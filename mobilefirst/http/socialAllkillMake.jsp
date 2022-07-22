<%@page import="com.enuri.bean.main.deal.Deal_Crawling_Proc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Mobile_GoodsToPricelist_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_GoodsToPricelist_Data"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.OutputStreamWriter"%>
<%@ page import="java.io.OutputStream"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.*"%>
<%@ page import="org.json.*"%>
<%@ page import="org.jsoup.*"%>
<%@ page import="org.jsoup.nodes.*"%>
<%@ page import="org.jsoup.select.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="org.apache.commons.lang3.*"%>
<%
	int shopCode = 4027; //옥션 shop code
	long logNo = 0; //크롤링 로그 번호
	
	//allkill 홈페이지에서 크롤링할 상품 카테고리의 리스트
	int[] allkillCateList = {0, 10000, 10007, 10013, 10016, 10020, 10024, 10028, 10033, 10039, 10045, 10049, 10054, 10059, 10066};
	int allkillCateLength = allkillCateList.length;
	int itemArrayLength = 0;
	int procResult = 0; // 프로시저 성공여부 (1 / 0)
	
	ArrayList<Long> plnoList = new ArrayList<Long>();
	Mobile_GoodsToPricelist_Proc mobile_goodstopricelist_proc = new Mobile_GoodsToPricelist_Proc();
	Deal_Crawling_Proc dealCrawlingProc = new Deal_Crawling_Proc();
	
	//첫번째 크롤링
	for (int cateCode : allkillCateList){
		//파라미터
		JSONObject paramJson = new JSONObject();
		paramJson.put("CategoryCode", cateCode);
		paramJson.put("SortType", "0");
		paramJson.put("PageNo", 0);
		paramJson.put("PageSize", 1000);
		
		//수집
		JSONObject jsonObject = jsonObjectUrlParsing("http://m.auction.co.kr/AllKill/Ajax/Search", paramJson);
		JSONArray itemArray = jsonObject.getJSONArray("AllKillDeals");
		itemArrayLength = itemArray.length();
		
		//tbl_pricelist와 매칭된 plno값 저장
		for(int j=0; j < itemArrayLength;j++){
			 try{
				String item = String.valueOf(itemArray.getJSONObject(j).getJSONObject("Item").get("ItemNo"));
				Mobile_GoodsToPricelist_Data mgtpd = mobile_goodstopricelist_proc.getPrictListOne(shopCode, item);
				
				//수집해온 plno 저장
				if(mgtpd != null){
					plnoList.add(mgtpd.getPl_no());
				}
			}catch(Exception e){
				System.out.println(e.getLocalizedMessage());
			} 
		} 
	}
	//두번째 크롤링
	for (int cateCode : allkillCateList){
		//수집
		JSONObject jsonObject = jsonObjectUrlParsing("http://m.auction.co.kr/AllKill/Ajax/MainDeal?categoryCode="+ cateCode +"&sortType=0");
		JSONArray itemArray = jsonObject.getJSONArray("AllKillMainDeals");
		itemArrayLength = itemArray.length();
		
		//tbl_pricelist와 매칭된 plno값 저장
		for(int j=0; j < itemArrayLength; j++){
			try{
				String item = String.valueOf(itemArray.getJSONObject(j).getJSONObject("Item").get("ItemNo"));
				Mobile_GoodsToPricelist_Data mgtpd = mobile_goodstopricelist_proc.getPrictListOne(shopCode, item);
				
				//수집해온 plno 저장
				if(mgtpd != null){
					plnoList.add(mgtpd.getPl_no());
				}
			}catch(Exception e){
				System.out.println(e.getLocalizedMessage());
			}
		} 
	}

	//호출로그 기록
	int crawlingCnt = plnoList.size();
	logNo = dealCrawlingProc.insertCrawlingLog(shopCode, "Y", "600", crawlingCnt);
	
	//크롤링한 갯수 판단해서 데이터 수집을 시작할지 안할지 판단
	if(crawlingCnt > 0){

		//테이블 초기화 
		int result = dealCrawlingProc.deleteAllPlNo();
 		//addbatch 일괄저장
		dealCrawlingProc.insertPlNo(shopCode, plnoList);
		//프로시저 호출
		procResult = dealCrawlingProc.couponCrAllkill_ins();
		
		//수집 종료
		if(logNo > 0){
			//프로시저 호출 에러발생시 error 기록
			if(procResult == 0){
				dealCrawlingProc.updateCrawlingLog(logNo, "1", procResult); 
			}else{
				dealCrawlingProc.updateCrawlingLog(logNo, procResult);
			}
		}
	}
	
	JSONObject resultObject = new JSONObject();
	resultObject.put("result", (procResult!=0));
	resultObject.put("itemCnt", procResult);
	out.println(resultObject.toString());
