<%@page import="com.enuri.util.common.ConfigManager"%>
<%@page import="com.enuri.bean.main.Main_SuggestGoods_Proc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="org.json.*"%>
<%
String strDcd = ConfigManager.RequestStr(request, "dcd", "0");					// [상품] 0:전체, 1:모델
String strCate = ConfigManager.RequestStr(request, "cate_cd", "");				// [카테고리]
String strStartDate = ConfigManager.RequestStr(request, "start_date", "0");	// [날짜] 시작일
String strEndDate = ConfigManager.RequestStr(request, "end_date", "0");		// [날짜] 종료일

JSONObject rtnJsonObj = new JSONObject();
Main_SuggestGoods_Proc msgp = new Main_SuggestGoods_Proc();

// procType=1 : 카테고리 목록 읽어오기
String strAdult = "1";

//JSONArray jsonArr = msgp.getCommentPopGoods(strAdult);
JSONArray jsonArr = msgp.getCommentScatePopGoods(strAdult);
	
out.println(jsonArr.toString());
%>
