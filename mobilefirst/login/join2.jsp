<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.event.Members_Friend_Proc"%>
<%@ page import="com.enuri.util.http.ShortUrl"%>
<%@ page import="com.enuri.bean.member.Join_Data"%>
<%@ page import="com.enuri.bean.member.Join_Proc"%>
<jsp:useBean id="ShortUrl" class="ShortUrl" scope="page" />
<jsp:useBean id="Join_Data" class="com.enuri.bean.member.Join_Data">
<jsp:useBean id="Join_Proc" class="com.enuri.bean.member.Join_Proc">

<% String strApp = ChkNull.chkStr(request.getParameter("app"),"");%>
<%
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
						<div>
							<p class="location">
								<label>지역명</label><input type="text" class="post_search" />
								<button class="searchbtn">검색</button>
								<em>(동/읍/면/리/가)</em>
							</p>
							<div class="adr_sel">검색 후 해당하는 주소를 선택해 주세요.</div>
							<!-- 검색 후 리스트 -->
							<div class="adr_sel_list">
								<ul>
									<li><span>139-053</span>서울 노원구 월계3동 서울 노원구 월계3동 서울 노원구 월계3동</li>
									<li><span>139-053</span>서울 노원구 월계3동</li>
									<li><span>139-053</span>서울 노원구 월계3동</li>
									<li><span>139-053</span>서울 노원구 월계3동</li>
									<li><span>139-053</span>서울 노원구 월계3동</li>
									<li><span>139-053</span>서울 노원구 월계3동</li>
								</ul>
							</div>
							<!--//검색 후 리스트 -->
						</div>
					</li>
					<li>
						<a href="#">도로명 주소</a>
						<div>
							<p class="location">
								<label>도로명</label><input type="text" class="post_search" />
								<button class="searchbtn">검색</button>
								<em>*도로명+건물번호 : 퇴계로 18<br />*건물명 : 대우재단빌딩</em>
							</p>
							<div class="adr_sel">검색 후 해당하는 주소를 선택해 주세요.</div>
							<!-- 검색 후 리스트 -->
							<div class="adr_sel_list">
								<ul>
									<li><span>139-053</span>서울특별시 중구 퇴계로 18 (남대문로5가)</li>
									<li><span>139-053</span>서울 노원구 월계3동</li>
									<li><span>139-053</span>서울 노원구 월계3동</li>
									<li><span>139-053</span>서울 노원구 월계3동</li>
									<li><span>139-053</span>서울 노원구 월계3동</li>
									<li><span>139-053</span>서울 노원구 월계3동</li>
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
			<input type="text" name="name" id="name" class="txt" title="이름 입력" autocorrect="off" autocomplete="off" autocapitalize="off" />
			<span class="txt_red" id="nameAlertTxt"></span>
		</div>
		<div class="myinfo_form">
			<label class="tit">아이디</label>
			<input type="text" name="user_id" id="user_id" class="txt" title="아이디 입력" maxlength="12" autocorrect="off" autocomplete="off" autocapitalize="off" />
			<span class="txt_blue" id="idAlerTxt"></span>
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
			<input type="text" name="email" id="email" class="txt" title="이메일 입력" autocorrect="off" autocomplete="off" autocapitalize="off" />
			<span class="txt_blue" id="emailAlerTxt">이메일</span>
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
				<span class="wbtn"><a href="javascript:///">본인인증</a></span>
				<p class="phone">휴대폰번호 (본인인증 하시면 휴대폰번호가 자동 입력됩니다.)</p>
				<!-- p class="phone ok">인증된 번호 010-9047-2020</p-->
			</div>

			<!-- 간편인증 -->
			<div class="contarea" id="tab02">
				<p class="phone_chk">에누리에서 인증번호 발송 간편인증은 e머니적립 제한<br />(MY메뉴에서 본인인증 후 e머니적립 가능!)</p>
				<div class="self_chk">
					<span class="self_in"><label>휴대폰</label><input type="text" autocorrect="off" autocomplete="off" autocapitalize="off" placeholder="' - ' 없이 입력" /><a href="javascript:///">인증요청</a></span>
					<span class="self_in"><label>인증번호</label><input type="text" autocorrect="off" autocomplete="off" autocapitalize="off" /><a href="javascript:///">인증확인</a></span>
					<span class="self_in"><label>휴대폰</label><span class="end_txt">010-1234-1234</span><a href="javascript:///">인증성공</a></span>
				</div>
			</div>
			
			<!-- 상세정보입력 -->
			<div class="my_detail">
				<span class="info_more">상세정보입력</span>
				<div class="myinfo_form">
					<label class="tit">닉네임</label><input type="text" autocorrect="off" autocomplete="off" autocapitalize="off" />
				</div>

				<div class="myinfo_form">
					<label class="tit">성별</label>
					<ul class="gender">
						<li>
							<input type="radio" id="man" name="gender" value="">
							<label id="manLb" for="man"><span>남자</span></label>
						</li>
						<li>
							<input type="radio" id="women" name="gender" value="">
							<label id="womenLb" for="women"><span>여자</span></label>
						</li>
					</ul>
				</div>

				<div class="myinfo_form">
					<label class="tit">생년월일</label>
					<div class="birth s_yy">
						<select name="" class="selbox">
							<option value="">년</option>
							<option value="">1980</option>
							<option value="">1979</option>
							<option value="">1978</option>
							<option value="">1977</option>
							<option value="">1976</option>
							<option value="">1975</option>
							<option value="">1974</option>
							<option value="">1973</option>
							<option value="">1972</option>
							<option value="">1971</option>
							<option value="">1970</option>
						</select>
					</div>
					<div class="birth s_mm">
						<select name="" class="selbox mon">
							<option value="">월</option>
							<option value="">1</option>
							<option value="">2</option>
							<option value="">3</option>
							<option value="">4</option>
							<option value="">5</option>
							<option value="">6</option>
						</select>
					</div>
					<div class="birth s_dd">
						<select name="" class="selbox day">
							<option value="">일</option>
							<option value="">1</option>
							<option value="">2</option>
							<option value="">3</option>
							<option value="">4</option>
							<option value="">5</option>
							<option value="">6</option>
						</select>
					</div>
					<span class="txt_red">태어난 년도를 입력하세요.</span>
				</div>

				<div class="myinfo_form">
					<label class="tit">주소</label>
					<span class="adr"><input type="text" autocorrect="off" autocomplete="off" autocapitalize="off" /><a href="javascript:///" onclick="$('#post').show();">검색</a></span>
					<input type="text" autocorrect="off" autocomplete="off" autocapitalize="off" class="adr_in" />
					<input type="text" autocorrect="off" autocomplete="off" autocapitalize="off" />
				</div>

				<div class="myinfo_form intxt">
					<label class="tit">에누리 소식지<br />수신여부</label>
					<input type="radio" name="newletter" class="in_radio" id="news_yes" /><label class="chkarea" for="news_yes">예</label>
					<input type="radio" name="newletter" class="in_radio" id="news_no" /><label class="chkarea" for="news_no">아니오</label>
				</div>

				<div class="myinfo_form intxt">
					<label class="tit">광고/이벤트<br />알림수신</label>
					<input type="checkbox" class="in_chk" id="sms" /><label class="chkarea" for="sms">SMS/MMS</label>
					<input type="checkbox" class="in_chk" id="email" /><label class="chkarea" for="email">e-mail</label>
				</div>
			</div>
			<!--// 상세정보입력 -->
		</div>
		<!--// 인증방법 -->

		<button type="submit" class="btn_join">가입하기</button>
	</fieldset>
	
</div>

<script type="text/javascript">
$(document).ready(function() {
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
		return false;
	});

});
</script>	

</body>
<script type="text/javascript" src="/mobilefirst/js/login2.js"></script>
<script language="JavaScript">
<!--
loginPageType = 2;

var backUrl = "<%=backUrl%>";
-->

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
</script>
</html>