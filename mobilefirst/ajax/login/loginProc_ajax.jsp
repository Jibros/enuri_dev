<%@page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%@page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<jsp:useBean id="Members_Data" class="com.enuri.bean.knowbox.Members_Data"  />
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc"  />
<%@ page import="com.enuri.bean.log.Sdu_login_Data"%>
<%@ page import="com.enuri.bean.log.Sdu_login_Proc"%>
<jsp:useBean id="Sdu_login_Data" class="com.enuri.bean.log.Sdu_login_Data"  />
<jsp:useBean id="Sdu_login_Proc" class="com.enuri.bean.log.Sdu_login_Proc"  />
<%@ page import="com.enuri.bean.main.auto.Auto_Dealer_Data"%>
<%@ page import="com.enuri.bean.main.auto.Auto_Dealer_Proc"%>
<jsp:useBean id="Auto_Dealer_Data" class="com.enuri.bean.main.auto.Auto_Dealer_Data" scope="page" />
<jsp:useBean id="Auto_Dealer_Proc" class="com.enuri.bean.main.auto.Auto_Dealer_Proc" scope="page" />
<%@ page import="com.enuri.bean.notification.Mobile_Push_Login_Proc"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<%@page import="com.enuri.bean.member.SnsType"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<jsp:useBean id="Seed_Proc" class="com.enuri.util.seed.Seed_Proc"  />
<%
/**
이 파일은 SSL 서버에 업로드해야 합니다.
*/
String sendScript = "";
String cookieSetId = "";

String strID           = ConfigManager.RequestStr(request, "member_id","");
String strPass         = ConfigManager.RequestStr(request, "member_pass","");
String strCmd          = ConfigManager.RequestStr(request, "cmd","");
String strAutoLogin    = ConfigManager.RequestStr(request, "autologin","");
String strReturnType   = ConfigManager.RequestStr(request, "returntype",""); // 로그인 결과값 리턴 타입
String strUserGroup    = ConfigManager.RequestStr(request, "usergroup","");
String strRtnUrl 	   = ConfigManager.RequestStr(request, "rtnurl",""); //sdul메뉴 자동로그인에서 사용
String strApp = ChkNull.chkStr(request.getParameter("app"),"");

String strHttp = "";
String errFlag = "";
String strBlnChk  = "";
String strBReturn = "";
boolean bReturn   = false;

strHttp = ConfigManager.ENURI_COM;

String strIsPassCaps = Members_Proc.getUserIsPassCaps(strID);
if(!strIsPassCaps.equals("1")){ //대문자 사용가능이 아니면 소문자로 변경
	//strPass = strPass.toLowerCase();
}

Cookie[] carr = request.getCookies();
String strAppyn = "";
String strVerios = "";
String strVerand = "";
int intVerios = 0;
int intVerand = 0;
String strAppid = "";

try {
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("appYN")){
	    	strAppyn = carr[i].getValue();
	    	//break;
	    }
	}
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("verios")){
	    	strVerios = carr[i].getValue();
	    	break;
	    }
	}
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("verand")){
	    	strVerand = carr[i].getValue();
	    	break;
	    }
	}
} catch(Exception e) {
}

if(!strVerios.equals("")){
	strVerios = strVerios.substring(0,5);
	intVerios = Integer.parseInt(strVerios.replace(".",""));
}

if(!strVerand.equals("")){
	intVerand = Integer.parseInt(strVerand.replace(".",""));
}

Members_Data members_data = new Members_Data();

