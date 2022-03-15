<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<META NAME="description" CONTENT="최저가 에누리 - 가격비교 사이트 에누리닷컴입니다.">
<META NAME="keyword" CONTENT="휴대폰, 사무, 생활가전, 용품, 영상음향, 컴퓨터, 자동차, 명품, 잡화, 스포츠, 유아, 완구, 가구, 화장품, 식품, 가격비교, 쇼핑몰, 최저가">
<link rel="shortcut icon" href="<%=ConfigManager.IMG_ENURI_COM %>/2014/layout/favicon_enuri.ico">
<title>에누리(가격비교) eNuri.com</title>
<script type="text/javascript" src="/common/js/lib/mustache.js"></script>
<script type="text/javascript" src="/common/js/lib/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/common/js/common_top.js"></script>
<script type="text/javascript" src="/common/js/function.js"></script>
<script type="text/javascript" src="/common/js/paging.js"></script>
<script type="text/javascript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Header.js"></script>
<script type="text/javascript" src="/event/Event_Common_Func.js"></script>
<%@ include file="/common/jsp/eb/head_2015.jsp"%>

<style>
#m_footer .m_footInner address {float:left;margin:0 4px 0 0;color:#888;font-style:normal;}
</style>
<link rel="stylesheet" href="/common/css/app_landing.css" type="text/css">
<script type="text/javascript">
	insertLog(11981);
	function clearPhone(){
		$("#phone_enuri").val("");
		$("#phone_car").val("");
		$("#phone_hotdeal").val("");
	}

	function checkNumber() {
	  var key = event.keyCode;
	  if(!(key==8||key==9||key==13||key==46||key==144||
	      (key>=48&&key<=57)||key==110||key==190)) {
	      alert("숫자만 입력해주세요.");
	      event.returnValue = false;
	  }
	}

	function SendSms(type){
		var myphone = $("#phone_"+type).val();
		var title = "";
		var rurl = "";
		if(type=="enuri"){
			title = "에누리가격비교";
			rurl = "http://goo.gl/O8CUnn";
		}else if(type=="hotdeal"){
			title = "스마트핫딜";
			rurl = "http://goo.gl/j62WKU";
		}else if(type=="smart"){
			title = "스마트택배";
			rurl = "http://bitly.kr/ldoP0Y";
		}

		if(myphone==""){
			alert("휴대폰 번호가 입력되지않았습니다.");
			return;
		}
		var rgEx = /(01[016789])(\d{4}|\d{3})\d{4}$/g;
		var chkFlg = rgEx.test(myphone);
		if(!chkFlg){
    		alert("잘못된 형식의 휴대폰 번호입니다.");
    		return;
   		}

   		//document.getElementById("ifSimpleheader").src = "/common/jsp/Ajax_Simpleheader_Sms_Proc.jsp?procType="+proctype+"&phoneno="+myphone;
   		document.getElementById("ifSimpleheader").src = "/common/jsp/Ajax_ListHeader_Sms_Proc.jsp?part="+type+"&rurl="+rurl+"&phoneno="+myphone+"&title="+encodeURIComponent(title);
   		clearPhone();
	}
</script>
</head>
<body>
<div id="main_body">
	<div>
	<jsp:include page="/common/jsp/Common_Top_2015.jsp" flush="true">
    	<jsp:param value="w_bg" name="gnbType"/>
	</jsp:include>
		</div>
		<!-- app 다운로드 -->
			<div class="app_wrap">
				<div class="landing01">
					<div class="sp_enuri">
						<ul>
							<li><a href="https://play.google.com/store/apps/details?id=com.enuri.android" onclick="insertLog(11983);" class="goole" target="_new">구글 PLAY스토어</a></li>
							<li><a href="https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8" onclick="insertLog(11984);" class="apple" target="_new">애플 스토어</a></li>
							<li>
								<fieldset>
									<legend>SMS보내기</legend>
									<input type="text" onfocus="this.className='focus'" title="휴대폰 번호 입력" class="mobile" name="phone_enuri" id="phone_enuri" onkeypress="checkNumber();" style="ime-mode:disabled;"><button type="button" class="send" onclick="SendSms('enuri');insertLog(11982);"></button>
								</fieldset>
							</li>
						</ul>
					</div>
				</div>
				<div class="landing02"></div>
				<div class="landing03">
					<div class="sp_car">
						<ul>
							<li><a href="https://play.google.com/store/apps/details?id=com.sweettracker.smartparcel" onclick="insertLog(11986);" class="goole" target="_new">구글 PLAY스토어</a></li>
							<li><a href="https://itunes.apple.com/kr/app/seumateutaegbae-taegbaejohoe/id523045854?mt=8" onclick="insertLog(11987);" class="apple" target="_new">애플 스토어</a></li>
							<li>
								<fieldset>
									<legend>SMS보내기</legend>
									<input type="text" onfocus="this.className='focus'" title="휴대폰 번호 입력" class="mobile" name="phone_smart" id="phone_smart" onkeypress="checkNumber();" style="ime-mode:disabled;"><button type="button" class="send" onclick="SendSms('smart');insertLog(11985);"></button>
								</fieldset>
							</li>
						</ul>
					</div>
					<div class="sp_hotdeal">
						<ul>
							<li><a href="https://play.google.com/store/apps/details?id=com.enuri.deal" onclick="insertLog(11989);" class="goole" target="_new">구글 PLAY스토어</a></li>
							<li><a href="https://itunes.apple.com/kr/app/seumateuhasdil-sosyeolkeomeoseu/id944887654?mt=8" onclick="insertLog(11990);" class="apple" target="_new">애플 스토어</a></li>
							<li>
								<fieldset>
									<legend>SMS보내기</legend>
									<input type="text" onfocus="this.className='focus'" title="휴대폰 번호 입력" class="mobile" name="phone_hotdeal" id="phone_hotdeal" onkeypress="checkNumber();" style="ime-mode:disabled;"><button type="button" class="send" onclick="SendSms('hotdeal');insertLog(11988);"></button>
								</fieldset>
							</li>
						</ul>
					</div>
				</div>
			</div>
		<!-- //app 다운로드 -->
	    <style type="text/css">
			.bnr_area {background:url(http://imgenuri.enuri.gscdn.com/images/main/bg_footer_bnr.gif) 0 0}
		</style>
		<jsp:include page="/include/IncListFooter_2010.jsp" flush="true"></jsp:include>
	</div>
</div>
<iframe frameborder="0" src="" id="ifSimpleheader" style="width:0px;height:0px;display:none"></iframe>
</body>
</head>
</html>