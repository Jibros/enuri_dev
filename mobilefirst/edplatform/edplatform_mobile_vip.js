jq11(document).ready(function()  {  
	getEDPlatformData();
});
 
/*********************************
 EDPlatform으로 부터 Item을 요청 한다. 
**********************************/
function getEDPlatformData(){
	var strQuery = "";													// 광고요청 키워드 or 카테고리  (UTF-8 Encoding 필수)
	var strChannelId = "";											// 광고노출 매체 및 광고노출 페이지를 구별하기 위한 ID 
	var intStartRank = 1;											// 광고목록의 시작 순위 
	var intMaxCount = 2;											// 필요한 광고 갯수. 광고슬롯갯수만큼만 호출	
	var strServerUrl = varEDSearchPage;						// 광고노출 페이지의 URL (UTF-8 Encoding 필수) - 노출대비 클릭 수 확인 위해 필요
	var strUserIp = varEDUserIp;									// 사용자 IP (Encoding 불필요)
//	var strUa = "";														// 사용자 HTTP 헤더의 User-Agent값 - 필수 아님. (UTF-8 Encoding 필수)
	var strReturnType = "json";									// 광고노출 작업을 위한 리턴 타입 (json)
	var strAdType = "";												// 광고요청 분류 srp, lp (SRP일 경우 keyword, LP일 경우 category)
	var strDeviceType = "MOBILE";								// 광고요청 디바이스 (pc/mobile)
	var strIsRecevieAdultInfo = "N";								// 광고 요청 시 성인 상품을 포함해서 받을 것인지 제외시키고 받을 것인지를 구분 default=N (로그인 후 인증 받았을 경우만 Y)

	/**********************************
		EDPlatform ChannelID Protocol 
			D001001001 : SRP - 키워드 검색을 통해 검색 함
			D001002001 : LP  - GNB 카테고리 분류를 클릭하여 검색 함.
	**********************************/

	if (varEDKeyword.length > 0) {
		strQuery = encodeURI(varEDKeyword);
		strAdType = "SRP";
		if(vAppyn == "Y"){
			strChannelId = "E001006002";
		}else{
			strChannelId = "E001006004";
		}
	} else { 
		strQuery = varEDCateCode;
		strAdType = "LP";
		if(vAppyn == "Y"){
			strChannelId = "E001006001";
		}else{
			strChannelId = "E001006003";
		} 
	}
	//Mobile VIP Channel
	//strChannelId = "E001006001";
	
	//E001006001 Mobile 에누리 앱 VIP LP
 	//E001006002 Mobile 에누리 앱 VIP SRP
	//E001006003 Mobile 에누리 웹 VIP LP
	//E001006004 Mobile 에누리 웹 VIP SRP
 
	var varEdReqUrl = "";
	//운영서버일 경우와 테스트 서버일 경우 분리
	if (varEdIsReal) { 
		varEdReqUrl = varEdReqUrl + "http://display.cpcad.enuri.com/adReq?";
	} else { 
		//varEdReqUrl = varEdReqUrl + "http://tdisplay.cpcad.enuri.com:9003/adReq?";
		varEdReqUrl = varEdReqUrl + "http://display.cpcad.enuri.com/adReq?";
		//varEdReqUrl = varEdReqUrl + "http://49.254.179.253:9003/adReq?";	//테스트 도메인 셋팅 완료 후 도메인 변경 호출 
	}    
	  
	/**********************************
		DeviceType이 MOBILE 인 경우 DeviceType 변경
		DeviceType의 Default 값은 PC 임.
	 **********************************/
	if (varEDSearchPage.indexOf("/mobile/") > -1 || varEDSearchPage.indexOf("/mobile2/") > -1 || varEDSearchPage.indexOf("/mobile3/") > -1  
			|| varEDSearchPage.indexOf("/mobilefirst/") > -1 || varEDSearchPage.indexOf("/mobilenew/") > -1 || varEDSearchPage.indexOf("/mobiledepart/") > -1) {
		strDeviceType = "MOBILE";
	}  
	
	/**********************************
		성인 상품 정보를 가져오기 위한 로그인 및 인증 검사
		Default 값은 N 이며, 에누리 로그인 및 본인인증 받는 
		사용자만 성인 상품 정보를 받을 수 있음.
	 **********************************/
	if(varIsAdult == "1") { 
		strIsRecevieAdultInfo = "Y";
	}
	
	varEdReqUrl = varEdReqUrl + "query="+strQuery;
	varEdReqUrl = varEdReqUrl + "&channelId="+strChannelId;
	varEdReqUrl = varEdReqUrl + "&startRank="+intStartRank;
	varEdReqUrl = varEdReqUrl + "&maxCount="+intMaxCount;
	varEdReqUrl = varEdReqUrl + "&serverUrl="+encodeURIComponent(strServerUrl);
	varEdReqUrl = varEdReqUrl + "&userIp="+strUserIp;
	varEdReqUrl = varEdReqUrl + "&returnType="+strReturnType;
	varEdReqUrl = varEdReqUrl + "&adType="+strAdType;
	varEdReqUrl = varEdReqUrl + "&deviceType="+strDeviceType;
	varEdReqUrl = varEdReqUrl + "&isRecevieAdultInfo="+strIsRecevieAdultInfo;

	/********************************** 
		Cross Browser 대안 로직
			- edGetItems.jsp를 통하여 EDPlatform Data를 가져 온다. 
	 **********************************/ 
	//console.log(varEdReqUrl);

	var enuriAccessUrl = "localhost";
	if (varEdIsReal) {
		enuriAccessUrl = "http://m.enuri.com/mobilefirst/edplatform/edGetItems_mobile.jsp"; //운영
	} else { 
		enuriAccessUrl = "http://dev.enuri.com/mobilefirst/edplatform/edGetItems_mobile.jsp"; //데브
	}
	/*
	jq11.ajax({
		type: "POST", 
		url: "/mobilefirst/edplatform/edGetItems_mobile.jsp",
		data: {"url" :varEdReqUrl},
		dataType : "json",
		success : function(data){
			if (data.resultCode == "100" && data.adResultItems.length > 0 && data.itemsCnt > 0) {
				if (strDeviceType == "MOBILE") {
					mobileListHtmlRandering(data);
				} 
			}
		},
		error:  function(request, status, error) {
			console.log("request : " + request + "status : " + status + "error : " + error);
		}
	});
	*/
	
	jq11.ajax({
		type: "POST",
		url: enuriAccessUrl,
		data: {"url" :varEdReqUrl},
		dataType : "json",
		success : function(data){
			if (data.resultCode == "100" && data.adResultItems.length > 0 && data.itemsCnt > 0) {
				if (strDeviceType == "MOBILE") {
					mobileListHtmlRandering(data, strQuery, strAdType);	
				} 
			}
		},
		error:  function(request, status, error) {
			console.log("request : " + request + "status : " + status + "error : " + error);
		}
	});
	

}

