<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%> 
<%@page import="com.enuri.bean.mobile.Event_Ladder_Proc" %>
<%
    //오늘날짜 반환
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");    
    String visitDate = formatter.format(new Date()); //오늘 날짜 (visitData, ins_date)
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); // 참여 os type
	String eventId = "2017041701"; //이벤트코드
	String userId = cb.GetCookie("MEM_INFO","USER_ID"); //참여 ID
    String strWishId = ChkNull.chkStr(request.getParameter("wishId"), "").trim();

    int intResultValue = 0; //결과값
    Event_Ladder_Proc event_ladder_proc = new Event_Ladder_Proc();
/*  if(request.getServerName().equals("dev.enuri.com") && request.getParameter("sdt")!=null && !request.getParameter("sdt").equals("")){
        visitDate = request.getParameter("sdt");
    } */
    if(!userId.equals("")){
    	try{
            intResultValue = event_ladder_proc.ladder_event_ins_ver2(eventId, userId, visitDate, osType,strWishId);  		
    	}catch(Exception e){
            intResultValue = 0;
    	}
    }
    JSONObject jSONObject = new JSONObject();
    jSONObject.put("result",intResultValue); // 결과를 넣는다.
    
	out.println(jSONObject.toString());
%>