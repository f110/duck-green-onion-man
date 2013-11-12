package App::Onion::Notify::ImKayac;
use strict;
use warnings;
use Mouse;

with 'App::Onion::Notify::Base';

no Mouse;

use Furl;
use HTTP::Request;

use constant {
    ENDPOINT => "http://im.kayac.com/api/post/",
};

sub new {
    my ($class, %args) = @_;

    return bless {
        ua => Furl->new,
        usename => $args{username},
    }, $class;
}

sub call {
    my ($self) = @_;

    my $req = HTTP::Request->new(
        POST => ENDPOINT.$self->{username}
    );
    $req->content("message=Got new Message!");
    $req->content_type('application/x-www-form-urlencoded');

    $self->{ua}->request($req);
}

1;
__END__
=pod

=encoding utf-8

=head1 NAME

App::Onion::Notify::ImKayac -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
