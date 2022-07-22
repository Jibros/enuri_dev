<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page language="java" import="Kisinfo.Check.CPClient"%>
<%@ page language="java" import="Kisinfo.Check.IPIN2Client"%>
<%@ include file="/member/join/auth/checkPlus_Conf.jsp"%>
<%@ include file="/member/join/auth/iPin_Conf.jsp"%>
<%
	String ENURI_COM_SSL = "https://m.enuri.com";

	String serverName = request.getServerName();
	if(serverName.indexOf("stagedev.enuri.com")>-1) {
		ENURI_COM_SSL = "https://"+serverName;
	}else if(serverName.indexOf("100.100.100.151")>-1 || serverName.indexOf("dev.enuri.com")>-1){
		ENURI_COM_SSL = "https://"+serverName;
	}else{
		ENURI_COM_SSL = "https://"+serverName;
	}

//ssl아님
String strRtnUrl = ChkNull.chkStr(request.getParameter("url"),""); //return opener's url
String strRtnFunc = ChkNull.chkStr(request.getParameter("func"),""); //return opener's function

//out.println("strRtnUrl: " + strRtnUrl);
//out.println("strRtnFunc: " + strRtnFunc);


String userid   = cb.GetCookie("MEM_INFO", "USER_ID");
String strAdult = cb.GetCookie("MEM_INFO", "ADULT"); //성인여부 (0:미성년자, 1:성인, 2:판단불가-판매자 또는 주민번호 없이 가입)

