var IMG_ENURI_COM = "http://img.enuri.info";
var loginPageType = 0;

var spin_opts = {
             lines: 5, // The number of lines to draw
             length: 30, // The length of each line
             width: 4, // The line thickness
             radius: 10, // The radius of the inner circle
             corners: 1, // Corner roundness (0..1)
             rotate: 0, // The rotation offset
             color: '#000', // #rgb or #rrggbb
             speed: 1, // Rounds per second
             trail: 60, // Afterglow percentage
             shadow: false, // Whether to render a shadow
             hwaccel: false, // Whether to use hardware acceleration
             className: 'spinner', // The CSS class to assign to the spinner
             zIndex: 2e9, // The z-index (defaults to 2000000000)
             top: 'auto', // Top position relative to parent in px
             left: 'auto' // Left position relative to parent in px
};

$.fn.spin = function(spin_opts) {
             this.each(function() {
                           var $this = $(this),
                                data = $this.data(); 

                           if (data.spinner) {
                                        data.spinner.stop();
                                        delete data.spinner;
                           }
                           if (spin_opts !== false) {
                                        data.spinner = new Spinner($.extend({color: $this.css('color')}, spin_opts)).spin(this);
                           }
             });
             return this;
};


$(document).ready(function() {

	setEvents(loginPageType);
	
	$("#member_id").keyup(function(e) { 
	    if (e.keyCode == 13){
	        $(".btnWrap").trigger("click");
	    }
	});
		
	$("#member_pass").keyup(function(e) { 
	    if (e.keyCode == 13){
	        $(".btnWrap").trigger("click");
	    }
	});
	
	$(".btn_close").click(function(){
		$(".dim").hide();
	});
	
	$(".rest_btn").click(function(){
		
		var userid = $(".id").text();
		
		location.href = "/mobilefirst/login/rest_cancel.jsp?userid="+userid+"&backUrl="+backUrl;
		
	});
	
	
});

// 페이지를 이동하는 함수
function changePage(tempPageType) {
	// 뒤로가기 기기 버튼을 눌렀을 경우 페이지 변환이 오류라 생각되면 페이지 새로 고침으로 바꿈
	 //document.location.href = "/mobile2/login/login.jsp?pageType="+tempPageType;
	
	if(pageType!=tempPageType) {
		
		oldPageType = pageType;

		unsetEvents(tempPageType);

		pageType = tempPageType;

		//loadPageUI(tempPageType);
	}
}

// 페이지 UI의 사이즈를 조절하는 스크립트 연결
function sizeSet() {
	sizeChangeCss();

	$(window).unbind();
	$(window).resize(function() {
		sizeChangeCss();
	});
}

