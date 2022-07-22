<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Stamp_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
    Mobile_Stamp_Proc mobile_Stamp_Proc = new Mobile_Stamp_Proc();
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
    //userId="villagegg";
	
  //String eventCode =ChkNull.chkStr(request.getParameter("eventCode"),"2017010201");
	
	int purchaseCnt = mobile_Stamp_Proc.getPurchaseCount(userId,"20170102");
    
    JSONObject jSONObject = new JSONObject();	 
    jSONObject.put("purchaseCnt",purchaseCnt);
	//jSONObject.put("purchaseCnt",12);
	out.println(jSONObject.toString());
%>