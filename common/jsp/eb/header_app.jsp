<script type="text/javascript">
	/*레이어 열고닫고*/
	function onoff(id) {
		var mid=document.getElementById(id);
		if(mid != null) {
			if(mid.style.display=='') {
				insertLog(11716);
				mid.style.display='none';
			}else{
		 		mid.style.display='';
			}
		}
	}

	/*tab*/
	function clickEvent(nIdx){
		clearPhonenum();
		if ( nIdx == 1 ){
			$(".sp_enuri").show(); $(".sp_car").hide(); $(".sp_hotdeal").hide(); $(".sp_depart").hide();}
		if ( nIdx == 2 ){
			$(".sp_car").show(); $(".sp_enuri").hide(); $(".sp_hotdeal").hide(); $(".sp_depart").hide();}
		if ( nIdx == 3 ){
			$(".sp_hotdeal").show(); $(".sp_enuri").hide(); $(".sp_car").hide(); $(".sp_depart").hide();}
		if ( nIdx == 4 ){
			$(".sp_depart").show(); $(".sp_enuri").hide(); $(".sp_car").hide(); $(".sp_hotdeal").hide();}
	}

	function clearPhonenum(){
		$("#phonenum_enuri").val("");
		$("#phonenum_car").val("");
		$("#phonenum_hotdeal").val("");
	}

	function checkForNumber() {
	  var key = event.keyCode;
	  if(!(key==8||key==9||key==13||key==46||key==144||
	      (key>=48&&key<=57)||key==110||key==190)) {
	      alert("숫자만 입력해주세요.");
	      event.returnValue = false;
	  }
	}

	function clickSendSms(type){
		var myphone = $("#phonenum_"+type).val();
		var title = "";
		var rurl = "";
		if(type=="enuri"){
			title = "에누리가격비교";
			rurl = "http://goo.gl/O8CUnn";
		}else if(type=="car"){
			title = "신차비교";
			rurl = "http://goo.gl/muoqQ9";
		}else if(type=="hotdeal"){
			title = "스마트핫딜";
			rurl = "http://goo.gl/j62WKU";
		}else if(type=="depart"){
			title = "에누리가격비교";
			rurl = "http://goo.gl/O8CUnn";
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
   		clearPhonenum();
	}
</script>
<div class="com_lay_app com_lay_box">
        <div class="spbox" id="simpleHeader">
		<ul class="sp_tab">
            <li><a href="javascript:void(0);" onclick="$('.sp_enuri').show().siblings('div').hide();">에누리 가격비교</a></li>
            <li><a href="javascript:void(0);" onclick="$('.sp_hotdeal').show().siblings('div').hide();">소셜비교</a></li>
        </ul>

		<!-- 에누리 -->
		<div class="sp_enuri" style="display:block;">
			<h2>에누리 가격비교 </h2>
			<p>모바일로 더욱 특별해진 가격비교!</p>
			<dl>
				<dt>QR코드 스캔</dt>
				<dd>QR코드</dd>
				<dt>앱 다운로드</dt>
				<dd><a href="https://play.google.com/store/apps/details?id=com.enuri.android" class="goole" target="_new">구글 PLAY스토어</a></dd>
				<dd><a href="https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8" class="apple" target="_new">애플 스토어</a></dd>
				<dt>다운로드 SMS 보내기</dt>
				<dd>
					<fieldset>
						<legend>SMS보내기</legend>
						<input type="text" onfocus="this.className='focus'" title="휴대폰 번호 입력" class="mobile" name="phonenum_enuri" id="phonenum_enuri" onkeypress="checkForNumber();" style="ime-mode:disabled;"><button type="button" class="send" onclick="clickSendSms('enuri')"></button>
					</fieldset>
				</dd>
				<dd>앱 설치페이지 주소를 무료문자로 발송해 드립니다.</dd>
				<dd>입력하신 번호는 저장되지 않습니다.</dd>
			</dl>
		</div>

		<!-- 스마트 핫딜 -->
		<div class="sp_hotdeal" style="display:none">
			<h2>스마트 핫딜</h2>
			<p>소셜커머스는 물론 오픈마켓, 종합몰의 핫딜 상품을 한곳에!</p>
			<dl>
				<dt>QR코드 스캔</dt>
				<dd>QR코드</dd>
				<dt>앱 다운로드</dt>
				<dd><a href="https://play.google.com/store/apps/details?id=com.enuri.deal" class="goole" target="_new">구글 PLAY스토어</a></dd>
				<dd><a href="https://itunes.apple.com/kr/app/seumateuhasdil-sosyeolkeomeoseu/id944887654?mt=8" class="apple" target="_new">애플 스토어</a></dd>
				<dt>다운로드 SMS 보내기</dt>
				<dd>
					<fieldset>
						<legend>SMS보내기</legend>
						<input type="text" onfocus="this.className='focus'" title="휴대폰 번호 입력" class="mobile" name="phonenum_hotdeal" id="phonenum_hotdeal" onkeypress="checkForNumber();" style="ime-mode:disabled;"><button type="button" class="send" onclick="clickSendSms('hotdeal')"></button>
					</fieldset>
				</dd>
				<dd>앱 설치페이지 주소를 무료문자로 발송해 드립니다.</dd>
				<dd>입력하신 번호는 저장되지 않습니다.</dd>
			</dl>
		</div>

	</div>
</div>
<iframe frameborder="0" src="" id="ifSimpleheader" style="width:0px;height:0px;display:none"></iframe>