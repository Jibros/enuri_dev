<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<% String strApp = ChkNull.chkStr(request.getParameter("app"),"");%>
<%
	String ENURI_COM_SSL = "https://m.enuri.com:442";
	String type = ChkNull.chkStr(request.getParameter("type"), "");
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
	location.href='https://m.enuri.com/mobilefirst/member/idpw.jsp?rtnUrl=<%=backUrl%>'; 
}
</script>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>에누리(가격비교) eNuri.com</title>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=yes, target-densitydpi=medium-dpi" name="viewport">
</head>
<%@include file="/mobilefirst/include/common.html"%>
<%@ include file="/mobilefirst/login/login_check.jsp"%>
<body>
	<div id="memberWrap" 
		<% 
			if(type.contains("mobiledepart")) out.println("class='mobiledepart'"); 
			else if(type.contains("deal")) out.println("class='mobiledeal'"); 
		%>
		>
		<div class="pageHead">
			<h1>ID / 비번 찾기</h1>
		</div>
		<div id="container">
			<fieldset>
				<legend>ID / 비번 찾기 입력</legend>
				<section class="titField">
					<h1>ID 찾기</h1>
					<p class="inputBox">
						<input type="text" name="name" id="name" class="txt" placeholder="이름" title="이름 입력" />
						<span class="alerTxt" id="nameAlerTxt"></span>
					</p>
					<p class="inputBox">
						<span class="inBtn" style="padding-right:64px;">
							<input type="number" name="phoneNum" id="phoneNum" class="txt" placeholder="휴대폰번호" title="휴대폰 번호 입력" />
							<span class="alerTxt" id="phoneAlerTxt"></span>
							<span class="btnBox"><button type="button" id="cerBtn" class="btnTxt" style="width:60px;">인증</button></span>
						</span>
					</p>
					<p class="inputBox">
						<span class="inBtn" style="padding-right:130px;">
							<input type="number" id="cerNum" name="cerNum" class="txt" placeholder="인증번호" title="인증번호 입력"/>
							<span class="alerTxt" id="cerAlerTxt"></span>
							<span class="btnBox">
								<button type="button" class="btnTxt" style="width:60px;" id="btnOk">확인</button>
								<button type="button" class="btnTxt" style="width:60px;display:none">재발송</button>
							</span>
						</span>
					</p>
				</section>
				<section class="titField">
					<h1>비번 찾기</h1>
					<p class="inputBox">
						<input type="text" class="txt" id="pw_userid" placeholder="ID" title="ID 입력" />
						<span class="alerTxt" id="idAlerTxt"></span>
					</p>
					<p class="inputBox">
						<input type="text" class="txt" name="pw_name" id="pw_name" placeholder="이름" title="이름 입력" />
						<span class="alerTxt" id="pw_nameAlerTxt"></span>
					</p>
					<p class="inputBox">
						<span class="inBtn" style="padding-right:64px;">
							<input type="number" class="txt" id="pw_phoneNum" placeholder="휴대폰번호" title="휴대폰 번호 입력" />
							<span class="alerTxt" id="pw_phoneAlerTxt"></span>
							<span class="btnBox"><button type="button" id="pw_cerBtn" class="btnTxt" style="width:60px;">인증</button></span>
						</span>
					</p>
					<p class="inputBox">
						<span class="inBtn" style="padding-right:130px;">
							<input type="number" id="pw_cerNum" class="txt" placeholder="인증번호" title="인증번호 입력" />
							<span class="alerTxt" id="pw_cerAlerTxt"></span>
							<span class="btnBox">
								<button type="button" class="btnTxt" style="width:60px;" id="pw_btnOk">확인</button>
								<button type="button" class="btnTxt" style="width:60px;display:none">재발송</button>
							</span>
						</span>
					</p>
				</section>
			</fieldset>
			<p class="txt_idpw"><span>※</span>휴면 회원은 ID/비밀번호 찾기가 제한되오니, 재가입을 권장 드립니다.</p>
		</div>
	</div>
</body>
<script type="text/javascript" charset="utf-8">

