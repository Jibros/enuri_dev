<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
 if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){

}else{
    response.sendRedirect("/event2020/tmonevt.jsp"); //pc url
    return;
}

long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String sdt = dayTime.format(new Date(cTime));//진짜시간

if( request.getServerName().indexOf("dev.enuri.com") > -1 && request.getParameter("sdt")!=null && !request.getParameter("sdt").equals("") ) {
	sdt = request.getParameter("sdt");
}

String startDate = "20200406";
String endDate="20200506";

String dday = "20200604";	


Calendar cale = Calendar.getInstance();
SimpleDateFormat prevFormat = new SimpleDateFormat("yyyyMMdd");
SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy년 M월 d일");

String[] customDate = new String[2];
try{
	int year  = Integer.parseInt(sdt.substring(0, 4));
	int month = Integer.parseInt(sdt.substring(4, 6));

    //현재날짜의 세달전 날짜의 1일자
    cale.set(year, month - 1, 1);
    cale.add(Calendar.MONTH, -3);
    customDate[0] = dateFormatter.format(cale.getTime());

    //구한 날짜의 하루전 날짜 (말일자)
    cale.add(Calendar.DATE, -1);
    customDate[1] = dateFormatter.format(cale.getTime());

}catch(Exception e){
	System.out.println("컴백혜택 유의사항 문구 자동화변경 오류: "+ e.getMessage());
	customDate[0] = "2017년 12월 1일";
	customDate[1] = "2017년 6월 30일";
}

String cUserId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

Members_Proc members_proc = new Members_Proc();
String cUsername = "";
String userArea = "";

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;

    if(cUsername.equals(""))      userArea = cUserNick;
    if(userArea.equals(""))        userArea = cUserId;
    
}

String tab = ChkNull.chkStr(request.getParameter("tab"));

