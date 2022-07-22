<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.enuri.bean.edeal.Edeal_Order_Proc"%>
<%@page import="com.enuri.bean.mobile.Event_Lina_Proc"%>
<%@page import="com.enuri.bean.mobile.Event_Welcome_Proc"%>
<%@page import="com.enuri.bean.main.deal.CrazyDeal_ShareEvt_Proc"%>
<%
	String sdt = ChkNull.chkStr(request.getParameter("sdt")).trim(); 				//	테스트 날짜
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
    String strToday = formatter.format(new Date()); 								//	오늘 날짜 (visitData, ins_date)
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크
	String server = "real";

	if(referer.indexOf("dev")>-1){
		server = "dev";
	}

	if(referer.indexOf("dev") > -1 && !"".equals(sdt)){
		strToday = sdt;
	}

	if (referer.indexOf("enuri.com") < 0
 	|| Integer.parseInt(strToday) < 20220103
	|| Integer.parseInt(strToday) > 20220203){
		return;
	}

	/*
	procCode
	1 : 즉시 지급
	2 : 응모 참여
	3 : 공유 이벤트 참여
	*/
	int procCode = ChkNull.chkInt(request.getParameter("procCode"));
	String shareType = ChkNull.chkStr(request.getParameter("shareType"),""); //	이벤트 유형
    int intResultValue = -3; // 결과값
    JSONObject jSONObject = new JSONObject();
	String strEventCode = "2022010301";
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); // 참여 ID
	String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); // 참여 os type
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
			* 	--  설날 즉시지급 (2022.01.03)
			*	--  이벤트 코드 2022010301
			*	--  return_code
			*	--		임직원 참여불가(-99)
			*	--		당일 참여X  test 날짜 조작(-55)
			*	--		이미 참여 (-22)
			*	-- 		꽝 (-44)
			*	-- 		당첨 (5)
			*/
     		if(!userId.equals("")){
    	        intResultValue = new Event_Welcome_Proc().exec_2022_newyear_event(strEventCode, userId, strToday, osType);
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
				intResultValue = new Event_Lina_Proc().ins_event_optpcd(userId, "2022010302", osType , osType).getInt("result");
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
					blInsert = proc.shareInsert_event_sdt(userId, strEventCode, shareType, osCode, strToday);
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