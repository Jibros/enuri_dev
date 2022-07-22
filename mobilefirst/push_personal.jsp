<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.RSAMains"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@page import="org.json.*"%>

<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%
	Mobile_Push_Proc mobile_push_proc = new Mobile_Push_Proc();
	//20171113 손진욱 t1 pd 모듈 
	PDManager_Proc pdmanager = new PDManager_Proc();
	PDManager_PD_Data pdData = pdmanager.chkPD(request);

	// int vReturn = 0;
	boolean vReturn2 = false;
	/*
	boolean vTrue = false; 
	
	String strRSA2 = ""; 
	
	String strRSA = ChkNull.chkStr(request.getParameter("pd"));

	strRSA = strRSA.replaceAll("-","+");
	strRSA = strRSA.replaceAll("_","/"); 
	   
	if(strRSA.length() > 0){ 	  
	strRSA2	= mobile_push_proc.longdecrypt3(strRSA);   
	}      
	
	//strRSA2  = "app_id=1001&app_type=A&user_data=b3ec2240ee602e2e"; 셀렉트테스트
	//strRSA2  = "app_id=1001&app_type=A&user_data=b3ec2240ee602e2e&gender=M&categories=02;03;04";
	//out.println(strRSA2);
	if(strRSA2.indexOf("app_id") > -1 && strRSA2.indexOf("app_type") > -1 && strRSA2.indexOf("user_data") > -1 ){
	vTrue = true;
	}   

	
	String astrRSA[] = strRSA2.split("&");
	
	int intRSACnt = astrRSA.length;  */

	if (pdData != null && pdData.isDataPush() && pdData.getGender().length() > 0) {
		String sApp_id = pdData.getAppid();
		String sApp_type = pdData.getApp_type();
		String sUser_data = pdData.getUuid();
		String sPush_Gender = pdData.getGender();
		String sPush_Categories = pdData.getCategorys();

		/*
		 sPush_Gender    ---> M		: 남자
							  F		: 여자
										  
		 sPush_Categories ---> 02;03;04 (대카테;대카테;대카테)
		 */

		JSONObject jSONObject = new JSONObject();

		if (sApp_id.length() > 0 && sApp_type.length() > 0 && sUser_data.length() > 0
				&& sPush_Gender.length() > 0) {
			vReturn2 = mobile_push_proc.updatePushPersonal(sApp_id, sApp_type, sUser_data, sPush_Gender,
					sPush_Categories);
			if (vReturn2) {
				out.println("result=ok ");
			} else {
				out.println("result=fail ");
			}
		} else {
			out.println("result=fail ");
		}
		/* }  */
	}
%>
