<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	Mobile_Event_Proc mobile_Event_Proc = new Mobile_Event_Proc();
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	
	JSONObject jSONObject = new JSONObject();
	
	int cnt = mobile_Event_Proc.getCashBackYN(userId);
	 
	jSONObject.put("result", cnt);
	
	out.println(jSONObject.toString());
	
%>