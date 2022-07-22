<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.mobile.Event_Welcome_Proc" %>
<%
    String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
    String eventId="2017032801";
 
    JSONObject jSONObject = new JSONObject();
    
    int resultType = 0; //유형체크
	boolean insertReturn = false;//즉시지급여부

	if(!userId.equals("")){
        Event_Welcome_Proc event_welcome_proc = new Event_Welcome_Proc();
		String getFirstApplyUserId = event_welcome_proc.getFirstApplyUserId(userId, eventId);  
		//System.out.println("getFirstApplyUserId: "+getFirstApplyUserId);
		//본인인증 중복참여 제한
		if(!getFirstApplyUserId.equals("") && !getFirstApplyUserId.equals(userId)){
			resultType=-3;
		}else{
			resultType = event_welcome_proc.comback_type_chk(eventId, userId);
	        //즉시지급
	        if(resultType==5){
	            insertReturn=event_welcome_proc.comback_directEmoney_proc(userId);
	        }        	
		}
        
    }	
     
	jSONObject.put("result",resultType); // 결과를 넣는다.
    jSONObject.put("insertReturn",insertReturn); // e머니지급결과       
	out.println(jSONObject.toString());
%>