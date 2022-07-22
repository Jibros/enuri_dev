<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Reward_Data"%>
<%@ page import="com.enuri.bean.mobile.Emoney_Proc"%>
<jsp:useBean id="Reward_Data" class="com.enuri.bean.mobile.Reward_Data" scope="page" />
<jsp:useBean id="Emoney_Proc" class="com.enuri.bean.mobile.Emoney_Proc" scope="page" />
<%
	String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
	String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");
	
	String strChk_id = ChkNull.chkStr(request.getParameter("chk_id"),"");
	String strPath = ChkNull.chkStr(request.getParameter("path"),"");
	
	Cookie[] carr = request.getCookies();
	String strAppyn = "";
	String strVerios = "";
	String strVerand = "";
	String strAd_id = "";
	int intVerios = 0;
    int intVerand = 0;
	 
	try {
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("appYN")){
		    	strAppyn = carr[i].getValue();
		    	break;
		    }
		}
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("verios")){
		    	strVerios = carr[i].getValue();
		    	break;
		    }
		}
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("verand")){
		    	strVerand = carr[i].getValue();
		    	//break;
		    }
		}
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("adid")){
		    	strAd_id = carr[i].getValue();
		    	break;
		    } 
		}
	} catch(Exception e) {
	}
	
	String szRemoteHost = request.getRemoteHost().trim();
	
	if(!strAppyn.equals("Y") && szRemoteHost.indexOf("58.234.199.")<0){
		response.sendRedirect("/mobilefirst/Index.jsp");// 여기
		return;
	}
	 
	strVerios = strVerios.replace(".","");
	strVerand = strVerand.replace(".","");
  
    //intVerios = Integer.parseInt(strVerios);
    //intVerand = Integer.parseInt(strVerand);
	
    int i_Log = 5941;
	int i_Log_pad = 0;
	if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0){
		i_Log = 5940;
	}else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0){
		i_Log = 5939;
	}else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0){
		i_Log = 5939;
		i_Log_pad = 1;
	}else{ 
		i_Log = 5941;
	}
	//상품정보 Bar 3.2.0 부터 사라짐 app에서만
    boolean blTopbar_show = false;
    
	try{
	    if(strAppyn.equals("Y")){
	        if(i_Log == 5940){
	        	intVerand = Integer.parseInt(strVerand);
	            if(intVerand >= 320){
	                blTopbar_show = false;
	            }else{
	            	blTopbar_show = true;
	            }
	        }else if(i_Log == 5939){
	        	intVerios = Integer.parseInt(strVerios);
	            if(intVerios >= 32000){
	                blTopbar_show = false;
	            }else{
	            	blTopbar_show = true;
	            }
	        }
	    }
	 }catch(Exception e){}
%> 
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/default.css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/emoney.css"> 
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/common.css"> 
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/event/emoney_info.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
	<script src="/mobilefirst/js/lib/jquery.paging.min.js"></script>
	<script src="/mobilefirst/js/lib/jquery.easy-paging.js"></script>
	<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		//런칭할때 UA-52658695-3 으로 변경
		ga('create', 'UA-52658695-3', 'auto');
	</script>
</head>
<body>
<div class="dim" id="mysave" style="display:none;">
	<div class="myarea">
		<a href="javascript:///" class="close" onclick="onoff('mysave')">창닫기</a>
		<div class="my_info">
			<h4 class="lose">소멸예정 <em>e</em>머니</h4>
			
			<div class="lose_list">
				<ul id="loselist"></ul>
				<div class="a_c"><button type="button" class="btn_close" onclick="onoff('mysave')">닫기</button></div>
			</div>
	
		</div>	
	</div>
</div>
<!--// 상세보기 레이어 -->

<!-- 시스템 정기점검 안내 -->
<div class="dim" id="mainLayer" style="display:none;">
	<div class="checkLayer">
		<div class="txt">
			<h1>시스템 정기점검 안내</h1>
			<p>안녕하세요. 에누리 가격비교입니다. 에누리에서는 고객님께 보다 나은 서비스를 제공하기 위하여 아래와 같이 정기점검을 실시하고 있습니다.
			점검 시간 동안 일부 서비스 이용이 제한되오니, 많은 양해 부탁 드립니다.</p>
			<dl>
				<dt>점검시간</dt>
				<dd>7.28 (금)  00:00  ~  09:00 (9시간)</dd>
				<dt>서비스제한</dt>
				<dd>쿠폰 교환 및 환불, 쿠폰사용 불가</dd>
			</dl>
			<p>약속한 시간에 작업을 마무리 하여, 더욱 편리한 서비스로 찾아 뵙겠습니다.</p>
		</div>
		<p class="frontbtn"><span><a href="#" onclick="mainLayer_close();">다시 보지않기</a></span><span><a href="#" onclick="onoff('mainLayer')">닫기</a></span></p>
	</div>
