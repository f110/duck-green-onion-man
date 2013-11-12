package App::Onion::Watcher;
use strict;
use warnings;
use AnyEvent;
use Carp;
use URI;

use App::Onion::MechanizeFactory;
use App::Onion::Watcher::Web;
use App::Onion::Watcher::Options;
use App::Onion::Watcher::DB::DBM;

sub app {
    my ($class, %arg) = @_;

    my $mech = App::Onion::MechanizeFactory->logged_in(
        $args{site},
        $args{email},
        $args{password}
    );
    my $uri = URI->new($args{site});

    return sub {
        my $cv = AnyEvent->condvar;
        my $watcher = App::Onion::Watcher::Web->new(
            mech => $mech,
            site => $uri,
            db => App::Onion::Watcher::DB::DBM->new,
            opt => App::Onion::Watcher::Options->new(
                notify => $args{notify},
                message_open => $args{message_open},
                notifies => [],
            ),
        );

        my $timer = AnyEvent->timer(
            interval => $interval,
            cb => sub {
                $watcher->timer_callback,
            },
        );
        warn $cv->recv;

        croak 'die timer';
    };
}

1;
__END__
=pod

=encoding utf-8

=head1 NAME

App::Onion::Watcher -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
