<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.bean.event.every.HitBrandProc_201612"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="java.util.*,java.text.*,java.net.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="java.net.UnknownHostException"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="HitBrandProc_201612" class="com.enuri.bean.event.every.HitBrandProc_201612" scope="page"  />
<%
	String getIp = "-";
	try{
		getIp = StringUtils.defaultString(request.getRemoteHost());
	}catch(Exception e){
		getIp = StringUtils.defaultString(request.getHeader("x-forwarded-for"));
		e.printStackTrace();
	}

	Map<String, String> paramMap = new HashMap<String, String>();
	paramMap.put("uniqueCode",ChkNull.chkStr(request.getParameter("uniqueCode")).trim());
	paramMap.put("ip",ChkNull.chkStr(getIp).trim());
	paramMap.put("logFlag",ChkNull.chkStr(request.getParameter("logFlag")).trim());
	paramMap.put("device",ChkNull.chkStr(request.getParameter("device")).trim());
	paramMap.put("eventId",ChkNull.chkStr(request.getParameter("eventId"),"2017061201").trim());
	new HitBrandProc_201612().insertLog(paramMap);
%>