<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Emoney_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%
	int intCnt = ChkNull.chkInt(request.getParameter("cnt"),3);
	String isShop = ChkNull.chkStr(request.getParameter("isShop"), "N");
	String device = ChkNull.chkStr(request.getParameter("device"), "M");

	JSONArray jSONArray = new JSONArray(); 
	JSONObject jSONObject = new JSONObject();
	
	Emoney_Proc emoney_proc = new Emoney_Proc(); 
	if (isShop.equals("N")) {
		jSONArray = emoney_proc.get_ItemList_Random(intCnt);
		jSONObject.put("itemlist",jSONArray);		
	} else {
		jSONObject = emoney_proc.get_StoreList_Random(intCnt,device);
	}
	out.println(jSONObject.toString());
%>
