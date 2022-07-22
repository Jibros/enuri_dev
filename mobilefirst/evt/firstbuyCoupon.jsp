<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@page import="com.enuri.bean.event.Event_FirstbuyCpn_Proc"%>
<%
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
	response.sendRedirect("http://www.enuri.com/evt/firstbuyCoupon.jsp");
	return;
}

String chkId   = ChkNull.chkStr(request.getParameter("chk_id"),"");
String cUserId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK"),"");

Members_Proc members_proc = new Members_Proc();
String cUsername = members_proc.getUserName(cUserId);
String userArea = cUsername;

long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String sdt =dayTime.format(new Date(cTime));//진짜시간

//test
if( request.getServerName().equals("dev.enuri.com") && request.getParameter("sdt")!=null && !request.getParameter("sdt").equals("")){
    sdt= request.getParameter("sdt");
}

int numSdt = Integer.parseInt(sdt);
boolean isNext = false;
if(numSdt >= 20190101){
	isNext = true;
}

String strUrl = request.getRequestURI();

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;

    if(cUsername.equals("")){
        userArea = cUserNick;
    }
    if(userArea.equals("")){
        userArea = cUserId;
    }
}
String strFb_title = "[에누리 가격비교]";
String strFb_description = "환영합니다~ 앱에서 첫구매라면 지금 혜택 다운!!";
String strFb_img = ConfigManager.IMG_ENURI_COM+"/images/mobilenew/images/enuri_logo_facebook200.gif";
String tab = ChkNull.chkStr(request.getParameter("tab"));

boolean isApply = new Event_FirstbuyCpn_Proc().getIsApply(cUserId);

%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
    <meta property="og:title" content="<%=strFb_title%>">
    <meta property="og:description" content="<%=strFb_description%>">
    <meta property="og:image" content="<%=strFb_img%>">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/buy_coupon_april_m.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/event_regular.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
