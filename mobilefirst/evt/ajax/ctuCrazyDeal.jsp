<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
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
	String strTest =		"N";
	String strSystemType =	"4";
	String strDevice =		"1";
	String strService =		"6";
	String strShopCode =	ChkNull.chkStr(request.getParameter("shop_code"),"");
	String strGoodsSeq =	ChkNull.chkStr(request.getParameter("goods_seq"),"");
	String strUserIp =		request.getRemoteAddr();
	
	String strParam = "ctu_test="+ strTest +"&system_type="+ strSystemType +"&device="+ strDevice +"&&service="+ strService 
			+"&&shop_code="+ strShopCode +"&&goods_seq="+ strGoodsSeq +"&&user_ip="+ strUserIp;
	
	//수집
	//JSONObject jsonObject = jsonObjectUrlParsing("http://" + request.getServerName() +"/move/ctuV2.jsp?" + strParam);
	JSONObject jsonObject = jsonObjectUrlParsing("http://192.168.213.173:"+  (request.getServerName().contains("dev.enuri.com") ? "8098" : "8088" )  +"/ctuApi/getCtuData.enuri?" + strParam);

	//System.out.println("http://192.168.213.173:"+  (request.getServerName().contains("dev.enuri.com") ? "8098" : "8088" )  +"/ctuApi/getCtuData.enuri?" + strParam);
	
	if(!jsonObject.isNull("GoodsUrl")) {
		jsonObject.remove("GoodsUrl");
		jsonObject.remove("GoodsCode");
	}

	out.println(jsonObject.toString());
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

%>
