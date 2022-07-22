<%@page import="com.enuri.bean.member.Login_Proc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.event.DBWrap"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<jsp:useBean id="Login_Proc" class="com.enuri.bean.member.Login_Proc"  />
<%
	String strApp = ChkNull.chkStr(request.getParameter("app"),"");	 //	Y일때 앱

	String strUserId = ConfigManager.RequestStr(request, "userId", "");
	String strUserNm = ConfigManager.RequestStr(request, "userNm", "");
	String strUserPhone= ConfigManager.RequestStr(request, "userPhone", "");
	String strUserPhone1= ConfigManager.RequestStr(request, "tel1", "");
	String strUserPhone2= ConfigManager.RequestStr(request, "tel2", "");
	String strUserPhone3= ConfigManager.RequestStr(request, "tel3", "");

	String isHpInputValue= ConfigManager.RequestStr(request, "hp_input_hidden_value", "");

	strUserNm = ConfigManager.RequestStr(request, "hp_Input_name", "");
	strUserPhone= ConfigManager.RequestStr(request, "cs_tel", "");
	
	
	Seed_Proc seed_proc = new Seed_Proc();
	
	/*
	Login_Proc lp = new Login_Proc();
	lp.insPassLog(4, "pw.jsp", String con_dtl_url, strUserId, 
			seed_proc.EnPass_Seed(strUserPhone1), seed_proc.EnPass_Seed(strUserPhone2) , seed_proc.EnPass_Seed(strUserPhone3) 
			, String usr_eml, int reward_no, String con_ip, String os_tp_cd)
	*/
	
	//블랙리스트 페이지 제한 로그 입력 _ start

	//int iPassCnt = Login_Proc.getPassCnt(userIp, 1); //1일 
	//블랙리스트 페이지 제한 로그 입력 _ end
	
	String userIp = ChkNull.chkStr(ConfigManager.szConnectIp(request), "");
	
	String reqUri = ChkNull.chkStr(request.getRequestURI().toString(), "");
	String reqUrl = "";
	String reqUrlQry = "";
	String reqDomain = ChkNull.chkStr(request.getServerName().toString(), "");

	
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
	
	boolean bPassLog= Login_Proc.insPassLog(4, reqUri, reqUrlQry, strUserId , seed_proc.EnPass(strUserPhone1)
			, seed_proc.EnPass(strUserPhone2) , seed_proc.EnPass(strUserPhone3) , "", 0, userIp, "");
	
	/*
	DBWrap insert = new DBWrap("member");
	insert.addSimpleParameter("userid", strUserId)
	.addSimpleParameter("tel1_p", seed_proc.EnPass_Seed(strUserPhone1))
	.addSimpleParameter("tel2_p", seed_proc.EnPass_Seed(strUserPhone2))
	.addSimpleParameter("tel3_p", seed_proc.EnPass_Seed(strUserPhone3))
	.addSimpleParameter("userip", userIp)
	.simpleInsert("TB_MEMBERS_TEMP_PASS_LOG", "");
	*/
	
	
