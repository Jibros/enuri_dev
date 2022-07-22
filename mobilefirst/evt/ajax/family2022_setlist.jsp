<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.json.JSONObject" %>
<%@page import="org.json.JSONArray"%>
<%@page import="com.enuri.bean.edeal.Edeal_Order_Proc" %>
<%@page import="com.enuri.bean.member.Sns_Login" %>
<%@page import="com.enuri.bean.mobile.Event_Newsemester_Proc" %>
<%
	int procCode = ChkNull.chkInt(request.getParameter("procCode"));	
	int intCpnTpCd = ChkNull.chkInt(request.getParameter("cpnTpCd"), 0);  // 응모권 (1: 준비물 챙기기, 2: 공유하기, 3: app에서 참여하기, 4: app 알림 동의하기)
	int intEvntNum = ChkNull.chkInt(request.getParameter("eNum"), 0);  // 상품 번호
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC"); 
	String sdt = ChkNull.chkStr(request.getParameter("sdt"));  // 테스트 날짜
	
	String referer = ChkNull.chkStr(request.getHeader("referer"));
	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date());
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
	
	/*
	procCode
		1 : 응모권 지급
		2 : 응모하기
	*/
    int intResultValue = -6;
	boolean bCertify = false;
	boolean IsEnuriEmployee = false;

	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim();  // 참여 ID

    JSONObject jSONObject = new JSONObject();
	Event_Newsemester_Proc Event_Newsemester_Proc = new Event_Newsemester_Proc();
	Edeal_Order_Proc edeal_order_proc = new Edeal_Order_Proc();
	Sns_Login sns_login = new Sns_Login();
	
	if(userId.length() > 0) {
		IsEnuriEmployee = edeal_order_proc.isEnuriEmployee(userId);  // 임직원 체크
		bCertify = sns_login.isSnsMemberCertify2(userId);  // sns회원 본인인증 체크
	}
	
    try{
   		if(userId.equals("")) {
   			intResultValue = -5;
   		} else if(!bCertify) {
   			intResultValue = -4;
   		} else if(IsEnuriEmployee) {
   			intResultValue = -2;
   		} else { 
   			if(1 == procCode) { //step 1. 응모권 지급
	    		/*
	    		intResultValue
	    			-6 	: 지급 실패
	    			-5	: 비로그인
	    			-4	: SNS회원 본인인증 X
	    			-2	: 임직원 참여 불가
	    			-1	: 응모권 중복
	    			0	: 지급 실패
	    			1	: 응모권 지급 성공
	    		*/
   				boolean blChk = false;
   				blChk = Event_Newsemester_Proc.ticketCntChk2(userId, intCpnTpCd, strToday, strStartDate, strEndDate); //응모권 중복 체크
   				
   				if (blChk) {
   					intResultValue = Event_Newsemester_Proc.insertTicket(userId, intCpnTpCd, strToday); //응모권 지급
   				} else {
   					intResultValue = -1;
   				}
	        }else if(2 == procCode){ //step 2. 응모하기
	    		/*
	        	intResultValue
	    	    	-55 : 참여 날짜가 오늘이 아닌 경우
	    	    	-7	: 상품이 없음
	    	    	-6  : 응모 실패 
	    	    	-5	: 비로그인
	    	    	-4  : 응모권 없음
	        		-3  : 응모권 사용 불가 (응모권 테이블 upd  X)
	    	    	-2	: 임직원 참여 불가
	    	    	0	: 꽝
	    	    	1 	: 리워드 지급 성공
	        	*/
	        	//응모권 사용 후 -> 프로시저 실행
	        	int intTicketCnt = 0;
        		intTicketCnt = Event_Newsemester_Proc.getEventTicketCnt(userId, strStartDate, strEndDate); //이벤트 기간 내 응모권 개수
        		
        		if (intTicketCnt > 0) {
        			String strEvntCd = "202204050"+intEvntNum; //상품 이벤트코드
        			JSONArray evntJarray = new JSONArray();
    				evntJarray = Event_Newsemester_Proc.getEventData(strEvntCd, strToday); //상품 당첨 확률 데이터
    				int intItemPoint = evntJarray.getJSONObject(0).getInt("item_point");
    				int intLimitCnt = evntJarray.getJSONObject(0).getInt("limit_cnt"); //일 제한 개수
    				int intRewardProdCnt = Event_Newsemester_Proc.getRewardCnt(strEvntCd, strToday, intItemPoint); //당첨 수
        			
    				if((intLimitCnt - intRewardProdCnt) > 0) {
	                	boolean blResult = false;
	               		blResult = Event_Newsemester_Proc.updEventTicket(strEvntCd, userId, strStartDate, strEndDate); //응모권 사용
	               		
	               		if (blResult) {
	               			intResultValue = Event_Newsemester_Proc.random_event_ins_v6(strEvntCd, userId, strToday, osType);
	               		} else {
	               			intResultValue = -3; 
	               		}
    				} else {
	        			intResultValue = -7;
    				}
        		} else {
        			intResultValue = -4;
        		}
			}
   		}
      }catch(Exception e){}

    jSONObject.put("result",intResultValue);
	out.println(jSONObject.toString());
%>