// 앱 로그인시 pd 데이터에서 값 추출
PDManager_Proc pdmanager = new PDManager_Proc();
PDManager_PD_Data pdData = pdmanager.chkPD(request);
if (pdData != null && pdData.isDataLogin() && !"".equals(pdData.getTimes())) {
	Calendar pdTime = Calendar.getInstance();
	pdTime.setTime(new SimpleDateFormat("yyyyMMddHHmmss", Locale.KOREA).parse(pdData.getTimes()));
	Calendar now = Calendar.getInstance();

	if (now.getTimeInMillis() - pdTime.getTimeInMillis() <= 3600000) {
		// 앱 pd 데이터가 1시간 이내 데이터일 때
		strID = pdData.getEnuri_id();	// member_id
		strPass = pdData.getEnuri_pw();	// member_pass
		strAutoLogin = "Y";
	}
	if(strAppid != null && strAppid.length() > 4){
		strAppid = strAppid.substring(1,5);
	}
	strAppid = pdData.getAppid();
}

//SNS 로그인
Sns_Login snsLogin = new Sns_Login();
String snsUsrId = ChkNull.chkStr(request.getParameter("sns_usr_id")); // SNS ID
SnsType snsDcd = snsLogin.getSnsType(ChkNull.chkStr(request.getParameter("sns_dcd"))); // SNS 타입
String access_token = ChkNull.chkStr(request.getParameter("access_token")); // SNS 타입
if (snsDcd != SnsType.NONE) {
	if (!"".equals(access_token)) {	// 앱 로그인
		String infoId = "";
		if (snsDcd == SnsType.APPLE) {	//애플 로그인
			if (snsLogin.isSnsMember(snsUsrId, snsDcd)){  //애플아이디가 등록되어 있고 && token이 유효하고(토큰유효성체크)
				members_data = snsLogin.Login_Check(snsUsrId, snsDcd);
				strID = members_data.getUserid();
				strAutoLogin = "Y";
			} else {
				strID = "";
			}
		}else{
			if (snsDcd == SnsType.NAVER) {  //네이버, 카카오 로그인
				infoId = snsLogin.getUserInfoNaver(access_token);	// token 으로 sns id 가져오기
			} else if (snsDcd == SnsType.KAKAO) {
				infoId = snsLogin.getUserInfoKakao(access_token);	// token 으로 sns id 가져오기
			}
			if (snsUsrId.equals(infoId) && snsLogin.isSnsMember(snsUsrId, snsDcd)) {
				members_data = snsLogin.Login_Check(snsUsrId, snsDcd);
				strID = members_data.getUserid();
				strAutoLogin = "Y";
			} else {
				strID = "";
			}
		}
	} else {	// 웹 로그인
		String storedToken = "";
		Object tokenObj = session.getAttribute("access_token");
		if (tokenObj != null) {
			storedToken = tokenObj.toString();
			if (strPass.equals(storedToken)) {	// access token 검증
				snsUsrId = "";
				if (snsDcd == SnsType.NAVER) {
					snsUsrId = snsLogin.getUserInfoNaver(storedToken);	// token 으로 sns id 가져오기
				} else if (snsDcd == SnsType.KAKAO) {
					snsUsrId = snsLogin.getUserInfoKakao(storedToken);	// token 으로 sns id 가져오기
				}
				if (strID.equals(snsUsrId) && snsLogin.isSnsMember(snsUsrId, snsDcd)) {
					members_data = snsLogin.Login_Check(snsUsrId, snsDcd);
					strID = members_data.getUserid();
				} else {
					strID = "";
				}
			} else {
				strID = "";
			}
		} else {
			strID = "";
		}
	}
} else {
	members_data = Members_Proc.Login_Check( strID , strPass ); //사용자 정보
}

