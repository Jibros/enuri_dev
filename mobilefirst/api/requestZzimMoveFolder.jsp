<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding="utf-8"%>
<%//@ include file="/include/Base_Inc_2010.jsp"%>
<%//@ page import="com.enuri.bean.main.Save_Goods_Proc"%>
<%@ page import="com.enuri.bean.mobile.depart.Save_Goods_Proc"%>
<%@ page import="com.enuri.bean.mobile.depart.Save_Goods_Data"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.RSAMains"%>
<%@ page import="com.enuri.bean.mobile.CRSA"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<jsp:useBean id="Mobile_Push_Proc"
	class="com.enuri.bean.mobile.Mobile_Push_Proc" scope="page" />

<%

//20171113 손진욱 t1 pd 모듈
	PDManager_Proc pdmanager = new PDManager_Proc();
	PDManager_PD_Data pdData = pdmanager.chkT1PD(request);
	//////////////////////////////////////////////////////////
	/* CRSA rsa = new CRSA();
	String strT1 = ChkNull.chkStr(request.getParameter("t1"));
	String strRSA = ChkNull.chkStr(request.getParameter("pd"));
	
	strT1 = strT1.replaceAll("[-]","+");
	strT1 = strT1.replaceAll("[_]","/"); */
	/*
	String browser = request.getHeader("User-Agent");
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
	} */

	/* boolean blOk = false; //전부 맞으면 true;
	if(blCheck_t1 && blCheck_pd){
		if(strT1_userdata.trim().equals(sUuid.trim())){
			blOk = true;
		}
	} */
	boolean blCheck = false;
	if(pdData.isData()){
		{	
			
			String sTime		 			= pdData.getTimes();
			String sUuid					= pdData.getUuid();
			String sEnuri_id				= pdData.getEnuri_id();

		
			
			blCheck = false;
			//String strUserId = cb.GetCookie("MEM_INFO","USER_ID");
			String selectedMoveItems = ChkNull.chkStr(request.getParameter("selectedMoveItems"),"");
			String folder_idStr = ChkNull.chkStr(request.getParameter("folder_id"), "0");
			int folder_id = 0;
			try {
				folder_id = Integer.parseInt(folder_idStr);
			} catch(Exception e) {
				
			}
				
			String strUserId = sEnuri_id;
			
			if(strUserId.length()>0 
					&& folder_id>0 
					&& selectedMoveItems.length()>0) {
				
				Save_Goods_Proc save_goods_proc = new Save_Goods_Proc();
				Save_Goods_Data[] save_goods_folder = save_goods_proc.getSaveFolderList(strUserId, true);
				int moveItemsCnt = selectedMoveItems.split(",").length;
				
				if(save_goods_folder != null) {
					
					for(Save_Goods_Data folder : save_goods_folder){
						if(folder.getFolder_id() == folder_id) {
							int folderItemsCnt = folder.getFolderItemCnt();
							
							if(moveItemsCnt+folderItemsCnt < 51){
								save_goods_proc.moveItemFolder(selectedMoveItems, strUserId, folder_id);
								blCheck = true;
							}
							break;
						}
					}
					
				}
				
			}else{
				blCheck =false;
			} 
		}
}

	
/* 	JSONObject json = new JSONObject();
	json.put("result", String.valueOf(blCheck));
	
	out.println(json.toString()); */
	
out.println("{");
out.println("	   \"result\": \""+ blCheck +"\" ");
out.println("}"); 

