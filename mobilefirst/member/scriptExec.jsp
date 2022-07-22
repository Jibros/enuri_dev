<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
	String sendScript = ChkNull.chkStr(request.getParameter("sendScript"));
	String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
%>
<script language="JavaScript">
<%=sendScript%> 
<!--
if(window.android){
	parent.IsLogin(); 
	window.android.getLoginID('<%=cUserId%>');
} 
 
-->
</script> 