<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
String chkId = ChkNull.chkStr(request.getParameter("chk_id"));

if(true){

response.sendRedirect("/mobilefirst/evt/firstbuy100_event.jsp?chk_id="+chkId); //pc url
return;

}

 if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
	 
	 
}else{
    response.sendRedirect("http://www.enuri.com/event2019/firstbuy.jsp"); //pc url
    return;
}
long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String sdt = dayTime.format(new Date(cTime));//진짜시간

if( request.getServerName().indexOf("m.enuri.com") > -1 && request.getParameter("sdt")!=null && !request.getParameter("sdt").equals("") ) {
	sdt = request.getParameter("sdt");
}

String[] customDate = new String[2];

try{
	int year  = Integer.parseInt(sdt.substring(0, 4));
	int month = Integer.parseInt(sdt.substring(4, 6));

	Calendar cale = Calendar.getInstance();
    SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy년 M월 d일");
    //현재날짜의 세달전 날짜의 1일자
    cale.set(year, month - 1, 1);
    cale.add(Calendar.MONTH, -3);
    customDate[0] = dateFormatter.format(cale.getTime());

    //구한 날짜의 하루전 날짜 (말일자)
    cale.add(Calendar.DATE, -1);
    customDate[1] = dateFormatter.format(cale.getTime());

}catch(Exception e){
	System.out.println("컴백혜택 유의사항 문구 자동화변경 오류: "+ e.getMessage());
	customDate[0] = "2017년 12월 1일";
	customDate[1] = "2017년 6월 30일";
}

int numSdt = Integer.parseInt(sdt);

boolean isNext = false;
String cssFile = "/css/event/y2019/buy_mar_m.css";
String bgImg = ConfigManager.IMAGE_ENURI_COM+"/images/event/2018/buy/dec/m_visual.jpg";

if(numSdt >= 20190401){
	isNext = true;
	cssFile = "/css/event/y2019/buy_mar_m.css";
	bgImg = ConfigManager.IMAGE_ENURI_COM+"/images/event/2018/buy/dec/m_visual.jpg";
}

String startDate = "20190401";
String endDate="20190501";

String cUserId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");
//String chkId = ChkNull.chkStr(request.getParameter("chk_id"));
String strUrl = request.getRequestURI();
String tab = ChkNull.chkStr(request.getParameter("tab"));
String flow = ChkNull.chkStr(request.getParameter("flow"));

String inflowType = ChkNull.chkStr(request.getParameter("inflow"));
boolean isPush=false;
//유입경로가 푸쉬메시지인 경우
if(inflowType.equals("pmsg")){
    isPush=true;
}
String strGno     = ChkNull.chkStr(cb.GetCookie("GATEP","GNO"),"");
String strGkind     = ChkNull.chkStr(cb.GetCookie("GATEP","GKIND"),"");

Members_Proc members_proc = new Members_Proc();
String cUsername = "";
String userArea = "";

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;

    if(cUsername.equals(""))      userArea = cUserNick;
    if(userArea.equals(""))        userArea = cUserId;
    
    /*
    String snsType = ChkNull.chkStr(cb.GetCookie("MEM_INFO","SNSTYPE"));
	if( "K".equals(snsType) ||  "N".equals(snsType) ){//sns 계정일 경우 닉네임을 넣어준다
		userArea = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK")); //로그인 닉네임
	}
	*/
}
//앱인 경우 버젼체크 구간
Cookie[] carr = request.getCookies();
String strAppyn = "";
String strVerios = ChkNull.chkStr(request.getParameter("verios"));
String strVerand = ChkNull.chkStr(request.getParameter("verand"));
String appType="";
int intVerios = 0;
int intVerand = 0;

try {
  for(int i=0;i<carr.length;i++){
      if(carr[i].getName().equals("appYN")){
        strAppyn = carr[i].getValue();
        break;
      }
  }
  if(strVerios.equals("")){
    for(int i=0;i<carr.length;i++){

        if(carr[i].getName().equals("verios")){
          strVerios = carr[i].getValue();
          break;
        }
    }
  }
  if(strVerand.equals("")){
    for(int i=0;i<carr.length;i++){
        if(carr[i].getName().equals("verand")){
          strVerand = carr[i].getValue();
          break;
        }
    }
  }
} catch(Exception e) {}