// 이벤트 바인드
// 체크 박스의 이벤트를 저장해 놓음
var checkFlag = [false, false, false];
var nameHangulCheckFlag = true;
// 이름, 아이디, 비밀번호, 휴대폰번호, 인증번호
var joinErrorFlagAry = [false, false, false, false, false, false];
var joinErrorObjAry = ["#name","#user_id","#pass1","#pass2","#sendHp","#recvHp"];
function setEvents(tempPageType) {
	
	/*
	for(var i=0; i<checkFlag.length; i++) {
		checkFlag[i] = false;
	}

	// 로그인 페이지에서는 자동로그인이 디폴트
	if(tempPageType==1) {
		checkFlag[0] = true;
	}
	*/
	
	//자동로그인
	//$("#autoLogin").attr("checked",true);
	

	// 로그인
	if(tempPageType==1 || tempPageType==3) {
		var loginObj = $("#login");
		loginObj.find(".optionArea .autoLogin img").click(function (e) {
			if(checkFlag[0]) { // 체크 된걸 해제
				$(this).attr("src", IMG_ENURI_COM+"/images/mobile2/login/btn_check.png");
				checkFlag[0] = false;
			} else {
				$(this).attr("src", IMG_ENURI_COM+"/images/mobile2/login/btn_check_on.png");
				checkFlag[0] = true;
			}
		});
		loginObj.find(".optionArea .joinLink span").click(function (e) {
			checkFlag = [false, false, false];
			nameHangulCheckFlag = true;
			// 이름, 아이디, 비밀번호, 휴대폰번호, 인증번호
			joinErrorFlagAry = [false, false, false, false, false];
			
			// 2번 회원가입
			changePage(2);
			
		});
		
		//loginObj.find("#btn_login").click(function (e) {
		$(".btnWrap").click(function (){
			var member_idObj = $("#member_id");
			var member_passObj = $("#member_pass");
			
			insertLog('11042');
			
			ga('send', 'event', 'button', 'click', '로그인');
			
			if(member_idObj.val()=="") {
				alert("ID를 입력해 주세요.");
				member_idObj.focus();
				return;
			}
			if(member_passObj.val()=="") {
				alert("비밀번호를 입력해 주세요.");
				member_passObj.focus();
				return;
			}
 
			/*
			if(checkFlag[0]==true) {
				document.loginForm.autologin.value = "Y";
			} else {
				document.loginForm.autologin.value = "";
			}
			*/
			
			if($("input:checkbox[id='autoLogin']").is(":checked")){
				document.loginForm.autologin.value = "Y";
			}else{
				document.loginForm.autologin.value = "";
			}
			
			
			document.loginForm.submit();

		});
	}

	// 회원가입
	if(tempPageType==2) {
		var joinObj = $("#container");

		// 키 입력시 아이디가 유효한지 확인함
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
				var textValue = "한글만 입력하세요.";
				//showInputInfo($("#join .inputBoxInfoName"), textValue, colorValue);
				$('#nameAlertTxt').text(textValue);
				joinErrorFlagAry[0] = false;
			} else {
				//showInputInfo($("#join .inputBoxInfoName"), "", "");
				$('#nameAlertTxt').text("");
				joinErrorFlagAry[0] = true;
			}
			
		});


		$("#user_id").keydown(function() {
			var user_idObj = $("#user_id");
			var inputId = user_idObj.val();
			
			/*
			if(!CheckValue(inputId)){
				$('#idAlerTxt').text("첫글자 영문자 가 와야 됩니다. 아이디는 영문 숫자 만 가능 합니다.");
			}else{
				$('#idAlerTxt').text("4~12 자의 영무자, 숫자만 입력하세요.");
			}
			*/
			
			if(CheckValue(inputId)){
				$('#idAlerTxt').text("중복체크를 해주세요.");				
			}else{
				$('#idAlerTxt').text("4~12 자의 영문자, 숫자만 입력하세요.");	
			}
			
			joinErrorFlagAry[1] = false;
			
		});

		$("#user_id").blur(function() {
			var user_idObj = $("#user_id");
			var inputId = user_idObj.val();
			
			if(CheckValue(inputId)){
				$('#idAlerTxt').text("중복체크를 해주세요.");				
			}else{
				$('#idAlerTxt').text("4~12 자의 영문자, 숫자만 입력하세요.");	
			}
			
		});

		// 키 입력시 아이디가 유효한지 확인함
		/*
		joinObj.find("#user_id").keyup(function (e) {
			var user_idObj = $("#user_id");
			var inputId = user_idObj.val();

			if(inputId.length > 3) {
				
				$.ajax({
					type: "POST",
					url: "/join/Join_Id_Chk_Ajax_2010.jsp",
					dataType: "json",
					data: "id="+inputId+"&date="+(new Date()),
					success: function(data) {
						//alert("'"+data["chkId"]+"'")
						var chkId = data["chkId"];
						var colorValue = "";
						var textValue = "";

						joinErrorFlagAry[1] = false;
						if(chkId=="0") {
							colorValue = "#1da900";
							textValue = "사용할 수 있는 아이디 입니다.";
							joinErrorFlagAry[1] = true;
						} else if(chkId == "-1") {
							colorValue = "#bd0f0e";
							textValue = "금칙어 입니다. 다시입력 해주세요.";
						} else if(chkId == "3") {
							colorValue = "#bd0f0e";
							textValue = "첫글자는 반드시 영문이어야 합니다.";
						} else {
							colorValue = "#bd0f0e";
							//textValue = "탈퇴한 ID 이거나, 이미 등록된 ID 입니다.";
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
		*/
