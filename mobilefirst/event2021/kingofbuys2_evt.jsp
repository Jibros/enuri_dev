<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
String strFb_title = "[에누리 가격비교] 내가 브.랜.드 왕이 될상인가 이벤트";
String strFb_description = "구매왕에 도전 하면 브랜드별 인기 경품 이 쏟아진다!";
String strFb_img = ConfigManager.IMG_ENURI_COM+"/images/event/2021/buy_king/may/sns_1200_630.jpg";

if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{ //pc일때 접속페이지 변경.
	response.sendRedirect("/event2021/kingofbuy_2021.jsp");
	return;
}
String oc = ChkNull.chkStr(request.getParameter("oc"), "");
String chkId     = ChkNull.chkStr(request.getParameter("chk_id"),"");
String cUserId   = cb.GetCookie("MEM_INFO","USER_ID");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

Members_Proc members_proc = new Members_Proc();
String cUsername = members_proc.getUserName(cUserId);
String userArea = cUsername;

String strUrl = request.getRequestURI();

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;

    if(cUsername.equals(""))        userArea = cUserNick;
    if(userArea.equals(""))        userArea = cUserId;
}
String tab = ChkNull.chkStr(request.getParameter("tab"),"");
String flow = ChkNull.chkStr(request.getParameter("flow"));

SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");	//오늘 날짜
String strToday = formatter.format(new Date());
String sdt = ChkNull.chkStr(request.getParameter("sdt"));

if(!"".equals(sdt) && request.getServerName().equals("dev.enuri.com")){
	strToday = sdt;
}

String strEventId = "2021060901";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<META NAME="description" CONTENT="<%=strFb_description%>">
	<META NAME="keyword" CONTENT="에누리가격비교, 프로모션, 내가 브.랜.드 왕이 될상인가 이벤트">
	<meta property="og:title" content="<%=strFb_title%>">
	<meta property="og:description" content="<%=strFb_description%>">
	<meta property="og:image" content="<%=strFb_img%>">
	<meta name="format-detection" content="telephone=no" />
	<!-- 프로모션 공통 CSS (Mobile) -->
	<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
	<link rel="stylesheet" href="/css/event/y2021_rev/buy_king_m.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/js/swiper4.5.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
	<script type="text/javascript" src="/common/js/function.js"></script>
	<script type="text/javascript" src="/common/js/paging_evt2.js"></script>
</head>
<body>
<div id="comm-loader" class="comm-loader">
	<div class="comm-loader__inner"></div>
