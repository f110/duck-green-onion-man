use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok "App::Onion::Parser", qw/get_sender/;
}

my $html = do { local $/; <DATA> };

subtest "get_sender" => sub {
    my ($sender_name, $sender_id) = get_sender($html);
    is $sender_name, "doctor who";
    is $sender_id, 1;
};

subtest "get_sender but couldn't get html" => sub {
    my ($sender_name, $sender_id) = get_sender("");
    is $sender_name, undef;
    is $sender_id, undef;
};

subtest "get_sender but get like error page" => sub {
    my ($sender_name, $sender_id) = get_sender("<html><body>error</body></html>");
    is $sender_name, undef;
    is $sender_id, undef;
};

done_testing;
__DATA__


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" class="osMacOSX browserChrome browserChrome23 serviceMessage pageViewMessageJpMixi domainJpMixi">
<head>
<title>[mixi] ��å������ξܺ�</title>

<!-- header meta values -->
<meta http-equiv="Content-Type" content="text/html; charset=euc-jp"  />
<meta name="application-name" content="mixi"  />
<meta name="msapplication-starturl" content="/home.pl?from=pin"  />
<meta name="msapplication-navbutton-color" content="#E0C074"  />
<meta name="msapplication-window" content="width=100%;height=100%"  />
<meta name="msapplication-tooltip" content="ͧ�ͤȥ��ߥ�˥���������ڤ��⤦��"  />
<meta name="robots" content="nofollow,noindex"  />
<meta name="robots" content="noodp"  />
<meta name="Slurp" content="NOYDIR"  />
<meta name="description" lang="ja" content="mixi(�ߥ�����)�ϡ��������̿���ͭ��������������ġ������ܤΥ��ץ�ʤɡ����ޤ��ޤʥ����ӥ���ͧ�͡��οͤȤΥ��ߥ�˥��������򤵤�������˳ڤ������롢���ܺ��絬�ϤΥ�������롦�ͥåȥ���󥰥����ӥ��Ǥ���"  />

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
    data-xuid="eef73ca4e6b8c556bbfafb6cf570c47e1eb46f6e"
    data-observe-channels="comeback.focus"
    style="margin-left:auto; margin-right:auto; width:468px; height:60px;"
>
</div>
</div>


<div class="utilityNavigation">
<ul class="serviceSubNavigation">
<li><a href="http://mixi.jp/mobile_access.pl" title="���ޥۡ�����">���ޥۡ�����</a></li>
<li><a href="http://mixi.jp/help.pl" title="�إ��">�إ��</a></li>
<li><a href="http://mixi.jp/logout.pl" title="��������">��������</a></li>
</ul>
<ul class="serviceNavigation">

<li><a href="http://mixi.jp/redirector.pl?id=6845" title="mixi Xmas 2012" style="background:url(http://img.mixi.net/img/basic/icon/xmas001.gif) no-repeat 0 0; padding:2px 0 2px 20px;">mixi Xmas 2012</a></li>


<li><a href="http://mixi.jp/redirector.pl?id=7055" title="�ߥ�����ǯ���" style="background:url(http://img.mixi.net/img/basic/icon/nenga001.gif) no-repeat 0 0; padding:1px 0 2px 18px;">�ߥ�����ǯ���</a></li>

</ul>
<!--/utilityNavigation--></div>

<!-- search widget -->
<div class="globalNavigation pGmInputArea01 widget" data-widget-namespace="jp.mixi.featuredcontents.pc.widget.searchform" data-form-select=".JS_searchSelect" data-form-category=".JS_searchCategory" data-form-text-field=".JS_searchTextField" data-form-submit=".JS_searchSubmitButton" role="search">
<p class="home"><a href="http://mixi.jp/home.pl?from=global" title="�ۡ���">�ۡ���</a></p>
<ul class="globalNavigationList">
<li class="search"><a href="http://mixi.jp/search.pl" title="ͧ�ͤ�õ��">ͧ�ͤ�õ��</a></li>
<li class="invite"><a href="https://mixi.jp/invite.pl" title="ͧ�ͤ���">ͧ�ͤ���</a></li>
<li class="appli"><a href="http://mixi.jp/search_appli.pl" title="���ץ�">���ץ�</a></li>
<li class="page"><a href="http://page.mixi.jp/page_portal.pl" title="�ڡ���">�ڡ���</a></li>
<li class="community"><a href="http://mixi.jp/search_community.pl?from=global" title="���ߥ�˥ƥ�">���ߥ�˥ƥ�</a></li>
<li class="game"><a href="http://mixi.jp/redirector.pl?id=4950" title="������">������</a></li>
<li class="mall"><a href="http://mmall.jp/mx/?aff_id=mixa0001" title="�⡼��">�⡼��</a></li>

