<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
	response.sendRedirect("/event2020/christmas_2020.jsp");
	return;
}
SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMddHHmm");	//오늘 날짜
String strToday = formatter.format(new Date());

String chkId   = ChkNull.chkStr(request.getParameter("chk_id"),"");
String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String userNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK"),"");

Members_Proc members_proc = new Members_Proc();
String userName = members_proc.getUserName(userId);
String userArea = userName;
String strUrl = request.getRequestURI();

if(!userId.equals("")){
    userName = members_proc.getUserName(userId);
    userArea = userName;

    if(userName.equals("")){
        userArea = userNick;
    }
    if(userArea.equals("")){
        userArea = userId;
    }
}

String tab = ChkNull.chkStr(request.getParameter("tab"));
String protab = ChkNull.chkStr(request.getParameter("protab"));
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<meta name="title" content="2020 크리스마스 통합기획전 – 최저가 쇼핑은 에누리">
<meta name="description" content="온 가족 타임특가! 매주 수요일마다 터지는 득템의 기회!">
<meta name="keyword" content="에누리가격비교, 통합기획전, 크리스마스, 연인선물, 크리스마스선물, 산타할아버지">
<meta property="og:title" content="[에누리 가격비교]겨울에누리다!">
<meta property="og:description" content="매주 수요일 타임특가도 만나보세요!">
<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM+ "/images/event/2020/xmas/sns_1200_630.jpg"%>">
<meta name="format-detection" content="telephone=no" />
<title>2020 크리스마스  기획전 - 최저가 쇼핑은 에누리</title>
<!-- 프로모션 공통 CSS (Mobile) -->
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<!-- 프로모션별 커스텀 CSS  -->
<link rel="stylesheet" href="/css/event/y2020/xmas_m.css" type="text/css">
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
<script type="text/javascript" src="/event2016/js/event_common.js"></script>

<script type="text/javascript">
	var userId = "<%=userId%>";
	var tab = "<%=tab%>"; //파라미터 tab
	var username = "<%=userArea%>"; //개인화영역 이름
	var vChkId = "<%=chkId%>";
	var vEvent_page = "<%=strUrl%>"; //경로
	var ssl = "<%=ConfigManager.ENURI_COM_SSL%>";
