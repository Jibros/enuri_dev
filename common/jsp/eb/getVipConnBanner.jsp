<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.bean.main.GetLoadExternalPage"%>
<%
out.println(new GetLoadExternalPage().getUrlPage(URLDecoder.decode(ChkNull.chkStr(request.getParameter("url")),"utf-8")));
%>