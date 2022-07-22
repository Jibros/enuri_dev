<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
String browser = request.getHeader("User-Agent");

if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1 
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1 
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){

}else{
	response.sendRedirect("/event2018/tabletAppBuy_201805.jsp");	//pc url 
}
String chkId   = ChkNull.chkStr(request.getParameter("chk_id"),"");
String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

Members_Proc members_proc = new Members_Proc();
String cUsername = members_proc.getUserName(cUserId);
String userArea = cUsername;

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;

    if(cUsername.equals("")) userArea = cUserNick;
    if(userArea.equals(""))  userArea = cUserId;
}

SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");	//오늘 날짜
String strToday = formatter.format(new Date());
String sdt = ChkNull.chkStr(request.getParameter("sdt"));

if(!"".equals(sdt) && request.getServerName().equals("dev.enuri.com")){
	strToday = sdt;
}

String strUrl = request.getRequestURI();
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/tablet_app_m.css">
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/lib/animate.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="http://m.enuri.com/mobilefirst/css/lib/slick.css"/>
	<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/common/js/function.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
</head>
<body>

<div class="wrap">

	<div class="myarea">
	<%if(cUserId.equals("")){%>	
	<p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>	
	<%}else{%>
	<p class="name"><%=userArea%> 님<span id="my_emoney">0점</span></p>
	<%}%>
	<a href="javascript:;" class="win_close">창닫기</a>
	</div>
	
	<!-- 상단비주얼 -->
	<div class="visual">
		<div class="contents">
			<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/tablet_app/m_visual.png" alt="격한 흥행! 검은사막 모바일 태블릿PC 크게 즐기자!" class="imgs">
			<div class="blind">
				<h1>검은사막 모바일 태블릿PC로 크게 즐기자!</h1>
			</div>
		</div>
	</div>

	<div class="section promotionwrap">
		<div class="contents">
			<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/tablet_app/m_promotion_info.jpg" alt="구글 플레이 카드 이미지" class="imgs">
			<div class="blind">
				<h2>APP에서 태블릿PC 구매하고 구글 플레이 카드 획득!</h2>
				<p>1등 한명! 구글 플레이 카드 (10만원권)</p>
				<ol>
					<li>구글 플레이 카드 5만원권 2등(3명)</li>
					<li>구글 플레이 카드 3만원권 3등(5명)</li>
					<li>구글 플레이 카드 1만원권 행운상(10명)</li>
				</ol>
			</div>
			
			<div class="btn__group">
				<a id="btn_event2_app" href="javascript:void(0);" class="btn"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/tablet_app/m_promotion_buy.jpg" alt="태블릿PC 구매하기" class="imgs"></a>
				<a id="btn_event2" href="javascript:void(0);" class="btn"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/tablet_app/m_promotion_join.jpg" alt="응모하기" class="imgs"></a>
			</div>
			
			<ul class="promotion__info">
				<li>이벤트 참여 및 구매 기간 : 2018년 5월 4일 ~ 5월 14일</li>
				<li>당첨자 발표 : 2018년 6월 15일</li>
				<li class="emp">응모 시 휴대폰번호를 잘못 기입했거나 연락이 되지 않아 발생하는 불이익에 대해서는 책임지지 않습니다.</li>
			</ul>
			
			<a href="javascript:void(0);" class="btn__caution" onclick="onoff('notetxt2'); $('html,body').stop().animate({scrollTop : 0},300); return false;">꼭 확인하세요</a>
		</div>
	</div>

	<div id="giftWrap1" class="giftWrap">
		<div class="heads">
			<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/tablet_app/m_gift_title1.jpg" class="imgs" alt="태블릿PC 점유율 1위 아이패드"></h2>
		</div>
		<div class="contents">
			<!-- items_area -->
			<div class="items_area">
				<ul class="itemlist">
				</ul>
				<a href="jacascript:void(0);" onclick="window.open('/mobilefirst/list.jsp?cate=0305&freetoken=list');" class="itemlist_more"><span>상품 더보기</span></a>
			</div>
			<!-- items_area -->
		</div>
	</div>
	<div id="giftWrap2" class="giftWrap">
		<div class="heads">
			<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/tablet_app/m_gift_title2.jpg" class="imgs" alt="AS는 삼성이 제일!! 삼성 태블릿PC"></h2>
		</div>
		<div class="contents">
			<!-- items_area -->
			<div class="items_area">
				<ul class="itemlist">
				</ul>
				<a href="jacascript:void(0);" onclick="window.open('/mobilefirst/list.jsp?cate=0305&freetoken=list');" class="itemlist_more"><span>상품 더보기</span></a>
			</div>
			<!-- items_area -->
		</div>
	</div>
	<div id="giftWrap3" class="giftWrap">
		<div class="heads">
			<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/tablet_app/m_gift_title3.jpg" class="imgs" alt="업무 생산량은 서피스로 UP! 뉴 서피스 프로"></h2>
		</div>
		<div class="contents">
			<!-- items_area -->
			<div class="items_area">
				<ul class="itemlist">
				</ul>
				<a href="jacascript:void(0);" onclick="window.open('/mobilefirst/list.jsp?cate=0305&freetoken=list');" class="itemlist_more"><span>상품 더보기</span></a>
			</div>
			<!-- items_area -->
		</div>
	</div>
	<div id="giftWrap4" class="giftWrap">
		<div class="heads">
			<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/tablet_app/m_gift_title4.jpg" class="imgs" alt="합리적인 가격의 태블릿PC는? 가성비 뿜뿜!!"></h2>
		</div>
		<div class="contents">
			<!-- items_area -->
			<div class="items_area">
				<ul class="itemlist">
				</ul>
				<a href="jacascript:void(0);" onclick="window.open('/mobilefirst/list.jsp?cate=0305&freetoken=list');" class="itemlist_more"><span>상품 더보기</span></a>
			</div>
			<!-- items_area -->
		</div>
	</div>
