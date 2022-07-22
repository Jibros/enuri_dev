<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.event.every.Event_201612_Xmas_Proc"%>
<%@page import="com.enuri.bean.event.Event_Mobile_Award_2016_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.simple.*"%>
<%
	String strTop = ChkNull.chkStr(request.getParameter("top"),"0");
	int iPageno = ChkNull.chkInt(request.getParameter("pageno"),1);
	int iPageSize = ChkNull.chkInt(request.getParameter("pagesize"),10);	//모바일은 4개, pc는 20개
	String eventId = ChkNull.chkStr(request.getParameter("eventId"), "2016120502").trim();
	String del_yn = ChkNull.chkStr(request.getParameter("del_yn"),"");
	
	JSONArray jSONArray = new JSONArray(); 
	JSONObject jSONObject = new JSONObject();
	//Event_201612_Xmas_Proc event_proc = new Event_201612_Xmas_Proc(); 
	Event_Mobile_Award_2016_Proc event_proc = new Event_Mobile_Award_2016_Proc(); 
	jSONArray = event_proc.get_List(iPageno,iPageSize, eventId, del_yn);
	jSONObject.put("eventlist",jSONArray);
	out.println(jSONObject.toString());
%>


