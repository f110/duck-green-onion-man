use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok "App::Onion::Parser";
    use_ok "App::Onion::Parser::ListMessage";
}

my $html = do { local $/; <DATA> };

subtest "get_message_ids" => sub {
    my $parser = App::Onion::Parser->build(
        target => "list_message",
        content => $html,
    );
    my @message_ids = $parser->get_message_ids;

    is_deeply \@message_ids, [qw/9143931510642147170/];
};

done_testing;
__DATA__
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" class="osMacOSX browserChrome browserChrome31 serviceMessage pageListMessageJpMixi domainJpMixi">
<head>
<title>[mixi] メッセージ一覧</title>

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
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/common.production.css?1386136869" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/skin/gray/mixicollection.css?1347507784" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/skin/header_gray.css?1373360634" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/skin/footer_gray.css?1347507784" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/skin/sidebar_gray.css?1385431243" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/skin/component_gray.css?1386136848" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/skin/message_gray.css?1373360634" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/message.css?1377569071" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/macfix.css?1378260083" />
<link href="http://img.mixi.net/img/basic/favicon.ico"  type="image/vnd.microsoft.icon"  rel="icon"         /><link href="http://img.mixi.net/img/basic/favicon.ico"  type="image/vnd.microsoft.icon"  rel="shortcut icon"         /><link href="http://img.mixi.net/img/smartphone/touch/favicon/x001_prec.png"    rel="apple-touch-icon-precomposed"         />
<!-- / header css and links -->

<!-- header javascript --><script type="text/javascript" src="/static/js/lib/json.js?1347507784"></script>
<script id="js-gateway" type="text/javascript"><!--
(function(){
    if( !window['Mixi'] ){
            window.Mixi = {};
                }

    var json = {"url_mixi_prefix":"http://mixi.jp/","url_mixi_plugin_prefix":"http://plugins.mixi.jp/","url_fan_page_redirector_prefix":"http://p.mixi.jp/","CONFIG_IMG_BASE":"http://img.mixi.net","url_self_ad_prefix":"https://ads.mixi.jp/","url_mobile_fan_apps_runtime":"http://mpa.mixi.net","url_mall_prefix":"http://mmall.jp/mx/","url_mixi_static_prefix":"http://static.mixi.jp/","url_download_prefix":"http://download.mixi.jp/","page_encoding":"euc-jp","url_ad_api_mobile_prefix":"http://api-mobile.ads.mixi.jp/","url_external_script_prefix":"http://external-script.mixi.net/","url_mixi_prefix_ssl":"https://mixi.jp/","url_fan_prefix":"http://page.mixi.jp/","url_marketplace_prefix_ssl":"https://market.mixi.jp/","url_pic_logo_base":"http://community.img.mixi.jp/photo/comm","STATIC_FILE_BASE":"http://img.mixi.net","url_photo_prefix":"http://photo.mixi.jp/","url_mixi_plugin_prefix_ssl":"https://plugins.mixi.jp/","url_application_sap_prefix":"https://sap.mixi.jp/","url_corp_apps_prefix":"http://apps.mixi.co.jp/","ad_iframe_id":0,"url_mall_no_login_top":"http://mmall.jp/","url_mobile_mall_prefix":"http://m.mmall.jp/mx/","url_payment_prefix_ssl":"https://payment.mixi.jp/","url_news_prefix":"http://news.mixi.jp/","url_adsmixi_prefix":"http://adsmixi.net/","url_ad_api_prefix":"http://api.ads.mixi.jp/","box":"inbox","rpc_post_key":"","url_mixi_static_prefix_ssl":"https://static.mixi.jp/","url_pic_logo_base_ssl":"https://mixi.jp/photo/comm","url_corp_develop_prefix":"http://developer.mixi.co.jp/","RUN_MODE":"production","url_mobile_pr_prefix":"http://pr.m.mixi.jp/","url_partner_ads_prefix_ssl":"https://partner.ads.mixi.jp/","url_pr_prefix":"http://pr.mixi.jp/","url_corp_prefix":"http://mixi.co.jp/","url_seller_prefix_ssl":"https://seller.mixi.jp/","url_corp_page_prefix":"http://page.mixi.co.jp/","news_prefix":"http://news.mixi.jp/","url_mobile_prefix":"http://m.mixi.jp/","url_ad_impact_prefix":"http://n2.ads.mreco0.jp/","ad_page_id_list":{},"url_fan_apps_prefix":"http://pageapps.mixi.jp/","url_smartphone_game_prefix":"http://sp.game.mixi.net/","url_corp_pr_prefix":"http://pr.mixi.co.jp/","url_img_ads_prefix":"http://img.ads.mreco0.jp/img/","login_member_id":"","url_gear_prefix_ssl":"https://gear.in.mixi.co.jp/","url_marketplace_prefix":"http://market.mixi.jp/"};
        var value;
            window.Mixi.Gateway = {
                    getParam:function(key){
                                if( !value ) {
                                                value = json;
                                                            }
                                                                        if( !key ){
                                                                                        return value;
                                                                                                    }
                                                                                                                return value[key];
                                                                                                                        }
                                                                                                                            };
                                                                                                                            })();
                                                                                                                            --></script>

