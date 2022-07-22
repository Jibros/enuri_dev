<%@ page contentType="text/json;charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="java.io.*, java.net.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.text.ParseException" %>
<%
/*
	String strUrl = ChkNull.chkStr(request.getParameter("url"));
	int timeout = 5000;	//timeout 2초 설정 : 2초 이후 Connection 끊어버림.
	 
	//try {	//타 Page에 영향력 없으므로 Exception 처리 안함.
		URL u = new URL(strUrl);
		HttpURLConnection c = (HttpURLConnection) u.openConnection();
		c.setRequestMethod("GET");
		c.setRequestProperty("Content-length", "0");
		c.setUseCaches(false); 
		c.setAllowUserInteraction(false);
		c.setConnectTimeout(timeout);
		c.setReadTimeout(timeout);
		c.connect();
	 
		int status = c.getResponseCode();
	
		BufferedReader br = new BufferedReader(new InputStreamReader(c.getInputStream(), "UTF-8"));
	    StringBuilder sb = new StringBuilder();
	    String line;
	     
	    while ((line = br.readLine()) != null) {
	        sb.append(line);
	    }
	    br.close();
	    out.print(sb);
*/
	//} catch (FileNotFoundException fe) {
	//	System.out.println("edGetItems.jsp] " + fe.getCause());
	//} catch (Exception e) {
	//	System.out.println("edGetItems.jsp] " + e.getCause());
	//}

%>
