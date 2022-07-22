<%@page import="com.enuri.bean.biz.Biz_Btn_Data"%>
<%@page import="com.enuri.bean.edeal.Edeal_Order_Proc"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.event.every.Newyear_2017"%>
<%@page import="com.enuri.util.seed.Seed_Proc"%>
<%@page import="com.enuri.bean.mobile.Event_Welcome_Proc" %>
<%@page import="com.enuri.bean.mobile.Event_Lina_Proc"%>
<%@page import="com.enuri.bean.bizm.Bizm_Proc"%>
<%@page import="com.enuri.bean.bizm.Bizm_Data"%>
<%@page import="com.enuri.bean.event.Members_Friend_Proc2"%>
<%@page import="com.enuri.bean.member.Join_Data"%>
<%@page import="com.enuri.bean.biz.Biz_Proc" %>
<%@page import="com.enuri.bean.biz.Biz_Data"%>
<%@page import="com.enuri.exception.ExceptionManager"%>
<%
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date()); 								//	오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크
	String server = "real";
	
	String event_id = "";
	if(com.enuri.util.date.DateStr.nowStr("HH:mm").compareTo("00:00")>=0 && com.enuri.util.date.DateStr.nowStr("HH:mm").compareTo("12:00")<0){
		event_id = "2021110101";
	}else{
		event_id = "2021110105";
	}
	if (referer.indexOf("dev") > -1 || !"".equals(sdt) || referer.indexOf("stagedev") > -1) {
		strToday = sdt;

	}
	if(referer.indexOf("dev")>-1){
		server = "dev";
	}
	/* if (referer.indexOf("enuri.com") < 0 || Integer.parseInt(strToday.substring(0,8)) < 20210118 || 20210214 < Integer.parseInt(strToday.substring(0,8)) ) {
		return;
	} */
	/*
	procCode
		1 : 2021 사다리 타기
		2 : 구매이벤트
		3 : 알림톡
	*/
	int procCode = ChkNull.chkInt(request.getParameter("procCode"));				//	이벤트 유형
    int intResultValue = -3; 														// 	결과값
    JSONObject jSONObject = new JSONObject();
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); 	// 	참여 os type
	String ostpcd = ChkNull.chkStr(request.getParameter("ostpcd"), "PC").trim(); 	// 	참여 os type
	String emoney = ChkNull.chkStr(request.getParameter("emoney"), "0").trim();

    try{
    	if(1 == procCode){
    		/*
        	intResultValue
        		-10		: ID 참여 완료
    	    	-2	 		: 임직원
    	    	-55 		: 오늘날짜로 참여가 아닌경우
    	    	-1  		: 당일 참여 완료
    	    	 0  - 10000 	: 리워드지급성공 및 액수반환
        	*/
    		if(!userId.equals("")){
    			/*boolean blIdChk = false;
    			blIdChk = new Event_Welcome_Proc().eventIdWinterCntChk(userId);
    			if(blIdChk){ // ID당 1회 / 참여 완료
    				intResultValue = -10;
        		}else{*/
        			intResultValue = new Event_Welcome_Proc().random_event_ins(event_id, userId, strToday, osType);
        		//}
     	    }
        }
    }catch(Exception e){}

    jSONObject.put("result",intResultValue);
	out.println(jSONObject.toString());
%>