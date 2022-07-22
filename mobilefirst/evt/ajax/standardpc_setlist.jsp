<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="com.enuri.bean.edeal.Edeal_Order_Proc"%>
<%@page import="com.enuri.bean.event.DBWrap"%>
<%@page import="com.enuri.bean.event.DBDataTable"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.util.seed.Seed_Proc"%>
<%@page import="com.enuri.bean.mobile.Event_Lina_Proc"%>
<%@page import="com.enuri.bean.event.every.Event_201608_Olympic_Proc"%>
<%@page import="com.enuri.bean.main.deal.CrazyDeal_ShareEvt_Proc"%>
<%
	JSONObject jSONObject = new JSONObject();

	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
	String answer = ChkNull.chkStr(request.getParameter("answer")).trim(); 
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date()); 								//	오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크

	
	if (referer.indexOf("enuri.com") < 0 || Integer.parseInt(strToday) > 20210228 ) {
		jSONObject.put("result",100);
		out.println(jSONObject.toString());
		return;
	}
	
	//에누리 표준PC 구매 이벤트 
	String eventCode1 = "2021020301";
	//에누리 표준PC 공유 이벤트 
	String eventCode2 = "2021020302";
	
	/*     
	procCode
		1 : 구매
	*/
	int procCode = ChkNull.chkInt(request.getParameter("proc"));				//	이벤트 유형
	if(1 == procCode){
	    int intResultValue = -3; 														// 	결과값
	    
		String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID
		String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); 	// 	참여 os type
		
		//임직원체크
		boolean IsEnuriEmployee = false;
		
		if(userId.length()>0) {
			Edeal_Order_Proc edeal_order_proc = new Edeal_Order_Proc();
			IsEnuriEmployee = edeal_order_proc.isEnuriEmployee(userId);
		}
		
		if(IsEnuriEmployee){
			jSONObject.put("result",-100);
			out.println(jSONObject.toString());
			return;
		}
	    try{
	   		if(!userId.equals("")){
	   			
	      		/*
	          	intResultValue
	      	    	1			: 신청성공
	      	    	2601		: 이미 신청
	      	    	-99			: 구매내역없음
	      		*/
	      		/*String query = " select count(*) CNT from tbl_reward_cart (nolock) where userid = ? and regdate>='2020-12-07'";
	      		DBDataTable dt = new DBWrap("member").setQuery(query).addParameter(userId).selectAllTry();
	      		int cartCnt = dt.parse(0, "CNT", 0);
	      	
	      		if(cartCnt > 0){*/
	      			intResultValue = new Event_Lina_Proc().ins_event_optpcd(userId, eventCode1  ,osType ,osType ).getInt("result");	
	      		/*}else{
	      			intResultValue = -99;
	      		}*/
	   			
	   	    }
	    }catch(Exception e){
	    	System.out.println(e);
	    }
	    jSONObject.put("result",intResultValue);
	}else if(procCode == 2) {
		String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID
		String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); 	// 	참여 os type
		
		String shareType = ChkNull.chkStr(request.getParameter("shareType"),"");
    	String osCode = "1";

    	if(osType.indexOf("PC") > -1) {
    		osCode = "1";
    	} else if(osType.indexOf("MW") > -1) {
    		osCode = "2";
    	}  else if(osType.indexOf("MA") > -1) {
    		osCode = "3";
    	}
    	
    	CrazyDeal_ShareEvt_Proc proc = new CrazyDeal_ShareEvt_Proc();
		jSONObject.put("result", proc.shareInsert_event(userId, eventCode2, shareType, osCode));
    	//jSONObject.put("result", true);
	}
	
	out.println(jSONObject.toString());
%>