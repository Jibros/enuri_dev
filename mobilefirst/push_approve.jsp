<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.RSAMains"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@page import="org.json.*"%>

<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%
	Mobile_Push_Proc mobile_push_proc = new Mobile_Push_Proc();

	/* int vReturn = 0;
	
	boolean vReturn2 = false;
	boolean vTrue = false;
	
	String strRSA2 = ""; 
	 
	String strRSA = ChkNull.chkStr(request.getParameter("pd"));
	
	strRSA = strRSA.replaceAll("-","+");
	strRSA = strRSA.replaceAll("_","/"); 
	
	if(strRSA.length() > 0){ 	  
 		strRSA2	= mobile_push_proc.longdecrypt3(strRSA);   
 	}    
	//out.println(strRSA2);
	
	//strRSA2  = "chk=1&app_id=1001&app_type=A&user_data=b3ec2240ee602e2e"; 셀렉트테스트
	//strRSA2  = "chk=2&app_id=1003&app_type=I&user_data=73409e43499a0f7e&approve_type=update&approve_yn=YN&approve_date=201705081539&adpushyn=Y&ver=2.0.4.02";
	if(strRSA2.indexOf("app_id") > -1 && strRSA2.indexOf("app_type") > -1 && strRSA2.indexOf("user_data") > -1 ){
		vTrue = true;
	}   

  
 	String astrRSA[] = strRSA2.split("&");
 	
	int intRSACnt = astrRSA.length; 

	String sChk 				="";
	
	String sApp_id 			= "";
	String sApp_type 		= "";   
	
	String sUser_data 		= "";
	
	String sPush_approve_type = "";
	String sPush_approve_yn = "";
	String sPush_approve_date = "";
	//Type == all 일때 사용하는 파라미터
	String sPush_approve_info_yn = "";
	String sPush_approve_ad_yn = "";
	
	String sApp_ver = "";
	String sAdpushyn = "";
	
	if(vTrue && strRSA2.length() > 0 && intRSACnt >= 3){

		for (int i=0 ; i<intRSACnt ; i++){
	String strKey =astrRSA[i].substring(0, astrRSA[i].indexOf("="));
	String strValue =astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length());
	if("chk".equals(strKey)){
		sChk = strValue;
	}else if("app_id".equals(strKey)){
		sApp_id = strValue;
	}else if("app_type".equals(strKey)){
		sApp_type = strValue;
	}else if("user_data".equals(strKey)){
		sUser_data = strValue;
	}else if("approve_type".equals(strKey)){
		sPush_approve_type = strValue;
	}else if("approve_yn".equals(strKey)){
		sPush_approve_yn = strValue;
	}else if("approve_date".equals(strKey)){
		sPush_approve_date = strValue;
	}else if("ver".equals(strKey)){
		sApp_ver = strValue;
	}else if("adpushyn".equals(strKey)){
		sAdpushyn = strValue;
	}
	//out.println(strKey +" : "+strValue);
		}
		
		// strPushApproveType    --->  all		: 전체동의/전체거절 
		//									ad 	: 광고 동의
		//									info 	: 정보동동의여부
		//									price : 가격동의여부
		// */
		 
