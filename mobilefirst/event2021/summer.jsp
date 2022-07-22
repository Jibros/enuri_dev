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
	response.sendRedirect("/event2021/summer.jsp"); //PC경로
    return;
}
SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMddHHmm");  //오늘 날짜
String strToday = formatter.format(new Date());
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

String tab = ChkNull.chkStr(request.getParameter("tab"));
String protab = ChkNull.chkStr(request.getParameter("protab"));
%>
<!doctype html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />

	<link rel="shortcut icon" href="http://img.enuri.info/2014/layout/favicon_enuri.ico">
	<title>에누리(가격비교) eNuri.com</title>
	<link rel="stylesheet" type="text/css" href="/css/slick.css">
	<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
	<link rel="stylesheet" type="text/css" href="/css/rev/common.css"/> <!-- reset -->
	<link rel="stylesheet" type="text/css" href="/css/rev/template.css"/> <!-- template -->
	<!-- 프로모션 공통 CSS (Mobile) -->
	<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
	<!-- 프로모션별 커스텀 CSS  -->
	<link rel="stylesheet" href="/css/event/y2021_rev/summer_pro_m.css" type="text/css">
	<script type="text/javascript" src="/common/js/lib/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="/js/swiper.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
	<script type="text/javascript" src="/event2016/js/event_common.js"></script>
	<script>
	    var userId = "<%=userId%>";
	    var tab = "<%=tab%>"; //파라미터 tab
	    var username = "<%=userArea%>"; //개인화영역 이름
	    var vChkId = "<%=chkId%>";
	    var vEvent_page = "<%=strUrl%>"; //경로
	</script>
</head>
<body>
<div class="lay_only_mw" style="display:none;">
	<div class="lay_inner">
		<div class="lay_head">
			더 다양한 <em>이벤트 혜택</em>을 누리고 싶다면?
		</div>
		<!-- 버튼 : 에누리앱으로 보기 -->
		<button class="btn_go_app" onclick="alert('APP으로 보기');">에누리앱으로 보기</button>
		<!-- 버튼 : 모바일웹으로 보기 -->
		<a href="javascript:void(0);" class="btn_keep_mw" onclick="$('.lay_only_mw').fadeOut(100);">괜찮아요. 모바일 웹으로 볼래요</a>
	</div>
</div>

