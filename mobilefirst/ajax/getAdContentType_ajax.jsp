<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Know_box_Proc"%>
<%=new Know_box_Proc().get_AdByContentType(4,ChkNull.chkStr(request.getParameter("strCate"),"0404"),5,ChkNull.chkStr(request.getParameter("strNo"),"")).toString()%>