</head>
<body>
<div id="eventWrap">

	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>

	<!-- 상단비주얼 -->
	<div class="evtop01">
		<div class="top_visual">
			<div class="img_box">
				<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/buy_coupon/april/m_visual.jpg" alt="앱 첫구매 웰컴 쿠폰" />
			</div>
		</div>
	</div>
	<!--// 상단비주얼 -->

	<div class="content">

		<!-- 웰컴쿠폰 -->
		<div id="tab4" class="maxfive_wrap">
			<!-- INNER -->
			<div class="inner">
				<div class="imgbox">
					<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/buy_coupon/april/m_coupon.jpg" alt="웰컴쿠폰" class="imgs" />

					<a class="btn btn_join" href="javascript://" id= "couponChk">지금 쿠폰 받기</a>

					<ul class="info_list">
						<li>· 참여 방법 : 쿠폰 받기 &rarr; 앱에서 첫구매 &rarr; 구매적립받기 &rarr; 5천점 적립</li>
						<li>· 구매 기간 : 쿠폰 발급일로부터 30일 이내</li>
						<li>· 구매 조건 : 적립대상 쇼핑몰에서 1만원 이상 구매</li>
						<li>· 적립대상 쇼핑몰 : 11번가, G마켓, 옥션, GS SHOP, CJmall, 인터파크,	티몬, 신세계몰, 위메프</li>
					</ul>
				</div>
			</div>
			<!-- //INNER -->

			<!-- 유의사항 WRAPPER -->
			<div class="caution-wrap">
				<a href="javascript:///" class="btn_check">이벤트 유의사항<span class="line"></span></a>

				<!-- 유의사항 -->
				<div class="moreview">
					<h4>유의사항</h4>
					<div class="txt">
						<strong>이벤트 유의사항</strong>
						<ul class="txt_indent">
							<li>구매 후 마이에누리>적립내역>구매에서 ‘적립받기‘ 클릭해, 구매 적립 받은 후 첫구매 혜택 적립 가능</li>
							<li>본인인증한 휴대폰과 동일한 휴대폰에서 첫구매 시 참여됩니다.</li>
							<li>ID당 1회 참여. 1개의 기기에서 1회 참여 가능.</li>
							<li>쿠폰 발급일로부터 30일 이내에 구매 시 참여 가능.</li>
							<li>첫구매 : 앱에서 1만원 이상 첫 구매 시 참여 가능 (적립불가 상품 구매 시 제외)</li>
							<li>첫구매 혜택은 중복으로 지급되지 않습니다. (예)첫구매혜택 신청시, 초대혜택을 받을 수 없습니다.</li>
							<!-- <li>첫 구매를 취소하고, 다시 구매하는 경우는 첫구매로 인정되지 않습니다.</li>  -->
							<li>이미 구매한 적이 있는 기기에서는 다른 ID를 사용하더라도 첫구매 혜택 참여 불가합니다.</li>
							<li><b class="stress">e머니 유효기간 : 15일 (유효기간 만료 후 재적립 불가)</b></li>
							<li>부정 참여 시 적립이 취소 될 수 있습니다.</li>
							<li>이벤트는 당사의 사정에 따라 사전고지 없이 변경 또는 조기종료 될 수 있습니다.</li>
						</ul>

						<strong>구매적립 기준 및 유의사항</strong>
						<ul class="txt_indent">
							<li>에누리 가격비교 앱 로그인 &rarr; 적립대상 쇼핑몰 이동 &rarr; 구매하기 &rarr; 마이에누리>적립내역>구매에서 ‘적립받기‘ 클릭 </li>
							<li>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 위메프</li>
							<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품 결제금액만 반영</li>
							<li>적립 e머니는 카테고리에 따라 차등 적립</li>
							<li>
							<p>카테고리별 적립률 상세</p>
								<div class="tb">
									<table cellpadding="0" cellspacing="0">
										<colgroup>
											<col width="70%"><col width="30%">
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
												<td rowspan="3">0.3%</td>
											</tr>
											<tr>
												<td>패션/화장품</td>
											</tr>
											<tr>
												<td>가구/생활/건강</td>
											</tr>
										</tbody>
									</table>
								</div>
							</li>
						</ul>
						<strong>상품권 및 e쿠폰 적립 상세</strong>
						<ul>
							<li>- 적립가능 상품 (0.3% 적립) 문화상품권(해피머니,컬쳐랜드),도서상품권, 백화점상품권, 영화예매권,국민관광 상품권</li>
							<li>- 적립가능 상품을 제외한 상품권, 지역쿠폰,e교환권, e쿠폰은 적립불가</li>
							<li>- 상품권 적립가능 쇼핑몰 : 티몬, G마켓, 옥션</li>
						</ul>
						
						<strong>아래의 경우에는 구매 확인 및 적립이 불가합니다.</strong>
						<ul class="txt_indent">
							<li>에누리 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리앱으로 결제만 한 경우 (에누리 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)</li>
							<li>에누리 앱을 로그인하지 않고 구매한 경우 또는 앱이 아닌, 에누리PC/모바일 웹에서 구매한 경우</li>
							<li><b class="stress">적립대상쇼핑몰 중 e머니 적립 제외 카테고리/서비스</b>
								<ul>
									<li>- 에누리 가격비교 앱에서 검색되지 않는 상품</li>
									<li>- 인터파크: 모바일쿠폰/상품권, 라이프 서비스(티켓, 투어, 아이마켓 등)</li>
									
									<!-- 
									<li>- 11번가: 여행/숙박/항공, e쿠폰/상품권</li>
									<li>- G마켓: 중고장터, 실시간 여행, 항공권, e쿠폰/상품권, 도서/음반</li>
									<li>- 옥션: 중고장터, 실시간 여행, 항공권, e쿠폰/상품권</li>
									<li>- SSG: 도서/음반/문구/취미/여행/상품권/서비스 및 현금성 상품</li>
									<li>- 티몬: 슈퍼꿀딜, 슈퍼마트 등 특가 판매 상품</li>
									 -->
									<li>- 11번가: 여행/숙박/항공, 모바일쿠폰/상품권 전체</li>
									<li>- G마켓: 중고장터, 실시간 여행, 항공권, 도서/음반, 모바일쿠폰/상품권  (일부 상품권 적립가능)</li>
									<li>- 옥션: 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권  (일부 상품권 적립가능)</li>
									<li>- SSG: 도서/음반/문구/취미/여행, 모바일쿠폰/상품권/서비스 및 현금성 상품</li>
									<li>- 티몬: 슈퍼꿀딜, 슈퍼마트 등 특가 판매 상품, 모바일쿠폰/상품권 (일부 상품권 적립가능)</li>
									<%if(isNext){ %>
									<li>- 위메프: 모바일쿠폰/상품권 전체</li>
									<%}else{ %>
									<li>- 위메프: 모바일쿠폰/상품권 전체(12월 한정, 일부 상품권 적립가능)</li>
									<%} %>
									<li>- CJ몰: 모바일쿠폰/상품권 전체</li>
									<li>- 모바일쿠폰/상품권: 상품권, 지역쿠폰, e교환권, e쿠폰 등 (문화상품권, 도서상품권, 백화점상품권, 영화예매권, 국민관광상품권은 적립가능)</li>
									<li>- 이 외 쇼핑몰에 입점한 제휴 서비스(배달, 티켓, 해외직구 등) 및 일부 카테고리 제외</li>
								</ul>
							</li>
						</ul>
						<a href="javascript:///" class="btn_check_hide">확인</a>
					</div>
				</div>
				<!-- //유의사항 -->
			</div>
			<!-- //유의사항 WRAPPER -->
		</div>
		<!-- //웰컴쿠폰 -->


		<!-- 5천점 받는 방법 -->
		<div class="cateplan_wrap">
			<span class="bal b1"></span><span class="bal b2"></span>
			<!-- INNER -->
			<div class="inner">
				<!-- step slide -->
				<div class="imgbox">
					<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/buy_coupon/april/m_cateplan_tit.png" alt="5천점 받는 방법" class="imgs" width="213" height="56" />
					<div class="plan_list">
						<ul class="planSlide">
							<li><a href="javascript:///"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/buy_coupon/april/m_cateplan_s1.png" alt="" /></a></li>
							<li><a href="javascript:///"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/buy_coupon/april/m_cateplan_s2.png" alt="" /></a></li>
							<li><a href="javascript:///"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/buy_coupon/april/m_cateplan_s3.png" alt="" /></a></li>
							<li><a href="javascript:///"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/buy_coupon/april/m_cateplan_s4.png" alt="" /></a></li>
						</ul>
					</div>

					<script>
					$(function(){
						$('.planSlide').slick({
							dots: true,
							infinite: true,
							speed: 200,
							slidesToShow: 1,
							adaptiveHeight: true,
							autoplay: true,
							autoplaySpeed: 2000
						});
					});
					</script>
				</div>
				<!-- //step slide -->
			</div>
			<!-- //INNER -->
		</div>
		<!-- //5천점 받는 방법 -->


		<!-- 스토어상품 내역 -->
		<div class="benefit">
			<div class="contents">
				<h3><span class="txt_bene">e머니<b>5,000</b>점 받으면 뭐하지?</span></h3>
				<ul class="bef_goos" id = "benefit_5000">
				</ul>
			</div>
		</div>
		<!-- //스토어상품 내역 -->


		<!-- 한번 더 구매 이벤트 -->
		<div id="tab3" class="comback_wrap">
			<!-- INNER -->
			<div class="inner">
				<div class="imgbox">
					<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/buy_coupon/april/m_moreEvent.jpg" alt="한번 더 구매하면 불닭볶음면 100%" class="imgs" />
					<a href="/mobilefirst/evt/welcome_event.jsp?tab=1&freetoken=eventclone" target="_blank" title="새탭 열기"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/buy_coupon/april/m_btn_viewgo.jpg" alt="이벤트 보러가기" /></a>
				</div>
			</div>
		</div>
		<!-- //한번 더 구매 이벤트 -->


		<!-- 진행중인 이벤트 -->
		<%@include file="/eventPlanZone/jsp/eventBannerTapMobile.jsp"%>
		<!-- //진행중인 이벤트 -->


		<script type="text/javascript">
			//상단 탭 이동
			$(document).on('click', '.tabmenu > li > a', function(e) {
				if($(this).hasClass("movetab")){
					var $anchor = $($(this).attr('href')).offset().top - 71;

					$('html, body').stop().animate({scrollTop: $anchor}, 500);
					e.preventDefault();
				}
			});

			$(function(){
				// 유의사항 드롭다운
				$('.btn_check').click(function(){
					var _this = $(this);
					_this.siblings(".moreview").toggle();

					$(".btn_check_hide").click(function(){
						$(this).parents(".moreview").slideUp();
						$('html,body').stop().animate({scrollTop:_this.offset().top - 71});
						return false;
					})
				});
			});
	</script>

	</div>
   
	<span class="go_top"><a onclick="$(window).scrollTop(0);">TOP</a></span>
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
<!-- layer-->
<div class="layer_back" id="app_only2" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 쇼핑혜택</h4>
		<a href="javascript:///" class="close" onclick="onoff('app_only2')">창닫기</a>
		<p class="txt">에누리앱(APP) 설치 후<br />e머니 적립내역 확인 및<br />다양한 e쿠폰 상품으로 교환할 수 있습니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();">설치하기</button></p>
	</div>
