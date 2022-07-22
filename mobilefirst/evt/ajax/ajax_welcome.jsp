<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@ page import="com.enuri.bean.member.Join_Data"%>
<%@ page import="com.enuri.bean.event.Members_Friend_Proc2"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page import="com.enuri.bean.edeal.Edeal_Order_Proc"%>
<%@page import="com.enuri.bean.biz.Biz_Data"%>
<%@page import="com.enuri.bean.biz.Biz_Proc"%>
<%@page import="com.enuri.bean.event.DBWrap"%>
<%@page import="com.enuri.bean.event.DBDataTable"%>
<%
    String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
    String userGroup = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_GROUP"));
	String userData  =  StringUtils.defaultString(request.getParameter("chkid"));
	String referer = ChkNull.chkStr(request.getHeader("referer"));
	int procCode = ChkNull.chkInt(request.getParameter("procCode"), 1);
	Members_Friend_Proc2 members_Friend_Proc2 = new Members_Friend_Proc2();
	Mobile_Event_Proc eventProc = new Mobile_Event_Proc();
	JSONObject jSONObject = new JSONObject();
	if("".equals(userData)){
		userData = ChkNull.chkStr(cb.getCookie_One("chk_id"));
	}
	boolean bcertify= new Sns_Login().isSnsMemberCertify2(userId);
	if(!bcertify){
		jSONObject.put("result", -5);
		out.println(jSONObject.toString());
		return;
	}
	int eventCode = 0;
    int result = 0;
	userId = userId.trim();

	switch(procCode) { //유형체크
		case 1 :
			eventCode = 1117;
			break;
		case 2 :
			eventCode = 1118;
			break;
		case 3 :
			break;
		case 4 :
			eventCode = 1119;
			break;
		default :
			eventCode = -55;
			break;
	}
	if( eventCode == -55 ){
		jSONObject.put("result", eventCode);
		out.println(jSONObject.toString());
		return;
	}

	String conf_ci_key ="";

	Join_Data Join_Data = new Join_Data();
	Join_Data = members_Friend_Proc2.getMemberData(userId);
	conf_ci_key = Join_Data.getConf_ci_key();
	if(conf_ci_key.equals("")){
		jSONObject.put("result", -99);
		out.println(jSONObject.toString());
		return;
	}

	if("".equals(userData) ){
		JSONObject installUser = eventProc.getInstalllData(userId);

		if(installUser.has("user_data")){
			userData = installUser.getString("user_data");
		}
	}
	if(procCode == 3){
		Edeal_Order_Proc edeal_order_proc = new Edeal_Order_Proc();
		boolean IsEnuriEmployee = false;

		if(userId.length()>0) IsEnuriEmployee = edeal_order_proc.isEnuriEmployee(userId);

		if(IsEnuriEmployee){
			jSONObject.put("result",-90);
			out.println(jSONObject.toString());
			return;
		}

		result=eventProc.getWelcomeChk(userId, conf_ci_key, userData);
	}else if(procCode ==4){
		result = eventProc.setWelcomeChk(eventCode, userId, conf_ci_key, userData);

		if(result == 3) alimTalk(Join_Data);
	}else{
		if(userGroup.equals("1") || userGroup.equals("2")){
			jSONObject.put("result", -100);
			out.println(jSONObject.toString());
			return;
		}

		if(referer.indexOf("new_member.jsp") < 0){
			result = eventProc.getNewMemYn(userId,"20201005");
		}else{
			result = eventProc.getNewMemYn(userId,"20210901");
		}

		if(result < 1 ){
			jSONObject.put("result", -96);
			out.println(jSONObject.toString());
			return;
		}

		int chk = eventProc.getEventDup(conf_ci_key, eventCode, userId);

		if(chk > 0){
			jSONObject.put("result", -91);
			out.println(jSONObject.toString());
			return;
		}

		result = eventProc.getWelcome200Point(userId, eventCode);
		if(result > 0){
			jSONObject.put("result", -1);
			out.println(jSONObject.toString());
			return;
		}else{
			if(procCode == 2){
				result = eventProc.getAlrimYn(userId,userData);
				if(result < 1 ){
					jSONObject.put("result", -95);
					out.println(jSONObject.toString());
					return;
				}
			}

			try{
				result = eventProc.setWelcomeChk(eventCode, userId, conf_ci_key, userData);
				if(result == 3) eventProc.setWelcome200Point(userId, eventCode);
			}catch(Exception e){
				result = -999;
			}
		}
	}

	jSONObject.put("result",result); // 결과를 넣는다.
	out.println(jSONObject.toString());
