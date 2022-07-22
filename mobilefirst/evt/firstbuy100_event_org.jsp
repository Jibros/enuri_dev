<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
String strFb_title = "[에누리 가격비교] 100원에누리다!";
String strFb_description = "에누리 첫 구매라면 누구나! 인기상품 단돈 100원에 구매하고 파워적립 받으세요!";
String strFb_img = "http://img.enuri.info/images/mobilefirst/etc/first100sns2.jpg";

response.sendRedirect("/mobilefirst/evt/welcome_event.jsp"); //100원딜 종료
return;

/*
String oc = ChkNull.chkStr(request.getParameter("oc"));
 if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){

}else{
    response.sendRedirect("/event2019/first_purchase_2019_evt.jsp"); //pc url
    return;
}
 */

 /*
long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String sdt = dayTime.format(new Date(cTime));//진짜시간

if(  request.getParameter("sdt")!=null && !request.getParameter("sdt").equals("") ) {
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
*/

int numSdt = Integer.parseInt(sdt);

boolean isNext = false;
//String cssFile = "/css/event/y2019/firstPurchase/mobile.css";
String cssFile = "/css/event/y2020/w100deal_m.css";


String startDate = "";
String endDate="";

if(numSdt >= 20200901){
	isNext = true;
	
	cssFile = "/css/event/y2020/buyfirst_sep_m.css";
	startDate = "20200901";
	endDate="20201004";
	strFb_title = "[에누리 가격비교] WELCOME 혜택!";
	strFb_description = "첫 구매 고객이라면 누구나 최대 e머니 17,000점!";
	strFb_img = "http://img.enuri.info/images/mobilefirst/etc/welcomesns.jpg";
}else{
	cssFile = "/css/event/y2020/w100deal_aug_m.css";
	startDate = "20200803";
	endDate="20200831";
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

if( "Y".equals(strAppyn) ){
	if( "".equals(chkId) ){
		chkId = ChkNull.chkStr(cb.getCookie_One("chk_id"));	
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
<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/event_regular.js?v=20200825"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js?v=202020"></script>
<script>
var shareUrl = "http://" + location.host + "/mobilefirst/evt/firstbuy100_event.jsp?oc=mo";
Kakao.init('5cad223fb57213402d8f90de1aa27301');
</script>
</head>
<body>
<script type="text/javascript">


var app = getCookie("appYN"); //app인지 여부
var gkind = '<%=strGkind%>'+'';
var gno = '<%=strGno%>'+'';
var vEvent_page = "<%=strUrl%>"; //돌아갈 이벤트페이지주소
var vEvent_title = "첫구매 100원딜";
var username = "<%=userArea%>";
var mType = "";// 안드로이드 / 아이폰
var isVersion = <%=isVersion%>;
var sdt = "<%=sdt%>";//오늘날짜
var vChkId = "<%=chkId %>";

</script>
<!-- layer-->
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
<div class="layer_back fixed" id="app_only" style="display:none;">
    <div class="dimm" onclick="onoff('app_only');"></div>
    <div class="appLayer">
        <h4>모바일 앱 전용 이벤트</h4>
        <a href="javascript:///" class="close" onclick="onoff('app_only');">창닫기</a>
        <p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
        <p class="btn_close"><button type="button"  onclick="install_btt();">설치하기</button></p>
    </div>
</div>
<div class="toparea">	
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
							<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/evt/firstbuy100_event.jsp</span>
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
</div>
<div id="eventWrap">
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>
	<%if(numSdt>=20200901){ %>
		<div class="toparea">		
		<!-- 공통 : 상단비주얼 -->
			<div class="visual">
				<!-- 공통 : 공유하기 버튼  -->
				<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
				<!-- // -->
				<div class="inner">
					<span class="txt_01">WELCOME 혜택</span>
	                <h2>첫만남에-누리다</h2>
	                <span class="txt_02">에누리 첫 구매 고객이라면 누구나 최대 e머니 17,000점 혜택!</span>
	                <span class="box_wrap"><!--상자--></span>
				</div>
	            <div class="obj_flow_01"> <!-- 01 flow object -->
	                <div class="bg_flow flow_obj_01"></div>
	                <div class="bg_flow flow_obj_02"></div>
	            </div>
	            <div class="obj_flow_02"> <!-- 02 flow object -->
	                <div class="bg_flow flow_obj_01"></div>
	                <div class="bg_flow flow_obj_02"></div>
	            </div>
				<div class="loader-box">
					<div class="visual-loader"></div>
				</div>
				<script>
					// 상단 타이틀 등장 모션
					$(window).load(function(){
						var $visual = $(".toparea .visual");
						 $visual.addClass("intro");
						setTimeout(function(){
							$visual.addClass("end");
						},100)
					})
				</script>
			</div>
	
			<!-- 공통 : 탭 -->	
			<div class="section navtab">
				<div class="navtab_inner">
					<ul class="navtab_list">
						<li onclick="ga('send', 'event', 'mf_event', '100원딜' ,'상단탭_100원딜');" class="is-on"><a href="#" class="navtab_item--01">100원딜</a></li>
						<li onclick="ga('send', 'event', 'mf_event', '100원딜' ,'상단탭_친구초대');"><a href="/mobilefirst/evt/new_friend_20179.jsp" class="navtab_item--02">친구초대</a></li>
						<li onclick="ga('send', 'event', 'mf_event', '100원딜' ,'상단탭_파워적립');"><a href="/mobilefirst/evt/powerbuy_event.jsp" class="navtab_item--03">파워적립</a></li>
					</ul>
				</div>
			</div>
			<!-- //탭 -->
			
		</div>
		
		<div class="event_join">
			<div class="contents">
				<h3><img src="http://img.enuri.info/images/event/2020//buy_first/sep/m_100deal_tit.png" alt="100원딜 참여방법"></h3>
				<div class="swiper-wrap">
					<div class="swiper-container swiper-container-horizontal">
						<div class="swiper-wrapper" style="transform: translate3d(-840px, 0px, 0px); transition-duration: 0ms;">
							<div class="swiper-slide"><img src="http://img.enuri.info/images/event/2020/buy_first/sep/m_100deal_slide_01.png" alt="STEP 01"></div>
							<div class="swiper-slide"><img src="http://img.enuri.info/images/event/2020/buy_first/sep/m_100deal_slide_02.png" alt="STEP 02"></div>
							<div class="swiper-slide swiper-slide-prev"><img src="http://img.enuri.info/images/event/2020/buy_first/sep/m_100deal_slide_03.png" alt="STEP 03"></div>
							<div class="swiper-slide swiper-slide-active"><img src="http://img.enuri.info/images/event/2020/buy_first/sep/m_100deal_slide_04.png" alt="STEP 04"></div>
						</div>				
					</div>
					<!-- Add Arrows -->
					<div class="swiper-button-next btn_next swiper-button-white swiper-button-disabled"></div>
					<div class="swiper-button-prev btn_prev swiper-button-white"></div>
				</div>
				<div class="swiper-pagination swiper-pagination-bullets"><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet swiper-pagination-bullet-active"></span></div>
				<script>
					var mySwiper = new Swiper(".event_join .swiper-container", {
						autoplay: 2000,
						speed : 800,
						loop : false,
						pagination : '.event_join .swiper-pagination',
						prevButton : '.event_join .swiper-button-prev',
						nextButton : '.event_join .swiper-button-next',
						slidesPerView : 'auto',
						watchActiveIndex: true,					
						spaceBetween : 0
					});
				</script>
			</div>
		</div>
		<%@ include file="/mobilefirst/event2020/firstbuy100_main202009.jsp"%>	
	<%}else{ %>
	<div class="visual intro intro-end">
		<!-- 공통 : 공유하기 버튼  -->
		<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
		<!-- // -->

		<div class="inner">
			<span class="obj-ribbon">
				<span class="txt-ribbon">에누리 첫구매라면 누구나</span>
			</span>
			
			<span class="txt_01">첫 구매 혜택</span>
			<h2>100원에-누리다</h2>
			<span class="txt_02">인기상품 100원에 구매하고, 100일간 파워적립!</span>
		</div>
		<div class="swiper-no-touch"></div>
		<div class="swiper-container swiper-container-horizontal swiper-container-3d swiper-container-coverflow" style="cursor: grab;">
			<div class="swiper-wrapper" style="transform: translate3d(-921.5px, 0px, 0px); transition-duration: 3000ms;"><div class="swiper-slide swiper-slide-duplicate swiper-slide-duplicate-prev" style="background-image: url(&quot;http://img.enuri.info/images/event/2019/w100deal/m_top_card_05.png&quot;); transform: translate3d(-60px, 0px, -3600px) rotateX(0deg) rotateY(0deg); z-index: -5; transition-duration: 3000ms;" data-swiper-slide-index="0"></div><div class="swiper-slide swiper-slide-duplicate swiper-slide-duplicate-active" style="background-image: url(&quot;http://img.enuri.info/images/event/2019/w100deal/m_top_card_01.png&quot;); transform: translate3d(-50px, 0px, -3000px) rotateX(0deg) rotateY(0deg); z-index: -4; transition-duration: 3000ms;" data-swiper-slide-index="1"></div><div class="swiper-slide swiper-slide-duplicate swiper-slide-duplicate-next" style="background-image: url(&quot;http://img.enuri.info/images/event/2019/w100deal/m_top_card_02.png&quot;); transform: translate3d(-40px, 0px, -2400px) rotateX(0deg) rotateY(0deg); z-index: -3; transition-duration: 3000ms;" data-swiper-slide-index="2"></div><div class="swiper-slide swiper-slide-duplicate" style="background-image: url(&quot;http://img.enuri.info/images/event/2019/w100deal/m_top_card_03.png&quot;); transform: translate3d(-30px, 0px, -1800px) rotateX(0deg) rotateY(0deg); z-index: -2; transition-duration: 3000ms;" data-swiper-slide-index="3"></div><div class="swiper-slide swiper-slide-duplicate" style="background-image: url(&quot;http://img.enuri.info/images/event/2019/w100deal/m_top_card_04.png&quot;); transform: translate3d(-20px, 0px, -1200px) rotateX(0deg) rotateY(0deg); z-index: -1; transition-duration: 3000ms;" data-swiper-slide-index="4"></div>
				<div class="swiper-slide swiper-slide-prev" style="background-image: url(&quot;http://img.enuri.info/images/event/2019/w100deal/m_top_card_05.png&quot;); transform: translate3d(-10px, 0px, -600px) rotateX(0deg) rotateY(0deg); z-index: 0; transition-duration: 3000ms;" data-swiper-slide-index="0"></div>
				<div class="swiper-slide swiper-slide-active" style="background-image: url(&quot;http://img.enuri.info/images/event/2019/w100deal/m_top_card_01.png&quot;); transform: translate3d(0px, 0px, 0px) rotateX(0deg) rotateY(0deg); z-index: 1; transition-duration: 3000ms;" data-swiper-slide-index="1"></div>
				<div class="swiper-slide swiper-slide-next" style="background-image: url(&quot;http://img.enuri.info/images/event/2019/w100deal/m_top_card_02.png&quot;); transform: translate3d(10px, 0px, -600px) rotateX(0deg) rotateY(0deg); z-index: 0; transition-duration: 3000ms;" data-swiper-slide-index="2"></div>
				<div class="swiper-slide" style="background-image: url(&quot;http://img.enuri.info/images/event/2019/w100deal/m_top_card_03.png&quot;); transform: translate3d(20px, 0px, -1200px) rotateX(0deg) rotateY(0deg); z-index: -1; transition-duration: 3000ms;" data-swiper-slide-index="3"></div>
				<div class="swiper-slide" style="background-image: url(&quot;http://img.enuri.info/images/event/2019/w100deal/m_top_card_04.png&quot;); transform: translate3d(30px, 0px, -1800px) rotateX(0deg) rotateY(0deg); z-index: -2; transition-duration: 3000ms;" data-swiper-slide-index="4"></div>
			<div class="swiper-slide swiper-slide-duplicate swiper-slide-duplicate-prev" style="background-image: url(&quot;http://img.enuri.info/images/event/2019/w100deal/m_top_card_05.png&quot;); transform: translate3d(40px, 0px, -2400px) rotateX(0deg) rotateY(0deg); z-index: -3; transition-duration: 3000ms;" data-swiper-slide-index="0"></div><div class="swiper-slide swiper-slide-duplicate swiper-slide-duplicate-active" style="background-image: url(&quot;http://img.enuri.info/images/event/2019/w100deal/m_top_card_01.png&quot;); transform: translate3d(50px, 0px, -3000px) rotateX(0deg) rotateY(0deg); z-index: -4; transition-duration: 3000ms;" data-swiper-slide-index="1"></div><div class="swiper-slide swiper-slide-duplicate swiper-slide-duplicate-next" style="background-image: url(&quot;http://img.enuri.info/images/event/2019/w100deal/m_top_card_02.png&quot;); transform: translate3d(60px, 0px, -3600px) rotateX(0deg) rotateY(0deg); z-index: -5; transition-duration: 3000ms;" data-swiper-slide-index="2"></div><div class="swiper-slide swiper-slide-duplicate" style="background-image: url(&quot;http://img.enuri.info/images/event/2019/w100deal/m_top_card_03.png&quot;); transform: translate3d(70px, 0px, -4200px) rotateX(0deg) rotateY(0deg); z-index: -6; transition-duration: 3000ms;" data-swiper-slide-index="3"></div><div class="swiper-slide swiper-slide-duplicate" style="background-image: url(&quot;http://img.enuri.info/images/event/2019/w100deal/m_top_card_04.png&quot;); transform: translate3d(80px, 0px, -4800px) rotateX(0deg) rotateY(0deg); z-index: -7; transition-duration: 3000ms;" data-swiper-slide-index="4"></div></div>
		</div>				
		<script>
			$(window).load(function(){
				var mySwiper;
				setTimeout(function(){
					mySwiper = new Swiper('.visual .swiper-container', {
						effect: 'coverflow',
						grabCursor: true,
						centeredSlides: true,
						loop : true,
						speed : 3000,
						autoplay : 1,
						slidesPerView: 'auto',
						coverflow: {
							rotate: 0,
							stretch: -10,
							depth: 600,
							modifier: 1,
							slideShadows : false,
						}
					});		
					$(".visual").addClass("intro");
					setTimeout(function(){
						$(".visual").addClass("intro-end");
					},2000)
				},500)
			});
		</script>	
	</div>
	<div class="section floattab">
		<div class="contents">
			<ul class="floattab__list">
				<li><a href="#evt1" class="floattab__item floattab__item--01 is-on">100원딜</a></li>
				<li><a href="#evt2" class="floattab__item floattab__item--02">파워적립</a></li>
				<li><a href="http://m.enuri.com/mobilefirst/index.jsp#2" class="floattab__item floattab__item--03">더 많은 이벤트</a></li>
			</ul>
		</div>
	</div>
    <%@ include file="/mobilefirst/event2020/firstbuy100_main202008.jsp"%>	<!-- 첫구매 -->
	<%}%>
        
    <%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
</div>
<script type="text/javascript">
//공통영역//
(function(){
	
	ga('send', 'pageview', {'page': vEvent_page,'title': '[모바일] 100원딜_PV'});
	
	if('<%=flow%>' == "sfb")				ga('send', 'pageview', {'page': vEvent_page,'title': '[모바일] 100원딜_페이스북_PV' });
	else if('<%=flow%>' == "sap")			ga('send', 'pageview', {'page': vEvent_page,'title': '[모바일] 100원딜_앱설치_PV' });
	else if('<%=flow%>' == "sad")			ga('send', 'pageview', {'page': vEvent_page,'title': '[모바일] 100원딜_검색광고_PV' });
	
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1)		mType = "I";
	else if(navigator.userAgent.indexOf("Android") > -1)		mType = "A";
	if(islogin())		getPoint();
	//닫기버튼
	 $( ".win_close" ).click(function(){
        if(app == 'Y')  window.location.href = "close://";
        else            window.location.replace("/m/index.jsp");
	});
	
	$(".go_top").click(function(){		$(window).scrollTop(0);	});

	$(".txt-caution-txt-02").each(function(e){
		$(this).css("width",$(this).outerWidth());
	});

	var mySwiper;
	setTimeout(function(){
		mySwiper = new Swiper('.toparea .swiper-container', {
			effect: 'coverflow',
			grabCursor: true,
			centeredSlides: true,
			loop : true,
			speed : 3000,
			autoplay : 1,
			slidesPerView: 'auto',
			coverflow: {
				rotate: 0,
				stretch: -10,
				depth: 600,
				modifier: 1,
				slideShadows : false,
			}
		});		
		$(".visual").addClass("intro");
		setTimeout(function(){
			$(".visual").addClass("intro-end");
		},2000)
	},500);
})();
window.onload = function(){
	var isPush = <%=isPush%>;
	if(isPush){
		ga('send', 'event', 'mf_event', vEvent_title ,'push클릭');
	}
    var tab = "<%=tab%>";
    $(".inner_tabs li a:after").css("background","none");

    var offset = "";
    if(tab == "1"){
        vEvent_title = "첫구매 100원딜";
        offset = $("#evt1").offset();
        
        if( '<%=flow%>' == "sad" ){
        	ga('send','event', 'mf_event','첫구매_외부유입','100원딜_외부유입');
        }
    }else if(tab == "2"){
        vEvent_title="100일간 파워적립";
        offset = $("#evt2").offset();
        
        if( '<%=flow%>' == "sad" ){
        	ga('send','event', 'mf_event','첫구매_외부유입','파워적립_외부유입');
        }
    }
    if(!!offset){
        var $anchor = offset.top - 40;
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
	if(nowPageChk.indexOf("tab=1") > -1)			ga('send', 'pageview', {'page': vEvent_page,'title': '[모바일] 100원딜_PV' });
	else if(nowPageChk.indexOf("tab=2") > -1 )		ga('send', 'pageview', {'page': vEvent_page,'title': '[모바일] 파워적립_PV' });
	else											ga('send', 'pageview', {'page': vEvent_page,'title': '[모바일] 100원딜_PV' });

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
    
	$("#eventShr > li").click(function(){
		var sel = $(this).attr("id");
		var shareTitle = "<%=strFb_title%> <%=strFb_description%>";
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
    
    
};
//앱설치버튼
function install_btt(){
	
	ga('send','event', 'mf_event','click',vEvent_title+'_설치하기');
	
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
    	}else if(gkind=="75" && gno == "3120469"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','버즈빌_첫구매CU');
    		window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=1917629&sub_referral=8147655";
		}else if(gkind=="74" && gno == "3120470"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','페이스북_첫구매CU');
			window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=4120949&sub_referral=2082626";
		}else if(gkind=="71" && gno =="3100367"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','망고_첫구매CU');
    		window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=9999961&sub_referral=1319566";
    	}else if(gkind=="76" && gno =="3139542"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','애드립_첫구매CU');
    		window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=3535287&sub_referral=3457934";
    	}else if(gkind=="82" && gno =="4299545"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','쉘위애드_첫구매');
    		window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6497571&sub_referral=4519572";
    	}else{
    		window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
    	}
    }
}

$(window).load(function(){
	var $itemGroup = $(".visual .fade_item"),
	_idx = 1,
	_timer = null;
	var changeItem = function(){
		$itemGroup.find(".off").removeClass("off");
		$itemGroup.find(".appear").removeClass("appear").addClass("off");
		$itemGroup.find("li").eq(_idx).addClass("appear");
		( _idx < $itemGroup.find('li').length - 1 ) ? _idx++ : _idx = 0;
	}
	changeItem();
	_timer = setInterval(changeItem,3500);

});

function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevt%2Ffirstbuy100_event.jsp";
	if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
		goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/evt/firstbuy100_event.jsp";
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
				location.href = goApp;
			} else{
				location.href = goApp;
			}
		}
	}else{
		setTimeout( function() {
			window.open("https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8");
		}, 1000);
		location.href = goApp;
	}
}

