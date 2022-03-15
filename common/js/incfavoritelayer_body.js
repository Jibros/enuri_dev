function copy_LINK_NEW(address,param_where){
	if (window.clipboardData) { 
		window.clipboardData.setData("Text",address);
		copy_LINK(address,param_where);
	} else if (window.netscape) { 
		try {
			netscape.security.PrivilegeManager.enablePrivilege('UniversalXPConnect'); 
			var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard); 
			if (!clip) return; 
			var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable); 
			if (!trans) return; trans.addDataFlavor('text/unicode'); 
			var str = new Object(); 
			var len = new Object(); 
			var str = Components.classes['@mozilla.org/supports-string;1'].createInstance(Components.interfaces.nsISupportsString); 
			var copytext = address; str.data = copytext; trans.setTransferData('text/unicode',str,copytext.length*2); 
			var clipid = Components.interfaces.nsIClipboard; 
			if (!clipid) return false;
			clip.setData(trans,null,clipid.kGlobalClipboard); 
			copy_LINK(address,param_where);
		} catch(e) {
			//alert("signed.applets.codebase_principal_support를 설정해주세요!\n"+e);
			alert("signed.applets.codebase_principal_support를 설정해주세요!");
		}
	}else{
		alert("해당 브라우저에서는 지원하지 않습니다.");
	} 
	return false;
}
function copy_LINK_NEW2(address,param_where)
{ 
	id = "toCopy";
	document.getElementById(id).innerText = address;
	var inputStr = document.getElementById(id).innerText; 

	if( typeof inputStr == 'undefined' ) inputStr = document.getElementById(id).textContent; 
	if( navigator.userAgent.indexOf('MSIE') != -1 ) { 
		window.clipboardData.setData('Text', inputStr); 
	} else { 
		var flashcopier = 'flashcopier'; 
		if(!document.getElementById(flashcopier)) { 
		var divholder = document.createElement('div'); 
		divholder.id = flashcopier; 
		document.body.appendChild(divholder); 
	} 
	document.getElementById(flashcopier).innerHTML = ''; 
	var divinfo = '<embed src=\'http:/<%=ConfigManager.IMG_ENURI_COM%>/images/clipboard_test.swf\' width=\'0\' height=\'0\' type=\'application/x-shockwave-flash\' flashvars=\'clipboard='+encodeURIComponent( inputStr )+'\'></embed>'; 
		document.getElementById(flashcopier).innerHTML = divinfo; 
	}
	copy_LINK(inputStr,param_where);
}