/* 	boolean isIos = false;
	if((
			ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 
			|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 
			|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0 
		)&& ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0){
		isIos = true;
	} */
		
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

	//REFERER 체크
	String referer = ChkNull.chkStr(request.getHeader("REFERER"), "");

	if(referer.isEmpty() || referer.indexOf("idpw.jsp") < 0){
		out.print("비정상적 접근 입니다. ");
		return;
	}
	
	//디바이스가 PC일 경우 해당페이지로
	if (!((ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Linux") >= 0 ) ||  (ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0))){
		response.sendRedirect("/member/login/modifyPw.jsp");
		return;
	}
	
	//실명인증으로 왔을 경우 파라미터
	if (isHpInputValue.equals("Y")) {
		strUserPhone= ConfigManager.RequestStr(request, "cs_tel", "");
		if( strUserPhone.equals("") ){
			strUserPhone = strUserPhone1 + strUserPhone2 + strUserPhone3;
		}
		if(strUserId.equals("") && strUserNm.equals("") && strUserPhone.equals("")){
		//	response.sendRedirect("/mobilefirst/member/idpw.jsp");
		}
	}else{
		strUserPhone = strUserPhone1 + strUserPhone2 + strUserPhone3;
		if(strUserId.equals("") && strUserPhone.equals("")){
			response.sendRedirect("/mobilefirst/member/idpw.jsp");
			return;
		}
	}
	

	//SSL
	String ENURI_COM_SSL = "https://m.enuri.com";

	String serverName = request.getServerName();
	/* if(serverName.indexOf("stagedev.enuri.com")>-1) {
		ENURI_COM_SSL = "http://"+serverName;
	}else if(serverName.indexOf("100.100.100.151")>-1 || serverName.indexOf("dev.enuri.com")>-1){
		ENURI_COM_SSL = "https://"+serverName;
	}else{
		ENURI_COM_SSL = "https://"+serverName;
	} */

	ENURI_COM_SSL = "https://"+serverName;

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
	<link rel="stylesheet" type="text/css" href="<%=ENURI_COM_SSL%>/css/home/member.css"/>
</head>
<body>

<div class="memberwrap">
	<header>
		<a href="javascript:history.back(-1);" class="back">뒤로가기</a>
		<h1>비밀번호 재설정</h1>
		<h2>ENURI</h2>
	</header>

	<div class="idpw_area" id="idpw01">
		<fieldset class="memberfield">
			<legend>비밀번호 재설정</legend>
			<!-- 임시 처리
			<div class="new_pw">
				새로운 비밀번호를 설정해주세요.
				<ul>
					<li>영문 대문자, 영문 소문자, 숫자, 특수문자 중 3가지를 조합하여 8~15자로 설정</li>
					<li>사용 가능한 특수문자: !  @  #  $  %  ^  &  *  (  )  ,</li>
					<li>아이디를 포함한 비밀번호 사용 불가능</li>
				</ul>
			</div>
			<div class="myinfo_form">
				<label class="tit">새 비밀번호</label><input type="password" id="newpass1" />
				<span id="newpass1Txt" class="txt_blue" style="display:none;"></span>
			</div>
			<div class="myinfo_form">
				<label class="tit">확인</label><input type="password" id="newpass2" onkeydown="NewPwCheck2(2);" />
				<span id="newpass2Txt" class="txt_red" style="display:none;">비밀번호가 일치하지 않습니다.<br />다시 입력해 주세요.</span>
			</div>
			<button type="submit" class="btn_join">확인</button>
			<p class="txt_basic star">휴면 회원은 아이디/비밀번호 찾기가 제한되오니 새로운 아이디로 다시 가입해 주시기 바랍니다.</p>
			 -->
			<button type="button" class="btn_join" onClick="tmpPassword();">임시 비밀번호 발급</button>
		</fieldset>
	</div>
	<input type="hidden" name="userid" id="userid" value="<%=strUserId%>">
	<form id="pwForm"  name="pwForm"  method="post" action="/mobilefirst/member/pw_update.jsp">
		<input type="hidden" name="newpass">
		<input type="hidden" name="userid">
	</form>
</div>


</body>

<script type="text/javascript">
	var vApp = "<%=strApp%>";
	<%-- var isIos = "<%=isIos%>"; --%>
	if(vApp == "Y"){
		$("h1").hide();
	}

		$(document).ready(function() {
			
			/* 임시 처리
			$(".btn_join").click(function(){
				var chkPW1 = $("#newpass1").val();
				var chkPW2 = $("#newpass2").val();
				var chkPW3 = NewPwCheck();
				var chkUserId = $("#userid").val();

				if(chkPW1 == "" || chkPW2 == ""){
					alert("비밀번호를 입력해주세요.");
				}else if(chkPW1 != chkPW2){
					$("#newpass2Txt").show();
				}else if(chkPW3){
					var form_data = {
							newpass: chkPW1,
							userid: chkUserId
					};
					var action = $("#pwForm").attr("action");

					//var loadUrl = "pw_update.jsp?newpass="+chkPW1+"&userid="+chkUserId;

					$.ajax({
						type: "POST",
						url: action,
						data: form_data,
					    success: function(data) {
							if(data){
								if(data.indexOf("true") > -1){
									alert("비밀번호가 정상적으로 변경되었습니다.");	
									goLogin();
								}else{
									alert("다시 시도해주세요.");
								}
							}
					  	}
					});
				}else{
					alert("비밀번호를 확인해주세요.");
				}
			});
			*/

			$("#newpass1").blur(function(){
				var newpass1 = false;

				if(NewPwCheck()){
					$("#newpass1Txt").removeClass("txt_red");
					$("#newpass1Txt").addClass("txt_blue");
					$("#newpass1Txt").text("사용할 수 있는 비밀번호 입니다.");
				}else{
					$("#newpass1Txt").removeClass("txt_blue");
					$("#newpass1Txt").addClass("txt_red");
					$("#newpass1Txt").text("8~15자의 영대/소문자, 숫자, 특수문자 중 3가지를 조합해주세요.");
				}
				//$(".txt_blue").show();
				$("#newpass1Txt").show();
			});

			$("#newpass1").keydown(function(){
				NewPwCheck2(1);
			});

			$("#newpass1").keydown(function(){
				NewPwCheck2(1);
			});

		});


		function NewPwCheck(){
			//alert("비번 규칙이 맞는지 체크");
			var pw = $("#newpass1").val();
		    var matchNum = 0;

		    var arrReg = [
		                  new RegExp("^.*[a-z]+.*$","g"),
		                  new RegExp("^.*[A-Z]+.*$","g"),
		                  new RegExp("^.*[0-9]+.*$","g"),
		                  new RegExp("^.*[!,@,#,\$,%,\^,\&,\*,\(,\)]+.*$","g")
		    ];

		    var allowReg = new RegExp("^[A-z0-9,!,@,#,\$,%,\^,\&,\*,\(,\)]{8,15}$");

		    for(var i in arrReg)
		        if(pw.match(arrReg[i]))
		            ++matchNum;

		    if(matchNum>=3 && pw.match(allowReg)){
		    	return true;
		    }else{
		    	return false;
		    }
		}

		function NewPwCheck2(param){
			if(param == 1){
				//$(".txt_blue").hide();
				$("#newpass1Txt").hide();
			}else if(param == 2){
				//$(".txt_red").hide();
				$("#newpass2Txt").hide();
			}
		}

		function goLogin() {
			if(vApp == "Y"){
		    	if(window.android){		// 안드로이드
		    		//document.location.href = "close://";
		    		window.open("close://");
		    	}else{					// 아이폰에서 호출
		    		window.open("close://");
		    		//document.location.href = "http://m.enuri.com/mobilefirst/app_redirect.jsp";
		    	}
		    }else{
				document.location.href = "/member/login/login.jsp?app=<%=strApp%>&backUrl=";
			}
			//return false;
		}

		//title생성
		var vTitle = "비밀번호 재설정";

		try{
				window.android.getTitle(vTitle);
		}catch(e){}

		// 임시비밀번호 SMS 발송
		function tmpPassword() {
			var userID = "<%=strUserId%>";
			var userPhone = "<%=strUserPhone%>";
			
			if(userID.trim().length==0 || userPhone.trim().length==0) {
				alert("개인정보를 찾을 수 없습니다.");
				return;
			}
			
			if(confirm("임시비밀번호를 발급하시겠습니까?\n임시비밀번호는 가입하신 휴대폰 번호로 발송됩니다.")) {
				$.ajax({
					type: "POST",
					url: "/mobilefirst/member/pw_sms.jsp",
					data: {
						"userid" : userID,
						"phoneno" : userPhone
					},
					success: function(success) {
						if(success){
							alert("임시비밀번호가 발송되었습니다.");
							goLogin();
						} else {
							alert("임시비밀번호 발송에 실패했습니다.\n고객센터로 문의해주세요.");	
						}
					}
				});
			}
		}
	
</script>

</html>

