var SimpleView = function(modelno,cate,vtype){

	if (typeof SimpleView.instance === "object"){
		if (typeof(modelno) != "undefined"){
			SimpleView.instance.modelno = modelno;
			SimpleView.instance.oldcate = SimpleView.instance.cate;
			SimpleView.instance.cate = cate;
			SimpleView.instance.type = vtype;
		}
		return SimpleView.instance
	}
	this.modelno = modelno;
	this.modelnm = "";
	this.divObj = document.getElementById("simpleView");
	this.blankObj = document.getElementById("simpleViewBlank");
	this.filterObj = document.getElementById("svfFilter");
	//this.bannerObj = document.getElementById("spBanner");
	this.frmObj = document.getElementById("frmSimpleView");
	this.shareObj = document.getElementById("simpleViewShare");
	this.mailObj = document.getElementById("simpleViewMail");
	this.viewState = false;
	this.clipBoards = [];
	this.cate = cate;
	this.oldcate = "";
	this.menu = 1;
	this.type = vtype;
	this.fixWidth = false;
	if (document.URL.indexOf("/search/Searchlist.jsp") >= 0){
		this.fixWidth = true;
	}

	if (typeof(loadingSvBanner) == "function"){
		this.isBanner = true;
	}else{
		this.isBanner = false;
	}
	SimpleView.instance = this;

}
var timerSvBanner = null;
function showSimpleView(modelno,popular,cate,vtype){
	/*
	m : 간략보기(default)
	s : 유사상품
	r : 렌탈상품
	 */
	var varType = "m";
	if (typeof(vtype) != "undefined"){
		varType = vtype;
	}
	var simpleViewObj = new SimpleView(modelno,cate,varType);
	if (simpleViewObj.viewState){
		simpleViewObj.load();
		if (simpleViewObj.shareObj.className != "_hideClass"){
			hideShareMenu();
		}
		if (simpleViewObj.mailObj.className != "_hideClass"){
			hideShareMail();
		}
	}else{
		simpleViewObj.load();
		simpleViewObj.show();
	}
	simpleViewPreProcess(modelno,popular,cate);
	if (simpleViewObj.isBanner){
		timerSvBanner = setInterval(function(){
			loadingSvBanner();
		},5000);
	}
	setTimeout(function(){
		if (simpleViewObj.cate != simpleViewObj.oldcate && simpleViewObj.menu != 1){
			if (simpleViewObj.cate.length > 6 && simpleViewObj.oldcate.length > 6){
				if (simpleViewObj.cate.substring(0,6) == simpleViewObj.oldcate.substring(0,6)){
					setSimpleViewMenuType(simpleViewObj);
				}
			}else{
				simpleViewObj.menu = 1;
			}
		}else{
			if (simpleViewObj.menu != 1){
				setSimpleViewMenuType(simpleViewObj);
			}
		}
	},1000);
	function setSimpleViewMenuType(simpleViewObj){
		var varSivTargetObj = simpleViewObj.frmObj.contentWindow.document.getElementById("menu"+simpleViewObj.menu);
		if ( varSivTargetObj && varSivTargetObj.style.display != "none"){
			if(window.document.createEvent){
				var evt = simpleViewObj.frmObj.contentWindow.document.createEvent('HTMLEvents');
				evt.initEvent("click", true, false);
				varSivTargetObj.dispatchEvent(evt);
			}else if(varSivTargetObj.fireEvent){
				varSivTargetObj.fireEvent("onclick");
			}
		}else{
			simpleViewObj.menu = 1;
		}
	}
	if(top.location.pathname.indexOf("view/Listmp3.jsp")>=0){
		insertLog(14952);
	}else if(top.location.pathname.indexOf("search/Searchlist.jsp")>=0){
		insertLog(14954);
	}
}

