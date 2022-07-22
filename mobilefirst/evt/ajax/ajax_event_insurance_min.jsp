<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Event_Dongbu_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%

	

	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	String eventId = "2017080703";
	String ostype = ChkNull.chkStr(request.getParameter("ostype"),"M");
	JSONObject jsonObj = new JSONObject(); 
	if(userId.equals(""))			jsonObj.put("result", "UE");
	else if(eventId.equals(""))		jsonObj.put("result", "EE");
	else if(ostype.equals(""))		jsonObj.put("result", "OE");
	else{
		Event_Dongbu_Proc event_dongbu_proc = new Event_Dongbu_Proc();
		jsonObj = event_dongbu_proc.ins_event_insurence(userId,eventId,ostype);
		
		if("M".equals(ostype)){
			if( request.getRequestURL().indexOf("dev.enuri.com") > -1 ){
				jsonObj.put("url", "https://dev.stockn.kr/stock/join?regSiteCode=UX&ctgCode=2&subCode=1&cid="+jsonObj.getInt("enNo"));	
			}else{
				jsonObj.put("url", "https://stockn.kr/stock/join?regSiteCode=UX&ctgCode=2&subCode=1&cid="+jsonObj.getInt("enNo")+"&freetoken=outlink");
			}
			
		}else if("P".equals(ostype)){
			if( request.getRequestURL().indexOf("dev.enuri.com") > -1  ){
				jsonObj.put("url", "https://dev.stockn.kr/stock/join?regSiteCode=UX&ctgCode=1&subCode=1&cid="+jsonObj.getInt("enNo"));
			}else{
				jsonObj.put("url", "https://stockn.kr/stock/join?regSiteCode=UX&ctgCode=1&subCode=1&cid="+jsonObj.getInt("enNo"));
			}
		}
	}
	out.println(jsonObj.toString());
%>