use strict;
use warnings;
use 5.010;
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

use Data::Dumper;

my $url = q#http://mixi.jp/#;

my $debug;
my $growl_notify;
my $notify_to_phone; # 0 or "kayac" or "notifo"
my $auto_url_open; # Denger!!
my $auto_message_open;
my $interval = 15;
my $use_local_hosts;
my $config_file = "./config.pl";

GetOptions(
    debug => \$debug,
    growl => \$growl_notify,
    "notify=s" => \$notify_to_phone,
    message_open => \$auto_message_open,
    "interval=s" => \$interval,
    "config=s" => \$config_file,
    hosts => \$use_local_hosts,
);

my $conf = do $config_file or die;

my $uri_object = URI->new($url);

my $mech = WWW::Mechanize->new();
my ($res, $tree);

$res = _mechanize_get($mech, $uri_object, "list_message.pl");
# login
$res = $mech->submit_form(
    form_number => 1,
    fields => {
        email => $conf->{login_mail},
        password => $conf->{login_password},
    }
);
$res = $mech->follow_meta_redirect;

$tree = HTML::TreeBuilder::XPath->new_from_content($res->decoded_content);

my @messages = $tree->findvalues(q{//td[@class='subject']/a/@href});
my @message_ids = map { $_ =~ m/id=([0-9a-f]{32})/; $1} @messages;

my $cv = AnyEvent->condvar;

# add watcher to supervisor
my $proclet = Proclet->new(color => 1);

$proclet->service(
    code => sub {
        warn "start timer";
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

$proclet->run;

sub timer_callback {
    my $res = _mechanize_get($mech, $uri_object, "list_message.pl");
    unless ($res) {
        $cv->send("Connection Lost!!");
        return;
    }
    my $tree = HTML::TreeBuilder::XPath->new_from_content($res->decoded_content);

    my @new_messages = $tree->findvalues(q{//td[@class='subject']/a/@href});
    my @new_message_ids = map { $_ =~ m/id=([0-9a-f]{32})/; $1} @new_messages;

    my $lc = List::Compare->new(\@message_ids, \@new_message_ids);

    my @Ronly = $lc->get_Ronly;

    # 新規メッセージがないなら終了
    return if scalar @Ronly == 0;

    push @message_ids, @Ronly;

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
        my @urls;

        $uri_object->path("view_message.pl");
        $uri_object->query_form({
            id => $id,
            box => "inbox",
        });
        my $view_message_url = $uri_object->as_string;
        say $view_message_url;
        if ($auto_message_open) {
            system qq#open "$view_message_url"#;
        }
        $res = _mechanize_get($mech, $uri_object);

        $tree = HTML::TreeBuilder::XPath->new_from_content($res->decoded_content);

        # メッセージ本文の取得
        if ($auto_url_open) {
            my $message_body = $tree->findnodes(q{//div[@id='message_body']});
            foreach my $line ($message_body->pop->content_list) {
                next unless defined $line;
                if ($line->isa("HTML::Element") and $line->tag("a")) {
                    if ($line->attr("href") =~ m#$url#) {
                        push @urls, $line->attr("href");
                    }
                }

                if ($debug) {
                    if ($line->isa("HTML::Element")) {
                        if ($line->tag eq "br") {
                            print "\n";
                        }
                    } else {
                        print encode_utf8($line);
                    }
                }
            }
            my $sender = $tree->findnodes(q{//div[@class='messageDetailHead']/dl/dd});
            foreach my $line ($sender->pop->content_list) {
                if ($debug and $line->isa("HTML::Element")) {
                    warn $line->tag;
                }
            }

            # URLが5個以内だった場合は開く
            if (scalar @urls > 0 and scalar @urls <= 5) {
                foreach (@urls) {
                    say $_;
                    system qq#open "$_"#;
                }
            }
        }

        say "";
        say "====================";
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

__END__
=pod

=encoding utf-8

=head1 NAME

url-opener.pl - 監視スクリプト

=head1 SYNOPSIS

    $ carton install
    $ carton exec -- perl url-opener.pl

おすすめ実行コマンド

    $ carton exec -- perl url-opener.pl --notify=notifo --message_open

=head1 DESCRIPTION

メッセージを監視して，新着メッセージがあったら通知したりする．

=head1 MEMO

自宅でログイン試行しすぎたらBANされて解除されないorz

=head1 OPTIONS

=over

=item growl

新しいメッセージがあったらGrowl通知をします。

growlnotifyコマンドがパスが通ったディレクトリにインストールされている必要があります。

=item notify

通知をスマートフォンに送ります．growlフラグとは関係ありません．

対応サービスはim.kayac.comとnotifoです．

im.kayac.comを使う場合は以下のようにします．

    $ carton exec -- perl url-opener.pl --notify "kayac"

notifoを使う場合は以下のようにします．

    $ carton exec -- perl url-opener.pl --notify "notifo"

im.kayac.comはiPhoneのみ．notifoもstableではiPhoneのみですが，Androidアプリも存在し
Androidへ通知を送る事も出来ます．

いずれのサービスを使う場合でもそれぞれのサイトで登録をしAPIを使える状態にする必要があります．

http://im.kayac.com/

http://notifo.com/

im.kayac.comの場合は登録したユーザー名をconfigファイルへ記述，
notifoの場合はユーザー名とAPI Secretをconfigファイルへ書く必要があります．

im.kayac.comは同時に複数のデバイスでSubscribeした場合は，後にログインした方のみに通知が飛びます．
notifoは複数のデバイスでSubscribeした場合でもそれぞれのデバイスへ通知が飛びます．

=item message_open

自動で新着メッセージを開きます．自動でメッセージ内のURLを開くのが怖い人はこちらがオススメ．

=item host

configファイル内に書かれたドメインとIPの対応を使用します．
管理者権限がなく，hostsファイルが書き換えられない場合でもアクセスする事が出来るようになります．

=item auto_url_open

B<非常に危険なオプションなのでプログラム内にハードコーディングされています>

メッセージ内にURLが含まれていた場合は自動で開きます．

メッセージ内に5個以上URLが含まれていた場合は開きません．

system関数からopenコマンドを実行しています．
標準のブラウザとして指定されているもので開きます．（特にアプリケーションの指定なし）

=back

=head1 GOAL

phantomjsと組み合わせ，自動採点

=head1 AUTHOR

Fumihiro Ito E<lt>fmhrit@gmail.comE<gt>

=cut
