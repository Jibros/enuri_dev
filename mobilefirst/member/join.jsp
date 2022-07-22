<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.member.Join_Data"%>
<%@ page import="com.enuri.bean.member.Join_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Post_Data"%>
<%@ page import="com.enuri.bean.knowbox.Post_Proc"%>


<jsp:useBean id="Join_Data" class="com.enuri.bean.member.Join_Data"/>
<jsp:useBean id="Join_Proc" class="com.enuri.bean.member.Join_Proc"/>
<jsp:useBean id="Post_Data" class="com.enuri.bean.knowbox.Post_Data" />
<jsp:useBean id="Post_Proc" class="com.enuri.bean.knowbox.Post_Proc" />

<%
	String strApp = ChkNull.chkStr(request.getParameter("app"),"");
	String strFlow = ChkNull.chkStr(request.getParameter("f"),"");
	String strAppid = ChkNull.chkStr(request.getParameter("appid"),"");	 //	appid

	if(strAppid != null && strAppid.length() > 4){
		strAppid = strAppid.substring(1,5);
	}

	if(1==1){
		String strHost = request.getServerName();
		response.sendRedirect("https://"+strHost+"/member/join/join.jsp");
		return;
	}
%>
<%

/***************************************************
이 파일은 SSL 서버에 업로드해야 합니다.
***************************************************/
//APP
	Cookie[] carr = request.getCookies();
	try {
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("appYN")){
		    	strApp = carr[i].getValue();
		    	break;
		    }
		}
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("appid")){
		    	strAppid = carr[i].getValue();
		    	break;
		    }
		}
	} catch(Exception e) {
	}

	String rtnurl = ConfigManager.RequestStr(request, "rtnurl", "/");	// 리턴 url
	String agree_chk1 = ConfigManager.RequestStr(request, "agree_chk1", "N");
	String agree_chk2 = ConfigManager.RequestStr(request, "agree_chk2", "N");
	String agree_chk3 = ConfigManager.RequestStr(request, "agree_chk3", "N"); // 개인정보 수집 선택
	String agree_chk4 = ConfigManager.RequestStr(request, "agree_chk4", "N"); // SMS,이메일 수신
	String agree_all = ConfigManager.RequestStr(request, "agree_all", "N");			//전체동의여부

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

	if(!agree_chk1.equals("Y") || !agree_chk2.equals("Y")){

		if(strApp.equals("Y")){
			response.sendRedirect(ENURI_COM_SSL+"/mobilefirst/member/agree.jsp?app=Y");
		}else{
			response.sendRedirect(ENURI_COM_SSL+"/mobilefirst/member/agree.jsp");
		}

	}

	//http -> https 로 넘겨줌
	String pUrl = request.getRequestURL().toString();
	String pUrl2 = request.getQueryString();

	/*if(pUrl.indexOf("http://www.enuri.com/") > -1 || pUrl.indexOf("http://m.enuri.com/") > -1 || pUrl.indexOf("http://dev.enuri.com/") > -1){
		pUrl = pUrl.replace("http://","https://");
		if(pUrl2 != null){
			pUrl = pUrl + "?"+pUrl2;
		}
		response.sendRedirect(pUrl);
		return;
	}*/

	/* String ENURI_COM_SSL = "https://m.enuri.com";
	String serverName = request.getServerName();

	// 아이폰 새버전이 올라가면
	// 밑에 ios예외처리 한부분들 수정해야함
	//if(serverName.indexOf("stagedev.enuri.com")>-1 || serverName.indexOf("124.243.126.151")>-1 || serverName.indexOf("dev.enuri.com")>-1  || serverName.indexOf("my.enuri.com")>-1 || serverName.indexOf("m.enuri.com")>-1 ) {
	//	ENURI_COM_SSL = "";
	//}
	if(serverName.indexOf("stagedev.enuri.com")>-1 || serverName.indexOf("124.243.126.151")>-1 || serverName.indexOf("dev.enuri.com")>-1) {
		ENURI_COM_SSL = "http://"+serverName;
	} */
	//추천인 로직
	//웹 &&  이전페이지가 게이트페이지일때

	int iSeq  = ChkNull.chkInt(request.getParameter("rec_seq"), 0);
	String strRecUserID = "";
	String strRec_Username = "";
	String strRec_Text = "";
	boolean bRec = false;
	String backUrl = ChkNull.chkStr(request.getParameter("backUrl"), "");
	String css ="";

	if(backUrl.contains("mobiledepart")) css = "mobiledepart";
	else if(backUrl.contains("deal")) css = "mobiledeal";

	String token = UUID.randomUUID().toString().replace("-","");



	if(!strApp.equals("Y")){
		if (!((ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Linux") >= 0 ) ||  (ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0))){
			response.sendRedirect("/member/join/join_personal.jsp");
			return;
		}
	}

%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="https://imgenuri.enuri.gscdn.com/images/mobilefirst/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<%//@include file="/mobilefirst/include/common.html"%>
	<!-- <script type="text/javascript" src="/carm/js/src/spin.js"></script>
	<script type="text/javascript" src="/common/js/function2.js"></script> -->
	<script type="text/javascript" src="/common/js/lib/jquery-1.9.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=ENURI_COM_SSL%>/css/home/default.css">
	<link rel="stylesheet" type="text/css" href="<%=ENURI_COM_SSL%>/css/home/member.css"/>
	<script type="text/javascript">
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
          (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
          m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
          })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
          ga('create', 'UA-52658695-3', 'auto');
     var _TRK_CC = 17;

	(function(a_,i_,r_,_b,_r,_i,_d,_g,_e){if(!a_[_b]){var d={queue:[]};_r.concat(_i).forEach(function(a){var i_=a.split("."),a_=i_.pop();i_.reduce(function(a,i_){return a[i_]=a[i_]||{}},d)[a_]=function(){d.queue.push([a,arguments])}});a_[_b]=d;a_=i_.getElementsByTagName(r_)[0];i_=i_.createElement(r_);i_.onerror=function(){d.queue.filter(function(a){return 0<=_i.indexOf(a[0])}).forEach(function(a){a=a[1];a=a[a.length-1];"function"===typeof a&&a("error occur when load airbridge")})};i_.async=1;i_.src="//static.airbridge.io/sdk/latest/airbridge.min.js";a_.parentNode.insertBefore(i_,a_)}})(window,document,"script","airbridge","init fetchResource setBanner setDownload setDownloads setDeeplinks sendSMS sendWeb setUserAgent setUserAlias addUserAlias setMobileAppData setUserId setUserEmail setUserPhone setUserAttributes clearUser setDeviceIFV setDeviceIFA setDeviceGAID events.send events.signIn events.signUp events.signOut events.purchased events.addedToCart events.productDetailsViewEvent events.homeViewEvent events.productListViewEvent events.searchResultViewEvent".split(" "),["events.wait"]);
	airbridge.init({
	    app: 'enuri',
	    webToken: 'f430f10352c54cc9aa2203b98e67be9e'
	});
	</script>
</head>
<body>
<%//@ include file="/mobilefirst/login/login_check.jsp"%>

<form name="joinForm" id="joinForm" method="post" autocomplete="off" action="/mobilefirst/member/join_proc.jsp" style="margin:0px;">
	<input type="hidden" name="rtnurl" value="/" />
	<input type="hidden" id="app" name="app" value="<%=strApp%>"/>
	<!-- <input type="hidden" name="marketing_use_yn"/> -->
	<input type="hidden" name="token" id="token" value="<%=token%>"/>


	<input type="hidden" name="certify" id="certify" value=""/>


	<input type="hidden" name="cs_tel" id="cs_tel" value=""/>
	<input type="hidden" name="tel1" id="tel1" value=""/>
	<input type="hidden" name="tel2" id="tel2" value=""/>
	<input type="hidden" name="tel3" id="tel3" value=""/>
	<input type="hidden" name="conf_ci_key">
	<input type="hidden" name="conf_di_key">
	<input type="hidden" name="conf_phoneco">
	<input type="hidden" name="conf_sex">
	<input type="hidden" name="conf_yyyymmdd">
	<input type="hidden" name="conf_date">


	<input type="hidden" name="sms" value=""/>
	<input type="hidden" name="email" value=""/>
	<input type="hidden" name="pin_yn" value="<%=agree_chk3%>"/>
	<input type="hidden" name="ad_yn" value="<%=agree_chk4%>"/>
	<input type="hidden" name="sex_user" />
	<input type="hidden" name="yyyymmdd_user" />


	<input type="hidden" name="rec_seq" value="<%=iSeq%>"/>

	<input type="hidden" name="isChecked"/>
	<input type="hidden" name="appid" value="<%=strAppid%>"/>

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
						<a href="#">도로명 주소</a>
						<div class="type2">
							<p class="location">
								<label>도로명</label><input type="text" class="post_search" id="road_keyword"/>
								<button type="button" class="searchbtn" id="road_search">검색</button>
								<em>*도로명+건물번호 : 퇴계로 18<br />*건물명 : 대우재단빌딩</em>
							</p>
							<div class="adr_sel">검색 후 해당하는 주소를 선택해 주세요.</div>
							<!-- 검색 후 리스트 -->
							<div class="adr_sel_list">
								<ul></ul>
							</div>
							<!--// 검색 후 리스트 -->
						</div>
					</li>
					<li>
						<a href="#">지번 주소</a>
						<div class="type1">
							<p class="location">
								<label>지역명</label><input type="text" class="post_search" id="addr_keyword"/>
								<button class="searchbtn" type="button" id="addr_search">검색</button>
								<em>(동/읍/면/리/가)</em>
							</p>
							<div class="adr_sel">검색 후 해당하는 주소를 선택해 주세요.</div>
							<!-- 검색 후 리스트 -->
							<div class="adr_sel_list">
								<ul></ul>
							</div>
							<!--//검색 후 리스트 -->
						</div>
					</li>
				</ul>
			</div>
		</div>
</div>
<!--// 주소검색 -->

<div class="memberwrap">

	<header>
		<a href="javascript:history.back(-1);" class="back"></a>
		<h1>회원가입</h1>
		<h2>ENURI</h2>
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
			<input type="password" name="pass2" id="pass2" class="txt" maxlength="15"/>
			<span class="txt_red" id="pwAlertTxt2"></span>
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


			<div class="contarea" id="tab01">
				<p class="phone_chk">
					고객님 명의의 휴대폰으로 본인인증을 해주세요.
					<span class="unchk" id="agree_span_CIDI" onclick="agree_check_CIDI();">
						<input onclick="agree_check_CIDI();" type="checkbox" class="in_chk" id="my" name="my" value="N" >
						<label for="my" onclick="agree_check_CIDI();">[필수]본인확인을 위해 휴대폰번호, 생년월일, 성별, 본인확인정보(CI,DI)를 수집하는 것에 동의합니다.</label>
					</span>
				</p>
				<span class="wbtn"><a href="javascript:///" onclick="openMyCheckIframe();">본인인증</a></span>
				<p class="phone">휴대폰번호
					<span id="phoneTxt">(본인인증 하시면 휴대폰번호가 자동 입력됩니다.)</span>
					<span id="spanPhoneNumber"></span>
				</p>
				<p class="auth_notice">본인명의 휴대폰 인증으로 가입 가능하며, 에누리 서비스를 자유롭게 이용할 수 있습니다.</p>
			</div>



			<!-- 간편인증 -->
			<div class="contarea" id="tab02">
				<p class="phone_chk">에누리에서 입력하신 번호로 인증번호를 발송합니다.<br />(가입 후 MY메뉴에서 본인인증 가능)</p>
				<div class="self_chk">
					<span class="self_in" id="aboutcertify1">
						<label>휴대폰</label>
						<input type="number" name="sendHp" id="sendHp" maxlength="11" pattern="\d*" oninput="maxlengthCheck(this)" autocorrect="off" autocomplete="off" autocapitalize="off" placeholder="' - ' 없이 입력" />
						<a href="javascript:///" id="btn_sendImg">인증요청</a>
						<span class="txt_red" id="phoneAlertTxt"></span>
					</span>
					<span class="self_in" id="about2certify1">
						<label>인증번호</label>
						<input type="number" name="recvHp" id="recvHp" pattern="\d*" autocorrect="off" autocomplete="off" autocapitalize="off" />
						<a href="javascript:///" id="btn_ok">인증확인</a>
						<span class="txt_blue" id="recvHpAlertTxt"></span>
					</span>
					<span class="self_in" id="certify1" style="display:none;">
						<label>휴대폰</label>
						<span class="end_txt" name="certify1_txt" id="certify1_txt"></span>
						<a href="javascript:///">인증성공</a>
					</span>
				</div>
				<p class="auth_notice">동일 번호로 1개 아이디만 가입 가능하며, 본인인증이 필요한 서비스 이용 시 제한됩니다.</p>
			</div>

			<% if(agree_chk3.equals("Y")){ %>
			<!-- 191022 [PC/M] ISMS결함 대응 수정 -->
			<!-- 상세정보입력 -->
			<!-- 191022 타이틀 추가 -->
			<h3>상세정보입력 <em>(선택)</em></h3>
			<!-- // -->
			<div class="my_detail">
				<div class="myinfo_form">
					<label class="tit">닉네임</label>
					<input type="text" name="nickname" id="nickname" class="ipt" value="" maxlength="15" onChange="CmdKeyPress();" autocorrect="off" autocomplete="off" autocapitalize="off" />
					<font id="fontNickName" color="red"><span id="spanChkNickName" style="width: 260px;"></span></font>
	      			<span id="spanChkNickName2" style="display:none;"></span>
				</div>

				<div class="myinfo_form">
					<label class="tit">성별</label>
					<ul class="gender" id="gender">
						<li class="male" onClick="selGender(this); return false;">
							<!-- 선택 시, input type="radio" checked="checked" 추가 -->
							<input type="radio" id="man" name="gender" >
							<label id="manLb" for="man">
								<span class="stripe man">남성</span>
							</label>
						</li>
						<li class="female" onClick="selGender(this); return false;">
							<input type="radio" id="women" name="gender" >
							<label id="womenLb" for="women">
								<span class="stripe women">여성</span>
							</label>
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
						<input type="text" name="newzip" id="newzip" autocorrect="off" autocomplete="off" autocapitalize="off" readonly />
						<a href="javascript:///" onclick="$('#post').show();">검색</a>
					</span>
					<input type="text" name="r_address1" id="r_address1" autocorrect="off" autocomplete="off" autocapitalize="off" class="adr_in" readonly />
					<input type="text" name="r_address2" id="r_address2" autocorrect="off" autocomplete="off" autocapitalize="off" />
				</div>

				<!-- <div class="myinfo_form intxt">
					<label class="tit">에누리 소식지<br />수신여부</label>
					<input type="radio" class="in_radio" id="mailing1" name="mailing" value="1"/>
					<label class="chkarea" for="news_yes" onClick="selMailing(1);">예</label>

					<input type="radio" class="in_radio" id="mailing2" name="mailing" value="0" />
					<label class="chkarea" for="news_no" onClick="selMailing(2);">아니오</label>
				</div> -->

				<!-- <div class="myinfo_form intxt">
					<label class="tit">광고/이벤트<br />알림수신</label>
					<input type="checkbox" class="in_chk" id="ad_sms_yn" name="ad_sms_yn" value="Y" onclick="ad_yn_check('ad_sms_yn');"/>
					<label class="chkarea" for="ad_sms_yn" onclick="ad_yn_check('ad_sms_yn');">SMS/MMS</label>
					<input type="checkbox" class="in_chk" id="ad_email_yn" name="ad_email_yn" value="Y" onclick="ad_yn_check('ad_email_yn');"/>
					<label class="chkarea" for="ad_email_yn" onclick="ad_yn_check('ad_email_yn');">e-mail</label>
				</div> -->

				<!-- 추가사항 -->
				<!-- <ul class="terms_div">
					<li>
						<div class="terms_chk">
							<input type="checkbox" class="in_chk" id="terms_enuri03" name="marketing_use_yn" onclick="ad_yn_check('terms_enuri03');" value="Y"/>
							<label for="terms_enuri03" class="chkarea" onclick="ad_yn_check('terms_enuri03');">개인정보 마케팅 및 광고에 이용 (선택)</label>
							<a href="javascript:///" target="_new" class="ex_all">전체</a>
						</div>
						<span class="txtmnt">- 동의를 거부하실 수 있으며, 동의하지 않아도 가입이 가능합니다.</span>
						scroll area
						<div class="terms_box">
							<div>
								<p>아래 목적을 위한 용도로 개인정보를 수집 및 활용할 수 있습니다.<br><br>
									<span>- 마케팅 및 광고에 활용하고, 신규 서비스(제품) 개발 및 특화 이벤트 등 광고성 정보를 전달</span>
									<span>- 인구통계학적 특성에 따른 서비스 제공 및 광고 게재</span>
									<span>- 접속 빈도 파악 또는 회원의 서비스 이용에 대한 통계 등을 위함</span>
								</p>
							</div>
						</div>
						//scroll area
					</li>
				</ul> -->
				<!-- 추가사항 -->
				<!-- 191022 설명 텍스트 추가 -->
				<p class="my_detail_notice"> 선택 정보를 입력하지 않아도  서비스 이용이 가능합니다.</p>
			</div>
			<% } %>
			<!--// 상세정보입력 -->
		</div>
		<!--// 인증방법 -->
		<button type="button" class="btn_join" onClick="goJoin(document.joinForm);">가입하기</button>

		<div class="mb_footer">
			<!-- container -->
			<div class="container">
				<p class="copyright">Copyright ⓒ SummercePlatform Inc. All rights reserved.</p>
			</div>
		</div>
	</fieldset>
</div>
<div class="dim" id="post_auth" style="display:none;">
	<div class="adr_search">
		<button class="btnClose" type="button" onclick="$('#post_auth').hide();">본인인증 레이어 닫기</button>
		<h2>에누리 가격비교</h2>
			<div class="adrarea">
				<p class="noticed">본인인증에 성공하였습니다.</p>
			</div>
			<div class="layerBtn">
				<button class="btnTxt" type="button" onclick="$('#post_auth').hide(); $( '.btnzzim' ).removeClass( 'on' );">닫기</button>
			</div>
	</div>
</div>

<script type="text/javascript">
$(document).ready(function() {
	var vApp = "<%=strApp%>";
	var vAgree = "<%=agree_all%>";
	if(vApp == "Y"){
		$("h1").hide();
	}
	if(vAgree == "Y"){
		$('.my_detail').addClass("more");
	}
	//애드브릭스 적용
	if(vApp == "Y")	{
		var strEvent = "member_join";
		try{
		    if(window.android){            // 안드로이드
		        window.android.igaworksEventForApp(strEvent);
		        window.android.airbridgeEventForApp("member_join","member","","");
		    }else{                                                        // 아이폰에서 호출
		    	window.location.href = "enuriappcall://igaworksEventForApp?strEvent="+ strEvent +"";
		    	window.location.href = "enuriappcall://airbridgeEventForApp?p1=member_join&p2=member&p3=&p4=";
		    }
		}catch(e){}
	}
	
	// 이름, 아이디, 비밀번호, 휴대폰번호, 인증번호
	var joinErrorFlagAry = [false, false, false, false, false, false]; 
	//tab
	$(".contarea").hide();
	$(".my_chk .tab li:last").addClass("on").show();
	$(".contarea:last").show();
	$(".my_chk .tab li").click(function() {
		$(".my_chk .tab li").removeClass("on");
		$(this).addClass("on");
		$(".contarea").hide();
		var activeTab = $(this).find("a").attr("href");
		$(activeTab).fadeIn();
		return false;
	});

	//주소검색
	$( ".adr_tab>li>a" ).click(function() {
		$(this).parent().addClass("on").siblings().removeClass("on");
		$(".adr_sel_list").empty();
		$("#road_keyword").val('');
		$("#addr_keyword").val('');
		return false;
	});

	$(".searchbtn").click(function(){
		//alert("btn click");
		var isNewType = $(this).attr("id") == "road_search" ? "Y" : "N";
		var keyword = isNewType == "Y" ? $("#road_keyword").val() : $("#addr_keyword").val();
		var url = "https://m.enuri.com/mobilefirst/member/Addr.jsp?newtype="+ isNewType + "&keyword=" + keyword;
		//console.log("keyword : " + keyword + ", type : " + isNewType);
		//alert("keyword : " + keyword + ", type : " + isNewType);
		//alert("url :" + url);
		$.ajax({

						 url: url,
						 dataType: 'json',
						 async: false,
						 success: function(data){
							 appendAddressList(isNewType, data);
						 },error: function(x, o, e){
							 //alert("error");
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
			$('#nameAlertTxt').css("color", "red");
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
			$('#idAlerTxt').css("color", "red");
			$('#idAlerTxt').text("4~12자의 영문자, 숫자만 입력하세요.");
			joinErrorFlagAry[1] = false;
		} else {
			$.ajax({
				type: "POST",
				url: "/mobilefirst/member/Join_Id_Chk_Ajax_2010.jsp",
				dataType: "json",
				data: "id="+inputId+"&date="+(new Date()),
				success: function(data) {
					var chkId = data.chkId;
					var textValue = "";

					if(chkId=="0") {
						joinErrorFlagAry[1] = true;
						$('#idAlerTxt').css("color", "#0375bb");
						textValue = "좋은 아이디 입니다.";
					} else if(chkId == "-1") {
						$('#idAlerTxt').css("color", "red");
						textValue = "금칙어 입니다. 다시입력 해주세요.";
					} else if(chkId == "3") {
						$('#idAlerTxt').css("color", "red");
						textValue = "4~12자의 영문자, 숫자만 입력하세요.";
					} else {
						$('#idAlerTxt').css("color", "red");
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
		if( inputPass != $("#pass2").val() ){
			if($("#pass2").val().length > 0){
				$('#pwAlertTxt2').css("color", "red");
				$('#pwAlertTxt2').text("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
			}
		}
		// 현재 아이디가 들어있는지 검사
		if(inputId !="" &&  inputPass.indexOf(inputId) >= 0)  {

			colorValue = "#bd0f0e";
			$('#pwAlertTxt1').css("color", "red");
			var textValue = "아이디를 포함한 비밀번호는 사용할 수 없습니다.";
			//showInputInfo($("#join .inputBoxInfoPass"), textValue, colorValue);
			$('#pwAlertTxt1').text(textValue);

		} else {

			if(passCheckFlag) {
				colorValue = "#1da900";
				$('#pwAlertTxt1').css("color", "#0375bb");
				var textValue = "사용할 수 있는 비밀번호 입니다.";
				$('#pwAlertTxt1').text(textValue);
				joinErrorFlagAry[2] = true;
			} else {
				$('#pwAlertTxt1').css("color", "red");
				var textValue = "8~15자 영대/소문자, 숫자, 특수문자 중 3가지를 조합해주세요.";
				$('#pwAlertTxt1').text(textValue);
			}
		}
		if( inputPass != $("#pass2").val() ){
			if($("#pass2").val().length > 0){
				$('#pwAlertTxt2').css("color", "red");
				$('#pwAlertTxt2').text("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
			}
		}
	});

	joinObj.find("#pass2").blur("input", function() {

		var pass2Obj = $("#pass2");
		var inputPass = pass2Obj.val();
		var passCheckFlag = false;

		if(inputPass.length > 0 && inputPass.length >= $("#pass1").val().length){

			if(inputPass == $("#pass1").val()){
				passCheckFlag = true;
				$('#pwAlertTxt2').css("color", "#0375bb");
				$('#pwAlertTxt2').text("비밀번호가 일치 합니다.");
			}else{
				$('#pwAlertTxt2').text("");
				passCheckFlag = false;
			}
		}else{
			$('#pwAlertTxt2').text("");
		}

		if(!passwordcheck($("#pass2").val(),$("#pass1").val())){
			if(joinErrorFlagAry[2]){
				if($("#pass2").val().length > 0){
					$('#pwAlertTxt2').css("color", "red");
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
	    	$('#emailAlerTxt').css("color", "red");
	    	$('#emailAlerTxt').text("이메일을 입력해 주십시오.");
			return false;
	    }

		// 이메일 중복체크
		if(inputEmail.length > 0 ){

			if (!inputEmail.isemail()){
				$('#emailAlerTxt').css("color", "red");
				$('#emailAlerTxt').text("잘못된 이메일 형식입니다. 다시 입력해주세요.");
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

			if(email_chk==false){
				$('#emailAlerTxt').css("color", "red");
				$('#emailAlerTxt').text("이미 등록된 이메일 주소입니다.");
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
				}
			});


		} else {

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
		$('#phoneAlertTxt').text("");
		//CmdSpinLoading();

		var cs_tel = $("#sendHp").val();
		var enuri_id = $("#user_id").val();

		if(cs_tel.length==0) {
			joinErrorFlagAry[3] = false;
			$('#phoneAlertTxt').text("휴대폰 번호를 입력해 주세요.");
			$('#phoneAlertTxt').css("color", "red");
			CmdSpinHide();
			return;
		}
		if(!joinCheckId(document.joinForm.user_id, $("#id_check_result").val())){ //아이디 체크
			return false;
		}

		if( $.isNumeric(cs_tel)==false ){
			$('#phoneAlertTxt').text("숫자만 입력해 주십시오");
			$('#phoneAlertTxt').css("color", "red");
			$("#sendHp").val('');
			return;
		}

		$('#recvHpAlertTxt').text("");
		joinErrorFlagAry[3] = true;

		document.hFrame.location.href = "/mobilefirst/member/hpAuth_ajax.jsp?cs_tel="+cs_tel+"&enuri_id="+enuri_id;

	});

	$("#btn_ok").click(function(){

		var cs_tel = $("#sendHp").val();
		var sms_no = $("#recvHp").val();
		$("#tel1").val('');
		$("#tel2").val('');
		$("#tel3").val('');

		if(cs_tel.length==0) {
			$('#phoneAlertTxt').text("휴대폰 번호를 입력해 주세요.");
			$('#phoneAlertTxt').css("color", "red");
			joinErrorFlagAry[3] = false;
			return;
		}
		if(sms_no.length==0) {
			$('#recvHpAlertTxt').text("인증이 필요합니다. 인증번호를 입력해주세요.");
			$('#phoneAlertTxt').css("color", "red");
			joinErrorFlagAry[4] = false;
			return;
		}
		if( $.isNumeric(sms_no)==false ){
			$('#recvHpAlertTxt').text("숫자만 입력해 주십시오");
			$('#phoneAlertTxt').css("color", "red");
			$("#recvHp").val('');
			return;
		}

		joinErrorFlagAry[3] = true;
		joinErrorFlagAry[4] = true;

		var loadUrl = "/mobilefirst/member/hpAuthSendProc_ajax.jsp?";
			loadUrl+= "cs_tel="+cs_tel+"&sms_no="+sms_no;
		$.ajax({
			  url: loadUrl,
			  dataType: 'json',
			  async: false,
			  success: function(data) {
				if(data){
					if(data.msg == "success"){
						document.joinForm.certify.value = "1";
						document.joinForm.isChecked.value = "true";
						var cTxt = $('#sendHp').val();
						$('#certify1_txt').text(cTxt);
						$('#certify1').show();
						$('#aboutcertify1').hide();
						$('#about2certify1').hide();
						<%-- var test = "<%= request.getSession(true).getAttribute("MEMJOIN_HP_CONF") %>"; --%>
						if(cs_tel.length==10){
							// substr(시작인덱스, 길이)
							$("#tel1").val(cs_tel.substr(0,3));
							$("#tel2").val(cs_tel.substr(3,3));	// 3자리
							$("#tel3").val(cs_tel.substr(6,4));	// 시작인덱스 6
						} else {
							$("#tel1").val(cs_tel.substr(0,3));
							$("#tel2").val(cs_tel.substr(3,4));	// 4자리
							$("#tel3").val(cs_tel.substr(7,4));	// 시작인덱스 7
						}
					}else if(data.msg == "timeout"){
						$('#recvHpAlertTxt').text("인증번호 입력시간이 초과되었습니다. 인증번호를 재전송해주세요.");
						alert("인증번호 입력시간이 초과되었습니다. 인증번호를 재전송해주세요.");

					}else if(data.msg == "5out"){
						$('#recvHpAlertTxt').text("5회 이상 잘못 입력하셨습니다. 인증번호를 재전송해주세요.");
						alert("5회 이상 잘못 입력하셨습니다. 인증번호를 재전송해주세요.");

					}else if(data.msg == "fail"){
						$('#recvHpAlertTxt').text("인증번호가 올바르지 않습니다.인증번호를 다시 입력하거나 재전송해주세요.");
						alert("인증번호가 올바르지 않습니다.인증번호를 다시 입력하거나 재전송해주세요.");
					}
				}

			  }
			});
		//document.hFrame.location.href = "/mobilefirst/member/hpAuthSendProc_ajax.jsp?cs_tel="+cs_tel+"&sms_no="+sms_no;
		//document.hFrame.location.href = "/mobilefirst/ajax/login/hpAuthSendProc_ajax.jsp?cs_tel="+cs_tel+"&sms_no="+sms_no+"&find_name="+find_name;
	});

});


function fail7days(){
	alert("탈퇴 후 7일 이후\n재인증이 가능합니다.");
	return;
	/* $(".myAuth").hide();
	$("#myAuthFail .mybox").html("탈퇴 후 7일 이후\n재인증이 가능합니다.");
	$("#myAuthFail").show(); */
}

function failchild(){
	$("#my").prop("checked", false);
	alert("에누리 가격비교는 만14세 이상 이용 가입 가능합니다.");
	return;
}


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
		if( !((event.keyCode >= 48 && event.keyCode <=57) || (event.keyCode >= 65 && event.keyCode <=90) || ("33,35,36,37,38,40,41,42,64,94".indexOf(event.keyCode+"")>-1) || (event.keyCode >= 97 && event.keyCode <=122) )) {
			event.returnValue = false;
		}
	}
}
function appendAddressList(isNewType, post_data){
	//alert("appendAddressList");
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

/*기본 주소 입력*/
function CmdSetAddr(newzip, addr){
	$("#newzip").val(newzip);
	$("#r_address1").val(addr);
	$('#post').hide();
}

//에누리소식 수신여부 라디오 선택
function selMailing(no){

	var radioMailing = '';
	var radioId = '#mailing'+no;

	if(no==1){
		$("#mailing1").prop("checked", true);
		$("#mailing2").prop("checked", false);
	} else if(no==2){
		$("#mailing2").prop("checked", true);
		$("#mailing1").prop("checked", false);
	}
}

function ad_yn_check(type){
	var isTermsChecked = $('input:checkbox[id="terms_enuri03"]').is(":checked");
	var smsYN = $('#ad_sms_yn');
	var emailYN = $('#ad_email_yn');

	//sms 혹은 email 수신 동의 시, 약관 동의 하지 않았을 경우
	if( (smsYN.is(":checked") || emailYN.is(":checked")) && !isTermsChecked) {
		alert("개인정보 마케팅 및 광고에 이용 동의가 필요합니다.");

		$('#ad_sms_yn').prop('checked', false);
		$('#ad_email_yn').prop('checked', false);
	}

}
/* function ad_yn_check(type){
	//개인정보 마케팅 및 광고에 이용 미 선택시 알럿, 비활성화
	if($('input:checkbox[id="terms_enuri03"]').is(":checked") == true){
		var id = '#'+type;

		var chk_yn = $(id).is(":checked");


		if(chk_yn==false){
			$(id).prop('checked', true);
		} else {
			$(id).prop('checked', false);
		}
	}else{
		alert("개인정보 마케팅 및 광고에 이용 동의가 필요합니다.");
		$(id).prop('checked', false);
		return false;
	}

} */
//성별 라디오 선택 여자-0, 남자-1
// 성별 라디오 선택
function selGender(vThis){

	//console.log("selGender: " + gender);
	var form = document.joinForm;
	var vThisInput = $(vThis).find("input[type=radio]");
	var vThisClass = $(vThis).attr("class");
	var vThisName = $(vThisInput).attr("name");
	var vThisChk = $(vThisInput).attr("checked");
	var gender = "";
	//form.sex_user.value = gender;

	if(vThisClass=="male"){
		gender = "1";
	}else{
		gender = "0";
	}

	if(typeof vThisName !== typeof undefined && vThisName !== false){
		$(".gender input:radio[name=gender]").removeAttr("checked");
		$(".gender input:radio[name=gender]").prop('checked', false);
		if(vThisChk=="checked"){
			gender = "";
			$(vThisInput).removeAttr("checked");
		}else{
			$(vThisInput).removeAttr("checked");

			$(vThisInput).attr("checked","checked");
			$(vThisInput).prop('checked', true);
		}
	}
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
		$('#fontNickName').css('color', '#0375bb');
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

function goJoin(form){
	if($(".my_chk .tab li:last").hasClass("on")){
 		ga('send', 'event', 'mf_member', 'join', "join_간편인증");
	}else{
		ga('send', 'event', 'mf_member', 'join', "join_본인인증");
	}
	if(!joinCheckName(form.name)){	//이름 체크
		return false;
	} else if(!joinCheckId(form.user_id, form.id_check_result.value)){ //아이디 체크
		return false;
	} else if(!joinCheckPassword(form.pass1, form.pass2)){
		return false;
	} else if(!joinCheckEmail(form.user_email)){
		return false;
	} else if(form.isChecked.value!="true"){
		alert("본인인증이나 간편인증이 필요합니다.");
		//return false; - ksay33
	}
	<% if(agree_chk3.equals("Y")){ %>
	else if(!joinCheckBirthDay(form.birthYear, form.birthMonth, form.birthDay)) {
		return false;
	} else if(!joinCheckAddr(form.newzip, form.r_address1, form.r_address2)) {
		return false;
	} else if(!joinCheckNickName(form.nickname)){
		return false;
	}
	<% } %>
	if(!confirm( '회원가입을 하시겠습니까?' ) ){
		return false;
	}


	form.submit();
	//console.log("Parameter all clear!");
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
		alert("대문자는 허용이 되지 않으며\n 첫글자는 반드시 영문이어야 합니다.");
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
		pass1.select();
		return false;
	} else if(!chkPassCombine(pass1.value)) {
      alert("8~15자 영대, 소문자, 숫자, 특수문자 중 3가지를 조합해주세요.\n사용 가능한 특수문자 :  ! @ # $ % ^ & * ( ) , ");
      pass1.select();
      return false;
  	}

	return true;
}

function joinCheckEmail(email){
	var chkYN = true;

	if(email.value == "") {
	  	alert("이메일을 입력해 주십시오.");
		email.focus();
		return false;

	}else if(email.value.trim().length <= 0 && !email.value.isemail()){
		alert("올바른 이메일 주소를 입력해 주십시오.");
		email.focus();
		return false;
	}else{
		$.ajax({
			method: "POST",
			url: "/member/join/Join_Email_Chk_Ajax.jsp",
			data: "email="+email.value,
			dataType: "json",
			async: false, // ture: 비동기, false: 동기

			success:function(result){
				//console.log(result.chkEmail);
				//-1 이면 등록된 이메일이 없음.

				if(result.chkEmail=='-1'){
					chkYN = true;
					return true;
				}else{
					alert("이메일을 확인해주세요.");
					chkYN = false;
					return false;
				}

			}

		});
	}
	return chkYN;
}
function joinCheckAddr(newzip, r_address1, r_address2){
	var addr = r_address2.value;
	var first = newzip.value;
	var second = r_address1.value;

	if(addr == '')	// 세번째 주소 입력박스가  비었으면 그냥 통과
		return true;

	if(first==''||second=='') {	//첫번째 입력박스나 두번째 입력박스가 비었으면 알럿
		alert("주소를 정확히 입력해주세요.");
		return false;
	}else{
		return true;
	}
}

function joinCheckBirthDay(birthYear, birthMonth, birthDay){
	var alertMsg = checkBirthDay(birthYear, birthMonth, birthDay);

	if(alertMsg)
		alert(alertMsg);

	return !alertMsg;	//메시지가 없을 때 조건문을 통과 시키기 위해 ! 붙여준다.
}
function checkBirthDay(birthYear, birthMonth, birthDay){
	var alertMsg = "";

	year = birthYear.value;
	month = birthMonth.value;
	day = birthDay.value;

	var isAllEmpty = (year == '' && month == '' && day == ''); 	// 모두 빈 값이거나
	var isAll = (year != '' && month != '' && day != '');				// 모두 값이 채워졌을 때는 클리어!

	if( !(isAll || isAllEmpty) ) {	//모두 값이 있을 때가 아니면 빈 값 찾기. 년 월 일 순서대로 찾는다.
		if(year == '')
			alertMsg = '태어난 년도를 선택하세요.';
		else if(month == '')
			alertMsg = '태어난 월을 선택하세요.';
		else if(day == '')
			alertMsg = '태어난 일을 선택하세요.';
	}

	if(month!=''){
		var user_birth = year+pad2(month)+pad2(day);
		var vAge = diffBirth(user_birth);

		if(vAge && month!=''){
			alertMsg = '에누리 가격비교는 만14세 이상 가입 가능합니다.';
	  	}
	}
	return alertMsg;
}

function diffBirth(birth){

	var date = new Date();
    var year = date.getFullYear();
    var month = (date.getMonth() + 1);
    var day = date.getDate();
    var mmdd = pad2(month) + '' + pad2(day);

    var birthyyyy = birth.substr(0, 4);
    var birthmmdd = birth.substr(4, 4);

    var age = 0;

    if(mmdd < birthmmdd){
 		age = year - birthyyyy - 1;
	}else{
		age = year - birthyyyy;
    }

    if(age < 14){
		return true;
	}else{
		return false;
	}
}

function pad2(n) { return (n > 0 && n < 10  ? '0' : '') + n; }

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

	var chkYN = true;

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
					chkYN = false;
 					return false;
				} else if(result.chkNick != '0'){
					alert('이미 등록된 닉네임입니다.');
					chkYN = false;
 				 	return false;
				}
			}});
	}
	return chkYN;
}


function isEmail(email){
    var re = /\S+@\S+\.\S+/;
    return re.test(email);
}

//test 휴대폰 유효성 검사(IOS 추가)
function maxlengthCheck(object){
	if (object.value.length > object.maxLength){
		object.value = object.value.slice(0, object.maxLength);
	}
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

	txt = txt.replace("<br>", "");

	alert(txt);

	CmdSpinHide();
}
//본인인증 CI, DI 동의 체크
function agree_check_CIDI(){

	var agree_id = '#my';
	var agree_span = '#agree_span_CIDI';

	var chk_yn = $(agree_id).is(":checked");
	//console.log('agree chk_yn: ', chk_yn);

	if(chk_yn==false){
		$(agree_span).attr('class','chk');
		$(agree_id).prop('checked', true);
	} else {
		$(agree_span).attr('class','unchk');
		$(agree_id).prop('checked', false);
	}

}
//본인인증 iframe
function openMyCheckIframe(e) {

	// 본인인증 CI, DI 동의 체크
	var chkCIDIyn = $("#my").is(":checked");
	if(chkCIDIyn!=true){
		alert('CI,DI 수집 및 이용안내에 동의해주세요.');
		return false;
	}

	document.joinForm.isChecked.value = "";
	cmdCheckPlusReal();
}
function failMyCheckOk(){
	$(".noticed").text("본인인증에 실패하였습니다.\n본인 명의의 휴대폰번호로 다시 시도해 주세요.");
	$("#post_auth").show();
}
//본인인증 완료
function myCheckOk(mobile, conf_ci_key, conf_di_key, conf_phoneco, conf_name, myauth){ //*****conf_name 추가

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
	form.name.value = conf_name;	//*****추가


	form.isChecked.value = "true";

	$("#phoneTxt").hide();

	$(".noticed").text("본인인증에 성공하였습니다.");
	$("#post_auth").show();
	$("#spanPhoneNumber").html("&nbsp;&nbsp;<font id='tel_show' color = '#000000'>" + tel1 + " - " + tel2 + " - " + tel3 + "</font>&nbsp;&nbsp;<font id='tel_show' color = '#7F7F7F'>(인증완료)</font>");

	$("#name").attr("readonly",true); //*****
	//alert('본인인증에 성공했습니다.\n본인인증 하신 휴대폰번호로 \n회원정보가 등록됩니다.');

}
var minute = "5";
var second = 0;
var vAuthTime;

function authTime(){
	minute = "5";
	second = 0;
	vAuthTime = setInterval("authTime2()",1000);
}

function authTime2(){
	if(second == -1){
		minute = minute - 1;
		second = 59
	}

	if(second < 10){
		textS = "0" + second;
	}else{
  		textS = second;
 	}
 	var s = minute + ':' + textS;

	if(minute == 0 && second == 0){
		clearInterval(vAuthTime);
	}
	second--;
 	$("#btn_sendImg").text(s);
}
function chkPassCombine(pw){
    var matchNum = 0;

    var arrReg = [
                  new RegExp("^.*[a-z]+.*$","g"),
                  new RegExp("^.*[A-Z]+.*$","g"),
                  new RegExp("^.*[0-9]+.*$","g"),
                  new RegExp("^.*[!@#\$%\^\&\*\(\)]+.*$","g")
    ];

    var allowReg = new RegExp("^[A-z0-9,!,@,#,\$,%,\^,\&,\*,\(,\)]{8,15}$");

    if(pw.match(arrReg[0]))
        ++matchNum;
    if(pw.match(arrReg[1]))
        ++matchNum;
    if(pw.match(arrReg[2]))
        ++matchNum;
    if(pw.match(arrReg[3]))
        ++matchNum;

    if(matchNum>=3 && pw.match(allowReg))
        return true;
    else
        return false;
}

String.prototype.isemail = function() {
	  var flag, md, pd, i;
	  var str;

	  if ( (md = this.indexOf("@")) < 0 )
	     return false;
	  else if ( md == 0 )
	     return false;
	  else if (this.substring(0, md).search(/[^.A-Za-z0-9_-]/) != -1)
	     return false;
	  else if ( (pd = this.indexOf(".")) < 0 )
	     return false;
	  else if ( (pd + 1 )== this.length || (pd - 1) == md )
	     return false;
	  else if (this.substring(md+1, this.length).search(/[^.A-Za-z0-9_-]/) != -1)
	     return false;
	  else
	     return true;
	}
String.prototype.isKorean = function() {
	Unicode = this.charCodeAt(0);
	if ( !(44032 <= Unicode && Unicode <= 55203) )
		return false;
	else
		return true;
}

//본인인증
/* if(form.isChecked.value!="true") {
	alert("본인인증이나 간편인증이 필요합니다.");
	return false;
} */
//title생성
var vTitle = "회원가입";

try{
		window.android.getTitle(vTitle);
}catch(e){}
</script>

</body>
<!-- <script type="text/javascript" src="/mobilefirst/member/join.js"></script> -->
<script language="JavaScript">
<!--
loginPageType = 2;
var backUrl = "<%=backUrl%>";
-->
</script>
</form>
<iframe name=urlCheck width=0 height=0 frameborder=0 marginheight=0 marginwidth=0 scrolling=auto style=visible:false></iframe>
<iframe id="hFrame" name="hFrame" frameborder="0" style="margin:0px;padding:0px;height:0px;width:0px;"></iframe>
<%@ include file="/mobilefirst/member/inc_myCheck.jsp"%>
</html>
