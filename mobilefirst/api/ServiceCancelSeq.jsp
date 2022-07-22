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

/ServiceCancelSeq

app.get('/ServiceCancelSeq', function(req, res) {
    console.log('do ServiceCancelSeq');

    // 필수 파라미터 체크
    var param = req.query;
    if (!param.COUPONCODE) { // 상품코드 체크
        res.send('no_has COUPONCODE');
        return;
    }

    if (!param.SEQNUMBER) { // 거래번호 체크
        res.send('no_has SEQNUMBER');
        return;
    }

    console.dir(param);

    najax({
        url: URL + "/serviceapi_02.asmx/ServiceCancelSeq",
        type: 'POST',
        data: {
            code: CONFIG.CODE,
            PASS: CONFIG.PASS,
            COUPONCODE: param.COUPONCODE,
            SEQNUMBER: param.SEQNUMBER
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

});


*/
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String today = formatter.format(new java.util.Date());

try{
	String strUrl = "";
	String strCode = "0549";
	String strPass = "enuri0549";
	String strCOUPONCODE  = ChkNull.chkStr(request.getParameter("COUPONCODE"),"");	//쿠폰코드
	String strSEQNUMBER  = ChkNull.chkStr(request.getParameter("SEQNUMBER"),"");		//쿠폰넘버
	
	if(strCOUPONCODE != null && !strCOUPONCODE.equals("") && strSEQNUMBER != null && !strSEQNUMBER.equals("")){
		strUrl = "http://v3api.inumber.co.kr";
		strUrl += "/serviceapi_02.asmx/ServiceCancelSeq";
		strUrl += "?CODE="+strCode+"&PASS="+strPass+"&COUPONCODE="+ strCOUPONCODE +"&SEQNUMBER="+strSEQNUMBER;
		
		String strReturn = new GetLoadExternalPage().getUrlPage(URLDecoder.decode(strUrl,"utf-8"));
		
		out.println(strReturn);	
		
		System.out.println("ServiceCancelSeq = ["+ today +"]>>>"+strReturn);
	}
}catch(Exception ex){
	System.out.println(today + "] ==  ServiceCancelSeq ==> " +  ex.getMessage());
}
%>