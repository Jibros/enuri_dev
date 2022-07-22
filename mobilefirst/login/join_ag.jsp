<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<% String strApp = ChkNull.chkStr(request.getParameter("app"),"");%>
<%
	String ENURI_COM_SSL = "https://m.enuri.com:442";
	String serverName = request.getServerName();

	// 아이폰 새버전이 올라가면
	// 밑에 ios예외처리 한부분들 수정해야함
	if(serverName.indexOf("stagedev.enuri.com")>-1 || serverName.indexOf("100.100.100.151")>-1 || serverName.indexOf("dev.enuri.com")>-1 || serverName.indexOf("m.enuri.com")>-1 ) {
		ENURI_COM_SSL = "";
	}

	String backUrl = ChkNull.chkStr(request.getParameter("backUrl"), "");
	
	String css ="";  
	
	if(backUrl.contains("mobiledepart")) css = "mobiledepart"; 
	else if(backUrl.contains("deal")) css = "mobiledeal";
%>
<html>
<head>
<title></title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width">
<%@include file="/mobilefirst/include/common.html"%>
<script type="text/javascript" src="/carm/js/src/spin.js"></script>
<script type="text/javascript" src="https://script.gmarket.co.kr/js/mobile/main/common/angular.min.js"></script>
<script type="text/javascript" src="https://script.gmarket.co.kr/js/mobile/main/common/angular-route.min.js"></script>
</head>
<body>
<%@ include file="/mobilefirst/login/login_check.jsp"%>
<div class="join_form" ng-app="inputValidChkApp">

<form name="joinForm" id="joinForm" method="post" ng-controller="inputValidChkController"    autocomplete="off" action="<%=ENURI_COM_SSL%>/mobilefirst/ajax/login/joinProc_ajax.jsp?chkurl=http://m.enuri.com" style="margin:0px;">
<input type="hidden" name="certify" id="certify" value=""/>
<input type="hidden" name="cs_tel" id="cs_tel" value=""/>
<input type="hidden" name="tel1" id="tel1" value=""/>
<input type="hidden" name="tel2" id="tel2" value=""/>
<input type="hidden" name="tel3" id="tel3" value=""/>
<input type="hidden" name="hptel1" id="hptel1" value=""/>
<input type="hidden" name="hptel2" id="hptel2" value=""/>
<input type="hidden" name="hptel3" id="hptel3" value=""/>
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
					<input type="password" name="pass1" id="pass1" class="txt" maxlength="15"  ng-pattern="pwpattern" ng-model="inputValue.pwTxt" required ng-keyup="pwTxtKeyup()"   placeholder="비밀번호" title="비밀번호 입력(8~15자의 영문, 숫자 조합)"  />
					<span class="alerTxt" id="pwAlertTxt1"  ng-show="(joinForm.pass1.$error.required || joinForm.pass1.$error.pattern) && (joinForm.pass1.$dirty)">6-15자의 영문 대소문자, 숫자, 특수문자를 사용해주세요.</span>
					<span class="alerTxt" id="pwAlertTxt1"  ng-show="!(inputValue.pwValidationResult.valid) && (joinForm.pass1.$dirty) ">{{inputValue.pwValidationResult.alertText}}</span>
					<!--<p class="retry_txt" ng-show="(joinForm.pass1.$error.required || joinForm.pass1.$error.pattern) && (joinForm.pass1.$dirty)">6-15자의 영문 대소문자, 숫자, 특수문자를 사용해주세요.</p>-->
					<!--<p class="retry_txt" ng-show="!(inputValue.pwValidationResult.valid) && (joinForm.pass1.$dirty) ">{{inputValue.pwValidationResult.alertText}}</p>					-->
					
				</p>
				<p class="inputBox">
					<input type="password" name="pass2" id="pass2" class="txt" maxlength="15" placeholder="비밀번호 확인" ng-model="inputValue.pw2Txt" ng-keyup="pw2TxtKeyup()" required />
					<span class="alerTxt" id="pwAlertTxt2" ng-show="(!(inputValue.pw2ValidationResult.valid)) && (joinForm.pass2.$dirty)">{{inputValue.pw2ValidationResult.alertText}}</span>
				</p>
				<p class="inputBox">
					<span class="inBtn">
						<input type="number" name="sendHp" id="sendHp" class="txt" placeholder="휴대폰번호" title="휴대폰 번호 입력" />
						<span class="btnBox"><button type="button" id="btn_sendImg" class="btnTxt" style="width:90px;">인증번호 전송</button></span>
					</span>
					<span class="alerTxt" id="phoneAlertTxt"></span>
				</p>
				<p class="inputBox" id="recvInputBox">
					<span class="inBtn">
						<input type="number" name="recvHp" id="recvHp" class="txt" placeholder="인증번호" title="인증번호 입력" />
						<span class="btnBox"><button type="button" class="btnTxt" style="width:90px;" id="btn_ok">인증 확인</button></span>
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
						<p class="left"><label><input type="checkbox" id="useAcessYN"> 에누리 이용약관 동의</label></p>
						<a href="javascript:///" class="link" onclick="showTerms()">보기</a>
					</div>
					<div class="joinm">
						<p class="left"><label><input type="checkbox" id="infoAcessYN"> 개인정보 수집 및 이용 동의</label></p>
						<a href="javascript:///" class="link" onclick="$('#privacyWrap').show();">보기</a>
					</div>
				</div>
				
				
				<p class="alerTxt" id="acessCheck"></p>
				<div class="lineBox">
					<p class="btnWrap"><a href="javascript:///" class="btnType3" onclick="joinBtnClick()">회원가입 하기</a></p>
				</div>
			</fieldset>
		</div>
	</div>
