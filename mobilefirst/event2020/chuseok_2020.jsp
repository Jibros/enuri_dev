<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
String strFb_img = ConfigManager.IMG_ENURI_COM+ "/images/event/2020/chuseok/sns_1200_630_01.jpg";
String oc = ChkNull.chkStr(request.getParameter("oc"));

if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
	response.sendRedirect("/event2020/chuseok_2020.jsp");
	return;
}
SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMddHHmm");	//오늘 날짜
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


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<meta name="title" content="2020 추석 통합기획전 - 최저가 쇼핑은 에누리">
<meta name="description" content="온 가족 타임특가! 매주 수요일마다 터지는 득템의 기회!">
<meta name="keyword" content="에누리 가격비교, 통합기획전, 추석, 한가위">
<meta property="og:title" content="[에누리 가격비교] 한가위에누리다!">
<meta property="og:description" content="매주 수요일 타임특가도 만나보세요!">
<meta property="og:image" content="<%=strFb_img%>">
<meta name="format-detection" content="telephone=no" />
<title>2020 추석 기획전 - 최저가 쇼핑은 에누리</title>
<!-- 프로모션 공통 CSS (Mobile) -->
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<!-- 프로모션별 커스텀 CSS  -->
<link rel="stylesheet" href="/css/event/y2020/chuseok_m.css" type="text/css">
<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
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
	var ssl = "<%=ConfigManager.ENURI_COM_SSL%>";
</script>
</head>
<body>
<!-- 200825 : SR#41896 : [MO] SNS 공유 딥링크 연결 팝업  -->
<div class="lay_only_mw" style="display:none;">
	<div class="lay_inner">
		<div class="lay_head">
			앱에서는 득템의 기회 <em>타임특가</em>에 참여할 수 있어요!
		</div>
		<!-- 버튼 : 에누리앱으로 보기 -->
		<button class="btn_go_app">에누리앱으로 보기</button>
		<!-- 버튼 : 모바일웹으로 보기 -->
		<a href="javascript:void(0);" class="btn_keep_mw" onclick="$('.lay_only_mw').fadeOut(100);">괜찮아요. 모바일 앱으로 볼래요</a>
	</div>
