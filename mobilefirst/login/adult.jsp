<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.net.*"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
	String strApp = ChkNull.chkStr(request.getParameter("app"),"");	 //	Y일때 앱
	long cTime = System.currentTimeMillis();
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddkk");
	String sdt = dayTime.format(new Date(cTime));//진짜시간
    int intSdt = Integer.parseInt(sdt);
    boolean uplus_show = false;
    if(intSdt>=2017032114 && intSdt <2017032204){
        uplus_show = true;
    }
%>

<%@ page language="java" import="Kisinfo.Check.CPClient"%>
<%@ page language="java" import="Kisinfo.Check.IPIN2Client"%>
<%@ include file="/join/checkPlus_Conf_2010.jsp"%>
<%@ include file="/join/iPin_Conf_2010.jsp"%>
<%
	String ENURI_COM_SSL = "https://m.enuri.com";

	String serverName = request.getServerName();
	if(serverName.indexOf("stagedev.enuri.com")>-1 || serverName.indexOf("100.100.100.151")>-1 || serverName.indexOf("dev.enuri.com")>-1) {
		ENURI_COM_SSL = "https://"+serverName;
	}

	String backUrl = ChkNull.chkStr(request.getParameter("backUrl"), "");

	String userid = cb.GetCookie("MEM_INFO", "USER_ID");
	String strAdult = cb.GetCookie("MEM_INFO", "ADULT"); //성인여부 (0:미성년자, 1:성인, 2:판단불가-판매자 또는 주민번호 없이 가입)
	//out.println("userid="+userid);


/** 본인인증 모듈 =================================================================================**/
	CPClient kisCrypt = new CPClient();
	CPClient kisCrypt_pwd = new CPClient();
	String sSiteCode = strCheckConf_code;		// NICE로부터 부여받은 사이트 코드
	String sSitePassword = strCheckConf_pwd;		// NICE로부터 부여받은 사이트 패스워드
	String sRequestNumber = "";    // 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
	sRequestNumber = kisCrypt.getRequestNO(sSiteCode);
	String sAuthType = "";      	// 없으면 기본 선택화면, X: 공인인증서, M: 핸드폰, C: 신용카드

	HttpSession ttsession = request.getSession(true);
	ttsession.setAttribute("REQ_SEQ", sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.

	// CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
	String sReturnUrl 	= ENURI_COM_SSL+"/mobilefirst/ajax/login/Adult_Checkplus.jsp?re=s&backUrl="+backUrl; // 성공시 이동될 URL
	String sErrorUrl 	= ENURI_COM_SSL+"/mobilefirst/ajax/login/Adult_Checkplus.jsp?re=f&backUrl="+backUrl; // 실패시 이동될 URL
	//String sReturnUrl 	= ConfigManager.ENURI_COM_SSL+"/login/Adult_Checkplus.jsp?re=s"; // 성공시 이동될 URL
	//String sErrorUrl 	= ConfigManager.ENURI_COM_SSL+"/login/Adult_Checkplus.jsp?re=f"; // 실패시 이동될 URL
	//String sReturnUrl 	= "http://m.enuri.com/login/Adult_Checkplus.jsp?re=s&linkType=m"; // 성공시 이동될 URL
	//String sErrorUrl 	= "http://m.enuri.com/login/Adult_Checkplus.jsp?re=f&linkType=m"; // 실패시 이동될 URL

	// 입력될 plain 데이타를 만든다.
	String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
	                    "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
	                    "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
	                    "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
	                    "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl;
	String sMessage = "";
	String sEncData = "";

	int iReturn = kisCrypt.fnEncode(sSiteCode, sSitePassword, sPlainData);

	if( iReturn == 0 ){
	    sEncData = kisCrypt.getCipherData();
	}else if( iReturn == -1){
	    sMessage = "암호화 시스템 에러입니다.";
	}else if( iReturn == -2){
	    sMessage = "암호화 처리오류입니다.";
	}else if( iReturn == -3){
	    sMessage = "암호화 데이터 오류입니다.";
	}else if( iReturn == -9){
	    sMessage = "입력 데이터 오류입니다.";
	}else{
	    sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
	}
/** 본인인증 모듈 끝 =================================================================================**/
/** 아이핀 인증 모듈 =================================================================================**/
	IPIN2Client pClient = new IPIN2Client();
	String sSiteCode_ip	= strIpinConf_code;		// 가상주민번호서비스 고객사이트 구분코드 (한국신용평가정보에서 발급한 사이트 코드)
	String sSitePw		= strIpinConf_pwd;		// 가상주민번호서비스 고객사이트 비밀번호 (한국신용평가정보에서 발급한 사이트 비밀번호)
	String sCPRequest 	= pClient.getRequestNO(sSiteCode_ip);

	ttsession.setAttribute("CPREQUEST", sCPRequest);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.

	String sEncData_ipin			= "";			// 암호화 된 데이타
	String sRtnMsg					= "";			// 처리결과 메세지
	String sRtnMsg_pwd				= "";			// 처리결과 메세지
	String sReturnURL				= ENURI_COM_SSL+"/login/Adult_iPin.jsp";

	int iRtn = pClient.fnRequest(sSiteCode_ip, sSitePw, sCPRequest, sReturnURL);

	if (iRtn == 0){
		sEncData_ipin = pClient.getCipherData();
	} else if (iRtn == -1 || iRtn == -2){
		sRtnMsg = "암호화 모듈 오류입니다.";
	} else if (iRtn == -9){
		sRtnMsg = "입력 데이터 오류입니다.";
	} else{
		sRtnMsg = "알수 없는 에러 입니다. iReturn : " + iRtn;
	}
/** 아이핀 인증 모듈 끝 ===============================================================================**/
Cookie[] carr = request.getCookies();
String strAppyn = "";
String strVerios = "";
String strVerand = "";
String strAd_id = "";
int intVerios = 0;
int intVerand = 0;

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
    for(int i=0;i<carr.length;i++){
        if(carr[i].getName().equals("adid")){
            strAd_id = carr[i].getValue();
            break;
        }
    }
} catch(Exception e) {
}
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

