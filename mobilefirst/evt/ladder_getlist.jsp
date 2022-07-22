<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Event_Ladder_Proc"%>
<%@ page import="com.enuri.bean.main.Member_Point_Proc"%>
<%@page import="org.json.*"%>
<%

	String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
	String strEventId = ChkNull.chkStr(request.getParameter("strEventId"),"");
	String procCode = ChkNull.chkStr(request.getParameter("procCode"),"");
	if(procCode.equals("")){
		if(!cUserId.equals("")){
			Event_Ladder_Proc event_proc = new Event_Ladder_Proc();
			
			JSONObject jSONObject = new JSONObject();
			
			jSONObject = event_proc.getEventEveryItemJson(strEventId, cUserId);
			
			out.println(jSONObject.toString());
		} else {
			out.println("{\"event_list\":\"false\"}");
		}
		
	}else if(procCode.equals("1")){
		out.println(new Member_Point_Proc().getEmoneyEventPoint(cUserId));
	}
	
%>