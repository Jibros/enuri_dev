<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.JSONObject"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.main.deal.CrazyDeal_Proc"%>
<%@ page import="com.enuri.bean.mobile.RSAMains"%>
<%@ page import="com.enuri.bean.mobile.CRSA"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.bean.log.Log_main_Proc"%>
<jsp:useBean id="Members_Data" class="com.enuri.bean.knowbox.Members_Data"  />
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc"  />
<jsp:useBean id="CrazyDeal_Proc" class="com.enuri.bean.main.deal.CrazyDeal_Proc" scope="page" />
<%@ page import="com.enuri.bean.edeal.Edeal_Order_Proc"%>
<%
	int intSeq = ChkNull.chkInt(request.getParameter("seq"),0);
	if(intSeq  == 0)		return ;
	
	String devYN = "N";
	if( request.getServerName().equals("dev.enuri.com")  ){
		devYN = "Y";
	}
	//JSONObject jsonUrlSoldoutflag = CrazyDeal_Proc.getCrazyDealUrlSoldOutFlag(intSeq);
	//JSONObject jsonUrlSoldoutflag = CrazyDeal_Proc.getCrazyDealUrlSoldOutFlag(intSeq,"Y");
	JSONObject jsonUrlSoldoutflag = CrazyDeal_Proc.getCrazyDealUrlSoldOutFlag(intSeq,devYN);

	String strUrl = "";
	boolean blLogin = false;
	String strSold_out = "";
	int cnt = 0;
	
	try{
		strUrl = jsonUrlSoldoutflag.getString("GOODS_URL");
		blLogin = jsonUrlSoldoutflag.getBoolean("login_need");
		strSold_out = jsonUrlSoldoutflag.getString("GOODS_SOLD_FLAG");
		cnt = jsonUrlSoldoutflag.getInt("CNT");
		
	}catch(Exception e){}
	
	String strUser_ip = ChkNull.chkStr(request.getParameter("user_ip"), "0");	//모바일웹 & PC는 페이지내 처리
	strUser_ip = request.getRemoteAddr();
    
    CRSA rsa = new CRSA();
    String strRSA = ChkNull.chkStr(request.getParameter("pd"));
    String strEnuriId = "";
    String strEnuriPw = "";
	String strOsType  = "";
	
	if("".equals(strRSA)){
		if((ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Linux") >= 0 )){
			strOsType = "MWA"; // WEB
		}else if(
				(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||
				(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||
				(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0)){
			strOsType = "MWI"; // WEB
		}else{
			strOsType = "PC";
		}
		strEnuriId =  StringUtils.trim(cb.GetCookie("MEM_INFO","USER_ID"));
	}else{
    	strRSA = StringUtils.trim(strRSA);
        strRSA = strRSA.replaceAll("[-]","+");
        strRSA = strRSA.replaceAll("[_]","/");
        //out.println(strRSA);
        String strRSA2	= "";
        boolean blLogin_chk = false;
        
    	if(strRSA.length() > 0){ 	  
    		strRSA2	= rsa.decryptByPrivate(strRSA).trim();   //RSA 타는것
    	}    
    	//System.out.println("strRSA : " + strRSA);
    	//System.out.println("strRSA2 : " + strRSA2);
	   	String astrRSA[] = strRSA2.split("&");
    	int intRSACnt = astrRSA.length; 
        for (int i=0 ; i<intRSACnt ; i++){
        	if(i == 0){
				if(ChkNull.chkStr(astrRSA[i]).indexOf("A1001") > -1){
					strOsType = "MAA";
        		}else if(ChkNull.chkStr(astrRSA[i]).indexOf("I1001") > -1){
        			strOsType = "MAI";
        		}
        	}
			if(i == 3)		strEnuriId = astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length()).trim();
			if(i == 4)		strEnuriPw = astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length()).trim();
    	}
    	//회원여부 확인
    	try{
    		strEnuriId = StringReplace(strEnuriId);
	  		Members_Data members_data = Members_Proc.Login_Check( StringUtils.trim(strEnuriId) , StringUtils.trim(strEnuriPw) ); //사용자 정보
    		String errCode = ChkNull.chkStr(members_data.getErrCode());
    	}catch(Exception e){
    		System.out.println("edeallog:"+e);
    	}
    }
	
	boolean IsEnuriEmployee = false;
	
	if(strEnuriId.length()>0) {
		Edeal_Order_Proc edeal_order_proc = new Edeal_Order_Proc();
		IsEnuriEmployee = edeal_order_proc.isEnuriEmployee(strEnuriId);
	}
  	
    out.println("{");
	//if(strUrl != null && !strUrl.equals("")){
	if(strUrl != null && !strUrl.equals("")){
		out.println("\"resultMsg\" : \"SUCCESS\", ");
		out.println("\"resultUrl\" : \""+ strUrl + "\", ");
        out.println("\"EnuriId\": \""+ strEnuriId + "\"," );
                
        //로그인상태에서 판매중인 상품일때 아이디 집계
        if(!strEnuriId.equals("") && strEnuriId!=null && strSold_out.equals("N") && blLogin){
        	CrazyDeal_Proc cdp = new CrazyDeal_Proc();
        	try{
        		cdp.insertEdealUser(intSeq, strEnuriId, strOsType);
        	}catch(Exception e){
        		System.out.println("crazyedeal insert log:"+e);
        	}
        }
	}else{
		out.println("\"resultMsg\" : \"FAIL\", ");
		out.println("\"resultUrl\" : \"\", ");
	}
		out.println("\"IsEnuriEmployee\" : "+IsEnuriEmployee+","); //직원여부
		out.println("\"cnt\" : "+cnt+","); //솔드아웃
		if(cnt > 0 ) out.println("\"soldout\" : \"Y\", "); // 날짜가 지난 상품은 솔드아웃	
		else out.println("\"soldout\" : \""+ strSold_out + "\", "); //판매날짜에 안에있는 상품만			
		
		out.println("\"login_need\" : \""+ blLogin + "\" ");
		
	out.println("}");
	
%>
<%!
//특수문자 제거 하기
public static String StringReplace(String str){       
	String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";
	str =str.replaceAll(match, "").trim();
	//str =str.replaceAll("?","").trim();
	return str;
}
%>