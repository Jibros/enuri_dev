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
<%@ page import="com.enuri.bean.mobile.depart.Save_Goods_Proc"%>
<%@ page import="com.enuri.bean.mobile.depart.Save_Goods_Data"%>
<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%

/*
CRSA rsa = new CRSA();

//	구분자 = Part + code
//			Part  : A ( Aos) , I ( Ios )
//			code : 1001 ( core )
//appid , uuid,id,t1
//ti 풀어서 넘어온 uuid 랑 pd에 있는 uuid가 동일하면 t1을 새로 말아서 던져줌.


//Ios sample
//appid=I1001&time=20160616165512&uuid=98BA2085-AFB7-45AA-BB21-E9032DDFB44F&id=en724&pw=en0724
//String strSample = "QPjisj5L_hJrzKwaNZOeoP-jxgVKPVWKlfPc8IXnSV-_mnNxQ88ZTnzFvMnjOnX3c8Sm9ypaxemKXav3rhtqXIbKkz0BLvNg7fbehC4VmQq597MUFh8krE-ztwDuWOqYdczKUlmYNai7RGch3HV8UWf38LsT1rJS8m8cE6rMFrQ=";

String strT1 = ChkNull.chkStr(request.getParameter("t1"));
String strRSA = ChkNull.chkStr(request.getParameter("pd"));
//String strT1 = "c441kLn_MkWFS0u9Fdx4CD6dN5xEAuSqs3mO2tYoerOg6dmU9b2oStbqHP5Kla1pMSuVwWg-7heSADtiNBVGDZd-L4zw_IfbAgr28pQ05YBk1dvheoqtypvTLymD6_l-srucoL92WWVyhe2tXLdwiKIbYrsnOGYln8ah03lK1ss=";
//String strRSA = "CZrAfC9T5iUni8qaNHxB7lPJa4FCq6tqrOMVirbnZRiqWNd9SThaO1EwcS0VMHKBopYlXC_X1Yt6fBOwjALQg0Oj9GdSSqh8dLnR2RfIXJI-Mnfphv2Ltg-RJfKEwrXq70lkRb_e0lqjiVlZVTKwvdqyeeQRSqZ-xZ4VXuxNVa0=";

strT1 = strT1.replaceAll("[-]","+");
strT1 = strT1.replaceAll("[_]","/");

boolean blCheck_t1 = false;
boolean blCheck_pd = false;

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

*/

PDManager_Proc pdmanager = new PDManager_Proc();
PDManager_PD_Data pdData = pdmanager.chkT1PD(request);
if(pdData != null) {
		
		String strMemberId = pdData.getEnuri_id();
		
		String strModelNos = ChkNull.chkStr(request.getParameter("modelnos"),"");
		Save_Goods_Proc save_goods_proc = new Save_Goods_Proc();

		String astrModelNos[] = strModelNos.split(",");
		int intCount = 0;
		
		for (int i=0;i<astrModelNos.length;i++){
			if (astrModelNos[i].length() > 0 ){
				Save_Goods_Data saveGoodsData = new Save_Goods_Data();
				String tempModelno = astrModelNos[i];
				int intTempModelno = 0;
				long lngTempPlno = 0;
				String strTempMkspModelno = "0";
				saveGoodsData.setMksp_model_no("0");
				
				if(tempModelno.indexOf("G:")>-1 || (tempModelno.indexOf("G:")<0 && tempModelno.indexOf("P:")<0 && tempModelno.indexOf("M:")<0)) {
					tempModelno = tempModelno.replace("G:", "");

					try {
						intTempModelno = Integer.parseInt(tempModelno);
					} catch(Exception e) {}
					saveGoodsData.setIntModelNo(intTempModelno);
				}

				if(tempModelno.indexOf("P:")>-1) {
					tempModelno = tempModelno.replace("P:", "");

					try {
						lngTempPlno = Long.parseLong(tempModelno);
					} catch(Exception e) {}

					saveGoodsData.setPl_no(lngTempPlno);
				}
				
				if(tempModelno.indexOf("M:")>-1) {
					tempModelno = tempModelno.replace("M:", "");

					try {
						strTempMkspModelno = tempModelno;
					} catch(Exception e) {}

					saveGoodsData.setMksp_model_no(strTempMkspModelno);
				}
				
				saveGoodsData.setStrId(strMemberId);
				int intReturn = save_goods_proc.insertMobileSaveGoods(saveGoodsData,"MEMBER");
				if (intReturn >= 0){
					intCount = intCount + intReturn; 
				}else{
					intCount = -1;	
					break;
				}
			}
		}
		
		out.println("{");
		out.println("	   \"result\": \""+ intCount +"\" ");
		out.println("}");
}




%>