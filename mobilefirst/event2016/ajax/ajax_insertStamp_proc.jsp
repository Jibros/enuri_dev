<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Stamp_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
    Mobile_Stamp_Proc mobile_Stamp_Proc = new Mobile_Stamp_Proc();
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
    String eventId ="2017060101";
    JSONObject jSONObject = new JSONObject();  
    
    int stampCnt = mobile_Stamp_Proc.getStampCnt(eventId, userId);
	int purchaseCnt = mobile_Stamp_Proc.getPurchaseCount(userId,"20170601");//test
 	
	String getFirstApplyUserId = mobile_Stamp_Proc.getFirstApplyUserId(userId, eventId);
	//System.out.println("getFirstApplyUserId: "+getFirstApplyUserId);
	//본인인증 중복참여 제한
	if(!getFirstApplyUserId.equals("") && !getFirstApplyUserId.equals(userId)){
		jSONObject.put("result",-2);
		
	}
    //스탬프가 7개이상이면 insert 불가
    else if(stampCnt>=7){
		jSONObject.put("result",-1);
    }else if(stampCnt >= purchaseCnt){
        jSONObject.put("result",false);        
    }    
    else if(stampCnt < purchaseCnt){
    	boolean result = mobile_Stamp_Proc.insertStamp(eventId, userId); 
  	    jSONObject.put("result",result);
    }
	out.println(jSONObject.toString());
%>