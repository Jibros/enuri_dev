<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%
//페이지 용도 : 팝업창을 띄우고 form을 팝업창으로 submit하기 원할때
//팝업창 뜨는 속도가 느리면 form이 target을 못찾아 새창으로 submit되는 현상을 해결하기 위해 
String strAfter = ChkNull.chkStr(request.getParameter("after"),"");
System.out.println("strAfter : " + strAfter);
if(strAfter.equals("")){
	return;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script language="javaScript">
function init(){
	try{
		//alert("<%=strAfter%>");
		opener.<%=strAfter%>();
	}catch(e){
		//alert("AAA");
		//location.href="https://check.namecheck.co.kr/checkplus_new_model4/checkplus.cb";
	}
}
</script>
</head>
<body onload="init()">
</body>
</html>