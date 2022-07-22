<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
String strApp = ChkNull.chkStr(request.getParameter("app"));
String cUserId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String tempIp = request.getRemoteHost();
String seasonYN = "Y";
String seasonName = "#새학기";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
    <title>에누리 가격비교 - 최저가 쇼핑은 에누리 가격비교 사이트</title>
	<meta name="Title" content="에누리 가격비교 - 최저가 쇼핑은 에누리 가격비교 사이트" />
	<meta name="Subject" content="에누리 가격비교 - 최저가 쇼핑은 에누리 가격비교 사이트">
	<meta property="og:title" content="에누리 가격비교 - 최저가 쇼핑은 에누리 가격비교 사이트">
	<meta property="og:description" content="에누리 가격비교 - 최저가 쇼핑은 에누리 가격비교 사이트">
    <meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/logo_enuri.png">
    <meta name="format-detection" content="telephone=no" />
    <meta name="description" CONTENT="에누리 가격비교 - 오픈마켓, 종합몰, 백화점, 소셜 등 국내 주요 쇼핑몰의 상품 정보 및 가격비교 제공">
	<meta name="keyword" CONTENT="가격비교, 최저가, 상품 가격, 쇼핑몰 최저가, 가격비교 사이트, 에누리, 싸게 파는 곳, 쇼핑몰, 상품 추천">
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.tmpl.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
	<script type="text/javascript" src="/js/swiper.min.js"></script> <!-- 200115 추가 -->
	<script type="text/javascript" src="/mobilefirst/js/utils.js"></script> <!-- 200115 추가 -->
	<script type="text/javascript" src="/mobilefirst/js/resentzzimStorage.js"></script> <!-- 200115 추가 -->
	<script type="text/javascript" src="renew2020/js/home.js"></script> <!-- 200115 추가 -->
    <%@include file="/mobilefirst/renew2020/include/cssBundle2.html"%>
    <%@include file="/mobilefirst/login/login_check.jsp"%>
    <script type="application/ld+json" src="/main/main2018/js/searchboxM.js"></script>
	<script>
		var cUserId = "<%=cUserId%>";
		var tempIp = "<%=tempIp%>";
		var seasonYN = "<%=seasonYN%>";
		var IMG_ENURI_COM       = "<%=ConfigManager.IMG_ENURI_COM%>";
		var STORAGE_ENURI_COM   = "<%=ConfigManager.STORAGE_ENURI_COM%>";
		var PHOTO_ENURI_COM     = "<%=ConfigManager.PHOTO_ENURI_COM%>";
		var BLANK_IMG           = IMG_ENURI_COM + "/images/blank.gif";
	</script>
<script type="application/ld+json">
{"@context": "http://schema.org","@type": "Person","name": "에누리닷컴","url": "http://www.enuri.com","sameAs": ["http://blog.naver.com/enuriblog","http://cafe.naver.com/enuriprosumer","https://www.instagram.com/enuristory","https://m.facebook.com/enuriStory/"]}
</script>
<!-- Global site tag (gtag.js) - Google Ads: 966646648 -->
<script async src="https://www.googletagmanager.com/gtag/js?id=AW-966646648"></script>
<script>(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)})(window,document,'script','//www.google-analytics.com/analytics.js','ga');ga('create', 'UA-52658695-3', 'auto');</script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'AW-966646648');
</script>
</head>
<body>

<!-- 공통 : 카테고리 레이어 -->
<%@include file="/mobilefirst/renew2020/include/cate.jsp"%>
<!-- 공통 : 검색 레이어 -->
<!-- 
	// 레이어를 visible 시킨 후 .opened 클래스 붙여주세요
	$srLayer.show(); // 레이어 visible
	setTimeout(function(){ // .3초뒤 실행
		$srLayer.addClass("opened"); // 백버튼 모션
		$mainWrap.addClass("scroll_lock"); // wrapper scroll 잠금
	},300)
 -->

<!-- // 검색 레이어 -->
<%@include file="/mobilefirst/renew2020/include/searchBar.jsp"%>
<!-- 메인 AD 배너 영역 - 전체보기 리스트 -->
<!-- 
	활성화 시에 레이어 fadeIn 후 active 클래스 붙여주세요.
	스크롤 되는 전체창 레이어 인관계로 #wrap에 .scroll_lock클래스로 스크롤 잠궈 주셔야 합니다.
 -->
