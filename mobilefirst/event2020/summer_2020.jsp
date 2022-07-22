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
	response.sendRedirect("/event2020/summer_2020.jsp");
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
<meta name="description" content="온 가족 타임특가! 여름준비 최저가로 미리 하고, 탄산수 제조기 당첨!">
<meta name="keyword" content="에누리가격비교, 통합기획전, 2020년 여름, 무더위, 썸머, 호캉스, 바캉스, 홈캉스, 탄산수제조기, 휴가">
<meta property="og:title" content="2020 무더위 통합기획전 – 최저가 쇼핑은 에누리">
<meta property="og:description" content="온 가족 타임특가! 여름준비 최저가로 미리 하고, 탄산수 제조기 당첨!">
<meta property="og:image" content="http://img.enuri.info/images/event/2020/summer/sns_1200_630_03.jpg">
<meta name="format-detection" content="telephone=no" />
<title>2020 무더위 통합기획전 – 최저가 쇼핑은 에누리</title>
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<link rel="stylesheet" href="/css/event/y2020/summer_m.css" type="text/css">
<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
<script type="text/javascript" src="/event2016/js/event_common.js"></script>
<!-- 프로모션 공통 CSS (Mobile) -->
<!-- 프로모션별 커스텀 CSS  -->
<script>
	var userId = "<%=userId%>";
	var tab = "<%=tab%>"; //파라미터 tab
	var username = "<%=userArea%>"; //개인화영역 이름
	var vChkId = "<%=chkId%>";
	var vEvent_page = "<%=strUrl%>"; //경로
	var ssl = "<%=ConfigManager.ENURI_COM_SSL%>";
	var share_title = "[에누리 가격비교] 무더운 여름 시원한 혜택을 누리다!\n매주 목요일 타임특가도 만나보세요!";
