<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
String strFb_img = ConfigManager.IMG_ENURI_COM+ "/images/event/2020/chuseok/sns_1200_630_01.jpg";
String oc = ChkNull.chkStr(request.getParameter("oc"));

if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
	response.sendRedirect("/event2020/chuseok_2020_deal.jsp");
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
<meta name="title" content="2020 추석 통합기획전 - 최저가 쇼핑은 에누리">
<meta name="description" content="온 가족 타임특가! 매주 수요일마다 터지는 득템의 기회!">
<meta name="keyword" content="에누리 가격비교, 통합기획전, 추석, 한가위">
<!-- 페이스북 공유하기 메타태그 동적 추가  -->
<meta id="meta_og_title" property="og:title" content="[에누리 가격비교] 한가위에누리다!">
<meta id="meta_og_description" property="og:description" content="매주 수요일 타임특가도 만나보세요!">
<meta id="meta_og_image" property="og:image" content="<%=strFb_img%>">
<meta name="format-detection" content="telephone=no" />
<title>2020 추석 기획전 - 최저가 쇼핑은 에누리</title>
<!-- 프로모션 공통 CSS (Mobile) -->
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<!-- 프로모션별 커스텀 CSS  -->
<link rel="stylesheet" href="/css/event/y2020/chuseok_m.css?v=20200820" type="text/css">
<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
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
</script>
</head>
<body>
<!-- 200825 : SR#41896 : [MO] SNS 공유 딥링크 연결 팝업  -->
<div class="lay_only_mw" style="display:none;">
	<div class="lay_inner">
		<div class="lay_head">
			앱에서는 득템의 기회 <em>타임특가</em>에 참여할 수 있어요!
		</div>
		<!-- 버튼 : 에누리앱으로 보기 -->
		<button class="btn_go_app">에누리앱으로 보기</button>
		<!-- 버튼 : 모바일웹으로 보기 -->
		<a href="javascript:void(0);" class="btn_keep_mw" onclick="$('.lay_only_mw').fadeOut(100);">괜찮아요. 모바일 앱으로 볼래요</a>
	</div>
</div>
<!-- // -->

