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
	
	
	// 기본 데이터
	outJSON.put("HOTDEAL_PREURL", "http://img.enuri.info/images");
	outJSON.put("HOTDEAL", getHotDeal(version));
	outJSON.put("BUF_TAB", getBufferTab(version));
	
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
		superdeal.put("title", "슈퍼딜");
		superdeal.put("deal", "/view/ls_logo/2013/Ap_logo_536_deal1.png");
		superdeal.put("file", "superDeal");
		superdeal.put("shopcode", "536");
		superdeal.put("url", "/http/json/superDeal.json");
		superdeal.put("mall", "superdeal");

		JSONObject allkill = new JSONObject();
		allkill.put("logo","/mobilefirst/hotdeal/20160617/20160617_hotdeal_allkill2.png");
		allkill.put("title", "올킬");
		allkill.put("deal", "/view/ls_logo/2013/Ap_logo_4027_deal1.png");
		allkill.put("file", "allKill");
		allkill.put("shopcode", "4027");
		allkill.put("url", "/http/json/allKill.json");
		allkill.put("mall", "allkill");

		JSONObject shockingdeal = new JSONObject();
		shockingdeal.put("logo","/mobilefirst/hotdeal/20160617/20160617_hotdeal_shocking.png");
		shockingdeal.put("title", "쇼킹딜");
		shockingdeal.put("deal","/view/ls_logo/2013/Ap_logo_5910_deal1.png");
		shockingdeal.put("file", "shocking");
		shockingdeal.put("shopcode", "5910");
		shockingdeal.put("url", "/http/json/shocking.json");
		shockingdeal.put("mall", "shocking");

		JSONObject tmon = new JSONObject();
		tmon.put("logo","/mobilefirst/hotdeal/20200220/20200226_hotdeal_tmon.png");
		tmon.put("title", "티몬");
		tmon.put("deal", "/view/ls_logo/202002/Ap_logo_6641_old.png");
		tmon.put("file", "tmon");
		tmon.put("shopcode", "6641");
		tmon.put("url", "/http/json/tmon.json");
		tmon.put("mall", "tmon");

		JSONObject wemake = new JSONObject();
		wemake.put("logo","/mobilefirst/hotdeal/20170330/20170330_hotdeal_wemake.png");
		wemake.put("title", "위메프");
		wemake.put("deal", "/view/ls_logo/2013/Ap_logo_6508_deal1.png");
		wemake.put("file", "wemake");
		wemake.put("shopcode", "6508");
		wemake.put("url", "/http/json/wemake.json");
		wemake.put("mall", "wemake");

		JSONObject ssendeal = new JSONObject();
		ssendeal.put("logo","/mobilefirst/hotdeal/20160617/20170228_hotdeal_ssendeal.png");
		ssendeal.put("title", "쎈딜");
		ssendeal.put("deal", "/view/ls_logo/2013/Ap_logo_55_deal.png");
		ssendeal.put("file", "ssendeal");
		ssendeal.put("shopcode", "55");
		ssendeal.put("url", "/http/json/ssenDeal.json");
		ssendeal.put("mall", "ssendeal");

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
			bufTab.put("BUF_TAB_IMAGE_AOS", "/images/mobilefirst/extra_tab/buftab/extratab_bg_20180313");
			bufTab.put("BUF_TAB_LINK_AOS", "http://m.enuri.com/mobilefirst/index.jsp?freetoken=main_tab|myeclub");
			bufTab.put("BUF_TAB_COLOR_AOS", "E4E4E4");
			bufTab.put("BUF_TAB_IMAGE_IOS", "/images/mobilefirst/extra_tab/buftab/extratab_bg_20191014");
			bufTab.put("BUF_TAB_COLOR_IOS", "E4E4E4");
			bufTab.put("BUF_TAB_LINK_IOS", "http://m.enuri.com/mobilefirst/index.jsp?freetoken=main_tab|myeclub");
		}
		
		// 3.3.8 이상에서 추가 됨
		bufTab.put("BUF_TAB_IMAGE_PREURL", "http://img.enuri.info");
		
		return bufTab;
	}
%>