<div class="wrap">
	<div class="event_wrap">
		<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp" %>

		<!-- 플로팅 배너 - 둥둥이 -->
		<div id="floating_bnr" class="floating_bnr" onclick="ga_log(5);">
			<a href="/mobilefirst/event2021/summer_deal.jsp?tab=05"><img src="http://img.enuri.info/images/event/2021/summer_pro/fl_bnr.png" alt="무더위 준비하고 애플워치 득템"></a>
			<!-- 닫기 -->
			<a href="#" class="btn_close" onclick="onoff('floating_bnr');return false;">
				<span class="blind">닫기</span>
			</a>
		</div>
		<!-- // -->



		<!-- visual -->
		<div class="section visual">
			<!-- 200330 추가 : 공통 : 공유하기 버튼  -->
			<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
			<!-- // -->
			<div class="inner">
				<div class="react_text_area plxtype2" data-vx="30" data-vy="0">
					<span class="txt_01">다가오는 무더위 미리대탈출!</span>
					<h2><span>시원함에 누리다</span></h2>
					<span class="txt_02">2021.07.05 ~ 2021.08.08</span>
				</div>
			</div>
			<script>
				$(window).load(function(){
					var $visual = $(".event_wrap .visual");
					setTimeout(function(){
						$visual.addClass("intro");
					},100)
				})
			</script>
		</div>
		<!-- //visual -->



		<!-- 탭 -->
		<div class="section floattab">
			<div class="contents">
				<ul class="floattab__list">
					<li onclick="ga_log(2);"><a href="/mobilefirst/event2021/summer_evt.jsp">무더위 극-복권 긁으러 GO</a></li>
					<li onclick="ga_log(3);"><a href="/mobilefirst/event2021/summer_deal.jsp">매주 수요일 타임특가</a></li>
					<li onclick="ga_log(4);"><a href="/mobilefirst/event2021/summer.jsp" class="active">여름을 시원하게! 무더위 기획전</a></li>
				</ul>
			</div>
		</div>
		<!-- /탭 -->

		<!-- 중단배너 -->
		<div class="mid_banner">
			<a href="javascript:;"><img src="http://img.enuri.info/images/event/2021/summer_pro/mobile/m_mid_banner.png" width="320" alt="무더위 준비!! 올 여름은 시원할 거에요~! 여름 피할 수 없으면 즐겁게 즐기자!" /></a>
		</div>
		<!-- 중단배너 -->

		<!-- 중단 상품 영역 -->
		<div class="pro_itemlist">
			<!-- 여름가전템 -->
			<div id="evt2" class="item_group item_group_01 scroll">
				<h3>
					<span class="txt_sub">에어컨 설치 전쟁 터지기 전에?!</span>
					<strong class="txt_tit">나 먼저 산다 여름 가전템</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active" onclick="ga_log(13);"><a href="#protab1-1">에어컨</a></li>
					<li onclick="ga_log(14);"><a href="#protab1-2">냉방 기기</a></li>
					<li onclick="ga_log(15);"><a href="#protab1-3">냉풍기/쿨매트</a></li>
				</ul>
				<!-- //추천상품 탭 -->
 
				<!-- 추천상품 템플릿 -->
				<div class="tab_container">
					<!--
						SLICK $(".itemlist")
						3개의 탭 콘텐츠가 있습니다. "tab_content"
						하나의 콘텐츠마다 ul 단위로 한 판(상품4개)씩 움직입니다.
					-->
					<!-- 에어컨 상품-->
					<div id="protab1-1" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="btn_more"  onclick="ga_log(17);" href="/m/list.jsp?cate=2401">상품더보기</a>
					</div>
					<!-- //에어컨 상품-->

					<!-- 제습기 상품-->
					<div id="protab1-2" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more"onclick="ga_log(17);"  href="/m/list.jsp?cate=2402">상품더보기</a>
					</div>
					<!-- //제습기 상품-->

					<!-- 공기순환기 상품 -->
					<div id="protab1-3" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(17);"  href="/m/list.jsp?cate=24020601">상품더보기</a>
					</div>
					<!-- //공기순환기 상품 -->
				</div>
				<!-- //추천상품 템플릿 -->
			</div>
			<!-- //여름가전템 -->

			<!-- 치트키템 -->
			<div id="evt3" class="item_group item_group_02 scroll">
				<h3>
					<span class="txt_sub">야! 너두 즐거운 바캉스 갈 수 있어!</span>
					<strong class="txt_tit">믿고 사는 휴가 치트키템</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active" onclick="ga_log(18);" ><a href="#protab2-1">물놀이 용품</a></li>
					<li onclick="ga_log(19);" ><a href="#protab2-2">패션</a></li>
					<li onclick="ga_log(20);" ><a href="#protab2-3">카메라/액션캠</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 템플릿 -->
				<div class="tab_container">
					<!-- 보양식 상품 -->
					<div id="protab2-1" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="btn_more" onclick="ga_log(22);" href="/m/list.jsp?cate=0909">상품더보기</a>
					</div>
					<!-- //보양식 상품 -->

					<!-- 빙과류 상품 -->
					<div id="protab2-2" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(22);" href="/m/list.jsp?cate=090915">상품더보기</a>
					</div>
					<!-- //빙과류 상품 -->

					<!-- 제철과일 상품 -->
					<div id="protab2-3" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(22);" href="/m/list.jsp?cate=0239">상품더보기</a>
					</div>
					<!-- //제철과일 상품 -->
				</div>
				<!-- //추천상품 템플릿 -->
			</div>
			<!-- //치트키템 -->

			<!-- 홈캉스템 -->
			<div id="evt4" class="item_group item_group_03 scroll">
				<h3>
					<span class="txt_sub">내 피 땀 염분~♬ 한방울도 용납할 수 없다면?</span>
					<strong class="txt_tit">뒹굴뒹굴 에어컨 1열 홈캉스템</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active" onclick="ga_log(23);" ><a href="#protab3-1">화장품</a></li>
					<li onclick="ga_log(24);" ><a href="#protab3-2">모기퇴치용품</a></li>
					<li onclick="ga_log(25);" ><a href="#protab3-3">컴퓨터/게임기</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 템플릿 -->
				<div class="tab_container">
					<!-- 홈카페 상품 -->
					<div id="protab3-1" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="btn_more" onclick="ga_log(27);" href="/m/list.jsp?cate=0805">상품더보기</a>
					</div>
					<!-- //홈카페 상품 -->

					<!-- 게임기 상품 -->
					<div id="protab3-2" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(27);" href="/m/list.jsp?cate=1629">상품더보기</a>
					</div>
					<!-- //게임기 상품 -->

					<!-- DIY 상품 -->
					<div id="protab3-3" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(27);" href="/m/list.jsp?cate=0408">상품더보기</a>
					</div>
					<!-- //DIY 상품 -->
				</div>
				<!-- //추천상품 템플릿 -->
			</div>
			<!-- //홈캉스템 -->

			<!-- 차가워템 -->
			<div id="evt5" class="item_group item_group_04 scroll">
				<h3>
					<span class="txt_sub">차가운것들이 내 목에! 빨리 먹고!</span>
					<strong class="txt_tit">머리가 띵~ 차가워템</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active" onclick="ga_log(28);"><a href="#protab4-1">홈카페</a></li>
					<li onclick="ga_log(29);"><a href="#protab4-2">과일</a></li>
					<li onclick="ga_log(30);"><a href="#protab4-3">기프티콘</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 템플릿 -->
				<div class="tab_container">
					<!-- 호캉스 상품 -->
					<div id="protab4-1" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="btn_more" onclick="ga_log(32);" href="/m/list.jsp?cate=1505">상품더보기</a>
					</div>
					<!-- //호캉스 상품 -->

					<!-- 텐트 상품 -->
					<div id="protab4-2" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(32);" href="/m/list.jsp?cate=150203">상품더보기</a>
					</div>
					<!-- //텐트 상품 -->

					<!-- 외식상품권 상품 -->
					<div id="protab4-3" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(32);"  href="/m/list.jsp?cate=164721">상품더보기</a>
					</div>
					<!-- //외식상품권 상품 -->
				</div>
				<!-- //추천상품 템플릿 -->
			</div>
			<!-- //차가워템 -->
		</div>
		<!-- //중단 상품 영역 -->

		<!-- 에누리 기획전 -->
		<div class="evt__enuri_plan" style="display:none;">
			<div class="inner">
				<h3 class="animated" data-animate="slideup" data-duration="1">에누리 기획전</h3>
				<ul class="enuri_plan_list clear">
					<li class="animated" data-animate="slideup" data-duration="1"><a href="">일교차 큰 요즘에 딱! 홍삼액 제조기</a></li>
					<li class="animated" data-animate="slideup" data-duration="1"><a href="">2020년 혼수 가구 기획전</a></li>
					<li class="animated" data-animate="slideup" data-duration="1"><a href="">청호 나이스 이과수 얼음 정수기</a></li>
					<li class="animated" data-animate="slideup" data-duration="1"><a href="">배그 유저들을 위한 추천사양</a></li>
					<li class="animated" data-animate="slideup" data-duration="1"><a href="">미리 준비하는 따뜻한 겨울</a></li>
					<li class="animated" data-animate="slideup" data-duration="1"><a href="">2020년 혼수 가구 기획전</a></li>
					<li class="animated" data-animate="slideup" data-duration="1"><a href="">일교차 큰 요즘에 딱! 홍삼액 제조기</a></li>
					<li class="animated" data-animate="slideup" data-duration="1"><a href="">배그 유저들을 위한 추천사양</a></li>
				</ul>
			</div>
		</div>
		<!-- // 에누리 기획전 -->

		<!-- 에누리 혜택 -->
		<div class="otherbene" onclick="ga_log(7);">
			<div class="contents">
				<h3 class="animated" data-animate="slideup" data-duration="1">놓칠 수  없는 특별한 혜택, 에누리 혜택</h3>
				<ul class="banlist">
					<li class="animated" data-animate="slideleft" data-duration="1">
						<a href="http://www.enuri.com/event2020/welcome_evt.jsp" target="_blank" title="새창으로 이동">
							<img src="http://img.enuri.info/images/event/2021/summer_pro/mobile/m_other_b1.jpg">
						</a>
					</li>
					<li class="animated" data-animate="slideright" data-duration="1">
						<a href="http://www.enuri.com/evt/visit.jsp#evt1" target="_blank" title="새창으로 이동">
							<img src="http://img.enuri.info/images/event/2021/summer_pro/mobile/m_other_b2.jpg">
						</a>
					</li>
					<li class="animated" data-animate="slideleft" data-duration="1">
						<a href="http://www.enuri.com/m/event/buy_stamp.jsp#tab4" target="_blank" title="새창으로 이동">
							<img src="http://img.enuri.info/images/event/2021/summer_pro/mobile/m_other_b3.jpg">
						</a>
					</li>
					<li class="animated" data-animate="slideright" data-duration="1">
						<a href="http://m.enuri.com/m/index.jsp#evt" target="_blank" title="새창으로 이동">
							<img src="http://img.enuri.info/images/event/2021/summer_pro/mobile/m_other_b4.jpg">
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
					</ul>
					<!-- 메인보내기 버튼클릭시 .mail_on 추가해 주세요 -->
					<div class="btn_wrap">
						<div class="btn_group">
							<!-- 주소복사하기 -->
							<div class="btn_item">
								<span id="txtURL" class="txt__share_url">http://www.enuri.com/mobilefirst/event2021/summer.jsp</span>
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
	<!-- // 프로모션 -->

	<!--<a href="#top" class="btn_top"><i>TOP</i></a>-->
	<script>
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
			var mid=document.getElementById(id);
			if(mid.style.display=='') {
				mid.style.display='none';
			}else{
				mid.style.display='';
			}
		}
	</script>

	<script>
		// 애니메이션
		var areaWin = $(window);
		var lastScroll = 0;
		function isScrolledIntoView(target, check) {
			var docViewTop = areaWin.scrollTop();
			var docViewBottom = docViewTop + areaWin.height();
			var elemTop = target.offset().top;
			// return (docViewBottom >= elemTop);
			var animate_nm = target.data('animate');

			if(animate_nm === 'slideup') {
				if(check === 'down') {
					elemTop = elemTop-target.height();
				}
				return (docViewBottom >= elemTop);
			} else {
				return (docViewBottom >= elemTop);
			}
		}
		$('.animated').each(function(index, item) {
			var animate_nm = $(item).data('animate');
			var animate_duration = "duration__" + $(item).data('duration');
			var animate_class = "";
			switch(animate_nm) {
				case "slideleft":
					animate_class = 'slideInLeft'
					break;
				case "slideright":
					animate_class = 'slideInRight'
					break;
				case "slideup":
					animate_class = 'slideInUp'
					break;
			}

			var position = $(window).scrollTop();
			$(document).on("scroll", function () {
				var scroll = $(window).scrollTop();
				if(scroll > position) {
					var wheelcontrol = 'down'
				} else {
					var wheelcontrol = 'up'
				}
				position = scroll;

				if (isScrolledIntoView($(item),wheelcontrol)) {
					$(item).addClass(animate_class+" "+ (animate_duration ? animate_duration : ''));
				}
				if (!isScrolledIntoView($(item),wheelcontrol)) {
					$(item).removeClass(animate_class+" "+ (animate_duration ? animate_duration : ''));
				}
			});
		});
	</script>