</div>
<script>
	function fadeOut(target) {
		var fadeTarget = document.getElementById(target);
		var fadeEffect = setInterval(function () {
			if (!fadeTarget.style.opacity) {
				fadeTarget.style.opacity = 1;
			}
			if (fadeTarget.style.opacity > 0) {
				fadeTarget.style.opacity -= 0.1;
			} else {
				fadeTarget.style.display = 'none';
				clearInterval(fadeEffect);
			}
		}, 100);
	}
	window.onload = function() {
		fadeOut('comm-loader');
		// setTimeout(function(){
		// 	fadeOut('comm-loader');
		// }, 1000); // 딜레이 1초
	};
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
<div id="wrap">
	<div class="myarea">
		<%if(cUserId.equals("")){%>	
			<p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>	
			<%}else{%>
			<p class="name"><%=userArea%> 님<span id="my_emoney">0점</span></p>
			<%}%>
		<a href="javascript:///" class="win_close">창닫기</a>
	</div>


	<!-- 프로모션 -->
	<div class="event_wrap">
		<input type="hidden" id="pagenum" name="pagenum" value="">
		<!-- visual -->
		<div class="section section-header plx plx_type_bg" data-plxtype="bg" data-plxspeed="0.5">
			<div class="bg_flow"></div>
			<div class="contents" style="width: 100%;">
				<!-- 공통 : 공유하기 버튼  -->
				<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
				<!-- // 공통 : 공유하기 버튼  -->
				<div class="txt_area">
					<h1 class="promotion_title">
						<img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/main_title.png" alt="내가 브.랜.드 왕이 될 상인가?!">
					</h1>
					<p class="promotion_subtitle">
						<span class="color-default">브랜드왕</span> 신청하고 <span class="color-default">세개의 왕좌</span>에 도전하라!<br>
					</p>
					<p class="promotion_date">
						도전기간 : 2021. 6. 9 ~ 7. 8<br>
						당첨자 발표일 : 2021. 8. 6
					</p>
				</div>

			</div>
		</div>
		<!-- //visual -->

		<!-- 네비 -->
		<div class="section section_nav">
			<div class="contents">
				<nav>
					<ul class="tab_menu_list">
						<li><a href="#evt1" class="">구매왕</a></li>
						<li><a href="#evt2" class="">출석왕</a></li>
						<li><a href="#evt3" class="">소문왕</a></li>
					</ul>
				</nav>
			</div>
		</div>
		<!-- // -->

		<section class="section section_brand">
			<div class="contents">
				<div class="section_title animated" data-animate="slideup" data-duration="1"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/title_section_brand.png" alt="참여브랜드"></div>

				<div class="slider_wrap animated" data-animate="slideup" data-duration="1">
					<ul class="brand_list"></ul>
					<div class="swiper-container"  id="service" >
						<ul class=" swiper-wrapper">
							<li class="swiper-slide"><a href="http://www.enuri.com/cmexhibition/exhibition_view.jsp?adsNo=1974" onclick="da_ga(2);" target="_blank"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/slide_brand_banner_m1.jpg"></a></li>
							<li class="swiper-slide"><a href="http://www.enuri.com/cmexhibition/exhibition_view.jsp?adsNo=1975" onclick="da_ga(3);" target="_blank"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/slide_brand_banner_m2.jpg"></a></li>
							<li class="swiper-slide"><a href="http://www.enuri.com/cmexhibition/exhibition_view.jsp?adsNo=1976" onclick="da_ga(4);" target="_blank"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/slide_brand_banner_m3.jpg"></a></li>
							<li class="swiper-slide"><a href="http://www.enuri.com/cmexhibition/exhibition_view.jsp?adsNo=1976" onclick="da_ga(5);" target="_blank"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/slide_brand_banner_m4.jpg"></a></li>
						</ul>

						<!-- navi btn remove
						<div class="btn_prev swbtn e_wrap"></div>
						<div class="btn_next swbtn e_wrap"></div>
						-->
					</div>
				</div>
				<div class="swiper-notice animated" data-animate="slideup" data-duration="1">
					※ 브랜드 배너를 클릭하면 각 브랜드 기획전으로 이동합니다.
				</div>
			</div>
			<script id="rendered-js">
				var imgUrl = ['http://img.enuri.info/images/event/2021/buy_king/may/mobile/brand_list_amd.png', 'http://img.enuri.info/images/event/2021/buy_king/may/mobile/brand_list_asus.png', 'http://img.enuri.info/images/event/2021/buy_king/may/mobile/brand_list_micron.png', 'http://img.enuri.info/images/event/2021/buy_king/may/mobile/brand_list_tt.png'];
				var mySwiper = new Swiper('#service', {
					pagination: {
						el: '.brand_list',
						clickable: true,
						renderBullet: function (index, className) {
							return '<li class="' + className + '"><img src="' + imgUrl[index] + '"></li>';
						}},
					// navigation: {
					// 	nextEl: '.btn_next',
					// 	prevEl: '.btn_prev'
					// },
					autoplay: {
						delay: 5000,
					},
					paginationClickable: true,
					centeredSlides: true,
					autoplayDisableOnInteraction: false,
					loop: true,
				});
			</script>
		</section>


		<section id="evt1" class="section_buy_king contents_scroll">
			<div class="seperate_area aqua">
				<div class="seperate_bar"></div>
				<div class="seperate_icon animated" data-animate="rotateIn" data-duration="1"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/icon_buyking.png" width="45.5" alt="구매왕"></div>
			</div>

			<div class="contents">
				<div class="icon_onlyapp"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/only_app.png" width="31.5" alt="앱전용 프로모션"></div>
				<p class="section_title animated" data-animate="slideup" data-duration="1"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/title_section_buy_king.png" alt="참여 브랜드 제품 구매하고 구매왕 도전!"></p>

				<div class="inner_content">
					<div class="gift_total_nm animated" data-animate="slideup" data-duration="1"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/subtitle_section_buy_king1.png" alt="종합구매왕"></div>
					<div class="gift_total animated" data-animate="slideup" data-duration="1">
						<div class="cnt">
							<div class="cnt_frame"></div>
							<div class="cnt_num">1</div>
						</div>
						<img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/gift_buyking_total.jpg?v=2" alt="1. ASUS VG278QR 2. 써멀테이크 TH360 ARGB Sync(화이트) 3. AMD 라이젠 5 5600X 버미어 - 정품(멀티팩) 4. 마이크론 Crucial X6 2TB">
					</div>
					<div class="gift_brand_nm animated" data-animate="slideup" data-duration="1"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/subtitle_section_buy_king2.png" alt="각 브랜드면 구매왕"></div>
					<div class="gift_brand animated" data-animate="slideup" data-duration="1">
						<div class="cnt">
							<div class="cnt_frame"></div>
							<div class="cnt_num">4</div>
						</div>
						<img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/gift_buyking_brand.jpg" alt="1. ASUS VG278QR 2. 써멀테이크 TH360 ARGB Sync(블랙) 3. AMD 라이젠 5 5600X 버미어 - 정품(멀티팩) 4. 마이크론 Crucial P5 500GB">
					</div>
					<a href="#" class="btn_buyking animated" data-animate="slideup" data-duration="1">이벤트 참여하기</a>
				</div>

				<button class="btn__evt_notice animated" data-animate="slideup" data-duration="1" data-laypop-id="layPop1">꼭! 확인하세요</button>
			</div>
		</section>
		<div id="layPop1" class="evt_notice--slide">
			<div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<dl>
							<dt>이벤트 대상 및 혜택</dt>
							<dd>
								<ul>
									<li>이벤트 대상 : 이벤트 기간 내 대상 참여 브랜드 상품 구매 후 구매왕 이벤트 응모한 고객 <span class="noti stress">※ 해당 브랜드 확인</span></li>
									<li>이벤트 기간 : 2021년 6월 9일 ~ 2021년 7월 8일</li>
									<li>이벤트 혜택 : [경품] 참고</li>
									<li>혜택 지급일 : 2021년 8월 6일<br>
										※ 당첨자 공지<br>
										[PC]에누리 가격비교 &gt; 쇼핑지식 &gt; 이벤트존 &gt; 하단[이벤트공지]<br>
										[M] 에누리 가격비교 APP &gt; 이벤트/기획전탭 &gt; 이벤트혜택 &gt; 하단 [당첨자/공지]
									</li>
									<li class="bold">이벤트 참여 브랜드 대상
										<div class="laypop_brand_list">
											<div class="laypop_brand"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/brand_list_amd.png"></div>
											<div class="laypop_brand"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/brand_list_asus.png"></div>
											<div class="laypop_brand"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/brand_list_micron.png"></div>
											<div class="laypop_brand"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/brand_list_tt.png"></div>
										</div>
									</li>
								</ul>
							</dd>
						</dl>

						<dl>
							<dt>랭킹 집계 방법</dt>
							<dd>
								<ul>
									<li>종합 구매왕: 이벤트 기간 내 참여 브랜드 제품 구매 e머니 적립금액</li>
									<li>각 브랜드 별 구매왕:  이벤트 기간 내 각 참여 브랜드 별 제품 구매 e머니 적립금액</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>경품 - 도전! 구매왕<span class="noti stress" style="font-weight: normal;">※ 제세공과금 당첨자 부담</span></dt>
							<dd>
								<ul>
									<li>종합 1등 :<br>
										AMD 라이젠 5 5600X 버미어 정품(멀티팩) + ASUS VG278QR + 마이크론 Crucial X6 2TB + 써멀테이크 TH360 ARGB Sync(화이트) (1명)</li>
									<li>각 브랜드 별 1등 :<br>
										AMD - 라이젠5 5600X 버미어정품 멀티팩 (1명) / ASUS - VG278QR (1명) / 써멀테이크 - TH360 ARGB Sync블랙 (1명) / 마이크론 - Crucial P5 500GB (1명)</li>
								</ul>
							</dd>
						</dl>

						<dl>
							<dt>E머니 구매 적립 기준 및 유의사항</dt>
							<dd>
								<ul>
									<li>적립방법 : 에누리 가격비교 모바일 앱 로그인 → 적립대상 쇼핑몰 이동 → <span class="stress">1천원 이상 구매</span> → 구매확정(배송완료) 시 e머니 적립</li>
									<li>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, Cjmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 에누리 해외직구관, SK스토아, 홈플러스</li>
									<li>구매적립 e머니는 구매일로부터 10 ~ 30일간 취소/환불/교환/반품여부 확인 후 적립 됩니다.</li>
									<li><span class="stress">구매적립 e머니 유효기간 : 적립일로부터 60일 (유효기간 만료 후 재적립 불가)</span><br>
										※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</li>
									<li>구매적립 e머니는 최소 10점(구매금액 1천원 이상)부터 적립되며, 1원 단위 e머니는 적립되지 않습니다.</li>
									<li>구매적립 e머니는 구매확정(구매일로부터 최 대 30일) 시점부터 MY 에누리 적립내역 페이지에서 확인 가능합니다.</li>
									<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다.</li>
									<li>적립대상 쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제하는 경우 구매건수는 1건이며 구매금액은 통합된 금액으로 e머니 적립 됩니다.</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>공통 이벤트 유의사항</dt>
							<dd>
								<ul>
									<li>사정에 따라 경품이 변경될 수 있습니다.</li>
									<li class="stress">구매왕 랭킹 순위는 제품 구매확정까지 다소 시간이 걸리기 때문에 2주 뒤에 랭킹 순위가 집계 됩니다.</li>
									<li>잘못된 정보 입력이나, 3회 이상 통화 시도에도 연락이 되지 않을 경우의 경품 수령 불이익은 책임지지 않습니다.</li>
									<li>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</li>
									<li>본 이벤트는 당사 사정에 따라 사전 고지 없이 변경 또는 종료 될 수 있습니다</li>
									<li>아래의 경우에는 구매 확인 및 구매적립이 불가합니다.<br>
										<div class="noti">- 에누리 가격비교 모바일 앱이 아닌 다른 모바일 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 모바일 앱으로 결제만 한 경우</div>
										<div class="noti">- 에누리 가격비교 미 로그인 후 구매한 경우</div>
										<div class="noti">- 에누리 가격비교 PC 및 모바일 웹에서 구매한 경우 (※ 티몬 및 에누리 해외직구관은 PC 및 모바일 앱/웹 구매 시에도 가능)</div>
									</li>
								</ul>
							</dd>
						</dl>
					</div>
				</div>
				<div class="evt_notice--foot">
					<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 레이어 닫기 -->
				</div>
			</div>
			<div class="evt_notice--dimmed"></div> <!-- 닫기 : 레이어 외부 클릭 -->
		</div>

		<section class="section_rank">
			<div class="contents">
				<div class="section_title animated" data-animate="slideup" data-duration="1"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/w_cont2_tit.png" alt="구매왕 랭킹TOP5"></div>

				<div class="rank_box">
					<p class="standard animated" data-animate="slideup" data-duration="1" id="standardTime">00일 00시 00분 기준</p>

					<!-- 참여자수 -->
					<div class="count_box animated" data-animate="slideup" data-duration="1">
						<span class="txt">참여자 수</span>
						<span class="numb" id="rnkCnt"> 명</span>
					</div>

					<!-- 랭킹 테이블-->
					<table class="rank_table animated" data-animate="slideup" data-duration="1" id="rank_table">
						<colgroup>
							<col width="60">
							<col />
							<col width="112">
						</colgroup>
						<thead>
						<tr>
							<th>순위</th>
							<th>아이디</th>
							<th>닉네임</th>
						</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div class="rank_table_notice color-default">
						※ 브랜드별 구매왕은 브랜드 기획전 페이지에서<br>
						별도 확인하세요.
					</div>
				</div>
			</div>
		</section>

		<section id="evt2" class="section_attendance_king contents_scroll">
			<div class="seperate_area lightblue">
				<div class="seperate_bar"></div>
				<div class="seperate_icon animated" data-animate="rotateIn" data-duration="1"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/icon_attendance.png" width="45.5" alt="출석왕"></div>
			</div>
			<div class="contents">
				<p class="section_title animated" data-animate="slideup" data-duration="1"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/title_section_attendance_king.png" alt="매일매일 스탬프 모아 출석왕 도전!"></p>

				<div class="inner_content">
					<!-- 스탬프받은 갯수 -->
					<div class="current_collect_stamp animated" data-animate="slideleft" data-duration="1">지금까지 모은 스탬프<span class="stamp_cnt">00</span>개</div>
					<!-- 스탬프받기 버튼 -->
					<a href="#" class="btn-givemethestamp animated" data-animate="slideright" data-duration="1">스탬프 받기</a>
					<div class="area_stamp animated" data-animate="slideup" data-duration="1">
						<div class="stamp_step_1">
							<div class="step_nm">1단계</div>
							<ul class="stamp">
								<li></li>
								<li></li>
								<li></li>
								<li></li>
								<li></li>
							</ul>
						</div>
						<div class="stamp_step_2">
							<span class="step_nm">2단계</span>
							<ul class="stamp">
								<li></li>
								<li></li>
								<li></li>
								<li></li>
								<li></li>
							</ul>
						</div>
						<div class="stamp_step_3">
							<span class="step_nm">3단계</span>
							<ul class="stamp">
								<li></li>
								<li></li>
								<li></li>
								<li></li>
								<li></li>
							</ul>
						</div>
					</div>
					<div class="attendance_notice animated" data-animate="slideup" data-duration="1">
						※ 스탬프를 모으면 단계별 자동응모 됩니다.<br>
						(ID당 1일 1회 참여 가능)
					</div>
				</div>
			</div>
		</section>

		<section class="section_attendance_king_gift">
			<div class="contents">
				<p class="section_title animated" data-animate="slideup" data-duration="1"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/title_section_attendance_king_gift.png" alt="출석왕 이벤트 경품"></p>

				<div class="inner_content">
					<div class="gift_nm animated" data-animate="slideup" data-duration="1"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/subtitle_section_attendance_king1.png?v=2" alt="1단계"></div>
					<div class="gift_content animated" data-animate="slideup" data-duration="1"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/gift_attendanceking1.jpg" alt="1. 파리바게뜨 아이스아메리카노(40명) 2. 먼치킨 10개팩(30명) 3. 문화상품권 10,000원(10명)">
					</div>
					<div class="gift_nm animated" data-animate="slideup" data-duration="1"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/subtitle_section_attendance_king2.png?v=2" alt="2단계"></div>
					<div class="gift_content animated" data-animate="slideup" data-duration="1"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/gift_attendanceking2.jpg" alt="1. AMD 라이젠 3 3300X마티스(1명) 2. 써멀테이크 120mm Pure A12 PWM Case Fan Single Pack - 색상랜덤(8명)">
					</div>
					<div class="gift_nm animated" data-animate="slideup" data-duration="1"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/subtitle_section_attendance_king3.png?v=2" alt="3단계"></div>
					<div class="gift_content animated" data-animate="slideup" data-duration="1"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/gift_attendanceking3.jpg" alt="1. 써멀테이크 S500 강화유리 블랙(1명) 2. ASUS VG278QR(1명)">
					</div>
				</div>
				<button class="btn__evt_notice" data-laypop-id="layPop2">꼭! 확인하세요</button>
			</div>
		</section>
		<div id="layPop2" class="evt_notice--slide">
			<div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<dl>
							<dt>이벤트 대상 및 혜택</dt>
							<dd>
								<ul>
									<li>이벤트 대상 : 20일 간 매일 출석한 회원 (자동 응모)</li>
									<li>이벤트 기간 : 2021년 6월 9일 ~ 2021년 7월 8일</li>
									<li>이벤트 혜택 : [경품] 참고</li>
									<li>혜택 지급일 : 2021년 8월 6일<br>
										※ 당첨자 공지 :<br>
										[PC] 에누리 가격비교 &gt; 고객센터 &gt; 공지사항<br>
										[M] 에누리 가격비교 APP &gt; 이벤트/기획전탭 &gt; 이벤트혜택 &gt; 하단 [당첨자/공지]
									</li>
									<li class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</li>
								</ul>
							</dd>
						</dl>

						<dl>
							<dt>경품</dt>
							<dd>
								<ul>
									<li>1단계 : 파리파게뜨 아이스 아메리카노 (e3,000) – 40명 추첨/던킨도너츠 먼치킨10개팩 (e4,000) – 30명 추첨/해피머니 문화 상품권 (e10,000) – 10명 추첨</li>
									<li>2단계 : AMD 라이젠 3 3300X 마티스 –1명 추첨/써멀테이크 120mm pure A12 pwm Case Fam Single Pack(색상랜덤)-8명 추첨 <span class="stress noti">※제세공과금 당첨자 부담</span></li>
									<li>3단계 : ASUS VG278QR 1개 – 1명 추첨/써멀테이크 S500 강화유리 블랙-1명 추첨 <span class="stress noti">※제세공과금 당첨자 부담</span></li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>이벤트 유의사항</dt>
							<dd>
								<ul>
									<li>사정에 따라 경품이 변경될 수 있습니다.</li>
									<li>스탬프를 모으면 단계별(1단계,2단계,3단계) 자동응모 됩니다.(ID당 1일 1회 참여가능)</li>
									<li>e쿠폰 스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립 해 드립니다.<br>
										※ 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격 변동이 있을 수 있습니다.</li>
									<li>잘못된 정보 입력이나, 3회 이상 통화 시도에도 연락이 되지 않을 경우의 경품 수령 불이익은 책임지지 않습니다.</li>
									<li>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</li>
									<li>본 이벤트는 당사 사정에 따라 사전 고지 없이 변경 또는 종료 될 수 있습니다</li>
									<li>아래의 경우에는 구매 확인 및 구매적립이 불가합니다.
										<div class="noti">- 에누리 가격비교 모바일 앱이 아닌 다른 모바일 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 모바일 앱으로 결제만 한 경우</div>
										<div class="noti">- 에누리 가격비교 미 로그인 후 구매한 경우</div>
										<div class="noti">- 에누리 가격비교 PC 및 모바일 웹에서 구매한 경우 (※ 티몬 및 에누리 해외직구관은 PC 및 모바일 앱/웹 구매 시에도 가능)</div>
									</li>
								</ul>
							</dd>
						</dl>
					</div>
				</div>
				<div class="evt_notice--foot">
					<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 레이어 닫기 -->
				</div>
			</div>
			<div class="evt_notice--dimmed"></div> <!-- 닫기 : 레이어 외부 클릭 -->
		</div>

		<section id="evt3" class="section_comment_king contents_scroll">
			<div class="seperate_area purple">
				<div class="seperate_bar"></div>
				<div class="seperate_icon animated" data-animate="rotateIn" data-duration="1"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/icon_commentking.png" width="45.5" alt="소문왕"></div>
			</div>

			<div class="contents">
				<p class="section_title animated" data-animate="slideup" data-duration="1"><img src="http://img.enuri.info/images/event/2021/buy_king/may/title_section_comment_king.png" alt="브랜드왕 비밀댓글 남기고 소문왕 도전!"></p>
				<p class="section_summary animated" data-animate="slideup" data-duration="1">
					브랜드왕 이벤트를 커뮤니티/SNS 2곳 이상 공유하고<br>
					URL을 비밀 댓글로 남겨주세요.<br>
					추첨을 통해 다양한 상품을 에누리가 쏜다!
				</p>
				<p class="comment_notice animated" data-animate="slideup" data-duration="1">
					(ID당 1일 1회 참여 가능 / 동일 URL 중복 불가능)
				</p>
				<img class="animated" data-animate="slideup" data-duration="1" src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/gift_commentking.jpg" alt="1. [설빙] 애플망고치즈설빙(10명) 2. [KFC] 핫크리스피치킨 5PCS(20명) 3. 신세계이마트 상품권 10,000원(30명)">
				<div class="inner_content" style="position: relative; z-index: 5;">
					<form name="form_comment_write">
						<div class="text_area_txtCnt"><strong>0</strong> / 150</div>
						<div class="write_area">
							<textarea id="textarea" maxlength="150" placeholder="이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다."></textarea>
							<button type="button" onclick="goEnter();">등록</button>
						</div>
					</form>
					<ul class="comment_list">
						<!-- 댓글 리스트 -->
						<!-- // 댓글 리스트 -->
					</ul>
					<div class="comment_pagination" id="paginate">
					</div>
				</div>
				<button class="btn__evt_notice" data-laypop-id="layPop3">꼭! 확인하세요</button>
			</div>
		</section>
		<div id="layPop3" class="evt_notice--slide">
			<div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<dl>
							<dt>이벤트 대상 및 혜택</dt>
							<dd>
								<ul>
									<li>이벤트 대상 : 본 이벤트를 페이지 상단의 공유하기를 클릭하여, 커뮤니티/SNS(카카오톡,페이스북,트위터,URL복사 등)를 통해 공유 후 비밀 댓글을 남긴 고객</li>
									<li>이벤트 기간 : 2021년 6월 9일 ~ 2021년 7월 8일</li>
									<li>이벤트 혜택 : [경품] 참고</li>
									<li>혜택 지급일 : 2021년 8월 6일<br>
										※ 당첨자 공지 :<br>
										[PC] 에누리 가격비교 &gt; 고객센터 &gt; 공지사항<br>
										[M] 에누리 가격비교 APP &gt; 이벤트/기획전탭 &gt; 이벤트혜택 &gt; 하단 [당첨자/공지]
									</li>
									<li class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</li>
								</ul>
							</dd>
						</dl>

						<dl>
							<dt>경품</dt>
							<dd>
								<ul>
									<li>1. 신세계이마트 상품권 교환권 (e10,000) – 30명</li>
									<li>2. KFC 핫크리스피치킨 (e11,300) – 20명</li>
									<li>3. 설빙 애플망고치즈설빙 (e11,990) – 10명</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>이벤트 유의사항</dt>
							<dd>
								<ul>
									<li>ID당 1일 1회 참여가능, 동일 URL 중복 불가</li>
									<li>e쿠폰 스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립 해 드립니다.<br>
										※ 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격 변동이 있을 수 있습니다.</li>
									<li>경품은 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격변동이 있을 수 있습니다.</li>
									<li>이벤트 참여 시 개인정보 수집에 동의하신 것으로 간주됩니다.</li>
									<li>이벤트의 원활한 진행을 위해 당첨자의 참여일시, 참여자ID, 본인인증확인(CI, DI)가 수집되며 수집된 개인정보는 이벤트 참여확인을 위한 본인확인 이외의 목적으로 활용되지 않습니다.</li>
									<li>개인정보 수집자(에누리 가격비교)는 이벤트 기간 동안 개인정보를 수집하며, 이벤트 당첨자 발표 후 개인정보를 즉시 파기합니다.</li>
									<li>부정 참여 시 적립 취소 및 사이트 사용이 제한될 수 있습니다.</li>
									<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료 될 수 있습니다.</li>
								</ul>
							</dd>
						</dl>
					</div>
				</div>
				<div class="evt_notice--foot">
					<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 레이어 닫기 -->
				</div>
			</div>
			<div class="evt_notice--dimmed"></div> <!-- 닫기 : 레이어 외부 클릭 -->
		</div>

		<section class="section_fullview">
			<div class="contents">
				<p class="section_title animated" data-animate="slideup" data-duration="1"><img src="http://img.enuri.info/images/event/2021/buy_king/may/mobile/title_section_fullview.png" alt="구매왕에 도전하는 여러분을 위한 인기상품 한눈에 보기!"></p>
			</div>
			<!-- 상품 영역 -->
			<div class="goods_wrap">
				<!-- 대메뉴 탭 -->
				<div class="section tabs">
					<div class="contents">
						<ul class="tabs__list">
							<!-- 선택시, li class="is-on" -->
							<li><a href="#goods1" class="tabs__item tabs__item--01">AMD</a></li>
							<li><a href="#goods2" class="tabs__item tabs__item--02">ASUS</a></li>
							<li><a href="#goods3" class="tabs__item tabs__item--03">MICRON 아스크텍</a></li>
							<li><a href="#goods4" class="tabs__item tabs__item--04">Thermaltake</a></li>
						</ul>
					</div>
				</div>
				<!-- /탭 -->

				<!-- 상단탭 상품 컨테이너 -->
				<div class="goods_container">
					<!--
						[D]
						SLICK : $(".itemlist")
						하나의 콘텐츠마다 ul 단위로 한 판(상품6개)씩 움직입니다.

						#goods1 ~ 6 영역은 반복됩니다.  ★ #goods1 마크업만 참고하시면 됩니다.
						ex) 상단탭 상품 컨텐츠(노트북)

						[[[[[상품 영역]]]]]
						DEPTH
						.tabs__list                                         - 5개 탭 목록
						.goods_container                                    - 5개 탭 컨테이너(대메뉴)
							.goods_content#goods1 ~ 5                       - 5개 탭 컨텐츠

								.tab_container                              - 컨테이너
									.tab_content                            - 추천상품 컨텐츠
										.itemlist                           - 각 상품 목록 (3*2)
					-->
					<!-- 상단탭 상품 컨텐츠(amd) -->
					<div id="goods1" class="goods_content">
						<!-- 추천상품 템플릿 -->
						<div class="tab_container">
							<!-- 추천상품-->
							<div class="tab_content">
								<div class="itemlist">
									<ul class="items clearfix">
									</ul>
								</div>
							</div>
							<!-- //추천상품-->
						</div>
						<!-- //추천상품 템플릿 -->
					</div>
					<!-- //상단탭 상품 컨텐츠(amd) -->
				</div>
				<!-- //상단탭 상품 컨테이너 -->
			</div>
			<!-- // 상품 영역-->
		</section>
		<!-- // -->
	</div>
	<!-- // 프로모션 -->

	<a href="#top" class="btn_top"><i>TOP</i></a>

	<!-- LAYER WRAP -->

