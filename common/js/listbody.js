var varPlsno;
/*
function hideLayer(){
	var hideLayers = [
		"sort_mode","view_mode","view_mode2","select_paging_group","reckeyword","factory_info_layer","main_price_layer","divWeightInfo","divWeightInfo"
	];
	var topHideLayers = [
		"main_price_layer_top","main_price_layer","comparisonInfo","myfavoriteInfo","sprice_info"
	];
	for (var i=0;i<hideLayers.length;i++){
		if (document.getElementById(hideLayers[i])){
			document.getElementById(hideLayers[i]).style.display = "none";
		}
	}
	for (var i=0;i<topHideLayers.length;i++){
		if (top.document.getElementById(topHideLayers[i])){
			top.document.getElementById(topHideLayers[i]).style.display = "none";
		}
	}
	hidePricelistLayer(varPlsno);
	top.closeAllBeginnerDic();
	top.hideGoogleSearch();
}
*/
window.onresize = windowResize

function windowResize(){
	hideAllLayer();
	setPositionLayers();

}

//var varLoadingImgChkTimeHandler
//var varLoadingImgChkCount = 0;
function init(){

	if (typeof(varOrderType) != "undefined"){
		default_value_for_radio(document.select_form.order_type , varOrderType);
	}
	/*
	if (!top.document.getElementById("enuriMenuFrame")){
		if (varTargetPage == "/view/Listbody.jsp" || varTargetPage == "/view/Listbody_Mp3.jsp" || varTargetPage == "/view/Listbody_Handphone.jsp" || varTargetPage == "/view/Listbody_Printer.jsp"){
			top.location.href = "Listmp3.jsp?cate="+varCate
		}
	}
	*/
	if (document.getElementById("m_price") ){
		if ((document.getElementById("m_price").value.trim().length > 0 && isOpenPriceTab()) ){
			if (fnGetCookie2010("pt") != "n"){
				togglePriceLayer("init");
			}
		}
	}
	/*
	if (document.getElementById("m_price") ){
		if (document.getElementById("m_price").value.trim().length > 0 && isOpenPriceTab()){

			document.getElementById("price_layer").innerHTML = top.document.getElementById("bodyPriceTab").innerHTML;
			var priceNmObj = $("price_layer").getElementsBySelector('input[class="chkbox"]');
			var priceIdx = "";
			var aselectedPriceNames = document.getElementById("m_price").value.split(",");
			for(i=0;i<priceNmObj.length;i++){
				var priceName = priceNmObj[i].value.trim();
				for (j=0;j<aselectedPriceNames.length;j++){
					var varSelectedPriceName = aselectedPriceNames[j];
					if (priceName == varSelectedPriceName ){
						priceIdx = priceNmObj[i].id;
						document.getElementById(priceIdx).checked = true;
					}
				}
			}
			if (fnGetCookie2010("pt") != "n"){
				togglePriceLayer();
			}
		}else{
			top.document.getElementById("bodyPriceTab").innerHTML =  "";
			if (document.getElementById("m_price").value.trim().length > 0){
				if (fnGetCookie2010("pt") != "n"){
					togglePriceLayer();
				}
			}
		}
	}
	*/
	if(typeof(varisBrand) == "undefined"){
		varisBrand = "";
	}
	if (document.getElementById("factory") && varisBrand !="true"){
		if (document.getElementById("factory").value.trim().length > 0 && isOpenFactoryTab()){
		  fnSetCookie2010("ft","y");
			document.getElementById("factory_layer").innerHTML = top.document.getElementById("bodyFactoryTab").innerHTML;
			var factoryNmObj = $("factory_layer").getElementsBySelector('input[class="chkbox"]');
			var factoryIdx = "";
			var aselectedFactoryNames = document.getElementById("factory").value.split(",");
			for(i=0;i<factoryNmObj.length;i++){
				var factoryName = factoryNmObj[i].value.trim();
				for (j=0;j<aselectedFactoryNames.length;j++){
					var varSelectedFactoryName = aselectedFactoryNames[j];
					if (factoryName == varSelectedFactoryName ){
						factoryIdx = factoryNmObj[i].id;
						document.getElementById(factoryIdx).checked = true;
					}
				}
			}
			if (fnGetCookie2010("ft") != "n"){
				toggleFactoryLayer();
			}

			if (document.getElementById("factory_layer_inner")){
				if (document.getElementById("factory_layer_inner").offsetHeight < document.getElementById("factory_layer_inner").scrollHeight ){
					var varFactoryGoLeft = Position.cumulativeOffset($(factoryIdx))[0]-53;
					//var factoryTop = Position.cumulativeOffset($(factoryIdx))[1] - Position.cumulativeOffset($("factory_layer"))[1]-10;
					var varAddHeight = 34;
					if (document.getElementById("hot_factory_layer")){
						varAddHeight = 66;
					}
					if(document.getElementById("price_layer")){
						if(document.getElementById("price_layer").style.display != "none"){
							varAddHeight = varAddHeight - 27;
						}
					}
					var varFactoryGoTop = Position.cumulativeOffset($(factoryIdx))[1] - Position.cumulativeOffset(document.getElementById("factory_layer"))[1]-varAddHeight;
					document.getElementById("factory_layer_inner").scrollTop = varFactoryGoTop;
				}
			}

		}else{
			top.document.getElementById("bodyFactoryTab").innerHTML =  "";
			if (document.getElementById("factory").value.trim().length > 0){
				if (fnGetCookie2010("ft") != "n"){
					toggleFactoryLayer("init");
				}
			}
		}
	}
	if (document.getElementById("brand") && varisBrand !="true"){
		if (document.getElementById("brand").value.trim().length > 0 && isOpenBrandTab()){
			fnSetCookie2010("bt","y");
			var brandNmObj = $("brand_layer").getElementsBySelector('input[class="chkbox"]');
			var brandIdx = "";
			var aselectedBrandNames = document.getElementById("brand").value.split(",");
			for(i=0;i<brandNmObj.length;i++){
				var factoryName = brandNmObj[i].value.trim();
				for (j=0;j<aselectedBrandNames.length;j++){
					var varSelectedBrandName = aselectedBrandNames[j];
					if (brandName == varSelectedBrandName ){
						brandIdx = brandNmObj[i].id;
						document.getElementById(brandIdx).checked = true;
					}
				}
			}
			if (fnGetCookie2010("bt") != "n"){
				toggleBrandLayer();
			}

			if (document.getElementById("brand_layer_inner")){
				if (document.getElementById("brand_layer_inner").offsetHeight < document.getElementById("brand_layer_inner").scrollHeight ){
					var varBrandGoLeft = Position.cumulativeOffset($(brandIdx))[0]-53;
					//var factoryTop = Position.cumulativeOffset($(factoryIdx))[1] - Position.cumulativeOffset($("factory_layer"))[1]-10;
					var varAddHeight = 34;
					if (document.getElementById("hot_brand_layer")){
						varAddHeight = 66;
					}
					if(document.getElementById("price_layer")){
						if(document.getElementById("price_layer").style.display != "none"){
							varAddHeight = varAddHeight - 27;
						}
					}
					var varBrandGoTop = Position.cumulativeOffset($(brandIdx))[1] - Position.cumulativeOffset(document.getElementById("brand_layer"))[1]-varAddHeight;
					document.getElementById("brand_layer_inner").scrollTop = varBrandGoTop;
				}
			}

		}else{
			if (document.getElementById("brand").value.trim().length > 0){
				if (fnGetCookie2010("bt") != "n"){
					toggleBrandLayer("init");
				}
			}
		}
	}
	//뒤로가기때문에 미분류 레이어및 선택된 소분류 처리를 여기서 다시 한번 해준다.

	if (varCate.length >= 6){
		var bSpreadMenu = false;
		if (parent.document.getElementById("spread_menu")){
			if (parent.document.getElementById("spread_menu").style.display != "none"){
				bSpreadMenu = true;
			}
		}
		if (!bSpreadMenu){
			if (typeof(parent.showCateLayer) == "function"){
				parent.showCateLayer(varCate,'click');
			}
			try{
				if (typeof(parent.showDCateLayer) == "function"){
					if (varGb1 == "" && varGb2 == ""){
						parent.showDCateLayer(varCate,'click');
					}
				}
			}catch(e){
			}
		}
		if (typeof(parent.goCategory) == "function"){
			parent.goCategory(varCate,"",true);
		}
		/*
		if (varTargetPage != "/view/Listbody_Social.jsp" && bSpreadMenu){
			if (varCate.length == 8){
				if (parent.document.getElementById("spread"+varCate)){
					var sccf = new String(parent.document.getElementById("spread"+varCate).onclick);
					var sccfm = "parent." + sccf.substring(sccf.indexOf("goCategory_Spread"),sccf.lastIndexOf(";")-1) + ",true);";
					eval(sccfm);
				}
			}else if(varCate.length == 6){
				if (parent.document.getElementById("Mspread"+varCate)){
					var sccf = new String(parent.document.getElementById("Mspread"+varCate).onclick);
					var sccfm = "parent." + sccf.substring(sccf.indexOf("goCategory_Spread"),sccf.lastIndexOf(";")-1) + ",true);";
					eval(sccfm);
				}
			}
		}
		*/
	}else{
		if (typeof (parent.goCategory) == "function"){
			parent.goCategory(varCate,"",true);
		}
	}
	top.getGuide_Resent_ZzimCate(1,1,varCate);
	var varScNo = "";
	try{
		varScNo = varSc;
	}catch(e){

	}
	if (varScNo != "no"){
		/*
		var varSpreadMenuHeight = 0;
		if (parent.document.getElementById("spread_menu")){
			varSpreadMenuHeight = parent.document.getElementById("spread_menu").offsetHeight;
		}
		if (top.document.body.scrollTop){
			top.document.body.scrollTop = varSpreadMenuHeight;
		}else{
			top.document.documentElement.scrollTop = varSpreadMenuHeight;
		}
		*/
		var isrt = 0;
		/*
		if (parent.document.getElementById("spread_menu")){
			if (parent.document.getElementById("spread_menu").style.display != "none"){
				isrt = 50;
			}
		}
		*/
		if (parent.document.getElementById("spec_menu")){
			if (parent.document.getElementById("spec_menu").style.display != "none"){
				if (document.getElementById("sel_spec").value.trim().length > 0 || (typeof(parent.uncheckSpecAll._click) != "undefined" && parent.uncheckSpecAll._click)){
					isrt = parent.document.getElementById("header").offsetHeight;
					parent.uncheckSpecAll._click = false;
				}else{
					isrt = -1;
				}
			}
		}
		if (varCate.length >= 2){
			if (varCate.substring(0,2) == "15"){
				isrt = 0;
			}
		}
		if (varCate.length >= 4){
			if (varCate.substring(0,4) == "1640"){
				isrt = 0;
			}
		}
		if (isrt > -1 ){
			if (BrowserDetect.browser == "Chrome"){
				top.document.body.scrollTop = isrt;
			}else{
				top.document.documentElement.scrollTop = isrt;
			}
		}
	}
 	if (varDetailMultiWinName == "detailMultiWin"){
 		function openDetailmultiWin(originalRequest){
 			varDetailMultiWinName = "detailMultiWin_"+originalRequest.responseText;
 		}
		var url = "/include/ajax/AjaxGetSessionId.jsp";
		var getFactoryInfo = new Ajax.Request(
			url,
			{
				method:'get',onComplete:openDetailmultiWin
			}
		);
	}
	/*
	top.document.getElementById("loading").style.display = "none";
	varLoadingImgChkTimeHandler = setInterval("loadingImgChk()",500)
	*/
	/*
	if ((varCate == "1503" || varCate == "150313" || varCate == "150309") && fnGetCookie2010("_hd_v_1503") == ""){
		//var varLayerHtml = "<img style=\"position:absolute;left:282px;top:8px;cursor:pointer;\" onClick=\"$('notice_1503').style.display='none'\" src=\""+var_img_enuri_com+"/2010/images/view/x_btn_0703.gif\">";
		var varLayerHtml = "<img src=\""+var_img_enuri_com+"/2010/images/view/20120512_layer.png\" usemap=\"#map_1503\" border=\"0\">";
		varLayerHtml += "<map name=\"map_1503\" id=\"map_1503\"><area shape=\"rect\" coords=\"370,5,385,21\" href=\"#\" onclick=\"$('notice_1503').style.display='none';fnSetCookie2010('_hd_v_1503','Y','');\"/></map>";
		var varLayerObj = document.createElement("DIV");
		varLayerObj.id = "notice_1503";
		varLayerObj.style.position = "absolute";
		varLayerObj.style.top = (Position.cumulativeOffset($("goodslist"))[1])+"px"
		varLayerObj.style.left = (top.document.getElementById("wrap").offsetWidth/2-157)+"px"
		varLayerObj.style.width="315";
		varLayerObj.style.height="192";
		varLayerObj.style.zIndex=100;
		varLayerObj.innerHTML = varLayerHtml
		document.getElementById("wrap").insertBefore(varLayerObj,null);
	}

	if (varCate.length >= 4 ){
		if (top.accNotice == "Y" && fnGetCookie2010("_hd_v_"+varCate.substring(0,4)) == "" && (varCate.substring(0,4) == "0337" || varCate.substring(0,4) == "0338" || varCate.substring(0,4) == "0339" ||
			varCate.substring(0,4) == "0340" || varCate.substring(0,4) == "0341" || varCate.substring(0,4) == "0343" || varCate.substring(0,4) == "0344" || varCate.substring(0,4) == "0346" || varCate.substring(0,4) == "0347" || varCate.substring(0,4) == "0348"))
		{
			if (document.getElementById("div_acc_notice")){
				document.getElementById("div_acc_notice").style.display = "";
			}else{
				var varLayerHtml = "<img src=\""+var_img_enuri_com+"/2010/images/brand/acc_notice2.gif\" usemap=\"#map_acc_notice\" />";
				varLayerHtml += "<map name=\"map_acc_notice\" id=\"map_acc_notice\"><area shape=\"rect\" coords=\"246,80,354,94\" href=\"#\" onclick=\"JavaScript:hideAccNotice7();return false;\" /><area shape=\"rect\" coords=\"350,3,364,15\" href=\"#\" onclick=\"document.getElementById('div_acc_notice').style.display='none';return false;\"/></map>";
				var varLayerObj = document.createElement("DIV");
				varLayerObj.id = "div_acc_notice";
				varLayerObj.style.position = "absolute";
				varLayerObj.style.top = (Position.cumulativeOffset($("goodslist"))[1])+"px"
				varLayerObj.style.left = (top.document.getElementById("wrap").offsetWidth/2-157)+"px"
				varLayerObj.style.width="314";
				varLayerObj.style.height="190";
				varLayerObj.style.zIndex=100;
				varLayerObj.innerHTML = varLayerHtml
				document.getElementById("wrap").insertBefore(varLayerObj,null);
			}
			top.accNotice = "";
		}
	}
	*/
	if (document.getElementById("spec")){
		if (document.getElementById("spec").value == "y"){
			if (parent.document.getElementById("spec_menu").style.display == "none"){
				parent.showSpecMenu(varCate,document.getElementById("sel_spec").value);
			}
		}else{
		//여기가 사양선택 디폴트
			if((varCate == "0202") && (parent.selectedMenu == "" || parent.selectedMenu == "spec_menu") ){
				parent.showSpecMenu(varCate,"",false);
			}
		}
	}
	if (varCate == "2211" || varCate == "2241"){
		if (parent.varBr){
			setTimeout(function(){parent.smart_cate(varCate);},2500);
			parent.varBr = false
		}
	}


	//if (varCate.substring(0,6) == "040207"){
	//	parent.document.getElementById("spec_menu_btn").style.display = "none";
	//}
	//showShopPrice('5910');

	/*
	var varCareerObj = document.createElement("IFRAME");
	varCareerObj.width = 0;
	varCareerObj.height = 0;
	varCareerObj.frameBorder = 0;
	varCareerObj.id = "frmCareer";
	varCareerObj.name = "frmCareer";
	varCareerObj.scrolling = "no";
	document.getElementById("wrap").insertBefore(varCareerObj,null);

	function changeCareerIframe(){
		document.getElementById("frmCareer").contentWindow.document.location = "http://www.career.co.kr/job/redplace.asp";
	}
	setTimeout(function(){changeCareerIframe();},500);
	*/
	if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 7){
		//setWidthLineMap();
	}
	top.notice._f_none = "none";
}
/*
function loadingImgChk(){
	if (top.document.getElementById("loading").style.display != "none"){
		top.document.getElementById("loading").style.display = "none";
		clearTimeout(varLoadingImgChkTimeHandler);
	}
	varLoadingImgChkCount++;
	if (varLoadingImgChkCount > 20){
		clearTimeout(varLoadingImgChkTimeHandler);
	}
}
*/
window.onload = init;
window.onunload = unloadFunction;

