<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.event.Members_Friend_Proc"%>
<%@ page import="com.enuri.util.http.ShortUrl"%>
<%@ page import="com.enuri.bean.member.Join_Data"%>
<%@ page import="com.enuri.bean.member.Join_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Post_Data"%>
<%@ page import="com.enuri.bean.knowbox.Post_Proc"%>
<jsp:useBean id="ShortUrl" class="ShortUrl" scope="page" />
<jsp:useBean id="Join_Data" class="com.enuri.bean.member.Join_Data"/>
<jsp:useBean id="Join_Proc" class="com.enuri.bean.member.Join_Proc"/>
<jsp:useBean id="Post_Data" class="com.enuri.bean.knowbox.Post_Data" />
<jsp:useBean id="Post_Proc" class="com.enuri.bean.knowbox.Post_Proc" />

<% String strApp = ChkNull.chkStr(request.getParameter("app"),"");%>
<%

	String rtnurl = ConfigManager.RequestStr(request, "rtnurl", "/");	// 리턴 url
	String agree_chk1 = ConfigManager.RequestStr(request, "agree_chk1", "N");
	String agree_chk2 = ConfigManager.RequestStr(request, "agree_chk2", "N");
	String agree_chk3 = ConfigManager.RequestStr(request, "agree_chk3", "N");
	
	if(!agree_chk1.equals("Y") || !agree_chk2.equals("Y")){
		response.sendRedirect("/mobilefirst/member/agree.jsp");
	}


	String ENURI_COM_SSL = "https://m.enuri.com:442";
	String serverName = request.getServerName();

	// 아이폰 새버전이 올라가면
	// 밑에 ios예외처리 한부분들 수정해야함
	if(serverName.indexOf("stagedev.enuri.com")>-1 || serverName.indexOf("100.100.100.151")>-1 || serverName.indexOf("dev.enuri.com")>-1  || serverName.indexOf("my.enuri.com")>-1 || serverName.indexOf("m.enuri.com")>-1 ) {
		ENURI_COM_SSL = "";
	}

	//추천인 로직
	//웹 &&  이전페이지가 게이트페이지일때

	int iSeq  = ChkNull.chkInt(request.getParameter("rec_seq"), 0);
	String strRecUserID = "";
	String strRec_Username = "";
	String strRec_Text = "";
	String strShorturl = "";
	boolean bRec = false;

	if(!strApp.equals("Y") ){
		Members_Friend_Proc members_friend_proc = new Members_Friend_Proc();

		strRecUserID = members_friend_proc.getRecommenderid(iSeq);

		Members_Proc members_proc = new Members_Proc();

		if(strRecUserID.length() > 0){
			strRec_Username = members_proc.getUserName(strRecUserID);
		}

		strRec_Text = strRec_Username + " ("+strRecUserID+")";

		if(strRec_Username.length() > 0 && strRecUserID.length() > 0 && iSeq >=10000){
			bRec = true;
		}
		strShorturl = ShortUrl.getExist_ShortUrl("http://m.enuri.com/mobilefirst/event/friend_gate.jsp?rec_seq="+iSeq);
	}


	String backUrl = ChkNull.chkStr(request.getParameter("backUrl"), "");

	String css ="";

	if(backUrl.contains("mobiledepart")) css = "mobiledepart";
	else if(backUrl.contains("deal")) css = "mobiledeal";

	String token = UUID.randomUUID().toString().replace("-","");

	//주소
	/* String strNewType = ChkNull.chkStr(request.getParameter("newtype"),"N"); //Y:도로명주소, N:지번주소
	String strKeyword = ChkNull.chkStr(request.getParameter("keyword")); */
	String strNewType = "";
	String strKeyword = "";
	String strZip1 = "";
	String strZip2 = "";
	String strAddrDetail = "";
	String strAddr = "";
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
	<%//@include file="/mobilefirst/include/common.html"%>
	<!-- <script type="text/javascript" src="/carm/js/src/spin.js"></script> -->
	<script type="text/javascript" src="/common/js/function.js"></script>
	<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<link rel="stylesheet" type="text/css" href="http://dev.enuri.com/mobilefirst/css/home/default.css">
	<link rel="stylesheet" type="text/css" href="http://dev.enuri.com/mobilefirst/css/home/member.css"/>
</head>
<body>
<%@ include file="/mobilefirst/login/login_check.jsp"%>

<!-- <form name="frmWMember" id="frmWMember" method="post" action="/member/join/join_ssl_proc.jsp"> -->

<input type="hidden" name="rtnurl" value="/">
<!-- <input type="hidden" name="isChecked"> -->
<!-- <input type="hidden" name="escro" value="0"> -->

<!-- <input type="hidden" name="tel1">
<input type="hidden" name="tel2">
<input type="hidden" name="tel3">
<input type="hidden" name="certify"> -->

<!-- <input type="hidden" name="yyyymmdd_user">
<input type="hidden" name="sex_user">

<input type="hidden" name="conf_ci_key">
<input type="hidden" name="conf_di_key">
<input type="hidden" name="conf_yyyymmdd">
<input type="hidden" name="conf_sex">
<input type="hidden" name="conf_phoneco">
<input type="hidden" name="conf_date">

<input type="hidden" name="zip1" value="">
<input type="hidden" name="zip2" value="">
<input type="hidden" name="addr1" value="">
<input type="hidden" name="addr2" value=""> -->


<!-- 개인정보 마케팅 및 광고에 이용 (선택) -->
<!-- <input type="hidden" name="marketing_use_yn" value="Y"> -->

