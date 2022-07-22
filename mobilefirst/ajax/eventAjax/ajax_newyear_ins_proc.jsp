<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Event_Lina_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	Event_Lina_Proc event_Lina_Proc = new Event_Lina_Proc();
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	//String eventId = "20160926";
	
	String eventId = ChkNull.chkStr(request.getParameter("eventCode"));
    //럭키박스 이벤트 일경우는 이벤트 코드가 2016092701
    //구매왕 이벤트 일 경우는 이벤트 코드가 2016093001
	
	JSONObject jSONObject  = new JSONObject(); 
	
	//String strEvent_code2 = "2016120104";   //구매왕 1000점
    //String strEvent_code3 = "2016120103";   //더블적립
	
	int buyCnt  = event_Lina_Proc.buyRecord(userId,"2017-01-05"); //11월 이후 구매 한 내역 확인
	//int buyCnt  = event_Lina_Proc.buyRecord(userId,"2017-01-04"); //테스트용
	
	if(eventId.equals("2016120103") || eventId.equals("2016120502")){ //더블적립은 카운트 필요 없음
	buyCnt = 1;
	}
	
	if( buyCnt  > 0 ){
		if(!eventId.equals("")){
		   jSONObject  = event_Lina_Proc.ins_event(userId,eventId);
		}else{
		   jSONObject.put("result",false);
		}
	}
	
	jSONObject.put("buyCnt",buyCnt);
	out.println(jSONObject.toString());
%>