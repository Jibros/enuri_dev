// 이베이 파워클릭 > 쿠팡 애드쇼핑 > 11번가 애드오피스
var powerClickShowCnt = 4; // 오픈쇼핑 광고 노출갯수
var logInit = false; // log() 함수 호출 여부
var logInit_adShopping = false; // 애드쇼핑 로그셋팅
var logInit_adOffice = false; // 애드오피스 로그셋팅

// LP,SRP 최초 호출 함수
// 카테고리, 파워클릭여부, 애드쇼핑여부, 애드오피스여부
function getPowerClick(ca_code, blADPowerClick, blADShopping, blADOffice) {
	
	var dstParam = "";
	
	if (listType == "search") {	/* SRP 호출 */
		dstParam = param_keyword;
	} else { /* LP 호출 */
		
		if(param_tabType==4) {
			return;
		}

		if (param_inKeyword == "") {
			dstParam = param_cate;
		} else {
			dstParam = param_inKeyword;
		}
	}
	loadPowerClick(blADPowerClick, ca_code, dstParam, blADShopping, blADOffice);
}

// 광고 호출
// 중단 광고 : 이베이
function loadPowerClick(blADPowerClick, ca_code, keyword, blADShopping, blADOffice){
	
	// 이베이 광고 호출
	if(blADPowerClick) {
		var varuml = "keyword="+encodeURIComponent(keyword)+"&maxCnt=4&isCate=LP&isPC=PC&cateCode="+ca_code;
		if (listType == "search") {
			varuml = "keyword="+encodeURIComponent(keyword)+"&maxCnt=4&isCate=SRP&isPC=PC&cateCode="+firstGoodsCate;
		}
	
		var ebayPromise = $.ajax({
			type:"GET",
			url: "/ebayCpc/jsp/connectApi2.jsp",
			data:varuml,
			dataType: "JSON"
		});
		
		// 이베이 광고 호출
		ebayPromise.then(function(obj) {
			drawEbay(obj);
		})
	
		// 이벤트 리스너
		ebayPromise.then(function() {
			eventListener_powerClick();
		});
	}
	
	if(blADShopping) {
		initADShopping(blADOffice);
	} else {
		if(blADOffice) {
			initADOffice();
			blAdOfficeFirst = true;
		}
	}
}

// 이베이 마크업 함수
// object : connectApi2 콜백 객체
function drawEbay(object) {
	
	// 마스크 관련 추가 대응 20200305
	if( object.keyword === undefined ) {
		return;
	}
	
	var centerADArray = new Array(); // 중단광고 이베이 배열
	var centerADCnt = 0;
	
	var itemCnt = object.sum_sort.length; // 전체 광고 갯수
	
	for(var i=0;i<itemCnt;i++) {
		centerADArray[centerADCnt] = object.sum_sort[i];
		centerADCnt++;
	}

	// 중단 이베이광고 마크업
	if(viewType==1) {
		if($("li[data-type=adline_powerclick]").length>0) {
			if(centerADArray.length>0) {
				drawEbayCenterAD(centerADArray);
				// 갤러리뷰 형태로 보고 싶으면 drawEbayCenterAD_GalleryView
			}
		}
	}
	if(viewType==2) {
		if(centerADArray.length>0) {
			drawEbayCenterAD_GalleryView(centerADArray);
		}
	}
}

