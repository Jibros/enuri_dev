<!doctype html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<META NAME="description" CONTENT="최저가 에누리 - 가격비교 사이트 에누리닷컴입니다.">
<META NAME="keyword" CONTENT="휴대폰, 사무, 생활가전, 용품, 영상음향, 컴퓨터, 자동차, 명품, 잡화, 스포츠, 유아, 완구, 가구, 화장품, 식품, 가격비교, 쇼핑몰, 최저가">
<title>에누리 백화점 가격비교</title>
<link rel="shortcut icon" href="http://imgenuri.enuri.gscdn.com/2014/layout/favicon_enuri.ico">
<script type="text/javascript" src="http://www.enuri.com/common/js/lib/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="http://www.enuri.com/department/js/lib/jquery.storageapi.min.js"></script>
<script type="text/javascript" src="http://www.enuri.com/department/js/lib/mustache.js"></script>
<script type="text/javascript" src="http://www.enuri.com/department/js/base.js"></script>
<script type="text/javascript" src="http://www.enuri.com/department/js/common.js"></script>
<script type="text/javascript" src="http://www.enuri.com/department/js/header.js"></script>
<link rel="stylesheet" type="text/css" href="http://www.enuri.com/department/css/default.css">
<link rel="stylesheet" type="text/css" href="http://dev.enuri.com/department/css/layout.css">
<link rel="stylesheet" type="text/css" href="http://www.enuri.com/department/css/content.css">
</head>
<body>
<div id="wrap" class="js-main">
<!------------------------- header start  ----------------------------->
	




<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create', 'UA-53076228-1', 'auto');

// 구글 페이지 로그
function setGPageLog(title, url) {
	ga('send', 'pageview', {
		'page': url,
		'title': title
	});
}

// 구글 이벤트 로그
function setGEventLog(cateName, subCateName, name) {
	try {
		ga('send', 'event', cateName, subCateName, name);
	} catch(e) {}
}

function setGPageLogExec() {
	var nowUrl = document.location.href;
	var domainStr = "enuri.com";

	if(nowUrl.indexOf(domainStr+"/department/index.jsp")>-1 || (nowUrl.indexOf(domainStr+"/department/")>-1 && nowUrl.length<30)) {
		setGPageLog("백화점_홈", "/department/index.jsp");
	}

	if(nowUrl.indexOf(domainStr+"/department/goods_list.jsp")>-1) {
		setGPageLog("백화점_카테고리", "/department/goods_list.jsp");
	}

	if(nowUrl.indexOf(domainStr+"/department/brand_main.jsp")>-1) {
		setGPageLog("백화점_브랜드메인", "/department/brand_main.jsp");
	}

	if(nowUrl.indexOf(domainStr+"/department/brand_list.jsp")>-1) {
		setGPageLog("백화점_브랜드목록", "/department/brand_list.jsp");
	}

	if(nowUrl.indexOf(domainStr+"/department/luxury.jsp")>-1) {
		setGPageLog("백화점_해외명품", "/department/luxury.jsp");
	}

	if(nowUrl.indexOf(domainStr+"/department/best.jsp")>-1) {
		setGPageLog("백화점_Best", "/department/best.jsp");
	}

	if(nowUrl.indexOf(domainStr+"/department/detail.jsp")>-1) {
		setGPageLog("백화점_상품상세", "/department/detail.jsp");
	}

	if(nowUrl.indexOf(domainStr+"/department/search.jsp")>-1) {
		setGPageLog("백화점_검색목록", "/department/search.jsp");
	}
}

setGPageLogExec();
	
/*레이어 열고닫고*/
function onoff(id) {
 	var mid=document.getElementById(id);
	if(mid.style.display=='') {
		mid.style.display='none';
	}else{
 		mid.style.display='';
	}
}

