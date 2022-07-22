<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%

String strFb_title = "[에누리 가격비교] 겨울, 따뜻한 혜택을 누리다!";
String strFb_description = "매주 수요일 타임특가 놓치지 마세요!";
String strFb_img = ConfigManager.IMG_ENURI_COM+"/images/event/2021/winter_pro/sns_1200_630.jpg";
String strFb_img_ev1 = ConfigManager.IMG_ENURI_COM+"/images/event/2021/winter_pro/sns_1200_630_ev1.png";

String strServerNm = request.getServerName();
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
	if(strServerNm.indexOf("dev.enuri.com") > -1){
		response.sendRedirect("http://dev.enuri.com/event2021/winter_2021_evt.jsp"); //PC경로		
	}else{
		response.sendRedirect("http://www.enuri.com/event2021/winter_2021_evt.jsp"); //PC경로
	}
	return;
}

	String chkId = ChkNull.chkStr(request.getParameter("chk_id"), "");
	String cUserId = ChkNull.chkStr(cb.GetCookie("MEM_INFO", "USER_ID"), "");
	String cUserNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO", "USER_NICK"), "");
	String oc = ChkNull.chkStr(request.getParameter("oc"), "");

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
<meta property="og:title" content="2021 월동준비 통합기획전 – 최저가 쇼핑은 에누리">
<meta property="og:description" content="온 가족 타임특가! 매주 수요일마다 터지는 득템의 기회!">
<META property="og:keywords" content="에누리가격비교, 통합기획전, 겨울용품, 방한용품, 겨울준비, 월동준비, 겨울나기">
<meta property="og:image" content="<%=strFb_img%>">
<meta name="format-detection" content="telephone=no" />
<title>에누리 가격비교 - 최저가 쇼핑은 에누리 가격비교 사이트</title>
<!-- 프로모션 공통 CSS (Mobile) -->
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<!-- 프로모션별 커스텀 CSS  -->
<link rel="stylesheet" href="/css/event/y2021_rev/winter_pro_m.css" type="text/css">
<link rel="stylesheet" type="text/css"	href="/mobilefirst/css/lib/slick.css" />
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
<script type="text/javascript" src="/event2016/js/event_common.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20200630"></script>
</head>
<body>
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