// 파워클릭 - 리스트형
function drawEbayCenterAD(object) {

	$(".ad-openad--list[ad-type=powerclick]").remove();
	
	var cHtml = ""; //Center Html
	
	if(object && object.length>0) {
		var drawCnt = object.length > powerClickShowCnt ? powerClickShowCnt : object.length;
		/* 리스트 4개*/
		for (var i=0; i<drawCnt; i++) {
		
			var varShopcode = object[i].shopcode;		//shopCode
			var varprice = object[i].enuri_price;		//에누리 가격
	
			var varImgS = object[i].imgS;				//작은 사이즈 이미지 주소
			var varimgL = object[i].imgL;				//큰 사이즈 이미지 주소
	
			var varIsAdult = object[i].is_adult;		//성인 여부
	
			var varSalePrice = object[i].sale_price;	//할인 금액
			var varSellPrice = object[i].sell_price;	//판매 금액
	
			var varImpT = object[i].imp_t;			//노출 체크를 위한 태그 정보
			if(varImpT.length>0) {
				impCall(varImpT);
			}
			var varClickT = object[i].clk_t;			//클릭 체크를 위한 태그 정보
	
			var varTitle = object[i].title;			//상품명
			var varShippingFee = object[i].shipping_fee;	//배송비
	
			var varImpPrice = 0;
			var varShipFeeTxt = "무료배송";
			var varShipClass ="deli_free";
			var varShopNm = "";
	
			var varLanding = object[i].landing;
	
			var varOnClickT = " onclick=\"clickEbayForward('" + varClickT + "');\"";
			var varRanUrl = varLanding;
			
			//성인여부 체크
			if (isAdultFlag=="false" && varIsAdult) {
				varimgL = "http://img.enuri.info/images/home/thum_adult.gif";
				varImgS = "http://img.enuri.info/images/home/thum_adult.gif";
			}
			
			//가격 정보 : 에누리 금액 -> 할인 금액 -> 판매 금액 순 노출
			if (varprice > 0) {
				varImpPrice = varprice.format();
			} else if (varSalePrice > 0) {
				varImpPrice = varSalePrice.format();
			} else {
				varImpPrice = varSellPrice.format();
			}
			
			//배송비 노출 정책에 따른 로직 마켓별로 노출 Text 정책이 다름
			if (varShippingFee > 0) {
				varShipClass ="deli";
				if (varShopcode == "536") {	//G마켓
					varShipFeeTxt = "배송비 " + varShippingFee.format();
				} else if (varShopcode == "4027") {	//옥션
					varShipFeeTxt = "조건부무료배송";
				}
			} else {
				varShipFeeTxt = "무료배송";
			}
			
			if (varShopcode == "536") {
				varShopNm = "G마켓";
			} else if (varShopcode == "4027") {
				varShopNm = "옥션";
			}
			
			if (i == 0) {
				cHtml += "<li class=\"ad-openad--list ad_powerclick\" ad-type=\"powerclick\">";
				cHtml += "	<div class=\"comm_ad_tit\">";
				cHtml += "		<em>파워클릭</em>";
				cHtml += "		<span class=\"comm_ad_tx_sub\">광고상품으로 검색결과와 다를 수 있습니다.</span>";
				cHtml += "		<a href=\"https://ad.esmplus.com/Member/SignIn/LogOn\" target=\"_blank\" title=\"새 창에서 열립니다\" class=\"comm_btn_apply\">신청하기</a>";
				cHtml += "	</div>";
				cHtml += "	<ul class=\"ad-openad__list--v2\">";
			}
			
			cHtml += "			<li data-type=\"powerclick\" ad-type=\"ebay\">";
			cHtml += "				<a href=\"" + varRanUrl + "\" target=\"_blank;\" " + varOnClickT + " class=\"ad-openad__link\" rel=\"noopener noreferrer\">";
			//							<!-- 상품카드  오픈쇼핑 -->
			cHtml += "					<div class=\"goods-item\">";
			//								<!-- 썸네일 -->
			cHtml += "						<div class=\"item__thumb\">";
			cHtml += "							<img class=\"lazy\" data-src=\""+varImgS+"\" data-original=\""+ varImgS+"\" onerror=\"this.src='"+noImageStr+"'\" />";
			cHtml += "						</div>";
			cHtml += "						<div class=\"item__box\">";
			//									<!-- 상품정보 -->
			cHtml += "							<div class=\"item__info\">";
			//										<!-- 모델명 -->
			cHtml += "								<div class=\"item__model\">"+varTitle+"</div>";
			cHtml += "							</div>";
			//									<!-- // -->
			//									<!-- 상품가격 : 오픈쇼핑 -->
			cHtml += "							<div class=\"item__price\">";
			//										<!-- 일반상품 / 가격 -->
			cHtml += "								<div class=\"price__mall\">";
			cHtml += "									<div class=\"col--mall\">";
			cHtml += "										<img class=\"lazy\" data-src=\"http://storage.enuri.info/logo/logo20/logo_20_" + varShopcode + ".png\" data-original=\"http://storage.enuri.info/logo/logo20/logo_20_" + varShopcode + ".png\" alt=\""+varShopNm+"\" width=\"76\" height=\"20\" onerror=\"javascript:logoImgNotFound(this);\">";
			cHtml += "									</div>";
			cHtml += "									<div class=\"col--price\">";
			cHtml += "										<em>" + varImpPrice + "</em>원";
			//												<!-- 배송료 -->
			cHtml += "										<div class=\"tx--delivery-label\">";
			if(varShipFeeTxt.indexOf("무료배송")>-1) {
				cHtml += "										<div class=\"tx--delivery\">"+varShipFeeTxt+"</div>";
			} else {
				if ($.isNumeric(varShipFeeTxt)) {
					varShipFeeTxt = numComma(varShipFeeTxt) + "원";
				}
				cHtml += "										<div class=\"tx--delivery--paid\">"+varShipFeeTxt+"</div>";
			}
			cHtml += "										</div>";
			//												<!-- // -->
			cHtml += "									</div>";
			cHtml += "								</div>";
			//										<!-- // -->
			cHtml += "						</div>";
			//								<!-- // -->
			cHtml += "					</div>";
			//							<!-- // -->
			cHtml += "				</a>";
			//						<!-- // -->
			cHtml += "			</li>";
			if ((i+1) == object.length) {
				cHtml += "	</ul>";
				cHtml += "</li>";
			}
		} //for 문 End
		
		if(cHtml != "") {
			$("li[data-type=adline_powerclick]").after(cHtml);
		}
		
	} else {
		$(".plus_area").hide();
	}
}

