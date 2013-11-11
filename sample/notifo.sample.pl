use strict;
use warnings;
use LWP::UserAgent;
use HTTP::Request;

my $config = do "../config.pl" or die;

my $req = HTTP::Request->new(POST => "https://api.notifo.com/v1/send_message");
$req->content("to=".$config->{notifo_username}."&msg=Got new Message!");
$req->authorization_basic(
    $config->{notifo_username},
    $config->{notifo_apisecret}
);
$req->content_type('application/x-www-form-urlencoded');
my $ua = LWP::UserAgent->new;
$ua->request($req);

__END__
=pod

=encoding utf-8

=head1 NAME

notifo.sample.pl - notifoの動作テスト用

=head1 SYNOPSIS

    $ carton install
    $ carton exec -- perl sample/notifo.sample.pl

=head1 DESCRIPTION

notifoを通してiPhoneに通知を送るサンプル

=head1 OPTIONS

config.plに書かれたユーザー名等を使います

=head1 AUTHOR

Fumihiro Ito E<lt>fmhrit@gmail.comE<gt>

=cut
