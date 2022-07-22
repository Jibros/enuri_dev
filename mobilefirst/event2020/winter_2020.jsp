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
	response.sendRedirect("/event2020/winter_2020.jsp");
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
<meta name="title" content="2020 월동 통합기획전 – 최저가 쇼핑은 에누리">
<meta name="description" content="온 가족 타임특가! 매주 수요일마다 터지는 득템의 기회!">
<meta name="keyword" content="에누리가격비교, 통합기획전, 겨울, 월동, 겨울준비, 월동준비">
<meta property="og:title" content="[에누리 가격비교]겨울에누리다!">
<meta property="og:description" content="매주 수요일 타임특가도 만나보세요!">
<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM+ "/images/event/2020/winter/sns_1200_630.jpg"%>">
<meta name="format-detection" content="telephone=no" />
<title>2020 월동  기획전 - 최저가 쇼핑은 에누리</title>
<!-- 프로모션 공통 CSS (Mobile) -->
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<!-- 프로모션별 커스텀 CSS  -->
<link rel="stylesheet" href="/css/event/y2020/winter_m.css" type="text/css">
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

	<%@include file="/mobilefirst/event2020/winter_header.jsp" %>

	<!-- T3 이벤트 04 : 추천 상품 영역 -->
	<div id="event04" class="section event_04 pro_itemlist">
		<h2>
			<span class="tx_sm">훈훈한 온풍기부터 따뜻한 온수매트까지!</span>
			<span class="tx_main">겨울을 더욱 포근하게 할 쇼핑 가이드</span>
		</h2>

		<div class="inner">
			<!-- 겨울잠 준비 -->
			<div id="prodGroup01" class="item_group item_group_01 scroll">
				<h3>
					<span class="txt_sub">#코코낸내 #이불밖은 위험해</span>
					<strong class="txt_tit">겨울잠 준비</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab1-1">온수/전기매트</a></li>
					<li><a href="#protab1-2">난방텐트</a></li>
					<li><a href="#protab1-3">침구세트</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">
					<!--
						SLICK $(".itemlist")
						3개의 탭 콘텐츠가 있습니다. "tab_content"
						하나의 콘텐츠마다 ul 단위로 한 판(상품4개)씩 움직입니다.
					-->
					<!-- 온수/전기매트 상품 -->
					<div id="protab1-1" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=240440">상품더보기</a>
					</div>
					<!-- //온수/전기매트 상품 -->

					<!-- 난방텐트 상품 -->
					<div id="protab1-2" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=09310621">상품더보기</a>
					</div>
					<!-- //난방텐트 상품 -->

					<!-- 침구세트 상품 -->
					<div id="protab1-3" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=120816">상품더보기</a>
					</div>
					<!-- //침구세트 상품 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 겨울잠 준비 -->

			<!--  난방비 절약 -->
			<div id="prodGroup02" class="item_group item_group_02 scroll">
				<h3>
					<span class="txt_sub">#1도의 기적</span>
					<strong class="txt_tit">난방비 절약</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab2-1">가습기</a></li>
					<li><a href="#protab2-2">단열필름</a></li>
					<li><a href="#protab2-3">암막커튼</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 가습기 상품 -->
					<div id="protab2-1" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=240321">상품더보기</a>
					</div>
					<!-- //가습기 상품 -->

					<!-- 단열필름 상품 -->
					<div id="protab2-2" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=122612">상품더보기</a>
					</div>
					<!-- //단열필름 상품 -->

					<!-- 암막커튼 상품 -->
					<div id="protab2-3" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=121307">상품더보기</a>
					</div>
					<!-- //암막커튼 상품 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- //  난방비 절약 -->

			<!-- 소형 난방템 -->
			<div id="prodGroup03" class="item_group item_group_03 scroll">
				<h3>
					<span class="txt_sub">#집에서도 #회사에서도 훈훈하게</span>
					<strong class="txt_tit">소형 난방템</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab3-1">히터/온풍기</a></li>
					<li><a href="#protab3-2">USB 온열기</a></li>
					<li><a href="#protab3-3">손난로/온열팩</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 히터/온풍기 상품 -->
					<div id="protab3-1" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=240508">상품더보기</a>
					</div>
					<!-- //히터/온풍기 상품 -->

					<!-- USB 온열기 상품 -->
					<div id="protab3-2" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=240414">상품더보기</a>
					</div>
					<!-- //USB 온열기 상품 -->

					<!-- 손난로/온열팩 상품 -->
					<div id="protab3-3" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=092029">상품더보기</a>
					</div>
					<!-- //손난로/온열팩 상품 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 소형 난방템 -->

			<!-- 겨울 먹거리 -->
			<div id="prodGroup04" class="item_group item_group_04 scroll">
				<h3>
					<span class="txt_sub">#뱃속부터 든든하게</span>
					<strong class="txt_tit">겨울 먹거리</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab4-1">겨울간식</a></li>
					<li><a href="#protab4-2">e쿠폰</a></li>
					<li><a href="#protab4-3">김장</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 겨울간식 상품 -->
					<div id="protab4-1" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=15081307">상품더보기</a>
					</div>
					<!-- //겨울간식 상품 -->

					<!-- e쿠폰 상품 -->
					<div id="protab4-2" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=164721">상품더보기</a>
					</div>
					<!-- //e쿠폰 상품 -->

					<!-- 김장 상품 -->
					<div id="protab4-3" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=150216">상품더보기</a>
					</div>
					<!-- //김장 상품 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 겨울 먹거리 -->

			<!-- 겨울 의류 -->
			<div id="prodGroup05" class="item_group item_group_05 scroll">
				<h3>
					<span class="txt_sub">#밖은 추우니까 #절대무장</span>
					<strong class="txt_tit">겨울 의류</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab5-1">패딩/다운</a></li>
					<li><a href="#protab5-2">방한용품</a></li>
					<li><a href="#protab5-3">내복</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 패딩/다운 상품 -->
					<div id="protab5-1" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=14350805&keyword=%EB%82%A8%EB%85%80%EA%B3%B5%EC%9A%A9">상품더보기</a>
					</div>
					<!-- //패딩/다운 상품 -->

					<!-- 방한용품 상품 -->
					<div id="protab5-2" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=145702">상품더보기</a>
					</div>
					<!-- //방한용품 상품 -->

					<!-- 내복 상품 -->
					<div id="protab5-3" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=143712">상품더보기</a>
					</div>
					<!-- //내복 상품 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 겨울 의류 -->
		</div>
	</div>
	<!-- // -->


	<!-- T3 : 배너 슬라이드 -->
	<div class="bnr_wide">
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<div class="swiper-slide">
					<!-- 배경색은 inline-style로 넣어주세요 -->
					<a href="http://m.enuri.com/m/pickMain.jsp" style="background-color:#f6ddb2" onclick="ga_log(38);">
						<img src="http://img.enuri.info/images/event/2020/winter/m_pick_bn_01_1.jpg" alt="">
					</a>
				</div>
				<div class="swiper-slide">
					<!-- 배경색은 inline-style로 넣어주세요 -->
					<a href="http://m.enuri.com/m/pickMain.jsp" style="background-color:#f6ddb2" onclick="ga_log(38);">
						<img src="http://img.enuri.info/images/event/2020/winter/m_pick_bn_01_1.jpg" alt="">
					</a>
				</div>
			</div>
			<div class="swiper-button swiper-button-prev btn_prev"></div>
			<div class="swiper-button swiper-button-next btn_next"></div>
		</div>
		<script>
			$(function(){
				var $slide = $(".bnr_wide .swiper-container .swiper-slide");
				var $slideBtn = $(".bnr_wide .swiper-button");
				// 슬라이드가 1개 초과일때만 swiper 생성
				if ( $slide.length == 1 ){
					$slideBtn.hide();
				}else{
					var swiper = new Swiper('.bnr_wide .swiper-container',{
						loop : true,
						prevButton : '.bnr_wide .btn_prev',
						nextButton : '.bnr_wide .btn_next'
					})
				}
			})
		</script>
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
		var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2020%2Fwinter_2020.jsp";
		if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
			goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2020/winter_2020.jsp";
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

		$(".ben_item--04").click(function(){
			var url = (app != "Y" ? "/mobilefirst/index.jsp#evt" : "/mobilefirst/renew/plan.jsp?freetoken=main_tab|event");
			window.open(url);
		});

		//상품 영역
		var loadUrl = "/event/ajax/exhibition_ajax.jsp?exh_id=39";

		$.ajax({
			  dataType : "json"
			, url	   : loadUrl
			, cache : false
			, success  : function(result){
				var banner = result.R;
				var tab = result.T;
				var tabSize = 3; //컨텐츠 별 탭 개수
				var listSize = 4; //노출 상품 개수
				var logNo = [16,21,26,31,36];
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
				}else if(tablo == '06'){
					$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_05').offset().top- $(".navtab").outerHeight())}, 0);
				}

			}
		});

		//ga > 탭
		tabLog('#prodGroup01', 13);
		tabLog('#prodGroup02', 18);
		tabLog('#prodGroup03', 23);
		tabLog('#prodGroup04', 28);
		tabLog('#prodGroup05', 33);

		//ga > 더보기
		moreViewLog('#prodGroup01',17);
		moreViewLog('#prodGroup02',22);
		moreViewLog('#prodGroup03',27);
		moreViewLog('#prodGroup04',32);
		moreViewLog('#prodGroup05',37);

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
