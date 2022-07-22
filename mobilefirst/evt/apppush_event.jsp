<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
String strFb_title = "[에누리 가격비교] PUSH 알림 혜택";
String strFb_description = "실시간 최저가 정보와 다양한 이벤트 소식 받기!"; 
String strFb_img = "http://img.enuri.info/images/event/2020/apppush/nov/sns_1200_630.jpg";

SimpleDateFormat prevFormat = new SimpleDateFormat("yyyyMMdd");
SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy년 M월 d일");

 if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){

}else{
    response.sendRedirect("http://www.enuri.com/event2020/apppush_event.jsp"); //pc url
    return;
}
long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd"); 
String sdt = dayTime.format(new Date(cTime));//진짜시간

if(  ( request.getServerName().indexOf("m.enuri.com") > -1  ||  request.getServerName().indexOf("dev.enuri.com") > -1  )  
		&& request.getParameter("sdt")!=null && !request.getParameter("sdt").equals("") ) {
	sdt = request.getParameter("sdt");
}

int numSdt = Integer.parseInt(sdt);

boolean isNext = false;
String cssFile = "/css/event/y2021/apppush_apr_m.css";
//String bgImg = "http://imgenuri.enuri.gscdn.com/images/event/2018/buy/dec/m_visual.jpg";
String event_id = "2021040102";
String startDate = "20210401";
String endDate="20210430";
String dday="20210511";

if(numSdt >= 20210501){
	isNext = true;
	cssFile = "/css/event/y2021_rev/apppush_may_m.css";
	event_id = "";
	startDate = "";
	endDate="";
	dday="";
}

String cUserId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");
String chkId = ChkNull.chkStr(request.getParameter("chk_id"));
String strUrl = request.getRequestURI();
String tab = ChkNull.chkStr(request.getParameter("tab"));
String flow = ChkNull.chkStr(request.getParameter("flow"));

