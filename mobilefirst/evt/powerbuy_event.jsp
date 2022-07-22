<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
String strFb_title = "[에누리 가격비교] WELCOME 혜택!";
String strFb_description = "첫 구매 고객이라면 누구나 최대 e머니 17,000점!";
String strFb_img = "http://img.enuri.info/images/mobilefirst/etc/welcomesns.jpg";

String oc = ChkNull.chkStr(request.getParameter("oc"));
 if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){

}else{
    response.sendRedirect("/event2020/power_purchase.jsp"); //pc url
    return;
}

long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String sdt = dayTime.format(new Date(cTime));//진짜시간

if(  request.getParameter("sdt")!=null && !request.getParameter("sdt").equals("") ) {
	sdt = request.getParameter("sdt");
}

if(Integer.parseInt(sdt)>=20210701){
	response.sendRedirect("/m/event/power.jsp "); //url 변경
	return;
}

int numSdt = Integer.parseInt(sdt);

boolean isNext = false;

String cssFile = "/css/event/y2020/buyfirst_nov_m.css";
if(numSdt >= 20210104){
	cssFile = "/css/event/y2021/buyfirst_jan_m.css";
}

if(numSdt >= 20210501){
	cssFile = "/css/event/y2021_rev/buyfirst_may_m.css";
}

String startDate = "20200901";
String endDate="20201004";

String cUserId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");
String chkId = ChkNull.chkStr(request.getParameter("chk_id"));
String strUrl = request.getRequestURI();
String tab = ChkNull.chkStr(request.getParameter("tab"));
String flow = ChkNull.chkStr(request.getParameter("flow"));

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
<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
<link rel="stylesheet" type="text/css" href="<%=cssFile %>"/>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/event_regular.js?v=20180201"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js?v=202020"></script>
<script>
var shareUrl = "http://" + location.host + "/mobilefirst/evt/powerbuy_event.jsp?oc=mo";
</script>
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
	if("<%=flow%>" == "sfb")			ga('send', 'event', 'mf_event', 'click','파워적립_페이스북_유입클릭');
	else if("<%=flow%>" == "sap")		ga('send', 'event', 'mf_event', 'click','파워적립_앱설치_유입클릭');
	else if("<%=flow%>" == "sad")		ga('send', 'event', 'mf_event', 'click','파워적립_검색광고_유입클릭');
}

