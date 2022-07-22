<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.mobile.Event_Welcome_Proc" %>
<%
    //대상자 확인기간
    String chkStartDate = "20170101";
    String chkEndDate = "20170328";
  
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));

    int allCartCnt=0; //2016.2.1 이후 구매건수 (04)
    int recentCartCnt=0; //최근 3개월 (2017.1.1 이후) 구매체결건수
    
    Event_Welcome_Proc event_welcome_proc = new Event_Welcome_Proc();
    allCartCnt = event_welcome_proc.getAllCartCnt("20160201",userId);
    recentCartCnt = event_welcome_proc.getRecentCartCnt(chkStartDate, chkEndDate,userId);

    boolean blReturn = false;

    //대상자
    if(allCartCnt > 0 && recentCartCnt==0){
    	blReturn=true;
    }
    //대상자아님
    else{
    	blReturn=false;
    }
    
    JSONObject jSONObject = new JSONObject(); 
    jSONObject.put("result",blReturn); // 지급결과를 넣는다.
	out.println(jSONObject.toString());
%>
