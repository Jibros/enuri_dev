try {document.execCommand('BackgroundImageCache', false, true);} catch(e) {}
var var_img_enuri_com = "http://img.enuri.info";
String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)|($\s*)/g, "");
}
String.prototype.isid = function() {
  if (this.search(/[^A-Za-z0-9_-]/) == -1)
     return true;
  else
     return false;
}
String.prototype.isalpha = function() {
  if (this.search(/[^A-Za-z]/) == -1)
     return true;
  else
     return false;
}
String.prototype.isnumber = function() {
  if (this.search(/[^0-9]/) == -1)
     return true;
  else
     return false;
}
String.prototype.isemail = function() {
  var flag, md, pd, i;
  var str;

  if ( (md = this.indexOf("@")) < 0 )
     return false;
  else if ( md == 0 )
     return false;
  else if (this.substring(0, md).search(/[^.A-Za-z0-9_-]/) != -1)
     return false;
  else if ( (pd = this.indexOf(".")) < 0 )
     return false;
  else if ( (pd + 1 )== this.length || (pd - 1) == md )
     return false;
  else if (this.substring(md+1, this.length).search(/[^.A-Za-z0-9_-]/) != -1)
     return false;
  else
     return true;
}
String.prototype.korlen = function() {
  var temp;
  var set = 0;
  var mycount = 0;

  for( k = 0 ; k < this.length ; k++ ){
     temp = this.charAt(k);

     if( escape(temp).length > 4 ) {
        mycount += 2;
     }
     else mycount++;
  }

  return mycount;
}
String.prototype.isssn = function() {

  var first  = new Array(6);
  var second = new Array(7);
  var total = 0;
  var tmp = 0;

  if ( this.length != 13 )
     return false;
  else {
     for ( i = 1 ; i < 7 ; i++ )
        first[i] = this.substring(i - 1, i);

     for ( i = 1 ; i < 8 ; i++ )
        second[i] = this.substring(6 + i - 1, i + 6);

     for ( i = 1 ; i < 7 ; i++ ) {
        if ( i < 3 )
           tmp = Number( second[i] ) * ( i + 7 );
        else if ( i >= 3 )
           tmp = Number( second[i] ) * ( ( i + 9 ) % 10 );

        total = total + Number( first[i] ) * ( i + 1 ) + tmp;
     }

     if ( Number( second[7] ) != ((11 - ( total % 11 ) ) % 10 ) )
        return false;
  }
  return true;
}
String.prototype.ByteLength = function() {
	var i,ch;
	var strLength = this.length;
	var count = 0;

	for(i=0;i<strLength;i++)
	{
		ch = escape(this.charAt(i));

		if(ch.length > 4)
			count += 2;
		else if(ch!='\r')
			count++;
	}
	return count;
}

/*
 * prototype.getByteLength : 바이트 수를 계산해서 반환한다
 */
String.prototype.getByteLength = function() {
    var str = this.trim();
    var l   = 0;

    if (str != null && str != 'undefined')
	    for (var i=0; i<str.length; i++) l += (str.charCodeAt(i) > 128) ? 2 : 1;
	        return l;
}
/**
 * 문자열을 형식화(3자리마다 콤마 삽입)된 식으로 반환합니다.
 */
String.prototype.NumberFormat = function() {
	var str = this.replace(/,/g,"");
	var strLength = str.length;

	if (strLength<=3) return str;

    var strOutput = "";
    var mod = 3 - (strLength % 3);
	var i;

    for (i=0; i<strLength; i++)
	{
		strOutput+=str.charAt(i);
        if (i < strLength - 1)
		{
			mod++;
            if ((mod % 3) == 0)
			{
				strOutput +=",";
                mod = 0;
			}
		}
	}
	return strOutput;
}

/**
 * 3자리수마다 ","처리 삭제 wookki25 2005-09-21
 */
String.prototype.DeNumberFormat = function() {
	var str = this.replace(/,/g,"");
	return str;
}

String.prototype.isKorean = function() {
	Unicode = this.charCodeAt(0);
	if ( !(44032 <= Unicode && Unicode <= 55203) )
		return false;
	else
		return true;
}
String.prototype.isEnglish = function() {
	if (this.search(/[^A-Za-z]/) == -1)
	   return true;
	else
	   return false;
}

String.prototype.lenH = function() {
   var temp;
   var set = 0;
   var mycount = 0;

   for( k = 0 ; k < this.length ; k++ ){
      temp = this.charAt(k);

      if( escape(temp).length > 4 ) {
         mycount += 2;
      }
      else mycount++;
   }

   return mycount;
}

/**
 *  문자열에서 Byte Len만큼 문자열 잘라온다.
 *  ex) var s = MidH("대한민국만세123ABS",0,10);
 */
function MidH(str, n, len){
	//n : 시작점;
	//len : ByteLength;
	var ret="";
	var tmp = str.substring(n, str.length);
	var s="";
	var j=0;
	if(tmp.length>0){
		for(i=0; i< tmp.length; i++){
			if(j <= len){
				s = tmp.substring(i,i+1);
				if(s.lenH()==2){
					j = j+2;
				}else{
					j++;
				}
				ret = ret + s;
			}else{
				break;
			}
		}
	}
	return ret;
}
/**
 *  문자열이 존재하는지 체크합니다. (복수 가능)
 *  ex) StrMultiExists(id,"sysadmin","admin"...);
 */
function StrMultiExists(str)
{
	var i;
	var argCount = arguments.length;
	if (argCount==0) return false;
	var regStr = "";

	for(i=1; i<argCount; i++) {
		regStr+="("+arguments[i].replace(/([\^\\\$\*\+\?\.])/g,"\\$1")+")|";
	}

	if (str.search(eval("/"+regStr.replace(/\|$/g,"")+"/g"))==-1) return false;
	else return true;
}
/**
 *  문자열을 특정 문자열을 나눠 배열형태의 값으로 반환합니다.
 */
function StringTokenizer(str,separator) {
	arrayOfStrings = str.split(separator);
	return arrayOfStrings;
}
/**
 * 올바른 메일형식인지 체크합니다.
 */
