<%@page import="com.enuri.bean.mobile.Event_Newsemester_Proc"%>
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
<%@page import="com.enuri.bean.main.deal.CrazyDeal_ShareEvt_Proc"%>
<%@page import="com.enuri.bean.bizm.Bizm_Proc"%>
<%@page import="com.enuri.bean.bizm.Bizm_Data"%>
<%@page import="com.enuri.bean.event.Members_Friend_Proc2"%>
<%@page import="com.enuri.bean.member.Join_Data"%>
<%@page import="com.enuri.bean.biz.Biz_Proc" %>
<%@page import="com.enuri.bean.biz.Biz_Data"%>
<%@page import="com.enuri.bean.biz.Biz_Btn_Data"%>
<%@page import="com.enuri.exception.ExceptionManager"%>
<%
	/*param*/
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); 	// 	참여 os type 
	int intCpnTpCd = ChkNull.chkInt(request.getParameter("cpntpcd"), 0); // 응모권 (1: 준비물 챙기기, 2: 공유하기, 3: app에서 참여하기, 4: app 알림 동의하기)
	int intEvntNum = ChkNull.chkInt(request.getParameter("eNum"),0);
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
	int procCode = ChkNull.chkInt(request.getParameter("procCode"));	
	
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
	
	/*
	procCode
		1 : 응모권 지급
		2 : 응모하기
	*/
    int intResultValue = -5; 														// 	결과값
    JSONObject jSONObject = new JSONObject();

	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID
	
	Event_Newsemester_Proc Event_Newsemester_Proc = new Event_Newsemester_Proc();
	Edeal_Order_Proc edeal_order_proc = new Edeal_Order_Proc();
	boolean IsEnuriEmployee = false;
	if(userId.length()>0) IsEnuriEmployee = edeal_order_proc.isEnuriEmployee(userId);
    try{
    	if(1 == procCode){ // 4번은 한 번만 지급 가능
    		if (!userId.equals("")) {
    			if (!IsEnuriEmployee) {
    				boolean blChk = false; // false 일 때 중복임.
    				blChk = Event_Newsemester_Proc.ticketCntChk(userId, intCpnTpCd, strToday); //중복체크
    				if (blChk) {
    					intResultValue = Event_Newsemester_Proc.insertTicket(userId, intCpnTpCd, strToday);
    				} else {
    					intResultValue = -1; //응모권 중복 
    				}
    			} else {
    				intResultValue = -2; //임직원
    			}
    		} 
        }else if(2 == procCode){ //step2. 자판기
    		/*
        	intResultValue
        		-3 : 응모권 사용 불가 (응모권 테이블 upd  X)
    	    	-2	 		: 임직원
    	    	-55 		: 오늘날짜로 참여가 아닌경우
    	    	0~ 	: 리워드지급성공 및 액수반환
    	    	-4 : 응모권 없음.
    	    	-5 : 초기값 
        	*/
        	//응모권 사용 후 -> 프로시저 실행
        	int intTicektCnt = 0;
        	if (!userId.equals("")) {
        		intTicektCnt = Event_Newsemester_Proc.getTicketCnt(userId); //응모권 있는지 확인
        		if ( intTicektCnt > 0) { 
        			String strEvntCd = "202202140"+intEvntNum;
                	boolean blResult = false;
                	if(IsEnuriEmployee){
                		intResultValue = -2;
                	}else{
                		blResult = Event_Newsemester_Proc.updTicket(strEvntCd, userId); //응모권 사용
                		if (blResult) {
                			intResultValue = Event_Newsemester_Proc.random_event_ins_v6(strEvntCd, userId, strToday, osType);
                		} else {
                			intResultValue = -3; 
                		}
        			}
        		} else {
        			intResultValue = -4; //응모권 없음.
        		}
        	}
        }
      }catch(Exception e){}

    jSONObject.put("result",intResultValue);
	out.println(jSONObject.toString());
%>
