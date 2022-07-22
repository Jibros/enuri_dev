<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
String strFb_title = "[에누리 가격비교] 성탄절에누리다!";
String strFb_description = "매주 수요일 타임특가도 만나보세요!";
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
	response.sendRedirect("/event2020/christmas_2020_evt.jsp");
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
<meta property="og:title" content="<%=strFb_title%>">
<meta property="og:description" content="<%=strFb_description%>">
<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM+"/images/event/2020/xmas/sns_1200_630.jpg"%>">
<meta name="format-detection" content="telephone=no" />
<title>2020 성탄절 기획전 - 최저가 쇼핑은 에누리</title>
<!-- 프로모션 공통 CSS (Mobile) -->
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css"
	type="text/css">
<!-- 프로모션별 커스텀 CSS  -->
<link rel="stylesheet" href="/css/event/y2020/xmas_m.css" type="text/css">
<link rel="stylesheet" type="text/css"
	href="/mobilefirst/css/lib/slick.css" />
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
<script type="text/javascript" src="/event2016/js/event_common.js"></script>
</head>
<body>
<div id="eventWrap">
	<%@include file="/mobilefirst/event2020/season_header.jsp" %>
	<!-- //비쥬얼,플로팅탭 -->
	<!-- 이벤트01 -->
	<div class="section event_game" id="evt1">
		<div class="contents">
			<span class="m_bell"><!--종--></span>
			<h3><img src="http://img.enuri.info/images/event/2020/xmas/m_tab1_g_tit.png" alt="산타 할아버지의 크리스마스 선물 ! 누구나 선물받기 응모하면 ‘꽝’ 없는 푸짐한 선물이 !"></h3>
			<div class="game_wrap">
				<div class="game_main" style="display: block;">
					<div class="gift_box" title="선물이 든 상자를 클릭해주세요!" style="display: block;"><span class="gift_box_front"></span></div>
					<button type="button" class="btn_gift">선물받기</button>
				</div>
			</div>
		</div>

		<!-- 공통 : 꼭 확인하세요  -->
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop1"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop1" class="evt_notice--slide">
			<div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<dl>								
							<dt>이벤트 대상 및 혜택</dt>
							<dd>
								<ul>
									<li>이벤트 참여 : ID당 1회 참여 가능</li>
									<li>경품
										<ul class="sub">
											<li>- Apple 에어팟 프로 (MWP22KH/A) – 2명 당첨  <span class="stress noti">※제세공과금 당첨자 부담</span><br>
												<span class="noti" style="display:block;text-indent:8px">(실물경품의 경우 이벤트 기간 이후 일괄배송될 예정입니다.)</span>
											</li>
											<li>- 맥도날드 빅맥세트 (e머니 5,900점) – 10명 당첨</li>
											<li>- 커피빈 커피 (e머니 5,000점) – 10명 당첨</li>
											<li>- GS25 모바일금액권 1,000원권 (e머니 1,000점) – 50명 당첨</li>
											<li>- 에누리 e머니 100점  - 10,000명 당첨</li>
										</ul>
									</li>
									<li>e머니 유효기간 : 적립일로부터 15일</li>
									<li>이벤트 참여 시 개인정보 수집에 동의하신 것으로 간주됩니다.</li>
									<li>이벤트의 원활한 진행을 위해 당첨자의 참여일시, 참여자ID, 본인인증확인(CI, DI)가 수집되며 수집된 개인정보는 이벤트 참여확인을 위한 본인확인 이외의 목적으로 활용되지 않습니다.</li>
									<li>개인정보 수집자(에누리 가격비교)는 이벤트 기간 동안 개인정보를 수집하며, 이벤트 당첨자 발표 후 개인정보를 즉시 파기합니다.</li>
									<li>잘못된 정보 입력이나, 3회 이상 통화 시도에도 연락이 되지 않을 경우의 경품수령 불이익은 책임지지 않습니다.</li>
									<li>적립된 e머니는 e머니 스토어에서 다양한 e쿠폰상품으로 교환 가능합니다.</li>
									<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
									<li>부정 참여 시 적립 취소 및 사이트 사용이 제한될 수 있습니다.</li>
								</ul>
							</dd>
						</dl>
					</div>
				</div>
				<div class="evt_notice--foot">						
					<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 레이어 닫기 -->
				</div>
			</div>
		</div>
		<!-- // -->
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
<div class="layerwrap">
	<!-- 모바일웹 공통 : 모바일 앱 전용 이벤트  -->
	<div class="layer_back" id="app_only" style="display:none">
		<div class="appLayer">
			<h4>모바일 앱 전용 이벤트</h4>
			<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
			<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br>에누리앱을 설치합니다.</p>
			<p class="btn_close"><button type="button">설치하기</button></p>
		</div>
	</div>

	<!-- 당첨 레이어 -->
	<div id="prizes" class="pop-layer" style="display:none">
		<div class="popupLayer">
			<div class="dim"></div>
		</div>
		<!-- 당첨 박스 -->
		<div class="vote_box">
			<div class="inner">
				<!-- 레이어 -->
				<div class="vote_img">
					<!-- 낙첨 - 100점 적립 이미지 -->
					<div class="result_0100" style="display:none">
						<img src="http://img.enuri.info/images/event/2020/xmas/m_result_img_01.png" alt="축하합니다! e머니 100점 적립 ">
					</div>
					<!-- 당첨 - GS25상품권 당첨(1,000점 적립) 이미지 -->
					<div class="result_01000" style="display:none">
						<img src="http://img.enuri.info/images/event/2020/xmas/m_result_img_02.png" alt="축하합니다! GS25상품권에 당첨됐어요!(1,000점 적립)">
					</div>
					<!-- 당첨 - GS25상품권 당첨(5,000점 적립) 이미지 -->
					<div class="result_05000" style="display:none">
						<img src="http://img.enuri.info/images/event/2020/xmas/m_result_img_03.png" alt="축하합니다! GS25상품권에 당첨됐어요!(5,000점 적립)">
					</div>
					<!-- 당첨 - 빅맥버거세트 당첨(5,900점 적립) 이미지 -->
					<div class="result_05900" style="display:none">
						<img src="http://img.enuri.info/images/event/2020/xmas/m_result_img_04.png" alt="축하합니다! 빅맥버거세트에 당첨됐어요!(5,900점 적립)">
					</div>
					<!-- 당첨 - 에어팟프로 당첨 이미지 -->
					<div class="result_00" style="display:none">
						<img src="http://img.enuri.info/images/event/2020/xmas/m_result_img_05.png" alt="축하합니다! 에어팟프로에 당첨됐어요 실물경품은 이벤트 마감 후 일괄배송됩니다. 조금만 기다려주세요!">
					</div>
				</div>
			</div>
			<a href="#" class="btn layclose" onclick="onoff('prizes');return false"><em>팝업 닫기</em></a>
		</div>
		<!-- //popup_box -->
	</div>
	<!-- //당첨 레이어 -->
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