<!-- (신규) 공통 : SNS공유하기 -->
	<div class="com__share_wrap dim" style="z-index:10000;display:none">
		<div class="com__layer share_layer">
			<div class="lay_head">공유하기</div>
			<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
			<div class="lay_inner">
				<ul id="eventShr">
					<li id="fbShare" class="share_fb">페이스북 공유하기</li>
					<li class="share_kakao" id="kakao-link-btn" >카카오톡 공유하기</li>				
					<li id="twShare" class="share_tw">트위터 공유하기</li>
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
							<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2021/kingofbuys2_evt.jsp?oc=mo</span>
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
	<div class="layer_back" id="app_only1" style="display:none;">
		<div class="appLayer">
			<h4>모바일 앱 전용 서비스</h4>
			<a href="javascript:///" class="close" onclick="$('#app_only1').hide();">창닫기</a>
			<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
			<p class="btn_close"><button type="button" onclick="install_btt();" >설치하기</button></p>
		</div>
	</div>
	
	<div class="layer_back" id="app_only2" style="display:none;">
		<div class="appLayer">
			<h4>모바일 앱 전용 이벤트</h4>
			<a href="javascript:///" class="close" onclick="$('#app_only2').hide();">창닫기</a>
			<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
			<p class="btn_close"><button type="button" onclick="install_btt();" >설치하기</button></p>
		</div>
	</div>
