<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="com.enuri.bean.mobile.Event_Newsemester_Proc" %>
<%@page import="java.util.*"%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%
	int intGetType = ChkNull.chkInt(request.getParameter("type")); //1 : 응모권 개수, 2 : 상품 잔여 개수, 3: 오늘 응모권 받은 여부
	String sdt = ChkNull.chkStr(request.getParameter("sdt"));  // 테스트 날짜
	
	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	String strToday = formatter.format(new Date());
	String referer = ChkNull.chkStr(request.getHeader("referer"));
	String strStartDate = "20220411";
	String strEndDate = "20220508";
	
	if(referer.indexOf("dev") > -1 && !"".equals(sdt)){
		strToday = sdt;
	}

	// 실서버 반영 시 주석 해제
	if (referer.indexOf("enuri.com") < 0 
	|| Integer.parseInt(strToday) < Integer.parseInt(strStartDate) 
	|| Integer.parseInt(strToday) > Integer.parseInt(strEndDate)) {
		return;
	}
	
	String userId = cb.GetCookie("MEM_INFO","USER_ID"); //참여 ID
	Event_Newsemester_Proc Event_Newsemester_Proc = new Event_Newsemester_Proc();
	JSONObject resultObj = new JSONObject();
	int intResult = 0;
	
	try{
		if (intGetType > 0) {
			if (intGetType == 1) { //응모권 개수
				intResult = Event_Newsemester_Proc.getEventTicketCnt(userId, strStartDate, strEndDate); //이벤트 기간 내 응모권 개수
				resultObj.put("result", intResult);
			} else if(intGetType == 2) { //상품잔여개수 
				String strEventId = "2022040501,2022040502,2022040503,2022040504,2022040505,2022040506";
				JSONArray evntJarray = new JSONArray();
				JSONArray evntRewardJarray = new JSONArray();
				evntJarray = Event_Newsemester_Proc.getEventData(strEventId, strToday); //상품 당첨 확률 데이터
				
	 			for(int i = 0; i < evntJarray.length(); i++) {
	 				JSONObject parseObj = new JSONObject();
					parseObj = evntJarray.getJSONObject(i);
		 			String strEventCd = parseObj.getString("event_id");
					int intItemPoint = parseObj.getInt("item_point");
					int intLimitCnt = parseObj.getInt("limit_cnt"); //일 제한 개수 
					int intRewardProdCnt = Event_Newsemester_Proc.getRewardCnt(strEventCd, strToday, intItemPoint);

					JSONObject rewardResObj = new JSONObject();
					String strEvntNum = strEventCd.substring(9,10);
					rewardResObj.put("eventNum", strEvntNum);
					rewardResObj.put("itemCnt", (intLimitCnt-intRewardProdCnt)); //일 제한 수 - 당일 당첨 개수
					evntRewardJarray.put(rewardResObj);
				} 
				resultObj.put("rewardProdList", evntRewardJarray); 
			} else if(intGetType == 3) { //응모권 여부 1,2,3번은 매일 1회씩 가능, 4번은 시즌 1회 가능
				JSONObject ticketObj = new JSONObject();
				ticketObj = Event_Newsemester_Proc.getTodayTicketData(strToday, userId); //1,2,3번 응모권
				
				int intTicket4Cnt = Event_Newsemester_Proc.getEventTicket4Data(userId, strStartDate, strEndDate); //4번 응모권
				
				if ( intTicket4Cnt > 0) {
					ticketObj.put("ticket4", true);
				} else {
					ticketObj.put("ticket4", false);
				}
				resultObj.put("ticketData", ticketObj);
			}
		} 
	}catch(Exception e){}
	out.println(resultObj.toString());
%>