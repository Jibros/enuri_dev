<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{ //pc일때 접속페이지 변경.
	response.sendRedirect("/event2020/enurixsmd_2020_evt.jsp");
	return;
}

String chkId     = ChkNull.chkStr(request.getParameter("chk_id"),"");
String cUserId   = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK"),"");

Members_Proc members_proc = new Members_Proc();
String cUsername = members_proc.getUserName(cUserId);
String userArea = cUsername;

String strUrl = request.getRequestURI();

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;

    if(cUsername.equals(""))        userArea = cUserNick;
    if(userArea.equals(""))        userArea = cUserId;
}
String strFb_title = "[에누리 가격비교]";
String strFb_description = "에누리 X 스마트택배 프로모션";
String strFb_img = ConfigManager.IMG_ENURI_COM + "/images/mobilenew/images/logo_enuri.png";
String tab = ChkNull.chkStr(request.getParameter("tab"),"");
String flow = ChkNull.chkStr(request.getParameter("flow"));

SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");	//오늘 날짜
String strToday = formatter.format(new Date());
String sdt = ChkNull.chkStr(request.getParameter("sdt"));

if(!"".equals(sdt) && request.getServerName().equals("dev.enuri.com")){
	strToday = sdt;
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<META NAME="description" CONTENT="에누리 X 스마트택배의 환상 콜라보!">
	<META NAME="keyword" CONTENT="에누리가격비교, 프로모션, 스마트택배, 스윗트래커, 가격비교, 이벤트">
	<meta property="og:title" content="최저가 쇼핑은 에누리에서~">
	<meta property="og:description" content="에누리 X 스마트택배의 환상 콜라보!">
	<meta property="og:image" content="<%=strFb_img%>">
	<meta name="format-detection" content="telephone=no" />
	<!-- 프로모션 공통 CSS (Mobile) -->
	<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
	<link rel="stylesheet" href="/css/event/y2020/enurixsmd_m.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/lib/animate.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<link rel="stylesheet" href="/css/swiper.css" type="text/css">
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
	<script type="text/javascript" src="/common/js/function.js"></script>
	<script type="text/javascript" src="/common/js/paging_visit_201708.js"></script>
	<script type="text/javascript" src="/js/swiper.min.js"></script>
</head>
<body>
<div id="eventWrap">

	<div class="myarea">
		<p class="name">나의 <em class="emy">머니</em>는 얼마일까?<button type="button" class="btn_login" onclick="goLogin();">로그인</button></p>
		<a href="javascript:///" class="win_close">창닫기</a>
	</div>

	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">
		<!-- visual -->
		<div class="visual">		
			<div class="inner">
				<h2>
					<span class="txt_sub">최저가 검색부터 편리한 배송추적까지</span>
					<span class="txt_tit">
						똑똑한 쇼핑습관
						<em>에누리</em><i class="ico_x">X</i><em>스마트택배</em>
					</span>
				</h2>
				<div class="top_obj"></div>
			</div>	
			<div class="loader-box">
				<div class="visual-loader"></div>
			</div>
			<script>
				// 상단 타이들 등장 모션
				$(window).load(function(){
					var $visual = $(".toparea .visual");
					$visual.addClass("intro");
					setTimeout(function(){
						// $visual.addClass("end");
					},2000)
				})
			</script>	
		</div>
	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<!-- 이벤트01 -->
	<div id="evt1" class="section event_01 scroll"><!-- 이벤트 1 앵커 영역 -->
		<div class="intro_wrap">
			<div class="intro_tab">
				<ul>
					<li class="on"><a href="#" onclick="return false;"><em>에누리 가격비교</em></a></li>
					<li><a href="#" onclick="return false;"><em>스마트택배</em></a></li>
				</ul>
			</div>
			<div class="intro_cont">
				<div class="intro_slide intro_slide_01 on">
					<h3>똑똑한 쇼핑습관 <em>땡큐! 에누리!</em></h3>
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<div class="swiper-slide"><div class="slide_inner"><img src="http://img.enuri.info/images/event/2020/enurixsmd/slide1_01.png" alt="강력한 검색기능! 빠르고 편리하게 가격비교 후 최저가 쇼핑"></div></div>
							<div class="swiper-slide"><div class="slide_inner"><img src="http://img.enuri.info/images/event/2020/enurixsmd/slide1_02.png" alt="상품명, 가격, 속성 등 표준화된 정보제공! 똑똑한 쇼핑"></div></div>
							<div class="swiper-slide"><div class="slide_inner"><img src="http://img.enuri.info/images/event/2020/enurixsmd/slide1_03.png" alt="APP에서 구매하면? 구매금액의 최대 1.5% e머니 적립까지!"></div></div>
							<div class="swiper-slide"><div class="slide_inner"><img src="http://img.enuri.info/images/event/2020/enurixsmd/slide1_04.png" alt="매일 최대 90% 파격 할인 선착순 크레이지 딜은 보너스~"></div></div>
						</div>
					</div>
					<div class="swiper-pagination"></div>
				</div>
				<div class="intro_slide intro_slide_02">
					<h3>No.1 택배조회 서비스 <em>땡큐! 스마트택배!</em></h3>
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<div class="swiper-slide"><div class="slide_inner"><img src="http://img.enuri.info/images/event/2020/enurixsmd/slide2_01.png" alt="구매이력을 한번에! 라인 쇼핑몰을 보기 쉽게 한눈에"></div></div>
							<div class="swiper-slide"><div class="slide_inner"><img src="http://img.enuri.info/images/event/2020/enurixsmd/slide2_02.png" alt="실시간 위치 추적 나의 택배 위치를 알림으로 받아보세요."></div></div>
							<div class="swiper-slide"><div class="slide_inner"><img src="http://img.enuri.info/images/event/2020/enurixsmd/slide2_03.png" alt="보내는 택배도 간편하게 예약 가능!"></div></div>
							<div class="swiper-slide"><div class="slide_inner"><img src="http://img.enuri.info/images/event/2020/enurixsmd/slide2_04.png" alt="상품가격, 월별지출 등 쇼핑다이어리로 간편하게"></div></div>
						</div>
					</div>
					<div class="swiper-pagination"></div>
				</div>
			</div>
		</div>
		<script>
			$(function(){
				var $tab = $(".event_01 .intro_tab li");
				var $slide = $(".event_01 .intro_slide");
				var arrSwiper = [null,null];
				$tab.on('click',function(e){
					if ( !$(this).hasClass("on") ){
						var _idx = $(this).index();
						$(this).addClass("on").siblings().removeClass("on");
						$slide.eq(_idx).addClass("on").siblings().removeClass("on");
						if ( _idx ) {
							arrSwiper[1].slideTo(0);
							arrSwiper[1].startAutoplay();
							arrSwiper[0].stopAutoplay();
						}else{
							arrSwiper[0].slideTo(0);
							arrSwiper[0].startAutoplay();
							arrSwiper[1].stopAutoplay();
						}
					}
				})
				$.each(arrSwiper,function(e){
					var _locate = '.event_01 .intro_slide_0'+(e+1);
					arrSwiper[e] = new Swiper(_locate+' .swiper-container',{
						pagination : _locate+' .swiper-pagination',
						autoplay : 4000,
						autoplayDisableOnInteraction:false,
						paginationClickable : true,
						centeredSlides : true,
						slidesPerView : 1.1,
						loop : false,
						speed : 1000
					});
				})
				arrSwiper[1].stopAutoplay();
			})
		</script>
	</div>
	<!-- // 이벤트01 -->

	<!-- 이벤트02 -->
	<div id="evt2" class="section event_02 scroll">				
		<div class="event_wrap">
			<h3>퀴즈 풀고 <em>배스킨라빈스 받으세요!</em></h3>
			<div class="gift">경품 : 배스킨라빈스 싱글레귤러(e3,500점 증정)</div>
		</div>
		<div class="quiz_wrap">
			<dl>
				<dt>여러 쇼핑몰 구매이력을 한번에 모아볼 수 있는 스마트택배만의 편리한 서비스명은?</dt>
				<dd>쇼핑
					<div class="group_inp">
						<!-- 정답입력 -->
						<input type="text" id="replyMsg1" maxlength="1"><input type="text" id="replyMsg2" maxlength="1"><input type="text" id="replyMsg3" maxlength="1"><input type="text" id="replyMsg4" maxlength="1">
					</div>
				</dd>
			</dl>
			<script>
				$(function(){
					$(".quiz_wrap .group_inp input").keyup(function(e){
						if($(this).val().length >= 2 ){
							//$(this).next('input').focus();
						}
					});
				})
			</script>
			<div class="group_btn">
				<!-- 힌트보기 버튼 : 링크 새창으로 연뒤 .disabled 클래스 붙여주세요 -->
				<a href="javascript:///" class="btn_hint">힌트보기</a>
				<a href="javascript:///" id="registBtn" class="btn_apply">응모하기</a>
			</div>
			<!-- 모바일웹 - 앱 레이어 띄움 -->
			<a href="javascript:///" class="btn_cover"></a>
			<!-- // -->
		</div>
		<!-- 버튼 : 꼭 확인하세요 -->
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop1"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop1" class="evt_notice--slide">
			<div class="evt_notice--inner">
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<ul class="list__event">
						<li>이벤트 참여 : ID당 1회 참여 가능</li>
						<li>당첨자 혜택 : [베스킨라빈스] 싱글레귤러 (e머니 3,500점) - 추첨 100명</li>
						<li>e쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립해드립니다.<br/>
						(제휴처의 사정에 따라 해당 쿠폰 품절, 단종, 가격 변동 등이 있을 수 있습니다.)</li>
						<li>당첨자 발표 : 2020년 5월 15일 금요일</li>
						<li>e머니 유효기간 : 적립일로부터 15일</li>
						<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다.</li>
						<li>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</li>
						<li>본 이벤트는 앱에서만 응모 가능합니다.</li>
					</ul>
				</div>
				<div class="evt_notice--foot">						
					<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 유의사항 닫기 -->
				</div>
			</div>
		</div>
		<script>
			// 유의사항 열기/닫기
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
					el.btnSlide.click();
				})
			})
		</script>
	</div>
	
	<!-- //Contents -->	
	<span class="go_top"><a href="#">TOP</a></span>