/** 본인인증 모듈 =================================================================================**/
	CPClient kisCrypt = new CPClient();
	CPClient kisCrypt_pwd = new CPClient();
	String sSiteCode = strCheckConf_code;		// NICE로부터 부여받은 사이트 코드
	String sSitePassword = strCheckConf_pwd;		// NICE로부터 부여받은 사이트 패스워드
	String sRequestNumber = "";    // 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
	sRequestNumber = kisCrypt.getRequestNO(sSiteCode);
	String sAuthType = "";      	// 없으면 기본 선택화면, X: 공인인증서, M: 핸드폰, C: 신용카드

	HttpSession ttsession = request.getSession(true);
	ttsession.setAttribute("REQ_SEQ", sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.

	// CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
	//String sReturnUrl 	= ConfigManager.ENURI_COM_SSL+"/member/join/auth/myCheckPlus.jsp?re=s"; // 성공시 이동될 URL
	//String sErrorUrl 	= ConfigManager.ENURI_COM_SSL+"/member/join/auth/myCheckPlus.jsp?re=f"; // 실패시 이동될 URL
	String sReturnUrl 	= ENURI_COM_SSL+"/mobilefirst/member/myCheckPlus.jsp?re=s"; // 성공시 이동될 URL
	String sErrorUrl 	= ENURI_COM_SSL+"/mobilefirst/member/myCheckPlus.jsp?re=f"; // 실패시 이동될 URL


	// 입력될 plain 데이타를 만든다.
	String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
	                    "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
	                    "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
	                    "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
	                    "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl;
	String sMessage = "";
	String sEncData = "";

	int iReturn = kisCrypt.fnEncode(sSiteCode, sSitePassword, sPlainData);

	if( iReturn == 0 ){
	    sEncData = kisCrypt.getCipherData();
	}else if( iReturn == -1){
	    sMessage = "암호화 시스템 에러입니다.";
	}else if( iReturn == -2){
	    sMessage = "암호화 처리오류입니다.";
	}else if( iReturn == -3){
	    sMessage = "암호화 데이터 오류입니다.";
	}else if( iReturn == -9){
	    sMessage = "입력 데이터 오류입니다.";
	}else{
	    sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
	}
/** 본인인증 모듈 끝 =================================================================================**/
/** 아이핀 인증 모듈 =================================================================================**/
	IPIN2Client pClient = new IPIN2Client();
	String sSiteCode_ip	= strIpinConf_code;		// 가상주민번호서비스 고객사이트 구분코드 (한국신용평가정보에서 발급한 사이트 코드)
	String sSitePw		= strIpinConf_pwd;		// 가상주민번호서비스 고객사이트 비밀번호 (한국신용평가정보에서 발급한 사이트 비밀번호)
	String sCPRequest 	= pClient.getRequestNO(sSiteCode_ip);

	ttsession.setAttribute("CPREQUEST", sCPRequest);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.

	String sEncData_ipin			= "";			// 암호화 된 데이타
	String sRtnMsg					= "";			// 처리결과 메세지
	String sRtnMsg_pwd				= "";			// 처리결과 메세지
	String sReturnURL				= ConfigManager.ENURI_COM_SSL+"/login/Adult_iPin.jsp";

	int iRtn = pClient.fnRequest(sSiteCode_ip, sSitePw, sCPRequest, sReturnURL);

	if (iRtn == 0){
		sEncData_ipin = pClient.getCipherData();
	} else if (iRtn == -1 || iRtn == -2){
		sRtnMsg = "암호화 모듈 오류입니다.";
	} else if (iRtn == -9){
		sRtnMsg = "입력 데이터 오류입니다.";
	} else{
		sRtnMsg = "알수 없는 에러 입니다. iReturn : " + iRtn;
	}
/** 아이핀 인증 모듈 끝 ===============================================================================**/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>본인인증</title>
<style type="text/css">
html {overflow:hidden;}
body, td {font-family:"맑은 고딕","돋움";font-size:8pt;color: #000000;line-height:16px;text-decoration: none;}
.bgLoginLayerBox1 {background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/images/knowbox/login/popLogin/login_00.png);}
.bgLoginLayerBox11 {background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/images/knowbox/login/popLogin/login_01.png);}
.bgLoginLayerBox2 {background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/images/knowbox/login/popLogin/login_02_right.png);}
.bgLoginLayerBox3 {background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/images/knowbox/login/popLogin/login_03.png);}
.bgLoginLayerBox4 {background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/images/knowbox/login/popLogin/login_ly_03.png);}
.bgLoginLayerSduBox1 {background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/images/knowbox/login/popLogin/login_mall.gif);}
.bgLoginLayerSdulBox1 {background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/images/knowbox/login/popLogin/login_sdul.gif);}
.autoLoginLayerStyle1 {font-family:돋움;color:#ce4300;font-size:11px;}
.autoLoginLayerStyle2 {font-family:돋움;color:#42638f;font-size:11px;font-weight:bold;line-height:13px;}
.autoLoginLayerStyle3 {font-family:돋움;color:#42638f;font-size:11px;line-height:normal;}
.login_font {color:#666666;font-size:11px;}
.login_font span {text-decoration:underline;cursor:pointer;}
#loginid {font-family:"맑은 고딕";font-size:12px;}
#frmUserName {font-family:"맑은 고딕";font-size:12px;}
form {list-style:none;display:inline;margin:0;padding:0;}
.service_layer1 .inner {text-indent:-9999em;}
.service_layer1 .btn_close {position:absolute; top:7px; right:5px; width:17px; height:17px; padding:5px;text-indent:-999em;}
</style>

<%-- <script language="javascript" src="<%=ConfigManager.ENURI_COM%>/common/js/lib/prototype.js"></script> --%>
<%-- <script language="javascript" src="<%=ConfigManager.ENURI_COM%>/common/js/lib/scriptaculous.js"></script> --%>
<script language="javaScript">
cmdCheckPlus();

// onload 시 호출되는 함수
function init(){


	// 이 페이지를 호출하면 휴대폰 인증으로 바로 넘김
    cmdCheckPlus();
	/*
	resize();
	<%if(!userid.equals("") && strAdult.equals("2")){%>
	needNameCheck();
	<%}%>
	*/

}


function resize(){
	if ($("tbl_main")){
		var wW = $("tbl_main").getWidth();
		var wH = $("tbl_main").getHeight();
		var h=0;
	    if(navigator.userAgent.indexOf("MSIE")>0 || navigator.userAgent.toLowerCase().indexOf("trident")>0) {
	    	//ie
	    	if(navigator.userAgent.indexOf("MSIE 9")>0 || navigator.userAgent.toLowerCase().indexOf("trident")>0) {
	    		h=88;
	      	}else{
	        	h=72;
	      	}
	    }else if(navigator.userAgent.indexOf("Gecko")>0 && navigator.userAgent.indexOf("Firefox")<0 && navigator.userAgent.indexOf("Chrome")<0){
	    	//safari
	    	h=53;
	    }else if(navigator.userAgent.indexOf("Firefox") > 0){
	    	//firefox
	    	h=66;
		}else if(navigator.userAgent.toLowerCase().indexOf("nt 6.") > 0) {
			wW += 8;
	  		h=66;
	    }else{
			h=66;
		}
		self.resizeTo(wW+10,wH+h+5);
	}
}
//로그인처리후 실행
function afterLoginLayer(){
	try{
		<%if(strRtnFunc.equals("")){%>
		opener.location.href = "<%=strRtnUrl%>";
		<%}else{%>
		opener.<%=strRtnFunc%>();
		<%}%>
	}catch(e){
		var win = window.open("<%=strRtnUrl%>");
		win.focus();
	}
	try{
		opener.top.cmdMyAreaReload();
		opener.top.showLoginStatus();
	}catch(e){}
	window.close();
}


//실명인증 처리후 실행
function afterMyAuth(mobile, conf_ci_key, conf_di_key, conf_phoneco, conf_name){
	try{
		<%if(strRtnFunc.equals("")){%>
		//opener.location.href = "<%=strRtnUrl%>";	// 팝업
			parent.location.href = "<%=strRtnUrl%>";	// iframe

		<%}else{%>
			opener.<%=strRtnFunc%>(mobile, conf_ci_key, conf_di_key, conf_phoneco, conf_name);
		<%}%>
	}catch(e){
		var win = window.open("<%=strRtnUrl%>");
		win.focus();
	}

	window.close();
}


//실명확인 필요 : 성인여부 판단불가일때 호출
function needNameCheck(){
	var shtml = "<img src=\"<%=ConfigManager.IMG_ENURI_COM%>/images/knowbox/login/popLogin/adult_loginfo_phone.gif\"/>";
	document.getElementById("type1_in").innerHTML = shtml;
	document.getElementById("type1_in").style.backgroundColor = "#f1f1f1";
	document.getElementById("type1_in").style.width = "325px";
	document.getElementById("type1_in").style.height = "135px";
}
//회원가입
function goJoin(){
	try{
		opener.top.CmdJoin(1);
		opener.top.hideLoginLayer();
	}catch(e){
		var win = window.open("/");
		win.focus();
	}
}
//분실신고
function goFindPassID(){
	var newWin = window.open("/join/find_id_pass/Find_Id_Pass_2013.jsp","find_id_pass","width=380,height=582,toolbar=no,directories=no,status=no,scrollbars=no,resizable=no,menubar=no,left=300, top=200");
	newWin.focus();
}
function chkFrmValue(form){
	if(form.loginid.value.length==0 || form.loginid.value==form.loginid.defaultValue){
		alert("ID를 입력하세요");
		form.loginid.focus();
		form.loginid.select();
		return;
	}
	if(form.pass.value.length==0){
		alert("비밀번호를 입력하세요");
		form.pass.focus();
		form.pass.select();
		return;
	}
	if(form.pass.value.length < 4 || form.pass.value.length > 12 || chkPassChar(form.pass.value) == false){
		alert("비밀번호는 6~12자의 영문, 숫자만 가능합니다");
		form.pass.select();
		return;
	}
	form.submit();
}
function CmdKeyPressLogin(e){
	if ( e.keyCode!=13){
		if ( !((e.keyCode >= 48 && e.keyCode <=57) || (e.keyCode >= 65 && e.keyCode <=90) || (e.keyCode >= 97 && e.keyCode <=122) )){
			e.returnValue = false;
		}
	}else{
		chkFrmValue(document.frmLogin);
	}
}
function chkPassChar(strPass) {
	var validChar = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
	for (var i=0;i<strPass.length;i++) {
		if (validChar.indexOf(strPass.charAt(i)) == -1)
			return false;
	}
	return true;
}
function getPositionLeftAutoAlert(){
	var varLeft = Position.cumulativeOffset(document.getElementById("autologin"))[0];
	return varLeft;
}
function getPositionTopAutoAlert(){
	var varTop = Position.cumulativeOffset(document.getElementById("autologin"))[1];
	return varTop;
}
function isNumber(form) {
	if(event.keyCode != 13) {
		if((event.keyCode<48)||(event.keyCode>57)) {
			event.returnValue = false;
		}
	}
}
function cmdCheckPlus(){
<%if(iReturn==0){%>
	window.open('/common/jsp/Common_Pop_Submit.jsp?after=cmdCheckPlusReal', 'popupChk', 'width=500, height=461, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	//location.href = "/common/jsp/Common_Pop_Submit.jsp?after=cmdCheckPlusReal";
<%}else{%>
	alert("<%=sMessage%>");
<%}%>
}
function cmdCheckPlusReal(){
	document.form_chk.action = "https://check.namecheck.co.kr/checkplus_new_model4/checkplus.cb";
	document.form_chk.target = "popupChk";
	document.form_chk.submit();
}
function cmdPopIpin(){
<%if(iRtn==0){%>
	window.open('/common/jsp/Common_Pop_Submit.jsp?after=cmdPopIpinReal', 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
<%}else{%>
	alert("<%=sRtnMsg%>");
<%}%>
}
function cmdPopIpinReal(){
	document.form_ipin.target = "popupIPIN2";
	document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
	document.form_ipin.submit();
}
function overImg(obj){
	if(obj.src.indexOf("_ov.gif")<0){
		obj.src = obj.src.replace(".gif", "_ov.gif");
	}
}
function outImg(obj){
	if(obj.src.indexOf("_ov.gif")>0){
		obj.src = obj.src.replace("_ov.gif", ".gif");
	}
}
</script>
</head>
<body scroll=no leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="init()">


<form name="form_chk" method="post">
<input type="hidden" name="m" value="checkplusSerivce"><!-- 필수 데이타로, 누락하시면 안됩니다. -->
<input type="hidden" name="EncodeData" value="<%=sEncData%>"><!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
<!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
	 해당 파라미터는 추가하실 수 없습니다. -->
<input type="hidden" name="param_r1" value="<%=sRequestNumber%>">
<input type="hidden" name="param_r2" value="">
<input type="hidden" name="param_r3" value="">
</form>
<form name="form_ipin" method="post">
<input type="hidden" name="m" value="pubmain">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
<input type="hidden" name="enc_data" value="<%=sEncData_ipin%>">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
<!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
	 해당 파라미터는 추가하실 수 없습니다. -->
<input type="hidden" name="param_r1" value="<%=sCPRequest%>">
<input type="hidden" name="param_r2" value="">
<input type="hidden" name="param_r3" value="">
</form>

</body>
</html>