<div class="m_main_bnr_all dim" style="display:none">	
	<div class="lay_tit">
		전체보기
		<button href="javascript:///" class="btn_close comm__sprite" onclick="$('.m_main_bnr_all').fadeOut(100).removeClass('active');$('#wrap').removeClass('scroll_lock');">닫기</button>
	</div>
	<ul id="mainInnerUl"></ul>
	<div class="btn_close_dim" onclick="$(this).parent().find('.btn_close').click()"></div>
</div>
<!-- //메인 AD 배너 영역 - 전체보기 리스트 -->

<!-- 공통 : 찜레이어 -->
<span class="zzimly">찜 되었습니다</span>
<!-- // 찜레이어 -->

<!-- 공통 : SNS공유하기 -->
<div class="com__share_wrap dim" style="z-index:999;display:none">
	<div class="com__layer share_layer">
		<div class="lay_head">공유하기</div>
		<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
		<div class="lay_inner">
			<ul>
				<li class="share_fb">페이스북 공유하기</li>
				<li class="share_kakao">카카오톡 공유하기</li>				
				<li class="share_tw">트위터 공유하기</li>
				<li class="share_line">라인 공유하기</li>
			</ul>
			<div class="btn_group">
				<span id="txtURL" class="txt__share_url">http://www.enuri.com/event/chuseok.jsp</span>
				<button class="btn__share_copy" data-clipboard-target="#txtURL">복사</button>
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

