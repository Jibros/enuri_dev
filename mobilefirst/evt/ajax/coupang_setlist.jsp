<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="com.enuri.bean.edeal.Edeal_Order_Proc"%>
<%@page import="com.enuri.bean.event.DBWrap"%>
<%@page import="com.enuri.bean.event.DBDataTable"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.util.seed.Seed_Proc"%>
<%@page import="com.enuri.bean.mobile.Event_Welcome_Proc" %>
<%@page import="com.enuri.bean.mobile.Event_Lina_Proc"%>
<%@page import="com.enuri.bean.event.every.Event_201608_Olympic_Proc"%>
<%@page import="com.enuri.bean.main.deal.CrazyDeal_ShareEvt_Proc"%>
<%@page import="com.enuri.bean.biz.Biz_Btn_Data"%>
<%@page import="com.enuri.bean.event.every.Newyear_2017"%>
<%@page import="com.enuri.bean.bizm.Bizm_Proc"%>
<%@page import="com.enuri.bean.bizm.Bizm_Data"%>
<%@page import="com.enuri.bean.event.Members_Friend_Proc2"%>
<%@page import="com.enuri.bean.member.Join_Data"%>
<%@page import="com.enuri.bean.biz.Biz_Proc" %>
<%@page import="com.enuri.bean.biz.Biz_Data"%>
<%@page import="com.enuri.exception.ExceptionManager"%>

<%
	JSONObject jSONObject = new JSONObject();

	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
	String answer = ChkNull.chkStr(request.getParameter("answer")).trim(); 
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date()); 								//	오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크

	
	if (referer.indexOf("enuri.com") < 0 || Integer.parseInt(strToday) > 20210630 ) {
		jSONObject.put("result",100);
		out.println(jSONObject.toString());
		return;
	}
	
	//쿠팡 신규 공유 이벤트 
	String eventCode = "2021051701";
	//String eventCode = "20190902";
	
	
	/*
	procCode
		1 : 쿠팡 최대5배적립 이벤트
		2 : 구매 이벤트
		3 : 공유하기 이벤트
	*/

	int procCode = ChkNull.chkInt(request.getParameter("proc"));				//	이벤트 유형
	int intResultValue = -99; 														// 	결과값

	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID
	String emoney = ChkNull.chkStr(request.getParameter("emoney"), "0").trim();
	String shareType = ChkNull.chkStr(request.getParameter("shareType"),"");
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); 	// 	참여 os type
	String ostpcd = ChkNull.chkStr(request.getParameter("ostpcd"), "PC").trim(); 	// 	참여 os type
	String osCode = "1";
	if(osType.indexOf("PC") > -1) {
		osCode = "1";
	} else if(osType.indexOf("MW") > -1) {
		osCode = "2";
	}  else if(osType.indexOf("MA") > -1) {
		osCode = "3";
	}

	try{
		if(1 == procCode){
			// 쿠팡 최대5배적립 이벤트

		}else if(procCode == 2) {
			// 구매 이벤트
			/*
        	intResultValue
    	    	1    : 신청성공
				2601 : 이미신청
				2602 : 신규가입자 아님
				2603 : 구매이력 없음
				2604 : 에누리직원
			boolResultStatus
    		*/
			

			// 신규가입자 체크
			String query1 = "SELECT TOP 1 convert(varchar(8),regdate,112) REGDATE FROM members WHERE userid = ?";
			DBDataTable dt1 = new DBWrap("member").setQuery(query1).addParameter(userId).selectAllTry();
			String regDate = dt1.parse(0,"REGDATE","19000101");

			//System.out.println("regDate : "+regDate);
			//System.out.println("regDate.compareTo(20210517) : "+regDate.compareTo("20210517"));

			if(regDate.compareTo("20210517") >= 0){
				
			}else{
				jSONObject.put("result",2602);
				out.println(jSONObject.toString());
				return;
			}
			


			// 쿠팡구매 이력 체크
			String query2 = " select count(userid) CNT from tbl_reward_cart where userid = ? and shop_code = '7861' and cart_order_date >= '2021-05-17'  ";
			DBDataTable dt2 = new DBWrap("member").setQuery(query2).addParameter(userId).selectAllTry();
			int cartCnt = dt2.parse(0, "CNT", 0);

			if(cartCnt > 0){
				
			}else{
				jSONObject.put("result",2603);
				out.println(jSONObject.toString());
				return;
			}



			// 에누리 직원 체크
			Edeal_Order_Proc edeal_order_proc = new Edeal_Order_Proc();
			boolean IsEnuriEmployee = false;
			if(userId.length()>0){
				IsEnuriEmployee = edeal_order_proc.isEnuriEmployee(userId);
			} 	

			if(IsEnuriEmployee){
				jSONObject.put("result",2604);
				out.println(jSONObject.toString());
				return;
			}
        	
        	intResultValue = new Event_Lina_Proc().ins_event_optpcd(userId, "2021051701", osType , ostpcd).getInt("result");

		}else if(procCode == 3) {
			// 공유하기 이벤트			
			
			CrazyDeal_ShareEvt_Proc proc = new CrazyDeal_ShareEvt_Proc();
			jSONObject.put("result", proc.shareInsert_event(userId, eventCode, shareType, osCode));
			//jSONObject.put("result", true);
		}
	}catch(Exception e){}
	
	jSONObject.put("result",intResultValue);
	out.println(jSONObject.toString());
%>