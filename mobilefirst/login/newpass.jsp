<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
	String strApp = ChkNull.chkStr(request.getParameter("app"),"");	 //	Y일때 앱
	String user_id = ChkNull.chkStr(request.getParameter("userid"));
%>
<!DOCTYPE html>
<html lang="ko">
<head>

<title>에누리(가격비교) eNuri.com</title>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=yes, target-densitydpi=medium-dpi" name="viewport">
<%@include file="/mobilefirst/include/common.html"%> 
<script type="text/javascript" src="/common/js/function.js"></script>
<style type="text/css">
.titField h1{position:relative;}
.ico_guide{display:block;width:23px;height:23px;position:absolute;top:6px;right:6px;background:url("http://imgenuri.enuri.gscdn.com/images/mobilefirst/ico_join_question.png") no-repeat 0 0;background-size:contain;text-indent:-9999em;}
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
<%@ include file="/mobilefirst/login/login_check.jsp"%>
	<div id="memberWrap">
		<div class="pageHead">
			<h1>ID / 비번 찾기</h1>
		</div>
		<div id="container">
			<fieldset>
				<legend>새 비밀번호 입력</legend>
				<section class="titField">
					<h1>새 비밀번호 설정<span class="ico_guide">비밀번호 설정 가이드</span></h1>
					<!-- 140806 수정 -->
					<p class="inputBox">
						<label for="newpass1"></label>
						<input type="password" id="newpass1" maxlength="15" class="txt" placeholder="(8~15자 영대/소문자, 숫자, 특수문자 중 3가지를 조합해주세요.)" />
					</p>
					<p class="inputBox">
						<label for="newpass2"></label>
						<input type="password" id="newpass2" maxlength="15" class="txt" placeholder="비밀번호 재입력" />
					</p>
					<!-- //140806 수정 -->
				</section>
				<p class="btnWrap"><a href="javascript:goPwUpdate()" class="btnType3">확인</a></p>
			</fieldset>
		</div>
	</div>
	<input type="hidden" name="userid" id="userid" value="<%=user_id%>">
	
</body>
<script language="JavaScript">
<!--

jQuery(document).ready(function($) {
		//백버튼	
		$(".pageHead").append("<a href='javascript:///' class='back' onclick=\"backButton()\"></a>");
});

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


function backButton(){

	var iOS = /(iPad|iPhone|iPod)/g.test( navigator.userAgent );
	
	if(getCookie("appYN") == 'Y' ){
		location.href = "close://"
	}else{
		window.history.back(-1);
	}
		
}




function goPwUpdate(){
	var pass1 = $("#newpass1").val();
	var pass2 = $("#newpass2").val();
	var userid = $("#userid").val();

	if(pass1.length == 0){
		alert("패스워드가 입력되지 았습니다.");
		$("#newpass1").focus();
		return;
	}
		
	if(pass2.length == 0){
		alert("패스워드가 입력되지않았습니다.");
		$("#newpass2").focus();
		return;
	}

	if(pass1 != pass2){
		alert("입력한 패스워드 가 다르게 입력 되었습니다. 다시 입력 해주세요");
			
		$("#newpass1").val("");
		$("#newpass2").val("");
			
		$("#newpass1").focus();
		return;
	}

	var passCheckFlag = false;
	if(pass1.length>=8) {
		// 영문또는 숫자인지 확인하는 정규식
		//passCheckFlag = rtn_engnumSum_chk(pass1);
		passCheckFlag = chkPassCombine(pass1);
		
	}
	if(pass2.length>=8) {
		// 영문또는 숫자인지 확인하는 정규식
		//passCheckFlag = rtn_engnumSum_chk(pass2);
		passCheckFlag = chkPassCombine(pass2);
		
	}

	if(pass1.indexOf("<%=user_id%>")>-1) {
		alert("아이디를 포함한 비밀번호는 사용할 수 없습니다.");

		$("#newpass1").focus();

		return;
	}
	if(pass2.indexOf("<%=user_id%>")>-1) {
		alert("아이디를 포함한 비밀번호는 사용할 수 없습니다.");

		$("#newpass2").focus();

		return;
	}

	if(!passCheckFlag) {
		alert("비밀번호 입력 형식이 잘못되었습니다.\n8~15자의 영문, 숫자가 조합된 비밀번호로 입력해 주세요.");
		$("#newpass1").focus();

		return;
	}

	var loadUrl = "pw_update.jsp?newpass="+pass1+"&userid="+userid;
		
	$.ajax({
	  url: loadUrl,
	  dataType: "html",
	  async: false,
	  success: function(data) {
		if(data){
			//if(data.result){
				alert("비밀번호 변경 완료");
				goLogin();
			//}
		}
	  }
	});
}

//=== 영문, 숫자 확인
//영문 또는 숫자이면 true, 아니면 false
function rtn_engnum_chk(str) {
	for(var i=0; i<=str.length-1; i++) {
		if('a' <= str.charAt(i) && str.charAt(i) <= 'z' || str.charAt(i) >= '0' && str.charAt(i) <= '9'){}
		else {
			return false;
		}
	}
	return true;
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
	
	var numbFind = 0;
	/*
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
	
	if(numbFind==3) return false;

	if(findFlag==2) return true;
	else return false;
}

</script>
</html>
<%@ include file="/mobilefirst/include/common_logger.html"%>
