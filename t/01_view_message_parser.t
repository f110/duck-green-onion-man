use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok 'App::Onion::Parser';
    use_ok 'App::Onion::Parser::ViewMessage';
}

my $html = do { local $/; <DATA> };

subtest 'can_ok' => sub {
    can_ok 'App::Onion::Parser::ViewMessage', qw(parse);
};

subtest 'parse with html' => sub {
    my $parser = App::Onion::Parser->build(
        target => 'view_message',
        content => $html,
    );
    my $got = $parser->parse;
    is_deeply $got, {
        member => {
            52 => "fuga",
        },
        message => [
            {
                sender => 52,
                body => "ふが",
                thread_id => "3739154590748419400",
                id => "95d6eefe2eb77958dab3c3c5a887b2d0",
                url => "http://sc.mixi.org/view_thread_message.pl?thread_id=3739154590748419400&id=95d6eefe2eb77958dab3c3c5a887b2d0&box=inbox",
                timestamp => '10:13',
            },
            {
                sender => '@me',
                body => "おれおれ",
                timestamp => '10:25',
            },
            {
                sender => 52,
                body => "ぴよ",
                thread_id => '3739154590748419400',
                id => '035e57ab2dd4783c9297d079c6571e0f',
                url => "http://sc.mixi.org/view_thread_message.pl?thread_id=3739154590748419400&id=035e57ab2dd4783c9297d079c6571e0f&box=inbox",
                timestamp => '13:24',
            },
        ],
    };
};

done_testing;
__DATA__




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" class="osMacOSX browserChrome browserChrome31 serviceMessage pageViewMessageOrgMixiSc domainOrgMixiSc">
<head>
<title> fugaさんとのメッセージ</title>

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
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/common.production.css" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/skin/gray/mixicollection.css?1384396631" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/skin/header_gray.css?1384396631" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/skin/footer_gray.css?1384396631" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/skin/sidebar_gray.css?1384396631" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/skin/component_gray.css?1384396631" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/skin/message_gray.css?1384396631" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/message.css?1384396631" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/basic/macfix.css?1384396631" /><link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/page/decolink.css?1384396631" />
<link rel="stylesheet" type="text/css" href="http://img.mixi.net/static/css/emoji_palette.css?1384396631" />
<link href="http://img.mixi.net/img/basic/favicon.ico"  type="image/vnd.microsoft.icon"  rel="icon"         /><link href="http://img.mixi.net/img/basic/favicon.ico"  type="image/vnd.microsoft.icon"  rel="shortcut icon"         /><link href="http://img.mixi.net/img/smartphone/touch/favicon/x001_prec.png"    rel="apple-touch-icon-precomposed"         />
<!-- / header css and links -->

