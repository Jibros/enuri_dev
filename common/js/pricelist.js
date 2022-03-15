// 배송비포함과 제외를 토글함
var pricelist_modelno,pricelist_porder,pricelist_cate,pricelist_minprice,pricelist_count,pricelist_imgurl,pricelist_pl_no;
var pricelist_getType = 0;
function getPricelistDelivery(checkedV){	if (checkedV){		getPricelistDeliveryMain(1);	}else{		getPricelistDeliveryMain(2);	}}
function getPricelistDeliveryMain(intPricelistFlag) {
//	hideAllLayer("pricelist");
	varPlsno = 0;
//	alert("pricelist_getType="+pricelist_getType+", intPricelistFlag="+intPricelistFlag);

/*
	if(intPricelistFlag==1) {
		if($("pricelistDeliveryImg1")) $("pricelistDeliveryImg1").src = var_img_enuri_com + "/images/view/deliverycate/p_plus_chack.gif";
		if($("pricelistDeliveryImg2")) $("pricelistDeliveryImg2").src = var_img_enuri_com + "/images/view/deliverycate/p_minus_unchack.gif";
	}
	if(intPricelistFlag==2) {
		if($("pricelistDeliveryImg1")) $("pricelistDeliveryImg1").src = var_img_enuri_com + "/images/view/deliverycate/p_plus_unchack.gif";
		if($("pricelistDeliveryImg2")) $("pricelistDeliveryImg2").src = var_img_enuri_com + "/images/view/deliverycate/p_minus_chack.gif";
	}
*/
	//alert(intPricelistFlag);
	//alert(pricelist_getType);
	if(pricelist_getType==1) {
		if($("view")) {
			getPricelistLayerInner(pricelist_modelno,pricelist_porder,pricelist_cate,pricelist_minprice,intPricelistFlag);
		} else {
			/*
			if (document.URL.indexOf("/view/Listbody.jsp") >= 0 || document.URL.indexOf("/view/List.jsp") >= 0){
				if (typeof(top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.getPricelistLayer) == "function"){
					top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.varPlsno = 0;
					top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.getPricelistLayerInner(pricelist_modelno,pricelist_porder,pricelist_cate,pricelist_minprice,intPricelistFlag);
				} 
			}else if (document.URL.indexOf("/search/") >= 0 ){
				if (typeof(top.$("searchListFrame").contentWindow.getPricelistLayer) == "function"){
					top.$("searchListFrame").contentWindow.varPlsno = 0;
					top.$("searchListFrame").contentWindow.getPricelistLayerInner(pricelist_modelno,pricelist_porder,pricelist_cate,pricelist_minprice,intPricelistFlag);
				} 
			}
			if(typeof(top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.getPricelistLayer) == "function"){
				top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.varPlsno = 0;
				top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.getPricelistLayerInner(pricelist_modelno,pricelist_porder,pricelist_cate,pricelist_minprice,intPricelistFlag);
			} 
			*/
			if (document.URL.indexOf("/search/") >= 0 ){
				if (typeof(top.$("searchListFrame").contentWindow.getPricelistLayer) == "function"){
					top.$("searchListFrame").contentWindow.varPlsno = 0;
					top.$("searchListFrame").contentWindow.getPricelistLayerInner(pricelist_modelno,pricelist_porder,pricelist_cate,pricelist_minprice,intPricelistFlag);
				} 
			}else if(typeof(top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.getPricelistLayer) == "function"){
				top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.varPlsno = 0;
				top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.getPricelistLayerInner(pricelist_modelno,pricelist_porder,pricelist_cate,pricelist_minprice,intPricelistFlag);
			} 			
		}
	}
	if(pricelist_getType==2) {
		if($("view")) {
			getPricelistToolLayerInner(pricelist_modelno,pricelist_porder,pricelist_cate,pricelist_minprice,pricelist_count,intPricelistFlag);
		} else {
			/*
			if (document.URL.indexOf("/view/Listbody.jsp") >= 0 || document.URL.indexOf("/view/List.jsp") >= 0){
				if (typeof(top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.getPricelistLayer) == "function"){
					top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.varPlsno = 0;
					top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.getPricelistToolLayerInner(pricelist_modelno,pricelist_porder,pricelist_cate,pricelist_minprice,pricelist_count,intPricelistFlag);
				} 
			}else if (document.URL.indexOf("/search/") >= 0 ){
				if (typeof(top.$("searchListFrame").contentWindow.getPricelistLayer) == "function"){
					top.$("searchListFrame").contentWindow.varPlsno = 0;
					top.$("searchListFrame").contentWindow.getPricelistToolLayerInner(pricelist_modelno,pricelist_porder,pricelist_cate,pricelist_minprice,pricelist_count,intPricelistFlag);
				} 
			}
			if(typeof(top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.getPricelistLayer) == "function"){
				top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.varPlsno = 0;
				top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.getPricelistToolLayerInner(pricelist_modelno,pricelist_porder,pricelist_cate,pricelist_minprice,pricelist_count,intPricelistFlag);
			} 
			*/
			if (document.URL.indexOf("/search/") >= 0 ){
				if (typeof(top.$("searchListFrame").contentWindow.getPricelistLayer) == "function"){
					top.$("searchListFrame").contentWindow.varPlsno = 0;
					top.$("searchListFrame").contentWindow.getPricelistToolLayerInner(pricelist_modelno,pricelist_porder,pricelist_cate,pricelist_minprice,pricelist_count,intPricelistFlag);
				}
			}else if(typeof(top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.getPricelistLayer) == "function"){
				top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.varPlsno = 0;
				top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.getPricelistToolLayerInner(pricelist_modelno,pricelist_porder,pricelist_cate,pricelist_minprice,pricelist_count,intPricelistFlag);
			}			
		}
	}
	if(pricelist_getType==3) {
		getPricelistLayerFusionInner(pricelist_modelno,pricelist_porder,pricelist_cate,pricelist_imgurl,pricelist_pl_no,intPricelistFlag);
	}
}