function unloadFunction(){
	hideAllLayer();
	if (typeof (top.isLoadedSimpleView) == "function"){
		if (top.isLoadedSimpleView()){
			top.hideSimpleView();
		}
	}
}
function showViewmode(n){
	if (typeof(showViewmode._n) != "undefined" && showViewmode._n == n && document.getElementById("view_mode").style.display != "none"){
		hideViewmode();
		if (document.getElementById("img_view_btn"+n)){
			if (document.getElementById("img_view_btn"+n).src.indexOf("x_b") >= 0 ){
				document.getElementById("img_view_btn"+n).src = var_img_enuri_com + "/2014/list/tab/dn_b.gif";
			}else{
				document.getElementById("img_view_btn"+n).src = var_img_enuri_com + "/2014/list/tab/dn.gif";
			}
		}
		hideAllLayer();
	}else{
		hideAllLayer();
		var posLeftTop = Position.cumulativeOffset($("selected_view_mode"+n));
		var addLeft = 0;
		var addTop = 14;
		if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 7){
			addLeft = -4;
			addTop = 12;
			if(varTargetPage == "/search/EnuriSearch.jsp"){
				if (n == 1){
					addTop = 14;
				}else{
					addTop = 14;
					addLeft = 0;
				}
			}/*else{
				addLeft = 0;
				addTop = 14;
			}*/
		}
		document.getElementById("view_mode").style.left = (posLeftTop[0]+addLeft)+"px";
		document.getElementById("view_mode").style.top = posLeftTop[1]+addTop+"px";
		document.getElementById("view_mode").style.display = "";
		if (document.getElementById("img_view_btn"+n)){
			if (document.getElementById("img_view_btn"+n).src.indexOf("dn_b") >= 0 ){
				document.getElementById("img_view_btn"+n).src = var_img_enuri_com + "/2014/list/tab/x_b.gif";
			}else{
				document.getElementById("img_view_btn"+n).src = var_img_enuri_com + "/2014/list/tab/x.gif";
			}
		}
	}
	showViewmode._n = n;
}
function hideViewmode(){
	if (document.getElementById("view_mode")){
		document.getElementById("view_mode").style.display = "none";
	}
	if (document.getElementById("img_left_arr1")){
		document.getElementById("img_left_arr1").style.display = "none";
	}
	if (document.getElementById("img_left_arr2")){
		document.getElementById("img_left_arr2").style.display = "none";
	}
}
function hideViewmode2(){
	if (document.getElementById("view_mode2")){
		document.getElementById("view_mode2").style.display = "none";
	}
}
function over_view_mode(obj){
	obj.className = "over";
}
function out_view_mode(obj){
	obj.className = "out";
}
function view_mode(viewmode,count){
	if (viewmode == "gp" && count == 30){
		insertLog(940);
	}else if(viewmode == "gp" && count == 60){
		insertLog(941);
	}else if(viewmode == "gp" && count == 100){
		insertLog(942);
	}else if(viewmode == "1p" && count == 50){
		insertLog(4355);
	}else if(viewmode == "1p" && count == 100){
		insertLog(4356);
	}else if(viewmode == "img" && count == 90){
		insertLog(10311);
	}else if(viewmode == "img" && count == 270){
		insertLog(10312);
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
		if (viewmode == "img"){
			document.getElementById("rdo_gplist").checked = false;
			document.getElementById("rdo_imglist").checked = true;
			document.getElementById("rdo_gplist2").checked = false;
			document.getElementById("rdo_imglist2").checked = true;
		}
		if (viewmode == "gp"){
			document.getElementById("rdo_gplist").checked = true;
			document.getElementById("rdo_imglist").checked = false;
			document.getElementById("rdo_gplist2").checked = true;
			document.getElementById("rdo_imglist2").checked = false;
		}
		var varLoadingLeft = 0;
		if (top.document.getElementById("gnbMenu")){
			varLoadingLeft = (top.document.getElementById("gnbMenu").offsetWidth/2 - 150);
		}
		top.document.getElementById("searchlist_reloading").style.left = varLoadingLeft + "px";
		top.document.getElementById("searchlist_reloading").style.display = "";
		top.viewSearchReloadingBar();

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
	/*
	if(varTargetPage == "/search/EnuriSearch.jsp"){
		if (document.getElementById("div_re_seach")){
			if (document.getElementById("div_re_seach").style.display != "none"){
				document.frmList.research.value = "Y";
				document.frmList.reorgkeyword.value = top.document.fmMainSearch.reorgkeyword.value;
				setResearchValue();
			}
		}
	}
	*/
	document.frmList.submit();
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
function moveScroll(){
	var varOffset = 0;
	if (document.body.scrollTop){
		varOffset = top.document.body.scrollTop;
	}else{
		varOffset = top.document.documentElement.scrollTop;
	}
	var varOffsetMi = 0;
	//varOffsetMi = varOffset/10;
	varOffsetMi = 20;
	if ((varOffset-varOffsetMi) >= 0){
		top.scrollTo(0,(varOffset-varOffsetMi));
		setTimeout(function(){moveScroll();},1);
	}
}
function goPage(page,brand){
	//top.viewLoadingBar();
	if (document.body.scrollTop){
		top.document.body.scrollTop = "0px";
	}else{
		top.document.documentElement.scrollTop = "0px";
	}

	top.scrollTo(0,0);

	//moveScroll();

	if ( varTargetPage == "/search/EnuriSearch.jsp"){
		var varLoadingLeft = 0;
		if (top.document.getElementById("gnbMenu")){
			varLoadingLeft = (top.document.getElementById("gnbMenu").offsetWidth/2 - 150);
		}
		top.document.getElementById("searchlist_reloading").style.left = varLoadingLeft + "px";
		var varTop = 300;
		if (top.document.getElementById("topBannerNew")){
			if(top.document.getElementById("topBannerNew").style.display != "none"){
				varTop += top.document.getElementById("topBannerNew").offsetHeight;
			}
		}
		top.document.getElementById("searchlist_reloading").style.top = varTop + "px";
		top.document.getElementById("searchlist_reloading").style.display = "";
		if (document.getElementById("view").value == "img"){
			top.viewSearchReloadingBar();
		}
	}
	if (page == 1 ){
		insertLog(6229);
	}else if(page == 2 ){
		insertLog(6230);
	}else if(page == 3 ){
		insertLog(6231);
	}else if(page == 4 ){
		insertLog(6232);
	}else if(page == 5 ){
		insertLog(6233);
	}else if(page == 6 ){
		insertLog(6234);
	}else if(page == 7 ){
		insertLog(6235);
	}else if(page == 8 ){
		insertLog(6236);
	}else if(page == 9 ){
		insertLog(6237);
	}else if(page == 10 ){
		insertLog(6238);
	}else if(page > 10){
		insertLog(6239);
	}
	var varPrevPage = document.frmList.page.value;
	document.frmList.page.value=page;
	if (document.getElementById("okeyword")){
		document.frmList.keyword.value = document.frmList.okeyword.value;
	}
	if(varTargetPage == "/search/EnuriSearch.jsp"){
		if (document.getElementById("in_o_keyword")){
			document.frmList.in_keyword.value = document.frmList.in_o_keyword.value;
		}
	}
	if (typeof(brand) == "undefined"){
		if (document.getElementById("cate_add_tab_search") && !document.getElementById("okeyword")){
			if (document.getElementById("cate_add_tab_search").value == "Y"){
				getCountAddCatePage();
				return;
			}
		}
		if (document.getElementById("brand_add_search")){
			document.frmList.brand_add_search.value="";
		}
		if (document.getElementById("page_enuri")){
			document.frmList.page_enuri.value="";
		}
	}else{

		if (document.frmList.page_enuri.value.isnumber() && (page <= parseInt(document.frmList.page_enuri.value)) ){
			document.frmList.brand_add_search.value="";
			document.frmList.page_enuri.value="";
		}else{
			if (!brand){
				if (varPrevPage < page ){
					if(varTargetPage == "/view/Listbody_Social_2013.jsp"){
						getCountSocialPage(page,varPrevPage);
					}else{
						getCountBrandPage(page,varPrevPage);
					}
					return;
				}else{
					document.frmList.page_enuri.value=page-1;
				}
			}
			document.frmList.brand_add_search.value="Y";
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
		document.getElementById("img_sort_btn").src = var_img_enuri_com + "/2012/list/btn_x.gif";
		document.getElementById("sort_mode").style.display = "";
	}
}
function hideSortmode(){
	document.getElementById("sort_mode").style.display = "none";
}
function select_sort(key,e){
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
	if(varTargetPage == "/search/EnuriSearch.jsp"){
		/*
		if (document.getElementById("div_re_seach")){
			if (document.getElementById("div_re_seach").style.display != "none"){
				document.frmList.research.value = "Y";
				document.frmList.reorgkeyword.value = top.document.fmMainSearch.reorgkeyword.value;
				setResearchValue();
			}
		}
		*/
		if (document.getElementById("in_o_keyword")){
			document.frmList.in_keyword.value = document.frmList.in_o_keyword.value;
		}
		var varLoadingLeft = 0;
		if (top.document.getElementById("gnbMenu")){
			varLoadingLeft = (top.document.getElementById("gnbMenu").offsetWidth/2 - 150);
		}
		top.document.getElementById("searchlist_reloading").style.left = varLoadingLeft + "px";
		top.document.getElementById("searchlist_reloading").style.display = "";
		top.viewSearchReloadingBar();
	}
	document.frmList.page.value = "1";
	document.frmList.key.value=key;
	document.frmList.submit();

}
function showRecKeyword(){

}
var varDetailMultiWinName = "detailMultiWin";
function detailMultiView(OpenFile,name,modelno){
 	changeSelectedModelBg(modelno);
 	fnSetCookie2010("opendetail","Y",1);
 	var sheight = eval(screen.height);
 	if(navigator.userAgent.toLowerCase().indexOf("chrome")>0 && navigator.userAgent.toLowerCase().indexOf("edge")>0){ //win10+edge
 		sheight -= 150;
 	}
 	//top.detailMultiView(OpenFile,name,modelno);
 	/*top.detailWin = window.open("/_pre_detail_.jsp","detailMultiWin","width=804,height="+sheight+",left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
 	top.detailWin.location.href = OpenFile;
 	if (OpenFile.indexOf("BigImageOnlyPopup.jsp") >=0 ){
 		top.detailWin.focus();
 	}*/

 	//vip 개편작업
 	if(OpenFile.indexOf("/view/Detailmulti.jsp")>-1 ){
 		OpenFile = OpenFile.replace("/view/Detailmulti.jsp","/detail.jsp");
 	}
 	var detailWin = window.open("/_pre_detail_.jsp");
 	//var detailWin = window.open("/_pre_detail_.jsp","detailMultiWin","width=804,height="+sheight+",left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
	detailWin.location.href = OpenFile;
	detailWin.focus();
 	/*
	if(varTargetPage == "/search/EnuriSearch.jsp"){
		var abTest = new Abtest("search_ab_001");
		abTest.update();
		insertUsability("M",modelno);
	}
	if(varTargetPage == "/search/EnuriSearch.jsp"){
		insertUsability("M",modelno);
	}
	*/
	if(top.location.pathname.indexOf("view/Listmp3.jsp")>=0){
		insertLog(14951);
	}else if(top.location.pathname.indexOf("search/Searchlist.jsp")>=0){
		insertLog(14953);
	}
}
function changeSelectedModelBg(modelno){
	if (document.getElementById("view")){
		if (document.getElementById("view").value == "gp"){
			if (document.getElementById("goods_more_list_tdchk_"+modelno)){
				document.getElementById("goods_more_list_tdchk_"+modelno).style.backgroundColor="#dbecf4"
			}
			if (document.getElementById("goods_more_list_td0_"+modelno)){
				document.getElementById("goods_more_list_td0_"+modelno).style.backgroundColor="#dbecf4"
			}
			if (document.getElementById("goods_more_list_td1_"+modelno)){
				document.getElementById("goods_more_list_td1_"+modelno).style.backgroundColor="#dbecf4"
			}
			if (document.getElementById("goods_more_list_td2_"+modelno)){
				document.getElementById("goods_more_list_td2_"+modelno).style.backgroundColor="#dbecf4"
			}
			if (document.getElementById("goods_more_list_td3_"+modelno)){
				document.getElementById("goods_more_list_td3_"+modelno).style.backgroundColor="#dbecf4"
			}
		}
		if (document.getElementById("view").value == "img"){
			if (document.getElementById("goods_image_list_dl_"+modelno)){
				document.getElementById("goods_image_list_dl_"+modelno).style.backgroundColor="#d8e6f5";
				document.getElementById("goods_image_list_dd1_"+modelno).style.backgroundColor="#d8e6f5";
				document.getElementById("goods_image_list_dd2_"+modelno).style.backgroundColor="#d8e6f5";
			}
		}
	}
}
function eCatalogShow(url) {
	var eCatalogPopup = null;
	if(url.toUpperCase().substring(url.length-4)==".JPG" || url.toUpperCase().substring(url.length-4)==".GIF" || url.toUpperCase().substring(url.length-4)==".PNG") {
		url = "/view/include/EcatalogView.jsp?imageurl="+encodeURIComponent(url);
		eCatalogPopup = window.open(url,null,"width=100,height=100,top=0,left=0,toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,menubar=no,personalbar=no");
	} else {
		eCatalogPopup = window.open(url,null,"width=742,height=1000,top=0,left=0,toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no,personalbar=no");
	}
	eCatalogPopup.focus();
}
function reFactorySearch(factory, modelno){
	insertLog(4463);
	checkFactory.value =factory
	factorySearch(modelno);
}
function reBrandSearch(brand){
	insertLog(4463);
	checkBrand.value =brand
	brandSearch();
}
function getFactoryLayer(modelno,factory){
	insertLog(2664);
	hideAllLayer();
	var f_factory_onclick = function(){
		//document.getElementById("factory").value = factory;
		insertLog(4463);
		checkFactory.value =factory
		factorySearch();
	}
	document.getElementById("factory_click").onclick = f_factory_onclick

	document.getElementById("factory_name1").innerHTML = factory.replace(/&/g, "&amp;");
	document.getElementById("factory_name2").innerHTML = factory.replace(/&/g, "&amp;");
	document.getElementById("factory_name3").innerHTML = factory.replace(/&/g, "&amp;");

	document.getElementById("factory_click").title = factory+" 상품만 검색합니다.";
	document.getElementById("factory_home").title = factory+" 홈페이지를 봅니다.";

	var varTop = 0;
	var varLeft = 0;
	if (document.getElementById("view").value == "1p"){
		var posLeftTop = Position.cumulativeOffset($("goodslist1_td_1_"+modelno));
		if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6){
			varTop = posLeftTop[1] - 14
		}else if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 7){
			varTop = posLeftTop[1] - 12 ;
		}else{
			varTop = posLeftTop[1] - 9;
		}
		varLeft = Position.cumulativeOffset($("factory_"+modelno))[0];
	}else if (document.getElementById("view").value == "2p"){
		var posLeftTop = Position.cumulativeOffset($("goodslist2_td_2_"+modelno));
		if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6){
			varTop = posLeftTop[1] - 14;
		}else if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 8){
			varTop = posLeftTop[1] - 10;
		}else if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 7){
			varTop = posLeftTop[1] - 12 ;
		}else{
			varTop = posLeftTop[1] - 9;
		}
		varLeft = Position.cumulativeOffset($("factory_"+modelno))[0];
	}else if(document.getElementById("view").value == "gp"){
		var posLeftTop = Position.cumulativeOffset($("goodslistgp_td_1_"+modelno));
		if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6){
			varTop = posLeftTop[1] - 20;
		}else if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 7){
			varTop = posLeftTop[1] - 13;
		}else{
			varTop = posLeftTop[1] - 10;
		}
		varLeft = Position.cumulativeOffset($("factory_"+modelno))[0];
	}

	var url = "/include/IncFactoryLayerInner_2010.jsp";
	var param = "modelno="+modelno;

	var getFactoryInfo = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:showFactoryLayer
		}
	);

	function showFactoryLayer(originalRequest){
		eval("factory_home_url = " + originalRequest.responseText);
		if (factory_home_url.URL.trim().length > 0 ){
			document.getElementById("factory_home_link").style.display = "";
			document.getElementById("factory_home").onclick = function(){
				insertLog(4464);
				document.getElementById("factory_home").href = factory_home_url.URL.trim();
				document.getElementById("factory_info_layer").style.display = "none";
			}
		}else{
			//varTop = varTop - 7;
			document.getElementById("factory_home_link").style.display = "none";
		}
		if (factory_home_url.EURL.trim().length > 0 ){
			document.getElementById("factory_ecatalog_link").style.display = "";
			document.getElementById("factory_ecatalog").onclick = function(){
				insertLog(4465);
				eCatalogShow(factory_home_url.EURL.trim());
				document.getElementById("factory_info_layer").style.display = "none";
			}
		}else{
			document.getElementById("factory_ecatalog_link").style.display = "none";
		}
		if ((varLeft + 150) > document.getElementById("wrap").offsetWidth){
			varLeft = document.getElementById("wrap").offsetWidth - 155;
		}
		document.getElementById("factory_info_layer").style.left = varLeft+"px";
		document.getElementById("factory_info_layer").style.top = varTop+"px";
		document.getElementById("factory_info_layer").style.display = "";
		var varAddHeight = 0;
		if (!(BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6)){
			varAddHeight = 6;
		}
		//document.getElementById("factory_click_li").style.height = document.getElementById("factory_click").offsetHeight+"px";
		//document.getElementById("factory_info_layer_list").style.height = (document.getElementById("factory_click").offsetHeight + varAddHeight + document.getElementById("factory_home_link").offsetHeight + document.getElementById("factory_ecatalog_link").offsetHeight) + "px";

		if ((varLeft + document.getElementById("factory_info_layer").offsetWidth) > document.getElementById("wrap").offsetWidth ){
			document.getElementById("factory_info_layer").style.left = (varLeft - (varLeft + document.getElementById("factory_info_layer").offsetWidth - document.getElementById("wrap").offsetWidth) - 5)+"px";
		}
		if (varTargetPage == "/view/Listbody_NewBrand.jsp"){
			document.getElementById("factory_click_li").style.display = "none";
			document.getElementById("factory_home_link").style.marginTop = "";
		}
	}

}
function changeOrderImg(){
	if (document.getElementById("btn_pop_order_sort")){
		if (document.getElementById("btn_pop_order_sort").src == var_img_enuri_com + "/2012/list/sort_popular_out2.gif"){
			document.getElementById("btn_pop_order_sort").src = var_img_enuri_com + "/2012/list/sort_order_out2.gif"
		}else{
			document.getElementById("btn_pop_order_sort").src = var_img_enuri_com + "/2012/list/sort_popular_out2.gif"
		}
	}
}
function check_weight_sort_img(cate){
	if (cate == "2401" ){
		insertLog(7875);
		select_sort("weight+DESC");
	}else{
		insertLog(7877);
		select_sort("weight");
	}
}
function check_sort_img(){
	if (document.getElementById("btn_pop_order_sort").src.indexOf("popular") >= 0 ){
		insertLog(84);
		select_sort("popular+DESC");
	}else{
		insertLog(136);
		select_sort("sale_cnt+DESC");
	}
}
function over_sort_img(){
	if (typeof(timerChnageOrderButton) != "undefined"){
		clearTimeout(timerChnageOrderButton);
	}
	if (document.getElementById("btn_pop_order_sort").src == var_img_enuri_com + "/2012/list/sort_popular_out2.gif"){
		document.getElementById("btn_pop_order_sort").src = var_img_enuri_com + "/2012/list/sort_popular_over2.gif"
	}else{
		document.getElementById("btn_pop_order_sort").src = var_img_enuri_com + "/2012/list/sort_order_over2.gif"
	}
}
function out_sort_img(){
	if (document.getElementById("btn_pop_order_sort").src == var_img_enuri_com + "/2012/list/sort_popular_over2.gif"){
		document.getElementById("btn_pop_order_sort").src = var_img_enuri_com + "/2012/list/sort_popular_out2.gif"
	}else{
		document.getElementById("btn_pop_order_sort").src = var_img_enuri_com + "/2012/list/sort_order_out2.gif"
	}
	if (typeof(timerChnageOrderButton) != "undefined"){
		timerChnageOrderButton = setInterval("changeOrderImg()",800);
	}
}
function over_sort_img2(){
	if (document.getElementById("btn_pop_order_sort").src == var_img_enuri_com + "/2012/list/sort_popular_out2.gif"){
		document.getElementById("btn_pop_order_sort").src = var_img_enuri_com + "/2012/list/sort_popular_over2.gif"
	}else{
		document.getElementById("btn_pop_order_sort").src = var_img_enuri_com + "/2012/list/sort_order_over2.gif"
	}
}
function out_sort_img2(){
	if (document.getElementById("btn_pop_order_sort").src == var_img_enuri_com + "/2012/list/sort_popular_over2.gif"){
		document.getElementById("btn_pop_order_sort").src = var_img_enuri_com + "/2012/list/sort_popular_out2.gif"
	}else{
		document.getElementById("btn_pop_order_sort").src = var_img_enuri_com + "/2012/list/sort_order_out2.gif"
	}
}
function goNewGoodsList(cate){
	if (cate.length >= 4){
		cate = cate.substring(0,4);
	}
	insertLogCate(143,cate);
	//top.location.href="/view/Listnewgoods_New.jsp?NewGoodMore=1&from=list&pop=yes&cate="+cate;
	//top.location.href="/knowbox/IssueList.jsp?kbcode=NEW&fromList=1&cate="+cate;
	location.href = "Listbody_New.jsp?cate="+cate;

}
/*
function over_newgoods_img(){
	document.getElementById("btn_newgoods_list").style.backgroundImage= "url("+var_img_enuri_com+"/2012/list/open_over2.gif)"
}
function out_newgoods_img(){
	document.getElementById("btn_newgoods_list").style.backgroundImage= "url("+var_img_enuri_com+"/2012/list/open_out2.gif)"
}
*/
function over_newgoods_img(){
	document.getElementById("btn_newgoods_list").style.backgroundImage= "url("+var_img_enuri_com+"/2012/list/list_soon_over.gif)"
}
function out_newgoods_img(){
	document.getElementById("btn_newgoods_list").style.backgroundImage= "url("+var_img_enuri_com+"/2012/list/list_soon_out.gif)"
}

