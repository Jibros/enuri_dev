<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.bean.event.Members_Friend_Proc"%>
<%@ page import="com.enuri.bean.event.Members_Friend_Proc"%>
<%

	//String IMG_ENURI_COM = ConfigManager.IMG_ENURI_COM;
	String ENURI_COM_SSL = "https://m.enuri.com:442";
	String serverName = request.getServerName();
	String strApp = "";

	Cookie[] carr = request.getCookies();
	try {
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("appYN")){
		    	strApp = carr[i].getValue();
		    	//break;
		    }
		}
	} catch(Exception e) {
	}

	String backUrl = ChkNull.chkStr(request.getParameter("backUrl"), "");
	String hotYN = ChkNull.chkStr(request.getParameter("hot"), "");

	%>
	<script language="javascript">
	var vAPP = "<%=strApp%>";
	var vBackUrl = "<%=backUrl%>";

	if(vAPP =="Y"){
		if(confirm("앱 업데이트가 필요합니다.\n\n업데이트 하시겠습니까?")>0){
			if( navigator.userAgent.indexOf("iPhone") > -1 ||
					navigator.userAgent.indexOf("iPod") > -1 ||
					navigator.userAgent.indexOf("iPad") > -1)
			{
				if(vBackUrl.indexOf("/deal/") > -1){
					window.location.href = "https://itunes.apple.com/kr/app/id944887654?freetoken=outlink";
				}else{
					window.location.href = "https://itunes.apple.com/kr/app/id476264124?freetoken=outlink";
				}
				setTimeout(function () {
					window.location.href = "close://";
				}, 500);
			}else{
				if(vBackUrl.indexOf("/deal/") > -1){
					window.location.href = "market://details?id=com.enuri.deal";
				}else{
					window.location.href = "market://details?id=com.enuri.android";
				}
				setTimeout(function () {
					window.location.href = "close://";
				}, 500);
			}
		}else{
			window.location.href = "close://";
		}
	}else{
		if(location.href.indexOf("dev.enuri.com") > -1){
			var vBackUrl = '<%=backUrl%>';
			vBackUrl = encodeURIComponent(vBackUrl);
			location.href='/member/login/login.jsp?rtnUrl='+vBackUrl;
		}else{
			var vBackUrl = '<%=backUrl%>';
			vBackUrl = encodeURIComponent(vBackUrl);
			if(vBackUrl.indexOf("www.enuri.com") > -1){
				location.href='https://www.enuri.com/member/login/login.jsp?rtnUrl='+vBackUrl;
			}else{
				location.href='https://m.enuri.com/member/login/login.jsp?rtnUrl='+vBackUrl;
			}
		}
	}
	</script>

	<%
	//추천인 로직
	//웹 &&  이전페이지가 게이트페이지일때
	int iSeq  = ChkNull.chkInt(request.getParameter("rec_seq"), 1);
	String strRecUserID = "";
	String strRec_Username = "";
	String strRec_Text = "";
	String strShorturl = "";

	boolean bRec = false;

	if(!strApp.equals("Y") ){
		//strRecUserID = "ksay33";
		Members_Friend_Proc members_friend_proc = new Members_Friend_Proc();

		strRecUserID = members_friend_proc.getRecommenderid(iSeq);

		Members_Proc members_proc = new Members_Proc();

		if(strRecUserID.length() > 0){
			strRec_Username = members_proc.getUserName(strRecUserID);
		}

		strRec_Text = strRec_Username + " ("+strRecUserID+")";

		if(strRec_Username.length() > 0 && strRecUserID.length() > 0 && iSeq >= 10000){
			bRec = true;
		}

		//strShorturl = ShortUrl.getExist_ShortUrl("http://m.enuri.com/mobilefirst/event/friend_gate.jsp?rec_seq="+iSeq);
	}

	// 아이폰 새버전이 올라가면
	// 밑에 ios예외처리 한부분들 수정해야함
	if(serverName.indexOf("stagedev.enuri.com")>-1 || serverName.indexOf("100.100.100.151")>-1 || serverName.indexOf("dev.enuri.com")>-1 || serverName.indexOf("my.enuri.com")>-1 ) {
		ENURI_COM_SSL = "";
	}

	if(StringUtils.contains(backUrl,"newpass.jsp?") || StringUtils.contains(backUrl,"find_result.jsp?")){
		backUrl = "/mobilefirst/Index.jsp";
	}
	//"http://dev.enuri.com/mobilenew/login/newpass.jsp?phoneNum=01038090522&userid=wiseroh";

	String car_flag = ChkNull.chkStr(request.getParameter("car_flag"), "");
	String pageType = ChkNull.chkStr(request.getParameter("pageType"), "1");


