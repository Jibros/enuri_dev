<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Event_Dongbu_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
  Event_Dongbu_Proc event_Dongbu_Proc = new Event_Dongbu_Proc();
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	
	int result = event_Dongbu_Proc.dongbuProcCall(userId);
    
    JSONObject jSONObject = new JSONObject();	 
	jSONObject.put("result",result);
	out.println(jSONObject.toString());
%>