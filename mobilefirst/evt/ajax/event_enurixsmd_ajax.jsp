<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="java.net.InetAddress"%>
<%@page import="com.enuri.bean.event.Event_Mobile_Award_2016_Proc"%>
<%@page import="com.enuri.bean.edeal.Edeal_Order_Proc"%>
<%
	
	String replyMsg = ChkNull.chkStr(request.getParameter("replyMsg"),"");
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim();
	
	String eventId = ChkNull.chkStr(request.getParameter("event_id"),"2020030901");
	String enuriId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	String iconFlag = ChkNull.chkStr(request.getParameter("iconFlag"),"");

	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();
	
	boolean bl_insert = false;
	Event_Mobile_Award_2016_Proc event_proc = new Event_Mobile_Award_2016_Proc(); 
	int replyCnt = event_proc.getCountReply(enuriId,eventId);
	
	//퀴즈정답
	String strCorrect = "다이어리";
	int correctReplyCnt = event_proc.getCountCorrectReply(enuriId,eventId, strCorrect);
	
	if(correctReplyCnt<=0){
		if(replyCnt >= 10){
		//if(!("2020020301".equals(eventId)) && replyCnt >= 10){
			%>{"result" : "over"}<%
			return;
		}
		if(referer.indexOf("enuri.com") < 1){
			return; 
		}
		if(replyMsg.length() > 160){
			replyMsg = replyMsg.substring(0,160);
		}
		
	
		//wish_date yyyymmdd
		SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
	
		String strToday = formatter.format(new Date());
		boolean IsEnuriEmployee = false;
		try{
	
			if( !"".equals(replyMsg) && !"".equals(enuriId)){
				bl_insert = event_proc.ins_reply(strToday, enuriId, eventId, replyMsg, osType, iconFlag);
			}
		} catch(Exception ex) {}
	%>{"result" : "<%=bl_insert %>" }
	<%
	}else{
		%>{"result" : "correct" }
	<%
	}
	%>
