<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.member.Login_Proc"%>
<jsp:useBean id="Login_Proc" class="com.enuri.bean.member.Login_Proc"  />
<%
	String strApp = ChkNull.chkStr(request.getParameter("app"),"");	 //	Y일때 앱
	String type = ChkNull.chkStr(request.getParameter("type"), "");
	String strFind = ChkNull.chkStr(request.getParameter("find"), "id");
	String referer = ChkNull.chkStr(request.getHeader("REFERER"), "");
	String strFlow = ChkNull.chkStr(request.getParameter("f"),"");				    // SNS PC(p) , SNS MO(m)
	//boolean isIos = false;
	boolean authReturnInPw = false;
	//APP
	Cookie[] carr = request.getCookies();
	try {
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("appYN")){
		    	strApp = carr[i].getValue();
		    }
		}
	} catch(Exception e) {
	}

	//블랙리스트 페이지 제한 로그  입력 _ start
	String userIp = ChkNull.chkStr(ConfigManager.szConnectIp(request), "");
	String reqUri = ChkNull.chkStr(request.getRequestURI().toString(), "");
	String reqUrl = "";
	String reqDomain =  ChkNull.chkStr(request.getServerName().toString(), "");
	String reqUrlQry = "";
	
	if(request.getServerPort() == 8443){
		reqUrl = "https://"+reqDomain+reqUri;
	}else{
		reqUrl = "http://"+reqDomain+reqUri;
	}

	if(request.getQueryString() != null){
		reqUrlQry = reqUrl+"?"+ ChkNull.chkStr(request.getQueryString().toString(), "");
	}else{
		reqUrlQry = reqUrl;
	}
	
	int hst_no =3;
	
	if(strFind.equals("pw")) { 
		 hst_no = 4; 
	}
	//int iPassCnt = Login_Proc.getPassCnt(userIp, 1);		//1일 
	boolean bPassLog= Login_Proc.insPassLog(hst_no, reqUri, reqUrlQry, "", "", "","", "", 0, userIp, "");
	//블랙리스트 페이지 제한 로그  입력 _ end
	
	
	//REFERER 체크
	//if(referer.isEmpty() || referer.indexOf("login.jsp") < 0){
    	//out.print("비정상적 접근 입니다. ");
		//return;
	//}

	//디바이스가 PC일 경우 해당페이지로 GO
	if(!strApp.equals("Y")){
		if (!((ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Linux") >= 0 ) ||  (ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0))){
			if(strFind.equals("id")){
				response.sendRedirect("/member/login/findId.jsp");
				return;
			}else{
				response.sendRedirect("/member/login/findPw.jsp");
				return;
			} 
		}
	}/* else{
		if((
				ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 
				|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 
				|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0 
			)&& ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0){
			isIos = true;
			if(request.getQueryString().indexOf("freetoken=outlink") < 0){
				//out.println("<script>location.href = '/member/login/findId.jsp?"+request.getQueryString()+"&freetoken=outlink'; </script>");
			    response.sendRedirect("/mobilefirst/member/idpw.jsp?"+request.getQueryString()+"&freetoken=outlink");
				return;	
			}
			
		}
	} */

	//SSL
	String ENURI_COM_SSL = "https://m.enuri.com";

	String serverName = request.getServerName();
	if(serverName.indexOf("stagedev.enuri.com")>-1) {
		ENURI_COM_SSL = "https://"+serverName;
	}else if(serverName.indexOf("100.100.100.151")>-1 || serverName.indexOf("dev.enuri.com")>-1){
		ENURI_COM_SSL = "https://"+serverName;
	}else{
		ENURI_COM_SSL = "https://"+serverName;
	}

%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<script type="text/javascript" src="/common/js/lib/jquery-1.9.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=ENURI_COM_SSL%>/css/home/default.css">
	<!--기존 /css/home/member.css에서 /mobilefirst/css/home/member.css로 변경 -->
	<link rel="stylesheet" type="text/css" href="<%=ENURI_COM_SSL%>/mobilefirst/css/home/member.css?ver=2018"/>
	<link rel="stylesheet" type="text/css" href="/css/mobile_v2/common.css"/>	
	<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		//런칭할때 UA-52658695-3 으로 변경
		ga('create', 'UA-52658695-3', 'auto');
	</script>
</head>
<body>
<div class="memberwrap">
	<header id="header" class="page_header nomargin">
		<div class="header_top">
			<div class="wrap">
				<button href="#" class="btn__sr_back"><i class="icon_arrow_back comm__sprite2">뒤로</i></button>
				<div class="header_top_page_name">ID / 비번 찾기</div>
			</div>
		</div>
	</header>
	<div class="member_tab">
		<ul>
			<li><a href="#idpw01">아이디 찾기</a></li>
			<li><a href="#idpw02">비밀번호 찾기</a></li>
		</ul>
	</div>

	<!-- 아이디찾기 -->
	<div class="idpw_area" id="idpw01">
		<fieldset class="memberfield">
			<legend>아이디찾기</legend>
			<div id="idFormDiv">
				<p class="txt_basic" >회원정보에 등록되어 있는 정보로 아이디의 일부를 찾으실 수 있습니다.</p>
				<div class="myinfo_form">
					<label class="tit">회원정보 선택</label>
					<input type="radio" name="info01" id="mobile" class="in_radio"  checked><label class="chkarea" for="mobile">휴대폰 번호</label>
					<input type="radio" name="info01" id="mail" class="in_radio"><label class="chkarea" for="mail">이메일 주소</label>
				</div>
				<div class="myinfo_form name">
					<label class="tit">이름</label><input type="text" id="idpw01_name" />
				</div>
				<div class="myinfo_form myinfo_form_sub mobile">
					<label class="tit">휴대폰번호</label><input type="number" id="idpw01_phone" placeholder="' - ' 없이 입력" />
				</div>
				<div class="myinfo_form myinfo_form_sub mail" style="display:none;">
					<label class="tit">이메일</label><input type="text" id="idpw01_mail"/>
				</div>
				<button type="submit" class="btn_join" id="btnId_join">확인</button>
			</div>
			<div id="idListDiv" style="display:none;">
				<!-- 아이디조회 -->
				<p class="txt_basic">조회하신 정보로 등록된 아이디는 아래와 같습니다.</p>
				<table class="id_search">
					<thead>
						<tr>
							<th>아이디</th>
							<th>가입일자</th>
						</tr>
					</thead>
				</table>
				<div class="id_list">
					<table class="id_search">
					</table>
				</div>
				<button type="submit" class="btn_join" id="btnId_login">로그인</button>
				<!--// 아이디조회 -->
			</div>
			<p class="txt_basic star">휴면 회원은 아이디/비밀번호 찾기가 제한되오니 새로운 아이디로 다시 가입해 주시기 바랍니다.</p>
		</fieldset>

	</div>

	<!-- PW 찾기 -->
	<div class="idpw_area" id="idpw02" style="display:none;">
<%-- 		<fieldset class="memberfield">
			<legend>아이디찾기</legend>
			<p class="txt_basic"  id="pwTitle">회원정보에 등록되어 있는 휴대폰번호로 인증 후 비밀번호를 재설정 하실 수 있습니다.</p>
			<div class="myinfo_form">
				<label class="tit">찾는방법</label>
				<input type="radio" name="info02" id="mobile_pw" class="in_radio"   checked><label class="chkarea" for="mobile_pw">휴대폰 번호</label>
				<input type="radio" name="info02" id="mail_pw" class="in_radio"><label class="chkarea" for="mail_pw">이메일 주소</label>
				<input type="radio" name="info02" id="my" class="in_radio"><label class="chkarea" for="my">본인인증</label>
			</div>
			<div class="myinfo_form myinfo_form_sub2">
				<label class="tit">아이디</label><input type="text" id="idpw02_id" autocorrect="off" autocomplete="off" autocapitalize="off" />
			</div>
			<div class="myinfo_form myinfo_form_sub2">
				<label class="tit">이름</label><input type="text" id="idpw02_name"autocorrect="off" autocomplete="off" autocapitalize="off" />
			</div>
			<div class="myinfo_form myinfo_form_sub2_1 mail_pw" style="display:none;">
				<label class="tit">이메일</label><input type="text" id="idpw02_mail"autocorrect="off" autocomplete="off" autocapitalize="off" />
			</div>
			<div class="myinfo_form myinfo_form_sub2_1 mobile_pw">
				<label class="tit">휴대폰번호</label><span class="adr"><input type="number" id="idpw02_phone" autocorrect="off" autocomplete="off" autocapitalize="off" placeholder="' - ' 없이 입력" /><a href="javascript:///" >인증요청</a></span>
			</div>
			<div class="myinfo_form myinfo_form_sub2_1 mobile_pw">
				<label class="tit">인증번호</label><input type="text" id="idpw02_auth" autocorrect="off" autocomplete="off" autocapitalize="off" placeholder="인증번호 입력" />
			</div>
			<button type="submit" class="btn_join" id="btnPw_join">확인</button>
			<button type="submit" class="btn_join" id="btnPw_auth" style="display:none;"><em class="m">휴대폰 본인인증</em></button>
			<p class="txt_basic star">휴면 회원은 아이디/비밀번호 찾기가 제한되오니 새로운 아이디로 다시 가입해 주시기 바랍니다.</p>
			--%>
		<fieldset class="memberfield" id="idpw02_top">
			<legend>비밀번호찾기</legend>
			<p class="txt_basic">회원정보에 등록되어 있는 휴대폰번호로 인증 후 비밀번호를 재설정 하실 수 있습니다.</p>
			<div class="myinfo_form">
				<label class="tit">찾는방법</label>
				<input type="radio" name="info02" id="mobile_pw" class="in_radio"   checked><label class="chkarea" for="mobile_pw">휴대폰 번호</label>
				<input type="radio" name="info02" id="mail_pw" class="in_radio"><label class="chkarea" for="mail_pw">이메일 주소</label>
				<input type="radio" name="info02" id="my" class="in_radio"><label class="chkarea" for="my">본인인증</label>
			</div>
			<!-- 휴대폰 번호, 이메일 주소 -->
			<div class="myinfo_form _ver2 no_b-bottom">
				<div class="id_inputbox">
					<input type="text"  id="idpw02_id_mobile" autocorrect="off" autocomplete="off" autocapitalize="off" placeholder="아이디" />
					<input type="text"  id="idpw02_id_email" autocorrect="off" autocomplete="off" autocapitalize="off" placeholder="아이디" style="display:none;"/>
					<a  id="idpw02_id_chk" href="javascript:///" >확인</a>
				</div>
			</div>
			<div class="myinfo_form _ver2 no_b-top">
				<label class="tit">등록된 번호</label>
				<p class="txt_info" id = "txt_info_phone">아이디 입력 후 '확인'을 눌러주세요</p>
				<p class="txt_info" id = "txt_info_mail" style="display:none;">아이디 입력 후 '확인'을 눌러주세요</p>
				<!-- <p class="txt_info"><strong class="emp">ab******@na******.com</strong></p>
				<!-- <p class="txt_info"><strong class="emp">등록된 이메일이 없습니다.</strong></p> -->
			</div>
			<!-- 본인인증 -->
			<div class="myinfo_form _ver2 _full" style="display:none;">
				<input type="text" id="txt_info_auth" autocorrect="off" autocomplete="off" autocapitalize="off" placeholder="아이디" />
			</div>

		</fieldset>

		<fieldset class="memberfield" id="idpw02_bottom">
			<p class="txt_basic border-top">등록된 번호와 입력한 번호가 같아야 인증번호를 받을 수 있습니다.</p>

			<div class="myinfo_form _ver2 mobile_pw">
				<div class="id_inputbox" id="idpw02_phone_auth">
					<input type="number" id="idpw02_phone" autocorrect="off" autocomplete="off" autocapitalize="off" placeholder="휴대폰번호 ('-' 제외하고 입력)" />
					<a href="javascript:///" >인증요청</a>
				</div>
			</div>
			<div class="myinfo_form _ver2 _full mobile_pw">
				<div class="id_inputbox">
					<input type="text" id="idpw02_auth" autocorrect="off" autocomplete="off" autocapitalize="off" placeholder="인증번호 입력" />
				</div>
			</div>
			<div class="myinfo_form _ver2 _full mail_pw" style="display:none;">
				<div class="id_inputbox">
					<input type="text" id="idpw02_mail" autocorrect="off" autocomplete="off" autocapitalize="off" placeholder="이메일 이메일을 입력해 주세요." />
				</div>
			</div>
			<button type="submit" id="btnPw_join" class="btn_join">확인</button>

			<p class="txt_basic star">휴면 회원은 아이디/비밀번호 찾기가 제한되오니 새로운 아이디로 다시 가입해 주시기 바랍니다.</p>
		</fieldset>
		<fieldset class="memberfield" id="idpw02_bottom_auth" style="display:none;">
			<button type="submit" id="btnPw_auth" class="btn_join"><em class="m">휴대폰 본인인증</em></button>
			<p class="txt_basic star">휴면 회원은 아이디/비밀번호 찾기가 제한되오니 새로운 아이디로 다시 가입해 주시기 바랍니다.</p>
		</fieldset>
	</div>
	<form id="joinForm"  name="joinForm"  method="post" action="/mobilefirst/member/pw.jsp">
		<input type="hidden" name="cs_tel" id="cs_tel" value="">
		<input type="hidden" name="tel1">
		<input type="hidden" name="tel2">
		<input type="hidden" name="tel3">
		<input type="hidden" name="certify">
		<input type="hidden" name="isChecked">
		<input type="hidden" name="yyyymmdd_user">
		<input type="hidden" name="sex_user">
		<input type="hidden" name="userId" id="userId2" >

		<input type="hidden" name="hp_input_hidden_value" id="hp_input_hidden_value">
		<input type="hidden" name="conf_ci_key" id="conf_ci_key">
		<input type="hidden" name="conf_di_key" id="conf_di_key">
		<input type="hidden" name="conf_yyyymmdd">
		<input type="hidden" name="conf_sex">
		<input type="hidden" name="conf_phoneco">
		<input type="hidden" name="conf_date">
		<input type="hidden" id="app" name="app" value="<%=strApp%>"/>
	</form>
	<form id="joinForm2"  name="joinForm2"  method="post" action="/member/ajax/findpw_send_mail.jsp">
		<input type="hidden" name="userId">
		<input type="hidden" name="userNm">
		<input type="hidden" name="mailAddr">
		<input type="hidden" name="input_name">
		<input type="hidden" name="input_hp_email">
		<input type="hidden" name="mallsel_1">
	</form>
</div>

<div class="dim" id="post" style="display:none;">
	<div class="adr_search">
		<button class="btnClose" type="button" onclick="$('#post').hide();">주소검색 창 닫기</button>
		<h2>에누리 가격비교</h2>
			<div class="adrarea">
				<p class="noticed">본인인증에 성공하였습니다.</p>
			</div>
			<div class="layerBtn">
				<button class="btnTxt" type="button" onclick="$('#post').hide(); $( '.btnzzim' ).removeClass( 'on' );">닫기</button>
			</div>
	</div>
</div>

<iframe name=urlCheck width=0 height=0 frameborder=0 marginheight=0 marginwidth=0 scrolling=auto style=visible:false></iframe>
</body>

<script type="text/javascript">

		$("#idpw01_name").bind("keydown", function(){
			var target = $("#idFormDiv").find("input[type!='hidden'], text");
			var id= this.id;
			var key = event.keyCode;

			if(key == 13){
				if($("#mobile").is(":checked")){
					$("#idpw01_phone").focus();
				}else if($("#mail").is(":checked")){
					$("#idpw01_mail").focus();
				}
			}
		});

		$(".myinfo_form_sub").bind("keydown", function(){
			var target = $("#idFormDiv").find("input[type!='hidden'], text");
			var id= this.id;
			var key = event.keyCode;

			if(key == 13){
				$("#btnId_join").click();
			}
		});

		$("#idpw02_id_mobile,#idpw02_id_email").bind("keydown", function(){
			var target = $("#idpw02").find("input[type!='hidden'], text");
			var id= this.id;
			var key = event.keyCode;

			if(key == 13){
				if($("#mobile_pw").is(":checked") || $("#mail_pw").is(":checked")){
					$("#idpw02_id_chk").click();	// 아이디 확인버튼 클릭
				}else if($("#my").is(":checked")){
					$("#btnPw_auth").click();
				}
			}
		});

		/* 개편 버전에서는 이름 입력 칸이 없음 */
		/* $("#idpw02_name").bind("keydown", function(){
			var target = $("#idpw02").find("input[type!='hidden'], text");
			var id= this.id;
			var key = event.keyCode;

			if(key == 13){
				if($("#mobile_pw").is(":checked")){
					$("#idpw02_phone").focus();
				}else if($("#mail_pw").is(":checked")){
					$("#idpw02_mail").click();
				}
			}
		}); */

		$("#idpw02_mail").bind("keydown", function(){
			var target = $("#idpw02").find("input[type!='hidden'], text");
			var id= this.id;
			var key = event.keyCode;

			if(key == 13){
				$("#btnPw_join").click();
			}
		});

		$("#idpw02_phone").bind("keydown", function(){
			var target = $("#idpw02").find("input[type!='hidden'], text");
			var id= this.id;
			var key = event.keyCode;

			if(key == 13){
				$("#idpw02_phone_auth  a").click();
			}
		});

		$("#idpw02_auth").bind("keydown", function(){
			var target = $("#idpw02").find("input[type!='hidden'], text");
			var id= this.id;
			var key = event.keyCode;

			if(key == 13){
				$("#btnPw_join").click();
			}
		});

		var vApp = "<%=strApp%>";
		var vFind = "<%=strFind%>";

		var ENURI_SSL = "<%=ENURI_COM_SSL%>";

		if(vApp == "Y"){
			$("h1").hide();
		}

		var submitClickFlag = false;
		var idCheckInPw = false; //비밀번호 찾기에서 아이디 체크 여부
		var useridInPw = "";	//비밀번호 찾기의 휴대폰번호, 이메일주소에서 확인된 아이디
		var phoneAuth = false;	//비밀번호 찾기의 휴대폰 번호에서 휴대폰 인증 여부
		$(document).ready(function() {
			//tab
			if(vFind == "pw"){
				$(".idpw_area").hide();
				$(".member_tab li:last").addClass("on").show();
				$("#idpw02").show();
			}else{
				$(".idpw_area").hide();
				$(".member_tab li:first").addClass("on").show();
				$("#idpw01").show();
			}

			/**
			 * 비밀번호 찾기의 아이디 확인 버튼 클릭
			 * 2018-03-02 pianohsj1
			 */

			$("#idpw02_id_chk").click(function(){
				var action = "/mobilefirst/member/findpw_id_chk.jsp";
				var checkedRadioId = $("input[name=info02]:checked").attr("id");
				var idValue = "";
				if(checkedRadioId == "mobile_pw"){
					idValue = $("#idpw02_id_mobile").val();
				}else if(checkedRadioId == "mail_pw"){
					idValue = $("#idpw02_id_email").val();
				}
				var form_data = {
						userId: idValue,
						kind: checkedRadioId,
						authType: "idCheck"
					};
				if(!idValue){
					alert("아이디를 입력하세요.");
					$("#idpw02 .txt_info").text("아이디 입력 후 ‘확인’을 눌러주세요");
					idCheckInPw = false;
					useridInPw = "";
					return ;
				}
				/* if(checkedRadioId == "mail_pw"){
					if(!($("#idpw02_id").val())){
						alert("이메일을 입력해주세요.");
						$("#idpw02 .txt_info").text("아이디 입력 후 ‘확인’을 눌러주세요");
						idCheckInPw = false;
						useridInPw = "";
						return ;
					}
				} */
				$.ajax({
					type: "POST",
					data: form_data,
					url: action,
					dataType:"JSON",
					success: function(json){
						if(json.getPhoneNEmailByIdCheckInPw){
							 idCheckInPw = false;
							 useridInPw = "";
							 $.each(json.getPhoneNEmailByIdCheckInPw , function(i,v){
								 if(v.idCheckValueInPw == "1"){
									 if(checkedRadioId == "mobile_pw"  && v.phoneNum){
										 alert("아이디가 확인되었습니다.");
										 $("#txt_info_phone").text(""+v.phoneNum+"");
										 idCheckInPw = true;
										 useridInPw = v.userid;
										 $("#userId2").val(v.userid);
									 }else if(checkedRadioId == "mail_pw"  && v.email){
										 alert("아이디가 확인되었습니다.");
										 $("#txt_info_mail").text(""+v.email+"");
										 idCheckInPw = true;
										 useridInPw = v.userid;
									 }else{
										 alert("잘못된 경로입니다.");
									 }
								 }else if(v.idCheckValueInPw == "2"){
									if(checkedRadioId == "mobile_pw"){
										$("#txt_info_phone").text("등록된 휴대폰 번호가 없습니다.");
									}else if(checkedRadioId == "mail_pw"){
										alert("아이디가 확인되었습니다.");
										$("#txt_info_mail").text("등록된 이메일이 없습니다.");
									}
								 }else if(v.idCheckValueInPw == "0"){
									 alert("입력하신 아이디를 찾을 수 없습니다.")
									 $("#idpw02 .txt_info").text("아이디 입력 후 ‘확인’을 눌러주세요");
								 }else if(v.idCheckValueInPw == "3"){
										var conf = confirm("의심스러운 로그인 활동이 감지되어 "+v.userid+"계정이 일시적으로 잠금 처리되었습니다. 해제하시려면, '해제하기' 또는 고객센터로 문의주세요. 해제하시겠습니까?");
										if(conf){
											window.open("/member/unlock/unlock_mo.jsp");
										}else{
											return false;
										}
								 }else{
									 alert("잘못된 경로입니다.");
								 }

							 });
						}

					},
					complete:function(){
					/* 	if(vList){
							$("#idFormDiv").hide();
							$("#idListDiv").show();
						}else{
							alert("입력하신 정보와\n일치하는 회원정보가 없습니다.");
						}			 */
					}
				});
			});

			$(".member_tab li").click(function() {
				$(".member_tab li").removeClass("on");
				$(this).addClass("on");
				$(".idpw_area").hide();
				var activeTab = $(this).find("a").attr("href");
				$(activeTab).fadeIn();

				$("#idFormDiv").show();
				$("#idListDiv").hide();

				return false;
			});
			$("#idpw01 .myinfo_form .in_radio").click(function(){
				var formthis = this.id;

				$("#idpw01 .myinfo_form_sub").hide();
				$("."+formthis).show();
			});

			$("#idpw02 .myinfo_form .in_radio").click(function(){
				var formthis = this.id;

				if(formthis == "mobile_pw"){
					$("#pwTitle").text("회원정보에 등록되어 있는 휴대폰번호로 인증 후 비밀번호를 재설정 하실 수 있습니다.");
				}else if(formthis == "mail_pw"){
					$("#pwTitle").text("회원정보에 등록되어 있는 이메일로 새로운 비밀번호를 보내드립니다.");
				}else if(formthis == "my"){
					$("#pwTitle").text("본인인증 한 회원에 한해 비밀번호를 재설정 하실 수 있습니다..");
				}

				//$("#idpw02 .btn_join").hide();

				if(formthis == "my"){
					/* $("#idpw02 .myinfo_form_sub2").hide();
					$("#idpw02 .myinfo_form_sub2_1").hide();
					$("#idpw02_id").show();
					$("#idpw02 .myinfo_form_sub2:first").show();
					$("#idpw02 .btn_join:last").show(); */
					$("#idpw02_top .no_b-top").hide();
					$("#idpw02_top .no_b-bottom").hide();
					$("#idpw02_top ._full").show();
					$("#idpw02_bottom").hide();
					$("#idpw02_bottom_auth").show();
				}else{
					/* $("#idpw02 .myinfo_form_sub2_1").hide();
					$("#idpw02 .myinfo_form_sub2").show();
					$("."+formthis).show();
					$("#idpw02 .btn_join:first").show();  */
					$("#idpw02_top .no_b-top").show();
					$("#idpw02_top .no_b-bottom").show();
					$("#idpw02_top ._full").hide();
					if(formthis == "mobile_pw"){
						$("#txt_info_phone").show();
						$("#txt_info_mail").hide();
						$(".mail_pw").hide();
						$(".mobile_pw").show();
						$("#idpw02_id_email").hide();
						$("#idpw02_id_mobile").show();
						$("#idpw02_top .no_b-top label").text("등록된 번호");
					}else if(formthis == "mail_pw"){
						$("#txt_info_mail").show();
						$("#txt_info_phone").hide();
						$(".mobile_pw").hide();
						$(".mail_pw").show();
						$("#idpw02_id_mobile").hide();
						$("#idpw02_id_email").show();
						$("#idpw02_top .no_b-top label").text("등록된 이메일");
					}
					$("#idpw02_bottom").show();
					$("#idpw02_bottom_auth").hide();
				}
			});

			$("#btnId_login").click(function(){
				if(vApp == "Y"){
					window.open("close://");
				}else{
					document.location.href = "/member/login/login.jsp";
				}
			});

			$("#btnId_join").click(function(){
				if($("#mobile").is(":checked")){
					ga('send', 'event', 'mf_member_find', 'find_id', 'find_id_휴대폰번호');
				}else if($("#mail").is(":checked")){
					ga('send', 'event', 'mf_member_find', 'find_id', 'find_id_이메일주소');
				}

				var vData = "";
				var user_nm = $("#idpw01_name").val();
				var user_phone = $("#idpw01_phone").val();
				var user_mail = $("#idpw01_mail").val();
				var template = "";
				var vList = false;

				if(user_nm == ""){
					alert("이름을 입력해주세요");
					return;
				}
				if(user_phone == "" && $("#mobile").is(":checked")){
					alert("휴대폰 번호를 입력해 주세요.");
					return;
				}
				if($("#mail").is(":checked")){
					if(user_mail == ""){
						alert("이메일을 입력해 주세요.");
						return;
					}
					if(user_mail.indexOf("@") < 0 && user_mail.indexOf(".") < 0){
						alert("이메일을 확인해주세요");
						return;
					}
				}
				$(".id_list .id_search").html("");

				/*if($("#mobile").is(":checked")){
					vData = "input_name="+user_nm+"&input_hp_email="+user_phone+"&mallsel_1=hp";
				}else if($("#mail").is(":checked")){
					vData = "input_name="+user_nm+"&input_hp_email="+user_mail+"&mallsel_1=";
				}
				*/
				$("#joinForm2").attr("action", "/mobilefirst/member/findId_ajax.jsp");
				var action = $("#joinForm2").attr("action");

				if($("#mobile").is(":checked")){
					var form_data = {
							input_name: user_nm,
							input_hp_email: user_phone,
							mallsel_1: "hp"
						};
				}else if($("#mail").is(":checked")){
					var form_data = {
							input_name: user_nm,
							input_hp_email: user_mail,
							mallsel_1: ""
						};
				}
				//var loadUrl = "/member/ajax/findpw_send_mail.jsp?";
				//loadUrl+="userId="+userid+"&userNm="+name+"&mailAddr="+email+"&isMobile=Y";
				$.ajax({
					type: "POST",
					url: action,
					data: form_data,
					dataType:"JSON",
					success: function(json){
						template += "<tbody>";
						for(i = 0; i < json.idList.length;  i++){
							template += "	<tr>";
							template += "		<td>"+json.idList[i].userid+"</td>";
							template += "		<td>"+json.idList[i].regdt+"</td>";
							template += "	</tr>";
						}
						template += "</tbody>";
						$(".id_list .id_search").html(template);

						if(json.idList.length > 0){
							vList = true;
						}
					},
					complete:function(){
						if(vList){
							$("#idFormDiv").hide();
							$("#idListDiv").show();
						}else{
							alert("입력하신 정보와\n일치하는 회원정보가 없습니다.");
						}
					}
				});
			});

			//휴대폰 인증요청
			$("#idpw02_phone_auth a").click(function(){
				/*$("#idpw02_auth").val("");

				 var phoneNum = $("#idpw02_phone").val();
				var userid = $("#idpw02_id").val();
				var name = $("#idpw02_name").val();

				if(userid == ""){
					alert("아이디를 입력해주세요");
					return;
				}

				if(name == ""){
					alert("이름을 입력해주세요");
					return;
				}

				if(phoneNum == ""){
					alert("휴대폰 번호를 입력해 주세요.");
					return;
				} */
				$("#idpw02_auth").val("");
				var phoneNum = $("#idpw02_phone").val();
				var checkedRadioId = $("input[name=info02]:checked").attr("id");
				var rtnValue = false;
				if(!idCheckInPw){
					alert("아이디를 확인해주세요.");
					return;
				}
				if(phoneNum == ""){
					alert("휴대폰 번호를 입력해주세요.");
					return;
				}

				var action = "/mobilefirst/member/findpw_id_chk.jsp";
				var form_data = {
					userId: useridInPw,
					kind: checkedRadioId,
					value: phoneNum,
					authType: "authCheck"
				};
				$.ajax({
					type: "POST",
					url: action,
					data: form_data,
					dataType:"JSON",
					success: function(json){
						if(json.getPhoneNEmailByIdCheckInPw){
							$.each(json.getPhoneNEmailByIdCheckInPw , function(i,v){
								if(v.returnValue == "true"){
									rtnValue = true;
								}
							});
						}
					},
					complete:function(){
						if(rtnValue){
							document.hFrame.location.href = "/mobilefirst/member/hpAuth_ajax.jsp?cs_tel="+phoneNum+"&type=pw&enuri_id="+useridInPw;
							phoneAuth = true;
						}else{
							alert("입력한 정보에 해당하는 회원정보가 없어 인증번호를 발송할 수 없습니다.");
							return;
						}
					}
				});


				/*
				var winObj = null;
				var theUrl = "/mobilefirst/member/hpAuth_ajax.jsp?cs_tel="+phoneNum+"&type=pw&enuri_id="+userid;//팝업창 호출할 페이지 이름
				var winName = "urlCheck";//iframe의 name이다.
				var features = "width=0 height=0 menubar=no status=no"; //이건 뭐 대충...

				winObj = window.open(theUrl,winName,features);
				*/




				/* var url = "/mobilefirst/member/hpAuth_ajax_new.jsp";
				var vData = {cs_tel : phoneNum, type : "pw", enuri_id : userid};

				$.ajax({
			        type: "POST",
			        url: url,
			        data: vData,
			        dataType: "JSON",
				  	async: false,
			        success: function(result){
			        	var result = result.result;
			        	if(result == -1){
			        		alert("인증번호 전송은 1일 10회로 제한됩니다. 내일 다시 이용해주세요");
			        	}else if(result == -2){
			        		alert("잘못된 전화번호입니다. 숫자만 정확히 입력해 주세요.");
			        		document.getElementById("sendHp").focus();
			        	}else if(result == -3){
			        		alert("이미 등록된 전화번호입니다. 다른 번호를 입력하세요.");
			        	}else if(result == -4){
			        		alert("인증번호를 받을 수 없는 전화번호 입니다.\n전화번호를 다시 확인해주세요. ");
			        	}else if( result == 1){
			        		alert("인증번호가 카카오 알림톡으로 발송되었습니다.\n(알림톡 수신 불가 시 입력하신 번호로 SMS가 발송됩니다.)");
			        	}else{
			        		alert("일시적인 오류입니다.");
			        	}
			        }
				});  */

			});

			$("#btnPw_join").click(function(){

				if($("#mobile_pw").is(":checked")){
					ga('send', 'event', 'mf_member_find', 'find_PW', 'find_pw_휴대폰번호');

					/* var cerNum = $("#idpw02_auth").val();
					var phoneNum = $("#idpw02_phone").val();
					var userid = $("#idpw02_id").val();
					var name = $("#idpw02_name").val();

					if(userid == ""){
						alert("아이디를 입력해주세요");
						return;
					}

					if(name == ""){
						alert("이름을 입력해주세요");
						return;
					}

					if(cerNum == ""){
						alert("인증번호를 입력해 주세요.");
						return;
					}*/

					var cerNum = $("#idpw02_auth").val();
					var phoneNum = $("#idpw02_phone").val();

					if(!idCheckInPw){
						alert("아이디를 확인해주세요.");
						return;
					}
					if(!phoneNum){
						alert("휴대폰 번호를 입력해주세요.");
						return;
					}
					if(!phoneAuth){
						alert("인증요청을 해주세요.");
						return;
					}
					if(!cerNum){
						alert("인증번호를 입력해주세요.");
						return;
					}

				 	var loadUrl = "/mobilefirst/member/hpAuthSendProc_ajax.jsp?";
						//loadUrl+="sms_no="+cerNum+"&cs_tel="+phoneNum+"&username="+name+"&userid="+userid;
						loadUrl+="sms_no="+cerNum+"&cs_tel="+phoneNum+"&userid="+useridInPw;
					var type = "<%=type%>";
					$.ajax({
					  url: loadUrl,
					  dataType: 'json',
					  async: false,
					  success: function(data) {
						if(data){
							// 입력하신 데이터  번호로 된 정보가 없습니다.
							/* if(data.msgID == "IDNONE" || data.msgID == "IDDIFF"){
								alert("입력하신 정보와 일치하는 ID가 없습니다.");
								return;
							} */

							if(data.msg == "success"){

								var form = document.joinForm;

								var tel1 = '';
								var tel2 = '';
								var tel3 = '';

								// 핸드폰 번호가 10자일 경우. 가운데 번호를 3자리로 자른다. ex) 0101234567.
								if(phoneNum.length==10){
									// substr(시작인덱스, 길이)
									tel1 = phoneNum.substr(0,3);
									tel2 = phoneNum.substr(3,3);	// 3자리
									tel3 = phoneNum.substr(6,4);	// 시작인덱스 6
								} else {
									tel1 = phoneNum.substr(0,3);
									tel2 = phoneNum.substr(3,4);	// 4자리
									tel3 = phoneNum.substr(7,4);	// 시작인덱스 7
								}

								form.isChecked.value = "true";
								form.tel1.value = tel1;
								form.tel2.value = tel2;
								form.tel3.value = tel3;
								form.certify.value = "1";	// 2:본인인증, 1:간편인증

								form.conf_ci_key.value = "";
								form.conf_di_key.value = "";
								form.conf_phoneco.value = "";
								//form.userId.value = userid;
								form.userId.value = useridInPw;
								document.hFrame.location.replace(self.location);

								form.submit();

							}else if(data.msg == "timeout"){

								alert("인증번호 입력시간이 초과되었습니다. 인증번호를 재전송해주세요.");

							}else if(data.msg == "5out"){

								alert("5회 이상 잘못 입력하셨습니다. 인증번호를 재전송해주세요.");

							}else if(data.msg == "fail"){

								alert("인증번호가 올바르지 않습니다.인증번호를 다시 입력하거나 재전송해주세요.");
							}
						}

					  }
					});
				}else if($("#mail_pw").is(":checked")){
					ga('send', 'event', 'mf_member_find', 'find_PW', 'find_pw_이메일주소');
					//alert("이메일 주소");
					var userid = $("#idpw02_id_email").val();
					var name = $("#idpw02_name").val();
					var email = $("#idpw02_mail").val();

				 	if($("#txt_info_mail").text() == "등록된 이메일이 없습니다." ){
					  	alert("입력한 정보에 해당하는 회원정보가 없어 메일전송에 실패했습니다.");
					  	return;
				   }
					if(!idCheckInPw){
						alert("아이디를 확인해주세요.")
						return;
					}

					if(email == ""){
						alert("이메일을 입력해주세요");
						return;
					}

					if(email.indexOf("@") < 0 && email.indexOf(".") < 0){
						alert("이메일을 확인해주세요");
						return;
					}
					$("#joinForm2").attr("action", "/member/ajax/findpw_send_mail.jsp");
					var action = $("#joinForm2").attr("action");
					var form_data = {
							userId: userid,
							mailAddr: email,
							kind: "mail_pw"
						};

					//var loadUrl = "/member/ajax/findpw_send_mail.jsp?";
					//loadUrl+="userId="+userid+"&userNm="+name+"&mailAddr="+email+"&isMobile=Y";

					$.ajax({
					  type: "POST",
					  url: action,
					  data: form_data,
					  success: function(data) {

						if(data){
							// 입력하신 데이터  번호로 된 정보가 없습니다.
					    	if(data.trim().indexOf("success") > -1 ) {
					    		alert(data.trim().replace("success:", ""));
					    	} else {
					        	alert(data.trim());
					        }
						}
					  }
					});
				}
			});

			$("#btnPw_auth").click(function(){
				var userid = $("#txt_info_auth").val();

				ga('send', 'event', 'mf_member_find', 'find_PW', 'find_pw_본인인증');

				if(userid == ""){
					alert("아이디를 입력해주세요");
					return;
				}

				// 사용자 본인인증 체크 ajax
				var user_chk = false;
				var form_data = {
						userId: userid,
					};

				$.ajax({
					method: "POST",
					url: "/member/ajax/findpw_user_cert_chk.jsp",
					data: form_data,
					async: false, // true: 비동기, false: 동기
					success:function(result){
						if(result.trim() == "success") {
							user_chk = true;
						}else if(result.trim() == "lock") {
							var conf = confirm("의심스러운 로그인 활동이 감지되어 "+userid+"계정이 일시적으로 잠금 처리되었습니다. 해제하시려면, '해제하기' 또는 고객센터로 문의주세요. 해제하시겠습니까?");
							user_chk = false;

							if(conf){
								window.open("/member/unlock/unlock_mo.jsp");
							}else{
								return false;
							}
						} else {
				        	alert(result.trim());
				        	user_chk = false;
				        }
					}
				});

				if(user_chk){
					cmdCheckPlusReal();
					//openMyCheckWin();
					// 본인인증 팝업
				}else{
					return;
				}

			});

			showInputInfoSendHpAuth = function (msg , temp){
				alert(msg);
			}

			showPwInputInfoSendHpAuth = function (msg , temp){
				alert(msg);
			}

			jShowInputInfoSendHpAuth = function (msg , temp){
				alert(msg);
			}

	});

		function failMyCheckOk(){
	  		$(".noticed").text("본인인증에 실패하였습니다.\n다시 본인인증을 해주세요.");
			$(".dim").show();
		}

		// 본인인증 완료
		//function myCheckOk(mobile, conf_ci_key, conf_di_key, conf_phoneco){
		function myCheckOk(mobile, conf_ci_key, conf_di_key, conf_phoneco, conf_name, myauth){
			var form = document.joinForm;

			var tel1 = '';
			var tel2 = '';
			var tel3 = '';

			// 핸드폰 번호가 10자일 경우. 가운데 번호를 3자리로 자른다. ex) 0101234567.
			if(mobile.length==10){
				// substr(시작인덱스, 길이)
				tel1 = mobile.substr(0,3);
				tel2 = mobile.substr(3,3);	// 3자리
				tel3 = mobile.substr(6,4);	// 시작인덱스 6
			} else {
				tel1 = mobile.substr(0,3);
				tel2 = mobile.substr(3,4);	// 4자리
				tel3 = mobile.substr(7,4);	// 시작인덱스 7
			}

			form.isChecked.value = "true";
			form.tel1.value = tel1;
			form.tel2.value = tel2;
			form.tel3.value = tel3;
			form.certify.value = "2";	// 2:본인인증, 1:간편인증

			form.conf_ci_key.value = conf_ci_key;
			form.conf_di_key.value = conf_di_key;
			form.conf_phoneco.value = conf_phoneco;
			form.userId.value = $("#txt_info_auth").val();

			// 사용자 정보 체크 ajax
			var user_chk = false;
			var form_data = {
					userId: $("#txt_info_auth").val(),
					ciKey: conf_ci_key,
					diKey: conf_di_key,
					isCert:"Y"
				};

			$.ajax({
				method: "POST",
				url: "/member/ajax/findpw_user_chk.jsp",
				data: form_data,
//				dataType: "json",
				async: false, // true: 비동기, false: 동기
				success:function(result){
					if(result.trim() == "success") {
						user_chk = true;
			    	}
					//인증번호 확인
					if (user_chk) {
						$(".noticed").text("본인인증에 성공하였습니다.");
						$(".dim").show();

						submitClickFlag = true;
						form.hp_input_hidden_value.value = "Y"; 	//간편인증에서 값 넘김 표시
						form.submit();
				  	} else {
				  		//$(".noticed").text("본인인증에 실패하였습니다.\n본인 명의의 휴대폰번호로 다시 시도해 주세요.");
				  		$(".noticed").text("이전에 인증하신 정보와 달라\n본인인증에 실패하였습니다.\n다시 본인인증을 해주세요.");
						$(".dim").show();
				  		submitClickFlag = false;
				  	}
				}
			});
		}

		//title생성
		var vTitle = "ID / 비번 찾기";

		try{
				window.android.getTitle(vTitle);
		}catch(e){}
	
		//뒤로 #추가
		$('#header .btn__sr_back').click(function(){
		    history.back(-1);
		});

</script>
<iframe id="hFrame" name="hFrame" frameborder="0" style="margin:0px;padding:0px;height:0px;width:0px;"></iframe>
<%@ include file="/mobilefirst/member/inc_myCheck.jsp"%>
</html>