</script>
</head>
<body>
<div id="eventWrap">

	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp" %>

	<!-- 플로팅 배너 - 둥둥이 -->
    <div id="floating_bnr" class="floating_bnr">
        <a href="/mobilefirst/event2020/summer_2020_evt.jsp?tab=2&freetoken=event" target="_blank" title="새 창으로 이동합니다." onclick="ga_log(8);"><img src="http://img.enuri.info/images/event/2020/summer/fl_bnr.png" alt="매주 목요일 여름준비 타임딜!"></a>
        <!-- 닫기 -->
        <a href="javascript:void(0);" class="btn_close" onclick="onoff('floating_bnr');return false;">
            <span class="blind">닫기</span>
        </a>
    </div>
    <!-- // -->

	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">
		<!-- 상단비주얼 -->
		<div class="visual week45">
			<!-- 공통 : 공유하기 버튼  -->
			<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
			<!-- // -->
			<div class="inner">
				<span class="txt_01">HOT SUMMER</span>
				<h2>여름에 누리다</h2>
				<span class="txt_02">여름준비 타임특가+딜라이트 탄산수 제조기 당첨!</span>
			</div>
			<div class="loader-box">
				<div class="visual-loader"></div>
			</div>
			<script>
				// 상단 타이틀 등장 모션
				$(document).ready(function(){
					var $visual = $(".toparea .visual");
					// $visual.addClass("intro");
					setTimeout(function(){
						$visual.addClass("intro");
						// $visual.addClass("end");
					},2100)
				})
			</script>
		</div>

		<!-- 플로팅 탭 -->
		<div class="floattab">
			<div class="floattab__list">
				<div class="scrollList">
					<ul class="floatmove">
						<li><a href="#evt1" class="floattab__item floattab__item--01" onclick="ga_log(2);"><em>타임특가!</em></a></li>
						<li><a href="#evt6" class="floattab__item floattab__item--06" onclick="ga_log(7);"><em>완벽한 바캉스 준비</em></a></li>
						<li><a href="#evt5" class="floattab__item floattab__item--05" onclick="ga_log(6);"><em>Flex한 국내여행</em></a></li>
						<li><a href="#evt4" class="floattab__item floattab__item--04" onclick="ga_log(5);"><em>프로집콕러 홈캉스템</em></a></li>
						<li><a href="#evt3" class="floattab__item floattab__item--03" onclick="ga_log(4);"><em>기력보충 제철음식</em></a></li>
						<li><a href="#evt2" class="floattab__item floattab__item--02" onclick="ga_log(3);"><em>COOL한 계절가전</em></a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<!-- 이벤트01 -->
	<div id="evt1" class="section dealwrap scroll">
		<div class="contents">
			<h2>
				<span class="tit_txt_01 blind">매주 목요일 오후 2시 OPEN</span>
				<span class="tit_date">
					<!-- 월일 노출 -->
					<span class="txt_month"></span>월 <span class="txt_day"></span>일
				</span>
				<strong class="tit_txt_02 blind">여름 타임특가</strong>
			</h2>
			<!-- 딜 구매영역 -->
			<div class="deal_slide">
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
				<a href="#" class="sprite btn_caution evt-caution-1" onclick="onoff('notetxt1'); return false;">꼭!확인하세요</a>
			</div>
		</div>
	</div>
	<!-- // 이벤트01 -->

	<!-- 중단배너 -->
	<div class="mid_banner">
		<a href="/mobilefirst/event2020/summer_2020_evt.jsp?tab=1&freetoken=event" target="_blank" title="새 창으로 이동합니다." onclick="ga_log(12);"><img src="http://img.enuri.info/images/event/2020/summer/m_mid_banner.jpg" alt="매일매일 터지는 100%당첨 이벤트 스타벅스 라임 패션 티를 찾아라!" /></a>
	</div>
	<!-- 중단배너 -->

	<!-- 추천 상품 영역 -->
	<div class="section pro_itemlist">
		<h2>바캉스부터 홈캉스까지! <em>여름을 100% 즐기는</em> 쇼핑가이드</h2>

		<div class="inner">
			<!-- 바캉스 -->
			<div id="evt6" class="item_group item_group_05 scroll">
				<h3>
					<span class="txt_sub">내 마음 속에 저장</span>
					<strong class="txt_tit">완벽한 휴가를 위한 <em>바캉스 준비</em></strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab5-1">바캉스</a></li>
					<li><a href="#protab5-2">의류</a></li>
					<li><a href="#protab5-3">카메라/액션캠</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 바캉스 상품 -->
					<div id="protab5-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/m/list.jsp?cate=090920" target="_blank">상품더보기</a>
					</div>
					<!-- //바캉스 상품 -->

					<!-- 의류 상품 -->
					<div id="protab5-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/m/list.jsp?cate=1434" target="_blank">상품더보기</a>
					</div>
					<!-- //의류 상품 -->

					<!-- 카메라/액션캠 상품 -->
					<div id="protab5-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/m/list.jsp?cate=0242" target="_blank">상품더보기</a>
					</div>
					<!-- //카메라/액션캠 상품 -->
				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 바캉스 -->

			<!-- 모바일 쿠폰 -->
			<div id="evt5" class="item_group item_group_04 scroll">
				<h3>
					<span class="txt_sub">멀리 못가더라도 Flex한 준비</span>
					<strong class="txt_tit"><em>국내여행</em>을 위한 럭셔리한 준비</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab4-1">호캉스</a></li>
					<li><a href="#protab4-2">캠핑</a></li>
					<li><a href="#protab4-3">외식상품권</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 호캉스 상품 -->
					<div id="protab4-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/m/list.jsp?cate=164720" target="_blank">상품더보기</a>
					</div>
					<!-- //호캉스 상품 -->

					<!-- 렌트 상품 -->
					<div id="protab4-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/m/list.jsp?cate=0920" target="_blank">상품더보기</a>
					</div>
					<!-- //렌트 상품 -->

					<!-- 외식상품권 상품 -->
					<div id="protab4-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/m/list.jsp?cate=164716" target="_blank">상품더보기</a>
					</div>
					<!-- //외식상품권 상품 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 모바일 쿠폰 -->
			<!-- 프로모션배너 -->
			<div class="pro_banner">
				<a href="/mobilefirst/event2020/summer_2020_evt.jsp?tab=2&freetoken=event" target="_blank" title="새 창으로 이동합니다." onclick="ga_log(23);"><img src="http://img.enuri.info/images/event/2020/summer/m_pro_banner.jpg" alt="모바일 APP에서 여름나기템 구매하면 머리까지 짜릿해지는 탄산수 머신 당첨!" /></a>
			</div>
			<!-- 프로모션배너 -->
			<!-- 홈캉스템 -->
			<div id="evt4" class="item_group item_group_03 scroll">
				<h3>
					<span class="txt_sub">홈캉스도 준비가 필요해</span>
					<strong class="txt_tit"><em>프로집콕러</em>를 위한 홈캉스템</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab3-1">홈카페</a></li>
					<li><a href="#protab3-2">게임기</a></li>
					<li><a href="#protab3-3">DIY</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 홈카페 상품 -->
					<div id="protab3-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/m/list.jsp?cate=0606" target="_blank">상품더보기</a>
					</div>
					<!-- //홈카페 상품 -->

					<!-- 게임기 상품 -->
					<div id="protab3-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/m/list.jsp?cate=040836" target="_blank">상품더보기</a>
					</div>
					<!-- //게임기 상품 -->

					<!-- DIY 상품 -->
					<div id="protab3-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/m/list.jsp?cate=101021" target="_blank">상품더보기</a>
					</div>
					<!-- //DIY 상품 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 홈캉스템 -->
			<!-- 제철음식 필수템 -->
			<div id="evt3" class="item_group item_group_02 scroll">
				<h3>
					<span class="txt_sub">지친 원기회복을 위한</span>
				<strong class="txt_tit"><em>기력보충</em> 제철음식</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab2-1">보양식</a></li>
					<li><a href="#protab2-2">빙과류</a></li>
					<li><a href="#protab2-3">제철과일</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 보양식 상품 -->
					<div id="protab2-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/m/list.jsp?cate=15110403" target="_blank">상품더보기</a>
					</div>
					<!-- //보양식 상품 -->

					<!-- 빙과류 상품 -->
					<div id="protab2-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/m/list.jsp?cate=150819" target="_blank">상품더보기</a>
					</div>
					<!-- //빙과류 상품 -->

					<!-- 제철과일 상품 -->
					<div id="protab2-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/m/list.jsp?cate=15020311" target="_blank">상품더보기</a>
					</div>
					<!-- //제철과일 상품 -->
				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 제철음식 필수템 -->

			<!-- 여름가전 아이템 -->
			<div id="evt2" class="item_group item_group_01 scroll">
				<h3>
					<span class="txt_sub">더위를 한 번에 날려버릴</span>
				<strong class="txt_tit"><em>COOL</em>한 여름가전</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab1-1">에어컨</a></li>
				<li><a href="#protab1-2">제습기</a></li>
				<li><a href="#protab1-3">공기순환기</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">
					<!-- 에어컨 상품 -->
					<div id="protab1-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/m/list.jsp?cate=2401" target="_blank">상품더보기</a>
					</div>
					<!-- //에어컨 상품 -->

					<!-- 제습기 상품 -->
					<div id="protab1-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/m/list.jsp?cate=240322" target="_blank">상품더보기</a>
					</div>
					<!-- //제습기 상품 -->

					<!-- 공기순환기 상품 -->
					<div id="protab1-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="/m/list.jsp?cate=240215" target="_blank">상품더보기</a>
					</div>
					<!-- //공기순환기 상품 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 여름가전 아이템 -->
		</div>
	</div>
	<!-- //추천 상품 영역 -->

	<!-- 에누리 혜택 -->
	<%@include	file = "/eventPlanZone/jsp/eventBannerTapMobile_201908.jsp"%>
	<!-- //에누리 혜택 -->
	<script>
	$('.banlist > li').click(function(){
		ga_log(39);
	});
	</script>
	<!-- //Contents -->