</div>
<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>

<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20180831"></script>
<script type="text/javascript">
Kakao.init('5cad223fb57213402d8f90de1aa27301');

var app = getCookie("appYN"); //app인지 여부
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로
var vEvent_title = "21년 브랜드 구매왕 프로모션";
var isFlow = "<%=flow%>" == "ad";
var vOs_type = getOsType();
var state = false;
var tab = "<%=tab%>";

var pageno = 1;
var pagesize = 5;
var totalcnt = 0;
var event_id = <%=strEventId%>;

$(".go_top").click(function(){		$('body, html').animate({scrollTop:0}, 500);	});

var shareUrl = "http://" + location.host + "/mobilefirst/event2021/kingofbuys2_evt.jsp?oc=mo";
var shareTitle = "<%=strFb_title%> <%=strFb_description%>";

var oc = '<%=oc%>';

/* 데이터 로드 영역 */
var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=46";

//전체 상품 데이터
var	ajaxData = (function() {
    var json = {};
    $.ajax({
        'async': false,
        'global': false,
        'url': loadUrl,
        'dataType': "json",
        'success': function (data) {
	    	json = data.T;
        }
    });
    return json;
})();

(function($) {
	$(function() {
		var areaWin = $(window);
		var lastScroll = 0;
		function isScrolledIntoView(target, check) {
			var docViewTop = areaWin.scrollTop();
			var docViewBottom = docViewTop + areaWin.height();
			var elemTop = target.offset().top;
			// return (docViewBottom >= elemTop);
			var animate_nm = target.data('animate');

			if(animate_nm == 'slideup') {
				if(check == 'down') {
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
				case "slidedown":
					animate_class = 'slideInDown'
					break;
				case "rotateIn":
					animate_class = 'rotateIn'
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

		function fixedNav(target) {
			var elemTop = target.offset().top;
			$(document).on("scroll", function () {
				var docViewTop = areaWin.scrollTop();
				var docViewBottom = docViewTop + areaWin.height();

				if(docViewTop > elemTop) {
					target.addClass('fixed');
					$(".myarea").addClass('f-nav');
				} else {
					target.removeClass('fixed');
					$(".myarea").removeClass('f-nav');
				}
			});
		}
		fixedNav($(".section_nav"));

		function customPlx(){
			$('.plx').each(function(index, item){
				var elemTop = $(item).offset().top;
				var docViewTop = $(window).scrollTop();
				var docViewBottom = docViewTop + $(window).height();

				var unit = 0.5*-1;
				var pos_bg = ((docViewTop - elemTop) * unit);
				if(docViewBottom >= elemTop) {
					$(item).animate({
						'background-position-y': pos_bg
					},400);
				}
				$(window).scroll(function(){
					var docViewTop = $(window).scrollTop();
					var pos_bg = ((docViewTop - elemTop) * unit);
					if(docViewBottom >= elemTop) {
						$(item).css('background-position-y', pos_bg);
					}
				});

			});
		}
		customPlx();
	});
})(jQuery);

(function (global, $) {
	$(function () {
		// 해당 섹션으로 스크롤 이동
		$menu.on('click', 'a', function (e) {
			e.preventDefault();
			var $target = $(this).parent(),
				idx = $target.index(),
				offsetTop = Math.ceil($contents.eq(idx).offset().top);

			$('html, body').stop().animate({ scrollTop: (offsetTop-100)}, 500);
			return false;
		});
	});

	var $menu = $('.tab_menu_list li'),
		$contents = $('.contents_scroll');

	$(window).scroll(function(){
		$('a', $menu).removeClass("active");
		var area_evt1 = $("#evt1").offset().top;
		var area_evt2 = $("#evt2").offset().top;
		var area_evt3 = $("#evt3").offset().top;
		var docViewTop = $(window).scrollTop()+151;
		if((docViewTop >= area_evt1) && (docViewTop <= area_evt2)) {
			$('a', $menu[0]).addClass("active");
		} else if((docViewTop >= area_evt2) && (docViewTop <= area_evt3)) {
			$('a', $menu[1]).addClass("active");
		} else if(docViewTop >= area_evt3){
			$('a', $menu[2]).addClass("active");
		}
	});

}(window, window.jQuery));

// 유의사항 열기/닫기
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

/*레이어*/
function onoff(id) {
	var mid=document.getElementById(id);
	if(mid.style.display=='') {
		mid.style.display='none';
	}else{
		mid.style.display='';
	}
}

$(document).ready(function() {
	ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_PV");
	
	if(oc!=""){
		$('.lay_only_mw').show();
	}
	$("#my_emoney").click(function(){	
		window.location.href = "https://m.enuri.com/my/my_emoney_m.jsp?freetoken=emoney";	//e머니 적립내역
	});
	
	
	$(".btn_login").click(function(){
		location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
		return false;
	})
	
	$(".btn_buyking").click(function(){
		da_ga(6);
		if(app=="Y"){
			btn_join();
		}else{
			$('.lay_only_mw').show();
			return false;			
		}
	});
	
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
	
	if(islogin()){
		getPoint();
	}
	
	//구매왕 랭킹
	getRnk();
	
	//출석왕
	var stamp_btn = $(".btn-givemethestamp");
	var stamp = $('.stamp');
	var stamp_active = stamp.find("li.active");
	stamp_btn.on('click', function(e){
		e.preventDefault();
		if(!islogin()){
			alert("로그인 후 신청 가능합니다!");
			location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
			return false;
		}else{
			if(!getSnsCheck()){
				if (confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?") == true){    
					location.href="<%=ConfigManager.ENURI_COM_SSL%>/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
					return false;
				}else{
					return false;
				}
			}else{
				$.ajax({
					type: "GET",
					url: "/knowcom/api/setAttendEvt.jsp?event_code="+event_id,
					dataType: "JSON",
					async : false,
					success: function(json){
						if(json.result == 1){
							//stamp.find("li").not(stamp_active).eq(0).addClass('active');
							alert('스탬프가 발급되었습니다.');
							getStamp();
						}else if(json.result == -3){
							alert('이미 오늘 스탬프를 받으셨습니다.');
						}else if(json.result == -4){
							alert("임직원은 참여 불가합니다.");
						}else if(json.result == -1 || json.result == -5){
							alert("다시 확인해주세요.");
						}
					} 
					/* ,error: function (xhr, ajaxOptions, thrownError) {
						console.log(xhr.status);
						console.log(thrownError);
					} */
				});
				
			}
		}
	});
	
	getStamp();
	
	//댓글 리스트
	getReply();
	
	tabLoading();
	
	$("body").on('click', '.items > li', function(event) {
		var modelno = $(this).attr("data-mn");
		var price = $(this).attr("data-price");
		
		var line = 0;
		
		$(".tabs__list > li").each(function(i,v){
			var cls = $(this).attr("class");
			if(cls == "is-on"){
				line = i;
			}
		});
		
		if(line == 0)        da_ga(7);       
		else if(line == 1)   da_ga(8);
		else if(line == 2)	 da_ga(9);
		else if(line == 3)   da_ga(10);
		
		itemClick(modelno,price);
		return false;
	});
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

function itemClick(modelNo, minprice) {
	
	da_ga(11);
	
	if(minprice > 0){
		window.open('/mobilefirst/detail.jsp?modelno=' + modelNo +'&freetoken=vip');
	}else{
		alert("품절된 상품 입니다.");
	}
}

function arrayShuffle(oldArray) {
    var newArray = oldArray.slice();
    var len = newArray.length;
    var i = len;
    while (i--) {
        var p = parseInt(Math.random()*len);
        var t = newArray[i];
        newArray[i] = newArray[p];
        newArray[p] = t;
    }
    return newArray;
};

function arrayShuffle2(oldArray) {
    var newArray = oldArray;
    var len = newArray.length;
    var i = len;
    while (i--) {
        var p = parseInt(Math.random()*len);
        var t = newArray[i];
        newArray[i] = newArray[p];
        newArray[p] = t;
    }
    return newArray;
};
var nowTab = 1;
function tabLoading(){
	//가격대별 탭 컨텐츠
	$(".goods_content .tab_content").hide(); 
	$("ul.tabs__list li").removeClass("is-on"); 
	//첫 로딩 시, 랜덤 노출
  var rndNum = Math.floor(Math.random() * 3);
  nowTab = rndNum+1;
  console.log(nowTab)
  
  $(".goods_content").attr("id","goods"+nowTab);
  
  var object = ajaxData[rndNum]["GOODS"];
	loadGoodsList(object);
	
	$(".tabs__list li").eq(rndNum).addClass("is-on").show();
  
	$(".goods_content .tab_content:first").show();
	//$("ul.tabs__list li").eq(0).trigger("click");
	
	$("ul.tabs__list li").click(function() {
		$("ul.tabs__list li").removeClass("is-on"); 
		$(this).addClass("is-on");
		//$(".pro_itemlist .tab_content").hide(); 
		var activeTab = $(this).find("a").attr("href");
		//$(activeTab).fadeIn();
		//proSlide.slick("setPosition");
		$(".goods_content").attr("id","goods"+activeTab.substring(7, 8));
		
		//가격대별 플리킹
		proSlide.slick("destroy");
		if(activeTab == "#goods1"){
			var object = ajaxData[0]["GOODS"];
			loadGoodsList(object);
			
			proSlide = $('.itemlist').slick({
				dots:false,
				slidesToScroll: 1
			});
			da_ga(7);
			nowTab = 1;
		}else if(activeTab == "#goods2"){
			var object = ajaxData[1]["GOODS"];
			loadGoodsList(object);
			proSlide = $('.itemlist').slick({
				dots:false,
				slidesToScroll: 1
			});
			da_ga(8);
			nowTab = 2;
		}else if(activeTab == "#goods3"){
			var object = ajaxData[2]["GOODS"];
			loadGoodsList(object);
			
			proSlide = $('.itemlist').slick({
				dots:false,
				slidesToScroll: 1
			});
			da_ga(9);
			nowTab = 3;
		}else if(activeTab == "#goods4"){
			var object = ajaxData[3]["GOODS"];
			loadGoodsList(object);
			proSlide = $('.itemlist').slick({
				dots:false,
				slidesToScroll: 1
			});
			da_ga(10);
			nowTab = 4;
		}
		return false;
	});
	
	//플리킹
	var proSlide = $('.tab_content .itemlist').slick({
		dots:false,
		slidesToScroll: 1
	});
	
}
function loadGoodsList(obj){
	var goodsList = arrayShuffle2(obj);
	var html = "";
	
	if(goodsList.length >0){
		
		for(var i=0;i<goodsList.length;i++){
			if(i<12){
				if(i%4==0) html += "<ul class=\"items clearfix\">";
					
					var goodsData = goodsList[i];
					var modelno = goodsData["MODELNO"];
					var goods_img = goodsData["GOODS_IMG"];
					var goods_title1 = goodsData["TITLE1"];
					var goods_title2 = goodsData["TITLE2"];
					var goods_minprice = goodsData["MINPRICE"]==null?0:goodsData["MINPRICE"];
					
					html+= "<li class=\"item\" data-mn='"+goodsData["MODELNO"]+"' , data-price='"+goodsData["MINPRICE"]+"' >";
					html+= "	<a href=\"javascript:;\" title=\"새 탭에서 열립니다.\">";
					html+= "		<span class=\"thumb\">";
					html+= "			<img src=\""+goodsData["GOODS_IMG"]+"\" alt=\"\" />";
					if(goodsData["MINPRICE"]==0){
					html+= "			<span class=\"soldout\">SOLD OUT</span>";	
					}
					html+= "		</span>";
					html+= "		<span class=\"pro_info\">";
					html+= "			<span class=\"pro_name\">"+goods_title1+"<br />"+goods_title2+"</span>";
					html+= "			<span class=\"price\"><em class=\"minp\">최저가 </em><em>"+numberWithCommas(goods_minprice)+"</em><span class=\"pro_unit\"> 원</span></span>";
					html+= "		</span>";
					html+= "	</a>";
					html+= "</li>";	
					
				if(i%4==3) html += "</ul>";
			}
		}
		
		$(".itemlist").html(html);
	}
}

function numberWithCommas(x) {   return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");		}

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

function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2021%2Fkingofbuys2_evt.jsp%3Ffreetoken%3Devent";
	
	if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
		goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2021/kingofbuys2_evt.jsp?freetoken=event";
		chrome25 = uagentLow.search("chrome") > -1 && navigator.appVersion.match(/Chrome\/\d+.\d+/)[0].split("/")[1] > 25;
		kitkatWebview = uagentLow.indexOf("naver") != -1 || uagentLow.indexOf("daum") != -1;
		if(kitkatWebview){
			setTimeout( function() {
				if (new Date - openAt < 1100) {
					if (uagentLow.search("android") > -1) {
						location.href = "market://details?id=com.enuri.android";
					}
				}
			}, 1000);
		}else{
			setTimeout( function() {
				if (new Date - openAt < 1500) {
					if (uagentLow.search("android") > -1) {
						location.href = "market://details?id=com.enuri.android";
					}
				}
			}, 1000);
		}
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
			window.location.replace("https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8");
		}, 2000);
		location.href = goApp;
	}
}

function btn_join() {
	
	if(!islogin()){
		
		alert("로그인 후 신청 가능합니다!");
		location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
		return false;
		
	}else{
		if(!getSnsCheck()){
		
			if (confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?") == true){    
				location.href="<%=ConfigManager.ENURI_COM_SSL%>/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
				return false;
			}else{
				return false;
			}
			
		}else{
			
			$.ajax({
				type: "GET",
				url: "/mobilefirst/evt/ajax/kingofbuys2_setlist.jsp?proc=1&osType="+getOsType(),
				dataType: "JSON",
				async : false,
				success: function(json){
					
					if(json.result == 1){
						alert("정상 참여 되었습니다.");
					}else if(json.result == 2601){
						alert("이미 참여 하셨습니다.\n구매왕에 도전하세요!");
					}else if(json.result == -99){
						alert("대상 카테고리 상품 구매 후 응모 가능합니다.");
					}else if(json.result == 100){
						alert("이벤트가 종료 되었습니다.");
					}else if(json.result == -100){
						alert("임직원은 참여 불가합니다.");
					}

				} 
				/* ,error: function (xhr, ajaxOptions, thrownError) {
					console.log(xhr.status);
					console.log(thrownError);
				} */
			});
			
		}
	}
}

function getRnk(){
	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/evt/ajax/kingofbuys2_setlist.jsp?proc=2",
		async: false,
		dataType:"JSON",
		success: function(json){
			var joincnt = json["joincnt"];	//참여자
			var jsonObj = json["list"];
			$("#rnkCnt").html(CommaFormattedN(joincnt) +" 명");
			
			var html = "";
			var startDate = "";
			var updateDate = "";
			if(jsonObj) {
				$.each(jsonObj, function(Index, listData) {
					var rnk = listData["rnk"];
					var enr_usr_id = listData["enr_usr_id"];
					var view_nm = listData["view_nm"];
					var ins_dtm = listData["ins_dtm"];
					var upd_dtm = listData["upd_dtm"];
					
					if(Index==0) {
						startDate = upd_dtm.substring(0,10);
						updateDate = upd_dtm.substring(0,16);
					}
					
            		html += "<tr>";
            		html += "	<td>"+rnk+"</td>";
            		html += "	<td>"+enr_usr_id+"</td>";
            		html += "	<td>"+view_nm+"</td>";
            		html += "</tr>";
            	});
				
				if(html!=""){
					var date = new Date();
				    var day = updateDate.substring(8,10);
				    var hours = updateDate.substring(11,13);
				    var minutes = updateDate.substring(14,16);
					$("#standardTime").html(day+"일 "+hours+"시 "+minutes+"분 기준");
					
					var startDateArr = startDate.split('-');
			         
			        var endDate = '2021-06-09';
			        var endDateArr = endDate.split('-');
			                 
			        var startDateCompare = new Date(startDateArr[0], startDateArr[1], startDateArr[2]);
			        var endDateCompare = new Date(endDateArr[0], endDateArr[1], endDateArr[2]);
			        
			        if(startDateCompare.getTime() >= endDateCompare.getTime()) {
						$("#rank_table tbody").html(html);
			        }else{
			        	$(".section_rank").hide();
			        }
				}else{
					$(".section_rank").hide();
				}
			}
			
		}
	});
}

