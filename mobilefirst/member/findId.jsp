<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%
/***************************************************
이 파일은 SSL 서버에 업로드해야 합니다.
***************************************************/
%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="keywords" content="휴대폰, 사무, 생활가전, 용품, 영상음향, 컴퓨터, 자동차, 명품, 잡화, 스포츠, 유아, 완구, 가구, 화장품, 식품, 가격비교, 쇼핑몰, 최저가">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>에누리(가격비교) eNuri.com</title>
<link rel="shortcut icon" href="/images/member/page/favicon_enuri.ico">
<script type="text/javascript" src="/common/js/lib/jquery-1.9.1.min.js"></script>
<!-- <link rel="stylesheet" type="text/css" href="http://imgenuri.enuri.gscdn.com/common/css/eb/default_main.css">
<link rel="stylesheet" type="text/css" href="http://imgenuri.enuri.gscdn.com/common/css/eb/common_main.css"> -->
<link rel="stylesheet" href="/css/default.css" type="text/css">
<link rel="stylesheet" href="/css/member.css" type="text/css"> <!-- [D] 작업 CSS -->
<script type="text/javascript" src="/member/js/findId.js"></script>
</head>
<body>
<!-- 회원가입 WRAP -->
<div class="member_wrap">
	<!-- Member Header -->
	<div class="mb_header">
		<!-- container -->
		<div class="container">
			<h1 class="logo"><a href="http://enuri.com/"><img src="/images/member/page/enuri_logo.gif" alt="ENURI 로고" /></a></h1>

			<div class="tabs t2"><!-- 탭 2개일 때 class="t2" 추가 -->
				<ul>
					<!-- 활성화 class="active" -->
					<li><a href="/member/login/findId.jsp" class="active">아이디 찾기</a></li>
					<li><a href="/member/login/findPw.jsp">비밀번호찾기</a></li>
				</ul>
			</div>
		</div>
		<!-- //container -->
	</div>

	<!-- Member Content -->
	<div class="mb_content">
		<!-- container -->
		<form id="findIdForm"  name="findIdForm" method="post" action="findIdResult.jsp">
		<div class="container">
			<div class="join_form">
					<fieldset>
						<legend>아이디 찾기, 회원찾기</legend>
						
						<!-- row section -->
						<div class="lr_box">
							<p class="info_txt2">회원정보에 등록되어 있는 정보로 아이디의 일부를 찾으실 수 있습니다.</p>
						</div>
						<div class="row_group">
							<div class="row">
								<div class="jr_box two_col">
									<label for="SAME_ID" class="th">회원정보 선택</label>
									<div class="radio_area td infochk"> 
										<ul>
											<li>
												<input type="radio" id="opt1_1"  value="hp"  name="mallsel_1" checked="checked" onclick="hpEmailChk(this);">
												<label for="opt1_1" id="opt1_1_1" class="chkd">휴대폰 번호</label>
												<div class="check"></div>
											</li>
											<li>
												<input type="radio" id="opt1_2"  value="email" name="mallsel_1"  onclick="hpEmailChk(this);">
												<label for="opt1_2"  id="opt1_1_2">이메일 주소</label>
												<div class="check"><div class="inside"></div></div>
											</li>
										</ul>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="jr_box two_col">
									<label for="SAME_ID" class="th">이름</label>
									<div class="ipt_area td">
										<input type="text" id="input_name"  name="input_name" class="ipt" value="" maxlength="" />
									</div>
								</div>
							</div>
							<div class="row">
								<div class="jr_box two_col">
									<label for="SAME_ID" class="th" id="chk_input_text">휴대폰번호</label>
									<div class="ipt_area td">
										<input type="text" id="input_hp_email" name="input_hp_email" class="ipt" value="" maxlength="" />
									</div>
								</div>
							</div>
						</div>

						<!-- //row section -->
					</fieldset>
							
			</div>

			<!-- BTN 영역 -->
			<div class="btn_group">
				<div><a href="javascript:void(0);" onClick="formSubmit();" class="btn btn_lg active" id="findid_btn">확인</a></div>
			</div>
			<!-- //BTN 영역 -->
			<div class="lr_box">
				<p class="caution"><span>*</span>휴면 회원은 아이디/비밀번호 찾기가 제한되오니 새로운 아이디로 다시 가입해<br />주시기 바랍니다.</p>
			</div>
		</div>		
		<!-- //container -->
</form>	
	</div>
	<!-- //Member Content -->

	<!-- Member Footer -->
	<jsp:include page="/member/include/IncMemberFooter.jsp" />
</div>
<!-- //회원가입 WRAP -->

<script>
$(".pw_hint").click(function(e){
	e.preventDefault();
	$(this).siblings("#hintLayer").show();
});
</script>

</body>
</html>