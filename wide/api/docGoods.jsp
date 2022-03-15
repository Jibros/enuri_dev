<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ page import="java.net.*,java.io.*,java.util.*"%>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%
	/**
	 * @history
	 	2020.12.24. 최조작성
	 	2021.09.08. 2차 개편
	*/	

	/********************* parameters ****************************/
	String strModelno = ConfigManager.RequestStr(request, "modelno", "");
	String strTest = ConfigManager.RequestStr(request, "test", "N");
	strTest = strTest.toUpperCase();
	
	boolean blParam = true;
	JsonResponse ret = null;

	if(strModelno.length()==0) {
		blParam = false;
	}
	
	if(!blParam) {
		ret = new JsonResponse(false).setCode(10).setParam(request);
	} else {
	
		String uHostStr = getServerIP();
		if(strTest.equals("Y")) {
			uHostStr = "192.168.213.156:8080";
		}
		String indexName = "enuri-goods";
		
		String restUrl = "";
		restUrl += "http://";
		restUrl += uHostStr;
		restUrl += "/";
		restUrl += indexName;
		restUrl += "/_mget";
		
		URL url = null;
	    HttpURLConnection httpConn = null;
	    BufferedReader in = null;
	    PrintWriter outS = null;
	    
	    url = new URL(restUrl);
	    httpConn = (HttpURLConnection)url.openConnection();

	    String strAuth = "Basic ZW51cmk6ZW51cmkxMjMhQCM=";
	    
		JSONObject postObject = new JSONObject();
		JSONArray postArray = new JSONArray();
		JSONObject paramObject = new JSONObject();
		
		paramObject.put("_id", "G"+strModelno);
		postArray.add(paramObject);
		postObject.put("docs", postArray);
		StringBuilder postData = new StringBuilder();
		postData.append(postObject.toString());
		byte[] postDataBytes = postData.toString().getBytes("UTF-8");
		
		httpConn.setRequestMethod("POST");
		httpConn.setRequestProperty("Content-Type", "application/json; UTF-8");
		httpConn.setRequestProperty("Content-Length", String.valueOf(postDataBytes.length));
		httpConn.setRequestProperty("Accept", "application/json");
		httpConn.setRequestProperty("group", "main");
		httpConn.setRequestProperty("Authorization", strAuth);
		httpConn.setConnectTimeout(3000);
		httpConn.setReadTimeout(3000);
		httpConn.setDoOutput(true);
		httpConn.setUseCaches(false);
		httpConn.getOutputStream().write(postDataBytes);
	
		in = new BufferedReader(new InputStreamReader(httpConn.getInputStream(), "UTF-8"));
		String inputLine;
		StringBuffer inputBuffer = new StringBuffer();
		while ((inputLine = in.readLine()) != null) { 
			inputBuffer.append(inputLine); 
		} 
		in.close();
		
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObjectOri = (JSONObject) jsonParser.parse(inputBuffer.toString());
		
		ret = new JsonResponse(true).setData(jsonObjectOri);
	}
	out.print(ret);
%>
<%!
private String[] serverIPAry = { 
		"192.168.213.168:8080",
		"192.168.213.168:9080",
		"192.168.213.169:8080",
		"192.168.213.169:9080"
};
public String getServerIP() {
	
	String rtnValue = "";
	ArrayList<String> retryIps = new ArrayList<String>();

	for(int i=0; i<serverIPAry.length; i++) {
		retryIps.add(serverIPAry[i]);
	}

	if(retryIps.size()>0) {
		Random r = new Random();
		int ran = r.nextInt(retryIps.size());
		rtnValue = retryIps.get(ran);
	}

	return rtnValue;
}
%>