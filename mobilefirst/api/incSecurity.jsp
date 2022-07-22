<%!
private String strEnuri_id = "";

public void setEnuri_id(String id){
	strEnuri_id = id;
}

public String getEnuri_id(){
	return strEnuri_id;
}

public boolean chk_r1(String strT1, String strRSA, String browser){
	CRSA rsa = new CRSA();
	//	구분자 = Part + code
	//	Part  : A ( Aos) , I ( Ios )
	//	code : 1001 ( core )
	//appid , uuid,id,t1
	//ti 풀어서 넘어온 uuid 랑 pd에 있는 uuid가 동일하면 t1을 새로 말아서 던져줌.
	
	
	//Ios sample
	//appid=I1001&time=20160616165512&uuid=98BA2085-AFB7-45AA-BB21-E9032DDFB44F&id=en724&pw=en0724
	//String strSample = "QPjisj5L_hJrzKwaNZOeoP-jxgVKPVWKlfPc8IXnSV-_mnNxQ88ZTnzFvMnjOnX3c8Sm9ypaxemKXav3rhtqXIbKkz0BLvNg7fbehC4VmQq597MUFh8krE-ztwDuWOqYdczKUlmYNai7RGch3HV8UWf38LsT1rJS8m8cE6rMFrQ=";
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
	
	boolean blOk = false; //전부 맞으면 true;
	if(blCheck_t1 && blCheck_pd){
		if(strT1_userdata.trim().equals(sUuid.trim())){
			blOk = true;
			setEnuri_id(sEnuri_id);
		}
	}
	
	return blOk;
}
%>