<div class="wrap">
	<div class="event_wrap">
		<div class="myarea">
			<%if(cUserId.equals("")){%>	
				<p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>	
			<%}else{%>
				<p class="name"><%=userArea%> 님<span id="my_emoney">0점</span></p>
			<%}%>
			<a href="javascript:///" class="win_close">창닫기</a>
		</div>

		<!-- 플로팅 배너 - 둥둥이 -->
		<div id="floating_bnr" class="floating_bnr">
			<a href="/mobilefirst/event2021/winter_deal.jsp?tab=03" onclick="da_ga(5);" title="새 창으로 이동합니다."><img src="http://img.enuri.info/images/event/2021/winter_pro/m_fl_bnr.png" alt="월동 준비하고 상품권 득템하자!"></a>
			<!-- 닫기 -->
			<a href="javascript:///" class="btn_close" onclick="onoff('floating_bnr');return false;">
				<span class="blind">닫기</span>
			</a>
		</div>
		<!-- // -->

		<!-- visual -->
		<div class="section visual">
			<div class="visual_obj_list">
				<div class="visual_obj obj_snow1"></div>
				<div class="visual_obj obj_snow2"></div>
				<div class="visual_obj obj_human"></div>
			</div>
			<div class="inner">
				<!-- 200330 추가 : 공통 : 공유하기 버튼  -->
				<button class="com__btn_share btn_white" onclick="$('.com__share_wrap').show();">공유하기</button>
				<!-- // -->
				<div class="react_text_area">
					<span class="txt_01">월동준비</span>
					<span class="txt_02"><span>겨울</span>에-누리다</span>
					<span class="txt_date">2021.11.1 ~ 2021.11.28</span>
				</div>
			</div>
			<script>
				$(window).load(function(){
					var $visual = $(".event_wrap .visual");
					setTimeout(function(){
						$visual.addClass("start");
					},500)
				})
			</script>
		</div>
		<!-- //visual -->

		<!-- 탭 -->
		<div class="section floattab">
			<div class="contents">
				<ul class="floattab__list">
					<li id="tab1"><a href="javascript:;" onclick="da_ga(2);" class="active">군고구마 찾으면<em>라떼당첨!</em></a></li>
					<li><a href="/mobilefirst/event2021/winter_deal.jsp#evt2" onclick="da_ga(3);" class="">매주 수요일 <em>타임특가</em></a></li>
					<li><a href="/mobilefirst/event2021/winter_goods.jsp" onclick="da_ga(4);" class="">따뜻한 겨울을 위한 <em>준비템</em></a></li>
				</ul>
			</div>
		</div>
		<!-- /탭 -->

		<!-- 이벤트01 -->
		<div class="section event_01" id="evt1">
			<div class="inner">
				<h3><img src="//img.enuri.info/images/event/2021/winter_pro/m_evt1_title.png" alt="잘 익은 군고구마를 골라 꺼내주세요, 매일매일 고구마 라떼 당첨"></h3>
				<div class="prize_img"><img src="//img.enuri.info/images/event/2021/winter_pro/m_evt1_obj_prize.png" alt="경품, 투썸플레이스 고구마라떼 e5,200점"></div>

				<!-- 이벤트영역 (고구마) -->
				<div class="game_area_wrap">
					<div class="s_potato">
						<div class="obj_bg">
							<div class="obj_fire"></div>
							<div class="obj_firewood"></div>
						</div>
						<div class="obj_potato">
							<span class="obj_potato1"></span>
							<span class="obj_potato2"></span>
							<span class="obj_potato3"></span>
						</div>
					</div>
					<button type="button" class="btn_play_game"><img src="//img.enuri.info/images/event/2021/winter_pro/m_evt1_play_btn.png" alt="start"></button>
				</div>

				<div class="evt1_sns_share">
					<div class="tit"><img src="//img.enuri.info/images/event/2021/winter_pro/m_evt1_share_txt.png" alt="공유하고 이벤트 한번 더! 참여하세요"></div>
					<ul class="sns_share_list" id="share_list">
						<li><a href=javascript:void(0);" class="btn_fb"><img src="//img.enuri.info/images/event/2021/winter_pro/m_evt1_sns_facebook.png" alt=""><span>페이스북</span></a></li>
						<li id="kakao-link-btn2"><a href="javascript:void(0);" class="btn_ka"><img src="//img.enuri.info/images/event/2021/winter_pro/m_evt1_sns_kakaotalk.png" alt=""><span>카카오톡</span></a></li>
						<li><a href="javascript:void(0);" data-clipboard-text="http://m.enuri.com/mobilefirst/event2021/winter_2021_evt.jsp" class="btn_co"><img src="//img.enuri.info/images/event/2021/winter_pro/m_evt1_sns_url.png" alt=""><span>URL 복사</span></a></li>
					</ul>
				</div>
				<!-- // 이벤트영역 (고구마) -->


				<div class="area_noti">
					<button class="btn_caution btn__evt_on_slide" data-laypop-id="layPop1">꼭! 확인하세요</button>
				</div>
			</div>
		</div>
		<div id="layPop1" class="evt_slide">
			<div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
				<div class="evt_slide--head">유의사항</div>
				<div class="evt_slide--cont">
					<div class="evt_slide--continner">
						<div class="popup_inner_tit">이벤트 기간 및 혜택</div>
						<ul class="list_dot mb20">
							<li>이벤트 참여 : ID당 1일 1회 참여 가능</li>
							<li>이벤트 참여 혜택 : e5,200점 / e5점</li>
							<li>e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</li>
							<li>적립된 e머니는 1,000여가지 인기 e쿠폰으로 교환 가능합니다.</li>
							<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
							<li>부정 참여 시 적립 취소 및 사이트 사용이 제한될 수 있습니다.</li>
						</ul>
					</div>
				</div>
				<div class="evt_notice--foot">
					<button class="btn__evt_off_slide">확인</button> <!-- 닫기 : 레이어 닫기 -->
				</div>
			</div>
			<div class="evt_notice--dimmed"></div> <!-- 닫기 : 레이어 외부 클릭 -->
		</div>

		<!-- 에누리 혜택 -->
		<div class="otherbene">
			<div class="contents">
				<h3><img src="http://img.enuri.info/images/event/2021/winter_pro/m_benefit_tit.png" alt="놓칠 수  없는 특별한 혜택, 에누리 혜택"></h3>
				<ul class="banlist">
					<li>
						<a href="http://m.enuri.com/m/event/welcome.jsp?tab=evt1" onclick="da_ga(8)" target="_blank" title="새창으로 이동">
							<div class="tx1">첫 구매 고객이라면!</div>
							<div class="tx2">50% 웰컴 페이백</div>
							<div class="comm_btn"><img src="//img.enuri.info/images/event/2021/winter_pro/m_other_btn_white.png"></div>
						</a>
					</li>
					<li>
						<a href="http://m.enuri.com/m/event/visit.jsp?oc=#evt1" onclick="da_ga(8)" target="_blank" title="새창으로 이동">
							<div class="tx1">100% 당첨! 매일받는 e머니</div>
							<div class="tx2">도전! 프로출첵러</div>
							<div class="comm_btn"><img src="//img.enuri.info/images/event/2021/winter_pro/m_other_btn_white.png"></div>
						</a>
					</li>
					<li>
						<a href="http://m.enuri.com/m/event/buy_stamp.jsp#tab4" onclick="da_ga(8)" target="_blank" title="새창으로 이동">
							<div class="tx1">받고 또 받고</div>
							<div class="tx2">추가 적립 5만점</div>
							<div class="comm_btn"><img src="//img.enuri.info/images/event/2021/winter_pro/m_other_btn_white.png"></div>
						</a>
					</li>
					<li>
						<a href="http://m.enuri.com/m/index.jsp?freetoken=main_tab|event#evt" onclick="da_ga(8)" target="_blank" title="새창으로 이동">
							<div class="tx1">아직 끝나지 않은 에누리혜택</div>
							<div class="tx2">더 많은 이벤트</div>
							<div class="comm_btn"><img src="//img.enuri.info/images/event/2021/winter_pro/m_other_btn_white.png"></div>
						</a>
					</li>
				</ul>
			</div>
		</div>
		<!-- //에누리 혜택 -->

		<!-- 200330 추가 : 공통 : SNS공유하기 -->
		<div class="com__share_wrap dim" style="z-index:10000;display:none">
			<div class="com__layer share_layer">
				<div class="lay_head">공유하기</div>
				<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
				<div class="lay_inner">
					<ul>
						<li class="share_fb">페이스북 공유하기</li>
						<li class="share_kakao" id="kakao-share-btn">카카오톡 공유하기</li>
						<li class="share_tw">트위터 공유하기</li>
						<!-- <li class="share_line">라인 공유하기</li> -->
						<!-- 메일아이콘 클릭시 활성화(.on) -->
						<!-- <li class="share_mail" onclick="$(this).toggleClass('on');$(this).parents('.share_layer').find('.btn_wrap').toggleClass('mail_on');">메일로 공유하기</li> -->
						<!-- <li class="share_story">카카오스토리 공유하기</li> -->
						<!-- <li class="share_band">밴드 공유하기</li> -->
					</ul>
					<!-- 메인보내기 버튼클릭시 .mail_on 추가해 주세요 -->
					<div class="btn_wrap">
						<div class="btn_group">
							<!-- 주소복사하기 -->
							<div class="btn_item">
								<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2021/winter_2021_evt.jsp?oc=sns</span>
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
		<div  id="play_result" class="pop-layer" style="display:none;">
			<div class="popupLayer">
				<div class="dim"></div>
			</div>
			<!-- popup_box -->
			<div class="popup_box guide">
				<img class="result_img" src="/">
				<a class="btn layclose" href="#" onclick="onoff('#play_result'); return false"><em>팝업 닫기</em></a>
			</div>
			<!-- //popup_box -->
		</div>
		<!-- //당첨 레이어 -->
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
var vServerNm = '<%=strServerNm%>';
var vEvent_title = "21년 월동준비 기획전";
var oc = '<%=oc%>';