// 중단 이베이 마크업 - 갤러리뷰
function drawEbayCenterAD_GalleryView(object) {

	if(viewType==1) {
		$(".ad-openad--gird-in-list[data-type=powerclick]").remove();
	} else {
		$(".ad-openad[data-type=powerclick]").remove();
	}
	
	var cHtml = ""; //Center Html
	
	if(object && object.length>0) {
		var drawCnt = object.length > powerClickShowCnt ? powerClickShowCnt : object.length;
		/* 리스트 4개*/
		for (var i=0; i<drawCnt; i++) {
		
			var varShopcode = object[i].shopcode;		//shopCode
			var varprice = object[i].enuri_price;		//에누리 가격
	
			var varImgS = object[i].imgS;				//작은 사이즈 이미지 주소
			var varimgL = object[i].imgL;				//큰 사이즈 이미지 주소
	
			var varIsAdult = object[i].is_adult;		//성인 여부
	
			var varSalePrice = object[i].sale_price;	//할인 금액
			var varSellPrice = object[i].sell_price;	//판매 금액
	
			var varImpT = object[i].imp_t;			//노출 체크를 위한 태그 정보
			if(varImpT.length>0) {
				impCall(varImpT);
			}
			var varClickT = object[i].clk_t;			//클릭 체크를 위한 태그 정보
	
			var varTitle = object[i].title;			//상품명
			var varShippingFee = object[i].shipping_fee;	//배송비
	
			var varImpPrice = 0;
			var varShipFeeTxt = "무료배송";
			var varShipClass ="deli_free";
			var varShopNm = "";
	
			var varLanding = object[i].landing;
	
			var varOnClickT = " onclick=\"clickEbayForward('" + varClickT + "');\"";
			var varRanUrl = varLanding;
			
			//성인여부 체크
			if (isAdultFlag=="false" && varIsAdult) {
				varimgL = "http://img.enuri.info/images/home/thum_adult.gif";
				varImgS = "http://img.enuri.info/images/home/thum_adult.gif";
			}
			
			//가격 정보 : 에누리 금액 -> 할인 금액 -> 판매 금액 순 노출
			if (varprice > 0) {
				varImpPrice = varprice.format();
			} else if (varSalePrice > 0) {
				varImpPrice = varSalePrice.format();
			} else {
				varImpPrice = varSellPrice.format();
			}
			
			//배송비 노출 정책에 따른 로직 마켓별로 노출 Text 정책이 다름
			if (varShippingFee > 0) {
				varShipClass ="deli";
				if (varShopcode == "536") {	//G마켓
					varShipFeeTxt = "배송비 " + varShippingFee.format();
				} else if (varShopcode == "4027") {	//옥션
					varShipFeeTxt = "조건부무료배송";
				}
			} else {
				varShipFeeTxt = "무료배송";
			}
			
			if (varShopcode == "536") {
				varShopNm = "G마켓";
			} else if (varShopcode == "4027") {
				varShopNm = "옥션";
			}
			
			if (i == 0) {
				if(viewType==1) {
					cHtml += "<li class=\"ad-openad--gird-in-list\" ad-type=\"powerclick\" style=\"display:none;\">";
				} else {
					cHtml += "<li class=\"ad--openad\" ad-type=\"powerclick\" style=\"display:none;\">";
				}
				cHtml += "	<div class=\"openad__wrap\">";
				cHtml += "		<div class=\"openad__head\">";
				cHtml += "			<em>파워클릭</em>";
				cHtml += "			<span class=\"openad_ad_tx_sub\">광고상품으로 검색결과와 다를 수 있습니다.</span>";
				cHtml += "			<a href=\"https://ad.esmplus.com/Member/SignIn/LogOn\" target=\"_blank\" title=\"새 창에서 열립니다\" class=\"openad_btn_apply\">신청하기</a>";
				cHtml += "		</div>";
				cHtml += "		<div class=\"openad__body\">";
				cHtml += "			<ul>";
			}
			
			//<!-- 광고 상품 1개  x 4 반복 -->
			cHtml += "					<li data-type=\"powerclick\" ad-type=\"ebay\">";
			cHtml += "						<a href=\"" + varRanUrl + "\" target=\"_blank;\" " + varOnClickT + " class=\"ad-openad__link\"  rel=\"noopener noreferrer\">";
			cHtml += "							<span class=\"openad_thumb\">";
			cHtml += "								<img class=\"lazy\" data-src=\""+varimgL+"\" data-original=\""+ varimgL+"\" onerror=\"this.src='"+noImageStr+"'\" />";
			cHtml += "							</span>";
			cHtml += "							<span class=\"openad_info\">";
			cHtml += "								<span class=\"tx_price\">최저가 <em>"+varImpPrice+"</em>원";
			//											<!-- 배송료 -->
			if(varShipFeeTxt.indexOf("무료배송")>-1) {
				cHtml += "								<div class=\"tx--delivery\">"+varShipFeeTxt+"</div>";
			} else {
				if ($.isNumeric(varShipFeeTxt)) {
					varShipFeeTxt = numComma(varShipFeeTxt) + "원";
				}
				cHtml += "								<div class=\"tx--delivery--paid\">"+varShipFeeTxt+"</div>";
			}
			//											<!-- // -->
			cHtml += "								</span>";
			cHtml += "								<span class=\"tx_name\">"+varTitle+"</span>";
			cHtml += "								<span class=\"tx_mall\"><img class=\"lazy\" data-src=\"http://storage.enuri.info/logo/logo20/logo_20_" + varShopcode + ".png\" data-original=\"http://storage.enuri.info/logo/logo20/logo_20_" + varShopcode + ".png\" alt=\""+varShopNm+"\" onerror=\"javascript:logoImgNotFound(this);\"></span>";
			cHtml += "							</span>";
			cHtml += "						</a>";
			//								<!-- // -->
			cHtml += "					</li>";
			
			
			if ((i+1) == object.length) {
				cHtml += "			</ul>";
				cHtml += "		</div>";
				cHtml += "	</div>";
				cHtml += "</li>";
			}
			
		} // for 문 end
		
		if(cHtml != "" && drawCnt==4) {
			if( $("li.prodItem").length>=8) {
				$("li.prodItem:eq(7)").after(cHtml);
				// 익스플로러 딜레이 방지
				if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
					setTimeout(function() {
						if( $("li[ad-type=powerclick]").length == 0 ) {
							$("li.prodItem:eq(7)").after(cHtml);
							eventListener_powerClick();
						}
					}, 1000);
				}
			}
		}
		
	}
}

