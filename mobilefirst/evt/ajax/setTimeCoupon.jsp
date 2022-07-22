<%@page import="com.enuri.bean.edeal.Edeal_Order_Proc"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="com.enuri.bean.main.deal.CrazyDeal_Proc"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.event.Event_Luckytime"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<jsp:useBean id="event_Luckytime" class="com.enuri.bean.event.Event_Luckytime" scope="page" />
<%
	String devYN = "N";
	if( request.getServerName().indexOf("dev.enuri.com") > -1 || request.getServerName().indexOf("my.enuri.com") > -1  ){
		devYN = "Y";
	}
	
	JSONObject jSONObject = new JSONObject();
	String strEnuriId =  ChkNull.chkStr(StringUtils.trim(cb.GetCookie("MEM_INFO","USER_ID")));
	// 쿠키 유저아이디 없음
	if(strEnuriId.equals("")){
		jSONObject.put("result",4);
		jSONObject.put("msg", "로그인 후 응모 가능 합니다.");
		out.println(jSONObject.toString());
		return; 
	}
	
	//long cTime = System.currentTimeMillis();
	
	Calendar cal1 = Calendar.getInstance();
	cal1.add(Calendar.HOUR, -13);
	cal1.add(Calendar.MINUTE, -40);
	Date date = cal1.getTime();    
	
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmss");

	//String sdt = dayTime.format(new Date(cTime));//진짜시간
	String sdt = dayTime.format(date);//진짜시간
	long numSdt =  Long.parseLong(sdt);
	
	long setTime = Long.parseLong("20180921130000"); //2018-09-21 13시 
	//long setTime = Long.parseLong("20180921123000"); 

	String EVENT_NO = "2018092101"; //타임쿠폰 이벤트 코드
	int limitCnt = 360; 			//쿠폰발급 제한 수량
	
	//jSONObject.put("numSdt",numSdt);
	//jSONObject.put("setTime",setTime);
	
	///////종료됨 DB 안타게 하드코딩으로 막음///////////////////////
	jSONObject.put("result", 0); //선착순 수량이 마감되었습니다.
	out.println(jSONObject.toString());
	return;
	///////종료됨 DB 안타게 하드코딩으로 막음///////////////////////
	
	//해당 시간이 전에는 응모할수 없다.
	/*
	if(setTime > numSdt ){
		jSONObject.put("result", -1);
		jSONObject.put("msg", "9월 21일 오후 1시부터 발급됩니다!");
		out.println(jSONObject.toString());
		return ;
	}
	
	Edeal_Order_Proc edeal_order_proc = new Edeal_Order_Proc();
	boolean IsEnuriEmployee = false;
	if(strEnuriId.length()>0) 	IsEnuriEmployee = edeal_order_proc.isEnuriEmployee(strEnuriId);
	
	//에누리직원은 응모할수없다
	if(IsEnuriEmployee){
		jSONObject.put("result",99);
		jSONObject.put("msg", "임직원은 응모할수 없습니다.");
		out.println(jSONObject.toString());
		return;
	}
	
	String strOsType = "";
	if((ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Linux") >= 0 )){
		strOsType = "MWA"; // WEB
	}else if(
			(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||
			(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||
			(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0)){
		strOsType = "MWI"; // WEB
	}else{
		strOsType = "PC";
	}
	
	int result = event_Luckytime.timeCouponUserIns(strEnuriId, 1, strOsType, EVENT_NO, limitCnt);

	jSONObject.put("result", result);
	out.println(jSONObject.toString());
	*/
%>