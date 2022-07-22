<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="com.enuri.bean.edeal.Edeal_Order_Proc"%>
<%@page import="com.enuri.bean.event.DBWrap"%>
<%@page import="com.enuri.bean.event.DBDataTable"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.util.seed.Seed_Proc"%>
<%@page import="com.enuri.bean.mobile.Event_Lina_Proc"%>
<%@page import="com.enuri.bean.event.every.Event_201608_Olympic_Proc"%>
<%@page import="com.enuri.bean.main.deal.CrazyDeal_ShareEvt_Proc"%>
<%
	JSONObject jSONObject = new JSONObject();

	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
	String answer = ChkNull.chkStr(request.getParameter("answer")).trim(); 
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date()); 								//	오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크

	
	if (referer.indexOf("enuri.com") < 0 || Integer.parseInt(strToday) > 20210513 ) {
		jSONObject.put("result",100);
		out.println(jSONObject.toString());
		return;
	}
	
	//에누리 표준PC 공유 이벤트 
	String eventCode = "2021041501";
	
	/*     
	procCode
		1 : 구매
	*/
	int procCode = ChkNull.chkInt(request.getParameter("proc"));				//	이벤트 유형
	if(procCode == 1) {
		String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID
		String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); 	// 	참여 os type
		
		String shareType = ChkNull.chkStr(request.getParameter("shareType"),"");
    	String osCode = "1";

    	if(osType.indexOf("PC") > -1) {
    		osCode = "1";
    	} else if(osType.indexOf("MW") > -1) {
    		osCode = "2";
    	}  else if(osType.indexOf("MA") > -1) {
    		osCode = "3";
    	}
    	
    	CrazyDeal_ShareEvt_Proc proc = new CrazyDeal_ShareEvt_Proc();
		jSONObject.put("result", proc.shareInsert_event(userId, eventCode, shareType, osCode));
    	//jSONObject.put("result", true);
	}
	
	out.println(jSONObject.toString());
%>