function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2020%2Fchristmas_2020_evt.jsp";
	if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
		goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2020/christmas_2020_evt.jsp?freetoken=event";
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
			var evtUrl = "/mobilefirst/evt/ajax/christmas2020_setlist.jsp";
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
		
		var findGiftBox = {
				el : {
					wrap : $(".game_wrap"),
					main : $(".game_main"),
					gift : $(".gift_box"),
					btn : $(".game_wrap .btn_gift"),
					layer : $(".game_wrap .layer_area")
				},
				init : function(){
					this.addEvent();
				},
				addEvent : function(){
					// 선물박스 클릭
					var _self = this;
					this.el.btn.click(function(){
						_self.selectbox(this);
						// 당첨결과 보기
						getEventAjaxData( {"procCode":1} , function(data) {
							ga_log(6);
							result = data.result;
							if(result >= 100){
								// 당첨결과 보기 
								rewards(result);
							}else if(result == -1){
								alert("이미 참여하셨습니다.");
								working = false;
							}else if(result == -2 || result == -99){
								alert("임직원은 참여 불가합니다.");
								working = false;
							}else if(result == -55){
								alert("잘못된 접근입니다.");
							}else if(result == -1225){
								alert("이미 참여 하셨습니다.");
							}else{
								working = false;
							}
						});
					})
				},
				selectbox : function(ta){
					var _self = this;
					this.el.btn.not(ta).fadeOut(500);
				},
				clear: function(){	// 오브젝트 치우기
					this.el.btn.fadeOut(100);
				},
				reset : function(){ // 오브젝트 재배치
					this.el.btn.fadeIn(300);
					this.el.gift.removeClass("init");
				}
			}
			// 실행
			findGiftBox.init();

			// 당첨 결과 처리
			function rewards(result){
				// 1 - 낙첨 - 100점 적립
				// 2 - 당첨 - GS25상품권 당첨(1,000점 적립)
				// 3 - 당첨 - GS25상품권 당첨(5,000점 적립)
				// 4 - 당첨 - 빅맥버거세트 당첨(5,900점 적립)
				// 5 - 당첨 - 에어팟프로 당첨
				
				// 비우기 
				findGiftBox.clear();

				// 선물 받기
				var $gift = findGiftBox.el.gift;
				// 결과 레이어 노출
				
				if(result > 0){
					$gift.addClass("init");
					// 팝업 띄우기
					setTimeout(function(){
						// 팝업 띄우기
						onoff('prizes');
						$("#prizes").find(".vote_img > div").hide();
						$("#prizes").find(".result_0" + result).show();

/* 						setTimeout(function(){
							// 게임 초기화
							findGiftBox.reset();
						}, 1000); */
					},1000);
				}
				$.ajax({
					type: "GET",
					url: "/mobilefirst/evt/ajax/christmas2020_setlist.jsp",
					data:{
						"emoney" : numberWithCommas(result),
						"procCode" : 3,
						"sdt" : sdt
					},
					dataType: "JSON",
					success: function(json){
					}
				});
    		}      
	});
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
welcomeGa("evt_christmas2020_view"); 
},500);
function goPlan(){
	da_ga(4);
	location.href = "/mobilefirst/event2020/christmas_2020.jsp";
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
