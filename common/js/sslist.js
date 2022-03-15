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

function syncHeightListFrame() {
	try{
		var varAddHeight = 5;
		if (BrowserDetect.browser == "Firefox" || (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 8 )){
			varAddHeight = 20;
		}
		if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 9 ){
			varAddHeight = 7;
		}
		if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 10 ){
			varAddHeight = 7;
		}
		if (BrowserDetect.browser == "Chrome"){
			varAddHeight = 7;
		}
		if (BrowserDetect.browser == "Explorer" || BrowserDetect.browser == "Firefox"){
			varAddHeight = varAddHeight + document.getElementById("enuriListFrame").contentWindow.document.body.scrollHeight; 
		}else{
			varAddHeight = varAddHeight + document.getElementById("enuriListFrame").contentWindow.document.documentElement.scrollHeight ? document.getElementById("enuriListFrame").contentWindow.document.documentElement.scrollHeight : document.getElementById("enuriListFrame").contentWindow.document.body.scrollHeight;
		}

	    document.getElementById("enuriListFrame").height = varAddHeight +"px";
	    //hideLoadingBar();
	    
		if(document.body.clientHeight-320 < document.getElementById("gotop").offsetHeight){
			document.getElementById("enuriListFrame").height = document.getElementById("gotop").offsetHeight + "px";
		}
	    
   	}catch(e){
	}
}

