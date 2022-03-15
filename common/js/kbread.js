// 브라우져 정보 읽어오기
function getBrowserName() {
	if(navigator.userAgent.toLowerCase().indexOf("msie 6")>-1 && navigator.userAgent.toLowerCase().indexOf("msie 7")==-1 
		&& navigator.userAgent.toLowerCase().indexOf("msie 8")==-1) {
		return "msie6";
	}
	if(navigator.userAgent.toLowerCase().indexOf("msie 7")>-1 && navigator.userAgent.toLowerCase().indexOf("msie 8")==-1) {
		return "msie7";
	}
	if(navigator.userAgent.toLowerCase().indexOf("msie")!=-1) {
		return "msie";
	}
	if(navigator.userAgent.toLowerCase().indexOf("firefox")>-1) {
		return "firefox";
	}
	if(navigator.userAgent.toLowerCase().indexOf("opera")>-1) {
		return "opera";
	}
	if(navigator.userAgent.toLowerCase().indexOf("chrome")>-1) {
		return "chrome";
	}
}
var borwserName = getBrowserName();
function getKbreadBodyHeight(){
	if(document.getElementById("kbread_body"))
		return document.getElementById("kbread_body").offsetHeight;
	else
		return 0;
}
function docResize() {
	try{
		cmdHideMyMenu();
		cmdHideMemMenu();
	}catch(e){}
	parent.kbReadResize();
}
function ebListResize(){
	if (top.document.getElementById("body")){
		top.document.getElementById("body").scrollIntoView(true);
	}
	docResize();
}
function kbReadResize() {
	var oFrame = document.getElementById("ifBodyRead_guide");
	if(oFrame.src){
		var sh = oFrame.contentWindow.getBodyScrollHeight();
		oFrame.height = sh;
		if(BrowserDetect.browser=="Safari"){
			oFrame.style.height = sh+"px";
		}
		var sh_r = oFrame.contentWindow.getKbreadBodyHeight();
		oFrame.height = sh_r;
		if(BrowserDetect.browser=="Safari"){
			oFrame.style.height = sh_r+"px";
		}
		docResize();
	}
}
function kbReadListResize() {
	var oFrame = document.getElementById("ifKbList");
	if(oFrame.src){
		var sh = oFrame.contentWindow.getBodyScrollHeight();
		oFrame.height = sh;
		if(BrowserDetect.browser=="Safari"){
			oFrame.style.height = sh+"px";
		}
		var sh_r = oFrame.contentWindow.getKbreadBodyHeight();
		oFrame.height = sh_r;
		if(BrowserDetect.browser=="Safari"){
			oFrame.style.height = sh_r+"px";
		}
		docResize();
	}
}
function logInsert(param){
	insertLog(param);
}
function CmdGetInfo(mode){
	var sTitle = "에누리 지식통";
	if(top.location.href.indexOf("/blog/")>0){ //블로그
		sTitle = "에누리 기자 블로그";
	}
	if(mode==0){ //즐겨찾기
		if(top.location.href.indexOf("/blog/")>0){ //블로그
			insertLog(6277);
		}else{
			insertLog(5714);
		}
		if (window.sidebar){ // 파폭
			window.sidebar.addPanel(sTitle, clipStr2, "");
		}else if (document.all){ // IE
			window.external.AddFavorite(clipStr2, sTitle);
		}else if (navigator.appName=="Netscape") { //크롬
			alert("확인을 누르시고 <Ctrl-D>를 사용하여 이 페이지를 즐겨찾기 하세요.");
		}
	}else if(mode==1){ //링크걸기
		if(top.location.href.indexOf("/blog/")>0){ //블로그
			insertLog(6275);
		}else{
			insertLog(5712);
		}
		copy_LINK(clipStr1,"knowbox");
	}else{ //URL복사
		if(top.location.href.indexOf("/blog/")>0){ //블로그
			insertLog(6276);
		}else{
			insertLog(5713);
		}
		copy_URL(clipStr2,"knowbox");
	}
}
function CmdInsert_MySave(){ //저장하기
	if(top.location.href.indexOf("/blog/")>0){ //블로그
		insertLog(6278);
	}else{
		insertLog(5715);
	}
	if(islogin()){
		var ww = 406;
		var wh = 250;
		var wl = (window.screen.width-500)/2;
		var wt = (window.screen.height)/2
		var wins = window.showModalDialog('/knowbox/Kbmysave.jsp?from='+strFrom+'&kbno='+iKbno, window, 'dialogWidth:'+ww+'px; dialogHeight:'+wh+'px; center:yes; resizable:no;help:No;status:No;scroll:no');
	}else{
		if(top.location.href.indexOf("/blog/")>0){ //블로그
			setLogintopAfterurl("/knowbox/List_read.jsp?from=blog&kbno="+iKbno+"&exe_cmdinsert_mysave=true");
		}else{
			setLogintopAfterurl("/knowbox/List_read.jsp?kbno="+iKbno+"&exe_cmdinsert_mysave=true");
		}
		Cmd_Login('redirect');
	}
}
function CmdKbPrint(){ //인쇄하기
	if(top.location.href.indexOf("/blog/")>0){ //블로그
		insertLog(6279);
	}else{
		insertLog(5716);
	}
	SLB_show('/knowbox/Kbreadprint_2010.jsp?kbno='+iKbno+'&zoom=85','iframe');
}
function cmdKbSingo(kbno,parentno,writer){ //삭제신고
	if(top.location.href.indexOf("/blog/")>0){ //블로그
		insertLog(6280);
	}else{
	}
	if(typeof(kbno)=="undefined") kbno = 0;
	if(typeof(parentno)=="undefined") parentno = 0;
	if(typeof(writer)=="undefined") writer = "";
	
	if(document.getElementById("div_singo")){
		if(document.getElementById("div_singo").style.display=="block" && document.getElementById("singo_kbno").value==kbno){
			document.getElementById("div_singo").style.display = "none";
		}else{
			document.getElementById("singo_kbno").value = kbno;
			document.getElementById("singo_parentno").value = parentno;
			if(parentno==0){ //원글신고
				insertLog(5717);
				document.getElementById("div_singo").style.left = "415px";
				document.getElementById("div_singo").style.top = "20px";
				document.getElementById("singo_kbwriter").style.height = "14px";
				document.getElementById("singo_kbwriter").innerHTML = "<strong>"+writer+"</strong>님의 글을 삭제/이동 요청합니다.";
				document.getElementById("div_singo_opt").style.display = "block";
			}else{ //댓글신고
				insertLog(5746);
				document.getElementById("div_singo").style.left = (parseInt(Position.cumulativeOffset($("btn_singo_"+kbno))[0],10)-100)+"px";
				document.getElementById("div_singo").style.top = (parseInt(Position.cumulativeOffset($("btn_singo_"+kbno))[1],10)-20)+"px";
				document.getElementById("singo_kbwriter").style.height = "14px";
				document.getElementById("singo_kbwriter").innerHTML = "<strong>"+writer+"</strong>님의 글을 삭제 요청합니다.";
				document.getElementById("div_singo_opt").style.display = "none";
			}
			document.getElementById("div_singo").style.display = "block";
		}
	}
}
function cmdKbSingoProc(){ //삭제신고저장
	var kbno = document.getElementById("singo_kbno").value;
	var parentno = document.getElementById("singo_parentno").value;
	if (document.getElementById("singo_txt").value.trim().length == 0 ){
		alert("오류내용을 입력해 주십시오.");
		document.getElementById("singo_txt").focus();
		return;
	}
	if (document.getElementById("singo_txt").value.trim().korlen() > 500){
		alert("500자 이상 입력하실수 없습니다.")
		document.getElementById("singo_txt").focus();
		return;		
	}
	if (document.getElementById("singo_email").value.trim().length > 0 ){
		if (!document.getElementById("singo_email").value.trim().isemail()){
			alert("올바른 E-Mail주소를 입력해 주십시오.");
			document.getElementById("singo_email").focus();
			return;
		}
	}
	var opt = "";
	if(parentno==0){
		if(document.getElementById("singo_opt_d").checked){
			opt = document.getElementById("singo_opt_d").value;
		}else{
			opt = document.getElementById("singo_opt_m").value;
		}
	}else{
		opt = "del";
	}
	function showSaveMsg(originalRequest){
		alert(originalRequest.responseText.replace(/(^\s*)|(\s*$)/gi, ""));/* 2013.04.05 박미현 과장 요청*/
		
		document.getElementById("singo_txt").value="";
		checkBackground(document.getElementById("singo_txt"));
		document.getElementById("singo_email").value="";
		checkBackground(document.getElementById("singo_email"));
		document.getElementById("div_singo").style.display = "none";
	}
	var url = "/knowbox/Kb_singo.jsp";
	var param = "opt="+opt+"&kbno="+kbno+"&singo_txt="+encodeURIComponent(document.getElementById("singo_txt").value.trim())+"&singo_email="+document.getElementById("singo_email").value;
	var getRec = new Ajax.Request(
		url,
		{
			method:'post',parameters:param,onComplete:showSaveMsg
		}
	);		
}
var reply_kbno = 0; //댓글에 댓글쓰기 클릭 위치
function CmdReplyToReplyCancel(){ //댓글에 댓글쓰기 박스 삭제
	if(reply_kbno>0 && document.getElementById("reply_to_"+reply_kbno)){
		CmdCancelReplyToReply(reply_kbno);
	}
}
function CmdFocusContentBox(pkbno){
	setReflySession();
	document.getElementById("reply_reply_input_msg"+pkbno).innerHTML = "";
	var obj = eval("document.frmRepWKnowBox"+pkbno);
	obj.content.focus();
}
function CmdReplyToReply(pkbno,pnm,gkbno){ //댓글에 댓글버튼 클릭
	if(document.getElementById("reply_reply_box") && document.getElementById("reply_to_"+pkbno)){
		document.getElementById("reply_reply_input_msg_p_kbno_").innerHTML = pnm+"님께 답글달기";
		var shtml = document.getElementById("reply_reply_box").innerHTML;
		shtml = shtml.replace("_p_kbno_",pkbno);
		shtml = shtml.replace("_p_kbno_",pkbno);
		shtml = shtml.replace("_p_kbno_",pkbno);
		shtml = shtml.replace("_p_kbno_",pkbno);
		shtml = shtml.replace("_p_kbno_",pkbno);
		shtml = shtml.replace("_p_kbno_",pkbno);
		shtml = shtml.replace("_g_kbno_",gkbno);
		document.getElementById("reply_to_"+pkbno).innerHTML = shtml;
if(document.getElementById("reply_to_"+pkbno).getElementsByTagName('dd')[0]){		
		var obj = document.createElement('input');
		obj.type 		= 'text';
		obj.name 		= 'loginid';
		obj.id 			= 'loginid2';
		obj.maxLength 	= '16';
		obj.tabIndex 	= '11';
		obj.className 	= 'gbwrite2_input_id';
		obj.onFocus = function() {
			InputLoginId(this);
		}
		
		obj.onBlur = function () {
			OutLoginId(this);
		}
		document.getElementById("reply_to_"+pkbno).getElementsByTagName('dd')[0].appendChild(obj);
}
		document.getElementById("btn_reply_reply_"+pkbno).style.display = "none";
		document.getElementById("btn_reply_reply_cancel_"+pkbno).style.display = "inline";
		
		CmdReplyToReplyCancel(); //다른 댓글에 댓글쓰기 버튼 클릭한 상태일때 이전 박스 없애고 생성
		reply_kbno = pkbno;
		docResize();
	}
}
function CmdCancelReplyToReply(pkbno){ //댓글에 댓글 취소버튼 클릭
	document.getElementById("reply_to_"+pkbno).innerHTML = "";
	document.getElementById("btn_reply_reply_"+pkbno).style.display = "inline";
	document.getElementById("btn_reply_reply_cancel_"+pkbno).style.display = "none";
	reply_kbno = 0;
	docResize();
}
function checkBackground(obj){
	if (obj.value.trim().length == 0 ){
		if (obj.id == "singo_txt"){
			obj.style.backgroundImage = "url("+var_img_enuri_com+"/images/knowbox/2011/error_webFont01_new.gif)";
		}else{
			obj.style.backgroundImage = "url("+var_img_enuri_com+"/images/knowbox/2011/error_webFont02_new.gif)";
		}
	}
}	
function cmdContentsImgResize(){ //본문이미지가 리사이즈 안되는 경우 대비
	var arrObj = document.getElementsByName("kb_content_img");
	if(arrObj && arrObj.length>0){
		for(i=0; i<arrObj.length; i++){
			LimitImgSize(arrObj[i],1);
		}
	}
	docResize();
}
//지식통 이미지 원문에 삽입된 이미지 사이즈 제한
function LimitImgSize(objImg, errCode){
	try{
		if(errCode){
			resizeImg(objImg);
		}else{
			if(typeof(objImg)=="object"){
				objImg.style.display="none";
			}else{
				$(objImg).style.display="none";
			}
		}
		docResize();
	}catch(e){}
}
function resizeImg(objImg){
	if(typeof(objImg)=="object"){
		objImg.realWidth = objImg.width;
		objImg.realHeight = objImg.height;
		if(objImg.width>400){ //ie7버그, 이미지가 옆으로 붙어 너비가 길어짐
			objImg.style.display = "block";		
		}
		if(objImg.width>730){
			objImg.width = 730;
		}else if(objImg.width==0){

		}
	}else{
		$(objImg).realWidth = $(objImg).width;
		$(objImg).realHeight = $(objImg).height;
		if($(objImg).width>400){ //ie7버그, 이미지가 옆으로 붙어 너비가 길어짐
			$(objImg).style.display = "block";
		}
		if($(objImg).width > 730){
			$(objImg).width = 730;
		}else if($(objImg).width==0){

		}
	}
	docResize();
}
function GoNextPage(pageNo){
	if(document.getElementById("reply_write_title")){
		document.getElementById("reply_write_title").scrollIntoView(true);
	}
	var obj = document.fmKBListSelf;
	obj.rpage.value = pageNo;
	obj.submit();
}
function gopage(value){
	GoNextPage(value);
}
function thisReload(){
	location.reload();
}
function CmdDetail(modelno){
	//OpenWindow('/view/Detailmulti.jsp?fb=1&modelno='+modelno,'detailMultiWin','804',window.screen.height,'YES','YES');
	//vip 개편작업
	detailView(modelno);
}
function CmdDetailBbs(modelno){
	//OpenWindow('/view/Detailmulti.jsp?fb=1&modelno='+modelno,'detailMultiWin','800','800','YES','YES');
	//vip 개편작업
	detailView(modelno);
}
function CmdDetailBigImg(modelno){
	OpenWindow('/view/include/BigImageOnlyPopup.jsp?modelno='+modelno,'detailMultiWin','800','800','YES','YES');
}

