<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.enuri.bean.main.brandplacement.DBWrap"%>
<%@page import="com.enuri.bean.main.brandplacement.DBDataTable"%>
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

	if (pdData != null && pdData.isData()) {
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
		//strRSA2  = "chk=1&app_id=1001&app_type=A&user_data=b3ec2240ee602e2e"; 셀렉트테스트
		//strRSA2  = "chk=2&app_id=1001&app_type=A&user_data=b3ec2240ee602e2e&approve_type=ad&approve_yn=Y&approve_date=201601251313";		
		if(strRSA2.indexOf("appid") > -1 && strRSA2.indexOf("time") > -1 && strRSA2.indexOf("uuid") > -1){
			vTrue = true;
		}		
		String astrRSA[] = strRSA2.split("&"); 	
		int intRSACnt = astrRSA.length;	 */
		//if(vTrue && strRSA2.length() > 0 && intRSACnt >= 3){
		String appid = pdData.getAppid().substring(1);// astrRSA[0].substring(astrRSA[0].indexOf("=") + 2, astrRSA[0].length());
		String app_type = pdData.getAppid().substring(0, 1);
		String time = pdData.getTimes();//[1].substring(astrRSA[1].indexOf("=") + 1, astrRSA[1].length());
		String uuid = pdData.getUuid();//[2].substring(astrRSA[2].indexOf("=") + 1, astrRSA[2].length());
		String id = pdData.getEnuri_id();//[3].substring(astrRSA[3].indexOf("=") + 1, astrRSA[3].length());

		
	

		String query = "";
		query += " SELECT AD_PUSH_YN,AD_PUSH_DATE,INFO_PUSH_YN,INFO_PUSH_DATE FROM MOBILE_PUSH_TOKEN" + "\n";
		query += " WHERE APP_ID = ? AND APP_TYPE = ? AND USER_DATA = ?" + "\n";
	
		DBDataTable dt = new DBWrap("main2004").setQuery(query).addParameter(appid).addParameter(app_type)
				.addParameter(uuid.trim()).selectAllTry();
		JSONObject ret = new JSONObject();
		if (dt.count() > 0) {
			JSONObject ad = new JSONObject();
			ad.put("approve_date", dt.parse(0, "AD_PUSH_DATE", "", "yyyy-MM-dd HH:mm:ss", "yyyyMMdd"));
			ad.put("approve_yn", dt.parse(0, "AD_PUSH_YN", ""));

			ret.put("ad", ad);

			JSONObject info = new JSONObject();
			info.put("approve_date", dt.parse(0, "INFO_PUSH_DATE", "", "yyyy-MM-dd HH:mm:ss", "yyyyMMdd"));
			info.put("approve_yn", dt.parse(0, "INFO_PUSH_YN", ""));

			ret.put("info", info);

		}

		out.println(ret.toJSONString());

		//} 
	}
%>
