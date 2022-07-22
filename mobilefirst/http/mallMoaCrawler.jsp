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

	String gs = onCrawlingGS();
	String cj = onCrawlingCJ();
	String hmall = onCrawlingHyunDai();
	String q10 = onCrawlingQ10();
	String ns = onCrawlingNS();
	String ssg = onCrawlingSSG();

	JSONObject resultJSON = new JSONObject();
	resultJSON.put("gs", gs);
	resultJSON.put("cj", cj);
	resultJSON.put("hmall", hmall);
	resultJSON.put("q10", q10);
	resultJSON.put("ns", ns);
	resultJSON.put("ssg", ssg);
	
	out.println(resultJSON.toString());
%>
<%!

public static final int MINIMUM_GOODS_SIZE = 10;

public void onErrorCrawling(String mallName) {
	
}

public void onErrorDataMatching(String mallName) {
	
}

public String checkCrawlingError(JSONObject result, String mallName) {
	String errApi = "";
	try {
		
		if(!result.getBoolean("result")) {
			int rows = result.getInt("rows");
			
			if(rows >= 0 && rows <= MINIMUM_GOODS_SIZE) {
				errApi = getApiUrl(mallName + " 상품 개수 이상 " + rows + " 개");
			} else {
				errApi = getApiUrl(mallName + " 크롤링 이상 " + result.getString("msg"));
			}
		}
	} catch (Exception e) {
		errApi = getApiUrl(mallName + " checkCrawlingError " + e.toString());
	}
	
	return errApi;
}

public String getApiUrl(String msg) {
	String arn = "";
	String title = "종합몰 크롤링 오류 메시지";
	String team = "msolution";
	String type = "warning";
	String url = "http://jca.enuri.com:8080/jqgrid/push_proc_ems_ajax.jsp";

	url 
	+= "?title=" + title
	+ "&msg=" + msg
	+ "&type=" + type
	+ "&team=" + team
	+ "&arn=" + arn;
	
	return url;
}

public String checkDataMatchingError(JSONObject result, String mallName) {
	String errApi = "";
	try {
		
		if(!result.getBoolean("result")) {
			int rows = result.getInt("rows");
			
			if(rows >= 0 && rows <= MINIMUM_GOODS_SIZE) {
				errApi = getApiUrl(mallName + " 상품 매칭 개수 이상 " + rows + " 개");
			} else {
				errApi = getApiUrl(mallName + " 크롤링 이상 " + result.getString("msg"));
			}
		}
	} catch (Exception e) {
		errApi = getApiUrl(mallName + " checkDataMatchingError " + e.toString());
	}
	
	return errApi;
}

public String onCrawlingGS() {
	try {
		
	    Document doc = Jsoup.connect("http://gsshop.com/deal/dealListCtrgCache.gs?dealGbn=best&rownum=400&kind=all&sectId=all&orderBy=popular")
	    		.timeout(6000).get();
	    int shopCode = 75;
	    ArrayList<String> itemCodeList = new ArrayList<String>();

	    Elements itemElements = doc.select(".product-item");
	    for (Element item : itemElements) {
	    	String itemCode = item.attr("data-prdid");
	    	itemCodeList.add(itemCode);
	    }
	    
	    Mobile_Social_GoodsToPrice_Proc socialProc = new Mobile_Social_GoodsToPrice_Proc();
	    String[] codes = itemCodeList.toArray(new String[0]);
		JSONObject result = socialProc.insertGoodsData(shopCode, codes);
		result.put("insCount", itemCodeList.size());
		
		if(result.getBoolean("result")) {
			JSONObject result2 = socialProc.makeGoodsDataJSON(shopCode, "gsshop");
			return result2.getString("result");
		} else {
			return result.getString("result");
		}
		
	} catch (IOException e) { //Jsoup의 connect 부분에서 IOException 오류가 날 수 있으므로 사용한다.
		e.printStackTrace();
		return e.toString();
	} catch (JSONException je) {
		return je.toString();
	} catch (ExceptionManager em) {
		return em.toString();
	}
}