///ng-keyup="pwTxtKeyup()"
		// password 체크
		//joinObj.find("#pass111").keyup(function() {
		
		/*
		$('html').on('keydown' , function(event) {
			alert(1111);
		});
		*/
		
		
		$('#pass1').on('blur' , function(event) {
				
			var user_idObj = $("#user_id");
			var inputId = user_idObj.val();
			var pass1Obj = $("#pass1");
			var inputPass = pass1Obj.val();
			passCheckFlag = false;
			
			if(inputPass.length>=8) {
				// 영문또는 숫자인지 확인하는 정규식
				passCheckFlag = chkPassCombine(inputPass);
				
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
					//var textValue = "8~15자의 영문, 숫자가 조합된 비밀번호로 입력해 주세요.";
					var textValue = "8~15자 영대/소문자, 숫자, 특수문자 중 3가지를 조합해주세요.";
					//showInputInfo($("#join .inputBoxInfoPass"), textValue, colorValue);
					$('#pwAlertTxt1').text(textValue);
				}
			}
			
			if( inputPass != $("#pass2").val() ){
				if($("#pass2").val().length > 0){
					$('#pwAlertTxt2').text("비밀번호가 일치하지 않습니다.다시 입력해주세요");	
				}
			}
	
		});
		
		joinObj.find("#pass2").blur(function() {					
				
			var pass2Obj = $("#pass2");
			var inputPass = pass2Obj.val();
			var passCheckFlag = false;

			if(inputPass.length > 0 && inputPass.length >= $("#pass1").val().length){
				
				if(inputPass == $("#pass1").val()){
					passCheckFlag = true;
					$('#pwAlertTxt2').text("비밀번호가 일치 합니다.");
				}else{
					$('#pwAlertTxt2').text("");
					//$("#pass2").focus();
					passCheckFlag = false;
				}
			
			}else{
				$('#pwAlertTxt2').text("");
			}
			
			if(!passwordcheck(inputPass,$("#pass1").val())){
				if(joinErrorFlagAry[2]){
					if($("#pass2").val().length > 0){
						$('#pwAlertTxt2').text("비밀번호가 일치하지 않습니다.다시 입력해주세요");	
					}
				}
				//return false;
			}
				
		});

		$("#name").blur(function(){
			var name = $("#name").val();
			name = name.trim();
			$("#name").val(name);
			
			var thisText = $(this).val();
			var checkHangul = true;

			for(var i=0; i<thisText.length; i++) {
				if(!((thisText.charCodeAt(i)>0x3130 && thisText.charCodeAt(i)<0x318F) ||
						(thisText.charCodeAt(i)>=0xAC00 && thisText.charCodeAt(i)<=0xD7A3))) {
					checkHangul = false;
				}
			}

			nameHangulCheckFlag = checkHangul;
			if(!checkHangul) {
				var colorValue = "#bd0f0e";
				var textValue = "한글만 입력하세요.";
				//showInputInfo($("#join .inputBoxInfoName"), textValue, colorValue);
				$('#nameAlertTxt').text(textValue);
				joinErrorFlagAry[0] = false;
			} else {
				//showInputInfo($("#join .inputBoxInfoName"), "", "");
				$('#nameAlertTxt').text("");
				joinErrorFlagAry[0] = true;
			}
			
		});
			
	joinObj.find("#pass1").keyup(function() {					
			
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
					$('#pwAlertTxt2').text("비밀번호가 일치하지 않습니다.다시 입력해주세요");	
				}
			}
			
		});
		// 비밀번호 확인 키 입력시 아이디가 유효한지 확인함