</div>
<!-- 이용약관 -->
<%@include file="/mobilenew/login/privacyWrap.jsp"%>
<%@include file="/mobilenew/login/termsWrap.jsp"%>

</body>
</form>
<iframe id="hFrame" name="hFrame" frameborder="0" style="margin:0px;padding:0px;height:0px;width:0px;"></iframe>
<script>

(function () {
		var app = angular.module('inputValidChkApp', ['ngRoute']);

		app.controller('inputValidChkController', ['$scope', '$http', function ($scope, $http) {
			$scope.pwpattern = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-]|.*[0-9]).{6,15}$/;
			//var EnNum_pattern = /[^a-zA-Z0-9!\"#$%&\'()*+,-./:;<>=?@[]\\^_`{|}~]/;
			$scope.inputValue = {
				pwTxt: "",
				pwValidationResult: { valid: false, alertText: "" },
				pw2Txt: "",
				pw2ValidationResult: { valid: false, alertText: "" }
			};

			$scope.pwTxtKeyup = function () {
				
				//var inputVal = $scope.inputValue.pwTxt;
				var inputVal = $("#pass1").val();
				
				if (inputVal == undefined) {
					return false;
				}
				else {
					var result = chkPassword(inputVal);
				}
				$scope.inputValue.pwValidationResult = result;
				this.pw2TxtKeyup();
			};

			$scope.pw2TxtKeyup = function () {
				var result = { valid: true, alertText: "" };
				tmpStr = document.getElementById("pass1").value;

				if (tmpStr.length == 0) {
					result.alertText = "우선 비밀번호를 설정해 주세요";
					result.valid = false;
				}
				else if ($scope.inputValue.pwValidationResult.valid == false) {
					result.alertText = "비밀 번호가 조합기준에 적합하지 않습니다. 비밀번호를 다시 설정해 주세요";
					result.valid = false;
				}
				else if (tmpStr.length > 0 && tmpStr != $scope.inputValue.pw2Txt) {
					result.alertText = "비밀 번호가 일치하지 않습니다.";
					result.valid = false;
				} else if( tmpStr.length > 0 && tmpStr == $scope.inputValue.pw2Txt ){
					result.alertText = "비밀 번호가 일치하지 않습니다.";
					result.valid = false;
				}
				
				$scope.inputValue.pw2ValidationResult = result;

			}
		} ]);
	})();




var chkPassword = function (pw) {
		var tmpStr = null;
		//var EnNum_pattern = /[^a-zA-Z0-9!\"#$%&\'()*+,-./:;<>=?@[]\\^_`{|}~]/;
		var returnJson = { valid: true, alertText: "" };

		//ID와 동일한 패스워드 생성 금지
		tmpStr = $("#user_id").val();
		
		console.log("tmpStr : "+tmpStr);
		console.log("pw : "+pw);
		
		if (tmpStr.length > 0 && tmpStr == pw) {
			returnJson.alertText = "회원 아이디를 비밀번호로 사용할 수 없습니다.";
			returnJson.valid = false;
			return returnJson;
		}

		//동일한 숫자(문자)로 이루어진 패스워드 생성 금지
		for (var i = 0; i <= pw.length - 4; i++) {
			if (pw.charAt(i) == pw.charAt(i + 1) && pw.charAt(i) == pw.charAt(i + 2) && pw.charAt(i) == pw.charAt(i + 3)) {
				returnJson.alertText = "4개 이상의 동일한 문자(숫자)가 포함된 비밀번호는 사용할 수 없습니다.";
				returnJson.valid = false;
				return returnJson;
			}
		}

		//연속된 숫자로 이루어진 패스워드 생성 금지
		strNum = "01234567890";
		for (var i = 0; i <= strNum.length - 4; i++) {
			tmpStr = strNum.substring(i, i + 4);
			if (pw.indexOf(tmpStr) >= 0) {
				returnJson.alertText = "연속된 4자리의 숫자가 포함된 비밀번호는 사용할 수 없습니다.";
				returnJson.valid = false;
				return returnJson;
			}
		}

		return returnJson;
	}




/*
   var myapp = angular.module("SampleApp", []);
        myapp.controller("SampleCntrl", function ($scope) {
            $scope.keydownevt = function () {
                $scope.keydownkeycode = event.keyCode;
                $scope.keyupkeycode = "";
                $scope.keypresskeycode = "";
            };
            $scope.keyupevt = function () {
                $scope.keyupkeycode = event.keyCode;
                console.log("scope : "+$scope.keyupkeycode);
                alert($scope.keyupkeycode);
            };
            $scope.keypressevt = function () {
                $scope.keypresskeycode = event.keyCode;
            };
        });
*/



</script>

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
	}else	if(userId == ''){
		alert("아이디를 입력해주세요.");
		$("#user_id").focus();
		//joinErrorFlagAry[1] = false;
		return false;
	}else if(!CheckValue(userId)){
		alert("아이디를 확인해주세요.");
		$("#user_id").focus();
		return false;
	}else if(!joinErrorFlagAry[0]){
		alert("이름을 확인해주세요.");
		$("#name").focus();
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
	
	var css = $("#memberWrap").attr("class");
	
	if(css == 'mobiledeal'){
		$("#termsWrap").addClass("mobiledeal");
		$("#privacyWrap").addClass("mobiledeal");
	}else if(css == 'mobiledepart'){
		$("#termsWrap").addClass("mobiledepart");
		$("#privacyWrap").addClass("mobiledepart");
	}
	
	$('#termsWrap').show();
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
