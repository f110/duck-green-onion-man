use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok "App::Onion::Parser", qw/get_send_date/;
}

my $html = do { local $/; <DATA> };
my $expected_message_send_date = "2012年12月10日 22時32分";

subtest "get_send_date" => sub {
    my $message_send_date = get_send_date($html);
    is $message_send_date, $expected_message_send_date;
};

subtest "get_send_date but couldn't get html" => sub {
    my $message_send_date = get_send_date("");
    is $message_send_date, undef;
};

subtest "get_send_date but get an other dom tree something like error page" => sub {
    my $message_send_date = get_send_date("<html><body>error</body></html>");
    is $message_send_date, undef;
};

done_testing;
__DATA__


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" class="osMacOSX browserChrome browserChrome23 serviceMessage pageViewMessageJpMixi domainJpMixi">
<head>
<title>[mixi] メッセージの詳細</title>

<!-- header meta values -->
<meta http-equiv="Content-Type" content="text/html; charset=euc-jp"  />
<meta name="application-name" content="mixi"  />
<meta name="msapplication-starturl" content="/home.pl?from=pin"  />
<meta name="msapplication-navbutton-color" content="#E0C074"  />
<meta name="msapplication-window" content="width=100%;height=100%"  />
<meta name="msapplication-tooltip" content="友人とコミュニケーションを楽しもう！"  />
<meta name="robots" content="nofollow,noindex"  />
<meta name="robots" content="noodp"  />
<meta name="Slurp" content="NOYDIR"  />
<meta name="description" lang="ja" content="mixi(ミクシィ)は、日記、写真共有、ゲームや便利ツール満載のアプリなど、さまざまなサービスで友人・知人とのコミュニケーションをさらに便利に楽しくする、日本最大規模のソーシャル・ネットワーキングサービスです。"  />

<!-- / header meta values -->

<!-- header css and links -->
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/common.production.css?1355897605" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/img/pc_skin/b9ecbcd14c549f0beab7fbbff4bc709f383ef934/mixicollection.css" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/skin/header_blue.css?1354687343" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/skin/footer_blue.css?1347507784" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/skin/sidebar_blue.css?1355292261" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/skin/component_blue.css?1348639262" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/skin/message_blue.css?1347507784" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/message.css?1347507784" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/macfix.css?1353304936" /><link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/page/decolink.css?1352873000" />
<link href="http://img.mixi.net/img/basic/favicon.ico"  type="image/vnd.microsoft.icon"  rel="icon"         /><link href="http://img.mixi.net/img/basic/favicon.ico"  type="image/vnd.microsoft.icon"  rel="shortcut icon"         /><link href="http://img.mixi.net/img/smartphone/touch/favicon/x001_prec.png"    rel="apple-touch-icon-precomposed"         />
<!-- / header css and links -->
</head>




<body>


<div id="page">

<!--[HeaderArea]-->
<div id="headerArea">
<div class="headerLogo"><h1><a id="pagetop" href="http://mixi.jp/home.pl?from=h_logo"><img src="http://img.mixi.net/img/basic/common/mixi_logo_large001.gif" alt="mixi" width="72" height="30" /></a></h1></div>

<div class="adBanner"><div class="adMain widget"
    data-widget-namespace="jp.mixi.ad.expander"
    data-server="http://n2.ads.mreco0.jp"
    data-api-prefix="http://api.ads.mixi.jp/"
    data-tag="/SITE=VIEWMESSAGE/AREA=NEWTARGETING.BANNER/AAMSZ=468X60/AGE=1/AGETYPE=1/PARA=76/APPCNT=0/APPUNREG=.33371.27882.29064.23246.34581.31253.36426.37390.38140.6598./S0=11967/S1=10474/S2=10127/S3=11772/S4=10417/S5=10319/S6=10906/S7=11948/BTA=.6.5.145.76./BTACCTID1=79/BTACCTID2=2/BTACCTID3=14/BTACCTID4=201/FBDT=1/GENDER=S1/H4=1/OCC=16/PREF=13/PRUNREG=0/PREM=1/MPTRG=0"
    data-width="468"
    data-height="60"
    data-enable-seg="0"
    data-grant-rand="1"
    data-pid="2"
    data-iframe-id=""
    data-xuid=""
    data-observe-channels="comeback.focus"
    style="margin-left:auto; margin-right:auto; width:468px; height:60px;"
