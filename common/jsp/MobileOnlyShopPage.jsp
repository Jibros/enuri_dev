<%@ page contentType="text/html; charset=utf-8" %>
<script type='text/javascript'>
function onoffMobileOnlyLayer(id) {
	var mid=document.getElementById(id);
	if(mid.style.display=='') {
	mid.style.display='none';
}else{
	mid.style.display='';
	}
}


function chkiszzimModel(modelno){
	try{
		var ret = false;
		url = "/common/jsp/chkZzim.jsp?modelno=" + modelno;		
		jQuery.ajax({
			url : url,			
			async:false,				
			type:"GET",
			datatype:"json",
			success:function(result){				
				ret = jQuery.parseJSON(result.replace(/(^\s*)|(\s*$)/gi, ""));
			}
		});
		
		return ret;
	}catch(err){
		return false;
	}
}

function chkiszzimGoods(pl_no){
	try{
		var ret = false;
		url = "/common/jsp/chkZzim.jsp?pl_no=" + pl_no;
		jQuery.ajax({
			url : url,			
			async:false,
			type:"GET",
			datatype:"json",
			success:function(result){				
				ret = jQuery.parseJSON(result.replace(/(^\s*)|(\s*$)/gi, ""));
			}
		});
		
		return ret;
	}catch(err){
		// console.log(err);
		return false;
	}
}

function showMobileOnlyModelLayer(modelno){
	var isZzim = chkiszzimModel(modelno);
	onoffMobileOnlyLayer('mobileOnlyLayer');	
	// 찜
	var MobileOnlyjjimChk = jQuery('#MobileOnlyjjimChk');
	MobileOnlyjjimChk.prop('checked',isZzim);
	
	MobileOnlyjjimChk.attr('modelno', modelno);
	MobileOnlyjjimChk.attr("pl_no", '');	
	
	// SMS 세팅
	jQuery('#mobileOnlySmsBtnSend').attr('modelno', modelno);
	jQuery('#mobileOnlySmsBtnSend').attr("pl_no", '');
	
	// QR 코드
	setQrCodeImg_model(modelno);
}

function showMobileOnlyGoodsLayer(pl_no, goodskeyword){
	var isZzim = chkiszzimGoods(pl_no);
	
	onoffMobileOnlyLayer('mobileOnlyLayer');
	var MobileOnlyjjimChk = jQuery('#MobileOnlyjjimChk');	
	MobileOnlyjjimChk.prop('checked',isZzim);
	
	MobileOnlyjjimChk.attr('modelno', '');
	MobileOnlyjjimChk.attr("pl_no", pl_no);	
		
	// SMS 세팅	
	jQuery('#mobileOnlySmsBtnSend').attr('modelno', '');
	jQuery('#mobileOnlySmsBtnSend').attr("goodskeyword", goodskeyword);
	jQuery('#mobileOnlySmsBtnSend').attr("pl_no", pl_no);
	
	// QR 코드 - 
	setQrCodeImg_goods(pl_no, goodskeyword);
}

// 찜은 goods에, QR이랑 SMS는 model에 매핑.
function showMobileOnlyMixLayer(modelno, pl_no){
	var isZzim = chkiszzimGoods(pl_no);
	
	onoffMobileOnlyLayer('mobileOnlyLayer');	
	// 찜
	var MobileOnlyjjimChk = jQuery('#MobileOnlyjjimChk');
	MobileOnlyjjimChk.prop('checked',isZzim);	
	MobileOnlyjjimChk.attr('modelno', '');
	MobileOnlyjjimChk.attr("pl_no", pl_no);	
	
	// SMS 세팅
	jQuery('#mobileOnlySmsBtnSend').attr('modelno', modelno);
	jQuery('#mobileOnlySmsBtnSend').attr("pl_no", '');
	
	// QR 코드
	setQrCodeImg_model(modelno);
}