</div>

<!-- //layer 개인정보 수집 및 이용동의 -->
<!-- layer 개인정보 수집 및 이용동의 -->
<div class="layer_back" id="myInvitedetail" style="display:none;">
	<div class="inviteLayer">
		<a href="javascript:///" class="close" onclick="onoff('myInvitedetail')">창닫기</a>
		<div class="agree_txt">
			<p class="txt1">개인정보 수집 및 이용동의</p>
			<p class="txt2">본인인증 정보는 이벤트 종료 시까지 <br />저장하며 이벤트 종료 후 파기됩니다.</p>
			<p class="ipt"><label><input type="checkbox" class="chkbox" id="" checked>이벤트 참여를 위한 개인정보 활용에 동의합니다.</label></p>
			<p class="line_detail"><a href="javascript:///" class="btn_detail" onclick="onoff('privacy')"><b>자세히보기</b></a></p>
			<button class="agreebtn" id="couponIns">동의 후 혜택받기</button>
		</div>
	</div>
</div>
<!-- //layer 개인정보 수집 및 이용동의 -->

<!-- 개인정보 수집 이용안내 레이어 --> 
<div class="event_layer" id="privacy" style="display:none">
	<div class="inner_layer privacy">
		<h3 class="tit stripe_layer">개인정보 수집·이용안내</h3>
		<a href="javascript:///" class="stripe_layer close" onclick="onoff('privacy')">창닫기</a>

		<div class="viewer">
			<!-- 개인정보 -->
			<div class="privacy__area">
				<p>에누리 가격비교는 이벤트 참여확인 및 경품 발송을 위하여 아래와 같이 개인 정보를 수집하고 있습니다. </p>
				<dl>
					<dt>1. 개인정보 수집 항목</dt>
					<dd>휴대폰번호, 참여 일시, 참여자ID, 본인인증확인(CI, DI)</dd>
					<dt>2. 개인정보 수집 및 이용 목적</dt>
					<dd>이벤트를 위해 수집된 개인정보는 이벤트 참여확인 및 경품 발송을 위한 본인확인 이외의 목적으로 활용되지 않습니다.</dd>
					<dt>3. 개인정보 보유 및 이용 기간</dt>
					<dd>개인 정보 수집자(에누리 가격비교)는 개인 정보의 수집 및 이용 목적이 달성되면 개인 정보를 즉시 파기합니다.</dd>
				</dl>
			</div>
			<!-- //개인정보 -->
		</div>
		<p class="btn_close"><button type="button" class="stripe_layer privacy__close" onclick="onoff('privacy')">닫기</button></p>
	</div>
