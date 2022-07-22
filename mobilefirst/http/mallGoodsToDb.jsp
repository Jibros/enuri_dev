<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="com.enuri.bean.mobile.Mobile_Social_GoodsToPrice_Proc"%>
<%@page import="com.enuri.bean.mobile.Mobile_GoodsToPricelist_Proc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@page import="java.net.*"%>
<%
	/* 몰베스트 DB 저장 */
	try {
		int CJ   	 = 806;
		int GSSHOP   = 75;
		int QOO10    = 7857;
		int NSMALL   = 974;
		int SSG   	 = 47;
		
		Mobile_Social_GoodsToPrice_Proc msgp = new Mobile_Social_GoodsToPrice_Proc (); 
		Mobile_GoodsToPricelist_Proc mgp = new Mobile_GoodsToPricelist_Proc();
		
		JSONObject json = new JSONObject();
		
		int result = 0;
		JSONArray jsonArr =  msgp.getDealToHotdeal(CJ);
		if( jsonArr.length() > 10 ){
			result = mgp.hotDealInsUpd("H", String.valueOf(CJ)  , jsonArr);
			json.put(""+CJ+"", jsonArr.length());	
		}else{
			json.put(""+CJ+"_lack", jsonArr.length());
		}
		
		jsonArr =  msgp.getDealToHotdeal(GSSHOP);
		if( jsonArr.length() > 10 ){
			result = mgp.hotDealInsUpd("H", String.valueOf(GSSHOP)  , jsonArr);
			json.put(""+GSSHOP+"", jsonArr.length());
		}else{
			json.put(""+GSSHOP+"_lack", jsonArr.length());
		}
		
		jsonArr =  msgp.getDealToHotdeal(QOO10);
		if( jsonArr.length() > 10 ){
			result = mgp.hotDealInsUpd("H", String.valueOf(QOO10)  , jsonArr);
			json.put(""+QOO10+"", jsonArr.length());
		}else{
			json.put(""+QOO10+"_lack", jsonArr.length());
		}

		jsonArr =  msgp.getDealToHotdeal(NSMALL);
		if( jsonArr.length() > 10 ){
			result = mgp.hotDealInsUpd("H", String.valueOf(NSMALL)  , jsonArr);
			json.put(""+NSMALL+"", jsonArr.length());
		}else{
			json.put(""+NSMALL+"_lack", jsonArr.length());
		}
		
		jsonArr =  msgp.getDealToHotdeal(SSG);
		if( jsonArr.length() > 10 ){
			result = mgp.hotDealInsUpd("H", String.valueOf(SSG)  , jsonArr);
			json.put(""+SSG+"", jsonArr.length());
		}else{
			json.put(""+SSG+"_lack", jsonArr.length());
		}

		out.println(json.toString());
	}catch(Exception e){
		System.out.println("eee"+e);
	}
%>