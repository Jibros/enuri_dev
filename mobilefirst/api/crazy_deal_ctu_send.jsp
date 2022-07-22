<%@page import="com.enuri.util.common.ChkNull"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.bean.mobile.Mobile_Deal_Proc"%>
<%@page import="org.json.*"%>
<%@page import="java.io.*"%>
<%@page import="com.enuri.util.common.CommonFtp"%>
<%@page import="com.oroinc.net.ftp.*"%>
<%
	String devYN = ChkNull.chkStr(request.getParameter("devYN"));
	String type = ChkNull.chkStr(request.getParameter("type") , "C");

	boolean vReturn = false;

	JSONArray jSONArray = new JSONArray(); 
	JSONObject jSONObject = new JSONObject();
	
	Mobile_Deal_Proc mobile_Deal_Proc = new Mobile_Deal_Proc();
	
	String jsonFileName = "";
	String fileName = "";
	if( "F".equals(type) ){ //크레이지 프라이데이 
		jSONArray = mobile_Deal_Proc.getCrazyFridayJson(devYN);
		jsonFileName = "C:/www/jsp/mobilefirst/http/json/friday_deal.json";
		fileName = "friday_deal.json";
	}else{
		jSONArray = mobile_Deal_Proc.getCrazyJson(devYN);	
		jsonFileName = "C:/www/jsp/mobilefirst/http/json/mobile_deal_list.json";
		fileName = "mobile_deal_list.json";
	}
	//if(request.getServerName().indexOf("dev.enuri.com")>-1){
	//	vReturn = mobile_Deal_Proc.jsonFileWrite80(jSONArray , "webapps/ROOT/mobilefirst/http/json/mobile_deal_list.json" );
	//}else{
	boolean mReturn = mobile_Deal_Proc.jsonFileWrite80(jSONArray , jsonFileName );
	
	if(mReturn){
		
		ArrayList ipList = new ArrayList();
		
		if(devYN.equals("Y")){
			ipList.add("100.100.100.151");	
		}else{
			ipList.add("100.100.100.151");
			ipList.add("100.100.100.170");
			ipList.add("100.100.110.171");
			ipList.add("100.100.100.172");
			ipList.add("100.100.110.173");
			ipList.add("100.100.100.174");
			ipList.add("100.100.110.175");
			ipList.add("100.100.100.176");
			ipList.add("100.100.110.177");
			ipList.add("100.100.100.178");
			ipList.add("100.100.110.179");
			ipList.add("100.100.110.191");
			ipList.add("100.100.100.192");
		}
		vReturn = mobile_Deal_Proc.ftpSendCrazy(ipList,fileName);
	}
	//}
%>
myCallback({"result":<%=vReturn%>});