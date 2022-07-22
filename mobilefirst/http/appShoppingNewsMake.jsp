<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>


<%@page import="java.net.*"%>

<%
	String TYPE_JSON_OBJECT = "jsonObject";
	String TYPE_JSON_ARRAY = "jsonArray";
	
	String serverTarget = "dev";

	String getNews_device ="http://" + serverTarget +".enuri.com/mobilefirst/api/main/newsTab_all.jsp";
	String shoppingNewsTap ="http://" + serverTarget +".enuri.com/mobilefirst/api/main/newsTab.json";
	

	try {
		
		JSONObject makeJson = new JSONObject();
		makeJson.put("getNews_device", getJSONObjectfromHttp(getNews_device));
		makeJson.put("newsTab", getJSONObjectfromHttp(shoppingNewsTap));
	
		out.print(makeJson.toString());
	}catch(Exception e)
	{
		
	}
%>
<%!

	public JSONObject getJSONObjectfromHttp(String strurl) {
		try {
			String recv;
			StringBuffer recvbuff = new StringBuffer();
			URL jsonpage = new URL(strurl);
			URLConnection urlcon = jsonpage.openConnection();
			BufferedReader buffread = new BufferedReader(new InputStreamReader(urlcon.getInputStream(), "utf-8"));
			int c;
			while ((c = buffread.read()) != -1)
				recvbuff.append((char)c);
			buffread.close();
			
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(recvbuff.toString());
			return (JSONObject) obj;
		} catch (Exception e) {

		}
		return null;
	}

%>
