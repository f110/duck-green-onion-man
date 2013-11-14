package App::Onion::Options;
use strict;
use warnings;
use Mouse;

has port => (
    is => 'ro',
    isa => 'Int',
    default => 5000,
);
has host => (
    is => 'ro',
    isa => 'Str',
    default => '0',
);
has no_web => (
    is => 'ro',
    isa => 'Bool',
    default => 0,
);
has no_watcher => (
    is => 'ro',
    isa => 'Bool',
    default => 0,
);
has message_open => (
    is => 'ro',
    isa => 'Bool',
    default => 0,
);
has hosts => (
    is => 'ro',
    isa => 'HashRef',
    default => sub{+{}},
);
has interval => (
    is => 'ro',
    isa => 'Int',
    default => 15,
);
has notifies => (
    is => 'ro',
    isa => 'ArrayRef[App::Onion::Notify::Base]',
    traits => ['Array'],
    default => sub {[]},
    handles => {
        add_notifier => 'push',
    },
);
has notify => (
    is => 'ro',
    isa => 'Bool',
    default => 0,
);

1;
__END__
=pod

=encoding utf-8

=head1 NAME

App::Onion::Options -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
