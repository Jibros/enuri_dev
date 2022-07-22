<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@page import="org.json.JSONObject"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="java.net.InetAddress"%>
<%@page import="com.enuri.bean.event.every.Event_Every_Visit_Proc"%>
<%
// getParameter
	String strOsType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); // 참여 os type
	String cUserId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); //참여 ID

	String sdt = ChkNull.chkStr(request.getParameter("sdt"), "").trim();  //날짜 테스트용 파라미터
	SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
	String strToday = formatter.format(new Date()); //오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();
	JSONObject jSONObject = new JSONObject();
	
	int intResultValue = -3; //결과값
	try {
		if(referer.indexOf("enuri.com") > -1){
			
			//sdu 회원이 인증이 안되어 있다면 true
			//이벤트 참여 불가 
			//노병원 2018/10/11
			Members_Proc mp = new Members_Proc();
			if(mp.SduCerify(cUserId)){
				jSONObject.put("result", -4);
				out.println(jSONObject.toString());
				return;
			}
			
			//sns 인증회원 확인
			boolean bcertify= new Sns_Login().isSnsMemberCertify2(cUserId);
			if(!bcertify){
				jSONObject.put("result", -5);
				out.println(jSONObject.toString());
				return;
			}
			
			if(!"".equals(sdt)  && referer.indexOf("dev") > -1 )				strToday = sdt;
	        int intToday = Integer.parseInt(strToday);
			
	        if( !"".equals(cUserId) ){
	        	Event_Every_Visit_Proc event_proc = new Event_Every_Visit_Proc();
	            intResultValue = event_proc.visit_bonus_first_event_ins(cUserId);	
	        }
		    
		}
	} catch(Exception ex) {
		System.out.println(ex.getMessage());
	}
    
    jSONObject.put("result",intResultValue); // 결과를 넣는다.
	out.println(jSONObject.toString());
%>
<%!
//날짜변환이 가능한 아이디인지 확인
boolean testIDchk(String userId){
	for(int i=1; i<=30; i++){
		if(("omom"+i).equals(userId))			return true;
	}
	String[] testID = {"jinow1","jinow3","jinow13","ca98047","makad321","wiseroh"};
	int i=0;
	if(testID[i++].equals(userId) || testID[i++].equals(userId) || testID[i++].equals(userId) || testID[i++].equals(userId) || testID[i++].equals(userId)){
		return true;
	}
	return false;
}
%>
