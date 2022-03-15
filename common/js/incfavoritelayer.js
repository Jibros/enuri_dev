
function noteopen(varPart,varType){
	window.open("/view/Detailmulti_Getinfo_Note.jsp?part="+varPart+"&type="+varType,"note","width=581,height=688,left=10,top=10,toolbar=no,directories=no,status=no,scrollbars=no,resizable=no,menubar=no");
}

function CmdGotoPurchaseGuide(cate,kind,kbno){
	//패션 명품관
	if (cate == "1460" || cate == "1461"){
		cate = "1459";
	}
	//var wWidth = 1014;
	var wWidth = 734+30+6;
	if (typeof(kind)=="number" && kind==20) wWidth = wWidth+35;
	var wHeight = screen.availHeight;
	var win = window.open("/purchaseguide/GuideLayer.jsp?kind="+kind+"&cate="+cate+"&kbno="+((typeof(kbno)=="number")?kbno:0)+"&btnhits=yes","GuideLayer","width="+wWidth+",height="+wHeight+",left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=yes,resizable=no,menubar=no");
	win.focus();
	document.getElementById("div_favorite").style.display = "none";
}
/*
function insertLog(logNum,shop_code){
	//alert(logNum);
	var url = "/view/Loginsert.jsp";
	var param = "kind="+logNum+"&modelno="+shop_code;
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param
		}
	);
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
				if (varUserId == "nova23"){
					var url = "/include/ajax/AjaxGetSession.jsp";
					var param = "sname=viewLogG";
					var getShop4Price = new Ajax.Request(
						url,
						{
							method:'get',parameters:param,onComplete:function(originalRequest){
								var varViewLogG = originalRequest.responseText.trim();
								if (varViewLogG != "N"){
									var logView = window.open("/etc/showLogView.jsp?lognum="+logNum,"logView","width=900,height=800,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no,left=800,top=100");
								}
							}
						}
					);
				}
			}
		}
	}
}
*/
function fn_gosingo()
{
	if(!opener.closed)
	{
		opener.fn_singoview();
		opener.focus();
	}else{
		alert(" 비교목록 창이 닫혀 있기 때문에 신고할 수 없습니다.");
	}
}


function go_icon_main(){
	//location.href="?pagenm=<%=strPageNm%>&icon=Y";
	document.frmFavorite.action = "/include/IncFavoriteLayer_2010.jsp";

	document.frmFavorite.icon.value = "Y";
	document.frmFavorite.target = "ifrmFavorite";
	if (document.frmFavorite.batang.value == "Y"){
		document.getElementById("ifrmFavorite").style.left = Position.cumulativeOffset($("favoritePoB"))[0];
		document.getElementById("ifrmFavorite").style.top = Position.cumulativeOffset($("favoritePoB"))[1];
	}else{
		document.getElementById("ifrmFavorite").style.left = Position.cumulativeOffset($("div_favorite"))[0];
	}
	document.getElementById("ifrmFavorite").style.display = "inline";
	document.frmFavorite.submit();
}
function go_icon_car(){
	location.href = "?stp=1&icon=Y&pagenm=<%=strPageNm%>&infourl="+escape("<%=sInfoUrl%>")+"&";
}
function go_icon_q(){
	location.href = "?modelnm=<%=strModelName%>&cate=<%=strFullCate%>&pagenm=<%=strPageNm%>&icon=Y&isq=Y&seq=<%=strSeq%>&orderby1=<%=strOrderBy1%>&orderby2=<%=strOrderBy2%>&op=<%=strOpenExpect%>&modelno=<%=strModelno%>";
}
function goMytodayList(){
	opener.top.location.href = "/view/Mytodayviewselectlist.jsp";
	window.close();
}
function sendMailMyTodayList(){
	var sURL="/view/Mytodayviewlist.jsp?ordby=mlm_date&cmd=img&cmdkind=recommend";
	OpenWindow(sURL,"RecommendMail",800,600,"yes","no");
	window.close();
}
function hideFavoriteLayer(){
	if (document.getElementById('incFavoriteLayer')){
		if (document.getElementById('incFavoriteLayer').style.display != "none"){
			document.getElementById('incFavoriteLayer').style.display='none';
		}
	}
	if(document.getElementById("enuriListFrame")){
		if (document.getElementById("enuriListFrame").contentWindow.document.getElementById('ifrmFavorite')){
			if (document.getElementById("enuriListFrame").contentWindow.document.getElementById('ifrmFavorite').style.display != "none"){
				document.getElementById("enuriListFrame").contentWindow.document.getElementById('ifrmFavorite').style.display='none';
			}
		}
	}
}
function chkEventBatang(){ //바탕화면 이벤트 (비스타 : 즐겨찾기, 그외: 바탕화면)
	if(navigator.appName == "Microsoft Internet Explorer") {
		var Agent = navigator.userAgent
		Agent = Agent.toLowerCase();
		if(Agent.indexOf("nt 6.")>0 || Agent=="mozilla/4.0 (compatible; msie 6.0)") {
			if(answer = confirm("Vista,윈도우7 이용자는 즐겨찾기를 통해 응모해주세요. \n즐겨찾기를 등록하시겠습니까?")){
				window.external.AddFavorite('http://www.enuri.com', '에누리(가격비교)');
				//return false;
			}else{
				//return false;
			}
		}else{
			go_icon();
		}
	}
}
//==============================================================
//비스타 여부 체크
//==============================================================


