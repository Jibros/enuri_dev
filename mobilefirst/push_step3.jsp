<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>

<%@ page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="org.json.simple.*"%>
<%
	Mobile_Push_Proc mobile_push_proc = new Mobile_Push_Proc();

	//20171113 손진욱 t1 pd 모듈 
	PDManager_Proc pdmanager = new PDManager_Proc();
	final PDManager_PD_Data pdData = pdmanager.chkPD(request);

	
	

	if (pdData != null && pdData.isDataPush()) {
		int vReturn;
		boolean vReturn2 = false;
		String sendError = "normal";
		String sEventChk = null;
		//Aos일때 i_use_date가 없을수도 있음
		if (pdData.getI_user_data() == null || pdData.getI_user_data().equals("")) {
			pdData.setI_user_data(pdData.getUuid());
		}
	
		//ios sns 로그인이 3.4.7.02에서 아이디가 소셜 로그인 아이디가 오고 있음 
		if(pdData.getVer().equals("3.4.7.02"))
		{	
			String getMyId = mobile_push_proc.getIDfromSnsID(pdData.getEnuri_id());
			if(getMyId.length() > 0)
				pdData.setEnuri_id(getMyId);		
		}
		
		//if(sEndpoint_arn.equals("") || sEndpoint_arn.equals("fail")){
		//	if(sEndpoint_arn.equals("fail")){
		//		System.out.println(" 모바일팀에 가르쳐주세요!  ENDPOINT_ARN ==== FAIL 로 떨어짐, PUSH-DATA 관련사항입니다!  ");
		//	}  
		//}else{        
		//if(sApp_type.equals("A")){
		//	vReturn = mobile_push_proc.getPushChk_AND(sUser_data, sEndpoint_arn); 
		//}else if(sApp_type.equals("I")){  
		//	vReturn = mobile_push_proc.getPushChk_IOS(sToken, sEndpoint_arn);
		//}  
		//vReturn = mobile_push_proc.getPushChk2(sUser_data, sEndpoint_arn);     
		//		vReturn = mobile_push_proc.getPushChk3(sUser_data, sEndpoint_arn, sApp_id, sApp_type);
		vReturn = mobile_push_proc.getPushChk3(pdData.getUuid(), pdData.getEndpoint_arn(), pdData.getAppid(),
				pdData.getApp_type());
		//if( !sEnuri_id.equals("") && ( sVersion.equals("3.0.4") || sVersion.equals("3.0.4.00") ) ){
		if (vReturn == 1) { //insert            
			//vReturn2 = mobile_push_proc.insertPush(sApp_id, sApp_type, sToken, sEndpoint_arn, sUser_data, sEnuri_id, sAd_id, sVersion);
			//vReturn2 = mobile_push_proc.insertPush3(sApp_id, sApp_type, sToken, sEndpoint_arn, sUser_data,
			//		sEnuri_id, sAd_id, sVersion, sIuser_data);			
			vReturn2 = mobile_push_proc.insertPush3(pdData.getAppid(), pdData.getApp_type(), pdData.getToken(),
					pdData.getEndpoint_arn(), pdData.getUuid(), pdData.getEnuri_id(), pdData.getAd_id(),
					pdData.getVer(), pdData.getI_user_data());
			//out.println("insert");  
		} else if (vReturn > 1) {
			//   2:  update : VERSION_FIRST 비어있음, 넣어줘야함
			//   3 : update : VERSION_FIRST 값 들어가있음, VERSION_LAST 값 갱신해줌
			//   4 : update : ENDPOINT_ARN 일치하는게 있고, USER_DATA 가 없음  
			//try{ 
			//System.out.println(vReturn +"		"+ sApp_id +"		"+  sApp_type +"		"+  sToken +"		"+ sEndpoint_arn +"		"+ sUser_data +"		"+ sEnuri_id +"		"+ sAd_id +"		"+ sVersion);
			//vReturn2 = mobile_push_proc.updatePush3(vReturn, sApp_id, sApp_type, sToken, sEndpoint_arn, sUser_data, sEnuri_id, sAd_id, sVersion);
			//vReturn2 = mobile_push_proc.updatePush4(vReturn, sApp_id, sApp_type, sToken, sEndpoint_arn, sUser_data, sEnuri_id, sAd_id, sVersion);
			//vReturn2 = mobile_push_proc.updatePush7(vReturn, sApp_id, sApp_type, sToken, sEndpoint_arn, sUser_data, sEnuri_id, sAd_id, sVersion, sIuser_data);
			//vReturn2 = mobile_push_proc.updatePush8(vReturn, sApp_id, sApp_type, sToken, sEndpoint_arn,
			//	sUser_data, sEnuri_id, sAd_id, sVersion, sIuser_data);
			String arn = pdData.getEndpoint_arn();
			if(arn.getBytes().length >= 1000) {
				sendError = sendErrorLogHttp(pdData.getApp_type(), pdData.getUuid(), pdData.getVer(), arn.replaceAll("[$]"," "), pdData.getToken()+" : "+pdData.getAd_id());
				arn = "";
			}
			
			vReturn2 = mobile_push_proc.updatePush8(vReturn, pdData.getAppid(), pdData.getApp_type(),
					pdData.getToken(), arn, pdData.getUuid(), pdData.getEnuri_id(),
					pdData.getAd_id(), pdData.getVer(), pdData.getI_user_data());
		}

		//if( !sEnuri_id.equals("") && ( sVersion.equals("3.0.4") || sVersion.equals("3.0.4.00") ) ){
		//System.out.println("sEnuri_id===="+sEnuri_id); 
		if (pdData.getEnuri_id() != null && !pdData.getEnuri_id().equals("")) {
			//sEventChk = mobile_push_proc.insertEvent2(sEnuri_id, sUser_data, 500, cur_date, sVersion, "20160215");
			//1. 앱에서 첫 로그인일때, nomiee에 user_data, version 관련 업데이트
			//vReturnNomiee = members_friend_proc.getNomieeUpdate(sEnuri_id, sUser_data, sVersion);	
			//2. 첫설치, 첫구매 관련 intall에 insert
			//sEventChk = mobile_push_proc.insertEvent3(sEnuri_id, sUser_data, sVersion, "20160215");
			sEventChk = mobile_push_proc.insertEvent3(pdData.getEnuri_id(), pdData.getUuid(), pdData.getVer(),
					"20160215");
			//3. install에서 id, user_data 관련 데이터 수집해서 nomiee 테이블에 입력
			//vReturnNomiee2 = members_friend_proc.getNomieeUpdateFromInstall(sEnuri_id, sUser_data);	
		}

		//System.out.println("sPush_loginshop>>>"+sPush_loginshop);

		if (pdData.getLogin_shop() != null && !pdData.getLogin_shop().equals("")) {
			//login_shop정보있으면 업데이트 시켜줌
			boolean blShop_update = mobile_push_proc.updateEvent_loginshop(pdData.getAppid(),
					pdData.getApp_type(), pdData.getUuid(), pdData.getLogin_shop());
		}
		

	//	System.out.println("vReturn " + vReturn + " vReturn2 " + vReturn2 + " sEventChk " + sEventChk);

		//System.out.println(pdData.toString());

		//}          

		out.println("result=ok : " + vReturn2+ " : "+sendError);
	}
