<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_HitBrand_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	Mobile_HitBrand_Proc hit_Brand_Proc = new Mobile_HitBrand_Proc();
	   
	JSONArray jSONArray =  hit_Brand_Proc.getHitBrandLIst();   
    out.println(jSONArray.toString());

%>