<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.json.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@include file="/mobilefirst/ajax/appAjax/getDefine_Core.jsp"%>

<%

/**
20190708 
getDefine_NufariLib는 
에누리 3.5.0, 소셜 2.1.5 버전 이상에서 적용 되어있다 
getDefine_NufariLib와 getDefine_new_ajax.jsp 는 getDefine_Core.jsp 를 include 해서 
더 필요한 데이터를 추가하거나 삭제해서 사용한다 

getDefine_NufariLib의 내용은 getDefine_Core와 동일해 추가하는 내용은 없지만 
만약 추가한다면 getDefine_new_ajax의 추가 방법을 참고하면된다 .

추가와 수정은 하위버전 공통 수정일경우는 getDefine_Core에 내용을 추가하고 
상위버전 내용 추가일 경우는 getDefine_NufariLib에 내용을 추가하면된다 (getDefine_new_ajax의 추가 로직 참고)

*/
	
	JSONObject andDefineList = defineJson.getJSONObject("andDefineList");

	if (appName.equals("enuri")) {
		setEnuriCoreDefaultInfo_ExtraAdd(andDefineList,version);
		setHotDealInfo(andDefineList);
		// CATEBOTTOMICON 재설정 
		andDefineList.remove("CATEICONS");
		andDefineList.remove("CATEICONS_PREURL");
		if (os.equals("ios")) {
			if (version >= 339)
				setCategoryListIcon338(andDefineList, os);//카테고리 리스트 아이콘
			else
				setCategoryListIcon(andDefineList);//카테고리 리스트 아이콘
		} else {
			if (version >= 338)
				setCategoryListIcon338(andDefineList, os);//카테고리 리스트 아이콘
			else if (version >= 337)
				setCategoryListIcon(andDefineList);//카테고리 리스트 아이콘
		}
		/*
		getDefine_Core의 데이터에서 추가 할 내용 더 추가함 
		*/
		
		String[] schemes = { "reShould", "noUrl", "redirect", "lpurl", "op", "reExt", "cno", "em", "popupUrl", "popupCloseUrl", "aLogin", "lurl", "lmtype" };
		JSONArray SITE = andDefineList.getJSONArray("SITES");

		//추가할 데이터를 정의하고
		JSONObject SITE_ATTR = new JSONObject();
		for (int i = 0; i < schemes.length; i++)
			SITE_ATTR.put(schemes[i], getParam_ExtraAdd(schemes[i], version, appName, os, isDev));
		//있는 곳에다 추가한다 
		for (int i = 0; i < SITE.length(); i++) {
			JSONObject obj = SITE.getJSONObject(i);
			if (obj.has("n")) {
				String name = obj.getString("n");
				for (int j = 0; j < schemes.length; j++) {
					if(SITE_ATTR.has(schemes[j])) {
						JSONObject scheme = SITE_ATTR.getJSONObject(schemes[j]);
						if (scheme.has(name)) {
							obj.put(schemes[j], scheme.get(name));
							//break;
						}else 
							obj.put(schemes[j], "");
					}
				}
			}
		}

	} else if (appName.equals("social")) {
		
		String[] schemes = {   "noUrl",  "redirect",  "lpurl", "op", "reExt",  "cno", 
				 "em", "popupUrl", "popupCloseUrl", "aLogin", "lurl", "lmtype" };

		JSONArray SITE = andDefineList.getJSONArray("SITES");

		//추가할 데이터를 정의하고
		JSONObject SITE_ATTR = new JSONObject();
		for (int i = 0; i < schemes.length; i++)
			SITE_ATTR.put(schemes[i], getParam_ExtraAdd(schemes[i], version, appName, os, isDev));
		//있는 곳에다 추가한다 
		for (int i = 0; i < SITE.length(); i++) {
			JSONObject obj = SITE.getJSONObject(i);
			if (obj.has("n")) {
				String name = obj.getString("n");
				for (int j = 0; j < schemes.length; j++) {
					if(SITE_ATTR.has(schemes[j])) {
						JSONObject scheme = SITE_ATTR.getJSONObject(schemes[j]);
						if (scheme.has(name)) {
							obj.put(schemes[j], scheme.get(name));
						//	break;
						}
					}
				}
			}
		}
		
	}else if (appName.equals("vaccine")) {
		
		setEnuriVaccineDefaultInfo(andDefineList);
		setCardInfo(andDefineList);
		
		/*
		이부분의 로직은 다른 것과 다름
		getDefine_Core의 데이터를 직접 가져와(getParam) 처리
		*/
		ArrayList<String> siteNames = new ArrayList<String>();
		siteNames.add("auction");
		siteNames.add("gmarket");
		siteNames.add("11st");
		siteNames.add("coupang");
		siteNames.add("wemakeprice");
		siteNames.add("tmon");
		siteNames.add("gsshop");
		siteNames.add("interpark");
		siteNames.add(".lotte.com");
		siteNames.add("cjmall");
		siteNames.add("ellotte");
		siteNames.add("ssg");
		siteNames.add("shinsegaemall");
		siteNames.add("hyundaihmall");
		siteNames.add("akmall");
		siteNames.add("lotteimall");
		siteNames.add("hnsmall");
		siteNames.add(".emart");
		siteNames.add("galleria");
		siteNames.add(".nsmall.com");
		siteNames.add("e-himart");
		siteNames.add("g9");
		siteNames.add("okmall");
		siteNames.add("homeplus");
		siteNames.add("lottemart");
		String[] schemes = { "id", "nic", "t", "p", "p2", "n", "m", "h", "info", "noUrl", "popupUrl" };
		
		JSONObject ParamObj = new JSONObject();
		for (int i = 0; i < schemes.length; i++) {
			JSONObject obj = getParam(request.getServerName(), schemes[i], version, appName, os, isDev, siteNames);
			if(obj != null && obj.toString().length() > 0)
				ParamObj.put(schemes[i],obj);
			else 
				ParamObj.put(schemes[i], getParam_ExtraAdd(schemes[i], version, appName, os, isDev));
		}
		
		JSONArray sites = new JSONArray();	
		for (int i = 0; i < siteNames.size(); i++) {
			
			JSONObject cell = new JSONObject();
			cell.put("n", siteNames.get(i));
			for (int j = 0; j < schemes.length; j++) {
				JSONObject scheme = ParamObj.getJSONObject(schemes[j]);
				if(scheme.has(siteNames.get(i)))
					cell.put(schemes[j], scheme.get(siteNames.get(i)));
			}
			sites.put(cell);
		}
		defineJson.put("SITES", sites);		

	} 