<script type="text/javascript" src="/static/js/lib/prototype-effects-1.6.0.2-1.8.1-compress.js?1382666447"></script><script type="text/javascript" src="/static/js/lib/underscore-string-1.3.3-2.0.0-compress.js?1373360634"></script><script type="text/javascript" src="/static/js/lib/namespace-brook-compress.js?1373360634"></script><script type="text/javascript" src="/static/js/mixi.js?1373360634"></script><script type="text/javascript" src="/static/js/dragdrop.js?1347507784"></script><script type="text/javascript" src="/static/js/overlay.js?1347507784"></script><script type="text/javascript" src="/static/js/popup.js?1347507784"></script><script type="text/javascript" src="/static/js/windowstate.js?1347507784"></script><!-- / header javascript -->





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
                data-mixi-host="http://mixi.jp/"
                    data-tracker-host="http://api.ads.mixi.net/"
                        data-tag="/SITE=LISTMESSAGE/AREA=NEWTARGETING.BANNER/AAMSZ=468X60/AGE=2/AGETYPE=1/PARA=75/APPCNT=0/APPUNREG=.39850.33371.27882.29064.37217.23246.34581.38598.38917.36745.6598./BD=_171/BTA=0/GENDER=S1/GENERIC=1386655697/PREF=13/PRUNREG=0/PREM=0/MPTRG=0/CROSS=S1_75/APPRCT=.37217.23246.38917.39850./XMAS2012=0"
                            data-width="468"
                                data-height="60"
                                    data-enable-seg="0"
                                        data-grant-rand="1"
                                            data-pid="2"
                                                data-iframe-id=""
                                                    data-xuid="2577df34f90fbcb0ac1bf84b28ef66953038ec29"
                                                        data-puid="j7ddjwsrrtamf"
                                                            data-puid-sig="0f0739ddc4aa95c9248456dcd1163e8b2d2abb27"
                                                                data-observe-channels="comeback.focus"
                                                                    style="margin-left:auto; margin-right:auto; width:468px; height:60px;"
                                                                    >
                                                                    </div>
                                                                    </div>



<div class="utilityNavigation">
<ul class="serviceSubNavigation">
<li><a href="http://mixi.jp/redirector.pl?id=7471">mixiプレミアム</a></li>
<li><a href="http://mixi.jp/help.pl" title="ヘルプ">ヘルプ</a></li>
<li><a href="http://mixi.jp/logout.pl" title="ログアウト">ログアウト</a></li>
</ul>
<ul class="serviceNavigation">















<li><a href="http://mixi.jp/redirector.pl?id=10150" style="background:url(http://img.mixi.net/img/basic/icon/nenga001.gif) no-repeat 0 0; padding:1px 0 1px 18px;">もうすぐ年末！年賀状はお早めに！</a></li>






</ul>
<!--/utilityNavigation--></div>

