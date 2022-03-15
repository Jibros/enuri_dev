//window.name ="ENURI.COM";
try {document.execCommand('BackgroundImageCache', false, true);} catch(e) {}
//최상위 "도서"버튼 클릭시

function CmdShopOver(n){
	/*
	1.대분류 이미지 오버
	2.중분류 레이어 보여주기.
	*/
	try{
		if(n=="14"){
			OpenWindow_book('61','http://www.yes24.com/main/default.aspx?pid=95673','goodsNo');
		}else{
			CmdLcodeOver(eval("document.all.img_"+n),n); //대분류 이미지 오버...
			var strLcode = AryLcode[n].split(strSep)[0]; //???변경해야함.
			LActiveStatus = "img_"+n;
			document.all.LayerS_Menu.style.display="none";
		}
		//CmdShopShowM_Menu(n);

		/*
		CmdShopShowM_Menu(n);함수는 막아주고..
		책관련 팝업창 띄우는 부분입니다.
		*/
	}catch(e){
		window.status="";
	}
}
//즐겨찾기 추가
function addFavorite(){
	if (top.document.getElementById("enuriMenuFrame") != null){
		try{
			if (top.document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("img_bt_favor") != null){
				top.document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("img_bt_favor").click();
			}
		}catch(e){
			window.external.AddFavorite('http://www.enuri.com', '에누리(가격비교)');
		}
	}else{
	    window.external.AddFavorite('http://www.enuri.com', '에누리(가격비교)');
	}
}
//팝업 띄우기

function Main_enuriWindow(OpenFile,name,nWidth,nHeight,ScrollYesNo,ResizeYesNo,TPosition,LPosition){
	location.href=OpenFile;
}
function Main_OpenWindow(OpenFile,name,nWidth,nHeight,ScrollYesNo,ResizeYesNo,TPosition,LPosition)
{
	var newWin = window.open(OpenFile,name,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=yes,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar=no,Top="+ TPosition +",left="+ LPosition);
	newWin.focus();
}
//새창 띄우기

function Main_OpenNewWindow(OpenFile,nWidth,nHeight,TPosition,LPosition)
{
	var newWin = window.open (OpenFile,"","width="+nWidth+" height="+nHeight+" Top="+ TPosition +" ,left="+ LPosition+" toolbar=yes,location=yes,directories=yes,status=yes,scrollbars=yes,resizable=yes,menubar=yes,personalbar=yes");
	newWin.focus();
}
//Max팝업창 띄우기(임시)
function openMaxWin(url){
	var w = window.screen.width;
	var h = screen.availHeight ;		
	//k = window.open (url,"","width="+w+" height="+h+" top=0 left=0 toolbar=yes,location=yes,directories=yes,status=yes,scrollbars=yes,resizable=yes,menubar=yes,personalbar=yes");
	k = window.open (url,"_blank");
	k.focus();		
	return false;
}
//log관련


function logParticular(flag)
{
	var url = "/include/Particularloginsert.jsp";
	var param = "flag="+flag+ "&modelno=";
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param
		}
	);		
}
function insertFashionViewCount(vctype,vccol1,vccol2){
	var url = "/fashion/include/Inc_Fashion_ViewCount.jsp";
	var param = "vctype="+vctype;
	if (vccol1 != ''){
		param = param + "&vccol1="+vccol1;
	}
	if (vccol2 != ''){
		param = param + "&vccol2="+vccol2;
	}	
	param = param + "&from=main";
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param
		}
	);			
}
//쿠키 Get
function fnGetCookie( name )
{
   var nameOfCookie = name + "=";
   var x = 0;
   while ( x <= document.cookie.length )
   {
           var y = (x+nameOfCookie.length);
           if ( document.cookie.substring( x, y ) == nameOfCookie ) {
                   if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
                           endOfCookie = document.cookie.length;
                   return unescape( document.cookie.substring( y, endOfCookie ) );
           }
           x = document.cookie.indexOf( " ", x ) + 1;
           if ( x == 0 )
                   break;
   }
   return "";
}

function fnSetCookie( name, value, expiredays ){
    var todayDate = new Date();
    todayDate.toGMTString()
    todayDate.setDate( todayDate.getDate() + expiredays );
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}
function fnSetCookie_MainLogo( name, value ){
	if (typeof(expiredays) == "undefined" || expiredays == null) {
		expiredays = "";
	}
	if (expiredays == ""){
		document.cookie = name + "=" + escape( value ) + "; path=/;"
	}else{
		var todayDate = new Date();
		todayDate.toGMTString();
		todayDate.setDate( todayDate.getDate() + expiredays );	
		document.cookie = name + "=" + escape( value ) + "; path=/;"
	}
	
}	  

