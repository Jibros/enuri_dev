function setPng24(obj) {
	if (navigator.userAgent.toLowerCase().indexOf('msie 8') < 0){
		obj.width=obj.height=1;
		obj.className=obj.className.replace(/\bpng24\b/i,'');
		obj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+ obj.src +"',sizingMethod='image');"
		obj.src='';
	}
	return '';
}
function cmdContentsImgResize(){ //�̹����� �������� �ȵǴ� ��� ���
	var arrObj = document.getElementsByName("kb_content_img");
	if(arrObj && arrObj.length>0){
		for(i=0; i<arrObj.length; i++){
			LimitImgSize(arrObj[i],1);
		}
	}
}
function LimitImgSize(objImg, errCode){//�̹��� ������ ����
	try{
		if(errCode){
			resizeImg(objImg);
		}else{
			if(typeof(objImg)=="object"){
				objImg.style.display="none";
			}else{
				document.getElementById(objImg).style.display="none";
			}
		}
	}catch(e){}
}
function resizeImg(objImg){
	if(typeof(objImg)=="object"){
		objImg.realWidth = objImg.width;
		objImg.realHeight = objImg.height;
		if(objImg.width>400){ //ie7����, �̹����� ������ �پ� �ʺ� �����
			objImg.style.display = "block";		
		}
		if(objImg.width>730){
			objImg.width = 730;
		}else if(objImg.width==0){

		}
	}else{
		document.getElementById(objImg).realWidth = document.getElementById(objImg).width;
		document.getElementById(objImg).realHeight = document.getElementById(objImg).height;
		if(document.getElementById(objImg).width>400){ //ie7����, �̹����� ������ �پ� �ʺ� �����
			document.getElementById(objImg).style.display = "block";
		}
		if(document.getElementById(objImg).width > 730){
			document.getElementById(objImg).width = 730;
		}else if(document.getElementById(objImg).width==0){

		}
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
function OpenWindowYes(OpenFile,winname,nWidth,nHeight){
	var newWin = window.open(OpenFile,winname,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
	newWin.focus();
}
function OpenWindowNo(OpenFile,winname,nWidth,nHeight){
	var newWin = window.open(OpenFile,winname,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars=no,resizable=no,menubar=no");
	newWin.focus();
}
function OpenWindow(OpenFile,name,nWidth,nHeight,ScrollYesNo,ResizeYesNo){
	var newWin = window.open(OpenFile,name,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar=no");
	newWin.focus();
}
function ViewKbBigImg(objImg){ // �̹��� Ŭ���� ��â���� ���� �̹��� ���
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
			writeln("<tr><td align=center><img id='photpimg' src='"+objImg.src+"' style=cursor:hand onClick='self.close();' alt='�ݱ�'></td></tr>");
			writeln("</table>");
			writeln("</body>");
			writeln("</hmtl>");
		}
	bigImgWin.close;
	bigImgWin.focus();
}
function closeImgDiv(obj) {
	obj.style.display = "none";
}
function cmdGuideDetailView(param){ //�󼼳��� ���̱�
	if(typeof(param)=="undefined"){
		param = "";
	}
	try{
		document.getElementById("btn_guidetitle_content_view").style.display = "none";
		document.getElementById("btn_guidetitle_content_hide").style.display = "inline";
		document.getElementById("guidetitle_content").style.display = "block";
	}catch(e){}
	try{ //�󼼳����� ���̵��� ��ũ���� �̵�
		document.getElementById("guidetitle_content").scrollIntoView(true);
	}catch(e){}

}
function cmdGuideDetailHide(){ //�󼼳��� ���߱�
	document.getElementById("btn_guidetitle_content_view").style.display = "inline";
	document.getElementById("btn_guidetitle_content_hide").style.display = "none";
	document.getElementById("guidetitle_content").style.display = "none";
}
function faq_close(){ //���ֹ������� ���߱�
	for(i=1; i<30; i++){
		if(document.getElementById("faq_"+i) && document.getElementById("faq_"+i+"_an")){
			document.getElementById("faq_"+i).style.display = "block";
			document.getElementById("faq_"+i+"_an").style.display = "none";
		}else{
			break;
		}
	}
}
function faq_answer(param){ //���ֹ������� ���̱�
	if(document.getElementById("faq_"+param) && document.getElementById("faq_"+param+"_an")){
		document.getElementById("faq_"+param).style.display = "none";
		document.getElementById("faq_"+param+"_an").style.display = "block";
	}
}
function faq_more(param){ //���ֹ������� �亯 more ���̱� ���ʹ���
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
	}
}
function faq_more_1007(param){ //���ֹ������� �亯 more ���̱� 10.7�� ����
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
	}
}
function cmdGuideMoreView(){ //�������׸� ���̱�
	try{
		document.getElementById("btn_guidetitle_more_view").style.display = "none";
		document.getElementById("btn_guidetitle_more_hide").style.display = "block";
		document.getElementById("guidetitle_morequestion").style.display = "block";
	}catch(e){}
}
function cmdGuideMoreHide(){ //�������׸� ���߱�
	document.getElementById("btn_guidetitle_more_view").style.display = "block";
	document.getElementById("btn_guidetitle_more_hide").style.display = "none";
	document.getElementById("guidetitle_morequestion").style.display = "none";
}
// ������ ������� �Լ� start
function cmdKbMovPlay(){
	if(document.getElementById("KbPlayer")){
		document.getElementById("KbPlayer").play();
		document.getElementById("tbl_palyinit").style.display = "none";
		document.getElementById("tbl_playscreen").style.display = "block";
	}
}
var Pposition;
function cmdKbMovEnd(){
	var KbPlayerState = KbPlayer.PlayState;
	if (Pposition==0 && document.getElementById("tbl_playscreen").style.display=="block" && KbPlayerState==0){
		document.getElementById("tbl_playscreen").style.display = "none";
		document.getElementById("tbl_palyinit").style.display = "block";
	}
}
// ������ ������� �Լ� end
function showImgDiv_20091221(imgPath) {
	if(document.getElementById("imgKnowboxTag")) {
		document.getElementById("imgKnowboxTag").src = imgPath;
		document.getElementById("imgKnowboxShowDiv").style.left = 160+"px";
	}
	document.getElementById("imgKnowboxShowDiv").style.display = "inline";
}
function knowBoxBigImgOpen_20091221(url1) {
	k = window.open(url1,"guideImgPopup","width=100,height=100,top=0,left=0,toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,menubar=no,personalbar=no");
	k.focus();
}
// ���ε�� Ȯ���̹����� �����ֱ� ���� �Լ�
function bigImageShowPopup(imgPath) {
	var url = "http://www.enuri.com/view/enuriupload/Show_OneImageKnowboxPopup.jsp?imgname="+imgPath;
	var imageshowPopup = window.open(url, "imageshow", "width="+window.screen.width+",height="+window.screen.height+",top=0,left=0,toolbar=no,location=no,directories=no,status=no,scrollbars=no,menubar=no,personalbar=no");
	imageshowPopup.focus();
}