</div>
<!-- 상세보기 레이어 -->

<!-- 위메프 상품권 적립률 변경 공지 노출 -->
<div class="dim" id="eTicketLayer" style="display:none;">
	<div class="wemap_ticket_layer">
		<div class="con">
			<h1><b>e머니</b> 적립 변경 안내</h1>
			<p class="txt">안녕하세요, 에누리가격비교입니다.<br /><b>e머니 적립 변경 관련해서 안내드립니다.</b></p>
			<p class="txt">이용에 참고 부탁 드립니다.</p>
			<div class="eticket_use_list">
				<h2>상품권 e머니 적립률 변경 </h2>
				<ul>
					<li>적립률: 0.8 → 0.4%</li>
					<li>적용시점: 2018년 4월 1일 이후 구매건</li>
					<li>적립가능 상품권<br /><span class="subtxt">문화/도서/백화점 상품권, 영화예매권, 국민관광상품권</span></li>
				</ul>				
				
				<h2>제휴 쇼핑몰 구매건 적립방식 변경</h2>
				<ul>
					<li>적립방식: 자동적립 → 적립받기 선택 후 적립</li>
					<li>적용시점: 2018년 4월 2일 오전 10시</li>
					<li>e머니 유효기간은 적립가능 시점부터 최대 60일</li>
				</ul>
				<button class="view" onclick="$('#btn_info03').show();">e머니 적립안내 자세히 보기</button>
			</div>
		</div>
		<p class="frontbtn"><span><a href="#" onclick="wmpLayer_close();">일주일간 보지않기</a></span><span><a href="#" onclick="$('#eTicketLayer').hide();">닫기</a></span></p>
	</div>
</div>
<!-- 위메프 상품권 적립률 변경 공지 노출 -->

<!-- e머니 적립정책 변경안내 -->
	<div class="dim" id="saveLayer" style="display:none;">
		<div class="saveLayer">
			<div class="txt">
				<h1>e머니 적립관련 변경안내</h1>
				안녕하세요, 에누리가격비교입니다.<br />
				추석연휴 기간 e머니 적립 안내 드립니다.<br /><br />
				
				<em class="red">연휴기간 쇼핑몰 휴무</em> 등으로 인해 <br />
				일시적으로 e머니 적립이 중단되며 연휴 이후에 <br />
				일괄 적립 될 예정입니다.

				<ul class="box">
					<li><b>적립 중단 기간</b>  : 10/01(일)~10/10(화)</li>
					<li><b>일괄 적립 기간</b>  : 10/11(수)~10/12(목)</li>
				</ul>

				<p>항상 에누리가격비교를 이용해주셔서 감사 드리며,<br />즐거운 연휴 보내시길 바랍니다.</p>
			</div>
			<p class="frontbtn"><span><a href="#" onclick="saveLayer_close();">다시 보지않기</a></span><span><a href="#" onclick="onoff('saveLayer')">닫기</a></span></p>
		</div>
	</div>
<!-- 2017-12-05 e머니 상품권적립안내 레이어 -->
<div class="dim" id="eTicketLayer" style="display:none;">
	<div class="emoney_ticket_layer">
		<div class="con">
			<h1>e머니 <b>상품권 적립 안내</b></h1>
			<p class="txt">안녕하세요, 에누리가격비교입니다.<br />적립불가 상품 중 일부상품의 e머니가 적립되던 <br />현상이 수정되어 안내 드립니다.</p>
			<p class="txt"><b>옥션, G마켓, 11번가, 인터파크</b>에서 구매하신 <br /><b>상품권 및 e쿠폰 전체의 적립이 완전히 종료</b>됩니다.<br />이용에 참고 부탁 드립니다.</p>
			<div class="eticket_use_list">
				<h2>적용내용</h2>
				<ul>
					<li>옥션, G마켓, 11번가, 인터파크 상품권/e쿠폰 전체 적립종료</li>
					<li>티몬, 위메프, CJ몰은 상품권/e쿠폰 중 일부상품 적립 가능<span class="subtxt"><br />(문화상품권 / 도서상품권 /백화점상품권 /영화예매권 / 국민관광상품권 적립 가능)</span></li>
				</ul>
				<button class="view" onclick="onoff('btn_info03');">e머니 적립안내 자세히 보기</button>
			</div>
		</div>
		<p class="frontbtn"><span><a href="#" onclick="eTicketLayer_close();">다시 보지 않기</a></span><span><a href="#" onclick="$('#eTicketLayer').hide();">닫기</a></span></p>
	</div>