/*푸터 관련 스크립트*/
function Sub_OpenWindow(OpenFile,name,nWidth,nHeight,ScrollYesNo,ResizeYesNo,T,L){
	var newWin
	window.status ="";
	newWin = window.open(OpenFile,name,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar=no,left="+L+", top="+T+"");
	newWin.focus();
}

function popUp(url){
	sealWin = window.open(url,"win","toolbar=0, location=0,directories=0, status=1, menubar=1, scrollbars=1, resizable=1, width=720, height=450");
}
function GotoSDU_Login(sURL){
	var k = window.open(sURL,'WinSDULogin','width=450 height=330');
		k.focus();	
}
function makeBodyBackScreen(){
	if(borwserName=="msie6" || borwserName=="msie7"){
		document.all(1).style.overflow = "hidden";
	}else if(borwserName=="chrome"){
		document.all(0).style.overflow = "hidden";
	}else{
		document.body.style.overflow = "hidden";
	}
}
function makeBodyReturn(){
	if(borwserName=="msie6" || borwserName=="msie7"){
		document.all(1).style.overflow = "auto";
	}else if(borwserName=="chrome"){
		document.all(0).style.overflow = "auto";
	}else{
		document.body.style.overflow = "visible";
	}
}

function syncWHSaveGoods(){
	if (document.getElementById("frmSaveGoods").contentWindow.document.location.href != "" && document.getElementById("frmSaveGoods").contentWindow.document.location.href != "about:blank"){
		setTimeout("syncHeightSaveGoods()",500);
		document.getElementById("frmSaveGoods").style.display = "";
		var varW = document.body.offsetWidth/2-433;	
		if (varW < 0 ){
			varW = 0;
		}
		document.getElementById("frmSaveGoods").style.left = varW+"px";
		document.getElementById("frmSaveGoods").style.display = "";
		window.scrollTo(0,0);
   	}
}
function syncHeightSaveGoods(){
	document.getElementById("frmSaveGoods").contentWindow.init();
	document.getElementById("frmSaveGoods").height = document.getElementById("frmSaveGoods").contentWindow.document.body.scrollHeight + "px";		
}
function hideSaveGoods(){
	document.getElementById("frmSaveGoods").style.display = "none";
}
function goZzimList() {
	document.getElementById('frmSaveGoods').src='/view/SaveGoodsList_2010.jsp?tbln=save';
}
function showConv(){
	if (document.getElementById("div_inconv").style.display != "none"){
		document.getElementById("div_inconv").style.display = "none";
		document.getElementById("inconv_txt").value="";
		document.getElementById("inconv_email").value="";		
	}else{
		document.getElementById("inconv_txt").style.backgroundImage="url(http://img.enuri.gscdn.com/images/view/error/error_webFont01.gif)";
		document.getElementById("inconv_email").style.backgroundImage="url(http://img.enuri.gscdn.com/images/view/error/error_webFont02.gif)";
		if(Position.cumulativeOffset($("img_main_conv"))[1]>220){
			document.getElementById("div_inconv").style.top = Position.cumulativeOffset($("img_main_conv"))[1] - 220;
		}else{
			document.getElementById("div_inconv").style.top = Position.cumulativeOffset($("img_main_conv"))[1];
		}
		document.getElementById("div_inconv").style.left = "505px";
		document.getElementById("div_inconv").style.display = "";
		insertLog(2067);
	}
}
// 불편신고 보내기


function noticeInconvenionce(){
	if (document.getElementById("inconv_txt").value.trim().length == 0 ){
		alert("오류내용을 입력해 주십시오.");
		document.getElementById("inconv_txt").focus();
		return;
	}
	if (document.getElementById("inconv_txt").value.trim().korlen() > 500){
		alert("500자 이상 입력하실수 없습니다.")
		document.getElementById("inconv_txt").focus();
		return;		
	}		
	if (document.getElementById("inconv_email").value.trim().length > 0 ){
		if (!document.getElementById("inconv_email").value.trim().isemail()){
			alert("올바른 E-Mail주소를 입력해 주십시오.");
			document.getElementById("inconv_email").focus();
			return;			
		}
	}
	var url = "/include/layer/InsertInconvenience.jsp";
	var param = "inconv_txt="+encodeURIComponent(document.getElementById("inconv_txt").value.trim())+"<BR>"+navigator.userAgent+"<BR>"+getOSInfoStr()+"&inconv_email="+document.getElementById("inconv_email").value;
	var getRec = new Ajax.Request(
		url,
		{
			method:'post',parameters:param,onComplete:showSaveMsg
		}
	);		
	function showSaveMsg(originalRequest){
		//alert(originalRequest.responseText);
		document.getElementById("inconv_txt").value="";
		document.getElementById("inconv_email").value="";
		document.getElementById("div_inconv").style.display = "none";
		alert("불편신고가 접수되었습니다.");
	}
}
function getOSInfoStr(){
	var ua = navigator.userAgent;
	if(ua.indexOf("NT 6.0") != -1) return "Windows Vista/Server 2008";
	else if(ua.indexOf("NT 5.2") != -1) return "Windows Server 2003";
	else if(ua.indexOf("NT 5.1") != -1) return "Windows XP";
	else if(ua.indexOf("NT 5.0") != -1) return "Windows 2000";
	else if(ua.indexOf("NT") != -1) return "Windows NT";
	else if(ua.indexOf("9x 4.90") != -1) return "Windows Me";
	else if(ua.indexOf("98") != -1) return "Windows 98";
	else if(ua.indexOf("95") != -1) return "Windows 95";
	else if(ua.indexOf("Win16") != -1) return "Windows 3.x";
	else if(ua.indexOf("Windows") != -1) return "Windows";
	else if(ua.indexOf("Linux") != -1) return "Linux";
	else if(ua.indexOf("Macintosh") != -1) return "Macintosh";
	else return "";
}
function checkBackground(obj){
	if (obj.value.trim().length == 0 ){
		if (obj.id == "inconv_txt"){
			obj.style.backgroundImage = "url(http://img.enuri.gscdn.com/images/view/error/error_webFont01.gif)";
		}else{
			obj.style.backgroundImage = "url(http://img.enuri.gscdn.com/images/view/error/error_webFont02.gif)";
		}
	}
}	
function showShoppingNoteWorningMsg(type){
	if (!document.getElementById("div_save_msg")){
		if (type == 1 ){
			LeftPos = Position.cumulativeOffset($("MyFavoriteLayerMain"))[0] - 60;
			TopPos = Position.cumulativeOffset($("MyFavoriteLayerMain"))[1] + 40;
		}else{
			var divLayerLeft = Position.cumulativeOffset($("main_body"));
			LeftPos = divLayerLeft[0] + 185;
			TopPos = divLayerLeft[1] + 5;
		}
		var varTag = "<div id='div_save_msg' style='position:absolute;left:"+LeftPos+";top:"+TopPos+";width:185;height:35;background-color:#FFFFFF;'></div>";
		varSaveMsgObj = document.createElement(varTag);
		document.body.appendChild(varSaveMsgObj);
	}else{
		var LeftPos = 0 ;
		var TopPos = 0 ;	
		if (type == 1 ){
			LeftPos = Position.cumulativeOffset($("MyFavoriteLayerMain"))[0] - 60;
			TopPos = Position.cumulativeOffset($("MyFavoriteLayerMain"))[1] + 40;
		}else{
			var divLayerLeft = Position.cumulativeOffset($("main_body"));
			LeftPos = divLayerLeft[0] + 185;
			TopPos = divLayerLeft[1] + 5;
		}
		$('div_save_msg').style.left = 	LeftPos;
		$('div_save_msg').style.top = 	TopPos;
		$('div_save_msg').show();
	}
	if (type == 1 ){
		document.getElementById("div_save_msg").innerHTML = "<img src='http://img.enuri.gscdn.com/images/view/savegoods/recently_no02.gif' border='0' align='absmiddle' border='0' align='absmiddle'>";
	}else if (type == 2){
		document.getElementById("div_save_msg").innerHTML = "<img src='http://img.enuri.gscdn.com/images/view/savegoods/zzim_no02.gif' border='0' align='absmiddle' border='0' align='absmiddle'>";
	}
	new Effect.Fade('div_save_msg', {duration:3.0, from: 3, to: 0});
}
function showZzim(favCnt){
	top.document.getElementById('frmSaveGoods').src='/view/SaveGoodsList.jsp?tbln=save';
	return false;
}
/* floating right */
function Cmd_Tgate(){
	window.open("http://tgate.kca.go.kr/itemCompare/comparison_view.jsp?main=Y&npage=1&main_code=19&sub_main_code=99&seq=1115&product_name=가격비교%20","tgate_pop2","toolbar=yes,menubar=yes,status=yes,location=yes,scrollbars=yes,resizable=yes,top=0,left=0,width="+screen.availWidth+",height="+screen.availHeight);
	//window.open("http://article.joins.com/article/article.asp?total_id=3424469","tgate_pop2","toolbar=yes,menubar=yes,status=yes,location=yes,scrollbars=yes,resizable=yes,top=0,left=0,width="+screen.availWidth+",height="+screen.availHeight);
}
function Top_Logo_Layer(){
	if($("T_Banner_L").style.display == "inline") {
		$("T_Banner_L").style.display = "none";
	} else {
		$("T_Banner_L").style.display = "inline";
	}
}
var logolayerTimer = null;

function Cmd_Logo_Layer(param){
	if (fnGetCookie("Logo_Layer") == "1"){
	 
	}else{
		if(param==1){
			clearTimeout(logolayerTimer);
			$('Logo_Layer').style.display='inline';
		}else if(param==2){
			logolayerTimer = setTimeout("Cmd_Logo_Layer(3)",100);
		}else if(param==3){
			clearTimeout(logolayerTimer);
			if($("T_Banner_L").style.display == "inline") {
				$('Logo_Layer').style.display='inline';	
			}else{
				$('Logo_Layer').style.display='none';	
			}
		}
	}
}
function openDanbiBanner(){
	insertLog(3362);
	var danbi = window.open("http://banner.auction.co.kr/bn_redirect.asp?ID=BN00068236","danbi");
}
function openResellBanner(){
	insertLog(5819);
	location.href="/event/Resell.jsp";
}
function CmdLink(url){
	location.href = url;
}
//이슈뉴스영역
var newswin;
function cmdOpenNews(url,targ){
	newswin = window.open(url,targ,"width=770,height=800,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no,Top=20,left=30");
	newswin.focus();
}
var newsTab = 1; //뉴스탭

var newsPage = 1; //페이지
var newsTimer = null;
var newsInterval = 20000;
function startNews(){
	if(document.getElementById("div_main_news_"+newsTab)){
		document.getElementById("div_main_news_"+newsTab).style.display = "block";
	}
	if(document.getElementById("div_main_news_"+newsTab+"_"+newsPage)){
		document.getElementById("div_main_news_"+newsTab+"_"+newsPage).style.display = "block";
	}
	if(BrowserDetect.OS=="Windows" || BrowserDetect.OS=="Mac" || BrowserDetect.OS=="Linux"){
		newsTimer = setTimeout("cmdNewsNextPage(1)",newsInterval);
	}
}
function cmdGetNewsMaxPage(tab){
	var maxpage = 3;
	if(tab==2){
		//maxpage = 2; //가이드
		maxpage = 1; //가이드
	}else if(tab==3 || tab==4){
		maxpage = 1; //블로그,패션,HIT
	}else if(tab==5){
		maxpage = 2;
	}
	return maxpage;
}
function cmdNewsNextPage(i,f){ //다음페이지로 이동
	clearTimeout(newsTimer);
	var newsMaxPage = cmdGetNewsMaxPage(newsTab);
	document.getElementById("div_main_news_"+newsTab+"_"+newsPage).style.display = "none";
	if(i==1){ //다음 페이지로

		newsPage++;
		if(newsPage>newsMaxPage){ //다음탭으로 이동
			newsPage = 1;
			if(newsTab<5){
				cmdNewsTab(newsTab+1,1,1);
			}else{
				cmdNewsTab(1,1,1);
			}
			return;
		}
	}else{ //이전 페이지로

		newsPage--;
		if(newsPage<=0) newsPage = newsMaxPage;
	}
	try{
		document.getElementById("div_main_news_"+newsTab+"_"+newsPage).style.display = "block";
	}catch(e){
	}
	if(f!=1){
		if(BrowserDetect.OS=="Windows" || BrowserDetect.OS=="Mac" || BrowserDetect.OS=="Linux"){
			newsTimer = setTimeout("cmdNewsNextPage(1)",newsInterval);
		}
	}
}
function cmdNewsGoPage(i){ //페이지 직접선택
	clearTimeout(newsTimer);
	document.getElementById("div_main_news_"+newsTab+"_"+newsPage).style.display = "none";
	newsPage = i;
	document.getElementById("div_main_news_"+newsTab+"_"+newsPage).style.display = "block";
}
function cmdNewsHitPage(i){ //페이지 직접선택
	clearTimeout(newsTimer);
	document.getElementById("div_main_news_"+newsTab+"_"+newsPage).style.display = "none";
	newsPage = i;
	document.getElementById("div_main_news_"+newsTab+"_"+newsPage).style.display = "block";
}
function cmdNewsOver(){
	clearTimeout(newsTimer);
}
function cmdNewsOut(){
	if(BrowserDetect.OS=="Windows" || BrowserDetect.OS=="Mac" || BrowserDetect.OS=="Linux"){
		newsTimer = setTimeout("cmdNewsNextPage(1)",newsInterval);
	}
}
function cmdNewsTab(tab, page, auto){
	if(newsTab==tab) return;
	if(typeof(page)=="undefined"){
		page = 1;
	}
	if(typeof(auto)=="undefined"){
		auto = 0;
	}
	if(auto!=1){
		if(tab==1){ ////뉴스
			insertLog(4996);
		}else if(tab==2){ //가이드
			insertLog(4994);
		}else if(tab==3){ //블로그
			insertLog(6813);
		}else if(tab==4){ //패션
			insertLog(6814);
		}else if(tab==5){ //HIT
			insertLog(5264);
		}
	}
	clearTimeout(newsTimer);
	if(document.getElementById("div_main_news_"+tab).innerHTML==""){
		cmdNewsGetContents(tab,page,auto);
	}else{
		var newsMaxPage = cmdGetNewsMaxPage(tab);
		document.getElementById("div_main_news_"+newsTab).style.display = "none";
		document.getElementById("div_main_news_"+tab).style.display = "block";
		for(j=1;j<=newsMaxPage;j++){
			if(document.getElementById("div_main_news_"+tab+"_"+j)){
				if(j==page){
					document.getElementById("div_main_news_"+tab+"_"+j).style.display = "block";
				}else{
					document.getElementById("div_main_news_"+tab+"_"+j).style.display = "none";
				}
			}
		}
		newsTab = tab;
		newsPage = page;
		if(auto==1){
			newsTimer = setTimeout("cmdNewsNextPage(1)",newsInterval);
		}
	}
}
function cmdNewsGetContents(i,f,auto){
	var url = "/include/main/main2010/Inc_Main_News_Ajax.jsp";
	var param = "tab="+i;
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:showNewsContents
		}
	);
	function showNewsContents(originalRequest){
		document.getElementById("div_main_news_"+i).innerHTML = originalRequest.responseText;
		if(f==1){
			document.getElementById("div_main_news_"+newsTab).style.display = "none";
			document.getElementById("div_main_news_"+i).style.display = "block";
			if(document.getElementById("div_main_news_"+i+"_1")){
				document.getElementById("div_main_news_"+i+"_1").style.display = "block";
			}
			newsTab = i;
			newsPage = 1;
			if(auto==1){
				newsTimer = setTimeout("cmdNewsNextPage(1)",newsInterval);
			}
		}
	}
}
function cmdNewsFashionHot(page){
	for(i=1;i<100;i++){
		if(document.getElementById("main_fashion_pic_"+i)){
			if(i==page){
				document.getElementById("main_fashion_pic_"+i).style.display = "block";
			}else{
				document.getElementById("main_fashion_pic_"+i).style.display = "none";
			}
		}else{
			break;
		}
	}
	clearTimeout(newsTimer);
}
function insertMainNewsLog(idx){ //뉴스로그
	var url = "/include/main/main2010/Inc_Main_News_Log.jsp";
	var param = "idx="+idx;
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param
		}
	);
}
function knowboxLinkByUri(param,wname){
	if (typeof(wname) == "undefined" || wname == null) {
		wname = "";
	}
//	var w = window.screen.width;
//	if(w>=1024 && w<=1036){
//		w = 1012;
//		if(getBrowserName()=="msie6"){
//			w = 1024;
//		}
//	}else if(w>1036){
//		w = 1088;
//		if(getBrowserName()=="msie6"){
//			w = 1100;
//		}	
//	}
//	var h = screen.availHeight;
	var selfH = screen.availHeight ;
	//==============================================================
	//비스타 여부 체크
	//==============================================================
	var IS_VISTA = "0";
	var vistaWidth = 0;
	if(navigator.appName == "Microsoft Internet Explorer") {
		var Agent = navigator.userAgent
		Agent = Agent.toLowerCase();
		if(Agent.indexOf("nt 6.")>0 || Agent=="mozilla/4.0 (compatible; msie 6.0)") {
			IS_VISTA="1";
			// 비스타일경우는 width를 10을 더함
			// vistaWidth = 10;
		}
	}
	try{
		var win = window.open(param,wname,"toolbar=yes,location=yes,left=0,top=0,directories=yes,status=yes,scrollbars=yes,resizable=yes,menubar=yes,personalbar=yes");
			if(IS_VISTA=="1") {
			win.resizeTo(1040, eval(selfH));
		} else {
			win.resizeTo(1030, eval(selfH));
		}
	}catch(e){}
	win.focus();
}
//자동차

