function over_view_mode(obj) {
	obj.className = "over";
}
function out_view_mode(obj) {
	obj.className = "out";
}
function cmdSelectShop(shop_code, shop_name) {
	document.getElementById("shop_code").value = shop_code;
	if (document.getElementById("page_chk").value == 0) {
		document.getElementById("enuriListFrame").src = "/sdul/bid/include/Listbody_Bid_Goods.jsp?shop_code="
				+ shop_code
				+ "&order_by="
				+ document.getElementById("order_by").value;
	} else {
		document.getElementById("enuriListFrame").src = "/sdul/bid/include/Listbody_Bid_Goods_Others.jsp?page_chk="
				+ document.getElementById("page_chk").value
				+ "&shop_code="
				+ shop_code
				+ "&order_by="
				+ document.getElementById("order_by").value;
	}
	document.getElementById("divShopSelect").innerHTML = shop_name + "&nbsp;";
	cmdShopLayer();
}
function cmdShopLayer() {
	document.getElementById("divSearchLayer").style.display = "none";
	document.getElementById("divOrderLayer").style.display = "none";
	if (document.getElementById("divShopLayer").style.display == "none") {
		document.getElementById("divShopLayer").style.display = "";
	} else {
		document.getElementById("divShopLayer").style.display = "none";
	}
}
function cmdOrder(order_name, order_by) {
	document.getElementById("order_by").value = order_by;
	if (document.getElementById("page_chk").value == 0) {
		document.getElementById("enuriListFrame").src = "/sdul/bid/include/Listbody_Bid_Goods.jsp?shop_code="
				+ document.getElementById("shop_code").value
				+ "&order_by="
				+ order_by;
	} else {
		document.getElementById("enuriListFrame").src = "/sdul/bid/include/Listbody_Bid_Goods_Others.jsp?page_chk="
				+ document.getElementById("page_chk").value
				+ "&shop_code="
				+ document.getElementById("shop_code").value
				+ "&order_by="
				+ order_by;
	}
	document.getElementById("divOrderSelect").innerHTML = order_name + "&nbsp;";
	cmdOrderLayer();
}
function cmdOrder_body(order_name, order_by) {
	document.getElementById("order_by").value = order_by;
	if (document.getElementById("page_chk").value == 0) {
		document.getElementById("enuriListFrame").src = "/sdul/bid/include/Listbody_Bid_Goods.jsp?shop_code="
				+ document.getElementById("shop_code").value
				+ "&order_by="
				+ order_by;
	} else {
		document.getElementById("enuriListFrame").src = "/sdul/bid/include/Listbody_Bid_Goods_Others.jsp?page_chk="
				+ document.getElementById("page_chk").value
				+ "&shop_code="
				+ document.getElementById("shop_code").value
				+ "&order_by="
				+ order_by;
	}
	document.getElementById("divOrderSelect").innerHTML = order_name + "&nbsp;";
}
function cmdOrderLayer() {
	document.getElementById("divSearchLayer").style.display = "none";
	document.getElementById("divShopLayer").style.display = "none";
	if (document.getElementById("divOrderLayer").style.display == "none") {
		document.getElementById("divOrderLayer").style.display = "";
	} else {
		document.getElementById("divOrderLayer").style.display = "none";
	}
}
function cmdOpenDetailMulti(modelno) {
	// http://stagedev.enuri.com/view/Detailmulti.jsp?modelno=2371168
	/*window.open("/view/Detailmulti.jsp?modelno=" + modelno + "&bidchk=1",
					"detailMultiWin",
					"width=804,height="
							+ window.screen.height
							+ ",left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");*/
	//vip 개편작업
	var detailWin = window.open("/_pre_detail_.jsp");
	detailWin.location.replace("/detail.jsp?modelno="+modelno);
	detailWin.focus();
	
	//window.open("/sdul/bid/include/AjaxBidDeduction.jsp?modelno=" + modelno ,"detailMultiWin","width=100,height=100,left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");

}
function cmdMoveAccountList() {
	document.getElementById("enuriListFrame").src = "/sdul/bid/include/Listbody_Bid_AccountList.jsp";
	document.getElementById("tr_search").style.display = "none";
	document.getElementById("menu_0").className = "style16";
	document.getElementById("menu_1").className = "style16";
	document.getElementById("menu_3").className = "style16";
	document.getElementById("menu_4").className = "style16";
	document.getElementById("menu_5").className = "style16";
}
function cmdMoveBidPage(obj, idx) {
	document.getElementById("menu_0").className = "style16";
	document.getElementById("menu_1").className = "style16";
	document.getElementById("menu_3").className = "style16";
	document.getElementById("menu_4").className = "style16";
	document.getElementById("menu_5").className = "style16";
	obj.className = "style15";

	document.getElementById("divShopLayer").style.display = "none";
	document.getElementById("divShopSelect").innerHTML = "쇼핑몰▼&nbsp;";
	document.getElementById("divOrderLayer").style.display = "none";
	document.getElementById("divOrderSelect").innerHTML = "상품 등록일 순▼&nbsp;";

	if (idx == 0) {
		document.getElementById("enuriListFrame").src = "/sdul/bid/include/Listbody_Bid_Goods.jsp";
		document.getElementById("tr_search").style.display = "";
	} else if (idx == 5) {
		document.getElementById("enuriListFrame").src = "/sdul/bid/include/Listbody_Bid_Effect_Report.jsp";
		document.getElementById("tr_search").style.display = "none";
	} else if (idx == 6) {
		document.getElementById("enuriListFrame").src = "/sdul/bid/include/Listbody_Bid_AccountList.jsp";
		document.getElementById("tr_search").style.display = "none";
	} else {
		document.getElementById("enuriListFrame").src = "/sdul/bid/include/Listbody_Bid_Goods_Others.jsp?page_chk="
				+ idx;
		document.getElementById("tr_search").style.display = "";
	}

	document.getElementById("page_chk").value = idx;

}
function Win(sURL, sName, scrollbars, left, top) {
	var win;
	win = window.open("/sdul/list/Sdul_Member_Modify.jsp", sName,
			"status=no,toolbar=no,resizable=no,scrollbars=" + scrollbars
					+ ",menubar=no, left=" + left + ", top=" + top);
	win.opener.self;
}
function isNumber(form) {
	if (event.keyCode != 13) {
		if ((event.keyCode < 48) || (event.keyCode > 57)) {
			// alert("숫자만 입력하세요.");
			event.returnValue = false;
		}
	}
}
function showPaging() {
	if (document.getElementById("select_paging_group").style.display != "none") {
		document.getElementById("select_paging_group").style.display = "none";
		// cmdAllLayerClose();
	} else {
		// cmdAllLayerClose();
		var posLeftTop = Position.cumulativeOffset($("paging_group_list"));
		document.getElementById("select_paging_group").style.left = posLeftTop[0]
				+ "px";
		document.getElementById("select_paging_group").style.top = posLeftTop[1]
				+ 16 + "px";
		document.getElementById("select_paging_group").style.display = "";
		document.getElementById("img_paging_btn").src = var_img_enuri_com
				+ "/2010/images/view/newdown_close.gif";
	}
}
function hidePaging() {
	if (document.getElementById("select_paging_group")) {
		document.getElementById("select_paging_group").style.display = "none";
	}
}
function cmdSearchSelect(search_name, search_type) {
	document.getElementById("search_type").value = search_type;
	document.getElementById("divSearchSelect").innerHTML = search_name;

	cmdSearchLayer();
}
function cmdSearchLayer() {
	// document.getElementById("divSearchLayer").style.display = "none";
	if(document.getElementById("divShopLayer")){
		document.getElementById("divShopLayer").style.display = "none";
	}
	if(document.getElementById("divOrderLayer")){
		document.getElementById("divOrderLayer").style.display = "none";
	}
	if (document.getElementById("divSearchLayer").style.display == "none") {
		document.getElementById("divSearchLayer").style.display = "";
	} else {
		document.getElementById("divSearchLayer").style.display = "none";
	}
}
function cmdSearch() {
	if (event.keyCode == 13) {
		if(document.getElementById("search_type").value == ""){
			document.getElementById("search_type").value = "goodscode";
		}
		if (document.getElementById("page_chk").value == 0) {
			if (document.getElementById("search_type").value == "goodscode") {
				location.href = "/sdul/bid/include/Listbody_Bid_Goods.jsp?page_chk=0&search_type="
						+ document.getElementById("search_type").value
						+ "&enuri_id_temp="
						+ document.getElementById("enuri_id_temp").value
						+ "&search_keyword="
						+ document.getElementById("txtSearch").value.toLowerCase();
			} else {
				location.href = "/sdul/bid/include/Listbody_Bid_Goods.jsp?page_chk=0&search_type="
						+ document.getElementById("search_type").value
						+ "&enuri_id_temp="
						+ document.getElementById("enuri_id_temp").value
						+ "&search_keyword="
						+ document.getElementById("txtSearch").value.toLowerCase();
			}
		} else {
			if (document.getElementById("search_type").value == "goodscode") {
				location.href = "/sdul/bid/include/Listbody_Bid_Goods.jsp?page_chk=0&enuri_id_temp="
						+ document.getElementById("enuri_id_temp").value
						+ "&search_type="
						+ document.getElementById("search_type").value
						+ "&search_keyword="
						+ document.getElementById("txtSearch").value.toLowerCase();
			} else {
				location.href = "/sdul/bid/include/Listbody_Bid_Goods.jsp?page_chk=0&enuri_id_temp="
						+ document.getElementById("enuri_id_temp").value
						+ "&search_type="
						+ document.getElementById("search_type").value
						+ "&search_keyword="
						+ document.getElementById("txtSearch").value.toLowerCase();
			}
		}
	}
}
function cmdClearInfoLayer() {
	document.getElementById('divInfo_1').style.display = 'none';
	document.getElementById('divInfo_2').style.display = 'none';
	document.getElementById('divInfo_3').style.display = 'none';
	document.getElementById('divInfo_4').style.display = 'none';
}
function cmdOpenInfoLayer(info_id) {
	cmdClearInfoLayer();

	document.getElementById(info_id).style.display = '';
}
