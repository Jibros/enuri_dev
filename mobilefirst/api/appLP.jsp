
<%@page import="com.enuri.bean.main.Component_Proc"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Data"%>
<%@ page import="com.enuri.bean.main.Component_Proc"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>

<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@page import="java.net.*"%>
<%!String mobileInfoAD, cate, catename, pType, gb1, gb2, deviceType, key, constrain, ca_arr_code, order, sponsor_modelno_type, openexpectflag, ca_arr_lcode, mallcntAll,
			IsDeliverySumPrice, jobcode, m_price, start_price, end_price, brand_arr, factory_arr, spec, sel_spec, random_seq, pageNum, pageGap, tabType, keyword, brand, factory,
			prtmodelno, sponsorList, infoAdList, procType, szCategory, ad_command, ad_command2, referrer, url, strCh, groupflag, chk_id, adult, ncpc, miseCate = "",
			listInfoCate = "", app_type, strversion;
	boolean fDevServer = false;
	int version = 0;
	String RightMenuFactory = "Y", RightMenuBrand = "Y";

	String enuri = "http://localhost";%>
<%
	//플러스 링크 ip 검사 해서 따로 생성 필요
	fDevServer = request.getServerName().equals("dev.enuri.com");

	
	String ip = request.getHeader("X-Forwarded-For");
	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("Proxy-Client-IP");
	}
	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("WL-Proxy-Client-IP");
	}
	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("HTTP_CLIENT_IP");
	}
	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("HTTP_X_FORWARDED_FOR");
	}
	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getRemoteAddr();
	}
	String userAgent = request.getHeader("user-agent");
	
	app_type = ConfigManager.RequestStr(request, "app_type", "N");
	
	strversion = ConfigManager.RequestStr(request, "version", "0.0.0");
	
	version = 0;
	if (strversion.length() >= 5) {
		try {
	version = Integer.parseInt(strversion.substring(0, 1)) * 100 + Integer.parseInt(strversion.substring(2, 3)) * 10 + Integer.parseInt(strversion.substring(4, 5));
		} catch (Exception e) {
		}
	}



	mobileInfoAD = ConfigManager.RequestStr(request, "mobileInfoAD", "N");
	cate = ConfigManager.RequestStr(request, "cate", "0404");
	catename = ConfigManager.RequestStr(request, "catename", "");
	pType = ConfigManager.RequestStr(request, "pType", "");
	gb1 = ConfigManager.RequestStr(request, "gb1", "");
	gb2 = ConfigManager.RequestStr(request, "gb2", "");
	deviceType = ConfigManager.RequestStr(request, "deviceType", "");
	

	constrain = ConfigManager.RequestStr(request, "constrain", "");
	ca_arr_code = ConfigManager.RequestStr(request, "ca_arr_code", "");
	order = ConfigManager.RequestStr(request, "order", "");
	sponsor_modelno_type = ConfigManager.RequestStr(request, "sponsor_modelno_type", "");
	openexpectflag = ConfigManager.RequestStr(request, "openexpectflag", "");
	ca_arr_lcode = ConfigManager.RequestStr(request, "ca_arr_lcode", "");
	mallcntAll = ConfigManager.RequestStr(request, "mallcntAll", "");
	IsDeliverySumPrice = ConfigManager.RequestStr(request, "IsDeliverySumPrice", "");
	jobcode = ConfigManager.RequestStr(request, "jobcode", "");
	m_price = ConfigManager.RequestStr(request, "m_price", "");
	start_price = ConfigManager.RequestStr(request, "start_price", "");
	end_price = ConfigManager.RequestStr(request, "end_price", "");
	brand_arr = ConfigManager.RequestStr(request, "brand_arr", "");
	factory_arr = ConfigManager.RequestStr(request, "factory_arr", "");
	spec = ConfigManager.RequestStr(request, "spec", "");
	
	sel_spec = ConfigManager.RequestStr(request, "sel_spec", "");
	if(sel_spec.equals("")){
		spec = "";
		}else {
	spec = "Y";
		}
	spec = spec.toLowerCase();
	random_seq = ConfigManager.RequestStr(request, "random_seq", "");
	pageNum = ConfigManager.RequestStr(request, "pageNum", "0");
	pageGap = ConfigManager.RequestStr(request, "pageGap", "0");
	
	
	key = ConfigManager.RequestStr(request, "key", "");
	tabType = ConfigManager.RequestStr(request, "tabType", "");
	keyword = ConfigManager.RequestStr(request, "keyword", "");
	
	/* 
	1.	인기순 - popular DESC
	 기존 동일
	2.	신규등록순 / 판매량순  - c_date DESC, sale_cnt DESC
		- 모델/그룹모델만 적용
	1) 기본 필터값 적용
	2) 동점 내 인기도 반영
	3.	최저가순 / 최고가순 / 상품평 많은순 - minprice3, minprice3 DESC, bbs_num DESC
		- 모델/그룹모델 + 일반상품 적용
	1) 기본 필터값 적용
	2) 동점 내 인기도 반영
 */
	//if (app_type.equals("I") || (app_type.equals("A") && version > 371)) {
		if (keyword.length() > 0 || key.equals("") ||  key.equals("popular DESC") || key.equals("bbs_num DESC") || key.equals("minprice3") || key.equals("minprice3 DESC")) {
			tabType = "0";
		} else {
			tabType = "1";
		}
	//}

	brand = ConfigManager.RequestStr(request, "brand", "");
	factory = ConfigManager.RequestStr(request, "factory", "");
	prtmodelno = ConfigManager.RequestStr(request, "prtmodelno", "");

	sponsorList = ConfigManager.RequestStr(request, "sponsorList", "");
	infoAdList = ConfigManager.RequestStr(request, "infoAdList", "");

	procType = ConfigManager.RequestStr(request, "procType", "");

	szCategory = ConfigManager.RequestStr(request, "szCategory", cate);
	ad_command = ConfigManager.RequestStr(request, "ad_command", "");
	ad_command2 = ConfigManager.RequestStr(request, "ad_command2", catename);
	referrer = ConfigManager.RequestStr(request, "referrer", "");
	// url = ConfigManager.RequestStr(request, "url", "http://m.enuri.com/mobilefirst/list.jsp?cate="+cate);
	url = ConfigManager.RequestStr(request, "url", "list.jsp");
	strCh = ConfigManager.RequestStr(request, "strCh", "m_enuri.ch5");

	groupflag = ConfigManager.RequestStr(request, "groupflag", "0");
	chk_id = ConfigManager.RequestStr(request, "chk_id", "");
	adult = ConfigManager.RequestStr(request, "adult", "0");

	ncpc = ConfigManager.RequestStr(request, "ncpc", "Y").toUpperCase();

	miseCate = "";
	listInfoCate = "";

	try {
		String strCate4 = cate;
		if (cate.length() > 0) {
			if (cate.length() > 4)
				strCate4 = cate.substring(0, 4);
			Goods_Search_Lsv_Proc goods_search_lsv_proc = new Goods_Search_Lsv_Proc();
			//int[] showCntList = goods_search_lsv_proc.getCategorySpecShowNum(cate);
			Goods_Search_Lsv_Data optionInfo = goods_search_lsv_proc.getSearchOptionSet(strCate4);
			RightMenuFactory = optionInfo.getTab_factory_flag().equals("1") ? "Y" : "N";
			if (cate.equals("163619")) {//마스크해외구매 카테고리에서 브랜드 값이 없는데 브랜드가 있다 Y 해서 오류남 iOS 3.6.0까지 
				RightMenuBrand = "N";
			} else {
				RightMenuBrand = optionInfo.getTab_brand_flag().equals("1") ? "Y" : "N";
			}
		}
	} catch (Exception e) {
	}

	//----------------------------------------------------------------------------------------------------------

	JSONObject obj = new JSONObject();
	{

		obj.put("navercpcA", "Y");
		obj.put("ebaycpcA", "Y");
		obj.put("navercpcI", "Y");
		obj.put("ebaycpcI", "Y");
		if (cate.length() > 4 && groupflag.equals("0") || groupflag.equals("2")) {
			if (cate.length() > 6)
				miseCate = cate.substring(0, 6);
			else
				miseCate = cate;

			obj.put("ajax_to_json_5category",
					new JSONArray(getfromHttp(false, enuri + "/mobilefirst/ajax/gnb/ajax_to_json_5category.jsp?cate=" + miseCate + "&flag=" + groupflag)));
		}

		if (cate.length() > 4)
			listInfoCate = cate.substring(0, 4);
		else
			listInfoCate = cate;

		//try{
		//안드로이드 3.3.1 버젼에서는 제조사 브랜드 상세를 lp데이터 호출 할때 값을 가져와 처리한다 
		if ((app_type.equals("A") && version >= 331) || (app_type.equals("I") && version >= 360)) {
			obj.put("appCateSpecMenu",
					new JSONObject(getfromHttp(true,
							enuri + "/mobilefirst/api/appCateSpecMenu331.jsp?cate=" + cate + "&factory=" + URLEncoder.encode(RightMenuFactory, "UTF-8") + "&brand="
									+ URLEncoder.encode(RightMenuBrand, "UTF-8"))));
		}
		/* }catch(Exception e){
			sendErrorLog("appCateSpecMenu "+ enuri + "/mobilefirst/api/appCateSpecMenu331.jsp?cate=" + cate + "&factory=" + URLEncoder.encode(RightMenuFactory, "UTF-8") + "&brand="
					+ URLEncoder.encode(RightMenuBrand, "UTF-8"))	;
		} */

		//ios의 경우에는 따로 appCateSpecMenu331을 호출 하기 때문에 그 값을 호출 하기위한 
		//값을 아래의 값으로 세팅해서 데이터를 호출 한다 
		if (app_type.equals("I") && version >= 331) {
			JSONObject temp = new JSONObject();
			temp.put("RightMenuFactory", RightMenuFactory);
			temp.put("RightMenuBrand", RightMenuBrand);
			obj.put("showLpFactoryBrand", temp);
		}
		boolean PowerShoppingCheck = false;
		try {
			if (cate != null && cate.length() > 2) {
				JSONObject shGoods = new JSONObject(getfromFile(true, "/was/lena/1.3/depot/lena-application/ROOT/lsv2016/category_type.json"));
				String preCaCode = cate.substring(0, 2);
				String WhatGoods = shGoods.getString(preCaCode);
				if (WhatGoods.equals("SG")) {
					PowerShoppingCheck = true;
					obj.put("POWERSHOPPING", "Y");
				}
			}

		} catch (Exception e) {

		}
		if (PowerShoppingCheck == false) {
			obj.put("POWERSHOPPING", "N");
		}

		if (cate.equals("11600")) {

		} else {
			JSONObject list = null;

			int gap = Integer.parseInt(pageGap);
           /*
			if (gap <= 50 && cate.length() == 4 && pageNum.equals("1") && !IsJsonUseCate(cate) && (keyword.length() == 0) && (gb1.length() == 0) && (gb2.length() == 0)
					&& key.equals("popular DESC") && (factory.length() == 0) && (factory_arr.length() == 0) && (brand.length() == 0) && (brand_arr.length() == 0)
					&& (start_price.length() == 0) && (end_price.length() == 0) && (sel_spec.length() == 0) && (spec.length() == 0)) {
				String resultList = getfromFile(true, "/was/lena/1.3/depot/lena-application/ROOT/lsv2016/etc/jsons_app/m_" + cate + "_1_50.json");

				try {
					if (resultList.length() > 10) {
						list = new JSONObject(resultList);
						if (gap != 50) {
							JSONArray objArr = list.getJSONArray("lpList");
							JSONArray tempArr = new JSONArray();

							int i = 0;
							for (int j = 0; j < objArr.length() && i < gap; j++) {
								JSONObject objtemp = objArr.getJSONObject(j);

								tempArr.put(objtemp);
								if (objtemp.getString("intAdType").equals(""))
									i++;
							}
							list.put("lpList", tempArr);
							list.put("itemShowCnt", Integer.toString(i));
							list.put("intRsCnt", Integer.toString(i));
							//obj.put("aa", "file ok" + i + " " + gap);
						}
					} else {
						try {

							list = getListGoods_ajax(ip, userAgent);
							sendErrorLog("down json E>");
						} catch (Exception ee) {
							//	obj.put("aa",ee.toString());
							sendErrorLog("down json > make json E>" + ee.toString());

						}
					}
				} catch (Exception e) {

					try {
						list = getListGoods_ajax(ip, userAgent);
						sendErrorLog("down json parsing E>" + e.toString());
					} catch (Exception ee) {
						sendErrorLog("down json parsing > make json E>" + ee.getMessage());

					}
				}
			} else
				*/
			{
				try {

					list = getListGoods_ajax(ip, userAgent);
					/* obj.put("aa",
							"web no file " + cate + " " + pageNum.equals("1") + " " + IsJsonUseCate(cate) + " " + key.equals("popular DESC") + " " + !(factory.length() > 0)
									+ " " + !(factory_arr.length() > 0) + " " + !(brand.length() > 0) + " " + !(brand_arr.length() > 0) + " " + !(start_price.length() > 0)
									+ " " + !(end_price.length() > 0)); */
				} catch (Exception ee) {
					sendErrorLog("make json E>" + ee.toString());
				}
			}

			obj.put("getListGoods_ajax", list);

			//모바일 웹 srp는 적용되 있더라 isSrpSponBType 이라는 값으로 호출 여부 판단하고 상품 첫번째 카테고리strCa_code 를 가지고 호출 한다 "편강 한방 연구소"			
			if (version >= 343) {
				if (pageNum.equals("1") && list.optString("isSponBType").equals("true")) {//스폰서 광고는 최대 3개가 표시 된다 랜덤으로 섞어 준다 
					try {
						//20191017 슈퍼탑 광고로 인해 ab타입 둘중에 하나라도 나오면 호출 하는 구조로 변경
						JSONObject btype = new JSONObject(getfromHttpTimeoutLimited(true,
								"http://localhost/lsv2016/ajax/getInfoAd_showList2_ajax.jsp?deviceType=2&division=2&type=B&cate=" + cate));

						//JSONObject btype = new JSONObject(getfromHttpTimeoutLimited(true,"http://localhost/lsv2016/ajax/getInfoAd_showList2_ajax.jsp?deviceType=2&division=2&cate=" + cate));
						if (!btype.has("sponsorads")) {
							JSONObject sponsorads = new JSONObject();
							JSONObject ads = new JSONObject();
							ads.put("ads", new JSONArray());
							sponsorads.put("sponsorads", ads);
							obj.put("sponsorBtype", sponsorads);
						} else {
							obj.put("sponsorBtype", btype);
						}
					} catch (Exception e) {
						JSONObject sponsorads = new JSONObject();
						JSONObject ads = new JSONObject();
						ads.put("ads", new JSONArray());
						sponsorads.put("sponsorads", ads);
						obj.put("sponsorBtype", sponsorads);
					}
				}
			}

		}

		
		// ebay cpc 에서 없으면 알아서 넣어준다 그래서 필요없음
		//	obj.put("getListDealMini_ajax", new JSONObject(getfromHttp(true, enuri + "/mobilefirst/ajax/listAjax/getListDealMini_ajax.jsp?cate=" + listInfoCate)));
		if (pageNum.equals("1") && ncpc.equals("Y")) {

			if (version < 360) { //2020 1월 파워 링크 데이터 변경 ios 개편전 버전 대응 ...버전 1개 대응용..
				try{
				String hostName = "http://localhost";//fDevServer ? "http://dev.enuri.com" : "http://m.enuri.com";
				StringBuffer sb = new StringBuffer(hostName);
				/* obj.put("getSponsorLink_jsonurlurl", url);
				obj.put("getSponsorLink_jsonurlreferrer", referrer); */
				
				sb.append("/mobilenew/ajax/getSponsorLink_json.jsp");
				sb.append("?cate=" + cate);
				sb.append("&szCategory=" + szCategory);
				sb.append("&ad_command=" + ad_command);
				sb.append("&ad_command2=" + ad_command2);
				sb.append("&referrer=" + URLEncoder.encode(referrer, "UTF-8"));
				sb.append("&url=" + URLEncoder.encode(url, "UTF-8"));
				sb.append("&strCh=" + strCh);
				//obj.put("getSponsorLink_jsonurl", sb.toString());
				obj.put("getSponsorLink_json", new JSONObject(getfromHttp(true, sb.toString())));
				
				
				}catch(Exception e){
					//obj.put("getSponsorLink_jsonexp", e.toString());
				}

			}

		}
		obj.put("banner_list", new JSONObject(getfromFile(true, "/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/http/json/banner_list.json")));
		obj.put("appLP_banner", new JSONObject(getfromHttp(true, enuri + "/mobilefirst/api/appLP_banner.jsp?cate=" + cate)));

	}

	out.println(obj.toString());
