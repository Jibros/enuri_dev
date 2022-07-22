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

/ServiceCouponStateInfo

najax({
    url: URL + "/serviceapi.asmx/ServiceCouponStateInfo",
    type: 'POST',
    data: {
        code: CONFIG.CODE,
        PASS: CONFIG.PASS,
        COUPONCODE: param.COUPONCODE,
        COUPONNUM: param.COUPONNUM
    },
    success: function(data) {
        res.header('Content-Type', 'text/xml');
        responseWrite(res, data);
    },

    error: function(error) {
        log.error("데이터수신에러");
        responseWrite(res, error);
    }

});


*/

java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String today = formatter.format(new java.util.Date());

try{
	String strUrl = "";
	String strCode = "0549";
	String strPass = "enuri0549";
	String strCOUPONCODE  = ChkNull.chkStr(request.getParameter("COUPONCODE"),"");	//쿠폰코드
	String strCOUPONNUM  = ChkNull.chkStr(request.getParameter("COUPONNUM"),"");		//쿠폰넘버
	
	if(strCOUPONCODE != null && !strCOUPONCODE.equals("") && strCOUPONNUM != null && !strCOUPONNUM.equals("")){
		strUrl = "http://v3api.inumber.co.kr";
		strUrl += "/serviceapi.asmx/ServiceCouponStateInfo";
		strUrl += "?CODE="+strCode+"&PASS="+strPass+"&COUPONCODE="+ strCOUPONCODE +"&COUPONNUM="+strCOUPONNUM;
		
		String strReturn = new GetLoadExternalPage().getUrlPage(URLDecoder.decode(strUrl,"utf-8"));
		
		out.println(strReturn);	
		
		//System.out.println("ServiceCouponStateInfo = ["+ today +"]>>>"+strReturn);
	}
}catch(Exception ex){
	System.out.println(today + "] ==  ServiceCouponStateInfo ==> " +  ex.getMessage());
}
%>