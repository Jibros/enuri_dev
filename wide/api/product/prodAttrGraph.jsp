
<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ page import="com.enuri.util.common.JsonResponse"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Attribute_Proc"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%
	if(!CvtStr.isNumeric(request.getParameter("modelno"))){
		return ;
	}
	Goods_Attribute_Proc proc = new Goods_Attribute_Proc();
	JsonResponse ret = null;
	String strModelno = ChkNull.chkStr(request.getParameter("modelno"),"");
	String strCate = ChkNull.chkStr(request.getParameter("cate"),"");
	String strAttrid = "";

	if(strCate.length()>0){
		if(strCate.substring(0,4).equals("1201")) strAttrid = "123660,211331";
		else if(strCate.substring(0,4).equals("1202")) strAttrid ="133553,205023";
		int cnt = 0;
		String[] strAttrIdAry = strAttrid.split(",");
		JSONObject jSONObject = new JSONObject();

		if(!(strModelno.equals("") || strAttrid.equals(""))){
			jSONObject = proc.getGoodsAttrGraph(strModelno, strAttrid);
		}

		if(jSONObject.has("list")) cnt = jSONObject.getJSONArray("list").length();

		ret = new JsonResponse(true).setData(jSONObject).setTotal(cnt);
		out.println(ret);
	}
%>