if(!strVerios.equals("")){
	intVerios = Integer.parseInt(strVerios.replace(".",""));
}

if(!strVerand.equals("")){
	intVerand = Integer.parseInt(strVerand.replace(".",""));
}
boolean blTopbar_show = true;

if(strAppyn.equals("Y")){
	if(i_Log == 5940){
		if(intVerand >= 320){
			blTopbar_show = false;
		}
	}else if(i_Log == 5939){
        if(intVerios >= 320){
            blTopbar_show = false;
        }
	}
}
/* if(i_Log == 5939){
	String requestQueryString = request.getQueryString();
	if(requestQueryString.length()>0){
		if(requestQueryString.indexOf("freetoken=login_title") > -1 ){
			requestQueryString = requestQueryString.replace("freetoken=login_title", "freetoken=outlink");
			response.sendRedirect("/mobilefirst/login/adult.jsp?"+requestQueryString);
			return ;
		}
	}
} */
%>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=yes, target-densitydpi=medium-dpi" name="viewport">
<%@include file="/mobilefirst/include/common.html"%>
<%@ include file="/mobilefirst/login/login_check.jsp"%>
<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
</head>
<body>
<!--
<div id="adultInfo">
	<div class="titleImage"><img src="<%=IMG_ENURI_COM%>/images/mobile2/login/tx_adult.png"></div>
	<div class="titleText">
		<span>본 정보 내용은 청소년 유해 매체물로서 정보통신망 이용촉진 및 정보보호 등에 관한 법률 및 청소년 보호법의 규정에 의해 만 19세 미만의 청소년이 이용할 수 없습니다.</span>
	</div>
</div>
 -->
