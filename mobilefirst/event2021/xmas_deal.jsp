<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%@ include file="/event/common/include/event_common.jsp" %>
<%
String strServerNm = request.getServerName();
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
       || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
       || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
       || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
	response.sendRedirect("/event2021/xmas_deal.jsp"); //PC경로
    return;
}

SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMddHHmm");  //오늘 날짜
String strToday = formatter.format(new Date());
String chkId   = ChkNull.chkStr(request.getParameter("chk_id"),"");
String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String userNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK"),"");
String oc = ChkNull.chkStr(request.getParameter("oc"));
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

String strApp = ChkNull.chkStr(request.getParameter("app"),"");

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
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<meta property="og:title" content="2021 크리스마스 통합기획전 – 최저가 쇼핑은 에누리">
	<meta property="og:description" content="온 가족 타임특가! 매주 수요일마다 터지는 득템의 기회!">
	<meta property="og:image" content="http://img.enuri.info/images/event/2021/xmas_pro/xmas_sns_1200_630.jpg">
	<meta name="format-detection" content="telephone=no" />
	<title>2021 크리스마스 통합기획전 – 최저가 쇼핑은 에누리</title>
	<link rel="stylesheet" type="text/css" href="/css/slick.css">
	<!-- 프로모션 공통 CSS (Mobile) -->
	<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
	<!-- 프로모션별 커스텀 CSS  -->
	<link rel="stylesheet" href="/css/event/y2021_rev/xmas_pro_m.css" type="text/css">
	<script type="text/javascript" src="/common/js/lib/jquery-1.9.1.min.js"></script>
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
		var vOc = "<%=oc%>";
		var vPop;
	  </script>
</head>
<body>
<div class="lay_only_mw" <%if(!strApp.equals("Y") && oc.equals("sns")){%><%}else{%>style="display:none;"<%} %>>>
	<div class="lay_inner"> 
		<div class="lay_head">
			더 다양한 <em>이벤트 혜택</em>을 누리고 싶다면?
		</div>
		<!-- 버튼 : 에누리앱으로 보기 -->
		<button class="btn_go_app" onclick="ga_log(35);view_moapp();">에누리앱으로 보기</button>
		<!-- 버튼 : 모바일웹으로 보기 -->
		<a href="javascript:void(0);" class="btn_keep_mw" onclick="ga_log(36);$('.lay_only_mw').fadeOut(100);">괜찮아요. 모바일 웹으로 볼래요</a>
	</div>
</div>

