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
	response.sendRedirect("/event2020/winter_2020_evt.jsp");
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
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<META NAME="description" CONTENT="APP에서 한가위 준비하면,  LG 빔프로젝트 당첨!">
<META NAME="keyword" CONTENT="에누리가격비교, 프로모션, 월동에누리다, 월동, 월동 이벤트, 매일참여">
<meta name="format-detection" content="telephone=no" />
<!-- 프로모션 공통 CSS (Mobile) -->
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css"
	type="text/css">
<!-- 프로모션별 커스텀 CSS  -->
<link rel="stylesheet" href="/css/event/y2020/winter_m.css" type="text/css">
<link rel="stylesheet" type="text/css"
	href="/mobilefirst/css/lib/slick.css" />
<script type="text/javascript"
	src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<script type="text/javascript" src="/common/js/function.js"></script>
</head>
<body>
<div id="eventWrap">
	<%@include file="/mobilefirst/event2020/winter_header.jsp" %>
	<!-- //비쥬얼,플로팅탭 -->
	<!-- 이벤트01 -->
	<div id="evt1" class="section event_01 scroll">
		<div class="inner">
			<h2>
				<span class="tx_sm">호빵을 따끈하게 데워주세요!</span>
				<span class="tx_main">매일매일 <em>스타벅스 카페모카</em> 당첨!</span>
			</h2>
			<div class="gift"><span class="blind">[스타벅스] 카페모카 Tall e5,100점</span></div>
			<%
			
			String inTime   = new java.text.SimpleDateFormat("HHmmss").format(new java.util.Date());
            
        	String time1 = "";
        	String time2 = "";
        	
        	int getTime = Integer.parseInt(inTime);
        	
        	if( getTime >=  000000 && getTime <=  150000  ){
        		time1 = "is-on";
        	}else{
        		time2 = "is-on";
        	}
			%>
			<ul class="box_round">
			<!-- 1차 타임 / 활성화는 is-on 클래스 붙여주세요 -->
				<li class="<%=time1 %>">
					<div class="tx_round">
						<span class="tx_tit">1차 타임</span>
						<span class="tx_time">12:00 AM ~ 3:00 PM</span>
					</div>
				</li>		
				<!-- 2차 타임 -->
				<li class="<%=time2 %>">
					<div class="tx_round">
						<span class="tx_tit">2차 타임</span>
						<span class="tx_time">03:00 PM ~ 12:00 AM</span>
					</div>
				</li>
			</ul>
			<div class="hoppang">
				<div class="obj_microwave">
					<div class="obj_screen">
						<div class="obj_screen_in"></div>
					</div>
					<div class="obj_timer">
						<span class="tx_num tx_num_01" data-num-count="2"></span>
						<span class="tx_num tx_num_02" data-num-count="0"></span>
						<span class="tx_num tx_num_03" data-num-count="0"></span>						
						<span class="tx_colon"></span>
					</div>
					<button class="btn_start">시작</button>
					<button class="btn_stop" style="display:none">중지</button>
				</div>
			</div>
		</div>
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop1"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop1" class="evt_notice--slide">
			<div class="evt_notice--inner"> <!-- .wide - 넓은 케이스 -->
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<ul>
							<li>이벤트 참여 : ID당 1일 2회 참여 가능</li>
							<li>이벤트 참여 혜택 : e5,100점, e5점</li>
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
                <li class="ben_item--01"><a href="http://m.enuri.com/mobilefirst/evt/welcome_event.jsp" target="_blank">첫구매 고객이라면! Welcome 혜택</a></li>
                <li class="ben_item--02"><a href="http://m.enuri.com/mobilefirst/evt/visit_event.jsp" target="_blank">하루라도 농치면 손해 매일100% 당첨</a></li>
                <li class="ben_item--03"><a href="http://m.enuri.com/mobilefirst/evt/smart_benefits.jsp?freetoken=event&tab=2" target="_blank">지금 가전을 구매하면? 최대 적립 10배</a></li>
                <li class="ben_item--04"><a href="" target="_blank">아직 끝나지 않은 혜택 더 많은 이벤트</a></li>
            </ul>
        </div>
	</div>
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
<div class="voteResult_layer" id="prizes" style="display:none">
	<div class="inner_layer">
		<div class="cont_area">
			<div class="img_box">
				<!-- 5,100점 적립 이미지 -->
				<div class="result_01" style="display:none">
					<img src="http://img.enuri.info/images/event/2020/winter/m_reward_img01.jpg" alt="축하합니다! 스타벅스 카페모카 e5,100">
				</div>
				<!-- 5점 적립 1 -->
				<div class="result_02" style="display:none">
					<img src="http://img.enuri.info/images/event/2020/winter/m_reward_img02.jpg" alt="땡! 호빵이 아직 얼음처럼 차가워요!">
				</div>
				<!-- 5점 적립 2 -->
				<div class="result_03" style="display:none">
						<img src="http://img.enuri.info/images/event/2020/winter/m_reward_img03.jpg" alt="오래 데운 호빵이 빵!하고 터졌어요!">
				</div>
			</div>
			<a class="btn layclose" href="#" onclick="onoff('prizes'); return false;"><em>팝업 닫기</em></a>
		</div>
	</div>
</div>