%>
<html>
<head>
<title></title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width">
<%@include file="/mobilefirst/include/common.html"%>
</head>
<body>

<iframe id="hFrame" name="hFrame" frameborder="0" style="margin:0px;padding:0px;height:0px;width:0px;"></iframe>

<script language="JavaScript">
<!--
backUrl = "<%=backUrl%>";
-->
</script>

<script type="text/javascript" src="/mobilenew/js/lib/jquery-2.1.1.min.js" charset="utf-8"></script>
<script type="text/javascript" src="/mobilefirst/js/login.js"></script>
<script language="JavaScript">
<!--

loginPageType = 1;

pageType = <%=pageType%>;
var ENURI_COM_SSL = "<%=ConfigManager.ENURI_COM_SSL%>";

var car_flag = "<%=car_flag%>";


if(backUrl.indexOf("/deal/mobile/main.deal") > 0 ){

	ga('send', 'pageview', {
       'page': '/mobilefirst/login/login.jsp',
       'title': '로그인_소셜모아'
    });

}

$(document).ready(function() {

	$(".pageHead").append("<a href='javascript:///' class='back' onclick=\"backButton()\"></a>");

	$(".btn_close").click(function(){

		$(".dim").hide();

	});

});

function backButton(){

	var iOS = /(iPad|iPhone|iPod)/g.test( navigator.userAgent );

	if(getCookie("appYN") == 'Y' ){
		if(backUrl.indexOf("hot=Y") > -1 ){
			window.history.back(-1);
		}else{
			location.href = "close://"
		}
	}else{
		if(getCookie("appYN") == 'Y' && iOS == true){
			location.href = "appcall://prev"
			return false;
		}else{
		  window.history.back(-1);
		}
	}
}

//회원가입 링크(친구추천, 추천인 있을때)
function goJoinFriend() {
	document.location.href = "/mobilefirst/login/join.jsp?app=<%=strApp%>&rec_seq=<%=iSeq%>&backUrl="+encodeURIComponent(document.location.href);
}

-->

</script>
<%@ include file="/mobilefirst/login/login_check.jsp"%>

<!-- 150812  휴면계정 레이어 -->
<div class="dim" style="display:none">
	<div class="restLayer">
		<a href="javascript:///" class="btn_close">닫기</a>
		<h2>고객님의 계정은<br /><span>휴면 상태</span> 입니다.</h2>
		<p class="txt"><span class="id"></span>님은<br />최근 1년 간 로그인 이력이 없는 회원으로,<br /><span>휴면 상태로 전환</span>되었습니다.</p>
		<div class="btnarea"><p>휴면 해제를 원하시면 아래 버튼을 클릭 하세요.</p><button class="rest_btn">휴면 해제 신청</button></div>
		<p class="txt02"><span>※</span>회원님의 개인정보 보호를 위해 , 회원가입 시 수집된<br />개인정보를 안전한 곳에 별도 보관 중 입니다.</p>
	</div>
