use strict;
use warnings;
use LWP::UserAgent;
use HTTP::Request;

my $username = "rightoverture";
my $apisecret = 'x90b1530afee6701ca835b63b774df8bf168f8805';

my $req = HTTP::Request->new(POST => "https://api.notifo.com/v1/send_message");
$req->content("to=".$username."&msg=Got new Message!");
$req->authorization_basic(
    $username,
    $apisecret
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
    $ carton exec -- perl notifo.sample.pl

=head1 DESCRIPTION

notifoを通してiPhoneに通知を送るサンプル

=head1 AUTHOR

Fumihiro Ito E<lt>fmhrit@gmail.comE<gt>

=cut