public String onCrawlingCJ() {
	try {
		int shopCode = 806;
		String cjImgRoot = "http://thumb.cjmall.net/unsafe/640x320";


		/*
		http://display.cjmall.com/c/rest/module/contList?id=000003&cjEmpYn=false&type=H&pmType=M //라이프
		http://display.cjmall.com/c/rest/module/contList?id=000004&cjEmpYn=false&type=H&pmType=M //스타일
		http://display.cjmall.com/c/rest/module/contList?id=000243&cjEmpYn=false&type=H&pmType=M //패션소호
		*/
		
		String[] urlList = new String[]{
					"http://display.cjmall.com/c/rest/module/contList?id=000003&cjEmpYn=false&type=H&pmType=M",
					"http://display.cjmall.com/c/rest/module/contList?id=000004&cjEmpYn=false&type=H&pmType=M"};
		
		ArrayList<String> itemCodeList = new ArrayList<String>();
		JSONArray goodsJsonList = new JSONArray();
		java.util.regex.Pattern p = java.util.regex.Pattern.compile("[0-9]*?");
		
		for(String url : urlList) {
			JSONArray rootJson = (JSONArray)((JSONObject) jsonObjectUrlParsing(url).get("result")).get("moduleContApiTupleList");
			
			int tryItemCount = 0;
			boolean bbb = false;
			for(int i=0; i<rootJson.length() && !bbb; i++) {
			
				JSONArray tmpItemList = (JSONArray) ((JSONObject)rootJson.get(i)).get("cateContApiTupleList");
				
				if(tmpItemList == null)
					continue;
				
				for(int j=0; j<tmpItemList.length(); j++) {
				
					JSONObject jsonGoods = (JSONObject) tmpItemList.get(j);
				
					if(jsonGoods != null && jsonGoods.has("contVal") ) {
						String itemCode = (String) jsonGoods.get("contVal");
				
						java.util.regex.Matcher m = p.matcher(itemCode);
						if(m.matches()) {
							itemCodeList.add(itemCode);
						}
					}
				
					if(jsonGoods.has("subCateContApiTupleList")) {
						JSONArray subList = (JSONArray)jsonGoods.get("subCateContApiTupleList");
					
						for(int k=0; k<subList.length(); k++) {
							JSONObject subGoods = (JSONObject) subList.get(k);
						
							if(subGoods != null && subGoods.has("contVal") ){
								String itemCode = (String) subGoods.get("contVal");
							
								java.util.regex.Matcher m = p.matcher(itemCode);
								if(m.matches()) {
									itemCodeList.add(itemCode);
								}
							}
						}
					}
				}
			}
		}
		
		Mobile_Social_GoodsToPrice_Proc socialProc = new Mobile_Social_GoodsToPrice_Proc();
		String[] codes = itemCodeList.toArray(new String[0]);
		JSONObject result = socialProc.insertGoodsData(shopCode, codes);
		result.put("insCount", itemCodeList.size());

		if(result.getBoolean("result")) {
			JSONObject result2 = socialProc.makeGoodsDataJSON(shopCode, "CJmall");
			return result2.getString("result");
		} else {
			return result.getString("result");
		}

	} catch (IOException e) { //Jsoup의 connect 부분에서 IOException 오류가 날 수 있으므로 사용한다.
		e.printStackTrace();
		System.out.println("onCrawlingCJ io");
		return e.toString();
	} catch (JSONException je) {
		System.out.println("onCrawlingCJ json");
		return je.toString();
	} catch (ExceptionManager em) {
		System.out.println("onCrawlingCJ em");
		return em.toString();
	}
}

public String onCrawlingQ10() {
	try {
		int shopCode = 7857;
		String[] shopName = new String[]{"Qoo10"};
		Mobile_Social_GoodsToPrice_Proc socialProc = new Mobile_Social_GoodsToPrice_Proc();
		JSONObject result = socialProc.insertHardGoodsData(shopCode, shopName);
		
		if(result.getBoolean("result")) {
			JSONObject result2 = socialProc.makeGoodsDataJSON(shopCode, shopName);
			return result2.getString("result");
		} else {
			return result.getString("result");
		}
		
	} catch(Exception e) {
		return e.toString();
	}
}

public String onCrawlingNS() {
	try {
		int shopCode = 974;
		String[] shopName = new String[]{"nsmall"};
		Mobile_Social_GoodsToPrice_Proc socialProc = new Mobile_Social_GoodsToPrice_Proc();
		JSONObject result = socialProc.insertHardGoodsData(shopCode, shopName);
		
		if(result.getBoolean("result")) {
			JSONObject result2 = socialProc.makeGoodsDataJSON(shopCode, shopName);
			return result2.getString("result");
		} else {
			return result.getString("result");
		}
		
	} catch(Exception e) {
		return e.toString();
	}
}