<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
<script type="text/javascript">
var app = getCookie("appYN"); //app인지 여부
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로
var isFlow = "<%=flow%>" == "ad";
var vOs_type = getOsType();
var state = false;
var tab = "<%=tab%>";
Kakao.init('5cad223fb57213402d8f90de1aa27301');
$(".go_top").click(function(){		$('body, html').animate({scrollTop:0}, 500);	});


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



(function (global, $) {
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
function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2020%2Fwinter_2020_evt.jsp";
	if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
		goapp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2020/winter_2020_evt.jsp";
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
			} else{
				window.open(goApp);
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
var userId = "<%=cUserId%>";
$(document).ready(function() {
	// 개인정보 불러오기
	$("body").append("<iframe id='iframeField'></iframe>");
	$("#iframeField").hide();
	
	$(".ben_item--04").click(function(){
		var url = (app != "Y" ? "/mobilefirst/index.jsp#evt" : "/mobilefirst/renew/plan.jsp?freetoken=main_tab|event")
		window.open(url);
	});
});

var isClick = true;
var sdt = "<%=strToday%>";
function getEventAjaxData(params, callback){
	
	/*  if(sdt < "20201026"){
		alert('오픈예정입니다.');
		return false;
	}
	if(sdt > "20201122"){
		alert('이벤트가 종료되었습니다.');
		return false;
	} */

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
			var evtUrl = "/mobilefirst/evt/ajax/winter2020_setlist.jsp";
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
		
		var hoppang = {
				el : {
					wrap : $(".hoppang"),
					obj_in : $(".hoppang .obj_screen_in"),
					btnStart : $(".hoppang .btn_start"),
					btnStop : $(".hoppang .btn_stop"),
					numMin : $(".tx_num.tx_num_01"),
					numSec1 : $(".tx_num.tx_num_02"),
					numSec2 : $(".tx_num.tx_num_03")
				},
				init : function(){ // 스타트 버튼 이벤트
					var _self = this;
					this.el.btnStart.click(function(){
						_self.el.btnStart.addClass("play");
						_self.el.btnStop.addClass("play").fadeIn(200);
						_self.addEvent();								
					});
				},
				addEvent : function(){ // 호빵돌리고, 카운트
					var _self = this;
					var time = 120; // 2분
					var mwTimer;
					_self.el.obj_in.addClass("play");
					
					setTimeout(function(){ // 전자레인지 카운트
						_self.el.obj_in.addClass("spin");
					},300);

					mwTimer = setInterval(function(){
						txm = parseInt(time/60,10); // 분
						txs = parseInt(time%60,10); // 초
						( txs < 10 ) ? txs = "0"+txs : txs = String(txs); // 
						_self.el.numMin.attr("data-num-count",txm);
						_self.el.numSec1.attr("data-num-count",txs.charAt(0));
						_self.el.numSec2.attr("data-num-count",txs.charAt(1));
						// console.log(txm,txs,time);
						if ( time ) {
							time -= 1
						}else{ // 2분지나면 자동으로 결과 노출
							_self.el.btnStop.click();
						}
					},1000);							

					_self.el.btnStop.click(function(){ // 정지 클릭
						$(this).unbind("click");
						_self.el.btnStop.removeClass("play");
						_self.el.obj_in.removeClass("spin");
						clearInterval(mwTimer);								
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
								}else if(result == -56){
									alert("1차 타임에 이미 참여 하셨습니다.\n2차 타임에 또 참여해 주세요!");
								}else if(result == -57){
									alert("2차 타임에 이미 참여 하셨습니다. 내일 또 참여해 주세요!");
								}else{
									working = false;
								}
							});
						},500);
					});
				},
				reset : function(){ // 오브젝트 초기화 - 재배치
					this.el.btnStart.removeClass("play");
					this.el.obj_in.removeClass("play spin");
					this.el.btnStart.removeClass("play");
					this.el.btnStop.removeClass("play").fadeOut(200);
					this.el.numMin.attr("data-num-count",2);
					this.el.numSec1.attr("data-num-count",0);
					this.el.numSec2.attr("data-num-count",0);
				}
			}
			// 실행
			hoppang.init();

			// 당첨 결과 처리
			function rewards(result){
				// 0 - 낙첨 - 5점 적립
				// 1 - 당첨 - 5,600점 적립
				ga_log(6);
				setTimeout(function(){
					// 스크린 비우기
					$("#prizes .vote_img > div").hide();
					// 레이어 띄우기
					// 결과 레이어 노출
					if ( result==5 ){ // 낙첨
						// 팝업 띄우기
						var resultImg = new Array(2, 3);
						onoff('prizes');
						$("#prizes").find(".result_0"+resultImg[Math.floor(Math.random()*resultImg.length)]).show(); // 5점
						// 게임 초기화
						hoppang.reset();
					}else if(result>5){ // 당첨
						// 팝업 띄우기
						onoff('prizes');
						$("#prizes").find(".result_01").show(); // 4,500점
						// 게임 초기화
						hoppang.reset();								
						//팝업 띄우기
					}
				},500); 
			}      		
		})
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
welcomeGa("evt_winter2020_view"); 
},500);
function goPlan(){
	da_ga(4);
	location.href = "/mobilefirst/event2020/winter_2020.jsp";
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