function setKeywordBackground(){

}
function hideAllLayer(layer){
	if (layer != "pricelist"){
		hidePricelistLayer(varPlsno);
	}

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
		"sort_mode","view_mode","view_mode2","select_paging_group","reckeyword","factory_info_layer","divWeightInfo","orderListDiv","divLowestPriceInfo","booklayer","div_point_info","div_innoresult","scate_layer","img_catekeyword_help","img_removesynonyum_help",
	];
	var topHideLayers = [
		"comparisonInfo","myfavoriteInfo","sprice_info","popular_info_layer","div_inconv","ac_layer","beginner_big_img","clauseLayer","booklayer","clauseInfoDiv","dicGoogleLayer","popularListDiv","orderListDiv","smartDiv","div_brand_list","div_Tc_Tab","div_Event_Tab","LayerM_KBMenu","divGoodsDetailInfo","simg_layer","div_inconv_2","More_layer_2","More_layer","app_dn_layer","app_dn_layer_car","More_layer_3","More_layer_2"
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
	if (parent.document.getElementById("divBrand2List")){
		parent.document.getElementById("divBrand2List").style.display = "none";
	}
}
function googleSearch(modelno,modelnm,spec,factory,minprice,isLayer,cate){
	hideAllLayer();
	spec = spec.replace(/"/g, "<=quot>") ;
	spec = spec.replace(/'/g, "<=singleQuot>") ;
	spec = spec.replace(/\r\n/g, "<=/r/n>") ;
	spec = spec.replace(/\\/g, "\\\\") ;
	top.googleSearch(modelno,modelnm,spec,factory,minprice,isLayer,cate);

}
var arrCheckedModelNo = new Array();
var arrCheckedModelNoBook = new Array();
function checkModel(modelno,bBook,isAddSearch){
	var bChecked = false;
	var varPrefix = "G:";
	if (typeof(isAddSearch) != "undefined"){
		varPrefix = "P:"
	}
	if (arrCheckedModelNo.indexOf(varPrefix+modelno) >= 0){
		arrCheckedModelNo = arrCheckedModelNo.without(varPrefix+modelno);
		arrCheckedModelNoBook[arrCheckedModelNo.indexOf(varPrefix+modelno)] = true;
	}else{
		bChecked = true;
		arrCheckedModelNo[arrCheckedModelNo.length] = varPrefix+modelno;
		if (typeof(bBook) != "undefined" && bBook){
			arrCheckedModelNoBook[arrCheckedModelNoBook.length] = true;
		}else{
			arrCheckedModelNoBook[arrCheckedModelNoBook.length] = false;
		}
	}
	setPositionCompareZzim($("chk_"+modelno));
	var bDisplay = false;
	for (i=0;i<arrCheckedModelNoBook.length;i++){
		if (!arrCheckedModelNoBook[i] ){
			bDisplay = true;
		}
	}
	if (arrCheckedModelNo.size() > 0){
		if (bDisplay && !(getFumCheckModel(modelno))){
			//$("comparenzzim").getElementsBySelector("img")[0].style.display = ""
		}else{
			//$("comparenzzim").getElementsBySelector("img")[0].style.display = "none";
		}
		document.getElementById("comparenzzim").style.display = "";

	}else{
		document.getElementById("comparenzzim").style.display = "none";
	}

	if (document.getElementById("pchk_"+modelno)){
		document.getElementById("pchk_"+modelno).checked = bChecked;
	}
	if (varPrefix == "P:"){
		if (document.getElementById("btn_fum")){
			document.getElementById("btn_fum").style.display = "none";
		}
	}
}
function getFumCheckModel(modelno){
	function contains(a, obj) {
	    var i = a.length;
	    while (i--) {
	       if (a[i] === obj) {
	           return true;
	       }
	    }
	    return false;
	}

	var arrModel = [ 8361362 ,7820366 ,11372296 ,11439697 ,11476890 ,11476883 , 11476887 , 11372322 , 11435489 , 11495006 , 11495001,11874713,11893759,11895731,11895724,11895743,11895750,11895748,11895749,11892326,11896209,11874479,11892496,11895438,11895445,11895440,11895444,11892495,11895477,11895486,11895481,11895484,1189238511895420, 11895418, 11895416, 11895417,11892497,11893833,11893846,11893840,11893842,11895751,11895759,11895752,11895757,11895758,11896237,11896498,11896525,11896522,11896519 ]
	return contains(arrModel,modelno);

}
function pcheckModel(modelno,bBook){
	var bChecked = false;
	var varPrefix = "G:";
	if (arrCheckedModelNo.indexOf(varPrefix+modelno) >= 0){
		arrCheckedModelNo = arrCheckedModelNo.without(varPrefix+modelno);
	}else{
		bChecked = true;
		arrCheckedModelNo[arrCheckedModelNo.length] = varPrefix+modelno;
	}
	setPositionCompareZzim($("pchk_"+modelno),'l')
	if (arrCheckedModelNo.size() > 0){
		if (typeof(bBook) != "undefined" || getFumCheckModel(modelno)){
			//$("comparenzzim").getElementsBySelector("img")[0].style.display = "none";
		}else{
			//$("comparenzzim").getElementsBySelector("img")[0].style.display = ""
		}
		document.getElementById("comparenzzim").style.display = "";

	}else{
		document.getElementById("comparenzzim").style.display = "none";
	}
	if (document.getElementById("view").value == "img"){
		if (bChecked){
			document.getElementById("pchk_"+modelno).src = var_img_enuri_com + "/2010/images/view/picture_check.gif";
		}else{
			document.getElementById("pchk_"+modelno).src = var_img_enuri_com + "/2010/images/view/picture_checkout.gif";
		}
	}

	if (document.getElementById("chk_"+modelno)){
		document.getElementById("chk_"+modelno).checked = bChecked;
	}
}
var _f_chekModel;
function setPositionCompareZzim(chkModel,chkLoc){
	if (typeof(chkModel) != "undefined"){
		_f_chekModel = chkModel;
	}
	if (typeof(_f_chekModel) != "undefined"){
		var posLeftTop = Position.cumulativeOffset(_f_chekModel);
		var posLeft = 0 ;
		var posTop = posLeftTop[1]+15;
		if (document.getElementById("view").value == "2p"){
			posLeft = posLeftTop[0]+13;
		}else if (document.getElementById("view").value == "img"){
			posLeft = posLeftTop[0]+25;
			posTop = posTop-15;
		}else{
			var varMLeft = 120;
			/*
			if (typeof(varCate) != "undefined"){
				if (varCate.length >= 2){
					if (varCate.substring(0,2) == "15"){
						varMLeft = 65;
					}
				}
			}
			*/
			posLeft = posLeftTop[0]-varMLeft;
		}


		if (posLeft < 5 ){
			posLeft = 5
		}

		if (typeof(chkLoc) != "undefined"){
			posLeft = posLeft + 105 + 36;
		}
		if (varTargetPage == "/view/Listbody_Smart.jsp" ){
			posLeft = posLeft + 53;
		}

		document.getElementById("comparenzzim").style.left = posLeft+"px";
		document.getElementById("comparenzzim").style.top = posTop+"px";
	}
}
function openOrderListInfoLayer(e){
	if(!e) var e = window.event;
	hideAllLayer();
	top.popOrderlist();

	e.cancelBubble = true;
	e.returnValue = false;
	if (e.stopPropagation) {
		e.stopPropagation();
		e.preventDefault();
	}
}
function openLowestPriceInfoLayer(e){
	if(!e) var e = window.event;
	hideAllLayer();
	if (document.getElementById("divLowestPriceInfo") && document.getElementById("divLowestPriceInfo").innerHTML != ""){
		if (document.getElementById("divLowestPriceInfo").style.display != "none"){
			document.getElementById("divLowestPriceInfo").style.display = "none";
		}else{
			document.getElementById("divLowestPriceInfo").style.display = "";
			if (document.getElementById("linemap")){
				document.getElementById("divLowestPriceInfo").style.top = (Position.cumulativeOffset($("linemap"))[1])+"px"
			}
			if (document.getElementById("location")){
				document.getElementById("divLowestPriceInfo").style.top = (Position.cumulativeOffset($("location"))[1])+"px"
			}
		}
	}else{
 		function createLayer(originalRequest){
			document.getElementById("divLowestPriceInfo").innerHTML = originalRequest.responseText;
			document.getElementById("divLowestPriceInfo").style.display = "";
			if (document.getElementById("linemap")){
				document.getElementById("divLowestPriceInfo").style.top = (Position.cumulativeOffset($("linemap"))[1])+"px"
			}
			if (document.getElementById("location")){
				document.getElementById("divLowestPriceInfo").style.top = (Position.cumulativeOffset($("location"))[1])+"px"
			}
 		}
		var url = "/include/layer/IncLowestPriceInfoLayer_2010.jsp";
		var getLayerInfo = new Ajax.Request(
			url,
			{
				method:'get',onComplete:createLayer
			}
		);
	}

	e.cancelBubble = true;
	e.returnValue = false;
	if (e.stopPropagation) {
		e.stopPropagation();
		e.preventDefault();
	}
}
function openWeightInfoLayer(e){
	if(!e) var e = window.event;
	hideAllLayer();
	if (document.getElementById("divWeightInfo") && document.getElementById("divWeightInfo").innerHTML != ""){
		if (document.getElementById("divWeightInfo").style.display != "none"){
			document.getElementById("divWeightInfo").style.display = "none";
		}else{
			document.getElementById("divWeightInfo").style.display = "";
		}
	}else{
 		function createLayer(originalRequest){
			document.getElementById("divWeightInfo").innerHTML = originalRequest.responseText;
			document.getElementById("divWeightInfo").style.display = "";
 		}
		var url = "/include/layer/IncWeightInfoLayer_2010.jsp";
		var getLayerInfo = new Ajax.Request(
			url,
			{
				method:'get',onComplete:createLayer
			}
		);
	}
	e.cancelBubble = true;
	e.returnValue = false;
	if (e.stopPropagation) {
		e.stopPropagation();
		e.preventDefault();
	}
}
function openSellPriceInfoLayer(obj,cate){
	hideAllLayer();
	if (document.getElementById("divSellPrice")){
		document.getElementById("divSellPrice").style.display = "";
		document.getElementById("divSellPrice").style.top = Position.cumulativeOffset($(obj))[1]+"px";
	}else{
		var varLayerHtml = "";
		varLayerHtml += "<img src=\""+var_img_enuri_com+"/2012/list/"+cate.substring(0,4)+"_150625.png\" usemap=\"#map_sellprice\" border=\"0\">";
		varLayerHtml += "<map name=\"map_sellprice\" id=\"map_sellprice\">";
		varLayerHtml += "<area shape=\"rect\" coords=\"91,79,125,96\" href=\"#\" onclick=\"Main_OpenWindow('/phone_word/new_phone_word.html#b2\','phoneShowPrice','670','500','NO','NO',0,0);\" />";
		varLayerHtml += "<area shape=\"rect\" coords=\"173,86,216,102\" href=\"#\" onclick=\"Main_OpenWindow('/phone_word/new_phone_word.html#a7\','phoneShowPrice','670','500','NO','NO',0,0);\"  />";
		varLayerHtml += "<area shape=\"rect\" coords=\"257,62,329,77\" href=\"#\" onclick=\"Main_OpenWindow('/phone_word/new_phone_word.html#b10\','phoneShowPrice','670','500','NO','NO',0,0);\" />";
		varLayerHtml += "<area shape=\"rect\" coords=\"91,131,128,149\" href=\"#\" onclick=\"Main_OpenWindow('/phone_word/new_phone_word.html#b7\','phoneShowPrice','670','500','NO','NO',0,0);\" />";
		varLayerHtml += "<area shape=\"rect\" coords=\"89,217,127,233\" href=\"#\" onclick=\"Main_OpenWindow('/phone_word/new_phone_word.html#b2\','phoneShowPrice','670','500','NO','NO',0,0);\"  />";
		varLayerHtml += "<area shape=\"rect\" coords=\"172,222,215,240\" href=\"#\" onclick=\"Main_OpenWindow('/phone_word/new_phone_word.html#a7\','phoneShowPrice','670','500','NO','NO',0,0);\" />";
		varLayerHtml += "<area shape=\"rect\" coords=\"257,199,320,216\" href=\"#\" onclick=\"Main_OpenWindow('/phone_word/new_phone_word.html#b9\','phoneShowPrice','670','500','NO','NO',0,0);\" />";
		varLayerHtml += "<area shape=\"rect\" coords=\"89,268,129,286\" href=\"#\" onclick=\"Main_OpenWindow('/phone_word/new_phone_word.html#b7\','phoneShowPrice','670','500','NO','NO',0,0);\" />";
		varLayerHtml += "<area shape=\"rect\" coords=\"241,286,291,303\" href=\"#\" onclick=\"Main_OpenWindow('/phone_word/new_phone_word.html#a9\','phoneShowPrice','670','500','NO','NO',0,0);\" />";
		varLayerHtml += "<area shape=\"rect\" coords=\"698,15,714,32\" href=\"#\" onclick=\"$('divSellPrice').style.display='none'\"/></map>";
		var varLayerObj = document.createElement("DIV");
		varLayerObj.id = "divSellPrice";
		varLayerObj.style.position = "absolute";
		varLayerObj.style.top = Position.cumulativeOffset($(obj))[1]+"px"
		varLayerObj.style.left = (document.getElementById("wrap").offsetWidth/2-300)+"px"
		varLayerObj.style.width="759";
		varLayerObj.style.height="430";
		varLayerObj.style.zIndex=100;
		varLayerObj.innerHTML = varLayerHtml
		document.getElementById("wrap").insertBefore(varLayerObj,null);
	}
}
function showPopularInfo(modelno,ingiObj){
	if (document.getElementById("view").value == "1p"){
		var posLeftTop = Position.cumulativeOffset($("goodslist1_td_1_"+modelno));
		varTop = posLeftTop[1];
		varLeft = posLeftTop[0];
	}else if (document.getElementById("view").value == "2p"){
		var posLeftTop = Position.cumulativeOffset($("goodslist2_td_1_"+modelno));
		varTop = posLeftTop[1];
		varLeft = posLeftTop[0];
	}else if(document.getElementById("view").value == "gp"){
		var posLeftTop = Position.cumulativeOffset($(ingiObj));
		varTop = posLeftTop[1];
		varLeft = posLeftTop[0];

		var posLeftTop2 = Position.cumulativeOffset($("tab"));
		varTop2 = posLeftTop2[1];
		varLeft2 = posLeftTop2[0];
		varTop = varTop - varTop2+15;

	}else if(document.getElementById("view").value == "img"){
		var posLeftTop = Position.cumulativeOffset($("goods_image_list_dl_"+modelno));
		varTop = posLeftTop[1]+15;
		varLeft = posLeftTop[0];
		if ((varLeft-90+345) > document.getElementById("wrap").offsetWidth){
			varLeft = varLeft - ((varLeft-90+345) -  top.document.getElementById("wrap").offsetWidth ) - 10;
		}
	}

	if(varTargetPage != "/search/EnuriSearch.jsp"){
		if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 7){
			varLeft = -152;
		}else{
			varLeft = -140;
		}
	}else{
		varLeft = 0;
	}

	/*
	if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 7){
		varTop = varTop - 15;
	}
	*/
	/*
	varLeft = varLeft - 90;
	if (top.document.getElementById("enuriMenuFrame")){
		var posLeftTop2 = Position.cumulativeOffset(top.document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame"));
		varTop = varTop + posLeftTop2[1] - 20;
	}else if (top.document.getElementById("searchListFrame")){
		varTop = varTop + 60;
	}
	*/

	if (showPopularInfo._f_modelno == modelno && document.getElementById("layerPop").style.display != "none"){
		closeLayer('layerPop');
	}else{
		//document.getElementById("layerPop").style.left = varLeft+"px"
		document.getElementById("layerPop").style.top = varTop+"px"
		document.getElementById("layerPop").style.left = varLeft+"px"
		if (document.getElementById("layerPop").style.display == "none"){
			openLayer('layerPop');
		}
	}
	showPopularInfo._f_modelno = modelno;

}
function showEcatalog(ecatalogflag,ecatalogurl){
	if (ecatalogflag == "1"){
		insertLog(3865);
		if(ecatalogurl.toUpperCase().substring(ecatalogurl.length-4)==".JPG" || ecatalogurl.toUpperCase().substring(ecatalogurl.length-4)==".GIF" || ecatalogurl.toUpperCase().substring(ecatalogurl.length-4)==".PNG") {
			var url = "/view/include/EcatalogView.jsp?imageurl="+ecatalogurl;
			window.open(url,null,"width=100,height=100,top=0,left=0,toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,menubar=no,personalbar=no");
		} else {
			var newDate = new Date();
			var newWinName = newDate.getMilliseconds()+"";
			window.open(ecatalogurl,newWinName,'left=0,top=0,width=730,height='+screen.availHeight+',toolbar=no,location=no,directories=no,status=no,resizable=yes,menubar=no,personalbar=no,scrollbars=yes');
		}
	}
}
function showCondiNameDic(ref_kbno,modelno,cate,e,multimodelno){
	if(!e) var e = window.event;
	var tObj;
	if (getBrowserName().indexOf("msie") >= 0 ){
		tObj = e.srcElement
	}else{
		tObj = e.target;
	}

	if (tObj.parentElement.className != "bg_guide_over"){
		insertBeginnerDicLog(ref_kbno);
		//getBeginnerDic(ref_kbno,modelno,cate,false,1,e,multimodelno);
		getBeginnerDic(ref_kbno,modelno,cate,false);
	}else{
		fireEvent(tObj.parentElement,"click");
	}
	e.cancelBubble = true;
	e.returnValue = false;
	if (e.stopPropagation) {
		e.stopPropagation();
		e.preventDefault();
	}
}
function showRolling(imgsrc,imgobj){
	imgobj.src = imgsrc;
}
function setPositionLayers(){
	setPositionCompareZzim();
	setPositionFactoryGo();
	setPositionPriceGo();
	setPositionShopGo();
	//setWidthLineMap();
	setPositionFactorySort();
	setPositionCategoryGo();
	//setPositionShop4Layer();
	if (typeof(cmdFusionResize_new) == "function"){
		cmdFusionResize_new();
	}
	if (varTargetPage == "/view/Listbody_NewBrand.jsp"){
		parent.setHeightBrandCateList();
	}
}

function setGoodsDescHeight(modelno){
	return (document.getElementById("goodslist2_td_0_"+modelno).offsetHeight - document.getElementById("goodslist2_td_1_"+modelno).offsetHeight)+"px";
}
function setWidthLineMap(){
	if (document.getElementById("top_location") && varTargetPage != "/view/Listbody_Smart.jsp"){
		var varWidth = 20;
		/*
		if (document.getElementById("btn_weight_order_sort")){
			varWidth += document.getElementById("btn_weight_order_sort").offsetWidth;
		}
		if (document.getElementById("btn_pop_order_sort")){
			varWidth += document.getElementById("btn_pop_order_sort").offsetWidth;
		}
		if (document.getElementById("btn_newgoods_list")){
			varWidth += document.getElementById("btn_newgoods_list").offsetWidth;
		}
		if (document.getElementById("btn_bigphoto")){
			varWidth += document.getElementById("btn_bigphoto").offsetWidth;
		}
		*/
		if (document.getElementById("list_btn")){
			varWidth += document.getElementById("list_btn").offsetWidth;
		}
		if (varTargetPage == "/search/WebSearch.jsp" || varTargetPage == "/search/EnuriSearch.jsp"){
			varWidth = 80;
		}
		/*
		if (!(BrowserDetect.browser == "Explorer" && BrowserDetect.version == 7)){
			document.getElementById("linemap").style.width = (document.getElementById("wrap").offsetWidth - varWidth)+"px";
		}
		*/
		if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 7){
			varWidth += 10;
		}
		document.getElementById("linemap").style.width = (document.getElementById("wrap").offsetWidth - varWidth)+"px";
	}
}

function hideZzimComp(){
	document.getElementById("comparenzzim").style.display = "none";
}

