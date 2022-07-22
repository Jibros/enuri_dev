<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	JSONObject jSONObject = new JSONObject();
	
	Mobile_Event_Proc mobile_Event_Proc = new Mobile_Event_Proc();
			 
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
	String userData =ChkNull.chkStr(request.getParameter("chkId"),"");
	
	int memberPointYNCnt = mobile_Event_Proc.getMemberPointYN(userId);
	
	jSONObject.put("pointYN",memberPointYNCnt);
	
	out.println(jSONObject.toString());
%>