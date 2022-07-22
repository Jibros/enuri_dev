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
	response.sendRedirect("/event2019/xmas_2019.jsp");
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
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" >
	<meta name="description" CONTENT="크리스마스 반값 타임딜! 선물준비 최저가로 미리 하고, 마법같은 혜택받자!">
	<meta name="keyword" CONTENT="에누리가격비교, Merry 크리스마스, 호텔식사권, 크리스마스 연인선물, e쿠폰선물, 크리스마스 홈파티, 크리스마스 준비">
	<title>2019 크리스마스 통합기획전 – 최저가 쇼핑은 에누리</title>
	<meta property="og:title" content="2019 크리스마스 통합기획전 – 최저가 쇼핑은 에누리">
	<meta property="og:description" content="크리스마스 반값 타임딜! 선물준비 최저가로 미리 하고, 마법같은 혜택받자!">
	<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilenew/images/sns_xmas_1200_630.jpg">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" href="/css/event/y2019/xmas_m.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="http://m.enuri.com/mobilefirst/css/lib/slick.css"/>
	<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
	<script type="text/javascript" src="/event2016/js/event_common.js"></script>
	<script>
		var userId = "<%=userId%>";
		var tab = "<%=tab%>"; //파라미터 tab
		var username = "<%=userArea%>"; //개인화영역 이름
		var vChkId = "<%=chkId%>";
		var vEvent_page = "<%=strUrl%>"; //경로
		var ssl = "<%=ConfigManager.ENURI_COM_SSL%>";
		var index = 0;
	</script>
