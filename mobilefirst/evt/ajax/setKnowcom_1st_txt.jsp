<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="com.enuri.bean.knowbox.Knowcom_Event" %>
<%@ page import="com.enuri.util.common.ChkNull" %>
<%@ page import="com.enuri.util.common.ConfigManager" %>
<%@ page import="com.enuri.exception.ExceptionManager" %>

<%
	String eventCode = ChkNull.chkStr(request.getParameter("event_code"), "2019010703");
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	String userIp = request.getRemoteAddr();
	String txt = ChkNull.chkStr(request.getParameter("txt"), "");
	String osType = ChkNull.chkStr(request.getParameter("os_type"), "");	// PC/MAA,MAI,MWA,MWI

	String strReferer = ChkNull.chkStr(request.getHeader("REFERER"),"");

	// 레퍼체크
	boolean bRefer = false;
	if(strReferer != null && !strReferer.equals("") && strReferer.indexOf(".enuri.com") > -1 ) {
		bRefer = true;
	}

	/**
	-- 쇼핑지식 1주년 맞이 이벤트 번호
	-- 577	2019010701	이벤트 01 투표1
	-- 578	2019010702	이벤트 02 투표2
	-- 579	2019010703	이벤트 03 댓글

	-- return 값
	-1	기본
	-3	중복참여
	-4	임직원참여
	-9	SDU 회원

	-- 사용값
	-5	로그인ID 없음
	-6	댓글 내용 오류
	*/
	int result = -1;
	Knowcom_Event knowcomEvent = new Knowcom_Event();

	if ("".equals(userId)) {
		result = -5;
	} else if (knowcomEvent.isEnuri(userId)) {
		result = -4;
	} else if ("".equals(txt) || txt.length() > 1000) {
		result = -6;
	} else if (bRefer) {
		if (knowcomEvent.existsKnowcom1stTxt(eventCode, userId, "").length() > 0) {
			result = -3;
		} else {
			result = knowcomEvent.ins_knowcom1stTxt(eventCode, userId, HtmlStr.replaceHtmlTags(HtmlStr.cleanScriptBlock(txt)), userIp, osType);
		}
	}

	JSONObject resultObj = new JSONObject();
	resultObj.put("result", result);
	out.println(resultObj.toString());
%>