function showViewmode(){
	if (document.getElementById("view_mode").style.display != "none"){
		document.getElementById("view_mode").style.display = "none";
		hideAllLayer();
	}else{
		hideAllLayer();
		var posLeftTop = Position.cumulativeOffset($("selected_view_mode"));
		document.getElementById("view_mode").style.left = posLeftTop[0]+"px";
		document.getElementById("view_mode").style.top = posLeftTop[1]+16+"px";
		document.getElementById("view_mode").style.display = "";
		document.getElementById("img_view_btn").src = var_img_enuri_com + "/2012/list/btn_x.gif";
	}
}
var varPlsno;
function hideAllLayer(layer){
	if (layer != "pricelist"){
		hidePricelistLayer(varPlsno);
	}
	/*
	hideConditionLayer();
	hidePriceLayer();
	hideFactoryLayer();
	*/
	if (layer != "beginner"){
		if (typeof(top.closeAllBeginnerDic) =="function"){
			top.closeAllBeginnerDic();
		}
	}
	if (layer != "reckeyword"){
		if (typeof(hideRecKeyword) =="function"){
			hideRecKeyword();
			setKeywordBackground();
		}
	}

	if (typeof(top.hideGoogleSearch) =="function"){
		top.hideGoogleSearch();
	}
	var hideLayers = [
		"sort_mode","view_mode","view_mode2","select_paging_group","reckeyword","factory_info_layer","divWeightInfo","orderListDiv","divLowestPriceInfo","booklayer","div_point_info","div_innoresult","scate_layer","divMCateLayer", "divDCateLayer","x_btn"
	];
	var topHideLayers = [
		"comparisonInfo","myfavoriteInfo","sprice_info","popular_info_layer","div_inconv","ac_layer","beginner_big_img","clauseLayer","booklayer","clauseInfoDiv","dicGoogleLayer","popularListDiv","orderListDiv","smartDiv","div_brand_list","div_Tc_Tab","div_Event_Tab","LayerM_KBMenu","divGoodsDetailInfo","simg_layer","divLowestPriceInfo","divLowestPriceInfo","divMCateLayer", "divDCateLayer","sort_mode","view_mode","x_btn"
	];	

	for (var i=0;i<hideLayers.length;i++){
		if (document.getElementById(hideLayers[i])){
			if (layer != hideLayers[i]){
				//if (!(getRecKeword._loading)){
				//	window.status = "hide reckeyword " + getRecKeword._loading;
					document.getElementById(hideLayers[i]).style.display = "none";
				//}				
			}
		}
	}
	for (var i=0;i<topHideLayers.length;i++){
		if (top.document.getElementById(topHideLayers[i])){
			if (layer != topHideLayers[i]){
				top.document.getElementById(topHideLayers[i]).style.display = "none";
				if ( topHideLayers[i] == "ac_layer"){
					if (top.document.getElementById("img_close_auto")){
						top.document.getElementById("img_close_auto").src = var_img_enuri_com + "/images/main_2008/topmenu/search/search_03.gif";
					}
				}
			}
		}
	}	
	//top.document.getElementById("loading").style.left = (top.document.getElementById("wrap").offsetWidth/2 - 132)+"px";
	//top.document.getElementById("loading").style.top = 320+"px"; 
	//top.document.getElementById("loading").style.display = "";
	if (document.getElementById("img_view_btn")){
		document.getElementById("img_view_btn").src = var_img_enuri_com + "/2012/list/newdown.gif";
	}
	if (document.getElementById("img_view_btn2")){
		document.getElementById("img_view_btn2").src = var_img_enuri_com + "/2010/images/view/newdown.gif";
	}
	if (document.getElementById("img_paging_btn")){
		document.getElementById("img_paging_btn").src = var_img_enuri_com + "/2010/images/view/newdown.gif";
	}
	if (document.getElementById("img_sort_btn")){
		document.getElementById("img_sort_btn").src = var_img_enuri_com + "/2012/list/newdown.gif";
	}
	if(varTargetPage == "/search/EnuriSearch.jsp"){
		top.checkAutoCom();
	}
	if (document.getElementById("nowLoc_L_Layer")){
		if (document.getElementById("nowLoc_L_Layer").style.display != "none"){
			showLocLCate();
		}
	}
	if (document.getElementById("nowLoc_M_Layer")){
		if (document.getElementById("nowLoc_M_Layer").style.display != "none"){
			showLocMCate();
		}
	}
	if (document.getElementById("nowLoc_S_Layer")){
		if (document.getElementById("nowLoc_S_Layer").style.display != "none"){
			showLocSCate();
		}
	}	
}
function over_view_mode(obj){
	obj.className = "over";
}
function out_view_mode(obj){
	obj.className = "out";
}
function view_mode(viewmode,count){
	if (viewmode == "gp" && count == 20){
		insertLog(940);
	}else if(viewmode == "gp" && count == 40){
		insertLog(941);
	}else if(viewmode == "gp" && count == 80){
		insertLog(942);
	}else if(viewmode == "1p" && count == 50){
		insertLog(4355);
	}else if(viewmode == "1p" && count == 100){
		insertLog(4356);
	}else if(viewmode == "img" && count == 500){
		insertLog(4203);
	}else if(viewmode == "img" && count == 200){
		insertLog(4202);
	}else if(viewmode == "txt" && count == 60){
		insertLog(4602);
	}else if(viewmode == "txt" && count == 120){
		insertLog(4603);
	}else if(viewmode == "2p" && count == 60){
		insertLog(4601);
	}else if(viewmode == "2p" && count == 120){
		insertLog(4600);
	}
	//top.viewLoadingBar();
	if (document.body.scrollTop){
		top.document.body.scrollTop = "0px";
	}else{
		top.document.documentElement.scrollTop = "0px";
	}	
	if (document.getElementById("okeyword")){
		document.frmList.keyword.value = document.frmList.okeyword.value;
	}	
	if(varTargetPage == "/search/EnuriSearch.jsp"){
		if (document.getElementById("in_o_keyword")){
			document.frmList.in_keyword.value = document.frmList.in_o_keyword.value;
		}					
	}		
	if (document.getElementById("brand_add_search")){
		document.frmList.brand_add_search.value="";
	}
	if (document.getElementById("page_enuri")){
		document.frmList.page_enuri.value="";
	}	
	document.frmList.page.value = "1";
	document.frmList.view.value=viewmode;
	document.frmList.pagesize.value=count;
	if(varTargetPage == "/search/EnuriSearch.jsp"){
		if (document.getElementById("div_re_seach")){
			if (document.getElementById("div_re_seach").style.display != "none"){
				document.frmList.research.value = "Y";
				document.frmList.reorgkeyword.value = top.document.fmMainSearch.reorgkeyword.value;
				setResearchValue();
			}
		}
	}		
	document.frmList.submit();
}

function showSortmode(){
	if (document.getElementById("sort_mode").style.display != "none"){
		document.getElementById("sort_mode").style.display = "none";
		hideAllLayer();
	}else{
		hideAllLayer();
		var posLeftTop = Position.cumulativeOffset($("selected_sort_mode"));
		document.getElementById("sort_mode").style.left = posLeftTop[0]+"px";
		document.getElementById("sort_mode").style.top = (posLeftTop[1]+16)+"px";
		document.getElementById("sort_mode").style.display = "";
		document.getElementById("img_sort_btn").src = var_img_enuri_com + "/2012/list/btn_x.gif";
	}
}

