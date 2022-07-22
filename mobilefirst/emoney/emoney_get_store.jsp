<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Emoney_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.simple.*"%>
<%
	String strTab = ChkNull.chkStr(request.getParameter("tab"),"1");
	String strStore_seq = ChkNull.chkStr(request.getParameter("store_seq"),"0");


	JSONArray jSONArray = new JSONArray(); 
	JSONObject jSONObject = new JSONObject();
	
	Emoney_Proc emoney_proc = new Emoney_Proc(); 
	
	if(strTab.equals("1")){
		jSONArray = emoney_proc.get_StoreList();
		jSONObject.put("storelist",jSONArray);
	}else{
		jSONArray = emoney_proc.get_ItemList(strStore_seq);
		jSONObject.put("itemlist",jSONArray);
	}
	
	out.println(jSONObject.toString());
	
%> 