function detailView(modelno){
	var detailWin = window.open("/_pre_detail_.jsp");
	detailWin.location.replace("/detail.jsp?fb=1&modelno="+modelno);
	detailWin.focus();
}
function cmdAfterPhoneSaleMod(kbno,pout,nick){
	parent.cmdListSetPhoneOut(kbno,pout,nick);
	location.replace("List_read.jsp?kbno="+kbno);
}
function CmdAfterKbWrite(){
	var tempEmail = "";
	try {
		tempEmail = document.frmWKnowBox.interest_email.value;
	} catch(e) {
	}
	document.frmWKnowBox.reset();
	try {
		document.frmWKnowBox.interest_email.value = tempEmail;
	} catch(e) {
	}
	CmdReloadReplyList();
	isKbWriteProgress = 0;
	reply_kbno = 0;
	try{
		cmdHideMyMenu();
		cmdHideMemMenu();
	}catch(e){}
}
function showReplyList(originalRequest){
	var rList = originalRequest.responseText;
	$('spReplyList').innerHTML = rList;
	docResize();
}
function CmdReloadReplyList(){
	location.reload();
	//var url = "/knowbox/List_readReplyList.jsp";
	//var param = "kbno="+iKbno+"&page="+document.fmKBListSelf.page.value;
	//var getHitProd = new Ajax.Request(
	//	url,
	//	{
	//		method:'get',parameters:param,onComplete:showReplyList
	//	}
	//);
}
function Cmd_Submit2(){
	var obj = document.frmWAnswerModify;
	if(obj.replykbno.value.trim()==""){
		alert("원글정보가 없습니다.");
		top.loation.reload();
		return;
	}
	if(obj.content.defaultValue==obj.content.value && (!obj.relurl || (obj.relurl && obj.relurl.defaultValue==obj.relurl.value))){
		location.href = "?kbno="+iKbno;
		return;
	}
	if(obj.content.value.trim()==""){
		alert("내용을 입력하세요."); 
		return;
	}
	obj.submit();
}
function CmdAfterKbRepMod(){
	if(top.location.href.indexOf("/blog/")>0){ //블로그
		location.replace("/knowbox/List_read.jsp?from=blog&kbno="+iKbno);
	}else{
		location.replace("/knowbox/List_read.jsp?kbno="+iKbno);
	}
}
function inputFlash(vId, vUri, vWidth, vHeight, vWmode, vFlashVar, vBorder) {
	if(typeof(vBorder)=="undefined") vBorder = 0;
	var str = "";
	str = '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="' + vWidth + '" height="' + vHeight + '" id="' + vId + '" align="left" style="border:' + vBorder + 'px solid gray">';
	str += '<param name="allowScriptAccess" value="always" />';
	str += '<param name="allowFullScreen" value="false" />';
	str += '<param name="quality" value="high" />';
	str += '<param name="wmode" value="' + vWmode + '" />';
	str += '<param name="bgcolor" value="#ffffff" />';
	str += '<param name="movie" value="' + vUri + '" />';
	str += '<param name="FlashVars" value="' + vFlashVar + '" />';
	str += '<embed src="' + vUri + '" quality="high" wmode="' + vWmode + '" bgcolor="#ffffff" width="' + vWidth +'" height="' + vHeight + '" id="' + vId + '" name="' + vId + '" align="left" swLiveConnect=true allowScriptAccess="always" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" /></embed>';
	str += '</object>';
	document.writeln(str);
}
//복사시 출처붙이기
function cmdKbContentsCopy(){
	if(window.event.srcElement.id == 'taContent') return;
	
	if(window.event){
		window.event.returnValue = true;
		window.setTimeout('cmdKbContentsAddEnuri()', 30);
	}
}
function cmdKbContentsAddEnuri(){
	if (window.clipboardData){
		var txt = window.clipboardData.getData('Text');
		var in_txt = "<무단복제 엄금 -출처: 에누리닷컴>";
		if(txt.indexOf(in_txt)<0){
			txt = txt + '\r\n<무단복제 엄금 -출처: 에누리닷컴>\r\n';
		}
		var result = window.clipboardData.setData('Text', txt);
	}
}
function OpenWindowYes(OpenFile,winname,nWidth,nHeight){
	var newWin = window.open(OpenFile,winname,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
	newWin.focus();
}
function OpenWindowNo(OpenFile,winname,nWidth,nHeight){
	var newWin = window.open(OpenFile,winname,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars=no,resizable=no,menubar=no");
	newWin.focus();
}
function OpenWindow(OpenFile,name,nWidth,nHeight,ScrollYesNo,ResizeYesNo){
	var newWin = window.open(OpenFile,name,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar=no,left=0,top=0");
	newWin.focus();
}
function OpenNewWin(url){
	var newWin = window.open(url);
	newWin.focus();
}
function CmdModify(ikbno){
	var obj = document.fmKbWinfo;
	if(top.location.href.indexOf("/blog/")>0){ //블로그
		var win = window.open("/knowbox/List.jsp?kbno="+ikbno);
		win.focus();
	}else{
		var surl = top.document.URL;
		if(surl.indexOf("knowbox")>0){ 
			obj.kbno.value = ikbno;
			obj.action = "List_modify.jsp";
			obj.target = "";
			obj.submit();
		}else{
			if(islogin()){
				//if(surl.indexOf("knowbox")<0){ //상품창
					if(parent.$("goodsBBSNewsTable")) parent.$("goodsBBSNewsTable").style.display = "none";
				//}
				obj.kbno.value = ikbno;
				obj.action = "List_modify.jsp";
				obj.target = "";
				obj.submit();
			}else{
				setLogintopAfterurl("/knowbox/List_modify.jsp?kbno="+ikbno+"&from="+obj.from.value);
				Cmd_Login('redirect');
			}		
		}
	}
}


function OutLoginPass(obj){
	if(obj.value==""){
		obj.style.background = "#ffffff url(<%=ConfigManager.IMG_ENURI_COM%>/images/knowbox/goodboard/tx_02.gif) no-repeat 1px 3px";
	}
}
var layerikbno = 0;
function CmdListDelete(ikbno){
	var formObj = document.frmWKnowBox;
	formObj.reset();
	OutLoginPass(formObj.del_pass);
	layerikbno = ikbno;
	closeAllInfo();
	showInfo(6);
}
function CmdDelete(ikbno){
	insertLog(5765);
	if(confirm("해당 글을 삭제하시겠습니까?")){
		function afterDel(){
			if(ikbno==iKbno){ //원글삭제
				var surl = top.document.URL;
				if(surl.indexOf("knowbox")<0){ //상품창 or 블록
					parent.location.reload();
					try {
						top.setKbNumShow(-1);
					} catch(e) {}
				}else{
					surl = surl.substring(0,surl.indexOf(".jsp")+4);
					surl += "?kbcate=" + top.document.getElementById("frmKbList").kbcate.value;
					if(top.document.getElementById("frmKbList").kbcode.value == "kc8" || top.document.getElementById("frmKbList").kbcode.value == "kc9"){
						if(top.document.getElementById("frmKbList").iskc9flag.value == "true"){ 
							surl += "&kbcode=kc9";
					}else{
							surl += "&kbcode=kc8";
						}
					}else{
						surl += "&kbcode=" + top.document.getElementById("frmKbList").kbcode.value;
					}
					surl += "&smart_tap_menu=" + top.document.getElementById("frmKbList").smart_tap_menu.value;
					top.location.replace(surl);
				}
			}else{ //댓글삭제
				thisReload();
			}
		};
		var url = "/knowbox/Kb_singo.jsp";
		var param = "opt=deldir&kbno="+ikbno;
		var getRec = new Ajax.Request(
			url,
			{
				method:'post',parameters:param,onComplete:afterDel
			}
		);
	}
}
function CmdPhoneOut(kbno,param){
	if(param=="1"){
		if(confirm("판매종료 상품으로 변경됩니다.")){
			document.getElementById("ifKbMod").src = "PhoneSale_proc.jsp?kbno="+kbno+"&phoneout="+param;
		}
	}else{
		if(confirm("판매종료를 해제합니다.")){
			document.getElementById("ifKbMod").src = "PhoneSale_proc.jsp?kbno="+kbno+"&phoneout="+param;
		}
	}
}
function cmdPsInputType(param){
	if(param=="1"){ //기본입력방식
		document.getElementById("kbw_ps_option").style.display = "block";
		if(document.getElementById("ps_option_list").innerHTML==""){
			cmdInputPsOption();
		}
		document.getElementById("ps_input_guidetxt_option").style.display = "block";
		document.getElementById("ps_input_guidetxt_html").style.display = "none";
	}else{
		document.getElementById("ps_option_list").innerHTML = "";
		document.getElementById("ps_option_idx").value = "";
		document.getElementById("kbw_ps_option").style.display = "none";
		document.getElementById("ps_input_guidetxt_option").style.display = "none";
		document.getElementById("ps_input_guidetxt_html").style.display = "block";
	}
	docResize();
}
function cmdChkEnuriModel(flg,param){
	if(flg){
		document.getElementById("box_ps_chk_enurimodel_exp_"+param).style.display = "none";
		document.getElementById("box_ps_chk_enurimodel_ins_"+param).style.display = "block";
	}else{
		document.getElementById("box_ps_chk_enurimodel_ins_"+param).style.display = "none"
		document.getElementById("box_ps_chk_enurimodel_exp_"+param).style.display = "block";
		//document.getElementById("relate_model_"+param).value = "";
	}
	
}
function cmdPsModelnmClear(obj){
	obj.style.background = "";
}
function cmdViewInfoFindModelno(){
	if(document.getElementById("img_findmodelno")){
		if(document.getElementById("img_findmodelno").style.display=="block"){
			document.getElementById("img_findmodelno").style.display = "none";
		}else{
			document.getElementById("img_findmodelno").style.display = "block";
		}
		docResize();
	}
}
function cmdViewPsLink(param){
	var obj = eval("document.frmWKnowBox.ps_link_url_"+param);
	if(obj.value==""){
		alert("링크주소를 입력하세요");
		return;
	}else{
		var newWin = window.open(obj.value);
		newWin.focus();
	}
}
function cmdInputPsOption(){ //기본정보박스 추가
	if(document.getElementById("ps_option_list") && document.getElementById("ps_option_html")){
		var ps_option_idx = document.getElementById("ps_option_idx").value;
		var newIdx = getNextPsIdx(ps_option_idx);
		
		var ps_option_html = document.getElementById("ps_option_html").innerHTML;
		var ps_chargeplan_html = document.getElementById("ps_chargeplan_html").innerHTML;
		
		document.getElementById("ps_option_idx").value = document.getElementById("ps_option_idx").value + "," + newIdx;
		ps_option_html = js_replace(ps_option_html, "$idx$", newIdx);
		
		document.getElementById("ps_option_list").insertAdjacentHTML("beforeEnd", ps_option_html);
		
		document.getElementById("ps_chargeplan_idx_"+newIdx).value = ",1";
		ps_chargeplan_html = js_replace(ps_chargeplan_html, "$idx$", newIdx);
		ps_chargeplan_html = js_replace(ps_chargeplan_html, "$cidx$", 1);
		
		document.getElementById("box_ps_chargeplan_"+newIdx).insertAdjacentHTML("beforeEnd", ps_chargeplan_html);
		docResize();
	}
}
function cmdDelPsOption(idx){ //기본정보박스 제거:1개 유지
	var obj = document.getElementById("ps_option_"+idx);
	var obj_cidx = document.getElementById("ps_chargeplan_idx_"+idx);
	if(obj && obj_cidx){
		cmdDelPsIdx(document.getElementById("ps_option_idx"),idx);
		obj.removeNode(true);
		obj_cidx.removeNode(true);
		if(document.getElementById("ps_option_idx").value==""){
			cmdInputPsOption();
		}
		docResize();
	}
}
function cmdAddChargePlan(idx){ //요금제 추가
	var cidx = document.getElementById("ps_chargeplan_idx_"+idx).value;
	var newIdx = getNextPsIdx(cidx);
	document.getElementById("ps_chargeplan_idx_"+idx).value = document.getElementById("ps_chargeplan_idx_"+idx).value + "," + newIdx;
	
	var ps_chargeplan_html = document.getElementById("ps_chargeplan_html").innerHTML;
	ps_chargeplan_html = js_replace(ps_chargeplan_html, "$idx$", idx);
	ps_chargeplan_html = js_replace(ps_chargeplan_html, "$cidx$", newIdx);
	document.getElementById("box_ps_chargeplan_"+idx).insertAdjacentHTML("beforeEnd", ps_chargeplan_html);
	docResize();
}
function cmdDelChargePlan(idx,cidx){ //요금제 제거:1개 유지
	var obj = document.getElementById("box_ps_chargeplan_"+idx+"_"+cidx);
	if(obj){
		cmdDelPsIdx(document.getElementById("ps_chargeplan_idx_"+idx),cidx);
		obj.removeNode(true);
		if(document.getElementById("ps_chargeplan_idx_"+idx).value==""){
			cmdAddChargePlan(idx);
		}
		docResize();
	}
}
function cmdPsChargeType(param,idx){ //요금제 선택 : 자유, 지정(요금제별 월청구액 입력)
	if(param=="자유"){
		document.getElementById("box_ps_chargeplan_"+idx).innerHTML = "";
		document.getElementById("ps_chargeplan_box_"+idx).style.display = "none";
	}else{ //지정
		document.getElementById("ps_chargeplan_box_"+idx).style.display = "block";
		cmdAddChargePlan(idx);
	}
	docResize();
}
function getNextPsIdx(idx){
	var nextIdx = 0;
	if(idx!=""){
		idx = idx.substring(1);
		var arrIdx = idx.split(",");
		nextIdx = parseInt(arrIdx[arrIdx.length-1],10);
	}
	nextIdx++;
	return nextIdx;
}
function cmdDelPsIdx(obj,idx){
	if(obj){
		var sidx = obj.value;
		var newVal = "";
		if(sidx!=""){
			sidx = sidx.substring(1);
			var arrIdx = sidx.split(",");
			for(i=0;i<arrIdx.length;i++){
				if(parseInt(arrIdx[i],10)!=parseInt(idx,10)){
					newVal = newVal + "," + arrIdx[i];
				}
			}
			obj.value = newVal;
		}
	}
}
function isNumber(form) {
	if(event.keyCode != 13) {
		if((event.keyCode<48)||(event.keyCode>57)) {
			event.returnValue = false;
		}	
	}
}
function inputNumberOnly(obj, val) {
	new_val = "";
	obj.value = "";

	for(var i=0; i<val.length; i++) {
		char1 = val.substring(i,i+1);
		if(char1 >= '0' && char1 <= '9') {
			new_val = new_val + char1;
		}
	}
	obj.value = new_val;
}
function goLogin() {
	setLogintopAfterurl("/knowbox/List_read.jsp?kbno="+iKbno+"&exe_cmdmodifydel_check=true");
	Cmd_Login('redirect');
}
function CmdModifyReply(ireplykbno){
	var surl = "/knowbox/List_read.jsp?";
	if(top.location.href.indexOf("/blog/")>0){ //블로그
		surl += "from=blog&";
	}
	surl += "kbno="+iKbno+"&replykbno="+ ireplykbno;
	if(islogin()){
		location.href = surl;
	}else{
		setLogintopAfterurl(surl);
		Cmd_Login('redirect');
	}
}
function goLoginModifyReply(ireplykbno) {
	var surl = "/knowbox/List_read.jsp?";
	if(top.location.href.indexOf("/blog/")>0){ //블로그
		surl += "from=blog&";
	}
	surl += "kbno="+iKbno+"&replykbno="+ ireplykbno;
	setLogintopAfterurl(surl);
	Cmd_Login('redirect');
}
// 로그인하고 자기가 쓴 댓글을 삭제할 때
function CmdOwnerDelete(kbno) {
	if(confirm("작성하신 댓글이 완전히 삭제됩니다.\n정말로 삭제하시겠습니까?")) {
		var url = "/knowbox/Kbmovedel_Exe.jsp";
		var param = "kbno="+kbno+"&opt=delmyreply";
		document.getElementById("ifReplyWrite").src = url+"?"+param;
	}
}
// 이미지 클릭시 새창으로 원본 이미지 출력
function ViewKbBigImg(objImg){
	intWidth = eval(objImg.realWidth+20);
	intHeight = eval(objImg.realHeight+5);
	if(intWidth>800) intWidth = 800;
	if(intHeight>800) intHeight = 800;
	x = Math.ceil((screen.width-intWidth)/3);
    y = Math.ceil((screen.height-intHeight)/3);
	bigImgWin = window.open("","viewBigImg","width="+ intWidth +",height="+ intHeight +"status=no,menubar=no,copyhistory=no,scrollbars=yes,resizable=yes,left="+x+",top="+y); 
	bigImgWin.open;
		with(bigImgWin.document){
			writeln("<hmtl>");
			writeln("<head>");
			writeln("<script>");
			writeln("function window::onload()");
			writeln("{");
			writeln("	window.resizeTo(document.getElementById('photpimg').width + 40, document.getElementById('photpimg').height + 65);");
			writeln("}");
			writeln("</script>");
			writeln("</head>");
			writeln("<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>");
			writeln("<table border=0  cellpadding=0 cellspacing=0 width=100% height=100%>");
			writeln("<tr><td align=center><img id='photpimg' src='"+objImg.src+"' style=cursor:hand onClick='self.close();' alt='닫기'></td></tr>");
			writeln("</table>");
			writeln("</body>");
			writeln("</hmtl>");
		}
	bigImgWin.close;
	bigImgWin.focus();
}
function cmdAdv(){
	window.open("/etc/Sp_Offer.jsp","moving_area","width=700,height=580,toolbar=no,directories=no,status=no,scrollbars=no,resizable=no,menubar=no");
}
function cmdKbListWrite(cate,modelno){
	insertLog(5739);
	var surl = "/knowbox/List_write.jsp";
	if(top.location.href.indexOf("/blog/")>0){ //블로그
		surl += "?kbno=" + iKbno;
		surl += "&rcontent=write";
		var win = window.open(surl);
		win.focus();
	}else{
		parent.cmdSetScroll(0);
		surl += "?kbcate=" + top.document.getElementById("frmKbList").kbcate.value;
		surl += "&kbcode=" + top.document.getElementById("frmKbList").kbcode.value;
		surl += "&kbno=" + iKbno;
		surl += "&cate=" + cate;
		surl += "&modelno=" + modelno;
		surl += "&rcontent=write";
		rContent = "write";
		location.href = surl;
	}
}
//구매가이드 결론부
function cmdGuideDetailView(param){ //상세내용 보이기
	if(typeof(param)=="undefined"){
		param = "";
	}
	try{
		document.getElementById("btn_guidetitle_content_view").style.display = "none";
		document.getElementById("btn_guidetitle_content_hide").style.display = "inline";
		document.getElementById("guidetitle_content").style.display = "block";
		insertLog(3422);
		if(strFrom=="main" && iKbno==253971){
			insertLog(4137);
		}
	}catch(e){}
	docResize();
	try{ //상세내용이 보이도록 스크롤을 이동
		document.getElementById("guidetitle_content").scrollIntoView(true);
		if(top.document.getElementById("FSETMAIN")){
			top.document.getElementById("FSETMAIN").scrollTop = (top.document.getElementById("FSETMAIN").scrollTop - 200)+"px";
		}else{
			top.document.body.scrollTop = (top.document.body.scrollTop - 200)+"px";
		}
	}catch(e){}
	//상세내용 보이면서 특정 위치 스크롤 이동
	if(param!=""){
		try{
			var iTop = Position.cumulativeOffset(document.getElementById(param))[1];
			parent.cmdSetScroll(iTop);
		}catch(e){}
	}
}
function cmdGuideDetailHide(){ //상세내용 감추기
	document.getElementById("btn_guidetitle_content_view").style.display = "inline";
	document.getElementById("btn_guidetitle_content_hide").style.display = "none";
	document.getElementById("guidetitle_content").style.display = "none";
	docResize();
	try{ //스크롤을 이동
		if(top.document.getElementById("FSETMAIN")){
			top.document.getElementById("FSETMAIN").scrollTop = 0;
		}else{
			top.document.body.scrollTop = 0;
		}
	}catch(e){}
}
function faq_close(){ //자주묻는질문 감추기
	for(i=1; i<30; i++){
		if(document.getElementById("faq_"+i) && document.getElementById("faq_"+i+"_an")){
			document.getElementById("faq_"+i).style.display = "block";
			document.getElementById("faq_"+i+"_an").style.display = "none";
		}else{
			break;
		}
	}
	docResize();
}
function faq_answer(param){ //자주묻는질문 보이기
	if(document.getElementById("faq_"+param) && document.getElementById("faq_"+param+"_an")){
		document.getElementById("faq_"+param).style.display = "none";
		document.getElementById("faq_"+param+"_an").style.display = "block";
	}
	docResize();
}
function faq_more(param){ //자주묻는질문 답변 more 보이기 최초버전
	if(document.getElementById("faq_"+param+"_more")){
		if(document.getElementById("faq_"+param+"_more").style.display=="block"){
			document.getElementById("faq_"+param).className = "guide_title_faq";
			if(document.getElementById("faq_"+param+"_a")) document.getElementById("faq_"+param+"_a").src = var_img_enuri_com+"/images/guide/icon_answer_bg.gif";
			document.getElementById("faq_"+param+"_morebtn").style.display = "inline";
			document.getElementById("faq_"+param+"_more").style.display = "none";
		}else{
			document.getElementById("faq_"+param).className = "guide_title_faq_border";
			if(document.getElementById("faq_"+param+"_a")) document.getElementById("faq_"+param+"_a").src = var_img_enuri_com+"/images/guide/icon_answer.gif";
			document.getElementById("faq_"+param+"_morebtn").style.display = "none";
			document.getElementById("faq_"+param+"_more").style.display = "block";
		}
		docResize();
	}
}
function faq_more_1007(param){ //자주묻는질문 답변 more 보이기 10.7월 버전
	if(document.getElementById("faq_"+param+"_more")){
		if(document.getElementById("faq_"+param+"_more").style.display=="block"){
			if(document.getElementById("faq_"+param+"_a")) document.getElementById("faq_"+param+"_a").src = var_img_enuri_com+"/images/guide/icon_answer_bg.gif";
			document.getElementById("faq_"+param+"_morebtn").style.display = "inline";
			document.getElementById("faq_"+param+"_more").style.display = "none";
		}else{
			if(document.getElementById("faq_"+param+"_a")) document.getElementById("faq_"+param+"_a").src = var_img_enuri_com+"/images/guide/icon_answer.gif";
			document.getElementById("faq_"+param+"_morebtn").style.display = "none";
			document.getElementById("faq_"+param+"_more").style.display = "block";
		}
		docResize();
	}
}
function cmdGuideMoreView(){ //더보기항목 보이기
	try{
		document.getElementById("btn_guidetitle_more_view").style.display = "none";
		document.getElementById("btn_guidetitle_more_hide").style.display = "block";
		document.getElementById("guidetitle_morequestion").style.display = "block";
		//insertLog(3422);
		docResize();
	}catch(e){}
}
function cmdGuideMoreHide(){ //더보기항목 감추기
	document.getElementById("btn_guidetitle_more_view").style.display = "block";
	document.getElementById("btn_guidetitle_more_hide").style.display = "none";
	document.getElementById("guidetitle_morequestion").style.display = "none";
	docResize();
}
//** 초보자 가이드용 */
function fnShowtitle(num){
	if (document.getElementById("hide_title"+num).style.display == "block"){
		document.getElementById("hide_title"+num).style.display = "none"
		if (num == "0"){
			document.hide_menu0.src = var_img_enuri_com+"/images/etc/guide/0.gif";
		}else if (num == "1"){
			document.hide_menu1.src = var_img_enuri_com+"/images/etc/guide/1.gif";
		}else if(num == "2"){
			document.hide_menu2.src = var_img_enuri_com+"/images/etc/guide/2.gif";
		}else if(num == "3"){
			document.hide_menu3.src = var_img_enuri_com+"/images/etc/guide/3.gif";
		}else if(num == "4"){
			document.hide_menu4.src = var_img_enuri_com+"/images/etc/guide/4.gif";
		}else if(num == "5"){
			document.hide_menu5.src = var_img_enuri_com+"/images/etc/guide/5.gif";
		}else if(num == "6"){
			document.hide_menu6.src = var_img_enuri_com+"/images/etc/guide/6.gif";
		}else if(num == "7"){
			document.hide_menu7.src = var_img_enuri_com+"/images/etc/guide/7.gif";
		}
		
	}else{
		document.getElementById("hide_title"+num).style.display = "block"
		if (num == "0"){
			document.hide_menu0.src = var_img_enuri_com+"/images/etc/guide/0_1.gif";
		}else if (num == "1"){
			document.hide_menu1.src = var_img_enuri_com+"/images/etc/guide/1_1.gif";
		}else if(num == "2"){
			document.hide_menu2.src = var_img_enuri_com+"/images/etc/guide/2_1.gif";
		}else if(num == "3"){
			document.hide_menu3.src = var_img_enuri_com+"/images/etc/guide/3_1.gif";
		}else if(num == "4"){
			document.hide_menu4.src = var_img_enuri_com+"/images/etc/guide/4_1.gif";
		}else if(num == "5"){
			document.hide_menu5.src = var_img_enuri_com+"/images/etc/guide/5_1.gif";
		}else if(num == "6"){
			document.hide_menu6.src = var_img_enuri_com+"/images/etc/guide/6_1.gif";
		}else if(num == "7"){
			document.hide_menu7.src = var_img_enuri_com+"/images/etc/guide/7_1.gif";
		}
	}
	docResize();
}
function load_rsi(pcode){ //실제사진링크함수, 구매가이드컨텐츠에서 사용
	RunRealSize(pcode+'');
}
// 동영상 재생관련 함수 start
function cmdKbMovPlay(){
	if($("KbPlayer")){
		$("KbPlayer").play();
		$("tbl_palyinit").style.display = "none";
		$("tbl_playscreen").style.display = "block";
	}
}
var Pposition;
function cmdKbMovEnd(){
	var KbPlayerState = KbPlayer.PlayState;
	if (Pposition==0 && $("tbl_playscreen").style.display=="block" && KbPlayerState==0){
		$("tbl_playscreen").style.display = "none";
		$("tbl_palyinit").style.display = "block";
	}
}
// 동영상 재생관련 함수 end
function closeImgDiv(obj) {
	obj.style.display = "none";
}
function showImgDiv_20091221(imgPath) {
	if(document.getElementById("imgKnowboxTag")) {
		document.getElementById("imgKnowboxTag").src = imgPath;
		document.getElementById("imgKnowboxShowDiv").style.left = 160+"px";
	}
	if(document.getElementById("FSETMAIN")) {
		document.getElementById("imgKnowboxShowDiv").style.top = (top.document.getElementById("FSETMAIN").scrollTop + 100)+"px";
	} else {
		document.getElementById("imgKnowboxShowDiv").style.top = (top.document.body.scrollTop + 100)+"px";
	}
	document.getElementById("imgKnowboxShowDiv").style.display = "inline";
}
function knowBoxBigImgOpen_20091221(url1) {
	k = window.open(url1,"guideImgPopup","top=0,left=0,toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,menubar=no,personalbar=no");
	k.focus();
}
// 업로드된 확대이미지를 보여주기 위한 함수
function bigImageShowPopup(imgPath) {
	var url = "http://www.enuri.com/view/enuriupload/Show_OneImageKnowboxPopup.jsp?imgname="+imgPath;
	var imageshowPopup = window.open(url, "imageshow", "width="+window.screen.width+",height="+window.screen.height+",top=0,left=0,toolbar=no,location=no,directories=no,status=no,scrollbars=no,menubar=no,personalbar=no");
	imageshowPopup.focus();
}


function syncHeightMenuFrame() {
	try{
		var varAddHeight = 0;
		if (BrowserDetect.browser == "Explorer" || BrowserDetect.browser == "Firefox"){
			varAddHeight = varAddHeight + document.getElementById("enuriMenuFrame").contentWindow.document.body.scrollHeight; 
		}else{
			varAddHeight = varAddHeight + document.getElementById("enuriMenuFrame").contentWindow.document.documentElement.scrollHeight ? document.getElementById("enuriMenuFrame").contentWindow.document.documentElement.scrollHeight : document.getElementById("enuriMenuFrame").contentWindow.document.body.scrollHeight;
		}			
		document.getElementById("enuriMenuFrame").height = varAddHeight+"px";
   	}catch(e){}
}

function fnImgResize(obj){
	if(document.body.offsetWidth < obj.width) obj.width = document.body.offsetWidth*0.98;
}