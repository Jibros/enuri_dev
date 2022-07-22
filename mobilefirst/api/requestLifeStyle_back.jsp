<%@ page import="com.enuri.bean.main.brandplacement.DBDataTable"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<%@ page import="com.enuri.bean.main.brandplacement.DBWrap"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.RSAMains"%>
<%@ page import="com.enuri.bean.mobile.CRSA"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@ page import="com.enuri.util.date.DateUtil"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<jsp:useBean id="Members_Data" class="com.enuri.bean.knowbox.Members_Data"  />
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc"  />
<jsp:useBean id="Seed_Proc" class="com.enuri.util.seed.Seed_Proc"  />
<jsp:useBean id="Mobile_Push_Proc" class="com.enuri.bean.mobile.Mobile_Push_Proc" scope="page" />
<%
CRSA rsa = new CRSA();

//	구분자 = Part + code
//			Part  : A ( Aos) , I ( Ios )
//			code : 1001 ( core )

//Ios sample
//appid=I1001&time=20160616165512&uuid=98BA2085-AFB7-45AA-BB21-E9032DDFB44F&id=en724&pw=en0724
//String strSample = "QPjisj5L_hJrzKwaNZOeoP-jxgVKPVWKlfPc8IXnSV-_mnNxQ88ZTnzFvMnjOnX3c8Sm9ypaxemKXav3rhtqXIbKkz0BLvNg7fbehC4VmQq597MUFh8krE-ztwDuWOqYdczKUlmYNai7RGch3HV8UWf38LsT1rJS8m8cE6rMFrQ=";

String strRSA = ChkNull.chkStr(request.getParameter("pd"));
//String strRSA = strSample;

String strType = "";
String strDate = "";
String strUserdata = "";
String strFdate = "";		//만료일 = strDate + 28일
String strApptype = "";
String strEnuriId = "";
String strEnuriPw = "";
boolean blUpdate = false;
int intSeqno = 0;
String strT1 = "";
String strT1_Rsa = "";
String strR_code = "";
String strR_msg = "";
String strR_id = "";

strRSA = strRSA.replaceAll("[-]","+");
strRSA = strRSA.replaceAll("[_]","/");

String strRSA2	= "";
boolean blLogin_chk = false;

String errCode = "";