function showCatalogDownload(modelno,userid,popularmodelno){
	hideAllLayer();
	var posTop;
	var varModelName = "";
	var varFactory = "";
	if ($("modelname_"+modelno)){
		varModelName = $("modelname_"+modelno).innerHTML.stripTags();
		if($("factory_"+modelno)){
			varFactory = $("factory_"+modelno).innerHTML.stripTags();
		}
	}else {
		if (typeof(popularmodelno) != "undefined"){
			if ($("modelname_"+popularmodelno)){
				varModelName = $("modelname_"+popularmodelno).innerHTML.stripTags();
				if($("factory_"+modelno)){
					varFactory = $("factory_"+popularmodelno).innerHTML.stripTags();
				}
			}
		}
	}
	if (varFactory.toUpperCase().indexOf("<NOBR>") >= 0){
		varFactory = varFactory.substring(varFactory.toUpperCase().indexOf("<NOBR>")+6,varFactory.toUpperCase().indexOf("</NOBR>"));
	}
	if (varModelName.toUpperCase().indexOf("<NOBR>") >= 0){
		varModelName = varModelName.substring(varFactory.toUpperCase().indexOf("<NOBR>")+6,varModelName.toUpperCase().indexOf("</NOBR>"));
	}
	if (document.getElementById("view").value == "2p"){
		var posLeftTop = Position.cumulativeOffset($("goodslist2_td_1_"+modelno));
		posTop = posLeftTop[1];
	}else if(document.getElementById("view").value == "1p"){
		var posLeftTop = Position.cumulativeOffset($("goodslist1_td_1_"+modelno));
		posTop = posLeftTop[1]+document.getElementById("goodslist1_td_1_"+modelno).offsetHeight;
	}else if (document.getElementById("view").value == "gp"){
		if ($("goodslistgp_td_1_"+modelno)){
			var posLeftTop = Position.cumulativeOffset($("goodslistgp_td_1_"+modelno));
			posTop = posLeftTop[1];
		}else{
			var posLeftTop2 = Position.cumulativeOffset($("goods_more_list_td1_"+modelno));
			posTop = posLeftTop2[1];
		}
	}else if (document.getElementById("view").value == "txt"){
		var posLeftTop = Position.cumulativeOffset($("goodslisttxt_td_1_"+modelno));
		posTop = posLeftTop[1] + document.getElementById("goodslist3_td_1_"+modelno).offsetHeight;
	}
	if ($("quot_"+modelno)){
		$("quot_"+modelno).style.color="#949494";
	}
	posTop = posTop + getListFrameTopPos();
	top.showCatalogDownload(modelno,userid,posTop,varModelName,varFactory);
}
function CmdGotoMall(type, cmd, vcode, modelno, price, url,cate,pl_no,imgurl,addsearch,instance_price,goodscode,afLayer){
	var bMobile = false;
	if (BrowserDetect.OS == "iPad" || BrowserDetect.OS == "iPhone/iPod" || BrowserDetect.OS == "Android"){
		bMobile = true;
	}
	if (typeof(afLayer) != "undefined"){
		bMobile = false;
	}

	if (!bMobile){
		if (type != "ep"){
			if (document.getElementById("goods_more_list_"+modelno)){
				document.getElementById("goods_more_list_"+modelno).style.backgroundColor="#dbecf4";
			}
			if (document.getElementById("view").value == "img"){
				if (document.getElementById("goods_image_list_dl_"+modelno)){
					document.getElementById("goods_image_list_dl_"+modelno).style.backgroundColor="#d8e6f5";
					document.getElementById("goods_image_list_dd1_"+modelno).style.backgroundColor="#d8e6f5";
					document.getElementById("goods_image_list_dd2_"+modelno).style.backgroundColor="#d8e6f5";
				}
			}
		}
		var w = window.screen.width;
		var h = screen.availHeight ;
		var strMoveTargetUrl = varMoveTargetPage;
		var varTargetUrl = "";
		if (type != "ep"){
			varTargetUrl = strMoveTargetUrl+"?type="+type+"&cmd="+cmd+"&vcode="+vcode+"&modelno="+modelno+"&price="+price+"&pl_no="+pl_no+"&imgurl="+imgurl+"&ads="+addsearch;
		}else{
			varTargetUrl = strMoveTargetUrl+"?type=ex&cmd="+cmd+"&vcode="+vcode+"&modelno="+modelno+"&price="+price+"&pl_no="+pl_no+"&imgurl="+imgurl+"&ads="+addsearch+"&ep=y&epkey="+goodscode;
		}
		var k = window.open("/_pre_detail_.jsp", "_blank");
		k.location.href = varTargetUrl;
		k.focus();
		if(top.location.pathname.indexOf("view/Listmp3.jsp")>=0){
			insertLog(14955);
		}else if(top.location.pathname.indexOf("search/Searchlist.jsp")>=0){
			insertLog(14956);
		}
	}else{
		/*var varMoblieLayer = "";
		varMoblieLayer += "<div><img src=\""+var_img_enuri_com +"/images/view/detail/20111027_01.png\" class=\"png24\" border=\"0\" /></div>";
		varMoblieLayer += "<div id=\"mobliePriceInfoInner\">";
		varMoblieLayer += "<img src=\""+var_img_enuri_com+"/images/view/detail/mlayer_xbtn.png\" width=\"19\" height=\"19\" border=\"0\" style=\"position:absolute;cursor:pointer;top:7px;right:12px;\" onclick=\"document.getElementById('div_mobile_price_info').style.display='none';\"/>";
		varMoblieLayer += "<div style=\"width:340px;height:55px;border-bottom:3px solid #626261\"><div style='font-size:16pt;font-weight:bold;position:relative;top:15px;left:20px;'>";

		if (vcode == 4027){
			varMoblieLayer += "옥션";
		}else if(vcode == 75){
			varMoblieLayer += "GS SHOP";
		}else if(vcode == 536){
			varMoblieLayer += "G마켓";
		}else if(vcode == 5910){
			varMoblieLayer += "11번가";
		}else if(vcode == 55){
			varMoblieLayer += "인터파크";
		}

		varMoblieLayer += "</div></div>";
		varMoblieLayer += "<div style=\"width:175px;height:112px;float:left;background-image:url("+var_img_enuri_com+"/images/view/detail/20111027_07.png);background-repeat:repeat-y;background-position:right top;\">";
		varMoblieLayer += "<div style=\"margin:5px 0 0 15px\"><span style=\"font-size:18px;color:#626261\">&bull;&nbsp;</span>PC 접속시 </div>";
		varMoblieLayer += "<div style=\"width:160px;margin:5px 0 0 10px;text-align:center;\"><span style=\"color:#5c5092;font-size:19px;font-weight:bold;\">"+(price+"").NumberFormat()+"</span>&nbsp;원</div>";
		varMoblieLayer += "</div>";
		varMoblieLayer += "<div style=\"width:160px;height:112px;float:left;\">";
		var sPlGoodsNm = "";
		if (document.getElementById("modelname_"+pl_no)){
			sPlGoodsNm = document.getElementById("modelname_"+pl_no).innerHTML
		}
		if((vcode==536 || vcode==4027 || vcode==5910 || sPlGoodsNm.indexOf("% 추가할인")>0) && instance_price>0){
			varMoblieLayer += "<div style=\"margin:5px 0 0 0\">&nbsp;&nbsp;<span style=\"font-size:18px;color:#626261\">&bull;&nbsp;</span>모바일 가격</div>";
			varMoblieLayer += "<div style=\"width:150px;margin:5px 0 0 10px;text-align:center;\"><span id=\"mb_price\" style=\"color:#5c5092;font-size:19px;font-weight:bold;\">"+(instance_price+"").NumberFormat()+"</span>&nbsp;원</div>";
		}else{
			varMoblieLayer += "<div style=\"margin:5px 0px 0px 8px\"><span style=\"font-size:18px;color:#626261\">&bull;&nbsp;</span>PC가격과</div>";
			varMoblieLayer += "<div style=\"margin:5px 0px 5px 15px\">다를 수 있음</div>";
		}
		varMoblieLayer += "<img src=\""+var_img_enuri_com+"/images/view/detail/20111027_04.png\" style=\"margin:5px 0px 0px 20px;cursor:pointer;\" class=\"png24\" border=\"0\" onclick=\"CmdGotoMall('"+type+"','"+cmd+"','"+vcode+"','"+modelno+"','"+price+"','"+url+"','"+cate+"','"+pl_no+"','"+imgurl+"','"+addsearch+"',"+instance_price+",'"+goodscode+"',true)\" />";
		varMoblieLayer += "</div>";
		varMoblieLayer += "</div>";
		varMoblieLayer += "<div style=\"clear:left\"><img src=\""+var_img_enuri_com+"/images/view/detail/20111027_03.png\" class=\"png24\" border=\"0\" /></div>";

		if (document.getElementById("div_mobile_price_info")){
			document.getElementById("div_mobile_price_info").innerHTML = varMoblieLayer;
			document.getElementById("div_mobile_price_info").style.left =  (Position.cumulativeOffset($("goodslistgp_td_1_"+pl_no))[0]+$("goodslistgp_td_1_"+pl_no).offsetWidth)+"px";
			document.getElementById("div_mobile_price_info").style.top = (Position.cumulativeOffset($("goodslistgp_td_1_"+pl_no))[1]+30)+"px";
			document.getElementById("div_mobile_price_info").style.display = "";
		}*/

		/*CTU*/
		var url = "/include/price_check_mobile.jsp";
		var param = "shop_code="+vcode+"&goodscode="+goodscode+"&mobile_price="+instance_price;
		var checkPrice = new Ajax.Request(
			url,
			{
				method:'get',parameters:param,onComplete:updateMobilePrice
			}
		);

		function updateMobilePrice(originalRequest){
			//document.getElementById("mb_price").innerHTML = originalRequestl.trim().NumberFormat();
		}

		setTimeout(function(){
		  CmdMobileRedirect();
		},500);

		function CmdMobileRedirect(){
			CmdGotoMall(type, cmd, vcode, modelno, price, url, cate, pl_no, imgurl, addsearch, instance_price, goodscode, true);
		}
	}
	/*
	if(varTargetPage == "/search/EnuriSearch.jsp"){
		insertUsability("P",pl_no)
	}
	*/
	return;

}
function CmdGotoMall2(type, cmd, vcode, modelno, price, url,cate,pl_no,imgurl,addsearch){
	if (document.getElementById("goods_more_list_"+modelno)){
		document.getElementById("goods_more_list_"+modelno).style.backgroundColor="#dbecf4";
	}
	var w = window.screen.width;
	var h = screen.availHeight ;
	var strMoveTargetUrl = varMoveTargetPage;
	var varTargetUrl = strMoveTargetUrl+"?type="+type+"&cmd="+cmd+"&vcode="+vcode+"&modelno="+modelno+"&price="+price+"&pl_no="+pl_no+"&imgurl="+imgurl+"&ads="+addsearch;
	var k = window.open("/_pre_detail_.jsp", "_blank");
	k.location.href = varTargetUrl;
	k.focus();
}
function showMoreGoods(modelno,multimodelno){
	if (document.getElementById("more_view_"+modelno).src.indexOf("/2012/list/btn_lessen.gif") >= 0 ){
		var viewObjs = $("goods_more_list_"+modelno).getElementsBySelector('tr[class="hide"]');
		for (i=0;i<viewObjs.length;i++){
			viewObjs[i].style.display = "none";
		}
		if (document.getElementById("goods_more_list_td1_"+multimodelno)){
			document.getElementById("goods_more_list_td1_"+multimodelno).style.borderBottom = "";
		}
		if (document.getElementById("goods_more_list_td2_"+multimodelno)){
			document.getElementById("goods_more_list_td2_"+multimodelno).style.borderBottom = "";
		}
		if (document.getElementById("goods_more_list_td3_"+multimodelno)){
			document.getElementById("goods_more_list_td3_"+multimodelno).style.borderBottom = "";
		}
		if (document.getElementById("goods_more_list_tdchk_"+multimodelno)){
			document.getElementById("goods_more_list_tdchk_"+multimodelno).style.borderBottom = "";
		}
		document.getElementById("more_view_"+modelno).src = var_img_enuri_com + "/2012/list/btn_more.gif";
		hidePricelistLayer(varPlsno);
	}else{
		/*
		var varShop4Vis = false;
		if($("goods_more_list_"+modelno).getElementsBySelector('span[class="p_shop_price"]')[0].visible()){
			varShop4Vis = true;
		}
		*/
		var hideObjs = $("goods_more_list_"+modelno).getElementsBySelector('tr[class="hide"]');
		var varHideModelNos = "";
		for (i=0;i<hideObjs.length;i++){
			hideObjs[i].style.display = "";
			/*
			if (varShop4Vis){
				if (varHideModelNos.trim().length > 0){
					varHideModelNos += ",";
				}
				var varHIdeModelNo = $(hideObjs[i]).getElementsBySelector('td')[0].id
				varHideModelNos +=  varHIdeModelNo.substring(20,varHIdeModelNo.length);
			}
			*/
		}
		document.getElementById("more_view_"+modelno).src = var_img_enuri_com + "/2012/list/btn_lessen.gif";
		if (document.getElementById("goods_more_list_td1_"+multimodelno)){
			document.getElementById("goods_more_list_td1_"+multimodelno).style.borderBottom = "1px dotted #909090";
		}
		if (document.getElementById("goods_more_list_td2_"+multimodelno)){
			document.getElementById("goods_more_list_td2_"+multimodelno).style.borderBottom = "1px dotted #909090";
		}
		if (document.getElementById("goods_more_list_td3_"+multimodelno)){
			document.getElementById("goods_more_list_td3_"+multimodelno).style.borderBottom = "1px dotted #909090";
		}
		if (document.getElementById("goods_more_list_tdchk_"+multimodelno)){
			document.getElementById("goods_more_list_tdchk_"+multimodelno).style.borderBottom = "1px dotted #909090";
		}
		/*
		if (varShop4Vis){
			var url = "/include/ajax/AjaxGetSession.jsp";
			var param = "sname=Shop4Price";
			var getShop4Price = new Ajax.Request(
				url,
				{
					method:'get',parameters:param,onComplete:function(originalRequest){
						showShop4PriceEachModel(varHideModelNos,originalRequest.responseText.trim());
					}
				}
			);

		}
		*/
	}
	parent.syncHeightListFrame();
}
/*
function showLayerAddFac(){
	if (document.getElementById("lay_addfac").style.display != "none"){
		document.getElementById("lay_addfac").style.display = "none";
	}else{
		document.getElementById("lay_addfac").style.top = Position.cumulativeOffset($("btn_add_fac"))[1]+"px";
		document.getElementById("lay_addfac").style.display = "";
	}
}
*/
function showSimg(sImg,modelno,modelno_group){
	var posLeftTop = Position.cumulativeOffset($("goods_more_list_td1_"+modelno));
	var varLeft = posLeftTop[0] - 105;
	var varTop = posLeftTop[1];

	var varGmlHeight = document.getElementById("td_gml_"+modelno_group).offsetHeight + Position.cumulativeOffset($("td_gml_"+modelno_group))[1];

	if (BrowserDetect.browser == "Explorer"){
		varTop = varTop + getListFrameTopPos();
		varGmlHeight = varGmlHeight + getListFrameTopPos();
	}else{
		varTop = varTop + getListFrameTopPos()-1;
		varGmlHeight = varGmlHeight + getListFrameTopPos()-1;
	}

	if ((varTop + 105 )> varGmlHeight){
		varTop = varGmlHeight - 105;
	}
	top.document.getElementById("simg_layer").innerHTML = "<img src=\""+sImg+"\" width=\"100\" height=\"100\" border=0 />";
	top.document.getElementById("simg_layer").style.left=varLeft+"px";
	top.document.getElementById("simg_layer").style.top=varTop+"px";
	top.document.getElementById("simg_layer").style.display = "";

}
function hideSimg(modelno){
	top.document.getElementById("simg_layer").style.display = "none";
}
function showImage(modelno) {
	var bigbigImage = window.open("/view/enuriupload/Show_ImagePopup.jsp?modelno="+modelno+"&goodsBbsOpenType=1&sopnShowFlag=false&imgname=1","bigbigImage","width="+window.screen.width+",height="+screen.availHeight+",top=0,left=0,toolbar=no,location=no,directories=no,status=no,scrollbars=no,resizable=yes,menubar=no,personalbar=no");
	bigbigImage.focus();
}
function getPopularList(modelno,imgurl) {
	insertLog(6531);
	if (typeof(getPopularList._modelno) != "undefined"){
		if (getPopularList._modelno == modelno ){
			if (top.document.getElementById("popularListDiv").style.display != "none"){
				top.document.getElementById("popularListDiv").style.display = "none";
				return;
			}
		}
	}
	top.document.getElementById("popularListDiv").style.display = "none";
  	var newDate = new Date();
	qrName = newDate.getTime();
	var posLeftTop;
	var posTop = 0;
	if (document.getElementById("view").value == "1p"){
		var posLeftTop = Position.cumulativeOffset($("goodslist1_td_1_"+modelno));
		posTop = (posLeftTop[1]+getListFrameTopPos());
	}else if (document.getElementById("view").value == "2p"){
		var posLeftTop = Position.cumulativeOffset($("goodslist2_td_1_"+modelno));
		posTop = (posLeftTop[1]+getListFrameTopPos());
	}else if(document.getElementById("view").value == "gp"){
		var posLeftTop = Position.cumulativeOffset($("order_"+modelno));
		posTop = (posLeftTop[1]+getListFrameTopPos())+20;
	}else if(document.getElementById("view").value == "img"){
		var posLeftTop = Position.cumulativeOffset($("goods_image_list_dl_"+modelno));
		posTop = (posLeftTop[1]+getListFrameTopPos());
	}


	top.document.getElementById("popularListDiv").style.left = posLeftTop[0]+"px";
	top.document.getElementById("popularListDiv").style.top = posTop+"px";
	if (imgurl == "http://img.enuri.gscdn.com/2012/search/19_100.gif"){
		imgurl = "http://img.enuri.info/2012/list/19_3.gif";
	}
	var url_i = "/view/include/modelPopularList.jsp";
	var param_i = "sModelNo="+modelno+"&strImageUrl="+imgurl;
	param_i += "&t=" + qrName;


	var getPopularAjax = new Ajax.Request (
		url_i, {
			method:'get', parameters:param_i, onComplete:showPopularAjaxd
		}
	);
	getPopularList._modelno = modelno;
}
function showPopularAjaxd(originalRequest) {
	hideAllLayer();
	top.document.getElementById("popularListDiv").innerHTML = originalRequest.responseText;
	top.document.getElementById("popularListDiv").style.display = "";
}
function getSmartPoint(cate,modelno,imgurl){
	if (typeof(getPopularList._modelno) != "undefined"){
		if (getPopularList._modelno == modelno ){
			if (top.document.getElementById("smartDiv").style.display != "none"){
				top.document.getElementById("smartDiv").style.display = "none";
				return;
			}
		}
	}

	top.document.getElementById("smartDiv").style.display = "none";
  	var newDate = new Date();
	qrName = newDate.getTime();
	var posLeftTop;
	var posTop = 0;
	if (document.getElementById("view").value == "1p"){
		var posLeftTop = Position.cumulativeOffset($("goodslist1_td_1_"+modelno));
		posTop = (posLeftTop[1]+getListFrameTopPos());
	}else if (document.getElementById("view").value == "2p"){
		var posLeftTop = Position.cumulativeOffset($("goodslist2_td_1_"+modelno));
		posTop = (posLeftTop[1]+getListFrameTopPos());
	}else if(document.getElementById("view").value == "gp"){
		var posLeftTop = Position.cumulativeOffset($("smart_"+modelno));
		posTop = (posLeftTop[1]+getListFrameTopPos())+20;
	}else if(document.getElementById("view").value == "img"){
		var posLeftTop = Position.cumulativeOffset($("goods_image_list_dl_"+modelno));
		posTop = (posLeftTop[1]+getListFrameTopPos());
	}


	top.document.getElementById("smartDiv").style.left = posLeftTop[0]+"px";
	top.document.getElementById("smartDiv").style.top = posTop+"px";

	var url_i = "/view/Smart_Point.jsp";
	var param_i = "cate="+cate+"&modelno="+modelno+"&strImageUrl="+imgurl;
	param_i += "&t=" + qrName;


	var getSmartAjax = new Ajax.Request (
		url_i, {
			method:'get', parameters:param_i, onComplete:showSmartAjax
		}
	);
	getSmartPoint._modelno = modelno;
}
function showSmartAjax(originalRequest) {
	hideAllLayer();
	top.document.getElementById("smartDiv").innerHTML = originalRequest.responseText;
	top.document.getElementById("smartDiv").style.display = "";
}
function getCountBrandPage(page,prevPage){

	function callBackGetCountInResult(originalRequest){
		eval("varCount = " + originalRequest.responseText);
		if (varCount.count == "-1"){
			top.hideLoadingBar();
			alert("죄송합니다.\r\n\r\n현재 검색서버의 장애로 검색이 되지 않고 있습니다.\r\n\r\n불편하시더라도 메뉴를 이용하여 주시기 바랍니다.\r\n\r\n조속히 정상화 되도록 최선을 다하겠습니다.	");
		}else if (varCount.count == "0"){
			alert("현재 조건의 다음 페이지 상품이 없습니다.")
			document.frmList.page.value=prevPage;
		}else{
			document.frmList.page_enuri.value=page-1;
			document.frmList.brand_add_search.value="Y";
			document.frmList.submit();
		}
	}

	tabValueCheck();
	var url = "";
	var param = "";
	url = "/search/GetCountListMp3.jsp";
	param = "cate="+document.getElementById("cate").value;
	if(document.getElementById("factory")){
		document.frmList.factory.value = "";
	}
	if (document.getElementById("shop_code")){
		param = param + "&shop_code="+document.getElementById("shop_code").value;
	}
	param = param + "&m_price="+document.getElementById("m_price").value;
	param = param + "&keyword="+convertSpecialKeyword(document.frmList.keyword.value).replace("&","%26");
	if (document.getElementById("gb1")){
		param = param + "&gb1="+document.getElementById("gb1").value;
	}
	if (document.getElementById("gb2")){
		param = param + "&gb2="+document.getElementById("gb2").value;
	}
	if (document.getElementById("brand_add_search")){
		param = param + "&brand_add_search=Y";
	}
	var getCount = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:callBackGetCountInResult
		}
	);
	return false;
}
function getCountSocialPage(page,prevPage){
	function callBackGetCountInResult(originalRequest){
		eval("varCount = " + originalRequest.responseText);
		if (varCount.count == "-1"){
			top.hideLoadingBar();
			alert("죄송합니다.\r\n\r\n현재 검색서버의 장애로 검색이 되지 않고 있습니다.\r\n\r\n불편하시더라도 메뉴를 이용하여 주시기 바랍니다.\r\n\r\n조속히 정상화 되도록 최선을 다하겠습니다.	");
		}else if (varCount.count == "0"){
			alert("현재 조건의 다음 페이지 상품이 없습니다.")
			document.frmList.page.value=prevPage;
		}else{
			document.frmList.page_enuri.value=page-1;
			document.frmList.brand_add_search.value="Y";
			document.frmList.submit();
		}
	}

	tabValueCheck();
	var url = "";
	var param = "";
	url = "/search/GetCountListSocial.jsp";
	param = "cate="+document.getElementById("cate").value;
	if(document.getElementById("factory")){
		document.frmList.factory.value = "";
	}
	if (document.getElementById("shop_code")){
		param = param + "&shop_code="+document.getElementById("shop_code").value;
	}
	param = param + "&m_price="+document.getElementById("m_price").value;
	param = param + "&keyword="+convertSpecialKeyword(document.frmList.keyword.value).replace("&","%26");
	if (document.getElementById("gb1")){
		param = param + "&gb1="+document.getElementById("gb1").value;
	}
	if (document.getElementById("gb2")){
		param = param + "&gb2="+document.getElementById("gb2").value;
	}
	if (document.getElementById("brand_add_search")){
		param = param + "&brand_add_search=Y";
	}
	var getCount = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:callBackGetCountInResult
		}
	);
	return false;
}
function getCountAddCatePage(){

	function callBackGetCountInResult(originalRequest){
		eval("varCount = " + originalRequest.responseText);
		if (varCount.count == "-1"){
			top.hideLoadingBar();
			alert("죄송합니다.\r\n\r\n현재 검색서버의 장애로 검색이 되지 않고 있습니다.\r\n\r\n불편하시더라도 메뉴를 이용하여 주시기 바랍니다.\r\n\r\n조속히 정상화 되도록 최선을 다하겠습니다.	");
			return;
		}else if (varCount.count == "0"){
			alert("해당 조건의 이전 페이지 상품이 없어, 전체 가격대 상품이 나옵니다.")
			document.getElementById("m_price").value = "";
		}
		if (document.getElementById("brand_add_search")){
			document.frmList.brand_add_search.value="";
		}
		if (document.getElementById("page_enuri")){
			document.frmList.page_enuri.value="";
		}
		if (document.getElementById("cate_add_tab_search")){
			document.getElementById("cate_add_tab_search").value = "";
		}
		document.frmList.page.value = "1";
		document.frmList.submit();
	}

	tabValueCheck();
	var url = "";
	var param = "";
	url = "/search/GetCountListMp3.jsp";
	param = "cate="+document.getElementById("cate").value;
	if (document.getElementById("shop_code")){
		document.getElementById("shop_code").value = "";
	}
	param = param + "&m_price="+document.getElementById("m_price").value;
	param = param + "&keyword="+convertSpecialKeyword(document.frmList.keyword.value).replace("&","%26");

	var getCount = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:callBackGetCountInResult
		}
	);
	return false;
}
function hideAccNotice7(){
	fnSetCookie2010("_hd_v_"+varCate.substring(0,4),"Y",7);
	document.getElementById("div_acc_notice").style.display="none";
}
/*
function viewShop4(){
	var varLeft = (Position.cumulativeOffset($("li_sel_shop"))[0])+"px";
	var varTop = (Position.cumulativeOffset($("li_sel_shop"))[1]+23)+"px";
	$("li_sel_shop").style.height = "23px";

	if (document.getElementById("ul_sel_shoplist")){
		if (document.getElementById("ul_sel_shoplist").style.display != "none"){
			document.getElementById("ul_sel_shoplist").style.display = "none";
			document.getElementById("img_sel_shop_down").src = var_img_enuri_com+"/2012/list/newdown.gif";
			if (getVisibleTabLayer()){
				$("li_sel_shop").style.backgroundImage= "url("+var_img_enuri_com+"/2012/list/tab_shop2_s_0604.gif)"
				$("li_sel_shop").style.height = "20px";
			}else{
				$("li_sel_shop").style.backgroundImage= "url("+var_img_enuri_com+"/2012/list/tab_shop2_0604.gif)"
			}
			return;
		}else{
			document.getElementById("ul_sel_shoplist").style.left = varLeft;
			document.getElementById("ul_sel_shoplist").style.top = varTop;
			document.getElementById("ul_sel_shoplist").style.display = "";
			document.getElementById("img_sel_shop_down").src = var_img_enuri_com+"/2012/list/btn_x.gif";
			document.getElementById("li_sel_shop").style.backgroundImage= "url("+var_img_enuri_com+"/2012/list/tab_shop_open2_0413.gif)"
		}
	}else{
		var varLayerHtml = "<li class=\"blk\"></li>";
		varLayerHtml += "<li id=\"li_sel_shop_check_\" onclick=\"showShopPrice('')\">";
		if (document.getElementById("key").value.indexOf("sale") >= 0 ){
			varLayerHtml += "판매량";
		}else{
			varLayerHtml += "업체수";
		}
		varLayerHtml += " <img id=\"img_sel_shop_check_\" src=\""+var_img_enuri_com+"/images/blank.gif\" width=\"7px\" height=\"7px\" border=\"0\" /></li>";
		varLayerHtml += "<li id=\"li_sel_shop_check_all\" onclick=\"showShopPrice('all')\">최저가 쇼핑몰 <img src=\""+var_img_enuri_com+"/images/blank.gif\" width=\"7px\" height=\"7px\" border=\"0\" id=\"img_sel_shop_check_all\"/></li>";
		varLayerHtml += "<li class=\"blk2\"></li>";
		varLayerHtml += "<li id=\"li_sel_shop_check_536\" onclick=\"showShopPrice('536')\">G마켓 <img src=\""+var_img_enuri_com+"/images/blank.gif\" width=\"7px\" height=\"7px\" border=\"0\" id=\"img_sel_shop_check_536\"/></li>";
		varLayerHtml += "<li id=\"li_sel_shop_check_4027\" onclick=\"showShopPrice('4027')\">옥션 <img src=\""+var_img_enuri_com+"/images/blank.gif\" width=\"7px\" height=\"7px\" border=\"0\" id=\"img_sel_shop_check_4027\"/></li>";
		varLayerHtml += "<li id=\"li_sel_shop_check_5910\" onclick=\"showShopPrice('5910')\">11번가 <img src=\""+var_img_enuri_com+"/images/blank.gif\" width=\"7px\" height=\"7px\" border=\"0\" id=\"img_sel_shop_check_5910\"/></li>";
		varLayerHtml += "<li id=\"li_sel_shop_check_55\" onclick=\"showShopPrice('55')\">인터파크 <img src=\""+var_img_enuri_com+"/images/blank.gif\" width=\"7px\" height=\"7px\" border=\"0\" id=\"img_sel_shop_check_55\"/></li>";
		varLayerHtml += "<li style=\"margin:0px;background-image:url("+var_img_enuri_com+"/2012/list/tab_shop_layer04_2_0424.gif);width:95px;height:3px;\"><!-- --></li>";
		var varLayerObj = document.createElement("UL");
		varLayerObj.id = "ul_sel_shoplist";
		varLayerObj.style.left = varLeft;
		varLayerObj.style.top = varTop;

		varLayerObj.innerHTML = varLayerHtml
		document.getElementById("wrap").insertBefore(varLayerObj,null);
		document.getElementById("img_sel_shop_down").src = var_img_enuri_com+"/2012/list/btn_x_0424.gif";
		document.getElementById("li_sel_shop").style.backgroundImage= "url("+var_img_enuri_com+"/2012/list/tab_shop_open2_0413.gif)"
		var url = "/include/ajax/AjaxGetSession.jsp";
		var param = "sname=Shop4Price";
		var getShop4Price = new Ajax.Request(
			url,
			{
				method:'get',parameters:param,onComplete:function(originalRequest){
					var varSelectedShopCode = originalRequest.responseText.trim();
					if (varSelectedShopCode == ""){
						var varLoc = document.location.href;
						if (varLoc.indexOf("bshopcode") >= 0){
							varSelectedShopCode = varLoc.substring(varLoc.indexOf("bshopcode")+10,varLoc.length);
							if (varSelectedShopCode.indexOf("&") > 0){
								varSelectedShopCode = varSelectedShopCode.substring(0,varSelectedShopCode.indexOf("&"));
							}
						}
					}
					if (varSelectedShopCode != "all"){
						$("img_sel_shop_check_"+varSelectedShopCode).src = var_img_enuri_com + "/2012/list/icon_cir_blue_0424.gif"
						$("li_sel_shop_check_"+varSelectedShopCode).style.color="#0064a3";
					}
					if (!(varSelectedShopCode == "536" || varSelectedShopCode == "4027" || varSelectedShopCode == "5910" || varSelectedShopCode == "55" || varSelectedShopCode == "all" || varSelectedShopCode == "")){
						var liShopHideObj = $("ul_sel_shoplist").getElementsBySelector('li[class="shop_hide"]');
						liShopHideObj.each(function(k,v){
							$(k).className = "shop_visible";
						});
						//$("moreshop").innerHTML = "기타 쇼핑몰 ▲";
						$("ul_sel_shoplist").style.height = "350px";
					}
				}
			}
		);
	}
	insertLog(7325);
}
function setPositionShop4Layer(){
	if (document.getElementById("ul_sel_shoplist")){
		if (document.getElementById("ul_sel_shoplist").style.display != "none"){
			var varLeft = (Position.cumulativeOffset($("li_sel_shop"))[0])+"px";
			var varTop = (Position.cumulativeOffset($("li_sel_shop"))[1]+23)+"px";
			document.getElementById("ul_sel_shoplist").style.left = varLeft;
			document.getElementById("ul_sel_shoplist").style.top = varTop;
		}
	}
}
function showShopPrice(shopcode){
	if (document.getElementById("ul_sel_shoplist")){
		var varShopCheckImg = $("ul_sel_shoplist").getElementsBySelector('img');
		varShopCheckImg.each(function(k,v){
			if ($(k).src == (var_img_enuri_com + "/2012/list/icon_cir_blue_0424.gif")){
				$(k).src = var_img_enuri_com + "/images/blank.gif";
			}
		});
		var varShopCheckImg = $("ul_sel_shoplist").getElementsBySelector('li');
		varShopCheckImg.each(function(k,v){
			$(k).style.color="#000000";
		});
	}

	var tdLcn = $("goodslist").getElementsBySelector('td[class="top5 td_lcn"]');
	//var tdGml = $("goodslist").getElementsBySelector('td[class="right1 td_gml"]');
	var tdGml2 = $("goodslist").getElementsBySelector('td[class="td_gml2"]');
	var tdGml3 = $("goodslist").getElementsBySelector('td[class="td_gml3"]');
	var divMallCnt = $("goodslist").getElementsBySelector('div[class="div_mall_cnt"]');
	var divSaleCnt = $("goodslist").getElementsBySelector('div[class="div_sale_cnt"]');
	var divShopTitle = $("goodslist").getElementsBySelector('div[class="div_shop_title"]');

	var varShopTitle = "";
	varShopTitle = getShopName(shopcode,"");
	if (shopcode == "536"){
		insertLog(7326);
	}else if(shopcode == "4027"){
		insertLog(7327);
	}else if(shopcode == "5910"){
		insertLog(7328);
	}else if(shopcode == "55"){
		insertLog(7329);
	}else if(shopcode == "all"){
		insertLog(7364);
	}

	var varVisModelNos = "";
	var varTdGml2W = 25;
	var varTdGml3W = 30;
	var varTdGml3Align = "center";
	if (document.getElementById("key").value.indexOf("sale") >= 0 ){
		varTdGml2W = 15;
		varTdGml3W = 20;
		varTdGml3Align = "right";
	}
	if (shopcode != ""){
		if (document.getElementById("ul_sel_shoplist")){
			document.getElementById("img_sel_shop_check_"+shopcode).src = var_img_enuri_com + "/2012/list/icon_cir_blue_0424.gif";
			document.getElementById("li_sel_shop_check_"+shopcode).style.color="#0064a3";
		}
		var varShopPriceDefault = false;
		tdLcn.each(function(k,v){
			if (v == 0){
				if (typeof(showShopPrice.o_tdLcn_w) == "undefined"){
					var varCntObj = null;
					if ($(k).getElementsBySelector('div[class="div_mall_cnt"]')[0]){
						varCntObj = $(k).getElementsBySelector('div[class="div_mall_cnt"]')[0];
					}else if($(k).getElementsBySelector('div[class="div_sale_cnt"]')[0]){
						varCntObj = $(k).getElementsBySelector('div[class="div_sale_cnt"]')[0];
					}
					if(!varCntObj.visible()){
						showShopPrice.o_tdLcn_w = parseInt(k.width)-5;
						varShopPriceDefault = true;
					}else{
						showShopPrice.o_tdLcn_w = k.width;
					}
				}
			}
			k.width = (parseInt(showShopPrice.o_tdLcn_w) + varTdGml3W)+"px";
		});
		tdGml3.each(function(k,v){
			if (v == 0){
				if (typeof(showShopPrice.o_tdGml3_w) == "undefined"){
					if (varShopPriceDefault){
						showShopPrice.o_tdGml3_w = parseInt(k.width)-varTdGml3W;
					}else{
						showShopPrice.o_tdGml3_w = k.width;
					}
				}
			}
			k.width = (parseInt(showShopPrice.o_tdGml3_w) + varTdGml3W)+"px";
			k.align = "right";

			$(k).getElementsBySelector('span[class="p_mallcnt"]')[0].style.display = "none";
			$(k).getElementsBySelector('span[class="p_shop_price"]')[0].style.display = "none";
			$(k).getElementsBySelector('span[class="p_shop_price"]')[0].innerHTML = "없음";
			$(k).getElementsBySelector('span[class="p_shop_price"]')[0].style.color = "#646464";
			$(k).getElementsBySelector('span[class="p_shop_price"]')[0].style.cursor="default";
			$(k).getElementsBySelector('span[class="p_shop_price"]')[0].title="";
			$(k).getElementsBySelector('span[class="p_shop_price"]')[0].style.letterSpacing="normal";
			$(k).getElementsBySelector('span[class="p_shop_price"]')[0].onclick = function(){

			}
			if ($(k.parentNode).visible()){
				varVisModelNos += k.id.substring(20,k.id.length) + ",";
			}
		});
		divMallCnt.each(function(k,v){
			k.style.display = "none";
		});
		divSaleCnt.each(function(k,v){
			k.style.display = "none";
		});
		divShopTitle.each(function(k,v){
			k.innerHTML = varShopTitle;
			k.style.display = "";
		});
		showShop4PriceEachModel(varVisModelNos,shopcode);
		url = "/include/ajax/AjaxSetSession.jsp";
		param = "sname=Shop4Price&svalue="+shopcode;
		var setSession = new Ajax.Request(
			url,
			{
				method:'get',parameters:param
			}
		);
	}else{
		var varShopPriceDefault = false;
		if (typeof(showShopPrice.o_tdLcn_w) == "undefined"){
			var varCntObj = null;
			var varTdLcn0Obj = $("goodslist").getElementsBySelector('td[class="top5 td_lcn"]')[0];
			if ($(varTdLcn0Obj).getElementsBySelector('div[class="div_mall_cnt"]')[0]){
				varCntObj = $(varTdLcn0Obj).getElementsBySelector('div[class="div_mall_cnt"]')[0];
			}else if($(varTdLcn0Obj).getElementsBySelector('div[class="div_sale_cnt"]')[0]){
				varCntObj = $(varTdLcn0Obj).getElementsBySelector('div[class="div_sale_cnt"]')[0];
			}
			if(varCntObj.visible()){
				varShopPriceDefault = true;
			}
		}
		if (varShopPriceDefault){
			if (document.getElementById("ul_sel_shoplist")){
				viewShop4();
			}
			return;
		}

		tdLcn.each(function(k,v){
			if (typeof(showShopPrice.o_tdLcn_w) != "undefined"){
				k.width = showShopPrice.o_tdLcn_w+"px";
			}else{
				k.width = (parseInt(k.width)-5)+"px";
			}
		});
		tdGml3.each(function(k,v){
			if (typeof(showShopPrice.o_tdGml_w) != "undefined"){
				k.width = showShopPrice.o_tdGml3_w+"px";
			}else{
				k.width = (parseInt(k.width)-varTdGml3W)+"px";
			}
			k.align = varTdGml3Align;
			$(k).getElementsBySelector('span[class="p_mallcnt"]')[0].style.display = "";
			$(k).getElementsBySelector('span[class="p_shop_price"]')[0].style.display = "none";
		});
		divMallCnt.each(function(k,v){
			k.style.display = "";
		});
		divSaleCnt.each(function(k,v){
			k.style.display = "";
		});
		divShopTitle.each(function(k,v){
			k.style.display = "none";
		});
		url = "/include/ajax/AjaxSetSession.jsp";
		param = "sname=Shop4Price&svalue=";
		var setSession = new Ajax.Request(
			url,
			{
				method:'get',parameters:param
			}
		);
		$("img_sel_shop_check_").src = var_img_enuri_com + "/2012/list/icon_cir_blue_0424.gif"
		$("li_sel_shop_check_").style.color="#0064a3";
		insertLog(7330);
	}
	if (shopcode == "536" || shopcode == "4027" || shopcode == "5910" || shopcode == "55" || shopcode == "" || shopcode == "all"){
		var liShopHideObj = $("ul_sel_shoplist").getElementsBySelector('li[class="shop_visible"]');
		liShopHideObj.each(function(k,v){
			$(k).className = "shop_hide";
		});
		//$("moreshop").innerHTML = "기타 쇼핑몰  ▼";
		$("ul_sel_shoplist").style.height = "120px";
	}
	if (document.getElementById("ul_sel_shoplist")){
		viewShop4();
	}
}
function CmdGotoMallShop4(event){
	insertLog(7331);
	var varModelNoId = Event.element(event).id;
	var modelno = varModelNoId.substring(13,varModelNoId.length);
	$("p_shop_price_"+modelno).style.backgroundColor="#e7e7e7";
	var vcode = $("p_shop_code_"+modelno).innerHTML;
	var varMoveTargetPage = "/move/Redirect.jsp";
	var w = window.screen.width;
	var h = screen.availHeight ;
	var varTargetUrl = varMoveTargetPage+"?cmd=move_link&vcode="+vcode+"&modelno="+modelno+"&shop4=y";
	k = window.open (varTargetUrl,"_blank");
	k.focus();
	return;
}
function showShop4PriceEachModel(varVisModelNos,shopcode){

	if (document.getElementById("img_show4_loading")){
		var varfObj = $("goodslist").getElementsBySelector('tr')[1];
		document.getElementById("img_show4_loading").style.top = (Position.cumulativeOffset($(varfObj))[1]+ $(varfObj).offsetHeight - 52)+"px"
		document.getElementById("img_show4_loading").style.left = (top.document.getElementById("wrap").offsetWidth-300)+"px"
		document.getElementById("img_show4_loading").style.display = "";
	}else{
		var varShop4Loading = document.createElement("IMG");
		varShop4Loading.id = "img_show4_loading";
		varShop4Loading.src = var_img_enuri_com+"/2012/search/tab_loading.gif";
		varShop4Loading.style.position = "absolute";
		var varfObj = $("goodslist").getElementsBySelector('tr')[1];
		varShop4Loading.style.top = (Position.cumulativeOffset($(varfObj))[1]+ $(varfObj).offsetHeight - 52)+"px"
		varShop4Loading.style.left = (top.document.getElementById("wrap").offsetWidth-300)+"px"
		varShop4Loading.style.zIndex=100;
		document.getElementById("wrap").insertBefore(varShop4Loading,null);
	}

	var url = "/include/ajax/AjaxGetShop4Price.jsp";
	var param = "modelnos="+varVisModelNos+"&shopcode="+shopcode;
	var getShop4Price = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:setShop4Price
		}
	);
	function setShop4Price(originalRequest){
		var varReturnData = originalRequest.responseText;
		var varShop4Price = eval('(' + varReturnData + ')' );

		for (var i=0;i<varShop4Price.shop4Price.length;i++){
			var varModelNo = varShop4Price.shop4Price[i].modelno;
			var varPrice = varShop4Price.shop4Price[i].price;
			var varShopTitle = "";
			var varShopTitle1 = "";
			var varShopTitle2 = "";
			var varShopShopCode = "";
			if (shopcode != "all"){
				varShopShopCode = shopcode;
				varShopTitle = getShopName(shopcode,"");
				varShopTitle1 = getShopName(shopcode,"1");
				varShopTitle2 = getShopName(shopcode,"2");
			}else{
				varShopShopCode = varShop4Price.shop4Price[i].shopcode;
				varShopTitle = varShop4Price.shop4Price[i].shoptitle;
				varShopTitle1 = varShop4Price.shop4Price[i].shoptitle+"(으)로";
				varShopTitle2 = varShop4Price.shop4Price[i].shoptitle+"이(가)";
			}
			$("p_shop_price_"+varModelNo).innerHTML = varPrice;
			$("p_shop_code_"+varModelNo).innerHTML = varShopShopCode;
			$("p_shop_price_"+varModelNo).style.cursor="pointer";
			$("p_shop_price_"+varModelNo).onclick = function(event){
				if(!event) var event = window.event;
				CmdGotoMallShop4(event);
			}
			if ($("goods_more_list_td2_"+varModelNo).getElementsBySelector('span').length > 0){
				if ($("goods_more_list_td2_"+varModelNo).getElementsBySelector('span')[0].innerHTML.trim() >= varPrice){
					$("p_shop_price_"+varModelNo).title="클릭시 최저가 쇼핑몰인 "+varShopTitle1+" 이동";
					if (shopcode != "all"){
						$("p_shop_price_"+varModelNo).style.color = "#c7423d";
						$("p_shop_price_"+varModelNo).innerHTML = "<img src=\""+var_img_enuri_com+"/2012/list/arr_left_red.gif\" width=\"6px\" height=\"5px\" border=\"0\" /> 최저가";
					}else{
						$("p_shop_price_"+varModelNo).style.color = "#444444";
						if (!varShopTitle.split(" ").join("").isalpha() && varShopTitle.length > 4 && varShopTitle != "현대Hmall"){
							if (varShopTitle.length > 5){
								varShopTitle = varShopTitle.substring(0,5);
							}
							$("p_shop_price_"+varModelNo).innerHTML = varShopTitle;
						}else{
							if ((varShopTitle.split(" ").join("").isalpha() && varShopTitle.length >= 7) || varShopTitle == "현대Hmall"){
								$("p_shop_price_"+varModelNo).innerHTML = varShopTitle.substring(0,7);
							}else{
								$("p_shop_price_"+varModelNo).innerHTML = "<img src=\""+var_img_enuri_com+"/2012/list/arr_left.gif\" width=\"6px\" height=\"5px\" border=\"0\" style=\"margin-left:3px\" />"+varShopTitle;
							}
						}
						$("p_shop_price_"+varModelNo).style.letterSpacing="-1px";
					}
				}else{
					var varMinPriceTmp = parseInt($("goods_more_list_td2_"+varModelNo).getElementsBySelector('span')[0].innerHTML.trim().DeNumberFormat());
					var varThisPriceTmp = parseInt(varPrice.DeNumberFormat());
					$("p_shop_price_"+varModelNo).title="최저가보다 "+varShopTitle2+" " + ((varThisPriceTmp - varMinPriceTmp)+"").NumberFormat() +" 원 더 비쌉니다. 클릭시 "+varShopTitle1+" 이동!";
				}
			}else{
				$("p_shop_price_"+varModelNo).innerHTML = "";
			}
		}

		var tdGml3 = $("goodslist").getElementsBySelector('td[class="td_gml3"]');

		tdGml3.each(function(k,v){
			if (shopcode != "all"){
				$(k).align="right"
			}else{
				$(k).align="left"
			}
			$(k).getElementsBySelector('span[class="p_shop_price"]')[0].style.backgroundColor = "transparent";
			$(k).getElementsBySelector('span[class="p_shop_price"]')[0].style.display = "";
		});
		document.getElementById("img_show4_loading").style.display = "none";
	}
}
function moreShopPrice(){
	var liShopHideObj = $("ul_sel_shoplist").getElementsBySelector('li[class="shop_hide"]');
	if (liShopHideObj.length > 0){
		liShopHideObj.each(function(k,v){
			$(k).className = "shop_visible";
		});
		//$("moreshop").innerHTML = "기타 쇼핑몰  ▲";
		$("ul_sel_shoplist").style.height = "350px";
		insertLog(7365);
	}else{
		liShopHideObj = $("ul_sel_shoplist").getElementsBySelector('li[class="shop_visible"]');
		liShopHideObj.each(function(k,v){
			$(k).className = "shop_hide";
		});
		//$("moreshop").innerHTML = "기타 쇼핑몰  ▼";
		$("ul_sel_shoplist").style.height = "120px";
	}

}
function getShopName(shopcode,endtype){
	var varShopTitle = "";
	if (shopcode == "536"){
		varShopTitle = "G마켓";
		if (endtype == "1"){
			varShopTitle +="으로"
		}else if(endtype == "2"){
			varShopTitle +="이"
		}
	}else if(shopcode == "4027"){
		varShopTitle = "옥션";
		if (endtype == "1"){
			varShopTitle +="으로"
		}else if(endtype == "2"){
			varShopTitle +="이"
		}
	}else if(shopcode == "5910"){
		varShopTitle = "11번가";
		if (endtype == "1"){
			varShopTitle +="로"
		}else if(endtype == "2"){
			varShopTitle +="가"
		}
	}else if(shopcode == "55"){
		varShopTitle = "인터파크";
		if (endtype == "1"){
			varShopTitle +="로"
		}else if(endtype == "2"){
			varShopTitle +="가";
		}
	}else if(shopcode == "all"){
		varShopTitle = "최저가 쇼핑몰";
	}else if(shopcode == "90"){
		varShopTitle = "AKmall";
		if (endtype == "1"){
			varShopTitle +="로"
		}else if(endtype == "2"){
			varShopTitle +="가"
		}
	}else if(shopcode == "806"){
		varShopTitle = "CJmall";
		if (endtype == "1"){
			varShopTitle +="로"
		}else if(endtype == "2"){
			varShopTitle +="이"
		}
	}else if(shopcode == "75"){
		varShopTitle = "GS SHOP";
		if (endtype == "1"){
			varShopTitle +="으로"
		}else if(endtype == "2"){
			varShopTitle +="이"
		}
	}else if(shopcode == "974"){
		varShopTitle = "nsmall";
		if (endtype == "1"){
			varShopTitle +="로"
		}else if(endtype == "2"){
			varShopTitle +="이"
		}
	}else if(shopcode == "1878"){
		varShopTitle = "디앤샵";
		if (endtype == "1"){
			varShopTitle +="으로"
		}else if(endtype == "2"){
			varShopTitle +="이"
		}
	}else if(shopcode == "49"){
		varShopTitle = "롯데닷컴";
		if (endtype == "1"){
			varShopTitle +="으로"
		}else if(endtype == "2"){
			varShopTitle +="이"
		}
	}else if(shopcode == "663"){
		varShopTitle = "롯데i몰";
		if (endtype == "1"){
			varShopTitle +="으로"
		}else if(endtype == "2"){
			varShopTitle +="이"
		}
	}else if(shopcode == "47"){
		varShopTitle = "신세계몰";
		if (endtype == "1"){
			varShopTitle +="로"
		}else if(endtype == "2"){
			varShopTitle +="이"
		}
	}else if(shopcode == "374"){
		varShopTitle = "이마트몰";
		if (endtype == "1"){
			varShopTitle +="로"
		}else if(endtype == "2"){
			varShopTitle +="이"
		}
	}else if(shopcode == "57"){
		varShopTitle = "현대Hmall";
		if (endtype == "1"){
			varShopTitle +="로"
		}else if(endtype == "2"){
			varShopTitle +="이"
		}
	}else if(shopcode == "6361"){
		varShopTitle = "홈플러스";
		if (endtype == "1"){
			varShopTitle +="로"
		}else if(endtype == "2"){
			varShopTitle +="가";
		}
	}
	return varShopTitle;
}
*/
function openAdultCheckWin(e){
	if(!e) var e = window.event;
	e.cancelBubble = true;
	e.returnValue = false;
	if (e.stopPropagation) {
		e.stopPropagation();
		e.preventDefault();
	}
	insertLog(7623);
	OpenWindowDetail('/login/Adult_Check.jsp?func=pageReload','adultcheck','430','260','no','no','yes','no','no','100','100');
}
function pageReload(){
	location.reload();
	top.getGuide_Resent_Zzim(2,1);
}
function setSpecInit(){
	/*
	if (document.getElementById("sel_spec")){
		document.getElementById("sel_spec").value="";
	}
	if (document.getElementById("spec")){
		document.getElementById("spec").value="";
	}
	if (document.getElementById("sc")){
		document.getElementById("sc").value="no";
	}
	if  (document.getElementById("keyword")){
		document.getElementById("keyword").value = "";
	}
	document.frmList.submit();
	*/
	if (parent.document.getElementById('comment_layer')){
		parent.document.getElementById('comment_layer').style.display='none';
	}
	if (parent.document.getElementById('comment_layer_over')){
		parent.document.getElementById('comment_layer_over').style.display='none';
	}

	var varSpecCate = "";
	if (document.getElementById("cate").value.length > 4 && document.getElementById("cate").value.indexOf("040207") < 0 &&  document.getElementById("cate").value.indexOf("03052201") < 0  &&  document.getElementById("cate").value.indexOf("03052202") < 0){
		varSpecCate = document.getElementById("cate").value.substring(0,4);
	}else{
		varSpecCate = document.getElementById("cate").value;
	}
	if (varTargetPage == "/view/Listbody_Smart.jsp" || varTargetPage == "/view/Listbody_Printer.jsp"){
		varTargetPage = "/view/Listbody_Mp3.jsp";
	}
	location.href = varTargetPage + "?cate="+varSpecCate;
}

