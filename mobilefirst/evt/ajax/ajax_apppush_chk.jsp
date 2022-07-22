<%@page import="com.enuri.bean.edeal.Edeal_Order_Proc"%>
<%@page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@ page import="com.enuri.bean.event.Members_Friend_Proc2"%>
<%@ page import="com.enuri.bean.member.Join_Data"%>
<%
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID */
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date()); 								//	오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크
	String userData = ChkNull.chkStr(cb.getCookie_One("chk_id"));
	Mobile_Event_Proc mobile_event_proc = new Mobile_Event_Proc();
	Join_Data Join_Data = new Join_Data();
	Members_Friend_Proc2 members_Friend_Proc2 = new Members_Friend_Proc2();
	String conf_ci_key ="";
	
	int event_id = Integer.parseInt(request.getParameter("event_id"));
	int result= 0;
	if (referer.indexOf("enuri.com") > -1) {
		if ( referer.indexOf("dev") > -1 &&  !"".equals(sdt)) { 
			strToday = sdt;
 		} 
	} else {
		return;
	}
	int numSdt = Integer.parseInt(strToday);


    JSONObject jSONObject1 = new JSONObject();
	
	
	Edeal_Order_Proc edeal_order_proc = new Edeal_Order_Proc();
	boolean IsEnuriEmployee = false;
	if(userId.length()>0) 	IsEnuriEmployee = edeal_order_proc.isEnuriEmployee(userId);
	
	//에누리직원은 응모할수없다
	if(IsEnuriEmployee){
		jSONObject1.put("result",-99);
		out.println(jSONObject1.toString());
		return;
	}
	//sdu 회원이 인증이 안되어 있다면 true
	//이벤트 참여 불가 
	Members_Proc mp = new Members_Proc();
	if(mp.SduCerify(userId)){
		jSONObject1.put("result", -5);
		out.println(jSONObject1.toString());
		return;
	}
	
	//sns 인증회원 확인
	boolean bcertify= new Sns_Login().isSnsMemberCertify2(userId);
	if(!bcertify){
		jSONObject1.put("result", -6);
		out.println(jSONObject1.toString());
		return;
	}
	Join_Data = members_Friend_Proc2.getMemberData(userId);
	conf_ci_key = Join_Data.getConf_ci_key();
	int dupChk = mobile_event_proc.getEventDup(conf_ci_key, event_id, userId);
	if(dupChk == 0){
		result = mobile_event_proc.setWelcomeChk(event_id, userId, conf_ci_key, userData);
		mobile_event_proc.setAppAlrimYn(userId, userData);
	}else{
		jSONObject1.put("result", 0);
		out.println(jSONObject1.toString());
		return;
	}

	jSONObject1.put("result", result);
	out.println(jSONObject1.toString());
%>
