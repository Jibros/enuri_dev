<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%@page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@page import="com.enuri.bean.knowbox.Members_Data"%>
<%@page import="com.enuri.bean.member.Login_Data"%>
<%@page import="com.enuri.bean.member.Login_Proc"%>
<%@page import="com.enuri.bean.member.AppleSignIn"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page import="com.enuri.bean.member.SnsType"%>

<%
	//애플 아이디를 에누리 아이디와 매칭 등록해준다. 애플토큰으로 유효성 검증 해야함!

	PDManager_Proc pdmanager = new PDManager_Proc();
	PDManager_PD_Data pdData = pdmanager.chkPD(request);

	JSONObject jsonObject = new JSONObject();

	String strAt1 = ChkNull.chkStr(request.getParameter("at"));		//앱에서 온 애플토큰
	String strAt2 = ""; 																	//웹에서 체크한 유효한 애플토큰
	String strAppid = "";
 	String strR_code = "";
 	String strR_msg = "";

	if (pdData != null && pdData.isDataApple()) { 							 					//앱에서 넘어오는 pd 데이터 체크
		Sns_Login snsLogin = new Sns_Login();
		AppleSignIn appleLogin = new AppleSignIn();

		String strAppleid = pdData.getAppleId();														//앱에서 넘어온 애플아이디
		String strEnuri = pdData.getEnuri_id();														//앱에서 넘어온 에누리아이디
		String strAppleEnuri = snsLogin.getSnsEnuriId(strAppleid, SnsType.APPLE);  //앱에서 넘어온 애플아이디로 회원디비에서 에누리 아이디 가져온다
		String authId = (String) session.getAttribute("authId"); //애플 유효성 검사 후 넘어온 appleId

// 		System.out.println("<br>******************************requestSetApple.jsp***************************************");
// 		System.out.println("<br>authId=="+authId);
// 		System.out.println("<br>strAppleid=="+strAppleid);
		//if(!strAt1.equals("") && !strAt2.equals("") && strAt1.equals(strAt2) && !strEnuri.equals("")){		//유효성 체크
		if(authId != null && authId.equals(strAppleid)){
			if(strAppleEnuri.equals("")){		//애플아이디에 등록된 에누리 아이디가 없을때 등록해준다.
				boolean bAppleid =  new AppleSignIn().Apple_Ins(strAppleid, strEnuri, "A");

			    if(bAppleid){
					strR_code = "100";
					strR_msg = "애플아이디와 연동되었습니다.";
				}else{
					strR_code = "201";
					strR_msg = "APPLEID 등록에 실패했습니다.";
				}
			}else{
				strR_code = "202";
				strR_msg = "APPLEID 등록에 실패했습니다.";
			}
		}else{
			strR_code = "203";
			strR_msg = "APPLEID 등록에 실패했습니다.";
		}
	}else{
		strR_code = "200";
		strR_msg = "APPLEID 등록에 실패했습니다.";
	}

	jsonObject.put("code", strR_code);
	jsonObject.put("message", strR_msg);

	out.println(jsonObject.toString());
%>