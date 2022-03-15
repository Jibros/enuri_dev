<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%
/**************************
session 세팅 
2021-04-29
**************************/

//페이지종류 ( list , search )
String strFrom = ConfigManager.RequestStr(request, "from", "list");
// 디바이스 유형 ( pc , mw , aos, ios )
String strDevice = ConfigManager.RequestStr(request, "device", "pc");

String strPagegap = ConfigManager.RequestStr(request, "pagegap", "");
String strListgridtype = ConfigManager.RequestStr(request, "listgridtype", "");

if(strPagegap != null && !strPagegap.equals("")){
	if(strPagegap.equals("30") || strPagegap.equals("60") || strPagegap.equals("90") || strPagegap.equals("120")){
		session.setAttribute("pagegap", strPagegap);
	}
}

if(strListgridtype != null && !strListgridtype.equals("")){
	if(strListgridtype.equals("1") || strListgridtype.equals("2")){
		session.setAttribute("listgridtype", strListgridtype);
	}
}

String ssPagegap = (String)session.getAttribute("pagegap");
String ssListgridtype = (String)session.getAttribute("listgridtype");

//System.out.println("ssPagegap>>>"+ssPagegap);
//System.out.println("ssListgridtype>>>"+ssListgridtype);


%>