<%@page import="com.enuri.bean.mobile.Officeworker_Event_Proc"%>
<%@page import="com.enuri.util.image.ImageUtil_lsv"%>
<%@page import="com.enuri.bean.main.Goods_Proc"%>
<%@page import="com.enuri.bean.main.Goods_Data"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.JSONObject"%>

<%
	String event_id = ChkNull.chkStr(request.getParameter("event_id"),"");
	String strP = ChkNull.chkStr(request.getParameter("p"),"");
	String tab_no = ChkNull.chkStr(request.getParameter("tab_no"),"");

	String serverName = request.getServerName();
	String strServerName = "";

	JSONObject jSONObject = new JSONObject();
	Officeworker_Event_Proc event_proc = new Officeworker_Event_Proc();

	if(serverName.indexOf("dev.enuri.com")>-1) {
	     strServerName = "dev";
	}else
		strServerName = "real";

	if(strP.equals("")){ //2018.11월 이전 타입
		jSONObject = event_proc.getOneOfficeworkerListOrg(event_id, strServerName);
	}else if(strP.equals("1")){
		jSONObject = event_proc.getOneOfficeworkerList(event_id, strServerName);
	}else if(strP.equals("2")){
		jSONObject = event_proc.getGDOfficeworkerList(event_id, tab_no);
	}else if(strP.equals("3")){
		jSONObject = event_proc.getTabOfficeworkerList(event_id);
	}
	out.println(jSONObject.toString());
%>