%>




<%!public JSONObject getListGoods_ajax(String ip, String userAgent) throws Exception {

		String url = null;
		try {
			url = getUrl();
		} catch (Exception e) {
			sendErrorLog("getListGoods_ajax make url E>" + e.toString());
		}
		return new JSONObject(getfromHttpHeader(true, url, ip, userAgent));

	}

	public String getUrl() throws Exception {

		StringBuffer sb = new StringBuffer(enuri);
		sb.append("/lsv2016/ajax/getListGoods_ajax.jsp");
		sb.append("?cate=" + cate);
		sb.append("&deviceType=2");
		sb.append("&mobileAppAdult=Y");
		sb.append("&gb1=" + URLEncoder.encode(gb1, "UTF-8"));
		sb.append("&gb2=" + URLEncoder.encode(gb2, "UTF-8"));
		sb.append("&key=" + URLEncoder.encode(key, "UTF-8"));
		sb.append("&constrain=" + URLEncoder.encode(constrain, "UTF-8"));
		sb.append("&ca_arr_code=" + URLEncoder.encode(ca_arr_code, "UTF-8"));
		sb.append("&order=" + URLEncoder.encode(order, "UTF-8"));
		sb.append("&sponsor_modelno_type=" + sponsor_modelno_type);
		sb.append("&IsMobileApp=Y");
		sb.append("&mobileInfoAD=" + URLEncoder.encode(mobileInfoAD, "UTF-8"));
		sb.append("&openexpectflag=" + URLEncoder.encode(openexpectflag, "UTF-8"));
		sb.append("&ca_arr_lcode=" + URLEncoder.encode(ca_arr_lcode, "UTF-8"));
		sb.append("&mallcntAll=" + URLEncoder.encode(mallcntAll, "UTF-8"));
		sb.append("&IsDeliverySumPrice=" + URLEncoder.encode(IsDeliverySumPrice, "UTF-8"));
		sb.append("&jobcode=" + URLEncoder.encode(jobcode, "UTF-8"));
	
		/* if(!start_price.equals("") || !end_price.equals("")){
			if (start_price.equals("")){
				start_price = "0";
			}
			if (end_price.equals("")){
				end_price = start_price;
				start_price = "0";
			}
			m_price = start_price +"~"+end_price;
		} */
		
		sb.append("&m_price=" + URLEncoder.encode(m_price, "UTF-8"));
		sb.append("&start_price=" + URLEncoder.encode(start_price, "UTF-8"));
		sb.append("&end_price=" + URLEncoder.encode(end_price, "UTF-8"));
		sb.append("&brand_arr=" + URLEncoder.encode(brand_arr, "UTF-8"));
		sb.append("&factory_arr=" + URLEncoder.encode(factory_arr, "UTF-8"));
		sb.append("&spec=" + URLEncoder.encode(spec, "UTF-8"));
		sb.append("&sel_spec=" + URLEncoder.encode(sel_spec, "UTF-8"));
		sb.append("&random_seq=" + random_seq);
		sb.append("&pageNum=" + pageNum);
		sb.append("&pageGap=" + pageGap);
		sb.append("&tabType=" + tabType);
		sb.append("&keyword=" + URLEncoder.encode(keyword, "UTF-8"));
		sb.append("&brand=" + URLEncoder.encode(brand, "UTF-8"));
		sb.append("&factory=" + URLEncoder.encode(factory, "UTF-8"));
		sb.append("&prtmodelno=" + URLEncoder.encode(prtmodelno, "UTF-8"));
		sb.append("&sponsorList=" + URLEncoder.encode(sponsorList, "UTF-8"));
		sb.append("&infoAdList=" + URLEncoder.encode(infoAdList, "UTF-8"));
		return sb.toString();
	}
	public String getfromHttpHeader(boolean isJSONObject, String strurl, String ip , String userAgent) {
		try {
			String recv;
			StringBuffer recvbuff = new StringBuffer();
			URL jsonpage = new URL(strurl);
			URLConnection urlcon = jsonpage.openConnection();

			//urlcon.setConnectTimeout(10000);
			urlcon.setRequestProperty("log.user_ip", ip);
			urlcon.setRequestProperty("log.user_agent", userAgent);
			
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

			return new String(arBytes, "UTF-8").trim();
		} catch (Exception e) {

		}
		if (isJSONObject)
			return "{}";
		else
			return "[]";
	}
	public String getfromHttp(boolean isJSONObject, String strurl) {
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

			return new String(arBytes, "UTF-8").trim();
		} catch (Exception e) {

		}
		if (isJSONObject)
			return "{}";
		else
			return "[]";
	}

	public String getfromHttpTimeoutLimited(boolean isJSONObject, String strurl) {
		try {
			String recv;
			StringBuffer recvbuff = new StringBuffer();
			URL jsonpage = new URL(strurl);
			URLConnection urlcon = jsonpage.openConnection();
			urlcon.setConnectTimeout(2000);
			urlcon.setReadTimeout(2000);
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
			//throw new Exception();

			return new String(arBytes, "UTF-8").trim();
		} catch (Exception e) {
			if (isJSONObject) {
				if (fDevServer)
					return "{\"exception\":\"" + e.getMessage() + "\"}";
				else
					return "{}";
			} else
				return "[]";
		}

	}

	public String getfromFile(boolean isJSONObject, String filePath) {

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
			return new String(arBytes, "utf-8");
		} catch (Exception e) {

		}
		if (isJSONObject)
			return "{}";
		else
			return "[]";
	}

	boolean IsJsonUseCate(String gCate) {

		if (gCate.length() > 4)
			return false;

		String[] noMCateAry = {
				//20200310 카테고리 변경으로 json 파일 참고 하지 않음
				//1602 > 2144,
				//1635 > 2145				
				//0807 > 1654

		"0502", "0503", "0514", "0515", "0511", "0602", "0609", "0611", "0601", "0608", "2406", "2401", "2402", "2405", "1007", "1020", "1024", "1005", "1010", "1501", "1513",
				"1505", "1511", "1502", "1508", "1507", "0201", "0203", "0211", "0224", "0232", "0237", "0238", "0241", "0233", "0234", "0304", "0318", "0357", "0359", "0305",
				"0363", "2211", "1451", "1454", "1455", "1459", 
				//"2144","2145","1654", 
				//"1635", 
				"1605", "1625", "1614", "1620", "1642", "0908", "0930", "0401", "0402", "0404", "0405", "0414",
				"0701", "0702", "0704", "0709", "0710", "0711", "0712", "0713", "1245", "1219", "2115", "1640", "2403", "9310" };

		boolean rtnValue = false;
		for (int i = 0; i < noMCateAry.length; i++) {
			if (gCate.equals(noMCateAry[i])) {
				rtnValue = true;
				break;
			}
		}

		return rtnValue;
	}

	public void sendErrorLog(String errorLog) {
		try {
			String recv;
			StringBuffer sendurl = new StringBuffer();
			sendurl.append("http://localhost/mobilefirst/api/appErrorLog.jsp?appId=1001&appType=E");
			String __jspName = this.getClass().getSimpleName();

			if (__jspName.contains("save")) {
				sendurl.append("&errorType=3");
				sendurl.append("&errorCode=appLP_save");
			} else {
				sendurl.append("&errorType=1");
				sendurl.append("&errorCode=appLP");
			}
			sendurl.append("&userData=");
			sendurl.append(__jspName);
			sendurl.append("&version=0.0.0");
			sendurl.append("&shopCode=0");
			sendurl.append("&errorMsg=");

			String sendUrl = null;
			try {
				sendUrl = getUrl();
			} catch (Exception e) {
				sendUrl = "sendErrorLog make sendurl>" + e.toString();
			}

			String sendMessage;
			if (sendUrl != null && sendUrl.length() > 0 && sendUrl.contains("?"))
				sendMessage = errorLog + "//" + sendUrl.split("[?]")[1];
			else
				sendMessage = errorLog + "//" + sendUrl;

			if (sendMessage.length() > 500)
				sendurl.append(URLEncoder.encode(sendMessage.substring(0, 500), "UTF-8"));
			else
				sendurl.append(URLEncoder.encode(sendMessage, "UTF-8"));

			URL obj = new URL(sendurl.toString());
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();
			//	String USER_AGENT = "Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Mobile Safari/535.19";

			con.setRequestMethod("GET");
			//con.setRequestProperty("User-Agent", USER_AGENT);

			int responseCode = con.getResponseCode();

		} catch (Exception e) {

		}

	}%>



