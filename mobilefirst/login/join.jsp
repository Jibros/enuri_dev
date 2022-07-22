<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.event.Members_Friend_Proc"%>

<% String strApp = ChkNull.chkStr(request.getParameter("app"),"");%>
<%
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

	String ENURI_COM_SSL = "https://m.enuri.com:442";
	String serverName = request.getServerName();

	// 아이폰 새버전이 올라가면
	// 밑에 ios예외처리 한부분들 수정해야함
	if(serverName.indexOf("stagedev.enuri.com")>-1 || serverName.indexOf("100.100.100.151")>-1 || serverName.indexOf("dev.enuri.com")>-1  || serverName.indexOf("my.enuri.com")>-1 || serverName.indexOf("m.enuri.com")>-1 ) {
		ENURI_COM_SSL = "";
	}

	String backUrl = ChkNull.chkStr(request.getParameter("backUrl"), "");
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
	location.href='https://m.enuri.com/mobilefirst/member/agree.jsp?rtnUrl=<%=backUrl%>'; 
}
</script>  

<%
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
		//strShorturl = ShortUrl.getExist_ShortUrl("http://m.enuri.com/mobilefirst/event/friend_gate.jsp?rec_seq="+iSeq);
	}
	
	
	
	String css ="";  
	
	if(backUrl.contains("mobiledepart")) css = "mobiledepart"; 
	else if(backUrl.contains("deal")) css = "mobiledeal";
	
	String token = UUID.randomUUID().toString().replace("-","");

%> 

