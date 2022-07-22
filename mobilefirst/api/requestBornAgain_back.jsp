<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.enuri.bean.main.brandplacement.DBDataTable"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<%@ page import="com.enuri.bean.main.brandplacement.DBWrap"%>
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
<%!
public static Date addDays(Date date, int days)
{
    Calendar cal = Calendar.getInstance();
    cal.setTime(date);
    cal.add(Calendar.DATE, days); //minus number would decrement the days
    return cal.getTime();
}

public static Date addMins(Date date, int mins)
{
    Calendar cal = Calendar.getInstance();
    cal.setTime(date);
    cal.add(Calendar.MINUTE, mins);
    return cal.getTime();
}
%>
<%
CRSA rsa = new CRSA();

//	구분자 = Part + code
//			Part  : A ( Aos) , I ( Ios )
//			code : 1001 ( core )
//appid , uuid,id,t1
//ti 풀어서 넘어온 uuid 랑 pd에 있는 uuid가 동일하면 t1을 새로 말아서 던져줌.


//Ios sample
//appid=I1001&time=20160616165512&uuid=98BA2085-AFB7-45AA-BB21-E9032DDFB44F&id=en724&pw=en0724
//String strSample = "QPjisj5L_hJrzKwaNZOeoP-jxgVKPVWKlfPc8IXnSV-_mnNxQ88ZTnzFvMnjOnX3c8Sm9ypaxemKXav3rhtqXIbKkz0BLvNg7fbehC4VmQq597MUFh8krE-ztwDuWOqYdczKUlmYNai7RGch3HV8UWf38LsT1rJS8m8cE6rMFrQ=";

//String strT1 = "c441kLn_MkWFS0u9Fdx4CD6dN5xEAuSqs3mO2tYoerOg6dmU9b2oStbqHP5Kla1pMSuVwWg-7heSADtiNBVGDZd-L4zw_IfbAgr28pQ05YBk1dvheoqtypvTLymD6_l-srucoL92WWVyhe2tXLdwiKIbYrsnOGYln8ah03lK1ss=";

String strT1 = ChkNull.chkStr(request.getParameter("t1"));
//String strPd = ChkNull.chkStr(request.getParameter("pd"));
String strRSA = ChkNull.chkStr(request.getParameter("pd"));
//String strRSA = "CZrAfC9T5iUni8qaNHxB7lPJa4FCq6tqrOMVirbnZRiqWNd9SThaO1EwcS0VMHKBopYlXC_X1Yt6fBOwjALQg0Oj9GdSSqh8dLnR2RfIXJI-Mnfphv2Ltg-RJfKEwrXq70lkRb_e0lqjiVlZVTKwvdqyeeQRSqZ-xZ4VXuxNVa0=";

strT1 = strT1.replaceAll("[-]","+");
strT1 = strT1.replaceAll("[_]","/");

boolean blCheck_t1 = false;
boolean blCheck_pd = false;
boolean blCheck_logout = false;

String strT1_fdate = "";
String strT1_enuriid = "";
String strT1_userdata = "";

String sApp_type 				= "";
String sTime		 			= "";
String sUuid						= "";
String sEnuri_id				= "";

String strFdate = "";

String strR_id = "";
String strT1_Rsa = "";
String strR_code = "";
String strR_msg = "";

String browser = request.getHeader("User-Agent");

String strApp_type = "";

if((browser+"").indexOf("Darwin") > -1){
	strApp_type = "I";
}else{
	strApp_type = "A";
}


SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
Date dayToday = new Date();

long lng_today = 0;
long lng_lastdate = 0;

if(!strT1.equals("")){
	//t1에 값이 있으면, 값 해독후 판단 진행
	String strT1_rsa = rsa.decryptByPrivate_mobile(strT1);

	if(strT1_rsa != null && !strT1_rsa.equals("")){
		String[] arrT1_rsa = strT1_rsa.split("[|][|]");
		
		if(arrT1_rsa != null && arrT1_rsa.length > 0){
			for(int i = 0; i < arrT1_rsa.length; i++){
				//out.println("arrT1_rsa["+ i +"]==="+arrT1_rsa[i] + "<br>");
				if(i == 1){
					strT1_fdate = arrT1_rsa[i];
				}else if(i == 2){
					strT1_enuriid  = arrT1_rsa[i];
				}else if(i == 3){
					strT1_userdata  = arrT1_rsa[i];
				}
			}
			
			blCheck_t1 = true;
		}
	}
}