function clickEbayForward(clickUrl) {
	//이베이 측 통계를 위해 단순 url 호출(이베이측 요청 - 테스트 페이지에서는 호출이 일어나면 안됨!)
	if(location.href.indexOf("local") > -1 || location.href.indexOf("dev") > -1 || location.href.indexOf("stagedev") > -1 || location.href.indexOf("my.") > -1){
		console.log("test-powerClickAnalysis() : " + clickUrl);
	} else {
		var imgSrc = new Image();
		imgSrc.src = clickUrl; 
	}
}

// 이벤트리스너
function eventListener_powerClick() {

	// 갤러리뷰 4개 안될 경우 미노출
	if(viewType==2) { 
		if($("li[ad-type=ebay]").length==4) {
			$("li.ad--openad").show();
		} else {
			$("li.ad--openad").remove();
		}
	} else if(viewType==1) {
		if($("li[ad-type=ebay]").length==4) {
			$("li.ad-openad--gird-in-list").show();
		} else {
			$("li.ad-openad--gird-in-list").remove();
		}
	}
	
	$("li[data-type=powerclick] img.lazy").lazyload({
		placeholder : noImageStr
	});
	
	logPowerClick(); // 개별로그
}

// 개별로그
function logPowerClick() {
	
	if(!logInit) {
		$(document).on("click", "li[data-type=powerclick]", function() {
			
			var logNum = 0;
			
			if( listType == "list" ) {
				logNum = 21227;
			} else if( listType == "search" ) {
				logNum = 21231;
			}
			
			if(logNum>0) {
				if(param_cate!==undefined && param_cate.length>0) {
					insertLogLSV(logNum, param_cate);
				} else {
					insertLogLSV(logNum);
				}
			}
		});
		logInit = true;
	}
}

// 애드쇼핑 최초 호출 함수
function initADShopping(blADOffice) {
	if($(".prodItem").not(".ad").eq(15).length==0) {
		return false;
	}
	loadADShopping(blADOffice);
}

// 광고 호출
function loadADShopping(blADOffice) {
	var adListType = (listType=="search") ? "srp" : "lp";
	var paramString = "type="+adListType;
	if(adListType=="lp") {
		paramString += "&cate="+param_cate;
	} else if(adListType=="srp") {
		paramString += "&keyword="+encodeURIComponent(param_keyword);
	}
	paramString += "&size=15";
	
	var adShoppingObj = $.ajax({
		type:"GET",
		url: "/wide/api/ad/cpcCoupang.jsp",
		data: paramString,
		dataType: "JSON"
	});
	if(viewType==1) {
		adShoppingObj.then(drawADShopping_List);
	} else if(viewType==2) {
		adShoppingObj.then(drawADShopping_Gallery);
	}
	
	// 이벤트리스너
	adShoppingObj.then(eventListener_ADshopping);

	if(blADOffice) {
		initADOffice();
	}
}

