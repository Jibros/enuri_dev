<%@page import="com.enuri.bean.biz.Biz_Btn_Data"%>
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
<%@page import="com.enuri.bean.bizm.Bizm_Proc"%>
<%@page import="com.enuri.bean.bizm.Bizm_Data"%>
<%@page import="com.enuri.bean.event.Members_Friend_Proc2"%>
<%@page import="com.enuri.bean.member.Join_Data"%>
<%@page import="com.enuri.bean.biz.Biz_Proc" %>
<%@page import="com.enuri.bean.biz.Biz_Data"%>
<%@page import="com.enuri.exception.ExceptionManager"%>
<%
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date()); 								//	오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크
	String server = "real";
	if (referer.indexOf("dev") > -1 || !"".equals(sdt)) {
		strToday = sdt;
		
	}
	if(referer.indexOf("dev")>-1){
		server = "dev";
	}
	/* if (referer.indexOf("enuri.com") < 0 || Integer.parseInt(strToday) < 20200901 || 20201004 < Integer.parseInt(strToday) ) {
		return;
	} */
	/*
	procCode
		1 : 2020 상자 찾기
		2 : 구매응모 참여
		3 : 알림톡
	*/
	int procCode = ChkNull.chkInt(request.getParameter("procCode"));				//	이벤트 유형
    int intResultValue = -3; 														// 	결과값
    JSONObject jSONObject = new JSONObject();
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); 	// 	참여 os type
	String ostpcd = ChkNull.chkStr(request.getParameter("ostpcd"), "PC").trim(); 	// 	참여 os type
	String emoney = ChkNull.chkStr(request.getParameter("emoney"), "0").trim();
    try{
    	if(1 == procCode){
        	/*
        	intResultValue
    	    	-2	 		: 임직원
    	    	-55 		: 오늘날짜로 참여가 아닌경우
    	    	-1  		: 당일 참여 완료
    	    	 0 - 10000 	: 리워드지급성공 및 액수반환
        	*/
     		if(!userId.equals("")){
    	        intResultValue = new Event_Welcome_Proc().random_event_ins("2020120120", userId, strToday, osType);
     	    }
        }else if(2 == procCode){
        	/*
        	intResultValue
    	    	1			: 신청성공
    	    	2601		: 이미 신청
    		*/
	   		//intResultValue = new Event_Lina_Proc().ins_event(userId, "2020090120").getInt("result");
        	// userid, String eventId, String osType, String osTpcd
        	
        	Edeal_Order_Proc edeal_order_proc = new Edeal_Order_Proc();
        	boolean IsEnuriEmployee = false;
        	if(userId.length()>0) 	IsEnuriEmployee = edeal_order_proc.isEnuriEmployee(userId);
        	
        	//에누리직원은 응모할수없다
        	if(IsEnuriEmployee){
        		jSONObject.put("result",-99);
        		out.println(jSONObject.toString());
        		return;
        	}
        	
        	intResultValue = new Event_Lina_Proc().ins_event_optpcd(userId, "2020120121", osType , ostpcd).getInt("result");
        	
        	
        }else if(3==procCode){
        	Join_Data join_Data = new Join_Data();
        	Members_Friend_Proc2 members_Friend_Proc2 = new Members_Friend_Proc2();
        	join_Data =  members_Friend_Proc2.getMemberData(userId);
        	StringBuilder msg = new StringBuilder() ;
        	String template_code = "om_2020xmas";
        	Biz_Proc bizProc = new Biz_Proc();
        	String mm = "12";
        	int dd = Integer.parseInt(strToday.substring(6))+14;
        	
			if(dd > 31){
				mm = "1";
				dd = dd-17;
			}
        	msg.append("[에누리 가격비교]\n");
        	msg.append("E머니 지급 안내\n\n");
        	msg.append(userId+"고객님, 안녕하세요\n");
        	msg.append("크리스마스 이벤트 당첨 e머니가 지급됐습니다.\n\n");
        	msg.append("■ 지급 e머니 : "+emoney+"원\n");
        	msg.append("■ 소멸 일시 : "+mm+"월 "+dd+"일 23:59\n\n");
        	msg.append("▶에누리에서 E머니 혜택을 확인하세요!");
        	join_Data.setUserid(userId);

        	alertTak(join_Data, template_code, msg.toString(), server);
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