<!-- search widget -->
<div class="globalNavigation pGmInputArea01 widget" data-widget-namespace="jp.mixi.featuredcontents.pc.widget.searchform" data-form-select=".JS_searchSelect" data-form-category=".JS_searchCategory" data-form-text-field=".JS_searchTextField" data-form-submit=".JS_searchSubmitButton" role="search">
<p class="home"><a href="http://mixi.jp/home.pl?from=global" title="ホーム">ホーム</a></p>
<ul class="globalNavigationList">
<li class="search"><a href="http://mixi.jp/search.pl" title="友人を探す">友人を探す</a></li>
<li class="invite"><a href="https://mixi.jp/invite.pl" title="友人を招待">友人を招待</a></li>
<li class="appli"><a href="http://mixi.jp/search_appli.pl?from=global" title="アプリ">アプリ</a></li>
<li class="page"><a href="http://page.mixi.jp/page_portal.pl?from=global" title="ページ">ページ</a></li>
<li class="community"><a href="http://mixi.jp/search_community.pl?from=global" title="コミュニティ">コミュニティ</a></li>

<li class="game"><a href="http://mixi.jp/redirector.pl?id=4950&from=global" title="ゲーム">ゲーム</a></li>

<li class="mall"><a href="http://mmall.jp/mx/?aff_id=mixa0001" title="モール">モール</a></li>
<li class="review"><a href="http://mixi.jp/search_item.pl?from=global" title="レビュー">レビュー</a></li>

<li class="searchBox">
<div class="headerSearchCategory"  >
<p class="category"><a href="#" class="JS_searchSelect" onclick="return false">
<span value="search_comm" data-placeholder="コミュニティ検索">コミュ</span>
</a></p>
</div>

<input type="text" class="headerSearchInput01 defaultText JS_searchTextField" name="searchText" value="" data-placeholder="" data-placeholder-class="lPlaceholder" size="10" />
<input class="headerSearchButton JS_searchSubmitButton" type="image" title="検索" alt="検索" src="http://img.mixi.net/img/basic/button/search_button004.gif" />
<ul class="categorySelector JS_searchCategory" style="display:none;"><li value="search_comm" data-placeholder="コミュ" data-placeholder-text="コミュニティ検索"><a href="#" onclick="return false">コミュニティ検索</a></li><li value="search_voice" data-placeholder="つぶやき" data-placeholder-text="つぶやき検索"><a href="#" onclick="return false">つぶやき検索</a></li><li value="search_diary" data-placeholder="日記" data-placeholder-text="日記検索"><a href="#" onclick="return false">日記検索</a></li><li value="search_game" data-placeholder="ゲーム" data-placeholder-text="ゲーム検索"><a href="#" onclick="return false">ゲーム検索</a></li><li value="search_appli" data-placeholder="アプリ" data-placeholder-text="アプリ検索"><a href="#" onclick="return false">アプリ検索</a></li><li value="search_page" data-placeholder="ページ" data-placeholder-text="ページ検索"><a href="#" onclick="return false">ページ検索</a></li><li value="search_profile" data-placeholder="プロフ" data-placeholder-text="プロフィール検索"><a href="#" onclick="return false">プロフィール検索</a></li><li value="search_school" data-placeholder="学校" data-placeholder-text="学校名を入力"><a href="#" onclick="return false">学校から友人を探す</a></li><li value="search_mykeyword" data-placeholder="キーワード" data-placeholder-text="mixiキーワードを入力"><a href="#" onclick="return false">mixiキーワード検索</a></li><li value="search_news" data-placeholder="ニュース" data-placeholder-text="ニュース検索"><a href="#" onclick="return false">ニュース検索</a></li><li value="search_item" data-placeholder="レビュー" data-placeholder-text="レビュー検索"><a href="#" onclick="return false">レビュー検索</a></li><li value="search_mall" data-placeholder="モール" data-placeholder-text="モール検索"><a href="#" onclick="return false">モール検索</a></li></ul>

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

<form class="JS_formVoiceSearch" action="http://mixi.jp/search_voice.pl" method="get" Accept-Charset="EUC-JP">
<input type="hidden" name="keyword" value="" />
<input type="hidden" name="launch" value="v2" />
<input type="submit" value="search" />
</form>

