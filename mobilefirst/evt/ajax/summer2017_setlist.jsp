<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%> 
<%@page import="com.enuri.bean.mobile.Event_Welcome_Proc" %>
<%
    //오늘날짜 반환
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 	//테스트 날짜	
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");    
    String visitDate = formatter.format(new Date()); //오늘 날짜 (visitData, ins_date)
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); // 참여 os type
	String eventId = "2017071001"; //이벤트코드
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); //참여 ID
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();
	
	if(referer.indexOf("enuri.com") > -1){
		if(!"".equals(sdt)){
			visitDate = sdt;
		}
	}else{
		return;
	}
	
    int intResultValue = 0; //결과값
    if(Integer.parseInt(visitDate) < 20170710 || 20170813 < Integer.parseInt(visitDate)){
		return;
    }else{
	    if(!userId.equals("")){
	        Event_Welcome_Proc event_welcome_proc = new Event_Welcome_Proc();
	        intResultValue = event_welcome_proc.random_event_ins(eventId, userId, visitDate, osType);
	    }
    }
    JSONObject jSONObject = new JSONObject();
    jSONObject.put("result",intResultValue); // 결과를 넣는다.
	out.println(jSONObject.toString());
%>