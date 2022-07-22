<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.json.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.enuri.util.common.ChkNull"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%
	request.setCharacterEncoding("UTF-8");
	String ver = ChkNull.chkStr(request.getParameter("ver"), "0.0.0");
	String appName = ChkNull.chkStr(request.getParameter("app"), "enuri");
	String os = ChkNull.chkStr(request.getParameter("os"), "");
	boolean isDev = request.getServerName().contains("dev.enuri.com");

	if (ver == null)
		ver = "0.0.0";

	int version = 0;
	if (ver.length() >= 5) {
		try {
			version = Integer.parseInt(ver.substring(0, 1)) * 100 + Integer.parseInt(ver.substring(2, 3)) * 10 + Integer.parseInt(ver.substring(4, 5));
		} catch (Exception e) {
		}
	}

	if (appName == null) {
		appName = "enuri";
	}

	if (os.indexOf("aos") <= -1 && os.indexOf("ios") <= -1) {
		if (ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1) {
			os = "aos";
		} else {
			os = "ios";
		}
	}
	if(!(os.indexOf("aos")>-1 || os.indexOf("ios")>-1))
	{
		out.print(os);
		return;
	}



	JSONObject defineJson = new JSONObject();

	defineJson.put("andDefineList", getDefineJson(appName, version, os, isDev));

	out.print(defineJson);
%>