var sdt = <%=numSdt%>;

$(function () {
	if(oc!=''){
		$('.lay_only_mw').show();
	}
	// 해당 섹션으로 스크롤 이동
		if(sdt<20200901){
			// 상단 메뉴 스크롤 시, 고정
		var $nav = $('.floattab'),
			$menu = $('.floattab__list li'),
			$contents = $('.scroll'),
			$navheight = $nav.outerHeight(), // 상단 메뉴 높이
			$navtop = Math.ceil($nav.offset().top); // floattab 현재 위치; 
			
		$menu.on('click', 'a', function (e) {
			var $target = $(this).parent(),
				idx = $target.index();
			if(idx != 2){
				offsetTop = Math.ceil($contents.eq(idx).offset().top);
				$('html, body').stop().animate({ scrollTop: offsetTop - $navheight }, 500);
			}
			
			if(idx == 0){
				ga('send', 'event', 'mf_event', vEvent_title ,'첫구매 100원딜');
			}else if(idx == 1){
				ga('send', 'event', 'mf_event', vEvent_title ,'100일간 파워적립');
			}else if(idx == 2){
				ga('send', 'event', 'mf_event', vEvent_title ,'더 많은 이벤트');
				if(app == "Y"){
					location.href = "http://m.enuri.com/mobilefirst/index.jsp?freetoken=main_tab|event";	
				}else{
					location.href = "http://m.enuri.com/mobilefirst/index.jsp#evt";
				}
				return false;
			}
			return false;
		});
	
		// menu class 추가 
		$(window).scroll(function () {
			var $scltop = Math.ceil($(window).scrollTop());	// 현재 scroll
	
			if ($scltop > $navtop) {
				$nav.addClass("is-fixed");
				$(".visual").css("margin-bottom", $navheight);
			} else {
				$nav.removeClass("is-fixed");
				$menu.children("a").removeClass('is-on');
				$menu.children("a").eq(0).addClass('is-on');
				$(".visual").css("margin-bottom", 0);
			}
	
			$.each($contents, function (idx, item) {
				var $target = $contents.eq(idx),
					i = $target.index(),
					targetTop = Math.ceil($target.offset().top - $navheight);
	
				if (targetTop <= $scltop) {
					$menu.children("a").removeClass('is-on');
					$menu.eq(idx).children("a").addClass('is-on');
				}else{
					$menu.eq(0).children("a").addClass('is-on');
				}
				if (!($navheight <= $scltop)) {
					$menu.children("a").removeClass('is-on');
					$menu.children("a").eq(0).addClass('is-on');
				}
			})
		});
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
CmdShare();
	function CmdShare(){
		Kakao.Link.createDefaultButton({
			  container: '#kakao-link-btn',
		      objectType: 'feed',
		      content: {
		        title: "<%=strFb_title%>",
		        description: "<%=strFb_description%>",
		        imageUrl: "<%=strFb_img%>",
		        link: {
		          webUrl: shareUrl,
		          mobileWebUrl: shareUrl
		        }
		      },
			buttons: [{
		          title: '첫구매 혜택 받기!',
		          link: {
		            mobileWebUrl: shareUrl,
		            webUrl: shareUrl
		          }
			}]
	    });
	}

</script>
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</body>
</html>