String errCode      = ChkNull.chkStr(members_data.getErrCode());
String userid       = ChkNull.chkStr(members_data.getUserid());
String name         = ChkNull.chkStr(members_data.getName());
String nickname     = ChkNull.chkStr(members_data.getNickname());
String service_flag = ChkNull.chkStr(members_data.getService_flag());
String m_group      = ChkNull.chkStr(members_data.getM_group());
String start_date   = ChkNull.chkStr(members_data.getStart_date());
String classname    = ChkNull.chkStr(members_data.getClassname());
String ap_yn        = ChkNull.chkStr(members_data.getAp_yn());
String yyyymmdd		= ChkNull.chkStr(members_data.getYyyymmdd());
String chkAdult = ""; //성인여부 (0:미성년자, 1:성인, 2:판단불가-판매자 또는 주민번호 없이 가입)
int nowYear = ChkNull.chkInt(DateStr.nowStr().substring(0,4));
int birthYear = 0;
if(!yyyymmdd.equals("") && yyyymmdd.length()>=4){
	birthYear = ChkNull.chkInt(yyyymmdd.substring(0,4));
	if(nowYear-birthYear>=19){
		chkAdult = "1";
	}else{
		chkAdult = "0";
	}
}else{
	chkAdult = "2";
}
if(m_group.equals("1") || m_group.equals("2") || m_group.equals("6")){ //운영자는 성인처리
	chkAdult = "1";
}
//System.out.println("yyyymmdd : " + yyyymmdd);
//System.out.println("chkAdult : " + chkAdult);

String sTmpID= cb.GetCookie("MYINFO","TMP_ID");

/*
System.out.println(">>Proc_ssl");
System.out.println(">>strID : " + strID);
System.out.println(">>strPass : " + strPass);
System.out.println(">>strCmd : " + strCmd);
System.out.println(">>strAutoLogin : " + strAutoLogin);
System.out.println(">>strReturnType : " + strReturnType);
System.out.println(">>errCode : " + errCode);
*/