function sendDetailSms(part){	
	var title = '에누리 모바일 전용 상품 안내.';
	var myphone = document.getElementById("phonenum_ListHeader").value;
	var rurl = '';
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

	var pl_no = document.getElementById('mobileOnlySmsBtnSend').getAttribute('pl_no');
	var modelno = document.getElementById('mobileOnlySmsBtnSend').getAttribute('modelno');
	var goodskeyword = document.getElementById('mobileOnlySmsBtnSend').getAttribute('goodskeyword');
	if(pl_no == ''){
		if (modelno != ''){
			rurl = encodeURIComponent("http://m.enuri.com/mobilefirst/detail.jsp?_qr=y&modelno="+ modelno + "&hoticon=-1");	
		}else if (goodskeyword != ''){
			rurl = encodeURIComponent("http://m.enuri.com/mobilefirst/search.jsp?_qr=y&keyword="+goodskeyword);
		}
	}else{
		rurl = encodeURIComponent("http://m.shinsegaetvshopping.com/display/detail/" + pl_no + "?inMediaCode=MC04&ckwhere=enuri_ep");
	}
	
	
	if (rurl == ''){
		alert('오류가 발생했습니다.');
		return;
	}
	

	if(rurl!=""){
		rurl = rurl.replace(/\?/ig, "--***--");
		rurl = rurl.replace(/\&/ig, "--**--");
		document.getElementById("ifListHeader").src = "/common/jsp/Ajax_ListHeader_Sms_Proc.jsp?part="+part+"&rurl="+rurl+"&phoneno="+myphone+"&title="+encodeURIComponent(title);
	}else{
		alert("주소를 읽어오지 못했습니다.");
	}
	
	document.getElementById("phonenum_ListHeader").value = "";
}


function mobileOnlyIslogin(){
	var cName = "LSTATUS";
	var s = document.cookie.indexOf(cName +'=');
	if (s != -1){
		s += cName.length + 1;
		e = document.cookie.indexOf(';',s);
		if (e == -1){
			e = document.cookie.length
		}
		if( unescape(document.cookie.substring(s,e))=="Y"){
			return true;
		}else{
			return false;
		}
	}else{
		return false;
	}
}

//찜되었습니다 렌더링.
function mobileOnlyzzimRender(){	
	
	var modelno = jQuery('#MobileOnlyjjimChk').attr('modelno');
	var pl_no = jQuery('#MobileOnlyjjimChk').attr('pl_no');
	var zzimStatus = false; // 찜 되어있나 여부 ajax로 체크.
	if (modelno != ''){
		zzimStatus = chkiszzimModel(modelno);
	}
	if (pl_no != ''){
		zzimStatus = chkiszzimGoods(pl_no);
	}
	
	if (zzimStatus){
		jQuery('#mobileOnlyZzimResult').text('찜 되었습니다!');
	}else{
		jQuery('#mobileOnlyZzimResult').text('찜 삭제되었습니다!');
	}
	
	jQuery('#mobileOnlyLayer').show();
	jQuery('#mobileOnly_div_save_msg').show();
	setTimeout(function(){jQuery('#mobileOnlyLayer').hide();},3000);
	setTimeout(function(){jQuery('#mobileOnly_div_save_msg').hide();},3000);	
}