function setBestInit(shop_code){
	if (parent.document.getElementById('comment_layer')){
		parent.document.getElementById('comment_layer').style.display='none';
	}
	if (parent.document.getElementById('comment_layer_over')){
		parent.document.getElementById('comment_layer_over').style.display='none';
	}

	var varSpecCate = "";
	/*if (document.getElementById("cate").value.length > 4 && document.getElementById("cate").value.indexOf("040207") < 0 &&  document.getElementById("cate").value.indexOf("03052201") < 0  &&  document.getElementById("cate").value.indexOf("03052202") < 0){
		varSpecCate = document.getElementById("cate").value.substring(0,4);
	}else{*/
		varSpecCate = document.getElementById("cate").value;
	//}

	location.href = "/view/Listbody_Fs_ShopBest.jsp?cate="+varSpecCate+"&fs_shop_code="+shop_code;
}
function showSimpleView(modelno,popular,cate,vtype){
	if (varTargetPage == "/view/Listbody_Social.jsp" || varTargetPage == "/include/IncEcouponList.jsp"){
		var varDetailViewUrl ="/view/Detailmulti.jsp?modelno="+modelno+"&cate="+cate+"&fb=1&porder="+popular;
		detailMultiView(varDetailViewUrl,"detailmulti_"+modelno,modelno);
		return;
	}
	top.changeRecentZzim(2);
	top.showSimpleView(modelno,popular,cate,vtype);
	top.hideRecentZzim();
	if (typeof(showSimpleView.modelno) != "undefined"){
		clearTimerSvModel();
	}
	if (typeof(showSimpleView.pulse) == "undefined"){
		showSimpleView.pulse = true;
	}

	showSimpleView.timerSelectedSvModel = setInterval(function(){
		if (showSimpleView.pulse){
			if (document.getElementById("view").value == "gp"){
				if (document.getElementById("goods_more_list_td0_"+showSimpleView.modelno)){
					document.getElementById("goods_more_list_td0_"+showSimpleView.modelno).style.backgroundColor = "#DBECF4";
				}
				document.getElementById("goods_more_list_td1_"+showSimpleView.modelno).style.backgroundColor = "#DBECF4";
				document.getElementById("goods_more_list_td2_"+showSimpleView.modelno).style.backgroundColor = "#DBECF4";
				document.getElementById("goods_more_list_td3_"+showSimpleView.modelno).style.backgroundColor = "#DBECF4";
				document.getElementById("goods_more_list_tdchk_"+showSimpleView.modelno).style.backgroundColor = "#DBECF4";
			}else if(document.getElementById("view").value == "img"){
				if (document.getElementById("goods_image_list_dl_"+modelno)){
					document.getElementById("goods_image_list_dl_"+modelno).style.backgroundColor="#ffe1e1";
					document.getElementById("goods_image_list_dd1_"+modelno).style.backgroundColor="#ffe1e1";
					document.getElementById("goods_image_list_dd2_"+modelno).style.backgroundColor="#ffe1e1";
				}
			}
			showSimpleView.pulse = false;
		}else{
			if (document.getElementById("view").value == "gp"){
				if (document.getElementById("goods_more_list_td0_"+showSimpleView.modelno)){
					document.getElementById("goods_more_list_td0_"+showSimpleView.modelno).style.backgroundColor = "#C7DBED";
				}
				document.getElementById("goods_more_list_td1_"+showSimpleView.modelno).style.backgroundColor = "#C7DBED";
				document.getElementById("goods_more_list_td2_"+showSimpleView.modelno).style.backgroundColor = "#C7DBED";
				document.getElementById("goods_more_list_td3_"+showSimpleView.modelno).style.backgroundColor = "#C7DBED";
				document.getElementById("goods_more_list_tdchk_"+showSimpleView.modelno).style.backgroundColor = "#C7DBED";
			}else if(document.getElementById("view").value == "img"){
				if (document.getElementById("goods_image_list_dl_"+modelno)){
					document.getElementById("goods_image_list_dl_"+modelno).style.backgroundColor="#d8e6f5";
					document.getElementById("goods_image_list_dd1_"+modelno).style.backgroundColor="#d8e6f5";
					document.getElementById("goods_image_list_dd2_"+modelno).style.backgroundColor="#d8e6f5";
				}
			}
			showSimpleView.pulse = true;
		}

	},1000)
	showSimpleView.modelno = modelno;
	if (top.document.getElementById('div_catekeyword_layer')){
		top.document.getElementById('div_catekeyword_layer').style.display="none";
	}
	if (top.document.getElementById('div_map_detail_info')){
		top.document.getElementById('div_map_detail_info').style.display="none";
	}
	/*
	if(varTargetPage == "/search/EnuriSearch.jsp"){
		var abTest = new Abtest("search_ab_001");
		abTest.update();
	}
	if(varTargetPage == "/search/EnuriSearch.jsp"){
		insertUsability("M",modelno);
	}
	*/
	hideAllLayer();
}
function clearTimerSvModel(){
	clearTimeout(showSimpleView.timerSelectedSvModel);
	if (document.getElementById("view").value == "gp"){
		if (document.getElementById("goods_more_list_td0_"+showSimpleView.modelno)){
			document.getElementById("goods_more_list_td0_"+showSimpleView.modelno).style.backgroundColor = "#DBECF4";
		}
		document.getElementById("goods_more_list_td1_"+showSimpleView.modelno).style.backgroundColor = "#DBECF4";
		document.getElementById("goods_more_list_td2_"+showSimpleView.modelno).style.backgroundColor = "#DBECF4";
		document.getElementById("goods_more_list_td3_"+showSimpleView.modelno).style.backgroundColor = "#DBECF4";
		document.getElementById("goods_more_list_tdchk_"+showSimpleView.modelno).style.backgroundColor = "#DBECF4";
	}else{
		if (document.getElementById("goods_image_list_dl_"+showSimpleView.modelno)){
			document.getElementById("goods_image_list_dl_"+showSimpleView.modelno).style.backgroundColor="#d8e6f5";
			document.getElementById("goods_image_list_dd1_"+showSimpleView.modelno).style.backgroundColor="#d8e6f5";
			document.getElementById("goods_image_list_dd2_"+showSimpleView.modelno).style.backgroundColor="#d8e6f5";
		}
	}
	showSimpleView.pulse = true;
}
function showBtmFunc(modelno,imgchk,popular_modelno,bigModelno){
	if (imgchk == "4" || imgchk == "8" || imgchk == "9" || imgchk == "5" ){
		return
	}
	var varLeft = Position.cumulativeOffset($("modelImg_"+modelno))[0];
	if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 8){
		if(navigator.userAgent.toLowerCase().indexOf('trident/5.0')>-1) {
			varLeft = varLeft -1;
		}
	}
	var varTop = (Position.cumulativeOffset($("modelImg_"+modelno))[1] + 85);
	var varZoomImg = "";
	var varZoomAlt = "";
	var varZoomImgClick = "dbwin("+popular_modelno+","+imgchk+")";
	if (typeof(bigModelno) == "undefined"){
		varZoomImg = "btn_bg_01.png";
	}else{
		varZoomImg = "btn_bg_01_ov.png";
		varZoomAlt = "title='더큰사진'";
	}

	if (document.getElementById("div_small_bottom_img")){
		var varfObj = $("goodslist").getElementsBySelector('tr')[1];
		document.getElementById("div_small_bottom_img").style.top = varTop+"px"
		document.getElementById("div_small_bottom_img").style.left = varLeft+"px"
		document.getElementById("div_small_bottom_img").innerHTML = "<img src='" +var_img_enuri_com + "/2012/list/"+varZoomImg+"' "+varZoomAlt+" style='cursor:pointer;' onclick='"+varZoomImgClick+"'/><img src='" +var_img_enuri_com + "/2012/list/btn_bg_02.png'  style='cursor:pointer;' onclick='dwin("+modelno+")'/>";
		document.getElementById("div_small_bottom_img").style.display = "";
	}else{
		var varSmallBtmImg = document.createElement("DIV");
		varSmallBtmImg.id = "div_small_bottom_img";
		varSmallBtmImg.style.width="102px";
		varSmallBtmImg.style.height="15px";
		varSmallBtmImg.style.position = "absolute";
		varSmallBtmImg.style.top = varTop+"px";
		varSmallBtmImg.style.left = varLeft+"px";

		varSmallBtmImg.onmouseout = function(){
			showBtmFunc._view = false;
			hideBtmFunc();
		}
		varSmallBtmImg.onmouseover = function(){
			showBtmFunc._view = true;
		}
		varSmallBtmImg.innerHTML = "<img src='" +var_img_enuri_com + "/2012/list/"+varZoomImg+"'  style='cursor:pointer;' onclick='"+varZoomImgClick+"' "+varZoomAlt+" /><img src='" +var_img_enuri_com + "/2012/list/btn_bg_02.png'  style='cursor:pointer;' onclick='dwin("+modelno+")'/>";
		document.getElementById("wrap").insertBefore(varSmallBtmImg,null);
	}
	showBtmFunc._view = true;
}
function hideBtmFunc(){
	showBtmFunc._view = false;
	setTimeout(function(){
		var varHide = false;
		if (typeof(showBtmFunc._view) == "undefined"){
			varHide = true;
		}else if(!showBtmFunc._view){
			varHide = true;
		}
		if (varHide){
			if (document.getElementById("div_small_bottom_img")){
				document.getElementById("div_small_bottom_img").style.display = "none";
			}
		}
	},500);
}
function dwin(modelno){
	insertLog(8742);
	if (document.getElementById("modelImg_"+modelno)){
		fireEvent(document.getElementById("modelImg_"+modelno),"click");
	}
}
function dbwin(modelno,imgchk){
	insertLog(8740);
	/*
	if (imgchk == 4 || imgchk == 8 || imgchk == 9){
		if (document.getElementById("modelImg_"+modelno)){
			var varClickFunc = document.getElementById("modelImg_"+modelno).onclick.toString();
			varClickFunc = varClickFunc.substring(varClickFunc.indexOf("'")+1,varClickFunc.length);
			varClickFunc = varClickFunc.substring(0,varClickFunc.indexOf("'")) + "&bigImgShowType=1";
			top.detailMultiView(varClickFunc,"detailmulti_"+modelno,modelno);
		}
	}else{
		top.detailMultiView("/view/include/BigImageOnlyPopup.jsp?modelno="+modelno,"detailmulti_"+modelno,modelno);
	}
	*/
	top.detailMultiView("/view/include/BigImageOnlyPopup.jsp?modelno="+modelno,"detailmulti_"+modelno,modelno);
}

