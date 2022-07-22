<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	String phone = ChkNull.chkStr(request.getParameter("phone"), "").trim();
	String username = ChkNull.chkStr(request.getParameter("username"), "").trim();
	 
	Mobile_Event_Proc mobile_Event_Proc = new Mobile_Event_Proc();
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	
	JSONObject jSONObject = new JSONObject();
	
	jSONObject = mobile_Event_Proc.insertReg(userId , username ,phone);
	 
	jSONObject.put("result",jSONObject.get("result"));
	
	out.println(jSONObject.toString());
	
%>