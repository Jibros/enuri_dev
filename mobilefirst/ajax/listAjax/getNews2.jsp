<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="org.apache.commons.lang3.*"%>
<%@page import="org.json.*"%>
<%@ page import="com.enuri.include.*"%>
<%@ page import="com.enuri.util.etc.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.util.image.*"%>
<%@ page import="com.enuri.util.http.*"%>
<%@ page import="com.enuri.util.date.*"%>
<%@page import="com.enuri.bean.mobile.Cpp_Proc"%>
<%@page import="com.enuri.bean.mobile.Cpp_Proc2"%>
<%
	
	String strGcate = ChkNull.chkStr(request.getParameter("gcate"	    ), ""); //  CPP카테고리
	String strLLCate= "01";
	
	Cpp_Proc2 cpp_Proc2 = new Cpp_Proc2(); 
	
	//gcate 1~4 기존 운영, 5~7 knowbox 데이터 가져옴
	if(strGcate.equals("1")){
		strLLCate = "01"; 
	}else if(strGcate.equals("2")){
		strLLCate = "02";
	}else if(strGcate.equals("3")){
		strLLCate = "03";
	}else if(strGcate.equals("4")){
		strLLCate = "04";
	}else if(strGcate.equals("5")){
		strLLCate = "15";
	}else if(strGcate.equals("6")){
		strLLCate = "16";
	}else if(strGcate.equals("7")){
		strLLCate = "17"; 
	}   
	
	if(strGcate.equals("1") || strGcate.equals("2") || strGcate.equals("3")|| strGcate.equals("4")){
		out.println(new Cpp_Proc().getNews(strLLCate).toString());
 	}else{ 
 		out.println(new Cpp_Proc2().getNews2(strLLCate).toString());
 	} 
%>  
 