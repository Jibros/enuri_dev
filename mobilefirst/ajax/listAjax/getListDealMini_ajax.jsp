<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.main.deal.Deal_Category_Proc" %>
<%
String strCate = ConfigManager.RequestStr(request,"cate","14");
String strType = "";
if (request.getRequestURL().indexOf("dev.enuri.com") > -1){
	//strType = "D";
}
Deal_Category_Proc deal_category_proc = new Deal_Category_Proc();
out.print(deal_category_proc.getCategoryDealGoods_mobile_str_sony(strCate,strType));
//out.print(deal_category_proc.getCategoryDealGoods_mobile_str(strCate,strType));

%> 