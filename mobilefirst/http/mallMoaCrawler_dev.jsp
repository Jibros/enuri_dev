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
JSONObject resultJSON = new JSONObject();
try {
	//String gs = onCrawlingGS();
	String cj = onCrawlingCJ();
	//String hmall = onCrawlingHyunDai();
	//String q10 = onCrawlingQ10();
	//String ns = onCrawlingNS();
	//String ssg = onCrawlingSSG();

	//resultJSON.put("gs", gs);
	resultJSON.put("cj", cj);
	//resultJSON.put("hmall", hmall);
	//resultJSON.put("q10", q10);
	//resultJSON.put("ns", ns);
	//resultJSON.put("ssg", ssg);
} catch (Exception e) {
	out.println(e.toString());
}
	out.println(resultJSON.toString());
%>
<%!public static final int MINIMUM_GOODS_SIZE = 10;

	public void onErrorCrawling(String mallName) {

	}

	public void onErrorDataMatching(String mallName) {

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
	}

	public String getApiUrl(String msg) {
		//String arn = "arn:aws:sns:ap-northeast-1:351636241112:endpoint/GCM/enuri.monitoring/f142cbba-87cc-398b-938f-970437f4fb5e";
		String arn = "";
		String title = "종합몰 크롤링 메시지";
		String team = "msolution";
		String type = "warning";

		String url = "http://jca.enuri.com:8080/jqgrid/push/push_proc_ems_ajax.jsp";
		try {
			String param = "title=" + URLEncoder.encode(title, "UTF-8") + "&msg="
					+ URLEncoder.encode(msg, "UTF-8") + "&type=" + type + "&team="
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
	
	
	public String onCrawlingGS() {
		try {
			int shopCode = 75;
			String[] shopName = new String[] { "gsshop" };
			Mobile_Social_GoodsToPrice_Proc socialProc = new Mobile_Social_GoodsToPrice_Proc();
			JSONObject result = socialProc.insertHardGoodsData(shopCode,
					shopName);

			if (result.getBoolean("result")) {
				JSONObject result2 = socialProc.makeGoodsDataJSON(shopCode,
						shopName);
				checkCrawlingError(result2, "gsshop");
				return result2.getString("result");
			} else {
				checkCrawlingError(result, "gsshop");
				return result.getString("result");
			}

		} catch (Exception e) {
			callEmsAPI(getApiUrl("try/catch [gsshop] " + e.toString()));
			return e.toString();
		}
	}

	public String onCrawlingCJ() {
	try {
		int shopCode = 806;
		String cjImgRoot = "http://thumb.cjmall.net/unsafe/640x320";

		String[] urlList = new String[]{
				"http://display.cjmall.com/c/rest/module/contList?id=000002&cjEmpYn=false&type=H&pmType=M",
				"http://display.cjmall.com/c/rest/module/contList?id=000502&cjEmpYn=false&type=H&pmType=M",
				//"http://display.cjmall.com/c/rest/module/contList?id=000504&cjEmpYn=false&type=H&pmType=M",
				"http://display.cjmall.com/c/rest/module/contList?id=000503&cjEmpYn=false&type=H&pmType=M"};
		
		ArrayList<String> itemCodeList = new ArrayList<String>();
		JSONArray goodsJsonList = new JSONArray();
		java.util.regex.Pattern p = java.util.regex.Pattern.compile("[0-9]*?");
		
		for(String url : urlList) {
			
			JSONObject rootObject = jsonObjectUrlParsing(url);
			int status = rootObject.optInt("status", 500);
			String message = rootObject.optString("message", "error");
			
			if (status != 200 || !message.equalsIgnoreCase("ok"))
				continue;
			
			JSONArray rootJson = jsonObjectUrlParsing(url).getJSONObject("result").getJSONArray("moduleContApiTupleList");
			
			for(int i=0; i<rootJson.length(); i++) {
			
				JSONArray tmpItemList = rootJson.getJSONObject(i).getJSONArray("cateContApiTupleList");
				
				if(tmpItemList == null)
					continue;
				
				for(int j=0; j<tmpItemList.length(); j++) {
				
					JSONObject jsonGoods = tmpItemList.getJSONObject(j);
				
					if(jsonGoods != null && jsonGoods.has("contVal") ) {
						String itemCode = jsonGoods.optString("contVal", "defVal");
				
						if(p.matcher(itemCode).matches())
							itemCodeList.add(itemCode);
					}
					
					
					if(jsonGoods != null && jsonGoods.has("itemCd") ) {
						String itemCode = jsonGoods.getString("itemCd");
				
						if(p.matcher(itemCode).matches())
							itemCodeList.add(itemCode);
					}
					
				
					if(jsonGoods.has("subCateContApiTupleList")) {
						JSONArray subList = jsonGoods.getJSONArray("subCateContApiTupleList");
					
						for(int k=0; k<subList.length(); k++) {
							JSONObject subGoods = subList.getJSONObject(k);
						
							if(subGoods != null && subGoods.has("contVal") ){
								String itemCode = subGoods.optString("contVal", "defVal");
							
								if(p.matcher(itemCode).matches())
									itemCodeList.add(itemCode);
							}
						}
					}
					
					if(jsonGoods.has("cateContGrpDtlApiTupleList")) {
						JSONArray subList = jsonGoods.getJSONArray("cateContGrpDtlApiTupleList");
					
						for(int k=0; k<subList.length(); k++) {
							JSONObject subGoods = subList.getJSONObject(k);
						
							if(subGoods != null && subGoods.has("itemCd") ){
								String itemCode = subGoods.getString("itemCd");
							
								if(p.matcher(itemCode).matches())
									itemCodeList.add(itemCode);
							}
						}
					}
					
					if(jsonGoods.has("dealItemTupleList")) {
						JSONArray subList = jsonGoods.getJSONArray("dealItemTupleList");
					
						for(int k=0; k<subList.length(); k++) {
							JSONObject subGoods = subList.getJSONObject(k);
						
							if(subGoods != null && subGoods.has("itemCd") ){
								String itemCode = subGoods.getString("itemCd");
							
								if(p.matcher(itemCode).matches())
									itemCodeList.add(itemCode);
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
			checkCrawlingError(result2, "CJmall");
			return result2.getString("result");
		} else {
			checkCrawlingError(result, "CJmall");
			return result.getString("result");
		}

	} catch (Exception e) {
		callEmsAPI( getApiUrl("try/catch [CJmall] " + e.toString()) );
		return e.toString();
	}
}

	public String onCrawlingQ10() {
		try {
			int shopCode = 7857;
			String[] shopName = new String[] { "Qoo10" };
			Mobile_Social_GoodsToPrice_Proc socialProc = new Mobile_Social_GoodsToPrice_Proc();
			JSONObject result = socialProc.insertHardGoodsData(shopCode,
					shopName);

			if (result.getBoolean("result")) {
				JSONObject result2 = socialProc.makeGoodsDataJSON(shopCode,
						shopName);
				checkCrawlingError(result2, "Qoo10");
				return result2.getString("result");
			} else {
				checkCrawlingError(result, "Qoo10");
				return result.getString("result");
			}

		} catch (Exception e) {
			callEmsAPI(getApiUrl("try/catch [Qoo10] " + e.toString()));
			return e.toString();
		}
	}

	public String onCrawlingNS() {
		try {
			int shopCode = 974;
			String[] shopName = new String[] { "nsmall" };
			Mobile_Social_GoodsToPrice_Proc socialProc = new Mobile_Social_GoodsToPrice_Proc();
			JSONObject result = socialProc.insertHardGoodsData(shopCode,
					shopName);

			if (result.getBoolean("result")) {
				JSONObject result2 = socialProc.makeGoodsDataJSON(shopCode,
						shopName);
				checkCrawlingError(result2, "nsmall");
				return result2.getString("result");
			} else {
				checkCrawlingError(result, "nsmall");
				return result.getString("result");
			}

		} catch (Exception e) {
			callEmsAPI(getApiUrl("try/catch [nsmall] " + e.toString()));
			return e.toString();
		}
	}

	public String onCrawlingSSG() {
		try {
			int shopCode = 47;
			String[] shopName = new String[] { "ssg", "emart" };
			Mobile_Social_GoodsToPrice_Proc socialProc = new Mobile_Social_GoodsToPrice_Proc();
			JSONObject result = socialProc.insertSsgGoodsData();

			if (result.getBoolean("result")) {
				JSONObject result2 = socialProc.makeGoodsDataJSON(shopCode,
						shopName);
				checkCrawlingError(result2, "ssg");
				return result2.getString("result");
			} else {
				checkCrawlingError(result, "ssg");
				return result.getString("result");
			}

		} catch (Exception e) {
			callEmsAPI(getApiUrl("try/catch [ssg] " + e.toString()));
			return e.toString();
		}
	}

	public String onCrawlingHyunDai() {
	try {
		int shopCode = 57;

		Document doc = Jsoup.connect("http://m.hyundaihmall.com/front/mblGood.do?pageSize=999&lastPrtyIndex=100&lastItemIndex=99&mpngItemSectId=&sortType=&mainDispSeq=10&lowDispTrtyCmbSeq=&preView=0")
										.userAgent("Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1")
										.timeout(10000)
										.get();


		Elements itemElements = doc.select(".product_box");
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
			checkCrawlingError(result2, "hmall");
			return result2.getString("result");
		} else {
			checkCrawlingError(result, "hmall");
			return result.getString("result");
		}
		
	} catch (Exception e) {
		callEmsAPI( getApiUrl("try/catch [hmall] " + e.toString()) );
		return e.toString();
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
		conn.setRequestProperty(
				"User-Agent",
				"Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.6) Gecko/20100625 Firefox/3.6.6");
		conn.setDoInput(true);
		conn.setDoOutput(true);

		BufferedReader br = new BufferedReader(new InputStreamReader((new URL(
				strUrl)).openConnection().getInputStream(), "UTF-8"));
		StringBuilder sbJson = new StringBuilder();
		String strLine = "";

		while ((strLine = br.readLine()) != null)
			sbJson.append(strLine);

		br.close();

		try {
			JSONObject jSONObject = new JSONObject(sbJson.toString());
			return jSONObject;
		} catch (JSONException e) { }

		return null;
	}%>
