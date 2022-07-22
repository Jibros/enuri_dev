<%@page import="com.enuri.bean.bizm.Bizm_Proc"%>
<%@page import="com.enuri.bean.bizm.Bizm_Data"%>
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
    String userId = StringReplace(ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")));
	String userData  =  StringUtils.defaultString(request.getParameter("chkid"));
	String referer = ChkNull.chkStr(request.getHeader("referer"));

	//userId = "testtest11";
	
	if("".equals(userData)){
		userData = ChkNull.chkStr(cb.getCookie_One("chk_id"));
	}
	
	JSONObject jSONObject = new JSONObject();

    int resultType = 0; //유형체크
	boolean insertReturn = false;//즉시지급여부
	userId = userId.trim();	
	int procCode = ChkNull.chkInt(request.getParameter("procCode"), 1);
	
	//알람톡
	alertTak(userId);
	
	jSONObject.put("result",resultType); // 결과를 넣는다.
	out.println(jSONObject.toString());
%>
<%!
//특수문자 제거 하기
public String StringReplace(String str){       
	String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";
	str =str.replaceAll(match, "").trim();
	return str;
}
%>
<%!
//알림톡 보내기
public void alertTak(String userid){     
	
	StringBuilder query = new StringBuilder() ;
	query.append(" select CART_STATUS from tbl_reward_cart with (readuncommitted) ");
	query.append(" where userid = ? ");
	query.append(" group by cart_status ");
	query.append(" order by cart_status asc ");
	
	DBDataTable dtcmex = new DBWrap("member").setQuery(query.toString()).addParameter(userid).selectAllTry();
	
	boolean msgA = false; // 적립받기 완료
	boolean msgB = false; // 적립받기 2차대사 완료
	
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
	Join_Data memData = null;
	
	memData = new Members_Friend_Proc2().getMemberData(userid);
	
	String userNm = "";
	String zip = "";
	String add1 = "";
	String add2 = "";
	String hp1 = "";
	String hp2 = "";
	String hp3 = "";
	String email = "";
	String receiver_num = "";	
	
	if (memData != null) {
		userNm = memData.getName();
		zip = memData.getZip();
		add1 = memData.getM_juso();
		add2 = memData.getS_juso();
		hp1 = memData.getTel1_p();
		hp2 = memData.getTel2_p();
		hp3 = memData.getTel3_p();
		email = memData.getM_email();
		
		receiver_num = hp1 + hp2 + hp3;
	}
	
	StringBuilder msg = new StringBuilder() ;
	
	if(msgA){

		msg.append("[에누리 가격비교]\n");
		msg.append("100원딜 이벤트 참여완료\n\n");
	
		msg.append("안녕하세요. "+userNm+"님!\n");
	
		msg.append("100원딜 이벤트에 \n");
		msg.append("참여해주셔서 감사합니다.\n\n");
	
		msg.append("참여하신 100원딜 이벤트\n");
		msg.append("페이백 9,900점이 내일 적립될 예정입니다.\n\n");
	
		msg.append("적립 이후 다시 한 번 \n");
		msg.append("안내 드릴 예정이오니 조금만 기다려주세요!\n\n");
	
		msg.append("▶이벤트 바로가기 : https://bit.ly/2XDqQnF\n");
		
	}else if(msgB){
		
		msg.append("[에누리 가격비교]\n");
		msg.append("100원딜 이벤트 참여완료\n\n");

		msg.append("안녕하세요. "+userNm+"님!\n");

		msg.append("100원딜 이벤트에\n"); 
		msg.append("참여해주셔서 감사합니다.\n\n");

		msg.append("e머니 9,900점은 신청일로부터\n");
		msg.append("최대 30일 이내에 적립됩니다.\n\n");

		msg.append("적립 이후 다시 한 번 \n");
		msg.append("안내 드릴 예정이오니 조금만 기다려주세요!\n\n");

		msg.append("▶이벤트 바로가기 : https://bit.ly/2XDqQnF\n");
		
	}
	//멤버 데이터가 없을 경우 입력받은 핸드폰 값으로 보내 도록 한다. 
	
	// bizm용 전화번호. 01012345678 을 821012345678. 형식으로 가공. 국가번호(82:대한민국).
	if (receiver_num.length() > 10) {
		receiver_num = "82" + receiver_num.substring(1, receiver_num.length());
	}
	if (receiver_num.length() > 10) {
		// 데이터 세팅
		Bizm_Data bizm_data = new Bizm_Data();
		bizm_data.setEnuri_id(userid);
		bizm_data.setReceiver_num(receiver_num);
		bizm_data.setServerType("real");
		
		/* 	//버튼 미사용으로 set 안함.
		bizm_data.setBtn_name("에누리가격비교 홈");		//enuriPC 홈 등 바뀔 수 있음
		bizm_data.setBtn_url("http://www.enuri.com/enuripc/Index.jsp");
		 */
		 String code ="" ;
				
		if(msgA){
			code = "enuri_0015"; //04 적립완료 
		}else if(msgB){
			code = "enuri_0014"; //신청완료 00,01
		}
		
		bizm_data.setTemplate_code(code);	
		bizm_data.setProfile_key("5febb2c1491bbbc3a069834f38e80c802fa584ff");
	
		bizm_data.setSend_message(msg.toString()); 
		
		boolean isInsert = false;
		Bizm_Proc bp = new Bizm_Proc();
		// bizm 문자 전송 테이블에 INSERT.
		isInsert = bp.insCommonBizMsg(bizm_data);
	
		// 인서트 실패 시 로그 남김
		if(!isInsert){
			
		}
	} 

}catch(Exception e){
	System.out.println(e);
}

}
%>