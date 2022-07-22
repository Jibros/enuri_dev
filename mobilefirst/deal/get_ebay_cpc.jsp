<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.io.IOException"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.FileReader"%>
<%@ page import="org.json.*"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.URLConnection"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page contentType="text/html; charset=utf-8;" pageEncoding="utf-8"%>
<%

String appId = ChkNull.chkStr(request.getParameter("app_id"), "");
String appType = ChkNull.chkStr(request.getParameter("app_type"), "");
String appVersion = ChkNull.chkStr(request.getParameter("version"), "");


if((appType.equalsIgnoreCase("A") || appType.equalsIgnoreCase("I")) 
		&& !checkVersion(appId, appType, appVersion)){
	out.println(new JSONObject().toString());
	return;
}

String chInfo = ChkNull.chkStr(request.getParameter("chInfo"), "");
String maxCnt = ChkNull.chkStr(request.getParameter("maxCnt"), "");
String isCate = ChkNull.chkStr(request.getParameter("isCate"), "");
String cateCode = ChkNull.chkStr(request.getParameter("cateCode"), "");
String keyword = ChkNull.chkStr(request.getParameter("keyword"), "");
String appReFer = ChkNull.chkStr(request.getParameter("appReFer"), "");

String rootPath = session.getServletContext().getRealPath("/");

// 에누리 카테고리 코드 값으로 매핑
cateCode = findCategory(getMappingJSON(session), cateCode);

//LP에서 호출한 경우 키워드를 카테고리 코드 값으로 치환
keyword = isCate.equals("LP") ? cateCode : URLEncoder.encode(keyword, "UTF-8");


// URL 재 구성
// was 부하 집중 해소 localhost 로 수정 - 2019-04-29
//String apiUrl = "http://" + request.getServerName() + "/ebayCpc/jsp/connectApi2.jsp";
String apiUrl = "http://localhost/ebayCpc/jsp/connectApi2.jsp";

StringBuilder builder = new StringBuilder();

builder.append(apiUrl);
builder.append("?chInfo=").append(chInfo);
builder.append("&maxCnt=").append(maxCnt);
builder.append("&isCate=").append(isCate);
//if(!StringUtils.isEmpty(cateCode))
	builder.append("&cateCode=").append(cateCode);
builder.append("&keyword=").append(keyword);
builder.append("&appReFer=").append(URLEncoder.encode(appReFer, "UTF-8"));

out.println(requestCpcItem(builder.toString()).toString(4));
%>

<%!

public boolean checkVersion(String appId, String appType, String version) {
	
	int intVersion = versionToInt(version);
	
	if(intVersion == 0 ) {
		return false;
	}
	
	return true;
}

private int versionToInt(String version) {
	if(StringUtils.isEmpty(version) || !version.contains(".")) {
		return 0;
	} else {
		String[] arr = version.split("\\.");
		if(arr.length == 3) {
			int result = Integer.parseInt(arr[0]) * 100
					+ Integer.parseInt(arr[1]) * 10
					+ Integer.parseInt(arr[2]);
			
			return result;
			
		} else {
			return 0;
		}
	}
}

/**
*	API를 호출해서 실제 cpc 데이터를 읽어온다
*/
public JSONObject requestCpcItem(String url) {
	
	JSONObject result = new JSONObject();
	
	try {
		
		HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
		
		conn.setRequestMethod("GET");
		conn.setConnectTimeout(20000);
		conn.setReadTimeout(5000);
		conn.setDoInput(true);
		conn.setDoOutput(true);
	
		BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(),  "UTF-8"));
		StringBuilder sb = new StringBuilder();
	
		String inputLine;
		while ((inputLine = in.readLine()) != null) {
			sb.append(inputLine);
		}
	
		in.close();
		conn.disconnect();

		result.put("bb", sb.toString());
		result = new JSONObject(sb.toString());
		
	} catch (Exception e) {
		// Ignore exception
		
		try {
			result.put("aa", e.toString());
		} catch (Exception ee) {
			
		}
	}

	return result;
}


/**
*	매핑 JSON을 읽어옴
*/
public JSONObject getMappingJSON(HttpSession seesion) {
	
	String jsonPath = seesion.getServletContext().getRealPath("/") + "/mobilefirst/deal/category_map_v2.json";
	JSONObject root = new JSONObject();
	
	try {
		
		BufferedReader reader = new BufferedReader(new FileReader(jsonPath));
		StringBuilder sb = new StringBuilder();
		String line;

		while((line = reader.readLine())!= null){
	    	sb.append(line+"\n");
		}

		reader.close();
	
		root = new JSONObject(sb.toString());
		
	} catch (Exception e) {
		// Ignore exception
	}
	
	return root;
}

/**
*	JSON 매핑 테이블에서 에누리 카테고리 코드 값을 찾는다.
*	매핑 된 카테고리 값이 없으면 소셜 카테고리 그대로 던짐
*/
public String findCategory(JSONObject json, String socialCateCode) {
	
	try {
		
		if(json.has(socialCateCode)) {
			
			if(socialCateCode.equals("A02")) {
				JSONArray array = json.getJSONArray(socialCateCode);
				int rndIdx = new Random().nextInt(array.length());
				return array.getString(rndIdx);
			} else
				return json.getString(socialCateCode);
		} else {
			return socialCateCode;
		}
		
	} catch (JSONException e) {
		return socialCateCode;
	}
}
%>