<%!int Hex_IDINPUT = 0X00000000;
	int Hex_EMAILINPUT = 0X00010000;

	int Hex_LOGINDELAY_1 = 0X0000003c;
	int Hex_LOGINDELAY_3 = 0X000000b4;
	int Hex_LOGINDELAY_2 = 0X00000078;
	int Hex_LOGINDELAY_6 = 0X00000168;
	int Hex_LOGINDELAY_12 = 0X000002d0;

	public JSONObject getDefineJson(String appName, int version, String os, boolean isDev) {
		JSONObject defineJson = new JSONObject();

		try {
			defineJson.put("FOOTER_TITLE", "법적고지");
			defineJson
					.put("FOOTER",
							((!(appName.equals("enuri") && version >= 341)) ? "\n" : "")
									+ "㈜써머스플랫폼은 통신판매 정보제공자로서 통신판매의 거래당사자가 아니며, 상품의 주문/배송/환불에 대한 의무와 책임은 각 쇼핑몰(판매자)에게 있습니다.\n\n㈜써머스플랫폼\n대표이사 : 김기범 |사업자등록번호 : 206-81-18164\n통신판매신고 : 2015-서울중구-1046호\n서울시 중구 퇴계로 18(남대문로5가) 9층\n문의 : 02-6354-3601|master@enuri.com\n");

			Date date = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");

			defineJson.put("version", formatter.format(date));
			if (appName.equals("enuri")) {
				setEnuriCoreDefaultInfo(defineJson,version); // 기본 정보 삽이
				setCardInfo(defineJson); // 카드 정보 삽입
				setHotDealInfo(defineJson); // 핫딜 정보 삽입
				setMcronyAD(defineJson); //엠크로니 광고 삽입
				setSchemePass(defineJson);//아이폰 스킴 패스
				if (version >= 341)
					setCateListBottomIcon(defineJson, isDev);
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
				// 				setSchemePass(defineJson);

				String[] siteNames = { "11st", "gmarket", "g9", "auction", "interpark", ".emart", "shinsegaemall", "ssg", "gsshop", "wemakeprice", "tmon", "ticketmonster",
						"cjmall", "hyundaihmall", "akmall", "e-himart", "galleria", "okmall", ".nsmall.com", "homeplus", "lottemart", ".lotte.com", "lotteimall", "ellotte",
						"hnsmall", "coupang" };

				String[] schemes = { "etc", "re", "reCallPercent", "iosReCallPercent", "reLink", "reBypass", "renot", "reCoDomain", "reShould", "ic", "noUrl", "icb", "redirect",
						"f", "lpurl", "op", "n", "reExt", "o", "cno", "l", "m", "j", "my", "h", "i", "t", "ld", "p", "p2", "lc", "em", "popupUrl", "popupCloseUrl",
						"popupCloseFunction", "aLogin", "lurl", "lmtype", "lcmsg", "shopCode", "lhtml", "hbridge" };

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

					JSONObject site = getSite(siteNames[i], schemes, version, appName, os, isDev);
					sites.put(site);
				}
				defineJson.put("SITES", sites);

			} else if (appName.equals("vaccine")) {
				setEnuriVaccineDefaultInfo(defineJson);
				setCardInfo(defineJson);

				String[] siteNames = { "auction", "gmarket", "11st", "coupang", "wemakeprice", "tmon", "gsshop", "interpark", ".lotte.com", "cjmall", "ellotte", "ssg",
						"shinsegaemall", "hyundaihmall", "akmall", "lotteimall", "hnsmall", ".emart", "galleria", ".nsmall.com", "e-himart", "g9", "okmall", "homeplus",
						"lottemart" };

				JSONArray sites = new JSONArray();

				String[] schemes = { "id", "nic", "t", "p", "p2", "n", "m", "h", "info", "noUrl", "popupUrl" };
				for (int i = 0; i < siteNames.length; i++) {
					String siteName = siteNames[i];

					JSONObject site = getSite(siteNames[i], schemes, version, appName, os, isDev);
					sites.put(site);
				}
				defineJson.put("SITES", sites);
			} else if (appName.equals("social")) {
				setSocialDefaultInfo(defineJson); // 기본 정보 삽이
				setCardInfo(defineJson); // 카드 정보 삽입

				setSchemePass(defineJson);//아이폰 스킴 패스
				String[] siteNames = { "11st", "gmarket", "g9", "auction", "interpark", ".emart", "shinsegaemall", "ssg", "gsshop", "wemakeprice", "tmon", "cjmall",
						"hyundaihmall", "akmall", "e-himart", "galleria", "okmall", ".nsmall.com", "homeplus", "lottemart", ".lotte.com", "lotteimall", "ellotte", "hnsmall",
						"coupang" };

                String[] schemes = { "etc", "re", "reCoDomain", "ic", "noUrl", "icb", "redirect", "f", "lpurl", "op", "n", "reExt", "o", "cno", "l", "m", "j", "my", "h", "i", "t",
                        "ld", "p", "p2", "lc", "em", "popupUrl", "popupCloseUrl", "popupCloseFunction", "aLogin", "lurl", "lmtype", "lcmsg", "lhtml" };

				JSONArray sites = new JSONArray();

				for (int i = 0; i < siteNames.length; i++) {
					String siteName = siteNames[i];

					if (/*siteName.equals("g9") || */
					siteName.equals("galleria") || siteName.equals("lottemart") || siteName.equals("coupang") /* || siteName.equals(".nsmall.com") */) {
						continue;
					}

					JSONObject site = getSite(siteNames[i], schemes, version, appName, os, isDev); // 사이트 이름으로 사이트 정보를 하나씩 가져와 site array에 append 한다.
					sites.put(site);
				}
				defineJson.put("SITES", sites); // 다 만들어진 site array를 SITES KEY에 defineJson에 넣는다.
			}
		} catch (Exception e) {
		}

		return defineJson;
	}

	public void setCateListBottomIcon(JSONObject defaultDefineInfo, boolean isDev) {
		//enuri 3.4.1 버전 부터 적용
		try {

			String link[] = { "http://m.enuri.com/mobiledepart/Index.jsp?freetoken=department&app=Y", "http://m.enuri.com/knowcom/index.jsp?freetoken=shoppingknow&app=Y",

			"http://m.enuri.com/deal/newdeal/index.deal?freetoken=social&app=Y", "http://m.flower365.com/category/cate_list.php?freetoken=outlink",
					"http://menuri.insvalley.com/mini/minsvalley.jsp?freetoken=outlink" };
			String keyword[] = { "백화점 가격비교", "쇼핑지식", "소셜비교", "꽃배달", "보험" };

			String icon[] = { "http://img.enuri.info/images/mobilefirst/main/cate/aos/nonecate/btn_category_store.png",
					"http://img.enuri.info/images/mobilefirst/main/cate/aos/nonecate/btn_category_shopping.png",
					"http://img.enuri.info/images/mobilefirst/main/cate/aos/nonecate/btn_category_social.png",
					"http://img.enuri.info/images/mobilefirst/main/cate/aos/nonecate/btn_category_flower.png",
					"http://img.enuri.info/images/mobilefirst/main/cate/aos/nonecate/btn_category_insurance.png" };
			JSONArray arr = new JSONArray();
			for (int i = 0; i < keyword.length; i++) {
				if ( keyword[i].equals("백화점 가격비교")|| keyword[i].equals("보험"))
					continue;
				JSONObject obj = new JSONObject();
				obj.put("key", keyword[i]);
				obj.put("link", link[i]);
				obj.put("icon", icon[i]);
				arr.put(obj);
			}

			//arr.put("icon_category_7.png");
			defaultDefineInfo.put("CATEBOTTOMICON", arr);

		} catch (Exception e) {
		}
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

	public void setMcronyAD(JSONObject defaultDefineInfo) {
		//m크로니 관련 링크 정의
		try {

			//lp top ad
			defaultDefineInfo.put("AD_LPTOP", "http://adsvc.enuri.mcrony.com/enuri_M/m_lp/M3/bundle?bundlenum=3&cate=");
			//footer ad
			defaultDefineInfo.put("AD_FOOTER", "http://adsvc.enuri.mcrony.com/enuri_M/m_all/W2/bundle?bundlenum=3");

			defaultDefineInfo.put("AD_HOME_FLOATING", "http://adsvc.enuri.mcrony.com/enuri_M/m_main/FA/bundle?bundlenum=2");
			//dim crm ad
			defaultDefineInfo.put("AD_CRM", "/api/eventAppCRM.jsp");

			defaultDefineInfo.put("AD_SHOPPINGNEWS", "http://ad-api.enuri.info/enuri_M/m_know/KA1/bundle?bundlenum=3");
			defaultDefineInfo.put("AD_SHOPPINGTIP", "http://ad-api.enuri.info/enuri_M/m_know/KA2/bundle?bundlenum=3");
			defaultDefineInfo.put("AD_TRANDWEBZINE", "http://ad-api.enuri.info/enuri_M/m_know/KA3/bundle?bundlenum=3");

			defaultDefineInfo.put("AD_LP_CENTER", "http://adsvc.enuri.mcrony.com/enuri_M/m_lp/M31/bundle?bundlenum=3&cate=");
			defaultDefineInfo.put("AD_SRP_TOP", "http://adsvc.enuri.mcrony.com/enuri_M/m_srp/MS1/bundle?bundlenum=3");


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

	public int setSchemePass(JSONObject defaultDefineInfo) {
		try {

			JSONArray arrMallData = new JSONArray();
			arrMallData.put("http://");
			arrMallData.put("https://");
			arrMallData.put("appcall://");
			arrMallData.put("appcall:");
			arrMallData.put("enuriappcall://");
			arrMallData.put("close://");
			arrMallData.put("ispmobile://");
			defaultDefineInfo.put("schemepass", arrMallData);

			defaultDefineInfo.put("instapass", "www.instagram.com;/embed/captioned/");

		} catch (Exception e) {
		}

		return 0;
	}

	public int setEnuriCoreDefaultInfo(JSONObject defaultDefineInfo,int version) {
		String ifdomain = "enuri.com/mobilefirst";
		try {

			defaultDefineInfo.put("NewsBoxListDesc", "수신일로부터 30일이 지난 메시지는 자동으로 삭제됩니다.");
			defaultDefineInfo.put("PersonalMessageListdesc", "최저가는 수시로 변경되므로, 즉시 방문하시는 것이 좋습니다.\n수신일로부터 30일이 지난 메시지는 자동으로 삭제됩니다.");
			StringBuffer sb = new StringBuffer();
			sb.append("enuri.com/mobilefirst;");
			sb.append("http://enuri.sweettracker.net;");
			sb.append("enuri.com/deal/mobile/;");
			sb.append("enuri.com/deal/newdeal/;");
			sb.append("/mobiledepart;");
			sb.append("enuri.com/mobilenew;");
			sb.append("enuri.com/move/;");
			sb.append("enuri.com/event;");
			sb.append("enuri.com/knowcom;");
			sb.append("https://nice.checkplus.co.kr;");
			if(version>=350)//3.5.0 도메인 개편 3세대 버전에서 vip 도메인이 바뀜
				sb.append("enuri.com/m/;");
			sb.append("100.100.100.234");
			defaultDefineInfo
					.put("OUTLINKURL",sb.toString());



			defaultDefineInfo.put("OUTLINKURL_IOS", "dev.enuri.com;m.enuri.com;dis.as.criteo.com;widerplanet.com");
			defaultDefineInfo.put("IF_DOMAIN", ifdomain);
			defaultDefineInfo.put("IF_ALL_MENU", ifdomain + "/layerMenu_ajax.jsp");
			defaultDefineInfo.put("IF_MAIN_URL2", "enuri.com/mobilefirst/Index.jsp");
			defaultDefineInfo.put("IF_BIG_IMAGE_URL", "enuri.com/mobilefirst/detailBigImage.jsp");

			defaultDefineInfo.put("IF_LOGIN_URL", ifdomain + "/login/");
			defaultDefineInfo.put("IF_LOGIN_URL2", "enuri.com/mobilenew/login/");
			defaultDefineInfo.put("IF_LOGIN_URL3", "enuri.com/member/login/");

			//3.2.8 버전 ANDROID 사용하지 않음
			defaultDefineInfo.put("IF_SOCIAL_URL", "enuri.com/deal/mobile/main.deal");
			defaultDefineInfo.put("IF_SOCIAL_DETAIL_URL", "enuri.com/deal/mobile/goods.deal");
			///////////////////////////////////
			defaultDefineInfo.put("IF_DEPARTMENT_LINK", "enuri.com/mobiledepart/Index.jsp");
			defaultDefineInfo.put("IF_DEPARTMENT_DETAILPAGE", "enuri.com/mobiledepart/detail.jsp");
			defaultDefineInfo.put("IF_DETAIL_URL", "enuri.com/mobilefirst/detail.jsp?modelno=");
			defaultDefineInfo.put("IF_DETAIL_URL_3G", "enuri.com/m/vip.jsp?modelno=");
			defaultDefineInfo.put("IF_ETC_URL", "enuri.com/mobilefirst/event/eventWonList.jsp;enuri.com/mobilefirst/event/eventWonView.jsp");
			defaultDefineInfo.put("IF_LIST_URL", "enuri.com/mobilefirst/list.jsp");
			defaultDefineInfo.put("IF_SEARCH_URL", "enuri.com/mobilefirst/search.jsp");
			defaultDefineInfo.put("IF_NICE", "https://nice.checkplus.co.kr");
			defaultDefineInfo.put("IF_NEWS_DETAIL", "enuri.com/mobilefirst/news_detail.jsp");
			defaultDefineInfo.put("IF_EVENT_DETAIL", "enuri.com/mobilefirst/event/");
			defaultDefineInfo.put("IF_EVENT_DETAIL2", "enuri.com/mobilefirst/evt/");
			defaultDefineInfo.put("IF_EVENT_GO", "enurievent=Y");

			defaultDefineInfo.put("ISP_INFO_CLOSE", "N");

			defaultDefineInfo.put("GO_INTENT", "androidgo");
			defaultDefineInfo.put("GO_CLOSE", "close://");
			defaultDefineInfo.put("GO_SHARE", "shareintent://");
			defaultDefineInfo.put("GO_EVENTDETAIL_KEYWORD", "eventdetailurl://");
			defaultDefineInfo.put("INTENT_PROTOCOL_START", "intent:");
			defaultDefineInfo.put("INTENT_PROTOCOL_INTENT", "#Intent;");
			defaultDefineInfo.put("INTENT_PROTOCOL_EN", ";end;");
			defaultDefineInfo.put("GOOGLE_PLAY_STORE_PREFIX", "market://details?id=");
			defaultDefineInfo.put("SHARE_TEXT", "sharetext:");
			defaultDefineInfo.put("SHARE_TEXT_TITLE", "공유");
			defaultDefineInfo.put("SHARE_TYPE", "text/plain");

			defaultDefineInfo.put("SWEETTRACKER_PACKAGE", "com.sweettracker.smartparcel");
			defaultDefineInfo.put("SWEETTRACKER_MARKET", "market://details?id=com.sweettracker.smartparcel");
			defaultDefineInfo.put("ZZIM_LIST_SPLIT", "ENURI");
			defaultDefineInfo.put("DETAIL_VIEWPORT", "");
			defaultDefineInfo.put("CATEGORY_MISE_ICON", "@");
			defaultDefineInfo.put("ENURI_GATE", "freetoken");
			defaultDefineInfo.put("ENURI_GETMOBILE", "enuri.com/mobilefirst/move.jsp");
			//defaultDefineInfo.put("ENURI_GETMOBILE", "100.234/mobilefirst/move.jsp");

			defaultDefineInfo.put("VIP_BACK", "N");
			defaultDefineInfo.put("LP_BACK", "Y");
			defaultDefineInfo.put("BROWSER_OUT", "http&https&intent&enuri&eventdetailurl&shareintent");
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
					.put("COMFAIL",
							"자동로그인&자동 로그인&아이디 찾기&비밀번호가 일치하지&아이디 저장&로그인 상태 유지&아이디 저장&자동로그인 설정&http%3A%2F%2Fmember.auction.co.kr%2FAuthenticate%2F%3Freturn_value%3D-1&loginResult('01'&\"success\":false&\"LoginResultEnum\":3&\"LoginResultEnum\":2");//에누리 브라우져 사용 여부
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

			// 마이페이지 인증 배너 시작 날짜
			defaultDefineInfo.put("MYPAGE_CERTIFY_SHOW_BANNER_DATE", "20170327000000");
			defaultDefineInfo.put("MYPAGE_CERTIFY_SHOW_BANNER_BGCOLOR", "FFF4D7");
			defaultDefineInfo.put("MYPAGE_CERTIFY_SHOW_BANNER_IMAGE", "http://img.enuri.info/images/mobilefirst/appImage/mypage/mypage_banner_wemake.png");
			defaultDefineInfo.put("MYPAGE_CERTIFY_SHOW_BANNER_LINK", "http://m.enuri.com/mobilefirst/http/emoney_benefit.jsp?freetoken=event");
			//마이페이지 쿠폰샵 배너
			defaultDefineInfo.put("MYPAGE_COUPONSHOP_BANNER_IMAGE", "http://img.enuri.info/images/mobilefirst/appImage/mypage/ban_emoney_shop.png");
			defaultDefineInfo.put("MYPAGE_COUPONSHOP_BANNER_BGCOLOR", "CCE9FF");
            defaultDefineInfo.put("MYPAGE_COUPONSHOP_BANNER_LINK", "");
            //마이페이지 2019 운영 배너
            defaultDefineInfo.put("MYPAGE_SHOW_BANNER_SHOW_YN", "Y");
            defaultDefineInfo.put("MYPAGE_SHOW_BANNER_BGCOLOR", "#CCE9FF");
            defaultDefineInfo.put("MYPAGE_SHOW_BANNER_IMAGE", "http://img.enuri.info/images/mobilefirst/appImage/mypage/mypage_banner.png");
            defaultDefineInfo.put("MYPAGE_SHOW_BANNER_LINK", "http://m.enuri.com/mobilefirst/http/emoney_benefit.jsp?freetoken=event");

			defaultDefineInfo.put("CPC_JOIN_LINK", "https://ad.esmplus.com");
			defaultDefineInfo.put("TRENDWEBZINE_IMAGE_ORIGINAL", "N");

			//ios에서도 적용 필수 3.3.8 버전 부터 적용
			defaultDefineInfo.put("ERROR_LOG_OVERVERSION", "337"); //에러로그 전송 가능 버전은 3.3.8 이상인 버전 전송함
			defaultDefineInfo.put("ERROR_LOG_STOPWORKVERSION", "337");//337;340ERROR_LOG_OVERVERSION에 포함되지만 특별히 제외버전

			defaultDefineInfo.put("ENURILOGIN_SHOP_ICON_PREURL", "http://img.enuri.info/images/mobilefirst/browser/marketicon/");

			defaultDefineInfo.put("APPSTORE_REVIEW_DATA", "3=-=180");//3번째 6개월에 한번씩 //0=-=0이면 무시한다
		} catch (Exception e) {
		}

		return 0;
	}

	public int setSocialDefaultInfo(JSONObject defaultDefineInfo) {
		String ifdomain = "enuri.com/deal";
		try {

			defaultDefineInfo.put("NewsBoxListDesc", "수신일로부터 30일이 지난 메시지는 자동으로 삭제됩니다.");
			defaultDefineInfo.put("PersonalMessageListdesc", "최저가는 수시로 변경되므로, 즉시 방문하시는 것이 좋습니다.\n수신일로부터 30일이 지난 메시지는 자동으로 삭제됩니다.");
			defaultDefineInfo
					.put("OUTLINKURL",
							"enuri.com/mobilefirst;http://enuri.sweettracker.net;enuri.com/deal/mobile/;enuri.com/deal/newdeal/;/mobiledepart;enuri.com/mobilenew;enuri.com/move/;enuri.com/event;enuri.com/knowcom;https://nice.checkplus.co.kr;100.100.100.234");

			defaultDefineInfo.put("OUTLINKURL_IOS", "dev.enuri.com;m.enuri.com;dis.as.criteo.com;widerplanet.com");
			defaultDefineInfo.put("IF_DOMAIN", ifdomain);
			defaultDefineInfo.put("IF_MAIN_URL", ifdomain + "/newdeal/index.deal");
			defaultDefineInfo.put("IF_BIG_IMAGE_URL", "enuri.com/mobilefirst/detailBigImage.jsp");

			defaultDefineInfo.put("IF_LOGIN_URL", ifdomain + "/login/");
			defaultDefineInfo.put("IF_LOGIN_URL2", "enuri.com/mobilenew/login/");
			defaultDefineInfo.put("IF_LOGIN_URL3", "enuri.com/member/login/");

			defaultDefineInfo.put("GO_INTENT", "androidgo");
			defaultDefineInfo.put("GO_CLOSE", "close://");
			defaultDefineInfo.put("GO_SHARE", "shareintent://");
			defaultDefineInfo.put("INTENT_PROTOCOL_START", "intent:");
			defaultDefineInfo.put("INTENT_PROTOCOL_INTENT", "#Intent;");
			defaultDefineInfo.put("INTENT_PROTOCOL_EN", ";end;");
			defaultDefineInfo.put("SHARE_TEXT", "sharetext:");
			defaultDefineInfo.put("SHARE_TEXT_TITLE", "공유");
			defaultDefineInfo.put("SHARE_TYPE", "text/plain");

			defaultDefineInfo.put("DETAIL_VIEWPORT", "");
			defaultDefineInfo.put("ENURI_GATE", "freetoken");
			defaultDefineInfo.put("ENURI_GETMOBILE", "enuri.com/mobilefirst/move.jsp");
			//defaultDefineInfo.put("ENURI_GETMOBILE", "100.234/mobilefirst/move.jsp");

			defaultDefineInfo.put("VIP_BACK", "N");
			defaultDefineInfo.put("LP_BACK", "Y");
			defaultDefineInfo.put("BROWSER_OUT", "http&https&intent&enuri&eventdetailurl&shareintent");
			defaultDefineInfo.put("REVIEW_SIZE", "100");

			// IOS에서 쿠키를 찾기 위해 사용하는 문자열
			// 쿠키를 원데이터로 읽으면 name, value가 서로 분리되어있는데 합쳐서 검색이 편하도록 하기 위해
			defaultDefineInfo.put("IOS_COOKIE_FIND_STR1", "\" value:\"");
			defaultDefineInfo.put("IOS_COOKIE_FIND_STR2", " value:\"=-=\" "); // 쿠키의 value값을 찾는 정규식
			defaultDefineInfo.put("ICONURL", "http://img.enuri.info/images/mobilefirst/browser/marketicon/");

			defaultDefineInfo.put("CPC_JOIN_LINK", "https://ad.esmplus.com");

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

	public int setCardInfo(JSONObject defineInfo) {
		String[] cardDataList = { "hdcard", "mpocket", "lotte", "smshin", "kb-acp", "hanaansim", "shinhan-sr", "ispmobile" };
		String[] m = { "market://details?id=com.hyundaicard.appcard", "market://details?id=kr.co.samsungcard.mpocket", "market://details?id=com.lotte.lottesmartpay",
				"market://details?id=com.shcard.smartpay", "market://details?id=com.kbcard.cxh.appcard", "market://details?id=com.ilk.visa3d",
				"market://details?id=com.shcard.smartpay", "market://details?id=kvp.jjy.MispAndroid320" };
		String[] i = { "hdcardappcardansimclick", "mpocket.online.ansimclic", "lottesmartpay", "smshinhanansimclick", "kb-acp", "hanaansim", "shinhan-sr-ansimclick", "ispmobile" };

		JSONArray cardInfos = new JSONArray();

		for (int index = 0; index < m.length; index++) {
			JSONObject cardInfo = new JSONObject();
			try {
				cardInfo.put("m", m[index]);
				cardInfo.put("i", i[index]);

				cardInfos.put(cardInfo);
			} catch (Exception e) {
			}

		}
		try {
			defineInfo.put("CARDDATAS", cardInfos);
		} catch (Exception e) {
		}

		return 0;
	}

	public String getParam(String siteName, String scheme, int version, String appName, String os, boolean isDev) {
		String param = null;
		JSONObject schemes = new JSONObject();

		if (scheme.equals("etc")) { // 안드로이드에서 로그인을 시간으로 체하기 위한 스킴
			try {
				schemes.put("11st", Hex_IDINPUT | Hex_LOGINDELAY_12);
				schemes.put("gmarket", Hex_IDINPUT | Hex_LOGINDELAY_3);
				schemes.put("g9", Hex_IDINPUT | Hex_LOGINDELAY_3);
				schemes.put("auction", Hex_IDINPUT | Hex_LOGINDELAY_2);
				schemes.put("interpark", Hex_IDINPUT | Hex_LOGINDELAY_2);
				schemes.put(".emart", Hex_IDINPUT | Hex_LOGINDELAY_3);
				schemes.put("shinsegaemall", Hex_IDINPUT | Hex_LOGINDELAY_3);
				schemes.put("ssg", Hex_IDINPUT | Hex_LOGINDELAY_3);
				schemes.put("gsshop", Hex_IDINPUT | Hex_LOGINDELAY_6);
				schemes.put("wemakeprice", Hex_IDINPUT | Hex_LOGINDELAY_6);
				schemes.put("tmon", Hex_IDINPUT | Hex_LOGINDELAY_6);
				schemes.put("cjmall", Hex_IDINPUT | Hex_LOGINDELAY_6);
				schemes.put("homeplus", Hex_IDINPUT | Hex_LOGINDELAY_12);
				schemes.put(".lotte.com", Hex_IDINPUT | Hex_LOGINDELAY_12);
				schemes.put("lotteimall", Hex_IDINPUT | Hex_LOGINDELAY_12);
				schemes.put("ellotte", Hex_IDINPUT | Hex_LOGINDELAY_3);
				schemes.put("akmall", Hex_IDINPUT | Hex_LOGINDELAY_6);
				schemes.put("coupang", Hex_EMAILINPUT | Hex_LOGINDELAY_3);
			} catch (Exception e) {
			}
		} else if (scheme.equals("reShould")) { // iOS에서 souldstart에서 리워드를 체크해야 하는 경우.
												// url에 2번째 Array의 값이 있는 경우 3번째 Array의 값으로 split를 한다.
												// 그런 후 마지막 값으로 Split 한 배열의 index를 가져 온다.
			try {
				//schemes.put("g9", "FROM_URL=-=Buy.htm#/Buy/PayComplete=-=#/Buy/PayComplete/=-=1");
			} catch (Exception e) {
			}
		} else if (scheme.equals("reBypass")) { // url에 포함되어 있으면 적립 하지 않고 무시 한다.
			try {
				// https://smshop.interpark.com/order/shop/pay_done_card_nlog.html?on=undefined&err=판매중인 상품이 아닙니다
				// pay_done_card_nlog.html를 추가안한 이유는 페이코로 결제시 호출되기 때문
				schemes.put("interpark", "?lsk==-=shop/pay_done_ispnew.html");
			} catch (Exception e) {
			}
		} else if (scheme.equals("re")) { // 적립을 위해 구매 정보를 가져오는 스크립트 스킴
			try {
				//schemes.put("11st", "SCRIPT=-=Order/viewOrderPayInfo.tmall=-=(function(){return $('.odr_tbl').find('tr:eq(1)').eq(0).find('td').text(); })()");

				schemes.put(
						"11st",
						"SCRIPT=-=Order/viewOrderPayInfo.tmall=-=(function(){var re = $('.odr_tbl').not('.tour_end').find('tbody').eq(0).find('tr:eq(1)').find('td').text(); if(re==null || re.length<1){var doc11=(document.documentURI);var index = doc11.indexOf('&ordNo=')+7;if(index>=7)re = doc11.substring(index,index + 15 );}return re;})()");
				schemes.put(
						"gmarket",
						"SCRIPT=-=ordercomplete?packNo=-=(function() {var doc11=(document.documentURI);var packNo=doc11.substring(doc11.indexOf('?packNo=')+8);var outText=packNo+',';for(var i=0; i<nova.data.orderCompleteData.orderInformation.length; i++) {outText += nova.data.orderCompleteData.orderInformation[i].orderNo+',';}return outText;})()");
				//schemes.put("g9", "SCRIPT=-=Buy.htm#/Buy/PayComplete=-=(function(){var a = document.documentURI; return a.substring(a.indexOf('PayComplete/')+'PayComplete/'.length, a.length)})()");
				if (version < 304) {
					schemes.put("auction", "");
				} else {
					//	schemes.put("auction", "SCRIPT=-=/OrderConfirmMobile.aspx=-=(function(){var doc11=(document.documentURI);var index = doc11.indexOf('?PayNo=')+7;var packNo=doc11.substring(index,index+9)+','; var track =$('#form1 script');for(var i=0;i< track.length;i++){var a = track[i].text;if(a.indexOf('OrderTracking(')>-1){var b =a.substring(a.indexOf('OrderTracking(')+ 'OrderTracking('.length, a.length);packNo += b.substring(0,b.indexOf(');')).split(',')[1]+',';}}packNo = packNo.replace(/'/gi, '');return packNo;})()");

					// 주문번호가 9자리 였다가 10자리로 변경 되면서 주문 수집 JS 변경 (2017 / 05 / 02 장태주)
					// URL에서 긁어 오는 주문 번호 끝에 &가 포함 되어 있으면 &부터 삭제 하도록 수정

					// schemes.put("auction", "SCRIPT=-=/OrderConfirmMobile.aspx=-=(function() {var doc11 = (document.documentURI);var index = doc11.indexOf('?PayNo=') + 7;var packNo = doc11.substring(index);if (packNo.includes('&')) {packNo = packNo.replace(packNo.substring(packNo.indexOf('&')), '')}var packNo = packNo + ',';var track = $('#form1 script');for (var i = 0; i < track.length; i++) {var a = track[i].text;if (a.indexOf('OrderTracking(') > -1) {var b = a.substring(a.indexOf('OrderTracking(') + 'OrderTracking('.length, a.length);packNo += b.substring(0, b.indexOf(');')).split(',')[1] + ','; } }packNo = packNo.replace(/'/gi, '');return packNo; })()");

					//			schemes.put("auction", "SCRIPT=-=/OrderConfirmMobile.aspx=-=(function(){var doc11=(document.documentURI);var index = doc11.indexOf('?PayNo=')+7;var packNo=doc11.substring(index,index+10)+','; var track =$('#form1 script');for(var i=0;i< track.length;i++){var a = track[i].text;if(a.indexOf('OrderTracking(')>-1){var b =a.substring(a.indexOf('OrderTracking(')+ 'OrderTracking('.length, a.length);packNo += b.substring(0,b.indexOf(');')).split(',')[1]+',';}}packNo = packNo.replace(/'/gi, '');return packNo;})()");
					//			}

					schemes.put(
							"auction",
							"SCRIPT=-=/OrderConfirmMobile.aspx=-=(function(){var doc11=(document.documentURI);var paynoindex=doc11.toLowerCase().indexOf('?payno=');var index;var packNo;if(paynoindex>0){index= paynoindex+7;packNo=doc11.substring(index,index+10)+',';}else{packNo = ',';}var track =$('#form1 script');for(var i=0;i< track.length;i++){var a = track[i].text;if(a.indexOf('OrderTracking(')>-1){var b =a.substring(a.indexOf('OrderTracking(')+ 'OrderTracking('.length, a.length);packNo += b.substring(0,b.indexOf(');')).split(',')[1]+',';}}packNo = packNo.replace(/'/gi, '');return packNo;})()");
				}

				//schemes.put("interpark", "SCRIPT=-=order/shop/pay_done=-=(function() {return $('#orderNumber strong').text();})()");
				schemes.put(
						"interpark",
						"SCRIPT=-=order/shop/pay_done=-=(function(){var doc11=(document.documentURI);var sharpindex = doc11.indexOf('#');if(sharpindex>0)return doc11.substring(doc11.toLowerCase().indexOf('on=')+3,sharpindex);else return doc11.substring(doc11.toLowerCase().indexOf('on=')+3);})()");

				schemes.put(".emart",
						"SCRIPT=-=/order/ordComplete.ssg=-=(function(){var doc11=(document.documentURI);return doc11.substring(doc11.toLowerCase().indexOf('ordno=')+6);})()");
				schemes.put("shinsegaemall",
						"SCRIPT=-=/order/ordComplete.ssg=-=(function(){var doc11=(document.documentURI);return doc11.substring(doc11.toLowerCase().indexOf('ordno=')+6);})()");
				schemes.put("ssg", "SCRIPT=-=/order/ordComplete.ssg=-=(function(){var doc11=(document.documentURI);return doc11.split('?')[1].split('&')[0].split('=')[1];})()");

				schemes.put("gsshop", "SCRIPT=-=order/main/confirmOrder.gs=-=(function() {return $('.order-number em').text().split(' : ')[1].replace(')','');})()");
				schemes.put(
						"wemakeprice",

						"SCRIPT=-=order/confirm_cart_order=-=(function(){var a=document.documentURI;if(a.indexOf('order/orderComplete')>0)return $('#purchaseNo').val();else{var b = a.substring(a.lastIndexOf('/')+1,a.length);var index = b.indexOf('#'); if(index>0) return b.substring(0,index);else return b;}})()");
				schemes.put(
						"tmon",
						"SCRIPT=-=/result/=-=(function(){var temp = $('.cmpl .order .num').text();if(temp==null || temp.length<1){var doc11=(document.documentURI);var index = doc11.toLowerCase().indexOf('/result/')+8;return doc11.substring(index,index+10);}else return temp;})()");
				//				schemes.put("cjmall", "SCRIPT=-=mw.cjmall.com/m/order/order_end.jsp=-=(function() {var a = $('.paynum').text();return a.substring('주문번호 '.length,a.length);})()");
				//				schemes.put("cjmall", "SCRIPT=-=base.cjmall.com/m/order/end/=-=(function() {var a = $('.paynum').text();if (a.length) return a.substring('주문번호 '.length, a.length).replace(/-/gi, '');a = $('.order_number').text();if (a.length) return a.substring('주문번호 '.length, a.length).replace(/-/gi, '');var url = document.documentURI;if (url.includes('base.cjmall.com/m/order/end/')) {var index = url.indexOf('/end/');a = url.substring(index + 5);if (a.includes('?app_cd=')) {a = a.replace(a.substring(a.indexOf('?')), '');}return a; } })()");
				//schemes.put(
				//	"cjmall",
				//"SCRIPT=-=mw.cjmall.com/m/order/order_end.jsp=-=(function() {var a = $('.paynum').text();if (a.length) return a.substring('주문번호 '.length, a.length).replace(/-/gi, '');a = $('.order_number').text();if (a.length) return a.substring('주문번호 '.length, a.length).replace(/-/gi, '');var url = document.documentURI;if (url.includes('base.cjmall.com/m/order/end/')) {var index = url.indexOf('/end/');a = url.substring(index + 5,index+5+14);if (a.includes('?app_cd=')) {a = a.replace(a.substring(a.indexOf('?')), '');}return a; } })()");

				schemes.put(
						"cjmall",
						"SCRIPT=-=cjmall.com/m/order/end=-=(function() {var a = $('.paynum').text();if (a.length) return a.substring('주문번호 '.length, a.length).replace(/-/gi, '');a = $('.order_number').text();if (a.length) return a.substring('주문번호 '.length, a.length).replace(/-/gi, '');var url = document.documentURI;if (url.includes('base.cjmall.com/m/order/end/')) {var index = url.indexOf('/end/');a = url.substring(index + 5,index+5+14);if (a.includes('?app_cd=')) {a = a.replace(a.substring(a.indexOf('?')), '');}return a; } })()");

				schemes.put(
						"coupang",
						"SCRIPT=-=/orderResult.pang=-=(function() {var doc11=(document.documentURI);var packNo=doc11.substring(doc11.indexOf('orderId=')+8);return packNo.substring(0,packNo.indexOf('&'))})()");

				if(isDev)
				schemes.put("hyundaihmall", "SCRIPT=-=/front/orderComplete.do=-=(function() {return _TRK_ODN +','+_TRK_PNC.replace(/;/gi, ',');})()");
				schemes.put("akmall", "");
				schemes.put("homeplus", "");
				schemes.put(".lotte.com", "");
				schemes.put("lotteimall", "");
				schemes.put("ellotte", "");
				schemes.put("hnsmall", "");

				//schemes.put("coupang", "SCRIPT=-=m/orderResult.pang=-=(function(){var a = document.documentURI; return a.substring(a.indexOf('orderId=')+8,a.indexOf('&price'));})()");
			} catch (Exception e) {
			}
		} else if (scheme.equals("reLink")) { // 리워드 확인 하는 링크, 있으면 reLink를 사용 하고 없으면 기존의 re를 사용 하도록 한다. // 3.2.5(2017.04) 부터 적용.
			try {
				schemes.put("cjmall", "mw.cjmall.com/m/order/order_end.jsp=-=base.cjmall.com/m/order/end/");
				schemes.put("wemakeprice", "order/orderComplete=-=order/confirm_cart_order");
			} catch (Exception e) {
			}
		} else if (scheme.equals("renot"))//=-=구분 리워드 중에 에러가 아닌데 에러로 메시지 던지는 걸 걸러넨다
		{
			try {
				//	schemes.put("11st", "url=p"); 시럽(11pay) 리워드 안되서 다시 지웠음
				schemes.put("interpark", "order/shop/pay_done_ispnew.html");
				//schemes.put("wemakeprice", "index.php/m/order");
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
			} catch (Exception e) {
			}
		} else if (scheme.equals("reLog")) { // 3.2.7에서 앱 리워드 로그 추가 획득 (아직 미정)
			try {
				//schemes.put("11st", "(function(){return $('.odr_tbl').not('.tour_end').find('tbody').eq(0).find('tr:eq(1)').html(); })()");//않ㄴ다 이것도 html 가져오는곳이랑 동일해서 의미 없다
				schemes.put("auction", "(function() {return $('#form1 script')[0].text; })()");
				schemes.put("interpark", "(function(){return $('.paymentContentsWrap .orderNumber .detail').html();})()");
				//schemes.put("tmon", "(function() {return $('.cmpl .order .num').text();})()"); //안한다 html 가져오는 곳이랑 동일하다

			} catch (Exception e) {
			}
		} else if (scheme.equals("reCallPercent")) //3.3.1에서 gsshop의 경우 주문완료페이지에서 finish가 안떨어져서 안드로이드는 90%, iOS는 60%이상인경우 리워드를 던지도록 추가
		{
			try {

				schemes.put("gsshop", "90");
				schemes.put("gmarket", "90");

			} catch (Exception e) {
			}
		} else if (scheme.equals("iosReCallPercent")) {
			try {

				schemes.put("gsshop", "60");
				//ios는 3.4.2 버전 부터 적용 된다
				if (os.equals("aos") || (os.equals("ios") && version >= 342))
					schemes.put("gmarket", "80");

			} catch (Exception e) {
			}
		}

		else if (scheme.equals("lc")) { // 쿠키에서 로그인 여부를 확인 하기 위한 스킴, 해당 스킴이 있으면 로그인이 성공한 것으로 본다.
			try {
				schemes.put("11st", "TMALL_AUTH=");
				schemes.put("gmarket", "isMember=MEM");
				schemes.put("auction", "auction=");
				schemes.put("interpark", "TMem%5FNO=");
				schemes.put(".emart", "MEMBER_ID=");
				schemes.put("shinsegaemall", "MEMBER_ID=");
				schemes.put("ssg", "MEMBER_ID=");
				schemes.put("gsshop", "login=true");
				schemes.put("wemakeprice", "setGM=");
				schemes.put("tmon", "tmon_login=");
				schemes.put("cjmall", "CJ_LOGIN=Y");
				schemes.put("hyundaihmall", "EHCustNO=");
				//schemes.put("akmall", "loginToken=-=BLANK");
				schemes.put("homeplus", "cAAutoID=-=BLANK");
				//20171206 쿠키확인 변경 (전:LOGINCHK)
				schemes.put(".lotte.com", "LOGINID=-=BLANK");
				//20171206 쿠키확인 변경 (전:LOGINCHK)
				schemes.put("lotteimall", "MC_ALOGIN_SEQ=-=BLANK");
				//신 엘롯데
				schemes.put("ellotte", "onl_id=-=BLANK");
				//구 엘롯데
				//schemes.put("ellotte", "LOGINID=-=BLANK");
				schemes.put("hnsmall", "savePw=-=BLANK");
				schemes.put("coupang", "CPUSR_RL");

				schemes.put("akmall", "mobileLogin");
				schemes.put("g9", "authtoken=-=BLANK");
			} catch (Exception e) {
			}
		} else if (scheme.equals("lcmsg")) { //안드로이드 3.0.9 버젼 부터 팝업 뜨면 로그인 실패인데 이 팝업이면 로그인 성공 시킴
			try {
				schemes.put("cjmall", "이미 로그인 중입니다.=-=");

			} catch (Exception e) {
			}
		} else if (scheme.equals("lurl")) { // 잘 모르겠음, iOS는 3.0.6 이후로 사용하지 않음
			try {
				schemes.put("lotteimall", "");
				schemes.put("ellotte", "");
			} catch (Exception e) {
			}
		} else if (scheme.equals("ld")) { // 로그인 쿠키 도메인
			try {
				schemes.put("11st", "http://m.11st.co.kr");
				schemes.put("gmarket", "http://m.gmarket.co.kr");
				schemes.put("g9", "http://m.g9.co.kr");
				schemes.put("auction", "http://mobile.auction.co.kr");
				schemes.put("interpark", "http://m.shop.interpark.com");
				schemes.put(".emart", "https://m.emart.ssg.com");
				schemes.put("shinsegaemall", "https://m.shinsegaemall.ssg.com");
				schemes.put("ssg", "http://m.ssg.com");
				schemes.put("gsshop", "http://m.gsshop.com");
				schemes.put("wemakeprice", "https://mw.wemakeprice.com");
				schemes.put("tmon", "http://m.tmon.co.kr");
				schemes.put("cjmall", "http://display.cjmall.com");
				schemes.put("hyundaihmall", "http://m.hyundaihmall.com");
				schemes.put("akmall", "http://m.akmall.com");
				schemes.put("homeplus", "https://m.homeplus.co.kr:448");
				schemes.put(".lotte.com", "http://m.lotte.com");
				schemes.put("lotteimall", "http://m.lotteimall.com");
				//신 엘롯데 링크 20181101
				schemes.put("ellotte", "https://m.display.ellotte.com");
				//구 엘롯데 링크
				//schemes.put("ellotte", "http://m.ellotte.com");
				schemes.put("hnsmall", "http://m.hnsmall.com");
				schemes.put("coupang", "http://m.coupang.com");
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
		} else if (scheme.equals("icb")) { // 아이폰용 큰 아이콘 이미지
			try {
				schemes.put("11st", "");
				schemes.put("gmarket", "app_icon_166_gmarket");
				schemes.put("auction", "app_icon_166_auction");

				schemes.put("interpark", "app_icon_166_interpark");
				schemes.put(".emart", "app_icon_166_emart");
				schemes.put("shinsegaemall", "app_icon_166_shinsegaemall");
				schemes.put("ssg", "app_icon_166_ssg");
				schemes.put("wemakeprice", "");
				schemes.put("tmon", "app_icon_166_ticketmonster");
				schemes.put("cjmall", "app_icon_166_cjmall");
				if(isDev)
					schemes.put("hyundaihmall", "app_icon_166_cjmall");
				else
					schemes.put("hyundaihmall", "");
				schemes.put("akmall", "");
				schemes.put("homeplus", "");
				schemes.put(".lotte.com", "app_icon_166_lottecom_20180124");
				schemes.put("ellotte", "app_icon_166_ellotte");
				schemes.put("hnsmall", "");
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
		} else if (scheme.equals("reCoDomain")) { // 적립 대상인지 확인하는 url
			try {
				schemes.put("11st", "http://m.11st.co.kr/");
				schemes.put("gmarket", "http://mitem.gmarket.co.kr/");
				//schemes.put("g9", " ");
				if (version < 304) {
					schemes.put("auction", " ");
				} else {
					schemes.put("auction", "http://mitem.auction.co.kr=-=http://mobile.auction.co.kr=-=http://mmya.auction.co.kr");
				}
				schemes.put("interpark", "http://m.shop.interpark.com/");
				schemes.put(".emart", "http://m.emart.ssg.com");
				schemes.put("shinsegaemall", "http://m.shinsegaemall.ssg.com");
				schemes.put("ssg", "http://m.ssg.com");
				schemes.put("gsshop", "http://m.gsshop.com/");
				schemes.put("wemakeprice", "https://mw.wemakeprice.com/");
				schemes.put("tmon", "http://m.tmon.co.kr/");
				schemes.put("cjmall", "http://fdrive.cjmall.com/m=-=http://mw.cjmall.com/m/item");
				//schemes.put("hyundaihmall", " ");
				//schemes.put("akmall", " ");
				//schemes.put("homeplus", " ");
				//schemes.put(".lotte.com", " ");
				//schemes.put("lotteimall", " ");
				//schemes.put("ellotte", " ");
				//schemes.put("hnsmall", " ");
			} catch (Exception e) {
			}
		} else if (scheme.equals("ic")) { // 안드로이드 아이콘, iOS는 icb가 없으면 이 아이콘을 가져 온다.
			try {
				schemes.put("11st", "app_icon_11st_0714");
				schemes.put("gmarket", "app_icon_gmarket");
				//ios 는 그냥되고 android는 3.4.5부터 됨 소수 수정함 (web database 설정)
				if (isDev && ((appName.equals("enuri") && os.equals("aos") && version >= 345) || os.equals("ios")))
					schemes.put("g9", "app_icon_g9");

				// 				if (!os.equals("ios"))
				schemes.put("auction", "app_icon_auction_new");
				// 				if (os.equals("ios"))
				schemes.put("interpark", "app_icon_interpark");
				//schemes.put("interpark", "");
				schemes.put(".emart", "app_icon_emart");
				schemes.put("shinsegaemall", "app_icon_shinsegaemall");
				schemes.put("ssg", "app_icon_ssg");
				schemes.put("wemakeprice", "app_icon_wemakeprice1015");

				//	schemes.put("wemakeprice", "app_icon_wemakeprice20170330");

				schemes.put("tmon", "app_icon_ticketmonster");
				/* if (os.equals("ios")) 	//cjmall android */
				if (isDev)
					schemes.put("cjmall", "app_icon_cjmall");
				if (isDev)
					schemes.put("hyundaihmall", "app_icon_cjmall");
				else
					schemes.put("hyundaihmall", "");
				//schemes.put("e-himart", "");
				//schemes.put("galleria", "app_icon_galleria");
				//schemes.put("okmall", "");
				// schemes.put(".nsmall.com", "app_icon_nsshopping");
				//schemes.put(".nsmall.com", "");
				//schemes.put("homeplus", "");
				//schemes.put("lottemart", "app_icon_lottemart");
				schemes.put(".lotte.com", "app_icon_lottecom_20180124");
				//schemes.put("lotteimall", "");
				//신 엘롯데 11월 1일 0시에 닫고 출근해서 오픈
				schemes.put("ellotte", "app_icon_ellotte_new");
				//schemes.put("hnsmall", "");
				if (isDev)
					schemes.put("gsshop", "app_icon_gsshop");
				//	schemes.put("akmall", "app_icon_lottemart");
				//schemes.put("coupang", "app_icon_coupang");
			} catch (Exception e) {
			}
		} else if (scheme.equals("captcha")) {
			try {
				schemes.put("wemakeprice",
						"(function(){var captch = $('captch_img img').attr('src');if(captch == null || captch.length ==0)return '';else  return 'https://mw.wemakeprice.com'+captch})()");
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
				schemes.put("tmon", "app_icon_ticketmonster");
				schemes.put("cjmall", "app_icon_cjmall");//90일간 비번 변경 팝업 대응
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
				//신 엘롯데 11월 1일 0시에 닫고 출근해서 오픈
				schemes.put("ellotte", "app_icon_ellotte_new");
				schemes.put("hnsmall", "app_icon_homenshopping");
				schemes.put("coupang", "app_icon_coupang");
			} catch (Exception e) {
			}
		} else if (scheme.equals("t")) { // 쇼핑몰 이름
			try {
				schemes.put("11st", "11번가");
				schemes.put("gmarket", "G마켓");
				schemes.put("g9", "G9");
				schemes.put("auction", "옥션");
				schemes.put("interpark", "인터파크");
				schemes.put(".emart", "이마트");
				schemes.put("shinsegaemall", "신세계몰");
				schemes.put("ssg", "SSG.COM");
				schemes.put("gsshop", "GS쇼핑");
				schemes.put("wemakeprice", "위메프");
				schemes.put("tmon", "티켓몬스터");
				schemes.put("cjmall", "CJ몰");
				schemes.put("hyundaihmall", "현대 hmall");
				schemes.put("akmall", "AK몰");
				schemes.put("e-himart", "하이마트");
				schemes.put("galleria", "갤러리아");
				schemes.put("okmall", "OKMALL");
				schemes.put(".nsmall.com", "ns홈쇼핑");
				schemes.put("homeplus", "홈플러스");
				schemes.put("lottemart", "롯데마트");
				schemes.put(".lotte.com", "롯데닷컴");
				schemes.put("lotteimall", "롯데아이몰");
				schemes.put("ellotte", "엘롯데");
				schemes.put("hnsmall", "홈앤쇼핑");
				schemes.put("coupang", "쿠팡");

				if (appName.equals("vaccine")) {
					schemes.put("tmon", "티몬");
					schemes.put("gsshop", "GS Shop");
					schemes.put("cjmall", "CJ mall");
					schemes.put("lotteimall", "롯데홈쇼핑");
				}
			} catch (Exception e) {
			}
		} else if (scheme.equals("m")) { // 쇼핑몰 메인 페이지 url
			try {
				schemes.put("11st", "http://m.11st.co.kr/MW/html/main.html");
				schemes.put("gmarket", "http://mobile.gmarket.co.kr/");
				schemes.put("g9", "http://m.g9.co.kr/Default/Home");
				schemes.put("auction", "http://mobile.auction.co.kr/");
				schemes.put("interpark", "http://m.shop.interpark.com/");
				schemes.put(".emart", "http://m.emart.ssg.com/");
				schemes.put("shinsegaemall", "http://m.shinsegaemall.ssg.com/mall/main.ssg");
				schemes.put("ssg", "http://m.ssg.com/");
				schemes.put("gsshop", "http://m.gsshop.com/");
				schemes.put("wemakeprice", "https://mw.wemakeprice.com/main");
				schemes.put("tmon", "http://m.tmon.co.kr/");
				schemes.put("cjmall", "http://display.cjmall.com/m/homeTab/main");
				schemes.put("hyundaihmall", "http://m.hyundaihmall.com/");
				schemes.put("akmall", "http://m.akmall.com/");
				schemes.put("e-himart", "http://m.e-himart.co.kr/");
				schemes.put("galleria", "http://mobile.galleria.co.kr");
				schemes.put(".nsmall.com", "http://m.nsmall.com");
				schemes.put("homeplus", "http://m.homeplus.co.kr/");
				schemes.put("lottemart", "http://m.lottemart.com");
				schemes.put(".lotte.com", "http://m.lotte.com");
				schemes.put("lotteimall", "http://m.lotteimall.com/main/viewMain.lotte");

				//신 엘롯데 링크 20181101
				schemes.put("ellotte", "https://m.display.ellotte.com/display-mo/shop");
				//구 엘롯데 링크
				//schemes.put("ellotte", "http://m.ellotte.com");

				schemes.put("hnsmall", "http://m.hnsmall.com");
				schemes.put("coupang", "http://m.coupang.com/nm/");
			} catch (Exception e) {
			}
		} else if (scheme.equals("l")) { // 쇼핑몰 로그인 페이지 url ios 에서는 쇼핑몰에 맞게 이게 있어야지 없으면 앱 죽음
			try {

				schemes.put("11st", "https://login.11st.co.kr/auth/login.tmall");//?returnURL=&method=Xsite&tid=1000997249");
				schemes.put("gmarket", "http://mobile.gmarket.co.kr/Login/Login");
				schemes.put("g9", "https://mssl.g9.co.kr/Member.htm");
				schemes.put("auction", "https://signin.auction.co.kr/Authenticate/MobileLogin.aspx?url=");
				schemes.put("interpark", "https://accounts.interpark.com/login/form");
				schemes.put(".emart", "https://member.ssg.com/m/member/login.ssg?retURL=http%3A%2F%2Fm.emart.ssg.com");
				schemes.put("shinsegaemall", "https://member.ssg.com/m/member/login.ssg?shinsegaemall=");
				schemes.put("ssg", "https://member.ssg.com/m/member/login.ssg?retURL=");
				schemes.put("gsshop", "https://m.gsshop.com/member/logIn.gs");// "http://m.gsshop.com/member/logIn.gs");
				schemes.put("wemakeprice", "https://mw.wemakeprice.com/user/login");
				schemes.put("tmon", "https://m.tmon.co.kr/user/loginForm");
				schemes.put("cjmall", "https://base.cjmall.com/m/page/account/login?returnUrl=http%3A%2F%2Fdisplay.cjmall.com%2Fm%2FhomeTab%2Fmain");
				if(isDev)//마이메뉴 눌렀을때 로그인 화면 주소가 마이메뉴 주소이다
					schemes.put("hyundaihmall", "https://m.hyundaihmall.com/front/smLoginF.do");
				else
					schemes.put("hyundaihmall", "");// "https://m.hyundaihmall.com/front/smLoginF.do");
				schemes.put("akmall", "");//"https://m.akmall.com/login/Login.do");
				schemes.put("e-himart", "");// "https://m.e-himart.co.kr/login.hmt?page=myHimart");
				schemes.put("galleria", "");
				schemes.put("okmall", "");
				schemes.put(".nsmall.com", "");// "http://m.nsmall.com/MemberLogin");
				schemes.put("homeplus", "");// "http://m.homeplus.co.kr/identity/login.do");
				schemes.put("lottemart", "");
				schemes.put(".lotte.com", "https://m.lotte.com/login/m/loginForm.do");//?c=mlotte&udid=&v=&cn=&cdn=&tclick=m_footer_log&targetUrl=");
				schemes.put("lotteimall", "");//"https://securem.lotteimall.com/member/login/forward.LCLoginMem.lotte");

				//신 엘롯데 링크 20181101
				schemes.put("ellotte", "https://m.members.ellotte.com/members-mo/login/form");
				//구 엘롯데 링크
				//schemes.put("ellotte", "https://m.ellotte.com/login/m/loginForm.do?c=&udid=&v=&cn=&cdn=&schema=");

				schemes.put("hnsmall", "");//"https://m.hnsmall.com/customer/login");
				schemes.put("coupang", "");//"https://login.coupang.com/login/login.pang");
			} catch (Exception e) {
			}
		} else if (scheme.equals("lhtml")) {
			try {
				schemes.put("wemakeprice", "wemakeprice.com/user/password/advice");
				schemes.put("cjmall", "cjmall.com/m/myzone/main");
			} catch (Exception e) {
			}

		} else if (scheme.equals("i")) { //쇼핑몰 로그인페이지에서 로그인 하는 스크립트
			try {
				//schemes.put("11st", "$('#userId').val('[[id]]');$('#userPw').val('[[pwd]]');$('#alg').prop('checked',true);$('#loginButton').click();");

				schemes.put("11st", "$('#memId').val('[[id]]');$('#memPwd').val('[[pwd]]');$('#keepsave').attr('checked', true);$('.login_box > .bbtn').click();");

				schemes.put("gmarket", "$('#id').val('[[id]]');$('#pwd').val('[[pwd]]');$('.lgs').click();");
				schemes.put("g9", "$('#LoginID').val('[[id]]');$('#Password').val('[[pwd]]');$('.btn_login').click();");
				schemes.put("auction", "$('#id').val('[[id]]');$('#password').val('[[pwd]]');$('#chkAutoLogin').attr('checked', true);$('#btnLogin').click();");
				//schemes.put("interpark", "$('#userId').val('[[id]]');$('#userPwd').val('[[pwd]]');$('.btn_login').click();");
				schemes.put("interpark", "$('#userId').val('[[id]]');$('#userPwd').val('[[pwd]]');$( '#ipLogin' ).removeClass( 'BtnLogin off' ).addClass( 'BtnLogin' );setTimeout($('#btn_login').click(),1000);setTimeout(saveAgree('Y'),5000);");
				schemes.put(".emart", "$('#inp_id').val('[[id]]');$('#inp_pw').val('[[pwd]]');$('#login_form').submit();");
				schemes.put("shinsegaemall", "$('#inp_id').val('[[id]]');$('#inp_pw').val('[[pwd]]');$('.bn_pnk').click();");
				schemes.put("ssg", "$('#inp_id').val('[[id]]');$('#inp_pw').val('[[pwd]]');$('.bn_pnk').click();");
				schemes.put("gsshop", "$('#id').val('[[id]]');$('#passwd').val('[[pwd]]');$('#btnLogin').click();");
				schemes.put("wemakeprice", "$('#_loginId').val('[[id]]');$('#_loginPw').val('[[pwd]]');$('#_userLogin').click();");
				schemes.put("tmon",
				//"$('#user_id').val('[[id]]');$('#user_pw').val('[[pwd]]');$('form').submit();");
						"$('#user_form_id').val('[[id]]');$('#user_form_pw').val('[[pwd]]');$('#login').click();");

				schemes.put("cjmall",
						"$('#id_input').val('[[id]]');$('#password_input').val('[[pwd]]');$('#loginSubmit').click();setTimeout(function(){$('#close_layer').click();},5000)");
				schemes.put("hyundaihmall", "$(\"input[name='userid']\").val('[[id]]');$(\"input[name='password']\").val('[[pwd]]');$('#loginCheck').click();");
				schemes.put("akmall", "$('#cust_id').val('[[id]]');$('#upw').val('[[pwd]]');$(\"form[name='memberFrm']\").submit();");
				schemes.put("e-himart", "");
				schemes.put("galleria", "");
				schemes.put("okmall", "");
				schemes.put(".nsmall.com", "$('#txtUserId').val('[[id]]');$('#txtPassword').val('[[pwd]]');$('#btnLogin').click();");
				schemes.put("homeplus", "$('#login_id').val('[[id]]');$('#user_passwd').val('[[pwd]]');identity.login();");
				schemes.put("lottemart", "");
				schemes.put(".lotte.com", "$('#userId').val('[[id]]');$('#lPointPw').val('[[pwd]]');angular.element('[ng-click]').scope().checkLogin('N');");
				schemes.put("lotteimall", "$('#login_id').val('[[id]]');$('#password').val('[[pwd]]');$('.btn_login').click();");

				//신 엘롯데
				schemes.put("ellotte", "$('#mbrLoginId1').val('[[id]]');$('#mbrLoginPwd1').val('[[pwd]]');$('#tab_pan-01 .btnLogin').click();");
				//구 엘롯데
				//schemes.put("ellotte", "$('#userId').val('[[id]]');$('#lPointPw').val('[[pwd]]');angular.element('[ng-click]').scope().checkLogin('N');");
				schemes.put("hnsmall", "$(\"input[name='mem_id']\").val('[[id]]');$(\"input[name='mem_pw']\").val('[[pwd]]');login(document.loginForm);");
				schemes.put("coupang",
						"$('#login-email-input').val('[[id]]');$('#login-password-input').val('[[pwd]]');$('#login-keep-state').attr('checked', true);$('.login__button').click();");
			} catch (Exception e) {
			}
		} else if (scheme.equals("j")) { // 쇼핑몰 바로 로그인 스크립트
			try {
				schemes.put("11st", "");
				schemes.put(
						"gmarket",
						"<form style=\"visibility:hidden\" name=lf method=post action=\"https://mobile.gmarket.co.kr/Login/Login\"><input name=\"url\" value=\"\"><input name=\"id\" id=\"id\" value=\"[[id]]\"><input name=\"pwd\" id=\"pwd\" value=\"[[pwd]]\"></form><script>lf.submit();</script>");
				schemes.put(
						"g9",
						"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://apissl.g9.co.kr/api/Authentication/DoLogin\"><input name=\"RedirectUrl\" value=\"http://m.g9.co.kr/Default/Home\"><input name=\"LoginID\" value=\"[[id]]\"><input name=\"Password\" value=\"[[pwd]]\"><input name=\"SaveLoginIdYN\" value=\"true\"><input name=\"AutoLoginYN\" value=\"false\"></form><script>lf.submit();</script>");
				schemes.put(
						"auction",
						"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://signin.auction.co.kr/Authenticate/login.aspx\"><input name=\"seller\" type=\"hidden\" value=\"\"><input name=\"seqno\" type=\"hidden\" value=\"\"><input name=\"url\" value=\"\"><input name=\"id\" value=\"[[id]]\"><input name=\"password\" value=\"[[pwd]]\"></form><script>lf.submit();</script>");
				//schemes.put("interpark", "<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://m.interpark.com/auth/_ajax/login.html\"><input name=\"fromSVC\" type=\"hidden\" value=\"shop\"><input name=\"retUrl\" type=\"hidden\" value=\"https%3A%2F%2Fm.interpark.com%2Fmy%2Fshop%2Fbuylist.html\"><input name=\"userId\" value=\"[[id]]\"><input name=\"userPwd\" value=\"[[pwd]]\"></form><script>lf.submit();</script>");
				//20171206 포스트 업데이트
				//schemes.put("interpark", "<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://m.interpark.com/auth/_ajax/login.html?callback=ipk_member_callback\"><input name=\"fromSVC\" value=\"shop\"><input name=\"userId\" value=\"[[id]]\"><input name=\"userPwd\" value=\"[[pwd]]\"><input name=\"saveSess\" value=\"Y\"><input name=\"saveId\" value=\"Y\"></form><script>lf.submit();</script>");
				schemes.put(
						".emart",
						"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://member.ssg.com/m/member/login.ssg\"><input name=\"mbrLoginId\" value=\"[[id]]\"><input name=\"password\" value=\"[[pwd]]\"><input name=\"keepLogin\" value=\"Y\"></form><script>lf.submit();</script>");
				schemes.put(
						"shinsegaemall",
						"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://member.ssg.com/m/member/login.ssg\"><input name=\"mbrLoginId\" id=\"inp_id\" value=\"[[id]]\"><input name=\"password\" id=\"inp_pw\" value=\"[[pwd]]\"><input name=\"keepLogin\" value=\"Y\"></form><script>lf.submit();</script>");
				schemes.put(
						"ssg",
						"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://member.ssg.com/m/member/login.ssg\"><input name=\"mbrLoginId\" id=\"inp_id\" value=\"[[id]]\"><input name=\"password\" id=\"inp_pw\" value=\"[[pwd]]\"><input name=\"keepLogin\" value=\"Y\"></form><script>lf.submit();</script>");
				schemes.put(
						"gsshop",
						"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://m.gsshop.com/member/j_spring_security_check\"><input name=\"id\" value=\"[[id]]\"><input name=\"passwd\" value=\"[[pwd]]\"></form><script>lf.submit();</script>");
				//schemes.put(
				//		"tmon",
				//		"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://m.tmon.co.kr/user/login\"><input name=\"id\" value=\"[[id]]\"><input name=\"pw\" value=\"[[pwd]]\"><input name=\"au\" value=\"1\"></form><script>lf.submit();</script>");
				schemes.put(
						"hyundaihmall",
						"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://m.hyundaihmall.com/front/smLoginP.do\"><input name=\"userid\" value=\"[[id]]\"><input name=\"password\" value=\"[[pwd]]\"></form><script>lf.submit();</script>");
				schemes.put(
						"akmall",
						"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://m.akmall.com/login/LoginProc2.do\"><input name=\"goUrl\" value=\"/mypage/OrderDeliInquiry.do\"><input name=\"urlpath\" value=\"\"><input name=\"token\" value=\"\"><input name=\"checkedNoSSL\" value=\"Y\"><input name=\"cust_id\" value=\"[[id]]\"><input name=\"passwd\" value=\"[[pwd]]\"><input name=\"keep_id\" value=\"Y\"><input name=\"autoLogin\" value=\"Y\">/form><script>lf.submit();</script>");
				schemes.put("e-himart", "");
				schemes.put("galleria", "");
				schemes.put("okmall", "");
				schemes.put(".nsmall.com", "");
				schemes.put(
						"homeplus",
						"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://m.homeplus.co.kr:448/identity/loginProc.do\"><input name=\"login_id\" value=\"[[id]]\"><input name=\"user_passwd\" value=\"[[pwd]]\"><input name=\"chkautologin\" value=\"Y\"></form><script>lf.submit();</script>");
				schemes.put("lottemart", "");
				//20171206 포스트 업데이트
				//schemes.put(".lotte.com", "<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://m.lotte.com/json/login.json\"><input name=\"userId\" value=\"[[id]]\"><input name=\"lPointPw\" value=\"[[pwd]]\"><input name=\"auto\" value=\"1\"><input name=\"save\" value=\"1\"><input name=\"autoEasy\" value=\"1\"><input name=\"saveEasy\" value=\"1\"></form><script>lf.submit();</script>");
				//20171206 포스트 업데이트
				//schemes.put("ellotte", "<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://m.ellotte.com/json/login.json\"><input name=\"userId\" value=\"[[id]]\"><input name=\"lPointPw\" value=\"[[pwd]]\"><input name=\"auto\" value=\"1\"><input name=\"save\" value=\"1\"><input name=\"autoEasy\" value=\"1\"><input name=\"saveEasy\" value=\"1\"></form><script>lf.submit();</script>");
				schemes.put(
						"hnsmall",
						"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://m.hnsmall.com/customer/loginproc\"><input name=\"mem_id\" value=\"[[id]]\"><input name=\"mem_pw\" value=\"[[pwd]]\"></form><script>lf.submit();</script>");
				//schemes.put(
				//		"coupang",
				//		"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://login.coupang.com/login/loginProcess.pang\"><input name=\"email\" id=\"login-tf-email\" value=\"[[id]]\"><input name=\"password\" id=\"login-tf-password\" value=\"[[pwd]]\"></form><script>lf.submit();</script>");
			} catch (Exception e) {
			}
		}
		/* else if (scheme.equals("h")) { // 수익코드 붙은 쇼핑몰 메인페이지 url
			try {
				String server = isDev ? "dev" : "m";
				schemes.put(
						"11st",
						"http://"
								+ server
								+ ".enuri.com/mobilefirst/move2.jsp?vcode=5910&freetoken=outlink&url=http%3A%2F%2Fwww.11st.co.kr%2Fconnect%2FGateway.tmall%3Fmethod%3DXsite%26tid%3D1000997249");

				schemes.put("gmarket", "http://www.gmarket.co.kr/index.asp?jaehuid=200006254");
				schemes.put("g9", "http://m.g9.co.kr/Default/Home?jaehuid=200006436");
				//schemes.put("auction", "http://mobile.auction.co.kr/HomeMain?BCODE=BN00181187");
				schemes.put("auction", "http://banner.auction.co.kr/bn_redirect.asp?ID=BN00181187");
				schemes.put(
						"interpark",
						"http://"
								+ server
								+ ".enuri.com/mobilefirst/move2.jsp?vcode=55&freetoken=outlink&url=http%3A%2F%2Fm.interpark.com%2FmobileGW.html%3Fsvc%3DShop%26bizCode%3DP14126%26url%3Dhttp%3A%2F%2Fm.shop.interpark.com");
				schemes.put(".emart", "http://m.emart.ssg.com/planshop/planShopBest.ssg?ckwhere=m_enuri");
				schemes.put("shinsegaemall", "http://m.shinsegaemall.ssg.com/mall/main.ssg?ckwhere=s_enuri");
				schemes.put("ssg", "http://m.ssg.com/?ckwhere=s_enuri");
				schemes.put("gsshop", "http://with.gsshop.com/jsp/jseis_withLGeshop.jsp?media=Pg&gourl=http://m.gsshop.com");
				schemes.put("wemakeprice",

				"https://mw.wemakeprice.com/affiliate/bridge?channelId=1000032");
				schemes.put("tmon", "http://m.tmon.co.kr/entry/?jp=80025&ln=214285");
				schemes.put("cjmall", "http://mw.cjmall.com/m/main.jsp?app_cd=ENURI");
				schemes.put("hyundaihmall", "http://www.hyundaihmall.com/front/shNetworkShop.do?NetworkShop=Html&ReferCode=022&Url=http://www.hyundaihmall.com/Home.html");
				schemes.put("akmall", "http://www.akmall.com/assc/associate.jsp?assc_comp_id=26392");
				schemes.put("e-himart", "");
				schemes.put("galleria", "http://mobile.galleria.co.kr/common.do?method=join&channel_id=2764&link_id=0105");
				schemes.put("okmall", "");
				schemes.put(".nsmall.com", "http://m.nsmall.com/mjsp/site/gate.jsp?co_cd=190&target=http%3A%2F%2Fm.nsmall.com%2FMainView");
				schemes.put("homeplus", "http://www.homeplus.co.kr/app.exhibition.main.PartnerMall.ghs?extends_id=enuri&service_cd=56080&nextUrl=http://www.homeplus.co.kr");
				schemes.put("lottemart", "http://m.lottemart.com/mobile/mobile_main.do?AFFILIATE_ID=01030001&CHANNEL_CD=00056");
				schemes.put(".lotte.com", "http://m.lotte.com/main_phone.do?udid=&cn=112346&cdn=783491");
				schemes.put("lotteimall", "http://www.lotteimall.com/coop/affilGate.lotte?chl_no=140769&chl_dtl_no=2540476");
				//신 엘롯데
				schemes.put("ellotte", "https://m.display.ellotte.com/display-mo/shop?chnlNo=100023&chnlDtlNo=1000023");
				//구 엘롯데
				//schemes.put("ellotte", "http://m.ellotte.com/main.do?&cn=153348&cdn=2942692");
				schemes.put("hnsmall", "http://m.hnsmall.com/channel/gate?channel_code=20200");
				schemes.put(
						"coupang",
						"http://www.coupang.com/landingMulti.pang?sid=Enuri&src=1033035&spec=10305201&addtag=400&utm_source=EN&utm_medium=Enuri_PCS&utm_campaign=PC_EP&forceBypass=Y&synd_meta=ENURI&homeLanding=Y");
			} catch (Exception e) {
			}
		}  */
		else if (scheme.equals("hbridge") || scheme.equals("h")) {
			try {
				String server = isDev ? "dev" : "m";
				schemes.put(
						"11st",
						"http://"
								+ server
								+ ".enuri.com/mobilefirst/move2.jsp?vcode=5910&freetoken=outlink&url=http%3A%2F%2Fwww.11st.co.kr%2Fconnect%2FGateway.tmall%3Fmethod%3DXsite%26tid%3D1000997249");
				schemes.put("gmarket", "http://" + server
						+ ".enuri.com/mobilefirst/move2.jsp?vcode=536&freetoken=outlink&url=http%3A%2F%2Fwww.gmarket.co.kr%2Findex.asp%3Fjaehuid%3D200006254");
				schemes.put("g9", "http://" + server
						+ ".enuri.com/mobilefirst/move2.jsp?vcode=7692&freetoken=outlink&url=http%3A%2F%2Fm.g9.co.kr%2FDefault%2FHome%3Fjaehuid%3D200006436");
				//schemes.put("auction", "http://mobile.auction.co.kr/HomeMain?BCODE=BN00181187");
				schemes.put("auction", "http://" + server
						+ ".enuri.com/mobilefirst/move2.jsp?vcode=4027&freetoken=outlink&url=http%3A%2F%2Fbanner.auction.co.kr%2Fbn_redirect.asp%3FID%3DBN00181187");
				schemes.put(
						"interpark",
						"http://"
								+ server
								+ ".enuri.com/mobilefirst/move2.jsp?vcode=55&freetoken=outlink&url=http%3A%2F%2Fm.interpark.com%2FmobileGW.html%3Fsvc%3DShop%26bizCode%3DP14126%26url%3Dhttp%3A%2F%2Fm.shop.interpark.com");
				schemes.put(".emart", "http://" + server
						+ ".enuri.com/mobilefirst/move2.jsp?vcode=374&freetoken=outlink&url=http%3A%2F%2Fm.emart.ssg.com%2Fplanshop%2FplanShopBest.ssg%3Fckwhere%3Dm_enuri");

				schemes.put("shinsegaemall", "http://" + server
						+ ".enuri.com/mobilefirst/move2.jsp?vcode=47&freetoken=outlink&url=http%3A%2F%2Fm.shinsegaemall.ssg.com%2Fmall%2Fmain.ssg%3Fckwhere%3Ds_enuri");

				/////////////////////////////
				schemes.put("ssg",

				"http://" + server + ".enuri.com/mobilefirst/move2.jsp?vcode=6665&freetoken=outlink&url=http%3A%2F%2Fm.ssg.com%2F%3Fckwhere%3Ds_enuri");
				/////////////////////////////
				schemes.put(
						"gsshop",
						"http://"
								+ server
								+ ".enuri.com/mobilefirst/move2.jsp?vcode=75&freetoken=outlink&url=http%3A%2F%2Fwith.gsshop.com%2Fjsp%2Fjseis_withLGeshop.jsp%3Fmedia%3DPg%26gourl%3Dhttp%3A%2F%2Fm.gsshop.com");
				schemes.put("wemakeprice", "http://" + server
						+ ".enuri.com/mobilefirst/move2.jsp?vcode=6508&freetoken=outlink&url=https%3A%2F%2Fmw.wemakeprice.com%2Faffiliate%2Fbridge%3FchannelId%3D1000032");
				schemes.put("tmon", "http://" + server
						+ ".enuri.com/mobilefirst/move2.jsp?vcode=6641&freetoken=outlink&url=http%3A%2F%2Fm.ticketmonster.co.kr%2Fentry%2F%3Fjp%3D80025%26ln%3D214285");
				schemes.put("cjmall", "http://" + server
						+ ".enuri.com/mobilefirst/move2.jsp?vcode=806&freetoken=outlink&url=http%3A%2F%2Fdisplay.cjmall.com%2Fm%2Fmain%3Finfl_cd%3DI0580");
				schemes.put(
						"hyundaihmall",
						"http://"
								+ server
								+ ".enuri.com/mobilefirst/move2.jsp?vcode=57&freetoken=outlink&url=http%3A%2F%2Fwww.hyundaihmall.com%2Ffront%2FshNetworkShop.do%3FNetworkShop%3DHtml%26ReferCode%3D022%26Url%3Dhttp%3A%2F%2Fwww.hyundaihmall.com%2FHome.html");
				schemes.put("akmall", "http://" + server
						+ ".enuri.com/mobilefirst/move2.jsp?vcode=90&freetoken=outlink&url=http%3A%2F%2Fwww.akmall.com%2Fassc%2Fassociate.jsp%3Fassc_comp_id%3D26392");
				schemes.put("e-himart", "");
				schemes.put(
						"galleria",
						"http://"
								+ server
								+ ".enuri.com/mobilefirst/move2.jsp?vcode=6620&freetoken=outlink&url=http%3A%2F%2Fwww.galleria.co.kr%2Fcommon.do%3Fmethod%3Djoin%26channel_id%3D2764%26link_id%3D0001");
				schemes.put("okmall", "");
				schemes.put(
						".nsmall.com",
						"http://"
								+ server
								+ ".enuri.com/mobilefirst/move2.jsp?vcode=974&freetoken=outlink&url=http%3A%2F%2Fm.nsmall.com%2Fmjsp%2Fsite%2Fgate.jsp%3Fco_cd%3D190%26target%3Dhttp%3A%2F%2Fm.nsmall.com%2FMainView");
				/////////////////////////////
				schemes.put(
						"homeplus",
						"http://"
								+ server
								+ ".enuri.com/mobilefirst/move2.jsp?vcode=6361&freetoken=outlink&url=http%3A%2F%2Fwww.homeplus.co.kr%2Fapp.exhibition.main.PartnerMall.ghs%3Fextends_id%3Denuri%26service_cd%3D56080%26nextUrl%3Dhttp%3A%2F%2Fwww.homeplus.co.kr");

				schemes.put(
						"lottemart",
						"http://"
								+ server
								+ ".enuri.com/mobilefirst/move2.jsp?vcode=7455&freetoken=outlink&url=http%3A%2F%2Fm.lottemart.com%2Fmobile%2Fmobile_main.do%3FAFFILIATE_ID%3D01030001%26CHANNEL_CD%3D00056");
				/////////////////////////////

				schemes.put(".lotte.com", "http://" + server
						+ ".enuri.com/mobilefirst/move2.jsp?vcode=49&freetoken=outlink&url=http%3A%2F%2Fm.lotte.com%2Fmain_phone.do%3Fudid%3D%26cn%3D112346%26cdn%3D783491");
				schemes.put(
						"lotteimall",
						"http://"
								+ server
								+ ".enuri.com/mobilefirst/move2.jsp?vcode=663&freetoken=outlink&url=http%3A%2F%2Fwww.lotteimall.com%2Fcoop%2FaffilGate.lotte%3Fchl_no%3D140769%26chl_dtl_no%3D2540476");
				//신 엘롯데
				schemes.put(
						"ellotte",
						"http://"
								+ server
								+ ".enuri.com/mobilefirst/move2.jsp?vcode=6547&freetoken=outlink&url=https%3A%2F%2Fm.display.ellotte.com%2Fdisplay-mo%2Fshop%3FchnlNo%3D100023%26chnlDtlNo%3D1000023");
				//구 엘롯데
				//schemes.put("ellotte", "http://" + server
				//	+ ".enuri.com/mobilefirst/move2.jsp?vcode=6547&freetoken=outlink&url=http%3A%2F%2Fm.ellotte.com%2Fmain.do%3F%26cn%3D153348%26cdn%3D2942692");
				schemes.put("hnsmall", "http://" + server
						+ ".enuri.com/mobilefirst/move2.jsp?vcode=6588&freetoken=outlink&url=http%3A%2F%2Fm.hnsmall.com%2Fchannel%2Fgate%3Fchannel_code%3D20200");

				/////////////////////////////
				schemes.put(
						"coupang",
						"http://"
								+ server
								+ ".enuri.com/mobilefirst/move2.jsp?vcode=7861&freetoken=outlink&url=http%3A%2F%2Fwww.coupang.com%2FlandingMulti.pang%3Fsid%3DEnuri%26src%3D1033035%26spec%3D10305201%26addtag%3D400%26utm_source%3DEN%26utm_medium%3DEnuri_PCS%26utm_campaign%3DPC_EP%26forceBypass%3DY%26synd_meta%3DENURI%26homeLanding%3DY");

				/////////////////////////////
			} catch (Exception e) {
			}

		}

		else if (scheme.equals("redirect")) { // 이 url이면 수익코드가 붙은 홈페이지로 리다이렉트를 한다.
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
			} catch (Exception e) {
			}
		} else if (scheme.equals("my")) { // 마이페이지 url
			try {
				schemes.put("11st", "http://m.11st.co.kr/MW/MyPage/mypageMain.tmall");
				schemes.put("gmarket", "http://mmyg.gmarket.co.kr/home");
				schemes.put("g9", "http://m.g9.co.kr/MyPage.htm#/MyPage/PurchaseInfo");
				schemes.put("auction", "http://mmya.auction.co.kr/MyAuction/");
				schemes.put("interpark", "https://m.interpark.com/my/shop/index.html?b=1");
				schemes.put(".emart", "http://m.ssg.com/myssg/main.ssg?emart=");
				schemes.put("shinsegaemall", "http://m.ssg.com/myssg/main.ssg?shinsegaemall=");
				schemes.put("ssg", "http://m.ssg.com/myssg/main.ssg");
				schemes.put("gsshop", "http://m.gsshop.com/mygsshop/myOrderList.gs");
				schemes.put("wemakeprice", "http://m.wemakeprice.com/m/mypage/order_list/ship");
				schemes.put("tmon", "http://m.tmon.co.kr/mytmon/list");
				schemes.put("cjmall", "https://mw.cjmall.com/m/mycj/index.jsp?pic=MYZONE&app_cd=ENURI");
				schemes.put("hyundaihmall", "https://m.hyundaihmall.com/front/basktList.do");
				schemes.put("akmall", "https://m.akmall.com/mypage/OrderDeliInquiry.do");
				schemes.put("e-himart", "");
				schemes.put("galleria", "");
				schemes.put("okmall", "");
				schemes.put(".nsmall.com", "http://m.nsmall.com");
				schemes.put("homeplus", "http://m.homeplus.co.kr/mypage/main.do");
				schemes.put("lottemart", "");
				schemes.put(".lotte.com", "http://m.lotte.com/mylotte/m/mylotte.do");
				schemes.put("lotteimall", "https://securem.lotteimall.com/mypage/searchOrderListFrame.lotte");
				//신 엘롯데
				schemes.put("ellotte", "https://m.order.ellotte.com/order-mo/cart");
				//구 엘롯데
				//schemes.put("ellotte", "https://m.ellotte.com/mylotte/purchase/m/purchase_list.do");
				schemes.put("hnsmall", "https://securem.lotteimall.com/mypage/searchOrderListFrame.lotte");
				schemes.put("coupang", "http://m.coupang.com/m/my.pang");
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
				schemes.put("tmon", "");
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
		} else if (scheme.equals("o")) { // 로그아웃 url
			try {

				schemes.put("11st", "https://m.11st.co.kr/MW/Login/logout.tmall?type=");
				schemes.put("gmarket", "http://m.gmarket.co.kr/Login/logout.asp");
				schemes.put("g9", "https://apissl.g9.co.kr/api/Authentication/Logout");
				schemes.put("auction", "http://member.auction.co.kr/Authenticate/Logout.aspx");
				schemes.put("interpark", "http://m.interpark.com/auth/logout.html");
				schemes.put(".emart", "https://member.ssg.com/m/member/logout.ssg?retURL=http%3A%2F%2Fm.emart.ssg.com%2F");
				schemes.put("shinsegaemall", "https://member.ssg.com/m/member/logout.ssg?retURL=http%3A%2F%2Fm.shinsegaemall.ssg.com%2F");
				schemes.put("ssg", "https://member.ssg.com/m/member/logout.ssg?retURL=http%3A%2F%2Fm.ssg.com%2F");
				schemes.put("gsshop", "http://m.gsshop.com/member/logOut.gs");
				schemes.put("wemakeprice", "https://mw.wemakeprice.com/logout");
				//"call_ajax('GET','/m/member/logout',false,function(data){if(data['result']==1){window.location ='https://member.wemakeprice.com/m/member/login/'}else {alert(data['msg']);}});");
				schemes.put("tmon", "http://m.tmon.co.kr/user/logout");
				schemes.put("cjmall", "https://mw.cjmall.com/m/login/logout.jsp");
				schemes.put(".nsmall.com", "");
				schemes.put("homeplus", "http://m.homeplus.co.kr/identity/logout.do");
				schemes.put(".lotte.com", "http://m.lotte.com/login/logout.do");
				schemes.put("lotteimall", "https://securem.lotteimall.com/member/goLogout.lotte");
				//신 엘롯데
				schemes.put("ellotte", "https://m.members.ellotte.com/members-mo/logout");
				//구 엘롯데
				//schemes.put("ellotte", "http://m.ellotte.com/login/logout.do");

				schemes.put("coupang", "https://login.coupang.com/login/logout.pang");
				schemes.put("akmall", "http://m.akmall.com/login/Logout.do");
				schemes.put("hnsmall", "http://m.hnsmall.com/customer/logout");
				schemes.put("hyundaihmall", "https://m.hyundaihmall.com/front/smLogoutP.do?returnUrl=/front/index.do");
			} catch (Exception e) {
			}
		} else if (scheme.equals("p")) { // 쇼핑몰 vip 페이지 구분자
			try {
				schemes.put("11st", "prdno=;productbasicinfo.tmall");
				schemes.put("gmarket", "goodscode=;item");
				schemes.put("g9", "display/vip");
				schemes.put("auction", "/item/vip#/");
				// 				schemes.put("auction", "/vip#/");
				schemes.put("interpark", "/product/");
				schemes.put(".emart", "/item/itemview.ssg;itemid=");
				schemes.put("shinsegaemall", "/item/itemview.ssg;itemid=");
				schemes.put("ssg", "/item/itemview.ssg;itemid=");
				schemes.put("gsshop", "/prd/prd.gs;prdid=");
				schemes.put("wemakeprice", "/m/deal/adeal/");
				schemes.put("tmon", "/deal/");
				schemes.put("cjmall", "/m/item/;app_cd=");
				schemes.put("hyundaihmall", "/front/smitemdetailr.do;itemcode=");
				schemes.put("akmall", "/goods/goodsdetail.do;goods_id=");
				schemes.put("e-himart", "/productdetail.hmt;prditmid=");
				schemes.put("galleria", "/item/showitemdtl.do;item_id=");
				schemes.put("okmall", "/product/view.html;pid=");
				schemes.put(".nsmall.com", "m_g2600000m");
				schemes.put("homeplus", "/product/info.do;good_id=");
				schemes.put("lottemart", "/mobile/cate/pmwmcat0004_new.do;productcd=");
				schemes.put(".lotte.com", "/product/m/product_view.do;goods_no=");
				schemes.put("lotteimall", "/goods/viewgoodsdetail.lotte;goods_no=");
				schemes.put("ellotte", "/product/m/product_view.do;goods_no=");
				schemes.put("hnsmall", "/goods/view/");
				schemes.put("coupang", "/nm/products/");
			} catch (Exception e) {
			}
		} else if (scheme.equals("p2")) { // 쇼핑몰 vip 페이지 구분자
			try {
				schemes.put("auction", "ego.aspx;p==-=/vip");
				schemes.put("gsshop", "/deal/deal.gs;dealno=");
				schemes.put("wemakeprice", "mobile_app/direct_to_app");
				schemes.put("cjmall", "/m/mocode;app_cd=");
				schemes.put("coupang", "/vm/products/");
				schemes.put("ssg", "/item/itemdtl.ssg?itemid=");
			} catch (Exception e) {
			}
		} else if (scheme.equals("shopCode")) {
			try {
				schemes.put("11st", "5910");
				schemes.put("gmarket", "536");
				schemes.put("g9", "7692");
				schemes.put("auction", "4027");
				schemes.put("interpark", "55");
				schemes.put(".emart", "374");
				schemes.put("shinsegaemall", "47");
				schemes.put("ssg", "6665");
				schemes.put("gsshop", "75");
				schemes.put("wemakeprice", "6508");
				schemes.put("tmon", "6641");
				schemes.put("cjmall", "806");
				schemes.put("hyundaihmall", "57");
				schemes.put("akmall", "90");
				schemes.put("e-himart", "6252");
				schemes.put("galleria", "6620");
				schemes.put("okmall", "6427");
				schemes.put(".nsmall.com", "974");
				schemes.put("homeplus", "6361");
				schemes.put("lottemart", "7455");
				schemes.put(".lotte.com", "49");
				schemes.put("lotteimall", "663");
				schemes.put("ellotte", "6547");
				schemes.put("hnsmall", "6588");
				schemes.put("coupang", "7861");
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
				schemes.put("tmon", 11);
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
				schemes.put("tmon",
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
			/* if(siteName.equals("ticketmonster"))
				param = schemes.get("tmon").toString();
			else  */
			param = schemes.get(siteName).toString();
		} catch (Exception e) {
		}

		return param;
	}

	public JSONObject getSite(String siteName, String[] schemes, int version, String appName, String os, boolean isDev) {
		JSONObject site = new JSONObject();

		try {
			site.put("n", siteName);

			for (int i = 0; i < schemes.length; i++) {
				String param = getParam(siteName, schemes[i], version, appName, os, isDev);

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
	}%>