</div>

<!-- (신규) 공통 : SNS공유하기 -->
<div class="com__share_wrap dim" style="z-index:10000;display:none">
	<div class="com__layer share_layer">
		<div class="lay_head">공유하기</div>
		<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
		<div class="lay_inner">
			<ul id="snslayer">
				<li class="share_fb">페이스북 공유하기</li>
				<li class="share_kakao">카카오톡 공유하기</li>				
				<!-- <li class="share_tw">트위터 공유하기</li> -->
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
						<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2020/newsemester_2020_evt.jsp</span>
						<button class="btn__share_copy" id="copy_btn">복사</button>
						<input id="clip_target" type="text" value="" style="position:absolute;top:-9999em;"/>
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
	<script>
		$('#copy_btn').click(function(){
			var txtVal = $('#txtURL').text(); //복사할 텍스트를 선택
			$('#clip_target').val(txtVal);
			$('#clip_target').select();
			document.execCommand("copy"); //클립보드 복사 실행
			alert('주소가 복사되었습니다');
		})
	</script>
</div>

<!-- layer--> 
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();">설치하기</button></p>
	</div>
</div>

<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20180831"></script>
<script type="text/javascript">
var app = getCookie("appYN"); //app인지 여부
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로
var vEvent_title = "20년 에누리 X 스마트택배 프로모션";
var isFlow = "<%=flow%>" == "ad";
var vOs_type = getOsType();
var event_id = "2020030901";
var state = false;
var tab = "<%=tab%>";

