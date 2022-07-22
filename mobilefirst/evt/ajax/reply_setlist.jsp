<%@page import="org.json.JSONObject"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="java.net.InetAddress"%>
<%@page import="com.enuri.bean.event.every.Event_201612_Xmas_Proc"%>
<%
	String replyType = ChkNull.chkStr(request.getParameter("replyType"),"");

	String replyMsg = ChkNull.chkStr(request.getParameter("replyMsg"),"");
	String osType = ChkNull.chkStr(request.getParameter("osType"), "").trim();
	String eventId = ChkNull.chkStr(request.getParameter("eventId"), "2017020601").trim();
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
	
	JSONObject jSONObject = new JSONObject(); 
	
	if("O".equals(replyType)){
		//sns 인증회원 확인
		boolean bcertify= new Sns_Login().isSnsMemberCertify2(enuriId);
		if(!bcertify){
			jSONObject.put("result", -5);
			out.println(jSONObject.toString());
			return;
		}
	}
	
	 try{
		if(!replyMsg.equals("")){
			bl_insert = event_proc.ins_event(strToday, enuriId, eventId, replyMsg, osType);
			jSONObject.put("result", ""+bl_insert+"");
		}
	} catch(Exception ex) {}
	 out.println(jSONObject.toString());
%>
