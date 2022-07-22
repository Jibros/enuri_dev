<%@page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page contentType ="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="com.enuri.util.common.ConfigManager"%>
<%
	String strServerNm = request.getServerName();
	String strUserAgent = ChkNull.chkStr(request.getHeader("User-Agent"));
	if(strUserAgent.indexOf("iPhone") > -1 || strUserAgent.indexOf("Android") > -1 || strUserAgent.indexOf("iPod") > -1
			|| strUserAgent.indexOf("iPad") > -1){
	}else{
		response.sendRedirect("http://www.enuri.com/event2021/connShopEvt.jsp");
	}
	String oc = ChkNull.chkStr(request.getParameter("oc"));
	String chkId   = ChkNull.chkStr(request.getParameter("chk_id"),"");
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
	String userNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK"),"");
	
	Members_Proc members_proc = new Members_Proc();
	String userName = members_proc.getUserName(userId);
	String userArea = userName;
	String strUrl = request.getRequestURI();

	if(!userId.equals("")){
	    userName = members_proc.getUserName(userId);
	    userArea = userName;

	    if(userName.equals("")){
	        userArea = userNick;
	    }
	    if(userArea.equals("")){
	        userArea = userId;
	    }
	}
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
<meta charset="utf-8">	
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
<title>[에누리 가격비교] 쇼핑몰 연결하면 에누리가 쏜다!</title>
<meta name="description" content="최저가 에누리 - 가격비교 사이트 에누리닷컴입니다.">
<meta name="keywords" content="휴대폰, 사무, 생활가전, 용품, 영상음향, 컴퓨터, 자동차, 명품, 잡화, 스포츠, 유아, 완구, 가구, 화장품, 식품, 가격비교, 쇼핑몰, 최저가">
<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
<meta property="og:title" content="[에누리 가격비교] 쇼핑몰 연결하면 에누리가 쏜다!">
<meta property="og:description" content="자주 이용하는 쇼핑몰에 연결해 두면, 각종 할인 소식과 구매리포트까지 한 눈에~!">
<meta name="format-detection" content="telephone=no" />
<!-- 프로모션 공통 CSS (Mobile) -->
<link rel="stylesheet" type="text/css" href="/css/swiper.css"/> 
<!-- <link rel="stylesheet" type="text/css" href="/css/rev/common.css"/> reset
<link rel="stylesheet" type="text/css" href="/css/rev/template.css"/> template -->
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
	<!-- 프로모션별 커스텀 CSS  -->
<link rel="stylesheet" href="/css/event/y2021_rev/connect_shop_m.css" type="text/css">
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/js/clipboard.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/event2016/js/event_common.js"></script>
<script>
	var userId = "<%=userId%>";
	var username = "<%=userArea%>"; //개인화영역 이름
	var vChkId = "<%=chkId%>";
	var vEvent_page = "<%=strUrl%>"; //경로
	var ssl = "<%=ConfigManager.ENURI_COM_SSL%>";
</script>
</head>

<body>
<!-- 200825 : SR#41896 : [MO] SNS 공유 딥링크 연결 팝업  -->
<div class="lay_only_mw" id="app_only" style="display:none;" >
	<div class="lay_inner">
		<div class="lay_head">
			앱에서는 득템의 기회 <em>타임특가</em>에 참여할 수 있어요!
		</div>
		<!-- 버튼 : 에누리앱으로 보기 -->
		<button class="btn_go_app">에누리앱으로 보기</button>
		<!-- 버튼 : 모바일웹으로 보기 -->
		<a href="javascript:void(0);" class="btn_keep_mw" onclick="$('.lay_only_mw').fadeOut(100);">괜찮아요. 모바일 웹으로 볼래요</a>
	</div>
