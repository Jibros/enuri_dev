<%@page import="java.util.*"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.json.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.lang.*"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%!String ver;
	String appName;
	String os;
	boolean isDev;
	int version;
	JSONObject defineJson = new JSONObject();
	JSONArray shopMainLogo;
	String imageDomain = "http://img.enuri.info";%>
<%
request.setCharacterEncoding("UTF-8");

ver = ChkNull.chkStr(request.getParameter("ver"), "0.0.0");
appName = ChkNull.chkStr(request.getParameter("app"), "enuri");
os = ConfigManager.RequestStr(request, "os", "");
isDev = request.getServerName().contains("dev.enuri.com") || request.getServerName().contains("stage1.enuri.com") ;
//isDev = false;
version = 0;
if (ver.length() >= 5) {
	try {
		version = Integer.parseInt(ver.substring(0, 1)) * 100 + Integer.parseInt(ver.substring(2, 3)) * 10
		+ Integer.parseInt(ver.substring(4, 5));
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
if (!(os.indexOf("aos") > -1 || os.indexOf("ios") > -1)) {
	out.print(os);
	return;
}

try {

	defineJson.put("andDefineList", getDefineJson(request.getServerName(), appName, version, os, isDev));

} catch (Exception e) {
	out.print(e.toString());
}
%>

<%!int Hex_IDINPUT = 0X00000000;
int Hex_EMAILINPUT = 0X00010000;

int Hex_LOGINDELAY_1 = 0X0000003c;
int Hex_LOGINDELAY_3 = 0X000000b4;
int Hex_LOGINDELAY_2 = 0X00000078;
int Hex_LOGINDELAY_6 = 0X00000168;
int Hex_LOGINDELAY_12 = 0X000002d0;

//현재 시간이 timeCheck시간 보다 작을때 true
public Boolean isTimeUnder(long timeCheck) {
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHH");
	long currentcheck = Long.parseLong(sdf.format(new Date()));
	if (timeCheck > currentcheck)
		return true;
	return false;
}

public Boolean isOkVersion(int aosVersion, int iosVersion) {
	if ((os.equals("aos") && version >= aosVersion) || (os.equals("ios") && version >= iosVersion)) {
		return true;
	} else
		return false;
}

public Boolean isMartStartVersion(String appName, int version, String os) {
	if (appName.equals("enuri")) {
		if (os.equals("aos")) {
			if (version > 364) {
				return true;
			}
			return false;
		} else if (os.equals("ios")) {
			if (version > 364) {
				return true;
			}
			return false;
		}
		return false;
	} else if (appName.equals("mart")) {
		return true;
	} else
		return false;
}

public JSONObject getDefineJson(String domain, String appName, int version, String os, boolean isDev) throws Exception {

	JSONObject defineJson = new JSONObject();

	defineJson.put("FOOTER_TITLE", "법적고지");
	defineJson.put("FOOTER", ((!(appName.equals("enuri") && version >= 341)) ? "\n" : "")
			+ "㈜써머스플랫폼은 통신판매 정보제공자로서 통신판매의 거래당사자가 아니며, 상품의 주문/배송/환불에 대한 의무와 책임은 각 쇼핑몰(판매자)에게 있습니다.\n\n㈜써머스플랫폼\n대표이사 : 김기록 |사업자등록번호 : 206-81-18164\n통신판매신고 : 2020-서울금천-1949호\n서울시 금천구 가산디지털1로 186, 제이플라츠빌딩 13층\n문의 : 02-6354-3601|master@enuri.com\n");

	if (appName.equals("enuri")) {
		if (version < 393)
			defineJson.put("FOOTER_OBJ", getJSONObjectfromFile(
					getServletContext().getRealPath("/") + "/mobilefirst/http/json/footer_2020.json"));
		else
			defineJson.put("FOOTER_OBJ", getJSONObjectfromFile(
					getServletContext().getRealPath("/") + "/mobilefirst/http/json/footer_2021.json"));
	}

	Date date = new Date();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	defineJson.put("version", formatter.format(date));
	defineJson.put("IMAGE_DOMAIN", imageDomain);
	defineJson.put("copyright", "Copyright ⓒ SummercePlatform Inc. All rights reserved.");

	shopMainLogo = getJSONArrayfromFile(
			"/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/http/json/shopMainLogo.json");

	if (appName.equals("enuri")) {
		setEnuriCoreDefaultInfo(defineJson, version, isDev); // 기본 정보 삽이
		setNufariData(defineJson, version);//누파리 정보 삽입
		setCardInfo(defineJson); // 카드 정보 삽입
		//if(isDev)
		setMcronyAD_Kosen(defineJson); //엠크로니 광고 삽입
		//else
		//	setMcronyAD(defineJson); //엠크로니 광고 삽입
		setSchemePass(defineJson);//아이폰 스킴 패스

		setMartInfo(defineJson);//마트 인포
		if (version >= 341)
			setCateListBottomIcon(defineJson, version);

		//에누리 브랜드 신규 등록 상품 순 정렬 생성
		setBrandCategory(defineJson);
		//하드코딩된 카테고리 정렬
		setHardCodingCategory(defineJson);

		setShoppingMalls(defineJson);
		setCategoryListIcon338(defineJson, os);//카테고리 리스트 아이콘

		if (version >= 400) {
			freetokenFilter(defineJson, os, version);
		}
		
		//"shopCode" 와 페어로 매핑되어있어야 한다. 
		ArrayList<String> siteNames = new ArrayList<String>();
		siteNames.add("11st");
		siteNames.add("gmarket");
		if (os.equals("aos") || (os.equals("ios") && version >= 377))
			siteNames.add("g9");
		siteNames.add("auction");
		siteNames.add("interpark");
		/////////////////////////////
		siteNames.add(".emart");//마트
		/////////////////////////////
		siteNames.add("shinsegaemall");
		siteNames.add("ssg");

		siteNames.add("gsshop");
		siteNames.add("wemakeprice");
		siteNames.add("tmon");
		siteNames.add("ticketmonster");
		//	siteNames.add("cjmall");
		siteNames.add("cjonstyle");
		siteNames.add("hmall");
		siteNames.add("akmall");
		siteNames.add("e-himart");
		siteNames.add("galleria");
		siteNames.add("okmall");
		siteNames.add(".nsmall.com");

		/////////////////////////////
		siteNames.add("homeplus");//마트
		if (isOkVersion(364, 365)) {
			siteNames.add("lotteon.=-=/lottemart=-=/product/LM");//마트
			//siteNames.add("lotteon.=-=/ellotte=-=/product/LE");//엘롯데	자동로그인은 3.6.5 부터 모두 들어감
		}
		/////////////////////////////

		siteNames.add("lotteon.");//롯데온

		//siteNames.add(".lotte.com");
		//siteNames.add("lottemart");
		siteNames.add("lotteimall");
		/* 	if(os.equals("aos") && version <= 364)//자동로그인 3.6.4 이하 버전에서만 들어감 lotteon.=-=/ellotte=-=/product/LE 이것과 충돌 안됨
				siteNames.add("ellotte"); */

		siteNames.add("hnsmall");
		/////////////////////////////
		siteNames.add("coupang");//마트
		/////////////////////////////
		siteNames.add("epost");
		siteNames.add("kyobo");
		siteNames.add("yes24");
		siteNames.add("aladin");
		siteNames.add("musinsa");
		if (isOkVersion(407, 407)) {
			siteNames.add("interpark=-=mbook");
		}
		siteNames.add("oliveyoung");
		siteNames.add("amoremall");
		/* 20201208 reward_shop_list.json 파일과 동일하게 수집하지 않는 리워드 쇼핑몰을 삭제함
		참고 :
			1.구글시트 [EMS PUSH 리스트]
			2.re 해당 부분 주석처리 (네이버 팜 스토어 리워드 수집 추가 건이 예상 됨으로 삭제하지 않음)
			3.getDefine_Core.jsp 3곳 수정함 20201208 검색
		- 손진욱
		if ( version >= 359) {
			// 네이버팜 스토어 리워드 수집
			//특이사항: move.jsp? 링크로 instore 구분 불가능 ... 리다이렉트 되는 링크에서 instore 구분 가능
			//		ios 경우 업데이트 없이 적용 가능하지만 Android의 경우 startWebView에서 "re"데이터를 파싱하는 부분이 있어서
			//		파싱하는 부분을 onStartPage로 옮김
			//siteNames.add("smartstore.naver.com/asmall19/");
			siteNames.add("smartstore.naver.com/inlstore/");
			if (isDev)
				siteNames.add("smartstore.naver.com/lgxnote/");
			if (isDev)
				siteNames.add("smartstore.naver.com/jojo/");
			if (isDev)
				siteNames.add("smartstore.naver.com/lgmedia/");
			if (isTimeUnder(2020092901)){
			//2020092901 까지만 서비스 됨
			siteNames.add("smartstore.naver.com/samsung_mall/");
			}
		}
		if (isDev)
			siteNames.add("feelway.com");
		*/

		//	 if (isDev)
		//	siteNames.add("smartstore.naver.com/guidecom/"); 

		//if(isDev)
		siteNames.add("skstoa.com");

		String[] schemes = { "etc", "re", "reCallPercent", "iosReCallPercent", "reLink", "reBypass", "renot","reDelay",
				"reCoDomain", "ic", "icb", "n", "f", "o", "l", "m", "j", "my", "popupCloseFunction", "h", "i", "t",
				"ld", "p", "p2", "lc", "lcmsg", "lcmsg_fail", "lc_timeOut", "lcJavascript", "shopCode", "lhtml",
				"hbridge", "uws", "isMart", "martParcelPay", "martPriority", "martCartCheckParam", "lBgSzUAgntChng",
				"martCartOK", "martCartFail", "martCartUrl", "martCartInsert", "martCartFail", "martMobileUrl",
				"martCartSoldoutMsg", "martCartTarget", "martFreeParcelPay", "oScript", "chkreturnurl", "loginskeepurl",
				"order", "i2021", "oScript2021", "snsList", "shopStatus", "setloginAgnt", "inputHint", "isCookie", "isRightSetting", "LRP", "LTO" };
		//20220719 iOS 전용 데이터 추가 
		String[] schemesiSO = {"stopst","iosSTWkWebView", "iosST2Setmall" };

		JSONObject ParamObj = new JSONObject();
		for (int i = 0; i < schemes.length; i++) {	
            ParamObj.put(schemes[i], getParam(domain, schemes[i], version, appName, os, isDev, siteNames));
		}
		
		//20220719 iOS 전용 데이터 추가 
		JSONObject ParamObjiOS = new JSONObject();
		if(os.equals("ios")){
			for (int i = 0; i < schemesiSO.length; i++) {	
				ParamObjiOS.put(schemesiSO[i], getParam(domain, schemesiSO[i], version, appName, os, isDev, siteNames));
			}
		}

		JSONArray sites = new JSONArray();
		for (int i = 0; i < siteNames.size(); i++) {
			if (siteNames.get(i).equals("galleria") /*|| siteNames[i].equals("lottemart")*/) {
				continue;
			}
			if (os.equals("ios") && version < 304) {
				if (siteNames.get(i).equals(".lotte.com") || siteNames.get(i).equals("ellotte")) {
					continue;
				}
			}

			JSONObject cell = new JSONObject();
			cell.put("n", siteNames.get(i));
			for (int j = 0; j < schemes.length; j++) {
				JSONObject scheme = ParamObj.getJSONObject(schemes[j]);
				if (scheme.has(siteNames.get(i)))
					cell.put(schemes[j], scheme.get(siteNames.get(i)));
			}
			
			//20220719 iOS 전용 데이터 추가
			if(os.equals("ios")){
				for (int j = 0; j < schemesiSO.length; j++) {
					JSONObject scheme = ParamObjiOS.getJSONObject(schemesiSO[j]);
					if (scheme.has(siteNames.get(i)))
						cell.put(schemesiSO[j], scheme.get(siteNames.get(i)));
				}
			}
			
			sites.put(cell);
		}

		defineJson.put("SITES", sites);

	} else if (appName.equals("mart")) { //마트 단독 앱 용 202005
		setNufariData(defineJson, version);//누파리 정보
		setCardInfo(defineJson); // 카드 정보
		setSchemePass(defineJson);//아이폰 스킴 패스
		setMartInfo(defineJson);//마트 인포

		ArrayList<String> siteNames = new ArrayList<String>();
		siteNames.add(".emart");//마트
		siteNames.add("homeplus");//마트
		siteNames.add("cjthemarket");//마트
		siteNames.add("gsfresh");//마트
		siteNames.add("lotteon.");//마트
		siteNames.add("coupang");//마트
		//siteNames.add("shinsegaemall");
		//siteNames.add("ssg");
		//siteNames.add("gsshop");
		//siteNames.add("cjmall");

		String[] schemes = { "etc", "ic", "icb", "n", "f", "o", "l", "m", "j", "my", "popupCloseFunction", "h", "i",
				"t", "ld", "p", "p2", "lc", "lcmsg", "lcJavascript", "shopCode", "lhtml", "hbridge", "uws", "isMart",
				"martParcelPay", "martPriority", "martCartCheckParam"

				, "martCartOK", "martCartFail", "martCartUrl", "martCartInsert", "martCartFail", "martMobileUrl",
				"martCartSoldoutMsg", "martCartTarget", "martFreeParcelPay", "oScript", "chkreturnurl",
				"loginskeepurl" };

		JSONObject ParamObj = new JSONObject();
		for (int i = 0; i < schemes.length; i++) {
			ParamObj.put(schemes[i], getParam(domain, schemes[i], version, appName, os, isDev, siteNames));
		}

		JSONArray sites = new JSONArray();
		for (int i = 0; i < siteNames.size(); i++) {

			JSONObject cell = new JSONObject();
			cell.put("n", siteNames.get(i));
			for (int j = 0; j < schemes.length; j++) {
				JSONObject scheme = ParamObj.getJSONObject(schemes[j]);
				if (scheme.has(siteNames.get(i)))
					cell.put(schemes[j], scheme.get(siteNames.get(i)));
			}
			sites.put(cell);
		}

		defineJson.put("SITES", sites);

	} else if (appName.equals("social")) {
		setSocialDefaultInfo(defineJson); // 기본 정보 삽이
		setCardInfo(defineJson); // 카드 정보 삽입
		setSchemePass(defineJson);//아이폰 스킴 패스

		ArrayList<String> siteNames = new ArrayList<String>();
		siteNames.add("11st");
		siteNames.add("gmarket");
		siteNames.add("g9");
		siteNames.add("auction");
		siteNames.add("interpark");
		siteNames.add(".emart");
		siteNames.add("shinsegaemall");
		siteNames.add("ssg");
		siteNames.add("gsshop");
		siteNames.add("wemakeprice");
		siteNames.add("tmon");
		siteNames.add("cjmall");
		siteNames.add("cjonstyle");
		siteNames.add("hmall");
		siteNames.add("akmall");
		siteNames.add("e-himart");
		siteNames.add("galleria");
		siteNames.add("okmall");
		siteNames.add(".nsmall.com");
		siteNames.add("homeplus");
		siteNames.add("lotteimall");
		siteNames.add("ellotte");
		siteNames.add("hnsmall");
		siteNames.add("coupang");

		String[] schemes = { "etc", "re", "reCallPercent", "iosReCallPercent", "reLink", "reBypass", "renot",
				"reCoDomain", "ic", "icb", "n", "o", "l", "m", "j", "my", "h", "i", "f", "t", "ld", "p", "p2", "lc",
				"lcmsg", "shopCode", "lhtml", "hbridge" };

		JSONObject ParamObj = new JSONObject();
		for (int i = 0; i < schemes.length; i++) {
			ParamObj.put(schemes[i], getParam(domain, schemes[i], version, appName, os, isDev, siteNames));
		}

		JSONArray sites = new JSONArray();
		for (int i = 0; i < siteNames.size(); i++) {
			if (siteNames.get(i).equals("galleria") || siteNames.get(i).equals("coupang")
					|| siteNames.get(i).equals("lottemart")) {
				continue;
			}
			if (os.equals("ios") && version < 304) {
				if (siteNames.get(i).equals(".lotte.com") || siteNames.get(i).equals("ellotte")) {
					continue;
				}
			}
			JSONObject cell = new JSONObject();
			cell.put("n", siteNames.get(i));
			for (int j = 0; j < schemes.length; j++) {
				JSONObject scheme = ParamObj.getJSONObject(schemes[j]);
				if (scheme.has(siteNames.get(i)))
					cell.put(schemes[j], scheme.get(siteNames.get(i)));
			}
			sites.put(cell);
		}
		defineJson.put("SITES", sites);
	}

	return defineJson;
}

//푸터 인기쇼핑몰 202005
public void setShoppingMalls(JSONObject defaultDefineInfo) {
	try {
		String shoppingMalls[] = { "536", "4027", "5910", "55", "6508", "6641", "7861", "7692", "75", "806", "663",
				"6588", "6665", "49", "57", "90", "6547", "974", "8830", "9011", "47", "7851", "58", "6252", "7455",
				"374", "6361", "6193", "7870", "7857", "7935", "7908", "23661", "8380", "15917", "7852", "8032", "6729",
				"24763", "30130" };
		JSONArray arrMalls = new JSONArray();
		for (int i = 0; i < shoppingMalls.length; i++) {
			arrMalls.put(shoppingMalls[i]);
		}
		defaultDefineInfo.put("SHOPPINGMALLS", arrMalls);
	} catch (Exception e) {
	}

}

//브랜드 카테고리 초기화(생성)202005
public void setBrandCategory(JSONObject defaultDefineInfo) {
	//에누리 브랜드 (신규등록 순으로 정렬 되어야 하는 카테고리 번호)
	try {
		String[] brandCateNumber = { "0425", "042550", "04255001", "04255002", "04255003", "04255004", "04255011",
				"04255012", "04255013", "04255014", "04255015", "042551", "04255101", "04255106", "04255107",
				"04255011", "04255111", "04255112", "04255113", "04255114", "04255115", "042552", "04255201",
				"04255202", "04255203", "04255204", "04255205", "04255211", "04255212", "04255213", "04255214",
				"04255102", "04255103", "04255104", "04255105", "04255108", "04255109" };

		//에누리 브랜드 JSONArray
		JSONArray brandCateNumberJson = new JSONArray();
		for (int i = 0; i < brandCateNumber.length; i++) {
			brandCateNumberJson.put(brandCateNumber[i]);
		}
		defaultDefineInfo.put("LP_FIRST_SORT_NEW", brandCateNumberJson);
	} catch (Exception e) {
	}
}

//하드코딩 카테고리 정렬
public void setHardCodingCategory(JSONObject defaultDefineInfo) {
	try {
		String[] hardCodingCate = { "0425", "1640", "040207" };

		//에누리 브랜드 JSONArray
		JSONArray HardcodingCateNumber = new JSONArray();
		for (int i = 0; i < hardCodingCate.length; i++) {
			HardcodingCateNumber.put(hardCodingCate[i]);
		}
		defaultDefineInfo.put("LP_HARDCODING_CATEGORY", HardcodingCateNumber);
	} catch (Exception e) {
	}
}

public void setCateListBottomIcon(JSONObject defaultDefineInfo, int version) {
	//enuri 3.4.1 버전 부터 적용
	try {

		String link[] = { "http://m.enuri.com/mobiledepart/Index.jsp?freetoken=main_tab|myeclub",
				"http://auto.enuri.com/m/car?freetoken=reborncar",
				//		"http://192.168.213.99/m/car?freetoken=reborncar",
				"http://m.enuri.com/mobiledepart/Index.jsp?freetoken=department&app=Y",
				"http://m.enuri.com/knowcom/index.jsp?freetoken=shoppingknow&app=Y",
				"http://m.enuri.com/deal/newdeal/index.deal?freetoken=social&app=Y",
				"http://m.flower365.com/category/cate_list.php?freetoken=outlink",
				"http://menuri.insvalley.com/mini/minsvalley.jsp?freetoken=outlink",
				"http://m.enuri.com/global/m/Index.jsp?freetoken=global" };

		String keyword[] = { "e클럽혜택", "자동차", "백화점 가격비교", "쇼핑지식", "소셜비교", "꽃배달", "보험", "해외직구" };
		String newTag[] = { "Y", "Y", "N", "N", "N", "N", "N", "N" };

		String icon[] = { imageDomain + "/images/mobilefirst/main/cate/aos/nonecate/btn_category_myeclub_1.png",
				imageDomain + "/images/mobilefirst/main/cate/aos/nonecate/btn_category_usedcar_1.png",
				imageDomain + "/images/mobilefirst/main/cate/aos/nonecate/btn_category_store.png",
				imageDomain + "/images/mobilefirst/main/cate/aos/nonecate/btn_category_shopping.png",
				imageDomain + "/images/mobilefirst/main/cate/aos/nonecate/btn_category_social.png",
				imageDomain + "/images/mobilefirst/main/cate/aos/nonecate/btn_category_flower.png",
				imageDomain + "/images/mobilefirst/main/cate/aos/nonecate/btn_category_insurance.png",
				imageDomain + "/images/mobilefirst/main/cate/aos/nonecate/btn_category_oversea.png" };

		JSONArray arr = new JSONArray();
		for (int i = 0; i < keyword.length; i++) {
			if (keyword[i].equals("백화점 가격비교") || keyword[i].equals("보험"))
				continue;

			//e클럽 탭 없는 하위 앱 미노출

			if (keyword[i].equals("e클럽혜택") && version < 400) {

				continue;
			}

			if (keyword[i].equals("소셜비교") && version >= 393) {
				continue;
			}

			JSONObject obj = new JSONObject();
			obj.put("key", keyword[i]);
			//freetoken reborncar 가 없는 버전 대응
			if (keyword[i].equals("자동차") && version < 359) {
				obj.put("link", "http://auto.enuri.com/m/car?freetoken=outbrowser");
			} else {
				obj.put("link", link[i]);
			}

			obj.put("icon", icon[i]);
			obj.put("new", newTag[i]);
			arr.put(obj);
		}

		//arr.put("icon_category_7.png");
		defaultDefineInfo.put("CATEBOTTOMICON", arr);

	} catch (Exception e) {
	}
}

public void setCategoryListIcon338(JSONObject defaultDefineInfo, String os) {
	//enuri 3.3.8 버전 부터 적용  ///2020년 ios 3.6.1 2019년 안드로이드 3.5.0 개편이후 사용하지 않음
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
			defaultDefineInfo.put("CATEICONS_PREURL", imageDomain + "/images/mobilefirst/main/cate/aos/");
		else
			defaultDefineInfo.put("CATEICONS_PREURL", imageDomain + "/images/mobilefirst/main/cate/ios/");
	} catch (Exception e) {
	}
}

public void setMcronyAD_Kosen(JSONObject defaultDefineInfo) {
	//m크로니 관련 링크 정의
	try {

		//lp top ad
		defaultDefineInfo.put("AD_LPTOP", "http://ad-api.enuri.info/enuri_M/m_lp/M3/bundle?bundlenum=3&cate=");
		defaultDefineInfo.put("AD_LPTOP_ADULT",
				"http://ad-api.enuri.info/enuri_M/m_adult/M3a/bundle?bundlenum=3&cate=");
		//footer ad
		defaultDefineInfo.put("AD_FOOTER", "http://ad-api.enuri.info/enuri_M/m_all/W2/bundle?bundlenum=3");

		defaultDefineInfo.put("AD_HOME_FLOATING", "http://ad-api.enuri.info/enuri_M/m_main/FA/bundle?bundlenum=2");
		//dim crm ad
		defaultDefineInfo.put("AD_CRM", "/api/eventAppCRM.jsp");

		defaultDefineInfo.put("AD_SHOPPINGNEWS", "http://ad-api.enuri.info/enuri_M/m_know/KA1/bundle?bundlenum=3");
		defaultDefineInfo.put("AD_SHOPPINGTIP", "http://ad-api.enuri.info/enuri_M/m_know/KA2/bundle?bundlenum=3");
		defaultDefineInfo.put("AD_TRANDWEBZINE", "http://ad-api.enuri.info/enuri_M/m_know/KA3/bundle?bundlenum=3");

		defaultDefineInfo.put("AD_LP_CENTER", "http://ad-api.enuri.info/enuri_M/m_lp/M31/bundle?bundlenum=3&cate=");
		defaultDefineInfo.put("AD_LP_CENTER_ADULT",
				"http://ad-api.enuri.info/enuri_M/m_adult/M31a/bundle?bundlenum=3&cate=");
		defaultDefineInfo.put("AD_SRP_TOP", "http://ad-api.enuri.info/enuri_M/m_srp/MS1/bundle?bundlenum=3");

	} catch (Exception e) {
	}
}

public int setMartInfo(JSONObject defaultDefineInfo) {
	//마트 관련 데이터
	try {
		defaultDefineInfo.put("MART_HOME_BANNERLINK", "");
		defaultDefineInfo.put("MART_HOME_BANNERIMAGE",
				imageDomain + "/images/mobilefirst/mart/mart_main_banner202005.png");
		defaultDefineInfo.put("MART_SEARCH_POPULAR", "false"); // 검색창 인기도 검색 노출 여부 -> 노출 true 비노출 false
		//찜 목록 에 상품이 없는 경우 노출되는 메세지 ... 마트 이름이 보여서 디파인에서 처리함
		defaultDefineInfo.put("MART_ZZIM_EMPTY_TOP_MSG",
				"이마트몰,쿠팡,홈플러스,롯데온\n4개의마트의 상품들을 모아 찜해두세요.\n어떤 마트의 상품이든\n하나의 찜 목록에 모아 관리할 수 있어요.");

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
		arrMallData.put("himartapp://");
		arrMallData.put("itms-appss://apps.apple.com/kr/app/id503522370");
		//arrMallData.put("coupang://product");

		defaultDefineInfo.put("schemepass", arrMallData);

		defaultDefineInfo.put("instapass", "www.instagram.com;/embed/captioned/");

	} catch (Exception e) {
	}

	return 0;
}

public void setNufariData(JSONObject defaultDefineInfo, int version) {
	String ifdomain = "enuri.com/mobilefirst";
	try {
		StringBuffer sb = new StringBuffer();
		sb.append("enuri.com/mobilefirst;");
		sb.append("http://enuri.sweettracker.net;");
		sb.append("enuri.com/deal/mobile/;");
		sb.append("enuri.com/deal/newdeal/;");
		sb.append("/mobiledepart;");
		sb.append("enuri.com/mobilenew;");
		sb.append("enuri.com/move/;");
		sb.append("enuri.com/event;");
		sb.append("enuri.com/;");
		sb.append("enuri.com/knowcom;");
		sb.append("https://nice.checkplus.co.kr;");
		sb.append("enuri.com/global;");
		sb.append("enuri.com/my/my_emoney_m.jsp;");
		sb.append("reborncar.co.kr/;");
		sb.append("://api.dable.io;");
		if (version >= 350)//3.5.0 도메인 개편 3세대 버전에서 vip 도메인이 바뀜
			sb.append("enuri.com/m/;");
		sb.append("100.100.100.234");

		defaultDefineInfo.put("OUTLINKURL", sb.toString());
		defaultDefineInfo.put("ISP_INFO_CLOSE", "N");
		defaultDefineInfo.put("GO_CLOSE", "close://");//Activity 종료 스킴
		defaultDefineInfo.put("GO_SHARE", "shareintent://");//공유 팝업 조건 스키마
		defaultDefineInfo.put("SHARE_TEXT", "sharetext:");//공유창 노출 조건
		defaultDefineInfo.put("SHARE_TEXT_TITLE", "공유");//공유 팝업 타이틀
		defaultDefineInfo.put("SHARE_TYPE", "text/plain");//공유 팝업 타입
		defaultDefineInfo.put("INTENT_PROTOCOL_START", "intent:");//ISP 결제시 리턴 값 파싱
		defaultDefineInfo.put("INTENT_PROTOCOL_INTENT", "#Intent;");//ISP 결제시 리턴 값 파싱
		defaultDefineInfo.put("INTENT_PROTOCOL_EN", ";end;");//ISP 결제시 리턴 값 파싱
		defaultDefineInfo.put("GOOGLE_PLAY_STORE_PREFIX", "market://details?id=");//isp Exception 시 마켓 전달용 프리픽스
		defaultDefineInfo.put("ENURI_GATE", "freetoken");//에누리 게이트 조건 파라메터
		defaultDefineInfo.put("ENURI_GETMOBILE", "enuri.com/mobilefirst/move.jsp");//누파리 무조건 이동 (move.jsp)
		defaultDefineInfo.put("BROWSER_OUT",
				"http&https&intent&enuri&eventdetailurl&shareintent&himartapp://&market://details?id=com.himart.main");//url에 포함되지 않으면 ActionView 호출
		defaultDefineInfo.put("EB_USE", true);//에누리 브라우져 사용 여부
		defaultDefineInfo.put("LOGOUT_ALERT", "아이디"); // iOS 로그인 실패 확인
		defaultDefineInfo.put("COMFAIL",
				"자동로그인&자동 로그인&아이디 찾기&비밀번호가 일치하지&아이디 저장&로그인 상태 유지&아이디 저장&자동로그인 설정&http%3A%2F%2Fmember.auction.co.kr%2FAuthenticate%2F%3Freturn_value%3D-1&loginResult('01'&\"success\":false&\"LoginResultEnum\":3&\"LoginResultEnum\":2&재시도&ssoFailYn=Y&아이디 또는 비밀번호를 다시 확인해주세요");//로그인 후 HTML에 포함되면 실패하는 조건

		//앱 설치 링크 호출 시 패키지 가져오는 정규식 market:\/\/details\?id=([\.]{0,3}[0-9a-zA-Z])* Java에서 정규식 오류로 UrlEncoding 을 함
		defaultDefineInfo.put("BROWSER_PASS_LINK_REGEXP",
				"market%3A%5C%2F%5C%2Fdetails%5C%3Fid%3D%28%5B%5C.%5D%7B0%2C3%7D%5B0-9a-zA-Z%5D%29%2A");
		//하이마트, 쿠팡앱 패키지 네임
		defaultDefineInfo.put("BROWSER_PASS_PACKAGE_LIST", "com.himart.main=-=com.coupang.mobile");

		defaultDefineInfo.put("NUFARI_EMONEY_POPUP", "구매 후 최대 30일내 적립 완료!");
		defaultDefineInfo.put("NUFARI_EMONEY_POPUP_DESC",
				"※ 참고해 주세요\n· 쇼핑적립은 적립 대상몰에서만 가능하며 1,000원 이상 구매 시 적립됩니다.\n· 쇼핑적립 e머니는 구매일로부터 10~30일간 취소/환불/교환/반품 여부를 확인하여 적립됩니다.\n· 쇼핑 금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등을 제외한 금액만 반영합니다.\n· 적립 e머니는 최소 10점부터 적립됩니다.\n자세한 적립 혜택 확인하기>");

		//20220223 누파리 팝업 자세한 적립 혜택 확인하기> 링크
		defaultDefineInfo.put("NUFARI_EMONEY_POPUP_BENEFIT", "/eclub/notice.jsp?freetoken=login_title");

	} catch (Exception e) {
	}
}

public int setEnuriCoreDefaultInfo(JSONObject defaultDefineInfo, int version, boolean isDev) {
	String ifdomain = "enuri.com/mobilefirst";
	try {
		//ios 쇼다 크롤링 딜레이 시간 정의
		if (isDev){
			//백그라운드 전체 돌기 시간제한 설정
			defaultDefineInfo.put("IOS_SHODA_TIMEDELAY", "1");
			//백그라운드 돌기 시간제한 걸어 리스트에 제외 처리 
			defaultDefineInfo.put("IOS_SHODA_DELIST", "1");			
			defaultDefineInfo.put("IOS_SHODA_ALLSTOP", "NO");
		}else {
			defaultDefineInfo.put("IOS_SHODA_TIMEDELAY", "6");
			defaultDefineInfo.put("IOS_SHODA_DELIST", "6");
			defaultDefineInfo.put("IOS_SHODA_ALLSTOP", "NO");
		}
	
		defaultDefineInfo.put("NewsBoxListDesc", "수신일로부터 30일이 지난 메시지는 자동으로 삭제됩니다.");//푸시리스트 페이지 메세지
		defaultDefineInfo.put("PersonalMessageListdesc",
				"최저가는 수시로 변경되므로, 즉시 방문하시는 것이 좋습니다.\n수신일로부터 30일이 지난 메시지는 자동으로 삭제됩니다.");//최저가 알림 페이지 메세지

		defaultDefineInfo.put("IF_DOMAIN", ifdomain);
		defaultDefineInfo.put("IF_MAIN_URL2", "enuri.com/mobilefirst/Index.jsp");//메인 Activity 이동 조건
		defaultDefineInfo.put("IF_BIG_IMAGE_URL", "enuri.com/mobilefirst/detailBigImage.jsp");//큰 상품 이미지 보기 넘어가는 조건
		defaultDefineInfo.put("IF_LOGIN_URL", ifdomain + "/login/");//로그인 Activity 이동 조건
		defaultDefineInfo.put("IF_LOGIN_URL2", "enuri.com/mobilenew/login/");//로그인 서브 Activity 이동 조건
		defaultDefineInfo.put("IF_LOGIN_URL3", "enuri.com/member/login/");//로그인 서브 Activity 이동 조건
		defaultDefineInfo.put("IF_DEPARTMENT_LINK", "enuri.com/mobiledepart/Index.jsp");//백화점  Activity 이동 조건
		defaultDefineInfo.put("IF_DEPARTMENT_DETAILPAGE", "enuri.com/mobiledepart/detail.jsp");//백화점 Activity 이동 조건
		defaultDefineInfo.put("IF_DETAIL_URL", "enuri.com/mobilefirst/detail.jsp?modelno=");//vip Activity 이동 조건
		defaultDefineInfo.put("IF_DETAIL_URL_3G", "enuri.com/m/vip.jsp?modelno=");
		defaultDefineInfo.put("IF_ETC_URL",
				"enuri.com/mobilefirst/event/eventWonList.jsp;enuri.com/mobilefirst/event/eventWonView.jsp");//ETCActivity 이동 조건
		defaultDefineInfo.put("IF_LIST_URL", "enuri.com/m/list.jsp");// LP Activity 이동 조건
		defaultDefineInfo.put("IF_SEARCH_URL", "enuri.com/m/search.jsp");//SRP Activity 이동 조건
		defaultDefineInfo.put("IF_NEWS_DETAIL", "enuri.com/mobilefirst/news_detail.jsp");//뉴스 Activity 이동 조건
		defaultDefineInfo.put("IF_EVENT_DETAIL", "enuri.com/mobilefirst/event");//이벤트 Activity 이동 조건
		defaultDefineInfo.put("IF_EVENT_DETAIL2", "enuri.com/mobilefirst/evt/");//이벤트 Activity 이동 조건
		defaultDefineInfo.put("IF_EVENT_GO", "enurievent=Y");//뉴스 Activity 이동 조건

		defaultDefineInfo.put("GO_EVENTDETAIL_KEYWORD", "eventdetailurl://");//이벤트에서 이벤트 디테일 페이지 넘어가는 스킴

		defaultDefineInfo.put("DETAIL_VIEWPORT", "");//상세보기 줌 표시 여부
		defaultDefineInfo.put("CATEGORY_MISE_ICON", "@");//카테 리스트 ㄴ 아이콘 표시 구분자

		defaultDefineInfo.put("DEAL_BRIDGE", "/deal/move.html");//소셜 브릿지 페이지 누파리 이동.
		defaultDefineInfo.put("VIP_BACK", "N");//VIP 웹뷰 goBack 사용 여부
		defaultDefineInfo.put("LP_BACK", "Y");//기획전 , lp웹 , Gnb웹 Back 사용 조건

		defaultDefineInfo.put("ICONURL", imageDomain + "/images/mobilefirst/browser/marketicon/");

		defaultDefineInfo.put("NUFARI_OUTLINK_INFO", "ISP, 결제오류 시 다른브라우저를 이용해보세요");//iOS isp 결제시 팝업 노출
		defaultDefineInfo.put("REVIEW_SIZE", "100");//누파리 리뷰 리스트 사이즈
		defaultDefineInfo.put("EMONEY_SHOW_AND_FLAG", "Y"); // 마이메뉴 이머니 카드 보여주는 조건
		defaultDefineInfo.put("EMONEY_INSERT_AND_FLAG", "Y");//이머니 수집 여부
		defaultDefineInfo.put("DEALCARDW", "640");//홈 딜 상품 사이즈 넓이
		defaultDefineInfo.put("DEALCARDH", "337");//홈 딜 상품 사이즈 높이
		defaultDefineInfo.put("ADULTIMG", imageDomain + "/images/mobilenew/images/img_19.jpg");
		defaultDefineInfo.put("NEWS_BYPASS_URL", "gamemeca;");//iOS 뉴스에서 링크포함 조건이 맞으면 통과
		defaultDefineInfo.put("MYPAGE_AOS_CERTIFY_SHOW_YN", "Y");//본인 인증 여부 카드 노출 조건
		defaultDefineInfo.put("MYPAGE_IOS_CERTIFY_SHOW_YN", "Y");//iOS 마이메뉴 휴대폰 본인인증 메뉴 표시 여부

		// 마이페이지 인증 배너 시작 날짜
		defaultDefineInfo.put("MYPAGE_CERTIFY_SHOW_BANNER_DATE", "20170327000000");
		defaultDefineInfo.put("MYPAGE_CERTIFY_SHOW_BANNER_BGCOLOR", "FFF4D7");
		defaultDefineInfo.put("MYPAGE_CERTIFY_SHOW_BANNER_IMAGE",
				imageDomain + "/images/mobilefirst/appImage/mypage/mypage_banner_wemake.png");
		defaultDefineInfo.put("MYPAGE_CERTIFY_SHOW_BANNER_LINK",
				"http://m.enuri.com/mobilefirst/http/emoney_benefit.jsp?freetoken=event");
		//마이페이지 쿠폰샵 배너
		defaultDefineInfo.put("MYPAGE_COUPONSHOP_BANNER_IMAGE",
				imageDomain + "/images/mobilefirst/appImage/mypage/ban_emoney_shop.png");
		defaultDefineInfo.put("MYPAGE_COUPONSHOP_BANNER_BGCOLOR", "CCE9FF");
		defaultDefineInfo.put("MYPAGE_COUPONSHOP_BANNER_LINK", "");
		//마이페이지 2019 운영 배너
		defaultDefineInfo.put("MYPAGE_SHOW_BANNER_SHOW_YN", "Y");
		defaultDefineInfo.put("MYPAGE_SHOW_BANNER_BGCOLOR", "#CCE9FF");
		defaultDefineInfo.put("MYPAGE_SHOW_BANNER_IMAGE",
				imageDomain + "/images/mobilefirst/appImage/mypage/mypage_banner.png");
		defaultDefineInfo.put("MYPAGE_SHOW_BANNER_LINK",
				"http://m.enuri.com/mobilefirst/http/emoney_benefit.jsp?freetoken=event");

		defaultDefineInfo.put("CPC_JOIN_LINK", "https://ad.esmplus.com");//CPC 가입하기 링크 (없으면 안나옴)
		defaultDefineInfo.put("11ST_JOIN_LINK", "https://adoffice.11st.co.kr");//CPC 가입하기 링크 (없으면 안나옴)
		defaultDefineInfo.put("POWERSHOPPING_JOIN_LINK", "http://m.searchad.naver.com/product/shopProduct");//파워쇼핑 가입하기
		defaultDefineInfo.put("POWERLINK_JOIN_LINK", "http://m.searchad.naver.com/product/shopProduct");//파워링크 가입하기
		defaultDefineInfo.put("TRENDWEBZINE_IMAGE_ORIGINAL", "N");//트렌드 웹진 이미지 높이 고정(N)
		defaultDefineInfo.put("ERROR_LOG_OVERVERSION", "337"); //에러로그 전송 가능 버전은 3.3.8 이상인 버전 전송함
		defaultDefineInfo.put("ERROR_LOG_STOPWORKVERSION", "337");//337;340ERROR_LOG_OVERVERSION에 포함되지만 특별히 제외버전

		defaultDefineInfo.put("APPSTORE_REVIEW_DATA", "3=-=180");//3번째 6개월에 한번씩 //0=-=0이면 무시한다

		defaultDefineInfo.put("BOTTOM_CATE_EXR_SEQ", "11200;11600");

		defaultDefineInfo.put("ZZIMWEBVIEWLINK", "mobilefirst/resentzzim/resentzzimList.jsp?listType=2");
		defaultDefineInfo.put("RECENTWEBVIEWLINK", "mobilefirst/resentzzim/resentzzimList.jsp?listType=1");

		defaultDefineInfo.put("WINDOWOPENCLOSE",
				"VipViewController;" + "EventViewController;" + "Enuri2.EventViewSubController;"
						+ "ShoppingKnowViewController;"// + "Enuri2.ShoppingKnowViewSubController;"
						+ "EmoneyViewController;" + "Enuri2.EmoneyViewSubController;" + "Enuri2.GlobalViewController;"
						+ "Enuri2.RebornViewController;" + "PlanListViewController;"
						+ "Enuri2.PlanListViewSubController;" + "SocialDepartmentController;"
						+ "Enuri2.SuperMarketVipViewController;"+ "Enuri2.BrandStoreViewController;"+ "Enuri2.BrandStoreRankingViewController");
		defaultDefineInfo.put("WINDOWOPENCLOSEANDOPEN", "");// 윈도우 오픈 사용안하는 뷰컨트롤러지만 필요한 링크가 있으면 추가하면된다 최대한 상세한 링크 필요함";");

		//202001 마이페이지 OM팀 이머니 혜택 텍스트배너
		defaultDefineInfo.put("MYPAGE_OM_BANNER_TEXT", "최저가는 기본! 더 강력해진 e머니 구매혜택");
		defaultDefineInfo.put("MYPAGE_OM_BANNER_LINK",
				"http://m.enuri.com/mobilefirst/evt/smart_benefits.jsp?freetoken=event");
		//202001이머니 디테일 , 유의사항 문구
		defaultDefineInfo.put("MYPAGE_EMONEY_DETAIL_NOTICE_TEXT",
				"- 주문금액은 배송비, 쿠폰적용을 제외한 금액입니다.\n- 실제 적립금액은 변경될 수 있습니다.\n- e머니 적립 제외 카테고리의 상품을 구매하신 경우 적립되지 않습니다.");
		//202005 스마트쇼핑 약관페이지
		defaultDefineInfo.put("SMART_SHOPPING_TERMS",
				"http://m.enuri.com/mobilefirst/http/smart_shopping_connect.html");
		//202007 스피드장보기 VIP상세보기 법적고지
		defaultDefineInfo.put("ENURIMART_VIPDETAIL_RULES",
				"스피드장보기는 공개된 자료를 기반으로 상품정보를 제공합니다.\n쇼핑몰에서 제공하는 상품정보와 다를 수 있으니, 구매 전 쇼핑몰의 상품정보를 다시 한 번 확인해 주세요. (법적고지보기)");
		defaultDefineInfo.put("ENURIMART_VIPDETAIL_RULES_LINK",
				"http://m.enuri.com/mobilefirst/login/ruleWrap.jsp?cssType=agreeWrap&freetoken=login_sub");
		defaultDefineInfo.put("ENURIMART_ADDCARTTIME", 100);
		defaultDefineInfo.put("ENURIMART_ADDCARTTIME_PER_GOODS", 15);//스피드 장보기 장바구니 담기 상품마다 타임아웃
		defaultDefineInfo.put("ENURIMART_CALL_JAVASCRIPT", 4);//스피드 장보기 장바구니 담기 스크립트 호출 타임아웃
		//202009 메인 탭바 장보기툴팁 보여지는 파라미터
		defaultDefineInfo.put("MAIN_ENURIMART_TOOLTIP_SHOW", "202101010000");
		//202011 LP/SRP 탭바 찜툴팁 보여지는 파라미터
		defaultDefineInfo.put("ZZIM_TOOLTIP_SHOW", "202101010000");
		//20201030 누파리에서 웹뷰에 강제로 세팅변경을 줘야 하는 경우의 필터 url  (=-=로 array)
		defaultDefineInfo.put("NUARI_WEBVIEW_FILTER_URLLIST", "youtu.be=-=youtube.com");
		//202109 LP스마트파인더 툴팁뷰
		defaultDefineInfo.put("LP_SMARTFINDER_TOOLTIP_SHOW", "202010290000");
		//202111 딥링크 이벤트페이지 호출 >>
		defaultDefineInfo.put("IF_EVENT_DETAIL3",
				"enuri.com/mobilefirst/evt;enuri.com/mobilefirst/event;enuri.com/m/event");
		//202201 마이이클럽 즉시적립상세페이지 주의사항
		defaultDefineInfo.put("ECLUB_CAUTIONS", getEclubCaustions());
		//회원가입 링크 
		defaultDefineInfo.put("MEMBER_JOIN", "/member/join/join.jsp");
		//브랜드 스토어 랭킹 페이지
		if(isDev){
			defaultDefineInfo.put("BRANDSTORE_RANKING_URL", "http://dev.enuri.com/m/brandRecom.jsp?freetoken=brandstore_recom");			
		}else{
			defaultDefineInfo.put("BRANDSTORE_RANKING_URL", "http://m.enuri.com/m/brandRecom.jsp?freetoken=brandstore_recom");
		}
		
		try{
			//Android ver 4.0.7 이상 
			//웹뷰를 가진 Activity에서 기본 WebViewManager를 사용할때 
			//새창열기를 적용할수 있게 처리
			JSONArray aJarr = new JSONArray();
			aJarr.put(new JSONObject().put("screen","ShoppingKnowActivity"));
			defaultDefineInfo.put("A_WINDOWOPEN_ENABLE_LIST", aJarr);
		}catch(Exception e){
			
		}
		
		try{
			/**
			4.0.8
			20220523 누파리혹은 외부 브라우져 갈때 t1 pd 붙여야 될 링크 조건 추가 
			*/
			JSONArray aJarr = new JSONArray();
			aJarr.put("/brandstore/move.jsp");
			defaultDefineInfo.put("ADDPARAM_T1PD", aJarr);
		}catch(Exception e){
			
		}
		

	} catch (Exception e) {
	}

	return 0;
}

public int setSocialDefaultInfo(JSONObject defaultDefineInfo) {
	String ifdomain = "enuri.com/deal";
	try {

		defaultDefineInfo.put("NewsBoxListDesc", "수신일로부터 30일이 지난 메시지는 자동으로 삭제됩니다.");
		defaultDefineInfo.put("PersonalMessageListdesc",
				"최저가는 수시로 변경되므로, 즉시 방문하시는 것이 좋습니다.\n수신일로부터 30일이 지난 메시지는 자동으로 삭제됩니다.");
		defaultDefineInfo.put("OUTLINKURL",
				"enuri.com/mobilefirst;http://enuri.sweettracker.net;enuri.com/deal/mobile/;enuri.com/deal/newdeal/;/mobiledepart;enuri.com/mobilenew;enuri.com/move/;enuri.com/event;enuri.com/knowcom;https://nice.checkplus.co.kr;100.100.100.234;enuri.com/global;enuri.com/my/my_emoney_m.jsp");

		defaultDefineInfo.put("OUTLINKURL_IOS", "dev.enuri.com;m.enuri.com;dis.as.criteo.com;widerplanet.com");
		defaultDefineInfo.put("IF_DOMAIN", ifdomain);
		defaultDefineInfo.put("IF_ALL_MENU", ifdomain + "/layerMenu_ajax.jsp");
		defaultDefineInfo.put("IF_MAIN_URL", "enuri.com/deal/newdeal/index.deal");
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
		defaultDefineInfo.put("IF_ETC_URL",
				"enuri.com/mobilefirst/event/eventWonList.jsp;enuri.com/mobilefirst/event/eventWonView.jsp");
		defaultDefineInfo.put("IF_LIST_URL", "enuri.com/m/list.jsp");
		defaultDefineInfo.put("IF_SEARCH_URL", "enuri.com/m/search.jsp");
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
		defaultDefineInfo.put("ICONURL", imageDomain + "/images/mobilefirst/browser/marketicon/");

		defaultDefineInfo.put("EB_USE", true);//에누리 브라우져 사용 여부
		defaultDefineInfo.put("ISP_SCHEME", "ispmobile://");//"?TID="); // 에누리 브라우저에서 ISP결제시 URL체크 IOS에서 사용
		defaultDefineInfo.put("IOS_LOGIN_LIMITE", "10"); // ajax로만 동작하는 쇼핑몰에서는 로그아웃을 확인하기가 힘듬, 따라서 타임아웃으로 결정함
		defaultDefineInfo.put("IOS_LOGOUT_LOGIN_INFO_DEL", "Y"); // IOS에서 로그아웃 할때 쇼핑몰들의 로그인 정보를 삭제할지를 결정하는 플래그 Y:삭제
		defaultDefineInfo.put("LOGOUT_ALERT", "아이디"); //
		defaultDefineInfo.put("COMFAIL",
				"자동로그인&자동 로그인&아이디 찾기&비밀번호가 일치하지&아이디 저장&로그인 상태 유지&아이디 저장&자동로그인 설정&http%3A%2F%2Fmember.auction.co.kr%2FAuthenticate%2F%3Freturn_value%3D-1&loginResult('01'&\"success\":false&\"LoginResultEnum\":3&\"LoginResultEnum\":2&재시도&ssoFailYn=Y&아이디 또는 비밀번호를 다시 확인해주세요");//에누리 브라우져 사용 여부
		defaultDefineInfo.put("COMFAIL_IOS",
				"document.getElementById('divMessageForInvalidPWD').textContent&document.getElementById('layerPopup').getElementsByClassName('login_layer')[0].textContent&다시 입력해주세요.&document.getElementById('webkit-xml-viewer-source-xml').textContent");//쇼핑몰 로그인 체크 ios

		// 마이페이지 리워드 관련 옵션
		defaultDefineInfo.put("REWARD_SHOW_AND_FLAG", "Y"); // AND 마이페이지에서 리워드정보를 보여줄지
		defaultDefineInfo.put("REWARD_SHOW_IOS_FLAG", "Y"); // IOS 마이페이지에서 리워드정보를 보여줄지
		defaultDefineInfo.put("REWARD_GUIDE_FLAG", "Y"); // 리워드 가이드를 보여줄지
		defaultDefineInfo.put("REWARD_BANNER_URL", imageDomain + "/images/mobilefirst/reward/mobile/reward_off_banner");
		defaultDefineInfo.put("REWARD_BANNER_LINK_URL", "/mobilefirst/event/benefit.jsp");//ios 마이메뉴 , 누파리 자세히보기 3.0.1까지 이렇게 되고 이후로는 and와 맞춤 // and 마이메뉴 링크
		defaultDefineInfo.put("REWARD_DETAIL_INFO_LINK",
				"http://m.enuri.com/mobilefirst/event/benefit.jsp?freetoken=event&app=Y"); // and 자세히 보기 링크
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
		defaultDefineInfo.put("EMONEY_DETAIL_INFO_LINK",
				"http://m.enuri.com/mobilefirst/event2016/allpayback_201610.jsp?freetoken=event&app=Y"); // and 자세히 보기 링크

		defaultDefineInfo.put("DEALCARDW", "640");
		defaultDefineInfo.put("DEALCARDH", "337");

		defaultDefineInfo.put("ADULTCATE", "1640;");
		defaultDefineInfo.put("ADULTIMG", imageDomain + "/images/mobilenew/images/img_19.jpg");

		// iOS 뉴스 디테일에서 bypass해야 할 URL
		defaultDefineInfo.put("NEWS_BYPASS_URL", "gamemeca;");

		// 마이페이지 인증 show Y/N
		defaultDefineInfo.put("MYPAGE_AOS_CERTIFY_SHOW_YN", "Y");
		defaultDefineInfo.put("MYPAGE_IOS_CERTIFY_SHOW_YN", "Y");

		// 마이페이지 인증 배너 시작 날짜
		defaultDefineInfo.put("MYPAGE_CERTIFY_SHOW_BANNER_DATE", "20170327000000");
		defaultDefineInfo.put("MYPAGE_CERTIFY_SHOW_BANNER_BGCOLOR", "FFF4D7");
		defaultDefineInfo.put("MYPAGE_CERTIFY_SHOW_BANNER_IMAGE",
				imageDomain + "/images/mobilefirst/appImage/mypage/mypage_banner_wemake.png");
		defaultDefineInfo.put("MYPAGE_CERTIFY_SHOW_BANNER_LINK",
				"http://m.enuri.com/mobilefirst/http/emoney_benefit.jsp?freetoken=event");

		defaultDefineInfo.put("CPC_JOIN_LINK", "https://ad.esmplus.com");
		defaultDefineInfo.put("TRENDWEBZINE_IMAGE_ORIGINAL", "N");

		//ios에서도 적용 필수 3.3.8 버전 부터 적용
		defaultDefineInfo.put("ERROR_LOG_OVERVERSION", "337"); //에러로그 전송 가능 버전은 3.3.8 이상인 버전 전송함
		defaultDefineInfo.put("ERROR_LOG_STOPWORKVERSION", "337");//337;340ERROR_LOG_OVERVERSION에 포함되지만 특별히 제외버전

		defaultDefineInfo.put("ENURILOGIN_SHOP_ICON_PREURL", imageDomain + "/images/mobilefirst/browser/marketicon/");

		defaultDefineInfo.put("APPSTORE_REVIEW_DATA", "3=-=180");//3번째 6개월에 한번씩 //0=-=0이면 무시한다

	} catch (Exception e) {
	}

	return 0;
}

public int setCardInfo(JSONObject defineInfo) {
	String[] cardDataList = { "hdcard", "mpocket", "lotte", "smshin", "kb-acp", "hanaansim", "shinhan-sr",
			"ispmobile" };
	String[] m = { "market://details?id=com.hyundaicard.appcard", "market://details?id=kr.co.samsungcard.mpocket",
			"market://details?id=com.lotte.lottesmartpay", "market://details?id=com.shcard.smartpay",
			"market://details?id=com.kbcard.cxh.appcard", "market://details?id=com.ilk.visa3d",
			"market://details?id=com.shcard.smartpay", "market://details?id=kvp.jjy.MispAndroid320" };
	String[] i = { "hdcardappcardansimclick", "mpocket.online.ansimclic", "lottesmartpay", "smshinhanansimclick",
			"kb-acp", "hanaansim", "shinhan-sr-ansimclick", "ispmobile" };

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

public JSONObject getParam(String domain, String scheme, int version, String appName, String os, boolean isDev,
		ArrayList<String> siteNames) {

	JSONObject schemes = new JSONObject();
	if (scheme.equals("isMart")) {//마트쇼핑몰인지 여부
		try {
			schemes.put("homeplus", true);//homeplus
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", true);//lottemart
			schemes.put(".emart", true);//ssg
			schemes.put("coupang", true);

		} catch (Exception e) {
		}
	}

	else if (scheme.equals("martFreeParcelPay")) {//무료배송 가능 주문 금액
		try {
			schemes.put("homeplus", "40000");
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", "40000");
			schemes.put(".emart", "40000");
			//쿠팡은 무료배송이 없다 무조건 3000원 배송비 항상 노출 (쿠팡은 배송비 도달 상태바 노출 안함)
			schemes.put("coupang", "999999999");
		} catch (Exception e) {
		}
	} else if (scheme.equals("martParcelPay")) {//무료배송 도달 안될시 배송비
		try {
			schemes.put("homeplus", "3000");
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", "3000");
			schemes.put(".emart", "3000");
			schemes.put("coupang", "3000");
		} catch (Exception e) {
		}
	}
	/* 20200603 PRD에서 해당 내용 삭제됨
	else if  (scheme.equals("martParcelTime")){//주문 마감 시간
		try{
			schemes.put("homeplus", "오늘 출발 (16시 주문 마감)");
			schemes.put("lotteon.", "오늘 출발 (16시 주문 마감)");
			schemes.put(".emart", "오늘 출발 (16시 주문 마감)");
			schemes.put("coupang", "오늘 출발 (16시 주문 마감)");
		}catch(Exception e){
		}
	}
	else if (scheme.equals("martParcelPayDesc")){//무료배송 상품 가격 안내 문구
		try{
			schemes.put("homeplus", "홈플러스 4만원이상 무료배송");
			schemes.put("lotteon.", "롯데마트 4만원이상 무료배송");
			schemes.put(".emart", "이마트몰 4만원이상 무료배송");
			schemes.put("coupang", "이마트몰 4만원이상 무료배송");
		}catch(Exception e){
		}
	}*/

	else if (scheme.equals("martPriority")) {//마트 노출 순서
		try {
			schemes.put(".emart", 1);
			schemes.put("coupang", 2);
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", 4);
			schemes.put("homeplus", 3);
		} catch (Exception e) {
		}
	}
	/* else if (scheme.equals("martBbsPer")){//마트 bbs
		try{
			schemes.put("homeplus", 20); // 100점 만점/20
			schemes.put("lotteon.", 2); // 10점 만점/2
			schemes.put("cjthemarket", 1);// 5.0 만점/1
			schemes.put("gsfresh", 1);//없음
			schemes.put(".emart", 1);//5.0 만점/1
			schemes.put("coupang", 1);//5.0 만점/1
		}catch(Exception e){
		}
	} */

	/* ic 값 과   isMart 값을 조합해서 사용하자
	ic에서 통합했는데 여기서 또 나누지 않을려고한다
	else if (scheme.equals("martic")) {
			try {
				schemes.put(".emart", "app_icon_emart_20200422");
				schemes.put("lotteon.", "app_icon_lottemart_20200422"); //mart
				schemes.put("homeplus", "app_icon_homeplus_20200422"); //마트
				schemes.put("cjthemarket", "app_icon_themarket_20200422"); //마트
				schemes.put("gsfresh", "app_icon_gsfresh_20200422"); //마트
			} catch (Exception e) {
			}
	
		} */
	/**
	POPUP - 팝업에서 성공 확인  . 팝업내용이 포함되어 있으면 성공
	JAVASCRIPT - martCartInsert 호출 리턴값이 1이면 성공
	 */
	else if (scheme.equals("martCartOK")) {//확인 방법  POPUP
		try {
			schemes.put(".emart", "POPUP=-=장바구니에 상품이 담겼습니다=-=상품을 장바구니에 담았습니다=-=장바구니에 상품을 담았습니다.");
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", ""); //mart
			schemes.put("homeplus", "POPUP=-=주문 가능합니다"); //마트
			schemes.put("coupang", ""); //mart
		} catch (Exception e) {
		}
	} else if (scheme.equals("martCartCheckParam")) {//리턴 밸류 확인값, javascript 함수 호출 인지 injection결과값인지
		try {
			schemes.put(".emart", "javascript");
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", "method"); //mart
			schemes.put("homeplus", "method");
			schemes.put("coupang", "method"); //mart
		} catch (Exception e) {
		}
	}
	/**
		POPUP - 팝업에서 성공 확인  . 팝업내용이 포함되어 있으면 실패
		JAVASCRIPT - martCartInsert 호출 리턴값이 1이 아니면 실패
	 */
	else if (scheme.equals("martCartFail")) {//확인 방법
		try {
			schemes.put(".emart", "POPUP=-=최대주문수량이=-=선택 가능한 최대 수량은=-=옵션을");
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", ""); //mart 1이 아니면 실패
			schemes.put("homeplus", ""); //마트
			schemes.put("coupang", "popup=-=이상이어야 합니다"); //마트 1이 아니면 실패
		} catch (Exception e) {
		}
	} else if (scheme.equals("martCartSoldoutMsg")) { //장바구니에서 넣는순간 품절일 경우
		try {
			schemes.put(".emart", "최소 주문가능=-=품절");
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", "품절"); //mart
			schemes.put("homeplus", "품절"); //마트
			schemes.put("coupang", "이상이어야 합니다"); //마트
		} catch (Exception e) {
		}

	} else if (scheme.equals("martCartUrl")) {
		try {
			schemes.put(".emart", "https://pay.ssg.com/m/cart/dmsShpp.ssg?enuriget=.emart");// 치환
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", "https://www.lotteon.com/p/order/cart/viewCart"); //mart
			schemes.put("homeplus", "https://mescrow.homeplus.co.kr/home/cart/cartList"); //마트
			schemes.put("coupang", "https://cart.coupang.com/cartView.pang"); //mart
		} catch (Exception e) {
		}
	}

	/**
		iOS 치환해서 사용
		window.android.onFailAddCart() -> webkit.messageHandler.martios.postMessage('cartFail')
		window.android.onSuccessAddCart() -> webkit.messageHandler.martios.postMessage('cartOk')
	 */
	else if (scheme.equals("martCartInsert")) {
		try {
			StringBuilder sb = new StringBuilder();
			sb.append("(function() {\n");
			sb.append("	  if (document.querySelector('#buy-button > button.addcart').style.display == 'none')\n");
			sb.append("     {\n");
			sb.append("         window.android.onFailAddCart();\n");
			sb.append("      	  return ;\n");
			sb.append("     } \n");
			sb.append("	  var cnt = '0';\n");
			sb.append("	  try {\n");
			sb.append("	    cnt = document.querySelector('#gnbCartCnt').textContent;\n");
			sb.append("	  } catch {}\n");
			sb.append("	  document.querySelector('#buy-button > button.addcart').click();\n");
			sb.append("	  setTimeout(function() {\n");
			sb.append("	      var temp = '0';\n");
			sb.append("	      try {\n");
			sb.append("	        temp = document.querySelector('#gnbCartCnt').textContent;\n");
			sb.append("	      } catch {}\n");
			sb.append("	      if (temp != cnt)\n");
			sb.append("	      {\n");
			sb.append("	        window.android.onSuccessAddCart();\n");
			sb.append("	      }else {\n");
			sb.append("	        window.android.onFailAddCart();\n");
			sb.append("	      }\n");
			sb.append("	    }, 500)\n");
			sb.append("	})()\n");
			schemes.put("coupang", sb.toString());

			schemes.put(".emart", "javascript:{fn_SaveCart(this, 'cart', 'floating');}");
			sb.setLength(0);
			sb.append("javascript: {\n");
			sb.append("       try {\n");
			sb.append("         var number = '0'\n");
			sb.append("         try {\n");

			sb.append(
					"           number = document.querySelector('#mainLayout > header > div > div > a > span.number').textContent;\n");

			sb.append("         } catch {\n");

			sb.append("        }\n");
			sb.append(
					"        document.querySelector('#mainLayout > div.actionBar.productDetail > div.actionButtonWrapper > div > button:nth-child(1)').click();\n");
			sb.append("        setTimeout(function() {\n");
			sb.append(
					"          if (document.querySelector('#mainLayout > div.actionBar.active.productDetail > div.slideContent.active') != null) {\n");
			sb.append(
					"            document.querySelector('#mainLayout > div.actionBar.productDetail > div.actionButtonWrapper > div > button:nth-child(1)').click();\n");
			sb.append("            setTimeout(function() {\n");
			sb.append(
					"              var temp = document.querySelector('#mainLayout > header > div > div > a > span.number').textContent;\n");
			sb.append("              if (number == temp) {\n");
			sb.append("              window.android.onFailAddCart()\n");

			sb.append("              } else {\n");
			sb.append("                window.android.onSuccessAddCart()\n");
			sb.append("              }\n");
			sb.append("            }, 1000)\n");
			sb.append("          } else {\n");
			sb.append("            setTimeout(function() {\n");
			sb.append(
					"              var temp = document.querySelector('#mainLayout > header > div > div > a > span.number').textContent;\n");
			sb.append("              if (number == temp) {\n");
			sb.append("               window.android.onFailAddCart()\n");

			sb.append("              } else {\n");
			sb.append("               window.android.onSuccessAddCart()\n");

			sb.append("            }\n");
			sb.append("          }, 1000)\n");
			sb.append("        }\n");
			sb.append("      }, 1000)\n");
			sb.append("    } catch {\n");
			sb.append("      window.android.onFailAddCart()\n");
			sb.append("    }\n");
			sb.append("  }\n");

			schemes.put("lotteon.=-=/lottemart=-=/product/LM", sb.toString());

			sb.setLength(0);
			sb.append(" javascript: { \n");
			sb.append(" try { \n");
			sb.append(" var number = '0' \n");
			sb.append(" try { \n");
			sb.append(" number = document.querySelector('div.headerAction > div > span').textContent; \n");
			sb.append(" } catch {} \n");
			sb.append(" document.querySelector('button.btn.primary').click();  \n");
			sb.append(" setTimeout(function() { \n");
			sb.append(" var temp = '0' \n");
			sb.append(" try { \n");
			sb.append(" temp = document.querySelector('div.headerAction > div > span').textContent; \n");
			sb.append(" } catch {} \n");
			sb.append(" if (number == temp) { \n");
			sb.append(" document.querySelector('button.btn.primary').click();  \n");
			sb.append(" setTimeout(function() { \n");
			sb.append(" var temp = '0' \n");
			sb.append(" try { \n");
			sb.append(" temp = document.querySelector('div.headerAction > div > span').textContent; \n");
			sb.append(" } catch {} \n");
			sb.append(" if (number == temp) { \n");
			sb.append(" window.android.onFailAddCart() \n");
			sb.append(" } else { \n");
			sb.append(" window.android.onSuccessAddCart() \n");
			sb.append(" } \n");
			sb.append(" }, 1000) \n");
			sb.append(" } else { \n");
			sb.append(" window.android.onSuccessAddCart() \n");
			sb.append(" } \n");
			sb.append(" }, 1000) \n");
			sb.append(" } catch { \n");
			sb.append(" window.android.onFailAddCart() \n");
			sb.append(" } \n");
			sb.append(" } \n");
			schemes.put("homeplus", sb.toString());

			/////////////////

			//마트
		} catch (Exception e) {
		}

	} else if (scheme.equals("martMobileUrl")) { //크롤링 url이 PC일경우 mobile로 변경해줘야됨
		try {
			//schemes.put(".emart", "http://m.ssg.com/item/itemView.ssg?");
			//schemes.put("lotteon.", "http://m.lottemart.com/mobile/cate/PMWMCAT0004_New.do?"); //mart
			//schemes.put("homeplus", "http://mfront.homeplus.co.kr/item?"); //마트
			//schemes.put("cjthemarket", "https://m.cjthemarket.com/mo/prod/prodDetail?"); //마트
			//schemes.put("gsfresh", "http://m.gsfresh.com/eretail.product.prodDetail.dev?"); //마트
		} catch (Exception e) {
		}
	} else if (scheme.equals("martCartTarget")) { //마트 카트 웹뷰 보여질때 Agent Target >> 쿠팡은 PC뷰
		try {
			schemes.put(".emart", "mobile");// 치환
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", "mobile"); //mart
			schemes.put("homeplus", "mobile"); //마트
			schemes.put("coupang", "pc"); //mart
		} catch (Exception e) {
		}
	} else if (scheme.equals("etc")) { // 안드로이드에서 로그인을 시간으로 체하기 위한 스킴
		try {
			schemes.put("11st", Hex_IDINPUT | Hex_LOGINDELAY_12);
			schemes.put("gmarket", Hex_IDINPUT | Hex_LOGINDELAY_3);
			schemes.put("g9", Hex_IDINPUT | Hex_LOGINDELAY_3);
			schemes.put("auction", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("interpark", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put(".emart", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("shinsegaemall", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("ssg", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("gsshop", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("wemakeprice", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("tmon", Hex_IDINPUT | Hex_LOGINDELAY_6);
			schemes.put("cjmall", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("cjonstyle", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("homeplus", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("lotteon.=-=/ellotte=-=/product/LE", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("lotteon.=-=/ellotte=-=/LE", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("lotteimall", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("ellotte", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("akmall", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("coupang", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("epost", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("kyobo", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("yes24", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("aladin", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("musinsa", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("interpark=-=mbook", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("oliveyoung", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("amoremall", Hex_IDINPUT | Hex_LOGINDELAY_2);
			
			
			/*
			schemes.put("11st", Hex_IDINPUT | Hex_LOGINDELAY_12);
			schemes.put("gmarket", Hex_IDINPUT | Hex_LOGINDELAY_3);
			schemes.put("g9", Hex_IDINPUT | Hex_LOGINDELAY_3);
			schemes.put("auction", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put("interpark", Hex_IDINPUT | Hex_LOGINDELAY_2);
			schemes.put(".emart", Hex_IDINPUT | Hex_LOGINDELAY_3);
			schemes.put("shinsegaemall", Hex_IDINPUT | Hex_LOGINDELAY_3);
			schemes.put("ssg", Hex_IDINPUT | Hex_LOGINDELAY_3);
			schemes.put("gsshop", Hex_IDINPUT | Hex_LOGINDELAY_3);
			schemes.put("wemakeprice", Hex_IDINPUT | Hex_LOGINDELAY_6);
			schemes.put("tmon", Hex_IDINPUT | Hex_LOGINDELAY_6);
			schemes.put("cjmall", Hex_IDINPUT | Hex_LOGINDELAY_6);
			schemes.put("homeplus", Hex_IDINPUT | Hex_LOGINDELAY_12);
			//schemes.put(".lotte.com", Hex_IDINPUT | Hex_LOGINDELAY_12);
			schemes.put("lotteon.=-=/ellotte=-=/product/LE", Hex_IDINPUT | Hex_LOGINDELAY_3);
			
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", Hex_IDINPUT | Hex_LOGINDELAY_3);
			
			//	schemes.put("lottemart", Hex_IDINPUT | Hex_LOGINDELAY_3);
			
			schemes.put("lotteon.=-=/ellotte=-=/LE", Hex_IDINPUT | Hex_LOGINDELAY_3);
			
			//schemes.put("lotteon.", Hex_IDINPUT | Hex_LOGINDELAY_3);
			schemes.put("lotteimall", Hex_IDINPUT | Hex_LOGINDELAY_12);
			schemes.put("ellotte", Hex_IDINPUT | Hex_LOGINDELAY_3);
			schemes.put("akmall", Hex_IDINPUT | Hex_LOGINDELAY_6);
			schemes.put("coupang", Hex_IDINPUT | Hex_LOGINDELAY_12);
			schemes.put("epost", Hex_IDINPUT | Hex_LOGINDELAY_6);
			schemes.put("kyobo", Hex_IDINPUT | Hex_LOGINDELAY_6);
			schemes.put("yes24", Hex_IDINPUT | Hex_LOGINDELAY_6);
			schemes.put("aladin", Hex_IDINPUT | Hex_LOGINDELAY_6);
			*/
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
			//결제하러 갔다가 취소하면 9999가 리턴된다
			schemes.put("skstoa.com",
					"https://m.skstoa.com/order/finish?orderNo=9999&=-=/sp.easypay.co.kr/ep8/card/cer");
		} catch (Exception e) {
		}
	} else if (scheme.equals("uws")) { //unique webview settings
		try {
			schemes.put("gmarket", "setBlockNetworkImage:false");
		} catch (Exception e) {
		}
	}

	else if (scheme.equals("re")) { // 적립을 위해 구매 정보를 가져오는 스크립트 스킴  reLink 쇼핑몰 링크 확인
		try {
			StringBuilder sb = new StringBuilder();
			//schemes.put("11st", "SCRIPT=-=Order/viewOrderPayInfo.tmall=-=(function(){return $('.odr_tbl').find('tr:eq(1)').eq(0).find('td').text(); })()");
			//(function(){var re = $('.odr_tbl').not('.tour_end').find('tbody').eq(0).find('tr:eq(1)').find('td').text(); if(re==null || re.length<1){var doc11=(document.documentURI);var index = doc11.indexOf('&ordNo=')+7;if(index>=7)re = doc11.substring(index,index + 15 );}return re;})()
			schemes.put("11st", "SCRIPT=-=Order/viewOrderPayInfo.tmall=-="
			+ "(function()  " + "		  { "
					+ "		    var re = ''; " + "		    try{ " + "		      re = id; "
					+ "		      if(re==null || re.length<10) " + "		      {  "
					+ "		        var doc11=(document.documentURI); "
					+ "		        if(doc11.includes('Order/viewOrderPayInfo.tmall')){ "
					+ "		          var index = doc11.indexOf('ordNo=')+6; "
					+ "		          var endindex = doc11.substring(index).indexOf('&'); "
					+ "		          if (endindex != -1) "
					+ "		            re = doc11.substring(index, index + endindex); " + "		          else "
					+ "		            re = doc11.substring(index); " + "		        } " + "		      } "
					+ "		    }catch{ " + "		      var doc11=(document.documentURI); "
					+ "		      if(doc11.includes('Order/viewOrderPayInfo.tmall')){ "
					+ "		        var index = doc11.indexOf('ordNo=')+6; "
					+ "		        var endindex = doc11.substring(index).indexOf('&'); "
					+ "		        if (endindex != -1) "
					+ "		        re = doc11.substring(index, index + endindex); " + "		        else "
					+ "		        re = doc11.substring(index); " + "		      } " + "		    } "
					+ "		    return re; " + "		  })()");

			

			//지마켓 결제 완료창에서 결제 정보가 비동기로 호출 되는 문제가 있었다 
			//안드로이드는 정상 수집되지만 ios에서는 정상 수집 되지 않아 장바구니 번호만 수집하도록했다 
			//400 버전이후로는 딜레이 값을 줘서 결제창이 완료되어도 몇초후에 호출 할 수있도록 했다 
			if (os.equals("aos")){
				schemes.put("gmarket", "SCRIPT=-=/complete?pno=-= " +
					"(async function asyncCall() { "+
					 "function resolveAfter2Seconds() { "+
					 "return new Promise(resolve => { "+
					 " setTimeout(() => { "+
					 " resolve((function() { "+
					 " var jsontt = JSON.parse(document.querySelector('body > form > input').value); "+
					 "var packNo = jsontt.paymentNo.toString(16) + ','; "+
					 "for (var i = 0; i < jsontt.orders.length; i++) { "+
					 "packNo += jsontt.orders[i].orderNo +','; "+
					 "} "+
					 "return packNo; "+
					 "})()); "+
					 "}, 2500); "+
					 "}); "+
					 "} "+
					 "const result = await resolveAfter2Seconds(); "+
					 "window.Android.getOrderNumberFromJavaScript(result.toString()); "+
					 "})() ");
			}else{
				if (version <= 400){
				schemes.put("gmarket", "SCRIPT=-=/complete?pno=-= " +
						"(function(){  "+			
								"var doc11=(document.documentURI); "+
								"var packNo=doc11.substring(doc11.indexOf('?pno=')+5); "+								 
								"if (packNo.indexOf('#')){ "+
								" 	packNo=packNo.split('#')[0]; "+
								"} "+								
								"return Number(packNo).toString(16); "+			
							"})()");
				}else {
					schemes.put("gmarket", "SCRIPT=-=/complete?pno=-= " +
							"(function(){ "+ 
							"var jsontt = JSON.parse(document.querySelector('body > form > input').value); "+ 
							"var packNo = jsontt.paymentNo.toString(16) +','; "+
							"for(var i = 0 ; i < jsontt.orders.length; i ++){ "+
							"packNo += jsontt.orders[i].orderNo; "+
							"packNo += ','; "+
							"} "+
							"return packNo; "+
							"})()");
				}
			}

			
			/* schemes.put("gmarket", "SCRIPT=-=/complete?pno=-= " +
					"(function(){  "+			
						 "var jsontt = JSON.parse(document.querySelector('body > form > input').value); "+				
						"var packNo = jsontt.paymentNo.toString(16) +','; "+
						"for(var i  = 0 ; i < jsontt.orders.length; i ++){ "+
						"packNo += jsontt.orders[i].orderNo; "+
						"} "+
						"return packNo; "+
						"})()"); */
			



			/* 	schemes.put(
						"gmarket",
						"SCRIPT=-=complete?pno=-= "+
						"(function(){ "+
						"var doc11=(document.documentURI); "+
						"var packNo=doc11.substring(doc11.indexOf('?pno=')+5); "+
						 
						"if (packNo.indexOf('#')){ "+
						" 	packNo=packNo.split('#')[0] "+
						"} "+
						
						"var outText=packNo; "+
						"return outText;})() "); */

			//schemes.put("g9", "SCRIPT=-=Buy.htm#/Buy/PayComplete=-=(function(){var a = document.documentURI; return a.substring(a.indexOf('PayComplete/')+'PayComplete/'.length, a.length)})()");
			if (version < 304 && appName.equals("enuri")) {
				schemes.put("auction", "");
			} else {
				//	schemes.put("auction", "SCRIPT=-=/OrderConfirmMobile.aspx=-=(function(){var doc11=(document.documentURI);var index = doc11.indexOf('?PayNo=')+7;var packNo=doc11.substring(index,index+9)+','; var track =$('#form1 script');for(var i=0;i< track.length;i++){var a = track[i].text;if(a.indexOf('OrderTracking(')>-1){var b =a.substring(a.indexOf('OrderTracking(')+ 'OrderTracking('.length, a.length);packNo += b.substring(0,b.indexOf(');')).split(',')[1]+',';}}packNo = packNo.replace(/'/gi, '');return packNo;})()");

				// 주문번호가 9자리 였다가 10자리로 변경 되면서 주문 수집 JS 변경 (2017 / 05 / 02 장태주)
				// URL에서 긁어 오는 주문 번호 끝에 &가 포함 되어 있으면 &부터 삭제 하도록 수정

				// schemes.put("auction", "SCRIPT=-=/OrderConfirmMobile.aspx=-=(function() {var doc11 = (document.documentURI);var index = doc11.indexOf('?PayNo=') + 7;var packNo = doc11.substring(index);if (packNo.includes('&')) {packNo = packNo.replace(packNo.substring(packNo.indexOf('&')), '')}var packNo = packNo + ',';var track = $('#form1 script');for (var i = 0; i < track.length; i++) {var a = track[i].text;if (a.indexOf('OrderTracking(') > -1) {var b = a.substring(a.indexOf('OrderTracking(') + 'OrderTracking('.length, a.length);packNo += b.substring(0, b.indexOf(');')).split(',')[1] + ','; } }packNo = packNo.replace(/'/gi, '');return packNo; })()");

				//			schemes.put("auction", "SCRIPT=-=/OrderConfirmMobile.aspx=-=(function(){var doc11=(document.documentURI);var index = doc11.indexOf('?PayNo=')+7;var packNo=doc11.substring(index,index+10)+','; var track =$('#form1 script');for(var i=0;i< track.length;i++){var a = track[i].text;if(a.indexOf('OrderTracking(')>-1){var b =a.substring(a.indexOf('OrderTracking(')+ 'OrderTracking('.length, a.length);packNo += b.substring(0,b.indexOf(');')).split(',')[1]+',';}}packNo = packNo.replace(/'/gi, '');return packNo;})()");
				//			}

				//schemes.put("auction",
				//		"SCRIPT=-=/OrderConfirmMobile.aspx=-=(function(){var doc11=(document.documentURI);var paynoindex=doc11.toLowerCase().indexOf('?payno=');var index;var packNo;if(paynoindex>0){index= paynoindex+7;packNo=doc11.substring(index,index+10)+',';}else{packNo = ',';}var track =$('#form1 script');for(var i=0;i< track.length;i++){var a = track[i].text;if(a.indexOf('OrderTracking(')>-1){var b =a.substring(a.indexOf('OrderTracking(')+ 'OrderTracking('.length, a.length);packNo += b.substring(0,b.indexOf(');')).split(',')[1]+',';}}packNo = packNo.replace(/'/gi, '');return packNo;})()");
				if (version <= 400){
					schemes.put("auction", "SCRIPT=-=/complete?pno=-= " +
							"(function(){  "+			
									"var doc11=(document.documentURI); "+
									"var packNo=doc11.substring(doc11.indexOf('?pno=')+5); "+								 
									"if (packNo.indexOf('#')){ "+
									" 	packNo=packNo.split('#')[0]; "+
									"} "+								
									"return Number(packNo); "+			
								"})()");
					}else {
						schemes.put("auction", "SCRIPT=-=/complete?pno=-= " +
								"(function(){ "+ 
								"var jsontt = JSON.parse(document.querySelector('body > form > input').value); "+ 
								"var packNo = jsontt.paymentNo +','; "+
								"for(var i = 0 ; i < jsontt.orders.length; i ++){ "+
								"packNo += jsontt.orders[i].orderNo; "+
								"packNo += ','; "+
								"} "+
								"return packNo; "+
								"})()");
					}
		}

			//schemes.put("interpark", "SCRIPT=-=order/shop/pay_done=-=(function() {return $('#orderNumber strong').text();})()");

			schemes.put("interpark", "SCRIPT=-=order/shop/pay_done=-=" +
			/* "(function(){var doc11=(document.documentURI);"+
			"var sharpindex = doc11.indexOf('#');"+
			"if(sharpindex>0)"+
			"	return doc11.substring(doc11.toLowerCase().indexOf('on=')+3,sharpindex);"+
			"else return doc11.substring(doc11.toLowerCase().indexOf('on=')+3);})()"); */

					"(function(){ " + "	  var doc11=(document.documentURI); "
					+ "	  if(doc11.includes('order/shop/pay_done')){ "
					+ "	    if (document.querySelector('div.row.orderNumber > div.detail > p') != null){ "
					+ "	       var orderNo = document.querySelector('div.row.orderNumber > div.detail > p').textContent; "
					+ "	       if (orderNo != null){ " + "	          return orderNo ; " + "	       }else{ "
					+ "	          return a(); " + "	       } " + "	    }else{ " + "	       return a(); "
					+ "	    } " + "	  } " + "	  function a(){ " + "	     var doc11=(document.documentURI); "
					+ "	     var sharpindex = doc11.indexOf('#'); " + "	     var temp ;  " + "	     if(sharpindex>0){ "
					+ "	       temp = doc11.substring(doc11.toLowerCase().indexOf('on=')+3,sharpindex); "
					+ "	       if (temp.includes('undefined') || doc11.includes('&err=')){  "
					+ "	         return '';  " + "	       }else {  " + "	         return temp; " + "	       }  "
					+ "	     } " + "	     else { "
					+ "	       temp = doc11.substring(doc11.toLowerCase().indexOf('on=')+3); "
					+ "	       if (temp.includes('undefined')|| doc11.includes('&err=')){  "
					+ "	         return '';  " + "	       }else {  " + "	         return temp; " + "	       }  "
					+ "	     } " + "	  } " + "	})() "

			/* "(function(){ "+
			"   if (document.querySelector('div.row.orderNumber > div.detail > p') != null){"+
			"      var orderNo = document.querySelector('div.row.orderNumber > div.detail > p').textContent;"+				
			"      if (orderNo != null){"+
			"         return orderNo ;"+
			"      }else{"+
			"         return a();"+
			"      }"+
			"   }else{"+
			"      return a();"+
			"   }"+
			"   function a(){"+
			"      var doc11=(document.documentURI);"+
			"      var sharpindex = doc11.indexOf('#');"+
			"		var temp ; "+
			"      if(sharpindex>0){	"+
			"			temp = doc11.substring(doc11.toLowerCase().indexOf('on=')+3,sharpindex); "+
			"			if (temp.includes('undefined') || temp.includes('&err=')){ "+
			"				return ''; "+
			"			}else { "+
			"				return temp; "+
			"			} "+
			"      }"+
			"      else { "+		
			"			temp = doc11.substring(doc11.toLowerCase().indexOf('on=')+3); "+
			"			if (temp.includes('undefined')|| temp.includes('&err=')){ "+
			"				return ''; "+
			"			}else { "+
			"				return temp; "+
			"			} "+
			"      }"+
			"   }"+
			"})()" */
			);

			schemes.put(".emart", "SCRIPT=-=/order/ordComplete.ssg=-="
					+ "(function(){var doc11=(document.documentURI);return doc11.substring(doc11.toLowerCase().indexOf('ordno=')+6);})()");
			
			
			
			schemes.put("shinsegaemall",
					"SCRIPT=-=/order/ordComplete.ssg=-=(function(){var doc11=(document.documentURI);return doc11.substring(doc11.toLowerCase().indexOf('ordno=')+6);})()");
			// https://pay.ssg.com/m/order/ordComplete.ssg?ordNo=202206013EF5FC
			schemes.put("ssg",
					"SCRIPT=-=/order/ordComplete.ssg=-="
							+ "(function(){var doc11=(document.documentURI);return doc11.substring(doc11.toLowerCase().indexOf('ordno=')+6);})()");
			/* + "(  " + "   function(){   " 
					+ getParamValueScript()
							+ "      var value = getParamValue('orderNo'); " 
					+ "      if (value != null){ "
							+ "         return value; " 
							+ "      }else { "
							+ "         var orderNo = $('#ordNo').val();   "
							+ "         return orderNo;   "
							+ "      } " 
							+ "   } " + ")()"); */

			schemes.put("gsshop",
					"SCRIPT=-=order/main/confirmOrder.gs=-=(function() {return $('#order_no').val();})()");

			/* var a = document.documentURI; 
			const url = new URL(  a );
			console.log(url.searchParams.get('purchaseNo'));  => 'hello' */

			schemes.put("wemakeprice",

					"SCRIPT=-=order/confirm_cart_order=-=( " + "		function(){ "
							+ "			var a = document.documentURI; "
							+ "			if(a.indexOf('order/orderComplete') > 0) "
							+ "				return $('#purchaseNo').val(); " + "			else{ "
							+ "				var b = a.substring(a.lastIndexOf('/')+1,a.length); "
							+ "				var index = b.indexOf('#'); "
							+ "				if(index>0) return b.substring(0,index); "
							+ "				else return b;}})()");
			schemes.put("tmon",
					"SCRIPT=-=/result/=-=(function(){var temp = $('.cmpl .order .num').text();if(temp==null || temp.length<1){var doc11=(document.documentURI);var index = doc11.toLowerCase().indexOf('/result/')+8;return doc11.substring(index,index+10);}else return temp;})()");
			//				schemes.put("cjmall", "SCRIPT=-=mw.cjmall.com/m/order/order_end.jsp=-=(function() {var a = $('.paynum').text();return a.substring('주문번호 '.length,a.length);})()");
			//				schemes.put("cjmall", "SCRIPT=-=base.cjmall.com/m/order/end/=-=(function() {var a = $('.paynum').text();if (a.length) return a.substring('주문번호 '.length, a.length).replace(/-/gi, '');a = $('.order_number').text();if (a.length) return a.substring('주문번호 '.length, a.length).replace(/-/gi, '');var url = document.documentURI;if (url.includes('base.cjmall.com/m/order/end/')) {var index = url.indexOf('/end/');a = url.substring(index + 5);if (a.includes('?app_cd=')) {a = a.replace(a.substring(a.indexOf('?')), '');}return a; } })()");
			//schemes.put(
			//	"cjmall",
			//"SCRIPT=-=mw.cjmall.com/m/order/order_end.jsp=-=(function() {var a = $('.paynum').text();if (a.length) return a.substring('주문번호 '.length, a.length).replace(/-/gi, '');a = $('.order_number').text();if (a.length) return a.substring('주문번호 '.length, a.length).replace(/-/gi, '');var url = document.documentURI;if (url.includes('base.cjmall.com/m/order/end/')) {var index = url.indexOf('/end/');a = url.substring(index + 5,index+5+14);if (a.includes('?app_cd=')) {a = a.replace(a.substring(a.indexOf('?')), '');}return a; } })()");

			schemes.put("cjmall",
					"SCRIPT=-=cjmall.com/m/order/end=-=(function() {var a = $('.paynum').text();if (a.length) return a.substring('주문번호 '.length, a.length).replace(/-/gi, '');a = $('.order_number').text();if (a.length) return a.substring('주문번호 '.length, a.length).replace(/-/gi, '');var url = document.documentURI;if (url.includes('base.cjmall.com/m/order/end/')) {var index = url.indexOf('/end/');a = url.substring(index + 5,index+5+14);if (a.includes('?app_cd=')) {a = a.replace(a.substring(a.indexOf('?')), '');}return a; } })()");

			schemes.put(

					"cjonstyle",
					"SCRIPT=-=cjonstyle.com/m/order/end=-=(function() {var a = $('.paynum').text();if (a.length) return a.substring('주문번호 '.length, a.length).replace(/-/gi, '');a = $('.order_number').text();if (a.length) return a.substring('주문번호 '.length, a.length).replace(/-/gi, '');var url = document.documentURI;if (url.includes('base.cjmall.com/m/order/end/')) {var index = url.indexOf('/end/');a = url.substring(index + 5,index+5+14);if (a.includes('?app_cd=')) {a = a.replace(a.substring(a.indexOf('?')), '');}return a; } })()");

			//if (isDev)
			schemes.put("coupang",
					"SCRIPT=-=/orderResult.pang=-=(function() {var doc11=(document.documentURI);var packNo=doc11.substring(doc11.indexOf('orderId=')+8);return packNo.substring(0,packNo.indexOf('&'))})()");

			schemes.put("akmall", "");
			//	if (isDev)
			schemes.put("homeplus",
					"SCRIPT=-=/home/ordinis/ordSuccess=-=" + "(function() { "
							+ "	  var doc11 = (document.documentURI); "
							+ "	  if (doc11.includes('/home/ordinis/ordSuccess')) { "
							+ "	    var packNo = doc11.substring(doc11.indexOf('sid=') + 4); "
							+ "	    var endIndex = packNo.indexOf('&'); " + "	    if (endIndex != -1) { "
							+ "	      return packNo.substring(0, endIndex); " + "	    } else { "
							+ "	      var temp = packNo.substring(0, packNo.length); "
							+ "	      var tempEndIndex = temp.indexOf('#'); " + "	      if (tempEndIndex != -1) { "
							+ "	        return temp.substring(0, tempEndIndex); " + "	      } else { "
							+ "	        return temp.substring(0, temp.length); " + "	      } " + "	    } "
							+ "	  } " + "	  return '' " + "	})() ");

			//schemes.put(".lotte.com", "");
			schemes.put("lotteon.", "");

			schemes.put("lotteon.=-=/lottemart=-=/product/LM", "");//마트
			schemes.put("lotteon.=-=/ellotte=-=/product/LE", "");//엘롯데
			//schemes.put("lottemart","");//마트

			schemes.put("lotteimall", "");
			schemes.put("ellotte", "");
			schemes.put("hnsmall", "");
			schemes.put("epost", "");
			schemes.put("kyobo", "");
			schemes.put("yes24", "");
			schemes.put("aladin", "");
			schemes.put("musinsa", "");
			schemes.put("interpark=-=mbook", "");
			schemes.put("oliveyoung", "");
			schemes.put("amoremall", "");

			/*
				20201208 reward_shop_list.json 파일과 동일하게 수집하지 않는 리워드 쇼핑몰을 삭제함
				참고 :
					1.구글시트 [EMS PUSH 리스트]
					2.re 해당 부분 주석처리 (네이버 팜 스토어 리워드 수집 추가 건이 예상 됨으로 삭제하지 않음)
					3.getDefine_Core.jsp 3곳 수정함 20201208 검색
				- 손진욱
					if (isDev)
						schemes.put("hmall", "SCRIPT=-=/front/orderComplete.do=-=(function() {return _TRK_ODN +','+_TRK_PNC.replace(/;/gi, ',');})()");
					//schemes.put("smartstore.naver.com/asmall19/", "SCRIPT=-=pay.naver.com/o/orderDone/=-=(function(){return document.getElementsByClassName('ord_num btn_tr')[0].getElementsByTagName('strong')[0].innerHTML+document.getElementsByClassName('ord_sc fst')[0].getElementsByTagName('a')[0].pathname;})()");
					schemes.put(
							"smartstore.naver.com/inlstore/",
							"SCRIPT=-=pay.naver.com/o/orderDone/=-=(function(){return document.getElementsByClassName('ord_num btn_tr')[0].getElementsByTagName('strong')[0].innerHTML+document.getElementsByClassName('ord_sc fst')[0].getElementsByTagName('a')[0].pathname;})()");
					if (isDev)
						schemes.put(
								"smartstore.naver.com/lgxnote/",
								"SCRIPT=-=pay.naver.com/o/orderDone/=-=(function(){return document.getElementsByClassName('ord_num btn_tr')[0].getElementsByTagName('strong')[0].innerHTML+document.getElementsByClassName('ord_sc fst')[0].getElementsByTagName('a')[0].pathname;})()");
					if (isDev)
						schemes.put(
								"smartstore.naver.com/jojo/",
								"SCRIPT=-=pay.naver.com/o/orderDone/=-=(function(){return document.getElementsByClassName('ord_num btn_tr')[0].getElementsByTagName('strong')[0].innerHTML+document.getElementsByClassName('ord_sc fst')[0].getElementsByTagName('a')[0].pathname;})()");
					if (isDev)
						schemes.put(
								"smartstore.naver.com/lgmedia/",
								"SCRIPT=-=pay.naver.com/o/orderDone/=-=(function(){return document.getElementsByClassName('ord_num btn_tr')[0].getElementsByTagName('strong')[0].innerHTML+document.getElementsByClassName('ord_sc fst')[0].getElementsByTagName('a')[0].pathname;})()");
			
					schemes.put(
							"smartstore.naver.com/samsung_mall/",
							"SCRIPT=-=pay.naver.com/o/orderDone/=-=(function(){return document.getElementsByClassName('ord_num btn_tr')[0].getElementsByTagName('strong')[0].innerHTML+document.getElementsByClassName('ord_sc fst')[0].getElementsByTagName('a')[0].pathname;})()");
			
					if (isDev)
						schemes.put(
								"feelway.com",
					 			"SCRIPT=-=/m_order_goods_view.php=-=(function() {var doc11=(document.documentURI);	var packNo=doc11.substring(doc11.indexOf('order_no=')+9);	return packNo.substring(0,packNo.indexOf('&'))})()");
					*/
			//if (isMartStartVersion(appName, version, os))
			//	schemes.put("homeplus", "SCRIPT=-=/payment/order_result.do=-=(function() {return $('.list-area').find('td').eq(0).text().trim();})()");
			schemes.put("smartstore.naver.com/guidecom/",
					"SCRIPT=-=pay.naver.com/o/orderDone/=-=(function(){return document.getElementsByClassName('ord_num btn_tr')[0].getElementsByTagName('strong')[0].innerHTML+document.getElementsByClassName('ord_sc fst')[0].getElementsByTagName('a')[0].pathname;})()");

			schemes.put("skstoa.com", "SCRIPT=-=skstoa.com/order/finish=-=" + "(function() { "
					+ "	  var strUrl = (document.documentURI); "
					+ "	  if (strUrl.includes('skstoa.com/order/finish')) { "
					+ "	    var scriptOrder = document.querySelector('p.number.mt10 > strong'); "
					+ "	    if (scriptOrder != null) { " + "	      if (scriptOrder.innerText != null) { "
					+ "	        return scriptOrder.innerText; " + "	      } " + "	    } "
					+ "	    var doc11 = (document.documentURI); "
					+ "	    var packNo = doc11.substring(doc11.indexOf('orderNo=') + 8, ); "
					+ "	    var shoartIndex, andIndex; " + "	    sharpIndex = packNo.indexOf('#'); "
					+ "	    if (sharpIndex != -1) { " + "	      packNo = packNo.substring(0, sharpIndex); "
					+ "	      andIndex = packNo.indexOf('&'); " + "	      if (andIndex != -1) { "
					+ "	        packNo = packNo.substring(0, andIndex); " + "	      } " + "	    } "
					+ "	    andIndex = packNo.indexOf('&'); " + "	    if (andIndex != -1) { "
					+ "	      packNo = packNo.substring(0, andIndex); " + "	      sharpIndex = packNo.indexOf('#'); "
					+ "	      if (sharpIndex != -1) { " + "	        packNo = packNo.substring(0, sharpIndex); "
					+ "	      } " + "	    } " + "	    return packNo; " + "	  } " + "	  return '' " + "	})() ");

			/* var doc11=(document.documentURI);
			var packNo=doc11.substring(doc11.indexOf('orderNo=')+8,);
			var shoartIndex , andIndex ;
			sharpIndex = packNo.indexOf('#');
			if (sharpIndex != -1)
			{
				packNo = packNo.substring(0,sharpIndex);
				andIndex = packNo.indexOf('&');
				if(andIndex != -1){
					packNo = packNo.substring(0,andIndex);
				}
			}
			andIndex = packNo.indexOf('&');
			if (andIndex != -1)
			{
				packNo = packNo.substring(0,andIndex);
				sharpIndex = packNo.indexOf('#');
				if(sharpIndex != -1){
					packNo = packNo.substring(0,sharpIndex);
				}
			}
			return packNo; */

			//schemes.put("coupang", "SCRIPT=-=m/orderResult.pang=-=(function(){var a = document.documentURI; return a.substring(a.indexOf('orderId=')+8,a.indexOf('&price'));})()");
		} catch (Exception e) {
		}
	} else if (scheme.equals("reLink")) { // 리워드 확인 하는 링크, 있으면 reLink를 사용 하고 없으면 기존의 re를 사용 하도록 한다. // 3.2.5(2017.04) 부터 적용.
		try {
			schemes.put("cjmall", "mw.cjmall.com/m/order/order_end.jsp=-=base.cjmall.com/m/order/end/");
			schemes.put("cjonstyle", "mw.cjonstyle.com/m/order/order_end.jsp=-=base.cjonstyle.com/m/order/end/");
			schemes.put("wemakeprice", "order/orderComplete=-=order/confirm_cart_order");
			//schemes.put("gmarket", "ordercomplete?packNo=-=complete?pno");

			schemes.put("coupang", "/orderResult.pang=-=thank-you?");
		} catch (Exception e) {
		}
	} else if (scheme.equals("renot"))//=-=구분 리워드 중에 에러가 아닌데 에러로 메시지 던지는 걸 걸러넨다
	{
		try {
			//	schemes.put("11st", "url=p"); 시럽(11pay) 리워드 안되서 다시 지웠음
			schemes.put("interpark", "order/shop/pay_done_ispnew.html");
			schemes.put("skstoa.com", "https://m.skstoa.com/order/finish?orderNo=9999&");

			//schemes.put("wemakeprice", "index.php/m/order");
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

			schemes.put("gsshop", 90);
			//schemes.put("gmarket", 90);

		} catch (Exception e) {
		}
	} else if (scheme.equals("reDelay")) //4.0.1 부터 적용 지마켓에서 결제 완료창에서 결제정보가 비동기로와 정상적으로 수집 되지 않는 오류가 있었다// 값은 초다  
	{
		try {
			if (os.equals("ios")){
				schemes.put("gmarket", 3);
			}
			schemes.put("auction", 3);
			//schemes.put("gmarket", 90);

		} catch (Exception e) {
		}
	}else if (scheme.equals("iosReCallPercent")) {
		try {

			schemes.put("gsshop", 60);
			//ios는 3.4.2 버전 부터 적용 된다
			/* if (appName.equals("enuri") && (os.equals("aos") || (os.equals("ios") && version >= 342)))
				schemes.put("gmarket", 80); */

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
			schemes.put("cjonstyle", "CJ_LOGIN=Y");
			//schemes.put("hmall", "EHCustNO=");
			//schemes.put("akmall", "loginToken=-=BLANK");
			
			schemes.put("homeplus", "Ahplus=-=BLANK");
			//20171206 쿠키확인 변경 (전:LOGINCHK)
			//	schemes.put(".lotte.com", "LOGINID=-=BLANK");
			schemes.put("lotteon.", "fo_sso_tkn=-=BLANK");
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", "fo_sso_tkn=-=BLANK");//마트
			schemes.put("lotteon.=-=/ellotte=-=/product/LE", "fo_sso_tkn=-=BLANK");//엘롯데
			//schemes.put("lottemart","fo_sso_tkn=-=BLANK");//마트
			//20171206 쿠키확인 변경 (전:LOGINCHK)
			schemes.put("lotteimall", "MC_ALOGIN_SEQ=-=BLANK");
			//신 엘롯데
			schemes.put("ellotte", "onl_id=-=BLANK");
			//구 엘롯데
			//schemes.put("ellotte", "LOGINID=-=BLANK");
			schemes.put("hnsmall", "HNS_NO=-=BLANK");
			schemes.put("coupang", "member_srl=-=BLANK");
			//schemes.put("g9", "API_INFO_G9=");
			schemes.put("akmall", "loginToken=-=BLANK");
			schemes.put("g9", "authtoken=-=BLANK");
			//schemes.put("lottemart", "MEMBERS_KEY=-=BLANK");
			schemes.put("epost", "chkLogin=-=BLANK");
			schemes.put("kyobo", "remember-me=-=BLANK");
			schemes.put("yes24", "MYes24LoginKeep=-=BLANK");
			schemes.put("aladin", "AladdinLogin");
			schemes.put("musinsa", "app_rtk=");
			schemes.put("interpark=-=mbook", "TMem%5FNO=");
			schemes.put("oliveyoung", "OYSESSIONID=");
			schemes.put("amoremall", "isLogin=Y");
		} catch (Exception e) {
		}
	} else if (scheme.equals("lcmsg")) { //안드로이드 3.0.9 버젼 부터 팝업 뜨면 로그인 실패인데 이 팝업이면 로그인 성공 시킴 (ios 3.7.4)
		try {
			schemes.put("cjmall", "이미 로그인 중입니다.=-=애플 아이디로 CJmall 로그인 서비스를 이용하시겠습니까?=-=휴대폰에 등록된 지문=-=로그인합니다");
			schemes.put("cjonstyle", "이미 로그인 중입니다.=-=애플 아이디로=-=휴대폰에 등록된 지문=-=로그인합니다");

		} catch (Exception e) {
		}

	} 
	else if (scheme.equals("lcmsg_etc")) {//20220720 기타 로그인 실패 로직 추가 필요 
		
		try {

			/* schemes.put("11st", 5910);				schemes.put("gmarket", 536);				schemes.put("g9", 7692);
			schemes.put("auction", 4027);				schemes.put("interpark", 55);				schemes.put(".emart", 374); //mart
			schemes.put("shinsegaemall", 47);				schemes.put("ssg", 6665);				schemes.put("gsshop", 75);
			schemes.put("wemakeprice", 6508);				schemes.put("tmon", 6641);				schemes.put("cjmall", 806);
			schemes.put("hmall", 57);				schemes.put("akmall", 90);				schemes.put("e-himart", 6252);
			schemes.put("galleria", 6620);				schemes.put("okmall", 6427);				schemes.put(".nsmall.com", 974);
			schemes.put("homeplus", 6361);				schemes.put("lotteon.", 49); 
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", 7455);				schemes.put("lotteon.=-=/ellotte=-=/product/LE", 6547);
			schemes.put("lotteimall", 663);				schemes.put("ellotte", 6547);				schemes.put("hnsmall", 6588);
			schemes.put("coupang", 7861);				schemes.put("epost", 5438);				schemes.put("kyobo", 6367);
			schemes.put("yes24", 3367);				schemes.put("aladin", 4861);				schemes.put("cjthemarket", 6165);
			schemes.put("gsfresh", 6622); schemes.put("musinsa", 24763); schemes.put("interpark=-=mbook", 6711); schemes.put("oliveyoung", 32203); 
			schemes.put("amoremall", 32205);   */

			schemes.put("homeplus", "일시적인");
			schemes.put("11st", "영구정지 회원");
			schemes.put("wemakeprice", "회원정보가 변동되어");
			schemes.put("tmon", "로그인 이용이 제한되어=-=탈퇴한 계정");
			schemes.put("gmarket", "장기미이용");//20210218 에러팝업 처리
			schemes.put("cjmall", "휴면상태가 되었습니다");
			schemes.put("cjonstyle", "휴면상태가 되었습니다");
			 
			schemes.put("coupang", "새로운 환경에서 로그인 할 경우 본인");
			schemes.put("lotteon.", "휴면 상태입니다"); //mart
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", "휴면 상태입니다"); //mart
			schemes.put("lotteon.=-=/ellotte=-=/product/LE", "휴면 상태입니다"); //mart
			schemes.put("lotteimall", "휴면 상태입니다"); //mart			
		} catch (Exception e) {
		}
	}
	else if (scheme.equals("lcmsg_fail")) {//ios 3.7.4 팝업에 내용이 포함된다면 로그인 실패 // 3.7.7 실패 조건 팝업 , 로그인창에서는 노출, 누파리에서는 비노출 - 로그인 실패 계정불일치
		try {

			/* schemes.put("11st", 5910);				schemes.put("gmarket", 536);				schemes.put("g9", 7692);
			schemes.put("auction", 4027);				schemes.put("interpark", 55);				schemes.put(".emart", 374); //mart
			schemes.put("shinsegaemall", 47);				schemes.put("ssg", 6665);				schemes.put("gsshop", 75);
			schemes.put("wemakeprice", 6508);				schemes.put("tmon", 6641);				schemes.put("cjmall", 806);
			schemes.put("hmall", 57);				schemes.put("akmall", 90);				schemes.put("e-himart", 6252);
			schemes.put("galleria", 6620);				schemes.put("okmall", 6427);				schemes.put(".nsmall.com", 974);
			schemes.put("homeplus", 6361);				schemes.put("lotteon.", 49); 
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", 7455);				schemes.put("lotteon.=-=/ellotte=-=/product/LE", 6547);
			schemes.put("lotteimall", 663);				schemes.put("ellotte", 6547);				schemes.put("hnsmall", 6588);
			schemes.put("coupang", 7861);				schemes.put("epost", 5438);				schemes.put("kyobo", 6367);
			schemes.put("yes24", 3367);				schemes.put("aladin", 4861);				schemes.put("cjthemarket", 6165);
			schemes.put("gsfresh", 6622); schemes.put("musinsa", 24763); schemes.put("interpark=-=mbook", 6711); schemes.put("oliveyoung", 32203); 
			schemes.put("amoremall", 32205);   */
            
			
			schemes.put("homeplus", "아이디 또는 비밀번호를 확인=-=일시적인");
			schemes.put("11st", "아이디 혹은 패스워드가=-=다시 입력해주시기 바랍니다.=-=비밀번호 5회 오류=-=영구정지 회원");
			schemes.put("hnsmall", "아이디 또는 비밀번호를 잘못입력하셨습니다.=-=아이디를 입력해주세요");
			schemes.put("wemakeprice", "회원정보가 변동되어");	
			schemes.put("interpark", "비밀번호를 5회 이상=-=아이디 또는 비밀번호를=-=자동방지 문자를 잘못");//20210218 에러팝업 처리
			schemes.put("tmon", "로그인 이용이 제한되어=-=탈퇴한 계정");
			schemes.put("gmarket", "로그인에 실패하였습니다=-=비밀번호 입력시도 횟수가=-=아이디 확인 후 다시 입력=-=죄송합니다.=-=비밀번호는 15자리=-=장기미이용");//20210218 에러팝업 처리
			schemes.put("gsshop", "로그인 실패");
			schemes.put("cjmall", "아이디나 비밀번호가 틀립니다=-=휴면상태가 되었습니다");
			schemes.put("cjonstyle", "아이디나 비밀번호가 틀립니다=-=휴면상태가 되었습니다");
			schemes.put("auction", "로그인에 실패=-=비밀번호 입력시도 횟수가");
			
			
			//20220711 조건 추가
			//schemes.put("coupang", "새로운 환경에서 로그인 할 경우 본인=-=아이디 또는 비밀번호를 10회 틀렸습니다"); 
			schemes.put("coupang", "새로운 환경에서 로그인 할 경우 본인=-=아이디 또는 비밀번호를 10회 틀렸습니다=-=이메일 또는 비밀번호를 다시 확인하세요=-=아이디(이메일)는 이메일 형식으로 입력해주세요");
			schemes.put("g9", "로그인에 실패하였습니다=-=아이디 또는 비밀번호를=-=비밀번호를 확인");//20210218 에러팝업 처리
			schemes.put("akmall", "아이디 또는 비밀번호가 일치하지 않습니다=-=비밀번호 항목은 필수");//20210218 에러팝업 처리
			schemes.put("hmall", "비밀번호를 5회 이상=-=잘못 입력하셨습니다");
			//롯데 계열 한묶음 SSO로 동일한 로직 - 롯데아이몰만 따로적용 
			//조건 추가 필요 로그인 실패 메시지 :비밀번호를 5회 잘못 입력하셨어요. 고객님의 정보보호를 위해 비밀번호 변경 후 로그인 해 주세요.
			
			schemes.put("lotteon.", "일치하는 회원정보가 없습니다=-=비밀번호를 5회=-=서비스 이용이 불가한=-=휴면 상태입니다"); //mart
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", "일치하는 회원정보가 없습니다=-=비밀번호를 5회=-=서비스 이용이 불가한=-=휴면 상태입니다");
			schemes.put("lotteon.=-=/ellotte=-=/product/LE", "일치하는 회원정보가 없습니다=-=비밀번호를 5회=-=서비스 이용이 불가한=-=휴면 상태입니다");
			schemes.put("lotteimall", "일치하는 회원정보가 없습니다=-=비밀번호 입력 5회");
			//신세계 계열 한묶음 SSO로 동일한 로직
			schemes.put("ssg", "다시 확인하신 후 입력해주세요=-=실패하셨습니다=-=로그인에 실패하였습니다=-=아이디 또는 비밀번호를 확인해 주세요=-=존재하지 않는 회원입니다");//20210218 에러팝업 처리
			schemes.put(".emart", "다시 확인하신 후 입력해주세요=-=실패하셨습니다=-=로그인에 실패하였습니다=-=아이디에 공백이 포함");//20210218 에러팝업 처리
			schemes.put("shinsegaemall", "다시 확인하신 후 입력해주세요=-=실패하셨습니다=-=로그인에 실패하였습니다");//20210218 에러팝업 처리
			schemes.put("aladin", "입력하신 로그인 정보");
			schemes.put("musinsa", "아이디 또는 패스워드=-=로봇방지 문항을");
			schemes.put("interpark=-=mbook",  "비밀번호를 5회 이상=-=아이디 또는 비밀번호를=-=자동방지 문자를 잘못");
			schemes.put("oliveyoung",  "비밀번호를");
			//20220721 검토중
			
			/* schemes.put("homeplus", "아이디 또는 비밀번호를 확인");
			schemes.put("11st", "아이디 혹은 패스워드가=-=다시 입력해주시기 바랍니다.=-=비밀번호 5회 오류");
			schemes.put("hnsmall", "아이디 또는 비밀번호를 잘못입력하셨습니다.");			
			schemes.put("interpark", "비밀번호를 5회 이상=-=아이디 또는 비밀번호를=-=자동방지 문자를 잘못");//20210218 에러팝업 처리
			schemes.put("gmarket", "로그인에 실패하였습니다=-=비밀번호 입력시도 횟수가=-=아이디 확인 후 다시 입력=-=죄송합니다.=-=비밀번호는 15자리");//20210218 에러팝업 처리
			schemes.put("gsshop", "로그인 실패");
			schemes.put("cjmall", "아이디나 비밀번호가 틀립니다");
			schemes.put("cjonstyle", "아이디나 비밀번호가 틀립니다");
			schemes.put("auction", "로그인에 실패=-=비밀번호 입력시도 횟수가");
			//20220711 조건 추가
			//schemes.put("coupang", "새로운 환경에서 로그인 할 경우 본인=-=아이디 또는 비밀번호를 10회 틀렸습니다"); 
			schemes.put("coupang", "아이디 또는 비밀번호를 10회 틀렸습니다=-=이메일 또는 비밀번호를 다시 확인하세요=-=아이디(이메일)는 이메일 형식으로 입력해주세요");
			
			schemes.put("g9", "로그인에 실패하였습니다=-=아이디 또는 비밀번호를=-=비밀번호를 확인");//20210218 에러팝업 처리
			schemes.put("akmall", "아이디 또는 비밀번호가 일치하지 않습니다");//20210218 에러팝업 처리
			schemes.put("hmall", "비밀번호를 5회 이상=-=잘못 입력하셨습니다");
			//롯데 계열 한묶음 SSO로 동일한 로직 - 롯데아이몰만 따로적용 
			//조건 추가 필요 로그인 실패 메시지 :비밀번호를 5회 잘못 입력하셨어요. 고객님의 정보보호를 위해 비밀번호 변경 후 로그인 해 주세요.
			
			schemes.put("lotteon.", "일치하는 회원정보가 없습니다=-=비밀번호를 5회=-=서비스 이용이 불가한"); //mart
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", "일치하는 회원정보가 없습니다=-=비밀번호를 5회=-=서비스 이용이 불가한");
			schemes.put("lotteon.=-=/ellotte=-=/product/LE", "일치하는 회원정보가 없습니다=-=비밀번호를 5회=-=서비스 이용이 불가한");
			schemes.put("lotteimall", "일치하는 회원정보가 없습니다=-=비밀번호 입력 5회");
			//신세계 계열 한묶음 SSO로 동일한 로직
			schemes.put("ssg", "다시 확인하신 후 입력해주세요=-=실패하셨습니다=-=로그인에 실패하였습니다=-=아이디 또는 비밀번호를 확인해 주세요=-=존재하지 않는 회원입니다");//20210218 에러팝업 처리
			schemes.put(".emart", "다시 확인하신 후 입력해주세요=-=실패하셨습니다=-=로그인에 실패하였습니다=-=아이디에 공백이 포함");//20210218 에러팝업 처리
			schemes.put("shinsegaemall", "다시 확인하신 후 입력해주세요=-=실패하셨습니다=-=로그인에 실패하였습니다");//20210218 에러팝업 처리
			schemes.put("aladin", "입력하신 로그인 정보");
			schemes.put("musinsa", "아이디 또는 패스워드=-=로봇방지 문항을");
			schemes.put("interpark=-=mbook",  "비밀번호를 5회 이상=-=아이디 또는 비밀번호를=-=자동방지 문자를 잘못");
			schemes.put("oliveyoung",  "비밀번호를"); */
		} catch (Exception e) {
		}
	} else if (scheme.equals("lc_timeOut")) {//ios 3.7.4 타임 아웃 조건 기다린다 .. 쿠키 확인리 페이지 바로다음에 안되는경우  
		try {
			schemes.put("lotteimall", "Y");
		} catch (Exception e) {

		}
	} else if (scheme.equals("lBgSzUAgntChng")) { //웹뷰 userAgent 변경  ipad, 갤폴더에서 자동로그인이 모바일 웹이 아니라 임의 수정함
		try {
			schemes.put("wemakeprice", "Y");
			schemes.put("cjmall", "Y");
			schemes.put("cjonstyle", "Y");
			schemes.put("tmon", "Y");
			schemes.put(".emart", "Y");
			schemes.put("auction", "Y");
			schemes.put("g9", "Y");
			schemes.put("gsshop", "Y");
		} catch (Exception e) {

		}
	} else if (scheme.equals("isRightSetting")) { //안드로이드 웹뷰 세팅 디폴트로 할지 말지 설정 Y  라이트 N 디폴트 설정 - 에누리코어 도메인 개편_2019 쇼핑몰로그인쿠키통합 시트 참고
		try {
			schemes.put("11st", "Y");
			schemes.put("gmarket", "N");
			schemes.put("g9", "N");
			schemes.put("auction", "N");
			schemes.put("interpark", "Y");
			schemes.put(".emart", "Y");
			schemes.put("shinsegaemall", "Y");
			schemes.put("ssg", "Y");
			schemes.put("gsshop", "Y");
			schemes.put("wemakeprice", "Y");
			schemes.put("tmon", "Y");
			schemes.put("cjmall", "N");
			schemes.put("cjonstyle", "N");
			schemes.put("akmall", "N");
			schemes.put("lotteon.", "N");
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", "N");//마트
			schemes.put("lotteon.=-=/ellotte=-=/product/LE", "N");//엘롯데
			schemes.put("lotteimall", "N");
			schemes.put("hnsmall", "Y");
			schemes.put("coupang", "N");
			schemes.put("homeplus", "N");
			schemes.put("hmall", "N");

		} catch (Exception e) {
		}

	}

	else if (scheme.equals("lcJavascript")) { //3.6.3 자바스크립트 호출로 로그인 성공 실패 확인
		try {
			schemes.put("gsfresh",
					"(function(){if ($('#footWrap li:eq(1) > a').text() == '로그인') return '0'; else return '1'  })()");

			schemes.put("cjthemarket", "(function(){ \n"
					+ "var result = document.querySelector('#header > div.header-wrap > div > ul > li:nth-child(2) > a').textContent;\n"
					+ "if (result == '로그아웃')\n" + "	return '1';\n" + "	else return '0';\n" +

					"})()"); //마트
			schemes.put("hmall", "document.getElementsByTagName('html')[0].innerHTML"); //마트
		} catch (Exception e) {
		}

	} else if (scheme.equals("ld")) { // 로그인 쿠키 도메인
		try {
			schemes.put("11st", "http://m.11st.co.kr");
			schemes.put("gmarket", "https://m.gmarket.co.kr");
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
			schemes.put("cjonstyle", "http://display.cjonstyle.com");
			schemes.put("hmall", "https://www.hmall.com/");
			schemes.put("akmall", "https://m.akmall.com");
			schemes.put("homeplus", "https://mfront.homeplus.co.kr");
			//schemes.put(".lotte.com", "http://m.lotte.com");
			schemes.put("lotteon.", "https://www.lotteon.com");

			schemes.put("lotteon.=-=/lottemart=-=/product/LM", "https://www.lotteon.com");//마트
			//schemes.put("lottemart","https://www.lotteon.com");//마트
			schemes.put("lotteon.=-=/ellotte=-=/product/LE", "https://www.lotteon.com");//엘롯데
			schemes.put("lotteimall", "http://m.lotteimall.com");
			//신 엘롯데 링크 20181101
			schemes.put("ellotte", "https://m.display.ellotte.com");
			//구 엘롯데 링크
			//schemes.put("ellotte", "http://m.ellotte.com");
			schemes.put("hnsmall", "https://m.hnsmall.com");
			//schemes.put("coupang", "https://mc.coupang.com");//IOS 는  이값 상관없음
			schemes.put("coupang", "https://m.coupang.com");//IOS 는 이값 상관없음
			//	schemes.put("lottemart", "http://m.lottemart.com");
			schemes.put("epost", "https://mall.epost.go.kr/mo/main/mobileMain.do");
			schemes.put("kyobo", "http://mobile.kyobobook.co.kr");
			schemes.put("yes24", "http://m.yes24.com/MyPage");
			schemes.put("aladin", "https://www.aladin.co.kr/m/main.aspx");
			schemes.put("musinsa", "https://www.musinsa.com/");
			schemes.put("interpark=-=mbook", "https://mbook.interpark.com");
			schemes.put("oliveyoung", "https://m.oliveyoung.co.kr/m/main/main.do");
			schemes.put("amoremall", "https://m.amoremall.com/kr/ko/display/main");
		} catch (Exception e) {
		}
	} else if (scheme.equals("icb")) { // 아이폰용 큰 아이콘 이미지
		try {
			schemes.put("11st", "");
			schemes.put("gmarket", "");
			schemes.put("auction", "app_icon_166_auction");

			schemes.put("interpark", "app_icon_166_interpark");
			schemes.put(".emart", "app_icon_166_emart");
			schemes.put("shinsegaemall", "app_icon_166_shinsegaemall");
			schemes.put("ssg", "app_icon_166_ssg");
			schemes.put("wemakeprice", "");
			schemes.put("tmon", "app_icon_166_timon_200408");
			schemes.put("cjmall", "app_icon_166_cjmall");
			//schemes.put("cjonstyle", "app_icon_166_cjmall");
			schemes.put("homeplus", "app_icon_166_homeplus");
			if (isDev) {
				schemes.put("aladin", "app_icon_166_aladin");
				schemes.put("kyobo", "app_icon_166_kyobo");
				schemes.put("epost", "app_icon_166_postkmall");
				schemes.put("yes24", "app_icon_166_yes24");
			} else {
				schemes.put("aladin", "");
				schemes.put("kyobo", "");
				schemes.put("epost", "");
				schemes.put("yes24", "");
			}
			schemes.put("akmall", "");
			schemes.put("hnsmall", "");
			//	schemes.put(".lotte.com", "app_icon_166_lotteon_20200428");
			schemes.put("lotteon.", "app_icon_166_lotteon_20200428");
			//신 엘롯데 11월 1일 0시에 닫고 출근해서 오픈
			schemes.put("ellotte", "app_icon_166_ellotte");
			schemes.put("musinsa", "");
			schemes.put("interpark=-=mbook", "");
			schemes.put("oliveyoung", "");
			schemes.put("amoremall", "");
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
			if (appName.equals("enuri") && version < 304) {
				schemes.put("auction", " ");
			} else {
				schemes.put("auction",
						"http://mitem.auction.co.kr=-=http://mobile.auction.co.kr=-=http://mmya.auction.co.kr");
			}
			schemes.put("interpark", "http://m.shop.interpark.com/");
			schemes.put(".emart", "http://m.emart.ssg.com");
			schemes.put("shinsegaemall", "http://m.shinsegaemall.ssg.com");
			schemes.put("ssg", "http://m.ssg.com");
			schemes.put("gsshop", "http://m.gsshop.com/");
			schemes.put("wemakeprice", "https://mw.wemakeprice.com/");
			schemes.put("tmon", "http://m.tmon.co.kr/");
			schemes.put("cjmall", "http://fdrive.cjmall.com/m=-=http://mw.cjmall.com/m/item");
			schemes.put("cjonstyle", "https://display.cjonstyle.com/m");
			//	if(isDev)
			schemes.put("homeplus", "http://m.homeplus.co.kr");

			//schemes.put("hmall", " ");
			//schemes.put("akmall", " ");
			//schemes.put("homeplus", " ");
			//schemes.put(".lotte.com", " ");
			//schemes.put("lotteimall", " ");
			//schemes.put("ellotte", " ");
			//schemes.put("hnsmall", " ");
			//schemes.put("coupang", "https://mc.coupang.com/");
			schemes.put("coupang", "https://m.coupang.com/=-=https://mc.coupang.com/");
			//안드로이드 이 url 값만 있으면 리워드 수집 몰 확인 됨
			//	schemes.put("smartstore.naver.com/asmall19/", "naver.com");

			/* 20201208 reward_shop_list.json 파일과 동일하게 수집하지 않는 리워드 쇼핑몰을 삭제함
				참고 :
				1.구글시트 [EMS PUSH 리스트]
				2.re 해당 부분 주석처리 (네이버 팜 스토어 리워드 수집 추가 건이 예상 됨으로 삭제하지 않음)
				3.getDefine_Core.jsp 3곳 수정함 20201208 검색
				- 손진욱
			
				schemes.put("smartstore.naver.com/inlstore/", "naver.com");
				if (isDev) {
					schemes.put("smartstore.naver.com/lgxnote/", "naver.com");
					schemes.put("smartstore.naver.com/jojo/", "naver.com");
					schemes.put("smartstore.naver.com/lgmedia/", "naver.com");
				}
				schemes.put("smartstore.naver.com/samsung_mall/", "naver.com");
				if (isDev)
					schemes.put("feelway.com", "https://www.feelway.com");
			*/
			schemes.put("smartstore.naver.com/guidecom/", "naver.com");

			/* if (isMartStartVersion(appName, version, os)) {
				schemes.put("homeplus", "http://m.homeplus.co.kr"); //마트
			} */

			schemes.put("skstoa.com", "https://m.skstoa.com");

		} catch (Exception e) {
		}
	} else if (scheme.equals("ic")) {
		// 안드로이드 아이콘, iOS는 icb가 없으면 이 아이콘을 가져 온다. 개편 3.6.3? 이후로는 ic만 사용
		/*20200522 규칙을 변경 함 -> 구글 문서 주소 https://docs.google.com/spreadsheets/d/1ppoJAKRJSfIoDfoKHKNH7m6wGpzeau_uFig8vo863mw/edit?usp=sharing
		"	[[[[[[[중요 사용 방법 중요]]]]]]]]]
			1. getDefine_Core의 ic 값 세팅은
			   -> shopMainLogo.json파일의 img_auto_small,img_auto_big 값이 있을 때 img_auto_small의 값에서 /mobilefirst/browser/marketicon/, _on.png 값을 제외한 값을 ic에 넣었다
		
			2.앱의 적용 방법
			  -> 개발하는 앱은 ic의 값이 있는 지만 확인하고 이미지는 shopMainLogo.json의 img_auto_small, img_auto_big 의 데이터를 사용한다
		
		 ** 앱은 3.6.4 부터 적용하고
		 ** 이전 앱 확인 방법 아래의 링크가 잘나오는지 확인하면 된다
		 ** http://img.enuri.info/images/mobilefirst/browser/marketicon/[ic]_on.png
		 ** http://img.enuri.info/images/mobilefirst/browser/marketicon/320logo_[ic].png
		
		 ******** 새로 추가하는 아이콘도 하위 버전에 호환이 되는 방법으로 이미지 명을 세팅한다
		 */

		try {
			if (shopMainLogo != null && shopMainLogo.length() > 0) {
				for (int i = 0; i < siteNames.size(); i++) {
					for (int j = 0; j < shopMainLogo.length(); j++) {
						JSONObject shoplogo = shopMainLogo.getJSONObject(j);
						String key = siteNames.get(i);
						if (key.equals(shoplogo.optString("e_name"))) {
							if (shoplogo.has("img_auto_small") && shoplogo.has("img_auto_big")) {

								if (key.equals("g9")) {
									if (((appName.equals("enuri") && os.equals("aos") && version >= 345)
											|| os.equals("ios")) || appName.equals("social")) {
									} else
										continue;
								}

							
								if (key.equals("interpark=-=mbook")) {
									if (isOkVersion(407, 407)) {

									} else {
										continue;
									}
								}

								/* if (key.equals("lotteon.")
										|| key.equals("lotteon.=-=/lottemart=-=/product/LM")
										|| key.equals("lotteon.=-=/ellotte=-=/product/LE")
										|| key.equals("coupang")){
									if (os.equals("aos") && version < 364)
										continue;
								} */

								//마트 노출 버전에서만 보이고 아니면 패스
								//if (key.equals("cjthemarket") || key.equals("gsfresh") || key.equals("coupang")){
								if (key.equals("lotteon.=-=/lottemart=-=/product/LM")) {
									if (isOkVersion(364, 365)) {

									} else {
										continue;
									}
								}
								String ic = shoplogo.getString("img_auto_small");
								ic = ic.replace("/mobilefirst/browser/marketicon/", "");
								ic = ic.replace("_on.png", "");
								schemes.put(key, ic);
								break;
							}
						}
					}
				}
			}
		} catch (Exception e) {
		}
	} else if (scheme.equals("captcha")) {
		try {
			schemes.put("wemakeprice",
					"(function(){var captch = $('captch_img img').attr('src');if(captch == null || captch.length ==0)return '';else  return 'https://mw.wemakeprice.com'+captch})()");
		} catch (Exception e) {
		}
	} else if (scheme.equals("nic")) { // 안드로이드 아이콘, iOS는 icb가 없으면 이 아이콘을 가져 온다. ios 3.6.2 개편 이후 사용하지 않는다
		try {
			schemes.put("11st", "app_icon_11st_0714");
			schemes.put("gmarket", "app_icon_gmarket");
			schemes.put("g9", "app_icon_g9");
			schemes.put("auction", "app_icon_auction_new");
			schemes.put("interpark", "app_icon_interpark");
			schemes.put(".emart", "app_icon_emart");
			schemes.put("shinsegaemall", "app_icon_shinsegaemall");
			schemes.put("ssg", "app_icon_ssg");
			schemes.put("gsshop", "app_icon_gsshop");
			schemes.put("wemakeprice", "app_icon_wemakeprice20170330");
			schemes.put("tmon", "app_icon_ticketmonster");
			schemes.put("cjmall", "app_icon_cjmall");//90일간 비번 변경 팝업 대응
			//schemes.put("cjonstyle", "app_icon_cjmall");//90일간 비번 변경 팝업 대응
			schemes.put("hmall", "app_icon_hmall");
			schemes.put("akmall", "app_icon_akmall");
			schemes.put("e-himart", "");
			schemes.put("galleria", "app_icon_galleria");
			schemes.put("okmall", "");
			schemes.put(".nsmall.com", "app_icon_nsshopping");
			schemes.put("homeplus", "");
			//	schemes.put("lottemart", "app_icon_lottemart");
			//	schemes.put(".lotte.com", "app_icon_lotteon_20200428");
			schemes.put("lotteon.", "app_icon_lotteon_20200428");
			schemes.put("lotteimall", "");
			//신 엘롯데 11월 1일 0시에 닫고 출근해서 오픈
			schemes.put("ellotte", "app_icon_ellotte_new");
			schemes.put("hnsmall", "app_icon_homenshopping");
			//schemes.put("coupang", "app_icon_coupang");
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
			schemes.put("tmon", "티몬");
			schemes.put("cjmall", "CJ몰");
			schemes.put("cjonstyle", "CJ온스타일");
			schemes.put("hmall", "현대 hmall");
			schemes.put("akmall", "AK몰");
			schemes.put("e-himart", "하이마트");
			schemes.put("galleria", "갤러리아");
			schemes.put("okmall", "OKMALL");
			schemes.put(".nsmall.com", "ns홈쇼핑");
			schemes.put("homeplus", "홈플러스");
			//schemes.put("lottemart", "롯데마트");
			//	schemes.put(".lotte.com", "롯데ON");
			schemes.put("lotteon.", "롯데ON");

			schemes.put("lotteon.=-=/lottemart=-=/product/LM", "롯데마트");//마트
			schemes.put("lotteon.=-=/ellotte=-=/product/LE", "엘롯데");//엘롯데
			schemes.put("lotteimall", "롯데홈쇼핑");
			schemes.put("ellotte", "엘롯데");
			schemes.put("hnsmall", "홈앤쇼핑");

			schemes.put("epost", "우체국쇼핑");
			schemes.put("kyobo", "교보문고");
			schemes.put("yes24", "Yes24");
			schemes.put("aladin", "알라딘");
			schemes.put("coupang", "쿠팡");
			if (appName.equals("vaccine")) {
				schemes.put("tmon", "티몬");
				schemes.put("gsshop", "GS Shop");
				schemes.put("cjmall", "CJ mall");
				schemes.put("lotteimall", "롯데홈쇼핑");
			}
			schemes.put("musinsa", "무신사스토어");
			schemes.put("interpark=-=mbook", "인터파크도서");
			schemes.put("oliveyoung", "올리브영");
			schemes.put("amoremall", "아모레몰");
			schemes.put("skstoa.com", "SK스토아");
			
		} catch (Exception e) {
		}
	} else if (scheme.equals("m")) { // 쇼핑몰 메인 페이지 url
		try {
			schemes.put("11st", "http://m.11st.co.kr/page/main/home");
			schemes.put("gmarket", "https://m.gmarket.co.kr/");
			schemes.put("g9", "https://m.g9.co.kr/Default/Home");
			schemes.put("auction", "http://mobile.auction.co.kr/");
			schemes.put("interpark", "http://m.shop.interpark.com/");
			schemes.put(".emart", "http://m.emart.ssg.com/");
			schemes.put("shinsegaemall", "http://m.shinsegaemall.ssg.com/mall/main.ssg");
			schemes.put("ssg", "http://m.ssg.com/");
			schemes.put("gsshop", "http://m.gsshop.com/");
			schemes.put("wemakeprice", "https://mw.wemakeprice.com/main");
			schemes.put("tmon", "http://m.tmon.co.kr/");
			schemes.put("cjmall", "http://display.cjmall.com/m/homeTab/main");
			schemes.put("cjonstyle", "https://display.cjonstyle.com/m/homeTab/main");
			schemes.put("hmall", "http://www.hmall.com/");
			schemes.put("akmall", "http://m.akmall.com/");
			schemes.put("e-himart", "http://m.e-himart.co.kr/");
			schemes.put("galleria", "http://mobile.galleria.co.kr");
			schemes.put(".nsmall.com", "http://m.nsmall.com");
			schemes.put("homeplus", "http://m.homeplus.co.kr/");

			//	schemes.put(".lotte.com", "https://www.lotteon.com/m/display/main/lotteon");
			schemes.put("lotteon.", "https://www.lotteon.com/m/display/main/lotteon");
			//	schemes.put("lottemart","https://www.lotteon.com/m/display/main/lottemart");//마트
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", "https://www.lotteon.com/m/display/main/lottemart");//마트
			schemes.put("lotteon.=-=/ellotte=-=/product/LE", "https://www.lotteon.com/m/display/main/ellotte");//엘롯데
			schemes.put("lotteimall", "http://m.lotteimall.com/main/viewMain.lotte");
			//	schemes.put("coupang", "http://mc.coupang.com");
			schemes.put("coupang", "https://m.coupang.com");
			//신 엘롯데 링크 20181101
			schemes.put("ellotte", "https://m.display.ellotte.com/display-mo/shop");
			//구 엘롯데 링크
			//schemes.put("ellotte", "http://m.ellotte.com");
			schemes.put("hnsmall", "http://m.hnsmall.com");

			schemes.put("epost", "https://mall.epost.go.kr/mo/main/mobileMain.do");
			schemes.put("kyobo", "http://mobile.kyobobook.co.kr");
			schemes.put("yes24", "http://m.yes24.com");
			schemes.put("aladin", "https://www.aladin.co.kr/m/main.aspx");
			schemes.put("musinsa", "https://www.musinsa.com/app/");
			schemes.put("interpark=-=mbook", "https://mbook.interpark.com/main/");
			schemes.put("oliveyoung", "https://m.oliveyoung.co.kr/m/main/main.do");
			schemes.put("amoremall", "https://m.amoremall.com/kr/ko/display/main");
			/* if (isMartStartVersion(appName, version, os)) {
			
				//schemes.put("cjthemarket", "https://m.cjthemarket.com/mo/main");
				schemes.put("cjthemarket", "https://m.cjthemarket.com/pc/my/myMain");
				schemes.put("gsfresh", "http://m.gsfresh.com/eretail.main.dev");
			} */

		} catch (Exception e) {
		}
	} else if (scheme.equals("l")) { // 쇼핑몰 로그인 페이지 url ios 에서는 쇼핑몰에 맞게 이게 있어야지 없으면 앱 죽음
		try {
			schemes.put("11st", "https://login.11st.co.kr/auth/login.tmall");//?returnURL=&method=Xsite&tid=1000997249");
			schemes.put("gmarket", "https://mobile.gmarket.co.kr/Login/Login");
			schemes.put("g9", "https://mssl.g9.co.kr/Member.htm");
			schemes.put("auction", "https://signin.auction.co.kr/Authenticate/MobileLogin.aspx?url=");
			schemes.put("interpark", "https://accounts.interpark.com/login/form");
			schemes.put(".emart", "https://member.ssg.com/m/member/login.ssg?retURL=http%3A%2F%2Fm.emart.ssg.com");
			schemes.put("shinsegaemall", "https://member.ssg.com/m/member/login.ssg?retURL=");
			schemes.put("ssg", "https://member.ssg.com/m/member/login.ssg?retURL=");
			schemes.put("gsshop", "https://m.gsshop.com/member/logIn.gs");// "http://m.gsshop.com/member/logIn.gs");
			schemes.put("tmon", "https://m.tmon.co.kr/user/loginForm");
			schemes.put("cjmall",
					"https://base.cjmall.com/m/page/account/login?returnUrl=http%3A%2F%2Fdisplay.cjmall.com%2Fm%2FhomeTab%2Fmain");
			schemes.put("cjonstyle", "https://base.cjonstyle.com/m/page/account/login");
			schemes.put("hmall", "https://www.hmall.com/m/smLoginF.do");
			schemes.put("e-himart", "");// "https://m.e-himart.co.kr/login.hmt?page=myHimart");
			schemes.put("galleria", "");
			schemes.put("okmall", "");
			schemes.put(".nsmall.com", "");// "http://m.nsmall.com/MemberLogin");

			if (os.equals("aos") && version < 364) {
				schemes.put("coupang", "https://login.coupang.com/login/login.pang");//"https://login.coupang.com/login/login.pang");
				schemes.put("lotteon.", "https://www.lotteon.com/p/member/login/common");//https://m.lotte.com/login/m/loginForm.do
				//	schemes.put("lottemart","https://www.lotteon.com/p/member/login/common");//마트
				schemes.put("lotteon.=-=/lottemart=-=/product/LM", "https://www.lotteon.com/p/member/login/common");//마트
				schemes.put("lotteon.=-=/ellotte=-=/product/LE", "https://www.lotteon.com/p/member/login/common");//엘롯데
			} else {
				//schemes.put("coupang", "https://login.coupang.com/login/login.pang?rtnUrl=https%3A%2F%2Fmc.coupang.com");//"https://login.coupang.com/login/login.pang");
				schemes.put("coupang", "https://login.coupang.com/login/login.pang?rtnUrl=http://m.coupang.com/");
				schemes.put("lotteon.",
						"https://www.lotteon.com/m/member/login/common?rtnUrl=https://www.lotteon.com/p/order/mylotte/orderDeliveryList");//https://m.lotte.com/login/m/loginForm.do
				schemes.put("lotteon.=-=/lottemart=-=/product/LM",
						"https://www.lotteon.com/m/member/login/common?rtnUrl=https://www.lotteon.com/p/order/mylotte/orderDeliveryList");//마트
				//	schemes.put("lottemart","https://www.lotteon.com/p/member/login/common?rtnUrl=https://www.lotteon.com/p/order/mylotte/orderDeliveryList");//마트
				schemes.put("lotteon.=-=/ellotte=-=/product/LE",
						"https://www.lotteon.com/m/member/login/common?rtnUrl=https://www.lotteon.com/p/order/mylotte/orderDeliveryList");//엘롯데
			}
			if (os.equals("aos") && version > 368 && version < 376) {
				schemes.put("wemakeprice",
						"https://mw.wemakeprice.com/user/login?returnUrl=https://mw.wemakeprice.com/mypage");
			} else {
				schemes.put("wemakeprice", "https://mw.wemakeprice.com/user/login");
			}

			schemes.put("lotteimall", "https://securem.lotteimall.com/jsp/member/login/forward.LCLoginMem.lotte");
			schemes.put("akmall", "https://m.akmall.com/login/Login.do");
			schemes.put("hnsmall", "https://m.hnsmall.com/customer/login");
			//	schemes.put("lottemart", "https://www.lottemart.com/imember/login/ssoLoginPop.do?addParam=MMARTSHOP@@https://m.lottemart.com/mobile/mypage/PMWMMAR0001.do");
			if (version >= 377) { //3.7.7 부터 =-= 배열사용
				schemes.put("homeplus", "https://mfront.homeplus.co.kr/mypage=-=https://sso.homeplus.co.kr/refit/login=-=https://sso.homeplus.co.kr/login");
			} else {
				schemes.put("homeplus", "https://sso.homeplus.co.kr/login");
			}

			schemes.put("epost",
					"https://m.epost.go.kr/mobile/login/cafzc008k02.jsp?s_url=https://mall.epost.go.kr:443/mo/main/mobileMain.do");
			schemes.put("kyobo", "https://mobile.kyobobook.co.kr/login");
			schemes.put("yes24",
					"https://m.yes24.com/Momo/Templates/FTLogin.aspx?ReturnUrl=http%3a%2f%2fm.yes24.com%2fMyPage");
			schemes.put("aladin",
					"https://www.aladin.co.kr/m/mlogin.aspx?returnurl=https%3a%2f%2fwww.aladin.co.kr%2fm%2fmain.aspx&start=alayer");
			schemes.put("musinsa","https://www.musinsa.com/auth/login?");
			schemes.put("interpark=-=mbook","https://accounts.interpark.com/login/form");
			schemes.put("oliveyoung","https://m.oliveyoung.co.kr/m/login/loginForm.do");
			schemes.put("amoremall","https://m.amoremall.com/kr/ko/login?");
			//신 엘롯데 링크 20181101
			schemes.put("ellotte", "https://m.members.ellotte.com/members-mo/login/form");
			//구 엘롯데 링크
			//schemes.put("ellotte", "https://m.ellotte.com/login/m/loginForm.do?c=&udid=&v=&cn=&cdn=&schema=");

		} catch (Exception e) {
		}
	} else if (scheme.equals("lhtml")) {
		try {
			schemes.put("wemakeprice", "wemakeprice.com/user/password/advice");
			schemes.put("cjmall", "cjmall.com/m/myzone/main");
			schemes.put("cjonstyle", "cjonstyle.com/m/myzone/main");
			schemes.put("hmall", "hmall.com/m/smLoginF.do");
		} catch (Exception e) {
		}

	} else if (scheme.equals("i")) { //쇼핑몰 로그인페이지에서 로그인 하는 스크립트
		try {
			//schemes.put("11st", "$('#userId').val('[[id]]');$('#userPw').val('[[pwd]]');$('#alg').prop('checked',true);$('#loginButton').click();");

			schemes.put("11st",
					"$('#memId').val('[[id]]');$('#memPwd').val('[[pwd]]');$('#keepsave').attr('checked', true);$('.login_box > .bbtn').click();");

			schemes.put("gmarket", "$('#id').val('[[id]]');$('#pwd').val('[[pwd]]');checkValid(this);");
			schemes.put("g9", "$('#LoginID').val('[[id]]');$('#Password').val('[[pwd]]');$('.btn_login').click();");
			schemes.put("auction",
					"$('#id').val('[[id]]');$('#password').val('[[pwd]]');$('#chkAutoLogin').attr('checked', true);$('#btnLogin').click();");
			//schemes.put("interpark", "$('#userId').val('[[id]]');$('#userPwd').val('[[pwd]]');$('.btn_login').click();");
			schemes.put("interpark",
					"$('#userId').val('[[id]]');$('#userPwd').val('[[pwd]]');$( '#ipLogin' ).removeClass( 'BtnLogin off' ).addClass( 'BtnLogin' );setTimeout($('#btn_login').click(),1000);");
			schemes.put(".emart", "$('#inp_id').val('[[id]]');$('#inp_pw').val('[[pwd]]');$('#login_form').submit();");
			schemes.put("shinsegaemall",
					"$('#inp_id').val('[[id]]');$('#inp_pw').val('[[pwd]]');$('.bn_pnk').click();");
			schemes.put("ssg", "$('#inp_id').val('[[id]]');$('#inp_pw').val('[[pwd]]');$('.bn_pnk').click();");
			schemes.put("gsshop", "$('#id').val('[[id]]');$('#passwd').val('[[pwd]]');$('#btnLogin').click();");
			schemes.put("wemakeprice",
					"$('#_loginId').val('[[id]]');$('#_loginPw').val('[[pwd]]');$('#_userLogin').click();");
			schemes.put("tmon",
					//"$('#user_id').val('[[id]]');$('#user_pw').val('[[pwd]]');$('form').submit();");
					"$('#user_form_id').val('[[id]]');$('#user_form_pw').val('[[pwd]]');$('#login').click();");

			schemes.put("cjmall",
					"$('#id_input').val('[[id]]');$('#password_input').val('[[pwd]]');$('#loginSubmit').click();setTimeout(function(){$('#close_layer').click();},5000)");
			schemes.put("cjonstyle",
					"$('#id_input').val('[[id]]');$('#password_input').val('[[pwd]]');$('#loginSubmit').click();setTimeout(function(){$('#close_layer').click();},5000)");
			schemes.put("hmall",
					"$(\"input[name='userid']\").val('[[id]]');$(\"input[name='password']\").val('[[pwd]]');$('#loginCheck').click();");
			schemes.put("akmall", "$('#cust_id').val('[[id]]');$('#passwd').val('[[pwd]]');$('#loginBtn').click();");
			schemes.put("e-himart", "");
			schemes.put("galleria", "");
			schemes.put("okmall", "");
			schemes.put(".nsmall.com",
					"$('#txtUserId').val('[[id]]');$('#txtPassword').val('[[pwd]]');$('#btnLogin').click();");
			schemes.put("homeplus",
					"$('#loginId').val('[[id]]'); $('#pwd').val('[[pwd]]'); setTimeout(function(){login();},1000);");
			//schemes.put("lottemart", "$('#loginid_old1').val('[[id]]'); $('#password_old1').val('[[pwd]]'); $('#btnLogin1').click();");
			//schemes.put(".lotte.com", "$('#userId').val('[[id]]');$('#lPointPw').val('[[pwd]]');angular.element('[ng-click]').scope().checkLogin('N');");
			schemes.put("lotteon.",
					"window.vueComponent.inId = '[[id]]'; 	window.vueComponent.Password = '[[pwd]]';	$('.btnConfirmWrap button').click();");

			//	schemes.put("lottemart","window.vueComponent.inId = '[[id]]'; 	window.vueComponent.Password = '[[pwd]]';	$('.btnConfirmWrap button').click();");//마트
			schemes.put("lotteon.=-=/lottemart=-=/product/LM",
					"window.vueComponent.inId = '[[id]]'; 	window.vueComponent.Password = '[[pwd]]';	$('.btnConfirmWrap button').click();");//마트
			schemes.put("lotteon.=-=/ellotte=-=/product/LE",
					"window.vueComponent.inId = '[[id]]'; 	window.vueComponent.Password = '[[pwd]]';	$('.btnConfirmWrap button').click();");//엘롯데

			schemes.put("lotteimall",
					"$('#login_id').val('[[id]]');$('#password').val('[[pwd]]');setTimeout(function(){$('#btn_login').click()},700)");

			//신 엘롯데
			schemes.put("ellotte",
					"$('#mbrLoginId1').val('[[id]]');$('#mbrLoginPwd1').val('[[pwd]]');$('#tab_pan-01 .btnLogin').click();");
			//구 엘롯데
			//schemes.put("ellotte", "$('#userId').val('[[id]]');$('#lPointPw').val('[[pwd]]');angular.element('[ng-click]').scope().checkLogin('N');");
			schemes.put("hnsmall",
					"$(\"input[name='mem_id']\").val('[[id]]');$(\"input[name='mem_pw']\").val('[[pwd]]');login(document.loginForm);");

			schemes.put("epost",
					"document.getElementById('id').value='[[id]]'; document.getElementById('passwd').value='[[pwd]]'; checkVal();");
			schemes.put("kyobo",
					"$('#j_username').val('[[id]]'); $('#j_password').val('[[pwd]]'); $('#btnLogin').click();");
			schemes.put("yes24",
					"$('#SMemberID').val('[[id]]'); $('#SMemberPassword').val('[[pwd]]'); $('#btn_login').click();");
			schemes.put("aladin", "$('#Email').val('[[id]]'); $('#Password').val('[[pwd]]'); javascript:fn_submit();");
			schemes.put("coupang",
					"$('#login-email-input').val('[[id]]');$('#login-password-input').val('[[pwd]]');$('#login-keep-state').attr('checked', true);$('.login__button').click();");

			/* if (isMartStartVersion(appName, version, os)) {
				schemes.put("cjthemarket",
						//"$('#id_input').val('[[id]]');$('#password_input').val('[[pwd]]');$('#loginSubmit').click();setTimeout(function(){$('#close_layer').click();},5000)");
			
						"$('span.input-text > input').val('[[id]]');"+
						"$('span.input-password > input').val('[[pwd]]');"+
						"$('#loginBtn').click();");
			
			
				//"$('#label01').val('[[id]]')$('#label02').val('[[pwd]]')$('#loginBtn').click()");
				schemes.put("gsfresh", "$('#webId').val('[[id]]');$('#webPwd').val('[[pwd]]');$('#btnLogIn').click();");
			
			} */
		} catch (Exception e) {
		}
	} else if (scheme.equals("j")) { // 쇼핑몰 바로 로그인 스크립트
		try {
			schemes.put("11st", "");
			//schemes.put(
			//		"gmarket",
			//		"<form style=\"visibility:hidden\" name=lf method=post action=\"https://mobile.gmarket.co.kr/Login/Login\"><input name=\"url\" value=\"\"><input name=\"id\" id=\"id\" value=\"[[id]]\"><input name=\"pwd\" id=\"pwd\" value=\"[[pwd]]\"></form><script>lf.submit();</script>");
			schemes.put("g9",
					"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://apissl.g9.co.kr/api/Authentication/DoLogin\"><input name=\"RedirectUrl\" value=\"http://m.g9.co.kr/Default/Home\"><input name=\"LoginID\" value=\"[[id]]\"><input name=\"Password\" value=\"[[pwd]]\"><input name=\"SaveLoginIdYN\" value=\"true\"><input name=\"AutoLoginYN\" value=\"false\"></form><script>lf.submit();</script>");
			schemes.put("auction",
					"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://signin.auction.co.kr/Authenticate/login.aspx\"><input name=\"seller\" type=\"hidden\" value=\"\"><input name=\"seqno\" type=\"hidden\" value=\"\"><input name=\"url\" value=\"\"><input name=\"id\" value=\"[[id]]\"><input name=\"password\" value=\"[[pwd]]\"></form><script>lf.submit();</script>");
			//schemes.put("interpark", "<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://m.interpark.com/auth/_ajax/login.html\"><input name=\"fromSVC\" type=\"hidden\" value=\"shop\"><input name=\"retUrl\" type=\"hidden\" value=\"https%3A%2F%2Fm.interpark.com%2Fmy%2Fshop%2Fbuylist.html\"><input name=\"userId\" value=\"[[id]]\"><input name=\"userPwd\" value=\"[[pwd]]\"></form><script>lf.submit();</script>");
			//20171206 포스트 업데이트
			//schemes.put("interpark", "<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://m.interpark.com/auth/_ajax/login.html?callback=ipk_member_callback\"><input name=\"fromSVC\" value=\"shop\"><input name=\"userId\" value=\"[[id]]\"><input name=\"userPwd\" value=\"[[pwd]]\"><input name=\"saveSess\" value=\"Y\"><input name=\"saveId\" value=\"Y\"></form><script>lf.submit();</script>");
			//schemes.put(
			//		".emart",
			//		"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://member.ssg.com/m/member/login.ssg\"><input name=\"mbrLoginId\" value=\"[[id]]\"><input name=\"password\" value=\"[[pwd]]\"><input name=\"keepLogin\" value=\"Y\"></form><script>lf.submit();</script>");
			schemes.put(".emart",
					"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://member.ssg.com/m/member/login.ssg\"><input name=\"mbrLoginId\" id=\"inp_id\" value=\"[[id]]\"><input name=\"password\" id=\"inp_pw\" value=\"[[pwd]]\"><input name=\"keepLogin\" value=\"Y\"></form><script>lf.submit();</script>");
			schemes.put("shinsegaemall",
					"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://member.ssg.com/m/member/login.ssg\"><input name=\"mbrLoginId\" id=\"inp_id\" value=\"[[id]]\"><input name=\"password\" id=\"inp_pw\" value=\"[[pwd]]\"><input name=\"keepLogin\" value=\"Y\"></form><script>lf.submit();</script>");
			schemes.put("ssg",
					"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://member.ssg.com/m/member/login.ssg\"><input name=\"mbrLoginId\" id=\"inp_id\" value=\"[[id]]\"><input name=\"password\" id=\"inp_pw\" value=\"[[pwd]]\"><input name=\"keepLogin\" value=\"Y\"></form><script>lf.submit();</script>");
			schemes.put("gsshop",
					"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://m.gsshop.com/member/j_spring_security_check\"><input name=\"id\" value=\"[[id]]\"><input name=\"passwd\" value=\"[[pwd]]\"></form><script>lf.submit();</script>");
			//schemes.put(
			//		"tmon",
			//		"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://m.tmon.co.kr/user/login\"><input name=\"id\" value=\"[[id]]\"><input name=\"pw\" value=\"[[pwd]]\"><input name=\"au\" value=\"1\"></form><script>lf.submit();</script>");
			//schemes.put(
			//		"hmall",
			//		"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://m.hyundaihmall.com/front/smLoginP.do\"><input name=\"userid\" value=\"[[id]]\"><input name=\"password\" value=\"[[pwd]]\"></form><script>lf.submit();</script>");
			schemes.put("akmall",
					"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://m.akmall.com/login/LoginProc2.do\"><input name=\"goUrl\" value=\"/mypage/OrderDeliInquiry.do\"><input name=\"urlpath\" value=\"\"><input name=\"token\" value=\"\"><input name=\"checkedNoSSL\" value=\"Y\"><input name=\"cust_id\" value=\"[[id]]\"><input name=\"passwd\" value=\"[[pwd]]\"><input name=\"keep_id\" value=\"Y\"><input name=\"autoLogin\" value=\"Y\">/form><script>lf.submit();</script>");
			schemes.put("e-himart", "");
			schemes.put("galleria", "");
			schemes.put("okmall", "");
			schemes.put(".nsmall.com", "");
			//schemes.put(
			//		"homeplus",
			//		"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://m.homeplus.co.kr:448/identity/loginProc.do\"><input name=\"login_id\" value=\"[[id]]\"><input name=\"user_passwd\" value=\"[[pwd]]\"><input name=\"chkautologin\" value=\"Y\"></form><script>lf.submit();</script>");
			//schemes.put("lottemart", "");
			//20171206 포스트 업데이트
			//schemes.put(".lotte.com", "<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://m.lotte.com/json/login.json\"><input name=\"userId\" value=\"[[id]]\"><input name=\"lPointPw\" value=\"[[pwd]]\"><input name=\"auto\" value=\"1\"><input name=\"save\" value=\"1\"><input name=\"autoEasy\" value=\"1\"><input name=\"saveEasy\" value=\"1\"></form><script>lf.submit();</script>");
			//20171206 포스트 업데이트
			//schemes.put("ellotte", "<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://m.ellotte.com/json/login.json\"><input name=\"userId\" value=\"[[id]]\"><input name=\"lPointPw\" value=\"[[pwd]]\"><input name=\"auto\" value=\"1\"><input name=\"save\" value=\"1\"><input name=\"autoEasy\" value=\"1\"><input name=\"saveEasy\" value=\"1\"></form><script>lf.submit();</script>");
			//schemes.put(
			//		"hnsmall",
			//		"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://m.hnsmall.com/customer/loginproc\"><input name=\"mem_id\" value=\"[[id]]\"><input name=\"mem_pw\" value=\"[[pwd]]\"></form><script>lf.submit();</script>");
			//schemes.put(
			//		"coupang",
			//		"<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" action=\"https://login.coupang.com/login/loginProcess.pang\"><input name=\"email\" id=\"login-tf-email\" value=\"[[id]]\"><input name=\"password\" id=\"login-tf-password\" value=\"[[pwd]]\"></form><script>lf.submit();</script>");
		} catch (Exception e) {
		}
	} else if (scheme.equals("hbridge") || scheme.equals("h")) { // 수익코드 붙은 쇼핑몰 메인페이지 url
		try {
			String server = isDev ? "dev" : "m";

			if (shopMainLogo != null && shopMainLogo.length() > 0) {
				for (int i = 0; i < siteNames.size(); i++) {
					for (int j = 0; j < shopMainLogo.length(); j++) {
						JSONObject shoplogo = shopMainLogo.getJSONObject(j);
						String key = siteNames.get(i);
						if (key.equals(shoplogo.optString("e_name"))) {
							schemes.put(key,
									"http://" + server + ".enuri.com/mobilefirst/move2.jsp?vcode="
											+ shoplogo.optString("shop") + "&freetoken=outlink&url="
											+ URLEncoder.encode(shoplogo.optString("move"), "UTF-8"));
							break;
						}
					}
				}
			}

			/*
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
					"hmall",
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
			
			//schemes.put(
				//	"lottemart",
					//"http://"
						//	+ server
							//+ ".enuri.com/mobilefirst/move2.jsp?vcode=7455&freetoken=outlink&url=http%3A%2F%2Fm.lottemart.com%2Fmobile%2Fmobile_main.do%3FAFFILIATE_ID%3D01030001%26CHANNEL_CD%3D00056");
			/////////////////////////////
			
			//	schemes.put(".lotte.com", "http://" + server
			//			+ ".enuri.com/mobilefirst/move2.jsp?vcode=49&freetoken=outlink&url=http%3A%2F%2Fm.lotte.com%2Fmain_phone.do%3Fudid%3D%26cn%3D112346%26cdn%3D783491");
			schemes.put("lotteon.", "http://" + server
					+ ".enuri.com/mobilefirst/move2.jsp?vcode=49&freetoken=outlink&url=https%3A%2F%2Fm.lotteon.com%2Fp%2Fdisplay%2Fmain%2Flotteon%3Fmall_no%3D1%26ch_no%3D100077%26ch_dtl_no%3D1000235");
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
			schemes.put("coupang", "http://" + server
					+ ".enuri.com/mobilefirst/move2.jsp?vcode=7861&freetoken=outlink&url=https%3A%2F%2Flink.coupang.com%2Fre%2FPCSENURIMOHOME");
			
			/////////////////////////////
			schemes.put("epost", "http://" + server
					+ ".enuri.com/mobilefirst/move2.jsp?vcode=5438&freetoken=outlink&url=http://mallscm.epost.go.kr/postif/epostPartner.do?p=enuri");
			schemes.put("kyobo", "http://" + server + ".enuri.com/mobilefirst/move2.jsp?vcode=6367&freetoken=outlink&url=");
			schemes.put("yes24", "http://" + server + ".enuri.com/mobilefirst/move2.jsp?vcode=3367&freetoken=outlink&url=http://www.yes24.com/Main/default.aspx?pid=95673");
			schemes.put("aladin", "http://" + server + ".enuri.com/mobilefirst/move2.jsp?vcode=4861&freetoken=outlink");
			
			if (isMartStartVersion(appName, version, os)) {
				schemes.put("cjthemarket", "https://m.cjthemarket.com/mo/my/myMain");//"http://" + server + ".enuri.com/mobilefirst/move2.jsp?vcode=6165&freetoken=outlink");
				schemes.put("gsfresh", "http://" + server + ".enuri.com/mobilefirst/move2.jsp?vcode=6622&freetoken=outlink");
			
			}
			 */
		} catch (Exception e) {
		}
	} else if (scheme.equals("my")) { // 마이페이지 url
		try {
			schemes.put("11st", "http://m.11st.co.kr/MW/MyPage/mypageMain.tmall");
			schemes.put("gmarket", "http://mmyg.gmarket.co.kr/home");
			schemes.put("g9", "https://m.g9.co.kr/MyPage.htm#/MyPage/PurchaseInfo");
			schemes.put("auction", "http://mmya.auction.co.kr/MyAuction/");
			schemes.put("interpark", "https://m.interpark.com/my/shop/index.html?b=1");
			schemes.put(".emart", "http://m.ssg.com/myssg/main.ssg?emart=&enuriget=.emart");
			schemes.put("shinsegaemall", "http://m.ssg.com/myssg/main.ssg?shinsegaemall=&enuriget=shinsegaemall");
			schemes.put("ssg", "http://m.ssg.com/myssg/main.ssg");
			schemes.put("gsshop", "http://m.gsshop.com/mygsshop/myOrderList.gs");
			schemes.put("wemakeprice", "http://m.wemakeprice.com/m/mypage/order_list/ship");
			schemes.put("tmon", "http://m.tmon.co.kr/mytmon/list");
			schemes.put("cjmall", "https://mw.cjmall.com/m/mycj/index.jsp?pic=MYZONE&app_cd=ENURI");

			schemes.put("cjonstyle", "https://base.cjonstyle.com/m/myzone/main");
			schemes.put("hmall", "https://www.hmall.com/m/smOrderPeriodL.do");
			schemes.put("akmall", "https://m.akmall.com/mypage/OrderDeliInquiry.do");
			schemes.put("e-himart", "");
			schemes.put("galleria", "");
			schemes.put("okmall", "");
			schemes.put(".nsmall.com", "http://m.nsmall.com");
			schemes.put("homeplus", "https://mfront.homeplus.co.kr/mypage");
			//	schemes.put("lottemart", "http://m.lottemart.com/mobile/mypage/PMWMMAR0001.do");
			//	schemes.put(".lotte.com", "https://www.lotteon.com/p/mylotte/index/main");
			schemes.put("lotteon.", "https://www.lotteon.com/m/mylotte/index/main");

			//	schemes.put("lottemart","https://www.lotteon.com/m/mylotte/index/main");//마트
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", "https://www.lotteon.com/m/mylotte/index/main");//마트
			schemes.put("lotteon.=-=/ellotte=-=/product/LE", "https://www.lotteon.com/m/mylotte/index/main");//엘롯데

			schemes.put("lotteimall", "https://securem.lotteimall.com/mypage/searchOrderListFrame.lotte");
			//신 엘롯데
			schemes.put("ellotte", "https://m.order.ellotte.com/order-mo/cart");
			//구 엘롯데
			//schemes.put("ellotte", "https://m.ellotte.com/mylotte/purchase/m/purchase_list.do");
			schemes.put("hnsmall", "https://m.hnsmall.com/mypage/order/list");
			schemes.put("coupang", "http://m.coupang.com/m/my.pang");
			schemes.put("epost", "https://mall.epost.go.kr/mo/mypage/mypageMainSearch.do");
			schemes.put("kyobo", "http://order.kyobobook.co.kr/myroom/main?Kc=GNHHNOmyrom&orderClick=Oi4");
			schemes.put("yes24", "http://m.yes24.com/MyPage");
			schemes.put("aladin", "https://www.aladin.co.kr/m/maccount.aspx?pType=orderlist&start=alayer");
			schemes.put("musinsa", "https://www.musinsa.com/member/mypage");
			schemes.put("interpark=-=mbook", "https://mbook.interpark.com/my/main");
			schemes.put("oliveyoung", "https://m.oliveyoung.co.kr/m/mypage/myPageMain.do");
			schemes.put("amoremall", "https://m.amoremall.com/kr/ko/my/page/onlineOrderShipping");
			/* if (isMartStartVersion(appName, version, os)) {
				schemes.put("cjthemarket", "https://m.cjthemarket.com/mo/my/myMain");
				schemes.put("gsfresh", "https://m.gsfresh.com/eretail.mypage.mypageMain.dev");
			
			}
			 */
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
			schemes.put("hmall", "");
			schemes.put("akmall", "");
			schemes.put("e-himart", "");
			schemes.put("galleria", "");
			schemes.put("okmall", "");
			schemes.put(".nsmall.com", "");
			schemes.put("homeplus", "");
			//	schemes.put("lottemart", "");
			//	schemes.put(".lotte.com", "");
			schemes.put("lotteon.", "");
			//	schemes.put("lottemart","");//마트
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", "");//마트
			schemes.put("lotteon.=-=/ellotte=-=/product/LE", "");//엘롯데

			schemes.put("lotteimall", "");
			schemes.put("ellotte", "");
			schemes.put("hnsmall", "");
			schemes.put("coupang", "");
			schemes.put("epost", "");
			schemes.put("kyobo", "");
			schemes.put("yes24", "");
			schemes.put("aladin", "");
			schemes.put("musinsa", "");
			schemes.put("interpark=-=mbook", "");
			schemes.put("oliveyoung", "");
			schemes.put("amoremall", "");
		} catch (Exception e) {
		}
	} else if (scheme.equals("o")) { // 로그아웃 url
		try {

			schemes.put("11st", "http://m.11st.co.kr/MW/Login/logout.tmall");
			schemes.put("gmarket", "https://mobile.gmarket.co.kr/LogOut");
			schemes.put("g9", "https://apissl.g9.co.kr/api/Authentication/Logout");
			schemes.put("auction", "https://memberssl.auction.co.kr/Authenticate/Logout.aspx");//http://member.auction.co.kr/Authenticate/Logout.aspx
			schemes.put("interpark", "https://accounts.interpark.com/logout");
			schemes.put(".emart", "https://member.ssg.com/m/member/logout.ssg");
			schemes.put("shinsegaemall", "https://member.ssg.com/m/member/logout.ssg");
			schemes.put("ssg", "https://member.ssg.com/m/member/logout.ssg");
			schemes.put("gsshop", "http://m.gsshop.com/member/logOut.gs");
			schemes.put("wemakeprice", "https://mw.wemakeprice.com/logout");
			//"call_ajax('GET','/m/member/logout',false,function(data){if(data['result']==1){window.location ='https://member.wemakeprice.com/m/member/login/'}else {alert(data['msg']);}});");
			schemes.put("tmon", "http://m.tmon.co.kr/user/logout");
			schemes.put("cjmall", "https://base.cjmall.com/m/page/account/logout");
			schemes.put("cjonstyle", "https://base.cjonstyle.com/m/page/account/logout");
			//schemes.put("cjmall", "https://mw.cjmall.com/m/login/logout.jsp");
			schemes.put(".nsmall.com", "");
			schemes.put("homeplus", "https://front.homeplus.co.kr/user/login/logout.json");
			//	schemes.put(".lotte.com", "http://m.lotte.com/login/logout.do");
			schemes.put("lotteon.",
					"https://www.lotteon.com/search/render/render.ecn?&render=nqapi&collection_id=6&platform=m&u9=categoryLayer&u10=1&login=Y");//로그아웃 못찾음
			//	schemes.put("lottemart","https://www.lotteon.com/search/render/render.ecn?&render=nqapi&collection_id=6&platform=m&u9=categoryLayer&u10=1&login=Y");//마트
			schemes.put("lotteon.=-=/lottemart=-=/product/LM",
					"https://www.lotteon.com/search/render/render.ecn?&render=nqapi&collection_id=6&platform=m&u9=categoryLayer&u10=1&login=Y");//마트
			schemes.put("lotteon.=-=/ellotte=-=/product/LE",
					"https://www.lotteon.com/search/render/render.ecn?&render=nqapi&collection_id=6&platform=m&u9=categoryLayer&u10=1&login=Y");//엘롯데

			schemes.put("lotteimall", "https://securem.lotteimall.com/member/goLogout.lotte");
			//신 엘롯데
			schemes.put("ellotte", "https://m.members.ellotte.com/members-mo/logout");
			//구 엘롯데
			//schemes.put("ellotte", "http://m.ellotte.com/login/logout.do");
			//	schemes.put("lottemart", "https://m.lottemart.com/mobile/integration/logout.do");
			schemes.put("coupang", "https://login.coupang.com/login/logout.pang");
			schemes.put("akmall", "https://m.akmall.com/login/Logout.do");
			schemes.put("hnsmall", "https://m.hnsmall.com/customer/logout");
			schemes.put("hmall", "https://www.hmall.com/m/smLogoutP.do?returnUrl=/m/index.do");
			schemes.put("epost", "https://m.epost.go.kr/mobile/login/MemLogout.jsp");
			schemes.put("kyobo", "https://mobile.kyobobook.co.kr/j_spring_security_checkout?orderClick=O72");
			schemes.put("yes24", "https://m.yes24.com/Momo/Templates/FTLogOut.aspx");
			schemes.put("aladin", "https://www.aladin.co.kr/m/mlogout.aspx");
			schemes.put("musinsa", "https://www.musinsa.com/auth/logout");
			schemes.put("interpark=-=mbook","https://accounts.interpark.com/logout");
			schemes.put("oliveyoung","https://m.oliveyoung.co.kr/login/logout.do");
			schemes.put("amoremall","https://m.amoremall.com/kr/ko/my/page/info/myPouch");
			/* if (isMartStartVersion(appName, version, os)) {
				schemes.put("cjthemarket", "https://m.cjthemarket.com/pc/auth/logout?redirectUrl=");
				schemes.put("gsfresh", "http://m.gsfresh.com/eretail.logout.dev?alertYn=N");
			
			} */
		} catch (Exception e) {
		}
	} else if (scheme.equals("oScript")) { // 로그아웃 스크립트 o로 링크 하고 oScript 가 있으면 스크립트 실행 추가
		try {
			schemes.put("lotteon.", "econJs.fn.memberLogout('https://pbf.lotteon.com')");//로그아웃 못찾음
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", "econJs.fn.memberLogout('https://pbf.lotteon.com')");//로그아웃 못찾음
			schemes.put("lotteon.=-=/ellotte=-=/product/LE", "econJs.fn.memberLogout('https://pbf.lotteon.com')");//로그아웃 못찾음
			
			schemes.put("amoremall","AP.login.out();");

		} catch (Exception e) {
		}
	} else if (scheme.equals("oScript2021")) { // 로그아웃 스크립트 o로 링크 하고 피니쉬일때 oscript2021이있으면 처리하고 아니면  oScript 스크립트 실행 
		try {
			StringBuilder sb = new StringBuilder();
			sb.append("javascript:{ \n");
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append("	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append("   if(stStartsWith(url, 'http://display.cjmall.com/m/homeTab')){ \n");
			sb.append("     window.android.logoutSuccess() \n");
			sb.append("    } \n");
			sb.append("   else if(stStartsWith(url, 'http://display.cjmall.com/p/homeTab')){ \n");
			sb.append("     window.android.logoutSuccess() \n");
			sb.append("    } \n");
			sb.append("  }catch(e){ window.android.onError(e.message+'|'+url);\n");
			sb.append("  } \n");
			sb.append("} \n");
			schemes.put("cjmall", sb.toString());

			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append("	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append("   if(stStartsWith(url, 'https://display.cjonstyle.com/m/homeTab')){ \n");
			sb.append("     window.android.logoutSuccess() \n");
			sb.append("    } \n");
			sb.append("   else if(stStartsWith(url, 'https://display.cjonstyle.com/m/homeTab')){ \n");
			sb.append("     window.android.logoutSuccess() \n");
			sb.append("    } \n");
			sb.append("  }catch(e){ window.android.onError(e.message+'|'+url);\n");
			sb.append("  } \n");
			sb.append("} \n");
			schemes.put("cjonstyle", sb.toString());

			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("    setTimeout( function(){window.android.logoutSuccess()}, 1500); \n");
			sb.append(" } \n");
			schemes.put("gmarket", sb.toString());

			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("    setTimeout( function(){window.android.logoutSuccess()}, 1500); \n");
			sb.append(" } \n");
			schemes.put("g9", sb.toString());

		} catch (Exception e) {
		}
	} else if (scheme.equals("chkreturnurl")) { //  로그인 시 체크할 리턴 url android 3.6.4
		try {
			schemes.put("lotteon.", "https://www.lotteon.com/p/order/mylotte/orderDeliveryList");//배송조회 페이지

			schemes.put("lotteon.=-=/lottemart=-=/product/LM",
					"https://www.lotteon.com/p/order/mylotte/orderDeliveryList");//배송조회 페이지
			schemes.put("lotteon.=-=/ellotte=-=/product/LE",
					"https://www.lotteon.com/p/order/mylotte/orderDeliveryList");//배송조회 페이지
			schemes.put("coupang", "https://mc.coupang.com");//배송조회 페이지
			schemes.put("wemakeprice", "https://mw.wemakeprice.com/user/password/advice");//비번번경페이지
			schemes.put("tmon", "http://m.tmon.co.kr/mytmon/list");//로그인되어 있을 경우 리턴페이지
			schemes.put("11st", "http://m.11st.co.kr/MW/html/main.html#/home");
			schemes.put("gmarket", "https://sslmember2.gmarket.co.kr/mobile/Verification/VerificationBlockAccess");
		} catch (Exception e) {
		}
	} else if (scheme.equals("loginskeepurl")) { //  로그인은 되었지만 메인페이지로 가지 않는경우, 로그인 체크페이지 =-= 어레이 안드로이드 3.6.9~
		try {
			schemes.put("wemakeprice",
					"https://mw.wemakeprice.com/user/password/advice=-=https://mw.wemakeprice.com/mypage");//비번번경페이지
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
			schemes.put("cjonstyle", "/m/item/;app_cd=");
			schemes.put("hmall", "/front/smitemdetailr.do;itemcode=");
			schemes.put("akmall", "/goods/goodsdetail.do;goods_id=");
			schemes.put("e-himart", "/productdetail.hmt;prditmid=");
			schemes.put("galleria", "/item/showitemdtl.do;item_id=");
			schemes.put("okmall", "/product/view.html;pid=");
			schemes.put(".nsmall.com", "m_g2600000m");
			schemes.put("homeplus", "/product/info.do;good_id=");
			//	schemes.put("lottemart", "/mobile/cate/pmwmcat0004_new.do;productcd=");
			//	schemes.put(".lotte.com", "/product/m/product_view.do;goods_no=");
			schemes.put("lotteon.", "/m/product/L");
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", "/m/product/L");
			schemes.put("lotteon.=-=/ellotte=-=/product/LE", "/m/product/L");
			schemes.put("lotteimall", "/goods/viewgoodsdetail.lotte;goods_no=");
			schemes.put("ellotte", "/product/m/product_view.do;goods_no=");
			schemes.put("hnsmall", "/goods/view/");
			schemes.put("coupang", "/nm/products/");
			/* if (isMartStartVersion(appName, version, os)) {
				schemes.put("cjthemarket", "");
				schemes.put("gsfresh", "");
			} */

		} catch (Exception e) {
		}
	} else if (scheme.equals("p2")) { // 쇼핑몰 vip 페이지 구분자
		try {
			schemes.put("auction", "ego.aspx;p==-=/vip");
			schemes.put("gsshop", "/deal/deal.gs;dealno=");
			schemes.put("wemakeprice", "mobile_app/direct_to_app");
			schemes.put("cjmall", "/m/mocode;app_cd=");
			schemes.put("cjonstyle", "/m/mocode;app_cd=");
			schemes.put("coupang", "/vm/products/");
			schemes.put("ssg", "/item/itemdtl.ssg?itemid=");
		} catch (Exception e) {
		}
	} else if (scheme.equals("shopCode")) {
		try {
			schemes.put("11st", 5910);
			schemes.put("gmarket", 536);
			schemes.put("g9", 7692);
			schemes.put("auction", 4027);
			schemes.put("interpark", 55);
			schemes.put(".emart", 374); //mart
			schemes.put("shinsegaemall", 47);
			schemes.put("ssg", 6665);
			schemes.put("gsshop", 75);
			schemes.put("wemakeprice", 6508);
			schemes.put("tmon", 6641);
			schemes.put("cjmall", 806);
			schemes.put("cjonstyle", 806);
			schemes.put("hmall", 57);
			schemes.put("akmall", 90);
			schemes.put("e-himart", 6252);
			schemes.put("galleria", 6620);
			schemes.put("okmall", 6427);
			schemes.put(".nsmall.com", 974);

			schemes.put("homeplus", 6361); //mart
			schemes.put("lotteon.", 49); //mart

			schemes.put("lotteon.=-=/lottemart=-=/product/LM", 7455);//마트
			schemes.put("lotteon.=-=/ellotte=-=/product/LE", 6547);//엘롯데

			/* schemes.put("lotteon|lottemart", 49); //mart
			schemes.put("lotteon|lotte.com", 49); //mart
			schemes.put("lotteon|ellottee", 49); //mart */
			schemes.put("lotteimall", 663);
			schemes.put("ellotte", 6547);
			schemes.put("hnsmall", 6588);
			schemes.put("coupang", 7861);//mart
			schemes.put("epost", 5438);
			schemes.put("kyobo", 6367);
			schemes.put("yes24", 3367);
			schemes.put("aladin", 4861);
			schemes.put("musinsa", 24763);
			schemes.put("cjthemarket", 6165); //mart
			schemes.put("gsfresh", 6622); //mart
			schemes.put("skstoa.com",9011);
			schemes.put("interpark=-=mbook",6711);
			schemes.put("oliveyoung",32203);
			schemes.put("amoremall", 32205); 
		} catch (Exception e) {
		}
	}

	else if (scheme.equals("id")) { // 쇼핑몰 id, 안드로이드 가격백신에서 사용
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
			schemes.put("cjonstyle", 12);
			schemes.put("hmall", 13);
			schemes.put("akmall", 14);
			schemes.put("e-himart", 15);
			schemes.put("galleria", 16);
			schemes.put("okmall", 17);
			schemes.put(".nsmall.com", 18);
			schemes.put("homeplus", 19);
			//	schemes.put("lottemart", 20);
			//	schemes.put(".lotte.com", 21);
			schemes.put("lotteon.", 21);
			schemes.put("lotteimall", 22);
			schemes.put("ellotte", 23);
			schemes.put("hnsmall", 24);
			schemes.put("coupang", 25);
		} catch (Exception e) {
		}
	} else if (scheme.equals("info")) { //	vip에서 가격과 제목을 가져옴
		try {
			schemes.put("11st",
					"(function(){return $('.dtl_tit').text().trim()+\"EnuRi\"+$('link[rel=\"image_src\"]').attr('href')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.dtl_total .prc b').text();})()");
			schemes.put("gmarket",
					"(function(){return $('title').text()+\"EnuRi\"+$('meta[property=\"og:image\"]').attr('content')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.pri1').text();})()");
			schemes.put("g9",
					"(function(){return $('.info_area .prod_cont .info_box .tit2').text()+\"EnuRi\"+$('.item_bnr .thmb img').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.info_area .price').text();})()");
			schemes.put("auction",
					"(function(){return $('.title span').text()+\"EnuRi\"+ $('.content-slider').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.elements_info .price .ng-scope strong').text();})()");
			schemes.put("interpark",
					"(function(){return $('#sub_title').text()+\"EnuRi\"+$('.slide').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+ $('.discountedPrice .numeric').text()+'원';})()");
			schemes.put(".emart",
					"(function(){return $('.article-title h3').text()+\"EnuRi\"+$('.flick-ct').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.article-title .sale').text().trim();})()");
			schemes.put("shinsegaemall",
					"(function(){return $('.txt01 em').text()+\"EnuRi\"+$('.flick-ct').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.pr_area .price').text();})()");
			schemes.put("ssg",
					"(function(){return $('.mallprd_info h3').text().trim().replaceAll('\t','')+\"EnuRi\"+$('.flick-ct').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.price_area strong').text().trim();})()");
			schemes.put("gsshop",
					"(function(){return $('.prdNames').text()+\"EnuRi\"+$('.swiper-slide-active').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.infoPrice strong ').text()+'원';})()");
			schemes.put("wemakeprice",
					"(function(){return $('.info-area #main_name').text()+\"EnuRi\"+$('#img_app_onecut').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.price_area .sale').text();})()");
			schemes.put("tmon",
					"(function(){return $('.info h2').text()+\"EnuRi\"+$('.deal_summary').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.pr .dc').text();})()");
			schemes.put("cjmall",
					"(function(){  var a =$('.flick-container').find('img:eq(0)').attr('src'); if(a.indexOf('?')!=-1) a= a.substring(0,a.indexOf('?')); if(a.indexOf('http:')==-1)a='http:'+a;return $('.prd_info h1').text().trim()+\"EnuRi\"+a+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.prd_price .price strong').text()+'원';})()");
			schemes.put("hmall",
					"(function(){return $('.title1 h2').text()+\"EnuRi\"+$('#detailPageImgSlide .selected img').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.price1').text();})()");
			schemes.put("akmall",
					"(function(){return $('.info_top h2').text().trim()+\"EnuRi\"+'http:'+$('.swiper-wrapper').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.discount').text();})()");
			schemes.put("galleria",
					"(function(){var a = $('.pri'); if(a.length>1) a=a.eq(1).text();else a=a.text();return $('.dt_pr .dt_pr_tx strong').text()+' '+$('.dt_pr .dt_pr_tx .min').text()+\"EnuRi\"+$('#dtSwipeList img').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+a.replace('₩','');})()");
			schemes.put(".nsmall.com",
					"(function(){return $('.test #productName').text()+\"EnuRi\"+$('.swipe_bannerArea.goods_thumbnailArea').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('#txtOfferPriceIns').text();})()");
			schemes.put("homeplus",
					"(function(){return $('.discount').text() +' '+$('.heading h2').text()+\"EnuRi\"+$('.flex-active-slide').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.value1').text();})()");
			//schemes.put(
			//		"lottemart",
			//		"(function(){return $('.goodstitle').text()+\"EnuRi\"+$('.swiper-wrapper').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('#ItemCurrSalePrc').text()+'원';})()");
			//schemes.put(".lotte.com",
			//		"(function(){return $('.titText').text()+\"EnuRi\"+$('.dSwipeImg').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.titPrice').text().trim();})()");
			schemes.put("lotteon.", "");
			schemes.put("lotteimall",
					"(function(){return $('#goodsNm').text()+\"EnuRi\"+$('.prodCont.clfix').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.price.dc_price .big').text();})()");
			schemes.put("ellotte",
					"(function(){return $('.titText').text()+\"EnuRi\"+$('.dSwipeImg').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.titPrice').text().trim();})()");
			schemes.put("hnsmall",
					"(function(){return $('h2.tit').text().trim()+\"EnuRi\"+$('.pd_img.bxslider').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('strong.priceRed').text()+'원';})()");
			schemes.put("coupang",
					"(function(){if($('#totalSalesPrice').val()!=null)return $('.title').eq(0).text()+\"EnuRi\"+$('#pdpImages').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('#totalSalesPrice').text();else return $('.clearfix dt').text()+\"EnuRi\"+$('.detail-main').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.detail-main-info  .clearfix .sale-price').text();})()");
		} catch (Exception e) {
		}
	} else if (scheme.equals("order")) { // 로그인 확인하기 위한 페이지 
		try {
			schemes.put("11st", "https://login.11st.co.kr/auth/login.tmall");//"http://m.11st.co.kr/MW/MyPage/V1/orderMngList.tmall");// "http://m.11st.co.kr/MW/MyPage/mypageMain.tmall");
			schemes.put("gmarket", "https://mmyg.gmarket.co.kr/v2");
			schemes.put("g9", "https://m.g9.co.kr/MyInfo.htm#/MyPage/PurchaseInfo");

			//schemes.put("g9","https://www.g9.co.kr/Display/Favorite");

			schemes.put("auction", "https://mmya.auction.co.kr/MyAuction/Order/#/OrderList");
			//schemes.put("auction", "https://cart.auction.co.kr/ko-m/cart");
			schemes.put("interpark", "https://smshop.interpark.com/my/shop/buylist.html");
			schemes.put(".emart", "https://pay.ssg.com/m/myssg/orderInfo.ssg");

			schemes.put("shinsegaemall", "https://pay.ssg.com/m/myssg/orderInfo.ssg");
			schemes.put("ssg", "https://pay.ssg.com/m/myssg/orderInfo.ssg");
			schemes.put("gsshop", "http://m.gsshop.com/mygsshop/myOrderList.gs");
			//schemes.put("wemakeprice", "https://mescrow.wemakeprice.com/cart/cartList");
			
			schemes.put("wemakeprice", "https://mw.wemakeprice.com/mypage/orders?schType=paymentComplete");

			
			schemes.put("tmon", "https://delivery.tmon.co.kr/m/mytmon/orders/purchase/all");
			schemes.put("cjmall", "https://base.cjmall.com/m/myzone/orderList?");
			schemes.put("cjonstyle", "https://base.cjonstyle.com/m/myzone/main");
			schemes.put("hmall", "https://www.hmall.com/m/smOrderPeriodL.do");
			schemes.put("akmall", "https://m.akmall.com/mypage/OrderDeliInquiry.do");
			
			//schemes.put("homeplus", "https://mfront.homeplus.co.kr/mypage");
			
			schemes.put("homeplus", "https://mfront.homeplus.co.kr/mypage/orders");
			//schemes.put("homeplus","https://mfront.homeplus.co.kr/mypage");
			
			schemes.put("lotteon.", "https://www.lotteon.com/m/order/mylotte/orderDeliveryList");
			schemes.put("lotteon.=-=/lottemart=-=/product/LM",
					"https://www.lotteon.com/m/order/mylotte/orderDeliveryList");//마트
			schemes.put("lotteon.=-=/ellotte=-=/product/LE",
					"https://www.lotteon.com/m/order/mylotte/orderDeliveryList");//엘롯데
			schemes.put("lotteimall", "https://securem.lotteimall.com/mypage/searchOrderListFrame.lotte");
			schemes.put("hnsmall", "https://m.hnsmall.com/mypage/order/list");
			schemes.put("coupang", "https://mc.coupang.com/ssr/mobile/order/list");
			schemes.put("epost", "https://mall.epost.go.kr/mo/mypage/mypageMainSearch.do");
			schemes.put("kyobo", "http://order.kyobobook.co.kr/myroom/order/orderList");
			schemes.put("yes24", "https://ssl.yes24.com/mMyPage/MyPageOrderList");
			schemes.put("aladin", "https://www.aladin.co.kr/m/maccount.aspx?pType=orderlist");
			schemes.put("musinsa", "https://www.musinsa.com/app/mypage/order_list_opt");
			schemes.put("interpark=-=mbook", "https://mbook.interpark.com/shop/ordersearch/main");
			schemes.put("oliveyoung", "https://m.oliveyoung.co.kr/m/mypage/getOrderList.do");
			schemes.put("amoremall", "https://m.amoremall.com/kr/ko/my/page/onlineOrderShipping");
			
		} catch (Exception e) {
		}
	} else if (scheme.equals("shopStatus")) { // 쇼핑몰 로그인 리스트 보여지기 상태  visible = 보이기, gone = 안보이기 , repair = 공사중
		try {
			schemes.put("11st", "visible");
			schemes.put("gmarket", "visible");
			schemes.put("g9", "visible");
			schemes.put("auction", "visible");
			schemes.put("interpark", "visible");
			schemes.put(".emart", "visible");
			schemes.put("shinsegaemall", "visible");
			schemes.put("ssg", "visible");
			schemes.put("gsshop", "visible");
			schemes.put("wemakeprice", "visible");
			schemes.put("tmon", "visible");
			schemes.put("cjmall", "gone");
			schemes.put("cjonstyle", "visible");
			schemes.put("akmall", "visible");

			schemes.put("lotteon.", "visible");
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", "visible");//마트
			schemes.put("lotteon.=-=/ellotte=-=/product/LE", "gone");//엘롯데
			schemes.put("lotteimall", "visible");
			schemes.put("ellotte", "gone");
			schemes.put("hnsmall", "visible");
			schemes.put("coupang", "visible");
			schemes.put("homeplus", "visible");
			schemes.put("hmall", "visible");
			schemes.put("epost", "visible");
			schemes.put("kyobo", "visible");
			schemes.put("yes24", "visible");
			schemes.put("aladin", "visible");
			schemes.put("musinsa", "visible");
			schemes.put("interpark=-=mbook", "visible");
			if(isDev) {
				schemes.put("oliveyoung","visible");
				schemes.put("amoremall","visible");
			}else{
				schemes.put("oliveyoung","gone");
				schemes.put("amoremall","gone");
			}
		} catch (Exception e) {
		}
	}
	else if (scheme.equals("iosSTWkWebView")){
		try {
			schemes.put("gsshop", true);
			schemes.put("coupang", true);
			schemes.put("cjmall", true);
			schemes.put("cjonstyle", true);
		} catch (Exception e) {
			
		}
	}
	else if (scheme.equals("iosST2Setmall")){
		
		try {
			schemes.put("wemakeprice", true);
		} catch (Exception e) {
			
		}
	}
	else if (scheme.equals("stopst")) { 
		// ios에서 쇼핑몰 로그인 되어있어도 크롤링 시도 하지 않도록 하기위함
	
		//all 모두 정지 
		//login 앱 로그인 후  라이브러리 로그인 정지 
		//craw 크롤링 정지 (홈, 마이에서 도는 경우)
	
		try {
		/* 	schemes.put("cjmall", "all");
			schemes.put("cjonstyle", "all"); */
			
		} catch (Exception e) {
			
		}
	}
	else if (scheme.equals("setloginAgnt")) {
		try {
			    schemes.put("coupang",  "Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1");
		} catch (Exception e) {
			
		}
	}else if (scheme.equals("inputHint")) { // 로그인할때 인풋 hint 
		try {
			schemes.put("11st", new JSONObject().put("ihint","아이디").put("phint","비밀번호(8~20자)"));
			schemes.put("gmarket", new JSONObject().put("ihint","아이디").put("phint","비밀번호"));
			schemes.put("g9", new JSONObject().put("ihint","아이디").put("phint","비밀번호"));
			schemes.put("auction", new JSONObject().put("ihint","아이디").put("phint","비밀번호"));
			schemes.put("interpark", new JSONObject().put("ihint","아이디").put("phint","비밀번호"));
			schemes.put(".emart", new JSONObject().put("ihint","아이디").put("phint","비밀번호"));
			schemes.put("shinsegaemall", new JSONObject().put("ihint","아이디").put("phint","비밀번호"));
			schemes.put("ssg", new JSONObject().put("ihint","아이디").put("phint","비밀번호"));
			schemes.put("gsshop", new JSONObject().put("ihint","아이디 또는 이메일").put("phint","비밀번호(영문+숫자 조합 6~16자)"));
			schemes.put("wemakeprice",  new JSONObject().put("ihint","아이디 또는 이메일").put("phint","비밀번호"));
			schemes.put("tmon",  new JSONObject().put("ihint","아이디").put("phint","비밀번호"));
			schemes.put("cjmall", new JSONObject().put("ihint","아이디(6~12자)").put("phint","비밀번호(영문+숫자+특수문자 조합  6~12자)"));
			schemes.put("cjonstyle", new JSONObject().put("ihint","아이디(6~12자)").put("phint","비밀번호(영문+숫자+특수문자 조합  6~12자)"));
			schemes.put("akmall",  new JSONObject().put("ihint","아이디").put("phint","비밀번호"));
			schemes.put("homeplus", new JSONObject().put("ihint","아이디").put("phint","비밀번호(대/소문자 구분)"));
			schemes.put("lotteon.", new JSONObject().put("ihint","아이디 또는 이메일").put("phint","비밀번호(영문+숫자+특수문자 조합 8~15자)"));
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", new JSONObject().put("ihint","아이디 또는 이메일").put("phint","비밀번호(영문+숫자+특수문자 조합 8~15자)"));//마트
			schemes.put("lotteon.=-=/ellotte=-=/product/LE", new JSONObject().put("ihint","아이디 또는 이메일").put("phint","비밀번호(영문+숫자+특수문자 조합 8~15자)"));//엘롯데
			schemes.put("lotteimall", new JSONObject().put("ihint","아이디 또는 이메일").put("phint","비밀번호"));
			schemes.put("ellotte", new JSONObject().put("ihint","아이디 또는 이메일").put("phint","비밀번호(영문+숫자+특수문자 조합 8~15자)"));
			schemes.put("hnsmall", new JSONObject().put("ihint","아이디(영문+숫자 4자 이상)").put("phint","비밀번호(영문+숫자 8자 이상)"));
			schemes.put("coupang",  new JSONObject().put("ihint","이메일").put("phint","비밀번호"));
			schemes.put("hmall",  new JSONObject().put("ihint","아이디 또는 이메일").put("phint","비밀번호"));
			schemes.put("epost",new JSONObject().put("ihint","아이디").put("phint","비밀번호"));
			schemes.put("kyobo", new JSONObject().put("ihint","아이디").put("phint","비밀번호"));
			schemes.put("yes24", new JSONObject().put("ihint","아이디").put("phint","비밀번호"));
			schemes.put("aladin", new JSONObject().put("ihint","아이디 또는 이메일").put("phint","비밀번호"));
			schemes.put("musinsa", new JSONObject().put("ihint","아이디").put("phint","비밀번호"));
			schemes.put("interpark=-=mbook", new JSONObject().put("ihint","아이디").put("phint","비밀번호"));
		} catch (Exception e) {
			
		}
	} else if (scheme.equals("isCookie")) { // 로그인상태를 쿠키체크로 할 수 있는 몰인지 아닌지 구분
		try {
			schemes.put("11st", "true");
			schemes.put("gmarket", "true");
			schemes.put("g9", "true");
			schemes.put("auction", "true");
			schemes.put("interpark", "true");
			schemes.put(".emart", "true");
			schemes.put("shinsegaemall", "true");
			schemes.put("ssg", "true");
			schemes.put("gsshop", "true");
			schemes.put("wemakeprice", "true");
			schemes.put("tmon", "true");
			schemes.put("cjmall", "true");
			schemes.put("cjonstyle", "true");
			schemes.put("akmall", "true");
			schemes.put("homeplus", "true");
			schemes.put("lotteon.", "true");
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", "true");//마트
			schemes.put("lotteon.=-=/ellotte=-=/product/LE", "true");//엘롯데
			schemes.put("lotteimall", "true");
			schemes.put("ellotte", "true");
			schemes.put("hnsmall", "true");
			if (os.equals("ios")) {//20210218 ios는 meber_srl 쿠키가 있어도 로그인이 안되는 경우가 있다 
				schemes.put("coupang", "false");
			} else {
				schemes.put("coupang", "true");
			}
			//schemes.put("coupang", "true");
			schemes.put("hmall", "false");
			schemes.put("epost", "true");
			schemes.put("kyobo", "true");
			schemes.put("yes24", "true");
			schemes.put("aladin", "true");
			schemes.put("musinsa", "true");
			schemes.put("interpark=-=mbook", "true");
			schemes.put("oliveyoung", "true");
			schemes.put("amoremall", "true");
		} catch (Exception e) {
		}
	}
	else if (scheme.equals("LRP")) //LRP 로그인 런 퍼센트  4.1.1에서 홈플러스의 경우 87퍼센트이상에서 로그인 시도
	{
		try {
			schemes.put("homeplus", 87);
		} catch (Exception e) {
		}
	}
	else if (scheme.equals("LTO")) // 로그인 타임아웃 4.1.1 홈플러스의 경우 로그인 타임 아웃 늘림 
	{
		try {
			schemes.put("homeplus", 60);
		} catch (Exception e) {
		}
	}
	else if (scheme.equals("i2021")) { //쇼핑몰 로그인페이지에서 로그인 하는 스크립트
		try {
			/* schemes.put("11st", 5910);				schemes.put("gmarket", 536);				schemes.put("g9", 7692);
			schemes.put("auction", 4027);				schemes.put("interpark", 55);				schemes.put(".emart", 374); //mart
			schemes.put("shinsegaemall", 47);				schemes.put("ssg", 6665);				schemes.put("gsshop", 75);
			schemes.put("wemakeprice", 6508);				schemes.put("tmon", 6641);				schemes.put("cjmall", 806);
			schemes.put("hmall", 57);				schemes.put("akmall", 90);				schemes.put("e-himart", 6252);
			schemes.put("galleria", 6620);				schemes.put("okmall", 6427);				schemes.put(".nsmall.com", 974);
			schemes.put("homeplus", 6361);				schemes.put("lotteon.", 49); 
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", 7455);				schemes.put("lotteon.=-=/ellotte=-=/product/LE", 6547);
			schemes.put("lotteimall", 663);				schemes.put("ellotte", 6547);				schemes.put("hnsmall", 6588);
			schemes.put("coupang", 7861);				schemes.put("epost", 5438);				schemes.put("kyobo", 6367);
			schemes.put("yes24", 3367);				schemes.put("aladin", 4861);				schemes.put("cjthemarket", 6165);
			schemes.put("gsfresh", 6622); */
			//goLogin 기본 true 그밖에 false
			//최초 로그인 시도하기위해서는 true이지만 window.android.goLogin()이 앱으로 호출된이후는 false로 
			//해서 떨어지는 링크가 홈이냐 마이메뉴이냐 확인해서 성공을 처리한다 
			//그외에 실패 확인은 팝업, 타임 아웃 으로 확인

			//window.android.onLoginFail()// 대응도 하자 

			//https://sd-login.sweettracker.net/getLoginRule?version=1&appVersion=1.0.0&osVersion=10&shopCode=51&os=Android
			//ShopMainLogo.json 에 "s_shop" 이 ST 샵코드임
			
			StringBuilder sb = new StringBuilder();

			sb.append("javascript:{ \n");
			sb.append("var strId = '[[id]]'; \n");
			sb.append("var strPw = '[[pwd]]'; \n");
			sb.append("var goLogin = [[gologin]] ; \n");
			if(version >= 407){
				sb.append("var snstype = '[[snstype]]' ; \n");
			}else{
				sb.append("var snstype = '' ; \n");
			}
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append("	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			sb.append("    function checkError() {\n");
			sb.append("       try{\n");
			sb.append("         	 var formerror= document.getElementsByClassName('form-msg')[0];\n");
			//sb.append("         	     console.log('formerror> '+formerror); \n");
			sb.append("         	 if( formerror.style.display == ''){\n");
			//sb.append("         	 if(formerror.length > 1 && formerror[0].style.display == 'block'){\n");
			
			sb.append(						loginfailData("로그인_실패_계정불일치", version));
			sb.append("         	 }else { \n");
			
			sb.append("         	 } \n");
			sb.append("       }catch(e){\n");
			sb.append(				loginfailData("로그인_실패_기타", version));
			sb.append("        }\n");
			sb.append("    }      \n");
			sb.append("    function callPruchaseUrl() {\n");
			sb.append("       try{\n");
			sb.append("         	document.location = 'http://m.11st.co.kr/MW/MyPage/V1/orderMngList.tmall'; \n");
			sb.append("       }catch(e){\n");
			sb.append("       }\n");
			sb.append("    }      \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append("    if(stStartsWith(url, 'http://m.11st.co.kr/MW/html/main.html')){ \n");
			sb.append("     	window.android.onLoginSuccess() \n");
			sb.append("     }else if(url== 'https://m.11st.co.kr/page/main/home'){  \n");
			sb.append("     	setTimeout(callPruchaseUrl(), 500);  \n");
			sb.append("     }else if(stStartsWith(url, 'https://auth.skt-id.co.kr/auth/authorize.do')){ \n"); //T아이디
			sb.append("       setTimeout( function(){");
			sb.append("      	window.android.runLogin();  \n");
			sb.append("      	var tidlist = document.getElementsByClassName('account-list');  \n");
			sb.append("      	if(tidlist.length > 0){  \n");
			sb.append("      	    tidlist[0].children[0].children[1].click();  \n");
			sb.append("      	}  \n");
			sb.append("          document.getElementById('userId').value = strId;\n");
			sb.append("          document.getElementById('password').value = strPw;\n");
			sb.append("          document.getElementById('authLogin').disabled = false;\n");
			sb.append("          document.getElementById('authLogin').click();\n");
		
			sb.append("      }, 1000); \n");
			sb.append("          setTimeout(checkError(), 4000);\n");
			sb.append("    }else if(stStartsWith(url, 'http://m.11st.co.kr/page/main/home')){ \n");
			sb.append("          window.android.onLoginSuccess() \n");
			sb.append("    }else if(stStartsWith(url, 'http://m.11st.co.kr/MW/MyPage/mypageMain.tmall')){ \n");
			sb.append("          window.android.onLoginSuccess() \n");
			sb.append("    }else if(stStartsWith(url, 'http://m.11st.co.kr/MW/MyPage/V1/orderMngList.tmall')){ \n");
			sb.append("         	window.android.onLoginSuccess() \n");
			sb.append("    }else if(url=='http://m.11st.co.kr/MW'){ \n");
			sb.append("     	    window.android.onLoginSuccess() \n");
			sb.append("    }else if(stStartsWith(url, 'https://member.11st.co.kr/find/pw')){ \n");
			sb.append(loginfailData("로그인_실패_계정불일치", version));
			sb.append("    }else if(stStartsWith(url, 'https://member.11st.co.kr/tid/agreeconnect')){ \n");
			sb.append("     		   document.getElementById('btnCancel').click(); \n");
			sb.append("    }else if (goLogin){ \n");
			sb.append("      if(snstype == 'to'){ \n");
			sb.append("         var BtnTID = document.getElementById('btn_simple_login_tid');\n");
			
			sb.append("         if(BtnTID != null && BtnTID != 'undefined' ){\n");
			sb.append("            BtnTID.click();\n"); 
			
			sb.append("         }\n");
			sb.append("      } else { \n");
			sb.append("         setTimeout( function(){");
			sb.append("      	  window.android.runLogin();  \n");
			sb.append("            document.getElementById('memId').value = strId;  \n");
			sb.append("      	  document.getElementById('memPwd').value = strPw;  \n");
			sb.append("      	  checkDataForLogin(this);  \n");
			sb.append("         },1000);");
			sb.append("      }\n");
			sb.append("    }      \n");
			sb.append("  }catch(e){ window.android.onError(document.location.href+'|'+e.message);\n");
			sb.append("  } \n");
			sb.append("} \n");
			schemes.put("11st", sb.toString());
			
			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("var strId = '[[id]]'; \n");
			sb.append("var strPw = '[[pwd]]'; \n");
			sb.append("var goLogin = [[gologin]] ; \n");
			if(version >= 407){
				sb.append("var snstype = '[[snstype]]' ; \n");
			}else{
				sb.append("var snstype = '' ; \n");
			}
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append("	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append("   if(stStartsWith(url, 'https://m.gmarket.co.kr/')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append("    }else if(stStartsWith(url, 'https://mmyg.gmarket.co.kr/v2')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			//20210218아이디 비밀번호 오류 링크 .. 뷰로 메세지 띄움
			sb.append("    }else if(url.includes('isViewFailOverPopup=true&isFailCountOver=true')){ \n");
			sb.append(loginfailData("로그인_실패_기타", version));
			sb.append("    }else if(stStartsWith(url, 'http://mobile.gmarket.co.kr/SiteOff/Notice')){ \n");
			sb.append(loginfailData("로그인_실패_사이트점검", version));
			sb.append("    }else if(stStartsWith(url, 'https://www.gmarket.co.kr/Notice-checkNotice')){ \n");
			sb.append(loginfailData("로그인_실패_사이트점검", version));
			sb.append("    }else if(stStartsWith(url, 'http://member2.gmarket.co.kr/Mobile/IDPW/PasswordChangeInform')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");


			sb.append("    }else if(stStartsWith(url, 'https://accounts.kakao.com/login?continue=')){ \n");
			sb.append("     	 window.android.runLogin();  \n");
			sb.append("    		document.getElementById('id_email_2').value = strId \n ");
			sb.append("    		document.getElementById('id_password_3').value = strPw \n");
			sb.append("    		document.querySelector('#login-form > fieldset > div.wrap_btn > button').click() \n");			
			
			sb.append("    }else if (goLogin){ \n");
			
			sb.append("      if(snstype == 'ka'){ \n");
			sb.append("     	setTimeout( function(){   \n");
			sb.append("         document.querySelector('#defaultForm > fieldset > div.at_log.mem > div.box__social-links > a').click()");
			sb.append("     		},1000);  \n");
		
			sb.append("      } else { \n");			
			sb.append("     	 window.android.runLogin();  \n");
			sb.append("     	setTimeout( function(){   \n");
			sb.append("        		document.getElementById('id').value = strId;  \n");
			sb.append("        		document.getElementById('pwd').value = strPw;  \n");
			sb.append("       		setTimeout( function(){ checkValid(this); },1000);  \n");
			sb.append("     		},1000);  \n");
			sb.append("    	}      \n");
			sb.append("    }      \n");
			sb.append("  }catch(e){ window.android.onError(document.location.href+'|'+e.message);\n");
			sb.append("  } \n");
			sb.append("} \n");
			schemes.put("gmarket", sb.toString());

			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("var strId = '[[id]]'; \n");
			sb.append("var strPw = '[[pwd]]'; \n");
			sb.append("var goLogin = [[gologin]] ; \n");
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append("	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append(
					"   if(stStartsWith(url, 'http://m.g9.co.kr/Default/Home') || stStartsWith(url, 'https://m.g9.co.kr/Default/Home')){ \n");
			sb.append("   		window.android.onLoginSuccess(); \n");
			sb.append(
					"    }else if(stStartsWith(url, 'http://m.g9.co.kr/MyInfo.htm') || stStartsWith(url, 'https://m.g9.co.kr/MyInfo.htm')){ \n");
			sb.append("    		window.android.onLoginSuccess(); \n");
			sb.append(
					"    }else if(stStartsWith(url, 'http://m.g9.co.kr/Notice.htm#/Notice/Error') || stStartsWith(url, 'https://m.g9.co.kr/Notice.htm#/Notice/Error')){ \n");
			sb.append("    		window.android.onLoginSuccess(); \n");
			sb.append(
					"    }else if(stStartsWith(url, 'http://m.g9.co.kr/MyInfo.htm#/Display/FavoriteList') || stStartsWith(url, 'https://m.g9.co.kr/MyInfo.htm#/Display/FavoriteList')){\n");
			sb.append("    		window.android.onLoginSuccess(); \n");
			sb.append("    }else if(stStartsWith(url, 'http://notice.g9.co.kr/SiteCheck.htm')){\n");
			sb.append(loginfailData("로그인_실패_사이트점검", version));
			sb.append("    }else if ( goLogin ){ \n");
			sb.append("      window.android.runLogin();  \n");
			sb.append("      setTimeout( function(){ \n");

			sb.append("         document.getElementById('LoginID').value = strId;    \n");
			sb.append("         document.getElementById('Password').value = strPw;    \n");
			sb.append("         document.getElementById('auto_login').value = true;    \n");
			sb.append("         document.getElementsByClassName('btn_login')[0].click();   \n");

			sb.append("      },1000 );  \n");
			sb.append("    }      \n");
			sb.append("  }catch(e){ \n");
			sb.append("      window.android.onError(document.location.href+'|'+e.message);\n");
			sb.append("  } \n");
			sb.append("} \n");
			schemes.put("g9", sb.toString());

			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("var strId = '[[id]]'; \n");
			sb.append("var strPw = '[[pwd]]'; \n");
			sb.append("var goLogin = [[gologin]] ; \n");
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append("	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append("   if(stStartsWith(url, 'http://m.auction.co.kr')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append("    }else if(stStartsWith(url, 'http://mobile.auction.co.kr')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append("    }else if(stStartsWith(url, 'https://cart.auction.co.kr/ko-m/cart')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			
			sb.append("    }else if(stStartsWith(url, 'https://mmya.auction.co.kr/MyAuction/Order/#/OrderList')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");			
			sb.append("    }else if(stStartsWith(url, 'http://mmya.auction.co.kr/MyAuction/')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append("    }else if(stStartsWith(url, 'http://member.auction.co.kr/Authenticate/Popup/PasswordWarningLoginInfoPopup.htm')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append(
					"    }else if(stStartsWith(url, 'https://memberssl.auction.co.kr/Authenticate/m/PasswordChangeByVerification.aspx')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append(
					"    }else if(stStartsWith(url, 'https://memberssl.auction.co.kr/Membership/IDPW_Mobile/ResetPassword.aspx')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append(
					"    }else if(stStartsWith(url, 'https://signin.auction.co.kr/Authenticate/MobileLogin.aspx?return_value=-1')){ \n");
			sb.append(loginfailData("로그인_실패_계정불일치", version));
			sb.append("    }else if(stStartsWith(url, 'http://mobile.auction.co.kr/Error/error_500.html')){ \n");
			sb.append(loginfailData("로그인_실패_사이트오류", version));
			
			sb.append("    }else if(stStartsWith(url, 'http://www.auction.co.kr/community/SiteStop/stop_main_new.html')){ \n");
			sb.append(loginfailData("로그인_실패_사이트오류", version));
			sb.append("    }else if (goLogin){ \n");
			sb.append("      window.android.runLogin();  \n");
			sb.append("      var failError = document.getElementById('divMessageForInvalidPWD');  \n");
			sb.append("      var captcha = document.getElementById('postback_CaptchaImage');  \n");
			sb.append("      if(failError != null){  \n");
			sb.append("         window.android.onError(document.location.href+'|'+commonErr.innerText);  \n");
			sb.append("      }else if (captcha != null){  \n");
			sb.append(loginfailData("로그인 실패_캡차", version));
			sb.append("      }else {  \n");
			sb.append("         document.getElementById('id').value = strId ;  \n");
			sb.append("         document.getElementById('password').value = strPw ;  \n");
			sb.append("         var logintBtn = document.getElementById('btnLogin') ;  \n");
			sb.append("         logintBtn.click() ;  \n");
			sb.append("      }      \n");
			sb.append("    }      \n");
			sb.append("  }catch(e){ window.android.onError(document.location.href+'|'+e.message);\n");
			sb.append("  } \n");
			sb.append("} \n");
			schemes.put("auction", sb.toString());

			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("var strId = '[[id]]'; \n");
			sb.append("var strPw = '[[pwd]]'; \n");
			sb.append("var goLogin = [[gologin]] ; \n");
		//	if(version >= 407){
		//		sb.append("var snstype = '[[snstype]]' ; \n");
		//	}else{
		//		sb.append("var snstype = '' ; \n");
		//	}
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append("	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			sb.append(" function resultCheker(){ \n");
  			sb.append(" 	try{ \n");
  			sb.append("  var captcha= document.getElementsByClassName('captchaWrap'); \n");
  			sb.append("  if(captcha != null && captcha.length > 0) { \n");
  			sb.append(" 		if(captcha[0].style.display == 'none') { \n");
  			sb.append(" 			return false; \n");
  			sb.append(" 		}else { \n");
  			sb.append(			loginfailData("로그인 실패_캡차", version));
  			sb.append(" 			return true; \n");
  			sb.append(" 		} \n");
  			sb.append(" 	 } \n");
  			sb.append(" 	}catch(e){ \n");
  			sb.append(" 		window.android.onError(document.location.href+'|'+e.message); return false; \n");
  			sb.append(" 	} \n");
  			sb.append(" 	return false; \n");
  			sb.append("    } \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			
			sb.append("   if( !resultCheker()){ \n");
			
			sb.append("   if(stStartsWith(url, 'http://m.shop.interpark.com/')){ \n");
			sb.append("         window.android.onLoginSuccess() \n");
			sb.append("    }else if(stStartsWith(url, 'https://smshop.interpark.com/my/shop/buylist.html')){ \n");
			sb.append("         window.android.onLoginSuccess() \n");
			sb.append("    }else if(stStartsWith(url, 'https://m.interpark.com/auth/marketing_agreement.html')){ \n"); //마케팅페이지
			sb.append("          window.android.onLoginSuccess(); \n");
			sb.append("    }else if(stStartsWith(url, 'http://incorp.interpark.com/member/MemberSiteAgree.do')){ \n");
			sb.append("          window.android.onLoginSuccess(); \n");
			
		//	sb.append("    }else if(stStartsWith(url, 'https://accounts.kakao.com/login?continue=')){ \n");
		//	sb.append("     	 window.android.runLogin();  \n");
		//	sb.append("    		document.getElementById('id_email_2').value = strId \n ");
		//	sb.append("    		document.getElementById('id_password_3').value = strPw \n");
		//	sb.append("    		document.querySelector('#login-form > fieldset > div.wrap_btn > button').click() \n");			
			
			
			sb.append("    }else if (goLogin){ \n");
		//	sb.append("      if(snstype == 'ka'){ \n");
		//	sb.append("     	document.querySelector(''#loginWrap > div > div.snsLoginWrap > a.openid.kakao').click(); \n");
		//	sb.append("      }else if (snstype == 'na'){ \n");
		//	sb.append("     	document.querySelector(''#loginWrap > div > div.snsLoginWrap > a.openid.naver').click(); \n");	
		//	sb.append("     } else {");			
			sb.append("      	document.getElementById('userId').value =  strId;  \n");
			sb.append("      	document.getElementById('userPwd').value = strPw;  \n");
			sb.append("      	proces();  \n");
			sb.append("       	setTimeout( function(){  \n");
			sb.append("     	    var logintBtn = document.getElementById('btn_login');  \n");
			sb.append("     	     logintBtn.click();  \n");
			sb.append("     	   },1000);  \n");
			sb.append("     	 window.android.runLogin();  \n");
		//	sb.append("    	}      \n");
			sb.append("    }      \n");
			sb.append("   } \n");
			sb.append("  }catch(e){ window.android.onError(document.location.href+'|'+e.message);\n");
			sb.append("  } \n");
			sb.append("} \n");
			schemes.put("interpark", sb.toString());

			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append(" var strId = '[[id]]'; \n");
			sb.append(" var strPw = '[[pwd]]'; \n");
			sb.append(" var goLogin = [[gologin]] ; \n");
			sb.append(" function stStartsWith(str, str2){ \n");
			sb.append(" 	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append(" } \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append(" console.log('[[URL' +url);\n");
			sb.append("   if( !resultCheker()){ \n");
			sb.append(" 	if(stStartsWith(url, 'http://m.ssg.com/')){ \n");
			sb.append(" 		window.android.onLoginSuccess(); \n");
			sb.append(" 	}else if(stStartsWith(url, 'https://pay.ssg.com/m/myssg/orderInfo.ssg')){ \n");
			sb.append("		 	window.android.onLoginSuccess(); \n");
			sb.append("	 	}else if (goLogin){ \n");
			sb.append("      window.android.runLogin();  \n");
			sb.append(" 		document.getElementById('inp_id').value = strId; \n");
			sb.append(" 		document.getElementById('inp_pw').value = strPw; \n");
			sb.append(" 		setTimeout(  function(){loginClick();} ,300); \n");
			sb.append(" 	} \n");
			sb.append("   } \n");
			sb.append(" }catch(e){ \n");
			sb.append(" } \n");
			sb.append(" function resultCheker(){ \n");
			sb.append(" 	try{ \n");
			sb.append(" 		var captcha= document.getElementById('captcha_area'); \n");
			sb.append(" 		if(captcha == null) { \n");
			sb.append(" 			return false; \n");
			sb.append(" 		}else{ \n");
			sb.append(" 			if(captcha.style.display == 'none') { \n");
			sb.append(" 				return false; \n");
			sb.append(" 			}else { \n");
			sb.append(loginfailData("로그인 실패_캡차", version));
			sb.append(" 				return true; \n");
			sb.append(" 			} \n");
			sb.append(" 		} \n");
			sb.append(" 	}catch(e){ \n");
			sb.append(" 		window.android.onError(document.location.href+'|'+e.message); \n");
			sb.append(" 	} \n");
			sb.append(" 	return false; \n");
			sb.append("    } \n");
			sb.append(" function loginClick(){ \n");
			sb.append(" 	document.getElementsByClassName('cmem_btn cmem_btn_orange3')[0].click(); \n");
			sb.append(" } \n");
			sb.append("} \n");
			schemes.put(".emart", sb.toString());

			sb.setLength(0);
			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append(" var strId = '[[id]]'; \n");
			sb.append(" var strPw = '[[pwd]]'; \n");
			sb.append(" var goLogin = [[gologin]] ; \n");
			sb.append(" function stStartsWith(str, str2){ \n");
			sb.append(" 	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append(" } \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append("   if( !resultCheker()){ \n");
			sb.append(" 	if(stStartsWith(url, 'http://m.ssg.com/')){ \n");
			sb.append(" 		window.android.onLoginSuccess(); \n");
			sb.append(" 	}else if(stStartsWith(url, 'https://pay.ssg.com/m/myssg/orderInfo.ssg')){ \n");
			sb.append("		 	window.android.onLoginSuccess(); \n");
			sb.append("	 	}else if (goLogin){ \n");
			sb.append("      window.android.runLogin();  \n");
			sb.append(" 		document.getElementById('inp_id').value = strId; \n");
			sb.append(" 		document.getElementById('inp_pw').value = strPw; \n");
			sb.append(" 		setTimeout(  function(){loginClick();} ,300); \n");

			sb.append(" 	} \n");
			sb.append("   } \n");
			sb.append(" }catch(e){ \n");
			sb.append(" } \n");
			sb.append(" function resultCheker(){ \n");
			sb.append(" 	try{ \n");
			sb.append(" 		var captcha= document.getElementById('captcha_area'); \n");
			sb.append(" 		if(captcha == null) { \n");
			sb.append(" 			return false; \n");
			sb.append(" 		}else{ \n");
			sb.append(" 			if(captcha.style.display == 'none') { \n");
			sb.append(" 				return false; \n");
			sb.append(" 			}else { \n");
			sb.append(loginfailData("로그인 실패_캡차", version));
			sb.append(" 				return true; \n");
			sb.append(" 			} \n");
			sb.append(" 		} \n");
			sb.append(" 	}catch(e){ \n");
			sb.append(" 		window.android.onError(document.location.href+'|'+e.message); \n");
			sb.append(" 	} \n");
			sb.append(" 	return false; \n");
			sb.append("    } \n");
			sb.append(" function loginClick(){ \n");
			sb.append(" 	document.getElementsByClassName('cmem_btn cmem_btn_orange3')[0].click(); \n");
			sb.append(" } \n");
			sb.append("} \n");
			schemes.put("shinsegaemall", sb.toString());

			sb.setLength(0);
			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append(" var strId = '[[id]]'; \n");
			sb.append(" var strPw = '[[pwd]]'; \n");
			sb.append(" var goLogin = [[gologin]] ; \n");
			sb.append(" function stStartsWith(str, str2){ \n");
			sb.append(" 	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append(" } \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append("   if(!resultCheker()){ \n");
			sb.append(" 	if(stStartsWith(url, 'http://m.ssg.com/')){ \n");
			sb.append(" 		window.android.onLoginSuccess(); \n");
			sb.append(" 	}else if(stStartsWith(url, 'https://pay.ssg.com/m/myssg/orderInfo.ssg')){ \n");
			sb.append("		 	window.android.onLoginSuccess(); \n");
			sb.append("	 	}else if (goLogin){ \n");
			sb.append("      window.android.runLogin();  \n");
			sb.append(" 		document.getElementById('inp_id').value = strId; \n");
			sb.append(" 		document.getElementById('inp_pw').value = strPw; \n");
			sb.append(" 		setTimeout(  function(){loginClick();} ,300); \n");

			sb.append(" 	} \n");
			sb.append("   } \n");
			sb.append(" }catch(e){ \n");
			sb.append(" } \n");
			sb.append(" function resultCheker(){ \n");
			sb.append(" 	try{ \n");
			sb.append(" 		var captcha= document.getElementById('captcha_area'); \n");
			sb.append(" 		if(captcha == null) { \n");
			sb.append(" 			return false; \n");
			sb.append(" 		}else{ \n");
			sb.append(" 			if(captcha.style.display == 'none') { \n");
			sb.append(" 				return false; \n");
			sb.append(" 			}else { \n");
			sb.append(loginfailData("로그인 실패_캡차", version));
			sb.append(" 				return true; \n");
			sb.append(" 			} \n");
			sb.append(" 		} \n");
			sb.append(" 	}catch(e){ \n");
			sb.append(" 		window.android.onError(document.location.href+'|'+e.message); \n");
			sb.append(" 	} \n");
			sb.append(" 	return false; \n");
			sb.append("    } \n");
			sb.append(" function loginClick(){ \n");
			sb.append(" 	document.getElementsByClassName('cmem_btn cmem_btn_orange3')[0].click(); \n");
			sb.append(" } \n");
			sb.append("} \n");
			schemes.put("ssg", sb.toString());

			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("var strId = '[[id]]'; \n");
			sb.append("var strPw = '[[pwd]]'; \n");
			sb.append("var goLogin = [[gologin]] ; \n");
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append("	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append("   if(!resultCheker()){ \n");
			sb.append("    if(stStartsWith(url, 'http://m.gsshop.com/index.gs')){ \n");
			sb.append("     	window.android.onLoginSuccess(); \n");
			sb.append("    }else if(stStartsWith(url, 'http://m.gsshop.com/mygsshop/myOrderList.gs')){ \n");
			sb.append("     	window.android.onLoginSuccess(); \n");
			
			sb.append("    }else if(stStartsWith(url, 'https://m.gsshop.com/mygsshop/myshopInfo.gs')){ \n");
			sb.append("     	window.android.onLoginSuccess(); \n");
			
			sb.append("    }else if(url.includes('isLoginFail=Y')){ \n");
			sb.append(loginfailData("로그인_실패_기타|isLoginFail=Y", version));
			sb.append(
					"    }else if(stStartsWith(url, 'https://m.gsshop.com/member/logIn.gs?passwdNeedChgFlg=true')){ \n");
			sb.append("       $('#noShow').click();  \n");
			sb.append(
					"    }else if (goLogin && stStartsWith(url, 'https://m.gsshop.com/member/logIn.gs?ssoChk=Y')){ \n");
			sb.append("      window.android.runLogin();  \n");
			sb.append("      $('#id').val(strId);  \n");
			sb.append("      $('#passwd').val(strPw); \n");
			sb.append("      setTimeout(function(){$('#btnLogin').click();},100);   \n");

			sb.append("    }      \n");
			sb.append("   } \n");
			sb.append("  }catch(e){ window.android.onError(e.message+'|'+url);\n");
			sb.append("      console.log('ERROR0>> '+e); \n");
			sb.append("  } \n");
			sb.append("  function resultCheker(){ \n");
			sb.append("     try{ \n");
			sb.append("     var alertMng = document.getElementById('loginResult');  \n");
			sb.append("     if(alertMng != null && alertMng.getAttribute('class') == 'noti on'){    \n");
			//sb.append("        window.android.onLoginFail();         \n"); 
			sb.append(loginfailData("로그인_실패_기타|noti on", version));
			sb.append("        return true;         \n");
			sb.append("     }                     \n");
			sb.append("    }catch(e){ window.android.onError(document.location.href+'|'+e.message);\n");
			sb.append("    } \n");
			sb.append("    return false;         \n");
			sb.append("   } \n");
			sb.append("} \n");
			schemes.put("gsshop", sb.toString());

			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("var strId = '[[id]]'; \n");
			sb.append("var strPw = '[[pwd]]'; \n");
			sb.append("var goLogin = [[gologin]] ; \n");
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append("	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append("   if(!checkError()){ \n");
			sb.append("    if(stStartsWith(url, 'https://mw.wemakeprice.com/main')){ \n");
			sb.append("     window.android.onLoginSuccess(); \n");
			sb.append("    }else if(stStartsWith(url, 'https://mw.wemakeprice.com/mypage')){ \n");
			sb.append("     window.android.onLoginSuccess(); \n");
			sb.append("    }else if(stStartsWith(url, 'https://mw.wemakeprice.com/cart/cartList')){ \n");
			sb.append("     window.android.onLoginSuccess(); \n");
			sb.append("    }else if(stStartsWith(url, 'https://mw.wemakeprice.com/mypage/orders')){ \n");
			sb.append("     window.android.onLoginSuccess(); \n");
			sb.append("    }else if(stStartsWith(url, 'https://front.wemakeprice.com/user/password/advice')){ \n");
			sb.append("     window.android.onLoginSuccess(); \n");
			sb.append("    }else if(stStartsWith(url, 'https://mw.wemakeprice.com/user/password/advice')){ \n");
			sb.append("     window.android.onLoginSuccess(); \n");
			sb.append("    }else if(stStartsWith(url, 'https://mescrow.wemakeprice.com/cart/cartList')){ \n");
			sb.append("     window.android.onLoginSuccess(); \n");
			sb.append("    }else if (goLogin){ \n");
			sb.append("      window.android.runLogin();  \n");
			sb.append("      $('#_loginId').val(strId);  \n");
			sb.append("      $('#_loginPw').val(strPw); \n");
			sb.append("      $('#_userLogin').click();       \n");

			sb.append("      setTimeout( function(){checkError();}, 1000);  \n"); //1초 뒤 에러체크 
			sb.append("    }      \n");
			sb.append("   } \n");
			sb.append("  }catch(e){ window.android.onError(e.message+'|'+url);\n");
			sb.append("  } \n");
			sb.append("    function checkError() {           \n");
			sb.append("      try{                   \n");
			sb.append("         var errlist = document.getElementsByClassName('err');      \n");
			sb.append("         var bError = false;                       \n");
			sb.append("         for(var i = 0; i < errlist.length; i++){                \n");
			sb.append("            var mErr = errlist[i];                           \n");
			sb.append("            if(mErr.style.display != 'none'){                \n"); //20210218 에러 메시지가 보여지게 된다면 에러라고 본다 
			//sb.append("            if(mErr.style.display == 'block'){                \n");               
			//sb.append("               window.android.onLoginFail();      \n");
			sb.append(loginfailData("로그인_실패_계정불일치|mErr.style.display!=none", version));
			sb.append("               bError = true;                        \n");
			sb.append("               break;                          \n");
			sb.append("            }                       \n");
			sb.append("         }   \n");
			sb.append("         var captcha = document.querySelector('#_captcha'); \n");
			sb.append("         if(captcha != null && captcha.style.display != 'none')  { \n");
			sb.append(loginfailData("로그인_실패_캡차", version));
			sb.append("             bError = true;                        \n");
			sb.append("         }                  \n");
			sb.append("         return bError;       \n");
			sb.append(
					"       }catch(e){ window.android.onError(document.location.href+'|'+e.message);                  \n");
			sb.append("         console.log('ERROR> '+e);       \n");
			sb.append("       }           \n");
			sb.append("       return false;       \n");
			sb.append("     }           \n");
			sb.append("} \n");
			schemes.put("wemakeprice", sb.toString());

			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("var strId = '[[id]]'; \n");
			sb.append("var strPw = '[[pwd]]'; \n");
			sb.append("var goLogin = [[gologin]] ; \n");
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append("	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append("   if(stStartsWith(url, 'http://m.tmon.co.kr/')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append("    }else if(stStartsWith(url, 'https://delivery.tmon.co.kr/m/mytmon/orders')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append("    }else if(stStartsWith(url, 'https://m.tmon.co.kr/user/loginFailed')){ \n");
			sb.append("        if (url.indexOf('message=AUTH_ERROR') > -1){  \n");
			sb.append(loginfailData("로그인_실패_계정불일치", version));
			sb.append("        }else if (url.indexOf('message=captcha_on') > -1){  \n");
			sb.append(loginfailData("로그인_실패_캡차", version));
	        sb.append("        }else{  \n");
			sb.append(loginfailData("로그인_실패_기타", version));
			sb.append("        }  \n");
			sb.append("    }else if (goLogin){ \n");
			sb.append("      window.android.runLogin();  \n");
			sb.append("      $('#user_form_id').val(strId);  \n");
			sb.append("      $('#user_form_pw').val(strPw); \n");
			sb.append("      $('#login').click(); \n");
			sb.append("    }      \n");
			sb.append("  }catch(e){ window.android.onError(e.message+'|'+url);\n");
			sb.append("  } \n");
			sb.append("} \n");
			schemes.put("tmon", sb.toString());

			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("var strId = '[[id]]'; \n");
			sb.append("var strPw = '[[pwd]]'; \n");
			sb.append("var goLogin = [[gologin]] ; \n");
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append("	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append("   if(stStartsWith(url, 'http://display.cjmall.com/p/homeTab/main')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append("    }else if(stStartsWith(url, 'https://base.cjmall.com/m/myzone/main')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append("    }else if(stStartsWith(url, 'https://base.cjmall.com/m/myzone/orderList')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append("    }else if (goLogin){ \n");
			sb.append("      window.android.runLogin();  \n");
			sb.append("      setTimeout(function(){  \n");
			sb.append("        document.getElementById('id_input').value =strId;  \n");
			sb.append("        document.getElementById('password_input').value = strPw; \n");
			sb.append("        $('#loginSubmit').click(); },1000); \n");
			sb.append("      setTimeout(function(){$('#close_layer').click();},5000); \n");

			sb.append("    }      \n");
			sb.append("  }catch(e){ window.android.onError(e.message+'|'+url);\n");
			sb.append("  } \n");
			sb.append("} \n");
			schemes.put("cjmall", sb.toString());

			sb.setLength(0);
			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("var strId = '[[id]]'; \n");
			sb.append("var strPw = '[[pwd]]'; \n");
			sb.append("var goLogin = [[gologin]] ; \n");
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append("	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append("   if(stStartsWith(url, 'https://display.cjonstyle.com/m/homeTab/main')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append("    }else if(stStartsWith(url, 'https://base.cjonstyle.com/m/myzone/main')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append("    }else if(stStartsWith(url, 'https://base.cjonstyle.com/m/myzone/orderList')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append("    }else if (goLogin){ \n");
			sb.append("      window.android.runLogin();  \n");
			sb.append("      setTimeout(function(){  \n");
			sb.append("        document.getElementById('id_input').value =strId;  \n");
			sb.append("        document.getElementById('password_input').value = strPw; \n");
			sb.append("        $('#loginSubmit').click(); },1000); \n");
			sb.append("      setTimeout(function(){$('#close_layer').click();},5000); \n");

			sb.append("    }      \n");
			sb.append("  }catch(e){ window.android.onError(e.message+'|'+url);\n");
			sb.append("  } \n");
			sb.append("} \n");
			schemes.put("cjonstyle", sb.toString());

			sb.setLength(0);

			sb.append(" javascript:{ \n ");
			sb.append(" 	var strId = '[[id]]'; \n ");
			sb.append(" 	var strPw = '[[pwd]]'; \n ");
			sb.append(" 	var goLogin = [[gologin]] ; \n ");
			sb.append(" 	function stStartsWith(str, str2){ \n ");
			sb.append(" 		return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n ");
			sb.append(" 	} \n ");
			sb.append(" 	var url = document.location.href; \n ");
			sb.append(" 	try{ \n ");
			sb.append(" 	  if(!resultChecker()){ \n ");
			sb.append(" 		if(!goLogin && (stStartsWith(url, 'https://www.hmall.com/m/smLoginP.do') || stStartsWith(url, 'https://www.hmall.com/m/smLoginF.do') )){ \n ");
			sb.append(" 			var updateform = document.getElementById('updateform') \n ");
			sb.append(" 			if (updateform != null){ \n ");						
			sb.append(" 				window.android.onLoginSuccess(); \n ");
			sb.append(" 			} \n ");			
			sb.append(" 		} \n");
			
			sb.append(" 		else if(stStartsWith(url, 'http://www.hmall.com/')){ \n ");
			sb.append(" 			window.android.onLoginSuccess(); \n ");
			sb.append(" 		}else if(stStartsWith(url, 'https://www.hmall.com/m/smOrderPeriodL.do')){ \n ");
			sb.append(" 			window.android.onLoginSuccess(); \n ");
			sb.append(" 		}else if(stStartsWith(url, 'https://www.hmall.com/m/smFindUserPasswordREmailCert.do')){ \n ");
			//sb.append(" 			window.android.onLoginFail(); \n ");
			sb.append(loginfailData("로그인_실패_기타", version));
			sb.append(" 		}else if (goLogin){ \n ");
			sb.append("      		window.android.runLogin();  \n");
			sb.append(" 			document.querySelector('#userid').value = strId; \n ");
			sb.append(" 			document.querySelector('#password').value = strPw; \n ");
			sb.append(" 			document.querySelector('#loginCheck').click() ;\n");
					
			/* sb.append(" 			$(\"input[name='userid']\").val(strId); \n ");
			sb.append(" 			$(\"input[name='password']\").val(strPw); \n "); 
			sb.append(" 			$('#loginCheck').click(); \n ");*/

			sb.append(" 		} \n ");
			sb.append(" 	  } \n ");
			sb.append(" 	}catch(e){ window.android.onError(e.message+'|'+url);\n ");
			sb.append(" 	} \n ");
			sb.append("     function resultChecker() {\n");
			sb.append(" 	try{");
			sb.append(" 		var alertMember = document.getElementById('alertMember'); \n ");
			sb.append(" 		var alertPoint = document.getElementById('alertHpoint'); \n ");
			sb.append(" 		if(alertMember != null && alertPoint != null ) {\n");
			sb.append(" 			if(alertMember.innerHTML != '' || alertPoint.style.display != 'none' ) {\n");
			//sb.append(" 				window.android.onLoginFail();\n");
			sb.append(					loginfailData("로그인 실패_기타|resultChecker", version));
			sb.append("					return true;\n");
			sb.append(" 			}\n");
			sb.append(" 		}\n");
			sb.append(" 	}catch(e) {\n");
			sb.append(" 	}\n");
			sb.append(" 	return false; \n");
			sb.append(" }\n");
			sb.append(" }\n");
			schemes.put("hmall", sb.toString());

			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("var strId = '[[id]]'; \n");
			sb.append("var strPw = '[[pwd]]'; \n");
			sb.append("var goLogin = [[gologin]] ; \n");
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append("	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append("   if(stStartsWith(url, 'https://m.akmall.com/main/Main.do')){ \n");
			sb.append("     	window.android.onLoginSuccess() \n");
			sb.append("    }else if(stStartsWith(url, 'https://m.akmall.com/mypage/OrderDeliInquiry.do')){ \n");
			sb.append("     	window.android.onLoginSuccess() \n");
			
			sb.append("    }else if (goLogin){ \n");
			sb.append("      window.android.runLogin();  \n");
			
			sb.append("      document.getElementById('cust_id').value  = strId \n");
			sb.append("      document.getElementById('passwd').value  = strPw \n");			
			sb.append("      setTimeout(function(){document.getElementById('loginBtn').click(); },1000); \n");
			//sb.append("      $('#cust_id').val(strId);  \n");
			//sb.append("      $('#passwd').val(strPw); \n");
			//sb.append("      setTimeout(function(){$('#loginBtn').click(); },1000); \n");

			sb.append("    }      \n");
			sb.append("  }catch(e){ window.android.onError(e.message+'|'+url);\n");
			sb.append("  } \n");
			sb.append("} \n");
			schemes.put("akmall", sb.toString());

			schemes.put(".nsmall.com", "");
			schemes.put("e-himart", "");
			schemes.put("galleria", "");
			schemes.put("okmall", "");

			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("var strId = '[[id]]'; \n");
			sb.append("var strPw = '[[pwd]]'; \n");
			sb.append("var goLogin = [[gologin]] ; \n");
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append("	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			sb.append(" setTimeout(function(){  \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append("   if(stStartsWith(url, 'https://mfront.homeplus.co.kr/')){ \n");
			sb.append("     	window.android.onLoginSuccess() \n");
			sb.append("    }else if(stStartsWith(url, 'https://mfront.homeplus.co.kr/mypage')){ \n");
			sb.append("     	window.android.onLoginSuccess() \n");			
			sb.append("    }else if(stStartsWith(url, 'http://m.homeplus.co.kr/orderfulfilment/basket/list.do')){ \n");
			sb.append("     	window.android.onLoginSuccess() \n");
			sb.append("    }else if (goLogin){ \n");		 	
			sb.append("      setTimeout(function(){ $('#loginId').val(strId);  $('#pwd').val(strPw);  window.android.runLogin();  login(); },2000); \n");

			sb.append("      setTimeout(function() {  \n");
			sb.append("       try{  \n");
			sb.append("        var stPwChangePopup = document.getElementById('ui-popup-pwdchange');  \n");
			sb.append("        if(stPwChangePopup != null){  \n");
			sb.append("      	   if(stPwChangePopup.style.display != 'none'){  \n");
			sb.append("      	       fn_PwCycleUpdate();  \n");
			sb.append("      	   }  \n");
			sb.append("      	 }  \n");
			sb.append("      }catch(e){  \n");
			sb.append("    	    window.android.onError(e.message+'|'+url);  \n");
			sb.append("      }}, 4000);  \n");

			sb.append("    }      \n");
			sb.append("  }catch(e){ window.android.onError(e.message+'|'+url);\n");
			sb.append("  } \n");
			sb.append(" }, 2000); \n");
			sb.append("} \n");
			schemes.put("homeplus", sb.toString());

			sb.setLength(0);
			sb.append("javascript:{ ");
			sb.append("	var strId = '[[id]]'; ");
			sb.append("	var strPw = '[[pwd]]'; ");
			sb.append("	var goLogin = [[gologin]] ; ");
			sb.append("	function stStartsWith(str, str2){ ");
			sb.append(" 	return str2.length > 0 && str.substring( 0, str2.length ) === str2; ");
			sb.append("	} ");
			sb.append(" var url = document.location.href; ");
			sb.append(" try{ ");
			sb.append("	 	if(stStartsWith(url, 'https://www.lotteon.com/m/display/main/lotteon')){ ");
			sb.append(" 		window.android.onLoginSuccess(); ");
			sb.append(" 	}else if(stStartsWith(url, 'https://www.lotteon.com/m/order/mylotte/orderDeliveryList')){ ");
			sb.append(" 		window.android.onLoginSuccess(); ");
			sb.append(" 	}else if(stStartsWith(url, 'https://members.lpoint.com/exView/join/mbrJoin')){ ");
			sb.append(loginfailData("로그인_실패_기타", version));
			sb.append(" 	}else if(stStartsWith(url, 'https://members.lpoint.com/exView/manage/')){ ");
			//sb.append(" 		window.android.onLoginFail(); ");
			sb.append(loginfailData("로그인_실패_기타", version));
			sb.append(" 	}else if (goLogin){ ");
			sb.append("      setTimeout( function(){");
			sb.append("      	window.android.runLogin();  \n");
			sb.append(" 		window.vueComponent.inId = strId; ");
			sb.append(" 		window.vueComponent.Password = strPw; ");
			sb.append(" 		setTimeout(function(){$('.loginPlaceWrap button').click();},500); ");
			sb.append("      },1000);");
			/* sb.append("      setTimeout( function(){");
					sb.append("				var temp = document.querySelector('#modals-container > div > div > div.v--modal-box.fullPageModal > div > div.fullPopupContent > div.buttonGroup.double.fixed.col2 > button:nth-child(1)''); \n");
					sb.append("				if (temp != null){ \n");
					sb.append("					temp.click();	 \n");		
					sb.append("				} \n");			
					sb.append("      },2000);"); */
			sb.append(" 	} ");
			sb.append(" 	}catch(e){ window.android.onError(e.message+'|'+url);");
			sb.append(" 	} ");
			sb.append("} ");
			schemes.put("lotteon.", sb.toString());

			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("var strId = '[[id]]'; \n");
			sb.append("var strPw = '[[pwd]]'; \n");
			sb.append("var goLogin = [[gologin]] ; \n");
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append("	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			
		
			
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			
			sb.append("   if(stStartsWith(url, 'https://www.lotteon.com/m/display/main/lotteon')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append("    }else if(stStartsWith(url, 'https://www.lotteon.com/m/order/mylotte/orderDeliveryList')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append(" 	}else if(stStartsWith(url, 'https://members.lpoint.com/exView/join/mbrJoin')){ ");
			sb.append(loginfailData("로그인_실패_기타", version));
			sb.append(" 	}else if(stStartsWith(url, 'https://members.lpoint.com/exView/manage/')){ ");
			//sb.append(" 		window.android.onLoginFail(); ");
			sb.append(loginfailData("로그인_실패_기타", version));
			sb.append("    }else if (goLogin){ \n");

			sb.append("      setTimeout( function(){");
			sb.append("      	window.android.runLogin();  \n");
			sb.append(" 		window.vueComponent.inId = strId; ");
			sb.append(" 		window.vueComponent.Password = strPw; ");
			sb.append(" 		setTimeout(function(){$('.loginPlaceWrap button').click();},500); ");
			sb.append("      },1000);");
			
		 
		/* 	sb.append("      setTimeout( function(){");
			sb.append("				var temp = document.querySelector('#modals-container > div > div > div.v--modal-box.fullPageModal > div > div.fullPopupContent > div.buttonGroup.double.fixed.col2 > button:nth-child(1)''); \n");
			sb.append("				if (temp != null){ \n");
			sb.append("					temp.click();	 \n");		
			sb.append("				} \n");			
			sb.append("      },2000);");  */
			sb.append("    }      \n");
			sb.append("  }catch(e){ window.android.onError(e.message+'|'+url);\n");
			sb.append("  } \n");
			sb.append("} \n");
			schemes.put("lotteon.=-=/lottemart=-=/product/LM", sb.toString());

			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("var strId = '[[id]]'; \n");
			sb.append("var strPw = '[[pwd]]'; \n");
			sb.append("var goLogin = [[gologin]] ; \n");
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append("	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append("   if(stStartsWith(url, 'https://www.lotteon.com/m/display/main/lotteon')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append("    }else if(stStartsWith(url, 'https://www.lotteon.com/m/order/mylotte/orderDeliveryList')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append(" 	}else if(stStartsWith(url, 'https://members.lpoint.com/exView/join/mbrJoin')){ ");
			sb.append(loginfailData("로그인_실패_기타", version));
			sb.append(" 	}else if(stStartsWith(url, 'https://members.lpoint.com/exView/manage/')){ ");
			//sb.append(" 		window.android.onLoginFail(); ");
			sb.append(loginfailData("로그인_실패_기타", version));
			sb.append("    }else if (goLogin){ \n");
			sb.append("      setTimeout( function(){");
			sb.append("      	window.android.runLogin();  \n");
			sb.append(" 		window.vueComponent.inId = strId; ");
			sb.append(" 		window.vueComponent.Password = strPw; ");

			sb.append(" 		setTimeout(function(){$('.loginPlaceWrap button').click();},500); ");
			sb.append("      },1000);");
		/* 	sb.append("      setTimeout( function(){");
						sb.append("				var temp = document.querySelector('#modals-container > div > div > div.v--modal-box.fullPageModal > div > div.fullPopupContent > div.buttonGroup.double.fixed.col2 > button:nth-child(1)''); \n");
						sb.append("				if (temp != null){ \n");
						sb.append("					temp.click();	 \n");		
						sb.append("				} \n");			
						sb.append("      },2000);"); */
			sb.append("    }      \n");
			sb.append("  }catch(e){ window.android.onError(e.message+'|'+url);\n");
			sb.append("  } \n");
			sb.append("} \n");
			schemes.put("lotteon.=-=/ellotte=-=/product/LE", sb.toString());

			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("var strId = '[[id]]'; \n");
			sb.append("var strPw = '[[pwd]]'; \n");
			sb.append("var goLogin = [[gologin]] ; \n");
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append("	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			sb.append(" setTimeout(function(){ \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append("   if(stStartsWith(url, 'https://m.lotteimall.com/main/viewMain.lotte?')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append(
					"    }else if(stStartsWith(url, 'https://securem.lotteimall.com/mypage/searchOrderListFrame.lotte')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append(
					"    }else if(stStartsWith(url, 'https://m.lotteimall.com/mypage/searchOrderListFrame.lotte')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append(
					"    }else if(stStartsWith(url, 'https://m.lotteimall.com/jsp/member/login/forward.LCLoginPwChgCmpPop.lotte')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append(
					"    }else if(stStartsWith(url, 'https://securem.lotteimall.com/jsp/member/login/forward.LCLoginPwChgCmpPop.lotte')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append(
					"    }else if(stStartsWith(url, 'https://m.lotteimall.com/jsp/member/login/forward.LCLoginMem.lotte?msgflag=Y')){ \n");
			sb.append(loginfailData("로그인_실패_계정불일치", version));
			sb.append(
					"    }else if(stStartsWith(url, 'https://securem.lotteimall.com/jsp/member/login/forward.LCLoginMem.lotte?msgflag=Y')){ \n");
			sb.append(loginfailData("로그인_실패_계정불일치", version));
			sb.append(
					"    }else if(stStartsWith(url, 'https://m.lotteimall.com/jsp/member/login/forward.LCLoginMem.lotte?msgflag=Y')){ \n");
			sb.append(loginfailData("로그인_실패_계정불일치", version));
			sb.append(
					"    }else if(stStartsWith(url, 'https://members.lpoint.com/exView/join/mbrJoin')){ \n");
			sb.append(loginfailData("로그인_실패_기타", version));
			sb.append(
					"    }else if(stStartsWith(url, 'https://securem.lotteimall.com/jsp/member/login/forward.LCLoginMem.lotte?msgflag=Y')){ \n");
			sb.append(loginfailData("로그인_실패_계정불일치", version));
			sb.append(" 	}else if(stStartsWith(url, 'https://members.lpoint.com/exView/manage/')){ ");
			sb.append(loginfailData("로그인_실패_기타", version));
			sb.append("    }else if (goLogin){ \n");
			sb.append(
					"      if(stStartsWith(url, 'https://securem.lotteimall.com/jsp/member/login/forward.LCLoginMem.lotte') || stStartsWith(url, 'https://m.lotteimall.com/jsp/member/login/forward.LCLoginMem.lotte')){ \n");
			sb.append("      window.android.runLogin();  \n");
			sb.append("      	$('#login_id').val(strId); \n");
			sb.append("      	$('#password').val(strPw); \n");
			sb.append("      	setTimeout(function(){$('#btn_login').click()},700); \n");

			sb.append("      } \n");
			sb.append("    }      \n");
			sb.append("  }catch(e){ window.android.onError(e.message+'|'+url);\n");
			sb.append("  } \n");
			sb.append("   },2000) \n");
			sb.append("} \n");
			schemes.put("lotteimall", sb.toString());

			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("var strId = '[[id]]'; \n");
			sb.append("var strPw = '[[pwd]]'; \n");
			sb.append("var goLogin = [[gologin]] ; \n");
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append("	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append("   if(stStartsWith(url, 'https://m.hnsmall.com/main')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append("    }else if(stStartsWith(url, 'https://m.hnsmall.com/mypage/order/list')){ \n");
			sb.append("     window.android.onLoginSuccess() \n");
			sb.append("    }else if (goLogin){ \n");
			sb.append("      window.android.runLogin();  \n");
			sb.append("    	document.getElementById('mem_id').value = strId; \n");
			sb.append("    	document.getElementById('mem_pw').value = strPw; \n");
			sb.append("    	login(document.loginForm); \n");
			sb.append("      setTimeout(function(){  document.getElementById('goLatterPasswdChg').click();},2000); \n");//90일 비밀번호 변경 안내 팝업 대응 				

			sb.append("    }      \n");
			sb.append("  }catch(e){ window.android.onError(e.message+'|'+url);\n");
			sb.append("  } \n");
			sb.append("} \n");
			schemes.put("hnsmall", sb.toString());

			sb.setLength(0);
			 	sb.append("javascript:{ \n");
				sb.append("var strId = '[[id]]'; \n");
				sb.append("var strPw = '[[pwd]]'; \n");
				sb.append("var goLogin = [[gologin]] ; \n");
				sb.append("function stStartsWith(str, str2){ \n");
				sb.append("	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
				sb.append("} \n");
				sb.append(" var url = document.location.href; \n");
				sb.append(" try{ \n");
				sb.append("   if(stStartsWith(url, 'https://mall.epost.go.kr/mo/main/mobileMain.do')){ \n");
				sb.append("     window.android.onLoginSuccess() \n");
				sb.append("    }else if(stStartsWith(url, 'https://mall.epost.go.kr/mo/mypage/mypageMainSearch.do')){ \n");
				sb.append("     window.android.onLoginSuccess() \n");
				sb.append("    }else if (goLogin){ \n");
				sb.append("      document.getElementById('id').value = strId; \n");
				sb.append("      document.getElementById('passwd').value = strPw;        \n");
				sb.append("      checkVal();        \n");
				sb.append("      window.android.runLogin()  \n");
				sb.append("    }      \n");
				sb.append("  }catch(e){ window.android.onError(e.message);\n");
				sb.append("  } \n");
				sb.append("} \n"); 
			schemes.put("epost", sb.toString());

			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("var strId = '[[id]]'; \n");
			sb.append("var strPw = '[[pwd]]'; \n");
			sb.append("var goLogin = [[gologin]] ; \n");
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append(" return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append(" if(stStartsWith(url, 'http://mobile.kyobobook.co.kr/?tabNm=home')){ \n");
			sb.append(" window.android.onLoginSuccess() \n");
			sb.append(" }else if(stStartsWith(url, 'http://order.kyobobook.co.kr/myroom/order/orderList')){ \n");
			sb.append(" window.android.onLoginSuccess() \n");
			sb.append(" }else if(stStartsWith(url, 'https://mobile.kyobobook.co.kr/member/checkPwTerm')){ \n");
			sb.append(loginfailData("로그인_실패_계정불일치", version));
			sb.append(" }else if (goLogin){ \n");
			sb.append("      window.android.runLogin();  \n");
			sb.append("      document.getElementById('j_username').value = strId; \n");
			sb.append("      document.getElementById('j_password').value = strPw;        \n");
			sb.append("      login();  \n");
			sb.append("     }  \n");
			sb.append("  }catch(e){ window.android.onError(e.message+'|'+url); \n");
			sb.append("  } \n");
			sb.append("} \n");
			schemes.put("kyobo", sb.toString());

			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("var strId = '[[id]]'; \n");
			sb.append("var strPw = '[[pwd]]'; \n");
			sb.append("var goLogin = [[gologin]] ; \n");
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append("	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append("   if(stStartsWith(url, 'http://m.yes24.com/')){ \n");
			sb.append("     window.android.onLoginSuccess(); \n");
			sb.append("    }else if(stStartsWith(url, 'https://ssl.yes24.com/mMyPage/MyPageOrderList')){ \n");
			sb.append("     window.android.onLoginSuccess(); \n");
			sb.append("    }else if(stStartsWith(url, 'http://m.yes24.com/MyPage')){ \n");
			sb.append("     window.android.onLoginSuccess(); \n");
			sb.append("    }else if(stStartsWith(url, 'https://m.yes24.com/Member/PasswordChangeCampaign')){ \n");
			sb.append("     window.android.onLoginSuccess(); \n");
			sb.append("    }else if(stStartsWith(url, 'http://m.yes24.com/Member/PasswordChangeCampaign')){ \n");
			sb.append("     window.android.onLoginSuccess(); \n");
			sb.append("    }else if(stStartsWith(url, 'https://m.yes24.com/Momo/Templates/DormantMember.aspx')){ \n");
			sb.append(loginfailData("로그인_실패_기타", version));
			sb.append("    }else if (goLogin){ \n");
			sb.append("      window.android.runLogin();  \n");
			sb.append("      document.getElementById('SMemberID').value = strId; \n");
			sb.append("      document.getElementById('SMemberPassword').value = strPw;        \n");
			sb.append("      document.getElementById('btn_login').click();        \n");
			sb.append("    }      \n");
			//20210218 비밀번호 오류 팝업이 레이아웃이다
			sb.append(
					"    if(document.querySelector('#yesWrap > div.blockUI.blockMsg.blockElement > div > div')||document.querySelector('#yesWrap > div.blockUI.blockMsg.blockElement > div > div')) { \n");
			sb.append(loginfailData("로그인_실패_계정불일치", version));
			sb.append("    }      \n");

			sb.append("  }catch(e){ window.android.onError(e.message+'|'+url);\n");
			sb.append("  } \n");
			sb.append("} \n");
			schemes.put("yes24", sb.toString());

			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("var strId = '[[id]]'; \n");
			sb.append("var strPw = '[[pwd]]'; \n");
			sb.append("var goLogin = [[gologin]] ; \n");
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append("	return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			
		
			
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append("   if(stStartsWith(url, 'https://www.aladin.co.kr/m/main.aspx')){ \n");
			sb.append("     window.android.onLoginSuccess(); \n");
			sb.append("    }else if(stStartsWith(url, 'https://www.aladin.co.kr/m/maccount.aspx?pType=orderlist')){ \n");
			sb.append("     window.android.onLoginSuccess(); \n");
			sb.append("    }else if(stStartsWith(url, 'https://www.aladin.co.kr/account/PwdExpirationNoti.aspx')){ \n");
			sb.append("     window.android.onLoginSuccess(); \n");
			sb.append("    }else if (goLogin){ \n");
			sb.append("      window.android.runLogin();  \n");
			sb.append("      document.getElementById('Email').value = strId; \n");
			sb.append("      document.getElementById('Password').value = strPw;        \n");
			sb.append("      fn_submit();        \n");
			sb.append("    }      \n");
			sb.append("  }catch(e){ window.android.onError(e.message+'|'+url);\n");
			sb.append("  } \n");
			sb.append("} \n");
			schemes.put("aladin", sb.toString());

			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("var strId = '[[id]]'; \n");
			sb.append("var strPw = '[[pwd]]'; \n");
			sb.append("var goLogin = [[gologin]] ; \n");
			sb.append("function stStartsWith(str, str2){ \n");
			sb.append(" return str2.length > 0 && str.substring( 0, str2.length ) === str2; \n");
			sb.append("} \n");
			
			sb.append(" function loginfailDataJS(errorMsgTitle){ \n");
			sb.append("		if ("+version+" < 400) { \n");
			sb.append("			   window.android.onLoginFail(); \n");
			sb.append("		} else { \n");
			sb.append("			if (errorMsgTitle.includes('|')) { \n");
			sb.append("				   window.android.onLoginFailData(  errorMsgTitle  + url) \n");
			sb.append("			} else { \n");
			sb.append("				  window.android.onLoginFailData( errorMsgTitle + '|' + url) \n");
			sb.append("			} \n");
			sb.append("		} \n");			
			sb.append("} \n");
			
			
			sb.append(" var url = document.location.href; \n");
			sb.append(" try{ \n");
			sb.append("   if(stStartsWith(url, 'https://m.coupang.com/')){ \n");
			sb.append("     	window.android.onLoginSuccess(); \n");
			sb.append("    }else if(stStartsWith(url, 'https://mc.coupang.com/ssr')){ \n");
			sb.append("    		 window.android.onLoginSuccess(); \n");
			//sb.append("    }else if(stStartsWith(url, 'https://login.coupang.com/login/loginRetry.pang')){ \n");
			//sb.append("    		 window.android.onNewWebview(); \n");
			sb.append("    }else if(stStartsWith(url, 'https://login.coupang.com/login/pincode/select')){\n");
			
			sb.append(" alert('쿠팡 : 새로운 환경에서 로그인 할 경우 본인인증 절차가 필요합니다.');\n");
			//20220711에 삭제함
			//sb.append(" window.android.onLoginFail() \n");
			sb.append( loginfailData("로그인_실패_계정불일치|새로운 환경에서 로그인 할 경우 본인인증 절차가 필요합니다.", version));
			
			sb.append("    }else if (goLogin){ \n");
			sb.append("      	window.android.runLogin();  \n");
			sb.append("      	var jump = 1000; \n");
			sb.append("      	var tempTime = Math.random() * jump;\n");
			sb.append("      	setTimeout(function(){  \n");
			sb.append("      		document.querySelector(\"#login-email-input\").focus(); \n");
			sb.append("      	    document.querySelector(\"#login-email-input\").click(); \n");
			sb.append("      	 },tempTime); \n");
			sb.append("      	tempTime += Math.random() * jump;\n");
			sb.append("      	setTimeout(function(){  \n");
			sb.append("      	    $('#login-email-input').val(strId); \n");
			sb.append("      	 },tempTime); \n");
			
			sb.append("      	tempTime += Math.random() * jump;\n");
			sb.append("      	 setTimeout(function(){  \n");
			sb.append("      	 $('#login-email-input').keydown(); \n");
			sb.append("      	 $('#login-email-input').keypress(); \n");
			sb.append("      	 $('#login-email-input').keyup(); \n");
			sb.append("      	 $('#login-email-input').blur(); \n");
			sb.append("      	 },tempTime); \n");
				    

			   
			sb.append("      	tempTime += Math.random() * jump;\n");
			sb.append("      	 setTimeout(function(){  \n");
			sb.append("      	     document.querySelector(\"#login-password-input\").focus(); \n");
			sb.append("      	     document.querySelector(\"#login-password-input\").click(); \n");
			sb.append("      	     $('#login-password-input').val(strPw); \n");
			sb.append("      	 },tempTime); \n");
			
			
			sb.append("      	tempTime += Math.random() * jump;\n");
			sb.append("      	 setTimeout(function(){  \n");
			sb.append("      	 $('#login-password-input').keydown(); \n");
			sb.append("      	 $('#login-password-input').keypress(); \n");
			sb.append("      	 $('#login-password-input').keyup(); \n");
			sb.append("      	 $('#login-password-input').blur(); \n");
			sb.append("      	 },tempTime); \n");
			
			
			
			sb.append("      	tempTime += Math.random() * jump;\n");
			sb.append("      	 setTimeout(function(){  \n");
			sb.append("      		document.querySelector('body > div.member-wrapper.member-wrapper--flex > div > div > form > div.login__content.login__content--trigger > button').click(); \n");
			//sb.append("      	     document.querySelector('body > div.member-wrapper.member-wrapper--flex > div > div > form').submit(); \n");
		    sb.append("      	 },tempTime); \n");
		/* 	sb.append("      	tempTime += Math.random() * jump;\n");
			sb.append("      	 setTimeout(function(){  \n");
			sb.append("      		document.querySelector('body > div.member-wrapper.member-wrapper--flex > div > div > form > div.login__content.login__content--trigger > button').click(); \n");
			//sb.append("      	     document.querySelector('body > div.member-wrapper.member-wrapper--flex > div > div > form').submit(); \n");
		    sb.append("      	 },tempTime); \n");
			sb.append("      	tempTime += Math.random() * jump;\n");
			sb.append("      	 setTimeout(function(){  \n");
			sb.append("      		document.querySelector('body > div.member-wrapper.member-wrapper--flex > div > div > form > div.login__content.login__content--trigger > button').click(); \n");
			//sb.append("      	     document.querySelector('body > div.member-wrapper.member-wrapper--flex > div > div > form').submit(); \n");
		    sb.append("      	 },tempTime); \n"); */
		    sb.append("      	tempTime += 3000; \n");
			sb.append("      	setTimeout(function(){ \n");
            sb.append("                var capcha = $('._loginCaptchaContainer').css('display');\n ");
			sb.append("				if (capcha == null || capcha != 'none') {\n ");			
			sb.append(					loginfailData("로그인_실패_캡차", version));
			sb.append("				}\n ");			
			 
			sb.append("				if (document.querySelector('div.login__content.login__content--message > div').style.display != 'none'){   \n ");  
			sb.append("				    if( document.querySelector('div.login__content.login__content--message > div') != null){  \n ");
			sb.append("						var msg =  document.querySelector('div.login__content.login__content--message > div').innerHTML \n ");
			sb.append("						if (msg.includes('오류')){ \n ");			//오류가 발생했습니다.https://login.coupang.com/login/login.pangrtnUrl=https3A2F2Fmc.coupang.com2Fssr2Fmobile2Forder2Flist			
			sb.append("							loginfailDataJS('로그인_실패_기타|'+ msg); \n ");
			sb.append("						}else { \n ");
			sb.append("							loginfailDataJS('로그인_실패_계정불일치|'+ msg); \n ");
			sb.append("						} \n ");
			sb.append("					}else { \n ");  
			sb.append("						loginfailDataJS('로그인_실패_계정불일치|innerHTML = null'); \n ");  
			sb.append("					} \n ");  
			sb.append("				} \n ");  
			sb.append("				if (document.querySelector('div:nth-child(1) > div.member__expand-field > div').style.display != 'none'){ \n ");   
			sb.append("				    if( document.querySelector('div:nth-child(1) > div.member__expand-field > div') != null){  \n ");
			sb.append("						var msg =  document.querySelector('div:nth-child(1) > div.member__expand-field > div').innerHTML \n ");
			sb.append("						if (msg.includes('오류')){ \n ");						
			sb.append("							loginfailDataJS('로그인_실패_기타|'+ msg); \n ");
			sb.append("						}else { \n ");
			sb.append("							loginfailDataJS('로그인_실패_계정불일치|'+ msg); \n ");
			sb.append("						} \n ");
			sb.append("					}else { \n ");  
			sb.append("						loginfailDataJS('로그인_실패_계정불일치|innerHTML = null'); \n ");  
			sb.append("					} \n ");
			sb.append("				} \n "); 

			sb.append("      	}, tempTime); \n");
			sb.append("    }      \n");
			sb.append("  }catch(e){ \n");
			sb.append("     window.android.onError(e.message+'|'+url);\n");
			sb.append("  } ");
			sb.append("} ");
			schemes.put("coupang", sb.toString());
			
			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("  var strId = '[[id]]';      \n");
			sb.append("  var strPw = '[[pwd]]'; \n");
			sb.append("  var goLogin = [[gologin]] ; \n");
			sb.append("  function stStartsWith(str, str2){          \n");
			sb.append("    return str2.length > 0 && str.substring( 0, str2.length ) === str2;    \n");  
			sb.append("  }       \n");
			
			
			sb.append("    var url = document.location.href;          \n");
			sb.append("    try{              \n");
			sb.append("       if(stStartsWith(url, 'https://www.musinsa.com/app/mypage/order_list_opt')){      \n");           
			sb.append("          window.android.onLoginSuccess();          \n");
			sb.append("       }else if(stStartsWith(url, 'https://m.store.musinsa.com/app/mypage/order_list_opt')){      \n");           
			sb.append("          window.android.onLoginSuccess();          \n");
			sb.append("       }else if(stStartsWith(url, 'https://my.musinsa.com/auth/update-password?')){      \n");           
			sb.append("          window.android.onLoginSuccess();          \n");
			sb.append("       }else if(stStartsWith(url, 'https://www.musinsa.com/?mod=mypage&page=updata_pw')  ){            \n");      
			sb.append("         var stSkipBtn = document.getElementsByClassName('skip');                  \n");
			sb.append("         if(stSkipBtn.length > 0){                      \n");
			sb.append("           stSkipBtn[0].click();                  \n");
			sb.append("         }              \n");
			sb.append("       }else if(stStartsWith(url, 'https://my.musinsa.com/login/v1/update-password')){            \n");      
			sb.append("         document.getElementById('changeSkipBtn').click();         \n");     
			sb.append("       }else if(stStartsWith(url, 'https://musinsa.com/auth/update-password?token')){            \n");      
			sb.append("        document.querySelector('#passwordChangeForm > div.login-button.login-button--static > button.login-button__link--bottom').click()        \n");     
			sb.append("       }else if(goLogin){                    \n");
			sb.append("          window.android.runLogin(); \n");
			sb.append("          document.getElementsByName('id')[0].value = strId;                   \n");
			sb.append("          document.getElementsByName('pw')[0].value = strPw;                 \n");  
			sb.append("          loginform.submit(); \n");
			sb.append("        }                 \n");
			sb.append("      }catch(e){              \n");
			sb.append("        window.android.onError(e.message+'|'+url);        \n");  
			sb.append("      }  \n");
			sb.append("} \n");
			schemes.put("musinsa", sb.toString());
			
			
			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("    var strId =  '[[id]]' ;    \n");
			sb.append("    var strPw =  '[[pwd]]' ;      \n");
			sb.append("    var goLogin = [[gologin]] ;     \n");
			sb.append("    function strStartsWith(str, str2){          \n");
			sb.append("      return str2.length > 0 && str.substring( 0, str2.length ) === str2;      \n");
			sb.append("    }      \n");
			sb.append("    var url = document.location.href;          \n");
			sb.append("    function getCaptcha(){          \n");
			sb.append("        var captcha = document.getElementsByClassName('captchaWrap');       \n");   
			sb.append("        if(captcha != null && captcha.length > 0){              \n");
			sb.append("            if(captcha[0].style.display != 'none'){                  \n");
			sb.append(loginfailData("로그인_실패_캡차", version));     
			sb.append("             }                     \n");
			sb.append("         }      \n");
			sb.append("     }    \n");
			sb.append("    try{              \n");
			sb.append("      if(strStartsWith(url, 'https://mbook.interpark.com/shop/ordersearch/main')){                  \n");
			sb.append("        window.android.onLoginSuccess();             \n");
			sb.append("      }else if(strStartsWith(url, 'http://mbook.interpark.com/shop/ordersearch/main')){             \n");     
			sb.append("        window.android.onLoginSuccess();              \n");
			sb.append("      }else if(goLogin){          \n");
			sb.append("        document.getElementById('userId').value = strId;             \n");     
			sb.append("        document.getElementById('userPwd').value = strPw; \n");
			sb.append("        proces();                  \n");
			sb.append("        var logintBtn = document.getElementById('btn_login');          \n");        
			sb.append("        setTimeout(getCaptcha(), 2000);                  \n");
			sb.append("        logintBtn.click();             \n");
			sb.append("        window.android.runLogin();         \n");
			sb.append("     }                   \n");
			sb.append("   }catch(e){              \n");
			sb.append("     console.log(e.message+'|'+url);         \n");
			sb.append("   }        \n");
			sb.append(" }        \n");
			schemes.put("interpark=-=mbook", sb.toString());
			
			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("    var strId =  '[[id]]' ;    \n");
			sb.append("    var strPw =  '[[pwd]]' ;      \n");
			sb.append("    var goLogin = [[gologin]] ;     \n");
			sb.append("    function strStartsWith(str, str2){          \n");
			sb.append("      return str2.length > 0 && str.substring( 0, str2.length ) === str2;      \n");
			sb.append("    }      \n");
			sb.append("    var url = document.location.href;          \n");
			sb.append("    try{              \n");
			sb.append("      if(strStartsWith(url, 'https://m.oliveyoung.co.kr/m/mypage/getOrderList.do')){                  \n");
			sb.append("        window.android.onLoginSuccess();             \n");
			sb.append("      }else if(goLogin){          \n");
			sb.append("        document.getElementById('loginId').value = strId;             \n");     
			sb.append("        document.getElementById('password').value = strPw; \n");
			sb.append("        mlogin.login.doLogin();                  \n");
			sb.append("        window.android.runLogin();         \n");
			sb.append("     }                   \n");
			sb.append("   }catch(e){              \n");
			sb.append("     console.log(e.message+'|'+url);         \n");
			sb.append("   }        \n");
			sb.append(" }        \n");
			schemes.put("oliveyoung", sb.toString());
			
			sb.setLength(0);
			sb.append("javascript:{ \n");
			sb.append("    var strId =  '[[id]]' ;    \n");
			sb.append("    var strPw =  '[[pwd]]' ;      \n");
			sb.append("    var goLogin = [[gologin]] ;     \n");
			sb.append("    function strStartsWith(str, str2){          \n");
			sb.append("      return str2.length > 0 && str.substring( 0, str2.length ) === str2;      \n");
			sb.append("    }      \n");
			sb.append("    var url = document.location.href;          \n");
			sb.append("    try{              \n");
			sb.append("      if(strStartsWith(url, 'https://m.amoremall.com/kr/ko/my/page/onlineOrderShipping')){                  \n");
			sb.append("        window.android.onLoginSuccess();             \n");
			sb.append("      }else if(goLogin){          \n");
			sb.append("       document.getElementsByName('chcsNo')[0].value = strId             \n");     
			sb.append("       document.getElementsByName('userPwdEc')[0].value = strPw             \n");     
			sb.append("       	setTimeout(function(){             \n");     
			sb.append("       		document.getElementById('login').click();             \n");     
			sb.append("       		setTimeout(function(){             \n");     
			sb.append("       			if(document.getElementsByClassName('layer_md')[0].style.display != 'none'){             \n");     
			sb.append(                       loginfailData("로그인_실패_기타", version));     
			sb.append("       			}             \n");     
			sb.append("       	    }, 500)             \n");     
			sb.append("       	}, 200)             \n");     
			sb.append("        window.android.runLogin();         \n");
			sb.append("     }                   \n");
			sb.append("   }catch(e){              \n");
			sb.append("     console.log(e.message+'|'+url);         \n");
			sb.append("   }        \n");
			sb.append(" }        \n");
			schemes.put("amoremall", sb.toString());
			
			
		} catch (Exception e) {
		}
	} else if (scheme.equals("snsList")) { // 가능한 소셜 로그인 리스트//logintype : to ka na ap fa pa
		try {
			/**
			 4.0.7 
			 type >  to ka na ap fa pa
			 icon > 버튼아이콘
			 icon_p >팝업 타이틀 아이콘
			 ihint > 아이디 인풋박스 힌트텍스트
			 phint > 패스워드 인풋박스 힌트텍스트
			 name > 이름
			**/
			
			JSONObject tworld = new JSONObject();
			tworld.put("type","to");
			tworld.put("icon","http://img.enuri.info/images/mobilefirst/appImage/sns/logo_48_x_48_t.png");
			tworld.put("icon_p","http://img.enuri.info/images/mobilefirst/appImage/sns/logo_28_t.png");
			tworld.put("ihint","T아이디(휴대폰,이메일) ");
			tworld.put("phint","비밀번호");
			tworld.put("name","T아이디");
			tworld.put("land_url","");
			
			JSONObject naver = new JSONObject();
			naver.put("type","na");
			naver.put("icon","http://img.enuri.info/images/mobilefirst/appImage/sns/logo_48_x_48_naver.png");
			naver.put("icon_p","http://img.enuri.info/images/mobilefirst/appImage/sns/logo_28_naver.png");
			naver.put("ihint","아이디");
			naver.put("phint","비밀번호");
			naver.put("name","네이버");
			naver.put("land_url","");
			
			JSONObject kakao = new JSONObject();
			kakao.put("type","ka");
			kakao.put("icon","http://img.enuri.info/images/mobilefirst/appImage/sns/logo_48_x_48_kakao.png");
			kakao.put("icon_p","http://img.enuri.info/images/mobilefirst/appImage/sns/logo_28_kakao.png");
			kakao.put("ihint","카카오메일 아이디, 이메일, 전화번호");
			kakao.put("phint","비밀번호");
			kakao.put("name","카카오");
			kakao.put("land_url","");
			
			JSONObject apple = new JSONObject();
			apple.put("type","ap");
			apple.put("icon","http://img.enuri.info/images/mobilefirst/appImage/sns/logo_48_x_48_apple.png");
			apple.put("icon_p","http://img.enuri.info/images/mobilefirst/appImage/sns/logo_28_apple.png");
			apple.put("ihint","APPLE ID");
			apple.put("phint","비밀번호");
			apple.put("name","APPLE");
			apple.put("land_url","");
			
			JSONObject facebook = new JSONObject();
			facebook.put("type","fa");
			facebook.put("icon","http://img.enuri.info/images/mobilefirst/appImage/sns/logo_48_x_48_facebook.png");
			facebook.put("icon_p","http://img.enuri.info/images/mobilefirst/appImage/sns/logo_28_facebook.png");
			facebook.put("ihint","이메일 또는 전화");
			facebook.put("phint","비밀번호");
			facebook.put("name","페이스북");
			facebook.put("land_url","");
			
			JSONObject payco = new JSONObject();
			payco.put("type","pa");
			payco.put("icon","http://img.enuri.info/images/mobilefirst/appImage/sns/logo_48_x_48_payco.png");
			payco.put("icon_p","http://img.enuri.info/images/mobilefirst/appImage/sns/logo_28_payco.png");
			payco.put("ihint","이메일 또는 휴대폰");
			payco.put("phint","비밀번호");
			payco.put("name","페이코");
			payco.put("land_url","");
			
			schemes.put("11st", new JSONArray().put(tworld));
			/* if(isDev){
				schemes.put("interpark", new JSONArray().put(naver).put(kakao).put(apple).put(facebook));
				schemes.put("gmarket", new JSONArray().put(kakao).put(naver).put(apple).put(facebook).put(payco));
				schemes.put("auction", new JSONArray().put(kakao).put(naver).put(facebook).put(payco));
				schemes.put("coupang", new JSONArray().put(naver).put(kakao));
			} */
		} catch (Exception e) {
		}
	}
	return schemes;
}

//이클럽 즉시적립상세페에지 주의사항
public String getEclubCaustions() {
	StringBuilder cautions = new StringBuilder();
	cautions.append("- 본 이벤트는 사전에 고지 없이 변경 및 취소될 수 있습니다.\n");
	cautions.append("- 앱설치 미션의 경우 앱설치 이후 상세보기 페이지에서");
	cautions.append(" '앱 설치 확인' 버튼을 클릭해야 포인트가 적립됩니다.\n");
	cautions.append("- e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후");
	cautions.append(" 재 적립 불가)\n");
	cautions.append("- 적립된 e머니는 1,000여가지 인기 e쿠폰으로 교환 가능");
	cautions.append(" 합니다.\n");
	cautions.append("- 참여 시 부정참여, 중복참여 확인 시 이벤트 참여 및 e머니");
	cautions.append(" 지급에 제한을 받을 수 있습니다. [사용하기]\n");
	cautions.append("- Wifi 아닌 환경에서는 데이터 이용료가 발생할 수 있습니다.\n");
	cautions.append("- e머니 적립 및 문의는 [고객센터]에서 확인 해주세요.\n");
	return cautions.toString();
}

public String loginfailData(String errorMsgTitle, int version) {
	if (version < 400) {
		return "     window.android.onLoginFail() \n";
	} else {
		if (errorMsgTitle.contains("|")) {
			return "     window.android.onLoginFailData( '" + errorMsgTitle + " ' + url) \n";
		} else {
			return "     window.android.onLoginFailData( '" + errorMsgTitle + "|' + url) \n";
		}
	}
}


public String getParamValueScript() {

	StringBuilder getParamFunction = new StringBuilder();
	getParamFunction.append("function getParamValue(key){ ");
	getParamFunction.append("   var getUrl=(document.documentURI); ");
	getParamFunction.append("   var vv = getUrl.split('?')[1]; ");
	getParamFunction.append("   var params = vv.split('&'); ");
	getParamFunction.append("   for (var i = 0; i < params.length; i++)  ");
	getParamFunction.append("   {  ");
	getParamFunction.append("      var pairs = params[i].split('='); ");
	getParamFunction.append("      if(pairs[0] == key)  ");
	getParamFunction.append("      {  ");
	getParamFunction.append("         return pairs[1]; ");
	getParamFunction.append("      }  ");
	getParamFunction.append("   }  ");
	getParamFunction.append("} ");
	return getParamFunction.toString();
}

public JSONArray getJSONArrayfromFile(String filePath) {

	String news_data = "";

	try {
		InputStream inputStream = new FileInputStream(filePath);

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
		return new JSONArray(new String(arBytes, "utf-8"));
	} catch (Exception e) {

	}
	return null;
}

public JSONObject getJSONObjectfromFile(String filePath) {

	String news_data = "";
	StringBuilder news_buffer = new StringBuilder();

	try {
		InputStream inputStream = new FileInputStream(filePath);
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

//https://docs.google.com/spreadsheets/d/1zwye4AD5rmIrTiZzzD9TfSQuYKIA2n9E/edit?usp=sharing&ouid=116053619391021363076&rtpof=true&sd=true
public void freetokenFilter(JSONObject defaultDefineInfo, String os, int ver) {

	JSONArray arr = new JSONArray();
	try {

		arr.put(getFreetokenFilterObj("mobilefirst/login/policy.jsp", "freetoken=login_sub", "app_id=1001"));
		arr.put(getFreetokenFilterObj("/mobilefirst/login/ruleWrap.jsp", "freetoken=login_sub"));
		arr.put(getFreetokenFilterObj("/mobilefirst/emoney/emoney_faq.jsp", "freetoken=faq"));
		arr.put(getFreetokenFilterObj("global/m/Index.jsp", "freetoken=global"));
		arr.put(getFreetokenFilterObj("/enuricar/m/list.jsp", "freetoken=reborncar"));
		arr.put(getFreetokenFilterObj("/mobilefirst/http/emoney_benefit.jsp", "freetoken=event"));
		arr.put(getFreetokenFilterObj("enuri.com/m/event2022/", "freetoken=event"));
		arr.put(getFreetokenFilterObj("/mobilefirst/member/myAuth.jsp", "freetoken=login_title"));
		arr.put(getFreetokenFilterObj("/mobilefirst/emoney/emoney_store.jsp", "freetoken=emoney","enurineedlogin=N" ));
		arr.put(getFreetokenFilterObj("/mobilefirst/emoney/emoney.jsp", "freetoken=emoney"));
		arr.put(getFreetokenFilterObj("mobilefirst/emoney/emoney_detail.jsp", "freetoken=emoney_sub"));
		arr.put(getFreetokenFilterObj("/my/my_emoney_m.jsp", "freetoken=emoney"));
		arr.put(getFreetokenFilterObj("/mobilefirst/move2.jsp", "freetoken=outlink"));
		arr.put(getFreetokenFilterObj("/m/login/policy_shopping_report.jsp", "freetoken=login_title"));
		arr.put(getFreetokenFilterObj("/mobilefirst/news_detail.jsp", "freetoken=shoppingknow"));
		arr.put(getFreetokenFilterObj("/my/my_newcar_m.jsp", "freetoken=reborncar"));
		arr.put(getFreetokenFilterObj("enuri.com/m/list.jsp", "freetoken=list"));
		arr.put(getFreetokenFilterObj("/mobilefirst/planlist.jsp", "freetoken=list"));
		arr.put(getFreetokenFilterObj("enuri.com/m/search.jsp", "freetoken=srp"));
		arr.put(getFreetokenFilterObj("enuri.com/knowcom/", "freetoken=shoppingknow"));
		arr.put(getFreetokenFilterObj("enuri.com/m/event/", "freetoken=event"));
		arr.put(getFreetokenFilterObj("enuri.com/m/cpp.jsp", "freetoken=cpp"));
		arr.put(getFreetokenFilterObj("/brandstore/list.jsp", "freetoken=brandstore_list"));
		arr.put(getFreetokenFilterObj("/brandstore/recommand.jsp", "freetoken=brandstore_recom"));
		arr.put(getFreetokenFilterObj("/auto.enuri.com/", "freetoken=reborncar"));
		defaultDefineInfo.put("FREETOKEN_LINK", arr);

	} catch (Exception e) {

	}

}

public JSONObject getFreetokenFilterObj(String containUrl, String... addParams) {

	JSONObject obj = new JSONObject();
	try {
		JSONArray objArray = new JSONArray();
		obj.put("url", containUrl);
		if (addParams.length > 0) {
			for (int i = 0; i < addParams.length; i++) {
				objArray.put(addParams[i]);
			}
			obj.put("addParams", objArray);
		}
	} catch (Exception e) {
	}
	return obj;

}
/* 	public JSONObject getRewardBackground( String[] ACTION_LINKS, String ACTION_SCRIPT, String[] REWARD_LINKS, String REWARD_SCRIPT ){
		
		JSONObject obj = new JSONObject();
		try{
			StringBuilder sb = new StringBuilder();
			JSONArray arr1 = new JSONArray();
			for (int i = 0 ; i < ACTION_LINKS.length; i ++){
				arr1.put(ACTION_LINKS[i]);
			}
			obj.append("ACTION_LINKS", arr1); //결제 창일때 
			obj.append("ACTION_SCRIPT", ACTION_SCRIPT);//결과 값을 가지고 백그라운드에서 실행
			JSONArray arr2 = new JSONArray();
			for (int i = 0 ; i < REWARD_LINKS.length; i ++){
				arr2.put(REWARD_LINKS[i]);
			}
			
			obj.append("REWARD_LINKS", arr2);//백그라운드 링크가 이것일때 
			obj.append("REWARD_SCRIPT",REWARD_SCRIPT);// 스크립트 실행
		}
		catch(Exception e){
			
		}
		return obj;
	} */%>
