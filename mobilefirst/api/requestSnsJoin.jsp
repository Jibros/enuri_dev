<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="org.json.JSONObject"%>

<%
JSONObject jsonObject = new JSONObject();
jsonObject.put("result", "ok");
out.println(jsonObject.toString());
%>