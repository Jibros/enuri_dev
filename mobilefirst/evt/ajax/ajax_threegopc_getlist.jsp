<%@page import="com.enuri.util.image.ImageUtil_lsv"%>
<%@page import="com.enuri.bean.main.Goods_Proc"%>
<%@page import="com.enuri.bean.main.Goods_Data"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.enuri.bean.enuripc.Enuripc_Event_T_Proc"%>
<%@ page import="org.json.*"%>
<%@ page import="com.enuri.util.common.ChkNull"%>
<%@ page import="org.apache.commons.lang3.StringUtils"%>
<%@ page import="java.util.*" %>
<%
	int intAdsNo = ChkNull.chkInt(request.getParameter("adsno"), 0);
	
	Enuripc_Event_T_Proc event = new Enuripc_Event_T_Proc();
	JSONObject jobject = new JSONObject();
	JSONArray jarray = new JSONArray ();
	
	if(intAdsNo > 0){
		jarray = event.getThreegopcList(intAdsNo);
		if(jarray.length() > 0){
			for(int i = 0; i < jarray.length(); i++){
				int intModelNo = 0;
				JSONArray shopJarray = new JSONArray();
				JSONObject parseJobject = new JSONObject();
				
				parseJobject = jarray.getJSONObject(i);
				intModelNo = parseJobject.getInt("modelno");
				
				Goods_Data goods_data = new Goods_Proc().Goods_Detailmulti_One(intModelNo, "Detailmulti");
				String strVIPImageUrl = ImageUtil_lsv.getVIPImageSrc(goods_data);
				
				shopJarray = event.getThreegopcShopList(intModelNo);
				parseJobject.put("shopList", shopJarray);
				parseJobject.put("img", strVIPImageUrl);
			}
			jobject.put("success", true);
			jobject.put("data", jarray);
		}else{
			jobject.put("success", false);
			jobject.put("msg", "fail");
		}
	}else{
		jobject.put("success", false);
		jobject.put("msg", "invalid Parameter");
	}
	out.println(jobject.toString());
	

%>
