<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.bean.main.GetLoadExternalPage"%>
<%
try{
	
	String strUrl = "https://ct.coopnc.com:5443/";
		
	String strReturn = new GetLoadExternalPage().getUrlPage(URLDecoder.decode(strUrl,"utf-8")); 
	out.println(strReturn);	
			
}catch(Exception ex){
	System.out.println(" coop test error ==> " +  ex.getMessage());
}
%>