if(strAppyn.equals("Y")){
     if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0){
         appType="AOS";
     }else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0
       ||ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0){
            appType="IOS";
     }	
}
if(strVerios.length() > 0){
  intVerios = Integer.parseInt(strVerios.replace(".",""));
}
if(strVerand.length() > 0){
  intVerand = Integer.parseInt(strVerand.replace(".",""));
}
boolean isVersion=false;//버젼이 3.1.3 이상 : TRUE  미만:FALSE
if(strAppyn.equals("Y")){
    if(appType.equals("AOS")){
        if(intVerand >= 313){
            isVersion = true;
        }
    }else if(appType.equals("IOS")){
        if(intVerios >= 31300){
            isVersion = true;
        }
    }
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<title>에누리(가격비교) eNuri.com</title>
<meta property="og:title" content="에누리 가격비교">
<meta property="og:description" content="에누리 모바일 가격비교">
<meta property="og:image" content="<%= ConfigManager.IMG_ENURI_COM%>/images/mobilenew/images/logo_enuri.png">
<meta name="format-detection" content="telephone=no" />
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=cssFile %>"/>
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/event_regular.js?v=20180201"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js?v=202020"></script>
</head>
<body>
<script type="text/javascript">
function adClickGa(){
	if("<%=flow%>" == "sfb")			ga('send', 'event', 'mf_event', 'click','페이스북_유입클릭');	
	else if("<%=flow%>" == "sap")		ga('send', 'event', 'mf_event', 'click','앱설치_유입클릭');
	else if("<%=flow%>" == "sad")		ga('send', 'event', 'mf_event', 'click','검색광고_유입클릭');
}
</script>
<!-- layer-->
<div class="layer_back fixed" id="app_only" style="display:none;">
    <div class="dimm" onclick="onoff('app_only');"></div>
    <div class="appLayer">
        <h4>모바일 앱 전용 이벤트</h4>
        <a href="javascript:///" class="close" onclick="onoff('app_only');">창닫기</a>
        <p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
        <p class="btn_close"><button type="button"  onclick="install_btt();">설치하기</button></p>
    </div>
</div>
<div id="eventWrap">
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>
	
	<!-- 상단비주얼 -->
	<div class="evtop01">
		<!-- tab_area -->
		<div class="toparea">	
			<!-- 상단비주얼 -->
			<div class="visual" style="margin-bottom: 0px;">
				<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
				
				<div class="contents">
					<h1 class="blind">따뜻한 봄에 처음 만나는 혜택</h1>
					<p class="blind">첫구매 고객에게만 드리는 특별한 선물</p>
				</div>
			</div>
		
			<div class="section floattab">
				<div class="contents">
					<div class="inner">
						<ul class="floattab__list">
							<li class="tab1"><a href="javascript:///" class="floattab__item floattab__item--01">출석</a></li>
							<li class="tab2"><a href="javascript:///" class="floattab__item floattab__item--02 is-on">첫구매</a></li>
							<li class="tab3"><a href="javascript:///" class="floattab__item floattab__item--03">누구나!구매혜택</a></li>
							<li class="tab4"><a href="javascript:///" class="floattab__item floattab__item--04">생일&amp;컴백</a></li>
							<li class="tab5"><a href="javascript:///" class="floattab__item floattab__item--05">더블적립</a></li>
						</ul>
					</div>
				</div>
			</div>		
		</div>
		<!-- //tab_area -->
		<div class="contents">
		<%if(isNext) { %>
			<%@ include file="/mobilefirst/event2019/firstbuy_main201903.jsp"%>	<!-- 첫구매 -->
		<%} else { %>
			<%@ include file="/mobilefirst/event2019/firstbuy_main201903.jsp"%>	<!-- 첫구매 -->
		<%} %>
		</div>
	</div>
    <span class="go_top"><a>TOP</a></span>
    <%@ include file="/mobilefirst/evt/emoney_guide.jsp"%><!-- 생활혜택 -->
    <%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
</div>
<script type="text/javascript">
//공통영역//
var app = getCookie("appYN"); //app인지 여부
var gkind = '<%=strGkind%>'+'';
var gno = '<%=strGno%>'+'';
var vEvent_page = "<%=strUrl%>"; //돌아갈 이벤트페이지주소
var vEvent_title = "앱 2019 첫구매 프로모션";
var username = "<%=userArea%>";
var mType = "";// 안드로이드 / 아이폰
var isVersion = <%=isVersion%>;
var sdt = "<%=sdt%>";//오늘날짜
var vChkId = "<%=chkId %>";
(function(){
	
	if('<%=flow%>' == "sfb")				ga('send', 'pageview', {'page': vEvent_page,'title': '[모바일] 첫구매_페이스북_PV' });
	else if('<%=flow%>' == "sap")			ga('send', 'pageview', {'page': vEvent_page,'title': '[모바일] 첫구매_앱설치_PV' });
	else if('<%=flow%>' == "sad")			ga('send', 'pageview', {'page': vEvent_page,'title': '[모바일] 첫구매_검색광고_PV' });
	
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1)		mType = "I";
	else if(navigator.userAgent.indexOf("Android") > -1)		mType = "A";
	if(islogin())		getPoint();
	//닫기버튼
	 $( ".win_close" ).click(function(){
        if(app == 'Y')  window.location.href = "close://";
        else            window.location.replace("/mobilefirst/index.jsp");
	});

	$(".floattab__list > li").click(function(){
		var inx = $(this).index();
		
		if(inx == 0){//출석
			ga('send', 'event', 'mf_event', '첫구매page','출석텝');
			window.open("/mobilefirst/evt/visit_event.jsp?freetoken=event");
		}else if(inx == 1){//첫구매
			ga('send', 'event', 'mf_event', '첫구매page','첫구매');
			window.open("/mobilefirst/evt/firstbuy_event.jsp?freetoken=event");			
		}else if(inx == 2){
			ga('send', 'event', 'mf_event', '첫구매page','누구나구매혜택');
			window.open("/mobilefirst/evt/smart_benefits.jsp?freetoken=event");
		}else if(inx == 3){
			ga('send', 'event', 'mf_event', '첫구매page','생일&컴백');
			window.open("/mobilefirst/evt/birthday_event.jsp?freetoken=event");
		}else if(inx == 4){
			ga('send', 'event', 'mf_event', '첫구매page','더블적립');
			window.open("/mobilefirst/evt/buy_event.jsp?freetoken=event");
		}
	});
	$(".go_top").click(function(){		$(window).scrollTop(0);	});
})();
window.onload = function(){
	var isPush = <%=isPush%>;
	if(isPush){
		ga('send', 'event', 'mf_event', '첫구매','push클릭');
	}
    var tab = "<%=tab%>";
    $(".inner_tabs li a:after").css("background","none");

    var offset = "";
    if(tab == "1"){
        vEvent_title = "앱 첫구매 프로모션";
        offset = $("#tab1").offset();
    }else if(tab == "2"){
        vEvent_title="재구매";
        offset = $("#tab2").offset();
    }

    if(!!offset){
        var $anchor = offset.top - 71;
        $('html, body').stop().animate({scrollTop: $anchor}, 500);
    }
	//ga
	/*
	if(app =='Y' ){
		if(mType=="I"){
			ga('send', 'pageview', {'page': vEvent_page,'title': '[모바일] '+vEvent_title+' PV(IOS)'});
		}else if(mType=="A"){
			ga('send', 'pageview', {'page': vEvent_page,'title': '[모바일] '+vEvent_title+' PV(AOS)'});
		}
	}else{
    	ga('send', 'pageview', {'page': vEvent_page,'title': vEvent_title+'_WEB'});
	}
	*/
	var nowPageChk = document.URL;
	if(nowPageChk.indexOf("tab=1") > -1)			ga('send', 'pageview', {'page': vEvent_page,'title': '[모바일] 첫구매_PV' });
	else if(nowPageChk.indexOf("tab=2") > -1 )		ga('send', 'pageview', {'page': vEvent_page,'title': '[모바일] 재구매_PV' });
	else											ga('send', 'pageview', {'page': vEvent_page,'title': '[모바일] 첫구매_PV' });

	//상단 탭 이동
	$(document).on('click', '.tabmenu > li > a', function(e) {
		if($(this).hasClass("movetab")){
			var $anchor = $($(this).attr('href')).offset().top - 71;

			$('html, body').stop().animate({scrollTop: $anchor}, 500);
			e.preventDefault();
		}
	});
	// 유의사항 드롭다운
	$('.btn_check').click(function(){
		var _this = $(this);
		_this.siblings(".moreview").toggle();

		$(".btn_check_hide").click(function(){
			$(this).parents(".moreview").slideUp();
			$('html,body').stop().animate({scrollTop:_this.offset().top - 71});
			return false;
		})
	});
    //더 많은 개이득
    $("#moreBanner > li").click(function(e){
        var idx = $(this).index();
        ga('send','event', 'mf_event','구매 프로모션', idx == 0 ? '더블적립 배너' : '무제한적립 배너');

    	window.open( "/mobilefirst/evt/buy_event.jsp?tab=" + (idx + 1) );
    });
};
//앱설치버튼
function install_btt(){
	
	ga('send','event', 'mf_event','click','첫구매이벤트_설치하기');
	
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8';
    }else if(navigator.userAgent.indexOf("Android") > -1){
    	if(gkind == "42"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','SA 42 M_Naver');
    		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=8820367';
    	}else if(gkind == "43"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','SA 43 M_Daum');
    		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=9238355';
    	}else if(gkind == "44"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','SA 44 M_google');
    		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=2709994';
    	}else if(gkind=="72"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','DA 72 M_icover');
    		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=9999961&sub_referral=5642519';
    	}
    	else if(gkind=="75" && gno == "3120469"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','버즈빌_첫구매CU');
    		window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=1917629&sub_referral=8147655";
		}else if(gkind=="74" && gno == "3120470"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','페이스북_첫구매CU');
			window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=4120949&sub_referral=2082626";
		}
    	else if(gkind=="71" && gno =="3100367"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','망고_첫구매CU');
    		window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=9999961&sub_referral=1319566";
    	}
    	else if(gkind=="76" && gno =="3139542"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','애드립_첫구매CU');
    		window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=3535287&sub_referral=3457934";
    	}
    	else if(gkind=="82" && gno =="4299545"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','쉘위애드_첫구매');
    		window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6497571&sub_referral=4519572";
    	}
    	else{
    		window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
    	}
    }
}