out.print(defineJson);
%>

<%!
private int setEnuriCoreDefaultInfo_ExtraAdd(JSONObject defaultDefineInfo, int version)
{
	try{
		String ifdomain = "enuri.com/mobilefirst";
		defaultDefineInfo.put("OUTLINKURL_IOS", "dev.enuri.com;m.enuri.com;dis.as.criteo.com;widerplanet.com");
		defaultDefineInfo.put("IF_ALL_MENU", ifdomain + "/layerMenu_ajax.jsp");
		defaultDefineInfo.put("IF_SOCIAL_URL", "enuri.com/deal/mobile/main.deal");
		defaultDefineInfo.put("IF_SOCIAL_DETAIL_URL", "enuri.com/deal/mobile/goods.deal");
		defaultDefineInfo.put("IF_NICE", "https://nice.checkplus.co.kr");
		defaultDefineInfo.put("GO_INTENT", "androidgo");
		defaultDefineInfo.put("SWEETTRACKER_PACKAGE", "com.sweettracker.smartparcel");
		defaultDefineInfo.put("SWEETTRACKER_MARKET", "market://details?id=com.sweettracker.smartparcel");
		defaultDefineInfo.put("ZZIM_LIST_SPLIT", "ENURI");
		

		defaultDefineInfo.put("REWARDMSG", "전송에 실패 했습니다.\n재전송 하시겠습니까?");
		defaultDefineInfo.put("REWARDCODEFAIL", "결제 번호 가져오기 실패");
		// IOS에서 쿠키를 찾기 위해 사용하는 문자열
		// 쿠키를 원데이터로 읽으면 name, value가 서로 분리되어있는데 합쳐서 검색이 편하도록 하기 위해
		defaultDefineInfo.put("IOS_COOKIE_FIND_STR1", "\" value:\"");
		defaultDefineInfo.put("IOS_COOKIE_FIND_STR2", " value:\"=-=\" "); // 쿠키의 value값을 찾는 정규식
		defaultDefineInfo.put("ICONURL", "http://img.enuri.info/images/mobilefirst/browser/marketicon/");

		defaultDefineInfo.put("EB_USE", true);//에누리 브라우져 사용 여부 
		defaultDefineInfo.put("ISP_SCHEME", "ispmobile://");//"?TID="); // 에누리 브라우저에서 ISP결제시 URL체크 IOS에서 사용
		defaultDefineInfo.put("IOS_LOGIN_LIMITE", "10"); // ajax로만 동작하는 쇼핑몰에서는 로그아웃을 확인하기가 힘듬, 따라서 타임아웃으로 결정함
		defaultDefineInfo.put("IOS_LOGOUT_LOGIN_INFO_DEL", "Y"); // IOS에서 로그아웃 할때 쇼핑몰들의 로그인 정보를 삭제할지를 결정하는 플래그 Y:삭제
		defaultDefineInfo.put("LOGOUT_ALERT", "아이디"); // 
		defaultDefineInfo
				.put("COMFAIL_IOS",
						"document.getElementById('divMessageForInvalidPWD').textContent&document.getElementById('layerPopup').getElementsByClassName('login_layer')[0].textContent&다시 입력해주세요.&document.getElementById('webkit-xml-viewer-source-xml').textContent");//쇼핑몰 로그인 체크 ios


		// 마이페이지 리워드 관련 옵션
		defaultDefineInfo.put("REWARD_SHOW_AND_FLAG", "Y"); // AND 마이페이지에서 리워드정보를 보여줄지  
		defaultDefineInfo.put("REWARD_SHOW_IOS_FLAG", "Y"); // IOS 마이페이지에서 리워드정보를 보여줄지  
		defaultDefineInfo.put("REWARD_GUIDE_FLAG", "Y"); // 리워드 가이드를 보여줄지
		defaultDefineInfo.put("REWARD_BANNER_URL", "http://img.enuri.info/images/mobilefirst/reward/mobile/reward_off_banner");
		defaultDefineInfo.put("REWARD_BANNER_LINK_URL", "/mobilefirst/event/benefit.jsp");//ios 마이메뉴 , 누파리 자세히보기 3.0.1까지 이렇게 되고 이후로는 and와 맞춤 // and 마이메뉴 링크
		defaultDefineInfo.put("REWARD_DETAIL_INFO_LINK", "http://m.enuri.com/mobilefirst/event/benefit.jsp?freetoken=event&app=Y"); // and 자세히 보기 링크
		defaultDefineInfo.put("REWARD_INFO_TEXT1", "라면쿠폰\n교환권");
		defaultDefineInfo.put("REWARD_INFO_TEXT2", "지급예정\n교환권");
		defaultDefineInfo.put("REWARD_INSERT_AND_FLAG", "Y"); // 리워드 저장을 할 것인지를 확인함
		defaultDefineInfo.put("REWARD_INSERT_IOS_FLAG", "Y"); // 리워드 저장을 할 것인지를 확인함

		// 리워드인 상품은 누파리에서 문구 보여주기"
		defaultDefineInfo.put("REWARD_DETAIL_INFO_SHOW", "Y"); // 누파리의 상품창에서 리워드 관련 문구 보여줄지
		defaultDefineInfo.put("REWARD_DETAIL_INFO_HIGHLIGHT", "e머니"); // 적립대상 url이 아닐 경우
		defaultDefineInfo.put("REWARD_DETAIL_INFO_TEXT1", "구매 후 생활혜택 e머니 적립받는 방법"); // 1. 비로그인 상태 / 적립 가능 쇼핑몰
		defaultDefineInfo.put("REWARD_DETAIL_INFO_TEXT2", "생활혜택 e머니를 받을 수 있습니다."); // 3. 로그인 상태 /적립 가능 쇼핑몰 /적립군X
		defaultDefineInfo.put("REWARD_DETAIL_INFO_TEXT3", "생활혜택 e머니를 받을 수 있습니다."); // 4. 로그인 상태 /적립 가능 쇼핑몰 /적립군O
		// 2. 비로그인 상태 / 적립 불가 쇼핑몰
		// 5. 로그인 상태 / 적립 불가 쇼핑몰 / 적립군X
		// 6. 로그인 상태 / 적립 불가 쇼핑몰 / 적립군O
		defaultDefineInfo.put("REWARD_DETAIL_INFO_TEXT4", "라면 적립 쇼핑몰이 아닙니다.");

		// 로그인 url
		defaultDefineInfo.put("SERVER_LOGINURL", "/mobilefirst/login/login.jsp?app=Y&backUrl=");

		defaultDefineInfo.put("NUFARI_LOGIN_OK_INFO", "에누리 로그인 중입니다.");
		defaultDefineInfo.put("NUFARI_LOGIN_SUGGESTION_INFO", "에누리 로그인을 하신 후 '쇼핑몰 연결' 서비스를 사용해 보세요.");
		defaultDefineInfo.put("NUFARI_OUTLINK_INFO", "ISP, 결제오류 시 다른브라우저를 이용해보세요");
		defaultDefineInfo.put("NUFARI_INFO_DELAY", "10");//값 * 하루 .... 0보다 작으면 안띄움

		defaultDefineInfo.put("REVIEW_SIZE", "100");

		//안드로이드 아이폰 3.0.4 버젼 부터 이머니 적용됨
		defaultDefineInfo.put("EMONEY_GUIDE", "Y");
		defaultDefineInfo.put("EMONEY_SHOW_AND_FLAG", "Y"); // AND 마이페이지에서 리워드정보를 보여줄지  
		defaultDefineInfo.put("EMONEY_SHOW_IOS_FLAG", "Y"); // IOS 마이페이지에서 리워드정보를 보여줄지  
		defaultDefineInfo.put("EMONEY_INSERT_AND_FLAG", "Y");
		defaultDefineInfo.put("EMONEY_STORE", "/mobilefirst/emoney/emoney_store.jsp");
		defaultDefineInfo.put("EMONEY_HISTORY", "/mobilefirst/emoney/emoney.jsp");
		defaultDefineInfo.put("EMONEY_DETAIL_INFO_SHOW", "Y");
		defaultDefineInfo.put("EMONEY_DETAIL_INFO_HIGHLIGHT", "e머니"); // 하이라이트 
		defaultDefineInfo.put("EMONEY_DETAIL_INFO_POINT_OK", "생활혜택 e머니를 받을 수 있습니다.;혜택받기 >"); // 로그인 > 적립가능 쇼핑몰
		defaultDefineInfo.put("EMONEY_DETAIL_INFO_POINT_NO", "생활혜택 e머니 적립 쇼핑몰이 아닙니다.;적립받기 >"); // 로그인 > 적립불가 쇼핑몰 
		defaultDefineInfo.put("EMONEY_DETAIL_INFO_LOGIN", "구매 후 생활혜택 e머니 적립받는 방법;자세히보기 >"); // 로그인 없이 쇼핑몰 접속 
		defaultDefineInfo.put("EMONEY_DETAIL_INFO_LINK", "http://m.enuri.com/mobilefirst/event2016/allpayback_201610.jsp?freetoken=event&app=Y"); // and 자세히 보기 링크

		defaultDefineInfo.put("DEALCARDW", "640");
		defaultDefineInfo.put("DEALCARDH", "337");

		defaultDefineInfo.put("ADULTCATE", "1640;");
		defaultDefineInfo.put("ADULTIMG", "http://img.enuri.info/images/mobilenew/images/img_19.jpg");

		// iOS 뉴스 디테일에서 bypass해야 할 URL
		defaultDefineInfo.put("NEWS_BYPASS_URL", "gamemeca;");

		// 마이페이지 인증 show Y/N
		defaultDefineInfo.put("MYPAGE_AOS_CERTIFY_SHOW_YN", "Y");
		defaultDefineInfo.put("MYPAGE_IOS_CERTIFY_SHOW_YN", "Y");		
		
		defaultDefineInfo.put("ENURILOGIN_SHOP_ICON_PREURL", "http://img.enuri.info/images/mobilefirst/browser/marketicon/");
	}catch(Exception e)
	{
		
	}
	
	return 0;
}
public JSONObject getParam_ExtraAdd(String scheme, int version, String appName, String os, boolean isDev) {
		JSONObject schemes = new JSONObject();

		if (scheme.equals("reShould")) { // iOS에서 souldstart에서 리워드를 체크해야 하는 경우. 
			// url에 2번째 Array의 값이 있는 경우 3번째 Array의 값으로 split를 한다.
			// 그런 후 마지막 값으로 Split 한 배열의 index를 가져 온다.
			try {
				//schemes.put("g9", "FROM_URL=-=Buy.htm#/Buy/PayComplete=-=#/Buy/PayComplete/=-=1");
			} catch (Exception e) {
			}
		} else if (scheme.equals("noUrl")) { // iOS에서 무시해야 할 URL, iOS는 3.0.6 이후로 사용하지 않음
			try {
				schemes.put("11st", "/a.st?url");
			} catch (Exception e) {
			}
		} else if (scheme.equals("redirect")) { // 이 url이면 수익코드가 붙은 홈페이지로 리다이렉트를 한다.
			try {
				schemes.put("11st", "");
				schemes.put("gmarket",
						"[{\"t\":\"c\",\"url\":\"http://mobile.gmarket.co.kr/?pCache=\"},{\"t\":\"e\",\"url\":\"http://sna.gmarket.co.kr/?cc=CHD0B001&url=http://www.gmarket.co.kr/\"}]");
				schemes.put("g9", "");
				schemes.put("auction", "[{\"t\":\"e\",\"url\":\"\"}]");
				schemes.put("interpark", "[{\"t\":\"e\",\"url\":\"http://m.shop.interpark.com/#mwm1=common&mwm2=header&mwm3=bi\"}]");
				schemes.put(".emart", "[{\"t\":\"e\",\"url\":\"http://m.emart.ssg.com/\"}]");
				schemes.put("shinsegaemall", "[{\"t\":\"e\",\"url\":\"http://m.shinsegaemall.ssg.com/mall/main.ssg\"}]");
				schemes.put("ssg", "[{\"t\":\"e\",\"url\":\"http://m.ssg.com/\"}]");
				schemes.put("gsshop", "");
				schemes.put("wemakeprice", "[{\"t\":\"e\",\"url\":\"https://mw.wemakeprice.com/main/\"}]");
				schemes.put("tmon", "[{\"t\":\"e\",\"url\":\"http://m.tmon.co.kr/\"}]");
				schemes.put("cjmall", "");
				schemes.put("hyundaihmall", "");
				schemes.put("akmall", "");
				schemes.put("e-himart", "");
				schemes.put("galleria", "");
				schemes.put("okmall", "");
				schemes.put(".nsmall.com", "");
				schemes.put("homeplus",
						"[{\"t\":\"c\",\"url\":\"http://mdirect.homeplus.co.kr/front.app.exhibition.main.Main.ghs\",\"pv\":[{\"p\":\"extends_id\",\"v\":\"enuri\"}]}]");
				schemes.put("lottemart", "");
				schemes.put(".lotte.com", "[{\"t\":\"c\",\"url\":\"http://m.lotte.com/main_phone.do?\",\"pv\":[{\"p\":\"cn\",\"v\":\"112346\"},{\"p\":\"cdn\",\"v\":\"783491\"}]}]");
				schemes.put("lotteimall", "");
				schemes.put("ellotte",
						"[{\"t\":\"c\",\"url\":\"http://m.ellotte.com/main_ellotte_phone.do?\",\"pv\":[{\"p\":\"cn\",\"v\":\"153348\"},{\"p\":\"cdn\",\"v\":\"2942692\"}]}]");
				schemes.put("hnsmall", "");
				schemes.put("coupang", "");
				schemes.put("epost", "");
				schemes.put("kyobo", "");
				schemes.put("yes24", "");
				schemes.put("aladin", "");
				schemes.put("nsmall", "");
			} catch (Exception e) {
			}
		} else if (scheme.equals("lpurl")) { // 로그인 하기 전에 한 번 띄워야 하는 url, iOS는 3.0.6 이후로 사용하고 있지 않음
			try {
				schemes.put("11st", "");
				schemes.put("gmarket", "");
				schemes.put("auction", "");
				schemes.put("interpark", "");
				schemes.put(".emart", "");
				schemes.put("shinsegaemall", "http://m.shinsegaemall.ssg.com/mall/main.ssg");
				schemes.put("ssg", "");
				schemes.put("gsshop", "");
				schemes.put("wemakeprice", "");
				schemes.put("tmon", "");
				schemes.put("cjmall", "");
				schemes.put("hyundaihmall", "");
				schemes.put("akmall", "");
				schemes.put("homeplus", "");
				schemes.put(".lotte.com", "http://m.lotte.com/login/logout.do");
				schemes.put("lotteimall", "https://securem.lotteimall.com/member/goLogout.lotte");
				//신 엘롯데 
				schemes.put("ellotte", "https//m.members.ellotte.com/members-mo/logout");
				//구 엘롯데 
				//schemes.put("ellotte", "http://m.ellotte.com/login/logout.do");
				schemes.put("hnsmall", "");
				schemes.put("coupang", "");
				schemes.put("epost", "");
				schemes.put("kyobo", "");
				schemes.put("yes24", "");
				schemes.put("aladin", "");
				schemes.put("nsmall", "");
			} catch (Exception e) {
			}
		} else if (scheme.equals("op")) { // iOS에서 ISP가 안된다는 메세지를 보여줘야 함, iOS는 3.0.6 이후로 사용하지 않음
			try {
				schemes.put("11st", "mw/order/orderbasicfirststep.tmall");
				schemes.put("gmarket", "ko/order?orderidx");
				schemes.put("g9", "ko/order?orderidx");
				schemes.put("auction", "common/ordermobile.aspx");
				schemes.put("interpark", "order/shop/payment.html");
				schemes.put(".emart", "m/order/ordpage.ssg");
				schemes.put("shinsegaemall", "m/order/ordpage.ssg");
				schemes.put("ssg", "m/order/ordpage.ssg");
				schemes.put("gsshop", "mobile/ordsht/ordsht.gs");
				schemes.put("wemakeprice", "m/order/pay");
				schemes.put("tmon", "m/buy?selected_id");
				schemes.put("cjmall", "m/order/order.jsp?app_cd");
				schemes.put("hyundaihmall", "front/order.do");
				schemes.put("akmall", "order/delipaymentinpt.do");
				schemes.put("homeplus", "orderfulfilment/order/info.do");
				schemes.put(".lotte.com", "order/m/order_form.do");
				schemes.put("lotteimall", "order/searchordersheetlist.lotte");
				schemes.put("ellotte", "order/m/order_form.do");
				schemes.put("hnsmall", "order/input#init");
				schemes.put("coupang", "");
				schemes.put("epost", "");
				schemes.put("kyobo", "");
				schemes.put("yes24", "");
				schemes.put("aladin", "");
				schemes.put("nsmall", "");
			} catch (Exception e) {
			}
		} else if (scheme.equals("reExt")) { // reExt 스킴이 포함된 URL이 지나가고 난 후 적립을 위한 구매 정보를 가져 옴, 3.0.6 이상에서는 사용하지 않음
			try {
				schemes.put("11st", "");
				schemes.put("gmarket", "");
				schemes.put("auction", "");
				schemes.put("interpark", "");
				schemes.put(".emart", "");
				schemes.put("shinsegaemall", "");
				schemes.put("ssg", "");
				schemes.put("gsshop", "");
				schemes.put("wemakeprice", "");
				schemes.put("tmon", "");
				schemes.put("cjmall", "");
				schemes.put("hyundaihmall", "");
				schemes.put("akmall", "");
				schemes.put("homeplus", "");
				schemes.put(".lotte.com", "/dacom/xansim/");
				schemes.put("lotteimall", "dis.as.criteo.com");
				schemes.put("ellotte", "dis.as.criteo.com");
				schemes.put("hnsmall", "");
				schemes.put("coupang", "");
				schemes.put("epost", "");
				schemes.put("kyobo", "");
				schemes.put("yes24", "");
				schemes.put("aladin", "");
				schemes.put("nsmall", "");
			} catch (Exception e) {
			}
		} else if (scheme.equals("cno")) { // 아래 문자열이 포함되는 URL에서는 로그인 체크를 하지 않음, iOS는 3.0.6 이후로 사용하지 않음
			try {
				schemes.put("11st", "login.tmall=-=blank");
				schemes.put("gmarket", "blank");
				schemes.put("auction", "https://=-=blank=-=http://member=-=http://www");
				schemes.put("interpark", "blank");
				schemes.put(".emart", "blank");
				schemes.put("shinsegaemall", "/mall/main.ssg=-=blank");
				schemes.put("ssg", "blank");
				schemes.put("gsshop", "https://=-=blank");
				schemes.put("wemakeprice", "https");
				schemes.put("tmon", "https://=-=blank");
				schemes.put("cjmall", "blank");
				schemes.put("hyundaihmall", "https://=-=blank");
				schemes.put("akmall", "https://=-=blank");
				schemes.put("homeplus", "https://=-=blank");
				schemes.put(".lotte.com", "/login/logout.do=-=blank");
				schemes.put("lotteimall", "/member/goLogout.lotte=-=blank");
				schemes.put("ellotte", "/members-mo/logout=-=blank");
				schemes.put("hnsmall", "https://=-=blank");
				schemes.put("coupang", "");
				schemes.put("epost", "");
				schemes.put("kyobo", "");
				schemes.put("yes24", "");
				schemes.put("aladin", "");
				schemes.put("nsmall", "");
			} catch (Exception e) {
			}
		} else if (scheme.equals("em")) { // 완료 메세지, iOS는 3.0.6 이후로 사용하지 않음
			try {
				schemes.put("11st", "");
				schemes.put("gmarket", "");
				schemes.put("auction", "");
				schemes.put("interpark", "");
				schemes.put(".emart", "");
				schemes.put("shinsegaemall", "SUCCESS");
				schemes.put("ssg", "SUCCESS");
				schemes.put("gsshop", "");
				schemes.put("wemakeprice", "");
				schemes.put("tmon", "");
				schemes.put("cjmall", "");
				schemes.put("hyundaihmall", "");
				schemes.put("akmall", "");
				schemes.put("homeplus", "");
				schemes.put(".lotte.com", "");
				schemes.put("lotteimall", "");
				schemes.put("ellotte", "");
				schemes.put("hnsmall", "");
				schemes.put("coupang", "");
				schemes.put("epost", "");
				schemes.put("kyobo", "");
				schemes.put("yes24", "");
				schemes.put("aladin", "");
				schemes.put("nsmall", "");
			} catch (Exception e) {
			}
		} else if (scheme.equals("popupUrl")) { // iOS에서 팝업을 실행하도록 해줌, (iOS 3.0.6,160418 기준) 현재 동작하지 않음
			try {
				schemes.put("interpark", "/order/shop/pay_addr_zip.html=-=/product/content.html=-=/basicdata/AddressPopup.do");
				schemes.put("hyundaihmall", "/front/smItemDetailImg.do");
				schemes.put(".nsmall.com", "/mobile/kicc/easypay_mob_request.jsp");
			} catch (Exception e) {
			}
		} else if (scheme.equals("popupCloseUrl")) {// iOS의 팝업 웹뷰에서 submit을 하고 window.close() javascript를 호출하는 URL
			try {
				schemes.put("interpark", "/order/shop/get_addr.html=-=/order/book/get_addr.php");
				schemes.put(".nsmall.com", "/html/common/return_payment.html");
			} catch (Exception e) {
			}
		} else if (scheme.equals("aLogin")) { // ajax를 사용하는 로그인에서 타이머로 로그인 실패 체크, iOS는 3.0.6 이후로 사용하지 않음
			try {
				schemes.put("wemakeprice", "Y");
				schemes.put("cjmall", "Y");
			} catch (Exception e) {
			}
		} else if (scheme.equals("lurl")) { // 잘 모르겠음, iOS는 3.0.6 이후로 사용하지 않음
			try {
				schemes.put("lotteimall", "");
				schemes.put("ellotte", "");
			} catch (Exception e) {
			}
		} else if (scheme.equals("lmtype")) { // 잘 모르겠음, iOS는 3.0.6 이후로 사용하지 않음
			try {
				schemes.put("ellotte", "1-1-0-0");
			} catch (Exception e) {
			}
		}else if (scheme.equals("reExt")) { // reExt 스킴이 포함된 URL이 지나가고 난 후 적립을 위한 구매 정보를 가져 옴, 3.0.6 이상에서는 사용하지 않음
			try {
				schemes.put("11st", "");
				schemes.put("gmarket", "");
				schemes.put("auction", "");
				schemes.put("interpark", "");
				schemes.put(".emart", "");
				schemes.put("shinsegaemall", "");
				schemes.put("ssg", "");
				schemes.put("gsshop", "");
				schemes.put("wemakeprice", "");
				schemes.put("tmon", "");
				schemes.put("cjmall", "");
				schemes.put("hyundaihmall", "");
				schemes.put("akmall", "");
				schemes.put("homeplus", "");
				schemes.put(".lotte.com", "/dacom/xansim/");
				schemes.put("lotteimall", "dis.as.criteo.com");
				schemes.put("ellotte", "dis.as.criteo.com");
				schemes.put("hnsmall", "");
				schemes.put("coupang", "");
				schemes.put("epost", "");
				schemes.put("kyobo", "");
				schemes.put("yes24", "");
				schemes.put("aladin", "");
				schemes.put("nsmall", "");
			} catch (Exception e) {
			}
		}

		return schemes;
	}

	public int setHotDealInfo(JSONObject defaultDefineInfo) {
		try {
			JSONArray hotDeal = new JSONArray();

			String[] hotDealMalls = { "superdeal", "allkill", "shocking", "tmon", "coupang", "wemake" };
			String[] hotDealUrls = { "/http/json/superDeal.json", "/http/json/allKill.json", "/http/json/shocking.json", "/http/json/tmon.json", "/http/json/coupang.json",
					"/http/json/wemake.json" };
			String[] hotDealLogos = { "/20160617/20160617_hotdeal_superdeal.png", "/20160617/20160617_hotdeal_allkill.png", "/20160617/20160617_hotdeal_shocking.png",
					"/20200220/20200220_hotdeal_tmon.png", "/20160617/20160617_hotdeal_coupang.png", "/20160617/20160617_hotdeal_wemake.png" };
			String[] hotDealTitles = { "슈퍼딜", "올킬", "쇼킹딜", "티몬", "쿠팡", "위메프" };

			for (int i = 0; i < hotDealMalls.length; i++) {
				JSONObject hotDealSites = new JSONObject();
				hotDealSites.put("mall", hotDealMalls[i]);
				hotDealSites.put("title", hotDealTitles[i]);
				hotDealSites.put("url", hotDealUrls[i]);
				hotDealSites.put("logo", hotDealLogos[i]);

				hotDeal.put(hotDealSites);
			}

			defaultDefineInfo.put("HOTDEAL", hotDeal);
		} catch (Exception e) {
		}

		return 0;
	}

	public void setCategoryListIcon(JSONObject defaultDefineInfo) {
		//enuri 3.3.7 버전 부터 적용
		try {
			JSONArray arr = new JSONArray();
			arr.put("icon_category_1.png");
			arr.put("icon_category_2.png");
			arr.put("icon_category_3.png");
			arr.put("icon_category_4.png");
			arr.put("icon_category_5.png");
			arr.put("icon_category_6.png");
			arr.put("icon_category_7.png");
			//arr.put("icon_category_7.png");
			defaultDefineInfo.put("CATEICONS", arr);

		} catch (Exception e) {
		}
	}
	
		public int setEnuriVaccineDefaultInfo(JSONObject defaultDefineInfo) {
		try {
			defaultDefineInfo.put("ICONURL", "http://img.enuri.info/images/mobilefirst/browser/marketicon/");
			defaultDefineInfo.put("EB_USE", "true");
			defaultDefineInfo.put("REVIEW_SIZE", "100");

			JSONArray arrMallData = new JSONArray();
			arrMallData.put("/http/json/shocking.json");
			arrMallData.put("/http/json/superDeal.json");
			arrMallData.put("/http/json/allKill.json");

			arrMallData.put("/http/json/tmon.json");
			arrMallData.put("/http/json/wemake.json");
			// 			arrMallData.put("/http/json/coupang.json");

			defaultDefineInfo.put("MALLDATA", arrMallData);

			JSONArray arrMallIcon = new JSONArray();
			arrMallIcon.put("/images/mobilefirst/module/tabs/tab_shocking");
			arrMallIcon.put("/images/mobilefirst/module/tabs/tab_superdeal");
			arrMallIcon.put("/images/mobilefirst/module/tabs/tab_allkill");

			arrMallIcon.put("/images/mobilefirst/module/tabs/tab_tmon");
			arrMallIcon.put("/images/mobilefirst/module/tabs/tab_wemake");
			// 			arrMallIcon.put("/images/mobilefirst/module/tabs/tab_coupang");

			defaultDefineInfo.put("MALLICON", arrMallIcon);

		} catch (Exception e) {
		}

		return 0;
	}
	%>