</div>
<!--// 150812  휴면계정 레이어 -->

	<div id="memberWrap"
		<%
			if(StringUtils.contains(backUrl,"mobiledepart")) out.println("class='mobiledepart'");
			else if(StringUtils.contains(backUrl,"/deal/mobile/") || hotYN.equals("Y") ) out.println("class='mobiledeal'");
		%>
		>
		<div class="pageHead">
			<h1>로그인</h1>
		</div>
		<div id="container">
			<h2 class="ci">ENURI</h2>
			<form name="loginForm" action="<%=ENURI_COM_SSL%>/mobilefirst/ajax/login/loginProc_ajax.jsp?chkurl=http://m.enuri.com" method="post" target="hFrame">
			<input type="hidden" name="autologin" value="">
			<input type="hidden" id="appDeviceId" name="appDeviceId" value="">
			<input type="hidden" id="appDeviceType" name="appDeviceType" value="">
			<input type="hidden" id="app" name="app" value="<%=strApp%>"/>
			<fieldset class="loginField boxField">
				<legend>로그인 입력</legend>
				<p class="inputBox">
					<input type="text" class="txt" placeholder="아이디" title="아이디 입력" id="member_id" name="member_id"/>
					<span class="alerTxt"></span>
				</p>
				<p class="inputBox">
					<input type="password" class="txt" placeholder="비밀번호" title="비밀번호 입력" id="member_pass" name="member_pass"/>
					<span class="alerTxt"></span>
				</p>
				<div class="utilSection">
					<p class="left"><label><input type="checkbox" id="autoLogin" name="autoLogin" checked="checked"/> 자동 로그인</label></p>
					<a href="find.jsp?app=<%=strApp%>
					<%
					if(backUrl.contains("mobiledepart")) out.print("&type=mobiledepart");
					else if(backUrl.contains("deal")) out.print("&type=deal");
					%>
					">
					ID / 비번 찾기
					</a>
				</div>
				<p class="btnWrap">
					<a href="javascript:///" class="btnType3">로그인</a>
				</p>
				<%if(bRec){%>
				<span class="recom"><em>추천코드</em><%=strShorturl%></span>
				<p class="friendtxt">로그인을 하면 추천코드 자동등록!!</p>
				<input type="hidden" id="recom_id" name="recom_id" value="<%=strRecUserID%>">
				<%}%>
				<script type="text/javascript">
				/*레이어*/
				function onoff(id) {
					var mid=document.getElementById(id);
					if(mid.style.display=='') {
					mid.style.display='none';
					//goBackPage();
					location.href = "http://m.enuri.com/mobilefirst/Index.jsp";
				}else{
					mid.style.display='';
					}
				}
				function CmdInstall(param){
		            if(param == "1"){
		            	location.href = "http://m.enuri.com/mobilefirst/event/friend_promotion.jsp?from2=friend";
					}else{
						if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
			            	location.href = "https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8&freetoken=outlink";
			            }else if(navigator.userAgent.indexOf("Android") > -1){
				            location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Dramen_event%26utm_medium%3Devent_button%26utm_campaign%3Dpromotion_ramen_event_web";
				        }
		            }
				}
				function CmdEventThree(){
					location.href = "/mobilefirst/event/event_three.jsp?freetoken=event";
				}
				</script>
				<!-- 레이어1-->
				<!--
				<div class="dim" id="frlayer" style="display:none;">
					<div class="friendLayer">
						<h3 id="friendLayerName"><em>친구 추천 이벤트</em><a href="javascript:///" class="lyclose" onclick="onoff('frlayer')">창닫기</a></h3>
						<div class="boxarea">
							<p>앱에서 <em>추천 혜택</em>을 받으세요!</p>
							<button type="button" onclick="CmdInstall();">앱설치/실행하기</button>
						</div>
					</div>
				</div>

				 레이어2
				<div class="dim" id="frlayer02"  style="display:none;">
					<div class="friendLayer">
						<h3><em>친구 추천 이벤트</em><a href="javascript:///" class="lyclose" onclick="onoff('frlayer02')">창닫기</a></h3>
						<div class="boxarea">
							<p>앱 설치만 해도 <em>1,000점!</em><br />
							구매까지 하면 <em>5,000점 더!</em>
							</p>
							<button type="button" onclick="CmdEventThree();">추천 혜택 받기</button>
						</div>
					</div>
				</div>
				 -->
				<!--// 160418 -->
				<div class="lineBox">
					<p class="joinTxt">에누리닷컴 회원이 아니신가요?</p>
					<% if(StringUtils.contains(backUrl,"mobiledepart")){%>
						<a href="javascript:goJoin<%if(bRec){%>Friend<%}%>()" class="btnjoin">간편 회원가입</a>
                    <%}else if(StringUtils.contains(backUrl,"/deal/mobile/") || hotYN.equals("Y") ){%>
						<a href="javascript:goJoin()" class="btnjoin02">간편 회원가입</a>
                    <%}else{%>
                    <a href="javascript:goJoin<%if(bRec){%>Friend<%}%>()" class="btnjoin">간편 회원가입</a>
                    <%}%>
                 </div>

			</fieldset>
			</form>
		</div>
	</div>
</body>
</html>
<%@ include file="/mobilefirst/include/common_logger.html"%>