<div class="wrap">
		<div class="event_wrap">
		<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp" %>
		
		<!-- 플로팅 배너 - 둥둥이 -->
		<div id="floating_bnr" class="floating_bnr">
			<a href="javascript:;"  id='float_btn'><img src="//img.enuri.info/images/event/2021/xmas_pro/m_fl_bnr.png" alt="크리스마스 준비하고 서가앤쿡 외식!"></a>
			<!-- 닫기 -->
			<a href="#" class="btn_close" onclick="onoff('floating_bnr');return false;">
				<span class="blind">닫기</span>
			</a>
		</div>
		<!-- visual -->
		<div class="section visual">
			<div class="visual_obj_list">
				<div class="visual_obj obj_hang1"></div>
				<div class="visual_obj obj_hang2"></div>
				<div class="visual_obj obj_hang3"></div>
				<div class="visual_obj obj_hang4"></div>
				<div class="visual_obj obj_hang5"></div>
				<div class="visual_obj obj_hang6"></div>
				<div class="visual_obj obj_bg1"></div>
				<div class="visual_obj obj_bg2"></div>
				<div class="visual_obj obj_bg3"></div>
				<div class="visual_obj obj_bg4"></div>
				<div class="visual_obj obj_bg5"></div>
			</div>
			<div class="inner">
				<!-- 200330 추가 : 공통 : 공유하기 버튼  -->
				<button class="com__btn_share btn_white" onclick="$('.com__share_wrap').show();">공유하기</button>
				<!-- // -->
				<div class="react_text_area">
					<span class="txt_01">Merri Christmas</span>
					<span class="txt_02"><span>성탄절</span>에-누리다</span>
					<span class="txt_date">2021.12.6 ~ 2021.12.31</span>
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
					<li onclick="ga_log(2);"><a href="/mobilefirst/event2021/xmas_evt.jsp" class="">산타 도와주면<em>유자차 당첨!</em></a></li>
					<li onclick="ga_log(3);"><a href="javascript:;" class="active">매주 수요일<em>타임특가</em></a></li>
					<li onclick="ga_log(4);"><a href="/mobilefirst/event2021/xmas_goods.jsp" class="">메리크리스마스<em>준비템</em></a></li>
				</ul>
			</div>
		</div>
		<!-- /탭 -->

		<!-- 이벤트02 -->
		<div class="section event_02" id="event02">
			<i class="ico_only_app"></i>
			<div class="inner">
				<h3>
					<span class="tit_txt_01">매주 수요일 오후 2시 OPEN</span>
					<span class="tit_date"  id="htit">
						<span class="txt_month">10</span>
						<span class="txt_day">27</span>
						<span class="txt_sale"><em class="xmas_red">크</em><em class="xmas_green">리</em><em class="xmas_red">스</em><em class="xmas_green">마</em><em class="xmas_red">스</em> 타임특가</span>
					</span>
				</h3> 
				<div class="dealwrap">
					<div class="deal_slide">
					</div> 
					<!-- //딜 구매영역 -->
				</div>

				<!-- 딜 리스트영역 -->
				<div class="deal_list">
					<h3 class="blind">nextweek</h3>
					<div class="contents">
						<div class="deal_nav">
						</div>
					</div>
				</div>
			</div>
			<div class="area_noti">
				<button class="btn_caution btn__evt_on_slide" data-laypop-id="layPop1">꼭! 확인하세요</button>
			</div>
			<!--// 딜 리스트영역 -->
		</div>
		<!-- // 이벤트02 -->
		<!-- 이벤트02 유의사항 -->
		<div id="layPop1" class="evt_slide">
			<div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
				<div class="evt_slide--head">유의사항</div>
				<div class="evt_slide--cont">
					<div class="evt_slide--continner">
						<ul class="list_dot list">
							<li>본인인증이 완료된 ID로만 참여가능합니다.</li>
							<li>시즌기획전 타임딜 상품의 주문/배송/환불/보증 책임은 해당 쇼핑몰의 판매자에게 있습니다.</li>
							<li>타임특가는 에누리 및 인터파크 ID 1개 당 1번만 구매 가능하며, 부정적인 방법으로 동일 상품을 1번 이상 구매한 경우  
								결제완료 한 경우라도 모든 구매 및 결제가 취소처리 됩니다.</li>
							<li>본 이벤트는 당사에 사정에 따라 사전고지 없이 변경 또는 조기종료 될 수 있습니다.</li>
							<li>시즌기획전 타임딜은 선착순 한정수량 판매로 결제 진행 중 상품이 품절될 경우 판매가 종료될 수 있습니다.</li>
							<li>에누리 모바일 APP에서만 구매가능하며, 이 외 다른 환경(인터파크 APP 등)에서 구매시도하여 발생되는 문제에 대해서는    
							책임 및 보상이 이루어지지 않습니다.</li>
						</ul>
					</div>
				</div>
				<div class="evt_notice--foot">
					<button class="btn__evt_off_slide">확인</button> <!-- 닫기 : 레이어 닫기 -->
				</div>
			</div>
			<div class="evt_notice--dimmed"></div> <!-- 닫기 : 레이어 외부 클릭 -->
		</div>
		<!-- // 이벤트02 유의사항 -->

		<!-- 이벤트03 -->
		<div class="section event_03" id="evt3">
			<i class="ico_only_app"></i>
			<div class="inner">
				<h3><img src="http://img.enuri.info/images/event/2021/xmas_pro/m_evt3_tit.png" width="320" alt="에누리 APP에서 크리스마스 준비하면 서가앤쿡 외식상품권 당첨! 많이 구매할수록 당첨 확률 UP! UP!"></h3>

				<div class="evt_area">
					<div class="prize_img">
						<img src="http://img.enuri.info/images/event/2021/xmas_pro/m_evt3_img.png" alt="[서가앤쿡] 스테이크한상교환권 (32,800점), [투썸플레이스] 리얼생크림2호 (29,000점), [스타벅스] 카페아메리카노 (4,100점)">
					</div>
					<div class="btn_area">
						<!-- #세번째페이지로 이동 : 기획전 보러가기-->
						<a href="/mobilefirst/event2021/xmas_goods.jsp" class="btn btn_ready" onclick="ga_log(12);">성탄절 준비하기</a>
						<%if(strApp.equals("Y")){%>
						<a href="javascript:void(0);" id="event2_join" class="btn btn_goapp" onclick="ga_log(13);">응모하기</a>
						<%}else{%>
						<a href="javascript:void(0);" onclick="viewSms(2);$('#app_only').show();" class="btn btn_goapp">응모하기</a>
						<%}%>
					</div>
				</div>
			</div>
			<div class="area_noti">
				<button class="btn_caution btn__evt_on_slide" data-laypop-id="layPop2">꼭! 확인하세요</button>
			</div>
		</div>
		<!-- // 이벤트03 -->
		<!-- 이벤트03 유의사항 -->
		<div id="layPop2" class="evt_slide">
			<div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
				<div class="evt_slide--head">유의사항</div>
				<div class="evt_slide--cont">
					<div class="evt_slide--continner">
						<div class="popup_inner_tit">이벤트 기간 및 혜택</div>
						<ul class="list_dot mb20">
							<li>이벤트 기간 : 2021년 12월 6일(월) ~ 2021년 12월 31일(금)</li>
							<li>당첨자 발표 및 적립 : 2022년 2월 14일(월)</li>
						</ul>
						<div class="popup_inner_tit">경품</div>
						<ul class="list_dot mb20">
							<li>1등 – 서가앤쿡 스테이크 한상 교환권 (e 32,800점) – 5명 추첨</li>
							<li>2등 – 투썸플레이스 리얼 생크림 2호 (e 29,000점) - 10명 추첨</li>
							<li>3등 – 스타벅스 카페아메리카노 Tall (e 4,100점) – 50명 추첨</li>
						</ul>
						<ul class="list_dot mb20">
							<li class="bold"><span class="color-red">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span><br>
								※ 적립된 e머니는 1,000여가지 인기 e쿠폰으로 교환 가능합니다.
							</li>
						</ul>

						<div class="popup_inner_tit">이벤트 유의사항</div>
						<ul class="list_dot mb20">
							<li>본 이벤트는 ID당 1회 참여 가능합니다.</li>
							<li>이벤트 참여 시 개인정보 수집에 동의하신 것으로 간주됩니다.</li>
							<li>이벤트의 원활한 진행을 위해 당첨자의 참여일시, 참여자ID, 본인인증확인(CI, DI)가 수집되며 수집된 개인정보는 이벤트 참여확인을 위한 본인확인 이외의 목적으로 활용되지 않습니다.</li>
							<li>개인정보 수집자(에누리 가격비교)는 이벤트 기간 동안 개인정보를 수집하며, 이벤트 당첨자 발표 후 개인정보를 즉시 파기합니다.</li>
							<li>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</li>
							<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
							<li>동일한 기간의 vip맞춤적립 및 트리플적립 혜택을 받은 경우 당첨에서 제외됩니다.</li>
						</ul>
		
						<div class="popup_inner_tit">구매 적립 기준 및 유의사항</div>
						<ul class="list_dot mb20">
							<li>적립 방법 : 에누리 가격비교 모바일 앱 로그인 → 적립대상 쇼핑몰 이동 → <span class="color-red">1천원 이상 구매</span> → 구매확정(배송완료) 시 e머니 적립</li>
							<li>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, Cjmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 에누리 해외직구관, SK스토아, 홈플러스<br>
								<span class="color-red">※ 티몬 및 에누리 해외직구관의 경우 PC 및 모바일 앱/웹에서 로그인 후 구매시에도 구매적립 가능합니다.</span></li>
							<li>구매적립 e머니는 구매일로부터 10 ~ 30일간 취소/환불/교환/반품여부 확인 후 적립 됩니다.</li>
							<li><span class="color-red">구매적립 e머니 유효기간 : 적립일로부터 60일 (유효기간 만료 후 재적립 불가)</span><br>
								※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</li>
							<li>구매적립 e머니는 최소 10점(구매금액 1천원 이상)부터 적립되며, 1원 단위 e머니는 적립되지 않습니다.</li>
							<li>구매적립 e머니는 구매확정(구매일로부터 최대 30일) 시점부터 MY 에누리 적립내역 페이지에서 확인 가능합니다.</li>
							<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다. </li>
							<li>적립대상 쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제하는 경우 구매건수는 1건이며 구매금액은 통합된 금액으로 e머니 적립 됩니다.</li>
							<li>구매적립 e머니는 카테고리별 차등 적립됩니다. </li>
						</ul>

						<div class="popup_inner_tit">※ 카테고리별 구매적립률 상세</div>
						<table class="popup_inner_table mb20">
							<colgroup></colgroup>
							<tbody>
								<tr><th>카테고리</th><th>적립률</th></tr>
								<tr><td>유아,완구</td><td>1.5%</td></tr>
								<tr><td>식품/스포츠,레저/자동차/화장품</td><td>1.0%</td></tr>
								<tr><td>컴퓨터/도서/문구,사무/PC부품</td><td>0.8%</td></tr>
								<tr><td>디지털/영상,디카</td><td rowspan="4">0.3%</td></tr>
								<tr><td>가전(생활,주방,계절)</td></tr>
								<tr><td>패션/잡화</td></tr>
								<tr><td>가구,인테리어</td></tr>
								<tr><td>생활,취미</td><td>0.2%</td></tr>
							</tbody>
						</table>
						
						<div class="popup_inner_tit">적립 대상 쇼핑몰 중 구매 적립 제외 카테고리 및 서비스</div>
						<ul class="list_dot mb20">
							<li>에누리 가격비교에서 검색되지 않는 상품</li>
							<li>모바일쿠폰,상품권 : 상품권, 지역쿠폰, e교환권, e쿠폰 등 </li>
							<li>쇼핑몰 제휴 서비스(배달, 티켓, 해외직구 등) 및 일부 카테고리
								<ul class="list_hyphen">
									<li>G마켓 : 중고장터, 실시간 여행, 항공권, 도서/음반, 모바일쿠폰/상품권(일부 적립가능)</li>
									<li>옥션 : 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권(일부 적립가능)</li>
									<li>11번가 : 여행/숙박/항공, 모바일쿠폰/상품권</li>
									<li>인터파크 : 라이프 서비스(티켓, 투어, 아이마켓 등), 모바일쿠폰/상품권(일부 적립가능) </li>
									<li>티몬 : 특가 판매 상품(슈퍼꿀딜, 슈퍼마트 등), 모바일쿠폰/상품권</li>
									<li>위메프 : 모바일쿠폰/상품권</li>
									<li>GS SHOP, Cjmall : 모바일쿠폰/상품권</li>
									<li>SSG : 도서/음반/문구/취미/여행, 모바일쿠폰/상품권</li>
								</ul>
							</li>
						</ul>
						<div class="popup_inner_tit">공통 구매 유의사항</div>
						<ul class="list_dot mb20">
							<li><span class="bold">아래의 경우에는 구매 확인 및 구매 적립이 불가합니다.</span>
								<ul class="list_hyphen">
									<li>에누리 가격비교 모바일 앱이 아닌 다른 모바일 앱을 통해서 장바구니 또는 관심 상품 등록 후 에누리 가격비교 모바일 앱으로 결제만 한 경우</li>
									<li>에누리 가격비교 미 로그인 후 구매한 경우</li>
									<li>에누리 가격비교 PC 및 모바일 웹에서 구매한 경우<br>(※ 티몬 및 에누리 해외직구관은 PC 및 모바일 앱/웹 구매 시에도 가능)</li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
				<div class="evt_notice--foot">
					<button class="btn__evt_off_slide">확인</button> <!-- 닫기 : 레이어 닫기 -->
				</div>
			</div>
			<div class="evt_notice--dimmed"></div> <!-- 닫기 : 레이어 외부 클릭 -->
		</div>
		<!-- // 이벤트03 유의사항 -->


		<!-- 에누리 혜택 -->
		<div class="otherbene">
			<div class="contents">
				<h3><img src="http://img.enuri.info/images/event/2021/winter_pro/m_benefit_tit.png" alt="놓칠 수  없는 특별한 혜택, 에누리 혜택"></h3>
				<ul class="banlist" onclick="ga_log(8);">
					<li>
						<a href="http://m.enuri.com/m/event/welcome.jsp" target="_blank" title="새창으로 이동">
							<div class="tx1">첫 구매 고객이라면!</div>
							<div class="tx2">50% 웰컴 페이백</div>
							<div class="comm_btn"><img src="//img.enuri.info/images/event/2021/winter_pro/m_other_btn_white.png"></div>
						</a>
					</li>
					<li>
						<a href="http://m.enuri.com/m/event/visit.jsp?oc=#evt1" target="_blank" title="새창으로 이동">
							<div class="tx1">100% 당첨! 매일받는 e머니</div>
							<div class="tx2">도전! 프로출첵러</div>
							<div class="comm_btn"><img src="//img.enuri.info/images/event/2021/winter_pro/m_other_btn_white.png"></div>
						</a>
					</li>
					<li>
						<a href="http://m.enuri.com/m/event/buy_stamp.jsp#tab4" target="_blank" title="새창으로 이동">
							<div class="tx1">받고 또 받고</div>
							<div class="tx2">추가 적립 5만점</div>
							<div class="comm_btn"><img src="//img.enuri.info/images/event/2021/winter_pro/m_other_btn_white.png"></div>
						</a>
					</li>
					<li>
						<a href="http://m.enuri.com/m/index.jsp#evt" target="_blank" title="새창으로 이동">
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
					</ul>
					<!-- 메인보내기 버튼클릭시 .mail_on 추가해 주세요 -->
					<div class="btn_wrap">
						<div class="btn_group">
							<!-- 주소복사하기 -->
							<div class="btn_item">
								<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2021/xmas_deal.jsp?oc=sns</span>
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
	<div class="layerwrap">
		<!-- 모바일웹 공통 : 모바일 앱 전용 이벤트  -->
		<div class="layer_back" id="app_only" style="display:none;">
			<div class="appLayer">
				<h4>모바일 앱 전용 이벤트</h4>
				<a href="javascript:///" class="close" onclick="hideSms();$('#app_only').hide();">창닫기</a>
				<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
				<p class="btn_close"><button type="button" onclick="view_moapp();">설치하기</button></p>
			</div>
		</div> 
	</div>
	<!--<a href="#top" class="btn_top"><i>TOP</i></a>-->
	<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20190611"></script>
	<script type="text/javascript" src="/mobilefirst/event/js/exhibition_m.js"></script>
	<script>
	var event_share_description = "";
	var event_share_img  = "";
	var cnt = 0;
	var $navHgt = 0;
	var app = getCookie("appYN"); //app인지 여부
	var makeHtml = "";
	var vServerNm = '<%=strServerNm%>';
	var dealSlide = 0;
	
	var share_url = "http://m.enuri.com/mobilefirst/event2021/xmas_deal.jsp?oc=sns";
	var share_title = "[에누리 가격비교] 메리크리스마스 혜택을 누리다!";
	var share_description = "매주 수요일 타임특가 놓치지 마세요!";
	var imgSNS = "http://img.enuri.info/images/event/2021/xmas_pro/xmas_sns_1200_630.jpg";
	
	var vEvent_title = "21년 크리스마스 기획전";
	var gaLabel = [  vEvent_title+"_PV"
			,vEvent_title+"_단순참여 이벤트"
			,vEvent_title+"_타임딜"
			,vEvent_title+"_기획전"
			,vEvent_title+"_상단플로팅배너"
			,vEvent_title+"_참여이벤트_참여"
			,vEvent_title+"_참여이벤트_공유하기"
			,vEvent_title+"_혜택배너"
			,vEvent_title+"_타임딜_상품보기"
			,vEvent_title+"_타임딜_APP구매하기"
			,vEvent_title+"_타임딜_썸네일"
			,vEvent_title+"_구매이벤트_기획전이동"
			,vEvent_title+"_구매이벤트_참여"
			,vEvent_title+"_어린이를 위한 선물_컴퓨터/게임기"
			,vEvent_title+"_어린이를 위한 선물_장난감"
			,vEvent_title+"_어린이를 위한 선물_겨울의류"
			,vEvent_title+"_어린이를 위한 선물_상품클릭"
			,vEvent_title+"_어린이를 위한 선물_상품더보기"
			,vEvent_title+"_애정을 담은 선물_쥬얼리/향수"
			,vEvent_title+"_애정을 담은 선물_패션잡화"
			,vEvent_title+"_애정을 담은 선물_효도가전"
			,vEvent_title+"_애정을 담은 선물_상품클릭"
			,vEvent_title+"_애정을 담은 선물_상품더보기"
			,vEvent_title+"_나홀로 집에 아이템_빔프로젝트"
			,vEvent_title+"_나홀로 집에 아이템_밀키트/E쿠폰"
			,vEvent_title+"_나홀로 집에 아이템_홈테리어"
			,vEvent_title+"_나홀로 집에 아이템_상품클릭"
			,vEvent_title+"_나홀로 집에 아이템_상품더보기"
			,vEvent_title+"_신년준비 필수템_달력/다이어리"
			,vEvent_title+"_신년준비 필수템_건강식품"
			,vEvent_title+"_신년준비 필수템_위생용품"
			,vEvent_title+"_신년준비 필수템_상품클릭"
			,vEvent_title+"_신년준비 필수템_상품더보기"
			,"크리스마스시즌_탭2공유하기_앱설치 팝업_PV"
			,"크리스마스시즌_탭2공유하기_앱설치 팝업_APP설치"
			,"크리스마스시즌_탭2공유하기_앱설치 팝업_닫기"
			,"크리스마스시즌_APP에서구매하기_앱설치 팝업_PV"
			,"크리스마스시즌_APP에서구매하기_앱설치 팝업_APP설치"
			,"크리스마스시즌_APP에서구매하기_앱설치 팝업_닫기"
			,"크리스마스시즌_APP에서응모하기_앱설치 팝업_PV"
			,"크리스마스시즌_APP에서응모하기_앱설치 팝업_APP설치"
			,"크리스마스시즌_APP에서응모하기_앱설치 팝업_닫기"
	];
	$(document).ready(function(){
		//ga > pageview
		
		$("#float_btn").click(function(){
			ga_log(5);
			$('html, body').stop().animate({scrollTop: Math.ceil($('.event_03').offset().top - $(".floattab").outerHeight())}, 0);
		});

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
		
		//딜 상품
		$.ajax({ 
			  url: "/mobilefirst/http/json/exh_deal_list_2021120122.json"
			, dataType : "json"
			, cache    : false
			, success  : function(data){
				var vCur_dtm = "<%=strToday%>";
					var dealItem = "";
					var dealList = "";
					var dealStatus = "";
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
		        	    dealItem += "<div class=\"deal_img\">";
		        	    dealItem += "	<img src=\"http://storage.enuri.info/Web_Storage"+v.GD_IMG_URL+"\" />";
		        	    dealItem += "	<span class=\"ico_limit\">";
		        	    dealItem += "		<strong>"+v.GD_DC_RT+"%</strong>";
		        	    dealItem += "		<span class=\"txt_limit\">선착순 "+v.GD_QTY+"개</span>";
		        	    dealItem += "	</span>";
		        	    dealItem += "</div>";
		        	    dealItem += "<div class=\"item_info\">";
		        	    dealItem += "	<div class=\"inner\">";
		        	    dealItem += "		<p class=\"tit\">"+v.GD_MODEL_NM1+"&nbsp"+v.GD_MODEL_NM2+"</p>";
						dealItem += "		<p class=\"price\"><strong>"+commaNum(v.GD_DC_PRC)+"</strong>원</p>";
						dealItem += "	</div>";
						dealItem += "</div>";
						dealItem += "<div class=\"btn_area clearfix\"  id=\"ul_btn"+i+"\">";
						dealItem += "	<a href=\"/m/vip.jsp?modelno="+v.GD_MODEL_NO+"&freetoken=vip\" target=\"_blank\" class=\"deal_btn btn_view\" onclick=\"ga_log(9);\">상품보기</a>";
						if( app != "Y" ){
							if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT > vCur_dtm) { //판매 전
								dealStatus = "APP에서 구매하기";
							}else if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT <= vCur_dtm && v.GD_SAL_E_DTM_CVT >= vCur_dtm){ //판매 중
								dealStatus = "APP에서 구매하기";
							}else{ // 판매 종료
								dealSlide = i+1;
								dealStatus = "SOLD OUT"; 
							}
							dealItem += "	<a href=\"javascript:void(0);\" onclick=\"viewSms(1);$('#app_only').show();ga_log(10);\" class=\"deal_btn btn_goapp\" >"+dealStatus+"</a>";
						}else{ 
							if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT > vCur_dtm) { //판매 전
								dealItem += "	<a href=\"javascript:void(0);\" class=\"deal_btn btn_goapp\" onclick=\"ga_log(10);\">판매예정</a>";
							}else if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT <= vCur_dtm && v.GD_SAL_E_DTM_CVT >= vCur_dtm){ //판매 중
								dealItem += "	<a href=\"javascript:void(0);\" class=\"deal_btn btn_goapp\"  onclick=\"ga_log(10);fnDeal("+v.EXH_DEAL_NO+",'2021120122'); return false;\">구매하기</a>";
							}else{ // 판매 종료
								dealSlide = i+1;
								dealItem += "	<a href=\"javascript:void(0);\" class=\"deal_btn btn_goapp btn_buy_soldout\" onclick=\"ga_log(10);\">SOLD OUT</a>";
							}
						} 
						dealItem += "</div>";
						dealItem += "<p class=\"ad\">※ 쿠폰적용 필수 / ID당 1회 구매가능 / 무료배송 <span class=\"mark\"><img src=\"http://img.enuri.info/images/event/2021/summer_pro/ico_interpark.png\" alt=\"인터파크\" width=\"40px\"></span></p>";
						dealItem += "</div>";
					
					
						dealList += "<div class=\"w_item\" onclick=\"ga_log(11);\">";
						dealList += "<div class=\"w_thumb\">";
						dealList += "	<div class=\"w_thumb_img\" style=\"background-image:url('http://storage.enuri.info/Web_Storage"+v.GD_IMG_URL+"');\"></div>";
						dealList += "</div>";
						dealList += "<div class=\"period\">";
						dealList += "	<span id=\"date\">"+month+"/"+day+"</span><span>("+getWeek(v.GD_SAL_S_DTM_CVT)+") 14:00</span>";
						dealList += "</div>";
						dealList += "<span class=\"w_tit\">"+v.GD_MODEL_NM1+"<br>"+v.GD_MODEL_NM2+"</span>";
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
						slidesToShow: 2,
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

					$('#event02 .deal_slide').slick('slickGoTo', dealSlide, true);
		           
					if(app != 'Y'){
						var deal_btn = $('#deal_btn a');
						
						$('#only_mweb').show();
						deal_btn.text('구매하기');
						deal_btn.removeAttr('onclick');
						deal_btn.attr('onclick',"$('.lay_only_mw').show();");
						$('.btn_go_app').attr("dealType", "01");
					}else{

					}
					if(tab == '05'){
		    			$('html, body').stop().animate({scrollTop: Math.ceil($('#event05').offset().top- $(".navtab").outerHeight())}, 0);
		    		} 
				    if(tab == '03'){
				    	$('html, body').stop().animate({scrollTop: Math.ceil($('.event_03').offset().top - $(".floattab").outerHeight())}, 0);
			    	} 		
				}
			});
		
			var vOs_type = getOsType();
		
			$("#event2_join").click(function(e){
				if(app != 'Y'){
					$('.btn_go_app').attr("dealType", $(this).attr("tabType"));
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
					    	 alert("참여완료! 당첨자 발표일을 기다려주세요~");
					         return false;
					    }
					});
				}
				return false;
			});
			

		});
	
	function viewSms(param){
		vOc = param;
		if(vOc == 1){
			ga_log(37);
		}else if(vOc == 2){
			ga_log(40);
		}
	}
	
	function dealDate(){
		var $txt_month = $('#htit .txt_month');
		var $txt_day = $('#htit .txt_day');
		var dealDate = new Array();

		dealDate = $('.w_item.slick-current .period #date').text().split('/');
		//$txt_month.html('<span class="txt_month">'+dealDate[0]+'</span> <span class="txt_day"> '+dealDate[1]+'</span> <span class="txt_sale">무더위 타임특가</span>');
		$txt_month.html(dealDate[0]);
		$txt_day.html(dealDate[1]);
	}
		
	var isClick = true;
	var sdt = "<%=strToday%>";
	var numSdt = parseInt(sdt.substring(0,8));
	function getEventAjaxData(params, callback){
		if(numSdt < 20211206){
			alert('오픈예정입니다.');
			return false;
		}
		if(numSdt > 20220101){
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
					//location.href="<%=ConfigManager.ENURI_COM_SSL%>/mobilefirst/member/myAuth.jsp?cmdType=modify&f=p";
					location.href= "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
				}else{  
					return false;  
				} 
			}else{
				var evtUrl = "/mobilefirst/evt/ajax/xmas2021_setlist.jsp";
				//mobilefirst/evt/ajax/xmas2021_setlist.jsp?procCode=2&sdt=20211202&osType=PC
				if(typeof params === "object") {
					params.sdt = sdt;
					params.osType = "MO";
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
		 
		//sns 공유하기 함수
		function shareSns(param){ //수정

			if(param == "face"){
				try{
					window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
				}catch(e){
					window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
				}
			}else if(param == "kakao"){
				imgSNS = "http://img.enuri.info/images/event/2021/xmas_pro/sns_800_800.jpg";
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
				var share_title_twi = "[에누리 가격비교] 메리크리스마스 혜택을 누리다! 매주 수요일 타임특가 놓치지 마세요!";
				window.open("https://twitter.com/intent/tweet?text="+encodeURIComponent(share_title_twi)+"&url="+share_url);
			}
		}

		function view_moapp(){ 
			var chrome25;
			var kitkatWebview;
			var uagentLow = navigator.userAgent.toLocaleLowerCase();
			var openAt = new Date;
			var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2021%2Fxmas_deal.jsp";
			if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
				goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2021/xmas_deal.jsp"; 
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
					location.href = goApp;
				}
				//location.href = "market://details?id=com.enuri.android";
				//location.href = "intent://#Intent;scheme=enuri;package=com.enuri.android;end";
			}else{
				setTimeout( function() { 
					window.open("https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8");
				}, 1000); 
				location.href = goApp;
			}
			
			if(vOc == 1){
				ga_log(38);
			}else if(vOc == 2){
				ga_log(41);
			}
		}	
		function hideSms(){
			if(vOc == 1){
				ga_log(39);
			}else if(vOc == 2){
				ga_log(42);
			}
		}
		ga_log(1);
		<%if(!strApp.equals("Y") && oc.equals("sns")){%>
		ga_log(34);
		<%}%>
	</script>
	<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
	<script type="text/javascript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</div>
</body>
</html>