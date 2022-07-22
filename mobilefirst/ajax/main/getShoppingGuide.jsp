<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="org.apache.commons.lang3.*"%>
<%@page import="org.json.*"%>
<%@ page import="com.enuri.include.*"%>
<%@ page import="com.enuri.util.etc.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.util.image.*"%>
<%@ page import="com.enuri.util.http.*"%>
<%@ page import="com.enuri.util.date.*"%>
<%@page import="com.enuri.bean.mobile.Shopping_Guide_Proc"%>
<%

	String strKbcate 		= ChkNull.chkStr(request.getParameter("kbcate"	    ),""	    ); //  지식통카테고리
	
	//지식통 분류 정의
	String[] ArrKbCate = {"kb0","kb10","kb1","kb5","kb2","kb4","kb7","kb8","kb9","kb11"};
	String[] ArrKbCateName = new String[ArrKbCate.length];
	
	ArrKbCateName[0] = "휴대폰";
	ArrKbCateName[1] = "테블릿PC";
	ArrKbCateName[2] = "디카·MP3";
	ArrKbCateName[3] = "가전";
	ArrKbCateName[4] = "노트북";
	ArrKbCateName[5] = "컴퓨터";
	ArrKbCateName[6] = "자동차·레저";
	ArrKbCateName[7] = "유아·생활"; 
	ArrKbCateName[8] = "패션·뷰티";
	
	/*
		전체 : http://dev.enuri.com/mobilefirst/ajax/main/getShoppingGuide.jsp	
		iT·휴대폰 : http://dev.enuri.com/mobilefirst/ajax/main/getShoppingGuide.jsp?kbcate=kb0,kb10
		디카·DSLR: http://dev.enuri.com/mobilefirst/ajax/main/getShoppingGuide.jsp?kbcate=kb1
		가전 : http://dev.enuri.com/mobilefirst/ajax/main/get1ShoppingGuide.jsp?kbcate=kb5
		컴퓨터 : http://dev.enuri.com/mobilefirst/ajax/main/getShoppingGuide.jsp?kbcate=kb4,kb2
		레저·자동차 : http://dev.enuri.com/mobilefirst/ajax/main/getShoppingGuide.jsp?kbcate=kb7
		유아·생활 : http://dev.enuri.com/mobilefirst/ajax/main/getShoppingGuide.jsp?kbcate=kb8
		패션·뷰티 : http://dev.enuri.com/mobilefirst/ajax/main/getShoppingGuide.jsp?kbcate=kb9
	*/
			
	String[][] ArrKbCategory = new String[ArrKbCate.length][];
	
	int kbCate1Idx = 0;
	int kbCateIdx = 0;
	
	if(strKbcate.equals("kb0,kb10")){	 //디지털/가전
		try{
			ArrKbCategory[kbCate1Idx++] = CateParser("03,05,06,24,22,!0362,!0363,!0364");
		}catch(Exception e){
			System.out.println("shopping_guide_proc:"+e);
		}
		 
	}else if(strKbcate.equals("kb1")){ //컴퓨터
		ArrKbCategory[kbCate1Idx++] = CateParser("04,07");
	}else if(strKbcate.equals("kb5")){ //스포츠/자동차
		ArrKbCategory[kbCate1Idx++] = CateParser("09,21,0362,0363,0364"); 
	}else if(strKbcate.equals("kb4,kb2")){ //유아/라이프
		ArrKbCategory[kbCate1Idx++] = CateParser("08,10,12,14,15,16,18");  
	}else{  
		ArrKbCategory[kbCate1Idx++] = new String[0]; 
	}
	if(strKbcate.equals("")){
		//전체일때는 100개(최신 30개 중에 모바일 이미지 없는 케이스가 많아서 갯수 늘림)
			out.println(new Shopping_Guide_Proc().getShoppingGuideList(ArrKbCategory[0], "kc1",  "regdate", 1, 100).toString());	
	}else{ 
		//카테고리일때는 30개(최신 30개 중에 모바일 이미지 있는것만 노출, 순수한 등록날짜순)
			out.println(new Shopping_Guide_Proc().getShoppingGuideList(ArrKbCategory[0], "kc1",  "regdate2", 1, 100).toString());	
	} 
%>
   
<%! 
public String[] CateParser(String strCateList){
    return strCateList.replaceAll(" ","").split(",");
}
%>  