</div>
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:;" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();">설치하기</button></p>
	</div>
</div>

<div class="layer_back nofix" id="notetxt2" style="display:none;">
	<div class="dim"></div>
	<div class="noteLayer no_fixed">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt2');return false;">창닫기</a>
	
		<div class="inner">
			<dl class="txtlist">
				<dt>이벤트/구매 기간 :</dt>
				<dd>2018년 5월 4일 ~ 5월 14일</dd>
			</dl>
			
			<dl class="txtlist">
				<dt>경품 : </dt>
				<dd>1등: 구글 플레이카드 10만원권 (1명 추첨)</dd> 
					<dd>2등: 구글 플레이카드 5만원권 (3명 추첨)</dd>
					<dd>3등: 구글 플레이카드 3만원권 (5명 추첨)</dd>
					<dd>행운상: 구글 플레이카드 1만원권 (10명 추첨)</dd>
				<dd><strong class="emp">이벤트 응모시 입력한 e-메일 주소를 통해 구글 플레이카드 코드 전송</strong><br><u>※ 제세공과금 당첨자 부담</u><br><u>※ 사정에 따라 경품이 변경될 수 있습니다.</u></dd>
			</dl>
	
			<dl class="txtlist">
				<dt>당첨자 발표 및 적립</dt>
				<dd>2018년 6월 15일</dd>
			</dl>
			
			<dl class="txtlist">
				<dt>이벤트 유의사항</dt>
				<dd>본 이벤트는 에누리 APP을 이용해 ‘태블릿PC’를 구매한 경우에만 참여가 가능합니다.</dd>
				<dd><strong class="emp">응모 시 입력한 휴대폰번호로 개별연락 드리며 휴대폰 번호나 e-메일 등 잘못된 정보를 기입했거나 연락이 되지 않아 발생하는 불이익에 대해서는 책임지지 않습니다.</strong></dd>
			</dl>
				
			<dl class="txtlist">
				<dt>아래의 경우에는 구매 확인 및 당첨이 불가합니다.</dt>
				<dd>에누리 가격비교 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱으로 결제만 한 경우 (에누리 가격비교 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)</dd>
				<dd>에누리 가격비교 앱 미 로그인 후 구매한 경우 또는 에누리 가격비교 PC, 모바일 웹에서 구매한 경우</dd>
				<dd>이벤트 대상 품목인 '태블릿PC' 이외의 물건을 구입 후 이벤트에 응모한 경우</dd>
			</dl>
			
			<dl class="txtlist">
				<dt>유의사항</dt>
				<dd>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</dd>
			</dl>
		</div>
		<p class="btn_close"><button type="button" onclick="onoff('notetxt2');return false;">닫기</button></p>
	</div>
