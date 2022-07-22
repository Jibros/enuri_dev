<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.date.DateStr"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String nowDate = DateStr.nowStr();
nowDate = StringUtils.replace(nowDate, "-", "");

JSONArray jSONArray = new JSONArray();

JSONObject JSONo = new JSONObject();
JSONo.put("date", "20180525");
JSONo.put("hint1", "테그1");
JSONo.put("hint2", "테그1");
JSONo.put("hint3", "테그1");
JSONo.put("hint4", "테그1");
JSONo.put("hint5", "테그1");

jSONArray.put(JSONo);

JSONo = new JSONObject();
JSONo.put("date", "20180526");
JSONo.put("hint1", "테그1");
JSONo.put("hint2", "테그1");
JSONo.put("hint3", "테그1");
JSONo.put("hint4", "테그1");
JSONo.put("hint5", "테그1");

jSONArray.put(JSONo);


JSONo = new JSONObject();
JSONo.put("date", "20180527");
JSONo.put("hint1", "테그1");
JSONo.put("hint2", "테그1");
JSONo.put("hint3", "테그1");
JSONo.put("hint4", "테그1");
JSONo.put("hint5", "테그1");
jSONArray.put(JSONo);

JSONo = new JSONObject();
JSONo.put("date", "20180528");
JSONo.put("hint1", "테그1");
JSONo.put("hint2", "테그1");
JSONo.put("hint3", "테그1");
JSONo.put("hint4", "테그1");
JSONo.put("hint5", "테그1");

jSONArray.put(JSONo);

JSONo = new JSONObject();
JSONo.put("date", "20180529");
JSONo.put("hint1", "테그1");
JSONo.put("hint2", "테그1");
JSONo.put("hint3", "테그1");
JSONo.put("hint4", "테그1");
JSONo.put("hint5", "테그1");

jSONArray.put(JSONo);

JSONo = new JSONObject();
JSONo.put("date", "20180529");
JSONo.put("hint1", "테그1");
JSONo.put("hint2", "테그1");
JSONo.put("hint3", "테그1");
JSONo.put("hint4", "테그1");
JSONo.put("hint5", "테그1");

jSONArray.put(JSONo);

for(int i=0; i < jSONArray.length() ; i++ ){
	
	JSONObject json =  jSONArray.getJSONObject(i);
	String date = json.getString("date");
	if(date.equals(nowDate)){
		
		out.println(json.toString());
		break;
	}
}

%>
