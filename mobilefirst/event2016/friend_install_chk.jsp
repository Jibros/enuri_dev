<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>

<%@ page import="com.enuri.bean.event.Members_Friend_Proc"%>
<jsp:useBean id="Members_Friend_Proc" class="com.enuri.bean.event.Members_Friend_Proc" scope="page" />

<%

	/* String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
	String strUuid = cb.GetCookie("MOBILEWEBUUID","UUID");
	String strI_Uuid = cb.GetCookie("MOBILEWEBIUUID","I_UUID");
	//cUserId = "omom1";
	//strI_Uuid = "103cef5c4cae5966"; 
	 
	String strText = ""; 
	
	String recUserid = "";   
	boolean bInstallChk = false; 
	boolean bFirstInstall = false;
	boolean bCheckPhone = false;
	
	//recUserid = Members_Friend_Proc.getRec_UserId(cUserId);
			
	Members_Friend_Proc members_friend_proc = new Members_Friend_Proc();
	 
	String strTextDiff = Members_Friend_Proc.getApplist(strI_Uuid);  
	 
	bInstallChk = Members_Friend_Proc.InstallChk(strI_Uuid, cUserId, "20160901");
 	//bInstallChk : true(첫설치대상), false(첫설치대상아님)
 	//bCheckPhone : true(첫설치/첫신청), false(핸드폰번호 중복)
 	if(bInstallChk){
 		//첫설치 포인트 지급
		bCheckPhone = Members_Friend_Proc.checkPhone(cUserId);
 		if(bCheckPhone){
	 		bFirstInstall = Members_Friend_Proc.appInstallPoint(cUserId); 
	 		strText = Members_Friend_Proc.getApplist(strI_Uuid);  
	 		if(!strTextDiff.equals(strText)){
	 			strText = strText+"Diff"; 
	 		}
 		}else{
 			//
 			strText = "0001";
 		}
 	}else{   
 		strText = "0000"; 
 	}
 	//System.out.println("strText==="+strText);
 	out.println(strText); */
%>  