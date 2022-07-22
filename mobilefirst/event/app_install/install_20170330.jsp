<%@ page contentType="text/html; charset=utf-8" %>
<%@include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
	String chkId = ChkNull.chkStr(request.getParameter("chk_id"));

%>
<!DOCTYPE html> 

<html lang="ko"><head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" type="text/css" href="http://dev.enuri.com/mobilefirst/css/default.css">
	<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
</head>
<body style="background-color:#fbe55b !important">

<div id="wrap">
	<a onclick="goClose()" href="#" class="close" style="position:absolute; right:0px; top:0px) 0 0 no-repeat; background-size:contain; width:56px; height:56px; text-indent: -9999em;">닫기</a>

	<ul>
		<li><img src="http://imgenuri.enuri.gscdn.com/images/event/2017/app_img/app_first_0330.jpg" width="100%" alt="" id="btntop"></li>
	</ul>
</div>

</body>
</html>

<script language="javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	//런칭할때 UA-52658695-3 으로 변경
	ga('create', 'UA-52658695-3', 'auto');

function isiPhone(){
    return (
        //Detect iPhone
        (navigator.platform.indexOf("iPhone") != -1) ||
        //Detect iPod
        (navigator.platform.indexOf("iPod") != -1) ||
        //Detect iPod
        (navigator.platform.indexOf("iPad") != -1)
    );
}
$(function() {	
	
var chkId = "<%=chkId%>";
	$("#btntop").click(function(){
		ga('send','event','mf_event','첫설치친구초대','이동');
		window.location.href = "/mobilefirst/evt/welcome_event.jsp?tab=1&freetoken=event";
 	});
});

function goClose(){
	ga('send','event','mf_event','닫기_첫설치','이동');
	window.location.href = "close://";
}
</script>