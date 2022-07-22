<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Visit_Event_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
    Visit_Event_Proc visit_event_proc = new Visit_Event_Proc();
    JSONObject jSONObject = visit_event_proc.getEventList_DEV("20170302");   

	out.println(jSONObject.toString());
%>