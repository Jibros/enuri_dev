<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.include.RandomMain"%>
<jsp:useBean id="RandomMain" class="com.enuri.include.RandomMain" scope="page" />
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc" scope="page" />
<%@ page import="com.enuri.bean.main.Advertiser_Data"%>
<%@ page import="com.enuri.bean.main.Advertiser_Proc"%>
<jsp:useBean id="Advertiser_Proc" class="com.enuri.bean.main.Advertiser_Proc"  />
<%
	String ENURI_COM_SSL = "https://m.enuri.com:442";

	String serverName = request.getServerName();
	if(serverName.indexOf("stagedev.enuri.com")>-1 || serverName.indexOf("100.100.100.151")>-1 || serverName.indexOf("dev.enuri.com")>-1) {
		ENURI_COM_SSL = "http://"+serverName;
	}

//ssl
String cs_tel = ChkNull.chkStr(request.getParameter("cs_tel"));
int[] iT = RandomMain.getRandomValueNoDupe(10);
String cs_no = iT[0]+""+iT[1]+""+iT[2]+""+iT[3]+""+iT[4];
String strMsg = "[에누리] 인증번호["+cs_no+"]를 입력해 주세요.";
int iCont_cnt = ChkNull.chkInt(cb.GetCookie("MEMJOIN_SELF_CONF","CONF_CNT"));

if(iCont_cnt>=100){
%>
<script language='JavaScript'>
parent.showInputInfoSendHpAuth("인증번호 전송은 1일 10회로 제한됩니다. 내일 다시 이용해주세요.", 1);

parent.CmdSpinHide();

</script>
<%
	return;
}
HttpSession ttsession = request.getSession(true);
ttsession.setMaxInactiveInterval(60*5);
ttsession.setAttribute("MEMJOIN_SELF_CONF", cs_no);
ttsession.setAttribute("MEMJOIN_SELF_CONF_FAILCNT", "0");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<%
if(cs_tel.equals("")){ 
}else{
	//기존회원테이블에 확인.
	boolean isUsedPhone = false;
	boolean isErrorFlag = false;
	String cs_tel1 = "";
	String cs_tel2 = "";
	String cs_tel3 = "";
	if(cs_tel.length()==11) {
		cs_tel1 = cs_tel.substring(0,3);
		cs_tel2 = cs_tel.substring(3,7);
		cs_tel3 = cs_tel.substring(7,11);
	} else {
		//if(cs_tel1.length()==10) {
		try {
			cs_tel1 = cs_tel.substring(0,3);
			cs_tel2 = cs_tel.substring(3,6);
			cs_tel3 = cs_tel.substring(6,10);
		} catch(Exception e) {
			isErrorFlag = true;
		}
		//}
	}
	isUsedPhone = Members_Proc.getDataCertifyPhone(cs_tel1, cs_tel2, cs_tel3, "");

	if(isErrorFlag) {
%>
<script language='JavaScript'>
parent.showInputInfoSendHpAuth("잘못된 전화번호입니다. 숫자만 정확히 입력해 주세요.", 1);
parent.document.getElementById("sendHp").focus();

parent.CmdSpinHide();

</script>
<%
	} else if(isUsedPhone) {
%>
<script language='JavaScript'>
//parent.showInputInfoSendHpAuth("이미 등록된 전화번호입니다.<br>다른 번호를 입력하세요.", 1);
//parent.document.getElementById("sendHp").value("이미 등록된 전화번호입니다.<br>다른 번호를 입력하세요.");

parent.jShowInputInfoSendHpAuth("이미 등록된 전화번호입니다. 다른 번호를 입력하세요.");

parent.CmdSpinHide();


</script>
<%
	} else {
		iCont_cnt++;
		cb.SetCookie("MEMJOIN_SELF_CONF","CONF_CNT",""+iCont_cnt);
		cb.SetCookieExpire("MEMJOIN_SELF_CONF", 3600*24);
		cb.responseAddCookie(response);
%>
<form name="hpCert" action="http://toll.surem.com/message/direct_call_sms_return_post.asp" method="post" accept-charset="euc-kr">
	<input type="hidden" name="member" value="1">
	<input type="hidden" name="usercode" value="enuritest">
	<input type="hidden" name="deptcode" value="7F-WIJ-ZG">
	<input type="hidden" name="group_name" value="<%=cs_tel%>">
	<input type="hidden" name="to_message" value="<%=strMsg%>">
	<input type="hidden" name="from_num1" value="02">
	<input type="hidden" name="from_num2" value="6354">
	<input type="hidden" name="from_num3" value="3601">
	<input type="hidden" name="rurl" value="<%=ENURI_COM_SSL%>/mobilefirst/ajax/login/hpAuthProc_ajax.jsp">
</form>
<script language='JavaScript'>
document.charset = "euc-kr";
var obj = document.hpCert;
obj.submit();
parent.CmdSpinHide();

</script>
<%
	}
}
%>
</body>
</html>
