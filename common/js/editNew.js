 //에누리 웹에디터
var ImageServer = "http://img.enuri.com";
/////////////////////////////////
//초기화
function initialize() 
{
	var html_tag = "";
	WebEditor = new WebEd();
	TextEditor.document.open();
	TextEditor.document.write(document.frmWKnowBox.FROMDB.value);
	TextEditor.document.close();
	TextEditor.document.designMode = 'on';

	iframe_image.document.open();
	html_tag = html_tagLink("image");
	iframe_image.document.write(html_tag);
	iframe_image.document.close();

	iframe_link.document.open();
	html_tag = html_tagLink("link");
	iframe_link.document.write(html_tag);
	iframe_link.document.close();

	iframe_fontcolor.document.open();
	html_tag = html_tagColor("forecolor");
	iframe_fontcolor.document.write(html_tag);
	iframe_fontcolor.document.close();

}

function initialize_edu() 
{
	var html_tag = "";
	WebEditor = new WebEd();

	TextEditor.document.open();
	TextEditor.document.write(document.frmDetail.FROMDB.value);
	TextEditor.document.close();
	TextEditor.document.designMode = 'on';

	iframe_image.document.open();
	html_tag = html_tagLink("image");
	iframe_image.document.write(html_tag);
	iframe_image.document.close();

	iframe_link.document.open();
	html_tag = html_tagLink("link");
	iframe_link.document.write(html_tag);
	iframe_link.document.close();

	iframe_fontcolor.document.open();
	html_tag = html_tagColor("forecolor");
	iframe_fontcolor.document.write(html_tag);
	iframe_fontcolor.document.close();
}

function ButtonUp(param) 
{
	param.style.border="1px outset";
	param.style.background="#D4D4D4";
}

function ButtonOut(param) 
{
	param.style.border="";
	param.style.background="";

}
function MenuOver(param) 
{
	param.style.fontColor="white";
	param.style.backgroundColor="navy";
}

function MenuOut(param) 
{
	param.style.fontcolor="white";
	param.style.backgroundColor="#C0C0C0";
}


function SelectionCommand(Btn, cmd) 
{
//	if(document.frmWKnowBox.content_type[1].checked)
//	{
//		alert('에디터 형태를 HTML 로 선택하고 사용하세요');
//		return;
//	}
	if(document.frmWKnowBox.sourceview.checked)
	{
		alert('소스편집 체크를 해제하고 사용하세요');
		return;
	}
	TextEditor.focus();
	var EdRange=TextEditor.document.selection.createRange();
	EdRange.execCommand(cmd);
}



function view_source(flag)
{
	hide_all();
	
//	if(document.frmWKnowBox.content_type[1].checked)
//	{
//		alert('에디터 형태를 HTML 로 선택하고 사용하세요');
//		document.frmWKnowBox.sourceview.checked = false;
//		return;
//	}
	
	if(flag)
	{
		//소스 편집 
		var tmp = TextEditor.document.body.innerHTML;
		TextEditor.document.body.innerText = tmp;
		TextEditor.document.body.style.backgroundImage = '';
		TextEditor.document.body.style.backgroundColor = '';
		TextEditor.focus();
	}
	else
	{
		//html
		var tmp = TextEditor.document.body.innerText;
		TextEditor.document.body.innerHTML = tmp;
		TextEditor.focus();
	}
}

function go_text(){


	if(document.frmWKnowBox.sourceview.checked)
	{		
		alert('소스편집을 해제하시고 텍스트 모드를 선택해주세요.');
		document.frmWKnowBox.content_type[0].checked = true;
		return;
	}

	var conf = confirm("html효과들은 사라집니다. 계속하겠습니까?");
	if(!conf)
	{
		document.frmWKnowBox.content_type[0].checked = true;
		return;
	}

	var str;

	str = TextEditor.document.body.innerText;

	TextEditor.document.body.innerText = str.replace(/&lt;?/g, '<').replace(/&gt;?/g, '>').replace(/&quot;?/g, '"').replace(/&amp;?/g, '&');
}

function go_html()
{
	TextEditor.document.body.innerHTML = replace_br( TextEditor.document.body.innerText );
}