/*		
		joinObj.find("#pass2").keyup(function (e) {
			var user_idObj = $("#user_id");
			var inputId = user_idObj.val();
			var pass2Obj = $("#pass2");
			var inputPass = pass2Obj.val();
			var passCheckFlag = false;

			if(inputPass.length > 0 && inputPass.length >= $("#pass1").val().length){
				
				if(inputPass == $("#pass1").val()){
					passCheckFlag = true;
					$('#pwAlertTxt2').text("비밀번호가 일치 합니다.");
				}else{
					$('#pwAlertTxt2').text("");
					$("#pass2").focus();
				}
			
			}else{
				$('#pwAlertTxt2').text("");
			}
			
			if(!passwordcheck(inputPass,$("#pass1").val())){
				if(joinErrorFlagAry[2]){
					if($("#pass2").val().length > 0){
						$('#pwAlertTxt2').text("비밀번호가 일치하지 않습니다.다시 입력해주세요");	
					}
				}
				return false;
			}
			
			
			if(inputPass.length>=8) {
				// 영문또는 숫자인지 확인하는 정규식
				passCheckFlag = rtn_engnumSum_chk(inputPass);
			}

			joinErrorFlagAry[2] = false;

			if(inputPass.indexOf(inputId)>-1) {
				colorValue = "#bd0f0e";
				var textValue = "아이디를 포함한 비밀번호는 사용할 수 없습니다.";
				//showInputInfo($("#join .inputBoxInfoPass"), textValue, colorValue);
				$('#pwAlertTxt2').text(textValue);
			} else {
				if(passCheckFlag) {
					colorValue = "#1da900";
					//showInputInfo($("#join .inputBoxInfoPass"), "사용할수 있는 비밀번호 입니다.", colorValue);
					var textValue = "사용할 수 있는 비밀번호 입니다.";
					$('#pwAlertTxt2').text(textValue);
					joinErrorFlagAry[2] = true;
				} else {
					colorValue = "#bd0f0e";
					var textValue = "8~15자의 영문, 숫자가 조합된 비밀번호로 입력해 주세요.";
					//showInputInfo($("#join .inputBoxInfoPass"), textValue, colorValue);
					$('#pwAlertTxt2').text(textValue);
				}
			}
			
			
		});
*/
		// 전화번호입력란이 숫자인지 확인
		joinObj.find("#sendHp").keyup(function (e) {
			
			var sendHpTxt = $(this).val();
			var sendHpTxtFlag = false;

			// 영문또는 숫자인지 확인하는 정규식
			sendHpTxtFlag = rtn_num_chk(sendHpTxt);
            
			joinErrorFlagAry[3] = false;
			if(!sendHpTxtFlag) {
				//showInputInfoSendHpAuth("", 1);
				var textValue = "숫자만 입력해 주세요.";
                $('#phoneAlertTxt').text(textValue);
				joinErrorFlagAry[3] = true;
			}else{
			     
			    if(sendHpTxt.length > 11 ){
                    var textValue = "휴대폰번호가 올바르지 않습니다. 확인 후 다시 입력해주세요";
                    $('#phoneAlertTxt').text(textValue);
                    //showInputInfoSendHpAuth(textValue, 1);
                }else{
                    var textValue = "";
                    $('#phoneAlertTxt').text(textValue);                    
                }
			}
			
			$("#cerkyY").hide();
			$("#cerkyN").show();
			
			$("#recvHp").val('');
			
			hpAuthComplete = false;
			$("#certify").val("");
			
		});
		




		// 인증번호 확인란이 숫자인지 확인
		joinObj.find("#recvHp").keyup(function (e) {
			var recvHpObj = $("#recvHp");
			var recvHpTxt = recvHpObj.val();
			var recvHpTxtFlag = false;

			// 영문또는 숫자인지 확인하는 정규식
			recvHpTxtFlag = rtn_num_chk(recvHpTxt);

			joinErrorFlagAry[4] = false;
			if(recvHpTxtFlag) {
				//showInputInfoRecvHpAuth("", 1);
				$('#recvHpAlertTxt').text("");
				joinErrorFlagAry[4] = true;
			} else {
				var textValue = "숫자만 입력해 주세요.";
				//showInputInfoRecvHpAuth(textValue, 1);
				$('#recvHpAlertTxt').text(textValue);
			}
		});
		//joinObj.find(".sendHpAuth img").click(function (e) {
		$("#btn_sendImg").click(function(){
			
			CmdSpinLoading();
			
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

		//joinObj.find(".recvHpAuth img").click(function (e) {
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
			
			CmdSpinLoading();
			
			document.hFrame.location.href = "/mobilefirst/ajax/login/hpAuthSendProc_ajax.jsp?cs_tel="+cs_tel+"&sms_no="+sms_no+"&find_name="+find_name;
		});
		

	}

	// 성인 인증
	if(tempPageType==3) {
		var authSelectObj = $("#authSelect");

		// 휴대폰 인증
		authSelectObj.find("#selfBtnImg").click(function (e) {
			cmdCheckPlus();
		});

		// 아이핀 인증
		authSelectObj.find("#ipinBtnImg").click(function (e) {
			cmdPopIpin();
		});
	}
}

