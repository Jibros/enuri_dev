<%@page import="com.enuri.util.date.DateUtil"%>
<%@page import="com.enuri.bean.member.Join_Data"%>
<%@page import="com.enuri.bean.event.Members_Friend_Proc2"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%

	Mobile_Event_Proc mep = new Mobile_Event_Proc();

	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID
	
	JSONObject jSONObject = new JSONObject();
	
	if(!"".equals(userId) ){
		jSONObject = mep.getPowerRewardCount(userId);
		
		int cnt = mep.getFirst100UserData(userId);
		
		if( cnt > 0 ){
			//첫구매 , 친구초대 , 선쿠폰 내역 존재
			jSONObject.put("isApply", -2 );
			
		}else{
			//true 본인인키로 신청내역있음
			//if(mep.isApply(ciKey)){ //true
			if(mep.is100Apply(userId)){ //true
				jSONObject.put("isApply", -3);	
			}else{
				//신청내역 없음
				//신청내역은 없고 첫구매 일자가 오늘 100 일 넘었을 경우
				int result = mep.getFirstShoppingCart(userId);
		
				if(result > 100){ //첫구매 오늘 기준 첫구매 날짜 
					jSONObject.put("isApply", -1);
				}else{
					jSONObject.put("isApply", 1);	
				}
			}
		}
	}
	out.println(jSONObject.toString());
%>