var app = getCookie("appYN"); //app인지 여부
var oc = '<%=oc%>';
var gkind = '<%=strGkind%>'+'';
var gno = '<%=strGno%>'+'';
var vEvent_page = "<%=strUrl%>"; //돌아갈 이벤트페이지주소
var vEvent_title = "파워적립";
var username = "<%=userArea%>";
var mType = "";// 안드로이드 / 아이폰
var isVersion = <%=isVersion%>;
var sdt = "<%=sdt%>";//오늘날짜
var vChkId = "<%=chkId %>";
var vUserId = "<%=cUserId%>";
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
<div id="eventWrap">

	<div class="myarea">
		<%if(cUserId.equals("")){%>
			<p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>
		<%}else{%>
			<p class="name"><%=userArea%> 님<span id="my_emoney">0점</span></p>
		<%}%>
		<a href="#" class="win_close">창닫기</a>
	</div>

	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">
		<!-- 공통 : 상단비주얼 -->
		<div class="visual intro end">
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
					<li><a onclick="mo_ga(1);" href="/mobilefirst/evt/welcome_event.jsp" class="navtab_item--01">웰컴팩</a></li>
					<li><a onclick="mo_ga(2);" href="/mobilefirst/evt/new_friend_20179.jsp" class="navtab_item--02">친구초대</a></li>
					<li onclick="mo_ga(3);" class="is-on"><a href="#" class="navtab_item--03">파워적립</a></li>
				</ul>
			</div>
		</div>
		<!-- //탭 -->
	</div>
	<!-- // -->

	<!-- T3 파워적립 혜택 -->
	<div class="section clear powersave" id="evt1">
		<div class="contents">
			<%if(numSdt >= 20210104){%>
			<h2><img src="http://img.enuri.info/images/event/2021/buy_first/jan/m_powersave_tit.png" alt="파워적립 참여 혜택 - 웰컴 페이백/친구초대 첫 구매 혜택 신청하셨다면 주목! 첫 구매 후 100일간 구매하고 최대 e7,100점 받아가세요!"></h2>
			<%}else{ %>
			<h2><img src="http://img.enuri.info/images/event/2020/buy_first/nov/m_powersave_tit.png" alt="파워적립 참여 혜택 - 웰컴 페이백/친구초대 첫구매 혜택 신청하셨다면 주목! 첫 구매 후 100일간 최대 e7,100점 받아가세요!"></h2>
			<%} %>

			<div class="stamp_con">
				<ul id="powerList">
					<!-- 활성화 .on 붙여주세요 -->
					<li><span class="blind">1,500점 적립</span></li>
					<li><span class="blind">1,000점 적립</span></li>
					<li><span class="blind">1,000점 적립</span></li>
					<li><span class="blind">1,500점 적립</span></li>
					<li><span class="blind">2,000점 적립</span></li>
				</ul>
				<span class="txt_terms">나의 파워적립 구매기간 : <span class="txt_date">APP에서 확인하세요!</span></span>
			</div>
			<div class="event_noti">
				<div class="noti_cnt">
					<ul>
						<%if(numSdt>20201031){ %>
							<li>※ 본 이벤트는 ID(본인인증), 웰컴 페이백/친구초대 첫 구매 혜택 신청, 100일간 구매 모두 동일한 모바일 기기에서 진행한 경우에만 혜택 지급 가능합니다.</li>
						<%}else{ %>
							<li>※ 본 이벤트는 본인인증, 첫 구매, 페이백 신청 100일간 구매 모두 동일한 모바일 기기에서 진행한 경우에만 지급 가능합니다.</li>
							<li>※ 본 이벤트는 친구초대 첫구매 혜택 신청한 경우에도 파워적립 자동 참여됩니다.</li>
						<%} %>
						<li>※ 본 이벤트는 웰컴 페이백/친구초대 첫 구매 혜택 신청 시 별도 절차없이 자동 적립됩니다. (미신청 시 혜택 지급 불가)</li>
						<%if(numSdt>=20210104){ %>
						<li>※ 본 이벤트 혜택은 각 2~6번째 구매 건의 구매적립 다음날 적립됨과 동시에 스탬프 확인이 가능합니다.</li>
						<%} %>
						<li>※ 본 이벤트는 모바일 앱에서만 참여 가능합니다.</li>
					</ul>
				</div>
			</div>
		</div>

		<!-- 버튼 : 꼭 확인하세요 -->
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop1"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop1" class="evt_notice--slide">
			<div class="evt_notice--inner">
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<dl>
							<dt>이벤트 대상 및 혜택</dt>
							<dd>
								<ul>
									<li>이벤트 대상 : 웰컴 페이백/친구초대 첫 구매 혜택 신청한 고객</li>
									<li>이벤트 기간 : 첫 구매일로부터 100일 이내</li>
									<li>이벤트 혜택 : 파워적립 구매건수별 차등 적립 (최대 e머니 7,100점)</li>
									<li>혜택 지급일 : 구매일로부터 최대 30일 이내 적립 (※ 해외직구 상품 구매 시 최대 70일 소요)<br>
										<%if(numSdt >= 20210104){ %>
										<span class="stress noti">※ 각 2~6번째 구매 건의 구매적립 다음날 적립됨과 동시에 스탬프 확인이 가능합니다.</span>
										<%} %>
									</li>
									<li><span class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span><br>
										<span class="noti">※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</span>
									</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>이벤트 참여방법 및 유의사항</dt>
							<dd>
								<ul>
									<li>참여방법 : 에누리 가격비교 모바일 앱 로그인 → 적립대상 쇼핑몰 이동 → <span class="stress">첫 구매일로부터 100일간 1만원 이상 구매</span> → 파워적립 (※ 별도 신청 절차없이 자동 적립)</li>
									<li>적립대상 쇼핑몰 : G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, Cjmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 에누리 해외직구관, SK스토아, 홈플러스<br>
										<span class="stress">※ 구매 유의사항 및 구매적립 제외 카테고리는 이벤트 페이지 하단 'e머니 구매혜택' 유의사항을 꼭 확인하세요!</span>
									</li>
									<li>적립대상 쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제하는 경우, 구매건수는 1건으로 1개의 파워적립만 적립됩니다.</li>
									<li>이벤트 기간 내 1만원 이상 구매건수에 따라 혜택 지급됩니다. (※ 이벤트 대상 제외 확인)</li>
									<li class="stress">본 이벤트는 모바일 앱에서만 참여가 가능한 모바일 앱전용 프로모션 입니다.</li>
									<li class="stress">본 이벤트는 ID(본인인증), 첫 구매, 웰컴 페이백/친구초대 첫 구매 혜택 신청, 100일간 구매 모두 동일한 모바일 기기에서 진행한 경우에만 혜택 지급 가능합니다.</li>
									<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다.</li>
									<li>
										<span class="stress">이벤트 대상 제외 :</span> 아래의 경우에는 이벤트 대상 및 혜택 지급에서 제외됩니다. <br>
										<ul class="sub">
										<%if(numSdt > 20201031){ %>
											<li>- 웰컴 페이백/친구초대 첫 구매 혜택 신청하지 않은 경우 </li>
										<%}else{ %>
											<li>- 첫 구매 페이백 이벤트 신청하지 않은 경우 </li>
										<%} %>
											<li>- 실제 구매금액이 1만원 미만의 구매일 경우</li>
											<li>- 구매적립 제외 카테고리 구매일 경우</li>
											<li>- 구매 후 취소/환불/교환/반품한 경우 </li>
											<li>- 동일한 본인인증으로 가입한 다수의 ID로 중복 참여한 경우</li>
										</ul>
									</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>공통 이벤트 유의사항</dt>
							<dd>
								<ul>
									<li>부정 참여 시 본 이벤트 대상 제외 및 혜택 지급이 취소될 수 있습니다. </li>
									<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
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
	<!-- // -->
	<%if(numSdt>20201030){ %>
	<div class="bnr_wrap bnr1">
		<h3 class="blind">구매혜택 배너</h3>

		<a href="http://m.enuri.com/mobilefirst/evt/smart_benefits.jsp" target="_blank" title="새 창에서 열립니다.">구매했다면 스탬프 찍고 추가적립까지! 쇼핑에-누리다 혜택 받기</a>
    </div>
    <div class="bnr_wrap bnr2">
		<h3 class="blind">더많은 이벤트 배너</h3>

		<a href="http://m.enuri.com/mobilefirst/index.jsp#plan" target="_blank" title="새 창에서 열립니다.">놓칠 수 없는 특별한 에누리 혜택, 더 많은 이벤트 혜택 받기</a>
	</div>
	<%}else{ %>
	<!-- T3 더많은 이벤트 -->
	<div class="go_moreevt">
		<div class="contents">
			<a onclick="mo_ga(4);" id="moreevt" target="_blank">
				<span class="txt">놓칠 수 없는 특별한 에누리 혜택</span>
				<span class="btn_more_evt">더 많은 이벤트 혜택 받기&gt;</span>
			</a>
		</div>
	</div>
	<!-- // -->
    <%} %>
    <%@ include file="/mobilefirst/evt/event_bottom.jsp"%><!-- 생활혜택 -->
    <!-- 공통 : 하단 e머니 구매혜택 -->
		<%-- <div class="com_event_benefit">
			<div class="com_event__inner">
				<h3 class="blind">에누리에서 구매하고 현금같은 e머니 적립 받으세요!</h3>
				<div class="com_benefit_slide swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<img src="http://img.enuri.info/images/event/2020/common/m_com_evt_ben_slide_01.png" alt="STEP1. 에누리 앱에서 로그인 후 적립대상 쇼핑몰 이동하기">
						</div>
						<div class="swiper-slide">
							<img src="http://img.enuri.info/images/event/2020/common/m_com_evt_ben_slide_02.png" alt="STEP2. 상품 구매하기">
						</div>
						<div class="swiper-slide">
							<img src="http://img.enuri.info/images/event/2020/common/m_com_evt_ben_slide_03.png" alt="STEP3. 구매금액의 최대 1.5% E머니 적립!">
						</div>
						<div class="swiper-slide">
							<img src="http://img.enuri.info/images/event/2020/common/m_com_evt_ben_slide_04.png" alt="STEP4. e쿠폰 스토어에서 1,000여가지의 인기 e쿠폰으로 교환가능!">
						</div>
					</div>
					<div class="swiper-button-prev btn_prev"></div>
					<div class="swiper-button-next btn_prev"></div>
				</div>
				<div class="swiper-pagination"></div>
				<!-- 유의사항 버튼 -->
	                  <a href="#appinfo" class="btn_com_benefit_noti btn__evt_notice on" data-laypop-id="appinfo">유의사항</a>
			</div>
			<script>
				$(function(){
					var mySwiper = new Swiper('.com_benefit_slide',{
						prevButton : '.swiper-button-prev',
						nextButton : '.swiper-button-next',
						pagination : '.swiper-pagination',
						speed : 1000,
						loop : true,
						paginationClickable : true
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

				});

			</script>
		</div>
<!-- 200207 구매적립 유의사항 이동 / 레이어 -> flip형으로 수정 / 문구수정 -->
			<div id="appinfo" class="evt_notice--slide">
				<div class="evt_notice--inner">
					<div class="evt_notice--head">유의사항</div>
					<!-- 200608 유의사항 문구 수정 -->
					<div class="evt_notice--cont">
						<div class="txt">
							<strong>e머니 구매적립 기준 및 유의사항</strong>
							<ul class="txt_indent">
								<li>적립 방법 : 에누리 가격비교 모바일 앱 로그인 &rarr; 적립대상 쇼핑몰 이동 &rarr; <span class="stress">1천원 이상 구매</span> &rarr; 구매확정(배송완료) 시 e머니 적립</li>
								<li>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 에누리 해외직구관, SK스토아, 홈플러스<br/>
									<span class="stress">※ 티몬 및 에누리 해외직구관의 경우 PC 및 모바일 앱/웹에서 로그인 후 구매시에도 구매적립 가능합니다.</span></li>
								<li>구매적립 e머니는 구매일로부터 10 ~ 30일간 취소/환불/교환/반품여부 확인 후 적립 됩니다.</li>
								<li><span class="stress">구매적립 e머니 유효기간 : 적립일로부터 60일 (유효기간 만료 후 재적립 불가)</span><br/>
									 ※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</li>
								<li>구매적립 e머니는 최소 10점(구매금액 1천원 이상)부터 적립되며, 1원 단위 e머니는 적립되지 않습니다.</li>
								<li>구매적립 e머니는 구매확정(구매일로부터 최대 30일) 시점부터 MY 에누리 적립내역 페이지에서 확인 가능합니다.</li>
								<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다. </li>
								<li>적립대상 쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제하는 경우 구매건수는 1건이며 구매금액은 통합된 금액으로 e머니 적립 됩니다.</li>
								<li>구매적립 e머니는 카테고리별 차등 적립됩니다. <br/>※ 카테고리별 적립률
									<div class="tb">
										<table>
											<colgroup>
												<col width="70%" /><col width="30%" />
											</colgroup>
											<tbody>
												<tr>
													<th>카테고리</th>
													<th>적립률</th>
												</tr>
												<tr>
													<td>유아,완구</td>
													<td>1.5%</td>
												</tr>
												<tr>
													<td>식품/스포츠,레저/자동차/화장품</td>
													<td>1.0%</td>
												</tr>
												<tr>
													<td>컴퓨터/도서/문구,사무/PC부품</td>
													<td>0.8%</td>
												</tr>
												<tr>
													<td>디지털/영상,디카</td>
													<td rowspan="4">0.3%</td>
												</tr>
												<tr>
													<td>가전(생활,주방,계절)</td>
												</tr>
												<tr>
													<td>패션/잡화</td>
												</tr>
												<tr>
													<td>가구,인테리어</td>
												</tr>
												<tr>
													<td>생활,취미</td>
													<td rowspan="2">0.2%</td>
												</tr>
												<tr>
													<td>모바일쿠폰,상품권<br/>
														<p style="font-size:10px;margin-top:4px;color:#e91030">*특정 상품에 한하여 적립되오니<br/>적립가능 상품은 하단에서 확인해주세요.</p>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</li>
							</ul>

							<strong class="stress">[모바일쿠폰,상품권 ] 구매적립 기준</strong>
							<ul class="txt_indent">
								<li>적립가능 쇼핑몰 :<%if(numSdt < 20201101){ %>티몬,<%} %> G마켓, 옥션<%if(numSdt > 20201030){ %>, 인터파크<%} %> </li>
								<%if(numSdt < 20201101){ %><li><span class="stress">※ 2020년 11월 1일부터 티몬 상품권 e머니 구매적립이 종료될 예정입니다.</span></li><%} %>
								<li>적립가능 상품 (0.2% 적립) : 문화상품권(해피머니, 컬쳐랜드), 도서상품권, 백화점상품권, 영화예매권, 국민관광 상품권</li>
								<li>백화점상품권 기준 상세
									<ul>
										<li>1) 상품명에 '백화점 상품권' 명시된 상품 또는 백화점에서만 사용할 수 있는 상품권만 적립가능</li>
										<li>2) 복합상품권 적립불가 (삼성 상품권, 신세계 기프트카드, 롯데카드 상품권, 이랜드 상품권, AK플라자 상품권, 통합 상품권 등)<br/>
											- 복합 상품권의 경우 사용처에 백화점이 기재되어 있는 경우에도 적립불가</li>
										<li>3) 백화점 상품권으로 전환 가능한 포인트 구매 시 적립불가</li>
									</ul>
								</li>
							</ul>

							<strong>적립대상 쇼핑몰 중 구매적립 제외 카테고리 및 서비스</strong>
							<ul class="txt_indent">
								<li>에누리 가격비교에서 검색되지 않는 상품</li>
								<li>모바일쿠폰,상품권 : 상품권, 지역쿠폰, e교환권, e쿠폰 등 </li>
								<li>쇼핑몰 제휴 서비스(배달, 티켓, 해외직구 등) 및 일부 카테고리<br/>
									<ul>
										<li>- G마켓 : 중고장터, 실시간 여행, 항공권, 도서/음반, 모바일쿠폰/상품권(일부 적립가능)</li>
										<li>- 옥션 : 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권(일부 적립가능)</li>
										<li>- 11번가 : 여행/숙박/항공, 모바일쿠폰/상품권</li>
										<li>- 인터파크 : 라이프 서비스(티켓, 투어, 아이마켓 등), 모바일쿠폰/상품권<%if(numSdt > 20201030){ %>(일부 적립가능)<%} %> </li>
										<li>- 티몬 : 특가 판매 상품(슈퍼꿀딜, 슈퍼마트 등), 모바일쿠폰/상품권<%if(numSdt < 20201101){ %>(일부 적립가능 <span class="stress">※2020년 11월 1일부터 적립불가</span> )<%} %></li>
										<li>- 위메프 : 모바일쿠폰/상품권</li>
										<li>- GS SHOP, CJmall : 모바일쿠폰/상품권</li>
										<li>- SSG : 도서/음반/문구/취미/여행, 모바일쿠폰/상품권</li>
									</ul>
								</li>
							</ul>

							<strong>공통 구매 유의사항</strong>
							<ul class="txt_indent">
								<li><b style="display:block;margin-bottom:4px">아래의 경우에는 구매 확인 및 구매적립이 불가합니다.</b>
									<ul>
										<li>- 에누리 가격비교 모바일 앱이 아닌 다른 모바일 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 모바일 앱으로 결제만 한 경우</li>
										<li>- 에누리 가격비교 미 로그인 후 구매한 경우</li>
										<li>- 에누리 가격비교 PC 및 모바일 웹에서 구매한 경우 (※ 티몬 및 에누리 해외직구관은 PC 및 모바일 앱/웹 구매 시에도 가능)</li>
									</ul>
								</li>
							</ul>
						</div>
					</div>
					<!-- // -->
					<div class="evt_notice--foot">
						<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 유의사항 닫기 -->
					</div>
				</div>
			</div>
	<%if( Integer.parseInt(sdt) > 20201005 &&  Integer.parseInt(sdt) < 20201229  ) {%>
		<div class="com_event_special">
			<div class="com_event__inner">
				<h3 class="blind">e머니 스페셜 적립 이벤트</h3>
				<div class="tab_event">
					<a href="javascript:void(0);" class="tab-item" data-tab-index="1">쿠팡</a>
					<!-- <a href="javascript:void(0);" class="tab-item" data-tab-index="2">티몬</a> -->
					<!-- <a href="javascript:void(0);" class="tab-item" data-tab-index="3">스토어팜</a> -->
				</div>
				<div class="tab_cnt swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<a href="http://m.enuri.com/mobilefirst/event2019/coupangevt.jsp" title="클릭시 새창이 열립니다." target="blank"><img src="http://img.enuri.info/images/event/2020/common/m_com_evt_special_coupang_oct.png" alt="에누리 앱을 경유하여 쿠팡에서 구매 시 e머니로 적립해 드립니다. 최대 5% 적립"></a>
						</div>
					</div>
				</div>
				<!--
				<div class="swiper-pagination"></div>
				 -->
			</div>
		</div>
	<%} %> --%>
