<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc" scope="page" />
<%

	String sendScript = "";
	
	String sms_no = ChkNull.chkStr(request.getParameter("sms_no"));
	String cs_tel = ChkNull.chkStr(request.getParameter("cs_tel"));
	String strID = cb.GetCookie("MEM_INFO","USER_ID");
	
	HttpSession ttsession = request.getSession(true);
	String strSession_no = "";
	int intSession_failcnt = 0;
	if(ttsession.getAttribute("MEMJOIN_SELF_CONF")!=null){
		strSession_no = (String)ttsession.getAttribute("MEMJOIN_SELF_CONF");
	}
	if(ttsession.getAttribute("MEMJOIN_SELF_CONF_FAILCNT")!=null) {
		intSession_failcnt = ChkNull.chkInt((String)ttsession.getAttribute("MEMJOIN_SELF_CONF_FAILCNT"));
	}

	//세션값이 없으면 인증문자발송 안한 상태임
	if(sms_no.equals("") || strSession_no.equals("") || cs_tel.equals("")){
		sendScript += "parent.showInputInfoRecvHpAuth('인증번호 입력시간이 초과되었습니다. 인증번호를 재발급 받은 후, 다시 입력해주세요.', 1);";

	} else if(sms_no.equals(strSession_no)) { //인증번호 맞음
		ttsession.setAttribute("MEMJOIN_SELF_CONF", "");
		ttsession.setAttribute("MEMJOIN_SELF_CONF_FAILCNT", "0");
	
		//기존회원테이블에 확인.
		boolean isUsedPhone = false;
		String cs_tel1 = "";
		String cs_tel2 = "";
		String cs_tel3 = "";
		if(cs_tel.length()==11) {
			cs_tel1 = cs_tel.substring(0,3);
			cs_tel2 = cs_tel.substring(3,7);
			cs_tel3 = cs_tel.substring(7,11);
		} else {
			cs_tel1 = cs_tel.substring(0,3);
			cs_tel2 = cs_tel.substring(3,6);
			cs_tel3 = cs_tel.substring(6,10);
		}
		isUsedPhone = Members_Proc.getDataCertifyPhone(cs_tel1, cs_tel2, cs_tel3, "");

		if(isUsedPhone) {

			sendScript += "parent.showInputInfoRecvHpAuth('이미 등록된 전화번호입니다.<br>다른 번호를 입력하세요.', 1);";
			System.out.println("이미 등록된 전화번호입니다.<br>다른 번호를 입력하세요.");
			
		} else { //인증성공
			if(!strID.equals("")) { //회원정보수정
				Members_Proc.update_Tel(strID, cs_tel1, cs_tel2, cs_tel3);
			}
			ttsession.setAttribute("MEMJOIN_SELF_CONF", "");
			ttsession.setAttribute("MEMJOIN_SELF_CONF_FAILCNT", "0");

			sendScript += "parent.showInputAuthComplete();";

		}
	} else { //번호 틀림
		if(intSession_failcnt>=4) { //5회 실패시 다시
			ttsession.setAttribute("MEMJOIN_SELF_CONF", "");
			ttsession.setAttribute("MEMJOIN_SELF_CONF_FAILCNT", "0");

			sendScript += "parent.showInputInfoRecvHpAuth('5회이상 인증번호를 잘못입력하셨습니다. 인증번호를 재발급 받은 후, 다시 입력해주세요.', 1);";
			
		} else {
			intSession_failcnt++;
			ttsession.setAttribute("MEMJOIN_SELF_CONF_FAILCNT", ""+intSession_failcnt);

			sendScript += "parent.showInputInfoRecvHpAuth('인증번호를 잘못입력하셨습니다. 확인해주세요.', 1);";
			//System.out.println("인증번호가 올바르지 않습니다.<br>인증번호를 다시 입력하거나 재전송해주세요.");
		}
	}
	
	String thisDomain = "http://m.enuri.com";
	String serverName = request.getServerName();
	if(serverName.indexOf("stagedev.enuri.com")>-1 || serverName.indexOf("100.100.100.151")>-1 || serverName.indexOf("dev.enuri.com")>-1) {
		thisDomain = "";
	}
	
%>
<!--<form name="sendScriptForm" method="post" action="<%=thisDomain%>/mobilefirst/ajax/login/scriptExec.jsp">-->
<form name="sendScriptForm" method="post" action="/mobilefirst/ajax/login/scriptExec.jsp">
<input type="hidden" name="sendScript" value="<%=sendScript%>">
</form>
<script language="JavaScript">
<!--
document.sendScriptForm.submit();
-->
</script>
