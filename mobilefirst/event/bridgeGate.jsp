<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%

	String from = ChkNull.chkStr(request.getParameter("from"),"");
	
	if(	ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0  ){
		
		if(from.equals("MC")){
			response.sendRedirect("http://api2.tnkfactory.com/tnk/api/ref/v1/6451/21228");
		}else if(from.equals("LG")){
			response.sendRedirect("http://api2.tnkfactory.com/tnk/api/ref/v1/6451/21230");
		}else if(from.equals("TG")){
			response.sendRedirect("http://api2.tnkfactory.com/tnk/api/ref/v1/6451/21231");
		}else if(from.equals("CR")){
			response.sendRedirect("http://api2.tnkfactory.com/tnk/api/ref/v1/6451/21232");
		}else if(from.equals("CL")){
			response.sendRedirect("http://api2.tnkfactory.com/tnk/api/ref/v1/6451/21233");
		}else{
			response.sendRedirect("https://play.google.com/store/apps/details?id=com.enuri.android");
		}

	}else if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0 ){
		response.sendRedirect("https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8");
	}
	
%>   