hpAuthComplete = false;	

	function backButton(){
	
		var iOS = /(iPad|iPhone|iPod)/g.test( navigator.userAgent );
		
		if(getCookie("appYN") == 'Y' ){
			location.href = "close://"
		}else{
			window.history.back(-1);
		}
			
	}

	$(document).ready(function(){

		//백버튼	
		$(".pageHead").append("<a href='javascript:///' class='back' onclick=\"backButton()\"></a>");
	
		//id 찾기
		$("#name").keyup(function (e) {
			
			var szKor = $(this).val();
			
			if( szKor == ""){
				$("#nameAlerTxt").text("한글을 입력해주세요");
				return false;
			}else{
				var kor_check = /([^가-힣ㄱ-ㅎㅏ-ㅣ\x20])/i;
				if (kor_check.test(szKor)){
					$("#nameAlerTxt").text("한글만 입력할 수 있습니다.");
					return false;
				}else{
					if( szKor.length < 2 || szKor.length > 6 ){
						$("#nameAlerTxt").text("2~6글자만 입력할수 있습니다.");
						return false;
					}else{
						$("#nameAlerTxt").text("");
					}
				}
			}
			
		});
		
		//pw 찾기
		$("#pw_name").keyup(function (e) {
			
			var szKor = $(this).val();
			
			if( szKor == ""){
				$("#pw_nameAlerTxt").text("한글을 입력해주세요");
				return false;
			}else{
				var kor_check = /([^가-힣ㄱ-ㅎㅏ-ㅣ\x20])/i;
				if (kor_check.test(szKor)){
					$("#pw_nameAlerTxt").text("한글만 입력할 수 있습니다.");
					return false;
				}else{
					if( szKor.length < 2 || szKor.length > 6 ){
						$("#pw_nameAlerTxt").text("2~6글자만 입력할수 있습니다.");
						return false;
					}else{
						$("#pw_nameAlerTxt").text("");
					}
				}
			}
			
		});
		
		$("#pw_userid").keyup(function (e) {
			var user_id = $(this).val();
			
			if(stringCheck(user_id) == "error") $("#idAlerTxt").text("한글 및 특수문자는 사용 할수 없습니다.");
			else $("#idAlerTxt").text("");
		
		});
		
		$("#phoneNum").keyup(function (e) {
			
			var phoneNum = $(this).val();
			
			if($.isNumeric(phoneNum)){
				$("#phoneAlerTxt").text("");
			}else{
				$("#phoneAlerTxt").text("숫자만 입력 할 수 있습니다.");	
			}
		});
		
		$("#pw_phoneNum").keyup(function (e) {
			
			var phoneNum = $(this).val();
			
			if($.isNumeric(phoneNum)){
				$("#pw_phoneAlerTxt").text("");
			}else{
				$("#pw_phoneAlerTxt").text("숫자만 입력 할 수 있습니다.");	
			}
		});
		
		//인증번호 전송
		$("#cerBtn").click(function(){
			
			var cs_tel = $("#phoneNum").val();
			if(cs_tel.length==0) {
				$('#phoneAlerTxt').text("휴대폰 번호를 입력해 주세요.");
				return;
			}

			$('#phoneAlerTxt').text("");
			
			document.hFrame.location.href = "/mobilefirst/ajax/login/findHpAuth_ajax.jsp?cs_tel="+cs_tel;

		});
		
		
		//인증번호 전송
		$("#pw_cerBtn").click(function(){
			
			var cs_tel = $("#pw_phoneNum").val();
			if(cs_tel.length==0) {
				$('#pw_phoneAlerTxt').text("휴대폰 번호를 입력해 주세요.");
				return;
			}

			$('#pw_phoneAlerTxt').text("");
			
			document.hFrame.location.href = "/mobilefirst/ajax/login/findHpAuth_ajax.jsp?cs_tel="+cs_tel+"&type=pw";

		});
		
		
		$("#cerNum").keyup(function (e) {
			
			var cerNum = $(this).val();
			
			if($.isNumeric(cerNum)){
				$("#cerAlerTxt").text("");
			}else{
				$("#cerAlerTxt").text("숫자만 입력 할 수 있습니다.");	
			}
			
		});
		
		
		$("#pw_cerNum").keyup(function (e) {
			
			var cerNum = $(this).val();
			
			if($.isNumeric(cerNum)){
				$("#pw_cerAlerTxt").text("");
			}else{
				$("#pw_cerAlerTxt").text("숫자만 입력 할 수 있습니다.");	
			}
			
		});
		
		
		//인증번호 인증
		$("#btnOk").click(function(){
			
			var cerNum = $("#cerNum").val();
			var phoneNum = $("#phoneNum").val();
			var username = $("#name").val();
			
			if(cerNum == ""){
				$("#cerAlerTxt").text("인증번호를 입력해 주세요.");
				return;
			}
			
			var loadUrl = "/mobilefirst/ajax/login/findHpAuthSendProc_ajax.jsp?";
				loadUrl+="sms_no="+cerNum+"&cs_tel="+phoneNum;
			console.log(loadUrl);
			$.ajax({
			  url: loadUrl,
			  dataType: 'json',
			  async: false,
			  success: function(data) {
				if(data){
					if(data.msg == "success"){
						
						location.href = "find_result.jsp?phoneNum="+phoneNum+"&name="+username;
						
					}else if(data.msg == "timeout"){
						
						$("#cerAlerTxt").text("인증번호 입력시간이 초과되었습니다. 인증번호를 재전송해주세요.");
						
					}else if(data.msg == "5out"){
						
						$("#cerAlerTxt").text("5회 이상 잘못 입력하셨습니다. 인증번호를 재전송해주세요.");
						
					}else if(data.msg == "fail"){
						
						$("#cerAlerTxt").text("인증번호가 올바르지 않습니다.인증번호를 다시 입력하거나 재전송해주세요.");
					}
				}
						
			  }
			});
			
			
		});
		
		
		//인증번호 인증
		$("#pw_btnOk").click(function(){
			
			var cerNum = $("#pw_cerNum").val();
			var phoneNum = $("#pw_phoneNum").val();
			var userid = $("#pw_userid").val();
			var name = $("#pw_name").val();
			
			if(userid == ""){
				$("#idAlerTxt").text("아이디를 입력해주세요");
				return;
			}
			
			if(name == ""){
				$("#pw_nameAlerTxt").text("이름을 입력해주세요");
				return;
			}
			
			
			if(cerNum == ""){
				$("#pw_cerAlerTxt").text("인증번호를 입력해 주세요.");
				return;
			}
			
			var loadUrl = "/mobilefirst/ajax/login/findHpAuthSendProc_ajax.jsp?";
				loadUrl+="sms_no="+cerNum+"&cs_tel="+phoneNum+"&username="+name+"&userid="+userid;
			
			var type = "<%=type%>";
			$.ajax({
			  url: loadUrl,
			  dataType: 'json',
			  async: false,
			  success: function(data) {
				if(data){
					
					// 입력하신 데이터  번호로 된 정보가 없습니다.					
					if(data.msgID == "IDNONE" || data.msgID == "IDDIFF"){
						alert("입력하신 정보와 일치하는 ID가 없습니다.");
						return;
					}
					
					if(data.msg == "success"){
						
						location.href = "newpass.jsp?phoneNum="+phoneNum+"&userid="+userid+"&type="+type;
						
					}else if(data.msg == "timeout"){
						
						$("#pw_cerAlerTxt").text("인증번호 입력시간이 초과되었습니다. 인증번호를 재전송해주세요.");
						
					}else if(data.msg == "5out"){
						
						$("#pw_cerAlerTxt").text("5회 이상 잘못 입력하셨습니다. 인증번호를 재전송해주세요.");
						
					}else if(data.msg == "fail"){
						
						$("#pw_cerAlerTxt").text("인증번호가 올바르지 않습니다.인증번호를 다시 입력하거나 재전송해주세요.");
					}
				}
						
			  }
			});
			
			
		});
		
		showInputInfoSendHpAuth = function (msg , temp){
			$('#phoneAlerTxt').text(msg);		
		}
		
		showPwInputInfoSendHpAuth = function (msg , temp){
			$('#pw_phoneAlerTxt').text(msg);		
		}
		
		jShowInputInfoSendHpAuth = function (msg , temp){
			$('#phoneAlerTxt').text(msg);		
		}
		
		//비번 찾기
		
	});

function showInputAuthComplete() {
	 
	$("#recvInputBox").children().empty();
	$("#recvInputBox").text("인증완료");
	
	hpAuthComplete = true;
}

function stringCheck( str ) 
{ 
	var result = (str.match(/[^(0-9a-zA-Z)]/)) ? 'error' : 'ok';
    return result; 
}

	
</script>
<iframe id="hFrame" name="hFrame" frameborder="0" style="margin:0px;padding:0px;height:0px;width:0px;"></iframe>
</html>
<%@ include file="/mobilefirst/include/common_logger.html"%>
