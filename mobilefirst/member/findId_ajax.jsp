<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.member.Login_Data"%>
<%@ page import="com.enuri.bean.member.Login_Proc"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<jsp:useBean id="Login_Data" class="com.enuri.bean.member.Login_Data" />
<jsp:useBean id="Login_Proc" class="com.enuri.bean.member.Login_Proc" />
<jsp:useBean id="Seed_Proc" class="com.enuri.util.seed.Seed_Proc"  />

<%
String inputName = ConfigManager.RequestStr(request, "input_name", "");
String inputHpEmail = ConfigManager.RequestStr(request, "input_hp_email", "");
String isHpEmail = ConfigManager.RequestStr(request, "mallsel_1", "");

String cs_tel1 = "";
String cs_tel2 = "";
String cs_tel3 = "";

String returnId = "";

ArrayList<Login_Data> ldList = new ArrayList<Login_Data>();

if (isHpEmail.equals("hp")) { //핸드폰 번호로 검색 할 경우
	if(inputHpEmail.length()==11){
		cs_tel1 = inputHpEmail.substring(0,3);
		cs_tel2 = inputHpEmail.substring(3,7);
		cs_tel3 = inputHpEmail.substring(7,11);
	}else{
		cs_tel1 = inputHpEmail.substring(0,3);
		cs_tel2 = inputHpEmail.substring(3,6);
		cs_tel3 = inputHpEmail.substring(6,10);
	}

	ldList = Login_Proc.getObjHpFindId(inputName, cs_tel1, cs_tel2, cs_tel3);
	inputHpEmail = "";
} else { //이메일로 검색 할 경우
	ldList = Login_Proc.getObjEmailFindId(inputName, inputHpEmail);
}


//블랙리스트 페이지 제한 로그  입력 _ start
String userIp = ChkNull.chkStr(ConfigManager.szConnectIp(request), "");
String reqUri = ChkNull.chkStr(request.getRequestURI().toString(), "");
String reqUrl = "";
String reqDomain =  ChkNull.chkStr(request.getServerName().toString(), "");
String reqUrlQry = "";

if(request.getServerPort() == 8443){
	reqUrl = "https://"+reqDomain+reqUri; 
}else{ 
	reqUrl = "http://"+reqDomain+reqUri;
}
if(request.getQueryString() != null){
	reqUrlQry = reqUrl+"?"+ ChkNull.chkStr(request.getQueryString().toString(), "");
}else{
	reqUrlQry = reqUrl;
}

//int iPassCnt = Login_Proc.getPassCnt(userIp, 1);		//1일 
boolean bPassLog= Login_Proc.insPassLog(3, reqUri, reqUrlQry, "", Seed_Proc.EnPass(cs_tel1), Seed_Proc.EnPass(cs_tel2), Seed_Proc.EnPass(cs_tel3), inputHpEmail, 0, userIp, "");
//블랙리스트 페이지 제한 로그  입력 _ end

out.print("\r\n{");
out.print("\r\n	\"idList\": [");
 
if (ldList.size() > 0) {
	for (int i=0; i<ldList.size(); i++) {
		String userId = ldList.get(i).getUserid();
		String regDt = ldList.get(i).getRegdate().replace("-", "");
		String visibleUserId = ldList.get(i).getUserid();
		/**
		 * 아이디 앞 세자리만 보여주고 나머지 마스킹 처리
		 */
		if(userId.trim() != "" && userId.length() > 3){
			visibleUserId = userId.substring(0, 3);
			for(int j=0; j<(userId.length()-3); j++){
				visibleUserId += "*";
			}
			
		}
		
		String regYear = regDt.substring(0, 4);
		String regMonth = regDt.substring(4, 6); 
		String regDay = regDt.substring(6, 8);
		
		regDt = regYear +"년 "+ regMonth +"월 "  +regDay+"일" ;
		if(i > 0){
			out.print("\r\n		, ");
		}
		out.print("\r\n		{");
		out.print("\r\n			\"userid\":\""+visibleUserId+"\", ");
		out.print("\r\n			\"regdt\":\""+regDt+"\" ");
		out.print("\r\n		}");
	}

} else {

}
out.print("\r\n	]  ");	
out.print("\r\n}");
%>