</div>
<!-- 2017-12-05 e머니 상품권적립안내 레이어 -->
<!-- 자동적립 유의사항 레이어 -->
<div class="layer_back over_ht" id="btn_info03" style="display:none; height:100%; opacity:unset;">
	<div class="appLayer">
		<h4>자동적립 유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('btn_info03')">창닫기</a>
		<div class="txt">
			<strong>지급 기준 및 구매 유의사항</strong>
			<ul class="txt_indent">
				<li>에누리 앱 로그인 &#8594 구매상품 검색 &#8594 쇼핑몰 이동 &#8594 구매하기 &#8594 구매확정(배송완료)</li>
				<li>배송비, 설치비, 할인, 쇼핑몰 포인트를 제외한 결제 금액의 3,000원 이상 시 구매금액의 최대 1.5% e머니 적립 </li>
				<li>대상쇼핑몰에서 장바구니로 여러 상품을 한번에 통합 결제 시 구매건수는 1건으로 적립</li>
				<li>결제일로부터 취소/반품여부 확인 후 적립 (10일~최대 30일 소요)</li>
				<li>e머니는 최소 10점부터 적립되며, 1점 단위 절삭 후 적립됩니다.</li>
				
			</ul>
			<strong>적립대상 쇼핑몰</strong>
			옥션, G마켓(G9 제외), 11번가, 인터파크, CJ몰, GSshop, 티몬, 위메프, SSG몰
			<strong>카테고리 별 적립률 (1점 단위 절삭 후 적립)</strong>
			<ol class="inner" style="margin-top:0px">
				<li>- 1.5% 적립 : 유아/식품</li>
				<li>- 1.0% 적립 : 스포츠/레저/자동차</li>
				<li>- 0.8% 적립 : 컴퓨터/도서/여행/취미(상품권)</li>
				<li>- 0.3% 적립 : 위에 명시되지 않은 카테고리 (디지털/ 가전 / 패션 / 화장품 / 가구 / 생활 등)</li>
			</ol>
			<strong>쇼핑몰 별 적립불가 상품</strong>
			쇼핑몰 공통
			<ol class="inner" style="margin-top:0px">
				<li>- 에누리 가격비교 앱에서 검색되지 않는 상품</li>
				<li>- 각 쇼핑몰에 입점한 제휴서비스 (백화점 등)</li>
				<li>- 장바구니에 담긴 상품을 모바일에서 결제만 하는 경우</li>
			</ol>
			<ol class="inner" style="margin-top:0px">
				<li>옥션, G마켓</li>
				<li>- 중고장터, 실시간 여행, 항공권, 해외배송, 도서/음반</li>
				<li>- 상품권 및 e쿠폰 전체</li>
				
				<li>11번가</li>
				<li>- 여행, 숙박, 항공권</li>
				<li>- 상품권 및 e쿠폰 전체</li>
				
				<li>인터파크</li>
				<li>- 에누리 특가상품(크레이지딜), 티켓, 투어, 아이마켓</li>
				<li>- 상품권 및 e쿠폰 전체</li>
				
				<li>티몬</li>
				<li>- 슈퍼꿀딜, 슈퍼마트 등 특가 판매 상품</li>
				<li>- 상품권 및 e쿠폰 (문화상품권, 도서상품권, 백화점 상품권, 영화예매권은 적립가능)</li>
				
				<li>위메프</li>
				<li>- 상품권 및 e쿠폰 (문화상품권, 도서상품권, 백화점 상품권, 영화예매권은 적립가능)</li>
				
				<li>SSG몰</li>
				<li>- 도서/음반, 문구, 취미, 여행</li>
				<li>- 상품권 및 e쿠폰 전체</li>
				
				<li>CJ몰</li>
				<li>- 상품권 및 e쿠폰 (문화상품권, 도서상품권, 백화점 상품권, 영화예매권은 적립가능)</li>
			</ol>
		
			<strong>아래의 경우에는 구매 확인 및 적립이 불가합니다.</strong>
			에누리 앱이 아닌 곳에서 장바구니 또는 관심상품 등록 후 에누리 앱으로 결제만 한경우
			(에누리 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)
			에누리 앱 미 로그인 후 구매한 경우 또는 에누리 PC, 모바일 웹에서 구매한 경우
			
		
			<strong>e머니 유의사항</strong>
			<ul class="txt_indent">
				<li>e머니 유효기간: 적립일로부터 60일</li>
				<li>적립된 e머니는 앱에서 다양한 e쿠폰 상품으로 교환 가능합니다.</li>
			</ul>

			<strong>적립확인</strong>
			<ul class="txt_indent">
				<li>에누리 앱 로그인 후 마이 페이지에서 확인</li>
			</ul>

		

			<strong>유의사항</strong>
			<ul class="txt_indent">
				<li>부정 참여 시 적립이 취소될 수 있습니다.</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
			</ul>
			
		</div>
		<p class="btn_close" style="border : none; box-shadow : none;"><button type="button" onclick="onoff('btn_info03')">확인</button></p>
	</div>