String inflowType = ChkNull.chkStr(request.getParameter("inflow"));

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
<meta name="og:title" content="<%=strFb_title%>">
<meta name="og:description" content="<%=strFb_description%>">
<meta name="og:image" content="<%=strFb_img%>">
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
</head>
<body>
<script type="text/javascript">
function adClickGa(){
	if("<%=flow%>" == "sfb")			ga('send', 'event', 'mf_event', 'click','페이스북_유입클릭');	
	else if("<%=flow%>" == "sap")		ga('send', 'event', 'mf_event', 'click','앱설치_유입클릭');
	else if("<%=flow%>" == "sad")		ga('send', 'event', 'mf_event', 'click','검색광고_유입클릭');
}
var shareUrl = "http://" + location.host + "/mobilefirst/evt/apppush_event.jsp?oc=sns";
Kakao.init('5cad223fb57213402d8f90de1aa27301');
</script>
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
						<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/evt/apppush_event.jsp</span>
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
<div id="eventWrap">
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>
	
	<div class="toparea">		
		<!-- 공통 : 상단비주얼 -->
		<div class="visual intro end">
			<!-- 공통 : 공유하기 버튼  -->
			<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
			<!-- // -->
			<div class="inner">
				<span class="txt_01">PUSH 알림 혜택</span>
                <h2>소식에-누리다</h2>
                <span class="txt_02">PUSH 수신 동의하면, 다양한 이벤트와 e머니 혜택의 기회가!</span>
                <div class="box_wrap">
                    <span class="mobile"></span>
                    <span class="bell"></span>
                    <span class="bellbox"></span>
                    <span class="rhand"></span>
                    <span class="lock off"></span>
                    <span class="lock on"></span>
                </div>
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
                    <!-- 선택 : a class="navtab_item--01 is-on" -->
					<li><a href="#evt1" onclick="da_ga(1);" class="navtab_item--01">APP PUSH 혜택 모아보기</a></li>
					<li><a href="#evt2" onclick="da_ga(2);" class="navtab_item--02">e머니 5,000점의 기회</a></li>
					<li><a href="#evt3" onclick="da_ga(3);" class="navtab_item--03">APP PUSH 수신 동의 가이드</a></li>
				</ul>
			</div>
		</div>
		<!-- //탭 -->		
	</div>
	
	<div class="section clear cont1 scroll" id="evt1">
		<div class="contents">
            <h2 class="tit">한 눈에 모아보는 APP PUSH 수신 동의 혜택</h2>
            
            <a href="#notiLayer" onclick="da_ga(4);" class="btn_noti">APP PUSH(앱 푸시)란?</a>

            <!-- 레이어 : 앱 푸시 설명 -->
            <div id="notiLayer" class="notice">
                <div class="notice_inner">
                    <h3>앱 푸시란?</h3>
                    <button type="button" class="btn_cls">닫기</button>
                    
                    <div class="inside">
                        <ul>
                            <li>모바일 앱 메세지를 통해 다양한 가격 정보와 이벤트 소식을 알려드리는 서비스 (1일 1회 발송)</li>
                        </ul>
                    </div>
                </div>
			</div>
			<script>
				$(".btn_noti").on("click", function(){
					var _this = $(this),
						_noti = _this.attr("href");
						
					_this.toggleClass("on");
					$(_noti).fadeToggle();

					$(_noti).find('.btn_cls').on("click", function(){
						$(_noti).hide();					
						_this.removeClass("on");
					})
					return false;
				})
			</script>
            <!-- // -->

			<!-- 앱 푸시 버튼 -->
			<div class="benefits">
                <ul class="benefits_list">
                    <li class="item1">
						<!-- 레이어 열림 : #pushLayer on/off -->
                        <a href="#pushLayer"onclick="da_ga(5);"><span class="img"></span></a>
                    </li>
                    <li class="item2">
                        <a href="#pushLayer"onclick="da_ga(6);"><span class="img"></span></a>
                    </li>
                    <li class="item3">
                        <a href="#pushLayer"onclick="da_ga(7);"><span class="img"></span></a>
                    </li>
                    <li class="item4">
                        <a href="#pushLayer"onclick="da_ga(8);"><span class="img"></span></a>
                    </li>
				</ul>
			</div>
			<!-- // -->
		</div>
	</div>
	
	<div class="section clear cont2 scroll" id="evt2">
		<div class="contents">
			<%if(numSdt>=20210501){ %>
			<p class="blind">COMMING SOON - 더 새로운 이벤트로 돌아옵니다.</p>
			<%}else{ %>
			 <h2 class="tit">APP 전용 - APP PUSH 수신 동의하면? GS 5,000원 상품권이 공짜!</h2>
            <div class="giftbox">
            <%if(numSdt>=20210401){ %>
				<p class="blind">GS25 모바일 상품권 5,000원 100명 추첨</p>
				<ul class="info">
                    <li><strong>대상</strong> APP PUSH 수신 동의 고객</li>
                    <li><strong>기간</strong> 2021. 4. 1 ~ 4. 30</li>
                    <li><strong>발표</strong> 2021. 5. 11</li>
				</ul>

                <a href="javascript:void(0);" id="joinAgree" class="btn_join" >참여하기</a>

            <%}else{ %>
                <p class="blind">GS25 모바일 상품권 5,000원 100명 추첨</p>
				<ul class="info">
                    <li><strong>대상</strong> APP PUSH 수신 동의 고객</li>
                    <li><strong>기간</strong> 2021. 3. 1 ~ 3. 31</li>
                    <li><strong>발표</strong> 2021. 4. 13</li>
				</ul>
                <a href="javascript:void(0);" id="joinAgree" class="btn_join" >참여하기</a>
             <%} %>
            </div>
			<%} %>
        </div>
        
        <!-- 공통 : 꼭 확인하세요  -->
        <%if(numSdt<20210501){ %>
		<div class="com__evt_notice" >
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop1"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 레이어 열기 -->
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
									<li>이벤트 대상 : 앱 PUSH (광고/정보알림) 수신 동의 고객</li>
									<%if(numSdt>=20210401){ %>
                                    <li>이벤트 기간 : 2021년 4월 1일 ~ 4월 30일</li>
                                    <li>이벤트 혜택 : [GS25] 모바일 금액권 5,000원권 (e5,000) - 100명 추첨</li>
                                    <li>당첨자 발표 : 2021년 5월 11일 화요일<br />
                                        <span class="noti">※ Push 메시지로 당첨을 알려 드립니다. (Push 알림 미동의자 제외)</span>
                                    </li>
									<li class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)<br>
										<span class="noti gray">※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</span>
									</li>
									<%}else{ %>
									 <li>이벤트 기간 : 2021년 3월 1일 ~ 3월 31일</li>
                                    <li>이벤트 혜택 : [GS25] 모바일 금액권 5,000원권 (e5,000) - 100명 추첨</li>
                                    <li>당첨자 발표 : 2021년 4월 13일 화요일<br>
                                        <span class="noti">※ Push 메시지로 당첨을 알려 드립니다. (Push 알림 미동의자 제외)</span>
                                    </li>
									<li class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)<br>
										<span class="noti gray">※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</span>
									</li>
									<%} %>
								</ul>
							</dd>
                        </dl>
                        
						<dl>
							<dt>이벤트 참여방법 및 유의사항</dt>
							<dd>
								<ul>
									<li>참여방법 : 에누리 가격비교 모바일 앱 로그인 → 이벤트 참여하기 → 광고알림 및 정보알림 수신 동의 확인하기
										<br>
										<span class="noti">※ 이벤트 참여 시 자동으로 수신 동의 설정 됩니다.</span>
									</li>
									<li>본 이벤트는 본인인증 ID당 1회만 참여 가능합니다.</li>
									<li class="stress">본 이벤트는 모바일 앱에서만 참여가 가능한 모바일 앱 전용 프로모션 입니다.</li>
									<li>
										<span class="stress">이벤트 대상 제외 :</span> 아래의 경우 본 이벤트 대상에서 제외됩니다. <br>
										<ul class="sub">
											<li>- 회원가입 및 본인인증, 광고/정보 알림 동의하지않은 고객</li>
                                            <li>- 동일한 본인인증으로 가입한 다수의 ID로 중복 참여한 경우</li>
                                            <li>- 광고알림 또는 정보알림 일부만 동의한 고객</li>
                                            <li>- 당첨자 발표일 이전에 알림 수신을 해제한 고객</li>
										</ul>
                                    </li>
                                    <li>e쿠폰 스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립 해 드립니다.<br>
                                        <span class="noti">※ 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격 변동이 있을 수 있습니다.</span>
                                    </li>
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
		<%}%>
	</div>
	
	<div class="section clear cont3">
		<div class="contents">
            <h2 class="tit">잠깐! 에누리가 처음이라면? 최대 17,000점! 웰컴팩 받아가세요!</h2>
            <p class="blind">에누리 가격비교 첫 구매 고객님을 위한 이벤트</p>

            <div onclick="da_ga(10);" class="wgift">
                <a href="http://m.enuri.com/mobilefirst/evt/welcome_event.jsp" target="_blank" class="btn_wgift" title="새 창에서 열립니다.">
                    <span class="imgs">신규가입 200점(e머니) - ※본인인증 필수, 알림 동의 200점(e머니) - ※광고/정보알림</span>
                </a>
            </div>
        </div>            
	</div>
	
	<div class="section clear cont4 scroll" id="evt3">
		<div class="contents">
            <h2 class="tit">쉽고 빠르게 소식 받기 APP PUSH 수신 동의 가이드</h2>
            <%if(!"Y".equals(strAppyn)){ %>
            	<button type="button" class="btn_app" onclick="da_ga(11);$('.lay_only_mw').fadeIn(100);">에누리 앱이 없다면? 앱 설치하기</button>
            <%} %>
            <div class="guidebox">
                <div class="swiper-container swiper-container-horizontal">
                    <div class="swiper-wrapper" style="transform: translate3d(-960px, 0px, 0px); transition-duration: 0ms;"><div class="swiper-slide swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="2" style="width: 320px;">
                            <img src="http://img.enuri.info/images/event/2020/apppush/nov/m_cont4_swipe3.png" alt="STEP3 - 광고알림 ON! 정보알림 ON! 수신동의하고 다양한 혜택을 받는다!">
                        </div>
                        <div class="swiper-slide swiper-slide-duplicate-next" data-swiper-slide-index="0" style="width: 320px;">
                            <img src="http://img.enuri.info/images/event/2020/apppush/nov/m_cont4_swipe1.png" alt="STEP1 - 에누리 앱에서 로그인한 뒤 마이페이지로 이동한다.">
                        </div>
                        <div class="swiper-slide swiper-slide-prev" data-swiper-slide-index="1" style="width: 320px;">
                            <img src="http://img.enuri.info/images/event/2020/apppush/nov/m_cont4_swipe2.png" alt="STEP2 - 설정으로 이동한다.">
                        </div>
                        <div class="swiper-slide swiper-slide-active" data-swiper-slide-index="2" style="width: 320px;">
                            <img src="http://img.enuri.info/images/event/2020/apppush/nov/m_cont4_swipe3.png" alt="STEP3 - 광고알림 ON! 정보알림 ON! 수신동의하고 다양한 혜택을 받는다!">
                        </div>
                    <div class="swiper-slide swiper-slide-duplicate swiper-slide-next" data-swiper-slide-index="0" style="width: 320px;">
                            <img src="http://img.enuri.info/images/event/2020/apppush/nov/m_cont4_swipe1.png" alt="STEP1 - 에누리 앱에서 로그인한 뒤 마이페이지로 이동한다.">
                        </div></div>
                </div>
                <div class="swiper-pagination swiper-pagination-clickable swiper-pagination-bullets"><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet swiper-pagination-bullet-active"></span></div>
                <script>
                    $(function(){
                        var mySwiper = new Swiper('.guidebox .swiper-container',{
                            loop : true,
                            autoplay : 3000,
                            speed : 500,
                            pagination : '.guidebox .swiper-pagination',
                            paginationClickable : true
                        });
                    })
                </script>
            </div>

            <p class="noti">※ 알림 설정 후에도 푸시가 오지 않는다면 모바일 [설정]에서<br>[에누리 앱] 알림 허용이 되어 있는지 확인 하시기 바랍니다. </p>
        </div>
    </div>
	
	<div class="otherbene" onclick="da_ga(12);">
		<div class="contents">
			<h3 class="blind">놓칠 수  없는 특별한 혜택, 에누리 혜택</h3>
			<ul class="banlist">
				<li>
					<a href="http://m.enuri.com/mobilefirst/evt/visit_event.jsp" target="_blank" title="새창으로 이동"><img src="http://img.enuri.info/images/event/2021/apppush/may/m_otherbene_bnr1.jpg" alt="100%당첨! 매일 받는 e머니 도전! 프로 출첵러"></a>
				</li>
				<li>
					<a href="http://m.enuri.com/mobilefirst/evt/welcome_event.jsp" target="_blank" title="새창으로 이동"><img src="http://img.enuri.info/images/event/2020/apppush/nov/m_otherbene_bnr2.jpg" alt="에누리가 처음이라면? WELCOME 혜택받기"></a>
				</li>
				<li>
					<a href="http://m.enuri.com/mobilefirst/evt/smart_benefits.jsp" target="_blank" title="새창으로 이동"><img src="http://img.enuri.info/images/event/2020/apppush/nov/m_otherbene_bnr3.jpg" alt="파워적립 받고 e머니 또 받자! 누리팡! 스탬프 혜택받기"></a>
				</li>
				<li>
				<%if(!"Y".equals(strAppyn)){ %>
                	<a href="http://m.enuri.com/m/index.jsp#evt" class="btn_link" target="_blank" title="새 창에서 열립니다."><img src="http://img.enuri.info/images/event/2020/apppush/nov/m_otherbene_bnr4.jpg" alt="더 많은 혜택을 놓치지 마세요! HOT 이벤트 혜택받기"></a>
                <%}else{ %>
                	<a href="http://m.enuri.com/m/index.jsp?freetoken=main_tab|event" class="btn_link" target="_blank" title="새 창에서 열립니다."><img src="http://img.enuri.info/images/event/2020/apppush/nov/m_otherbene_bnr4.jpg" alt="더 많은 혜택을 놓치지 마세요! HOT 이벤트 혜택받기"></a>
                <%}%>
				</li>
			</ul>
		</div>
    </div>
	
