<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="com.enuri.bean.main.deal.CrazyDeal_ShareEvt_Proc"%>
<%@page import="org.json.*"%>
<%
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date()); 										//	오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크
	boolean isDev = false;

	String eventId = ChkNull.chkStr(request.getParameter("event_id"),"2020102602");
	String evnt_cd = ChkNull.chkStr(request.getParameter("evnt_cd"),"T");
	isDev = true;
	if (referer.indexOf("dev") > -1 && !"".equals(sdt)) {
		strToday = sdt;
	//	isDev = true;
	}
	if (referer.indexOf("enuri.com") < 0) {
	//	return;
	}
	/*
	procCode
		1 : 이벤트 정보 API
		2 : 공유 INSERT
	*/
	int procCode = ChkNull.chkInt(request.getParameter("procCode"));				//	이벤트 유형

	JSONObject jSONObject = new JSONObject();
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 	//	참여 ID
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); 	// 	참여 os type
	CrazyDeal_ShareEvt_Proc proc = new CrazyDeal_ShareEvt_Proc();


	if(procCode == 1){
    	Map<String, Object> eventApi = proc.getEventData(strToday, isDev, evnt_cd);

    	if(!eventApi.isEmpty()) {
       		jSONObject = new JSONObject(eventApi);
    	}

	}else if(procCode == 2){
    	String shareType = ChkNull.chkStr(request.getParameter("shareType"),"");
    	String osCode = "1";

    	if(osType.indexOf("PC") > -1) {
    		osCode = "1";
    	} else if(osType.indexOf("MW") > -1) {
    		osCode = "2";
    	}  else if(osType.indexOf("MA") > -1) {
    		osCode = "3";
    	}

		jSONObject.put("result", proc.shareInsert_event(userId, eventId, shareType, osCode));
    	//jSONObject.put("result", true);
    }

	out.println(jSONObject.toString());
%>
