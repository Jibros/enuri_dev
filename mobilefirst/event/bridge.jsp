<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%
//response.sendRedirect("intent://#Intent;scheme=enuri;package=com.enuri.android;end");

//response.sendRedirect("intent://#Intent;scheme=enuri;package=com.enuri.android;end");

/*
	String strType = ChkNull.chkStr(request.getParameter("type"),"");
	
if(	ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0  ){
		if(strType.equals("1")){
			response.sendRedirect("http://api2.tnkfactory.com/tnk/api/ref/v1/6451/129317716");			
		}else{
			response.sendRedirect("market://details?id=com.enuri.android");
		}	
	}else if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0 ){
		response.sendRedirect("https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8");
	}
	
	
	String browser = request.getHeader("User-Agent");
		
		System.out.println(browser);
		System.out.println(browser.indexOf("Chrome"));
	 if(browser.indexOf("Chrome") > 0  ){
	 	response.sendRedirect("market://details?id=com.enuri.android");
	 }
	
*/	 
	 
	 String from = ChkNull.chkStr(request.getParameter("from"),"");
	 
	 String gateUrl = "";
	 
	 if(from.equals("gate")){
	 	gateUrl = "http://api2.tnkfactory.com/tnk/api/ref/v1/6451/21210";
	 }else{
	 	gateUrl = "http://api2.tnkfactory.com/tnk/api/ref/v1/6451/21209";
	 }
	 
%>   
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
</head>
<body>
<div style="width: 250px; height: 60px; margin:-30px auto 0 -125px; position: absolute; left: 50%; top: 50%; text-align:center;" >
	<a href="intent://#Intent;scheme=enuri;package=com.enuri.android;end" id="gogo">
		에누리 앱 실행중 입니다.....</br> 자동 에누리 앱이 실행 되지 않을 경우 클릭해주세요. 
	</a>
</div>
</body>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/Osinfo.js"></script>
<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		//런칭할때 UA-52658695-3 으로 변경
		ga('create', 'UA-52658695-3', 'auto');
	</script>
<script>

var ios_appstoreUrl = "https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8";
var ios_appUrl = "enuri://";
 
//url 은 “naversearchapp://search?qmenu=voicerecg&version=1”  
function runApp_ios() {
    var clickedAt = +new Date;
 
    var naverAppCheckTimer = setTimeout(function () {
        if (+new Date - clickedAt < 2000)
            //if (window.confirm("에누리 최신 버전 앱 설치되어 있지 않습니다.\n설치페이지로 이동하시겠습니까?"))
                location.href = ios_appstoreUrl;
    }
        , 1500);

	//location.href = ios_appUrl;
	
    var iframe = document.createElement("iframe");
    iframe.style.border = "none";
    iframe.style.width = "0px";
    iframe.style.height = "0px";
    iframe.onload = function () {
        document.location = ios_appUrl;
    };
    iframe.src = android_appUrl;
    document.body.appendChild(iframe);
	


}
 
//여기까지 IOS
 
 
//var android_marketUrl = "market://details?id=com.google.zxing.client.android";
//var android_appUrl = "zxing://scan";
//var android_intent = "intent://scan/#Intent;scheme=zxing;package=com.google.zxing.client.android;end";
 
var android_marketUrl = "<%=gateUrl%>";
var android_appUrl = "enuri://";
//var android_intent = "intent://#Intent;scheme=enuri;package=com.enuri.android;end";
var android_intent = "https://nk63e.app.goo.gl/IgMa";

//var android_intent = "intent://#Intent;scheme=enuri;package=com.enuri.android;end";

 
 
var timer;
var heartbeat;
var iframe_timer;
 
function clearTimers() {
    clearTimeout(timer);
    clearTimeout(heartbeat);
    clearTimeout(iframe_timer);
}
 
function intervalHeartbeat() {
    if (document.webkitHidden || document.hidden) {
        clearTimers();
    }
}
 
function tryIframeApproach() {

    var iframe = document.createElement("iframe");
    iframe.style.border = "none";
    iframe.style.width = "0px";
    iframe.style.height = "0px";
    iframe.onload = function () {
        document.location = android_marketUrl;
    };
    iframe.src = android_appUrl;
    document.body.appendChild(iframe);

	iframe.submit();
}
 
function tryWebkitApproach() {
    document.location = android_appUrl;
    timer = setTimeout(function () {
        document.location = android_marketUrl;
    }, 2500);
}
 
function useIntent() {
	
	/*
	setTimeout(function () {
		//document.location.href = android_intent;
		location.replace(android_intent);
    }, 1500);
	
	//location.replace(android_intent);
	
	$("#gogo").trigger("click");
	*/
	
	//$("#gogo").trigger("click");
	
	alert(android_intent);
	document.location.href = android_intent;
	
}
 
function launch_app_or_alt_url(el) {
    //heartbeat = setInterval(intervalHeartbeat, 200);
	
    if (navigator.userAgent.match(/Chrome/)) {
        useIntent();

    } else if (navigator.userAgent.match(/Firefox/)) {
        tryWebkitApproach();
        iframe_timer = setTimeout(function () {

            tryIframeApproach();
        }, 1500);
    } else {
        tryIframeApproach();
    }
}
 
 
 
 
 
function runApp() {
    var devName = OSInfoDev();

    if (devName.indexOf("MacOS") != -1) {

        runApp_ios();
	
    }
    else if (devName.indexOf("Android") != -1) {

        launch_app_or_alt_url($(this));
	
        event.preventDefault();
    }
 	
	//self.close();
 
}


jQuery(document).ready(function($) {
	
	var gate = "<%=from%>"+"";
	
	if(gate.indexOf("gate") > -1){
		insertLog('12621');
		ga('send', 'event', 'mf_event', 'event_20150727_설치', '광고 gate');
	}
	
	runApp();
		
});

function insertLog(logNum){
	$.ajax({
		type: "GET",
		url: "/view/Loginsert_2010.jsp",
		data: "kind="+logNum,
		success: function(result){
		
		}
	});
}




</script>
</html>