if(errCode.trim().length() == 0 ){ //정상
	StringBuffer strBAuto = new StringBuffer();
	cookieSetId = userid;

	if(strCmd.equals("reconfirm") && !cb.GetCookie("MEM_INFO","USER_ID").equals("")) {
		//자동로그인중 회원정보 수정할때 비번 재확인
		cb.SetCookie("MEM_INFO", "LOGIN_RECONFIRM", "Y");
		cb.responseAddCookie(response);
	} else {
		//로그인처리
	    if(m_group.equals("3") || m_group.equals("5")){
	         cb.SetCookie(  "SDU", "SHOP_ID", userid);
	         cb.SetCookie(  "SDU", "SHOP_NO", Integer.toString(members_data.getShopNo()));
	         cb.SetCookie(  "SDU", "SHOP_CODE", members_data.getShopVcode());
			 cb.SetCookie(  "SDU", "SHOP_NAME", members_data.getShopName());
			 cb.SetCookie(  "SDU", "SHOP_OPT", members_data.getShopOpt());
			 cb.SetCookie(  "SDU", "SHOP_AUTH", members_data.getShopAuth());
			 cb.SetCookie(  "SDU", "SHOP_GRADE", members_data.getShopGrade());
			 cb.SetCookie(  "SDU", "SHOP_MAX_UNIT", members_data.getShopUnit());
			 cb.SetCookie(  "SDU", "SHOP_COUPON", members_data.getShopCoupon());
			 cb.SetCookie(  "SDU", "SHOP_SDU_CLASS", members_data.getShopSduClass());
			 cb.SetCookieExpire("SDU",-1);
		}
	    cb.SetCookie(  "MEM_INFO", "USER_ID", userid);
	    cb.SetCookie(  "MEM_INFO", "USER_NICK", nickname);
	    cb.SetCookie(  "MEM_INFO", "USER_GROUP", m_group);
	    cb.SetCookie(  "MEM_INFO", "USER_BROWSERNO", "1");
	    cb.SetCookie(  "MEM_INFO", "USER_REGDATE", sTmpID);
	    cb.SetCookie(  "MEM_INFO", "AP_YN", ap_yn);
	    cb.SetCookie("MEM_INFO", "SNSTYPE", snsDcd.getStrValue());	// K/N/""
	    if(strAutoLogin.equals("Y")){ //자동로그인
	    	cb.SetCookie("MEM_INFO", "LOGIN_RECONFIRM", "Y");
	    }else{
	    	cb.SetCookie("MEM_INFO", "LOGIN_RECONFIRM", "");
	    }
	    cb.SetCookie(  "MEM_INFO", "ADULT", chkAdult);
	    cb.SetCookieExpire("MEM_INFO",-1);
	    cb.responseAddCookie(response);

	    cb.setCookie_One("LSTATUS","Y");
	    cb.SetCookieExpire("LSTATUS",-1);
	    cb.responseAddCookie(response);

	    /**********20201124 에누리 자동차 쿠키생성**********/
		strBAuto.append("USER_ID="+URLEncoder.encode(Seed_Proc.EnPass_Seed(userid), "UTF-8"));
		strBAuto.append("&USER_NICK="+URLEncoder.encode(nickname, "UTF-8"));
		strBAuto.append("&SNSTYPE="+URLEncoder.encode(snsDcd.getStrValue(), "UTF-8"));

		{
			Cookie c = new Cookie("MEM_INFO_AUTO", strBAuto.toString());
			c.setPath("/");
			c.setDomain(".enuri.com");
			response.addCookie(c);
		}

		//앱에서만 MEM_INFO(.enuri.com) 추가 후 사용, 웹도 변경예정
		{
			Cookie c = new Cookie("MEM_INFO", strBAuto.toString());
			c.setPath("/");
			c.setDomain(".enuri.com");
			response.addCookie(c);
		}
		/**********20201124 에누리 자동차 쿠키생성**********/

		//if(!m_group.equals("3") && !m_group.equals("5")){
		    if(strAutoLogin.equals("Y")) { //자동로그인 체크하고 로그인하는 경우
				cb.SetCookie("MYINFO","AUTOLOGIN","Y");
				cb.SetCookie("MYINFO","AUTOLOGINID",userid);
				cb.SetCookie("MYINFO","LOGINPWFAIL",""); //5회오류시 숫자입력
				cb.SetCookieExpire("MYINFO", 3600*24*30);
				cb.responseAddCookie(response);
		    } else {
				cb.SetCookie("MYINFO","AUTOLOGIN","");
				cb.SetCookie("MYINFO","AUTOLOGINID","");
				cb.SetCookie("MYINFO","LOGINPWFAIL",""); //5회오류시 숫자입력
				cb.SetCookieExpire("MYINFO", 3600*24*30);
				cb.responseAddCookie(response);
		    }
		//}

		//os 구분값 추가
	    int i_Log = 5941;
	    int i_Log_pad = 0;
	    if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0){
	    	i_Log = 5940;
	    }else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0){
	    	i_Log = 5939;
	    }else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0){
	    	i_Log = 5939;
	    	i_Log_pad = 1;
	    }else{
	    	i_Log = 5941;
	    }

	    String strOs_type = "MWA";

	    if(i_Log == 5939){
	    	strOs_type = "MWI";
	    }

	    int intAutologin = 0;
	    if(strAutoLogin.equals("Y")){
	    	intAutologin = 1;
	    }

	    bReturn = Members_Proc.Login_Log_Ins_type_autologin(userid, sTmpID ,ConfigManager.szConnectIp(request), strOs_type, intAutologin);

	    if( bReturn ) {
	   		strBReturn = "true";
	    }

	    if( Members_Proc.getLengthPassword(userid)<6){
	    	strBlnChk = "true";
	    }

		// 로그인 아이디 저장
		{
			Cookie c = new Cookie("DOMAIN_LOGIN_ID", Seed_Proc.EnPass_Seed(userid));
			c.setMaxAge(3600*24*30);
			c.setPath("/");
			c.setDomain(".enuri.com");
			response.addCookie(c);
		}

		// 로그아웃 플래그 초기화
		{
			Cookie c = new Cookie("DOMAIN_LOGOUT_YN", "N");
			c.setMaxAge(3600*24*30);
			c.setPath("/");
			c.setDomain(".enuri.com");
			response.addCookie(c);
		}

	}

	sendScript += "parent.goBackPage();";
	//sendScript += "parent.insertLog(9970);";
} else {
	if(errCode.equals("0")) {

		sendScript += "alert('ID 또는 비밀번호가 일치하지 않습니다.');";
		sendScript += "try {";
		sendScript += "	parent.document.loginForm.reset();";
		sendScript += "	parent.document.loginForm.member_id.focus();";
		sendScript += "} catch(e) {}";

	} else if(errCode.equals("1")) {
		if(strIsPassCaps.equals("1")) { //대소문자 모두 사용가능
			sendScript += "alert('ID 또는 비밀번호가 일치하지 않습니다.');";
			sendScript += "try {";
			sendScript += "	parent.document.loginForm.member_pass.value = '';";
			sendScript += "	parent.document.loginForm.member_pass.focus();";
			sendScript += "} catch(e) {}";
		}else{

			sendScript += "alert('ID 또는 비밀번호가 일치하지 않습니다.');";
			sendScript += "try {";
			sendScript += "	parent.document.loginForm.member_pass.value = '';";
			sendScript += "	parent.document.loginForm.member_pass.focus();";
			sendScript += "} catch(e) {}";

		}
	} else if(errCode.equals("01")) { //회원탈퇴상태

		sendScript += "alert('회원탈퇴 완료\\n현재 고객님께서는 탈퇴 상태 입니다.\\n회원 탈퇴 후 1주일 동안은 회원가입이 불가능 합니다.');";
		sendScript += "try {";
		sendScript += "	parent.document.loginForm.reset();";
		sendScript += "} catch(e) {}";

	} else if(errCode.equals("02")) { //강제탈퇴상태

		sendScript += "alert('회원탈퇴 완료\\n현재 고객님께서는 강제탈퇴 상태 입니다.\\n문의 : 02-6354-3601');";
		sendScript += "try {";
		sendScript += "	parent.document.loginForm.reset();";
		sendScript += "} catch(e) {}";

	} else if(errCode.equals("03")) { //이용정지상태

		sendScript += "alert('회원탈퇴 완료\\n현재 고객님께서는 이용정지 상태 입니다.\\n문의 : 02-6354-3601');";
		sendScript += "try {";
		sendScript += "	parent.document.loginForm.reset();";
		sendScript += "} catch(e) {}";

	} else if(errCode.equals("04")) {

		sendScript += "alert('해외거주자 삭제상태입니다.');";
		sendScript += "try {";
		sendScript += "	parent.document.loginForm.reset();";
		sendScript += "} catch(e) {}";

	} else if(errCode.equals("05")) {

		sendScript += "alert('임시 비밀번호가 발급된 상태이므로\nPC환경에서 비밀번호를 변경해 주세요.');";

	} else if(errCode.equals("06")) {

		sendScript += "alert('이용정지(ID도용) 상태입니다.');";
		sendScript += "try {";
		sendScript += "	parent.document.frmLogin.reset();";
		sendScript += "} catch(e) {}";

	} else if(errCode.equals("07")) {

		sendScript += "alert('해외거주자 가입신청 상태입니다.');";
		sendScript += "try {";
		sendScript += "	parent.document.frmLogin.reset();";
		sendScript += "} catch(e) {}";

	} else if(errCode.equals("08")) { //휴면계정

		sendScript += "top.restLayerShow('"+strID+"');";
		sendScript += "try {";
		sendScript += "	parent.document.frmLogin.reset();";
		sendScript += "} catch(e) {}";

	}
}

String thisDomain = "http://m.enuri.com";
String serverName = request.getServerName();
if(serverName.indexOf("stagedev.enuri.com")>-1 || serverName.indexOf("100.100.100.151")>-1 || serverName.indexOf("dev.enuri.com")>-1 || serverName.indexOf("my.enuri.com")>-1 ) {
	thisDomain = "";
}
%>
<form name="sendScriptForm" method="post" action="<%=thisDomain%>/mobilefirst/ajax/login/scriptExec.jsp">
<input type="hidden" name="sendScript" value="<%=sendScript%>">
</form>
<script language="JavaScript">
<!--
document.sendScriptForm.submit();
-->
</script>