</div>
<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20190611"></script>
<script type="text/javascript" src="/mobilefirst/event/js/exhibition_m.js"></script>
<script type="text/javascript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
<script type="text/javascript">
var cnt = 0;
var $navHgt = 0;
var app = getCookie("appYN"); //app인지 여부
var makeHtml = "";
var vOs_type = getOsType();

var vEvent_title = "21년 무더위 통합기획전";
var gaLabel = [  vEvent_title+"_PV"
		,vEvent_title+"_상단탭_단순참여 이벤트"
		,vEvent_title+"_상단탭_타임딜"
		,vEvent_title+"_상단탭_기획전"
		,vEvent_title+"_상단플로팅배너"
		,vEvent_title+"_무더위 극-복권 이벤트 참여"
		,vEvent_title+"_혜택배너"
		,vEvent_title+"_타임딜_상품보기"
		,vEvent_title+"_타임딜_APP구매하기"
		,vEvent_title+"_타임딜_썸네일"
		,vEvent_title+"_구매이벤트_기획전 이동"
		,vEvent_title+"_구매이벤트_참여"
		,vEvent_title+"_여름가전템_에어컨"
		,vEvent_title+"_ 여름가전템__냉방기기"
		,vEvent_title+"_ 여름가전템_냉풍기/쿨매트"
		,vEvent_title+"_여름가전템_상품클릭"
		,vEvent_title+"_여름가전템_더보기"
		,vEvent_title+"_휴가 치트키템_물놀이용품"
		,vEvent_title+"_ 휴가 치트키템_패션"
		,vEvent_title+"_ 휴가 치트키템_카메라/액션캠"
		,vEvent_title+"_ 휴가 치트키템_상품클릭"
		,vEvent_title+"_휴가 치트키템_더보기"
		,vEvent_title+"_홈캉스템_화장품"
		,vEvent_title+"_홈캉스템_모기퇴치용품"
		,vEvent_title+"_홈캉스템_컴퓨터/게임기"
		,vEvent_title+"_홈캉스템_상품클릭"
		,vEvent_title+"_홈캉스템_더보기"
		,vEvent_title+"_차가워템_홈카페"
		,vEvent_title+"_차가워템_과일"
		,vEvent_title+"_차가워템_기프티콘"
		,vEvent_title+"_차가워템_상품클릭"
		,vEvent_title+"_차가워템_더보기"
];

