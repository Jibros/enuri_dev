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
	JSONObject jSONObject = new JSONObject();
	JSONArray jsonArr = new JSONArray();

    int resultType = 0; //유형체크
	boolean insertReturn = false;//즉시지급여부
	
	//알람톡
	StringBuilder query = new StringBuilder() ;
	
	query.append(" select USERID	from tbl_reward_req_first_point a \n    ");
	query.append(" where a.regdate >= '2019-07-01 10:00' \n ");
	query.append(" and a.conf_ci_key is not null \n ");
	query.append(" and exists ( \n ");
	query.append(" select top 1 userid from tbl_reward_point cc \n ");
	query.append(" where cc.userid = a.userid  \n ");
	query.append(" and cc.point_code = '10' \n ");
	query.append(" and cc.ref_seq =  24 \n ");
	query.append(" and point_date > convert(varchar(10), getdate(),121) \n ");
	query.append(" )  \n ");
	query.append(" and isnull(a.dflag,'N') <> 'Y' \n ");
	query.append(" and req_kind = '02' \n");
	query.append(" group by userid \n");
	query.append(" order by userid asc  ");
	
	DBDataTable dtcmex24 = new DBWrap("member").setQuery(query.toString()).selectAllTry();
	
	for ( int i = 0 ; i < dtcmex24.count() ; i++ ){
		String userid = dtcmex24.parse(i,"USERID","");
		
		alertTak(userid , "24");
		jsonArr.put(userid);
	}
	//알람톡
	query = new StringBuilder() ;
	
	query.append(" select USERID from tbl_reward_point  ");
	query.append(" where point_code = '10'   ");
	query.append(" and ref_seq =  26    ");
	query.append(" and point_date > convert(varchar(10), getdate(),121)      ");
	query.append(" order by point_seq desc     ");

	DBDataTable dtcmex26 = new DBWrap("member").setQuery(query.toString()).selectAllTry();
	
	for ( int i = 0 ; i < dtcmex26.count() ; i++ ){
		String userid = dtcmex26.parse(i,"USERID","");
		
		alertTak(userid,"26");
		jsonArr.put(userid);
	}
	//jSONObject.put("result",userid); // 결과를 넣는다.
	out.println(jsonArr.toString());
%>

<%!
//알림톡 보내기
public void alertTak( String userid, String type ){     
	
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
	String code ="" ;
	
	if( "24".equals(type) ){
		
		msg.append( "[에누리 가격비교]\n"); 
		msg.append( "친구초대 e머니 적립완료\n\n");

		msg.append( "안녕하세요. "+userNm+"님! \n");

		msg.append( "참여하신 100원딜 이벤트\n");
		msg.append( "페이백 9,900점이 적립되었습니다!\n\n");

		msg.append( "적립된 e머니는 약 1,500여 개의 인기 쿠폰으로 즉시 교환 후 사용하실 수 있습니다.\n");
		msg.append( "※ 친구초대 혜택은 100원딜 페이백과 중복지급이 불가합니다.");
		
		code = "enuri_0025";
		
	}else if( "26".equals(type) ){
		
		msg.append( "[에누리 가격비교]\n"); 
		msg.append( "친구초대 e머니 적립완료\n\n");

		msg.append( "안녕하세요. "+userNm+"님! \n");

		msg.append( "친구초대 이벤트 초대자 혜택\n");
		msg.append( "e머니 9,000점이 적립되었습니다!\n\n");

		msg.append( "적립된 e머니는 약 1,500여 개의 인기 쿠폰으로 즉시 교환 후 사용하실 수 있습니다.\n");

		code = "enuri_0026";
		
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
		
		bizm_data.setTemplate_code(code);	
		bizm_data.setProfile_key("5febb2c1491bbbc3a069834f38e80c802fa584ff");
	
		bizm_data.setSend_message(msg.toString()); 
		
		boolean isInsert = false;
		Bizm_Proc bp = new Bizm_Proc();
		// bizm 문자 전송 테이블에 INSERT.
		isInsert = bp.insCommonBizMsg(bizm_data);
		
		if(isInsert){
			new DBWrap("member").addSimpleParameter("dflag", "Y").simpleUpdate("tbl_reward_req_first_point", "userid", userid );
		}
		
		// 인서트 실패 시 로그 남김
		if(!isInsert){
			
		}
	} 

}catch(Exception e){
	System.out.println(e);
}

}
%>