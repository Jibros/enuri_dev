<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="com.enuri.exception.ExceptionManager"%>
<%@page import="com.enuri.bean.mobile.Mobile_Social_GoodsToPrice_Proc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>

<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.OutputStreamWriter"%>
<%@ page import="java.io.OutputStream"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.*"%>
<%@ page import="org.json.*"%>
<%@ page import="org.jsoup.*"%>
<%@ page import="org.jsoup.nodes.*"%>
<%@ page import="org.jsoup.select.*"%>
<%@ page import="org.apache.commons.lang3.*"%>
<%@page import="com.enuri.bean.mobile.Mobile_Gnb_Proc"%>
<%
JSONObject result = new JSONObject();
try { 
	String strdevFlag = ChkNull.chkStr(request.getParameter("dev"),"");
	boolean devFlag = false;
	JSONArray crawlingData = new JSONArray();
	//crawlingData = appendJSONArray(onCrawlingG9(), onCrawlingGmarket());
	//crawlingData = appendJSONArray(crawlingData, onCrawlingWmp());
	//crawlingData = appendJSONArray(crawlingData, onCrawlingGmarket());
	//crawlingData = shuffle(crawlingData);	// 셔플
	//crawlingData = selectRandomItem(crawlingData, 10);	//10개 추출
	
	if(strdevFlag.equals("Y")){
		devFlag = true;
	}
	
	//System.out.println(crawlingData.toString());
	
	result = getCouponFromDB(devFlag);
	//result.put("best", crawlingData);
	out.println(result.toString());
	
	
} catch (Exception e) {
	out.println("e:"+e.toString());
}
%>
<%!
public static final int MINIMUM_GOODS_SIZE = 10;

private JSONObject getCouponFromDB(boolean devFlag) throws Exception {
	
	String url = "http://m.enuri.com/deal/mobile/selectECouponList.deal";
	if(devFlag){
		url = "http://192.168.213.213:8080/deal/mobile/selectECouponList.deal";
	}

	HashMap<String, String> params = new HashMap<String, String>();
	JSONObject param = new JSONObject();
	
	JSONObject object = new JSONObject();
	try{
		param.put("category", "life");
		object.put("life", jsonObjectFromUrlPost(url, param).getJSONObject("param").getJSONObject("list").getJSONArray("DS_COUPON"));
		
		param.put("category", "cafe");
		object.put("cafe", jsonObjectFromUrlPost(url, param).getJSONObject("param").getJSONObject("list").getJSONArray("DS_COUPON"));
		
		param.put("category", "mart");
		object.put("mart", jsonObjectFromUrlPost(url, param).getJSONObject("param").getJSONObject("list").getJSONArray("DS_COUPON"));
		
		param.put("category", "buffet");
		object.put("buffet", jsonObjectFromUrlPost(url, param).getJSONObject("param").getJSONObject("list").getJSONArray("DS_COUPON"));
		
		param.put("category", "instant");
		object.put("instant", jsonObjectFromUrlPost(url, param).getJSONObject("param").getJSONObject("list").getJSONArray("DS_COUPON"));
		
		param.put("category", "etc");
		object.put("etc", jsonObjectFromUrlPost(url, param).getJSONObject("param").getJSONObject("list").getJSONArray("DS_COUPON"));
	
		
		param.put("category", "etc");
		object.put("best", jsonObjectFromUrlPost(url, param).getJSONObject("param").getJSONObject("list").getJSONArray("DS_COUPON"));
		
	}catch(Exception e)
	{
		
	}
	return object;
}

public JSONArray onCrawlingG9() {
	try {
		int shopCode = 7692;

		JSONObject object = jsonObjectUrlParsing("http://www.g9.co.kr/deals/category/l/400000082?channel=pc&page=1&size=100&sort=g9best&no=2493|2492|2491|2490|2489|2488|2487&h=catem,globalYN,sellerGroupSeq&filter=&_=1519629818250");
		
		JSONArray list = object.getJSONArray("deals");
		ArrayList<String> itemCodeList = new ArrayList<String>();
		for(int i=0; i<list.length(); i++) {
			itemCodeList.add(list.getJSONObject(i).optString("gdno"));
		}
		
		Mobile_Social_GoodsToPrice_Proc proc = new Mobile_Social_GoodsToPrice_Proc();
	
		return proc.matchGoodsData(shopCode, itemCodeList.toArray(new String[0]));
	} catch (Exception e) {
		callEmsAPI( getApiUrl("try/catch [e-coupon g9] " + e.toString()) );
		return new JSONArray();
	}
}

