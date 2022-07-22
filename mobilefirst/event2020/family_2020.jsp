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
	response.sendRedirect("/event2020/family_2020.jsp");
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
<meta name="title" content="2020 가정의달 통합기획전 – 최저가 쇼핑은 에누리">
<meta name="description" content="온 가족 타임특가! 온 가족 선물 최저가로 미리 하고, 에어팟 프로 당첨!">
<meta name="keyword" content="에누리가격비교, 통합기획전, 2020년 가정의달, 5월, 어린이날, 어버이날, 스승의날, 에어팟, 가정의달 준비">
<meta property="og:title" content="[에누리 가격비교] 가족 모두 혜택을 누리다! 매주 목요일 타임특가도 만나보세요!">
<meta property="og:description" content="가족 모두 혜택을 누리다! 매주 목요일 타임특가도 만나보세요!">
<meta property="og:image" content="http://img.enuri.info/images/event/2020/family/sns_1200_631.jpg">
<meta name="format-detection" content="telephone=no" />
<title>2020 가정의달 통합기획전 – 최저가 쇼핑은 에누리</title>
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<link rel="stylesheet" href="/css/event/y2020/family_m.css" type="text/css">
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
</script>
</head>
<body>
<div id="eventWrap">

	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp" %>

	<!-- 플로팅  - 둥둥이 -->
    <div id="floating_bnr" class="floating_bnr">
        <a href="/mobilefirst/event2020/family_2020_evt.jsp?tab=2" target="_blank;" onclick="ga_log(7);"><img src="http://img.enuri.info/images/event/2020/family/fl_bnr.png" alt="온가족 선물하고 에어팟 당첨!"></a>
        <!-- 닫기 -->
        <a href="javascript:void(0);" class="btn_close" onclick="onoff('floating_bnr');return false;">
            <span class="blind">닫기</span>
        </a>
    </div>
    <!-- // -->

	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">
		<!-- 상단비주얼 -->
		<div class="visual">
			<!-- 공통 : 공유하기 버튼  -->
			<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
			<!-- // -->
			<div class="inner">
				<span class="txt_01">온 가족 타임특가 + 에어팟 프로 당첨!</span>
				<span class="txt_tit_01">가족 모두 혜택을</span>
				<span class="txt_tit_02">에누리다!</span>
				<span class="obj_heart"><!-- 愛 --></span>
			</div>
			<div class="loader-box">
				<div class="visual-loader"></div>
			</div>
			<script>
				// 상단 타이틀 등장 모션
				$(window).load(function(){
					var $visual = $(".toparea .visual");
					// $visual.addClass("intro");
					setTimeout(function(){
						$visual.addClass("intro");
						// $visual.addClass("end");
					},1000)
				})
			</script>
		</div>

		<!-- 플로팅 탭 -->
		<div class="floattab">
			<div class="floattab__list">
				<div class="scrollList">
					<ul class="floatmove">
						<li><a href="#evt1" class="floattab__item floattab__item--01" onclick="ga_log(2);"><em>타임특가</em></a></li>
						<li><a href="#evt2" class="floattab__item floattab__item--02" onclick="ga_log(3);"><em>아이 선물</em></a></li>
						<li><a href="#evt3" class="floattab__item floattab__item--03" onclick="ga_log(4);"><em>부모 선물</em></a></li>
						<li><a href="#evt4" class="floattab__item floattab__item--04" onclick="ga_log(5);"><em>반려동물 선물</em></a></li>
						<li><a href="#evt5" class="floattab__item floattab__item--05" onclick="ga_log(6);"><em>나를 위한 선물</em></a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<!-- DEAL페이지 -->
	<div id="evt1" class="section dealwrap scroll">
		<div class="contents">
			<h2>
				<span class="tit_txt_01 blind">매주 목요일 오후 2시 OPEN</span>
				<span class="tit_date">
					<!-- 월일 노출 -->
					<span class="txt_month">4</span>월 <span class="txt_day">16</span>일
				</span>
				<strong class="tit_txt_02 blind"></strong>
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
			<!--// 딜 리스트영역 -->
		</div>
	</div>
	<!-- //DEAL페이지 -->

	<!-- 추천 상품 영역 -->
	<div class="section pro_itemlist">
		<h2>아이, 부모 선물은 물론! 우리집 댕댕이 까지, <em>모두에게 이쁨받는</em> 쇼핑가이드</h2>
		<div class="inner">

			<!--  아이 선물 굿 아이템 -->
			<div id="evt2" class="item_group item_group_01 scroll">
				<h3>
					<span class="txt_sub">우리 아이는 어린이날만 기다린다구요!</span>
					<strong class="txt_tit">아이 선물 굿 아이템</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab1-1">태블릿 PC</a></li>
					<li><a href="#protab1-2">자전거/킥보드</a></li>
					<li><a href="#protab1-3">완구/장난감</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">
					<!--
						SLICK $(".itemlist")
						3개의 탭 콘텐츠가 있습니다. "tab_content"
						하나의 콘텐츠마다 ul 단위로 한 판(상품4개)씩 움직입니다.
					-->
					<!-- 태블릿 PC 상품 -->
					<div id="protab1-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=0305" target="_blank;">상품더보기</a>
					</div>
					<!-- //태블릿 PC 상품 -->

					<!-- 자전거/킥보드 상품 -->
					<div id="protab1-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=0905" target="_blank;">상품더보기</a>
					</div>
					<!-- //자전거/킥보드 상품 -->

					<!-- 완구/장난감 상품 -->
					<div id="protab1-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=1014" target="_blank;">상품더보기</a>
					</div>
					<!-- //완구/장난감 상품 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 새학기 패션 아이템-->

			<!-- 부모님 선물 굿 아이템 -->
			<div id="evt3" class="item_group item_group_02 scroll">
				<h3>
					<span class="txt_sub">자나 깨나 부모님 생각</span>
					<strong class="txt_tit">부모님 선물 굿 아이템</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab2-1">건강식품</a></li>
					<li><a href="#protab2-2">건강가전</a></li>
					<li><a href="#protab2-3">의류</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 건강식품 상품 -->
					<div id="protab2-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=150105" target="_blank;">상품더보기</a>
					</div>
					<!-- //건강식품 상품 -->

					<!-- 건강가전 상품 -->
					<div id="protab2-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=0510" target="_blank;">상품더보기</a>
					</div>
					<!-- //건강가전 상품 -->

					<!-- 의류 상품 -->
					<div id="protab2-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=0913" target="_blank;">상품더보기</a>
					</div>
					<!-- //의류 상품 -->
				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 부모님 선물 굿 아이템 -->

			<!-- 우리집 막내 댕냥이 굿템 -->
			<div id="evt4" class="item_group item_group_03 scroll">
				<h3>
					<span class="txt_sub">나도 가족이라구욧!</span>
					<strong class="txt_tit">우리집 막내 댕냥이 굿템</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab3-1">댕댕이 맛집</a></li>
					<li><a href="#protab3-2">냥냥이 맛집</a></li>
					<li><a href="#protab3-3">외출/미용</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 댕댕이 맛집 상품 -->
					<div id="protab3-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=164219" target="_blank;">상품더보기</a>
					</div>
					<!-- //댕댕이 맛집 상품 -->

					<!-- 냥냥이 맛집 상품 -->
					<div id="protab3-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=164220" target="_blank;">상품더보기</a>
					</div>
					<!-- //냥냥이 맛집 상품 -->

					<!-- 외출/미용 상품 -->
					<div id="protab3-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=164208" target="_blank;">상품더보기</a>
					</div>
					<!-- //외출/미용 상품 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 우리집 막내 댕냥이 굿템 -->

			<!-- 오직 나를 위한 굿 아이템 -->
			<div id="evt5" class="item_group item_group_04 scroll">
				<h3>
					<span class="txt_sub">드디어 시작, 걱정말고 준비하자!</span>
					<strong class="txt_tit">온라인 개학 굿템</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab4-1">PC</a></li>
					<li><a href="#protab4-2">노트북</a></li>
					<li><a href="#protab4-3">헤드셋/웹캠</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- PC 상품 -->
					<div id="protab4-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=0401" target="_blank;">상품더보기</a>
					</div>
					<!-- //PC 상품 -->

					<!-- 노트북 상품 -->
					<div id="protab4-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=0404" target="_blank;">상품더보기</a>
					</div>
					<!-- //노트북 상품 -->

					<!-- 헤드셋/키보드 상품 -->
					<div id="protab4-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="http://m.enuri.com/m/list.jsp?cate=0704" target="_blank;">상품더보기</a>
					</div>
					<!-- //헤드셋/키보드 상품 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 오직 나를 위한 굿 아이템 -->
		</div>
	</div>
	<!-- //추천 상품 영역 -->

	<!-- 가볍게 Flex! 에어팟 프로 당첨! -->
	<div class="event_bnr">
		<a href="/mobilefirst/event2020/family_2020_evt.jsp?tab=2" target="_blank;">
			<img src="http://img.enuri.info/images/event/2020/family/m_aside_bnr2.jpg" alt="가볍게 Flex! 에어팟 프로 당첨!" onclick="ga_log(31);">
		</a>
	</div>
	<!-- // -->

	<!-- 에누리 혜택 -->
	<%@include	file = "/eventPlanZone/jsp/eventBannerTapMobile_201908.jsp"%>
	<!-- //에누리 혜택 -->
	<script>
	$('.banlist > li').click(function(){
		ga_log(32);
	});
	</script>
	<!-- //Contents -->

	<span class="go_top"><a href="#">TOP</a></span>
