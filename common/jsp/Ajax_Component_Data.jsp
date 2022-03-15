<%@ page contentType = "text/json;charset=utf-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="java.io.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="com.enuri.bean.main.Component_Proc"%>
<jsp:useBean id="Component_Proc" class="com.enuri.bean.main.Component_Proc" scope="page" />
<%--
	/*
		Type 별로 return 되는 json Data값 다양	
			멥핑된 전성분 목록만 요청 시 : 1
			피부타입별 적합도 요청 시 : 2
			좋은성분 주의 성분 요청 시 : 3
			cp id 별 배합 목적 return : 4
			CM이 등록한 전체 전성분 목록 요청 시 : 5
			
			멥핑된 성분관련 전체 리턴 요청 시 : ALL (1 + 2 + 3)
			멥핑된 성분관련 전체 리턴 요청 시 : ALL_T (5 + 2 + 3)
	*/
--%>
<%
	JSONObject rtnJSONData = new JSONObject();

	//request.setCharacterEncoding("UTF-8");
	String strModelNo = ChkNull.chkStr(request.getParameter("modelno"), "");
	String strCaCode = ChkNull.chkStr(request.getParameter("cacode"), "");
	String strOpt = ChkNull.chkStr(request.getParameter("opt"), "");
	String stCptids  = ChkNull.chkStr(request.getParameter("cpids"), "");
	String stTitleText  = ChkNull.chkStr(request.getParameter("titletext"), "");
	String strErrorMsg = "";
	String strErrorCode = "";
	
	if (!strOpt.isEmpty()) {
		int intModelNo = !strModelNo.isEmpty() ? Integer.parseInt(strModelNo) : 0;
		if (!strCaCode.isEmpty() && strCaCode.length() > 4) {
			strCaCode = strCaCode.substring(0, 4);
		}
		Component_Proc edData = new Component_Proc();
		
		//rtnJSONData = edProc.getItem(edData);
		if ("ALL".equals(strOpt) || "ALL_T".equals(strOpt)) {
			if (strModelNo.isEmpty()) {
				strErrorMsg = "modelno";
				strErrorCode = "1001";
			} else if (strCaCode.isEmpty()) {
				strErrorMsg = "cacode";
				strErrorCode = "1002";
			} else {
				rtnJSONData = edData.getCompDatas(intModelNo, strCaCode, strOpt);
			}
		// 전성분 return method
		} else if ("1".equals(strOpt)) {
			if (strModelNo.isEmpty()) {
				strErrorMsg = "modelno";
				strErrorCode = "1001";
			} else {
				rtnJSONData = edData.getAllComponent(intModelNo);
			}
		// 피부별적합도 return method
		} else if ("2".equals(strOpt)) {
			if (strModelNo.isEmpty()) {
				strErrorMsg = "modelno";
				strErrorCode = "1001";
			} else if (strCaCode.isEmpty()) {
				strErrorMsg = "cacode";
				strErrorCode = "1002";
			} else {
				rtnJSONData = edData.getCptSkinGoodness(intModelNo, strCaCode);
			}
		// 좋은성분 및 주의 성분 return method
		} else if ("3".equals(strOpt)) {
			if (strModelNo.isEmpty()) {
				strErrorMsg = "modelno";
				strErrorCode = "1001";
			} else if (strCaCode.isEmpty()) {
				strErrorMsg = "cacode";
				strErrorCode = "1002";
			} else {
				rtnJSONData = edData.getCptHarmfulLessCnt(intModelNo, strCaCode);
			}
		// cpcId별 성분 설명 레이어 데이터 return method
		} else if ("4".equals(strOpt)) {
			if (stCptids.isEmpty()) {
				strErrorMsg = "cpids";
				strErrorCode = "1003";
			} else if (strCaCode.isEmpty()) {
				strErrorMsg = "cacode";
				strErrorCode = "1002";
			} else {
				rtnJSONData = edData.getComponentPurposeList(stCptids, strCaCode);
				rtnJSONData.put("com_title", stTitleText);
			}
		} else if ("5".equals(strOpt)) {
			if (strModelNo.isEmpty()) {
				strErrorMsg = "modelno";
				strErrorCode = "1001";
			} else {
				rtnJSONData = edData.getAllComponentText(intModelNo);
				rtnJSONData.put("com_title", stTitleText);
			}
		} else if("6".equals(strOpt)){
			if (stCptids.isEmpty()) {
				strErrorMsg = "cpids";
				strErrorCode = "1003";
			} else if (strCaCode.isEmpty()) {
				strErrorMsg = "cacode";
				strErrorCode = "1002";
			} else if (strModelNo.isEmpty()) {
				strErrorMsg = "modelno";
				strErrorCode = "1001";
			}else {
				JSONArray rtnJSONArray = new JSONArray();
				JSONObject rtnJSONObj= new JSONObject();
				String[] arrCptname = stCptids.split(",");
				String strCptname = "";
				for(int i=0;i<arrCptname.length;i++){
					strCptname = arrCptname[i].replaceAll(" ","");

					rtnJSONObj = edData.getAllComponentPurposeList(strCptname, strCaCode,intModelNo);
					rtnJSONArray.put(rtnJSONObj);
				}
				
				rtnJSONData.put("Allcomponent_list", rtnJSONArray);
			}
		}
		
		if (strErrorMsg.isEmpty()) {
			rtnJSONData.put("resultmsg", "success");
			rtnJSONData.put("resultcode", "1000");
		}
		
	} else {
		strErrorMsg = "opt";
		strErrorCode = "1004";
	}
	
	if (!strErrorMsg.isEmpty()) {
		rtnJSONData.put("resultmsg", "Empty is " + strErrorMsg + "!!");
		rtnJSONData.put("resultcode", strErrorCode);
	}

	out.print(rtnJSONData);
%>