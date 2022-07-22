<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
if(true){
	response.sendRedirect("/m/event/buy_stamp.jsp "); //url 변경
	return;
}

String strFb_title = "[에누리 가격비교] WELCOME 혜택!";
String strFb_description = "첫 구매 고객이라면 누구나 최대 e머니 17,000점!";
String strFb_img = "http://img.enuri.info/images/mobilefirst/etc/welcomesns.jpg";

 if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){

}else{
    response.sendRedirect("/event2020/welcome_evt.jsp"); //pc url
    return;
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
long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String sdt = dayTime.format(new Date(cTime));//진짜시간
String oc = ChkNull.chkStr(request.getParameter("oc"));
if( (request.getServerName().indexOf("dev.enuri.com") > -1 || request.getServerName().indexOf("m.enuri.com") > -1 ) && request.getParameter("sdt")!=null && !request.getParameter("sdt").equals("") ) {
	sdt = request.getParameter("sdt");
}

if(Integer.parseInt(sdt)>=20210701){
	response.sendRedirect("/m/event/welcome.jsp "); //url 변경
	return;
}

int numSdt = Integer.parseInt(sdt);

boolean isNext = false;
String cssFile = "/css/event/y2020/buyfirst_oct_m.css";

String startDate = "20201005";
String endDate="20201104";

if(numSdt >= 20201101){
	isNext = true;
	cssFile = "/css/event/y2020/buyfirst_nov_m.css";
	startDate = "20201101";
	endDate="20201130";
}

if(numSdt >= 20210501){
	cssFile = "/css/event/y2021_rev/buyfirst_may_m.css";
}

String cUserId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");
String chkId = ChkNull.chkStr(request.getParameter("chk_id"));
String strUrl = request.getRequestURI();
String tab = ChkNull.chkStr(request.getParameter("tab"));

String flow = ChkNull.chkStr(request.getParameter("flow"));
String pd = ChkNull.chkStr(request.getParameter("pd"));
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
<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/event_regular.js?v=20200825"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js?v=202020"></script>
<script>
var shareUrl = "http://" + location.host + "/mobilefirst/evt/welcome_event.jsp?oc=mo";


(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	//런칭할때 UA-52658695-3 으로 변경
	ga('create', 'UA-52658695-3', 'auto');
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
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br>에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();">설치하기</button></p>
	</div>
</div>
<div class="layer_back" id="pop_agree" style="display:none">
    <div class="agree_layer">
        <div class="inner">
            <div class="txt_tit">개인정보 수집 및 이용동의</div>
            <div class="txt_cnt">
                <div class="agree_tit">
                    본인인증 정보는 이벤트 종료 시까지<br>
                    저장하며 이벤트 종료 후 파기됩니다.
                </div>
                <div class="agree_txt">
                    <label><input type="checkbox" class="chkbox" id="chkAgree">이벤트 참여를 위한 개인정보 활용에 동의합니다.</label>
                    <a href="" onclick="onoff('pop_agree_noti');return false;" class="btn_view_detail">자세히보기&gt;</a>
                </div>
            </div>
            <p class="btn_apply"><button type="button" onclick="">응모완료 &gt;</button></p>
        </div>
        <!-- 닫기 -->
        <a href="#" onclick="onoff('pop_agree');return false;" class="btn_close">닫기</a>
        <!-- // 닫기 -->
    </div>
</div>
<div class="layer_back" id="pop_agree_noti" style="display:none">
	<div class="agree_noti_layer">
		<div class="inner">
			<div class="txt_tit">개인정보 수집 · 이용안내</div>
			<div class="txt_cnt">
				<strong>에누리 가격비교는 이벤트 참여확인을 위하여 <br>아래와 같이 개인 정보를 수집하고 있습니다.</strong><br>
				<dl>
					<dt>1. 개인정보 수집 항목</dt>
					<dd>- 휴대폰번호, 참여일시, 참여자ID, 본인인증확인(CI,DI)</dd>
					<dt>2. 개인정보 수집 목적</dt>
					<dd>- 이벤트를 위해 수집된 개인정보는 이벤트 참여확인을 위한 본인확인 이외의 목적으로 활용되지 않습니다.</dd>
					<dt>3. 개인정보 보유 및 이용기간</dt>
					<dd>- 개인정보 수집자 (에누리 가격비교)는 이벤트 기간 동안 개인정보를 수집하며, 이벤트가 종료되면 개인정보를 즉시 파기합니다.</dd>
				</dl>
			</div>
			<p class="btn_close"><button type="button" onclick="onoff('pop_agree_noti');">닫기</button></p>
		</div>
	</div>
</div>
<div class="layer_back" id="pop_payback" style="display:none">
	<div class="payback_noti_layer">
		<div class="inner">
			<div class="txt_tit blind">웰컴 페이백 신청 완료!</div>
			<div class="txt_cnt blind">첫 구매일로부터 <em>최대 30일 이내</em>에 웰컴 페이백 e머니가 적립됩니다.</div>
			<span class="blind">자세한 내용은 유의사항을 확인해 주세요!</span>
			<p class="btn_close"><button type="button" onclick="onoff('pop_payback');">닫기</button></p>
		</div>
	</div>
</div>
<div class="com__share_wrap dim" style="z-index:10000;display:none">
	<div class="com__layer share_layer">
		<div class="lay_head">공유하기</div>
		<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
		<div class="lay_inner">
			<ul id="eventShr">
				<li id="fbShare" class="share_fb">페이스북 공유하기</li>
				<li class="share_kakao" id="kakao-link-btn" >카카오톡 공유하기</li>
				<li id="twShare" class="share_tw">트위터 공유하기</li>
			</ul>
			<!-- 메인보내기 버튼클릭시 .mail_on 추가해 주세요 -->
			<div class="btn_wrap">
				<div class="btn_group">
					<!-- 주소복사하기 -->
					<div class="btn_item">
						<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/evt/welcome_event.jsp</span>
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

<div id="eventWrap">
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>


	<div class="toparea">
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
		<div class="section navtab">
			<div class="navtab_inner">
				<ul class="navtab_list">
					<li class="is-on"><a href="#" class="navtab_item--01">웰컴팩</a></li>
					<li><a href="/mobilefirst/evt/new_friend_20179.jsp" class="navtab_item--02">친구초대</a></li>
					<li><a href="/mobilefirst/evt/powerbuy_event.jsp" class="navtab_item--03">파워적립</a></li>
				</ul>
			</div>
		</div>
	</div>
	<%if(numSdt>20201031){ %>
	<div class="section welcome_join">
		<div class="contents">
			<h3><img src="http://img.enuri.info/images/event/2020/buy_first/nov/m_welcome_sec1_tit.png" alt="웰컴백 참여혜택"></h3>
			<div class="info">
				<p class="blind">누구나 웰컴 선물 받고 구매금액 50% 웰컴 페이백! 첫 구매 후 100일간 최대 e머니 7,100점 파워적립까지!</p>
			</div>
		</div>
	</div>
	<%} %>
	<div class="event_gift" id="evt1"> <!-- 이벤트 1 앵커 영역 -->
		<div class="contents">
            <h3><img src="http://img.enuri.info/images/event/2020/buy_first/oct/m_welcome_tit.png" alt="혜택01. 웰컴 선물 - APP 전용"></h3>
            <p class="blind">에누리 가격비교에 오신 것을 환영합니다!</p>

            <div class="gift">
                <p class="blind">
                    WELCOME GIFT : 신규가입 e머니 200점 (※본인인증 필수) 선물 받기
                </p>
                <a href="javascript:void(0);" class="btn btn_gift1">신규가입 e머니200점 선물받기 (※본인인증 필수)</a>

                <p class="blind">
                    WELCOME GIFT : 알림동의 e머니 200점 (※본인인증 필수) 선물 받기
				</p>
				<a href="javascript:void(0);" class="btn btn_gift2">알림동의 e머니200점 선물받기 (※광고/정보알림)</a>

                <a href="javascript:void(0);" class="btn btn_join">회원 가입 버튼</a>
                <a href="javascript:void(0);" class="btn btn_alarm">알림 받기 버튼</a>
            </div>
        </div>

        <!-- 공통 : 꼭 확인하세요  -->
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice btn__white" data-laypop-id="slidePop1"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop1" class="evt_notice--slide">
			<div class="evt_notice--inner"> <!-- .wide - 넓은 케이스 -->
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
                        <h1 class="htit">[신규 가입]</h1>
						<dl>
							<dt>이벤트 대상 및 혜택</dt>
							<dd>
								<ul>
									<li>이벤트 대상 : 이벤트 기간 이후 에누리 가격비교 모바일 앱에서 회원가입한 고객</li>
									<li>이벤트 기간 : 2020년 10월 5일 이후</li>
									<li>이벤트 혜택 : e머니 200점</li>
									<li>혜택 지급일 :&nbsp;신규 가입 선물 받기 시 즉시 적립</li>
									<li>
										<span class="stress">E머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span><br>
										※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.
									</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>이벤트 참여방법 및 유의사항</dt>
							<dd>
								<ul>
									<li>참여방법 : 에누리 가격비교 모바일 앱 → 회원가입 →신규 가입 선물 받기</li>
									<li>본 이벤트는 본인인증 ID당 1회만 참여 가능합니다.</li>
									<li class="stress">본 이벤트는 모바일 앱에서만 참여가 가능한 모바일 앱전용 프로모션 입니다.</li>
									<li>
										<span class="stress">이벤트 대상 제외 :</span> 아래의 경우 본 이벤트 대상에서 제외됩니다.<br>
										<ul class="sub">
											<li>- 회원가입 및 본인인증 하지않은 고객</li>
											<li>- 2020년 10월 5일 이전 회원가입 및 본인인증한 고객</li>
											<li>- PC 및 모바일 웹에서 회원가입 및 본인인증한 고객</li>
											<li>- 동일한 본인인증으로 가입한 다수의 ID로 중복 참여한 경우</li>
										</ul>
									</li>
								</ul>
							</dd>
                        </dl>

                        <h1 class="htit">[알림 동의]</h1>
						<dl>
							<dt>이벤트 대상 및 혜택</dt>
							<dd>
								<ul>
									<li>이벤트 대상 : 이벤트 기간 이후 에누리 가격비교 모바일 앱에서 회원가입 후 알림 동의한 고객</li>
									<li>이벤트 기간 : 2020년 10월 5일 이후</li>
									<li>이벤트 혜택 : e머니 200점</li>
									<li>혜택 지급일 :&nbsp;알림 동의 선물 받기 시 즉시 적립</li>
									<li>
										<span class="stress">E머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span><br>
										※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.
									</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>이벤트 참여방법 및 유의사항</dt>
							<dd>
								<ul>
									<li>참여방법 : 에누리 가격비교 모바일 앱 로그인 → 회원가입 → 광고/정보알림 동의 → 알림 동의 선물 받기</li>
                                    <li>본 이벤트는 본인인증 ID당 1회만 참여 가능합니다.</li>
                                    <li>광고알림 및 정보알림 모두 동의 시에만 참여 가능합니다.</li>
									<li class="stress">본 이벤트는 모바일 앱에서만 참여가 가능한 모바일 앱전용 프로모션 입니다.</li>
									<li>
										<span class="stress">이벤트 대상 제외 :</span> 아래의 경우 본 이벤트 대상에서 제외됩니다.<br>
										<ul class="sub">
											<li>- 회원가입 및 본인인증, 광고/정보 알림 동의하지않은 고객</li>
											<li>- 2020년 10월 5일 이전 회원가입 및 본인인증, 광고/정보 알림 동의한 고객 </li>
                                            <li>- PC 및 모바일 웹에서 회원가입 및 본인인증, 광고/정보 알림 동의한 고객</li>
                                            <li>- 동일한 본인인증으로 가입한 다수의 ID로 중복 참여한 경우 </li>
                                            <li>- 광고알림 또는 정보알림 일부만 동의한 고객</li>
										</ul>
									</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>공통 이벤트 유의사항</dt>
							<dd>
								<ul>
									<li>부정 참여 시 본 이벤트 대상 제외 및 혜택 지급이 취소될 수 있습니다.</li>
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
	<div class="event_payback" id="evt2"> <!-- 이벤트 2 앵커 영역 -->
		<div class="contents">
            <h3><img src="http://img.enuri.info/images/event/2020/buy_first/oct/m_pay_tit.png" alt="혜택02. 웰컴 페이백 - APP 전용"></h3>
            <p class="blind">오직 에누리 가격비교 첫 구매 고객님을 위한!</p>

            <div class="payback">
                <p class="blind">50% 최대 e머니 9500점</p>
            </div>

			<!-- 페이백 신청하기 -->
			<a href="javascript:void(0);" class="btn_payback">첫 구매 페이백 신청하기(※ 첫 구매일로부터 30일 이내 신청 가능)</a>
			<!-- // -->
			<div class="event_noti">
				<div class="noti_cnt">
					<!-- 201015 : 내용 수정 -->
					<ul>
						<%if(numSdt<20201031){ %>
							<li class="stress">※ ID(본인인증), 첫 구매, 웰컴 페이백 신청을 모두 동일한 모바일 기기에서 진행한 경우에만 혜택 지급 가능합니다.</li>
							<li class="stress">※ 모바일 앱에서 1만원 이상 구매 시 참여 가능합니다.</li>
						<%}else{ %>
							<li class="stress">※ 본 이벤트는 ID(본인인증), 첫 구매, 웰컴 페이백 신청을 모두 동일한 모바일 기기에서 진행한 경우에만 혜택 지급 가능합니다.</li>
						<%} %>
						<li class="stress">※ 본 이벤트는 모바일 앱에서만 참여 가능합니다.</li>
						<li class="stress">※ 친구초대 코드등록 및 첫 구매 혜택과 중복 참여 불가합니다.</li>
					</ul>
					<!-- // -->
				</div>
			</div>
		</div>

		<!-- 공통 : 꼭 확인하세요  -->
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop2"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop2" class="evt_notice--slide">
			<div class="evt_notice--inner"> <!-- .wide - 넓은 케이스 -->
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<dl>
							<dt>이벤트 대상 및 혜택</dt>
							<dd>
								<ul>
									<li>이벤트 대상 : 이벤트 기간 이내 에누리 가격비교 모바일 앱에서 1만원 이상 첫 구매한 고객</li>
									<li>이벤트 기간 : 첫 구매일로부터 30일 이내 </li>
									<li>이벤트 혜택 : 구매금액의 50% 페이백 (최대 e9,500점)</li>
									<li>혜택 지급일 : 구매일로부터 최대 30일 이내 적립 (※ 해외직구 상품 구매 시 최대 70일 소요)</li>
									<li>
										<span class="stress">e머니 유효기간 : 적립일로부터 30일 (유효기간 만료 후 재적립 불가)</span><br>
										※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.
									</li>
								</ul>
							</dd>
						</dl>

						<!-- 201015 : 내용 수정 -->
						<dl>
							<dt>이벤트 참여방법 및 유의사항</dt>
							<dd>
								<ul>
									<%if(numSdt<20201101){ %>
										<li>참여방법 : 에누리 가격비교 모바일 앱 로그인 → 적립대상 쇼핑몰 이동 →&nbsp;1만원 이상 구매 → 웰컴 페이백 이벤트 신청</li>
									<%}else{ %>
										<li>참여방법 : 에누리 가격비교 모바일 앱 로그인 → 적립대상 쇼핑몰 이동 →&nbsp;<span class="stress">1만원 이상 구매</span> → 웰컴 페이백 이벤트 신청</li>
									<%} %>
									<li>적립대상 쇼핑몰 : G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, Cjmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 에누리 해외직구관, SK스토아, 홈플러스<br>
										<span class="stress">※ 구매 유의사항 및 구매적립 제외 카테고리는 이벤트 페이지 하단 'e머니 구매혜택' 유의사항을 꼭 확인하세요!</span>
                                    </li>
									<li>본 이벤트는 본인인증 ID당 1회만 참여 가능합니다.</li>
									<%if(numSdt<20201101){ %>
										<li>d본 이벤트는 ID와 구매한 기기 모두 첫 구매일 경우에만 참여 가능합니다.(※ 구매한 모바일 기기에 구매이력 있으면 참여 불가)</li>
									<%}else{ %>
										<li>본 이벤트는 ID(본인인증)와 구매한 모바일 기기 모두 첫 구매일 경우에만 참여 가능합니다. <br>
											<span class="stress">(※ 구매한 모바일 기기에 구매이력 있으면 참여 불가)</span>
										</li>
									<%} %>
									<li>본 이벤트는 본인인증 및 이벤트 정보 활용 동의 후 참여 가능합니다.</li>
									<li class="stress">본 이벤트는 모바일 앱에서만 참여가 가능한 모바일 앱전용 프로모션 입니다.</li>
									<li class="stress">본 이벤트는 ID(본인인증), 첫 구매, 웰컴 페이백 신청을 모두 동일한 모바일 기기에서 진행한 경우에만 혜택 지급 가능합니다.</li>
									<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다.</li>
									<li>
										<span class="stress">이벤트 대상 제외 :</span> 아래의 경우에는 이벤트 대상 및 혜택 지급에서 제외됩니다. <br>
										<ul class="sub">
											<li>- 웰컴 페이백 이벤트 신청하지 않은 경우 </li>
                                            <li>- 실제 구매금액이 1만원 미만의 구매일 경우</li>
                                            <li>- 구매적립 제외 카테고리 구매일 경우 (※ 웰컴 페이백 신청일로부터 30일 이내 재구매 시 혜택 지급 가능)</li>
                                            <li>- 구매 후 취소/환불/교환/반품한 경우 (※ 웰컴 페이백 신청일로부터 30일 이내 재구매 시 혜택 지급 가능)</li>
                                            <li>- 동일한 본인인증으로 가입한 다수의 ID로 중복 참여한 경우</li>
                                            <%if(numSdt<20201101){ %>
												<li class="stress">- 친구초대 첫구매 혜택 받은 고객 (중복 지급 불가)</li>
											<%}else{ %>
												<li class="stress">- 친구초대 코드등록 및 첫 구매 혜택 받은 고객(중복 지급 불가)</li>
											<%} %>
										</ul>
									</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>공통 이벤트 유의사항</dt>
							<dd>
								<ul>
									<li>부정 참여 시 본 이벤트 대상 제외 및 혜택 지급이 취소될 수 있습니다.</li>
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
    <%if(numSdt<20210501){ %>
    <div class="bnr_wrap bnr3">
		<h3 class="blind">APP PUSH 수신 동의 배너</h3>

		<a href="http://www.enuri.com/mobilefirst/evt/apppush_event.jsp" target="_blank" title="새 창에서 열립니다.">[APP전용] 혜택엔 스피드가 생명, 제일 먼저 이벤트 소식 받고 5000원 상품권도 받고!</a>
    </div>
    <%} %>
    <!-- 210518 : 5월 쿠팡배너 추가 -->
	<div class="bnr_wrap bnr3">
		<h3 class="blind">쿠팡 신규회원앱 혜택</h3>

		<a href="http://www.enuri.com/event2021/coupang_evt.jsp" target="_blank" title="새 창에서 열립니다.">신규 회원앱에서 구팡구매하면 최대 5배 적립과 쏟아지는 경품!</a>
	</div>
	<!-- // -->
	<div class="bnr_wrap bnr1">
		<h3 class="blind">구매혜택 배너</h3>
		<a href="http://m.enuri.com/mobilefirst/evt/smart_benefits.jsp" target="_blank" title="새 창에서 열립니다.">구매했다면 스탬프 찍고 추가적립까지! 쇼핑에-누리다 혜택 받기</a>
    </div>
    <div class="bnr_wrap bnr2">
		<h3 class="blind">더많은 이벤트 배너</h3>
		<a href="http://m.enuri.com/mobilefirst/index.jsp#plan" target="_blank" title="새 창에서 열립니다.">놓칠 수 없는 특별한 에누리 혜택, 더 많은 이벤트 혜택 받기</a>
	</div>
	
    <%@ include file="/mobilefirst/evt/event_bottom.jsp"%><!-- 생활혜택 -->
</div>
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script type="text/javascript">
Kakao.init('5cad223fb57213402d8f90de1aa27301');

//공통영역//
var app = getCookie("appYN"); //app인지 여부
var gkind = '<%=strGkind%>'+'';
var gno = '<%=strGno%>'+'';
var vEvent_page = "<%=strUrl%>"; //돌아갈 이벤트페이지주소
var vEvent_title = "앱 2020웰컴 프로모션";
var username = "<%=userArea%>";
var mType = "";// 안드로이드 / 아이폰
var isVersion = <%=isVersion%>;
var sdt = "<%=sdt%>";//오늘날짜
var vChkId = "<%=chkId %>";



var oc = '<%=oc%>';

$(document).ready(function(){
	ga('send', 'pageview', {'page': '/mobilefirst/evt/welcome_event.jsp','title': '웰컴팩_PV'});
	if(oc!=''){
		$('.lay_only_mw').show();
	}

	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
		mType = "I";
	}else if(navigator.userAgent.indexOf("Android") > -1){
		mType = "A";
	}
	$(".keyword").hide();
	$("#my_emoney").click(function(){
		window.location.href = "/my/my_emoney_m.jsp?freetoken=emoney";	//e머니 적립내역
	});
	$(".btn_gift1").click(function(){
		if(app == 'Y'){
			if(!islogin()){
				goLoginPg();
			}else{
				welComeGift(1);
			}
		}else{
			$('.lay_only_mw').show();
		}
	});

	$(".btn_gift2").click(function(){
		if(app == 'Y'){
			if(!islogin()){
				goLoginPg();
			}else{
				welComeGift(2);
			}
		} else{
			$('.lay_only_mw').show();
		}
	});

	$(".btn_join").click(function(){
 		if(app=='Y'){
			if(!islogin()){
				location.href='https://m.enuri.com//member/join/join_bridge.jsp?rtnUrl=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevt%2Fwelcome_event.jsp';
			}else{
				alert("이미 에누리 회원 입니다.\n웰컴 선물 받으셨나요?^^");
				return false;
			}
		}else{
			$('.lay_only_mw').show();
		}
	});
	var isClick = true;
	$(".btn_alarm").click(function(){
		if(app == 'Y'){
			if(!islogin()){
				goLoginPg();
			}else{
				if(isClick){
					$.ajax({
						type: "POST",
						url: "/mobilefirst/evt/ajax/ajax_welcome_upd_alrim.jsp",
						dataType:"JSON",
						success: function(json){
							var result = json.result;
							if(result > 0){
								alert('광고/정보 알림 받기 완료!\n [My에누리>설정]에서 확인 가능합니다!');
							}else if(result == -99){
								alert("본인 인증 후 알림 받기가 가능합니다!");
								var pd = "<%=pd%>";

								if(getCookie("appYN") == "Y"){
									window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&app=Y&freetoken=login_title&pd="+pd);
								}else{
									window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&freetoken=login_title");
								}
								return false;
							}else if ( result== -5 ) {
								alert("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
								location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
							}
							isClick = false;
						}/* ,error:function(request,status,error){
							console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						} */
					});
				}else{
					alert('[My에누리>설정]에서 확인 가능합니다!');
					return false;
				}
			}
		} else{
			$('.lay_only_mw').show();
		}
	});

	$(".btn_payback").click(function(){
		if(app == 'Y'){
			if(!islogin()){
				goLoginPg();
			}else{
				$.ajax({
					type: "POST",
					url: "/mobilefirst/evt/ajax/ajax_welcome.jsp",
					async: false,
					data: { procCode: 3 },
					dataType:"JSON",
					success: function(json){
						var result = json.result;

						if(result == 4){
							onoff('pop_agree');

							// 애드브릭스 적용: 프로모션
							var strEvent = "event_welcome_payback";

							try{
								if(window.android){            // 안드로이드
									//window.android.igaworksEventForApp(strEvent);
									window.android.airbridgeEventForApp(strEvent,"event","welcome","");
								}else{                               // 아이폰에서 호출
									//window.location.href = "enuriappcall://igaworksEventForApp?strEvent="+ strEvent +"";
									window.location.href = "enuriappcall://airbridgeEventForApp?p1="+strEvent+"&p2=event&p3=welcome&p4=";
								}
							}catch(e){}
						}else if ( result== -5 ) {
							alert("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
							location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
						}else if(result == -55){
							alert("잘못된 접근입니다.");
							return false;
						}else if(result == -99){
							alert("본인 인증 후 선물 받기가 가능합니다!");

							var pd = "<%=pd%>";

							if(getCookie("appYN") == "Y"){
								window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&app=Y&freetoken=login_title&pd="+pd);
							}else{
								window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&freetoken=login_title");
							}
							return false;
						}else if(result == -77){
							alert("이미 포인트를 받은 내역이 있습니다!");
							return false;
						}else if(result == 1){
							alert("이미 웰컴 페이백 신청하였습니다.");
							return false;
						}else if(result == 8){
							alert("이미 웰컴 페이백 신청하였습니다!");
							return false;
						}else if(result == 6){
							alert("첫 구매 후 신청해주세요!");
							return false;
						}else if(result == 10 || result == -96 || result == 79){
							alert("아쉽지만 대상자가 아닙니다.");
							return false;
						}else if(result == -91){
							alert("동일 본인인증으로 중복 참여 불가합니다.");
							return false;
						}else if(result == -79){
							alert("친구초대 첫 구매 혜택 이벤트 참여해주세요~!");
							return false;
						}
					}/* ,error:function(request,status,error){
						console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					} */
				});
			}
		}else{
			$('.lay_only_mw').show();
		}
	});
	/*  $("#chkAgree").change(function(){
	        if($("#chkAgree").is(":checked")){
	            alert("체크박스 체크했음!");
	        }else{
	            alert("체크박스 체크 해제!");
	        }
	    }); */
	$(".btn_apply").click(function(){
		var chkYn = $("#chkAgree").is(":checked")
		if(!chkYn){
			alert("이벤트 정보 활용 동의 후 참여 가능합니다.");
			return false;
		}
		$.ajax({
			type: "POST",
			url: "/mobilefirst/evt/ajax/ajax_welcome.jsp",
			async: false,
			data: { procCode: 4 },
			dataType:"JSON",
			success: function(json){
				var result = json.result;
				onoff('pop_agree')
				onoff('pop_payback')
			}
		});

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
function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevt%2Fwelcome_event.jsp";
	if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
		goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/evt/welcome_event.jsp";
		chrome25 = uagentLow.search("chrome") > -1 && navigator.appVersion.match(/Chrome\/\d+.\d+/)[0].split("/")[1] > 25;
		kitkatWebview = uagentLow.indexOf("naver") != -1 || uagentLow.indexOf("daum") != -1;
		setTimeout( function() {
			if (new Date - openAt < 1001) {
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

function install_btt(){
	$('#app_only').hide();
	$('.lay_only_mw').show();
}
function getUserCerti(){ //인증확인
	$.ajax({
		type: "GET",
		url: "/mobilefirst/evt/ajax/ajax_get_certi.jsp",
		dataType: "JSON",
		success: function(json){
			if(json.cikeyCnt < 1 ){
				alert('본인 인증 후 이벤트 참여 가능합니다.');
				var pd = "<%=pd%>";

				if(getCookie("appYN") == "Y"){
					window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&app=Y&freetoken=login_title&pd="+pd);
				}else{
					window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&freetoken=login_title");
				}
				return false;
			}else{
				onoff('pop_agree');
			}
		}
	});
}
function welComeGift(code){
	$.ajax({
		type: "POST",
		url: "/mobilefirst/evt/ajax/ajax_welcome.jsp",
		async: false,
		data: { procCode: code },
		dataType:"JSON",
		success: function(json){
			var result = json.result;
			if ( result== -5 ) {
				alert("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
				location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
			}else if(result == -55){
				alert("잘못된 접근입니다.");
			}else if(result == -99){
				alert("본인 인증 후 선물 받기가 가능합니다!");

				var pd = "<%=pd%>";

				if(getCookie("appYN") == "Y"){
					window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&app=Y&freetoken=login_title&pd="+pd);
				}else{
					window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&freetoken=login_title");
				}
				return false;
			}else if(result == 3){
				alert("e머니 200점 선물 받기 완료!\n 에누리 가격비교에 오신 것을 환영합니다!");
			}else if(result == -1){
				alert("이미 웰컴 선물을 받았습니다.");
				return false;
			}else if(result == -96){
				alert("아쉽지만 대상자가 아닙니다.");
				return false;
			}else if(result == -95){
				alert("알림 동의 후 선물 받기가 가능합니다!");
				return false;
			}else if(result == -91){
				alert("동일 본인인증으로 중복 참여 불가 합니다");
				return false;
			}
		}/* ,
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		} */
	});
}
function goLoginPg(){
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
		location.href = "/mobilefirst/login/login.jsp";
	}else if(navigator.userAgent.indexOf("Android") > -1){
		location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
	}
	return false;
}
(function(){
	if(islogin()){ //로그인상태인 경우 개인e머니 내역 노출
		getPoint();
	}
	//닫기버튼
	 $( ".win_close" ).click(function(){
        if(app == 'Y')  window.location.href = "close://";
        else            window.location.replace("/m/index.jsp");
	});
})();
CmdShare();
function CmdShare(){
	Kakao.Link.createDefaultButton({
	  container: '#kakao-link-btn',
      objectType: 'feed',
      content: {
        title: '<%=strFb_title%>',
        description: "<%=strFb_description%>",
        imageUrl: "<%=strFb_img%>",
			link : {
				webUrl : shareUrl,
				mobileWebUrl : shareUrl
			}
		},
		buttons : [ {
			title : '에누리 가격비교',
			link : {
			mobileWebUrl : shareUrl,
			webUrl : shareUrl
			}
		} ]
	});
}
</script>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</body>
</html>
<script>
var vApp = "<%=strApp%>";
if(vApp == "Y")	{
	// 애드브릭스 적용: 프로모션
	var strEvent = "event_welcome_view";

	try{
		if(window.android){            // 안드로이드
			window.android.airbridgeEventForApp(strEvent,"event","welcome","");
		}else{                               // 아이폰에서 호출
			window.location.href = "enuriappcall://airbridgeEventForApp?p1="+strEvent+"&p2=event&p3=welcome&p4=";
		}
	}catch(e){}
}
</Script>