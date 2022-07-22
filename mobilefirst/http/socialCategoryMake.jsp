<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>
<%@page import="java.net.*"%>
<%

	final String CATE_CODE_SHOPPING = "A02";
	final String CATE_CODE_LOCATION = "A0101";
	final String CATE_CODE_TOUR 	= "A03";
	final String CATE_CODE_CULTURE 	= "A04";
	
	String SERVER_TARGET = "m";
	String server =	StringUtils.defaultString(request.getParameter("server"));
	if(server != null && server.equals("dev") ){
		SERVER_TARGET = "dev";
	}

	String DEPART_URL = "http://" + SERVER_TARGET + ".enuri.com";
	String BASE_URL = DEPART_URL + "/mobilefirst";

	final String BIG_CATEGEORY_URL = BASE_URL + "/api/deal/dealCate.json";

	JSONObject bigCateJson = getJSONObjectfromHttp(BIG_CATEGEORY_URL);

	JSONArray bigCateList = (JSONArray) bigCateJson.get("cate");

	for(int i=0; i<bigCateList.size(); i++) {
		JSONObject curBigCate = (JSONObject) bigCateList.get(i);
		
		String cateCode = (String) curBigCate.get("catecode");
		
		String allName = cateCode.equals(CATE_CODE_SHOPPING) ? "쇼핑전체" : "전체";
		
		String imgUrl = getBigCategoryIconUrl(cateCode);
		
		String faname =  getBigCategoryFaname(cateCode);
		
		curBigCate.put("icon_url", imgUrl);
		curBigCate.put("faname", faname);
		
		JSONArray childList = (JSONArray) curBigCate.get("list");
		JSONObject all = new JSONObject();
			
		all.put("codename", allName);
		all.put("code", cateCode);
		all.put("pcode", cateCode);
		
		childList.add(0, all);
		

		if(cateCode.equals(CATE_CODE_SHOPPING)){	
			for(int j=0; j<childList.size(); j++){
				JSONObject childItem = (JSONObject) childList.get(j);
				
				if(j == 0) {
					String childName = "전체";
					
					childItem.put("ic_aos", andIconMap.get(childName));
					childItem.put("ic_ios_2", iosIconMap.get(childName)[0]);
					childItem.put("ic_ios_3", iosIconMap.get(childName)[1]);
					
					continue;
				}
				
				String childCode = (String)childItem.get("code");
				if(andIconMap.containsKey(childCode)){
					childItem.put("ic_aos", andIconMap.get(childCode));
					childItem.put("ic_ios_2", iosIconMap.get(childCode)[0]);
					childItem.put("ic_ios_3", iosIconMap.get(childCode)[1]);
				}
			}
		}

	}

	out.println(bigCateList.toString());
	
%>






