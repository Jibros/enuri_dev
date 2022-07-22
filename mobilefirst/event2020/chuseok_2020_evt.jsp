<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
	String strFb_title = "[에누리 가격비교] 한가위에누리다!";
	String strFb_description = "매주 수요일 타임특가도 만나보세요!";
	String strFb_img = ConfigManager.IMG_ENURI_COM
			+ "/images/event/2020/chuseok/sns_1200_630_01.jpg";

	if (ChkNull.chkStr(request.getHeader("User-Agent")).indexOf(
			"iPhone") > -1
			|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf(
					"Android") > -1
			|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf(
					"iPod") > -1
			|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf(
					"iPad") > -1) {
	} else { //pc일때 접속페이지 변경.
		response.sendRedirect("/event2020/chuseok_2020_evt.jsp");
		return;
	}

	String chkId = ChkNull.chkStr(request.getParameter("chk_id"), "");
	String cUserId = ChkNull.chkStr(
			cb.GetCookie("MEM_INFO", "USER_ID"), "");
	String cUserNick = ChkNull.chkStr(
			cb.GetCookie("MEM_INFO", "USER_NICK"), "");

	Members_Proc members_proc = new Members_Proc();
	String cUsername = members_proc.getUserName(cUserId);
	String userArea = cUsername;

	String strUrl = request.getRequestURI();

	if (!cUserId.equals("")) {
		cUsername = members_proc.getUserName(cUserId);
		userArea = cUsername;

		if (cUsername.equals(""))
			userArea = cUserNick;
		if (userArea.equals(""))
			userArea = cUserId;
	}
	String tab = ChkNull.chkStr(request.getParameter("tab"), "");
	String flow = ChkNull.chkStr(request.getParameter("flow"));
	String oc = ChkNull.chkStr(request.getParameter("oc"));

	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd"); //오늘 날짜
	String strToday = formatter.format(new Date());
	String sdt = ChkNull.chkStr(request.getParameter("sdt"));

	if (!"".equals(sdt)
			|| request.getServerName().equals("dev.enuri.com")) {
		strToday = sdt;
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<META NAME="description" CONTENT="APP에서 한가위 준비하면,  LG 빔프로젝트 당첨!">
<META NAME="keyword"
	CONTENT="에누리가격비교, 프로모션, 한가위에누리다, 추석, 추석 이벤트, 매일참여">
<meta property="og:title" content="추석 맞이 이벤트! - 최저가 쇼핑은 에누리">
<meta property="og:description" content="APP에서 한가위 준비하면,  LG 빔프로젝트 당첨!">
<meta property="og:image" content="<%=strFb_img%>">
<meta name="format-detection" content="telephone=no" />
<!-- 프로모션 공통 CSS (Mobile) -->
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css"
	type="text/css">
<!-- 프로모션별 커스텀 CSS  -->
<link rel="stylesheet" href="/css/event/y2020/chuseok_m.css"
	type="text/css">
<link rel="stylesheet" type="text/css"
	href="/mobilefirst/css/lib/slick.css" />
<script type="text/javascript"
	src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
<script type="text/javascript" src="/common/js/function.js"></script>
</head>
<body>
<div class="lay_only_mw" style="display: none;">
	<div class="lay_inner">
		<div class="lay_head">
			앱에서는 득템의 기회 <em>타임특가</em>에 참여할 수 있어요!
		</div>
		<!-- 버튼 : 에누리앱으로 보기 -->
		<button class="btn_go_app" onclick="view_moapp();">에누리앱으로 보기</button>
		<!-- 버튼 : 모바일웹으로 보기 -->
		<a href="javascript:void(0);" class="btn_keep_mw" onclick="$('.lay_only_mw').fadeOut(100);">괜찮아요. 모바일 웹으로 볼래요</a>
	</div>
</div>
	<div id="eventWrap">
		<div class="myarea">
			<p class="name">
				나의 <em class="emy">머니</em>는 얼마일까?
				<button type="button" class="btn_login" onclick="goLogin();">로그인</button>
			</p>
			<a href="javascript:///" class="win_close">창닫기</a>
		</div>
		<!-- 플로팅 배너 - 둥둥이 -->
		<div id="floating_bnr" class="floating_bnr" onclick="floating_bnr();return false;">
	        <a><img src="http://img.enuri.info/images/event/2020/chuseok/fl_bnr.png" alt="한가위 준비하고 LG시네빔 받자!"></a>
	        <!-- 닫기 -->
	        <a href="#" class="btn_close" onclick="onoff('floating_bnr');return false;">
	            <span class="blind">닫기</span>
	        </a>
	    </div>
		<!-- 비쥬얼,플로팅탭 -->
		<div class="toparea">
			<!-- 상단비주얼 -->
			<div class="visual">
				<!-- 공통 : 공유하기 버튼  -->
				<button class="com__btn_share"
					onclick="$('.com__share_wrap').show();">공유하기</button>
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
			<div class="section navtab">
				<div class="navtab_inner">
					<ul class="navtab_list">
						<li class="is-on"><a onclick="da_ga(2);" href="#" class="navtab_item--01"><span class="tx_sm">매일매일</span>100% 당첨</a></li>
						<li><a onclick="da_ga(3);" href="/mobilefirst/event2020/chuseok_2020_deal.jsp" class="navtab_item--02"><span class="tx_sm">~92%</span>타임특가!</a></li>
						<li><a onclick="da_ga(4);" href="/mobilefirst/event2020/chuseok_2020.jsp" class="navtab_item--03"><span class="tx_sm">BEST</span>추석선물</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- //비쥬얼,플로팅탭 -->

		<!-- 이벤트01 -->
		<div id="evt1" class="section event_01 scroll">
			<div class="inner">
				<h2>
					<span class="tx_sm">떡 먹은 토끼를 찾아라!</span>
					<span class="tx_main">매일매일 <em>인절미 토스트</em> 당첨!</span>
				</h2>
				<div class="gift"><span class="blind">[설빙] 인절미 토스트 e4,500점</span></div>
				<!-- 떡 먹은 토끼 찾기 -->
	            <div class="rabbitgame">
					<div class="rabbitgame_inner">
						<ul class="rabbits">
							<li class="rabbit_01"><!-- 토끼1 --></li>
							<li class="rabbit_02"><!-- 토끼2 --></li>
							<li class="rabbit_03"><!-- 토끼3 --></li>						
						</ul>
						<button class="btn_start">시작</button>
					</div>
				</div>
			</div>
			<div class="com__evt_notice">
				<div class="evt_notice--btn_area"><button class="btn__evt_notice btn__white" data-laypop-id="slidePop1"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
			</div>
			<div id="slidePop1" class="evt_notice--slide">
				<div class="evt_notice--inner"> <!-- .wide - 넓은 케이스 -->
					<div class="evt_notice--head">유의사항</div>
					<div class="evt_notice--cont">
						<div class="evt_notice--continner">
							<ul>
								<li>이벤트 참여 : ID당 1일 1회 참여 가능</li>
								<li>이벤트 참여 혜택 : e4,500점, e5점</li>
								<li>e머니 유효기간 : 적립일로부터 15일</li>
								<li>적립된 e머니는 e머니 스토어에서 다양한 e쿠폰상품으로 교환 가능합니다. </li>
								<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
								<li>부정 참여 시 적립 취소 및 사이트 사용이 제한될 수 있습니다.</li>
							</ul>
						</div>
					</div>
					<div class="evt_notice--foot">						
						<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 레이어 닫기 -->
					</div>
				</div>
			</div>
		</div>
		<!-- //이벤트01 -->
		<div class="otherbene">
	        <div class="inner">
	            <h3 class="blind">놓칠 수  없는 특별한 혜택, 에누리 혜택</h3>
	            <ul id="bene" class="ben_list">
	                <li class="ben_item--01"><a href="http://m.enuri.com/mobilefirst/evt/firstbuy100_event.jsp" target="_blank">첫구매 고객이라면! Welcome 혜택</a></li>
	                <li class="ben_item--02"><a href="http://m.enuri.com/mobilefirst/evt/visit_event.jsp" target="_blank">하루라도 농치면 손해 매일100% 당첨</a></li>
	                <li class="ben_item--03"><a href="http://m.enuri.com/mobilefirst/evt/smart_benefits.jsp?freetoken=event#tab3" target="_blank">지금 가전을 구매하면? 최대 적립 10배</a></li>
	                <li class="ben_item--04"><a href="" target="_blank">아직 끝나지 않은 혜택 더 많은 이벤트</a></li>
	            </ul>
	        </div>
		</div>
	</div> 
	
	<!-- (신규) 공통 : SNS공유하기 -->
	<div class="com__share_wrap dim" style="z-index: 10000; display: none">
		<div class="com__layer share_layer">
			<div class="lay_head">공유하기</div>
			<a href="#close" class="lay_close"
				onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
			<div class="lay_inner">
				<ul id="eventShr">
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
							<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2020/chuseok_2020_evt.jsp</span>
							<button class="btn__share_copy" data-clipboard-target="#txtURL">복사</button>
						</div>
						<!-- 이메일주소 입력하기 -->
						<div class="btn_item">
							<input type="text" class="txt__share_mail"
								placeholder="이메일 주소 입력해 주세요">
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

	<!-- layer-->
	<div class="layer_back" id="app_only" style="display: none;">
		<div class="appLayer">
			<h4>모바일 앱 전용 이벤트</h4>
			<a href="javascript:///" class="close"
				onclick="$('#app_only').hide();">창닫기</a>
			<p class="txt">
				<strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.
			</p>
			<p class="btn_close">
				<button type="button" onclick="install_btt();">설치하기</button>
			</p>
		</div>
	</div>

	<!-- 당첨 레이어 -->
	<div class="voteResult_layer" id="prizes" style="display: none;">
		<div class="inner_layer">
			<div class="cont_area">
				<div class="img_box">
					<!-- 4,500점 적립 이미지 -->
					<div class="result_01" style="display: none">
						<img src="http://img.enuri.info/images/event/2020/chuseok/m_reward_img01.jpg" alt="당첨을 축하합니다! 설빙 인절미 토스트 e4,500">
					</div>
					<!-- 5점 적립 이미지 -->
					<div class="result_02" style="display: none">
						<img src="http://img.enuri.info/images/event/2020/chuseok/m_reward_img02.jpg" alt="5점 적립 내일 또 참여해주세요!">
					</div>
					<div class="result_03" style="display:none">
						<img src="http://img.enuri.info/images/event/2020/chuseok/m_reward_img03.jpg" alt="5점 적립 내일 또 참여해주세요!">
					</div>
				</div>
				<a class="btn layclose" href="#"
					onclick="onoff('prizes'); return false;"><em>팝업 닫기</em></a>
			</div>
		</div>
	</div>

	<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
	<script type="text/javascript"
		src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
	<script type="text/javascript"
		src="/mobilefirst/evt/js/event_season.js?v=20200629"></script>
<script type="text/javascript">
var app = getCookie("appYN"); //app인지 여부
var oc = '<%=oc%>';
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로
var vEvent_title = "20년 추석 통합기획전";
var isFlow = "<%=flow%>" == "ad";
var vOs_type = getOsType();
var state = false;
var tab = "<%=tab%>";

$(".go_top").click(function(){		$('body, html').animate({scrollTop:0}, 500);	});

var shareUrl = "http://" + location.host + "/mobilefirst/event2020/chuseok_2020_evt.jsp?oc=";
var shareTitle = "<%=strFb_title%> <%=strFb_description%>";

Kakao.init('5cad223fb57213402d8f90de1aa27301');

function da_ga(num){
	
	if(num == 2){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_상단탭_이벤트1");
	}else if(num == 3){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_상단탭_타임특가");
	}else if(num == 4){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_상단탭_이벤트2");
	}else if(num == 5){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_이벤트1 참여");
	}else if(num == 6){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_상단플로팅배너");
	}
	/* else if(num == 7){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_상품탭_여름가전");
	}else if(num == 8){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_상품탭_제철음식");
	}else if(num == 9){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_상품탭_홈캉스");
	}else if(num == 10){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_상품탭_모바일쿠폰");
	}else if(num == 11){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_상품탭_바캉스준비");
	}else if(num == 12){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_상품_상품클릭");
	}else if(num == 13){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_상품_상품더보기");	
	}else if(num == 14){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_기획전보러가기");
	}else if(num == 15){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_응모하기");
	}else if(num == 16){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_에누리혜택");
	} */
	
}

//sns 인증
function getSnsCheck() {
	var snsCertify;
	$.ajax({
		type: "GET",
		url: "/member/ajax/getMemberCetify.jsp",
		dataType: "JSON",
		async : false,
		success: function(json){
			var snsdcd = json["snsdcd"]; //sns회원유무 K:카카오, N:네이버
			snsCertify = json["certify"];
			if(snsdcd==""){
				snsCertify = true;
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
	});
	return snsCertify;
}

//닫기버튼
$('.win_close').click(function(){
	if(getCookie("appYN") == 'Y'){
		window.location.href = "close://";
	}else{
		window.location.replace("/m/index.jsp");
	}
});


(function (global, $) {
	$(function () {
		$("#bene > li").click(function(){
			ga('send', 'event', 'mf_event', vEvent_title, "20년 추석 통합기획전_에누리혜택");
		});
		$("#eventShr > li").click(function(){
			var sel = $(this).attr("class");
			if(sel == "share_fb"){
				try{
					window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(shareTitle)+"&u="+shareUrl+"fb");
				}catch(e){
					window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(shareTitle)+"&u="+shareUrl+"fb");
				}	
			}else if(sel == "share_tw"){
				try {
					window.android
							.android_window_open("http://twitter.com/intent/tweet?text="
									+ encodeURIComponent(shareTitle)
									+ "&url=" + shareUrl+"tw");
				} catch (e) {
					window.open("http://twitter.com/intent/tweet?text="
							+ encodeURIComponent(shareTitle) + "&url="
							+ shareUrl+"tw");
				}
			}
		});
		
		
	});

	// 상단 메뉴 스크롤 시, 고정
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
    
	if(window.location.hash) {
		var $hash = $("#"+window.location.hash.substring(1));
		var navH = $(".navtab").outerHeight();
		if ( $hash.length ){
			$("html,body").stop(true,false).animate({"scrollTop": $hash.offset().top - navH},"slow");
		}
  	}
	
	//스크롤
	var nav = $('.myarea'); 
	$(window).scroll(function () {
		if ($(this).scrollTop() > $(".toparea").height()) {
			nav.addClass("f-nav");
		} else {
			nav.removeClass("f-nav");
		}
	});
}(window, window.jQuery));

/*레이어*/
function onoff(id){
	var mid = $("#"+id);
	if(mid.css("display") !== "none"){
		mid.css("display","none");
	}else{
		mid.css("display","");
	}
}

function floating_bnr(){
	da_ga(6);
	location.href = "/mobilefirst/event2020/chuseok_2020.jsp?tab=#event05";
	return false;	
}
function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2020%2Fchuseok_2020_evt.jsp";
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
				location.href = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2020/chuseok_2020_evt.jsp";
			} else{
				location.href = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2020/chuseok_2020_evt.jsp";
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
	// 개인정보 불러오기
	$("body").append("<iframe id='iframeField'></iframe>");
	$("#iframeField").hide();
	
	if(islogin()){
		$(".login_alert").addClass("disNone");
		$("#user_id").text("<%=cUserId%>");
	}
	
	ga('send', 'pageview', {'page': vEvent_page,'title': vEvent_title+'_PV'});
	$(".ben_item--04").click(function(){
		var url = (app != "Y" ? "/mobilefirst/index.jsp#evt" : "/mobilefirst/renew/plan.jsp?freetoken=main_tab|event")
		window.open(url);
	});
	if(oc!=""){
		$('.lay_only_mw').show();
	}
	

	//로그인시 개인화영역
	if(islogin()){
		$("#user_id").text("<%=cUserId%>");
		getPoint();//개인e머니 내역 노출
	}

});

