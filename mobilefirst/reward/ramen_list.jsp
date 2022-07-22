<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Reward_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.simple.*"%>
<%
 
	JSONArray jSONArray = new JSONArray(); 
	 
	Reward_Proc reward_proc = new Reward_Proc(); 
	jSONArray = reward_proc.get_RamenList();
	
	out.println(jSONArray.toString());	
	
%> 