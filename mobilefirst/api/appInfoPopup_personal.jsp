<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_T1_Data"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Popup_Personal"%>
<%
	String strID = "";
	PDManager_Proc pdmanager = new PDManager_Proc();
	PDManager_T1_Data t1Data = pdmanager.getT1(request);
	if (t1Data != null)
		strID = t1Data.getStrT1_enuriid();
	String app_type = ConfigManager.RequestStr(request, "app_type", "N");
	String strversion = ConfigManager.RequestStr(request, "version", "0.0.0");
	int version = 0;
	if (strversion.length() >= 5) {
		try {
			version = Integer.parseInt(strversion.substring(0, 1)) * 100
					+ Integer.parseInt(strversion.substring(2, 3)) * 10
					+ Integer.parseInt(strversion.substring(4, 5));
		} catch (Exception e) {
		}
	}

	//strID = "an0116";
	if (strID.equals("") || strID.length() <= 0) {
		out.print("{}");
		return;
	}

	Mobile_Popup_Personal.Builder builder = new Mobile_Popup_Personal().getEnuriReward08(strID);
	//Mobile_Popup_Personal.Builder builder = new Mobile_Popup_Personal().getEnuriReward08_test("");
	
	/* a000151
a000151
a000151
a01s01
a01s01
a0a0a7
a1000
a1116124o
a119818
a123ing
a123ing
a13866196
a13866196 */
	if (builder != null) {
		//샘플
		////////////////타이틀 없음, 본문 텍스트, 본문 버튼, 하루보지않기
		//builder.setPopUpTxtDesc(
		//		"<b>회원님,</b><br><b><font color='#4b7eff'>적립가능한 'e머니'가 있습니다.</font></b><br>잊지 마시고 꼭 기간내 적립 받으세요!")
		//		.setPopupTxtDescButton("<b>지금 적립 받기</b>", "#4b7eff", "http://m.daum.net")
		//		.setPopUpNoShow("하루보지않기", 1);
		//---------------
		////////////////타이틀 없음, 본문 텍스트, 본문 버튼, 닫기
		//builder.setPopUpTxtDesc(
		//		"<b>회원님,</b><br><b><font color='#4b7eff'>적립가능한 'e머니'가 있습니다.</font></b><br>잊지 마시고 꼭 기간내 적립 받으세요!")
		//		.setPopupTxtDescButton("<b>지금 적립 받기</b>", "#4b7eff", "http://m.daum.net");

		//---------------
		////////////////타이틀 , 본문 텍스트, 본문 버튼, 닫기
		//builder.setPopUpTxtTitle("<b>e머니 적립 안내</b>", "#81a9db")
		//		.setPopUpTxtDesc(
		//				"<b>회원님,</b><br><b><font color='#4b7eff'>적립가능한 'e머니'가 있습니다.</font></b><br>잊지 마시고 꼭 기간내 적립 받으세요!")
		//		.setPopupTxtDescButton("<b>지금 적립 받기</b>", "#4b7eff", "http://m.daum.net");

		//---------------
		////////////////타이틀/본문/본문버튼/일주일보지않기
		if (app_type.equals("A"))

			builder.setPopUpTxtTitle("<b>e머니 적립 안내</b>", "#81a9db")
					.setPopUpTxtDesc(
							"<b>회원님,</b><br><b><font color='#4b7eff'>적립가능한 'e머니'가 있습니다.</font></b><br>잊지 마시고 꼭 기간내 적립 받으세요!")
					.setPopupTxtDescButton("<b> 지금 적립 받기 </b>", "#4b7eff",
							"http://m.enuri.com/my/my_emoney_m.jsp?tab=7&freetoken=emoney")
					.setPopupNewLink("http://m.enuri.com/my/my_emoney_m.jsp?tab=7&freetoken=emoney")
					.setPopUpNoShow("오늘하루보지않기", 1);
		else
			builder.setPopUpTxtTitle("e머니 적립 안내", "#81a9db")
					.setPopUpTxtDesc(
							"<div align='center'><font size='4.99em' ><b>회원님,</b><br><b><font color='#4b7eff'>적립가능한 'e머니'가 있습니다.</font></b><br>잊지 마시고 꼭 기간내 적립 받으세요!</font></div>")
					//.setPopUpTxtDesc(
						//	"<font size='5' ><b>회원님,</b><br><b><font color='#4b7eff'>적립가능한 'e머니'가 있습니다.</font></b><br>잊지 마시고 꼭 기간내 적립 받으세요!</font>")
					.setPopupTxtDescButton("지금 적립 받기", "#4b7eff",
							"http://m.enuri.com/my/my_emoney_m.jsp?tab=7&freetoken=emoney")
					.setPopupNewLink("http://m.enuri.com/my/my_emoney_m.jsp?tab=7&freetoken=emoney")
					.setPopUpNoShow("오늘하루보지않기", 1);
		//---------------
		JSONObject obj = builder.Create();
		if (obj != null) {
			obj.put("start", "201804110000");
			obj.put("end", "205004302300");
			out.print(obj);
		} else
			out.print("{}");

	} else
		out.print("{}");
%>
<%!%>