function select_sort(key){
	//top.viewLoadingBar();
	if (key.indexOf("factory") >= 0){
		insertLog(112);		
	}else if (key.indexOf("minprice+DESC") >= 0){
		insertLog(116);		
	}else if (key.indexOf("minprice") >= 0){
		insertLog(115);		
	}else if (key.indexOf("c_date") >= 0){
		insertLog(118);		
	}else if (key.indexOf("popular") >= 0){
		insertLog(119);		
	}else if (key.indexOf("modelnm") >= 0){
		insertLog(113);		
	}else if (key.indexOf("sale_cnt") >= 0){
		insertLog(2509);
		var setSession = new Ajax.Request("/include/ajax/AjaxSetSession.jsp",{method:'get',parameters:"sname=Shop4Price&svalue="});	
	}else if (key.indexOf("accuracy") >= 0){
		insertLog(609);		
	}else if (key.indexOf("weight") >= 0){
		insertLogCate(7893,varCate);		
	}
	if (top.document.body.scrollTop){
		top.document.body.scrollTop = "0";
	}else{
		top.document.documentElement.scrollTop = "0";
	}	
	if (document.getElementById("brand_add_search")){
		document.frmList.brand_add_search.value="";
	}
	if (document.getElementById("page_enuri")){
		document.frmList.page_enuri.value="";
	}	
	if (document.getElementById("okeyword")){
		document.frmList.keyword.value = document.frmList.okeyword.value;
	}	
	document.frmList.page.value = "1";
	document.frmList.key.value=key;
	document.frmList.submit();
}

function setKeywordBackground(){

}

function showPaging(){
	if (document.getElementById("select_paging_group").style.display != "none"){
		document.getElementById("select_paging_group").style.display = "none";
		hideAllLayer();
	}else{
		hideAllLayer();
		var posLeftTop = Position.cumulativeOffset($("paging_group_list"));
		document.getElementById("select_paging_group").style.left = posLeftTop[0]+"px";
		document.getElementById("select_paging_group").style.top = posLeftTop[1]+16+"px";
		document.getElementById("select_paging_group").style.display = "";
		document.getElementById("img_paging_btn").src = var_img_enuri_com + "/2010/images/view/newdown_close.gif";
	}
}
function hidePaging(){
	document.getElementById("select_paging_group").style.display = "none";
}

function convertSpecialKeyword_sslist(keyword){
	
	keyword = replace_sslist(keyword, "'");		
	keyword = replace_sslist(keyword, "\"");				
    keyword = replace_sslist(keyword, "^");
    keyword = replace_sslist(keyword, "&");
    keyword = replace_sslist(keyword, "~");
    keyword = replace_sslist(keyword, "!");
    keyword = replace_sslist(keyword, "@");
    keyword = replace_sslist(keyword, "$");
    keyword = replace_sslist(keyword, "%");
    keyword = replace_sslist(keyword, "*"); 
    keyword = replace_sslist(keyword, "+");
    keyword = replace_sslist(keyword, "=");
    keyword = replace_sslist(keyword, "\\");
    keyword = replace_sslist(keyword, "{");
    keyword = replace_sslist(keyword, "}");
    keyword = replace_sslist(keyword, "[");
    keyword = replace_sslist(keyword, "]");
    keyword = replace_sslist(keyword, ":");
    keyword = replace_sslist(keyword, ";");
    keyword = replace_sslist(keyword, "/");
    keyword = replace_sslist(keyword, "<");
    keyword = replace_sslist(keyword, ">");
    //keyword = replace_sslist(keyword, "."); 
    keyword = replace_sslist(keyword, ",");
    keyword = replace_sslist(keyword, "?");
    keyword = replace_sslist(keyword, "(");
    keyword = replace_sslist(keyword, ")");
    keyword = replace_sslist(keyword, "'");
    keyword = replace_sslist(keyword, "_");
    keyword = replace_sslist(keyword, "-");
    keyword = replace_sslist(keyword, "`");
    keyword = replace_sslist(keyword, "|");
    keyword = replace_sslist(keyword, ",");
	
    keyword = keyword.trim();		
	return keyword;
	
	function replace_sslist(src, delWrd){
		var newSrc = "";
		for(var i=0;i<src.length;i++){
			if(src.charAt(i) == delWrd) {
				newSrc = newSrc + " ";
			}else{
				newSrc = newSrc + src.charAt(i);
			}			
		}
		return newSrc;
	}		

	return keyword;
}