//휴면 계정 show
function restLayerShow(strID){
	
	$(".id").text(strID);
	$(".dim").show();
}

//=== 영문, 숫자 혼용 확인
//혼용이면 true, 아니면 false
function rtn_engnum_mix_chk(str) {
	var chk_num = str.search(/[0-9]/g);
	var chk_eng = str.search(/[a-z]/ig);
	if(chk_num < 0 || chk_eng < 0) {
		return false;
	}
	return true;
}

// 숫자이면 true, 아니면 false
function rtn_num_chk(str) {
	/*
	for(var i=0; i<=str.length-1; i++) {
		if(str.charAt(i) >= '0' && str.charAt(i) <= '9'){}
		else {
			return false;
		}
	}
	*/
    if($.isNumeric(str) == true) {
        return true;    
    } else {
        return false;
    }
	
	
}

//=== 영문, 숫자 확인
//영문 또는 숫자이면 true, 아니면 false
function rtn_engnum_chk(pw) {
	
	//console.log(chkPassCombine(pw));

	return chkPassCombine(pw);
	
}

//=== 영문 숫자만 이면서 영문과 숫자가 하나씩있어야함
//영문 또는 숫자이면 true, 아니면 false
function rtn_engnumSum_chk(str) {
	if(!rtn_engnum_chk(str)) {
		return false;
	}

	var findFlag = 0;
	// 영문찾기
	for(var i=0; i<=str.length-1; i++) {
		if('a' <= str.charAt(i) && str.charAt(i) <= 'z') {
			findFlag++;
			break;
		}
	}
	// 숫자 찾기
	for(var i=0; i<=str.length-1; i++) {
		if(str.charAt(i) >= '0' && str.charAt(i) <= '9') {
			findFlag++;
			break;
		}
	}

	// 연속 숫자 3자 찾기
	/*
	var numbFind = 0;
	for(var i=0; i<=str.length-1; i++) {
		if(str.charAt(i) >= '0' && str.charAt(i) <= '9') {
			numbFind++;

			if(numbFind==3) {
				break;
			}
		} else {
			numbFind = 0;
		}
	}
	*/
	
	if(!kin3(str)) return false; 
	//alert(!kin3(str));
	//if(numbFind==3) return false;

	if(findFlag==2) return true;
	else return false;
}


function kin3(str, limit){ 
	var o, d, p, n = 0, l = limit==null ? 3 : limit; 
	for(var i=0; i<str.length; i++){ 
	var c = str.charCodeAt(i); 
	if(i > 0 && (p = o - c) >-2 && p < 2 && (n = p == d ? n+1 : 0) > l-3) return false; 
	d = p, o = c; 
	} 
	return true; 
	} 


// 텍스트 박스 아래의 주석을 보여주기 위한 함수
function showInputInfo(jObj, txt, color) {
	var objHeight = 20;
	var objLineHeight = 20;
	var objColor = "#bd0f0e";
	
	if(color!=null && color.length>0) objColor = color;
	if(txt.length==0) {
		objHeight = 10;
	} else {
		if(txt.indexOf("<br>")>-1) {
			objHeight = 32;
			objLineHeight = 12;
		}
	}
	jObj.css("height", objHeight+"px");
	jObj.css("line-height", objLineHeight+"px");
	jObj.find("span").html(txt);
	jObj.find("span").css("color", objColor);
}

// 인증번호 전송시에만 사용하는 예외처리
/*
function showInputInfoSendHpAuth(txt, colorType) {
	var colorVal = "";

	if(colorType==2) {
		colorVal = "#1da900";
	} else {
		colorVal = "#bd0f0e";
	}

	showInputInfo($("#join .sendHpAuthInfo"), txt, colorVal);
}*/

function showInputInfoSendHpAuth(txt) {
	$("#phoneAlertTxt").text(txt);
}