$("#textarea").keyup(function (e){
    var content = $(this).val();
    $('.text_area_txtCnt strong').html(content.length);
});

function getStamp(){
	$.ajax({
		type: "GET",
		url: "/knowcom/api/getAttendEvt.jsp?event_code="+event_id,
		dataType: "JSON",
		async : false,
		success: function(json){
			var stampCnt = json.result;
			if(stampCnt > 0){
				$(".stamp_cnt").html(stampCnt);
				for(var i=0;i<stampCnt;i++){
					$('.stamp').find("li").eq(i).addClass('active');
				}
			}
		} 
		/* ,error: function (xhr, ajaxOptions, thrownError) {
			console.log(xhr.status);
			console.log(thrownError);
		} */
	});
}

//게시판
function goEnter(){
	  if(!islogin()){
        alert("로그인 후 참여 가능합니다.");
        goLogin();
        return false;
    }else{
    	goReplay();
    }
}

function goReplay(){
	
  var txtcnt = $("#textarea").val().length;
	
  if(txtcnt > 150){
	  alert("150글자 까지만 입력 가능합니다.");
	  return false;
  }

  var reply = $("#textarea").val();
  var count = reply.length;

  if(reply == "이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다."){
    alert("내용을 입력해주세요!");
    $("#textarea").focus();
    return false;
  }

  var blank_pattern = /^\s+|\s+$/g;
  if( $("#textarea").val().replace( blank_pattern, '' ) == "" ){
      alert(' 내용을 입력해주세요! ');
      return false;
  }

  if(count == 0)             alert("내용을 입력해주세요!");
  else{
       var vData = {event_code:event_id, txt:reply, max_length:150, perday : "true", osType:vOs_type };
       $.ajax({
          type: "POST",
          url: "/knowcom/api/setReplyEvt.jsp",
          data : vData ,
          dataType: "JSON",
          success : function(data) {
  			var result = data.result;
  			switch (result) {
  				case 1  :
  					alert("등록 되었습니다.");
  					$("#textarea").val('').trigger("keyup");
  					getReply(1);
  					break;
  				case -3 :
  					alert("이미 참여했습니다.");
  					break;
  				case -4 :
  					alert("임직원은 참여가 불가합니다.");
  					break;
  				case -5 :
  	        		if (confirm("로그인 후 작성할 수 있습니다.\n로그인 하시겠습니까?")) {
  	        			goLogin();	// 로그인 화면 이동
  	        		}
  	        		break;
  				default :
  					alert("잘못된 접근입니다.");
  					break;
  			}
  		},
        error: function (xhr, ajaxOptions, thrownError) {}
       });
   }
	
}