// 애드쇼핑 그리기 - 리스트뷰
function drawADShopping_List(dataObj) {
	
	$(".ad-openad--list[ad-type=adshopping]").remove();
	
	if(dataObj && dataObj.success && dataObj.data.length>0) {
	
		var adHtml = "";
	
		$(dataObj.data).each(function(i, v) {
		
			if(i==4) {
				return false;
			}
		
			if(i==0) {
				adHtml += "<li class=\"ad-openad--list\" ad-type=\"adshopping\">";
				adHtml += "	<div class=\"comm_ad_tit\">";
				adHtml += "		<em>애드쇼핑</em>";
				adHtml += "		<span class=\"comm_ad_tx_sub\">광고상품으로 검색결과와 다를 수 있습니다.</span>";
				adHtml += "	</div>";
				adHtml += "	<ul class=\"ad-openad__list--v2\">";
			}
			
			var vIsRocket = typeof v.isRocket == "undefined" ? false : v.isRocket; 
			adHtml += "<li data-type=\"adshopping\">";
			adHtml += "	<a href=\""+v.landingUrl+"\" class=\"ad-openad__link\" target=\"_blank\" rel=\"noopener noreferrer\">";
			// 				<!-- 상품카드  오픈쇼핑 -->
			adHtml += "		<div class=\"goods-item\">";
			// 					<!-- 썸네일 -->
			adHtml += "			<div class=\"item__thumb\">";
			adHtml += "				<img class=\"lazy\" data-src=\""+v.productImage+"\" data-original=\""+v.productImage+"\" alt=\""+v.productName+"\" width=\"146\" height=\"146\">";
			adHtml += "			</div>";
			//					<!-- // -->
			adHtml += "			<div class=\"item__box\">";
			//						<!-- 상품정보 -->
			adHtml += "				<div class=\"item__info\">";
			//							<!-- 모델명 -->
			adHtml += "					<div class=\"item__model\">"+v.productName+"</div>";
			adHtml += "				</div>";
			//						<!-- // -->
			//						<!-- 상품가격 : 애드쇼핑 -->
			adHtml += "				<div class=\"item__price\">";
			//							<!-- 일반상품 / 가격 -->
			adHtml += "					<div class=\"price__mall\">";
			adHtml += "						<div class=\"col--mall\">";
			//									<!-- 로고형 -->
			adHtml += "							<img class=\"lazy\" data-src=\"http://storage.enuri.info/logo/logo20/logo_20_7861.png\" data-original=\"http://storage.enuri.info/logo/logo20/logo_20_7861.png\" alt=\""+v.productName+"\" width=\"76\" height=\"20\" onerror=\"javascript:logoImgNotFound(this);\">";
			adHtml += "						</div>";
			adHtml += "						<div class=\"col--price\">";
			adHtml += "							<em>"+v.productPrice.format()+"</em>원";
			if(vIsRocket) { //로켓배송여부
				adHtml += "						<div class=\"tx--delivery-label\">";
				adHtml += "							<div class=\"ico--rocket-s12\">로켓배송</div>";
				adHtml += "						</div>";
			}
			adHtml += "						</div>";
			adHtml += "					</div>";
			//							<!-- // -->
			adHtml += "				</div>";
			adHtml += "			</div>";
			adHtml += "		</div>";
			adHtml += "	</a>";
			adHtml += "</li>";
			
			
			if ((i+1) == dataObj.data.length || (i+1)==4 ) {
				adHtml += "	</ul>";
				adHtml += "</li>";
			}
			
		});
		
		if(adHtml != "") {
			// 14위 다음
			$(".prodItem").not(".ad").eq(13).after(adHtml);
		}
	}	
}

