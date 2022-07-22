<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	String phone = ChkNull.chkStr(request.getParameter("phone"), "").trim();
	String username = ChkNull.chkStr(request.getParameter("username"), "").trim();
	 
	Mobile_Event_Proc mobile_Event_Proc = new Mobile_Event_Proc();
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	
	JSONObject jSONObject = new JSONObject();
	
	String week = "5";
	
	Date today = new Date();
  	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
  	
  	int yyyymmdd = Integer.parseInt(sdf.format(today));
  	
  	/*
  	if( yyyymmdd > 20160110  ){
  		week = "2";
  	}else if( yyyymmdd > 20160117 ){
  		week = "3";
  	}else if( yyyymmdd > 20160124 ){
  		week = "4";
  	}
  	*/
  	

  	 if( yyyymmdd > 20160131 ){
  		week = "5";
  	}
  	
  	if( yyyymmdd > 20160207 ){
  		week = "6";
  	}

	jSONObject = mobile_Event_Proc.insertPayBack(userId , username ,phone,week);
	 
	if((Integer)jSONObject.get("result") == 1){
	
		int memberPointYNCnt = mobile_Event_Proc.getMemberPointYN(userId);
			if(memberPointYNCnt == 0){
				mobile_Event_Proc.memberRevolutionUpdate(userId);
			}
	}
	 
	jSONObject.put("result",jSONObject.get("result"));
	
	out.println(jSONObject.toString());
	
%>