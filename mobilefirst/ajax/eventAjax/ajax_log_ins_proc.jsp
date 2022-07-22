<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Event_Lina_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	Event_Lina_Proc event_Lina_Proc = new Event_Lina_Proc();
	
	String code = ChkNull.chkStr(request.getParameter("code"),"");
	String M_Ip = ChkNull.chkStr(request.getParameter("ip"),request.getRemoteAddr());
	
	
	String flag = ChkNull.chkStr(request.getParameter("flag"),"");
	String eventId = ChkNull.chkStr(request.getParameter("eventId"),"");
	event_Lina_Proc.insertLog(code, M_Ip,flag,eventId);
	
%>