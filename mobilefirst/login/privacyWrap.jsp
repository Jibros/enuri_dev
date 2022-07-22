<%@ page contentType="text/html; charset=utf-8" %>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%
	
	String css = "";
	String cssType = StringUtils.defaultString(request.getParameter("cssType"));
	
	if(cssType.contains("mobiledepart")){
		css = "mobiledepart";
	}else if(cssType.contains("mobiledeal")){
		css = "mobiledeal";
	}else{
		css = "agreeWrap";
	}
    String app_id= StringUtils.defaultString(request.getParameter("app_id"),"");	
	response.sendRedirect("/mobilefirst/login/privacyWrapFooter.jsp?cssType="+css+"&app_id="+app_id);
%>
