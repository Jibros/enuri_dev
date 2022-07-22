<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilenew/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Plan_Event_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<% 
	Mobile_Plan_Event_Proc mobile_Plan_Event_Proc = new Mobile_Plan_Event_Proc();
	
	JSONObject jSONObject = new JSONObject();
	jSONObject = mobile_Plan_Event_Proc.mobileGetWonList();
	
	out.println(jSONObject);
%>