</head>
<body>
<div id="eventWrap">
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp" %>

	<!-- 플로팅 배너 - 둥둥이 -->
    <div id="floating_bnr" class="floating_bnr" onclick="ga_log(9);">
        <a href="/mobilefirst/event2019/xmas_2019_evt.jsp?tab=evt1&freetoken=event" target="_blank">
        <img src="http://img.enuri.info/images/event/2019/xmas/fl_bnr.png" alt="매일매일 투썸케이크 당첨!"></a>
        <!-- 닫기 -->
        <a href="javscript:void(0);" class="btn_close" onclick="onoff('floating_bnr');return false;">
            <span class="blind">닫기</span>
        </a>
    </div>
    <!-- // -->

	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">
		<!-- 상단비주얼 -->
		<div class="visual">
			<div class="inner">
				<h2>
					<span class="tit_01">Merry<span class="obj_light_01"></span></span>
					<span class="tit_02">크리스마스<span class="obj_light_02"></span></span>
				</h2>
				<div class="txt_box">
					<span class="txt_01">호텔식사권부터 반값할인 까지</span>
					<span class="txt_02">에누리가 드리는 마법같은 혜택</span>
				</div>
			</div>
			<script>
				// 상단 등장 모션
				$(window).load(function(){
					setTimeout(function(){
						$(".visual").addClass("intro");
						setTimeout(function(){
							$(".visual").addClass("end");
						},1500)
					},500)
				});
			</script>
		</div>

		<!-- 플로팅 탭 -->
		<div class="floattab">
			<div class="floattab__list">
				<div class="scrollList">
					<ul class="floatmove">
						<li><a href="#evt1" class="floattab__item floattab__item--01"><em>크리스마스 반값 타임딜</em></a></li>
						<li><a href="#evt2" class="floattab__item floattab__item--02"><em>키즈선물</em></a></li>
						<li><a href="#evt3" class="floattab__item floattab__item--03"><em>연인선물</em></a></li>
						<li><a href="#evt4" class="floattab__item floattab__item--04"><em>e쿠폰 선물</em></a></li>
						<li><a href="#evt5" class="floattab__item floattab__item--05"><em>홈파티</em></a></li>
						<li><a href="#evt6" class="floattab__item floattab__item--06"><em>새해준비</em></a></li>
						<li><a href="#evt7" class="floattab__item floattab__item--07"><em>윈터 스포츠</em></a></li>
					</ul>
				</div>
				<a href="javascript:///" class="btn_tabmove next"><em>탭 이동</em></a>

				<script>
				$(document).on('click', '.floattab__list a', function(e) {
					index = $(this).parents().index();
					ga_log(index + 2);
				});
				</script>
			</div>
		</div>
	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<!-- DEAL페이지 -->
	<div id="evt1" class="section dealwrap scroll">
		<div class="contents">
			<h2><img src="http://img.enuri.info/images/event/2019/xmas/m_deal_tit_03.png" alt="매주 목요일! 크리스마스 선물 반값 타임딜"></h2>
			<!-- 딜 구매영역 -->
			<div class="deal_slide">
				<!-- 딜 아이템 loop -->
				<!-- //딜 아이템 loop -->
			</div>
			<!-- //딜 구매영역 -->
		</div>
		<div>
			<!-- 딜 리스트영역 -->
			<div class="deal_list">
				<h4>Next Week</h4>
				<div class="deal_nav">
				</div>
			</div>
			<div class="area_noti">
				<a href="jvavscript:void(0);" class="sprite btn_caution evt-caution-1" onclick="onoff('notetxt1'); return false;">꼭!확인하세요</a>
			</div>
		</div>
	</div>
	<!-- //DEAL페이지 -->

	<!-- 추천 상품 영역 -->
	<div class="section pro_itemlist">
		<h2><img src="http://img.enuri.info/images/event/2019/xmas/m_goods_tit.jpg" alt="크리스마스 특별한 선물"></h2>
		<div class="inner">

			<!-- 키즈선물 -->
			<div id="evt2" class="item_group item_group_01 scroll">
				<h3>
					<strong class="txt_tit"><em>아이</em>를 위한 선물</strong>
					<span class="txt_sub">#행복한 겨울, 매일 크리스마스</span>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab1-1">태블릿PC</a></li>
					<li><a href="#protab1-2">장난감</a></li>
					<li><a href="#protab1-3">겨울의류</a></li>
				</ul>
				<script>
				$('#evt2 .pro_tabs li a').click(function(){
					index = $(this).parents().index();
					ga_log(13 + index);
				});
				</script>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">
					<!--
						SLICK $(".itemlist")
						3개의 탭 콘텐츠가 있습니다. "tab_content"
						하나의 콘텐츠마다 ul 단위로 한 판(상품4개)씩 움직입니다.
					-->
					<!-- 태블릿PC 상품 -->
					<div id="protab1-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=0305&freetoken=list" target="_blank" onclick="ga_log(17);">상품더보기</a>
					</div>
					<!-- //태블릿PC 상품 -->

					<!-- 장난감 상품 -->
					<div id="protab1-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=1014&freetoken=list" target="_blank" onclick="ga_log(17);">상품더보기</a>
					</div>
					<!-- //장난감 상품 -->

					<!-- 겨울의류 상품 -->
					<div id="protab1-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=1015&freetoken=list" target="_blank" onclick="ga_log(17);">상품더보기</a>
					</div>
					<!-- //겨울의류 상품 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- //키즈선물 -->

			<!-- 연인선물 -->
			<div id="evt3" class="item_group item_group_02 scroll">
				<h3>
					<strong class="txt_tit"><em>연인</em>을 위한 선물</strong>
					<span class="txt_sub">#행복한 겨울, 매일 크리스마스</span>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab2-1">패션잡화</a></li>
					<li><a href="#protab2-2">쥬얼리</a></li>
					<li><a href="#protab2-3">향수</a></li>
				</ul>
				<script>
				$('#evt3 .pro_tabs li a').click(function(){
					index = $(this).parents().index();
					ga_log(18 + index);
				});
				</script>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 패션잡화 상품 -->
					<div id="protab2-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=1436&freetoken=list" target="_blank" onclick="ga_log(22);">상품더보기</a>
					</div>
					<!-- //패션잡화 상품 -->

					<!-- 쥬얼리 상품 -->
					<div id="protab2-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=1451&freetoken=list" target="_blank" onclick="ga_log(22);">상품더보기</a>
					</div>
					<!-- //쥬얼리 상품 -->

					<!-- 향수 상품 -->
					<div id="protab2-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=0810&freetoken=list" target="_blank" onclick="ga_log(22);">상품더보기</a>
					</div>
					<!-- //향수 상품 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 연인선물 -->

			<!-- e쿠폰 선물 -->
			<div id="evt4" class="item_group item_group_03 scroll">
				<h3>
					<strong class="txt_tit"><em>e쿠폰</em> 선물</strong>
					<span class="txt_sub">#행복한 겨울, 매일 크리스마스</span>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab3-1">외식</a></li>
					<li><a href="#protab3-2">케이크/카페</a></li>
					<li><a href="#protab3-3">상품권</a></li>
				</ul>
				<script>
				$('#evt4 .pro_tabs li a').click(function(){
					var index = $(this).parents().index();
					ga_log(23 + index);
				});
				</script>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 외식 상품 -->
					<div id="protab3-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=164751&freetoken=list" target="_blank" onclick="ga_log(27);">상품더보기</a>
					</div>
					<!-- //외식 상품 -->

					<!-- 케이크/카페 상품 -->
					<div id="protab3-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=164719&freetoken=list" target="_blank" onclick="ga_log(27);">상품더보기</a>
					</div>
					<!-- //케이크/카페 상품 -->

					<!-- 상품권 상품 -->
					<div id="protab3-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=164714&freetoken=list" target="_blank" onclick="ga_log(27);">상품더보기</a>
					</div>
					<!-- //상품권 상품 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // e쿠폰 선물 -->

			<!-- 홈파티 -->
			<div id="evt5" class="item_group item_group_04 scroll">
				<h3>
					<strong class="txt_tit"><em>크리스마스 홈파티</em> 준비</strong>
					<span class="txt_sub">#행복한 겨울, 매일 크리스마스</span>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab4-1">트리장식</a></li>
					<li><a href="#protab4-2">파티음식</a></li>
					<li><a href="#protab4-3">인테리어 소품</a></li>
				</ul>
				<script>
				$('#evt5 .pro_tabs li a').click(function(){
					var index = $(this).parents().index();
					ga_log(28 + index);
				});
				</script>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 트리장식 상품 -->
					<div id="protab4-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=16441711&freetoken=list" target="_blank" onclick="ga_log(32);">상품더보기</a>
					</div>
					<!-- //트리장식 상품 -->

					<!-- 파티음식 상품 -->
					<div id="protab4-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=151112&freetoken=list" target="_blank" onclick="ga_log(32);">상품더보기</a>
					</div>
					<!-- //파티음식 상품 -->

					<!-- 인테리어 소품 상품 -->
					<div id="protab4-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=12451215&freetoken=list" target="_blank" onclick="ga_log(32);">상품더보기</a>
					</div>
					<!-- //인테리어 소품 상품 -->
				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 홈파티 -->

			<!-- 새해준비 -->
			<div id="evt6" class="item_group item_group_05 scroll">
				<h3>
					<strong class="txt_tit"><em>새해 준비</em> 아이템</strong>
					<span class="txt_sub">#미리미리 준비하는 2020년</span>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab5-1">다이어리/달력</a></li>
					<li><a href="#protab5-2">건강식품</a></li>
					<li><a href="#protab5-3">패션/화장품</a></li>
				</ul>
				<script>
				$('#evt6 .pro_tabs li a').click(function(){
					var index = $(this).parents().index();
					ga_log(33 + index);
				});
				</script>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 다이어리/달력 상품 -->
					<div id="protab5-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=180210&freetoken=list" target="_blank" onclick="ga_log(37);">상품더보기</a>
					</div>
					<!-- //다이어리/달력 상품 -->

					<!-- 건강식품 상품 -->
					<div id="protab5-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=1501&freetoken=list" target="_blank" onclick="ga_log(37);">상품더보기</a>
					</div>
					<!-- //건강식품 상품 -->

					<!-- 패션/화장품 상품 -->
					<div id="protab5-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=0801&freetoken=list" target="_blank" onclick="ga_log(37);">상품더보기</a>
					</div>
					<!-- //패션/화장품 상품 -->
				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 새해준비 -->

			<!-- 윈터스포츠 -->
			<div id="evt7" class="item_group item_group_06 scroll">
				<h3>
					<strong class="txt_tit"><em>윈터 스포츠</em> 아이템</strong>
					<span class="txt_sub">#야외에서 필요한 추위 극복템</span>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab6-1">스포츠 의류</a></li>
					<li><a href="#protab6-2">방한용품</a></li>
				</ul>
				<script>
				$('#evt7 .pro_tabs li a').click(function(){
					var index = $(this).parents().index();
					ga_log(38 + index);
				});
				</script>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 스포츠 의류 상품 -->
					<div id="protab6-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=0912&freetoken=list" target="_blank" onclick="ga_log(41);">상품더보기</a>
					</div>
					<!-- //스포츠 의류 상품 -->

					<!-- 방한용품 상품 -->
					<div id="protab6-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=090118&freetoken=list" target="_blank" onclick="ga_log(41);">상품더보기</a>
					</div>
					<!-- //방한용품 상품 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 윈터스포츠 -->
		</div>
	</div>
	<!-- //추천 상품 영역 -->

	<!-- 크리스마스 스페셜 선물사고 신라호텔 뷔페식사권 당첨! -->
	<div class="event_bnr">
		<a href="/mobilefirst/event2019/xmas_2019_evt.jsp?tab=evt2&freetoken=event" target="_blank" onclick="ga_log(42);">
			<img src="http://img.enuri.info/images/event/2019/xmas/m_aside_bnr2.jpg" alt="크리스마스 스페셜 선물사고 신라호텔 뷔페식사권 당첨!">
		</a>
	</div>
	<!-- // -->

	<!-- 에누리 혜택 -->
	<%@include	file = "/eventPlanZone/jsp/eventBannerTapMobile_201908.jsp"%>
	<script>
	$('.otherbene .banlist li a').click(function(){
		ga_log(43);
	});
	</script>
	<!-- //에누리 혜택 -->
	<!-- //Contents -->

	<span class="go_top"><a href="#">TOP</a></span>