function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var url = "";
	url = encodeURIComponent("http://"+location.host+"/mobilefirst/event2021/winter_2021_evt.jsp?freetoken=event");
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
	var $nav = $('.floattab'),
			$menu = $('.floattab__list li'),
			$flyingbnr = $(".floating_bnr"),
			// $contents = $('.scroll'),
			$navheight = $nav.outerHeight(), // 상단 메뉴 높이
			$navtop = Math.ceil($nav.offset().top); // floattab 현재 위치;

	// menu class 추가
	$(window).scroll(function () {
		var $scltop = Math.ceil($(window).scrollTop());	// 현재 scroll

		if ($scltop > $navtop-260) $flyingbnr.addClass("is-fixed")
		else $flyingbnr.removeClass("is-fixed");

		if ($scltop > $navtop) {
			$nav.addClass("is-fixed");
			$(".visual").css("margin-bottom", $navheight);
		} else {
			$nav.removeClass("is-fixed");
			$menu.children("a").removeClass('is-on');
			$(".visual").css("margin-bottom", 0);
		}
	});
	
	var s_potato = {
			el : {
				wrap : $(".s_potato"),
				obj_fire : $(".obj_fire"),
				obj_p : $(".obj_potato > span"),
				btn_start : $(".btn_play_game"),
			},
			chk_member : function(){
				_self = this;
				// 게임시작
				_self.start();
			},
			stop : function() {
				this.el.obj_p.off('click');
			},
			start : function(){
				
				_self = this;
				_self.el.btn_start.fadeOut();
				
				_self.el.obj_p.addClass('action');

				// 불꽃움짤로변경
				_self.el.obj_fire.css('background-image', 'url("//img.enuri.info/images/event/2021/winter_pro/obj_fire.gif")');
				
				_self.el.obj_p.off().on('click', function(e){
					var vResult =0 ; // 버튼클릭시 넘버생성
					var vImageIdx = 0;
					getEventAjaxData({"procCode":1} ,function(data){
						vResult = data.result;
						if(vResult == -1 || vResult == -10){
							alert("이미 참여하셨습니다. 내일 또 참여해주세요!");
							_self.stop();
						}else if(vResult == -2 || vResult == -99){
							alert("임직원은 참여 불가합니다.");
						}else if(vResult == -55){
							alert("잘못된 접근입니다.");
						}else if(vResult==5){
							vImageIdx = (Math.floor(Math.random() * 1))+1;
						}else if(vResult==5200){
							vImageIdx = 3;
						}
						if(vImageIdx > 0){
							// 1번 : 땡, 탄고구마
							// 2번 : 떙, 덜익음
							// 3번 : 당첨
							$("#play_result .result_img").attr('src','//img.enuri.info/images/event/2021/winter_pro/potato_result_'+ vImageIdx +'.jpg?v=3');
							$(this).addClass('active');
							// 결과팝업 띄움
							setTimeout(function(){
									onoff('#play_result');
							},1000);
						
						}
						_self.el.obj_p.removeClass('action');
					});

					// 클릭이벤트제거
					_self.stop();

					// 불꽃기본이미지로변경
					_self.el.obj_fire.css('background-image', 'url("//img.enuri.info/images/event/2021/winter_pro/obj_fire.jpg")');

				});
			},
			restart : function(){
				this.el.obj_p.removeClass('active');
				this.start();
			}
		}
		// 클릭시 멤버체크후 플레이 실행
		$(".btn_play_game").on('click', function(){
			s_potato.chk_member();
		});
}(window, window.jQuery));

