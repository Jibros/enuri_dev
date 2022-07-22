<%@ page language="java" import="Kisinfo.Check.CPClient"%>
<%@ page language="java" import="Kisinfo.Check.IPIN2Client"%>
<%@ include file="/member/join/auth/checkPlus_Conf.jsp"%>
<%@ include file="/member/join/auth/iPin_Conf.jsp"%>
<%
//ssl아님
String strRtnUrl = ChkNull.chkStr(request.getParameter("url"),""); //return opener's url
String strRtnFunc = ChkNull.chkStr(request.getParameter("func"),""); //return opener's function
String strReferer = ChkNull.chkStr(request.getHeader("REFERER"),"");
strRtnFunc = "myCheckOk";

String sMyAuth = "";
if(request.getRequestURL().indexOf("mobilefirst/member/myAuth.jsp") > -1){
	 if(strReferer.indexOf("/mobilefirst/login/rest_cancel.jsp")  > -1){
		 sMyAuth = "&cmdType=uft";
	 }else{
		 sMyAuth = "&cmdType=modify";
	 }
}

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

	//CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
	//String sReturnUrl 	= ConfigManager.ENURI_COM_SSL+"/member/join/auth/myCheckPlus.jsp?re=s"; // 성공시 이동될 URL
	//String sErrorUrl 	= ConfigManager.ENURI_COM_SSL+"/member/join/auth/myCheckPlus.jsp?re=f"; // 실패시 이동될 URL
	String sReturnUrl 	= ENURI_COM_SSL+"/mobilefirst/member/myCheckPlus.jsp?re=s"+sMyAuth; // 성공시 이동될 URL
	String sErrorUrl 	= ENURI_COM_SSL+"/mobilefirst/member/myCheckPlus.jsp?re=f"+sMyAuth; // 실패시 이동될 URL


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

<script language="javaScript">

//로그인처리후 실행
function afterLoginLayer(){
	try{
		<%if(strRtnFunc.equals("")){%>
		location.href = "<%=strRtnUrl%>";
		<%}else{%>
		<%=strRtnFunc%>();
		<%}%>
	}catch(e){
		var win = window.open("<%=strRtnUrl%>");
		win.focus();
	}
	try{
		top.cmdMyAreaReload();
		top.showLoginStatus();
	}catch(e){}
	window.close();
}


//실명인증 처리후 실행
function afterMyAuth(mobile, conf_ci_key, conf_di_key, conf_phoneco, conf_name, myauth){
	//conf_di_key = conf_di_key.replaceAll("[-]","+");
	//conf_ci_key = conf_ci_key.replaceAll("[_]","/");
	conf_di_key = conf_di_key.replace(/\-/g,"+");
	conf_ci_key = conf_ci_key.replace(/\-/g,"+");

	try{
		<%if(strRtnFunc.equals("")){%>
			location.href = "<%=strRtnUrl%>";	// iframe
		<%}else{%>
			<%=strRtnFunc%>(mobile, conf_ci_key, conf_di_key, conf_phoneco, conf_name, myauth);
		<%}%>
	}catch(e){
		var win = window.open("<%=strRtnUrl%>");
		win.focus();
	}
}


function cmdCheckPlusReal(){
	<%if(strFlow.equals("p")){%>
		window.open('', 'popupChk', 'width=500, height=461, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	<%}%>
	try{
		document.form_chk.target = "popupChk";
		document.form_chk.action = "https://check.namecheck.co.kr/checkplus_new_model4/checkplus.cb";
		document.form_chk.submit();
	}catch(e){
		alert(e);
	}

}
</script>
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