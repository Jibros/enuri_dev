var varPlsno;
var varFusionContentChk;


function cmdCloseFusionAllCate(divName){
	if(divName == "divMCateSub"){
		cmdCloseSCate();
		cmdCloseDCate();
	}
	if(divName == "divSCateSub"){
		cmdCloseMCate();
		cmdCloseDCate();
	}
	if(divName == "divDCateSub"){
		cmdCloseMCate();
		cmdCloseSCate();
	}
}
function cmdOpenMCate(){
	cmdCloseFusionAllCate("divMCateSub");
	if(document.getElementById("divMCateSub").style.display == "inline"){
		document.getElementById("divMCateSub").style.display = "none";
	}else{
		document.getElementById("divMCateSub").style.display = "inline";
	}
	insertLog('4348');
}
function cmdCloseMCate(){
	if(document.getElementById("divMCateSub")){
		document.getElementById("divMCateSub").style.display = "none";
	}
}
function cmdOpenSCate(){
	cmdCloseFusionAllCate("divSCateSub");
	if(document.getElementById("divSCateSub").style.display == "inline"){
		document.getElementById("divSCateSub").style.display = "none";
	}else{
		document.getElementById("divSCateSub").style.display = "inline";
	}
	insertLog('4349');
}
function cmdCloseSCate(){
	if(document.getElementById("divSCateSub")){
		document.getElementById("divSCateSub").style.display = "none";
	}
}
function cmdOpenDCate(){
	cmdCloseFusionAllCate("divDCateSub");
	if(document.getElementById("divDCateSub").style.display == "inline"){
		document.getElementById("divDCateSub").style.display = "none";
	}else{
		document.getElementById("divDCateSub").style.display = "inline";
	}
	insertLog('4350');
}
function cmdCloseDCate(){
	if(document.getElementById("divDCateSub")){
		document.getElementById("divDCateSub").style.display = "none";
	}
}
function cmdFusionClickLoc(ca_code){
	if(ca_code=="1005" || ca_code=="1506"){
		location.href="/view/Listmp3.jsp?cate=1005&menu=true&islist=";
	}else if(ca_code=="150709"){
		location.href="/view/fusion/Fusion.jsp?cate="+ca_code+"&brand2no=4924&brandName=%uC885%uAC00%uC9D1";
	}else if(ca_code=="145405"){
		location.href="/view/fusion/Fusion.jsp?cate="+ca_code+"&brand=%uC5D8%uCE78%uD1A0";
	}else if(ca_code=="145103"){
		location.href="/view/fusion/Fusion.jsp?cate="+ca_code+"&brand=%uC2A4%uC640%uCE58";
	}else if(ca_code=="145108"){
		location.href="/view/fusion/Fusion.jsp?cate="+ca_code+"&brand=%uD3EC%uCCB4";
	}else if(ca_code=="145104"){
		location.href="/view/fusion/Fusion.jsp?cate="+ca_code+"&brand=%uCE74%uC2DC%uC624";
	}else if(ca_code=="145507"){
		location.href="/view/fusion/Fusion.jsp?cate="+ca_code+"&brand=%uC324%uC18C%uB098%uC774%uD2B8";
	}else if(ca_code=="145212"){
		location.href="/view/fusion/Fusion.jsp?cate="+ca_code+"&brand=%uC81C%uC774%uC5D0%uC2A4%uD2F0%uB098";
	}else if(ca_code=="1459"){
		location.href="/view/fusion/Fusion_Masterpiece.jsp?cate=145901";
	}else if(ca_code=="145901"){
		location.href="/view/fusion/Fusion_Masterpiece.jsp?cate="+ca_code+"";
	}else if(ca_code=="145902"){
		location.href="/view/fusion/Fusion_Masterpiece.jsp?cate="+ca_code+"";
	}else if(ca_code=="145903"){
		location.href="/view/fusion/Fusion_Masterpiece.jsp?cate="+ca_code+"";
	}else if(ca_code=="145904"){
		location.href="/view/fusion/Fusion_Masterpiece.jsp?cate="+ca_code+"";
	}else if(ca_code=="145905"){
		location.href="/view/fusion/Fusion_Masterpiece.jsp?cate="+ca_code+"";
	}else if(ca_code=="145906"){
		location.href="/view/fusion/Fusion_Masterpiece.jsp?cate="+ca_code+"";
	}else if(ca_code=="145907"){
		location.href="/view/fusion/Fusion_Masterpiece.jsp?cate="+ca_code+"";
	}else if(ca_code=="145908"){
		location.href="/view/fusion/Fusion_Masterpiece.jsp?cate="+ca_code+"";
	}else if(ca_code=="145909"){
		location.href="/view/fusion/Fusion_Masterpiece.jsp?cate="+ca_code+"";
	}else if(ca_code=="1458"){//잡화브랜드(기본:빈폴)
		location.href="/view/fusion/Fusion.jsp?cate=1458&brand2no=4290&ganada=3&brandcate=";
	}else if(ca_code=="145109"){//시계-명품시계
		location.href="/view/fusion/Fusion_Masterpiece.jsp?cate=145904";
	}else if(ca_code=="145920"){//명품 브랜드 링크
		location.href="/view/fusion/Fusion_Masterpiece.jsp?cate="+ca_code+"&glname=Coach&ganada=2&isbrand=true&hdnScrollPo=";
	}else if(ca_code=="14570609"){//명품 선글라스 링크
		location.href="/view/fusion/Fusion_Masterpiece.jsp?cate=145906";
	}else if(ca_code=="14570608"){//스포츠 선그라스 링크
		location.href="/view/List.jsp?cate=0925 ";
	}else{
		location.href="/view/fusion/Fusion.jsp?cate="+ca_code;
	}
}
function cmdFusionBrandClickLoc(ca_code,brand2no,brandName){
	if(ca_code=="1005"){
		location.href="/view/Listmp3.jsp?cate=1005&menu=true&islist=";
	}else{
		location.href="/view/fusion/Fusion.jsp?cate="+ca_code+"&brand2no="+brand2no+"&brandName="+brandName;
	}
}
function cmdFusionBrandClickLoc_Fashion(ca_code,brandName){
	location.href="/view/fusion/Fusion.jsp?cate="+ca_code+"&brand="+brandName;
}
function Main_OpenWindow(OpenFile,name,nWidth,nHeight,ScrollYesNo,ResizeYesNo,TPosition,LPosition){
	var newWin = window.open(OpenFile,name,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar=no,Top="+ TPosition +",left="+ LPosition);
	newWin.focus();
}
function CmdTodayView(modelNo , good_type){	
	var url = "/fashion/Fashion_Todayview_Proc.jsp";		
	var param = "modelno=" + modelNo + "&good_type="+good_type;

	var getHitProd = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:drawTodayview
		}
	);		
}
function drawTodayview(originalRequest){
	var cate = originalRequest.responseText;
	
	document.IFrameMyFavoriteList.location.href = "/include/Incmytodayviewlistmain.jsp";
}
function showhidelayer(param){
	//일단 주석처리
	/*
	if(document.all.popular_layer=="[object]")
	{	
		if(param=="1"){
			document.all.popular_layer.style.display="none";
			
			if( document.all.popular_button == "[object]"){
				document.all.popular_button.style.display="block";
			}
		}else{
			document.all.popular_layer.style.display="block";
			if( document.all.popular_button == "[object]"){
				document.all.popular_button.style.display="none";		
			}
		}
	}
	if (document.frames.Fashion_Header.document.getElementById("right_arrow") != null)
	{
		document.frames.Fashion_Header.document.getElementById("right_arrow").src="<%=ConfigManager.IMG_ENURI_COM%>/images/view/fashion/right_arrow.gif";
	}
	if(document.getElementById("div_reckeyword") != null){
		if (document.getElementById("div_reckeyword").style.display == "none"){
			setRecPostion(false);	
		}else{
			setRecPostion(true);	
		}
	}
	*/
}
function over_view_mode(obj){
	obj.className = "over";
}
function out_view_mode(obj){
	obj.className = "out";
}
function cmdAllLayerClose(){
	cmdCloseContentLayer();
	cmdCloseOrderLayer();
	cmdCloseContentLayer_bottom();
	hidePaging();
	cmdTopLayerClose();

	if (document.getElementById("img_paging_btn")){
		document.getElementById("img_paging_btn").src = var_img_enuri_com + "/2010/images/view/newdown.gif";
	}
	if (document.getElementById("img_sort_btn")){
		document.getElementById("img_sort_btn").src = var_img_enuri_com + "/2012/list/newdown.gif";
	}
}
function cmdTopLayerClose(){ //탑메뉴에 있는 이벤트 레이어, 지식통  닫아주기
	if(top.document.getElementById("ac_layer")){ 
		if(top.document.getElementById("ac_layer").style.display != "none"){ 
			top.document.getElementById("ac_layer").style.display = "none";
		}
	}
	if(top.document.getElementById("div_Tc_Tab")){
		if(top.document.getElementById("div_Tc_Tab").style.display != "none"){
			top.document.getElementById("div_Tc_Tab").style.display = "none";
		}
	}
	if(top.document.getElementById("div_Event_Tab")){
		if(top.document.getElementById("div_Event_Tab").style.display != "none"){
			top.document.getElementById("div_Event_Tab").style.display = "none";
		}
	}
	if(top.document.getElementById("LayerM_KBMenu")){
		if(top.document.getElementById("LayerM_KBMenu").style.display != "none"){
			top.document.getElementById("LayerM_KBMenu").style.display = "none";
		} 
	}
}
function cmdShowContentLayer(){

	if(document.getElementById("divContentCount").style.display != "none"){
		document.getElementById("divContentCount").style.display = "none";
		cmdAllLayerClose();
	}else{
		cmdAllLayerClose();
		var posLeftTop = Position.cumulativeOffset($("selected_view_mode"));
		document.getElementById("divContentCount").style.left = posLeftTop[0]+"px";
		document.getElementById("divContentCount").style.top = (posLeftTop[1]+16)+"px";
		document.getElementById("divContentCount").style.display = "";		
		document.getElementById("img_view_btn").src = var_img_enuri_com + "/2012/list/btn_x.gif";
	}
}
function cmdCloseContentLayer(){
	if(document.getElementById("divContentCount")){
		document.getElementById("divContentCount").style.display = "none";
	}
}
function cmdShowContentLayer_bottom(){
	if(document.getElementById("divContentCount_bottom").style.display != "none"){
		document.getElementById("divContentCount_bottom").style.display = "none";
		cmdAllLayerClose();	
	}else{
		cmdAllLayerClose();
		document.getElementById("divContentCount_bottom").style.display = "";
		document.getElementById("img_view_btn2").src = var_img_enuri_com + "/2010/images/view/newdown_close.gif";
	}
}
function cmdCloseContentLayer_bottom(){
	if(document.getElementById("divContentCount_bottom")){
		document.getElementById("divContentCount_bottom").style.display = "none";
	}
}
function cmdShowOrderLayer(){
	if(document.getElementById("divOrderList").style.display != "none"){
		cmdAllLayerClose();
		document.getElementById("divOrderList").style.display = "none";
	}else{
		cmdAllLayerClose();
		var posLeftTop = Position.cumulativeOffset($("selected_sort_mode"));
		document.getElementById("divOrderList").style.left = posLeftTop[0]+"px";
		document.getElementById("divOrderList").style.top = (posLeftTop[1]+16)+"px";
		document.getElementById("divOrderList").style.display = "";		
		document.getElementById("img_sort_btn").src = var_img_enuri_com + "/2012/list/btn_x.gif";
	}
}
function cmdCloseOrderLayer(){
	if(document.getElementById("divOrderList")){
		document.getElementById("divOrderList").style.display = "none";
	}
}
/*
function viewBigImage(cate){
	OpenFile = "/view/Viewbigimg_Fusion_2010.jsp?key=POPULAR DESC&cate="+cate+"&search=NO&m_price=&pagesize=60&page=1&keyword=&orgkeyword=&logkeyword=&nomodel=Y&from=fusion";
	var newWin = window.open(OpenFile,"img_fusion","width=500,height=500,toolbar=no,directories=no,status=no,scrollbars=no,resizable=NO,menubar=no,Top=0,left=0");
	newWin.focus();
}
*/
function openFavoriteWin(){
	/*
	if (document.getElementById("div_favorite")){
		document.getElementById("div_favorite").style.zindex = 100;
		if (document.getElementById("div_favorite").style.display != "none"){
			document.getElementById("div_favorite").style.display = "none";
		}else{
			document.getElementById("div_favorite").style.top = "117";
			document.getElementById("div_favorite").style.left = Position.cumulativeOffset($("imgFavoriteBtn"))[0]-318+"px";
			document.getElementById("div_favorite").style.position = "absolute";
			document.getElementById("div_favorite").style.display = "";
		}
	}
	*/
	if(document.getElementById("incFavoriteLayer").innerHTML != document.getElementById("div_favorite").innerHTML){
		document.getElementById("incFavoriteLayer").innerHTML = document.getElementById("div_favorite").innerHTML;
	}
	if(document.getElementById("incFavoriteLayer").style.display == "none"){
		document.getElementById("incFavoriteLayer").style.top = "117px";
		document.getElementById("incFavoriteLayer").style.left = Position.cumulativeOffset($("imgFavoriteBtn"))[0]-318+"px";
		document.getElementById("incFavoriteLayer").style.zIndex = "99";
		document.getElementById("incFavoriteLayer").style.display = "";
	}else{
		document.getElementById("incFavoriteLayer").style.display = "none";
	}
}
function closeFavorite(){
	if(document.getElementById("incFavoriteLayer")){
		document.getElementById("incFavoriteLayer").style.display = "none";
	}
}
function goSortTab(strTabKey){
	if (document.getElementById("orgkeyword") && document.getElementById("keyword")){
		document.frmList.keyword.value = document.frmList.orgkeyword.value;
	}			
	document.frmList.page.value="";
	document.frmList.key.value=strTabKey;
	document.frmList.submit(); 
}
function goSortCount(strCount , div){
	if (document.body.scrollTop){
		top.document.body.scrollTop = "0px";
	}else{
		top.document.documentElement.scrollTop = "0px";
	}
	if (document.getElementById("orgkeyword")){
		document.frmList.keyword.value = document.frmList.orgkeyword.value;
	}			
	document.frmList.page.value="";
	
	document.frmList.divList.value = div;
	document.frmList.pagesize.value=strCount;
	document.frmList.submit();
}
function cmdBrandClick(brand2no,ganada, brandcate){
	location.href="/view/fusion/Fusion.jsp?cate=1458&brand2no="+brand2no+"&ganada="+ganada+"&brandcate="+brandcate+"";
}
function getBrandName(ganada){
	
	for (i=1;i<9;i++){
		document.getElementById("span_ganada"+i).className = "no_sel_ganada";
		//document.getElementById("brand_arr"+i).style.display = "none";
	}
	document.getElementById("span_ganada"+ganada).className = "sel_ganada";

	//document.getElementById("brand_arr"+ganada).style.display = "inline";
	
	//if (document.getElementById("ganada"+ganada).innerHTML == ""){//스크롤 무조건 상위 가게 하려고 주석 처리했음
		var url_i = "/view/fusion/include/getBrandNames_2010.jsp";
		var param_i = "ganada="+ganada+"&cate=1458";
		var getAjaxProd = new Ajax.Request(
			url_i,
			{
				method:'get',parameters:param_i,onComplete:showBrand
			}
		);	
	/*
	}else{
		for (i=1;i<9;i++){
			document.getElementById("ganada"+i).style.display = "none";
			if(document..getElementById("div_dcatelayer")){
				alert("aaa1");
				document.getElementById("div_dcatelayer").scrollTop = 0;
			}
		}			
		document.getElementById("ganada"+ganada).style.display = "inline";
	}
	*/
	function showBrand(originalRequest){
		for (i=1;i<9;i++){
			document.getElementById("ganada"+i).style.display = "none";
		}					
		document.getElementById("ganada"+ganada).innerHTML = originalRequest.responseText;
		document.getElementById("ganada"+ganada).style.display = "inline";

	}		
}
function cmdMoveFusionPage(goPage){
	location.href=goPage;
}
function cmdFusionLocationAllClose(){
	cmdCloseMCate();
	cmdCloseSCate();
	cmdCloseDCate();
}
function CmdGotoMall(type, cmd, vcode, modelno, price, url,cate,pl_no,imgurl){
	var obj = document.fmGotoMall;
	obj.type.value=type;
	obj.cmd.value=cmd;
	obj.vcode.value=vcode;
	obj.modelno.value=modelno;
	obj.price.value=price;
	obj.url.value=url;	
	obj.cate.value=cate;
	obj.pl_no.value=pl_no;
	obj.imgurl.value=imgurl;
	obj.submit();
}
function cmdFusionResize_new(){
	cmdAllLayerClose();
	if (varPlsno){
		if(document.getElementById("main_price_layer")){
			document.getElementById("main_price_layer").style.display = "none";
		}
		if(top.document.getElementById("main_price_layer")){
			top.document.getElementById("main_price_layer").style.display = "none";
		}
	}
	if (varImgViewWidth != Math.floor(98/(top.getBodyClientWidth() > 1205 ? 6 : 5)*100)/100){  
		varImgViewWidth = Math.floor(98/(top.getBodyClientWidth() > 1205 ? 6 : 5)*100)/100;
		varBannerViewWidth = Math.floor(97/(top.getBodyClientWidth() > 1205 ? 6 : 5)*100)/100;
		if (styleObj.insertRule) {  
			styleObj.deleteRule(varRuleIndex);
			styleObj_banner.deleteRule(varRuleIndex_banner);
			
			varRuleIndex = styleObj.cssRules.length;
			varRuleIndex_banner = styleObj_banner.cssRules.length;
			
			styleObj.insertRule(".fusion_goods{width:"+varImgViewWidth+"%}",varRuleIndex);
			styleObj_banner.insertRule("#food_banner li{width:"+varBannerViewWidth+"%}",varRuleIndex_banner);
		}else { /* IE */  
			styleObj.removeRule(0);
			styleObj_banner.removeRule(0);
			styleObj.addRule(".fusion_goods","width:"+varImgViewWidth+"%",0);
			styleObj_banner.addRule("#food_banner li","width:"+varBannerViewWidth+"%",0);
		}
		/* 브랜드 의류쪽 미분류 레이어 */
		if(parent.document.getElementById("divDCateLayer")){
			parent.document.getElementById("divDCateLayer").style.display = "none";
		}
	}
	setPositionFactoryGo();
	setPositionFactorySort();
	
}

