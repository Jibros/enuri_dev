<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
if(true){
	response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
	response.setHeader("Location", "http://m.enuri.com/m/vip.jsp?"+request.getQueryString());
	//response.sendRedirect("/m/vip.jsp?"+request.getQueryString());
	return ;
}

%>