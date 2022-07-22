<%@ page import="java.util.HashMap"%>
<%@ page import="com.enuri.bean.mobile.Mobile_GoodsToPricelist_Proc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>
<%@ page import="java.net.*"%>
<%
	/* hot Deal DB 저장 */
	String TYPE_JSON_OBJECT = "jsonObject";
	String TYPE_JSON_ARRAY = "jsonArray";

	String domain = "http://m.enuri.com";
	
	String GMARKET   = "536";
	String AUCTION   = "4027";
	String ST11 	 = "5910";
	String INTERPARK = "55";
	String TMON = "6641";
	String WEMAKE = "6508";
	
	try {
		
		JSONObject jSONObject =new JSONObject();
		
		String url = domain+"/mobilefirst/http/json/superDeal.json";
		JSONObject goodsJson = getJSONObjectfromHttp(url);
		
		int result = jsonToDb( GMARKET , goodsJson);
		jSONObject.put(GMARKET, result);
		
		url = domain+"/mobilefirst/http/json/allKill.json";
		result =jsonToDb(AUCTION , getJSONObjectfromHttp(url) );
		jSONObject.put(AUCTION, result);
		
		url = domain+"/mobilefirst/http/json/shocking.json";
		result = jsonToDb(ST11 , getJSONObjectfromHttp(url) );
		jSONObject.put(ST11 , result);
		
		url = domain+"/mobilefirst/http/json/tmon.json";
		result = jsonToDb(TMON , getJSONObjectfromHttp(url) );
		jSONObject.put(TMON , result);
		
		url = domain+"/mobilefirst/http/json/ssenDeal.json";
		result = jsonToDb( INTERPARK , getJSONObjectfromHttp(url));
		jSONObject.put(INTERPARK, result);
					
		url = domain+"/mobilefirst/http/json/wemake.json";
		result = jsonToDb( WEMAKE , getJSONObjectfromHttp(url));
		jSONObject.put(WEMAKE, result);
		
		out.println(jSONObject.toString());
		
	}catch(Exception e){
	}
%>
<%!public int jsonToDb(String shop_code , JSONObject goodsJson) {

	int result = 0;
	
	Mobile_GoodsToPricelist_Proc mobile_goodstopricelist_proc = new Mobile_GoodsToPricelist_Proc();
	JSONArray goodsArr = (JSONArray)goodsJson.get("goodsList");
	try{
		org.json.JSONArray jsonChang = new org.json.JSONArray(goodsArr.toString()); 
		result = mobile_goodstopricelist_proc.hotDealInsUpd( "H" ,shop_code , jsonChang );
	}catch(Exception e){
		return result;
	}
	return result;
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
