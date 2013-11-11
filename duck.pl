use strict;
use warnings;
use 5.010;
use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), 'lib');
use WWW::Mechanize;
use WWW::Mechanize::Plugin::FollowMetaRedirect;
use HTML::TreeBuilder::XPath;
use AnyEvent;
use List::Compare qw//;
use Encode;
use HTTP::Request;
use LWP::UserAgent;
use Date::Calc qw//;
use Getopt::Long qw/:config posix_default no_ignore_case gnu_compat/;
use URI;
use Carp;
use Proclet;
use Plack::Loader;
use Plack::Builder;
use DBM::Deep;
use App::Onion::Parser;
use App::Onion::Web;

# for debug
use Data::Dumper;

my $url = q#http://mixi.jp/#;

my $debug;
my $growl_notify;
my $notify_to_phone; # 0 or "kayac" or "notifo"
my $auto_message_open;
my $interval = 15;
my $use_local_hosts;
my $config_file = "./config.pl";
my $port = 5000;
my $host = 0;
my $no_web;
my $no_watcher;

GetOptions(
    "d|debug" => \$debug,
    "g|growl" => \$growl_notify,
    "m|message_open" => \$auto_message_open,
    "i|interval=s" => \$interval,
    "p|port=s" => \$port,
    "host=s" => \$host,
    "notify=s" => \$notify_to_phone,
    "config=s" => \$config_file,
    "hosts" => \$use_local_hosts,
    "no-web" => \$no_web,
    "no-watcher" => \$no_watcher,
);

my $conf = do $config_file or die;

# open databse file
my $messages_detail = DBM::Deep->new(
    file => "message.db",
    type => DBM::Deep->TYPE_HASH,
    autoflush => 1,
);

my $message_ids = DBM::Deep->new(
    file => "message_list.db",
    type => DBM::Deep->TYPE_ARRAY,
    autoflush => 1,
);

my $uri_object = URI->new($url);

my $mech = WWW::Mechanize->new();
my ($res, $tree);

my $cv = AnyEvent->condvar;

# setup supervisor
my $proclet = Proclet->new(color => 1);

# add watcher to supervisor
unless ($no_watcher) {
    $res = _mechanize_get($mech, $uri_object, "list_message.pl");
    # login to web site
    $res = $mech->submit_form(
        form_number => 1,
        fields => {
            email => $conf->{login_mail},
            password => $conf->{login_password},
        }
    );
    $res = $mech->follow_meta_redirect;

    {
        my @new_message_ids = get_message_ids($res->decoded_content);
        my @Ronly = calc_new_message_ids($message_ids, \@new_message_ids);

        if (scalar @Ronly > 0) {
            store_new_messages(@Ronly);
        }
    }

    $proclet->service(
        code => sub {
            say "Start timer";
            my $timer = AnyEvent->timer(
                interval => $interval,
                cb => \&timer_callback,
            );

            warn $cv->recv;

            die;
        },
        worker => 1,
        tag => "Watcher",
    );
}

# add web front end to supervisor
unless ($no_web) {
    $proclet->service(
        code => sub {
            my $frontend_app = builder {
                enable "Plack::Middleware::Static",
                    path => qr{^/(css|js|img)/},
                    root => File::Spec->catdir(dirname(__FILE__), "static");
                App::Onion::Web->to_app($conf);
            };

            # start app server
            my $loader = Plack::Loader->load(
                'Starlet',
                port => $port,
                host => $host || 0,
                max_workers => 1,
            );
            say "Start Web Frontend";
            say "Accepting connections at http://$host:$port/";
            $loader->run($frontend_app);
        },
        worker => 1,
        tag => "Web Frontend",
    );
}

$proclet->run;