</div>

<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
<script type="text/javascript" src="/js/clipboard.min.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20190611"></script>
<script type="text/javascript" src="/mobilefirst/event/js/exhibition_m.js"></script>
<script type="text/javascript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>

<!-- 공통 : SNS공유하기 -->
<div class="com__share_wrap dim" style="z-index:10000;display:none">
	<div class="com__layer share_layer">
		<div class="lay_head">공유하기</div>
		<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
		<div class="lay_inner">
			<ul>
				<li class="share_fb">페이스북 공유하기</li>
				<li class="share_kakao" id="kakao-link-btn">카카오톡 공유하기</li>
				<li class="share_tw">트위터 공유하기</li>
				<!-- <li class="share_line">라인 공유하기</li> -->
				<!-- 메일아이콘 클릭시 활성화(.on) -->
				<!-- <li class="share_mail" onclick="$(this).toggleClass('on');$(this).parents('.share_layer').find('.btn_wrap').toggleClass('mail_on');">메일로 공유하기</li> -->
				<!-- <li class="share_story">카카오스토리 공유하기</li> -->
				<!-- <li class="share_band">밴드 공유하기</li> -->
			</ul>
			<!-- 메인보내기 버튼클릭시 .mail_on 추가해 주세요 -->
			<div class="btn_wrap">
				<div class="btn_group">
					<!-- 주소복사하기 -->
					<div class="btn_item">
						<span id="txtURL" class="txt__share_url">http://www.enuri.com/mobilefirst/event2020/family_2020.jsp</span>
						<button class="btn__share_copy" data-clipboard-target="#txtURL">복사</button>
					</div>
					<!-- 이메일주소 입력하기 -->
					<div class="btn_item">
						<input type="text" class="txt__share_mail" placeholder="이메일 주소 입력해 주세요">
						<button class="btn__share_mail">보내기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="/js/clipboard.min.js"></script>
	<script>
		$(function(){
			var clipboard = new ClipboardJS('.com__share_wrap .btn__share_copy');
			clipboard.on('success', function(e) {
				alert('주소가 복사되었습니다');
			});
			clipboard.on('error', function(e) {
				console.log(e);
			});
		});
	</script>
