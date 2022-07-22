<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Stamp_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
    Mobile_Stamp_Proc mobile_Stamp_Proc = new Mobile_Stamp_Proc();
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
    String startDate = ChkNull.chkStr(request.getParameter("startDate"));//이벤트시작일
    int purchaseCnt = 0;

// 	purchaseCnt = mobile_Stamp_Proc.getPurchaseCount(userId,startDate);
   	purchaseCnt = mobile_Stamp_Proc.getPurchaseCount2(userId,startDate,0);

    JSONObject jSONObject = new JSONObject();
    jSONObject.put("purchaseCnt",purchaseCnt);
	out.println(jSONObject.toString());
%>