if(blCheck_t1){
	Mobile_Push_Proc mobile_push_proc = new Mobile_Push_Proc();

	int vReturn = 0;

	boolean vTrue = false;
	
	String strRSA2 = ""; 
	 
	if(strRSA != null && !strRSA.equals("")){
		strRSA = strRSA.replaceAll("[-]","+");
		strRSA = strRSA.replaceAll("[_]","/");
		
		if(strRSA.length() > 0){ 	  
			strRSA2	= mobile_push_proc.longdecrypt3(strRSA);   //RSA 타는것
		}

		if(strRSA2 != null && !strRSA2.equals("")){
			if(strRSA2.indexOf("appid") > -1 && strRSA2.indexOf("time") > -1 && strRSA2.indexOf("uuid") > -1 && strRSA2.indexOf("id") > -1){
				vTrue = true;
			}   
			
			if(vTrue){
			 	String astrRSA[] = strRSA2.split("&");
			 	
				int intRSACnt = astrRSA.length; 
			
				if(vTrue && strRSA2.length() > 0 && intRSACnt == 4){
			
					for (int i=0 ; i<intRSACnt ; i++){
						if(i == 0)	 sApp_type 		= astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length()).trim();
						if(i == 1)	 sTime 				= astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length()).trim();
						if(i == 2)	 sUuid 				= astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length()).trim();
						if(i == 3)	 sEnuri_id 			= astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length()).trim();
					}
					
					//out.println("sApp_type>>"+sApp_type +"<br>");
					//out.println("sTime>>"+sTime +"<br>");
					//out.println("sUuid>>>"+sUuid +"<br>");
					//out.println("sEnuri_id>>>"+sEnuri_id +"<br>");
					blCheck_pd = true;
				}
			}
		}
	}
}

if(blCheck_t1 && blCheck_pd){
	
	if(strT1_userdata.trim().equals(sUuid.trim())){
		//out.println("같음");
		
		//T1에 있는 strT1_fdate(종료일자) 보다 28일 후면 500 메세지 (강제 로그아웃) sending
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		Date to = transFormat.parse(strT1_fdate);

		String dateToday = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		String strLast_day = new SimpleDateFormat("yyyyMMddHHmmss").format(addDays(to, 28));
		//String strLast_day = new SimpleDateFormat("yyyyMMddHHmmss").format(addMins(to, 28));
		
		//dateToday = "20170523204000";		//test
		
		//System.out.println("T1 F date>>>>"+strT1_fdate);	//토큰 만료시간
		//System.out.println("Today date>>>"+dateToday);		//오늘 날짜
		//System.out.println("T1 F date+28>>>>"+strLast_day);	//토큰 만료시간 +28일후

		lng_today = Long.parseLong(dateToday);
		lng_lastdate = Long.parseLong(strLast_day);
		
		if(lng_lastdate >= lng_today){		//만료일+28 한 날짜보다 오늘이 작을 경우만 T1값 생성
			//같을때 t1 재 생성

			cal.setTime(dayToday);
			cal.add(Calendar.DATE, 28);
			cal.add(Calendar.HOUR, 2);
			cal.add(Calendar.MINUTE, 30);
			cal.add(Calendar.SECOND, 11);
			//test 28분
			//cal.add(Calendar.MINUTE, 28);
			
			strFdate = sdf.format(cal.getTime());
			
			//System.out.println("new Final Date >>>>"+strFdate);
			
			//out.println("sEnuri_id>>>"+sEnuri_id);
	
			strR_id = Seed_Proc.EnPass_Seed(sEnuri_id);
			//out.println("strR_id>>>"+strR_id);
			
			strT1 = sTime  + "||" +  strFdate + "||" +  sEnuri_id + "||"+ sUuid;
			
			//out.println("strT1 >>>>"+strT1);
			
			//RSA생성
			strT1_Rsa = rsa.encryptByPublic_mobile(strT1);
			
			//out.println("strR_t11>>>"+strR_t1+"<br>");
			
			strT1_Rsa = strT1_Rsa.replaceAll("[+]","-");
			strT1_Rsa = strT1_Rsa.replaceAll("[/]","_");
			
			//out.println("strR_t12>>>"+strR_t1+"<br>");
			
			//out.println("strT1>>>"+strT1+"<br>");
			//out.println("strR_t1>>>"+strR_t1+"<br>");
			//out.println("strT1_Rsa_decrypt>>>"+rsa.decryptByPrivate_mobile(strT1_Rsa)+"<br>");
		}else{
			blCheck_logout = true;
		}
	}
}

/*
	구분 					code 				message 							
1 	성공 					100 				ok 　 
2 	data오류 			200 				t1오류								
3 	request 오류 		300 				pd오류								
4 	server 오류 			400 				t1과 pd의 user_data가 다름 	
5	만료일초과			500				강제 로그아웃

*/
	
if(blCheck_t1 && blCheck_pd && strT1_Rsa != null && !strT1_Rsa.equals("")){
	strR_code = "100";
	strR_msg = "ok";
}else if(blCheck_logout){
		strR_code = "500";
		strR_msg = "log out";
}else if(!blCheck_t1){
	strR_code = "200";
	strR_msg = "t1오류";
}else if(!blCheck_pd){
	strR_code = "300";
	strR_msg = "pd오류";
}else{
	if(blCheck_t1 && blCheck_pd){
		if(!strT1_userdata.trim().equals(sUuid.trim())){
			strR_code = "400";
			strR_msg = "t1과 pd의 user_data가 다름";
		}
	}
}

out.println("{");
out.println("	   \"code\": \""+ strR_code +"\", ");
out.println("	   \"message\": \""+ strR_msg +"\", ");
out.println("	   \"result_id\": \""+ strR_id +"\", ");
out.println("	   \"result\": \""+ strT1_Rsa +"\" ");
out.println("}");


%>