var vCh_nation = 0;	//레이어 오버 되면 1
var vNation_Timer;
var vSelected_Section = "1";	//메인 자동차 현재 보이는 레이어번호.
var vBimg_no = ",";	//메인에 사용하는 자동차쪽 에러 모델들.
function fn_show_bimg(obj_name,modelno,img_root,obj){
	if(vBimg_no.indexOf(","+modelno+",")<0){
		$(obj_name).style.display = "inline";
	}else{
		obj.src = img_root+modelno+".gif";
	}
}
function fn_nation_out(param){
	vNation_Timer = setTimeout("fn_nation_timer()",1000);
}

function fn_nation_timer(){
	if(vCh_nation == 0){
		$("main_model_nation").style.display = "none";
		vNation_Timer = clearTimeout();
	}
}

function fn_newwindow(modelno){
	insertLog(5084);
	var varScrollCheckValue = document.body.clientHeight;
	var newwin = window.open("/car/Spec_View.jsp?fr=main&modelno="+modelno,"","menubar=no,toolbar=no,location=no,directories=no,resizable=no,status=no,scrollbars=yes,width=795" + ",height="+ varScrollCheckValue);
	newwin.focus();
	//location.href = "/car/Index.jsp?main=0"+vSelected_Section+"&modelno="+modelno;
}

