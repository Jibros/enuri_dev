<%@page import="com.enuri.bean.mobile.Mobile_NewsBox_Proc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="org.json.*"%>
<%@ page import="com.enuri.bean.mobile.Mobile_NewsBox_Proc"%>
<%@ page import="org.apache.commons.lang3.*"%>

<%

String appId = StringUtils.defaultString(request.getParameter("appId"));
String appType = StringUtils.defaultString(request.getParameter("appType"));
String strDays = request.getParameter("days");
int intDays = 15;

try {
	if(strDays != null && !strDays.trim().equals("")) {
		intDays = Integer.valueOf(strDays);
	}
} catch(Exception e) {
	intDays = 15;
}

JSONObject result = new JSONObject();
result.put("list", new JSONArray());
if(appId != "" && appType != "") {
	Mobile_NewsBox_Proc proc = new Mobile_NewsBox_Proc();
	result.put("list", proc.getPushList(appId, appType, intDays));
}

out.println(result.toString());
%>