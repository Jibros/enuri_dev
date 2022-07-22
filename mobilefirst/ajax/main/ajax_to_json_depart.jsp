<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@include file="/mobiledepart/include/common.jsp"%>
<%@page import="com.enuri.bean.main.Mobile_Main_Proc"%>
<%@page import="com.enuri.bean.main.depart.Depart_Goods_Data"%>
<%@page import="com.enuri.bean.main.depart.Depart_Goods_Proc"%>
<%@page import="com.enuri.bean.mobile.depart.Mobile_Depart_Pricelist_Proc"%>
<%@page import="com.enuri.bean.mobile.depart.Mobile_Depart_Pricelist_Data"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%

/*
메인 백화점 상품 노출 
최저가 2개 노출
*/
	String modelno = StringUtils.defaultString(request.getParameter("modelno"),"0");
	int modelnmInt = Integer.parseInt(modelno);
		
	//Depart_Goods_Proc depart_Goods_Proc = new Depart_Goods_Proc();
	//Depart_Goods_Data[] minshop_list = depart_Goods_Proc.getMinDeptShop(modelnmInt,5);
	
	Mobile_Depart_Pricelist_Proc mobile_Depart_Pricelist_Proc  = new Mobile_Depart_Pricelist_Proc();   
	Mobile_Depart_Pricelist_Data[] minshop_list = mobile_Depart_Pricelist_Proc.getDetailShopList(modelnmInt,1,10,1);
	
	JSONArray jSONArray = new JSONArray(); 
	
	for(int i=0 ; i<minshop_list.length  ; i++){
		
		Mobile_Depart_Pricelist_Data mobile_Depart_Pricelist_Data = new Mobile_Depart_Pricelist_Data();
		JSONObject jSONObject = new JSONObject();
		  
		jSONObject.put("price",minshop_list[i].getPrice());
		jSONObject.put("shop_code",minshop_list[i].getShop_code());
		jSONObject.put("dept_code",minshop_list[i].getDept_code());
		jSONObject.put("shop_name", getShopName(_shop_code,minshop_list[i].getShop_code()+""));
		
		jSONArray.put(jSONObject);

	}
	
	out.println(jSONArray.toString());
%>