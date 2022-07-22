<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.enuri.bean.mobile.Mobile_Gnb_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	
	String cate = StringUtils.defaultString(request.getParameter("cate"));
	String flag = StringUtils.defaultString(request.getParameter("flag"));
	
	if(flag.equals("0") || flag.equals("1") || flag.equals("2")){
		Mobile_Gnb_Proc mobile_Gnb_Proc = new Mobile_Gnb_Proc();
		JSONArray jSONArray= mobile_Gnb_Proc.mobileCategoryLevelToJson(4,cate,flag);
	
		out.println(jSONArray);
	}else{
		out.println("[]");
	}
	
%>