var proSlide ;

setTimeout(function(){
	proSlide = $('.itemlist').slick({
		dots:true,
		slidesToScroll: 1
	});
},100);

function arrayShuffle(oldArray) {
    var newArray = oldArray.slice();
    var len = newArray.length;
    var i = len;
    while (i--) {
        var p = parseInt(Math.random()*len);
        var t = newArray[i];
        newArray[i] = newArray[p];
        newArray[p] = t;
    }
    return newArray;
};

function arrayShuffle2(oldArray) {
    var newArray = oldArray;
    var len = newArray.length;
    var i = len;
    while (i--) {
        var p = parseInt(Math.random()*len);
        var t = newArray[i];
        newArray[i] = newArray[p];
        newArray[p] = t;
    }
    return newArray;
};

var nowTab = 1;

var isClick = true;
var sdt = "<%=strToday%>";
function getEventAjaxData(params, callback){
	
	 if(sdt < "20200901"){
		alert('오픈예정입니다.');
		return false;
	}
	if(sdt > "20201004"){
		alert('이벤트가 종료되었습니다.');
		return false;
	}

	if(!islogin()){
		alert("로그인 후 이용 가능합니다.");
		goLogin();
		return false;
	}else{
		if(!getSnsCheck()){
			if (confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?") == true){    
				location.href="https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
			}else{
				return false;
			}
		}else{
			var evtUrl = "/mobilefirst/evt/ajax/chuseok2020_setlist.jsp";
			if(typeof params === "object") {
				params.sdt = sdt;
				params.osType = "M";
			}
		    if(!isClick){
		    	return false;
		    }
		    isClick = false;

			 $.post(evtUrl,params,callback,"json").done(function(){
					isClick = true;
			});
		}
	}
}