<div id="eventWrap">

	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp" %>

	<!-- 플로팅 배너 - 둥둥이 -->
    <div id="floating_bnr" class="floating_bnr">
        <a href="chuseok_2020.jsp?tab=05" onclick="ga_log(6);"><img src="http://img.enuri.info/images/event/2020/chuseok/fl_bnr.png" alt="한가위 준비하고 LG시네빔 받자!"></a>
        <!-- 닫기 -->
        <a href="#" class="btn_close" onclick="onoff('floating_bnr');return false;">
            <span class="blind">닫기</span>
        </a>
    </div>
    <!-- // -->

	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">
		<!-- 공통 : 상단비주얼 -->
		<div class="visual">
			<!-- 공통 : 공유하기 버튼  -->
			<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
			<!-- // -->
			<div class="inner">
				<span class="txt_01">추석 준비</span>
				<h2>한가위에-누리다</h2>
				<span class="txt_02">2020. 9.1 ~ 2020. 10. 4</span>
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
					},100)
				})
			</script>
		</div>

		<!-- 공통 : 탭 -->
		<div class="section navtab">
			<div class="navtab_inner">
				<ul class="navtab_list">
					<li><a href="/mobilefirst/event2020/chuseok_2020_evt.jsp" class="navtab_item--01" onclick="ga_log(2);"><span class="tx_sm">매일매일</span>100% 당첨</a></li>
					<li class="is-on"><a href="/mobilefirst/event2020/chuseok_2020_deal.jsp" class="navtab_item--02" onclick="ga_log(3);"><span class="tx_sm">~93%</span>타임특가!</a></li>
					<li><a href="/mobilefirst/event2020/chuseok_2020.jsp" class="navtab_item--03" onclick="ga_log(4);"><span class="tx_sm">한가위 준비하고</span>빔프로젝트 받자!</a></li>
				</ul>
			</div>
		</div>
		<!-- //탭 -->

	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<!-- T2 이벤트 02 : 추석 타임특가 -->
	<div id="event02" class="section event_02 scroll dealwrap">
		<div class="contents">
			<h2>
				<span class="tit_txt_01 blind">매주 수요일 오후 2시 OPEN</span>
				<span class="tit_date">
					<!-- 월일 노출 -->
					<span class="txt_month"></span>월 <span class="txt_day"></span>일
				</span>
				<strong class="tit_txt_02 blind">추석 타임특가</strong>
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
			<!--// 딜 리스트영역 -->
		</div>

		<!-- 공통 : 꼭 확인하세요  -->
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop2"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop2" class="evt_notice--slide">
			<div class="evt_notice--inner">
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<ul>
							<li>본인인증이 완료된 ID로만 참여가능합니다.</li>
							<li>시즌기획전 타임딜 상품의 주문/배송/환불/보증 책임은 해당 쇼핑몰의 판매자에게 있습니다.</li>
							<li>타임특가는 에누리 및 인터파크 ID 1개 당 1번만 구매 가능하며, 부정적인 방법으로 동일 상품을 1번 이상 구매한 경우 결제완료 한 경우라도 모든 구매 및 결제가 취소처리 됩니다. </li>
							<li>본 이벤트는 당사에 사정에 따라 사전고지 없이 변경 또는 조기종료 될 수 있습니다.</li>
							<li>시즌기획전 타임딜은 선착순 한정수량 판매로 결제 진행 중 상품이 품절될 경우 판매가 종료될 수 있습니다.</li>
							<li>에누리 모바일 APP에서만 구매가능하며, 이 외 다른 환경(인터파크 APP 등)에서 구매시도하여 발생되는 문제에 대해서는 책임 및 보상이 이루어지지 않습니다.</li>
						</ul>
					</div>
				</div>
				<div class="evt_notice--foot">
					<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 레이어 닫기 -->
				</div>
			</div>
		</div>
		<!-- // -->

	</div>
	<!-- // -->

	<!-- T2 이벤트 03 : 타입특가 공유이벤트 -->
	<div id="event03" class="section event_03 scroll">
		<div class="inner">
			<h2>
				<span class="tx_main"><em>딜 공유</em> 하고 선물받자!</span>
				<span class="tx_sm">타일딜을 SNS로 공유하면 추첨을 통해 20분에게 선물을 드립니다.</span>
			</h2>
			<!-- 경품이미지는 inline style로 넣어주세요 -->
			<div class="gift" style="background-image:url(http://img.enuri.info/images/event/2020/chuseok/m_sec03_gift.jpg)">
				<span class="blind">GS25 모바일 상품권 5,000원권 20명 추첨<BR/> 경품은 E머니로 지급됩니다.</span>
			</div>
			<ul class="share_list" onclick="ga_log(10);">
				<li class="btn_fb"><a href="javascript:Share_detail('face');">페이스북<span class="blind"> 공유하기</span></a></li>
				<li class="btn_ka" id="kakao-link-btn"><a href="javascript:Share_detail('kakao');">카카오톡<span class="blind"> 공유하기</span></a></li>
				<li class="btn_co"><a href="javascript:void(0);" data-clipboard-text="http://m.enuri.com/mobilefirst/event2020/chuseok_2020_deal.jsp?oc=sns">URL복사</a></li>
			</ul>
		</div>

		<!-- 공통 : 꼭 확인하세요  -->
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice btn__white" data-laypop-id="slidePop3"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop3" class="evt_notice--slide">
			<div class="evt_notice--inner">
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<ul>
							<li>당첨자 발표 : 2020년 10월 5일</li>
							<li>e머니 유효기간 : 적립일로부터 15일</li>
							<li>e머니 적립후 APP PUSH 메시지 발송 (PUSH 알림 미동의자 제외)</li>
							<li>SNS 공유는 횟수 제한없이 참여 가능합니다.</li>
						    <li>적립된 e머니는 e머니 스토어에서 다양한 e머니 쿠폰상품으로 교환 가능합니다.</li>
							<li>경품은 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격변동이 있을 수 있습니다.</li>
							<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
							<li>부정참여 시 적립 취소 및 사이트 사용이 제한 될 수 있습니다.</li>
						</ul>
					</div>
				</div>
				<div class="evt_notice--foot">
					<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 레이어 닫기 -->
				</div>
			</div>
		</div>
		<!-- // -->
	</div>
	<!-- // -->

	<!-- 공통 : 하단 에누리 혜택 -->
	<div class="otherbene">
        <div class="inner">
            <h3 class="blind">놓칠 수  없는 특별한 혜택, 에누리 혜택</h3>
            <ul class="ben_list">
                <li class="ben_item--01"><a href="http://m.enuri.com/mobilefirst/evt/firstbuy100_event.jsp" target="_blank">첫구매 고객이라면! Welcome 혜택</a></li>
                <li class="ben_item--02"><a href="http://m.enuri.com/mobilefirst/evt/visit_event.jsp" target="_blank">하루라도 농치면 손해 매일100% 당첨</a></li>
                <li class="ben_item--03"><a href="http://m.enuri.com/mobilefirst/evt/smart_benefits.jsp?freetoken=event#tab3" target="_blank">지금 가전을 구매하면? 최대 적립 10배</a></li>
                <li class="ben_item--04"><a href="http://m.enuri.com/mobilefirst/renew/plan.jsp?freetoken=main_tab|event" target="_blank">아직 끝나지 않은 혜택 더 많은 이벤트</a></li>
            </ul>
        </div>
	</div>
	<!-- // -->
	<script>
		$('.ben_list > li').click(function(){
			ga_log(36);
		});
	</script>

	<!-- //Contents -->