</div>
<!-- 자동적립 유의사항 레이어 -->
<!-- 상세보기 레이어 -->
<div class="wrap">
	<section class="top" style="display:none;">
		<h1>사용가<em onclick="ver();">능</em> <span>e</span>머니</h1>
		<div class="my_e"></div>
		<nav>
			<ul class="sgnb">
				<li id="saving" class="on">적립내역</li>
				<li id="store">스토어</li>
				<li id="couponbox">쿠폰함</li>
				<li id="notice">혜택안내</li>
			</ul>
		</nav>
	</section>

	<div class="shop_contents">
	<!--	
	<p class="myinfo">7일 내 소멸예정 : <span id="end_point">0점</span><button type="button" class="btn_view">상세보기</button></p>
	<div class="myinfo">
		<ul>
			<li class="on"><a>전체</a></li>
			<li><a>적립</a></li>
			<li><a>사용</a></li>
		</ul>
		<button type="button" class="btn_view" !onclick="onoff('mysave')">소멸예정 e머니</button>
	</div>
	-->
	<div class="myinfo">
		<ul>
			<li class="on"><a>구매</a></li>
			<li><a>이벤트</a></li>
			<li><a>환불</a></li>
			<li><a>사용</a></li>
		</ul>
		<button type="button" class="btn_view" !onclick="onoff('mysave')">소멸예정</button>
	</div>
	<ul class="savingList"></ul>
	<ul class="paging" id="paging" style="display:none;">
		<li></li>
	    <li>#n</li>
	    <li>#n</li>
	    <li>#c</li>
	    <li>#n</li>
	    <li>#n</li>
	    <li></li> 
	</ul> 
		<!-- e머니 적립가능 쇼핑몰 -->
		<div class="mall_list">
			<h4>e머니 적립가능 쇼핑몰</h4>
			<ul>
				<li><img src="http://img.enuri.info/images/mobilefirst/images/tmp/logo_auction.gif" alt="옥션"></li>
				<li><img src="http://img.enuri.info/images/mobilefirst/images/tmp/logo_gmarket.gif" alt="지마켓"></li>
				<li><img src="http://img.enuri.info/images/mobilefirst/images/tmp/logo_11st.gif" alt="11번가"></li>
				<li><img src="http://img.enuri.info/images/mobilefirst/images/tmp/logo_interpark.gif" alt="인터파크"></li>
				<li><img src="http://img.enuri.info/images/mobilefirst/images/tmp/img_logo06.gif" alt="CJmall"></li>
				<li><img src="http://img.enuri.info/images/mobilefirst/images/tmp/img_logo05.gif" alt="GS SHOP"></li>
				<li><img src="http://img.enuri.info/images/mobilefirst/images/tmp/logo_timon.gif" alt="티몬"></li>
				<li><img src="http://img.enuri.info/images/mobilefirst/images/tmp/logo_ssg.gif" alt="ssg"></li>
				<li><img src="http://img.enuri.info/images/mobilefirst/images/tmp/logo_wema.gif" alt="위메프"></li>
			</ul>
		</div>
	</div>
	<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
	<!-- 환불 상세 레이어 -->
	<div class="dim" id="refund"  style="display:none;">
		<div class="myarea refund">
			<a href="javascript:///" class="close" onclick="$('#refund').hide();">창닫기</a>
			<div class="my_info">
				<h4 class="lose">환불 상세내역</h4>
				
				<div class="refund_area">
					<div class="refund_box">
					<em class="mark ico_big_pc" style="display:none;">PC</em><em class="mark ico_big_mobile" style="display:none;">모바일</em>
						<p class="thum"></p>
						<strong id="thum_name"></strong>
						<span class="emo">환불e머니<em id="thum_point"></em></span>
						<p class="date" id="thum_date"></p>
					</div>
					<p class="note">최초 교환시 e머니 적립 시점에 따라 환불되는 e머니의 유효기간이 다를 수 있습니다.</p>
					<div class="shop_contents">
						<ul id="refund_savingList" class="savingList"></ul>
					</div>
				</div>

			</div>	
		</div>
	</div>
	<!--// 환불 상세 레이어 -->
</div>




</body>

</html>
<script>

var spin_opts = {
	lines: 5, // The number of lines to draw
	length: 30, // The length of each line
	width: 4, // The line thickness
	radius: 10, // The radius of the inner circle
	corners: 1, // Corner roundness (0..1)
	rotate: 0, // The rotation offset
	color: '#000', // #rgb or #rrggbb
	speed: 1, // Rounds per second
	trail: 60, // Afterglow percentage
	shadow: false, // Whether to render a shadow
	hwaccel: false, // Whether to use hardware acceleration
	className: 'spinner', // The CSS class to assign to the spinner
	zIndex: 2e9, // The z-index (defaults to 2000000000)
	top: 'auto', // Top position relative to parent in px
	left: 'auto' // Left position relative to parent in px
};
 
