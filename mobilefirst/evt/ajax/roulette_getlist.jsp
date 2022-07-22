<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.mobile.Event_Welcome_Proc" %>
<%
    String eventId = "2017032802"; //이벤트코드

    String eventId1 = "2019120120"; //1차 이벤트코드
    String eventId2 = "2019120121"; //2차 이벤트코드

	String userId = cb.GetCookie("MEM_INFO","USER_ID"); //참여 ID
   	String startDate = "";
   	String endDate = "";
   	long cTime = System.currentTimeMillis();
   	SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
   	String today = dayTime.format(new Date(cTime));//진짜시간
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 	//테스트 날짜
   	if(!"".equals(sdt)){
   		today = sdt;
   	}
	Calendar calendar = Calendar.getInstance();

   	int year = Integer.parseInt(today.substring(0, 4));
   	int month = Integer.parseInt(today.substring(4, 6))-1;

   	calendar.set(year, month, 1);

   	int DayOfMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);

   	String nowDay = String.valueOf(DayOfMonth);
   	if(DayOfMonth < 10){
   		nowDay = "0"+DayOfMonth;
   	}
   	startDate = today.substring(0, 6) + "01";
   	endDate = today.substring(0, 6) + nowDay;


   	//10월룰렛 예외처리
   	int intToday = Integer.parseInt(today);
   	if(intToday >= 20170929 && intToday <=20171031){
   		startDate = "20170929";
   		endDate = "20171031";
   		eventId="2017100108";
   	}
   	//1일 2회 참여룰렛 예외처리
   	String isVer2 = "";
	if("2017100108".equals(eventId)){
		isVer2 = "_V2";
	}

	/*
    if( request.getParameter("sdt")!=null && !request.getParameter("sdt").equals("")){
       sdt= request.getParameter("sdt");
   }
   	int numSdt = Integer.parseInt(sdt);
	if(numSdt >= 20170801){
		startDate="20170801";
		endDate="20170831";
	}
	*/
    Event_Welcome_Proc event_welcome_proc = new Event_Welcome_Proc();

    JSONObject jSONObject = new JSONObject();
	JSONObject cntObj = new JSONObject();

	cntObj = event_welcome_proc.eventUser2thCntByDate(eventId1, eventId2, userId, today);
	jSONObject.put("cntObj", cntObj);

// 	if(intToday < 20191201){
// 		int rouletteCnt = 0;
// 		rouletteCnt = event_welcome_proc.eventUserCntByDate(eventId, userId, startDate, endDate, isVer2);
// 		jSONObject.put("rouletteCnt", rouletteCnt);
// 	}

    out.println(jSONObject.toString());
%>