function getIsOpenFactoryTab(cate){
	if (cate.length > 4 ){
		cate = cate.substring(0,4);
	}
	var varFactoryCate = "0208,0212,0215,0217,0357,0220,0318,0408,0503,2405,2402,0508,0510,0514,0515,2404,0527,0606,0607,0608,0611,0704,0709,0710,0711,0801,0802,0803,0804,0805,0806,0807,0809,0810,0812,0813,0814,0826,0901,0903,0904,0906,0907,0908,0909,0911,0912,0913,0918,0919,0920,0921,0923,0924,0928,0929,0930,1001,1003,1004,1009,1010,1011,1012,1013,1015,1022,1023,1024,1201,1202,1203,1204,1205,1207,1208,1648,1213,1215,1219,1451,1452,1454,1455,1456,1457,1459,1482,1483,1484,1485,1501,1502,1503,1504,1505,1506,1507,1508,1510,1511,1513,1602,1603,1605,1227,1609,1611,1612,1225,1614,1621,1623,1625,1626,1629,1226,1632,1634,1635,1636,1228,1801,1802,1642,1643,1644,1645,1647,0364,2103,2104,2105,2108,2109,0362,2114,2115,0363,2120,2122,0931,0932,1030,1822,0238,0422,0423,0240,2211,2212,2213,2221,2222,2226,2227,2241,2242";
	var varReturn = true;
	if (varFactoryCate.indexOf(cate) >=0 ){
		varReturn = false;
	}
	return varReturn;
}

