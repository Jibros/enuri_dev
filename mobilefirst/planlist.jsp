<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
	String strVersion   = ChkNull.chkStr(request.getParameter("version"),"");
	String strApp_p   = ChkNull.chkStr(request.getParameter("app"),"");
	String strID = ChkNull.chkStr(request.getParameter("t"),"B_20150604110000");
	if(1==1){
		response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
		response.setHeader("Location", "/m/planlist.jsp?t="+strID);
		return;
	}
%>