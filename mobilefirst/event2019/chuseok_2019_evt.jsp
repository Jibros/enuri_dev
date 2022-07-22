<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{ //pc일때 접속페이지 변경.
	response.sendRedirect("/event2019/chuseok_2019_evt.jsp");
	return;
}

String chkId     = ChkNull.chkStr(request.getParameter("chk_id"),"");
String cUserId   = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK"),"");

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
String strFb_title = "[에누리 가격비교]";
String strFb_description = "추석 프로모션";
String strFb_img = ConfigManager.IMG_ENURI_COM + "/images/mobilenew/images/logo_enuri.png";
String tab = ChkNull.chkStr(request.getParameter("tab"),"");
String flow = ChkNull.chkStr(request.getParameter("flow"));

SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");	//오늘 날짜
String strToday = formatter.format(new Date());
String sdt = ChkNull.chkStr(request.getParameter("sdt"));

if(!"".equals(sdt) && request.getServerName().equals("dev.enuri.com")){
	strToday = sdt;
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<META NAME="description" CONTENT="매일 게임참여하고, 햄버거세트 받아가세요!">
	<META NAME="keyword" CONTENT="에누리가격비교, 프로모션, 추석, 한가위, 추석선물, 매일참여, 추석이벤트">
	<meta property="og:title" content="한가위 프로모션 – 최저가 쇼핑은 에누리">
	<meta property="og:description" content="매일 게임참여하고, 햄버거세트 받아가세요!">
	<meta property="og:image" content="<%=strFb_img%>">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/css/event/y2019/chuseok_pro_m.css"/>
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/lib/animate.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
	<script type="text/javascript" src="/common/js/function.js"></script>
	<script type="text/javascript" src="/common/js/paging_visit_201708.js"></script>
</head>
<body>
<div id="eventWrap">
	<!-- 개인화영역 -->
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile_xmas_2018.jsp"%>
	
	<!-- 플로팅 배너 - 둥둥이 -->
    <div id="floating_bnr" class="floating_bnr">
        <a href="/mobilefirst/event2019/chuseok_2019.jsp?tab=1" onclick="da_ga(5);" target="_blank"><img src="http://img.enuri.com/images/event/2019/chuseok_pro/fl_bnr.png" alt="최대80% 타임세일"></a>
        <!-- 닫기 -->
        <a href="#" class="btn_close" onclick="onoff('floating_bnr');return false;">
            <span class="blind">닫기</span>
        </a>
    </div>
    <!-- // -->

	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">		
		<!-- 상단비주얼 -->
		<div class="visual">
			<div class="sns">
				<span class="sns_share evt_ico" onclick="onoff('snslayer')">sns 공유하기</span>
				<ul id="snslayer" style="display:none;">
					<li>페이스북</li>
					<li>카카오톡</li>
				</ul>
			</div>
			<div class="inner">
				<h2>
					<span class="top_tit_04">풍</span><span class="top_tit_05">성</span><span class="top_tit_06">한</span><span class="top_tit_01">한</span><span class="top_tit_02">가</span><span class="top_tit_03">위</span><span class="top_tit_stamp"></span>
				</h2>
				<span class="obj_leaf"><!-- 단풍잎 --></span>
				<span class="obj_moon"><!-- 보름달 --></span>
				<span class="txt_sub">게임하면 매일매일 햄버거 쇼핑하면 LG모니터 득템</span>
				<span class="obj_rabbit_w"><!-- 토끼w --></span>
				<span class="obj_rabbit_m"><!-- 토끼m --></span>			
			</div>
			<script>
				// 상단 등장 모션
				$(window).load(function(){
					setTimeout(function(){					
						$(".visual").addClass("intro");
						setTimeout(function(){
							$(".visual").addClass("end");
						},4000)
					},500)
				})
			</script>
		</div>
	
		<div class="section floattab">
			<div class="contents">
				<ul class="floattab__list">
					<li><a href="#evt1" onclick="da_ga(2)" class="floattab__item floattab__item--01">게임하면 햄버거 공짜</a></li>
					<li><a href="#evt2" onclick="da_ga(3)" class="floattab__item floattab__item--02">쇼핑하고 LG모니터 득템</a></li>
					<li><a href="/mobilefirst/event2019/chuseok_2019.jsp?tab=1" onclick="da_ga(4)" class="floattab__item floattab__item--03">최대 80% 타임세일</a></li>
				</ul>
			</div>
		</div>
		
	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<!-- 이벤트01 -->
	<div id="evt1" class="section evt_1st scroll">
		<div class="contents">
			<h2><img src="http://img.enuri.com/images/event/2019/chuseok_pro/m_event_01_tit.png" alt="게임만 해도 매일매일 햄버거 세트 쏜다"></h2>
			<span class="evt_gift"><img src="http://img.enuri.com/images/event/2019/chuseok_pro/m_event_01_gift.jpg" alt="롯데리아 T-REX 버거 (e5,800)"></span>
			<!-- 게임화면 -->
			<div class="game_wrap">
				<div class="game_main">
					<span class="blind">토끼가 숨어있는 달을 찾아주세요!</span>
					<ul>
						<!-- 달1 -->
						<li class="btn_moon btn_moon_01"></li>
						<!-- 달2 -->
						<li class="btn_moon btn_moon_02"></li>
						<!-- 달3 -->
						<li class="btn_moon btn_moon_03"></li>
					</ul>
				</div>

				<!-- 결과 레이어 영역 -->
				<div class="layer_area">
					<!-- case 1 : 축하합니다! 토끼를 찾으셨네요! -->
					<div class="layer_success">
						<img src="http://img.enuri.com/images/event/2019/chuseok_pro/m_game_result_01.jpg" alt="축하합니다! 토끼를 찾으셨네요!">
					</div>
					<!-- case 2 : 아쉽지만 토끼를 찾지 못하셨어요. -->
					<div class="layer_fail">
						<img src="http://img.enuri.com/images/event/2019/chuseok_pro/m_game_result_02.jpg" alt="아쉽지만 토끼를 찾지 못하셨어요">
					</div>
				</div>
                <!-- // -->
			</div>

			<a href="#" class="sprite btn_caution evt-caution-1" onclick="onoff('notetxt1'); return false;">꼭!확인하세요</a>
		</div>
	
	</div>
	<!-- //이벤트01 -->
	
	<!-- 추천 상품 영역 -->
	<div class="section pro_itemlist">
		<div class="contents">
			<h2 class="blind">풍요로운 추석 추천선물</h2>
			
			<!-- 추천상품 탭 -->
			<ul class="pro_tabs">
				<li class="active"><a href="#protab1">#한우선물세트</a></li>
				<li><a href="#protab2">#신선선물세트</a></li>
				<li><a href="#protab3">#가공선물세트</a></li>
				<li><a href="#protab4">#생활선물세트</a></li>
				<li><a href="#protab5">#건강선물세트</a></li>
				<li><a href="#protab6">#상품권</a></li>
			</ul>
			<!-- //추천상품 탭 -->
			
			<!-- 추천상품 콘텐츠 -->
			<div class="tab_container">
				
				<!-- 
					SLICK $(".itemlist")
					6개의 탭 콘텐츠가 있습니다. "tab_content"
					하나의 콘텐츠마다 ul 단위로 한 판(상품4개)씩 움직입니다. 				
				-->
				<!-- 한우선물세트 -->
				<div id="protab1" class="tab_content">
					<div class="itemlist"></div>
					<a class="sprite btn_more" href="javascript:///" >상품더보기</a>
				</div>
				<!-- //한우선물세트 -->
				

			</div>
			<!-- //추천상품 콘텐츠 -->
		</div>
	</div>
	<!-- //추천 상품 영역 -->
	
	<!-- 이벤트02 -->
	<div id="evt2" class="section evt_2rd scroll">
		<h3 class="tit">선추석선물 구매하고 행운당점!</h3>
		<p class="blind">APP에서 많이 구매할수록 당첨확률 UP!</p>
		<div class="contents">			
			<div class="evt2_area">
				<div class="evt2_area__inner">
					<ol class="blind">
						<li>1등 LG울트라 와이드 모니터 34WK500(실물배송) 1명 추첨</li>
						<li>2등 북앤라이프 도서문화상품권 1만원권(e 10,000점) 20명 추첨</li>
						<li>3등 투썸플레이스 오렌지에이드 (e 5,500점) 40명 추첨</li>
					</ol>			
				</div>
				<div class="btn_wrap">
					<a href="javascript:///" class="btn_goevt" target="_blank" title="새창 열림">기획전 보러 가기</a>
					<a href="javascript:///" class="btn_apply" id="event2_join">응모하기</a>
				</div>
				<ul class="evt_info">					
					<li>이벤트 참여 및 구매 기간 : 2019년 8월 19일 ~ 9월 15일</li>
					<li>참여 방법 : APP &gt; 적립대상 쇼핑몰에서 구매하고 응모하기</li>
					<li>당첨자 발표 : 2019년 10월 29일 화요일 [에누리 앱 &gt; 이벤트/기획전 &gt; 이벤트 하단 당첨자 발표]</li>
					<li>사정에 따라 경품이 변경될 수 있습니다.</li>
				</ul>
			</div>
		</div>
		
		<!-- 유의사항 WRAPPER -->
		<div class="caution-wrap">
			<a href="#" class="sprite btn_caution evt-caution-2">꼭!확인하세요</a>

			<!-- 유의사항 드롭다운 -->
			<div class="moreview" style="border-bottom:1px solid #222">
				<h4>유의사항</h4>
				<div class="txt">
					<dl class="txtlist">
						<dt>이벤트/구매 기간 :</dt>
						<dd>2019년 8월 19일 ~ 9월 15일</dd>
					</dl>
					
					<dl class="txtlist">
						<dt>경품 : </dt>
						<dd>1등 – [LG] 울트라 와이드 모니터 34WK500 (실물배송) - 1명 추첨 <strong class="emp">※제세공과금 당첨자 부담</strong></dd>
						<dd>2등 - [북앤라이프] 도서문화상품권 1만원권(e 10,000점)-  20명 추첨</dd>
						<dd>3등 – [투썸플레이스] 자몽에이드 (e머니 5,500점) – 40명 추첨<br></dd>
						<dd><strong>e머니 유효기간 : 적립일로부터 15일</strong></dd>
						<dd>사정에 따라 경품이 변경될 수 있습니다.</dd>			
					</dl>
		
					<dl class="txtlist">
						<dt>당첨자 발표 및 적립</dt>
						<dd>2019년 10월 29일 [APP 이벤트/기획전 탭 &gt; 이벤트 하단 당첨자 발표]</dd>
					</dl>
					
					<dl class="txtlist">
						<dt>구매방법 및 유의사항</dt>
						<dd>에누리 가격비교 앱 로그인 → 적립대상 쇼핑몰 이동 → 구매하기 → 구매확정(배송완료) 금액이 1,000원 이상 시 e머니 적립</dd>
						<dd>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스)</dd>
						<dd>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품 결제금액만 반영</dd>
						<dd>구매 e머니는 구매 확인완료 시점(구매 후 최대 30일)부터 모바일 앱 → 마이 에누리 → 적립내역 페이지에서 페이지에서 확인 가능</dd>
						<dd>구매 e머니는 카테고리에 따라 차등 적립</dd>
						</dl>
						
						<dl class="txtlist">
						<dt>※ 카테고리별 적립률 상세						
							<div class="tb">
								<table>
									<colgroup>
										<col width="65%"><col width="30%">
									</colgroup>
									<tbody>
										<tr>
											<th>카테고리</th>
											<th>적립률</th>
										</tr>
										<tr>
											<td>유아</td>
											<td>1.5%</td>
										</tr>
										<tr>
											<td>식품/스포츠/레저/자동차</td>
											<td>1.0%</td>
										</tr>
										<tr>
											<td>컴퓨터/도서/취미</td>
											<td>0.8%</td>
										</tr>
										<tr>
											<td>디지털/가전</td>
											<td rowspan="5">0.3%</td>
										</tr>
										<tr>
											<td>패션/화장품</td>
										</tr>
										<tr>
											<td>가구/생활/건강</td>
										</tr>
										<tr>
											<td>모바일쿠폰,상품권</td>
										</tr>
										<tr>
											<td>기타</td>
										</tr>
									</tbody>
								</table>
							</div>
						</dt>
						<dd>적립대상쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제 시 구매건수는 1건이며, 구매금액은 통합 결제한 금액의 e머니 적립</dd>
						<dd>결제일로부터 10~30일간 취소/반품여부 확인 후 적립</dd>
						<dd>e머니는 최소 10점부터 적립되며 (구매금액 1,000원 이상), 1원 단위 e머니는 적립되지 않습니다. 
							<br>(예: 1,200원 결제 시 e머니 10점 적립)</dd>
						<dd>구매적립 e머니 유효기간: 적립일로부터 60일</dd>
						<dd>적립된 e머니는 e쿠폰 스토어에서 다양한 e쿠폰으로 교환 가능합니다.</dd>
					</dl>
						
					<dl class="txtlist">
						<dt>상품권 및 e쿠폰 적립 상세</dt>
						<dd>적립가능 상품 (0.3% 적립): 문화상품권(해피머니, 컬쳐랜드), 도서상품권, 백화점상품권, 영화예매권, 국민관광 상품권</dd>
						<dd>적립가능 상품을 제외한 상품권, 지역쿠폰, e교환권, e쿠폰은 적립불가</dd>
						<dd>상품권 적립가능 쇼핑몰: 티몬, G마켓, 옥션</dd>
					</dl>
		
					<dl class="txtlist">
						<dt>아래의 경우에는 구매 확인 및 적립이 불가합니다.</dt>
						<dd>에누리 가격비교 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱으로 결제만 한 경우<br>(에누리 가격비교 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)</dd>
						<dd>에누리 가격비교 앱 미 로그인 후 구매한 경우 또는 에누리 가격비교 PC, 모바일 웹에서 구매한 경우</dd>
					</dl>
					
					<dl class="txtlist">
						<dt>적립대상쇼핑몰 중 e머니 적립 제외 카테고리/서비스 </dt>
						<dd>에누리 가격비교 앱에서 검색되지 않는 상품</dd>
						<dd>인터파크: 에누리 특가상품(크레이지딜), 모바일쿠폰/상품권, 라이프 서비스(티켓, 투어, 아이마켓 등)</dd>
						<dd>11번가: 여행/숙박/항공, 모바일쿠폰/상품권 전체</dd>
						<dd>G마켓: 중고장터, 실시간 여행, 항공권, 도서/음반, 모바일쿠폰/상품권(일부 상품권 적립가능)</dd>
						<dd>옥션: 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권(일부 상품권 적립가능)</dd>
						<dd>SSG: 도서/음반/문구/취미/여행, 모바일쿠폰/상품권/서비스 및 현금성 상품</dd>
						<dd>티몬: 슈퍼꿀딜, 슈퍼마트 등 특가 판매 상품, 모바일쿠폰/상품권(일부 상품권 적립가능)</dd>
						<dd>위메프: 모바일쿠폰/상품권 전체</dd>
						<dd>CJ몰: 모바일쿠폰/상품권 전체</dd>
						<dd>모바일쿠폰/상품권: 상품권, 지역쿠폰, e교환권, e쿠폰 등 (문화상품권, 도서상품권, 백화점상품권, 영화예매권, 국민관광상품권은 적립 가능)</dd>
						<dd>이 외 쇼핑몰에 입점한 제휴 서비스(배달, 티켓, 해외직구 등) 및 일부 카테고리 제외</dd>
					</dl>
					
					<dl class="txtlist">
						<dt>유의사항</dt>
						<dd>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</dd>
						<dd>더블적립 대상자는 본 이벤트와 중복참여하실 수 없습니다.</dd>
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

	<span class="go_top"><a href="javascript:///">TOP</a></span>