</div>
<div id="pushLayer" class="push_layer_wrap dim">
    <div class="push_layer">
        <div class="inner">				
            <div class="item1">
                <p class="txt">다양한 이벤트를 볼 수 있는<br><strong>이벤트혜택</strong>으로 이동하시겠습니까?</p>
                <%if(!"Y".equals(strAppyn)){ %>
                	<a href="http://m.enuri.com/m/index.jsp#evt" class="btn_link" target="_blank" title="새 창에서 열립니다.">이동하기</a>
                <%}else{ %>
                	<a href="http://m.enuri.com/m/index.jsp?freetoken=main_tab|event" class="btn_link" target="_blank" title="새 창에서 열립니다.">이동하기</a>
                <%}%>
            </div>
            <div class="item2">
                <p class="txt">그 상품 지금 얼마지?<br><strong>가격 비교</strong>를 위해 이동하시겠습니까?</p>
                <%if(!"Y".equals(strAppyn)){ %>
                	<a href="http://m.enuri.com/m/index.jsp#trend" class="btn_link" target="_blank" title="새 창에서 열립니다.">이동하기</a>
                <%}else{ %>
                	<a href="http://m.enuri.com/m/index.jsp?freetoken=main_tab|trendpickup" class="btn_link" target="_blank" title="새 창에서 열립니다.">이동하기</a>
                <%}%>
            </div>
            <div class="item3">
                <p class="txt">똑똑하게 쓰는 법! 사는 법!<br><strong>쇼핑지식</strong>으로 먼저 구경하기</p>
                <%if(!"Y".equals(strAppyn)){ %>
                	<a href="http://m.enuri.com/m/index.jsp#know" class="btn_link" target="_blank" title="새 창에서 열립니다.">이동하기</a>
                <%}else{ %>
                	<a href="http://m.enuri.com/knowcom/index.jsp?freetoken=shoppingknow" class="btn_link" target="_blank" title="새 창에서 열립니다.">이동하기</a>
                <%}%>
            </div>
            <div class="item4">
                <p class="txt">지금 트렌디 아이템은?!<br><strong>PICK</strong>으로 기획전 모아보기</p>
                <%if(!"Y".equals(strAppyn)){ %>
                	<a href="/m/pickMain.jsp" class="btn_link" target="_blank" title="새 창에서 열립니다.">이동하기</a>
                <%}else{ %>
                	<a href="http://m.enuri.com/m/pickMain.jsp?freetoken=event" class="btn_link" target="_blank" title="새 창에서 열립니다.">이동하기</a>
                <%}%>
            </div>

            <button type="button" class="btn_cls">닫기</button>
        </div>
    </div>
