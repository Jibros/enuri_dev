<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.event.Event_PlusRsv_Proc"%>
<%
	//String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	String ServerType  = StringUtils.defaultString(request.getParameter("server_type"));
	//int numToday  = ChkNull.chkInt(request.getParameter("num_today"),1);
	String eventId  = StringUtils.defaultString(request.getParameter("event_id"));
	//System.out.println("ServerType:"+ServerType);
	String referer = ChkNull.chkStr(request.getHeader("referer"));
    JSONObject jSONObject = new JSONObject();

    int resultType = 0; //유형체크

	if(referer.indexOf("enuri.com") > -1){
		Event_PlusRsv_Proc event_plusrsv_proc = new Event_PlusRsv_Proc();
		/* JSONArray  catePromotion = event_plusrsv_proc.getCatePromotion(ServerType,eventId).getJSONArray("catePromotion");
		jSONObject.put("catePromotion"	, catePromotion); */
		jSONObject = event_plusrsv_proc.getCatePromotion(ServerType,eventId);
    }
	out.println(jSONObject.toString());
%>