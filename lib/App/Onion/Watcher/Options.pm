package App::Onion::Watcher::Options;
use strict;
use warnings;
use Mouse;

has notify => (
    is => 'ro',
    isa => 'Bool',
);
has notifies => (
    is => 'rw',
    isa => 'ArrayRef[App::Onion::Notify::Base]',
    default => sub {[]},
);
has message_open => (
    is => 'ro',
    isa => 'Bool',
);
has no_web => (
    is => 'ro',
    isa => 'Bool',
);

1;
__END__
=pod

=encoding utf-8

=head1 NAME

App::Onion::Watcher::Options -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