%>
<%!

//get 방식
public JSONObject jsonObjectUrlParsing(String strUrl) throws UnsupportedEncodingException, MalformedURLException, IOException, JSONException{
	URL urlObj = new URL(strUrl);
	HttpURLConnection conn = (HttpURLConnection) urlObj.openConnection();
	conn.setRequestMethod("GET");
	conn.setConnectTimeout(20000);
	conn.setReadTimeout(5000);
	conn.setRequestProperty("Accept-Charset", "UTF-8");
	conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.6) Gecko/20100625 Firefox/3.6.6");
	conn.setDoInput(true);
	conn.setDoOutput(true);
	
	BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(),  "UTF-8"));
	StringBuilder html = new StringBuilder();  
	
	String inputLine;
	while ((inputLine = in.readLine()) != null) {
		html.append(inputLine);
	}
	
	in.close();
	conn.disconnect();
	BufferedReader br = new BufferedReader(new InputStreamReader((new URL(strUrl)).openConnection().getInputStream(),"UTF-8"));
	StringBuilder sbJson = new StringBuilder();
	String strLine = "";
	    
	while ((strLine = br.readLine()) != null){
		sbJson.append(strLine);
	}
	   
	br.close();
	try {
		JSONObject jSONObject = new JSONObject(sbJson.toString());
		return jSONObject;
	} catch (JSONException e) {}	
	return null;
}

//payload 방식
public JSONObject jsonObjectUrlParsing(String strUrl,JSONObject paramJson) throws UnsupportedEncodingException, MalformedURLException, IOException, JSONException{
	URL urlObj = new URL(strUrl);
	HttpURLConnection conn = (HttpURLConnection) urlObj.openConnection();
	conn.setRequestMethod("POST");
	conn.setConnectTimeout(20000);
	conn.setReadTimeout(5000);
	conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
	conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.6) Gecko/20100625 Firefox/3.6.6");
	conn.setDoInput(true);
	conn.setDoOutput(true);

	OutputStreamWriter wr= new OutputStreamWriter(conn.getOutputStream());
    wr.write(paramJson.toString());
    wr.flush();
	wr.close();

	BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(),  "UTF-8"));
	StringBuilder html = new StringBuilder();  
	
	String inputLine;
	while ((inputLine = in.readLine()) != null) {
		html.append(inputLine);
	}

	in.close();
	conn.disconnect();

	try {
		JSONObject jSONObject = new JSONObject(html.toString());
		return jSONObject;
	} catch (JSONException e) {
		return null;
	}
	
}

public JSONArray jsonUrlParsing(String strUrl) throws UnsupportedEncodingException, MalformedURLException, IOException, JSONException{
	BufferedReader br = new BufferedReader(new InputStreamReader((new URL(strUrl)).openConnection().getInputStream(),"euc-kr"));
	StringBuilder sbJson = new StringBuilder();
	String strLine = "";
    
	while ((strLine = br.readLine()) != null){
		String str = StringUtils.substringBetween(strLine, "AllKillMainDeals\":", ",\"LargeCategories");
		str = StringUtils.replace(str,"\\\\\"","'");
		str = StringUtils.replace(str,"\\\\/","/");
		sbJson.append(str);
	}
	br.close();
	try {
		JSONArray jsonArray = new JSONArray(sbJson.toString());
		return jsonArray;
		
	} catch (JSONException e) {
	   System.out.println(e);
	}
	return null;
}

%>