$(document).ready(function(){
	
	$(function(){
		var rabbitGame = {
				el : {
					wrap : $(".rabbitgame"),
					main : $(".rabbitgame_inner"),
					btn : $(".rabbitgame .btn_start"),
					rabbitw : $(".rabbitgame .rabbits"),
					rabbit : $(".rabbitgame .rabbits > li")
			     },
				init : function(){
					var _self = this;
					this.el.btn.click(function(){
						_self.el.btn.addClass("play");
						setTimeout(function(){
							_self.intro();
						},1000);
					});
				},
				intro : function(){
					var _self = this;
					_self.el.rabbitw.addClass("step1");
					setTimeout(function(){
						_self.el.rabbitw.addClass("step2");
						setTimeout(function(){
							_self.el.rabbitw.removeClass("step1").addClass("step3");;
							_self.addEvent();
						},600);
					},600);
				},
				addEvent : function(){
				//토끼 선택
					var _self = this;
						this.el.rabbit.unbind("click");
						this.el.rabbit.click(function(){							
						if ( !$(this).hasClass("disabled") ){ // 중복클릭방지								
							$(this).addClass("selected").siblings().addClass("disabled");
							setTimeout(function(){ // 모션을 위한 타이머
								getEventAjaxData( {"procCode":1} , function(data) {
									result = data.result;
									if(result >= 5){
											// 당첨결과 보기 
											rewards(result);
									}else if(result == -1){
										alert("이미 참여하셨습니다.\n내일 또 참여해주세요.");
										working = false;
									}else if(result == -2 || result == -99){
										alert("임직원은 참여 불가합니다.");
										working = false;
									}else if(result == -55){
										alert("잘못된 접근입니다.");
									}else{
										working = false;
									}
								});
							},1000) 
						}
					})
				},
				clear : function(){ // 오브젝트 치우기
					this.el.main.fadeOut(100); 
				},
				reset : function(){ // 오브젝트 초기화 - 재배치
					this.el.btn.removeClass("play");
					this.el.rabbitw.removeClass("step1 step2 step3");
					this.el.rabbit.removeClass("disabled selected");
					this.el.main.fadeIn(300);
					this.el.layer.fadeOut(100);
				}
			}
		// 실행
		rabbitGame.init();

		// 당첨 결과 처리
		function rewards(result){
				// 0 - 낙첨 - 5점 적립
				// 1 - 당첨 - 5,600점 적립
				da_ga(5);
				/* setTimeout(function(){ */
					// 스크린 비우기
					rabbitGame.clear();
					$("#prizes .vote_img > div").hide();
					// 레이어 띄우기
					// 결과 레이어 노출
					if ( result==5 ){ // 낙첨
						// 팝업 띄우기
						var resultImg = new Array(2, 3);
						onoff('prizes');
						$("#prizes").find(".result_0"+resultImg[Math.floor(Math.random()*resultImg.length)]).show(); // 5점
						// 게임 초기화
						rabbitGame.reset();
					}else if(result>5){ // 당첨
						// 팝업 띄우기
						onoff('prizes');
						$("#prizes").find(".result_01").show(); // 4,500점
						// 게임 초기화
						rabbitGame.reset();								
						//팝업 띄우기
					}
				/* },500); */
			}      			
	});
	//기획전상품

});
$(window).load(function(){
	if(tab!='') {
		setTimeout(inner, 300);
	}
	function inner() {
		$('html, body').animate({scrollTop: Math.ceil($('#'+tab).offset().top)}, 500);
	}
});

