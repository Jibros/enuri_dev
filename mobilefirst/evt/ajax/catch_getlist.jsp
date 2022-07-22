<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%> 
<%@page import="com.enuri.bean.mobile.Event_Catch_Proc" %>


<%
	String eventId = ChkNull.chkStr(request.getParameter("eventid"));
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	String result = "";
	
	JSONObject jSONObject = new JSONObject();
	if (eventId.isEmpty() || userId.isEmpty()) { // null checking
		String resultMsg = "";
		if (eventId.isEmpty()) {
			result = "event_value_empty";	
		} else if (userId.isEmpty()) {
			result = "userId_empty";
		}
	} else { // 값 세팅
		Event_Catch_Proc event_catch_proc = new Event_Catch_Proc();
		result = String.valueOf(event_catch_proc.getCatchCnt(eventId, userId));
	}
	jSONObject.put("result", result); // 아이콘잡은 갯수를 json에 넣는다
	
	out.println(jSONObject.toString());
	
%>