>
</div>
</div>


<div class="utilityNavigation">
<ul class="serviceSubNavigation">
<li><a href="http://mixi.jp/mobile_access.pl" title="スマホ・携帯">スマホ・携帯</a></li>
<li><a href="http://mixi.jp/help.pl" title="ヘルプ">ヘルプ</a></li>
<li><a href="http://mixi.jp/logout.pl" title="ログアウト">ログアウト</a></li>
</ul>
<ul class="serviceNavigation">

<li><a href="http://mixi.jp/redirector.pl?id=6845" title="mixi Xmas 2012" style="background:url(http://img.mixi.net/img/basic/icon/xmas001.gif) no-repeat 0 0; padding:2px 0 2px 20px;">mixi Xmas 2012</a></li>


<li><a href="http://mixi.jp/redirector.pl?id=7055" title="ミクシィ年賀状" style="background:url(http://img.mixi.net/img/basic/icon/nenga001.gif) no-repeat 0 0; padding:1px 0 2px 18px;">ミクシィ年賀状</a></li>

</ul>
<!--/utilityNavigation--></div>

<!-- search widget -->
<div class="globalNavigation pGmInputArea01 widget" data-widget-namespace="jp.mixi.featuredcontents.pc.widget.searchform" data-form-select=".JS_searchSelect" data-form-category=".JS_searchCategory" data-form-text-field=".JS_searchTextField" data-form-submit=".JS_searchSubmitButton" role="search">
<p class="home"><a href="http://mixi.jp/home.pl?from=global" title="ホーム">ホーム</a></p>
<ul class="globalNavigationList">
<li class="search"><a href="http://mixi.jp/search.pl" title="友人を探す">友人を探す</a></li>
<li class="invite"><a href="https://mixi.jp/invite.pl" title="友人を招待">友人を招待</a></li>
<li class="appli"><a href="http://mixi.jp/search_appli.pl" title="アプリ">アプリ</a></li>
<li class="page"><a href="http://page.mixi.jp/page_portal.pl" title="ページ">ページ</a></li>
<li class="community"><a href="http://mixi.jp/search_community.pl?from=global" title="コミュニティ">コミュニティ</a></li>
<li class="game"><a href="http://mixi.jp/redirector.pl?id=4950" title="ゲーム">ゲーム</a></li>
<li class="mall"><a href="http://mmall.jp/mx/?aff_id=mixa0001" title="モール">モール</a></li>

<li class="searchBox">
<div class="headerSearchCategory"  >
<p class="category"><a href="#" class="JS_searchSelect" onclick="return false">
<span value="search_comm" data-placeholder="コミュニティ検索">コミュ</span>
</a></p>
</div>

