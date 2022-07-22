<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.RSAMains"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@ page import="com.enuri.bean.mobile.CRSA"%>
<%@ page import="com.enuri.bean.mobile.Reward_Data"%>
<%@ page import="com.enuri.bean.mobile.Reward_Proc"%>
<jsp:useBean id="Reward_Data" class="Reward_Data" scope="page" />
<jsp:useBean id="Reward_Proc" class="Reward_Proc" scope="page" />
<%
//t1=@@@&enuri_id=@@@&shop_code=@@@&order_no=@@@&user_data=@@@&url=@@@&error_msg=@@@

CRSA rsa = new CRSA();

String strT1 = ChkNull.chkStr(request.getParameter("t1"));
String strUrl = ChkNull.chkStr(request.getParameter("url"));
String strError_msg = ChkNull.chkStr(request.getParameter("error_msg"));

//out.println("strT11>>>"+strT1 + "<br>");

strT1 = strT1.replaceAll("[-]","+");
strT1 = strT1.replaceAll("[_]","/");

//out.println("strT12>>>"+strT1 + "<br>");

boolean blCheck_t1 = false;

String strT1_fdate = "";
String strT1_enuriid = "";
String strT1_userdata = "";
String strR_code = "";
String strR_msg = "";

String browser = request.getHeader("User-Agent");

//System.out.println("browser>>>"+browser);

String strApp_type = "";

if((browser+"").indexOf("Darwin") > -1){
	strApp_type = "I";
}else{
	strApp_type = "A";
}
//browser>>>enuriApp/2.2.7.04 CFNetwork/758.0.2 Darwin/14.5.0
//browser>>>Dalvik/2.1.0 (Linux; U; Android 5.0.1; SHV-E330S Build/LRX22C)

if(!strT1.equals("")){
	//t1에 값이 있으면, 값 해독후 판단 진행
	String strT1_rsa = rsa.decryptByPrivate_mobile(strT1);
	//fire_date가 현재보다 큰지만 비교해서 크면 반환
	//id & user_data 비교 해서 다르면 반환
	//아니면 OK
	//out.println("strT1_rsa>>>"+strT1_rsa + "<br>");
	
	if(strT1_rsa != null){
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
			//fire_date가 현재보다 큰지만 비교해서 크면 반환	
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			
			Date dayToday = new Date();
			
			if(Double.parseDouble(sdf.format(dayToday)) > Double.parseDouble(strT1_fdate)){
				//out.println("error");
				blCheck_t1 = true;	//로그에서만 pd값 풀게 처리
			}else{
				//out.println("success");
				blCheck_t1 = true;
			}
		}
	}
}