function showLocLCate(dlname,cate){
	if (document.getElementById("nowLoc_M_Layer").style.display != "none"){
		showLocMCate();
	}
	if (document.getElementById("nowLoc_S_Layer").style.display != "none"){
		showLocSCate();
	}
	if (typeof(dlname) == "undefined" && (typeof(showLocLCate._f_dlname) == "undefined" || showLocLCate._f_dlname == "")){
		showLocLCate._f_dlname = document.getElementById("lm_lname").getElementsByTagName("DIV")[0].innerHTML;
	}else if (typeof(dlname) == "undefined" && showLocLCate._f_dlname != ""){
		dlname = showLocLCate._f_dlname;
		showLocLCate._f_dlname = "";
	}
	if (typeof(dlname) != "undefined"){
		showLocLCate._f_dlname = "";
	}
	if (document.getElementById("nowLoc_L_Layer").style.display != "none"){
		document.getElementById("nowLoc_L_Layer").style.display = "none";
		document.getElementById("lcate_dn").src = var_img_enuri_com+"/2012/list/linemap2013/now_combo_dn.gif";
		document.getElementById("lm_lname").getElementsByTagName("DIV")[0].innerHTML = dlname;
	}else{
		document.getElementById("nowLoc_L_Layer").style.left = (Position.cumulativeOffset($("lm_lname"))[0]-4)+"px";
		document.getElementById("nowLoc_L_Layer").style.top = (Position.cumulativeOffset($("lm_lname"))[1]+17)+"px";
		document.getElementById("nowLoc_L_Layer").style.display = "";
		document.getElementById("lcate_dn").src = var_img_enuri_com+"/2012/list/linemap2013/now_combo_x.gif";
		document.getElementById("lm_lname").getElementsByTagName("DIV")[0].innerHTML = "선택하세요";
	}
	if (typeof(cate) != "undefined"){
		setNowLocMLayer._cate = "";
		document.getElementById("nowLoc_M_Layer").style.display = "none";
		var url = "/mobile2/include/m4_getcategory.jsp";
		var param = "ca_code="+cate+"&from=list";
		var getMCate = new Ajax.Request(
			url,
			{
				method:'get',parameters:param,onComplete:setNowLocMLayer
			}
		);
	}
	if (typeof(dlname) != "undefined" && typeof(cate) != "undefined"){
		var varLCateLi = $("nowLoc_L_Layer").getElementsBySelector("li");
		for (var i=0;i<varLCateLi.length;i++){
			if (varLCateLi[i].id == ("nll_cate_"+cate)){
				varLCateLi[i].style.backgroundImage= "url("+var_img_enuri_com+"/2012/list/linemap2013/icon_arr_b.gif)";
				varLCateLi[i].style.color="#00589A";
			}else{
				varLCateLi[i].style.backgroundImage= "url("+var_img_enuri_com+"/2012/list/linemap2013/bullet.gif)";
				varLCateLi[i].style.color="#242424";
			}
		}
	}

}
function setNowLocMLayer(originalRequest){
	document.getElementById("nowLoc_M_Layer").innerHTML = "<div style=\"background-image:url("+var_img_enuri_com+"/2012/list/linemap2013/now_combo_02_open01.gif);width:148px;height:5px;\"><!--  --></div><div id='nowLoc_M_Layer_In'>"+originalRequest.responseText.replace(/<br>/g,"").replace(/clear:both;/g,"clear:both;display:none;").replace(/■/g,"") + "</div><div style=\"background-image:url("+var_img_enuri_com+"/2012/list/linemap2013/now_combo_02_open03.gif);width:148px;height:9px;\"><!--  --></div>";
	setTimeout(function(){
		document.getElementById("nowLoc_M_Layer").getElementsByTagName("UL")[0].style.display="none";
		if (setNowLocMLayer._cate == ""){
			if (document.getElementById("lm_mname")){
				document.getElementById("lm_mname").getElementsByTagName("DIV")[0].innerHTML = "선택하세요";
			}
		}
		var varMCateDiv = $("nowLoc_M_Layer_In").getElementsBySelector("div");
		if (varMCateDiv.length > 24 ){
			$("nowLoc_M_Layer").getElementsBySelector("ul[class='cate_layer_ul']")[0].style.height = "228px";
		}else{
			$("nowLoc_M_Layer").getElementsBySelector("ul[class='cate_layer_ul']")[0].style.height = "100%";
		}

		for (var i=0;i<varMCateDiv.length;i++){
			if (varMCateDiv[i].visible()){
				varMCateDiv[i].onmouseover = function(){
					if (typeof(this.getElementsByTagName("SPAN")[1]) != "undefined"){
						this.getElementsByTagName("SPAN")[1].getElementsByTagName("SPAN")[0].style.color="#c70b09";
					}
				}
				varMCateDiv[i].onmouseout = function(){
					if (typeof(this.getElementsByTagName("SPAN")[1]) != "undefined"){
						if (this.getElementsByTagName("SPAN")[1].id == ("cate_"+varCate.substring(0,4)) ){
							this.getElementsByTagName("SPAN")[1].getElementsByTagName("SPAN")[0].style.color="#00589A";
						}else{
							this.getElementsByTagName("SPAN")[1].getElementsByTagName("SPAN")[0].style.color="#242424";
						}
					}
				}
				if (varMCateDiv[i].getElementsByTagName("SPAN").length > 1 ){
					var varClickFunc = new String(varMCateDiv[i].getElementsByTagName("SPAN")[1].onclick);

					var varClickCate = "";
					if (typeof(varClickFunc[36]) != "undefined"){
						if (BrowserDetect.browser == "Chrome" &&  navigator.userAgent.toLowerCase().indexOf("edge") < 0 ){
							varClickCate = varClickFunc[36] + varClickFunc[37] + varClickFunc[38] + varClickFunc[39] + varClickFunc[40] + varClickFunc[41] + varClickFunc[42];
						}else{
							varClickCate = varClickFunc[34] + varClickFunc[35] + varClickFunc[36] + varClickFunc[37] + varClickFunc[38] + varClickFunc[39] + varClickFunc[40];
						}
					}else{
						varClickCate = varClickFunc.substring(varClickFunc.indexOf("'")+1,varClickFunc.length);
					}
					varClickCate = varClickCate.substring(0,varClickCate.indexOf("'"));

					if (varCate.substring(0,4) == varClickCate ){
						varMCateDiv[i].getElementsByTagName("SPAN")[1].getElementsByTagName("SPAN")[0].style.color="#00589A";
						varMCateDiv[i].style.backgroundImage= "url("+var_img_enuri_com+"/2012/list/linemap2013/icon_arr_b.gif)";
						if (document.getElementById("lm_mname")){
							document.getElementById("lm_mname").getElementsByTagName("DIV")[0].innerHTML = varMCateDiv[i].getElementsByTagName("SPAN")[1].getElementsByTagName("SPAN")[0].innerHTML;
						}
					}

				}
			}
		}
		if (document.getElementById("lm_mname")){
			if (document.getElementById("lm_mname").getElementsByTagName("DIV")[0].innerHTML.trim().length == 0){
				document.getElementById("lm_mname").getElementsByTagName("DIV")[0].innerHTML = setNowLocMLayer._defaultName;
			}
		}

		if (!setNowLocMLayer._init){
			showLocMCate();
		}
		setNowLocMLayer._init = false;
	},1000);
}
function showLocMCate(dmname){
	if (document.getElementById("nowLoc_L_Layer").style.display != "none"){
		showLocLCate();
	}
	if (document.getElementById("nowLoc_S_Layer").style.display != "none"){
		showLocSCate();
	}
	if (typeof(dmname) == "undefined" && (typeof(showLocMCate._f_dmname) == "undefined" || showLocMCate._f_dmname == "")){
		if (document.getElementById("lm_mname")){
			showLocMCate._f_dmname = document.getElementById("lm_mname").getElementsByTagName("DIV")[0].innerHTML;
		}
	}else if (typeof(dmname) == "undefined" && showLocMCate._f_dmname != ""){
		dmname = showLocMCate._f_dmname;
		showLocMCate._f_dmname = "";
	}
	if (typeof(dmname) != "undefined"){
		showLocMCate._f_dmname = "";
	}
	if (document.getElementById("nowLoc_M_Layer").style.display != "none"){
		document.getElementById("nowLoc_M_Layer").style.display = "none";
		document.getElementById("mcate_dn").src = var_img_enuri_com+"/2012/list/linemap2013/now_combo_dn.gif";
		document.getElementById("lm_mname").getElementsByTagName("DIV")[0].innerHTML = dmname;
	}else{
		document.getElementById("nowLoc_M_Layer").style.left = (Position.cumulativeOffset($("lm_mname"))[0]-4)+"px";
		document.getElementById("nowLoc_M_Layer").style.top = (Position.cumulativeOffset($("lm_mname"))[1]+17)+"px";
		document.getElementById("nowLoc_M_Layer").style.display = "";
		document.getElementById("mcate_dn").src = var_img_enuri_com+"/2012/list/linemap2013/now_combo_x.gif";
		document.getElementById("lm_mname").getElementsByTagName("DIV")[0].innerHTML = "선택하세요";
	}


}
function CmdMainCate(cate){
	top.location.href = "Listmp3.jsp?cate="+cate;
}
function showLocSCate(dsname){
	if (document.getElementById("nowLoc_L_Layer").style.display != "none"){
		showLocLCate();
	}
	if (document.getElementById("nowLoc_M_Layer").style.display != "none"){
		showLocMCate();
	}
	if (typeof(dsname) == "undefined" && (typeof(showLocSCate._f_dsname) == "undefined" || showLocSCate._f_dsname == "")){
		showLocSCate._f_dsname = document.getElementById("lm_sname").getElementsByTagName("DIV")[0].innerHTML;
	}else if (typeof(dsname) == "undefined" && showLocSCate._f_dsname != ""){
		dsname = showLocSCate._f_dsname;
		showLocSCate._f_dsname = "";
	}
	if (typeof(dsname) != "undefined"){
		showLocSCate._f_dsname = "";
	}
	if (document.getElementById("nowLoc_S_Layer").style.display != "none"){
		document.getElementById("nowLoc_S_Layer").style.display = "none";
		document.getElementById("scate_dn").src = var_img_enuri_com+"/2012/list/linemap2013/now_combo_dn.gif";
		document.getElementById("lm_sname").getElementsByTagName("DIV")[0].innerHTML = dsname;
	}else{
		document.getElementById("nowLoc_S_Layer").style.left = (Position.cumulativeOffset($("lm_sname"))[0]-4)+"px";
		document.getElementById("nowLoc_S_Layer").style.top = (Position.cumulativeOffset($("lm_sname"))[1]+17)+"px";
		document.getElementById("nowLoc_S_Layer").style.display = "";
		document.getElementById("scate_dn").src = var_img_enuri_com+"/2012/list/linemap2013/now_combo_x.gif";
		document.getElementById("lm_sname").getElementsByTagName("DIV")[0].innerHTML = "선택하세요";
	}
}
function outLocLCate(lcateObj){

	if (lcateObj.style.backgroundImage.indexOf("icon_arr_b.gif") >= 0){
		lcateObj.style.color = "#00589A";
	}else{
		lcateObj.style.color = "#242424";
	}
}
function goList(linkCate,orgCate){
	if (varTargetPage == "/view/Listbody_Social.jsp" ){
		top.location.href = "/view/Listmp3.jsp?cate="+linkCate;
		return;
	}
	if (linkCate == "1206" || linkCate == "2112" || linkCate == "0811"){
		top.location.href = "/view/Listbrand.jsp?cate=" + linkCate
	}else if(linkCate == "092109" || linkCate == "900305"){
		top.location.href = "/tour2012/Tour_Index.jsp";
	}else if(linkCate == "092118"){
		top.location.href = "/view/Tour_Tourjockey.jsp";
	}else if(linkCate == "122810"){
		top.location.href = "/view/Flower365.jsp";
	}else if(linkCate == "1458"){
		top.location.href = "/view/fusion/Fusion.jsp?cate=1458&brand2no=&ganada=&brandcate=";
	}else{
		if (linkCate.length < 6 ){
			top.location.href = "/view/Listmp3.jsp?cate="+linkCate;
		}else{
			if (varCate.substring(0,4) != linkCate.substring(0,4)){
				top.location.href = "/view/Listmp3.jsp?cate="+linkCate;
			}else{
				parent.location.href = parent.location.pathname + "?cate="+linkCate;
			}
		}
	}
}
function setNowLocSLayer(originalRequest){
	document.getElementById("nowLoc_S_Layer").innerHTML = "<div style=\"background-image:url("+var_img_enuri_com+"/2012/list/linemap2013/now_combo_02_open01.gif);width:148px;height:5px;\"><!--  --></div><div id='nowLoc_S_Layer_In'>"+originalRequest.responseText.replace(/<br>/g,"").replace(/<BR>/g,"").replace(/clear:both;/g,"clear:both;display:none;").replace(/■/g,"").replace(/●/g,"</span><p style='width:3px;background-color:#f8f8f8;float:left;'>&nbsp;</p>") + "</div><div style=\"background-image:url("+var_img_enuri_com+"/2012/list/linemap2013/now_combo_02_open03.gif);width:148px;height:9px;\"><!--  --></div>";
	setTimeout(function(){
		document.getElementById("nowLoc_S_Layer").getElementsByTagName("UL")[0].style.display="none";
		if (setNowLocSLayer._cate.length < 6){
			document.getElementById("lm_sname").getElementsByTagName("DIV")[0].innerHTML = "선택하세요";
		}
		var varSCateDiv = $("nowLoc_S_Layer_In").getElementsBySelector("div");
		if (varSCateDiv.length > 28 ){
			$("nowLoc_S_Layer_In").getElementsBySelector("ul[class='cate_layer_ul']")[0].style.height = "228px";
		}else{
			$("nowLoc_S_Layer_In").getElementsBySelector("ul[class='cate_layer_ul']")[0].style.height = "100%";
		}
		if (document.getElementById("cate_091224")){
			$("cate_091224").parentNode.style.display = "none";
		}

		//현재위치 카테고리 선택 비활성화_101447
		if (document.getElementById("cate_101447")){
			$("cate_101447").onclick = function(){}
			$("cate_101447").parentNode.onmouseover = function(){}
		}

		for (var i=0;i<varSCateDiv.length;i++){
			if (varSCateDiv[i].visible()){
				var ScateDivOver = function(){
					if (typeof(this.getElementsByTagName("SPAN")[1]) != "undefined"){
						if (this.getElementsByTagName("SPAN")[1].id == ("cate_"+varCate.substring(0,6)) ){
							this.getElementsByTagName("SPAN")[1].getElementsByTagName("SPAN")[0].style.color="#c70b09";
						}else{
							this.getElementsByTagName("SPAN")[1].className = this.getElementsByTagName("SPAN")[1].className.replace(/_off/g, "_on");
						}
					}
				}
				var ScateDivOut = function(){
					if (typeof(this.getElementsByTagName("SPAN")[1]) != "undefined"){
						if (this.getElementsByTagName("SPAN")[1].id == ("cate_"+varCate.substring(0,6)) ){
							this.getElementsByTagName("SPAN")[1].getElementsByTagName("SPAN")[0].style.color="#00589a";
						}else{
							this.getElementsByTagName("SPAN")[1].className = this.getElementsByTagName("SPAN")[1].className.replace(/_on/g, "_off");
						}
					}
				}
				varSCateDiv[i].onmouseover = ScateDivOver;
				varSCateDiv[i].onmouseout = ScateDivOut;
				/*
				varSCateDiv[i].onmouseover = function(){
					if (typeof(this.getElementsByTagName("SPAN")[1]) != "undefined"){
						if (this.getElementsByTagName("SPAN")[1].id == ("cate_"+varCate.substring(0,6)) ){
							this.getElementsByTagName("SPAN")[1].getElementsByTagName("SPAN")[0].style.color="#c70b09";
						}else{
							this.getElementsByTagName("SPAN")[1].className = this.getElementsByTagName("SPAN")[1].className.replace(/_off/g, "_on");
						}
					}
				}
				varSCateDiv[i].onmouseout = function(){
					if (typeof(this.getElementsByTagName("SPAN")[1]) != "undefined"){
						if (this.getElementsByTagName("SPAN")[1].id == ("cate_"+varCate.substring(0,6)) ){
							this.getElementsByTagName("SPAN")[1].getElementsByTagName("SPAN")[0].style.color="#00589a";
						}else{
							this.getElementsByTagName("SPAN")[1].className = this.getElementsByTagName("SPAN")[1].className.replace(/_on/g, "_off");
						}
					}
				}
				*/
				if (varSCateDiv[i].getElementsByTagName("SPAN").length > 1 ){
					var varClickFunc = new String(varSCateDiv[i].getElementsByTagName("SPAN")[1].onclick);
					var varClickCate = "";
					if (typeof(varClickFunc[36]) != "undefined"){
						if (BrowserDetect.browser == "Chrome" &&  navigator.userAgent.toLowerCase().indexOf("edge") < 0 ){
							varClickCate = varClickFunc[36] + varClickFunc[37] + varClickFunc[38] + varClickFunc[39] + varClickFunc[40] + varClickFunc[41] + varClickFunc[42];
						//}else if (BrowserDetect.browser == "Explorer" && ( BrowserDetect.version == 9 || BrowserDetect.version == 10)){
						}else{
							varClickCate = varClickFunc[34] + varClickFunc[35] + varClickFunc[36] + varClickFunc[37] + varClickFunc[38] + varClickFunc[39] + varClickFunc[40];
						}
					}else{
						varClickCate = varClickFunc.substring(varClickFunc.indexOf("'")+1,varClickFunc.length);
					}

					if (varClickCate.indexOf("'") > 0 ){
						varClickCate = varClickCate.substring(0,varClickCate.indexOf("'"));
					}
					if (varCate.substring(0,6) == varClickCate.substring(0,6) ){
						varSCateDiv[i].getElementsByTagName("SPAN")[1].getElementsByTagName("SPAN")[0].style.color="#00589A";
						varSCateDiv[i].getElementsByTagName("SPAN")[1].style.backgroundRepeat = "no-repeat";
						varSCateDiv[i].getElementsByTagName("SPAN")[1].style.backgroundPosition = "left 6px";
						varSCateDiv[i].getElementsByTagName("SPAN")[1].style.backgroundImage= "url("+var_img_enuri_com+"/2012/list/linemap2013/icon_arr_b.gif)";
						//varSCateDiv[i].style.backgroundImage= "url("+var_img_enuri_com+"/2012/list/linemap2013/icon_arr_b.gif)";

						document.getElementById("lm_sname").getElementsByTagName("DIV")[0].innerHTML = varSCateDiv[i].getElementsByTagName("SPAN")[1].getElementsByTagName("SPAN")[0].innerHTML;
					}
				}
			}
		}

		if (!setNowLocSLayer._init){
			showLocSCate();
		}
		setNowLocSLayer._init = false;
	},1000);
}

