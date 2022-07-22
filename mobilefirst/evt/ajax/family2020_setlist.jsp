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
<%
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date()); 								//	오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크
	
	if (referer.indexOf("dev") > -1 && !"".equals(sdt)) {
		strToday = sdt;
	}
	if (referer.indexOf("enuri.com") < 0 || Integer.parseInt(strToday) < 20200413 || 20200510 < Integer.parseInt(strToday) ) {
		return;
	}
	/*
	procCode
		1 : 2020 설날 세뱃돈
		2 : 구매응모 참여
	*/
	int procCode = ChkNull.chkInt(request.getParameter("procCode"));				//	이벤트 유형
    int intResultValue = -3; 														// 	결과값
    JSONObject jSONObject = new JSONObject();
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); 	// 	참여 os type
	String ostpcd = ChkNull.chkStr(request.getParameter("ostpcd"), "PC").trim(); 	// 	참여 os type

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
    	        intResultValue = new Event_Welcome_Proc().random_event_ins("2020041301", userId, strToday, osType);
     	    }
        }else if(2 == procCode){
        	/*
        	intResultValue
    	    	1			: 신청성공
    	    	2601		: 이미 신청
    		*/
	   		//intResultValue = new Event_Lina_Proc().ins_event(userId, "2020041302").getInt("result");
        	// userid, String eventId, String osType, String osTpcd
        	
        	Edeal_Order_Proc edeal_order_proc = new Edeal_Order_Proc();
        	boolean IsEnuriEmployee = false;
        	if(userId.length()>0) 	IsEnuriEmployee = edeal_order_proc.isEnuriEmployee(userId);
        	
        	//에누리직원은 응모할수없다
        	if(IsEnuriEmployee){
        		jSONObject.put("result",-99);
        		out.println(jSONObject.toString());
        		return;
        	}
        	
        	intResultValue = new Event_Lina_Proc().ins_event_optpcd(userId, "2020041302", osType , ostpcd).getInt("result");
        	
        	
        }
    }catch(Exception e){}

    jSONObject.put("result",intResultValue);
	out.println(jSONObject.toString());
%>
