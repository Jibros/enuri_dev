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
		response.sendRedirect("http://dev.enuri.com/event2021/family_2021_evt.jsp"); //PC경로		
	}else{
		response.sendRedirect("http://www.enuri.com/event2021/family_2021_evt.jsp"); //PC경로
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

	SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");	//오늘 날짜
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
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<!-- 프로모션별 커스텀 CSS  -->
<link rel="stylesheet" href="/css/event/y2021_rev/familymonth_m.css" type="text/css">
<link rel="stylesheet" type="text/css"	href="/mobilefirst/css/lib/slick.css" />
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
<script type="text/javascript" src="/event2016/js/event_common.js"></script>
<script type="text/javascript" src="/mobilefirst/js/ladder_familymonth_m.js"></script>
</head>
<body>
<div id="eventWrap">
	<%@include file="/mobilefirst/event2021/family_header.jsp" %>
	<!-- //비쥬얼,플로팅탭 -->
	<!-- T1 이벤트 : 게임 -->
	<div class="section event_game" id="evt1">
		<div class="contents">
			<h1 class="evt1_tit">꽃피는 오월 행운의 사다리타기</h1>
			<div class="evt1_gift"><!--경품이미지--></div>

			<div class="game_wrap">
				<!-- 사다리타기 JS  -->
				<!-- 사다리 타기 -->
				<div id="ladder" class="ladder">
					<div class="dimmed">
						<p class="blind">5월에 선물하기 좋은 꽃을 골라주세요 푸짐한 상품 100% 당첨 !</p>
					</div>
					<!--상단 라운드보더-->
					<div class="round__border"><span class="rndb-1"></span><span class="rndb-2"></span><span class="rndb-3"></span><span class="rndb-4"></span></div>

					<canvas class="ladder_canvas" id="ladder_canvas"></canvas>
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
							<dd>
								<ul>
									<li>이벤트 참여 : ID당 1회 참여 가능</li>
									<li>경품 : <br>
										<ul class="sub">
											<li>- 삼성전자 갤럭시 핏2 (실물경품) – 5명 당첨</li>
											<li>- 디티플렉스 마사지건 DT-EST120 (실물경품) – 10명 당첨<br><span class="noti">(실물경품의 경우 이벤트 기간 이후 일괄배송 될 예정입니다.)</span></li>
											<li>- 맥도날드 치즈버거 세트 (e머니 4,000점) – 10명 당첨</li>
											<li>- 이디야 ICED 초콜릿 (e머니 3,700점) – 10명 당첨</li>
											<li>- 베스킨라빈스 싱글레귤러 아이스크림 (e머니 3,200점) – 10명 당첨</li>
											<li>- 크리스피크림도넛 오리지널 글레이즈드 (e머니 1,300점) – 50명 당첨</li>
											<li>- 에누리 e머니 100점  - 10,000명 당첨</li>
										</ul>
									</li>
									<li>e머니 유효기간 : 적립일로부터 15일</li>
									<li>이벤트 참여 시 개인정보 수집에 동의하신 것으로 간주됩니다.</li>
									<li>이벤트의 원활한 진행을 위해 당첨자의 참여일시, 참여자ID, 본인인증확인(CI, DI)가 수집되며 수집된 개인정보는 이벤트 참여확인을 위한 본인확인 이외의 목적으로 활용되지 않습니다.</li>
									<li>개인정보 수집자(에누리 가격비교)는 이벤트 기간 동안 개인정보를 수집하며, 이벤트 당첨자 발표 후 개인정보를 즉시 파기합니다.</li>
									<li>잘못된 정보 입력이나, 3회 이상 통화 시도에도 연락이 되지 않을 경우의 경품수령 불이익은 책임지지 않습니다.</li>
									<li>적립된 e머니는 e머니 스토어에서 다양한 e쿠폰상품으로 교환 가능합니다. </li>
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
	<!-- // T1 이벤트 게임 -->
	
	<!-- 공통 : 하단 에누리 혜택 -->
	<div class="otherbene">
        <div class="inner">
            <h3 class="blind">놓칠 수  없는 특별한 혜택, 에누리 혜택</h3>
            <ul class="ben_list">
                <li class="ben_item--01"><a href="http://m.enuri.com/event2020/welcome_evt.jsp" target="_blank">첫구매 고객이라면! Welcome 혜택</a></li>
                <li class="ben_item--02"><a href="http://www.enuri.com/evt/visit.jsp" target="_blank">100% 당첨! 매일받는 e머니 도전! 프로출첵러</a></li>
                <li class="ben_item--03"><a href="http://m.enuri.com/mobilefirst/evt/smart_benefits.jsp?#tab4" target="_blank">받고 또 받는 카테고리 혜택</a></li>
                <li class="ben_item--04"><a href="http://www.enuri.com/eventPlanZone/jsp/shoppingBenefit.jsp" target="_blank">아직 끝나지 않은 혜택 더 많은 이벤트</a></li>
            </ul>
        </div>
	</div>
	<!-- // -->	
	
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
					<div class="result_00" style="display:none">
						<img src="http://img.enuri.info/images/event/2021/familymonth/m_result_img_01.png" alt="축하합니다! 스마트밴드에 당첨됐어요! - 삼성 갤럭시 핏2(실물배송)">
					</div>
					<div class="result_01" style="display:none">
						<img src="http://img.enuri.info/images/event/2021/familymonth/m_result_img_02.png" alt="축하합니다! 마사지 건에 당첨됐어요! - 디티 플렉스 마사지건(실물배송)">
					</div>
					<div class="result_04000" style="display:none">
						<img src="http://img.enuri.info/images/event/2021/familymonth/m_result_img_03.png" alt="축하합니다! 치즈버거세트에 당첨됐어요! - 맥도날드 치즈버거 세트(e머니 4000점)">
					</div>
					<div class="result_03700" style="display:none">
						<img src="http://img.enuri.info/images/event/2021/familymonth/m_result_img_04.png" alt="축하합니다! 아이스초코에 당첨됐어요! - 이디야 ICED 초콜릿(e머니 3700점)">
					</div>
					<div class="result_03200" style="display:none">
						<img src="http://img.enuri.info/images/event/2021/familymonth/m_result_img_05.png" alt="축하합니다! 아이스크림에 당첨됐어요! - 베스킨라빈스 싱글레귤러 (e머니 3200점)">
					</div>
					<div class="result_01300" style="display:none">
						<img src="http://img.enuri.info/images/event/2021/familymonth/m_result_img_06.png" alt="축하합니다! 글레이즈드 도넛에 당첨됐어요! - 크리스피크림도넛 오리지널 (e머니 1300점)">
					</div>
					<div class="result_0100" style="display:none">
						<img src="http://img.enuri.info/images/event/2021/familymonth/m_result_img_07.png" alt="축하합니다! 에누리 E머니에 당첨됐어요! (e머니 100점)">
					</div>
				</div>
			</div>
			<a href="javascript:void(0);" class="btn layclose" onclick="onoff('prizes');return false"><em>팝업 닫기</em></a>
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
	url = encodeURIComponent("http://"+location.host+"/mobilefirst/event2021/family_2021_evt.jsp?freetoken=event");
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
	
	//#애드브릭스
	setTimeout(function(){
		welcomeGa("evt_family2021_view");
	},500);
});

var isClick = true;

var sdt = "<%=strToday%>";
var numSdt = parseInt(sdt);
function getEventAjaxData(params, callback){
	
	if(numSdt < 20210412){
		alert('오픈예정입니다.');
		return false;
	}
	if(numSdt > 20210509){ //마지막 날짜
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
			var evtUrl = "/mobilefirst/evt/ajax/family2021_setlist.jsp";
			if(typeof params === "object") {
				params.sdt = sdt;
				params.osType = "M";
			}
		    if(!isClick){
		    	return false;
		    }
		    isClick = false;
		    //$.ajaxSetup({ async:false });
			 $.post(evtUrl,params,callback,"json").done(function(){
					isClick = true;
			});
		}
	}
}


function rewards(result){
	$.ajax({
		type: "GET",
		url: "/mobilefirst/evt/ajax/family2021_setlist.jsp",
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
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>