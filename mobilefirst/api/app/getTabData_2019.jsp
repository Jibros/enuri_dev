<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>
<%@ page import="com.enuri.util.common.ChkNull"%>
<%@ page import="java.text.*"%>

<%
	JSONObject outJSON = new JSONObject();
	String os = ChkNull.chkStr(request.getParameter("app"), "core");
	String version = ChkNull.chkStr(request.getParameter("version"), "0.0.0");
	
	String targetName = "";
	String targetPrefix = "";
	
	String server = request.getParameter("server");
	boolean isServer = !StringUtils.isEmpty(server) && server.equals("dev");
	
	if (version.length() > 5) {
		version = version.substring(0, 5);
	}
	
	if(os.equals("core")) {
		targetPrefix = "enuri_tab_";
		targetName = targetPrefix + version + ".json";
	} else if(os.equals("social")) {
		targetPrefix = "social_tab_";
		targetName = targetPrefix + version + ".json";
	}
	
	try{
		// 기본 데이터
		outJSON.put("HOTDEAL_PREURL", "http://img.enuri.info/images");
		outJSON.put("HOTDEAL", getHotDeal(version));
		outJSON.put("BUF_TAB", getBufferTab(version));
		
		JSONArray shopList = getJSONArrayfromFile("/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/http/json/shopMainLogo.json");
		JSONObject bestdeal = new JSONObject();
		JSONArray dealarr = new JSONArray();
		ArrayList<String> dealshoparr = new ArrayList<String>(); // 순서조정
		dealshoparr.add("536");
		dealshoparr.add("4027");
		dealshoparr.add("5910");
		dealshoparr.add("55");
		dealshoparr.add("806");
		dealshoparr.add("974");
		dealshoparr.add("47");
		dealshoparr.add("7857");
		for(int i =0; i < dealshoparr.size() ; i++) {
			for(int j =0; j < shopList.size() ; j++){
				JSONObject o = (JSONObject)shopList.get(j);
				if(o!=null){
					if(dealshoparr.get(i).equals(o.get("shop"))){
						JSONObject tempo = new JSONObject();
						tempo.put("title",o.get("name"));
						tempo.put("image_ios",o.get("bestdeal_img"));
						tempo.put("image_aos",o.get("bestdeal_img"));
						tempo.put("shopcode",o.get("shop"));
						tempo.put("dealtype",o.get("bestdeal_type"));
						dealarr.add(tempo);
						break;
					}
				}
			}
		}
		bestdeal.put("BestdealtabUrl","/mobilefirst/api/getBestDealGoods.jsp");
		bestdeal.put("BestdealtabJsonArr",dealarr);
		outJSON.put("BESTDEAL", bestdeal);
		
		outJSON.put("EVENT_TAB", getEventTab(version));
		outJSON.put("DDCATEGORY", getJSONObjectfromFile(getServletContext().getRealPath("/") + "/mobilefirst/api/app/app_category_info.json"));
		
		int verInt = 0;
		if (version.length() >= 5) {
			try {
				verInt = Integer.parseInt(version.substring(0, 1)) * 100 + Integer.parseInt(version.substring(2, 3)) * 10 + Integer.parseInt(version.substring(4, 5));
			} catch (Exception e) {
			
			}
		}
		
		if (verInt < 393) {
			outJSON.put("FOOTER_OBJ", getJSONObjectfromFile(getServletContext().getRealPath("/") + "/mobilefirst/http/json/footer_2020.json"));
		}else{
			outJSON.put("FOOTER_OBJ", getJSONObjectfromFile(getServletContext().getRealPath("/") + "/mobilefirst/http/json/footer_2021.json"));
		}
		
		
		if(targetName.length() == 0) {
			outJSON.put("TABS", new JSONArray());
			out.println(new JSONArray().toString()) ;
		} else {
			String jsonPath = getServletContext().getRealPath("/") + "/mobilefirst/http/json/apptab";
			String targetAbsPath = jsonPath + "/" + targetName;
			File file = new File(targetAbsPath);
			if(file.exists()) {
				if(isServer)
					outJSON.put("json_version", targetName);
				outJSON.put("TABS", getJSONArrayfromFile(targetAbsPath));
				
			} else {
				ArrayList<File> jsonList = getTabJSON(jsonPath, targetPrefix);
				
				//버전 역순으로 정렬
				Collections.sort(jsonList, new Comparator<File>(){
	           		@Override
	           	 	public int compare(File f1, File f2) {
	           	 		return f1.getName().compareTo(f2.getName());
	           	 	}
	        	});
				
				boolean isFind = false;
				if(!targetName.contains("0.0.0")) {
					double targetVersion = versionToDouble(version);
		        	
					for(int i=jsonList.size()-1; i>=0; i--) {
						File jsonFile = jsonList.get(i);
						String fileName = jsonFile.getName();
						String strVer = fileName.substring(fileName.lastIndexOf("_") + 1, fileName.lastIndexOf("."));
						
						isFind = versionToDouble(strVer) <= targetVersion;
						if(isFind) {
							outJSON.put("TABS", getJSONArrayfromFile(jsonPath + "/" + fileName));
							break;
						}
					}
				}
	        
				//기본 값 세팅 (가장 최신 버전)
				if(!isFind) {
					File jsonFile = jsonList.get(jsonList.size()-1);
					outJSON.put("TABS", getJSONArrayfromFile(jsonPath + "/" + jsonFile.getName()));
				}
			}
		}
	}

	catch(IndexOutOfBoundsException e) {

		System.out.println(e);

	}
	
	out.println(outJSON.toString());