// 애드쇼핑 그리기 - 갤러리뷰
function drawADShopping_Gallery(dataObj) {
	
	$(".ad-openad--list[ad-type=adshopping]").remove();
	
	if(dataObj && dataObj.success && dataObj.data.length>0) {
	
		var adHtml = "";
		var drawCnt = dataObj.data.length > 4 ? 4 : dataObj.data.length;
		
		$(dataObj.data).each(function(i, v) {
		
			if(i==4) {
				return false;
			}
		
			if(i==0) {
				adHtml += "<li class=\"ad--openad\" ad-type=\"adshopping\">";
				adHtml += "	<div class=\"openad__wrap\">";
				adHtml += "		<div class=\"openad__head\">";
				adHtml += "			<em>애드쇼핑</em>";
				adHtml += "			<span class=\"openad_ad_tx_sub\">광고상품으로 검색결과와 다를 수 있습니다.</span>";
				adHtml += "		</div>";
				//				<!-- // -->
				adHtml += "		<div class=\"openad__body\">";
				adHtml += "			<ul>";
			}
			
			var vIsRocket = typeof v.isRocket == "undefined" ? false : v.isRocket; 
			
			adHtml += "<li data-type=\"adshopping\">";
			adHtml += "	<a href=\""+v.landingUrl+"\" class=\"ad-openad__link\" target=\"_blank\" rel=\"noopener noreferrer\">";
			adHtml += "		<span class=\"openad_thumb\">";
			adHtml += "			<img class=\"lazy\" data-src=\""+v.productImage+"\" data-original=\""+v.productImage+"\" alt=\""+v.productName+"\" width=\"216\" height=\"216\">";
			adHtml += "		</span>";
			adHtml += "		<span class=\"openad_info\">";
			adHtml += "			<span class=\"tx_price\">최저가 <em>"+v.productPrice.format()+"</em>원";
			if(vIsRocket) { //로켓배송여부
				adHtml += "			<div class=\"ico--rocket-s12\">로켓배송</div>";
			}
			adHtml += "			</span>";
			adHtml += "			<span class=\"tx_name\">"+v.productName+"</span>";
			adHtml += "			<span class=\"tx_mall\">";
			adHtml += "				<img class=\"lazy\" data-src=\"http://storage.enuri.info/logo/logo20/logo_20_7861.png\" data-original=\"http://storage.enuri.info/logo/logo20/logo_20_7861.png\" alt=\""+v.productName+"\" width=\"76\" height=\"20\" onerror=\"javascript:logoImgNotFound(this);\">";
			adHtml += "			</span>";
			adHtml += "		</span>";
			adHtml += "	</a>";
			adHtml += "</li>";
		
			if ((i+1) == dataObj.data.length || (i+1)==4 ) {
				adHtml += "			</ul>";
				adHtml += "		</div>";
				adHtml += "	</div>";
			}
		});
		
		if(adHtml != "" && drawCnt==4) {
			// 5번째 줄
			var adEntryCnt = 15; // eq 16
			$(".prodItem").eq(adEntryCnt).after(adHtml);
			
			// 익스플로러 딜레이 방지
			if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
				setTimeout(function() {
					if( $("li[ad-type=adshopping]").length == 0 ) {
						$(".prodItem").eq(adEntryCnt).after(adHtml);
						eventListener_ADshopping();
					}
				}, 1000);
			}
		}
	}
}

// 애드쇼핑 이벤트리스너
function eventListener_ADshopping() {
	$("li[data-type=adshopping] img.lazy").lazyload({
		placeholder : noImageStr
	});
	
	log_ADshopping();
}

// 애드쇼핑 로그
function log_ADshopping() {
	if(!logInit_adShopping) {
		$(document).on("click", "li[data-type=adShopping]", function() {
			insertLogLSV(24845);
		});
		
		logInit_adShopping = true;
	}
}

// 애드오피스 최초 호출 함수
function initADOffice() {
	if(viewType==1 && $("li[data-type=adline_adoffice]").length==0) {
		return false;
	} else if(viewType==2 && $(".prodItem").length<20) {
		return false;
	}
	loadADOffice();
}

// 애드오피스 API 호출
function loadADOffice() {
	var dstParam = "device=web";
	var param_listType = (listType=="list") ? "lp" : "srp";
	
	dstParam += "&type="+param_listType+"&size=4"
	if(listType=="search") {
		dstParam += "&keyword="+encodeURIComponent(param_keyword);
	} else {
		dstParam += "&cate="+param_cate;
	}
	
	var ad11stPromise = $.ajax({
		type : "get", 
		url : "/lsv2016/ajax/getSponsor11st_ajax.jsp",
		dataType : "json",
		data : dstParam
	});
	
	if(viewType==1) {
		ad11stPromise.then(drawADOffice_List);
	} else if(viewType==2) {
		ad11stPromise.then(drawADOffice_Gallery);
	}
	
	// 이벤트리스너
	ad11stPromise.then(eventListener_ADoffice);
}

