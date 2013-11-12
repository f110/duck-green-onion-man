package App::Onion::Notify::Notifo;
use strict;
use warnings;
use Furl;
use HTTP::Request;

use constant {
    ENDPOINT => 'https://api.notifo.com/v1/send_message'
};

sub new {
    my ($class, %args) = @_;

    return bless {
        ua => Furl->new,
        username => $args{username},
        apisecret => $args{apisecret},
    }, $class;
}

sub call {
    my ($self) = @_;

    my $req = HTTP::Request->new(POST => ENDPOINT);
    $req->content("to=".$self->{username}."&msg=Got new Message!");
    $req->authorization_basic(
        $self->{username},
        $self->{apisecret}
    );
    $req->content_type('application/x-www-form-urlencoded');

    $self->{ua}->request($req);
}

1;
__END__
=pod

=encoding utf-8

=head1 NAME

App::Onion::Notify::Notifo -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
