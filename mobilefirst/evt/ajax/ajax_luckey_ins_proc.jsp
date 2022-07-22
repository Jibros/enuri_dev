<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Event_Lina_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	Event_Lina_Proc event_Lina_Proc = new Event_Lina_Proc();

	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim();
	String eventId = ChkNull.chkStr(request.getParameter("eventId")).trim();
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();

	JSONObject jSONObject  = new JSONObject(); 
	if(referer.indexOf("enuri.com") > -1 && !"".equals(eventId) && !"".equals(userId)){
		jSONObject  = event_Lina_Proc.ins_event(userId,eventId);
	}else{
		jSONObject.put("result",false);
	}
	out.println(jSONObject.toString());
%>