function mobileOnlyzzim(){			
	var modelno = jQuery('#MobileOnlyjjimChk').attr('modelno');
	var pl_no = jQuery('#MobileOnlyjjimChk').attr('pl_no');
	var chkstatus = jQuery('#MobileOnlyjjimChk').is(":checked");
	
	if(mobileOnlyIslogin()){
		var url = "";
		if (chkstatus){
			url = "/view/include/insertSaveGoodsProc.jsp";			
		}else{ 
			url = "/view/deleteSaveGoodsProc.jsp";
		}
		
		var modeldata = "";
		if (modelno != ''){
			modeldata = "G:" + modelno;
		}
		if (pl_no != ''){
			modeldata = "P:" + pl_no;
		}
		
		if (modeldata != ''){
			try{
				jQuery.ajax({
					url : url,
					data : {"modelnos":modeldata, "tbln":"save"},
					async:false,				
					type:"GET"
				});
			}catch(err){
				
			}
		}
		
		mobileOnlyzzimRender();		
	}else{
		document.getElementById('mobileOnlyLayer').style.display="none";
		Cmd_Login('mobileonly');
	}
	
	/*
	if (CmdJJim){
		CmdJJim();
		return;
	}
	if (top && top.CmdJJim){
		top.CmdJJim();
		return;
	}	
	if (top && top.zzim){
		top.zzim();
		return;
	}	
	if (top && top.top && top.top.zzim){
		top.top.zzim();
		return;
	}
	*/
}

var qrCodeResetTryCnt = 0;
function setQrCodeImg_model(modelno){
  	var newDate = new Date();
  	var qrName = newDate.getTime();

	if(document.getElementById("mobileOnlyQrcodeImg").src==""){
		document.getElementById("mobileOnlyQrcodeImg").src = "/view/qrcode/qr_model_"+modelno+".png?v="+(new Date()).getTime();
	}else{ //onerror이므로 생성 호출
		if(qrCodeResetTryCnt<5){ //5회까지만 생성 재시도
			qrCodeResetTryCnt++;

			function showQrModel(originalRequest){
				setTimeout(function(){
					document.getElementById("mobileOnlyQrcodeImg").src = "/view/qrcode/qr_model_"+modelno+".png?v="+qrName;
				},1000);
			}
			var pl_no = document.getElementById('mobileOnlySmsBtnSend').getAttribute('pl_no');
			var aUrl = "/view/make_qr2.jsp";
			var param = "";
			if(pl_no == ''){
				param += "&url="+encodeURIComponent("http://m.enuri.com/mobilefirst/detail.jsp?_qr=y&modelno="+modelno+"&hoticon=-1");
			}else{
				param += "&url="+encodeURIComponent("http://m.shinsegaetvshopping.com/display/detail/" + pl_no + "?inMediaCode=MC04&ckwhere=enuri_ep");
			}
			param = param + "&t=qr_model_"+modelno;
			try{
				var getMakeQr = jQuery.ajax({
					url : aUrl,
					data : param,
					async:true,
					success:showQrModel,
					type:"GET"
				});
			}catch(err){
				
			}
		}else{
			return;
		}
	}
}

function setQrCodeImg_goods(pl_no, goodskeyword){
	
  	var newDate = new Date();
  	var qrName = newDate.getTime();

	if(document.getElementById("mobileOnlyQrcodeImg").src==""){
		document.getElementById("mobileOnlyQrcodeImg").src = "/view/qrcode/qr_goods_"+pl_no+".png?v="+(new Date()).getTime();
	}else{ //onerror이므로 생성 호출
		if(qrCodeResetTryCnt<5){ //5회까지만 생성 재시도
			qrCodeResetTryCnt++;

			function showQrGoods(originalRequest){
				setTimeout(function(){
					document.getElementById("mobileOnlyQrcodeImg").src = "/view/qrcode/qr_goods_"+pl_no+".png?v="+qrName;
				},1000);
			}
			
			var aUrl = "/view/make_qr2.jsp";
			var param = "";
			param += "&url="+encodeURIComponent("http://m.shinsegaetvshopping.com/display/detail/" + pl_no + "?inMediaCode=MC04&ckwhere=enuri_ep");
// 			param += "&url="+encodeURIComponent("http://m.enuri.com/mobilefirst/search.jsp?_qr=y&keyword="+goodskeyword);
			param = param + "&t=qr_goods_"+pl_no;
			try{
				var getMakeQr = jQuery.ajax({
					url : aUrl,
					data : param,
					async:true,
					success:showQrGoods,
					type:"GET"
				});
			}catch(err){
				
			}
		}else{
			return;
		}
	}
}

