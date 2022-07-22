<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
	String errorNo = ChkNull.chkStr(request.getParameter("Result"));
	String type = ChkNull.chkStr(request.getParameter("type"));
	String sendScript = "";
	
	if(errorNo.indexOf("SUCCESS")>-1) {
		if("pw".equals(type)){
			sendScript += "parent.showPwInputInfoSendHpAuth('인증번호가 전송되었습니다.', 2);";
		}else{
			sendScript += "parent.showInputInfoSendHpAuth('인증번호가 전송되었습니다.', 2);";
		}
		
	}
	
	String thisDomain = "http://m.enuri.com";
	String serverName = request.getServerName();
	if(serverName.indexOf("stagedev.enuri.com")>-1 || serverName.indexOf("100.100.100.151")>-1 || serverName.indexOf("dev.enuri.com")>-1) {
		thisDomain = "";
	}
	
%>
<form name="sendScriptForm" method="post" action="<%=thisDomain%>/mobilefirst/ajax/login/scriptExec.jsp">
<input type="hidden" name="sendScript" value="<%=sendScript%>">
</form>
<script language="JavaScript">
<!--
document.sendScriptForm.submit();
-->
</script>