<!-- 비밀번호 규칙 안내 -->
<div class="dim" id="pwrule" style="display:none;">
<div class="pw_pop">
	<div class="header">
		<h3>비밀번호 규칙 안내</h3>
		<a href="#" class="btn_close" onclick="$('#pwrule').hide();">닫기</a>
	</div>
	<div class="con">
		<ul>
			<li>영문 대문자, 영문 소문자, 숫자, 특수문자 중  3가지를 조합하여 8~15자로 입력해주세요.</li>
			<li>사용 가능한 특수문자 :  ! @ # $ % ^ &amp; * ( ) ,</li>
			<li>아이디를 포함한 비밀번호는 사용 불가합니다.</li>
		</ul>
	</div>
</div>
</div>
<!--// 비밀번호 규칙 안내 -->

<!-- 주소검색 -->
<div class="dim" id="post" style="display:none;">
	<div class="adr_search">
			<button class="btnClose" type="button" onclick="$('#post').hide();">주소검색 창 닫기</button>
			<h2>주소검색</h2>
			<div class="adrarea">
				<ul class="adr_tab">
					<li class="on">
						<a href="#">지번 주소</a>
						<div class="type1">
							<p class="location">
								<label>지역명</label><input type="text" class="post_search" id="addr_keyword"/>
								<button class="searchbtn" id="addr_search">검색</button>
								<em>(동/읍/면/리/가)</em>
							</p>
							<div class="adr_sel">검색 후 해당하는 주소를 선택해 주세요.</div>
							<!-- 검색 후 리스트 -->
							<div class="adr_sel_list">
								<ul>
									<!-- <li><span>139-053</span>서울 노원구 월계3동 서울 노원구 월계3동 서울 노원구 월계3동</li>
									<li><span>139-053</span>서울 노원구 월계3동</li>
									<li><span>139-053</span>서울 노원구 월계3동</li>
									<li><span>139-053</span>서울 노원구 월계3동</li>
									<li><span>139-053</span>서울 노원구 월계3동</li>
									<li><span>139-053</span>서울 노원구 월계3동</li> -->
								</ul>
							</div>
							<!--//검색 후 리스트 -->
						</div>
					</li>
					<li>
						<a href="#">도로명 주소</a>
						<div class="type2">
							<p class="location">
								<label>도로명</label><input type="text" class="post_search" id="road_keyword"/>
								<button class="searchbtn" id="road_search">검색</button>
								<em>*도로명+건물번호 : 동남로71길, 퇴계로 18<br />*건물명 : 대우재단빌딩</em>
							</p>
							<div class="adr_sel">검색 후 해당하는 주소를 선택해 주세요.</div>
							<!-- 검색 후 리스트 -->
							<div class="adr_sel_list">
								<ul>
									<!-- <li><span>139-053</span>서울특별시 중구 퇴계로 18 (남대문로5가)</li>
									<li><span>139-053</span>서울 노원구 월계3동</li>
									<li><span>139-053</span>서울 노원구 월계3동</li>
									<li><span>139-053</span>서울 노원구 월계3동</li>
									<li><span>139-053</span>서울 노원구 월계3동</li>
									<li><span>139-053</span>서울 노원구 월계3동</li> -->
								</ul>
							</div>
							<!--// 검색 후 리스트 -->
						</div>
					</li>
				</ul>
			</div>
		</div>
</div>
<!--// 주소검색 -->

