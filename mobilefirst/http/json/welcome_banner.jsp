<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="org.json.*"%>

<%
long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String sdt = dayTime.format(new Date(cTime));//진짜시간
int intSdt = Integer.parseInt(sdt);
String imgSrc ="";
String colorType="";
if (intSdt >=20170501){
	colorType="ffdf80";
	imgSrc = "http://storage.enuri.gscdn.com/Web_Storage/pic_upload/mobile/banner/welcome_appbanner_v2.jpg";	
}else{
	colorType="d9f4ff";
	imgSrc = "http://storage.enuri.gscdn.com/Web_Storage/pic_upload/mobile/banner/welcome_appbanner.jpg";		
}
%>
{
	"appFrontPop": {
		"banner": [{
			"sdate": "2017-03-16 12:00:00",
			"img": "<%=imgSrc %>",
			"bgcolor": "#<%=colorType %>",
			"name": "웰컴혜택",
			"link": "http://m.enuri.com/mobilefirst/evt/welcome_event.jsp?freetoken=event&tab=2",
			"location": "all",
			"ANDROID": "Y",
			"IOS": "Y",
			"edate": "2019-06-05 23:59:59"
		}]
	}
}