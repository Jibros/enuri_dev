<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.edeal.Edeal_Order_Proc"%>
<%@page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page import="com.enuri.bean.mobile.Event_Welcome_Proc" %>
<%
	JSONObject jSONObject = new JSONObject();

    String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim();
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();
	String ostpcd = ChkNull.chkStr(request.getParameter("ostpcd"),"PC");
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim();
    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date());

	if (referer.indexOf("enuri.com") > -1) {
		if ( referer.indexOf("dev") > -1 &&  !"".equals(sdt)) {
			strToday = sdt;
		}
	} else {
		return;
	}
	
   /*  // 실서버 테스트용
 	if ( referer.indexOf("enuri.com") > -1 &&  !"".equals(sdt)) {
 		strToday = sdt;
 	} */

	String cur_eventId = ""; // 해당 월 이벤트코드
	String cur_comeback_start_date = ""; //3개월전 이벤트 지급이력 조회 시작일, ex) 5월 이벤트 진행 중 -> 2월 이벤트 시작일부터 지급이력 조회

	int numMonth = Integer.parseInt(strToday.substring(4,6));
	boolean EVENODD = (numMonth%2 == 0) ? true : false;

	if(EVENODD){	// 짝
		cur_eventId = "2022060109"; // 2022 6월 컴백혜택 이벤트코드
		cur_comeback_start_date = "20220301";
	}else{	// 홀
		cur_eventId = "2022050109"; // 2022 5월 컴백혜택 이벤트코드
		cur_comeback_start_date = "20220201";
	}

    int resultType = 0; //유형체크
	boolean insertReturn = false;//즉시지급여부

	Edeal_Order_Proc edeal_order_proc = new Edeal_Order_Proc();
	boolean IsEnuriEmployee = false;
	if(userId.length()>0) 	IsEnuriEmployee = edeal_order_proc.isEnuriEmployee(userId);

	//에누리직원은 응모할수없다
	if(IsEnuriEmployee){
		jSONObject.put("result",-99);
		out.println(jSONObject.toString());
		return;
	}

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
	boolean bcertify= new Sns_Login().isSnsMemberCertify(userId);
	if(!bcertify){
		jSONObject.put("result", -5);
		out.println(jSONObject.toString());
		return;
	}

	//참여테이블 -> 해당 월이벤트코드로 insert, 포인트 지급테이블 -> 2017090107로 계속 insert 됨.
	if(!userId.equals("") && referer.indexOf("enuri.com") > -1){
        Event_Welcome_Proc event_welcome_proc = new Event_Welcome_Proc();
		resultType = event_welcome_proc.comback_type_chk_v6(userId, ostpcd, cur_comeback_start_date, cur_eventId);
    }

	jSONObject.put("result",resultType); // 결과를 넣는다.
    jSONObject.put("insertReturn",insertReturn); // e머니지급결과
	out.println(jSONObject.toString());
%>
