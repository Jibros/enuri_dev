<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="org.json.*"%>
<%@ page import="org.apache.commons.lang3.StringUtils"%>
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc" scope="page" />
<%
	JSONObject jSONObject= new JSONObject(); 
	
	String sendScript = "";
	
	String sms_no = ChkNull.chkStr(request.getParameter("sms_no"));
	String cs_tel = ChkNull.chkStr(request.getParameter("cs_tel"));
	
	String username = ChkNull.chkStr(request.getParameter("username"));
	String userid = ChkNull.chkStr(request.getParameter("userid"));
	
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

	String tel1 = "";
	String tel2 = "";
	String tel3 = "";

	if(cs_tel.length() > 0){
		
		if(cs_tel.length() == 10){
			tel1 = StringUtils.substring(cs_tel,0,3);
			tel2 = StringUtils.substring(cs_tel,3,6);
			tel3 = StringUtils.substring(cs_tel,6,9);
		}else if(cs_tel.length() == 11){
			tel1 = StringUtils.substring(cs_tel,0,3);
			tel2 = StringUtils.substring(cs_tel,3,7);
			tel3 = StringUtils.substring(cs_tel,7,11);
		}
	}

	//비밀번호 변경
	String dbUserId = StringUtils.defaultString(Members_Proc.getFindId(username,tel1,tel2,tel3));

	System.out.println("dbUserId:"+dbUserId);
	System.out.println("tel1:"+tel1);
	System.out.println("tel2:"+tel2);
	System.out.println("tel3:"+tel3);
	System.out.println("userid:"+userid);
	System.out.println("username:"+username);

	//세션값이 없으면 인증문자발송 안한 상태임
	if(sms_no.equals("") || strSession_no.equals("") || cs_tel.equals("")){
		//sendScript += "parent.showInputInfoRecvHpAuth('인증번호 입력시간이 초과되었습니다.<br>인증번호를 재전송해주세요.', 1);";
		jSONObject.put("msg","timeout");

	} else if(sms_no.equals(strSession_no)) { //인증번호 맞음
		
		ttsession.setAttribute("MEMJOIN_SELF_CONF", "");
		ttsession.setAttribute("MEMJOIN_SELF_CONF_FAILCNT", "0");
	
		jSONObject.put("msg","success");
		
	} else { //번호 틀림
		if(intSession_failcnt>=4) { //5회 실패시 다시
			ttsession.setAttribute("MEMJOIN_SELF_CONF", "");
			ttsession.setAttribute("MEMJOIN_SELF_CONF_FAILCNT", "0");

			//sendScript += "parent.showInputInfoRecvHpAuth('5회 이상 잘못 입력하셨습니다.<br>인증번호를 재전송해주세요.', 1);";
			//System.out.println("5회 이상 잘못 입력하셨습니다.");
			
			jSONObject.put("msg","5out");
			

		} else {
			intSession_failcnt++;
			ttsession.setAttribute("MEMJOIN_SELF_CONF_FAILCNT", ""+intSession_failcnt);
			
			//sendScript += "parent.showInputInfoRecvHpAuth('인증번호가 올바르지 않습니다.<br>인증번호를 다시 입력하거나 재전송해주세요.', 1);";
			//System.out.println("인증번호가 올바르지 않습니다.<br>인증번호를 다시 입력하거나 재전송해주세요.");
			
			jSONObject.put("msg","fail");
			
			//isUsedPhone = Members_Proc.getDataCertifyPhone(cs_tel1, cs_tel2, cs_tel3, "");
			
		}
	}
	
	jSONObject.put("msgID","");
	
	//입력된 아이디와 전화번호 이름으로 매칭된 아이디가 다를경우
	if(!dbUserId.equals(userid)){
		jSONObject.put("msgID","IDNONE");
	}
	
	//이름과 전화 번호로 매칭된 아이디가 없을경우
	if("".equals(dbUserId)){
		jSONObject.put("msgID","IDDIFF");
	}
	
	
	out.println(jSONObject);
	
	String thisDomain = "http://m.enuri.com";
	String serverName = request.getServerName();
	if(serverName.indexOf("stagedev.enuri.com")>-1 || serverName.indexOf("100.100.100.151")>-1 || serverName.indexOf("dev.enuri.com")>-1) {
		thisDomain = "";
	}
%>