$(".go_top").click(function(){		$('body, html').animate({scrollTop:0}, 500);	});

Kakao.init('5cad223fb57213402d8f90de1aa27301');

function da_ga(num){
	
	if(num == 2){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 에누리 X 스마트택배 프로모션_탭_이벤트1");
	}else if(num == 3){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 에누리 X 스마트택배 프로모션_탭_이벤트2");
	}else if(num == 4){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 에누리 X 스마트택배 프로모션_탭_에누리 X 스마트택배 쇼핑");
	}else if(num == 5){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 에누리 X 스마트택배 프로모션_상단플로팅배너");
	}else if(num == 6){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 에누리 X 스마트택배 프로모션_이벤트1참여");
	}else if(num == 7){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 에누리 X 스마트택배 프로모션_상품탭_새학기패션");
	}else if(num == 8){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 에누리 X 스마트택배 프로모션_상품탭_새학기가전");
	}else if(num == 9){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 에누리 X 스마트택배 프로모션_상품탭_새학기가구");
	}else if(num == 10){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 에누리 X 스마트택배 프로모션_상품탭_새학기문구");
	}
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
		//window.location.replace("/mobilefirst/index.jsp");
		window.history.back();
	}
});

(function (global, $) {
	//스크롤
	var nav = $('.myarea'); 
	$(window).scroll(function () {
		if ($(this).scrollTop() > $(".event_01").offset().top) {
			nav.addClass("f-nav");
		} else {
			nav.removeClass("f-nav");
		}
	});
}(window, window.jQuery));

