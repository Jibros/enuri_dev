<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="com.enuri.util.seed.Seed_Proc"%>
<%@page import="com.enuri.bean.member.Join_Data"%>
<%@page import="com.enuri.bean.member.Join_Proc"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page import="com.enuri.bean.mobile.Event_Lina_Proc"%>
<%@page import="org.json.*"%>

<%
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date()); 								//	오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크
	String strAppyn = "";
    JSONObject jSONObject = new JSONObject();
    int intResultValue = -99; 														// 	결과값    
	boolean blApp = false;
	//app체크
	for(int i=0;i<request.getCookies().length;i++){
		if(request.getCookies()[i].getName().equals("appYN")){
			strAppyn = request.getCookies()[i].getValue();
			break;
		}
	}
	if(strAppyn.equals("Y")){
	     if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0){
	    	 blApp=true;
	     }else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0
	       ||ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0){
	    	 blApp=true;
	     }	
	}
	 	
	if(!blApp){
	    jSONObject.put("result",intResultValue);
	    out.println(jSONObject.toString());
		return ;
	}

	if (referer.indexOf("dev") > -1 && !"".equals(sdt)) {
		strToday = sdt;
	}
	if (referer.indexOf("enuri.com") < 0 || Integer.parseInt(strToday) < 20191220 || 20200119 < Integer.parseInt(strToday) ) {
		return;
	}
	
    
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID
    try{
    	if(!userId.equals("") &&  referer.indexOf("enuri.com") > -1){
    		//sns 인증회원 확인
    		boolean bcertify= new Sns_Login().isSnsMemberCertify2(userId);
    		Join_Data join_Data = new Join_Proc().getMemberData(userId);
    		String ciKey = join_Data.getConf_ci_key();//본인인증여부
    		if(!bcertify){
    			intResultValue = -5;   	//본인인증 되지 않은 sns 회원
    		}else if ("".equals(ciKey)) {
    			intResultValue = -5; 	//일반회원 본인인증 안됨
    		}else { 					//회원 인증 통과 
    			
    		  	intResultValue = new Event_Lina_Proc().buyRecord(userId,"2019-12-24");
    			if(intResultValue>0){	// 구매내역 있음
    				/*
    	        	intResultValue
    	    	    	1			: 신청성공
    	    	    	2601		: 이미 신청
    	    		*/
    	       		intResultValue = new Event_Lina_Proc().ins_event(userId, "2019121901").getInt("result");
    	    	}else {					//구매내역 없음
    	    		intResultValue = -1;
    	    	}
    		}
        }
    }catch(Exception e){}

    jSONObject.put("result",intResultValue);
	out.println(jSONObject.toString());
%>
