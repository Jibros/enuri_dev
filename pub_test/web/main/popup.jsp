<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>\
<html>
<head>
<meta charset="utf-8">
<META NAME="description" CONTENT="최저가 에누리 - 가격비교 사이트 에누리닷컴입니다.">
<META NAME="keyword" CONTENT="휴대폰, 사무, 생활가전, 용품, 영상음향, 컴퓨터, 자동차, 명품, 잡화, 스포츠, 유아, 완구, 가구, 화장품, 식품, 가격비교, 쇼핑몰, 최저가">
<meta name="format-detection" content="telephone=no">
<link rel="shortcut icon" href="http://img.enuri.info/2014/layout/favicon_enuri.ico">
<title>공지사항 - 에누리(가격비교) eNuri.com</title>
<link rel="stylesheet" href="http://dev.enuri.com/main/main1003/css/main.css" type="text/css">
<script language="javascript">
	function closeWindow(){
		top.window.opener = top;
		top.window.open('','_parent', '');
		top.window.close();
	}
	function notToSeeAgain(){
		setCookie("NotToSeeAgain", "Y", 30);
		closeWindow();
	}
	
	function deleteCookie() {
		setCookie('NotToSeeAgain', '', -1);
		closeWindow();
	}

	function setCookie(cName, cValue, cDay){
		var expire = new Date();
		expire.setDate(expire.getDate() + cDay);
		cookies = cName + '=' + escape(cValue) + '; path=/ '; 
		if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
		document.cookie = cookies;
	}
</script>
<body>

<!-- popup size 445*540 -->
<div class="terms_popup">
	<h1>에누리 이용약관 개정 안내</h1>
	<a href="javascript:closeWindow();" class="close">창닫기</a>
	<div class="terms_box">
		<p>안녕하세요. 에누리 가격비교입니다.<br />고객님의 보다 편리한 서비스 이용을 돕기 위해<br /><strong>2016년 09월 05일(월요일)</strong>부터 에누리 이용약관과 e머니 이용약관이<br />아래와 같이 전면 개정될 예정입니다.</p>
		
		<h2>에누리 이용약관<span class="view" onclick="window.open('/faq/customer_info.jsp?faq_type=3&faq_seq_ad=130','_blank');">변경내용 자세히보기</span></h2>
		<ul class="terms_txt">
			<li>에누리에서 제공하는 서비스 정의 보완</li>
			<li>개인정보취급방침 개정(시행일: 2016.08.12)에 따른 관련 조항 변경</li>
			<li>광고 서비스 제공을 위한 조항 신설</li>
			<li>“에누리 오픈마켓” 서비스 종료에 따른 관련 조항 삭제</li>
		</ul>

		<h2>e머니 이용약관<span class="view" onclick="window.open('/faq/customer_info.jsp?faq_type=3&faq_seq_ad=131','_blank');">변경내용 자세히보기</span></h2>
		<ul class="terms_txt">
			<li>e머니(리워드서비스)에 대한 정의 및 정책 보완</li>
			<li>약관 변경에 따른 사전 공지기간 변경</li>
		</ul>

		<p>이용약관에 대한 문의는 고객센터로 접수해 주시길 바라며,<br />개정된 내용에 동의하지 않으시는 경우, 회원탈퇴를 요청하실 수 있습니다.</p>
		<div class="btnarea"><a href="javascript:notToSeeAgain();">다시보지 않기</a><a href="javascript:closeWindow();">닫기</a></div>
	</div>
</div>

</body>
</html>