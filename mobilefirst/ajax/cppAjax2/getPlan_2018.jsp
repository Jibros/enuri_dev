<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="org.apache.commons.lang3.*"%>
<%@page import="org.json.*"%>
<%@ page import="com.enuri.include.*"%>
<%@ page import="com.enuri.util.etc.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.util.image.*"%>
<%@ page import="com.enuri.util.http.*"%>
<%@ page import="com.enuri.util.date.*"%>
<%@page import="com.enuri.bean.mobile.Cpp_Proc_2018"%>
<%
	String strGcate = ChkNull.chkStr(request.getParameter("gcate"	    ),""	    ); //  CPP카테고리
	strGcate = "1"+strGcate;
	
	JSONArray jsonArrayTemp = new JSONArray(); 
	
	Cpp_Proc_2018 cpp_Proc_2018 = new Cpp_Proc_2018(); 
	
	JSONObject jsonobj = cpp_Proc_2018.getPlan(strGcate);
	JSONArray jsonArray = new JSONArray();
	
	jsonArray = (JSONArray)jsonobj.get("planList");
	
	for(int i=0 ; i < jsonArray.length(); i++){
		
		 JSONObject jSONObject =  (JSONObject)jsonArray.get(i);
		 
		 String imgJpg = "http://img.enuri.info/images/mobilefirst/planlist/B_"+jSONObject.getString("TODAY_ID")+"/B_"+jSONObject.getString("TODAY_ID")+"_main.jpg";
		 String imgPng = "http://img.enuri.info/images/mobilefirst/planlist/B_"+jSONObject.getString("TODAY_ID")+"/B_"+jSONObject.getString("TODAY_ID")+"_main.png";
		 
		 jSONObject.put("IMG", imgJpg);
		 jSONObject.put("IMG2", imgPng);
		 
		 jsonArrayTemp.put(jSONObject);
	}
	
	JSONObject json = new JSONObject(); 
	json.put("planList", jsonArrayTemp);
	out.println(json.toString());
	
%> 
 