</div>

<!-- layer--> 
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();">설치하기</button></p>
	</div>
</div>

<!-- 당첨 레이어 --> 
<div class="voteResult_layer" id="prizes" style="display:none">
	<div class="inner_layer">
		<div class="cont_area">
			<div class="img_box">
				<!-- 5,800점 적립 이미지 -->
				<div class="result_01" style="display:none">
					<img src="http://img.enuri.com/images/event/2019/chuseok_pro/m_result_img_01.jpg" alt="축하해요~!! e머니 5,800점 적립 내일 또 만나요~">
				</div>
				<!-- 5점 적립 이미지 -->
				<div class="result_02" style="display:none">
					<img src="http://img.enuri.com/images/event/2019/chuseok_pro/m_result_img_02.jpg" alt="5점 적립~">
				</div>
			</div>
			<a class="btn layclose" href="#" onclick="onoff('prizes'); return false;"><em>팝업 닫기</em></a>
		</div>
	</div>
</div>

<!-- 이벤트 응모완료 -->
<div class="event_layer complete" id="completeJoin" style="display:none">
	<div class="inner_layer">
		<h3 class="tit stripe_layer">응모가 완료되었습니다.</h3>
		<a href="javascript:///" class="stripe_layer close" onclick="onoff('completeJoin')">창닫기</a>
		<div class="viewer">
			<ul class="new_product_list" id="completeJoin_list"></ul>
		</div>
		<p class="btn_close"><button type="button" class="btn_confirm stripe_layer" onclick="onoff('completeJoin')">확인</button></p>
	</div>
