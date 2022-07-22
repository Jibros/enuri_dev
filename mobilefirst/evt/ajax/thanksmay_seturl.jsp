<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.util.http.ShortUrl"%>
<%@page import="org.json.*"%>
<jsp:useBean id="ShortUrl" class="com.enuri.util.http.ShortUrl" scope="page" />
<%

String cardSeq = ChkNull.chkStr(request.getParameter("card_seq"),"");
String strPc = ChkNull.chkStr(request.getParameter("pc"),"");
String strImg = ChkNull.chkStr(request.getParameter("img"),"");

JSONObject resultJson = new JSONObject();

if(!cardSeq.equals("") && strPc.equals("")){
	String defaultUrl="";
    if(request.getServerName().equals("m.enuri.com")){
    	defaultUrl = "http://m.enuri.com/mobilefirst/evt/thanksmay_card.jsp?card_seq=" + cardSeq;
    }else{
    	defaultUrl = "http://dev.enuri.com/mobilefirst/evt/thanksmay_card.jsp?card_seq=" + cardSeq;    
    }
	ShortUrl urlMaker = new ShortUrl();
	String shortUrl = urlMaker.getShortUrl(defaultUrl);
	
	resultJson.put("short_url", shortUrl);
} else if(strPc.equals("Y")) {
	String defaultUrl="";
    if(request.getServerName().equals("m.enuri.com")){
    	defaultUrl = "http://m.enuri.com/event2017/thanksmay_event.jsp?img=" + strImg;
    }else{
    	defaultUrl = "http://dev.enuri.com/event2017/thanksmay_event.jsp?img=" + strImg;    
    }
	ShortUrl urlMaker = new ShortUrl();
	String shortUrl = urlMaker.getShortUrl(defaultUrl);
	
	resultJson.put("short_url", shortUrl);
}else{
	resultJson.put("short_url", "");
}

out.println(resultJson.toString());
%>