</div>
<!-- //개인정보 수집 이용안내 레이어 --> 

<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script>
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로

var numSdt = "<%=numSdt%>";

$(document).ready(function(){
	//로그인시 개인화영역
	if(islogin()){
		getPoint();//개인e머니 내역 노출
	}
	
	//5,000 받으면 뭐하지?
	$.getJSON("/mobilefirst/emoney/emoney_get_random2.jsp",{cnt : 3, price1 : 4000, price2 : 5000 },function(data){
		var vTxt = "";
		$.each(data.itemlist, function(i, item) {				
			vTxt +="<li>";
			vTxt +="	<a href=\"javascript:///\" onclick=\"goEmoneygoods('http://m.enuri.com/mobilefirst/emoney/emoney_detail.jsp?freetoken=emoney_sub&code="+ item.gift_code +"&seq="+ item.gift_seq +"&item="+ item.item_seq +"');\">";
			vTxt +="	<img src=\"http://imgenuri.enuri.gscdn.com/images/mobilefirst/emoney/item/@"+ item.item_seq +".jpg\" alt=\"\">";
			vTxt +="		<em class=\"ellipsis\">"+ item.item_name +"</em>";
			vTxt +="		<span><em class=\"e\">e머니</em>"+ commaNum(item.gift_price) +"</span>";
			vTxt +="	</a>";
			vTxt +="</li>";
		});
		$("#benefit_5000").html(vTxt);
	});
	
	var bttnArea = $("#couponChk");
	if(<%=isApply%>) {
		bttnArea.addClass("done");
		if(getOsType() == "app"){
			bttnArea.click(afterClick);
		}
	} else {
		bttnArea.click(beforeClick);
	}

	function beforeClick() {
		
		if(numSdt > 20190131){
			alert("이벤트가 종료 되었습니다.");
			return false;
		}
		
		evtCall(1, function(data){
		    var result = data.result;
		    switch(result) {
		        case 1 :
		        	onoff('myInvitedetail');
		            break;
		        case 2 :
		            alert("휴대폰번호 본인인증 후\n 참여할 수 있습니다.");
		    		window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&freetoken=login_title");	
		            break;
		        case 3 :
					if(confirm("초대코드가 있습니다.\n초대 첫구매 혜택 신청해주세요.")){
			            window.open('/mobilefirst/evt/new_friend_20179.jsp?freetoken=eventclone');
					}
		            break;
		        case 4 :
		            alert("첫 구매 후\n혜택 신청 하세요.");
		            window.open('/mobilefirst/evt/welcome_event.jsp?tab=1&freetoken=eventclone');
		            break;
		        case -4 :
		        	alert("SDU 회원은 본인인증 후 참여 가능합니다.\n※ 본인인증은 ‘앱 설정 > 본인인증’ 또는 ‘PC >\n개인정보관리 화면’을 이용해주세요");
		        	break;
		        default :
		            alert("아쉽네요^^;\n 대상자가 아닙니다.");
		            break;
		    }
		});
	}

	function afterClick() {
		evtCall(3, function(data){
		    if(data.userId) {
		        if(data.cart_seq != 0) {
		            alert("첫 구매 완료!\n\n 구매일로부터 약 7일(최대 30일) 후에\n구매적립받기 버튼 생성됩니다.\n\nMy페이지 > 구매 적립내역에서\n적립 신청해주세요.");
		            location.href = "/mobilefirst/emoney/emoney.jsp?freetoken=emoney";
		        }else if(data.strToday > data.cpn_expire_dt){
		            alert("쿠폰이 만료되었습니다.\n첫구매 후 혜택 신청하세요.");
		            window.open('/mobilefirst/evt/welcome_event.jsp?tab=1&freetoken=eventclone');
		        }else{
		            alert("쿠폰 발급일로부터 30일 이내에\n구매시 적립됩니다.");
		        }
		    }
		});
	}

	//쿠폰 발급
	$("#couponIns").click(function(e){
		
		if(!$(".chkbox").prop("checked")){
			alert("정보 수집 동의 후 쿠폰 신청하세요!");
			return false;
		}
		
		evtCall(2, function(data){
		    var result = data.result;
		    switch(result) {
		        case true :
		            alert("정상 발급 되었습니다!\n\n앱에서 첫구매하고\n구매일로부터 약 10일(최대 30일) 후\n'구매적립' 받으세요!");
		            bttnArea.addClass("done");
		            bttnArea.unbind();
		            break;
		        default :
		            alert("이미 발급되었거나 대상자가 아닙니다.");
		            break;
		    }
	    	onoff('myInvitedetail');
		});
	});

	var isClick = true;
	//event API 호출
	function evtCall (procCode, callback) {
	    if(!islogin()){
	        alert("로그인 후 이용 가능합니다.");
	        goLogin();      
	        return false;
	    }
	    if(!isClick){
	    	return false;
	    }
	    isClick = false;
	    
	    var params = {procCode : procCode, osType : getOsType()};
	    
	    if(location.host.indexOf("dev.enuri.com") > -1){
	    	params.sdt = <%=sdt%>;
	    }
	    
	    $.post("/mobilefirst/evt/ajax/ajax_firstbuycpn_proc.jsp", params, callback, "json")
	    	.done(function(){
	    		isClick = true;
	    	});
	}
});

function goEmoneygoods(url){
	 if(getCookie("appYN") != 'Y'){
		onoff('app_only');
	 }else{
		 if(islogin())		window.open(url);
		else		       	location.href = "/mobilefirst/login/login.jsp";          
	}
}

window.onload = function(){
	
	ga('send', 'pageview', {'page': vEvent_page ,'title': '첫구매 선쿠폰 프로모션 PV'});
	
	//닫기버튼
	$( ".win_close" ).click(function(){
	    if(getCookie("appYN") =='Y'){
			window.location.href = "close://";
		}else{
			window.location.replace("/mobilefirst/Index.jsp");
		}
	});
};

function getOsType(){
    if(getCookie("appYN") =='Y'){
         return "app";
    }else {
        return "web";
    }
}

/*checkbox*/
function agreechk(obj){
	if (obj.className== 'unchk') {
		obj.className = 'chk';
	} else {
		obj.className = 'unchk';
	}
}
</script>
</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