function gosearchKeyword(){
	var varKeyword = document.frmList.keyword.value;
	varKeyword = convertSpecialKeyword_sslist(varKeyword);
	if (varKeyword.length < 2){
		alert("2자 이상의 검색어를 넣으세요.\t\t\r\n\특수문자는 제외 됩니다.");
		return false;
	}else{
		document.frmList.page.value = "1";
		document.frmList.submit();
	}
}

function detailMultiView(OpenFile,name,modelno){
 	//changeSelectedModelBg(modelno);
 	fnSetCookie2010("opendetail","Y",1);
 	//top.detailMultiView(OpenFile,name,modelno);
 	top.detailWin = window.open(OpenFile,"detailMultiWin","width=804,height="+window.screen.height+",left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
	//detailWin.focus(); 	 	
} 

function openLowestPriceInfoLayer(e){
	if(!e) var e = window.event;
	hideAllLayer();
	if (top.document.getElementById("divLowestPriceInfo") && top.document.getElementById("divLowestPriceInfo").innerHTML != ""){
		if (top.document.getElementById("divLowestPriceInfo").style.display != "none"){
			top.document.getElementById("divLowestPriceInfo").style.display = "none";
		}else{
			top.document.getElementById("divLowestPriceInfo").style.display = "";
			top.document.getElementById("divLowestPriceInfo").style.top = "191px"
		}
	}else{
		top.document.getElementById("divLowestPriceInfo").innerHTML = "<img src='<%=ConfigManager.IMG_ENURI_COM%>/images/social/2013/sale_layer.png' width='285' height='273' border='0' class='png24'/><div onclick='hideAllLayer();return false;' style='position:absolute;top:14px;left:313px;width:16px;height:16px;z-index:120;cursor:pointer;'><img src='<%=ConfigManager.IMG_ENURI_COM%>/images/blank.gif' border='0' width='16' height='16'/></div>";
		top.document.getElementById("divLowestPriceInfo").style.display = "";
			if (document.getElementById("metamain")){
				top.document.getElementById("divLowestPriceInfo").style.top = "191px"
			}
	}
	
	e.cancelBubble = true;
	e.returnValue = false;
	if (e.stopPropagation) {
		e.stopPropagation();
		e.preventDefault();
	}		
}

function openOrderListInfoLayer_social(e){
	if(!e) var e = window.event;
	hideAllLayer();
	popOrderlist_social();

	e.cancelBubble = true;
	e.returnValue = false;
	if (e.stopPropagation) {
		e.stopPropagation();
		e.preventDefault();
	}
}

function popOrderlist_social(){
	if(top.document.getElementById("orderListDiv")){
		var varLeft = 0;
		var varTop = 191;
		function ShowOrderInfoLayer(originalRequest){
			top.document.getElementById("orderListDiv").innerHTML = originalRequest.responseText;
			top.document.getElementById("orderListDiv").style.top = varTop + "px";
			top.document.getElementById("orderListDiv").style.left = varLeft + "px";
			top.document.getElementById("orderListDiv").style.display = "";			
		}
		if(top.document.getElementById("orderListDiv").innerHTML==""){ 
			var url = "/include/ajax/AjaxOrderInfoLayer.jsp";
			var getRec = new Ajax.Request(
				url,
				{
					method:'get',onComplete:ShowOrderInfoLayer
				}
			);				
		}else{
			top.document.getElementById("orderListDiv").style.top = varTop + "px";
			top.document.getElementById("orderListDiv").style.left = varLeft + "px";
			top.document.getElementById("orderListDiv").style.display = "";
		}
	}	
}

function CmdGotoURL(modelno, site_code){
	var url = '/move/Redirect_Social.jsp?modelno='+modelno+'&sitecode='+site_code;
	k = window.open (url,"_blank");
	k.focus();		
	return false;	
}	

function CmdGotoAll(){
	var url = '/view/Sslist_2013.jsp';
	k = window.open (url,"_blank");
	k.focus();		
	return false;	
}