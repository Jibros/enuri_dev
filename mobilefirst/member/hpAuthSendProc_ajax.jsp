<%@ page contentType="text/html; charset=utf-8" %>

<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="org.json.*"%>
<%@ page import="org.apache.commons.lang3.StringUtils"%>
<%@ page import="com.enuri.bean.member.Login_Data"%>
<%@ page import="com.enuri.bean.member.Login_Proc"%>
<jsp:useBean id="Login_Data" class="com.enuri.bean.member.Login_Data"  scope="page" />
<jsp:useBean id="Login_Proc" class="com.enuri.bean.member.Login_Proc"  scope="page" />

<%
	response.setHeader("P3P","CP='CAO PSA CONi OTR OUR DEM ONL'");
	JSONObject jSONObject= new JSONObject(); 
	
	String sendScript = "";
	
	String sms_no = ChkNull.chkStr(request.getParameter("sms_no"));
	String cs_tel = ChkNull.chkStr(request.getParameter("cs_tel"));
	
	//String username = ChkNull.chkStr(request.getParameter("username"));
	String userid = ChkNull.chkStr(request.getParameter("userid"));
	
	String strID = cb.GetCookie("MEM_INFO","USER_ID");
	String serverName1 = request.getRequestURL().toString();
	
	HttpSession ttsession = request.getSession(true);
	String strSession_no = ""; 
	int intSession_failcnt = 0;
	System.out.println("kkkk ------------------");
	System.out.println("kkkk servername: "+serverName1);
	System.out.println("kkkk session.id:"+ttsession.getId());
	System.out.println("kkkk session.isnew:"+ttsession.isNew());
	
	
	if(ttsession.getAttribute("MEMJOIN_SELF_CONF")!=null){
		strSession_no = (String)ttsession.getAttribute("MEMJOIN_SELF_CONF");
	}
	if(ttsession.getAttribute("MEMJOIN_SELF_CONF_FAILCNT")!=null) {
		intSession_failcnt = ChkNull.chkInt((String)ttsession.getAttribute("MEMJOIN_SELF_CONF_FAILCNT"));
	}

	System.out.println("kkkk sms_no:"+sms_no);
	System.out.println("kkkk cs_tel:"+cs_tel);
	System.out.println("kkkk strSession_no:"+strSession_no);
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

	//이름과 핸펀번호로 아이디 찾기
	//String dbUserId = StringUtils.defaultString(Login_Proc.getHpFindId(username,tel1,tel2,tel3));
	
	/**
	  * 아이디 체크로직, 아이디에 번호가 등록되어 있는지 체크로직이 앞으로 빠짐
      * 따라서, 이름과 핸드폰번호로 아이디 찾는 로직이 필요 없어져서 주석 처리함.
      * 2018-03-07 pianohsj1
	  */
	//boolean rtnValue = false;
	//rtnValue = Login_Proc.isMember(userid, username, tel1, tel2, tel3);
	
	/*
	System.out.println("dbUserId:"+dbUserId);
	System.out.println("tel1:"+tel1);
	System.out.println("tel2:"+tel2);
	System.out.println("tel3:"+tel3);
	System.out.println("userid:"+userid);
	System.out.println("username:"+username);
	*/
	
	//세션값이 없으면 인증문자발송 안한 상태임
	if(sms_no.equals("") || strSession_no.equals("") || cs_tel.equals("")){
		jSONObject.put("msg","timeout");

	} else if(sms_no.equals(strSession_no)) { //인증번호 맞음
		
		ttsession.setAttribute("MEMJOIN_SELF_CONF", "");
		ttsession.setAttribute("MEMJOIN_SELF_CONF_FAILCNT", "0");
		ttsession.setAttribute("MEMJOIN_HP_CONF", cs_tel);
	
		jSONObject.put("msg","success");
		
	} else { //번호 틀림
		if(intSession_failcnt>=4) { //5회 실패시 다시
			ttsession.setAttribute("MEMJOIN_SELF_CONF", "");
			ttsession.setAttribute("MEMJOIN_SELF_CONF_FAILCNT", "0");


			jSONObject.put("msg","5out");
			

		} else {
			intSession_failcnt++;
			ttsession.setAttribute("MEMJOIN_SELF_CONF_FAILCNT", ""+intSession_failcnt);

			jSONObject.put("msg","fail");
			
		}
	}
	 
	//jSONObject.put("msgID","");
	
	//입력된 아이디와 전화번호 이름으로 매칭된 아이디가 다를경우
	/*if(!dbUserId.equals(userid)){
		jSONObject.put("msgID","IDNONE"+dbUserId);
	}
	
	//이름과 전화 번호로 매칭된 아이디가 없을경우
	if("".equals(dbUserId)){
		jSONObject.put("msgID","IDDIFF"+dbUserId);
	}
	if(rtnValue){
		
	}else{
		jSONObject.put("msgID","IDDIFF");
	}  */
	
	  
	out.println(jSONObject);
	
	String thisDomain = "http://m.enuri.com";
	String serverName = request.getServerName();
	if(serverName.indexOf("stagedev.enuri.com")>-1 || serverName.indexOf("100.100.100.151")>-1 || serverName.indexOf("dev.enuri.com")>-1) {
		thisDomain = "";
	}
%>