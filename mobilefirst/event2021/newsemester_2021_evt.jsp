<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
String strServerNm = request.getServerName();
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
	if(strServerNm.indexOf("dev.enuri.com") > -1){
		response.sendRedirect("http://dev.enuri.com/event2021/newsemester_2021_evt.jsp"); //PC경로		
	}else{
		response.sendRedirect("http://www.enuri.com/event2021/newsemester_2021_evt.jsp"); //PC경로
	}
	return;
}

	String chkId = ChkNull.chkStr(request.getParameter("chk_id"), "");
	String cUserId = ChkNull.chkStr(cb.GetCookie("MEM_INFO", "USER_ID"), "");
	String cUserNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO", "USER_NICK"), "");

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

	if (!"".equals(sdt) || request.getServerName().equals("dev.enuri.com")) {
		strToday = sdt;
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<meta property="og:title" content="2021 새학기 통합기획전 – 최저가 쇼핑은 에누리">
<meta property="og:description" content="온 가족 타임특가! 매주 수요일마다 터지는 득템의 기회!">
<meta property="og:image" content="http://img.enuri.info/images/event/2021/new_semester/sns_1200_630.jpg"">
<meta name="format-detection" content="telephone=no" />
<title>에누리 가격비교 - 최저가 쇼핑은 에누리 가격비교 사이트</title>
<!-- 프로모션 공통 CSS (Mobile) -->
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css"
	type="text/css">
<!-- 프로모션별 커스텀 CSS  -->
<link rel="stylesheet" href="/css/event/y2021/newsemester_m.css" type="text/css">
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
	<%@include file="/mobilefirst/event2021/newsemester_header.jsp" %>
	<!-- //비쥬얼,플로팅탭 -->
	<!-- 이벤트01 -->
	<div class="section event_game" id="evt1">
		<div class="contents">
			<span class="m_bell"><!--종--></span>
			<h3><img src="//img.enuri.info/images/event/2021/new_semester/m_sec1_tit.jpg" alt="누구나 선물 받기 응모하면 꽝 없는 푸짐한 선물 당첨! 100% 당첨! 추억의 뽑기"></h3>
			<div class="game_wrap">
				<div class="game_main" style="display: block;">
					<ul class="draw">
						<li class="draw_item draw_01">
							<button class="btn_draw">뽑기</button>
							<div class="obj_paper"></div>
						</li>
						<li class="draw_item draw_02">
							<button class="btn_draw">뽑기</button>
							<div class="obj_paper"></div>
						</li>
						<li class="draw_item draw_03">
							<button class="btn_draw">뽑기</button>
							<div class="obj_paper"></div>
						</li>
						<li class="draw_item draw_04">
							<button class="btn_draw">뽑기</button>
							<div class="obj_paper"></div>
						</li>
						<li class="draw_item draw_05">
							<button class="btn_draw">뽑기</button>
							<div class="obj_paper"></div>
						</li>
						<li class="draw_item draw_06">
							<button class="btn_draw">뽑기</button>
							<div class="obj_paper"></div>
						</li>
					</ul>
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
											<li>- 도서문화상품권 1만원권 (e머니 10,000점) – 5명 당첨</li>
											<li>- 베스킨라빈스 싱글킹 2개 세트  (e머니 8,000점) – 5명 당첨</li>
											<li>- 이디야 우리 함께해 세트 (e머니 5,000점) – 10명 당첨</li>
											<li>- GS25 모바일금액권 3,000원권 (e머니 3,000점) – 10명 당첨</li>
											<li>- 타코벨 클래식 타코 (e머니 2,500점) – 10명</li>
											<li>- 세븐일레븐 오로나민C 120ml (e머니 1,000점) – 10명</li>
											<li>- 맥도날드 애플파이 (e머니 1,000점) – 10명</li>
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
                <li class="ben_item--01"><a href="http://m.enuri.com/mobilefirst/evt/firstbuy100_event.jsp" target="_blank">첫구매 고객이라면! Welcome 혜택</a></li>
                <li class="ben_item--02"><a href="http://m.enuri.com/mobilefirst/evt/visit_event.jsp" target="_blank">하루라도 농치면 손해 매일100% 당첨</a></li>
                <li class="ben_item--03"><a href="http://m.enuri.com/mobilefirst/evt/smart_benefits.jsp?#tab4" target="_blank">받고 또 받는 카테고리 혜택 최대적립 3만점</a></li>
                <li class="ben_item--04"><a href="http://m.enuri.com/m/index.jsp#evt" target="_blank">아직 끝나지 않은 혜택 더 많은 이벤트</a></li>
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
						<img src="//img.enuri.info/images/event/2021/new_semester/m_result_img_03.jpg" alt="축하합니다! e머니 100점 적립 ">
					</div>
					<!-- 당첨 - 도서문화 상품권 당첨(10,000점 적립) 이미지 -->
					<div class="result_010000" style="display:none">
						<img src="//img.enuri.info/images/event/2021/new_semester/m_result_img_04.jpg" alt="축하합니다! 도서문화상품권에 당첨됐어요!(10,000점 적립)">
					</div>
					<!-- 당첨 - 베스킨라빈스 싱글킹 2개 세트 당첨 (8,000점 적립) 이미지 -->
					<div class="result_08000" style="display:none">
						<img src="//img.enuri.info/images/event/2021/new_semester/m_result_img_01.jpg" alt="축하합니다! 베스킨라빈스 싱글킹 2개 세트에 당첨됐어요!(8,000점 적립)">
					</div>
					<!-- 당첨 - 이디야 커피 세트 당첨(5,000점 적립) 이미지 -->
					<div class="result_05000" style="display:none">
						<img src="//img.enuri.info/images/event/2021/new_semester/m_result_img_02.jpg" alt="축하합니다! 이디야 커피세트에 당첨됐어요!(5,000점 적립)">
					</div>
					<!-- 당첨 - GS25 모바일 금액권 당첨(3,000점 적립) 이미지 -->
					<div class="result_03000" style="display:none">
						<img src="//img.enuri.info/images/event/2021/new_semester/m_result_img_07.jpg" alt="축하합니다! GS25 모바일 금액권에 당첨됐어요! (3,000점 적립)">
					</div>
					<!-- 당첨 - 타코벨 클래식타코 당첨(2,500점 적립) 이미지 -->
					<div class="result_02500" style="display:none">
						<img src="//img.enuri.info/images/event/2021/new_semester/m_result_img_05.jpg" alt="축하합니다! 타코벨 클래식타코에 당첨됐어요! (2,500점 적립)">
					</div>
					<!-- 당첨 - 오로나민C 당첨(1,000점 적립) 이미지 -->
					<div class="result_01000" style="display:none">
						<img src="//img.enuri.info/images/event/2021/new_semester/m_result_img_06.jpg" alt="축하합니다! 오로나민C에 당첨됐어요! (1,000점 적립)">
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
var vServerNm = '<%=strServerNm%>';

function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var url = "";
	/*
	if(vServerNm.indexOf("dev.enuri.com") > -1){
		url = "http://dev.enuri.com/mobilefirst/event2021/newsemester_2021_evt.jsp?freetoken=event";
	}else {
		url = "http://m.enuri.com/mobilefirst/event2021/newsemester_2021_evt.jsp?freetoken=event";
	}
	*/
	url = encodeURIComponent("http://"+location.host+"/mobilefirst/event2021/newsemester_2021_evt.jsp?freetoken=event");
	var goApp = "enuri://freetoken/?url="+url;
	if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
		goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl="+url;
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
    if(tab == '01'){
		$('html, body').stop().animate({scrollTop: Math.ceil($('#evt1').offset().top- $(".navtab").outerHeight())}, 0);
	}
	
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
			var evtUrl = "/mobilefirst/evt/ajax/newsemester2021_setlist.jsp";
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
		// 추억의 뽑기
		var findGift = {
			el : {
				wrap : $(".game_wrap"),
				main : $(".game_main"),
				item : $(".draw_item"),
				btn : $(".game_wrap .btn_draw"),
				layer : $(".game_wrap .layer_area")
			},
			init : function(){
				this.addEvent();
			},
			addEvent : function(){
				// 선물박스 클릭
				var _self = this;
				this.el.btn.click(function(){
					var _btn = this;
					
					// 당첨결과 보기
					//rewards( parseInt( prompt('퍼블테스트용 입니다.\n1 : 낙첨 - 100점 적립\n2 : 당첨 - 도서문화상품권 (10,000점 적립)\n3 : 당첨 - 베스킨라빈스 싱글킹 2개(8,000점 적립)\n4 : 당첨 - 이디야 커피세트(5,000점 적립)\n5 : 당첨 - GS25 3천원권 (3,000점 적립)\n6: 당첨 - 타코벨 클래식타코 (2,500점 적립)\n7: 당첨 - 오로나민C (1,000점 적립)'),10) );
 					getEventAjaxData( {"procCode":1} , function(data) {
						ga_log(6);
						result = data.result;
						if(result >= 100){
							// 당첨결과 보기
							_self.selectbox(_btn);
							rewards(result);
						}else if(result == -1 || result == -10){
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
				var $ta = $(ta).parent();
				this.el.btn.not(ta).fadeOut(500);
				$ta.addClass("ing");
				setTimeout(function(){
					$ta.addClass("ing1");
					setTimeout(function(){
						$ta.addClass("ing2");
					},1000)
				},1000)
			},
			clear: function(){	// 오브젝트 치우기
				// this.el.btn.fadeOut(500);
			},
			reset : function(){ // 오브젝트 재배치
				var _self = this;
				this.el.btn.fadeIn(300);
				this.el.item.hide();
				this.el.item.removeClass("ing ing1 ing2");
				setTimeout(function(){
					_self.el.item.show();
				},1000)
			}
		}
		// 실행
		findGift.init();

		// 당첨 결과 처리
		function rewards(result){
			// 1 - 당첨 - 100점 적립
			// 2 - 당첨 - 도서문화상품권 (10,000점 적립)
			// 3 - 당첨 - 베스킨라빈스 싱글킹 2개(8,000점 적립)
			// 4 - 당첨 - 이디야 커피세트(5,000점 적립)
			// 5 - 당첨 - GS25 3천원권 (3,000점 적립)
			// 6 - 당첨 - 타코벨 클래식타코 (2,500점 적립)
			// 7 - 당첨 - 오로나민C (1,000점 적립)
			
			// 비우기 
			// findGift.clear();

			// 결과 레이어 노출
			if(result >= 100){
				// 팝업 띄우기
				setTimeout(function(){
					// 팝업 띄우기
					onoff('prizes');
					$("#prizes").find(".vote_img > div").hide();
					$("#prizes").find(".result_0" + result).show();

					setTimeout(function(){
						// 게임 초기화
						findGift.reset();
					}, 100);
				},2000);
			}/* else{
				// 팝업 띄우기
				setTimeout(function(){
					// 팝업 띄우기
					onoff('prizes');
					$("#prizes").find(".vote_img > div").hide();
					$("#prizes").find(".result_01").show();

					setTimeout(function(){
						// 게임 초기화
						findGift.reset();
					}, 100);
				},2000);
			} */
			$.ajax({
				type: "GET",
				url: "/mobilefirst/evt/ajax/newsemester2021_setlist.jsp",
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
/* setTimeout(function(){
welcomeGa("evt_christmas2020_view"); 
},500); */
function goPlan(){
	da_ga(4);
	location.href = "/mobilefirst/event2020/christmas_2020.jsp"; //수정
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