/*tab*/
function clickEvent(nIdx){ 
	if ( nIdx == 1 ){
		$(".sp_enuri").show(); $(".sp_car").hide(); $(".sp_hotdeal").hide(); }
	if ( nIdx == 2 ){
		$(".sp_car").show(); $(".sp_enuri").hide(); $(".sp_hotdeal").hide(); }
	if ( nIdx == 3 ){
		$(".sp_hotdeal").show(); $(".sp_enuri").hide(); $(".sp_car").hide(); }
}
</script>
<style>
.list{height:20px; overflow:hidden;}
#header .r_menu {float:right;margin-top:2px;margin-right:4px;height:22px;}
#header .r_menu .l_menu{float:left;height:22px;line-height:23px}
#header .r_menu .divider{float:left;margin-top:6px;height:10px;width:22px;background:url(http://imgenuri.enuri.gscdn.com/images/department/common/bull_hd_blink.gif) center center no-repeat;}
#header #ly_more {width:302px;height:125px;position:absolute;z-index:9999;}
#header #ly_more ul {margin:0 auto;}
#header #ly_more ul li { float:right;margin-right:0}
#header #ly_more_back {position:absolute ;top:30px;z-index:9999;width:302px;height:111px;margin-left:-20px }
</style>
<link rel="stylesheet" href="/common/css/simple_header.css" type="text/css">
<meta name="format-detection" content="telephone=no">
<div id="header">
	<div class="skipMenu">
		<a href="#">상단 메뉴 바로가기</a>
		<a href="#">본문 바로가기</a>
	</div>
	<!-- top 유틸 영역 -->
	<div class="utilMenu">
		<h1><a href="/" onclick="insertLog(11329);" title="에누리 홈으로 바로이동"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/logo_enuri_s.gif" alt="eNuri 세상의 모든 최저가 에누리 가격비교" /></a></h1>
		<div class="search">
			<form name="fmMainSearch" method="post" onSubmit="javascript:  return false;">
				<input name="keyword" id="keyword" type="text" value="" class="txt"/>
			</form>
			<a href="javascript:return false;" id="keywordBtn"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/btn_search_s.gif" alt="검색" /></a>
		</div>
        <div class="r_menu">
       		<!-- <a href="#n" class="l_menu enuriApp" onclick="onoff('simpleHeader')">에누리앱 설치</a> 
       		<span class="divider"></span> -->
       		<!-- 150224 enuriApp 추가 -->
       		<!-- 150224 심플헤더 -->
       		<div class="headerArea_s depart">
				<div class="simple_h">
							<div class="spbox" id="simpleHeader" style="display:none">
								<a href="#n" class="ly_close" onclick="onoff('simpleHeader')">close</a>
								<ul class="sp_tab">
									<li><a href="javascript:void(0);" onclick="javascript:clickEvent('1');">에누리 가격비교</a></li>
									<li><a href="javascript:void(0);" onclick="javascript:clickEvent('2');">신차비교</a></li>
									<li><a href="javascript:void(0);" onclick="javascript:clickEvent('3');">스마트 핫딜</a></li>
								</ul>
								
								<!-- 에누리 -->
								<div class="sp_enuri">
									<h2>에누리 가격비교 </h2>
									<p>모바일로 더욱 특별해진 가격비교!</p>
									<dl>
										<dt>QR코드 스캔</dt>
										<dd>QR코드</dd>
										<dt>앱 다운로드</dt>
										<dd><a href="https://play.google.com/store/apps/details?id=com.enuri.android" class="goole" target="_new">구글 PLAY스토어</a></dd>
										<dd><a href="https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8" class="apple" target="_new">애플 스토어</a></dd>
									</dl>
								</div>
								
								<!-- 신차비교 -->
								<div class="sp_car" style="display:none">
									<h2>신차비교</h2>
									<p>신차정보부터 견적까지 모두 모바일로 즐기세!</p>
									<dl>
										<dt>QR코드 스캔</dt>
										<dd>QR코드</dd>
										<dt>앱 다운로드</dt>
										<dd><a href="https://play.google.com/store/apps/details?id=com.enuri_car.android" class="goole" target="_new">구글 PLAY스토어</a></dd>
										<dd><a href="https://itunes.apple.com/kr/app/enuli-sinchabigyo/id623149329?mt=8" class="apple" target="_new">애플 스토어</a></dd>
									</dl>
								</div>
								
								<!-- 스마트 핫딜 -->
								<div class="sp_hotdeal" style="display:none">
									<h2>스마트 핫딜</h2>
									<p>소셜커머스는 물론 오픈마켓, 종합몰의 핫딜 상품을 한곳에!</p>
									<dl>
										<dt>QR코드 스캔</dt>
										<dd>QR코드</dd>
										<dt>앱 다운로드</dt>
										<dd><a href="https://play.google.com/store/apps/details?id=com.enuri.deal" class="goole" target="_new">구글 PLAY스토어</a></dd>
										<dd><a href="https://itunes.apple.com/kr/app/seumateuhasdil-sosyeolkeomeoseu/id944887654?mt=8" class="apple" target="_new">애플 스토어</a></dd>
									</dl>
								</div>

							</div>

						</div>
					</div>
			<!--// 150224 심플헤더 끝. -->
            <a href="http://www.enuri.com/knowbox/List.jsp" class="l_menu">지식통</a><span class="divider"></span>
            <a href="http://www.enuri.com/knowbox/List.jsp?kbcate=kbALL&kbcode=kc9" class="l_menu">쇼핑Q&A</a><span class="divider"></span>
            <a href="http://www.enuri.com/tour2012/Tour_Index.jsp" class="l_menu">여행</a><span class="divider"></span>
            <a href="http://www.enuri.com/car/Index.jsp?stp=4" target="_blank" class="l_menu">신차비교</a><span class="divider"></span>
            <a href="JavaScript:;" onClick="ly_moreShow(this);" class="l_menu">더보기</a>
        </div>
	</div>
    <div id="ly_more" style="display:none">
        <ul>
            <li>
                <img src="http://imgenuri.enuri.gscdn.com/images/main/layer_more_S_2015.png" usemap="#more">
                <map name="more" id="more">
                    <area shape="rect" coords="14,45,63,60" href="http://www.enuri.com/event/EventReviewAll.jsp?status=" />
                    <area shape="rect" coords="122,44,167,59" href="http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=http://insvalley.enuri.com/join_site/layout/compare/compare_main.jsp?h_targetPage=/goods/gallerylist.jsp||market_cd=D04||market_point_cd=PLA_20100825004&ac=SNU_B_2010082500003" />
                    <area shape="rect" coords="119,62,168,79" href="http://www.enuri.com/view/move_mall.jsp" />
                    <area shape="rect" coords="14,63,49,76" href="http://www.enuri.com/view/Flower365.jsp" />
                    <area shape="rect" coords="204,45,289,60" href="http://www.enuri.com/view/Insurance_Insvalley.jsp" />
                    <area shape="rect" coords="203,62,289,76" href="http://www.enuri.com/view/Listbrand.jsp?cate=2112" />
                    <area shape="rect" coords="275,12,291,26" href="javascript:;" onClick="ly_moreHidden();" />
                </map>
            </li>
        </ul>
    </div>

<div class="main_pop" style="display:none; height:550px">
	<!-- 150413 세일 -->
	<div class="pop_con">
		<p>세일 브랜드의 최저가를 비교해 보세요.</p>
		<ul>
			<li>롯데백화점</li>
			<li>현대백화점</li>
			<li>AK PLAZA</li>
			<li>갤러리아</li>
		</ul>
	</div>
	<a class="btn_close" href="JavaScript:" onclick="cmd_close()">닫기</a>
	<!--// 150413 세일-->
</div>

<script type="text/javascript">
	function wing_click(){
		if($('.main_pop').css("display") != "block"){
			cmd_click();
		}
 	} 
	
	function cmd_click(){
		insertLog(11961);
		var popright = $("#gnb .menu").offset().left + 3;
		jQuery( ".main_pop" ).toggle(
			function() {
				$(".main_pop").animate({right: popright+'px', top:_quickTop},
						1000,function() {
						$(".main_pop").css({'top':_quickTop});
				});
			}
		);
	}
	
	function cmd_close(){
		if($('.main_pop').css("display") == "block"){
			cmd_click();
		}
	}