function getPricelistLayer(modelno,porder,cate,minprice){
	changeFlag = 1;
	if(varPlsno!=modelno) {
		hideAllLayer();		/*
		if (top.document.getElementById('rb_recent_zzim')){
			top.document.getElementById('rb_recent_zzim').style.display = "none";
		}				
		if (top.document.getElementById("rb_buttons")){
			top.document.getElementById("rb_buttons").style.display="";
		}		*/								
	}
	insertLog(408);
	getPricelistLayerInner(modelno,porder,cate,minprice,2);
}
function getPricelistLayerInner(modelno,porder,cate,minprice,intPricelistFlag){
	pricelist_modelno = modelno;
	pricelist_porder = porder;
	pricelist_cate = cate;
	pricelist_minprice = minprice;
	pricelist_getType = 1;
	top.pricelist_modelno = modelno;
	top.pricelist_porder = porder;
	top.pricelist_cate = cate;
	top.pricelist_minprice = minprice;
	top.pricelist_getType = 1;

	if (varPlsno ){
		$("main_price_layer").style.display = "none";		if (top.document.getElementById("main_price_layer_info")){			if (top.document.getElementById("main_price_layer_info").style.display != "none"){				top.document.getElementById("main_price_layer_info").style.display = "none";			}												}
		if ($("view").value != "img"){
			if ($("view").value == "1p"){
				//$("goodslist1_div_2_"+varPlsno).style.backgroundColor="";
				//$("goodslist1_div_3_"+varPlsno).style.backgroundColor="";
				top.$("main_price_layer_bar").style.display = "none";
				hideAllLayer("pricelist");
			}
		}else{
			$("goods_image_list_dl_"+varPlsno).style.borderStyle="solid";
			$("goods_image_list_dl_"+varPlsno).style.borderColor="#d4d4d4";

			var nextObjs = $("goods_image_list_dl_"+varPlsno).nextSiblings();
			if (nextObjs.length > 0){
				if (Position.cumulativeOffset($("goods_image_list_dl_"+varPlsno))[1] == Position.cumulativeOffset(nextObjs[0])[1]){
					nextObjs[0].style.borderLeftStyle="solid";
					nextObjs[0].style.borderLeftColor="#d4d4d4";
				}
			}				
		}
	}

	if (varPlsno != modelno){
//		hideAllLayer();
//		insertLog('408');
		if ($("view").value != "img"){
			//$("sprice_open_"+modelno).src = var_img_enuri_com + "/2010/images/view/bt_close.gif";
		}else{
			$("goods_image_list_dl_"+modelno).style.borderStyle="solid";
			$("goods_image_list_dl_"+modelno).style.borderColor="#F97800";

			var nextObjs = $("goods_image_list_dl_"+modelno).nextSiblings();
			if (nextObjs.length > 0){
				if (Position.cumulativeOffset($("goods_image_list_dl_"+modelno))[1] == Position.cumulativeOffset(nextObjs[0])[1]){
					nextObjs[0].style.borderLeftStyle="solid";
					nextObjs[0].style.borderLeftColor="#F97800";
				}
			}
		}
		varPlsno = modelno;
		var varListType = "";
		if ($("view").value == "2p"){
			varListType = "list2p"
		}else if ($("view").value == "1p"){
			varListType = "list1p"
		}else if($("view").value == "img"){
			varListType = "imglist"
		}
		var url = "/include/IncPricelistLayerInner_2010.jsp";
		var param = "modelno="+modelno+"&type="+varListType+"&cate="+cate+"&porder="+porder+"&intPricelistFlag="+intPricelistFlag;
		var getRec = new Ajax.Request(
			url,
			{
				method:'get',parameters:param,onComplete:showPricelistLayer
			}
		);
	}else{
		varPlsno = "";
	}
	function showPricelistLayer(originalRequest){
		if (originalRequest.responseText.trim().length == 0) {
			alert("가격정보가 없습니다.");
			return;
		}
		if ($("view").value == "2p"){
			var posLeftTop = Position.cumulativeOffset($("goodslist2_td_2_"+modelno));
			var posLeft = posLeftTop[0];
			var posTop = posLeftTop[1];
			if(BrowserDetect.browser == "Explorer") {
				if (BrowserDetect.version == 8){
					posLeft = posLeft -1;
				}
			}			var slWidth = $("goodslist2_td_2_"+modelno).offsetWidth;
			$("main_price_layer").innerHTML = originalRequest.responseText;			var tempLeft = 0;			if(posLeft>300) {				tempLeft = 83;			} else {				tempLeft = 111 + slWidth + 2;			}			$("main_price_layer").setStyle({'left':tempLeft+'px','top':(posTop-60)+'px','visibility':'hidden','display':'','width':'230px','border':'0px solid #000000'});			setTimeout(function(){
				var posTop2 = Position.cumulativeOffset($("goodslist2_td_0_"+modelno))[1] - $("main_price_layer").offsetHeight + $("goodslist2_td_0_"+modelno).offsetHeight + $("goodslist2_td_optoon_"+modelno).offsetHeight;
				if((BrowserDetect.browser == "Explorer" && BrowserDetect.version != 8 ) || BrowserDetect.browser == "Firefox") {
					posTop2 = posTop2 +1;
				}
				$("main_price_layer").style.top = (posTop2) +"px";
				$("main_price_layer").style.visibility = "";
			},300);			

		}else if ($("view").value == "1p"){
			var posLeftTop = Position.cumulativeOffset($("sprice_open_"+modelno));
			var posLeft = posLeftTop[0];
			var posTop = posLeftTop[1];
			top.$("main_price_layer").style.left = (top.$("wrap").offsetWidth - 600) +"px";
			if (BrowserDetect.browser == "Explorer"){
				top.$("main_price_layer").style.top = (posTop + getListFrameTopPos()-5) +"px";
				top.$("main_price_layer_bar").style.top = (posTop + getListFrameTopPos()-5) +"px";
			}else{
				top.$("main_price_layer").style.top = (posTop + getListFrameTopPos()-4) +"px";
				top.$("main_price_layer_bar").style.top = (posTop + getListFrameTopPos()-4) +"px";
			}
			top.$("main_price_layer").style.display = "";
			top.$("main_price_layer").innerHTML = originalRequest.responseText;
			
			var posBarLeft = Position.cumulativeOffset($("goodslist1_div_2_"+modelno))[0];
			var posBarTop = Position.cumulativeOffset($("goodslist1_div_2_"+modelno))[1];
			top.$("main_price_layer_bar").style.width = ($("goodslist1_div_2_"+modelno).offsetWidth+1) +"px"
			top.$("main_price_layer_bar").style.left =  posBarLeft+"px"
			
				
			if (minprice.toString().isnumber()){
				top.$("main_price_layer_bar").innerHTML = "<div style='color:#0000FF;font-family:Arial;font-size:9pt;font-weight:bold;line-height:15px;margin-top:4px;height:15px;width:85px;text-align:right'>"+(minprice+"").NumberFormat() + " <span style='color:#808080;font-family:돋움;font-size:11px;font-weight:normal'>원</span></div>"
			}else{
				top.$("main_price_layer_bar").innerHTML = "<div style='color:#0000FF;font-family:Arial;font-size:9pt;font-weight:bold;line-height:15px;margin-top:4px;height:15px;width:60px;margin-left:27px;'>"+minprice + "</div>"
			}			
			top.$("main_price_layer_bar").style.display = ""; 
			
		}else if($("view").value == "img"){
			var posLeftTop = Position.cumulativeOffset($("goods_image_list_dl_"+modelno));
			var posLeft = posLeftTop[0];
			var posTop = 0;
			if (BrowserDetect.browser == "Explorer" && BrowserDetect.version >= 7 ){
				posTop = posLeftTop[1]+136;
			}else if(BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6 ){
				posTop = posLeftTop[1]+141;
			}else{
				posTop = posLeftTop[1]+140;
			}
			if ((posLeft + 250) > $("wrap").offsetWidth){
				showLog($("goods_image_list_dl_"+modelno).offsetWidth)
				posLeft = (posLeft+$("goods_image_list_dl_"+modelno).offsetWidth)-262;
			}	
			$("main_price_layer").setStyle({'left':posLeft+'px','top':posTop+'px','display':'','width':250+'px','border':'1px solid #F97800','padding':'0px 5px 5px 5px'});
			$("main_price_layer").style.backgroundColor = "#f4e4d4";
			$("main_price_layer").innerHTML = originalRequest.responseText;		
		}		/*
		try {			if (top.document.getElementById('rb_recent_zzim')){				if(top.document.getElementById('rb_recent_zzim').style.display=="none") {					top.today(true);				}			}								} catch(e) {}		*/	}	
}
function hidePricelistLayer(modelno){
	var documentLoc = document.location.href;	if (typeof(modelno) != "undefined"){		if(documentLoc.indexOf("/view/Listbody.jsp")>=0 || documentLoc.indexOf("/view/List.jsp")>=0 || documentLoc.indexOf("/view/Sslist.jsp")>=0) {
			if(top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.document.URL.indexOf("/view/Listbody.jsp")>=0 || top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.document.URL.indexOf("/view/Listbody_Printer.jsp")>=0) {
				if(typeof(top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.getPricelistLayer) == "function") {
					top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.getPricelistLayer(modelno,0,"");
				}
			} else {
				if(typeof(top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.getPricelistToolLayer) == "function") {
					top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.getPricelistToolLayer(modelno,0,"");
				}
			}
		} else if(documentLoc.indexOf("/view/Listbody_Mp3.jsp") >= 0 || documentLoc.indexOf("/view/Listbody_Social.jsp")>=0  || documentLoc.indexOf("/view/Listbody_Handphone.jsp") >= 0 || 				documentLoc.indexOf("/view/Sslist.jsp")>=0 || documentLoc.indexOf("/view/Listmp3.jsp") >= 0 || documentLoc.indexOf("/view/Listhandphone.jsp") >= 0 || 				documentLoc.indexOf("/search/") >= 0  || documentLoc.indexOf("/view/Listprinter.jsp")>=0 ) {
			/*
			if(typeof(top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.getPricelistToolLayer) == "function") {
				top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").contentWindow.getPricelistToolLayer(modelno,0,"");
			}
			*/
			if (top.document.getElementById("main_price_layer")){
				if (top.document.getElementById("main_price_layer").style.display != "none"){
					top.document.getElementById("main_price_layer").style.display = "none";
				}
				if (top.document.getElementById("main_price_layer_bar").style.display != "none"){
					top.document.getElementById("main_price_layer_bar").style.display = "none";
				}				
			}						if (top.document.getElementById("main_price_layer_info").style.display != "none"){				top.document.getElementById("main_price_layer_info").style.display = "none";			}						
		} else if(documentLoc.indexOf("/view/fusion/") >= 0) {			//getPricelistLayerFusion(0,0,"","",modelno);
			if(top.document.getElementById("main_price_layer")){
				top.document.getElementById("main_price_layer").style.display = "none";				if (top.document.getElementById("main_price_layer_info").style.display != "none"){					top.document.getElementById("main_price_layer_info").style.display = "none";				}										
				varPlsno = "";
			}
		}else if (documentLoc.indexOf("/view/SaveGoodsList_2010.jsp")>=0) {
			if (document.getElementById("main_price_layer")){				if (document.getElementById("main_price_layer").style.display != "none"){					document.getElementById("main_price_layer").style.display = "none";				}			}					}else {
			hideAllLayer("pricelist");
		}
	}
}
function getPricelistToolLayer(modelno,porder,cate,minprice,count){
	if(varPlsno!=modelno) {
		hideAllLayer();		/*		if (top.document.getElementById('rb_recent_zzim')){
			top.document.getElementById('rb_recent_zzim').style.display = "none";
		}
		if (top.document.getElementById("rb_buttons")){
			top.document.getElementById("rb_buttons").style.display="";
		}		*/			
	}
	insertLog(408);
	getPricelistToolLayerInner(modelno,porder,cate,minprice,count,2);
}
function getPricelistToolLayerInner(modelno,porder,cate,minprice,count,intPricelistFlag){	pricelist_modelno = modelno;	pricelist_porder = porder;	pricelist_cate = cate;	pricelist_minprice = minprice;	pricelist_count = count;	pricelist_getType = 2;	top.pricelist_modelno = modelno;	top.pricelist_porder = porder;	top.pricelist_cate = cate;	top.pricelist_minprice = minprice;	top.pricelist_count = count;	top.pricelist_getType = 2;		if(varPlsno==modelno && top.$("main_price_layer").style.display=="") {		top.$("main_price_layer").style.display = "none";		if (top.document.getElementById("main_price_layer_info").style.display != "none"){			top.document.getElementById("main_price_layer_info").style.display = "none";		}										return;	}	if (varPlsno){		//$("sprice_open_"+varPlsno).src = var_img_enuri_com + "/2010/images/view/bt_open.gif";		top.$("main_price_layer").style.display = "none";//		top.$("main_price_layer_bar").style.display = "none";	}	if (varPlsno != modelno){//		hideAllLayer();		insertLog('408');		//$("sprice_open_"+modelno).src = var_img_enuri_com + "/2010/images/view/bt_close.gif";		varPlsno = modelno;		// 조건별 상품명을 읽어옴		var condName = "";		if($("goods_more_list_td1_"+modelno)) {			var tempStr = $("goods_more_list_td1_"+modelno).innerHTML;			// 처음 div를 삭제/*			if(tempStr.indexOf(">")>0 && tempStr.length>tempStr.indexOf(">")) {				tempStr = tempStr.substring(tempStr.indexOf(">") + 1);			}			if(tempStr.toUpperCase().indexOf("</DIV>")>0) {				tempStr = tempStr.substring(0, tempStr.toUpperCase().indexOf("</DIV>"));			}*/			try {				var breakPoint = 0;				while(tempStr.indexOf("<")>-1) {					tempStr = tempStr.substring(0, tempStr.indexOf("<")) + tempStr.substring(tempStr.indexOf(">")+1);					breakPoint++;					if(breakPoint>100) break;				}			} catch(e) {}			condName = encodeURIComponent(tempStr);		}		var url = "/include/IncPricelistLayerInner_2010.jsp";		var param = "modelno="+modelno+"&type=tool&cate="+cate+"&porder="+porder+"&intPricelistFlag="+intPricelistFlag+"&condName="+condName;		var getRec = new Ajax.Request(			url,			{				method:'get',parameters:param,onComplete:showPricelistLayerTool			}		);	}else{		//varPlsno = "";		top.$("main_price_layer").style.display = "";	}	function showPricelistLayerTool(originalRequest){		if (originalRequest.responseText.trim().length == 0) {			alert("가격정보가 없습니다.");			$("sprice_open_"+modelno).src = var_img_enuri_com + "/images/view/sprice_btn_open.gif";			return;		}				top.$("main_price_layer").setStyle({'border':'0px solid #000000'});		top.$("main_price_layer").style.display = "";		top.$("main_price_layer").style.width = "205px";		top.$("main_price_layer").innerHTML = originalRequest.responseText;		var posLeftTop = Position.cumulativeOffset($("sprice_open_"+modelno));		try {			posLeftTop = Position.cumulativeOffset($("sprice_open_"+modelno).parentElement.parentElement.parentElement);		} catch(e) {}		var posLeft = posLeftTop[0];		var posTop = posLeftTop[1];		top.$("main_price_layer").style.left = (top.$("wrap").offsetWidth - 720 ) +"px";		if (BrowserDetect.browser == "Explorer"){			top.$("main_price_layer").style.top = (posTop + getListFrameTopPos()-4) +"px";		}else{			top.$("main_price_layer").style.top = (posTop + getListFrameTopPos()-5) +"px";		}		/*		try {			if (top.document.getElementById('rb_recent_zzim')){				if(top.document.getElementById('rb_recent_zzim').style.display=="none") {					top.today(true);				}			}			} catch(e) {}		*/	}}
function getPricelistLayerFusion(modelno,porder,cate,imgurl,pl_no){
	getPricelistLayerFusionInner(modelno,porder,cate,imgurl,pl_no,2);
}
function getPricelistLayerFusionInner(modelno,porder,cate,imgurl,pl_no,intPricelistFlag){
	pricelist_modelno = modelno;
	pricelist_porder = porder;
	pricelist_cate = cate;
	pricelist_imgurl = imgurl;
	pricelist_pl_no = pl_no;
	pricelist_getType = 3;
	top.pricelist_modelno = modelno;
	top.pricelist_porder = porder;
	top.pricelist_cate = cate;
	top.pricelist_imgurl = imgurl;
	top.pricelist_pl_no = pl_no;
	top.pricelist_getType = 3;
	

	if (varPlsno){
		top.document.getElementById("main_price_layer").style.display = "none";
		varPlsno = "";
	}
	if (varPlsno != pl_no){//모하는 조건문??
		insertLog('4344');

		varPlsno = pl_no;
		varListType = "imglist"
		var url = "/include/IncPricelistLayerInner_2010.jsp";
		var param = "modelno="+modelno+"&type=fusion&cate="+cate+"&porder="+porder+"&imgurl="+imgurl+"&pl_no="+pl_no+"&intPricelistFlag="+intPricelistFlag;		if (document.getElementById("goods_image_"+pl_no)){			param = param + ("&pwidth="+document.getElementById("goods_image_"+pl_no).offsetWidth);		}		var getRec = new Ajax.Request(
			url,
			{
				method:'get',parameters:param,onComplete:showPricelistLayer
			}
		);
	}else{
		varPlsno = "";
	}
	function showPricelistLayer(originalRequest){		top.$("main_price_layer").setStyle({'border':'1px solid #000000'});
		if (originalRequest.responseText.trim().length == 0) {
			alert("가격정보가 없습니다.");
			return;
		}
		if(document.getElementById("goods_image_"+pl_no)){
			var posLeftTop = Position.cumulativeOffset(document.getElementById("goods_image_"+pl_no));
			var posLeft = posLeftTop[0];
			var posTop = posLeftTop[1];
		}
		if(BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6 ){
			posLeft = posLeft + 1;
			posTop = posTop + 1;
		}else if(BrowserDetect.browser == "Firefox"){
			posLeft = posLeft + 1;
			posTop = posTop - 20;
		}else if(BrowserDetect.browser == "Chrome"){
			posLeft = posLeft+1;
			posTop = posTop;
		}else if(BrowserDetect.browser == "Safari"){
			posLeft = posLeft+1;
			posTop = posTop;
		}else{
			posLeft = posLeft + 1;
			posTop = posTop - 2;
		}

		var varHeight = top.document.getElementById("wrap").offsetHeight - top.$("enuriMenuFrame").contentWindow.$("enuriListFrame").offsetHeight;

		if(document.getElementById("goods_image_"+pl_no)){
			var varWidth = document.getElementById("goods_image_"+pl_no).offsetWidth;
			top.document.getElementById("main_price_layer").style.width = varWidth+"px";
		}
		top.document.getElementById("main_price_layer").style.backgroundColor = "#FFFFFF";

		top.document.getElementById("main_price_layer").style.backgroundColor = "#FFFFFF";
		top.document.getElementById("main_price_layer").innerHTML = originalRequest.responseText;

		setTimeout(function(){
			if(document.getElementById("goods_image_"+pl_no)){
				top.document.getElementById("main_price_layer").style.left = posLeft+"px";
				top.document.getElementById("main_price_layer").style.top = posTop+varHeight+"px";
			}
			top.document.getElementById("main_price_layer").style.display = "";
		},10);		/*		try {			if (top.document.getElementById('rb_recent_zzim')){				if(top.document.getElementById('rb_recent_zzim').style.display=="none") {					top.today(true);				}			}			} catch(e) {}		*/	}	
}function changeTdFontOver(clickIdx) {	if($("pricelistTd1_"+clickIdx)) {		$("pricelistTd1_"+clickIdx).style.color = "#696969";	}	if($("pricelistTd2_"+clickIdx)) {		$("pricelistTd2_"+clickIdx).style.color = "#FF0000";	}	if($("pricelistTd3_"+clickIdx)) {		$("pricelistTd3_"+clickIdx).style.color = "#FF0000";	}}function changeTdFontOut(clickIdx) {	if($("pricelistTd1_"+clickIdx)) {		$("pricelistTd1_"+clickIdx).style.color = "#000000";	}	if($("pricelistTd2_"+clickIdx)) {		$("pricelistTd2_"+clickIdx).style.color = "#0071E1";	}	if($("pricelistTd3_"+clickIdx)) {		$("pricelistTd3_"+clickIdx).style.color = "#515151";	}}function copy_LINK(param,param_where){	var bResult = window.clipboardData.setData("Text",param);	if (bResult){		if (param_where=="goods" || param_where=="ever_goods" || param_where=="reuse_goods"){			alert("해당 상품의 링크에 필요한 HTML소스가 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");		}	}}function copy_URL(param,param_where){	if (window.clipboardData) { 		var bResult = window.clipboardData.setData("Text",param);		if (bResult){			if (param_where=="goods"  || param_where=="ever_goods" || param_where=="reuse_goods"){				alert("해당 상품의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");			}		}	} else if (window.netscape) { 		try {			netscape.security.PrivilegeManager.enablePrivilege('UniversalXPConnect'); 			var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard); 			if (!clip) return; 			var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable); 			if (!trans) return; trans.addDataFlavor('text/unicode'); 			var str = new Object(); 			var len = new Object(); 			var str = Components.classes['@mozilla.org/supports-string;1'].createInstance(Components.interfaces.nsISupportsString); 			var copytext = address; str.data = copytext; trans.setTransferData('text/unicode',str,copytext.length*2); 			var clipid = Components.interfaces.nsIClipboard; 			if (!clipid) return false;			clip.setData(trans,null,clipid.kGlobalClipboard); 			copy_LINK(param,param_where);		} catch(e) {			//alert("signed.applets.codebase_principal_support를 설정해주세요!\n"+e);			alert("signed.applets.codebase_principal_support를 설정해주세요!");		}	}else{		alert("해당 브라우저에서는 지원하지 않습니다.");	} 	return false;}function go_icon(param_where, iurl, iname) {	var str = "<OBJECT ID='enuri_iconctl' CLASSID='CLSID:4A2C4205-FCA0-48FB-ABD7-D8845E741183' CODEBASE='/common/urllink.CAB#version=1,1,0,25' width=0 height=0>";	str += "<PARAM NAME='icon_url' VALUE='"+iurl+"'>";	str += "<PARAM NAME='icon_txt' VALUE='"+iname+"'>";	str += "<PARAM NAME='icon_name' VALUE='favicon1.ico'>";	str += "<PARAM NAME='icon_img' VALUE='http://img.enuri.gscdn.com/images/icon/favicon1.ico'>";	str += "</OBJECT>";	$("div_blank").innerHTML = str; 	if(enuri_iconctl.icon_name=="favicon1.ico") {		time_id = setTimeout("ActiveX_Finish()", 1000);	}}function ActiveX_Finish(){	alert("바탕화면에 저장되었습니다!");}function showShopLayer(obj, text){	if (document.getElementById("shopGsTxt")){		document.getElementById("shopGsTxt").style.left = (Position.cumulativeOffset($(obj)))[0] + "px";		document.getElementById("shopGsTxt").style.top = ((Position.cumulativeOffset($(obj)))[1]+25) + "px";		document.getElementById("shopGsTxt").innerHTML = "<div style=\"text-align:left;width:234px;height:45px;overflow:hidden;margin:5px 0px 0px 4px;font-family:돋움;font-size:8pt;color:#000000;line-height:13px;\"  align='center'>"+text+"</div>"		document.getElementById("shopGsTxt").style.display = "";	}else{		var  varGsShopMsgObj = document.createElement("DIV");		varGsShopMsgObj.id = "shopGsTxt";		varGsShopMsgObj.style.position = "absolute";		varGsShopMsgObj.style.zIndex=110;		varGsShopMsgObj.style.width="239";		varGsShopMsgObj.style.height="50";		varGsShopMsgObj.style.backgroundImage = "url('http://img.enuri.gscdn.com/images/view/systemimg/Hmall_2_new.png')";		varGsShopMsgObj.style.overflow="hidden";		varGsShopMsgObj.style.left = (Position.cumulativeOffset($(obj)))[0] + "px";		varGsShopMsgObj.style.top = ((Position.cumulativeOffset($(obj)))[1]+25) + "px";		varGsShopMsgObj.style.display="";		varGsShopMsgObj.innerHTML = "<div style=\"text-align:left;width:234px;height:45px;overflow:hidden;margin:5px 0px 0px 4px;font-family:돋움;font-size:8pt;color:#000000;line-height:13px;\"  align='center'>"+text+"</div>"		if (document.getElementById("wrap")){			document.getElementById("wrap").insertBefore(varGsShopMsgObj,null);		}else{			document.body.insertBefore(varGsShopMsgObj,null);		}			}}function hideShopLayer(){	if(document.getElementById("shopGsTxt")) {		if (document.getElementById("shopGsTxt").style.display != "block"){			document.getElementById("shopGsTxt").style.display = "none";		}	}}