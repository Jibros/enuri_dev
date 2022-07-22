<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="com.enuri.util.http.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="java.util.HashMap"%>

<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<jsp:useBean id="Members_Data" class="com.enuri.bean.knowbox.Members_Data"  />
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc"  />

<%
String strID = ConfigManager.RequestStr(request, "id","");
strID = strID.toLowerCase();	// 소문자 처리 wookki25 2005.04.28
int iReturn = 0;

if(strID.equals("") || CvtStr.isNumeric(strID.substring(0,1)) || !CvtStr.isValidID(strID)) {
	iReturn = 3;
}else{
	iReturn = Integer.parseInt( Members_Proc.Check_ID(strID) );
}

out.println("{");
out.println("\"chkId\":\""+iReturn+"\"");
out.println("}");
%>