// 애드오피스 그리기 리스트뷰
function drawADOffice_List(dataObj) {
	
	$(".ad-openad--list[ad-type=adoffice]").remove();
	
	if(dataObj && dataObj.success && dataObj.data && dataObj.data.length>0) {
		
		var adHtml = "";		
		
		/* 리스트 4개*/
		for (var i=0; i<dataObj.data.length; i++) {
		
			var varShopcode = 5910;		//shopCode
			var varImg = dataObj.data[i].img;	// 이미지 주소
			var varImgAlt = dataObj.data[i].alt;	// 이미지 alt
			var varImpPrice = dataObj.data[i].price;	//판매 금액
			var varTitle = dataObj.data[i].title;			//상품명
			var varImpT = dataObj.data[i].impt;	 // 임프레션 URL
			if(varImpT.length>0) {
				impCall(varImpT);
			}
			var varLanding = dataObj.data[i].curl; // 랜딩 주소
			var varDelivery = dataObj.data[i].delivery; // 배송문구
			var varDiscount = dataObj.data[i].discount; // 할인율
			
			if (i == 0) {
				adHtml += "<li class=\"ad-openad--list\" ad-type=\"adoffice\">";
				adHtml += "	<div class=\"comm_ad_tit\">";
				adHtml += "		<em>애드오피스</em>";
				adHtml += "		<span class=\"comm_ad_tx_sub\">광고상품으로 검색결과와 다를 수 있습니다.</span>";
				adHtml += "		<a href=\"https://adoffice.11st.co.kr/login\" class=\"comm_btn_apply\" target=\"_blank\">신청하기</a>";
				adHtml += "	</div>";
				adHtml += "	<ul class=\"ad-openad__list--v2\">";
			}
			
			adHtml += "			<li data-type=\"adoffice\">";
			adHtml += "				<a href=\"" + varLanding + "\" target=\"_blank;\" class=\"ad-openad__link\" rel=\"noopener noreferrer\">";
			//							<!-- 상품카드  오픈쇼핑 -->
			adHtml += "					<div class=\"goods-item\">";
			//								<!-- 썸네일 -->
			adHtml += "						<div class=\"item__thumb\">";
			adHtml += "							<img class=\"lazy\" data-src=\""+varImg+"\" data-original=\""+ varImg+"\" onerror=\"this.src='"+noImageStr+"'\"  alt=\"" + varImgAlt + "\" />";
			adHtml += "						</div>";
			adHtml += "						<div class=\"item__box\">";
			//									<!-- 상품정보 -->
			adHtml += "							<div class=\"item__info\">";
			//										<!-- 모델명 -->
			adHtml += "								<div class=\"item__model\">"+varTitle+"</div>";
			adHtml += "							</div>";
			//									<!-- // -->
			//									<!-- 상품가격 : 오픈쇼핑 -->
			adHtml += "							<div class=\"item__price\">";
			//										<!-- 일반상품 / 가격 -->
			adHtml += "								<div class=\"price__mall\">";
			adHtml += "									<div class=\"col--mall\">";
			adHtml += "										<img class=\"lazy\" data-src=\"http://storage.enuri.info/logo/logo20/logo_20_" + varShopcode + ".png\" data-original=\"http://storage.enuri.info/logo/logo20/logo_20_" + varShopcode + ".png\" alt=\"11번가\" onerror=\"javascript:logoImgNotFound(this);\">";
			adHtml += "									</div>";
			adHtml += "									<div class=\"col--price\">";
			adHtml += "										<em>"+varImpPrice.format()+"</em>원";
			//												<!-- 배송료 -->
			adHtml += "										<div class=\"tx--delivery-label\">";
			if(varDelivery.indexOf("무료배송")>-1) {
				adHtml += "										<div class=\"tx--delivery\">"+varDelivery+"</div>";
			} else {
				if ($.isNumeric(varDelivery)) {
					varDelivery = numComma(varDelivery) + "원";
				}
				adHtml += "										<div class=\"tx--delivery--paid\">"+varDelivery+"</div>";
			}
			//													<!-- // -->
			adHtml += "										</div>";
			adHtml += "									</div>";
			adHtml += "								</div>";
			//										<!-- // -->
			adHtml += "							</div>";
			//									<!-- // -->
			adHtml += "						</div>";
			//								<!-- // -->
			adHtml += "					</div>";
			//							<!-- // -->
			adHtml += "				</a>";
			//						<!-- // -->
			adHtml += "			</li>";
			//					<!-- // -->
				
			if ((i+1) == dataObj.data.length || (i+1)==4 ) {
				adHtml += "	</ul>";
				adHtml += "</li>";
			}
		} //for 문 End
		
		if(adHtml.length>0) {
			$("li[data-type=adline_adoffice]").after(adHtml);
		}
	}
}