<input type="text" class="headerSearchInput01 defaultText JS_searchTextField" name="searchText" value="" data-placeholder="" data-placeholder-class="lPlaceholder" size="10" />
<input class="headerSearchButton JS_searchSubmitButton" type="image" title="検索" alt="検索" src="http://img.mixi.net/img/basic/button/search_button004.gif" />
<ul class="categorySelector JS_searchCategory" style="display:none;"><li value="search_comm" data-placeholder="コミュ" data-placeholder-text="コミュニティ検索"><a href="#" onclick="return false">コミュニティ検索</a></li><li value="search_game" data-placeholder="ゲーム" data-placeholder-text="ゲーム検索"><a href="#" onclick="return false">ゲーム検索</a></li><li value="search_appli" data-placeholder="アプリ" data-placeholder-text="アプリ検索"><a href="#" onclick="return false">アプリ検索</a></li><li value="search_page" data-placeholder="ページ" data-placeholder-text="ページ検索"><a href="#" onclick="return false">ページ検索</a></li><li value="search_profile" data-placeholder="プロフ" data-placeholder-text="プロフィール検索"><a href="#" onclick="return false">プロフィール検索</a></li><li value="search_school" data-placeholder="学校" data-placeholder-text="学校名を入力"><a href="#" onclick="return false">学校から友人を探す</a></li><li value="search_mykeyword" data-placeholder="キーワード" data-placeholder-text="mixiキーワードを入力"><a href="#" onclick="return false">mixiキーワード検索</a></li><li value="search_news" data-placeholder="ニュース" data-placeholder-text="ニュース検索"><a href="#" onclick="return false">ニュース検索</a></li><li value="search_item" data-placeholder="レビュー" data-placeholder-text="レビュー検索"><a href="#" onclick="return false">レビュー検索</a></li><li value="search_mall" data-placeholder="モール" data-placeholder-text="モール検索"><a href="#" onclick="return false">モール検索</a></li><li value="search_diary" data-placeholder="日記" data-placeholder-text="日記検索"><a href="#" onclick="return false">日記検索</a></li></ul>

<div class="categorySelector" style="display:none;">
<form class="JS_formCommunitySearch" action="http://mixi.jp/search_community.pl" method="get" Accept-Charset="EUC-JP">
<input type="hidden" name="keyword" value="" />
<input type="hidden" name="search_mode" value="title" />
<input type="hidden" name="category_id" value="0" />
<input type="hidden" name="type" value="com" />
<input type="hidden" name="mode" value="main" />
<input type="hidden" name="launch" value="v2" />
<input type="submit" value="search" />
</form>

<form class="JS_formGameSearch" action="http://mixi.jp/search_appli_result.pl" method="get" Accept-Charset="EUC-JP">
<input type="hidden" name="keyword" value="" />
<input type="hidden" name="is_game" value="1" />
<input type="hidden" name="launch" value="v2" />
<input type="submit" value="search" />
</form>

<form class="JS_formAppliSearch" action="http://mixi.jp/search_appli_result.pl" method="get" Accept-Charset="EUC-JP">
<input type="hidden" name="keyword" value="" />
<input type="hidden" name="is_game" value="0" />
<input type="hidden" name="launch" value="v2" />
<input type="submit" value="search" />
</form>

<form class="JS_formPageSearch" action="http://page.mixi.jp/search_page.pl" method="get" accept-charset="UTF-8">
<input type="hidden" name="keyword" value="" />
<input type="hidden" name="title_only" value="1" />
<input type="hidden" name="category_id" value="0" />
<input type="hidden" name="mode" value="result" />
<input type="hidden" name="launch" value="v2" />
<input type="submit" value="search" />
</form>

<form class="JS_formProfileSearch" action="http://mixi.jp/search_profile.pl" method="get" Accept-Charset="EUC-JP">
<input type="hidden" name="keyword" value="" />
<input type="hidden" name="from_age" value="" />
<input type="hidden" name="to_age" value="" />
<input type="hidden" name="hometown" value="0" />
<input type="hidden" name="hometown_area" value="0" />
<input type="hidden" name="location" value="0" />
<input type="hidden" name="location_area" value="0" />
<input type="hidden" name="order_change" value="" />
<input type="hidden" name="search_all" value="full" />
<input type="hidden" name="sex" value="" />
<input type="hidden" name="submit_hidden" value="result" />
<input type="hidden" name="launch" value="v2" />
<input type="submit" value="search" />
</form>