</div>
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20190611"></script>
<script type="text/javascript" src="/mobilefirst/event/js/exhibition_m.js"></script>

<!-- layer-->
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick = "install_btt();">설치하기</button></p>
	</div>
</div>

<!-- 이벤트1 유의사항 -->
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="noteLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1');return false;">창닫기</a>
		<div class="inner">
			<ul class="txtlist">
				<li>본인인증이 완료된 ID로만 참여가능합니다.</li>
				<li>시즌기획전 타임딜 상품의 주문/배송/환불/보증 책임은 해당 쇼핑몰의 판매자에게 있습니다.</li>
				<li>부정한 방법으로 상품 구매 시 주문이 취소될 수 있습니다.</li>
				<li>본 이벤트는 당사에 사정에 따라 사전고지 없이 변경 또는 조기종료 될 수 있습니다.</li>
				<li>시즌기획전 타임딜은 선착순 한정수량 판매로 결제 진행 중 상품이 품절될 경우 판매가 종료될 수 있습니다.</li>
				<li>에누리 모바일 APP 에서만 구매가능하며, 다른 환경(인터파크 APP 등)에서 구매시도하여 발생되는 문제에 대해서는 책임 및 보상이 이루어지지 않습니다.</li>
			</ul>
		</div>
		<p class="btn_close"><button type="button" onclick="onoff('notetxt1');return false;">닫기</button></p>
	</div>