%>

<%!
public String sendErrorLogHttp(String appType, String userdata, String version, String msg, String token) {
	try {
		String recv;
		
		if(msg.contains("registered with a different token")) {
			msg = token;
		}
		msg = subStrByte(msg.replaceAll("[$]"," "), 220);
		msg = URLEncoder.encode(msg,"UTF-8");
		
		StringBuffer recvbuff = new StringBuffer();
		recvbuff.append("http://m.enuri.com/mobilefirst/api/appErrorLog.jsp?appId=1001&appType=");
		recvbuff.append(appType);
		recvbuff.append("&errorType=1").append("&shopCode=0").append("&userData=").append(userdata);
		recvbuff.append("&version=").append(version).append("&errorCode=PUSH_REGIST").append("&errorMsg=").append(msg);
		URL jsonpage = new URL(recvbuff.toString());
		URLConnection urlcon = jsonpage.openConnection();
		//urlcon.setConnectTimeout(10000);
		InputStream inputStream = urlcon.getInputStream();

		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		byte[] arBytes = null;
		byte[] readByte = new byte[1024];
		int readLen;
		while ((readLen = inputStream.read(readByte)) != -1) {
			outputStream.write(readByte, 0, readLen);
		}
		arBytes = outputStream.toByteArray();
		outputStream.close();
		inputStream.close();

		return msg;
	} catch (Exception e) {
	    return e.getMessage();
	}	
}

public String subStrByte(String srcStr, int length) {
	try {
		if(!srcStr.isEmpty()) {
			srcStr = srcStr.trim();
			if(srcStr.getBytes().length <= length){
				return srcStr;
			}else{
				StringBuffer str = new StringBuffer(length);
				int cnt = 0;
				for(int i =0; i < srcStr.length() ; i++) {
					char c = srcStr.charAt(i);
					cnt += String.valueOf(c).getBytes().length;
					if(cnt > length ) {
						break;
					}
					str.append(c);
				}
				return str.toString();
			}
		}else{
			return "substring fail...";
		}
	}catch (Exception e){
		return e.getMessage();
	}
}

%>