function fn_car_tab_show(value){
	vSelected_Section = value;
	
	var img_set = "";
	if(value == "3"){
		img_set = "1";
	}else if(value == "4"){
		img_set = "2";
	}else{
		img_set = value;
	}
	if(value != "1"){
		$("main_car_btn_img_1").src = $("main_car_btn_img_1").src.replace("_ov.gif",".gif");
		$("main_car_list_1").style.display = "none";
	}
	if(value != "2"){
		$("main_car_btn_img_2").src = $("main_car_btn_img_2").src.replace("_ov.gif",".gif");
		$("main_car_list_2").style.display = "none";
	}
	if(value != "3"){
		$("main_car_btn_img_3").src = $("main_car_btn_img_3").src.replace("_ov.gif",".gif");
		$("main_car_list_3").style.display = "none";
	}
	if(value != "4"){
		$("main_car_btn_img_4").src = $("main_car_btn_img_4").src.replace("_ov.gif",".gif");
		$("main_car_list_4").style.display = "none";
	}
	$("main_car_btn_img_"+value).src = $("main_car_btn_img_"+value).src.replace("bt0"+img_set+".gif","bt0"+img_set+"_ov.gif");
	$("main_car_list_"+value).style.display = "block";
}

function show_nation_info(param,rowno,part){
	if(part=="p"){
		if($("p_model_nation_"+rowno).innerHTML.length > 100){
			$("main_model_nation").innerHTML = $("p_model_nation_"+rowno).innerHTML;
			$("main_model_nation").style.left = Position.cumulativeOffset(param)[0]-($("main_body").offsetLeft+30)+"px";
			$("main_model_nation").style.top = Position.cumulativeOffset(param)[1]+15+"px";
			$("main_model_nation").style.display = "block";
		}else{ 
			$("main_model_nation").style.display = "none";
		}
	}else{
		if($("f_model_nation_"+rowno).innerHTML.length > 100){
			$("main_model_nation").innerHTML = $("f_model_nation_"+rowno).innerHTML;
			$("main_model_nation").style.left = Position.cumulativeOffset(param)[0]-($("main_body").offsetLeft+40)+"px";
			$("main_model_nation").style.top = Position.cumulativeOffset(param)[1]+15+"px";
			$("main_model_nation").style.display = "block";
		}else{
			$("main_model_nation").style.display = "none";
		}
	}
}
function fn_goCar(){
	insertLog(5083);
	location.href = "/car/Index.jsp?main=0"+vSelected_Section;
	//location.href = "/car/Index.jsp";
}
function cmdShopPlanLink(url){
	var win = window.open(url,'','');
	win.focus();
}
function cmdShopPlanPage(page){
	for(i=1;i<100;i++){
		if(document.getElementById("div_shopplan_"+i)){
			if(i==page){
				document.getElementById("div_shopplan_"+i).style.display = "block";
			}else{
				document.getElementById("div_shopplan_"+i).style.display = "none";
			}
		}else{
			break;
		}
	}
}
//에누리에 다있다