$.fn.spin = function(spin_opts) {
	this.each(function() {
		var $this = $(this),
			data = $this.data(); 

		if (data.spinner) {
			data.spinner.stop();
			delete data.spinner; 
		}
		if (spin_opts !== false) {
			data.spinner = new Spinner($.extend({color: $this.css('color')}, spin_opts)).spin(this);
		}
	});
	return this;
};

var vView = "<%=strPath %>";
var vTitle = "e머니 적립내역";
var vVerios = "<%=strVerios %>";
var vVerand = "<%=strVerand %>";
var iPage = 1;
var iPageSize = 25;

function ver(){
	alert(vVerand);
}

$(function() {
	if($.cookie('appYN') != 'Y' && '<%=strAppyn %>' != 'Y'){	// 웹에서 호출
	//if(1==2){
		 alert("에누리 앱(APP)에서 e머니 적립내역 확인 및 다양한 e쿠폰 상품으로 교환할 수 있습니다.");
  		 event.preventDefault();
  		 location.href = "/mobilefirst/Index.jsp"; // 여기
  	}else{ 
  		// 앱에서 호출 
	    	if(window.android){		// 안드로이드
	    		if(vVerand != "" && Number(vVerand) < 304){
	    			if(confirm("e머니 적립내역 확인 및 e쿠폰 교환을 위해서는 업데이트가 필요합니다.\n\n업데이트 하시겠습니까?")>0){
	        			window.location.href = "market://details?id=com.enuri.android";
	        			setTimeout("location.href='close://';", 2000);
	        			return;
	    			}else{
	    				window.location.href = "close://";	    				
	    			}
	    		}
	    	}else{					// 아이폰에서 호출
	    		if(vVerios != "" && Number(vVerios.substring(0,3)) < 304){
	    			if(confirm("e머니 적립내역 확인 및 e쿠폰 교환을 위해서는 업데이트가 필요합니다.\n\n업데이트 하시겠습니까?")>0){
	        			window.location.href = "https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8&freetoken=outlink";
	        			setTimeout("location.href='close://';", 2000);
	        			return;
	    			}else{
	    				window.location.href = "close://";	    				
	    			}
	    		}
	    	}
  	}
	
	//위메프 적립내역 변경
	if ($.cookie('wmpLayer') != "CHECKED") {
			$("#eTicketLayer").show();
	}
	//시스템공지 레이어
	//if ($.cookie('mainLayer') != "CHECKED") {
	//	$("#mainLayer").show();
	//}
	
 	//if ($.cookie('saveLayer') != "CHECKED") {
	//	$("#saveLayer").show();
    //}
	/* if ($.cookie('eTicketLayer') != "CHECKED") {
		$("#eTicketLayer").show();
    } */
	//title생성
	try{ 
		window.android.getEmoneyTitle(vTitle);
	}catch(e){}

	getPoint();

	getEndlist();
	
	getHistory('in_buy');
	
	$("#saving").click(function(){
		getHistory('in_buy');
	});
	$("#store").click(function(){
		location.href = "http://m.enuri.com/mobilefirst/emoney/emoney_store.jsp?freetoken=emoney";
	});
	$("#couponbox").click(function(){
		location.href = "http://m.enuri.com/mobilefirst/emoney/emoney_couponbox.jsp?freetoken=emoney";
	});
	$("#notice").click(function(){
		//location.href = "/mobilefirst/event/benefit.jsp?freetoken=emoney_sub";
		location.href = "http://m.enuri.com/mobilefirst/emoney/benefit.jsp?freetoken=emoney";
	});
	
	$(".btn_view").click(function(){
		onoff('mysave');
		ga('send', 'event', 'mf_emoney',  'click', '적립내역_상세보기');
	});
	
	$(".myinfo li").click(function(){
		var vPointInOut = "";
		iPage = 1;
		
		$(".myinfo li").removeClass("on");
		if($(this).text() == "구매"){ 
			ga('send', 'event', 'mf_emoney',  'click', '적립내역_구매'); 
			$(this).addClass("on");	
			getHistory('in_buy');
		}else if($(this).text() == "이벤트"){ 
			ga('send', 'event', 'mf_emoney',  'click', '적립내역_이벤트'); 
			$(this).addClass("on");	
			getHistory('in_event');
		}else if($(this).text() == "환불"){ 
			ga('send', 'event', 'mf_emoney',  'click', '적립내역_환불'); 
			$(this).addClass("on");	
			getHistory('in_refund');
		}else if($(this).text() == "사용"){ 
			ga('send', 'event', 'mf_emoney',  'click', '적립내역_사용');
			$(this).addClass("on");
			getHistory('out');
		}
	});
	
	ga('send', 'pageview', {
		'page': '/mobilefirst/emoney/emoney.jsp',
		'title': 'mf_emoney_적립내역'
	}); 
	
	/*하단 top버튼 & 작은따라다니는 배너_시작*/
	$(window).scroll(function(){
        $(".TBtn").show();
        
        if ( $(window).scrollTop() < 50 ){
        	$(".TBtn").hide();
        }
    });
    
    $("body").on('click', '.TBtn', function(event) {
		scrollTo(0,0);    
    });
    
	$(".cateBtn.gift").click(function(){
			ga('send', 'event', 'mf_footer', 'footer', 'footer_선물박스');
			location.href = "/mobilefirst/emoney/benefit.jsp?freetoken=event";
	});
	/*하단 top버튼 & 작은따라다니는 배너_끝*/
	
});
function wmpLayer_close(){
	fnEverSetCookie("wmpLayer", "CHECKED", 7);
	onoff('eTicketLayer');
}

