<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.depart.Save_Goods_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%
	//20171113 손진욱 t1 pd 모듈
	PDManager_Proc pdmanager = new PDManager_Proc();
	PDManager_PD_Data pdData = pdmanager.chkT1PD(request);
	boolean blCheck_web = false;
	boolean blCheck_app = false;
	String sEnuri_id = "";
	String sApp_type = "";
	if (ChkNull.chkStr(request.getParameter("sh")).equals("Y")) {
		sEnuri_id = cb.GetCookie("MEM_INFO", "USER_ID");
		sApp_type = "W" + ChkNull.chkStr(request.getParameter("appId"));
		blCheck_web = true;
	}
	if (pdData != null && pdData.isData()) {
		sApp_type = pdData.getAppid();
		sEnuri_id = pdData.getEnuri_id();
		blCheck_app = true;
	}
	boolean blCheck = false;
	if (blCheck_app || blCheck_web) {
		Save_Goods_Proc save_goods_proc = new Save_Goods_Proc();

		String strUserId = sEnuri_id;
		String strModelNos = ChkNull.chkStr(request.getParameter("modelnos"), "");
		String tempModelnos = "";
		String tempPlnos = "";

		String[] strModelNosAry = strModelNos.split(",");
		if (strModelNosAry != null && strModelNosAry.length > 0) {
			for (int i = 0; i < strModelNosAry.length; i++) {
				if (strModelNosAry[i].indexOf("G:") > -1
						|| (strModelNosAry[i].indexOf("G:") < 0 && strModelNosAry[i].indexOf("P:") < 0)) {
					if (tempModelnos.length() > 0)
						tempModelnos += ",";
					tempModelnos += strModelNosAry[i].replace("G:", "");
				}
				if (strModelNosAry[i].indexOf("P:") > -1) {
					if (tempPlnos.length() > 0)
						tempPlnos += ",";
					tempPlnos += strModelNosAry[i].replace("P:", "");
				}
			}
		}
		String minAppId = "", minAppType = "";
		if (sApp_type.length() == 5) {
			minAppType = sApp_type.substring(0, 1);
			minAppId = sApp_type.substring(1);
		}
		// 모델번호 삭제
		if (tempModelnos.length() > 0) {
			blCheck = save_goods_proc.deleteMinpriceAlarmModelno(minAppId, minAppType, tempModelnos, strUserId);
		}
		// 추가검색상품(plno)삭제
		if (tempPlnos.length() > 0) {
			blCheck = save_goods_proc.deleteMinpriceAlarmPlno(minAppId, minAppType, tempPlnos, strUserId);
		}
	}
	out.println("{");
	out.println("	   \"result\": \"" + blCheck + "\" ");
	out.println("}");
%>