<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="java.net.InetAddress"%>
<%@page import="com.enuri.bean.event.every.Event_201606_Movie_Proc"%>
<%
	
	String u_name = ChkNull.chkStr(request.getParameter("u_name"),"");
	String u_phone = ChkNull.chkStr(request.getParameter("u_phone"), "");
	String u_eventId = ChkNull.chkStr(request.getParameter("u_eventId"), "");

	String enuriId = cb.GetCookie("MEM_INFO","USER_ID");

	Event_201606_Movie_Proc event_proc = new Event_201606_Movie_Proc(); 
	
	boolean bl_insert = false;
	
	try{ 
		if(!u_name.equals("") || !u_phone.equals("")){
			bl_insert = event_proc.ins_event(u_eventId, enuriId, u_name, u_phone);
		} 
	} catch(Exception ex) {}
%>{"result" : "<%=bl_insert %>" }
