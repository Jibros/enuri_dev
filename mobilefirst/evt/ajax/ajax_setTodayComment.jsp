<%@page import="com.enuri.bean.event.every.Event_Every_Visit_Proc"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%> 
<%@page import="com.enuri.bean.mobile.Event_Catch_Proc" %>


<%
	String eventId = ChkNull.chkStr(request.getParameter("reply_eventcode"));
	String sdt = ChkNull.chkStr(request.getParameter("sdt"));
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	String result = "";
	
	JSONObject jSONObject = new JSONObject();
	/* if (eventId.isEmpty() || userId.isEmpty()) { // null checking
		String resultMsg = "";
		if (eventId.isEmpty()) {
			result = "event_value_empty";	
		} else if (userId.isEmpty()) {
			result = "userId_empty";
		}
	} else { // 값 세팅 */
		Event_Every_Visit_Proc visit_proc = new Event_Every_Visit_Proc();
		jSONObject = visit_proc.getTodayComment(eventId, sdt);
	//}
	
	out.println(jSONObject.toString());
	
%>