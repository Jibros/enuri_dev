<%@ page contentType = "text/json;charset=utf-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="org.json.*" %>
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
	if(!CvtStr.isNumeric(request.getParameter("modelno"))){
		return ;
	}
	JSONObject rtnJSONData = new JSONObject();

	int intModelno = ChkNull.chkInt(request.getParameter("modelno"), 0);
	String strCategory = ChkNull.chkStr(request.getParameter("cate"), "");
	String strOpt = ChkNull.chkStr(request.getParameter("opt"), "");
	String stCptids  = ChkNull.chkStr(request.getParameter("cpids"), "");
	String stTitleText  = ChkNull.chkStr(request.getParameter("titletext"), "");
	String strErrorMsg = "";
	String strErrorCode = "";

	if (!strOpt.isEmpty()) {
		if (!strCategory.isEmpty() && strCategory.length() > 4) {
			strCategory = strCategory.substring(0, 4);
		}
		Component_Proc edData = new Component_Proc();

		if ("ALL_T".equals(strOpt)) {
			if (intModelno == 0) {
				strErrorMsg = "modelno";
				strErrorCode = "1001";
			} else if (strCategory.isEmpty()) {
				strErrorMsg = "cacode";
				strErrorCode = "1002";
			} else {
				rtnJSONData = edData.getCompDatas(intModelno, strCategory, strOpt);
			}
		// cpcId별 성분 설명 레이어 데이터 return method
		} else if ("4".equals(strOpt)) {
			if (stCptids.isEmpty()) {
				strErrorMsg = "cpids";
				strErrorCode = "1003";
			} else if (strCategory.isEmpty()) {
				strErrorMsg = "cacode";
				strErrorCode = "1002";
			} else {
				rtnJSONData = edData.getComponentPurposeList(stCptids, strCategory);
				rtnJSONData.put("com_title", stTitleText);
			}
		} else if ("5".equals(strOpt)) {
			if (intModelno == 0) {
				strErrorMsg = "modelno";
				strErrorCode = "1001";
			} else {
				rtnJSONData = edData.getAllComponentText(intModelno);
				rtnJSONData.put("com_title", stTitleText);
			}
		} else if("6".equals(strOpt)){
			if (stCptids.isEmpty()) {
				strErrorMsg = "cpids";
				strErrorCode = "1003";
			} else if (strCategory.isEmpty()) {
				strErrorMsg = "cacode";
				strErrorCode = "1002";
			} else if (intModelno == 0) {
				strErrorMsg = "modelno";
				strErrorCode = "1001";
			}else {
				JSONArray rtnJSONArray = new JSONArray();
				JSONObject rtnJSONObj= new JSONObject();
				String[] arrCptname = stCptids.split(",");
				String strCptname = "";
				for(int i=0;i<arrCptname.length;i++){
					strCptname = arrCptname[i].replaceAll(" ","");

					rtnJSONObj = edData.getAllComponentPurposeList(strCptname, strCategory,intModelno);
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