</script>
	<!-- //20150306 백화점 책임배송 관련 팝업 -->
	<script language="javascript">
	function ly_moreShow(thisObj) {
		var selMenu = $(thisObj);
		var ly_moreObj = $("#ly_more");
		if(ly_moreObj.css("display")=="none") {
			var topPos =  selMenu.offset().top + selMenu.height(); 
			var leftPos =  selMenu.offset().left - ly_moreObj.width() + selMenu.width() + 5;
			ly_moreObj.css("display", "");
			ly_moreObj.css("top", topPos+"px");
			ly_moreObj.css("left", leftPos+"px");
		} else {
			ly_moreHidden();
		}
	}

	function ly_moreHidden() {
		var ly_moreObj = $("#ly_more");

		ly_moreObj.css("display", "none");

		app_dn_layerClose();
		app_dn_layer_carClose();
	}

	function app_dn_layerShow(param) {
    	if (typeof(param)=="undefined") param=2;

		if (document.getElementById("app_dn_layer").style.display == "" || document.getElementById("app_dn_layer_car").style.display=="") {
			document.getElementById("app_dn_layer").style.display = "none";
			app_dn_layer_carClose();
		} else {
			if (document.getElementById("app_dn_layer").style.display=="none") {
				document.getElementById("app_dn_layer").style.display = "";
			}
		}
	}

	function app_dn_layerShow1205() {
		if(document.getElementById("app_dn_layer_car").style.display=="") {
			app_dn_layer_carClose();
		}

		if(document.getElementById("app_dn_layer").style.display=="none") {
			document.getElementById("app_dn_layer").style.display = "";
		}
	}

	function app_dn_layer_carShow(param) {
		if(typeof(param)=="undefined") param = "";

		if(document.getElementById("app_dn_layer").style.display=="") {
			app_dn_layerClose();
		}

		if(document.getElementById("app_dn_layer_car").style.display=="none") {
			document.getElementById("app_dn_layer_car").style.display = "";
		}
	}

	function app_dn_layerClose() {
		document.getElementById("app_dn_layer").style.display = "none";
	}

	function app_dn_layer_carClose() {
		document.getElementById("app_dn_layer_car").style.display = "none";
	}

	function fnSearchEnuri() {
		var sKeyword = $("#enuriKeyword").val();
		if (!sKeyword) {
			alert("검색어를 입력해주세요.");
			$("#enuriKeyword").focus();
			return false;
		} else {
			$("input[name='keyword']").val(sKeyword);
			return true;
		}
	}
	</script>
	<!-- 백화점관 검색 영역 -->
	<div class="dep-search">
		<div class="in-cont">
			<h2><span onclick="goMain();insertLog(11331);setGEventLog('depart_home', 'top', 'top_백화점로고');" style="cursor:pointer;"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/logo_department.png" alt="프리미엄 백화점 최저가 비교 Department Store"/></span></h2>
			<div id="searchWrap">
				<span class="searchForm">
					<form name="fmMainSearch2" method="get" onSubmit="javascript:  return false;">
						<input name="departmentKeyword" id="departmentKeyword" type="text" value="" onfocus="this.className='focus'" class="txt" /><!-- 150730 -->
					</form>
					<a href="javascript:" id="departmentKeywordBtn"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/btn_price_compare.gif" alt="검색" /></a>
				</span>
				<ul class="keyword-list">
				
					<li><a onclick="goTopSearch('선글라스');insertLog(11333);" style="cursor:pointer;">선글라스</a></li>
				
					<li><a onclick="goTopSearch('바람막이 자켓');insertLog(11333);" style="cursor:pointer;">바람막이 자켓</a></li>
				
					<li><a onclick="goTopSearch('쉬즈미스');insertLog(11333);" style="cursor:pointer;">쉬즈미스</a></li>
				
					<li><a onclick="goTopSearch('나이키');insertLog(11333);" style="cursor:pointer;">나이키</a></li>
				
					<li><a onclick="goTopSearch('코치 가방');insertLog(11333);" style="cursor:pointer;">코치 가방</a></li>
				
				</ul>
			</div>
			<ul class="store-banner">
				<li><a target="_blank" href="http://www.lotte.com/coop/affilGate.lotte?chl_no=156324&chl_dtl_no=2949657&returnUrl=/main/viewMain.lotte?dpml_no=2" onclick="insertLog(11338);setGEventLog('depart_home', 'top', 'top_롯데백화점');"><img src="http://imgenuri.enuri.gscdn.com/images/department/view/banner_lotte.gif" alt="롯데백화점"></a></li>
				<li><a target="_blank" href="http://department.ssg.com/main.ssg?ckwhere=s_enuri" onclick="insertLog(11339);setGEventLog('depart_home', 'top', 'top_신세계백화점');"><img src="http://imgenuri.enuri.gscdn.com/images/department/view/banner_ssg.gif" alt="신세계백화점"></a></li>
				<li><a target="_blank" href="http://www.hyundaihmall.com/front/shNetworkShop.do?NetworkShop=Html&ReferCode=022&Url=http://www.hmall.com/front/dsMainR.do" onclick="insertLog(11340);setGEventLog('depart_home', 'top', 'top_현대백화점');"><img src="http://imgenuri.enuri.gscdn.com/images/department/view/banner_hyundai.gif" alt="현대백화점"></a></li>
				<li><a target="_blank" href="http://www.galleria.co.kr/mallmain/initMallMain.do?method=join&channel_id=2763&link_id=0001#none" onclick="insertLog(11341);setGEventLog('depart_home', 'top', 'top_갤러리아백화점');"><img src="http://imgenuri.enuri.gscdn.com/images/department/view/banner_galleria.gif" alt="갤러리아백화점"></a></li>
				<li><a target="_blank" href="http://www.akmall.com/assc/assc_conv.jsp?assc_comp_id=12189&url=http://www.akmall.com/akplaza/AKPlazaMain.do?urlpath=A_03_02@1" onclick="insertLog(11342);setGEventLog('depart_home', 'top', 'top_AK플라자');"><img src="http://imgenuri.enuri.gscdn.com/images/department/view/banner_ak.gif" alt="AK플라자"></a></li>
			</ul>
		</div>
	</div>
	<!-- GNB -->
	<div id="gnb">
		<div class="menu">
			<!-- 대메뉴 top-wrap -->
			<ul class="depth-top">
				<li class="category on">
					<a href="#" onclick="insertLog(11343);setGEventLog('depart_home', 'tab', 'top_카테고리');" class="quick-link "><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/gnb_top01.gif" alt="카테고리"></a>
					<ul class="mid-list">
						<li class="first"><em class="mid-tit"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/menu_mid01.gif" alt="화장품/잡화"></em>
							<ul class="depth-mid">
								<li id="8601"><a href="#n" onclick="insertLog(11343);categoryMigGLog(this);"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/menu_mid0101.gif" alt="명품화장품"></a></li>
								<!-- <li><a href="#"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/menu_mid0102.gif" alt="국내화장품"></a></li>-->
								<li id="8602"><a href="#n" onclick="insertLog(11343);categoryMigGLog(this);"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/menu_mid0103.gif" alt="패션잡화"></a></li>
								<li id="8603"><a href="#n" onclick="insertLog(11343);categoryMigGLog(this);"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/menu_mid0104.gif" alt="패션슈즈"></a></li>
								<li id="8614"><a href="#n" onclick="insertLog(11343);categoryMigGLog(this);"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/menu_mid_acc.gif" alt="시계/주얼리/ACC"></a></li>
							</ul>
						</li>
						<li><em class="mid-tit"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/menu_mid02.gif" alt="여성패션"></em>
							<ul class="depth-mid">
								<li id="8604"><a href="#n" onclick="insertLog(11343);categoryMigGLog(this);"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/menu_mid0201.gif" alt="영캐주얼"></a></li>
								<li id="8605"><a href="#n" onclick="insertLog(11343);categoryMigGLog(this);"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/menu_mid0202.gif" alt="여성캐릭터/커리어"></a></li>
							</ul>
						</li>
						<li><em class="mid-tit"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/menu_mid03.gif" alt="남성패션"></em>
							<ul class="depth-mid">
								<li id="8609"><a href="#n" onclick="insertLog(11343);categoryMigGLog(this);"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/menu_mid0301.gif" alt="남성정장/셔츠"></a></li>
								<li id="8610"><a href="#n" onclick="insertLog(11343);categoryMigGLog(this);"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/menu_mid0302.gif" alt="남성캐주얼"></a></li>
							</ul>
						</li>
						<li><em class="mid-tit"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/menu_mid04.gif" alt="유니섹스/스포츠"></em>
							<ul class="depth-mid">
								<li id="8606"><a href="#n" onclick="insertLog(11343);categoryMigGLog(this);"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/menu_mid0401.gif" alt="진/유니섹스"></a></li>
								<li id="8607"><a href="#n" onclick="insertLog(11343);categoryMigGLog(this);"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/menu_mid0402.gif" alt="언더웨어"></a></li>
								<li id="8608"><a href="#n" onclick="insertLog(11343);categoryMigGLog(this);"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/menu_mid0403.gif" alt="스포츠/레저"></a></li>
							</ul>
						</li>
						<li class="end"><em class="mid-tit"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/menu_mid05.gif" alt="유아동/생활"></em>
							<ul class="depth-mid">
								<li id="8611"><a href="#n" onclick="insertLog(11343);categoryMigGLog(this);"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/menu_mid0501.gif" alt="유아동/용품"></a></li>
								<li id="8612"><a href="#n" onclick="insertLog(11343);categoryMigGLog(this);"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/menu_mid0502.gif" alt="생활/가구"></a></li>
								<li id="8613"><a href="#n" onclick="insertLog(11343);categoryMigGLog(this);"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/menu_mid0503.gif" alt="식품"></a></li>
							</ul>
						</li>
					</ul>
					<div id="subMenu"><!-- 메뉴에 마우스 올릴시 json 로드 후 출력--></div>
				</li>
				<li class="top-item">
					<a href="brand_main.jsp" onclick="insertLog(11357);setGEventLog('depart_home', 'tab', 'top_브랜드');" class="quick-link "><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/gnb_top02.gif" alt="브랜드"></a>
				</li>
				<li class="top-item">
					<a href="luxury.jsp" onclick="insertLog(11358);setGEventLog('depart_home', 'tab', 'top_해외명품');" class="quick-link "><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/gnb_top03.gif" alt="해외명품"></a>
				</li>
				<li class="top-item">
					<a href="best.jsp" onclick="insertLog(11359);setGEventLog('depart_home', 'tab', 'top_백화점Best');" class="quick-link "><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/gnb_top04.gif" alt="백화점"></a>
				</li>
			</ul>
		</div>
	</div>
