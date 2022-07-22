<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%
	//모바일전용 LOG 저장용 페이지 shwoo 2016.12.07
	//몽고DB 사용
	String strOs_type = ChkNull.chkStr(request.getParameter("os_type"), "");
	String strChk_id = ChkNull.chkStr(request.getParameter("chk_id"), "");
	String strPage_code = ChkNull.chkStr(request.getParameter("page_code"), "");
	String strApp_ver = ChkNull.chkStr(request.getParameter("app_ver"), "");
	String strUser_ip = ChkNull.chkStr(request.getParameter("user_ip"), "0");

	// page_code info
	//=============
	// A00001 : Main
	// A00002 : LP
	// A00003 : SRP
	// A00004 : VIP*
	//=============
	
    String strHtmlSource = strGetData(strOs_type, strChk_id, strPage_code, strApp_ver, strUser_ip);
    //System.out.println("※Recieve HTML ("+getCurrentDate24() +") \n"+strHtmlSource);

    
%>
<%!
private String strGetData(String strOs_type, String strChk_id, String strPage_code, String strApp_ver, String strUser_ip) {
	  
    BufferedReader    oBufReader = null;
    HttpURLConnection httpConn   = null;
    String strBuffer = "";
    String strRslt   = "";
    String strParam = "?logChkId="+ strChk_id + "&logOsType="+ strOs_type + "&logPageCode="+ strPage_code + "&logAppVer="+ strApp_ver + "&logUserIp="+ strUser_ip;
  
    try
    {
        //String strEncodeUrl = "http://mymelog.enuri.com/MYMELOG/setMobileBigLog.enr"+strParam;
        String strEncodeUrl = "http://internal-INT-MYMELOG-LB-976891188.ap-northeast-2.elb.amazonaws.com/MYMELOG/setMobileBigLog.enr"+strParam;
        URL oOpenURL = new URL(strEncodeUrl);
      
        httpConn =  (HttpURLConnection) oOpenURL.openConnection();          
        httpConn.setRequestMethod("POST");   
        httpConn.setConnectTimeout(1000);
        httpConn.connect();          
        oBufReader = new BufferedReader(new InputStreamReader(oOpenURL.openStream()));

        while((strBuffer = oBufReader.readLine()) != null)
        {
            if(strBuffer.length() > 1)
            {
                strRslt += strBuffer;
            }
        }
      
    } catch( Exception ee) {
    	ee.getMessage();
    }

    return strRslt;
}

private static String getCurrentDate24()
{
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", java.util.Locale.KOREA);
    return formatter.format(new java.util.Date());
}
%>