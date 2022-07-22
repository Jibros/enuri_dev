<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Reward_Data"%>
<%@ page import="com.enuri.bean.mobile.Reward_Proc"%>
<jsp:useBean id="Reward_Data" class="Reward_Data" scope="page" />
<jsp:useBean id="Reward_Proc" class="Reward_Proc" scope="page" />
<%
	String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
	String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");
	
	String strChk_id = ChkNull.chkStr(request.getParameter("chk_id"),"");
	
	Cookie[] carr = request.getCookies();
	String strAppyn = "";
	String strVerios = "";
	String strVerand = "";
	String strAd_id = "";
	int intVerios = 0;
	 
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
		    	break;
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
		response.sendRedirect("/mobilefirst/Index.jsp");
	}
	
	strVerios = strVerios.replace(".","");
	strVerand = strVerand.replace(".","");
	
	response.sendRedirect("/mobilefirst/index.jsp");	
	
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/default.css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/mybag.css">
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
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
 
<div class="wrap">
	<nav>
		<ul class="sgnb">
			<li class="sgnb_btt btt_1"><a href="javascript:///" class="on">홈</a></li>
			<li class="sgnb_btt btt_2"><a href="javascript:///">라면교환소</a></li>
			<li class="sgnb_btt btt_3"><a href="javascript:///">쿠폰함</a></li>
			<li class="sgnb_btt btt_4"><a href="javascript:///">문의</a></li>
		</ul> 
	</nav>

	<section class="content">
		<div class="w_box">
			<span class="my"><em id="username"><%=cUserId %></em>님의 현황</span>
			<ul class="myzone">
				<li>라면쿠폰 교환권<strong id="point_remain"></strong></li>
				<li>지급예정 교환권<strong id="point_prefix"></strong></li>
			</ul>
			<span class="btnarea"><button type="button" class="btnok" id="btt_detail">상세내역확인</button></span>
			
			<div class="warning">
				2월 14일까지 교환하지 않은 라면쿠폰 교환권은<br /><strong>새로운 쇼핑혜택 <span>e</span>머니</strong>로 전환됩니다.
				<button type="button" id="btn_notice">자세히 보기</button>
			</div>
		</div>

		<div class="w_box">
			<div class="coupon">
				<p class="clicktxt"><strong>완성된 라면을 클릭하세요!</strong> 진짜 라면으로 교환하실 수 있습니다.</p>
				<ul class="coupon_list"></ul>
			</div>
		</div>
	</section>

</div>
</body> 
</html>
<script>
var vUserNick = "<%=(cUserNick.equals("")?cUserId:cUserNick) %>";
var remain = 0.0;	//적립금
var prefix = 0.0;	//적립예정

Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";
 
    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var d = this;
     
    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear();
            case "yy": return (d.getFullYear() % 1000).zf(2);
            case "MM": return (d.getMonth() + 1).zf(2);
            case "dd": return d.getDate().zf(2);
            case "E": return weekName[d.getDay()];
            case "HH": return d.getHours().zf(2);
            case "hh": return d.getHours().zf(2);
            case "mm": return d.getMinutes().zf(2);
            case "ss": return d.getSeconds().zf(2);
            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
            default: return $1;
        }
    });
};

String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};

var vChk_End = false;
var vAlert_txt = "라면적립 이벤트가 종료되어 교환권이 \'e머니\'로 전환되었습니다. \'e머니\' 서비스를 이용하기 위해서는 앱 업데이트가 필요합니다.\n\n업데이트 하시겠습니까?'";
var vAlert_aos = "※라면백 이벤트 종료※\n라면쿠폰은 쿠폰함에서 사용가능하며\n라면 교환권은 e머니로 교환됩니다.";
var vVerios = "<%=strVerios %>";
var vVerand = "<%=strVerand %>";

