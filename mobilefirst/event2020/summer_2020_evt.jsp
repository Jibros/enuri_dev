<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
	String strFb_title = "여름 맞이 이벤트! - 최저가 쇼핑은 에누리";
	String strFb_description = "올 여름 COOL템 구매하면, 딜라이트 탄산수 제조기 추첨 증정!";
	String strFb_img = ConfigManager.IMG_ENURI_COM
			+ "/images/event/2020/summer_pro/sns_1200_630_03.jpg";

	if (ChkNull.chkStr(request.getHeader("User-Agent")).indexOf(
			"iPhone") > -1
			|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf(
					"Android") > -1
			|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf(
					"iPod") > -1
			|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf(
					"iPad") > -1) {
	} else { //pc일때 접속페이지 변경.
		response.sendRedirect("/event2020/summer_2020_evt.jsp");
		return;
	}

	String chkId = ChkNull.chkStr(request.getParameter("chk_id"), "");
	String cUserId = ChkNull.chkStr(
			cb.GetCookie("MEM_INFO", "USER_ID"), "");
	String cUserNick = ChkNull.chkStr(
			cb.GetCookie("MEM_INFO", "USER_NICK"), "");

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

	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd"); //오늘 날짜
	String strToday = formatter.format(new Date());
	String sdt = ChkNull.chkStr(request.getParameter("sdt"));

	if (!"".equals(sdt)
			&& request.getServerName().equals("dev.enuri.com")) {
		strToday = sdt;
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<META NAME="description" CONTENT="올 여름 COOL템 구매하면,  딜라이트 탄산수 제조기 추첨증정!">
<META NAME="keyword"
	CONTENT="에누리가격비교, 프로모션, 여름에누리다, 무더위, 무더위 이벤트, 매일참여">
<meta property="og:title" content="여름 맞이 이벤트! - 최저가 쇼핑은 에누리">
<meta property="og:description" content="올 여름 COOL템 구매하면, 딜라이트 탄산수 제조기 추첨 증정!">
<meta property="og:image" content="<%=strFb_img%>">
<meta name="format-detection" content="telephone=no" />
<!-- 프로모션 공통 CSS (Mobile) -->
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css"
	type="text/css">
<!-- 프로모션별 커스텀 CSS  -->
<link rel="stylesheet" href="/css/event/y2020/summer_pro_m.css"
	type="text/css">
<link rel="stylesheet" type="text/css"
	href="/mobilefirst/css/lib/slick.css" />
<script type="text/javascript"
	src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
<script type="text/javascript" src="/common/js/function.js"></script>
</head>
<body>
	<div id="eventWrap">
		<div class="myarea">
			<p class="name">
				나의 <em class="emy">머니</em>는 얼마일까?
				<button type="button" class="btn_login" onclick="goLogin();">로그인</button>
			</p>
			<a href="javascript:///" class="win_close">창닫기</a>
		</div>
		<!-- 플로팅 배너 - 둥둥이 -->
		<div id="floating_bnr" class="floating_bnr">
			<a href="javascript:///" onclick="floating_bnr()"> <img
				src="http://img.enuri.info/images/event/2020/summer_pro/fl_bnr.png"
				alt="매주 목요일 여름준비 타임딜">
			</a>
			<!-- 닫기 -->
			<a href="javascript:///" class="btn_close"
				onclick="onoff('floating_bnr');return false;"> <span
				class="blind">닫기</span>
			</a>
		</div>
		<!-- // -->
		<!-- 비쥬얼,플로팅탭 -->
		<div class="toparea">
			<!-- 상단비주얼 -->
			<div class="visual">
				<!-- 공통 : 공유하기 버튼  -->
				<button class="com__btn_share"
					onclick="$('.com__share_wrap').show();">공유하기</button>
				<!-- // -->
				<div class="inner">
					<span class="txt_01">HOT SUMMER</span>
					<h2>"여름에 누리다"</h2>
					<span class="txt_02">여름준비 타임특가+딜라이트 탄산수 제조기 당첨!</span>
				</div>
				<div class="loader-box">
					<div class="visual-loader"></div>
				</div>
				<script>
				// 상단 타이틀 등장 모션
				$(window).load(function(){
					var $visual = $(".toparea .visual");
					// $visual.addClass("intro");
					setTimeout(function(){
						$visual.addClass("intro");
						// $visual.addClass("end");
					},2100)
				})
			</script>
			</div>
			<div class="section floattab">
				<div class="contents">
					<ul class="floattab__list">
						<li><a href="#evt1" class="floattab__item floattab__item--01">얼음
								속 음료를 찾아라!</a></li>
						<li><a href="#evt2" class="floattab__item floattab__item--02">여름템
								구매하면 탄산수 머신 겟</a></li>
						<li><a href="javascript:///" onclick="goPlan();" class="floattab__item floattab__item--03">시원한 여름준비</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- //비쥬얼,플로팅탭 -->

		<!-- 이벤트01 -->
		<div id="evt1" class="section evt_1st scroll">
			<div class="contents">
				<h2>
					EVENT.01 얼음 속 아이스티를 찾아라! 매일매일 스벅 아이스티 당첨 <em>스타벅스 라임 패션 티 Tall
						e머니 5,600점</em>
				</h2>
				<!-- 게임화면 -->
				<div class="icegame">
					<div class="icegame_inner" style="display: block;">
						<span class="ship"></span> <span class="seagull"></span>
						<ul class="ices">
							<!-- 아이스 모양 stat-0~3 -->
							<li class="ice1 stat-0"><span class="ice">
									<!--얼음1-->
							</span><span class="hammer">
									<!--망치-->
							</span></li>
							<li class="ice2 stat-0"><span class="ice">
									<!--얼음2-->
							</span><span class="hammer">
									<!--망치-->
							</span></li>
							<li class="ice3 stat-0"><span class="ice">
									<!--얼음3-->
							</span><span class="hammer">
									<!--망치-->
							</span></li>
						</ul>
					</div>
					<div class="layer_area" style="display: none;">
						<!-- case 1 : 축하합니다. 아이스티를 찾으셨어요! -->
						<div class="layer_success" style="display: none;">
							<span>축하합니다. 아이스티를 찾으셨어요!</span>
						</div>
						<!-- case 2 : 땡! 시원한 아이스티 그림을 찾았네요! -->
						<div class="layer_fail type1" style="display: none;">
							<span>땡! 시원한 아이스티 그림을 찾았네요!</span>
						</div>
						<!-- case 3 : 땡! 아무것도 없네요^^; -->
						<div class="layer_fail type2" style="display: none;">
							<span>땡! 아무것도 없네요^^;</span>
						</div>
					</div>
				</div>
				<a href="#" class="btn_caution evt-caution-1"
					onclick="onoff('notetxt1'); return false;">꼭!확인하세요</a>
			</div>
		</div>
		<!-- //이벤트01 -->

		<!-- 추천 상품 영역 -->
		<div class="section pro_itemlist">
			<div class="contents">
				<h2>
					바캉스부터 홈캉스까지! <em>여름을 100% 즐기는</em> 쇼핑가이드
				</h2>
				<!-- 추천상품 탭 -->
				<div class="pro_tabs_wrap">
					<div class="scrollList">
						<ul class="pro_tabs">
							<li class="active"><a href="#protab1">COOL한 여름가전</a></li>
							<li><a href="#protab2">기력보충 제철음식</a></li>
							<li><a href="#protab3">프로집콕러 홈캉스</a></li>
							<li><a href="#protab4">Flex한 국내 여행</a></li>
							<li><a href="#protab5">완벽한 바캉스준비</a></li>
						</ul>
					</div>
				</div>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">
					<!-- 
					SLICK $(".itemlist")
					4개의 탭 콘텐츠가 있습니다. "tab_content"
					하나의 콘텐츠마다 ul 단위로 한 판(상품4개)씩 움직입니다. 				
				-->
					<!-- COOL한 여름가전 -->
					<div id="protab1" class="tab_content">
						<div class="itemlist"></div>
						<a class="sprite btn_more" href="javascript:///">상품더보기</a>
					</div>
					<!-- //COOL한 여름가전 -->
					<!-- 기력보충 제철음식 -->
					<div id="protab2" class="tab_content">
						<div class="itemlist"></div>
						<a class="sprite btn_more" href="javascript:///">상품더보기</a>
					</div>
					<!-- //기력보충 제철음식 -->
					<!-- 프로집콕러 홈캉스 -->
					<div id="protab3" class="tab_content">
						<div class="itemlist"></div>
						<a class="sprite btn_more" href="javascript:///">상품더보기</a>
					</div>
					<!-- //프로집콕러 홈캉스 -->
					<!-- FLEX한 모바일쿠폰 -->
					<div id="protab4" class="tab_content">
						<div class="itemlist"></div>
						<a class="sprite btn_more" href="javascript:///">상품더보기</a>
					</div>
					<!-- //FLEX한 모바일쿠폰 -->
					<!-- 완벽한 바캉스준비 -->
					<div id="protab5" class="tab_content">
						<div class="itemlist"></div>
						<a class="sprite btn_more" href="javascript:///">상품더보기</a>
					</div>
					<!-- //완벽한 바캉스준비 -->

				</div>
				<!-- //추천상품 콘텐츠 -->

			</div>
		</div>
		<!-- //추천 상품 영역 -->

		<!-- 이벤트02 -->
		<div id="evt2" class="section evt_2rd scroll">
			<h3 class="tit">APP에서 여름 준비하면</h3>
			<p class="blind">짜릿한 딜라이트 탄산수머신 당첨!</p>
			<div class="contents">
				<div class="evt2_area">
					<div class="evt2_area__inner">
						<div class="blind">
							<ol>
								<li>1등 딜라이트소다 셰프 탄산수 제조기(실물배송/색상랜덤)</li>
								<li>2등 피자헛 메가콤비A 포테이토피자+파스타+콜라</li>
								<li>3등 스무디킹 스트로베리 익스트림</li>
							</ol>
						</div>
					</div>
					<ul class="btn_wrap">
						<li><a href="javascript:///" class="btn_goevt"
							target="_blank" title="새창 열림">기획전 보러 가기 &gt;</a></li>
						<li><a href="javascript:///" class="btn_apply"
							id="event2_join">응모하기 &gt;</a></li>
					</ul>
				</div>
			</div>

			<!-- 유의사항 WRAPPER -->
			<div class="caution-wrap">
				<a href="javascript:///" class="btn_caution evt-caution-2">꼭!확인하세요</a>
				<!-- 유의사항 드롭다운 -->
				<div class="moreview"
					style="border-bottom: 1px solid rgb(34, 34, 34); display: none;">
					<h4>유의사항</h4>
					<div class="txt">
						<dl class="txtlist">
							<dt>이벤트/구매 기간 :</dt>
							<dd>2020년 6월 29일 ~ 2020년 8월 02일</dd>
						</dl>

						<dl class="txtlist">
							<dt>당첨자 발표 및 적립</dt>
							<dd>2020년 10월 29일 [APP 이벤트/기획전 탭 &gt; 이벤트 하단 당첨자 발표]</dd>
						</dl>

						<dl class="txtlist">
							<dt>경품 :</dt>
							<dd>
								1등 – 딜라이트소다 셰프 탄산수 제조기 - 3명 추첨 <strong class="emp">※제세공과금
									당첨자 부담</strong>
							</dd>
							<dd>2등 – 피자헛 메가콤비A (e 21,900점) - 15명 추첨</dd>
							<dd>
								3등 – 스무디킹 스트로베리 익스트림 (e 5,900점) – 50명 추첨<br>
								<br>
							</dd>
							<dd>
								<strong>e머니 유효기간 : 적립일로부터 15일</strong>
							</dd>
							<dd>사정에 따라 경품이 변경될 수 있습니다.</dd>
							<dd>
								<strong>잘못된 정보 입력으로 인한 경품 수령의 불이익은 책임지지 않습니다.</strong>
							</dd>
							<dd>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</dd>
							<dd>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다.</dd>
							<dd>본 이벤트 당첨은 더블적립 및 무제한적립 참여 시 혜택 지급이 불가합니다.</dd>
						</dl>

						<dl class="txtlist">
							<dt>구매 적립 기준 및 유의사항</dt>
							<dd>
								에누리 가격비교 앱 로그인 → 적립대상 쇼핑몰 이동 → 구매하기 → 구매확정(배송완료) 금액이 1,000원 이상 시
								e머니 적립 <br>
								<span class="emp">※ 티몬의 경우 PC 및 모바일 앱/웹에서 로그인 후 구매시 e머니
									적립!</span>
							</dd>
							<dd>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP,
								CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), SK스토아</dd>
							<dd>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품 결제금액만 반영</dd>
							<dd>구매 e머니는 구매 확인완료 시점(구매 후 최대 30일)부터 마이 에누리 → 적립내역 페이지에서 확인
								가능</dd>
							<dd>구매 e머니는 카테고리에 따라 차등 적립</dd>
							<dd>더블적립 및 무제한적립 참여 시 혜택 지급이 불가합니다.</dd>
						</dl>

						<dl class="txtlist">
							<dt>
								※ 카테고리별 적립률 상세
								<div class="tb">
									<table>
										<colgroup>
											<col width="65%">
											<col width="30%">
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
												<td>패션,잡화</td>
											</tr>
											<tr>
												<td>가구,인테리어/생활,취미</td>
											</tr>
											<tr>
												<td>모바일쿠폰,상품권 <br> <span class="emp">*특정
														상품에 한하여 적립되오니<br>적립가능 상품은 하단에서 확인해주세요.
												</span>
												</td>
												<td>0.2%</td>
											</tr>
										</tbody>
									</table>
								</div>
							</dt>
							<dd>적립대상쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제 시 구매건수는 1건이며, 구매금액은 통합
								결제한 금액의 e머니 적립</dd>
							<dd>결제일로부터 10~30일간 취소/반품여부 확인 후 적립</dd>
							<dd>
								e머니는 최소 10점부터 적립되며 (구매금액 1,000원 이상), 1원 단위 e머니는 적립되지 않습니다. <br>(예:
								1,200원 결제 시 e머니 10점 적립)
							</dd>
							<dd>
								<span class="emp">구매적립 e머니 유효기간: 적립일로부터 60일</span>
							</dd>
							<dd>적립된 e머니는 e쿠폰 스토어에서 다양한 e쿠폰으로 교환 가능합니다.</dd>
						</dl>

						<dl class="txtlist">
							<dt>
								<span class="emp">모바일쿠폰, 상품권 적립 상세</span>
							</dt>
							<dd>적립가능 쇼핑몰: 티몬, G마켓, 옥션</dd>
							<dd>적립가능 상품 (0.2% 적립): 문화상품권(해피머니, 컬쳐랜드), 도서상품권, 백화점상품권,
								영화예매권, 국민관광 상품권</dd>
							<dd>적립가능 상품을 제외한 상품권, 지역쿠폰, e교환권, e쿠폰은 적립불가</dd>
							<dd style="background: none">
								<strong class="stress">※ 백화점 상품권 적립기준</strong>
								<ul>
									<li>1) 상품명에 '백화점 상품권' 명시된 상품 또는 백화점에서만 사용할 수 있는 상품권만 적립</li>
									<li>2) 복합상품권 적립불가(삼성 상품권/신세계 기프트카드/롯데카드 상품권/이랜드 상품권/AK플라자
										상품권/통합 상품권 등)</li>
									<li>3) 복합 상품권의 경우 사용처에 백화점이 기재되어 있는 경우에도 적립불가</li>
									<li>4) 백화점 상품권으로 전환 가능한 포인트 구매시 적립불가</li>
								</ul>
							</dd>
						</dl>

						<dl class="txtlist">
							<dt>아래의 경우에는 구매 확인 및 적립이 불가합니다.</dt>
							<dd>
								에누리 가격비교 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱으로 결제만 한 경우<br>(에누리
								가격비교 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)
							</dd>
							<dd>에누리 가격비교 앱 미 로그인 후 구매한 경우 또는 에누리 가격비교 PC, 모바일 웹에서 구매한 경우</dd>
						</dl>

						<dl class="txtlist">
							<dt>적립대상쇼핑몰 중 e머니 적립 제외 카테고리/서비스</dt>
							<dd>에누리 가격비교 앱에서 검색되지 않는 상품</dd>
							<dd>인터파크: 모바일쿠폰/상품권, 라이프 서비스(티켓, 투어, 아이마켓 등)</dd>
							<dd>11번가: 여행/숙박/항공, 모바일쿠폰/상품권 전체</dd>
							<dd>G마켓: 중고장터, 실시간 여행, 항공권, 도서/음반, 모바일쿠폰/상품권(일부 상품권 적립가능)</dd>
							<dd>옥션: 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권(일부 상품권 적립가능)</dd>
							<dd>SSG: 도서/음반/문구/취미/여행, 모바일쿠폰/상품권/서비스 및 현금성 상품</dd>
							<dd>티몬: 슈퍼꿀딜, 슈퍼마트 등 특가 판매 상품, 모바일쿠폰/상품권(일부 상품권 적립가능)</dd>
							<dd>위메프: 모바일쿠폰/상품권 전체</dd>
							<dd>CJ몰/GSSHOP: 모바일쿠폰/상품권 전체</dd>
							<dd>모바일쿠폰/상품권: 상품권, 지역쿠폰, e교환권, e쿠폰 등 (문화상품권, 도서상품권, 백화점상품권,
								영화예매권, 국민관광상품권은 적립 가능)</dd>
							<dd>이 외 쇼핑몰에 입점한 제휴 서비스(배달, 티켓, 해외직구 등) 및 일부 카테고리 제외</dd>
						</dl>

						<a href="#" class="btn_check_hide">확인</a>
					</div>
				</div>
				<!-- //첫구매 유의사항 -->

				<script>
			// 유의사항 드롭다운
			$('.evt-caution-2').click(function(){
				var _this = $(this);
				_this.siblings(".moreview").toggle();
				
				$(".btn_check_hide").click(function(){
					$(this).parents(".moreview").slideUp();
					$('html,body').stop().animate({scrollTop:_this.offset().top});
					return false;
				});
				
				return false;
			});
			</script>
			</div>
			<!-- //유의사항 WRAPPER -->
		</div>
		<!-- //이벤트 03 -->
		<!-- 에누리 혜택 -->
		<%@include file="/eventPlanZone/jsp/eventBannerTapMobile_2019.jsp"%>
		<!-- //에누리 혜택 -->
		<!-- //Contents -->
	</div>

	<!-- (신규) 공통 : SNS공유하기 -->
	<div class="com__share_wrap dim" style="z-index: 10000; display: none">
		<div class="com__layer share_layer">
			<div class="lay_head">공유하기</div>
			<a href="#close" class="lay_close"
				onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
			<div class="lay_inner">
				<ul id="eventShr">
					<li class="share_fb">페이스북 공유하기</li>
					<li class="share_kakao" id="kakao-link-btn">카카오톡 공유하기</li>
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
							<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2020/summer_2020_evt.jsp</span>
							<button class="btn__share_copy" data-clipboard-target="#txtURL">복사</button>
						</div>
						<!-- 이메일주소 입력하기 -->
						<div class="btn_item">
							<input type="text" class="txt__share_mail"
								placeholder="이메일 주소 입력해 주세요">
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
	<div class="layer_back" id="app_only" style="display: none;">
		<div class="appLayer">
			<h4>모바일 앱 전용 이벤트</h4>
			<a href="javascript:///" class="close"
				onclick="$('#app_only').hide();">창닫기</a>
			<p class="txt">
				<strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.
			</p>
			<p class="btn_close">
				<button type="button" onclick="install_btt();">설치하기</button>
			</p>
		</div>
	</div>

	<!-- 당첨 레이어 -->
	<div class="voteResult_layer" id="prizes" style="display: none;">
		<div class="inner_layer">
			<div class="cont_area">
				<div class="img_box">
					<!-- 5,600점 적립 이미지 -->
					<div class="result_01" style="display: none">
						<img
							src="http://img.enuri.info/images/event/2020/summer_pro/m_reward_img01.jpg"
							alt="당첨을 축하합니다! 스타벅스 라임 패션 티 Tall사이즈, e머니 5,600점">
					</div>
					<!-- 5점 적립 이미지 -->
					<div class="result_02" style="display: none">
						<img
							src="http://img.enuri.info/images/event/2020/summer_pro/m_reward_img02.jpg"
							alt="5점 적립 내일 또 참여해주세요!">
					</div>
				</div>
				<a class="btn layclose" href="#"
					onclick="onoff('prizes'); return false;"><em>팝업 닫기</em></a>
			</div>
		</div>
	</div>

	<!-- 이벤트 응모완료 -->
	<div class="complete_layer" id="completeJoin" style="display: none">
		<div class="inner_layer">
			<div class="cont_area">
				<p class="tit">응모가 완료되었습니다.</p>
				<div class="img_box">
					<a href="/m/pickMain.jsp">
					<img src="http://img.enuri.info/images/event/2020/summer_pro/m_complete_640_500_img2.jpg"
						alt="나만의 추억템을 댓글로 남기고 스타벅스 라떼받자!(100명 추첨)">
					</a>
				</div>
			</div>
			<a class="btn layclose" href="#"
				onclick="onoff('completeJoin'); return false;"><em>팝업 닫기</em></a>
		</div>
	</div>

	<!-- 이벤트1 유의사항 -->
	<div class="layer_back" id="notetxt1" style="display: none;">
		<div class="noteLayer">
			<h4>유의사항</h4>
			<a href="javascript:///" class="close"
				onclick="onoff('notetxt1');return false;">창닫기</a>
			<div class="inner">
				<ul class="txtlist">
					<li>이벤트 참여 : ID당 1일 2회 참여 가능</li>
					<li>이벤트 참여 혜택 : e5,600점, e5점</li>
					<li>e머니 유효기간 : 적립일로부터 15일</li>
					<li>적립된 e머니는 e머니 스토어에서 다양한 e쿠폰상품으로 교환 가능합니다.</li>
					<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
					<li>부정 참여 시 적립 취소 및 사이트 사용이 제한될 수 있습니다.</li>
				</ul>
			</div>
			<p class="btn_close">
				<button type="button" onclick="onoff('notetxt1');return false;">닫기</button>
			</p>
		</div>
	</div>


	<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
	<script type="text/javascript"
		src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
	<script type="text/javascript"
		src="/mobilefirst/evt/js/event_season.js?v=20200629"></script>
	<script type="text/javascript">