<%if(userid.length()>0) {%>
<!--
<div id="authSelect">
	<div class="title"><span>아래 방법 중 선택하여 실명인증을 진행하세요</span></div>
	<div class="buttons">
		<img id="selfBtnImg" src="<%=IMG_ENURI_COM%>/images/mobile2/login/btn_phone.png">
		<div><span>or</span></div>
		<img id="ipinBtnImg" src="<%=IMG_ENURI_COM%>/images/mobile2/login/btn_ipin.png">
	</div>
</div>
 -->
 	<div id="memberWrap">
<!--@@@  -->

		<div class="pageHead" id="pageHead" style="<%=(blTopbar_show)?"":"display:none" %>;">
			<h1>성인인증</h1>
			<a href="javascript:history.back(-1)" class="back">이전</a>
		</div>
		<div id="container" class="adultSection">
			<div class="adult">
				<p class="txt1">청소년 유해 키워드가 포함된<br /> 상품이므로 성인인증이 필요합니다.</p>
				<p>본 정보 내용은 청소년 유해 매체물로서 정보통신망 이용촉진 및 정보보호 등에 관한 법률 및 청소년 보호법의 규정에 의해 만 19세 미만의 청소년이 이용할 수 없습니다.</p>
				<p>아래 방법 중 선택하여 성인인증을 진행해주세요.</p>
			</div>
			<div class="btnWrap2">
				<a href="javascript:cmdCheckPlus()" class="btnTxt">휴대폰 인증</a>
				<a href="javascript:cmdPopIpin()" class="btnTxt">아이핀 인증</a>
			</div>

			<div class="uplus_stop" style="<%=(uplus_show)?"":"display:none" %>;">
				<h2>&#60;LGU+ 휴대폰인증 일시 중단 안내&#62;</h2>
				<ul>
					<li>서비스점검으로 LGU+ 본인인증서비스가 일시 중단됩니다. (타통신사는 가능!)</li>
					<li>중단시간:<br />2017.3.21(화) 오후2시~4시, 오후6시~11시<br />2017.3.22(수) 오전12시~4시</li>
				</ul>
			</div>
		</div>
	</div>
<%} else {%>
<!--
<div id="login">
	<div class="inputArea" style="">
		<div class="inputBox">
			<form name="loginForm" action="<%=ENURI_COM_SSL%>/mobilenew/ajax/login/loginProc_ajax.jsp" method="post" target="hFrame">
			<input type="hidden" name="autologin" value="">
			<input type="text" id="member_id" name="member_id" placeholder="아이디">
			<input type="password" id="member_pass" name="member_pass" placeholder="비밀번호">
			</form>
		</div>
		<div class="inputButton" style="float:right;">
			<img id="btn_login" src="<%=IMG_ENURI_COM%>/images/mobile2/login/btn_login.png">
		</div>
	</div>
	<div class="optionArea">
		<div class="autoLogin">
			<img src="<%=IMG_ENURI_COM%>/images/mobile2/login/btn_check_on.png">
			<span>자동로그인</span>
		</div>
		<div class="joinLink">
			<span>초간편 회원가입</span>
		</div>
	</div>
	<div class="loginAdultInfo">
		<span>※실명인증이 안되어 있으면 로그인 후 실명확인 절차가 진행됩니다.</span>
	</div>
</div>
 -->
 <div id="memberWrap">
		<div class="pageHead" style="<%=(blTopbar_show)?"":"display:none" %>;">
			<h1>성인인증 로그인</h1>
			<a href="javascript:history.back(-1)" class="back">이전</a>
		</div>
		<div id="container" class="adultSection">
			<div class="adult">
				<p class="txt1">청소년 유해 키워드가 포함된<br /> 상품이므로 성인인증이 필요합니다.</p>
				<p>본 정보 내용은 청소년 유해 매체물로서 정보통신망 이용촉진 및 정보보호 등에 관한 법률 및 청소년 보호법의 규정에 의해 만 19세 미만의 청소년이 이용할 수 없습니다.</p>
				<p>※ 실명인증을 하지 않았다면, 로그인 후 실명인증 절차가 진행됩니다.</p>
			</div>
			<fieldset class="loginField boxField">
				<legend>성인인증 로그인 입력</legend>
				<form name="loginForm" action="<%=ENURI_COM_SSL%>/mobilefirst/ajax/login/loginProc_ajax.jsp?chkurl=http://m.enuri.com" method="post" target="hFrame">
				<input type="hidden" name="autologin" value="">
				<!-- 140806 수정 -->
				<p class="inputBox">
					<input type="text" id="member_id" name="member_id" class="txt" title="아이디 입력" placeholder="아이디" />
					<span class="alerTxt"></span>
				</p>
				<p class="inputBox">
					<input type="password" id="member_pass" name="member_pass" class="txt" title="비밀번호 입력" placeholder="비밀번호"/>
					<span class="alerTxt"></span>
				</p>
				<!-- //140806 수정 -->
				<div class="utilSection">
					<p class="left"><label><input type="checkbox" /> 자동 로그인</label></p>
				</div>
				<p class="btnWrap"><a href="#" class="btnType3">로그인</a></p>
				<div class="lineBox">
					<p class="joinTxt">에누리닷컴 회원이 아니세요? <a href="javascript:goJoin()">회원가입</a></p>
				</div>
				</form>
			</fieldset>
		</div>
	</div>
<%}%>
<form name="form_chk" method="post">
<input type="hidden" name="m" value="checkplusSerivce"><!-- 필수 데이타로, 누락하시면 안됩니다. -->
<input type="hidden" name="EncodeData" value="<%=sEncData%>"><!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
<!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
	 해당 파라미터는 추가하실 수 없습니다. -->
<input type="hidden" name="param_r1" value="<%=sRequestNumber%>">
<input type="hidden" name="param_r2" value="">
<input type="hidden" name="param_r3" value="">
</form>
<form name="form_ipin" method="post" target="aList">
<input type="hidden" name="m" value="pubmain">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
<input type="hidden" name="enc_data" value="<%=sEncData_ipin%>">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
<!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
	 해당 파라미터는 추가하실 수 없습니다. -->
<input type="hidden" name="param_r1" value="<%=sCPRequest%>">
<input type="hidden" name="param_r2" value="">
<input type="hidden" name="param_r3" value="">
</form>
<!-- 성인 인증 필요 정보 모음 -->
<input type="hidden" id="iReturnInput" value="<%=iReturn%>">
<input type="hidden" id="sMessageInput" value="<%=sMessage%>">
<input type="hidden" id="iRtnInput" value="<%=iRtn%>">
<input type="hidden" id="sRtnMsgInput" value="<%=sRtnMsg%>">

<iframe id="hFrame" name="hFrame" frameborder="0" style="margin:0px;padding:0px;height:0px;width:0px;" ></iframe>
<script type="text/javascript" src="/mobilefirst/js/login.js"></script>
<script language="JavaScript">
<!--
loginPageType = 3;

var backUrl = "<%=backUrl%>";
-->
</script>
</body>
</html>
<%@ include file="/mobilefirst/include/common_logger.html"%>