function replace_br(str)
{
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


function WebEd()
{
	this.selection    = null;
	this.selection2    = null;
	this.RestoreSelection = WebEd_RestoreSelection;
	this.SaveSelection  = WebEd_SaveSelection;
	this.GetSelection  = WebEd_GetSelection;
}

function WebEd_RestoreSelection() 
{
	if (this.selection) {
		this.selection.select();
	}
}

function WebEd_GetSelection() 
{
	var we_Sel = this.selection;
	if (!we_Sel) {
		we_Sel = TextEditor.document.selection.createRange();
		we_Sel.type = TextEditor.document.selection.type;
	}
	return we_Sel;
}

function WebEd_SaveSelection() 
{
	WebEditor.selection = TextEditor.document.selection.createRange();
	WebEditor.selection.type = TextEditor.document.selection.type;
}



function webed_showmenu(framename)
{
    	var rightedge = document.body.clientWidth-event.clientX;
	var bottomedge = document.body.clientHeight-event.clientY;

	var leftpoint;
	var toppoint;

    	if (rightedge < document.all.item(framename).style.width) {
       		leftpoint = document.body.scrollLeft + event.clientX - document.all.item(framename).style.width +40;
    	}
    	else{
       		leftpoint = document.body.scrollLeft + event.clientX - 40;
    	}

        toppoint = document.body.scrollTop + event.clientY;

	toppoint = toppoint + 10;

	document.all.item(framename).style.left = leftpoint;
	document.all.item(framename).style.top = toppoint;

	if(document.all.item(framename).style.visibility == 'visible')
		document.all.item(framename).style.visibility = 'hidden';
	else
    		document.all.item(framename).style.visibility = 'visible';

	if(framename == 'iframe_image'){
		iframe_image.document.imageform.imageurl.focus();
		iframe_image.document.imageform.imageurl.select();
	}
	else if(framename == 'iframe_link'){
		iframe_link.document.linkform.linkurl.focus();
		iframe_link.document.linkform.linkurl.select();
	}

}

function do_command(what, opt)
{
  if (opt == null) {
  TextEditor.document.execCommand(what);
  }
  else {
  TextEditor.document.execCommand(what,"", opt);
  }
  WebEditor.selection = null;
}



function hide_all(){
	document.all.iframe_fontcolor.style.visibility='hidden';  
	document.all.iframe_link.style.visibility='hidden';  
	document.all.iframe_image.style.visibility='hidden';  
}

function blackbox(clk, opt){
	var flg_open=0;

	if(clk == "webed_showmenu"){
		if(document.all.item(opt).style.visibility!='hidden'){
			flg_open =1;
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
			TextEditor.focus();
		}
	}

	if(clk == "insertimage"){
		//alert(opt);

		if(opt != "" && opt != "http://"){
			iframe_image.document.imageform.imageurl.value='http://';
			var iCtrl = TextEditor.document.selection.createRange();
			iCtrl.pasteHTML("<IMG src='"+opt+"'>");
		}
	}
	else if(clk == "insertimage_file"){
		var iCtrl = TextEditor.document.selection.createRange();
		iCtrl.pasteHTML("<IMG src='"+opt+"'>");	
	}
	else if(clk == "hyper_link"){
		if(opt != "" && opt != "http://"){
			iframe_link.document.linkform.linkurl.value='http://';
			var lCtrl = TextEditor.document.selection.createRange();
			if(lCtrl.htmlText==''){
				lCtrl.pasteHTML("<A HREF='"+opt+"' target='_blank' style='text-decoration:underline;'>"+opt+"</A>");
			}
			else{
				lCtrl.pasteHTML("<A HREF='"+opt+"' target='_blank' style='text-decoration:underline;'>"+lCtrl.htmlText+"</A>");
			}
		}
	}
	else if(clk == "apply_html"){
		apply_html();
		return;
	}
	else{
		do_command(clk, opt);
	}
	return true;
}


function blackbox_edu(clk, opt){
	var flg_open=0;

	if(clk == "webed_showmenu"){
		if(document.all.item(opt).style.visibility!='hidden'){
			flg_open =1;
		}
	}
	hide_all();
	if(document.all.sourceview.checked){
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
			TextEditor.focus();
		}
	}

	if(clk == "insertimage"){
		//alert(opt);

		if(opt != "" && opt != "http://"){
			iframe_image.document.imageform.imageurl.value='http://';
			var iCtrl = TextEditor.document.selection.createRange();
			iCtrl.pasteHTML("<IMG src='"+opt+"'>");
		}
	}
	else if(clk == "insertimage_file"){
		var iCtrl = TextEditor.document.selection.createRange();
		iCtrl.pasteHTML("<IMG src='"+opt+"'>");	
	}
	else if(clk == "hyper_link"){
		if(opt != "" && opt != "http://"){
			iframe_link.document.linkform.linkurl.value='http://';
			var lCtrl = TextEditor.document.selection.createRange();
			if(lCtrl.htmlText==''){
				lCtrl.pasteHTML("<A HREF='"+opt+"' target='_blank'>"+opt+"</A>");
			}
			else{
				lCtrl.pasteHTML("<A HREF='"+opt+"' target='_blank'>"+lCtrl.htmlText+"</A>");
			}
		}
	}
	else if(clk == "apply_html"){
		apply_html();
		return;
	}
	else{
		do_command(clk, opt);
	}
	return true;
}


