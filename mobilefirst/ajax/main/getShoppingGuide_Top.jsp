<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilenew/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Shopping_Guide_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<% 
	Shopping_Guide_Proc shopping_guide_proc = new Shopping_Guide_Proc();
	
	JSONObject jSONObject = new JSONObject();
	jSONObject = shopping_guide_proc.getShoppingGuideList_Top();
	
	out.println(jSONObject);
%>