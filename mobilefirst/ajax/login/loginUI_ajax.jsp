<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/m2_Base_Inc_Mobile.jsp"%>
<%
	String IMG_ENURI_COM = ConfigManager.IMG_ENURI_COM;

	String ENURI_COM_SSL = "https://m.enuri.com:442";

	HttpSession MobilesessionCheck = request.getSession(true);
	String strEnuriAppCheck = ChkNull.chkStr((String)MobilesessionCheck.getAttribute("enuriApp"),"");
	
	String strReferr = request.getHeader("referer");
	String serverName = request.getServerName();
	String useragent = request.getHeader("user-agent");
	//out.println("useragent="+useragent);

	// 아이폰 새버전이 올라가면
	// 밑에 ios예외처리 한부분들 수정해야함
	if(serverName.indexOf("stagedev.enuri.com")>-1 || serverName.indexOf("dev.enuri.com")>-1) {
		ENURI_COM_SSL = "";
	}

	String car_flag = "";
	String url_param = "";
	if(strReferr.indexOf("carm")>-1) {
		car_flag = "1";
		url_param = "?carErr=http://m.enuri.com/carm/err";
	}
%>
<div id="login">
	<div class="inputArea" style="">
		<div class="inputBox">
			<form name="loginForm" action="<%=ENURI_COM_SSL%>/mobile2/login/ajax/loginProc_ajax.jsp<%=url_param%>" method="post" target="hFrame">
			<input type="hidden" name="autologin" value="">
			<input type="hidden" id="appDeviceId" name="appDeviceId" value="">
			<input type="hidden" id="appDeviceType" name="appDeviceType" value="">
			<input type="hidden" name="car_flag" value="<%=car_flag%>">
			<input type="text" id="member_id" name="member_id" placeholder="아이디">
			<input type="password" id="member_pass" name="member_pass" placeholder="비밀번호">
			</form>
		</div>
		<div class="inputButton" style="float:right;">
			<img id="btn_login" src="<%=IMG_ENURI_COM%>/images/mobile2/login/btn_login.png">
		</div>
	</div>
	<div class="optionArea">
		<div class="autoLogin">
			<img src="<%=IMG_ENURI_COM%>/images/mobile2/login/btn_check_on.png">
			<span>자동로그인</span>
		</div>
		<div class="joinLink">
			<span>초간편 회원가입</span>
		</div>
	</div>
<%if(!car_flag.equals("1")) {%>
<div id="loginInfoTextDiv">
	<div class="infoTextArea">
		<div class="infoTextTitle">찜상품, 모바일과 PC 연동됩니다.</div>
		<div class="infoTextContents">
① 현재의 모바일에서의 ID로<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PC에서 접속하시면<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;모바일에서 찜하신 상품을 볼 수 있습니다.<br/>
<br/>
② PC나 모바일에서의 ID는 동일하게 사용됩니다.
		</div>
	</div>
</div>
<%}%>
</div>