</div>

<!-- 이벤트1 유의사항 --> 
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="noteLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1');return false;">창닫기</a>
		<div class="inner">
			<ul class="txtlist">
				<li>ID당 1일 1회 참여 가능</li>
				<li>이벤트 경품: e5,800점, e5점</li>
				<li>적립된 e머니는 e머니 스토어에서 다양한 e쿠폰상품으로 교환 가능합니다.</li> 
				<li class="emp">e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
			</ul>
		</div>
		<p class="btn_close"><button type="button" onclick="onoff('notetxt1');return false;">닫기</button></p>
	</div>
</div>

<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20180831"></script>
<script type="text/javascript">
var app = getCookie("appYN"); //app인지 여부
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로
var vEvent_title = "19년 추석 프로모션";
var isFlow = "<%=flow%>" == "ad";
var vOs_type = getOsType();
var state = false;
var tab = "<%=tab%>";

$(".go_top").click(function(){		$('body, html').animate({scrollTop:0}, 500);	});

Kakao.init('5cad223fb57213402d8f90de1aa27301');

/* 데이터 로드 영역 */
var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=29";

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
		ga('send', 'event', 'mf_event', vEvent_title, "19 추석 프로모션_탭_이벤트1");
	}else if(num == 3){
		ga('send', 'event', 'mf_event', vEvent_title, "19 추석 프로모션_탭_이벤트2");
	}else if(num == 4){
		ga('send', 'event', 'mf_event', vEvent_title, "19 추석 프로모션_탭_타임딜");
	}else if(num == 5){
		ga('send', 'event', 'mf_event', vEvent_title, "19 추석 프로모션_상단플로팅배너");
	}else if(num == 6){
		ga('send', 'event', 'mf_event', vEvent_title, "19 추석 프로모션_이벤트1참여");
	}else if(num == 7){
		ga('send', 'event', 'mf_event', vEvent_title, "19 추석 프로모션_상품탭_한우선물");
	}else if(num == 8){
		ga('send', 'event', 'mf_event', vEvent_title, "19 추석 프로모션_상품탭_신선선물");
	}else if(num == 9){
		ga('send', 'event', 'mf_event', vEvent_title, "19 추석 프로모션_상품탭_가공선물");
	}else if(num == 10){
		ga('send', 'event', 'mf_event', vEvent_title, "19 추석 프로모션_상품탭_생활선물");
	}else if(num == 11){
		ga('send', 'event', 'mf_event', vEvent_title, "19 추석 프로모션_상품탭_건강선물");
	}else if(num == 12){
		ga('send', 'event', 'mf_event', vEvent_title, "19 추석 프로모션_상품탭_상품권");
	}else if(num == 13){
		ga('send', 'event', 'mf_event', vEvent_title, "19 추석 프로모션_상품클릭");
	}else if(num == 14){
		ga('send', 'event', 'mf_event', vEvent_title, "19 추석 프로모션_상품더보기");
	}else if(num == 15){
		ga('send', 'event', 'mf_event', vEvent_title, "19 추석 프로모션_기획전보러가기");	
	}else if(num == 16){
		ga('send', 'event', 'mf_event', vEvent_title, "19 추석 프로모션_구매응모하기");
	}else if(num == 17){
		ga('send', 'event', 'mf_event', vEvent_title, "19 추석 프로모션_구매응모상품클릭");
	}else if(num == 18){
		ga('send', 'event', 'mf_event', vEvent_title, "19 추석 프로모션_혜택배너");
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
		window.location.replace("/mobilefirst/index.jsp");
	}
});

