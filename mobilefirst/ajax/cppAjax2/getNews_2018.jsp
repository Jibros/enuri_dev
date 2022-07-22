<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="org.apache.commons.lang3.*"%>
<%@page import="org.json.*"%>
<%@ page import="com.enuri.include.*"%>
<%@ page import="com.enuri.util.etc.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.util.image.*"%>
<%@ page import="com.enuri.util.http.*"%>
<%@ page import="com.enuri.util.date.*"%>
<%@page import="com.enuri.bean.mobile.Cpp_Proc_2018"%>
<%
	String strGcate = ChkNull.chkStr(request.getParameter("gcate"), "0"); //  CPP카테고리
	String strLLCate= "01";

	Cpp_Proc_2018 cpp_Proc_2018 = new Cpp_Proc_2018();

	/*
	* 	1 가전/해외직구	: 디지털/가전
	* 	2 TV/영상/디카	: 디지털/가전
	* 	3 컴퓨터/노트북	: 컴퓨터
	* 	4 태블릿/모바일	: 디지털/가전
	* 	5 스포츠/자동차	: 스포츠/자동차
	* 	6 유아/식품		: 패션/라이프
	* 	7 가구/생활		: 패션/라이프
	* 	8 패션/화장품	: 패션/라이프
	*/
	// 디지털/가전:01 컴퓨터:02, 스포츠/자동차:03, 패션/라이프:07, 쇼핑가이드:06
	// 삭제 => 유아/라이프:04, 패션/뷰티:05
	if (strGcate.equals("1") || strGcate.equals("2") || strGcate.equals("4")) {
		strLLCate = "01";
	} else if(strGcate.equals("3")) {
		strLLCate = "02";
	} else if(strGcate.equals("5")) {
		strLLCate = "03";
	} else if(strGcate.equals("6") || strGcate.equals("7") || strGcate.equals("8")) {
		strLLCate = "07";
	}

	out.println(new Cpp_Proc_2018().getNew(strLLCate).toString());
%>
