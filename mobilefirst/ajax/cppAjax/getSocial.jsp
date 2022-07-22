<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Cpp_Proc"%>
<%
String strCate = ConfigManager.RequestStr(request,"cate","14");
String strType = "";

if (request.getRequestURL().indexOf("dev.enuri.com") > -1){
	strType = "D";
}

Cpp_Proc cpp_proc = new Cpp_Proc();
//out.print(cpp_proc.getCategoryDealGoods_mobile_str_sony(strCate,strType));
out.print(cpp_proc.getCategoryDealGoods_mobile_str(strCate,strType));

%>