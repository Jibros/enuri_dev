<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.enuri.bean.knowbox.Knowcom_Event" %>
<%@ page import="com.enuri.util.common.ChkNull" %>

<%
	int ipage = ChkNull.chkInt(request.getParameter("page"), 1);
	int icnt = ChkNull.chkInt(request.getParameter("cnt"), 10);

	// 레퍼체크
	String strReferer = ChkNull.chkStr(request.getHeader("REFERER"),"");
	boolean bRefer = false;
	if(strReferer != null && !strReferer.equals("") && strReferer.indexOf(".enuri.com") > -1 ) {
		bRefer = true;
	}

	if (bRefer) {
		Knowcom_Event knowcomEvent = new Knowcom_Event();
		out.println(knowcomEvent.getKnowcom1stTxtList(icnt, ipage).toString());
	}
%>