</div>
<script language=javascript src="http://imgenuri.enuri.gscdn.com/common/js/Log_Header.js"></script>
<script id="subMenuTemplate" type="x-tmpl-mustache">
	<li><a href='/department/goods_list.jsp?ca_code={{code}}' onclick='insertLog(11343);categorySigGLog(this);'>{{title}}</a></li>
</script>
<script language="JavaScript"> 
<!-- 
function categorySigGLog(thisObj) {
	var scateName = $(thisObj).text();

	// 구글 분석기 로그
	try {
		setGEventLog("depart_Category", "소", "cate_"+scateName);
	} catch(e) {}
}

function categoryMigGLog(thisObj) {
	var parentObj = $(thisObj).parent();
	var mcateName = parentObj.find("img").attr("alt");

	// 구글 분석기 로그
	try {
		setGEventLog("depart_Category", "중", "cate_"+mcateName);
	} catch(e) {}
}

function goTopSearch(keyword){
	location.href="/department/search.jsp?keyword="+escape(keyword);

	// 구글 분석기 로그
	try {
		setGEventLog("depart_Keyword", "Keyword", "Keyword_"+$("#keyword2").val());
	} catch(e) {}
}
function bluring(){ 
 if(event.srcElement.tagName=="A"||event.srcElement.tagName=="IMG") document.body.focus(); 
 } 
 document.onfocusin=bluring; 
 // --> 
</script>
	<!------------------------- header end  ----------------------------->
	<div id="container">
		<!-- 기획전 배너 -->
		<div class="promotion-banner">
			<ul class="viewport">
				
					<li class="on"><a href="http://www.akmall.com/planshop/PlanShopView.do?urlpath=A_14%408&shop_event_id=1001156" onclick="insertLog(11367);setGEventLog('depart_home', 'top', 'top_기획전');" target="_blank"><img src="http://storage.enuri.gscdn.com/pic_upload/depart_plan/plan_3_90_20150406103023.jpg" alt="지니킴&박수진 콜라보레이션 최대 15% off"/></a></li>
				
					<li ><a href="http://www.hyundaihmall.com/front/dpa/searchSpexSectItem.do?sectId=1392925&ReferCode=022" onclick="insertLog(11367);setGEventLog('depart_home', 'top', 'top_기획전');" target="_blank"><img src="http://storage.enuri.gscdn.com/pic_upload/depart_plan/plan_5_57_20150406102853.jpg" alt="LF패션 패빌리 룩 세일!"/></a></li>
				
					<li ><a href="http://www.galleria.co.kr/shop/viewShopDetail.do?shop_id=140394" onclick="insertLog(11367);setGEventLog('depart_home', 'top', 'top_기획전');" target="_blank"><img src="http://storage.enuri.gscdn.com/pic_upload/depart_plan/plan_6_6620_20150406103148.jpg" alt="타미 VS 헤지스 신상품 기획전"/></a></li>
				
			</ul>
			<div class="indicators">
				
					<a href="http://www.akmall.com/planshop/PlanShopView.do?urlpath=A_14%408&shop_event_id=1001156" class="on">j+1</a>
				
					<a href="http://www.hyundaihmall.com/front/dpa/searchSpexSectItem.do?sectId=1392925&ReferCode=022" >j+1</a>
				
					<a href="http://www.galleria.co.kr/shop/viewShopDetail.do?shop_id=140394" >j+1</a>
				
			</div>
		</div>



		<!-- 150413 세일 -->
		<div class="salezone">
			<h3 class="spring_sale">봄 맞이 백화점 세일! 세일 브랜드의 최저가를 한번 더 비교!</h3>
			<ul class="tabs">
				<li class="on"><a href="#"><span>패션잡화</span></a></li>
				<li><a href="#"><span>패션슈즈</span></a></li>
				<li><a href="#"><span>여성패션</span></a></li>
				<li><a href="#"><span>남성패션</span></a></li>
				<li><a href="#"><span>유니섹스/스포츠</span></a></li>
			</ul>
			<ul class="sale_list">
				<li class="s01"><a href="#">DAKS 닥스핸드백 Lovely SALE</a></li>
				<li class="s02"><a href="#">METROCITY 핸드백, 지갑 품목할인</a></li>
				<li class="s03"><a href="#">SISLEY 봄에 함께하고 싶은 Bag</a></li>
				<li class="s04"><a href="#">BEANPOLE LUCKY SALE</a></li>
				<li class="s05"><a href="#">BRUNOMAGLI 드라마속 IT Item</a></li>
				<li class="s06"><a href="#">HAZZYS UP TO 20% SALE</a></li>
			</ul>
		</div>
		<!--// 150413 세일 -->



		<h3 class="mtit"><img src="http://imgenuri.enuri.gscdn.com/images/department/view/tit_best_sellers.gif" alt="MD Pick 국내 백화점 최고의 인기상품"/></h3>
		<!-- 베스트상품 -->
		




 

<script type="text/javascript" src="/department/js/common.js"></script>
 
