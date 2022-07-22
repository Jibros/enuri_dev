<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Event_Lina_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	Event_Lina_Proc event_Lina_Proc = new Event_Lina_Proc();
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	//String eventId = "20160926";
	
	String eventId = ChkNull.chkStr(request.getParameter("eventCode"));
    //럭키박스 이벤트 일경우는 이벤트 코드가 2016092701
    //구매왕 이벤트 일 경우는 이벤트 코드가 2016093001
	
	JSONObject jSONObject  = new JSONObject(); 
	
	if(!eventId.equals("")){
	   jSONObject  = event_Lina_Proc.ins_event(userId,eventId);
	}else{
	   jSONObject.put("result",false);
	}
	
	out.println(jSONObject.toString());
%>