</div>

<script type="text/javascript">
var cnt = 0;
var $navHgt = 0;
var app = getCookie("appYN"); //app인지 여부
var makeHtml = "";
var vEvent_title = "19 크리스마스";
var gaLabel = [
				 " 19 크리스마스 통합기획전_PV"
				," 19 크리스마스 통합기획전_상단탭_타임딜"
				," 19 크리스마스 통합기획전_상단탭_키즈선물"
				," 19 크리스마스 통합기획전_상단탭_연인선물"
				," 19 크리스마스 통합기획전_상단탭_e쿠폰선물"
				," 19 크리스마스 통합기획전_상단탭_홈파티"
				," 19 크리스마스 통합기획전_상단탭_새해준비"
				," 19 크리스마스 통합기획전_상단탭_윈터스포츠"
				," 19 크리스마스 통합기획전_상단플로팅배너"
				," 19 크리스마스 통합기획전_타임딜_상품보기"
				," 19 크리스마스 통합기획전_타임딜_APP구매하기"
				," 19 크리스마스 통합기획전_타임딜_썸네일"
				," 19 크리스마스 통합기획전_키즈선물_탭_태블릿PC"
				," 19 크리스마스 통합기획전_키즈선물_탭_장난감"
				," 19 크리스마스 통합기획전_키즈선물_탭_겨울의류"
				," 19 크리스마스 통합기획전_키즈선물_상품클릭"
				," 19 크리스마스 통합기획전_키즈선물_상품더보기"
				," 19 크리스마스 통합기획전_연인선물_탭_패션잡화"
				," 19 크리스마스 통합기획전_연인선물_탭_쥬얼리"
				," 19 크리스마스 통합기획전_연인선물_탭_향수"
				," 19 크리스마스 통합기획전_연인선물_상품클릭"
				," 19 크리스마스 통합기획전_연인선물_상품더보기"
				," 19 크리스마스 통합기획전_e쿠폰_탭_외식"
				," 19 크리스마스 통합기획전_e쿠폰_탭_케이크/카페"
				," 19 크리스마스 통합기획전_e쿠폰_탭_상품권"
				," 19 크리스마스 통합기획전_e쿠폰_상품클릭"
				," 19 크리스마스 통합기획전_e쿠폰_상품더보기"
				," 19 크리스마스 통합기획전_홈파티_탭_트리장식"
				," 19 크리스마스 통합기획전_홈파티_탭_파티음식"
				," 19 크리스마스 통합기획전_홈파티_탭_인테리어"
				," 19 크리스마스 통합기획전_홈파티_상품클릭"
				," 19 크리스마스 통합기획전_홈파티_상품더보기"
				," 19 크리스마스 통합기획전_새해준비_탭_다이어리/달력"
				," 19 크리스마스 통합기획전_새해준비_탭_건강식품"
				," 19 크리스마스 통합기획전_새해준비_탭_패션/화장품"
				," 19 크리스마스 통합기획전_새해준비_상품클릭"
				," 19 크리스마스 통합기획전_새해준비_상품더보기"
				," 19 크리스마스 통합기획전_윈터스포츠_탭_스포츠의류"
				," 19 크리스마스 통합기획전_윈터스포츠_탭_방한용품"
				," 19 크리스마스 통합기획전_윈터스포츠_상품클릭"
				," 19 크리스마스 통합기획전_윈터스포츠_상품더보기"
				," 19 크리스마스 통합기획전_프로모션띠배너"
				," 19 크리스마스 통합기획전_혜택배너"
             ];

