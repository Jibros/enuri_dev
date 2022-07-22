<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.json.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.enuri.util.common.ChkNull"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@page import="java.net.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String ver = request.getParameter("ver");
	String appName = request.getParameter("app");
	String os;

	if (ver == null)
		ver = "0.0.0";

	int version = 0;
	if (ver.length() >= 5) {
		try {
			version = Integer.parseInt(ver.substring(0, 1)) * 100 + Integer.parseInt(ver.substring(2, 3)) * 10 + Integer.parseInt(ver.substring(4, 5));
		} catch (Exception e) {
		}
	}
	if (appName == null)
		appName = "enuri";
	if (ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1)
		os = "aos";
	else
		os = "ios";
	//누파리 라이브러리에 적용 안해도 되는 여기서 만든 디파인 데이터 (기준은 3.4.0 이하 버전은 사용하지 않는 데이터)
	JSONObject makeJSON = getDefineJson(appName, version, os);
	//누파리 라이브러리 적용된 버전에서 사용할 다운받은 디파인 데이터 
	JSONObject getNewDefineJSON = getJSONObjectfromHttp("http://localhost/mobilefirst/ajax/appAjax/getDefine_NufariLib.jsp?ver=" + ver + "&app=" + appName + "&os=" + os);
	getNewDefineJSON = getNewDefineJSON.getJSONObject("andDefineList");
	

	
	
	//다운 받은 디파인 데이터 키값을 가져와 확인한다 
	Iterator<?> keys = getNewDefineJSON.keys();
	
	
	while (keys.hasNext()) {
		String key = (String) keys.next();
		System.out.println("key"+key);
		if (key.equals("CATEICONS")) {
			//무시한다 
			//새버전에서 쓰는건 쓰고 이버전에서 쓰는건 여기서 만든다 
		}
		//키가 SITE 이면 예외 처리 한다 
		else if (key.equals("SITES")) {
			JSONArray arrMakeJSON = makeJSON.getJSONArray("SITES");
			JSONArray arrGetNewDefineJSON = getNewDefineJSON.getJSONArray("SITES");

			for (int i = 0; i < arrMakeJSON.length(); i++) {
				//만들어진 디파인 데이터 site 쇼핑몰과(arrMakeJSON.getJSONObject(i).getString("n")) 같은 쇼핑몰이 
				//다운받은 디파인 데이터 파일에(arrGetNewDefineJSON) 있다면  다운받은 json 의 쇼핑몰 데이터를 가져와서 
				JSONObject obj = getJSONObjectInJSONArray(arrGetNewDefineJSON, arrMakeJSON.getJSONObject(i).getString("n"));
				if (obj != null) {
					//다운 받은 데이터 키 값을 가져와 검사한다 
					Iterator<?> sitekeys = obj.keys();
					while (sitekeys.hasNext()) {
						String sitekey = (String) sitekeys.next();
						//다운받은 데이터 키값과 같은 키가 없다면 다운 받은 키의 값을 만들어진 데이터에 넣는다 
						if (!arrMakeJSON.getJSONObject(i).has(sitekey))
							arrMakeJSON.getJSONObject(i).put(sitekey, obj.get(sitekey));
					}
				}
			}
		}  else {
			//생성한 디파인 데이터가 새로운 디파인 데이터 키값과 같은게 없다면 삽입 
			//왜냐면 새로운 디파인에서 선언한게 여기서 덥어 져 버리면 하위버전은 버그 생김 
			//여기서 우선순위는 하위 버전 데이터가 우선임 
			if (!makeJSON.has(key))
				makeJSON.put(key, getNewDefineJSON.get(key));
		}
	}

	JSONObject defineJson = new JSONObject();
	defineJson.put("andDefineList", makeJSON);
	out.print(defineJson);
%>

