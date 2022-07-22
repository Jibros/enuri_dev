<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="com.enuri.bean.main.deal.CrazyDeal_ShareEvt_Proc"%>
<%@page import="org.json.*"%>
<%
	
/*

	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date()); 								//	오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크
	boolean isDev = false;
	
	String eventId = ChkNull.chkStr(request.getParameter("event_id"),"2018072301");
	String evnt_cd = ChkNull.chkStr(request.getParameter("evnt_cd"),"C");
	
	if (referer.indexOf("dev") > -1 && !"".equals(sdt)) {
		strToday = sdt;
		isDev = true;
	}
	if (referer.indexOf("enuri.com") < 0) {
		return;
	}
	
	//procCode
	//	1 : 이벤트 정보 API
	//	2 : 댓글 리스트 API
	//	3 : 공유 INSERT
	//	4 : 댓글 INSERT
	
	int procCode = ChkNull.chkInt(request.getParameter("procCode"));				//	이벤트 유형

	JSONObject jSONObject = new JSONObject();
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); 	// 	참여 os type
	CrazyDeal_ShareEvt_Proc proc = new CrazyDeal_ShareEvt_Proc();
	
	
	if(procCode == 1 || procCode == 2){
    	Map<String, Object> eventApi = proc.getEventData(strToday, isDev,evnt_cd);

    	if(!eventApi.isEmpty()) {
			if(procCode == 1) {
        		jSONObject = new JSONObject(eventApi);
        	} else {
        		int iPageno = ChkNull.chkInt(request.getParameter("pageno"),1);
        		int iPageSize = ChkNull.chkInt(request.getParameter("pagesize"),10);
        		
        		jSONObject.put("eventlist",
        				proc.get_List(iPageno, iPageSize, eventId, "N", eventApi.get("EVNT_S_DT").toString(), eventApi.get("EVNT_E_DT").toString()));
        	}	
    	}
    	
	}else if(procCode == 3){
    	String shareType = ChkNull.chkStr(request.getParameter("shareType"),"");
    	String osCode = "1";
    	
    	if(osType.indexOf("PC") > -1) {
    		osCode = "1";
    	} else if(osType.indexOf("MW") > -1) {
    		osCode = "2";
    	}  else if(osType.indexOf("MA") > -1) {
    		osCode = "3";
    	}
    	
		jSONObject.put("result", proc.shareInsert(userId, shareType, osCode));
    }else if(procCode == 4) {
    	String replyMsg = ChkNull.chkStr(request.getParameter("replyMsg"),"");
		boolean isResult = false;
		
		//sns 인증회원 확인
		boolean bcertify= new Sns_Login().isSnsMemberCertify2(userId);
		if(!bcertify){
			jSONObject.put("result", -5);
			out.println(jSONObject.toString());
			return;
		}
		
		try{
			if(!"".equals(replyMsg) && !"".equals(userId)){
				isResult = proc.replyInsert(strToday, userId, eventId, replyMsg, osType);
			}
		} catch(Exception ex) {}
		
    	jSONObject.put("result", isResult);

    }

	out.println(jSONObject.toString());
	*/
%>
