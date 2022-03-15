<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.util.http.ShortUrl"%>
<%@ page import="com.surem.Mobile_TextMessage_Proc"%>
<%
String strPart = ChkNull.chkStr(request.getParameter("part"), "");
String strUrl = ChkNull.chkStr(request.getParameter("rurl"), "");
String strPhoneNum = ChkNull.chkStr(request.getParameter("phoneno"), "");
String strTitle = ChkNull.chkStr(request.getParameter("title"), "");

if(strPart.equals("enuri")){
	strUrl = "http://goo.gl/O8CUnn";
}else if(strPart.equals("hotdeal")){
	strUrl = "http://goo.gl/j62WKU";
}

strUrl = ReplaceStr.replace(strUrl, "--***--", "?");
strUrl = ReplaceStr.replace(strUrl, "--**--", "&");

//System.out.println("Ajax_ListHeader_Sms_Proc.jsp : strPart : "+strPart+", strTitle : "+strTitle+", strUrl : " +strUrl);

if(strPart.equals("search")){

}else if(strPart.equals("cate") && strTitle.equals("")){

}

if(strUrl.equals("") || strPhoneNum.equals("")){
	return;
}

ShortUrl sshortUrl = new ShortUrl();
String shortUrl = "";
try {
	if(strPart.equals("enuri") || strPart.equals("car") || strPart.equals("hotdeal") || strPart.equals("depart") || strPart.equals("smart")){
		shortUrl = strUrl;
	}else{
		shortUrl = "m.enuri.com/short/" + sshortUrl.getShortUrl(strUrl);
	}
} catch (Exception e1) {
	System.out.println("Ajax_ListHeader_Sms_Proc.jsp : shortUrl error ");
	return;
}

/* 2014.01.08. 문자 형식 수정 */
String Msg = "";
if(strPart.equals("enuri") || strPart.equals("car") || strPart.equals("hotdeal") || strPart.equals("depart") || strPart.equals("smart")){
	strTitle = "아래 링크로\r\n"+strTitle+" 앱을 설치할\r\n수 있습니다.\r\n\r\n";
}
Msg = "[에누리 가격비교]" + strTitle + " ";
Msg += shortUrl;

//System.out.println(strUrl);
//System.out.println(Msg);

strPhoneNum = strPhoneNum.replaceAll("-", "");

Mobile_TextMessage_Proc TextMessage_Proc = new Mobile_TextMessage_Proc();
TextMessage_Proc.sendTextMessage("", strPhoneNum, Msg);
%>
<script language="javascript">
alert("성공적으로 전송하였습니다.");
</script>