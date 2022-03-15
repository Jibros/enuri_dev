
	function getShop(url){
		var shop = ""; 

		if (url.indexOf("11st.co.kr") > -1){
			shop = "11";
		} else if (url.indexOf("gmarket.co.kr") > -1) {
			shop = "gmarket";
		} else if (url.indexOf("auction.co.kr") > -1) {
			shop = "auction";
		} else if (url.indexOf("interpark.com") > -1) {
			shop = "interpark";
		} else if (url.indexOf("hyundaihmall.com") > -1) {
			shop = "hyundaihmall";
		} else if (url.indexOf("gsshop.com") > -1) {
			shop = "gsshop";
		} else if (url.indexOf("lotteimall.com") > -1) {
			shop = "lotteimall";
		} else if (url.indexOf("shinsegaemall.ssg.com") > -1) {
			shop = "shinsegaemall";
		} else if (url.indexOf("homeplus.co.kr") > -1) {
			shop = "homeplus";
		} else if (url.indexOf("cjmall.com") > -1) {
			shop = "cjmall";
		} else if (url.indexOf("ellotte.com") > -1) {
			shop = "ellotte";
		} else if (url.indexOf("lotte.com") > -1) {
			shop = "lotte";
		} else if (url.indexOf("hnsmall.com") > -1) {
			shop = "hnsmall";
		} else if (url.indexOf("nsmall.com") > -1) {
			shop = "nsmall";
		} else if (url.indexOf("wemakeprice.com") > -1) {
			shop = "wemakeprice";
		} else if (url.indexOf("ticketmonster.co.kr") > -1) {
			shop = "ticketmonster";
		} else if (url.indexOf("akmall.com") > -1) {
			shop = "akmall";
		} else if (url.indexOf("emart.ssg.com") > -1) {
			shop = "emart";
		} else if (url.indexOf("dnshop.com") > -1) {
			shop = "dnshop";
		} else if (url.indexOf("galleria.co.kr") > -1) {
			shop = "galleria";
		}
		return shop;
	}

	function getCode(url, shop){
		var code = "";
		if (shop == "11"){
			code = getReplaceCode("prdno=", "&xzone=");
		} else if (shop == "gmarket"){
			code = getReplaceCode("goodscode=", "&GoodsSale=");
		} else if (shop == "auction"){
			code = getReplaceCode("itemno=", "&frm3=");
		} else if (shop == "interpark"){
			code = getReplaceCode("sc.prdno=", "&D1_name=");
		} else if (shop == "hyundaihmall"){
			code = getReplaceCode("slitmcd=", "");
		} else if (shop == "gsshop"){
			code = getReplaceCode("prdid=", "&lseq=");
		} else if (shop == "lotteimall"){
			code = getReplaceCode("goods_no=", "&infw_disp_no_sct_cd=");
		} else if (shop == "shinsegaemall"){
			code = getReplaceCode("itemid=", "&siteNo=");
		} else if (shop == "homeplus"){
			if (url.indexOf("good_id=") > -1) {
				code = getReplaceCode("good_id=", "");	//온라인 마트
			} else if (url.indexOf("i_style=") > -1) {
				code = getReplaceCode("i_style=", "&navi_id=");	//온라인 몰
			}
		} else if (shop == "cjmall"){
			code = getReplaceCode("item_cd=", "&shop_id=");
		} else if (shop == "ellotte"){	
			code = getReplaceCode("goods_no=", "");
		} else if (shop == "lotte"){
			code = getReplaceCode("goods_no=", "");
		} else if (shop == "hnsmall"){
			code = getReplaceCode("goods_code=", "&category_code");
		} else if (shop == "nsmall"){
			code = getReplaceCode("good_id=", "");
		} else if (shop == "wemakeprice"){
			code = getReplaceCode("/adeal/", "URI_REPLACE");
		} else if (shop == "ticketmonster"){
			code = getReplaceCode("/deal/", "URI_REPLACE");
		} else if (shop == "akmall"){
			code = getReplaceCode("goods_id=", "");
		} else if (shop == "emart"){
			code = getReplaceCode("itemid=", "&worldYn=");
		} else if (shop == "dnshop"){
			code = getReplaceCode("pid=", "&CID=");
		} else if (shop == "galleria"){
			code = getReplaceCode("item_id=", "&sale_shop_gubun_code=");
		}
		
		return code;
	}

	function getReplaceCode(strFirstTxt, strLastTxt) {
		strFirstTxt = strFirstTxt.toLowerCase();
		
		var code = "";
		var firstTxtLength = strFirstTxt.length;
		var lowUrl = url;
		var no = lowUrl.toLowerCase().indexOf(strFirstTxt);
		var lastNo = 0;
		
		if ("URI_REPLACE" == strLastTxt) {	/*  /가 상품번호 다음 존재 시 - 위메프, 티몬 */
			var varRepTxt = url.substring(no + firstTxtLength, url.length);
			code = varRepTxt.substring(0, varRepTxt.indexOf("/"));
		} else {	/* 정상적인 URI */
			//var varRepTxt = url.substring(no + firstTxtLength, url.length);
			//var lastCnt = varRepTxt.indexOf("&") > 0 ? varRepTxt.indexOf("&") - 1 : url.length;
			//code = varRepTxt.substring(0, varRepTxt.indexOf("&"));
			lastNo = strLastTxt.length > 0 && url.indexOf(strLastTxt) > 0 ? url.indexOf(strLastTxt) : url.length;

			if (no > 0){
				code = url.substring(no + firstTxtLength, lastNo);
			}
		}
		return code;
	}


	function callBackModelno(modelno){
		var remoteEnuriComUrl = "http://dev.enuri.com/toolbar/index.jsp?modelno="+modelno;
		var varIframeObj = document.createElement("iframe");
		varIframeObj.setAttribute("type", "text/html");
		varIframeObj.setAttribute("src", remoteEnuriComUrl);
		varIframeObj.setAttribute("width", 290);
		varIframeObj.setAttribute("height", 1000);
		varIframeObj.style.position = "absolute";
		varIframeObj.style.left = "0px";
		varIframeObj.style.top = "0px";
		varIframeObj.style.zIndex = 99999;
		/*
		varIframeObj.style.setAttribute("position", "absolute");
		varIframeObj.style.setAttribute("left", 0);
		varIframeObj.style.setAttribute("top", 0);
		*/
		document.body.appendChild(varIframeObj);
	}


	function callBackPlno(pl_no){
		var remoteEnuriComUrl = "http://dev.enuri.com/toolbar/index.jsp?plno="+pl_no;
		var varIframeObj = document.createElement("iframe");
		varIframeObj.setAttribute("type", "text/html");
		varIframeObj.setAttribute("src", remoteEnuriComUrl);
		varIframeObj.setAttribute("width", 290);
		varIframeObj.setAttribute("height", 1000);
		varIframeObj.style.position = "absolute";
		varIframeObj.style.left = "0px";
		varIframeObj.style.top = "0px";
		varIframeObj.style.zIndex = 99999;

		document.body.appendChild(varIframeObj);
	}

	function callBackNoResult(){
		var remoteEnuriComUrl = "http://dev.enuri.com/toolbar/index.jsp";
		var varIframeObj = document.createElement("iframe");
		varIframeObj.setAttribute("type", "text/html");
		varIframeObj.setAttribute("src", remoteEnuriComUrl);
		varIframeObj.setAttribute("width", 290);
		varIframeObj.setAttribute("height", 1000);
		varIframeObj.style.position = "absolute";
		varIframeObj.style.left = "0px";
		varIframeObj.style.top = "0px";
		varIframeObj.style.zIndex = 99999;

		document.body.appendChild(varIframeObj);
	}

	var url = location.href;
	var shop = getShop(url);
	var code = getCode(url, shop);
	
	var remoteGetModelNoUrl = "http://dev.enuri.com/etc/toolbar.jsp?shop="+shop+"&code="+code;
	
	var scriptObj = document.createElement("script");
	scriptObj.setAttribute("type", "text/javascript");
	scriptObj.setAttribute("charset", "utf-8");
	scriptObj.setAttribute("src", remoteGetModelNoUrl);
	document.body.appendChild(scriptObj);
	

	

