<%@ page contentType="text/json;charset=utf-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>\
<%@ page import="java.io.*, java.net.*" %>
<%
	String strUrl = ChkNull.chkStr(request.getParameter("url"));
	int timeout = 1000;		//서버 부하 방지 위해 2초로 재설정

	HttpURLConnection c = null;
	try {	//타 Page에 영향력 없으므로 Exception 처리 안함.
		URL u = new URL(strUrl);
		c = (HttpURLConnection) u.openConnection();
		c.setRequestMethod("GET");
		c.setAllowUserInteraction(false);
		c.setConnectTimeout(timeout);
		c.setReadTimeout(timeout);
		c.connect();

		int status = c.getResponseCode();

		if(status!=200){
			status = 404;
		}
		out.println("{");
		out.println("	\"imgcode\": \""+ status +"\" ");
		out.println("}");
	} catch (FileNotFoundException fe) {
		System.out.println("getImgChk.jsp] " + fe.getCause());
	} catch (Exception e) {
		System.out.println("getImgChk.jsp] " + e.getCause());
	} finally {
		if (c != null) {
        	c.disconnect();
        }
	}
%>
