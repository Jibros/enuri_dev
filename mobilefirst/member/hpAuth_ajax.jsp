<%@page import="java.awt.Robot"%>
<%@page import="com.enuri.bean.bizm.Bizm_Data"%>
<%@ page import="com.enuri.bean.bizm.Bizm_Proc"%>
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
<jsp:useBean id="Bizm_Proc" class="com.enuri.bean.bizm.Bizm_Proc" />

<%@ page import="com.enuri.bean.member.Join_Data"%>
<%@ page import="com.enuri.bean.member.Join_Proc"%>
<jsp:useBean id="Join_Data" class="com.enuri.bean.member.Join_Data" />
<jsp:useBean id="Join_Proc" class="com.enuri.bean.member.Join_Proc" />

<%
	response.setHeader("P3P","CP='CAO PSA CONi OTR OUR DEM ONL'");
	String ENURI_COM_SSL = "https://m.enuri.com:442";
	String type = ChkNull.chkStr(request.getParameter("type"));

	String enuri_id = ChkNull.chkStr(request.getParameter("enuri_id"));
	
	String serverName = request.getRequestURL().toString();
	
	if(serverName.indexOf("stagedev.enuri.com")>-1 || serverName.indexOf("100.100.100.151")>-1 || serverName.indexOf("dev.enuri.com")>-1) {
		ENURI_COM_SSL = "http://"+serverName;
	}

//ssl
String cs_tel = ChkNull.chkStr(request.getParameter("cs_tel"));
int[] iT = RandomMain.getRandomValueNoDupe(10);
String cs_no = iT[0]+""+iT[1]+""+iT[2]+""+iT[3]+""+iT[4];
String strMsg = "[에누리] 인증번호["+cs_no+"]를 입력해 주세요.";
int iCont_cnt = ChkNull.chkInt(cb.GetCookie("MEMJOIN_SELF_CONF","CONF_CNT"));

if(iCont_cnt>=10){
%>
<script language='JavaScript'>
parent.showInputInfoSendHpAuth("인증번호 전송은 1일 10회로 제한됩니다. 내일 다시 이용해주세요.", 1);
</script>
<%
	return;
}else if(!isPhoneNumber(cs_tel) && !type.equals("pw") ){
%>
<script language='JavaScript'>
parent.showInputInfoSendHpAuth("인증번호를 받을 수 없는 전화번호 입니다.\n전화번호를 다시 확인해주세요.", 1);
</script>
<%
	return;
}

HttpSession ttsession = request.getSession(true);
ttsession.setMaxInactiveInterval(60*5);