//댓글 리스팅
function getReply(){
	pageno = $("#pagenum").val()!==""?$("#pagenum").val():1;
	var makeHtml = "";
	var makeHtml2 = "";
	var cnt = 5;
	if(pageno > 0){
		$.ajax({
			url:"/knowcom/api/getReplyEvt.jsp",
			type:"get",
			data:{
				  "page"       : pageno
				, "cnt"        : cnt
				, "event_code" : event_id
				, "secret" : true
				 },
			dataType:"json",
			success:function(result){
				var totalcnt = result.total;
				var replyList = result.list;

				$.each(replyList,function(i,v){
					makeHtml += "<li>";
					makeHtml += "	<div class=\"comment_author\">";
					makeHtml += 		v.nickname;
					makeHtml += "		<span class=\"date\">"+v.insdate+"</span>";
					makeHtml += "	</div>";
					makeHtml += "	<div class=\"comment_intext\">";
					makeHtml += v.ptcp_cts;
					makeHtml += "	</div>";
					makeHtml += "</li>";
				});

				$('.comment_list').html(makeHtml);
				
				if (totalcnt != 0) {
 					var paging2 = new paging(parseInt(pageno), pagesize, cnt, totalcnt, 'paginate','goPage');
 				  	paging2.calcPage();
 				  	paging2.getPaging();
 				  	if(pageno!=1){
 				  		var offset = $(".comment_list").offset();
 	        	    	$("html,body").stop(true).animate({scrollTop:offset.top - 50},50,"swing");
 				  	}
 				}
			},
			complete:function(){
				$("#paginate .btn_page").click(function(e){
	  				var num = $(this).attr("num");
	  				goPage(num);
	  			});
			}
		});
	}
}

