<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	Mobile_Event_Proc mobile_Event_Proc = new Mobile_Event_Proc();
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
   //String userId  =  "kalee";
	String userData  =  StringUtils.defaultString(request.getParameter("chkid"));
	//String userData  = "6bc7fa45c9939ede";
  	
	boolean result1 = mobile_Event_Proc.firstShoppingInsert3(userId , userData);
	boolean result2 = false;
	//201612 첫구매신청 후 바로 지급 
	if(request.getServerName().equals("m.enuri.com")){
  		result2 = mobile_Event_Proc.firstShoppingDirectEmoney(userId);	  		
  	}else{
  		result2 = mobile_Event_Proc.firstShoppingDirectEmoney_dev(userId);	
  	}
	JSONObject jSONObject = new JSONObject(); 
	jSONObject.put("result1",result1);
    jSONObject.put("result2",result2);
    jSONObject.put("userId",userId);
    jSONObject.put("userData",userData);
    out.println(jSONObject.toString());
%>