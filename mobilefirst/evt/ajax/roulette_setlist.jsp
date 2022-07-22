<%@page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page import="com.enuri.bean.mobile.Event_Welcome_Proc" %>
<%
    //오늘날짜 반환
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 	//테스트 날짜	
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");    
    String visitDate = formatter.format(new Date()); //오늘 날짜 (visitData, ins_date)
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); // 참여 os type
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); //참여 ID
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();
	JSONObject jSONObject = new JSONObject();
	int intResultValue = 0; //결과값
	
	//sdu 회원이 인증이 안되어 있다면 true
	//이벤트 참여 불가 
	//노병원 2018/10/11
	Members_Proc mp = new Members_Proc();
	if(mp.SduCerify(userId)){
		jSONObject.put("result", -4);
		out.println(jSONObject.toString());
		return;
	}
	
	//sns 인증회원 확인
	boolean bcertify= new Sns_Login().isSnsMemberCertify2(userId);
	if(!bcertify){
		jSONObject.put("result", -5);
		out.println(jSONObject.toString());
		return;
	}
	
    try{
    	if(referer.indexOf("enuri.com") > -1){
    		if(!"".equals(sdt))    			visitDate = sdt;
    		
    	    if(!"".equals(userId)){
    	        Event_Welcome_Proc event_welcome_proc = new Event_Welcome_Proc();
    	        int intVisitDate = Integer.parseInt(visitDate);
    			
    		    if(intVisitDate >= 20170929 && intVisitDate <= 20171031){
    		        intResultValue = event_welcome_proc.random_event_ins_v2("2017100108", userId, visitDate, osType);
    		    }else{
    		        intResultValue = event_welcome_proc.random_event_ins("2017032802", userId, visitDate, osType);
    		    }
    	    }
    	}
    }catch(Exception e){
    	System.out.println("룰렛 setlist error : "+ e);
    }
    jSONObject.put("result",intResultValue); // 결과를 넣는다.
	out.println(jSONObject.toString());
%>