function copy_LINK(param,param_where){

	if (param_where=="goods" || param_where=="ever_goods" || param_where=="reuse_goods" || param_where=="quick"){
		alert("해당 상품의 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="cate" || param_where=="brand" ){
		alert("해당 분류의 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="ever_main"){
		alert("에누리 오픈마켓메인의 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="ever_shop"){
		alert("에누리 오픈마켓 미니샵의 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="callrate"){
		alert("통화요금비교 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="nego"){
		alert("흥정하기 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="star"){
		alert("스탸삽 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="purchaseguide"){
		alert("구매가이드 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="knowbox_expert"){
		alert("전문가 질문-가이드 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="compare"){
		alert("상품비교 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="knowbox"){
		alert("지식통 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="plan"){
	    alert("기획전모음 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="main"){
	    alert("에누리닷컴 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="auto" || param_where=="autocome" || param_where=="automenu" || param_where=="autonew"){
	    alert("신차비교 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="tour" || param_where=="tour2012"){
		alert("여행상품검색 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="today"){
		alert("최근 본 상품의 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="search"){
		alert("검색결과 가져가기에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="event"){
		alert("이벤트 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="main_poll"){
		alert("토론방 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="social"){
		alert("소셜쇼핑 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="social2013"){
		alert("소셜쇼핑 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}

	//document.getElementById("incFavoriteLayer").style.display = "none";
}
function copy_URL_NEW(address,param_where){
	if (window.clipboardData) { 
		window.clipboardData.setData("Text",address);	
		copy_URL(address,param_where);
	} else if (window.netscape) { 
		try {
			netscape.security.PrivilegeManager.enablePrivilege('UniversalXPConnect'); 
			var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard); 
			if (!clip) return; 
			var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable); 
			if (!trans) return; trans.addDataFlavor('text/unicode'); 
			var str = new Object(); 
			var len = new Object(); 
			var str = Components.classes['@mozilla.org/supports-string;1'].createInstance(Components.interfaces.nsISupportsString); 
			var copytext = address; str.data = copytext; trans.setTransferData('text/unicode',str,copytext.length*2); 
			var clipid = Components.interfaces.nsIClipboard; 
			if (!clipid) return false;
			clip.setData(trans,null,clipid.kGlobalClipboard); 
			copy_URL(address,param_where);
		} catch(e) {
			//alert("signed.applets.codebase_principal_support를 설정해주세요!\n"+e);
			alert("signed.applets.codebase_principal_support를 설정해주세요!");
		}
	}else{
		alert("해당 브라우저에서는 지원하지 않습니다.");
	} 
	return false;
}
function copy_URL(param,param_where){
	if(document.URL.indexOf("/view/Sslist.jsp") > 0 && param_where=="goods" ){
		copy_URL_NEW(param);
	}
	if (param_where=="goods"  || param_where=="ever_goods" || param_where=="reuse_goods" || param_where=="quick"){
		alert("해당 상품의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="cate" || param_where=="brand" ){
		alert("해당 분류의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="ever_main" ){
		alert("에누리 오픈마켓메인의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="ever_shop" ){
		alert("에누리 오픈마켓 미니샵의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="callrate" ){
		alert("통화요금비교 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="nego"){
		alert("흥정하기 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="star"){
		alert("스탸삽 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="purchaseguide"){
		alert("해당 분류의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="knowbox_expert"){
		alert("해당 분류의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="compare"){
		alert("상품비교의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="knowbox"){
		alert("지식통의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="main"){
		alert("에누리닷컴의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="autocome"){
		alert("신차비교(출시예정)의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="autonew"){
		alert("신차비교(최근출시차량)의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="auto" || param_where=="automenu"){
		alert("신차비교비교의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="tour" || param_where=="tour2012"){
		alert("여행상품검색의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="today"){
		alert("최근본 상품 페이지의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="search"){
		alert("검색 결과가져가기의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="event"){
		alert("이벤트의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="main_poll"){
		alert("토론방의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="social"){
		alert("소셜쇼핑의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}else if (param_where=="social2013"){
		alert("소셜쇼핑의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
	}
	//if(document.getElementById("incFavoriteLayer")) document.getElementById("incFavoriteLayer").style.display = "none";
	//if(document.getElementById("div_favorite")) document.getElementById("div_favorite").style.display = "none";
}
function favoriteURL_NEW(param, param_text){
	if (window.sidebar){ // 파폭
		window.sidebar.addPanel(param_text, param, "");
	}else if (document.all){ // IE
		try{
			window.external.AddFavorite(param, param_text);
		}catch(e){
			alert("이 브라우저에서는 즐겨찾기를 추가 할수 없습니다.")
		}
	}else if (navigator.appName=="Netscape") { //크롬
		//alert("Please click OK, then press <Ctrl-D> to bookmark this page.");
		alert("확인을 누르시고 <Ctrl-D>를 사용하여 이 페이지를 즐겨찾기 하세요.");
	}
	//if(document.getElementById("incFavoriteLayer")) document.getElementById("incFavoriteLayer").style.display = "none";
	//if(document.getElementById("div_favorite")) document.getElementById("div_favorite").style.display = "none";
}
function doBuilder(){
	var strQuery = "Encoding=UTF-8&Name=" + encodeURIComponent("에누리") + "&URI="  + encodeURIComponent("http://www.enuri.com/search/Searchlist.jsp?keyword=TEST");
	var strAddURI = "http://www.microsoft.com/windows/ie/searchguide/spbuilder.mspx?" + strQuery;
	try{
		window.external.AddSearchProvider(strAddURI);
	}
	catch(eX){
		alert("검색 공급자를 추가하지 못했습니다.");
	}
	
	return false;
}
function go_icon(){
	if( navigator.userAgent.indexOf('MSIE') >= 0 ){	
		document.frmFavorite.action = "/include/IncFavoriteLayer_2010.jsp";
		document.frmFavorite.icon.value = "Y";
		document.frmFavorite.target = "ifrmFavorite";
		document.getElementById("ifrmFavorite").style.left = Position.cumulativeOffset($("incFavoriteLayer"))[0] + 10 + "px";
		document.getElementById("ifrmFavorite").style.top = Position.cumulativeOffset($("incFavoriteLayer"))[1] - 170 + "px";
		document.getElementById("ifrmFavorite").style.display = "inline";
		document.frmFavorite.submit();
	}else{
		alert("해당 브라우저에서는 지원하지 않습니다.");	
	}
}
function go_icon_search(){	
	if( navigator.userAgent.indexOf('MSIE') >= 0 ){
		document.frmFavorite.action = "/include/IncFavoriteLayer_2010.jsp";
		document.frmFavorite.icon.value = "Y";
		document.frmFavorite.target = "ifrmFavorite";
		document.getElementById("ifrmFavorite").style.left = Position.cumulativeOffset($("incFavoriteLayer"))[0] + 10 + "px";
		document.getElementById("ifrmFavorite").style.top = Position.cumulativeOffset($("incFavoriteLayer"))[1] - 170 + "px";
		document.getElementById("ifrmFavorite").style.display = "inline";
		document.frmFavorite.submit();
	}else{
		alert("해당 브라우저에서는 지원하지 않습니다.");
	}
}
function go_icon_fusion(){	
	if( navigator.userAgent.indexOf('MSIE') >= 0 ){
		document.frmFavorite.action = "/include/IncFavoriteLayer_2010.jsp";
		document.frmFavorite.icon.value = "Y";
		document.frmFavorite.target = "ifrmFavorite";
		document.getElementById("ifrmFavorite").style.left = Position.cumulativeOffset($("incFavoriteLayer"))[0] + 10 + "px";
		document.getElementById("ifrmFavorite").style.top = Position.cumulativeOffset($("incFavoriteLayer"))[1] - 300 + "px";
		document.getElementById("ifrmFavorite").style.display = "inline";
		document.frmFavorite.submit();
	}else{
		alert("해당 브라우저에서는 지원하지 않습니다.");
	}

}