<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.RSAMains"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@ page import="com.enuri.bean.mobile.CRSA"%>
<%@ page import="com.enuri.bean.mobile.Reward_Data"%>
<%@ page import="com.enuri.bean.mobile.Reward_Proc"%>
<jsp:useBean id="Reward_Data" class="com.enuri.bean.mobile.Reward_Data"
	scope="page" />
<jsp:useBean id="Reward_Proc" class="com.enuri.bean.mobile.Reward_Proc"
	scope="page" />

<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%@ page import="com.enuri.bean.mobile.PDManager_T1_Data"%>

<%
	//t1=@@@&enuri_id=@@@&shop_code=@@@&order_no=@@@&user_data=@@@
	//20171113 손진욱 t1 pd 모듈
	PDManager_Proc pdmanager = new PDManager_Proc();
	PDManager_T1_Data t1Data = pdmanager.getT1(request);
	PDManager_PD_Data pdData = pdmanager.chkT1PD(request, t1Data);
	

	String strR_code = "";
	String strR_msg = "";
	String strAppShow_msg = "";

	boolean blCheck_t1 = false;

	String strT1_fdate = "";
	String strT1_enuriid = "";
	String strT1_userdata = "";

	
	
	if (t1Data != null && t1Data.isData() && t1Data.isInFireDate()) {
		strT1_enuriid = t1Data.getStrT1_enuriid();
		strT1_userdata = t1Data.getStrT1_userdata();
		strT1_fdate = t1Data.getStrT1_fdate();
		blCheck_t1 = true;
		
		
	}
	
	String sEnuri_id = "";
	String sShop_code = "";
	String sOrder_no = "";
	String sUser_data = "";

	if (blCheck_t1 && pdData != null && pdData.isDataReward()) {
		sEnuri_id = pdData.getEnuri_id();
		sShop_code = pdData.getShop_code();
		sOrder_no = pdData.getOrder_no();
		sUser_data = pdData.getUuid();

		//옥션만 싱글쿼테이션 삭제 2017.3.10(탄핵날) shwoo
		if (sShop_code.equals("auction")) {
			//System.out.println("sOrder_no_before>>>>"+sOrder_no);
			sOrder_no = sOrder_no.replaceAll("'", "");
			//System.out.println("sOrder_no_after>>>>"+sOrder_no);
		}
		int issuccess = 0;
		/////////////////////////////////////////////////////////////
		//스마트팜은 보내는 내용이 좀 다르다 
		//enuri_id=sonane45&shop_code=smartstore.naver.com/inlstore/&order_no=2019111232133546/inlstore&user_data=		
		boolean smartFarmStore_Pass = true;		
		
		
		
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
				{
					sOrder_no = strs[0];
					if(!strs[1].equals(smartFarmStoreOrderCodeSplit[i])){
						smartFarmStore_Pass = false;
						issuccess = 5;
					}		
				}else 
					sOrder_no = sOrder_no.replace("/", "");
			
				break;
			}
		}
		/////////////////////////////////////////////////////////////
		
		
		if(smartFarmStore_Pass){
			// x하나라도 오류나면, 롤백 !
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
				//out.println("strKey_order>>"+strKey_order +"<br>");
				//out.println("sShop_code>>"+ch_shopcode(sShop_code) +"<br>");
				//out.println("strOther_order>>>"+strOther_order +"<br>");
				//out.println("sUser_data>>>"+sUser_data +"<br>");
				//지마켓은 마지막에 값을 넣어주고 다른 숖은 안넣어주고.
				//issuccess = Reward_Proc.Reward_Cart_Ins(strKey_order, ch_shopcode(sShop_code), sEnuri_id, sUser_data, strOther_order);
				//2017-05-10 pd 아이디에서 t1 아이디로 변경
				
				
				
				issuccess = Reward_Proc.Reward_Cart_Ins_Mobile(strKey_order, ch_shopcode(sShop_code), strT1_enuriid,
						sUser_data, strOther_order);
			} else {
				if (sOrder_no.indexOf("tps://smshop.interpark.com/ord") > -1) { //인터파크 예외처리(결제창 원페이 --;;;)
					issuccess = 1; //log 디비는 쌓고 (reward_order_insert_log.jsp) 여기서는 db는 안 쌓고. 손진욱 요청 2017-01-24
				} else {
					//issuccess = Reward_Proc.Reward_Cart_Ins(sOrder_no, ch_shopcode(sShop_code), sEnuri_id, sUser_data, "");
					//2017-05-10 pd 아이디에서 t1 아이디로 변경
					issuccess = Reward_Proc.Reward_Cart_Ins_Mobile(sOrder_no, ch_shopcode(sShop_code), strT1_enuriid,
							sUser_data, "");
				}
			}
		}

		if (issuccess == 1) {
			strR_code = "100";
			strR_msg = "ok";
		} else if (issuccess == 2) {
			strR_code = "600";
			strR_msg = "적립군이 아닙니다.";
		} else if (issuccess == 5){//스마트 팜 3.5.7 버전 부터 팝업 안내 내용 띄우는 기능 적용 
			strR_code = "700";
			strAppShow_msg = "리워드 적립 쇼핑몰이 아닙니다.";
		}
		else {
			strR_code = "400";
			strR_msg = "이미 입력된 data입니다.";
		}

	} else if (blCheck_t1 == false) {
		strR_code = "300"; //원래 200 인데, 잠시 300으로 처리 (하위버전이 만료 지원을 안함.-강제로그아웃) v.3.2.5
		strR_msg = "에누리 로그인 후 다시 구매를 하세요."; //기간 만료시
	} else  {
		strR_code = "500";
		strR_msg = "유효한 접근경로가 아닙니다.";
	}

	out.println("{");
	out.println("	   \"code\": \"" + strR_code + "\", ");
	out.println("	   \"sOrder_no\": \"" + sOrder_no + "\", ");
	out.println("	   \"message\": \""+strAppShow_msg+"\" ");
	
	out.println("}");

	/*
	 구분 					code 				message 							비고 
	 1 	성공 					100 				ok 　 
	 2 	기한만료	 			200 				기한이 만료되었습니다. 　 
	 3 	data 오류 			300 				data를 조회할 수 없습니다. 		데이터 오류 
	 4 	server 오류 			400 				data를 조회할 수 없습니다. 		서버 오류 & 데이터 중복오류
	 */
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
		if (strShop.equals("skstoa.com")){
			rtn_String="9011";
		}
		if (strShop.equals("homeplus")){
			rtn_String="6361";
		}
		
		if (strShop.equals("feelway.com")){
			rtn_String="15917";
		}
		
		return rtn_String;
	}%>