</div>
<!-- // -->
<div class="wrap">
	<div class="event_wrap" id="eventWrap">
			<div class="myarea">
				<p class="name">
					나의 <em class="emy">머니</em>는 얼마일까?
					<button type="button" class="btn_login" onclick="goLogin();">로그인</button>
				</p>
				<a href="javascript:///" class="win_close">창닫기</a>
			</div>
	
			<!-- visual -->
			<div class="section visual">
				<div class="visual_obj_list">
					<div class="visual_obj obj_paper"></div>
					<div class="visual_obj obj_coin"></div>
				</div>
				<div class="inner">
					<!-- 공유하기 버튼  -->
					<button class="com__btn_share btn_white" onclick="$('.com__share_wrap').show();">공유하기</button>
					<!-- // -->
					<div class="obj_ticket">
						<span class="txt1">할인 소식과 구매 정보를 쇼핑매니저로 한 눈에!</span>
						<span class="shape_ticket"><img src="//img.enuri.info/images/event/2021/connect_shop/m_visual_ticket.png" alt="쇼핑몰 연결하면 에누리가 쏜다!"></span>
					</div>
					<ul class="move_evt_area">
						<li><a href="#evt1"><img src="//img.enuri.info/images/event/2021/connect_shop/m_visual_evt1.png" alt="이벤트1. 연결 소핑몰당 즉시지급 (e머니:건당 200점)"></a></li>
						<li><a href="#evt2"><img src="//img.enuri.info/images/event/2021/connect_shop/m_visual_evt2.png" alt="이벤트2. 3개 이상 연결 시 신세계 상품권 (e머니:건당 20,000점)"></a></li>
						<li><a href="#evt3"><img src="//img.enuri.info/images/event/2021/connect_shop/m_visual_evt3.png" alt="이벤트3. 5개 이상 연결 시 투썸 케이크 (e머니:건당 35,000점)"></a></li>
					</ul>
				</div>
				<script>
				$(window).on('load', function(){
					var $visual = $(".event_wrap .visual");
					setTimeout(function(){
						$visual.addClass("start");
					},800)
				});
				</script>
			</div>
			<!-- //visual -->
	
			<!-- 이벤트 인트로 -->
			<div class="section" id="evt_intro">
				<div class="inner">
					<div class="tit">쇼핑몰 연결이란?</div>
					<div class="subtit">
						자주이용하는 쇼핑몰에 로그인해주세요<br>
						쇼핑매니저 기능으로 <em>내 구매내역과 할인정보를 한 눈에!</em>
					</div>
					<div class="img_shop_icons"><img src="//img.enuri.info/images/event/2021/connect_shop/m_evtintro_shop_icons.png" alt=""></div>
					<div class="img_benefit_connect">
						<img src="//img.enuri.info/images/event/2021/connect_shop/m_evtintro_benefit1.png" alt="혜택 하나. 구매리포트, 나의 구매내역을 기간별, 쇼핑몰별로 볼수 있어요!">
						<img src="//img.enuri.info/images/event/2021/connect_shop/m_evtintro_benefit2.png" alt="혜택 둘. 혜택리포트, 에누리에서 받은 혜택을 기간별,쇼핑몰별로 볼 수 있어요!">
						<img src="//img.enuri.info/images/event/2021/connect_shop/m_evtintro_benefit3.png" alt="혜택 셋. 카드혜택, 쇼핑몰별, 카드사별 카드 정보 및 할인 정보를 알려드려요!">
					</div>
				</div>
			</div>
			<!-- // 이벤트 인트로 -->
			
			<!-- 쇼핑몰 연결가이드 -->
			<div class="section" id="evt_guide">
				<div class="inner">
					<h3><img src="//img.enuri.info/images/event/2021/connect_shop/m_evtguide_title.png" alt="쇼핑몰 연결가이드"></h3>
					<div class="subtit" id="evt_guide_subtit">
						<span class="txt"><img src="//img.enuri.info/images/event/2021/connect_shop/m_evtguide_subtit.png" alt="에누리 모든혜택! 알차게 누리려면?"></span>
						<a href="javascript:void(0);" onclick="$('#app_only').show();" class="applink_aos" ><img src="//img.enuri.info/images/event/2021/connect_shop/m_evtguide_aos.png" alt="app aos" width="88"></a>
						<span class="bar"></span>
						<a href="javascript:void(0);" onclick="$('#app_only').show();" class="applink_ios"><img src="//img.enuri.info/images/event/2021/connect_shop/m_evtguide_ios.png" alt="app ios" width="82"></a>
					</div>
					<div class="evt_guide_wrap">
						<div class="evt_guide_slide swiper-container">
							<div class="swiper-wrapper">
								<div class="swiper-slide">
									<img src="//img.enuri.info/images/event/2021/connect_shop/m_evtguide_step1.png" alt="STEP1. 에누리 앱에서 접속 또는 로그인 뒤 마이e클럽으로 이동">
								</div>
								<div class="swiper-slide">
									<img src="//img.enuri.info/images/event/2021/connect_shop/m_evtguide_step2.png" alt="STEP2. 쇼핑매니저-쇼핑몰 연결하기를 눌러 쇼핑몰 연결 페이지로 이동">
								</div>
								<div class="swiper-slide">
									<img src="//img.enuri.info/images/event/2021/connect_shop/m_evtguide_step3.png" alt="STEP3. 연결할 쇼핑몰을 선택 후 로그인만 해주면 끝!">
								</div>
							</div>
							<div class="swiper-button-prev btn_prev"></div>
							<div class="swiper-button-next btn_next"></div>
						</div>
						<div class="swiper-pagination"></div>
					</div>
					<script>
						$(function(){
							var mySwiper = new Swiper('.evt_guide_slide',{
								prevButton : '.evt_guide_wrap .swiper-button-prev',
								nextButton : '.evt_guide_wrap .swiper-button-next',
								pagination : '.evt_guide_wrap .swiper-pagination',
								speed : 1000,
								loop : true,
								paginationClickable : true
							})
						})
					</script>
				</div>
			</div>
			<!-- // 쇼핑몰 연결가이드 -->
	
			<!-- 이벤트 상세 -->
			<div class="section" id="evt_detail">
				<div class="inner">
					<div id="evt1"><img src="//img.enuri.info/images/event/2021/connect_shop/m_evtdetail_evt1.png" alt="첫번째이벤트, 쇼핑몰 연결하면 연결수제한없이 200점 즉시 지급 (연결이력이 없는 쇼핑몰 1개당 1회지급, 중복지급불가)"></div>
					<div id="evt2"><img src="//img.enuri.info/images/event/2021/connect_shop/m_evtdetail_evt2.png" alt="두번째이벤트, 쇼핑몰 3개 이상 연결시 신세계이마트상품권 20명 추첨증정 (이벤트 기간 내 연결 이력이 없는 쇼핑몰 3개이상 연결시 자동참여)"></div>
					<div id="evt3"><img src="//img.enuri.info/images/event/2021/connect_shop/m_evtdetail_evt3.png" alt="세번째이벤트, 쇼핑몰 5개 이상 연결시 투썸플레이스 케이크 10명 추첨증정 (이벤트 기간 내 연결 이력이 없는 쇼핑몰 5개이상 연결시 자동참여)"></div>
					
					<div class="evt_period">
						<ul>
							<li>이벤트대상 : 본인인증 한 에누리회원</li>
							<li>이벤트기간 : 2021.11.15 ~ 2021.12.15</li>
							<li>당첨자발표 : 2021.12.23</li>
						</ul>
					</div>
	
					<div class="area_noti">
						<button href="#" class="btn_caution btn__evt_on_slide" data-laypop-id="layPop1">꼭 확인하세요</button>
					</div>
	
					<a href="javascript:void(0);"  class="btn_connect_shop">지금 바로 쇼핑몰 연결하기</a>
				</div>
			</div>
			<!-- // 이벤트 상세 -->
	
			<div id="layPop1" class="evt_slide">
				<div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
					<div class="evt_slide--head">유의사항</div>
					<div class="evt_slide--cont">
						<div class="evt_slide--continner">
							<div class="popup_inner_tit">이벤트 대상 및 혜택</div>
							<ul class="list_dot mb20">
								<li>이벤트 대상 : 에누리 회원 <span class="color-red">※ 본인인증 필수</span></li>
								<li>이벤트 기간 : 2021년 11월 15일 ~ 12월 15일</li>
								<li>혜택 지급일 : 2021년 12월 23일</li>
								<li>이벤트 혜택 : e200점, 신세계이마트 상품권(e20,000) – 20명 추첨, 투썸플레이스 트리플 베리 치즈 무스(e35,000) - 10명 추첨</li>
								<li>e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</li>
							</ul>
							<div class="popup_inner_tit">이벤트 유의사항</div>
							<ul class="list_dot mb20">
								<li>본 이벤트는 특정 버전 이상에서만 참여하실 수 있습니다.(iOS:  /안드로이드:  ) <span class="color-red">※ 업데이트 필요</span></li>
								<li>본 이벤트는 이벤트 기간 중 연결 이력이 없는 쇼핑몰 1개당 1회 지급 됩니다. (중복 지급 불가)</li>
								<li>모바일 앱에서 본인인증 ID로 쇼핑몰에 연결하면 현재 로그인 상태인 ID에 e머니가 적립 됩니다.</li>
								<li>적립된 e머니는 에누리 가격비교 앱에서 1,000여가지 인기 e쿠폰으로 교환 가능합니다.<br>
									※ 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격 변동이 있을 수 있습니다.</li>
								<li>부정 참여 시 본 이벤트 대상 제외 및 혜택 지급이 취소될 수 있습니다.</li>
								<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
							</ul>
						</div>
					</div>
					<div class="evt_notice--foot">
						<button class="btn__evt_off_slide">확인</button> <!-- 닫기 : 레이어 닫기 -->
					</div>
				</div>
				<div class="evt_notice--dimmed"></div> <!-- 닫기 : 레이어 외부 클릭 -->
			</div>
		</div>
	<!-- // 프로모션 -->
