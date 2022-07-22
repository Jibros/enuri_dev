<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
String strFb_title = "[에누리 가격비교] 생일&컴백 EVENT!";
String strFb_description = "[에누리 가격비교] 생일&컴백 EVENT! 생일에누리고~ 오랜만에누리고~ 이번달 생일이거나 오랜만에 오신 분들을 위해 특별한 혜택을 드립니다!"; 
String strFb_img = "http://img.enuri.info/images/mobilefirst/etc/birthsns2.jpg";

SimpleDateFormat prevFormat = new SimpleDateFormat("yyyyMMdd");
SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy년 M월 d일");
long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String sdt = dayTime.format(new Date(cTime));//진짜시간

 if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
    response.sendRedirect("http://www.enuri.com/event2019/buy_birth.jsp"); //pc url
    return;
}

if(  ( request.getServerName().indexOf("m.enuri.com") > -1  ||  request.getServerName().indexOf("dev.enuri.com") > -1  )  
		&& request.getParameter("sdt")!=null && !request.getParameter("sdt").equals("") ) {
	sdt = request.getParameter("sdt");
}
String queryString =request.getQueryString();
if(Integer.parseInt(sdt)>=202107){
	if(queryString !=null){
		response.sendRedirect("/m/event/buy_birth.jsp?"+request.getQueryString());
	}else{
		response.sendRedirect("/m/event/buy_birth.jsp");
	}
	return;
}
String[] customDate = new String[2];

