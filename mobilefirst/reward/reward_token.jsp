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
<jsp:useBean id="Mobile_Push_Proc" class="com.enuri.bean.mobile.Mobile_Push_Proc" scope="page" />
<%
CRSA rsa = new CRSA();

//넘겨받는값 (구분자 + rdate + 에누리아이디)
//	구분자 = Part + code
//			Part  : A ( Aos) , I ( Ios )
//			code : 1001 ( core )

//Aos sample
//A100120150831143601b9ad161b92ed5dec||sonane45
//String strSample = "TG4f6KTtHpHXNvHDOsTxmzJE95nO_AHTOQxYQA0LUlOuKRj5YIuObB0BaZcfFpJ8-xnd6zvHJD7oe4CXwqC5ldeINWIYzne4MKTxBrV-HJDsr_vunS7lLJA9Q0-EfEtWDxnlClVfimABtjLfJXC9_Njx84GH2no0uBZKZtmVJN8=";

//Ios sample
//I100120150831143601262147E4-A1B4-4D47-AB5B-B843D1F23E64||enuri_id
//String strSample = "W4d868NJUkagXMkMirx85Br5WuWpwxUSg2xf-hFRDWtDqDYMvEs4DI0EThPkgTgEqUVAeIpJMaPgyZsg9HP-ISc8e_qCSGsQyaE9yea19kJMDE0CxcaPi1P4I8PLauNUPAS2GkOLbu3kz8Fw5J76F0CfUBZSZ8qkob536BYTNB4=";

String strRSA = ChkNull.chkStr(request.getParameter("rt"));
//String strRSA = strSample;
String strType = "";
String strDate = "";
String strUserdata = "";
String strFdate = "";		//만료일 = strDate + 28일
String strApptype = "";
String strEnuriId = "";

boolean blUpdate = false;
int intSeqno = 0;
String strT1 = "";
String strT1_Rsa = "";
String strR_code = "";
String strR_msg = "";


strRSA = strRSA.replaceAll("[-]","+");
strRSA = strRSA.replaceAll("[_]","/");

String strRSA2	= "";

try{
	

if(strRSA.length() > 0){ 	  
	strRSA2	= rsa.decryptByPrivate(strRSA).trim();   //RSA 타는것
}    

if(!strRSA2.equals("")){
	strType = strRSA2.substring(0,5);
	strDate = strRSA2.substring(5,19);
	strUserdata = strRSA2.substring(19,strRSA2.indexOf("||"));
	strEnuriId = strRSA2.substring(strRSA2.indexOf("||")+2,strRSA2.length());
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
//out.println("strApptype>>>"+strApptype +"<br>");
//out.println("strUserdata>>>"+strUserdata +"<br>");
//out.println("strFdate>>>"+strFdate +"<br>");
//out.println("strEnuriId>>>"+strEnuriId +"<br>");

//seqno 추출

intSeqno = Mobile_Push_Proc.chk_reward_request(strUserdata, strEnuriId);

//out.println("intSeqno>>>"+intSeqno +"<br>");

if(intSeqno > 0){
	//update
	blUpdate = Mobile_Push_Proc.updatePush_reward(strDate,strFdate, intSeqno);
}else if(strApptype.equals("I")){
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
	strT1 = strDate  + "||" +  strFdate + "||" +  strEnuriId + "||"+ strUserdata;
	//RSA생성
	strT1_Rsa = rsa.encryptByPublic_mobile(strT1);
	
	//out.println("strT1_Rsa1>>>"+strT1_Rsa+"<br>");
	
	strT1_Rsa = strT1_Rsa.replaceAll("[+]","-");
	strT1_Rsa = strT1_Rsa.replaceAll("[/]","_");
	
	//out.println("strT1_Rsa2>>>"+strT1_Rsa+"<br>");
	
	//out.println("strT1>>>"+strT1+"<br>");
	//out.println("strT1_Rsa>>>"+strT1_Rsa+"<br>");
	//out.println("strT1_Rsa_decrypt>>>"+rsa.decryptByPrivate_mobile(strT1_Rsa)+"<br>");
}

}catch(Exception e) {
	
}
/*
	구분 					code 				message 							비고 
1 	성공 					100 				ok 　 
2 	티켓 오류 			200 				잘못된 data입니다. 　 
3 	request 오류 		300 				data를 조회할 수 없습니다. 		입력값 오류 
4 	server 오류 			400 				data를 조회할 수 없습니다. 		서버 오류 
5	기한만료				500				기한이 만료되었습니다.				기한만료
*/
if(strRSA ==  null || strRSA.equals("") || strType.equals("") || strApptype.equals("") || strUserdata.equals("")  || strEnuriId.equals("") || intSeqno == 0 || !blUpdate){
	strR_code = "200";
	strR_msg = "잘못된 data입니다. ";
}else if(blUpdate && strT1 != null && !strT1.equals("")){
	strR_code = "100";
	strR_msg = "ok";
}else if(blUpdate && strT1 != null && strT1.equals("")){
	strR_code = "400";
	strR_msg = "data를 조회할 수 없습니다.";
}else{
	strR_code = "300";
	strR_msg = "data를 조회할 수 없습니다.";
}

out.println("{");
out.println("	   \"code\": \""+ strR_code +"\", ");
out.println("	   \"message\": \"\", ");
out.println("	   \"result\": \""+ strT1_Rsa +"\" ");
out.println("}");

%>