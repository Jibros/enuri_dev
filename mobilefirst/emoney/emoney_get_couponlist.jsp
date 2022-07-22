<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Emoney_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.simple.*"%>
<%
	String strUserid = cb.GetCookie("MEM_INFO","USER_ID");

	String strIsUse = ChkNull.chkStr(request.getParameter("isuse"),"");	

	JSONArray jSONArray = new JSONArray(); 
	//strUserid = "cherub1004";   

	Emoney_Proc emoney_proc = new Emoney_Proc(); 
	jSONArray = emoney_proc.get_CouponList(strUserid, strIsUse);		// 0:미사용 쿠폰, 1:사용완료
	
	 
	JSONObject jSONObject = new JSONObject(); 
	
	jSONObject.put("couponlist",jSONArray);
	 
	out.println(jSONObject.toString());
	
%>