</div>
<script>
    $(function(){
        //PUSH 혜택 레이어 on/off
        var $itemlist = $(".benefits_list li"),
            $pushLayer = $("#pushLayer");

        $itemlist.on("click", function(){
            var _item = $(this).attr("class");
            
            $pushLayer.fadeIn(100).find("."+_item).show();
            return false;
        });
        $pushLayer.find(".btn_cls, .btn_link").on("click", function(){
            $pushLayer.fadeOut(100).find(".inner > div").fadeOut(100);
        })
    })
</script>
<script type="text/javascript">
//공통영역//
var app = getCookie("appYN"); //app인지 여부

var vEvent_page = "<%=strUrl%>"; //돌아갈 이벤트페이지주소
var vEvent_title = "20년 앱푸시 프로모션";
if(sdt >= 20210101){
	vEvent_title = "21년 앱푸시 프로모션";
}
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
	var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevt%2Fapppush_event.jsp?freetoken=event";
	if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
		goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/evt/apppush_event.jsp?sdt=20201105";
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
function da_ga(tab){
	if(tab==1){
		ga('send', 'event', 'mf_event', '앱푸시', vEvent_title+'상단탭_푸시혜택'); 
	}else if(tab==2){
		ga('send', 'event', 'mf_event', '앱푸시', vEvent_title+'상단탭_푸시이벤트');
	}else if(tab==3){
		ga('send', 'event', 'mf_event', '앱푸시', vEvent_title+'상단탭_가이드');
	}else if(tab==4){
		ga('send', 'event', 'mf_event', '앱푸시', vEvent_title+'푸시혜택_앱푸시란?');
	}else if(tab==5){
		ga('send', 'event', 'mf_event', '앱푸시', vEvent_title+'푸시혜택_이벤트');
	}else if(tab==6){
		ga('send', 'event', 'mf_event', '앱푸시', vEvent_title+'푸시혜택_최저가');
	}else if(tab==7){
		ga('send', 'event', 'mf_event', '앱푸시', vEvent_title+'푸시혜택_쇼핑지식');
	}else if(tab==8){
		ga('send', 'event', 'mf_event', '앱푸시', vEvent_title+'푸시혜택_PICK');
	}else if(tab==9){
		ga('send', 'event', 'mf_event', '앱푸시', vEvent_title+'푸시이벤트_참여하기');
	}else if(tab==10){
		ga('send', 'event', 'mf_event', '앱푸시', vEvent_title+'푸시이벤트_웰컴배너');
	}else if(tab==11){
		ga('send', 'event', 'mf_event', '앱푸시', vEvent_title+'가이드_앱설치하기');
	}else if(tab==12){
		ga('send', 'event', 'mf_event', '앱푸시', vEvent_title+'에누리혜택');
	}
}
$(document).ready(function(){
	ga('send', 'pageview', {'page': '/mobilefirst/evt/apppush_event.jsp', 'title': vEvent_title+'_PV'});
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
		var shareTitle = "<%=strFb_title %> \n <%=strFb_description%>";
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
	
	var loadUrl = '/mobilefirst/evt/ajax/ajax_apppush_chk.jsp'
	$("#joinAgree").click(function(){
		if(sdt >= '20210501'){
			alert("이벤트가 종료되었습니다.");
			return false;
		}else {
			if(app == 'Y'){
				if(!islogin()){
					goLoginPg();
				}else{
					$.ajax({
				        url: loadUrl,
				        contentType: 'application/json; charset=utf-8',
				        data : {
				        	event_id : "<%=event_id%>",
				        	sdt : sdt
				        },
				        dataType: 'text json',
				        cache: false,
				        success: function(data){
				        	da_ga(9);
				        	var result = data.result;
				        	if(result == -1){
				        		alert("수신동의 후 참여해주세요.");
				        		return false;
				        	}else if(result == -99){
				        		alert("임직원은 참여할 수 없습니다.");
				        		return false;
				        	}else if(result == -6){
				        		if(getCookie("appYN") == "Y"){
									window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&app=Y&freetoken=login_title&pd="+pd);
								}else{
									window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&freetoken=login_title");	
								}
				        		return false;
				        	}else if(result == -5){
				        		alert("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
								location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
				        	}else if(result == 3){
				        		alert("광고/정보 알림 받기 완료!\n [My에누리>설정]에서 확인 가능합니다!");
				        		return false;
				        	}else if(result == 0){
				        		alert("이미 참여 하였습니다.");
				        		return false;
				        	}else{
				        		alert(result);
				        	}
				        }/*  ,error:function(request,status,error){   console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); } */ 
				        
					});
				 }
			}else{
				$('.lay_only_mw').show();
			}
		}
		
	});
});
function goLoginPg(){
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
		location.href = "/mobilefirst/login/login.jsp";
	}else if(navigator.userAgent.indexOf("Android") > -1){
		location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
	}
	return false;
}