function isValidEmail(str) {
	var re=new RegExp("^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$","gi");
	if (str.match(re)) return true;
	else return false;
}

/**
 * 올바른 홈페이지형식인지 체크합니다.
 */
function isValidHomepage(str) {
	var re=new RegExp("^((ht|f)tp:\/\/)((([a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3}))|(([0-9]{1,3}\.){3}([0-9]{1,3})))((\/|\\?)[a-z0-9~#%&'_\+=:\?\.-]*)*)$","gi");
	if (str.match(re)) return true;
	else return false;
}

/**
 * 올바른 주민등록번호인지 체크합니다.
 */
function IsResidentRegistrationNumber(str1, str2) {
	if (isNull(str1)) return false;
	if (isNull(str2)) return false;

	var Sum = 0;
	var i, j;

	for (i=0, j=2 ; i<=5 ;i++,j++)
	{
		Sum += parseInt(str1.charAt(i)) * j;
	}

	for (i=0, j=8;i<=5;i++, j++)
	{
		Sum += parseInt(str2.charAt(i)) * j;
		if (j==9) j=1;
	}

	if ((Sum=11-(Sum%11))>9) Sum=Sum%10;

	if (parseInt(str2.charAt(6)) != Sum) return false;
	return true;
}

/**
 * 알파벳만으로 구성된 문자열인지 체크합니다.
 */
function isAlphabet(str) {
	if (str.search(/[^a-zA-Z]/g)==-1) return true;
	else return false;
}

/**
 * 한글로만 구성된 문자열인지 체크합니다.
 */
function isKorean(str) {
	var strLength = str.length;
	var i;
	var Unicode;

	for (i=0;i<strLength;i++) {
		Unicode = str.charCodeAt(i);
		if ( !(44032 <= Unicode && Unicode <= 55203) ) return false;
	}
	return true;
}

/**
 * 숫자만으로 구성된 문자열인지 체크합니다.
 */
function isDigit(str) {
	if (str.search(/[^0-9]/g)==-1) return true;
	else return false;
}

/**
 * 문자열이 NULL인지 체크합니다.
 */
function isNull(str) {
    if (str == null || str == "") return true;
    else return false;
}

/**
 * 문자열에 한칸이상의 스페이스 입력이 있는지를 체크합니다.
 */
function isValidSpace(str) {
	if (str.search(/[\s]{2,}/g)!=-1) return false;
	else return true;
}

/**
 * 팝업창의 위치값을 마지막에 받아서 창을 띄웁니다.
 */
