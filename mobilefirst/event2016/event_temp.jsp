<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
String browser = request.getHeader("User-Agent");

if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1 
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1 
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){

}else{
	//response.sendRedirect("/event/emoney/jsp/firstInstall_201604.jsp");	//pc url 
}

String chkId = ChkNull.chkStr(request.getParameter("chk_id"));
String strApp = ChkNull.chkStr(request.getParameter("app"),"");

String cUserId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

Members_Proc members_proc = new Members_Proc();

String cUsername = "";
String userArea = "";

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

//facebook 썸네일 관련
String strFb_title = "에누리 가격비교";
String strFb_description = "에누리 모바일 가격비교";
String strFb_img = "http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png";

//이벤트 설정
String strEvent_code = "2016050101";
String strEvent_name = "생활혜택";
String strEvent_class = "Attend";	//프로모션별 클래스 : 혜택 Benefit / 웰컴 Welcome / 출석 Attend / 구매 Buy / 추천 Recommend
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
	<meta property="og:title" content="<%=strFb_title %>">
	<meta property="og:description" content="<%=strFb_description %>">
	<meta property="og:image" content="<%=strFb_img %>">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/event/common_area.css"/>
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/event/filck.css">
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/flick.event.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/iscroll.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/event_common.js"></script> 
</head>

<body>

<div class="<%=strEvent_class %>">

<%@ include file="/mobilefirst/event2016/event_top.jsp" %>

<div style="height:300px;">각 프로모션 컨텐츠 영역</div>

<%@ include file="/mobilefirst/event2016/event_bottom.jsp" %>

</div>

</body>
</html>
<script>
var vEvent = "<%=strEvent_class %>"; 
var app = getCookie("appYN");
var vEvent_title = "이벤트 이름";
var vEvent_page = "/mobilefirst/event2016/event_temp.jsp";
var username = "<%=userArea%>";
var vChkId = "<%=chkId %>";

$(document).ready(function() {
	
	if(app =='Y' ){
		
		ga('send', 'pageview', {
			'page': vEvent_page,
			'title': vEvent_title+'_APP'
		});
		
	}else{
	
		ga('send', 'pageview', {
			'page': vEvent_page,
			'title': vEvent_title+'_WEB'
		});
	}
	
	if(islogin()){
		getPoint();
	}
	
	$( ".win_close" ).click(function(){
		if(app == 'Y'){
			window.location.href = "close://";
		}else{
			window.location.replace("/mobilefirst/Index.jsp");
		}
		
	});

	$(".my_e").click(function(){
	
		if(app == 'Y'){
			ga('send', 'event', '<%=strEvent_name %>_APP', 'button', '내 e머니 확인하기');
			location.href="/mobilefirst/emoney/emoney.jsp?&freetoken=emoney";
			return false;
		}else{
			ga('send', 'event', '<%=strEvent_name %>_WEB', 'button', '내 e머니 확인하기');
			$("#app_only").show();
		}
	
		//location.href="/mobilefirst/emoney/emoney.jsp?&freetoken=emoney";
	});

	$(".btn_login").click(function(){
		
		if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
			location.href = "/mobilefirst/login/login.jsp";
		}else	if(navigator.userAgent.indexOf("Android") > -1){
			location.href = "/mobilefirst/login/login.jsp?backUrl="+vEvent_page+"?freetoken=event&chk_id="+vChkId;
		}
		
	});
});

</script>