<!-- 스크롤 잠글때 #wrap에 .scroll_lock 클래스 붙여주세요 -->
<div id="wrap">
<!-- <div id="wrap" class="scroll_lock"> -->

	<!-- 헤더 -->	
	<!-- inline-style로  배경색 / 배경 이미지 교체 -->
	<header id="header" class="m_header m_header_main">
		<div class="header_wrap">
			<h1 class="m_symbol comm__sprite">ENURI</h1>			
			<button class="btn_hd_cate comm__sprite">카테고리</button>
			<button class="btn_hd_my comm__sprite">나의정보</button>
		</div>
		<div class="search_wrap">
			<span class="btn_lay_sr"><!-- 버튼 :: 검색레이어 --></span>
		</div>
	</header>
	<!-- // 헤더 -->

	<!-- 네비 -->
	<nav class="m_nav m_nav_main">
		<div class="m_nav_cont swiper-container">
			<div class="swiper-wrapper">
				<div class="swiper-slide on"><a href="#tab_home">홈</a></div>
				<div class="swiper-slide"><a href="#tab_best">핫딜베스트</a></div>
				<%if(seasonYN.equals("Y")){ %>
				<div class="swiper-slide"><a href="#tab_season" class="tab__new"><%=seasonName %></a></div>
				<%} %>
				<div class="swiper-slide"><a href="#tab_trend">트렌드픽업</a></div>
				<div class="swiper-slide"><a href="#tab_event">이벤트/기획전</a></div>
				<div class="swiper-slide"><a href="#tab_knowcom">쇼핑지식</a></div>
				<div class="swiper-slide"><a href="#tab_sale">특가모음</a></div>
			</div>
		</div>
    </nav>	
	<!--// 네비 -->	

	<section id="container" class="m_main_cont">
		<!-- 슬라이드 네비 -->
        <div class="m_main_swiper swiper-container">
			<div class="swiper-wrapper">
				
				<!-- 메인탭 :: 홈 // index_tab_home.html -->
				<div id="tab_home" class="swiper-slide m_main_tab">

					<!-- Placehold loader : 홈탭 메인 컨텐츠가 완전히 로딩이 끝나기 전까지 노출 -->
					<div class="m_main_placeholder">
						<ul class="m_shortcut">
							<li class="ph-item"><span class="ph_ico"></span><span class="ph_txt"></span></li>
							<li class="ph-item"><span class="ph_ico"></span><span class="ph_txt"></span></li>
							<li class="ph-item"><span class="ph_ico"></span><span class="ph_txt"></span></li>
							<li class="ph-item"><span class="ph_ico"></span><span class="ph_txt"></span></li>
							<li class="ph-item"><span class="ph_ico"></span><span class="ph_txt"></span></li>
							<li class="ph-item"><span class="ph_ico"></span><span class="ph_txt"></span></li>
							<li class="ph-item"><span class="ph_ico"></span><span class="ph_txt"></span></li>
							<li class="ph-item"><span class="ph_ico"></span><span class="ph_txt"></span></li>
							<li class="ph-item"><span class="ph_ico"></span><span class="ph_txt"></span></li>
							<li class="ph-item"><span class="ph_ico"></span><span class="ph_txt"></span></li>
						</ul>
						<div class="ph_banner ph-item"></div>
						<ul class="m_shortcut">
							<li class="ph-item"><span class="ph_ico"></span><span class="ph_txt"></span></li>
							<li class="ph-item"><span class="ph_ico"></span><span class="ph_txt"></span></li>
							<li class="ph-item"><span class="ph_ico"></span><span class="ph_txt"></span></li>
							<li class="ph-item"><span class="ph_ico"></span><span class="ph_txt"></span></li>
							<li class="ph-item"><span class="ph_ico"></span><span class="ph_txt"></span></li>
							<li class="ph-item"><span class="ph_ico"></span><span class="ph_txt"></span></li>
							<li class="ph-item"><span class="ph_ico"></span><span class="ph_txt"></span></li>
							<li class="ph-item"><span class="ph_ico"></span><span class="ph_txt"></span></li>
							<li class="ph-item"><span class="ph_ico"></span><span class="ph_txt"></span></li>
							<li class="ph-item"><span class="ph_ico"></span><span class="ph_txt"></span></li>
						</ul>
					</div>
					<!-- // -->

					<!-- 홈탭 메인 컨텐츠 상단 영역 -->
					<!-- 로딩이 끝나면 loaded 클래스 붙여주세요. -->
					<div class="m_main_topcnt">
						
						<!-- CPP 및 이벤트/주요쇼핑몰 영역 -->
						<ul class="m_sc_top m_shortcut">
							<li>
								<a href="javascript:///">
									<span class="ico_elec home__sprite"></span>
									<span class="txt_cate_name">가전/해외직구</span>
								</a>
							</li>
							<li>
								<a href="javascript:///">
									<span class="ico_tv home__sprite"></span>
									<span class="txt_cate_name">TV/영상/디카</span>
								</a>
							</li>
							<li>
								<a href="javascript:///">
									<span class="ico_pc home__sprite"></span>
									<span class="txt_cate_name">컴퓨터/노트북</span>
								</a>
							</li>
							<li>
								<a href="javascript:///">
									<span class="ico_tablet home__sprite"></span>
									<span class="txt_cate_name">태블릿/모바일</span>
								</a>
							</li>
							<li>
								<a href="javascript:///">
									<span class="ico_kids home__sprite"></span>
									<span class="txt_cate_name">유아/식품</span>
								</a>
							</li>
							<li>
								<a href="javascript:///">
									<span class="ico_sports home__sprite"></span>
									<span class="txt_cate_name">스포츠/자동차</span>
								</a>
							</li>
							<li>
								<a href="javascript:///">
									<span class="ico_funi home__sprite"></span>
									<span class="txt_cate_name">가구/생활</span>
								</a>
							</li>
							<li>
								<a href="javascript:///">
									<span class="ico_fashion home__sprite"></span>
									<span class="txt_cate_name">패션/화장품</span>
								</a>
							</li>
							<li>
								<a href="javascript:///">
									<span class="ico_social home__sprite"></span>
									<span class="txt_cate_name">소셜비교</span>
								</a>
							</li>
							<li>
								<a href="javascript:///">
									<span class="ico_knowcom home__sprite"></span>
									<span class="txt_cate_name">쇼핑지식</span>
								</a>
							</li>
						</ul>
						<!-- //CPP 및 이벤트/주요쇼핑몰 영역 -->

						<!-- 메인 AD 배너 영역 -->
						<div class="m_main_banner swiper-container noswipe">
							<div class="swiper-wrapper" id="mainEvtbnr" ></div>
							<div class="swiper-ctrl" onclick="$('.m_main_bnr_all').fadeIn(200).addClass('active');$('#wrap').addClass('scroll_lock');">
								<div class="swiper-counter"><span class="num_index">1</span> / <span class="num_total"></span></div>
								<!-- 전체보기 버튼 -->
								<button class="swiper-button comm__sprite btn__view_all">전체보기</button>
							</div>						
						</div>
						<!-- // 메인 AD 배너 영역 -->					
						<%@include file="/mobilefirst/renew2020/include/homeLink.jsp"%>
					</div>

					<script>
						// 퍼블테스트 
						$(function(){
							// 페이지 로딩이 끝나고 플레이스 홀더가 사라지는 액션 보기
							setTimeout(function(){
								$(".m_main_placeholder").fadeOut(600);
								$(".m_main_topcnt").addClass('loaded');
							},2000)
						})
					</script>
					
					<!-- 트랜드픽업 -->
					<%@include file="/mobilefirst/renew2020/include/trendPickArea.jsp"%>
					<!-- // 트랜드픽업 -->

					<!-- 해외직구 가격비교 -->
					<%@include file="/mobilefirst/renew2020/include/globalArea.jsp"%>
					<!-- // -->

					<!-- 중고차 -->
					<%@include file="/mobilefirst/renew2020/include/rebornCarArea.jsp"%>
					<!-- // 중고차 -->					

					<!-- 크레이지딜 -->
					<%@include file="/mobilefirst/renew2020/include/crazyDealArea.jsp"%>
					<!-- // 크레이지딜 -->

					<!-- 쇼핑지식 -->
					<div class="m_knowcom">
						<div class="card__head">
							<p class="card__tit">쇼핑지식</p>
							<a href="javascript:///" class="btn__card_more" onclick="goKnowBoxMore();" >더보기</a>
						</div>
						<ul class="board__list type_photo_r"></ul>
					</div>
					<!-- // 쇼핑지식 -->

					<!-- 에누리 추천 상품 -->
					<%@include file="/mobilefirst/renew2020/include/todayGoodsDeal.jsp"%>
					<!-- // 에누리 추천 상품 -->

					<!-- 인기쇼핑몰 -->
					<div class="m_mall_list m_card_type">
						<div class="card__head">
							<p class="card__tit">인기 쇼핑몰</p>
						</div>
						<ul class="mall__list">
							<li><a href="javascript:///"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/logo/Ap_logo_536.png" alt="G마켓"></a></li>
							<li><a href="javascript:///"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/logo/Ap_logo_4027.png" alt="옥션"></a></li>
							<li><a href="javascript:///"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/logo/Ap_logo_5910.png" alt="11번가"></a></li>
							<li><a href="javascript:///"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/logo/Ap_logo_55.png" alt="인터파크"></a></li>
							<li><a href="javascript:///"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/logo/Ap_logo_6665.png" alt="SSG"></a></li>
							<li><a href="javascript:///"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/logo/Ap_logo_49.png" alt="롯데닷컴"></a></li>
							<li><a href="javascript:///"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/logo/Ap_logo_57.png" alt="현대H몰"></a></li>
							<li><a href="javascript:///"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/logo/Ap_logo_90.png" alt="AKMall"></a></li>
							<li><a href="javascript:///"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/logo/Ap_logo_75.png" alt="GS SHOP"></a></li>
							<li><a href="javascript:///"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/logo/Ap_logo_806.png" alt="CJ Mall"></a></li>
							<li><a href="javascript:///"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/logo/Ap_logo_663.png" alt="롯데홈쇼핑"></a></li>
							<li><a href="javascript:///"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/logo/Ap_logo_6588.png" alt="홈앤쇼핑"></a></li>
							<li><a href="javascript:///"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/logo/Ap_logo_6508.png" alt="위메프"></a></li>
							<li><a href="javascript:///"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/logo/Ap_logo_6641.png" alt="티몬"></a></li>
							<li><a href="javascript:///"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/logo/Ap_logo_7861.png" alt="쿠팡"></a></li>
							<li><a href="javascript:///"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/logo/Ap_logo_7692.png" alt="G9"></a></li>
							<li><a href="javascript:///"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/logo/Ap_logo_6547.png" alt="elLotte"></a></li>
							<li><a href="javascript:///"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/logo/Ap_logo_6620.png" alt="갤러리아"></a></li>
							<li><a href="javascript:///"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/logo/Ap_logo_974.png" alt="NSmall"></a></li>
							<li><a href="javascript:///"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/logo/Ap_logo_7935.png" alt="공영쇼핑"></a></li>
						</ul>
					</div>
					<!-- // 인기쇼핑몰 -->

				</div>
				<!-- // 메인탭 :: 홈 -->

				<!-- 메인탭 :: 핫딜베스트 // index_tab_hotdeal.html -->
				<%@include file="/mobilefirst/renew2020/include/hotdealTab.jsp"%>
				<!-- // 메인탭 :: 핫딜베스트 -->

				<!-- 메인탭 :: 시즌탭 // index_tab_season.html-->
				<%@include file="/mobilefirst/renew2020/include/seasonTab.jsp"%>
				<!-- // 메인탭 :: 시즌탭 -->

				<!-- 메인탭 :: 트랜드픽업 // index_tab_trend.html-->
				<%@include file="/mobilefirst/renew2020/include/trendTab.jsp"%>
				<!-- // 메인탭 :: 트랜드픽업 -->

				<!-- 메인탭 :: 이벤트/기획전 // index_tab_event.html-->
				<%@include file="/mobilefirst/renew2020/include/eventTab.jsp"%>
				<!-- // 메인탭 :: 이벤트/기획전 -->

				<!-- 메인탭 :: 쇼핑지식 // index_tab_knowcom.html-->
				<%@include file="/mobilefirst/renew2020/include/knowTab.jsp"%>
				<!-- // 메인탭 :: 쇼핑지식 -->

				<!-- 메인탭 :: 특가모음 // index_tab_sale.html-->
				<%@include file="/mobilefirst/renew2020/include/bestTab.jsp"%>
				<!-- // 메인탭 :: 특가모음 -->

				<!-- 메인탭 :: 히든탭 -->
				<div id="tab_dummy" class="swiper-slide m_main_tab">
					<span class="m_hidden_cnt">
						<img src="<%=IMG_ENURI_COM %>/images/mobile_v2/m_hidden_visual.jpg" alt="">
					</span>
					<span class="m_hidden_cnt">
						<img src="<%=IMG_ENURI_COM %>/images/mobile_v2/m_hidden_cnt.png" alt="">
					</span>
					<a href="javascript:///" class="btn_hidden_app">
						<span class="txt_btn_app">앱 다운로드</span>
					</a>
					<span class="txt_hidden_noti">혜택은 당사 사정에 따라 변경/종료 될 수 있습니다.</span>
				</div>
				<!-- // 메인탭 :: 히든탭 -->
			</div>
        </div>

	</section>

	<!-- 공통 : 하단 배너 영역 -->
	<aside class="common_bnr">	
		
		<!-- 패밀리 앱 다운로드 -->
		<ul class="another_app_list">
			<li class="btn_app_smart">
				<a href="javascript:///">스마트 택배 다운받기</a>
			</li>
			<li class="btn_app_social">
				<a href="javascript:///">소셜가격비교 다운받기</a>
			</li>
		</ul>
		<!-- // -->		

		<!-- 공통 : 하단 배너 -->
		<!-- 배경색은 inline-style로 넣어주세요 -->
		<div class="aside_bnr" style="background-color:#fbe8e7">
			<a href="javascript:///"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/@bnr_bottom_home.png"></a>
		</div>
		<!-- // -->
	</aside>
	<!-- // -->
	<%@include file="/mobilefirst/renew2020/include/footer.jsp"%>