//페이지 이동
function goPage(pageno) {
	$("#pagenum").val(pageno);
	getReply();
}

function da_ga(num){
	if(num == 2){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_브랜드_AMD");
	}else if(num == 3){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_브랜드_ASUS");
	}else if(num == 4){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_브랜드_마이크론");
	}else if(num == 5){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_브랜드_써멀테이크");
	}else if(num == 6){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_구매왕_응모");
	}else if(num == 7){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_쇼핑가이드_AMD");
	}else if(num == 8){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_쇼핑가이드_ASUS");
	}else if(num == 9){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_쇼핑가이드_마이크론");
	}else if(num == 10){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_쇼핑가이드_써멀테이크");
	}else if(num == 11){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_쇼핑가이드_상품");
	}
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
		}
		/* ,error: function (xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		} */
	});
	return snsCertify;
}
//닫기버튼
$('.win_close').click(function(){
	if(getCookie("appYN") == 'Y'){
		window.location.href = "close://";
	}else{
		window.location.replace("/m/index.jsp");
	}
});

function getOsType(){
    var osType = "";
    if(app =='Y'){
         if(navigator.userAgent.indexOf("Android") > -1)		        	 osType = "MAA";
         else		        	 osType = "MAI";
    }else {
         if(navigator.userAgent.indexOf("Android") > -1)		        	 osType = "MWA";
         else		        	 osType = "MWI";
    }
    return osType;
}
CmdShare();
function CmdShare(){
	Kakao.Link.createDefaultButton({
	  container: '#kakao-link-btn',
      objectType: 'feed',
      content: {
        title: '<%=strFb_title%>',
        description: "구매왕에 도전 하면 브랜드별 인기 경품 이 쏟아진다!",
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

</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
