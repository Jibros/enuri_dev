<%@page import="org.json.JSONObject"%>
<%@page import="com.enuri.bean.event.Members_Friend_Proc"%>
<%@page import="org.json.JSONArray"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%
String setDate = "2018-07-02"; //이벤트 시작 날짜
//String eventId = "2018032601"; //이벤트 코드
//String eventId = "2018052801"; //이벤트 코드
String eventId = "2018070201"; //이벤트 코드

Members_Friend_Proc members_Friend_Proc = new Members_Friend_Proc();

JSONObject jSONObject = new JSONObject();
JSONArray jSONArray = new JSONArray();

JSONArray rankingJson = members_Friend_Proc.getRanking(setDate,eventId);
jSONObject.put("RANKINGLIST", rankingJson);

out.println(jSONObject.toString());

%>