function mainLayer_close(){
	fnEverSetCookie("mainLayer", "CHECKED", 7);
	onoff('mainLayer');
}

 function saveLayer_close(){
	fnEverSetCookie("saveLayer", "CHECKED", 90);
	onoff('saveLayer');
}
function eTicketLayer_close(){
	fnEverSetCookie("eTicketLayer", "CHECKED", 999);
	onoff('eTicketLayer');
}
//쿠키 날짜 대로
function fnEverSetCookie( name, value, expiredays )
{
	var todayDate = new Date();
	todayDate.toGMTString()
	todayDate.setDate( todayDate.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}


function getPoint(){
	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_point.jsp",
		async: false,
		dataType:"JSON",
		success: function(json){
			remain = json.POINT_REMAIN;	//적립금
			
			$(".my_e").html("<span>"+CommaFormattedN(remain) +"<em>"+json.POINT_UNIT+"</em></span>");
			
			if(parseInt(remain) > 0){
				$(".btn_view").show();
			}else{
				$(".btn_view").hide();
			}	
		}
	});
}

function getHistory(param){
	var today2 = new Date();

	var year2 = today2.getFullYear();
	var month2 = today2.getMonth() + 1;
	var day2 = today2.getDate();
	
	if(month2 < 10){
		month2 = "0"+month2;
	}
	if(day2 < 10){
		day2 = "0"+day2;
	}
	
	var vDate2 = year2+month2+day2;

	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_pointlist.jsp",
		async: false,
		data:"point_in_out="+param+"&page="+iPage,
		dataType:"JSON",
		success: function(data){
			$(".savingList").html(null);
			 
			var vTxt = "";
			var vTotalCnt = 0;
			
			$.each(data.pointlist, function(i, item) {
				vTotalCnt = item.total_cnt;
				
				if(param != "in_refund"){
					vTxt += "<li>";
					vTxt += "	<span class=\"date\">"+ item.point_date.substring(0,10);
					if(item.point_expire_date != "" &&  item.point_in_out.indexOf("-") < 0){
						vTxt += " ~ "+ item.point_expire_date;
					}  
					if(parseInt(item.point_expire_date.replace(/-/gi,"")) < parseInt(vDate2)){
						//vTxt += " (기간만료)";
					}
					vTxt += "	</span>"; 
					vTxt += "	<strong>";
					if(item.point_code == "07"){
						vTxt += "이벤트적립";	//공유	
					}else if(item.point_code == "08" ){
						vTxt += "이벤트적립";	//앱설치
					}else if(item.point_code == "09"){
						vTxt += "이벤트적립";	//적립군동의
					}else if(item.point_code == "10"){		//새로생성 이벤트적립 통합
						vTxt += "이벤트적립";	
					}else if(item.point_code == "01"){
						vTxt += "구매적립 | "+ getShopname(item.shop_code) + "("+ (item.cart_order_date).substring(5,10).replace("-","/") +")";
					}else if(item.point_code == "02"){
						vTxt += "이벤트적립";
					}else if(item.point_code == "03"){
						vTxt += "이벤트적립";
					}else if(item.point_code == "04"){
						vTxt += "쿠폰교환";
						if(item.coupon_name != ""){
							vTxt += " | "+ item.comp_name + "("+ item.coupon_name +")" ;
						}
					}else if(item.point_code == "05"){
						vTxt += "사용기간만료";
					}else if(item.point_code == "06"){
						vTxt += "적립취소";
					}else if(item.point_code == "91"){
						vTxt += "이벤트적립 | CS (쿠폰오류)";
					}else if(item.point_code == "92"){
						vTxt += "이벤트적립 | CS (기타오류)";
					}else if(item.point_code == "93"){	//CS적립 통합
						vTxt += "CS적립 ";
					}else if(item.point_code == "11"){	//쇼핑지식 적립
						vTxt += "쇼핑지식 적립 ";
					}else{
						if(item.point_in_out.indexOf("-")>-1){
							vTxt += "기타차감";	
						}else{
							vTxt += "기타적립";
						}
					}
					
					if(item.point_desc != ""){
						//if(item.point_desc == "4월 에누리Day" && item.point_date.indexOf("2016-05-") > -1){
						//	vTxt += " | 5월 에누리Day";
						//}else{
							vTxt += " | "+item.point_desc;
						//}
					}
					
					vTxt += "</strong>";
					
					if(item.point_in_out.indexOf("-")>-1){
						vTxt += "<span class=\"point minus\">"+ CommaFormattedN(item.point_in_out) +"<em>점</em></span>";	
					}else{
						vTxt += "<span class=\"point\">"+ CommaFormattedN(item.point_in_out) +"<em>점</em></span>";
					}

					if(item.device == "P"){
						//PC만 마크
						vTxt += "<em class=\"mark ico_pc\">PC</em>";
					}else{
						//vTxt += "<em class=\"mark ico_mobile\">모바일</em>";
					}
					
					
					vTxt += "</li>";
				}else{
					//환불처리
					vTxt += "<li>";
					vTxt += "	<span class=\"date\">"+ item.refund_date.substring(0,10) +"</span>";
					vTxt += "	<strong>";
					vTxt += "<span class=\"refund\">[쿠폰환불]</span>";
					if(item.coupon_name != ""){
						vTxt += " "+ item.coupon_name;
					}
					vTxt += "</strong>";
					
					vTxt += "<button class=\"point\" onclick=\"refund_datail('"+ item.coupon_seq +"', "+ item.coupon_price +")\">"+ CommaFormattedN(item.coupon_price.replace("-","")) + "<em>점</em></button>";

					if(item.device == "P"){
						//PC만 마크
						vTxt += "<em class=\"mark ico_pc\">PC</em>";
					}else{
						//vTxt += "<em class=\"mark ico_mobile\">모바일</em>";
					}
					
					vTxt += "</li>";
				}
			});
			
			$(".savingList").html(vTxt);
			
			var vPaging = "<li></li><li>#n</li><li>#n</li><li>#c</li><li>#n</li><li>#n</li><li></li>";

			$("#paging").html(vPaging);
			
			if(vTotalCnt > 25){
				$("#paging").show();
			} 
			
			if(iPage == 1){
				$("#paging").easyPaging(vTotalCnt, {
					perpage: iPageSize,
					page: 1,
					onSelect: function(page) {
						if(iPage != page){
							scrollTo(0, 0);
							iPage = page;
							getHistory(param);
						}
					} 
		         });	  
			}else{
				$("#paging").easyPaging(vTotalCnt, {
					perpage: iPageSize,
					page: iPage,
					onSelect: function(page) {
						if(iPage != page){ 
							scrollTo(0, 0);
							iPage = page;
							getHistory(param);
						}
					} 
	            });
			}
		}
	});
}

