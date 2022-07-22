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
	
	int procCode = ChkNull.chkInt(request.getParameter("procCode"), 1);
	
	//알람톡
	StringBuilder query = new StringBuilder() ;
	
	query.append(" select USERID	from tbl_reward_req_first_point a \n    ");
	query.append(" where a.regdate >= '2019-06-01 10:00' \n ");
	query.append(" and a.conf_ci_key is not null \n ");
	query.append(" and exists ( \n ");
	query.append(" select top 1 userid from tbl_reward_point cc \n ");
	query.append(" where cc.userid = a.userid  \n ");
	query.append(" and cc.point_code = '10' \n ");
	query.append(" and cc.ref_seq =  662 \n ");
	query.append(" and point_date > convert(varchar(10), getdate(),121) \n ");
	query.append(" )  \n ");
	query.append(" and isnull(a.dflag,'N') <> 'Y' \n ");
	query.append(" and req_kind = '03' \n");
	query.append(" group by userid \n");
	query.append(" order by userid asc  ");
	
	DBDataTable dtcmex = new DBWrap("member").setQuery(query.toString()).selectAllTry();
	
	boolean msgA = false; // 적립받기 완료
	boolean msgB = false; // 적립받기 2차대사 완료
	
	for (int j=0 ; j<dtcmex.count() ; j++){
		String userid = dtcmex.parse(j,"USERID","");
		
		alertTak(userid);
		jsonArr.put(userid);
	}
	
	//jSONObject.put("result",userid); // 결과를 넣는다.
	out.println(jsonArr.toString());
%>

<%!
//알림톡 보내기
public void alertTak(String userid){     
	
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
	
	msg.append( "[에누리 가격비교]\n"); 
	msg.append( "100원딜 페이백 적립완료\n\n");

	msg.append( "안녕하세요. "+userNm+"님! \n");

	msg.append( "참여하신 100원딜 이벤트\n");
	msg.append( "페이백 9,900점이 적립되었습니다!\n\n");

	msg.append( "적립된 e머니는 적립내역에서 확인 부탁드리며,\n");
	msg.append( "약 1,500여 개의 인기 쿠폰으로 즉시 교환 후 사용하실 수 있습니다.\n");
	
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
		String code ="enuri_0016" ;

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