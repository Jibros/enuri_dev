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
	//setEvents(loginPageType);
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
	
	// 키 입력시 아이디가 유효한지 확인함
	// 한글자~세글자 입력 or 특수문자, 한글 입력되고 있을 때
	// "4~12자의 영문자, 숫자만 입력하세요."
	$("#user_id").keydown(function() {
		var user_idObj = $("#user_id");
		var inputId = user_idObj.val();
		
		if(!CheckValue(inputId)){
			$('#idAlerTxt').text("4~12 자의 영문자, 숫자만 입력하세요.");	
		}else{
			$('#idAlerTxt').text("");
		}
		joinErrorFlagAry[1] = false;
	});

	// 입력창 벗어날 시 아이디가 유효한지 확인함
	// "탈퇴한 ID이거나, 이미 등록된 ID입니다."
	// 4글자 이상 영문, 숫자 입력하여 정상적인 아이디 일 때 -> "좋은 아이디 입니다."
	$("#user_id").blur(function() {
		var user_idObj = $("#user_id");
		var inputId = user_idObj.val();
		
		if(inputId.length > 3) {
			$.ajax({
				type: "POST",
				url: "/join/Join_Id_Chk_Ajax_2010.jsp",
				dataType: "json",
				data: "id="+inputId+"&date="+(new Date()),
				success: function(data) {
					var chkId = data.chkId;
					var colorValue = "";
					var textValue = "";
					
					if(chkId=="0") {
						colorValue = "#1da900";
						joinErrorFlagAry[1] = true;
						textValue = "좋은 아이디 입니다.";
					} else if(chkId == "-1") {
						colorValue = "#bd0f0e";
						textValue = "금칙어 입니다. 다시입력 해주세요.";
					} else if(chkId == "3") {
						colorValue = "#bd0f0e";
						textValue = "첫글자는 반드시 영문이어야 합니다.";
					} else {
						colorValue = "#bd0f0e";
						textValue = "탈퇴한 ID이거나, 이미 등록된 ID입니다.";
					}
					$('#idAlerTxt').text(textValue);
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
			$('#idAlerTxt').text(textValue);
			joinErrorFlagAry[1] = false;
		}
	});
	
	//비밀번호 입력시 비밀번호 규칙에 안 맞는 비번이 입력되고 있을 때
	//"8~15자의 영대/소문자, 숫자, 특수문자 중 3가지를 조합해주세요."
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
				$('#pwAlertTxt2').text("비밀번호가 일치하지 않습니다. 다시 입력해주세요");	
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
	
	joinObj.find("#email").blur(function() {
		// 이메일 체크	
	    if(form.email1.value == "") {
	    	alert("이메일을 입력해 주십시오.");
			form.email1.focus();
			return false;
	    }
		
		// 이메일 중복체크
		if(form.email1.value.trim().length > 0 ){
			
			//var semail = form.email1.value + "@" + form.email2.value;
			var semail = form.email1.value;
			
			if (!semail.isemail()){
				alert("올바른 이메일 주소를 입력해 주십시오.");
				form.email1.focus();
				return false;
			}
			
			
			// 이메일 중복체크 ajax
			var email_chk = false; 
			
			$.ajax({
				method: "POST",
				url: "/member/join/Join_Email_Chk_Ajax.jsp",
				data: "email="+semail,
				dataType: "json",			
				async: false, // ture: 비동기, false: 동기
				
				success:function(result){
					
					//console.log("result.chkEmail: " + result.chkEmail);
					
					// -1 이면 등록된 이메일이 없음.
					if(result.chkEmail=='-1'){
						email_chk = true;
					}
					
					//showChkStr(result.chkId);
					
				}
			});
			
			
			//console.log("email_chk: " + email_chk);
			
			if(email_chk==false){
				alert("이미 등록된 이메일 입니다.\n다른 이메일을 입력해 주십시오.")
				form.email1.focus();
				return false;
			}		
		}
	});
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
//	document.form_chk.target = "popupChk";
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
