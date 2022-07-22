<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Emoney_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.simple.*"%>
<%
	String strUserid = cb.GetCookie("MEM_INFO","USER_ID");
	 
	JSONArray jSONArray = new JSONArray(); 
	
	Emoney_Proc emoney_proc = new Emoney_Proc(); 
	jSONArray = emoney_proc.get_EndList2(strUserid);
	 
	 
	JSONObject jSONObject = new JSONObject(); 
	
	jSONObject.put("endlist",jSONArray);
	
	out.println(jSONObject.toString());
	
%>