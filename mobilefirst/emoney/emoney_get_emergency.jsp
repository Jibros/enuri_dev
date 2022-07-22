<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.lsv2016.Emoney_Emergency_Data"%>
<jsp:useBean id="Emoney_Emergency_Data" class="com.enuri.bean.lsv2016.Emoney_Emergency_Data" scope="page" />
<%@ page import="com.enuri.bean.lsv2016.Emoney_Emergency_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>


<%
	Emoney_Emergency_Proc emoney_proc = new Emoney_Emergency_Proc();
	

	JSONObject jSONObject = new JSONObject(); 
	jSONObject = emoney_proc.getEmoneyJson();
	//jSONObject.put("BANLIST",jSONObject);
	
	
	out.println(jSONObject.toString());
%>