<li class="searchBox">
<div class="headerSearchCategory"  >
<p class="category"><a href="#" class="JS_searchSelect" onclick="return false">
<span value="search_comm" data-placeholder="���ߥ�˥ƥ�����">���ߥ�</span>
</a></p>
</div>

<input type="text" class="headerSearchInput01 defaultText JS_searchTextField" name="searchText" value="" data-placeholder="" data-placeholder-class="lPlaceholder" size="10" />
<input class="headerSearchButton JS_searchSubmitButton" type="image" title="����" alt="����" src="http://img.mixi.net/img/basic/button/search_button004.gif" />
<ul class="categorySelector JS_searchCategory" style="display:none;"><li value="search_comm" data-placeholder="���ߥ�" data-placeholder-text="���ߥ�˥ƥ�����"><a href="#" onclick="return false">���ߥ�˥ƥ�����</a></li><li value="search_game" data-placeholder="������" data-placeholder-text="�����ม��"><a href="#" onclick="return false">�����ม��</a></li><li value="search_appli" data-placeholder="���ץ�" data-placeholder-text="���ץ긡��"><a href="#" onclick="return false">���ץ긡��</a></li><li value="search_page" data-placeholder="�ڡ���" data-placeholder-text="�ڡ�������"><a href="#" onclick="return false">�ڡ�������</a></li><li value="search_profile" data-placeholder="�ץ��" data-placeholder-text="�ץ�ե����븡��"><a href="#" onclick="return false">�ץ�ե����븡��</a></li><li value="search_school" data-placeholder="�ع�" data-placeholder-text="�ع�̾������"><a href="#" onclick="return false">�ع�����ͧ�ͤ�õ��</a></li><li value="search_mykeyword" data-placeholder="�������" data-placeholder-text="mixi������ɤ�����"><a href="#" onclick="return false">mixi������ɸ���</a></li><li value="search_news" data-placeholder="�˥塼��" data-placeholder-text="�˥塼������"><a href="#" onclick="return false">�˥塼������</a></li><li value="search_item" data-placeholder="��ӥ塼" data-placeholder-text="��ӥ塼����"><a href="#" onclick="return false">��ӥ塼����</a></li><li value="search_mall" data-placeholder="�⡼��" data-placeholder-text="�⡼�븡��"><a href="#" onclick="return false">�⡼�븡��</a></li><li value="search_diary" data-placeholder="����" data-placeholder-text="��������"><a href="#" onclick="return false">��������</a></li></ul>

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
        title="�ץ�ե�����">�ץ�ե�����</a></li><li class="myMixi"><a
        href="http://mixi.jp/list_friend.pl"
        title="ͧ�ͥꥹ��">ͧ�ͥꥹ��</a></li><li class="voice"><a
        href="http://mixi.jp/list_voice.pl"
        title="�Ĥ֤䤭">�Ĥ֤䤭</a></li><li class="check"><a
        href="http://mixi.jp/list_check.pl"
        title="�����å�">�����å�</a></li><li class="diary"><a
        href="http://mixi.jp/list_diary.pl?from=navi"
        title="����">����</a></li><li class="photo"><a
        href="http://photo.mixi.jp/home.pl"
        title="�ե���">�ե���</a></li><li id="contentsPulldown" class="contents" aria-live="assertive"><a
        href="http://mixi.jp/js_notice.pl"
        title="����ƥ��">����ƥ��</a><div id="contentsSubMenu" style="display:none"><ul class="pulldown"><li><a href="http://mixi.jp/list_mymall_item.pl?from=navi">�����ƥ�</a></li><li><a href="http://video.mixi.jp/list_video.pl?from=navi">ư��</a></li><li><a href="http://mixi.jp/list_review.pl?from=navi">��ӥ塼</a></li></ul></div></li><li class="message"><a
        href="http://mixi.jp/list_message.pl"
        title="��å�����"
        class="current">��å�����</a></li><li class="schedule"><a
        href="http://mixi.jp/show_schedule.pl"
        title="��������">��������</a></li><li class="account"><a
        href="http://mixi.jp/edit_account.pl"
        title="�����ѹ�">�����ѹ�</a></li></ul><!--/personalNavigation01--></div>

