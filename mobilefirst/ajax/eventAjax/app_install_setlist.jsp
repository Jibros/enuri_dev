<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page import="org.json.JSONObject"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="java.net.InetAddress"%>
<%@page import="com.enuri.bean.event.Event_Mobile_Award_2016_Proc"%>
<%
	String replyMsg = ChkNull.chkStr(request.getParameter("replyMsg"),"");
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim();
	
	String eventId = ChkNull.chkStr(request.getParameter("event_id"),"2016041801");
	String enuriId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	String iconFlag = ChkNull.chkStr(request.getParameter("iconFlag"),"");
	
	JSONObject jSONObject = new JSONObject();
	
	if( "".equals(enuriId) ){
		//로그인 안함
		jSONObject.put("result", "le");
		out.println(jSONObject.toString());
		return ;
	}
	
	Event_Mobile_Award_2016_Proc event_proc = new Event_Mobile_Award_2016_Proc(); 
	
	boolean bl_insert = false;
	
	if(replyMsg.length() > 160){
		replyMsg = replyMsg.substring(0,160);
	}
	
	//sns 인증회원 확인
	/*
	boolean bcertify= new Sns_Login().isSnsMemberCertify2(enuriId);
	if(!bcertify){
		jSONObject.put("result", -5);
		out.println(jSONObject.toString());
		return;
	}
	*/
	
	//wish_date yyyymmdd
	SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
	String strToday = formatter.format(new Date());

	try{
		if(!"".equals(replyMsg) && !"".equals(enuriId)){
			bl_insert = event_proc.ins_event(strToday, enuriId, eventId, replyMsg, osType, iconFlag);
			jSONObject.put("result", ""+bl_insert+"");
		}
	} catch(Exception ex) {}
	out.println(jSONObject.toString());
%>