</script>
</head>
<body>
<div id="eventWrap">

	<%@include file="/mobilefirst/event2020/season_header.jsp" %>

	<!-- T3 이벤트 04 : 추천 상품 영역 -->
	<div id="event04" class="section event_04 pro_itemlist">
		<h2>
			<span class="tx_sm">산타클로스의 동심가득 선물부터 새해준비까지!</span>
			<span class="tx_main">크리스마스를 더욱 포근하게 할 쇼핑 가이드</span>
		</h2>

		<div class="inner">
			<!-- 어린이를 위한 선물 -->
		<div id="prodGroup01" class="item_group item_group_01 scroll">
			<h3>
				<span class="txt_sub">울지 않고 산타를 기다린</span>
				<strong class="txt_tit">어린이를 위한 선물</strong>
			</h3>
			<!-- 탭 -->
			<ul class="pro_tabs">
				<li class="active"><a href="#protab1-1">컴퓨터/게임기</a></li>
				<li><a href="#protab1-2">장난감</a></li>
				<li><a href="#protab1-3">겨울의류</a></li>
			</ul>
			<!-- //탭 -->

			<!-- 템플릿 -->
			<div class="tab_container">
				<!--
					SLICK $(".itemlist")
					3개의 탭 콘텐츠가 있습니다. "tab_content"
					하나의 콘텐츠마다 ul 단위로 한 판(상품6개)씩 움직입니다.
				-->
				<!-- 컴퓨터/게임기 상품-->
				<div id="protab1-1" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="btn_more" href="http://m.enuri.com/m/list.jsp?cate=040823">상품더보기</a>
				</div>
				<!-- //컴퓨터/게임기 상품-->

				<!-- 장난감 상품-->
				<div id="protab1-2" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=101006">상품더보기</a>
				</div>
				<!-- //장난감 상품-->

				<!-- 겨울의류 상품 -->
				<div id="protab1-3" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=101515">상품더보기</a>
				</div>
				<!-- //겨울의류 상품 -->

			</div>
			<!-- //템플릿 -->
		</div>
		<!-- //어린이를 위한 선물 -->

		<!-- 연인을 위한 선물 -->
		<div id="prodGroup02" class="item_group item_group_02 scroll">
			<h3>
				<span class="txt_sub">로맨틱한 연말 이벤트</span>
				<strong class="txt_tit">연인을 위한 선물</strong>
			</h3>
			<!-- 탭 -->
			<ul class="pro_tabs">
				<li class="active"><a href="#protab2-1">패션잡화</a></li>
				<li><a href="#protab2-2">쥬얼리</a></li>
				<li><a href="#protab2-3">향수</a></li>
			</ul>
			<!-- //탭 -->

			<!-- 템플릿 -->
			<div class="tab_container">
				<!-- 패션잡화 상품 -->
				<div id="protab2-1" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="btn_more" href="http://m.enuri.com/m/list.jsp?cate=145614">상품더보기</a>
				</div>
				<!-- //패션잡화 상품 -->

				<!-- 쥬얼리 상품 -->
				<div id="protab2-2" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=1452">상품더보기</a>
				</div>
				<!-- //쥬얼리 상품 -->

				<!-- 향수 상품 -->
				<div id="protab2-3" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=0810">상품더보기</a>
				</div>
				<!-- //향수 상품 -->
			</div>
			<!-- //템플릿 -->
		</div>
		<!-- //연인을 위한 선물 -->

		<!-- 나홀로 집을 위한 아이템 -->
		<div id="prodGroup03" class="item_group item_group_03 scroll">
			<h3>
				<span class="txt_sub">도레미파솔~로세요??</span>
				<strong class="txt_tit">나홀로 집을 위한 아이템</strong>
			</h3>
			<!-- 탭 -->
			<ul class="pro_tabs">
				<li class="active"><a href="#protab3-1">빔프로젝트</a></li>
				<li><a href="#protab3-2">밀키트</a></li>
				<li><a href="#protab3-3">트리장식</a></li>
			</ul>
			<!-- //탭 -->

			<!-- 템플릿 -->
			<div class="tab_container">
				<!-- 빔프로젝트 상품 -->
				<div id="protab3-1" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="btn_more" href="http://m.enuri.com/m/list.jsp?cate=021132">상품더보기</a>
				</div>
				<!-- //빔프로젝트 상품 -->

				<!-- 밀키트 상품 -->
				<div id="protab3-2" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=151112">상품더보기</a>
				</div>
				<!-- //밀키트 상품 -->

				<!-- 트리장식 상품 -->
				<div id="protab3-3" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=164417">상품더보기</a>
				</div>
				<!-- //트리장식 상품 -->
			</div>
			<!-- //템플릿 -->
		</div>
		<!-- //나홀로 집을 위한 아이템 -->

		<!-- E쿠폰 -->
		<div id="prodGroup04" class="item_group item_group_04 scroll">
			<h3>
				<span class="txt_sub">행복한 순간, 더욱 알차게</span>
				<strong class="txt_tit">E쿠폰</strong>
			</h3>
			<!-- 탭 -->
			<ul class="pro_tabs">
				<li class="active"><a href="#protab4-1">외식</a></li>
				<li><a href="#protab4-2">케이크/카페</a></li>
				<li><a href="#protab4-3">호텔</a></li>
			</ul>
			<!-- //탭 -->

			<!-- 템플릿 -->
			<div class="tab_container">
				<!-- 외식 상품 -->
				<div id="protab4-1" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="btn_more" href="http://m.enuri.com/m/list.jsp?cate=16472101">상품더보기</a>
				</div>
				<!-- //외식 상품 -->

				<!-- 케이크/카페 상품 -->
				<div id="protab4-2" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=16472102">상품더보기</a>
				</div>
				<!-- //케이크/카페 상품 -->

				<!-- 호텔 상품 -->
				<div id="protab4-3" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=16472402">상품더보기</a>
				</div>
				<!-- //호텔 상품 -->
			</div>
			<!-- //템플릿 -->
		</div>
		<!-- //E쿠폰 -->

		<!-- 신년준비 -->
		<div id="prodGroup05" class="item_group item_group_05 scroll">
			<h3>
				<span class="txt_sub">아듀 2020년, 헬로 2021년</span>
				<strong class="txt_tit">신년준비</strong>
			</h3>
			<!-- 탭 -->
			<ul class="pro_tabs">
				<li class="active"><a href="#protab5-1">달력/다이어리</a></li>
				<li><a href="#protab5-2">건강식품</a></li>
				<li><a href="#protab5-3">위생용품</a></li>
			</ul>
			<!-- //탭 -->

			<!-- 템플릿 -->
			<div class="tab_container">
				<!-- 달력/다이어리 상품 -->
				<div id="protab5-1" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="btn_more" href="http://m.enuri.com/m/list.jsp?cate=180210">상품더보기</a>
				</div>
				<!-- //달력/다이어리 상품 -->

				<!-- 건강식품 상품 -->
				<div id="protab5-2" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=150101">상품더보기</a>
				</div>
				<!-- //건강식품 상품 -->

				<!-- 위생용품 상품 -->
				<div id="protab5-3" class="tab_content">
					<div class="itemlist">
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
						<ul class="items clearfix">
						</ul>
					</div>
					<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=080613">상품더보기</a>
				</div>
				<!-- //위생용품 상품 -->
			</div>
			<!-- //템플릿 -->
		</div>
		<!-- //신년준비 -->
		</div>
	</div>
	<!-- // -->

	<!-- 에누리 기획전 -->
	<div class="enuriexhibition">
        <div class="inner">
            <h3>에누리 기획전</h3>
            <ul class="exb_list">
                <li><a href="http://m.enuri.com/m/planlist.jsp?t=B_20201109011430" target="_blank">올겨울 핫한 패딩 정보좀요!</a></li>
                <li><a href="http://m.enuri.com/m/planlist.jsp?t=B_20201106101559" target="_blank">난방가전 여기에 다 모았다!</a></li>
                <li><a href="http://m.enuri.com/m/planlist.jsp?t=B_20201013105733" target="_blank">우리집 김장하는 날</a></li>
                <li><a href="http://m.enuri.com/m/planlist.jsp?t=B_20201158913321" target="_blank">의류건조기A to Z</a></li>
                <li><a href="http://m.enuri.com/m/planlist.jsp?t=B_20201201171508" target="_blank">산타 할아버지 장난감주세요!</a></li>
                <li><a href="http://m.enuri.com/m/planlist.jsp?t=B_20201127130613" target="_blank">올해 연말은 홈파티로~</a></li>
                <li><a href="http://m.enuri.com/m/planlist.jsp?t=B_20201127105901" target="_blank">크리스마스 가성비, 심성비 선물추천</a></li>
            </ul>
        </div>
	</div>
	<!-- // -->

	<!-- 공통 : 하단 에누리 혜택 -->
	<div class="otherbene">
        <div class="inner">
            <h3 class="blind">놓칠 수  없는 특별한 혜택, 에누리 혜택</h3>
            <ul class="ben_list">
                <li class="ben_item--01"><a href="http://m.enuri.com/mobilefirst/evt/firstbuy100_event.jsp" target="_blank">첫구매 고객이라면! Welcome 혜택</a></li>
                <li class="ben_item--02"><a href="http://m.enuri.com/mobilefirst/evt/visit_event.jsp" target="_blank">하루라도 농치면 손해 매일100% 당첨</a></li>
                <li class="ben_item--03"><a href="http://m.enuri.com/mobilefirst/evt/smart_benefits.jsp?freetoken=event&tab=2" target="_blank">지금 가전을 구매하면? 최대 적립 10배</a></li>
                <li class="ben_item--04"><a href="javascript:void(0);">아직 끝나지 않은 혜택 더 많은 이벤트</a></li>
            </ul>
        </div>
	</div>
	<!-- // -->

	<!-- //Contents -->

