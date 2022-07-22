<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.enuri.bean.main.brandplacement.DBDataTable"%>
<%@ page import="com.enuri.bean.main.brandplacement.DBWrap"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.RSAMains"%>
<%@ page import="com.enuri.bean.mobile.CRSA"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<jsp:useBean id="Seed_Proc" class="com.enuri.util.seed.Seed_Proc"  />
<%@ page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<jsp:useBean id="Mobile_Push_Proc" class="com.enuri.bean.mobile.Mobile_Push_Proc" scope="page" />
<%
	String strApp = ChkNull.chkStr(request.getParameter("app"),"");	 //	Y일때 앱
	String strEnuriID = ChkNull.chkStr(request.getParameter("userid"),"");
	String strRSA = ChkNull.chkStr(request.getParameter("pd"));
	String cmdType = ChkNull.chkStr(request.getParameter("cmdType"),"");	// 빈값:가입, modify:회원정보수정, uft:휴면2
	String strFlow = ChkNull.chkStr(request.getParameter("f"),"");				    // SNS PC(p) , SNS MO(m)
	/* boolean isIos = false;
	if((
			ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 
			|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 
			|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0 
		)&& ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0){
		isIos = true;
		if(request.getQueryString().indexOf("freetoken=outlink") < 0){
			
			//out.println("<script>location.href = '/mobilefirst/member/myAuth.jsp?"+request.getQueryString()+"&freetoken=outlink'; </script>");
			response.sendRedirect("/mobilefirst/member/myAuth.jsp?"+request.getQueryString()+"&freetoken=outlink");
			return;	
		}
		
	} */
	
	//APP
	Cookie[] carr = request.getCookies();
	try {
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("appYN")){
		    	if(!strApp.equals("Y")){
		    		strApp = carr[i].getValue();
		    	}
		    }
		}  
	} catch(Exception e) {
	}

	Mobile_Push_Proc mobile_push_proc = new Mobile_Push_Proc();

	String cUserId = "";
	String strRSA2 = "";

	//strRSA = "H9QRIGxu9iJkmRfxn1u0r5T5qbA8ccH9FGRVXx9n2C424_psa40GIF9FslaNkEH87JkRTXnbw-DbGD4WFDZwhroVXCwHMOeTaxD9_2XyfOCS2s8ef3erzW1T6TX9vjNf7-I-15-qoZCbJKU4Faqkd-uCjGUyqeTk-i5Fj0uV312aIBlahojFh8rTu7wgDa9DFK0SHDvByoaInQ1EN83wz3tFNhg9yf--z3sDoHaRxtIudEtmf50NbeYBJ_r2KhVpM5OGDIOvKmIfhmHRqpS_QTEJc8cfpb6opyot4zFB7Adq0V4xLAksmxO5HD5w3yrZ5K4d833ObhmR5PuUSDRUkm3OMR8fZ9zmLuWbJYMVURj-GBPbgLHUiRghMdkbfMv2tiFZSdpBg_E-xr4YXMTvQIDgVFfjhJF7TBo-Zce9ajCNxTUvYzQORitH2raZ6jhPUdUZX1Im17jnYp6CWrUe4X9tmT8MHMo_k5e5Zosb9qXBo-uK0qBcOY5AtfUIwRvfnbqEV-Fn7-sK5hDcvBmRw10UAeJ0tpEfMBsIIYQfq9XfeDNrqyw_MQYDQS7d_bm_M59O8O9_p_oxPt2x51xmOfrLBrR4446QNWUcUfF1AsFpU9OifrGEh3BjJ96kWM64Cdt3Cg4fXX_fMQXcWR469SMtZqWAqHBC5ljEO30EX8M=";
	//strRSA = "K0KjMa91dnFddGp3NLUBX_CfKjAT9FNtcfaQqfkSIwmfv4DD6lcuSRCoP17EanHHKtyqyG51weBCDcHZwpjEMrEjLX1VraOoVNQRscKr6R12Yrkj4srfd1T4iggqCuMJlonK_ms73cXixaMf0_KZe5YbciwQPeLrx-ZbdSAl1mM=";

	if(strApp.equals("Y") && strRSA.length() > 0 ){

		strRSA = strRSA.replaceAll("-","+");
		strRSA = strRSA.replaceAll("_","/");

		if(strRSA.length() > 0){
	 		strRSA2	= mobile_push_proc.longdecrypt3(strRSA);
	 	}

		//vTrue = false;

	    String astrRSA[] = strRSA2.split("&");

		int intRSACnt = astrRSA.length;

		String sEnuri_id 		= "";

		for (int i=0 ; i<intRSACnt ; i++){
			String strTmpHead = astrRSA[i].substring(0, astrRSA[i].indexOf("="));
			String strTmpValue = astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length());

			if(strTmpHead.equals("appid")){
			}else if(strTmpHead.equals("time")){
			}else if(strTmpHead.equals("uuid")){
			}else if(strTmpHead.equals("id")){
				sEnuri_id = strTmpValue;
			}
		}

		if(strRSA2.indexOf("&id=") > -1){
			//앱일때 강제로 SET USER_ID
			cb.SetCookie("MEM_INFO", "USER_ID", sEnuri_id);
			cb.SetCookieExpire("MEM_INFO",-1);
			cb.responseAddCookie(response);
			cUserId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
			if(cUserId.equals("")){
				cUserId = strEnuriID;
			}
		}

	}else{

		if(!strApp.equals("Y")){
			cUserId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim();
			if(cUserId.equals("")){
				cUserId = strEnuriID;
			}
		}else{
			cUserId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim();
			if(cUserId.equals("")){

				cb.SetCookie("MEM_INFO", "USER_ID", strEnuriID);
				cb.SetCookieExpire("MEM_INFO",-1);
				cb.responseAddCookie(response);
				cUserId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
				if(cUserId.equals("")){
					cUserId = strEnuriID;
				}

			}
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
	<%if(strFlow.equals("p")){ %>
	<meta name="keywords" content="휴대폰, 사무, 생활가전, 용품, 영상음향, 컴퓨터, 자동차, 명품, 잡화, 스포츠, 유아, 완구, 가구, 화장품, 식품, 가격비교, 쇼핑몰, 최저가">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>에누리(가격비교) eNuri.com</title>
	<link rel="shortcut icon" href="//img.enuri.info/2014/layout/favicon_enuri.ico">
	<script type="text/javascript" src="/common/js/lib/jquery-1.9.1.min.js"></script>
	<link rel="stylesheet" href="/css/default.css" type="text/css">
	<link rel="stylesheet" href="/css/member.css" type="text/css"> <!-- [D] 작업 CSS -->
	<%}else if(strFlow.equals("m")){ %>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/default.css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/member.css"/>
	<%}else{%>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<script type="text/javascript" src="/common/js/lib/jquery-1.9.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/css/home/default.css">
	<link rel="stylesheet" type="text/css" href="/css/home/member.css"/>
	<%} %>
	<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		//런칭할때 UA-52658695-3 으로 변경
		ga('create', 'UA-52658695-3', 'auto');
	</script>
</head>

<%if(strFlow.equals("p")){ %>
<body id="Member">
<!-- 회원가입 WRAP -->
<div class="member_wrap">
	<!-- Member Header -->
	<div class="mb_header">
		<!-- container -->
		<div class="container ex_login_top" style="width:auto;">
			<h1 class="page_title"><a href="http://enuri.com/" class="pt_logo"><img src="/images/member/page/enuri_logo.gif" alt="ENURI 로고"></a> SNS 회원 본인인증</h1>
		</div>
		<!-- //container -->
	</div>

	<!-- Member Content -->
	<div class="mb_content">
		<!-- container -->
		<div class="container">
			<div class="join_form">
				<form id="joinForm" method="post" action="">
					<fieldset>
						<legend>SNS 회원 본인인증 페이지</legend>

						<!-- row section -->
						<div class="sns_auth_wrap">
							<p class="sns_auth_info">본인인증이 완료되면 e머니 혜택과 이벤트 참여가 가능합니다.</p>

							<!-- SNS 회원 본인인증 -->
							<div class="auth_cont sns_auth_cont">
								<div class="auth_id">
									<p class="tit">본인인증</p>

									<p class="info">
										<span class="unchk" onclick="agreechk(this);"><input type="checkbox" id="my" name="my" value="N"><b>[필수]</b> 본인확인을 위해 휴대폰번호, 생년월일, 성별, 본인확인정보를 수집하는 것에 동의합니다.</span>
									</p>

									<div class="btn_group">
										<div class="sm"><a href="#" class="btn btn_sm default"  id="hpAuth" !onclick="alert('본인인증에 성공했습니다.\n본인인증 하신 휴대폰번호로 \n회원정보가 등록됩니다.'); return false;">본인인증</a></div>
									</div>
									<p class="hp_info" id="hpText">휴대폰번호 (본인인증 하시면 휴대폰번호가 자동 입력됩니다.)</p>
									<!-- <p class="hp_info numb">010-1234-5678</p> -->
								</div>
							</div>
							<!-- //SNS 회원 본인인증 -->
						</div>
						<!-- //row section -->
					</fieldset>
				</form>
			</div>

			<!-- BTN 영역 -->
			<div class="btn_group">
				<div><a href="javascript:;" class="btn btn_lg" id="snsmbtn">본인인증 완료</a></div>
			</div>
			<!-- //BTN 영역 -->
		</div>
		<!-- //container -->

	</div>
	<!-- //Member Content -->

	<!-- Member Footer -->
	<div class="mb_footer">
		<!-- container -->
		<div class="container">
			<p class="copyright">Copyright ⓒ SummercePlatform Inc. All rights reserved.</p>
		</div>
	</div>
	<!-- //Member Footer -->
</div>
</body>
<!-- //회원가입 WRAP -->
<%}else if(strFlow.equals("m")){ %>
<body>
<div class="memberwrap">
	<header>
		<a href="javascript:history.back(-1);" class="back">뒤로가기</a>
		<h1>SNS회원 본인인증</h1>
		<h2>ENURI</h2>
    </header>

	<div class="memberfield">
        <div id="myAuth" class="myAuth">
	        <legend>sns아이디 회원가입</legend>
	        <p class="txt_basic">본인인증이 완료되면 e머니 혜택과 이벤트 참여가 가능합니다.</p>
	            <div class="sns_form">
	                <div class="chkbox_area">
	                    <input type="checkbox" class="in_chk" id="my" name="my" onclick="agreechk2(this);">
	                    <label for="sms_mms" class="chkbox">[필수] 본인확인을 위해 이름, 휴대폰번호, 생년월일, 성별 정보를 수집하는 것에  동의합니다.</label>
	                </div>
	            </div>
	        <button type="submit" class="btn_confirm" id="hpAuth">본인인증</button>
        </div>
		<div id="myAuthSuccess" style="display:none;" class="myAuth">
			<div class="mybox success">본인인증에 성공하였습니다.</div>
			<p class="my_btnarea"><button type="button" class="ok_close">닫기</button></p>
		</div>
		<div id="myAuthFail" style="display:none;" class="myAuth">
			<div class="mybox fail">본인인증에 실패하였습니다.<br />다시 본인인증을 해주세요.</div>
			<p class="my_btnarea"><button type="button" class="ok_close">본인인증 다시하기</button></p>
		 </div>
    </div>
</div>
</body>
<%}else{ %>
<body>
<div class="memberwrap">
	<header>
		<a href="javascript:history.back(-1);" class="back">뒤로가기</a>
		<h1>본인인증</h1>
	</header>

	<div class="memberfield">
		<div id="myAuth" class="myAuth">
			<!-- <div class="mybox">본인인증을 하시면 에누리앱에서<br /><em>e머니 적립</em>이 가능합니다.</div> -->
			<div class="mybox">고객님 명의의 휴대폰으로<br />본인인증을 해주세요.</div>
			<p class="my_agr"><input type="checkbox" id="my" name="my"/><label for="my">[필수] 본인확인을 위해 휴대폰 번호, 생년월일, 성별, 본인확인정보(CI, DI)를 수집하는 것에 동의합니다.</label></p>
			<p class="my_btnarea">
				<span><button type="button" id="hpAuth">휴대폰 본인인증</button></span>
				<span><button type="button" class="close">닫기</button></span>
			</p>
		</div>
		<div id="myAuthSuccess" style="display:none;" class="myAuth">
			<div class="mybox success">본인인증에 성공하였습니다.</div>
			<p class="my_btnarea"><button type="button" class="ok_close">닫기</button></p>
		</div>
		<div id="myAuthFail" style="display:none;" class="myAuth">
			<div class="mybox fail">본인인증에 실패하였습니다.<br />다시 본인인증을 해주세요.</div>
			<p class="my_btnarea"><button type="button" class="ok_close">본인인증 다시하기</button></p>
		 </div>
	</div>
</div>
</body>
<%} %>

<script type="text/javascript">
	var vApp = "<%=strApp%>";
	var ENURI_SSL = "<%=ENURI_COM_SSL%>";

	if(vApp == "Y")			$("h1").hide();

	$(document).ready(function() {
		$("#snsmbtn").click(function(){
			if($("#snsmbtn").hasClass("active")){
				//alert("본인인증 완료, 그다음은 어떻게 할까");
				insertLog(19300);
				CmdClose();
			}
		});

		$("#hpAuth").click(function() {

			//console.log(<%=ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"))%>)
			if("<%=ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"))%>" == "" && "<%=cmdType%>" == ""){
				location.href = "/member/login/login.jsp";
				return false;
			}

			if($('input:checkbox[name="my"]')[0].checked || $('#my').parent().hasClass("chk")){
				// 휴대폰 본인인증
				//cmdCheckPlusReal();
				AuthCheck();
				//CmdClose();
				<%if(strFlow.equals("p")){	%>
				<%}else if(strFlow.equals("m")){	%>
					ga('send', 'event', 'mf_SNS', 'SNS본인인증', 'click_confirm');
				<%}%>
			}else{
				alert("필수항목 수집 동의해주세요.");
			}
		});

		$(".close").click(function() {
			CmdClose();
		});

		$("#myAuthSuccess .ok_close").click(function() {
			if( "<%=cmdType%>" == "uft"){
				location.replace("/member/login/login.jsp");
				return false;
			}else{
				alert("본인인증이 완료되었습니다.");
				CmdClose();
			}
		});

		$("#myAuthFail .ok_close").click(function() {
			$("#my").attr("checked", false);
			$("#myAuthFail").hide();
			$("#myAuth").show();
		});
	});


	function CmdClose(){

		if(vApp == "Y"){
			location.href = "close://";
		}else{
			//history.go(-1);
			<%if(strFlow.equals("p")){ %>
				window.open('about:blank', '_self').close();
			<%} else {%>
			location.href = "http://"+location.hostname;
			//history.back(-1);
			<%} %>
		}
	}

	function agreechk(obj){
		if (obj.className== 'unchk') {
			obj.className = 'chk';
		} else {
			obj.className = 'unchk';
		}
	}

	function agreechk2(obj){
		if (obj.checked) {
			$("#hpAuth").addClass("on");
		}else{
			$("#hpAuth").removeClass("on");
		}
	}

	function insertLog(logNum){
		$.ajax({
			type: "GET",
			url: "/view/Loginsert_2010.jsp",
			data: "kind="+logNum,
			success: function(result){
			}
		});
	}
	//title생성
	var vTitle = "본인인증";
	<%if(strFlow.equals("p") || strFlow.equals("m")){%>
		vTitle = "SNS본인인증";
	<%}%>
	try{
			window.android.getTitle(vTitle);
	}catch(e){}

	<%if(!strFlow.equals("p")){ %>
	ga('send', 'pageview', {
		'page': '/mobilefirst/member/myAuth.jsp',
		'title': 'mf_'+vTitle
	});
	<%}%>

	/////////////////////////////////////////본인인증 수정
	function AuthCheck(){
		var theUrl = ENURI_SSL + "/member/join/auth/AuthCheck.jsp?type=modify";	//팝업창 호출할 페이지 이름
		var winName = "popupChk";	
		var features = "width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no";	//이건 뭐 대충...
		window.open(theUrl,winName,features);
		window.addEventListener("message",receivePostMsg);
	}
	function receivePostMsg(event){
		if(typeof event.data.phone != "undefined"){
			$(".myAuth").hide();
			if(event.data.phone ==""){
				$("#myAuthFail .mybox").html(event.data.message);
				$("#myAuthFail").show();
			}else{
				if("<%=strFlow%>" == "p"){
					var mobile = event.data.phone;
					var vmobile = mobile.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
					$("#hpText").addClass("numb");
					$("#hpText").text(vmobile);
					alert("본인인증에 성공했습니다.\n본인인증 하신 휴대폰번호로 \n회원정보가 등록됩니다.");
					$("#snsmbtn").addClass("active");
				}else if("<%=strFlow%>" == "m"){
					$("#myAuthSuccess .mybox").html("본인인증이 완료되어<br>e머니 혜택과 이벤트 참여가<br>가능합니다.");
					$("#myAuthSuccess").show();
				}else{
					$("#myAuthSuccess").show();
				}
				if(vApp == "Y"){
					if(window.android){
						window.android.appCertifyResult('<%=strEnuriID%>', true);
					}else{
						location.href="enuri://appCertifyResult?enuriID=<%=strEnuriID%>&result=true";
					}
				}
			}
		} else {

		}
		console.log(event.data);
	}
	/////////////////////////////////////////////////////////
	function failMyCheckOk(){
		$(".myAuth").hide();
		$("#myAuthFail .mybox").html("본인인증에 실패하였습니다.\n다시 본인인증을 해주세요.");
		$("#myAuthFail").show();
	}
	function fail7days(){
		$(".myAuth").hide();
		$("#myAuthFail .mybox").html("탈퇴 후 7일 이후\n재인증이 가능합니다.");
		$("#myAuthFail").show();
	}
	function failchild(){
		$(".myAuth").hide();
		$("#myAuthFail .mybox").html("에누리 가격비교는 만14세 이상 이용 가입 가능합니다.");
		$("#myAuthFail").show();
	}

	// 본인인증 완료
	//function myCheckOk(mobile, conf_ci_key, conf_di_key, conf_phoneco){
	function myCheckOk(mobile, conf_ci_key, conf_di_key, conf_phoneco, conf_name, myauth){

		//alert("본인 인증 완료 되었습니다.");
		//CmdClose();

		$(".myAuth").hide();

		if(myauth == "true"){
			if("<%=strFlow%>" == "p"){
				var vmobile = mobile.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
				$("#hpText").addClass("numb");
				$("#hpText").text(vmobile);
				alert("본인인증에 성공했습니다.\n본인인증 하신 휴대폰번호로 \n회원정보가 등록됩니다.");
				$("#snsmbtn").addClass("active");
				try{
					opener.CmdMyAuth(vmobile);
				}catch(e){}
			}else if("<%=strFlow%>" == "m"){
				$("#myAuthSuccess .mybox").html("본인인증이 완료되어<br>e머니 혜택과 이벤트 참여가<br>가능합니다.");
				$("#myAuthSuccess").show();
			}else{
				$("#myAuthSuccess").show();
			}
			if(vApp == "Y"){
				if(window.android){
					window.android.appCertifyResult('<%=strEnuriID%>', true);
				}else{
					location.href="enuri://appCertifyResult?enuriID=<%=strEnuriID%>&result=true";
				}
			}
		}else if(myauth == "false"){
			$("#myAuthFail .mybox").html("이전에 인증하신 정보와 달라<br>본인인증에 실패하였습니다.<br>다시 본인인증을 해주세요.");
			$("#myAuthFail").show();
			if(vApp == "Y"){
				if(window.android){
					window.android.appCertifyResult('<%=strEnuriID%>', false);
				}else{
					location.href="enuri://appCertifyResult?enuriID=<%=strEnuriID%>&result=false";
				}
			}
		}else if(myauth == "uft"){
			$("#myAuthSuccess .mybox").html("본인인증이 완료되어<br>휴면 상태가 해제되었습니다.<br><br>다시 로그인 후 이용해 주세요.");
			$("#myAuthSuccess").show();
		}else{
			$("#myAuth").show();
		}
		//CmdClose();
	}
</script>
</html>