$(document).ready(function(){
	ga_log(1);

	//#타임특가 PV
	setTimeout(function(){
		welcomeGa("evt_xmas_deal_view");
	},500);

	//딜 상품
	$.ajax({
		  url: "/mobilefirst/http/json/exh_deal_list_2019111300.json"
		, dataType : "json"
		, cache    : false
		, success  : function(data){
			var vCur_dtm = "<%= strToday %>";
			var dealItem = "";
			var dealList = "";
			$.each(data, function(i,v){
				//딜 판매날짜, 할인률
				var month = parseInt(v.GD_SAL_S_DTM_CVT.substring(4,6));
				var day = parseInt(v.GD_SAL_S_DTM_CVT.substring(6,8));
				var discountRate =  Math.round((v.GD_PRC - v.GD_DC_PRC) / v.GD_PRC * 100);
				var text = discountRate+"% 타임특가 / "+v.GD_QTY+"개 한정";
				cnt = data.length;

				dealItem += "<div class=\"deal_item clearfix\">";
				dealItem += "	<div class=\"container\">";
				dealItem += "		<div class=\"thumb\">";
				dealItem += "			<img src=\"http://storage.enuri.info/Web_Storage"+v.GD_IMG_URL+"\" />";
				dealItem += "			<span class=\"ico_date\">";
				dealItem += "				<span>";
				dealItem += "					<strong>"+month+"."+day+"일("+getWeek(v.GD_SAL_S_DTM_CVT)+")</strong>2pm 오픈";
				dealItem += "				</span>";
				dealItem += "			</span>";
				dealItem += "		</div>";
                dealItem += "		<div class=\"item_info\">";
                dealItem += "			<div class=\"inner\">";
				dealItem += "				<strong class=\"limit\">"+text+"</strong>";
                dealItem += "				<p class=\"tit\">"+v.GD_MODEL_NM1+v.GD_MODEL_NM2+"</p>";
                dealItem += "				<p class=\"price\"><strong>"+commaNum(v.GD_DC_PRC)+"</strong>원</p>";
                dealItem += "			</div>";
                dealItem += "			<ul class=\"btn_area clearfix\" id=\"ul_btn"+i+"\">";
                dealItem += "				<li><a href=\"/mobilefirst/detail.jsp?modelno="+v.GD_MODEL_NO+"&freetoken=vip\" class=\"btn_dview\" target=\"_blank\" onclick=\"ga_log(10)\">상품보기</a></li>";
                if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT > vCur_dtm) { //판매 전
	                dealItem += "			<li id='deal_btn'><a class=\"btn_buy\">판매예정</a></li>";
		        }else if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT <= vCur_dtm && v.GD_SAL_E_DTM_CVT >= vCur_dtm) { //판매 중
	                dealItem += "			<li id='deal_btn'><a class=\"btn_buy\" onclick=\" fnDeal("+v.EXH_DEAL_NO+",'2019111300'); ga_log(11); return false;\">구매하기</a></li>";
		        }else{ // 판매 종료
	                dealItem += "			<li id='deal_btn'><a class=\"btn_buy_soldout\">Sold out</a></li>";
	        	}
                dealItem += "			</ul>";
                dealItem += "		</div>";
                dealItem += "	<p class=\"ad\">※ 쿠폰적용 필수 / ID당 1회 / 무료배송 <span class=\"mark\"><img src=\"http://img.enuri.info/images/event/2019/familySpecial/logo_inter.png\" alt=\"인터파크\"></span></p>";
        	    dealItem += "	</div>";
        	    dealItem += "</div>";

        		dealList += "<div class=\"w_item\" onclick=\"ga_log(12);\">";
                dealList += "	<div class=\"w_thumb\">";
                dealList += "		<img src=\"http://storage.enuri.info/Web_Storage"+v.GD_IMG_URL+"\" />";
                dealList += "	</div>";
				dealList += "	<div class=\"period\">";
                dealList += "		<span>"+month+"/"+day+"("+getWeek(v.GD_SAL_S_DTM_CVT)+") 14:00</span>";
                dealList += "	</div>";
                dealList += "	<span class=\"w_tit\">"+v.GD_MODEL_NM1+"<br>"+v.GD_MODEL_NM2+"</span>";
				dealList += "</div>";
			});
			$('#evt1 .deal_slide').html(dealItem);
			$('#evt1 .deal_list .deal_nav').html(dealList);
		}
		, complete: function(){
	    	//딜 슬릭
	    	dealSlick();

            //딜 날짜별 상품 노출
			for(var i = 0; i < cnt; i++){
				if($("#ul_btn"+i+" li a").hasClass("btn_buy_soldout")){
					$('#evt1 .deal_slide').slick('slickGoTo', i+1, true);
				}else{
					break;
				}
			}

            if(app != 'Y'){
				var deal_btn = $('#deal_btn a');

				$('#only_mweb').show();
				deal_btn.text('APP에서 구매하기');
				deal_btn.removeAttr('onclick');
				deal_btn.attr('onclick',"$('#app_only').show();");

				//앱 전용 이미지
				$('#evt1 h2 img').attr('src','http://img.enuri.info/images/event/2019/xmas/m_deal_tit_02.png');
			}
		}
	});

	//상품 영역
	var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=31";

	$.ajax({
		  dataType : "json"
		, url	   : loadUrl
		, success  : function(result){
			var tab = result.T;
			for(var idx = 0; idx < tab.length; idx ++){
				var listSize = 4; //노출 상품 개수
				var logNo = [16,21,26,31,36,40];
				var no = logNo[parseInt(idx/3)];
				makeHtml = "";
				$.each(tab[idx].GOODS, function(i,v){
					var minprice = (v.MINPRICE == null) ? 0 : v.MINPRICE;

					if((i % listSize) == 0)
						makeHtml += "<ul class='items clearfix'>";
					makeHtml += "<li class='item'>";
					makeHtml +=	"	<a href='javascript:void(0);' onclick='itemClick("+v.MODELNO+", "+minprice+"); ga_log("+no+")'>";
					makeHtml +=	"		<span class='thumb'>";
					makeHtml += "			<img src='"+v.GOODS_IMG+"' alt='상품이미지' onerror = 'replaceImg(this);'>";
					if(minprice == 0 || minprice == null){
						makeHtml +=	"			<span class='soldout'>soldout</span> <!-- 품절시 노출 -->";
					}
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
					if(i % listSize == (listSize - 1) || i == tab[idx].GOODS.length)
						makeHtml += "</ul>";
				});
				$('#protab'+ (parseInt((idx / 3) + 1)) + '-' + ((idx % 3) + 1) +' .itemlist').html(makeHtml);
			}
		}
	    , complete : function(){
			$navHgt = Math.ceil($(".floattab__list").height());

			//플로팅 상단 탭 이동
			$(document).on('click', '.floattab__list .floatmove a', function(e) {
				var $anchor = Math.ceil($($(this).attr('href')).offset().top);
				$('html, body').stop().animate({scrollTop: $anchor - $navHgt}, 500);
				e.preventDefault();
			});

			//상품 슬릭
			prodSlick();

			//파라이터값 tab 이동
			if(tab > 0) tabMove(tab, $navHgt);

	    }
	});
});
</script>

