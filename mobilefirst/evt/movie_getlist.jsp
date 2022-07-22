<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Movie_Event_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%//@page import="org.json.simple.*"%>
<%//@page import="java.util.ArrayList"%>
<%//@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>

<%
	String event_id = ChkNull.chkStr(request.getParameter("event_id"), "").trim();

	String serverName = request.getServerName();
	String strServerName = "";
	
	JSONObject jSONObject = new JSONObject();
	Movie_Event_Proc event_proc = new Movie_Event_Proc(); 
	
	
	if(serverName.indexOf("dev.enuri.com")>-1) {
	     strServerName = "dev";
	}else
		strServerName = "real";

	jSONObject = event_proc.getOneMovieList(event_id, strServerName);
	out.println(jSONObject.toString());
%>

 