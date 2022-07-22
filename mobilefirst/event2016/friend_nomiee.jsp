<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.event.Members_Friend_Proc"%>
<jsp:useBean id="Members_Friend_Proc" class="com.enuri.bean.event.Members_Friend_Proc" scope="page" />
<%

	String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
	String strUuid = cb.GetCookie("MOBILEWEBUUID","UUID");
	String strI_Uuid = cb.GetCookie("MOBILEWEBIUUID", "I_UUID");
	//String strChk = ChkNull.chkStr(request.getParameter("chk"),"");
    
    String strChk = "1001";
    
	//cUserId = "omom1";
	//strI_Uuid = "103cef5c4cae5966"; 
	
	
	//String recUserid = "";  
	boolean bNomieeInsert = false; 
	String strNomiee = "";
  
	//recUserid = Members_Friend_Proc.getRec_UserId(strID);  
	/*
	if(cUserId.equals("omom25")){
		System.out.println("cUserId>>>"+cUserId+"<br>");
		System.out.println("strUuid>>>"+strUuid+"<br>");
		System.out.println("strI_Uuid>>>"+strI_Uuid+"<br>");
		System.out.println("strChk>>>"+strChk+"<br>");		
	}
	*/
	
	//아이디 체크. 아이디 반반 나눠서 같은지 비교
	boolean bCheckId = false;
	int intId_length = cUserId.length();
 	
	/* 
	if(intId_length > 0 && intId_length % 2 == 0){
 	 	String strId_a = cUserId.substring(0,intId_length/2);
 	 	String strId_b = cUserId.substring(intId_length/2,intId_length);
 	 	
 	 	//out.println("cUserId>>>"+cUserId);
 	 	//out.println("strId_a>>>"+strId_a);
 	 	//out.println("strId_b>>>"+strId_b);
 	 	if(strId_a.equals(strId_b)){
 	 		bCheckId = true;
 	 	}
	}
	*/
	/*
	if(!bCheckId){
		Members_Friend_Proc members_friend_proc = new Members_Friend_Proc();
		bNomieeInsert = Members_Friend_Proc.insertNomiee2(strUuid, strI_Uuid, cUserId, strChk);
	}
 	out.println(bNomieeInsert);
 	*/
%>  