</div>

	<!-- 2018-03-12 이벤트 응모하기 레이어 --> 
<div class="event_layer" id="eventJoin" style="display:none">
	<div class="inner_layer">
		<div class="head">
			<h2 class="p_tit stripe_layer">이벤트 응모하기</h2>
		</div>
		<h3 class="tit stripe_layer">참여해주셔서 감사합니다. 당첨 시 경품배송을 위해 정확한 정보를 입력해 주세요.</h3>
		<a href="javascript:;" class="stripe_layer close" onclick="onoff('eventJoin')">창닫기</a>

		<div class="viewer">
			<fieldset>
				<legend>경품 발송을 위한 정보 입력</legend>
				<label>
					<p>휴대폰번호</p>
					<input type="number" id="u_phone" name="event_phone" class="ipt_box" max="11" value="" placeholder="휴대폰 번호를 입력해 주세요" />
				</label>
				<label>
				<p>e-메일 주소</p>
					<input type="text" id="u_email" name="event_email" class="ipt_box" value="" placeholder="e-메일 주소를 입력해주세요">
				</label>
				<div class="agree_chk">
					<span class="unchk" onclick="agreechk(this);"><input type="checkbox" id="chkagree" name="agreechk" value="Y">위 개인 정보 활용에 동의 합니다.</span>
					<a href="javascript:;" class="btn_detail stripe_layer" onclick="onoff('privacy')">자세히보기</a>
				</div>
			</fieldset>
		</div>
		<p class="btn_close"><button type="button" id="btn_event2_ok" class="stripe_layer complete">응모완료</button></p>

		<p class="caution_info stripe_layer">
			<strong>꼭 알아두세요!</strong>
			입력하신 정보는 당첨자의 확인 및 경품 발송을 위해서만 이용 후 파기합니다.<br />잘못된 정보 입력으로 인한 경품 수령의 불이익은 책임지지 않습니다
		</p>
	</div>
</div>

<!-- 2018-03-12 개인정보 수집 이용안내 레이어 --> 
<div class="event_layer" id="privacy" style="display:none">
	<div class="inner_layer privacy">
		<h3 class="tit stripe_layer">개인정보 수집·이용안내</h3>
		<a href="javascript:;" class="stripe_layer close" onclick="onoff('privacy')">창닫기</a>

		<div class="viewer">
			<!-- 개인정보 -->
			<div class="privacy__area">
				<p>에누리 가격비교는 이벤트 참여확인 및 경품 발송을 위하여 아래와 같이 개인 정보를 수집하고 있습니다. </p>
				<dl>
					<dt>1. 개인정보 수집 항목</dt>
					<dd>휴대폰 번호, 회원ID,e-메일 주소, 참여 일시</dd>
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

<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>

</body>
</html>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
<script>
var vOs_type = "";
var vEvent_page = "<%=strUrl%>"; //경로
var vChkId = "<%=chkId%>";
var app = getCookie("appYN"); //app인지 여부

if(app == "Y"){
	 if(navigator.userAgent.indexOf("Android") > -1){
		 vOs_type = "MAA"; 		
	 }else{
		 vOs_type = "MAI"; 				 
	 }
}else{	
	 if(navigator.userAgent.indexOf("Android") > -1){
		 vOs_type = "MWA"; 		
	 }else{
		 vOs_type = "MWI"; 				 
	 }
}

var ajaxUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=14";
if(location.host.indexOf("my.enuri.com") > -1) {
	ajaxUrl = "./test.json";
}

//전체 상품 데이터f
var	ajaxData = (function() {
    var json = new Array();
    $.ajax({
        'async': false,
        'global': false,
        'url': ajaxUrl,
        'dataType': "json",
        'success': function (data) {
        	json = data["T"];
        }
    });
    return json;
})();

$(function(){ 
	$(".btn_login").click(function(){
		goLogin();       
    });
	getList(ajaxData);

	$("#btn_event2_app").click(function(){
		if(app =='Y'){
			ga('send', 'event', 'mf_event', '태블릿PC', '구매하기');
			window.open('/mobilefirst/list.jsp?cate=0305&freetoken=list');
			return false;
		}else{
			$("#app_only").show();
			return false;
		}
	});
	
	$("#btn_event2").click(function(){
		if(!islogin()){
			alert("로그인 후 이용 가능합니다.");
			goLogin();
			return false;
		}else{
			if(app =='Y'){
				ga('send', 'event', 'mf_event', '태블릿PC', '응모하기');
				getEventAjaxData({"procCode":3}, function(data){
					var result = data.result;
					if(result == 1) {
						alert("이미 응모하셨습니다.\n앱에서 구매 시\n구매내역 자동 누적됩니다.");
						return false;
					}else if(result == 0) {
						$("#u_phone").val("");
						$("#u_email").val("");
						$("#eventJoin").show();
					}
				});
			}else{
				$("#app_only").show();
				return false;
			}
		}
	});

	//앱에서 구매후 응모 파라미터
	var appBuyParams = function(){
		var uphone = $("#u_phone").val();
		var uemail = $("#u_email").val();
		var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;//전화번호 체크
		
		if(!uphone){
			alert("휴대폰 번호를 입력해주세요.");
			return false;
		}else if(!regExp.test(uphone)){
			alert("연락처를 정확히 입력해주세요");
			return false;
		}else if(!uemail){
			alert("e-메일 주소를 입력해주세요.");
			return false;
		}else if(!isValidEmail(uemail)){
			alert("e-메일 주소를 정확히 입력해주세요.");
			return false;
		}
		else if($("div.agree_chk > span").attr("class")=="unchk"){
			alert("경품 배송을 위해 개인정보 활용 동의해주세요");
			return false;
		}else{
			return {
				"procCode" : 2 ,
				uphone : uphone,
				uemail : uemail
			};
		}
	};
	
	$("#btn_event2_ok").click(function(){
		getEventAjaxData(appBuyParams, function(data){
			var result = data.result;
			if(result == -1) {
				alert("이미 응모하셨습니다.\n앱에서 구매 시\n구매내역 자동 누적됩니다.");
				$("#eventJoin").hide();
				return false;
			}else if(result == 1) {
				alert("응모가\n완료 되었습니다.");
				$("#eventJoin").hide();
				return false;
			}
		});
	});
	
	//getPoint();

	//닫기버튼
	$( ".win_close" ).click(function(){
		if(app == 'Y'){
			window.location.href = "close://";
		}else{
			window.location.replace("/mobilefirst/Index.jsp");
		}
	});
});