<!-- header javascript --><script type="text/javascript" src="/static/js/lib/json.js?1384396631"></script>
<script id="js-gateway" type="text/javascript"><!--
(function(){
    if( !window['Mixi'] ){
            window.Mixi = {};
                }

    var json = {"url_mixi_prefix":"http://sc.mixi.org/","url_mixi_plugin_prefix":"","url_fan_page_redirector_prefix":"","CONFIG_IMG_BASE":"http://img.mixi.net","url_self_ad_prefix":"","sender_image":"http://img.mixi.net/img/basic/common/noimage_member40.gif","url_mobile_fan_apps_runtime":"","url_mixi_static_prefix":"","url_mall_prefix":"http://sc.mixi.org/not_yet/","url_download_prefix":"","page_encoding":"euc-jp","url_ad_api_mobile_prefix":"","url_external_script_prefix":"","url_mixi_prefix_ssl":"http://sc.mixi.org/","url_fan_prefix":"","thread_id":"3739154590748419400","url_marketplace_prefix_ssl":"","url_pic_logo_base":"http://community.img.sc.mixi.org/photo/comm","STATIC_FILE_BASE":"http://img.mixi.net","sender_link":"show_profile.pl?id=50","url_photo_prefix":"http://sc.mixi.org/not_yet/","url_mixi_plugin_prefix_ssl":"","url_application_sap_prefix":"","ad_iframe_id":null,"url_mall_no_login_top":"","url_mobile_mall_prefix":"","url_payment_prefix_ssl":"","url_news_prefix":"","url_adsmixi_prefix":"","url_ad_api_prefix":"","rpc_post_key":"","url_mixi_static_prefix_ssl":"","url_pic_logo_base_ssl":"https://community-img-sc.mixi.org/photo/comm","url_corp_develop_prefix":"","RUN_MODE":"production","url_mobile_pr_prefix":"","url_partner_ads_prefix_ssl":"","url_pr_prefix":"","url_corp_prefix":"","url_seller_prefix_ssl":"","url_corp_page_prefix":"","is_talk":"1","url_video_prefix":"","news_prefix":"","url_mobile_prefix":"http://sc.mixi.org/","url_ad_impact_prefix":"","ad_page_id_list":null,"url_fan_apps_prefix":"","url_smartphone_game_prefix":"http://sc.mixi.org/not_yet/","url_img_ads_prefix":"","login_member_id":"50","url_gear_prefix_ssl":"","url_marketplace_prefix":"","fancyurl_schema":["http://mixi.jp/fancyurl_test_for_static.pl","http://photo.mixi.jp/view_album.pl?*","http://photo.mixi.jp/view_share_album.pl?*","http://www.clubdam.com/app/damtomo/karaokePost/StreamingKrk.do?karaokeContributeId=*&karaokeContributeIdBlogParts=*","http://mixi.jp/pr.pl?id=76&vegas=entry","http://mixi.jp/view_item.pl?*"],"url_upload_video_prefix":""};
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

<script type="text/javascript" src="/static/js/lib/prototype-effects-1.6.0.2-1.8.1-compress.js?1384396631"></script><script type="text/javascript" src="/static/js/lib/underscore-string-1.3.3-2.0.0-compress.js?1384396631"></script><script type="text/javascript" src="/static/js/lib/namespace-brook-compress.js?1384396631"></script><script type="text/javascript" src="/static/js/mixi.js?1384396631"></script><script type="text/javascript" src="/static/js/mixi/oembed.js?1384396631"></script><script type="text/javascript" src="/static/js/lib/swfobject-1.5.1-compress.js?1384396631"></script><script type="text/javascript" src="/static/js/mixi/util/namespace.js?1384396631"></script><script type="text/javascript" src="/static/js/mixi/message/message.js?1384396631"></script><!-- / header javascript -->





</head>




<body>


<div id="page">

<!--[HeaderArea]-->
<div id="headerArea">
<div class="headerLogo"><h1><a id="pagetop" href="http://sc.mixi.org/home.pl?from=h_logo"><img src="http://img.mixi.net/img/basic/common/mixi_logo_large001.gif" alt="mixi" width="72" height="30" /></a></h1></div>


<div class="adBanner"><a href="http://sc.mixi.org/redirector.pl?id=7487"><img src="http://img.mixi.net/img/promotion/school/banner_468.jpg" width="468" height="60" border="0" class="bnlogin"></a></div>



<div class="utilityNavigation">
<ul class="serviceSubNavigation">
<li><a href="http://sc.mixi.org/redirector.pl?id=7471">mixiプレミアム</a></li>
<li><a href="http://sc.mixi.org/help.pl" title="ヘルプ">ヘルプ</a></li>
<li><a href="http://sc.mixi.org/logout.pl" title="ログアウト">ログアウト</a></li>
</ul>
<ul class="serviceNavigation">








</ul>
<!--/utilityNavigation--></div>

<!-- search widget -->
<div class="globalNavigation pGmInputArea01 widget" data-widget-namespace="jp.mixi.featuredcontents.pc.widget.searchform" data-form-select=".JS_searchSelect" data-form-category=".JS_searchCategory" data-form-text-field=".JS_searchTextField" data-form-submit=".JS_searchSubmitButton" role="search">
<p class="home"><a href="http://sc.mixi.org/home.pl?from=global" title="ホーム">ホーム</a></p>
<ul class="globalNavigationList">
<li class="search"><a href="http://sc.mixi.org/search.pl" title="友人を探す">友人を探す</a></li>
<li class="invite"><a href="http://sc.mixi.org/invite.pl" title="友人を招待">友人を招待</a></li>
<li class="appli"><a href="http://sc.mixi.org/search_appli.pl" title="アプリ">アプリ</a></li>
<li class="page"><a href="page_portal.pl" title="ページ">ページ</a></li>
<li class="community"><a href="http://sc.mixi.org/search_community.pl?from=global" title="コミュニティ">コミュニティ</a></li>

<li class="game"><a href="http://sc.mixi.org/redirector.pl?id=4950" title="ゲーム">ゲーム</a></li>

<li class="mall"><a href="http://sc.mixi.org/not_yet/?aff_id=mixa0001" title="モール">モール</a></li>
<li class="review"><a href="http://sc.mixi.org/search_item.pl?from=global" title="レビュー">レビュー</a></li>

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
<form class="JS_formCommunitySearch" action="http://sc.mixi.org/search_community.pl" method="get" Accept-Charset="EUC-JP">
<input type="hidden" name="keyword" value="" />
<input type="hidden" name="search_mode" value="title" />
<input type="hidden" name="category_id" value="0" />
<input type="hidden" name="type" value="com" />
<input type="hidden" name="mode" value="main" />
<input type="hidden" name="launch" value="v2" />
<input type="submit" value="search" />
</form>

<form class="JS_formGameSearch" action="http://sc.mixi.org/search_appli_result.pl" method="get" Accept-Charset="EUC-JP">
<input type="hidden" name="keyword" value="" />
<input type="hidden" name="is_game" value="1" />
<input type="hidden" name="launch" value="v2" />
<input type="submit" value="search" />
</form>

<form class="JS_formAppliSearch" action="http://sc.mixi.org/search_appli_result.pl" method="get" Accept-Charset="EUC-JP">
<input type="hidden" name="keyword" value="" />
<input type="hidden" name="is_game" value="0" />
<input type="hidden" name="launch" value="v2" />
<input type="submit" value="search" />
</form>

<form class="JS_formPageSearch" action="search_page.pl" method="get" accept-charset="UTF-8">
<input type="hidden" name="keyword" value="" />
<input type="hidden" name="title_only" value="1" />
<input type="hidden" name="category_id" value="0" />
<input type="hidden" name="mode" value="result" />
<input type="hidden" name="launch" value="v2" />
<input type="submit" value="search" />
</form>

<form class="JS_formProfileSearch" action="http://sc.mixi.org/search_profile.pl" method="get" Accept-Charset="EUC-JP">
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

<form class="JS_formSchoolSearch" action="http://sc.mixi.org/search_school.pl" method="get" Accept-Charset="EUC-JP">
<input type="hidden" name="keyword" value="" />
<input type="hidden" name="mode" value="search" />
<input type="hidden" name="school_type_id" value="0" />
<input type="hidden" name="launch" value="v2" />
<input type="submit" value="search" />
</form>

<form class="JS_formMyKeywordSearch" action="http://sc.mixi.org/search_mykeyword.pl" method="post" Accept-Charset="EUC-JP">
<input type="hidden" name="mykeyword" value="" />
<input type="hidden" name="mode" value="search" />
<input type="hidden" name="launch" value="v2" />
<input type="submit" value="search" />
</form>

<form class="JS_formNewsSearch" action="search_news.pl" method="get" Accept-Charset="EUC-JP">
<input type="hidden" name="keyword" value="" />
<input type="hidden" name="category_id" value="0" />
<input type="hidden" name="launch" value="v2" />
<input type="submit" value="search" />
</form>

<form class="JS_formItemSearch" action="http://sc.mixi.org/search_item.pl" method="get" Accept-Charset="EUC-JP">
<input type="hidden" name="keyword" value="" />
<input type="hidden" name="category_id" value="0" />
<input type="hidden" name="comm_id" value="" />
<input type="hidden" name="submit_main" value="1" />
<input type="hidden" name="launch" value="v2" />
<input type="submit" value="search" />
</form>

<form class="JS_formMallSearch" action="http://sc.mixi.org/search_mall_redirector.pl" method="get" Accept-Charset="UTF-8">
<input type="hidden" name="keyword" value="" />
<input type="hidden" name="aff_name" value="global_search_window_not_home_pc" />
<input type="submit" value="search" />
</form>

<form class="JS_formDiarySearch" action="http://sc.mixi.org/search_diary.pl" method="get" Accept-Charset="EUC-JP">
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
                        href="http://sc.mixi.org/show_profile.pl?id=50&from=navi"
                                title="プロフィール">プロフィール</a></li><li class="myMixi"><a
                                        href="http://sc.mixi.org/list_friend.pl"
                                                title="友人リスト">友人リスト</a></li><li class="voice"><a
                                                            href="http://sc.mixi.org/list_voice.pl"
                                                                        title="つぶやき">つぶやき</a></li><li class="check"><a
                                                                                href="http://sc.mixi.org/list_check.pl"
                                                                                        title="チェック">チェック</a></li><li class="diary"><a
                                                                                                href="http://sc.mixi.org/list_diary.pl?from=navi"
                                                                                                        title="日記">日記</a></li><li class="photo"><a
                                                                                                                href="http://sc.mixi.org/not_yet/home.pl"
                                                                                                                        title="フォト">フォト</a></li><li id="contentsPulldown" class="contents" aria-live="assertive"><a
                                                                                                                                href="http://sc.mixi.org/js_notice.pl"
                                                                                                                                        title="コンテンツ">コンテンツ</a><div id="contentsSubMenu" style="display:none"><ul class="pulldown"><li><a href="http://sc.mixi.org/list_mymall_item.pl?from=navi">アイテム</a></li><li><a href="http://sc.mixi.org/list_review.pl?from=navi">レビュー</a></li><li><a href="manage_trade.pl?from=navi">マイ取引</a></li></ul></div></li><li class="message"><a
                                                                                                                                                href="http://sc.mixi.org/list_message.pl"
                                                                                                                                                        title="メッセージ"
                                                                                                                                                                class="current">メッセージ</a></li><li class="schedule"><a
                                                                                                                                                                        href="http://sc.mixi.org/show_schedule.pl"
                                                                                                                                                                                title="カレンダー">カレンダー</a></li><li class="visitor"><a
                                                                                                                                                                                        href="http://sc.mixi.org/list_visitor.pl?from=navi"
                                                                                                                                                                                                title="訪問者">訪問者</a></li><li class="account"><a
                                                                                                                                                                                                        href="http://sc.mixi.org/edit_account.pl"
                                                                                                                                                                                                                title="設定変更">設定変更</a></li></ul><!--/personalNavigation01--></div>

<!--/headerArea--></div>
<!--/[HeaderArea]-->








<!--[BodyArea]-->
<div id="bodyArea" class="message">

<!--[BodyMainArea]-->
<div id="bodyMainArea" class="widget" data-widget-namespace="jp.mixi.message.pc.widget.viewthread.background">

<div class="pageTitle homeTitle005"><h2>hogeのメッセージ</h2></div>

<!--[ContentsArea]-->
<div id="contentsArea" class="clearfix">

<!--[subArea]-->
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
<li class="" id="subMenuBottom"><a class="mixiInbox" href="list_message.pl?box=thrash">ごみ箱</a></li>

</ul>
</div>

<!--/subArea--></div>

<!--/[subArea]-->

<!--[MainArea]-->
<div id="mainArea">

<div class="extraWrap01">

<div class="extraInner">
<div class="heading clearfix">
<p class="headingNavi"><a href="http://sc.mixi.org/list_message.pl?box=inbox&page=1">&lt;&lt;&nbsp;メッセージ一覧へ戻る</a></p>
<ul class="toolbar">

<li>
<a class="widget delete" data-widget-namespace="jp.mixi.message.pc.widget.viewthread.movetotrash"
    data-thread-id="3739154590748419400"
        data-confirm-message="fugaさんとのメッセージを削除しますか？"
            data-completion-location="list_message.pl?box=inbox"
                href="javascript:void(0);">削除する</a>
                </li>

</ul>
</div>

<div class="contents">

<div class="messageDialog">

<h3 class="dialogHeader"><a href="show_friend.pl?id=52"><span class="memberName">fuga</span></a>さんとのメッセージ</h3>

<div class="widget dialogBlockLink"
   data-widget-namespace="jp.mixi.message.pc.widget.viewthread.morelink"
      data-has-previous-message="0"
         data-render-target-element-class=".JS_messageList"
            data-morelink-element-id="#JS_moreLink"
               data-loading-element-id="#JS_moreLinkLoading"
               >
               <p id="JS_moreLink" style="display : none;"><a class="upstream" href="javascript:void(0);">過去のメッセージを表示する</a></p>
               <p id="JS_moreLinkLoading" class="dialogBlockLink loading" style="display : none;"></p>
               </div>

<div class="dialogBody widget JS_messageList"
    data-widget-namespace="jp.mixi.message.pc.widget.viewthread.messagelist"
        data-unread-messages-count="1"
            data-thread-id="3739154590748419400"
                data-boundary-message-id="95d6eefe2eb77958dab3c3c5a887b2d0"
                    data-boundary-message-created-at="1384477993"
                        data-conclusive-message-id="035e57ab2dd4783c9297d079c6571e0f"
                            data-conclusive-message-created-at="1384489446">


<div class="subject JS_messageSubjectRow"><h4>てすと</h4></div>

<div id="MID95d6eefe2eb77958dab3c3c5a887b2d0" class="JS_messageRow post receive ">

<p class="author"><span class="thumbnail"><a href="show_friend.pl?id=52"><img src="http://img.mixi.net/img/basic/common/noimage_member40.gif" alt="fuga" /></a></span>
<span class="name">fuga</span></p>


<div class="postBody"><span class="message">ふが</span>
</div>

<div class="postData">


<p class="timestamp"><a href="http://sc.mixi.org/view_thread_message.pl?thread_id=3739154590748419400&id=95d6eefe2eb77958dab3c3c5a887b2d0&box=inbox">10:13</a></p>


</div>
<!--/post--></div>



<div id="MID2da29ac8dd1b2a3774cbaa7fd4a7582c" class="JS_messageRow post send ">


<div class="postBody"><span class="message">おれおれ</span>
</div>

<div class="postData">


<p class="timestamp">10:25</p>


</div>
<!--/post--></div>



<div id="MID035e57ab2dd4783c9297d079c6571e0f" class="JS_messageRow post receive ">

<p class="author"><span class="thumbnail"><a href="show_friend.pl?id=52"><img src="http://img.mixi.net/img/basic/common/noimage_member40.gif" alt="fuga" /></a></span>
<span class="name">fuga</span></p>


<div class="postBody"><span class="message">ぴよ</span>
</div>

<div class="postData">


<p class="timestamp"><a href="http://sc.mixi.org/view_thread_message.pl?thread_id=3739154590748419400&id=035e57ab2dd4783c9297d079c6571e0f&box=inbox">13:24</a></p>


</div>
<!--/post--></div>


<!--/dialogBody--></div>

<div class="widget JS_inputForm postForm"
             data-widget-namespace="jp.mixi.message.pc.widget.viewthread.postmessage"
                          data-input-textarea-class=".JS_textarea"
                                       data-input-form-class=".JS_fileInputForm"
                                                    data-submit-button-class=".JS_submitButton"
                                                                 data-error-area-class=".JS_errorArea"
                                                                              data-thread-id="3739154590748419400"
                                                                                           data-latest-message-title="Re: てすと"
                                                                                                        data-value-nickname="hoge"
                                                                                                                     >

<div class="inputArea" >
<p class="JS_errorArea InputAlert" style="display:none"></p>
<textarea name="body" id="messageBody" rows="3" class="JS_textarea widget" data-widget-namespace="jp.co.mixi.ui.textarea.autoresize" placeholder="メッセージを入力してください"></textarea><input type="submit" value="送信" class="JS_submitButton formBt01" />
</div>


<div class="option JS_fileInputForm" id="messageInput" >
<input name="photo" id="media" type="file">
</div>
<p class="supplement01"><a href="/agreement.pl?id=message" target="_blank">同意事項</a>（※必読）に同意して、送信してください。<br />メッセージの内容を確認する場合があります。</p>
<!--/postForm--></div>




<!--/messageDetail--></div>

<div class="notes01">
<p><img src="http://img.mixi.net/img/basic/icon/school001.gif" alt="同級生" />
…同級生のメッセージに表示されます。詳しくは<a href="help.pl?mode=item&item=632">こちら</a>をご覧ください。</p></div>

<!--/contents--></div>

<!--/extraInner--></div>

<!--/extraWrap01--></div>

<ul class="moreLink01 messageUtility clearfix">
<li><a class="settings" href="http://sc.mixi.org/edit_account_notice_mail.pl">受信通知の設定</a></li>
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


<a href="http://sc.mixi.org/premium.pl?from=224_224_pc" target="_blank"><img src="http://img.mixi.net/img/promotion/pr_banner/premium224_001.gif" border="0" width="224" height="224" alt="mixiプレミアム" /></a>



<!--/#AdBanner--></div>
<!--/[AdBanner]-->
<!-- use_ssl -->











 



































<!--/[help]-->

<!--[help]-->
<div class="bodySubSection" id="help">
<div class="heading01">
<h2>困ったときには</h2>
</div>
<div class="contents">
<ul class="helpList04">
<li><a href="http://sc.mixi.org/help.pl">ヘルプトップ</a></li>
<li><a href="http://sc.mixi.org/help.pl?mode=list&category=3">利用上の注意</a></li>
<li><a id="JS_supportReportLink"  href="http://sc.mixi.org/support_report.pl?mode=disable">規約違反の通報</a></li>


</ul>
</div>
<!--/help--></div>
<!--/[help]-->
















<!--/bodySub--></div>
<!--/[BodySub]-->

<!--/[BodySub]-->

<!--/bodyArea--></div>
<!--/[BodyArea]-->

<div id="emoji_palette" class="emoji_palette"><div class="emoji_palette_title" onclick="closeEmojiPalette();" align="left">
<div id="emoji_palette_title_left" class="emoji_palette_title_left"></div><div class="emoji_palette_title_right"><a href="javascript:void(0)" onclick="return false;" class="emoji_palette_image_close"><img src="http://img.mixi.net/img/p_close_rev.gif" alt="close" class="emoji_palette_image_close" height="11" width="12" /></a></div></div>
<div class="emoji_palette_body">
  <table align="center" border="0" cellpadding="0" cellspacing="2">
      <tbody></tbody>
          <tbody id="ads_area"></tbody>
            </table>
            </div>
            </div>

<!-- decomessage -->
<div id="decometag_template"><!--<decome src="<TMPL_VAR NAME="id">">--></div>
<div class="utilityWindow02" id="decomessage_selector" style="display:none;"></div>
<!-- /decomessage -->










































<!--[FooterArea]-->
<div id="footerArea">
<div class="pagetopLink"><p><a href="#page">このページの上部へ</a></p></div>







<div class="footerMain">
<ul class="footerNavigation01">
<li><a href="" target="_blank">運営会社</a></li>
<li><a href="privacy/" target="_blank">プライバシーポリシー</a></li>
<li><a href="http://sc.mixi.org/rules.pl">利用規約</a></li>
<li><a href="http://sc.mixi.org/release_info.pl">運営者からのお知らせ</a></li>
<li><a href="http://sc.mixi.org/list_service.pl" title="サービス一覧">サービス一覧</a></li>
<li><a href="http://sc.mixi.org/inquiry.pl">お問い合わせ</a></li>
</ul>
<ul class="footerNavigation02">
<li><a href="kenzen/" target="_blank">健全化の取り組み</a></li>
<li><a href="http://sc.mixi.org/premium.pl?from=footer">mixiプレミアム</a></li>
<li><a href="http://sc.mixi.org/search_idea.pl">機能要望</a></li>
<li><a href="http://sc.mixi.org/contact.pl?ad">広告掲載</a></li>
<li><a href="?from=footer" target="_blank">開発者向け情報</a></li>
<li><a href="http://recruit.mixi.co.jp/" target="_blank">人材募集</a></li>
<li><a href="http://www.find-job.net/" target="_blank">転職サイト</a></li>

</ul>
<p id="copyright">Copyright (C) 1999-2013 mixi, Inc. All rights reserved.</p>
</div>
<!--/footerArea--></div>
<!--/[FooterArea]-->

</div><!--/page-->
<div style="display:none" class="HTML_TEMPLATE" id="decoMessageTemplate"><!--<div class="layerHeading02">
<h2><TMPL_VAR EXPR="html_escape(nickname)">のメッセージ素材</h2>
<span class="close"><img src="<TMPL_VAR NAME=CONFIG_IMG_BASE ESCAPE=0>/img/basic/button/close006.gif" alt="閉じる" class="closeBtn" /></span>
</div>

<div class="contents">

<TMPL_IF NAME='hasItems'>
<div class="tab01">
<ul>
<li><a href="javascript:void(null);" class="all"><span>全て</span></a></li>&nbsp;<li><a href="javascript:void(null);" class="decome"><span>デコメッセージ素材</span></a></li>&nbsp;<li><a href="javascript:void(null);" class="grica"><span>グリカ素材</span></a></li>
</ul>
</div>
<TMPL_ELSE>
<div class="tab01">
<ul>
<li><span class="disabled"><span>全て</span></span></li>&nbsp;<li><span class="disabled"><span>デコメッセージ素材</span></span></li>&nbsp;<li><span class="disabled"><span>グリカ素材</span></span></li>
</ul>
</div>
</TMPL_IF>

<div class="contentsBody">

<TMPL_IF NAME='hasItems'>
<div class="category01">
<p>カテゴリで絞り込み</p><select name="decoCategory" id="decoCategory">
<option value="">全て</option>
<TMPL_LOOP NAME='genres'>
<option value="<TMPL_VAR EXPR="html_escape(id)">"<TMPL_IF NAME='is_selected'> selected="selected"</TMPL_IF>><TMPL_VAR EXPR="html_escape(name)"></option>
</TMPL_LOOP>
</select>
</div>

<TMPL_IF NAME='hasItemsOnThisGenre'>
<div class="slideList01">
<ul>
<TMPL_LOOP NAME='items'>
<li id="item<TMPL_VAR EXPR="html_escape(contents_id)">"><span class="thumb"><img src="<TMPL_VAR EXPR="html_escape(thumbnail_pc_url)">" class="thumbImg" /></span><span class="btn"><a href="javascript:void(null);" title="メッセージに貼る"><img src="<TMPL_VAR NAME=CONFIG_IMG_BASE ESCAPE=0>/img/basic/button/paste001.gif" alt="メッセージに貼る" width="120" height="23" /></a></span></li>
</TMPL_LOOP>
</ul>
<div class="slider" style="display:none;">
<div class="up"></div>
<div class="handle"></div>
<div class="down"></div>
</div>
</div>

<TMPL_ELSE>
<div class="messageArea">
<div class="contents">
<div style="padding-top:64px; padding-bottom:64px;">
<p class="nothing"><img src="<TMPL_VAR NAME=CONFIG_IMG_BASE ESCAPE=0>/img/basic/common/nothing.gif" alt="まだ何もありません"/></p>
</div>
</div>
</div>
</TMPL_IF>



<TMPL_ELSE>
<div class="decomessageAlert">
<p>まだデコメッセージの素材を持っていません。いますぐGETしちゃおう！</p>
<p><a href="promotion.pl?id=mobile_access" target="_blank">詳しくは「mixiモバイル」から</a></p>
</div>
</TMPL_IF>

</div>

</div>
--></div><div style="display:none" class="HTML_TEMPLATE" id="delConfirmThreadMessageTemplate"><!--<div class="editList01">
<div class="layerHeading01 clearfix">
<h2>メッセージ削除の確認</h2>
<a href="javascript:void(0);" id='' class='closeButton' ><img src="<TMPL_VAR NAME=CONFIG_IMG_BASE ESCAPE=0>/img/basic/button/close005.gif" alt="閉じる" title="閉じる" /></a>
</div>
<div class="contents">
<p class="notes02"><TMPL_VAR EXPR="html_escape(message)"></p>

</div>

<ul class="formButtons01">
<li><input type="submit" class="formBt01 submitButton" value="完全に削除する" /></li>
<li><input type="submit" class="formBt02 closeButton" value="やめる" /></li>
</ul>

</div>
--></div>
<div style="display:none" data-last-update-time="1384396634" class="HTML_TEMPLATE" id="message_snippet"><!--<TMPL_IF NAME="is_new_topic">
<div class="subject JS_messageSubjectRow"><h4><TMPL_VAR EXPR="html_escape(subject)"></h4></div>
</TMPL_IF>
<div id="MID<TMPL_VAR EXPR="html_escape(message_id)">" class="JS_messageRow post <TMPL_IF NAME="is_own">send<TMPL_ELSE>receive</TMPL_IF> <TMPL_IF NAME="is_system_message">system</TMPL_IF>"<TMPL_IF NAME=deleted> style="display:none"</TMPL_IF>>
<TMPL_UNLESS EXPR="is_own || is_system_message">
<p class="author"><span class="thumbnail"><TMPL_IF NAME="nickname"><a href="<TMPL_VAR EXPR="html_escape(sender_link)">"><img src="<TMPL_VAR EXPR="html_escape(image)">" alt="<TMPL_VAR EXPR="html_escape(nickname)">" /></a><TMPL_ELSE><a><img src="<TMPL_VAR EXPR="html_escape(image)">" alt="" /></a></TMPL_IF></span>
<span class="name"><TMPL_IF NAME="nickname"><TMPL_VAR EXPR="html_escape(nickname)"><TMPL_ELSE>退会したユーザー</TMPL_IF></span><TMPL_IF NAME="use_icon"><TMPL_VAR NAME="icon_html" ESCAPE=0></TMPL_IF></p>
</TMPL_UNLESS>
<TMPL_IF NAME="is_post">
<div class="postBody"><span class="message JS_postBody"><TMPL_VAR EXPR="lf_to_br(html_escape(body))"></span></div>
<TMPL_IF NAME="image_html">
<div class="postBody JS_postImage"><TMPL_VAR EXPR="lf_to_br(image_html)"></div>
</TMPL_IF>
<TMPL_ELSE>
<div class="postBody"><TMPL_VAR NAME="body_html" ESCAPE=0></div>
</TMPL_IF>
<div class="postData">
<TMPL_UNLESS EXPR="is_system_message">
<TMPL_IF NAME="is_own">
<p class="timestamp"><TMPL_VAR EXPR="html_escape(created_at)"></p>
<TMPL_ELSE>
<p class="timestamp"><a href="<TMPL_VAR NAME="url_mixi_prefix">view_thread_message.pl?thread_id=<TMPL_VAR EXPR="html_escape(thread_id)">&id=<TMPL_VAR EXPR="html_escape(message_id)">&box=inbox"><TMPL_VAR EXPR="html_escape(created_at)"></a></p>
</TMPL_IF>
</TMPL_UNLESS>
</div>
</div>
--></div>











<script type="text/javascript" src="/static/js/lib/jquery-1.7.1.min-noconflict-compress.js?1384396631"></script>
<script type="text/javascript" charset="UTF-8" src="/static/js/mixi/featuredcontents/searchform.production.js?1384396631"></script>
<script type="text/javascript" src="/static/js/lib/slider-1.8.1.js?1384396631"></script>
<script type="text/javascript" src="/static/js/mixi/message/message.js?1384396631"></script>
<script type="text/javascript" src="/static/js/overlay.js?1384396631"></script>
<script type="text/javascript" src="/static/js/popup.js?1384396631"></script>
<script type="text/javascript" src="/static/js/windowstate.js?1384396631"></script>
<script type="text/javascript" src="/static/js/mixi/class/baseclass.js?1384396631"></script>
<script type="text/javascript" src="/static/js/mixi/popup/simplepopup.js?1384396631"></script>
<script type="text/javascript" src="/static/js/view_message.js?1384396631"></script>
<script type="text/javascript" src="/static/js/jp/mixi/message/pc/widget/viewthread/reply.js?1384396631"></script>
<script type="text/javascript" src="/static/js/jp/mixi/message/pc/widget/viewthread/movetotrash.js?1384396631"></script>
<script type="text/javascript" src="/static/js/jp/mixi/message/pc/widget/viewthread/morelink.js?1384396631"></script>
<script type="text/javascript" src="/static/js/jp/mixi/message/pc/widget/viewthread/postmessage.js?1384396631"></script>
<script type="text/javascript" src="/static/js/jp/mixi/message/pc/widget/viewthread/background.js?1384396631"></script>
<script type="text/javascript" src="/static/js/jp/mixi/message/pc/widget/viewthread/messagelist.js?1384396631"></script>
<script type="text/javascript" src="/static/js/jp/mixi/message/pc/widget/viewthread/pollnewmessage.js?1384396631"></script>
<script type="text/javascript" src="/static/js/jp/mixi/message/pc/ui/viewthread/leavethread.js?1384396631"></script>
<script type="text/javascript" src="/static/js/jp/mixi/message/pc/widget/viewthread/leavethread.js?1384396631"></script>
<script type="text/javascript" src="/static/js/jp/mixi/message/pc/widget/birthdaymessage/confirminvitation.js?1384396631"></script>
<script type="text/javascript" src="/static/js/emoji_palette_base.js?1384396631"></script>
<script type="text/javascript" src="/static/js/emoji_palette.js?1384396631"></script>
<script type="text/javascript" src="/static/js/mixi/event/eventdispatcher.js?1384396631"></script>
<script type="text/javascript" src="/static/js/lib/html/template_production.js?1384396631"></script>
<script type="text/javascript" src="/static/js/mixi/message/queue.js?1384396631"></script>
<script type="text/javascript" src="/static/js/mixi/popup/error.js?1384396631"></script>
<script type="text/javascript" src="/static/js/mixi/message/decomessage_selector.js?1384396631"></script>
<script type="text/javascript" src="/static/js/mixi/message/send_message.js?1384396631"></script>
<script type="text/javascript" src="/static/js/mixi/model/utils.js?1384396631"></script>
<script type="text/javascript" src="/static/js/mixi/common/string.js?1384396631"></script>
<script type="text/javascript" src="/static/js/jp/co/mixi/lang/class.js?1384396631"></script>
<script type="text/javascript" src="/static/js/jp/co/mixi/lang.js?1384396631"></script>
<script type="text/javascript" src="/static/js/jp/co/mixi/net/jsonrpc.js?1384396631"></script>
<script type="text/javascript" src="/static/js/jp/co/mixi/net/jsonrpc/engine.js?1384396631"></script>
<script type="text/javascript" src="/static/js/jp/co/mixi/net/jsonrpc/uploader.js?1384396631"></script>
<script type="text/javascript" src="/static/js/jp/co/mixi/net/utils.js?1384396631"></script>
<script type="text/javascript" src="/static/js/jp/co/mixi/net/httprequester.js?1384396631"></script>
<script type="text/javascript" src="/static/js/jp/co/mixi/ui/template.js?1384396631"></script>
<script type="text/javascript" src="/static/js/mixi/model/message.js?1384396631"></script>
<script type="text/javascript" src="/static/js/jp/mixi/message/util/cookie.js?1384396631"></script>
<script type="text/javascript" src="/static/js/jp/mixi/message/util/diffusivepoll.js?1384396631"></script>
<script type="text/javascript" src="/static/js/mixi/common/ui/textarea/autoresize.js?1384396631"></script>
<script type="text/javascript" src="/static/js/mixi/analysis.production.js?1384396631"></script>
<script type="text/javascript" src="/static/js/lib/prototype/replacer_for_array_prototype.js?1384396631"></script>
<script type="text/javascript" src="/static/js/mixi/ad/other.production.js?1384396631"></script>
<script type="text/javascript" src="/static/js/jp/co/mixi/logging.production.js?1384396631"></script>

<script type="text/javascript"><!--//<![CDATA[
Mixi.Analysis.setAttribute(["sc.mixi.org/view_message.pl","",""],["a40","g1","ar1","p1","pc"],[""],["",""],["message","","","",decodeURIComponent("")]);

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
