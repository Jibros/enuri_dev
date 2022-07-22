
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


<%@page import="java.net.*"%>

<%
boolean isDev = request.getServerName().contains("dev.enuri.com");	
boolean isCrazyDealUseable = false;
	String server = "m";

	String pages[] = {
	/*
	 //	"http", "0", "", 
	 //"http://dev.enuri.com/mobilefirst/ajax/appAjax/getMainFooterDefine_new_ajax.jsp",	

	 "array_deal", "0", "", "/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/http/json/mobile_deal_list.json", 
	 "array", "0", "", "/was/lena/1.3/depot/lena-application/ROOT/mobilenew/gnb/category/mainBanner.json",
	 //"objfile", "0", "",
	 //"/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/api/main/mobile_mainlist.json",
	 //"objfile", "0", "",
	 //"/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/http/json/mainBest.json", 
	 //"objfile", "0", "", 
	 //"/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/http/json/mainCompare.json", 
	 "objfile", "0", "", "/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/http/json/banner_list.json", 
	 "objfile", "0", "", "/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/api/main/mobile_mainlistfix.json",
	 "array", "0", "", "/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/ajax/middle_banner.json"
	 */

			//	"http", "0", "", 
			//"http://dev.enuri.com/mobilefirst/ajax/appAjax/getMainFooterDefine_new_ajax.jsp",	

			"mobile_deal_list.json", "0", "",
			//"http://" + server + ".enuri.com/mobilefirst/http/json/mobile_deal_list.json",
			"http://localhost/mobilefirst/http/json/mobile_deal_list.json",

			"mainBanner", "0", "",
			//"http://ad-api.enuri.info/enuri_M/m_main/M1/bundle?bundlenum=11",
			"http://localhost/mobilenew/gnb/category/mainBanner.json",

			//"objfile", "0", "",
			//"/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/api/main/mobile_mainlist.json",
			"httparray", "0", "", "http://localhost/mobilefirst/http/json/shopMainLogo.json",

			"httpobject", "0", "", "http://localhost/mobilefirst/http/json/banner_list.json",

			"middle_banner.json", "0", "",
			
			//"http://ad-api.enuri.info/enuri_M/m_main/M2/bundle?bundlenum=2"
			"http://localhost/mobilefirst/ajax/middle_banner2.json"

	/*
	"objmax", "30", "goodsList",
	"/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/http/json/best11st.json",
	"objmax", "30", "goodsList",
	"/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/http/json/bestAuction.json",
	"objmax", "30", "goodsList",
	"/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/http/json/bestGmarket.json" ,
	"objmax", "10", "planList",
	"/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/http/json/plan_banner.json" 
	 */
	};
	JSONObject makeJson = new JSONObject();
	try {

		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String dates = formatter.format(new Date());

		makeJson.put("time", dates);
		
		
		

		for (int i = 0; i < pages.length; i += 4) {
			try {
				String splits[] = pages[i + 3].split("/");

				if(isCrazyDealUseable) {
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
					if (obj != null)
						makeJson.put("mainBanner.json", obj);
				} else if (pages[i].equals("middle_banner.json")) {
					JSONArray obj;
					obj = getJSONArrayfromHttp(pages[i + 3]);
					if (obj != null)
					{
						// ios 3.3.2 버전 이하에서 [] 이값이 들어가면 홈 상품 나오지 않는 현상 예외처리함
						 if(obj.toString().startsWith("[{"))
						{
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

			if(isCrazyDealUseable) {
				try{
					
					String shopCode[]={"8090","6641","55"};
					String iconUrl[]={"http://img.enuri.info/images/mobilefirst/deal/logo/taillist%s.jpg",
							"http://img.enuri.info/images/mobilefirst/deal/logo/202002/tmon%s.jpg",
							"http://img.enuri.info/images/mobilefirst/deal/logo/201912/interpark%s.jpg"
					};
					JSONArray arrDealShopsIcon = new  JSONArray();
					for(int i = 0 ; i < shopCode.length; i ++)
					{
						JSONObject obj1 = new JSONObject();
						obj1.put("code",shopCode[i]);
						obj1.put("url",iconUrl[i]);
						arrDealShopsIcon.put(obj1);
					}
								
					makeJson.put("mobile_deal_list_shops_icon",arrDealShopsIcon);
				}catch(Exception e)
				{
					//makeJson.put("mobile_deal_list_shops_icon",e.toString());
				}
			}
		
		try {
			makeJson.put("shopimage_preurl","http://img.enuri.info/images");
		
			JSONArray arr1 = getJSONArrayfromHttp("http://ad-api.enuri.info/enuri_M/m_fp/M6/bundle?bundlenum=12");
			JSONArray arr2 = getJSONArrayfromHttp("http://ad-api.enuri.info/enuri_M/m_fp/M6a/bundle?bundlenum=12");
			
			for(int i = 0 ; i< arr2.length(); i ++){
				arr1.put(arr2.get(i));
			}
			JSONArray dimpopupArr = new JSONArray();
			int r = (int)((Math.random()* 10)%3);
	
			for(int i = 0 ; i< arr1.length(); i ++){
				JSONObject obj = arr1.getJSONObject(i);
				String sort = obj.getString("SORT");
				switch(r)
				{
				case 0:
					if(sort.equals("1"))
						dimpopupArr.put(obj);
					break;
				case 1:
					if( sort.equals("2"))
						dimpopupArr.put(obj);
					break;
				case 2:
					if(!sort.equals("1") && !sort.equals("2"))
						dimpopupArr.put(obj);
					break;
				}
			}
			
			
			makeJson.put("dimEventPopup",dimpopupArr);
			
			
		} catch (Exception e) {
			

		}
		
		 try{
		
			JSONObject obj = new JSONObject();
			obj.put("title","해외직구 가격비교");
			obj.put("link","http://"+server+".enuri.com/global/m/Index.jsp?freetoken=global");
			//obj.put("link","https://dev.enuri.com/my/my_enuri_m.jsp?freetoken=global");
			makeJson.put("mallree_mall_header",obj);
			makeJson.put("mallree_mall_list",getJSONArrayfromHttp("http://localhost/global/ajax/getGlobalPopShop_ajax.jsp?view_pst_cd=C"));			
			//makeJson.put("mallree_mall_bridge","http://"+server+".enuri.com/global/m/portal.jsp");
			makeJson.put("mallree_mall_bridge","http://"+server+".enuri.com/global/m/mvp.jsp?freetoken=global");
			
			makeJson.put("mallree_goods",getJSONArrayfromHttp("http://localhost/global/ajax/getDetailShoplist_ajax.json"));
			
			
		}catch(Exception e){
			
		} 
		 try{
			JSONObject obj = new JSONObject();
			
					
			String link = "http://"+server+".enuri.com/enuricar/m/list.jsp?freetoken=reborncar";
			obj.put("title","프리미엄 중고차");
			obj.put("link",link);
			//obj.put("list",getJSONObjectfromHttp("http://localhost/m/api/main/getAppCarSearch_ajax.jsp"));
            obj.put("list",getJSONObjectfromHttp("http://localhost/main/main2018/ajax/mainCarData.json"));
			obj.put("freetoken","freetoken=outbrowser");
			obj.put("bridge","http://"+server+".enuri.com/move/Redirect_resellcar.jsp?gd_cd=%s&url=%s");			
			JSONObject banner = new JSONObject();    	
	    	JSONArray arr = getJSONArrayfromHttp("http://ad-api.enuri.info/enuri_M/m_main/MR1/bundle?bundlenum=10");    			
	    	if(arr != null && arr.length() > 0){
	    		try{
		    		JSONObject bannerJson = arr.getJSONObject(0);
		    		banner.put("link",bannerJson.getString("JURL1"));
		    		banner.put("img",bannerJson.getString("IMG1"));
	    		}catch(Exception e){
	    			banner.put("link","http://"+server+".enuri.com/enuricar/m/list.jsp?freetoken=reborncar");
	        		banner.put("img","http://storage.enuri.info/car/appbanner/app_bnr_reborn_main_20200326.png");	
	    		}
	    	}else {
	    		banner.put("link","http://"+server+".enuri.com/enuricar/m/list.jsp?freetoken=reborncar");
	    		banner.put("img","http://storage.enuri.info/car/appbanner/app_bnr_reborn_main_20200326.png");
	    	}   
			obj.put("ad",banner);
			makeJson.put("reborn_car",obj);
						
		}catch(Exception e){
		
		} 
			
		//홈 상품 구좌 뚫기2017-05-19(개발)
		try {
			JSONArray objfixarray;

			objfixarray = (JSONArray) (getJSONObjectfromHttp("http://localhost/mobilefirst/api/main/mobile_mainlistfix.json").get("MainJsonfix"));

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
				String partKeys[][] = { { "T", "D", "C", "N" }, { "Q" }, { "T", "D", "C", "N" }, { "A" },
						{ "Q" }, { "G" }, { "A" }, { "G" }, { "G" }, { "G" }, { "G" } };
				//파트명이 들어갈 {위치, 길이, 카운트 초기값}
				int partKeyslocation[][] = { { 1, 10, 0 }, { 15, 1, 0 }, { 16, 3, 0 }, { 20, 1, 0 },
						{ 25, 1, 0 }, { 30, 1, 0 }, { 40, 1, 0 }, { 50, 1, 0 }, { 60, 1, 0 }, { 70, 1, 0 },
						{ 80, 1, 0 } };

				for (int i = 0; i < partKeys.length; i++) {
					for (int q = 0; q < objfixarray.length() && q >= 0; q++) {
						JSONObject objfixCell = ((JSONObject) objfixarray.get(q));
						//다운 받은 json에 part데이터가 있나 확인
						if (objfixCell.has("part") && !objfixCell.has("shuffle")) {
							String strPart = objfixCell.getString("part");

							if (strPart != null && strPart.length() > 0) {
								for (int j = 0; j < partKeys[i].length && j >= 0; j++) {
									//part가 있고 partKeys[][?]의 값이 있으면 ArrayList인 jsonDatas에 넣어주고  다운 받은 json의 part를 지워버린다 다시 못쓰게
									if (strPart != null && strPart.length() > 0
											&& strPart.equals(partKeys[i][j])) {
										if (strPart.equals("Q")) {

											int qcnt = 0;
											for (int a = 0; a < objfixarray.length() && a >= 0; a++) {
												JSONObject objfixCellQ = ((JSONObject) objfixarray.get(a));
												if (objfixCellQ.has("part") && !objfixCellQ.has("shuffle")) {
													String strPartQ = objfixCellQ.getString("part");
													if (strPartQ != null && strPartQ.length() > 0
															&& strPartQ.equals("Q")) {
														objfixCellQ.put("shuffle", true);
														objfixCellQ.put(
																"fix_location",
																Integer.toString(partKeyslocation[i][0]
																		+ partKeyslocation[i][2]));
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
											objfixCell.put(
													"fix_location",
													Integer.toString(partKeyslocation[i][0]
															+ partKeyslocation[i][2]));
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
		카테고리 3.3.8
		 */
		JSONArray cateBarJsonArr338 = new JSONArray();
		{
			String cateBarTitle[] = { "가전/해외직구", "TV/영상/디카", "컴퓨터/노트북", "태블릿/모바일",
					"스포츠/자동차", "유아/식품", "가구/생활",			
					"패션/화장품", "소셜비교", "쇼핑지식" };
			String cateBarImageaos[] = { 
					"/images/mobilefirst/main/cate/aos/home_category_menu01_",			
					"/images/mobilefirst/main/cate/aos/home_category_menu02_",
					"/images/mobilefirst/main/cate/aos/home_category_menu03_",
					"/images/mobilefirst/main/cate/aos/home_category_menu04_",
					"/images/mobilefirst/main/cate/aos/home_category_menu05_",
					"/images/mobilefirst/main/cate/aos/home_category_menu06_",
					"/images/mobilefirst/main/cate/aos/home_category_menu07_",
					"/images/mobilefirst/main/cate/aos/home_category_menu08_",
					"/images/mobilefirst/main/cate/aos/home_category_menu_social_",
					"/images/mobilefirst/main/cate/aos/home_category_menu_knowshopping2_" };
			String cateBarImageios[] = { 
					"/images/mobilefirst/main/cate/ios/home_category_menu01_",
					"/images/mobilefirst/main/cate/ios/home_category_menu02_",
					"/images/mobilefirst/main/cate/ios/home_category_menu03_",
					"/images/mobilefirst/main/cate/ios/home_category_menu04_",
					"/images/mobilefirst/main/cate/ios/home_category_menu05_",
					"/images/mobilefirst/main/cate/ios/home_category_menu06_",
					"/images/mobilefirst/main/cate/ios/home_category_menu07_",
					"/images/mobilefirst/main/cate/ios/home_category_menu08_",
					"/images/mobilefirst/main/cate/ios/home_category_menu_social_",
					"/images/mobilefirst/main/cate/ios/home_category_menu_knowshopping2_" };

			String cateBarUrl[] = { 
					"http://"+server+".enuri.com/mobilefirst/cpp.jsp?gcate=1",			
					"http://"+server+".enuri.com/mobilefirst/cpp.jsp?gcate=2",
					"http://"+server+".enuri.com/mobilefirst/cpp.jsp?gcate=3",
					"http://"+server+".enuri.com/mobilefirst/cpp.jsp?gcate=4",
					"http://"+server+".enuri.com/mobilefirst/cpp.jsp?gcate=5",
					"http://"+server+".enuri.com/mobilefirst/cpp.jsp?gcate=6",
					"http://"+server+".enuri.com/mobilefirst/cpp.jsp?gcate=7",
					"http://"+server+".enuri.com/mobilefirst/cpp.jsp?gcate=8",					
					"http://"+server+".enuri.com/deal/newdeal/index.deal?freetoken=social",
					"http://"+server+".enuri.com/knowcom/index.jsp?freetoken=shoppingknow"
			};

			for (int i = 0; i < 10; i++) {
				JSONObject obj = new JSONObject();
				obj.put("title", cateBarTitle[i]);
				obj.put("url", cateBarUrl[i]);//3.3.6 부터는 9인덱스 url은 무시하자 9일때 소스에 있는걸로 쓴다 
				obj.put("image_aos", cateBarImageaos[i]);
				obj.put("image_ios", cateBarImageios[i]);
				cateBarJsonArr338.put(obj);
			}
			makeJson.put("catebar338", cateBarJsonArr338);
			makeJson.put("catebar_preurl","http://img.enuri.info");
		}
		/**
		카테고리 하위버전
		 */
		JSONArray cateBarJsonArr = new JSONArray();
		{
			String cateBarTitle[] = { "디지털/가전", "컴퓨터", "스포츠/자동차", "유아/식품", "가구/생활/건강", "패션/화장품", "도서/여행/취미",
					"소셜비교", "백화점비교", "전체카테고리" };
			String cateBarImageaos[] = { "/images/mobilefirst/main/cate/aos/home_category_menu01_",
					"/images/mobilefirst/main/cate/aos/home_category_menu02_",
					"/images/mobilefirst/main/cate/aos/home_category_menu03_",
					"/images/mobilefirst/main/cate/aos/home_category_menu04_",
					"/images/mobilefirst/main/cate/aos/home_category_menu05_",
					"/images/mobilefirst/main/cate/aos/home_category_menu06_",
					"/images/mobilefirst/main/cate/aos/home_category_menu07_",
					"/images/mobilefirst/main/cate/aos/home_category_menu08_",
					"/images/mobilefirst/main/cate/aos/home_category_menu09_",
					"/images/mobilefirst/main/cate/aos/home_category_all_new_" };
			String cateBarImageios[] = { 
					"/images/mobilefirst/main/cate/ios/home_category_menu01",
					"/images/mobilefirst/main/cate/ios/home_category_menu02",
					"/images/mobilefirst/main/cate/ios/home_category_menu03",
					"/images/mobilefirst/main/cate/ios/home_category_menu04",
					"/images/mobilefirst/main/cate/ios/home_category_menu05",
					"/images/mobilefirst/main/cate/ios/home_category_menu06",
					"/images/mobilefirst/main/cate/ios/home_category_menu07",
					"/images/mobilefirst/main/cate/ios/home_category_menu08",
					"/images/mobilefirst/main/cate/ios/home_category_menu09",
					"/images/mobilefirst/main/cate/ios/home_category_all_new" };

			String cateBarUrl[] = { "http://"+server+".enuri.com/mobilefirst/cpp.jsp?gcate=1",
					"http://"+server+".enuri.com/mobilefirst/cpp.jsp?gcate=2",
					"http://"+server+".enuri.com/mobilefirst/cpp.jsp?gcate=3",
					"http://"+server+".enuri.com/mobilefirst/cpp.jsp?gcate=4",
					"http://"+server+".enuri.com/mobilefirst/cpp.jsp?gcate=5",
					"http://"+server+".enuri.com/mobilefirst/cpp.jsp?gcate=6",
					"http://"+server+".enuri.com/mobilefirst/cpp.jsp?gcate=7",
					"http://"+server+".enuri.com/deal/mobile/main.deal",
					//"http://"+server+".enuri.com/deal/newdeal/index.deal",
					"http://"+server+".enuri.com/mobiledepart/Index.jsp",
					"http://"+server+".enuri.com/mobilefirst?freetoken=category_app"

			};

			for (int i = 0; i < 10; i++) {
				JSONObject obj = new JSONObject();
				obj.put("title", cateBarTitle[i]);
				obj.put("url", cateBarUrl[i]);//3.3.6 부터는 9인덱스 url은 무시하자 9일때 소스에 있는걸로 쓴다 
				obj.put("image_aos", cateBarImageaos[i]);
				obj.put("image_ios", cateBarImageios[i]);
				cateBarJsonArr.put(obj);
			}
			makeJson.put("catebar", cateBarJsonArr);
		}

		makeJson.put("mobile_newedeal_design", "201709");
		
		if(isCrazyDealUseable) {
			JSONObject deallistHeader = new JSONObject();
			{
				deallistHeader.put("txt", "최저가에서 한번더 추/가/할/인");
				deallistHeader.put("txtcolor", "#55748b");

				//3.2.7은 여기 부터 사용
				deallistHeader.put("txt1", "오전10시!");
				deallistHeader.put("txt2", "다시없을 핫딜이 온다.");
				deallistHeader.put("linkurl", "http://"+server+".enuri.com/mobilefirst/evt/mobile_deal.jsp?freetoken=event");

				/////
				makeJson.put("mobile_deal_list_header", deallistHeader);
			}
		}


		JSONObject personalSetJson = new JSONObject();
		{
			JSONArray personalSetJsonArr = new JSONArray();
			String personalTitle[] = { "영상/디지털", "가전", "컴퓨터", "스포츠 용품", "자동차 용품", "유아용품/완구", "가구", "패션/화장품",
					"식품", "생활용품/도서" };
			String personalCode[] = { "02;24;03", "05;06", "04;07", "09", "21", "10", "12", "14;08", "15",
					"16;93;18" };
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

			String UNIQUE_EVETN_URL = "";
			//2020100500시 부터 100원딜 삭제됨
			if(isTimeUnder(2020100500)) {
				UNIQUE_EVETN_URL = "http://"+server+".enuri.com/mobilefirst/evt/firstbuy_event.jsp?freetoken=event";
			}else{
				UNIQUE_EVETN_URL = "http://"+server+".enuri.com/mobilefirst/evt/welcome_event.jsp?freetoken=event";
			}
			
			String eventBarTitle[] = { "출석체크", "WELCOME", "구매혜택", "VIP", "이벤트" };
			String eventBariOS[] = { "Y", "Y", "Y", "Y", "Y" };
			String eventBarAos[] = { "Y", "Y", "Y", "Y", "Y" };
			String eventBarUrl[] = {
					"http://"+server+".enuri.com/mobilefirst/evt/visit_event.jsp?freetoken=event",					
					UNIQUE_EVETN_URL ,
					"http://"+server+".enuri.com/mobilefirst/evt/smart_benefits.jsp?freetoken=event",
					"http://"+server+".enuri.com/mobilefirst/evt/buy_event.jsp?tab=1&freetoken=event",
					"http://"+server+".enuri.com/mobilefirst/plan_event.jsp?freetoken=main_tab|event" };
			String eventBarImageaos[] = { "/images/mobilefirst/main/eventbar/aos/home_event_menu01",
					"/images/mobilefirst/main/eventbar/aos/home_event_menu11",
					"/images/mobilefirst/main/eventbar/aos/home_event_menu09",
					"/images/mobilefirst/main/eventbar/aos/home_event_menu10",
					"/images/mobilefirst/main/eventbar/aos/home_event_menu05" };
			String eventBarImageios[] = { "/images/mobilefirst/main/eventbar/ios/home_event_menu01",
					"/images/mobilefirst/main/eventbar/ios/home_event_menu11",
					"/images/mobilefirst/main/eventbar/ios/home_event_menu09",
					"/images/mobilefirst/main/eventbar/ios/home_event_menu10",
					"/images/mobilefirst/main/eventbar/ios/home_event_menu05" };

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
			makeJson.put("eventbar_preurl","http://img.enuri.info");
		}
		JSONArray shopbestArr = new JSONArray();
		{
			String[] codes = { "536", "4027", "5910", "6641", "6508" };

			String[] urls ={
					"http://"+server+".enuri.com/mobilefirst/move2.jsp?vcode=536&freetoken=outlink&url=http%3a%2f%2fmobile.gmarket.co.kr%2f%3fjaehuid%3d200006254",
					"http://"+server+".enuri.com/mobilefirst/move2.jsp?vcode=4027&freetoken=outlink&url=http%3A%2F%2Fbanner.auction.co.kr%2Fbn_redirect.asp%3FID%3DBN00181187",
					"http://"+server+".enuri.com/mobilefirst/move2.jsp?vcode=5910&freetoken=outlink&url=http%3A%2F%2Fwww.11st.co.kr%2Fconnect%2FGateway.tmall%3Fmethod%3DXsite%26tid%3D1000997249",
					"http://"+server+".enuri.com/mobilefirst/move2.jsp?vcode=6641&freetoken=outlink&url=http%3A%2F%2Fm.ticketmonster.co.kr%2Fentry%2F%3Fjp%3D80025%26ln%3D214285",
					"http://"+server+".enuri.com/mobilefirst/move2.jsp?vcode=6508&freetoken=outlink&url=https%3A%2F%2Fmw.wemakeprice.com%2Faffiliate%2Fbridge%3FchannelId%3D1000032",
			};
					
			/* String[] urls = { 
					//"http://dev.enuri.com/mobilefirst/appschemetest.jsp?freetoken=outlink",		
					"http://www.gmarket.co.kr/index.asp?jaehuid=200006254&DEVICE_BROWSER=Y",
			
					//"http://mobile.auction.co.kr/HomeMain?BCODE=BN00149093&DEVICE_BROWSER=Y",
					//"http://mobile.auction.co.kr/HomeMain?BCODE=BN00181187&DEVICE_BROWSER=Y",
					"http://banner.auction.co.kr/bn_redirect.asp?ID=BN00181187",
					"http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1000997249&DEVICE_BROWSER=Y",
					"http://m.ticketmonster.co.kr/entry/?jp=80025&ln=214285&DEVICE_BROWSER=Y",

					"http://www.wemakeprice.com/widget/aff_bridge_public/enuri_m/0/Y/PRICE_af?DEVICE_BROWSER=Y"

			}; */
			//"http://img.enuri.info/images/mobilefirst/images/tmp/
			String[] imgurl = { "1", "2", "3_0714", "14", "13" };
			String[] imgurl_v333 = { "1", "2", "3", "4", "5" };
			String[] mall = { "G마켓", "옥션", "11번가", "티몬", "위메프" };

			for (int i = 0; i < codes.length; i++) {
				JSONObject site = new JSONObject();
				try {
					site.put("code", codes[i]);
					site.put("url", urls[i]);
					site.put("img", "/20160613/20160613_logo_" + imgurl[i] + ".gif");
					site.put("img_v333", "/main_shopbest_v333/20170918_logo_" + imgurl_v333[i] );
					site.put("mall", mall[i]);
					shopbestArr.put(site);
				} catch (Exception e) {
				}
			}
			makeJson.put("shopbest", shopbestArr);
			makeJson.put("shopbest_preurl","http://img.enuri.info/images/mobilefirst/publicmall");

		}
		/**
		홈메인 상품로고
		 */
		/*		JSONArray shopLogoJsonArr = new JSONArray();
		 {
		 String shopLogoTitle[]={"536","4027","5910","55","47","49","57","90","75","806","663","6588","6508","6641","6603","7692","6547","6620","974","374"};
		 String shopLogoUrl[]={
		 "/view/ls_logo/2013/Ap_logo_536.png",
		 "/view/ls_logo/2013/Ap_logo_4027.png",
		 "/view/ls_logo/2013/Ap_logo_5910.png",
		 "/view/ls_logo/2013/Ap_logo_55.png",
		 "/view/ls_logo/2013/Ap_logo_47.png",
		 "/view/ls_logo/2013/Ap_logo_49.png",
		 "/view/ls_logo/2013/Ap_logo_57.png",
		 "/view/ls_logo/2013/Ap_logo_90.png",
		 "/view/ls_logo/2013/Ap_logo_75.png",
		 "/view/ls_logo/2013/Ap_logo_806.png",
		 "/view/ls_logo/2013/Ap_logo_663.png",
		 "/view/ls_logo/2013/Ap_logo_6588.png",
		 "/view/ls_logo/2013/Ap_logo_6508.png",
		 "/view/ls_logo/2013/Ap_logo_6641.png",
		 "/view/ls_logo/2013/Ap_logo_6603.png",
		 "/view/ls_logo/2013/Ap_logo_7692.png",
		 "/view/ls_logo/2013/Ap_logo_6547.png",
		 "/view/ls_logo/2013/Ap_logo_6620.png",
		 "/view/ls_logo/2013/Ap_logo_974.png",
		 "/view/ls_logo/2013/Ap_logo_374.png"};

		 for(int i = 0 ; i < shopLogoTitle.length ; i ++)
		 {
		 JSONObject obj = new JSONObject();
		 obj.put("shop", shopLogoTitle[i]);
		 obj.put("img", shopLogoUrl[i]);

		 shopLogoJsonArr.add(obj);
		 }
		 makeJson.put("logo", shopLogoJsonArr);
		 }
		 */
		/**
		푸터쪽 페밀리앱
		 */
		JSONObject footerJson = new JSONObject();
		{

			JSONArray sites = new JSONArray();
			JSONArray allsite = getJSONArrayfromFile("/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/http/json/shopMainLogo.json");

			String[] codes = { "536", "4027", "5910", "55", "6665", "49", "57", "90", "75", "806", "663", "6588",
					"6508", "6641", "7861", "7692", "6547", "6620", "974", "7935" };
			String[] mall = new String[codes.length];
			String[] urls = new String[codes.length];
			String[] img = new String[codes.length];
			try{
				for(int i =0; i < codes.length ; i++) {
					for(int j =0; j < allsite.length() ; j++) {
						JSONObject shoplogoO =allsite.getJSONObject(j);
						
						if(codes[i].equals(shoplogoO.optString("shop"))){
							mall[i] = shoplogoO.optString("name");
							urls[i] = "http://"+server+".enuri.com/mobilefirst/move2.jsp?vcode="+codes[i]+"&freetoken=outlink&url=" + URLEncoder.encode(shoplogoO.optString("move"),"UTF-8");
							img[i] = shoplogoO.optString("img_g");
							break;
						}
						
					}
				}
			}catch(Exception e){
				//footerJson.put("exception SITE2",e.getLocalizedMessage());
			}

			for (int i = 0; i < codes.length ; i++) {
				JSONObject site = new JSONObject();

				try {
					site.put("site", mall[i]);
					site.put("code", codes[i]);
					site.put("url", urls[i]);
					
					//하위 버전에서 이미지 깨짐 현상 발생 iOS 개편 전 버전, 안드로이드는 잘됨 202005 확인 .. 서비스 버전 3.6.3
					//나중에 주석 풀 필요있다 -----------------------------
					//site.put("img", img[i]);		
					//ios 하위 버전 때문에 남겨둔 소스----------------------------- 
					if (mall[i].equals("wemakeprice"))
						site.put("img", "/20170330/20170330_logo_13.gif");
					else if (mall[i].equals(".lotte.com"))
						site.put("img", "/20170330/20180124_logo_6.gif");
					else if (mall[i].equals("11st"))
						site.put("img", "/20160613/20160613_logo_" + Integer.toString(i + 1) + "_0714.gif");
					else if (mall[i].equals("g9"))
						site.put("img", "/20160613/20180918_logo_g9.gif");
					else if (mall[i].equals("akmall"))
						site.put("img", "/20160613/20181030_logo_90.gif");
					else if (mall[i].equals("publichs"))
						site.put("img", "/20160613/20181105_logo_7935.gif");	
					else if (mall[i].equals("ssg"))
						site.put("img", "/20190404/20190404_logo_6665.gif");	
					else if (mall[i].equals("coupang"))
						site.put("img", "/20190404/20190404_logo_7861.gif");	
					else if( mall[i].equals("interpark") )
						site.put("img",  "/20191204/20191205_logo_" + codes[i] + ".png");	
					else if( mall[i].equals("gmarket") )
	        			site.put("img", "/20200113/20200113_logo_" + codes[i] + ".png");
					else
						site.put("img", "/20160613/20160613_logo_" + Integer.toString(i + 1) + ".gif");
					
					//여기 까지 -----------------------------
					sites.put(site);
				} catch (Exception e) {
				}
			}
			try {
			
				footerJson.put("SITE", sites);
				
			} catch (Exception e) {
			}

			JSONObject objFoot = getJSONObjectfromHttp("http://localhost/mobilefirst/http/json/footer.json");

			try {
				footerJson.put("APPSTORE_TITLE", objFoot.get("APPSTORE_TITLE"));
				footerJson.put("APPSTORE_IOS", objFoot.get("APPSTORE_IOS"));
				footerJson.put("APPSTORE_AND", objFoot.get("APPSTORE_AND"));
				footerJson.put("IMAGE_PREURL", objFoot.get("IMAGE_PREURL"));
			} catch (Exception e) {
			}
			// String[] appStoreTitle = { "스마트택배", "홈쇼핑가격비교", "소셜가격비교", "해외직구" };
			// 			String[] appStoreImgUrl = { "/images/mobilefirst/main/footer/footer_icon_sweettracker.png", 
			// 			"/images/mobilefirst/main/footer/footer_icon_homeshopping.png", 
			// 			"/images/mobilefirst/main/footer/footer_icon_hotdeal.png",
			// 					"/images/mobilefirst/main/footer/footer_icon_shipget.png", };
			// 			String[] appStoreURLiOS = { "https://itunes.apple.com/kr/app/id523045854?freetoken=outlink", 
			// 			"https://itunes.apple.com/kr/app/id1053348835?freetoken=outlink",
			// 					"https://itunes.apple.com/kr/app/id944887654?freetoken=outlink", 
			// 					"https://itunes.apple.com/kr/app/id992420740?freetoken=outlink" };
			// 			String[] appStoreURLAndroid = { "market://details?id=com.sweettracker.smartparcel&referrer=utm_source%Enuri%26utm_medium%app_banner%26utm_campaign%3Dinstall_promotion_from_Enuri",
			// 					"market://details?id=com.enuri.homeshopping&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_app_click%26utm_campaign%3Dfamilyapp20151209",
			// 					"market://details?id=com.enuri.deal&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_app_click%26utm_campaign%3Dfamilyapp20151209",
			// 					"market://details?id=com.megabrain.modagi&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_app_click%26utm_campaign%3Dfamilyapp20160705" };
			// 
			// 			String[] appSchemeiOS = { "smartparcel://", "enurihomeshopping://", "enurideal://", "shipget://" };
			// 			String[] appSchemeAOS = { "smartparcel://", "enurihomeshopping://", "enurideal://", "mbmdg://shipget.co.kr/main" };
			// 
			// 			for (int i = 0; i < 4; i++) {
			// 				JSONObject appStore = new JSONObject();
			// 				try {
			// 					appStore.put("title", appStoreTitle[i]);
			// 					appStore.put("url", appStoreURLiOS[i]);
			// 					appStore.put("scheme", appSchemeiOS[i]);
			// 					appStore.put("imgUrl", appStoreImgUrl[i]);
			// 
			// 					iOSAppStores.add(appStore);
			// 				} catch (Exception e) {
			// 				}
			// 			}
			// 
			// 			for (int i = 0; i < 4; i++) {
			// 				JSONObject appStore = new JSONObject();
			// 				try {
			// 					appStore.put("title", appStoreTitle[i]);
			// 					appStore.put("scheme", appSchemeAOS[i]);
			// 					appStore.put("url", appStoreURLAndroid[i]);
			// 					appStore.put("imgUrl", appStoreImgUrl[i]);
			// 
			// 					andAppStores.add(appStore);
			// 				} catch (Exception e) {
			// 				}
			// 			}
			// 
			// 			try {
			// 				footerJson.put("APPSTORE_IOS", iOSAppStores);
			// 				footerJson.put("APPSTORE_AND", andAppStores);
			// 			} catch (Exception e) {
			// 			}

			makeJson.put("footer", footerJson);
			makeJson.put("footersite_preurl","http://img.enuri.info/images/mobilefirst/publicmall");
		}
		// 		makeJson.put("footer", getJSONObjectfromHttp("http://localhost/mobilefirst/http/json/footer.json"));
		/**
		핫픽 이미지 URL
		 */
		JSONArray hotPicks = new JSONArray();
		{
			String[] cardPart = { "T", "N", "C" };
			String[] hotPickImageURLaos = { "/mobilefirst/badge/aos/home_label_hotpick_T_20160908.png",
					"/mobilefirst/badge/aos/home_label_hotpick_N_20160908.png",
					"/mobilefirst/badge/aos/home_label_hotpick_C_20160908.png" };
			String[] hotPickImageURLios = { "/mobilefirst/badge/ios/home_label_hotpick_T_20160909.png",
					"/mobilefirst/badge/ios/home_label_hotpick_N_20160909.png",
					"/mobilefirst/badge/ios/home_label_hotpick_C_20160909.png" };

			for (int i = 0; i < 3; i++) {
				JSONObject hotPick = new JSONObject();
				try {
					hotPick.put("part", cardPart[i]);
					hotPick.put("imgurlaos", hotPickImageURLaos[i]);
					hotPick.put("imgurlios", hotPickImageURLios[i]);

					hotPicks.put(hotPick);
				} catch (Exception e) {
				}
			}

			makeJson.put("badge", hotPicks);
			makeJson.put("badge_preurl","http://img.enuri.info/images");
		}
		/*
		JSONArray hotDeal = new JSONArray();
		String[] hotDealMalls = { "superdeal", "allkill", "shocking", "tmon", "coupang", "wemake" };
		String[] hotDealUrls = { "/http/json/superDeal.json", "/http/json/allKill.json", "/http/json/shocking.json", "/http/json/tmon.json", "/http/json/coupang.json", "/http/json/wemake.json"};
		String[] hotDealLogos = { "/20160617/20160617_hotdeal_superdeal.png", "/20160617/20160617_hotdeal_allkill.png", "/20160617/20160617_hotdeal_shocking.png", "/20160617/20160617_hotdeal_tmon.png", "/20160617/20160617_hotdeal_coupang.png", "/20160617/20160617_hotdeal_wemake.png" };
		String[] hotDealTitles = { "슈퍼딜", "올킬", "쇼킹딜", "티몬", "쿠팡", "위메프" };
		for (int i = 0 ; i < hotDealMalls.length ; i++) {
		JSONObject hotDealSites = new JSONObject();
		hotDealSites.put("mall", hotDealMalls[i]);
		hotDealSites.put("title", hotDealTitles[i]);
		hotDealSites.put("url", hotDealUrls[i]);
		hotDealSites.put("logo", hotDealLogos[i]);
		hotDeal.add(hotDealSites);
		}		
		makeJson.put("aaa",hotDeal);
		 */

		//out.println(makeJson.toString().substring(5750));
		//"/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/http/json/mobile_deal_list.json",
		try {

			JSONObject[] dealSaveList = new JSONObject[6];
			String[] strDeals = { "superDeal", "allKill", "shocking", "tmon", "wemake", "ssenDeal" };
			int[] randomIndex = { 0, 1, 2, 3, 4, 5 };
			int[] overrandomIndex = { 0, 1, 2 };
			int maxsize = randomIndex.length;
			for (int i = 0; i < randomIndex.length; i++) {
				//JSONObject obj =getJSONObjectfromFile("/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/http/json/"+strDeals[i]+".json");
				JSONObject obj = getJSONObjectfromHttp("http://localhost/mobilefirst/http/json/"
						+ strDeals[i] + ".json");
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
							int shopCode = Integer.parseInt((String) dealSaveList[randomIndex[cnt]]
									.getString("shopCode"));

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
							int shopCode = Integer.parseInt((String) dealSaveList[overrandomIndex[cnt]]
									.getString("shopCode"));
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

				makeJson.put("mainBest.json", getJSONObjectfromHttp("http://localhost/mobilefirst/http/json/mainBest.json"));
				makeJson.put("mainCompare.json", getJSONObjectfromHttp("http://localhost/mobilefirst/http/json/mainCompare.json"));

			} else
				makeJson.put("main_deal", dealList);
			makeJson.put("main_deal_cnt", dealList.length());
		} catch (Exception e) {
			//out.println(e.toString());
			makeJson.put("exception1", e.toString());

		}

		if (!makeJson.has("main_deal")) {
			if (!makeJson.has("mainBest.json"))

				makeJson.put("mainBest.json", getJSONObjectfromHttp("http://localhost/mobilefirst/http/json/mainBest.json"));

			if (!makeJson.has("mainCompare.json"))
				makeJson.put("mainCompare.json", getJSONObjectfromHttp("http://localhost/mobilefirst/http/json/mainCompare.json"));

		}
		

	} catch (Exception e) {
		makeJson.put("exception2", e.toString());
	}
	if (makeJson != null)
		out.println(makeJson.toString());
%>
<%!public JSONArray getJSONArrayfromFile(String filePath) {

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

	public JSONArray getJSONArrayfromFileDeal(String filePath) {
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
		return null;
	}

	public JSONArray getJSONArrayfromFile(String filePath, String strMax, String title) {
		String news_data = "";

		try {
			int max = Integer.parseInt(strMax);
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

			JSONObject json = new JSONObject(new String(arBytes, "utf-8"));
			JSONArray arr = (JSONArray) json.get(title);

			JSONArray returnarr = new JSONArray();
			for (int i = 0; i < arr.length() && i < max; i++) {
				returnarr.put(arr.get(i));
			}

			return returnarr;
		} catch (Exception e) {

		}

		return null;
	}

	public JSONObject getJSONObjectfromFile(String filePath) {

		String news_data = "";

		InputStream inputStream = null;

		try {
			inputStream = new FileInputStream(filePath);

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

	public JSONArray getJSONArrayfromHttp(String strurl) {
		try {
			String recv;
			StringBuffer recvbuff = new StringBuffer();
			URL jsonpage = new URL(strurl);
			URLConnection urlcon = jsonpage.openConnection();
			urlcon.setConnectTimeout(10000);

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

			return new JSONArray(new String(arBytes, "utf-8"));
		} catch (Exception e) {

			
		}
		return null;
	}

	public JSONArray getJSONArrayfromHttpDeal(String strurl) {
		try {
			String recv;

			URL jsonpage = new URL(strurl);
			URLConnection urlcon = jsonpage.openConnection();
			urlcon.setConnectTimeout(10000);
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
		return null;
	}
	//현재 시간이 timeCheck시간 보다 작을때 true
	public Boolean isTimeUnder(long timeCheck){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHH");
		long currentcheck = Long.parseLong(sdf.format(new Date()));
		if (timeCheck > currentcheck)
			return true;
		return false;
	}
	
	%>