function mobileOnlyResize(top, left){	
		document.getElementById('mobileOnlyLayer').style.top = top;
		document.getElementById('mobileOnlyLayer').style.left = left;
}

function mobileOnlyRemoveZzim(){
	document.getElementById('MobileOnlyLiJJim').style.display="none";
}

function getOffset( el ) {
    var _x = 0;
    var _y = 0;
    while( el && !isNaN( el.offsetLeft ) && !isNaN( el.offsetTop ) ) {
        _x += el.offsetLeft - el.scrollLeft;
        _y += el.offsetTop - el.scrollTop;
        el = el.offsetParent;
    }
    return { top: _y, left: _x };
}

function addmobileOnlyLayerClass(clsname){
	if (clsname != ''){
		document.getElementById('mobileOnlyLayer').className = "mobile_only " + clsname;
	}
}

</script>
<div class="mobile_only" id="mobileOnlyLayer" style="display: none;z-index:999px;">
	<a href="javascript:///" class="close" onclick="onoffMobileOnlyLayer('mobileOnlyLayer')">창닫기</a>
	<h4>모바일 전용 상품</h4>
	<div class="boxly">
		<p class="qrcode"><img id="mobileOnlyQrcodeImg" src="http://imgenuri.enuri.gscdn.com/images/home/@qr.gif" alt=""></p>
		<div class="m_txt">
			<p>모바일에서만 구매할 수 있는 모바일 전용<br>찜/핸드폰 전송 또는 QR코드를 스캔하여<br>모바일에서 최저가를 확인하세요.</p>
			<ul>
				<li id="MobileOnlyLiJJim"><label><input type="checkbox" id="MobileOnlyjjimChk" onclick="mobileOnlyzzim();" modelno='' goodskeyword ='' pl_no='' >찜<!-- label--></label></li>
				<li><a href="#" class="smsp" onclick="onoffMobileOnlyLayer('sms'); return false;">핸드폰 전송</a></li>							
				<li class="app" onclick="window.open('/common/jsp/App_Landing.jsp','_blank');return false;">에누리앱 설치</li> 
			</ul>
		</div>
	</div>
	<div class="boxly_b" id="sms" style="display: none;">
		<span class="mms"><input type="text" name="phonenum_ListHeader" id="phonenum_ListHeader" onfocus="if(this.value =='-없이 입력하세요.') this.value='';" onblur="if(this.value =='') this.value='-없이 입력하세요.';" value="-없이 입력하세요."></span>
		<span class="btn_send" onclick="sendDetailSms('detail');return false;" id='mobileOnlySmsBtnSend' modelno='' goodskeyword =''  pl_no='' >전송</span>
		<p>- 상품 상세 주소를 무료문자로 발송해드립니다.<br>- 입력하신 번호는 저장되지 않습니다.</p>
		<iframe frameborder="0" src="" id="ifListHeader" style="width:0px;height:0px;display:none"></iframe>
	</div>
	<div id="mobileOnly_div_save_msg" style="position: absolute; top: 20%; left: 30%; width: 156px; height: 62px; display:none; background-image: url(http://imgenuri.enuri.gscdn.com/images/view/resentzzim/layer_ok.png);"><img src="http://imgenuri.enuri.gscdn.com/images/view/resentzzim/btn_x.gif" border="0" align="absmiddle" style="position:absolute;left:140px;top:5px;cursor:pointer;" onclick="document.getElementById('mobileOnly_div_save_msg').style.display='none'"><img src="http://imgenuri.enuri.gscdn.com/images/view/resentzzim/go_zlist_over.gif" border="0" align="absmiddle" style="position:absolute;left:50px;top:37px;cursor:pointer;" onclick="resentZzimOpen(2)"><span style="position:absolute;left:36px;top:15px;color:#008ad6;font-weight:bold;font-family:맑은 고딕" id="mobileOnlyZzimResult">찜 되었습니다!</span></div>
</div>