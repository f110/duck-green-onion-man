use strict;
use warnings;
use WWW::Mechanize;
use WWW::Mechanize::Plugin::FollowMetaRedirect;
use HTML::TreeBuilder::XPath;
use AnyEvent;
use List::Compare qw//;

use Data::Dumper;

my $config_file = "./config.pl";
my $conf = do $config_file or die;

my $url = q#http://mixi.jp/#;

my $mech = WWW::Mechanize->new();
my ($res, $tree);

$res = $mech->get($url."list_message.pl");
# login
$res = $mech->submit_form(
    form_number => 1,
    fields => {
        email => $conf->{login_mail},
        password => $conf->{login_password},
    }
);
$res = $mech->follow_meta_redirect;

$tree = HTML::TreeBuilder::XPath->new_from_content($res->decoded_content);

my @messages = $tree->findvalues(q{//td[@class='subject']/a/@href});
my @message_ids = map { $_ =~ m/id=([0-9a-f]{32})/; $1} @messages;

my $cv = AnyEvent->condvar;
my $timer = AnyEvent->timer(
    interval => 60,
    cb => sub {
        my $res = $mech->get($url."list_message.pl");
        my $tree = HTML::TreeBuilder::XPath->new_from_content($res->decoded_content);

        my @new_messages = $tree->findvalues(q{//td[@class='subject']/a/@href});
        my @new_message_ids = map { $_ =~ m/id=([0-9a-f]{32})/; $1} @messages;

        my $lc = List::Compare->new(\@message_ids, \@new_message_ids);

        my @Ronly = $lc->get_Ronly;

        foreach my $id (@Ronly) {
            $res = $mech->get($url."view_message.pl?id=".$id."&box=inbox");
            $tree = HTML::TreeBuilder::XPath->new_from_content($res->decoded_content);

            warn $tree->findnodes(q{//div[@id='message_body']});
            warn $tree->findnodes(q{//div[@class='messageDetailHead']/dl/dd});
        }
    },
);

$cv->recv;

exit;

__END__
=pod

=head1 NAME

url-opener.pl

=head1 SYNOPSIS

    carton install
    carton exec -- perl url-opener.pl

=head1 MEMO

自宅でログイン試行しすぎたらBANされて解除されないorz

=head1 AUTHOR

Fumihiro Ito <fmhrit@gmail.com>

=cut
