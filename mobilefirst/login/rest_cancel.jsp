<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="org.apache.commons.lang3.StringUtils"%>
<%
	String userId = StringUtils.defaultString(request.getParameter("userid"));
	String backUrl = StringUtils.defaultString(request.getParameter("backUrl"));
	String appYN = StringUtils.defaultString(request.getParameter("app"));
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/default.css">
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
	<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		//런칭할때 UA-52658695-3 으로 변경
		ga('create', 'UA-52658695-3', 'auto');

		var vTitle = "휴면 해제 신청";

		// 안드로이드 헤더용...
		if(window.android){
			android.getTitle(vTitle);
		}

	</script>
</head>
<body>
	<div id="memberWrap">
		<%if(!appYN.equals("Y")){%>
		<div class="pageHead">
			<h1>휴면 해제 신청</h1>
		<a href="javascript:///" class="back" onclick="backButton()"></a></div>
		<%}%>
		<div id="container">
			<fieldset class="rest">
				<legend>휴면 해제 신청</legend>
				<section class="titField">
					<p class="rest_txt">비밀번호를 입력하신 후, 완료 버튼을 누르시면<br />휴면 해제 신청이 됩니다.</p>
					<ul>
						<li><input type="text" name="name" id="name" title="이름 입력" value="<%=userId%>" readonly ></li>
						<li><input type="password" name="password" id="pw1" placeholder="비밀번호" title="비밀번호"></li>
						<li><input type="password" name="password" id="pw2" placeholder="비밀번호 재확인" title="비밀번호 재확인"></li>
					</ul>
				</section>
				<p class="btnWrap"><a href="javascript:///" class="btnType3">입력완료</a></p>
			</fieldset>
		</div>
	</div>
</body>
<script>

var appYN = "<%=appYN%>";

jQuery(document).ready(function($) {
	$(".btnWrap").click(function(){

		var userId = $("#name").val();

		var pw1 = $("#pw1").val();
		var pw2 = $("#pw2").val();

		if(pw1 == '' ){
			alert("비밀번호를 2번 입력해야 \n 해제 신청이 가능합니다.");
			$("#pw1").focus();
			return false;
		}
		if(pw2 == '' ){
			alert("비밀번호를 2번 입력해야 \n 해제 신청이 가능합니다.");
			$("#pw2").focus();
			return false;
		}
		if(pw1 != pw2){
			alert("입력하신 비밀번호 2개가 \n 일치하지 않습니다.");
			$("#pw1").val('');
			$("#pw2").val('');
			return false;
		}
		var url = "/join/ApplyMemberActive_Proc_Ssl_Mobile.jsp";
		var backUrl = "<%=backUrl%>"+"";
		$.ajax({
		url: url,
		data : {app_userid : userId , app_pwd1: pw1 , app_pwd2: pw2} ,
		dataType: 'json',
		success: function(data){
				if(data.rtnCode == "1"){
					alert("휴면 해제 신청 완료!\n "+data.iOk_Month+"월 "+data.iOk_Day+"일 6시 이후에 로그인이 가능합니다.\n감사합니다.");

					if(backUrl.indexOf("deal/mobile/main.deal") > -1){
						location.replace("/deal/mobile/main.deal");
					}else{
						backButton();
					}

				}else if(data.rtnCode == "2"){
					alert("이미 휴면 해제 신청한 상태입니다.\n조금만 기다려 주시면\n"+data.iOk_Month+"월 "+data.iOk_Day+"일 6시 부터 로그인이 가능합니다.");

					if(backUrl.indexOf("deal/mobile/main.deal") > -1){
						location.replace("/deal/mobile/main.deal");
					}else{
						if(appYN == "Y"){
							location.href = "close://"
						}else{
							location.replace("/mobilefirst/Index.jsp");
						}
					}

				}else if(data.rtnCode == "3"){
					alert("비밀번호를 잘못 입력하셨습니다.\n다시 확인해주세요.");
					$("#pw1").val('');
					$("#pw2").val('');

				}else if(data.rtnCode == "99"){
					alert("휴면중인 계정이 아닙니다.");

				}else if(data.rtnCode == "98"){		//휴면2
					location.href = "/mobilefirst/member/myAuth.jsp?cmdType=uft&freetoken=login_title&app=<%=appYN%>";
				}

			}
		});
	});
});
function backButton(){
	if(appYN == "Y"){
		location.href = "close://"
	}else{
		history.back(-1);
	}
}
</script>
</html>