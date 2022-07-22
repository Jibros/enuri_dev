
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.enuri.bean.mobile.Mobile_GoodsToPricelist_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_GoodsToPricelist_Data"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="java.net.*"%>

<%@page import="java.net.*"%>

<%
boolean isDev = request.getServerName().contains("dev.enuri.com");
boolean isCrazyDealUseable = false;

String server = "m";

String pages[] = { "mobile_deal_list.json", "0", "", "http://localhost/mobilefirst/http/json/mobile_deal_list.json",
		"mainBanner", "0", "",
		//"http://ad-api.enuri.info/enuri_M/m_main/M1/bundle?bundlenum=11",
		"http://localhost/mobilenew/gnb/category/mainBanner.json", "httparray", "0", "",
		"http://localhost/mobilefirst/http/json/shopMainLogo.json", "httpobject", "0", "",
		"http://localhost/mobilefirst/http/json/banner_list.json", "middle_banner.json", "0", "",
		//"http://ad-api.enuri.info/enuri_M/m_main/M2/bundle?bundlenum=2"
		"http://localhost/mobilefirst/ajax/middle_banner2.json" };
JSONObject makeJson = new JSONObject();
try {

	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String dates = formatter.format(new Date());
	makeJson.put("time", dates);

	for (int i = 0; i < pages.length; i += 4) {
		try {
	String splits[] = pages[i + 3].split("/");

	if (isCrazyDealUseable) {
		if (pages[i].equals("mobile_deal_list.json")) {
	JSONArray obj;
	obj = getJSONArrayfromHttpDeal(pages[i + 3]);
	//obj = getJSONArrayfromHttp(pages[i + 3]);
	if (obj != null)
		makeJson.put("mobile_deal_list.json", obj);
		}
	}
	if (pages[i].equals("httpobject")) {
		JSONObject obj;
		obj = getJSONObjectfromHttp(pages[i + 3]);
		if (obj != null)
	makeJson.put(splits[splits.length - 1], obj);
	} else if (pages[i].equals("mainBanner")) {
		JSONArray obj;
		obj = getJSONArrayfromHttp(pages[i + 3]);
		if (obj != null && obj.length() > 0)
	makeJson.put("mainBanner.json", obj);
	} else if (pages[i].equals("middle_banner.json")) {
		JSONArray obj;
		obj = getJSONArrayfromHttp(pages[i + 3]);
		if (obj != null) {
	// ios 3.3.2 버전 이하에서 [] 이값이 들어가면 홈 상품 나오지 않는 현상 예외처리함
	if (obj.toString().startsWith("[{")) {
		makeJson.put("middle_banner.json", obj);
		makeJson.put("middle_banner_fixlocation", "5;");
	}

		}
	} else if (pages[i].equals("httparray")) {
		JSONArray obj;
		obj = getJSONArrayfromHttp(pages[i + 3]);
		if (obj != null)
	makeJson.put(splits[splits.length - 1], obj);
	} else if (pages[i].equals("httpdeal")) {
		JSONArray obj;
		obj = getJSONArrayfromHttpDeal(pages[i + 3]);
		if (obj != null)
	makeJson.put(splits[splits.length - 1], obj);
	} else if (pages[i].equals("array")) {
		JSONArray obj;
		obj = getJSONArrayfromFile(pages[i + 3]);
		if (obj != null)
	makeJson.put(splits[splits.length - 1], obj);
	} else if (pages[i].equals("array_deal")) {
		JSONArray obj;
		obj = getJSONArrayfromFileDeal(pages[i + 3]);
		if (obj != null)
	makeJson.put(splits[splits.length - 1], obj);
	} else if (pages[i].equals("objmax")) {
		JSONArray obj;
		obj = getJSONArrayfromFile(pages[i + 3], pages[i + 1], pages[i + 2]);
		if (obj != null)
	makeJson.put(splits[splits.length - 1], obj);
	} else if (pages[i].equals("objfile")) {
		JSONObject obj;
		obj = getJSONObjectfromFile(pages[i + 3]);
		if (obj != null)
	makeJson.put(splits[splits.length - 1], obj);
	}
		} catch (Exception e) {
		}
	}

	if (isCrazyDealUseable) {
		try {

	String shopCode[] = { "8090", "6641", "55" };
	String iconUrl[] = { "http://img.enuri.info/images/mobilefirst/deal/logo/taillist%s.jpg",
	"http://img.enuri.info/images/mobilefirst/deal/logo/tmon%s.jpg",
	"http://img.enuri.info/images/mobilefirst/deal/logo/interpark%s.jpg" };
	//로고 변경 20190416
	String iconUrl350[] = { "http://img.enuri.info/images/mobilefirst/deal/logo/201904/taillist%s.png",
	"http://img.enuri.info/images/mobilefirst/deal/logo/202002/tmon%s.jpg",
	"http://img.enuri.info/images/mobilefirst/deal/logo/201912/interpark%s.png" };
	JSONArray arrDealShopsIcon = new JSONArray();
	for (int i = 0; i < shopCode.length; i++) {
		JSONObject obj1 = new JSONObject();
		obj1.put("code", shopCode[i]);
		obj1.put("url", iconUrl[i]);
		obj1.put("url_350", iconUrl350[i]);
		arrDealShopsIcon.put(obj1);
	}

	makeJson.put("mobile_deal_list_shops_icon", arrDealShopsIcon);
		} catch (Exception e) {
	//makeJson.put("mobile_deal_list_shops_icon",e.toString());
		}
	}
	/*
	try {
		makeJson.put("shopimage_preurl","http://img.enuri.info/images");
	
		//if(isDev)
	makeJson.put("dimEventPopup",
		getJSONArrayfromHttp("http://ad-api.enuri.info/enuri_M/m_fp/M6/bundle?bundlenum=12"));
		//else 
	//makeJson.put("dimEventPopup",
		//	getJSONArrayfromHttp("http://adsvc.enuri.mcrony.com/enuri_M/m_fp/M6/bundle?bundlenum=12"));
	} catch (Exception e) {
	
	}
	*/
	try {
		makeJson.put("shopimage_preurl", "http://img.enuri.info/images");

		JSONArray arr1 = getJSONArrayfromHttp("http://ad-api.enuri.info/enuri_M/m_fp/M6/bundle?bundlenum=12");
		//c앤c 팀 고대웅 , 김지연이 삭제 요청 eventAppCRM.jsp 호출도 안한다고 한다 20220502
		//JSONArray arr2 = getJSONArrayfromHttp("http://ad-api.enuri.info/enuri_M/m_fp/M6a/bundle?bundlenum=12");

		/* for (int i = 0; i < arr2.length(); i++) {
			arr1.put(arr2.get(i));
		} */
		JSONArray dimpopupArr = new JSONArray();
		int r = (int) ((Math.random() * 10) % 3);

		for (int i = 0; i < arr1.length(); i++) {
	         JSONObject obj = arr1.getJSONObject(i);
	         if(obj.has("SORT")){
	             	String sort = obj.getString("SORT");
	                switch (r) {
	                 case 0:
	                     	  if (sort.equals("1"))
	                                dimpopupArr.put(obj);
	                            break;
	                 case 1:
	                           if (sort.equals("2"))
			                         dimpopupArr.put(obj);
	                           break;
	                 case 2:
	                           if (!sort.equals("1") && !sort.equals("2"))
	                                   dimpopupArr.put(obj);
	                           break;
	                  }
	          }
        }

		makeJson.put("dimEventPopup", dimpopupArr);

	} catch (Exception e) {
		makeJson.put("dimEventPopup err",e.toString());
	}
	

	//홈 상품 구좌 뚫기2017-05-19(개발)
	try {
		JSONArray objfixarray;

		objfixarray = (JSONArray) (getJSONObjectfromHttp(
		"http://localhost/mobilefirst/api/main/mobile_mainlistfix.json").get("MainJsonfix"));

		//objfixarray =(JSONArray) (getJSONObjectfromFile("/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/api/main/
		//mobile_mainlistfix.json").get("MainJsonfix"));

		if (objfixarray != null && objfixarray.length() > 0) {
	JSONArray printarr = new JSONArray();

	Random rnd = new Random();
	for (int i = objfixarray.length() - 1; i >= 0; i--) {

		int j = rnd.nextInt(i + 1);
		// Simple swap
		Object object = objfixarray.get(j);
		objfixarray.put(j, objfixarray.get(i));
		objfixarray.put(i, object);
	}
	//기존에 데이터 있었는데 3.2.9부터 fix_location을 넣지 않는다고 해서 임의로 넣어둠 
	for (int i = 0; i < objfixarray.length(); i++)
		objfixarray.getJSONObject(i).put("fix_location", Integer.toString(99999999 + i));

	//파트명{영역에 들어갈 타입들}
	String partKeys[][] = { { "T", "D", "C", "N" }, { "Q" }, { "T", "D", "C", "N" }, { "A" }, { "Q" }, { "G" },
	{ "A" }, { "G" }, { "G" }, { "G" }, { "G" } };
	//파트명이 들어갈 {위치, 길이, 카운트 초기값}
	int partKeyslocation[][] = { { 1, 10, 0 }, { 15, 1, 0 }, { 16, 3, 0 }, { 20, 1, 0 }, { 25, 1, 0 },
	{ 30, 1, 0 }, { 40, 1, 0 }, { 50, 1, 0 }, { 60, 1, 0 }, { 70, 1, 0 }, { 80, 1, 0 } };

	for (int i = 0; i < partKeys.length; i++) {
		for (int q = 0; q < objfixarray.length() && q >= 0; q++) {
	JSONObject objfixCell = ((JSONObject) objfixarray.get(q));
	//다운 받은 json에 part데이터가 있나 확인
	if (objfixCell.has("part") && !objfixCell.has("shuffle")) {
		String strPart = objfixCell.getString("part");

		if (strPart != null && strPart.length() > 0) {
			for (int j = 0; j < partKeys[i].length && j >= 0; j++) {
				//part가 있고 partKeys[][?]의 값이 있으면 ArrayList인 jsonDatas에 넣어주고  다운 받은 json의 part를 지워버린다 다시 못쓰게
				if (strPart != null && strPart.length() > 0 && strPart.equals(partKeys[i][j])) {
					if (strPart.equals("Q")) {

						int qcnt = 0;
						for (int a = 0; a < objfixarray.length() && a >= 0; a++) {
							JSONObject objfixCellQ = ((JSONObject) objfixarray.get(a));
							if (objfixCellQ.has("part") && !objfixCellQ.has("shuffle")) {
								String strPartQ = objfixCellQ.getString("part");
								if (strPartQ != null && strPartQ.length() > 0 && strPartQ.equals("Q")) {
									objfixCellQ.put("shuffle", true);
									objfixCellQ.put("fix_location", Integer
											.toString(partKeyslocation[i][0] + partKeyslocation[i][2]));
									printarr.put(objfixCellQ);
									qcnt++;
									if (qcnt > 2)
										a = Integer.MAX_VALUE;
								}
							}
						}
						//갯수를 차감 시켜서 j,q for 문을 탈출한다
						if (++partKeyslocation[i][2] >= partKeyslocation[i][1])
							q = Integer.MAX_VALUE;
						j = Integer.MAX_VALUE;
					} else {

						objfixCell.put("shuffle", true);
						objfixCell.put("fix_location",
								Integer.toString(partKeyslocation[i][0] + partKeyslocation[i][2]));
						printarr.put(objfixCell);
						//갯수를 차감 시켜서 j,q for 문을 탈출한다
						if (++partKeyslocation[i][2] >= partKeyslocation[i][1])
							q = Integer.MAX_VALUE;
						j = Integer.MAX_VALUE;
					}
				}
			}
		}
	}
		}
	}
	makeJson.put("mobile_mainlistfix.json", new JSONObject().put("MainJsonfix", printarr));
		}
	} catch (Exception e) {
		makeJson.put("exception4", e.toString());

	}

	/**
	카테고리 3.5.0 //20190404
	 */
	JSONArray cateBarJsonArr350 = new JSONArray();
	{
		String cateBarTitle[] = { "가전", "TV/영상/디카", "컴퓨터/노트북", "태블릿/모바일", "스포츠/자동차", "유아/식품", "가구/생활", "패션/화장품", "PICK",
		"쇼핑지식" };
		String cateBarImageaos[] = { "/images/mobilefirst/main/cate/aos/home_category_menu01_",
		"/images/mobilefirst/main/cate/aos/home_category_menu02_",
		"/images/mobilefirst/main/cate/aos/home_category_menu03_",
		"/images/mobilefirst/main/cate/aos/home_category_menu04_",
		"/images/mobilefirst/main/cate/aos/home_category_menu05_",
		"/images/mobilefirst/main/cate/aos/home_category_menu06_",
		"/images/mobilefirst/main/cate/aos/home_category_menu07_",
		"/images/mobilefirst/main/cate/aos/home_category_menu08_",

		//"/images/mobilefirst/main/cate/aos/home_category_menu_social_",
		"/images/mobilefirst/main/cate/aos/home_category_pick_",
		"/images/mobilefirst/main/cate/aos/home_category_menu_knowshopping2_" };

		String cateBarImageios[] = { "/images/mobilefirst/main/cate/ios/2019/iconMainCate01",
		"/images/mobilefirst/main/cate/ios/2019/iconMainCate02",
		"/images/mobilefirst/main/cate/ios/2019/iconMainCate03",
		"/images/mobilefirst/main/cate/ios/2019/iconMainCate04",
		"/images/mobilefirst/main/cate/ios/2019/iconMainCate06",
		"/images/mobilefirst/main/cate/ios/2019/iconMainCate05",
		"/images/mobilefirst/main/cate/ios/2019/iconMainCate07",
		"/images/mobilefirst/main/cate/ios/2019/iconMainCate08",

		//"/images/mobilefirst/main/cate/ios/2019/iconMainCate09",
		"/images/mobilefirst/main/cate/ios/2019/iconMainCatePick",
		"/images/mobilefirst/main/cate/ios/2019/iconMainCate10" };
		/**
		카테고리 이미지 변경  주소 구분
		파랑색 그라데이션 개편 전 appMainMake.jsp catebar339
		Android
		 - > /images/mobilefirst/main/cate/aos/home_category_menu00_v338_xhdpi.png
		 - > /images/mobilefirst/main/cate/aos/home_category_menu00_v338_xxhdpi.png
		iOS		 
		 - > /images/mobilefirst/main/cate/ios/home_category_menu00_v338@3x.png
		 
		파랑색 그라데이션 개편 후 appMainMake_2019.jsp catebar350
		Android
		 - > /images/mobilefirst/main/cate/aos/home_category_menu00_v350_xhdpi.png
		 - > /images/mobilefirst/main/cate/aos/home_category_menu00_v350_xxhdpi.png
		iOS		 
		 - > /images/mobilefirst/main/cate/ios/2019/iconMainCate00@3x.png		
		*/
		String cateBarUrl[] = { "http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=1",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=2",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=3",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=4",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=5",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=6",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=7",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=8",
		//"http://"+server+".enuri.com/deal/newdeal/index.deal?freetoken=social",
		"http://" + server + ".enuri.com/m/pickMain.jsp?freetoken=event",
		"http://" + server + ".enuri.com/knowcom/index.jsp?freetoken=shoppingknow" };

		for (int i = 0; i < 10; i++) {
	JSONObject obj = new JSONObject();
	obj.put("title", cateBarTitle[i]);
	obj.put("url", cateBarUrl[i]);//3.3.6 부터는 9인덱스 url은 무시하자 9일때 소스에 있는걸로 쓴다 
	obj.put("image_aos", cateBarImageaos[i]);
	obj.put("image_ios", cateBarImageios[i]);
	cateBarJsonArr350.put(obj);
		}
		makeJson.put("catebar350", cateBarJsonArr350);
		makeJson.put("catebar_preurl", "http://img.enuri.info");
	}

	/**
	카테고리 3.7.4 //20210108
	 */
	JSONArray cateBarJsonArr374 = new JSONArray();
	{
		String cateBarTitle[] = { "가전", "TV/영상/디카", "컴퓨터/노트북", "태블릿/모바일", "스포츠/자동차", "유아/식품", "가구/생활", "패션/화장품", "PICK",
		"쇼핑지식" };
		String cateBarImageaos[] = { "/images/mobilefirst/main/cate/aos/home_category_menu01_",
		"/images/mobilefirst/main/cate/aos/home_category_menu02_",
		"/images/mobilefirst/main/cate/aos/home_category_menu03_",
		"/images/mobilefirst/main/cate/aos/home_category_menu04_",
		"/images/mobilefirst/main/cate/aos/home_category_menu05_",
		"/images/mobilefirst/main/cate/aos/home_category_menu06_",
		"/images/mobilefirst/main/cate/aos/home_category_menu07_",
		"/images/mobilefirst/main/cate/aos/home_category_menu08_",
		"/images/mobilefirst/main/cate/aos/home_category_pick_",
		"/images/mobilefirst/main/cate/aos/home_category_menu_knowshopping2_" };

		String cateBarImageios[] = { "/images/mobilefirst/main/cate/ios/2019/iconMainCate01",
		"/images/mobilefirst/main/cate/ios/2019/iconMainCate02",
		"/images/mobilefirst/main/cate/ios/2019/iconMainCate03",
		"/images/mobilefirst/main/cate/ios/2019/iconMainCate04",
		"/images/mobilefirst/main/cate/ios/2019/iconMainCate06",
		"/images/mobilefirst/main/cate/ios/2019/iconMainCate05",
		"/images/mobilefirst/main/cate/ios/2019/iconMainCate07",
		"/images/mobilefirst/main/cate/ios/2019/iconMainCate08",
		"/images/mobilefirst/main/cate/ios/2019/iconMainCatePick",
		"/images/mobilefirst/main/cate/ios/2019/iconMainCate10" };

		String cateBarUrl[] = { "http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=1",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=2",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=3",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=4",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=5",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=6",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=7",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=8",
		"http://" + server + ".enuri.com/m/pickMain.jsp?freetoken=main_tab|pick",
		"http://" + server + ".enuri.com/knowcom/index.jsp?freetoken=shoppingknow" };

		for (int i = 0; i < 10; i++) {
	JSONObject obj = new JSONObject();
	obj.put("title", cateBarTitle[i]);
	obj.put("url", cateBarUrl[i]);//3.3.6 부터는 9인덱스 url은 무시하자 9일때 소스에 있는걸로 쓴다 
	obj.put("image_aos", cateBarImageaos[i]);
	obj.put("image_ios", cateBarImageios[i]);
	cateBarJsonArr374.put(obj);
		}
		makeJson.put("catebar374", cateBarJsonArr374);
		makeJson.put("catebar_preurl", "http://img.enuri.info");
	}

	/**
	카테고리 안드로이드 기준 3.9.2 
	 */
	JSONArray cateBarJsonArr390 = new JSONArray();
	{
		String cateBarTitle[] = { "생활가전", "계절가전", "TV/영상/디카 ", "컴퓨터/노트북", "태블릿/모바일", "식품/유아/완구", "스포츠/자동차", "가구/문구",
		"명품/패션/뷰티", "건강/생활/동물" };

		String cateBarImageaos[] = { "/images/mobilefirst/main/cate/aos/20220308/icon_main_cate_01_",
		"/images/mobilefirst/main/cate/aos/20220308/icon_main_cate_02_",
		"/images/mobilefirst/main/cate/aos/20220308/icon_main_cate_03_",
		"/images/mobilefirst/main/cate/aos/20220308/icon_main_cate_04_",
		"/images/mobilefirst/main/cate/aos/20220308/icon_main_cate_05_",
		"/images/mobilefirst/main/cate/aos/20220308/icon_main_cate_06_",
		"/images/mobilefirst/main/cate/aos/20220308/icon_main_cate_07_",
		"/images/mobilefirst/main/cate/aos/20220308/icon_main_cate_08_",
		"/images/mobilefirst/main/cate/aos/20220308/icon_main_cate_09_",
		"/images/mobilefirst/main/cate/aos/20220308/icon_main_cate_10_", };

		String cateBarImageios[] = { "/images/mobilefirst/main/cate/ios/20220308/icon_main_cate01",
		"/images/mobilefirst/main/cate/ios/20220308/icon_main_cate02",
		"/images/mobilefirst/main/cate/ios/20220308/icon_main_cate03",
		"/images/mobilefirst/main/cate/ios/20220308/icon_main_cate04",
		"/images/mobilefirst/main/cate/ios/20220308/icon_main_cate05",
		"/images/mobilefirst/main/cate/ios/20220308/icon_main_cate06",
		"/images/mobilefirst/main/cate/ios/20220308/icon_main_cate07",
		"/images/mobilefirst/main/cate/ios/20220308/icon_main_cate08",
		"/images/mobilefirst/main/cate/ios/20220308/icon_main_cate09",
		"/images/mobilefirst/main/cate/ios/20220308/icon_main_cate10" };

		String cateBarUrl[] = { "http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=1&scate=0",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=1&scate=2",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=2",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=3",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=4",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=6",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=5",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=7",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=8",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=7&scate=1", };

		for (int i = 0; i < 10; i++) {
	JSONObject obj = new JSONObject();
	obj.put("title", cateBarTitle[i]);
	obj.put("url", cateBarUrl[i]);//3.3.6 부터는 9인덱스 url은 무시하자 9일때 소스에 있는걸로 쓴다 
	obj.put("image_aos", cateBarImageaos[i]);
	obj.put("image_ios", cateBarImageios[i]);
	cateBarJsonArr390.put(obj);
		}
		makeJson.put("catebar392", cateBarJsonArr390);
		makeJson.put("catebar_preurl", "http://img.enuri.info");
	}

	/**
	카테고리 안드로이드 기준 4.0.1 
	 */
	JSONArray cateBarJsonArr401 = new JSONArray();
	{
		String cateBarTitle4[] = { "생활\n가전", "계절\n주방가전", "TV\n영상·디카 ", "컴퓨터\n노트북", "태블릿\n모바일", "식품\n유아·완구", "스포츠·골프\n자동차·공구", "가구·문구\n인테리어",
		"명품·패션\n화장품", "건강·생활\n반려동물" };

		String cateBarImageaos4[] = { "/images/mobilefirst/main/cate/aos/20220308/icon_main_cate_01_",
		"/images/mobilefirst/main/cate/aos/20220308/icon_main_cate_02_",
		"/images/mobilefirst/main/cate/aos/20220308/icon_main_cate_03_",
		"/images/mobilefirst/main/cate/aos/20220308/icon_main_cate_04_",
		"/images/mobilefirst/main/cate/aos/20220308/icon_main_cate_05_",
		"/images/mobilefirst/main/cate/aos/20220308/icon_main_cate_06_",
		"/images/mobilefirst/main/cate/aos/20220308/icon_main_cate_07_",
		"/images/mobilefirst/main/cate/aos/20220308/icon_main_cate_08_",
		"/images/mobilefirst/main/cate/aos/20220308/icon_main_cate_09_",
		"/images/mobilefirst/main/cate/aos/20220308/icon_main_cate_10_", };

		String cateBarImageios4[] = { "/images/mobilefirst/main/cate/ios/20220308/icon_main_cate01",
		"/images/mobilefirst/main/cate/ios/20220308/icon_main_cate02",
		"/images/mobilefirst/main/cate/ios/20220308/icon_main_cate03",
		"/images/mobilefirst/main/cate/ios/20220308/icon_main_cate04",
		"/images/mobilefirst/main/cate/ios/20220308/icon_main_cate05",
		"/images/mobilefirst/main/cate/ios/20220308/icon_main_cate06",
		"/images/mobilefirst/main/cate/ios/20220308/icon_main_cate07",
		"/images/mobilefirst/main/cate/ios/20220308/icon_main_cate08",
		"/images/mobilefirst/main/cate/ios/20220308/icon_main_cate09",
		"/images/mobilefirst/main/cate/ios/20220308/icon_main_cate10" };

		String cateBarUrl4[] = { "http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=1&scate=0",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=1&scate=2",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=2",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=3",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=4",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=6",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=5",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=7",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=8",
		"http://" + server + ".enuri.com/mobilefirst/cpp.jsp?gcate=7&scate=2", };

		for (int i = 0; i < 10; i++) {
			JSONObject obj = new JSONObject();
			obj.put("title", cateBarTitle4[i]);
			obj.put("url", cateBarUrl4[i]);
			obj.put("image_aos", cateBarImageaos4[i]);
			obj.put("image_ios", cateBarImageios4[i]);
			cateBarJsonArr401.put(obj);
		}
		makeJson.put("catebar401", cateBarJsonArr401);
		makeJson.put("catebar_preurl", "http://img.enuri.info");
	}
	
	   /**
		* 카테고리 4.0.4 부터 여기서 새로 파서 쓰게 처리
		관리포인트 하나로 하기위해서~ 이제 여기만 수정하면 됨
		**/
	   try{
		   String callURL = "http://localhost/m/api/app/appMainDDCategory.jsp?ver=4.0.4&referer=home";
		   makeJson.put("main_catebar_url", callURL);
		   JSONArray categorys = getJSONArrayfromHttp(callURL);
		   makeJson.put("main_catebar", categorys);
	   }catch(Exception e){
		   
	   }
	   
	   /**
		* 카테고리 4.1.1 이상데이터 (통합카테고리관리자호출)
		**/
	   try{
		   String callURL = "http://localhost/m/include/m_Ht_Cate_real.json";
	       if(isDev){
	    	   callURL = "http://localhost/m/include/m_Ht_Cate_dev.json";
	       }
		   
		   makeJson.put("main_catebar_url", callURL);
		   JSONArray categorys = getJSONArrayfromHttp(callURL);
		   JSONArray reCates = new JSONArray();
		   for( int i =0; i < categorys.length(); i++){
			   JSONObject cate = categorys.optJSONObject(i);
			   JSONObject reCate =new JSONObject();
			   if(cate != null && cate.has("view_cate_nm")) {
				   reCate.put("title",cate.optString("view_cate_nm"));
				   reCate.put("randing_url",cate.optString("page_url") + "&freetoken=cpp");
				   reCate.put("img_url",cate.optString("icn_img_url"));
				   reCates.put(reCate);
			   }
		   }
		   makeJson.put("main_catebar411", reCates);
	   }catch(Exception e){
		   
	   }
	   
	//퍼스널 배너
	JSONObject personalBanner = new JSONObject();
	personalBanner.put("color", "#52a2f9");
	personalBanner.put("txt", "<font color='#f1ff2c'>e클럽 가입</font><font color='#ffffff'>하고 e머니 받으세요!</font>");
	personalBanner.put("url", "http://m.enuri.com/m/index.jsp?freetoken=main_tab|myeclub");
	makeJson.put("personalBanner", personalBanner);
	
	if (isCrazyDealUseable) {
		JSONObject deallistHeader = new JSONObject();
		{
	//크레이지딜 타이틀 더보기 링크
	deallistHeader.put("linkurl",
	"http://" + server + ".enuri.com/mobilefirst/evt/mobile_deal.jsp?freetoken=event");
	makeJson.put("mobile_deal_list_header", deallistHeader);
		}
	}

	JSONObject personalSetJson = new JSONObject();
	{
		JSONArray personalSetJsonArr = new JSONArray();
		String personalTitle[] = { "영상/디지털", "가전", "컴퓨터", "스포츠 용품", "자동차 용품", "유아용품/완구", "가구", "패션/화장품", "식품",
		"생활용품/도서" };
		String personalCode[] = { "02;24;03", "05;06", "04;07", "09", "21", "10", "12", "14;08", "15", "16;93;18" };
		for (int i = 0; i < personalTitle.length; i++) {
	JSONObject obj = new JSONObject();
	obj.put("title", personalTitle[i]);
	obj.put("code", personalCode[i]);
	personalSetJsonArr.put(obj);
		}
		personalSetJson.put("data", personalSetJsonArr);

		personalSetJson.put("man", "02;24;05;06;04;07;21");
		personalSetJson.put("woman", "10;12;14;08");
		personalSetJson.put("all", "09");
		makeJson.put("setpersonal", personalSetJson);
	}
	/**
	이벤트 바
	 */
	JSONArray eventBarJsonArr = new JSONArray();
	{

		String eventBarTitle[] = { "출석체크", "WELCOME", "구매혜택", "VIP", "이벤트" };
		String eventBariOS[] = { "Y", "Y", "Y", "Y", "Y" };
		String eventBarAos[] = { "Y", "Y", "Y", "Y", "Y" };

		String UNIQUE_EVETN_URL = "";
		//2020100500시 부터 100원딜 삭제됨
		if (isTimeUnder(2020100500)) {
	UNIQUE_EVETN_URL = "http://" + server + ".enuri.com/mobilefirst/evt/firstbuy_event.jsp?freetoken=event";
		} else {
	UNIQUE_EVETN_URL = "http://" + server + ".enuri.com/mobilefirst/evt/welcome_event.jsp?freetoken=event";
		}

		String eventBarUrl[] = { "http://" + server + ".enuri.com/mobilefirst/evt/visit_event.jsp?freetoken=event",
		UNIQUE_EVETN_URL, "http://" + server + ".enuri.com/mobilefirst/evt/smart_benefits.jsp?freetoken=event",
		"http://" + server + ".enuri.com/mobilefirst/evt/buy_event.jsp?tab=1&freetoken=event",
		"http://" + server + ".enuri.com/mobilefirst/plan_event.jsp?freetoken=main_tab|event" };
		String eventBarImageaos[] = { "/images/mobilefirst/main/eventbar/aos/20190523/home_event_menu01",
		"/images/mobilefirst/main/eventbar/aos/2020081801/home_event_menu02",
		"/images/mobilefirst/main/eventbar/aos/20190523/home_event_menu09",
		"/images/mobilefirst/main/eventbar/aos/20190523/home_event_menu10",
		"/images/mobilefirst/main/eventbar/aos/20190523/home_event_menu05" };
		String eventBarImageios[] = { "/images/mobilefirst/main/eventbar/ios/20190523/iconMainBen01",
		"/images/mobilefirst/main/eventbar/ios/20200818/iconMainBen02",
		"/images/mobilefirst/main/eventbar/ios/20190523/iconMainBen03",
		"/images/mobilefirst/main/eventbar/ios/20190523/iconMainBen04",
		"/images/mobilefirst/main/eventbar/ios/20190523/iconMainBen05" };

		for (int i = 0; i < eventBarTitle.length; i++) {
	JSONObject obj = new JSONObject();
	obj.put("title", eventBarTitle[i]);
	obj.put("url", eventBarUrl[i]);
	obj.put("image_aos", eventBarImageaos[i]);
	obj.put("image_ios", eventBarImageios[i]);
	obj.put("iOS", eventBariOS[i]);
	obj.put("And", eventBarAos[i]);
	eventBarJsonArr.put(obj);
		}
		makeJson.put("eventbar", eventBarJsonArr);
		makeJson.put("eventbar_preurl", "http://img.enuri.info");
	}

	JSONArray eventBarJsonArr392 = new JSONArray();
	{
		
		String eventBarTitle[] = { "출석체크", "WELCOME", "구매혜택", "VIP", "e클럽혜택" };
		String eventBariOS[] = { "Y", "Y", "Y", "Y", "Y" };
		String eventBarAos[] = { "Y", "Y", "Y", "Y", "Y" };

		String UNIQUE_EVETN_URL = "";

		String eventBarUrl[] = { "http://" + server + ".enuri.com/mobilefirst/evt/visit_event.jsp?freetoken=event",
				"http://" + server + ".enuri.com/mobilefirst/evt/welcome_event.jsp?freetoken=event",
				"http://" + server + ".enuri.com/mobilefirst/evt/smart_benefits.jsp?freetoken=event",
		        "http://" + server + ".enuri.com/mobilefirst/evt/buy_event.jsp?tab=1&freetoken=event",
		        "http://m.enuri.com/mobiledepart/Index.jsp?freetoken=main_tab|myeclub" };

		String eventBarImageaos[] = { "/images/mobilefirst/main/eventbar/aos/20220310/icon_main_ben_01",
		"/images/mobilefirst/main/eventbar/aos/20220310/icon_main_ben_02",
		"/images/mobilefirst/main/eventbar/aos/20220310/icon_main_ben_03",
		"/images/mobilefirst/main/eventbar/aos/20220310/icon_main_ben_04",
		"/images/mobilefirst/main/eventbar/aos/20220310/icon_main_ben_05" };

		String eventBarImageios[] = { "/images/mobilefirst/main/eventbar/ios/20220302/icon_main_ben01",
		"/images/mobilefirst/main/eventbar/ios/20220302/icon_main_ben02",
		"/images/mobilefirst/main/eventbar/ios/20220302/icon_main_ben03",
		"/images/mobilefirst/main/eventbar/ios/20220302/icon_main_ben04",
		"/images/mobilefirst/main/eventbar/ios/20220302/icon_main_ben05" };

		for (int i = 0; i < eventBarTitle.length; i++) {
	JSONObject obj = new JSONObject();
	obj.put("title", eventBarTitle[i]);
	obj.put("url", eventBarUrl[i]);
	obj.put("image_aos", eventBarImageaos[i]);
	obj.put("image_ios", eventBarImageios[i]);
	obj.put("iOS", eventBariOS[i]);
	obj.put("And", eventBarAos[i]);
	eventBarJsonArr392.put(obj);
		}
		makeJson.put("eventbar392", eventBarJsonArr392);
		makeJson.put("eventbar_preurl", "http://img.enuri.info");
	}

	JSONArray shopbestArr = new JSONArray();
	{
		String[] codes = { "536", "5910", "4027", "6508", "7861" };
		JSONArray allsite = getJSONArrayfromFile(
		"/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/http/json/shopMainLogo.json");
		for (int i = 0; i < codes.length; i++) {
	for (int j = 0; j < allsite.length(); j++) {
		JSONObject shoplogoO = allsite.getJSONObject(j);

		if (codes[i].equals(shoplogoO.optString("shop"))) {
			JSONObject site = new JSONObject();
			try {
				site.put("code", codes[i]);
				site.put("url", "http://" + server + ".enuri.com/mobilefirst/move2.jsp?vcode=" + codes[i]
						+ "&freetoken=outlink&url=" + URLEncoder.encode(shoplogoO.optString("move"), "UTF-8"));
				site.put("img_v350", shoplogoO.optString("main_shopbest_img"));
				site.put("mall", shoplogoO.optString("name"));
				shopbestArr.put(site);
			} catch (Exception e) {
			}
		}
	}
		}
		makeJson.put("shopbest", shopbestArr);
		makeJson.put("shopbest_preurl", "http://img.enuri.info/images/mobilefirst/publicmall");

	}
	/**
	푸터쪽 인기쇼핑몰
	 */
	JSONObject footerJson = new JSONObject();
	{

		JSONArray sites = new JSONArray();

		JSONArray allsite = getJSONArrayfromFile(
		"/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/http/json/shopMainLogo.json");
		String[] codes = { "536", "4027", "5910", "55", "6665", "49", "57", "90", "75", "806", "663", "6588", "6508",
		"6641", "7861", "7692", "6547", "9011", "974", "7935" };
		String[] mall = new String[codes.length];
		String[] urls = new String[codes.length];
		String[] img = new String[codes.length];
		try {
	for (int i = 0; i < codes.length; i++) {
		for (int j = 0; j < allsite.length(); j++) {
			JSONObject shoplogoO = allsite.getJSONObject(j);

			if (codes[i].equals(shoplogoO.optString("shop"))) {
				mall[i] = shoplogoO.optString("name");
				urls[i] = "http://" + server + ".enuri.com/mobilefirst/move2.jsp?vcode=" + codes[i]
						+ "&freetoken=outlink&url=" + URLEncoder.encode(shoplogoO.optString("move"), "UTF-8");
				img[i] = shoplogoO.optString("img_g");
				break;
			}

		}
	}
		} catch (Exception e) {
	//footerJson.put("exception SITE2",e.getLocalizedMessage());
		}

		for (int i = 0; i < codes.length; i++) {
	JSONObject site = new JSONObject();
	try {
		site.put("site", mall[i]);
		site.put("code", codes[i]);
		site.put("url", urls[i]);
		site.put("img", img[i]);
		/*	
			site.put("img", "/20190417/20190417_logo_" + codes[i] + ".png");
		*/
		sites.put(site);
	} catch (Exception e) {

		//site.put("exception",e.getLocalizedMessage());
	}
		}
		try {

	footerJson.put("SITE", sites);

		} catch (Exception e) {
	//footerJson.put("exception SITE",e.getLocalizedMessage());

		}

		JSONObject objFoot = getJSONObjectfromHttp("http://localhost/mobilefirst/http/json/footer.json");

		try {
	footerJson.put("APPSTORE_TITLE", objFoot.get("APPSTORE_TITLE"));
	footerJson.put("APPSTORE_IOS", objFoot.get("APPSTORE_IOS"));
	footerJson.put("APPSTORE_AND", objFoot.get("APPSTORE_AND"));
	footerJson.put("IMAGE_PREURL", objFoot.get("IMAGE_PREURL"));
		} catch (Exception e) {
		}

		makeJson.put("footer", footerJson);
		makeJson.put("footersite_preurl", "http://img.enuri.info/images/mobilefirst/publicmall");
	}

	try {

		JSONObject[] dealSaveList = new JSONObject[6];
		String[] strDeals = { "superDeal", "allKill", "shocking", "tmon", "wemake", "ssenDeal" };
		int[] randomIndex = { 0, 1, 2, 3, 4, 5 };
		int[] overrandomIndex = { 0, 1, 2 };
		int maxsize = randomIndex.length;
		for (int i = 0; i < randomIndex.length; i++) {
	JSONObject obj = getJSONObjectfromHttp("http://localhost/mobilefirst/http/json/" + strDeals[i] + ".json");
	if (obj == null)
		throw new Exception("nullData " + strDeals[i] + ".json");
	dealSaveList[i] = obj;
		}

		for (int j = 0; j < maxsize; j++) {
	int random;
	random = new Random().nextInt(maxsize);
	int temp = randomIndex[random];
	randomIndex[random] = randomIndex[j];
	randomIndex[j] = temp;
		}

		Mobile_GoodsToPricelist_Proc mgp = new Mobile_GoodsToPricelist_Proc();
		ArrayList al = new ArrayList();

		if (mgp == null)
	throw new Exception("Mobile_GoodsToPricelist_Proc null data");

		al = mgp.getPlno();

		String strPlnos = "";
		for (int j = 0; j < al.size(); j++) {
	if (strPlnos != "") {
		strPlnos += ",";
	}
	strPlnos += al.get(j);
		}
		if (strPlnos.length() > 0)
	strPlnos = "," + strPlnos + ",";
		//out.println(strPlnos);
		maxsize = randomIndex.length;
		JSONArray dealList = new JSONArray();
		int cnt = 0, subcnt = 0;

		for (int i = 0; i < 200; i++) {
	try {
		JSONArray arr = (JSONArray) dealSaveList[randomIndex[cnt]].get("goodsList");
		if (arr != null && arr.length() > subcnt) {
			JSONObject cellObj = (JSONObject) arr.get(subcnt);
			if (strPlnos.indexOf("," + cellObj.get("pl_no") + ",") < 0) {

				String imgType = (String) dealSaveList[randomIndex[cnt]].get("imgtype");
				int shopCode = Integer.parseInt((String) dealSaveList[randomIndex[cnt]].getString("shopCode"));

				if (!cellObj.has("imgtype")) {
					if (imgType == null)//iOS에서 문제 발생 1이면 큰이미지 2이면 정사각형 이미지 쓴다
						cellObj.put("imgtype", "2");
					else
						cellObj.put("imgtype", imgType);
				}

				if (!cellObj.has("shopCode"))
					cellObj.put("shopCode", shopCode);

				dealList.put(cellObj);
				if (dealList.length() >= 120)
					break;
			}
		}
	} catch (Exception e) {
		makeJson.put("exception3", e.toString());
	}
	cnt++;
	if (cnt >= maxsize) {
		cnt = 0;
		subcnt++;

		for (int j = 0; j < maxsize; j++) {
			int random;
			random = new Random().nextInt(maxsize);
			int temp = randomIndex[random];
			randomIndex[random] = randomIndex[j];
			randomIndex[j] = temp;
		}

	}
		}
		subcnt++;
		cnt = 0;
		//위에는 120개를 원래 모든 마트 렌덤으로 가져 옴
		//슈퍼딜,쇼킹딜,옥션 추가 20개씩 총 60개 더 추가 
		maxsize = overrandomIndex.length;

		for (int i = 0; i < 100; i++) {
	try {
		JSONArray arr = (JSONArray) dealSaveList[overrandomIndex[cnt]].get("goodsList");
		if (arr != null && arr.length() > subcnt) {
			JSONObject cellObj = (JSONObject) arr.get(subcnt);
			if (strPlnos.indexOf("," + cellObj.get("pl_no") + ",") < 0) {

				String imgType = (String) dealSaveList[overrandomIndex[cnt]].get("imgtype");
				//int shopCode = ((Long) dealSaveList[overrandomIndex[cnt]].get("shopCode")).intValue();
				int shopCode = Integer
						.parseInt((String) dealSaveList[overrandomIndex[cnt]].getString("shopCode"));
				if (!cellObj.has("imgtype")) {
					if (imgType == null)//iOS에서 문제 발생
						cellObj.put("imgtype", "2");
					else
						cellObj.put("imgtype", imgType);
				}
				if (!cellObj.has("shopCode"))
					cellObj.put("shopCode", shopCode);
				dealList.put(cellObj);
				if (dealList.length() >= 180)
					break;
			}
		}
	} catch (Exception e) {
		makeJson.put("exception33", e.toString());
	}
	cnt++;
	if (cnt >= maxsize) {
		cnt = 0;
		subcnt++;

		for (int j = 0; j < maxsize; j++) {
			int random;
			random = new Random().nextInt(maxsize);
			int temp = overrandomIndex[random];
			overrandomIndex[random] = overrandomIndex[j];
			overrandomIndex[j] = temp;
		}

	}
		}

		if (dealList.length() < 50) {

	makeJson.put("mainBest.json",
			getJSONObjectfromHttp("http://localhost/mobilefirst/http/json/mainBest.json"));
	makeJson.put("mainCompare.json",
			getJSONObjectfromHttp("http://localhost/mobilefirst/http/json/mainCompare.json"));

		} else
	makeJson.put("main_deal", dealList);
		makeJson.put("main_deal_cnt", dealList.length());
	} catch (Exception e) {
		//out.println(e.toString());
		makeJson.put("exception1", e.toString());
	}

	if (!makeJson.has("main_deal")) {
		if (!makeJson.has("mainBest.json"))
	makeJson.put("mainBest.json",
			getJSONObjectfromHttp("http://localhost/mobilefirst/http/json/mainBest.json"));

		if (!makeJson.has("mainCompare.json"))
	makeJson.put("mainCompare.json",
			getJSONObjectfromHttp("http://localhost/mobilefirst/http/json/mainCompare.json"));

	}
	//20190312 트랜드픽업 json..
	if (!makeJson.has("m_trendJson.json")) {
		makeJson.put("m_trendJson.json",
		getJSONObjectfromHttp("http://localhost/main/main2018/ajax/m_trendJson_new.json"));
	}
	if (!makeJson.has("m_trendJson_2022.json")) {
		makeJson.put("m_trendJson_2022.json",
		getJSONObjectfromHttp("http://localhost/m/api/main/m_trendJson_2022.json"));
	}
	//20190312 쇼핑지식 all
	if (!makeJson.has("newsAdmin.json")) {
		makeJson.put("newsAdmin.json", getJSONObjectfromHttp("http://localhost/m/api/main/getMainKnowcom.json"));
	}
	//20190415 홈 카드형 광고
	makeJson.put("homeCardAd", getJSONArrayfromHttp("http://ad-api.enuri.info/enuri_M/m_main/D1/bundle?bundlenum=42"));

	makeJson.put("shopMainLogo.json", getJSONArrayfromHttp("http://localhost/mobilefirst/http/json/shopMainLogo.json"));

	//20190923 해외쇼핑몰 리스트
	JSONObject obj = new JSONObject();
	obj.put("title", "해외직구 가격비교");
	obj.put("link", "http://" + server + ".enuri.com/global/m/Index.jsp?freetoken=global");
	makeJson.put("mallree_mall_header", obj);
	makeJson.put("mallree_mall_bridge", "http://" + server + ".enuri.com/global/m/mvp.jsp?freetoken=global");
	makeJson.put("mallree_mall_list",
	getJSONArrayfromHttp("http://localhost/global/ajax/getGlobalPopShop_ajax.jsp?view_pst_cd=C"));
	makeJson.put("mallree_goods", getJSONArrayfromHttp("http://localhost/global/ajax/getDetailShoplist_ajax.jsp"));

	try {

		JSONObject carObj = new JSONObject();
		carObj.put("title", "프리미엄 중고차");
		carObj.put("link", "http://" + server + ".enuri.com/enuricar/m/list.jsp?freetoken=reborncar");
		//carObj.put("list",getJSONObjectfromHttp("http://localhost/m/api/main/getAppCarSearch_ajax.jsp"));
		carObj.put("listAll", getJSONObjectfromHttp(
		"http://localhost/lsv2016/ajax/getCarSearch_ajax.jsp?pageNum=1&pageGap=10&sort=1"));
		carObj.put("list", getJSONObjectfromHttp("http://localhost/main/main2018/ajax/mainCarData.json"));
		carObj.put("freetoken", "freetoken=outbrowser");
		carObj.put("bridge",
		"http://" + (isDev ? "dev" : "m") + ".enuri.com/move/Redirect_resellcar.jsp?gd_cd=%s&url=%s");
		JSONObject banner = new JSONObject();
		JSONArray arr = getJSONArrayfromHttp("http://ad-api.enuri.info/enuri_M/m_main/MR1/bundle?bundlenum=10");
		if (arr != null && arr.length() > 0) {
	try {
		JSONObject bannerJson = arr.getJSONObject(0);
		banner.put("link", bannerJson.getString("JURL1"));
		banner.put("img", bannerJson.getString("IMG1"));
	} catch (Exception e) {
		banner.put("link", "http://" + server + ".enuri.com/enuricar/m/list.jsp?freetoken=reborncar");
		banner.put("img", "http://storage.enuri.info/car/appbanner/app_bnr_reborn_main_20200326.png");
	}
		} else {
	banner.put("link", "http://" + server + ".enuri.com/enuricar/m/list.jsp?freetoken=reborncar");
	banner.put("img", "http://storage.enuri.info/car/appbanner/app_bnr_reborn_main_20200326.png");
		}

		carObj.put("ad", banner);
		makeJson.put("reborn_car", carObj);
	} catch (Exception e) {

	}

	try {
		
		JSONObject carObj = new JSONObject();
		carObj.put("title", "자동차");
    	carObj.put("link","http://auto.enuri.com/m/car?freetoken=reborncar");    	
    	//carObj.put("list",getJSONObjectfromHttp("http://localhost/m/api/main/getAppCarSearch_ajax.jsp"));
    	carObj.put("listAll",getJSONObjectfromHttp("http://localhost/main/main2018/ajax/getCarMainList.json"));
       
    	carObj.put("freetoken","freetoken=reborncar");
    	carObj.put("bridge","http://auto.enuri.com/m/vip?model=%s");
    	JSONObject banner = new JSONObject();    	
    	JSONArray arr = getJSONArrayfromHttp("http://ad-api.enuri.info/enuri_M/m_main/MR1/bundle?bundlenum=10");    			

		if (arr != null && arr.length() > 0) {
	try {
		JSONObject bannerJson = arr.getJSONObject(0);
		banner.put("link", bannerJson.getString("JURL1"));
		banner.put("img", bannerJson.getString("IMG1"));
	} catch (Exception e) {
		banner.put("link", "http://" + server + ".enuri.com/enuricar/m/list.jsp?freetoken=reborncar");
		banner.put("img", "http://storage.enuri.info/car/appbanner/app_bnr_reborn_main_20200326.png");
	}
		} else {
	banner.put("link", "http://" + server + ".enuri.com/enuricar/m/list.jsp?freetoken=reborncar");
	banner.put("img", "http://storage.enuri.info/car/appbanner/app_bnr_reborn_main_20200326.png");
		}

		carObj.put("ad", banner);
		makeJson.put("new_car", carObj);
	} catch (Exception e) {

	}

} catch (Exception e) {
	makeJson.put("exception2", e.toString());
}
if (makeJson != null)
	out.println(makeJson.toString());
%>
<%!public JSONArray getJSONArrayfromFile(String filePath) {

		String news_data = "";
		InputStream inputStream = null;
		ByteArrayOutputStream outputStream = null;
		byte[] arBytes = null;
		try {
			inputStream = new FileInputStream(filePath);

			outputStream = new ByteArrayOutputStream();

			byte[] readByte = new byte[1024];
			int readLen;
			while ((readLen = inputStream.read(readByte)) != -1) {
				outputStream.write(readByte, 0, readLen);
			}
			arBytes = outputStream.toByteArray();

		} catch (Exception e) {

		} finally {
			try {
				if (outputStream != null)
					outputStream.close();
			} catch (Exception e) {

			}
			try {
				if (inputStream != null)
					inputStream.close();
			} catch (Exception e) {

			}

		}
		if (arBytes != null) {
			try {
				return new JSONArray(new String(arBytes, "utf-8"));
			} catch (Exception e) {

			}
		}
		return null;
	}

	public JSONArray getJSONArrayfromFileDeal(String filePath) {

		InputStream inputStream = null;
		ByteArrayOutputStream outputStream = null;
		byte[] arBytes = null;
		try {
			inputStream = new FileInputStream(filePath);

			outputStream = new ByteArrayOutputStream();

			byte[] readByte = new byte[1024];
			int readLen;
			while ((readLen = inputStream.read(readByte)) != -1) {
				outputStream.write(readByte, 0, readLen);
			}
			arBytes = outputStream.toByteArray();

		} catch (Exception e) {

		} finally {
			try {
				if (outputStream != null)
					outputStream.close();
			} catch (Exception e) {

			}
			try {
				if (inputStream != null)
					inputStream.close();
			} catch (Exception e) {

			}

		}

		if (arBytes != null) {
			try {

				JSONArray json = new JSONArray(new String(arBytes, "utf-8"));
				JSONArray returnarr = new JSONArray();
				for (int i = 0; i < json.length(); i++) {

					JSONObject object = (JSONObject) json.get(i);
					String b = (String) object.get("GOODS_EXPO_FLAG");
					if (b.equals("Y")) {
						returnarr.put(json.get(i));
					}
				}

				return returnarr;
			} catch (Exception e) {

			}
		}

		return null;
	}

	public JSONArray getJSONArrayfromFile(String filePath, String strMax, String title) {
		String news_data = "";
		InputStream inputStream = null;
		ByteArrayOutputStream outputStream = null;
		byte[] arBytes = null;
		int max = Integer.parseInt(strMax);
		try {

			inputStream = new FileInputStream(filePath);

			outputStream = new ByteArrayOutputStream();

			byte[] readByte = new byte[1024];
			int readLen;
			while ((readLen = inputStream.read(readByte)) != -1) {
				outputStream.write(readByte, 0, readLen);
			}
			arBytes = outputStream.toByteArray();

		} catch (Exception e) {

		} finally {
			try {
				if (outputStream != null)
					outputStream.close();
			} catch (Exception e) {

			}
			try {
				if (inputStream != null)
					inputStream.close();
			} catch (Exception e) {

			}
		}

		if (arBytes != null) {
			try {
				JSONObject json = new JSONObject(new String(arBytes, "utf-8"));
				JSONArray arr = (JSONArray) json.get(title);

				JSONArray returnarr = new JSONArray();
				for (int i = 0; i < arr.length() && i < max; i++) {
					returnarr.put(arr.get(i));
				}

				return returnarr;
			} catch (Exception e) {

			}
		}
		return null;
	}

	public JSONObject getJSONObjectfromFile(String filePath) {

		String news_data = "";

		InputStream inputStream = null;
		ByteArrayOutputStream outputStream = null;
		byte[] arBytes = null;
		try {
			inputStream = new FileInputStream(filePath);

			outputStream = new ByteArrayOutputStream();

			byte[] readByte = new byte[1024];
			int readLen;
			while ((readLen = inputStream.read(readByte)) != -1) {
				outputStream.write(readByte, 0, readLen);
			}
			arBytes = outputStream.toByteArray();

		} catch (Exception e) {

		} finally {
			try {
				if (outputStream != null)
					outputStream.close();
			} catch (Exception e) {

			}
			try {
				if (inputStream != null)
					inputStream.close();
			} catch (Exception e) {

			}

		}
		if (arBytes != null) {
			try {
				return new JSONObject(new String(arBytes, "utf-8"));
			} catch (Exception e) {

			}
		}

		return null;
	}

	public JSONObject getJSONObjectfromHttp(String strurl) {

		InputStream inputStream = null;
		ByteArrayOutputStream outputStream = null;
		byte[] arBytes = null;

		try {
			String recv;
			StringBuffer recvbuff = new StringBuffer();
			URL jsonpage = new URL(strurl);
			URLConnection urlcon = jsonpage.openConnection();
			//urlcon.setConnectTimeout(10000);
			inputStream = urlcon.getInputStream();

			outputStream = new ByteArrayOutputStream();

			byte[] readByte = new byte[1024];
			int readLen;
			while ((readLen = inputStream.read(readByte)) != -1) {
				outputStream.write(readByte, 0, readLen);
			}
			arBytes = outputStream.toByteArray();

		} catch (Exception e) {

		} finally {
			try {
				if (outputStream != null)
					outputStream.close();
			} catch (Exception e) {

			}
			try {
				if (inputStream != null)
					inputStream.close();
			} catch (Exception e) {

			}

		}
		if (arBytes != null) {
			try {
				return new JSONObject(new String(arBytes, "utf-8"));
			} catch (Exception e) {

			}
		}
		return null;
	}

	public JSONArray getJSONArrayfromHttp(String strurl) {

		InputStream inputStream = null;
		ByteArrayOutputStream outputStream = null;
		byte[] arBytes = null;

		try {
			String recv;
			StringBuffer recvbuff = new StringBuffer();
			URL jsonpage = new URL(strurl);
			URLConnection urlcon = jsonpage.openConnection();
			urlcon.setConnectTimeout(10000);

			inputStream = urlcon.getInputStream();

			outputStream = new ByteArrayOutputStream();

			byte[] readByte = new byte[1024];
			int readLen;
			while ((readLen = inputStream.read(readByte)) != -1) {
				outputStream.write(readByte, 0, readLen);
			}
			arBytes = outputStream.toByteArray();

		} catch (Exception e) {

		} finally {
			try {
				if (outputStream != null)
					outputStream.close();
			} catch (Exception e) {

			}
			try {
				if (inputStream != null)
					inputStream.close();
			} catch (Exception e) {

			}

		}
		if (arBytes != null) {
			try {
				return new JSONArray(new String(arBytes, "utf-8"));
			} catch (Exception e) {

			}
		}
		return null;
	}

	public JSONArray getJSONArrayfromHttpDeal(String strurl) {

		InputStream inputStream = null;
		ByteArrayOutputStream outputStream = null;
		byte[] arBytes = null;
		try {
			String recv;

			URL jsonpage = new URL(strurl);
			URLConnection urlcon = jsonpage.openConnection();
			urlcon.setConnectTimeout(10000);
			inputStream = urlcon.getInputStream();

			outputStream = new ByteArrayOutputStream();

			byte[] readByte = new byte[1024];
			int readLen;
			while ((readLen = inputStream.read(readByte)) != -1) {
				outputStream.write(readByte, 0, readLen);
			}
			arBytes = outputStream.toByteArray();

		} catch (Exception e) {

		} finally {
			try {
				if (outputStream != null)
					outputStream.close();
			} catch (Exception e) {

			}
			try {
				if (inputStream != null)
					inputStream.close();
			} catch (Exception e) {

			}

		}

		if (arBytes != null) {
			try {
				SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
				String dates = formatter.format(new Date());
				long currenttime = Long.parseLong(dates);

				JSONArray json = new JSONArray(new String(arBytes, "utf-8"));
				JSONArray returnarr = new JSONArray();

				for (int i = 0; i < json.length(); i++) {

					JSONObject object = (JSONObject) json.get(i);

					String GOODS_EXPO_FLAG = (String) object.get("GOODS_EXPO_FLAG");
					String strST_EXPODATE = (String) object.get("GOODS_ST_EXPODATE_DIF");
					String strEND_EXPODATE = (String) object.get("GOODS_END_EXPODATE_DIF");

					if (strST_EXPODATE.length() < 13 || strEND_EXPODATE.length() < 13 || GOODS_EXPO_FLAG.length() < 1)
						continue;

					long ST_EXPODATE = Long.parseLong(strST_EXPODATE);
					long END_EXPODATE = Long.parseLong(strEND_EXPODATE);

					//	System.out.println(ST_EXPODATE+" "+END_EXPODATE+" "+currenttime);

					if (GOODS_EXPO_FLAG.equals("Y") && ST_EXPODATE <= currenttime && END_EXPODATE > currenttime) {

						returnarr.put(json.get(i));
					}
				}
				return returnarr;
			} catch (Exception e) {

			}
		}

		return null;
	}

	//현재 시간이 timeCheck시간 보다 작을때 true
	public Boolean isTimeUnder(long timeCheck) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHH");
		long currentcheck = Long.parseLong(sdf.format(new Date()));
		if (timeCheck > currentcheck)
			return true;
		return false;
	}%>