<form class="JS_formSchoolSearch" action="https://mixi.jp/search_school.pl" method="get" Accept-Charset="EUC-JP">
<input type="hidden" name="keyword" value="" />
<input type="hidden" name="mode" value="search" />
<input type="hidden" name="school_type_id" value="0" />
<input type="hidden" name="launch" value="v2" />
<input type="submit" value="search" />
</form>

<form class="JS_formMyKeywordSearch" action="http://mixi.jp/search_mykeyword.pl" method="post" Accept-Charset="EUC-JP">
<input type="hidden" name="mykeyword" value="" />
<input type="hidden" name="mode" value="search" />
<input type="hidden" name="launch" value="v2" />
<input type="submit" value="search" />
</form>

<form class="JS_formNewsSearch" action="http://news.mixi.jp/search_news.pl" method="get" Accept-Charset="EUC-JP">
<input type="hidden" name="keyword" value="" />
<input type="hidden" name="category_id" value="0" />
<input type="hidden" name="launch" value="v2" />
<input type="submit" value="search" />
</form>

<form class="JS_formItemSearch" action="http://mixi.jp/search_item.pl" method="get" Accept-Charset="EUC-JP">
<input type="hidden" name="keyword" value="" />
<input type="hidden" name="category_id" value="0" />
<input type="hidden" name="comm_id" value="" />
<input type="hidden" name="submit_main" value="1" />
<input type="hidden" name="launch" value="v2" />
<input type="submit" value="search" />
</form>

<form class="JS_formMallSearch" action="http://mmall.jp/mx/bep/m/klist3" method="get" Accept-charset="Shift-JIS">
<input type="hidden" name="keyword" value="" />
<input type="hidden" name="aff_id" value="ixs0002" />
<input type="submit" value="search" />
</form>

<form class="JS_formDiarySearch" action="http://mixi.jp/search_diary.pl" method="get" Accept-Charset="EUC-JP">
<input type="submit" value="search" />
<input type="hidden" name="keyword" value="" />
<input type="hidden" name="type" value="dia" />
<input type="hidden" name="launch" value="v2" />
</form>

</div>
</li>

</ul>



<!-- /search widget --></div>

<script type="text/javascript">//<![CDATA[
// Disable iframe encapsulation
if (window != top) top.location.href = location.href;
//]]></script>




<div class="personalNavigation"><ul
    role="navigation"
    class="personalNaviHome widget"
    data-widget-namespace="jp.mixi.common.navigationbar"
    data-menus="contents"><li class="profile"><a
        href="http://mixi.jp/show_profile.pl?id=2&from=navi"
        title="プロフィール">プロフィール</a></li><li class="myMixi"><a
        href="http://mixi.jp/list_friend.pl"
        title="友人リスト">友人リスト</a></li><li class="voice"><a
        href="http://mixi.jp/list_voice.pl"
        title="つぶやき">つぶやき</a></li><li class="check"><a
        href="http://mixi.jp/list_check.pl"
        title="チェック">チェック</a></li><li class="diary"><a
        href="http://mixi.jp/list_diary.pl?from=navi"
        title="日記">日記</a></li><li class="photo"><a
        href="http://photo.mixi.jp/home.pl"
        title="フォト">フォト</a></li><li id="contentsPulldown" class="contents" aria-live="assertive"><a
        href="http://mixi.jp/js_notice.pl"
        title="コンテンツ">コンテンツ</a><div id="contentsSubMenu" style="display:none"><ul class="pulldown"><li><a href="http://mixi.jp/list_mymall_item.pl?from=navi">アイテム</a></li><li><a href="http://video.mixi.jp/list_video.pl?from=navi">動画</a></li><li><a href="http://mixi.jp/list_review.pl?from=navi">レビュー</a></li></ul></div></li><li class="message"><a
        href="http://mixi.jp/list_message.pl"
        title="メッセージ"
        class="current">メッセージ</a></li><li class="schedule"><a
        href="http://mixi.jp/show_schedule.pl"
        title="カレンダー">カレンダー</a></li><li class="account"><a
        href="http://mixi.jp/edit_account.pl"
        title="設定変更">設定変更</a></li></ul><!--/personalNavigation01--></div>

