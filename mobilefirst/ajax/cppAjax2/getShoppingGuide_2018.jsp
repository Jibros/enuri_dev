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

	String strKbcate 		= ChkNull.chkStr(request.getParameter("kbcate"), "");	//  지식통카테고리
	String strGcate 		= ChkNull.chkStr(request.getParameter("gcate"), "");	//  CPP카테고리

	String[][] ArrKbCategory = new String[8][];

	int kbCate1Idx = 0;
	int kbCateIdx = 0;

	if(strGcate.equals("1")){
		ArrKbCategory[kbCate1Idx++] = CateParser("05,06,24,0243");
	}else if(strGcate.equals("2")){
		ArrKbCategory[kbCate1Idx++] = CateParser("02,!0243");
	}else if(strGcate.equals("3")){
		ArrKbCategory[kbCate1Idx++] = CateParser("04,07");
	}else if(strGcate.equals("4")){
		ArrKbCategory[kbCate1Idx++] = CateParser("03,22");
	}else if(strGcate.equals("5")){
		ArrKbCategory[kbCate1Idx++] = CateParser("09,21");
	}else if(strGcate.equals("6")){
		ArrKbCategory[kbCate1Idx++] = CateParser("10,15,93");
	}else if(strGcate.equals("7")){
		ArrKbCategory[kbCate1Idx++] = CateParser("12,16,18");
	}else if(strGcate.equals("8")){
		ArrKbCategory[kbCate1Idx++] = CateParser("14,08");
	}else{
		ArrKbCategory[kbCate1Idx++] = new String[0];
	}

	out.println(new Cpp_Proc_2018().getGuide(ArrKbCategory[0], 1, 4).toString());

%>

<%!
public String[] CateParser(String strCateList){
    return strCateList.replaceAll(" ","").split(",");
}
%>