<%!public JSONObject getDefineJson(String appName, int version, String os) {
		JSONObject defineJson = new JSONObject();

		try {
			Date date = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			defineJson.put("version", formatter.format(date));

			if (appName.equals("enuri")) {
				setEnuriCoreDefaultInfo(defineJson); // 기본 정보 삽입
				setHotDealInfo(defineJson); // 핫딜 정보 삽입
				if (os.equals("ios")) {
					if (version >= 339)
						setCategoryListIcon338(defineJson, os);//카테고리 리스트 아이콘
					else
						setCategoryListIcon(defineJson);//카테고리 리스트 아이콘
				} else {
					if (version >= 338)
						setCategoryListIcon338(defineJson, os);//카테고리 리스트 아이콘
					else if (version >= 337)
						setCategoryListIcon(defineJson);//카테고리 리스트 아이콘
				}
				String[] siteNames = { "11st", "gmarket", "g9", "auction", "interpark", ".emart", "shinsegaemall", "ssg", "gsshop", "wemakeprice", "ticketmonster", "cjmall",
						"hyundaihmall", "akmall", "e-himart", "galleria", "okmall", ".nsmall.com", "homeplus", "lottemart", ".lotte.com", "lotteimall", "ellotte", "hnsmall",
						"coupang" };
				String[] schemes = { "reShould", "noUrl", "redirect", "f", "lpurl", "op", "reExt", "cno", "em", "popupUrl", "popupCloseUrl", "popupCloseFunction", "aLogin",
						"lurl", "lmtype" };
				JSONArray sites = new JSONArray();
				for (int i = 0; i < siteNames.length; i++) {
					String siteName = siteNames[i];

					if (/*siteName.equals("g9") ||*/
					siteName.equals("galleria") || siteName.equals("coupang") || siteName.equals("lottemart") /*|| siteName.equals(".nsmall.com")*/) {
						continue;
					}

					if (os.equals("ios") && version < 304) {
						if (siteName.equals(".lotte.com") || siteName.equals("ellotte")) {
							continue;
						}
					}

					JSONObject site = getSite(siteNames[i], schemes, version, appName, os);
					sites.put(site);
				}
				defineJson.put("SITES", sites);

			} else if (appName.equals("vaccine")) {
				setEnuriVaccineDefaultInfo(defineJson);

				String[] siteNames = { "auction", "gmarket", "11st", "coupang", "wemakeprice", "ticketmonster", "gsshop", "interpark", ".lotte.com", "cjmall", "ellotte", "ssg",
						"shinsegaemall", "hyundaihmall", "akmall", "lotteimall", "hnsmall", ".emart", "galleria", ".nsmall.com", "e-himart", "g9", "okmall", "homeplus",
						"lottemart" };

				JSONArray sites = new JSONArray();

				String[] schemes = { "id", "nic", "t", "p", "p2", "n", "m", "h", "info", "noUrl", "popupUrl" };
				for (int i = 0; i < siteNames.length; i++) {
					String siteName = siteNames[i];

					JSONObject site = getSite(siteNames[i], schemes, version, appName, os);
					sites.put(site);
				}
				defineJson.put("SITES", sites);
			} else if (appName.equals("social")) {
				setEnuriCoreDefaultInfo(defineJson); // 기본 정보 삽이

				String[] siteNames = { "11st", "gmarket", "g9", "auction", "interpark", ".emart", "shinsegaemall", "ssg", "gsshop", "wemakeprice", "ticketmonster", "cjmall",
						"hyundaihmall", "akmall", "e-himart", "galleria", "okmall", ".nsmall.com", "homeplus", "lottemart", ".lotte.com", "lotteimall", "ellotte", "hnsmall",
						"coupang" };

				String[] schemes = { "etc", "re", "reCoDomain", "ic", "noUrl", "icb", "redirect", "f", "lpurl", "op", "n", "reExt", "o", "cno", "l", "m", "j", "my", "h", "i", "t",
						"ld", "p", "p2", "lc", "em", "popupUrl", "popupCloseUrl", "popupCloseFunction", "aLogin", "lurl", "lmtype", "lcmsg" };

				JSONArray sites = new JSONArray();

				for (int i = 0; i < siteNames.length; i++) {
					String siteName = siteNames[i];

					if (/*siteName.equals("g9") || */siteName.equals("galleria") || siteName.equals("lottemart") || siteName.equals("coupang") /* || siteName.equals(".nsmall.com") */) {
						continue;
					}

					JSONObject site = getSite(siteNames[i], schemes, version, appName, os); // 사이트 이름으로 사이트 정보를 하나씩 가져와 site array에 append 한다.
					sites.put(site);
				}
				defineJson.put("SITES", sites); // 다 만들어진 site array를 SITES KEY에 defineJson에 넣는다. 
			}
		} catch (Exception e) {
		}

		return defineJson;
	}

	public void setCategoryListIcon338(JSONObject defaultDefineInfo, String os) {
		//enuri 3.3.8 버전 부터 적용
		try {
			JSONArray arr = new JSONArray();
			arr.put("icon_category_1_");
			arr.put("icon_category_2_");
			arr.put("icon_category_3_");
			arr.put("icon_category_4_");
			arr.put("icon_category_5_");
			arr.put("icon_category_6_");
			arr.put("icon_category_7_");
			arr.put("icon_category_8_");
			//arr.put("icon_category_7.png");
			defaultDefineInfo.put("CATEICONS", arr);
			if (os.equals("aos"))
				defaultDefineInfo.put("CATEICONS_PREURL", "http://img.enuri.info/images/mobilefirst/main/cate/aos/");
			else
				defaultDefineInfo.put("CATEICONS_PREURL", "http://img.enuri.info/images/mobilefirst/main/cate/ios/");
		} catch (Exception e) {
		}
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

	public int setHotDealInfo(JSONObject defaultDefineInfo) {
		try {
			JSONArray hotDeal = new JSONArray();

			String[] hotDealMalls = { "superdeal", "allkill", "shocking", "tmon", "coupang", "wemake" };
			String[] hotDealUrls = { "/http/json/superDeal.json", "/http/json/allKill.json", "/http/json/shocking.json", "/http/json/tmon.json", "/http/json/coupang.json",
					"/http/json/wemake.json" };
			String[] hotDealLogos = { "/20160617/20160617_hotdeal_superdeal.png", "/20160617/20160617_hotdeal_allkill.png", "/20160617/20160617_hotdeal_shocking.png",
					"/20160617/20160617_hotdeal_tmon.png", "/20160617/20160617_hotdeal_coupang.png", "/20160617/20160617_hotdeal_wemake.png" };
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

	public int setEnuriCoreDefaultInfo(JSONObject defaultDefineInfo) {
		String ifdomain = "enuri.com/mobilefirst";
		try {

			defaultDefineInfo.put("OUTLINKURL_IOS", "dev.enuri.com;m.enuri.com;dis.as.criteo.com;widerplanet.com");
			defaultDefineInfo.put("IF_ALL_MENU", ifdomain + "/layerMenu_ajax.jsp");
			defaultDefineInfo.put("IF_SOCIAL_URL", "enuri.com/deal/mobile/main.deal");
			defaultDefineInfo.put("IF_SOCIAL_DETAIL_URL", "enuri.com/deal/mobile/goods.deal");
			///////////////////////////////////

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
			defaultDefineInfo.put("ISP_SCHEME", "ispmobile://");//"?TID="); // 에누리 브라우저에서 ISP결제시 URL체크 IOS에서 사용
			defaultDefineInfo.put("IOS_LOGIN_LIMITE", "10"); // ajax로만 동작하는 쇼핑몰에서는 로그아웃을 확인하기가 힘듬, 따라서 타임아웃으로 결정함
			defaultDefineInfo.put("IOS_LOGOUT_LOGIN_INFO_DEL", "Y"); // IOS에서 로그아웃 할때 쇼핑몰들의 로그인 정보를 삭제할지를 결정하는 플래그 Y:삭제			
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
			defaultDefineInfo.put("NUFARI_INFO_DELAY", "10");//값 * 하루 .... 0보다 작으면 안띄움			

			//안드로이드 아이폰 3.0.4 버젼 부터 이머니 적용됨
			defaultDefineInfo.put("EMONEY_GUIDE", "Y");
			defaultDefineInfo.put("EMONEY_SHOW_IOS_FLAG", "Y"); // IOS 마이페이지에서 리워드정보를 보여줄지 

			defaultDefineInfo.put("EMONEY_STORE", "/mobilefirst/emoney/emoney_store.jsp");
			defaultDefineInfo.put("EMONEY_HISTORY", "/mobilefirst/emoney/emoney.jsp");
			defaultDefineInfo.put("EMONEY_DETAIL_INFO_SHOW", "Y");
			defaultDefineInfo.put("EMONEY_DETAIL_INFO_HIGHLIGHT", "e머니"); // 하이라이트 
			defaultDefineInfo.put("EMONEY_DETAIL_INFO_POINT_OK", "생활혜택 e머니를 받을 수 있습니다.;혜택받기 >"); // 로그인 > 적립가능 쇼핑몰
			defaultDefineInfo.put("EMONEY_DETAIL_INFO_POINT_NO", "생활혜택 e머니 적립 쇼핑몰이 아닙니다.;적립받기 >"); // 로그인 > 적립불가 쇼핑몰 
			defaultDefineInfo.put("EMONEY_DETAIL_INFO_LOGIN", "구매 후 생활혜택 e머니 적립받는 방법;자세히보기 >"); // 로그인 없이 쇼핑몰 접속 
			defaultDefineInfo.put("EMONEY_DETAIL_INFO_LINK", "http://m.enuri.com/mobilefirst/event2016/allpayback_201610.jsp?freetoken=event&app=Y"); // and 자세히 보기 링크
			defaultDefineInfo.put("ADULTCATE", "1640;");
			defaultDefineInfo.put("ENURILOGIN_SHOP_ICON_PREURL", "http://img.enuri.info/images/mobilefirst/browser/marketicon/");
		} catch (Exception e) {
		}

		return 0;
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

	public String getParam(String siteName, String scheme, int version, String appName, String os) {
		String param = null;
		JSONObject schemes = new JSONObject();
		if (scheme.equals("reShould")) { // iOS에서 souldstart에서 리워드를 체크해야 하는 경우. 
											// url에 2번째 Array의 값이 있는 경우 3번째 Array의 값으로 split를 한다.
											// 그런 후 마지막 값으로 Split 한 배열의 index를 가져 온다.
			try {
				//schemes.put("g9", "FROM_URL=-=Buy.htm#/Buy/PayComplete=-=#/Buy/PayComplete/=-=1");
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
				schemes.put("ticketmonster", "");
				schemes.put("cjmall", "");
				schemes.put("hyundaihmall", "");
				schemes.put("akmall", "");
				schemes.put("homeplus", "");
				schemes.put(".lotte.com", "/dacom/xansim/");
				schemes.put("lotteimall", "dis.as.criteo.com");
				schemes.put("ellotte", "dis.as.criteo.com");
				schemes.put("hnsmall", "");
			} catch (Exception e) {
			}
		} else if (scheme.equals("reLog")) { // 3.2.7에서 앱 리워드 로그 추가 획득 (아직 미정)
			try {
				//schemes.put("11st", "(function(){return $('.odr_tbl').not('.tour_end').find('tbody').eq(0).find('tr:eq(1)').html(); })()");//않ㄴ다 이것도 html 가져오는곳이랑 동일해서 의미 없다 
				schemes.put("auction", "(function() {return $('#form1 script')[0].text; })()");
				schemes.put("interpark", "(function(){return $('.paymentContentsWrap .orderNumber .detail').html();})()");
				//schemes.put("ticketmonster", "(function() {return $('.cmpl .order .num').text();})()"); //안한다 html 가져오는 곳이랑 동일하다 			

			} catch (Exception e) {
			}
		} else if (scheme.equals("lurl")) { // 잘 모르겠음, iOS는 3.0.6 이후로 사용하지 않음
			try {
				schemes.put("lotteimall", "");
				schemes.put("ellotte", "");
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
				schemes.put("ticketmonster", "https://=-=blank");
				schemes.put("cjmall", "blank");
				schemes.put("hyundaihmall", "https://=-=blank");
				schemes.put("akmall", "https://=-=blank");
				schemes.put("homeplus", "https://=-=blank");
				schemes.put(".lotte.com", "/login/logout.do=-=blank");
				schemes.put("lotteimall", "/member/goLogout.lotte=-=blank");
				schemes.put("ellotte", "/login/logout.do=-=blank");
				schemes.put("hnsmall", "https://=-=blank");
			} catch (Exception e) {
			}
		} else if (scheme.equals("aLogin")) { // ajax를 사용하는 로그인에서 타이머로 로그인 실패 체크, iOS는 3.0.6 이후로 사용하지 않음
			try {
				schemes.put("wemakeprice", "Y");
				schemes.put("cjmall", "Y");
			} catch (Exception e) {
			}
		} else if (scheme.equals("lmtype")) { // 잘 모르겠음, iOS는 3.0.6 이후로 사용하지 않음
			try {
				schemes.put("ellotte", "1-1-0-0");
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
				schemes.put("ticketmonster", "m/buy?selected_id");
				schemes.put("cjmall", "m/order/order.jsp?app_cd");
				schemes.put("hyundaihmall", "front/order.do");
				schemes.put("akmall", "order/delipaymentinpt.do");
				schemes.put("homeplus", "orderfulfilment/order/info.do");
				schemes.put(".lotte.com", "order/m/order_form.do");
				schemes.put("lotteimall", "order/searchordersheetlist.lotte");
				schemes.put("ellotte", "order/m/order_form.do");
				schemes.put("hnsmall", "order/input#init");
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
				schemes.put("ticketmonster", "");
				schemes.put("cjmall", "");
				schemes.put("hyundaihmall", "");
				schemes.put("akmall", "");
				schemes.put("homeplus", "");
				schemes.put(".lotte.com", "");
				schemes.put("lotteimall", "");
				schemes.put("ellotte", "");
				schemes.put("hnsmall", "");
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
		} else if (scheme.equals("popupCloseFunction")) {// iOS의 팝업을 닫을 때 호출 할 javascript 함수
			try {
				schemes.put("interpark", "setDelvInfo()");
				schemes.put(".nsmall.com", "window.opener.paymentSuccessWeb(getBroadCastParam())");
			} catch (Exception e) {
			}
		} else if (scheme.equals("noUrl")) { // iOS에서 무시해야 할 URL, iOS는 3.0.6 이후로 사용하지 않음
			try {
				schemes.put("11st", "/a.st?url");
			} catch (Exception e) {
			}
		} else if (scheme.equals("captcha")) {
			try {
				schemes.put("wemakeprice",
						"(function(){var captch = $('captch_img img').attr('src');if(captch == null || captch.length ==0)return '';else  return 'http://m.wemakeprice.com'+captch})()");
			} catch (Exception e) {
			}
		} else if (scheme.equals("nic")) { // 안드로이드 아이콘, iOS는 icb가 없으면 이 아이콘을 가져 온다.
			try {
				schemes.put("11st", "app_icon_11st_0714");
				schemes.put("gmarket", "app_icon_gmarket");
				schemes.put("g9", "");
				schemes.put("auction", "app_icon_auction_new");
				schemes.put("interpark", "app_icon_interpark");
				schemes.put(".emart", "app_icon_emart");
				schemes.put("shinsegaemall", "app_icon_shinsegaemall");
				schemes.put("ssg", "app_icon_ssg");
				schemes.put("gsshop", "app_icon_gsshop");
				schemes.put("wemakeprice", "app_icon_wemakeprice20170330");
				schemes.put("ticketmonster", "app_icon_ticketmonster");
				schemes.put("cjmall", "app_icon_cjmall");
				schemes.put("hyundaihmall", "app_icon_hmall");
				schemes.put("akmall", "app_icon_akmall");
				schemes.put("e-himart", "");
				schemes.put("galleria", "app_icon_galleria");
				schemes.put("okmall", "");
				schemes.put(".nsmall.com", "app_icon_nsshopping");
				schemes.put("homeplus", "");
				schemes.put("lottemart", "app_icon_lottemart");
				schemes.put(".lotte.com", "app_icon_lottecom_20180124");
				schemes.put("lotteimall", "");
				schemes.put("ellotte", "app_icon_ellotte_new");
				schemes.put("hnsmall", "app_icon_homenshopping");
				schemes.put("coupang", "app_icon_coupang");
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
				schemes.put("wemakeprice", "[{\"t\":\"e\",\"url\":\"http://m.wemakeprice.com/m/\"}]");
				schemes.put("ticketmonster", "[{\"t\":\"e\",\"url\":\"http://m.ticketmonster.co.kr/\"}]");
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
			} catch (Exception e) {
			}
		} else if (scheme.equals("f")) { // 로그인 마지막 페이지에서 떨어지는결과
			try {
				schemes.put("11st", "");
				schemes.put("gmarket", "");
				schemes.put("g9", "");
				schemes.put("auction", "");
				schemes.put("interpark", "");
				schemes.put(".emart", "");
				schemes.put("shinsegaemall", "");
				schemes.put("ssg", "");
				schemes.put("gsshop", "");
				schemes.put("wemakeprice", "");
				schemes.put("ticketmonster", "");
				schemes.put("cjmall", "");
				schemes.put("hyundaihmall", "");
				schemes.put("akmall", "");
				schemes.put("e-himart", "");
				schemes.put("galleria", "");
				schemes.put("okmall", "");
				schemes.put(".nsmall.com", "");
				schemes.put("homeplus", "");
				schemes.put("lottemart", "");
				schemes.put(".lotte.com", "");
				schemes.put("lotteimall", "");
				schemes.put("ellotte", "");
				schemes.put("hnsmall", "");
				schemes.put("coupang", "");
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
				schemes.put("ticketmonster", "");
				schemes.put("cjmall", "");
				schemes.put("hyundaihmall", "");
				schemes.put("akmall", "");
				schemes.put("homeplus", "");
				schemes.put(".lotte.com", "http://m.lotte.com/login/logout.do");
				schemes.put("lotteimall", "https://securem.lotteimall.com/member/goLogout.lotte");
				schemes.put("ellotte", "http://m.ellotte.com/login/logout.do");
				schemes.put("hnsmall", "");
			} catch (Exception e) {
			}
		} else if (scheme.equals("id")) { // 쇼핑몰 id, 안드로이드 가격백신에서 사용
			try {
				schemes.put("11st", 1);
				schemes.put("gmarket", 2);
				schemes.put("g9", 3);
				schemes.put("auction", 4);
				schemes.put("interpark", 5);
				schemes.put(".emart", 6);
				schemes.put("shinsegaemall", 7);
				schemes.put("ssg", 8);
				schemes.put("gsshop", 9);
				schemes.put("wemakeprice", 10);
				schemes.put("ticketmonster", 11);
				schemes.put("cjmall", 12);
				schemes.put("hyundaihmall", 13);
				schemes.put("akmall", 14);
				schemes.put("e-himart", 15);
				schemes.put("galleria", 16);
				schemes.put("okmall", 17);
				schemes.put(".nsmall.com", 18);
				schemes.put("homeplus", 19);
				schemes.put("lottemart", 20);
				schemes.put(".lotte.com", 21);
				schemes.put("lotteimall", 22);
				schemes.put("ellotte", 23);
				schemes.put("hnsmall", 24);
				schemes.put("coupang", 25);
			} catch (Exception e) {
			}
		} else if (scheme.equals("info")) { //	vip에서 가격과 제목을 가져옴
			try {
				schemes.put(
						"11st",
						"(function(){return $('.dtl_tit').text().trim()+\"EnuRi\"+$('link[rel=\"image_src\"]').attr('href')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.dtl_total .prc b').text();})()");
				schemes.put("gmarket",
						"(function(){return $('title').text()+\"EnuRi\"+$('meta[property=\"og:image\"]').attr('content')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.pri1').text();})()");
				schemes.put(
						"g9",
						"(function(){return $('.info_area .prod_cont .info_box .tit2').text()+\"EnuRi\"+$('.item_bnr .thmb img').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.info_area .price').text();})()");
				schemes.put(
						"auction",
						"(function(){return $('.title span').text()+\"EnuRi\"+ $('.content-slider').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.elements_info .price .ng-scope strong').text();})()");
				schemes.put(
						"interpark",
						"(function(){return $('#sub_title').text()+\"EnuRi\"+$('.slide').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+ $('.discountedPrice .numeric').text()+'원';})()");
				schemes.put(
						".emart",
						"(function(){return $('.article-title h3').text()+\"EnuRi\"+$('.flick-ct').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.article-title .sale').text().trim();})()");
				schemes.put("shinsegaemall",
						"(function(){return $('.txt01 em').text()+\"EnuRi\"+$('.flick-ct').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.pr_area .price').text();})()");
				schemes.put(
						"ssg",
						"(function(){return $('.mallprd_info h3').text().trim().replaceAll('\t','')+\"EnuRi\"+$('.flick-ct').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.price_area strong').text().trim();})()");
				schemes.put(
						"gsshop",
						"(function(){return $('.prdNames').text()+\"EnuRi\"+$('.swiper-slide-active').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.infoPrice strong ').text()+'원';})()");
				schemes.put("wemakeprice",
						"(function(){return $('.info-area #main_name').text()+\"EnuRi\"+$('#img_app_onecut').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.price_area .sale').text();})()");
				schemes.put("ticketmonster",
						"(function(){return $('.info h2').text()+\"EnuRi\"+$('.deal_summary').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.pr .dc').text();})()");
				schemes.put(
						"cjmall",
						"(function(){  var a =$('.flick-container').find('img:eq(0)').attr('src'); if(a.indexOf('?')!=-1) a= a.substring(0,a.indexOf('?')); if(a.indexOf('http:')==-1)a='http:'+a;return $('.prd_info h1').text().trim()+\"EnuRi\"+a+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.prd_price .price strong').text()+'원';})()");
				schemes.put("hyundaihmall",
						"(function(){return $('.title1 h2').text()+\"EnuRi\"+$('#detailPageImgSlide .selected img').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.price1').text();})()");
				schemes.put(
						"akmall",
						"(function(){return $('.info_top h2').text().trim()+\"EnuRi\"+'http:'+$('.swiper-wrapper').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.discount').text();})()");
				schemes.put(
						"galleria",
						"(function(){var a = $('.pri'); if(a.length>1) a=a.eq(1).text();else a=a.text();return $('.dt_pr .dt_pr_tx strong').text()+' '+$('.dt_pr .dt_pr_tx .min').text()+\"EnuRi\"+$('#dtSwipeList img').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+a.replace('₩','');})()");
				schemes.put(
						".nsmall.com",
						"(function(){return $('.test #productName').text()+\"EnuRi\"+$('.swipe_bannerArea.goods_thumbnailArea').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('#txtOfferPriceIns').text();})()");
				schemes.put(
						"homeplus",
						"(function(){return $('.discount').text() +' '+$('.heading h2').text()+\"EnuRi\"+$('.flex-active-slide').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.value1').text();})()");
				schemes.put(
						"lottemart",
						"(function(){return $('.goodstitle').text()+\"EnuRi\"+$('.swiper-wrapper').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('#ItemCurrSalePrc').text()+'원';})()");
				schemes.put(".lotte.com",
						"(function(){return $('.titText').text()+\"EnuRi\"+$('.dSwipeImg').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.titPrice').text().trim();})()");
				schemes.put(
						"lotteimall",
						"(function(){return $('#goodsNm').text()+\"EnuRi\"+$('.prodCont.clfix').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.price.dc_price .big').text();})()");
				schemes.put("ellotte",
						"(function(){return $('.titText').text()+\"EnuRi\"+$('.dSwipeImg').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.titPrice').text().trim();})()");
				schemes.put(
						"hnsmall",
						"(function(){return $('h2.tit').text().trim()+\"EnuRi\"+$('.pd_img.bxslider').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('strong.priceRed').text()+'원';})()");
				schemes.put(
						"coupang",
						"(function(){if($('#totalSalesPrice').val()!=null)return $('.title').eq(0).text()+\"EnuRi\"+$('#pdpImages').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('#totalSalesPrice').text();else return $('.clearfix dt').text()+\"EnuRi\"+$('.detail-main').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.detail-main-info  .clearfix .sale-price').text();})()");
			} catch (Exception e) {
			}
		}

		try {
			param = schemes.get(siteName).toString();
		} catch (Exception e) {
		}

		return param;
	}

	public JSONObject getSite(String siteName, String[] schemes, int version, String appName, String os) {
		JSONObject site = new JSONObject();

		try {
			site.put("n", siteName);

			for (int i = 0; i < schemes.length; i++) {
				String param = getParam(siteName, schemes[i], version, appName, os);

				if (param != null) {
					try {
						int intParam = Integer.parseInt(param);
						site.put(schemes[i], intParam);
					} catch (Exception e) {
						site.put(schemes[i], param);
					}
				}
			}

		} catch (Exception e) {
		}

		return site;
	}

	public JSONObject getJSONObjectInJSONArray(JSONArray arr, String shopname) {
		try {
			for (int i = 0; i < arr.length(); i++) {
				if (arr.getJSONObject(i).getString("n").equals(shopname))
					return arr.getJSONObject(i);
			}
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
			//urlcon.setConnectTimeout(10000);
			InputStream inputStream = urlcon.getInputStream();

			ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
			byte[] arBytes = null;
			byte[] readByte = new byte[1024];
			int readLen;
			while ((readLen = inputStream.read(readByte)) != -1) {
				outputStream.write(readByte, 0, readLen);
			}
			arBytes = outputStream.toByteArray();
			outputStream.close();
			inputStream.close();

			return new JSONObject(new String(arBytes, "utf-8"));
		} catch (Exception e) {

		}
		return null;
	}

	int Hex_IDINPUT = 0X00000000;
	int Hex_EMAILINPUT = 0X00010000;

	int Hex_LOGINDELAY_1 = 0X0000003c;
	int Hex_LOGINDELAY_3 = 0X000000b4;
	int Hex_LOGINDELAY_2 = 0X00000078;
	int Hex_LOGINDELAY_6 = 0X00000168;
	int Hex_LOGINDELAY_12 = 0X000002d0;%>