<!-- LAYER WRAP -->
	<div class="layerwrap">
	<!-- 공통 : SNS공유하기 -->
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
								<span id="txtURL" class="txt__share_url"></span>
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
		</div>
		<!-- // -->
 	</div>
	<script>
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

		// visual부분 쿠폰클릭시 스크롤이동
		$('.move_evt_area li a').on('click', function(){
			var target = $(this).attr('href');
			var t_pos = $(target).offset().top-20;
			$('html,body').stop().animate({scrollTop:t_pos}, 1000);
			return false;
		});

		// 딤눌러도 닫힘
		$('.popupLayer').on('click',function(){
			var thislayer = $(this).parent();
			thislayer.find('.layclose').trigger('click');
		});

		// 레이어 열닫
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
	</script>
</div> 
<%@ include file="/mobilefirst/event2016/event_footer.jsp"%> 
<!-- // 프로모션 -->
<!-- // -->

<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20200630"></script>
<script type="text/javascript" src="/mobilefirst/event/js/exhibition_m.js"></script>
<script>
$(window).on('load', function(){
    var oc = '<%=oc%>';
    var app = getCookie("appYN"); //app인지 여부
    var userId = "<%=userId%>";
    
	// 앱으로 보기
	$(".btn_go_app").click(function(){
		view_moapp();
	});

 	// 공유하기 링크로 진입 시, 팝업 노출(모웹)
    if(oc == "sns" && app != 'Y'){ //수정
    	$('.lay_only_mw').show();
    }
 	
  	//공유하기
    $(".share_kakao").on('click', function(){
    	shareSns('kakao');
    });
    $(".share_fb").on('click', function(){
    	shareSns('face');
    });
    $(".share_tw").on('click', function(){
    	shareSns('twitter');
    });
/*     $("#pcList").on("click", function(){
    	ga_log(5);
    }); */
    $("#txtURL").text("http://"+location.host+"/mobilefirst/event2021/m_connShopEvt.jsp?oc=sns");
    
    $(".btn_connect_shop").on("click", function(){
    	if (app == "Y") { //쇼핑몰 연결페이지 
    		location.href= "http://"+location.host+"/?freetoken=shoplist";
    	} else {
    		$('#app_only').show();
    	}
    });
    
    if (app == 'Y') {
    	$("#evt_guide_subtit").hide();
    }
});

