<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="java.net.InetAddress"%>
<%@page import="com.enuri.bean.event.every.Event_201606_Movie_Proc"%>
<%
	String eventId = "2017041703"; //이벤트코드
	String userId = cb.GetCookie("MEM_INFO","USER_ID"); //참여 ID
    
    
	Event_201606_Movie_Proc event_proc = new Event_201606_Movie_Proc(); 
	boolean bl_insert = false;

	try{ 
		if(!userId.equals("")){
			bl_insert = event_proc.ins_event(eventId, userId, "", "");
		} 
	}catch(Exception ex) {
        //System.out.println(ex.getMessage());		
    } 
%>{"result" : "<%=bl_insert %>" }
