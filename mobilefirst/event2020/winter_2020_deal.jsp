<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
	response.sendRedirect("/event2020/winter_2020_deal.jsp");
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
<meta name="title" content="2020 월동 통합기획전 - 최저가 쇼핑은 에누리">
<meta name="description" content="온 가족 타임특가! 매주 수요일마다 터지는 득템의 기회!">
<meta name="keyword" content="에누리 가격비교, 통합기획전, 월동, 겨울">
<!-- 페이스북 공유하기 메타태그 동적 추가  -->
<meta id="meta_og_title" property="og:title" content="[에누리 가격비교] 월동에누리다!">
<meta id="meta_og_description" property="og:description" content="매주 수요일 타임특가도 만나보세요!">
<meta id="meta_og_image" property="og:image" content="<%=ConfigManager.IMG_ENURI_COM+ "/images/event/2020/winter/sns_1200_630.jpg"%>">
<meta name="format-detection" content="telephone=no" />
<title>2020 월동 기획전 - 최저가 쇼핑은 에누리</title>
<!-- 프로모션 공통 CSS (Mobile) -->
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<!-- 프로모션별 커스텀 CSS  -->
<link rel="stylesheet" href="/css/event/y2020/winter_m.css" type="text/css">
<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
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
<div id="eventWrap">
<!-- 비쥬얼,플로팅탭 -->
	<%@include file="/mobilefirst/event2020/winter_header.jsp" %>
	<!-- //비쥬얼,플로팅탭 -->

	
	<!-- T2 이벤트 02 : 월동 타임특가 -->
	<div id="event02" class="section event_02 scroll dealwrap">
		<div class="contents">
			<h2>
				<span class="tit_txt_01 blind">매주 수요일 오후 2시 OPEN</span>
				<span class="tit_date">
					<!-- 월일 노출 -->
					<span class="txt_month">10</span>월 <span class="txt_day">28</span>일
				</span>
				<strong class="tit_txt_02 blind">월동 타임특가</strong>
			</h2>
			<!-- 딜 구매영역 -->
			<div class="deal_slide">
			</div>
			<!-- //딜 구매영역 -->
		</div>
		<div>
			<!-- 딜 리스트영역 -->
			<div class="deal_list">
				<h4>Next Week</h4>
				<div class="deal_nav">
				</div>
			</div>
			<!--// 딜 리스트영역 -->
		</div>

		<!-- 공통 : 꼭 확인하세요  -->
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop2"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop2" class="evt_notice--slide">
			<div class="evt_notice--inner">
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<ul>
							<li>본인인증이 완료된 ID로만 참여가능합니다.</li>
							<li>시즌기획전 타임딜 상품의 주문/배송/환불/보증 책임은 해당 쇼핑몰의 판매자에게 있습니다.</li>
							<li>타임특가는 에누리 및 인터파크 ID 1개 당 1번만 구매 가능하며, 부정적인 방법으로 동일 상품을 1번 이상 구매한 경우 결제완료 한 경우라도 모든 구매 및 결제가 취소처리 됩니다. </li>
							<li>본 이벤트는 당사에 사정에 따라 사전고지 없이 변경 또는 조기종료 될 수 있습니다.</li>
							<li>시즌기획전 타임딜은 선착순 한정수량 판매로 결제 진행 중 상품이 품절될 경우 판매가 종료될 수 있습니다.</li>
							<li>에누리 모바일 APP에서만 구매가능하며, 이 외 다른 환경(인터파크 APP 등)에서 구매시도하여 발생되는 문제에 대해서는 책임 및 보상이 이루어지지 않습니다.</li>
						</ul>
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

	<!-- T2 이벤트 03 : 타입특가 공유이벤트 -->
	<div id="event03" class="section event_03 scroll">
		<div class="inner">
			<h2>
				<span class="tx_main"><em>딜 공유</em> 하고 선물받자!</span>
				<span class="tx_sm">타일딜을 SNS로 공유하면 추첨을 통해 20분에게 선물을 드립니다.</span>
			</h2>
			<div class="gift">
				<span class="blind">경품은 E머니로 지급됩니다.</span>
			</div>
			<ul class="share_list">
				<li class="btn_fb"><a href="javascript:Share_detail('face');">페이스북<span class="blind"> 공유하기</span></a></li>
				<li class="btn_ka" id="kakao-link-btn"><a href="javascript:Share_detail('kakao');">카카오톡<span class="blind"> 공유하기</span></a></li>
				<li class="btn_co"><a href="javascript:void(0);" data-clipboard-text="http://m.enuri.com/mobilefirst/event2020/winter_2020_deal.jsp?oc=sns">URL복사</a></li>
			</ul>			
		</div>
		<script>
			$(function(){
				var clipboard = new ClipboardJS('.share_list .btn_co a');
				clipboard.on('success', function(e) {
					if(islogin()){
						alert('주소가 복사되었습니다');
						sharePaticipant('url');
					}else{
						alert("로그인 후 이용 가능합니다.");
						goLogin();
						return false;
					}
				});
				clipboard.on('error', function(e) {
					console.log(e);
				});
			});
		</script>
		<!-- 공통 : 꼭 확인하세요  -->
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice btn__white" data-laypop-id="slidePop3"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop3" class="evt_notice--slide">
			<div class="evt_notice--inner"> 
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<ul>
							<li>당첨자 발표 : 2021년 2월 25일</li>
							<li>e머니 유효기간 : 적립일로부터 15일</li>
							<li>e머니 적립후 APP PUSH 메시지 발송 (PUSH 알림 미동의자 제외)</li>
							<li>SNS 공유는 횟수 제한없이 참여 가능합니다.</li>
						    <li>적립된 e머니는 e머니 스토어에서 다양한 e머니 쿠폰상품으로 교환 가능합니다.</li>
							<li>경품은 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격변동이 있을 수 있습니다.</li>
							<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
							<li>부정참여 시 적립 취소 및 사이트 사용이 제한 될 수 있습니다.</li>						   
						</ul>
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
	<div id="event05" class="section event_05 scroll">
		<div class="inner">
			<h2>
				<span class="tx_main">
					APP에서 월동 준비하면
					<em>따끈한 온열테이블 당첨!</em>
				</span>
				<span class="tx_sm">많이 구매할 수록 당첨 확률 UP! UP!</span>
			</h2>
			<div class="gift">
				<ol class="blind">
					<li>1등 난방테이블 지이라이프 KOW-105 (실물배송/색상랜덤) - 3명 추첨</li>
					<li>2등 양키캔들 자캔들(소) e15,000점 - 10명 추첨</li>
					<li>3등 본죽 동지팥죽 e9,000점 - 50명 추첨</li>
				</ol>
			</div>
			<!-- 버튼 : 응모하기 -->
			<button class="btn_apply" id="event2_join">응모하기 &gt;</button>
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
									<li>2020년 10월 26일 ~ 2020년 11월 22일</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>당첨자 발표 및 적립</dt>
							<dd>
								<ul>
									<li>2021년 2월 25일 [APP 이벤트/기획전 탭 &gt; 이벤트 하단 당첨자 발표]</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>경품</dt>
							<dd>
								<ul>
									<li>1등 – 난방테이블 지이라이프 KOW-105(담요표함X) - 3명 추첨  <span class="stress">※제세공과금 당첨자 부담</span></li>
									<li>2등 – 양키캔들 자캔들(소) (e 15,000점) - 10명 추첨</li>
									<li>3등 – 본죽 동지팥죽 (e 9,000점) – 50명 추첨</li>
								</ul>
								<br>
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
							<dt>e머니 구매 적립 기준 및 유의사항</dt>
							<dd>
								<ul>
									<li>적립방법 : 에누리 가격비교 모바일 앱 로그인 → 적립대상 쇼핑몰 이동 → <span class="stress">1천원 이상 구매</span> → 구매확정(배송완료) 시 e머니 적립</li>
									<li>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 에누리 해외직구관, SK스토아, 홈플러스<br>
										<span class="stress">※ 티몬 및 에누리 해외직구관의 경우 PC 및 모바일 앱/웹에서 로그인 후 구매시에도 구매적립 가능합니다.</span>
									</li>
									<li>구매적립 e머니는 구매일로부터 10 ~ 30일간 취소/환불/교환/반품여부 확인 후 적립 됩니다.</li>
									<li><span class="stress">구매적립 e머니 유효기간 : 적립일로부터 60일 (유효기간 만료 후 재적립 불가)</span><br>
										※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</li>
									<li>구매적립 e머니는 최소 10점(구매금액 1천원 이상)부터 적립되며, 1원 단위 e머니는 적립되지 않습니다.</li>
									<li>구매적립 e머니는 구매확정(구매일로부터 최	대 30일) 시점부터 MY 에누리 적립내역 페이지에서 확인 가능합니다.</li>
									<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다.</li>
									<li>적립대상 쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제하는 경우 구매건수는 1건이며 구매금액은 통합된 금액으로 e머니 적립 됩니다.</li>									
								</ul>
							</dd>

							<dt>※ 카테고리별 적립률 상세</dt>
							<dd>
								<table class="evt_noti_tb" style="width:320px;">
									<colgroup>
										<col>
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
											<td>가구,인테리어/생활,취미</td>
										</tr>
										<tr>
											<td>모바일쿠폰,상품권<br>
												<p class="stress">*특정 상품에 한하여 적립되오니<br>적립가능 상품은 하단에서 확인해주세요.</p>
											</td>				
											<td>0.2%</td>									
										</tr>
									</tbody>
								</table>
							</dd>
						</dl>
						<dl>
							<dt class="stress">[모바일쿠폰,상품권 ] 구매적립 기준</dt>
							<dd>									
								<ul>
									<li>적립가능 쇼핑몰 : G마켓, 옥션, 인터파크
									</li>
									<li>적립가능 상품 (0.2% 적립) : 문화상품권(해피머니, 컬쳐랜드), 도서상품권, 백화점상품권, 영화예매권, 국민관광 상품권</li>
									<li>백화점상품권 기준 상세
										<ul class="sub">
											<li>1) 상품명에 '백화점 상품권' 명시된 상품 또는 백화점에서만 사용할 수 있는 상품권만 적립가능</li>
											<li>2) 복합상품권 적립불가 (삼성 상품권, 신세계 기프트카드, 롯데카드 상품권, 이랜드 상품권, AK플라자 상품권, 통합 상품권 등)<br>
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
											<li>- G마켓 : 중고장터, 실시간 여행, 항공권, 도서/음반, 모바일쿠폰/상품권(일부 적립가능 <span class="stress">※ 2020년 11월 1일부터 적립불가</span> )</li>
											<li>- 옥션 : 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권(일부 적립가능)</li>
											<li>- 11번가 : 여행/숙박/항공, 모바일쿠폰/상품권</li>
											<li>- 인터파크 : 라이프 서비스(티켓, 투어, 아이마켓 등), 모바일쿠폰/상품권(일부 적립가능)</li>
											<li>- 티몬 : 특가 판매 상품(슈퍼꿀딜, 슈퍼마트 등), 모바일쿠폰/상품권</li>
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
	<!-- 공통 : 하단 에누리 혜택 -->
	<div class="otherbene">
        <div class="inner">
            <h3 class="blind">놓칠 수  없는 특별한 혜택, 에누리 혜택</h3>
            <ul class="ben_list">
                <li class="ben_item--01"><a href="http://m.enuri.com/mobilefirst/evt/welcome_event.jsp" target="_blank">첫구매 고객이라면! Welcome 혜택</a></li>
                <li class="ben_item--02"><a href="http://m.enuri.com/mobilefirst/evt/visit_event.jsp" target="_blank">하루라도 농치면 손해 매일100% 당첨</a></li>
                <li class="ben_item--03"><a href="http://m.enuri.com/mobilefirst/evt/smart_benefits.jsp?freetoken=event&tab=2" target="_blank">지금 가전을 구매하면? 최대 적립 10배</a></li>
                <li class="ben_item--04"><a href="http://m.enuri.com/mobilefirst/renew/plan.jsp?freetoken=main_tab|event" target="_blank">아직 끝나지 않은 혜택 더 많은 이벤트</a></li>
            </ul>
        </div>
	</div>
	<!-- // -->

