<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.edeal.Edeal_Order_Proc"%>
<%@page import="com.enuri.bean.event.every.Newyear_2017"%>
<%@page import="com.enuri.util.seed.Seed_Proc"%>
<%@page import="com.enuri.bean.mobile.Event_Welcome_Proc" %>
<jsp:useBean id="ShortUrl" class="com.enuri.util.http.ShortUrl" scope="page" />
<%
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date()); 								//	오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크

	if(referer.indexOf("enuri.com") > -1){
		if(referer.indexOf("dev") > -1 && !"".equals(sdt)){
			strToday = sdt;
		}
	    if(Integer.parseInt(strToday) < 20180129 || 20180218 < Integer.parseInt(strToday)){
			return;
	    }
	}else{
		return;
	}

	/*
	procCode
		1 : 사다리 참여
		2 : 카드 참여
		3 : 구매응모 참여
	*/
	int procCode = ChkNull.chkInt(request.getParameter("procCode"));				//	이벤트 유형
    int intResultValue = 0; 														// 	결과값
    JSONObject jSONObject = new JSONObject();
	String eventId = "2018012901"; 													//	이벤트코드
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); 	// 	참여 os type

    try{
    	if(1 == procCode){
        	/*
        	intResultValue
    	    	-99 		: 임직원
    	    	-55 		: 오늘날짜로 참여가 아닌경우
    	    	-1  		: 이미 두번 참여
    	    	-2			: 당일 1번참여 + 카드응모 X
    	    	 0 - 5000 	: 리워드지급성공 및 액수반환
        	*/
        	boolean isEnuriEmployee = false; 										//	임직원여부

     		if(!userId.equals("")){
         		if(new Edeal_Order_Proc().isEnuriEmployee(userId)){
         			intResultValue = -99;
         		}else{
         	        intResultValue = new Event_Welcome_Proc().random_event_ins_card(eventId, userId, strToday, osType);
         		}
     	    }
        }else if(2 == procCode){
        	/*
        	intResultValue
    	    	-1			: 실패
    	    	xxx 		: 성공한 카드의 seq 번호
        	*/
        	String cardImg = ChkNull.chkStr(request.getParameter("cardImg"),"");
        	String cardMsg = ChkNull.chkStr(request.getParameter("cardMsg"),"");
        	String cardDear = ChkNull.chkStr(request.getParameter("cardDear"),"");
        	String cardFrom = ChkNull.chkStr(request.getParameter("cardFrom"),"");
        	String strImg = ChkNull.chkStr(request.getParameter("img"),"");

        	if(referer.indexOf("dev") > -1 && !"".equals(sdt)){
           		intResultValue = new Newyear_2017().insertCard(userId, eventId, cardMsg, cardDear, cardFrom, cardImg, osType, strToday);
    		}else{
           		intResultValue = new Newyear_2017().insertCard(userId, eventId, cardMsg, cardDear, cardFrom, cardImg, osType);
    		}

       		if(intResultValue > 0){
       			String defaultUrl = "http://" + request.getServerName();
       			if("PC".equals(osType)){
       				defaultUrl += "/event2018/newyear_2018.jsp?img=" + strImg;
       			}else{
       				defaultUrl += "/mobilefirst/evt/newyear_card.jsp?cardSeq=" + intResultValue;
       			}
       			ShortUrl urlMaker = new ShortUrl();
       			String shortUrl = urlMaker.getShortUrl(defaultUrl);
       			jSONObject.put("url", shortUrl);
       			jSONObject.put("cardImg", cardImg);
       		}
        }else if(3 == procCode){
        	/*
        	intResultValue
    	    	-1			: 이미 참여
    	    	 1	 		: insert 성공
    		*/
    		eventId = "2018012902";
        	String uphone = ChkNull.chkStr(request.getParameter("uphone"), "").trim();
        	if(uphone.length()>10){
    	   		String ceedUphone = new Seed_Proc().EnPass_Seed(uphone);
    	   		intResultValue = new Newyear_2017().setPhoneEventIns(eventId, userId, ceedUphone, osType, strToday);
        	}
        }
    }catch(Exception e){}

    jSONObject.put("result",intResultValue);
	out.println(jSONObject.toString());
%>
