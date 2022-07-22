<%@ page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.net.*"%>
<%@ page import="com.enuri.bean.log.Log_AppError_Proc"%>

<%
	//플러스 링크 ip 검사 해서 따로 생성 필요
	
	SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMddHHmm");
long currentcheck = Long.parseLong(sdf.format(new Date()));
if (202104272200l <= currentcheck && currentcheck <= 202104280100l)
{
	
	return;
}




	String appId = replaceQuerystring(ConfigManager.RequestStr(request, "appId", ""));
	String appType = replaceQuerystring(ConfigManager.RequestStr(request, "appType", ""));
	String errorType = replaceQuerystring(ConfigManager.RequestStr(request, "errorType", ""));
	String shopCode = replaceQuerystring(ConfigManager.RequestStr(request, "shopCode", "0"));
	String userData = replaceQuerystring(ConfigManager.RequestStr(request, "userData", ""));
	String version = replaceQuerystring(ConfigManager.RequestStr(request, "version", ""));
	String errorCode = replaceQuerystring(ConfigManager.RequestStr(request, "errorCode", ""));
	String errorMsg = replaceQuerystring(ConfigManager.RequestStr(request, "errorMsg", ""));

	if (appType.equals("I") && version.equals("3.4.3") && appId.equals("1001"))
		return;
	try {
		//202010141800 배포
		if (errorCode.equals("PUSHID_TEST")) {
		//	out.print("PUSHID_TEST");
			return;
		}
		//202010141800 배포
		if (errorCode.equals("MART_CART_FAIL") && appType.equals("A") && version.equals("3.6.9") && errorMsg.contains("SUCCESS")) {
		//	out.print("MART_CART_FAIL");
			return;
		}
		
		
		//20210419 배포 // 20210521 다시 배포 
		if (errorCode.equals("API_ERROR") && appType.equals("I")  && errorMsg.contains("ad-api.enuri.info")) {
		//	out.print("API_ERROR");
			return;
		}
		
		String replaceErrorMsg = replaceSeperator(errorMsg);
		
	 	Log_AppError_Proc proc = new Log_AppError_Proc();
		proc.insertAppErrorLog(appId, appType, errorType, Integer.parseInt(shopCode), userData, version, errorCode, replaceErrorMsg); 
		
		
		
       /*  StringBuffer sb = new StringBuffer("http://100.100.100.210:8090/enr/setEnrAppError.enr?");
       sb.append("appId=");
       sb.append(appId);
       sb.append("&appType=");
       sb.append(appType);
       sb.append("&errorType=");
       sb.append(errorType);
       sb.append("&shopCode=");
       sb.append(shopCode);
       sb.append("&userData=");
       sb.append(userData);
       sb.append("&version=");
       sb.append(version);
       sb.append("&errorCode=");
       sb.append(URLEncoder.encode(errorCode,"UTF-8"));
       sb.append("&errorMsg=");
       sb.append(URLEncoder.encode(replaceSeperator(errorMsg),"UTF-8")); 
     

       URL obj = new URL(sb.toString());
       HttpURLConnection con = (HttpURLConnection) obj.openConnection();   

       con.setRequestMethod("GET");        
       int responseCode = con.getResponseCode(); */
       
       
	} catch (Exception e) {
		//out.println(e.toString());

	}
%>
<%!/**
	 * LOGDB에 쌓을때 ASCII 특수기호있는 경우 안 들어갈 수 있어서 제거
	 * @param allStr
	 * @return
	 */
private String replaceSeperator(String allStr) {

	StringBuilder sb = new StringBuilder();
	if (allStr == null) {
		return "";
	}
	try {
		for (int i = 0; i < allStr.length(); i++) {
			int b = allStr.charAt(i);
			if (b >= 0x20 && b != 0x24) { //DB에서 안받는 특수문자 "$"제거
				sb.append(Character.toString((char) b));
			}
		}
		return sb.toString();
	} catch (Exception e) {
		return allStr;
	}
}		
private String replaceQuerystring(String allStr){
	
	allStr = allStr.replaceAll("%","");
	allStr = allStr.replaceAll("'",""); //&#39;
	allStr = allStr.replaceAll("\"",""); //&quot;
	allStr = allStr.replaceAll(",",""); //&#44;
	allStr = allStr.replaceAll("|","");
	allStr = allStr.replaceAll("\n","");
	allStr = allStr.replaceAll("\r","");
	allStr = allStr.replaceAll("\r\n","");
	allStr= allStr.replaceAll("'","′"); // 작은 따옴표를 ′ 로 치환
	
	//쿼리에 사용하는 기본 문자열 제거
	allStr = allStr.replaceAll("select","");
	allStr = allStr.replaceAll("from","");
	allStr = allStr.replaceAll("insert","");
	allStr = allStr.replaceAll("update","");
	allStr = allStr.replaceAll("[?]","");
	return allStr;
}
	
	%>