<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
	String errorNo = ChkNull.chkStr(request.getParameter("Result"));
	String type = ChkNull.chkStr(request.getParameter("type"));
	String sendScript = "";


	//SSL
	String ENURI_COM_SSL = "https://m.enuri.com";

	String serverName = request.getServerName();
	/* if(serverName.indexOf("stagedev.enuri.com")>-1) {
		ENURI_COM_SSL = "http://"+serverName;
	}else if(serverName.indexOf("100.100.100.151")>-1 || serverName.indexOf("dev.enuri.com")>-1){
		ENURI_COM_SSL = "https://"+serverName;
	}else{
		ENURI_COM_SSL = "https://"+serverName;
	} */

	ENURI_COM_SSL = "https://"+serverName;

	HttpSession ttsession = request.getSession(true);

	if(errorNo.indexOf("SUCCESS")>-1) {
		if("pw".equals(type)){
			//sendScript += "parent.showPwInputInfoSendHpAuth('인증번호가 전송되었습니다.' , 2);";
		}else{
			//sendScript += "parent.showInputInfoSendHpAuth('인증번호가 전송되었습니다.', 2);";
		}


		%>
		<script language="JavaScript">
		var type= "<%=type%>";
		if(type==''){
			parent.authTime();
			parent.jShowInputInfoSendHpAuth("인증번호가 발송되었습니다.");
		}
			alert('인증번호가 발송되었습니다.');

		</script>
		<%
	}

%>
<!--
<form name="sendScriptForm" method="post" action="<%=ENURI_COM_SSL%>/mobilefirst/member/scriptExec.jsp">
<input type="hidden" name="sendScript" value="<%=sendScript%>">
</form>
 -->
<script language="JavaScript">
</script>