//20171113 손진욱 t1 pd 모듈 
	PDManager_Proc pdmanager = new PDManager_Proc();
	PDManager_PD_Data pdData = pdmanager.chkPD(request);
	//System.out.println(pdData.toString());
	if(pdData != null && pdData.isDataPush() )
	{

	
	
		// strPushApproveType    --->  		all		: 전체동의/전체거절 
		//									ad 	: 광고 동의
		//									info 	: 정보동동의여부
		//									price : 가격동의여부
		//
		boolean vReturn2 = false;
		String sPush_approve_info_yn = "";
		String sPush_approve_ad_yn = "";
		JSONObject jSONObject = new JSONObject();
		//out.println(pdData.toString());
		if (pdData.getChk().equals("1")) {
			//select
			jSONObject = mobile_push_proc.pushApproveList(pdData.getAppid(), pdData.getApp_type(),
					pdData.getUuid());

			out.println(jSONObject.toString());
		} else if (pdData.getChk().equals("2")) {
			//update
			if (pdData.getAppid().length() > 0 && pdData.getApp_type().length() > 0
					&& pdData.getUuid().length() > 0 && pdData.getApprove_type().length() > 0
					&& pdData.getApprove_yn().length() > 0 && pdData.getApprove_date().length() > 0) {

				String result = mobile_push_proc.settingAWS(pdData.getUuid(), pdData.getAppid(),
						pdData.getApp_type(), pdData.getApprove_type(), pdData.getApprove_yn(),
						pdData.getAdpushyn());
				//out.println(result);

				if (result.contains("s_id")) { //결과 값이 있을 때만 실제 디비에 쌓아보자 --- sid도 쌓을수 있도록 변경 20170316
					vReturn2 = mobile_push_proc.updatePushApproveWithSID(pdData.getAppid(),
							pdData.getApp_type(), pdData.getUuid(), pdData.getApprove_type(),
							pdData.getApprove_yn(), pdData.getApprove_date(), result);
				} else { //ARN값이 없을때도 YN값은 저장되도록 update API를 호출한다. 셀렉트 한 NY값을 넣는다. ---- 클라이언트 서버 Sync 맞출려고
					try {
						JSONObject jj = new JSONObject(result);
						sPush_approve_info_yn = jj.getString("AD_PUSH_YN");						
						sPush_approve_ad_yn = jj.getString("INFO_PUSH_YN");
					} catch (JSONException e) {
							vReturn2 = false;
					}
					vReturn2 = mobile_push_proc.updatePushApprove(pdData.getAppid(), pdData.getApp_type(),
								pdData.getUuid(), pdData.getApprove_type(), pdData.getApprove_yn(),
								pdData.getApprove_date(), sPush_approve_info_yn, sPush_approve_ad_yn);
					
				}
				//out.println(vReturn2);
				if (!pdData.getVer().equals("")) {
					boolean isVersionMatch = false;
					int androidVersion = 0, iOSversion = 0;
					if (pdData.getAppid().equals("1001")) { // 에누리코어
						androidVersion = 327;
						iOSversion = 327;
					} else if (pdData.getAppid().equals("1003")) { //소셜 
						androidVersion = 204;
						iOSversion = 20401;
					}

					if (pdData.getApp_type().equals("A")
							&& Integer.parseInt(pdData.getVer().replace(".", "")) > androidVersion) {
						isVersionMatch = true;
					} else if (pdData.getApp_type().equals("I")) {
						int ver = 0;
						String verString = pdData.getVer().substring(0,5);
						ver = Integer.parseInt(verString.replace(".",""));
						//out.println(ver);
						if (ver > iOSversion) {
							isVersionMatch = true;
						}
					}

					if (isVersionMatch) {//app_ver 파라미터가 있고, 라스트버전이 맞을때 ..
						JSONObject reJson = new JSONObject();
						if (vReturn2) {
							reJson.put("result", "Y");
						} else {
							reJson.put("result", "N");
						}
						//reJson.put("pddate", pdData.toString());
						reJson.put("re", result);
					
						long cTime = System.currentTimeMillis();
						SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmss");
						String nowDt = dayTime.format(new Date(cTime));

						reJson.put("regdate", nowDt);
						out.println(reJson.toString());
					} else {
						if (pdData.getApp_type().equals("I") || vReturn2) {
							out.println("result=ok");
						} else {
							out.println("result=fail");
						}
					}
				} else {
					if (pdData.getApp_type().equals("I") || vReturn2) {
						out.println("result=ok");
					} else {
						out.println("result=fail");
					}
				}
			} else {
				out.println("result=fail");
			}
		}
	}
%> 