$(document).ready(function() {
	
	var vServerNm = '<%=strServerNm%>';
	var tablo = '<%=protab%>';
	   
	if(tablo == '01'){
		$('html, body').stop().animate({scrollTop: Math.ceil($('#evt1').offset().top- $(".navtab").outerHeight())}, 0);
	}

	//상품 영역
	var loadUrl = "/event/ajax/exhibition_ajax.jsp?exh_id=47"; 

	$.ajax({
		  dataType : "json"
		, url	   : loadUrl
		, cache : false
		, success  : function(result){
			var banner = result.R;
			var tab = result.T;
			var tabSize = 3; //컨텐츠 별 탭 개수
			var listSize = 4; //노출 상품 개수
			var logNo = [16,21,26,31];
			var no = 0;
			var minprice = 0;

			for(var idx = 0; idx < tab.length; idx ++){
				makeHtml = "";
				no = logNo[parseInt(idx/tabSize)];
				$.each(tab[idx].GOODS, function(i,v){ 
					minprice = (v.MINPRICE == null) ? 0 : v.MINPRICE;

					if((i % listSize) == 0)	makeHtml += "<ul class='items clearfix'>";
					makeHtml += "<li class='item'>";
					makeHtml +=	"	<a href='javascript:void(0);' onclick='itemClick("+v.MODELNO+", "+minprice+"); ga_log("+no+")'>";
					makeHtml +=	"		<span class='thumb'>";
					makeHtml += "			<img src='"+v.GOODS_IMG+"' alt='상품이미지' onerror = 'replaceImg(this);'>";
					if(minprice == 0 || minprice == null) makeHtml += "<span class='soldout'>soldout</span> <!-- 품절시 노출 -->";
					makeHtml +=	"		</span>";
					makeHtml +=	"		<span class='pro_info'>";
					makeHtml +=	"			<span class='pro_name'>"+v.TITLE1+"<br>"+v.TITLE2+"</span>";
					makeHtml +=	"			<span class='price'>";
					makeHtml +=	"				<span class='price_label'>최저가</span>";
					makeHtml +=	"				<em>"+commaNum(minprice)+"</em>";
					makeHtml +=	"				<span class='pro_unit'>원</span>";
					makeHtml +=	"			</span>";
					makeHtml +=	"		</span>";
					makeHtml +=	"	</a>";
					makeHtml += "</li>";
					if(i % listSize == (listSize - 1) || i == tab[idx].GOODS.length) makeHtml += "</ul>";
				});
				$('#protab'+ (parseInt((idx / tabSize) + 1)) + '-' + ((idx % tabSize) + 1) +' .itemlist').html(makeHtml);
			}
		}
		, complete : function(){
			$navHgt = Math.ceil($(".floattab__list").height());

			//상품 슬릭
			prodSlick();
 
			 if(tablo == '02'){
				$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_01').offset().top- $(".navtab").outerHeight())}, 0);
			}else if(tablo == '03'){
				$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_02').offset().top- $(".navtab").outerHeight())}, 0);
			}else if(tablo == '04'){
				$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_03').offset().top- $(".navtab").outerHeight())}, 0);
			}else if(tablo == '05'){
				$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_04').offset().top- $(".navtab").outerHeight())}, 0);
			}

		}
	});
});

