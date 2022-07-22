<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_HitBrand_Proc2"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	Mobile_HitBrand_Proc2 hit_Brand_Proc = new Mobile_HitBrand_Proc2();
	   
	JSONArray jSONArray =  hit_Brand_Proc.getHitBrandLIst("20171211");   	
    out.println(jSONArray.toString());

%>