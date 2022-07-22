<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page language="java" import="NiceID.Check.CPClient"%>
<%@ include file="/member/join/auth/checkPlus_Conf.jsp"%>

<%@ page import="com.enuri.bean.member.Join_Data"%>
<%@ page import="com.enuri.bean.member.Join_Proc"%>
<jsp:useBean id="Join_Data" class="com.enuri.bean.member.Join_Data" />
<jsp:useBean id="Join_Proc" class="com.enuri.bean.member.Join_Proc" />

<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<jsp:useBean id="Seed_Proc" class="com.enuri.util.seed.Seed_Proc" scope="page" />
<%@page import="com.enuri.bean.member.Sns_Login"%>

<%
//ssl
String linkType = ChkNull.chkStr(request.getParameter("linkType")); // p=pc, m=mobile
String sResult = ChkNull.chkStr(request.getParameter("re"));
String sEncodeData = ChkNull.chkStr(request.getParameter("EncodeData"));
String sReserved1 = ChkNull.chkStr(request.getParameter("param_r1"));
String sReserved2 = ChkNull.chkStr(request.getParameter("param_r2"));
String sReserved3 = ChkNull.chkStr(request.getParameter("param_r3"));
String userid   = cb.GetCookie("MEM_INFO", "USER_ID");
//String snstype   = cb.GetCookie("MEM_INFO", "SNSTYPE");
String snstype = "";
snstype = new Sns_Login().getSnsDcd(userid);

String cmdType = ChkNull.chkStr(request.getParameter("cmdType"),"");	// 빈값:가입, modify:회원정보수정, uft:휴면2


//APP
String strApp = ChkNull.chkStr(request.getParameter("app"),"");	 //	Y일때 앱
Cookie[] carr = request.getCookies();
try {
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("appYN")){
	    	strApp = carr[i].getValue();
	    }
	}
} catch(Exception e) {
}


String s1 = "smobileno";
String s2 = "sconninfo";
String s3 = "sdopinfo";
String s4 = "smobileco";
String s5 = "sname";
String s6 = "myauth";

//SSL
String ENURI_COM_SSL = "https://m.enuri.com";

String serverName = request.getServerName();
/* if(serverName.indexOf("stagedev.enuri.com")>-1) {
	ENURI_COM_SSL = "http://"+serverName;
}else if(serverName.indexOf("100.100.100.151")>-1 || serverName.indexOf("dev.enuri.com")>-1){
	ENURI_COM_SSL = "https://"+serverName;
}else{
	ENURI_COM_SSL = "https://"+serverName;
} */

ENURI_COM_SSL = "https://"+serverName;

if(sResult.equals("f")){
%>
	<script language="javascript">
	//alert("본인인증이 실패하였습니다.");
	opener.failMyCheckOk();
	top.window.close();
	</script>
<%
	return;
}

/** 본인인증 모듈 =================================================================================**/
	CPClient kisCrypt = new CPClient();
	String sSiteCode = strCheckConf_code;		// NICE로부터 부여받은 사이트 코드
	String sSitePassword = strCheckConf_pwd;		// NICE로부터 부여받은 사이트 패스워드

    String sCipherTime = "";				 // 복호화한 시간
    String sRequestNumber = "";			 // 요청 번호
    String sResponseNumber = "";		 // 인증 고유번호
    String sAuthType = "";				   // 인증 수단
    String sName = "";							 // 성명
    String sDupInfo = "";						 // 중복가입 확인값 (DI_64 byte)
    String sConnInfo = "";					 // 연계정보 확인값 (CI_88 byte)
    String sBirthDate = "";					 // 생일
    String sGender = "";						 // 성별
    String sNationalInfo = "";       // 내/외국인정보 (개발가이드 참조)
    String sMessage = "";
    String sPlainData = "";

    String sMobileNo = "";                     // 휴대폰 번호
    String sMobileCo = "";                     // 휴대폰 회사

    String tel1_p = "";
    String tel2_p = "";
    String tel3_p = "";

    int iReturn = kisCrypt.fnDecode(sSiteCode, sSitePassword, sEncodeData);
/** 본인인증 모듈 끝 =================================================================================**/

