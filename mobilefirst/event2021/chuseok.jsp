<%@page contentType="text/html; charset=utf-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="java.util.*,java.text.*,java.net.*"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.bean.main.Member_Point_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<jsp:useBean id="Members_Data" class="com.enuri.bean.knowbox.Members_Data" scope="page" />
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc" scope="page" />
<jsp:useBean id="Member_Point_Proc" class="com.enuri.bean.main.Member_Point_Proc" scope="page" />
<%@ include file="/common/jsp/COMMON_CONST_TOP.jsp"%>
<%@ include file="/event/common/include/event_common.jsp"%>
<%
	String strFb_title = "2021 추석 통합 기획전 – 최저가 쇼핑은 에누리";
	String strFb_description = "한가위에-누리다! 매주 수요일 타임특가 놓치지 마세요!";
	String strFb_Image = ConfigManager.IMG_ENURI_COM + "/images/event/2021/chuseok/sns_1200_630.jpg";
	// #. 모바일 기기 접속 시 접속 페이지 변경
	
	if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
	}else{
		response.sendRedirect("/event2021/chuseok.jsp?oc=sns");
		return;
	}
		
	String strApp = ChkNull.chkStr(request.getParameter("app"),"");
	String strOc = ChkNull.chkStr(request.getParameter("oc"),"");
	String bannerOn = "";

	Cookie[] carr = request.getCookies();
	if(carr != null){
		for(int i=0;i<carr.length;i++){
			if(carr[i].getName().equals("appYN")){
			strApp = carr[i].getValue();
			break;
			}
		}
	}
%>
<!doctype html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<meta name="description" content="<%=strFb_description%>">
	<meta name="keywords" content="에누리가격비교, 에누리, 이벤트, 기획전, 타임특가, 명절, 추석, 한가위, 타임특가, 추석선물 ">
	<meta property="og:title" content="<%=strFb_title%>">
	<meta property="og:description" content="<%=strFb_description%>">
	<meta property="og:image" content="<%=strFb_Image%>">	
	<meta property="og:url" content="http://m.enuri.com/mobilefirst/event2021/chuseok.jsp">
	<link rel="shortcut icon" href="http://img.enuri.info/2014/layout/favicon_enuri.ico">
	<title><%=strFb_title%></title>
	<link rel="stylesheet" href="/css/slick.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
	<link rel="stylesheet" type="text/css" href="/css/rev/common.css"/> <!-- reset -->
	<link rel="stylesheet" type="text/css" href="/css/rev/template.css"/> <!-- template -->
	<!-- 프로모션 공통 CSS (Mobile) -->
	<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
	<!-- 프로모션별 커스텀 CSS  -->
	<link rel="stylesheet" href="/css/event/y2021_rev/chuseok_pro_m.css" type="text/css">
	<script type="text/javascript" src="/common/js/lib/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="/js/swiper.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
	<script type="text/javascript" src="/m/event/common/js/event_common.js"></script>
	<script type="text/javascript" src="/js/clipboard.min.js"></script>

