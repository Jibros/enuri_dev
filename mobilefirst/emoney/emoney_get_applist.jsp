<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Emoney_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.simple.*"%>
<%
 
	String strUuid = cb.GetCookie("MOBILEWEBUUID","UUID");
	String strI_Uuid = cb.GetCookie("MOBILEWEBIUUID", "I_UUID");
	//strUuid="66C5D711-7128-4017-90D7-AF0253E2FB93";
	
	JSONArray jSONArray = new JSONArray(); 
	JSONObject jSONObject = new JSONObject();
	
	Emoney_Proc emoney_proc = new Emoney_Proc(); 
	
	//System.out.println("strUuid>>"+strUuid);
	//System.out.println("strI_Uuid>>"+strI_Uuid);
	
	jSONArray = emoney_proc.get_applist(strI_Uuid);
	jSONObject.put("applist",jSONArray);  
	
	out.println(jSONObject.toString()); 
	 
%>
