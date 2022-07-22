<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Emoney_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.simple.*"%>
<%
	int intCnt = ChkNull.chkInt(request.getParameter("cnt"),3);
	int intPrice1 = ChkNull.chkInt(request.getParameter("price1"),0);
	int intPrice2 = ChkNull.chkInt(request.getParameter("price2"),0);

	JSONArray jSONArray = new JSONArray(); 
	JSONObject jSONObject = new JSONObject();
	
	Emoney_Proc emoney_proc = new Emoney_Proc(); 
	
	jSONArray = emoney_proc.get_ItemList_Random2(intCnt, intPrice1, intPrice2);
	jSONObject.put("itemlist",jSONArray); 
	
	out.println(jSONObject.toString()); 
	 
%>
