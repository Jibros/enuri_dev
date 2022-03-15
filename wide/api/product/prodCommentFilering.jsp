<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.util.common.JsonResponse"%>
<%@ page import="com.enuri.bean.main.Vip_Comment_Filtering_Proc"%>
<%@ page import="com.enuri.bean.main.Vip_Comment_Filtering_Data"%>
<jsp:useBean id="Vip_Comment_Filtering_Proc" class="com.enuri.bean.main.Vip_Comment_Filtering_Proc" scope="page" />
<jsp:useBean id="Vip_Comment_Filtering_Data" class="com.enuri.bean.main.Vip_Comment_Filtering_Data" scope="page" />
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>

<%
	
	if(!CvtStr.isNumeric(request.getParameter("modelno"))){
		return ;
	}

	String strCate = ChkNull.chkStr(request.getParameter("cate"));
	int intModelno = ChkNull.chkInt(request.getParameter("modelno"));

	Vip_Comment_Filtering_Data[] vip_comment_filtering_data = null;
	JSONObject rtnJSONObject = new JSONObject();
	JSONArray rtnJSONArray = new JSONArray();
  	JsonResponse ret = null;
	if(intModelno > 0){
		if(strCate.length() >= 4){
			strCate = strCate.substring(0,4);
			vip_comment_filtering_data = Vip_Comment_Filtering_Proc.Vip_Comment_Filtering_Subject(intModelno, strCate);
		}
		if (vip_comment_filtering_data != null){
			for(int i=0; i<vip_comment_filtering_data.length; i++) {
				JSONObject tmpObject = new JSONObject();
				tmpObject.put("word_code",vip_comment_filtering_data[i].getAssess_word_code());
				tmpObject.put("word_name",vip_comment_filtering_data[i].getAssess_word_name());
				tmpObject.put("word_cnt",vip_comment_filtering_data[i].getCnt());
				rtnJSONArray.put(tmpObject);
			}
			rtnJSONObject.put("bbsFilterList",rtnJSONArray);
			ret = new JsonResponse(true).setData(rtnJSONObject);
		}else{
			ret = new JsonResponse(false).setData(rtnJSONObject);
		}
	}else {
		ret = new JsonResponse(false).setData(rtnJSONObject);
	}
	out.println(ret.toString());
%>
