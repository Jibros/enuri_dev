<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.util.http.ShortUrl"%>
<%@page import="org.json.*"%>
<jsp:useBean id="ShortUrl" class="com.enuri.util.http.ShortUrl" scope="page" />
<%

String cardSeq = ChkNull.chkStr(request.getParameter("card_seq"),"");

JSONObject resultJson = new JSONObject();

if(!cardSeq.equals("")){
	String defaultUrl = "http://m.enuri.com/mobilefirst/event2016/newyear_card.jsp?card_seq=" + cardSeq;
	ShortUrl urlMaker = new ShortUrl();
	String shortUrl = urlMaker.getShortUrl(defaultUrl);
	
	resultJson.put("short_url", shortUrl);
} else {
	resultJson.put("short_url", "");
}

out.println(resultJson.toString());
%>