</div>
<div class="com__share_wrap dim" style="z-index:10000;display:none">
	<div class="com__layer share_layer">
		<div class="lay_head">공유하기</div>
		<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
		<div class="lay_inner">
			<ul id="eventShr">
				<li class="share_fb" id="fbShare">페이스북 공유하기</li>
				<li class="share_kakao" id="kakao-link-btn">카카오톡 공유하기</li>
				<li class="share_tw" id="twShare">트위터 공유하기</li>
			</ul>
			<!-- 메인보내기 버튼클릭시 .mail_on 추가해 주세요 -->
			<div class="btn_wrap">
				<div class="btn_group">
					<!-- 주소복사하기 -->
					<div class="btn_item">
						<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/evt/powerbuy_event.jsp</span>
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
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br>에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button">설치하기</button></p>
	</div>
</div>
    <%@ include file="/mobilefirst/event2016/event_footer.jsp" %>

<script type="text/javascript">
Kakao.init('5cad223fb57213402d8f90de1aa27301');
var heartbeat;
var timer;
function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevt%2Fpowerbuy_event.jsp";
	if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
		goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/evt/powerbuy_event.jsp";
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

function mo_ga(tab){
	if(tab==1){
		ga('send', 'event', 'mf_event', '파워적립', '상단탭_웰컴팩');
	}else if(tab==2){
		ga('send', 'event', 'mf_event', '파워적립', '상단탭_친구초대');
	}else if(tab==3){
		ga('send', 'event', 'mf_event', '파워적립', '상단탭_파워적립');
	}else if(tab==4){
		ga('send', 'event', 'mf_event', '파워적립', '더많은이벤트');
	}
}
function getPoint(){
	$.ajax({
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_point.jsp",
		async: false,
		dataType:"JSON",
		success: function(json){
			remain = json.POINT_REMAIN;	//적립금
			$("#my_emoney").html(CommaFormattedN(remain) +""+json.POINT_UNIT);

		}
	});
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

  while(n.length > 3){
      var nn = n.substr(n.length-3);
      a.unshift(nn);
      n = n.substr(0,n.length-3);
  }
  if (n.length > 0) { a.unshift(n); }
  n = a.join(delimiter);
  amount = minus + (n+ "");
  return amount;
}
$(function() {
	ga('send', 'pageview', {'page': '/mobilefirst/evt/powerbuy_event.jsp','title': '파워적립_PV'});

	if(oc!=""){
		$('.lay_only_mw').show();
	}
	$(".btn_login").click(function(){
		location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent("m.enuri.com/mobilefirst/evt/powerbuy_event.jsp");
		return false;
	});
	$("#moreevt").click(function(){
		var url = (app != "Y" ? "/mobilefirst/index.jsp#evt" : "/mobilefirst/renew/plan.jsp?freetoken=main_tab|event")
		window.open(url);
	});

	if(islogin()){
		getPoint();
		getPowerReward();
	}
	var app = getCookie("appYN");
	$(".stamp_con").click(function(){
		if(app!='Y'){
			$('.lay_only_mw').show();
		}else{
			if(vUserId==""){
				location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent("m.enuri.com/mobilefirst/evt/powerbuy_event.jsp");
			}
		}
	});
	$(".win_close").click(function(){
		if(app == "Y")			window.location.href = "close://";
		else			window.location.replace("/m/index.jsp");
	});

	$("#my_emoney").click(function(){
		window.location.href = "https://m.enuri.com/my/my_emoney_m.jsp?freetoken=emoney";	//e머니 적립내역
	});
	var shareTitle = "<%=strFb_title%> <%=strFb_description%>";
	$("#eventShr > li").click(function(){
		var sel = $(this).attr("id");

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
});
(function (global, $) {
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
}(window, window.jQuery));

// 공통 :  하단 컨텐츠로 바로 진입시 포지션 보정을 위한 스크립트 처리
$(function(){
	if(window.location.hash) {
		var $hash = $("#"+window.location.hash.substring(1));
		var navH = $(".navtab").outerHeight();
		if ( $hash.length ){
			$("html,body").stop(true,false).animate({"scrollTop": $hash.offset().top - navH},"slow");
		}
	}
})
function islogin() {
	var cName = "LSTATUS";
	var s = document.cookie.indexOf(cName +'=');
	if (s != -1){
		s += cName.length + 1;
		e = document.cookie.indexOf(';',s);
		if (e == -1){
			e 	= document.cookie.length;
		}
		if( unescape(document.cookie.substring(s,e))=="Y"){
			try {
				if(window.android){
						window.android.isLogin("true");
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
function getPowerReward(){

	if(!islogin()){
		$(".txt_date").text("로그인 후 확인하세요!");
		return;
	}

	$.ajax({
		type: "POST",
		url: "/mobilefirst/evt/ajax/ajax_power_reward.jsp",
		async: false,
		dataType:"JSON",
		success: function(json){

				for( i=0 ; i < json.cnt ; i++){
					$("#powerList > li").eq(i).addClass("on");
				}

				if(getCookie("appYN") == 'Y'){

					//첫구매 신청내역 없음
					if ( json.isApply == -2 || json.isApply == -3 || json.isApply == -1  ) {

						$(".txt_date").text("아쉽게도 대상자가 아닙니다.");
					} else if ( json.isApply == 1  ) {
						if( typeof json.power_date != 'undefined' ){

							var yy = json.power_date.substring(0,4);
							var mm = json.power_date.substring(4,6);
							var dd = json.power_date.substring(6,8);

							$(".txt_date").text(mm+"월 "+dd+"일 까지");

						}else{
							$(".txt_date").text("첫 구매 후 확인하세요!");
						}

					} else if( typeof json.power_date != 'undefined') {
						var yy = json.power_date.substring(0,4);
						var mm = json.power_date.substring(4,6);
						var dd = json.power_date.substring(6,8);

						$(".txt_date").text(mm+"월 "+dd+"일 까지");
					}

				}else{
					$(".txt_date").text("APP에서 확인하세요!");
				}

		}
	});
}


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

var vApp = "<%=strApp%>";
if(vApp == "Y")	{
	// 애드브릭스 적용: 프로모션
	var strEvent = "event_powerbuy_view";

	try{
		if(window.android){            // 안드로이드
			window.android.igaworksEventForApp(strEvent);
			window.android.airbridgeEventForApp(strEvent,"event","powerbuy","");
		}else{                               // 아이폰에서 호출
			window.location.href = "enuriappcall://igaworksEventForApp?strEvent="+ strEvent +"";
			window.location.href = "enuriappcall://airbridgeEventForApp?p1="+strEvent+"&p2=event&p3=powerbuy&p4=";
		}
	}catch(e){}
}
</script>
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</body>
</html>