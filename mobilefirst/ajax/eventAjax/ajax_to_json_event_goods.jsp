<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.simple.*"%>
<%
	JSONArray jSONArray = new JSONArray(); 
	
	Mobile_Event_Proc mobile_Event_Proc = new Mobile_Event_Proc(); 
	jSONArray = mobile_Event_Proc.getGoodsList();
	
	out.println(jSONArray.toString());
%>