</div>

<!-- 공통 : SNS공유하기 -->
<div class="com__share_wrap dim" style="z-index:10000;display:none">
	<div class="com__layer share_layer">
		<div class="lay_head">공유하기</div>
		<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
		<div class="lay_inner">
			<ul>
				<li class="share_fb">페이스북 공유하기</li>
				<li class="share_kakao" id="kakao-share-btn">카카오톡 공유하기</li>
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
						<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2020/chuseok_2020_deal.jsp?oc=sns</span>
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
			var clipboard = new ClipboardJS('.com__share_wrap .btn__share_copy, .share_list .btn_co a');
			clipboard.on('success', function(e) {
				if(islogin()){
					alert('주소가 복사되었습니다');
					sharePaticipant('url');
				}else{
					alert("로그인 후 이용 가능합니다.");
					goLogin();
					return false;
				}
			});
			clipboard.on('error', function(e) {
				console.log(e);
			});
		});
	</script>
</div>
<!-- // -->

<!-- 모바일웹 공통 : 모바일 앱 전용 이벤트  -->
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btn();">설치하기</button></p>
	</div>
</div>

<!-- 이벤트1 : 당첨 레이어 -->
<div class="voteResult_layer" id="prizes" style="display:none">
	<div class="inner_layer">
		<div class="cont_area">
			<div class="img_box">
				<!-- 4,500점 적립 이미지 -->
				<div class="result_01" style="display:none">
					<img src="http://img.enuri.info/images/event/2020/chuseok/m_reward_img01.jpg" alt="당첨을 축하합니다! 설빙 인절미 토스트 e4,500">
				</div>
				<!-- 5점 적립 1 -->
				<div class="result_02" style="display:none">
					<img src="http://img.enuri.info/images/event/2020/chuseok/m_reward_img02.jpg" alt="5점 적립 내일 또 참여해주세요!">
				</div>
				<!-- 5점 적립 2 -->
				<div class="result_03" style="display:none">
					<img src="http://img.enuri.info/images/event/2020/chuseok/m_reward_img03.jpg" alt="5점 적립 내일 또 참여해주세요!">
				</div>
			</div>
			<a class="btn layclose" href="#" onclick="onoff('prizes'); return false;"><em>팝업 닫기</em></a>
		</div>
	</div>
</div>

<!-- 이벤트5 : 이벤트 응모완료 -->
<div class="complete_layer" id="completeJoin" style="display:none">
	<div class="inner_layer">
		<div class="cont_area">
			<p class="tit">응모가 완료되었습니다.</p>
			<div class="img_box">
				<a href="#"><img src="http://img.enuri.info/images/event/2020/summer_pro/m_complete_img.jpg" alt="이번 주 CRAZY DEAL, GS25 모바일 상품권 5천원권을 100원 (98%할인)" /></a>
			</div>
		</div>
		<a class="btn layclose" href="#" onclick="onoff('completeJoin'); return false;"><em>팝업 닫기</em></a>
	</div>
