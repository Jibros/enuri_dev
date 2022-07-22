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
	response.sendRedirect("http://www.enuri.com/event2021/newyear_2021_deal.jsp"); //PC경로
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
<!DOCTYPE html> 
<html lang="ko">
<head>
<meta charset="utf-8">	
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
<meta name="keyword" content="에누리가격비교, 통합기획전, 설날, 새해, 명절선물, 신축년">
<meta property="og:title" content="2021 설날 통합기획전 – 최저가 쇼핑은 에누리">
<meta property="og:description" content="100% 당첨 설~프라이즈 이벤트를 만나보세요!">
<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
<meta name="format-detection" content="telephone=no" />
<!-- 프로모션 공통 CSS (Mobile) -->
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<!-- 프로모션별 커스텀 CSS  -->
<link rel="stylesheet" href="/css/event/y2021/newyear_m.css" type="text/css">
<link rel="stylesheet" type="text/css" href="http://m.enuri.com/mobilefirst/css/lib/slick.css"/>
<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
<script type="text/javascript" src="/event2016/js/event_common.js"></script>
<title>에누리 가격비교 - 최저가 쇼핑은 에누리 가격비교 사이트</title>
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
<!--  -->

<div id="eventWrap">
<%@include file="/mobilefirst/event2021/newyear_header.jsp" %>
	
	<!-- T2 이벤트 : 구매이벤트 -->
	<div class="section event_ready" id="evt1">
		<div class="contents">
			<h1><img src="http://img.enuri.info/images/event/2021/newyear/m_tab2_ready_tit.png" alt="앱전용 - APP에서 설날 준비하면 한국금거래소 순금 골드바 당첨! 많이 구매할수록 당첨 확률 UP! UP!"></h1>

			<div class="evt_area">
				<div class="evt_area__inner">
					<div class="blind">
						<ol>
							<li>1등 한국금거래소 순금 골드바 3.75g(실물배송) - 3명 추첨</li>
							<li>2등 신세계 상품권 3만원권 (e 30,000점) - 10명 추첨</li>
							<li>3등 투썸플레이스 흑임자 카페라떼 (e 5,800점) - 50명 추첨</li>
						</ol>				
					</div>
					<a href="/mobilefirst/event2021/newyear_2021.jsp" onclick="ga_log(9);" class="btn_ready"  target="_blank" title="새 창에서 응모하기">응모하기</a>
					<button type="button" id="event2_join" class="btn_apply" onclick="ga_log(10);">응모하기</button>
				</div>
			</div>
		</div>

		<!-- 공통 : 꼭 확인하세요  -->
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop1"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop1" class="evt_notice--slide">
			<div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<dl>								
							<dt>이벤트 대상 및 혜택</dt>
							<dd>
								<ul>
									<li>이벤트/구매 기간 : 2021년 1월 18일 ~ 2021년 2월 14일</li>
									<li>당첨자 발표 및 적립 : 2021년 5월 27일 [APP 이벤트/기획전 탭 &gt; 이벤트 하단 당첨자 발표]</li>
									<li>경품 :
										<ul class="sub">
											<li>1등 – 한국금거래소 순금 골드바 3.75g  - 3명 추첨 <span class="noti stress">※제세공과금 당첨자 부담</span></li>
											<li>2등 – 신세계이마트 30,000원 상품권 교환권 (e 30,000점) - 10명 추첨</li>
											<li>3등 – 아이스 흑임자 카페 라떼 ® (e 5,800점) – 50명 추첨</li>
										</ul>
									</li>
									<li>e머니 유효기간 : 적립일로부터 15일</li>
									<li>사정에 따라 경품이 변경될 수 있습니다.</li>
									<li>이벤트 참여 시 개인정보 수집에 동의하신 것으로 간주됩니다.</li>
									<li>이벤트의 원활한 진행을 위해 당첨자의 참여일시, 참여자ID, 본인인증확인(CI, DI)가 수집되며 수집된 개인정보는 이벤트 참여확인을 위한 본인확인 이외의 목적으로 활용되지 않습니다.</li>
									<li>개인정보 수집자(에누리 가격비교)는 이벤트 기간 동안 개인정보를 수집하며, 이벤트 당첨자 발표 후 개인정보를 즉시 파기합니다.</li>
									<li>잘못된 정보 입력이나, 3회 이상 통화 시도에도 연락이 되지 않을 경우의 경품수령 불이익은 책임지지 않습니다.</li>
									<li>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</li>
									<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다.</li>
									<li>본 이벤트 당첨은 vip맞춤적립 트리플적립 참여 시 혜택 지급이 불가합니다.</li>
								</ul>
							</dd>
						</dl>
						<dl>								
							<dt>구매 적립 기준 및 유의사항</dt>
							<dd>
								<ul>
									<li>적립 방법 : 에누리 가격비교 모바일 앱 로그인 &rarr; 적립대상 쇼핑몰 이동 &rarr; <span class="stress">1천원 이상 구매</span> &rarr; 구매확정(배송완료) 시 e머니 적립</li>
									<li>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 에누리 해외직구관, SK스토아, 홈플러스<br />
										<span class="noti stress">※ 티몬 및 에누리 해외직구관의 경우 PC 및 모바일 앱/웹에서 로그인 후 구매시에도 구매적립 가능합니다.</span>
									</li>
									<li>구매적립 e머니는 구매일로부터 10 ~ 30일간 취소/환불/교환/반품여부 확인 후 적립 됩니다.</li>
									<li class="stress">구매적립 e머니 유효기간 : 적립일로부터 60일 (유효기간 만료 후 재적립 불가)<br />
										<span class="noti gray">※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</span>
									</li>
									<li>구매적립 e머니는 최소 10점(구매금액 1천원 이상)부터 적립되며, 1원 단위 e머니는 적립되지 않습니다.</li>
									<li>구매적립 e머니는 구매확정(구매일로부터 최대 30일) 시점부터 MY 에누리 적립내역 페이지에서 확인 가능합니다.</li>
									<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다.</li>
									<li>적립대상 쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제하는 경우 구매건수는 1건이며 구매금액은 통합된 금액으로 e머니 적립 됩니다.</li>
									<li>구매적립 e머니는 카테고리별 차등 적립됩니다. </li>
								</ul>
							</dd>

							<dt>※ 카테고리별 적립률 상세</dt>
								<dd>
									<table class="evt_noti_tb" style="width:300px;">
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
												<td>모바일쿠폰,상품권<br/>
													<p class="stress">*특정 상품에 한하여 적립되오니<br/>적립가능 상품은 하단에서 확인해주세요.</p>
												</td>	
												<td>0.2%</td>												
											</tr>
										</tbody>
									</table>
								</dd>
							</dl>
							<dl>
								<dt class="stress">[모바일쿠폰,상품권] 구매적립 기준</dt>
								<dd>									
									<ul>
										<li>적립가능 쇼핑몰 : G마켓, 옥션, 인터파크</li>
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
								<dt>공통 구매 유의사항</dt>
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
	<!-- // T2 이벤트 : 구매이벤트 -->

	<!-- 공통 : 하단 에누리 혜택 -->
	<div class="otherbene">
        <div class="inner">
            <h3 class="blind">놓칠 수  없는 특별한 혜택, 에누리 혜택</h3>
            <ul class="ben_list">
                <li class="ben_item--01"><a href="http://www.enuri.com/event2019/first_purchase_2019_evt.jsp?tab=evt1" target="_blank">첫구매 고객이라면! Welcome 혜택</a></li>
                <li class="ben_item--02"><a href="http://www.enuri.com/evt/visit.jsp" target="_blank">하루라도 놓치면 손해 매일100% 당첨</a></li>
                <li class="ben_item--03"><a href="http://m.enuri.com/mobilefirst/evt/smart_benefits.jsp?#tab4" target="_blank">받고 또 받는 카테고리 혜택</a></li>
                <li class="ben_item--04"><a href="http://www.enuri.com/eventPlanZone/jsp/shoppingBenefit.jsp" target="_blank">아직 끝나지 않은 혜택 더 많은 이벤트</a></li>
            </ul>
        </div>
	</div>
	<!-- // -->	
	
	<!-- //Contents -->	