function hideSimpleView(){
	var simpleViewObj = new SimpleView();
	simpleViewObj.hide();
	if (simpleViewObj.isBanner){
		clearTimeout(timerSvBanner);
	}
	if(document.URL.indexOf("/search/Searchlist.jsp") >= 0){
		document.getElementById("searchListFrame").contentWindow.clearTimerSvModel();
	}else{
		if (typeof (document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.clearTimerSvModel) == "function"){
			document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.clearTimerSvModel();
		}
		if (typeof (document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.unDoSimpleView) == "function"){
			document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.unDoSimpleView();
		}

	}
	/*
	if (!this.fixWidth && document.URL.indexOf("/search/Searchlist.jsp") < 0){
		document.getElementById("wrap").style.width = "83%";
	}
	*/
	if (document.getElementById("simple_blank")){
		document.getElementById("simple_blank").style.display = "none";
	}
	hideRecentZzim();
	changeRecentZzim(1);
	setAsideLeftPosition();

	//화장품 레이어 숨김
	if (document.getElementById("div_component_data_info")){
		document.getElementById("div_component_data_info").style.display = "none";
	}
}
SimpleView.prototype.load = function(){
	this.position();
	this.showFilter();
	if (this.type == "m"){
		this.frmObj.src = "/toolbar/index.jsp?modelno="+this.modelno+"&frm=list";
	}else if (this.type == "r"){
			this.frmObj.src = "/toolbar/index.jsp?modelno="+this.modelno+"&frm=list&srv=rental";
	}else if(this.type == "s"){
		this.frmObj.src = "/sim/index.jsp?modelno="+this.modelno+"&frm=list";
	}
	this.setHeight();
	resizeAll();

}
SimpleView.prototype.show = function(){
	//this.divObj.style.display = "";
	//this.blankObj.style.display = "";
	this.divObj.className = "";
	this.blankObj.className = "";
	this.viewState = true;


}
SimpleView.prototype.hide = function(){
	this.divObj.className = "_hideClass";
	this.blankObj.className = "_hideClass";
	if (this.shareObj.className != "_hideClass"){
		hideShareMenu();
	}
	if (this.mailObj.className != "_hideClass"){
		hideShareMail();
	}
	this.viewState = false;
}
SimpleView.prototype.position = function(){
	/*
	if (!this.fixWidth){
		document.getElementById("wrap").style.width = "74%";
		var varWidth = getBodyClientWidth();
		if (varWidth >= 1200 && varWidth <= 1300){
			var varCusWidth = varWidth - 6 - 290;
			document.getElementById("wrap").style.width = varCusWidth+"px";
		}
	}
	*/
	this.setLeft();
	this.divObj.style.top = "30px";
	this.blankObj.style.top = "30px";
	this.shareObj.style.top = "120px";
	this.mailObj.style.top = "135px";
}
SimpleView.prototype.showFilter = function(){
	this.filterObj.className = "";
	this.filterObj.getElementsByTagName("img")[0].style.display="";
}
SimpleView.prototype.hideFilter = function(){
	this.filterObj.className = "_hideClass";
}
SimpleView.prototype.setLeft = function(){
	var varLeftPos = 0;
	/*
	if (screen.width >= 1024 && screen.width < 1280){
		varLeftPos = 856;
	}else{
		varLeftPos = 1006;
	}
	if (document.getElementById("wrap")){
		varLeftPos = document.getElementById("wrap").offsetWidth + 5;
		if(!(BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6) && !(BrowserDetect.OS == "iPad" && BrowserDetect.browser == "Safari")) {
			varLeftPos = varLeftPos - getBodyScrollLeft();
		}
	}
	*/
	varLeftPos = $(".enuriBi").width()+5-getBodyScrollLeft();
	this.divObj.style.left = varLeftPos+"px";
	this.blankObj.style.left = (varLeftPos + 5)+"px";
	this.shareObj.style.left = (varLeftPos + 30)+"px";
	this.mailObj.style.left = (varLeftPos + 4)+"px";


}
SimpleView.prototype.setHeight = function(){
	var varBodyHeight = getBodyClientHeight();
	var varSpAddHeight = 0;
	if (this.isBanner){
		varSpAddHeight = 75;
	}
	this.frmObj.height = varBodyHeight-varSpAddHeight;
	this.filterObj.style.height = (varBodyHeight-varSpAddHeight)+"px";
}
SimpleView.prototype.makeUrl = function(){
	return "http://www.enuri.com/p/"+this.modelno;

}

