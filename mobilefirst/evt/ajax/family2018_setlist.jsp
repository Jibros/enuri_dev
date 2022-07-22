<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.event.every.Newyear_2017"%>
<%@page import="com.enuri.util.seed.Seed_Proc"%>
<%@page import="com.enuri.bean.mobile.Event_Welcome_Proc" %>
<jsp:useBean id="ShortUrl" class="com.enuri.util.http.ShortUrl" scope="page" />
<%
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date()); 								//	오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크

	if (referer.indexOf("enuri.com") > -1) {
		if (referer.indexOf("dev") > -1 && !"".equals(sdt)) {
			strToday = sdt;
		}
	    if (Integer.parseInt(strToday) < 20180423 || 20180518 < Integer.parseInt(strToday)) {
			return;
	    }
	} else {
		return;
	}
	/*
	procCode
		1 : 카네이션 참여
		2 : 구매응모 참여
	*/
	int procCode = ChkNull.chkInt(request.getParameter("procCode"));				//	이벤트 유형
    int intResultValue = 0; 														// 	결과값
    JSONObject jSONObject = new JSONObject();
	String eventId = "2018042301"; 													//	이벤트코드
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); 	// 	참여 os type

    try{
    	if(1 == procCode){
        	/*
        	intResultValue
    	    	-2	 		: 임직원
    	    	-55 		: 오늘날짜로 참여가 아닌경우
    	    	-1  		: 당일 참여 완료
    	    	 0 - 10000 	: 리워드지급성공 및 액수반환
        	*/
     		if(!userId.equals("")){
    	      intResultValue = new Event_Welcome_Proc().random_event_ins(eventId, userId, strToday, osType);
     			//intResultValue = 6000;
     	    }
        }else if(2 == procCode){
        	/*
        	intResultValue
    	    	-1			: 이미 참여
    	    	 1	 		: insert 성공
    		*/
    		eventId = "2018042302"; 	
        	String uphone = ChkNull.chkStr(request.getParameter("uphone"), "").trim();
        	if(uphone.length()>10){
    	   		String ceedUphone = new Seed_Proc().EnPass_Seed(uphone);
    	   		intResultValue = new Newyear_2017().setPhoneEventIns(eventId, userId, ceedUphone, osType, strToday);
        	}
        }else if(3 == procCode){
        	/*
        	intResultValue
    	    	1		: 이미 신청
    	    	0		: 신청하지 않음
    		*/
    		eventId = "2018042302"; 	
   	   		intResultValue = new Newyear_2017().getPhoneEventIsApply(eventId, userId);
        }
    }catch(Exception e){}

    jSONObject.put("result",intResultValue);
	out.println(jSONObject.toString());
%>