</div>
<!-- // -->

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
        <a href="javascript:///" onclick="ga_log(6);"><img src="http://img.enuri.info/images/event/2020/chuseok/fl_bnr.png" alt="한가위 준비하고 LG시네빔 받자!"></a>
        <!-- 닫기 -->
        <a href="#" class="btn_close" onclick="onoff('floating_bnr');return false;">
            <span class="blind">닫기</span>
        </a>
    </div>
    <!-- // -->

	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">
		<!-- 공통 : 상단비주얼 -->
		<div class="visual">
			<!-- 공통 : 공유하기 버튼  -->
			<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
			<!-- // -->
			<div class="inner">
				<span class="txt_01">추석 준비</span>
				<h2>한가위에-누리다</h2>
				<span class="txt_02">2020. 9.1 ~ 2020. 10. 4</span>
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
					},100)
				})
			</script>
		</div>

		<!-- 공통 : 탭 -->
		<div class="section navtab">
			<div class="navtab_inner">
				<ul class="navtab_list">
					<li><a href="/mobilefirst/event2020/chuseok_2020_evt.jsp" class="navtab_item--01" onclick="ga_log(2);"><span class="tx_sm">매일매일</span>100% 당첨</a></li>
					<li><a href="/mobilefirst/event2020/chuseok_2020_deal.jsp" class="navtab_item--02" onclick="ga_log(3);"><span class="tx_sm">~93%</span>타임특가!</a></li>
					<li class="is-on"><a href="/mobilefirst/event2020/chuseok_2020.jsp" class="navtab_item--03" onclick="ga_log(4);"><span class="tx_sm">한가위 준비하고</span>빔프로젝트 받자!</a></li>
				</ul>
			</div>
		</div>
		<!-- //탭 -->

	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<!-- T3 이벤트 04 : 추천 상품 영역 -->
	<div id="event04" class="section event_04 pro_itemlist">
		<h2>
			<span class="tx_sm">추석 선물세트부터 1인 가구를 위한 연휴준비까지!</span>
			<span class="tx_main">추석을 더욱 풍성하게 할 쇼핑 가이드</span>
		</h2>

		<div class="inner">
			<!-- BEST 추석선물 -->
			<div id="prodGroup01" class="item_group item_group_01 scroll">
				<h3>
					<span class="txt_sub">마음을 전하기 딱 좋은</span>
					<strong class="txt_tit">BEST 추석선물</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab1-1">정육/축산</a></li>
					<li><a href="#protab1-2">건강식품</a></li>
					<li><a href="#protab1-3">신선식품</a></li>
					<li><a href="#protab1-4">상품권</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">
					<!--
						SLICK $(".itemlist")
						4개의 탭 콘텐츠가 있습니다. "tab_content"
						하나의 콘텐츠마다 ul 단위로 한 판(상품4개)씩 움직입니다.
					-->
					<!-- 정육/축산 상품 -->
					<div id="protab1-1" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=150315" target="_blank">상품더보기</a>
					</div>
					<!-- //정육/축산 상품 -->

					<!-- 건강식품 상품 -->
					<div id="protab1-2" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=1501" target="_blank">상품더보기</a>
					</div>
					<!-- //건강식품 상품 -->

					<!-- 신선식품 상품 -->
					<div id="protab1-3" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=15020323" target="_blank">상품더보기</a>
					</div>
					<!-- //신선식품 상품 -->

					<!-- 상품권 상품 -->
					<div id="protab1-4" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=164715" target="_blank">상품더보기</a>
					</div>
					<!-- //상품권 상품 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // BEST 추석선물 -->

			<!-- 가격대별 선물세트 -->
			<div id="prodGroup02" class="item_group item_group_02 scroll">
				<h3>
					<span class="txt_sub">예산에 맞게 전하는 진심</span>
					<strong class="txt_tit">가격대별 선물세트</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab2-1">1만원~3만원</a></li>
					<li><a href="#protab2-2">3만원~5만원</a></li>
					<li><a href="#protab2-3">5만원~10만원</a></li>
					<li><a href="#protab2-4">10만원 이상</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 1만원~3만원 상품 -->
					<div id="protab2-1" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=151110" target="_blank">상품더보기</a>
					</div>
					<!-- //1만원~3만원 상품 -->

					<!-- 3만원~5만원 상품 -->
					<div id="protab2-2" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=080106" target="_blank">상품더보기</a>
					</div>
					<!-- //3만원~5만원 상품 -->

					<!-- 5만원~10만원 상품 -->
					<div id="protab2-3" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=15080801" target="_blank">상품더보기</a>
					</div>
					<!-- //5만원~10만원 상품 -->

					<!-- 10만원 이상 상품 -->
					<div id="protab2-4" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=150315" target="_blank">상품더보기</a>
					</div>
					<!-- //10만원 이상 상품 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 가격대별 선물세트 -->

			<!-- 즐거운 귀성준비 -->
			<div id="prodGroup03" class="item_group item_group_03 scroll">
				<h3>
					<span class="txt_sub">더도 말고, 덜도 말고 한가위만 같아라~</span>
					<strong class="txt_tit">즐거운 귀성준비</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab3-1">귀성길</a></li>
					<li><a href="#protab3-2">돈봉투</a></li>
					<li><a href="#protab3-3">보드게임</a></li>
					<li><a href="#protab3-4">유아한복</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 귀성길 상품 -->
					<div id="protab3-1" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=211417" target="_blank">상품더보기</a>
					</div>
					<!-- //귀성길 상품 -->

					<!-- 돈봉투 상품 -->
					<div id="protab3-2" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=18020309" target="_blank">상품더보기</a>
					</div>
					<!-- //돈봉투 상품 -->

					<!-- 보드게임 상품 -->
					<div id="protab3-3" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=164404" target="_blank">상품더보기</a>
					</div>
					<!-- //보드게임 상품 -->

					<!-- 유아한복 -->
					<div id="protab3-4" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=101508" target="_blank">상품더보기</a>
					</div>
					<!-- //유아한복 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 즐거운 귀성준비 -->

			<!-- 알찬 추석 연휴준비 -->
			<div id="prodGroup04" class="item_group item_group_04 scroll">
				<h3>
					<span class="txt_sub">1인 가구를 위한</span>
					<strong class="txt_tit">알찬 추석 연휴준비</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab4-1">컴퓨터/게임기</a></li>
					<li><a href="#protab4-2">간편가정식</a></li>
					<li><a href="#protab4-3">e쿠폰</a></li>
					<li><a href="#protab4-4">댕냥이 한복</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 컴퓨터/게임기 상품 -->
					<div id="protab4-1" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=0408" target="_blank">상품더보기</a>
					</div>
					<!-- //컴퓨터/게임기 상품 -->

					<!-- 간편가정식 상품 -->
					<div id="protab4-2" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=151112&parent=11511" target="_blank">상품더보기</a>
					</div>
					<!-- //간편가정식 상품 -->

					<!-- e쿠폰 상품 -->
					<div id="protab4-3" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=164721" target="_blank">상품더보기</a>
					</div>
					<!-- //e쿠폰 상품 -->

					<!-- 댕냥이 한복 -->
					<div id="protab4-4" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" href="/mobilefirst/list.jsp?cate=16420803" target="_blank">상품더보기</a>
					</div>
					<!-- //댕냥이 한복 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 알찬 추석 연휴준비 -->

		</div>
	</div>
	<!-- // -->

	<!-- T3 이벤트05 : APP에서 한가위 준비하면 LG빔 프로젝트 당첨! -->
	<div class="section event_05 scroll">
		<div class="inner">
			<h2>
				<span class="tx_main">
					APP에서 한가위 준비하면
					<em>LG 빔프로젝트 당첨!</em>
				</span>
				<span class="tx_sm">많이 구매할 수록 당첨 확률 UP! UP!</span>
			</h2>
			<div class="gift">
				<ol class="blind">
					<li>1등 LG전자 시네빔 PH500 (실물배송/색상랜덤) - 2명 추첨</li>
					<li>2등 서가앤쿡, 필라프 교환권 e19,800점 - 10명 추첨</li>
					<li>3등 크리스피 어소티드 하프더즌 e5,900점 - 38명 추첨</li>
				</ol>
			</div>
			<!-- 버튼 : 응모하기 -->
			<button class="btn_apply" id="event2_join" >응모하기 &gt;</button>
		</div>

		<!-- 공통 : 꼭 확인하세요  -->
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice btn__white" data-laypop-id="slidePop4"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop4" class="evt_notice--slide">
			<div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<dl>
							<dt>이벤트/구매 기간</dt>
							<dd>
								<ul>
									<li>2020년 9월 1일 ~ 2020년 10월 4일</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>당첨자 발표 및 적립</dt>
							<dd>
								<ul>
									<li>2020년 12월 23일 [APP 이벤트/기획전 탭 > 이벤트 하단 당첨자 발표]</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>경품</dt>
							<dd>
								<ul>
									<li>1등 – LG전자 시네빔 PH550 - 2명 추첨  <span class="stress">※제세공과금 당첨자 부담</span></li>
									<li>2등 – 서가앤쿡 파스타, 필라프 교환권 (e 19,800점) - 10명 추첨</li>
									<li>3등 – 크리스피크림도넛 어소티드 하프더즌 (e 8,800점) – 38명 추첨</li>
								</ul>
								<br/>
								<ul>
									<li>e머니 유효기간 : 적립일로부터 15일</li>
									<li>사정에 따라 경품이 변경될 수 있습니다.</li>
									<li>잘못된 정보 입력으로 인한 경품 수령의 불이익은 책임지지 않습니다.</li>
									<li>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</li>
									<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
									<li>본 이벤트 당첨은 더블적립 및 무제한적립 참여 시 혜택 지급이 불가합니다.</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>구매 적립 기준 및 유의사항</dt>
							<dd>
								<ul>
									<li>적립방법 : 에누리 가격비교 모바일 앱 로그인 &rarr; 적립대상 쇼핑몰 이동 &rarr; <span class="stress">1천원 이상 구매</span> &rarr; 구매확정(배송완료) 시 e머니 적립</li>
									<li>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 에누리 해외직구관, SK스토아, 홈플러스<br/>
										<span class="stress">※ 티몬 및 에누리 해외직구관의 경우 PC 및 모바일 앱/웹에서 로그인 후 구매시에도 구매적립 가능합니다.</span>
									</li>
									<li>구매적립 e머니는 구매일로부터 10 ~ 30일간 취소/환불/교환/반품여부 확인 후 적립 됩니다.</li>
									<li><span class="stress">구매적립 e머니 유효기간 : 적립일로부터 60일 (유효기간 만료 후 재적립 불가)</span><br/>
										※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</li>
									<li>구매적립 e머니는 최소 10점(구매금액 1천원 이상)부터 적립되며, 1원 단위 e머니는 적립되지 않습니다.</li>
									<li>구매적립 e머니는 구매확정(구매일로부터 최	대 30일) 시점부터 MY 에누리 적립내역 페이지에서 확인 가능합니다.</li>
									<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다.</li>
									<li>적립대상 쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제하는 경우 구매건수는 1건이며 구매금액은 통합된 금액으로 e머니 적립 됩니다.</li>
									<li>e머니 적립을 위해 반드시 최신 버전으로 업데이트를 해주세요.</li>
									<li>구매적립 e머니는 카테고리별 차등 적립됩니다.</li>
								</ul>
							</dd>

							<dt>※ 카테고리별 적립률 상세</dt>
							<dd>
								<table class="evt_noti_tb" style="width:320px;">
									<colgroup>
										<col/>
										<col width="100px">
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
											<td>모바일쿠폰,상품권<br />
												<p class="stress">*특정 상품에 한하여 적립되오니<br/>적립가능 상품은 하단에서 확인해주세요.</p>
											</td>
										</tr>
									</tbody>
								</table>
							</dd>
						</dl>
						<dl>
							<dt class="stress">[모바일쿠폰,상품권 ] 구매적립 기준</dt>
							<dd>
								<ul>
									<li>적립가능 쇼핑몰 : 티몬, G마켓, 옥션</li>
									<li>적립가능 상품 (0.2% 적립) : 문화상품권(해피머니, 컬쳐랜드), 도서상품권, 백화점상품권, 영화예매권, 국민관광 상품권</li>
									<li>백화점상품권 기준 상세
										<ul class="sub">
											<li>1) 상품명에 '백화점 상품권' 명시된 상품 또는 백화점에서만 사용할 수 있는 상품권만 적립가능</li>
											<li>2) 복합상품권 적립불가 (삼성 상품권, 신세계 기프트카드, 롯데카드 상품권, 이랜드 상품권, AK플라자 상품권, 통합 상품권 등)<br />
												- 복합 상품권의 경우 사용처에 백화점이 기재되어 있는 경우에도 적립불가
											</li>
											<li>3) 백화점 상품권으로 전환 가능한 포인트 구매 시 적립불가</li>
										</ul>
									</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>적립대상 쇼핑몰 중 구매적립 제외 카테고리 및 서비스</dt>
							<dd>
								<ul>
									<li>에누리 가격비교에서 검색되지 않는 상품</li>
									<li>모바일쿠폰,상품권 : 상품권, 지역쿠폰, e교환권, e쿠폰 등</li>
									<li>쇼핑몰 제휴 서비스(배달, 티켓, 해외직구 등) 및 일부 카테고리</li>
									<li>
										<ul class="sub">
											<li>- G마켓 : 중고장터, 실시간 여행, 항공권, 도서/음반, 모바일쿠폰/상품권(일부 적립가능)</li>
											<li>- 옥션 : 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권(일부 적립가능)</li>
											<li>- 11번가 : 여행/숙박/항공, 모바일쿠폰/상품권</li>
											<li>- 인터파크 : 라이프 서비스(티켓, 투어, 아이마켓 등), 모바일쿠폰/상품권(100원딜 상품만 적립가능)</li>
											<li>- 티몬 : 특가 판매 상품(슈퍼꿀딜, 슈퍼마트 등), 모바일쿠폰/상품권(일부 적립가능)</li>
											<li>- 위메프 : 모바일쿠폰/상품권</li>
											<li>- GS SHOP, CJmall : 모바일쿠폰/상품권</li>
											<li>- SSG : 도서/음반/문구/취미/여행, 모바일쿠폰/상품권</li>
										</ul>
									</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>공통 이벤트 유의사항</dt>
							<dd>
								<ul>
									<li>아래의 경우에는 구매 확인 및 구매적립이 불가합니다.
										<ul class="sub">
											<li>- 에누리 가격비교 모바일 앱이 아닌 다른 모바일 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 모바일 앱으로 결제만 한 경우</li>
											<li>- 에누리 가격비교 미 로그인 후 구매한 경우</li>
											<li>- 에누리 가격비교 PC 및 모바일 웹에서 구매한 경우 (※ 티몬 및 에누리 해외직구관은 PC 및 모바일 앱/웹 구매 시에도 가능)</li>
											<li>- 구매 후 환불/취소/교환한 경우 적립되지 않습니다.</li>
										</ul>
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
		</div>
		<!-- // -->
	</div>
	<!-- // -->

	<!-- 공통 : 하단 에누리 혜택 -->
	<div class="otherbene">
        <div class="inner">
            <h3 class="blind">놓칠 수  없는 특별한 혜택, 에누리 혜택</h3>
            <ul class="ben_list">
                <li class="ben_item--01"><a href="http://m.enuri.com/mobilefirst/evt/firstbuy100_event.jsp" target="_blank">첫구매 고객이라면! Welcome 혜택</a></li>
                <li class="ben_item--02"><a href="http://m.enuri.com/mobilefirst/evt/visit_event.jsp" target="_blank">하루라도 농치면 손해 매일100% 당첨</a></li>
                <li class="ben_item--03"><a href="http://m.enuri.com/mobilefirst/evt/smart_benefits.jsp?freetoken=event#tab3" target="_blank">지금 가전을 구매하면? 최대 적립 10배</a></li>
                <li class="ben_item--04"><a href="http://m.enuri.com/mobilefirst/renew/plan.jsp?freetoken=main_tab|event" target="_blank">아직 끝나지 않은 혜택 더 많은 이벤트</a></li>
            </ul>
        </div>
	</div>
	<!-- // -->
	<script>
		$('.ben_list > li').click(function(){
			ga_log(36);
		});
	</script>

	<!-- //Contents -->

