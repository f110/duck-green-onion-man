package App::Onion::Messages;
use strict;
use warnings;
use Mouse;

has list => (
    is => 'ro',
    isa => 'ArrayRef[App::Onion::Message]',
);

no Mouse;

sub length {
    my ($self) = @_;
    return scalar @{$self->list};
}

1;
__END__
=pod

=encoding utf-8

=head1 NAME

App::Onion::Messages -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
