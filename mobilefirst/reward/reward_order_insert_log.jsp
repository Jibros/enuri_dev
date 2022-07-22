<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<jsp:useBean id="Reward_Data" class="com.enuri.bean.mobile.Reward_Data"
	scope="page" />
<jsp:useBean id="Reward_Proc" class="com.enuri.bean.mobile.Reward_Proc"
	scope="page" />
<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%@ page import="com.enuri.bean.mobile.PDManager_T1_Data"%>
<%
	//t1=@@@&enuri_id=@@@&shop_code=@@@&order_no=@@@&user_data=@@@&url=@@@&error_msg=@@@

	//20171113 손진욱 t1 pd 모듈
	PDManager_Proc pdmanager = new PDManager_Proc();
	PDManager_T1_Data t1Data = pdmanager.getT1(request);
	PDManager_PD_Data pdData = pdmanager.chkT1PD(request, t1Data);

	String strUrl = ChkNull.chkStr(request.getParameter("url"));
	String strError_msg = ChkNull.chkStr(request.getParameter("error_msg"));
	//유저에이전트로 구분이 안된다 \
	//api에서는 유저에이전트 안온다고 봐야된다 
	//20220311 부터 ios 앱이 A로 잡히고 있고 4.0.1
	//유저 데이터 길이로 구분한다 
	String strApp_type = "A";
/*
	String browser = request.getHeader("User-Agent");
	
	if ((browser + "").indexOf("Darwin") > -1) {
		strApp_type = "I";
	} else {
		strApp_type = "A";
	}	
	*/
	
	String sEnuri_id = "";
	String sShop_code = "";
	String sOrder_no = "";
	String sUser_data = "";
	String strT1_enuriid = "";
	String strT1_userdata = "";

	if (pdData != null && pdData.isDataReward()) {
		sEnuri_id = pdData.getEnuri_id();
		sShop_code = pdData.getShop_code();
		sOrder_no = pdData.getOrder_no();
		sUser_data = pdData.getUuid();
		//유저에이전트로 구분이 안된다 \
		//api에서는 유저에이전트 안온다고 봐야된다 
		//20220311 부터 ios 앱이 A로 잡히고 있고 4.0.1
		//유저 데이터 길이로 구분한다 
		//384CC108-FA4B-4DB7-AA44-18471FF1809E
		//a8d56375541a2803
		if (sUser_data.length() < 20){
			strApp_type = "A";
		}else {
			strApp_type = "I";
		}
		
		
		//스마트팜 쇼핑 리워드 대응 201912
		String smartFarmStoreShopCode[]={"smartstore.naver.com/inlstore/",
				"smartstore.naver.com/lgxnote/",
				"smartstore.naver.com/jojo/",
				"smartstore.naver.com/lgmedia/",
				"smartstore.naver.com/samsung_mall/",
				"smartstore.naver.com/guidecom/"};
		String smartFarmStoreOrderCodeSplit[]={"inlstore","lgxnote","jojo","lgmedia","samsung_mall","guidecom"};
		
		for(int  i = 0 ; i < smartFarmStoreShopCode.length; i ++){
			if(sShop_code.equals(smartFarmStoreShopCode[i])){
				String strs[] = sOrder_no.split("/");
				if(strs.length == 2)
					sOrder_no = strs[0];					
				else 
					sOrder_no = sOrder_no.replace("/", "");
				break;
			}
		}
		
		//////////////////////////////
		//지마켓 이고 undefined 이면 무시하는 로직 넣는다 
		//앱 20220223에 지마켓이 비동기로 결제정보를 넘겨주 방법이 비동기로 와서 리워드 수집 스크립트만 변경했는데 그때 undefined가 오게 되었다
		//그래서 로그에서 undefined가 오면 로그를 쌓지 않게 했다 왜냐하면 ems 에서 에러가 오기 때문이다 
		if (sShop_code.equals("gmarket")  && sOrder_no.equals("undefined")){
		
			return;
		}
	}
	if (t1Data != null && t1Data.isData()) {
		strT1_enuriid = t1Data.getStrT1_enuriid();
		strT1_userdata = t1Data.getStrT1_userdata();
	}
	if (strError_msg.contains("_300")){
		sendErrorLog(ChkNull.chkStr(request.getParameter("t1")) +"        "+ChkNull.chkStr(request.getParameter("pd")) +"        t1_"+strError_msg);			
	}
	if (pdData != null && pdData.isDataReward()) {
		// x하나라도 오류나면, 롤백 !
		int issuccess = 0;

		
		
		if (sOrder_no.indexOf(",") > -1) { //지마켓같은경우, 콤마가 넘어오면 다중입력
			String[] arr_Orderno = sOrder_no.trim().split(",");
			String strKey_order = "";
			String strOther_order = "";

			for (int j = 0; j < arr_Orderno.length; j++) {
				if (arr_Orderno[j] != null && !arr_Orderno[j].equals("")) {
					if (j == 0) {
						//0번은 G마켓 체결번호, 1번이후로는 주문번호 (체결번호가 주문번호의 키)
						strKey_order = arr_Orderno[j];
					} else {
						if (!strOther_order.equals("")) {
							strOther_order += ",";
						}
						strOther_order += arr_Orderno[j];
					}
				}
			}
			//지마켓은 마지막에 값을 넣어주고 다른 숖은 안넣어주고.
			//issuccess = Reward_Proc.Reward_Cart_Detail_Ins(strKey_order, sEnuri_id, sUser_data, strOther_order);
			Reward_Proc.Reward_Cart_Log_Ins(strKey_order, ch_shopcode(sShop_code), sEnuri_id, sUser_data,
					strOther_order, strUrl, strError_msg, strApp_type);
		} else {
			Reward_Proc.Reward_Cart_Log_Ins(sOrder_no, ch_shopcode(sShop_code), sEnuri_id, sUser_data, "",
					strUrl, strError_msg, strApp_type);
		}

		
		
	} else if (t1Data != null && t1Data.isData()) {
		
		if(pdData != null){
			sShop_code = pdData.getShop_code();		
			
			Reward_Proc.Reward_Cart_Log_Ins("", ch_shopcode(sShop_code), strT1_enuriid, strT1_userdata, "", strUrl, "t1_"
					+ strError_msg, strApp_type);
		}else {
		
			//t1은 있고 pd는 없을때
			Reward_Proc.Reward_Cart_Log_Ins("", "0", strT1_enuriid, strT1_userdata, "", strUrl, "t1_"
					+ strError_msg, strApp_type);
		}
		sendErrorLog(ChkNull.chkStr(request.getParameter("t1")) +"        "+ChkNull.chkStr(request.getParameter("pd")) +"        t1_"+strError_msg);
		
	} else
		//t1도 pd도 없을 때 
		Reward_Proc.Reward_Cart_Log_Ins("", "0", "", "", "", strUrl, strError_msg, strApp_type);

	