public JSONArray onCrawlingAuction() {
	try {
		int shopCode = 4027;

		HashMap<String, String> params = new HashMap<String, String>();
		params.put("categoryCode", "10000000");
		
		String url = "http://mobile.auction.co.kr/ajax/Arche.MobileWeb.Home.ECouponslide,Arche.MobileWeb.Web.ashx?_method=getCategoryCollection&_session=no";
		
		JSONObject object = jsonObjectFromUrlPost(url, params);
		
		JSONArray list = object.getJSONArray("HotDealCollection");
		ArrayList<String> itemCodeList = new ArrayList<String>();
		for(int i=0; i<list.length() && i < 10; i++) {
			itemCodeList.add(list.getJSONObject(i).optString("ItemNo"));
		}
		
		Mobile_Social_GoodsToPrice_Proc proc = new Mobile_Social_GoodsToPrice_Proc();
		
		return proc.matchGoodsData(shopCode, itemCodeList.toArray(new String[0]));
	} catch (Exception e) {
		callEmsAPI( getApiUrl("try/catch [e-coupon auction] " + e.toString()) );
		return new JSONArray();
	}
}

public JSONArray onCrawlingWmp() {
	try {
		int shopCode = 6508;
		Document doc = Jsoup.connect("http://www.wemakeprice.com/main/103900").get();
		Elements liList = doc.select("div.section_list").select("ul").select("li");
		
		ArrayList<String> itemCodeList = new ArrayList<String>();
		for(Element li : liList)
			itemCodeList.add(li.attr("deal_id"));
		
		Mobile_Social_GoodsToPrice_Proc proc = new Mobile_Social_GoodsToPrice_Proc();
		
		return proc.matchGoodsData(shopCode, itemCodeList.toArray(new String[0]));
	} catch(Exception e) {
		
		try {
			JSONArray array = new JSONArray();
			JSONObject obj = new JSONObject();
			obj.put("err", e.toString());
			array.put(obj);
			return array;
		} catch (JSONException je) {
			
		}
		callEmsAPI( getApiUrl("try/catch [e-coupon wmp] " + e.toString()) );
		return new JSONArray();
	}
}

public JSONArray onCrawlingGmarket() {
	try {
		int shopCode = 536;
		Document doc = Jsoup.connect("http://mobile.gmarket.co.kr/Best/Category?code=G12").get();
		Elements liList = doc.getElementById("list_bx").select("li");
		ArrayList<String> itemCodeList = new ArrayList<String>();
		
		for(Element li : liList) {
			String linkAddr = li.select("a").attr("href");
			String goodsCode = getQueryParamater(linkAddr).get("goodsCode");
			itemCodeList.add(goodsCode);
		}
		
		Mobile_Social_GoodsToPrice_Proc proc = new Mobile_Social_GoodsToPrice_Proc();
		
		return proc.matchGoodsData(shopCode, itemCodeList.toArray(new String[0]));
	} catch(Exception e) {
		callEmsAPI( getApiUrl("try/catch [e-coupon wmp] " + e.toString()) );
		return new JSONArray();
	}
}

public String checkCrawlingError(JSONObject result, String mallName) {
	String errApi = "";
	try {

		if (!result.getBoolean("result")) {
			int rows = result.getInt("rows");

			if (rows >= 0 && rows <= MINIMUM_GOODS_SIZE) {
				errApi = getApiUrl(mallName + " 상품 개수 이상 " + rows + " 개");
			} else {
				errApi = getApiUrl(mallName + " 크롤링 이상 "
						+ result.getString("msg"));
			}
		}
	} catch (Exception e) {
		errApi = getApiUrl(mallName + " checkCrawlingError " + e.toString());
	}

	if (errApi != null && errApi.length() > 0) {
		callEmsAPI(errApi);
	}

	return errApi;
}