function numberWithCommas(x) {   return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");		}
function onoff(id) {var mid=document.getElementById(id);if(mid.style.display=='') 	mid.style.display='none';else mid.style.display='';}
function openLayer(IdName){	var pop = document.getElementById(IdName);	pop.style.display = "block";}
function closeLayer(IdName){	var pop = document.getElementById(IdName);		pop.style.display = "none";	}

var isClick = true;
function getEventAjaxData(params, callback){
	var sdt = "<%=strToday%>";
	if(sdt < "20180504"){
		alert('오픈예정입니다.');
		return false;
	}
	if(sdt > "20180514"){
		alert('이벤트가 종료되었습니다.');
		return false;
	}
	
	if(!islogin()){
		alert("로그인 후 이용 가능합니다.");
		goLogin();
		return false;
	}else{
		var evtUrl = "/mobilefirst/evt/ajax/tabletAppBuy_201805_setlist.jsp";
		if(typeof params === "object") {
			params.sdt = sdt;
			params.osType = vOs_type;

			$.post(evtUrl,params,callback,"json").done(function(){
				isClick = true;
			});
			
		}else if(typeof params === "function"){
			addParams = params();

			if(addParams){
				$.post(evtUrl , $.extend({sdt : "<%=sdt%>" , osType : vOs_type}, addParams),	callback, "json").done(function(){
					isClick = true;
				});
			}
		}
	    if(!isClick){
	    	return false;
	    }
	    isClick = false;
	}
}

function islogin() {
	var cName = "LSTATUS";
	var s = document.cookie.indexOf(cName +'=');
	if (s != -1){
		s += cName.length + 1;
		e = document.cookie.indexOf(';',s);
		if (e == -1){
			e 	= document.cookie.length;
		}
		if( unescape(document.cookie.substring(s,e))=="Y"){
			
			try {
				if(window.android){
						window.android.isLogin("true");
				}
			} catch(e) {}
			return true;
		}else{
			try {
				if(window.android){
					window.android.isLogin("false");
				}
			} catch(e) {}
			return false;
		}
	}else{
		try {
			if(window.android){
				window.android.isLogin("false");
			}	
		} catch(e) {}
		return false;
	}
}

//로그인페이지 이동
function goLogin(){
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        if(app =='Y'){
        	location.href = "/mobilefirst/login/login.jsp";          	
       }
        else{
        	location.href = "/mobilefirst/login/login.jsp?backUrl="+vEvent_page;          	
        }
    }else if(navigator.userAgent.indexOf("Android") > -1){
        location.href = "/mobilefirst/login/login.jsp?backUrl="+vEvent_page+"?freetoken=event&chk_id="+vChkId;
    }       
}

function getCookie(c_name) {
	var i,x,y,ARRcookies=document.cookie.split(";");
	for(i=0;i<ARRcookies.length;i++) {
		x = ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
		y = ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
		x = x.replace(/^\s+|\s+$/g,"");
		if(x==c_name) {
			return unescape(y);
		}
	}
}

/*레이어*/
function onoff(id){
	var mid = $("#"+id);
	if(mid.css("display") !== "none"){
		mid.css("display","none");
	}else{
		mid.css("display","");
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

function getList(jsonData){
	var goodsData;
	var html="";
	var goods_minprice = "";
	$.each(jsonData,function(index,goodsList){
		html = "";
		goodsData = goodsList["GOODS"];
		for(var i=0; i<goodsData.length;i++){
			if(goodsData[i]["MINPRICE"] == 0){
				goods_minprice ="<b>품절</b>";
			}else{
				goods_minprice = "<b>"+goodsData[i]["MINPRICE"].NumberFormat()+"</b>원";
			}
			html += "<li>";
			html += "	<a href=\"javascript:;\" onclick=\"window.open('/mobilefirst/detail.jsp?modelno="+goodsData[i]["MODELNO"]+"&freetoken=vip');\" target=\"_blank\" title=\"새 탭에서 열립니다.\" class=\"btn\">";
			html += "		<div class=\"imgs\">";
			html += "			<img src=\""+goodsData[i]["GOODS_IMG"]+"\" alt=\"\">";
			html += "		</div>";
			html += "		<div class=\"info\">";
			html += "			<p class=\"pname\">"+goodsData[i]["TITLE1"]+"<br>"+goodsData[i]["TITLE2"]+"</p>";
			html += "			<p class=\"price\"><span class=\"lowst\">최저가</span>"+goods_minprice+"</p>";
			html += "		</div>";
			html += "	</a>";
			html += "</li>";
		}
		$("#giftWrap"+(index+1)+" .contents .items_area .itemlist").html(html);
	});
	
}
//앱설치버튼
function install_btt(){

	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8';
    }else if(navigator.userAgent.indexOf("Android") > -1){
    	window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
    }
}

</script>