// 인증번호 전송시에만 사용하는 예외처리
function jShowInputInfoSendHpAuth(txt) {
	
	$('#phoneAlertTxt').text(txt);

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

// 인증이 완료 되었을 경우 처리
var hpAuthComplete = false;

/*
function showInputAuthComplete() {
	showInputInfoSendHpAuth("", 1);

	$("#join .sendHpAuth #btn_sendImg").css("display", "none");
	$("#join .sendHpAuth .authCompDiv").css("display", "block");
	$("#join .recvHpAuth").css("display", "none");
	$("#join .recvHpAuthInfo").css("display", "none");
	
	// 인증 완료시 체크함
	$("#join #certify").val("1");

	hpAuthComplete = true;
}
*/

//
function showInputAuthComplete() {

	//$("#recvInputBox").children().hide();
	
	$("#cerkyN").hide();
	$("#cerkyY").show();
	
	CmdSpinHide();
	
	hpAuthComplete = true;
	$("#certify").val("1");
}

// 인증번호 입력레이어를 나타나게 함
function recvHpAuthShow() {
	$("#join .recvHpAuth").css("display", "block");
}

//이벤트 바인드
function unsetEvents(tempPageType) {
	if(tempPageType==1 || tempPageType==3) {
		var loginObj = $("#login");
		loginObj.find(".optionArea .autoLogin img").unbind();
		loginObj.find(".optionArea .joinLink span").unbind();
		loginObj.find("#btn_login").unbind();
	}

	if(tempPageType==2) {
		var joinObj = $("#join");
		joinObj.find(".sendHpAuth img").unbind();
		joinObj.find(".recvHpAuth img").unbind();
		joinObj.find(".joinBtn img").unbind();
		joinObj.find("#useAgree .checkArea img").unbind();
		joinObj.find("#personalAgree .checkArea img").unbind();
	}

	// 성인 인증
	if(tempPageType==3) {
		var authSelectObj = $("authSelect");
		authSelectObj.find("#selfBtnImg").unbind();
		authSelectObj.find("#ipinBtnImg").unbind();
	}
}

function sizeChangeCss() {
	var tempWidth = $(window).width();

	// 공통
	$("#hTitleDiv").css("width",  tempWidth - 120);

	if(pageType==1 || pageType==3) {
		$(".inputBox").css("width",  tempWidth - 90);
		$(".inputBox input").css("width",  tempWidth - 103);
	}

	if(pageType==2) {
		$(".inputBox").css("width",  tempWidth - 26);
		$(".inputBox input").css("width",  tempWidth - 38);
		$(".sendHpAuth").css("width",  tempWidth - 30);
		$(".sendHpAuth input").css("width",  tempWidth - 140);
		$(".recvHpAuth").css("width",  tempWidth - 30);
		$(".recvHpAuth input").css("width",  tempWidth - 140);
	}
}

// ***********************************************
// *************** 성인 인증 시작 ********************
// ***********************************************
function cmdCheckPlus() {
	var iReturn = $("#iReturnInput").val();
	var sMessage = $("#sMessageInput").val();
	if(iReturn=="0") {
		//var popupChkObj = window.open("/common/jsp/Common_Pop_Submit.jsp?after=cmdCheckPlusReal", "popupChk", "width=500, height=461, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no");
		//window.open("/common/jsp/Common_Pop_Submit.jsp?after=cmdCheckPlusReal");
		//document.location.href = "/mobile2/login/Common_Pop_Submit.jsp";
		//document.location.href = "https://m.enuri.com:442/mobile2/login/Common_Pop_Submit.jsp";
		cmdCheckPlusReal();
	} else {
		alert(sMessage);
	}
}

function cmdCheckPlusReal() {
	document.form_chk.action = "https://check.namecheck.co.kr/checkplus_new_model4/checkplus.cb";
	document.form_chk.target = "popupChk";
	document.form_chk.submit();
}

function cmdPopIpin() {
	var iRtn = $("#iRtnInput").val();
	var sRtnMsg = $("#sRtnMsgInput").val();
	if(iRtn=="0") {

		if(getCookie("appYN") == 'Y'){

			if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
				//document.location.href = "/common/jsp/Common_Pop_Submit.jsp?after=cmdPopIpinReal";
				//var $iFrm = $('<iframe id="iFrm" name="iFrm" ></IFRAME>');
                //$iFrm.attr('src', "/common/jsp/Common_Pop_Submit.jsp?after=cmdPopIpinReal");
                //$iFrm.appendTo('body');
                //$iFrm.submit();
                
                 //var $iFrm =  $("input[name=form_ipin]"); // $("#form_ipin");  //$('<iframe id="form_ipin" name="form_ipin" ></iframe>');
                 //var $iFrm = $('<iframe id="iFrm" name="iFrm" scrolling="no"  width="400" height="800" frameborder="0" ></IFRAME>');
                 //$iFrm.attr('src', "https://cert.vno.co.kr/ipin.cb");
                 //$iFrm.attr('target', "popupIPIN2");
                 //$iFrm.appendTo('body');
                 //$iFrm.submit();

                //document.form_ipin.target = "popupIPIN2";
                //document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
                //document.form_ipin.submit();
                
                cmdPopIpinReal();
                
	        }else{
	        	//window.open("/common/jsp/Common_Pop_Submit.jsp?after=cmdPopIpinReal", "popupIPIN2", "width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no");
	        	cmdPopIpinReal();
	        }

	       //var $iFrm = $('<iframe id="iFrm" name="iFrm" ></iframe>');
           //      $iFrm.attr('src', "/common/jsp/Common_Pop_Submit.jsp?after=cmdPopIpinReal");
           //      $iFrm.attr('target', "popupIPIN2");
            //     $iFrm.appendTo('body');
            
        }else{
        	window.open("/common/jsp/Common_Pop_Submit.jsp?after=cmdPopIpinReal", "popupIPIN2", "width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no");
        }
		
	} else {
		alert(sRtnMsg);
	}
}