private String callEmsAPI(String apiUrl) {
	return "";
	/*
	String response = "";
	try {
		URL url = new URL(apiUrl);

		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");

		// 연결 타임아웃 설정 
		conn.setConnectTimeout(3000); // 3초 
		// 읽기 타임아웃 설정 
		conn.setReadTimeout(3000); // 3초 

		InputStream in = conn.getInputStream();
		ByteArrayOutputStream out = new ByteArrayOutputStream();

		byte[] buf = new byte[1024 * 8];
		int length = 0;
		while ((length = in.read(buf)) != -1) {
			out.write(buf, 0, length);
		}

		response = new String(out.toByteArray(), "UTF-8");

		conn.disconnect();
	} catch (Exception e) {
		return e.toString();
	}

	return response;
	*/
}

public String getApiUrl(String msg) {
	//String arn = "arn:aws:sns:ap-northeast-1:351636241112:endpoint/GCM/enuri.monitoring/f142cbba-87cc-398b-938f-970437f4fb5e";
	String arn = "";
	String title = "종합몰 크롤링 메시지";
	String team = "msolution";
	String type = "warning";

	String url = "http://jca.enuri.com:8080/jqgrid/push/push_proc_ems_ajax.jsp";
	try {
		String param = "title=" + URLEncoder.encode(title) + "&msg="
				+ URLEncoder.encode(msg) + "&type=" + type + "&team="
				+ team + "&arn=" + arn;

		url += "?" + param;
	} catch (Exception e) {

	}
	return url;
}

public String checkDataMatchingError(JSONObject result, String mallName) {
	String errApi = "";
	try {

		if (!result.getBoolean("result")) {
			int rows = result.getInt("rows");

			if (rows >= 0 && rows <= MINIMUM_GOODS_SIZE) {
				errApi = getApiUrl(mallName + " 상품 매칭 개수 이상 " + rows + " 개");
			} else {
				errApi = getApiUrl(mallName + " 크롤링 이상 "
						+ result.getString("msg"));
			}
		}
	} catch (Exception e) {
		errApi = getApiUrl(mallName + " checkDataMatchingError "
				+ e.toString());
	}

	return errApi;
}

public JSONObject jsonObjectFromUrlPost(String url, HashMap<String, String> params) {
	try {
		HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
		conn.setRequestMethod("POST");
		conn.setDoOutput(true);
		
		StringBuilder paramBuilder = new StringBuilder();
		for(String key : params.keySet()) {
			String value = params.get(key);
			if(paramBuilder.length() != 0) {
				paramBuilder.append("&");
			}
			
			paramBuilder.append(URLEncoder.encode(key, "UTF-8"));
			paramBuilder.append("=");
			paramBuilder.append(URLEncoder.encode(value, "UTF-8"));
		}
		
		conn.connect();
		
		OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream());
		writer.write(paramBuilder.toString());
		writer.flush();
		
		InputStreamReader reader = new InputStreamReader(conn.getInputStream(), "UTF-8");
		
		BufferedReader in = new BufferedReader(reader);
		StringBuilder resBuilder = new StringBuilder();

		String inputLine;
		while ((inputLine = in.readLine()) != null)
			resBuilder.append(inputLine);
		
		in.close();
		
		String response = resBuilder.toString();
		try {
			if(!response.startsWith("{"))
				response = response.substring(response.indexOf("{"), response.lastIndexOf("}") + 1);
		} catch(StringIndexOutOfBoundsException e) {
			
		}
		
		return new JSONObject(response);
	} catch(Exception e) {
		JSONObject obj = new JSONObject();
		try {
			obj.put("error", e.toString());
		} catch (Exception ee) {
			
		}
		return obj;
	}
}

public JSONObject jsonObjectFromUrlPost(String url, JSONObject params) {
	try {
		HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
		conn.setRequestProperty("Content-Type", "application/json");
		conn.setRequestProperty("Accept", "*/*");
		conn.setRequestMethod("POST");
		conn.setDoOutput(true);
		
		conn.connect();
		
		OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream());
		writer.write(params.toString());
		writer.flush();
		
		InputStreamReader reader = new InputStreamReader(conn.getInputStream(), "UTF-8");
		
		BufferedReader in = new BufferedReader(reader);
		StringBuilder resBuilder = new StringBuilder();

		String inputLine;
		while ((inputLine = in.readLine()) != null)
			resBuilder.append(inputLine);
		
		in.close();
		
		return new JSONObject(resBuilder.toString());
	} catch(Exception e) {
		JSONObject obj = new JSONObject();
		try {
			obj.put("error", e.toString());
		} catch (Exception ee) {
			
		}
		return obj;
	}
}
	