</div>

<!-- 모바일웹 공통 : 모바일 앱 전용 이벤트  -->
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btn();">설치하기</button></p>
	</div>
</div>

<!-- 이벤트5 : 이벤트 응모완료 -->
<div class="complete_layer" id="completeJoin" style="display:none">
	<div class="inner_layer">
		<div class="cont_area">
			<p class="tit">응모가 완료되었습니다.</p>
			<div class="img_box" id="completeJoin_list">
				<a href="/mobilefirst/evt/smart_benefits.jsp?freetoken=event&chk_id="><img src="http://img.enuri.info/images/event/2020/winter/m_complete_640_500.jpg" alt="" /></a>
			</div>
		</div>
		<a class="btn layclose" href="#" onclick="onoff('completeJoin'); return false;"><em>팝업 닫기</em></a>
	</div>
</div>

<!-- 공통 : 프론트배너 -->
<div class="dim" id="mainLayer" style="z-index:999;display: none">
	<!-- 백그라운드 터치 : 닫기 -->
	<span class="dim__back" onclick="$(this).closest('.dim').fadeOut(200);return false;"></span>
</div>
<!-- // 프론트배너 -->

<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
<script type="text/javascript" src="/js/clipboard.min.js"></script>

<script type="text/javascript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
<script type="text/javascript">
	var event_share_description = "";
	var event_share_img  = "";
	var cnt = 0;
	var $navHgt = 0;
	var app = getCookie("appYN"); //app인지 여부
	var makeHtml = "";


  
	/* 퍼블테스트 : 레이어 열고 닫기*/
	function onoff(id){
		var mid = $("#"+id);
		if(mid.css("display") !== "none"){
			mid.css("display","none");
		}else{
			mid.css("display","");
		}
	}
	function view_moapp(){
		var chrome25;
		var kitkatWebview;
		var uagentLow = navigator.userAgent.toLocaleLowerCase();
		var openAt = new Date;
		var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2020%2Fwinter_2020_deal.jsp";
		if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
			goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2020/winter_2020_deal.jsp";
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
	$(document).ready(function(){
 		//ga > pageview

		$(".ben_item--04").click(function(){
			var url = (app != "Y" ? "/mobilefirst/index.jsp#evt" : "/mobilefirst/renew/plan.jsp?freetoken=main_tab|event")
			window.open(url);
		});

		//#애드브릭스 타임특가 PV
		setTimeout(function(){
			welcomeGa("evt_winter2020 deal_view");
		},500);

		//딜 상품
		$.ajax({
			  url: "/mobilefirst/http/json/exh_deal_list_2020101200.json" //
			, dataType : "json"
			, cache    : false
			, success  : function(data){
				var vCur_dtm = "<%= strToday %>";
				var dealItem = "";
				var dealList = "";
				var month = "";
				var day = "";
				var text = "";
				$.each(data, function(i,v){
					//딜 판매날짜, 할인률
					month = parseInt(v.GD_SAL_S_DTM_CVT.substring(4,6));
					day = parseInt(v.GD_SAL_S_DTM_CVT.substring(6,8));
					text = v.GD_DC_RT+"% 타임특가 / "+v.GD_QTY+"개 한정";
					cnt = data.length;

					dealItem += "<div class=\"deal_item clearfix\">";
					dealItem += "	<div class=\"container\">";
					dealItem += "		<div class=\"thumb\">";
					dealItem += "			<img src=\"http://storage.enuri.info/Web_Storage"+v.GD_IMG_URL+"\" />";
					dealItem += "			<span class=\"ico_limit\">";
					dealItem += "				<strong>"+v.GD_DC_RT+"%</strong>";
					dealItem += "				<span class='txt_limit'>선착순 "+v.GD_QTY+"개</span>";
					dealItem += "			</span>";
					dealItem += "		</div>";
	                dealItem += "		<div class=\"item_info\">";
	                dealItem += "			<div class=\"inner\">";
	                dealItem += "				<p class=\"tit\">"+v.GD_MODEL_NM1+"&nbsp"+v.GD_MODEL_NM2+"</p>";
	                dealItem += "				<p class=\"price\"><strong>"+commaNum(v.GD_DC_PRC)+"<span>원</span></strong></p>";
	                dealItem += "			</div>";
	                dealItem += "			<ul class=\"btn_area clearfix\" id=\"ul_btn"+i+"\">";
	                dealItem += "				<li><a href=\"/mobilefirst/detail.jsp?modelno="+v.GD_MODEL_NO+"&freetoken=vip\" class=\"btn_dview\" target=\"_blank\" onclick=\"ga_log(8)\">상품보기</a></li>";
	                if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT > vCur_dtm) { //판매 전
		                dealItem += "			<li id='deal_btn'><a class=\"btn_buy_ready\">판매예정</a></li>";
			        }else if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT <= vCur_dtm && v.GD_SAL_E_DTM_CVT >= vCur_dtm){ //판매 중
		                dealItem += "			<li id='deal_btn'><a class=\"btn_buy\" onclick=\" fnDeal("+v.EXH_DEAL_NO+",'2020081903'); ga_log(9); return false;\">구매하기</a></li>";
			        }else{ // 판매 종료
		                dealItem += "			<li id='deal_btn'><a class=\"btn_buy_soldout\">Sold out</a></li>";
		        	}
	                dealItem += "			</ul>";
	                dealItem += "		</div>";
	                dealItem += "	<p class=\"ad\">※ 쿠폰적용 필수 / ID당 1회 구매가능 / 무료배송 <span class=\"mark\"><img src=\"http://img.enuri.info/images/event/2020/newyear/ico_interpark.png\" alt=\"인터파크\"></span></p>";
	        	    dealItem += "	</div>";
	        	    dealItem += "</div>";

	        		dealList += "<div class=\"w_item\" onclick=\"ga_log(10);\">";
	                dealList += "	<div class=\"w_thumb\">";
	                dealList += "		<img src=\"http://storage.enuri.info/Web_Storage"+v.GD_IMG_URL+"\" />";
	                dealList += "	</div>";
					dealList += "	<div class=\"period\">";
	                dealList += "		<span id='date'>"+month+"/"+day+"</span><span id=week>("+getWeek(v.GD_SAL_S_DTM_CVT)+") 14:00</span>";
	                dealList += "	</div>";
	                dealList += "	<span class=\"w_tit\">"+v.GD_MODEL_NM1+"<br>"+v.GD_MODEL_NM2+"</span>";
					dealList += "</div>";

					// 공유하기 title/description
					if(v.GD_SAL_S_DTM_CVT >= vCur_dtm){
						if(event_share_img == ""){
							event_share_img = v.GD_IMG_URL;
							event_share_description = month+"월 "+day+"일 수요일 오후 2시! "+v.GD_MODEL_NM1+v.GD_MODEL_NM2+" "+commaNum(v.GD_DC_PRC)+"원!";
						}
					}

				});
				$('#event02 .deal_slide').html(dealItem);
				$('#event02 .deal_list .deal_nav').html(dealList);

			}
			, complete: function(){
				var $deal_slide = $('#event02 .deal_slide');
				var $w_item = $('.deal_nav .w_item');

				$('.deal_slide').slick({
					slidesToShow: 1,
					slidesToScroll: 1,
					arrows: true,
					dots: true,
					fade: false,
					//speed: 0,
					asNavFor: '.deal_nav'
				})
				$('.deal_nav').slick({
					slidesToShow: 3,
					slidesToScroll: 1,
					asNavFor: '.deal_slide',
					dots: false,
					centerMode: true,
					focusOnSelect: true,
					variableWidth: true
				});

				dealDate();

				$deal_slide.on('beforeChange', function(e, s, c, n){
			    	$w_item.removeClass("slick-current");
			    	$w_item.eq(n).addClass("slick-current");
			    	dealDate();
			    });

	            //딜 날짜별 상품 노출
				for(var i = 0; i < cnt; i++){
					if($("#ul_btn"+i+" li a").hasClass("btn_buy_soldout")){
						$('#event02 .deal_slide').slick('slickGoTo', i+1, true);
					}else{
						break;
					}
				}

	            if(app != 'Y'){
					var deal_btn = $('#deal_btn a');
					
					$('#only_mweb').show();
					deal_btn.text('구매하기');
					deal_btn.removeAttr('onclick');
					deal_btn.attr('onclick',"$('.lay_only_mw').show();");
				}else{
					//앱 전용 이미지
//	 				$('.dealwrap h2').css({ 'text-align': 'center'
//	 									  , 'height': '220px','background': 'url(http://img.enuri.info/images/event/2020/new_semester/m_deal_tit2.png) 50% 0%'
//	 									  , 'background-repeat':'no-repeat'
//	 									  , 'background-size': '320px'});

//	 				$('.dealwrap h2 .tit_date').css({ 'padding-top': '75px'});
				}
	            if(tab == '05'){
	    			$('html, body').stop().animate({scrollTop: Math.ceil($('.event_05').offset().top- $(".navtab").outerHeight())}, 0);
	    		}
			}
		});
		var vOs_type = getOsType();
		$("#event2_join").click(function(e){
			ga_log(12);//ga 부분
			if(app != 'Y'){
				$('.lay_only_mw').show();
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
		

	});
	function dealDate(){
		var $txt_month = $('#event02 .contents .tit_date .txt_month');
		var $txt_day = $('#event02 .contents .tit_date .txt_day');
		var dealDate = new Array();

		dealDate = $('.w_item.slick-current .period #date').text().split('/');
		$txt_month.text(dealDate[0]);
		$txt_day.text(dealDate[1]);
	}

	
	function Share_detail(param){
		var share_url = "http://m.enuri.com/mobilefirst/event2020/winter_2020_deal.jsp?oc=sns";
		var share_title = "[2020년 월동 타임딜 이벤트]";
		var share_description = event_share_description;
		var imgSNS = "http://storage.enuri.info"+event_share_img;

		if(!islogin()){
			alert("로그인 후 이용 가능합니다.");
			goLogin();
			return false;
		}else{
			// 메타태그 수정
			$("#meta_og_url").attr("content",share_url);
			$("#meta_og_title").attr("content",share_title);
			$("#meta_og_description").attr("content",share_description);
			$("#meta_og_image").attr("content",imgSNS);

			// sns 공유하기 함수 호출
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
						container: '#kakao-link-btn',
						objectType: 'feed',
						content: {
							title: share_title,
							imageUrl: imgSNS,
							imageWidth : 380,
							imageHeight : 198,
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
			}

			// 공유하기 이벤트 참여자 insert
			sharePaticipant(param);

			// 메타태그 원래대로 수정
			$("#meta_og_url").attr("content","http://m.enuri.com/mobilefirst/event2020/winter_2020_deal.jsp");
			$("#meta_og_title").attr("content","[에누리 가격비교] 월동에누리다!");
			$("#meta_og_description").attr("content","매주 수요일 타임특가도 만나보세요!");
			$("#meta_og_image").attr("content","<%=strFb_img%>");

		}
	}


	// 공유하기 이벤트 참여자
	function sharePaticipant(Type){
		var shareType = 0;
		var osType = "";

		if(Type == "face"){
			shareType = 1;
		}else if(Type == "kakao"){
			shareType = 2;
		}else if(Type == "url"){
			shareType = 3;
		}

		if(app =='Y'){
	        osType = "MA";
	    }else {
	    	osType = "MW";
	    }

		$.ajax({
			  url : "/mobilefirst/evt/ajax/ajax_share_evt.jsp"
			, data : {	procCode  : 2,
						shareType : shareType,
						osType    : osType	 }
			, dataType : "json"
			, success : function(result){
				if(!result){
					alert('공유하기 이벤트 참여 실패하였습니다.');
				}
			}

		});

	}


var isClick = true;
var sdt = "<%=strToday%>";
function getEventAjaxData(params, callback){
	/* if(sdt < "20201026"){
		alert('오픈예정입니다.');
		return false;
	}
	if(sdt > "20201124"){
		alert('이벤트가 종료되었습니다.');
		return false;
	} */
	
	if(!islogin()){
		alert("로그인 후 이용 가능합니다.");
		goLogin()();
		return false;
	}else{
		
		if(!getSnsCheck()){
			
			if (confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?") == true){    
				location.href="<%=ConfigManager.ENURI_COM_SSL%>/mobilefirst/member/myAuth.jsp?cmdType=modify&f=p";
			}else{
				return false;
			}
		}else{
			var evtUrl = "/mobilefirst/evt/ajax/winter2020_setlist.jsp";
			
			if(typeof params === "object") {
				params.sdt = sdt;
				params.osType = "PC";
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
</script>
</body>
</html>