<form class="JS_formDiarySearch" action="http://mixi.jp/search_diary.pl" method="get" Accept-Charset="EUC-JP">
<input type="submit" value="search" />
<input type="hidden" name="keyword" value="" />
<input type="hidden" name="type" value="dia" />
<input type="hidden" name="launch" value="v2" />
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
<input type="hidden" name="sort_type" value="neary" />
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

<form class="JS_formMallSearch" action="http://mixi.jp/search_mall_redirector.pl" method="get" Accept-Charset="UTF-8">
<input type="hidden" name="keyword" value="" />
<input type="hidden" name="aff_name" value="global_search_window_not_home_pc" />
<input type="submit" value="search" />
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
                        href="http://mixi.jp/show_profile.pl?id=53075497&from=navi"
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
                                                                                                                                        title="コンテンツ">コンテンツ</a><div id="contentsSubMenu" style="display:none"><ul class="pulldown"><li><a href="http://mixi.jp/list_mymall_item.pl?from=navi">アイテム</a></li><li><a href="http://mixi.jp/list_review.pl?from=navi">レビュー</a></li><li><a href="http://market.mixi.jp/manage_trade.pl?from=navi">マイ取引</a></li></ul></div></li><li class="message"><a
                                                                                                                                                href="http://mixi.jp/list_message.pl"
                                                                                                                                                        title="メッセージ"
                                                                                                                                                                class="current">メッセージ</a></li><li class="schedule"><a
                                                                                                                                                                        href="http://mixi.jp/show_schedule.pl"
                                                                                                                                                                                title="カレンダー">カレンダー</a></li><li class="visitor"><a
                                                                                                                                                                                        href="http://mixi.jp/list_visitor.pl?from=navi"
                                                                                                                                                                                                title="訪問者">訪問者</a></li><li class="account"><a
                                                                                                                                                                                                        href="http://mixi.jp/edit_account.pl"
                                                                                                                                                                                                                title="設定変更">設定変更</a></li></ul><!--/personalNavigation01--></div>

<!--/headerArea--></div>
<!--/[HeaderArea]-->






<!--[BodyArea]-->
<div id="bodyArea" class="message">

<!--[BodyMainArea]-->
<div id="bodyMainArea">

<div class="pageTitle homeTitle005"><h2>Dexのメッセージ一覧</h2></div>

<!--[ContentsArea]-->
<div id="contentsArea" class="clearfix">

<!--[SubArea]-->
<div id="subArea">

<div id="compose" class="sideBlock">
<p><a href="send_message.pl?ref=list_message"><img src="http://img.mixi.net/img/basic/button/send_message002.gif" alt="メッセージ作成" /></a></p>
</div>

<div id="subMenu" class="sideBlock">
<ul>
<li class="on" id="subMenuTop"><a class="list" href="list_message.pl?box=inbox">メッセージ一覧</a></li>
<li><span class="draft headline">その他のメッセージ</span></li>
<li class=""><a class="mixiInbox" href="list_message.pl?box=noticebox">mixiからのお知らせ</a></li>
<li class=""><a class="mixiInbox" href="list_message.pl?box=savebox">下書き</a></li>
<li class=""><a class="mixiInbox" href="list_message.pl?box=thrash">ごみ箱</a></li>

<li><span class="headline twoway">古いメッセージ</span></li>
<li><a class="mixiInbox" href="list_old_message.pl?box=inbox">受信箱</a></li>
<li id="subMenuBottom"><a class="mixiInbox" href="list_old_message.pl?box=outbox">送信済み</a></li>

</ul>
</div>

<!--/subArea--></div>

<!--/[SubArea]-->

<!--[MainArea]-->
<div id="mainArea">

<div class="extraWrap01">

<div class="extraInner">

<div class="heading">
<h3 class="list">メッセージ一覧</h3>
</div>

<div class="contents">

<!-- no message -->

<!--[messageListArea]-->
<div class="messageListArea">
<div class="pageNavigation01 top">
<div class="pageList02">
<ul><li rel="__display">1件～2件を表示</li></ul>
</div>
<!--/pageNavigation01--></div>