function numberWithCommas(x) {   return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");		}

function welcomeGa(strEvent){
	if(app == "Y"){
		try{
			if(window.android){ // 안드로이드 
				window.android.igaworksEventForApp (strEvent);
			}else if(/iPhone|iPad|iPod/i.test(navigator.userAgent)){
				// 아이폰에서 호출
				location.href = "enuriappcall://igaworksEventForApp?strEvent="+strEvent;
			}
		}catch(e){}
	}
}
setTimeout(function(){
welcomeGa("evt_chuseok2020_view"); 
},500);
function goPlan(){
	da_ga(4);
	location.href = "/mobilefirst/event2020/chuseok_2020.jsp";
}

CmdShare();
function CmdShare(){
	Kakao.Link.createDefaultButton({
	  container: '#kakao-link-btn',
      objectType: 'feed',
      content: {
        title: '<%=strFb_title%>',
        description: "<%=strFb_description%>",
        imageUrl: "<%=strFb_img%>",
			link : {
				webUrl : shareUrl,
				mobileWebUrl : shareUrl+"ka"
			}
		},
		buttons : [ {
			title : '에누리 가격비교',
			link : {
			mobileWebUrl : shareUrl+"ka",
			webUrl : shareUrl
			}
		} ]
	});
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
<script language="JavaScript"
	src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
