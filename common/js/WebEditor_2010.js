//에누리 웹에디터
/////////////////////////////////
//초기화
var ImageServer = "http://img.enuri.com";
var WebEditor;
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
	if(navigator.userAgent.indexOf('Trident/7.0') >= 0){
		return "msie11";
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
var browserName = getBrowserName();
function initialize(){
	var html_tag = "";
	WebEditor = new WebEd();
	
	document.getElementById("TextEditor").contentWindow.document.open();
	document.getElementById("TextEditor").contentWindow.document.write(document.frmWKnowBox.FROMDB.value);
	document.getElementById("TextEditor").contentWindow.document.close();
	document.getElementById("TextEditor").contentWindow.document.designMode = 'on';

	document.getElementById("iframe_image").contentWindow.document.open();
	html_tag = html_tagLink("image");
	document.getElementById("iframe_image").contentWindow.document.write(html_tag);
	document.getElementById("iframe_image").contentWindow.document.close();

	document.getElementById("iframe_link").contentWindow.document.open();
	html_tag = html_tagLink("link");
	document.getElementById("iframe_link").contentWindow.document.write(html_tag);
	document.getElementById("iframe_link").contentWindow.document.close();

	document.getElementById("iframe_fontcolor").contentWindow.document.open();
	html_tag = html_tagColor("forecolor");
	document.getElementById("iframe_fontcolor").contentWindow.document.write(html_tag);
	document.getElementById("iframe_fontcolor").contentWindow.document.close();
	
	if(window.attachEvent){
	    document.getElementById("TextEditor").contentWindow.document.attachEvent("onclick",new Function("isLogin()"));                 
	} else if(window.addEventListener){
	    document.getElementById("TextEditor").contentWindow.document.addEventListener("click",new Function("isLogin()"),false);
	}else {
	    document.getElementById("TextEditor").contentWindow.document.addEventListener("click",new Function("isLogin()"),false);
	}	
}
function cmdBtnUp(obj){
	obj.src = obj.src.replace("_out.gif","_over.gif");
}
function cmdBtnOut(obj){
	obj.src = obj.src.replace("_over.gif","_out.gif");
}
function SelectionCommand(Btn, cmd){
	if(document.frmWKnowBox.sourceview.checked){
		alert('소스편집 체크를 해제하고 사용하세요');
		return;
	}
	var sel = null;
	var EdRange = null;

	if(browserName.indexOf("msie")>-1){
		sel = document.getElementById("TextEditor").contentWindow.document.selection;
		EdRange = sel.createRange();
	}else{
		sel = document.getElementById("TextEditor").contentWindow.getSelection();
		EdRange = sel.getRangeAt(0);
	}
	EdRange.execCommand(cmd,false,false);
}
function view_source(flag){
	hide_all();
	if(flag){
		//소스 편집
		var tmp = document.getElementById("TextEditor").contentWindow.document.body.innerHTML;
		document.getElementById("TextEditor").style.display = "none";
		document.getElementById("TextEditor").contentWindow.document.body.innerText = tmp;
		document.getElementById("TextEditor").style.display = "block";
		document.getElementById("TextEditor").contentWindow.document.body.style.backgroundImage = '';
		document.getElementById("TextEditor").contentWindow.document.body.style.backgroundColor = '';
		document.getElementById("TextEditor").contentWindow.document.body.style.fontFamily = "굴림";
		document.getElementById("TextEditor").contentWindow.focus();
	}else{
		//html
		var tmp = document.getElementById("TextEditor").contentWindow.document.body.innerText;
		document.getElementById("TextEditor").style.display = "none";
		document.getElementById("TextEditor").contentWindow.document.body.innerHTML = tmp;
		document.getElementById("TextEditor").style.display = "block";
		document.getElementById("TextEditor").contentWindow.document.body.style.fontFamily = "맑은 고딕";
		document.getElementById("TextEditor").contentWindow.focus();
	}
}
function go_text(){
	if(document.frmWKnowBox.sourceview.checked){
		alert('소스편집을 해제하시고 텍스트 모드를 선택해주세요.');
		document.frmWKnowBox.content_type[0].checked = true;
		return;
	}
	var conf = confirm("html효과들은 사라집니다. 계속하겠습니까?");
	if(!conf){
		document.frmWKnowBox.content_type[0].checked = true;
		return;
	}
	var str;
	str = document.getElementById("TextEditor").contentWindow.document.body.innerText;
	document.getElementById("TextEditor").contentWindow.document.body.innerText = str.replace(/&lt;?/g, '<').replace(/&gt;?/g, '>').replace(/&quot;?/g, '"').replace(/&amp;?/g, '&');
}

function go_html(){
	document.getElementById("TextEditor").contentWindow.document.body.innerHTML = replace_br( document.getElementById("TextEditor").contentWindow.document.body.innerText );
}
function replace_br(str){
	var start=0;
	var dest="";
	var pos=0;
	while(true)
	{
		pos = str.indexOf("\n",start);
		if (pos == -1)
		{
			dest = dest + str.substr(start);
			return dest;
		}
		else
		{
			dest = dest + str.substr(start,pos-start) + "<br>";
			start=pos+1;
		}
	}
}
function WebEd(){
	this.selection    = null;
	this.selection2    = null;
	this.RestoreSelection = WebEd_RestoreSelection;
	this.SaveSelection  = WebEd_SaveSelection;
	this.GetSelection  = WebEd_GetSelection;
}

function WebEd_RestoreSelection() {
	if (this.selection) {
		this.selection.select();
	}
}

function WebEd_GetSelection(){
	var we_Sel = this.selection;
	if (!we_Sel) {
		we_Sel = getCreateRange();
		we_Sel.type = getCreateSelectionType();
	}
	return we_Sel;
}

function WebEd_SaveSelection(){
	WebEditor.selection = getCreateRange();
	WebEditor.selection.type = getCreateSelectionType();
}

/*
 * author : by CDS
 * date   : 2013.08.29
 * function : 크로스 브라우저 문제로 인한 스크립트 오류를 해결하기 위해 만듦
 */
function getCreateRange()
{
	if(browserName.indexOf('msie') > -1)
		return document.getElementById("TextEditor").contentWindow.document.selection.createRange();
	else	
		return document.getElementById("TextEditor").contentWindow.getSelection();
}

/*
 * author : by CDS
 * date   : 2013.08.29
 * function : 크로스 브라우저 문제로 인한 스크립트 오류를 해결하기 위해 만듦
 */
function getCreateSelectionType()
{
	if(browserName.indexOf('msie') > -1)
		return document.getElementById("TextEditor").contentWindow.document.selection.type;
	else 
		return document.getElementById("TextEditor").contentWindow.getSelection().type;
}
function webed_showmenu(framename){
	if(document.getElementById(framename).style.display=='block'){
		document.getElementById(framename).style.display = 'none';
	}else{
   		document.getElementById(framename).style.display = 'block';
	}
	if(framename == 'iframe_image'){
		document.getElementById("iframe_image").contentWindow.document.imageform.imageurl.focus();
		document.getElementById("iframe_image").contentWindow.document.imageform.imageurl.select();
	}
	else if(framename == 'iframe_link'){
		document.getElementById("iframe_link").contentWindow.document.linkform.linkurl.focus();
		document.getElementById("iframe_link").contentWindow.document.linkform.linkurl.select();
	}
}
function do_command(what, opt){
  if (opt == null) {
  	document.getElementById("TextEditor").contentWindow.document.execCommand(what);
  }else{
  	document.getElementById("TextEditor").contentWindow.document.execCommand(what,"", opt);
  }
  WebEditor.selection = null;
}
function hide_all(){
	document.getElementById("iframe_fontcolor").style.display = 'none';
	document.getElementById("iframe_link").style.display = 'none';
	document.getElementById("iframe_image").style.display = 'none';
}
function blackbox(clk, opt){
	var flg_open=0;
	if(clk == "webed_showmenu"){
		if(document.getElementById(opt).style.display=='block'){
			flg_open = 1;
		}
	}
	hide_all();
	if(document.frmWKnowBox.sourceview.checked){
		alert('소스편집 체크를 해제하고 사용하세요');
		return;
	}
	if(clk == "webed_showmenu"){
		if(flg_open==0){
			WebEditor.SaveSelection();
			webed_showmenu(opt);
		}
		return;
	}
	
	WebEditor.RestoreSelection();
	
	if(WebEditor.selection){
		var aa = WebEditor.selection.parentElement();
		if(aa.style.topmargin != "12px"){
			document.getElementById("TextEditor").contentWindow.focus();
		}
	}

	if(clk == "insertimage"){
		if(opt != "" && opt != "http://"){
//			iframe_image.document.imageform.imageurl.value='http://';
			var iCtrl = getCreateRange();
			alert('전송 완료');
			setPasteHTML(iCtrl,"<IMG src='" + opt + "'>");
		}
	}else if(clk == "insertimage_file"){
		var iCtrl = getCreateRange();
		setPasteHTML(iCtrl,"<IMG src='"+opt+"'>");

	}else if(clk == "hyper_link"){
		if(opt != "" && opt != "http://"){
			iframe_link.document.linkform.linkurl.value='http://';
			var lCtrl = getCreateRange();
			if(lCtrl.htmlText==''){
				setPasteHTML(lCtrl,"<A HREF='"+opt+"' target='_blank' style='text-decoration:underline;'>"+opt+"</A>");
			}
			else{
				setPasteHTML(lCtrl,"<A HREF='"+opt+"' target='_blank' style='text-decoration:underline;'>"+lCtrl.htmlText+"</A>");
			}
		}
	}else if(clk == "apply_html"){
		apply_html();
		return;
	}else{
		do_command(clk, opt);
	}
	return true;
}
function apply_html(){
	var eA = getCreateRange();
	var aa = eA.parentElement();
	setPasteHTML(eA,eA.text);

	document.getElementById("TextEditor").contentWindow.focus();
}

function setPasteHTML(obj,text)
{

	if(browserName.indexOf('msie') > -1)
		obj.pasteHTML(text);
	else{
		if (obj.rangeCount > 0) {
			var objTmp = obj.getRangeAt(0);

			objTmp.deleteContents();
			objTmp.insertNode(objTmp.createContextualFragment(text));
		}
	}
}
// Color Map
var colormap = new Array(10);
colormap[0] = new Array('#ffffff','#e5e4e4','#d9d8d8','#c0bdbd','#a7a4a4','#8e8a8b','#827e7f','#767173','#5c585a','#000000');
colormap[1] = new Array('#fefcdf','#fef4c4','#feed9b','#fee573','#ffed43','#f6cc0b','#e0b800','#c9a601','#ad8e00','#8c7301');
colormap[2] = new Array('#ffded3','#ffc4b0','#ff9d7d','#ff7a4e','#ff6600','#e95d00','#d15502','#ba4b01','#a44201','#8d3901');
colormap[3] = new Array('#ffd2d0','#ffbab7','#fe9a95','#ff7a73','#ff483f','#fe2419','#f10b00','#d40a00','#940000','#6d201b');
colormap[4] = new Array('#ffdaed','#ffb7dc','#ffa1d1','#ff84c3','#ff57ac','#fd1289','#ec0078','#d6006d','#bb005f','#9b014f');
colormap[5] = new Array('#fcd6fe','#fbbcff','#f9a1fe','#f784fe','#f564fe','#f546ff','#f328ff','#d801e5','#c001cb','#8f0197');
colormap[6] = new Array('#e2f0fe','#c7e2fe','#add5fe','#92c7fe','#6eb5ff','#48a2ff','#2690fe','#0162f4','#013add','#0021b0');
colormap[7] = new Array('#d3fdff','#acfafd','#7cfaff','#4af7fe','#1de6fe','#01deff','#00cdec','#01b6de','#00a0c2','#0084a0');
colormap[8] = new Array('#edffcf','#dffeaa','#d1fd88','#befa5a','#a8f32a','#8fd80a','#79c101','#3fa701','#307f00','#156200');
colormap[9] = new Array('#d4c89f','#daad88','#c49578','#c2877e','#ac8295','#c0a5c4','#969ac2','#92b7d7','#80adaf','#9ca53b');
function html_tagColor(flag){
	var str = "";
	str = str + "<html><body marginwidth=0 marginheight=0 topmargin=0 leftmargin=0>";
	str = str + "<table cellpadding=0 cellspacing=0 border=0>";

	for (var i=0; i<10; i++){
		str = str + "<tr>";
		for(var j=0; j<10; j++){
			str = str + "<td onmouseover=this.style.backgroundColor='blue' onmouseout=this.style.backgroundColor=''><table cellpadding=0 cellspacing=1 border=0><tr><td bgcolor='" + colormap[i][j] + "' onclick='parent.blackbox(\"" + flag + "\", \"" + colormap[i][j] + "\");' width=12 height=12></td></tr></table></td>";
		}   
		str = str + "</tr>";
	}       
	return str;
}

function checkImgFormat_file(imgPath){
 	if(imgPath.indexOf(".JPG") != -1 ||
 		imgPath.indexOf(".GIF") != -1 ||
 		imgPath.indexOf(".gif") != -1 ||
 		imgPath.indexOf(".jpg") != -1 ){
		blackbox("insertimage_file", imgPath);
	}else{
 		if(imgPath != ""){
 			alert("지원하지 않는 파일입니다. jpg 나 gif 포맷만 지원합니다.");
 		}
	}     		
}
function html_tagLink(flag){
	var str = "";
	str = str + "<html><head><style> td { font-size:10pt; color:#000000; font-family:굴림; } .base { font-size:9pt; color:#000000; font-family:굴림; } </style></head><body marginwidth=0 marginheight=0 topmargin=10 leftmargin=5 bgcolor='#efefef'>";
	if(flag == "link"){
		str = str + "<font class=base>&nbsp;선택된 부분에 걸릴 링크 주소(url)을 넣어주세요<br>&nbsp;&nbsp;(예: http://www.enuri.com) - \"http://\" 꼭 써야 함..</font><br> <table><tr><form name=linkform onsubmit='parent.blackbox(\"hyper_link\", document.linkform.linkurl.value); return false;'><td> <input type='text' name='linkurl' value='http://' size=29> <img src='"+ImageServer+"/images/knowbox/webed/btApply.gif' onclick='parent.blackbox(\"createlink\", document.linkform.linkurl.value);' border=0 align=absmiddle> <img src='"+ImageServer+"/images/knowbox/webed/btcancel.gif' onclick='parent.blackbox(\"unlink\"); parent.hide_all();' border=0 align=absmiddle></td></form></tr></table></body></html>";
	}else if(flag == "image"){
		str = str + "<font class=base>&nbsp;인터넷에 올려진 이미지만 삽입이 가능합니다.<br>&nbsp;삽입할 이미지 주소(url)을 넣어주세요<br>&nbsp;&nbsp;(예: http://www.enuri.com/img.gif) - \"http://\" 꼭 써야 함</font><br> <table><tr><form name=imageform onsubmit='parent.blackbox(\"insertimage\", document.imageform.imageurl.value); return false;'><td> <input type='text' name='imageurl' value='http://' size=29'> <img src='"+ImageServer+"/images/knowbox/webed/btApply.gif' onclick='parent.blackbox(\"insertimage\", document.imageform.imageurl.value);' border=0 align=absmiddle> <img src='"+ImageServer+"/images/knowbox/webed/btcancel.gif' onclick='parent.hide_all();' border=0 align=absmiddle></td></form></tr></table>";
   		str = str + "</body></html>";
	}
	return str;
}
function Form_onsubmit() {
	if(Form1.imagefile.value == ""){
		alert("업로드할 이미지 화일을 선택해주세요.");
		return false;
	}
	if(Form1.imagefile.value.indexOf(".JPG") != -1 ||
 		Form1.imagefile.value.indexOf(".GIF") != -1 ||
 		Form1.imagefile.value.indexOf(".gif") != -1 ||
 		Form1.imagefile.value.indexOf(".jpg") != -1 ){
		return true;
	}else{
		alert("지원하지 않는 파일입니다. jpg 나 gif 포맷만 지원합니다.");
		return false;
	} 
	return true;
}
function checkImgFormat(imgPath, imgIndex){
 	if(imgPath.indexOf(".JPG") != -1 ||
 		imgPath.indexOf(".GIF") != -1 ||
 		imgPath.indexOf(".gif") != -1 ||
 		imgPath.indexOf(".jpg") != -1 ){

		if(imgIndex == "1"){
			Form1.preview.src = imgPath;
			Form1.preview.style.visibility = "visible";
		}
	}else{
 		if(imgPath != ""){
 			alert("지원하지 않는 파일입니다. jpg 나 gif 포맷만 지원합니다.");
 		}
	}
}
function openNewWindow(){ 
	var left = (screen.width  - 400 ) / 2;
	var top  = (screen.height - 500) / 2;
	var option = ',menubar=no,toolbar=no,directories=no,scrollbars=no,status=no,location=no,resizable=no';
	noticeWindow = window.open('/html/knowbox/popup_upload.html','notice','top='+top +',left='+left+',width=380,height=373'+option); 
	noticeWindow.focus();
}
function aaa() {
	alert('100');
}
function webeditorchk(){
	alert(1);
	if(event.keyCode == 13){
	  	alert("엔터키 방지");
	}
}
