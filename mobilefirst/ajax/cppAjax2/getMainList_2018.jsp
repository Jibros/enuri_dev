<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="org.apache.commons.lang3.*"%>
<%@page import="org.json.*"%>
<%@ page import="com.enuri.include.*"%>
<%@ page import="com.enuri.util.etc.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.util.image.*"%>
<%@ page import="com.enuri.util.http.*"%>
<%@ page import="com.enuri.util.date.*"%>
<%@page import="com.enuri.bean.mobile.Cpp_Proc_2018"%>
<%@page import="com.enuri.bean.mobile.Cpp_Data"%>

<% 
	
	String strGcate = ChkNull.chkStr(request.getParameter("gcate"	    ), "1"); //  CPP카테고리
	
	strGcate ="1"+strGcate; 
	
	out.println(new Cpp_Proc_2018().CppList(strGcate).toString());
 
%> 