function apply_html(){
	var eA = TextEditor.document.selection.createRange();
	var aa = eA.parentElement();
	//if(aa.tagName != "BODY"){
	//	return;
	//}
	eA.pasteHTML(eA.text);
	
	TextEditor.focus();
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
	}
  	else{
     		if ( imgPath != "" ) {
     			alert("지원하지 않는 파일입니다. jpg 나 gif 포맷만 지원합니다.");
     			
     		}
	}     		
  }
    
function html_tagLink(flag){
	var str = "";
	str = str + "<html><head><style> td { font-size:10pt; color:#000000; font-family:굴림; } .base { font-size:9pt; color:#000000; font-family:굴림; } </style></head><body marginwidth=0 marginheight=0 topmargin=10 leftmargin=5 bgcolor='#efefef'>";
	if(flag == "link"){
		str = str + "<font class=base>&nbsp;선택된 부분에 걸릴 링크 주소(url)을 넣어주세요<br>&nbsp;&nbsp;(예: http://www.enuri.com) - \"http://\" 꼭 써야 함..</font><br> <table><tr><form name=linkform onsubmit='parent.blackbox(\"hyper_link\", document.linkform.linkurl.value); return false;'><td> <input type='text' name='linkurl' value='http://' size=29> <img src='"+ImageServer+"/images/knowbox/webed/btApply.gif' onclick='parent.blackbox(\"createlink\", document.linkform.linkurl.value);' border=0 align=absmiddle> <img src='"+ImageServer+/images/knowbox/webed/btcancel.gif' onclick='parent.blackbox(\"unlink\"); parent.hide_all();' border=0 align=absmiddle></td></form></tr></table></body></html>";
	}
	else if(flag == "image"){
		str = str + "<font class=base>&nbsp;인터넷에 올려진 이미지만 삽입이 가능합니다.<br>&nbsp;삽입할 이미지 주소(url)을 넣어주세요<br>&nbsp;&nbsp;(예: http://www.enuri.com/img.gif) - \"http://\" 꼭 써야 함</font><br> <table><tr><form name=imageform onsubmit='parent.blackbox(\"insertimage\", document.imageform.imageurl.value); return false;'><td> <input type='text' name='imageurl' value='http://' size=29'> <img src='"+ImageServer+"/images/knowbox/webed/btApply.gif' onclick='parent.blackbox(\"insertimage\", document.imageform.imageurl.value);' border=0 align=absmiddle> <img src='"+ImageServer+"/images/knowbox/webed/btcancel.gif' onclick='parent.hide_all();' border=0 align=absmiddle></td></form></tr></table>";
    		str = str + "</body></html>";
	}
	return str;
}


function Form_onsubmit() {
	if(Form1.imagefile.value == "")
	{
		alert("업로드할 이미지 화일을 선택해주세요.");
		return false;
	}
	if(Form1.imagefile.value.indexOf(".JPG") != -1 ||
     		Form1.imagefile.value.indexOf(".GIF") != -1 ||
     		Form1.imagefile.value.indexOf(".gif") != -1 ||
     		Form1.imagefile.value.indexOf(".jpg") != -1 ){

		return true;
	}
  	else{
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

		if(imgIndex == "1")
		 {
				Form1.preview.src = imgPath;
				Form1.preview.style.visibility = "visible";
		 }
	}
  	else{
     		if ( imgPath != "" ) {
     			alert("지원하지 않는 파일입니다. jpg 나 gif 포맷만 지원합니다.");
     			
     		}
	}     		
  }
  

function aaa() {
	alert('100');
}

  
  