<form name="delete_message_form" action="move_message.pl?box=inbox&move_to_trash=1" method="post">

<div id="messageList" class="listMessage">

<div class="messageListHead">
<table class="tableHead">
<tr>
<th class="status">&nbsp;</th>
<th class="sender">差出人</th>
<th class="subject">件名・本文</th>
<th class="date">日付</th>
</tr>
</table>
</div>

<div class="messageListBody">
<input id="hidden_message_id" type="hidden" name="message_id" value="" />
<input type="hidden" name="post_key" value="" />

<table class="tableBody">
<tr class="top notOpened">
<td class="status"><img src="http://img.mixi.net/img/basic/icon/message_new.gif" alt="未開封" /></td>
<td class="face">


<a class="thumbnail" href="show_friend.pl?id=17770037">
<img src="http://profile.img.mixi.jp/photo/member/p/48/97/4897dfbb787121644b2dd773ca42de788a1e2ab511m.jpg" alt="Dexter"width="40"height="40"></a>

</td>
<td class="sender">Dexter</td>
<td class="subject"><span class="messageTitle"></span><a href="view_message.pl?thread_id=9143931510642147170&box=inbox&page=1">てす</a></td>
<td class="date">8秒前</td>
</tr>
<tr class="">
<td class="status"><img class="reply" src="http://img.mixi.net/img/basic/icon/arrow_reply001.png" width="12" height="13" alt="返信済み" /></td>
<td class="face">


<a class="thumbnail" href="show_friend.pl?id=775011">
<img src="http://profile.img.mixi.jp/photo/member/50/11/775011_4017660741m.jpg" alt="luckypool"width="40"height="40"></a>

</td>
<td class="sender">luckypool</td>
<td class="subject"><span class="messageTitle">test2</span><a href="view_message.pl?thread_id=1587639003822237935&box=inbox&page=1">test2</a></td>
<td class="date">12月13日</td>
</tr>

</table>

</div>

<!--/messageList--></div>
</form>

<div class="pageNavigation01 bottom">
<div class="pageList02">
<ul><li rel="__display">1件～2件を表示</li></ul>
</div>
<!--/pageNavigation01--></div>
<!--/messageListArea--></div>

<div class="notes01">
<p><img src="http://img.mixi.net/img/basic/icon/school001.gif" alt="同級生" />
…同級生のメッセージに表示されます。詳しくは<a href="help.pl?mode=item&item=632">こちら</a>をご覧ください。</p></div>

<!--/contents--></div>

<!--/extraInner--></div>
<!--/extraWrap01--></div>

