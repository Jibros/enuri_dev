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
	} else {
		return;
	}

    int intResultValue = 0; 														// 	결과값
    JSONObject jSONObject = new JSONObject();
	//String eventId = "2018032601"; 												//	이벤트코드
	//String eventId = "2018032601"; 													//	이벤트코드
	//String eventId = "2018052801"; //이벤트 코드
	
	String eventId = "2018070201"; //이벤트 코드
	
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); 	// 	참여 os type

    try{
   		
       	String uphone = ChkNull.chkStr(request.getParameter("uphone"), "").trim();
       	if(uphone.length()>10){
   	   		String ceedUphone = new Seed_Proc().EnPass_Seed(uphone);
   	   		intResultValue = new Newyear_2017().setPhoneEventIns(eventId, userId, ceedUphone, osType, strToday);
       	}else{
       		intResultValue = -11;
       	}
    }catch(Exception e){}

    jSONObject.put("result",intResultValue);
	out.println(jSONObject.toString());
%>
