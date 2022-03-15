<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="com.enuri.bean.home.Main_Knowcom_Proc"%>
<%@page import="org.json.JSONObject"%>
<%
	JSONObject jsonObject = new JSONObject();
	Main_Knowcom_Proc knowcomData = new Main_Knowcom_Proc();
	//jsonObject.put("nuriHmList", knowcomData.getMainNuriHm());
	jsonObject.put("nuriHmList", knowcomData.getWideMainNuriHm());
	jsonObject.put("enuritvList", knowcomData.getMainEnuritv());
	jsonObject.put("reviewList", knowcomData.getReviewHotData("HOT", 6));
	jsonObject.put("unboxingList", knowcomData.getUnboxingData2());
	out.println(jsonObject.toString());
%>