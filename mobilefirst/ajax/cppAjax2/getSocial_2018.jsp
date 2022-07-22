<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Cpp_Proc_2018"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.net.URLEncoder" %>

<%
String strCate = ConfigManager.RequestStr(request,"gcate","14");
String strType = "";

if (request.getRequestURL().indexOf("dev.enuri.com") > -1){
	strType = "D";
}

Cpp_Proc_2018 cpp_proc_2018 = new Cpp_Proc_2018();

String jsonStr = cpp_proc_2018.getCategoryDealGoods_mobile_str(strCate,strType);
JSONObject jsonObject = new JSONObject(jsonStr);
JSONArray jsonArray = jsonObject.getJSONArray("goods");
//String hostUrl = request.getRequestURL().toString().replace(request.getRequestURI(), "");

String hostUrl = "http://www.enuri.com";

// #31755 cpp 소셜 브릿지페이지적용
for (int i=0; i < jsonArray.length(); i++) {
	JSONObject obj = jsonArray.getJSONObject(i);
	String url = obj.getString("url");
	String encodeUrl = URLEncoder.encode(url, "UTF-8");
	String outurl = hostUrl+"/deal/move.html?freetoken=outlink&cpId="+obj.getString("cp_id")+"&cpUrl="+encodeUrl+"&cpCompany="+obj.getString("company");
	obj.put("url", outurl);
	obj.put("url2", url);
}

out.print(jsonObject.toString());
%>