private Map<String, String> getQueryParamater(String url) throws MalformedURLException {
	String[] paramList = new URL(url).getQuery().split("&");
	
	if(paramList == null || paramList.length == 0)
		return Collections.emptyMap();
	else {
		Map<String, String> result = new HashMap<String, String>();
		for(String param : paramList) {
			String[] pair = param.split("=");
			if(pair.length == 2)
				result.put(pair[0], pair[1]);
		}
		
		return result;
	}
}
public JSONObject jsonObjectUrlParsing(String strUrl)
		throws UnsupportedEncodingException, MalformedURLException,
		IOException, JSONException {

	URL urlObj = new URL(strUrl);
	HttpURLConnection conn = (HttpURLConnection) urlObj.openConnection();
	conn.setRequestMethod("GET");
	conn.setConnectTimeout(20000);
	conn.setReadTimeout(5000);
	conn.setRequestProperty("Accept-Charset", "UTF-8");
	//			conn.addRequestProperty("Accept-Language", "en-US,en;q=0.8");
	//			conn.addRequestProperty("User-Agent", "Mozilla");
	//			conn.addRequestProperty("Referer", "google.com");
	conn.setRequestProperty(
			"User-Agent",
			"Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.6) Gecko/20100625 Firefox/3.6.6");
	conn.setDoInput(true);
	conn.setDoOutput(true);

	BufferedReader in = new BufferedReader(new InputStreamReader(
			conn.getInputStream(), "UTF-8"));

	StringBuilder html = new StringBuilder();

	String inputLine;
	while ((inputLine = in.readLine()) != null) {
		html.append(inputLine);
	}

	in.close();

	conn.disconnect();

	

	BufferedReader br = new BufferedReader(new InputStreamReader((new URL(
			strUrl)).openConnection().getInputStream(), "UTF-8"));
	StringBuilder sbJson = new StringBuilder();
	String strLine = "";

	while ((strLine = br.readLine()) != null) {
		sbJson.append(strLine);
	}

	br.close();

	try {

		JSONObject jSONObject = new JSONObject(sbJson.toString());

		return jSONObject;

	} catch (JSONException e) {
	}

	return null;
}

public static JSONArray shuffle(JSONArray array) throws JSONException {
	
	JSONArray shuffled = new JSONArray();   
    ArrayList<Integer> intArr1 = new ArrayList<Integer>(array.length());
    for(int i = 0; i<array.length(); i++)
        intArr1.add(i);
    
    Collections.shuffle(intArr1);
    
    for(int idx : intArr1) {
    	shuffled.put(array.get(idx));
    }
    /*
    for(int i = 0; i < intArr1.size(); i++)
        shuffled.put(i, array.get(intArr1.get(i)));
    */
    
    return shuffled;
}

private JSONArray appendJSONArray(JSONArray arr1, JSONArray arr2) throws JSONException {
	String tmpArr1 = arr1.toString();
	tmpArr1 = tmpArr1.substring(tmpArr1.indexOf("[") + 1, tmpArr1.lastIndexOf("]"));
	
	String tmpArr2 = arr2.toString();
	tmpArr2 = tmpArr2.substring(tmpArr2.indexOf("[") + 1, tmpArr2.lastIndexOf("]"));
	
	return new JSONArray("[" + tmpArr1 + ", " + tmpArr2 + "]");
}

private JSONArray selectRandomItem(JSONArray list, int size) throws JSONException {
	Random rnd = new Random(System.currentTimeMillis());
	JSONArray rndList = new JSONArray();
	int[] idxArray = new int[size];
	
	for(int i=0; i<list.length(); i++) {
		int newIdx = rnd.nextInt(list.length());
		for(int oldIdx : idxArray) {
			if(newIdx == oldIdx) {
				i--;
				continue;
			}
		}
		
		idxArray[i] = newIdx;
		if(i == size) break;
	}
	
	for(int idx : idxArray)
		rndList.put(list.getJSONObject(idx));
	
	return rndList;
}

%>
