<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="org.apache.commons.lang3.*"%>
<%@page import="org.json.*"%>
<%@ page import="com.enuri.include.*"%>
<%@ page import="com.enuri.util.etc.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.util.image.*"%>
<%@ page import="com.enuri.util.http.*"%>
<%@ page import="com.enuri.util.date.*"%>
<%@page import="com.enuri.bean.mobile.Cpp_Proc"%>
<%@page import="com.enuri.bean.mobile.Cpp_Proc2"%>
<%

	String strGcate = ChkNull.chkStr(request.getParameter("gcate"), ""); // CPP카테고리
	String strLLCate= "";

	/*
	* 	1  가전/TV				: 디지털/가전
	* 	2  컴퓨터/노트북/조립PC	: 컴퓨터
	* 	3  태블릿/모바일/디카	: 디지털/가전
	* 	4  스포츠 아웃도어		: 스포츠/자동차
	* 	5  공구/자동차			: 스포츠/자동차
	* 	6  가구/인테리어		: 패션/라이프
	* 	7  유아/식품/건강		: 패션/라이프
	* 	8  생활/주방용품		: 패션/라이프
	* 	9  반려/취미/문구		: 패션/라이프
	* 	10 패션/화장품			: 패션/라이프
	* 	11 명품관				: 패션/라이프
	*/
 	if(strGcate.equals("1") || strGcate.equals("3")){
		strLLCate = "01";
	}else if(strGcate.equals("2")){
		strLLCate = "02";
	}else if(strGcate.equals("4") || strGcate.equals("5")){
		strLLCate = "03";
	}else if(strGcate.equals("6") || strGcate.equals("7") || strGcate.equals("8") || strGcate.equals("9") || strGcate.equals("10") || strGcate.equals("11")){
		strLLCate = "07";
	}

	out.println(new Cpp_Proc().getNews2(strLLCate).toString());
%>
