<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.main.Save_Goods_Proc"%>
{
<%
try {
	// ********************************************************************************
	// 찜 상품 개수 읽기 
	// ********************************************************************************
	int totalLength = 0;
	String strUserId = "";
	if(cb.GetCookie("MEM_INFO","USER_ID") != "") {
		Save_Goods_Proc save_goods_proc = new Save_Goods_Proc();

		strUserId = cb.GetCookie("MEM_INFO","USER_ID");
		totalLength = save_goods_proc.getSaveGoodCnt(strUserId, "MEMBER");
	}
	out.println("	\"myZzimGoodsCnt\":\""+totalLength+"\"");

} catch(Exception e) {
}
%>
}