function showCoupon(plno,shopcode,goodsnm,goodsfactory,price,ca_code,coupon){
	var nowDate = new Date();
	var varCouponHtml = "";
	var varPriceHtml = "<div style=\"float:right;font-family:돋움;font-size:11px;color:#4b4b4b;margin-right:3px;\">쿠폰 적용가: <span style=\"font-family:Arial;font-size:9pt;color:#0066DE;font-weight:bold\">"+price+"</span><span style=\"font-family:돋움;font-size:11px;color:#000000;\">원</span></div>";
	if (shopcode == 75 || shopcode == 49 || shopcode == 90 || shopcode == 806 || shopcode == 1878 || shopcode == 6559  || shopcode == 6547 ){
		varPriceHtml = "";
	}
	if (shopcode == 6588 && nowDate.getTime() >= (new Date(2013,06,17,02,00,00)).getTime() && nowDate.getTime() <=  (new Date(2013,06,17,06,00,00)).getTime()){
		varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:65px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_"+shopcode+"_a.gif) no-repeat;\">"+varPriceHtml+"</div>";
	}else if(shopcode == 57 && nowDate.getTime() >= (new Date(2013,10,08,23,30,00)).getTime() && nowDate.getTime() <=  (new Date(2013,10,09,09,20,00)).getTime()){
		varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:65px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_"+shopcode+"_a.gif) no-repeat;\"></div>";
	}else if(shopcode==49 && goodsnm.indexOf("%추가할인")>-1 && goodsnm.indexOf("에누리")>-1){ //롯데닷컴
		varPriceHtml = "<div style=\"float:right;font-family:돋움;font-size:11px;color:#4b4b4b;margin-right:3px;\">쿠폰 적용가: <span style=\"font-family:Arial;font-size:9pt;color:#0066DE;font-weight:bold\">"+price+"</span><span style=\"font-family:돋움;font-size:11px;color:#000000;\">원</span></div>";
		varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:77px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_"+shopcode+"_double.gif) no-repeat;\">"+varPriceHtml+"</div>";
	}else if(shopcode==75 && !goodsfactory != "쇼핑지원금" && (goodsnm.indexOf("추가할인")>-1 || goodsnm.indexOf("에누리 전용")>-1) && goodsnm.indexOf("%")>-1) {
		varPriceHtml = "<div style=\"float:right;font-family:돋움;font-size:11px;color:#4b4b4b;margin-right:3px;\">쿠폰 적용가: <span style=\"font-family:Arial;font-size:9pt;color:#0066DE;font-weight:bold\">"+price+"</span><span style=\"font-family:돋움;font-size:11px;color:#000000;\">원</span></div>";
		varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:77px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_"+shopcode+"_double.gif) no-repeat;\">"+varPriceHtml+"</div>";
	}else if(shopcode==6252 && goodsnm.indexOf("%할인쿠폰적용")>-1){ //하이마트
		varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:77px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_"+shopcode+"_double.gif) no-repeat;\">"+varPriceHtml+"</div>";
	}else if(shopcode==6389 && goodsnm.indexOf("에누리")>-1 && goodsnm.indexOf("%할인쿠폰적용")>-1){ //패션플러스
		varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:65px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_"+shopcode+"_double.gif) no-repeat;\">"+varPriceHtml+"</div>";
	}else if(shopcode==6547 && goodsnm.indexOf("에누리")>-1 && goodsnm.indexOf("%")>-1 && goodsnm.indexOf("추가할인")>-1){ //롯데백화점
		//if (ca_code.substring(0,2) == "08" || ca_code.substring(0,2) == "09" || ca_code.substring(0,2) == "10" || ca_code.substring(0,2) == "14"){
			varPriceHtml = "<div style=\"float:right;font-family:돋움;font-size:11px;color:#4b4b4b;margin-right:3px;\">쿠폰 적용가: <span style=\"font-family:Arial;font-size:9pt;color:#0066DE;font-weight:bold\">"+price+"</span><span style=\"font-family:돋움;font-size:11px;color:#000000;\">원</span></div>";
			varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:77px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_"+shopcode+"_double.gif) no-repeat;\">"+varPriceHtml+"</div>";
		//}
	}else if(shopcode==47 && goodsnm.indexOf("더블할인쿠폰")>-1 && goodsnm.indexOf("에누리")>-1) {
		varPriceHtml = "<div style=\"float:right;font-family:돋움;font-size:11px;color:#4b4b4b;margin-right:3px;\">쿠폰 적용가: <span style=\"font-family:Arial;font-size:9pt;color:#0066DE;font-weight:bold\">"+price+"</span><span style=\"font-family:돋움;font-size:11px;color:#000000;\">원</span></div>";
		varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:55px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_"+shopcode+"_double_1.gif) no-repeat;\">"+varPriceHtml+"</div>";
	}else if(shopcode==6603 ){
		varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:65px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_"+shopcode+".gif) no-repeat;\"></div>";
	}else if(shopcode==6644 && goodsnm.indexOf("%할인쿠폰")>-1 && goodsnm.indexOf("에누리")>-1 ){
		varPriceHtml = "<div style=\"float:right;font-family:돋움;font-size:11px;color:#4b4b4b;margin-right:3px;\">쿠폰 적용가: <span style=\"font-family:Arial;font-size:9pt;color:#0066DE;font-weight:bold\">"+price+"</span><span style=\"font-family:돋움;font-size:11px;color:#000000;\">원</span></div>";
		varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:65px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_"+shopcode+"_double.gif) no-repeat;\">"+varPriceHtml+"</div>";
	}else if(coupon > 0 || (shopcode == 49 || shopcode == 75 || shopcode == 90 || shopcode == 806 || shopcode == 1878 || shopcode == 6559 || shopcode == 6634 || shopcode == 6547)){
		//쿠폰상품 안내 레이어
		//if (shopcode == 55 || shopcode == 974 ){
		if (shopcode == 55  ){
			varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:55px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_"+shopcode+"_1.gif) no-repeat;\">"+varPriceHtml+"</div>";
		}else if(shopcode == 57 || shopcode == 663 || shopcode == 6588 || shopcode == 6620 || shopcode == 6634){
			if (!(shopcode == 6634 && coupon == 0)){
				varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:65px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_"+shopcode+"_1.gif) no-repeat;\">"+varPriceHtml+"</div>";
			}
		}else if(shopcode == 6559 ){
			varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:77px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_"+shopcode+".gif) no-repeat;\">"+varPriceHtml+"</div>";
		}else{
			if (coupon == 1 ){
				if (shopcode == 55 || shopcode == 663 || shopcode == 6588 || shopcode == 6620 || shopcode == 57 || shopcode == 6665 || shopcode == 90 || shopcode == 75){
				//if (shopcode == 55 || shopcode == 663 || shopcode == 974 || shopcode == 6588 || shopcode == 6620 || shopcode == 57 || shopcode == 6665 || shopcode == 90 || shopcode == 75){
					varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:65px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_"+shopcode+".gif) no-repeat;\">"+varPriceHtml+"</div>";
				}else if(shopcode == 806){
					varPriceHtml = "<div style=\"float:right;font-family:돋움;font-size:11px;color:#4b4b4b;margin-right:3px;\">쿠폰 적용가: <span style=\"font-family:Arial;font-size:9pt;color:#0066DE;font-weight:bold\">"+price+"</span><span style=\"font-family:돋움;font-size:11px;color:#000000;\">원</span></div>";
					varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:65px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_"+shopcode+".gif) no-repeat;\">"+varPriceHtml+"</div>";
				}/*else if(shopcode == 90){
					//varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:65px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_"+shopcode+"_1.gif) no-repeat;\">"+varPriceHtml+"</div>";
					varPriceHtml = "<div style=\"float:right;font-family:돋움;font-size:11px;color:#4b4b4b;margin-right:3px;\">쿠폰 적용가: <span style=\"font-family:Arial;font-size:9pt;color:#0066DE;font-weight:bold\">"+price+"</span><span style=\"font-family:돋움;font-size:11px;color:#000000;\">원</span></div>";
					varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:65px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_"+shopcode+"_1.gif) no-repeat;\">"+varPriceHtml+"</div>";
				}*/
			}else{
				if (shopcode != 806){
					varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:65px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_"+shopcode+".gif) no-repeat;\">"+varPriceHtml+"</div>";
				}
			}
		}
	}
	if (shopcode == 90 || shopcode == 663){
		if(shopcode == 90){
			varPriceHtml = "<div style=\"float:right;font-family:돋움;font-size:11px;color:#4b4b4b;margin-right:3px;\">쿠폰 적용가: <span style=\"font-family:Arial;font-size:9pt;color:#0066DE;font-weight:bold\">"+price+"</span><span style=\"font-family:돋움;font-size:11px;color:#000000;\">원</span></div>";
			varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:65px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_"+shopcode+"_1.gif) no-repeat;\">"+varPriceHtml+"</div>";
		}else{
			varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:65px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_"+shopcode+"_1.gif) no-repeat;\">"+varPriceHtml+"</div>";
		}
	}

	if (shopcode == 57 && nowDate.getTime() >= (new Date(2015,02,14,02,30,00)).getTime() && nowDate.getTime() <= (new Date(2015,02,14,06,00,00)).getTime()  ){
		varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:55px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_57_a.gif) no-repeat;\">"+varPriceHtml+"</div>";
	}
	if (shopcode == 6508 && nowDate.getTime() >= (new Date(2015,11,19,08,00,00)).getTime() && nowDate.getTime() <= (new Date(2015,11,21,09,30,00)).getTime()  ){
		varPriceHtml = "";
		varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:80px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_6508_a.gif) no-repeat;\">"+varPriceHtml+"</div>";
	}
	if (shopcode == 6252 && nowDate.getTime() >= (new Date(2015,08,30,22,00,00)).getTime() && nowDate.getTime() <= (new Date(2015,09,02,14,00,00)).getTime()  ){
		varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:65px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/systemimg_6252_a.gif) no-repeat;\"></div>";
	}

	if (shopcode == 6165){	//cjon
		varCouponHtml = "<div id=\"shopReadyEvent"+shopcode+"\" style=\"width:228px;height:65px;margin:-1px 0 0 3px;background:#ffffe1 url("+var_img_enuri_com+"/images/view/systemimg/coupon_6165_1.gif) no-repeat;\"></div>";
	}

	if (varCouponHtml != ""){
		if (document.getElementById("couponLayer")){
			document.getElementById("couponLayer").style.left = (Position.cumulativeOffset($("goods_more_list_td2_"+plno))[0]-139)+"px";
			document.getElementById("couponLayer").style.top = (Position.cumulativeOffset($("goods_more_list_td2_"+plno))[1]+22)+"px";
			document.getElementById("couponLayer").innerHTML = varCouponHtml;
			document.getElementById("couponLayer").style.display = "";
		}else{
			var varLayerObj = document.createElement("DIV");
			varLayerObj.id = "couponLayer";
			varLayerObj.style.position = "absolute";
			varLayerObj.style.left = (Position.cumulativeOffset($("goods_more_list_td2_"+plno))[0]-139)+"px";
			varLayerObj.style.top = (Position.cumulativeOffset($("goods_more_list_td2_"+plno))[1]+22)+"px";
			varLayerObj.innerHTML = varCouponHtml
			document.getElementById("wrap").insertBefore(varLayerObj,null);
		}
	}
}
function hideCoupon(){
	if (document.getElementById("couponLayer")){
		document.getElementById("couponLayer").style.display = "none";
	}
}
function goSaleGoodsList(cate){
	if (cate.length >= 4){
		cate = cate.substring(0,4);
	}
	location.href = "Listbody_Mp3.jsp?cate="+cate;
}
function goReqProdBbs(){
	top.location.href = "/faq/Faq_List.jsp?faq_type=4";
}
function goCateKeywordSearch(){
	fireEvent(top.document.getElementById("cate_layer_link_img"),"click");
}
function showSearchKeywordHepLayer(){
	if (document.getElementById("img_catekeyword_help").style.display != "none"){
		document.getElementById("img_catekeyword_help").style.display = "none";
	}else{
		var varLeft = Position.cumulativeOffset($("catekeyword_help"))[0]-220;
		var varTop = Position.cumulativeOffset($("catekeyword_help"))[1]+18;
		document.getElementById("img_catekeyword_help").style.top = varTop+"px";
		document.getElementById("img_catekeyword_help").style.left = varLeft+"px";
		document.getElementById("img_catekeyword_help").style.display = "";
	}
}
function showRemoveSynonyumHelpLayer(){
	if (document.getElementById("img_removesynonyum_help").style.display != "none"){
		document.getElementById("img_removesynonyum_help").style.display = "none";
	}else{
		var varLeft = Position.cumulativeOffset($("img_remove_synonyum_keyword"))[0]-130;
		var varTop = Position.cumulativeOffset($("img_remove_synonyum_keyword"))[1]+18;
		document.getElementById("img_removesynonyum_help").style.top = varTop+"px";
		document.getElementById("img_removesynonyum_help").style.left = varLeft+"px";
		document.getElementById("img_removesynonyum_help").style.display = "";
	}

}
function isOpenFactoryTab(){
	var bFactoryTabOpen = true;
	if (document.getElementById("m_price")){
		if (document.getElementById("m_price").value.trim().length > 0){
			bFactoryTabOpen = false;
		}
	}

	if (document.getElementById("okeyword")){
		if (document.frmList.okeyword.value.trim().length > 0 ){
			bFactoryTabOpen = false;
		}
	}
	if(varTargetPage == "/search/EnuriSearch.jsp"){
		if (document.getElementById("in_o_keyword")){
			if (document.frmList.in_o_keyword.value.trim().length > 0 ){
				bFactoryTabOpen = false;
			}
		}
	}
	return bFactoryTabOpen;
}

function isOpenBrandTab(){
	var bBrandTabOpen = true;
	if (document.getElementById("m_price")){
		if (document.getElementById("m_price").value.trim().length > 0){
			bBrandTabOpen = false;
		}
	}

	if (document.getElementById("factory")){
		if (document.getElementById("factory").value.trim().length > 0){
			bBrandTabOpen = false;
		}
	}

	/*if (document.getElementById("okeyword")){
		if (document.frmList.okeyword.value.trim().length > 0 ){
			bBrandTabOpen = false;
		}
	}*/

	if(varTargetPage == "/search/EnuriSearch.jsp"){
		if (document.getElementById("in_o_keyword")){
			if (document.frmList.in_o_keyword.value.trim().length > 0 ){
				bBrandTabOpen = false;
			}
		}
	}
	return bBrandTabOpen;
}

function isOpenPriceTab(){
	var bPriceTabOpen = true;
	if (document.getElementById("okeyword")){
		if (document.frmList.okeyword.value.trim().length > 0 ){
			bPriceTabOpen = false;
		}
	}
	if(varTargetPage == "/search/EnuriSearch.jsp"){
		if (document.getElementById("in_o_keyword")){
			if (document.frmList.in_o_keyword.value.trim().length > 0 ){
				bPriceTabOpen = false;
			}
		}
	}
	return bPriceTabOpen;
}
function toggleRecKeyword(ca_code){
	if (typeof(toggleRecKeyword.isAll) == "undefined"  || toggleRecKeyword.isAll == false){
		document.getElementById("reckeyword_top_list").style.display = "none";
		document.getElementById("reckeyword_all_list").style.display = "";
		toggleRecKeyword.isAll = true;
		document.getElementById("rec_btn_more").innerHTML = "<span style=\"font-family:'맑은 고딕','돋움';font-size:11px;font-weight:bold\">닫기</span><span style=\"font-family:돋움;font-size:12px;font-weight:bold\">↑</span>";
		insertLog(10179);
		if(typeof(ca_code) != "undefined"){
			insertLogCate(10179,ca_code);
		}

	}else{
		document.getElementById("reckeyword_all_list").style.display = "none";
		document.getElementById("reckeyword_top_list").style.display = "";
		toggleRecKeyword.isAll = false;
		document.getElementById("rec_btn_more").innerHTML = "<span style=\"font-family:'맑은 고딕','돋움';font-size:11px;font-weight:bold\">더보기</span><span style=\"font-family:돋움;font-size:12px;font-weight:bold\">↓</span>";
	}
}
function showOpenShopBigImage(obj){
	if (obj.src.indexOf("working") >= 0){
		return;
	}
	var imageUrl = obj.src;
	var wsize = 600;
	if (imageUrl.indexOf("gmarket") >= 0 || imageUrl.indexOf("auction") >= 0 || imageUrl.indexOf("11st") >= 0 || imageUrl.indexOf("interpark") >= 0){
		wsize = 310;
	}
	var shopBigImgWin = window.open(imageUrl,"showBigImg","width="+wsize+",height="+wsize+",left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
	shopBigImgWin.focus();
}
function preProShowSimpleView(modelno,popular,cate,vtype){
	function getPopularModelSimpleView(originalRequest){
		showSimpleView(originalRequest.responseText.trim(),popular,cate,vtype)
	}
	var url = "/view/getPopularModelNo.jsp";
	var param = "modelno="+modelno+"&op_type=S"

	var getPopular = new Ajax.Request(
		url,
		{
			method:'get', parameters:param, onComplete:getPopularModelSimpleView
		}
	);

}
function openLayer(layerPop,e){
	var pop = document.getElementById(layerPop);
	if (pop.style.display != "none"){
		pop.style.display = "none";
	}else{
		pop.style.display = "block";
	}

	if (typeof (e) != "undefined"){
		pop.style.top= "20px";
		e.cancelBubble = true;
		e.returnValue = false;
		if (e.stopPropagation) {
			e.stopPropagation();
			e.preventDefault();
		}
	}
}
function closeLayer(layerPop,e){
	var pop = document.getElementById(layerPop);
	pop.style.display = "none";
	if (typeof (e) != "undefined"){
		e.cancelBubble = true;
		e.returnValue = false;
		if (e.stopPropagation) {
			e.stopPropagation();
			e.preventDefault();
		}
	}
}
function insertUsability(type,no){
	var url = "/search/IncUsability_Evaluation.jsp";
	var varKeyword = "";
	if  (document.getElementById("keyword")){
		varKeyword = document.getElementById("keyword").value;
	}
	var param = "";
	if (type == "M"){
		param += "modelno="+no;
	}else if(type == "P"){
		param += "pl_no="+no;
	}
	param += "&searchTerm="+varKeyword;
	var setSearchEva = new Ajax.Request(
		url,
		{
			method:'get',parameters:param
		}
	);
}