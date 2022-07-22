<%@page import="java.util.Random"%>
<%@page import="com.enuri.bean.mobile.Mobile_GoodsToPricelist_Proc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>
<%@page import="java.net.*"%>
<%
	/* 특가모음 DB 저장 */

	String TYPE_JSON_OBJECT = "jsonObject";
	String TYPE_JSON_ARRAY = "jsonArray";

	String domain = "http://m.enuri.com";
	
	String GMARKET   = "536";
	String AUCTION   = "4027";
	String ST11 	 = "5910";
	String INTERPARK = "55";
	
	int result = 0;
	
	String url = "";
	
	try {
		
		Random r = new Random(); //객체생성
        int a = r.nextInt(10)+1;      
		
		JSONObject jSONObject =new JSONObject();
				
		url = domain+"/mobilefirst/http/json/bestAuction.json?v="+a;
		result =jsonToDb(AUCTION , getJSONObjectfromHttp(url) );
		jSONObject.put("AUCTION", result);
		
		url = domain+"/mobilefirst/http/json/bestInterPark.json?v="+a;
		result = jsonToDb( INTERPARK , getJSONObjectfromHttp(url));
		jSONObject.put("INTERPARK", result);
		
		url = domain+"/mobilefirst/http/json/best11st.json?v="+a;
		result = jsonToDbGmarket(ST11 , getJSONObjectfromHttp(url) );
		jSONObject.put("ST11" , result);
		
		url = domain+"/mobilefirst/http/json/bestGmarket.json?v="+a;
		result = jsonToDbGmarket( GMARKET , getJSONObjectfromHttp(url));
		jSONObject.put("GMARKET", result);
		
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
		result = mobile_goodstopricelist_proc.hotDealInsUpd( "B" , shop_code , jsonChang );
		
	}catch(Exception e){
		
		System.out.println(shop_code+">>>> e:"+e);
		return result;
		
	}
	
	return result;
}
%>
<%!public int jsonToDbGmarket(String shop_code , JSONObject goodsJson) {

	int result = 0;
	
	Mobile_GoodsToPricelist_Proc mobile_goodstopricelist_proc = new Mobile_GoodsToPricelist_Proc();
	JSONArray goodsArr = (JSONArray)goodsJson.get("goodsList");
	
	try{
		
		if("536".equals(shop_code)){
			
			String url = "http://localhost:8080/mobilefirst/http/shopDealMake.jsp?dealType=4";
			System.out.println("11111");
			JSONObject hardGoodsJson = getJSONObjectfromHttp(url);
			System.out.println("2222");
			
			goodsArr.addAll((JSONArray)hardGoodsJson.get("goodsList"));
			
			url = "http://localhost:8080/mobilefirst/http/shopDealMake.jsp?dealType=5";
			hardGoodsJson = getJSONObjectfromHttp(url);
			System.out.println("3333");
			
			goodsArr.addAll((JSONArray)hardGoodsJson.get("goodsList"));
			
			url = "http://localhost:8080/mobilefirst/http/shopDealMake.jsp?dealType=6";
			
			hardGoodsJson = getJSONObjectfromHttp(url);
			System.out.println("4444");
			
			goodsArr.addAll((JSONArray)hardGoodsJson.get("goodsList"));
			
			url = "http://localhost:8080/mobilefirst/http/shopDealMake.jsp?dealType=7";
			hardGoodsJson = getJSONObjectfromHttp(url);
			
			goodsArr.addAll((JSONArray)hardGoodsJson.get("goodsList"));
			System.out.println("55555");
			
		
		} else if( "5910".equals(shop_code) ){
		
			//String url = "http://localhost:8080/mobilefirst/http/shopDealMake.jsp?dealType=8";
			//goodsArr.addAll((JSONArray)getJSONObjectfromHttp(url).get("goodsList"));
		}
		
		org.json.JSONArray jsonChang = new org.json.JSONArray(goodsArr.toString());
		
		System.out.println(jsonChang.toString());
		
		result = mobile_goodstopricelist_proc.hotDealInsUpd( "B" , shop_code , jsonChang );
		
	}catch(Exception e){
		System.out.println(shop_code+">>>> e:"+e);
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