function cmdPopIpinReal() {
                //var $iFrm =  $("input[name=form_ipin]").attr("target","form_ipin"); // $("#form_ipin");  //$('<iframe id="form_ipin" name="form_ipin" ></iframe>');
    if(getCookie("appYN") == 'Y'){
        $("#container").hide();
        var $iFrm = $('<iframe id="iFrm" name="iFrm" width=\"400\" height=\"800\"></iframe>');
             $iFrm.attr('method', "post");
             $iFrm.attr('target', "aList");
             $iFrm.appendTo('body');
            
        	//document.form_ipin.target = "popupIPIN2";
        	document.form_ipin.target = "iFrm";
        	document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
        	document.form_ipin.submit();
    }else{
        
            document.form_ipin.target = "popupIPIN2";
            document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
            document.form_ipin.submit();
        
    }
}

// ***********************************************
// *************** 성인 인증 끝 *********************
// ***********************************************

function goBackPage() {
	var thisUrl = document.location.href;
	
	if(thisUrl.indexOf("mobilefirst/login/login.jsp")>-1 && thisUrl.indexOf("pageType=3")>-1) {
		document.location.reload();
	} else {
		if(backUrl == undefined || backUrl == ""){
		    
    		if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
                
                if(getCookie("appYN") == 'Y'){
                    document.location.href = "close://";
                }else{                                                                          
                    document.location.href = "/mobilefirst/Index.jsp";
                }
                
            }else if(navigator.userAgent.indexOf("Android") > -1){
                
                if(getCookie("appYN") == 'Y'){
                    document.location.href = "close://";
                }else{                                                                          
                    document.location.href = "/mobilefirst/Index.jsp";
                }
            }
			
		}else{
		    if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
                if(getCookie("appYN") == 'Y'){
                    document.location.href = "close://";
                }else{                                                                          
                    document.location.href = backUrl;
                }
            }else if(navigator.userAgent.indexOf("Android") > -1){
                
                if(getCookie("appYN") == 'Y'){
                    document.location.href = "close://";
                }else{                                                                          
                    document.location.href = backUrl;
                }
            }
			
		}
		
	}
}

//preOpen이 없음
function preOpen(objName, url) {

	if(url.indexOf("Index.jsp")>-1) {
		window.open("/Index.jsp?from=mo");
	} else {
		window.open(url);
	}
}


function CmdSpinLoading(){
	$("#cm_loading").css("top",$(window).height()/2);
	$("#cm_loading").css("left",$(window).width()/2);
	$("#cm_loading").fadeIn("fast");
	$("#cm_loading").spin();	 
}


function CmdSpinHide(){
	
	$("#cm_loading").hide();

}


function Is_nick_name(txt){
		
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

}
