<%@page import="com.enuri.bean.mobile.Event_Lina_Proc"%>
<%@page import="com.enuri.bean.edeal.Edeal_Order_Proc"%>
<%@page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page import="com.enuri.bean.mobile.Mobile_Stamp_Proc"%>
<%
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date()); 								//	오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크

 	if (referer.indexOf("enuri.com") > -1) {
		if ( (referer.indexOf("dev") > -1 &&  !"".equals(sdt) && request.getServerName().equals("dev.enuri.com"))) {
			strToday = sdt;
		}
	} else {
		return;
	} 

    //실서버 테스트용
   /*  if ( referer.indexOf("enuri.com") > -1 &&  !"".equals(sdt)) {
        strToday = sdt;
    } */

	/*
	procCode
		1 : 대상자체크
		2 : 대상자체크 + 스탬프 응모
	*/
	int procCode = ChkNull.chkInt(request.getParameter("procCode"));				//	이벤트 유형
    int intResultValue = 0;	// 대상 여부
    int insertResult = 0;	// 신청 결과
    JSONObject jSONObject = new JSONObject();
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); 	// 	참여 os type
	String optpcd = ChkNull.chkStr(request.getParameter("optpcd")); 	// 	참여 os type

	Edeal_Order_Proc edeal_order_proc = new Edeal_Order_Proc();
	boolean IsEnuriEmployee = false;
	if(userId.length()>0) 	IsEnuriEmployee = edeal_order_proc.isEnuriEmployee(userId);

	//에누리직원은 응모할수없다
	if(IsEnuriEmployee){
		jSONObject.put("chkValue",-99);
		out.println(jSONObject.toString());
		return;
	}
	//sdu 회원이 인증이 안되어 있다면 true
	//이벤트 참여 불가
	//노병원 2018/10/11
	Members_Proc mp = new Members_Proc();
	if(mp.SduCerify(userId)){
		jSONObject.put("chkValue", -5);
		out.println(jSONObject.toString());
		return;
	}

	//sns 인증회원 확인
	boolean bcertify= new Sns_Login().isSnsMemberCertify(userId);
	if(!bcertify){
		jSONObject.put("chkValue", -6);
		out.println(jSONObject.toString());
		return;
	}

	//생일 이벤트 코드는 매년 새로 생성(중복 체크)
// 	String birthdayEventId = "2021010111"; 		//2021년 생일 이벤트 코드
	String birthdayEventId = "2022010111"; 		//2022년 생일 이벤트 코드

    try{
    	Mobile_Stamp_Proc proc = new Mobile_Stamp_Proc();

    	if(1 == procCode || 2 == procCode){
        	/*
        	intResultValue
	        	 음수 : 대상자가 아닙니다. ( -1: 이미 신청  -2: 스탬프 미참여 -3: 본인인증X  -4 : 생일 x )
	        	 0  : 오류
	        	 1  : 생일스탬프 참여 대상자
        	*/
     		if(!userId.equals("")){
				int intRefSeq = 1555;

				intResultValue = proc.birthDayChk(birthdayEventId,userId,intRefSeq,strToday);

    	 	    //insert
	        	if(2 == procCode && 1 == intResultValue) {
	        		//insertResult = proc.ins_event(birthdayEventId, userId).getInt("result");
	        		Event_Lina_Proc elp = new Event_Lina_Proc();
	        		insertResult = elp.ins_event_optpcd(userId, birthdayEventId ,osType,optpcd).getInt("result");
	        	}
     		}
        }
    }catch(Exception e){}

    jSONObject.put("chkValue",intResultValue);
    jSONObject.put("insertResult",insertResult);
	out.println(jSONObject.toString());
%>