<!--/headerArea--></div>
<!--/[HeaderArea]-->






<!--[BodyArea]-->
<div id="bodyArea" class="message">

<!--[BodyMainArea]-->
<div id="bodyMainArea">

<div class="pageTitle homeTitle005"><h2>Whoの受信箱</h2></div>

<!--[ContentsArea]-->
<div id="contentsArea" class="clearfix">

<!--[subArea]-->
<div id="subArea">

<div id="compose" class="sideBlock">
<p><a href="send_message.pl?ref=list_message"><img src="http://img.mixi.net/img/basic/button/send_message002.gif" alt="メッセージ作成" /></a></p>
</div>

<div id="subMenu" class="sideBlock">
<ul>
<li class="on" id="subMenuTop"><a class="inbox" href="list_message.pl?box=inbox">受信箱</a></li>
<li class=""><a class="mixiInbox" href="list_message.pl?box=noticebox">mixiからのお知らせ</a></li>
<li class=""><a class="sent" href="list_message.pl?box=outbox">送信済み</a></li>
<li class=""><a class="draft" href="list_message.pl?box=savebox">下書き保存箱</a></li>
<li class="" id="subMenuBottom"><a class="trash" href="list_message.pl?box=thrash">ごみ箱</a></li>
</ul>
</div>

<div id="function" class="sideBlock">
<p><a href="http://mixi.jp/edit_account_notice_mail.pl">受信通知の設定</a></p>
</div>

<!--/subArea--></div>

<!--/[subArea]-->

<!--[MainArea]-->
<div id="mainArea">

<div class="extraWrap01">

<div class="extraInner">

<div class="heading">
<p><a href="list_message.pl?box=inbox&page=1">&lt;&lt;&nbsp;受信箱へ戻る</a></p>
</div>

<div class="contents">

<div id="messageDetail">

<div class="thumb"><a href="show_friend.pl?id=2"><img src="http://profile.img.mixi.jp/photo/member/1234567890.jpg" alt="doctor who" /></a></div>

<div class="messageDetailHead">
<h3>☆mixi Xmasへの招待☆</h3>
<dl>
<dt>日付</dt>
<dd>2012年12月10日 22時32分</dd>
<dt>差出人</dt>
<dd><a href="show_friend.pl?id=1">doctor who</a><span><form action="reply_message.pl?reply_message_id=1234567891&id=1" method="post"><input type="submit" class="formBt01" value="返信する" /></form></span></dd>
</dl>
</div>

<div id="message_body" class="messageDetailBody FANCYURL_EMBED">今年もmixi Xmasの季節がきたよ！一緒に幸運のベルを鳴らして、クリスマスまでのカウントダウンを楽しもう！プレゼントや、無料のクーポン券がもらえるよ♪<br /><br />☆mixi Xmas 2012☆<br /><a href="http://mixixmas.mplace.jp/?from=miv">http://<wbr/>mixixma<wbr/>s.mplac<wbr/>e.jp/?f<wbr/>rom=miv</a></div>

<div class="formButtons01">
<ul>
<li><form action="reply_message.pl?reply_message_id=1234567890&id=1" method="post"><input type="submit" class="formBt01" value="返信する" /></form></li>
<li><form action="delete_message.pl?message_id=1234567890&box=inbox" method="post"><input class="formBt02" type=submit value="削除する" /></form></li>
</ul>
</div>

<!--/messageDetail--></div>

<div class="notes01">
<p><img src="http://img.mixi.net/img/basic/icon/school001.gif" alt="同級生" />
<img src="http://img.mixi.net/img/basic/icon/company001.gif" alt="同僚" />
…同級生・同僚のメッセージに表示されます。詳しくは<a href="help.pl?mode=item&item=632">こちら</a>をご覧ください。</p></div>

