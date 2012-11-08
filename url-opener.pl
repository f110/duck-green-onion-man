use strict;
use warnings;
use WWW::Mechanize;
use WWW::Mechanize::Plugin::FollowMetaRedirect;
use HTML::TreeBuilder::XPath;
use AnyEvent;
use List::Compare qw//;
use Encode;

use Data::Dumper;

my $debug = 1;
my $growl_notify = 0;
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

warn "start timer";
my $cv = AnyEvent->condvar;
timer_callback();
#my $timer = AnyEvent->timer(
    #interval => 60,
    #cb => \&timer_callback,
#);

$cv->recv;

exit;

sub timer_callback {
    my $res = $mech->get($url."list_message.pl");
    my $tree = HTML::TreeBuilder::XPath->new_from_content($res->decoded_content);

    my @new_messages = $tree->findvalues(q{//td[@class='subject']/a/@href});
    my @new_message_ids = map { $_ =~ m/id=([0-9a-f]{32})/; $1} @messages;

    my $lc = List::Compare->new(\@message_ids, \@new_message_ids);

    my @Ronly = $lc->get_Ronly;
    if ($growl_notify) {
        system q#growlnotify -t "鴨ネギ男" -m "Got new message!"#;
    }

    # for debug
    my $id = $new_message_ids[0];
    my @urls;
    #foreach my $id (@Ronly) {
        $res = $mech->get($url."view_message.pl?id=".$id."&box=inbox");
        $tree = HTML::TreeBuilder::XPath->new_from_content($res->decoded_content);

        my $message_body = $tree->findnodes(q{//div[@id='message_body']});
        foreach my $line ($message_body->pop->content_list) {
            unless ($line->isa("HTML::Element")) {
                if ($line =~ m#$url/[a-z_]+\.pl\?[a-z0-9_=]#) {
                    push @urls, $&;
                }
            }

            if ($debug) {
                if ($line->isa("HTML::Element")) {
                    if ($line->tag eq "br") {
                        print "\n";
                    }
                } else {
                    print encode_utf8($line);
                }
            }
        }
        $cv->send;
        my $sender = $tree->findnodes(q{//div[@class='messageDetailHead']/dl/dd});
        foreach my $line ($sender->pop->content_list) {
            if ($line->isa("HTML::Element")) {
                warn $line->tag;
            }
        }
    #}

    push @message_ids, @Ronly;
}

__END__
=pod

=head1 NAME

url-opener.pl

=head1 SYNOPSIS

    carton install
    carton exec -- perl url-opener.pl

=head1 MEMO

自宅でログイン試行しすぎたらBANされて解除されないorz

=head1 OPTIONS

引数は与えられません。
フラグがハードコーディングされているのでプログラムを自分で修正してください。

=over

=item growl_notify

新しいメッセージがあったらGrowl通知をします。

growlnotifyコマンドがパスが通ったディレクトリにインストールされている必要があります。

=back

=head1 AUTHOR

Fumihiro Ito <fmhrit@gmail.com>

=cut
