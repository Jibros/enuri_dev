<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="com.enuri.bean.main.Mobile_Main_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	String type = StringUtils.defaultString(request.getParameter("type"));
	
	Mobile_Main_Proc mobile_Main_Proc = new Mobile_Main_Proc();
	
	JSONObject jSONObject1 = new JSONObject();
	JSONObject jSONObject2 = new JSONObject();

	jSONObject1 = mobile_Main_Proc.getMobileDepartBestToJson();
	jSONObject2 = mobile_Main_Proc.getMobileDepartBestPriceToJson();
	
	JSONObject jSONObject = new JSONObject();
	
	jSONObject.put("best",jSONObject1);
	jSONObject.put("price",jSONObject2);
	
	out.println(jSONObject);
%>