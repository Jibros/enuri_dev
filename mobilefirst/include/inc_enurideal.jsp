<%@page import="org.json.JSONException"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.main.deal.CrazyDeal_Proc"%>
<%
	String referer = ChkNull.chkStr(request.getHeader("referer")).trim();			//	레퍼러 체크
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID
	System.out.println("crazydeal referer : " + referer);
	System.out.println("crazydeal userId : " + userId);
	if (referer.indexOf("enuri.com") < 0) {
		return;
	}
	int intSeq = ChkNull.chkInt(request.getParameter("seq"),0);
	boolean vReturn = false;
	CrazyDeal_Proc crazyDeal_Proc = new CrazyDeal_Proc();
	
	if(intSeq > 0){
		vReturn = crazyDeal_Proc.upd_CrazyDeal_soldout(intSeq);
	}
	if(vReturn)		urlGo("http://27.122.133.180:8080/mobilefirst/api/crazy_deal_ctu_send.jsp");
%>
<%!
public void urlGo(String strUrl) {
	
	try {
		BufferedReader br = new BufferedReader(new InputStreamReader((new URL(strUrl)).openConnection().getInputStream(),"UTF-8"));
		StringBuilder sbJson = new StringBuilder();
		String strLine = "";
		while ((strLine = br.readLine()) != null)	sbJson.append(strLine);
		br.close();
	} catch (Exception e) {
		System.out.println("********* error ************:"+e);
	}
}
%>
{"resultMsg":<%=vReturn%>}