var app = getCookie("appYN"); //app인지 여부
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로
var vEvent_title = "20년 무더위 프로모션";
var isFlow = "<%=flow%>" == "ad";
var vOs_type = getOsType();
var state = false;
var tab = "<%=tab%>";

$(".go_top").click(function(){		$('body, html').animate({scrollTop:0}, 500);	});

var shareUrl = "http://" + location.host + "/mobilefirst/event2020/summer_2020_evt.jsp";
var shareTitle = "<%=strFb_title%> <%=strFb_description%>";

Kakao.init('5cad223fb57213402d8f90de1aa27301');

/* 데이터 로드 영역 */
var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=37";


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
 
function da_ga(num){
	
	if(num == 2){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_상단탭_이벤트1");
	}else if(num == 3){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_상단탭_이벤트2");
	}else if(num == 4){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_상단탭_기획전연결");
	}else if(num == 5){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_상단플로팅배너");
	}else if(num == 6){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_이벤트1참여");
	}else if(num == 7){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_상품탭_여름가전");
	}else if(num == 8){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_상품탭_제철음식");
	}else if(num == 9){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_상품탭_홈캉스");
	}else if(num == 10){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_상품탭_모바일쿠폰");
	}else if(num == 11){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_상품탭_바캉스준비");
	}else if(num == 12){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_상품_상품클릭");
	}else if(num == 13){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_상품_상품더보기");	
	}else if(num == 14){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_기획전보러가기");
	}else if(num == 15){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_응모하기");
	}else if(num == 16){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 무더위 프로모션_에누리혜택");
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
		},
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
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

function go_ex(){
	window.open("/mobilefirst/event2020/summer_2020.jsp?tab=1");
}

(function (global, $) {
	$(function () {
		// 해당 섹션으로 스크롤 이동 
		$menu.on('click', 'a', function (e) {
			var $target = $(this).parent(),
				idx = $target.index(),
				offsetTop = Math.ceil($contents.eq(idx).offset().top);

			if ( idx < 2 ) $('html, body').stop().animate({ scrollTop: offsetTop - $navheight }, 500);
			
			if(idx == 0){
				da_ga(2);
			}else if(idx == 1){
				da_ga(3);
			}else if(idx == 2){
				da_ga(4);
			}
			
			return false;
		});

		
		$("#eventShr > li").click(function(){
			var sel = $(this).attr("class");
			
			if(sel == "share_fb"){
				try{
					window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(shareTitle)+"&u="+shareUrl);
				}catch(e){
					window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(shareTitle)+"&u="+shareUrl);
				}	
			}else if(sel == "share_tw"){
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

	// 상단 메뉴 스크롤 시, 고정
	var $nav = $('.floattab'),
		$menu = $('.floattab__list li'),
		$contents = $('.scroll'),
		$navheight = $nav.outerHeight(), // 상단 메뉴 높이
		$navtop = Math.ceil($nav.offset().top); // floattab 현재 위치; 

	// menu class 추가 
	$(window).scroll(function () {
		var $scltop = Math.ceil($(window).scrollTop());	// 현재 scroll

		if ($scltop > $navtop) {
			$nav.addClass("is-fixed");
			$(".visual").css("margin-bottom", $navheight);
		} else {
			$nav.removeClass("is-fixed");
			$menu.children("a").removeClass('is-on');
			$(".visual").css("margin-bottom", 0);
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

/*레이어*/
function onoff(id){
	var mid = $("#"+id);
	if(mid.css("display") !== "none"){
		mid.css("display","none");
	}else{
		mid.css("display","");
	}
}

function floating_bnr(){
	da_ga(5);
	location.href = "/mobilefirst/event2020/summer_2020.jsp?tab=#evt1";
	return false;	
}

$(document).ready(function() {
	// 개인정보 불러오기
	if(islogin()){
		$(".login_alert").addClass("disNone");
		$("#user_id").text("<%=cUserId%>");
	}
	
	ga('send', 'pageview', {'page': vEvent_page,'title': vEvent_title+'_PV'});
	
	if(tab != ""){
		setTimeout(function() {
	        $(".floattab__list li > a").eq(tab-1).trigger("click");
	    },300);
	}
	
	//응모하기 버튼
	$("#event2_join").click(function(e){
		da_ga(15);
		if(app != 'Y'){
			onoff('app_only');
		}else {
			getEventAjaxData({"procCode": 2 , ostpcd : vOs_type  }, function(data){
				var result = data.result;
				
				if(result == -99){
					alert("임직원은 참여 불가합니다.");
					return false;
				}
				
			    if(result == 2601){
			       alert("이미 응모하셨습니다.\n앱에서 구매 시\n구매내역 자동 누적됩니다.");
			    }else if( result == 1 ){
			    	 //alert("참여완료! 당첨자 발표일을 기다려주세요~");
			         var rdm = Math.floor(Math.random() * 4);
			         var goodsList = arrayShuffle(ajaxData[rdm]["GOODS"]);
			         var html = "";
			 		 if(goodsList.length >0){
			 			for(var i=0;i<goodsList.length;i++){
			 				if(i>=2){
			 					break;
			 				}
			 				var goodsData = goodsList[i];
			 				var modelno = goodsData["MODELNO"];
			 				var goods_img = goodsData["GOODS_IMG"];
			 				var goods_title1 = goodsData["TITLE1"];
			 				var goods_title2 = goodsData["TITLE2"];
			 				var goods_minprice = goodsData["MINPRICE"]==null?0:goodsData["MINPRICE"];
			 				
			 				html+= "<li>";
			 				html+= "	<a href=\"javascript:;\" onclick=\"window.open('/mobilefirst/detail.jsp?modelno="+modelno+"&freetoken=vip');\" title=\"새 탭에서 열립니다.\">";
			 				html+= "			<span class=\"thumb\">";
			 				html+= "				<img src=\""+goodsData["GOODS_IMG"]+"\" alt=\"\" />";
			 				html+= "			</span>";
			 				if(goodsData["MINPRICE"]==0){
			 				html+= "			<span class=\"soldout\">SOLD OUT</span>";	
			 				}
			 				html+= "			<span class=\"goods_info\">";
			 				html+= "				<span class=\"goods_tit\">"+goods_title1+"<br />"+goods_title2+"</span>";
			 				html+= "				<span class=\"goods_price\">";
			 				html+= "					<span class=\"tag_lowest\">지금최저가</span>";
			 				html+= "			        <strong>"+numberWithCommas(goods_minprice)+"</strong>원";
			 				html+= "				</span>";
			 				html+= "			</span>";
			 				html+= "	</a>";
			 				html+= "</li>";	
			 			}
			 			$("#completeJoin_list").html(html);
			 		 }
			 		 
			 		 onoff('completeJoin');
			 		 return false;
			    }
			});
		}
		return false;
	});
	
	$(".btn_goevt").click(function(){
		da_ga(14);
		window.open("/mobilefirst/event2020/summer_2020.jsp");
		return false;
	});
	
	//로그인시 개인화영역
	if(islogin()){
		$("#user_id").text("<%=cUserId%>");
		getPoint();//개인e머니 내역 노출
	}
	
	$(".sprite.btn_more").click(function(){
		var tabnum = nowTab+1;
		var goods_more = "/mobilefirst/event2020/summer_2020.jsp?tab="+tabnum;
		da_ga(13);
		window.open(goods_more); 
	});
	
});

var proSlide ;

setTimeout(function(){
	proSlide = $('.itemlist').slick({
		dots:true,
		slidesToScroll: 1
	});
},100);

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
	$(".pro_itemlist .tab_content").hide(); 
	$(".pro_itemlist ul.pro_tabs li").removeClass("active"); 
	//첫 로딩 시, 랜덤 노출
    var rndNum = Math.floor(Math.random() * 4);
    nowTab = rndNum+1
    var object = ajaxData[rndNum*3+0]["GOODS"].concat(ajaxData[rndNum*3+1]["GOODS"], ajaxData[rndNum*3+2]["GOODS"]);
	loadGoodsList(object);
	$(".pro_itemlist ul.pro_tabs li").eq(rndNum).addClass("active").show();
    $(".pro_itemlist .tab_content:first").show();
	
	$(".pro_tabs li").click(function() {
		$(".pro_tabs li").removeClass("active"); 
		$(this).addClass("active");
		//$(".pro_itemlist .tab_content").hide(); 
		var activeTab = $(this).find("a").attr("href"); 
		//$(activeTab).fadeIn();
		
		//가격대별 플리킹
		proSlide.slick("destroy");
		if(activeTab == "#protab1"){
			var object = ajaxData[0]["GOODS"].concat(ajaxData[1]["GOODS"], ajaxData[2]["GOODS"]);
			loadGoodsList(object);
			da_ga(7);
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			
			nowTab = 1;
		}else if(activeTab == "#protab2"){
			var object = ajaxData[3]["GOODS"].concat(ajaxData[4]["GOODS"], ajaxData[5]["GOODS"]);
			loadGoodsList(object);
			da_ga(8);
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			
			nowTab = 2;
		}else if(activeTab == "#protab3"){
			var object = ajaxData[6]["GOODS"].concat(ajaxData[7]["GOODS"], ajaxData[8]["GOODS"]);
			loadGoodsList(object);
			da_ga(9);
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			
			nowTab = 3;
		}else if(activeTab == "#protab4"){
			var object = ajaxData[9]["GOODS"].concat(ajaxData[10]["GOODS"], ajaxData[11]["GOODS"]);
			loadGoodsList(object);
			da_ga(10);
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			
			nowTab = 4;
		}else if(activeTab == "#protab5"){
			var object = ajaxData[12]["GOODS"].concat(ajaxData[13]["GOODS"], ajaxData[14]["GOODS"]);
			loadGoodsList(object);
			da_ga(11);
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			
			nowTab = 5;
		}
		return false;
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
					
					html+= "<li class=\"item\">";
					html+= "	<a href=\"javascript:;\" onclick=\"itemClick("+goodsData["MODELNO"]+","+goodsData["MINPRICE"]+");da_ga(12);\" title=\"새 탭에서 열립니다.\">";
					html+= "		<div class=\"thumb\">";
					html+= "			<img src=\""+goodsData["GOODS_IMG"]+"\" alt=\"\" />";
					if(goodsData["MINPRICE"]==0){
					html+= "			<span class=\"soldout\">SOLD OUT</span>";	
					}
					html+= "		</div>";
					html+= "		<div class=\"pro_info\">";
					html+= "			<span class=\"pro_name\">"+goods_title1+"<br />"+goods_title2+"</span>";
					html+= "			<span class=\"price\"><span class=\"price_label\">최저가</span><em>"+numberWithCommas(goods_minprice)+"</em><span class=\"pro_unit\">원</span></span>";
					html+= "		</div>";
					html+= "	</a>";
					html+= "</li>";	
					
				if(i%4==3) html += "</ul>";
			}
		}
		
		$(".itemlist").html(html);
		
	}
}

function itemClick(modelNo, minprice) {
	if(minprice > 0){
		window.open('/mobilefirst/detail.jsp?modelno=' + modelNo +'&freetoken=vip');
	}else{
		alert("품절된 상품 입니다.");
	}
}

var isClick = true;
var sdt = "<%=strToday%>";
function getEventAjaxData(params, callback){
	
	 if(sdt < "20200629"){
		alert('오픈예정입니다.');
		return false;
	}
	if(sdt > "20200802"){
		alert('이벤트가 종료되었습니다.');
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
			var evtUrl = "/mobilefirst/evt/ajax/summer2020_setlist.jsp";
			if(typeof params === "object") {
				params.sdt = sdt;
				params.osType = "M";
			}
		    if(!isClick){
		    	return false;
		    }
		    isClick = false;

			 $.post(evtUrl,params,callback,"json").done(function(){
					isClick = true;
			});
		}
	}
}

$(document).ready(function(){
	
	$(function(){
		var iceBreak = {
				el : {
					wrap : $(".icegame"),
					main : $(".icegame_inner"),
					btn : $(".icegame .ices > li"),
					hammer : $(".icegame .ices > li .hammer"),
					layer : $(".icegame .layer_area")
				},
				init : function(){
					this.addEvent();
				},
				addEvent : function(){
				// 얼음 클릭
					var _self = this;
					this.el.btn.click(function(){
						var $btnThis = $(this);
						getEventAjaxData( {"procCode":1} , function(data) {
							result = data.result;
							if(result >= 5){
								$btnThis.addClass("selected");
								setTimeout(function(){ // 모션을 위한 타이머
									// 당첨결과 보기 
									rewards(result);
								},2000) // 얼음깨는 모션 2s
							}else if(result == -1){
								alert("이미 참여하셨습니다.\n내일 또 참여해주세요.");
								working = false;
							}else if(result == -2 || result == -99){
								alert("임직원은 참여 불가합니다.");
								working = false;
							}else if(result == -55){
								alert("잘못된 접근입니다.");
							}else{
								working = false;
							}
						});
					})
				},
				clear : function(){ // 오브젝트 치우기
					this.el.main.fadeOut(100); 
				},
				reset : function(){ // 오브젝트 초기화 - 재배치
					this.el.btn.removeClass("selected");
					this.el.main.fadeIn(300);
					this.el.layer.fadeOut(100);
				}
			}
		// 실행
		iceBreak.init();

		// 당첨 결과 처리
		function rewards(result){
				// 0 - 낙첨 - 5점 적립
				// 1 - 당첨 - 5,600점 적립
				da_ga(6);
				setTimeout(function(){
					// 스크린 비우기
					iceBreak.clear();
					// 레이어 띄우기
					var $Layer = iceBreak.el.layer;
					// 결과 레이어 노출
					if ( result==5 ){ // 낙첨
						// $Layer.fadeIn(100).find(".layer_fail.type1").show(); // 땡! 시원한 아이스티 그림을 찾았네요!					
						$Layer.fadeIn(200).find(".layer_fail.type2").show(); // 땡! 아무것도 없네요~

						// 팝업 띄우기
						setTimeout(function(){										
							// 팝업 띄우기
							onoff('prizes');
							$("#prizes").find(".result_02").show(); // 5점
							// 게임 초기화
							iceBreak.reset();
						},1200);
					}else if(result==5600){ // 당첨
						$Layer.fadeIn(200).find(".layer_success").show()
						
						// 팝업 띄우기
						setTimeout(function(){										
							// 팝업 띄우기
							onoff('prizes');
							$("#prizes").find(".result_01").show(); // 6,200점
							// 게임 초기화
							iceBreak.reset();
						},1200);
					}
				},500);
			}      			
	});
	//기획전상품
	tabLoading();
});
$(window).load(function(){
	if(tab!='') {
		setTimeout(inner, 300);
	}
	function inner() {
		$('html, body').animate({scrollTop: Math.ceil($('#'+tab).offset().top)}, 500);
	}
});

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
setTimeout(function(){
welcomeGa("evt_summer_view"); 
},500);
function goPlan(){
	da_ga(4);
	location.href = "/mobilefirst/event2020/summer_2020.jsp";
}

CmdShare();
function CmdShare(){
	Kakao.Link.createDefaultButton({
	  container: '#kakao-link-btn',
      objectType: 'feed',
      content: {
        title: '<%=strFb_title%>',
        description: "<%=strFb_description%>",
        imageUrl: "<%=strFb_img%>",
			imageWidth : 380,
			imageHeight : 198,
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
	</script>
</body>
<script language="JavaScript"
	src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
