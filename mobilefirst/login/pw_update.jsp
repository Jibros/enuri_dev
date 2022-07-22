<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilenew/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc" scope="page" />
<%@ page import="org.json.*"%>
<%	
	String user_id = ChkNull.chkStr(request.getParameter("userid"));
	String newpass = ChkNull.chkStr(request.getParameter("newpass"));
	
	//비밀번호 변경
	Members_Proc.Update_NewPass(user_id,newpass);
	

%>