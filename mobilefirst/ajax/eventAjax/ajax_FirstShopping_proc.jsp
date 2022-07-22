<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	Mobile_Event_Proc mobile_Event_Proc = new Mobile_Event_Proc();
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	String userData  =  StringUtils.defaultString(request.getParameter("chkid"));
	//String userData  = "c7e836450927fa75";
    	
    //201612 첫구매 
	boolean result = mobile_Event_Proc.firstShoppingInsert3(userId , userData);
	
	JSONObject jSONObject = new JSONObject(); 
	jSONObject.put("result",result);
    jSONObject.put("userId",userId);  
    jSONObject.put("userData",userData);
    out.println(jSONObject.toString());
%>