sub timer_callback {
    my $tree;
    my $res = _mechanize_get($mech, $uri_object, "list_message.pl");
    unless ($res) {
        $cv->send("Connection Lost!!");
        return;
    }
    my @new_message_ids = get_message_ids($res->decoded_content);

    my @Ronly = calc_new_message_ids(\@$message_ids, \@new_message_ids);

    # 新規メッセージがないなら終了
    return if scalar @Ronly == 0;
    # 以下新規メッセージがある場合の処理

    store_new_messages(@Ronly);

    # notification
    if ($growl_notify) {
        system q#growlnotify -t '鴨ネギ男' -m 'Got new message!'#;
    }

    # push notification
    send_notify() if $notify_to_phone;

    foreach my $id (@Ronly) {
        my ($hour, $min, $sec) = Date::Calc::Now();
        say "--------------------";
        say "New Message!";
        say $hour.":".$min.":".$sec;
        say "--------------------";

        $uri_object->path("view_message.pl");
        $uri_object->query_form({
            id => $id,
            box => "inbox",
        });

        {
            $res = _mechanize_get($mech, $uri_object);
            my $decoded_content = $res->decoded_content;
            my ($sender_name, $sender_id) = get_sender($decoded_content);
            my $message_send_date = get_send_date($decoded_content);
            my $message_title = get_title($decoded_content);
            my $message_body = get_body($decoded_content);
            if (defined $sender_name and defined $sender_id) {
                say "From: $sender_name";
                say "Sender ID: $sender_id";
                say "Title: $message_title";
                say "Body: $message_body";

                $messages_detail->{$id}->{sender} = $sender_id;
                $messages_detail->{$id}->{sender_name} = $sender_id;
                $messages_detail->{$id}->{send_date} = $message_send_date;
                $messages_detail->{$id}->{title} = $message_title;
                $messages_detail->{$id}->{body} = $message_body;
            } else {
                warn "something wrong. unable to get sender name and id";
            }
        }
        say "";
        say "====================";

        # notify to browser when after write message detail
        # because web server using it
        if ($auto_message_open) {
            my $view_message_url = $uri_object->as_string;
            say $view_message_url;
            $view_message_url = "http://localhost:$port/message?id=$id" unless $no_web;
            system qq#open "$view_message_url"#;
        }
    }
}

sub send_notify {
    my $ua = LWP::UserAgent->new;
    my $req;
    if ($notify_to_phone eq "notifo") {
        $req = HTTP::Request->new(POST => "https://api.notifo.com/v1/send_message");

        $req->content("to=".$conf->{notifo_username}."&msg=Got new Message!");
        $req->authorization_basic(
            $conf->{notifo_username},
            $conf->{notifo_apisecret}
        );
        $req->content_type('application/x-www-form-urlencoded');
    } elsif ($notify_to_phone eq "kayac") {
        $req = HTTP::Request->new(
            POST => "http://im.kayac.com/api/post/".$conf->{im_kayac_username}
        );
        $req->content("message=Got new Message!");
        $req->content_type('application/x-www-form-urlencoded');
    }
    $ua->request($req);
}

sub _mechanize_get {
    my ($mech, $uri, $path, $query) = @_;

    croak "_mechanize_get requires a URI object" if not $uri->isa("URI");

    $uri->path($path) if defined $path;
    $uri->query_form($query) if defined $query;
    if ($use_local_hosts) {
        $mech->add_header("Host", $uri->host);
        $uri->host($conf->{hosts}{$uri->host});
    }
    return $mech->get($uri->as_string);
}

sub calc_new_message_ids {
    my $message_ids = shift;
    my $new_message_ids = shift;

    if (ref $message_ids eq "DBM::Deep::Array") {
        $message_ids = dbm_array_to_array_ref($message_ids);
    }

    my $lc = List::Compare->new($message_ids, $new_message_ids);
    my @Ronly = $lc->get_Ronly;

    return wantarray ? @Ronly : \@Ronly;
}

sub dbm_array_to_array_ref {
    my $dbm_array = shift;

    my @normal_array = @$dbm_array;

    return \@normal_array;
}

sub store_new_messages {
    my @new_message_ids = @_;

    # add message list db
    push @$message_ids, @new_message_ids;

    # initialize entry in message detail db
    foreach my $message_id (@new_message_ids) {
        $messages_detail->{$message_id} = {
            sender => "",
            sender_name => "",
            send_date => "",
            title => "",
            body => "",
            mark => 0,
        };
    }
}

__END__
=pod

=encoding utf-8

=head1 NAME

duck.pl - 監視スクリプト

=head1 SYNOPSIS

    $ carton install
    $ carton exec -- perl duck.pl

おすすめ実行コマンド

    $ carton exec -- perl duck.pl --notify=notifo --message_open

=head1 DESCRIPTION

メッセージを監視して，新着メッセージがあったら通知したりする．

=head1 AUTHOR

Fumihiro Ito E<lt>fmhrit@gmail.comE<gt>

=cut
