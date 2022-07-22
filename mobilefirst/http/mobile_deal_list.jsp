<%@page import="com.enuri.bean.mobile.Mobile_Deal_Proc"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="org.json.JSONException"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
Mobile_Deal_Proc mdp = new Mobile_Deal_Proc();
JSONArray jSONArray = new JSONArray();
if(request.getServerName().indexOf("dev.enuri.com")>-1){
	jSONArray = mdp.getCrazyJson("Y");
}else{
	jSONArray = mdp.getCrazyJson("N");	
}

out.println(jSONArray.toString());
%>