<%@page import="com.enuri.bean.bizm.Bizm_Proc"%>
<%@page import="com.enuri.bean.bizm.Bizm_Data"%>
<%@page import="com.enuri.bean.biz.Biz_Data"%>
<%@page import="com.enuri.bean.biz.Biz_Proc"%>
<%@page import="com.enuri.bean.biz.Biz_Btn_Data"%>
<%@page import="com.enuri.bean.enuripc.Member_Data"%>
<%@page import="com.enuri.bean.event.DBWrap"%>
<%@page import="com.enuri.bean.event.DBDataTable"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page import="com.enuri.bean.event.Members_Friend_Proc2"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.member.Join_Data"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%
StringBuilder strQuery = new StringBuilder() ;

strQuery.append(" select USERID from tbl_reward_point  ");
strQuery.append(" where point_code = '10'   ");
strQuery.append(" and ref_seq =  1119    ");
strQuery.append(" and point_date > convert(varchar(10), getdate(),121)      ");
strQuery.append(" order by point_seq desc     ");

DBDataTable ddt = new DBWrap("member").setQuery(strQuery.toString()).selectAllTry();

for ( int i = 0 ; i < ddt.count() ; i++ ){
	String userid = ddt.parse(i,"USERID","");
	alimTalk(userid);
}
%>

<%!
//알림톡 보내기
public void alimTalk(String userid){
	/*************************************************************
	알림톡 발송
	*************************************************************/
	//사용자 정보를 가져와 배송 정보에 미리 담아둔다.
	try{
		Join_Data memData = new Members_Friend_Proc2().getMemberData(userid);
		String userNm = "";
		String hp1 = "";
		String hp2 = "";
		String hp3 = "";
		String receiver_num = "";

		if (memData == null) {
			return;
		}else{
			userNm = memData.getName();
			hp1 = memData.getTel1_p();
			hp2 = memData.getTel2_p();
			hp3 = memData.getTel3_p();

			receiver_num = hp1 + hp2 + hp3;
		}

		StringBuilder msg = new StringBuilder();
		String code ="";

		msg.append( "[에누리 가격비교]\n");
		msg.append( "웰컴 페이백 적립 완료\n\n");

		msg.append( "안녕하세요. "+userNm+"님!\n");
		msg.append( "웰컴 혜택 이벤트에 참여해 주셔서 감사합니다.\n\n");

		msg.append( "웰컴 페이백 e머니가 적립되었습니다!\n\n");

		msg.append( "하단 [나의 e머니 확인하기] 클릭 시 확인 가능합니다.");

		code = "enuri_welcome4";

		//멤버 데이터가 없을 경우 입력받은 핸드폰 값으로 보내 도록 한다.

		// bizm용 전화번호. 01012345678 을 821012345678. 형식으로 가공. 국가번호(82:대한민국).

		if (receiver_num.length() > 10) {
			receiver_num = "82" + receiver_num.substring(1, receiver_num.length());
		}
		if (receiver_num.length() > 10) {
			// 데이터 세팅
			Biz_Data bizData = new Biz_Data();
			Biz_Btn_Data bizBtnData = new Biz_Btn_Data();

			bizBtnData.setType("AL");
	        bizBtnData.setName("나의 e머니 확인하기");
	        bizBtnData.setScheme_android("enuri://freetoken/?url=https%3A%2F%2Fm.enuri.com%2Fmy%2Fmy_emoney_m.jsp%3F_tab%3Dnew%26tab%3D4%26freetoken%3Demoney");
	        bizBtnData.setScheme_ios("enuri://freetoken/?url=https%3A%2F%2Fm.enuri.com%2Fmy%2Fmy_emoney_m.jsp%3F_tab%3Dnew%26tab%3D4%26freetoken%3Demoney");

			bizData.setEnuri_id(userid); //id
			bizData.setReceiver_num(receiver_num); //번호
			bizData.setReserved_time("00000000000000");
// 			bizData.setReserved_time(new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()) + "090000");
			bizData.setTemplate_code(code); // 템플릿코드
			bizData.setMessage(msg.toString()); // 알림톡 메시지
			bizData.setSms_message(msg.toString()); // SMS 메시지
			bizData.setButton1(bizBtnData); // 버튼추가

			Biz_Proc bizProc = new Biz_Proc();
			// bizm 문자 전송 테이블에 INSERT.

			bizProc.insBizMsgRtnData(bizData);	// insert enuri_bizmsg

			JSONArray rtnArr = bizProc.sendPost(bizData);	// 서버 전송
			if (rtnArr == null || rtnArr.length() <= 0) {
				logMsg("welcome_kakao_send_msg.jsp", "### send post return error... data=>"+bizData.getJson());
			} else {
				for (int j=0; j<rtnArr.length(); j++) {
					if (!bizProc.updRtnMsg(rtnArr.getJSONObject(j))) {	// status Ready > Save
						logMsg("welcome_kakao_send_msg.jsp", "### update fail... msgid:" + bizData.getMsgid() + ", rtnArr:"+rtnArr.toString());
					}
				}
			}
		}
	}catch(Exception e){
		System.out.println(e);
	}
}

private void logMsg(String method, String msg) {
	System.out.println("["+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime())+"] === /mobilefirst/bizmsg/welcome_kakao_send_msg.jsp === " + method + "=> " + msg);
}
%>