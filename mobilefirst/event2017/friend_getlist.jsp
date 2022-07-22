<%@page import="com.enuri.bean.main.brandplacement.DBWrap"%>
<%@page import="com.enuri.bean.main.brandplacement.DBDataTable"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.event.Members_Friend_Proc"%>
<%@page import="org.json.*"%>
<%
String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
//cUserId = "cherub1004";

String osType = ChkNull.chkStr(request.getParameter("osType"),"PC");
String type = ChkNull.chkStr(request.getParameter("type"),"");
int pg = ChkNull.chkInt(request.getParameter("pg"));
int pgSize = ChkNull.chkInt(request.getParameter("pgsize"));

JSONObject jSONObject = new JSONObject();
JSONArray jSONArray = new JSONArray(); 
int totalCnt = 0;

if(cUserId.equals("")){
	jSONObject.put("friendlist","");	
}else{ 
	/*
	if(!osType.equals("PC")){
		jSONArray = Members_Friend_Proc.getFriendInfo(cUserId, type, pg, pgSize);
		jSONObject.put("friendlist",jSONArray);
	}
	*/
	
	String query = " select count(m_idx) as CNT from members where rec_userid = ? and rec_date is not null ";
	DBDataTable dt = new DBWrap("member").setQuery(query).addParameter(cUserId).selectAllTry();
	totalCnt = dt.parse(0, "cnt", -1);
	jSONObject.put("totalCnt",totalCnt);
}

out.println(jSONObject.toString());
%>