<div class="best-seller-wrap">
	<ul class="tabs">
		
		<li class="on"><a href="#" onclick="insertLog(11370);setGEventLog('depart_home', 'body', 'body_MDPick_화장품/잡화');"><span>화장품/잡화</span></a></li>
		
		<li ><a href="#" onclick="insertLog(11371);setGEventLog('depart_home', 'body', 'body_MDPick_여성패션');"><span>여성패션</span></a></li>
		
		<li ><a href="#" onclick="insertLog(11372);setGEventLog('depart_home', 'body', 'body_MDPick_남성패션');"><span>남성패션</span></a></li>
		
		<li ><a href="#" onclick="insertLog(11373);setGEventLog('depart_home', 'body', 'body_MDPick_유니섹스/스포츠');"><span>유니섹스/스포츠</span></a></li>
		
		<li ><a href="#" onclick="insertLog(11374);setGEventLog('depart_home', 'body', 'body_MDPick_유아동/생활');"><span>유아동/생활</span></a></li>
		
	</ul>
	<ul class="product-list">
		
			<li><a href="javascript:goDetail(12015185,86021502);insertLog(11375);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="12015185" src="http://storage.enuri.gscdn.com/pic_upload/depart_best/depart_12015185.JPG" alt=""/></span>
					<em class="subject">[엘르]  레이스그리드 스카프_SE519X311</em>
					<div class="Tier">
						<span class="p">가격비교 (2)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">GS SHOP</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_5.gif"/></span>
						<span class="price-wrap ">
							<span>27,070<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">25,670</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(12027361,86020106);insertLog(11375);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="12027361" src="http://photo3.enuri.com/data/images/service/d_middle/12000000/12020000/12027361.jpg" alt=""/></span>
					<em class="subject">[시슬리]  카일 쇼퍼백</em>
					<div class="Tier">
						<span class="p">가격비교 (40)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">GS SHOP</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_2.gif"/></span>
						<span class="price-wrap ">
							<span>283,370<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">171,350</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(11993827,86010107);insertLog(11375);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="11993827" src="http://photo3.enuri.com/data/images/service/d_middle/11900000/11990000/11993827.jpg" alt=""/></span>
					<em class="subject">[에스티로더] 크레센트 화이트 UV 프로텍터</em>
					<div class="Tier">
						<span class="p">가격비교 (5)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">롯데닷컴</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_2.gif"/></span>
						<span class="price-wrap ">
							<span>58,900<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">51,900</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(11791430,86030202);insertLog(11375);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="11791430" src="http://photo3.enuri.com/data/images/service/d_middle/11700000/11790000/11791430.jpg" alt=""/></span>
					<em class="subject">[탠디]  남성 캐주얼화</em>
					<div class="Tier">
						<span class="p">가격비교 (68)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">CJmall</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_2.gif"/></span>
						<span class="price-wrap ">
							<span>110,650<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">97,280</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(11276949,86020101);insertLog(11375);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="11276949" src="http://photo3.enuri.com/data/images/service/d_middle/11200000/11270000/11276949.jpg" alt=""/></span>
					<em class="subject">[쿠론 <span class=fif>코오롱</span>]  스테파니 M 토트겸 숄더백</em>
					<div class="Tier">
						<span class="p">가격비교 (18)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">CJmall</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_5.gif"/></span>
						<span class="price-wrap ">
							<span>271,310<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">190,510</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(12023161,86020501);insertLog(11375);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="12023161" src="http://photo3.enuri.com/data/images/service/d_middle/12000000/12020000/12023161.jpg" alt=""/></span>
					<em class="subject">[헤지스 <span class=fif>LF</span>]  핑크 다이아엠보 여성 장지갑</em>
					<div class="Tier">
						<span class="p">가격비교 (21)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">AKmall</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_3.gif"/></span>
						<span class="price-wrap ">
							<span>169,290<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">115,320</em>원</span>
						</span>
					</span>
			</a></li>
		
	</ul>
</div>
 
<div class="best-seller-wrap">
	<ul class="tabs">
		
		<li ><a href="#" onclick="insertLog(11370);setGEventLog('depart_home', 'body', 'body_MDPick_화장품/잡화');"><span>화장품/잡화</span></a></li>
		
		<li class="on"><a href="#" onclick="insertLog(11371);setGEventLog('depart_home', 'body', 'body_MDPick_여성패션');"><span>여성패션</span></a></li>
		
		<li ><a href="#" onclick="insertLog(11372);setGEventLog('depart_home', 'body', 'body_MDPick_남성패션');"><span>남성패션</span></a></li>
		
		<li ><a href="#" onclick="insertLog(11373);setGEventLog('depart_home', 'body', 'body_MDPick_유니섹스/스포츠');"><span>유니섹스/스포츠</span></a></li>
		
		<li ><a href="#" onclick="insertLog(11374);setGEventLog('depart_home', 'body', 'body_MDPick_유아동/생활');"><span>유아동/생활</span></a></li>
		
	</ul>
	<ul class="product-list">
		
			<li><a href="javascript:goDetail(12068358,86040501);insertLog(11376);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="12068358" src="http://photo3.enuri.com/data/images/service/d_middle/12000000/12060000/12068358.jpg" alt=""/></span>
					<em class="subject">[르샵]  플라워 프린트 원피스</em>
					<div class="Tier">
						<span class="p">가격비교 (36)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">GS SHOP</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_2.gif"/></span>
						<span class="price-wrap ">
							<span>56,050<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">42,800</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(10994691,86040301);insertLog(11376);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="10994691" src="http://photo3.enuri.com/data/images/service/d_middle/10900000/10990000/10994691.jpg" alt=""/></span>
					<em class="subject">[JnB]  비비드 컬러 포인트 변형 니트</em>
					<div class="Tier">
						<span class="p">가격비교 (12)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">엘롯데</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_2.gif"/></span>
						<span class="price-wrap ">
							<span>19,000<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">17,670</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(10602288,86041002);insertLog(11376);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="10602288" src="http://photo3.enuri.com/data/images/service/d_middle/10600000/10600000/10602288.jpg" alt=""/></span>
					<em class="subject">[ZOOC]  지퍼여밈 캐주얼 트렌치코트</em>
					<div class="Tier">
						<span class="p">가격비교 (6)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">nsmall</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_3.gif"/></span>
						<span class="price-wrap ">
							<span>306,945<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">47,200</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(12036301,86041002);insertLog(11376);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="12036301" src="http://photo3.enuri.com/data/images/service/d_middle/12000000/12030000/12036301.jpg" alt=""/></span>
					<em class="subject">[Ab.f.z]  다양한 컬러감의 기본 트렌치코트</em>
					<div class="Tier">
						<span class="p">가격비교 (16)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">CJmall</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_5.gif"/></span>
						<span class="price-wrap ">
							<span>107,980<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">67,640</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(11990393,86040401);insertLog(11376);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="11990393" src="http://photo3.enuri.com/data/images/service/d_middle/11900000/11990000/11990393.jpg" alt=""/></span>
					<em class="subject">[보니알렉스]  와플 숄 롱 가디건</em>
					<div class="Tier">
						<span class="p">가격비교 (17)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">AKmall</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_3.gif"/></span>
						<span class="price-wrap ">
							<span>91,140<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">52,130</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(12036248,86040600);insertLog(11376);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="12036248" src="http://photo3.enuri.com/data/images/service/d_middle/12000000/12030000/12036248.jpg" alt=""/></span>
					<em class="subject">[나이스클랍]  칼라믹스 숏팬츠</em>
					<div class="Tier">
						<span class="p">가격비교 (36)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">GS SHOP</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_2.gif"/></span>
						<span class="price-wrap ">
							<span>171,400<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">131,520</em>원</span>
						</span>
					</span>
			</a></li>
		
	</ul>
</div>
 
