<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="java.net.InetAddress"%>
<%@page import="com.enuri.bean.event.every.Event_201612_Xmas_Proc"%>
<%
	String replyMsg = ChkNull.chkStr(request.getParameter("replyMsg"),"");
	String osType = ChkNull.chkStr(request.getParameter("osType"), "").trim();
	String eventId = ChkNull.chkStr(request.getParameter("eventId"), "2016120502").trim();
	String enuriId = cb.GetCookie("MEM_INFO","USER_ID");
	
	Event_201612_Xmas_Proc event_proc = new Event_201612_Xmas_Proc(); 
	boolean bl_insert = false;
	//wish_date yyyymmdd
	SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
	String strToday = formatter.format(new Date());
	
	/* System.out.println("replyMsg>>>"+replyMsg);
	System.out.println("osType>>>"+osType);
	System.out.println("eventId>>>"+eventId);
	System.out.println("enuriId>>>"+enuriId);
	System.out.println("strToday>>>"+strToday); */
	
	 try{
		if(!replyMsg.equals("")){
			bl_insert = event_proc.ins_event(strToday, enuriId, eventId, replyMsg, osType);
		}
	} catch(Exception ex) {} 
%>{"result" : "<%=bl_insert %>" }