function CmdLinkAllOfEnuri(url){
	insertLog(4683);
	location.href = url;
}
//투표
var pollPage = 1; //페이지
var pollMaxPage = 1;
var pollTimer = null;
var pollInterval = 10000;
function startPoll(){
	pollTimer = setTimeout("cmdPollNextPage()",pollInterval);
}
function cmdPollOver(){
	clearTimeout(pollTimer);
}
function cmdPollOut(){
	pollTimer = setTimeout("cmdPollNextPage()",pollInterval);
}
function cmdPollNextPage(){
	clearTimeout(pollTimer);
	var nextPage = pollPage+1;
	if(nextPage>pollMaxPage) nextPage = 1;
	cmdPollGoPage(nextPage);
	pollTimer = setTimeout("cmdPollNextPage()",pollInterval);
}
function cmdPollGoPage(idx){
	document.getElementById("poll_article_"+pollPage).style.display = "none";
	document.getElementById("poll_article_"+idx).style.display = "block";
	pollPage = idx;
}
function cmdOpenPoll(idx,jflag){
	var obj = eval("document.frmPoll_"+idx);
	var poll_idx = obj.idx.value;
	var article_idx = 0;
	for(i=0;i<10;i++){
		if(obj.article_idx[i]){
			if(obj.article_idx[i].checked){
				article_idx = obj.article_idx[i].value;
				break;
			}
		}else{
			break;
		}
	}
	if(jflag==0){
		article_idx = 0;
	}
	insertLog(4685);
	var selfH = window.screen.availHeight;
	Main_OpenWindow("/knowbox/Poll.jsp?idx="+poll_idx+"&article_idx="+article_idx,"enuri_poll",800,selfH,"yes","no",30,0);
}
//우측 이슈박스 : 패션,소셜/반값,여행
var riTab = 1; //뉴스탭