</div>
<!-- // 프로모션 -->

<!-- LAYER WRAP -->
<div class="layerwrap">
	<!-- 공통 : SNS공유하기 -->
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

	<!-- 이벤트5 : 이벤트 응모완료 M APP 전용 -->
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
</div>
<!-- // -->
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
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
		var goApp = "enuri://freetoken/?url=http%3a%2f%2fm.enuri.com%2fmobilefirst%2fevent2021%2fnewyear_2021_deal.jsp%3ffreetoken%3devent";
		if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
			goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2021/newyear_2021_deal.jsp?freetoken=event";
	 		chrome25 = uagentLow.search("chrome") > -1 && navigator.appVersion.match(/Chrome\/\d+.\d+/)[0].split("/")[1] > 25;
			kitkatWebview = uagentLow.indexOf("naver") != -1 || uagentLow.indexOf("daum") != -1; 
			setTimeout( function() {
				if (new Date - openAt < 4000) {
					if (uagentLow.search("android") > -1) {
						location.href = "market://details?id=com. enuri.android";
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

		var vOs_type = getOsType();
		$("#event2_join").click(function(e){
			ga_log(11);//ga 부분
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

				 		 //onoff('completeJoin');
				 		 return false;
				    }
				});
			}
			return false;
		});
		
        if(tab == '01'){
			$('html, body').stop().animate({scrollTop: Math.ceil($('#evt1').offset().top- $(".navtab").outerHeight())}, 0);
		}
        
      //#애드브릭스
		setTimeout(function(){
			welcomeGa("evt_newyear2021 deal_view");
		},500);

	});
	
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

var isClick = true;
var sdt = "<%=strToday%>";
function getEventAjaxData(params, callback){
	
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
		}else{
			var evtUrl = "/mobilefirst/evt/ajax/newyear2021_setlist.jsp";
			
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
</script>
</body>
</html>