<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="com.enuri.bean.mobile.Event_Newsemester_Proc" %>
<%@page import="java.util.*"%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
	SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
	String strToday = formatter.format(new Date()); 								//	오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크
	String server = "real";
	if(referer.indexOf("dev")>-1){
		server = "dev";
	}
	
	//실서버 올라갈 때 주석 풀기
	if (referer.indexOf("dev") > -1 && !"".equals(sdt)) {
		strToday = sdt;
	}
	
	if (referer.indexOf("enuri.com") < 0 || Integer.parseInt(strToday) < 20220214 || 20220313 < Integer.parseInt(strToday) ) {
		return;
	}

	int intGetType = ChkNull.chkInt(request.getParameter("type"), 0); //1 : 응모권 개수, 2 : 상품 잔여 개수, 3: 오늘 응모권 받은 여부
	
	Event_Newsemester_Proc Event_Newsemester_Proc = new Event_Newsemester_Proc();
	JSONObject resultObj = new JSONObject();
	int intResult = 0;
	
	try{
		String strEnrUsrId = cb.GetCookie("MEM_INFO","USER_ID"); //참여 ID
		if (intGetType > 0) {
			if ( intGetType == 1) { //응모권 개수
				intResult = Event_Newsemester_Proc.getTicketCnt(strEnrUsrId);
				resultObj.put("result", intResult);
			} else if (intGetType == 2) { //상품잔여개수 
				//이벤트 데이터
				JSONArray evntJarray = new JSONArray();
				JSONArray evntRewardJarray = new JSONArray();
				evntJarray = Event_Newsemester_Proc.getNewsemesterEvntData(strToday); //이벤트 확률 관련 데이터
	 			for(int i = 0; i < evntJarray.length(); i++) {
	 				JSONObject parseObj = new JSONObject();
					parseObj = evntJarray.getJSONObject(i);
		 			String strEventCd = parseObj.getString("event_id");
					int intItemPoint = parseObj.getInt("item_point");
					int intLimitCnt =parseObj.getInt("limit_cnt");
					
					int intRewardProdCnt = Event_Newsemester_Proc.getRewardCnt(strEventCd, strToday, intItemPoint);
					JSONObject rewardResObj = new JSONObject();
					String strEvntNum = strEventCd.substring(9,10);
					rewardResObj.put("eventNum", strEvntNum);
					rewardResObj.put("itemCnt", (intLimitCnt-intRewardProdCnt));
					evntRewardJarray.put(rewardResObj);
				} 
				resultObj.put("rewardProdList", evntRewardJarray); 
			} else if (intGetType == 3) { //응모권 여부 1,2,3번은 매일 1회씩 가능, 4번은 시즌 1회 가능
				JSONObject ticketObj = new JSONObject();
				ticketObj = Event_Newsemester_Proc.getTodayTicketData(strToday, strEnrUsrId);
				
				int intTicket4Cnt = Event_Newsemester_Proc.getTodayTicket4Data(strEnrUsrId);
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