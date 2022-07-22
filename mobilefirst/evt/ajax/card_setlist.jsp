<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="java.net.InetAddress"%>
<%@page import="com.enuri.bean.event.every.Newyear_2017"%>
<%
	String userId = cb.GetCookie("MEM_INFO","USER_ID");
	//int cardSeq = ChkNull.chkInt(request.getParameter("cardSeq"));
	String eventId = "2017041701";
	String cardImg = ChkNull.chkStr(request.getParameter("cardImg"),"");
	String cardMsg = ChkNull.chkStr(request.getParameter("cardMsg"),"");
	String cardDear = ChkNull.chkStr(request.getParameter("cardDear"),"");
	String cardFrom = ChkNull.chkStr(request.getParameter("cardFrom"),"");
	String osType = ChkNull.chkStr(request.getParameter("osType"), "").trim();
	
	Newyear_2017 event_proc = new Newyear_2017();  
	boolean bl_insert = false;
	int seqNum = -1; 
	
	 try{
		seqNum = event_proc.insertCard(userId, eventId, cardMsg, cardDear, cardFrom, cardImg, osType);	
		bl_insert = seqNum >= 0;
	} catch(Exception ex) {} 
%>
{"result" : "<%=bl_insert %>", "cardseq" : "<%=seqNum %>"}