</div>

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
						<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2020/chuseok_2020.jsp?oc=sns</span>
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
		/* $(function(){
			var clipboard = new ClipboardJS('.com__share_wrap .btn__share_copy');
			clipboard.on('success', function(e) {
				alert('주소가 복사되었습니다');
			});
			clipboard.on('error', function(e) {
				console.log(e);
			});
		}); */
	</script>
</div>
<!-- // -->

<!-- 모바일웹 공통 : 모바일 앱 전용 이벤트  -->
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btn();">설치하기</button></p>
	</div>
</div>

<!-- 이벤트1 : 당첨 레이어 -->
<div class="voteResult_layer" id="prizes" style="display:none">
	<div class="inner_layer">
		<div class="cont_area">
			<div class="img_box">
				<!-- 4,500점 적립 이미지 -->
				<div class="result_01" style="display:none">
					<img src="http://img.enuri.info/images/event/2020/chuseok/m_reward_img01.jpg" alt="당첨을 축하합니다! 설빙 인절미 토스트 e4,500">
				</div>
				<!-- 5점 적립 1 -->
				<div class="result_02" style="display:none">
					<img src="http://img.enuri.info/images/event/2020/chuseok/m_reward_img02.jpg" alt="5점 적립 내일 또 참여해주세요!">
				</div>
				<!-- 5점 적립 2 -->
				<div class="result_03" style="display:none">
					<img src="http://img.enuri.info/images/event/2020/chuseok/m_reward_img03.jpg" alt="5점 적립 내일 또 참여해주세요!">
				</div>
			</div>
			<a class="btn layclose" href="#" onclick="onoff('prizes'); return false;"><em>팝업 닫기</em></a>
		</div>
	</div>