<!--/headerArea--></div>
<!--/[HeaderArea]-->






<!--[BodyArea]-->
<div id="bodyArea" class="message">

<!--[BodyMainArea]-->
<div id="bodyMainArea">

<div class="pageTitle homeTitle005"><h2>Who�μ���Ȣ</h2></div>

<!--[ContentsArea]-->
<div id="contentsArea" class="clearfix">

<!--[subArea]-->
<div id="subArea">

<div id="compose" class="sideBlock">
<p><a href="send_message.pl?ref=list_message"><img src="http://img.mixi.net/img/basic/button/send_message002.gif" alt="��å���������" /></a></p>
</div>

<div id="subMenu" class="sideBlock">
<ul>
<li class="on" id="subMenuTop"><a class="inbox" href="list_message.pl?box=inbox">����Ȣ</a></li>
<li class=""><a class="mixiInbox" href="list_message.pl?box=noticebox">mixi����Τ��Τ餻</a></li>
<li class=""><a class="sent" href="list_message.pl?box=outbox">�����Ѥ�</a></li>
<li class=""><a class="draft" href="list_message.pl?box=savebox">������¸Ȣ</a></li>
<li class="" id="subMenuBottom"><a class="trash" href="list_message.pl?box=thrash">����Ȣ</a></li>
</ul>
</div>

<div id="function" class="sideBlock">
<p><a href="http://mixi.jp/edit_account_notice_mail.pl">�������Τ�����</a></p>
</div>

<!--/subArea--></div>

<!--/[subArea]-->

<!--[MainArea]-->
<div id="mainArea">

<div class="extraWrap01">

<div class="extraInner">

<div class="heading">
<p><a href="list_message.pl?box=inbox&page=1">&lt;&lt;&nbsp;����Ȣ�����</a></p>
</div>

<div class="contents">

<div id="messageDetail">

<div class="thumb"><a href="show_friend.pl?id=3822309"><img src="http://profile.img.mixi.jp/photo/member/1234567890.jpg" alt="doctor who" /></a></div>

<div class="messageDetailHead">
<h3>��mixi Xmas�ؤξ��ԡ�</h3>
<dl>
<dt>����</dt>
<dd>2012ǯ12��10�� 22��32ʬ</dd>
<dt>���п�</dt>
<dd><a href="show_friend.pl?id=1">doctor who</a><span><form action="reply_message.pl?reply_message_id=1234567891&id=1" method="post"><input type="submit" class="formBt01" value="�ֿ�����" /></form></span></dd>
</dl>
</div>

<div id="message_body" class="messageDetailBody FANCYURL_EMBED">��ǯ��mixi Xmas�ε��᤬�����衪���˹����Υ٥���Ĥ餷�ơ����ꥹ�ޥ��ޤǤΥ�����ȥ������ڤ��⤦���ץ쥼��Ȥ䡢̵���Υ����ݥ������館����<br /><br />��mixi Xmas 2012��<br /><a href="http://mixixmas.mplace.jp/?from=miv">http://<wbr/>mixixma<wbr/>s.mplac<wbr/>e.jp/?f<wbr/>rom=miv</a></div>

<div class="formButtons01">
<ul>
<li><form action="reply_message.pl?reply_message_id=1234567890&id=1" method="post"><input type="submit" class="formBt01" value="�ֿ�����" /></form></li>
<li><form action="delete_message.pl?message_id=1234567890&box=inbox" method="post"><input class="formBt02" type=submit value="�������" /></form></li>
</ul>
</div>

