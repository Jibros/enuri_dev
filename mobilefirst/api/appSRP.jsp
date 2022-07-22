<%@ page language="java" contentType="text/html; charset=UTF-8"
				pageEncoding="UTF-8"%>
<%@ page import="com.enuri.util.common.*"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="com.enuri.bean.main.Component_Proc"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@page import="java.net.*"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%//플러스 링크 ip 검사 해서 따로 생성 필요f

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


			String cate = ConfigManager.RequestStr(request, "cate", "");
			String pType = ConfigManager.RequestStr(request, "pType", "");
			String gb1 = ConfigManager.RequestStr(request, "gb1", "");
			String gb2 = ConfigManager.RequestStr(request, "gb2", "");
			String deviceType = ConfigManager.RequestStr(request, "deviceType", "");
			String procType = ConfigManager.RequestStr(request, "procType", "");

			String constrain = ConfigManager.RequestStr(request, "constrain", "");
			String ca_arr_code = ConfigManager.RequestStr(request, "ca_arr_code", "");
			String order = ConfigManager.RequestStr(request, "order", "");
			String sponsor_modelno_type = ConfigManager.RequestStr(request, "sponsor_modelno_type", "");
			String openexpectflag = ConfigManager.RequestStr(request, "openexpectflag", "");
			String ca_arr_lcode = ConfigManager.RequestStr(request, "ca_arr_lcode", "");
			String mallcntAll = ConfigManager.RequestStr(request, "mallcntAll", "");
			String IsDeliverySumPrice = ConfigManager.RequestStr(request, "IsDeliverySumPrice", "");
			String jobcode = ConfigManager.RequestStr(request, "jobcode", "");
			String m_price = ConfigManager.RequestStr(request, "m_price", "");
			String start_price = ConfigManager.RequestStr(request, "start_price", "");
			String end_price = ConfigManager.RequestStr(request, "end_price", "");
			String brand_arr = ConfigManager.RequestStr(request, "brand_arr", "");
			String factory_arr = ConfigManager.RequestStr(request, "factory_arr", "");
			String spec = ConfigManager.RequestStr(request, "spec", "");
			spec = spec.toLowerCase();
			String sel_spec = ConfigManager.RequestStr(request, "sel_spec", "");
			String random_seq = ConfigManager.RequestStr(request, "random_seq", "");
			String pageNum = ConfigManager.RequestStr(request, "pageNum", "");
			String pageGap = ConfigManager.RequestStr(request, "pageGap", "300");

			String tabType = ConfigManager.RequestStr(request, "tabType", "");

			String keyword = removenewline(ConfigManager.RequestStr(request, "keyword", "노트북"));

			String in_keyword = removenewline(ConfigManager.RequestStr(request, "in_keyword", ""));
			String key = ConfigManager.RequestStr(request, "key", "");

			String brand = ConfigManager.RequestStr(request, "brand", "");
			String factory = ConfigManager.RequestStr(request, "factory", "");
			String prtmodelno = ConfigManager.RequestStr(request, "prtmodelno", "");

			String sponsorList = ConfigManager.RequestStr(request, "sponsorList", "");
			String infoAdList = ConfigManager.RequestStr(request, "infoAdList", "");

			String szCategory = ConfigManager.RequestStr(request, "szCategory", "");
			String ad_command = ConfigManager.RequestStr(request, "ad_command", keyword);
			String ad_command2 = ConfigManager.RequestStr(request, "ad_command2", "");
			String referrer = ConfigManager.RequestStr(request, "referrer", "");
			String url = ConfigManager.RequestStr(request, "url", "search.jsp");
			//String url = ConfigManager.RequestStr(request, "url", "http://m.enuri.com/mobilefirst/search.jsp?keyword="+keyword);
			String strCh = ConfigManager.RequestStr(request, "strCh", "m_enuri.ch4");
			String ncpc = ConfigManager.RequestStr(request, "ncpc", "Y").toUpperCase();
			String app_type = ConfigManager.RequestStr(request, "app_type", "N");

			String strversion = ConfigManager.RequestStr(request, "version", "0.0.0");
			//플러스 링크 ip 검사 해서 따로 생성 필요
			boolean fDevServer = request.getServerName().equals("dev.enuri.com");
			
			//20200513 ios 땅콩 달고나 모든 정렬시 일반 상품 안나오는경우 있어 수정함
			//if (key.equals("minprice3"))
			//{
				tabType = "0";
			//}
		//	out.print(request.getHeader( "User-Agent" ));

			if (Integer.parseInt(pageGap) > 50)
				out.print("");
			else {
				int version = 0;
				if (strversion.length() >= 5) {
					try {
						version = Integer.parseInt(strversion.substring(0, 1)) * 100 + Integer.parseInt(strversion.substring(2, 3)) * 10
								+ Integer.parseInt(strversion.substring(4, 5));
					} catch (Exception e) {
					}
				}

				// 	JSONObject obj;
				// 				obj = getJSONObjectfromHttp("http://dev.enuri.com/lsv2016/ajax/getLinkageKeyword_ajax.jsp?procType=1&keyword=nike");
				// 				out.println(obj.toString());

				String childCate = "";
				String enuri = "http://localhost";
				JSONObject obj = new JSONObject();
				{
					obj.put("navercpcA", "Y");
					obj.put("ebaycpcA", "Y");
					obj.put("navercpcI", "Y");
					obj.put("ebaycpcI", "Y");
					if (version >= 330) {


						obj.put("search_type_c_d", new JSONObject(getfromHttp(true, enuri + "/mobilefirst/api/search_type.jsp?keyword=" + URLEncoder.encode(keyword, "UTF-8"))));

					}

					obj.put("v", version);
					obj.put("a", app_type);
					obj.put("p", pageNum);
					if (version >= 325) {

						obj.put("getCateListSearchType_ajax",
								new JSONObject(getfromHttp(true, 
										enuri + "/lsv2016/ajax/getCateListSearchType_ajax.jsp?keyword=" + URLEncoder.encode(keyword, "UTF-8") + "&in_keyword=")));
										//"http://m.enuri.com/lsv2016/ajax/getCateListSearchType_ajax.jsp?keyword=" + URLEncoder.encode(keyword, "UTF-8") + "&in_keyword=")));

						//안드로이드 srp2에서 제조사 브랜드 여부를  getCateListSearchType_ajax 가져오는 타이밍에 알아야 되서 가져왔다
						if ((app_type.equals("A") && pageNum.equals("1")) || (app_type.equals("I") && version>=360)) {

							obj.put("getSearchInfoList_ajax",
									new JSONObject(getfromHttp(true,
											enuri + 
											"/lsv2016/ajax/getSearchInfoList_ajax.jsp?cate=" + cate + "&keyword=" + URLEncoder.encode(keyword, "UTF-8"))));
										    //"http://m.enuri.com/lsv2016/ajax/getSearchInfoList_ajax.jsp?cate=" + cate + "&keyword=" + URLEncoder.encode(keyword, "UTF-8"))));

						}
					}
					try {

						obj.put("getLinkageKeyword_ajax",
								new JSONObject(getfromHttp(true,
										enuri + "/lsv2016/ajax/getLinkageKeyword_ajax.jsp?procType=" + procType + "&keyword=" + URLEncoder.encode(keyword, "UTF-8"))));

					} catch (Exception e) {

					}

					if (cate.length() >= 4) {
						if (version < 325) {
							childCate = cate.substring(0, 4);

							obj.put("getSearchCateList_ajax",
									new JSONObject(getfromHttp(true,
											enuri + "/lsv2016/ajax/getSearchCateList_ajax.jsp?cate=" + cate + "&keyword=" + URLEncoder.encode(keyword, "UTF-8"))));


						}
					} else {

						obj.put("getSearchManageCond_ajax",
								new JSONObject(getfromHttp(true, enuri + "/lsv2016/ajax/getSearchManageCond_ajax.jsp?procType=1&keyword=" + URLEncoder.encode(keyword, "UTF-8"))));


					}

					{
					
						StringBuffer sb = new StringBuffer(enuri);
						sb.append("/lsv2016/ajax/getSearchGoods_ajax.jsp");
						sb.append("?IsMobileApp=Y");
						sb.append("&appVersion=");						
						sb.append(version);
						sb.append("&in_keyword=");						
						sb.append(URLEncoder.encode(in_keyword, "UTF-8"));
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
						sb.append("&m_price=");
						sb.append(m_price);
						
						
						obj.put("start_price", start_price);
						obj.put("end_price", end_price);
						
						
						
						sb.append("&start_price=");
						sb.append(start_price);
						sb.append("&end_price=");
						sb.append(end_price);
						sb.append("&brand_arr=");
						sb.append(URLEncoder.encode(brand_arr, "UTF-8"));
						sb.append("&factory_arr=");
						sb.append(URLEncoder.encode(factory_arr, "UTF-8"));
						sb.append("&keyword=");
						sb.append(URLEncoder.encode(keyword, "UTF-8"));
						sb.append("&brand=");
						sb.append(URLEncoder.encode(brand, "UTF-8"));
						sb.append("&factory=");
						sb.append(URLEncoder.encode(factory, "UTF-8"));
						sb.append("&spec=");
						sb.append(URLEncoder.encode(spec, "UTF-8"));
						sb.append("&deviceType=2");
						sb.append("&mobileAppAdult=Y");
						sb.append("&pageNum=");
						sb.append(pageNum);
						sb.append("&pageGap=");
						sb.append(pageGap);
						sb.append("&tabType=");
						sb.append(tabType);
						sb.append("&cate=");
						sb.append(cate);
						sb.append("&key=");
						sb.append(URLEncoder.encode(key, "UTF-8"));
						sb.append("&IsDeliverySumPrice=");
						sb.append(URLEncoder.encode(IsDeliverySumPrice, "UTF-8"));

						JSONObject list = new JSONObject(getfromHttpHeader(true, sb.toString(), ip, userAgent));

						obj.put("getSearchGoods_ajax", list);
					//	obj.put("getSearchGoods_ajaxapi", sb.toString());
						boolean PowerShoppingCheck = false;
						try{
							JSONArray arrSrpModelList = list.getJSONArray("srpModelList");
							if(arrSrpModelList.length() >  0){
								String cacode = arrSrpModelList.getJSONObject(0).getString("strCa_code");							
								if(cacode != null && cacode.length()>2){
									JSONObject shGoods = new JSONObject(getfromFile(true, "/was/lena/1.3/depot/lena-application/ROOT/lsv2016/category_type.json"));
									String preCaCode = cacode.substring(0, 2);
									String WhatGoods = shGoods.getString(preCaCode);
									if(WhatGoods.equals("SG")){
										PowerShoppingCheck = true;
										obj.put("POWERSHOPPING", "Y");
									}
								}
							}
						}catch(Exception e)
						{
							
						}
						if(PowerShoppingCheck == false)
						{
							obj.put("POWERSHOPPING", "N");
						}
					}
					
					
					
					
					
					obj.put("banner_list", new JSONObject(getfromFile(true, "/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/http/json/banner_list.json")));

					/*
					최윤정 201912
					중고차 카드 3.5.9 버전 추가
					배너는 바뀌지 않는다
					*/
				/* 	if((version >= 359 && pageNum.equals("1") && app_type.equals("A"))||(version >= 360 && pageNum.equals("1") && app_type.equals("I")) ){
						try{
							//링크 만들기
							String donwloadLink = "http://localhost/lsv2016/ajax/getCarSearch_ajax.jsp?keyword="+URLEncoder.encode(keyword, "UTF-8")+"&pageNum=1&pageGap=10&sort=1&IsMobileApp=Y&spm_cd=9002";
							//링크 다운로드 받아  JSONData 만들기
							JSONObject rebornCarJsonData = new JSONObject(getfromHttp(true, donwloadLink));

							//데이터가 있는지 확인
							boolean fLoad = false;
							if(rebornCarJsonData.has("hits")){
								if(rebornCarJsonData.getJSONObject("hits").has("total")){
									if(rebornCarJsonData.getJSONObject("hits").getJSONObject("total").has("value")){
										if(rebornCarJsonData.getJSONObject("hits").getJSONObject("total").getInt("value")>0){
											fLoad = true;
										}
									}
								}
							}
						
						 	if(fLoad){
						 		boolean isDev = request.getServerName().contains("dev.enuri.com");							 		
							 	String link = "http://"+(isDev?"dev":"m")+".enuri.com/enuricar/m/list.jsp?freetoken=reborncar";
								JSONObject reborn = new JSONObject();
								reborn.put("title","프리미엄 중고차");
								reborn.put("link",link);
								reborn.put("freetoken","freetoken=outbrowser");
								reborn.put("bridge","http://"+(isDev?"dev":"m")+".enuri.com/move/Redirect_resellcar.jsp?gd_cd=%s&url=%s");
								reborn.put("list",rebornCarJsonData);
								
								
								JSONObject banner = new JSONObject();    	
						    	JSONArray arr =  new JSONArray(getfromHttp(false,"http://ad-api.enuri.info/enuri_M/m_main/MR1/bundle?bundlenum=10"));    			
						    	if(arr != null && arr.length() > 0){
						    		try{
							    		JSONObject bannerJson = arr.getJSONObject(0);
							    		banner.put("link",bannerJson.getString("JURL1"));
							    		banner.put("img",bannerJson.getString("IMG1"));
						    		}catch(Exception e){
						    			banner.put("link","http://"+(isDev?"dev":"m")+".enuri.com/enuricar/m/list.jsp?freetoken=reborncar");
						        		banner.put("img","http://storage.enuri.info/car/appbanner/app_bnr_reborn_main_20200326.png");	
						    		}
						    	}else {
						    		banner.put("link","http://"+(isDev?"dev":"m")+".enuri.com/enuricar/m/list.jsp?freetoken=reborncar");
						    		banner.put("img","http://storage.enuri.info/car/appbanner/app_bnr_reborn_main_20200326.png");
						    	}    	
								reborn.put("ad",banner);
								obj.put("reborn_car",reborn);
						 	}
						}catch(Exception e){
						//	obj.put("reborn_caraadda",e.toString());
						}
					} */

					if ((app_type.equals("A") && pageNum.equals("1") && version >= 345)||(app_type.equals("I") && pageNum.equals("1") && version >= 360)) {

						obj.put("brand_thema",
								new JSONObject(getfromHttp(true, enuri + "/lsv2016/ajax/getBrandTheme_ajax.jsp?random_seq=319&keyword=" + URLEncoder.encode(keyword, "UTF-8")
										+ "&channel=m")));

					}

					if (cate.length() > 0 && pageNum.equals("1") && ncpc.equals("Y")) {
						if (!(app_type.equals("A") && version >= 325)) {

							if(version < 360)
							{
								String hostName =  "http://localhost";
								StringBuffer sb = new StringBuffer(hostName);
								sb.append("/mobilenew/ajax/getSponsorLink_json.jsp");
								sb.append("?cate=");
								sb.append(cate);
								sb.append("&szCategory=");
								sb.append(szCategory);
								sb.append("&ad_command=");
								sb.append(URLEncoder.encode(ad_command, "UTF-8"));
								sb.append("&ad_command2=");
								sb.append(URLEncoder.encode(ad_command2, "UTF-8"));
								sb.append("&referrer=");
								sb.append(URLEncoder.encode(referrer, "UTF-8"));
								sb.append("&url=");
								sb.append(URLEncoder.encode(url, "UTF-8"));
								sb.append("&strCh=");
								sb.append(URLEncoder.encode(strCh, "UTF-8"));
	
								obj.put("getSponsorLink_json", new JSONObject(getfromHttp(true, sb.toString())));
							
							}

						}
					}
				}
				out.print(obj);
			}%>



