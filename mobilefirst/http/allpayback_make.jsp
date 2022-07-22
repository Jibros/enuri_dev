<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*,java.text.*,java.net.*"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.bean.mobile.Event_Buy_Proc"%>
<%@page import="org.json.*"%>
<%@page import="java.io.*"%>
<%@page import="com.enuri.util.common.*"%>
<%@page import="com.oroinc.net.ftp.*"%>
<%
	/*
	long cTime = System.currentTimeMillis(); 
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
	String nowDt = dayTime.format(new Date(cTime));
	*/
	/*
   	String eventId = "2016093001";
	String startDt = "2016-10-01";
	String endDt = "2016-10-31";
	*/
	
	String eventId = "2016120101";
    String startDt = "2016-12-01";
    String endDt = "2016-12-31";
	
	//String fileNm = "getAllpayback_rank_201609.json";
	String fileNm = "getAllpayback_rank_201612.json";
	
	//System.out.println("nowDt="+nowDt);
	
	//테스트
	//eventId = "2016060102";
	//startDt = "2016-06-01";
	//endDt = "2016-07-01";

	JSONArray jSONArray = new JSONArray(); 
	JSONObject jSONObject = new JSONObject();
	ArrayList<String> ipList = new ArrayList<String>(); 
	
	Event_Buy_Proc event_Buy_Proc = new Event_Buy_Proc();
	
	jSONArray = event_Buy_Proc.getJson(eventId, startDt, endDt);
	boolean mReturn = event_Buy_Proc.jsonFileWrite(jSONArray,fileNm);
	/*
	if(mReturn){
		ipList.add("124.243.126.170");
		ipList.add("124.243.126.171");
		ipList.add("124.243.126.172");
		ipList.add("124.243.126.173");
		ipList.add("124.243.126.174");
		ipList.add("124.243.126.175");
		ipList.add("124.243.126.176");
		ipList.add("124.243.126.177");
		ipList.add("124.243.126.178");
		ipList.add("124.243.126.179");
		
		vReturn = mobile_Deal_Proc.ftpSendDev(ipList);
	}
	
	jSONObject.put("result", vReturn);
	out.println("myCallback("+jSONObject.toString()+");");
	*/
	jSONObject.put("result", mReturn);
	out.println(jSONObject.toString());	
%>