<%@page import="com.enuri.bean.edeal.Edeal_Order_Proc"%>
<%@page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Stamp_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page import="org.json.*"%>
<%
    Mobile_Stamp_Proc mobile_Stamp_Proc = new Mobile_Stamp_Proc();
    JSONObject jSONObject = new JSONObject();
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	String strToday = formatter.format(new Date()); 								//오늘 날짜 (visitData, ins_date)
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
	String ostpcd = ChkNull.chkStr(request.getParameter("ostpcd"),"PC").trim(); 				//	테스트 날짜
    String referer = ChkNull.chkStr(request.getHeader("referer")).trim();
	String eventId = ChkNull.chkStr(request.getParameter("eventId"));
	String startDate = ChkNull.chkStr(request.getParameter("startDate"));

	if ( referer.indexOf(".enuri.com") > -1 ) {
		if (referer.indexOf("dev") > -1 && !"".equals(sdt)) {
			strToday = sdt;
		}
		//strToday = sdt; /*실서버 운영시 주석걸기*/
		//startDate = "20210401"; /*실서버 운영시 주석걸기*/
	}

	if(eventId.equals("") || startDate.equals("")) {
		return;
	}

    int resultType = 0;
	//sdu 회원이 인증이 안되어 있다면 true
	//이벤트 참여 불가
	//노병원 2018/10/11
	boolean IsEnuriEmployee = false;
	Edeal_Order_Proc edeal_order_proc = new Edeal_Order_Proc();
   	if(userId.length()>0) 	IsEnuriEmployee = edeal_order_proc.isEnuriEmployee(userId);

   	//에누리직원은 응모할수없다
   	if(IsEnuriEmployee){
   		jSONObject.put("result",-99);
   		out.println(jSONObject.toString());
   		return;
   	}
	Members_Proc mp = new Members_Proc();
	if(mp.SduCerify(userId)){
		jSONObject.put("result", -4);
		out.println(jSONObject.toString());
		return;
	}
	//본인인증 여부 확인
	boolean bcertify = new Sns_Login().isSnsMemberCertify(userId);
	if(!bcertify){
		jSONObject.put("result", -5);
		out.println(jSONObject.toString());
		return;
	}

	if(referer.indexOf("enuri.com") > -1 && !"".equals(userId)){
		resultType = mobile_Stamp_Proc.stamp_ins_proc_v3(eventId, userId, startDate, ostpcd); //스탬프 4개
// 		resultType = mobile_Stamp_Proc.stamp_ins_proc_v2(eventId, userId, startDate, ostpcd); //스탬프 9개
	}

	jSONObject.put("result", resultType);
	out.println(jSONObject.toString());
%>