<script type="text/javascript">
/*레이어*/
$(function(){
	//스크롤
	var nav = $('.myarea');

	$(window).scroll(function () {
		if ($(this).scrollTop() > $(".toparea").height()) {
			nav.addClass("f-nav");
		} else {
			nav.removeClass("f-nav");
		}
	});
});

function onoff(id){
	var mid = $("#"+id);
	if(mid.css("display") !== "none"){
		mid.css("display","none");
	}else{
		mid.css("display","");
	}
}
/*checkbox*/
function agreechk(obj){
	if (obj.className== 'unchk') {
		obj.className = 'chk';
	} else {
		obj.className = 'unchk';
	}
}

//상단 탭 이동
function topTabMove(){
	var posScr = new Array(),
	$nav = $(".floattab__list"), // scroll tabs
	$navTop = $nav.offset().top,
	$scrTarget = $("#eventWrap .scroll"),
	$scrList = $(".scrollList"),
	navPerView = parseInt ( screen.width / $nav.find("li").eq(0).width() , 10) ;
	// 네비 활성화
	var activeNavi = function(num){
		$nav.find("a").removeClass("is-on");
		$nav.find("li").eq(num).find("a").addClass("is-on").siblings().removeClass("is-on");
		var moveToScr = function(num){
			if ( num < navPerView ) return 0;
			else return $nav.find("li").eq(0).width() * ( Math.floor( (num - navPerView) / 2 ) + 2 ) - 30;
		}
		$scrList.scrollLeft( moveToScr(num) );
	}
	// 네비 이동영역의 ScrollTop 보관
	$scrTarget.each(function(e){
		posScr[e] = $(this).offset().top - $nav.outerHeight();
	})
	// 상단 탭 position 변경 및 버튼 활성화
	$(window).scroll(function(){
		var $currY = $(this).scrollTop(); // 현재 scroll
		var _nowPos = 0;
		if ($currY > $navTop-1) {
			$nav.addClass("is-fixed");
			$(posScr).each(function(e){
				if ( e != posScr.length -1 ){
					if ( posScr[e] <= $currY && posScr[e+1] > $currY ){
						activeNavi(e);
						return false;
					}
				}else{
					activeNavi(e);
				}
			});
		} else {
			$nav.removeClass("is-fixed").find("a").removeClass("is-on");
		}
	});
	$scrList.on("scroll", function(){
		var st = $scrList.scrollLeft();
		if (st >= $nav.find("li").eq(0).width() * 1 - 30) {
			$(".btn_tabmove").removeClass("next").addClass("prev");
		}else {
			$(".btn_tabmove").removeClass("prev").addClass("next");
		}
	});
}

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
	var slide6 = new slickSlide('.item_group_06');

	//상단 탭 이동
	topTabMove();
}

//딜 슬릭
function dealSlick(){
	var $deal_slide = $('#evt1 .deal_slide');
	var $w_item = $('.deal_nav .w_item');

	$deal_slide.slick({
		slidesToShow: 1,
		slidesToScroll: 1,
		arrows: true,
		dots: true,
		fade: false,
		//speed: 0,
		asNavFor: '.deal_nav'
	});

	$('#evt1 .deal_list .deal_nav').slick({
		slidesToShow: 3,
		slidesToScroll: 1,
		asNavFor: '.deal_slide',
		dots: false,
		centerMode: false,
		focusOnSelect: true,
		variableWidth: true
	});

	$deal_slide.on('beforeChange', function(e, s, c, n){
	    	$w_item.removeClass("slick-current");
	    	$w_item.eq(n).addClass("slick-current");
    });
}
</script>
</body>
</html>