try{
	int year  = Integer.parseInt(sdt.substring(0, 4));
	int month = Integer.parseInt(sdt.substring(4, 6));

	Calendar cale = Calendar.getInstance();
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
String cssFile = "/css/event/y2021/buybirth_apr_m.css";
//String bgImg = "http://imgenuri.enuri.gscdn.com/images/event/2018/buy/dec/m_visual.jpg";

String startDate = "20210401";
String endDate="20210502";

String dday="20210617";

if(numSdt >= 20210601){
	isNext = true;
	cssFile = "/css/event/y2021_rev/buybirth_may_m.css";

	startDate = "20210601";
	endDate="20210630";
	dday="20210819";
}else{
	isNext = true;
	cssFile = "/css/event/y2021_rev/buybirth_may_m.css";

	startDate = "20210503";
	endDate="20210531";
	dday="20210722";
}

String strApp = ChkNull.chkStr(request.getParameter("app"),"");

Cookie[] carr1 = request.getCookies();
try {
	for(int i=0;i<carr1.length;i++){
	    if(carr1[i].getName().equals("appYN")){
	    	strApp = carr1[i].getValue();
	    }
	}
} catch(Exception e) {
}

String cUserId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");
String chkId = ChkNull.chkStr(request.getParameter("chk_id"));
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

String oc = ChkNull.chkStr(request.getParameter("oc"));

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;

    if(cUsername.equals(""))      userArea = cUserNick;
    if(userArea.equals(""))        userArea = cUserId;

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
if(strVerios.length() > 0)  intVerios = Integer.parseInt(strVerios.replace(".",""));
if(strVerand.length() > 0)  intVerand = Integer.parseInt(strVerand.replace(".",""));

boolean isVersion=false;//버젼이 3.1.3 이상 : TRUE  미만:FALSE
if(strAppyn.equals("Y")){
    if(appType.equals("AOS")){
        if(intVerand >= 313)            isVersion = true;
    }else if(appType.equals("IOS")){
        if(intVerios >= 31300)            isVersion = true;
    }
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<title>에누리(가격비교) eNuri.com</title>
<meta property="og:title" content="<%=strFb_title%>">
<meta property="og:description" content="<%=strFb_description%>">
<meta property="og:image" content="<%=strFb_img%>">
<meta name="format-detection" content="telephone=no" />
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=cssFile %>"/>
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
<link rel="stylesheet" type="text/css" href="/css/swiper.css">
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/event_regular.js?v=20180201"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script> <!-- 200115 추가 -->
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js?v=202020"></script>
<script>
(function(a_,i_,r_,_b,_r,_i,_d,_g,_e){if(!a_[_b]){var d={queue:[]};_r.concat(_i).forEach(function(a){var i_=a.split("."),a_=i_.pop();i_.reduce(function(a,i_){return a[i_]=a[i_]||{}},d)[a_]=function(){d.queue.push([a,arguments])}});a_[_b]=d;a_=i_.getElementsByTagName(r_)[0];i_=i_.createElement(r_);i_.onerror=function(){d.queue.filter(function(a){return 0<=_i.indexOf(a[0])}).forEach(function(a){a=a[1];a=a[a.length-1];"function"===typeof a&&a("error occur when load airbridge")})};i_.async=1;i_.src="//static.airbridge.io/sdk/latest/airbridge.min.js";a_.parentNode.insertBefore(i_,a_)}})(window,document,"script","airbridge","init fetchResource setBanner setDownload setDownloads setDeeplinks sendSMS sendWeb setUserAgent setUserAlias addUserAlias setMobileAppData setUserId setUserEmail setUserPhone setUserAttributes clearUser setDeviceIFV setDeviceIFA setDeviceGAID events.send events.signIn events.signUp events.signOut events.purchased events.addedToCart events.productDetailsViewEvent events.homeViewEvent events.productListViewEvent events.searchResultViewEvent".split(" "),["events.wait"]);
airbridge.init({
    app: 'enuri',
    webToken: 'f430f10352c54cc9aa2203b98e67be9e'
});
</script>
</head>
<body>
<script type="text/javascript">
function adClickGa(){
	if("<%=flow%>" == "sfb")			ga('send', 'event', 'mf_event', 'click','페이스북_유입클릭');	
	else if("<%=flow%>" == "sap")		ga('send', 'event', 'mf_event', 'click','앱설치_유입클릭');
	else if("<%=flow%>" == "sad")		ga('send', 'event', 'mf_event', 'click','검색광고_유입클릭');
}
var shareUrl = "http://" + location.host + "/mobilefirst/evt/birthday_event.jsp";
Kakao.init('5cad223fb57213402d8f90de1aa27301');
</script>
<div id="lay_only_mw" class="lay_only_mw" style="display: none;">
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
<div class="com__share_wrap dim" style="z-index: 10000;display:none">
	<div class="com__layer share_layer">
		<div class="lay_head">공유하기</div>
		<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
		<div class="lay_inner">
			<ul id="eventShr">
				<li class="share_fb" id="fbShare" >페이스북 공유하기</li>
				<li class="share_kakao" id="kakao-link-btn">카카오톡 공유하기</li>				
				<li class="share_tw" id="twShare" >트위터 공유하기</li>
			</ul>
			<!-- 메인보내기 버튼클릭시 .mail_on 추가해 주세요 -->
			<div class="btn_wrap">
				<div class="btn_group">
					<!-- 주소복사하기 -->
					<div class="btn_item">
						<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/evt/birthday_event.jsp</span>
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
	<div class="evt_visual visual" style="margin-bottom: 0px;">
		<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
		<div class="inner">
			<span class="txt_01">생일&amp;컴백 혜택</span>
			<h2>선물에-누리다</h2>
			<span class="txt_02">이번 달 생일이세요? 오랜만에 오셨나요?</span>
			<span class="box_wrap"><!--케이크--></span>
			<span class="balloon balloon1"><!--풍선(좌)--></span>
			<span class="balloon balloon2"><!--풍선(중)--></span>
			<span class="balloon balloon3"><!--풍선(우)--></span>
		</div>
		<div class="obj_flow_01"> <!-- 앞쪽 flow object -->
			<div class="bg_flow flow_obj_01"></div>
			<div class="bg_flow flow_obj_02"></div>
		</div>
		<div class="obj_flow_02"> <!-- 뒤쪽 flow object -->
			<div class="bg_flow flow_obj_01"></div>
			<div class="bg_flow flow_obj_02"></div>
		</div>
		<div class="loader-box">
			<div class="visual-loader"></div>
		</div>
		<script>
			// 상단 타이들 등장 모션
			$(window).load(function(){
				var $visual = $(".evt_visual.visual");
				$visual.addClass("intro");
				setTimeout(function(){
					$visual.addClass("end");
				},4300)
			})	
		</script>
	</div>
	<div class="evt_content">
		<div class="section floattab">
			<div class="contents">
				<div class="inner">
					<ul class="floattab__list">
						<li class="tab1"><a href="#" class="floattab__item floattab__item--01">출석&amp;룰렛</a></li>
						<li class="tab2"><a href="#" class="floattab__item floattab__item--02">웰컴혜택</a></li>
						<li class="tab3"><a href="#" class="floattab__item floattab__item--03">구매혜택</a></li>
						<li class="tab4"><a href="#" class="floattab__item floattab__item--04 is-on">생일&amp;컴백</a></li>
						<li class="tab5"><a href="#" class="floattab__item floattab__item--05">VIP혜택</a></li>
					</ul>
				</div>
			</div>
		</div>
		<%if(numSdt>=20210601){ %>
			<%@ include file="/mobilefirst/event2021/buybirth_main202106.jsp"%>
		<%}else{ %>
			<%@ include file="/mobilefirst/event2021/buybirth_main202105.jsp"%>
		<%} %>
	</div>
	<%@ include file="/mobilefirst/event2019/best_goods_area.jsp"%>
    <%@ include file="/mobilefirst/evt/event_bottom.jsp"%><!-- 생활혜택 -->
    <%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
</div>

<script type="text/javascript">
//공통영역//
var app = getCookie("appYN"); //app인지 여부
var gkind = '<%=strGkind%>'+'';
var gno = '<%=strGno%>'+'';
var vEvent_page = "<%=strUrl%>"; //돌아갈 이벤트페이지주소
var vEvent_title = "앱 2021 생일 프로모션";
var username = "<%=userArea%>";
var mType = "";// 안드로이드 / 아이폰
var isVersion = <%=isVersion%>;
var sdt = "<%=sdt%>";//오늘날짜
var vChkId = "<%=chkId %>";
var oc = "<%=oc%>";

function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2evt%2Fbirthday_event.jsp";
	if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
		goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/evt/birthday_event.jsp";
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
			window.open(goApp);
		}
	}else{
		setTimeout( function() {
			window.open("https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8");
		}, 1000);
		location.href = goApp;
	}

}
$(document).ready(function(){
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
		mType = "I";
	}else if(navigator.userAgent.indexOf("Android") > -1){
		mType = "A";
	}
	if(oc!=""){
		$('.lay_only_mw').show();
	}
	$("#eventShr > li").click(function(){
		var sel = $(this).attr("id");
		var shareTitle = "[에누리 가격비교] 생일&컴백 EVENT! 생일에누리고~ 오랜만에누리고~ 이번달 생일이거나 오랜만에 오신 분들을 위해 특별한 혜택을 드립니다!";
		if(sel == "fbShare"){
			try{
				window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(shareTitle)+"&u="+shareUrl);
			}catch(e){
				window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(shareTitle)+"&u="+shareUrl);
			}
		}else if(sel == "twShare"){
			try {
				window.android
						.android_window_open("http://twitter.com/intent/tweet?text="
								+ encodeURIComponent(shareTitle)
								+ "&url=" + shareUrl);
			} catch (e) {
				window.open("http://twitter.com/intent/tweet?text="
						+ encodeURIComponent(shareTitle) + "&url="
						+ shareUrl);
			}
		}
	});

	$(".go_top").click(function(){		$(window).scrollTop(0);	});

	$(".floattab__list > li").click(function(){
		var inx = $(this).index();

		if(inx == 0){//출석
			ga('send', 'event', 'mf_event', 'birthday_page','출석텝');
			window.open("/mobilefirst/evt/visit_event.jsp?freetoken=event&chk_id="+vChkId);
		}else if(inx == 1){//첫구매
			ga('send', 'event', 'mf_event', 'birthday_page','첫구매텝');
			if(sdt < 20201005){
				window.open("/mobilefirst/evt/firstbuy100_event.jsp?freetoken=event&chk_id="+vChkId);
			}else{
				window.open("/mobilefirst/evt/welcome_event.jsp?freetoken=event&chk_id="+vChkId);
			}
		}else if(inx == 2){
			ga('send', 'event', 'mf_event', 'birthday_page','누구나구매혜택텝');
			window.open("/mobilefirst/evt/smart_benefits.jsp?freetoken=event&chk_id="+vChkId);
		}else if(inx == 3){
			ga('send', 'event', 'mf_event', 'birthday_page','생일&컴백텝');
			window.open("/mobilefirst/evt/birthday_event.jsp?freetoken=event&chk_id="+vChkId);
		}else if(inx == 4){
			ga('send', 'event', 'mf_event', 'birthday_page','더블적립텝');
			window.open("/mobilefirst/evt/buy_event.jsp?freetoken=event&chk_id="+vChkId);
		}
	});

	if(islogin()) getPoint(); //로그인상태인 경우 개인e머니 내역 노출
	//닫기버튼
	 $( ".win_close" ).click(function(){
        if(app == 'Y')  window.location.href = "close://";
		else			window.location.replace("/m/index.jsp");
	});

	 $(".keyword").hide();

});

