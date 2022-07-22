<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="java.net.InetAddress"%>
<%@page import="com.enuri.bean.event.every.Event_Every_Visit_Proc"%>
<%

// getParameter
	String strJob = ChkNull.chkStr(request.getParameter("job"), "").trim();			//1: 출석체크 insert
	String strOsType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); // 참여 os type
	String strEventId = ChkNull.chkStr(request.getParameter("strEventId"),"").trim(); //이벤트코드

	String sdt = ChkNull.chkStr(request.getParameter("sdt"), "").trim();  //날짜 테스트용 파라미터
	String cUserId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); //참여 ID

	SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
	String strToday = formatter.format(new Date()); //오늘 날짜 (visitData, ins_date)

	int intResultValue = 0; //결과값
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();

	JSONObject jSONObject = new JSONObject();

	if(referer.indexOf(".enuri.com") > -1){
		//sdu 회원이 인증이 안되어 있다면 true
		//이벤트 참여 불가
		//노병원 2018/10/11
		Members_Proc mp = new Members_Proc();
		if(mp.SduCerify(cUserId)){
			jSONObject.put("result", -4);
			out.println(jSONObject.toString());
			return;
		}

		// 본인인증 확인
		boolean bcertify= new Sns_Login().isSnsMemberCertify(cUserId);
		if(!bcertify){
			jSONObject.put("result", -5);
			out.println(jSONObject.toString());
			return;
		}

		// 회원 상태값 체크
		boolean bStatus = new Sns_Login().chkMemberStatus(cUserId);
		if(!bStatus){
			jSONObject.put("result", -6);
			out.println(jSONObject.toString());
			return;
		}

		if(!"".equals(sdt)){
			strToday = sdt;
		}
	    if (strJob.length() > 0 && strOsType.length() > 0 && cUserId.length() > 0) {
	        try {
	            if(strJob.equals("1")){
	                // return value 0:실패, 1:중복참여
	                Event_Every_Visit_Proc event_proc = new Event_Every_Visit_Proc();
	                intResultValue = event_proc.visit_event_ins(strEventId,cUserId,strToday,strOsType);
	                System.out.println(intResultValue);
	            }
	        } catch(Exception ex) {}
	    }
	}
	jSONObject.put("result", intResultValue);
	out.println(jSONObject.toString());
%>