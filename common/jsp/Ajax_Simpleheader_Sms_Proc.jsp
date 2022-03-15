<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.bean.main.App_Sms_Send_Proc"%>
<jsp:useBean id="App_Sms_Send_Proc" class="com.enuri.bean.main.App_Sms_Send_Proc" scope="page" />
<%
String userip = request.getRemoteAddr();

try{
	String procType = ChkNull.chkStr(request.getParameter("procType"));
	String phoneno = ChkNull.chkStr(request.getParameter("phoneno"));
	
	DateFormat sdFormat = new SimpleDateFormat("yyyyMMdd");
	Date nowDate = new Date();
	String strToday = sdFormat.format(nowDate);
	
	int intSendCnt = App_Sms_Send_Proc.getSmsSendCheck(userip, strToday, "");
	
	String strShoturl = "http://goo.gl/O8CUnn";
	String strAppnm = "에누리가격비교";
	if(procType.equals("1")){
		 strShoturl = "http://goo.gl/O8CUnn";
		 strAppnm = "에누리가격비교";
	}else if(procType.equals("2")){
		 strShoturl = "http://goo.gl/muoqQ9";
		 strAppnm = "신차비교";
	}else if(procType.equals("3")){
		 strShoturl = "http://goo.gl/j62WKU";
		 strAppnm = "스마트핫딜";
	}else if(procType.equals("4")){
		 strShoturl = "http://goo.gl/DnOOjo";
		 strAppnm = "스마트택배";
	}
	
	//System.out.println("procType>"+procType);
	//System.out.println("phoneno>"+phoneno);
	//System.out.println("intSendCnt>"+intSendCnt);
	
	String strMsg = "[에누리닷컴]아래 링크로\r\n"+strAppnm+" 앱을 설치할\r\n수 있습니다.\r\n\r\n"+strShoturl;
	//단문 : https://toll.surem.com:440/message/direct_call_sms_return_post.asp?	usercode=enuritest&deptcode=7F-WIJ-ZG&group_name=01012341234&from_num1=02&from_num2=&from_num3=&to_message=안녕&member=10
	//LMS : https://toll.surem.com:440/message/direct_call_lms_return_post.asp?	usercode=enuritest&deptcode=7F-WIJ-ZG&callphone=01012341234&reqphone=022345678&message=안녕&member=1234
	if(procType.equals("5")){
		strMsg = "[에누리 가격비교]" + "\n";
	    strMsg += "앱 전용 EVENT!" + "\n";
	    strMsg += "앱 설치하고 참여하세요!" + "\n";
		strMsg += "▶ APP 설치하기 : http://goo.gl/O8CUnn" + "\n";
		
		procType = "1";
	}else if(procType.equals("6")){
		strMsg = "[에누리 가격비교]" + "\n";
	    strMsg += "영화 예매권 이벤트!" + "\n";
	    strMsg += "앱 설치하고 참여하세요!" + "\n";
		strMsg += "▶ APP 설치하기 : http://goo.gl/ygK873" + "\n";
		
		procType = "1";
	}else if(procType.equals("7")){ //통합기획전 타임특가 문구 수정
		strMsg = "[에누리 가격비교]" + "\n";
	    strMsg += "앱 전용 타임특가!" + "\n";
	    strMsg += "앱 설치하고 참여하세요!" + "\n";
		strMsg += "▶ APP 설치하기 : http://goo.gl/O8CUnn" + "\n";

		procType = "1";
	}
	
		if(!phoneno.equals("") && phoneno.length()>=10 && phoneno.length()<=11){
			if(intSendCnt > 20){
%>
				<script language='JavaScript'>
				alert("SMS 1일 발송 건이 초과되었습니다.\r\n(1일 최대 20건)");
				</script>
<%
				return;
			}else{
				if(App_Sms_Send_Proc.cmdSmsSendLogInsert(procType, userip)){
%>
					<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
					<html xmlns="http://www.w3.org/1999/xhtml">
					<head>
					<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
					</head>
					<body>
				    <form name="hpCert" action="https://toll.surem.com:440/message/direct_call_lms_return_post.asp" method="post" accept-charset="EUC-KR">
					<input type="hidden" name="member" value="10">
				    <input type="hidden" name="usercode" value="enuritest">
					<input type="hidden" name="deptcode" value="7F-WIJ-ZG">
					<input type="hidden" name="callphone" value="<%=phoneno%>">
					<input type="hidden" name="message" value="<%=strMsg%>">
					<input type="hidden" name="reqphone" value="0263543601">
					<input type="hidden" name="rurl" value="<%=ConfigManager.ENURI_COM%>/common/jsp/Ajax_Simpleheader_Sms_Proc.jsp?phoneno=<%=phoneno%>">
					</form>
					<script language='JavaScript'>
					//document.enctype = "application/x-www-form-urlencoded; charset=euc-kr";
					//alert(navigator.userAgent.toLowerCase());
					if(navigator.userAgent.indexOf("MSIE")>0 || navigator.userAgent.toLowerCase().indexOf("trident")>0) {
						document.charset = "euc-kr";
					}
					var obj = document.hpCert;
					alert("성공적으로 전송하였습니다.");
					obj.submit();
					</script>
					</body>
					</html>
<%
					return;
				}else{
%>
					<script language='JavaScript'>
					alert("오류가 발생하였습니다.");
					</script>
<%
					return;
				}
			}
		}else{
%>
			<script language='JavaScript'>
			alert("휴대폰 번호가 유효하지 않습니다.");
			</script>
<%
			return;
		}
}catch(Exception ex){
}
%>