</div>

<!-- 이벤트5 : 이벤트 응모완료 -->
<div class="complete_layer" id="completeJoin" style="display:none">
	<div class="inner_layer">
		<div class="cont_area">
			<p class="tit">응모가 완료되었습니다.</p>
			<div class="img_box" id="completeJoin_list">
				<a href="/mobilefirst/evt/smart_benefits.jsp?freetoken=event"><img src="http://img.enuri.info/images/event/2020/chuseok/m_complete_img_2.jpg" alt="이번 주 CRAZY DEAL, GS25 모바일 상품권 5천원권을 100원 (98%할인)" /></a>
			</div>
		</div>
		<a class="btn layclose" href="javascript:///" onclick="onoff('completeJoin'); return false;"><em>팝업 닫기</em></a>
	</div>
</div>

<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
<script type="text/javascript" src="/js/clipboard.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20200629"></script>
<script type="text/javascript" src="/mobilefirst/event/js/exhibition_m.js"></script>
<script type="text/javascript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
<script type="text/javascript">
	$(function(){
		var clipboard = new ClipboardJS('.com__share_wrap .btn__share_copy');
		clipboard.on('success', function(e) {
			alert('주소가 복사되었습니다');
		});
		clipboard.on('error', function(e) {
			console.log(e);
		});
	});

	var cnt = 0;
	var $navHgt = 0;
	var app = getCookie("appYN"); //app인지 여부
	var makeHtml = "";
	var vOs_type = getOsType();
	var vEvent_title = "20 추석통합기획전";
	var gaLabel = [  "20년 추석 통합기획전_PV"
					,"20년 추석 통합기획전_상단탭_이벤트1"
					,"20년 추석 통합기획전_상단탭_타임특가"
					,"20년 추석 통합기획전_상단탭_이벤트2"
					,"20년 추석 통합기획전_이벤트1 참여"
					,"20년 추석 통합기획전_상단플로팅배너"
					,"20년 추석 통합기획전_타임딜_상품보기"
					,"20년 추석 통합기획전_타임딜_APP구매하기"
					,"20년 추석 통합기획전_타임딜_썸네일"
					,"20년 추석 통합기획전_타임딜_공유이벤트 참여"
					,"20년 추석 통합기획전_BEST 추석선물_탭_정육/축산"
					,"20년 추석 통합기획전_BEST 추석선물_탭_건강식품"
					,"20년 추석 통합기획전_BEST 추석선물_탭_신선식품"
					,"20년 추석 통합기획전_BEST 추석선물_탭_상품권"
					,"20년 추석 통합기획전_BEST 추석선물_상품클릭"
					,"20년 추석 통합기획전_BEST 추석선물_상품더보기"
					,"20년 추석 통합기획전_가격대별 추석선물_탭_1~3만원"
					,"20년 추석 통합기획전_가격대별 추석선물_탭_3~5만원"
					,"20년 추석 통합기획전_가격대별 추석선물_탭_5~10만원"
					,"20년 추석 통합기획전_가격대별 추석선물_탭_10만원 이상"
					,"20년 추석 통합기획전_가격대별 추석선물_상품클릭"
					,"20년 추석 통합기획전_가격대별 추석선물_상품더보기"
					,"20년 추석 통합기획전_즐거운 귀성준비_탭_귀성길"
					,"20년 추석 통합기획전_즐거운 귀성준비_탭_돈봉투"
					,"20년 추석 통합기획전_즐거운 귀성준비_탭_보드게임"
					,"20년 추석 통합기획전_즐거운 귀성준비_탭_유아한복"
					,"20년 추석 통합기획전_즐거운 귀성준비_상품클릭"
					,"20년 추석 통합기획전_즐거운 귀성준비_상품더보기"
					,"20년 추석 통합기획전_1인가구 추석준비_탭_컴퓨터/게임기"
					,"20년 추석 통합기획전_1인가구 추석준비_탭_간편가정식"
					,"20년 추석 통합기획전_1인가구 추석준비_탭_e쿠폰"
					,"20년 추석 통합기획전_1인가구 추석준비_탭_댕냥이 한복"
					,"20년 추석 통합기획전_1인가구 추석준비_상품클릭"
					,"20년 추석 통합기획전_1인가구 추석준비_상품더보기"
					,"20년 추석 통합기획전_이벤트2 참여"
					,"20년 추석 통합기획전_혜택배너" ];

	//탭별 ga로그
	function tabLog(evt,no){
		var index = 0;
		$(evt + ' .pro_tabs li a').click(function(){
			index = $(this).parents().index() + no;
			ga_log(index);
		});
	}

	//더보기 ga로그
	function moreViewLog(evt,no){
		$(evt + ' .tab_container .btn_more').click(function(){
			ga_log(no);
		});
	}

    // 공통 : 상단 탭 고정
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
	});

	var isClick = true;
	var sdt = "<%=strToday.substring(0,8) %>";
	function getEventAjaxData(params, callback){
		if(sdt < "20200901"){
			alert('오픈예정입니다.');
			return false;
		}
		if(sdt > "20201004"){
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
				var evtUrl = "/mobilefirst/evt/ajax/chuseok2020_setlist.jsp";
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

	function view_moapp(){
		var chrome25;
		var kitkatWebview;
		var uagentLow = navigator.userAgent.toLocaleLowerCase();
		var openAt = new Date;
		var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2020%2Fchuseok_2020.jsp";
		if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
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
					location.href = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2020/chuseok_2020.jsp";
				} else{
					location.href = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2020/chuseok_2020.jsp";
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

	$(document).ready(function() {
		//ga > pageview
		 ga_log(1);

		 var oc = '<%=oc%>';
		 var tablo = '<%=tab%>';

		 $(".ben_item--04").click(function(){
			var url = (app != "Y" ? "/mobilefirst/index.jsp#evt" : "/mobilefirst/renew/plan.jsp?freetoken=main_tab|event")
			window.open(url);
		});

		//상품 영역
		var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=38";

		$.ajax({
			  dataType : "json"
			, url	   : loadUrl
			, cache : false
			, success  : function(result){
				var banner = result.R;
				var tab = result.T;
				var tabSize = 4; //컨텐츠 별 탭 개수
				var listSize = 4; //노출 상품 개수
				var logNo = [15,21,27,33];
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

				var vThisUrl =location.href;

				/* if(vThisUrl.indexOf("#event05") > -1 ){
					$('html, body').stop().animate({scrollTop: Math.ceil($('.event_05').offset().top- $(".navtab").outerHeight())}, 0);
				}
 */
				/* if(vThisUrl.indexOf("#prodGroup01") > -1 ){
					$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_01').offset().top- $(".navtab").outerHeight())}, 0);
				}else if(vThisUrl.indexOf("#prodGroup02") > -1 ){
					$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_02').offset().top- $(".navtab").outerHeight())}, 0);
				}else if(vThisUrl.indexOf("#prodGroup03") > -1 ){
					$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_03').offset().top- $(".navtab").outerHeight())}, 0);
				}else if(vThisUrl.indexOf("#prodGroup04") > -1 ){
					$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_04').offset().top- $(".navtab").outerHeight())}, 0);
				} */
				if(tablo == '01'){
					$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_01').offset().top- $(".navtab").outerHeight())}, 0);
				}else if(tablo == '02'){
					$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_02').offset().top- $(".navtab").outerHeight())}, 0);
				}else if(tablo == '03'){
					$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_03').offset().top- $(".navtab").outerHeight())}, 0);
				}else if(tablo == '04'){
					$('html, body').stop().animate({scrollTop: Math.ceil($('.item_group_04').offset().top- $(".navtab").outerHeight())}, 0);
				}else if(tablo == '05'){
					$('html, body').stop().animate({scrollTop: Math.ceil($('.event_05').offset().top- $(".navtab").outerHeight())}, 0);
				}

			}
		});

		// 공유하기 링크로 진입 시, 팝업 노출(모웹)
		if(oc == "sns" && app != 'Y'){
			var url = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2020%2Fchuseok_2020.jsp";
			$('.lay_only_mw').show();
			// 앱으로 보기
	    	$(".btn_go_app").click(function(){
	    		view_moapp();

	    	});
		}

		//ga > 탭
		tabLog('#prodGroup01', 11);
		tabLog('#prodGroup02', 17);
		tabLog('#prodGroup03', 23);
		tabLog('#prodGroup04', 29);

		//ga > 더보기
		moreViewLog('#prodGroup01',16);
		moreViewLog('#prodGroup02',22);
		moreViewLog('#prodGroup03',28);
		moreViewLog('#prodGroup04',34);

		//응모하기 버튼
		$("#event2_join").click(function(e){
			ga_log(35);//ga 부분
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
				         $("#completeJoin").show();
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

				 		 //onoff('completeJoin');
				 		 return false;
				    }
				});
			}
			return false;
		});

		// 공유하기
		$(".share_kakao").on('click', function(){
			shareSns('kakao');
		});
		$(".share_fb").on('click', function(){
			shareSns('face');
		});
		$(".share_tw").on('click', function(){
			shareSns('twitter');
		});


		$(".floating_bnr").on('click', function(){
			$('html, body').stop().animate({scrollTop: Math.ceil($('.event_05').offset().top- $(".navtab").outerHeight())}, 0);
		});

		// 공유하기 클릭시
		/* $(".com__btn_share").click(function(){
			var url = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2event2020%2Fchuseok_2020_deal.jsp";
			if(app != 'Y'){
				$('.lay_only_mw').show();
				// 앱으로 보기
		    	$(".btn_go_app").click(function(){
		    		if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
						location.href = url;
					}else{ // 아이폰
						setTimeout(function(){
							window.open("https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8");
						}, 1000);
						location.href = url;
					}
		    	});

			}else{
				$('.com__share_wrap').show();
			}
		}); */
	});

	<%-- $(window).load(function(){
		var tab = '<%=tab%>';
		console.log("tab --> "+tab);
		if(tab != ""){
			location.href = '#event05';
		}
	}); --%>

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

	// sns 공유하기 함수
	function shareSns(param){
		var share_url = "http://m.enuri.com/mobilefirst/event2020/chuseok_2020.jsp?oc=sns";
		var share_title = "[에누리 가격비교] 한가위에누리다!";
		var share_description = "매주 수요일 타임특가도 만나보세요!";
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
			share_title += " 매주 수요일 타임특가도 만나보세요!";
			window.open("https://twitter.com/intent/tweet?text="+share_title+"&url="+share_url);
		}
	}

	function webInstall(){
		var url = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2event2020%2Fchuseok_2020_deal.jsp";
	    if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
	    	setTimeout(function(){
	    		url = "https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8";
			}, 1000);
	    }else if(navigator.userAgent.indexOf("Android") > -1){
	    	setTimeout(function(){
	    		url = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3Denuri_deal%26utm_campaign%3Denuri";
			}, 1000);
	    }
	    window.location.href = url;
	}

</script>
</body>
</html>