</div>

<!-- 공통 : 프론트배너 -->
<div class="dim" id="mainLayer" style="z-index:999;display: none">
	<div class="main_front_bnr">
		<!-- 배너 이미지  -->
		<a href="#" onclick="return false;"><img src="<%=IMG_ENURI_COM %>/images/mobile_v2/@front_bnr.jpg" ></a>
		<!-- 하단 버튼 그룹 -->
		<div class="btn_group">
			<!-- 버튼 : 앱 이동 / 설치 버튼 -->
			<button class="btn_down_app"><span>에누리 앱에서 보기</span></button>
			<!-- 버튼 : 닫기 -->
			<button class="btn_layer_close" onclick="$(this).closest('.dim').fadeOut(200);return false;"><span>모바일웹으로 계속 보기</span></button>
		</div>
	</div>
	<!-- 백그라운드 터치 : 닫기 -->
	<span class="dim__back" onclick="$(this).closest('.dim').fadeOut(200);return false;"></span>
</div>
<!-- // 프론트배너 -->
</body>
<script id="mainBanner" type="text/x-jquery-tmpl">
    <div class="swiper-slide"><a href="javascript:goMainBanner('\${JURL1}','\${TXT1}');" title="\${TXT1}"><img src="\${TARGET}" alt="\${ALT}"  /></a></div>
