<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilenew/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.main.Mobile_Main_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<% 
	String type = StringUtils.defaultString(request.getParameter("type"));
	String date = StringUtils.defaultString(request.getParameter("date"));	
	
	Mobile_Main_Proc mobile_Main_Proc = new Mobile_Main_Proc();
	
	JSONObject jSONObject = new JSONObject();

	jSONObject = mobile_Main_Proc.getMobileRecommendGoodsToJson(date);
//	System.out.println("date====="+date); 
	out.println(jSONObject);
	 
	 
%>