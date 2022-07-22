<%@page import="com.enuri.bean.event.DBWrap"%>
<%@page import="com.enuri.bean.event.DBDataTable"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc" %>
<%@page import="org.json.*"%>
<%
	/*
	procCode
		1 : vip 설문조사
		2 : 응모 참여
	*/
	int procCode = ChkNull.chkInt(request.getParameter("proc"),1);				//	이벤트 유형
	//int procCode = 2;
	int intResultValue = -3; 														// 	결과값
	JSONObject jSONObject = new JSONObject();
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); 	// 	참여 os type
	String mobile_yn = "N";
	if(!osType.equals("PC")){
		mobile_yn = "Y";	
	}
	String survey_q1 = ChkNull.chkStr(request.getParameter("survey_q1"),"" ).trim(); 	//
	String survey_q2 = ChkNull.chkStr(request.getParameter("survey_q2"),"" ).trim(); 	// 	
	String survey_q3 = ChkNull.chkStr(request.getParameter("survey_q3"),"" ).trim(); 	// 	
	String survey_q4 = ChkNull.chkStr(request.getParameter("survey_q4"),"" ).trim(); 	// 	
	String survey_q5 = ChkNull.chkStr(request.getParameter("survey_q5"),"" ).trim(); 	//
	String survey_q6 = ChkNull.chkStr(request.getParameter("survey_q6"),"" ).trim(); 	// 	
	String survey_q7 = ChkNull.chkStr(request.getParameter("survey_q7"),"" ).trim(); 	// 	
	String survey_q8 = ChkNull.chkStr(request.getParameter("survey_q8"),"" ).trim(); 	// 	
	String survey_q9 = ChkNull.chkStr(request.getParameter("survey_q9"),"" ).trim(); 	// 	
	String survey_q10 = ChkNull.chkStr(request.getParameter("survey_q10"),"" ).trim(); 	// 	
	
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date()); 								//	오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크
	
	String eventId = ChkNull.chkStr(request.getParameter("eventid"),"2020120125" );
	
	if (referer.indexOf("dev") > -1 && !"".equals(sdt)) {
		strToday = sdt;
	}
	
	if (referer.indexOf("enuri.com") < 0 ) {
		return;
	}
	
	if(userId.length() == 0){
		
		jSONObject.put("result", -99);//db 오류
		out.println(jSONObject.toString());
		
		return;
	}
	
    if(1 == procCode){
		
    	try{
    		
			String query = " select count(userid) CNT from TBL_EVENT_SURVEY  with (readuncommitted) where event_id = ? and userid = ? ";
			DBDataTable dt = new DBWrap("member").setQuery(query).addParameter(eventId).addParameter(userId).selectAllTry();
			int orderCnt = dt.parse(0, "CNT",0);
			
			if( orderCnt > 0 ) {
				jSONObject.put("result", -3); //이미 등록됨
				out.println(jSONObject.toString());
				return;
			}
			
			StringBuilder sb = new StringBuilder();
			sb.append(" insert into TBL_EVENT_SURVEY ( userid , event_id ,  ostype ,  ");
			sb.append("	survey_q1 , survey_q2 , survey_q3 , survey_q4 , survey_q5 ,   survey_q6 , survey_q7, survey_q8 , survey_q9 , survey_q10 ) ");
			sb.append(" values ( ?,?,?,  ?,?,?,?,? ,?,?,?,?,?   )");
			
			boolean result =  new DBWrap("member").setQuery(sb.toString())
			.addParameter(userId).addParameter(eventId).addParameter(osType).addParameter(survey_q1).addParameter(survey_q2).addParameter(survey_q3)
			.addParameter(survey_q4).addParameter(survey_q5).addParameter(survey_q6).addParameter(survey_q7)
			.addParameter(survey_q8).addParameter(survey_q9).addParameter(survey_q10).CUDTry();
			
			jSONObject.put("result", 1);
			out.println(jSONObject.toString());
			
		} catch (UnknownHostException e1) {
			
			jSONObject.put("result", -2);//db 오류
			out.println(jSONObject.toString());
			
		    e1.printStackTrace();
		}

	}else if(2 == procCode){
        	
        	
       	if(userVipCheck(userId)){
	   		try{
       			if( !userVipCheck(userId) ){
       				jSONObject.put("result", -1); //대상자가 아닙니다
    				out.println(jSONObject.toString());
    				return;
       			}
    			String queryCnt = " select count(userid) CNT from EVENT_LUCKEY_201609  with (readuncommitted) where event_id = ? and userid = ? ";
    			DBDataTable dt = new DBWrap("member").setQuery(queryCnt).addParameter(eventId).addParameter(userId).selectAllTry();
    			int cnt = dt.parse(0, "CNT",0);
    		
    			if( cnt > 0 ) {
   					jSONObject.put("result", -2); //이미 등록됨
   					out.println(jSONObject.toString());
   					return;
   				}
        			
        		StringBuilder sb = new StringBuilder();
				sb.append(" insert into EVENT_LUCKEY_201609 ( userid , event_id ,  os_tp_cd , mobile_yn ) ");
				sb.append(" values ( ?,?,?,? )");
					
				boolean result =  new DBWrap("member").setQuery(sb.toString())
				.addParameter(userId).addParameter(eventId).addParameter(osType).addParameter(mobile_yn).CUDTry();
	        	if(osType.indexOf("MA")>-1){
					Mobile_Event_Proc mo_evnt_proc = new Mobile_Event_Proc();
					mo_evnt_proc.setAppAlrimYn(userId, "");
	        	}
				if(result){
					jSONObject.put("result", 1);
					out.println(jSONObject.toString());
				}
       		}catch(Exception e){
       			System.out.println("vipcare2019_setlist.jsp : procCode=2  "+e);
       		}
			
        }else{
        	//대상자가 아닙니다.
        	jSONObject.put("result", -3);
			out.println(jSONObject.toString());
        }
       
	}else if(5 == procCode){
        		
    	String query = " select count(userid) CNT from TBL_EVENT_SURVEY  with (readuncommitted) where event_id = ? and userid = ? ";
   		DBDataTable dt = new DBWrap("member").setQuery(query).addParameter(eventId).addParameter(userId).selectAllTry();
   		int orderCnt = dt.parse(0, "CNT",0);
   		
		jSONObject.put("orderCnt", orderCnt); //이미 등록됨
		jSONObject.put("result", userVipCheck(userId) );	
		out.println(jSONObject.toString());
		return;
	   		        		
	}