// 애드오피스 그리기 갤러리뷰
function drawADOffice_Gallery(dataObj) {

	$(".ad-openad[ad-type=adoffice]").remove();
	
	if(dataObj && dataObj.success && dataObj.data && dataObj.data.length>0) {
		
		var adHtml = "";
		var drawCnt = dataObj.data.length > 4 ? 4 : dataObj.data.length;
		
		/* 리스트 4개*/
		for (var i=0; i<dataObj.data.length; i++) {
			var varShopcode = 5910;		//shopCode
			var varImg = dataObj.data[i].img;	// 이미지 주소
			var varImgAlt = dataObj.data[i].alt;	// 이미지 alt
			var varImpPrice = dataObj.data[i].price;	//판매 금액
			var varTitle = dataObj.data[i].title;			//상품명
			var varImpT = dataObj.data[i].impt;	 // 임프레션 URL
			if(varImpT.length>0) {
				impCall(varImpT);
			}
			var varLanding = dataObj.data[i].curl; // 랜딩 주소
			var varDelivery = dataObj.data[i].delivery; // 배송문구
			var varDiscount = dataObj.data[i].discount; // 할인율
			
			if (i==0) {
				adHtml += "<li class=\"ad--openad\" ad-type=\"adoffice\" style=\"display:none;\">";
				adHtml += "	<div class=\"openad__wrap\">";
				adHtml += "		<div class=\"openad__head\">";
				adHtml += "			<em>애드오피스</em>";
				adHtml += "			<span class=\"openad_ad_tx_sub\">판매자 상황에 따라 가격이 일치하지 않을 수 있습니다.</span>";
				adHtml += "			<a href=\"https://adoffice.11st.co.kr/login\" class=\"openad_btn_apply\" target=\"_blank\">신청하기</a>";
				adHtml += "		</div>";
				adHtml += "		<div class=\"openad__body\">";
				adHtml += "			<ul>";
			}
			
			//<!-- 광고 상품 1개  x 4 반복 -->
			adHtml += "					<li data-type=\"adoffice\">";
			adHtml += "						<a href=\"" + varLanding + "\" target=\"_blank;\" rel=\"noopener noreferrer\">";
			adHtml += "							<span class=\"openad_thumb\">";
			adHtml += "								<img class=\"lazy\" data-src=\""+varImg+"\" data-original=\""+ varImg+"\" onerror=\"this.src='"+noImageStr+"'\"  alt=\"" + varImgAlt + "\" />";
			adHtml += "							</span>";
			adHtml += "							<span class=\"openad_info\">";
			adHtml += "								<span class=\"tx_price\">최저가 <em>"+varImpPrice.format()+"</em>원";
			//											<!-- 배송료 -->
			if(varDelivery.indexOf("무료배송")>-1) {
				adHtml += "								<div class=\"tx--delivery\">"+varDelivery+"</div>";
			} else {
				if ($.isNumeric(varDelivery)) {
					varDelivery = numComma(varDelivery) + "원";
				}
				adHtml += "								<div class=\"tx--delivery--paid\">"+varDelivery+"</div>";
			}
			//											<!-- // -->
			adHtml += "								</span>";
			adHtml += "								<span class=\"tx_name\">"+varTitle+"</span>";
			adHtml += "								<span class=\"tx_mall\"><img class=\"lazy\" data-src=\"http://storage.enuri.info/logo/logo20/logo_20_" + varShopcode + ".png\" data-original=\"http://storage.enuri.info/logo/logo20/logo_20_" + varShopcode + ".png\" alt=\"11번가\" onerror=\"javascript:logoImgNotFound(this);\"></span>";
			adHtml += "							</span>";
			adHtml += "						</a>";
			//								<!-- // -->
			adHtml += "					</li>";
			
			if ((i+1) == dataObj.data.length || (i+1)==4 ) {
				adHtml += "			</ul>";
				adHtml += "		</div>";
				adHtml += "	</div>";
				adHtml += "</li>";
			}
		} // for 문 end
		
		if(adHtml.length>0 && drawCnt==4) {
			// 8번째 줄
			var adEntryCnt = 23; // eq 24
			$(".prodItem").eq(adEntryCnt).after(adHtml);
			
			// 익스플로러 딜레이 방지
			if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
				setTimeout(function() {
					if( $("li[ad-type=adoffice]").length == 0 ) {
						$(".prodItem").eq(adEntryCnt).after(adHtml);
						eventListener_ADoffice();
					}
				}, 1000);
			}
		}
	}
}

// 애드오피스 이벤트리스너
function eventListener_ADoffice() {
	$("li[data-type=adoffice] img.lazy").lazyload({
		placeholder : noImageStr
	});
	
	// 갤러리뷰 4개 안될 경우 미노출
	if(viewType==2) { 
		if($("li[data-type=adoffice]").length==4) {
			$("li.ad--openad").show();
		} else {
			$("li.ad--openad").remove();
		}
	}
	
	log_ADoffice();
}

// 애드오피스 로그
function log_ADoffice() {
	if(!logInit_adOffice) {
		$(document).on("click", "li[data-type=adoffice]", function() {
			if (listType == "list") {
				insertLogLSV(26632);
			} else if(listType == "search") {
				insertLogLSV(26633);
			}
		});
		logInit_adOffice = true;
	}
}


//impression call
function impCall(impUrl) {
	if(impUrl && impUrl.length>0) {
		$.ajax({
			type: "GET",
			url: impUrl
		});
	}
}