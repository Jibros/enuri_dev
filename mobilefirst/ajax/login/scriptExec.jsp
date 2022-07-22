<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<jsp:useBean id="Members_Data" class="com.enuri.bean.knowbox.Members_Data" />
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc" />
<%
	String sendScript = ChkNull.chkStr(request.getParameter("sendScript"));
	String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
%>
<script language="JavaScript">
<!--
<%=sendScript%>
if(window.android){
	parent.IsLogin();
	window.android.getLoginID('<%=cUserId%>');
}
 
-->
</script>