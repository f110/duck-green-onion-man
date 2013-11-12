package App::Onion::Watcher::Base;
use strict;
use warnings;
use Mouse::Role;

has notifies => (
    is => 'rw',
    isa => 'ArrayRef[App::Onion::Notify::Base]',
);
has messages => (
    is => 'ro',
    isa => 'App::Onion::Messages',
);
has datastore => (
    is => 'ro',
    isa => 'App::Onion::Watcher::DB',
);

requires 'timer_callback';

1;
__END__
=pod

=encoding utf-8

=head1 NAME

App::Onion::Watcher::Base -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
