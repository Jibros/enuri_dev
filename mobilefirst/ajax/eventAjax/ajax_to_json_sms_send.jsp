<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.include.RandomMain"%>
<jsp:useBean id="RandomMain" class="com.enuri.include.RandomMain" scope="page" />
<jsp:useBean id="mobile_Event_Proc" class="com.enuri.bean.mobile.Mobile_Event_Proc" scope="page" />
<%
	String ENURI_COM_SSL = "https://m.enuri.com:442";
	String type = ChkNull.chkStr(request.getParameter("type"));
	String username = ChkNull.chkStr(request.getParameter("username"));
	String giftNo = ChkNull.chkStr(request.getParameter("gift_no"));
	
	String serverName = request.getServerName();
	if(serverName.indexOf("stagedev.enuri.com")>-1 || serverName.indexOf("dev.enuri.com")>-1) {
		ENURI_COM_SSL = "http://"+serverName;
	}

//ssl
String cs_tel = ChkNull.chkStr(request.getParameter("cs_tel"));

GregorianCalendar gc = new GregorianCalendar();
SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss"); // 기본 데이타베이스 저장 타입
Date d = gc.getTime(); // Date -> util 패키지
String str = sf.format(d);

int[] iT = RandomMain.getRandomValueNoDupe(10);
String cs_no = "";
int iCont_cnt = ChkNull.chkInt(cb.GetCookie("MEMJOIN_SELF_CONF","CONF_CNT"));

for(int i = 0 ; i < 10 ; i++){
	cs_no = str.substring(6,8)+""+iT[0]+""+iT[1]+""+iT[2]+""+iT[3]+""+iT[4]+""+iT[5];
	if(mobile_Event_Proc.getCerkeyDuplicate(cs_no) == 0 ) break;
}

String strMsg  =  "[에누리가격비교] \n";
		strMsg += "교환번호 : "+cs_no+" \n";
		strMsg += "APP 설치하기 \n";
		strMsg += "http://m.enuri.com/short/5Axg7 \n";

if(iCont_cnt>=10){
%>
<script language='JavaScript'>
<%if("pw".equals(type)){%>
parent.alertMsg("인증번호 전송은 1일 10회로 제한됩니다. 내일 다시 이용해주세요.", 1);
<%}else{%> 
parent.alertMsg("인증번호 전송은 1일 10회로 제한됩니다. 내일 다시 이용해주세요.", 1);
<%}%>
</script>
<%
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<%
if(cs_tel.equals("")){ 
%>
<script language='JavaScript'>
parent.alertMsg("전화번호 등록을 다시해주세요");
</script>
<%
}else{
	
	int cnt = mobile_Event_Proc.getCerkeySend(cs_tel,username);
		
	if(cnt > 0) {
%>
	<script language='JavaScript'>
	parent.alertMsg("이미 참여 하신 번호 입니다.");
	</script>
<%	
	} else {
		iCont_cnt++;
		cb.SetCookie("MEMJOIN_SELF_CONF","CONF_CNT",""+iCont_cnt);
		cb.SetCookieExpire("MEMJOIN_SELF_CONF", 3600*24);
		cb.responseAddCookie(response);
		
		String ostype = "";
		
		if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0){
			ostype = "A";
		}else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0){
			ostype = "I";
		}else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0){
			ostype = "I";
		}else{
			ostype = "P";
		}
		mobile_Event_Proc.eventCerKeyInsert(cs_no,ostype, username, cs_tel, Integer.parseInt(giftNo), "","");
		
%>
<form name="hpCert" action="http://toll.surem.com/message/direct_call_sms_return_post.asp" method="post">
	<input type="hidden" name="member" value="1">
	<input type="hidden" name="usercode" value="enuritest">
	<input type="hidden" name="deptcode" value="7F-WIJ-ZG">
	<input type="hidden" name="group_name" value="<%=cs_tel%>">
	<input type="hidden" name="to_message" value="<%=strMsg%>">
	<input type="hidden" name="from_num1" value="02">
	<input type="hidden" name="from_num2" value="6354">
	<input type="hidden" name="from_num3" value="3601">
	<input type="hidden" name="rurl" value="<%=ENURI_COM_SSL%>/mobilefirst/ajax/login/hpAuthProc_ajax.jsp?type=+<%=type%>">
</form>
<script language='JavaScript'>
document.charset = "euc-kr";
var obj = document.hpCert;
obj.submit();

parent.alertMsg("인증번호가 전송되었습니다.");

</script>
<%
	}
}
%>
</body>
</html>