</script>
<script id="mainInnerBanner" type="text/x-jquery-tmpl">
    <li><a href="javascript:goMainBanner('\${JURL1}','\${TXT1}');" title="\${TXT1}"><img src="\${TARGET}" alt="\${ALT}"  /></a></li>
</script>
<script id="mainGoodsList" type="text/x-jquery-tmpl">
    {{if part =='T' || part == 'C' }}
<li id="part_\${part}" onclick="addResentZzimItem(1, 'P', '\${pl_no}');goShopLink('\${url}','\${part}' , '\${shopcode}' ,  '\${modelno}' , '\${pl_no}' );" >
		<span class="img_goods">
			{{if fix_location > 8}}
			<img class="lazy" data-original="\${img}" alt="" src='<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png';">
			{{else}}
			<img src="\${img}" onerror="if (this.src != '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png') this.src = '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png';">
			{{/if}}
		</span>
		<span class="group_info">
			<span class="info_head">
				<!-- 쇼핑몰 아이콘 -->
				{{if shopcode == 1634}}
				<span class="info_mall txt">컴퓨존</span>
	            {{else shopcode == 6695}}
				<span class="mall txt">멸치쇼핑</span>
				{{else}}
				<span class="info_mall"><img src="\${mainShopLogo(shopcode)}" alt="" onerror="if (this.src != '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png') this.src = '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png';"></span>
	            {{/if}}

				<!-- 평점 -->
				<span class="group_grade">
					<span class="ico_grade comm__sprite">
						<!-- 획득한 별표 width에 %로 입력 -->
						<span class="ico_grade_gauge comm__sprite" style="width:\${bbs_staravg*2}%"></span>
					</span>
					<span class="txt_score"><em>\${bbs_staravg}</em> (\${numberWithCommas(bbs_cnt)})</span>
					<!-- 구매함 -->
					<!-- <span class="txt_purchased">4,868개 구매</span> -->
				</span>
				<!-- 찜버튼 -->
				<button class="btn__zzim" onclick="event.cancelBubble=true;zzimSet('\${modelno}' , '\${pl_no}' ,this,'\${part}', '\${shopcode}' );"   id="G_\${modelno}"  >찜버튼</button>
				<!-- 광고상품 아이콘 -->
				<!-- <span class="ico__ad comm__sprite">AD</span> -->
			</span>
			<!-- 상품명 -->
			<span class="info_goods_tit">
				\${modelnm}
			</span>
			<span class="info_price">
				<span class="txt_price">
					<!-- 할인율 -->
					<!-- <span class="txt_sale_rate">40%</span> -->
					<!-- 최저가 등 접두어 -->
					<span class="txt_prefix">최저가</span>
					<!-- 할인가격 -->
					<strong>\${numberWithCommas(price)}</strong>원
					<!-- 기존가격 -->
					<!-- <del class="txt_price_origin">\${numberWithCommas(price)}원</del> -->
				</span>
				<!-- 가격비교 -->
				<span class="btn__compare" onclick="event.cancelBubble=true;goDetail(\${modelno});" >가격비교 (\${mallcnt})</span>
			</span>
		</span>
