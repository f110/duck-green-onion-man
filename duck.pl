use strict;
use warnings;
use 5.010;
use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), 'lib');

use Encode;
use Getopt::Long qw/:config posix_default no_ignore_case gnu_compat/;
use Proclet;
use Plack::Loader;
use Plack::Builder;

use App::Onion::Parser;
use App::Onion::Web;
use App::Onion::Watcher;

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

# setup supervisor
my $proclet = Proclet->new(color => 1);

# add watcher to supervisor
unless ($no_watcher) {
    my $watcher = App::Onion::Watcher->app(
        site         => $url,
        email        => $conf->{login_mail},
        password     => $conf->{login_password},
        notify       => $notify_to_phone,
        message_open => $auto_message_open,
        no_web       => $no_web,
        interval     => $interval,
    );
    $proclet->service(
        code   => $watcher,
        worker => 1,
        tag    => "Watcher",
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