public String onCrawlingSSG() {
	try {
		int shopCode = 47;
		String[] shopName = new String[]{"ssg", "emart"};
		Mobile_Social_GoodsToPrice_Proc socialProc = new Mobile_Social_GoodsToPrice_Proc();
		JSONObject result = socialProc.insertHardGoodsData(shopCode, shopName);
		
		if(result.getBoolean("result")) {
			JSONObject result2 = socialProc.makeGoodsDataJSON(shopCode, shopName);
			return result2.getString("result");
		} else {
			return result.getString("result");
		}
		
	} catch(Exception e) {
		return e.toString();
	}
}
public String onCrawlingHyunDai() {
	try {
		int shopCode = 57;

		Document doc = Jsoup.connect("http://m.hyundaihmall.com/front/mblGood.do?pageSize=999&lastPrtyIndex=100&lastItemIndex=99&mpngItemSectId=&sortType=&mainDispSeq=10&lowDispTrtyCmbSeq=&preView=0")
										.userAgent("Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1")
										.get();


		Elements itemElements = doc.select(".item_wrap_star");
		JSONObject exportJsonObject = new JSONObject();
		JSONArray goodsJsonList = new JSONArray();
		ArrayList<String> itemCodeList = new ArrayList<String>();
		
		for(Element item : itemElements) {
			String link = item.select("a").attr("href");
			if(link.toLowerCase().contains("itemcode=")){
				String itemCode = link.replaceAll("[^\\d]", "");
				itemCodeList.add(itemCode);
			}
		}
		
		Mobile_Social_GoodsToPrice_Proc socialProc = new Mobile_Social_GoodsToPrice_Proc();
		String[] codes = itemCodeList.toArray(new String[0]);
		JSONObject result = socialProc.insertGoodsData(shopCode, codes);
		result.put("insCount", itemCodeList.size());

		if(result.getBoolean("result")) {
			JSONObject result2 = socialProc.makeGoodsDataJSON(shopCode, "hmall");
			return result2.getString("result");
		} else {
			return result.getString("result");
		}
		
	} catch (IOException e) { //Jsoup의 connect 부분에서 IOException 오류가 날 수 있으므로 사용한다.
		e.printStackTrace();
		return e.toString();
	} catch (JSONException je) {
		return je.toString();
	} catch (ExceptionManager em) {
		return em.toString();
	}
}

public JSONObject jsonObjectUrlParsing(String strUrl) throws UnsupportedEncodingException, MalformedURLException, IOException, JSONException{

    		URL urlObj = new URL(strUrl);
			HttpURLConnection conn = (HttpURLConnection) urlObj.openConnection();
			conn.setRequestMethod("GET");
			conn.setConnectTimeout(20000);
			conn.setReadTimeout(5000);
			conn.setRequestProperty("Accept-Charset", "UTF-8");
//			conn.addRequestProperty("Accept-Language", "en-US,en;q=0.8");
//			conn.addRequestProperty("User-Agent", "Mozilla");
//			conn.addRequestProperty("Referer", "google.com");
			conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.6) Gecko/20100625 Firefox/3.6.6");
			conn.setDoInput(true);
			conn.setDoOutput(true);
			/*
			String line;
			StringBuilder builder = new StringBuilder();
			BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			while((line = reader.readLine()) != null) {
				builder.append(line);
			}
			*/

			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(),  "UTF-8"));

			StringBuilder html = new StringBuilder();

			String inputLine;
			while ((inputLine = in.readLine()) != null) {
				html.append(inputLine);
			}

//			System.out.println("html="+html.length());
			//rtnValue = html.toString();

			in.close();

			conn.disconnect();

			System.out.println(html.toString());



	BufferedReader br = new BufferedReader(new InputStreamReader((new URL(strUrl)).openConnection().getInputStream(),"UTF-8"));
	StringBuilder sbJson = new StringBuilder();
	String strLine = "";

	while ((strLine = br.readLine()) != null){

		//String str = StringUtils.substringBetween(strLine, "AllKillMainDeals\":", ",\"LargeCategories");
		sbJson.append(strLine);
	}

	br.close();

	try {

		JSONObject jSONObject = new JSONObject(sbJson.toString());
		//JSONObject JSONObject = new JSONObject(sbJson.toString());

		return jSONObject;

	} catch (JSONException e) {
	}

	return null;
}

%>