</div>

<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
<script type="text/javascript" src="/js/clipboard.min.js"></script>
<script type="text/javascript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
<script type="text/javascript">
	var cnt = 0;
	var $navHgt = 0;
	var app = getCookie("appYN"); //app인지 여부
	var makeHtml = "";
	var vOs_type = getOsType();

	//탭별 ga로그
	function tabLog(evt,no){
		var index = 0;
		$(evt + ' .pro_tabs li a').click(function(){
			index = $(this).parents().index() + no;
			ga_log(index);
		});
	}

	//더보기 ga로그
	function moreViewLog(evt,no){
		$(evt + ' .tab_container .btn_more').click(function(){
			ga_log(no);
		});
	}

	var isClick = true;
	var sdt = "<%=strToday.substring(0,8) %>";

	function view_moapp(){
		var chrome25;
		var kitkatWebview;
		var uagentLow = navigator.userAgent.toLocaleLowerCase();
		var openAt = new Date;
		var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2020%2Fchristmas_2020.jsp";
		if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
			goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2020/christmas_2020.jsp";
	 		chrome25 = uagentLow.search("chrome") > -1 && navigator.appVersion.match(/Chrome\/\d+.\d+/)[0].split("/")[1] > 25;
			kitkatWebview = uagentLow.indexOf("naver") != -1 || uagentLow.indexOf("daum") != -1;
			setTimeout( function() {
				if (new Date - openAt < 4000) {
					if (uagentLow.search("android") > -1) {
						location.href = "market://details?id=com.enuri.android";
					}
				}
			}, 1000);
			if(uagentLow.search("android") > -1){
				chrome25 = uagentLow.search("chrome") > -1 && navigator.appVersion.match(/Chrome\/\d+.\d+/)[0].split("/")[1] > 25;
				kitkatWebview = uagentLow.indexOf("naver") != -1 || uagentLow.indexOf("daum") != -1;
				if (chrome25 && !kitkatWebview){
					window.open(goApp);
					//location.href = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2020/winter_2020.jsp";
				} else{
					window.open(goApp);
					//location.href = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2020/winter_2020.jsp";
				}
			}
			//location.href = "market://details?id=com.enuri.android";
			//location.href = "intent://#Intent;scheme=enuri;package=com.enuri.android;end";
		}else{
			setTimeout( function() {
				window.open("https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8");
			}, 1000);
			location.href = goApp;
		}
	}

	$(document).ready(function() {
		var oc = '<%=oc%>';
		var tablo = '<%=tab%>';

		// 에누리 기획전 브릿지 ga로그(new)
		$(".exb_list a").click(function(){
			ga_log(37);
		});

		$(".ben_item--04").click(function(){
			var url = (app != "Y" ? "/mobilefirst/index.jsp#evt" : "/mobilefirst/renew/plan.jsp?freetoken=main_tab|event");
			window.open(url);
		});

		//상품 영역
		var loadUrl = "/event/ajax/exhibition_ajax.jsp?exh_id=40";

		$.ajax({
			  dataType : "json"
			, url	   : loadUrl
			, cache : false
			, success  : function(result){
				var banner = result.R;
				var tab = result.T;
				var tabSize = 3; //컨텐츠 별 탭 개수
				var listSize = 4; //노출 상품 개수
				var logNo = [15,20,25,30,35];
				var no = 0;
				var minprice = 0;

				for(var idx = 0; idx < tab.length; idx ++){
					makeHtml = "";
					no = logNo[parseInt(idx/tabSize)];
					$.each(tab[idx].GOODS, function(i,v){
						minprice = (v.MINPRICE == null) ? 0 : v.MINPRICE;

						if((i % listSize) == 0)	makeHtml += "<ul class='items clearfix'>";
						makeHtml += "<li class='item'>";
						makeHtml +=	"	<a href='javascript:void(0);' onclick='itemClick("+v.MODELNO+", "+minprice+"); ga_log("+no+")'>";
						makeHtml +=	"		<span class='thumb'>";
						makeHtml += "			<img src='"+v.GOODS_IMG+"' alt='상품이미지' onerror = 'replaceImg(this);'>";
						if(minprice == 0 || minprice == null) makeHtml += "<span class='soldout'>soldout</span> <!-- 품절시 노출 -->";
						makeHtml +=	"		</span>";
						makeHtml +=	"		<span class='pro_info'>";
						makeHtml +=	"			<span class='pro_name'>"+v.TITLE1+"<br>"+v.TITLE2+"</span>";
						makeHtml +=	"			<span class='price'>";
						makeHtml +=	"				<span class='price_label'>최저가</span>";
						makeHtml +=	"				<em>"+commaNum(minprice)+"</em>";
						makeHtml +=	"				<span class='pro_unit'>원</span>";
						makeHtml +=	"			</span>";
						makeHtml +=	"		</span>";
						makeHtml +=	"	</a>";
						makeHtml += "</li>";
						if(i % listSize == (listSize - 1) || i == tab[idx].GOODS.length) makeHtml += "</ul>";
					});
					$('#protab'+ (parseInt((idx / tabSize) + 1)) + '-' + ((idx % tabSize) + 1) +' .itemlist').html(makeHtml);
				}
			}
			, complete : function(){
				$navHgt = Math.ceil($(".floattab__list").height());

				//상품 슬릭
				prodSlick();

				var vThisUrl =location.href;

				/* if(vThisUrl.indexOf("#event05") > -1 ){
					$('html, body').stop().animate({scrollTop: Math.ceil($('.event_05').offset().top- $(".navtab").outerHeight())}, 0);
				}
*/
				/* if(vThisUrl.indexOf("#prodGroup01") > -1 ){
					$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_01').offset().top- $(".navtab").outerHeight())}, 0);
				}else if(vThisUrl.indexOf("#prodGroup02") > -1 ){
					$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_02').offset().top- $(".navtab").outerHeight())}, 0);
				}else if(vThisUrl.indexOf("#prodGroup03") > -1 ){
					$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_03').offset().top- $(".navtab").outerHeight())}, 0);
				}else if(vThisUrl.indexOf("#prodGroup04") > -1 ){
					$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_04').offset().top- $(".navtab").outerHeight())}, 0);
				} */
				if(tablo == '01'){
					$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_01').offset().top- $(".navtab").outerHeight())}, 0);
				}else if(tablo == '02'){
					$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_02').offset().top- $(".navtab").outerHeight())}, 0);
				}else if(tablo == '03'){
					$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_03').offset().top- $(".navtab").outerHeight())}, 0);
				}else if(tablo == '04'){
					$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_04').offset().top- $(".navtab").outerHeight())}, 0);
				}else if(tablo == '05'){
					$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_05').offset().top- $(".navtab").outerHeight())}, 0);
				}

			}
		});

		//ga > 탭
		tabLog('#prodGroup01', 12);
		tabLog('#prodGroup02', 17);
		tabLog('#prodGroup03', 22);
		tabLog('#prodGroup04', 27);
		tabLog('#prodGroup05', 32);

		//ga > 더보기
		moreViewLog('#prodGroup01',16);
		moreViewLog('#prodGroup02',21);
		moreViewLog('#prodGroup03',26);
		moreViewLog('#prodGroup04',31);
		moreViewLog('#prodGroup05',36);

	});

	//상품 탭, 슬라이트 관련
	function prodSlick(){
		var slickSlide = function(el){
			var $wrap = $(el);
			// 탭초기화
			$wrap.find(".tab_content").hide();
			$wrap.find("ul.pro_tabs li").eq(0).addClass("active").show();
			$wrap.find(".tab_content").eq(0).show();
			// 슬라이드 실행
			var proSlide = $(el + ' .itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			// 클릭이벤트
			$wrap.find("ul.pro_tabs li").click(function() {
				if ( !$(this).hasClass("active") ){
					$wrap.find("ul.pro_tabs li").removeClass("active");
					$(this).addClass("active")
					$wrap.find(".tab_content").hide();
					var activeTab = $(this).find("a").attr("href");
					$(activeTab).fadeIn();
					proSlide.slick("setPosition");
				}
				return false;
			});
		}
		// 슬라이드 실행
		var slide1 = new slickSlide('.item_group_01');
		var slide2 = new slickSlide('.item_group_02');
		var slide3 = new slickSlide('.item_group_03');
		var slide4 = new slickSlide('.item_group_04');
		var slide5 = new slickSlide('.item_group_05');

		//상단 탭 이동
		//topTabMove();
	}

	/* 퍼블테스트 : 레이어 열고 닫기*/
	function onoff(id){
		var mid = $("#"+id);
		if(mid.css("display") !== "none"){
			mid.css("display","none");
		}else{
			mid.css("display","");
		}
	}

	function getOsType() {
		var osType = "";
		if (app == 'Y') {
			if (navigator.userAgent.indexOf("Android") > -1)
				osType = "MAA";
			else
				osType = "MAI";
		} else {
			if (navigator.userAgent.indexOf("Android") > -1)
				osType = "MWA";
			else
				osType = "MWI";
		}
		return osType;
	}


</script>
</body>
</html>
