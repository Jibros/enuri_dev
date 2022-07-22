<%@page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<jsp:useBean id="Mobile_Event_Proc" class="com.enuri.bean.mobile.Mobile_Event_Proc" scope="page" />
<%
	String eventId = StringUtils.defaultString(request.getParameter("event_id"));
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	//키값으로 받기, 날짜int체크
	String eventStartDt  = StringUtils.defaultString(request.getParameter("event_start_dt"));
	String eventEndDt  = StringUtils.defaultString(request.getParameter("event_end_dt"));
	String mobileYN  = StringUtils.defaultString(request.getParameter("mobileyn"),"N");
	String ostpcd  = StringUtils.defaultString(request.getParameter("ostpcd"),"PC");
	String referer = ChkNull.chkStr(request.getHeader("referer"));
    JSONObject jSONObject = new JSONObject();

    if(eventId.equals("") || eventStartDt.equals("") || eventEndDt.equals("") || referer.indexOf("enuri.com") < 0) {
    	jSONObject.put("result", -100);
    	out.println(jSONObject.toString());
    	return;
    }

    int resultType = 0; //유형체크
	userId = userId.trim();

	//sdu 회원이 인증이 안되어 있다면 true
	//이벤트 참여 불가
	//노병원 2018/10/11
	Members_Proc mp = new Members_Proc();
	if(mp.SduCerify(userId)){
		jSONObject.put("result", -4);
		out.println(jSONObject.toString());
		return;
	}
    
	//본인인증 여부 확인
	boolean bcertify = new Sns_Login().isSnsMemberCertify(userId);
	if(!bcertify){
		jSONObject.put("result", -5);
		out.println(jSONObject.toString());
		return;
	}

	if(!userId.equals("")){
		Mobile_Event_Proc mobile_event_proc = new Mobile_Event_Proc();
		resultType = mobile_event_proc.plusRsvChk3(eventId, userId, eventStartDt, eventEndDt,mobileYN,ostpcd);
    }
	
	jSONObject.put("result",resultType); // 결과를 넣는다.
	out.println(jSONObject.toString());
%>