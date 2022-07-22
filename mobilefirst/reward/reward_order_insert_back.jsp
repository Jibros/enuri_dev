<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.RSAMains"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@ page import="com.enuri.bean.mobile.CRSA"%>
<%@ page import="com.enuri.bean.mobile.Reward_Data"%>
<%@ page import="com.enuri.bean.mobile.Reward_Proc"%>
<jsp:useBean id="Reward_Data" class="com.enuri.bean.mobile.Reward_Data" scope="page" />
<jsp:useBean id="Reward_Proc" class="com.enuri.bean.mobile.Reward_Proc" scope="page" />
<%
//t1=@@@&enuri_id=@@@&shop_code=@@@&order_no=@@@&user_data=@@@

CRSA rsa = new CRSA();

String strT1 = ChkNull.chkStr(request.getParameter("t1"));

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

String sEnuri_id 				= "";
String sShop_code 			= "";
String sOrder_no				= "";
String sUser_data				= "";

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
	
	if(strRSA2.indexOf("enuri_id") > -1 && strRSA2.indexOf("shop_code") > -1 && strRSA2.indexOf("order_no") > -1 && strRSA2.indexOf("user_data") > -1){
		vTrue = true;
	}   

 	String astrRSA[] = strRSA2.split("&");
 	
	int intRSACnt = astrRSA.length; 

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
		
		sUser_data = sUser_data.trim();
		strT1_userdata = strT1_userdata.trim();

		if(sUser_data.equals(strT1_userdata)){
			//옥션만 싱글쿼테이션 삭제 2017.3.10(탄핵날) shwoo
			if(sShop_code.equals("auction")){
				//System.out.println("sOrder_no_before>>>>"+sOrder_no);
				sOrder_no = sOrder_no.replaceAll("'","");
				//System.out.println("sOrder_no_after>>>>"+sOrder_no);
			}

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
				//issuccess = Reward_Proc.Reward_Cart_Ins(strKey_order, ch_shopcode(sShop_code), sEnuri_id, sUser_data, strOther_order);
				//2017-05-10 pd 아이디에서 t1 아이디로 변경
				issuccess = Reward_Proc.Reward_Cart_Ins(strKey_order, ch_shopcode(sShop_code), strT1_enuriid, sUser_data, strOther_order);
			}else{
				if(sOrder_no.indexOf("tps://smshop.interpark.com/ord") > -1){	//인터파크 예외처리(결제창 원페이 --;;;)
					issuccess = 1; //log 디비는 쌓고 (reward_order_insert_log.jsp) 여기서는 db는 안 쌓고. 손진욱 요청 2017-01-24
				}else{
					//issuccess = Reward_Proc.Reward_Cart_Ins(sOrder_no, ch_shopcode(sShop_code), sEnuri_id, sUser_data, "");
					//2017-05-10 pd 아이디에서 t1 아이디로 변경
					issuccess = Reward_Proc.Reward_Cart_Ins(sOrder_no, ch_shopcode(sShop_code), strT1_enuriid, sUser_data, "");
				}
			}
			
			if(issuccess == 1){
				strR_code = "100";
				strR_msg = "ok";
			}else if(issuccess == 2){
				strR_code = "600";
				strR_msg = "적립군이 아닙니다.";
			}else{
				strR_code = "400";
				strR_msg = "이미 입력된 data입니다.";
			}
		}else{
			strR_code = "500";
			strR_msg = "유효한 접근경로가 아닙니다.";
 		}
	}else{
		strR_code = "300";
		strR_msg = "잘못된 data입니다.";
	}
}else{
	strR_code = "300";	//원래 200 인데, 잠시 300으로 처리 (하위버전이 만료 지원을 안함.-강제로그아웃) v.3.2.5
	strR_msg = "에누리 로그인 후 다시 구매를 하세요.";	//기간 만료시
}

out.println("{");
out.println("	   \"code\": \""+ strR_code +"\", ");
out.println("	   \"message\": \"\" ");
out.println("}");


/*
구분 					code 				message 							비고 
1 	성공 					100 				ok 　 
2 	기한만료	 			200 				기한이 만료되었습니다. 　 
3 	data 오류 			300 				data를 조회할 수 없습니다. 		데이터 오류 
4 	server 오류 			400 				data를 조회할 수 없습니다. 		서버 오류 & 데이터 중복오류
*/
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