<ul class="moreLink01 messageUtility clearfix">
<li><a class="settings" href="http://mixi.jp/edit_account_notice_mail.pl">受信通知の設定</a></li>
<li><a href="edit_message_setting.pl">受信範囲の設定</a></li>
</ul>

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
                    data-mixi-host="http://mixi.jp/"
                        data-tracker-host="http://api.ads.mixi.net/"
                            data-tag="/SITE=LISTMESSAGE/AREA=GENERALBRANDING/AGE=2/AGETYPE=1/PARA=75/APPCNT=0/APPUNREG=.39850.33371.27882.29064.37217.23246.34581.38598.38917.36745.6598./BD=_171/BTA=0/GENDER=S1/GENERIC=1386655697/PREF=13/PRUNREG=0/PREM=0/MPTRG=0/CROSS=S1_75/APPRCT=.37217.23246.38917.39850./XMAS2012=0"
                                data-width="224"
                                    data-height="224"
                                        data-enable-seg="0"
                                            data-grant-rand="1"
                                                data-pid="2"
                                                    data-xuid="2577df34f90fbcb0ac1bf84b28ef66953038ec29"
                                                        data-puid="j7ddjwsrrtamf"
                                                            data-puid-sig="0f0739ddc4aa95c9248456dcd1163e8b2d2abb27"
                                                                data-observe-channels="comeback.focus"
                                                                    data-load-with-channel=''
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
                data-mixi-host="http://mixi.jp/"
                    data-tracker-host="http://api.ads.mixi.net/"
                        data-tag="/SITE=LISTMESSAGE/AREA=MEGA.TEXT/AAMSZ=MTEXT/AGE=2/AGETYPE=1/PARA=75/APPCNT=0/APPUNREG=.39850.33371.27882.29064.37217.23246.34581.38598.38917.36745.6598./BD=_171/BTA=0/GENDER=S1/GENERIC=1386655697/PREF=13/PRUNREG=0/PREM=0/MPTRG=0/CROSS=S1_75/APPRCT=.37217.23246.38917.39850./XMAS2012=0"
                            data-width="216"
                                data-height="72"
                                    data-enable-seg="0"
                                        data-grant-rand="1"
                                            data-pid="1"
                                                data-iframe-id=""
                                                    data-xuid="2577df34f90fbcb0ac1bf84b28ef66953038ec29"
                                                        data-puid="j7ddjwsrrtamf"
                                                            data-puid-sig="0f0739ddc4aa95c9248456dcd1163e8b2d2abb27"
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
                data-mixi-host="http://mixi.jp/"
                    data-tracker-host="http://api.ads.mixi.net/"
                        data-tag="/SITE=LISTMESSAGE/AREA=MEGA.TEXT/AAMSZ=MTEXT/AGE=2/AGETYPE=1/PARA=75/APPCNT=0/APPUNREG=.39850.33371.27882.29064.37217.23246.34581.38598.38917.36745.6598./BD=_171/BTA=0/GENDER=S1/GENERIC=1386655697/PREF=13/PRUNREG=0/PREM=0/MPTRG=0/CROSS=S1_75/APPRCT=.37217.23246.38917.39850./XMAS2012=0"
                            data-width="216"
                                data-height="72"
                                    data-enable-seg="0"
                                        data-grant-rand="1"
                                            data-pid="1"
                                                data-iframe-id=""
                                                    data-xuid="2577df34f90fbcb0ac1bf84b28ef66953038ec29"
                                                        data-puid="j7ddjwsrrtamf"
                                                            data-puid-sig="0f0739ddc4aa95c9248456dcd1163e8b2d2abb27"
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


<li><a id="JS_supportReportLink"  href="http://mixi.jp/support_report.pl?mode=disable">規約違反の通報</a></li>




</ul>
</div>
<!--/help--></div>
<!--/[help]-->


<div id="adBanner02">
<div class="adMain widget"
    data-widget-namespace="jp.mixi.ad.expander.change_iframe_size"
        data-server="http://n2.ads.mreco0.jp"
            data-api-prefix="http://api.ads.mixi.jp/"
                data-mixi-host="http://mixi.jp/"
                    data-tracker-host="http://api.ads.mixi.net/"
                        data-tag="/SITE=LISTMESSAGE/AREA=SQUARE.BANNER/AAMSZ=224X224/AGE=2/AGETYPE=1/PARA=75/APPCNT=0/APPUNREG=.39850.33371.27882.29064.37217.23246.34581.38598.38917.36745.6598./BD=_171/BTA=0/GENDER=S1/GENERIC=1386655697/PREF=13/PRUNREG=0/PREM=0/MPTRG=0/CROSS=S1_75/APPRCT=.37217.23246.38917.39850./XMAS2012=0"
                            data-width="224"
                                data-height="224"
                                    data-enable-seg="0"
                                        data-grant-rand="1"
                                            data-pid="1"
                                                data-xuid="2577df34f90fbcb0ac1bf84b28ef66953038ec29"
                                                    data-puid="j7ddjwsrrtamf"
                                                        data-puid-sig="0f0739ddc4aa95c9248456dcd1163e8b2d2abb27"
                                                            data-observe-channels="comeback.focus"
                                                                data-load-with-channel=''
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
                data-mixi-host="http://mixi.jp/"
                    data-tracker-host="http://api.ads.mixi.net/"
                        data-tag="/SITE=LISTMESSAGE/AREA=FOOTER.BANNER/AAMSZ=728X90/AGE=2/AGETYPE=1/PARA=75/APPCNT=0/APPUNREG=.39850.33371.27882.29064.37217.23246.34581.38598.38917.36745.6598./BD=_171/BTA=0/GENDER=S1/GENERIC=1386655697/PREF=13/PRUNREG=0/PREM=0/MPTRG=0/CROSS=S1_75/APPRCT=.37217.23246.38917.39850./XMAS2012=0"
                            data-width="728"
                                data-height="90"
                                    data-enable-seg="0"
                                        data-grant-rand="1"
                                            data-pid="1"
                                                data-iframe-id=""
                                                    data-xuid="2577df34f90fbcb0ac1bf84b28ef66953038ec29"
                                                        data-puid="j7ddjwsrrtamf"
                                                            data-puid-sig="0f0739ddc4aa95c9248456dcd1163e8b2d2abb27"
                                                                data-observe-channels="comeback.focus"
                                                                    style="margin-left:auto; margin-right:auto; width:728px; height:90px;"
                                                                    >
                                                                    </div>
                                                                    </div>





