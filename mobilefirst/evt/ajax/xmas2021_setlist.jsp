<%@page import="com.enuri.bean.edeal.Edeal_Order_Proc"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.event.every.Newyear_2017"%>
<%@page import="com.enuri.util.seed.Seed_Proc"%>
<%@page import="com.enuri.bean.mobile.Event_Welcome_Proc" %>
<%@page import="com.enuri.bean.mobile.Event_Lina_Proc"%>
<%@page import="com.enuri.bean.main.deal.CrazyDeal_ShareEvt_Proc"%>
<%@page import="com.enuri.bean.bizm.Bizm_Proc"%>
<%@page import="com.enuri.bean.bizm.Bizm_Data"%>
<%@page import="com.enuri.bean.event.Members_Friend_Proc2"%>
<%@page import="com.enuri.bean.member.Join_Data"%>
<%@page import="com.enuri.bean.biz.Biz_Proc" %>
<%@page import="com.enuri.bean.biz.Biz_Data"%>
<%@page import="com.enuri.bean.biz.Biz_Btn_Data"%>
<%@page import="com.enuri.exception.ExceptionManager"%>
<%
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date()); 								//	오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크
	String server = "real";
	if(referer.indexOf("dev")>-1){
		server = "dev";
	}
	if (referer.indexOf("dev") > -1 && !"".equals(sdt)) {
		strToday = sdt;
	}
	if (referer.indexOf("enuri.com") < 0 || Integer.parseInt(strToday) < 20211201 || 20211231 < Integer.parseInt(strToday) ) {
		return;
	}
	/*
	procCode
		1 : 선물보따리
		2 : 응모 참여
		3 : 공유 이벤트 참여 
	*/
	int procCode = ChkNull.chkInt(request.getParameter("procCode"));	
	String shareType = ChkNull.chkStr(request.getParameter("shareType"),"");			//	이벤트 유형
    int intResultValue = -3; 														// 	결과값
    JSONObject jSONObject = new JSONObject();
	String strEventCode = "2021120120";

	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); 	// 	참여 os type
	String osCode = "1";
	if(osType.indexOf("PC") > -1) {
		osCode = "1";
	} else if(osType.indexOf("MW") > -1) {
		osCode = "2";
	}  else if(osType.indexOf("MA") > -1) {
		osCode = "3";
	}

    try{
    	if(1 == procCode){
        	/*
        	*	intResultValue
			* 	--  크리스마스 즉시지급 (2021.11.22) 
			*	--  이벤트 코드 2021120120
			*	--  return_code 
			*	--		임직원 참여불가(-99)
			*	--		당일 참여X  test 날짜 조작(-55)
			*	--		이미 참여 (-22)
			*	-- 		꽝 (-44)
			*	-- 		당첨 (5)
			*/	
     		if(!userId.equals("")){
    	        intResultValue = new Event_Welcome_Proc().exec_2021_christmas_event(strEventCode, userId, strToday, osType);
     	    }
        }else if(2 == procCode){
        	/*
        	intResultValue
    	    	1			: 신청성공
    	    	2601		: 이미 신청
    		*/
        	Edeal_Order_Proc edeal_order_proc = new Edeal_Order_Proc();
        	boolean IsEnuriEmployee = false;
        	if(userId.length()>0) IsEnuriEmployee = edeal_order_proc.isEnuriEmployee(userId);
        	
        	//에누리직원은 응모할수없다
        	if(IsEnuriEmployee){
        		intResultValue = -99;
        	}else{
				intResultValue = new Event_Lina_Proc().ins_event_optpcd(userId, "2021120121", osType , osType).getInt("result");
			}
        }else if(3 == procCode){
			

			// 공유하기 이벤트			
			CrazyDeal_ShareEvt_Proc proc = new CrazyDeal_ShareEvt_Proc();
			int shareEventCount = proc.shareInsert_event_count(userId,  strEventCode,  strToday);
			if(shareEventCount>0){
				intResultValue = -22; //이미참여
			}else{
				boolean blInsert = false;
				if(server.equals("real")){
					blInsert = proc.shareInsert_event(userId, strEventCode, shareType, osCode);
				}else{
					blInsert = proc.shareInsert_event_sdt(userId, strEventCode, shareType, osCode,strToday);
				}
				if(blInsert){
					intResultValue = 1;
				}else{
					intResultValue = 0;
				}
			}
		}
    }catch(Exception e){}

    jSONObject.put("result",intResultValue);
	out.println(jSONObject.toString());
