<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.bean.wide.Wide_Prod_Proc"%>
<%@ page import="com.enuri.util.common.JsonResponse"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>

<%

	if(!CvtStr.isNumeric(request.getParameter("modelno"))){
		return ;
	}

	String strCate = ChkNull.chkStr(request.getParameter("cate"));
	String strModelno = ChkNull.chkStr(request.getParameter("modelno"));
	String strViewType = ChkNull.chkStr(request.getParameter("viewtype"));
	String strModelnm = ChkNull.chkStr(request.getParameter("modelnm"));
	String strFactory = ChkNull.chkStr(request.getParameter("factory"));
	String strBrand = ChkNull.chkStr(request.getParameter("brand"));
	String strServerName = request.getServerName();
	boolean bManFlag = false;

	if(strServerName.indexOf("stagedev.enuri.com") >=0) {
		bManFlag = false;
	}else if(strServerName.indexOf("dev.enuri.com") >=0 || strServerName.indexOf("my.enuri.com") >=0 || strServerName.indexOf("localhost") >=0) {
		bManFlag = true;
	}
	Wide_Prod_Proc wideProdProc = new Wide_Prod_Proc();

	JSONArray rtnJSONArray = new JSONArray();
	JsonResponse ret = null;
	JSONArray caution_info_All_data = new JSONArray();
	JSONArray caution_info_content_data = new JSONArray();
	JSONArray caution_info_imgmap_data = new JSONArray();
	if((strCate.length()>0 || strModelno.length()>0)){
		for(int i = 1; i < 3; i++){
			JSONObject tmpJSONObject = new JSONObject();
			strViewType = Integer.toString(i);
			caution_info_All_data = wideProdProc.getCautionInfoView(bManFlag, strCate, strModelnm, strFactory, strBrand, strModelno, strViewType);
			String caution_nos = "";
			String content_type = "";
			if(caution_info_All_data.length()> 0){
				for(int x=0;x<caution_info_All_data.length();x++){
					if(x>0) caution_nos+=",";
					caution_nos += caution_info_All_data.getJSONObject(x).getInt("seq_no");
				}
				tmpJSONObject = caution_info_All_data.getJSONObject(0);
				tmpJSONObject.put("imgmap_list",wideProdProc.getImgMap(tmpJSONObject.getInt("seq_no")));
				tmpJSONObject.put("content_list",wideProdProc.getCaution_Info_Content_List(bManFlag, caution_nos));

				rtnJSONArray.put(tmpJSONObject);
			}
		}
		ret = new JsonResponse(true).setData(rtnJSONArray).setTotal(rtnJSONArray.length());
	}else{
		ret = new JsonResponse(false).setData(rtnJSONArray);
	}
	out.println(ret.toString());
%>
