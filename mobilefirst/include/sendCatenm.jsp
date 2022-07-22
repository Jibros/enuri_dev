<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.main.Category_Proc"%>
<%@ page import="com.enuri.bean.main.Category_Data"%>
<%
	String strCate = ChkNull.chkStr(request.getParameter("cate"),"00000000");	//카테고리

	String strCatenm = ReplaceStr.replace(Category_Proc.Category_Name_One(CutStr.cutStr(strCate,4))," > ","/");
%><%=strCatenm %>