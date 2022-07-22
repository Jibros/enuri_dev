<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.json.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	String verAnd = request.getParameter("verand");
	String verIos = request.getParameter("iosver");

	if (verAnd != null) {
		int intVersion = 0;
		if (verAnd.length() >= 5)
			intVersion = Integer.parseInt(verAnd.substring(0, 1)) * 100
					+ Integer.parseInt(verAnd.substring(2, 3)) * 10
					+ Integer.parseInt(verAnd.substring(4, 5));
		out.println(getResponseAOS(intVersion));
	} else if (verIos != null) {
		int intVersion = 0;
		if (verIos.length() >= 5)
			intVersion = Integer.parseInt(verIos.substring(0, 1)) * 100
					+ Integer.parseInt(verIos.substring(2, 3)) * 10
					+ Integer.parseInt(verIos.substring(4, 5));

		out.println(getResponseIOS(intVersion));
	} else {
		out.println(getResponseIOS(0));
	}
%>


<%!
	public static String getResponseAOS(int version) {
		JSONObject response = new JSONObject();
		try {
			response.put("TABS", getMainTabAOS(version));
			response.put("BUF_TAB", getBufTabAOS());
			response.put("EVENT_BTN", getEventTabAOS());
			response.put("DYNAMIC_TAB2", getDynamicTabAOS());
			response.put("HOTDEAL", getHotdealTabAOS(version));
			//response.put("MOA_TAB", getMoaTabAOS(version));	// "MAIN_TAB" 내용을 디폴트로 하되, 탭 데이터를 따로 컨트롤 하기 경우 사용
			response.put("MAIN_TAB", getMainDynaimcTab(version));

			response.put("hotdeal_empty_set", "false");
		} catch (Exception e) {
		}

		return response.toString();
	}

	public static JSONObject getBufTabAOS() throws JSONException {

		JSONObject obj = new JSONObject();

		obj.put("BUF_TAB_LINK_AOS",
				"");
		obj.put("BUF_TAB_COLOR_AOS", "E4E4E4");
		obj.put("BUF_TAB_IMAGE_AOS",
				"/images/mobilefirst/extra_tab/buftab/extratab_bg_20200109_aos.jpg");
		obj.put("BUF_TAB_LINK_IOS",
				"https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8&freetoken=outlink");
		obj.put("BUF_TAB_COLOR_IOS", "E4E4E4");
		obj.put("BUF_TAB_IMAGE_IOS",
				"/images/mobilefirst/extra_tab/buftab/extratab_bg_20170102_ios.png");

		return obj;
	}

	public static JSONObject getEventTabAOS() throws JSONException {
		JSONObject obj = new JSONObject();

		obj.put("EVENT_BTN_LINK_URL_IOS",
				"http://m.enuri.com/mobilefirst/event2016/allpayback_201607.jsp?freetoken=event");
		obj.put("EVENT_BTN_LINK_URL_AOS",
				"http://m.enuri.com/mobilefirst/event2016/allpayback_201607.jsp?freetoken=event");
		obj.put("EVENT_BTN_YN", "Y");
		obj.put("EVENT_BTN_IMAGE_URL",
				"/images/mobilefirst/floating_event/event_floating0627");

		return obj;
	}

	public static JSONArray getDynamicTabAOS() throws JSONException {
		JSONArray array = new JSONArray();

		JSONArray sampleBanner = new JSONArray();
		JSONObject banner = new JSONObject();
		banner.put("link",
				"http://m.enuri.com/mobilefirst/event/newyear_2016.jsp?freetoken=event");
		banner.put("img-src", "/images/mobilefirst/event/newyear.png");
		sampleBanner.put(banner);

		JSONObject sample = new JSONObject();
		sample.put("TABENDDATE", "201702311200");
		sample.put("TABBANNER", sampleBanner);
		sample.put("TABJSON", "/http/json/allKill.json");
		sample.put("TABSTARTDATE", "201601011200");
		sample.put("TABVIEWGLOG", "social_dynamic");
		sample.put("TABGLOG", "dynamic");
		sample.put("TABBANNER", "만원쇼핑");

		array.put(sample);

		return array;
	}

	public static JSONArray getHotdealTabAOS(int version) throws JSONException {
		JSONArray array = new JSONArray();
		{
			JSONObject deal = new JSONObject();
			deal.put("logo",
					"/mobilefirst/hotdeal/20160617/20160617_hotdeal_allkill2.png");
			deal.put("deal", "/view/ls_logo/2013/Ap_logo_4027_deal1.png");
			deal.put("title", "올킬");
			deal.put("url", "/http/json/allKill.json");
			deal.put("mall", "allkill");
			deal.put("shopcode", "4027");

			array.put(deal);
		}
		{
			JSONObject deal = new JSONObject();
			deal.put("logo",
					"/mobilefirst/hotdeal/20160617/20160617_hotdeal_superdeal.png");
			deal.put("deal", "/view/ls_logo/2013/Ap_logo_536_deal1.png");
			deal.put("title", "슈퍼딜");
			deal.put("url", "/http/json/superDeal.json");
			deal.put("mall", "superdeal");
			deal.put("shopcode", "536");

			array.put(deal);
		}
		{
			JSONObject deal = new JSONObject();
			deal.put("logo",
					"/mobilefirst/hotdeal/20160617/20160617_hotdeal_shocking.png");
			deal.put("deal", "/view/ls_logo/2013/Ap_logo_5910_deal1.png");
			deal.put("title", "쇼킹딜");
			deal.put("url", "/http/json/shocking.json");
			deal.put("mall", "shocking");
			deal.put("shopcode", "5910");

			array.put(deal);
		}

		{
			JSONObject deal = new JSONObject();
			deal.put("logo",
					"/mobilefirst/hotdeal/20160617/20160617_hotdeal_tmon.png");
			deal.put("deal", "/view/ls_logo/2013/Ap_logo_6641_deal1.png");
			deal.put("title", "티몬");
			deal.put("url", "/http/json/tmon.json");
			deal.put("mall", "tmon");
			deal.put("shopcode", "6641");

			array.put(deal);
		}

		{
			JSONObject deal = new JSONObject();
			deal.put("logo",
					"/mobilefirst/hotdeal/20160617/20160617_hotdeal_wemake.png");
			deal.put("deal", "/view/ls_logo/2013/Ap_logo_6508_deal1.png");
			deal.put("title", "위메프");
			deal.put("url", "/http/json/wemake.json");
			deal.put("mall", "wemake");
			deal.put("shopcode", "6508");

			array.put(deal);
		}

		if (version == 0 || version <= 202) { // 2.0.2 이하의 버전에서는 최대 5개만 준다.
			return array;
		}

		{
			JSONObject deal = new JSONObject();
			deal.put("logo",
					"/mobilefirst/hotdeal/20160617/20170228_hotdeal_ssendeal.png");
			deal.put("deal", "/view/ls_logo/2013/Ap_logo_55_deal.png");
			deal.put("title", "쎈딜");
			deal.put("url", "/http/json/ssenDeal.json");
			deal.put("mall", "ssendeal");
			deal.put("shopcode", "55");

			array.put(deal);
		}

		return array;
	}
	
	/**
	*	종합몰 API 데이터
	*/
	public static JSONArray getMoaTabAOS(int version) throws JSONException {
		JSONArray array = new JSONArray();
		
		/*
		{
			JSONObject data = new JSONObject();
			data.put("logo", "");
			data.put("deal", "");
			data.put("title", "Hmall");
			data.put("url", "/http/json/mallMoa_hmall.json");
			data.put("mall", "hmall");
			data.put("shopcode", "57");

			array.put(data);
		}
		
		*/
		
		
		{
			JSONObject data = new JSONObject();
			data.put("logo", "");
			data.put("deal", "");
			data.put("title", "CJ mall");
			data.put("url", "/http/json/mallMoa_CJmall.json");
			data.put("mall", "cj");
			data.put("shopcode", "806");

			array.put(data);
		}
		
		/*
		{
			JSONObject data = new JSONObject();
			data.put("logo", "");
			data.put("deal", "");
			data.put("title", "롯데닷컴");
			data.put("url", "/http/json/mallMoa_49.json");
			data.put("mall", "lotte");
			data.put("shopcode", "49");

			array.put(data);
		}
		*/
		
		{
			JSONObject data = new JSONObject();
			data.put("logo", "");
			data.put("deal", "");
			data.put("title", "GS Shop");
			data.put("url", "/http/json/mallMoa_gsshop.json");
			data.put("mall", "gs");
			data.put("shopcode", "75");

			array.put(data);
		}
		{
			JSONObject data = new JSONObject();
			data.put("logo", "");
			data.put("deal", "");
			data.put("title", "Qoo10");
			data.put("url", "/http/json/mallMoa_Qoo10.json");
			data.put("mall", "Qoo10");
			data.put("shopcode", "7857");

			array.put(data);
		}
		
		{
			JSONObject data = new JSONObject();
			data.put("logo", "");
			data.put("deal", "");
			data.put("title", "NSMall");
			data.put("url", "/http/json/mallMoa_nsmall.json");
			data.put("mall", "nsmall");
			data.put("shopcode", "974");

			array.put(data);
		}

		{
			JSONObject data = new JSONObject();
			data.put("logo", "");
			data.put("deal", "");
			data.put("title", "SSG");
			data.put("url", "/http/json/mallMoa_ssg.json");
			data.put("mall", "ssg");
			data.put("shopcode", "47");

			array.put(data);
		}		


		return array;
	}

	/**
	*	탭 순서, on/off 변경
	*/
	public static JSONArray getMainTabAOS(int version) throws JSONException {
		
		if(version < 214)
			return getAos214Tab(version);


		JSONArray array = new JSONArray();
		
		JSONObject tab1 = new JSONObject();
		JSONObject tab2 = new JSONObject();
		JSONObject tab3 = new JSONObject();
		JSONObject tab4 = new JSONObject();
		JSONObject tab5 = new JSONObject();
		JSONObject tab6 = new JSONObject();
		
		tab1.put("INDEX", 1);
		tab1.put("TITLE", "추천");
		tab1.put("NAME", "RECOMMEND");
		tab1.put("START", "201801010000");
		tab1.put("END", "");
		tab1.put("SHOWA", "Y");
		tab1.put("SHOWI", "Y");
		
		tab2.put("INDEX", 2);
		tab2.put("TITLE", "핫딜베스트");
		tab2.put("NAME", "BEST");
		tab2.put("START", "201701010000");
		tab2.put("END", "");
		tab2.put("SHOWA", "Y");
		tab2.put("SHOWI", "Y");
		
		tab3.put("INDEX", 3);
		tab3.put("TITLE", "여행");
		tab3.put("NAME", "TOUR");
		tab3.put("START", "201701010000");
		tab3.put("END", "");
		tab3.put("SHOWA", "Y");
		tab3.put("SHOWI", "Y");
		
		tab4.put("INDEX", 4);
		tab4.put("TITLE", "e쿠폰");
		tab4.put("NAME", "E_COUPON");
		tab4.put("START", "201701010000");
		tab4.put("END", "");
		tab4.put("SHOWA", "Y");
		tab4.put("SHOWI", "Y");
		
		tab5.put("INDEX", 5);
		tab5.put("TITLE", "몰베스트");
		tab5.put("NAME", "MOA");
		tab5.put("START", "201705181717");
		tab5.put("END", "");
		tab5.put("SHOWA", "Y");
		tab5.put("SHOWI", "Y");
		
		tab6.put("INDEX", 6);
		tab6.put("TITLE", "기획전");
		tab6.put("NAME", "PLAN");
		tab6.put("START", "201705181717");
		tab6.put("END", "");
		tab6.put("SHOWA", "N");
		tab6.put("SHOWI", "N");
		
		array.put(tab1);
		array.put(tab2);
		array.put(tab3);
		array.put(tab4);
		array.put(tab5);
		array.put(tab6);
		
		return array;
	}
	
	private static JSONArray getAos214Tab(int version) throws JSONException {
		JSONArray array = new JSONArray();
		
		JSONObject home = new JSONObject();
		JSONObject today = new JSONObject();
		JSONObject hotdeal = new JSONObject();
		JSONObject plus = new JSONObject();
		JSONObject realtime = new JSONObject();
		JSONObject moa = new JSONObject();
		
		home.put("INDEX", 1);
		home.put("TITLE", "소셜홈");
		home.put("NAME", "HOME");
		home.put("START", "201701010000");
		home.put("END", "");
		home.put("SHOWA", "Y");
		home.put("SHOWI", "Y");
		
		today.put("INDEX", 2);
		today.put("TITLE", "오늘의추천");
		today.put("NAME", "TODAY");
		today.put("START", "201701010000");
		today.put("END", "");
		today.put("SHOWA", "Y");
		today.put("SHOWI", "Y");
		
		realtime.put("INDEX", 3);
		realtime.put("TITLE", "실시간핫딜");
		realtime.put("NAME", "REALTIME");
		realtime.put("START", "201701010000");
		realtime.put("END", "");
		realtime.put("SHOWA", "Y");
		realtime.put("SHOWI", "Y");
		
		plus.put("INDEX", 4);
		plus.put("TITLE", "쇼핑플러스");
		plus.put("NAME", "PLAN");
		plus.put("START", "201701010000");
		plus.put("END", "");
		plus.put("SHOWA", "Y");
		plus.put("SHOWI", "Y");
		
		hotdeal.put("INDEX", 5);
		hotdeal.put("TITLE", "핫딜베스트");
		hotdeal.put("NAME", "BEST");
		hotdeal.put("START", "201701010000");
		hotdeal.put("END", "");
		hotdeal.put("SHOWA", "Y");
		hotdeal.put("SHOWI", "Y");
		
		moa.put("INDEX", 6);
		moa.put("TITLE", "인기몰베스트");
		moa.put("NAME", "MOA");
		moa.put("START", "201705181717");
		moa.put("END", "");
		moa.put("SHOWA", "Y");
		moa.put("SHOWI", "Y");

		array.put(home);
		array.put(today);
		array.put(hotdeal);
		array.put(plus);
		array.put(realtime);
		
		
		if(version >= 207)
			array.put(moa);
		
		return array;
	}
	
	/**
	*	모든 탭 컨트롤을 위한 JSON
	*	서브탭 정보와 api 주소 변경용
	*	파싱할 때 제일 먼저 불려지므로, 앱 내부에 하드코딩으로 선언된 디폴트 탭 데이터를 덮어 쓴다.
	*	탭의 순서를 보장하지는 않는다. 탭의 순서 및 ON/OFF는 getMainTabAOS의 순서를 따른다
	*	App에서 BASE_URL + url을 사용하기 때문에 /mobilefirst로 시작하는 url이 아니면 사용하지 않음
	*/
	public static JSONArray getMainDynaimcTab(int version) {
		
		JSONArray tabArray = new JSONArray();
		
		if(version < 214)
			return get214DynamicTab(version);
		else {
			
			try {	
				tabArray.put(getTabJSONObject("recommend", "추천", "/api/deal/socialMainMake.json", "recommend"));
			} catch (Exception e) { }
		
			/*	핫딜베스트  */
			try {
				JSONObject tab3 = getTabJSONObject("best", "핫딜베스트", "", "hotdeal");
				tab3.put("subtab", getHotdealTabAOS(version));	
				tabArray.put(tab3);
			} catch (Exception e) { }
		
			/*	여행  */
			try {
				JSONObject tab4 = getTabJSONObject("tour", "여행", "/api/deal/tourCouponList.json", "travel");
				tabArray.put(tab4);
			} catch (Exception e) { }
			
			/*	e쿠폰  */
			try {
				JSONObject tab4 = getTabJSONObject("e_coupon", "e쿠폰", "/api/deal/eCouponList.json", "ecoupon");
				tabArray.put(tab4);
			} catch (Exception e) { }
		
			/*	기획전  */
			/*
			try {
				JSONObject tab4 = getTabJSONObject("plan", "기획전", "", "promotion");
				tabArray.put(tab4);
			} catch (Exception e) { }
		*/
			/*	종합몰  */
			try {
				JSONObject tab5 = getTabJSONObject("moa", "몰베스트", "", "mallbest");
				tab5.put("subtab", getMoaTabAOS(version));
				if(version >= 207)
					tabArray.put(tab5);
			} catch (Exception e) { }
		}
		
		return tabArray;
	}
	
	private static JSONArray get214DynamicTab(int version) {
		JSONArray tabArray = new JSONArray();
		
		try {
			
			tabArray.put(getTabJSONObject("home", "소셜홈", "/api/deal/socialMainMake.json", ""));
		} catch (Exception e) {
			//ignore
		}
		

		/*	오늘의추천  */
		try {
			JSONObject tab2 = getTabJSONObject("today", "오늘의추천", "", "");
			JSONArray tab2_sub = new JSONArray();
			tab2_sub.put(getTabJSONObject("sub1", "소셜HOT클릭", "/api/deal/dealTodayGoods.json", "오늘의추천_소셜HOT"));
			tab2_sub.put(getTabJSONObject("sub2", "신상품", "/api/deal/dealNewGoods.json", "오늘의추천_신상품"));
			tab2.put("subtab", tab2_sub);
				
			tabArray.put(tab2);
		} catch (Exception e) {
			//ignore
		}
		
		/*	핫딜베스트  */
		try {
			JSONObject tab3 = getTabJSONObject("best", "핫딜베스트", "", "");
			tab3.put("subtab", getHotdealTabAOS(version));
			
			tabArray.put(tab3);
		} catch (Exception e) {
			//ignore
		}
		
		/*	실시간핫딜  */
		try {
			JSONObject tab4 = getTabJSONObject("realtime", "실시간핫딜", "", "");
			
			tabArray.put(tab4);
		} catch (Exception e) {
			//ignore
		}
		
		/*	기획전  */
		try {
			JSONObject tab4 = getTabJSONObject("plan", "쇼핑플러스", "", "");
			
			tabArray.put(tab4);
		} catch (Exception e) {
			//ignore
		}
		
		/*	종합몰  */
		try {
			JSONObject tab5 = getTabJSONObject("moa", "인기몰베스트", "", "");
			tab5.put("subtab", getMoaTabAOS(version));
			if(version >= 207)
				tabArray.put(tab5);
		} catch (Exception e) {
			//ignore
		}
			
		return tabArray;
	}
	
	public static JSONObject getTabJSONObject(String id, String title, String url, String ga) throws JSONException {
		JSONObject object = new JSONObject();
		object.put("id", id);
		object.put("title", title);
		object.put("url", url);
		object.put("ga", ga);
		
		return object;
	}

	//////////////////// I O S ////////////////////

	public static String getResponseIOS(int version) {
		JSONObject response = new JSONObject();
		try {
			response.put("TABS", getMainTabIOS(version));
			response.put("BUF_TAB", getBufTabIOS());
			response.put("EVENT_BTN", getEventTabIOS());
			response.put("DYNAMIC_TAB2", getDynamicTabIOS());
			response.put("HOTDEAL", getHotdealTabIOS(version));
			if(version >= 207)
				response.put("MOA_TAB", getMoaTabIOS(version));
			response.put("hotdeal_empty_set", "false");
		} catch (Exception e) {
		}

		return response.toString();
	}

	public static JSONObject getBufTabIOS() throws JSONException {

		JSONObject obj = new JSONObject();

		obj.put("BUF_TAB_LINK_AOS",
				"market://details?id=com.enuri.android&referrer=utm_source%3Ddeal%26utm_medium%3DHidden_tab%26utm_campaign%3DHidden_tab_20160203");
		obj.put("BUF_TAB_COLOR_AOS", "E4E4E4");
		obj.put("BUF_TAB_IMAGE_AOS",
				"/images/mobilefirst/extra_tab/buftab/extratab_bg_20170102_aos.png");
		obj.put("BUF_TAB_LINK_IOS",
				"https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8&freetoken=outlink");
		obj.put("BUF_TAB_COLOR_IOS", "E4E4E4");
		obj.put("BUF_TAB_IMAGE_IOS",
				"/images/mobilefirst/extra_tab/buftab/extratab_bg_20170102_ios.png");

		return obj;
	}

	public static JSONObject getEventTabIOS() throws JSONException {
		JSONObject obj = new JSONObject();

		obj.put("EVENT_BTN_LINK_URL_IOS",
				"http://m.enuri.com/mobilefirst/event2016/allpayback_201607.jsp?freetoken=event");
		obj.put("EVENT_BTN_LINK_URL_AOS",
				"http://m.enuri.com/mobilefirst/event2016/allpayback_201607.jsp?freetoken=event");
		obj.put("EVENT_BTN_YN", "Y");
		obj.put("EVENT_BTN_IMAGE_URL",
				"/images/mobilefirst/floating_event/event_floating0627");

		return obj;
	}
	
	public static JSONArray getMainTabIOS(int version) throws JSONException {
		JSONArray array = new JSONArray();
		
		JSONObject tab1 = new JSONObject();
		JSONObject tab2 = new JSONObject();
		JSONObject tab3 = new JSONObject();
		JSONObject tab4 = new JSONObject();
		JSONObject tab5 = new JSONObject();
		JSONObject tab6 = new JSONObject();
		
		tab1.put("INDEX", 1);
		tab1.put("TITLE", "소셜홈");
		tab1.put("NAME", "HOME");
		tab1.put("START", "201701010000");
		tab1.put("END", "");
		tab1.put("SHOWA", "Y");
		tab1.put("SHOWI", "Y");
		
		tab2.put("INDEX", 2);
		tab2.put("TITLE", "오늘의추천");
		tab2.put("NAME", "TODAY");
		tab2.put("START", "201701010000");
		tab2.put("END", "");
		tab2.put("SHOWA", "Y");
		tab2.put("SHOWI", "Y");
		
		tab3.put("INDEX", 4);
		tab3.put("TITLE", "핫딜베스트");
		tab3.put("NAME", "BEST");
		tab3.put("START", "201701010000");
		tab3.put("END", "");
		tab3.put("SHOWA", "Y");
		tab3.put("SHOWI", "Y");

		tab4.put("INDEX", 3);
		tab4.put("TITLE", "실시간핫딜");
		tab4.put("NAME", "REALTIME");
		tab4.put("START", "201701010000");
		tab4.put("END", "");
		tab4.put("SHOWA", "Y");
		tab4.put("SHOWI", "Y");

		tab5.put("INDEX", 5);
		tab5.put("TITLE", "기획전");
		tab5.put("NAME", "PLAN");
		tab5.put("START", "201701010000");
		tab5.put("END", "");
		tab5.put("SHOWA", "Y");
		tab5.put("SHOWI", "N");

		tab6.put("INDEX", 6);
		tab6.put("TITLE", "몰모아");
		tab6.put("NAME", "MOA");
		tab6.put("START", "201701010000");
		tab6.put("END", "");
		tab6.put("SHOWA", "Y");
		tab6.put("SHOWI", "Y");

		array.put(tab1);
		array.put(tab2);
		array.put(tab3);
		array.put(tab4);
		array.put(tab5);
		array.put(tab6);
		
		return array;
	}

	public static JSONArray getDynamicTabIOS() throws JSONException {
		JSONArray array = new JSONArray();

		JSONArray sampleBanner = new JSONArray();
		JSONObject banner = new JSONObject();
		banner.put("link",
				"http://m.enuri.com/mobilefirst/event/newyear_2016.jsp?freetoken=event");
		banner.put("img-src", "/images/mobilefirst/event/newyear.png");
		sampleBanner.put(banner);

		JSONObject sample = new JSONObject();
		sample.put("TABENDDATE", "201702311200");
		sample.put("TABBANNER", sampleBanner);
		sample.put("TABJSON", "/http/json/allKill.json");
		sample.put("TABSTARTDATE", "201601011200");
		sample.put("TABVIEWGLOG", "social_dynamic");
		sample.put("TABGLOG", "dynamic");
		sample.put("TABBANNER", "만원쇼핑");

		array.put(sample);

		return array;
	}

	public static JSONArray getHotdealTabIOS(int version) throws JSONException {
		JSONArray array = new JSONArray();
		{
			JSONObject deal = new JSONObject();
			deal.put("logo",
					"/mobilefirst/hotdeal/20160617/20160617_hotdeal_allkill2.png");
			deal.put("deal", "/view/ls_logo/2013/Ap_logo_4027_deal1.png");
			deal.put("title", "올킬");
			deal.put("url", "/http/json/allKill.json");
			deal.put("mall", "allkill");
			deal.put("shopcode", "4027");

			array.put(deal);
		}
		{
			JSONObject deal = new JSONObject();
			deal.put("logo",
					"/mobilefirst/hotdeal/20160617/20160617_hotdeal_superdeal.png");
			deal.put("deal", "/view/ls_logo/2013/Ap_logo_536_deal1.png");
			deal.put("title", "슈퍼딜");
			deal.put("url", "/http/json/superDeal.json");
			deal.put("mall", "superdeal");
			deal.put("shopcode", "536");

			array.put(deal);
		}
		{
			JSONObject deal = new JSONObject();
			deal.put("logo",
					"/mobilefirst/hotdeal/20160617/20160617_hotdeal_shocking.png");
			deal.put("deal", "/view/ls_logo/2013/Ap_logo_5910_deal1.png");
			deal.put("title", "쇼킹딜");
			deal.put("url", "/http/json/shocking.json");
			deal.put("mall", "shocking");
			deal.put("shopcode", "5910");

			array.put(deal);
		}

		{
			JSONObject deal = new JSONObject();
			deal.put("logo",
					"/mobilefirst/hotdeal/20160617/20160617_hotdeal_tmon.png");
			deal.put("deal", "/view/ls_logo/2013/Ap_logo_6641_deal1.png");
			deal.put("title", "티몬");
			deal.put("url", "/http/json/tmon.json");
			deal.put("mall", "tmon");
			deal.put("shopcode", "6641");

			array.put(deal);
		}

		{
			JSONObject deal = new JSONObject();
			deal.put("logo",
					"/mobilefirst/hotdeal/20160617/20160617_hotdeal_wemake.png");
			deal.put("deal", "/view/ls_logo/2013/Ap_logo_6508_deal1.png");
			deal.put("title", "위메프");
			deal.put("url", "/http/json/wemake.json");
			deal.put("mall", "wemake");
			deal.put("shopcode", "6508");

			array.put(deal);
		}

		{
			JSONObject deal = new JSONObject();
			deal.put("logo",
					"/mobilefirst/hotdeal/20160617/20170228_hotdeal_ssendeal.png");
			deal.put("deal", "/view/ls_logo/2013/Ap_logo_55_deal.png");
			deal.put("title", "쎈딜");
			deal.put("url", "/http/json/ssenDeal.json");
			deal.put("mall", "ssendeal");
			deal.put("shopcode", "55");

			array.put(deal);
		}

		return array;
	}
	/**
	*	종합몰 API 데이터
	*/
	public static JSONArray getMoaTabIOS(int version) throws JSONException {
		JSONArray array = new JSONArray();
		
		/*
		{
			JSONObject data = new JSONObject();
			data.put("logo", "");
			data.put("deal", "");
			data.put("title", "Hmall");
			data.put("url", "/http/json/mallMoa_hmall.json");
			data.put("mall", "hmall");
			data.put("shopcode", "57");

			array.put(data);
		}
		
		*/
		
		
		{
			JSONObject data = new JSONObject();
			data.put("logo", "");
			data.put("deal", "");
			data.put("title", "CJ mall");
			data.put("url", "/http/json/mallMoa_CJmall.json");
			data.put("mall", "cj");
			data.put("shopcode", "806");

			array.put(data);
		}
		
		/*
		{
			JSONObject data = new JSONObject();
			data.put("logo", "");
			data.put("deal", "");
			data.put("title", "롯데닷컴");
			data.put("url", "/http/json/mallMoa_49.json");
			data.put("mall", "lotte");
			data.put("shopcode", "49");

			array.put(data);
		}
		*/
		
		{
			JSONObject data = new JSONObject();
			data.put("logo", "");
			data.put("deal", "");
			data.put("title", "GS Shop");
			data.put("url", "/http/json/mallMoa_gsshop.json");
			data.put("mall", "gs");
			data.put("shopcode", "75");

			array.put(data);
		}
		{
			JSONObject data = new JSONObject();
			data.put("logo", "");
			data.put("deal", "");
			data.put("title", "Qoo10");
			data.put("url", "/http/json/mallMoa_Qoo10.json");
			data.put("mall", "Qoo10");
			data.put("shopcode", "7857");

			array.put(data);
		}
		
		{
			JSONObject data = new JSONObject();
			data.put("logo", "");
			data.put("deal", "");
			data.put("title", "NSMall");
			data.put("url", "/http/json/mallMoa_nsmall.json");
			data.put("mall", "nsmall");
			data.put("shopcode", "974");

			array.put(data);
		}

		{
			JSONObject data = new JSONObject();
			data.put("logo", "");
			data.put("deal", "");
			data.put("title", "SSG");
			data.put("url", "/http/json/mallMoa_ssg.json");
			data.put("mall", "ssg");
			data.put("shopcode", "47");

			array.put(data);
		}		


		return array;
	}
%>