<p class="moreLink01"><a href="spam_message.pl?message_id=1234567890&box=inbox">スパムメッセージをmixi運営事務局に報告する</a><br /><a href="add_access_block.pl?mode=confirm&target_id=1&via=view_message&message_id=1234567890&page=1">送信者をアクセスブロックする</a></p>

<!--/contents--></div>

<!--/extraInner--></div>

<!--/extraWrap01--></div>

<p style="padding-right: 10px;" class="moreLink01"><a href="http://mixi.jp/edit_message_setting.pl">受信範囲の設定</a></p>

<!--/mainArea--></div>
<!--/[MainArea]-->

<!--/contentsArea--></div>
<!--/[ContentsArea]-->

<!--/bodyMainArea--></div>
<!--/[BodyMainArea]-->

<!--[bodySub]-->


<!--[bodySub]-->
<div id="bodySub">


<!--[AdBanner]-->
<div id="adBanner">


    <div class="adMain widget"
    data-widget-namespace="jp.mixi.ad.expander.change_iframe_size"
    data-server="http://n2.ads.mreco0.jp"
    data-api-prefix="http://api.ads.mixi.jp/"
    data-tag="/SITE=VIEWMESSAGE/AREA=GENERALBRANDING/AGE=1/AGETYPE=1/PARA=76/APPCNT=0/APPUNREG=.33371.27882.29064.23246.34581.31253.36426.37390.38140.6598./S0=11967/S1=10474/S2=10127/S3=11772/S4=10417/S5=10319/S6=10906/S7=11948/BTA=.6.5.145.76./BTACCTID1=79/BTACCTID2=2/BTACCTID3=14/BTACCTID4=201/FBDT=1/GENDER=S1/H4=1/OCC=16/PREF=13/PRUNREG=0/PREM=1/MPTRG=0"
    data-width="224"
    data-height="224"
    data-enable-seg="0"
    data-grant-rand="1"
    data-pid="2"
    data-xuid=""
    data-observe-channels="comeback.focus"
>

</div>



<!--/#AdBanner--></div>
<!--/[AdBanner]-->
<!-- use_ssl -->














 



















<div id="prContentsArea" class="bodySubSection">
<div class="heading01"><h2>おすすめ情報</h2></div>
<div class="prContents">

<div class="precedingMegaContents">
<div class="adMain widget"
    data-widget-namespace="jp.mixi.ad.expander"
    data-server="http://n2.ads.mreco0.jp"
    data-api-prefix="http://api.ads.mixi.jp/"
    data-tag="/SITE=VIEWMESSAGE/AREA=MEGA.TEXT/AAMSZ=MTEXT/AGE=1/AGETYPE=1/PARA=76/APPCNT=0/APPUNREG=.33371.27882.29064.23246.34581.31253.36426.37390.38140.6598./S0=11967/S1=10474/S2=10127/S3=11772/S4=10417/S5=10319/S6=10906/S7=11948/BTA=.6.5.145.76./BTACCTID1=79/BTACCTID2=2/BTACCTID3=14/BTACCTID4=201/FBDT=1/GENDER=S1/H4=1/OCC=16/PREF=13/PRUNREG=0/PREM=1/MPTRG=0"
    data-width="216"
    data-height="72"
    data-enable-seg="0"
    data-grant-rand="1"
    data-pid="1"
    data-iframe-id=""
    data-xuid=""
    data-observe-channels="comeback.focus"
    style="margin-left:auto; margin-right:auto; width:216px; height:72px;"
>
</div>

</div>