function refund_datail(coupon_seq, coupon_point){
	$("#refund_savingList").html(null);
	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_refundlist.jsp",
		async: false,
		data:"coupon_seq="+coupon_seq,
		dataType:"JSON",
		success: function(data){
			//$("#refund_savingList").html(null);
			 
			var vTxt = "";

			if(typeof  data.gift_code != "undefined" && data.gift_code != ""){
				getCouponInfo(data.gift_code);
				$("#thum_point").html("<b>"+CommaFormattedN((coupon_point+"").replace("-","")) +"</b>점");
				$("#thum_date").html("<em>교환일</em>"+ data.c_date.substring(0,10) +"<br /><em>환불일</em>"+ data.refund_date.substring(0,10) +"");
				if(data.device == "P"){
					$(".ico_big_pc").show();
					$(".ico_big_mobile").hide();
				}else{
					$(".ico_big_pc").hide();
					$(".ico_big_mobile").show();
				}
			}
			
			$.each(data.refundlist, function(i, item) {
				vTxt += "<li>";
				vTxt += "	<span class=\"date\">"+ item.point_date.substring(0,10);
				if(item.point_expire_date != "" &&  item.point_in_out.indexOf("-") < 0){
					vTxt += " ~ "+ item.point_expire_date;
				}  
				vTxt += "	</span>"; 
				vTxt += "	<strong>";
				vTxt += "환불 적립 ";
				
				if(typeof  item.point_desc != "undefined" && item.point_desc != ""){
					//if(item.point_desc == "4월 에누리Day" && item.point_date.indexOf("2016-05-") > -1){
					//	vTxt += " | 5월 에누리Day";
					//}else{
						vTxt += " | "+item.point_desc;
					//}
				}
				
				vTxt += "</strong>";
				
				if(item.point_in_out.indexOf("-")>-1){
					vTxt += "<span class=\"point minus\">"+ CommaFormattedN(item.point_in_out) +"<em>점</em></span>";	
				}else{
					vTxt += "<span class=\"point\">"+ CommaFormattedN(item.point_in_out) +"<em>점</em></span>";
				}
				
				
				vTxt += "</li>";
			});
			//alert(vTxt);
			$("#refund_savingList").html(vTxt);
			$("#refund").show();
		}
	});
}

