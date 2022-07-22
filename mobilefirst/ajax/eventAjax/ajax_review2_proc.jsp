<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
	
	String type = ChkNull.chkStr(request.getParameter("type"), "").trim();
	String pg = ChkNull.chkStr(request.getParameter("page"), "").trim();
	
	String os = ChkNull.chkStr(request.getParameter("os"), "").trim();

	if(!userId.equals("")){
	
		Mobile_Event_Proc mobile_Event_Proc = new Mobile_Event_Proc();
		JSONObject jSONObject = new JSONObject();
		jSONObject = mobile_Event_Proc.insertReview2( type , pg , os , userId );
		jSONObject.put("result",jSONObject.get("result"));
		out.println(jSONObject.toString());
	
	}else{
		
		JSONObject jSONObject = new JSONObject();
		jSONObject.put("result",-2);
		out.println(jSONObject.toString());
	}
	
	
	
%>