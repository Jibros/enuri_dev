<%@page import="org.apache.commons.lang3.StringUtils"%>

<%@page import="java.util.Random"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.enuri.bean.mobile.Mobile_GoodsToPricelist_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_GoodsToPricelist_Data"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>


<%@page import="java.net.*"%>

<%
	String SERVER_TARGET = "m";
	String server =	StringUtils.defaultString(request.getParameter("server"));
	if(server.equals("dev") ){
		SERVER_TARGET = "dev";
	}

	String DEPART_URL = "http://" + SERVER_TARGET + ".enuri.com";
	String BASE_URL = DEPART_URL + "/mobilefirst";
	String[][] pages = { 
		{"http_array", BASE_URL + "/http/json/mobile_deal_list.json" },
		{"http_array", DEPART_URL + "/mobilenew/gnb/category/mainBanner.json" },
		{"http_array", BASE_URL + "/http/json/shopMainLogo.json" }
	};
	

	try {
	
		JSONObject makeJson = new JSONObject();

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dates = formatter.format(new Date());
		if(SERVER_TARGET.equals("m"))
			makeJson.put("time", dates);
		for(int i=0; i<pages.length; i++) {
			String[] temp = pages[i][1].split("/");
			String fileName = temp[temp.length-1]; 
			String type = pages[i][0];
			
			if(type.equals("http_array")){
				JSONArray jsonObj = getJSONArrayfromHttp(pages[i][1]);
				makeJson.put(fileName, jsonObj);
			} else if (type.equals("http_object")){
				JSONObject jsonObj = getJSONObjectfromHttp(pages[i][1]);
				makeJson.put(fileName, jsonObj);
			}
		}
		
		{
			//20181204 소셜 브릿지 페이지 추가 http://dev.enuri.com/deal/move.html?freetoken=outlink&cpCompany=&cpUrl=
			JSONArray shopbestArr = new JSONArray();
		
		    String appendBridgeUrl = "http://"+SERVER_TARGET+".enuri.com/deal/move.html?freetoken=outlink&cpCompany=";
			{	// 올킬
				JSONObject site = new JSONObject();
				site.put("code", "4027");
				site.put("url", appendBridgeUrl+ "auction&cpUrl=" + URLEncoder.encode("http://banner.auction.co.kr/bn_redirect.asp?ID=BN00174819", "utf-8"));
				site.put("img", "/hotdeal/20160617/20160617_hotdeal_allkill.png");			
				site.put("mall", "올킬");
				shopbestArr.add(site);
			}
			
			{	// 슈퍼딜
				JSONObject site = new JSONObject();
				site.put("code", "536");
				site.put("url", appendBridgeUrl + "gmarket&cpUrl=" + URLEncoder.encode("http://mobile.gmarket.co.kr/SuperDeal?jaehuid=200006254", "utf-8"));
				site.put("img", "/hotdeal/20160617/20160617_hotdeal_superdeal.png");			
				site.put("mall", "슈퍼딜");
				shopbestArr.add(site);
			}			

			{	// 쇼킹딜
				JSONObject site = new JSONObject();
				site.put("code", "5910");
				site.put("url", appendBridgeUrl + "11st&cpUrl=" + URLEncoder.encode("http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1001004404", "utf-8"));
				site.put("img", "/hotdeal/20160617/20160617_hotdeal_shocking.png");			
				site.put("mall", "쇼킹딜");
				shopbestArr.add(site);
			}
			{	// 쎈딜
				JSONObject site = new JSONObject();
				site.put("code", "55");
				site.put("url", appendBridgeUrl + "interpark&cpUrl=" + URLEncoder.encode("http://m.interpark.com/mobileGW.html?svc=Shop&bizCode=P14430&url=http://m.shop.interpark.com/ssendeal", "utf-8"));
				site.put("img", "/hotdeal/20160617/20170228_hotdeal_ssendeal.png");			
				site.put("mall", "쎈딜");
				shopbestArr.add(site);
			}
			{	// 티몬
				JSONObject site = new JSONObject();
				site.put("code", "6641");
				site.put("url", appendBridgeUrl + "ticketmonster&cpUrl=" + URLEncoder.encode("http://m.ticketmonster.co.kr/?jp=80025&ln=214285", "utf-8"));
				site.put("img", "/hotdeal/20160617/20160617_hotdeal_tmon.png");
				site.put("mall", "티몬");
				shopbestArr.add(site);
			}
			makeJson.put("shopbest", shopbestArr);

		}


		/**
		* 카테고리
		*/
		JSONArray cateList = new JSONArray();
		{
			String imgCategoryUrl = "/images/mobilefirst/hotdeal/category";
            JSONObject shopping = new JSONObject();
            shopping.put("code", "A02");
            shopping.put("name", "쇼핑");
            shopping.put("ic_aos", imgCategoryUrl + "/hometab/service_m01.png");
            shopping.put("ic_ios_2", imgCategoryUrl + "/hometab/service_m01@2x.png");
            shopping.put("ic_ios_3", imgCategoryUrl + "/hometab/service_m01@3x.png");

            JSONObject location = new JSONObject();
            location.put("code", "A0101");
            location.put("name", "지역");
            location.put("ic_aos", imgCategoryUrl + "/hometab/service_m02.png");
            location.put("ic_ios_2", imgCategoryUrl + "/hometab/service_m02@2x.png");
            location.put("ic_ios_3", imgCategoryUrl + "/hometab/service_m02@3x.png");

            JSONObject tour = new JSONObject();
            tour.put("code", "A03");
            tour.put("name", "여행/레저");
            tour.put("ic_aos", imgCategoryUrl + "/hometab/service_m03.png");
            tour.put("ic_ios_2", imgCategoryUrl + "/hometab/service_m03@2x.png");
            tour.put("ic_ios_3", imgCategoryUrl + "/hometab/service_m03@3x.png");

            JSONObject culture = new JSONObject();
            culture.put("code", "A04");
            culture.put("name", "공연/문화");
            culture.put("ic_aos", imgCategoryUrl + "/hometab/service_m04.png");
            culture.put("ic_ios_2", imgCategoryUrl + "/hometab/service_m04@2x.png");
            culture.put("ic_ios_3", imgCategoryUrl + "/hometab/service_m04@3x.png");

            JSONObject category = new JSONObject();
            category.put("code", "all");
            category.put("name", "카테고리");
            category.put("ic_aos", imgCategoryUrl + "/hometab/service_m05.png");
            category.put("ic_ios_2", imgCategoryUrl + "/hometab/service_m05@2x.png");
            category.put("ic_ios_3", imgCategoryUrl + "/hometab/service_m05@3x.png");

            cateList.add(shopping);
            cateList.add(location);
            cateList.add(tour);
            cateList.add(culture);
            cateList.add(category);
		}
		makeJson.put("catebar", cateList);
		
		
		{	
			JSONObject goodsList = new JSONObject();
			JSONArray realTimeList = new JSONArray();
			JSONArray auctionList = new JSONArray();
			JSONObject hotClickDev = new JSONObject();
			JSONObject hotClickReal = new JSONObject();
			/**
			* 소셜 핫클릭 상품 목록
			*/
			try {
				String hotClickUrl = BASE_URL + "/api/deal/hotClick_HomeItem.jsp";
				hotClickDev = getJSONObjectfromHttp(hotClickUrl + "?type=dev");
				hotClickReal = getJSONObjectfromHttp(hotClickUrl + "?type=real");		
				
				if(hotClickDev != null && hotClickDev.get("homeItemList_dev") != null)
					goodsList.put("social_hot_dev", (JSONArray)hotClickDev.get("homeItemList_dev"));
					
				if(hotClickReal != null && hotClickReal.get("homeItemList") != null)
					goodsList.put("social_hot_real", (JSONArray)hotClickReal.get("homeItemList"));
				
				goodsList.put("md_goods_title", "MD <font color='#498AF3'>Pick</font>");
			} catch(Exception e){

			}
			
			/**
			* 실시간 상품 목록
			*/
			try {
				JSONObject realTimeRootObj = getJSONObjectfromHttp(BASE_URL + "/api/deal/realTimeDeal.json");
				JSONObject list = (JSONObject)realTimeRootObj.get("list");

				goodsList.put("realtime", list.get("DS_COUPON"));
			} catch(Exception e){
				out.println(e.toString());
			}
			makeJson.put("goods_list", goodsList);	
			
			/**
			* 기획전 상품
			*/
			try {
				String url = "http://" + (!SERVER_TARGET.equals("m") ? "dev" : "www") + ".enuri.com/eventPlanZone/jsp/getExhibition_ajax.jsp?sel_exhibition_type=3";
				JSONObject exhibitionObj = getJSONObjectfromHttp(url);

				goodsList.put("exhibition", exhibitionObj.get("exhibitionList"));
			} catch(Exception e){
				out.println(e.toString());
			}
		}
		
		/**
		* 추천 탭 > 타이틀 데이터
		*/
		{
			try {
				JSONObject today = new JSONObject();
				today.put("title", "Today's 소셜");
				today.put("category", (JSONArray)((JSONObject)getJSONObjectfromHttp(BASE_URL + "/api/deal/popCateList.json").get("list")).get("DS_POPCATE"));
				makeJson.put("reco_title", today);
			} catch (Exception e) {			
			}
		}
		
		out.println(makeJson.toString());
		
	} catch (Exception e) {
	
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

				JSONObject object = (JSONObject) json.get(i);
				String b = (String) object.get("GOODS_EXPO_FLAG");
				if (b.equals("Y")) {
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

	public JSONArray getJSONArrayfromHttpDeal(String strurl) {
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
			JSONArray json = (JSONArray) obj;
			JSONArray returnarr = new JSONArray();
			for (int i = 0; i < json.size(); i++) {

				JSONObject object = (JSONObject) json.get(i);
				String b = (String) object.get("GOODS_EXPO_FLAG");
				if (b.equals("Y")) {
					returnarr.add(json.get(i));
				}
			}

			return returnarr;
		} catch (Exception e) {

		}
		return null;
	}%>
