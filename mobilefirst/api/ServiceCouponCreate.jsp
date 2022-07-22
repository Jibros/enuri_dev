<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.bean.main.GetLoadExternalPage"%>
<%
/*
"REAL_URL" : "http://v3api.inumber.co.kr",
"FILENAME": "coopmkt_api.log",
"PORT" : 3303,
"CODE": "0549", 
"PASS": "enuri0549"

/ServiceCouponCreate


url: REAL_URL + "/serviceapi.asmx/ServiceCouponCreate", //?CODE=0413&PASS=enuri0413&COUPONCODE=00EB036J00001&SEQNUMBER=4503485320948523480950234";
        type: 'POST',
        data: {
            code: CONFIG.CODE,
            PASS: CONFIG.PASS,
            COUPONCODE: param.COUPONCODE,
            SEQNUMBER: param.SEQNUMBER
        },

*/
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String today = formatter.format(new java.util.Date());

try{
	String strUrl = "";
	String strCode = "0549";
	String strPass = "enuri0549";
	String strCOUPONCODE = ChkNull.chkStr(request.getParameter("COUPONCODE"),"");	//선택한 상품의 code
	int intSEQNUMBER  = ChkNull.chkInt(request.getParameter("SEQNUMBER"),0);		//차감 포인트seq
	
	if(strCOUPONCODE != null && !strCOUPONCODE.equals("") && intSEQNUMBER > 0){
		strUrl = "http://v3api.inumber.co.kr";
		strUrl += "/serviceapi.asmx/ServiceCouponCreate";
		strUrl += "?CODE="+strCode+"&PASS="+strPass+"&COUPONCODE="+strCOUPONCODE+"&SEQNUMBER="+intSEQNUMBER;
		
		String strReturn = new GetLoadExternalPage().getUrlPage(URLDecoder.decode(strUrl,"utf-8")); 
		out.println(strReturn);	
			
	}else{
		System.out.println(today + "] ServiceCouponCreate ==> parameter 이상 ");
	}
}catch(Exception ex){
	System.out.println(today + "] ==  ServiceCouponCreate(error) ==> " +  ex.getMessage());
}
%>