try{
	

	if(strRSA.length() > 0){ 	  
		strRSA2	= rsa.decryptByPrivate(strRSA).trim();   //RSA 타는것
	}    
	
	String astrRSA[] = strRSA2.split("&");
	
	int intRSACnt = astrRSA.length; 
	
	if(strRSA2.length() > 0 && intRSACnt == 5){
	
		for (int i=0 ; i<intRSACnt ; i++){
			if(i == 0)	 strType 				= astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length()).trim();
			if(i == 1)	 strDate 					= astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length()).trim();
			if(i == 2)	 strUserdata 			= astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length()).trim();
			if(i == 3)	 strEnuriId 				= astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length()).trim();
			if(i == 4)	 strEnuriPw 				= astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length()).trim();
		}
	}
	
	if(!strType.equals("") && strType.indexOf("A") > -1){
		strApptype = "A";
	}else if(!strType.equals("") && strType.indexOf("I") > -1){
		strApptype = "I";
	}
	
	if(!strDate.equals("")){	//date가 있으면 fire date 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		
		Date dayToday = new Date();
		
		cal.setTime(dayToday);
		cal.add(Calendar.DATE, 28);
		cal.add(Calendar.HOUR, 2);
		cal.add(Calendar.MINUTE, 30);
		cal.add(Calendar.SECOND, 11);
		
		strFdate = sdf.format(cal.getTime());
	}
	
	//out.println("strType>>>"+strType +"<br>");
	//out.println("strDate>>>"+strDate +"<br>");
	//out.println("strUserdata>>>"+strUserdata +"<br>");
	//out.println("strEnuriId>>>"+strEnuriId +"<br>");
	//out.println("strEnuriPw>>>"+strEnuriPw +"<br>");
	
	//out.println("strDate>>>"+strDate +"<br>");
	//out.println("strFdate>>>"+strFdate +"<br>");
	
	//회원여부 확인
	Members_Data members_data = Members_Proc.Login_Check( strEnuriId , strEnuriPw ); //사용자 정보
	
	errCode      = ChkNull.chkStr(members_data.getErrCode());
	
	if(errCode.trim().length() == 0 ){ //정상
		intSeqno = Mobile_Push_Proc.chk_reward_request(strUserdata, strEnuriId);

		//out.println("intSeqno>>>"+intSeqno +"<br>");

		if(intSeqno > 0){
			//update
			blUpdate = Mobile_Push_Proc.updatePush_reward(strDate,strFdate, intSeqno);
		}else{
			//IOS일때 seqno 없을때. token table에 insert를 한다
			//int vReturn = Mobile_Push_Proc.getPushChk2(strUserdata, "");      
			int vReturn = Mobile_Push_Proc.getPushChk3(strUserdata, "", "1001",strApptype);
		     
			if(vReturn == 1){				//insert         
				//boolean vReturn2 = Mobile_Push_Proc.insertPush("1001", strApptype, "ios_tokenpass", "ios_arnpass", strUserdata, strEnuriId, "", "3.0.0");
				boolean vReturn2 = Mobile_Push_Proc.insertPush("1001", strApptype, "ios_tokenpass", "ios_arnpass", strUserdata, strEnuriId, "", "3.0.5.00");
			}else if(vReturn > 1){		 
				//boolean vReturn2 = Mobile_Push_Proc.updatePush4(vReturn, "1001", strApptype, "ios_tokenpass", "ios_arnpass", strUserdata, strEnuriId, "", "3.0.0");
				boolean vReturn2 = Mobile_Push_Proc.updatePush6(vReturn, "1001", strApptype, "", "", strUserdata, strEnuriId, "", "");
			}   
		 
			intSeqno = Mobile_Push_Proc.chk_reward_request(strUserdata, strEnuriId);
			 
			blUpdate = Mobile_Push_Proc.updatePush_reward(strDate,strFdate, intSeqno);
		}

		//out.println("blUpdate>>>"+blUpdate +"<br>");

		//t1 : rsa256(request_date+fire_date+||+enuri_id)

		if(blUpdate){
			//로그인정보 추가
			// 로그인 아이디 저장
			strR_id = Seed_Proc.EnPass_Seed(strEnuriId);
			
			strT1 = strDate  + "||" +  strFdate + "||" +  strEnuriId + "||"+ strUserdata;
			//RSA생성
			strT1_Rsa = rsa.encryptByPublic_mobile(strT1);
			
			//out.println("strR_t11>>>"+strR_t1+"<br>");
			
			strT1_Rsa = strT1_Rsa.replaceAll("[+]","-");
			strT1_Rsa = strT1_Rsa.replaceAll("[/]","_");
			
			//out.println("strR_t12>>>"+strR_t1+"<br>");
			
			//out.println("strT1>>>"+strT1+"<br>");
			//out.println("strR_t1>>>"+strR_t1+"<br>");
			//out.println("strT1_Rsa_decrypt>>>"+rsa.decryptByPrivate_mobile(strT1_Rsa)+"<br>");
		}
		blLogin_chk = true;
	}
}catch(Exception e) {
	
}
/*
	구분 					code 				message 							비고 
1 	성공 					100 				ok 　 
2 	data오류 			200 				data가 잘못 되었습니다.			RSA 오류 　 
3 	request 오류 		300 				data를 조회할 수 없습니다. 		입력값 오류 
4 	server 오류 			400 				data를 조회할 수 없습니다. 		서버 오류
5 	Login  오류 			500 				로그인정보가 잘못되었습니다.		아이디비번오류
6	휴면상태				600				휴면상태로 전환되었습니다.		휴면상태
7	탈퇴회원				700				탈퇴하신 회원입니다.				탈퇴상태 

6 HTTS 에서만 노출 
*/
	

String strUrl = request.getRequestURL().toString();

boolean isHttps = false;

if(strUrl.startsWith("https://")){
	isHttps = true;
}

if(blLogin_chk && blUpdate && strT1 != null && !strT1.equals("")){
	strR_code = "100";
	strR_msg = "ok";
}else if(errCode.equals("08") && isHttps){
	strR_code = "600";
	strR_msg = "님은%5Cn최근 1년 간 로그인 이력이 없는 회원으로,%5Cn휴면 상태로 전환되었습니다.";
}else if(errCode.equals("01") || errCode.equals("011")){
	strR_code = "700";
	strR_msg = "탈퇴하신 회원 입니다.";
}else if(!blLogin_chk){
	strR_code = "500";
	
	if(errCode.equals("05")){
		strR_msg = "임시 비밀번호가 발급된 상태이므로\nPC환경에서 비밀번호를 변경해 주세요.";
	}else{
		strR_msg = "ID 또는 비밀번호가 일치하지 않습니다.";
	}
}else if(strRSA ==  null || strRSA.equals("") || strType.equals("") || strApptype.equals("") || strUserdata.equals("")  || strEnuriId.equals("") || intSeqno == 0 || !blUpdate){
	strR_code = "200";
	strR_msg = "잘못된 data입니다. ";
}else if(blUpdate && strT1 != null && strT1.equals("")){
	strR_code = "300";
	strR_msg = "data를 조회할 수 없습니다.";
}else{
	strR_code = "400";
	strR_msg = "data를 조회할 수 없습니다.";
}

out.println("{");
out.println("	   \"code\": \""+ strR_code +"\", ");
out.println("	   \"message\": \""+ strR_msg +"\", ");
out.println("	   \"result_id\": \""+ strR_id +"\", ");
out.println("	   \"result\": \""+ strT1_Rsa +"\" ");
out.println("}");

%>