%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<title>에누리(가격비교) eNuri.com</title>
<META NAME="description" CONTENT="[티몬 구매 이벤트] 구매만 해도? 콜드브루라떼 증정!">
<META NAME="keyword" CONTENT="[티몬 구매 이벤트] 구매만 해도? 콜드브루라떼 증정!">
<meta property="og:title" content="[티몬 구매 이벤트] 구매만 해도? 콜드브루라떼 증정!">
<meta property="og:description" content="[티몬 구매 이벤트] 구매만 해도? 콜드브루라떼 증정!">
<meta property="og:image" content="http://img.enuri.com/images/event/2020/tmon/sns_1200_630.jpg">
<meta name="format-detection" content="telephone=no" />
<!-- 프로모션 공통 CSS (Mobile) -->
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<!-- 프로모션별 커스텀 CSS  -->
<link rel="stylesheet" href="/css/event/y2020/tmon_m.css" type="text/css">
<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/event_regular.js?v=20180201"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script>
</head>
<body>
<script type="text/javascript">
var app = getCookie("appYN"); //app인지 여부
var username = "<%=userArea%>";
var vChkId = "";
</script>
<div id="eventWrap">
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>

	<!-- 플로팅 배너  -->
	<div class="floating_bnr" style="display:none">
		<img src="http://img.enuri.info/images/event/2019/crazyFriday/fl_bnr.png" alt="매일 오전 10시 매일 한정특가">
		<a href="javascript:///" onclick="$('.floating_bnr').hide();return false;" class="btn_close">닫기</a>
	</div>
	<!-- //  플로팅 배너 -->

	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">

		<!-- 상단비주얼 -->		
		<div class="visual">
			<div class="inner">
				<h2 class="blind">
					<small>더 강력해진 e머니 혜택!</small><br/>
					티몬 단독!
				</h2>
				<span class="blind">PC 및 모바일</span>
				<span class="top_txt_02">어디서 구매해도 e머니 적립!</span>				
			</div>
		</div>
	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<!-- 이벤트01 -->
	<div id="evt1" class="section event_01 scroll"><!-- 이벤트 1 앵커 영역 -->
		<div class="evt_box">
			<h3>
				<small>티몬 구매이벤트</small>
				에누리 경유하여 티몬에서 구매하면 이디야커피 콜드브루 라떼 당첨!
			</h3>
			<div class="evt_cnt">
				<div class="evt_area">
					<p class="blind">이디야커피 콜드브루 라떼 100명 추첨 (e머니 4,200점)</p>
					<dl class="blind">
						<dt>당첨TIP</dt>
						<dd>구매금액 높을 수록 당첨확률 up!</dd>
					</dl>
					<a href="javascript:///" class="btn_apply" onclick="btn_apply()">구매 후 응모하기</a>
					<ul class="evt_noti_01">
						<li>이벤트기간 : <%= dateFormatter.format(prevFormat.parse(startDate)) %> ~ <%= dateFormatter.format(prevFormat.parse(endDate)) %></li>
						<li>당첨자 발표일 : <%= dateFormatter.format(prevFormat.parse(dday)) %></li>
						<li>참여방법 : 에누리 로그인 &gt; 티몬 이동 &gt; 구매 후 응모</li>
						<li>이벤트 경품 : 이디야커피 콜드브루 라떼 100명 추첨 </li>
					</ul>
				</div>
			</div>
		</div>
		<div class="caution-wrap">
			<div class="btn_box">
				<a class="btn_notice" href="javascript:///" onclick="onoff('layerNoti1');return false;">유의사항을 꼭! 확인하세요</a>
			</div>
			<div id="layerNoti1" class="moreview" style="display:none">
				<h4>유의사항</h4>
				<div class="txt">
					<strong>이벤트 및 구매기간</strong>
					<ul class="txt_indent">
						<li><%= dateFormatter.format(prevFormat.parse(startDate)) %> ~ <%= dateFormatter.format(prevFormat.parse(endDate)) %></li>
					</ul>
					<strong>이벤트 참여방법 및 유의사항</strong>
					<ul class="txt_indent">
						<li>에누리 로그인 &rarr; 티몬 이동 &rarr; 구매 후 응모 </li>
						<li>본인인증 및 로그인하지 않거나 에누리를 경유하지 않은 경우 적립불가</li>
						<li>티몬 이외의 쇼핑몰에서 구매시 응모 불가</li>
						<li>이벤트 기간 내 1회 응모 가능</li>
					</ul>
					<strong>이벤트 경품</strong>
					<ul class="txt_indent">
						<li>이디야커피 콜드브루 라떼 100명 추첨 (e머니 4,200점)</li>
						<li><span class="stress">e머니 유효기간: 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span></li>
						<li>경품은 e쿠폰으로 교환 가능한 e머니로 적립되며, e쿠폰 스토어에서 교환 가능</li>
						<li class="no_bul">※ 경품은 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격변동이 있을 수 있음</li>
					</ul>
					<strong>당첨자 발표 및 경품지급일</strong>
					<ul class="txt_indent">
						<li>당첨자 발표일: <%= dateFormatter.format(prevFormat.parse(dday)) %></li>
						<li>당첨자 공지: 에누리 앱 &gt; 이벤트/기획전탭 &gt; 이벤트혜택 &gt; 하단 ‘당첨자 발표’에 공지</li>
					</ul>
					<strong>티몬 구매적립기준 및 유의사항</strong>
					<ul class="txt_indent">
						<li>에누리 가격비교 로그인 &rarr; 티몬 이동 &rarr; 구매하기 &rarr; 구매확정(배송완료) 금액이 1,000원 이상 시 e머니 적립</li>
						<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품 결제금액만 반영</li>
						<li>구매 e머니는 구매 확인완료 시점(구매 후 최대 30일)부터 마이 에누리 → 적립내역 페이지에서 확인 가능</li>
						<li>적립제외 카테고리: 슈퍼꿀딜, 슈퍼마트 등 특가 판매 상품, 모바일쿠폰/상품권(일부 상품권 적립가능)</li>
						<li>*특정 상품에 한하여 적립되오니 적립가능 상품은 하단에서 확인해주세요.</li>
						<li>본인인증 PC페이지 이동 → 모바일 본인인증 페이지 이동 </li>
						<li class="no_bul">
							<div class="tb">
								<table>
									<colgroup>
										<col><col>
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
													<td rowspan="2" >0.2%</td>
												</tr>
												<tr>
													<td>모바일쿠폰,상품권<br>
														<p style="font-size:10px;margin-top:4px;color:#e91030">*특정 상품에 한하여 적립되오니<br>적립가능 상품은 하단에서 확인해주세요.</p>
													</td>
												</tr>
											</tbody>
								</table>
							</div>
						</li>
						<li>적립대상 쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제 시 구매건수는 1건이며, 구매금액은 통합 결제한 금액의 e머니 적립</li>
						<li>결제일로부터 10~30일간 취소/반품여부 확인 후 적립</li>
						<li>e머니는 최소 10점부터 적립되며 (구매금액 1,000원 이상), 1원 단위 e머니는 적립되지 않습니다. (예: 1,200원 결제 시 e머니 10점 적립)</li>
						<li>구매적립 e머니 유효기간: 적립일로부터 60일</li>
						<li>적립된 e머니는 e쿠폰 스토어에서 다양한 e쿠폰으로 교환 가능합니다</li>	
					</ul>
					
					<div style="padding:15px 10px 5px">
						<strong>모바일쿠폰, 상품권 적립 상세</strong>
						<ul class="txt_indent">
							<li>적립가능 쇼핑몰 : 티몬, G마켓, 옥션</li>
							<li>적립가능 상품 (0.2% 적립): 문화상품권(해피머니, 컬쳐랜드), 도서상품권, 백화점상품권, 영화예매권, 국민관광 상품권</li>
							<li>적립가능 상품을 제외한 상품권, 지역쿠폰, e교환권, e쿠폰은 적립불가</li>
							<li style="background:none;">
								<strong class="stress">※ 백화점 상품권 적립기준</strong>
								<ul>
									<li>1) 상품명에 '백화점 상품권' 명시된 상품 또는 백화점에서만 사용할 수 있는 상품권만 적립</li>
									<li>2) 복합상품권 적립불가(삼성 상품권/신세계 기프트카드/롯데카드 상품권/이랜드 상품권/AK플라자 상품권/통합 상품권 등)</li>
									<li>3) 복합 상품권의 경우 사용처에 백화점이 기재되어 있는 경우에도 적립불가</li>
									<li>4) 백화점 상품권으로 전환 가능한 포인트 구매시 적립불가</li>
								</ul>
							</li>
						</ul>
						
						<strong>적립대상쇼핑몰 중 e머니 적립 제외 카테고리/서비스 </strong>
						<ul class="txt_indent">
							<li>에누리 가격비교 앱에서 검색되지 않는 상품</li>
							<li>인터파크: 모바일쿠폰/상품권, 라이프 서비스(티켓, 투어, 아이마켓 등)</li>
							<li>11번가: 여행/숙박/항공, 모바일쿠폰/상품권 전체</li>
							<li>G마켓: 중고장터, 실시간 여행, 항공권, 도서/음반, 모바일쿠폰/상품권(일부 상품권 적립가능)</li>
							<li>옥션: 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권(일부 상품권 적립가능)</li>
							<li>SSG: 도서/음반/문구/취미/여행, 모바일쿠폰/상품권 전체</li>
							<li>티몬: 슈퍼꿀딜, 슈퍼마트 등 특가 판매 상품, 모바일쿠폰/상품권(일부 상품권 적립가능)</li>
							<li>위메프: 모바일쿠폰/상품권 전체</li>
							<li>CJ몰/GSSHOP: 모바일쿠폰/상품권 전체</li>
							<li>모바일쿠폰/상품권: 상품권, 지역쿠폰, e교환권, e쿠폰 등 (문화상품권, 도서상품권, 백화점상품권, 영화예매권, 국민관광상품권은 적립 가능)</li>
							<li>이 외 쇼핑몰에 입점한 제휴 서비스(배달, 티켓, 해외직구 등) 및 일부 카테고리 제외</li>
						</ul>	
					</div>		
					<strong>유의사항</strong>
					<ul class="txt_indent">
						<li>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</li>
						<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
					</ul>					
					<a href="javascript:///" onclick="onoff('layerNoti1');return false" class="btn_check_hide">확인</a>
				</div>
			</div>
		</div>
	</div>
	<!-- // 이벤트01 -->

	<!-- 이벤트02 -->
	<div id="evt2" class="section event_02 scroll"> <!-- 이벤트 2 앵커 영역 -->
		<div class="evt_box">
			<h3>티몬 구매하고 e머니 적립받기</h3>
			<div class="evt_cnt">
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<img src="http://img.enuri.info/images/event/2020/tmon/m_slide_01.jpg" alt="STEP1 - 에누리 로그인 후 티몬 이동하기">
						</div>
						<div class="swiper-slide">
							<img src="http://img.enuri.info/images/event/2020/tmon/m_slide_02.jpg" alt="STEP2 - 티몬에서 상품 구매하기">
						</div>
						<div class="swiper-slide">
							<img src="http://img.enuri.info/images/event/2020/tmon/m_slide_03.jpg" alt="STEP3 - 구매금액의 최대 1.5% e머니 적립">
						</div>
						<div class="swiper-slide">
							<img src="http://img.enuri.info/images/event/2020/tmon/m_slide_04.jpg" alt="STEP4 - e쿠폰 스토어에서 1,000여가지의 인기 e쿠폰으로 교환가능!">
						</div>
					</div>
					<div class="swiper-button-prev btn_prev"></div>
					<div class="swiper-button-next btn_next"></div>
				</div>
				<div class="swiper-pagination"></div>
				<script>
					$(function(){
						var mySwiper = new Swiper('.event_02 .swiper-container',{
							prevButton : '.event_02 .swiper-button-prev',
							nextButton : '.event_02 .swiper-button-next',
							loop : true,
							autoplay : 6000,
							speed : 1000,
							pagination : '.event_02 .swiper-pagination',
							paginationClickable : true
						});
					})
				</script>
			</div>
		</div>
	</div>

	<!-- 이벤트3 -->
	<div id="evt3" class="section event_03 scroll">
		<h3>e머니로 쿠폰교환</h3>
		<div class="evt_box">
			<a href="javascript:///" class="btn_go_store">스토어 바로가기</a>
		</div>
	</div>
	
	<!-- //Contents -->	
	<span class="go_top"><a href="javascript:///">TOP</a></span>