%>

<%!

	public double versionToDouble(String version) {
	
		if (StringUtils.isEmpty(version))
			return 0;

		double value = 0;
		try {
			String[] splitVer = version.split("\\.");
			int magnification = 1;
			for(int i=splitVer.length -1; i>=0; i--) {
				value += magnification * Integer.valueOf(splitVer[i]);
				
				if(magnification == 1 && splitVer[i].length() > 1) {
					int div = (int)Math.pow(10, splitVer[i].length()-1);
					value = value * div * 0.01;
				}
				magnification *= 10;
			}
		} catch (Exception e){
			return 0;
		}
		
		return value;
	}
	
	public ArrayList<File> getTabJSON(String path, String prefix) {
		File folder = new File(path);
		ArrayList<File> jsonList = new ArrayList<File>();
		if (folder.exists()) {
			for(File file : folder.listFiles()) {
				if(file.isFile() && file.getName().startsWith(prefix)){
					jsonList.add(file);
				}
			}
		}

		return jsonList;
	}
	
	public JSONArray getJSONArrayfromFile(String filePath) {

		String news_data = "";
		StringBuilder news_buffer = new StringBuilder();

		try {
			InputStream inputStream = new FileInputStream(filePath);
			BufferedReader in = new BufferedReader(new InputStreamReader(inputStream, "utf-8"));
			while ((news_data = in.readLine()) != null) {
				news_buffer.append(news_data);
			}
			in.close();
			inputStream.close();

			JSONParser parser = new JSONParser();
			Object obj = parser.parse(news_buffer.toString());

			return (JSONArray) obj;
		} catch (Exception e) {

		}
		return null;
	}
	
	public JSONArray getHotDeal(String version) {
		JSONArray hotdealList = new JSONArray();
		
		JSONObject superdeal = new JSONObject();
		superdeal.put("logo","/mobilefirst/hotdeal/20160617/20160617_hotdeal_superdeal.png");
		superdeal.put("logo350","/mobilefirst/hotdeal/20190415/icon_main_mallbest_01.png");
		superdeal.put("title", "슈퍼딜");
		superdeal.put("deal", "/view/ls_logo/2019/Ap_logo_536_deal.png");
		superdeal.put("file", "superDeal");
		superdeal.put("shopcode", "536");
		superdeal.put("url", "/http/json/superDeal.json");
		superdeal.put("mall", "superdeal");
		superdeal.put("priority", 1);

		JSONObject allkill = new JSONObject();
		allkill.put("logo","/mobilefirst/hotdeal/20160617/20160617_hotdeal_allkill2.png");
		allkill.put("logo350","/mobilefirst/hotdeal/20190415/icon_main_mallbest_02.png");
		allkill.put("title", "올킬");
		allkill.put("deal", "/view/ls_logo/2019/Ap_logo_4027_deal.png");
		allkill.put("file", "allKill");
		allkill.put("shopcode", "4027");
		allkill.put("url", "/http/json/allKill.json");
		allkill.put("mall", "allkill");
		allkill.put("priority", 2);
		
		JSONObject shockingdeal = new JSONObject();
		shockingdeal.put("logo","/mobilefirst/hotdeal/20160617/20160617_hotdeal_shocking.png");
		shockingdeal.put("logo350","/mobilefirst/hotdeal/20190415/icon_main_mallbest_03.png");
		shockingdeal.put("title", "쇼킹딜");
		shockingdeal.put("deal","/view/ls_logo/2019/Ap_logo_5910_deal.png");
		shockingdeal.put("file", "shocking");
		shockingdeal.put("shopcode", "5910");
		shockingdeal.put("url", "/http/json/shocking.json");
		shockingdeal.put("mall", "shocking");
		shockingdeal.put("priority", 3);
		
		JSONObject tmon = new JSONObject();
		tmon.put("logo","/mobilefirst/hotdeal/20160617/20160617_hotdeal_tmon.png");
		tmon.put("logo350","/mobilefirst/hotdeal/20220105/icon_main_mallbest_04.png");
		tmon.put("title", "티몬");
		tmon.put("deal", "/view/ls_logo/202002/Ap_logo_6641.png");
		tmon.put("file", "tmon");
		tmon.put("shopcode", "6641");
		tmon.put("url", "/http/json/tmon.json");
		tmon.put("mall", "tmon");
		tmon.put("priority", 4);
		
		JSONObject wemake = new JSONObject();
		wemake.put("logo","/mobilefirst/hotdeal/20170330/20170330_hotdeal_wemake.png");
		wemake.put("logo350","/mobilefirst/hotdeal/20220105/icon_main_mallbest_05.png");
		wemake.put("title", "위메프");
		wemake.put("deal", "/view/ls_logo/2019/Ap_logo_6508.png");
		wemake.put("file", "wemake");
		wemake.put("shopcode", "6508");
		wemake.put("url", "/http/json/wemake.json");
		wemake.put("mall", "wemake");
		wemake.put("priority", 5);
		
		JSONObject ssendeal = new JSONObject();
		ssendeal.put("logo","/mobilefirst/hotdeal/20160617/20170228_hotdeal_ssendeal.png");
		ssendeal.put("logo350","/mobilefirst/hotdeal/20190415/icon_main_mallbest_06.png");
		ssendeal.put("title", "쎈딜");
		ssendeal.put("deal", "/view/ls_logo/2019/Ap_logo_55_deal.png");
		ssendeal.put("file", "ssendeal");
		ssendeal.put("shopcode", "55");
		ssendeal.put("url", "/http/json/ssenDeal.json");
		ssendeal.put("mall", "ssendeal");
		ssendeal.put("priority", 6);
		
		hotdealList.add(superdeal);
		hotdealList.add(allkill);
		hotdealList.add(shockingdeal);
		hotdealList.add(tmon);
		hotdealList.add(wemake);
		hotdealList.add(ssendeal);

		return hotdealList;
	}
	
	public JSONObject getBufferTab(String version) {
		JSONObject bufTab = new JSONObject();

		//3.3.0 이하
		double ver = versionToDouble(version);
		if(ver > 0 && ver <= 330) {
			bufTab.put("BUF_TAB_LINK_AOS", "market://details?id=com.enuri.deal&referrer=utm_source%3Denuri%26utm_medium%3Dhiddentab_click%26utm_campaign%3Dhiddentab_20170510");
			bufTab.put("BUF_TAB_COLOR_AOS", "E4E4E4");
			bufTab.put("BUF_TAB_IMAGE_IOS", "/images/mobilefirst/extra_tab/buftab/extratab_bg_20170510");
			bufTab.put("BUF_TAB_COLOR_IOS", "E4E4E4");
			bufTab.put("BUF_TAB_LINK_IOS", "https://itunes.apple.com/kr/app/id944887654?freetoken=outlink");
			bufTab.put("BUF_TAB_IMAGE_AOS", "/images/mobilefirst/extra_tab/buftab/extratab_bg_20170510");
		} else if(ver > 0 && ver <= 400){ //4.0.0 이하에서는 이벤트페이지, 이상부터는 마이이클럽 페이지
			bufTab.put("BUF_TAB_LINK_AOS", "http://m.enuri.com/mobilefirst/index.jsp?freetoken=main_tab|event");
			bufTab.put("BUF_TAB_COLOR_AOS", "E4E4E4");
			bufTab.put("BUF_TAB_IMAGE_IOS", "/images/mobilefirst/extra_tab/buftab/extratab_bg_20191014");
			bufTab.put("BUF_TAB_COLOR_IOS", "E4E4E4");
			bufTab.put("BUF_TAB_LINK_IOS", "http://m.enuri.com/mobilefirst/index.jsp?freetoken=main_tab|event");
			bufTab.put("BUF_TAB_IMAGE_AOS", "/images/mobilefirst/extra_tab/buftab/extratab_bg_20180313");
		} else {
			bufTab.put("BUF_TAB_IMAGE_AOS", "/images/mobilefirst/extra_tab/buftab/extratab_bg_20220321");
			bufTab.put("BUF_TAB_LINK_AOS", "http://m.enuri.com/mobilefirst/index.jsp?freetoken=main_tab|myeclub");
			bufTab.put("BUF_TAB_COLOR_AOS", "E4E4E4");
			bufTab.put("BUF_TAB_IMAGE_IOS", "/images/mobilefirst/extra_tab/buftab/extratab_bg_20220321");
			bufTab.put("BUF_TAB_COLOR_IOS", "E4E4E4");
			bufTab.put("BUF_TAB_LINK_IOS", "http://m.enuri.com/mobilefirst/index.jsp?freetoken=main_tab|myeclub");
		}
		
		// 3.3.8 이상에서 추가 됨
		bufTab.put("BUF_TAB_IMAGE_PREURL", "http://img.enuri.info");
		
		return bufTab;
	}
	
	public JSONObject getJSONObjectfromFile(String filePath) {

		String news_data = "";
		StringBuilder news_buffer = new StringBuilder();

		try {
			InputStream inputStream = new FileInputStream(filePath);
			BufferedReader in = new BufferedReader(new InputStreamReader(inputStream, "utf-8"));
			while ((news_data = in.readLine()) != null) {
				news_buffer.append(news_data);
			}
			in.close();
			inputStream.close();

			JSONParser parser = new JSONParser();
			Object obj = parser.parse(news_buffer.toString());

			return (JSONObject) obj;
		} catch (Exception e) {

		}
		return null;
	}
	
	public JSONArray getEventTab(String version) {
		JSONArray arr = new JSONArray();
		try{
			JSONObject event1 = new JSONObject();
			event1.put("link", "http://m.enuri.com/mobilefirst/evt/visit_event.jsp");
			event1.put("image", "http://img.enuri.info/images/mobilefirst/planlist/event_image/20190404/icon_main_eve_01.png");
			event1.put("title", "출석체크");
			arr.add(event1);
			
			JSONObject event2 = new JSONObject();
			//2020100500시 부터 100원딜 삭제됨
			if (isTimeUnder(2020100500)) {
			    event2.put("link", "http://m.enuri.com/mobilefirst/evt/firstbuy100_event.jsp?freetoken=event");
			} else {
				event2.put("link", "http://m.enuri.com/mobilefirst/evt/welcome_event.jsp?freetoken=event");
			}
			event2.put("image", "http://img.enuri.info/images/mobilefirst/planlist/event_image/20200818/icon_main_eve_02.png");
			event2.put("title", "WELCOME");
			arr.add(event2);
			
			JSONObject even3 = new JSONObject();
			even3.put("link", "http://m.enuri.com/mobilefirst/evt/smart_benefits.jsp?freetoken=event");
			even3.put("image", "http://img.enuri.info/images/mobilefirst/planlist/event_image/20190404/icon_main_eve_03.png");
			even3.put("title", "구매혜택");
			arr.add(even3);
			
			JSONObject even4 = new JSONObject();
			even4.put("link", "http://m.enuri.com/mobilefirst/evt/buy_event.jsp?tab=1");
			even4.put("image", "http://img.enuri.info/images/mobilefirst/planlist/event_image/20190404/icon_main_eve_04.png");
			even4.put("title", "VIP");
			arr.add(even4);
			
			return arr;
		}catch(Exception e){
			
		}
		return arr;
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