<!--/messageDetail--></div>

<div class="notes01">
<p><img src="http://img.mixi.net/img/basic/icon/school001.gif" alt="Ʊ����" />
<img src="http://img.mixi.net/img/basic/icon/company001.gif" alt="Ʊν" />
��Ʊ������Ʊν�Υ�å�������ɽ������ޤ����ܤ�����<a href="help.pl?mode=item&item=632">������</a>��������������</p></div>

<p class="moreLink01"><a href="spam_message.pl?message_id=1234567890&box=inbox">���ѥ��å�������mixi���Ļ�̳�ɤ���𤹤�</a><br /><a href="add_access_block.pl?mode=confirm&target_id=1&via=view_message&message_id=1234567890&page=1">�����Ԥ򥢥������֥�å�����</a></p>

<!--/contents--></div>

<!--/extraInner--></div>

<!--/extraWrap01--></div>

<p style="padding-right: 10px;" class="moreLink01"><a href="http://mixi.jp/edit_message_setting.pl">�����ϰϤ�����</a></p>

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
    data-xuid="eef73ca4e6b8c556bbfafb6cf570c47e1eb46f6e"
    data-observe-channels="comeback.focus"
>

</div>



<!--/#AdBanner--></div>
<!--/[AdBanner]-->
<!-- use_ssl -->














 



















<div id="prContentsArea" class="bodySubSection">
<div class="heading01"><h2>�����������</h2></div>
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
    data-xuid="eef73ca4e6b8c556bbfafb6cf570c47e1eb46f6e"
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
    data-xuid="eef73ca4e6b8c556bbfafb6cf570c47e1eb46f6e"
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
<h2>���ä��Ȥ��ˤ�</h2>
</div>
<div class="contents">
<ul class="helpList04">
<li><a href="http://mixi.jp/help.pl">�إ�ץȥå�</a></li>
<li><a href="http://mixi.jp/help.pl?mode=list&category=3">���Ѿ�����</a></li>
<li><a id="JS_supportReportLink"  href="spam_message.pl?message_id=d6557b05fd0b85f4dd64432276000abe&box=inbox">�����ȿ������</a></li>


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
    data-xuid="eef73ca4e6b8c556bbfafb6cf570c47e1eb46f6e"
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
<div class="pagetopLink"><p><a href="#page">���Υڡ����ξ�����</a></p></div>

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
    data-xuid="eef73ca4e6b8c556bbfafb6cf570c47e1eb46f6e"
    data-observe-channels="comeback.focus"
    style="margin-left:auto; margin-right:auto; width:728px; height:90px;"
>
</div>
</div>





<div class="footerMain">
<ul class="footerNavigation01">
<li><a href="http://mixi.co.jp/" target="_blank">���Ĳ��</a></li>
<li><a href="http://mixi.co.jp/privacy/" target="_blank">�ץ饤�Х����ݥꥷ��</a></li>
<li><a href="http://mixi.jp/rules.pl">���ѵ���</a></li>
<li><a href="http://mixi.jp/release_info.pl">���ļԤ���Τ��Τ餻</a></li>
<li><a href="http://mixi.jp/list_service.pl" title="�����ӥ�����">�����ӥ�����</a></li>
<li><a href="http://mixi.jp/inquiry.pl">���䤤��碌</a></li>
</ul>
<ul class="footerNavigation02">
<li><a href="http://mixi.co.jp/kenzen/" target="_blank">�������μ���Ȥ�</a></li>
<li><a href="http://mixi.jp/premium.pl?from=footer">mixi�ץ�ߥ���</a></li>
<li><a href="http://mixi.jp/search_idea.pl">��ǽ��˾</a></li>
<li><a href="https://mixi.jp/contact.pl?ad">����Ǻ�</a></li>
<li><a href="http://developer.mixi.co.jp/?from=footer" target="_blank">��ȯ�Ը�������</a></li>
<li><a href="http://recruit.mixi.co.jp/" target="_blank">�ͺ��罸</a></li>
<li><a href="http://www.find-job.net/" target="_blank">ž��������</a></li>

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







