<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	String phone = ChkNull.chkStr(request.getParameter("phone"), "").trim();
	String nickname = ChkNull.chkStr(request.getParameter("nickname"), "").trim();
	String type = ChkNull.chkStr(request.getParameter("type"), "").trim();
	String pg = ChkNull.chkStr(request.getParameter("page"), "").trim();
	String os = ChkNull.chkStr(request.getParameter("os"), "").trim();

	Mobile_Event_Proc mobile_Event_Proc = new Mobile_Event_Proc();
	
	JSONObject jSONObject = new JSONObject();
	
	jSONObject = mobile_Event_Proc.insertReview( type , pg , os , nickname , phone);
	 
	jSONObject.put("result",jSONObject.get("result"));
	
	out.println(jSONObject.toString());
	
%>