window.onload = function(){
	var isPush = <%=isPush%>;
	if(isPush)		ga('send', 'event', 'mf_event', '컴백혜택','push클릭');

    var tab = "<%=tab%>";
    $(".inner_tabs li a:after").css("background","none");

    var offset = "";
    if(tab == "1"){
        vEvent_title = "생일혜택";
        offset = $("#evt1").offset();
    }else if(tab == "2"){
        vEvent_title="컴백혜택";
        offset = $("#evt2").offset();
    }

    if(!!offset){
        var $anchor = offset.top;
        $('html, body').stop().animate({scrollTop: $anchor}, 500);
    }

	var nowPageChk = document.URL;
	if(nowPageChk.indexOf("tab=1") > -1){
		ga('send', 'pageview', {'page': vEvent_page,'title': '[모바일] 생일혜택_PV' });
	}else if(nowPageChk.indexOf("tab=2") > -1 ){
		ga('send', 'pageview', {'page': vEvent_page,'title': '[모바일] 컴백혜택_PV' });
	}

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

CmdShare();
function CmdShare(){
	Kakao.Link.createDefaultButton({
		  container: '#kakao-link-btn',
	      objectType: 'feed',
	      content: {
	        title: '생일&컴백',
	        description: '이번달 생일이거나 오랜만에 오신분들을 위해 특별한 혜택을 드립니다!',
	        imageUrl: "<%=strFb_img%>",
	        link: {
	          webUrl: shareUrl,
	          mobileWebUrl: shareUrl
	        }
	      },
		buttons: [{
	          title: '에누리가격비교',
	          link: {
	            mobileWebUrl: shareUrl,
	            webUrl: shareUrl
	          }
		}]
    });
}

var vApp = "<%=strApp%>";
if(vApp == "Y")	{
	// 애드브릭스 적용: 프로모션
	var strEvent = "event_birthday_view";
	  
	try{
		if(window.android){            // 안드로이드
			window.android.airbridgeEventForApp(strEvent,"event","birthday","");
		}else{                               // 아이폰에서 호출
			window.location.href = "enuriappcall://airbridgeEventForApp?p1="+strEvent+"&p2=event&p3=birthday&p4=";
		} 
	}catch(e){} 
}


</script>
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</body>
/html>