$(function(){
	var clipboard = new ClipboardJS('.com__share_wrap .btn__share_copy');
	clipboard.on('success', function(e) {
		alert('주소가 복사되었습니다');
	});
	clipboard.on('error', function(e) {
		console.log(e);
	});
});

function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var url = "";
	url = encodeURIComponent("http://" + location.host + "/mobilefirst/event2021/m_connShopEvt.jsp?freetoken=event"); 
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

function shareSns(param){ //수정 
	var share_url = "http://" + location.host + "/mobilefirst/event2021/m_connShopEvt.jsp?oc=sns";
	var share_title = "[에누리 가격비교] 쇼핑몰 연결하면 에누리가 쏜다!";
	var share_description = "자주 이용하는 쇼핑몰에 연결해 두면, 각종 할인 소식과 구매리포트까지 한 눈에~!";
	var imgSNS = "http://img.enuri.info/images/event/2021/connect_shop/sns_800_400.jpg";
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
					imageUrl: "http://img.enuri.info/images/event/2021/connect_shop/sns_1200_630_kakao.jpg",
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
		var share_title_twi = "[에누리 가격비교] 쇼핑몰 연결하면 에누리가 쏜다! 자주 이용하는 쇼핑몰에 연결해 두면, 각종 할인 소식과 구매리포트까지 한 눈에~!";
		window.open("https://twitter.com/intent/tweet?text="+encodeURIComponent(share_title_twi)+"&url="+share_url);
	}
}
</script>
</body>
</html>