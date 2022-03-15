<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/include/Base_Inc.jsp"%>
<%@ page import="com.enuri.include.RandomMain"%>
<%
String strKeywordTop = ChkNull.chkStr(request.getParameter("keyword"),"");//키워드
String strSearchKindTop =ConfigManager.RequestStr(request,"searchkind",""); //(1:에누리,  3:미등록쇼핑몰,4:식품,5:의류)
String strSearchKindTitileTop = "";

if (strSearchKindTop.trim().equals("1")){
	strSearchKindTitileTop = "일반상품";
}else if(strSearchKindTop.trim().equals("3")){
	strSearchKindTitileTop = "미등록 상품";
}else if(strSearchKindTop.trim().equals("4")){
	strSearchKindTitileTop = "식품";
}else if(strSearchKindTop.trim().equals("5")){
	strSearchKindTitileTop = "의류";
}

boolean bExLink = false;
if (request.getRequestURI().indexOf("Smilecat.jsp") >= 0 || request.getRequestURI().indexOf("Paxinsu.jsp") >= 0 || request.getRequestURI().indexOf("Flower_Easyflower.jsp") >= 0){
	bExLink = true;
}
boolean bMain = true;
RandomMain ranMain = new RandomMain();
int intRan = ranMain.getRandomValue(10);
intRan = intRan + 1;
if (!request.getServletPath().trim().equals("/Index.jsp")){
	intRan = 10;
}
if (!request.getServletPath().trim().equals("/Index.jsp") && !request.getServletPath().trim().equals("/search/Searchlist.jsp")){
	bMain = false;
}

String strIsFashion = "";
if (request.getRequestURI().indexOf("/fashion/Fashion_") >= 0){
	strIsFashion = "Y";
}
//int intRan = 9;

%>
<style type="text/css">
<!--
.search_menu {
  background-color: #F2FDFF;
  border: 1px solid;
  border-color: #3762A1 #3762A1 #3762A1 #3762A1;
  padding: 0px;
  position: absolute;
  text-align: left;
  width:100;
  overflow-x:hidden;
  overflow-y:auto;
  left:866px;
  top:21px;
  z-index:50;
}
a.menuButton_search {
	  background-color: transparent;
	  border: 1px solid #c0c0c0;
	  color: #000000;
	  cursor: hand;
	  font-family: "굴림";
	  font-size: 8pt;
	  font-style: normal;
	  font-weight: normal;
	  margin: 0px;
	  padding: 0px 0px 0px 0px;
	  position: relative;
	  left: 0px;
	  text-decoration: none;
	  width:100%;
	  height:100%;
	  valign:middle;
}
-->
</style>
<script language="JavaScript">
<!--
	function MM_reloadPage(init) {  //reloads the window if Nav4 resized
	  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
	    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
	  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
	}
	MM_reloadPage(true);

	function MM_findObj(n, d) { //v4.01
	  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
	    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
	  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
	  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
	  if(!x && d.getElementById) x=d.getElementById(n); return x;
	}
	function MM_showHideLayers() { //v6.0		
	  var i,p,v,obj,args=MM_showHideLayers.arguments;
	  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
	    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
	    obj.visibility=v; }
	}
	function MM_swapImgRestore() { //v3.0
	  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
	}
	function MM_preloadImages() { //v3.0
	  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
	    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
	    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
	}
	function MM_swapImage() { //v3.0
	  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
	   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
	}
	function MM_xPopJumpMenu_R(targ){ //v3.0
		pop = window.open('', 'pop','');
		pop.location.href = eval("'"+targ+"'");
	}

	function MM_xPopJumpNDelCookie(url, target){
		RemoveDomainCookie('SSO_BINDADDR');
		RemoveDomainCookie('SSO_FROMSITE'); 
		pop = window.open(url, target);
	}
	function MM_xPopJumpNDelCookie_NoEnc(url, target){
		RemoveDomainCookie('SSO_BINDADDR');
		RemoveDomainCookie('SSO_FROMSITE'); 
		pop = XecureNavigate_NoEnc(url, target);
	}