if(blCheck_t1){
	Mobile_Push_Proc mobile_push_proc = new Mobile_Push_Proc();

	int vReturn = 0;

	boolean vTrue = false;
	
	String strRSA2 = ""; 
	 
	String strRSA = ChkNull.chkStr(request.getParameter("pd"));
	strRSA = strRSA.replaceAll("[-]","+");
	strRSA = strRSA.replaceAll("[_]","/");
	
	if(strRSA.length() > 0){ 	  
 		strRSA2	= mobile_push_proc.longdecrypt3(strRSA);   //RSA 타는것
 	}    

	//out.println("strRSA2>>"+strRSA2);
	
	//strRSA2 = "app_id=&app_type=&service_type=&enuri_id=enuri&shop_code=auction&order_no=1234567890&user_data=ABCDEFG1234567890";	//test
	
	if(strRSA2 != null){
		if(strRSA2.indexOf("enuri_id") > -1 && strRSA2.indexOf("shop_code") > -1 && strRSA2.indexOf("order_no") > -1 && strRSA2.indexOf("user_data") > -1){
			vTrue = true;
		}   
	
	 	String astrRSA[] = strRSA2.split("&");
	 	
		int intRSACnt = astrRSA.length; 
	
		String sEnuri_id 				= "";
		String sShop_code 			= "";
		String sOrder_no				= "";
		String sUser_data				= "";
	
		if(vTrue && strRSA2.length() > 0 && intRSACnt == 4){
	
			for (int i=0 ; i<intRSACnt ; i++){
				if(i == 0)	 sEnuri_id 				= astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length());
				if(i == 1)	 sShop_code 			= astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length());
				if(i == 2)	 sOrder_no 				= astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length());
				if(i == 3)	 sUser_data 			= astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length());
			}
			
			//out.println("sEnuri_id>>"+sEnuri_id +"<br>");
			//out.println("sShop_code>>"+sShop_code +"<br>");
			//out.println("sOrder_no>>>"+sOrder_no +"<br>");
			//out.println("sUser_data>>>"+sUser_data +"<br>");
	
			// x하나라도 오류나면, 롤백 !
			int issuccess = 0;
			
			if(sOrder_no.indexOf(",") > -1){	//지마켓같은경우, 콤마가 넘어오면 다중입력
				String[] arr_Orderno = sOrder_no.trim().split(",");
				String strKey_order = "";
				String strOther_order = "";
				
				for(int j = 0;j<arr_Orderno.length;j++){
					if(arr_Orderno[j] != null && !arr_Orderno[j].equals("")){
						if(j == 0){
							//0번은 G마켓 체결번호, 1번이후로는 주문번호 (체결번호가 주문번호의 키)
							strKey_order = arr_Orderno[j];
						}else{
							if(!strOther_order.equals("")){
								strOther_order += ",";
							}
							strOther_order += arr_Orderno[j];
						}
					}
				}
				
				//out.println("strKey_order>>"+strKey_order +"<br>");
				//out.println("sShop_code>>"+ch_shopcode(sShop_code) +"<br>");
				//out.println("strOther_order>>>"+strOther_order +"<br>");
				//out.println("sUser_data>>>"+sUser_data +"<br>");
				//지마켓은 마지막에 값을 넣어주고 다른 숖은 안넣어주고.
				//issuccess = Reward_Proc.Reward_Cart_Detail_Ins(strKey_order, sEnuri_id, sUser_data, strOther_order);
				Reward_Proc.Reward_Cart_Log_Ins(strKey_order, ch_shopcode(sShop_code), sEnuri_id, sUser_data, strOther_order, strUrl, strError_msg, strApp_type);
			}else{
				Reward_Proc.Reward_Cart_Log_Ins(sOrder_no, ch_shopcode(sShop_code), sEnuri_id, sUser_data, "", strUrl, strError_msg, strApp_type);
	 		}
	
		}else{
			//t1은 있고 pd는 없을때
			Reward_Proc.Reward_Cart_Log_Ins("", "0", strT1_enuriid, strT1_userdata, "", strUrl, "t1_"+strError_msg, strApp_type);
		}
	}else{
		//pd 오류
		Reward_Proc.Reward_Cart_Log_Ins("", "0", strT1_enuriid, strT1_userdata, "", strUrl, "t1_"+strError_msg, strApp_type);
	}
}else{
	//t1이 안넘어오면 구매 이전 토큰 부분에서 오류가 나기 때문에 아무런 정보가 없어도 된다.
	Reward_Proc.Reward_Cart_Log_Ins("", "0", "", "", "", strUrl, strError_msg, strApp_type);
}
%> 
<%!
public static String ch_shopcode(String strShop){
	String rtn_String = "";
	
	if(strShop.equals("11st"))  			rtn_String = "5910";
	if(strShop.equals("gmarket"))  		rtn_String = "536";
	if(strShop.equals("interpark"))			rtn_String = "55";
    if(strShop.equals("auction"))  		rtn_String = "4027";
    if(strShop.equals(".emart"))			rtn_String = "6665";
    if(strShop.equals("ssg"))	  			rtn_String = "6665";
    if(strShop.equals("shinsegaemall")) 	rtn_String = "6665";
    if(strShop.equals("gsshop")) 			rtn_String = "75";
    if(strShop.equals("wemakeprice"))	rtn_String = "6508";
    if(strShop.equals("ticketmonster"))	rtn_String = "6641";
    if(strShop.equals(".lotte.com"))		rtn_String = "49";
    if(strShop.equals("ellotte"))			rtn_String = "6547";
    if(strShop.equals("lotteimall"))		rtn_String = "663";
    if(strShop.equals("cjmall"))				rtn_String = "806";
    if(strShop.equals("g9"))					rtn_String = "7692";
    
    return rtn_String;
}
%>