<!-- 	<span class="go_top"><a href="#">TOP</a></span> -->
</div>

<!-- (신규) 공통 : SNS공유하기 -->
<div class="com__share_wrap dim" style="z-index:10000;display:none">
	<div class="com__layer share_layer">
		<div class="lay_head">공유하기</div>
		<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
		<div class="lay_inner">
			<ul>
				<li class="share_fb" onclick="Share_Sns('face');">페이스북 공유하기</li>
				<li class="share_kakao" onclick="Share_Sns('kakao');">카카오톡 공유하기</li>
				<li class="share_tw" onclick="Share_Sns('tw')">트위터 공유하기</li>
			</ul>
			<div class="btn_wrap">
				<div class="btn_group">
					<!-- 주소복사하기 -->
					<div class="btn_item">
						<span id="txtURL" class="txt__share_url"></span>
						<button class="btn__share_copy" data-clipboard-target="#txtURL">복사</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- // -->
<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
<script type="text/javascript" src="/js/clipboard.min.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20190611"></script>
<script type="text/javascript" src="/mobilefirst/event/js/exhibition_m.js"></script>
<script type="text/javascript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
<script>
	$(function(){
		$('#txtURL').text(location.href);
		var clipboard = new ClipboardJS('.com__share_wrap .btn__share_copy');
		clipboard.on('success', function(e) {
			alert('주소가 복사되었습니다');
		});
		clipboard.on('error', function(e) {
			console.log(e);
		});
	});
