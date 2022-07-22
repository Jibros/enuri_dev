<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Hit_Brand_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	String event_id = "2017010301";
	String ostype = StringUtils.defaultString(request.getParameter("ostype"),"M");
	
	Hit_Brand_Proc hit_Brand_Proc = new Hit_Brand_Proc();
	   
	//히트 브랜드 이벤트 등록
	JSONObject jSONObject =  hit_Brand_Proc.ins_vote(userId,event_id,ostype);   
	
    out.println(jSONObject.toString());

%>