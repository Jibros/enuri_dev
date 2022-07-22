<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.depart.Save_Goods_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%@ page import="org.json.*"%>
<%
	//20171113 손진욱 t1 pd 모듈
	PDManager_Proc pdmanager = new PDManager_Proc();
	PDManager_PD_Data pdData = pdmanager.chkT1PD(request);
	String sApp_type = "";
	String sTime = "";
	String sUuid = "";
	String sEnuri_id = "";
	String strT1_enuriid = "";
	boolean blCheck_app = false;
	boolean blCheck_web = false;

	String browser = request.getHeader("User-Agent");

	String strApp_type = "";

	if ((browser + "").indexOf("Darwin") > -1) {
		strApp_type = "I";
	} else {
		strApp_type = "A";
	}

	if (pdData != null) {
		sApp_type = pdData.getAppid();
		strT1_enuriid = pdData.getEnuri_id();
		sTime = pdData.getTimes();
		sUuid = pdData.getUuid();
		blCheck_app = true;
	} else if (ChkNull.chkStr(request.getParameter("sh")).equals("Y")) {
		strT1_enuriid = cb.GetCookie("MEM_INFO", "USER_ID");
		sApp_type = "W" + ChkNull.chkStr(request.getParameter("appId"));
		blCheck_web = true;
	}

	if (blCheck_app || blCheck_web) {
		//정상 통과
		String strMemberId = strT1_enuriid;
		String modelNo = ChkNull.chkStr(request.getParameter("modelnos"), "");

		JSONObject result = new JSONObject();
		result.put("modelno", "0");
		result.put("minprice", "0");
		result.put("reg_date", JSONObject.NULL);

		String appId = "", appType = "";

		if (sApp_type.length() == 5) {
			appType = sApp_type.substring(0, 1);
			appId = sApp_type.substring(1);
		}

		if (modelNo != null && modelNo.length() > 0) {
			Save_Goods_Proc proc = new Save_Goods_Proc();
			try {
				JSONObject item = proc.getMinpriceItemOne(appId, strMemberId, modelNo);
				if (item != null) {
					result = item;
				}
			} catch (Exception e) {

			}
		}

		out.println(result.toString(4));
	}
%>

<%!//특수문자 제거 하기
	public static String StringReplace(String str) {
		String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";
		str = str.replaceAll(match, "").trim();
		return str;
	}%>