<div class="memberwrap">
<form name="joinForm" id="joinForm" method="post" autocomplete="off" action="/mobilefirst/member/join_proc.jsp" style="margin:0px;">

	<input type="hidden" name="token" id="token" value="<%=token%>"/>
	<input type="hidden" name="certify" id="certify" value=""/>
	<input type="hidden" name="cs_tel" id="cs_tel" value=""/>
	<input type="hidden" name="tel1" id="tel1" value=""/>
	<input type="hidden" name="tel2" id="tel2" value=""/>
	<input type="hidden" name="tel3" id="tel3" value=""/>
	<input type="hidden" name="hptel1" id="hptel1" value=""/>
	<input type="hidden" name="hptel2" id="hptel2" value=""/>
	<input type="hidden" name="hptel3" id="hptel3" value=""/>
	<input type="hidden" name="marketingYN" value=""/>
	<input type="hidden" name="smsYN" value=""/>
	<input type="hidden" name="emailYN" value=""/>
	<input type="hidden" name="rec_seq" value="<%=iSeq%>"/>
	<input type="hidden" name="app" value="<%=strApp%>"/>

	<input type="hidden" name="sex_user" />
	<input type="hidden" name="yyyymmdd_user" />


	<header>
		<h1>회원가입</h1>
		<h2 class="ico">ENURI</h2>
	</header>
	<fieldset class="memberfield" id="memberfield">
		<!-- 회원정보입력 -->
		<legend>회원정보입력, 인증방법</legend>
		<h3>회원정보입력<em>(필수)</em></h3>
		<div class="myinfo_form">
			<label class="tit">이름</label>
			<input type="text" name="name" id="name" class="txt" title="이름 입력" autocorrect="off" autocomplete="off" autocapitalize="off" value=""/>
			<span class="txt_red" id="nameAlertTxt"></span>
		</div>
		<div class="myinfo_form">
			<label class="tit">아이디</label>
			<input type="text" name="user_id" id="user_id" class="txt" title="아이디 입력" maxlength="12" autocorrect="off" autocomplete="off" autocapitalize="off" />
			<span class="txt_blue" id="idAlerTxt"></span>
			<input type="hidden" id="id_check_result" name="id_check_result" />
		</div>
		<div class="myinfo_form">
			<label class="tit">비밀번호<em class="info" onclick="$('#pwrule').show();">?</em></label>
			<input type="password" name="pass1" id="pass1" class="txt" maxlength="15"  title="비밀번호 입력(8~15자의 영문, 숫자, 특수문자 조합)"/>
			<span class="txt_blue" id="pwAlertTxt1"></span>
		</div>
		<div class="myinfo_form">
			<label class="tit">비밀번호확인</label>
			<input type="password" name="pass2" id="pass2" class="txt" maxlength="15" readonly/>
			<span class="txt_blue" id="pwAlertTxt2"></span>
		</div>
		<div class="myinfo_form">
			<label class="tit">이메일</label>
			<input type="text" name="user_email" id="user_email" class="txt" title="이메일 입력" autocorrect="off" autocomplete="off" autocapitalize="off" />
			<span class="txt_blue" id="emailAlerTxt"></span>
		</div>
		<!--// 회원정보입력 -->

		<!-- 인증방법 -->
		<h3>인증방법<em>(택1,필수)</em></h3>
		<div class="my_chk">
			<ul class="tab">
				<li><a href="#tab01">본인인증</a></li>
				<li><a href="#tab02">간편인증</a></li>
			</ul>
			<!-- 본인인증 -->
			<div class="contarea" id="tab01">
				<p class="phone_chk">본인 명의 휴대폰 번호로 본인확인 하기<br />본인인증 하면 <span>에누리앱에서 e머니 적립 가능!</span></p>
				<span class="wbtn"><a href="javascript:///" onclick="openMyCheckWin();">본인인증</a></span>
				<p class="phone">휴대폰번호
					<span id="phoneTxt">(본인인증 하시면 휴대폰번호가 자동 입력됩니다.)</span>
					<span id="spanPhoneNumber"></span>
				</p>
				<!-- p class="phone ok">인증된 번호 010-9047-2020</p-->
			</div>

			<!-- 간편인증 -->
			<div class="contarea" id="tab02">
				<p class="phone_chk">에누리에서 인증번호 발송 간편인증은 e머니적립 제한<br />(MY메뉴에서 본인인증 후 e머니적립 가능!)</p>
				<div class="self_chk">
					<span class="self_in">
						<label>휴대폰</label>
						<input type="text" name="sendHp" id="sendHp" autocorrect="off" autocomplete="off" autocapitalize="off" placeholder="' - ' 없이 입력" />
						<a href="javascript:///" id="btn_sendImg">인증요청</a>
						<span class="txt_blue" id="phoneAlertTxt"></span>
					</span>
					<span class="self_in">
						<label>인증번호</label>
						<input type="text" name="recvHp" id="recvHp" autocorrect="off" autocomplete="off" autocapitalize="off" />
						<a href="javascript:///" id="btn_ok">인증확인</a>
					</span>
					<span class="self_in">
						<label>휴대폰</label>
						<span class="end_txt">010-1234-1234</span>
						<a href="javascript:///">인증성공</a>
					</span>
				</div>
			</div>

			<!-- 상세정보입력 -->
			<div class="my_detail">
				<span class="info_more">상세정보입력</span>
				<div class="myinfo_form">
					<label class="tit">닉네임</label>
					<input type="text" name="nickname" id="nickname" class="ipt" value="" maxlength="15" onkeypress="CmdKeyPress();" autocorrect="off" autocomplete="off" autocapitalize="off" />
					<font id="fontNickName" color="red"><span id="spanChkNickName" style="width: 260px;"></span></font>
	      			<span id="spanChkNickName2" style="display:none;"></span>
				</div>

				<div class="myinfo_form">
					<label class="tit">성별</label>
					<ul class="gender">
						<li>
							<input type="radio" id="man" name="gender" value="">
							<label id="manLb" for="man" onClick="selGender('1')"><span>남자</span></label>
						</li>
						<li>
							<input type="radio" id="women" name="gender" value="">
							<label id="womenLb" for="women" onClick="selGender('0')"><span>여자</span></label>
						</li>
					</ul>
				</div>
				<%
				// 생년월일 연도 설정.
				int year, yearMin, yearMax;
				int yearResult, yearCount;
				//int month;
				//int date;

				List<String> yearList = new ArrayList<String>();
				Calendar now = Calendar.getInstance();

				year = now.get(Calendar.YEAR);
				yearMin = year - 110;
				yearMax = year - 14;
				yearCount = yearMax - yearMin;
				%>

				<div class="myinfo_form">
					<label class="tit">생년월일</label>
					<div class="birth s_yy">
						<select name="birthYear" id="birthYear" class="selbox" onChange="setBirth(); txtCheckBirthDay();">
							<option value="">년</option>
							<%
							// 동적으로 연도 뿌려주기
							yearResult = yearMin;
							for(yearResult = yearMax; yearResult>=yearMin; yearResult--){
							%>
							<option value="<%=yearResult%>"><%=yearResult%></option>
							<% } %>
						</select>
					</div>
					<div class="birth s_mm">
						<select name="birthMonth" id="birthMonth" class="selbox mon" onChange="setBirth(); txtCheckBirthDay();">
							<option value="">월</option>
							<%
							// 정적으로 월 뿌려주기
							for(int i=1; i<=12; i++){
							%>
								<option value="<%=i%>"><%=i%></option>
							<% } %>
						</select>
					</div>
					<div class="birth s_dd">
						<select name="birthDay" id="birthDay" class="selbox day" onChange="setBirth(); txtCheckBirthDay();">
							<option value="">일</option>
							<%
							// 정적으로 월 뿌려주기
							for(int i=1; i<=31; i++){
							%>
								<option value="<%=i%>"><%=i%></option>
							<% } %>
						</select>
					</div>
					<span class="txt_red" id="birthAlertMsg"></span>
					<!-- <span class="txt_red" id="birthTxt" style="display:none"></span>  -->
				</div>

				<div class="myinfo_form">
					<label class="tit">주소</label>
					<span class="adr">
						<input type="text" id="newzip" autocorrect="off" autocomplete="off" autocapitalize="off" />
						<a href="javascript:///" onclick="$('#post').show();">검색</a>
					</span>
					<input type="text" id="r_address1" autocorrect="off" autocomplete="off" autocapitalize="off" class="adr_in" />
					<input type="text" id="r_address2" autocorrect="off" autocomplete="off" autocapitalize="off" />
				</div>

				<div class="myinfo_form intxt">
					<label class="tit">에누리 소식지<br />수신여부</label>
					<input type="radio" name="newletter" class="in_radio" id="news_yes" value="1"/>
					<label class="chkarea" for="news_yes" onClick="selMailing(1);">예</label>

					<input type="radio" name="newletter" class="in_radio" id="news_no" value="0"/>
					<label class="chkarea" for="news_no" onClick="selMailing(2);">아니오</label>
				</div>

				<div class="myinfo_form intxt">
					<label class="tit">광고/이벤트<br />알림수신</label>
					<input type="checkbox" class="in_chk" id="sms" name="sms" value="Y"/>
					<label class="chkarea" for="sms" onclick="ad_yn_check('sms');">SMS/MMS</label>
					<input type="checkbox" class="in_chk" id="email" name="email" value="Y"/>
					<label class="chkarea" for="email" onclick="ad_yn_check('email');">e-mail</label>
				</div>
			</div>
			<!--// 상세정보입력 -->
		</div>
		<!--// 인증방법 -->
		<button type="button" class="btn_join" onClick="goJoin(document.joinForm);">가입하기</button>
		<!-- <button type="submit" class="btn_join" onClick="goJoin(document.joinForm);">가입하기</button> -->
	</fieldset>
