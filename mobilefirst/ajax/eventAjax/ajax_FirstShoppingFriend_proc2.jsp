<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@ page import="com.enuri.bean.event.Members_Friend_Proc"%>
<jsp:useBean id="Members_Friend_Proc" class="Members_Friend_Proc" scope="page" />
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	//즉시지급이 없어져서 소스 막음
	/*
	Mobile_Event_Proc mobile_Event_Proc = new Mobile_Event_Proc(); 
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	String userData  =  StringUtils.defaultString(request.getParameter("chkid"));

	boolean result1 = false;
	boolean result = false;
	
	result1 = mobile_Event_Proc.firstShoppingInsert2(userId , userData);
	
	result = Members_Friend_Proc.pointInsertNow(userId);

	JSONObject jSONObject = new JSONObject(); 
	jSONObject.put("result",result);

	out.println(jSONObject.toString());
	*/
%>  