//등록하기
function insertAttend() {
	var replyMsg = $("#replyMsg1").val()+$("#replyMsg2").val()+$("#replyMsg3").val()+$("#replyMsg4").val();

	if (replyMsg.length < 1) {
		alert("다시 입력해주세요!");
		return false;
	}

	var url = "/mobilefirst/evt/ajax/event_enurixsmd_ajax.jsp";
	var vData = {replyMsg : replyMsg, event_id : event_id, osType:getOsType()};

	$.ajax({
        type: "POST",
        url: url,
        data: vData,
        dataType: "JSON",
        success: function(result){
        	 if (result.result == "true") {
        		alert("응모가 정상적으로\n완료되었습니다");
        	 }else if(result.result == "over"){
        		 alert("아이디당 하루 10건까지 작성 가능합니다.\n내일 또 남겨주세요~");
        	 }else if(result.result == "correct"){
        		 alert("이미 응모하셨습니다.");
        	 }else {
				 alert("정상 응모가 되지않았습니다.\n다시 확인해주세요.");
			}
        	 $('input[id^="replyMsg"]').val("");
        },
		error: function (xhr, ajaxOptions, thrownError) {
		}
    });
}

/*레이어*/
function onoff(id){
	var mid = $("#"+id);
	if(mid.css("display") !== "none"){
		mid.css("display","none");
	}else{
		mid.css("display","");
	}
}

$(document).ready(function() {
	// 개인정보 불러오기
	if(islogin()){
		$(".login_alert").addClass("disNone");
		$("#user_id").text("<%=cUserId%>");
	}
	
	ga('send', 'pageview', {'page': vEvent_page,'title': '20 에누리 X 스마트택배_PV'});
	
	//로그인시 개인화영역
	if(islogin()){
		$("#user_id").text("<%=cUserId%>");
		getPoint();//개인e머니 내역 노출
	}
	
	$("#registBtn").click(function() {
		if (islogin()) {
			if(!getSnsCheck()){
				if (confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?") == true){    
					location.href="https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
				}else{
					return false;
				}
			}else{
				if(getCookie("appYN") == 'Y'){
					insertAttend();
				}else{
					onoff('app_only');
					return false;
				}
			}
		} else {
			alert("로그인 후 참여 가능합니다!");
			goLogin();
			return false;
		}
	});
	
	if(getCookie("appYN") == 'Y'){
		$(".btn_cover").css('z-index', -1000);
	}else{
		$(".btn_cover").click(function() {
			onoff('app_only');
			return false;
		});
	}
	
	$(".btn_hint").click(function() {
		if ( !$(this).hasClass("disabled") ){
			$(this).addClass("disabled");
		}
		window.open("http://st.sweettracker.co.kr/?freetoken=shoppingknow");
	});
	
	$("#snslayer li").click(function(){
		var shareUrl = "http://" + location.host + "/mobilefirst/event2020/enurixsmd_2020_evt.jsp";
		var shareTitle = "[에누리 가격비교]\에누리 X 스마트택배 이벤트!";
		var idx = $(this).index();
		
		if(idx == 1) {
			 try{ 
				
				Kakao.Link.sendDefault({
				      objectType: 'feed',
				      content: {
				        title: shareTitle,
				        description: "똑똑한 쇼핑습관!\n에누리 X 스마트택배\n퀴즈만 풀어도 아메리카노 증정!",
				        imageUrl: "<%= ConfigManager.IMG_ENURI_COM%>/images/mobilenew/images/enuri_logo_facebook200.gif",
				        link: {
				          mobileWebUrl: shareUrl,
				          webUrl: shareUrl
				        }
				      }
				    });
				
			}catch(e){
				alert("카카오 톡이 설치 되지 않았습니다.");
				alert(e.message);
			}
		} else {
			window.open("http://www.facebook.com/sharer.php?u=" + shareUrl);
		}
	});
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
	welcomeGa("evt_newsemester_view"); 
	},500);
</script>
</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