function checkVista(){
	if(navigator.appName == "Microsoft Internet Explorer") {
		var Agent = navigator.userAgent
		Agent = Agent.toLowerCase();
		if(Agent.indexOf("nt 6.")>0 || Agent=="mozilla/4.0 (compatible; msie 6.0)") {
			if(document.getElementById("trBatang")){
				document.getElementById("trBatang").style.display = "none";
			}
			if(document.getElementById("img_bt_favor")){

				document.getElementById("img_bt_favor").src = var_img_enuri_com + "/images/view/header_image/1121/allbtn_06.gif";
			}
		}
	}
	//전역변수 입니다.
	var navName = navigator.appName; //브라우져 이름...
	var brVer = navigator.userAgent;//브라우져 정보

	//익스플로러 버전체크 함수
	var brVerId = brVer.indexOf('MSIE');//브라우져 정보에서 'MSIE'라는 부분의 문자열
	brNum = brVer.substr(brVerId,8);//브라우져 버전('MSIE' 포함..)..
	brNum2 = brNum.substr(5,1)//브라우져 버번. 숫자만...

	if(document.getElementById("trSearch")){
		if(brNum2 < 7){
			document.getElementById("trSearch").style.display = "none";
		}
	}
}
// 이미지 반투명
function setPng24(obj) {
	if (navigator.userAgent.toLowerCase().indexOf('msie 8') < 0){
		obj.width=obj.height=1;
		obj.className=obj.className.replace(/\bpng24\b/i,'');
		obj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+ obj.src +"',sizingMethod='image');"
		obj.src='';
	}
	return '';
}
function makeLink(el){
	var urlLinkObj ;
	if(document.URL.indexOf("/search/EnuriSearch.jsp") >= 0 ){
		urlLinkObj = document.getElementById('url_link');
	}else if(document.URL.indexOf("/view/Sslist.jsp") >= 0 || document.URL.indexOf("/include/IncMetaList.jsp") >= 0 || document.URL.indexOf("/include/IncMetaMain.jsp") >= 0){
		urlLinkObj = document.getElementById('url_link');
	}else if(document.URL.indexOf("/include/IncMetaTourList.jsp") >= 0 || document.URL.indexOf("/include/IncEcouponList.jsp") >= 0){
		urlLinkObj = document.getElementById('url_link');
	}else{
		urlLinkObj = document.getElementById('enuriListFrame').contentWindow.document.getElementById('url_link');
	}
	if( document.createEvent ) {
  		var evObj = document.createEvent('MouseEvents');
		evObj.initEvent( 'click', true, false );
		urlLinkObj.dispatchEvent(evObj);
	}else if( document.createEventObject ) {
		urlLinkObj.fireEvent('onclick');
	}
}
function makeUrl(el){
	var urlLinkObj ;
	if(document.URL.indexOf("/search/EnuriSearch.jsp") >= 0 ){
		urlLinkObj = document.getElementById('url_copy');
	}else if(document.URL.indexOf("/view/Sslist.jsp") >= 0 || document.URL.indexOf("/include/IncMetaList.jsp") >= 0 || document.URL.indexOf("/include/IncMetaMain.jsp") >= 0){
		urlLinkObj = document.getElementById('url_copy');
	}else if(document.URL.indexOf("/include/IncMetaTourList.jsp") >= 0 || document.URL.indexOf("/include/IncEcouponList.jsp") >= 0){
		urlLinkObj = document.getElementById('url_link');
	}else if(document.URL.indexOf("/tour2012/") >= 0 || document.URL.indexOf("/Tour_Tourjockey.jsp") >= 0 ){
		urlLinkObj = document.getElementById('url_copy');
	}else{
		urlLinkObj = document.getElementById('enuriListFrame').contentWindow.document.getElementById('url_copy');
	}

	if( document.createEvent ) {
  		var evObj = document.createEvent('MouseEvents');
		evObj.initEvent( 'click', true, false );
		urlLinkObj.dispatchEvent(evObj);
	}else if( document.createEventObject ) {
		urlLinkObj.fireEvent('onclick');
	}
}
function makeFavorite(el){
	if(document.URL.indexOf("/Index.jsp")>=0 || document.URL.indexOf("/etc/")>=0 || document.URL.indexOf("/Listmall.jsp")>=0 || document.URL.indexOf("/faq/Faq_List.jsp")>=0 || (document.URL.length<29 && (document.URL.charAt(document.URL.length-1)=='/' || document.URL.charAt(document.URL.length-2)=='/#'))) {
		var url = document.URL;
		var urlname = document.title.innerHTML;
		if(typeof urlname == 'undefined' ){
			urlname = document.title;
		}
		favoriteURL_NEW(url, urlname);

		return;
	}

	var urlLinkObj ;
	if(document.URL.indexOf("/search/EnuriSearch") >= 0 ){
		urlLinkObj = document.getElementById('add_favorite');
	}else if(document.URL.indexOf("/view/Sslist.jsp") >= 0 || document.URL.indexOf("/include/IncMetaList.jsp") >= 0 || document.URL.indexOf("/include/IncMetaMain.jsp") >= 0){
		urlLinkObj = document.getElementById('add_favorite');
	}else if(document.URL.indexOf("/include/IncMetaTourList.jsp") >= 0 || document.URL.indexOf("/include/IncEcouponList.jsp") >= 0){
		urlLinkObj = document.getElementById('url_link');
	}else if(document.URL.indexOf("/tour2012/") >= 0 || document.URL.indexOf("/Tour_Tourjockey.jsp") >=0){
		urlLinkObj = document.getElementById('add_favorite');
	}else{
		urlLinkObj = document.getElementById('enuriListFrame').contentWindow.document.getElementById('add_favorite');
	}

	if( document.createEvent ) {
  		var evObj = document.createEvent('MouseEvents');
		evObj.initEvent( 'click', true, false );
		urlLinkObj.dispatchEvent(evObj);
	}else if( document.createEventObject ) {
		urlLinkObj.fireEvent('onclick');
	}
}