/*
모바일  광고 영역 랜더링
*/
function mobileListHtmlRandering (data, strQuery, strAdType) {
	var resultCode = data.resultCode;
	var channelId = data.channelId;
	var itemCnt = data.itemsCnt;
	var reqQuery = data.query;
	
	var itemRank = 0;
	var edItemCd = 0;
	var itemNm = "";
	var itemNm2 = "";
	var itemImg = "";
	var deliveryType = "";
	var price = 0;
	var isAdult = false;
	var shopNm = "";
	var shopCd = 0;
	var cateCd = "";
	var goodsCd = "";
	var itemLpUrl ="";
	var clickUrl = "";
	var isPowerSeller = "";
	var shopImageUrl = "";
	var deliClass = "";
	var deliText = "";
	var plno = "";
	var itemLpUrl ="";

	for (var i=0; i<data.adResultItems.length; i++) {
		var randerUrl = "";
		
		if (varEdIsReal) {
			randerUrl = "http://m.enuri.com/mobilefirst/move.jsp?freetoken=outlink&sb=F&plno="; //운영 : sb=F 로딩 이미지 안 보이도록 함.
		} else { 
			randerUrl = "http://dev.enuri.com/mobilefirst/move.jsp?freetoken=outlink&sb=F&plno="; //데브 : sb=F 로딩 이미지 안 보이도록 함.
		} 
		  
		
		obj = data.adResultItems[i];
		itemRank = obj.itemRank;
		edItemCd = obj.edItemCd;
		itemNm = obj.itemNm;
		
		if ("SRP" == strAdType) { 
			itemNm2 = itemNm.replace(eval("/"+decodeURI(strQuery)+"/gi"), "<b>"+decodeURI(strQuery)+"</b>");
		}else{
			itemNm2 = itemNm;
		}
		
		itemImg = obj.itemImg;
		deliveryType = obj.deliveryType;
		price = numberFormat(obj.price);
		isAdult = obj.isAdult;
		shopNm = obj.shopNm;
		shopCd = obj.shopCd;
		cateCd = obj.cateCd;
		goodsCd = obj.goodsCd;
		itemLpUrl =obj.itemLpUrl;
		clickUrl = obj.clickUrl;
		isPowerSeller = obj.isPowerSeller;
		plno = obj.plno;
		
		shopImageUrl = "http://img.enuri.info/images/board/big/logo_"+shopCd+"b.gif";
		
		if (deliveryType == "F") {
			deliClass = "free";
			deliText = "무료배송";
		} else if (deliveryType == "C") {
			deliClass = "charged";
			deliText = "유료배송";
		} else if (deliveryType == "U") {
			deliClass = "nodel";
			deliText = "비배송";
		}
		
		jq11("#plusLinkGoodsItemCron").clone()
		.attr("id", "plusLinkGoodsItemCron_" + (i+1))
		.insertBefore("#plusLinkGoodsItemCron").hide();
		
		var objItemId = jq11("#plusLinkGoodsItemCron_" + (i+1));
		
 		objItemId
		.find(".thum img").attr("src", itemImg).end() 
		//.find(".name").text(itemNm).end()
		.find(".name").html(itemNm2).end()
		.find(".delivery").addClass(deliClass).text(deliText).end()
		.find(".price em").html(price+"<em>원</em>").end();
		
		if (plno > 0) {
			objItemId
			.find(".best_mall img").attr("src", shopImageUrl).end();
		} else {
			objItemId
			.find(".price span").html("에누리판매가").end()
			.find(".best_mall").html(shopNm).end();
		}
		
		//파워셀러 일 경우에만 이미지 노출  
		if (isPowerSeller) {
			objItemId.find(".best").show();
		} else {
			objItemId.find(".best").hide();
		}   
		
		//랜딩페이지 구현을 위한 plno 유효성 검사.
		if (plno != undefined && plno.length > 0) {
			randerUrl = clickUrl + "&fwUrl="+ encodeURIComponent(randerUrl + plno);
			
			if( getCookie("appYN") == "Y" && (navigator.userAgent.indexOf("iPhone") > 0 || navigator.userAgent.indexOf("iPod") > 0 ||  navigator.userAgent.indexOf("iPad") > 0 )){
				if(shopCd == "536"){
					randerUrl = randerUrl+"&shop=gmarket";	
				}else if(shopCd == "5910"){
					randerUrl = randerUrl+"&shop=11st";	
				}else if(shopCd == "55"){
					randerUrl = randerUrl+"&shop=interpark";	
				}else if(shopCd == "6641"){
					randerUrl = randerUrl+"&shop=ticketmonster";	
				}else if(shopCd == "806"){
					randerUrl = randerUrl+"&shop=cjmall";	
				}else if(shopCd == "75"){
					randerUrl = randerUrl+"&shop=gsshop";	
				}
			} 
			//alert(randerUrl)
			//fwdRendingPg(randerUrl, objItemId); 
		} else {
			//console.log("상품정보가 정상적으로 수신 되지 않았습니다. 관리자에게 문의 하세요. 상품코드 : " + goodsCd);
			randerUrl = clickUrl + "&fwUrl="+ encodeURIComponent(itemLpUrl);
		}   
		
		fwdRendingPg(randerUrl, objItemId); 

		//$('.prodList li:eq('+(i+5)+')').after(objItemId);
		 
		jq11(".pluslink_goods_list").show();
		jq11(".pluslink_tit").show();
		$("#plusLinkGoodsItemCron").hide();
	}  
}   

//랜딩 페이지 호출 : EDPlatform Server에서 클릭율 등 계산 후 Enuri 과금 페이지로 이동하게 된다. 
function fwdRendingPg(url, obj) { 
	obj.click(function() {
		window.open(url, '_blank');  
		//OpenWindowYes(url, "plusLinkItem", 1000, 800);
	});
}

//화폐 3자리수 마다 콤마 보여주기
function numberFormat(num) {
	num += ''; //문자열로 치환
	var pattern = /(-?[0-9]+)([0-9]{3})/;
	while(pattern.test(num)) {
		num = num.replace(pattern,"$1,$2");
	}
	return num;
}

