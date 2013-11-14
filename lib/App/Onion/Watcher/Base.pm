package App::Onion::Watcher::Base;
use strict;
use warnings;
use Mouse::Role;

has db => (
    is => 'ro',
    does => 'App::Onion::DB',
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
