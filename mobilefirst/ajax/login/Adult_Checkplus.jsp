<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc" scope="page" />
<%@ page language="java" import="NiceID.Check.CPClient"%>
<%@ include file="/join/checkPlus_Conf_2010.jsp"%>
<%
String backUrl = ChkNull.chkStr(request.getParameter("backUrl"), "");
String appYN = "";
String queryStr = request.getQueryString();

if(queryStr!=null && queryStr.indexOf("backUrl=")>-1) {
	backUrl = queryStr.substring(queryStr.indexOf("backUrl=")+8);
}

Cookie[] carr = request.getCookies();

try{
	if(carr != null){
		for(int i=0;i<carr.length;i++){
			if(carr[i].getName().equals("appYN")){
				appYN = carr[i].getValue();
				break;
			}
		}
	}
} catch(Exception e) {
}

/* boolean isIos = false;
if((
		ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 
		|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 
		|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0 
	)&& ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0){
	isIos = true;
} */
	
//ssl
String sResult = ChkNull.chkStr(request.getParameter("re"));
String sEncodeData = ChkNull.chkStr(request.getParameter("EncodeData"));
String sReserved1 = ChkNull.chkStr(request.getParameter("param_r1"));
String sReserved2 = ChkNull.chkStr(request.getParameter("param_r2"));
String sReserved3 = ChkNull.chkStr(request.getParameter("param_r3"));
String userid   = cb.GetCookie("MEM_INFO", "USER_ID");
//out.println("userid="+userid);

if(sResult.equals("f")){
%>
	<script language="javascript">
	alert("본인인증이 실패하였습니다.");
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
//System.out.println(">>>>>>userid : " + userid + ", sGender : " + sGender);
//out.println(">>>>>>userid : " + userid + ", sGender : " + sGender);

	String chkAdult = ""; //성인여부 (0:미성년자, 1:성인, 2:판단불가-판매자 또는 주민번호 없이 가입)
	int nowYear = ChkNull.chkInt(DateStr.nowStr().substring(0,4));
	int birthYear = 0;
	if(!sBirthDate.equals("") && sBirthDate.length()>=4){
		birthYear = ChkNull.chkInt(sBirthDate.substring(0,4));
		if(nowYear-birthYear>=19){
			chkAdult = "1";
		}else{
			chkAdult = "0";
		}
	}else{
		chkAdult = "2";
	}
    cb.SetCookie("MEM_INFO", "ADULT", chkAdult);
    cb.SetCookieExpire("MEM_INFO",-1);
    cb.responseAddCookie(response);

    if(!userid.equals("") && !chkAdult.equals("2")){ //로그인된 경우 실명인증값 없으면 업데이트
		//이미 가입된 실명정보인지 체크
		String[] strCheckRegInfo = Members_Proc.getDataUserInfoIpin(sConnInfo);
		if(!strCheckRegInfo[0].equals("") && !strCheckRegInfo[0].equals("0")){
			out.println("<script language='javascript'>");
			out.println("alert('이미 가입된 실명정보입니다!\\n현재 아이디로는 실명인증 저장이 되지 않습니다.\\n"+strCheckRegInfo[1].substring(0, strCheckRegInfo[1].length()-3)+"*** ("+ReplaceStr.replace(strCheckRegInfo[2],"-",".")+"일 가입)');");
			out.println("</script>");
		}else{
			Members_Data mdata = Members_Proc.getData_One2(userid);
			if(mdata!=null && !mdata.getUserid().equals("")){
				if(mdata.getCi_key().equals("")){
					if(Members_Proc.updateCiData(sConnInfo, sDupInfo, sBirthDate, sGender, userid, sName, sNationalInfo)){
						out.println("<script language='javascript'>");
						out.println("alert('성인인증이 완료되었습니다.');");
						out.println("</script>");
					};
					
				}
			}
		}
    }
%>
<script language="JavaScript">

//document.location.href = "<%=backUrl%>";

<%if(appYN.equals("Y")) {%>
try {
	window.location = "close://";
} catch(e) {}
<%}else{%>
//window.opener.parent.goBackPage();
//window.open('','_self').close();
//document.location.href = "/";
opener.location.href = "<%=backUrl%>";
window.close();
<%}%>
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
%>
	<script language="javascript">
	alert("<%=sMessage%>");
	top.window.close();
	</script>
<%
}
%>