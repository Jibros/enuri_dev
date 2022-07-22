<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.enuri.bean.mobile.GNB_mobile_List_Proc"%>
<%@ page import="com.enuri.bean.mobile.GNB_mobile_List_Data"%>
<jsp:useBean id="GNB_mobile_List_Data" class="com.enuri.bean.mobile.GNB_mobile_List_Data" scope="page" />
<jsp:useBean id="GNB_mobile_List_Proc" class="com.enuri.bean.mobile.GNB_mobile_List_Proc" scope="page" />
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	
	String gseq = StringUtils.defaultString(request.getParameter("gseq"));
		
	GNB_mobile_List_Proc mobile_Category_Proc = new GNB_mobile_List_Proc();
	JSONObject jSONObject= mobile_Category_Proc.mobileCategory3ToJson(gseq);

	out.println(jSONObject);
	
%>
