package App::Onion::DB;
use strict;
use warnings;
use Mouse::Role;

requires 'create_message';
requires 'delete_message';
requires 'find_message';
requires 'update_message';
requires 'rows';
requires 'fetch_id_list';

1;
__END__
=pod

=encoding utf-8

=head1 NAME

App::Onion::DB -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