</script>

<!-- layer-->
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btn();">설치하기</button></p>
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
				<li>타임특가는 에누리 및 인터파크 ID 1개 당 1번만 구매 가능하며, 부정적인 방법으로 동일 상품을 1번 이상 구매한 경우 결제완료 한 경우라도 모든 구매 및 결제가 취소처리 됩니다.</li>
				<li>본 이벤트는 당사에 사정에 따라 사전고지 없이 변경 또는 조기종료 될 수 있습니다.</li>
				<li>시즌기획전 타임딜은 선착순 한정수량 판매로 결제 진행 중 상품이 품절될 경우 판매가 종료될 수 있습니다.</li>
				<li>에누리 모바일 APP에서만 구매가능하며, 다른 환경(인터파크 APP 등)에서 구매시도하여 발생되는 문제에 대해서는 책임 및 보상이 이루어지지 않습니다.</li>
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
var vEvent_title = "20 무더위통합기획전";
var gaLabel = [  "20 무더위 통합기획전_PV"
				,"20 무더위 통합기획전_상단탭_타임특가"
				,"20 무더위 통합기획전_상단탭_여름가전"
				,"20 무더위 통합기획전_상단탭_제철음식"
				,"20 무더위 통합기획전_상단탭_홈캉스"
				,"20 무더위 통합기획전_상단탭_모바일쿠폰"
				,"20 무더위 통합기획전_상단탭_바캉스"
				,"20 무더위 통합기획전_상단플로팅배너"
				,"20 무더위 통합기획전_타임딜_상품보기"
				,"20 무더위 통합기획전_타임딜_APP구매하기"
				,"20 무더위 통합기획전_타임딜_썸네일"
				,"20 무더위 통합기획전_프로모션_이벤트1_배너"
				,"20 무더위 통합기획전_여름가전_탭_에어컨"
				,"20 무더위 통합기획전_여름가전_탭_제습기"
				,"20 무더위 통합기획전_여름가전_탭_공기순환기"
				,"20 무더위 통합기획전_여름가전_상품클릭"
				,"20 무더위 통합기획전_여름가전_상품더보기"
				,"20 무더위 통합기획전_원기음식_탭_보양식"
				,"20 무더위 통합기획전_원기음식_탭_빙과류"
				,"20 무더위 통합기획전_원기음식_탭_제철과일"
				,"20 무더위 통합기획전_원기음식_상품클릭"
				,"20 무더위 통합기획전_원기음식_상품더보기"
				,"20 무더위 통합기획전_프로모션_이벤트2_배너"
				,"20 무더위 통합기획전_홈캉스_탭_홈카페"
				,"20 무더위 통합기획전_홈캉스_탭_게임기"
				,"20 무더위 통합기획전_홈캉스_탭_DIY"
				,"20 무더위 통합기획전_홈캉스_상품클릭"
				,"20 무더위 통합기획전_홈캉스_상품더보기"
				,"20 무더위 통합기획전_모바일쿠폰_탭_호캉스"
				,"20 무더위 통합기획전_모바일쿠폰_탭_렌트"
				,"20 무더위 통합기획전_모바일쿠폰_탭_외식상품권"
				,"20 무더위 통합기획전_모바일쿠폰_상품클릭"
				,"20 무더위 통합기획전_모바일쿠폰_상품더보기"
				,"20 무더위 통합기획전_바캉스_탭_바캉스"
				,"20 무더위 통합기획전_바캉스_탭_의류"
				,"20 무더위 통합기획전_바캉스_탭_카메라/액션캠"
				,"20 무더위 통합기획전_바캉스_상품클릭"
				,"20 무더위 통합기획전_바캉스_상품더보기"
				,"20 무더위 통합기획전_혜택배너" ];

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