function makeBatang(el){
	var urlMainFlag = false;
	if(document.URL.indexOf("/Index.jsp")>=0 || (document.URL.length<28 && document.URL.charAt(document.URL.length-1)=='/')) {
		urlMainFlag = true;
	}

	var urlLinkObj ;
	if(document.URL.indexOf("/search/EnuriSearch") >= 0 || document.URL.indexOf("/Index.jsp") >=0 || urlMainFlag ){
		urlLinkObj = document.getElementById('add_batang');
	}else if(document.URL.indexOf("/view/Sslist.jsp") >= 0 || document.URL.indexOf("/include/IncMetaList.jsp") >= 0 || document.URL.indexOf("/include/IncMetaMain.jsp") >= 0){
		urlLinkObj = document.getElementById('add_batang');
	}else if(document.URL.indexOf("/include/IncMetaTourList.jsp") >= 0 || document.URL.indexOf("/include/IncEcouponList.jsp") >= 0){
		urlLinkObj = document.getElementById('url_link');
	}else{
		urlLinkObj = document.getElementById('enuriListFrame').contentWindow.document.getElementById('add_batang');
	}
	if( document.createEvent ) {
  		var evObj = document.createEvent('MouseEvents');
		evObj.initEvent( 'click', true, false );
		urlLinkObj.dispatchEvent(evObj);
	}else if( document.createEventObject ) {
		urlLinkObj.fireEvent('onclick');
	}
}
// type=1 : 트위터, type=2 : 미투데이, type=3 : 페이스북
function goSnsLink(type) {
	var url = "";
	if(document.URL.indexOf("/view/Sslist.jsp") >= 0){
		url = document.getElementById('fav_cate_link').href;
		insertLog(5953);
		if(type==1) {
			insertLog(5950);
		}
		if(type==2) {
			insertLog(5952);
		}
		if(type==3) {
			insertLog(5951);
		}
	}else if(document.URL.indexOf("/tour2012/") >= 0 || document.URL.indexOf("/Tour_Tourjockey.jsp") >= 0 ){
		url = document.getElementById('fav_cate_link').href;
		if(type==1) {
			insertLog(5950);
		}
		if(type==2) {
			insertLog(5952);
		}
		if(type==3) {
			insertLog(5951);
		}
	}else if(document.URL.indexOf("/search/EnuriSearch") >= 0 ){
		url = document.getElementById('fav_cate_link').href;
		insertLog(5953);
		if(type==1) {
			insertLog(5950);
		}
		if(type==2) {
			insertLog(5952);
		}
		if(type==3) {
			insertLog(5951);
		}
	}else{
		url = document.getElementById('enuriListFrame').contentWindow.document.getElementById('fav_cate_link').href;
		insertLog(5945);
		if(type==1) {
			insertLog(5942);
		}
		if(type==2) {
			insertLog(5944);
		}
		if(type==3) {
			insertLog(5943);
		}
	}
	var content = "";
	/*
	if (document.getElementById('enuriListFrame').contentWindow.document.getElementById('location')){
		content = encodeURIComponent(document.getElementById('enuriListFrame').contentWindow.document.getElementById('location').innerHTML.stripTags());
	}else if (document.getElementById('enuriListFrame').contentWindow.document.getElementById('location2010')){
		content = encodeURIComponent(document.getElementById('enuriListFrame').contentWindow.document.getElementById('location2010').innerHTML.stripTags());
	}
	*/

	content = top.document.title.trim();
	if (content.indexOf("[") > 0){
		content = content.substring(0,content.indexOf("["));
	}
	// 트위터
	if(type==1) {
		insertLog(5958);
		//http://twitter.com/home?status=전달할컨텐츠
		//window.open("http://twitter.com/home?status="+encodeURIComponent(content + " " + url));
		window.open("http://twitter.com/intent/tweet?text="+encodeURIComponent(content) + "&url="+encodeURIComponent(url));
	}
	// 미투데이
	if(type==2) {
		insertLog(5960);
		//http://me2day.net/posts/new?new_post[body]=전달할컨텐츠
		window.open("http://me2day.net/posts/new?new_post[body]="+encodeURIComponent(content + " " + url));
	}
	// 페이스북
	if(type==3) {
		insertLog(5959);
		//http://www.facebook.com/sharer.php?u=<공유할 url>&t=<컨텐트 타이틀>
		//showLog(url)
		if(document.URL.indexOf("/search/EnuriSearch.jsp") >= 0 ){
			var skeyword = "";
			var params = window.location.search.substring( 1 ).split( '&' );
			for( var i = 0, l = params.length; i < l; ++i ) {
				var parts = params[i].split( '=' );
				switch( parts[0] ) {
					case 'keyword':
					skeyword =  parts[1];
					break;
				}
		  	}
			url = top.document.URL.substring(0,top.document.URL.indexOf("?")) + "?keyword=" +skeyword
		}
		var fullUrl = "http://www.facebook.com/share.php?u="+url
		fullUrl = encodeURI(fullUrl);
		window.open(fullUrl);
	}

}
var varReloadCnt = 0;
function reloadQrImg(qrName){
	document.getElementById("qr_img").src = "http://img.enuri.info/images/blank.gif";
	setTimeout(function(){
		if (varReloadCnt < 5){
			document.getElementById("qr_img").src = "/view/qrcode/qr"+qrName+".png?_t="+(new Date()).getTime();
			varReloadCnt++;
		}else{
			document.getElementById("qr_img").src = "http://img.enuri.info/images/blank.gif";
		}
	},1000);

}
function setQrStyle(){
	document.getElementById("qr_img").style.marginLeft = "20px";
	document.getElementById("qr_img").style.display = "";
	varReloadCnt = 0;
}
function makeQrCode(){
	if (document.getElementById("qr_layer")){
		if (document.getElementById("qr_layer").style.display != "none"){
			document.getElementById("qr_layer").style.display = "none";
			//document.getElementById("img_make_qr").src = var_img_enuri_com + "/2010/images/view/qr.gif";
			return;
		}
	}
	insertLog(5937);
	var params = window.location.search.substring( 1 ).split( '&' );
	var cate;
	for( var i = 0, l = params.length; i < l; ++i ) {
		var parts = params[i].split( '=' );
		switch( parts[0] ) {
			case 'cate':
			cate =  parts[1];
			break;
		}
  	}
  	var newDate = new Date();
  	var qrName = newDate.getTime();

  	function showQr(originalRequest){
  		setTimeout(function(){
			if (document.getElementById("qr_layer")){
				if (document.getElementById("qr_layer").style.display == "none"){
					document.getElementById("qr_img").src = "http://storage.enuri.com/qrcode/qr"+qrName+".png";
					document.getElementById("qr_img").style.marginLeft = "20px";
					document.getElementById("qr_layer").style.display = "";
					//document.getElementById("img_make_qr").src = var_img_enuri_com + "/2010/images/view/qr_noline.gif";
				}
			}else{
				var varQrLayer = document.createElement("DIV");
				varQrLayer.id = "qr_layer";
				varQrLayer.style.position = "absolute";
				varQrLayer.style.top = (Position.cumulativeOffset($("img_make_qr"))[1]+81)+"px";
				if (Position.cumulativeOffset($("img_make_qr"))[0] + 338 > document.getElementById("wrap").offsetWidth){
					varQrLayer.style.left = (document.getElementById("wrap").offsetWidth - 400)+"px";
				}else{
					varQrLayer.style.left = "40px";
				}

				varQrLayer.style.width="351px";
				varQrLayer.style.height="199px";
				varQrLayer.style.zIndex = 10;
				//varQrLayer.style.backgroundImage="url('"+var_img_enuri_com+"/2010/images/view/qr_layer.gif')";
				var varQrLayerHtml = "";
				varQrLayerHtml = "<div><img src=\""+var_img_enuri_com+"/2010/images/view/2014/qr_layer_01.png\" class=\"png24\" border=\"0\" />";
				varQrLayerHtml = varQrLayerHtml + "<img src=\""+var_img_enuri_com+"/2010/images/view/2014/x.gif\" width=\"10\" height=\"10\" border=\"0\" style=\"cursor:pointer;position:absolute;top:18px;right:70px;\" onclick=\"makeQrCode()\"/></div>";
				varQrLayerHtml = varQrLayerHtml + "<div id=\"qr_inner\">";
				varQrLayerHtml = varQrLayerHtml + "<img id=\"qr_img\" onload=\"setQrStyle()\" onerror=\"reloadQrImg('"+qrName+"')\" src=\""+"http://storage.enuri.com/qrcode/qr"+qrName+".png\" width=\"150\" height=\"150\" style=\"margin-left:20px;display:none\">";
				varQrLayerHtml = varQrLayerHtml + "<p style=\"font-family:맑은 고딕;color:#000000;font-size:12px;position:absolute;left:165px;top:100px\">QR코드 찍고,<br>모바일 버전으로 이동</p></div>";
				varQrLayerHtml = varQrLayerHtml + "<div><img src=\""+var_img_enuri_com+"/2010/images/view/2014/qr_layer_03.png\" class=\"png24\" border=\"0\" /></div>";
				varQrLayer.innerHTML = varQrLayerHtml;
				document.getElementById("wrap").insertBefore(varQrLayer,null);
				//document.getElementById("img_make_qr").src = var_img_enuri_com + "/2010/images/view/qr_noline.gif";
			}
		},1000);

  	}

	if (cate == "03043404" || cate == "03043405"){
		cate = "0304";
	}
	if (cate == "03052201" || cate == "03052202"){
		cate = "0305";
	}
	var aUrl = "/view/make_qr.jsp";
	var param = "url="+encodeURIComponent("http://m.enuri.com/mobile2/m4_list.jsp?cate=" + cate + "&_qr=y");
	//var param = "url="+encodeURIComponent("http://m.enuri.com/mobile/Index.jsp?cate=" + cate + "&_qr=y");
	param = param + "&t=" + qrName;
	var getMakeQr = new Ajax.Request(
		aUrl,
		{
			method:'get',parameters:param,async:false,onComplete:showQr
		}
	);

}
//2015.06 qr코드 리뉴얼
function snsLayerCateToggle(oid){
	var oPopup = document.getElementById(oid);
	if(oPopup.style.display=="none"){
		oPopup.style.display = "block";
		if(oid=="snsLayerPopup2"){ //qr코드 노출시
			insertLog(5937);
			document.getElementById("snsLayerPopup").style.display = "none";
			setQrCodeImg('cate');
		}else{
			insertLog(12333);
			document.getElementById("snsLayerPopup2").style.display = "none";
		}
	}else{
		oPopup.style.display = "none";
		document.getElementById("snsLayerPopup2").className = document.getElementById("snsLayerPopup2").className.replace(/(?:^|\s)spread(?!\S)/g , '');
	}
}
function snsLayerSearchToggle(oid){
	if(typeof(document.getElementById('searchListFrame').contentWindow.makeFavorite)=="undefined"){ //검색결과 없음
		document.getElementById("snsLayerPopup").style.display = "none";
		document.getElementById("snsLayerPopup2").style.display = "none";
		return;
	}
	var oPopup = document.getElementById(oid);
	if(oPopup.style.display=="none"){
		oPopup.style.display = "block";
		if(oid=="snsLayerPopup2"){ //qr코드 노출시
			insertLog(12344);
			document.getElementById("snsLayerPopup").style.display = "none";
			setQrCodeImg('search');
		}else{
			insertLog(12340);
			document.getElementById("snsLayerPopup2").style.display = "none";
		}
	}else{
		oPopup.style.display = "none";
		document.getElementById("snsLayerPopup2").className = document.getElementById("snsLayerPopup2").className.replace(/(?:^|\s)spread(?!\S)/g , '');
	}
}
var qrCodeResetTryCnt = 0;
function setQrCodeImg(part){
	var params = window.location.search.substring( 1 ).split( '&' );
	var cate;
	var skeyword;

	if(part=='cate'){
		for( var i = 0, l = params.length; i < l; ++i ) {
			var parts = params[i].split( '=' );
			switch( parts[0] ) {
				case 'cate':
				cate =  parts[1];
				break;
			}
	  	}
		if (cate == "03043404" || cate == "03043405"){
			cate = "0304";
		}
		if (cate == "03052201" || cate == "03052202"){
			cate = "0305";
		}
		if (cate == "145920"){
			cate = "1459";
		}
	}else if(part=='search'){
		for( var i = 0, l = params.length; i < l; ++i ) {
			var parts = params[i].split( '=' );
			switch( parts[0] ) {
				case 'keyword':
				skeyword =  parts[1];
				break;
			}
	  	}
	}

  	var newDate = new Date();
  	var qrName = newDate.getTime();

	if(document.getElementById("qrcodeImg").src==""){
		if(part=='cate'){
			document.getElementById("qrcodeImg").src = "/view/qrcode/qr_cate_"+cate+".png?v="+(new Date()).getTime();
			//document.getElementById("qrcodeImg").src = "http://storage.enuri.info/pic_upload/qrcode/qr_cate_"+cate+".png?v="+qrName;
		}else if(part=='search'){
			document.getElementById("qrcodeImg").src = "/view/qrcode/qr_search_"+qrName+".png?v="+qrName;
			//document.getElementById("qrcodeImg").src = "http://storage.enuri.info/pic_upload/qrcode/qr_search_"+qrName+".png?v="+qrName;
		}
	}else{ //onerror이므로 생성 호출
		if(qrCodeResetTryCnt<5){ //5회까지만 생성 재시도
			qrCodeResetTryCnt++;

			function showQr(originalRequest){
				setTimeout(function(){
					if(part=='cate'){
						document.getElementById("qrcodeImg").src = "/view/qrcode/qr_cate_"+cate+".png?v="+qrName;
					}else if(part=='search'){
						document.getElementById("qrcodeImg").src = "/view/qrcode/qr_search_"+qrName+".png?v="+qrName;
					}
				},1000);
			}
			var aUrl = "/view/make_qr2.jsp";
			var param = "";
			if(part=='cate'){
				param = "url="+encodeURIComponent("http://m.enuri.com/mobile2/m4_list.jsp?cate=" + cate + "&_qr=y");
				param = param + "&t=qr_cate_"+cate;
				var getMakeQr = new Ajax.Request(
					aUrl,
					{
						method:'get',parameters:param,async:false,onComplete:showQr
					}
				);
			}else if(part=='search'){
				param = "url="+encodeURIComponent("http://m.enuri.com/mobilefirst/search.jsp?keyword=" + skeyword + "&_qr=y");
				param = param + "&t=qr_search_"+qrName;
				commonAjaxRequest(aUrl, param, showQr);
			}
		}else{
			return;
		}
	}
}
function openListHeaderSms(){
	document.getElementById("snsLayerPopup2").className = "enuriapp_box spread";
	insertLog(12334);
}
function openSearchHeaderSms(){
	document.getElementById("snsLayerPopup2").className = "enuriapp_box spread";
	insertLog(12341);
}
function sendListHeaderSms(part, title){
	if(typeof(title)=="undefined") title = "";
	var myphone = document.getElementById("phonenum_ListHeader").value;
	var rurl;
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
	/**
	var urlLinkObj ;
	if(document.URL.indexOf("/search/EnuriSearch.jsp") >= 0 ){
		urlLinkObj = document.getElementById('url_for_copy');
	}else if(document.URL.indexOf("/view/Sslist.jsp") >= 0 || document.URL.indexOf("/include/IncMetaList.jsp") >= 0 || document.URL.indexOf("/include/IncMetaMain.jsp") >= 0){
		urlLinkObj = document.getElementById('url_for_copy');
	}else if(document.URL.indexOf("/include/IncMetaTourList.jsp") >= 0 || document.URL.indexOf("/include/IncEcouponList.jsp") >= 0){
		urlLinkObj = document.getElementById('url_for_copy');
	}else{
		urlLinkObj = document.getElementById('enuriListFrame').contentWindow.document.getElementById('url_for_copy');
	}
	rurl = urlLinkObj.value;

	if(rurl!=""){
		rurl = rurl.replace(/\?/ig, "--***--");
		rurl = rurl.replace(/\&/ig, "--**--");
		document.getElementById("ifListHeader").src = "/common/jsp/Ajax_ListHeader_Sms_Proc.jsp?rurl="+rurl+"&phoneno="+myphone;
	}else{
		alert("주소를 읽어오지 못했습니다.");
	}
	*/
	var cate;
	var skeyword;
	var params = window.location.search.substring( 1 ).split( '&' );

	if(part=='cate'){
		insertLog(12422);
		for( var i = 0, l = params.length; i < l; ++i ) {
			var parts = params[i].split( '=' );
			switch( parts[0] ) {
				case 'cate':
				cate =  parts[1];
				break;
			}
	  	}
		if (cate == "03043404" || cate == "03043405"){
			cate = "0304";
		}
		if (cate == "03052201" || cate == "03052202"){
			cate = "0305";
		}
		rurl = encodeURIComponent("http://m.enuri.com/mobile2/m4_list.jsp?cate=" + cate + "&_qr=y");
	}else if(part=='search'){
		insertLog(12423);
		for( var i = 0, l = params.length; i < l; ++i ) {
			var parts = params[i].split( '=' );
			switch( parts[0] ) {
				case 'keyword':
				skeyword =  parts[1];
				break;
			}
	  	}
	  	rurl = encodeURIComponent("http://m.enuri.com/mobilefirst/search.jsp?keyword=" + skeyword + "&_qr=y");
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
function checkForNumber() {
  var key = event.keyCode;
  if(!(key==8||key==9||key==13||key==46||key==144||
      (key>=48&&key<=57)||key==110||key==190)) {
      alert("숫자만 입력해주세요.");
      event.returnValue = false;
  }
}