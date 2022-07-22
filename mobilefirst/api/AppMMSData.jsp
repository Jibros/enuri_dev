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

/AppMMSData

url: REAL_URL + "/App/Appapi.asmx/AppMMSData",
        type: 'POST',
        data: {
            code: CONFIG.CODE,
            PASS: CONFIG.PASS,
            GUCODE: param.GUCODE,
            PINNUMBER: param.PINNUMBER
        },


*/
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String today = formatter.format(new java.util.Date());

try{
	String strUrl = "";
	String strCode = "0549";
	String strPass = "enuri0549";
	String strPINNUMBER  = ChkNull.chkStr(request.getParameter("PINNUMBER"),"");		//쿠프 쿠폰핀넘버
	
	if(strPINNUMBER != null && !strPINNUMBER.equals("")){
		strUrl = "http://v3api.inumber.co.kr";
		strUrl += "/App/Appapi.asmx/AppMMSData";
		strUrl += "?CODE="+strCode+"&PASS="+strPass+"&GUCODE=01&PINNUMBER="+strPINNUMBER;
		
		String strReturn = new GetLoadExternalPage().getUrlPage(URLDecoder.decode(strUrl,"utf-8"));
		out.println(strReturn);	
				
		//System.out.println(today + ": AppMMSData >>> ");
	}else{
		System.out.println(today + "] AppMMSData ==> parameter 이상 ");
	}
}catch(Exception ex){
	System.out.println(today + "] ==  AppMMSData(error) ==> " +  ex.getMessage());
}
%>