//-->
</script>
<script language='javaScript'>
<!--
function SearchLayerCmdMouseOver(Obj,n)
{
	if(n==1)//onmouseover
	{
		Obj.style.backgroundColor="#08246B";
		Obj.style.color="#FFFFDD";
	}
	else
	{
		Obj.style.backgroundColor="#FFFFFF";
		Obj.style.color="#000000";
	}
}
function showTopSearchLayer(){
	if (document.getElementById("LayerSearchKindSelectTop") != null){
		if (document.getElementById("LayerSearchKindSelectTop").style.display == "none"){
			document.getElementById("LayerSearchKindSelectTop").style.display = "inline";
		}else{
			document.getElementById("LayerSearchKindSelectTop").style.display = "none";
		}
	}
}

function close_layer(){
	document.getElementById("LayerSearchEmpty").style.display="none";
}

function Open_guide(){
	OpenWindowNo_bar('<%=ConfigManager.IMG_ENURI_COM%>/html/search/search_guide.htm','winguide','624','700');
	close_layer();
}

function OpenWindowNo_bar(OpenFile,winname,nWidth,nHeight)
{
	window.open(OpenFile,winname,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars=yes,resizable=no,menubar=no");
}

var varOnOff = "";
function noSale(onoff)
{
	if (document.fmMainSearch.keyword.value.trim().length > 0 ){
		varOnOff = onoff;
		Cmd_Login();
	}else{
		alert("2자 이상의 검색어를 넣으세요(특수문자는 제외 됩니다)~~");
	}
}
var nosalewin = null;
function Cmd_Login()
{
	if(islogin()){
		/*
		var nosale = window.open("about:blank","nosale","left=100,top=100,width=795,height=710,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=no,menubar=no");
		if (nosale == null)
		{
			document.getElementById("div_NoSale").style.display="inline";
		}
		else
		{
			document.getElementById("div_NoSale").style.display="none";
			document.frmList_login.keyword.value = document.fmMainSearch.keyword.value;
			frmList_login.page.value='';
			document.frmList_login.nosale.value=varOnOff;
			document.frmList_login.key.value="POPULAR+DESC";
			document.frmList_login.pagesize.value="100";
			frmList_login.searchkind.value=1;
			frmList_login.target = "nosale";
			fnSendData_Login('/search/Searchlist.jsp');
			document.frmList_login.nosale.value="";
		}
	<%
		if (bExLink){
	%>
		frmMainLogin.location.href='/login/Loginstatus.jsp?exlink=Y';
	<%
		}else{
			if (bMain){
	%>
		frmMainLogin.location.href='/login/Loginstatus.jsp?main=Y';
	<%
			}else{
	%>
		frmMainLogin.location.href='/login/Loginstatus.jsp';
	<%			
			}
		}
	%>			
		IFrameMyFavoriteList.location.href='/include/Incmyfavoritelistmain.jsp';
		IFrameMyNegoList.location.href='/include/Incnegomylistmain.jsp';
		*/
		document.frmList_login.keyword.value = document.fmMainSearch.keyword.value;
		frmList_login.page.value='';
		document.frmList_login.nosale.value=varOnOff;
		document.frmList_login.key.value="POPULAR+DESC";
		document.frmList_login.pagesize.value="100";
		frmList_login.searchkind.value=1;
		fnSendData_Login('/search/Searchlist.jsp');
		document.frmList_login.nosale.value="";
					
	}else{
		var wins = window.open("","ENURI_LOGIN","width=372, height=230; resizable=yes");
		var obj = document.fmKbLogin;
		obj.action="/login/Loginpop.jsp";
		obj.cmd.value = "function";
		obj.gubun.value = "search";
		obj.target="ENURI_LOGIN";
		obj.submit();
		wins.focus();
	}
}
function hideNoSale()
{
	document.getElementById("div_NoSale").style.display="none";
}

function fnSendData_Login(strActionName)
{
	document.frmList_login.action = strActionName;
	document.frmList_login.submit();
	document.frmList_login.target = "_self";
}
//-->
</script>
<%
	String strTopAllMenu01 = "";
	if (bMain){
		strTopAllMenu01 = "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2007/top_allmenu_01_main_0822.gif' align='absmiddle' border='0' style='position:absolute;left:0px; top:15px;' id='top_login_right_menu'>" ;
	}else{
		strTopAllMenu01 = "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2007/search_list_left_0823.gif' align='absmiddle' border='0' style='position:absolute;left:0px; top:0px;' id='top_login_right_menu'>" ;
	}
%>

<div id="LayerLoginMain" style="position:absolute;left:773px; top:0px; width:<%=strIsFashion.equals("Y")?"223":"208"%>px; height:42px; z-index:0; border-width:1px; overflow:hidden; " >
	<%=strTopAllMenu01%>
	<iframe id="frmMainLogin" name="frmMainLogin" src="/login/Loginstatus_tmp.jsp?isfashion=<%=strIsFashion%>&keyword=<%=strKeywordTop%>&searchkind=<%=strSearchKindTop%><%if (bExLink){out.print("&exlink=Y");}%><%if (bMain){out.print("&main=Y");}%>" frameborder=0  style="margin-left:7px;width:227px;height:42px;overflow:hidden;" ></iframe>
</div>

<div id="LayerSearchEmpty" style="z-index:99;top:250;left:400;position:absolute;display:none;">
	<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/Search/warning.gif" border="0" usemap="#Mapsearch">
	<map name="Mapsearch">
	  <area shape="rect" coords="238,67,269,84" href="javascript:Open_guide();"><!--안내-->
	  <area shape="rect" coords="240,110,342,131" href="javascript:close_layer();noSale('NO')">
	  <area shape="rect" coords="151,144,200,166" href="javascript:close_layer();"><!--확인-->
	  <area shape="rect" coords="323,5,345,26" href="javascript:close_layer();">
	</map>
</div>
<%
	if ( ((ChkNull.chkStr(request.getParameter("from"),"").equals("search") && !ChkNull.chkStr(request.getParameter("cate_keyword"),"").equals("Y")) || (ChkNull.chkStr(request.getParameter("gate_keyword"),"").equals("Y"))) && !ChkNull.chkStr(request.getParameter("nosale"),"").equals("NO") ){
%>
<script language="javaScript">
function goEnuriGuide(){
	//window.open("/etc/guide/Enuriguide.jsp","_blank","");
	window.open("/etc/guide/Enuriguide.jsp?cmd=enuriguide&step=&infoPage=no","","width=767,height=625,toolbar=no,directories=no,status=no,scrollbars=no,resizable=yes,menubar=no");
}
function hideKeywordPopup(){
	document.getElementById("LayerKeywordPopup").style.display = "none";
}
function goEnuriShoppingGuide(){
	window.open("/etc/guide/Enuriguide.jsp?cmd=shoppingguide&step=&infoPage=no","","status=1,toolbar=no,resizable=no,scrollbars=1,menubar=no, width=632, height=565");
}
</script>
<div id="LayerKeywordPopup" style="z-index:99;top:247;left:150;position:absolute;display:inline;">
	<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/etc/key_layer0510.gif" border="0" usemap="#MapKeyword">
	<map name="MapKeyword">
	<!--닫기버튼-->
	  <area shape="rect" coords="451,10,476,31" href="#" onClick="hideKeywordPopup()">
	<!--초보자가이드-->
	  <area shape="rect" coords="329,80,432,100" href="#" onClick="goEnuriGuide();">
	<!--인터넷쇼핑몰불안하세요?-->
	  <area shape="rect" coords="15,120,160,138" href="#" onClick="goEnuriShoppingGuide();">
	</map>	
</div>
<%
	}
%>	
<div id='div_NoSale' style="z-index:99;top:250;left:400;position:absolute;display:none;">
	<table width="362" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/Search/pop_img_01.gif" width="362" height="30" border="0" usemap="#Map"></td>
	  </tr>
	  <tr>
	    <td><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/Search/pop_img_02.gif" width="362" height="120"></td>
	  </tr>
	  <tr>
	    <td height="32" align="center" background="<%=ConfigManager.IMG_ENURI_COM%>/images/Search/pop_img_04.gif"><a href="javaScript:Cmd_Login();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','http://img.enuri.gscdn.com/images/Search/search_02.gif',1)"><img src="http://img.enuri.gscdn.com/images/Search/search_01.gif" name="Image4" width="108" height="19" border="0"></a></td>
	  </tr>
	  <tr>
	    <td><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/Search/pop_img_03.gif" width="362" height="41" border="0" usemap="#Map2"></td>
	  </tr>
	</table>
	<map name="Map">
	  <area shape="rect" coords="330,5,351,27" href="javaScript:hideNoSale();">
	</map>
	<map name="Map2">
	  <area shape="rect" coords="297,8,346,30" href="javaScript:hideNoSale();">
	</map>
</div>
<form name="frmList_login"  method="get" target="_self" style="margin:0;">
	<input type="hidden" name="searchtype" value="enuri">
	<input type="hidden" name="searchkind" value="0"><!--검색종류 0:통합검색, 1:에누리검색, 2:에누리외검색, 3:지식통검색-->
	<input type="hidden" name="key" value="POPULAR+DESC">
	<input type="hidden" name="pagesize" value="100">
	<input type="hidden" name="page" value="">
	<input type="hidden" name="nosale" value="OFF">
	<input type="hidden" name="cmd" value="imglist">
	<input type="hidden" name="from" value="search">
	<input type="hidden" name="orgkeyword" value="">
	<input type="hidden" name="logkeyword" value="">
	<input type="hidden" name="keyword" value="">
</form>
<form name="fmKbLogin" action="/login/Loginpop.jsp" style="margin:0;">
	<input type=hidden name="rtnurl" value="">
	<input type=hidden name="rtntarget" >
	<input type=hidden name="cmd" >
	<input type="hidden" name="gubun" value="">
</form>


<!--자동완성 기능-->
<script language=javascript src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/autocom_search_2007.js"></script>
<script language=javascript>
<!--
var oT = null;
 
function oT_Init(){
	try{
		
		if(oT == null){
			oT = new Tom();
		}
		var o = oT;
		if(o.oForm==null){
			o.oForm = document.fmMainSearch;
		}
		if(o.sCollection==null){
			o.sCollection = o.oForm.c.value;
		}
		if(o.oKeyword==null){
			o.oKeyword = o.oForm.keyword;//document.getElementById("keyword");
		}
		o.oKeyword.setAttribute("autocomplete","off"); 
		if(o.oAc_lyr==null){
			o.oAc_lyr = document.getElementById("ac_layer");
		}
		if(o.oAc_ifr==null){
			o.oAc_ifr = document.getElementById("ifr_ac");	
		}
		/*
		if(o.oImg_Toggle == null){
			o.oImg_Toggle = document.getElementById("ac_img");
		}
		*/
		o.oAc_lyr.style.left  = calculateOffsetLeft(o.oKeyword)-3 + "px";
		o.oAc_lyr.style.top   = (calculateOffsetTop(o.oKeyword)+ o.oKeyword.offsetHeight-1)+ "px";
		o.oAc_lyr.style.width = (o.oKeyword.offsetWidth-2+44+16+3) + "px";
		o.oAc_lyr.style.display = "none" ;
		o.oAc_ifr.style.width = (o.oKeyword.offsetWidth-2+44+16+3) + "px";
		o.oAc_ifr.style.display = "block";				
		//o.oImg_Toggle.style.left = calculateOffsetLeft(o.oKeyword)+20 + o.oKeyword.offsetWidth - 20;
		//o.oImg_Toggle.style.top  = calculateOffsetTop(o.oKeyword)  + o.oKeyword.offsetHeight -20+5;
		o.sSubmitFunctionName = "Cmd_MainSearchSubmit()";
	}catch(e){
		setTimeout("oT_Init()", 1000);
	}
}

function oT_search(){
	try{
		if(oT==null){
			oT_Init();
		}
		var o = oT;
		var e = window.event;
		var obj = document.frames(o.oAc_ifr.name);
		if(e.keyCode==40){
			obj.Jerry_next();
		}else if(e.keyCode==38){
			obj.Jerry_prev();
		}else if(e.keyCode==37){
		}else if(e.keyCode==39){
		}else if(e.keyCode==13){
		}else{
			setTimeout("oT.find()", o.TimerInterval);
		}		
	}catch(e){		
	}	
}

//window.onload=Tom_Init;
//-->
</script>

<!-- 
<img id="ac_img" name="ac_img"  border=0  
	src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/search_arr_on.gif" 
	onclick="oT.toggle();"
	style="position:absolute;top:0;left:0;z-index:100;cursor:pointer;">
 -->


<script language=javascript>
<!--
function Cmd_MainSearch1(){
	var schWrd;
	var obj = document.fmMainSearch; 
	schWrd = obj.keyword.value;
	schWrd = replace2(schWrd, "'");		
	schWrd = replace2(schWrd, "\"");				
	schWrd = schWrd.trim();		
	var schLen;
	var schWrdExp;
	schWrdExp = schWrd;
    schWrdExp = replace2(schWrdExp, "^");
    schWrdExp = replace2(schWrdExp, "&");
    schWrdExp = replace2(schWrdExp, "~");
    schWrdExp = replace2(schWrdExp, "!");
    schWrdExp = replace2(schWrdExp, "@");
    schWrdExp = replace2(schWrdExp, "$");
    schWrdExp = replace2(schWrdExp, "%");
    schWrdExp = replace2(schWrdExp, "*");
    schWrdExp = replace2(schWrdExp, "+");
    schWrdExp = replace2(schWrdExp, "=");
    schWrdExp = replace2(schWrdExp, "\\");
    schWrdExp = replace2(schWrdExp, "{");
    schWrdExp = replace2(schWrdExp, "}");
    schWrdExp = replace2(schWrdExp, "[");
    schWrdExp = replace2(schWrdExp, "]");
    schWrdExp = replace2(schWrdExp, ":");
    schWrdExp = replace2(schWrdExp, ";");
    schWrdExp = replace2(schWrdExp, "/");
    schWrdExp = replace2(schWrdExp, "<");
    schWrdExp = replace2(schWrdExp, ">");
    schWrdExp = replace2(schWrdExp, "."); 
    schWrdExp = replace2(schWrdExp, ",");
    schWrdExp = replace2(schWrdExp, "?");
    schWrdExp = replace2(schWrdExp, "(");
    schWrdExp = replace2(schWrdExp, ")");
    schWrdExp = replace2(schWrdExp, "'");
    schWrdExp = replace2(schWrdExp, "_");
    schWrdExp = replace2(schWrdExp, "-");
    schWrdExp = replace2(schWrdExp, "`");
    schWrdExp = replace2(schWrdExp, "|");
    schWrdExp = schWrdExp.trim();
	schLen = schWrdExp.length;	
	
	var varExpKeyWord = "쌀콩팥배감귤무밤잣햄물차굴게김깨탕국빵떡전엿껌죽솥칼휠옙잼쨈팩숯톱숄뮬힐맥놈쌤";
	if (schWrd == "에누리 오픈마켓"){
		window.open("http://www.enuri.com/minishop/Ms_List_Solo_All_Main.jsp","_blank","width="+window.screen.availWidth+",height="+window.screen.availHeight+",toolbar=yes,directories=no,status=yes,scrollbars=yes,resizable=yes,menubar=yes,location=yes");
		return false;
	}	
	if (obj.nosearchkeyword.value != "Y"){
		if(schLen < 2 && obj.searchkind.value != "4" ){
			if (schLen == 1 && obj.searchkind.value == "" && varExpKeyWord.indexOf(schWrd) >= 0 ){
				obj.searchkind.value = "4";
			}else{
				alert("2자 이상의 검색어를 넣으세요(특수문자는 제외 됩니다)~~");
				obj.searchkind.value = "";
				obj.keyword.focus();
				return false;
			}
		}
		obj.keyword.value = schWrd;
		if (obj.searchkind.value == ""){
			obj.target = "ifrmMainSearch";
			obj.action = "/search/GetcountSearchAll.jsp";
		}else{
			obj.target = "_top";
			obj.action = "/search/Searchlist.jsp";
		}			
	}else{
		obj.target = "_top";
		obj.action = "/search/Searchlist.jsp";		
	}
	

	
	return true;
	
	//alert("죄송합니다.\r\n\r\n현재 검색서버의 장애로 검색이 되지 않고 있습니다.\r\n\r\n불편하시더라도 메뉴를 이용하여 주시기 바랍니다.\r\n\r\n조속히 정상화 되도록 최선을 다하겠습니다.	");	
	//return false;																				
}	

function replace2(src, delWrd){
	var newSrc;
		newSrc = "";
	var i;
	for(i=0;i<src.length;i++){
		if(src.charAt(i) == delWrd) {
			newSrc = newSrc + " ";
		}else{
			newSrc = newSrc + src.charAt(i);
		}			
	}
	return newSrc;
}

function Cmd_MainSearchSubmit(){
		
	var obj = document.fmMainSearch; 
	schWrd = obj.keyword.value;
	var adSearch = <%=intRan%>;
	
	if (schWrd.trim().length == 0 && adSearch != 10 && obj.keyword.style.backgroundImage != "url(<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/main_search_cbg.gif)"){
		var searchUrl = "";
		if (adSearch == 1 ){
			searchUrl = "/view/plan/Plan_List.jsp?lstType2=Sub2&lstCategory=02";
			ifrmLog.location.href="/view/Loginsert.jsp?kind=299";
		}else if (adSearch == 2 ){
			searchUrl = "/view/plan/Plan_List.jsp?lstType2=Sub2&lstTitle=임신/출산&lstPpno=9";
			ifrmLog.location.href="/view/Loginsert.jsp?kind=300";
		}else if (adSearch == 3 ){
			searchUrl = "/view/List.jsp?cate=2113&menu=false&flag=&islist=";
			ifrmLog.location.href="/view/Loginsert.jsp?kind=288";
		}else if (adSearch == 4 ){
			searchUrl = "/view/List.jsp?cate=111110&menu=false&flag=&islist=";
			ifrmLog.location.href="/view/Loginsert.jsp?kind=301";
		}else if (adSearch == 5 ){
			searchUrl = "/view/List.jsp?cate=080213&menu=false&flag=&islist=";
			ifrmLog.location.href="/view/Loginsert.jsp?kind=302";
		}else if (adSearch == 6 ){
			searchUrl = "/view/plan/Plan_List.jsp?lstType2=Sub2&lstCategory=04";
			ifrmLog.location.href="/view/Loginsert.jsp?kind=291";
		}else if (adSearch == 7 ){
			searchUrl = "/view/plan/Plan_List.jsp?lstType2=Sub2&lstTitle=혼수기획전&lstPpno=9";
			ifrmLog.location.href="/view/Loginsert.jsp?kind=303";
		}else if (adSearch == 8 ){
			searchUrl = "/view/plan/Plan_List.jsp?lstType2=Sub2&lstCategory=05";
			ifrmLog.location.href="/view/Loginsert.jsp?kind=293";
		}else if (adSearch == 9 ){
			searchUrl = "/view/List.jsp?cate=091401&menu=false&flag=&islist=";
			ifrmLog.location.href="/view/Loginsert.jsp?kind=304";
		}
		location.href = searchUrl;
		//window.open(searchUrl,"_blank","width="+window.screen.availWidth+",height="+window.screen.availHeight+",top=0,left=0,toolbar=yes,directories=no,status=yes,scrollbars=yes,resizable=yes,menubar=yes,location=yes");
		return;
	}
	else{	
		var return_a = Cmd_MainSearch1();
		if(return_a==true){
			document.fmMainSearch.submit();
		}
	}
}

function fnGetCountSearchAll(varCount,varSearchkind){
	var obj = document.fmMainSearch;
	/*
	if (varCount > 0 ){
		obj.target = "_top";
		obj.searchkind.value = varSearchkind;
		obj.action = "/search/Searchlist.jsp";
		obj.submit();
	}else{
		document.getElementById("LayerSearchEmpty").style.display="block";
		document.getElementById("frmList_login").keyword.value=obj.keyword.value;
		document.getElementById("frmList_login").orgkeyword.value=obj.keyword.value;
		document.getElementById("frmList_login").logkeyword.value=obj.keyword.value;
	}
	*/
	obj.target = "_top";	
	if (varCount > 0 ){
		obj.searchkind.value = varSearchkind;
	}else{
		obj.searchkind.value = "1";
	}	
	if (varSearchkind == "3"){
		obj.es.value = "no";
	}
	obj.action = "/search/Searchlist.jsp";
	obj.submit();	
}	


//베스텍 관련 activeX 안내팝업 by hsw 2005.10.11
function b2c_plugin_chk(num)
{
	if(num=="1")
	{
	    var obj = window.open("/escrow/myenuri/b2c_plugin_chk.jsp?step=1","plugin_chk","width=600, height=400; resizable=no");
		obj.focus();
	}
	else
	{
	    var obj = window.open("/escrow/myenuri/b2c_plugin_chk.jsp?step=3","plugin_chk","width=600, height=400; resizable=no");
		obj.focus();
	}

}

function goMyPage(url)
{
	parent.top.location.href=url;
}
function changeStyle(obj){
	//obj.value = "";
	obj.style.color ="#FF0000";
	obj.style.backgroundImage ='url(<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/list_search_02_0823.gif)';
	obj.style.backgroundRepeat = 'repeat-x';
}
//-->
</script>
<%
	String strKeyWordStyle = "";
	String strKeywordInit = "";
	String strSearchBackGround = "";
	String strSearchBackGroundRepeat = "";
	if (strKeywordTop.trim().length() > 0 ){
		strKeyWordStyle = "color:#FF0000;";
		strKeywordInit = strKeywordTop;
		//strSearchBackGround = ConfigManager.IMG_ENURI_COM + "/images/main_2007/main_search_cbg.gif";
		strSearchBackGround = ConfigManager.IMG_ENURI_COM + "/images/main_2007/search_left_txt_0605_1.gif";
		
		strSearchBackGroundRepeat = "repeat-x";		
	}else{
		strKeyWordStyle = "color:#619BAC;";
		strKeywordInit = "";
		if (intRan != 10 ){
			strSearchBackGround = ConfigManager.IMG_ENURI_COM + "/images/main_2007/new_ad_searchtxt_0"+intRan+".gif";
		}else{
			strSearchBackGround = ConfigManager.IMG_ENURI_COM + "/images/main_2007/list_search_02_text_0823.gif";
		}
		strSearchBackGroundRepeat = "no";
	}
	String strMainSearchStyle = "";
	if (!request.getServletPath().trim().equals("/Index.jsp") && !request.getServletPath().trim().equals("/search/Searchlist.jsp")){
		strMainSearchStyle = "style=\"top:0px;left:780;position:absolute;background-image:url("+ConfigManager.IMG_ENURI_COM+"/images/main_2007/search_list_bg_0823.gif);height:22;width:"+(strIsFashion.equals("Y")?"215":"200")+";padding-top:2px;\"";
	}
%> 

<div id="MainSearch1" <%=strMainSearchStyle%>>
<%if (!request.getServletPath().trim().equals("/Index.jsp") && !request.getServletPath().trim().equals("/search/Searchlist.jsp")){%>	
	<form name="fmMainSearch"  method="get" OnSubmit="return Cmd_MainSearch1();" style="margin:0px">
	<input type="hidden" name="searchkind" value="">
	<input type="hidden" name="nosearchkeyword" value="">
	<input type="hidden" name="es" value="">
   	<input type=hidden name="c" value="enuri">
<%if(bExLink){%><input type=hidden name="exlink" value="Y"><%}%>
   	<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/list_search_01_0822.gif" border="0" align='absmiddle' ><input name="keyword"  id="keyword" type="text" autocomplete=off value="<%=strKeywordInit%>" 
		onkeydown="oT_search();"
		onmousedown = "oT_search();"	
		onBlur="changeStyle(this);" 
		onFocus="changeStyle(this);" 
		style="width:135px;height:17px;border:none;padding-top:3px;background-image:url(<%=strSearchBackGround%>);background-repeat:<%=strSearchBackGroundRepeat%>;<%=strKeyWordStyle%>;font-family:gulim;font-size:9pt;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/list_search_03_0822.gif" border="0" align='absmiddle' onclick="oT.toggle();" style="cursor:pointer"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/top_searchbt_0820.gif" Onclick="Cmd_MainSearchSubmit();" align='absmiddle' style='cursor:pointer'><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/top_searchbt_0820_1.gif" onClick="top.showTopSearchLayer()" style='cursor:pointer' align='absmiddle'>
	</form>
<%
	}
%>		
</div>
<div id="divSearchMenuDesc1" style="font-family:돋움;display:none;line-height:13px;padding:2px;font-size:8pt;position:absolute;width:310px;top:21;left:559;z-index:100;background:#FFFFFF;border:1px solid #000000">
	<div><span style="font-weight:bold">가격비교 상품</span> : 에누리 가격비교 상품중에서 검색합니다.</div>
	<div style="padding-left:170px">(의류,식품 제외)</div>
</div>
<div id="divSearchMenuDesc2" style="font-family:돋움;display:none;line-height:13px;padding:2px;font-size:8pt;position:absolute;width:310px;top:21;left:559;z-index:100;background:#FFFFFF;border:1px solid #000000">
	<div><span style="font-weight:bold">웹검색상품</span> : 에누리 가격비교에 없는 상품들을 쇼핑몰 에서</div>
	<div style="padding-left:71px">직접 검색하므로 인터넷상의 모든 판매상품을 모두 검색할 수 있습니다.</div>
</div>
<div id="divSearchMenuDesc3" style="font-family:돋움;display:none;line-height:13px;padding:2px;font-size:8pt;position:absolute;width:310px;top:21;left:559;z-index:100;background:#FFFFFF;border:1px solid #000000">
	<div><span style="font-weight:bold">식품</span> : 모든 "식품" 상품에 대해서만 검색합니다.</div>
</div>
<div id="divSearchMenuDesc4" style="font-family:돋움;display:none;line-height:13px;padding:2px;font-size:8pt;position:absolute;width:310px;top:21;left:559;z-index:100;background:#FFFFFF;border:1px solid #000000">
	<div><span style="font-weight:bold">의류</span> : 모든 "의류" 상품에 대해서만 검색합니다.</div>
</div>
<div id="divSearchMenuDesc6" style="font-family:돋움;display:none;line-height:13px;padding:2px;font-size:8pt;position:absolute;width:310px;top:21;left:559;z-index:100;background:#FFFFFF;border:1px solid #000000">
	<div><span style="font-weight:bold">에누리 단종상품</span> : 에누리 가격비교 목록에 등록 되었다가</div>
	<div style="padding-left:100px">현재는 판매중인 쇼핑몰이 없는 옛날 상품중에서 검색합니다.</div>
</div>
<script language=javascript>
<!--
oT_Init();
//-->
</script>
<iframe name="ifrmMainSearch" id="ifrmMainSearch" frameborder="0" style="height:0;width:0;z-index:0;"></iframe>