var riTimer = null;
var riInterval = 15000;
function startRightIssue(){
	if(BrowserDetect.OS=="Windows" || BrowserDetect.OS=="Mac" || BrowserDetect.OS=="Linux"){
		riTimer = setTimeout("cmdRiNextTab()",riInterval);
	}
}
function cmdRiNextTab(){
	clearTimeout(riTimer);
	document.getElementById("div_right_issue_"+riTab).style.display = "none";
	riTab++;
	if(riTab>5){ //다음탭으로 이동
		riTab = 1;
	}
	cmdRightIssueTab(riTab);
	if(BrowserDetect.OS=="Windows" || BrowserDetect.OS=="Mac" || BrowserDetect.OS=="Linux"){
		riTimer = setTimeout("cmdRiNextTab()",riInterval);
	}
}
function cmdRiOver(){
	clearTimeout(riTimer);
}
function cmdRiOut(){
	if(BrowserDetect.OS=="Windows" || BrowserDetect.OS=="Mac" || BrowserDetect.OS=="Linux"){
		riTimer = setTimeout("startRightIssue()",500);
	}
}
function cmdRightIssueTab(tab){
	for(i=1;i<=5;i++){
		if(i==tab){
			if(document.getElementById("div_right_issue_"+i)){
				riTab = i;
				document.getElementById("div_right_issue_"+i).style.display = "block";
			}
		}else{
			if(document.getElementById("div_right_issue_"+i)){
				document.getElementById("div_right_issue_"+i).style.display = "none";
			}
		}
	}
}
function cmdGoPopFashion(shopcode,plno,url){
	var win = window.open("/move/Redirect.jsp?type=ex&cmd=move_fashion&vcode="+shopcode+"&pl_no="+plno+"&notToday=Y&url="+url);
	win.focus();
}
function cmdGoPopFashionMall(shopcode,plno,url,from){
	var obj = document.fmGotoMall;
	obj.type.value = "ex";
	obj.cmd.value = "move_fashion";
	obj.vcode.value = shopcode;
	obj.modelno.value = "";
	obj.price.value = "";
	obj.url.value = url;	
	obj.cate.value = "";
	obj.pl_no.value = plno;
	obj.imgurl.value = "";
	obj.notToday.value = "Y";
	obj.from.value = from;
	obj.submit();
}
function insertMainFashionLog(idx){
	var url = "/include/main/main2010/Inc_Main_Fashion_Log.jsp";
	var param = "idx="+idx;
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param
		}
	);
}
//여행 긴급모객
function cmdTourGoPage(idx){
	for(i=1;i<10;i++){
		if(document.getElementById("ri_tour_"+i)){
			document.getElementById("ri_tour_"+i).style.display = "none";
		}
	}
	document.getElementById("ri_tour_"+idx).style.display = "block";
}
function cmdTravelRedirect(param, nocpc){
	insertLog(5146);
	var w = window.screen.width;
	var h = screen.availHeight;
	if (nocpc){
		var win = window.open("/move/Redirect_Tour.jsp?model_subno="+param+"&nocpc=Y","_blank");
	}else{
		var win = window.open("/move/Redirect_Tour.jsp?model_subno="+param,"_blank");
	}
	win.focus();
}
function cmdTourTextOver(idx){
	if(idx){
		document.getElementById("ri_tour_name_"+idx).style.textDecoration = "underline";
		document.getElementById("ri_tour_date_"+idx).style.textDecoration = "underline";
	}
}
function cmdTourTextOut(idx){
	if(idx){
		document.getElementById("ri_tour_name_"+idx).style.textDecoration = "none";
		document.getElementById("ri_tour_date_"+idx).style.textDecoration = "none";
	}
}

