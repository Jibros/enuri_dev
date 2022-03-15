function showMoreGoods(modelno){
	if (document.getElementById("more_view_"+modelno).src.indexOf("/2010/images/view/bt_close.gif") >= 0 ){
		var viewObjs = $("goods_more_list_"+modelno).getElementsBySelector('tr[class="hide"]');
		for (i=0;i<viewObjs.length;i++){
			viewObjs[i].style.display = "none";
		}			
		document.getElementById("more_view_"+modelno).src = var_img_enuri_com + "/2010/images/view/bt_group.gif";
		hidePricelistLayer(varPlsno);
	}else{
		var hideObjs = $("goods_more_list_"+modelno).getElementsBySelector('tr[class="hide"]');
		for (i=0;i<hideObjs.length;i++){
			hideObjs[i].style.display = "";
		}
		document.getElementById("more_view_"+modelno).src = var_img_enuri_com + "/2010/images/view/bt_close.gif";
	}
	parent.syncHeightListFrame();
}