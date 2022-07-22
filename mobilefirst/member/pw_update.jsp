<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.member.Login_Proc"%>
<jsp:useBean id="Login_Proc" class="com.enuri.bean.member.Login_Proc" scope="page" />
<%@ page import="org.json.*"%>
<%	

/*
	String referer = ChkNull.chkStr(request.getHeader("REFERER"), "");
	
	if(referer.isEmpty() || referer.indexOf("pw.jsp") < 0){
		response.sendRedirect("http://www.enuri.com");
		return;
	}
	String user_id = ChkNull.chkStr(request.getParameter("userid"));
	String newpass = ChkNull.chkStr(request.getParameter("newpass"));
	
	//비밀번호 변경

	boolean rtnValue = Login_Proc.Update_NewPass(user_id, newpass) ;
	out.println(rtnValue);
	*/
%> 