</div>

<script type="text/javascript">
$(document).ready(function() {
	// 이름, 아이디, 비밀번호, 휴대폰번호, 인증번호
	var joinErrorFlagAry = [false, false, false, false, false, false];
	//tab
	$(".contarea").hide();
	$(".my_chk .tab li:first").addClass("on").show();
	$(".contarea:first").show();
	$(".my_chk .tab li").click(function() {
		$(".my_chk .tab li").removeClass("on");
		$(this).addClass("on");
		$(".contarea").hide();
		var activeTab = $(this).find("a").attr("href");
		$(activeTab).fadeIn();
		return false;
	});

	//상세정보
	$('.my_detail .info_more').click(function(){
		if ($(this).parent().hasClass("more")) {
			$(this).parent().removeClass("more");
		} else {
			$(this).parent().addClass("more");
	}});

	//주소검색
	$( ".adr_tab>li>a" ).click(function() {
		$(this).parent().addClass("on").siblings().removeClass("on");
		$(".adr_sel_list").empty();
		$("#road_keyword").val('');
		$("#addr_keyword").val('');
		return false;
	});

	$(".searchbtn").click(function(){

		var isNewType = $(this).attr("id") == "road_search" ? "Y" : "N";
		var keyword = isNewType == "Y" ? $("#road_keyword").val() : $("#addr_keyword").val();

		var url = "/mobilefirst/include/Addr.jsp?newtype="+ isNewType + "&keyword=" + keyword;
		//console.log("keyword : " + keyword + ", type : " + isNewType);
		$.ajax({
						 url: url,
						 dataType: 'json',
						 async: false,
						 success: function(data){
							 appendAddressList(isNewType, data);
						 },error: function(x, o, e){
									//alert(x.status + " : "+ o +" : "+e);
						 }
		 });
	});
	var joinObj = $("#memberfield");

	// 키 입력시 이름이 유효한지 확인함
	joinObj.find("#name").keyup(function (e) {
		var thisText = $(this).val();
		var checkHangul = true;

		for(var i=0; i<thisText.length; i++) {
			if(!((thisText.charCodeAt(i)>0x3130 && thisText.charCodeAt(i)<0x318F) ||
					(thisText.charCodeAt(i)>=0xAC00 && thisText.charCodeAt(i)<=0xD7A3))) {
				checkHangul = false;
			}
		}

		nameHangulCheckFlag = checkHangul;
		if( !checkHangul ) {
			var colorValue = "#bd0f0e";
			var textValue = "한글이름을 입력하세요.";
			$('#nameAlertTxt').text(textValue);
			joinErrorFlagAry[0] = false;
		} else {
			$('#nameAlertTxt').text("");
			joinErrorFlagAry[0] = true;
		}

	});

	// 입력창 벗어날 시 아이디가 유효한지 확인함
	// "탈퇴한 ID이거나, 이미 등록된 ID입니다."
	// 4글자 이상 영문, 숫자 입력하여 정상적인 아이디 일 때 -> "좋은 아이디 입니다."
	$("#user_id").on("input", function() {
		var user_idObj = $("#user_id");
		var inputId = user_idObj.val();
		// 한글자~세글자 입력 or 특수문자, 한글 입력되고 있을 때
		if(inputId.length <= 3){
			$('#idAlerTxt').text("4~12자의 영문자, 숫자만 입력하세요.");
			joinErrorFlagAry[1] = false;
		} else {
			$.ajax({
				type: "POST",
				url: "/join/Join_Id_Chk_Ajax_2010.jsp",
				dataType: "json",
				data: "id="+inputId+"&date="+(new Date()),
				success: function(data) {
					var chkId = data.chkId;
					var textValue = "";

					if(chkId=="0") {
						joinErrorFlagAry[1] = true;
						textValue = "좋은 아이디 입니다.";
					} else if(chkId == "-1") {
						textValue = "금칙어 입니다. 다시입력 해주세요.";
					} else if(chkId == "3") {
						textValue = "첫글자는 반드시 영문이어야 합니다.";
					} else {
						textValue = "탈퇴한 ID이거나, 이미 등록된 ID입니다.";
					}
					$("#id_check_result").val(chkId);
					$('#idAlerTxt').text(textValue);
				}
			});
		}
	});

	//비밀번호 입력시 비밀번호 규칙에 안 맞는 비번이 입력되고 있을 때
	//"8~15자의 영대/소문자, 숫자, 특수문자 중 3가지를 조합해주세요."
	joinObj.find("#pass1").on("input", function() {

		var user_idObj = $("#user_id");
		var inputId = user_idObj.val();
		var pass1Obj = $("#pass1");
		var inputPass = pass1Obj.val();
		passCheckFlag = false;
		if(inputPass.length>=8) {
			// 영문또는 숫자인지 확인하는 정규식
			passCheckFlag = chkPassCombine(inputPass);
			//console.log("passCheckFlag :"+passCheckFlag);
		}

		joinErrorFlagAry[2] = false;

		// 현재 아이디가 들어있는지 검사
		if(inputId !="" &&  inputPass.indexOf(inputId) >= 0)  {

			colorValue = "#bd0f0e";
			var textValue = "아이디를 포함한 비밀번호는 사용할 수 없습니다.";
			//showInputInfo($("#join .inputBoxInfoPass"), textValue, colorValue);
			$('#pwAlertTxt1').text(textValue);

		} else {

			if(passCheckFlag) {
				colorValue = "#1da900";
				//showInputInfo($("#join .inputBoxInfoPass"), "사용할수 있는 비밀번호 입니다.", colorValue);
				var textValue = "사용할 수 있는 비밀번호 입니다.";
				$('#pwAlertTxt1').text(textValue);
				joinErrorFlagAry[2] = true;
				$("#pass2").attr("readonly",false);
			} else {
				colorValue = "#bd0f0e";
				var textValue = "8~15자 영대/소문자, 숫자, 특수문자 중 3가지를 조합해주세요.";
				//showInputInfo($("#join .inputBoxInfoPass"), textValue, colorValue);
				$('#pwAlertTxt1').text(textValue);
			}
		}
		if( inputPass != $("#pass2").val() ){
			if($("#pass2").val().length > 0){
				$('#pwAlertTxt2').text("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
			}
		}
	});

	joinObj.find("#pass2").on("input", function() {

		var pass2Obj = $("#pass2");
		var inputPass = pass2Obj.val();
		var passCheckFlag = false;

		if(inputPass.length > 0 && inputPass.length >= $("#pass1").val().length){

			if(inputPass == $("#pass1").val()){
				passCheckFlag = true;
				$('#pwAlertTxt2').text("비밀번호가 일치 합니다.");
			}else{
				$('#pwAlertTxt2').text("");
				passCheckFlag = false;
			}
		}else{
			$('#pwAlertTxt2').text("");
		}

		if(!passwordcheck(inputPass,$("#pass1").val())){
			if(joinErrorFlagAry[2]){
				if($("#pass2").val().length > 0){
					$('#pwAlertTxt2').text("비밀번호가 일치하지 않습니다. 다시 입력해주세요");
				}
			}
			//return false;
		}
	});

	joinObj.find("#user_email").blur(function() {
		var emailObj = $("#user_email");
		var inputEmail = emailObj.val();

		// 이메일 체크
	    if(inputEmail == "") {
	    	$('#emailAlerTxt').text("이메일을 입력해 주십시오.");
	    	//alert("이메일을 입력해 주십시오.");
			//form.email1.focus();
			return false;
	    }

		// 이메일 중복체크
		if(inputEmail.length > 0 ){

			//var semail = form.email1.value + "@" + form.email2.value;
			//var semail = form.email1.value;

			if (!inputEmail.isemail()){
				$('#emailAlerTxt').text("잘못된 이메일 형식입니다. 다시 입력해주세요.");
				//alert("올바른 이메일 주소를 입력해 주십시오.");
				//form.email1.focus();
				return false;
			}


			// 이메일 중복체크 ajax
			var email_chk = false;

			$.ajax({
				method: "POST",
				url: "/member/join/Join_Email_Chk_Ajax.jsp",
				data: "email="+inputEmail,
				dataType: "json",
				async: false, // ture: 비동기, false: 동기

				success:function(result){

					// -1 이면 등록된 이메일이 없음.
					if(result.chkEmail=='-1'){
						email_chk = true;
						$('#emailAlerTxt').text("");
					}

					//showChkStr(result.chkId);

				}
			});


			//console.log("email_chk: " + email_chk);

			if(email_chk==false){
				$('#emailAlerTxt').text("이미 등록된 이메일 주소입니다.");
				//alert("이미 등록된 이메일 입니다.\n다른 이메일을 입력해 주십시오.")
				//form.email1.focus();
				return false;
			}
		}
	});

	joinObj.find("#nickname").on("input", function() {
		var nicknameObj = $("#nickname");
		var inputNick = nicknameObj.val();
		if(inputNick.length > 0 && inputNick.length < 17 && chkNickChar(inputNick)) {

			$.ajax({
				method: "POST",
				url: "/member/join/ajax/Join_Nickname_Chk_Ajax.jsp",
				data: "nickname="+encodeURIComponent(inputNick),
				dataType: "json",

				success:function(result){
					showNickChkStr(result.chkNick);
					//console.log("result.chkNick: " + result.chkNick);
				}
			});


		} else {

			//console.log('bbb');

			if(inputNick.length == 0) {
				$("#spanChkNickName").text("");
				$("#spanChkNickName2").text("");
			} else {
				$('#fontNickName').css('color', 'red');
				$("#spanChkNickName").text("한글1~8자, 영문2~16자까지 입력하세요.");
				$("#spanChkNickName2").text("3");
			}
		}
	});
	//간편인증 클릭시
	$("#btn_sendImg").click(function(){

		//CmdSpinLoading();

		var cs_tel = $("#sendHp").val();

		if(cs_tel.length==0) {
			joinErrorFlagAry[3] = false;
			//showInputInfoSendHpAuth("휴대폰 번호를 입력해 주세요.", 1);
			$('#phoneAlertTxt').text("휴대폰 번호를 입력해 주세요.");
			CmdSpinHide();
			return;
		}
		//showInputInfoSendHpAuth("", 1);
		$('#recvHpAlertTxt').text("");
		joinErrorFlagAry[3] = true;

		document.hFrame.location.href = "/mobilefirst/ajax/login/hpAuth_ajax.jsp?cs_tel="+cs_tel;

	});

	$("#btn_ok").click(function(){

		//var joinObj = $("#join");
		var cs_tel = $("#sendHp").val();
		var sms_no = $("#recvHp").val();
		var find_name = $("#name").val();

		if(cs_tel.length==0) {
			//showInputInfoSendHpAuth("휴대폰 번호를 입력해 주세요.", 1);

			$('#phoneAlertTxt').text("휴대폰 번호를 입력해 주세요.");
			joinErrorFlagAry[3] = false;
			return;
		}

		if(sms_no.length==0) {
			//showInputInfoRecvHpAuth("인증번호를 입력해 주세요.", 1);

			$('#recvHpAlertTxt').text("인증번호를 입력해 주세요.");
			joinErrorFlagAry[4] = false;
			return;
		}

		joinErrorFlagAry[3] = true;
		joinErrorFlagAry[4] = true;
		//showInputInfoRecvHpAuth("", 1);

		//CmdSpinLoading();

		document.hFrame.location.href = "/mobilefirst/ajax/login/hpAuthSendProc_ajax.jsp?cs_tel="+cs_tel+"&sms_no="+sms_no+"&find_name="+find_name;
	});


/* 	var birthYear = $("#birthYear").val();
	var birthMonth = $("#birthMonth").val();
	var birthDay = $("#birthDay").val();
	if( !((birthYear == '' && birthMonth == '' && birthDay == '') ||	//모두 빈 값이거나
			(birthYear != '' && birthMonth != '' && birthDay != ''))) {	//모두 값이 있을 때가 아니면 빈 값 찾기. 년 월 일 순서대로 찾는다.
				alert(birthYear);
				if(birthYear == '')
					$('#birthYear').change(function(){
						$('#birthTxt').html("태어난 년도를 선택하세요.");
						$('#birthTxt').show();
				        //alert( $('#birthYear option:selected').val() );
				    });
				else if(birthMonth == '')
					$('#birthMonth').change(function(){
						$('#birthTxt').html("태어난 월을 선택하세요.");
						$('#birthTxt').show();
				       // alert( $('#birthYear option:selected').val() );
				    });
				else if(birthDay == '')
					$('#birthMonth').change(function(){
						$('#birthTxt').html("태어난 일을 선택하세요.");
						$('#birthTxt').show();
				       // alert( $('#birthYear option:selected').val() );
				    });
	} */

});
function CheckValue(strValue)
{
        // id 유효성을 검증하는 정규식입니다 .
        var reg_exp = new RegExp("^[a-zA-Z][a-zA-Z0-9]{3,11}$","g");
        var match = reg_exp.exec(strValue);

        if (match == null || strValue <  4 || strValue > 12) {
                    //alert ("ID 형식이 잘못되었습니다 .");
                    return false;
        }

        return true;
}
function passwordcheck(pass1,pass2){
	if(pass1 == pass2){
		return true;
	}else{
		return false;
	}
}
//영문자, 숫자  입력 chk
function CmdKeyPress() {
	if(event.keyCode!=13) {
		if( !((event.keyCode >= 48 && event.keyCode <=57) || (event.keyCode >= 65 && event.keyCode <=90) || ("33,35,36,37,38,40,41,42,64,94".indexOf(event.keyCode.toString())>-1) || (event.keyCode >= 97 && event.keyCode <=122) )) {
			event.returnValue = false;
		}
	}
}
function appendAddressList(isNewType, post_data){
	var element = $(".adr_sel_list");
	var html = "";

	for(var idx in post_data.addrList){
		var data = post_data.addrList[idx];
		element.empty();
		if( data.newzip != null) {
			html += "<li onclick='CmdSetAddr(\""+data.newzip+"\", \""+data.strAddrDetail+"\");'>"
			html += 	"<span>" + data.newzip + "</span>";
			html += 	data.strAddrDetail;
			html += "</li>";
		}else{
			html += "<div class=\"adr_sel\">검색 결과가 없습니다.</div>";
		}
	}
	html = "<ul>" + html + "</ul>";
	element.html(html);

}

// 본인인증 팝업
function openMyCheckWin(e) {

	document.joinForm.certify.value = "";

	if(!e) var e = window.event;
	e.cancelBubble = true;
	e.returnValue = false;
	if(e.stopPropagation) {
		e.stopPropagation();
		e.preventDefault();
	}

	OpenWindowDetail("/member/join/auth/myCheck.jsp?func=myCheckOk","myCheck","300","130","no","no","yes","no","no","100","100");

}


// 본인인증 완료
function myCheckOk(mobile, conf_ci_key, conf_di_key, conf_phoneco){

	//alert('check!');
	//console.log("mobile: " + mobile);

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

	$("#tel1").val(tel1);
	$("#tel2").val(tel2);
	$("#tel3").val(tel3);
	form.certify.value = "2";	// 2:본인인증, 1:간편인증
	form.conf_ci_key.value = conf_ci_key;
	form.conf_di_key.value = conf_di_key;
	form.conf_phoneco.value = conf_phoneco;

	//$("#spanPhoneNumber").html("&nbsp;&nbsp;<font id='tel_show' color = '#000000'>" + tel1 + " - " + tel2 + " - " + tel3 + "</font>&nbsp;&nbsp;<font id='tel_show' color = '#7F7F7F'>(인증완료)</font>");
	$("#phoneTxt").hide();
	$("#spanPhoneNumber").html("&nbsp;&nbsp;<font id='tel_show' color = '#000000'>" + tel1 + " - " + tel2 + " - " + tel3 + "</font>&nbsp;&nbsp;<font id='tel_show' color = '#7F7F7F'>(인증완료)</font>");

	alert('본인인증에 성공했습니다.\n본인인증 하신 휴대폰번호로 \n회원정보가 등록됩니다.');

}

/*tab*/
/* $(function(){
	$( ".adr_tab>li>a" ).click(function() {
		$(this).parent().addClass("on").siblings().removeClass("on");
		return false;
	});
});
function maxlengthCheck(obj){
	if (obj.value.length > obj.maxLength){
		obj.value = obj.value.substring(0, obj.maxLength)
	}
} */

/*기본 주소 입력*/
function CmdSetAddr(newzip, addr){
	$("#newzip").val(newzip);
	$("#r_address1").val(addr);
	$('#post').hide();
}

//에누리소식 수신여부 라디오 선택
function selMailing(no){

	var radioMailing = '';
	var radioId = '#newletter'+no;

	if(no==1){
		$("#news_yes").prop("checked", true);
		$("#news_no").prop("checked", false);
	} else if(no==2){
		$("#news_no").prop("checked", true);
		$("#news_yes").prop("checked", false);
	}

}
function ad_yn_check(type){
	var id = '#'+type;
	var span = '#'+type+'_span';

	var chk_yn = $(id).is(":checked");


	if(chk_yn==false){
		$(span).attr('class','chk');
		$(id).prop('checked', true);
	} else {
		$(span).attr('class','unchk');
		$(id).prop('checked', false);
	}
}
//성별 라디오 선택
function selGender(gender){

	//console.log("selGender: " + gender);

	var form = document.joinForm;
	form.sex_user.value = gender;
}
//생년월일 설정
function setBirth(){

	var form = document.joinForm;

	var year = form.birthYear.value;
	var month = form.birthMonth.value;
	var day = form.birthDay.value;


	if(year=='출생년도') year='';
	if(month=='월') month='';
	if(day=='일') day='';

	if( month!='' && month<10) month = '0' + month;
	if( day!='' && day<10) day = '0' + day;


	var birthday = year + month + day;
	//console.log("birthday: " +birthday);

	form.yyyymmdd_user.value = birthday;

}
function chkNickChar(strNick) {
	var validNick = "`~!@#$%^&*()-_=+\\|]}[{;:'\"/?.>,<";
	if(strNick.length < 1) return false;
	for(var i=0;i<strNick.length;i++) {
		if(validNick.indexOf(strNick.charAt(i)) > -1)
			return false;
	}
	return true;
}

function showNickChkStr(originalRequest){

	var chkNick = originalRequest;

	if(chkNick == "0") {
		$('#fontNickName').css('color', 'blue');
		$("#spanChkNickName").text("");
		$("#spanChkNickName2").text(chkNick);
	} else if(chkNick == "-1") {
		$('#fontNickName').css('color', 'red');
		$("#spanChkNickName").text("금칙어 입니다. 다시입력 해주세요.");
		$("#spanChkNickName2").text("1");
	} else {
		$('#fontNickName').css('color', 'red');
		$("#spanChkNickName").text("이미 등록된 닉네임입니다.");
		$("#spanChkNickName2").text("2");
	}
}
/* function Is_nick_name(txt){

	var form = txt;
	for(var i = 0; i < form.length; i++){
		var chr = form.substr(i,1);
		chr = escape(chr);
		if(chr.charAt(1) == "u"){
			chr = chr.substr(2, (chr.length - 1));
			if((chr < "AC00") || (chr > "D7A3"))
			return false;
		}
		else{
			return false;
		}
	}
	return true;

} */

function goJoin(form){

	if(!joinCheckName(form.name)){	//이름 체크
		return false;
	} else if(!joinCheckId(form.user_id, form.id_check_result.value)){ //아이디 체크
		return false;
	} else if(!joinCheckPassword(form.pass1, form.pass2)){
		return false;
	} else if(!joinCheckEmail(form.user_email)){
		return false;
	} else if(!joinCheckBirthDay(form.birthYear, form.birthMonth, form.birthDay)) {
		return false;
	}else if(!joinCheckNickName(form.nickname)){
		return false;
	}

	console.log("Parameter all clear!");
}

function joinCheckName(name){

	if(name.value == ''){
		alert("이름을 입력해주십시오.");
		name.focus();
		return false;
	} else if(!name.value.isKorean()){
		alert("이름이 정확하지 않습니다. 한글명을 입력해 주십시오.");
		name.focus();
		return false;
	} else {
		return true;
	}
}

function joinCheckId(id, idCheckResult){
	//if(id.value == '' || idCheckResult == ''){
	if(id.value == ''){
		alert("아이디를 입력해 주십시오.");
		id.focus();
		return false;
	} else if(id.value.length <= 3) {
		alert("4~12자의 영문자, 숫자만 입력하세요.");
		id.focus();
		return false;
	} else if(idCheckResult == "-1") {
		alert("금칙어  입니다.\n다른 아이디를 입력해 주십시오.");
		id.focus();
		return false;
	} else if(idCheckResult == "1") {
		alert("이미 등록된 ID 입니다.\n다른 아이디를 입력해 주십시오.");
		id.focus();
		return false;
	} else if(idCheckResult == "3") {
		alert("첫글자는 반드시 영문이어야 합니다.");
		id.focus();
		return false;
	}

	return true;
}

function joinCheckPassword(pass1, pass2){
	if(pass1.value == "") {
		alert("비밀번호를 입력해 주십시오.");
		pass1.focus();
		return false;
	} else if (pass2.value == "") {
		alert("비밀번호 확인을 입력해 주십시오.");
		pass2.focus();
		return false;
	} else if(pass1.value != pass2.value) {
		alert("비밀번호가 비밀번호 확인과 서로 다릅니다.");
		form.pass1.select();
		return false;
	} else if(!chkPassCombine(pass1.value)) {
      alert("8~15자 영대, 소문자, 숫자, 특수문자 중 3가지를 조합해주세요.\n사용 가능한 특수문자 :  ! @ # $ % ^ & * ( ) , ");
      form.pass1.select();
      return false;
  	}

	return true;
}

function joinCheckEmail(email){

  if(email.value == "") {
    alert("이메일을 입력해 주십시오.");
		email.focus();

		return false;
  }

	// 이메일 중복체크
	if(email.value.trim().length <= 0 && !email.value.isemail()){
		alert("올바른 이메일 주소를 입력해 주십시오.");
		email.focus();

		return false;
	}

	$.ajax({
		method: "POST",
		url: "/member/join/Join_Email_Chk_Ajax.jsp",
		data: "f="+email.value,
		dataType: "json",
		async: false, // ture: 비동기, false: 동기

		success:function(result){

			// -1 이면 등록된 이메일이 없음.
			return result.chkEmail == '-1';
		}
	});

	return true;
}

function joinCheckBirthDay(birthYear, birthMonth, birthDay){
	var alertMsg = checkBirthDay(birthYear, birthMonth, birthDay);

	if(alertMsg)
		alert(alertMsg);

	return !alertMsg;	//메시지가 없을 때 조건문을 통과 시키기 위해 ! 붙여준다.
}
function checkBirthDay(birthYear, birthMonth, birthDay){
	var alertMsg;

	year = birthYear.value;
	month = birthMonth.value;
	day = birthDay.value;

	var isAllEmpty = (year == '' && month == '' && day == ''); 	// 모두 빈 값이거나
	var isAll = (year != '' && month != '' && day != '');				// 모두 값이 채워졌을 때는 클리어!

	if( !(isAll || isAllEmpty) ) {	//모두 값이 있을 때가 아니면 빈 값 찾기. 년 월 일 순서대로 찾는다.
				if(year == '')
					alertMsg = '태어난 년도를 선택하세요.'
				else if(month == '')
					alertMsg = '태어난 월을 선택하세요.'
				else if(day == '')
					alertMsg = '태어난 일을 선택하세요.'
	}

	return alertMsg;
}
function txtCheckBirthDay(){
	var form = document.joinForm;

	var alertMsg = checkBirthDay(form.birthYear, form.birthMonth, form.birthDay);
	var birthSpan = $('#birthAlertMsg');

	if(alertMsg){
		birthSpan.html(alertMsg);
		birthSpan.show();
	} else {
		birthSpan.html('');
		birthSpan.hide();
	}
}

function joinCheckNickName(nickname){
	var nick = nickname.value;

	if(nick == '')	// 닉네임이 비었으면 그냥 통과
		return true;

	if(nick.length > 17 && chkNickChar(nick)) {	// 글자수가 17자 이상이거나, 특수문자 있을 때? 통과 안시킴
		alert('한글1~8자, 영문2~16자까지 입력하세요.');
		return false;
	} else {	// 금칙어 또는 중복 체크
		$.ajax({
			method: "POST",
			url: "/member/join/ajax/Join_Nickname_Chk_Ajax.jsp",
			data: "nickname="+encodeURIComponent(nick),
			async: false,	// 결과를 바로 return 해야 하니깐 동기로
			dataType: "json",
			success:function(result){
				if(result.chkNick == '-1'){
					alert('금칙어 입니다. 다시입력 해주세요.');
 					return false;
				} else if(result.chkNick != '0'){
					alert('이미 등록된 닉네임입니다.');
 				 	return false;
				}
			}});
	}

	return true;

}


function isEmail(email){
    var re = /\S+@\S+\.\S+/;
    return re.test(email);
}
//인증번호 전송시에만 사용하는 예외처리
function jShowInputInfoSendHpAuth(txt) {

	$('#phoneAlertTxt').text(txt);

}
function showInputInfoSendHpAuth(txt) {
	$("#phoneAlertTxt").text(txt);
}
function CmdSpinHide(){

	$("#cm_loading").hide();

}
//인증번호 전송시에만 사용하는 예외처리
function showInputInfoRecvHpAuth(txt, colorType) {

	var colorVal = "";

	if(colorType==2) {
		colorVal = "#1da900";
	} else {
		colorVal = "#bd0f0e";
	}
	//showInputInfo($("#join .recvHpAuthInfo"), txt, colorVal);

	txt = txt.replace("<br>", "");

	//$('#recvHpAlertTxt').text(txt);
	alert(txt);

	CmdSpinHide();
}
</script>

</body>
<!-- <script type="text/javascript" src="/mobilefirst/member/join.js"></script> -->
<script language="JavaScript">
<!--
loginPageType = 2;
var backUrl = "<%=backUrl%>";
-->
</script>
<iframe id="hFrame" name="hFrame" frameborder="0" style="margin:0px;padding:0px;height:0px;width:0px;"></iframe>
</html>