<div class="succeedingMegaContents">
<div class="adMain widget"
    data-widget-namespace="jp.mixi.ad.expander"
    data-server="http://n2.ads.mreco0.jp"
    data-api-prefix="http://api.ads.mixi.jp/"
    data-tag="/SITE=VIEWMESSAGE/AREA=MEGA.TEXT/AAMSZ=MTEXT/AGE=1/AGETYPE=1/PARA=76/APPCNT=0/APPUNREG=.33371.27882.29064.23246.34581.31253.36426.37390.38140.6598./S0=11967/S1=10474/S2=10127/S3=11772/S4=10417/S5=10319/S6=10906/S7=11948/BTA=.6.5.145.76./BTACCTID1=79/BTACCTID2=2/BTACCTID3=14/BTACCTID4=201/FBDT=1/GENDER=S1/H4=1/OCC=16/PREF=13/PRUNREG=0/PREM=1/MPTRG=0"
    data-width="216"
    data-height="72"
    data-enable-seg="0"
    data-grant-rand="1"
    data-pid="1"
    data-iframe-id=""
    data-xuid=""
    data-observe-channels="comeback.focus"
    style="margin-left:auto; margin-right:auto; width:216px; height:72px;"
>
</div>

</div>

</div>
</div>










<!--/[help]-->



<!--[help]-->
<div class="bodySubSection" id="help">
<div class="heading01">
<h2>困ったときには</h2>
</div>
<div class="contents">
<ul class="helpList04">
<li><a href="http://mixi.jp/help.pl">ヘルプトップ</a></li>
<li><a href="http://mixi.jp/help.pl?mode=list&category=3">利用上の注意</a></li>
<li><a id="JS_supportReportLink"  href="spam_message.pl?message_id=1234567890&box=inbox">規約違反の通報</a></li>


</ul>
</div>
<!--/help--></div>
<!--/[help]-->


<div id="adBanner02">
<div class="adMain widget"
    data-widget-namespace="jp.mixi.ad.expander"
    data-server="http://n2.ads.mreco0.jp"
    data-api-prefix="http://api.ads.mixi.jp/"
    data-tag="/SITE=VIEWMESSAGE/AREA=SQUARE.BANNER/AAMSZ=224X224/AGE=1/AGETYPE=1/PARA=76/APPCNT=0/APPUNREG=.33371.27882.29064.23246.34581.31253.36426.37390.38140.6598./S0=11967/S1=10474/S2=10127/S3=11772/S4=10417/S5=10319/S6=10906/S7=11948/BTA=.6.5.145.76./BTACCTID1=79/BTACCTID2=2/BTACCTID3=14/BTACCTID4=201/FBDT=1/GENDER=S1/H4=1/OCC=16/PREF=13/PRUNREG=0/PREM=1/MPTRG=0"
    data-width="224"
    data-height="224"
    data-enable-seg="0"
    data-grant-rand="1"
    data-pid="1"
    data-iframe-id=""
    data-xuid=""
    data-observe-channels="comeback.focus"
    style="margin-left:auto; margin-right:auto; width:224px; height:224px;"
>
</div>

<!--/#AdBanner02--></div>















<!--/bodySub--></div>
<!--/[BodySub]-->

<!--/[BodySub]-->

<!--/bodyArea--></div>
<!--/[BodyArea]-->








<!--[FooterArea]-->
<div id="footerArea">
<div class="pagetopLink"><p><a href="#page">このページの上部へ</a></p></div>

<div class="adImpactFooter"><div class="adMain widget"
    data-widget-namespace="jp.mixi.ad.expander"
    data-server="http://n2.ads.mreco0.jp"
    data-api-prefix="http://api.ads.mixi.jp/"
    data-tag="/SITE=VIEWMESSAGE/AREA=FOOTER.BANNER/AAMSZ=728X90/AGE=1/AGETYPE=1/PARA=76/APPCNT=0/APPUNREG=.33371.27882.29064.23246.34581.31253.36426.37390.38140.6598./S0=11967/S1=10474/S2=10127/S3=11772/S4=10417/S5=10319/S6=10906/S7=11948/BTA=.6.5.145.76./BTACCTID1=79/BTACCTID2=2/BTACCTID3=14/BTACCTID4=201/FBDT=1/GENDER=S1/H4=1/OCC=16/PREF=13/PRUNREG=0/PREM=1/MPTRG=0"
    data-width="728"
    data-height="90"
    data-enable-seg="0"
    data-grant-rand="1"
    data-pid="1"
    data-iframe-id=""
    data-xuid=""
    data-observe-channels="comeback.focus"
    style="margin-left:auto; margin-right:auto; width:728px; height:90px;"
