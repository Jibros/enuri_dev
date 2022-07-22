<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
	String strApp = ChkNull.chkStr(request.getParameter("app"),"");	 //	Y일때 앱
	String type = ChkNull.chkStr(request.getParameter("type"),"");	 // 소셜 백화점 구분
%>
<%
	
	String ENURI_COM_SSL = "https://m.enuri.com:442";
	String phoneNum = ChkNull.chkStr(request.getParameter("phoneNum"));
	String name = ChkNull.chkStr(request.getParameter("name"));
	
	String tel1 = "";
	String tel2 = "";
	String tel3 = "";
	
	if(phoneNum.length() == 10){
		tel1 = phoneNum.substring(0,3);  
		tel2 = phoneNum.substring(3,6);  
		tel3 = phoneNum.substring(6,10);  
	}else{
		tel1 = phoneNum.substring(0,3);  
		tel2 = phoneNum.substring(3,7);  
		tel3 = phoneNum.substring(7,11);
	}

%>

<!DOCTYPE html>
<html lang="ko">
<head>

<title>에누리(가격비교) eNuri.com</title>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=yes, target-densitydpi=medium-dpi" name="viewport">
</head>
<%@include file="/mobilefirst/include/common.html"%>
<%@ include file="/mobilefirst/login/login_check.jsp"%>
<%

String user_id = ChkNull.chkStr(Members_Proc.getFindId(name,tel1, tel2, tel3));

%>
<body>
	<div id="memberWrap">
		<div class="pageHead">
			<h1>ID / 비번 찾기</h1>
		</div>
		<div id="container">
			<section class="titField">
				<%if(user_id.equals("")){%>
				<p class="findTxt">입력하신 정보와 일치하는 ID가 없습니다.</p>				
				<%}else{%>
				<h1>ID 조회결과</h1>
				<p class="findTxt">고객님의 ID는 <strong><%=user_id%></strong> 입니다.</p>
				<%}%>
			</section>
			<% if(type.equals("deal")){ %>
			<p class="btnWrap"><a href="javascript:godealLogin()" class="btnType3">확인</a></p>
			<%}else{%>
			<p class="btnWrap"><a href="javascript:goLogin()" class="btnType3">확인</a></p>
			<%}%>
		</div>
	</div>
</body>
</html>
<script>

function godealLogin(){
    document.location.href = "/mobilefirst/login/login.jsp?app=<%=strApp%>&backUrl="+encodeURIComponent("/deal/mobile/main.deal#/home");
}

</script>
<%@ include file="/mobilefirst/include/common_logger.html"%>