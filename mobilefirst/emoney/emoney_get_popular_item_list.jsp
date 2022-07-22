<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Emoney_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.simple.*"%>
<%

	JSONArray jSONArray = new JSONArray(); 
	JSONObject jSONObject = new JSONObject();
	
	Emoney_Proc emoney_proc = new Emoney_Proc(); 
	
	jSONArray = emoney_proc.get_PopularItemList();
	jSONObject.put("itemlist",jSONArray);
	
	out.println(jSONObject.toString());
	
%> 