>
</div>
</div>





<div class="footerMain">
<ul class="footerNavigation01">
<li><a href="http://mixi.co.jp/" target="_blank">運営会社</a></li>
<li><a href="http://mixi.co.jp/privacy/" target="_blank">プライバシーポリシー</a></li>
<li><a href="http://mixi.jp/rules.pl">利用規約</a></li>
<li><a href="http://mixi.jp/release_info.pl">運営者からのお知らせ</a></li>
<li><a href="http://mixi.jp/list_service.pl" title="サービス一覧">サービス一覧</a></li>
<li><a href="http://mixi.jp/inquiry.pl">お問い合わせ</a></li>
</ul>
<ul class="footerNavigation02">
<li><a href="http://mixi.co.jp/kenzen/" target="_blank">健全化の取り組み</a></li>
<li><a href="http://mixi.jp/premium.pl?from=footer">mixiプレミアム</a></li>
<li><a href="http://mixi.jp/search_idea.pl">機能要望</a></li>
<li><a href="https://mixi.jp/contact.pl?ad">広告掲載</a></li>
<li><a href="http://developer.mixi.co.jp/?from=footer" target="_blank">開発者向け情報</a></li>
<li><a href="http://recruit.mixi.co.jp/" target="_blank">人材募集</a></li>
<li><a href="http://www.find-job.net/" target="_blank">転職サイト</a></li>

</ul>
<p id="copyright">Copyright (C) 1999-2012 mixi, Inc. All rights reserved.</p>
</div>
<!--/footerArea--></div>
<!--/[FooterArea]-->

</div><!--/page-->




<script type="text/javascript" src="/static/js/lib/jquery-1.7.1.min-noconflict-compress.js?1349331828"></script>
<script type="text/javascript" charset="UTF-8" src="/static/js/mixi/featuredcontents/searchform.production.js?1355119946"></script>
<script type="text/javascript" src="/static/js/overlay.js?1347507784"></script>
<script type="text/javascript" src="/static/js/popup.js?1347507784"></script>
<script type="text/javascript" src="/static/js/windowstate.js?1347507784"></script>
<script type="text/javascript" src="/static/js/mixi/class/baseclass.js?1347507784"></script>
<script type="text/javascript" src="/static/js/mixi/popup/simplepopup.js?1347507784"></script>
<script type="text/javascript" src="/static/js/view_message.js?1347507784"></script>
<script type="text/javascript" src="/static/js//mixi/analysis.production.js?1347516306"></script>
<script type="text/javascript" src="/static/js/lib/prototype/replacer_for_array_prototype.js?1347507784"></script>
<script type="text/javascript" src="/static/js/mixi/ad/other.production.js?1355796633"></script>
<script type="text/javascript"><!--//<![CDATA[
Mixi.Analysis.setAttribute(["mixi.jp/view_message.pl","",""],["a30","g1","ar13","p7","pc"],[""],["",""],["message","","","",decodeURIComponent("")]);

Mixi.Analysis.invoke();

//]]>--></script> 


<script type="text/javascript">
<!--//<![CDATA[
if( this.IS_STARTED_ENTRY_POINT ){
    alert("already loaded");
}
this.IS_STARTED_ENTRY_POINT = true;
Namespace.use('brook.widget bindAllWidget').apply(function (ns) {
    ns.bindAllWidget.run();
});
//]]>--></script>



</body>
</html>