</li>
    {{/if}}
    {{if part =='S' }}

<li id="part_\${part}">
	<span class="img_goods">
		<img class="lazy" data-original="\${img}" alt=""  src='<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png';">
	</span>
	<span class="group_info">
		<span class="info_head">
			<!-- 쇼핑몰 아이콘 -->
			<span class="info_mall">
				<img src="\${mainShopLogo(shopcode)}" alt="">
			</span>
			<span class="group_grade">
				<!-- 구매함 -->
				{{if pcnt != ""}}
				<span class="txt_purchased">\${numberWithCommas(pcnt)}개 구매</span>
				{{/if}}
			</span>
			<button class="btn__zzim"  id="P_\${pl_no}" onclick="event.cancelBubble=true;zzimSet('\${modelno}' , '\${pl_no}' ,this,'\${part}', '\${shopcode}' );"  >찜버튼</button>			
		</span>
		<!-- 상품명 -->
		<span class="info_goods_tit">
			\${modelnm}
		</span>
		<span class="info_price">
			<span class="txt_price">
				
 				{{if orgPrice != "" && discount_rate != ""}}
                <span class="txt_sale_rate">\${discount_rate}%</span>
                {{/if}}
                {{if orgPrice == "" && discount_rate == ""}}
                <span class="txt_prefix">특별가</span>
                {{/if}}
				
				<strong>\${numberWithCommas(price)}원</strong>
                {{if orgPrice != "" && discount_rate != ""}}
                <del class="txt_price_origin">\${numberWithCommas(orgPrice)}원</del>
                {{/if}}
			</span>
		</span>
	</span>
