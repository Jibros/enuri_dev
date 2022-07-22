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
	response.sendRedirect("/event2019/winter_2019.jsp");
	return;
}
// SimpleDateFormat("yyyy-MM-dd HH:mm");
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
	<meta name="description" CONTENT="겨울필수템 반값세일! 겨울준비 최저가로 미리 하고, 경품 받자!">
	<meta name="keyword" CONTENT="에누리가격비교, 통합기획전, 겨울탐구생활, 따뜻한겨울나기, 월동준비, 방한용품, 겨울가전">
	<title>2019 월동준비 통합기획전 – 최저가 쇼핑은 에누리</title>
	<meta property="og:title" content="2019 월동준비 통합기획전 – 최저가 쇼핑은 에누리">
	<meta property="og:description" content="겨울필수템 반값세일! 겨울준비 최저가로 미리 하고, 경품 받자!">
	<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/sns_winter_1200_630.jpg">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" href="/css/event/y2019/prewinter_m.css" type="text/css">
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
	</script>
</head>
<body>
<div id="eventWrap">
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp" %>

	<!-- 플로팅 배너 - 둥둥이 -->
    <div id="floating_bnr" class="floating_bnr" onclick="ga_log(8);">
        <a href="/mobilefirst/event2019/winter_2019_evt.jsp?tab=evt1&freetoken=event" target="_blank"><img src="http://img.enuri.info/images/event/2019/pre_winter/fl_bnr.png" alt="매일매일 스타벅스 당첨!"></a>
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
					<span class="blind">겨울 탐구생활</span>
					<span class="obj_fill"></span>
				</h2>
				<span class="obj_ryan"></span>
				<span class="obj_txt">
					<span class="obj_txt_01"></span>
					<span class="obj_txt_02"></span>
				</span>
				<span class="obj_snow">
					<span class="obj_snow_01"></span>
					<span class="obj_snow_02"></span>
				</span>
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
				})
			</script>
		</div>

		<!-- 플로팅 탭 -->
		<div class="floattab">
			<div class="floattab__list">
				<div class="scrollList">
					<ul class="floatmove">
						<li><a href="#evt1" class="floattab__item floattab__item--01"><em>매주목요일 반값세일</em></a></li>
						<li><a href="#evt2" class="floattab__item floattab__item--02"><em>리빙 월동준비</em></a></li>
						<li><a href="#evt3" class="floattab__item floattab__item--03"><em>패션 월동준비</em></a></li>
						<li><a href="#evt4" class="floattab__item floattab__item--04"><em>방한 월동준비</em></a></li>
						<li><a href="#evt5" class="floattab__item floattab__item--05"><em>단열 월동준비</em></a></li>
						<li><a href="#evt6" class="floattab__item floattab__item--06"><em>가전 월동준비</em></a></li>
					</ul>
				</div>
				<a href="javascript:///" class="btn_tabmove next"><em>탭 이동</em></a>

				<script>
				$(document).on('click', '.floattab__list a', function(e) {
					var index = $(this).parents().index();
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
			<h2><img src="http://img.enuri.info/images/event/2019/pre_winter/m_deal_tit.png" alt="매주 목요일! 선착순 한정수량 겨울준비 반값세일"></h2>
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
		<h2><img src="http://img.enuri.info/images/event/2019/pre_winter/m_goods_tit.png" alt="올 겨울 건강하고 따뜻하게 겨울극복 필수템"></h2>
		<div class="inner">

			<!-- 리빙 월동준비 -->
			<div id="evt2" class="item_group item_group_01 scroll">
				<h3>
					<strong class="txt_tit"><em>리빙</em> 겨울준비 필수 ITEM</strong>
					<span class="txt_sub">#겨울내내 따뜻하게</span>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab1-1">침구세트</a></li>
					<li><a href="#protab1-2">난방텐트</a></li>
					<li><a href="#protab1-3">암막커튼</a></li>
				</ul>
				<script>
				$('#evt2 .pro_tabs li a').click(function(){
					var index = $(this).parents().index();

					ga_log(12 + index);
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
					<!-- 침구세트 상품 -->
					<div id="protab1-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=120816&freetoken=list" target="_blank" onclick="ga_log(16);">상품더보기</a>
					</div>
					<!-- //침구세트 상품 -->

					<!-- 난방텐트 상품 -->
					<div id="protab1-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=09310621&freetoken=list" target="_blank" onclick="ga_log(16);">상품더보기</a>
					</div>
					<!-- //난방텐트 상품 -->

					<!-- 암막커튼 상품 -->
					<div id="protab1-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=121307&freetoken=list" target="_blank" onclick="ga_log(16);">상품더보기</a>
					</div>
					<!-- //암막커튼 상품 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 리빙 월동준비-->

			<!-- 패션 월동준비 -->
			<div id="evt3" class="item_group item_group_02 scroll">
				<h3>
					<strong class="txt_tit"><em>패션</em> 겨울준비 필수 ITEM</strong>
					<span class="txt_sub">#겨울내내 따뜻하게</span>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab2-1">패딩&middot;다운</a></li>
					<li><a href="#protab2-2">워머&middot;모자</a></li>
					<li><a href="#protab2-3">니트&middot;조끼</a></li>
				</ul>
				<script>
				$('#evt3 .pro_tabs li a').click(function(){
					var index = $(this).parents().index();

					ga_log(17 + index);
				});
				</script>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 패딩&middot;다운 상품 -->
					<div id="protab2-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=143508&freetoken=list" target="_blank" onclick="ga_log(21);">상품더보기</a>
					</div>
					<!-- //패딩&middot;다운 상품 -->

					<!-- 워머&middot;모자 상품 -->
					<div id="protab2-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=145704&freetoken=list" target="_blank" onclick="ga_log(21);">상품더보기</a>
					</div>
					<!-- //워머&middot;모자 상품 -->

					<!-- 니트&middot;조끼 상품 -->
					<div id="protab2-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=143414&freetoken=list" target="_blank" onclick="ga_log(21);">상품더보기</a>
					</div>
					<!-- //니트&middot;조끼 상품 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 패션 월동준비 -->

			<!-- 방한 월동준비 -->
			<div id="evt4" class="item_group item_group_03 scroll">
				<h3>
					<strong class="txt_tit"><em>방한</em> 겨울준비 필수 ITEM</strong>
					<span class="txt_sub">#겨울내내 따뜻하게</span>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab3-1">휴대용손난로</a></li>
					<li><a href="#protab3-2">찜질팩</a></li>
					<li><a href="#protab3-3">온열담요</a></li>
				</ul>
				<script>
				$('#evt4 .pro_tabs li a').click(function(){
					var index = $(this).parents().index();

					ga_log(22 + index);
				});
				</script>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 휴대용손난로 상품 -->
					<div id="protab3-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=09202901&freetoken=list" target="_blank" onclick="ga_log(26);">상품더보기</a>
					</div>
					<!-- //휴대용손난로 상품 -->

					<!-- 찜질팩 상품 -->
					<div id="protab3-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=05101108&freetoken=list" target="_blank" onclick="ga_log(26);">상품더보기</a>
					</div>
					<!-- //찜질팩 상품 -->

					<!-- 온열담요 상품 -->
					<div id="protab3-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=240407&freetoken=list" target="_blank" onclick="ga_log(26);">상품더보기</a>
					</div>
					<!-- //온열담요 상품 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 방한 월동준비 -->

			<!-- 단열 월동준비 -->
			<div id="evt5" class="item_group item_group_04 scroll">
				<h3>
					<strong class="txt_tit"><em>단열</em> 겨울준비 필수 ITEM</strong>
					<span class="txt_sub">#겨울내내 따뜻하게</span>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab4-1">에어캡</a></li>
					<li><a href="#protab4-2">문풍지</a></li>
					<li><a href="#protab4-3">단열스프레이</a></li>
				</ul>
				<script>
				$('#evt5 .pro_tabs li a').click(function(){
					var index = $(this).parents().index();

					ga_log(27 + index);
				});
				</script>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 에어캡 상품 -->
					<div id="protab4-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=122611&freetoken=list" target="_blank" onclick="ga_log(31);">상품더보기</a>
					</div>
					<!-- //에어캡 상품 -->

					<!-- 문풍지 상품 -->
					<div id="protab4-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=12261001&freetoken=list" target="_blank" onclick="ga_log(31);">상품더보기</a>
					</div>
					<!-- //문풍지 상품 -->

					<!-- 단열스프레이 상품 -->
					<div id="protab4-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=122612&freetoken=list" target="_blank" onclick="ga_log(31);">상품더보기</a>
					</div>
					<!-- //단열스프레이 상품 -->
				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 단열 월동준비 -->

			<!-- 가전 월동준비 -->
			<div id="evt6" class="item_group item_group_05 scroll">
				<h3>
					<strong class="txt_tit"><em>가전</em> 겨울준비 필수 ITEM</strong>
					<span class="txt_sub">#겨울내내 따뜻하게</span>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab5-1">전자난로&middot;히터</a></li>
					<li><a href="#protab5-2">발난로</a></li>
					<li><a href="#protab5-3">전기장판</a></li>
				</ul>
				<script>
				$('#evt6 .pro_tabs li a').click(function(){
					var index = $(this).parents().index();

					ga_log(32 + index);
				});
				</script>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 전자난로&middot;히터 상품 -->
					<div id="protab5-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=240502&freetoken=list" target="_blank" onclick="ga_log(36);">상품더보기</a>
					</div>
					<!-- //전자난로&middot;히터 상품 -->

					<!-- 발난로 상품 -->
					<div id="protab5-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=240414&freetoken=list" target="_blank" onclick="ga_log(36);">상품더보기</a>
					</div>
					<!-- //발난로 상품 -->

					<!-- 전기장판 상품 -->
					<div id="protab5-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=240405&freetoken=list" target="_blank" onclick="ga_log(36);">상품더보기</a>
					</div>
					<!-- //전기장판 상품 -->
				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 가전 월동준비 -->
		</div>
	</div>
	<!-- //추천 상품 영역 -->

	<!-- 완벽하게 월동준비 하고 라이언 대형쿠션 득템 -->
	<div class="event_bnr">
		<a href="/mobilefirst/event2019/winter_2019_evt.jsp?tab=evt2&freetoken=event" target="_blank" onclick="ga_log(37);">
			<img src="http://img.enuri.info/images/event/2019/pre_winter/m_aside_bnr2.jpg" alt="완벽하게 월동준비 하고 라이언 대형쿠션 득템">
		</a>
	</div>
	<!-- // -->

	<!-- 에누리 혜택 -->
	<%@include	file = "/eventPlanZone/jsp/eventBannerTapMobile_201908.jsp"%>
	<script>
	$('.otherbene .banlist li a').click(function(){
		ga_log(38);
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
var app = getCookie("appYN"); //app인지 여부
var makeHtml = "";
var vEvent_title = "19 월동";
var gaLabel = [
				 "19 월동통합기획전_PV"
				,"19 월동통합기획전_상단탭_타임딜"
				,"19 월동통합기획전_상단탭_겨울리빙"
				,"19 월동통합기획전_상단탭_겨울패션"
				,"19 월동통합기획전_상단탭_방한용품"
				,"19 월동통합기획전_상단탭_생활단열"
				,"19 월동통합기획전_상단탭_계절가전"
				,"19 월동통합기획전_상단플로팅배너"
				,"19 월동통합기획전_타임딜_상품보기"
				,"19 월동통합기획전_타임딜_APP구매하기"
				,"19 월동통합기획전_타임딜_썸네일"
				,"19 월동통합기획전_리빙_탭_침구세트"
				,"19 월동통합기획전_리빙_난방텐트"
				,"19 월동통합기획전_리빙_탭_암막커튼"
				,"19 월동통합기획전_리빙_상품클릭"
				,"19 월동통합기획전_리빙_상품더보기"
				,"19 월동통합기획전_패션_탭_패딩·다운"
				,"19 월동통합기획전_패션_워머·모자"
				,"19 월동통합기획전_패션_탭_니트·조끼"
				,"19 월동통합기획전_패션_상품클릭"
				,"19 월동통합기획전_패션_상품더보기"
				,"19 월동통합기획전_방한_탭_휴대용손난로"
				,"19 월동통합기획전_방한_찜질팩"
				,"19 월동통합기획전_방한_탭_온열담요"
				,"19 월동통합기획전_방한_상품클릭"
				,"19 월동통합기획전_방한_상품더보기"
				,"19 월동통합기획전_단열_탭_에어캡"
				,"19 월동통합기획전_단열_문풍지"
				,"19 월동통합기획전_단열_탭_단열스프레이"
				,"19 월동통합기획전_단열_상품클릭"
				,"19 월동통합기획전_단열_상품더보기"
				,"19 월동통합기획전_가전_탭_전자난로·히터"
				,"19 월동통합기획전_가전_발난로"
				,"19 월동통합기획전_가전_탭_전기장판"
				,"19 월동통합기획전_가전_상품클릭"
				,"19 월동통합기획전_가전_상품더보기"
				,"19 월동통합기획전_프로모션띠배너"
				,"19 월동통합기획전_혜택배너"
             ];

$(document).ready(function(){
	ga_log(1);

	//#타임특가 PV
	setTimeout(function(){
		welcomeGa("evt_chuseok deal_view");
	},500);

	//딜 상품
	$.ajax({
		  url: "/mobilefirst/http/json/exh_deal_list_2019101500.json"
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
                dealItem += "				<li><a href=\"/mobilefirst/detail.jsp?modelno="+v.GD_MODEL_NO+"&freetoken=vip\" class=\"btn_dview\" target=\"_blank\" onclick=\"ga_log(9)\">상품보기</a></li>";
                if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT > vCur_dtm) { //판매 전
	                dealItem += "			<li id='deal_btn'><a class=\"btn_buy\">판매예정</a></li>";
		        }else if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT <= vCur_dtm && v.GD_SAL_E_DTM_CVT >= vCur_dtm) { //판매 중
	                dealItem += "			<li id='deal_btn'><a class=\"btn_buy\" onclick=\" fnDeal("+v.EXH_DEAL_NO+",'2019101500'); ga_log(10); return false;\">구매하기</a></li>";
		        }else{ // 판매 종료
	                dealItem += "			<li id='deal_btn'><a class=\"btn_buy_soldout\">Sold out</a></li>";
	        	}
                dealItem += "			</ul>";
                dealItem += "		</div>";
	                dealItem += "	<p class=\"ad\">※ 쿠폰적용 필수 / ID당 1회 / 무료배송 <span class=\"mark\"><img src=\"http://img.enuri.info/images/event/2019/familySpecial/logo_inter.png\" alt=\"인터파크\"></span></p>";
//                 }
        	    dealItem += "	</div>";
        	    dealItem += "</div>";

        		dealList += "<div class=\"w_item\" onclick=\"ga_log(11);\">";
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
				$('#evt1 h2 img').attr('src','http://img.enuri.info/images/event/2019/pre_winter/m_deal_tit_02.png');
			}
		}
	});

	//상품 영역
	var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=30";

	$.ajax({
		  dataType : "json"
		, url	   : loadUrl
		, success  : function(result){
			var tab = result.T;
			for(var idx = 0; idx < tab.length; idx ++){
				var listSize = 4; //노출 상품 개수
				var logNo = [15,20,25,30,35];
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
			var	$navHgt = Math.ceil($(".floattab__list").height());

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

			//상단 탭 이동
			topTabMove();
	    }
	});
});

function ga_log(param){
	if(param == 1){
		ga('send', 'pageview', {'page': vEvent_page, 'title': gaLabel[0]});
	}else{
		ga('send', 'event', 'mf_event', vEvent_title, gaLabel[param - 1]);
	}
}
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