<div class="footerMain">


<ul class="footerNavigation01">
<li><a href="http://mixi.jp/release_info.pl">運営者からのお知らせ</a></li>
<li><a href="http://mixi.jp/rules.pl">利用規約</a></li>
<li><a href="http://mixi.jp/premium.pl?from=footer">mixiプレミアム</a></li>
<li><a href="http://mixi.jp/list_service.pl" title="サービス一覧">サービス一覧</a></li>
<li><a href="http://apps.mixi.co.jp/" target="_blank">スマホアプリ一覧</a></li>
<li><a href="http://mixi.jp/search_idea.pl">機能要望</a></li>
<li><a href="http://mixi.jp/mobile_access.pl">スマホからの利用</a></li>
<li><a href="http://mixi.jp/inquiry.pl">お問い合わせ</a></li>
</ul>
<ul class="footerNavigation02">
<li><a href="http://mixi.co.jp/" target="_blank">運営会社</a></li>
<li><a href="http://mixi.co.jp/privacy/" target="_blank">プライバシーポリシー</a></li>
<li><a href="http://mixi.co.jp/kenzen/" target="_blank">健全化の取り組み</a></li>
<li><a href="https://mixi.jp/contact.pl?ad">広告掲載</a></li>
<li><a href="http://developer.mixi.co.jp/?from=footer" target="_blank">開発者向け情報</a></li>
<li><a href="http://pr.mixi.co.jp/" target="_blank">公式ブログ</a></li>
<li><a href="http://mixi.co.jp/recruit/" target="_blank">人材募集</a></li>
<li><a href="http://www.find-job.net/" target="_blank">転職サイト</a></li>

</ul>
<p id="copyright">Copyright (C) 1999-2013 mixi, Inc. All rights reserved.</p>
</div>
<!--/footerArea--></div>
<!--/[FooterArea]-->

</div><!--/page-->













<script type="text/javascript" src="/static/js/lib/jquery-1.7.1.min-noconflict-compress.js?1373360634"></script>
<script type="text/javascript" charset="UTF-8" src="/static/js/mixi/featuredcontents/searchform.production.js?1382421635"></script>
<script type="text/javascript" src="/static/js/mixi/util/namespace.js?1347507784"></script>
<script type="text/javascript" src="/static/js/mixi/class/baseclass.js?1347507784"></script>
<script type="text/javascript" src="/static/js/mixi/event/eventdispatcher.js?1347507784"></script>
<script type="text/javascript" src="/static/js/mixi/popup/simplepopup.js?1347507784"></script>
<script type="text/javascript" src="/static/js/list_message.js?1379988238"></script>
<script type="text/javascript" src="/static/js/mixi/analysis.production.js?1373360634"></script>
<script type="text/javascript" src="/static/js/lib/prototype/replacer_for_array_prototype.js?1347507784"></script>
<script type="text/javascript" src="/static/js/mixi/ad/other.production.js?1382940266"></script>
<script type="text/javascript" src="/static/js/jp/co/mixi/logging.production.js?1384754428"></script>

<script type="text/javascript"><!--//<![CDATA[
Mixi.Analysis.setAttribute(["mixi.jp/list_message.pl","",""],["a40","g1","ar13","p5","pc"],[""],["",""],["message","","","",decodeURIComponent("")]);

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