// 유의사항 열기/닫기
$(function(){
	var el = {
		btnSlide: $(".btn__evt_on_slide"), // 열기 버튼
		btnSlideClose : $(".btn__evt_off_slide") // 닫기 버튼
	}
	el.btnSlide.click(function(){ // 슬라이드 유의사항 열기
		$(this).toggleClass('on');
		$("#"+$(this).attr("data-laypop-id")).slideToggle();
	})
	el.btnSlideClose.click(function(){ // 슬라이드 유의사항 닫기
		var thisClosest = $(this).closest('.evt_slide')
		$(thisClosest).slideToggle();
		$('html,body').stop(0).animate({scrollTop:$(thisClosest).siblings(".com__evt_notice").offset().top - 50});
	})
})

/*레이어*/
function onoff(id) {
	var mid = $(id);
	var cont = mid.find('.popup_box');
	if(mid.css("display") === 'none') {
		mid.css('display','block');
		cont.css('margin-top',  (-1 * (cont.height() / 2)) );
	}else{
		mid.css('display','none');
	}
}

var userId = "<%=cUserId%>";
$(document).ready(function() {
	
	$("#tab1").click(function(){
		$('html, body').stop().animate({scrollTop: Math.ceil($('#evt1').offset().top - 50 - $(".navtab").outerHeight())}, 0);
	});
	
	if(oc!=""){
		$('.lay_only_mw').show();
	}
	$("#my_emoney").click(function(){	
		window.location.href = "https://m.enuri.com/my/my_emoney_m.jsp?freetoken=emoney";	//e머니 적립내역
	});
	
	ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_PV");
	
	if(tab == '01'){
		$('html, body').stop().animate({scrollTop: Math.ceil($('#evt1').offset().top- $(".navtab").outerHeight())}, 0);
	}
	
	// 개인정보 불러오기
	$("body").append("<iframe id='iframeField'></iframe>");
	$("#iframeField").hide();
	
	//#애드브릭스
	setTimeout(function(){
		welcomeGa("evt_winter2021_view");
	},500);
	
	global_share('kakao');
	shareSns("kakao");
	
	if(islogin()){
		getPoint();
	}
});