//상품 탭, 슬라이트 관련
function prodSlick(){
	var slickSlide = function(el){
		var $wrap = $(el);
		// 탭초기화
		$wrap.find(".tab_content").hide();
		$wrap.find("ul.pro_tabs li").eq(0).addClass("active").show();
		$wrap.find(".tab_content").eq(0).show();
		// 슬라이드 실행
		var proSlide = $(el + ' .itemlist').slick({
			dots:true,
			slidesToScroll: 1
		});
		// 클릭이벤트
		$wrap.find("ul.pro_tabs li").click(function() {
			if ( !$(this).hasClass("active") ){
				$wrap.find("ul.pro_tabs li").removeClass("active");
				$(this).addClass("active")
				$wrap.find(".tab_content").hide();
				var activeTab = $(this).find("a").attr("href");
				$(activeTab).fadeIn();
				proSlide.slick("setPosition");
			}
			return false;
		});
	}
	// 슬라이드 실행
	var slide1 = new slickSlide('.item_group_01');
	var slide2 = new slickSlide('.item_group_02');
	var slide3 = new slickSlide('.item_group_03');
	var slide4 = new slickSlide('.item_group_04');

	//상단 탭 이동
	//topTabMove();
}

/* 퍼블테스트 : 레이어 열고 닫기*/
function onoff(id){
	var mid = $("#"+id);
	if(mid.css("display") !== "none"){
		mid.css("display","none");
	}else{
		mid.css("display","");
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
	shareSns('kakao');
});
$(".share_fb").on('click', function(){
	shareSns('face');
});
$(".share_tw").on('click', function(){
	shareSns('twitter');
});

//sns 공유하기 함수
function shareSns(param){ //수정
	var share_url = "http://" + location.host + "/mobilefirst/event2021/summer_deal.jsp?oc=sns";
	var share_title = "[에누리 가격비교] 시원함에누리다!";
	var share_description = "매주 수요일 타임특가도 만나보세요!";
	var imgSNS = "http://img.enuri.info/images/event/2021/summer_pro/sns_1200_630.jpg";
	
	if(param == "face"){
		try{
			window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
			//ga("send", "event", "mf_event", vEvent_title +"_APP", "공유하기_페이스북");
		}catch(e){
			window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
			//ga("send", "event", "mf_event", vEvent_title +"_WEB", "공유하기_페이스북");
		}
	}else if(param == "kakao"){
		imgSNS = "http://img.enuri.info/images/event/2021/summer_pro/sns_800_400.jpg";
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
		var share_title_twi = "[에누리 가격비교] 시원함에누리다! 매주 수요일 타임특가도 만나보세요!";
		window.open("https://twitter.com/intent/tweet?text="+encodeURIComponent(share_title_twi)+"&url="+share_url);
	}
}

ga_log(1);
insertLog(25140);
</script>
</body>
</html>