<div class="best-seller-wrap">
	<ul class="tabs">
		
		<li ><a href="#" onclick="insertLog(11370);setGEventLog('depart_home', 'body', 'body_MDPick_화장품/잡화');"><span>화장품/잡화</span></a></li>
		
		<li ><a href="#" onclick="insertLog(11371);setGEventLog('depart_home', 'body', 'body_MDPick_여성패션');"><span>여성패션</span></a></li>
		
		<li class="on"><a href="#" onclick="insertLog(11372);setGEventLog('depart_home', 'body', 'body_MDPick_남성패션');"><span>남성패션</span></a></li>
		
		<li ><a href="#" onclick="insertLog(11373);setGEventLog('depart_home', 'body', 'body_MDPick_유니섹스/스포츠');"><span>유니섹스/스포츠</span></a></li>
		
		<li ><a href="#" onclick="insertLog(11374);setGEventLog('depart_home', 'body', 'body_MDPick_유아동/생활');"><span>유아동/생활</span></a></li>
		
	</ul>
	<ul class="product-list">
		
			<li><a href="javascript:goDetail(12048053,86090600);insertLog(11377);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="12048053" src="http://photo3.enuri.com/data/images/service/d_middle/12000000/12040000/12048053.jpg" alt=""/></span>
					<em class="subject">[레노마]  춘하 라이트블루 캐주얼 자켓</em>
					<div class="Tier">
						<span class="p">가격비교 (7)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">nsmall</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_3.gif"/></span>
						<span class="price-wrap ">
							<span>98,560<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">90,720</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(11937215,86090101);insertLog(11377);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="11937215" src="http://photo3.enuri.com/data/images/service/d_middle/11900000/11930000/11937215.jpg" alt=""/></span>
					<em class="subject">[티아이포맨]  서울 라이트 멜란지 티셔츠</em>
					<div class="Tier">
						<span class="p">가격비교 (12)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">신세계몰</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_1.gif"/></span>
						<span class="price-wrap ">
							<span>93,860<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">79,253</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(11301597,86090301);insertLog(11377);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="11301597" src="http://photo3.enuri.com/data/images/service/d_middle/11300000/11300000/11301597.jpg" alt=""/></span>
					<em class="subject">[헨리코튼]  포인트 컬러 라운드 니트</em>
					<div class="Tier">
						<span class="p">가격비교 (6)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">신세계몰</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_1.gif"/></span>
						<span class="price-wrap ">
							<span>102,030<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">58,995</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(9921994,86090803);insertLog(11377);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="9921994" src="http://photo3.enuri.com/data/images/service/d_middle/9900000/9920000/9921994.jpg" alt=""/></span>
					<em class="subject">[BON]  면스판 네이비 베이지 2컬러 슬림 팬츠</em>
					<div class="Tier">
						<span class="p">가격비교 (2)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">신세계몰</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_1.gif"/></span>
						<span class="price-wrap none">
							<span></span><br/>
							<span class="min">최저가 <em class="num">51,566</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(12078489,86100101);insertLog(11377);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="12078489" src="http://photo3.enuri.com/data/images/service/d_middle/12000000/12070000/12078489.jpg" alt=""/></span>
					<em class="subject">[제스]  춘하 차콜 그레이 정장</em>
					<div class="Tier">
						<span class="p">가격비교 (5)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">nsmall</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_3.gif"/></span>
						<span class="price-wrap ">
							<span>96,800<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">89,100</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(12066900,86090600);insertLog(11377);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="12066900" src="http://photo3.enuri.com/data/images/service/d_middle/12000000/12060000/12066900.jpg" alt=""/></span>
					<em class="subject">[엠비오 <span class=fif>제일모직</span>]  핑크 도트 자카드 2버튼 자켓</em>
					<div class="Tier">
						<span class="p">가격비교 (12)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">AKmall</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_3.gif"/></span>
						<span class="price-wrap ">
							<span>324,090<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">241,100</em>원</span>
						</span>
					</span>
			</a></li>
		
	</ul>
</div>
 
<div class="best-seller-wrap">
	<ul class="tabs">
		
		<li ><a href="#" onclick="insertLog(11370);setGEventLog('depart_home', 'body', 'body_MDPick_화장품/잡화');"><span>화장품/잡화</span></a></li>
		
		<li ><a href="#" onclick="insertLog(11371);setGEventLog('depart_home', 'body', 'body_MDPick_여성패션');"><span>여성패션</span></a></li>
		
		<li ><a href="#" onclick="insertLog(11372);setGEventLog('depart_home', 'body', 'body_MDPick_남성패션');"><span>남성패션</span></a></li>
		
		<li class="on"><a href="#" onclick="insertLog(11373);setGEventLog('depart_home', 'body', 'body_MDPick_유니섹스/스포츠');"><span>유니섹스/스포츠</span></a></li>
		
		<li ><a href="#" onclick="insertLog(11374);setGEventLog('depart_home', 'body', 'body_MDPick_유아동/생활');"><span>유아동/생활</span></a></li>
		
	</ul>
	<ul class="product-list">
		
			<li><a href="javascript:goDetail(10963901,86060401);insertLog(11378);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="10963901" src="http://photo3.enuri.com/data/images/service/d_middle/10900000/10960000/10963901.jpg" alt=""/></span>
					<em class="subject">[엠폴햄]  베이직 후드 집업 캐주얼 가디건</em>
					<div class="Tier">
						<span class="p">가격비교 (18)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">롯데닷컴</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_2.gif"/></span>
						<span class="price-wrap ">
							<span>34,750<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">8,370</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(10903780,86080601);insertLog(11378);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="10903780" src="http://photo3.enuri.com/data/images/service/d_middle/10900000/10900000/10903780.jpg" alt=""/></span>
					<em class="subject">[K2] 남성 워킹화</em>
					<div class="Tier">
						<span class="p">가격비교 (16)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">엘롯데</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_2.gif"/></span>
						<span class="price-wrap ">
							<span>227,050<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">121,550</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(11443878,86060704);insertLog(11378);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="11443878" src="http://photo3.enuri.com/data/images/service/d_middle/11400000/11440000/11443878.jpg" alt=""/></span>
					<em class="subject">[앤듀]  여성 워싱 구제 보이프렌트핏 데님 팬츠</em>
					<div class="Tier">
						<span class="p">가격비교 (13)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">AKmall</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_3.gif"/></span>
						<span class="price-wrap ">
							<span>76,090<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">30,180</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(11673087,86080501);insertLog(11378);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="11673087" src="http://photo3.enuri.com/data/images/service/d_middle/11600000/11670000/11673087.jpg" alt=""/></span>
					<em class="subject">[디스커버리] 남성 컬러 배색 캐주얼 자켓</em>
					<div class="Tier">
						<span class="p">가격비교 (13)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">신세계몰</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_1.gif"/></span>
						<span class="price-wrap ">
							<span>190,000<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">102,885</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(11955827,86080210);insertLog(11378);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="11955827" src="http://photo3.enuri.com/data/images/service/d_middle/11900000/11950000/11955827.jpg" alt=""/></span>
					<em class="subject">[나이키] 우먼스 줌 윈플로</em>
					<div class="Tier">
						<span class="p">가격비교 (5)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">AKmall</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_3.gif"/></span>
						<span class="price-wrap ">
							<span>77,210<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">62,370</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(12000578,86080504);insertLog(11378);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="12000578" src="http://photo3.enuri.com/data/images/service/d_middle/12000000/12000000/12000578.jpg" alt=""/></span>
					<em class="subject">[블랙야크] 남성 익스트림 슬림핏 팬츠</em>
					<div class="Tier">
						<span class="p">가격비교 (17)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">AKmall</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_3.gif"/></span>
						<span class="price-wrap ">
							<span>145,000<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">131,950</em>원</span>
						</span>
					</span>
			</a></li>
		
	</ul>