<html>
<head>
<title></title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width">
<%@include file="/mobilefirst/include/common.html"%>
<script type="text/javascript" src="/carm/js/src/spin.js"></script>
<script type="text/javascript" src="/common/js/function.js"></script>
<style type="text/css">
.ico_guide{display:block;width:23px;height:23px;position:absolute;top:8px;right:6px;background:url("http://imgenuri.enuri.gscdn.com/images/mobilefirst/ico_join_question.png") no-repeat 0 0;background-size:contain;text-indent:-9999em;}
.dim {display:none;position: fixed; left: 0; top: 0; width: 100%; height: 100%; background:url("http://imgenuri.enuri.gscdn.com/images/mobilefirst/bg_join_dim.png") repeat 0 0;background-size:10px 10px;}
.pop {position: absolute;top:50%;margin-top:-79px; left: 20px;right:20px;background:#ffffff}
.pop .header{position:relative;height:35px;line-height:35px;background:#e6e8eb;border-bottom:1px solid #d5d9de;box-sizing:border-box;-webkit-box-sizing:border-box;}
.pop .header .tit{padding-left:11px;font-weight:bold;font-size:14px;color:#333;}
.pop .header .btn_close{position:absolute;display:block;top:9px;right:10px;;width:17px;height:17px;background:url("http://imgenuri.enuri.gscdn.com/images/mobilefirst/ico_join_close.png") no-repeat 0 0;background-size:contain;text-indent:-9999em;} 
.pop .con{padding:14px 11px;font-size:12px;color:#7d7d7d;}
.pop .con li{margin-top:15px;padding-left:7px;background:url("http://imgenuri.enuri.gscdn.com/images/mobilefirst/ico_join_dot.png") no-repeat 0px 7px;background-size:3px 3px;}
.pop .con li:first-child{margin-top:0px;}
</style>
</head>
<body>
<%@ include file="/mobilefirst/login/login_check.jsp"%>
<div class="dim" style="display: none;">
    <div class="pop">
        <div class="header">
            <div class="tit">비밀번호 규칙 안내</div>
            <a href="#" class="btn_close">닫기</a>
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

<div class="join_form">

<form name="joinForm" id="joinForm" method="post" autocomplete="off" action="<%=ENURI_COM_SSL%>/mobilefirst/ajax/login/joinProc_ajax.jsp?chkurl=http://m.enuri.com" style="margin:0px;">
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

	<div id="cm_loading" style="display:block;position:absolute;z-index:999999;width:1px;height:1px;"></div>
	<div id="memberWrap" class="agreeWrap <%=css%>" >
		<div class="pageHead">
			<h1>회원가입</h1>
		</div>
		<div id="container"   >
			<fieldset class="memberField boxField">
				<legend>회원가입 입력</legend>
				<p class="inputBox">
					<input type="text" name="name" id="name" class="txt" placeholder="이름" title="이름 입력" />
					<span class="alerTxt" id="nameAlertTxt"></span>
				</p>
				<p class="inputBox">
					<span class="inBtn">
						<input type="text" name="user_id" id="user_id" class="txt" placeholder="아이디" title="아이디 입력" maxlength="12" />
						<span class="btnBox"><button type="button" id="check_id" class="btnTxt" style="width:90px;">중복체크</button></span>
					</span>
					<span class="alerTxt" id="idAlerTxt"></span>
				</p>
				<p class="inputBox">
					<input type="password" name="pass1" id="pass1" class="txt" maxlength="15"  title="비밀번호 입력(8~15자의 영문, 숫자, 특수문자 조합)" placeholder="비밀번호"  />
					<span class="alerTxt" id="pwAlertTxt1"></span>
					<span class="ico_guide">비밀번호 설정 가이드</span>
				</p>
				<p class="inputBox">
					<input type="password" name="pass2" id="pass2" class="txt" maxlength="15" placeholder="비밀번호 확인" readonly/>
					<span class="alerTxt" id="pwAlertTxt2" ></span>
				</p>
				<p class="inputBox">
					<span class="inBtn">
						<input type="number" name="sendHp" id="sendHp" class="txt" placeholder="휴대폰번호" title="휴대폰 번호 입력" />
						<span class="btnBox"><button type="button" id="btn_sendImg" class="btnTxt" style="width:90px;">인증번호 전송</button></span>
					</span>
					<span class="alerTxt" id="phoneAlertTxt"></span>
				</p>
				<p class="inputBox" id="recvInputBox">
					<span class="inBtn"  id="cerkyN">
						<input type="number" name="recvHp" id="recvHp" class="txt" placeholder="인증번호" title="인증번호 입력" />
						<span class="btnBox"><button type="button" class="btnTxt" style="width:90px;" id="btn_ok">인증 확인</button></span>
					</span>
					<span class="inBtn" id="cerkyY" style="display:none">
						인증완료
					</span>					
					<span class="alerTxt" id="recvHpAlertTxt"></span>
				</p>
				<!-- 
				<div class="utilSection">
					<p class="left"><label><input type="checkbox" id="useAcessYN" /> 이용약관</label></p>
					<a href="javascript:///" class="link" onclick="showTerms()">보기</a>
				</div>
				<div class="utilSection">
					<p class="left"><label><input type="checkbox" id="infoAcessYN" /> 개인정보취급방침</label></p>
					<a href="javascript:///" class="link" onclick="$('#privacyWrap').show();">보기</a>
				</div>
				 -->
				<div class="agree_chk">
					<div class="joinm">
						<p class="left"><label><input type="checkbox" id="useAcessYN"> 에누리 이용약관 동의(필수)</label></p>
						<a href="javascript:///" class="link" onclick="showTerms()">보기</a>
					</div>
					<div class="joinm">
						<p class="left"><label><input type="checkbox" id="infoAcessYN"> 개인정보 수집 및 이용 동의(필수)</label></p>
						<a href="javascript:///" class="link" onclick="privacyWrap();">보기</a>
					</div>
					<div class="joinm">
						<p class="left"><label><input type="checkbox" id="marketingYN_cb"> 개인정보 마케팅 및 광고 이용(선택)</label></p>
						<a href="javascript:///" class="link" onclick="showMarketing()">보기</a>
					</div>
					<div class="joinm">
						<p class="left"><label><input type="checkbox" id="smsYN_cb"> SMS, MMS 수신 (선택)</label></p>
						<p class="left" style="padding-left:20px"><label><input type="checkbox" id="emailYN_cb"> E-mail 수신 (선택)</label></p>
					</div>
				</div>
				
				
				<p class="alerTxt" id="acessCheck"></p>
				<div class="lineBox">
					<%if(bRec){%>
					<span class="recom"><em>추천코드</em><%=strShorturl%></span>
					<%}%>
					<p class="btnWrap"><a href="javascript:///" class="btnType3" onclick="joinBtnClick()">회원가입 하기</a></p>
				</div>
			</fieldset>
		</div>
	</div>
</div>

</body>
</form>
<iframe id="hFrame" name="hFrame" frameborder="0" style="margin:0px;padding:0px;height:0px;width:0px;"></iframe>
<script type="text/javascript" src="/mobilefirst/js/login.js"></script>
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



//회원가입 버튼
function joinBtnClick(){

	var name = $("#name").val();
	var userId = $("#user_id").val();
	var pass1 = $("#pass1").val();
	var pass2 = $("#pass2").val();
	
	var sendHp = $("#sendHp").val(); //핸드폰 번호
	var recvHp = $("#recvHp").val(); //인증번호

	name = name.trim();
	$("#name").val(name)

	if(name == '' ){
		alert("이름을 입력해주세요.");
		$("#name").focus();
		//joinErrorFlagAry[0] = false;	
		return false;
	}else if(!joinErrorFlagAry[0]){
		alert("이름을 확인해주세요.");
		$("#name").focus();
		return false;
	}else if( !Is_nick_name(name) ){
		alert("완성형 한글입력 만 가능합니다.");
		$("#name").focus();
		return false;
	}else	if(userId == ''){
		alert("아이디를 입력해주세요.");
		$("#user_id").focus();
		//joinErrorFlagAry[1] = false;
		return false;
	}else if(!CheckValue(userId)){
		alert("아이디를 확인해주세요.");
		$("#user_id").focus();
		return false;
	}else if(pass1 == ''){
		alert("비밀번호를 입력해주세요.");
		$("#pass1").focus();
		return false;
	}else if(pass2 == ''){
		alert("비밀번호를 입력해주세요.");
		$("#pass2").focus();
		return false;
	}else if(!passCheckFlag){
		alert("비밀번호를 확인해주세요.");
		$("#pass2").focus();
		return false;
	}else if(!passwordcheck(pass1,pass2)){
		alert("비밀번호가 일치하지 않습니다.다시 입력해주세요.");
		$("#pass1").focus();
		return false;
	}else if(sendHp == ''){
		alert("휴대폰번호를 입력하세요.");
		$("#sendHp").focus();
		return false;
	}else if(!jQuery.isNumeric(sendHp) || "010,011,016,017,019".indexOf(sendHp.substring(0,3)) < 0 || sendHp.length > 11 || sendHp.length < 10){
		alert("휴대폰번호를 확인해주세요.");
		return false;
	}else if(recvHp == ''){
		alert("인증번호를 입력해주세요.");
		$("#recvHp").focus(); 
		return false;
	}else	if(!hpAuthComplete) {
		$("#recvHpAlertTxt").text("휴대폰인증을  완료해주세요.");
		alert("휴대폰인증을  완료해주세요.");
		return false;
	}else if(!$("input:checkbox[id='useAcessYN']").is(":checked")){
		alert("에누리 이용약관에 동의해주세요.");
		return false; 
	}else if(!$("input:checkbox[id='infoAcessYN']").is(":checked")){
		alert("개인정보 수집 및 이용에 동의해주세요.");
		return false;
	}else if(!joinErrorFlagAry[1]){
		alert("아이디 중복체크를 해주세요.");
		return false;
	} 
	
	// 휴대폰 번호 세팅
	var hpVal = $("#sendHp").val();
	var tel1 = "";
	var tel2 = "";
	var tel3 = "";
	if(hpVal.length==10) {
		tel1 = hpVal.substring(0, 3);
		tel2 = hpVal.substring(3, 6);
		tel3 = hpVal.substring(6, 10);
	}
	if(hpVal.length==11) {
		tel1 = hpVal.substring(0, 3);
		tel2 = hpVal.substring(3, 7);
		tel3 = hpVal.substring(7, 11);
	}
	$("#tel1").val(tel1);
	$("#tel2").val(tel2);
	$("#tel3").val(tel3);
	$("#hptel1").val("");
	$("#hptel2").val("");
	$("#hptel3").val("");
	
	//joinFormObj.target = "hFrame";
	//joinFormObj.submit();
	
	/*if(hpAuthComplete){
		$("#certify").val(1);	
	}*/
	
	if($("#marketingYN_cb").is(":checked")){
		$("#marketingYN").val("Y");
	}else{
		$("#marketingYN").val("N");
	}
	
	if($("#smsYN_cb").is(":checked")){
		$("#smsYN").val("Y");
	}else{
		$("#smsYN").val("N");
	}
	
	if($("#emailYN_cb").is(":checked")){
		$("#emailYN").val("Y");
	}else{
		$("#emailYN").val("N");
	}
	
	$.ajax({
	        type: "POST",
	        async : false,
	        dataType: 'json',
	        url: "/join/Join_Id_Chk_Ajax_2010.jsp",		        
	        data : {id:userId} ,
	        success: function(data){
				
				if(data.chkId == 0){
					
					$("#joinForm").attr("target","hFrame");
					$("#joinForm").submit();
					
				}else{
					alert("탈되한 ID 이거나 , 이미 등록된 ID 입니다. 아이디를 확인 해주세요");
				}
	        },
			error: function (xhr, ajaxOptions, thrownError) {
				alert(xhr.status);
				alert(thrownError);
			}
		});
}

function passwordcheck(pass1,pass2){
	if(pass1 == pass2){
		return true;	
	}else{
		return false;
	}
}

function backButton(){

	var iOS = /(iPad|iPhone|iPod)/g.test( navigator.userAgent );
	
	if(getCookie("appYN") == 'Y' ){
		location.href = "close://"
	}else{
		window.history.back(-1);
	}
		
}


jQuery(document).ready(function($) {
		
$(function(){
    var handler = function(e) { 
      e.preventDefault();
    };
    $(".ico_guide").click(function(){
        $(window).on('touchmove', handler);
        $(".dim").show();
        return false;
    });
    $(".dim .btn_close").click(function(){
        $(window).off('touchmove', handler);
        $(".dim").hide();
        return false;
    });
});
		
		//백버튼	
		$(".pageHead").append("<a href='javascript:///' class='back' onclick=\"backButton()\"></a>");
		
		$(".btnClose").click(function(){
			$("div[name=termsWrap]").hide();
			$("div[name=privacyWrap]").hide();
			$("div[name=ruleWrap]").hide();
		});
		
		$("#check_id").click(function(){
			
			var inputId = $("#user_id").val();
			
			if(inputId.length > 3) {
				$.ajax({
					type: "POST",
					url: "/join/Join_Id_Chk_Ajax_2010.jsp",
					dataType: "json",
					data: "id="+inputId+"&date="+(new Date()),
					success: function(data) {
						//alert("'"+data["chkId"]+"'")
						var chkId = data.chkId;
						var colorValue = "";
						var textValue = "";
						
						//joinErrorFlagAry[1] = false;
						if(chkId=="0") {
							colorValue = "#1da900";
							//textValue = "사용할 수 있는 아이디 입니다.";
							alert("사용하실수 있는 아이디 입니다.");
							$("#pass1").focus();
							joinErrorFlagAry[1] = true;
							textValue = "사용가능한 아이디입니다.";
							//joinErrorFlagAry[1] = true;
						} else if(chkId == "-1") {
							colorValue = "#bd0f0e";
							textValue = "금칙어 입니다. 다시입력 해주세요.";
						} else if(chkId == "3") {
							colorValue = "#bd0f0e";
							textValue = "첫글자는 반드시 영문이어야 합니다.";
						} else {
							colorValue = "#bd0f0e";
							//textValue = "이미 등록된 ID 이거나, 탈퇴한 ID 입니다.다시 입력해 주세요";
							alert("이미 등록된 ID 이거나, 탈퇴한 ID 입니다.다시 입력해 주세요");
						}
						$('#idAlerTxt').text(textValue);
						//showInputInfo($("#join .inputBoxInfoId"), textValue, colorValue);
					}
				});

			} else {
				var colorValue = "";
				var textValue = "";

				if(inputId.length==0) {
					colorValue = "#bd0f0e";
					textValue = "ID를 입력해주세요.";
				} else {
					colorValue = "#bd0f0e";
					textValue = "4~12자의 영문자, 숫자만 입력하세요.";
				}
				//showInputInfo($("#join .inputBoxInfoId"), textValue);
				$('#idAlerTxt').text(textValue);
				joinErrorFlagAry[1] = false;
			}
			
			
		});
		
});

function showTerms(){
	
	if(getCookie("appYN") == 'Y' ){
		//location.href = "/mobilefirst/login/termsWrap.jsp?freetoken=event";
		location.href = "/mobilefirst/login/policy.jsp?param=1&freetoken=event";
	}else{
		window.open("/mobilefirst/login/termsWrap.jsp?freetoken=event");
	}
}
function privacyWrap(){
	if(getCookie("appYN") == 'Y' ){
		location.href = "/mobilefirst/login/policy.jsp?param=2&freetoken=event";
	}else{
		window.open("/mobilefirst/login/privacyWrap.jsp?freetoken=event");
	}
}
function showMarketing(){
	if(getCookie("appYN") == 'Y' ){
		location.href = "/mobilefirst/login/maketingWrap.jsp?freetoken=event";
	}else{
		window.open("/mobilefirst/login/maketingWrap.jsp?freetoken=event");
	}
}
function goBack(){
 <%
 String strAppBI = ChkNull.chkStr(request.getParameter("app"),"");;
 if(strAppBI.equals("Y")) {
 %>
 document.location = "appcall://popupClose";
 <% } else { %>
 history.back(-1);
 <% } %>

}
</script>
<script language="JavaScript">
var resentZzimModelno = "10873519";
</script>
</body>
</html>
<%@ include file="/mobilefirst/include/common_logger.html"%>