function da_ga(num){
	if(num == 2){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_단순참여 이벤트");
	}else if(num == 3){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_타임딜");
	}else if(num == 4){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_기획전");
	}else if(num == 5){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_상단플로팅배너");
	}else if(num == 6){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_참여이벤트_참여");
	}else if(num == 7){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_참여이벤트_공유하기");
	}else if(num == 8){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_혜택배너");
	}
}

var isClick = true;

var sdt = "<%=strToday%>";
function getEventAjaxData(params, callback){
	
   if(sdt > '20211128'){
		alert("이벤트가 종료되었습니다.");
		return false;
   }else if(sdt < '20211101'){
	   alert("이벤트기간이 아닙니다.");
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
			da_ga(6);
			
			var evtUrl = "/mobilefirst/evt/ajax/winter2021_setlist.jsp";
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

//공유하기
$(".share_kakao").on('click', function(){
	global_share('kakao');
});
$(".share_fb").on('click', function(){
	global_share('face');
});
$(".share_tw").on('click', function(){
	global_share('twitter');
});

//sns 공유하기 함수
function global_share(param){ //수정
	var share_url = "http://" + location.host + "/mobilefirst/event2021/winter_2021_evt.jsp?oc=sns";
	var share_title = "[에누리 가격비교] 겨울, 따뜻한 혜택을 누리다!";
	var share_description = "온 가족 타임특가! 매주 수요일마다 터지는 득템의 기회!";
	var imgSNS = "<%=strFb_img%>";
	if(param == "face"){
		try{
			window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
			//ga("send", "event", "mf_event", vEvent_title +"_APP", "공유하기_페이스북");
		}catch(e){
			window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
			//ga("send", "event", "mf_event", vEvent_title +"_WEB", "공유하기_페이스북");
		}
	}else if(param == "kakao"){
		try{
			Kakao.Link.createDefaultButton({
				container: '#kakao-share-btn',
				objectType: 'feed',
				content: {
					title: share_title,
					imageUrl: imgSNS,
					description : share_description,
					link: {
						mobileWebUrl: share_url,
					}
				},
				buttons: [
				{
					title: '상세정보 보기',
					link: {
						mobileWebUrl: share_url,
					}
				}
				]
			});
		}catch(e){
			alert("카카오 톡이 설치 되지 않았습니다.");
			alert(e.message);
		}
	}else if(param == "twitter"){
		var share_title_twi = "[에누리 가격비교] 겨울, 따뜻한 혜택을 누리다! 매주 수요일 타임특가도 만나보세요!";
		window.open("https://twitter.com/intent/tweet?text="+encodeURIComponent(share_title_twi)+"&url="+share_url);
	}
}

//공유하기 이벤트
$("#share_list li").unbind();
$("#share_list li").click(function(){
	if(islogin()){
		var n = $(this).index()+1;
		shareEvent(n);
	}else{
		alert("로그인 후 참여할 수 있습니다.");
		goLogin();
		shareSns("kakao");
		return ;
	}
});

//공유하기evt
function shareEvent(n){
	da_ga(7);
	var shareType = n;
	if(n==1) {
		shareSns("face");
	}else if(n==3) {
		if(ClipboardJS.isSupported()) {
			var clipboard = new ClipboardJS('#share_list .btn_co');
			var cnt = 0;
			clipboard.on('success', function(e) {
				if(cnt==0) alert("복사가 완료되었습니다!");
				cnt++;
			}).on('error', function(e) {
				alert("해당 브라우저는 지원하지 않습니다.");
			});
		}
	}
}

function shareSns(param){
	var share_url2 = "http://" + location.host + "/mobilefirst/event2021/winter_2021_evt.jsp?oc=sns#evt1";
	var share_title2 = "[에누리 가격비교] 매일매일 100% 당첨! 군고구마 굽고 간식 받아가세요~";
	var imgSNS2 = "<%=strFb_img_ev1%>";

	if(param == "face"){
		try{
			window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title2)+"&u="+share_url2);
			//ga("send", "event", "mf_event", vEvent_title +"_APP", "공유하기_페이스북");
		}catch(e){
			window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title2)+"&u="+share_url2);
			//ga("send", "event", "mf_event", vEvent_title +"_WEB", "공유하기_페이스북");
		}
	}else if(param == "kakao"){
		try{
			Kakao.Link.createDefaultButton({
				container: '#kakao-link-btn2',
				objectType: 'feed',
				content: {
					title: share_title2,
					imageUrl: imgSNS2,
					link: {
						webUrl: share_url2,
						mobileWebUrl: share_url2
					}
				},
				buttons: [
				{
					title: '상세정보 보기',
					link: {
						webUrl: share_url2,
						mobileWebUrl: share_url2
					}
				}
				]
			});
		}catch(e){
			alert("카카오 톡이 설치 되지 않았습니다.");
			alert(e.message);
		}
	}else if(param == "twitter"){
		var share_title_twi = "[에누리 가격비교] 매일매일 100% 당첨! 군고구마 굽고 간식 받아가세요~";
		window.open("https://twitter.com/intent/tweet?text="+share_title_twi+"&url="+share_url2);
	}
}
//닫기버튼
$('.win_close').click(function(){
	if(getCookie("appYN") == 'Y'){
		window.location.href = "close://";
	}else{
		window.location.replace("/m/index.jsp");
	}
});

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
</script>
</body>
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>