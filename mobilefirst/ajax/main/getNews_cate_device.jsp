<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="org.apache.commons.lang3.*"%>
<%@page import="org.json.*"%>
<%@ page import="com.enuri.include.*"%>
<%@ page import="com.enuri.util.etc.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.util.image.*"%>
<%@ page import="com.enuri.util.http.*"%>
<%@ page import="com.enuri.util.date.*"%>
<%@page import="com.enuri.bean.mobile.News_Proc"%>
<%
String strCate = ChkNull.chkStr(request.getParameter("cate"),"");
String strNotin = ChkNull.chkStr(request.getParameter("notin"),"");

out.println(new News_Proc().getNewsList_device_cate(strCate,strNotin).toString());

%>