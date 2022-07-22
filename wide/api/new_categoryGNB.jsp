<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ page import="com.enuri.bean.wide.Lp_Header_Proc"%>
<%@ page import="org.json.simple.*"%>
<%
	/** Parameter Sets */
	String strParamCate = ConfigManager.RequestStr(request, "category", "");
	String strDevice = ConfigManager.RequestStr(request, "device", "pc"); //m
 	String strServer = ConfigManager.RequestStr(request, "server", "real");
 	String strMoveYN = ConfigManager.RequestStr(request, "moveYN", "N");
 	String strType = ConfigManager.RequestStr(request, "type", "lp");
 	int intGnbNo = ChkNull.chkInt(request.getParameter("gnbno"));
 	int intParamLevel = ChkNull.chkInt(request.getParameter("level"));
	/* Parameter Sets */
	
	/** Parameter Validation Check */
	JsonResponse ret = null;
	if(strParamCate.length()==0 && strMoveYN.equals("N")) {
		ret = new JsonResponse(false).setCode(10).setParam(request);
		out.print(ret);
		return;
	}
	/** // Parameter Validation Check */
	
	Lp_Header_Proc lp_header_proc = new Lp_Header_Proc();
	JSONObject resultObj = new JSONObject();
	boolean blDevFlag = strServer.equals("real") ? false : true;
	int intViewDcd = strDevice.equals("pc") ? 1 : 2;
	int intLevel = 0;
	
	try{

		JSONArray gnbListArray = new JSONArray();
		if (strMoveYN.equals("N")) {
			JSONArray cateArr = new JSONArray();
			JSONObject cateObj = new JSONObject();
			if (strParamCate.length() > 4 && strType.equals("vip")) {
				if(strParamCate.length() > 6) {
					cateArr.add(strParamCate);
					cateArr.add(strParamCate.substring(0, 6));
					cateArr.add(strParamCate.substring(0, 4));
				} else if (strParamCate.length() > 4) { 
					cateArr.add(strParamCate);
					cateArr.add(strParamCate.substring(0, 4));
				}
				cateObj = lp_header_proc.getVipItgGnbLevel(cateArr, blDevFlag, intViewDcd);
				intLevel = (int)cateObj.get("level");
				strParamCate = (String)cateObj.get("cate_cd");
			} else {
				intLevel = lp_header_proc.getItgGnbLevel(strParamCate, blDevFlag, intViewDcd);
			}
			
			gnbListArray = lp_header_proc.getItgCateNavList(strParamCate, blDevFlag, intLevel, intViewDcd);
		} else {
			if (intParamLevel == 0) gnbListArray = lp_header_proc.getItgMoveNavList_lv0(intGnbNo, blDevFlag, intViewDcd);
			else gnbListArray = lp_header_proc.getItgCateNavMove(intGnbNo, blDevFlag, intParamLevel, intViewDcd);
		}	

		//화면에서 depth 1씩 빼야함
		JSONObject depth0Obj = new JSONObject();
		JSONObject depth1Obj = new JSONObject();
		JSONObject depth2Obj = new JSONObject();
		JSONObject depth3Obj = new JSONObject();
		JSONObject depth4Obj = new JSONObject();
		
		JSONArray depth0List = new JSONArray();
		JSONArray depth1List = new JSONArray();
		JSONArray depth2List = new JSONArray();
		JSONArray depth3List = new JSONArray();
		JSONArray depth4List = new JSONArray();
		
		String strSelCateNm0 = "";
		String strSelCateNm1 = "";
		String strSelCateNm2 = "";
		String strSelCateNm3 = "";
		String strSelCateNm4 = "";
		
		for (int i = 0 ; i  < gnbListArray.size(); i ++) {
			JSONObject parseObj = (JSONObject)gnbListArray.get(i);
			int intArrLevel = (Integer)parseObj.get("g_level");
			String strArrCateCd = (String)parseObj.get("g_cate");
			String strArrCateNm = (String)parseObj.get("g_name");
			String strCateYN = (String)parseObj.get("cateYN");
			
			if (intArrLevel == 0) {
				if (strCateYN.equals("Y")) {
					strSelCateNm0 = strArrCateNm;
				}
				depth0List.add(parseObj);
			}else if (intArrLevel == 1){
				if (strCateYN.equals("Y")) {
					strSelCateNm1 = strArrCateNm;
				}
				depth1List.add(parseObj);
			} else if (intArrLevel == 2) {
				if (strCateYN.equals("Y")) {
					strSelCateNm2 = strArrCateNm;
				}
				depth2List.add(parseObj);
			} else if (intArrLevel == 3) {
				if (strCateYN.equals("Y")) {
					strSelCateNm3 = strArrCateNm;
				}
				depth3List.add(parseObj);
			} else if (intArrLevel == 4) {
				if (strCateYN.equals("Y")) {
					strSelCateNm4 = strArrCateNm;
				}
				depth4List.add(parseObj);
			}
		}
		
		depth0Obj.put("list", depth0List);
		depth1Obj.put("list", depth1List);
		depth2Obj.put("list", depth2List);
		depth3Obj.put("list", depth3List);
		depth4Obj.put("list", depth4List);
		
		depth0Obj.put("selCateNm", strSelCateNm0);
		depth1Obj.put("selCateNm", strSelCateNm1);
		depth2Obj.put("selCateNm", strSelCateNm2);
		depth3Obj.put("selCateNm", strSelCateNm3);
		depth4Obj.put("selCateNm", strSelCateNm4);

		resultObj.put("depth0", depth0Obj);
		resultObj.put("depth1", depth1Obj);
		resultObj.put("depth2", depth2Obj);
		resultObj.put("depth3", depth3Obj);
		resultObj.put("depth4", depth4Obj);

	}catch(Exception e){}
	
	ret = new JsonResponse(true).setData(resultObj);
	out.print ( ret );
%>