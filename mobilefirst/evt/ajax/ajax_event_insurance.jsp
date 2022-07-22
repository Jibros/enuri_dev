<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Event_Dongbu_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	String eventId = "2017072601";
	String ostype = ChkNull.chkStr(request.getParameter("ostype"),"M");
	JSONObject jsonObj = new JSONObject(); 
	if(userId.equals(""))			jsonObj.put("result", "UE");
	else if(eventId.equals(""))		jsonObj.put("result", "EE");
	else if(ostype.equals(""))		jsonObj.put("result", "OE");
	else{
		Event_Dongbu_Proc event_dongbu_proc = new Event_Dongbu_Proc();
		jsonObj = event_dongbu_proc.ins_event_insurence(userId,eventId,ostype);
		
		if("M".equals(ostype)){
			jsonObj.put("url", "https://mdirect.kbinsure.co.kr/websquare/mobilePromotion.jsp?pid=1090049&code=0178&page=m_step1&enNo="+jsonObj.getInt("enNo"));
		}else if("P".equals(ostype)){
			jsonObj.put("url", " http://direct.kbinsure.co.kr/websquare/promotion.jsp?pid=1090049&code=0178&page=step1&enNo="+jsonObj.getInt("enNo"));			
		}
	}
	out.println(jsonObj.toString());
%>