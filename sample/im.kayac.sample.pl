use strict;
use warnings;
use LWP::UserAgent;
use HTTP::Request;

my $config = do "../config.pl" or die;

my $req = HTTP::Request->new(
    POST => "http://im.kayac.com/api/post/".$config->{im_kayac_username}
);
$req->content("message=Got new Message!");
$req->content_type('application/x-www-form-urlencoded');
my $ua = LWP::UserAgent->new;
$ua->request($req);

__END__
=pod

=encoding utf-8

=head1 NAME

im.kayac.sample.pl - im.kayac.comの動作テスト用

=head1 SYNOPSIS

    $ carton install
    $ carton exec -- perl sample/im.kayac.sample.pl

=head1 DESCRIPTION

im.kayac.comを通してiPhoneに通知を送るサンプル

=head1 OPTIONS

config.plに書かれているユーザー名等を使います

=head1 AUTHOR

Fumihiro Ito E<lt>fmhrit@gmail.comE<gt>

=cut
