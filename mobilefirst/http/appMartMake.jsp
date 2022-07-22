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
	
	String serverTarget = "m";
	String baseUrl = "http://localhost/mobilefirst";
	String jsonUrl = baseUrl + "/http/json";

	
	String pages[][] = { 
			{TYPE_JSON_OBJECT, jsonUrl + "/bannerAndCate.json"},
			{TYPE_JSON_OBJECT, jsonUrl + "/allMart.json"},
			{TYPE_JSON_ARRAY, jsonUrl + "/shopMainLogo.json"}
		
		};

	try {
		
		JSONObject makeJson = new JSONObject();
		
		for (int i = 0; i < pages.length; i++ ) {
			
			String tmpSplit[] = pages[i][1].split("/");
			String type = pages[i][0];
			String name = tmpSplit[tmpSplit.length-1];
			
			if(type.equals(TYPE_JSON_OBJECT)) {
				
				makeJson.put(name, getJSONObjectfromHttp(pages[i][1]));
			} else if(type.equals(TYPE_JSON_ARRAY)){
				makeJson.put(name, getJSONArrayfromHttp(pages[i][1]));
			}

		}
		makeJson.put("shopimage_preurl","http://img.enuri.info/images");
		
		out.print(makeJson.toString());
	}catch(Exception e)
	{
		
	}
%>
<%!public JSONArray getJSONArrayfromFile(String filePath) {

		String news_data = "";
		StringBuffer news_buffer = new StringBuffer();

		try {
			InputStream inputStream = new FileInputStream(filePath);
			BufferedReader in = new BufferedReader(new InputStreamReader(inputStream, "utf-8"));
			while ((news_data = in.readLine()) != null) {
				news_buffer.append(news_data);
			}
			in.close();
			inputStream.close();

			JSONParser parser = new JSONParser();
			Object obj = parser.parse(news_buffer.toString());
			//"/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/ajax/appAjax/getDefine_new_Extra_ajax.jsp"));

			return (JSONArray) obj;
		} catch (Exception e) {

		}
		return null;
	}

	public JSONArray getJSONArrayfromFileDeal(String filePath) {

		String news_data = "";
		StringBuffer news_buffer = new StringBuffer();

		try {
			InputStream inputStream = new FileInputStream(filePath);
			BufferedReader in = new BufferedReader(new InputStreamReader(inputStream, "utf-8"));
			while ((news_data = in.readLine()) != null) {
				news_buffer.append(news_data);
			}
			in.close();
			inputStream.close();

			JSONParser parser = new JSONParser();
			Object obj = parser.parse(news_buffer.toString());
			//"/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/ajax/appAjax/getDefine_new_Extra_ajax.jsp"));

			JSONArray json = (JSONArray) obj;

			JSONArray returnarr = new JSONArray();
			for (int i = 0; i < json.size(); i++) {


			JSONObject object = (JSONObject)json.get(i);	
			String b = (String)object.get("GOODS_EXPO_FLAG"); 
				if(b.equals("Y")){
					returnarr.add(json.get(i));
				}
			}

			return returnarr;
		} catch (Exception e) {

		}
		return null;
	}

	public JSONArray getJSONArrayfromFile(String filePath, String strMax, String title) {
		String news_data = "";
		StringBuffer news_buffer = new StringBuffer();
		try {
			int max = Integer.parseInt(strMax);
			InputStream inputStream = new FileInputStream(filePath);
			BufferedReader in = new BufferedReader(new InputStreamReader(inputStream, "utf-8"));
			while ((news_data = in.readLine()) != null) {
				news_buffer.append(news_data);
			}
			in.close();
			inputStream.close();

			JSONParser parser = new JSONParser();
			Object obj = parser.parse(news_buffer.toString());

			JSONObject json = (JSONObject) obj;
			JSONArray arr = (JSONArray) json.get(title);

			JSONArray returnarr = new JSONArray();
			for (int i = 0; i < arr.size() && i < max; i++) {
				returnarr.add(arr.get(i));
			}

			return returnarr;
		} catch (Exception e) {

		}

		return null;
	}
	public JSONObject getJSONObjectfromFile(String filePath) {
		String news_data = "";
		StringBuffer news_buffer = new StringBuffer();

		try {
			InputStream inputStream = new FileInputStream(filePath);
			BufferedReader in = new BufferedReader(new InputStreamReader(inputStream, "utf-8"));
			while ((news_data = in.readLine()) != null) {
				news_buffer.append(news_data);
			}
			in.close();
			inputStream.close();

			JSONParser parser = new JSONParser();
			Object obj = parser.parse(news_buffer.toString());
			return (JSONObject) obj;
		} catch (Exception e) {

		}
		return null;
	}

	public JSONObject getJSONObjectfromHttp(String strurl) {
		try {
			String recv;
			StringBuffer recvbuff = new StringBuffer();
			URL jsonpage = new URL(strurl);
			URLConnection urlcon = jsonpage.openConnection();
			BufferedReader buffread = new BufferedReader(new InputStreamReader(urlcon.getInputStream(), "utf-8"));
			while ((recv = buffread.readLine()) != null)
				recvbuff.append(recv);
			buffread.close();
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(recvbuff.toString());
			return (JSONObject) obj;
		} catch (Exception e) {

			
		}
		return null;
	}
	
	public JSONArray getJSONArrayfromHttp(String strurl) {
		try {
			String recv;
			StringBuffer recvbuff = new StringBuffer();
			URL jsonpage = new URL(strurl);
			URLConnection urlcon = jsonpage.openConnection();
			BufferedReader buffread = new BufferedReader(new InputStreamReader(urlcon.getInputStream(), "utf-8"));
			while ((recv = buffread.readLine()) != null)
				recvbuff.append(recv);
			buffread.close();

			JSONParser parser = new JSONParser();
			Object obj = parser.parse(recvbuff.toString());
			return (JSONArray) obj;
		} catch (Exception e) {

		}
		return null;
	}
%>
