<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%@page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@page import="org.json.JSONObject"%>
<%@page import="io.jsonwebtoken.Claims"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@page import="com.enuri.bean.knowbox.Members_Data"%>
<%@page import="com.enuri.bean.member.Login_Data"%>
<%@page import="com.enuri.bean.member.Login_Proc"%>
<%@page import="com.enuri.bean.member.AppleSignIn"%>
<%@page import="com.enuri.bean.member.Apple_Jwt"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page import="com.enuri.bean.member.SnsType"%>

<%
	PDManager_Proc pdmanager = new PDManager_Proc();
	PDManager_PD_Data pdData = pdmanager.chkPD(request);

	JSONObject jsonObject = new JSONObject();

	String strAc = ChkNull.chkStr(request.getParameter("ac")); //authorization_code
	String strAt = ChkNull.chkStr(request.getParameter("at")); //앱로그인 id_token
	String strAt2 = ""; //웹에서 체크한 유효한 애플토큰
	String strEmail = ""; //id_token 안에 들어있는 email
	String strAppid = "";
 	String strR_code = "";
 	String strR_msg = "";
	String strNextPage = "";
	String strAppleEnuri = "";
 	boolean snslogin = false;

 	//애플 아이디 연동 체크 api
 	if (pdData != null && pdData.isDataApple()) { //앱에서 넘어오는 pd 데이터 체크
		Sns_Login snsLogin = new Sns_Login();
		AppleSignIn appleLogin = new AppleSignIn();
		Apple_Jwt appleJwt = new Apple_Jwt();
		Claims claimsAll = appleJwt.decodeJwt(strAt,0);

		String strApple = pdData.getAppleId();			 //앱에서 넘어온 애플아이디
		String strEnuri = pdData.getEnuri_id();			 //앱에서 넘어온 에누리아이디
		String strAuthId = ""; //애플 유효성 검사 후 넘어온 appleId

		strEmail = String.valueOf(claimsAll.get("email"));

// 		System.out.println("<br>******************************requestApple.jsp***************************************");
// 		System.out.println("<br>claims=="+claimsAll);
// 		System.out.println("<br>email=="+strEmail);
// 		System.out.println("<br>strAc=="+strAc);
// 		System.out.println("<br>strAt=="+strAt);
// 		System.out.println("<br>strEnuri=="+strEnuri);
// 		System.out.println("<br>strAuthId=="+strAuthId);
// 		System.out.println("<br>strApple=="+strApple);


		strAppleEnuri = snsLogin.getSnsEnuriId(strApple, SnsType.APPLE);    //앱에서 넘어온 애플아이디로 회원디비에서 에누리 아이디 가져온다
// 			System.out.println("<br>strAppleEnuri=="+strAppleEnuri);

		if(strAppleEnuri.equals("")){
				strR_code = "100";
				strR_msg = "";
				strNextPage = "https://www.enuri.com/member/join/join.jsp";
		}else{
			strAuthId = appleLogin.Apple_auth(strAc); //애플 유효성 검사 후 넘어온 appleId

// 			System.out.println("<br>strAuthId2=="+strAuthId);

			if(strAuthId != null && strAuthId.length() > 0 && strAuthId.equals(strApple)){
				session.setAttribute("authId",strAuthId); //유효성 체크 된 id session 저장
				session.setMaxInactiveInterval(5*60); // session 5분간 유효

				strR_code = "200";
				strR_msg = "연동되어있음("+strAppleEnuri+")";
			}else{
				strR_code = "500";
				strR_msg = "토큰 유효하지 않음";
			}
		}
	}else{
		strR_code = "600";
		strR_msg = "pd 바르지 않음";
	}
	//out.println(strApple.toString());
	jsonObject.put("code", strR_code);
	jsonObject.put("message", strR_msg);
	jsonObject.put("userid", strAppleEnuri);
	jsonObject.put("email", strEmail);
	jsonObject.put("nextpage", strNextPage);

	out.println(jsonObject.toString());
%>