function cmdFusionResize(){
	if (varPlsno){
		//document.getElementById("main_price_layer").style.display = "none";
		if(document.getElementById("main_price_layer")){
			document.getElementById("main_price_layer").style.display = "none";
		}
		if(top.document.getElementById("main_price_layer")){
			top.document.getElementById("main_price_layer").style.display = "none";
		}
		//document.getElementById("sprice_open_"+varPlsno).src = var_img_enuri_com + "/2010/images/view/bt_open.gif";
	}
	
	//1205
	//document.getElementById("widthCheck").innerHTML = document.body.clientWidth;
	//setAsideLeftPosition();
	
	if(!(BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6)) {
		if(document.getElementById("rb_buttons")){
			document.getElementById("rb_buttons").style.top = setRbButtonsTopPosition();
		}
	} 
	if (document.getElementById("enuriMenuFrame")){
		document.getElementById("enuriMenuFrame").contentWindow.setPositionCategory();
	}
	/*
	for(var i=0; i< totalCnt;i++){
		if(document.body.clientWidth >= 1205){
			document.getElementById("fusionContent_"+i).style.width = "20%";
		}else{
			document.getElementById("fusionContent_"+i).style.width = "24.9%";
		}
	}
	
	if(document.body.clientWidth >= 1205 && varFusionContentChk == "25"){
		for(var i=0; i< totalCnt;i++){
			document.getElementById("fusionContent_"+i).style.width = "20%";
		}
		varFusionContentChk = "20";
	}
	if(document.body.clientWidth < 1205 && varFusionContentChk == "20"){
		for(var i=0; i< totalCnt;i++){
			document.getElementById("fusionContent_"+i).style.width = "24.9%";
		}
		varFusionContentChk = "25";
	}
	*/
	if (varImgViewWidth != Math.floor(98/(top.getBodyClientWidth() > 1205 ? 5 : 4)*100)/100){  
		varImgViewWidth = Math.floor(98/(top.getBodyClientWidth() > 1205 ? 5 : 4)*100)/100;
		varBannerViewWidth = Math.floor(97/(top.getBodyClientWidth() > 1205 ? 5 : 4)*100)/100;
		if (styleObj.insertRule) {  
			styleObj.deleteRule(varRuleIndex);
			styleObj_banner.deleteRule(varRuleIndex_banner);
			
			varRuleIndex = styleObj.cssRules.length;
			varRuleIndex_banner = styleObj_banner.cssRules.length;
			
			styleObj.insertRule(".fusion_goods{width:"+varImgViewWidth+"%}",varRuleIndex);
			styleObj_banner.insertRule("#food_banner li{width:"+varBannerViewWidth+"%}",varRuleIndex_banner);
		}else { /* IE */  
			styleObj.removeRule(0);
			styleObj_banner.removeRule(0);
			
			styleObj.addRule(".fusion_goods","width:"+varImgViewWidth+"%",0);
			styleObj_banner.addRule("#food_banner li","width:"+varBannerViewWidth+"%",0);
		}
	}
	setPositionFactoryGo();
	hideAllLayer();
	setWidthLineMap();
	setPositionFactorySort();
	if (BrowserDetect.browser == "Explorer" && (BrowserDetect.version == 6 || BrowserDetect.version == 7)){
		setTimeout(function(){
			try{
				var varWidth = top.document.getElementById("wrap").offsetWidth;
				top.document.getElementById("wrap").style.width = varWidth-1+"px";
				top.document.getElementById("wrap").style.width = varWidth+"px";
				top.document.getElementById("wrap").style.setExpression("width", "setWidthWrap()")
				var varCloseBtnTop = Position.cumulativeOffset(document.getElementById("factory_layer_inner"))[1]- Position.cumulativeOffset(document.getElementById("factory_layer"))[1]; 
				if (document.getElementById("hot_factory_layer")){
					varCloseBtnTop = varCloseBtnTop - document.getElementById("hot_factory_layer").offsetHeight; 
				}							
				if (document.getElementById("close_factory_btn")){
					document.getElementById("close_factory_btn").style.top = varCloseBtnTop+"px";
				}
			}catch(e){
			}
		},10);
	}	
}
function initFusion(totalCnt){
	for(var i=0; i< totalCnt;i++){
		if(document.body.clientWidth >= 1205){
			document.getElementById("fusionContent_"+i).style.width = "20%";
		}else{
			document.getElementById("fusionContent_"+i).style.width = "24.9%";
		}
	}
	//alert(document.getElementById("fusionContent_1").style.width);
	if(document.body.clientWidth >= 1205){
		varFusionContentChk = "20";
	}else{
		varFusionContentChk = "25";
	}
}
function goPage(page){
	/*
	if (document.body.scrollTop){
		top.document.body.scrollTop = "0px";
	}else{
		top.document.documentElement.scrollTop = "0px";
	}
	*/
	top.scrollTo(0,0);
	document.frmList.page.value=page;
	document.frmList.submit(); 
}
function showPaging(){
	if (document.getElementById("select_paging_group").style.display != "none"){
		document.getElementById("select_paging_group").style.display = "none";
		cmdAllLayerClose();
	}else{
		cmdAllLayerClose();
		var posLeftTop = Position.cumulativeOffset($("paging_group_list"));
		document.getElementById("select_paging_group").style.left = posLeftTop[0]+"px";
		document.getElementById("select_paging_group").style.top = posLeftTop[1]+16+"px";
		document.getElementById("select_paging_group").style.display = "";
		document.getElementById("img_paging_btn").src = var_img_enuri_com + "/2010/images/view/newdown_close.gif";
	}
}
function hidePaging(){
	if (document.getElementById("select_paging_group")){
		document.getElementById("select_paging_group").style.display = "none";
	}
}
function hideAllLayer(layer){
	if (layer != "pricelist"){
		hidePricelistLayer(varPlsno);
	}

	if (layer != "beginner"){
		//top.closeAllBeginnerDic();
	}

	top.hideGoogleSearch();
		
	var hideLayers = [
	"sort_mode","view_mode","view_mode2","select_paging_group","factory_info_layer","divWeightInfo","orderListDiv","divLowestPriceInfo","booklayer","div_point_info","div_innoresult","scate_layer","img_catekeyword_help","img_removesynonyum_help",
	];
	var topHideLayers = [
	"comparisonInfo","myfavoriteInfo","sprice_info","popular_info_layer","div_inconv","ac_layer","beginner_big_img","clauseLayer","booklayer","clauseInfoDiv","dicGoogleLayer","popularListDiv","orderListDiv","smartDiv","div_brand_list","div_Tc_Tab","div_Event_Tab","LayerM_KBMenu","divGoodsDetailInfo","simg_layer","div_inconv_2","More_layer_2","More_layer","app_dn_layer","app_dn_layer_car","More_layer_3","More_layer_2"
	];		
	for (var i=0;i<hideLayers.length;i++){
		if (document.getElementById(hideLayers[i])){
			if (layer != hideLayers[i]){
				document.getElementById(hideLayers[i]).style.display = "none";
			}
		}
	}
	
	for (var i=0;i<topHideLayers.length;i++){
		if (top.document.getElementById(topHideLayers[i])){
			if (layer != topHideLayers[i]){
				top.document.getElementById(topHideLayers[i]).style.display = "none";
			}
		}
	}
	//alert(11);
	//top.document.getElementById("div_Tc_Tab").style.display = "none";
	if (document.getElementById("img_paging_btn")){
		document.getElementById("img_paging_btn").src = var_img_enuri_com + "/2010/images/view/newdown.gif";
	}
	if (document.getElementById("img_sort_btn")){
		document.getElementById("img_sort_btn").src = var_img_enuri_com + "/2012/list/newdown.gif";
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
function setKeywordBackground(){
	/*
	if (varTargetPage == "/view/fusion/Fusion.jsp" || varTargetPage == "/view/fusion/Fusion_Masterpiece.jsp"
		|| varTargetPage == "/view/Listbody_Fusion.jsp" || varTargetPage == "/view/Listbody_Fusion_Masterpiece.jsp"
		|| varTargetPage == "/fashion/brand/include/Listbody_Brand.jsp"
		){
		if (document.getElementById("in_keyword").value.trim().length > 0 ){
			document.getElementById("in_keyword").style.backgroundImage="none";
		}else{
			document.getElementById("in_keyword").style.backgroundImage="url('"+var_img_enuri_com+"/2010/images/view/searchinresult_txt.gif')"
		}
	}else{
		if (document.getElementById("keyword").value.trim().length > 0 ){
			document.getElementById("keyword").style.backgroundImage="none";
		}else{
			document.getElementById("keyword").style.backgroundImage="url('"+var_img_enuri_com+"/2010/images/view/searchinresult_txt.gif')"
		}
	}
	*/
}
function getPricelistLayerFashion(cate,keyword,m_price,start_price,end_price,brand,minpricesearch,maxpricesearch){
	//alert("ajax"+cate+"["+cate.substring(0,2)+"]-"+cate.length);
	//return;
	if (document.getElementById("price_layer")){
		if (document.getElementById("price_layer").innerHTML.trim() == ""){	
			if(cate.substring(0,2) == "15"){
				var url = "/include/ajax/AjaxFusionPriceLayer.jsp";
				var param = "cate="+cate+"&m_price="+m_price+"&start_price="+start_price+"&end_price="+end_price;
				param = param + "&brand="+brand+"&minpricesearch="+minpricesearch+"&maxpricesearch="+maxpricesearch;
			}else{
				var url = "";
				var param = "cate="+cate+"&keyword="+keyword+"&m_price="+m_price+"&start_price="+start_price+"&end_price="+end_price;
				if(varTargetPage == "/fashion/brand/include/Listbody_Brand.jsp"){
					if(cate.substring(0,6) == "148105" || cate.substring(0,6) == "148106" || cate.substring(0,6) == "148107" || cate.substring(0,6) == "148108"){
						url = "/include/ajax/AjaxFashionPriceLayer.jsp";
					}else{
						url = "/include/ajax/AjaxBrandPriceLayer.jsp";
						param = param + "&brand2no="+document.getElementById("brand2no").value;
					}
				}else{
					url = "/include/ajax/AjaxFashionPriceLayer.jsp";
				}		
				param = param + "&brand="+brand+"&minpricesearch="+minpricesearch+"&maxpricesearch="+maxpricesearch;
			}
			if(document.getElementById("sub_cate")){
				param = param + "&sub_cate="+document.getElementById("sub_cate").value;
			}		
			var getRec = new Ajax.Request(
				url,
				{
					method:'get',parameters:param,onComplete:showPricelistLayerFashion
				}
			);
			function showPricelistLayerFashion(originalRequest){
				if (originalRequest.responseText.trim().length == 0) {
					alert("가격정보가 없습니다.");
					return;
				}
				$("price_layer").innerHTML = originalRequest.responseText.trim();
				document.getElementById("tab_price").src = var_img_enuri_com + "/2012/list/tab/price_tab_on.gif";
				document.getElementById("price_layer").style.display = "";
				fnSetCookie2010("pt","y")						
				toggleTabBorder();
			}
		}else{
			if (document.getElementById("price_layer").style.display != "none"){
				document.getElementById("tab_price").src = var_img_enuri_com+"/2012/list/tab/price_tab.gif";
				document.getElementById("price_layer").style.display = "none";
				fnSetCookie2010("pt","n")
			}else{
				document.getElementById("tab_price").src = var_img_enuri_com + "/2012/list/tab/price_tab_on.gif";
				document.getElementById("price_layer").style.display = "";
				insertLog(82);
				fnSetCookie2010("pt","y")
			}
			toggleTabBorder();
		}
	}
	
	insertLog('4374');
}
function setWidthLineMap(){
	if (document.getElementById("location")){
		var varWidth = 90;
		if (document.getElementById("bigphoto")){
			varWidth = varWidth + document.getElementById("bigphoto").offsetWidth;
		}
		document.getElementById("location").style.width = (top.document.getElementById("wrap").offsetWidth - varWidth)+"px";
	}
}
function showFactorySort(){
	if (document.getElementById("factory_sort").style.display != "none"){
		document.getElementById("factory_sort").style.display = "none";
	}else{
		setPositionFactorySort();
		document.getElementById("factory_sort").style.display = "";
	}
}
function setPositionFactorySort(){
	if (document.getElementById("factory_sort")){
		var varLeft = 8;
		if (BrowserDetect.browser == "Chrome" || (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 9) ){
			varLeft = 6;
		}
		document.getElementById("factory_sort").style.left = (Position.cumulativeOffset($("selected_factory_mode"))[0]-varLeft)+"px";
		var varFactoryAddHeight = false;
		if(document.getElementById("price_layer")){
			if(document.getElementById("price_layer").style.display != "none"){
				varFactoryAddHeight = true;
			}
		}
		if(document.getElementById("condition_layer")){
			if(document.getElementById("condition_layer").style.display != "none"){
				varFactoryAddHeight = true;
			}
		}			
		varFactoryGoTop = 27;
		if (varFactoryAddHeight){
			varFactoryGoTop = varFactoryGoTop - 6;
		}		
		document.getElementById("factory_sort").style.top = varFactoryGoTop+"px";
	}
}
function sort_factory(sort,cate,org_cate){
	function showSortedFactoryLayer(originalRequest){
		document.getElementById("factory_layer_inner").innerHTML = originalRequest.responseText;
		var varSort = "";
		if (sort == "G"){
			varSort = "<p>가나다 순</p>";
		}else if(sort == "C"){
			varSort = "<p>상품수 순</p>";
		}else if(sort == "P"){
			varSort = "<p>인기도 순</p>";
		}
		document.getElementById("selected_factory_mode").innerHTML = varSort;
		//document.getElementById("factory_sort").style.display="none";
		showFactorySort();
	}	
	if (sort == "G"){
		insertLog(4492);
	}else if(sort == "C"){
		insertLog(4493);
	}else if(sort == "P"){
		insertLog(4494);
	}	
	chkFactory = $("factory_layer_inner").getElementsBySelector('input[class="chkbox"]');
	var varFactoryUrl = "";
	for (i=0;i<chkFactory.length;i++){
		var varFactoryName = "";
		var varFactoryMallCnt = "";
		var varFactoryPopular = "";
		var varFactoryEtc = "";
		var varFactoryChecked = "";
		if (chkFactory[i].id != "factorychk_all"){
			varFactoryName = chkFactory[i].value.replace(/&/g,"^38^");
			varFactoryName = varFactoryName.replace(/#/g,"^39^");
			varFactoryMallCnt = document.getElementById("factory_mall_cnt_"+chkFactory[i].id.substring(11,chkFactory[i].id.length)).value;
			varFactoryPopular = document.getElementById("factory_popular_"+chkFactory[i].id.substring(11,chkFactory[i].id.length)).value;
			varFactoryEtc = document.getElementById("factory_etc_"+chkFactory[i].id.substring(11,chkFactory[i].id.length)).value;
			if (varFactoryEtc == ""){
				varFactoryEtc = "0"
			}
			if (chkFactory[i].checked){
				varFactoryChecked = "1";
			}else{
				varFactoryChecked = "0";
			}
			varFactoryUrl = varFactoryUrl + varFactoryName+"*"+varFactoryMallCnt+"*"+varFactoryPopular+"*"+varFactoryEtc+"*"+varFactoryChecked+"`";
		}
	}
	varFactoryUrl = "factory="+varFactoryUrl+"&sort="+sort+"&cate="+cate+"&org_cate="+org_cate;
	var url = "/include/IncFactoryLayerSort.jsp";
	var getFactoryInfo = new Ajax.Request(
		url,
		{
			method:'post',parameters:varFactoryUrl,onComplete:showSortedFactoryLayer
		}
	);		
}
function detailMultiView(OpenFile,name,modelno){
//	var detailWin = window.open(OpenFile,"detailMultiWin","width=780,height=600,left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
//	detailWin.focus(); 	 	
	if(navigator.userAgent.indexOf("Chrome/")>0) {
		window.detailWin = window.open("","detailMultiWin","width=0,height=0,left=0,top=0");
		window.detailWin.close();
		window.detailWin = null;
	}
	window.detailWin = window.open(OpenFile,"detailMultiWin","width=804,height="+window.screen.height+",left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
	window.detailWin.focus();
}
function getRecKeword_fusion(cate, chk_brand){
	if(chk_brand == "2"){//브랜드 의류에서 아이템으로 찾기의 관련 키워드 레이어 안띄움
		return;
	}
	//top.commonLayerClose("");
	try{
		if (varGb1 != "" && varGb2 != ""){
			return;
		}
	}catch(e){
	}
	if (typeof(hideAllLayer) == "function"){
		hideAllLayer("");
	}
	//getRecKeword._loading = true;

	var posLeftTop = Position.cumulativeOffset($("tab_layer"));
	var varTop = 0; 
	if (BrowserDetect.browser == "Explorer"){
		varTop = posLeftTop[1]-6;
	}else{
		varTop = posLeftTop[1]-5;
	}	
	document.getElementById("reckeyword").style.top = varTop +"px"
	document.getElementById("reckeyword").style.left = (document.getElementById("tab").offsetWidth - 664) +"px"
	hidePriceLayer();
	hideFactoryLayer();
	hideConditionLayer();
	hideShoppingLayer();
	toggleTabBorder();

	var varInputLeft = 0;
	if (document.getElementById("keyword")){
		varInputLeft = Position.cumulativeOffset(document.getElementById("keyword"))[0] -  (document.getElementById("tab").offsetWidth - 664);
	}else if(document.getElementById("keyword")){
		varInputLeft = Position.cumulativeOffset(document.getElementById("keyword"))[0] -  (document.getElementById("tab").offsetWidth - 664);
	}
	if (document.getElementById("li_sel_shop")){
		if (document.getElementById("li_sel_shop").style.display == "none"){
			varInputLeft = varInputLeft - 95;
		}
	}	
	if (document.getElementById("reckeyword").innerHTML.trim().length >  0){
		setTimeout("setFocusRecKeyword()",200);
		//setFocusRecKeyword();
	}else{
		var todayDate = new Date();
		
		if (varTargetPage == "/view/fusion/Fusion.jsp" || varTargetPage == "/view/fusion/Fusion_Masterpiece.jsp"
			 || varTargetPage == "/view/Listbody_Fusion.jsp" || varTargetPage == "/view/Listbody_Fusion_Masterpiece.jsp"
			 || varTargetPage == "/fashion/clothes/include/Listbody_Style.jsp"){
			insertHideLayer("/view/GetRecKeyword_2010.jsp","cate="+cate+"&keyword="+document.getElementById("keyword").value+"&tmpid="+todayDate.getTime()+"&left="+varInputLeft,"reckeyword",setFocusRecKeyword());
		}else{
			insertHideLayer("/view/GetRecKeyword_2010.jsp","cate="+cate+"&keyword="+document.getElementById("keyword").value+"&tmpid="+todayDate.getTime()+"&left="+varInputLeft,"reckeyword",setFocusRecKeyword());
		}
		
	}
}
function showSimpleView(modelno,popular,cate,vtype){
	top.changeRecentZzim(2);
	top.showSimpleView(modelno,popular,cate,vtype);
	top.hideRecentZzim();
	if (typeof(showSimpleView.modelno) != "undefined"){
		if (document.getElementById("fusion_goods_"+showSimpleView.modelno)){
			document.getElementById("fusion_goods_"+showSimpleView.modelno).style.border="1px solid #ffffff";
		}
	}
	if (typeof(showSimpleView.pulse) == "undefined"){
		showSimpleView.pulse = true;
	}

	showSimpleView.modelno = modelno;
	document.getElementById("fusion_goods_"+showSimpleView.modelno).style.border="1px solid #000000";
	if (top.document.getElementById('div_catekeyword_layer')){
		top.document.getElementById('div_catekeyword_layer').style.display="none";
	}
	if (top.document.getElementById('div_map_detail_info')){
		top.document.getElementById('div_map_detail_info').style.display="none";
	}
	hideAllLayer();
}
function unDoSimpleView(){
	if (typeof(showSimpleView.modelno) != "undefined"){
		if (document.getElementById("fusion_goods_"+showSimpleView.modelno)){
			document.getElementById("fusion_goods_"+showSimpleView.modelno).style.border="1px solid #ffffff";
		}
	}	
}
window.onunload = unloadFunction;

function unloadFunction(){
	hideAllLayer();
	if (typeof (top.isLoadedSimpleView) == "function"){
		if (top.isLoadedSimpleView()){
			top.hideSimpleView();
		}
	}
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
			document.getElementById("lm_mname").getElementsByTagName("DIV")[0].innerHTML = "선택하세요";
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
						if (BrowserDetect.browser == "Chrome"){
							varClickCate = varClickFunc[36] + varClickFunc[37] + varClickFunc[38] + varClickFunc[39] + varClickFunc[40] + varClickFunc[41] + varClickFunc[42];
						//}else if (BrowserDetect.browser == "Explorer" && ( BrowserDetect.version == 9 || BrowserDetect.version == 10)){
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
						document.getElementById("lm_mname").getElementsByTagName("DIV")[0].innerHTML = varMCateDiv[i].getElementsByTagName("SPAN")[1].getElementsByTagName("SPAN")[0].innerHTML;
					}
					
				}
			}
		}	
		if (document.getElementById("lm_mname").getElementsByTagName("DIV")[0].innerHTML.trim().length == 0){
			document.getElementById("lm_mname").getElementsByTagName("DIV")[0].innerHTML = setNowLocMLayer._defaultName;
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
		showLocMCate._f_dmname = document.getElementById("lm_mname").getElementsByTagName("DIV")[0].innerHTML;  
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
	if (linkCate == "0816" || linkCate == "1206" || linkCate == "2112" || linkCate == "0811"){
		top.location.href = "/view/fast_view/Brand_View.jsp?cate=" + linkCate
	}else if(linkCate == "092109" || linkCate == "900305"){
		top.location.href = "/tour2012/Tour_Index.jsp";
	}else if(linkCate == "092118"){
		top.location.href = "/view/Tour_Tourjockey.jsp";
	}else if(linkCate == "163810"){
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
			document.getElementById("lm_sname").getElementsByTagName("DIV")[0].innerHTML = "전체상품";
		}
		var varSCateDiv = $("nowLoc_S_Layer_In").getElementsBySelector("div");
		if (varSCateDiv.length > 28){
			$("nowLoc_S_Layer_In").getElementsBySelector("ul[class='cate_layer_ul']")[0].style.height = "228px";
		}else{
			$("nowLoc_S_Layer_In").getElementsBySelector("ul[class='cate_layer_ul']")[0].style.height = "100%";
		}
		
		for (var i=0;i<varSCateDiv.length;i++){
			if (varSCateDiv[i].visible()){
				varSCateDiv[i].onmouseover = function(){
					if (typeof(this.getElementsByTagName("SPAN")[1]) != "undefined"){
						this.getElementsByTagName("SPAN")[1].getElementsByTagName("SPAN")[0].style.color="#c70b09";
					}
				}
				varSCateDiv[i].onmouseout = function(){
					if (typeof(this.getElementsByTagName("SPAN")[1]) != "undefined"){
						if (this.getElementsByTagName("SPAN")[1].id == ("cate_"+varCate.substring(0,6)) ){
							this.getElementsByTagName("SPAN")[1].getElementsByTagName("SPAN")[0].style.color="#00589A";
						}else{						
							this.getElementsByTagName("SPAN")[1].getElementsByTagName("SPAN")[0].style.color="#242424";
						}
					}
				}
				if (varSCateDiv[i].getElementsByTagName("SPAN").length > 1 ){
					var varClickFunc = new String(varSCateDiv[i].getElementsByTagName("SPAN")[1].onclick);
					var varClickCate = "";
					if (typeof(varClickFunc[36]) != "undefined"){
						if (BrowserDetect.browser == "Chrome"){
							varClickCate = varClickFunc[36] + varClickFunc[37] + varClickFunc[38] + varClickFunc[39] + varClickFunc[40] + varClickFunc[41] + varClickFunc[42];
						//}else if (BrowserDetect.browser == "Explorer" && ( BrowserDetect.version == 9 || BrowserDetect.version == 10)){
						}else{
							varClickCate = varClickFunc[34] + varClickFunc[35] + varClickFunc[36] + varClickFunc[37] + varClickFunc[38] + varClickFunc[39] + varClickFunc[40];
						}
					}else{
						varClickCate = varClickFunc.substring(varClickFunc.indexOf("'")+1,varClickFunc.length);
					}
					varClickCate = varClickCate.substring(0,varClickCate.indexOf("'"));
					
					if (varCate.substring(0,6) == varClickCate ){
						varSCateDiv[i].getElementsByTagName("SPAN")[1].getElementsByTagName("SPAN")[0].style.color="#00589A";
						varSCateDiv[i].getElementsByTagName("SPAN")[1].style.backgroundRepeat = "no-repeat";
						varSCateDiv[i].getElementsByTagName("SPAN")[1].style.backgroundPosition = "left center";
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

function pcheckModel_fasion(modelno,bBook){
	var bChecked = false;
	if (arrCheckedModelNo.indexOf(modelno) >= 0){
		//arrCheckedModelNo = arrCheckedModelNo.without(modelno);
		arrCheckedModelNo[arrCheckedModelNo.indexOf(modelno)] = "";
	}else{
		bChecked = true;
		arrCheckedModelNo[arrCheckedModelNo.length] = modelno;
	}
	if(arrCheckedModelNo.indexOf(modelno) >= 0 && bChecked ==false){
		document.getElementById("comparenzzim").style.display = "none";
	}
	setPositionCompareZzim_fasion($("pchk_"+modelno),'l')
	if (arrCheckedModelNo.size() > 0){
		if (typeof(bBook) != "undefined" || modelno == 8361362 || modelno == 7820366 || modelno == 2513426){
			$("comparenzzim").getElementsBySelector("img")[0].style.display = "none";
		}else{
			$("comparenzzim").getElementsBySelector("img")[0].style.display = ""
		}	
		document.getElementById("comparenzzim").style.display = "";
		//if (typeof(bBook) != "undefined"){
		//	document.getElementById("comparenzzim").style.left = (document.getElementById("comparenzzim").offsetLeft-30) + "px";
		//}		
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
	var sCheckmodelno = arrCheckedModelNo.toString();
	sCheckmodelno = sCheckmodelno.replaceAll(",","");
	if(sCheckmodelno==""){
		document.getElementById("comparenzzim").style.display = "none";
	}
}

String.prototype.replaceAll = function (str1,str2){
	 var str    = this;     
	 var result   = str.replace(eval("/"+str1+"/gi"),str2);
	 return result;
}

var arrCheckedModelNo = new Array();
var _f_chekModel;
function setPositionCompareZzim(chkModel,chkLoc){
	if (typeof(chkModel) != "undefined"){
		_f_chekModel = chkModel;
	}
	if (typeof(_f_chekModel) != "undefined"){
		var posLeftTop = Position.cumulativeOffset(_f_chekModel);
		var posLeft = 0 ;
		if (document.getElementById("view").value == "2p"){
			posLeft = posLeftTop[0]+13;
		}else{
			var varMLeft = 90;
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

		var posTop = posLeftTop[1]+15;	
		if (posLeft < 5 ){
			posLeft = 5
		}
		
		if (typeof(chkLoc) != "undefined"){
			posLeft = posLeft + 105;
		}
		if (varTargetPage == "/view/Listbody_Smart.jsp" ){
			posLeft = posLeft - 36;
		}
		if (posLeft < 100){
			posLeft = posLeft + 105;
		}
		document.getElementById("comparenzzim").style.left = posLeft+"px";
		document.getElementById("comparenzzim").style.top = posTop+"px";
	}	
}
function setPositionCompareZzim_fasion(chkModel,chkLoc){
	if (typeof(chkModel) != "undefined"){
		_f_chekModel = chkModel;
	}
	if (typeof(_f_chekModel) != "undefined"){
		var posLeftTop = Position.cumulativeOffset(_f_chekModel);
		var posLeft = 0 ;
		if (document.getElementById("view").value == "2p"){
			posLeft = posLeftTop[0]+13;
		}else{
			var varMLeft = 90;
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

		var posTop = posLeftTop[1]+15;	
		var browserAgent = navigator.userAgent;
		if(browserAgent.indexOf("MSIE 10")!=-1){
			posTop = posTop + 12;
		}
		if (posLeft < 5 ){
			posLeft = 5
		}
		
		if (typeof(chkLoc) != "undefined"){
			if(posLeft==5){
				posLeft = -61;
			}else{
				posLeft = posLeft + 105;
			}
		}
		if (varTargetPage == "/view/Listbody_Smart.jsp" ){
			posLeft = posLeft - 36;
		}
		if (posLeft < 100){
			posLeft = posLeft + 105;
		}
		document.getElementById("comparenzzim").style.left = posLeft+"px";
		document.getElementById("comparenzzim").style.top = posTop+"px";
	}	
}
function setPositionCompareZzim_fasion_width(){
	if(_f_chekModel){
		var posLeftTop = Position.cumulativeOffset(_f_chekModel);
		var posLeft = 0 ;
		//alert("posLeftTop[0]->"+posLeftTop[0]);
		//alert("posLeftTop[1]->"+posLeftTop[1]);
		posLeft = posLeftTop[0]+17;
		posTop = posLeftTop[1]+14;
		var browserAgent = navigator.userAgent;
		if(browserAgent.indexOf("MSIE 10")!=-1){
			posTop = posTop + 12;
		}
		document.getElementById("comparenzzim").style.left = posLeft+"px";
		document.getElementById("comparenzzim").style.top = posTop+"px";
	}
}

function hideZzimComp(){
	document.getElementById("comparenzzim").style.display = "none";
}
function goCateKeywordSearch(){
	fireEvent(top.document.getElementById("cate_layer_link_img"),"click");	
}
function showSearchKeywordHepLayer(){
	var varLeft = Position.cumulativeOffset($("catekeyword_help"))[0]-220;
	var varTop = Position.cumulativeOffset($("catekeyword_help"))[1]+18;
	document.getElementById("img_catekeyword_help").style.top = varTop+"px";
	document.getElementById("img_catekeyword_help").style.left = varLeft+"px";
	document.getElementById("img_catekeyword_help").style.display = "";
}
function toggleRecKeyword(){
	if (typeof(toggleRecKeyword.isAll) == "undefined"  || toggleRecKeyword.isAll == false){
		document.getElementById("reckeyword_top_list").style.display = "none";
		document.getElementById("reckeyword_all_list").style.display = "";		
		toggleRecKeyword.isAll = true;
		document.getElementById("rec_btn_more").innerHTML = "<span style=\"font-family:'맑은 고딕','돋움';font-size:11px;font-weight:bold\">접기</span><span style=\"font-family:돋움;font-size:12px;font-weight:bold\">↑</span>";
		insertLog(10179);
	}else{
		document.getElementById("reckeyword_all_list").style.display = "none";
		document.getElementById("reckeyword_top_list").style.display = "";
		toggleRecKeyword.isAll = false;		
		document.getElementById("rec_btn_more").innerHTML = "<span style=\"font-family:'맑은 고딕','돋움';font-size:11px;font-weight:bold\">더보기</span><span style=\"font-family:돋움;font-size:12px;font-weight:bold\">↓</span>";
	}
}
function showViewmode(n){
	if (typeof(showViewmode._n) != "undefined" && showViewmode._n == n && document.getElementById("view_mode").style.display != "none"){
		hideViewmode();
		if (document.getElementById("img_view_btn"+n)){
			document.getElementById("img_view_btn"+n).src = var_img_enuri_com + "/2014/list/tab/combo_dn.gif";
		}		
		hideAllLayer();
	}else{
		if (document.getElementById("view_mode").style.display != "none"){
			document.getElementById("view_mode").style.display = "none";
			if (document.getElementById("img_view_btn"+showViewmode._n)){
				document.getElementById("img_view_btn"+showViewmode._n).src = var_img_enuri_com + "/2014/list/tab/combo_dn.gif";
			}					
		}
		hideAllLayer();
		var posLeftTop = Position.cumulativeOffset($("selected_view_mode"+n));
		var addLeft = 0;
		var addTop = 14;
		if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 7){
			if (n == 1){
				addTop = 12;
				addLeft = -4;
			}
		}

		document.getElementById("view_mode").style.left = (posLeftTop[0]+addLeft)+"px";
		document.getElementById("view_mode").style.top = posLeftTop[1]+addTop+"px"; 
		document.getElementById("view_mode").style.display = "";
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

var libType = function(){
    var rtn = "";
    if (typeof(Prototype) != "undefined" ){
        rtn = "PR"
    }else if(typeof(jQuery) != "undefined"){
        rtn = "JQ"
    }
    return rtn;
}

function commonAjaxRequest(url,param,callback){
    if (libType() == "PR"){
        var getInstProd = new Ajax.Request(       
            url,      
            {  
                method:'post',parameters:param,onComplete:callback
            }
        );      
    }else if(libType() == "JQ"){
        $.ajax({
            type: "POST",  
            url: url, 
            data: param,     
            success: function(result){
                callback(result);
            }   
        });     
    }
}
function openLayer(layerPop,e){
	var pop = document.getElementById(layerPop);
	pop.style.display = "block";
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