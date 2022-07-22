<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="../include/m2_Base_Inc_Mobile.jsp"%>
<%@ include file="/mobilefirst/login/login_check_car.jsp"%>
<%
if(1==1){
	out.println("<script>alert('회원가입은 PC에서 가능합니다.');history.go(-1);</script>");
	return;
}else{


	String IMG_ENURI_COM = ConfigManager.IMG_ENURI_COM;
	String ConstServer = ConfigManager.ConstServer(request);

	String car_flag = ChkNull.chkStr(request.getParameter("car_flag"), "");

	String backUrl = ChkNull.chkStr(request.getParameter("backUrl"), "");

	// 1:로그인, 2:회원가입, 3:성인인증
	String pageType = ChkNull.chkStr(request.getParameter("pageType"), "1");
	String titleTxt = "로그인";
	if(pageType.equals("2")) {
		titleTxt = "회원가입";
	}
	if(pageType.equals("3")) {
		titleTxt = "성인인증";
	}

	HttpSession Mobilesession = request.getSession(true);

	String strPageType = ChkNull.chkStr(request.getParameter("pagetype"),"login"); 
	String strQrcode = ChkNull.chkStr(request.getParameter("_qr"),"");  
	String strApp = ChkNull.chkStr(request.getParameter("app"),"");  
	String strFromNaver = ChkNull.chkStr((String)Mobilesession.getAttribute("fromNaver"),"");
 
	if(!strApp.equals("")){
		Mobilesession.setAttribute("enuriApp","Y");
	}else if(!ChkNull.chkStr((String)Mobilesession.getAttribute("enuriApp"),"").equals("")){
		Mobilesession.setAttribute("enuriApp","Y");
	}else{
		Mobilesession.setAttribute("enuriApp",""); 
	} 

	String strEnuriApp = ChkNull.chkStr((String)Mobilesession.getAttribute("enuriApp"),"");
	if(strEnuriApp.equals("Y")){
		strApp = "Y"; 
	}
	String listType = "";

	//out.println("loginId="+cb.GetCookie("MEM_INFO","USER_ID"));

	String iPhoneApp = "N";
	if(strApp.equals("Y") && (ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone")>=0 || 
		ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod")>=0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad")>=0)){
		iPhoneApp = "Y";
	}

//	 String referer = ChkNull.chkStr(request.getHeader("REFERER"), "no");
%>
<!doctype html>
<html <%if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0){%>style="-webkit-tap-highlight-color:rgba(0,0,0,0);"<%}%>>
<head>
<title><%=titleTxt%></title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width">
<link rel="stylesheet" href="css/login.css?ver=1.0" type="text/css">
<script type="text/javascript" src="<%=ConstServer%>/mobile2/js/jquery-1.6.4.min.js" charset="utf-8"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/localStorage.js"></script>
<script type="text/javascript" src="js/login.js?ver=1.0"></script>
<script type="text/javascript" src="<%=ConstServer%>/carm/js/src/spin.js"></script> 
<script type="text/javascript" src="<%=ConstServer%>/mobile2/js/m4_function.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=ConstServer%>/mobile2/js/kakaoLink.js?v1.0.0" charset="utf-8"></script>
<script language=javascript src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Header.js"></script>
<script language="JavaScript">
<!--
pageType = <%=pageType%>;
var ENURI_COM_SSL = "<%=ConfigManager.ENURI_COM_SSL%>";
var backUrl = "<%=backUrl%>";
var iPhoneApp = "<%=iPhoneApp%>";
var car_flag = "<%=car_flag%>";
-->
</script>
</head>
<body>
<div id="headerDiv">
	<%if(car_flag.equals("1")) {%>
	<div id="hLeftDiv"><div id="hLogoImg" class="carLogo"></div></div>
	<%} else {%>
	<div id="hLeftDiv"><div id="hLogoImg" class="mainLogo"></div></div>
	<%}%>
	<div id="hTitleDiv"><span><%=titleTxt%></span></div>
	<div id="hRightDiv"><img id="hPrevBtn" src="<%=IMG_ENURI_COM%>/images/mobile2/login/btn_prev.png" border="0"></div>
</div>

<div id="bodyDiv"></div>
<iframe id="hFrame" name="hFrame" frameborder="0" style="margin:0px;padding:0px;height:0px;width:0px;"></iframe>
<%if(!car_flag.equals("1")) {%>
<%@ include file="/mobilefirst/include/m4_bottom_menu.jsp"%>
<%}%>
</body>
</html>
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
<%}%>