%>

<%!
//알림톡 보내기
public void alimTalk(Join_Data memData){
	if (memData == null) return;

	StringBuilder query = new StringBuilder();

	query.append(" select CART_STATUS from tbl_reward_cart with (readuncommitted) ");
	query.append(" where userid = ? ");
	query.append(" group by cart_status ");
	query.append(" order by cart_status asc ");

	DBDataTable dtcmex = new DBWrap("member").setQuery(query.toString()).addParameter(memData.getUserid()).selectAllTry();

	boolean msgA = false; // 적립받기 완료
	boolean msgB = false; // 적립받기 2차대사 완료
	boolean result = true;

	for (int j=0 ; j<dtcmex.count() ; j++){
		String cart_status = dtcmex.parse(j,"CART_STATUS","");

		if("04".equals(cart_status)){
			msgA = true;
		}else if("00".equals(cart_status) || "01".equals(cart_status)){
			msgB = true;
		}
	}

	/*************************************************************
	알림톡 발송
	*************************************************************/
	//사용자 정보를 가져와 배송 정보에 미리 담아둔다.
	try{
		String userNm = memData.getName();
		String hp1 = memData.getTel1_p();
		String hp2 = memData.getTel2_p();
		String hp3 = memData.getTel3_p();
		String receiver_num = hp1 + hp2 + hp3;
		String dday = "";

		StringBuilder msg = new StringBuilder() ;

		if(msgA){ //적립완료
			dday = "1~3일";
		}else if(msgB){ //신청완료
			dday = "최대 30일";
		}else {
			return;
		}

		msg.append("[에누리 가격비교]\n");
		msg.append("웰컴 페이백 참여 완료\n\n");

		msg.append("안녕하세요. "+userNm+"님!\n");
		msg.append("웰컴 페이백 이벤트에 참여해 주셔서 감사합니다.\n\n");

		msg.append("웰컴 페이백 e머니는\n");
		msg.append(dday+" 이내에 적립될 예정입니다.\n\n");

		msg.append("적립 후 다시 한번 안내 드릴 예정이오니\n");
		msg.append("조금만 기다려주세요!");
		//멤버 데이터가 없을 경우 입력받은 핸드폰 값으로 보내 도록 한다.

		// bizm용 전화번호. 01012345678 을 821012345678. 형식으로 가공. 국가번호(82:대한민국).
		if (receiver_num.length() > 10) {
			receiver_num = "82" + receiver_num.substring(1, receiver_num.length());
		}

		if (receiver_num.length() > 10) {
			String code ="" ;

			if(msgA){
				code = "enuri_welcome2";
			}else if(msgB){
				code = "enuri_welcome1";
			}

			Biz_Data bizData = new Biz_Data();

			bizData.setEnuri_id(memData.getUserid()); //id
			bizData.setReceiver_num(receiver_num); //번호
			bizData.setReserved_time("00000000000000"); //즉시발송
			bizData.setTemplate_code(code); // 템플릿코드
			bizData.setMessage(msg.toString()); // 알림톡 메시지
			bizData.setSms_message(msg.toString()); // SMS 메시지

			Biz_Proc bizProc = new Biz_Proc();
			// bizm 문자 전송 테이블에 INSERT.

			bizProc.insBizMsgRtnData(bizData);	// insert enuri_bizmsg

			JSONArray rtnArr = bizProc.sendPost(bizData);	// 서버 전송
			if (rtnArr == null || rtnArr.length() <= 0) {
				logMsg("ajax_welcome.jsp.jsp", "### send post return error... data=>"+bizData.getJson());
			} else {
				for (int j=0; j<rtnArr.length(); j++) {
					if (!bizProc.updRtnMsg(rtnArr.getJSONObject(j))) {	// status Ready > Save
						logMsg("ajax_welcome.jsp.jsp", "### update fail... msgid:" + bizData.getMsgid() + ", rtnArr:"+rtnArr.toString());
					}
				}
			}
		}
	}catch(Exception e){
		System.out.println(e);
	}
}

private void logMsg(String method, String msg) {
	System.out.println("["+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime())+"] === /mobilefirst/evt/ajax/ajax_welcome.jsp === " + method + "=> " + msg);
}
%>