(function (global, $) {
	$(function () {
		// 해당 섹션으로 스크롤 이동 
		$menu.on('click', 'a', function (e) {
			var $target = $(this).parent(),
				idx = $target.index();			
			if ( idx < $menu.length ){
				var offsetTop = Math.ceil($contents.eq(idx).offset().top);
				$('html, body').stop().animate({ scrollTop: offsetTop - $navheight }, 500);
				return false;
			}
		});
	});

	// 상단 메뉴 스크롤 시, 고정
	var $nav = $('.navtab'),
		$menu = $('.navtab_list li'),
		$contents = $('.scroll'),
		$navheight = $nav.outerHeight(), // 상단 메뉴 높이
		$navtop = Math.ceil($nav.offset().top); // navtab 현재 위치; 

	// menu class 추가 
	$(window).scroll(function () {
		var $scltop = Math.ceil($(window).scrollTop());	// 현재 scroll

		if ($scltop > $navtop) {
			$nav.addClass("is-fixed");
		} else {
			$nav.removeClass("is-fixed");
			$menu.children("a").removeClass('is-on');
		}

		$.each($contents, function (idx, item) {
			var $target = $contents.eq(idx),
				i = $target.index(),
				targetTop = Math.ceil($target.offset().top - $navheight);

			if (targetTop <= $scltop) {
				$menu.children("a").removeClass('is-on');
				$menu.eq(idx).children("a").addClass('is-on');
			}
			if (!($navheight <= $scltop)) {
				$menu.children("a").removeClass('is-on');
			}
		})
	});
}(window, window.jQuery));

// 공통 : 유의사항 레이어 열기/닫기
$(function(){
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
})

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

/* 퍼블테스트 : 레이어 열고 닫기*/
function onoff(id){
	var mid = $("#"+id);
	if(mid.css("display") !== "none"){
		mid.css("display","none");
	}else{
		mid.css("display","");
	}
}


CmdShare();
function CmdShare(){
	Kakao.Link.createDefaultButton({
		  container: '#kakao-link-btn',
	      objectType: 'feed',
	      content: {
	        title: '[에누리 가격비교] PUSH 알림 혜택',
	        description: '푸시 받고 5,000점 받자!\n 최저가 정보와 다양한 이벤트 소식!',
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

function welcomeGa(strEvent){
	if(app == "Y"){
	try{
        if(window.android){            // 안드로이드                  
             window.android.igaworksEventForApp (strEvent);
        }else if(/iPhone|iPad|iPod/i.test(navigator.userAgent)){// 아이폰에서 호출
    		// 아이폰에서 호출
             location.href = "enuriappcall://igaworksEventForApp?strEvent="+strEvent;
        }
	}catch(e){}
	}
}
setTimeout(function(){ welcomeGa("evt_birthday_view"); },500);
</script>
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</body>
</html>