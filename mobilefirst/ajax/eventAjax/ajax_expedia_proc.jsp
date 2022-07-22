<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Event_Expdia_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	String strMm = ChkNull.chkStr(request.getParameter("mm"), "0").trim();
	String strDay = ChkNull.chkStr(request.getParameter("day"), "0").trim();
	String price = request.getParameter("price");
	String travelNum = request.getParameter("travelNum");
	
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	
	Event_Expdia_Proc event_Expdia_Proc = new Event_Expdia_Proc(); 
	
	int month = Integer.parseInt(strMm);
	int day =  Integer.parseInt(strDay);
	
	String ostype = ChkNull.chkStr(request.getParameter("ostype"), "").trim();

	
	//String userid , int month ,int day , int buyPrice , int travelNum
	int outPut = event_Expdia_Proc.ins_expedia_cashback(userId , month  ,day , price , travelNum ,ostype);
	
	JSONObject jSONObject = new JSONObject();
	
	jSONObject.put("result",outPut);
	
	out.println(jSONObject.toString());
	
%>