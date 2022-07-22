<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.bean.event.Members_Friend_Proc"%>
<jsp:useBean id="Members_Data" class="com.enuri.bean.knowbox.Members_Data" />
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc" />
<jsp:useBean id="Members_Friend_Proc" class="Members_Friend_Proc" scope="page" />
<%

response.sendRedirect("/mobilefirst/Index.jsp");

/*
	String sendScript = "";

	String strName = ChkNull.chkStr(request.getParameter("name"), "");
	String strID = ChkNull.chkStr(request.getParameter("user_id"), "");
	String strPass = ChkNull.chkStr(request.getParameter("pass1"), "");
	String strEmail = ChkNull.chkStr(request.getParameter("email"), "");
	String strTel1 = ChkNull.chkStr(request.getParameter("tel1"), "");
	String strTel2 = ChkNull.chkStr(request.getParameter("tel2"), "");
	String strTel3 = ChkNull.chkStr(request.getParameter("tel3"), "");
	String strZip = ChkNull.chkStr(request.getParameter("zip"), "");
	String strAddr1 = ChkNull.chkStr(request.getParameter("addr1"), "");
	String strAddr2 = ChkNull.chkStr(request.getParameter("addr2"), "");
	String strNickname = ChkNull.chkStr(request.getParameter("nickname"), "");
	String strJob = ChkNull.chkStr(request.getParameter("job"), "");
	String strWedding = ChkNull.chkStr(request.getParameter("wedding"), "");
	String strEscro = ChkNull.chkStr(request.getParameter("escro"), "");
	String strMailing = ChkNull.chkStr(request.getParameter("mailing"), "");
	String strAvataPicName = ChkNull.chkStr(request.getParameter("avatapicname"), "");
	String strIntro = ChkNull.chkStr(request.getParameter("intro"), "");
	String strTelflag = ChkNull.chkStr(request.getParameter("telflag"), "1");
	String strHptel1 = ChkNull.chkStr(request.getParameter("hptel1"), "");
	String strHptel2 = ChkNull.chkStr(request.getParameter("hptel2"), "");
	String strHptel3 = ChkNull.chkStr(request.getParameter("hptel3"), "");
	String strConnInfo = ChkNull.chkStr(request.getParameter("conninfo"), "");
	String strDupInfo = ChkNull.chkStr(request.getParameter("dupinfo"), "");
	String strYyyymmdd = ChkNull.chkStr(request.getParameter("yyyymmdd"), "");
	String strSex = ChkNull.chkStr(request.getParameter("sex"), "");
	String strInout_flag = ChkNull.chkStr(request.getParameter("inout"), "");
	String strCertify = ChkNull.chkStr(request.getParameter("certify"), "");
	
	String strSendHp = ChkNull.chkStr(request.getParameter("sendHp"), "");
	
	String marketingYN = ChkNull.chkStr(request.getParameter("marketingYN"), "N");
	String smsYN = ChkNull.chkStr(request.getParameter("smsYN"), "N");
	String emailYN = ChkNull.chkStr(request.getParameter("emailYN"), "N");
	
	String strReg_gate = "1";

	//추천인 로직
	//웹 &&  이전페이지가 게이트페이지일때
	int iSeq  = ChkNull.chkInt(request.getParameter("rec_seq"), 0);
	String strApp = ChkNull.chkStr(request.getParameter("app"),"");
	
	String strRecUserID = "";
	boolean bNomieeInsert = false;
	if(!strApp.equals("Y") && iSeq >= 10000){
		//strRecUserID = "ksay33";
		Members_Friend_Proc members_friend_proc = new Members_Friend_Proc();
		
		strRecUserID = members_friend_proc.getRecommenderid(iSeq); 
		
		//members_nomiee insert
		bNomieeInsert = Members_Friend_Proc.ins_nomiee(strID.toLowerCase(), strRecUserID, "0", "");
	} 
	
	boolean iRtn = false;   
	 
	if(strRecUserID.length() > 0){	//추천인 있을때
		iRtn = Members_Proc.InsertData6(strName, "", strID, strPass, strEmail, strTel1, strTel2, strTel3,
			strZip, strAddr1, strAddr2, "서브이메일", strNickname, "", "",
			strJob, strWedding, strEscro, strMailing, ConfigManager.szConnectIp(request), strAvataPicName, strIntro, strTelflag,
			strHptel1, strHptel2, strHptel3, 
			strConnInfo, strDupInfo, strYyyymmdd, strSex, strInout_flag, strCertify, strReg_gate, smsYN, emailYN , marketingYN, strRecUserID);
	}else{										//추천인 없을때(기존로직)
		iRtn = Members_Proc.InsertData4(strName, "", strID, strPass, strEmail, strTel1, strTel2, strTel3,
				strZip, strAddr1, strAddr2, "서브이메일", strNickname, "", "",
				strJob, strWedding, strEscro, strMailing, ConfigManager.szConnectIp(request), strAvataPicName, strIntro, strTelflag,
				strHptel1, strHptel2, strHptel3, 
				strConnInfo, strDupInfo, strYyyymmdd, strSex, strInout_flag, strCertify, strReg_gate, smsYN, emailYN , marketingYN);	 
	}
	
	*/
%>