</head>
<body>
	<%if(!strApp.equals("Y") && strOc.equals("sns")){%>
	<div class="lay_only_mw">
		<div class="lay_inner">
			<div class="lay_head">
				더 다양한 <em>이벤트 혜택</em>을 누리고 싶다면?
			</div>
			<!-- 버튼 : 에누리앱으로 보기 -->
			<button class="btn_go_app" onclick="view_moapp();">에누리앱으로 보기</button>
			<!-- 버튼 : 모바일웹으로 보기 -->
			<a href="javascript:void(0);" class="btn_keep_mw" onclick="$('.lay_only_mw').fadeOut(100);">괜찮아요. 모바일 웹으로 볼래요</a>
		</div>
	</div>
	<%}%>
	<div class="event_wrap">
		<!-- 개인화영역 -->
		<%@include file="/m/event/common/include/event_emoney.jsp"%>
		<!-- //개인화영역 -->
		<!-- 플로팅 배너 - 둥둥이 -->
		<div id="floating_bnr" class="floating_bnr">
			<a href="/mobilefirst/event2021/chuseok_deal.jsp?tab=03" ><img src="http://img.enuri.info/images/event/2021/chuseok/fl_bnr.png" alt="추석준비하고 횡성한우세트 받자!"></a>
			<!-- 닫기 -->
			<a href="javascript:void(0);" class="btn_close" onclick="onoff('floating_bnr');return false;">
				<span class="blind">닫기</span>
			</a>
		</div>
		<!-- // -->

		<!-- visual -->
		<div class="section visual">
			<div class="inner">
				<div class="visual_obj_list">
					<div class="visual_obj obj_moon"></div>
					<div class="visual_obj animated obj_shooting_star1"></div>
					<div class="visual_obj animated obj_shooting_star2"></div>
					<div class="visual_obj animated obj_shooting_star3"></div>
					<div class="visual_obj animated obj_shooting_star4"></div>
					<div class="visual_obj animated obj_shooting_star5"></div>
				</div>

				<!-- 200330 추가 : 공통 : 공유하기 버튼  -->
				<button class="com__btn_share btn_white" onclick="$('.com__share_wrap').show();share_kakao();">공유하기</button>
				<!-- // -->
				<div class="react_text_area">
					<span class="txt_01">건강한 2021 추석 보내세요!</span>
					<span class="txt_02"><span>한가위</span> 에-누리다</span>
					<span class="txt_date">2021.08.23 ~ 2021.09.22</span>
				</div>
			</div>
		</div>
		<!-- //visual -->

		<!-- 탭 -->
		<div class="section floattab">
			<div class="contents">
				<ul class="floattab__list">
					<li><a href="/mobilefirst/event2021/chuseok.jsp" class="active">매일매일<em>윷놀이</em></a></li>
					<li><a href="/mobilefirst/event2021/chuseok_deal.jsp" class="">매주 수요일<em>타임특가</em></a></li>
					<li><a href="/mobilefirst/event2021/chuseok_evt.jsp" class="">풍요로운<em>추석 기획전</em></a></li>
				</ul>
			</div>
		</div>
		<!-- /탭 -->

		<!-- 이벤트01 -->
		<div class="section event_01">
			<img src="http://img.enuri.info/images/event/2021/chuseok/mobile/m_evt1_obj_bar.png" class="obj_bar">
			<div class="inner">
				<h3><img src="http://img.enuri.info/images/event/2021/chuseok/mobile/m_evt1_title.png" alt="신나게 윷을 던져주이소. 매일매일 윷놀이!"></h3>
				<div class="prize_img"><img src="http://img.enuri.info/images/event/2021/chuseok/mobile/m_evt1_obj_prize.png"></div>

				<div class="game_area_wrap">
					<div class="game_area">
						<img src="http://img.enuri.info/images/event/2021/chuseok/mobile/game_img1.png">
					</div>
					<button type="button" class="btn_play_game"><img src="http://img.enuri.info/images/event/2021/chuseok/mobile/m_evt1_play_btn.png"></button>
				</div>
				<div class="evt1_con_txt">
					<img src="http://img.enuri.info/images/event/2021/chuseok/mobile/m_evt1_txt.png" alt="에누리에 처음 오셨다면? 당첨기회를 한 번 더! 신나게X2 윷을 던져주이소! ※ 21년 8월 23일 00시 이후 신규 가입 고객 대상">
				</div>
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
							<li>이벤트 기간 : 2021년 8월 23일(월) ~ 2021년 9월 22일(수)</li>
							<li>이벤트 혜택 :
								<div class="color-red">
									※ 실물 경품의 경우 2021년 11월 4일 당첨자 개별 연락 후 일괄 배송됩니다. 3회 이상 통화 시도에도 연락이 되지 않을 경우 경품 수령 불이익은 책임지지 않습니다. (e머니의 경우 당첨 즉시 적립)
								</div>
								<ul class="list_hyphen">
									<li>모 : 정관장 홍삼원 50ml [30포,2박스] (실물경품) – 3명 당첨</li>
									<li>윷 : [BBQ] 황금올리브치킨+콜라 1.25L (e머니 20,000점) – 5명 당첨</li>
									<li>걸 : [파리바게뜨] 푸짐한 빵선물 세트 (e머니 11,100점) – 50명 당첨
									<li>개 : [CU] 광동)비타500병180ml (e머니 1,300점) – 200명 당첨</li>
									<li>도 : e머니 100점 – 500명 당첨</li>
									<li>빽도 : 꽝</li>
								</ul>
							</li>
							<li>
								<div class="color-red">
									e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)
								</div>
								※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환 가능합니다.
							</li>
						</ul>
						<div class="popup_inner_tit">이벤트 유의사항</div>
						<ul class="list_dot">
							<li>본 이벤트는 ID당 1일 1회 참여 가능합니다.<br>
								<div class="color-red">※ 21년 8월 23일 00시 이후 신규 가입 고객의 경우 ID당 1일 2회 참여 가능합니다.</div>
							</li>
							<li>이벤트 참여 시 개인 정보 수집에 동의하신 것으로 간주됩니다.</li>
							<li>개인 정보 수집자(에누리 가격비교)는 이벤트의 원활한 진행을 위해 이벤트 기간 동안 당첨자의 참여 일시, 참여자 ID, 본인인증 확인(CI, DI)가 수집하며, 이벤트 참여 확인을 위한 본인 확인 이외의 목적으로 활용되지 않습니다. 수집된 정보는 이벤트 당첨자 발표 후 개인 정보를 즉시 파기합니다.</li>
							<li>부정 참여 시 본 이벤트 대상 제외 및 혜택 지급이 취소될 수 있습니다.</li>
							<li>본 이벤트는 당사 사정에 따라 사전 고지 없이 변경 또는 종료될 수 있습니다.</li>
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
				<h3><img src="http://img.enuri.info/images/event/2021/chuseok/mobile/m_benefit_tit.png" alt="놓칠 수  없는 특별한 혜택, 에누리 혜택"></h3>
				<ul class="banlist">
					<li>
						<a href="http://m.enuri.com/m/event/welcome.jsp " target="_blank" title="새창으로 이동">
							<div class="tx1">첫 구매 고객이라면!</div>
							<div class="tx2">WELCOME 혜택</div>
							<div class="comm_btn"><img src="http://img.enuri.info/images/event/2021/chuseok/mobile/m_other_btn.png"></div>
						</a>
					</li>
					<li>
						<a href="http://m.enuri.com/m/event/visit.jsp?oc=#evt1" target="_blank" title="새창으로 이동">
							<div class="tx1">100% 당첨! 매일받는 e머니</div>
							<div class="tx2">도전! 프로출첵러</div>
							<div class="comm_btn"><img src="http://img.enuri.info/images/event/2021/chuseok/mobile/m_other_btn.png"></div>
						</a>
					</li>
					<li>
						<a href="http://m.enuri.com/m/event/buy_stamp.jsp#tab4" target="_blank" title="새창으로 이동">
							<div class="tx1">받고 또 받는 카테고리 혜택</div>
							<div class="tx2">추가 적립 5만점</div>
							<div class="comm_btn"><img src="http://img.enuri.info/images/event/2021/chuseok/mobile/m_other_btn.png"></div>
						</a>
					</li>
					<li>
						<a href="/mobilefirst/plan_event.jsp?freetoken=main_tab|event" target="_blank" title="새창으로 이동">
							<div class="tx1">끝나지 않은 에누리 혜택</div>
							<div class="tx2">더 많은 이벤트</div>
							<div class="comm_btn"><img src="http://img.enuri.info/images/event/2021/chuseok/mobile/m_other_btn.png"></div>
						</a>
					</li>
				</ul>
			</div>
		</div>
		<!-- //에누리 혜택 -->

		<div class="com__share_wrap dim" style="z-index: 10000;display:none">
			<div class="com__layer share_layer">
				<div class="lay_head">공유하기</div>
				<a href="javascript:void(0);" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
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
								<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2021/chuseok.jsp?oc=sns</span>
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
		</div>
	</div>
	<!-- // 프로모션 -->
	<!-- // 프로모션 -->
	<div class="layerwrap">
		<!-- 딤레이어 : 모바일 앱 전용 이벤트 당첨!!-->
		<div  id="play_result" class="pop-layer" style="display:none;">
			<div class="popupLayer">
				<div class="dim"></div>
			</div>
			<!-- popup_box -->
			<div class="popup_box guide">
				<img class="result_img" src="/">
				<a class="btn layclose" href="javascript:void(0);" onclick="onoff('play_result'); $('.btn_play_game').fadeIn(); return false"><em>팝업 닫기</em></a>
			</div>
			<!-- //popup_box -->
		</div>
	</div>
	<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>

	<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
	<script>
	var share_url = "http://" + location.host + "/mobilefirst/event2021/chuseok.jsp?oc=sns";
	var share_title = "<%=strFb_title%>";
	var share_description = "한가위에-누리다!매주 수요일 타임특가 놓치지 마세요!";
	var share_image = "http://img.enuri.info/images/event/2021/chuseok/sns_1200_630.jpg";
	var sdt = "<%=TODAY%>";
	var APPYN = "<%=strApp%>"; //app인지 여부
	var isClick = true;
	Kakao.init('5cad223fb57213402d8f90de1aa27301');

	ga('send', 'pageview', {	    'page': location.pathname,	    'title': "21년 추석 기획전_PV"	});

	$(window).load(function(){
		
		var $visual = $(".event_wrap .visual");
		setTimeout(function(){
			$visual.addClass("start");
		},500);

	})
		
	$(document).ready(function(){

		// 상단 메뉴 스크롤 시, 고정
		var $nav = $('.floattab'),
				$menu = $('.floattab__list li'),
				$flyingbnr = $(".floating_bnr"),
				// $contents = $('.scroll'),
				$navheight = $nav.outerHeight(), // 상단 메뉴 높이
				$navtop = Math.ceil($nav.offset().top); // floattab 현재 위치;
		$menu.click(function(){
			if($(this).index()==0){
				ga('send', 'event', 'mf_event', "21년 추석 기획전", "21년 추석 기획전_상단탭_단순참여 이벤트" );
			}else if($(this).index()==1){
				ga('send', 'event', 'mf_event', "21년 추석 기획전", "21년 추석 기획전_상단탭_타임딜" );
			}else if($(this).index()==2){
				ga('send', 'event', 'mf_event', "21년 추석 기획전", "21년 추석 기획전_상단탭_기획전" );
			}
		});
		$("#floating_bnr a").click(function(){
			ga('send', 'event', 'mf_event', "21년 추석 기획전", "21년 추석 기획전_상단플로팅배너" );
		})
		$(".otherbene .banlist li").click(function(){
			ga('send', 'event', 'mf_event', "21년 추석 기획전", "21년 추석 기획전_혜택배너" );
		});
		
		$('.btn_play_game').on('click', function(){
			if(!islogin()){
				alert("로그인 후 이용 가능합니다.");
				goLogin();
				return false;
			}else if(sdt < "20210823"){
				alert('오픈예정입니다.');
				return false;
			}else if(sdt > "20210922"){
				alert('이벤트 종료! 다음 이벤트를 기대해주세요');
				return false;
			}else{
				if(!getSnsCheck()){
					if (confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?") == true){    
						location.href="<%=ConfigManager.ENURI_COM_SSL%>/mobilefirst/member/myAuth.jsp?cmdType=modify&f=p";
					}else{
						return false;
					}
				}else{
					var vResult = 0; // 버튼클릭시 넘버생성
					var vImageIdx = 0;
					var i = 0;
					ga('send', 'event', 'mf_event', "21년 추석 기획전", "21년 추석 기획전_참여이벤트_참여" );
					$(this).fadeOut(); // 해당버튼 제거 (상품이미지 팝업 다시 출력)
					var chain_img = setInterval(function(){
						i++;
						$('.game_area img').attr('src', 'http://img.enuri.info/images/event/2021/chuseok/game_img'+ i +'.png?v=2'); // 연결이미지
						if(i===12) {
							getEventAjaxData({"procCode":1} ,function(data){
								vResult = data.result;
								if(vResult == -1 || vResult == -10){
									alert("오늘의 윷놀이 끝! 내일 또 윷을 던져주세요!");
									return;
								}else if(vResult == -2 || vResult == -99){
									alert("임직원은 참여 불가합니다.");
									return;
								}else if(vResult == -55){
									alert("잘못된 접근입니다.");
									return;
								}else if(vResult==1){
									vImageIdx = 5;
								}else if(vResult==20000){
									vImageIdx = 4;
								}else if(vResult==11100){
									vImageIdx = 3;
								}else if(vResult==1300){
									vImageIdx = 2;
								}else if(vResult==100){
									vImageIdx = 1;
								}else{
									vImageIdx = 6;
								}
								
								if(vImageIdx > 0){
									$('.result_img').attr('src',"http://img.enuri.info/images/event/2021/chuseok/result"+vImageIdx+"_prize.jpg") // 상품이미지 적용		
									$('.game_area img').attr('src', 'http://img.enuri.info/images/event/2021/chuseok/result'+ vImageIdx +'.png?v=2');// 결과이미지 적용
									setTimeout(function(){
										onoff('play_result'); // 상품팝업출력
									},300);
								}
							});
							clearInterval(chain_img); // 인터벌제거
						}
					},200)
				}
			}
		});
		$("#eventShr > li").click(function(){
			var sel = $(this).attr("id");
			if(sel == "fbShare"){
				try{
					window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
				}catch(e){
					window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
				}
			}else if(sel == "twShare"){
				try {
					window.android.android_window_open("http://twitter.com/intent/tweet?text="
									+ encodeURIComponent(share_description)
									+ "&url=" + share_url);
				} catch (e) {
					window.open("http://twitter.com/intent/tweet?text="
							+ encodeURIComponent(share_description) + "&url="
							+ share_url);
				}
			}
		});
		
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
		  var clipboard = new ClipboardJS('.com__share_wrap .btn__share_copy');
		clipboard.on('success', function(e) {
			alert('주소가 복사되었습니다');
		});
		clipboard.on('error', function(e) {
			console.log(e);
		});
	});
	/*레이어*/
	function onoff(id) {
		var mid=document.getElementById(id);
		if(mid.style.display=='') {
			mid.style.display='none';
		}else{
			mid.style.display='';
		}
	}
		
	function share_kakao(){
		try{
			Kakao.Link.createDefaultButton({
				container: '#kakao-link-btn',
				objectType: 'feed',
				content: {
					title: "2021 추석 통합 기획전 – 최저가 쇼핑은 에누리",
					description: "한가위에-누리다!\n매주 수요일 타임특가 놓치지 마세요!",
					imageUrl: share_image,
					link: {
							webUrl: share_url,
						mobileWebUrl: share_url
					}
				},
				buttons: [
				{
					title: '상세정보 보기',
					link: {
						webUrl: share_url,
						mobileWebUrl: share_url
					}
				}
				]
			});
		}catch(e){
			alert("카카오 톡이 설치 되지 않았습니다.");
			alert(e.message);
		}
	}

	function getEventAjaxData(params, callback){
		var evtUrl = "/mobilefirst/evt/ajax/chuseok2021_setlist.jsp";
		
		if(typeof params === "object") {
			params.sdt = sdt;
			params.osType = getOsType();
		}
		if(!isClick){
			return false;
		}
		isClick = false;
		$.post(evtUrl,params,callback,"json").done(function(){
				isClick = true;
		});
	}

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
	function view_moapp(){
		var chrome25;
		var kitkatWebview;
		var uagentLow = navigator.userAgent.toLocaleLowerCase();
		var openAt = new Date;
		var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2021%2Fchuseok.jsp";
		if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
			goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2021/chuseok.jsp";
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
	//닫기버튼
	$( ".win_close" ).click(function(){
		if(APPYN == 'Y')  window.location.href = "close://";
		else			window.location.replace("/m/index.jsp");
	});


	</script>
</body>
</html>