<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="java.net.InetAddress"%>
<%@page import="com.enuri.bean.event.Event_Gate_Data"%>
<%@page import="org.json.simple.*"%>
<%

	int strTgId = ChkNull.chkInt(request.getParameter("tg_id"),0);
	int strTgFrom = ChkNull.chkInt(request.getParameter("tg_from"),0);

	JSONArray jSONArray = new JSONArray(); 
	JSONObject jSONObject = new JSONObject();

	Event_Gate_Data gate_proc = new Event_Gate_Data();
			
	jSONArray = gate_proc.get_GateList(strTgId, strTgFrom );
	jSONObject.put("gatelist",jSONArray);

	out.println(jSONObject.toString());
	
%>