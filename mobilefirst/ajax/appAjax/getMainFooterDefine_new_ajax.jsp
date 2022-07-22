<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.json.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.enuri.util.common.ChkNull"%>

<%
	request.setCharacterEncoding("UTF-8");
	String ver = request.getParameter("ver");
	String appName = request.getParameter("app");

	if (ver==null) ver = "0.0.0";

	String os;

	int version = 0;
	if(ver.length()>=5) {
		try {
			version = Integer.parseInt(ver.substring(0, 1)) * 100 + Integer.parseInt(ver.substring(2, 3)) * 10 + Integer.parseInt(ver.substring(4, 5));
		} catch(Exception e) {}
	}

	if (appName == null) {
		appName = "enuri";
	}

	if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1 ) { 
		os="aos";
	} else {
		os="ios";
	}

	JSONObject defineJson = new JSONObject();
	JSONArray sites = new JSONArray();
	JSONArray iOSAppStores = new JSONArray();
	JSONArray andAppStores = new JSONArray();

	try {
		defineJson.put("APPSTORE_TITLE", "에누리 패밀리 앱");
	} catch (Exception e) {}

	String[] codes = { "536","4027","5910","55","47","49","57","90","75","806","663","6588","6508","6641","6603","7692","6547","6620","974","374" };

	String[] urls = { "http://www.gmarket.co.kr/index.asp?jaehuid=200006254&DEVICE_BROWSER=Y",
						"http://banner.auction.co.kr/bn_redirect.asp?ID=BN00181187&DEVICE_BROWSER=Y",
						"http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1000997249&DEVICE_BROWSER=Y",
						"http://m.interpark.com/mobileGW.html?svc=Shop&bizCode=P14126&url=http://m.shop.interpark.com&DEVICE_BROWSER=Y",
						"http://m.shinsegaemall.ssg.com/mall/main.ssg?ckwhere=s_enuri&DEVICE_BROWSER=Y",
						"http://m.lotte.com/main_phone.do?udid=&cn=112346&cdn=783491&DEVICE_BROWSER=Y",
						"http://www.hyundaihmall.com/front/shNetworkShop.do?NetworkShop=Html&ReferCode=022&Url=http://www.hyundaihmall.com/Home.html&DEVICE_BROWSER=Y",
						"http://www.akmall.com/assc/associate.jsp?assc_comp_id=26392&DEVICE_BROWSER=Y",
						"http://with.gsshop.com/jsp/jseis_withLGeshop.jsp?DEVICE_BROWSER=Y&media=Pg&gourl=http://m.gsshop.com",
						"http://mw.cjmall.com/m/main.jsp?app_cd=ENURI&DEVICE_BROWSER=Y",
						"http://www.lotteimall.com/coop/affilGate.lotte?chl_no=140769&chl_dtl_no=2540476&DEVICE_BROWSER=Y",
						"http://m.hnsmall.com/channel/gate?channel_code=20200&DEVICE_BROWSER=Y",
						"http://www.wemakeprice.com/widget/aff_bridge_public/enuri_m/0/Y/PRICE_af?DEVICE_BROWSER=Y",
						"http://m.ticketmonster.co.kr/entry/?jp=80025&ln=214285&DEVICE_BROWSER=Y",
						"http://m.boribori.co.kr/partner/commonv2.aspx?partnerid=b_enuri_m2&ReturnUrl=http%3a%2f%2fm.boribori.co.kr&DEVICE_BROWSER=Y",
						"http://m.g9.co.kr/Default.htm?jaeuid=200006436#/Display/G9Today?DEVICE_BROWSER=Y",
						"http://m.ellotte.com/main.do?&cn=153348&cdn=2942692&DEVICE_BROWSER=Y",
						"http://www.galleria.co.kr/common.do?method=join&channel_id=2764&link_id=0001&DEVICE_BROWSER=Y",
						"http://m.nsmall.com/mjsp/site/gate.jsp?co_cd=190&target=http%3A%2F%2Fm.nsmall.com%2FMainView&DEVICE_BROWSER=Y",
						"http://m.emart.ssg.com/planshop/planShopBest.ssg?ckwhere=m_enuri&DEVICE_BROWSER=Y" };

	String[] mall = { "gmarket", "auction", "11st", "interpark", "shinsegaemall", 
						".lotte.com", "hyundaihmall", "akmall", "gsshop", "cjmall",
						"lotteimall", "hnsmall", "wemakeprice", "ticketmonster", "boribori", 
						"g9", "ellotte", "galleria", "nsmall", "emart"};

	for (int i = 0 ; i < 20 ; i++) {
		JSONObject site = new JSONObject();

		try {
			site.put("site", mall[i]);
			site.put("code", codes[i]);
			site.put("url", urls[i]);
			site.put("img", "/20160613/20160613_logo_" + Integer.toString(i + 1) + ".gif");

			sites.put(site);
		} catch (Exception e) {}
	}
	try {
		defineJson.put("SITE", sites);
	} catch (Exception e) {}

	String[] appStoreTitle = { "스마트 택배", "홈쇼핑가격비교", "소셜가격비교", "골프예약"};
	String[] appStoreURLiOS = { "https://itunes.apple.com/kr/app/id523045854?freetoken=outlink",
		"https://itunes.apple.com/kr/app/id1053348835?freetoken=outlink", 
		"https://itunes.apple.com/kr/app/id944887654?freetoken=outlink", 
		"https://itunes.apple.com/kr/app/id641395664?freetoken=outlink" };
	String[] appStoreURLAndroid = { "market://details?id=com.sweettracker.smartparcel&referrer=utm_source%Enuri%26utm_medium%app_banner%26utm_campaign%3Dinstall_promotion_from_Enuri", 
		"market://details?id=com.enuri.homeshopping&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_app_click%26utm_campaign%3Dfamilyapp20151209", 
		"market://details?id=com.enuri.deal&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_app_click%26utm_campaign%3Dfamilyapp20151209",
		"market://details?id=com.xgolf.booking&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_app_click%26utm_campaign%3Dfamilyapp20151221" };

	for (int i = 0 ; i < 4 ; i++) {
		JSONObject appStore = new JSONObject();
		try {
			appStore.put("title", appStoreTitle[i]);
			appStore.put("url", appStoreURLiOS[i]);

			iOSAppStores.put(appStore);
		} catch (Exception e) {}
	}

	for (int i = 0 ; i < 4 ; i++) {
		JSONObject appStore = new JSONObject();
		try {
			appStore.put("title", appStoreTitle[i]);
			appStore.put("url", appStoreURLAndroid[i]);

			andAppStores.put(appStore);
		} catch (Exception e) {}
	}

	try {
		defineJson.put("APPSTORE_IOS", iOSAppStores);
		defineJson.put("APPSTORE_AND", andAppStores);

		defineJson.put("FOOTER_AD_URL", "http://dev.enuri.com/mobilefirst/event/event_expedia_201605.jsp?freetoken=event");
		defineJson.put("FOOTER_AD_IMAGE", "http://img.enuri.info/images/mobilefirst/event/footerimg2.jpg");
	} catch (Exception e) {}

	out.print(defineJson);
%>