</div>
 
<div class="best-seller-wrap">
	<ul class="tabs">
		
		<li ><a href="#" onclick="insertLog(11370);setGEventLog('depart_home', 'body', 'body_MDPick_화장품/잡화');"><span>화장품/잡화</span></a></li>
		
		<li ><a href="#" onclick="insertLog(11371);setGEventLog('depart_home', 'body', 'body_MDPick_여성패션');"><span>여성패션</span></a></li>
		
		<li ><a href="#" onclick="insertLog(11372);setGEventLog('depart_home', 'body', 'body_MDPick_남성패션');"><span>남성패션</span></a></li>
		
		<li ><a href="#" onclick="insertLog(11373);setGEventLog('depart_home', 'body', 'body_MDPick_유니섹스/스포츠');"><span>유니섹스/스포츠</span></a></li>
		
		<li class="on"><a href="#" onclick="insertLog(11374);setGEventLog('depart_home', 'body', 'body_MDPick_유아동/생활');"><span>유아동/생활</span></a></li>
		
	</ul>
	<ul class="product-list">
		
			<li><a href="javascript:goDetail(11542136,86110401);insertLog(11379);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="11542136" src="http://photo3.enuri.com/data/images/service/d_middle/11500000/11540000/11542136.jpg" alt=""/></span>
					<em class="subject">[섀르반 <span class=fif>제로투세븐</span>] 섀르반 배색하프점퍼</em>
					<div class="Tier">
						<span class="p">가격비교 (11)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">AKmall</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_3.gif"/></span>
						<span class="price-wrap ">
							<span>69,000<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">56,520</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(11539558,86110401);insertLog(11379);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="11539558" src="http://photo3.enuri.com/data/images/service/d_middle/11500000/11530000/11539558.jpg" alt=""/></span>
					<em class="subject">[블랙야크] 키즈 바람막이 자켓</em>
					<div class="Tier">
						<span class="p">가격비교 (10)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">GS SHOP</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_5.gif"/></span>
						<span class="price-wrap ">
							<span>84,550<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">56,830</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(12080151,86120603);insertLog(11379);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="12080151" src="http://photo3.enuri.com/data/images/service/d_middle/12000000/12080000/12080151.jpg" alt=""/></span>
					<em class="subject">[박홍근홈패션] 페이버 워싱 60수 아사면 누비이불</em>
					<div class="Tier">
						<span class="p">가격비교 (4)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">엘롯데</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_2.gif"/></span>
						<span class="price-wrap ">
							<span>74,090<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">53,100</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(8235178,86130101);insertLog(11379);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="8235178" src="http://photo3.enuri.com/data/images/service/d_middle/8200000/8230000/8235178.jpg" alt=""/></span>
					<em class="subject">[한국인삼공사] 정관장 홍이장군 2단계 키즈</em>
					<div class="Tier">
						<span class="p">가격비교 (6)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">현대Hmall</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_5.gif"/></span>
						<span class="price-wrap ">
							<span>93,000<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">88,350</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(11918995,86120406);insertLog(11379);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="11918995" src="http://photo3.enuri.com/data/images/service/d_middle/11900000/11910000/11918995.jpg" alt=""/></span>
					<em class="subject">[웨지우드] 사라스가든 1인 홈세트E</em>
					<div class="Tier">
						<span class="p">가격비교 (10)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">AKmall</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_3.gif"/></span>
						<span class="price-wrap ">
							<span>206,780<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">143,500</em>원</span>
						</span>
					</span>
			</a></li>
		
			<li><a href="javascript:goDetail(7899093,86120410);insertLog(11379);setGEventLog('depart_home', 'body', 'body_MDPick상품');">
					<span class="thumb"><img id="7899093" src="http://photo3.enuri.com/data/images/service/d_middle/7800000/7890000/7899093.jpg" alt=""/></span>
					<em class="subject">[포트메리온] 보타닉가든 케이크스탠드</em>
					<div class="Tier">
						<span class="p">가격비교 (8)</span>
						
					</div>
					<span class="pr-info">
						<span class="brand"><em class="mallname">옥션</em><img src="http://imgenuri.enuri.gscdn.com/images/department/common/dept_2.gif"/></span>
						<span class="price-wrap ">
							<span>62,622<span>원</span></span><br/>
							<span class="min">최저가 <em class="num">53,480</em>원</span>
						</span>
					</span>
			</a></li>
		
	</ul>
</div>

		<!-- 베스트상품 END -->
		<!-- 최근본상품 -->
			
<div id="quickMenu">
	
    <div class="wingban">
		<a href="JavaScript:" onclick="wing_click();"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/wingbn_sale.jpg" alt="각 백화점 매장에서 직접배송 합니다."></a><!-- 150413 세일 -->
	</div>
   
	<div class="wrap">
		<h4><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/stit_shop_history.gif" alt="최근본상품"/></h4>
		<div class="viewport">
			<ul>
			</ul>
		</div>
		<div class="paging">
			<a href="#" onclick="insertLog(11364);"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/btn_history_down.gif" alt="다음"/></a><a href="#" onclick="insertLog(11364);"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/btn_history_up.gif" alt="이전"/></a>
		</div>			
	</div>
	
	<a href="#" onclick="insertLog(11365);" class="btn-top"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/btn_top.gif" alt="TOP"/></a>
	
	<!-- 150715 불편오류신고 -->
	<div class="report_area">
		<span class="report" onclick="onoff('reportLayer')">불편오류신고</span>
		<div class="singo" id="reportLayer" style="display:none;">
			<a href="#n" class="btn_close" onclick="onoff('reportLayer')">닫기</a>
			<h2>불편오류신고</h2>
			<div class="singo_content">
				<p class="category"><span>백화점비교</span><span>백화점비교</span>메인</p><!-- 메인, lp, srp -->
				<p class="category">[율미아스탭] 레이스 밴딩 스커트</p><!-- vip 상품영역 -->
				<p class="category"><em>롯데백화점(엘롯데)</em>[율미아스탭] 레이스 밴딩 스커트</p><!-- vip 가격비교영역 -->

				<dl class="first">	
					<dt>신고항목</dt>
					<dd><label><input type="radio" name="radio" />가격표기 오류</label></dd>
					<dd><label><input type="radio" name="radio" />카테고리 오류</label></dd>
					<dd><label><input type="radio" name="radio" />품절상품</label></dd>
					<dd><label><input type="radio" name="radio" />페이지 오류<span>(이미지/텍스트 깨짐)</span></label></dd>
					<dd><label><input type="radio" name="radio" />기타</label></dd>
				</dl>
				<dl>	
					<dt>신고내용</dt>
					<dd><textarea onfocus="this.className='focus'"></textarea></dd>
				</dl>
				<dl class="mail">	
					<dt>답변알림</dt>
					<dd>
						<p>이메일을 입력하시면 처리결과 및 답변을 받으실 수 있습니다.</p>
						<label><input type="checkbox" name="checkbox" />처리결과를 이메일로 받겠습니다.</label>
						<input type="text" name="text" class="mail_chk" onfocus="this.className='main_focus'" />
					</dd>
				</dl>
			</div>

			<div class="singo_btn">
				<button type="button" class="submit">등록</button><button type="button" class="cancel">취소</button>
			</div>
		</div>
	</div>
	<!--// 150715 불편오류신고 -->
	
	<!-- 150806 기획전배너 -->
	<div class="wing">
		<a href="http://www.enuri.com/department/plan_list.jsp" target="_new" ><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/wingbn02.gif" alt="SUMMER SALE"></a>
	</div>
	<!--// 150806 기획전배너 -->