ttsession.setAttribute("MEMJOIN_SELF_CONF", "");
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
		try {
			cs_tel1 = cs_tel.substring(0,3);
			cs_tel2 = cs_tel.substring(3,6);
			cs_tel3 = cs_tel.substring(6,10);
		} catch(Exception e) {
			isErrorFlag = true;
		}
	}
	
	
	// 데이터 세팅
 	Join_Data join_data_s = new Join_Data();
 	join_data_s.setTel1_p(cs_tel1);
 	join_data_s.setTel2_p(cs_tel2);
 	join_data_s.setTel3_p(cs_tel3);
 	join_data_s.setConf_ci_key("");
 	
 	
	// 탈퇴 후 7일 체크
 	int secede_count = 0;
 	secede_count = Join_Proc.secedeCheck(join_data_s);
 	
 	
 	%>
	<%-- <script>
	alert('<%=secede_count%>_aaaaa');
	alert('<%=cs_tel1%>_<%=cs_tel2%>_<%=cs_tel3%>');
	</script> --%>
	<%
	
 	
 	if(secede_count > 0){
 		%>
 		<script>
 		alert("탈퇴 후 7일 이후\n재인증이 가능합니다.");
 		
 		// 팝업창 닫기
 		self.opener = self;
 		window.close();
 		</script>
 		<%
 		return;
 	}
	
	
	// 전화번호 중복 체크
	isUsedPhone = Members_Proc.getDataCertifyPhone(cs_tel1, cs_tel2, cs_tel3, "");

	if(isErrorFlag) {
%>
<script language='JavaScript'>
parent.showInputInfoSendHpAuth("잘못된 전화번호입니다. 숫자만 정확히 입력해 주세요.", 1);
parent.document.getElementById("sendHp").focus();
</script>
<%
	} else if(isUsedPhone  && !"pw".equals(type)) {
%>
<script language='JavaScript'>
//parent.showInputInfoSendHpAuth("이미 등록된 전화번호입니다.<br>다른 번호를 입력하세요.", 1);
//parent.document.getElementById("sendHp").value("이미 등록된 전화번호입니다.<br>다른 번호를 입력하세요.");

parent.jShowInputInfoSendHpAuth("이미 등록된 전화번호입니다. 다른 번호를 입력하세요.");

</script>
<%
	} else {
		iCont_cnt++;
		cb.SetCookie("MEMJOIN_SELF_CONF","CONF_CNT",""+iCont_cnt);
		cb.SetCookieExpire("MEMJOIN_SELF_CONF", 3600*24);
		cb.responseAddCookie(response);
		
		// bizm용 전화번호. 01012345678 을 821012345678. 형식으로 가공. 국가번호(82:대한민국).
		String receiver_num = "";	// 
		receiver_num = "82" + cs_tel.substring(1, cs_tel.length());				
		//System.out.println("receiver_num: "+receiver_num);
		//System.out.println("cs_no: "+cs_no);
		
		
		/*
		// 현재 url 로 서버타입 판단.
		String nowUrl = request.getRequestURL().toString();
		//System.out.println("nowUrl: " + nowUrl);
		
		if( nowUrl.indexOf("my.enuri.com")>-1 || nowUrl.indexOf("stagedev.enuri.com")>-1 ){
			
		} else {
			
		}
		*/
		String serverType = "";
		serverType = "real";	// 알림톡 실제용
		//System.out.println("serverType: " + serverType);
		
		
		// 데이터 세팅
		Bizm_Data bizm_data = new Bizm_Data();
		bizm_data.setEnuri_id(enuri_id);
		bizm_data.setReceiver_num(receiver_num);
		bizm_data.setServerType(serverType);
		bizm_data.setAuthNum(cs_no);
		
		boolean InsertYN = false;
		
		// bizm 문자 전송 테이블에 INSERT.
		InsertYN = Bizm_Proc.insertBizmsg(bizm_data);
		
		
		String bizmResult = "FAIL";
		// 인서트에 성공했다면
		if(InsertYN==true){
			bizmResult = "SUCCESS";
		}
				
%>
<%-- <form name="hpCert" action="http://toll.surem.com/message/direct_call_sms_return_post.asp" method="post">
	<input type="hidden" name="member" value="1">
	<input type="hidden" name="usercode" value="enuritest">
	<input type="hidden" name="deptcode" value="7F-WIJ-ZG">
	<input type="hidden" name="group_name" value="<%=cs_tel%>">
	<input type="hidden" name="to_message" value="<%=strMsg%>">
	<input type="hidden" name="from_num1" value="02">
	<input type="hidden" name="from_num2" value="6354">
	<input type="hidden" name="from_num3" value="3601">
	<input type="hidden" name="rurl" value="<%=ENURI_COM_SSL%>/mobilefirst/ajax/login/hpAuthProc_ajax.jsp">
</form> --%>
<!-- 새로 바뀐 bizm URL -->
<%-- <form name="hpCert" action="<%=ENURI_COM_SSL%>/member/join/auth/ConfSelf.jsp" method="post" target="_blank" accept-charset="EUC-KR">

	<input type="hidden" name="member" value="1">
	<input type="hidden" name="group_name" value="<%=cs_tel%>">
	<input type="hidden" name="cs_no" value="<%=cs_no%>"><!-- 인증번호. 테스트 후 주석처리. -->
	<input type="hidden" name="winType" value="iframe">
	<input type="hidden" name="Result" value="<%=bizmResult%>">

</form> --%>
<script language='JavaScript'>
if("<%=bizmResult%>"=="SUCCESS"){
	alert("인증번호가 카카오 알림톡으로 발송되었습니다.\n(알림톡 수신 불가 시 입력하신 번호로 SMS가 발송됩니다.)");
	
}
<%-- 
function callbackFunction(callback){
	alert("인증번호가 카카오 알림톡으로 발송되었습니다.\n(알림톡 수신 불가 시 입력하신 번호로 SMS가 발송됩니다.)");
	callback();
}
 
function testFunction(){
	if("<%=bizmResult%>"=="SUCCESS"){
		alert("인증번호가 카카오 알림톡으로 발송되었습니다.\n(알림톡 수신 불가 시 입력하신 번호로 SMS가 발송됩니다.)");

		callbackFunction(function(){
			
			<%
		  	for(int i=0;i<5;i++){
				System.out.println("kkkk forever 세션번호:"+(String)ttsession.getAttribute("MEMJOIN_SELF_CONF"));
				ttsession = request.getSession(true);
				ttsession.setAttribute("MEMJOIN_SELF_CONF", cs_no);
				Thread.sleep(2000);
			}  
			%>
		});
	}
} --%>


/* document.charset = "euc-kr";
var obj = document.hpCert;
obj.submit(); */
</script>
<%
	}
}
%>
</body>
</html>
<%!
public boolean isPhoneNumber(String num){
	boolean isPhoneNumber = false;
	String firstNum = CutStr.cutStr(num, 3);
	
	if(firstNum.equals("010") || firstNum.equals("011") || firstNum.equals("016") || firstNum.equals("017") || firstNum.equals("018") || firstNum.equals("019")){
		isPhoneNumber = true;
	}
	
	return isPhoneNumber;
}
%>
