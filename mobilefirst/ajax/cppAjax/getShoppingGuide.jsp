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
<%
	String strKbcate = ChkNull.chkStr(request.getParameter("kbcate"),""); // 지식통카테고리
	String strGcate = ChkNull.chkStr(request.getParameter("gcate"),""); // CPP카테고리
	int kbCate1Idx = 0;

	Cpp_Proc cpp_proc = new Cpp_Proc();

	String[][] ArrKbCategory = new String[7][];
	String[] arrCate = cpp_proc.getItgCategory(strGcate);

	out.println(new Cpp_Proc().getGuide(arrCate, 1, 4));
%>
