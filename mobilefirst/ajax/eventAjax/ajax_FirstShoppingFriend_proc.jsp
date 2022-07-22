<%@page import="com.enuri.bean.event.DBWrap"%>
<%@page import="com.enuri.bean.biz.Biz_Data"%>
<%@page import="com.enuri.bean.biz.Biz_Proc"%>
<%@page import="com.enuri.bean.event.DBDataTable"%>
<%@page import="com.enuri.bean.event.Members_Friend_Proc"%>
<%@page import="com.enuri.bean.event.Members_Friend_Proc2"%>
<%@page import="com.enuri.bean.member.Join_Data"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	Mobile_Event_Proc mobile_Event_Proc = new Mobile_Event_Proc();
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	String userData  =  StringUtils.defaultString(request.getParameter("chkid"));

	JSONObject jSONObject = new JSONObject();

	Join_Data join_Data = new Join_Data();
	Members_Friend_Proc2 members_Friend_Proc2 = new Members_Friend_Proc2();
	join_Data =  members_Friend_Proc2.getMemberData(userId);
	String ciKey = join_Data.getConf_ci_key();//본인인증여부

	int pointUserCnt =  members_Friend_Proc2.getPointCikey(ciKey);

	JSONArray jsonRecDate = new JSONArray();

	Members_Friend_Proc Members_Friend_Proc = new Members_Friend_Proc();

	jsonRecDate = Members_Friend_Proc.getRecDate(userId);
	String rec_date = StringUtils.defaultString((String)jsonRecDate.get(0),"0");
	int dupChk = Members_Friend_Proc.getDupChk(userId);
	if(dupChk > 0){
		jSONObject.put("pointUserCnt","UD");
	}else if(jsonRecDate.equals("0") ){

		jSONObject.put("pointUserCnt","UX");

	}else if( pointUserCnt > 0 ){ //이미 추천한 적이 있다.
		jSONObject.put("pointUserCnt","UO");

	}else{
		Mobile_Push_Proc mobile_push_proc = new Mobile_Push_Proc();
	    mobile_push_proc.insertEvent3(userId, userData, "" , "20160701"); //   insert 한다.

		boolean result = mobile_Event_Proc.firstShoppingInsert2(userId , userData);

		jSONObject.put("result",result);
		jSONObject.put("pointUserCnt","UE");

		if(result){
			alertTak(userId , join_Data );
		}
	}
	out.println(jSONObject.toString());
%>

<%!
//알림톡 보내기
public void alertTak(String userid , Join_Data  memData){
	StringBuilder query = new StringBuilder() ;
	query.append(" select CART_STATUS from tbl_reward_cart with (readuncommitted) ");
	query.append(" where userid = ? ");
	query.append(" group by cart_status ");
	query.append(" order by cart_status asc ");

	DBDataTable dtcmex = new DBWrap("member").setQuery(query.toString()).addParameter(userid).selectAllTry();

	boolean msgA = false; // 적립받기 완료
	boolean msgB = false; // 적립받기 2차대사 완료
	boolean result = true;

	for (int j=0 ; j<dtcmex.count() ; j++){
		String cart_status = dtcmex.parse(j,"CART_STATUS","");

		if( "04".equals(cart_status) ){
			msgA = true;
		}else if( "00".equals(cart_status) || "01".equals(cart_status) ){
			msgB = true;
		}
	}

	/*************************************************************
	알림톡 발송
	*************************************************************/
	//사용자 정보를 가져와 배송 정보에 미리 담아둔다.
	try{
		String userNm = "";
		String hp1 = "";
		String hp2 = "";
		String hp3 = "";
		String receiver_num = "";
		String dday = "";

		if (memData != null) {
			userNm = memData.getName();
			hp1 = memData.getTel1_p();
			hp2 = memData.getTel2_p();
			hp3 = memData.getTel3_p();

			receiver_num = hp1 + hp2 + hp3;
		}

		StringBuilder msg = new StringBuilder() ;

		if(msgA){ //적립완료
			dday = "1~3일";
		}else if(msgB){ //신청완료
			dday = "최대 30일";
		}else {
			result = false;
		}

		msg.append("[에누리 가격비교]\n");
		msg.append("초대 혜택 이벤트 참여 완료\n\n");

		msg.append("안녕하세요. "+userNm+"님!\n");
		msg.append("초대 혜택 이벤트에 참여해 주셔서 감사합니다.\n\n");

		msg.append("초대 혜택 e9,000점은\n");
		msg.append(dday+" 이내에 적립될 예정입니다.\n\n");

		msg.append("적립 이후 다시 한번 안내 드릴 예정이오니\n");
		msg.append("조금만 기다려주세요!");
		//멤버 데이터가 없을 경우 입력받은 핸드폰 값으로 보내 도록 한다.

		// bizm용 전화번호. 01012345678 을 821012345678. 형식으로 가공. 국가번호(82:대한민국).
		if (receiver_num.length() > 10) {
			receiver_num = "82" + receiver_num.substring(1, receiver_num.length());
		}

		if (receiver_num.length() > 10) {
			 String code ="" ;

			if(msgA){
				//code = "enuri_0024"; //04 적립완료
				code = "enuri_invite2"; //#48518 템플릿 변경
			}else if(msgB){
				//code = "enuri_0023"; //신청완료 00,01
				code = "enuri_invite1"; //#48518 템플릿 변경
			}

			Biz_Data bizData = new Biz_Data();

			bizData.setEnuri_id(userid); //id
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
				logMsg("ajax_FirstShoppingFriend_proc.jsp", "### send post return error... data=>"+bizData.getJson());
			} else {
				for (int j=0; j<rtnArr.length(); j++) {
					if (!bizProc.updRtnMsg(rtnArr.getJSONObject(j))) {	// status Ready > Save
						logMsg("ajax_FirstShoppingFriend_proc.jsp", "### update fail... msgid:" + bizData.getMsgid() + ", rtnArr:"+rtnArr.toString());
					}
				}
			}
		}
	}catch(Exception e){
		System.out.println(e);
	}
}

private void logMsg(String method, String msg) {
	System.out.println("["+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime())+"] === /mobilefirst/ajax/eventAjax/ajax_FirstShoppingFriend_proc.jsp === " + method + "=> " + msg);
}
%>