function getCouponInfo(gift_code){
	var vData = {"coupon_code" : gift_code};
	
	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_detail_info.jsp",
		data : vData,
		dataType:"JSON",
		success: function(json){
			if(json.RESULTCODE == "00"){
				$(".thum").html("<img src=\"https://image.multicon.co.kr/"+ json.COMP_CODE +"/"+ json.MENU_CODE +"/0002.jpg\" onerror=\"fn_img(this,'https://image.multicon.co.kr/"+ json.COMP_CODE +"/"+ json.MENU_CODE +"/0001.jpg');\" />");
				$("#thum_name").text(json.COUPONNAME);
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
		
	});
}

function getShopname(shop_code){
	var vReturn_shopname = "";

	//옥션,지마켓,11번가,인터파크,CJmall,GS SHOP,티몬
	//4027,536,5910,55,806,75,6641
	if(shop_code == "4027"){
		vReturn_shopname = "옥션";
	}else if(shop_code == "536"){
		vReturn_shopname = "G마켓";
	}else if(shop_code == "5910"){
		vReturn_shopname = "11번가";
	}else if(shop_code == "55"){
		vReturn_shopname = "인터파크";
	}else if(shop_code == "806"){
		vReturn_shopname = "CJmall";
	}else if(shop_code == "75"){
		vReturn_shopname = "GS SHOP";
	}else if(shop_code == "6641"){
		vReturn_shopname = "티몬";
	}
	
		
	return vReturn_shopname;
}

function getEndlist(){
	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_endlist.jsp",
		async: false,
		dataType:"JSON",
		success: function(data){
			$("#loselist").html(null);
			var vTxt = ""; 
			
			for(var i=0;i<30;i++){
				var today = new Date(); 

				today.setDate(today.getDate() + i); //i 일 더하여 setting

				var year = today.getFullYear();
				var month = today.getMonth() + 1;
				var day = today.getDate();
				
				if(month < 10){
					month = "0"+month;
				} 
				if(day < 10){
					day = "0"+day;
				} 
				
				var vDate = year+"-"+month+"-"+day;
				
				vTxt += "<li id=\"date_"+ vDate +"\"><span class=\"day\">"+ vDate +"</span><em id=\"txt_"+ vDate +"\">-</em></li>";					
			}
			
			$("#loselist").html(vTxt); 

			var vEnd_point = 0;
			$.each(data.endlist, function(i, item) {
				try{
					$("#date_"+item.point_expire_date).html($("#date_"+item.point_expire_date).html()+"<strong>"+ CommaFormattedN(item.point_remain) +"</strong>점 소멸예정");
					$("#txt_"+item.point_expire_date).hide();
				
					vEnd_point += parseInt(item.point_remain);
				}catch(e){}
			});
			
			if(vEnd_point > 0){
				$("#end_point").text(CommaFormattedN(vEnd_point)+" 점");
			}else{
				$(".btn_view").hide();
			} 
			

		}, 
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
	});
}

function onoff(id) { 
	var mid=document.getElementById(id);
	if(mid.style.display=='') {
		mid.style.display='none';
		if(id == "mysave"){
			//$('body').unbind('touchmove');
			$('body').css({overflow:'auto', height:$(".wrap").height()});
		}
	}else{
		mid.style.display='';
		if(id == "mysave"){
			$('body').bind('touchmove', function(e) {
				//e.preventDefault(); 
				var heightCheck = $(window).height();
				$('body').css({overflow:'hidden',height:heightCheck});
			}); 
		}  
	}
}

//콤마 옵션
function CommaFormattedN(amount) {

    var delimiter = ","; 
    
    var i = parseInt(amount);

    if(isNaN(i)) { return ''; }
    
    var minus = '';
    
    if (i < 0) { minus = '-'; }
    
    i = Math.abs(i);
    
    var n = new String(i);
    var a = [];

    while(n.length > 3)
    {
        var nn = n.substr(n.length-3);
        a.unshift(nn);
        n = n.substr(0,n.length-3);
    }

    if (n.length > 0) { a.unshift(n); }

    n = a.join(delimiter);

    amount = minus + (n+ "");

    return amount;

}
function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
       var c = ca[i];
       while (c.charAt(0)==' ') c = c.substring(1);
       if(c.indexOf(name) == 0)
          return c.substring(name.length,c.length);
    }
    return "";
}
</script>
<%@ include file="/mobilefirst/include/common_logger.html"%>