<%@ page contentType="text/html; charset=utf-8" %>
<%@include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
String chkId = request.getParameter("chk_id");
String appYN = ChkNull.chkStr(request.getParameter("app"),"");
String strCh = ChkNull.chkStr(request.getParameter("ch"),"");
String strGno = ChkNull.chkStr(request.getParameter("g_no"));
String appYnImg = "";

String strUrl = request.getRequestURI();

String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");
String EVENTID="2017042401";

Members_Proc members_proc = new Members_Proc();


String cUsername = members_proc.getUserName(cUserId);
String userArea = cUsername;

if(cUsername.equals("")){
	userArea = cUserNick;
}
if(userArea.equals("")){
	userArea = cUserId;
}


if(appYN.isEmpty()){
	appYN = "N";
	try{
		Cookie[] cookies = request.getCookies();              

		if(cookies!=null){                                    
	
			for(int i=0; i<cookies.length; i++){                    
				if(cookies[i].getName().equals("appYN")){            	
					appYN =cookies[i].getValue();                   
					break;
				}
			}
		}
	}catch(Exception e){
		appYN = "N";	
	}finally{
		
	}
}else{
	appYN = "Y";
}

String referer = ChkNull.chkStr(request.getHeader("referer"),"");

long cTime = System.currentTimeMillis(); 
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmm");
String nowDt = dayTime.format(new Date(cTime));
SimpleDateFormat dayTime2 = new SimpleDateFormat("yyyyMMddHHmmss");
String nowDt2 = dayTime2.format(new Date(cTime));


if(appYN.equals("Y")){
	appYnImg = "_app";
}