</div>

<!-- 공통 : 프론트배너 -->
<div class="dim" id="mainLayer" style="z-index:999;display: none">
	<!-- 백그라운드 터치 : 닫기 -->
	<span class="dim__back" onclick="$(this).closest('.dim').fadeOut(200);return false;"></span>
</div>
<!-- // 프론트배너 -->

<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
<script type="text/javascript" src="/js/clipboard.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20200629"></script>
<script type="text/javascript" src="/mobilefirst/event/js/exhibition_m.js"></script>
<script type="text/javascript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
<script type="text/javascript">
	var event_share_description = "";
	var event_share_img  = "";
	var cnt = 0;
	var $navHgt = 0;
	var app = getCookie("appYN"); //app인지 여부
	var makeHtml = "";
	var vEvent_title = "20년 추석통합기획전";
	var gaLabel = [  "20년 추석 통합기획전_PV"
					,"20년 추석 통합기획전_상단탭_이벤트1"
					,"20년 추석 통합기획전_상단탭_타임특가"
					,"20년 추석 통합기획전_상단탭_이벤트2"
					,"20년 추석 통합기획전_이벤트1 참여"
					,"20년 추석 통합기획전_상단플로팅배너"
					,"20년 추석 통합기획전_타임딜_상품보기"
					,"20년 추석 통합기획전_타임딜_APP구매하기"
					,"20년 추석 통합기획전_타임딜_썸네일"
					,"20년 추석 통합기획전_타임딜_공유이벤트 참여"
					,"20년 추석 통합기획전_BEST 추석선물_탭_정육/축산"
					,"20년 추석 통합기획전_BEST 추석선물_탭_건강식품"
					,"20년 추석 통합기획전_BEST 추석선물_탭_신선식품"
					,"20년 추석 통합기획전_BEST 추석선물_탭_상품권"
					,"20년 추석 통합기획전_BEST 추석선물_상품클릭"
					,"20년 추석 통합기획전_BEST 추석선물_상품더보기"
					,"20년 추석 통합기획전_가격대별 추석선물_탭_1~3만원"
					,"20년 추석 통합기획전_가격대별 추석선물_탭_3~5만원"
					,"20년 추석 통합기획전_가격대별 추석선물_탭_5~10만원"
					,"20년 추석 통합기획전_가격대별 추석선물_탭_10만원 이상"
					,"20년 추석 통합기획전_가격대별 추석선물_상품클릭"
					,"20년 추석 통합기획전_가격대별 추석선물_상품더보기"
					,"20년 추석 통합기획전_즐거운 귀성준비_탭_귀성길"
					,"20년 추석 통합기획전_즐거운 귀성준비_탭_돈봉투"
					,"20년 추석 통합기획전_즐거운 귀성준비_탭_보드게임"
					,"20년 추석 통합기획전_즐거운 귀성준비_탭_유아한복"
					,"20년 추석 통합기획전_즐거운 귀성준비_상품클릭"
					,"20년 추석 통합기획전_즐거운 귀성준비_상품더보기"
					,"20년 추석 통합기획전_1인가구 추석준비_탭_컴퓨터/게임기"
					,"20년 추석 통합기획전_1인가구 추석준비_탭_간편가정식"
					,"20년 추석 통합기획전_1인가구 추석준비_탭_e쿠폰"
					,"20년 추석 통합기획전_1인가구 추석준비_탭_댕냥이 한복"
					,"20년 추석 통합기획전_1인가구 추석준비_상품클릭"
					,"20년 추석 통합기획전_1인가구 추석준비_상품더보기"
					,"20년 추석 통합기획전_이벤트2 참여"
					,"20년 추석 통합기획전_혜택배너" ];

    // 공통 : 상단 탭 고정
    (function (global, $) {
        var $nav = $('.navtab'); // 탭
		var $myarea = $('.myarea');
        $(window).scroll(function () {
            var scroll = $(window).scrollTop();
            if (scroll > $nav.offset().top) {
                $nav.addClass("is-fixed")
				$myarea.addClass("f-nav");
            }else{
                $nav.removeClass("is-fixed")
				$myarea.removeClass("f-nav");
            }
        });
    }(window, window.jQuery));

	// 공통 : 유의사항 레이어 열기/닫기
	$(function(){
		var el = {
			btnSlide: $(".btn__evt_notice"), // 열기 버튼
			btnSlideClose : $(".btn__evt_confirm") // 닫기 버튼
		}
		el.btnSlide.click(function(){ // 슬라이드 유의사항 열기
			$(this).toggleClass('on');
			$("#"+$(this).attr("data-laypop-id")).slideToggle();
		})
		el.btnSlideClose.click(function(){ // 슬라이드 유의사항 닫기
			var thisClosest = $(this).closest('.evt_notice--slide')
			$(thisClosest).slideToggle();
			$('html,body').stop(0).animate({scrollTop:$(thisClosest).siblings(".com__evt_notice").offset().top - 50});
		})
	})

	// 공통 :  하단 컨텐츠로 바로 진입시 포지션 보정을 위한 스크립트 처리
	$(function(){
		if(window.location.hash) {
			var $hash = $("#"+window.location.hash.substring(1));
			var navH = $(".navtab").outerHeight();
			if ( $hash.length ){
				$("html,body").stop(true,false).animate({"scrollTop": $hash.offset().top - navH},"slow");
			}
  		}
	})

	/* 퍼블테스트 : 레이어 열고 닫기*/
	function onoff(id){
		var mid = $("#"+id);
		if(mid.css("display") !== "none"){
			mid.css("display","none");
		}else{
			mid.css("display","");
		}
	}

	function view_moapp(){
		var chrome25;
		var kitkatWebview;
		var uagentLow = navigator.userAgent.toLocaleLowerCase();
		var openAt = new Date;
		var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2020%2Fchuseok_2020_deal.jsp";
		if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
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
					location.href = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2020/chuseok_2020_deal.jsp";
				} else{
					location.href = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2020/chuseok_2020_deal.jsp";
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

	$(document).ready(function(){
 		//ga > pageview
		var oc = '<%=oc%>';

		// 공유하기 링크로 진입 시, 팝업 노출(모웹)
		if(oc == "sns" && app != 'Y'){
			var url = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2020%2Fchuseok_2020_deal.jsp";
			$('.lay_only_mw').show();
			// 앱으로 보기
	    	$(".btn_go_app").click(function(){
	    		view_moapp();

	    	});
		}

		$(".ben_item--04").click(function(){
			var url = (app != "Y" ? "/mobilefirst/index.jsp#evt" : "/mobilefirst/renew/plan.jsp?freetoken=main_tab|event")
			window.open(url);
		});

		//#애드브릭스 타임특가 PV
		setTimeout(function(){
			welcomeGa("evt_chuseok2020_deal_view");
		},500);

		//딜 상품
		$.ajax({
			  url: "/mobilefirst/http/json/exh_deal_list_2020081903.json" //
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
	                dealItem += "				<li><a href=\"/mobilefirst/detail.jsp?modelno="+v.GD_MODEL_NO+"&freetoken=vip\" class=\"btn_dview\" target=\"_blank\" onclick=\"ga_log(7)\">상품보기</a></li>";
	                if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT > vCur_dtm) { //판매 전
		                dealItem += "			<li id='deal_btn'><a class=\"btn_buy_ready\">판매예정</a></li>";
			        }else if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT <= vCur_dtm && v.GD_SAL_E_DTM_CVT >= vCur_dtm){ //판매 중
		                dealItem += "			<li id='deal_btn'><a class=\"btn_buy\" onclick=\" fnDeal("+v.EXH_DEAL_NO+",'2020081903'); ga_log(8); return false;\">구매하기</a></li>";
			        }else{ // 판매 종료
		                dealItem += "			<li id='deal_btn'><a class=\"btn_buy_soldout\">Sold out</a></li>";
		        	}
	                dealItem += "			</ul>";
	                dealItem += "		</div>";
	                dealItem += "	<p class=\"ad\">※ 쿠폰적용 필수 / ID당 1회 구매가능 / 무료배송 <span class=\"mark\"><img src=\"http://img.enuri.info/images/event/2020/newyear/ico_interpark.png\" alt=\"인터파크\"></span></p>";
	        	    dealItem += "	</div>";
	        	    dealItem += "</div>";

	        		dealList += "<div class=\"w_item\" onclick=\"ga_log(9);\">";
	                dealList += "	<div class=\"w_thumb\">";
	                dealList += "		<img src=\"http://storage.enuri.info/Web_Storage"+v.GD_IMG_URL+"\" />";
	                dealList += "	</div>";
					dealList += "	<div class=\"period\">";
	                dealList += "		<span id='date'>"+month+"/"+day+"</span><span id=week>("+getWeek(v.GD_SAL_S_DTM_CVT)+") 14:00</span>";
	                dealList += "	</div>";
	                dealList += "	<span class=\"w_tit\">"+v.GD_MODEL_NM1+"<br>"+v.GD_MODEL_NM2+"</span>";
					dealList += "</div>";

					// 공유하기 title/description
					if(v.GD_SAL_S_DTM_CVT >= vCur_dtm){
						if(event_share_img == ""){
							event_share_img = v.GD_IMG_URL;
							event_share_description = month+"월 "+day+"일 수요일 오후 2시! "+v.GD_MODEL_NM1+v.GD_MODEL_NM2+" "+commaNum(v.GD_DC_PRC)+"원!";
						}
					}

				});
				$('#event02 .deal_slide').html(dealItem);
				$('#event02 .deal_list .deal_nav').html(dealList);

			}
			, complete: function(){
				var $deal_slide = $('#event02 .deal_slide');
				var $w_item = $('.deal_nav .w_item');

				$('.deal_slide').slick({
					slidesToShow: 1,
					slidesToScroll: 1,
					arrows: true,
					dots: true,
					fade: false,
					//speed: 0,
					asNavFor: '.deal_nav'
				})
				$('.deal_nav').slick({
					slidesToShow: 3,
					slidesToScroll: 1,
					asNavFor: '.deal_slide',
					dots: false,
					centerMode: true,
					focusOnSelect: true,
					variableWidth: true
				});

				dealDate();

				$deal_slide.on('beforeChange', function(e, s, c, n){
			    	$w_item.removeClass("slick-current");
			    	$w_item.eq(n).addClass("slick-current");
			    	dealDate();
			    });

	            //딜 날짜별 상품 노출
				for(var i = 0; i < cnt; i++){
					if($("#ul_btn"+i+" li a").hasClass("btn_buy_soldout")){
						$('#event02 .deal_slide').slick('slickGoTo', i+1, true);
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
//	 				$('.dealwrap h2').css({ 'text-align': 'center'
//	 									  , 'height': '220px','background': 'url(http://img.enuri.info/images/event/2020/new_semester/m_deal_tit2.png) 50% 0%'
//	 									  , 'background-repeat':'no-repeat'
//	 									  , 'background-size': '320px'});

//	 				$('.dealwrap h2 .tit_date').css({ 'padding-top': '75px'});
				}
			}
		});

		$(".share_kakao").on('click', function(){
			shareSns('kakao');
		});
		$(".share_fb").on('click', function(){
			shareSns('face');
		});
		$(".share_tw").on('click', function(){
			shareSns('twitter');
		});

		/* // 공유하기 클릭시
		$(".com__btn_share").click(function(){
			var url = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2event2020%2Fchuseok_2020_deal.jsp";
			if(app != 'Y'){
				$('.lay_only_mw').show();
				// 앱으로 보기
		    	$(".btn_go_app").click(function(){
		    		if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
						location.href = url;
					}else{ // 아이폰
						setTimeout(function(){
							window.open("https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8");
						}, 1000);
						location.href = url;
					}
		    	});
		    	// 모웹
				$(".btn_keep_mw").click(function(){
					$(".com__share_wrap").show();
		    	});
			}else{
				$('.com__share_wrap').show();
			}
		}); */

	});

	function dealDate(){
		var $txt_month = $('#event02 .contents .tit_date .txt_month');
		var $txt_day = $('#event02 .contents .tit_date .txt_day');
		var dealDate = new Array();

		dealDate = $('.w_item.slick-current .period #date').text().split('/');
		$txt_month.text(dealDate[0]);
		$txt_day.text(dealDate[1]);
	}

	<%-- function Share_detail(param){
		var loadUrl = "/mobilefirst/evt/ajax/ajax_share_evt.jsp";
		var share_url = "http://www.enuri.com/mobilefirst/event2020/chuseok_2020_deal.jsp";
		var share_title = "";
		var share_description = "";
		var imgSNS = "";
		if(!islogin()){
			alert("로그인 후 이용 가능합니다.");
			goLogin();
			return false;
		}else{
			// 공유하기 문구 및 이미지 불러오기
			$.ajax({
				  url : loadUrl
				, async : true
				, data : {procCode : 1}
				, dataType : "json"
				, success : function(data){
					share_title = data.SHARE_TL;
					share_description = data.SHARE_DS;
					imgSNS = "http://storage.enuri.info/"+data.GD_IMG_URL;

					// 메타태그 수정
					$("#meta_og_url").attr("content",share_url);
					$("#meta_og_title").attr("content",share_title);
					$("#meta_og_description").attr("content",share_description);
					$("#meta_og_image").attr("content",imgSNS);

					// sns 공유하기 함수 호출
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
									description : share_description,
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
					}

					// 공유하기 이벤트 참여자 insert
					sharePaticipant(param);

					// 메타태그 원래대로 수정
					$("#meta_og_title").attr("content","[에누리 가격비교] 한가위에누리다!");
					$("#meta_og_description").attr("content","매주 수요일 타임특가도 만나보세요!");
					$("#meta_og_image").attr("content","<%=strFb_img%>");

				}, complete : function(){

				}
			});
		}
	} --%>

	function Share_detail(param){
		var share_url = "http://m.enuri.com/mobilefirst/event2020/chuseok_2020_deal.jsp?oc=sns";
		var share_title = "[2020년 추석 타임딜 이벤트]";
		var share_description = event_share_description;
		var imgSNS = "http://storage.enuri.info"+event_share_img;

		if(!islogin()){
			alert("로그인 후 이용 가능합니다.");
			goLogin();
			return false;
		}else{
			// 메타태그 수정
			$("#meta_og_url").attr("content",share_url);
			$("#meta_og_title").attr("content",share_title);
			$("#meta_og_description").attr("content",share_description);
			$("#meta_og_image").attr("content",imgSNS);

			// sns 공유하기 함수 호출
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
							description : share_description,
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
			}

			// 공유하기 이벤트 참여자 insert
			sharePaticipant(param);

			// 메타태그 원래대로 수정
			$("#meta_og_url").attr("content","http://m.enuri.com/mobilefirst/event2020/chuseok_2020_deal.jsp");
			$("#meta_og_title").attr("content","[에누리 가격비교] 한가위에누리다!");
			$("#meta_og_description").attr("content","매주 수요일 타임특가도 만나보세요!");
			$("#meta_og_image").attr("content","<%=strFb_img%>");

		}
	}


	// sns 공유하기 함수
	function shareSns(param){
		var share_url = "http://m.enuri.com/mobilefirst/event2020/chuseok_2020_deal.jsp?oc=sns";
		var share_title = "[에누리 가격비교] 한가위에누리다!";
		var share_description = "매주 수요일 타임특가도 만나보세요!";
		var imgSNS = "<%=strFb_img%>";

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
					container: '#kakao-share-btn',
					objectType: 'feed',
					content: {
						title: share_title,
						imageUrl: imgSNS,
						description : share_description,
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
			share_title += " 매주 수요일 타임특가도 만나보세요!";
			window.open("https://twitter.com/intent/tweet?text="+share_title+"&url="+share_url);
		}
	}

	// 공유하기 이벤트 참여자
	function sharePaticipant(Type){
		var shareType = 0;
		var osType = "";

		if(Type == "face"){
			shareType = 1;
		}else if(Type == "kakao"){
			shareType = 2;
		}else if(Type == "url"){
			shareType = 3;
		}

		if(app =='Y'){
	        osType = "MA";
	    }else {
	    	osType = "MW";
	    }

		$.ajax({
			  url : "/mobilefirst/evt/ajax/ajax_share_evt.jsp"
			, data : {	procCode  : 2,
						shareType : shareType,
						osType    : osType	 }
			, dataType : "json"
			, success : function(result){
				if(!result){
					alert('공유하기 이벤트 참여 실패하였습니다.');
				}
			}

		});

	}

</script>
</body>
</html>