(function (global, $) {
	// 상단 메뉴 스크롤 시, 고정
	var $nav = $('.floattab'),
		$menu = $('.floattab__list li'),
		$contents = $('.scroll'),
		$navheight = $nav.outerHeight(), // 상단 메뉴 높이
		$navtop = Math.ceil($nav.offset().top); // floattab 현재 위치; 

	// menu class 추가 
	$(window).scroll(function () {
		var $scltop = Math.ceil($(window).scrollTop());	// 현재 scroll

		if ($scltop > $navtop) {
			$nav.addClass("is-fixed");
			$(".visual").css("margin-bottom", $navheight);
			$(".myarea").addClass("f-nav");
		} else {
			$nav.removeClass("is-fixed");
			$(".visual").css("margin-bottom", 0);
			$(".myarea").removeClass("f-nav");
		}
	});
}(window, window.jQuery));

function welcomeGa(strEvent){
	if(app == "Y"){
		try{
	        if(window.android){            // 안드로이드                  
                 window.android.igaworksEventForApp (strEvent);
	        }else if(/iPhone|iPad|iPod/i.test(navigator.userAgent)){
        		// 아이폰에서 호출
                 location.href = "enuriappcall://igaworksEventForApp?strEvent="+strEvent;
	        }
		}catch(e){}
	}
}
setTimeout(function(){
	welcomeGa("evt_100won_view");    
},500);
</script>
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</body>
</html>