%>
<%!

/*************************************************************
알림톡 발송
*************************************************************/
public void alertTak(Join_Data memData, String template_code, String msg, String server){

	//사용자 정보를 가져와 배송 정보에 미리 담아둔다.
	try{
		String hp1 = "";
		String hp2 = "";
		String hp3 = "";
		String receiver_num = "";

		if (memData != null) {
			hp1 = memData.getTel1_p();
			hp2 = memData.getTel2_p();
			hp3 = memData.getTel3_p();

			receiver_num = hp1 + hp2 + hp3;
		}


		// bizm용 전화번호. 01012345678 을 821012345678. 형식으로 가공. 국가번호(82:대한민국).
		if (receiver_num.length() > 10) {
			receiver_num = "82" + receiver_num.substring(1, receiver_num.length());
		}
		if (receiver_num.length() > 10) {
			// 데이터 세팅
			Bizm_Data bizm_data = new Bizm_Data();
			bizm_data.setEnuri_id(memData.getUserid());
			bizm_data.setReceiver_num(receiver_num);
			bizm_data.setServerType("real");

			bizm_data.setTemplate_code(template_code);
			bizm_data.setProfile_key("5febb2c1491bbbc3a069834f38e80c802fa584ff");

			bizm_data.setSend_message(msg.toString());

			boolean isInsert = false;
			Bizm_Proc bp = new Bizm_Proc();
			// bizm 문자 전송 테이블에 INSERT.

			isInsert = bp.insCommonBizMsg(bizm_data);
			// 인서트 실패 시 로그 남김
			if(!isInsert){

			}else{
				Biz_Proc bizProc = new Biz_Proc();
	 			ArrayList<Biz_Data> readyList = bizProc.getSendList(new String[]{template_code});	// 이머니 알림톡 템플릿코드
				sendBizMsg(template_code,readyList);
			}
		}

		}catch(Exception e){
			System.out.println(e);
		}

	}



public int sendBizMsg(String template, ArrayList<Biz_Data> sendList) throws ExceptionManager {
	if (sendList == null || sendList.size() <= 0) {
		return -1;
	}

	Biz_Proc bizProc = new Biz_Proc();

	int successCnt = 0;

	final int SEG_SIZE = 100;
	int listCount = sendList.size() / SEG_SIZE
	, remainCount = sendList.size() % SEG_SIZE;

	for (int i=0; i<=listCount; i++) {
		ArrayList<Biz_Data> segList = null;	// SEG_SIZE 단위로 잘라서 전송하기 위한 임시 리스트
		if (remainCount > 0 && i == listCount) {
			segList = new ArrayList<Biz_Data>(sendList.subList(i*SEG_SIZE, i*SEG_SIZE+remainCount));
		} else {
			segList = new ArrayList<Biz_Data>(sendList.subList(i*SEG_SIZE, (i+1)*SEG_SIZE));
		}

		try {
			for (Biz_Data data : segList) {
				Biz_Btn_Data btn = new Biz_Btn_Data();
				btn.setType("WL");
			 	btn.setName("e머니 추가적립 확인하기");
			 	btn.setUrl_mobile("http://m.enuri.com/mobilefirst/evt/smart_benefits.jsp?#tab2");
			 	btn.setUrl_pc("http://www.enuri.com/event2019/smart_benefits.jsp?&tab=nuri_stamp");
				data.setButton1(btn);

				JSONArray rtnArr = bizProc.sendPost(data);	// 서버 전송
				if (rtnArr == null || rtnArr.length() <= 0) {
					logMsg("sendBizMsg", "### send post return error... data=>"+data.getJson());
				} else {
					for (int j=0; j<rtnArr.length(); j++) {
						if (bizProc.updRtnMsg(rtnArr.getJSONObject(j))) {	// status Ready > Save
							successCnt++;
						} else {

						}
					}
				}
			}
		} catch (Exception e) {
			throw new ExceptionManager("Biz_Proc.java", "sendBizMsg", e.getLocalizedMessage());
		}
	} // for
	return successCnt;
}
private void logMsg(String method, String msg) {
	System.out.println("["+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime())+"] === biz/sawon_alimtalk.jsp === " + method + "=> " + msg);
}
%>