//발렌타인


function fa_1() {
	var w = window.screen.width;
	if(w>=1024 && w<=1036){
		w = 1012;
		if(getBrowserName()=="msie6"){
			w = 1024;
		}
	}else if(w>1036){
		w = 1088;
		if(getBrowserName()=="msie6"){
			w = 1100;
		}	
	}
	var h = screen.availHeight;
	var objfa_1 = window.open("/view/Listmp3.jsp?cate=0408","objfa_1", "top=0, left=0, channelmode=0, directories=1, fullscreen=0, location=1, menubar=1, resizable=1, scrollbars=1, status=1, titlebar=1, toolbar=1");
	objfa_1.focus();
}

function fa_2() {
	var objfa_2 = window.open("/view/Listmp3.jsp?cate=101014","objfa_2", "top=0, left=0, channelmode=0, directories=1, fullscreen=0, location=1, menubar=1, resizable=1, scrollbars=1, status=1, titlebar=1, toolbar=1");
	objfa_2.focus();
}

function fa_3() {
	var objfa_3 = window.open("/view/Listmp3.jsp?cate=090504","objfa_3", "top=0, left=0, channelmode=0, directories=1, fullscreen=0, location=1, menubar=1, resizable=1, scrollbars=1, status=1, titlebar=1, toolbar=1");
	objfa_3.focus();
}