%>
<%!public static String ch_shopcode(String strShop) {
		String rtn_String = "";

		if (strShop.equals("11st"))
			rtn_String = "5910";
		if (strShop.equals("gmarket"))
			rtn_String = "536";
		if (strShop.equals("interpark"))
			rtn_String = "55";
		if (strShop.equals("auction"))
			rtn_String = "4027";
		if (strShop.equals(".emart"))
			rtn_String = "6665";
		if (strShop.equals("ssg"))
			rtn_String = "6665";
		if (strShop.equals("shinsegaemall"))
			rtn_String = "6665";
		if (strShop.equals("gsshop"))
			rtn_String = "75";
		if (strShop.equals("wemakeprice"))
			rtn_String = "6508";
		if (strShop.equals("ticketmonster")||strShop.equals("tmon"))
			rtn_String = "6641";
		if (strShop.equals(".lotte.com"))
			rtn_String = "49";
		if (strShop.equals("ellotte"))
			rtn_String = "6547";
		if (strShop.equals("lotteimall"))
			rtn_String = "663";
		if (strShop.equals("cjmall"))
			rtn_String = "806";
		if (strShop.equals("cjonstyle"))
			rtn_String = "806";
		if (strShop.equals("g9"))
			rtn_String = "7692";
		if (strShop.equals("hyundaihmall"))
			rtn_String = "57";
		if (strShop.equals("coupang"))
			rtn_String = "7861";
		
		if (strShop.equals("skstoa.com")){
			rtn_String="9011";
		}		
		if (strShop.equals("smartstore.naver.com/jojo/")){
			rtn_String="11889";
		}
	
		if (strShop.equals("smartstore.naver.com/inlstore/")){
			rtn_String="8270";
		}
		if (strShop.equals("smartstore.naver.com/lgxnote/")){
			rtn_String="8974";
		}
		if (strShop.equals("smartstore.naver.com/lgmedia/")){
			rtn_String="8538";
		}
		
		if (strShop.equals("smartstore.naver.com/samsung_mall/")){
			rtn_String="9735";
		}
		if (strShop.equals("smartstore.naver.com/guidecom/")){
			rtn_String="17240";
		}
		
		if (strShop.equals("homeplus")){
			rtn_String="6361";
		}
		if (strShop.equals("feelway.com")){
			rtn_String="15917";
		}
		
		return rtn_String;
	}
	public void sendErrorLog(String errorLog) {
		try {
			String recv;
			StringBuffer sendurl = new StringBuffer();
			sendurl.append("http://localhost/mobilefirst/api/appErrorLog.jsp?appId=1001&appType=E");
			String __jspName = this.getClass().getSimpleName();

			sendurl.append("&errorType=1");
			sendurl.append("&errorCode=REWARD_ERROR_WEB");

			sendurl.append("&userData=");
			sendurl.append(__jspName);
			sendurl.append("&version=0.0.0");
			sendurl.append("&shopCode=0");
			sendurl.append("&errorMsg=");

			if (errorLog.length() >= 1000)
				sendurl.append(URLEncoder.encode(errorLog.substring(0, 999), "UTF-8"));
			else
				sendurl.append(URLEncoder.encode(errorLog, "UTF-8"));

			URL obj = new URL(sendurl.toString());
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();
			//	String USER_AGENT = "Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Mobile Safari/535.19";

			con.setRequestMethod("GET");
			//con.setRequestProperty("User-Agent", USER_AGENT);

			int responseCode = con.getResponseCode();

		} catch (Exception e) {

		}

	}%>
