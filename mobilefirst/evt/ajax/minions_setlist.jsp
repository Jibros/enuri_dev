<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%> 
<%@page import="com.enuri.bean.mobile.Mobile_Stamp_Proc"%>
<%
    //오늘날짜 반환
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 	//테스트 날짜	
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");    
    String visitDate = formatter.format(new Date()); //오늘 날짜 (visitData, ins_date)
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); //참여 ID
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();
	
	String eventId = ""; //이벤트코드
	String startDate =""; //시작일
	String type="0"; //1: 1주차, 2:2주차
    int resultType = 0;

	if(referer.indexOf("enuri.com") > -1){
		if(!"".equals(sdt)){
			visitDate = sdt;
		}
	 	
		int intVisitDate = Integer.parseInt(visitDate);
		//System.out.println("kkk sdt:"+sdt);
		//System.out.println("kkk visitDate:"+visitDate);
		
		//1차: 8월 10일 ~ 16일
		if(intVisitDate >= 20170810 && intVisitDate < 20170817){
			eventId="2017081001";
			type="1";
			startDate="20170810";
			//startDate="20170807";//test!! 실서버 배포시 반드시 날짜 변경!!
		}	
		//2차: 8월 17일 ~ 23일
		else if(intVisitDate >= 20170817 && intVisitDate < 20170824){
			type="2";
			eventId="2017081701";
			startDate="20170817";
			//startDate="20170807"; //test!! 실서버 배포시 반드시 날짜 변경!!
		}else{
			type="3";// 이벤트가 종료되었습니다.
		}
		
	    if(!"".equals(eventId) && !"".equals(userId)){
	        Mobile_Stamp_Proc mobile_Stamp_Proc = new Mobile_Stamp_Proc();
	        resultType = mobile_Stamp_Proc.minions_ins_proc(eventId, userId, startDate);
	    }
	}
    JSONObject jSONObject = new JSONObject();
    jSONObject.put("result",resultType); // 참여결과
    jSONObject.put("type",type); // 참여 이벤트 유형
	out.println(jSONObject.toString());
%>