function fa_4() {
	var objfa_4 = window.open("/view/Listmp3.jsp?cate=15010502","objfa_4", "top=0, left=0, channelmode=0, directories=1, fullscreen=0, location=1, menubar=1, resizable=1, scrollbars=1, status=1, titlebar=1, toolbar=1");
	objfa_4.focus();
}

function fa_5() {
	var objfa_5 = window.open("/view/Listmp3.jsp?cate=0923","objfa_5", "top=0, left=0, channelmode=0, directories=1, fullscreen=0, location=1, menubar=1, resizable=1, scrollbars=1, status=1, titlebar=1, toolbar=1");
	objfa_5.focus();
}

function fa_6() {
	var objfa_6 = window.open("/view/Listmp3.jsp?cate=083211","objfa_6", "top=0, left=0, channelmode=0, directories=1, fullscreen=0, location=1, menubar=1, resizable=1, scrollbars=1, status=1, titlebar=1, toolbar=1");
	objfa_6.focus();
}

function fa_7() {
	var objfa_7 = window.open("/view/Listmp3.jsp?cate=091902","objfa_7", "top=0, left=0, channelmode=0, directories=1, fullscreen=0, location=1, menubar=1, resizable=1, scrollbars=1, status=1, titlebar=1, toolbar=1");
	objfa_7.focus();
}

function fa_8() {
	var objfa_8 = window.open("/view/fusion/Fusion.jsp?cate=1452&factory=&in_keyword=","objfa_8", "top=0, left=0, channelmode=0, directories=1, fullscreen=0, location=1, menubar=1, resizable=1, scrollbars=1, status=1, titlebar=1, toolbar=1");
	objfa_8.focus();
}

function fa_9() {
	var objfa_9 = window.open("/view/fusion/Fusion_Masterpiece.jsp?cate=145901&in_keyword=","objfa_9", "top=0, left=0, channelmode=0, directories=1, fullscreen=0, location=1, menubar=1, resizable=1, scrollbars=1, status=1, titlebar=1, toolbar=1");
	objfa_9.focus();
}

function fnSetCookie_5( name, value, expiredays ){
    var todayDate = new Date();
    todayDate.toGMTString()
    todayDate.setDate( todayDate.getDate() + expiredays );
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
    document.getElementById("Val_layer").style.display = "none";
}

function fam_layer_popShow() {
	if($("fam_layer").style.display=="none") {
		$("fam_layer").style.display = "";
	} else {
		fam_layerClose();
	}
}

function M_layerShow() {
	if($("M_layer").style.display=="none") {
		$("M_layer").style.display = "";
	} else {
		M_layerClose();
	}
}


function layer_none() {
	var newDate = new Date();
	var url = "/include/ajax/AjaxSetSession.jsp";
	var param = "sname=chk5m&svalue="+newDate.getTime();
	var setSession = new Ajax.Request(
		url,
		{
			method:'get',parameters:param
		}
	);
}

function M_layerClose() {
	$("M_layer").style.display = "none";
}

function MAnd_go() {
	location.href = "https://market.android.com/details?id=com.enuri.android&feature=search_result#?t=W251bGwsMSwxLDEsImNvbS5lbnVyaS5hbmRyb2lkIl0.";
}

function enuri_go() {
	location.href = "http://m.enuri.com";
}

function Mac_go() {
	location.href = "http://itunes.apple.com/kr/app/enuriapp/id476264124?l=ko&ls=1&mt=8";
}


function IE6_layer_go() {
	location.href = "http://windows.microsoft.com/ko-KR/internet-explorer/downloads/ie-8";
}

function fam_layerClose() {
	$("fam_layer").style.display = "none";
}


function hideAutoComLayer(){
    document.getElementById('ac_layer_main').style.display='none';
}
