<%@page import="com.enuri.bean.mobile.HMacGenerator"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding="utf-8"%>

<%


if (HMacGenerator.checkApiHash(request)) {
	String path = "/mobilefirst/api/appLP" + (request.getServerName().contains("dev.enuri.com") ? "_save.jsp" : ".jsp");
	request.getRequestDispatcher(path).forward(request, response);
} else {
	out.println("{}");
}
%>