(function (global, $) {
	$(function () {
		// 해당 섹션으로 스크롤 이동 
		$menu.on('click', 'a', function (e) {
			var $target = $(this).parent(),
				idx = $target.index(),
				offsetTop = Math.ceil($contents.eq(idx).offset().top);

			$('html, body').stop().animate({ scrollTop: offsetTop - $navheight }, 500);
			return false;
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
				// $menu.children("a").eq(0).addClass('is-on');
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

$(document).ready(function() {
	// 개인정보 불러오기
	if(islogin()){
		$(".login_alert").addClass("disNone");
		$("#user_id").text("<%=cUserId%>");
	}
	
	ga('send', 'pageview', {'page': vEvent_page,'title': '19 추석 프로모션_PV'});
	
	if(tab != ""){
		setTimeout(function() {
	        $(".floattab__list li > a").eq(tab-1).trigger("click");
	    },300);
	}
	
	//응모하기 버튼
	$("#event2_join").click(function(e){
		da_ga(16);
		if(app != 'Y'){
			onoff('app_only');
		}else {
			getEventAjaxData({"procCode": 2}, function(data){
				var result = data.result;
			    if(result == 2601){
			       alert("이미 응모하셨습니다.\n앱에서 구매 시\n구매내역 자동 누적됩니다.");
			    }else if( result == 1 ){
			        //alert("이벤트에 응모해주셔서 감사합니다.");
			         var rdm = Math.floor(Math.random() * 5);
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
			 				html+= "	<a href=\"javascript:;\" onclick=\"window.open('/mobilefirst/detail.jsp?modelno="+modelno+"&freetoken=vip');da_ga(17);\" title=\"새 탭에서 열립니다.\">";
			 				html+= "		<div class=\"img_box\">";
			 				html+= "			<img src=\""+goodsData["GOODS_IMG"]+"\" alt=\"\" />";
			 				if(goodsData["MINPRICE"]==0){
			 				html+= "			<span class=\"soldout\">SOLD OUT</span>";	
			 				}
			 				html+= "		</div>";
			 				html+= "		<div class=\"txt_box\">";
			 				html+= "			<span class=\"n_ptit\">"+goods_title1+"<br />"+goods_title2+"</span>";
			 				html+= "			<div class=\"n_price\">";
			 				html+= "				<span class=\"min stripe_layer\">지금최저가</span>";
			 				html+= "			    <span class=\"num\"><strong>"+numberWithCommas(goods_minprice)+"</strong>원</span>";
			 				html+= "			</div>";
			 				html+= "		</div>";
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
		da_ga(15);
		window.open("/mobilefirst/event2019/chuseok_2019.jsp");
		return false;
	});
	
	//로그인시 개인화영역
	if(islogin()){
		$("#user_id").text("<%=cUserId%>");
		getPoint();//개인e머니 내역 노출
	}
	
	$(".sprite.btn_more").click(function(){
		var tabnum = nowTab;
		var goods_more = "/mobilefirst/event2019/chuseok_2019.jsp?protab="+tabnum;
		da_ga(14);
		window.open(goods_more); 
	});
	
	$("#snslayer li").click(function(){
		var shareUrl = "http://" + location.host + "/mobilefirst/event2019/chuseok_2019_evt.jsp";
		var shareTitle = "[에누리 가격비교]\n추석 이벤트!";
		var idx = $(this).index();
		
		if(idx == 1) {
			 try{ 
				
				Kakao.Link.sendDefault({
				      objectType: 'feed',
				      content: {
				        title: shareTitle,
				        description: "다가온 추석명절!\n추석선물 구매하면\nLG 울트라와이드 모니터 추첨증정\n지금 당장 에누리로~!",
				        imageUrl: "<%= ConfigManager.IMG_ENURI_COM%>/images/mobilenew/images/sns_chuseok_1200_630.jpg",
				        link: {
				          mobileWebUrl: shareUrl,
				          webUrl: shareUrl
				        }
				      }
				    });
				
			}catch(e){
				alert("카카오 톡이 설치 되지 않았습니다.");
				alert(e.message);
			}
		} else {
			window.open("http://www.facebook.com/sharer.php?u=" + shareUrl);
		}
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
    var rndNum = Math.floor(Math.random() * 5);
    nowTab = rndNum+1;
    var object = ajaxData[rndNum]["GOODS"];
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
			var object = ajaxData[0]["GOODS"];
			loadGoodsList(object);
			da_ga(7);
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			
			nowTab = 1;
		}else if(activeTab == "#protab2"){
			var object = ajaxData[1]["GOODS"];
			loadGoodsList(object);
			da_ga(8);
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			
			nowTab = 2;
		}else if(activeTab == "#protab3"){
			var object = ajaxData[2]["GOODS"];
			loadGoodsList(object);
			da_ga(9);
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			
			nowTab = 3;
		}else if(activeTab == "#protab4"){
			var object = ajaxData[3]["GOODS"];
			loadGoodsList(object);
			da_ga(10);
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			
			nowTab = 4;
		}else if(activeTab == "#protab5"){
			var object = ajaxData[4]["GOODS"];
			loadGoodsList(object);
			da_ga(11);
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			
			nowTab = 5;
		}else if(activeTab == "#protab6"){
			var object = ajaxData[5]["GOODS"];
			loadGoodsList(object);
			da_ga(12);
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			
			nowTab = 6;
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
					html+= "	<a href=\"javascript:;\" onclick=\"itemClick("+goodsData["MODELNO"]+","+goodsData["MINPRICE"]+");da_ga(13);\" target=\"_blank\" title=\"새 탭에서 열립니다.\">";
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
	if(sdt < "20190819"){
		alert('오픈예정입니다.');
		return false;
	}
	if(sdt > "20190915"){
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
				location.href="<%=ConfigManager.ENURI_COM_SSL%>/mobilefirst/member/myAuth.jsp?cmdType=modify&f=p";
			}else{
				return false;
			}
		}
	}
	
	var evtUrl = "/mobilefirst/evt/ajax/chuseok2019_setlist.jsp";
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

$(document).ready(function(){
	// 토끼가 숨어있는 달을 찾아주세요
	var moonFindGame = {
		el : {
			wrap : $(".game_wrap"),
			main : $(".game_main"),
			moon : $(".game_wrap ul li"),
			layer : $(".game_wrap .layer_area")
		},
		init : function(){
			this.addEvent();
		},
		addEvent : function(){
			// 달 클릭 이벤트 
			this.el.moon.each(function(e){
				$(this).click(function(){
					da_ga(6);
					getEventAjaxData( {"procCode":1} , function(data) {
						result = data.result;
					    if(result >= 5){
							// 정답모션 시작
							$(this).addClass("selected").siblings().addClass("dropout").parent().addClass("selected");
							setTimeout(function(){
								// 당첨결과 보기
								rewards(result);
							},1000);
					    }else if(result == -1){
							alert("이미 참여하셨습니다.\n내일 또 참여해주세요.");
				            working = false;
						}else if(result == -2 || result == -99){
							alert("임직원은 참여 불가합니다.");
				            working = false;
						} else if(result == -55){
							alert("잘못된 접근입니다.");
						}else{
				            working = false;
						}
					});
				})
			})
		},
		clear : function(){ // 오브젝트 치우기
			this.el.main.fadeOut(500);								
		},
		reset : function(){ // 오브젝트 재배치
			this.el.moon.removeClass("selected dropout").parent().removeClass("selected");
			this.el.main.fadeIn(300);
			this.el.layer.fadeOut(100);
		}
	}
	// 실행
	moonFindGame.init();

	// 당첨 결과 처리
	function rewards(result){
		// 스크린 비우기
		moonFindGame.clear();
		// 0 - 낙첨 - 5점 적립
		// 1 - 당첨 - 5,800점 적립
		setTimeout(function(){
			// 레이어 띄우기
			var $Layer = moonFindGame.el.layer;
			// 결과 레이어 노출
			if (result==5){ // 낙첨
				$Layer.find(".layer_fail").show()
				$Layer.fadeIn();
				// 팝업 띄우기
				setTimeout(function(){										
					// 팝업 띄우기
					onoff('prizes');
					$("#prizes").find(".result_02").show(); // 5점
					// 게임 초기화
					moonFindGame.reset();
				},1000);
			}else if(result==5800){  // 당첨
				$Layer.find(".layer_success").show()
				$Layer.fadeIn();
				// 팝업 띄우기
				setTimeout(function(){										
					// 팝업 띄우기
					onoff('prizes');
					$("#prizes").find(".result_01").show(); // 5,800점
					// 게임 초기화
					moonFindGame.reset();
				},1000);
			}
		},500);
	}         						
  
	//기획전상품
	tabLoading()
});

$(window).load(function(){
	if(tab!='') {
		setTimeout(inner, 500);
	}
	function inner() {
		$('html, body').animate({scrollTop: Math.ceil($('#'+tab).offset().top-50)}, 500);
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
	welcomeGa("evt_chuseok_view"); 
	},500);
</script>
</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