<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
</div>
<!-- layer-->
<div class="layer_back fixed" id="app_only" style="display:none;">
    <div class="dimm" onclick="onoff('app_only');"></div>
    <div class="appLayer">
        <h4>모바일 앱 전용 이벤트</h4>
        <a href="javascript:///" class="close" onclick="onoff('app_only');">창닫기</a>
        <p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
        <p class="btn_close"><button type="button"  onclick="install_btt();">설치하기</button></p>
    </div>
</div>

<script type="text/javascript">
var tapType = "<%=tab%>";
var default_src = "<%=ConfigManager.STORAGE_ENURI_COM%>";

var vEvent_title = "20년 티몬이벤트";
var vEvent_page = "";

var tab = "<%=tab%>";

//공통영역//
$(document).ready(function() {

	if(islogin()){
		getPoint();
	}
	//스크롤
	var nav = $('.myarea'); 
	$(window).scroll(function () {
		if ($(this).scrollTop() > $(".event_01").offset().top) {
			nav.addClass("f-nav");
		} else {
			nav.removeClass("f-nav");
		}
	});
	
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1)		mType = "I";
	else if(navigator.userAgent.indexOf("Android") > -1)		mType = "A";

	var url = window.location.href;

    var offset = "";
    if( url.indexOf("evt1") > -1 )        offset = $("#evt1").offset();
    else if( url.indexOf("evt2") > -1 )   offset = $("#evt2").offset();
    
    if(!!offset){
        var $anchor = offset.top;
        $('html, body').stop().animate({scrollTop: $anchor}, 500);
    }
	
	//닫기버튼
	 $( ".win_close" ).click(function(){
        if(app == 'Y')  window.location.href = "close://";
        else            window.location.replace("/mobilefirst/index.jsp");
	});
	
	$(".go_top").click(function(){		$(window).scrollTop(0);	});
	ga('send', 'pageview', {'title': vEvent_title + " > " + "PV"});
	
	$(".btn_go_store").click(function(){
		
		GA("20년 티몬 프로모션_스토어 바로가기");
		
		if(app == 'Y') location.href ="/mobilefirst/emoney/emoney_store.jsp?freetoken=emoney";  
		else alert("e쿠폰 교환은 모바일 APP 및 PC에서만 가능합니다!");
	});
	
});
function btn_apply() {
	
	GA("응모하기");
	
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
				url: "/mobilefirst/evt/ajax/tmon_setlist.jsp?proc=1&osType="+getOsType(),
				dataType: "JSON",
				async : false,
				success: function(json){
					
					if(json.result == 1){
						alert("응모완료! 당첨자 발표일을 기다려주세요");
					}else if(json.result == 2601){
						alert("이미 응모완료 되었습니다!");
					}else if(json.result == -99){
						alert("티몬에서 구매 후 응모 가능합니다.");
					}else if(json.result == 100){
						alert("이벤트가 종료 되었습니다.");
					}
					//onoff('agreeLayer1');
				},
				error: function (xhr, ajaxOptions, thrownError) {
					//alert(xhr.status);
					//alert(thrownError);
				}
			});
			
		}
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