</div>
<!-- // -->


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
				<li>타임특가는 에누리 및 인터파크 ID 1개 당 1번만 구매 가능하며, 부정적인 방법으로 동일 상품을 1번 이상 구매한 경우  결제완료 한 경우라도 모든 구매 및 결제가 취소처리 됩니다.</li>
				<li>부정한 방법으로 상품 구매 시 주문이 취소될 수 있습니다.</li>
				<li>본 이벤트는 당사에 사정에 따라 사전고지 없이 변경 또는 조기종료 될 수 있습니다.</li>
				<li>시즌기획전 타임딜은 선착순 한정수량 판매로 결제 진행 중 상품이 품절될 경우 판매가 종료될 수 있습니다.</li>
				<li>에누리 모바일 APP에서만 구매가능하며, 다른 환경(인터파크 APP 등)에서 구매시도하여 발생되는 문제에 대해서는 책임 및 보상이 이루어지지 않습니다.</li>			</ul>
		</div>
		<p class="btn_close"><button type="button" onclick="onoff('notetxt1');return false;">닫기</button></p>
	</div>
</div>

<script type="text/javascript">
var cnt = 0;
var $navHgt = 0;
var app = getCookie("appYN"); //app인지 여부
var makeHtml = "";
var vEvent_title = "20 가정의달 통합기획전";
var gaLabel = [
				 "20 가정의달 통합기획전_PV"
				,"20 가정의달 통합기획전_상단탭_타임특가"
				,"20 가정의달 통합기획전_상단탭_아이선물"
				,"20 가정의달 통합기획전_상단탭_부모선물"
				,"20 가정의달 통합기획전_상단탭_반려동물선물"
				,"20 가정의달 통합기획전_상단탭_나를위한선물"
				,"20 가정의달 통합기획전_상단플로팅배너"
				,"20 가정의달 통합기획전_타임딜_상품보기"
				,"20 가정의달 통합기획전_타임딜_APP구매하기"
				,"20 가정의달 통합기획전_타임딜_썸네일"
				,"20 가정의달 통합기획전_아이선물_탭_태블릿PC"
				,"20 가정의달 통합기획전_아이선물_탭_자전거"
				,"20 가정의달 통합기획전_아이선물_탭_장난감"
				,"20 가정의달 통합기획전_아이선물_상품클릭"
				,"20 가정의달 통합기획전_아이선물_상품더보기"
				,"20 가정의달 통합기획전_부모선물_탭_건강식품"
				,"20 가정의달 통합기획전_부모선물_탭_건강가전"
				,"20 가정의달 통합기획전_부모선물_탭_의류"
				,"20 가정의달 통합기획전_부모선물_상품클릭"
				,"20 가정의달 통합기획전_부모선물_상품더보기"
				,"20 가정의달 통합기획전_반려동물선물_탭_댕댕이맛집"
				,"20 가정의달 통합기획전_반려동물선물_탭_냥냥이맛집"
				,"20 가정의달 통합기획전_반려동물선물_탭_외출미용"
				,"20 가정의달 통합기획전_반려동물선물_상품클릭"
				,"20 가정의달 통합기획전_반려동물선물_상품더보기"
				,"20 가정의달 통합기획전_나를위한선물_탭_캠핑"
				,"20 가정의달 통합기획전_나를위한선물_탭_차량용아이템"
				,"20 가정의달 통합기획전_나를위한선물_탭_상품권"
				,"20 가정의달 통합기획전_나를위한선물_상품클릭"
				,"20 가정의달 통합기획전_나를위한선물_탭_상품더보기"
				,"20 가정의달 통합기획전_프로모션띠배너"
				,"20 가정의달 통합기획전_혜택배너"
				];

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
	//pageview
	ga_log(1);

	//탭 ga
	tabLog('#evt2', 11);
	tabLog('#evt3', 16);
	tabLog('#evt4', 21);
	tabLog('#evt5', 26);

	//더보기 ga
	moreViewLog('#evt2',15);
	moreViewLog('#evt3',20);
	moreViewLog('#evt4',25);
	moreViewLog('#evt5',30);

	//#타임특가 PV
	setTimeout(function(){
		welcomeGa("evt_newsemester_deal_view");
	},500);

	//딜 상품
	$.ajax({
		  url: "/mobilefirst/http/json/exh_deal_list_2020032000.json"
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
                dealItem += "				<li><a href=\"/mobilefirst/detail.jsp?modelno="+v.GD_MODEL_NO+"&freetoken=vip\" class=\"btn_dview\" target=\"_blank\" onclick=\"ga_log(8)\">상품보기</a></li>";
                if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT > vCur_dtm) { //판매 전
	                dealItem += "			<li id='deal_btn'><a class=\"btn_buy_ready\">판매예정</a></li>";
		        }else if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT <= vCur_dtm && v.GD_SAL_E_DTM_CVT >= vCur_dtm){ //판매 중
	                dealItem += "			<li id='deal_btn'><a class=\"btn_buy\" onclick=\" fnDeal("+v.EXH_DEAL_NO+",'2020032000'); ga_log(9); return false;\">구매하기</a></li>";
		        }else{ // 판매 종료
	                dealItem += "			<li id='deal_btn'><a class=\"btn_buy_soldout\">Sold out</a></li>";
	        	}
                dealItem += "			</ul>";
                dealItem += "		</div>";
                dealItem += "	<p class=\"ad\">※ 쿠폰적용 필수 / ID당 1회 구매가능 / 무료배송 <span class=\"mark\"><img src=\"http://img.enuri.info/images/event/2020/newyear/ico_interpark.png\" alt=\"인터파크\"></span></p>";
        	    dealItem += "	</div>";
        	    dealItem += "</div>";

        		dealList += "<div class=\"w_item\" onclick=\"ga_log(10);\">";
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
				deal_btn.text('구매하기');
				deal_btn.removeAttr('onclick');
				deal_btn.attr('onclick',"$('#app_only').show();");
			}else{
				//앱 전용 이미지
				$('.dealwrap h2').css({ 'text-align': 'center'
									  , 'height': '220px','background': 'url(http://img.enuri.info/images/event/2020/family/m_deal_tit.png) 50% 0%'
									  , 'background-repeat':'no-repeat'
									  , 'background-size': '320px'});

				/* $('.dealwrap h2 .tit_date').css({ 'padding-top': '75px'}); */
			}
		}
	});

	//상품 영역
	var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=34";

	$.ajax({
		  dataType : "json"
		, url	   : loadUrl
		, success  : function(result){
			var banner = result.R;
			var tab = result.T;
			var tabSize = 3; //컨텐츠 별 탭 개수
			var listSize = 4; //노출 상품 개수
			var logNo = [14,19,24,29];
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
					$navHgt = Math.ceil($(".floattab__list").height());
				$('html, body').stop().animate({scrollTop: $anchor - $navHgt}, 500);
				e.preventDefault();
			});

			//파라이터값 tab 이동
			if(tab > 0) tabMove(tab, $navHgt);

		}
	});

	// 공유하기
	 $(".share_kakao").on('click', function(){
    	Share_detail('kakao');
	});
	$(".share_fb").on('click', function(){
		Share_detail('face');
	});
	$(".share_tw").on('click', function(){
		Share_detail('twitter');
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

// 공유하기(kakao)
//Kakao.init('5cad223fb57213402d8f90de1aa27301');
function Share_detail(param){
	var share_url = "http://www.enuri.com/mobilefirst/event2020/family_2020.jsp";
	var share_title = "[에누리 가격비교] 가족 모두 혜택을 누리다! 매주 목요일 타임특가도 만나보세요!";
	var imgSNS = "http://img.enuri.info/images/event/2020/family/sns_1200_631.jpg";

	if(param == "face"){
		try{
			window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
			//ga("send", "event", "mf_event", vEvent_title +"_APP", "공유하기_페이스북");
		}catch(e){
			window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
			//ga("send", "event", "mf_event", vEvent_title +"_WEB", "공유하기_페이스북");
		}
	}else if(param == "kakao"){

		try{
			 Kakao.Link.createDefaultButton({
				container: '#kakao-link-btn',
				objectType: 'feed',
				content: {
					title: share_title,
					imageUrl: imgSNS,
					link: {
						mobileWebUrl: share_url,
					}
				},
				buttons: [
				{
					title: '상세정보 보기',
					link: {
						mobileWebUrl: share_url,
					}
				}
				]
			});
		}catch(e){
			alert("카카오 톡이 설치 되지 않았습니다.");
			alert(e.message);
		}
	}else if(param == "twitter"){

		window.open("https://twitter.com/intent/tweet?text="+share_title+"&url="+share_url);

	}
}

</script>
</body>
</html>