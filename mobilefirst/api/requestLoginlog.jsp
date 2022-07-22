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
String strAppid = ChkNull.chkStr(request.getParameter("appid"));

strT1 = strT1.replaceAll("[-]","+");
strT1 = strT1.replaceAll("[_]","/");

boolean blCheck_t1 = false;
boolean blCheck_pd = false;

String strT1_fdate = "";
String strT1_enuriid = "";
String strT1_userdata = "";

String strFdate = "";

String strR_id = "";
String strT1_Rsa = "";
String strR_code = "";
String strR_msg = "";

String browser = request.getHeader("User-Agent");

String strApp_type = "";

if(strAppid != null && strAppid.length() > 4){
	strApp_type = strAppid.substring(0,1);
	strAppid = strAppid.substring(1,5);
}

if(!strT1.equals("")){
	//t1에 값이 있으면, 값 해독후 판단 진행
	String strT1_rsa = rsa.decryptByPrivate_mobile(strT1);

	//out.println("strT1_rsa>>>"+strT1_rsa + "<br>");

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
	String strOs_type = "MAA";

	if(strApp_type.equals("I")){
		strOs_type = "MAI";
	} 
	//t1에 있는 id 로 로그인 로그 쌓아줌.  session id 대신 userdata로 변경.(app만) 2016-07-14
	//이페이지 들어오는 건 백그라운드에서 포그라운드로 올라올때 콜되는 api 이므로 무조건 자동로그인 처리
	boolean bReturn1 = Members_Proc.Login_Log_Ins_type_autologin(strT1_enuriid, strT1_userdata, ConfigManager.szConnectIp(request), strOs_type, 1);
	//System.out.println("requestLoginlog==="+ConfigManager.szConnectIp(request));
	//mobile_push_token 에 connect_date , enuri_id 를 update 해줌
	int intSeqno = Mobile_Push_Proc.getSeqno(strT1_userdata, strAppid, strApp_type);

	boolean bReturn2 = Mobile_Push_Proc.setConnect_date(strT1_enuriid, intSeqno);
} 
%>
<%!
public static String szConnectIp(HttpServletRequest req)
{
    return req.getRemoteAddr();
}
%>