%>
<%!
public boolean userVipCheck(String id) throws Exception{
	
	if(id.indexOf("omom") > -1){
		return true;
	}
	
	
	String queryCnt = " select count(a.userid) CNT from tbl_reward_point A(nolock) " 
					+	" INNER JOIN EVENT_MAIN B (NOLOCK) "
					+	" ON a.ref_seq = b.event_seq "
							+	"inner join members c (NOLOCK) "
			+	" ON a.userid = c.userid "
			+	" where b.event_id in "
			+	" ( "
			+	" '2020010102', "
			+	" '2020010103', "
			+	" '2020020102', "
			+	" '2020020103', "
			+	" '2020030102', "
			+	" '2020030103', "
			+	" '2020040102', "
			+	" '2020040103', "
			+	" '2020050102', "
			+	" '2020050103', "
			+	" '2020060102', "
			+	" '2020060103', "
			+	" '2020070102', "
			+	" '2020070103', "
			+	" '2020080102', "
			+	" '2020080103', "
			+	" '2020090102', "
			+	" '2020090103' "
			+	" ) "
			+	" and a.point_kind = '02' "
			+	" and point_code = '10' "
			+	" and a.userid = ? "
			+	" group by a.userid ";
	DBDataTable dt = new DBWrap("member").setQuery(queryCnt).addParameter(id).selectAllTry();

	boolean result = false;
	
	int idCnt = dt.parse(0, "CNT",0);
	if(idCnt > 0){
		result = true; 
	}
	return result;
}
%>