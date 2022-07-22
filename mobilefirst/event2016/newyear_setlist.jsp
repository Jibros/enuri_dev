<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="java.net.InetAddress"%>
<%@page import="com.enuri.bean.event.every.Newyear_2017"%>
<%
	String userId = cb.GetCookie("MEM_INFO","USER_ID");
	//int cardSeq = ChkNull.chkInt(request.getParameter("cardSeq"));
	String eventId = ChkNull.chkStr(request.getParameter("eventId"), "2017010402").trim();
	String cardImg = ChkNull.chkStr(request.getParameter("cardImg"),"");
	String cardMsg = ChkNull.chkStr(request.getParameter("cardMsg"),"");
	String cardDear = ChkNull.chkStr(request.getParameter("cardDear"),"");
	String cardFrom = ChkNull.chkStr(request.getParameter("cardFrom"),"");
	String osType = ChkNull.chkStr(request.getParameter("osType"), "").trim();
	
	Newyear_2017 event_proc = new Newyear_2017();  
	boolean bl_insert = false;
	int seqNum = -1; 
	
	//wish_date yyyymmdd
	//SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
	//String strToday = formatter.format(new Date());
	
	//System.out.println("replyMsg>>>"+replyMsg);
	//System.out.println("osType>>>"+osType);
	//System.out.println("eventId>>>"+eventId);
	//System.out.println("cardImg>>>"+cardImg);
	System.out.println("cardMsg>>>"+cardMsg);
	//System.out.println("enuriId>>>"+enuriId);
	//System.out.println("strToday>>>"+strToday);
	
	 try{
		if(!cardMsg.equals("")){
			seqNum = event_proc.insertCard(userId, eventId, cardMsg, cardDear, cardFrom, cardImg, osType);
			
			bl_insert = seqNum >= 0;
		}
	} catch(Exception ex) {} 
%>
{"result" : "<%=bl_insert %>", "cardseq" : "<%=seqNum %>"}
