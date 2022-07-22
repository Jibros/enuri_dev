<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>
<%
	String verand = request.getParameter("verand");
	String verios = request.getParameter("veriosr");

	String ver;
	if (verand != null)
		ver = verand;
	else
		ver = verios;
	int version = 0;
	if (ver != null) {
		if (ver.length() >= 5) {
			try {
				version = Integer.parseInt(ver.substring(0, 1)) * 100
						+ Integer.parseInt(ver.substring(2, 3)) * 10
						+ Integer.parseInt(ver.substring(4, 5));
			} catch (Exception e) {
			}
		}
	}
	JSONObject makeJson = new JSONObject();

	JSONArray deals = new JSONArray();

	JSONObject superdeal = new JSONObject();
	superdeal
			.put("logo",
					"/mobilefirst/hotdeal/20160617/20160617_hotdeal_superdeal.png");
	superdeal.put("title", "슈퍼딜");
	superdeal.put("deal", "/view/ls_logo/2013/Ap_logo_536_deal1.png");
	superdeal.put("file", "superDeal");
	superdeal.put("shopcode", "536");
	superdeal.put("url", "/http/json/superDeal.json");
	superdeal.put("mall", "superdeal");

	JSONObject allkill = new JSONObject();
	allkill.put("logo",
			"/mobilefirst/hotdeal/20160617/20160617_hotdeal_allkill2.png");
	allkill.put("title", "올킬");
	allkill.put("deal", "/view/ls_logo/2013/Ap_logo_4027_deal1.png");
	allkill.put("file", "allKill");
	allkill.put("shopcode", "4027");
	allkill.put("url", "/http/json/allKill.json");
	allkill.put("mall", "allkill");

	JSONObject shockingdeal = new JSONObject();
	shockingdeal
			.put("logo",
					"/mobilefirst/hotdeal/20160617/20160617_hotdeal_shocking.png");
	shockingdeal.put("title", "쇼킹딜");
	shockingdeal.put("deal",
			"/view/ls_logo/2013/Ap_logo_5910_deal1.png");
	shockingdeal.put("file", "shocking");
	shockingdeal.put("shopcode", "5910");
	shockingdeal.put("url", "/http/json/shocking.json");
	shockingdeal.put("mall", "shocking");

	JSONObject tmon = new JSONObject();
	tmon.put("logo",
			"/mobilefirst/hotdeal/20160617/20160617_hotdeal_tmon.png");
	tmon.put("title", "티몬");
	tmon.put("deal", "/view/ls_logo/2013/Ap_logo_6641_deal1.png");
	tmon.put("file", "tmon");
	tmon.put("shopcode", "6641");
	tmon.put("url", "/http/json/tmon.json");
	tmon.put("mall", "tmon");

	JSONObject wemake = new JSONObject();
	wemake.put("logo",
			"/mobilefirst/hotdeal/20170330/20170330_hotdeal_wemake.png");
	wemake.put("title", "위메프");
	wemake.put("deal", "/view/ls_logo/2013/Ap_logo_6508_deal1.png");
	wemake.put("file", "wemake");
	wemake.put("shopcode", "6508");
	wemake.put("url", "/http/json/wemake.json");
	wemake.put("mall", "wemake");

	JSONObject ssendeal = new JSONObject();
	ssendeal.put("logo",
			"/mobilefirst/hotdeal/20160617/20170228_hotdeal_ssendeal.png");
	ssendeal.put("title", "쎈딜");
	ssendeal.put("deal", "/view/ls_logo/2013/Ap_logo_55_deal.png");
	ssendeal.put("file", "ssendeal");
	ssendeal.put("shopcode", "55");
	ssendeal.put("url", "/http/json/ssenDeal.json");
	ssendeal.put("mall", "ssendeal");

	deals.add(superdeal);
	deals.add(allkill);
	deals.add(shockingdeal);
	deals.add(tmon);
	deals.add(wemake);
	deals.add(ssendeal);

	makeJson.put("HOTDEAL", deals);

	JSONObject buftab = new JSONObject();

	buftab.put(
			"BUF_TAB_LINK_AOS",
			"market://details?id=com.enuri.deal&referrer=utm_source%3Denuri%26utm_medium%3Dhiddentab_click%26utm_campaign%3Dhiddentab_20170510");
	buftab.put("BUF_TAB_COLOR_AOS", "E4E4E4");
	buftab.put("BUF_TAB_IMAGE_IOS",
			"/images/mobilefirst/extra_tab/buftab/extratab_bg_20170510");
	buftab.put("BUF_TAB_COLOR_IOS", "E4E4E4");
	buftab.put("BUF_TAB_LINK_IOS",
			"https://itunes.apple.com/kr/app/id944887654?freetoken=outlink");
	buftab.put("BUF_TAB_IMAGE_AOS",
			"/images/mobilefirst/extra_tab/buftab/extratab_bg_20170510");
	makeJson.put("BUF_TAB", buftab);

	JSONObject eventtab = new JSONObject();

	eventtab.put(
			"EVENT_BTN_LINK_URL_IOS",
			"http://m.enuri.com/mobilefirst/event2016/allpayback_201608.jsp?freetoken=event");
	eventtab.put(
			"EVENT_BTN_LINK_URL_AOS",
			"http://m.enuri.com/mobilefirst/event2016/allpayback_201608.jsp?freetoken=event");
	eventtab.put("EVENT_BTN_YN", "Y");
	eventtab.put("EVENT_BTN_IMAGE_URL",
			"/images/mobilefirst/floating_event/event_floating0627");

	makeJson.put("EVENT_BTN", eventtab);
	///////////////////////////////////////////////////////////////
	int index = 1;
	JSONArray tabs = new JSONArray();

	if (version >= 329) {

		JSONObject maintab = new JSONObject();
		maintab.put("INDEX", index++);
		maintab.put("SHOWA", "Y");
		maintab.put("START", "200001010000");
		maintab.put("NAME", "MAIN");
		maintab.put("END", "");
		maintab.put("SHOWI", "Y");
		maintab.put("TITLE", "홈");
		tabs.add(maintab);

		JSONObject hotdealtab = new JSONObject();
		hotdealtab.put("INDEX", index++);
		hotdealtab.put("SHOWA", "Y");
		hotdealtab.put("START", "200001010000");
		hotdealtab.put("NAME", "HOTDEAL");
		hotdealtab.put("END", "");
		hotdealtab.put("SHOWI", "Y");
		hotdealtab.put("TITLE", "핫딜베스트");
		hotdealtab.put("TAG", "NEW");//NEW,HOT,DOT,FIRE
		
		tabs.add(hotdealtab);

		 JSONObject season2 = new JSONObject();
		season2.put("INDEX", index++);
		season2.put("SHOWA", "Y");
		season2.put("START", "201707010000");
		season2.put("NAME", "SEASON");
		season2.put("END", "201708171300");
		season2.put("EXTRADATA",
				"http://m.enuri.com/mobilefirst/api/main/seasonTab.json");
		season2.put("SHOWI", "Y");
		season2.put("TITLE", "#다이어트");
		tabs.add(season2); 

		JSONObject plantab = new JSONObject();
		plantab.put("INDEX", index++);
		plantab.put("SHOWA", "Y");
		plantab.put("START", "200001010000");
		plantab.put("NAME", "PLAN");
		plantab.put("END", "");
		plantab.put("SHOWI", "Y");
		plantab.put("TITLE", "이벤트/기획전");
		tabs.add(plantab);

		JSONObject shoppingnews = new JSONObject();
		shoppingnews.put("INDEX", index++);
		shoppingnews.put("SHOWA", "Y");
		shoppingnews.put("START", "200001010000");
		shoppingnews.put("NAME", "SHOPPINGNEWS");
		shoppingnews.put("END", "");
		shoppingnews.put("SHOWI", "Y");
		shoppingnews.put("TITLE", "쇼핑뉴스");
		tabs.add(shoppingnews);

		JSONObject shoppingtip2017 = new JSONObject();
		shoppingtip2017.put("INDEX", index++);
		shoppingtip2017.put("SHOWA", "Y");
		shoppingtip2017.put("START", "200001010000");
		shoppingtip2017.put("NAME", "SHOPPINGTIP_2017");
		shoppingtip2017.put("END", "");
		shoppingtip2017.put("SHOWI", "Y");
		shoppingtip2017.put("TITLE", "쇼핑팁");
		tabs.add(shoppingtip2017);

		JSONObject trendwebzine = new JSONObject();
		trendwebzine.put("INDEX", index++);
		trendwebzine.put("SHOWA", "Y");
		trendwebzine.put("START", "200001010000");
		trendwebzine.put("NAME", "TRENDWEBZINE");
		trendwebzine.put("END", "");
		trendwebzine.put("SHOWI", "Y");
		trendwebzine.put("TITLE", "트렌드웹진");
		tabs.add(trendwebzine);

		JSONObject bestshoptab = new JSONObject();
		bestshoptab.put("INDEX", index++);
		bestshoptab.put("SHOWA", "Y");
		bestshoptab.put("START", "200001010000");
		bestshoptab.put("NAME", "BESTSHOP");
		bestshoptab.put("END", "");
		bestshoptab.put("SHOWI", "Y");
		bestshoptab.put("TITLE", "특가모음");
		tabs.add(bestshoptab);

		JSONObject marthotpicktab = new JSONObject();
		marthotpicktab.put("INDEX", index++);
		marthotpicktab.put("SHOWA", "Y");
		marthotpicktab.put("START", "200001010000");
		marthotpicktab.put("NAME", "MART");
		marthotpicktab.put("END", "");
		marthotpicktab.put("SHOWI", "Y");
		marthotpicktab.put("TITLE", "마트핫픽#");
		tabs.add(marthotpicktab);

		JSONObject trendtab = new JSONObject();
		trendtab.put("INDEX", index++);
		trendtab.put("SHOWA", "Y");
		trendtab.put("START", "200001010000");
		trendtab.put("NAME", "TRANDPICKUP");
		trendtab.put("END", "");
		trendtab.put("SHOWI", "Y");
		trendtab.put("TITLE", "트렌드픽업");
		tabs.add(trendtab);

	} else {
		JSONObject maintab = new JSONObject();
		maintab.put("INDEX", index++);
		maintab.put("SHOWA", "Y");
		maintab.put("START", "200001010000");
		maintab.put("NAME", "MAIN");
		maintab.put("END", "");
		maintab.put("SHOWI", "Y");
		maintab.put("TITLE", "홈");
		tabs.add(maintab);

		JSONObject hotdealtab = new JSONObject();
		hotdealtab.put("INDEX", index++);
		hotdealtab.put("SHOWA", "Y");
		hotdealtab.put("START", "200001010000");
		hotdealtab.put("NAME", "HOTDEAL");
		hotdealtab.put("END", "");
		hotdealtab.put("SHOWI", "Y");
		hotdealtab.put("TITLE", "핫딜베스트");
		tabs.add(hotdealtab);

		JSONObject marthotpicktab = new JSONObject();
		marthotpicktab.put("INDEX", index++);
		marthotpicktab.put("SHOWA", "Y");
		marthotpicktab.put("START", "200001010000");
		marthotpicktab.put("NAME", "MART");
		marthotpicktab.put("END", "");
		marthotpicktab.put("SHOWI", "Y");
		marthotpicktab.put("TITLE", "마트핫픽#");
		tabs.add(marthotpicktab);

		JSONObject plantab = new JSONObject();
		plantab.put("INDEX", index++);
		plantab.put("SHOWA", "Y");
		plantab.put("START", "200001010000");
		plantab.put("NAME", "PLAN");
		plantab.put("END", "");
		plantab.put("SHOWI", "Y");
		plantab.put("TITLE", "기획전");
		tabs.add(plantab);

		JSONObject shoppingtiptab = new JSONObject();
		shoppingtiptab.put("INDEX", index++);
		shoppingtiptab.put("SHOWA", "Y");
		shoppingtiptab.put("START", "200001010000");
		shoppingtiptab.put("NAME", "SHOPPINGTIP");
		shoppingtiptab.put("END", "");
		shoppingtiptab.put("SHOWI", "Y");
		shoppingtiptab.put("TITLE", "쇼핑팁+");
		tabs.add(shoppingtiptab);

		JSONObject trendtab = new JSONObject();
		trendtab.put("INDEX", index++);
		trendtab.put("SHOWA", "Y");
		trendtab.put("START", "200001010000");
		trendtab.put("NAME", "TRANDPICKUP");
		trendtab.put("END", "");
		trendtab.put("SHOWI", "Y");
		trendtab.put("TITLE", "트렌드픽업");
		tabs.add(trendtab);

		JSONObject bestshoptab = new JSONObject();
		bestshoptab.put("INDEX", index++);
		bestshoptab.put("SHOWA", "Y");
		bestshoptab.put("START", "200001010000");
		bestshoptab.put("NAME", "BESTSHOP");
		bestshoptab.put("END", "");
		bestshoptab.put("SHOWI", "Y");
		bestshoptab.put("TITLE", "특가모음");
		tabs.add(bestshoptab);

	}
	makeJson.put("TABS", tabs);
	out.println(makeJson.toString());
%>
