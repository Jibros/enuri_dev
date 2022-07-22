<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.util.http.ShortUrl"%>
<%@ page import="java.util.Random"%>
<%@ page import="com.surem.Mobile_TextMessage_Proc"%>
<%@page import="org.json.*"%>
<jsp:useBean id="RandomMain" class="com.enuri.include.RandomMain" scope="page" />
<%

String strPhoneNum = ChkNull.chkStr(request.getParameter("phoneno"), "");
String strMsg = ChkNull.chkStr(request.getParameter("strMsg"),"");
String cookieName = ChkNull.chkStr(request.getParameter("cookiename"),"MEMJOIN_SELF_CONF");
String referer = ChkNull.chkStr(request.getHeader("referer"));

if(referer.indexOf("enuri.com") < 0 ){

	response.sendRedirect("/");
	return;

}else{

	JSONObject jSONObject = new JSONObject();

	if(strMsg.equals("")){
		 strMsg = "";
		 strMsg += "[에누리 가격비교] \n";
		 strMsg += "앱 전용 쇼핑 혜택! \n";
		 strMsg += "앱 설치하고 e머니를 다양한 e쿠폰으로 교환하세요! \n";
		 strMsg += "▶ APP 설치하기 : http://goo.gl/O8CUnn \n";
	}else{
		strMsg = "";
		strMsg += "[에누리 가격비교] \n";
		strMsg += "앱 전용 EVENT! \n";
		strMsg += "앱 설치하고 참여하세요! \n";
		strMsg += "▶ APP 설치하기 : http://goo.gl/O8CUnn \n";
	}

	if(strMsg.equals("") || strPhoneNum.equals("")){

		jSONObject.put("result","N");

	}else{
		//int iCont_cnt = ChkNull.chkInt(cb.GetCookie("MEMJOIN_SELF_CONF","CONF_CNT"));
		int iCont_cnt = ChkNull.chkInt(cb.GetCookie(cookieName,"CONF_CNT"));

		if(iCont_cnt > 10){
			//10번 이상 참여
			jSONObject.put("result","T");

		}else{

			strPhoneNum =  strPhoneNum.replaceAll("-", "");

			Mobile_TextMessage_Proc TextMessage_Proc = new Mobile_TextMessage_Proc();
			boolean result = TextMessage_Proc.sendTextMessage("", strPhoneNum, strMsg);

			if(result){

				iCont_cnt++;
				cb.SetCookie("MEMJOIN_SELF_CONF","CONF_CNT",""+iCont_cnt);
				cb.SetCookieExpire("MEMJOIN_SELF_CONF", 3600*24);
				cb.responseAddCookie(response);

				//문자 전송 성공
				jSONObject.put("result","S");

			}else{
				//문자 전송 실패
				jSONObject.put("result","N");
			}

		}
	}
	out.println(jSONObject.toString());
}
%>