function inner() {
	$('html, body').animate({scrollTop: Math.ceil($('#'+tapType).offset().top-$("#topFix").height())}, 1000);
}
function GA(label){
	ga('send', 'event', 'mf_event', vEvent_title , label );		
}

//앱설치버튼
function install_btt(){
	
	var gkind = "";
	
	ga('send','event', 'mf_event','click',vEvent_title+'_설치하기');
	
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8';
    }else if(navigator.userAgent.indexOf("Android") > -1){
    	if(gkind == "42"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','SA 42 M_Naver');
    		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=8820367';
    	}else if(gkind == "43"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','SA 43 M_Daum');
    		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=9238355';
    	}else if(gkind == "44"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','SA 44 M_google');
    		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=2709994';
    	}else if(gkind=="72"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','DA 72 M_icover');
    		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=9999961&sub_referral=5642519';
    	}else if(gkind=="75" && gno == "3120469"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','버즈빌_첫구매CU');
    		window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=1917629&sub_referral=8147655";
		}else if(gkind=="74" && gno == "3120470"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','페이스북_첫구매CU');
			window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=4120949&sub_referral=2082626";
		}else if(gkind=="71" && gno =="3100367"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','망고_첫구매CU');
    		window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=9999961&sub_referral=1319566";
    	}else if(gkind=="76" && gno =="3139542"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','애드립_첫구매CU');
    		window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=3535287&sub_referral=3457934";
    	}else if(gkind=="82" && gno =="4299545"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','쉘위애드_첫구매');
    		window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6497571&sub_referral=4519572";
    	}else{
    		window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
    	}
    }
}
function commaNum(x) {
	var num;
	try{
		num = x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}catch(e){}
    return num; 
}
//페이지 이동
function XSSfilter (content) {
	return content.replace(/\</g, "&lt;").replace(/\>/g, "&gt;");
}
function welcomeGa(strEvent){
	if(app == "Y"){
		try{
	        if(window.android){            // 안드로이드                  
                 window.android.igaworksEventForApp (strEvent);
	        }else if(/iPhone|iPad|iPod/i.test(navigator.userAgent)){
        		// 아이폰에서 호출
                 location.href = "enuriappcall://igaworksEventForApp?strEvent="+strEvent;
	        }
		}catch(e){}
	}
}
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
</script>
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</body>
</html>