if(iReturn==0){ //인증성공
	sPlainData = kisCrypt.getPlainData();
    sCipherTime = kisCrypt.getCipherDateTime();

    // 데이타를 추출합니다.
    java.util.HashMap mapresult = kisCrypt.fnParse(sPlainData);

    sRequestNumber  = (String)mapresult.get("REQ_SEQ");
    sResponseNumber = (String)mapresult.get("RES_SEQ");
    sAuthType 		= (String)mapresult.get("AUTH_TYPE");
    sName 			= (String)mapresult.get("NAME");
    sBirthDate 		= (String)mapresult.get("BIRTHDATE");
    sGender 		= (String)mapresult.get("GENDER");
    sNationalInfo  	= (String)mapresult.get("NATIONALINFO");
    sDupInfo 		= (String)mapresult.get("DI");
    sConnInfo 		= (String)mapresult.get("CI");
    sMobileNo		= (String)mapresult.get("MOBILE_NO");
    sMobileCo		= (String)mapresult.get("MOBILE_CO");


    // 핸드폰번호 자리별로 저장
    if(sMobileNo.length()==11){
		tel1_p = sMobileNo.substring(0,3);
		tel2_p = sMobileNo.substring(3,7);
		tel3_p = sMobileNo.substring(7,11);
	}else{
		tel1_p = sMobileNo.substring(0,3);
		tel2_p = sMobileNo.substring(3,6);
		tel3_p = sMobileNo.substring(6,10);
	}


	// 데이터 세팅
  	Join_Data join_data_s = new Join_Data();
  	join_data_s.setTel1_p(tel1_p);
  	join_data_s.setTel2_p(tel1_p);
  	join_data_s.setTel3_p(tel1_p);
  	join_data_s.setConf_ci_key(sConnInfo);


 	// 탈퇴 후 7일 체크
 	// sns회원일때는 체크 안함!

  	int secede_count = 0;

 	if(snstype.equals("N") || snstype.equals("K") || snstype.equals("A")){
 	}else{
	 	secede_count = Join_Proc.secedeCheck(join_data_s);

		if(secede_count > 0){
	  		%>
	  		<script>


	  		alert("탈퇴 후 7일 이후\n재인증이 가능합니다.");
			top.window.close();

	  		</script>
	  		<%
	  		return;
	  	}
 	}

  	//가입일기준 본인인증 생일이 14세 미만인지
 	if(cmdType.equals("modify")){
	  	boolean bUftRegdate = Join_Proc.MemberUftRegdate(userid, ChkNull.chkInt(sBirthDate));

	 	if(bUftRegdate){
	  	%>
			<script>
		  		opener.failMyCheckOk();
				top.window.close();
		 	</script>
	  	<%
	  		return;
	  	}
 	}

 	int nowYear = ChkNull.chkInt(DateStr.nowStr().substring(0,4));
 	int birthYear = 0;

 	String strNowDate = DateStr.nowStr();
 	if(!strNowDate.equals("")){
 		strNowDate = strNowDate.replace("-","");
 		if(strNowDate.length() >=8){
 			strNowDate = strNowDate.substring(0,8);
 		}
 	}

 	int nowYear2 = ChkNull.chkInt(strNowDate);
	//int nowYear2 = ChkNull.chkInt(DateStr.nowStr().replace("-","").substring(0,6));
 	int birthYear2 = 0;

 	//14세 미만
	if(!sBirthDate.equals("") && sBirthDate.length()>=8){
		birthYear2 = ChkNull.chkInt(sBirthDate.substring(0,8));
		if(nowYear2-birthYear2 < 140000){
 		%>
 		<script>
  			opener.failchild();
			top.window.close();
 		</script>
 		<%
 		return;
		}
 	}

    // 세션 설정
    HttpSession ttsession = request.getSession(true);
    ttsession.setMaxInactiveInterval(60*5);

	ttsession.removeAttribute("MEMJOIN_HP_CONF");
	ttsession.removeAttribute("MEMJOIN_CETIFY");
	ttsession.removeAttribute("MEMJOIN_DI");
	ttsession.removeAttribute("MEMJOIN_CI");
	ttsession.removeAttribute("MEMJOIN_NAME");
	ttsession.removeAttribute("MEMJOIN_BIRTHDATE");
	ttsession.removeAttribute("MEMJOIN_GENDER");

    ttsession.setAttribute("MEMJOIN_HP_CONF", sMobileNo);
    ttsession.setAttribute("MEMJOIN_CETIFY", "2");	// 본인인증:2, 간편인증:1
    ttsession.setAttribute("MEMJOIN_DI", sDupInfo);
    ttsession.setAttribute("MEMJOIN_CI", sConnInfo);
    ttsession.setAttribute("MEMJOIN_NAME", sName);
    ttsession.setAttribute("MEMJOIN_BIRTHDATE", sBirthDate);
    ttsession.setAttribute("MEMJOIN_GENDER", sGender);

	String chkAdult = ""; //성인여부 (0:미성년자, 1:성인, 2:판단불가-판매자 또는 주민번호 없이 가입)

	boolean updChk = false;
	String myAuth = "";


	// APP/이머니 휴대폰 본인인증 only update
	if(cmdType.equals("modify")){
		String certify = "2";
		if(userid.equals("")){
		}else{
			updChk = Join_Proc.updateMyPhone(userid, sName, certify, tel1_p, tel2_p, tel3_p, sConnInfo, sDupInfo, sBirthDate, sGender, sMobileCo);
			//본인인증 성공시 쿠키셋팅 CERTIFY=2
			cb.SetCookie("MEM_INFO", "CERTIFY", "2");
			cb.responseAddCookie(response);
		}
		//myAuth = "&s6="+updChk+"";
		myAuth = updChk+"";
	//}
	}else if(cmdType.equals("uft")){ // 휴면2 delete/insert
		// delete / insert 로직 태우기
		String userid2   = cb.GetCookie("REENT", "USR");
		String certify2 = "2";
    	boolean uftChk = false;

		if(!userid2.equals("")){
			uftChk = Join_Proc.UftReEntrance(userid2, sName, certify2, tel1_p, tel2_p, tel3_p, sConnInfo, sDupInfo, sBirthDate, sGender, sMobileCo);
		}
    	if(uftChk){
    		myAuth = cmdType;
    	}else{
    		%>
    		<script>
    	  		opener.failMyCheckOk();
    			top.window.close();
    	 	</script>
      		<%
      		return;
    	}
	}

	sMobileNo = Seed_Proc.EnPass(sMobileNo);
	sDupInfo 	=	Seed_Proc.EnPass(sDupInfo);
	sConnInfo = Seed_Proc.EnPass(sConnInfo);
	sMobileCo = Seed_Proc.EnPass_Seed(sMobileCo);
	if(!sName.equals("")){
		sName 		= Seed_Proc.EnPass_Seed(sName);
	}
%>

	<script language="javascript">

	//alert('mobileNo:'+'<%=sMobileNo%>');

	//try{
		var sdopinfo ="<%=sDupInfo%>";
		sdopinfo = sdopinfo.replace(/\+/g,"-");
		var sconninfo ="<%=sConnInfo%>";
		sconninfo = sconninfo.replace(/\+/g,"-");
		var vModify = "<%=cmdType%>";

		<%
		if(serverName.indexOf("stagedev.enuri.com")>-1) {
		%>
			location.href  = "http://stagedev.enuri.com/mobilefirst/member/myCheckPlus_send.jsp?enus1=<%=sMobileNo%>&enus2="+sconninfo+"&enus3="+sdopinfo+"&enus4=<%=sMobileCo%>&enus5=<%=sName%>&enus6=<%=myAuth%>";
		<%
		}else if(serverName.indexOf("124.243.126.151")>-1 || serverName.indexOf("dev.enuri.com")>-1){
		%>
			location.href  = "<%=ENURI_COM_SSL%>/mobilefirst/member/myCheckPlus_send.jsp?enus1=<%=sMobileNo%>&enus2="+sconninfo+"&enus3="+sdopinfo+"&enus4=<%=sMobileCo%>&enus5=<%=sName%>&enus6=<%=myAuth%>";
		<%
		}else{
		%>
			location.href  = "<%=ENURI_COM_SSL%>/mobilefirst/member/myCheckPlus_send.jsp?enus1=<%=sMobileNo%>&enus2="+sconninfo+"&enus3="+sdopinfo+"&enus4=<%=sMobileCo%>&enus5=<%=sName%>&enus6=<%=myAuth%>";
		<%
		}
		%>
		//window.close();
	//}catch(e){}
	</script>
<%
}else{
	if( iReturn == -1){
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

    if(linkType.equals("m")) {
%>
	<script language="javascript">
	alert("인증이 실패하였습니다.");
	<%if(sReserved2.length()>0) {%>
	document.location.href = "<%=sReserved2%>";
	<%}%>
	</script>
<%
    } else {
%>
	<script language="javascript">
	alert("<%=sMessage%>");
	top.window.close();
	</script>
<%
	}
}
%>