<%!

	static String TEST = "hello_World";
	static final String CATE_CODE_SHOPPING = "A02";
	static final String CATE_CODE_LOCATION = "A0101";
	static final String CATE_CODE_TOUR 	= "A03";
	static final String CATE_CODE_CULTURE 	= "A04";
	static final String IMAGE_HOTDEAL_URL = "/images/mobilefirst/hotdeal";
	static final String imgCategoryUrl = IMAGE_HOTDEAL_URL + "/category";

	static HashMap<String, String> andIconMap = getShoppingChildIconMap();
	static HashMap<String, String[]> iosIconMap = convertToIosImgMap(andIconMap);
	
	public String getBigCategoryIconUrl(String bigCateCode){
	
		String iconUrl = "";
		
		if(bigCateCode.equals(CATE_CODE_SHOPPING)){
		
			iconUrl = imgCategoryUrl + "/activity/category_tit01.png";
			
		} else if(bigCateCode.equals(CATE_CODE_LOCATION)){
		
			iconUrl = imgCategoryUrl + "/activity/category_tit02.png";
			
		} else if(bigCateCode.equals(CATE_CODE_TOUR)){
		
			iconUrl = imgCategoryUrl + "/activity/category_tit03.png";
			
		} else if(bigCateCode.equals(CATE_CODE_CULTURE)){
		
			iconUrl = imgCategoryUrl + "/activity/category_tit04.png";
			
		}
		
		return iconUrl;
	}
	
	
	public static HashMap<String, String> getShoppingChildIconMap(){
	
		HashMap<String, String> iconUrlMap = new HashMap<String, String>();
		iconUrlMap.put("전체", 	imgCategoryUrl + "/activity/category01.png");		//	전체
		iconUrlMap.put("A0201", imgCategoryUrl + "/activity/category02.png");		//	의류
		iconUrlMap.put("A0202", imgCategoryUrl + "/activity/category03.png");		//	패션/잡화
		iconUrlMap.put("A0203", imgCategoryUrl + "/activity/category08.png");		//	스포츠/레저
		
		iconUrlMap.put("A0204", imgCategoryUrl + "/activity/category04.png");		//	뷰티
		iconUrlMap.put("A0205", imgCategoryUrl + "/activity/category06.png");		//	식품/건강
		iconUrlMap.put("A0206", imgCategoryUrl + "/activity/category07.png");		//	생활/주방
		iconUrlMap.put("A0207", imgCategoryUrl + "/activity/category05.png");		//	출산/유아동
		
		iconUrlMap.put("A0208", imgCategoryUrl + "/activity/category09.png");		//	홈데코
		iconUrlMap.put("A0209", imgCategoryUrl + "/activity/category10.png");		//	디지털
		iconUrlMap.put("A0210", imgCategoryUrl + "/activity/category12.png");		//	온라인/기타
		iconUrlMap.put("A0211", imgCategoryUrl + "/activity/category11.png");		//	문구/도서

		return iconUrlMap;
	}
	
	public String getBigCategoryFaname(String bigCateCode){
		
		String faname = "";
		
		if(bigCateCode.equals(CATE_CODE_SHOPPING)){
			faname = "shopping";
		} else if(bigCateCode.equals(CATE_CODE_LOCATION)){
			faname = "region";
		} else if(bigCateCode.equals(CATE_CODE_TOUR)){
			faname = "travel";
		} else if(bigCateCode.equals(CATE_CODE_CULTURE)){
			faname = "culture";
		}
		return faname;
	}
	
	public static HashMap<String, String[]> convertToIosImgMap(HashMap<String, String> andMap){
	
		HashMap<String, String[]> iosMap = new HashMap<String, String[]>();
		for(String key : andMap.keySet()){
			
			String andVal = andMap.get(key);
			
			String[] iosVal = new String[2];
			iosVal = convertIosUrl(andVal);
			
			iosMap.put(key, iosVal);
			//System.out.println("put : " + iosVal[0]);
		}
		
		return iosMap;
	}

	
	public static String[] convertIosUrl(String baseUrl){
		String[] convertedUrl = {"", ""};
		
		int extensionIdx = baseUrl.lastIndexOf(".");
		
		if( extensionIdx >= 0 ){
			String tempStartString = baseUrl.substring(0, extensionIdx);
			String tempEndString = baseUrl.substring(extensionIdx, baseUrl.length());
			
			convertedUrl[0] = tempStartString + "@2x" + tempEndString;;
			convertedUrl[1] = tempStartString + "@3x" + tempEndString;;
		}
		
		return convertedUrl;
	}

	public JSONObject getJSONObjectfromHttp(String strurl) {
		try {
			String recv;
			StringBuffer recvbuff = new StringBuffer();
			URL jsonpage = new URL(strurl);
			URLConnection urlcon = jsonpage.openConnection();
			BufferedReader buffread = new BufferedReader(new InputStreamReader(urlcon.getInputStream(), "utf-8"));
			while ((recv = buffread.readLine()) != null)
				recvbuff.append(recv);
			buffread.close();

			JSONParser parser = new JSONParser();
			Object obj = parser.parse(recvbuff.toString());
			return (JSONObject) obj;
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
			BufferedReader buffread = new BufferedReader(new InputStreamReader(urlcon.getInputStream(), "utf-8"));
			while ((recv = buffread.readLine()) != null)
				recvbuff.append(recv);
			buffread.close();

			JSONParser parser = new JSONParser();
			Object obj = parser.parse(recvbuff.toString());
			return (JSONArray) obj;
		} catch (Exception e) {

		}
		return null;
	}

%>