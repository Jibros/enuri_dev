<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.simple.*"%>
<%
	
	String  chkId = StringUtils.defaultString(request.getParameter("chkId") ,"");
	
	JSONObject jSONObject = new JSONObject(); 
	
	Mobile_Event_Proc mobile_Event_Proc = new Mobile_Event_Proc();
	
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	
	String linkUrl = "http://m.enuri.com/mobilefirst/event/ramen_event_web.jsp";
	
	jSONObject = mobile_Event_Proc.insertStemp(userId,linkUrl,chkId);
	
	JSONArray jSONArray = new JSONArray();	
	jSONArray = mobile_Event_Proc.getStemp(userId);
	
	if( jSONArray.size() >= 4 ){
		mobile_Event_Proc.upd_reward_event_point_ins(userId , "07", 1000 );
		jSONObject.put("recommendYN","Y");
	}else{
		jSONObject.put("recommendYN","N");
	}
	out.println(jSONObject.toString());
%>