<%@page import="org.json.JSONObject"%>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.util.seed.Seed_Proc" %>
<%@ page import="java.text.*" %>
<%@ page import="com.enuri.util.mail.SendMail" %>
<%@ page import="com.enuri.bean.log.Log_main_Proc"%>
<%@ page import="com.enuri.bean.log.Log_main_Data"%>
<%@ page import="com.enuri.bean.member.Login_Data"%>
<%@ page import="com.enuri.bean.member.Login_Proc"%>
<%@ page import="com.enuri.bean.member.Login_Proc2"%>
<jsp:useBean id="Login_Data" class="com.enuri.bean.member.Login_Data"  />
<jsp:useBean id="Login_Proc" class="com.enuri.bean.member.Login_Proc"  />
<jsp:useBean id="Login_Proc2" class="com.enuri.bean.member.Login_Proc2"  />
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<jsp:useBean id="Seed_Proc" class="com.enuri.util.seed.Seed_Proc"/>

<%
/***************************************************
이 파일은 SSL 서버에 업로드해야 합니다.
***************************************************/
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy.MM.dd.");
String today = formatter.format(new java.util.Date());
Login_Data rtnValue = new Login_Data();
boolean authRtnValue = false;

String emptyUser = "입력한 정보에 해당하는 회원정보가 없습니다.";
String emptyCertUser = "본인인증에 실패하셨습니다.\n본인명의의 휴대폰이 맞는지 다시 확인해주세요.";
/* REQUEST */
//String strUserId = ConfigManager.RequestStr(request, "userId", "");
String strUserId = ChkNull.chkStr(request.getParameter("userId"),"");
String kind =  ChkNull.chkStr(request.getParameter("kind"),"");
String authType =  ChkNull.chkStr(request.getParameter("authType"),"");
String reqValue =  ChkNull.chkStr(request.getParameter("value"),"");

String strPhoneNum = "";
String strPhoneNum1 = "";
String strPhoneNum2 = "";
String strPhoneNum3 = "";
String strEmail = "";
String emailArr[] = {};
String strIdCheckValueInPw ="";
String strUserid ="";

Login_Proc lp = new Login_Proc();


out.println("{");
out.println("	\"getPhoneNEmailByIdCheckInPw\": [");
if(authType.equals("idCheck")){
	boolean bMyLock = Login_Proc2.getMyLockStatus(strUserId);
	
	if(bMyLock){
		out.println("{"); 
		out.println("	\"userid\"	 :\""+strUserid+"\", ");
		out.println("	\"idCheckValueInPw\"	 :\"3\" ");
		out.println("}");
	}else{	
		rtnValue = lp.getPhoneNEmailbyidCheck(strUserId, kind);
		if (rtnValue != null) {
			//System.out.println("loginReturnValue:"+rtnValue);
			if(rtnValue.getHp_tel1() != null){
				strPhoneNum1 = rtnValue.getHp_tel1();
			}
			if(rtnValue.getHp_tel2() != null && rtnValue.getHp_tel2().length()>0){
				strPhoneNum2 = rtnValue.getHp_tel2();
				strPhoneNum2 = strPhoneNum2.substring(0, 1) + "***";
			}
			if(rtnValue.getHp_tel3() != null && rtnValue.getHp_tel3().length()>0){
				strPhoneNum3 = rtnValue.getHp_tel3();
				strPhoneNum3 = "***"+strPhoneNum3.charAt(strPhoneNum3.length() - 1);
			}
			if(rtnValue.getM_email() != null && rtnValue.getM_email().length()>0){
				strEmail = rtnValue.getM_email();
			}
			if(rtnValue.getIdCheckResultInPw() != null){
				strIdCheckValueInPw = rtnValue.getIdCheckResultInPw();
			}
			if(rtnValue.getHp_tel1().length()>0){
				strPhoneNum = strPhoneNum1 + "-" + strPhoneNum2 + "-" + strPhoneNum3;
			}
			if(rtnValue.getM_email().length()>0){
				emailArr = strEmail.split("@");
				strEmail = emailArr[0].substring(0, 2) + "******@";
				strEmail = strEmail + emailArr[1].substring(0, 2) + "******.com";
			}
			if(rtnValue.getUserid().length()>0){
				strUserid = rtnValue.getUserid();
			}
			
			out.println("{");
			out.println("	\"userid\"	 :\""+strUserid+"\", ");
			out.println("	\"phoneNum\" :\""+strPhoneNum+"\", ");
			out.println("	\"phoneNum1\":\""+strPhoneNum1+"\", ");
			out.println("	\"phoneNum2\":\""+strPhoneNum2+"\", ");
			out.println("	\"phoneNum3\":\""+strPhoneNum3+"\", ");
			out.println("	\"email\"	 :\""+strEmail+"\", ");
			out.println("	\"idCheckValueInPw\":\""+strIdCheckValueInPw+"\"");
			out.println("}");
		}else{
			System.out.println("아이디로 회원정보 얻기 실패");
		}
	}
}else if(authType.equals("authCheck")){
	authRtnValue = lp.getResultIsEqualToPhoneEmail(strUserId, reqValue, kind);
	out.println("{");
	out.println("	\"returnValue\"	 :\""+authRtnValue+"\" ");
	out.println("}");
}

out.println("	]  ");	
out.println("}");
%>