function Main_OpenWindow(OpenFile,name,nWidth,nHeight,ScrollYesNo,ResizeYesNo,TPosition,LPosition)
{
	if(OpenFile.indexOf("/view/Detailmulti.jsp")>-1){
		//vip 개편작업
		OpenFile = OpenFile.replace("/view/Detailmulti.jsp","/detail.jsp");
		var newWin = window.open(OpenFile);
		newWin.focus();
	}else if(OpenFile.indexOf("/p/")>-1 || OpenFile.indexOf("/detail.jsp")>-1){
		//vip 개편작업
		var newWin = window.open(OpenFile);
		newWin.focus();
	}else{
		var newWin = window.open(OpenFile,name,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar=no,Top="+ TPosition +",left="+ LPosition);
		newWin.focus();
	}
}

function detailView(OpenFile){
	var detailWin = window.open("/_pre_detail_.jsp");
	detailWin.location.replace(OpenFile);
	detailWin.focus();
}

function GotoSDU_Login(sURL)
{
	var k = window.open(sURL,'WinSDULogin','width=450 height=330');
		k.focus();
}

function SetUpdate()
{
  window.status="";
}


function islogin(){
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

function CmdSetLog(lognum, logcate, logmodelno, logshopcode){ //해당로그번호에 대한 로그남기기

 try{
	var cName = "LOGNUM";
	var cCate = "LOGCATE";
	var cModelno = "LOGMODELNO";
	var cShopcode = "LOGSHOPCODE";
	var ispos = false;
	if( typeof(lognum)=="number"){
		ispos =true;
	}else if(typeof(lognum)=="string"){
		if( lognum.isnumber()==true){
			ispos =true;
		}
	}
	if(typeof(logcate)=="undefined" || logcate.isnumber()!=true){
		logcate="";
	}

	if( typeof(logmodelno)=="number"){

	}else if(typeof(logmodelno)=="string"){
		if( logmodelno.isnumber()!=true){
			logmodelno=0;
		}
	}else{
		logmodelno=0;
	}

	if( typeof(logshopcode)=="number"){

	}else if(typeof(logshopcode)=="string"){
		if( logshopcode.isnumber()!=true){
			logshopcode=0;
		}
	}else{
		logshopcode=0;
	}

	if(ispos==true){
		document.cookie = cName + "=" + lognum + "; path=/;";
		document.cookie = cCate + "=" + logcate+ "; path=/;";
		document.cookie = cModelno + "=" + logmodelno + "; path=/;";
		document.cookie = cShopcode + "=" + logshopcode + "; path=/;";
	}else{
		alert("정확한 로그번호를 입력하십시오");
	}
 }catch(e){
  window.status="";
 }
}


function OpenWindow(OpenFile,name,nWidth,nHeight,ScrollYesNo,ResizeYesNo){
    var newWin
    if (OpenFile.indexOf("Viewbigimg.jsp") >= 0 ){
        ScrollYesNo = "no";
    }
    /*if(OpenFile.indexOf("/view/Detailmulti.jsp")>-1){
		//vip 개편작업
		OpenFile = OpenFile.replace("/view/Detailmulti.jsp","/detail.jsp");
		newWin = window.open(OpenFile);
		newWin.focus();
	}else if(OpenFile.indexOf("/p/")>-1){
		//vip 개편작업
		var newWin = window.open(OpenFile);
		newWin.focus();
    }else{*/
		newWin = window.open(OpenFile,name,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar=no");
		newWin.focus();
   // }
}
function OpenWindowYes(OpenFile,winname,nWidth,nHeight){
	var newWin
	/*if(OpenFile.indexOf("/view/Detailmulti.jsp")>-1){
		//vip 개편작업
		OpenFile = OpenFile.replace("/view/Detailmulti.jsp","/detail.jsp");
		newWin = window.open(OpenFile);
		newWin.focus();
	}else if(OpenFile.indexOf("/p/")>-1){
		//vip 개편작업
		var newWin = window.open(OpenFile);
		newWin.focus();
	}else{*/
		newWin = window.open(OpenFile,winname,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
		newWin.focus();
	//}
}
function OpenWindowNo(OpenFile,winname,nWidth,nHeight){
	var newWin
	/*if(OpenFile.indexOf("/view/Detailmulti.jsp")>-1){
		//vip 개편작업
		OpenFile = OpenFile.replace("/view/Detailmulti.jsp","/detail.jsp");
		newWin = window.open(OpenFile);
		newWin.focus();
	}else if(OpenFile.indexOf("/p/")>-1){
		//vip 개편작업
		var newWin = window.open(OpenFile);
		newWin.focus();
	}else{*/
		newWin = window.open(OpenFile,winname,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars=no,resizable=no,menubar=no");
		newWin.focus();
	//}
}
function OpenWindowPosition(OpenFile,name,nWidth,nHeight,ScrollYesNo,ResizeYesNo,lleft,ttop){
	/*if(OpenFile.indexOf("/view/Detailmulti.jsp")>-1){
		//vip 개편작업
		OpenFile = OpenFile.replace("/view/Detailmulti.jsp","/detail.jsp");
		window.open(OpenFile);
	}else if(OpenFile.indexOf("/p/")>-1){
		//vip 개편작업
		var newWin = window.open(OpenFile);
		newWin.focus();
	}else{*/
		window.open(OpenFile,name,"width="+nWidth+",height="+nHeight+",left="+lleft+",top="+ttop+",toolbar=no,directories=no,status=no,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar=no");
	//}
}
function OpenWindowDetail(OpenFile,name,nWidth,nHeight,ToolbarYN,MenubarYN,StatusYN,ScrollbarYN,ResizeYN,TPosition,LPosition)
{
	/*if(OpenFile.indexOf("/view/Detailmulti.jsp")>-1){
		//vip 개편작업
		OpenFile = OpenFile.replace("/view/Detailmulti.jsp","/detail.jsp");
		var newWin = window.open(OpenFile);
		newWin.focus();
	}else if(OpenFile.indexOf("/p/")>-1){
		//vip 개편작업
		var newWin = window.open(OpenFile);
		newWin.focus();
	}else{*/
		var newWin = window.open(OpenFile,name,"width="+nWidth+",height="+nHeight+",toolbar="+ToolbarYN+",menubar="+MenubarYN+",status="+StatusYN+",scrollbars="+ ScrollbarYN +",resizable="+ ResizeYN +",directories=no,Top="+ TPosition +",left="+ LPosition);
		newWin.focus();
	//}
}

function js_replace(str, oldStr, newStr)
{
	for(var i=0;i<str.length;i++)
	{
		if(str.substring(i, i+oldStr.length) == oldStr)
		{
			str = str.substring(0, i) + newStr + str.substring(i+oldStr.length, str.length)
		}
	}

	return str
}

function reActionGif()
{

	try
	{
		if (document.getElementById("knowbox7_img") != null)
		{
    		if (typeof(document.getElementById("knowbox7_img")) != "undefined")
    		{
    			document.getElementById("knowbox7_img").background="url("+var_img_enuri_com+"/knowbox/btnGoKnowbox7.gif)";
    		}
    	}

		if (document.getElementById("re_img_2") != null)
		{
    		if (typeof(document.getElementById("re_img_2")) != "undefined")
    		{
    			document.getElementById("re_img_2").src = var_img_enuri_com  + "/images/front/menu_051209/14.gif";
    		}
    	}
		if (document.getElementById("re_img_3") != null)
		{
    		if (typeof(document.getElementById("re_img_3")) != "undefined")
    		{
    			document.getElementById("re_img_3").src = var_img_enuri_com  + "/images/button/button_best.gif";
    		}
    	}
		if (document.getElementById("re_img_4") != null)
		{
    		if (typeof(document.getElementById("re_img_4")) != "undefined")
    		{
    			document.getElementById("re_img_4").src = var_img_enuri_com  + "/images/view/openexpect_small_200501.gif";
    		}
    	}
		if (document.frames("IFrameMyFavoriteList").document.getElementById("UpdateBtn") != null)
		{
    		if (typeof(document.frames("IFrameMyFavoriteList").document.getElementById("UpdateBtn")) != "undefined")
    		{
    			document.frames("IFrameMyFavoriteList").document.getElementById("UpdateBtn").src = var_img_enuri_com  + "/images/view/bt_myfavoritegolist.gif	";
    		}
    	}
		if (document.getElementById("re_img_7") != null)
		{
    		if (typeof(document.getElementById("re_img_7")) != "undefined")
    		{
    			document.getElementById("re_img_7").src = var_img_enuri_com  + "/images/front/bt_term.gif";
    		}
    	}


    }
    catch(e)
    {

    }


}
function getAbsoluteLeft(objectId) {
	// Get an object left position from the upper left viewport corner
	// Tested with relative and nested objects
	if (typeof(objectId) == "string"){
		o = document.getElementById(objectId)
	}else{
		o = objectId;
	}

	var oLeft = 0;
	if(o){
		oLeft = o.offsetLeft;            // Get left position from the parent object
		while(o.offsetParent!=null) {   // Parse the parent hierarchy up to the document element
			oParent = o.offsetParent;    // Get parent object reference
			oLeft += oParent.offsetLeft; // Add parent left position
			o = oParent
		}
		// Return left postion
	}
	return oLeft;
}

function getAbsoluteTop(objectId) {
	// Get an object top position from the upper left viewport corner
	// Tested with relative and nested objects
	if (typeof(objectId) == "string"){
		o = document.getElementById(objectId)
	}else{
		o = objectId;
	}

	var oTop = 0;
	if(o){
		oTop = o.offsetTop;            // Get top position from the parent object
		while(o.offsetParent!=null) { // Parse the parent hierarchy up to the document element
			oParent = o.offsetParent;  // Get parent object reference
			oTop += oParent.offsetTop; // Add parent top position
			o = oParent;
		}
	}

	// Return top position
	return oTop;
}
function getCumulativeOffset(obj){
	var varReturn  = new Array(2);
	varReturn[0] =  getAbsoluteLeft(obj);
	varReturn[1] =  getAbsoluteTop(obj);
	return varReturn;
}
function getFlashObjectHeight(objectId) {
	o = document.getElementById(objectId)
	oHeight = o.height
	return oHeight
}
function getFlashObjectWidth(objectId) {
	o = document.getElementById(objectId)
	oWidth = o.width
	return oWidth
}

String.prototype.isUserName = function() {
	if (this.search(/[^ㄱ-힣A-Za-z0-9]/) == -1)
		return true;
	else
		return false;
}

function CmdGotoPurchaseGuide(cate,kind,kbno){
	//var wWidth = 1014;
	var wWidth = 734+30+6;
	if (typeof(kind)=="number" && kind==20) wWidth = wWidth+35;
	var wHeight = screen.availHeight;
	var win = window.open("/purchaseguide/GuideLayer.jsp?kind="+kind+"&cate="+cate+"&kbno="+((typeof(kbno)=="number")?kbno:0)+"&btnhits=yes","GuideLayer","width="+wWidth+",height="+wHeight+",left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=yes,resizable=no,menubar=no");
	win.focus();
}
var knowBoxWin = null;
function CmdGotoPurchaseGuide2(url,modwidth){
	//var wWidth = 1014;
	/*
	var wWidth = 734+30+6;
	if (typeof(kind)=="number" && kind==20) wWidth = wWidth+35;
	var wHeight = screen.availHeight;
	var win = window.open(url,"GuideLayer","width="+wWidth+",height="+wHeight+",left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=yes,resizable=no,menubar=no");
	win.focus();
	*/

	/*
	if (window.knowBoxWin == null){
		window.knowBoxWin = window.open(url);
	}else{
		try{
			if(tyopeof(window.knowBoxWin.location.href) != "undefined"){
				window.knowBoxWin.location.href = url;
			}else{
				window.knowBoxWin = window.open(url);
			}
		}catch(e){
			window.knowBoxWin = window.open(url);
		}
	}
	*/

	//window.knowBoxWin = window.open(url,"knowBoxWin");
	//window.knowBoxWin.focus();
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
	var strNo = 0;
	strNo = url.lastIndexOf("/knowbox/");
	if(strNo == -1) strNo = 0;
	url = url.substr(strNo,url.length);

	var selfW = 0;

	if(IS_VISTA=="1") {
		selfW = 1040;
	}else {
		selfW = 1030;
	}

	if (typeof(modwidth) != "undefined"){
		selfW = modwidth;
	}
	/*if(url.indexOf("/view/Detailmulti.jsp")>-1){
		//vip 개편작업
		url = url.replace("/view/Detailmulti.jsp","/detail.jsp");
	}*/
	if (url.indexOf("enuri.com") < 0){

		var win = window.open(url,"knowBoxWin","toolbar=yes,location=yes,left=0,top=0,directories=yes,status=yes,scrollbars=yes,resizable=yes,menubar=yes,personalbar=yes,width="+selfW+",height="+selfH);
	}else{
		var win = window.open(url,"knowBoxWin","toolbar=yes,location=yes,left=0,top=0,directories=yes,status=yes,scrollbars=yes,resizable=yes,menubar=yes,personalbar=yes");
		try{
			if(IS_VISTA=="1") {
				win.resizeTo(selfW, eval(selfH));
			}else {
				win.resizeTo(selfW, eval(selfH));
			}
		}catch(e){
		}
	}
	win.focus();
}
var knowBoxWin2 = null;
function CmdpopPurchaseGuide(url){
	var wWidth = 1014;

	//var wWidth = 734+30+6;
	//if (typeof(kind)=="number" && kind==20) wWidth = wWidth+35;
	var wHeight = screen.availHeight;
	//var win = window.open(url,"GuideLayer","width="+wWidth+",height="+wHeight+",left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=yes,resizable=no,menubar=no");
	//win.focus();


	/*
	if (window.knowBoxWin == null){
		window.knowBoxWin = window.open(url);
	}else{
		try{
			if(tyopeof(window.knowBoxWin.location.href) != "undefined"){
				window.knowBoxWin.location.href = url;
			}else{
				window.knowBoxWin = window.open(url);
			}
		}catch(e){
			window.knowBoxWin = window.open(url);
		}
	}
	*/

	/*if(url.indexOf("/view/Detailmulti.jsp")>-1){
		//vip 개편작업
		url = url.replace("/view/Detailmulti.jsp","/detail.jsp");
		window.knowBoxWin2 = window.open(url);
		window.knowBoxWin2.focus();
	}else{*/
		window.knowBoxWin2 = window.open(url,"knowBoxWin2","width="+wWidth+",height="+wHeight+",left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=yes,resizable=no,menubar=no");
		window.knowBoxWin2.focus();
	//}

}

function getIEVersion(){
    g = navigator;
    a = g.userAgent;
    p = g.appVersion;
    m = p.indexOf("MSIE");

    if(m!=-1 && a.indexOf("Win") != -1){
		if(a.toLowerCase().indexOf('trident/4.0') < 0){
			return parseFloat(p.substring(m+4));
		}else{
			return 8;
		}
    }else{
    	return -1;
    }
}
//vista flag
function getVistaFlag(){
	if(navigator.appName == "Microsoft Internet Explorer") {
		var Agent = navigator.userAgent
		Agent = Agent.toLowerCase();
		if(Agent.indexOf("nt 6.") > 0) {
			return true;
		}else{
			return false;
		}
	}
}
function inputFlash(vId, vUri, vWidth, vHeight, vWmode, vFlashVar) {
  var str = "";
  str = '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="' + vWidth + '" height="' + vHeight + '" id="' + vId + '" align="middle">';
  str += '<param name="allowScriptAccess" value="always" />';
  str += '<param name="allowFullScreen" value="false" />';
  str += '<param name="quality" value="high" />';
  str += '<param name="wmode" value="' + vWmode + '" />';
  str += '<param name="bgcolor" value="#ffffff" />';
  str += '<param name="movie" value="' + vUri + '" />';
  str += '<param name="FlashVars" value="' + vFlashVar + '" />';
  str += '<embed src="' + vUri + '" quality="high" wmode="' + vWmode + '" bgcolor="#ffffff" width="' + vWidth +'" height="' + vHeight + '" id="' + vId + '" name="' + vId + '" align="middle" swLiveConnect=true allowScriptAccess="always" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" /></embed>';
  str += '</object>';
  document.writeln(str);
}
function getBodyScrollTop(){
	try{
		if (document.body.scrollTop){
			return document.body.scrollTop;
		}else{
			return document.documentElement.scrollTop;
		}
	}catch(e){
		return 0;
	}
}
function getBodyScrollLeft(){
	if (document.body.scrollLeft){
		return document.body.scrollLeft;
	}else{
		return document.documentElement.scrollLeft;
	}
}
function getBodyScrollWidth(){

	if (document.body){
		return document.body.scrollWidth;
	}else if(document.documentElement){
		return document.documentElement.scrollWidth;
	} else
		return 0;

	//return document.documentElement.scrollWidth ? document.documentElement.scrollWidth : document.body.scrollWidth
}
function getBodyScrollHeight(){

	if (document.body){
		return document.body.scrollHeight;
	}else if(document.documentElement){
		return document.documentElement.scrollHeight;
	} else
		return 0;

	// return document.documentElement.scrollHeight ? document.documentElement.scrollHeight : document.body.scrollHeight
}
function getBodyClientHeight(){
	return document.documentElement.clientHeight ? document.documentElement.clientHeight : document.body.clientHeight;
}
function getBodyClientWidth(){
	return document.documentElement.clientWidth ? document.documentElement.clientWidth : document.body.clientWidth;
}
var BrowserDetect = {
    init: function () {
        this.browser = this.searchString(this.dataBrowser) || "An unknown browser";
        this.version = this.searchVersion(navigator.userAgent)
            || this.searchVersion(navigator.appVersion)
            || "an unknown version";
        this.OS = this.searchString(this.dataOS) || "an unknown OS";
    },
    searchString: function (data) {
        for (var i=0;i<data.length;i++) {
            var dataString = data[i].string;
            var dataProp = data[i].prop;
            this.versionSearchString = data[i].versionSearch || data[i].identity;
            if (dataString) {
                if (dataString.indexOf(data[i].subString) != -1)
                    return data[i].identity;
            }
            else if (dataProp)
                return data[i].identity;
        }
    },
    searchVersion: function (dataString) {
        var index = dataString.indexOf(this.versionSearchString);
        if (index == -1) return;
        return parseFloat(dataString.substring(index+this.versionSearchString.length+1));
    },
    dataBrowser: [
        {
            string: navigator.userAgent,
            subString: "Chrome",
            identity: "Chrome"
        },
        {   string: navigator.userAgent,
            subString: "OmniWeb",
            versionSearch: "OmniWeb/",
            identity: "OmniWeb"
        },
        {
            string: navigator.vendor,
            subString: "Apple",
            identity: "Safari",
            versionSearch: "Version"
        },
        {
            prop: window.opera,
            identity: "Opera"
        },
        {
            string: navigator.vendor,
            subString: "iCab",
            identity: "iCab"
        },
        {
            string: navigator.vendor,
            subString: "KDE",
            identity: "Konqueror"
        },
        {
            string: navigator.userAgent,
            subString: "Firefox",
            identity: "Firefox"
        },
        {
            string: navigator.vendor,
            subString: "Camino",
            identity: "Camino"
        },
        {       // for newer Netscapes (6+)
            string: navigator.userAgent,
            subString: "Netscape",
            identity: "Netscape"
        },
        {
            string: navigator.userAgent,
            subString: "MSIE",
            identity: "Explorer",
            versionSearch: "MSIE"
        },
        {
            string: navigator.userAgent,
            subString: "Gecko",
            identity: "Mozilla",
            versionSearch: "rv"
        },
        {       // for older Netscapes (4-)
            string: navigator.userAgent,
            subString: "Mozilla",
            identity: "Netscape",
            versionSearch: "Mozilla"
        }
    ],
    dataOS : [
        {
            string: navigator.platform,
            subString: "Win",
            identity: "Windows"
        },
        {
            string: navigator.platform,
            subString: "Mac",
            identity: "Mac"
        },
        {
            string: navigator.platform,
            subString: "iPad",
            identity: "iPad"
        },
        {
           string: navigator.userAgent,
           subString: "iPhone",
           identity: "iPhone/iPod"
        },
        {
           string: navigator.userAgent,
           subString: "Android",
           identity: "Android"
        },
        {
            string: navigator.platform,
            subString: "Linux",
            identity: "Linux"
        }
    ]

};
BrowserDetect.init();
var AryCateComment = new Array();
var AryDCateLayer = new Array();

function insertHideLayer(url,param,id,callback){
	var now=new Date();
	var nowTime1 = now.getTime();
	var nowTime2 = 0;
	var nowTime3 = 0;
	var nowTime4 = 0;
	var nowTime5 = 0;

	/*
	if(id=="spread_menu" && navigator.userAgent.indexOf("Chrome") > 0){
		var getHideLayer = new Ajax.Request(
			url,
			{
				method:'get',parameters:param,asynchronous:true,onComplete:showHideLayer
			}
		);
	}else{
	*/

		var getHideLayer = new Ajax.Request(
			url,
			{
				method:'get',parameters:param,asynchronous:false,onComplete:showHideLayer
			}
		);
	/*}*/
	function showHideLayer(originalRequest){
		nowTime2 = now.getTime();
		if ( id != "dcate_layer" && id != "dcate_layer_over" && id != "comment_layer" && id != "comment_layer_over"){
			document.getElementById(id).innerHTML = originalRequest.responseText;
		}
		nowTime3 = now.getTime();
		if( id == "comment_layer" || id == "comment_layer_over"){
			AryCateComment[param.substring(5,param.length)] = originalRequest.responseText;
		}
		nowTime4 = now.getTime();
		if(id == "dcate_layer" || id == "dcate_layer_over"){
			AryDCateLayer[param.substring(5,param.length)] = originalRequest.responseText;
		}
		nowTime5 = now.getTime();
		if (document.getElementById(id).style.display == "none" && id != "dcate_layer" && id != "dcate_layer_over" && id != "comment_layer" && id != "comment_layer_over"){
			document.getElementById(id).style.display = "";
		}
		if (typeof(callback) != "undefined"){
			callback;
		}
	}
}
function setOverOutImage(obj,mode){
	if (mode == "over"){
		obj.src = obj.src.replace(/out/g,"over");
	}else{
		obj.src = obj.src.replace(/over/g,"out");
	}
}
function inputFlash(vId, vUri, vWidth, vHeight, vWmode, vFlashVar) {
  var str = "";
  str = '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="' + vWidth + '" height="' + vHeight + '" id="' + vId + '" align="middle">';
  str += '<param name="allowScriptAccess" value="always" />';
  str += '<param name="allowFullScreen" value="false" />';
  str += '<param name="quality" value="high" />';
  str += '<param name="wmode" value="' + vWmode + '" />';
  str += '<param name="bgcolor" value="#ffffff" />';
  str += '<param name="movie" value="' + vUri + '" />';
  str += '<param name="FlashVars" value="' + vFlashVar + '" />';
  str += '<embed src="' + vUri + '" quality="high" wmode="' + vWmode + '" bgcolor="#ffffff" width="' + vWidth +'" height="' + vHeight + '" id="' + vId + '" name="' + vId + '" align="middle" swLiveConnect=true allowScriptAccess="always" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" /></embed>';
  str += '</object>';
  document.writeln(str);
}
function showLog(msg){
	if(typeof console != 'undefined' && typeof console.log != 'undefined'){
		console['info'](msg);
	}
}
var libTypeCheck = function(){
	var rtn = "";
	if (typeof(Prototype) != "undefined" ){
		rtn = "PR"
	}else if(typeof(jQuery) != "undefined"){
		rtn = "JQ"
	}
	return rtn;
}
function insertLog(logNum){
	var url = "/view/Loginsert_2010.jsp"
	var param = "kind="+logNum;
	if (typeof(modelno) != "undefined"){
		if(isNaN(modelno)== true){
			modelno=0;
		}
		param += "&modelno="+modelno;
	}
	if (libTypeCheck() == "PR"){
		var getRec = new Ajax.Request(
			url,
			{
				method:'get',parameters:param
			}
		);
	}else{
		$.ajax({
			type: "GET",
			url: url,
			data: param
		});
	}
	showLogView(logNum);
}
function insertLogCate(logNum,cate){
	var url = "/view/Loginsert_2010.jsp"
	var param = "kind="+logNum+"&cate="+cate;
	if (libTypeCheck() == "PR"){
		var getRec = new Ajax.Request(
			url,
			{
				method:'get',parameters:param
			}
		);
	}else{
		$.ajax({
			type: "GET",
			url: url,
			data: param
		});
	}
	showLogView(logNum);
}

function insertLogCate_inven(logNum,cate){
	var url = "/view/Loginsert_2010.jsp"
	var param = "kind="+logNum+"&cate="+cate;
	if (libTypeCheck() == "PR"){
		var getRec = new Ajax.Request(
			url,
			{
				method:'get',parameters:param
			}
		);
	}else{
		$.ajax({
			type: "GET",
			url: url,
			data: param
		});
	}
	showLogView(logNum);
}

function insertLogModel(logNum,modelno,cate){
	var url = "/view/Loginsert_2010.jsp"
	var param = "kind="+logNum+"&modelno="+modelno+"&cate="+cate;
	if (libTypeCheck() == "PR"){
		var getRec = new Ajax.Request(
			url,
			{
				method:'get',parameters:param
			}
		);
	}else{
		$.ajax({
			type: "GET",
			url: url,
			data: param
		});
	}
	showLogView(logNum);
}
function showLogView(logNum){
	if (islogin()){
		var varMem_Info = fnGetCookie2010("MEM_INFO");
		var varUserIdStart = varMem_Info.indexOf("USER_ID");
		if (varUserIdStart > 0){
			var varTemp = varMem_Info.substring(varUserIdStart+8,varMem_Info.length);
			var varUserIdEnd = varTemp.indexOf("&");
			if (varUserIdEnd > 0){
				var varUserId = varTemp.substring(0,varUserIdEnd);
				if (varUserId == "h9TzqD2/eNI01bMVk6w3gg=="){
					var url = "/include/ajax/AjaxGetSession.jsp";
					var param = "sname=viewLogG";
					if (libTypeCheck() == "PR"){
						var getShop4Price = new Ajax.Request(
							url,
							{
								method:'get',parameters:param,onComplete:function(originalRequest){
									var varViewLogG = originalRequest.responseText.trim();
									if (varViewLogG != "N"){
										top.openLogView("/etc/showLogView.jsp?lognum="+logNum);
									}else{
										if (top.document.getElementById("logView")){
											top.document.getElementById("logView").style.display = "";
										}else{
											var varLayerObj = document.createElement("DIV");
											varLayerObj.id = "logView";
											varLayerObj.style.position = "absolute";
											varLayerObj.style.top = "5px"
											varLayerObj.style.right = "20px"
											varLayerObj.style.zIndex=100;
											varLayerObj.innerHTML = "로그보기"
											varLayerObj.onclick = function(){
												var setSession = new Ajax.Request("/include/ajax/AjaxSetSession.jsp",{method:'get',parameters:"sname=viewLogG&svalue="});
											}
											top.document.body.insertBefore(varLayerObj,null);
										}
									}
								}
							}
						);
					}else{
						$.ajax({
							type: "GET",
							url: url,
							data: param,
							success: function(result){
								var varViewLogG = result;
								if (varViewLogG != "N"){
									top.openLogView("/etc/showLogView.jsp?lognum="+logNum);
								}else{
									if (top.document.getElementById("logView")){
										top.document.getElementById("logView").style.display = "";
									}else{
										var varLayerObj = document.createElement("DIV");
										varLayerObj.id = "logView";
										varLayerObj.style.position = "absolute";
										varLayerObj.style.top = "5px"
										varLayerObj.style.right = "20px"
										varLayerObj.style.zIndex=100;
										varLayerObj.innerHTML = "로그보기"
										varLayerObj.onclick = function(){
											var setSession = new Ajax.Request("/include/ajax/AjaxSetSession.jsp",{method:'get',parameters:"sname=viewLogG&svalue="});
										}
										top.document.body.insertBefore(varLayerObj,null);
									}
								}

							}
						});
					}
				}
			}
		}
	}
}
function openLogView(url){
	/*if(url.indexOf("/view/Detailmulti.jsp")>-1){
		//vip 개편작업
		url = url.replace("/view/Detailmulti.jsp","/detail.jsp");
		openLogView.logViewWin = window.open(url);
		openLogView.logViewWin.focus();
	}else{*/
		openLogView.logViewWin = window.open(url,"logViewWin","width=950,height=800,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no,left=800,top=100");
		openLogView.logViewWin.focus();
	//}
}
function changeColor(obj,color){
	obj.style.color = color;
}
function setPng24(obj) {
	if (BrowserDetect.browser == "Explorer" && (BrowserDetect.version == 6 || BrowserDetect.version == 7)){
		obj.width=obj.height=1;
		obj.className=obj.className.replace(/\bpng24\b/i,'');
		obj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+ obj.src +"',sizingMethod='image');"
		obj.src='';
	}
	return '';
}
function fnGetCookie2010( name ){
	var nameOfCookie = name + "=";
	var x = 0;
	while ( x <= document.cookie.length ){
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

function fnSetCookie2010( name, value, expiredays ){
	if (typeof(expiredays) == "undefined" || expiredays == null) {
		expiredays = "";
	}
	if (expiredays == ""){
		document.cookie = name + "=" + escape( value ) + "; path=/;"
	}else{
		var todayDate = new Date();
		todayDate.toGMTString();
		todayDate.setDate( todayDate.getDate() + expiredays );
		document.cookie = name + "=" + escape( value ) + "; path=/;expires="+ todayDate.toGMTString() + ";"
	}
}

function CmdSetCookie(param_gubun, param_modelno){
	var param = "type="+param_gubun+"&modelnos="+param_modelno;
	jQuery.ajax({
		type: "POST",
		url: "/common/jsp/include/m4_cookie.jsp",
		data: param,
		success: function(result){
		}
	});
}

function getCookie(c_name) {
    var i,x,y,ARRcookies=document.cookie.split(";");
    for(i=0;i<ARRcookies.length;i++) {
        x = ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
        y = ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
        x = x.replace(/^\s+|\s+$/g,"");
        if(x==c_name) {
            return unescape(y);
        }
    }
}
// 브라우져 정보 읽어오기
function getBrowserName() {
	/*
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
	*/

	var strReturn = "";
	if(navigator.userAgent.toLowerCase().indexOf("msie 6")>-1 && navigator.userAgent.toLowerCase().indexOf("msie 7")==-1 && navigator.userAgent.toLowerCase().indexOf("msie 8")==-1) {
		strReturn = "msie6";
	}else if(navigator.userAgent.toLowerCase().indexOf("msie 7")>-1 && navigator.userAgent.toLowerCase().indexOf("msie 8")==-1) {
		strReturn = "msie7";
	}else if(navigator.userAgent.toLowerCase().indexOf("msie 8")>-1) {
		strReturn = "msie8";
		if (navigator.userAgent.toLowerCase().indexOf("trident/7.0")>-1){
			strReturn = "msie11";
		}
	}else if(navigator.userAgent.toLowerCase().indexOf("msie 9")>-1) {
		strReturn = "msie9";
	}else if(navigator.userAgent.toLowerCase().indexOf("msie 10")>-1) {
		strReturn = "msie10";
	}else if(navigator.userAgent.toLowerCase().indexOf("msie")!=-1) {
		strReturn = "msie";
	}else if(navigator.userAgent.toLowerCase().indexOf("firefox")>-1) {
		strReturn = "firefox";
	}else if(navigator.userAgent.toLowerCase().indexOf("opera")>-1) {
		strReturn = "opera";
	}else if(navigator.userAgent.toLowerCase().indexOf("chrome")>-1) {
		strReturn = "chrome";
	}else if(navigator.userAgent.toLowerCase().indexOf("mozilla/5.0")>-1 && navigator.userAgent.toLowerCase().indexOf("trident/7.0")>-1 && navigator.userAgent.toLowerCase().indexOf("rv:11")>-1) {
		strReturn = "msie11";
	}else{

	}
	return strReturn;
}
var borwserName = getBrowserName();
function kowboxLinkByKbno(param){
	var uri = "/knowbox/List.jsp?kbno="+param;
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
	var win = window.open(uri,"","width="+w+" height="+h+" toolbar=yes,location=yes,directories=yes,status=yes,scrollbars=yes,resizable=yes,menubar=yes,personalbar=yes");
	win.focus();
}
function knowboxLinkByUri(param,wname){
	if (typeof(wname) == "undefined" || wname == null) {
		wname = "";
	}
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
	/*if(param.indexOf("/view/Detailmulti.jsp")>-1){
		//vip 개편작업
		param = param.replace("/view/Detailmulti.jsp","/detail.jsp");
		var win = window.open(param);
		win.focus();
	}else{*/
		var win = window.open(param,wname,"width="+w+" height="+h+" toolbar=yes,location=yes,directories=yes,status=yes,scrollbars=yes,resizable=yes,menubar=yes,personalbar=yes");
		win.focus();
	//}
}
function fireEvent(target,eventName){
	if(!eventName || !target)return;
	if(target.fireEvent)target.fireEvent("on"+eventName);
	else if(window.document.createEvent){
		var evt = window.document.createEvent('HTMLEvents');
		evt.initEvent(eventName, true, true);
		target.dispatchEvent(evt);
	}
}
String.prototype.replaceAll = function(from, to) {
    return this.replace(new RegExp(from, "g"), to);

}
   String.prototype.isEmpty = function() {
       return this.trim().length == 0;
   }

   function cumulativeOffset(element) {
		var valueT = 0, valueL = 0;

		do {
			valueT += element.offsetTop || 0;
			valueL += element.offsetLeft || 0;
			element = element.offsetParent;
		} while (element);

		return [valueL, valueT];
	}

   function check2Hyphen(keyword){
       var bReturn = false;
       if (keyword.length >= 2){
           if (keyword.substring(1,2) == "-" || keyword.substring(1,2) == "_" || keyword.substring(1,2) == " "){
               bReturn = true;
           }
       }
       return bReturn;
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

   function fnInsertHitLog(_idx,type){
       $.ajax({
           type: "POST",
           url: "/main/main1003/ajax/setHitCount_Ajax.jsp",
           data: "idx=" + _idx + "&type=" + type,
           success: function(result){
           }
       });
   }

	function setGEventLog(cateName, subCateName, name) {
		try {
			ga('send', 'event', cateName, subCateName, name);
		} catch(e) {}
	}

	function fnGetDate(){
		var date = new Date();

		return String(date.getFullYear()) + String((String(date.getMonth()+1).length == 1 ? "0" : "") + (date.getMonth() + 1)) + String((String(date.getDate()).length == 1 ? "0" : "") + date.getDate());
	}

	function fnGetDate2(){
	    var date = new Date();

	    return String(date.getFullYear()) + String((String(date.getMonth()+1).length == 1 ? "0" : "") + (date.getMonth() + 1)) + String((String(date.getDate()).length == 1 ? "0" : "") + date.getDate()) + String((String(date.getHours()).length == 1 ? "0" : "") + date.getHours());
	}
	//제조사+브랜드+모델명 조합 노출 규칙
	function getModel_FBN(cate, modelnm, factory, brand){
		var exp_modelnm = modelnm;
		var exp_factory = factory;
		var exp_brand = brand;

		//제조사=브랜드시 브랜드 비노출
		if(factory.toLowerCase()==(brand.toLowerCase())){
			exp_brand = "";
		}
		if(factory=="불명" || factory=="[불명]" || factory=="호환업체" || factory=="[호환업체]"){
			exp_factory = "";
		}
		if(brand=="불명" || brand=="[불명]" || brand=="호환업체" || brand=="[호환업체]"){
			exp_brand = "";
		}

		//제조사 or 브랜드 선택 비노출
		if(cate.substr(0,4)=="0304" || cate.substr(0,4)=="0305"){
			exp_brand = "";
		}else if(cate.substr(0,4)=="0903" || cate.substr(0,4)=="0912" || cate.substr(0,4)=="0913" || cate.substr(0,4)=="0919" || cate.substr(0,4)=="0923" || cate.substr(0,4)=="0937" || cate.substr(0,4)=="1015" || cate.substr(0,4)=="1001"){
			exp_factory = "";
		}else if(cate.substr(0,4)=="1007" || cate.substr(0,4)=="1647"){
			exp_factory = "";
			exp_brand = "";
		}else if(cate.substr(0,2)=="08" || cate.substr(0,2)=="14"){
			exp_factory = "";
		}

		//제조사=브랜드=모델명 일때 모델명만 노출
		if(factory.toLowerCase()==modelnm.toLowerCase() && brand.toLowerCase()==modelnm.toLowerCase()){
			exp_factory = "";
			exp_brand = "";
		}

		//제조사/브랜드가 모두 비노출되는 경우 선택 노출
		if(exp_factory=="" && exp_brand==""){
			if(cate.substr(0,4)=="0304" || cate.substr(0,4)=="0305"){
				exp_factory = factory;
			}else if(cate.substr(0,4)=="0903" || cate.substr(0,4)=="0912" || cate.substr(0,4)=="0913" || cate.substr(0,4)=="0919" || cate.substr(0,4)=="0923" || cate.substr(0,4)=="0937" || cate.substr(0,4)=="1015" || cate.substr(0,4)=="1001"){
				exp_brand = brand;
			}else if(cate.substr(0,2)=="08" || cate.substr(0,2)=="14"){
				exp_brand = brand;
			}
		}

		var strModel_FBN  = new Array(3);
		strModel_FBN[0] = exp_modelnm;
		strModel_FBN[1] = exp_factory;
		strModel_FBN[2] = exp_brand;

		return strModel_FBN;
	}

	function getModel_FBN2(cate, modelnm, factory, brand){
		var arrRtn = getModel_FBN(cate, modelnm, factory, brand);
		return arrRtn[1]+(arrRtn[1].isEmpty() ? "" :" ")+arrRtn[2]+(arrRtn[2].isEmpty() ? "" :" ")+arrRtn[0];
	}

	function chkPassCombine(pw){
	    var matchNum = 0;

	    var arrReg = [
                  new RegExp("^.*[A-z]+.*$","g"),
                  new RegExp("^.*[0-9]+.*$","g"),
                  new RegExp("^.*[!@#\$%\^\&\*\(\)]+.*$","g")
	    ];

	    var allowReg = new RegExp("^[A-z0-9,!,@,#,\$,%,\^,\&,\*,\(,\)]{8,15}$");

        if(pw.match(arrReg[0]))
            ++matchNum;
        if(pw.match(arrReg[1]))
            ++matchNum;
        if(pw.match(arrReg[2]))
            ++matchNum;

        if(matchNum>=3 && pw.match(allowReg))
            return true;
        else
            return false;
	}
	if(typeof(MSLOG_var)=="undefined"){
		var MSLOG_var = "";
		//var script = document.createElement("script");
		//script.type = "text/javascript";
		//script.src = document.location.protocol + "//log1.makeshop.co.kr/js/msfunc.js";
		//document.getElementsByTagName("head")[0].appendChild(script);
	}
