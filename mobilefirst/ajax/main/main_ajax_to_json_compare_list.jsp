<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilenew/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Goods_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<% 
	Mobile_Goods_Proc mobile_goods_proc = new Mobile_Goods_Proc();
	
	JSONObject jSONObject = new JSONObject();
	jSONObject = mobile_goods_proc.mobileGetCompareList();
	
	out.println(jSONObject);
%>