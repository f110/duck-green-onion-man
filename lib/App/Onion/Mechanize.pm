package App::Onion::Mechanize;
use strict;
use warnings;

use parent qw(WWW::Mechanize);

sub login {
    my ($self, $email, $password) = @_;

    return $self->submit_form(
        form_number => 1,
        fields => {
            email => $email,
            password => $password,
        }
    );
}

1;
__END__
=pod

=encoding utf-8

=head1 NAME

App::Onion::Mechanize -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
