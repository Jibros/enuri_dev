<%@page import="com.enuri.bean.edeal.Edeal_Order_Proc"%>
<%@page import="com.enuri.bean.member.Join_Data"%>
<%@page import="com.enuri.bean.event.Members_Friend_Proc2"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Shop_Bridge_Log_Proc"%>
<jsp:useBean id="Moble_Shop_Bridge_Log_Proc" class="com.enuri.bean.mobile.Mobile_Shop_Bridge_Log_Proc" scope="page" />
<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%@ page import="com.enuri.bean.mobile.PDManager_T1_Data"%>
<%@page import="org.json.*"%>
<%
if(1==1){
	return;
}
String strEnrUsrId = "";
String strSpmCd = "";

SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
String strToday = formatter.format(new Date()); 	
int intToday = Integer.parseInt(strToday);
String strConf_ci_key = ""; //본인인증키
boolean blCheck = false;
int intReturnCd = -5; 
/*
new ver.
-1 : 본인 인증 X, -2: 임직원 O, -3 : 쇼핑몰 중복(본인인증키값 기준, 쇼핑몰 전부 중복임) , -5 : 초기값
1 : 데이터 적재 O
*/

JSONObject jobject = new JSONObject ();
JSONArray jarray = new JSONArray();
int intSuccessCnt = 0; //성공한 개수

strSpmCd = ChkNull.chkStr(request.getParameter("spmcd"), "");
String strServerNm = request.getServerName();

if(strSpmCd.length() > 0) {
	PDManager_Proc pdmanager = new PDManager_Proc();
	PDManager_T1_Data t1Data = pdmanager.getT1(request);

	boolean blCheck_t1 = false;
	if (t1Data != null && t1Data.isData() && t1Data.isInFireDate()) {
		strEnrUsrId = t1Data.getStrT1_enuriid();
		blCheck_t1 = true;
	}
	
	if(blCheck_t1) {
		
       	Edeal_Order_Proc edeal_order_proc = new Edeal_Order_Proc();
       	boolean IsEnuriEmployee = false;
       	if(strEnrUsrId.length()>0) 	IsEnuriEmployee = edeal_order_proc.isEnuriEmployee(strEnrUsrId);

       	if(IsEnuriEmployee){ //임직원 O
       		intReturnCd = -2 ;
       	} else { // 임직원 X
      			Join_Data join_Data = new Join_Data();
      			Members_Friend_Proc2 members_Friend_Proc2 = new Members_Friend_Proc2();
      			join_Data =  members_Friend_Proc2.getMemberData(strEnrUsrId);
      			strConf_ci_key = join_Data.getConf_ci_key();//본인인증여부
       		if(!strConf_ci_key.equals("")) { //본인인증 o
       			blCheck =true;
       		} else { // 본인인증 x
       			intReturnCd = -1 ;
       		}
       	}

       	if(blCheck) {
			//중복체크
			String strSpmCdArr [] = strSpmCd.split(",");
			//중복 체크
			for(int i =0; i < strSpmCdArr.length; i++) {
				int intChkResult = 0;
				int intSpmCd = Integer.parseInt(strSpmCdArr[i]);
				String strEvntCd = Moble_Shop_Bridge_Log_Proc.getEventId(intSpmCd); // event_main에서 가져오기
				intChkResult = Moble_Shop_Bridge_Log_Proc.connShopEventChk(intSpmCd, strEnrUsrId, strConf_ci_key);
				if(intChkResult == 0) { //중복X, e머니 지급은 하지 않음 
					boolean blResult = Moble_Shop_Bridge_Log_Proc.insertConnShopEvent(strEvntCd, intSpmCd, strEnrUsrId, strConf_ci_key);
					if (blResult) {
						++intSuccessCnt;
						jarray.put(intSpmCd);
					}
				} 
			}
			if (intSuccessCnt > 0) {
				intReturnCd = 1;
			} else {
				intReturnCd = -3; //쇼핑몰 전부 중복임
			}
		}
		
		jobject.put("success", true);
		jobject.put("returnCode", intReturnCd);
		jobject.put("insertCnt", intSuccessCnt);
		jobject.put("insertShopList", jarray);
		jobject.put("enrUsrId", strEnrUsrId);
	} else {
		jobject.put("success", false);
		jobject.put("msg", "Invaild t1data");
	}
} else {
	jobject.put("success", false);
	jobject.put("msg", "Invaild Parameter");
}

out.println(jobject.toString());
%>