function openShareMenu(){
	var simpleViewObj = new SimpleView();
	//simpleViewObj.showFilter();
	//simpleViewObj.filterObj.getElementsByTagName("img")[0].style.display="none";
	simpleViewObj.shareObj.className = "";
	simpleViewObj.modelnm = simpleViewObj.frmObj.contentWindow.document.getElementById("goodsName").innerHTML;

	if (document.getElementById("rb_recent_zzim")){
		if (document.getElementById("rb_recent_zzim").style.display != "none"){
			document.getElementById("rzFilter").style.height = document.getElementById("rb_recent_zzim").offsetHeight+"px";
			document.getElementById("rzFilter").className = "";
		}
	}
	if (!document.getElementById("zeroClicp")){
		var sc=document.createElement('script');
		sc.setAttribute('type','text/javascript');
		sc.setAttribute('id','zeroClicp');
		sc.setAttribute('src',''+'/common/js/zeroclipboard/ZeroClipboard_2010.js?'+(new Date()).getMilliseconds+'');
		document.body.appendChild(sc);
	}
	setTimeout(function(){
		var isIE = true;
		if(navigator.userAgent.indexOf("MSIE")<0 && (navigator.userAgent.indexOf("Gecko")>0 || navigator.userAgent.indexOf("Firefox")>0 || navigator.userAgent.indexOf("Netscape")>0)) {
			isIE = false;
		}
		if(!isIE){
			var clipStr = "<a href='"+simpleViewObj.makeUrl()+"' target='_blank'><img src='http://img.enuri.info/images/view/get_info/link_img_120827.gif' align='absmiddle' border='0'></a>";
			initClipBoard('svs_copy_url',simpleViewObj.makeUrl(),"해당 상품의 URL이 복사되었습니다.");
			initClipBoard('svs_copy_html',clipStr,"HTML글 작성시 붙여넣으면 링크버튼이 생성됩니다.");
		}
	},500);
	if (document.getElementById("rb_recent_zzim").style.display != "none"){
		hideRecentZzim();
	}
}
function hideShareMenu(){
	var simpleViewObj = new SimpleView();
	//simpleViewObj.hideFilter();
	simpleViewObj.shareObj.className = "_hideClass";
	for (var i=0;i<simpleViewObj.clipBoards.length;i++){
		simpleViewObj.clipBoards[i].destroy();
	}
	if (document.getElementById("rb_recent_zzim")){
		if (document.getElementById("rb_recent_zzim").style.display != "none"){
			document.getElementById("rzFilter").className = "_hideClass";
		}
	}
}
function initClipBoard(btnid,clipstr,clipalert){
	var simpleViewObj = new SimpleView();
	var clipBoard = new ZeroClipboard.Client();
	//cursor hand type
	clipBoard.setHandCursor( true );
	//swf화일 경로 설정.
	ZeroClipboard.setMoviePath("/common/js/zeroclipboard/ZeroClipboard.swf");
	//버튼 활성화
	clipBoard.glue(btnid);
	//마우스 클릭시에 이벤트 발생. - 저장한다.
	clipBoard.addEventListener('mouseOver', function (client) {
		clipBoard.setText(clipstr);
	});
	//COPY완료시에 발생할 CALLBACK함수.
	clipBoard.addEventListener('complete', function (client) {
		alert(clipalert+"\n원하는 곳에 CTRL + V 를 해주세요!");
	});
	clipBoard.setFixed();
	simpleViewObj.clipBoards[simpleViewObj.clipBoards.length] = clipBoard;

}
function shareCmd(param){
	var simpleViewObj = new SimpleView();
	if (param == 1){ //주소복사
		var bResult = window.clipboardData.setData("Text",simpleViewObj.makeUrl());
		if (bResult){
			alert("해당 상품의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
		}
		insertLog(8439);
	}else if(param == 2){ //즐겨찾기
		if (window.sidebar){ // 파폭
			window.sidebar.addPanel("에누리▒"+simpleViewObj.modelnm, simpleViewObj.makeUrl(), "");
		}else if (document.all){ // IE
			try{
				window.external.AddFavorite(simpleViewObj.makeUrl(), "에누리▒"+simpleViewObj.modelnm);
			}catch(e){
				alert("이 브라우저에서는 즐겨찾기를 추가 할수 없습니다.")
			}
		}else if (navigator.appName=="Netscape") { //크롬
			alert("이 브라우저에서는 즐겨찾기를 추가 할수 없습니다.")
		}
		insertLog(8440);
	}else if(param == 3){ //링크
		var clipStr = "<a href='"+simpleViewObj.makeUrl()+"' target='_blank'><img src='http://img.enuri.info/images/view/get_info/link_img_120827.gif' align='absmiddle' border='0'></a>";
		var bResult = window.clipboardData.setData("Text",clipStr);
		if (bResult){
			alert("HTML글 작성시 붙여넣으면 링크버튼이 생성됩니다..\n원하는 곳에 CTRL + V 를 해주세요!");
		}
	}else if(param == 4){ //메일
		hideShareMenu();
		openShareMail();
		insertLog(8441);
	}else if(param == 5){ //오류신고
		simpleViewObj.frmObj.contentWindow.toggleSingoButton();
		hideShareMenu();
	}else if(param == 6){ //인쇄
		hideShareMenu();
		openSharePrint();
	}
}
function openShareMail(){
	var simpleViewObj = new SimpleView();
	//simpleViewObj.showFilter();
	//simpleViewObj.filterObj.getElementsByTagName("img")[0].style.display="none";
	simpleViewObj.mailObj.className = "";
	//document.getElementById("mailModelName").innerHTML = simpleViewObj.modelnm;
	document.sendMailForm.modelno.value = simpleViewObj.modelno;
	document.sendMailForm.subject.value = "[에누리] " + simpleViewObj.modelnm + " 상품 가격비교";
	document.getElementById("mailBodyNone").style.display = "";
	document.getElementById("mailBody").style.display = "none";
	reloadCaptchaImgUrl();
}
function hideShareMail(){
	var simpleViewObj = new SimpleView();
	//simpleViewObj.hideFilter();
	simpleViewObj.mailObj.className = "_hideClass";
	var formObj = document.sendMailForm;
	formObj.reset();
	hideMoreReceiver(2);
	hideMoreReceiver(3);
}
function openSharePrint(){
	var simpleViewObj = new SimpleView();
	var sdulWin = window.open("/view/DetailmultiPrint.jsp?modelno="+simpleViewObj.modelno,"","width=740,height=900,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no,top=100,left=100");
	sdulWin.focus();
}
function reloadCaptchaImgUrl() {
	var dateLong = (new Date()).getTime();
	var url = "/mailer/Mailsend_Getpassimage.jsp";
	var param = "dateLong="+dateLong;
	/*
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:changeImage
		}
	);
	*/
	commonAjaxRequest(url,param,changeImage);
	function changeImage(originalRequest){
		if (libType() == "PR"){
   	 		var tempResponse = originalRequest.responseText;
    	}else{
       		var tempResponse = originalRequest;
   		}
		document.getElementById("captchaImg").src = var_img_enuri_com + "/images/mailing/mailimage/"+tempResponse;
		document.sendMailForm.passImgName.value = tempResponse;
	}
}
function viewMoreReceiver(){
	if (document.getElementById("moreReceiver2").className == "_hideClass"){
		document.getElementById("moreReceiver2").className = "moreReceiver";
		return;
	}
	if (document.getElementById("moreReceiver3").className == "_hideClass"){
		document.getElementById("moreReceiver3").className = "moreReceiver";
		return;
	}
}
function hideMoreReceiver(cnt){
	document.getElementById("moreReceiver"+cnt).className = "_hideClass";
}
//추가입력항목 보이기/접기
function mailBodyToggle(){
	var obj_none = document.getElementById("mailBodyNone");
	var obj_body = document.getElementById("mailBody");
	if(obj_body.style.display=="block"){
		obj_none.style.display = "block";
		obj_body.style.display = "none";
	}else{
		obj_none.style.display = "none";
		obj_body.style.display = "block";
	}
}
function formSubmit() {
	var formObj = document.sendMailForm;
	// 메일주소를 ;로 배열을 만듬
	var to_emailAry = null;
	var toMailNum = 1;
	if (document.getElementById("moreReceiver2").className == "moreReceiver"){
		toMailNum++;
	}
	if (document.getElementById("moreReceiver3").className == "moreReceiver"){
		toMailNum++;
	}

	if(toMailNum==1) to_emailAry = new Array("");
	if(toMailNum==2) to_emailAry = new Array("","");
	if(toMailNum==3) to_emailAry = new Array("","","");
	// 실제로 메일 주소가 들어간 개수를 체크, 3개까지만 유효
	var mailRealToNum = 0;
	if(toMailNum>=1) to_emailAry[0] = formObj.receiverMail1.value;
	if(toMailNum>=2) to_emailAry[2] = formObj.receiverMail2.value;
	if(toMailNum>=3) to_emailAry[3] = formObj.receiverMail3.value;
	for(var i=0; i<to_emailAry.length; i++) {
		if(to_emailAry[i].length>0) mailRealToNum = mailRealToNum + 1;
	}

	if(toMailNum>=1) if(!mailCheck(formObj.receiverMail1)) return;
	if(toMailNum>=2) if(!mailCheck(formObj.receiverMail2)) return;
	if(toMailNum>=3) if(!mailCheck(formObj.receiverMail3)) return;

	if(!varCheckSubmitClickFlag) {
		if(formObj.receiverMail1.value!="메일주소") {
			formObj.to_email.value = formObj.receiverMail1.value;
		}
		if(toMailNum>=2 && formObj.receiverMail2.value!="메일주소(필수)") {
			formObj.to_email.value += ";"+formObj.receiverMail2.value;
		}
		if(toMailNum>=3 && formObj.receiverMail3.value!="메일주소(필수)") {
			formObj.to_email.value += ";"+formObj.receiverMail3.value;
		}
		if($.trim(formObj.to_email.value).length == 0) {
			alert("받는 사람 e-mail을 입력하세요!");
			formObj.receiverMail1.focus();
			return false;
		}
	}
	if(formObj.subjectTemp.value.length > 0) {
		formObj.subject.value = formObj.subjectTemp.value;
	}
	if(formObj.subject.value.length <= 0) {
		formObj.subject.value="에누리 추천메일입니다.";
	}
	if(formObj.from_name_temp.value=="발신자명") {
		formObj.from_name_temp.value = "";
	}
	formObj.subject.value = encodeURIComponent(formObj.subject.value);
	formObj.from_name.value = encodeURIComponent(formObj.from_name_temp.value);
	formObj.contents.value = encodeURIComponent(formObj.contents_temp.value);

	if (formObj.contents.value == encodeURIComponent(mailContentDefault)){
		formObj.contents.value = "";
	}
	var varCheckSubmitClickFlag = false;
	if (typeof(formSubmit._submitClickFlag) != "undefined"){
		if (formSubmit._submitClickFlag){
			varCheckSubmitClickFlag = true;
		}
	}

	if(!varCheckSubmitClickFlag) {
		formSubmit._submitClickFlag = true;
		formObj.submit();

	} else {
		alert("처리 중 입니다.");
	}
}
// 메일 체크하는 함수
function mailCheck(mailObj) {
	if(mailObj.value.length > 0 && mailObj.value!="메일주소") {
		if(mailObj.value.indexOf("@") <= 0) {
			alert("받는 사람의 올바른 e-mail을 입력하세요!");
			mailObj.focus();
			return false;
		} else if(mailObj.value.indexOf(".") <= 0) {
			alert("받는 사람의 올바른 e-mail을 입력하세요!");
			mailObj.focus();
			return false;
		}
		if(mailObj.value.split("@").length > 2) {
			alert("@는 한번만 사용하실수 있습니다!");
			mailObj.focus();
			return false;
		}
	}
	return true;
}

// 필수 입력 처리 하는 함수
function onBlurCheck(obj) {
	try {
		if(obj.value==obj.defaultValue || obj.value=="") {
			obj.value = obj.defaultValue;
			obj.style.color = "#676767";
		}
	} catch(e) {}
}

function onFocusCheck(obj) {
	if(obj.value==obj.defaultValue) {
		obj.value = "";
		obj.style.color = "#000000";
		obj.focus();
	}
}

//메일 내용에 대한 기본내용 세팅
var mailContentDefault = "본문";
function onBlurContentsCheck(obj) {
	if(obj.value==mailContentDefault || obj.value=="") {
		obj.value = mailContentDefault;
		obj.style.color = "#676767";
	}
}
function onFocusContentsCheck(obj) {
	if(obj.value==mailContentDefault) {
		obj.value = "";
		obj.style.color = "#000000";
	}
}
// 왼쪽 숫자 필수 입력 처리 하는 함수
function onBlurCheckPass(obj) {
	if(obj.value==obj.defaultValue || obj.value=="") {
		obj.value = obj.defaultValue;
		obj.style.color = "#676767";
	}
}

function onFocusCheckPass(obj) {
	if(obj.value==obj.defaultValue) {
		obj.value = "";
		obj.style.color = "#000000";
	}
}

// 메일 취소
function mailCancel() {
	if(history.length>0 && top.opener=="[object]") {
		history.back();
	} else {
		top.close();
	}
}
// 숫자이외의 문자 막기
function onlyNumber() {
	if(event.keyCode<48 || event.keyCode>57) {
		event.returnValue = false;
	}
}
function setMeMail(obj) {
	var formObj = document.mailSendLayerFrm;
	if(obj.checked==true) {
		if(formObj.to_email.value.length>0 && formObj.from_email.value.length>0) {
			formObj.to_email.value = formObj.from_email.value;
		}
		if(formObj.to_email.value.length>0 && formObj.from_email.value.length==0) {
			if(formObj.to_email.value!=formObj.to_email.defaultValue) formObj.from_email.value = formObj.to_email.value;
		}
		if(formObj.to_email.value.length==0 && formObj.from_email.value.length>0) {
			formObj.to_email.value = formObj.from_email.value;
		}
	}
}
// 비로그인에서 이미지 확인 숫자를 잘못 입력했을 경우처리하는 함수
function focusImgText() {
	document.sendMailForm.imgPassText.value = "";
	document.sendMailForm.imgPassText.focus();
	formSubmit._submitClickFlag = false;
}
// 메일 보내기가 완료 되었을 경우 form을 리셋하고 창을 닫음
function mailLayerResetClose() {
	hideShareMail();
	formSubmit._submitClickFlag = false;
}
function goSimpleSnsLink(type) {
	var simpleViewObj = new SimpleView();
	if(simpleViewObj.modelnm.length>0) {
		var content1 = encodeURIComponent(simpleViewObj.modelnm.replace(/"/g,""));
		var url1 = encodeURIComponent(simpleViewObj.makeUrl());
		// 트위터
		if(type==1) {
			window.open("http://twitter.com/intent/tweet?text="+content1+"&url="+url1, "_new");
			insertLog(8442);
		}
		// 페이스북
		if(type==2) {
			window.open("http://www.facebook.com/sharer.php?u="+url1+"&t="+content1+"");
			insertLog(8443);
		}
		// 미투데이
		if(type==3) {
			window.open("http://me2day.net/posts/new?new_post[body]="+content1+" "+url1);
			insertLog(8444);
		}
	}
}
function simpleViewPreProcess(modelno,popular,cate) {
	var dateLong = (new Date()).getTime();
	var url = "/include/ajax/AjaxSimpleviewPreProcess.jsp";
	var param = "modelno="+modelno+"&porder="+popular+"&cate="+cate;
	/*
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:reCountRecent
		}
	);
	*/
	commonAjaxRequest(url,param,reCountRecent);
	function reCountRecent(originalRequest){
		if (libType() == "PR"){
   	 		var tempResponse = originalRequest.responseText;
    	}else{
       		var tempResponse = originalRequest;
   		}
		document.getElementById("mytoday_cnt").innerHTML = "("+$.trim(tempResponse)+")";
	}
}
function clickSimpleViewRecentZzimGoods(id){
	/**
	var svRzGoods = $("#rb_recent_zzim .sv_rz_goods_sel");
	for (var i=0;i<svRzGoods.length;i++){
		$(svRzGoods[i]).attr("class","sv_rz_goods");
	}
	document.getElementById("sv_rz_goods_"+id).className = "sv_rz_goods_sel";
	*/
}
function setSimpleViewCate(menu){
	var simpleViewObj = new SimpleView();
	simpleViewObj.menu = menu;
}