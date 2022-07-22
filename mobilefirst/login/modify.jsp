<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<jsp:useBean  id="Members_Data" class="com.enuri.bean.knowbox.Members_Data"  />
<jsp:useBean  id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc"  />
<%

if(1==1){
	response.sendRedirect("/mobilefirst/index.jsp");
	return;
}

	String ENURI_COM_SSL = "https://m.enuri.com:442";
	String serverName = request.getServerName();
	String strApp = ChkNull.chkStr(request.getParameter("app"),"");

	// 아이폰 새버전이 올라가면
	// 밑에 ios예외처리 한부분들 수정해야함
	if(serverName.indexOf("stagedev.enuri.com")>-1 || serverName.indexOf("100.100.100.151")>-1 || serverName.indexOf("dev.enuri.com")>-1) {
		ENURI_COM_SSL = "";
	}

	String backUrl = ChkNull.chkStr(request.getParameter("backUrl"), "");

	String userid = cb.GetCookie("MEM_INFO", "USER_ID");

	// 로그인을 하지 않았을 경우 처리
	if(userid==null || userid.length()==0) {
%>
<SCRIPT language="JavaScript">
<!--
alert("로그인하세요");
top.location.reload();
-->
</SCRIPT>
<%
		return;
	}

/*
1.[PSWD]
2.[NAME]
3.REGNO_P
4.ISNULL(M_EMAIL,'') M_EMAIL
5.TEL1_P
6.TEL2_P
7.TEL3_P
8.ZIP
9.M_JUSO_P
10.S_JUSO_P
11.NICKNAME
12.JOB
13.WEDDING_FLAG
14.ESCRO_FLAG
15.NEWS_FLAG
16.INOUT_FLAG
17.CETIFY
18.ISNULL(USERPOINT,0) USERPOINT
19.DBO.UDF_CLASSNAME(CLASS_CODE)
20.PIC_NAME
21.MY_INTRO
22.DBO.UDF_AVATA_NAME (ISNULL(AVATA_CODE,'001'))
23.DBO.UDF_MIL_NAME(ISNULL(AVATA_CODE,'001'))
24.ISNULL(CLASS_CODE,'A0')
25.TEL_FLAG
26.ISNULL(HP_TEL1_P,'') HP_TEL1_P
27.ISNULL(HP_TEL2_P,'') HP_TEL2_P
28.ISNULL(HP_TEL3_P,'') HP_TEL3_P
29.IS_PASS_CAPS
30.CI_KEY
*/
	String[] arrMemberInfo = Members_Proc.getData_One(userid);
%>
<html>
<head>
<title></title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width">
<%@include file="/mobilefirst/include/common.html"%>
</head>
<body>
<form name="modifyForm" method="post" autocomplete="off" action="<%=ENURI_COM_SSL%>/mobilefirstfirst/ajax/login/modifyProc_ajax.jsp?chkurl=http://m.enuri.com" style="margin:0px;">
<div id="modify">
	<div class="inputBox">
		<input type="text" name="name" id="name" maxlength="12" placeholder="이름" value="<%=arrMemberInfo[1]%>">
		<div class="inputBoxInfoName"><span></span></div>
		아이디 : <%=userid%><br>
		<input type="password" name="pass" id="pass" size="20" maxlength="12" placeholder="현재 비밀번호">
		<div class="inputBoxInfoPass"><span></span></div>
		<input type="password" name="pass1" id="pass1" size="20" maxlength="12" placeholder="새 비밀번호">
		<div class="inputBoxInfoPass"><span></span></div>
		<input type="password" name="pass2" id="pass2" size="20" maxlength="12" placeholder="새 비밀번호 확인">
		<div class="inputBoxInfoPass"><span></span></div>
	</div>
	<div class="sendHpAuth">
		<input type="text" name="sendHp" id="sendHp" placeholder="휴대폰 번호" value="<%=arrMemberInfo[4]%><%=arrMemberInfo[5]%><%=arrMemberInfo[6]%>">
		<img id="btn_sendImg" src="<%=IMG_ENURI_COM%>/images/mobile2/login/btn_send.png">
		<div class="authCompDiv" style="display:none"><img src="<%=IMG_ENURI_COM%>/images/mobile2/login/check_on.png">인증완료</div>
	</div>
	<div class="sendHpAuthInfo"><span></span></div>
	<div class="recvHpAuth">
		<input type="text" name="recvHp" id="recvHp" placeholder="인증번호">
		<img src="<%=IMG_ENURI_COM%>/images/mobile2/login/btn_ok.png">
	</div>
	<div class="recvHpAuthInfo"><span></span></div>
	<div>
		<span id="modifyBtn">수정</수정>
	</div>
</div>
</form>

<iframe id="hFrame" name="hFrame" frameborder="0" style="margin:0px;padding:0px;height:0px;width:0px;"></iframe>

<script type="text/javascript" src="/mobilenew/js/lib/jquery-2.1.1.min.js" charset="utf-8"></script>
<script type="text/javascript" src="/mobilefirst/js/login.js"></script>
<script language="JavaScript">
<!--
loginPageType = 4;

var backUrl = "<%=backUrl%>";
-->
</script>

<%//@ include file="/mobilefirst/renew/include/footer.jsp"%>

</body>
</html>
<%@ include file="/mobilefirst/include/common_logger.html"%>