$(function() {
	
	var vNowtime = new Date().format("yyyyMMddhhmm");
	vNowtime = vNowtime * 1;
	
	var limit_time = 201602142359;
	//var limit_time = 201602141600;
	if(vNowtime > limit_time){
	

		
		vChk_End = true;
	}
	
	$("#username").text(vUserNick);
	
	getPoint();
	
	$(".sgnb_btt").click(function(e){
		 if($(this).hasClass("btt_1")){
			 location.href = "/mobilefirst/reward/reward_main.jsp?title=My%20%EB%9D%BC%EB%A9%B4%EB%B0%B1";
		 }else if($(this).hasClass("btt_2")){
			 alert(vAlert_aos);
		 }else if($(this).hasClass("btt_3")){
			 location.href = "/mobilefirst/reward/reward_coupon.jsp?title=My%20%EB%9D%BC%EB%A9%B4%EB%B0%B1";
		 }else if($(this).hasClass("btt_4")){
			 location.href = "/mobilefirst/reward/reward_cs.jsp?title=My%20%EB%9D%BC%EB%A9%B4%EB%B0%B1";
		 }
	});
	
	$("#btt_detail").click(function(e){
		location.href = "/mobilefirst/reward/reward_detail.jsp?title=%EC%83%81%EC%84%B8%EB%82%B4%EC%97%AD%20%ED%99%95%EC%9D%B8";
	});
	
	$("#btn_notice").click(function(e){
		location.href = "/mobilefirst/event/eventWonView.jsp?seq=44&freetoken=event&reward=Y";
	});
	
	ga('send', 'pageview', {
		'page': '/mobilefirst/reward/reward_main.jsp',
		'title': 'mf_라면백_홈'
	}); 
	
	if(window.android){		// 안드로이드
		if(vVerand != "" && Number(vVerand) < 304){
			if(confirm(vAlert_txt)>0){
    			window.location.href = "market://details?id=com.enuri.android";
    			//setTimeout("location.href='close://';", 2000);
    			return;
			}else{
				//window.location.href = "close://";	    				
			}
		}
	}else{					// 아이폰에서 호출
		if(vVerios != "" && Number(vVerios.substring(0,3)) < 304){
			if(confirm(vAlert_txt)>0){
    			window.location.href = "https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8&freetoken=outlink";
    			//setTimeout("location.href='close://';", 2000);
    			return;
			}else{
				//window.location.href = "close://";	    				
			}
		}
	}
});

function getPoint(){
	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/reward/reward_get_point.jsp",
		async: false,
		dataType:"JSON",
		success: function(json){
			remain = parseFloat(json.POINT_REMAIN);	//적립금
			prefix = parseFloat(json.POINT_PRE_FIX);	//적립예정
			
			//test
			//remain = 2;
			//prefix = 2.0;
			
			$("#point_remain").html(remain +"<em>개</em>");
			$("#point_prefix").html(prefix +"<em>개</em>");
	
			displayCoupon();	//show coupon;
		}
	});
}

function displayCoupon(){
	var vX = parseInt((parseInt(remain) + 3) / 3);
	var vHtml = "";
	var vImg = "coupon";
	//coupon_h , coupon_n, coupon
	
	if(vX < 2){
		vX = 2;
	}
	for(var i = 0; i < vX; i ++){
		for(var j = 1 ; j < 4; j ++){
			if(((i * 3)  + j) <= parseInt(remain)){	//정수랑 우선비교
				vImg = "coupon";
			}else{
				if(((i * 3)  + j) <= remain + 0.5){	//소수까지 비교
					vImg = "coupon_h";				
				}else{
					vImg = "coupon_n";
				}
			}
			vHtml += "<li><a href=\"javascript:///\"><img src=\"http://img.enuri.info/images/mobilefirst/reward/"+ vImg +".gif\" alt=\"\" class=\"coupon_btt\" id=\"cp_"+ ((i * 3)  + j) +"\"";
			if(vImg == "coupon"){
				vHtml += " onclick=\"goStore()\" ";
			}
			vHtml += "/></a></li>";
		}
	}
	$(".coupon_list").html(vHtml);
	
	$(".coupon_btt").click(function(){
		var img_nm = $(this).attr("src");
		
		if(img_nm.indexOf("coupon.gif") >  -1){
			if(vChk_End){
				 alert(vAlert_txt);				 
			}else{
				 location.href="/mobilefirst/reward/reward_store.jsp?title=My%20%EB%9D%BC%EB%A9%B4%EB%B0%B1";
			}
		}
	});
}

function goStore(){
	$(".sgnb_btt.btt_2").click();
}

function bannerClick(){
	ga('send', 'event', 'mf_myramen', '홈', '라면이벤트 보러가기');
	location.href = "/mobilefirst/event/ramen_event_eve.jsp?freetoken=event";
}

function bannerClick2(){
	ga('send', 'event', 'mf_myramen', '홈', '1월 페이백_MY 라면백 하단띠');
	location.href = "/mobilefirst/event/event_payback.jsp?freetoken=event";
}
</script>