</li>
    {{/if}}
    {{if part =='N' }}
    <li id="part_\${part}">
        <a href="javascript:///"  onclick="addResentZzimItem(1, 'P', '\${pl_no}');goShopLink('\${url}','\${part}' , '\${shopcode}'  , '\${pl_no}' , '\${pl_no}' );"  >
            <span class="img_goods">
				<img class="lazy" data-original="\${img}" alt="" src = '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png';">
			</span>
            {{if title != ""}}
            <p class="ment" style="background:\${title_bg}"><em>\${title}<br>\${subtitle}</em></p>
            {{/if}}
            <div class="zzimarea" onclick="event.cancelBubble=true;" >
                <button type="button" class="heart"  onclick="zzimSet('\${modelno}' , '\${pl_no}' ,this,'\${part}', '\${shopcode}' );"  id="P_\${pl_no}">찜</button>
            </div>
            {{if typeof shopcode != "undefined"}}
            <span class="mall"><img src="\${mainShopLogo(shopcode)}" alt=""></span>
            {{/if}}
            <div class="titarea"><strong>\${modelnm}</strong></div>
            <div class="price">
                <span class="prc"><b>\${commaNum(price)}</b>원</span>
                {{if salecnt != '' }}
                <span class="buy">\${commaNum(salecnt)}개 구매</span>
                {{/if}}
            </div>
        </a>
    </li>
    {{/if}}
    {{if part == 'A' ||  part =='G' }}
    <li id="part_\${part}" class="bnrarea" onclick="javascript:mainEventGo('\${part}','\${section_txt}','\${section_url}');">
        <img class="lazy" data-original="\${img}" src = "<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png"  alt="" onerror="if (this.src != '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png');">
    </li>
    {{/if}}
    {{if part =='P' }}
	<li id="part_\${part}">
	    <div class="guide">
	        {{if title !='' }}
	        <div class="cam_tip">
	            <div class="txtbox" onclick="goMainPlan('\${section_url}','\${modelno}')"><span>\${title}<em><br>\${subtitle}</em></span></div>
	            <img class="lazy" data-original="\${img}" alt="" src='<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png';">
	        </div>
	        {{/if}}
	         {{if title =='' }}
            <div class="cam_tip img">
                <div class="txtbox" onclick="goMainPlan('\${section_url}','\${modelno}')"></div>
                <img src="\${img}"  alt="" onerror="if (this.src != '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png') this.src = '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png';">
            </div>
            {{/if}}
	        <ul class="buy_tip">
	           {{each(prop, val) sublist}}
	            <li>
	                <a href="javascript:///" onclick="goSublistClick('\${val.url}', '\${val.parent_modelno}' )">
	                    <img src="\${val.shop_img}" onerror="if (this.src != '\${val.enuri_img}') this.src = '\${val.enuri_img}';">
	                    <span class="tit">\${val.modelnm}</span>
	                    <b>\${commaNum(val.minprice3)}<em>원</em></b>
	                </a>
	            </li>
	            {{/each}}
	        </ul>
	    </div>
	</li>
    {{/if}}
    {{if part =='B' }}
    <li id="part_\${part}">
        <a href="javascript:///" onclick="goShopLink('\${url}','\${part}' , '\${shopcode}'  , '\${pl_no}'  , '\${pl_no}'  );">
            <span class="img_goods">
				<img src="\${img}" alt="" onerror="if (this.src != '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png') this.src = '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png';">
			</span>
            {{if badge_yn== 'Y'}}
            <span class="hotpic ico_m">HOT PICK</span>
            {{/if}}
            {{if title != ""}}
            <p class="ment" style="background:\${title_bg}"><em>\${title}<br>\${subtitle}</em></p>
            {{/if}}
            <div class="zzimarea" onclick="event.cancelBubble=true;" >
                <button type="button" class="heart"  onclick="zzimSet('\${modelno}' , '\${pl_no}' ,this,'\${part}', '\${shopcode}' );"  id="P_\${pl_no}">찜</button>
            </div>
            {{if  shopcode != null  || shopcode != ""}}
            <span class="mall"><img src="\${mainShopLogo(shopcode)}" alt="" onerror="if (this.src != '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png') this.src = '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png';"></span>
            {{/if}}
            <strong>\${modelnm}</strong>
            <div class="price">
                <span class="prc"><b>\${commaNum(price)}</b>원</span>
                {{if pcnt != ""}}
                <span class="buy">\${commaNum(pcnt)}개 구매</span>
                {{/if}}
            </div>
        </a>
        <a href = "\${section_url}">
        <div class="info_btn">
            <span class="go_store onebtn" onclick="">
               <em>\${section_txt}</em>
            </span>
        </div>
        </a>
    </li>
    {{/if}}
    {{if part =='QQ' }}
	<li id="part_\${part}" class="type_multi">
		<div class="slide_recomm swiper-container noswipe"  id="home_plan" >
			<div class="swiper-wrapper" >
				{{each(prop, val) list}}
				<div class="swiper-slide" onclick="goQQlink('\${section_url}','\${part}' , '\${section_txt}');" >
					<img src="\${val.img}" alt='' >
				</div>
				{{/each}}
			</div>
		</div>
	</li>
    {{/if}}
