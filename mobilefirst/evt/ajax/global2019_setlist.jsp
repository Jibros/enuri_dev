<%@page import="com.enuri.bean.event.DBWrap"%>
<%@page import="com.enuri.bean.event.DBDataTable"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.event.every.Newyear_2017"%>
<%@page import="com.enuri.util.seed.Seed_Proc"%>
<%@page import="com.enuri.bean.mobile.Event_Lina_Proc"%>
<%
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date()); 								//	오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크
	
	/*
	if (referer.indexOf("dev") > -1 && !"".equals(sdt)) {
		strToday = sdt;
	}else{
		
	}
	*/
	
	if (referer.indexOf("enuri.com") < 0 || Integer.parseInt(strToday) < 20191001 || 20191130 < Integer.parseInt(strToday) ) {
		
		return;
	}
	
	/*
	procCode
		1 : 참여
		2 : 방문
	*/
	int procCode = ChkNull.chkInt(request.getParameter("procCode"));				//	이벤트 유형
    int intResultValue = -3; 														// 	결과값
    JSONObject jSONObject = new JSONObject();
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); 	// 	참여 os type
	String muid = ChkNull.chkStr(request.getParameter("muid"), "").trim(); 	// 	참여 os type

    try{
    	if(1 == procCode){
    		/*
        	intResultValue
    	    	1			: 신청성공
    	    	2601		: 이미 신청
    	    	-99			: 구매내역없음
    		*/
    		//String query = " select USR_MTC_ENC from TB_ENR_USR_MTC  with (readuncommitted) where enr_usr_id = ? ";
    		//DBDataTable dt = new DBWrap("member").setQuery(query).addParameter(userId).selectAllTry();
    		//String m_idx = dt.parse(0, "USR_MTC_ENC", "");
    		
    		//int orderCnt = 0;
    		//if(m_idx.length()>0){
	    	//	String query2 = " select count(ORDER_LOGIN_ID) cnt from MERCHANT_ORDER where ORDER_LOGIN_ID = ? ";
	    	//	DBDataTable dt2 = new DBWrap("global").setQuery(query2).addParameter(m_idx).selectAllTry();
	    	//	orderCnt = dt2.parse(0, "cnt", 0);
    		//}
    		
    		//if(orderCnt<=0){
    		//	intResultValue = -99; //구매내역없음
    		//}else{
    		intResultValue = new Event_Lina_Proc().ins_event(userId, "2019101401",osType).getInt("result");
    		//}
    		
    	}else if(2 == procCode){
     		if(!userId.equals("")){
    	        //intResultValue = new Event_Welcome_Proc().random_event_ins("2019101402", userId, strToday, osType);
    	        
    	        String query3 = " select count(*) CNT from TB_EVNT_OVS_VISIT_PTCP where EVNT_CD = '2019101402' and ENR_USR_ID = ? and ins_dtm > convert(varchar(10), getdate(),121)  ";
	    		DBDataTable dt3 = new DBWrap("member").setQuery(query3).addParameter(userId).selectAllTry();
	    		int logCnt = dt3.parse(0, "CNT", 0);
    	        
	    		if(logCnt < 30){
	    			new DBWrap("member")
					.addSimpleParameter("EVNT_CD", "2019101402")
					.addSimpleParameter("ENR_USR_ID", userId)
					.addSimpleParameter("MUID", muid)
					.addSimpleParameter("OS_TP_CD", osType )
					.simpleInsert("TB_EVNT_OVS_VISIT_PTCP", "");	    			
	    		}
	    		
	    		jSONObject.put("logCnt",logCnt);
     	    }
     	
    	}else if(3 == procCode){
     		
    		String query4 = " select count(*) CNT from TB_EVNT_OVS_VISIT_PTCP where EVNT_CD = '2019101402' and ENR_USR_ID = ?  ";
    		DBDataTable dt4 = new DBWrap("member").setQuery(query4).addParameter(userId).selectAllTry();
    		int userCnt = dt4.parse(0, "CNT", 0);
    		
    		jSONObject.put("userCnt",userCnt);
    		
        }
    }catch(Exception e){
    	System.out.println(e);
    }

    jSONObject.put("result",intResultValue);
	out.println(jSONObject.toString());
%>
