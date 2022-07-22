<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page import="com.enuri.bean.event.DBDataTable"%>
<%@page import="com.enuri.bean.event.DBWrap"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.event.every.Newyear_2017"%>
<%@page import="com.enuri.util.seed.Seed_Proc"%>
<%@page import="com.enuri.bean.mobile.Event_Welcome_Proc" %>
<%@page import="com.enuri.bean.mobile.Event_Lina_Proc"%>
<%
	//String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
	
	String sdt = "20191029";
	
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date()); 								//	오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크
	
	String answer = ChkNull.chkStr(request.getParameter("ans")).trim(); 				//	테스트 날짜
	
	String eventid = "2019102805";
	
	//if (referer.indexOf("dev") > -1 && !"".equals(sdt)) {
	strToday = sdt;
	//}
	//if (referer.indexOf("enuri.com") < 0 || Integer.parseInt(strToday) < 20190819 || 20190915 < Integer.parseInt(strToday) ) {
//		return;
//	}
	/*
	procCode
		1 : 2019추석 토끼
		2 : 구매응모 참여
	*/
	int procCode = ChkNull.chkInt(request.getParameter("procCode"));				//	이벤트 유형
    int intResultValue = -3; 														// 	결과값
    JSONObject jSONObject = new JSONObject();
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); 	// 	참여 os type

    try{
    	if(1 == procCode){
        	/*
        	intResultValue
    	    	-2	 		: 임직원
    	    	-55 		: 오늘날짜로 참여가 아닌경우
    	    	-1  		: 당일 참여 완료
    	    	 0 - 10000 	: 리워드지급성공 및 액수반환
        	*/
        	
     		if(!userId.equals("")){
     			
     			//sns 인증회원 확인
     			boolean bcertify= new Sns_Login().isSnsMemberCertify2(userId);
     			
     			if(!bcertify){
     				intResultValue = -6;
     				
     			}else if("매주수요일".equals(answer)){
     				
     				String query3 = " select count(*) CNT from EVENT_EVERY_USER where event_id = ?  ";
     	    		DBDataTable dt3 = new DBWrap("member").setQuery(query3).addParameter(eventid).selectAllTry();
     	    		int cnt = dt3.parse(0, "CNT", 0);
     	    		
     	    		if(cnt < 2500){
     	    			intResultValue = new Event_Welcome_Proc().random_event_ins(eventid , userId, strToday, osType);	
     	    		}else{
     	    			intResultValue = -3;
     	    		}
     					
            	}else{
            		intResultValue = -9;//오답
            	}
     	    }
        }else if(2 == procCode){
        	
    		String query4 = " select count(*) CNT from EVENT_EVERY_USER where event_id = ?  ";
    		DBDataTable dt4 = new DBWrap("member").setQuery(query4).addParameter(eventid).selectAllTry();
    		int userCnt = dt4.parse(0, "CNT", 0);
    		
    		jSONObject.put("userCnt",userCnt);
        	
        }
    }catch(Exception e){}

    jSONObject.put("result",intResultValue);
	out.println(jSONObject.toString());
%>