$(document).ready(function(){
	//ga > pageview
	ga_log(1);

	//ga > 탭
	tabLog('#evt2', 13);
	tabLog('#evt3', 18);
	tabLog('#evt4', 24);
	tabLog('#evt5', 29);
	tabLog('#evt6', 34);

	//ga > 더보기
	moreViewLog('#evt2',17);
	moreViewLog('#evt3',22);
	moreViewLog('#evt4',28);
	moreViewLog('#evt5',33);
	moreViewLog('#evt6',38);

	//#애드브릭스 타임특가 PV
	setTimeout(function(){
		welcomeGa("evt_summer deal_view");
	},500);

	//딜 상품
	$.ajax({
		  url: "/mobilefirst/http/json/exh_deal_list_2020061800.json"
		, dataType : "json"
		, cache    : false
		, success  : function(data){
			var vCur_dtm = "<%= strToday %>";
			var dealItem = "";
			var dealList = "";
			var month = "";
			var day = "";
			var text = "";
			$.each(data, function(i,v){
				//딜 판매날짜, 할인률
				month = parseInt(v.GD_SAL_S_DTM_CVT.substring(4,6));
				day = parseInt(v.GD_SAL_S_DTM_CVT.substring(6,8));
				text = v.GD_DC_RT+"% 타임특가 / "+v.GD_QTY+"개 한정";
				cnt = data.length;

				dealItem += "<div class=\"deal_item clearfix\">";
				dealItem += "	<div class=\"container\">";
				dealItem += "		<div class=\"thumb\">";
				dealItem += "			<img src=\"http://storage.enuri.info/Web_Storage"+v.GD_IMG_URL+"\" />";
				dealItem += "			<span class=\"ico_limit\">";
				dealItem += "				<strong>"+v.GD_DC_RT+"%</strong>";
				dealItem += "				<span class='txt_limit'>선착순 "+v.GD_QTY+"개</span>";
				dealItem += "			</span>";
				dealItem += "		</div>";
                dealItem += "		<div class=\"item_info\">";
                dealItem += "			<div class=\"inner\">";
                dealItem += "				<p class=\"tit\">"+v.GD_MODEL_NM1+"&nbsp"+v.GD_MODEL_NM2+"</p>";
                dealItem += "				<p class=\"price\"><strong>"+commaNum(v.GD_DC_PRC)+"<span>원</span></strong></p>";
                dealItem += "			</div>";
                dealItem += "			<ul class=\"btn_area clearfix\" id=\"ul_btn"+i+"\">";
                dealItem += "				<li><a href=\"/mobilefirst/detail.jsp?modelno="+v.GD_MODEL_NO+"&freetoken=vip\" class=\"btn_dview\" target=\"_blank\" onclick=\"ga_log(9)\">상품보기</a></li>";
                if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT > vCur_dtm) { //판매 전
	                dealItem += "			<li id='deal_btn'><a class=\"btn_buy_ready\">판매예정</a></li>";
		        }else if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT <= vCur_dtm && v.GD_SAL_E_DTM_CVT >= vCur_dtm){ //판매 중
	                dealItem += "			<li id='deal_btn'><a class=\"btn_buy\" onclick=\" fnDeal("+v.EXH_DEAL_NO+",'2020061800'); ga_log(10); return false;\">구매하기</a></li>";
		        }else{ // 판매 종료
	                dealItem += "			<li id='deal_btn'><a class=\"btn_buy_soldout\">Sold out</a></li>";
	        	}
                dealItem += "			</ul>";
                dealItem += "		</div>";
                dealItem += "	<p class=\"ad\">※ 쿠폰적용 필수 / ID당 1회 구매가능 / 무료배송 <span class=\"mark\"><img src=\"http://img.enuri.info/images/event/2020/newyear/ico_interpark.png\" alt=\"인터파크\"></span></p>";
        	    dealItem += "	</div>";
        	    dealItem += "</div>";

        		dealList += "<div class=\"w_item\" onclick=\"ga_log(11);\">";
                dealList += "	<div class=\"w_thumb\">";
                dealList += "		<img src=\"http://storage.enuri.info/Web_Storage"+v.GD_IMG_URL+"\" />";
                dealList += "	</div>";
				dealList += "	<div class=\"period\">";
                dealList += "		<span id='date'>"+month+"/"+day+"</span><span id=week>("+getWeek(v.GD_SAL_S_DTM_CVT)+") 14:00</span>";
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
			}else{
				//앱 전용 이미지
// 				$('.dealwrap h2').css({ 'text-align': 'center'
// 									  , 'height': '220px','background': 'url(http://img.enuri.info/images/event/2020/new_semester/m_deal_tit2.png) 50% 0%'
// 									  , 'background-repeat':'no-repeat'
// 									  , 'background-size': '320px'});

// 				$('.dealwrap h2 .tit_date').css({ 'padding-top': '75px'});
			}
		}
	});

	//상품 영역
	var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=37";
// 	var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.json";

	$.ajax({
		  dataType : "json"
		, url	   : loadUrl
		, success  : function(result){
			var banner = result.R;
			var tab = result.T;
			var tabSize = 3; //컨텐츠 별 탭 개수
			var listSize = 4; //노출 상품 개수
			var logNo = [16,21,27,32,37];
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

			//플로팅 상단 탭 이동
			$(document).on('click', '.floattab__list .floatmove a', function(e) {
				var $anchor = Math.ceil($($(this).attr('href')).offset().top);
				$('html, body').stop().animate({scrollTop: $anchor - $navHgt}, 500);
				e.preventDefault();
			});

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
	}
	// 네비 이동영역의 ScrollTop 보관
	$scrTarget.each(function(e){
		posScr[e] = $(this).offset().top - $nav.outerHeight();
	})
	// 상단 탭 position 변경 및 버튼 활성화
	$(window).scroll(function(){
		var $currY = $(this).scrollTop() // 현재 scroll
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
	dealDate();

	$deal_slide.on('beforeChange', function(e, s, c, n){
    	$w_item.removeClass("slick-current");
    	$w_item.eq(n).addClass("slick-current");
    	dealDate();
    });
}

function dealDate(){
	var $txt_month = $('#evt1 .contents .tit_date .txt_month');
	var $txt_day = $('#evt1 .contents .tit_date .txt_day');
	var dealDate = new Array();

	dealDate = $('.w_item.slick-current .period #date').text().split('/');
	$txt_month.text(dealDate[0]);
	$txt_day.text(dealDate[1]);
}
</script>
</body>
</html>