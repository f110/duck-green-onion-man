use strict;
use warnings;
use WWW::Mechanize;
use WWW::Mechanize::Plugin::FollowMetaRedirect;
use HTML::TreeBuilder::XPath;
use AnyEvent;
use List::Compare qw//;
use Encode;
use HTTP::Request;
use LWP::UserAgent;

use Data::Dumper;

my $debug = 1;
my $growl_notify = 0;
my $notify_to_phone = 0; # 0 or "kayac" or "notifo"
my $auto_url_open = 0;
my $auto_message_open = 0;
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

    # 新規メッセージがないなら終了
    return if scalar @Ronly == 0;

    push @message_ids, @Ronly;

    # notification
    if ($growl_notify) {
        system q#growlnotify -t '鴨ネギ男' -m 'Got new message!'#;
    }

    # push notification
    if ($notify_to_phone) {
        my $ua = LWP::UserAgent->new;
        if ($notify_to_phone eq "notifo") {
            my $req = HTTP::Request->new(POST => "https://api.notifo.com/v1/send_message");

            $req->content("to=".$config->{notifo_username}."&msg=Got new Message!");
            $req->authorization_basic(
                $config->{notifo_username},
                $config->{notifo_apisecret}
            );
            $req->content_type('application/x-www-form-urlencoded');
        } elsif ($notify_to_phone eq "kayac") {
            my $req = HTTP::Request->new(
                POST => "http://im.kayac.com/api/post/".$config->{im_kayac_username}
            );
            $req->content("message=Got new Message!");
            $req->content_type('application/x-www-form-urlencoded');
            my $ua = LWP::UserAgent->new;
        }
        $ua->request($req);
    }
    # end of notification section

    # for debug
    my $id = $new_message_ids[0];
    #foreach my $id (@Ronly) {
        my @urls;

        $res = $mech->get($url."view_message.pl?id=".$id."&box=inbox");
        if ($auto_message_open) {
            system qq#open -a $url/view_message.pl?id="$id"&box=inbox#;
        }

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

        if ($auto_url_open and scalar @urls > 0 and scalar @urls <= 5) {
            foreach (@urls) {
                system qq#open -a $_#;
            }
        }
    #}
}

__END__
=pod

=encoding utf-8

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

=item notify_to_phone

通知をスマートフォンに送ります．growl_notifyのフラグとは関係ありません．

対応サービスはim.kayac.comとnotifoです．

im.kayac.comを使う場合は以下のようにします．

    $notify_to_phone = "kayac";

notifoを使う場合は以下のようにします．

    $notify_to_phone = "notifo";

im.kayac.comはiPhoneのみ．notifoもstableではiPhoneのみですが，Androidアプリも存在し
Androidへ通知を送る事も出来ます．

いずれのサービスを使う場合でもそれぞれのサイトで登録をしAPIを使える状態にする必要があります．

http://im.kayac.com/

http://notifo.com/

=item auto_url_open

メッセージ内にURLが含まれていた場合は自動で開きます．

メッセージ内に5個以上URLが含まれていた場合は開きません．

system関数からopenコマンドを実行しています．
標準のブラウザとして指定されているもので開きます．（特にアプリケーションの指定なし）

=item auto_message_open

自動で新着メッセージを開きます．自動でメッセージ内のURLを開くのが怖い人はこちらがオススメ．

=back

=head1 AUTHOR

Fumihiro Ito <fmhrit@gmail.com>

=cut
