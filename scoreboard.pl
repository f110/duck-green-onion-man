use strict;
use warnings;
use 5.010;
use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), "lib");
use Proclet;
use Plack::Buidler;
use Plack::Loader;
use Getopt::Long qw/:config posix_default no_ignore_case gnu_compat/;
use App::Onion::Scoreboard::Viewer;
use App::Onion::Scoreboard::Register;

my $viewer_port = 7000;
my $register_port = 10325;

GetOptions(
    "viewer-port" => \$viewer_port,
    "register-port" => \$register_port,
);

my $proclet = Proclet->new(color => 1);

# add viewer
$proclet->service(
    code => sub {
        my $app = builder {
            App::Onion::Scoreboard::Viewer->to_app;
        };
        my $loader = Plack::Loader->load(
            'Starlet',
            port => $viewer_port,
            host => 0,
            worker => 3,
        );
        $loader->run($app);
    },
    worker => 1,
    tag => "Viewer",
);

# add register
$proclet->service(
    code => sub {
        my $app = builder {
            App::Onion::Scoreboard::Register->to_app;
        };
        my $loader = Plack::Loader->load(
            'Starlet',
            port => $register_port,
            host => 0,
            worker => 3,
        );
        $loader->run($app);
    },
    worker => 1,
    tag => "Register",
);

$proclet->run;

__END__
=pod

=encoding utf-8

=head1 NAME

scoreboard.pl -

=head1 SYNOPSIS

    $ carton exec -- perl scoreboard.pl --viewer-port 8000 --register-port 10325

=cut