</script>
<script id="revisedTermsofUse" type="text/x-jquery-tmpl">
    <div class="terms_layer">
        <div class="con">
            <h1>에누리 이용약관 개정 안내</h1>
            <p class="txt">안녕하세요. 에누리 가격비교입니다.<br />고객님의 보다 편리한 서비스 이용을 돕기 위해<br />이용약관이 전면 개정될 예정입니다.<br /><br />&#183; 시행일자 : 2016년 9월 5일(월요일)부터</p>
            <div class="wbox">
                <h2>에누리 이용약관</h2>
                <ul>
                    <li>에누리 서비스에 대한 정의 보완</li>
                    <li>광고 서비스 제공을 위한 조항 신설</li>
                    <li>‘에누리 오픈마켓’ 서비스 종료에 따른 조항 삭제</li>
                </ul>
                <button class="view"  id="termButton">자세히보기</button>
            </div>
            <div class="wbox">
                <h2>e머니 이용약관</h2>
                <ul>
                    <li>e머니(리워드서비스)에 대한 정의 및 정책 보완</li>
                    <li>약관 변경에 따른 사전 공지기간 변경</li>
                </ul>
                <button class="view" id="emoneyButton">자세히보기</button>
            </div>
            <p class="txt02">※자세히보기는 PC버전으로 지원<br />※개정된 내용에 동의하지 않으신 경우, 회원탈퇴 요청 가능</p>
        </div>
        <p class="frontbtn"><span id="replaceN"><a href="javascript:///">다시 보지 않기</a></span><span><a href="javascript:///" onclick="$('#terms').hide();">닫기</a></span></p>
    </div>
</script>
<script id="seasonTabTmp" type="text/x-jquery-tmpl">
<div class='season_wrap'>
	<div class="s_area">
		<div class="s_area_inner">
			{{each(prop, val) season_Tab}}
			<img src="\${val.img_web}" alt="" class="m_img" data-url="\${val.url}" data-num="\${prop}" />
			{{/each}}
		</div>
	</div>
</div>
</script>
<%@include file="/mobilefirst/include/common_logger.html"%>
</html>