//pc면 pc로 센딩
if(
		(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Linux") >= 0 ) ||  
		(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||  
		(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||  
		(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0)
){}else{
	response.sendRedirect("http://www.enuri.com/event2017/luckytime_201704.jsp");
	return;
}
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
	<meta property="og:title" content="[에누리 가격비교]">
	<meta property="og:description" content="모바일 어워드 3년 연속 수상 기념! 오후 2시! 에누리가 디저트 쏜다!">
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/css/event/luckytime3rd_m.css"/>
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/utils.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/flick.event.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/event_regular.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/common/js/iscroll.js"></script>
	<script src="/mobilefirst/js/lib/jquery.paging.min.js"></script>
	<script src="/mobilefirst/js/lib/jquery.easy-paging.js"></script>
	<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		//런칭할때 UA-52658695-3 으로 변경
		ga('create', 'UA-52658695-3', 'auto');
		
		var _TRK_CC = 98;
	</script>
</head>

<body>
<!-- layer-->
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="onoff('app_only')">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();">설치하기</button></p>
	</div>
</div>

<!-- 개인영역 -->
<div class="myarea nav-container" id="topFix">
	<p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>
	<a href="#" class="win_close">창닫기</a>
</div>
<!--// 개인영역 -->

<div class="wrap">
	<!-- tab_area -->
	<div class="tab_area">
		<div class="inner">
			<ul class="tabmenu">
				<li class="tab1"><a class="btn" href="javascript:;"><strong>출석체크</strong></a></li>
				<li class="tab2"><a class="btn" href="javascript:;"><strong>구매혜택</strong></a></li>
				<li class="tab3"><a class="btn" href="javascript:;"><strong>첫 혜택</strong></a></li>
			</ul>
		</div>		
	</div>
	<!-- //tab_area -->

	<!-- EVENT BOARD -->
	<div class="eventboard">
		<ul class="sns" style="display:none">
			<li><a href="javascript:///">카카오톡</a></li>
			<li><a href="javascript:///">페이스북</a></li>
		</ul>

		<div class="visual">
			<div class="img_box">
				<img src="http://imgenuri.enuri.gscdn.com/images/event/2017/luckytime3rd/m_visual.jpg" alt="" />

				<div class="ir_txt">
					<h1>에누리 습격사건!</h1>
					<p>오후 2시! 디저트 쏜다!</p>
					<p>소비자가 직접 선정하는 모바일 어워드 코리아 3년연속 수상 기념!</p>
					<p>이벤트 기간 : 2017년 4월 24일부터 5월 5일 (월~금)까지 매일 오후 2시 오픈!</p>
				</div>
			</div>
		</div>
		
		<div class="cont_area">
			<div class="img_box daily">
				<img src="http://imgenuri.enuri.gscdn.com/images/event/2017/luckytime3rd/m_evt_img01.jpg" alt="" />
				<div class="ir_txt">
					<h2>오후 2시</h2>
				</div>
				
				<div class="lt_time">
					<img src="http://imgenuri.enuri.gscdn.com/images/event/2017/luckytime3rd/m_evt_img02.jpg" alt="세븐일레븐 요구르트 젤리 e머니 1,200점" />
					<div class="lt_alarm">

						<p class="time" id="tag_ing"></p>
						<p class="time" id="tag_soldout" style="display:none;">SOLDOUT</p>
	
					</div>
				</div>

				<a href="javascript:;" class="goEvent"><img src="http://imgenuri.enuri.gscdn.com/images/event/2017/luckytime3rd/m_evt_img03.jpg" alt="참여하기 버튼" /></a>

				<ul class="evt_info">
					<li>· 이벤트 기간 : 2017년 4월 24일~5월 5일 (월~금)</li>
					<li>· 이벤트 기간 내 1인 1개 당첨</li>
				</ul>
				
				<a href="javascript:;" id="prevWoner"><img src="http://imgenuri.enuri.gscdn.com/images/event/2017/luckytime3rd/m_evt_img04.jpg" alt="이전 당첨자 발표 &gt;" /></a>
				<a href="javascript:;" onclick="onoff('notetxt'); return false;"><img src="http://imgenuri.enuri.gscdn.com/images/event/2017/luckytime3rd/m_btn_caution.jpg" alt="꼭! 확인하세요" /></a>
			</div>
		</div>
	</div>

	<%@ include file="/mobilefirst/evt/emoney_guide.jsp"%><!-- 생활혜택 -->
	
	<span class="go_top"><a href="#">TOP</a></span>

</div>

<!-- 앱전용 이벤트 LAYER --> 
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 쇼핑 혜택</h4>
		<a href="javascript:///" class="close" onclick="onoff('app_only')">창닫기</a>
		<p class="txt">에누리 앱(APP) 설치 후<br />e머니 적립내역 확인 및<br />다양한 e쿠폰 상품으로 교환할 수 있습니다.</p>
		<p class="btn_close"><button type="button">설치하기</button></p>
	</div>
</div>
<!-- //앱전용 이벤트 LAYER --> 

<!-- 1 이벤트 유의사항 --> 
<div class="layer_back over_ht" id="notetxt" style="display:none">
	<div class="appLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt')">창닫기</a>
		<div class="txt">
			<ul class="txt_indent">
				<li>ID당 1회 참여 가능</li>
				<li>매회 선착순 250명 당첨 시까지 진행됩니다.</li>
				<li>당첨 경품: 세븐일레븐 요구르트 젤리 (e1,200)</li>
				<li>경품 당첨 시, e쿠폰스토어에서 해당 경품으로 교환할 수 있는 e머니로 적립해드립니다. <br />(제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격 변동 있을 수 있습니다.)</li>
				<li>적립된 e머니는 앱 설치 후 다양한 e쿠폰상품으로 교환 가능합니다. </li>
				<li>e머니 유효기간: 적립일로부터 30일 (미사용시 자동소멸)</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
			</ul>
		</div>
		<p class="btn_close"><button type="button" onclick="onoff('notetxt')">확인</button></p>
	</div>
</div>

<!-- 당첨 축하 레이어 --> 
<div class="prizes_layer" id="prizes" style="display:none">
	<div class="inner_layer">
		<h3 class="tit stripe">당첨을 축하합니다.</h3>
		<a href="javascript:///" class="stripe close" onclick="onoff('prizes')">창닫기</a>

		<div class="viewer">
			<div class="img_box">
				<img src="http://imgenuri.enuri.gscdn.com/images/event/2017/luckytime3rd/m_img_prizes01.jpg" alt="세븐일레븐 요구르트 젤리(e머니 1,200점)" />
			</div>
			<p class="txt">앱 &gt; 마이에누리에서 경품으로 교환할 수 있습니다.</p>
		</div>
		<p class="btn_close"><button type="button" class="stripe" onclick="onoff('prizes')">확인</button></p>
	</div>
</div>

<!-- 이전 당첨자 발표 레이어 --> 
<div class="won_layer" id="wonList" style="display:none">
	<div class="inner_layer">
		<h3 class="tit stripe">당첨자 발표</h3>
		<a href="javascript:///" id="wonClose" class="stripe close">창닫기</a>

		<div class="viewer">
			<div class="won_wrap">
				<a href="#" class="won_btn" id="wonDate">당첨일 ▼</a>
				
				<div id="scrollArea2" class="scr_box2" style="display:none;">
					<div class="scroller">
						<!-- 당첨일자 클릭 → 당첨자 리스트 갱신 : 346 line -->
						<ul class="won_date">
							<li><a href="javascript:;" onclick="onWinnerDayClick(1);">2017년 04월 24일 (월)</a></li>
							<li><a href="javascript:;" onclick="onWinnerDayClick(2);">2017년 04월 25일 (화)</a></li>
							<li><a href="javascript:;" onclick="onWinnerDayClick(3);">2017년 04월 26일 (수)</a></li>
							<li><a href="javascript:;" onclick="onWinnerDayClick(4);">2017년 04월 27일 (목)</a></li>
							<li><a href="javascript:;" onclick="onWinnerDayClick(5);">2017년 04월 28일 (금)</a></li>
							<li><a href="javascript:;" onclick="onWinnerDayClick(6);">2017년 05월 01일 (월)</a></li>
							<li><a href="javascript:;" onclick="onWinnerDayClick(7);">2017년 05월 02일 (화)</a></li>
							<li><a href="javascript:;" onclick="onWinnerDayClick(8);">2017년 05월 03일 (수)</a></li>
							<li><a href="javascript:;" onclick="onWinnerDayClick(9);">2017년 05월 04일 (목)</a></li>
							<li><a href="javascript:;" onclick="onWinnerDayClick(10);">2017년 05월 05일 (금)</a></li>
						</ul>
					</div>
				</div>

				<div class="person_wrap">
					<p class="wonh">당첨자</p>
					
					<div id="scrollArea1" class="scr_box1">
						<div class="scroller">
							<ul class="per_list"></ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<p class="btn_close"><button type="button" class="stripe" id="wonConfirm">확인</button></p>
	</div>
</div>


<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>

</body>
</html>
<script>
var app = getCookie("appYN"); //app인지 여부
var username = "<%=userArea%>"; <!--개인화영역 이름-->
var vChkId = "<%=chkId%>";
var vOs_type = getOsType();
var vEvent_page = "<%=strUrl%>";<!--경로-->

var vUserId = "<%=cUserId %>";
var nowCd = 0;//이벤트 순서

String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};

var strGno = '<%=strGno%>'+'';

var vNowtime = '<%=nowDt%>';
var vNowtime2 = '<%=nowDt2%>';
var limit_time = 201705052359;

var itemId = new Array();				//JSON itemId
var stDateArr = new Array();			//JSON 시작날짜
var endDateArr = new Array();
var tagDateArr = new Array();

var scrollArea1, // 당첨자 스크롤
scrollArea2, // 당첨일 스크롤
$wonPopup = $("#wonList"); // 이전 당첨자 팝업
$wonDate = $("#scrollArea2") // 당첨일 레이어

var state1 = false, state2 = false;

$(function() {

	$("#owl-demo").owlCarousel({
		items:1,
		navigation : true, // Show next and prev buttons
		slideSpeed : 300,
		paginationSpeed : 400,
		singleItem:true,
		loop:true,
		autoPlay:3000
	 });
	
	//스크롤
	var nav = $('#topFix'); 
	$(window).scroll(function () {
		if ($(this).scrollTop() > 70) {
			nav.addClass("f-nav");
		} else {
			nav.removeClass("f-nav");
		}
	});
	
	var nowDate = vNowtime2.substr(0,4) + "-" + vNowtime2.substr(4,2) + "-" + vNowtime2.substr(6,2) + " " 
				+ vNowtime2.substr(8,2) + ":" + vNowtime2.substr(10,2) + ":" + vNowtime2.substr(12,2) + ".0";
	vNowtime = vNowtime * 1;
	
	$.ajax({
        type: "POST",
        async : false,
        url: "/event2017/luckytime_getlist.jsp",
        dataType: "JSON",
        success: function(data){
			if (data.eventlist.length > 0) {
				for (var i=0; i < data.eventlist.length; i++) {
					itemId[i] = data.eventlist[i].item_id;
					stDateArr[i] = data.eventlist[i].start_date;
				}
			} 
			
        },
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
	});
	
	if(islogin()){ //로그인상태 
		getPoint();
	}
	
	getLuckyTime();
	getBI_random();	//스토어 인기브랜드 call
	
	$(".btn_login").click(function(){
			location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
			return false;
	});
	
	$(".goEvent").click(function(){
		if(vUserId == ""){
			alert("로그인 후 참여할 수 있습니다.")
			goLogin();	//login_check.jsp
		}else{	
			if(vNowtime > limit_time){
				alert("이벤트가 종료되었습니다.");
				return false;
			}else{
				goLuckyTime();
			}
		}
		
		ga('send', 'event', 'mf_event', '럭키타임2', '럭키타임_참여하기');
			
	});
	
	$("#prevWoner, #wonClose, #wonConfirm").on("click", function(e){
		e.preventDefault();
		if(!state1){ // 당첨자 발표 팝업 open
			$wonPopup.show();
			scrollArea1Loaded();
			state1 = true;
		}else if(state1 && state2){ // 당첨일과 당첨자 팝업 같이 닫을 때
			$wonPopup.hide();
			$wonDate.hide();
			
			// iscroll 해제
			scrollArea1.destroy();scrollArea1 = null;
			scrollArea2.destroy();scrollArea2 = null;
			
			state1 = false;		
			state2 = false;
		}else{ // 당첨자 리스트만 닫을 때
			$wonPopup.hide();
	
			// iscroll 해제
			scrollArea1.destroy();scrollArea1 = null;
			state1 = false;
		}
		ga('send', 'event', 'mf_event', '럭키타임2', '럭키타임_당첨자발표');
	});
	
	// 당첨일자 클릭
	$("#wonDate").on("click", function(e){ 
		e.preventDefault();
		if(state1 && !state2){
			$wonDate.fadeIn(100);
			scrollArea2Loaded();
			state2 = true;
		}else if(state2){ // 클릭 후,
			$wonDate.fadeOut(100);

			// iscroll 해제
			scrollArea2.destroy();scrollArea2 = null;
			state2 = false;
		}
	});
	
	//당첨일 클릭 -> 당첨자 리스트 갱신
	$(".won_date li a").click(function(e){
		e.preventDefault();
		
		// 당첨자 리스트 갱신


		$wonDate.hide();

		// iscroll 해제
		scrollArea2.destroy();scrollArea2 = null;
		state2 = false;
	});

	$(".win_close").on('click', function(){
		
    	if($.cookie('appYN') != 'Y' && '<%=appYN %>' != 'Y'){	// 웹에서 호출 
    		 location.href="/mobilefirst/Index.jsp";
    	}else{
    		// 앱에서 호출 
	    	if(window.android){		// 안드로이드 			
	    		window.location.href = "close://";
	    	}else{					// 아이폰에서 호출
	    		window.location.href = "close://";
	    	}
    	}
    	
    });
	
	$("#my_emoney").click(function(){	
		if($.cookie('appYN') != 'Y' && '<%=appYN %>' != 'Y'){	// 웹에서 호출 
			onoff('app_only');
			ga('send', 'event', 'mf_event', '럭키타임2', '럭키타임2_e머니현황_WEB');
		}else{
			window.location.href = "/mobilefirst/emoney/emoney.jsp?freetoken=emoney";	//e머니 적립내역
			ga('send', 'event', 'mf_event', '럭키타임2', '럭키타임2_e머니현황_APP');
		}
	});
	
	$(".ecoupon").click(function(){
		if($.cookie('appYN') != 'Y' && '<%=appYN %>' != 'Y'){	// 웹에서 호출 
			onoff('app_only');
			ga('send', 'event', 'mf_event', '럭키타임2', '럭키타임2_e쿠폰교환하기_WEB');
		}else{
			if(vUserId == ""){
				goLogin();	//login_check.jsp
			}else{
				window.location.href = "/mobilefirst/emoney/emoney_store.jsp?freetoken=emoney";	//e쿠폰 스토어
				ga('send', 'event', 'mf_event', '럭키타임2', '럭키타임2_e쿠폰교환하기_APP');
			}
		}
	});

	//설치하기
	$(".mybtn").click(function(){
		var url;
		if( navigator.userAgent.indexOf("iPhone") > -1 || 
			navigator.userAgent.indexOf("iPod") > -1 || 
			navigator.userAgent.indexOf("iPad") > -1){

			url = "https://itunes.apple.com/kr/app/" + 
			"enuli-gagyeogbigyo/id476264124?mt=8&freetoken=outlink";
		}else if(navigator.userAgent.indexOf("Android") > -1){
			url = "market://details?id=com.enuri.android&referrer=" + 
			"utm_source%3Denuri.%26utm_medium%3Dreview_event%26utm_campaign%3Dreview_promotion_20151231%2520";
		}				
		ga('send', 'event', 'mf_event', '럭키타임2', '럭키타임2_앱이벤트설치하기');
		window.location.href = url;
	});
	
	//page view 
	if($.cookie('appYN') == "Y"){
		 if(navigator.userAgent.indexOf("Android") > -1){
			 ga('send', 'pageview', {
				'page': '/mobilefirst/evt/luckytime_201704.jsp',
				'title': '럭키타임2_PV(안드로이드)'
			}); 		
		 }else{
			 ga('send', 'pageview', {
				'page': '/mobilefirst/evt/luckytime_201704.jsp',
				'title': '럭키타임2_PV(ios)'
			}); 				 
		 }
	}else{	
		ga('send', 'pageview', {
			'page': '/mobilefirst/evt/luckytime_201704.jsp',
			'title': '럭키타임2_PV(app)'
		}); 
	}
	
	$(".tab1").click(function(){
		location.href = "/mobilefirst/evt/visit_event.jsp?freetoken=event";
		ga('send', 'event', 'mf_event', '프로모션 공통영역', '상단탭_출석체크');
		return;
	});
	$(".tab2").click(function(){
		location.href = "/mobilefirst/evt/buy_event.jsp?freetoken=event";
		ga('send', 'event', 'mf_event', '프로모션 공통영역', '상단탭_구매혜택');
		return;
	});
	$(".tab3").click(function(){
		location.href = "/mobilefirst/evt/welcome_event.jsp?tab=1&freetoken=event";
		ga('send', 'event', 'mf_event', '프로모션 공통영역', '상단탭_첫혜택');
		return;
	});
	
	ga('send', 'pageview', {
		'page': '/mobilefirst/evt/luckytime_201704.jsp',
		'title': '럭키타임2_PV'
	}); 

});

function getEventIndex(eventList) {
	var now = new Date(); //***테스트용 현재 날짜. 배포 시 var now = new Date();로 바꿀것
	var startDate, eventDay, toDay;
	for(var idx in eventList) {
		startDate = stringToDate(eventList[idx].start_date);
		//이벤트 시작 날짜 년월일
		eventDay = startDate.getFullYear() * 10000 + startDate.getMonth() * 100 + startDate.getDate();
		//오늘 날짜 년월일
		toDay = now.getFullYear() * 10000 + now.getMonth() * 100 + now.getDate();

		//오늘 날짜가 이벤트 날짜 시간 내에 있을 때
		if(toDay >= eventDay && toDay < (eventDay + 1)) {
			return idx;
		}
	}
	return 0;
}

function stringToDate(strDate) {
	strDate = String(strDate);
	var newDate = new Date(strDate.substring(0, 10));

	if(strDate.length > 13)
		newDate.setHours(parseInt(strDate.substr(11,2)));
	if(strDate.length > 16)
		newDate.setMinutes(parseInt(strDate.substr(14,2)));
	if(strDate.length > 19)
		newDate.setSeconds(parseInt(strDate.substr(17,2)));

	return newDate;
}

function onWinnerDayClick(itemId) {

	try{
		if(scrollArea1 != null){
			scrollArea1.destroy();
			scrollArea1 = null;
		}
	}catch(e){}
	
	
	$('.per_list').empty();
	var now = new Date(); //***테스트용 현재 날짜. 배포 시 var now = new Date();로 바꿀것
	//if(now.getTime())
	$.ajax({
				type: "POST",
				async : false,
				url: "/event2017/luckytime_winnerlist.jsp?item_id=" + itemId,
				data : {eventid: '<%=EVENTID%>', item_id : itemId } ,

				async: false,
				success: function(result) {
					var jsonArray = $.parseJSON(result);

					for(idx in jsonArray) {
						var obj = jsonArray[idx];
						var enuriId = String(obj.enuri_id);
						if(enuriId.length > 2)
							enuriId = enuriId.substring(0, enuriId.length -2) + '**';

						$('.per_list').append('<li>' + enuriId + '</li>');
					}
					
					scrollArea1Loaded(); 
				},
				error: function (xhr, ajaxOptions, thrownError) {
				}
	});

}

//로그인 링크
function goLogin() {
	if($.cookie('appYN') != 'Y' && '<%=appYN %>' != 'Y'){
		document.location.href = "/mobilefirst/login/login.jsp?app=&backUrl="+encodeURIComponent(document.location.href);
	}else{
	   	if(window.android){		// 안드로이드 			
	   		document.location.href = "/mobilefirst/login/login.jsp?app=&backUrl="+encodeURIComponent(document.location.href);
	   	}else{					// 아이폰에서 호출
	   		document.location.href = "/mobilefirst/login/login.jsp";
	   	}
	}

	return false;
}


//콤마 옵션
function CommaFormattedN(amount) {
    var delimiter = ","; 
    var i = parseInt(amount);

    if(isNaN(i)) { return ''; }
    
    var minus = '';
    
    if (i < 0) { minus = '-'; }
    i = Math.abs(i);
    
    var n = new String(i);
    var a = [];

    while(n.length > 3)
    {
        var nn = n.substr(n.length-3);
        a.unshift(nn);
        n = n.substr(0,n.length-3);
    }

    if (n.length > 0) { a.unshift(n); }
    n = a.join(delimiter);
    amount = minus + (n+ "");
    return amount;
}

function onoff(id) {
	var mid=document.getElementById(id);
	if(mid.style.display=='') {
	mid.style.display='none';
}else{
	mid.style.display='';
	}
}

function IsLogin() {
	var cName = "LSTATUS";
	var s = document.cookie.indexOf(cName +'=');
	if (s != -1){
		s += cName.length + 1;
		e = document.cookie.indexOf(';',s);
		if (e == -1){
			e = document.cookie.length
		}
		if( unescape(document.cookie.substring(s,e))=="Y"){
			try {
				if(window.android){
					if(vCheckfirst){
						window.android.isLogin("true");
						vCheckfirst = false;
					}
				}
			} catch(e) {}
			return true;
		}else{
			try {
				if(window.android){
					window.android.isLogin("false");
				}
			} catch(e) {}
			return false;
		}
	}else{
		try {
			if(window.android){
				window.android.isLogin("false");
			}	
		} catch(e) {}
		return false;
	}
}

function fn_filterChk(name){
	var chktext = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
	//정규식 구문
	var obj = $("#"+name).val();
	if (chktext.test(obj)) {
		return false;
	}
	return true;
}

function setLog(){
/*
	if(strGno == '2490779') ga('send', 'event', 'mf_event', '럭키타임_WEB', 'LGU+_E1_enuri5');
	else if(strGno == '2454612') ga('send', 'event', 'mf_event', '럭키타임_WEB', '이노캐시_E1_전면3');
	else if(strGno == '2454613') ga('send', 'event', 'mf_event', '럭키타임_WEB', 'shallwe_E1_전면3');
	else if(strGno == '2491520') ga('send', 'event', 'mf_event', '럭키타임_WEB', 'shallwe_E1_enuri5');
	else if(strGno == '2602022') ga('send', 'event', 'mf_event', '럭키타임_WEB', 'Mcloud_E1_enuri5');*/

}

function goLink(){
	if($.cookie('appYN') != 'Y' && '<%=appYN %>' != 'Y'){	// 웹에서 호출 
		window.location.href = "/mobilefirst/event/event_three.jsp?freetoken=event&loc=con01&app=Y";
	}else{
		if(vUserId == ""){
			goLogin();	//login_check.jsp
		}else{
			window.location.href = "/mobilefirst/emoney/emoney_store.jsp?freetoken=emoney";	//e쿠폰 스토어
		}
	}

	return false;
}

function goShoppingBenefit(param){
	if(param == 1){		//설치구매 버튼
		ga('send', 'event', 'mf_event', '생활혜택', '설치구매 버튼');
		location.href = "/mobilefirst/event/event_three.jsp?freetoken=event";
	}else if(param == 2){	//매일당첨 버튼
		ga('send', 'event', 'mf_event', '생활혜택', '매일당첨 버튼');
		location.href = "/mobilefirst/event/visit_2016.jsp?freetoken=event";
	}else if(param == 3){	//자동적립 버튼
		ga('send', 'event', 'mf_event', '생활혜택', '자동적립 버튼');
		location.href = "/mobilefirst/event/event_allpayback_201604.jsp?loc=con02&freetoken=event";
	}else if(param == 4){	//추가적립 버튼
		ga('send', 'event', 'mf_event', '생활혜택', '추가적립 버튼');
		location.href = "/mobilefirst/event/event_allpayback_201604.jsp?loc=con01&freetoken=event";
	}else if(param == 5){	//이벤트 버튼
		ga('send', 'event', 'mf_event', '생활혜택', '이벤트 버튼');
		location.href = "/mobilefirst/event/luckytime_2016.jsp?freetoken=event";
	}else if(param == 6){	//혜택의 완성 버튼
		ga('send', 'event', 'mf_event', '생활혜택', '혜택의 완성 버튼');
		if($.cookie('appYN') != 'Y' && '<%=appYN %>' != 'Y'){
			location.href = "/mobilefirst/event/event_three.jsp?loc=con01&freetoken=event";
		}else{ 
			location.href = "/mobilefirst/emoney/emoney_store.jsp?freetoken=emoney"; 
		}
	}
}

function getOsType(){
    var osType = "";
    if(app == "Y"){
         if(navigator.userAgent.indexOf("Android") > -1)             
        	 osType = "MAA";
         else             
        	 osType = "MAI";
    }else {
         if(navigator.userAgent.indexOf("Android") > -1)             
        	 osType = "MWA";
         else             
        	 osType = "MWI";
    }
    return osType;
}

//응모하기
function goLuckyTime(){
	var vData = {eventid: '<%=EVENTID%>', item_id:itemId[nowCd], os_type: vOs_type};
	
	$.ajax({
        type: "POST",
        async : false,
        url: "/event2017/luckytime_setlist.jsp",
        data : vData ,
        async: false,
        success: function(result){
			result = jQuery.parseJSON(result);
			
			if(result.result == '-1'){
				alert("로그인 후 참여할 수 있습니다.");
				goLogin();
			}else if(result.result == '1'){
				$("#prizes").show();
				getPoint();
			}else if(result.result == '2'){
				alert("1인 1개 당첨가능합니다.");
				getArrivalSeq();	//표시 다시
			}else if(result.result == '-2'){
				alert("임직원은 참여가 불가합니다.");
			}else if(result.result == '99'){
				alert("오픈 시간을 기다려주세요~");//->오늘시간
			}else{
				alert("아쉽게도 선착순이 마감되었습니다."); //->내일시간
				getArrivalSeq();	//표시 다시
			}
			return false;
        },
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
	});
}

function getLuckyTime(){
	$.ajax({
        type: "POST",
        async : false,
        url: "/event2017/luckytime_getlist.jsp",
        dataType: "JSON",
        success: function(data){
        	if (data.eventlist.length > 0) {
				for (var i=0; i < data.eventlist.length; i++) {
					itemId[i] = data.eventlist[i].item_id;
					stDateArr[i] = data.eventlist[i].start_date;
					endDateArr[i] = data.eventlist[i].end_date;
					tagDateArr[i] = data.eventlist[i].tag_date;
				}
				nowCd = getEventIndex(data.eventlist);
				onWinnerDayClick(itemId[nowCd]);
				getArrivalSeq();
			}
        },
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
	});
}

function getArrivalSeq(){
	$.ajax({
		type: "POST",
		url: "/event2017/luckytime_getseq.jsp",
		async: false,
		data: {item_id:itemId[nowCd]},
		dataType:"JSON",
		success: function(json){
			var vArrivalTrue = json.arrivalTrue;
			var jspDate = json.nowDate;
			var now = new Date(jspDate.slice(0, 4), jspDate.slice(4, 6) - 1, jspDate.slice(6, 8), jspDate.slice(8, 10), jspDate.slice(10, 12), jspDate.slice(12, 14));
			
			var toDayEventStart = stringToDate(stDateArr[nowCd]);
			var endDayEventEnd = stringToDate(endDateArr[stDateArr.length-1]);

			if(now.getTime() > endDayEventEnd.getTime()) { //이벤트 종료 후
				$('#tag_ing').text('');
				$('#tag_soldout').show();
				$(".goEvent").unbind("click");
			} else if(nowCd < 0) {
				var soonIdx = getSoonEventIndex(now);//주말
				if(soonIdx != -1) {	
					$('#tag_ing').text(tagDateArr[parseInt(soonIdx)]);
					$('#tag_soldout').hide();
				}
			} else if(now.getTime() < toDayEventStart.getTime()) {	//이벤트 시작 전
				$('#tag_ing').text(tagDateArr[parseInt(nowCd)]);
				$('#tag_soldout').hide();
			} else if(vArrivalTrue) {	//이벤트 기간 중 하루 당첨자 넘었을 경우
				var lastDay = new Date('2017-05-05');
				if(now.getTime() < lastDay.getTime()) {	// 5월 5일 이전에는 다음 날 태그 메시지
					$('#tag_ing').text(tagDateArr[parseInt(nowCd) + 1]);
					$('#tag_soldout').hide();
				} else {	//	5월 5일에는 매진 표시
					$('#tag_ing').text('');
					$('#tag_soldout').show();
					$(".goEvent").unbind("click");
				}
			} else {
				$('#tag_ing').text('');
				$('#tag_soldout').hide();
			}
		}
	});
}

function getSoonEventIndex(date) {
	for(var idx in stDateArr) {
		var eventDate = stringToDate(stDateArr[idx]);
		if(date.getTime() < eventDate.getTime()){
			return idx;
		}
	}

	return -1;
}

function scrollArea1Loaded() { // 당첨자 리스트 ISCROLL
	scrollArea1 = new IScroll('#scrollArea1', { 
		mouseWheel: true,
		scrollbars: true,
		fadeScrollbars: true,
		click: true
	});

	setTimeout(function () {
        scrollArea1.refresh();
    }, 200);
}

function scrollArea2Loaded() { // 당첨일 리스트 ISCROLL
	scrollArea2 = new IScroll('#scrollArea2', { 
		mouseWheel: true,
		scrollbars: true,
		fadeScrollbars: true,
		click: true
	});

	setTimeout(function () {
        scrollArea2.refresh();
    }, 200);
}


</script>
<script language="JavaScript" src="http://imgenuri.enuri.gscdn.com/common/js/Log_Tail_Mobile.js"></script>

</script>