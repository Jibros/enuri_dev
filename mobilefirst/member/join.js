var IMG_ENURI_COM = "http://img.enuri.gscdn.com";
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
// ???????????? ???????????? ??????
function changePage(tempPageType) {
	// ???????????? ?????? ????????? ????????? ?????? ????????? ????????? ????????? ???????????? ????????? ?????? ???????????? ??????
	 //document.location.href = "/mobile2/login/login.jsp?pageType="+tempPageType;
	
	if(pageType!=tempPageType) {
		
		oldPageType = pageType;

		unsetEvents(tempPageType);

		pageType = tempPageType;

		//loadPageUI(tempPageType);
	}
}

// ????????? UI??? ???????????? ???????????? ???????????? ??????
function sizeSet() {
	sizeChangeCss();

	$(window).unbind();
	$(window).resize(function() {
		sizeChangeCss();
	});
}

// ????????? ?????????
// ?????? ????????? ???????????? ????????? ??????
var checkFlag = [false, false, false];
var nameHangulCheckFlag = true;

var joinErrorObjAry = ["#name","#user_id","#pass1","#pass2","#sendHp","#recvHp"];

//?????? ?????? show
function restLayerShow(strID){
	
	$(".id").text(strID);
	$(".dim").show();
}

//=== ??????, ?????? ?????? ??????
//???????????? true, ????????? false
function rtn_engnum_mix_chk(str) {
	var chk_num = str.search(/[0-9]/g);
	var chk_eng = str.search(/[a-z]/ig);
	if(chk_num < 0 || chk_eng < 0) {
		return false;
	}
	return true;
}

// ???????????? true, ????????? false
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

//=== ??????, ?????? ??????
//?????? ?????? ???????????? true, ????????? false
function rtn_engnum_chk(pw) {
	
	//console.log(chkPassCombine(pw));

	return chkPassCombine(pw);
	
}

//=== ?????? ????????? ????????? ????????? ????????? ?????????????????????
//?????? ?????? ???????????? true, ????????? false
function rtn_engnumSum_chk(str) {
	if(!rtn_engnum_chk(str)) {
		return false;
	}

	var findFlag = 0;
	// ????????????
	for(var i=0; i<=str.length-1; i++) {
		if('a' <= str.charAt(i) && str.charAt(i) <= 'z') {
			findFlag++;
			break;
		}
	}
	// ?????? ??????
	for(var i=0; i<=str.length-1; i++) {
		if(str.charAt(i) >= '0' && str.charAt(i) <= '9') {
			findFlag++;
			break;
		}
	}

	// ?????? ?????? 3??? ??????
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


// ????????? ?????? ????????? ????????? ???????????? ?????? ??????
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

// ???????????? ??????????????? ???????????? ????????????
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



// ???????????? ??????????????? ???????????? ????????????
function jShowInputInfoSendHpAuth(txt) {
	
	$('#phoneAlertTxt').text(txt);

}


//???????????? ??????????????? ???????????? ????????????
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

// ????????? ?????? ????????? ?????? ??????
var hpAuthComplete = false;

/*
function showInputAuthComplete() {
	showInputInfoSendHpAuth("", 1);

	$("#join .sendHpAuth #btn_sendImg").css("display", "none");
	$("#join .sendHpAuth .authCompDiv").css("display", "block");
	$("#join .recvHpAuth").css("display", "none");
	$("#join .recvHpAuthInfo").css("display", "none");
	
	// ?????? ????????? ?????????
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

// ???????????? ?????????????????? ???????????? ???
function recvHpAuthShow() {
	$("#join .recvHpAuth").css("display", "block");
}

//????????? ?????????
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

	// ?????? ??????
	if(tempPageType==3) {
		var authSelectObj = $("authSelect");
		authSelectObj.find("#selfBtnImg").unbind();
		authSelectObj.find("#ipinBtnImg").unbind();
	}
}

function sizeChangeCss() {
	var tempWidth = $(window).width();

	// ??????
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
// *************** ?????? ?????? ?????? ********************
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
// *************** ?????? ?????? ??? *********************
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

//preOpen??? ??????
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
