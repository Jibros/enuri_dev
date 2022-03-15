<%@ page contentType="text/html; charset=euc-kr" %>
<!--
<%@ include file="/include/Base_Inc.jsp"%>
-->
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
%>
<style type="text/css">
<!--
.search_menu {
  background-color: #FFFFFF;
  border: 1px solid;
  border-color: #7F9DB9 #7F9DB9 #7F9DB9 #7F9DB9;
  padding: 0px;
  position: absolute;
  text-align: left;
  width:100;
  overflow-x:hidden;
  overflow-y:auto;
  left:870px;
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
	varOnOff = onoff;
	Cmd_Login();
}
var nosalewin = null;
function Cmd_Login()
{
	if(islogin()){
		var nosale = window.open("about:blank","nosale","left=100,top=100,width=795,height=710,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=no,menubar=no");
		if (nosale == null)
		{
			document.getElementById("div_NoSale").style.display="inline";
			document.getElementById("div_NoSale").style.left=250;
			document.getElementById("div_NoSale").style.bottom=300;
		}
		else
		{
			document.getElementById("div_NoSale").style.display="none";
			frmList_login.page.value='';
			document.frmList_login.nosale.value=varOnOff;
			document.frmList_login.key.value="POPULAR+DESC";
			document.frmList_login.pagesize.value="100";
			frmList_login.searchkind.value=1;
			frmList_login.target = "nosale";
			fnSendData2('/search/Searchlist.jsp');
			document.frmList_login.nosale.value="";
		}
		frmMainLogin.location.href='/login/Loginstatus.jsp';
		IFrameMyFavoriteList.location.href='/include/Incmyfavoritelistmain.jsp';
		IFrameMyNegoList.location.href='/include/Incnegomylistmain.jsp';
	}else{
		var wins = window.open("","ENURI_LOGIN","width=372, height=230; resizable=yes");
		var obj = document.fmKbLogin;
		obj.action="<%=ConfigManager.ENURI_COM_SSL%>/login/Loginpop.jsp";
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

function fnSendData2(strActionName)
{
	document.frmList_login.action = strActionName;
	document.frmList_login.submit();
	document.frmList_login.target = "_self";
}

//-->
</script>
<div id="LayerLoginMain" style="position:absolute;left:774px; top:0px; width:220px; height:46px; z-index:0; border-width:1px; overflow:hidden; border-style:none;"><iframe id="frmMainLogin" name="frmMainLogin" src="/login/Loginstatus.jsp?keyword=<%=strKeywordTop%>&searchkind=<%=strSearchKindTop%>" frameborder=0  style="width:220px;height:46px;overflow:hidden;"></iframe></div>


<div id="LayerSearchEmpty" style="z-index:99;top:250;left:400;position:absolute;display:none;">
	<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/Search/warning.gif" border="0" usemap="#Mapsearch">
	<map name="Mapsearch">
	  <area shape="rect" coords="238,67,269,84" href="javascript:Open_guide();"><!--안내-->
	  <area shape="rect" coords="240,110,342,131" href="javascript:close_layer();noSale('NO')">
	  <area shape="rect" coords="151,144,200,166" href="javascript:close_layer();"><!--확인-->
	  <area shape="rect" coords="323,5,345,26" href="javascript:close_layer();">
	</map>
</div>

<div id='div_NoSale' style='display:none;position:absolute;left:0;right:0'>
	<table width="362" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/Search/pop_img_01.gif" width="362" height="30" border="0" usemap="#Map"></td>
	  </tr>
	  <tr>
	    <td><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/Search/pop_img_02.gif" width="362" height="120"></td>
	  </tr>
	  <tr>
	    <td height="32" align="center" background="<%=ConfigManager.IMG_ENURI_COM%>/images/Search/pop_img_04.gif"><a href="javaScript:Cmd_Login();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','http://img.enuri.info/images/Search/search_02.gif',1)"><img src="http://img.enuri.info/images/Search/search_01.gif" name="Image4" width="108" height="19" border="0"></a></td>
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
<form name="frmList_login"  method="get" target="nosale" style="margin:0;">
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
<form name="fmKbLogin" action="<%=ConfigManager.ENURI_COM_SSL%>/login/Loginpop.jsp" style="margin:0;">
	<input type=hidden name="rtnurl" value="">
	<input type=hidden name="rtntarget" >
	<input type=hidden name="cmd" >
	<input type="hidden" name="gubun" value="">
</form>




<!--자동완성 기능-->
<script language=javascript>
<!--
function calculateOffsetLeft(field) {
  return calculateOffset(field, "offsetLeft");
}

function calculateOffsetTop(field) {
  return calculateOffset(field, "offsetTop");
}

function calculateOffset(field, attr) {
  var offset = 0;
  while(field) {
    offset += field[attr]; 
    field = field.offsetParent;
   }
  return offset;
}

function isExistSkipWrd(s, t){
	var ret = false;
	for(i=0;i<s.length;i++){
		if(t.indexOf(s.substring(i, i+1)) < 0){
			ret = false;
		}
		else{
			ret = true;
			break;
		}
	}
	return ret;
}
var jj=0;

function Tom_Evt_Cancel(){
	var e = window.event;
	e.returnValue=false; 
	if (e && e.preventDefault) e.preventDefault(); 
}
function Tom_find(){
	try{
		//var skip = isExistSkipWrd(oT.oKeyword.value.trim(), oT.sSkipWrd);
		var skip = false;
		if(skip == false){
			var e = window.event;
			if(oT.oAc_ifr!=null){
				var obj = document.frames(oT.oAc_ifr.name);
				obj.Jerry_AutoSearch( oT, e.keyCode);
			}
			//e.returnValue=false;
		}else{
			//alert("스킵해야할 단어가 살짝 건너뛰어봅시다..")
		}
		//Tom_Evt_Cancel();

		jj++;
		top.window.status=jj;
	}catch(e){
		//alert("");
	}
}

function Tom(){
	this.version="1.0";
	this.name = "AutoComplete Tom";
	this.oForm = null;
	this.sCollection = null; //콜랙션 정보.
	this.oKeyword = null;
	this.oAc_lyr = null;
	this.oAc_ifr = null;
	//this.oImg_lyr = null;
	this.oImg_Toggle = null;
	this.sImg_Toggle_on = "http://img.enuri.info/images/Search/btn_ac_on.gif";
	this.sImg_Toggle_off = "http://img.enuri.info/images/Search/btn_ac_off.gif";
	this.sSkipWrd = "ㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎ"; 
}

var oT = null;
function Tom_Init(){
	oT_Init();
}
function Tom_get(){
	return oT;
}

function oT_Init(){
	try{
		if(oT == null){
			oT = new Tom();
		}
		if(oT.oForm==null){
			oT.oForm = document.fmMainSearch;
		}
		if(oT.sCollection==null){
			oT.sCollection = oT.oForm.c.value;
		}
		if(oT.oKeyword==null){
			oT.oKeyword = oT.oForm.keyword;//document.getElementById("keyword");
		}
		if(oT.oAc_lyr==null){
			oT.oAc_lyr = document.getElementById("ac_layer");
		}
		oT.oAc_lyr.style.left  = calculateOffsetLeft(oT.oKeyword) + "px";
		oT.oAc_lyr.style.top   = (calculateOffsetTop(oT.oKeyword)+ oT.oKeyword.offsetHeight+1)+ "px";
		oT.oAc_lyr.style.width = (oT.oKeyword.offsetWidth-2+44+2+5) + "px";
		oT.oAc_lyr.style.display = "none" ;
		if(oT.oAc_ifr==null){
			oT.oAc_ifr = document.getElementById("ifr_ac");	
		}
		oT.oAc_ifr.style.width = (oT.oKeyword.offsetWidth-2+44+2+5) + "px";
		oT.oAc_ifr.style.display = "block";				
		if(oT.oImg_Toggle == null){
			oT.oImg_Toggle = document.getElementById("ac_img");
			oT.oImg_Toggle.style.left = calculateOffsetLeft(oT.oKeyword) + oT.oKeyword.offsetWidth - 20;
			oT.oImg_Toggle.style.top  = calculateOffsetTop(oT.oKeyword)  + oT.oKeyword.offsetHeight -20;
		}
	}catch(e){
		
	}
}

function Tom_Img_Toggle(){
	try{
		if(oT.oAc_ifr!=null){
			var obj = document.frames(oT.oAc_ifr.name);
			obj.Jerry_on_off();
		}else{
			//alert("xxxx");
		}
	}catch(e){
		//alert("xxx");
	}
}

window.onload = Tom_Init;
//-->
</script>

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
	schLen = schWrd.length;
	var varExpKeyWord = "쌀콩팥배감귤무밤잣햄물차굴게김깨탕국빵떡전엿껌죽";
	
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
	//try{
		var return_a = Cmd_MainSearch1();
		if(return_a==true){
			document.fmMainSearch.submit();
		}
	//}catch(e){
	//	window.status=e;
	//}
}

function fnGetCountSearchAll(varCount,varSearchkind){
	var obj = document.fmMainSearch;
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
}	
var jjj=0;

//-->
</script>

<div id="MainSearch1" name="MainSearch1" style='position:absolute;display:block;border:0;top:0;left:775;width:210;height:22;z-index:99;'>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#AFDFAF">
<tr>
  <td height="22" bgcolor="#AFDFAF" width="100%">
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
		<form name="fmMainSearch"  method="get" OnSubmit="return Cmd_MainSearch1();">
		<input type="hidden" name="searchkind" value="">
		<input type="hidden" name="nosearchkeyword" value="">
			<tr>
		        <td width="160" align="right" style="padding-left:1px" >
		        <%
		        	String strKeyWordStyle = "";
		        	if (strKeywordTop.trim().length() > 0 ){
		        		strKeyWordStyle = "color:#FF0000;";
		        	}
		        %>
		        	<input type=hidden name="c" value="enuri">
					<input name="keyword"  id="keyword" type="text" autocomplete=off value="<%=strKeywordTop%>" 
						onkeyup="Tom_find();"
						onBlur="this.style.background='#FFFFE7';" 
						!onFocus="this.style.background='#FFFFE7';" 
						style="padding-right:20px;border:solid 1 #487272; background-color:#FFFFE7;<%if(strKeywordTop.equals("")){%>background-image:url(<%=ConfigManager.IMG_ENURI_COM%>/images/login/login_060512/search_text.gif);<%}%>background-repeat:no-repeat;background-position:left; width:160px; font-size:9pt; color: #FF0000; font-family:gulim;">
				 </td>
				<td width="45">
					<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/login/login_060512/newbt3_1_new.gif" name="Image4" width="31" height="18" border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','<%=ConfigManager.IMG_ENURI_COM%>/images/login/login_060512/newbt3_2_new.gif',1)" Onclick="Cmd_MainSearchSubmit();" border="0" style="cursor:hand;"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/login/login_060512/down_y.gif" name="Image4" width="13" height="18" border="0" align="absmiddle" border="0" onClick="top.showTopSearchLayer()" style="cursor:hand;">
				</td>
			</tr>
		</form>
		</table>
	</td>
</tr>
</table>
</div>
<iframe name="ifrmMainSearch" id="ifrmMainSearch" frameborder="0" style="height:0;width:0;z-index:0;"></iframe>

<div id="ac_layer" name="ac_layer" border=0 style='display:none;border:0;position:absolute;top:0;left:0;width:0;z-index:90;'>
<iframe id="ifr_ac" name="ifr_ac" src='/search/Autocom_MainSearch.jsp'  frameborder=0 marginwidth=0 marginheight=0 topmargin=0 scrolling=no></iframe>
</div>
<img id="ac_img" name="ac_img"  border=0
src="http://img.enuri.info/images/Search/btn_ac_off.gif" 
onclick="Tom_Img_Toggle();"
style="position:absolute;top:0;left:0;z-index:100;cursor:pointer;">


