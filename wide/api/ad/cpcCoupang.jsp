<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="com.enuri.exception.ExceptionManager"%>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%
/******************** 쿠팡 광고 배너 연동
written by jinwook
이력 추가 시 기재부탁드립니다.
2021.06.10 최초연동
********************/

	/********************* parameters ****************************/
	//유형정보 ( lp / srp / vip )
	String strType = ChkNull.chkStr(request.getParameter("type"),"lp");
	strType = strType.toLowerCase();
	// 카테고리 ( lp / vip 에서만 사용 )
	String strCate = ChkNull.chkStr(request.getParameter("cate"),"");
	// 키워드 정보 ( srp 에서만 사용 )
	String strKeyword = ChkNull.chkStr(request.getParameter("keyword"),"");
	// 호출 광고 갯수
	int intSize = ChkNull.chkInt(request.getParameter("size"),1);
	intSize = 10;
	/*************************************************************/
	
	boolean blParam = true; // 파라미터 정상 여부 
	JsonResponse ret = null;
	String strFalseMsg = ""; // 실패메세지
	
	/********************* validation ****************************/
	if(!strType.equals("lp") && !strType.equals("srp") && !strType.equals("vip")) {
		blParam = false;
		strFalseMsg = "유형 정보 입력 오류";
	}
	
	if((strType.equals("lp") || strType.equals("vip")) && strCate.trim().length()==0 ) {
		blParam = false;
		strFalseMsg = "카테고리 미입력";
	}
	
	if(strType.equals("srp") && strKeyword.trim().length()==0 ) {
		blParam = false;
		strFalseMsg = "키워드 미입력";
	}
	/*************************************************************/
	
	if(!blParam) {
		ret = new JsonResponse(false).setMessage(strFalseMsg);
	} else {
		
		// String strAdApiUrl = "https://ad-dev.3dpop.kr/web_api/coupang_search.php"; // 개발 용
		String strAdApiUrl = "https://ad.3dpop.kr/web_api/coupang_search_enuri.php"; // 라이브 용
		String strPartnerID = "384e61ff8d2a293b21ead7b3a734e1625bd1031f"; // company id
		
		if(strType.equals("lp") || strType.equals("vip")) {
			strKeyword = convertCateToKeywd(strCate);
		}
		
		// FullUrl
		String strFullUrl = strAdApiUrl + "?company_uid=" + strPartnerID + "&cp_keyword=" + URLEncoder.encode(strKeyword) + "&cp_count=" + intSize;
		
		try {
			
			URL targetURL = new URL(strFullUrl);
			HttpURLConnection httpConn = (HttpURLConnection) targetURL.openConnection();
			httpConn.setRequestMethod("GET");
			httpConn.setRequestProperty("Content-length", "0");
			httpConn.setUseCaches(false);
			httpConn.setAllowUserInteraction(false);
			httpConn.setConnectTimeout(3000);
			httpConn.setReadTimeout(3000);
			httpConn.connect();
			
			int responseCode = httpConn.getResponseCode(); 
			
			if(responseCode == 200) {
				
				BufferedReader in = new BufferedReader(new InputStreamReader(httpConn.getInputStream(), "UTF-8"));
				String inputLine;
				StringBuffer inputBuffer = new StringBuffer();
				while ((inputLine = in.readLine()) != null) { 
					inputBuffer.append(inputLine); 
				} 
				in.close();
				
				JSONParser jsonParser = new JSONParser();
				JSONObject jsonObjectOri = (JSONObject) jsonParser.parse(inputBuffer.toString());
				JSONArray retArray = new JSONArray();
				JSONObject retObj = new JSONObject();
			
				if(jsonObjectOri.size()>0) {
					if(jsonObjectOri.get("Code")!=null) {
						String resCode = (String) jsonObjectOri.get("Code");
						/*
						0   : Success                  -> API 통신 성공 & 검색 결과 값 존재 
						503 : Request failed [01]  -> API 통신 실패 
						603 : Return data null [01]  -> API 통신은 성공했으나 검색 결과 값이 없는 경우
						*/
						if(resCode.equals("0")) {
							if(jsonObjectOri.get("data")!=null && !jsonObjectOri.get("data").toString().isEmpty()) {
								retArray = (JSONArray) jsonObjectOri.get("data");
							}
						}
					}
				}
				
				if(retArray.isEmpty()) {
					ret = new JsonResponse(false).setMessage("쿠팡 CPC 광고 수신 값 없음");	
				} else{
					ret = new JsonResponse(true).setData(retArray).setMessage("광고키워드 : " + strKeyword).setTotal(retArray.size());
				}
				
			} else {
				ret = new JsonResponse(false).setMessage("쿠팡 CPC 광고 수신 오류 코드 : " + responseCode);
			}
			
		} catch(Exception e) {
			ret = new JsonResponse(false);
		}
	}
		
	out.print( ret );
%>

<%!
/***********************************
	카테고리 코드를 키워드로 전환하는 메소드 
***********************************/
public static String convertCateToKeywd(String strCateCode) throws ExceptionManager {
	String tempKeywd = "";
	
	tempKeywd = new Ca_Ad_Keyword().Ca_Ad_Google_Call(strCateCode);

	if (!tempKeywd.isEmpty() && tempKeywd.indexOf(",") > -1) {
		String strArr[] = tempKeywd.split(",");
		tempKeywd = strArr[0];
	}
	
	//스폰서 링크의 카테고리 정보가 없을 경우 에누리 카테고리 정보로 키워드 정보 추출
	if (tempKeywd.isEmpty()) {
		tempKeywd = new Category_Proc().Category_One_3(strCateCode);
	}
	
	// null 방어로직
	if (tempKeywd == null) {
		tempKeywd = "";
	}

	return tempKeywd;
}
%>