<%!public String getfromHttpHeader(boolean isJSONObject, String strurl, String ip, String userAgent) {
	String temp = null;
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

		temp = new String(arBytes, "UTF-8").trim();

	} catch (Exception e) { //return "{\"error\":\""+e.toString()+"\"}";
	}
	if (temp == null || temp.length() <= 0) {
		if (isJSONObject)
			return "{}";
		else
			return "[]";
	} else {
		if (isJSONObject) {
			if (temp.startsWith("{"))
				return temp;
			else
				return "{}";
		} else

			return temp;
	}

}public String getfromHttp(boolean isJSONObject, String strurl) {
		String temp = null;
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

			temp = new String(arBytes, "UTF-8").trim();

		} catch (Exception e) { //return "{\"error\":\""+e.toString()+"\"}";
		}
		if (temp == null || temp.length() <= 0) {
			if (isJSONObject)
				return "{}";
			else
				return "[]";
		} else {
			if (isJSONObject) {
				if (temp.startsWith("{"))
					return temp;
				else
					return "{}";
			} else

				return temp;
		}

	}

	public String getfromFile(boolean isJSONObject, String filePath) {

		InputStream inputStream = null;

		String temp = null;
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
			temp = new String(arBytes, "UTF-8").trim();
		} catch (Exception e) {

		}

		if (temp == null || temp.length() <= 0) {
			if (isJSONObject)
				return "{}";
			else
				return "[]";
		} else {
			if (isJSONObject) {
				if (temp.startsWith("{"))
					return temp;
				else
					return "{}";
			} else

				return temp;
		}
	}

	public String removenewline(String desc) {
		char buf[] = desc.toCharArray();
		char buf2[] = new char[buf.length];
		int cnt = 0;
		for (int i = 0; i < buf.length; i++) {

			if (buf[i] != '\"') {
				if (!((int) buf[i] == 10 || (int) buf[i] == 13))
					buf2[cnt++] = buf[i];

				else
					buf2[cnt++] = (char) 32;
			}
		}

		return new String(buf2).trim();
	}%>