</div>

<script>
var _quickTop = "";
(function(){
	quick();
	function getCookie(c_name) {
		var i,x,y,ARRcookies=document.cookie.split(";");
		for(i=0;i<ARRcookies.length;i++) {
			x = ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
			y = ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
			x = x.replace(/^\s+|\s+$/g,"");
			if(x==c_name) {
				return unescape(y);
			}
		}
	}
	
	function quick(){
		var url = "./ajax/quick_ajax.jsp?departmentResentList=" + getCookie("departmentResentList");

		// 메인페이지와 다른 목록의 최근본 상품의 절대 위치가 미묘하게 틀림
		try {
			var nowScrollTop = (document.documentElement && document.documentElement.scrollTop) || document.body.scrollTop;
			var continerTop = $("#container").offset().top;
			var menuTop = $("#gnb .menu").offset().top;
			var minusTop = menuTop - continerTop;
			var varwingtop = $('#quickMenu').offset().top;
			var popright = $("#gnb .menu").offset().left + 3;
			var menutop = $("#gnb .menu").offset().top;
			if(nowScrollTop<varwingtop) {
				$("#quickMenu").css("top", minusTop+"px");
				$(".main_pop").css("top", menutop+"px");
				$(".main_pop").css("right", popright+"px");
				_quickTop = menutop;
			}else{
				_quickTop = nowScrollTop;
				$(".main_pop").css("top", _quickTop+"px");
			}
		} catch(e) {}

		$.get(url, function(html){
			$("#quickMenu ul").empty().append($.trim(html));
			var vartop = $('#header').height() -($('#container').offset().top +$('.menu').height());
			$('#quickMenu').quickMenu({
				ajaxLoad: false,
				viewMenu : 5,
				start : vartop,
				min : $('#container').offset().top,
				max : $('#footer').offset().top,
				selectors: {
					items : '.viewport li',
					prevBtn : '.paging a:eq(1)',
					nextBtn : '.paging a:eq(0)'
				}
			});	
			
			$('.viewport').find('.thumb img').each(function(){
			  $(this).error(function(){
			    $(this).unbind('error');
			    $(this).attr("src", "http://imgenuri.enuri.gscdn.com/images/department/common/goods_default_100.gif");
			    //alert("no image");
			  });
			});	
		}); 
		
	}
	
	/*function quickset(){
		$('#quickMenu').quickMenu({
				ajaxLoad: false,
				viewMenu : 5,
				min : $('#container').offset().top,
				max : $('#footer').offset().top,
				selectors: {
					items : '.viewport li',
					prevBtn : '.paging a:eq(1)',
					nextBtn : '.paging a:eq(0)'
				}
		});
	}
	
	setInterval(quickset,1000);*/
	

})();
</script>
		<!-- 최근본상품 end -->
	</div>
	
	<!-- 에누리 Footer -->
	
<!-- 에누리 Footer -->
<div id="section9">
	<div class="linkItem"><span onclick="JavaScript:CmdLink('/etc/enuri_intro/Enuriintro.jsp');insertLog(1059);">회사소개</span></div>
	<div class="linkItem"><span onclick="JavaScript:CmdLink('/sdul/mallregister/SellerMain.jsp?sm=4&amp;guide=3');insertLog(1060);">광고안내</span></div>
	<div class="linkItem"><span onclick="JavaScript:CmdLink('/etc/provision.jsp');insertLog(1058);">이용약관</span></div>
	<div class="linkItem"><span onclick="JavaScript:CmdLink('/etc/Secure.jsp');insertLog(1063);"><b>개인정보취급방침</b></span></div>
	<div class="linkItem"><span onclick="JavaScript:CmdLink('/etc/Duty.jsp');insertLog(1064);">법적고지</span></div>
	<div class="linkItem"><span onclick="JavaScript:CmdLink('/view/mallsearch/Listmall.jsp');insertLog(1065);">쇼핑몰검색</span></div>
	<div class="linkItem"><span><a href="/faq/Faq_List.jsp">고객센터</a></span></div>
</div>
<div id="footer">
	<div class="footInner">
		<p class="footLogo"><a href="/"><img src="http://imgenuri.enuri.gscdn.com/images/department/layout/bg_foot_logo.png" alt="에누리 가격비교" /></a></p>
		<p class="enuriDec">에누리닷컴(주)는 통신판매 정보제공자이며, 상품의 주문/배송/환불에 대한 의무와 책임은 각 쇼핑몰에 있습니다.</p>
		<address>서울시 종로구 청계천로 85 (관철동) 29층, 에누리닷컴(주)</address><p class="enuriInfo"><span>대표이사 : 최문석</span> <span>사업자등록번호 : 206-81-18164</span> <span>통신판매신고 : 종로통신 제4406호</span><br />
		Tel : 02-6354-3601 <span>Fax : 02-6354-3600</span> <span>문의 : master@enuri.com</span> <a href="#"><img src="http://imgenuri.enuri.gscdn.com/images/layout/btn_faq.gif" alt="문의전클릭" style="cursor:pointer" onClick=window.open('http://www.enuri.com/faq/Faq_List.jsp');></a> <a href="JavaScript:;" onClick="window.open('http://imgenuri.enuri.gscdn.com/html/etc/Noemail_popup.htm','noEmail','width=379,height=245,left=300,top=300')"><img src="http://imgenuri.enuri.gscdn.com/images/layout/btn_no_email.gif" alt="이메일주소 무단수집거부" /></a></p>
		<p class="copyright">Copyright ⓒ eNuri.com Co., Ltd All rights reserved. 법적고지</p>
	</div>
</div>
<!-- //footer -->
<script language=javascript src="http://imgenuri.enuri.gscdn.com/common/js/Log_Tail.js"></script>
<script language="JavaScript"> _TRK_CC=56 </script>
<script>
function CmdLink(url){
    location.href = url;
}
</script>
	<!-- //footer -->
</div>
</style>
<script type="text/javascript">
	insertLog(11366);
	$('.promotion-banner').banner({
		randomInit : true,
		auto : true,
		selectors:{
			items : '.viewport li'
		}
	});
	
	//책임배송레이어
	setTimeout(function () {if($('.main_pop').css("display") != "block"){wing_click()}}, 1000);
	setTimeout(function () {if($('.main_pop').css("display") == "block"){cmd_close()}}, 6000);
</script>	
</body>
</html>