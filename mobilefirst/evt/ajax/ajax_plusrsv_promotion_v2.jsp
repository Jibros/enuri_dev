<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.event.Event_PlusRsv_Proc"%>
<%
	/*
		<파라미터>
		deviceType : P / M 구분
		sdt : 파라미터로 받은 오늘날짜
	*/

	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
	SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
	String strToday = formatter.format(new Date()); 								//	오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크
	String serverType  = "real";													// dev인지 real 인지 구분
	String event_dtl_id = ChkNull.chkStr(request.getParameter("event_dtl_id"));
	
	if (referer.indexOf("enuri.com") > -1) {
        if (referer.indexOf("dev") > -1) {
        	serverType = "dev";
        }
		if (!"".equals(sdt)) {
			strToday = sdt;
		}
	} else {
		return;
	}
	
	JSONObject jSONObject = new JSONObject();
	String deviceType = ChkNull.chkStr(request.getParameter("deviceType"));
	int limitCnt = 4;  															//노출 제한갯수 (4개 미만)
	Event_PlusRsv_Proc procObj = new Event_PlusRsv_Proc();
	
	if ("M".equals(deviceType)) {
		jSONObject = procObj.getMobliePromtnInfo(serverType, deviceType, strToday, limitCnt);
	} else if ("P".equals(deviceType)) {
		jSONObject = procObj.getPCPromtnInfo(serverType, deviceType, strToday, limitCnt);
	} else {
		return;
	}
	//대상카테고리 추가
	jSONObject.put("targetCate", procObj.getTargetCateInfo(serverType, strToday, event_dtl_id));
	out.println(jSONObject.toString());
%>