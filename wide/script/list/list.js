// 속성 정보 호출
loadAttrs();
// 딥링크 시 loadAttrs 호출 완료후 loadGoods 호출
if(!blDeepLink) {
	loadGoods();
}
if (listType == "list") {
	// 네비게이션 호출 nav.min.js
	loadNav(param_cate);
	// 탑배너 호출 listbanner.min.js
	loadLPTopBanner(param_cate);
	// 동의어
	if (Synonym_From == "search" && Synonym_Keyword.length > 0) {
		loadFromSearch();
		insertSearchKeywordLog(Synonym_Keyword); // 로그
	}
	
	if (param_cate.length == 4 || param_cate.length == 6) {
		loadbrandStore(param_cate);
	}
} else if (listType == "search") {
	// 연관검색어
	loadLinkageKeyword();
	insertSearchKeywordLog(param_keyword); // 로그
}
// 리스트 정보 호출
function loadGoods() {
	// 상단탭 비활성화 
	if (listType == "list") {
		$(".category-lp--fine").removeClass("is--disabled");
	}
	$(".adv-search").removeClass("is--disabled");

	//로딩바 불러오기
	loading("show");

	// 탭별 소팅 노출 처리
	// 일반상품, 해외직구는 신제품순, 판매 량순 비노출
	if (param_tabType == 2 || param_tabType == 3) {
		$(".list-filter-bot[data-type=prod] .sortFilter[sorttype=4]").hide();
		$(".list-filter-bot[data-type=prod] .sortFilter[sorttype=5]").hide();
		$(".list-filter-bot[data-type=prod] .sortFilter[sorttype=7]").hide();
	} else {
		if (!blNewListBtnCheck) {
			$(".list-filter-bot[data-type=prod] .sortFilter[sorttype=4]").show();
			$(".list-filter-bot[data-type=prod] .sortFilter[sorttype=5]").show();
		}
		if (blNewListBtnIsset && !blNewListBtnCheck) {
			$(".list-filter-bot[data-type=prod] .sortFilter[sorttype=7]").show();
		}
	}

	// LP 속성은 _는 AND조건, ,는 OR조건
	// ex) spec=3313,205,_6678,3695,3694,
	var $customSpecArray = new Array();
	var $customSpecNameArray = new Array();
	var $customSpec = "";
	var $customSpecName = "";
	var $customTmpString = "";
	var $customTmpNameString = "";
	var $customSpecArrayCount = 0;
	var $customSpecNameArrayCount = 0;

	$("dl.search-box-row[data-attr-type=spec]").each(function(index, item) {
		$customTmpString = "";
		$customTmpNameString = "";
		$(this).find("li.sel").each(function(sub_index, sub_item) {
			if ($customTmpString.length > 0) {
				$customTmpString += ",";
				$customTmpNameString += ",";
			}
			if($(this).attr("data-spec")!==undefined) {
				$customTmpString += $(this).attr("data-spec");
				if($(this).find("button[data-type=smartfinder_button]").length>0) {
					$customTmpNameString += $.trim($(this).find("span.tx_attr").text());
				} else if($(this).find("button[data-type=smartfinder_texthighlight]").length>0) {
					$customTmpNameString += $.trim($(this).find("span.tx_attr").text());
				} else {
					$customTmpNameString += $.trim($(this).find("label").text());
				}
			}
		});
		if ($customTmpString.length > 0) {
			$customSpecArray[$customSpecArrayCount++] = $customTmpString;
		}
		if ($customTmpNameString.length > 0) {
			$customSpecNameArray[$customSpecNameArrayCount++] = $customTmpNameString;
		}
	});
	$customSpec = $customSpecArray.join(",_");
	$customSpecName = $customSpecNameArray.join(",_");

	// 파라미터
	var listParam = {
		"from": listType,
		"device": "pc",
		"category": param_cate,
		"tab": param_tabType,
		"isDelivery": param_isDelivery,
		"isRental": param_isRental,
		"pageNum": param_pageNum,
		"pageGap": param_pageGap,
		"sort": param_sort,
		"factory": encodeURIComponent(param_factory),
		"factory_code": param_factorycode,
		"brand": encodeURIComponent(param_brand),
		"brand_code": param_brandcode,
		"shopcode": param_shopcode,
		"keyword": encodeURIComponent(param_keyword),
		"in_keyword": encodeURIComponent(param_inKeyword),
		"s_price": param_sPrice,
		"e_price": param_ePrice,
		"spec": $customSpec,
		"spec_name": encodeURIComponent($customSpecName),
		"color": param_color,
		"isReSearch": param_isResearch,
		"isTest": (blDevMode) ? "Y" : "N",
		"prtmodelno": param_prtmodelno,
		"isMakeshop": "Y",
		"discount": param_discount,
		"bbsscore" : param_bbsscore
	};

	// 리스트 API 호출
	var listDataPromise = $.ajax({
		type: "POST",
		url: "/wide/api/listGoods.jsp",
		dataType: "json",
		data: listParam
	});

	listDataPromise.then(drawList, failList);

}

// 리스트 정보 그리기
function drawList(dataObj) {
	// 예외처리
	if (dataObj.success === undefined || !dataObj.success) {
		drawNoData(); // 리스트 정보 없을때
		return;
	}
	if (dataObj.data.list === undefined || dataObj.total === undefined) {
		drawNoData(); // 리스트 정보 없을때
		return;
	}

	tmpDataObj = dataObj;

	var listObj = dataObj.data.list;

	if (listObj.length == 0 || dataObj.total == 0) {
		drawNoData(); // 리스트 정보 없을때
		return;
	}

	// 스마트파인더 있을 경우 노출
	if ($(".info_smartfinder").length > 0) {
		$(".info_smartfinder").show();
	}

	// SRP 에서 상품 갯수 표시
	if (listType == "search" && dataObj.total > 0) {
		$("#topAllCntEm").text(dataObj.total.format());
	}
	
	//serchtypeC check
	if (dataObj.data.strKeywordCTypeYN == "Y") {
		drawCtype();
	}

	// 부분검색어 있을때는 부분검색어, 없으면 검색어를 노출
	if (listType == "search") {
		if (dataObj.data.searchedKeyword.length > 0 && param_isResearch == "Y") {
			$(".sr-keyword").text(dataObj.data.searchedKeyword);
		} else {
			$(".sr-keyword").text(param_keyword);
		}

		if (param_isResearch == "N") {
			$(".sr-keyword--info-sub").show();
			$(".category-srp--recom-cate").show();
			$(".adv-search").show();
		}
	}

	// 유사검색어 여부
	if (listType == "search") {
		if (dataObj.data.strFuzzy != "-1" && dataObj.data.strFuzzy != "0") {
			$(".similar-keyword").show();
		} else {
			$(".similar-keyword").hide();
		}
	}

	// isResearch 변경처리
	if (dataObj.data.searchedKeyword.length == 0 && (dataObj.data.strFuzzy == "-1" || dataObj.data.strFuzzy == "0")) {
		param_isResearch = "N";
	} else if (dataObj.data.strFuzzy != "-1" && dataObj.data.strFuzzy != "0") {
		param_isResearch = "Y";
	}
	
	// 해외직구 탭일 경우 카운팅 처리
	if (param_tabType == 3) {
		$("ul.list-filter__tab li").find(".list-tab--count").text("");
		$("ul.list-filter__tab li[tabType=3]").find(".list-tab--count").text(dataObj.total.format());
	} else if (param_tabType < 3) {
		// 필터가 적용되었을 때 상품갯수 표기
		$("ul.list-filter__tab li").find(".list-tab--count").text("");
		if (attrSelCnt > 0 || param_tabType!=0) {
			$("ul.list-filter__tab li[tabType=" + param_tabType + "]").find(".list-tab--count").text(dataObj.total.format());
		} else {
			$("ul.list-filter__tab li[tabType=0]").find(".list-tab--count").text(dataObj.total.format());
			$("ul.list-filter__tab li[tabType=1]").find(".list-tab--count").text(dataObj.data.modelCnt.format());
			$("ul.list-filter__tab li[tabType=2]").find(".list-tab--count").text(dataObj.data.plCnt.format());
		}
	}

	var html = [];
	var hIdx = 0;

	var rank = 1; // 순위 표기용

	// 리스트형 type--list 그리드형 type--grid
	var viewTypeClass = "type--list";
	if (viewType == 1) {
	} else if (viewType == 2) {
		viewTypeClass = "type--grid";
	}

	// 쿠폰 컨텐츠 임시 저장소 ( html 을 동적으로 삽입해야함 )
	var couponContentsObj = new Object();

	// 갤러리뷰 상품메우기 로직을 위해 3위 까지 임의의 class 부여
	var highRankMaxCnt = 3;

	// 파워클릭 그리는 판단자 ( 상품갯수가 8개 이상 일때 true )
	if (dataObj.data.nonAdItemSize >= 8) {
		blADPowerClick = true;
	}

	// 애드쇼핑 그리는 판단자 ( 상품갯수가 16개 이상 일때 true )
	if (dataObj.data.nonAdItemSize >= 16) {
		blADShopping = true;
	}
	
	// 애드오피스 그리는 판단자 ( 상품갯수가 20개 이상 일때 true )
	if (dataObj.data.nonAdItemSize >= 20) {
		blADOffice = true;
	}

	$.each(dataObj.data.list, function(index, item) {

		var strModelName = item.strModelName; // 상품명
		var strCaCode = item.strCate; // 상품의 원 카테고리
		var strExtraPriceTitle = item.strExtraPriceTitle; // 속성 특수가격 구분
		var strExtraPrice = item.strExtraPrice; // 속성 특수가격
		var strDiscountRate = item.strDiscountRate; // 할인율
		var strSpec1 = item.strSpec1; // 속성문구1(용어사전 or 속성)
		var strSpec2 = item.strSpec2; // 속성문구2(태그)
		var strMinPrice = item.strMinPrice; // PC최저가
		var strMinPriceMobileTag = item.strMinPriceMobileTag; // 모바일최저가딱지노출여부
		var strProdStatusTxt = item.strProdStatusTxt; //상품상태문구
		var strMallCnt = item.strMallCnt; // 판매쇼핑몰수
		var strMallCnt3 = item.strMallCnt3; // 판매쇼핑몰수3
		var strCdate = item.strCdate; // 출시일
		var strAdProdFlag = item.strAdProdFlag; // 슈퍼탑 광고상품 여부
		var strModelNo = item.strModelNo; // 최저가모델번호
		var strModelNoRep = item.strModelNoRep; // 대표모델번호
		var strFactory = item.strFactory; // 제조사
		var strFactoryCode = item.strFactoryCode; // 제조사코드
		if(strFactoryCode===undefined) {
			strFactoryCode = "";
		}
		var strBrand = item.strBrand; // 브랜드
		var strBrandCode = item.strBrandCode; // 브랜드코드
		if(strBrandCode===undefined) {
			strBrandCode = "";
		}
		var strPlNo = item.strPlNo; // 상품코드(plno)
		var strImageUrl = item.strImageUrl; // 이미지주소
		var strAdultYN = item.strAdultYN; // 성인상품유무
		var strTip = item.strTip; // 팁 노출문구
		var strBbsNum = item.strBbsNum; // 상품평 갯수
		var strBbsPoint = Math.floor(item.strBbsPoint * 10) / 10; // 상품평 평점
		var strKeywordDTypeYN = item.strKeywordDTypeYN; // 상품 D타입 유무(Y/N)
		var strCouponContents = item.strCouponContents; // 쿠폰문구
		var strShopCode = item.strShopCode; // 쇼핑몰코드
		var strShopName = item.strShopName; // 쇼핑몰명
		var strEventTxt = item.strEventTxt; // 이벤트 문구
		var strEventPrice = item.strEventPrice; // 이벤트 가격
		var strDeliveryInfo = item.strDeliveryInfo; // 배송 문구
		var strLandUrl = item.strLandUrl; // 상품 링크 주소
		var optionViewType = item.optionViewType; // 옵션유형 ( model : 그룹모델 , shop : 쇼핑몰정보 , 없음 : 비노출 )
		var strOpenExpectFlag = item.strOpenExpectYN; // 출시예정 유무
		var strDiscountRate = item.strDiscountRate; // 할인율
		var strMakeshopID = item.strMakeshopID;

		if (optionViewType == "" || optionViewType === undefined) {
			optionViewType = "shop";
		}
		var groupModel = item.groupModel; // 그룹모델(옵션) 정보
		var strSpec3 = item.strSpec3; //소모품 속성 
		var relProdV2Obj = item.relProdV2Obj; // 연관상품
		
		var strVideoYN = item.strVideoYN; // 비디오 포함여부
		var strPromotionUrl = item.strPromotionUrl; // 프로모션 링크 주소
		var strPromotionShopName = item.strPromotionShopName; // 프로모션 쇼핑몰 이름
		var strZzimYN = item.strZzimYN;
		// 모델상품 중 찜표기가 되어있으면 저장한다. ( 레이어 표현 위해 ) 
		if (strZzimYN == "Y" && strModelNo != "") {
			zzimLayerSet.add(strModelNo);
		}
		
		// 성과측정 용 순위 정보
		var strTotRank = item.strTotRank;

		/* -- ~Attr 은 유동적을 관리, 폐기될수 있음 */
		var priceAttr = item.priceAttr; // 가격 속성 
		var iconAttr = item.iconAttr; // 아이콘 속성
		var adAttr = item.adAttr; // 광고 속성
		var lpEtcAttr = item.lpEtcAttr; // LP 개별카테고리 속성 

		// 모델번호 저장
		if (strModelNo != "0") {
			modelNoSet.add(strModelNo);
		} else if (strPlNo != "0") {
			plNoSet.add(strPlNo);
		}

		// srp 일 경우 1등 상품의 카테고리를 저장한다. 
		if (listType == "search" && index == 0) {
			firstGoodsCate = strCaCode;
		}

		// 상품 Data-id 세팅, 대표모델 세팅
		var dataId = "";
		var dataOrigin = 0;
		var dataType = "model";
		if (item.prodType == "P") {
			dataId = "pl_" + strPlNo;
			dataType = "pl";
		} else if(item.prodType == "G") {
			dataId = "model_" + strModelNo;
			if (adAttr.groupImage !== undefined) {
				if (adAttr.groupImage.modelno !== undefined && adAttr.groupImage.modelno.length > 0 && adAttr.groupImage.url !== undefined && adAttr.groupImage.url.length > 0) {
					adImageADModelNo = adAttr.groupImage.modelno;
					adImageADModelImageUrl = adAttr.groupImage.url;
					var groupAdObject = {};
					groupAdObject.modelno = adImageADModelNo;
					groupAdObject.url = adImageADModelImageUrl;

					groupModel.groupImage = groupAdObject;
				}
			}
			modelNoGroupMap.set(strModelNo, groupModel);
		} else if (item.prodType == "M") {
			dataType = "makeshop";
			dataId = "makeshop_" + strMakeshopID;
		}
		
		if (item.prodType == "G" && strModelNoRep !== undefined && strModelNoRep.length > 0) {
			dataOrigin = strModelNoRep;
		}

		if (viewType == 1) {
			$(".goods-list").empty().append("<div class=\"goods-cont\"><ul class=\"goods-bundle\"></ul></div>");
		} else if (viewType == 2) {
			$(".goods-list").empty().append("<div class=\"goods-cont\"><ul class=\"goods-bundle\"></ul><div class=\"goods-option-bundle\" style=\"display:none;\"><div class=\"goods-option\"></div></div></div>");
		}
		$(".goods-cont").addClass(viewTypeClass); // 뷰타입 설정

		var supertopNos = dataObj.data.supertopADNos; // 슈퍼탑 광고 번호

		var prodAddClass = "";
		if (strModelNo != "0" && item.strAdProdFlagYN == "Y") {
			prodAddClass += " ad";
		}

		if (viewType == 2) {
			if (param_tabType == 0 || param_tabType == 1) {
				if (item.strAdProdFlagYN == "N" && highRankMaxCnt > 0 && (dataObj.data.nonAdItemSize <= param_pageGap)) {
					prodAddClass += " highrank";
					highRankMaxCnt--;
				}
			} else {
				if (highRankMaxCnt > 0 && (dataObj.data.nonAdItemSize <= param_pageGap)) {
					prodAddClass += " highrank";
					highRankMaxCnt--;
				}
			}
		}

		// <!-- 리스트형 : 반복 -->
		// 슈퍼탑 상품은 비노출 , supertop.js 에서 처리
		if (strModelNo != "0") {
			if (item.strAdProdFlagYN == "Y") {
				// ad 클래스 생성, 슈퍼탑 그릴때 .ad-supertop 으로 이동.
				html[hIdx++] = "<li class=\"prodItem" + prodAddClass + "\" data-type=\"" + dataType + "\" data-id=\"" + dataId + "\" data-model-origin=\"" + dataOrigin + "\" data-cate=\"" + strCaCode + "\" data-factory=\"" + strFactory.toUpperCase() + "\" data-viewtype=\"" + optionViewType + "\" data-all-rank=\""+strTotRank+"\" style=\"display:none\">"; // 일단 비노출 처리
			} else {
				html[hIdx++] = "<li class=\"prodItem" + prodAddClass + "\" data-type=\"" + dataType + "\" data-id=\"" + dataId + "\" data-model-origin=\"" + dataOrigin + "\" data-cate=\"" + strCaCode + "\" data-factory=\"" + strFactory.toUpperCase() + "\" data-viewtype=\"" + optionViewType + "\" data-all-rank=\""+strTotRank+"\">";
			}
		} else {
			html[hIdx++] = "	<li class=\"prodItem" + prodAddClass + "\" data-type=\"" + dataType + "\" data-id=\"" + dataId + "\" data-viewtype=\"" + optionViewType + "\" data-all-rank=\""+strTotRank+"\">";
		}

		/*--------------------------- 리스트형 ------------------------------------*/
		if (viewType == 1) {

			// 모델상품
			if (item.prodType == "G") {

				// 					<!-- 리스트형 : 가격비교 > Full Case -->
				html[hIdx++] = "	<div class=\"goods-item\">";
				//						<!-- 썸네일 -->
				html[hIdx++] = "		<div class=\"item__thumb\">";
				// 							<!-- 히트 브랜드 (기존유지)-->
				if (adAttr.hitbrand !== undefined) {
					html[hIdx++] = "		<span class=\"badge_hitbrand\">히트브랜드</span>";
				}
				//							<!-- // -->
				html[hIdx++] = "			<a href=\"/detail.jsp?modelno=" + strModelNo + "\" target=\"_blank\">";
				html[hIdx++] = "				<img src=\"" + strImageUrl + "\" onerror=\"this.src='" + noImageStr + "'\" alt=\"" + strModelName + "\">";
				// 								<!-- 태그 / 기존 마크업 유지 -->
				html[hIdx++] = "				<div class=\"img_tag_v2\">";
				// 									<!-- 타입 A : 기존 태그 -->
				// list_func.js setListImageInIconSet() 에서 호출 
				html[hIdx++] = "				</div>";
				// 								<!-- // -->
				html[hIdx++] = "			</a>";

				// 							<!-- 동영상/찜/비교/크게보기 -->
				html[hIdx++] = "			<div class=\"item__menu\">";
				html[hIdx++] = "				<div class=\"item__menu__inner\">";
				// 									<!-- 버튼 : 동영상 -->

				if (strVideoYN == "Y") {
					html[hIdx++] = "				<button class=\"item__btn--movie\" title=\"동영상 보기\" onclick=\"javascript:loadThumNail(" + strModelNoRep + ",1);\"><i class=\"ico-item--movie lp__sprite\">동영상 보기</i></button>";
				}
				//									<!-- 버튼 : 이미지 크게보기 -->
				if (!(strAdultYN == "Y" && isAdultFlag == "false")) { // 성인상품이면서 성인인증을 받지 않은 경우를 제외하고 돋보기 노출 
					html[hIdx++] = "				<button class=\"item__btn--view\" title=\"크게보기\" onclick=\"javascript:loadThumNail(" + strModelNoRep + ");\"><i class=\"ico-item--view lp__sprite\">크게보기</i></button>";
				}
				//									<!-- 버튼 : 비교하기 -->
				html[hIdx++] = "					<button class=\"item__btn--compare\" title=\"상품비교\" ><i class=\"ico-item--compare lp__sprite\">상품비교</i></button>";
				//									<!-- 버튼 : 찜하기 -->
				//									<!-- 찜된 상품 .is--on -->
				if ((strZzimYN == "Y" && !zzimTmpModelNoRemoveSet.has(strModelNo)) || zzimTmpModelNoSet.has(strModelNo)) {
					html[hIdx++] = "					<button class=\"item__btn--zzim is--on\" title=\"찜\" data-zzimno=\"G" + strModelNo + "\" onclick=\"showLayZzim_list(this);return false;\"><i class=\"ico-item--zzim lp__sprite\">찜</i></button>";
				} else {
					html[hIdx++] = "					<button class=\"item__btn--zzim\" title=\"찜\" data-zzimno=\"G" + strModelNo + "\" onclick=\"showLayZzim_list(this);return false;\"><i class=\"ico-item--zzim lp__sprite\">찜</i></button>";
				}
				html[hIdx++] = "				</div>";
				html[hIdx++] = "			</div>";
				// 							<!-- // -->
				html[hIdx++] = "		</div>";
				// 						<!-- // -->
				html[hIdx++] = "		<div class=\"item__box\">";
				//							<!-- 상품정보 -->
				html[hIdx++] = "			<div class=\"item__info\">";
				//								<!-- 모델명 -->
				html[hIdx++] = "				<div class=\"item__model\">";
				
				// 순위 ( 1페이지, 인기순 일때만 ) rank
				if (param_pageNum == 1 && param_sort == "1" && item.strAdProdFlagYN == "N") {
					html[hIdx++] = "				<span class=\"tag--rank\">" + (rank++) + "</span>";
				}
				
				// sr #45776 [PC] LP/SRP > 심플리스트 > 특정카테고리 그룹모델 VIP 발생 로직 변경
				// 심플리스트뷰의 그룹모델 상품명 클릭 시 지정 그룹조건의 VIP로 랜딩
				if (listType == "list" && param_cate.substring(0, 4) == "2401" && groupModel.list !== undefined) {
					var tmpModelNo = changeModelNumber2401(strModelNo, groupModel.list);
					html[hIdx++] = "				<a href=\"/detail.jsp?modelno=" + tmpModelNo + "\" target=\"_blank\" data-type=\"modelname\">" + strModelName + "</a>";
				} else {
					html[hIdx++] = "				<a href=\"/detail.jsp?modelno=" + strModelNo + "\" target=\"_blank\" data-type=\"modelname\">" + strModelName + "</a>";
				}

				//	case 1. <!-- 브랜드관 --> 미사용 <span class="tag--brand lp__sprite">브랜드관</span>
				//	case 2. <!-- 쇼핑몰 추가할인 -->
				if (strPromotionUrl != undefined && strPromotionShopName != undefined && strPromotionUrl != "" && strPromotionShopName != "") {
					html[hIdx++] = "				<a href=\"" + strPromotionUrl + "\" target=\"_blank\" class=\"tag--discount\"><i class=\"ico-tag-enuri lp__sprite\"></i>" + strPromotionShopName + " 추가할인</a>";
				}
				if (item.strAdProdFlagYN == "Y") {
					html[hIdx++] = "				<span class=\"tag--ad\">AD</span>";
				}
				html[hIdx++] = "				</div>";
				// 								<!-- 카피문구 -->
				// 								<!-- '/'' 구분자는 li태그에 자동으로 붙습니다 -->
				//								<!-- 상세검색 매칭되는 속성은 em태그로 감사주세요 -->
				if (strTip && strTip.length > 0) {
					strTip = strTip.split("▶").join("");
					html[hIdx++] = "			<div class=\"item__tx--copy\">" + strTip + "</div>";
				}
				// 								<!-- 속성/용어사전 -->
				if (strSpec1 && strSpec1.length > 0) {
					html[hIdx++] = "			<ul class=\"item__attr\">";
					
					// 출시가/할인율
					if(strExtraPrice && strExtraPrice.length > 0 && strExtraPriceTitle && strExtraPriceTitle.length > 0) {
						if(strDiscountRate && strDiscountRate.length>0) {
							html[hIdx++] = "		<li>"+strExtraPriceTitle+":"+strExtraPrice+"원<strong>("+strDiscountRate+"%↓)</strong></li>";
						} else {
							html[hIdx++] = "		<li>"+strExtraPriceTitle+":"+strExtraPrice+"원</li>";
						}
						if(strSpec1.length>0) {
							html[hIdx++] = "		<em>|</em>";
						}
					}
					
					html[hIdx++] = makerSpecTagDic(strSpec1);
					html[hIdx++] = "			</ul>";
				} else if(strExtraPriceTitle && strExtraPriceTitle.length > 0) {
					html[hIdx++] = "			<ul class=\"item__attr\">";
					html[hIdx++] = "				<li>"+strExtraPriceTitle+": "+strExtraPrice+"원 ";
					if(strDiscountRate && strDiscountRate.length>0) {
						html[hIdx++] = "				<strong>("+strDiscountRate+"%↓)</strong>";
					}
					html[hIdx++] = "				</li>";
					html[hIdx++] = "			</ul>";
				}
				
				//<!-- 대괄호속성 --> or 소모품
				if (strSpec2 && strSpec2.length > 0) {
					html[hIdx++] = "			<div class=\"item__summ\">";
					if (strSpec2.length > 0 ) { //대괄호 속성
						html[hIdx++] = "				 " + makeSpecTagBig(strSpec2) + "";
					} 
					html[hIdx++] = "			</div>";
				}
				//								<!-- 컨텐츠 -->
				// getModelsEventInfo_ajax2 : 뉴스, 브랜드관, 이벤트, 특가, 사용기
				// getKnowBoxFlashReview_ajax : 리뷰
				html[hIdx++] = "				<div class=\"item__cont\"></div>";
				//								<!-- 성분 / 등급 / 자재,착석감 등 -->
				html[hIdx++] = "				<div class=\"item__addinfo\">";
				//									<!-- 화장품 전성분 UI -->
				if (lpEtcAttr.cosmetic) {
					html[hIdx++] = "				<div class=\"lpcosmetics\">";
					html[hIdx++] = "					<div class=\"lpcosmetics__inner\">";
					html[hIdx++] = "						<h2 class=\"lpcosmetics__label\">";
					html[hIdx++] = "							<a href=\"javascript:void(0);\" class=\"btn--dic\" onclick=\"$(this).siblings('.lay-cosmetics-box').toggle();return false;\">피부타입별 적합도</a>";
					//											<!-- 레이어 팝업 -->
					html[hIdx++] = "							<div class=\"lay-cosmetics-box lay-comm\" style=\"display:none\">";
					html[hIdx++] = "								<div class=\"lay-comm--head\">";
					html[hIdx++] = "									<strong class=\"lay-comm__tit\">피부타입별 적합도</strong>";
					html[hIdx++] = "								</div>";
					html[hIdx++] = "								<div class=\"lay-comm--body\">";
					html[hIdx++] = "									<div class=\"lay-comm--inner\">";
					html[hIdx++] = "										<img src=\"http://img.enuri.info/images/home/lp_modal_cosmeticinfo.jpg\" alt=\"각 피부타입 별 좋은 성분과 주의 성분 수를 비교했습니다. 본인의 피부타입에 적합한 제품인지 확인해보세요.\">";
					html[hIdx++] = "									</div>";
					html[hIdx++] = "								</div>";
					//												<!-- 버튼 : 레이어 닫기 -->
					html[hIdx++] = "								<button class=\"lay-comm__btn--close comm__sprite\" onclick=\"$(this).parent().hide()\">레이어 닫기</button>";
					//												<!-- // -->
					html[hIdx++] = "							</div>";
					//											<!-- // -->
					html[hIdx++] = "						</h2>";
					if (lpEtcAttr.cosmetic.value) {
						html[hIdx++] = "					<ul class=\"lpcosmetics__list\">";
						$.each(lpEtcAttr.cosmetic.value, function(index, listData) {
							html[hIdx++] = "					<li>";
							html[hIdx++] = "						<span class=\"lpcosmetics__tit\">" + listData.cpt_goodness + "</span>";
							html[hIdx++] = "							<div class=\"watergraph\">";
							html[hIdx++] = "								<em class=\"watergraph data data" + Math.round(listData.cpt_goodness_percent_gage / 10) * 10 + "\">" + listData.cpt_goodness_percent_gage + "%</em>";
							html[hIdx++] = "							</div>";
							html[hIdx++] = "					</li>";
						});
						html[hIdx++] = "					</ul>";
					}
					html[hIdx++] = "					</div>";
					html[hIdx++] = "				</div>";
				}
				//									<!-- // -->
				//									<!-- 가구 속성 -->
				if (lpEtcAttr.furniture) {
					html[hIdx++] = "				<div class=\"lpfurniture\">";

					$.each(lpEtcAttr.furniture, function(index, listData) {
						var attribute_id = listData["attribute_id"];
						var attribute_element_id = listData["attribute_element_id"];
						var attribute_element = listData["attribute_element"];
						var attribute_title = listData["title"];
						var attribute_type = listData["type"];
						if (attribute_type == 1) {
							//							<!-- 자재등급.grade--01 -->
							html[hIdx++] = "			<div class=\"lpfurniture__grade grade--01\">";
							html[hIdx++] = "				<div class=\"lpfurniture__tit\"><a href=\"javascript:void(0);\" class=\"btn--dic\" data-attr_id=\"" + attribute_id + "\" data-attr_el_id=\"0\" onclick=\"showDicLayer(this);return false;\" title=\"클릭 시 용어사전\">자재등급</a></div>";
							html[hIdx++] = "				<div class=\"lpfurniture__level level--" + attribute_element.toLowerCase() + "\"></div>";
							html[hIdx++] = "			</div>";
							//							<!-- // -->
						} else if (attribute_type == "2") {
							//							<!-- 쿠션감 / 착석감 .grade--2 -->  att_txt_211331_0
							html[hIdx++] = "			<div class=\"lpfurniture__grade grade--02\">";
							html[hIdx++] = "				<div class=\"lpfurniture__tit\"><a href=\"javascript:void(0);\" class=\"btn--dic\" data-attr_id=\"" + attribute_id + "\" data-attr_el_id=\"0\" onclick=\"showDicLayer(this);return false;\" title=\"클릭 시 용어사전\">착석감</a></div>";
							// <!-- <div class="lpfurniture__tit"><a href="#" onclick="showDicLayer(this);return false;" title="클릭 시 용어사전">착석감</a></div> -->
							html[hIdx++] = "				<div class=\"lpfurniture__level level--0" + attribute_element_id + "\"></div>";
							html[hIdx++] = "			</div>";
							//							<!-- // -->
						}
					});
					html[hIdx++] = "				</div>";
					//								<!-- // -->
				}
				html[hIdx++] = "				</div>";
				//								<!-- // -->
				//								<!-- 기타 -->
				html[hIdx++] = "				<div class=\"item__etc\">";
				html[hIdx++] = "					<ul>";
				//										<!-- 상품평/평점 -->
				html[hIdx++] = "						<li class=\"item__etc--score\">";
				if (strModelNo != "0") {
					html[hIdx++] = "						<a href=\"/detail.jsp?modelno=" + strModelNo + "&focus=bbs\" target=\"_blank\">";
					if (strBbsPoint != "0" && strBbsPoint != "0.0") {
						html[hIdx++] = "						<i class=\"ico-etc-star lp__sprite\"></i><strong>" + strBbsPoint + "점</strong> (" + strBbsNum.format() + ")";
					} else if (strBbsNum != "0") {
						html[hIdx++] = "상품평 ("+strBbsNum.format() + ")";
					}
					html[hIdx++] = "						</a>";
				} else {
					if (strBbsPoint != "0" && strBbsPoint != "0.0") {
						html[hIdx++] = "					<i class=\"ico-etc-star lp__sprite\"></i><strong>" + strBbsPoint + "점</strong> (" + strBbsNum.format() + ")";
					} else if (strBbsNum != "0") {
						html[hIdx++] = "상품평 ("+strBbsNum.format() + ")";
					}
				}
				html[hIdx++] = "						</li>";
				//										<!-- 등록일 -->
				if (strCdate.length > 0 && strCdate.length == 8) {
					html[hIdx++] = "					<li class=\"item__etc--date\">등록일 " + strCdate.substring(0, 4) + "." + strCdate.substring(4, 6) + "</li>";
				}
				// 										<!-- 브랜드/제조사 모아보기 --> 제조사 1 브랜드 2
				if (listType == "list") {
					if (lpSetupInfo.sf_factory_viewYN == "Y" || lpSetupInfo.sf_factory_viewYN == "Y" && strFactory.length > 0 && strFactoryCode.length > 0) { 
						html[hIdx++] = "				<li class=\"item__etc--brand\"><a href=\"javascript:void(0);\" class=\"btn--view-brand\" viewtype=\"factory\" searchtext=\"" + strFactory + "\" searchcode=\"" + strFactoryCode + "\" >" + strFactory + "<i class=\"ico-etc-sr lp__sprite\"></i></a></li>";
					} else if (lpSetupInfo.sf_brand_viewYN == "" || lpSetupInfo.sf_brand_viewYN == "Y" && strBrand.length > 0 && strBrandCode.length > 0) {
						html[hIdx++] = "				<li class=\"item__etc--brand\"><a href=\"javascript:void(0);\" class=\"btn--view-brand\" viewtype=\"brand\" searchtext=\"" + strBrand + "\" searchcode=\"" + strBrandCode + "\">" + strBrand + "<i class=\"ico-etc-sr lp__sprite\"></i></a></li>";
					}
				} else if (listType == "search") {
					if (strFactory.length > 0) {
						html[hIdx++] = "				<li class=\"item__etc--brand\"><a href=\"javascript:void(0);\" class=\"btn--view-brand\" viewtype=\"factory\" searchtext=\"" + strFactory + "\" searchcode=\"" + strFactoryCode + "\" >" + strFactory + "<i class=\"ico-etc-sr lp__sprite\"></i></a></li>";
					} else if (strBrand.length > 0) {
						html[hIdx++] = "				<li class=\"item__etc--brand\"><a href=\"javascript:void(0);\" class=\"btn--view-brand\" viewtype=\"brand\" searchtext=\"" + strBrand + "\" searchcode=\"" + strBrandCode + "\" >" + strBrand + "<i class=\"ico-etc-sr lp__sprite\"></i></a></li>";
					}
				}
				html[hIdx++] = "					</ul>";
				html[hIdx++] = "				</div>";
				
				if (relProdV2Obj != undefined && relProdV2Obj.modelNo != undefined) {
					if (relProdV2Obj.modelNo.length > 0) {
						var vRelProdCnt = relProdV2Obj.cnt;
						var vRelProdModelNo = relProdV2Obj.modelNo;
						var vRelProdModelNm = relProdV2Obj.modelNm;
						var vBtnText = relProdV2Obj.btnText;
						html[hIdx++] = "				<div class=\"item__relate\">";
						html[hIdx++] = "					<a href=\"javascript:void(0);\" class=\"btn_relate_item\" data-orgModelNo=\""+strModelNoRep+"\" data-modelNo =\""+strModelNo+"\" data-relbtntext=\""+vBtnText+"\" data-relProdModelNo=\""+vRelProdModelNo+"\" data-relProdModelNm=\""+vRelProdModelNm+"\">"+vBtnText+"<em>"+vRelProdCnt+"</em></a>";
						html[hIdx++] = "				</div>";
					}
				}
				
				html[hIdx++] = "			</div>";
				//							<!-- // -->
				if (optionViewType == "model" || groupModel.list !== undefined) {
					html[hIdx++] = drawGroupModel(groupModel, strOpenExpectFlag, adAttr, strDiscountRate);
				}
				html[hIdx++] = "		</div>";
				html[hIdx++] = "	</div>";

				// 일반상품
			} else if (item.prodType == "P") {

				var plMoveLinkUrl = "/move/Redirect.jsp?type=ex&cmd=move_" + strPlNo + "&pl_no=" + strPlNo;

				//					<!-- 리스트형 : 일반상품 Case -->
				html[hIdx++] = "	<div class=\"goods-item\">";
				//						<!-- 썸네일 -->
				html[hIdx++] = "		<div class=\"item__thumb\">";
				html[hIdx++] = "			<a href=\"" + plMoveLinkUrl + "\" target=\"_blank\">";
				html[hIdx++] = "				<img src=\"" + strImageUrl + "\" alt=\"" + strModelName + "\">";
				// 								<!-- 태그 / 기존 마크업 유지 -->
				html[hIdx++] = "				<div class=\"img_tag_v2\">";
				// 									<!-- 타입 A : 기존 태그 -->
				// /lsv2016/ajax/getGoods_List_Colors_ajax.jsp api 에서 호출 
				html[hIdx++] = "				</div>";
				// 							<!-- // -->
				html[hIdx++] = "			</a>";

				// 							<!-- 동영상/찜/비교/크게보기 -->
				html[hIdx++] = "			<div class=\"item__menu\">";
				html[hIdx++] = "				<div class=\"item__menu__inner\">";
				//									<!-- 버튼 : 비교하기 -->
				// html[hIdx++] = "					<button class=\"item__btn--compare\" title=\"상품비교\" onclick=\"javascript:compareProdInput('P"+strPlNo+"');\"><i class=\"ico-item--compare lp__sprite\">상품비교</i></button>";
				//									<!-- 버튼 : 찜하기 -->
				//									<!-- 찜된 상품 .is--on -->
				if ((strZzimYN == "Y" && !zzimTmpPlNoRemoveSet.has(strPlNo)) || zzimTmpPlNoSet.has(strPlNo)) {
					html[hIdx++] = "					<button class=\"item__btn--zzim is--on\" title=\"찜\" data-zzimno=\"P" + strPlNo + "\" onclick=\"showLayZzim_list(this);return false;\"><i class=\"ico-item--zzim lp__sprite\">찜</i></button>";
				} else {
					html[hIdx++] = "					<button class=\"item__btn--zzim\" title=\"찜\" data-zzimno=\"P" + strPlNo + "\" onclick=\"showLayZzim_list(this);return false;\"><i class=\"ico-item--zzim lp__sprite\">찜</i></button>";
				}
				html[hIdx++] = "				</div>";
				html[hIdx++] = "			</div>";
				// 							<!-- // -->
				html[hIdx++] = "		</div>";
				// 						<!-- // -->
				html[hIdx++] = "		<div class=\"item__box\">";
				//							<!-- 상품정보 -->
				html[hIdx++] = "			<div class=\"item__info\">";
				//								<!-- 모델명 -->
				html[hIdx++] = "				<div class=\"item__model\">";
				// 순위 ( 1페이지, 인기순 일때만 ) rank
				if (param_pageNum == 1 && param_sort == "1" && item.strAdProdFlagYN == "N") {
					html[hIdx++] = "				<span class=\"tag--rank\">" + (rank++) + "</span>";
				}
				html[hIdx++] = "					<a href=\"" + plMoveLinkUrl + "\" target=\"_blank\" data-type=\"modelname\">" + strModelName + "</a>";
				html[hIdx++] = "				</div>";
				//								<!-- 카드 무이자 정보 -->
				if (item.strFreeinterest !== undefined && item.strFreeinterest.length > 0) {
					html[hIdx++] = "			<ul class=\"item__attr\">";
					html[hIdx++] = "				<li>" + convertFreeInterest(item.strFreeinterest) + "</li>";
					html[hIdx++] = "			</ul>";
				}
				//								<!-- 기타 -->
				html[hIdx++] = "				<div class=\"item__etc\">";
				html[hIdx++] = "					<ul>";
				//										<!-- 상품평/평점 -->
				html[hIdx++] = "						<li class=\"item__etc--score\">";
				if (strModelNo != "0") {
					html[hIdx++] = "						<a href=\"/detail.jsp?modelno=" + strModelNo + "&focus=bbs\" target=\"_blank\">";
					if (strBbsPoint != "0" && strBbsPoint != "0.0") {
						html[hIdx++] = "						<i class=\"ico-etc-star lp__sprite\"></i><strong>" + strBbsPoint + "점</strong> (" + strBbsNum.format() + ")";
					} else if (strBbsNum != "0") {
						html[hIdx++] = "상품평 ("+strBbsNum.format() + ")";
					}
					html[hIdx++] = "						</a>";
				} else {
					if (strBbsPoint != "0" && strBbsPoint != "0.0") {
						html[hIdx++] = "					<i class=\"ico-etc-star lp__sprite\"></i><strong>" + strBbsPoint + "점</strong> (" + strBbsNum.format() + ")";
					} else if (strBbsNum != "0") {
						html[hIdx++] = "					<span class=\"tx_tit\">상품평</span> (" + strBbsNum.format() + ")";
					}
				}
				html[hIdx++] = "						</li>";
				//										<!-- 등록일 -->
				if (strCdate.length > 0 && strCdate.length == 8) {
					html[hIdx++] = "					<li class=\"item__etc--date\">등록일 " + strCdate.substring(0, 4) + "." + strCdate.substring(4, 6) + "</li>";
				}
				html[hIdx++] = "					</ul>";
				html[hIdx++] = "				</div>";
				html[hIdx++] = "			</div>";
				//							<!-- // -->
				//							<!-- 상품가격 : 일반상품 -->
				html[hIdx++] = "			<div class=\"item__price\">";
				//								<!-- 일반상품 / 가격 -->
				html[hIdx++] = "				<div class=\"price__mall\">";
				//									<!-- 쇼핑몰 -->
				html[hIdx++] = "					<div class=\"col--mall\" data-role=\"logo\">";
				//										<!-- 텍스트 + N페이 -->
				if (strShopName != "" && iconAttr.naverpay !== undefined) {
					html[hIdx++] = "					<span class=\"tx--mall-npay\">" + strShopName + "</span>";
					//										<!-- 로고형 -->
				} else if (strShopCode != "0" && strShopName != "") {
					html[hIdx++] = "					<img src=\"//storage.enuri.info/logo/logo20/logo_20_" + strShopCode + ".png\" alt=\"" + strShopName + "\" onerror=\"javascript:logoImgNotFound(this);\">";
				}
				html[hIdx++] = "					</div>";
				//									<!-- 가격 -->
				html[hIdx++] = "					<div class=\"col--price\">";
				if (iconAttr.cash !== undefined) {
					//									<!-- 현금 -->
					html[hIdx++] = "					<span class=\"tag--cash lp__sprite\">현금</span>";
				}
				if (iconAttr.ovs !== undefined) {
					//									<!-- 직구 -->
					html[hIdx++] = "					<span class=\"tag--global lp__sprite\">직구</span>";
				}
				if (strCouponContents.length > 0) {
					// 모델, 컨텐츠 
					var obj = {};
					obj["P:" + strPlNo] = strCouponContents;
					Object.assign(couponContentsObj, obj);

					//									<!-- 쿠폰 -->
					html[hIdx++] = "					<div class=\"tag--coupon\">";
					html[hIdx++] = "						<i class=\"ico-tag--coupon lp__sprite\">쿠폰</i>";
					html[hIdx++] = "						<div class=\"lay-coupon lay-comm lay-comm--sm\" style=\"display:none;\">";
					html[hIdx++] = "							<div class=\"lay-comm--head\">";
					html[hIdx++] = "								<strong class=\"lay-comm__tit\">";
					html[hIdx++] = "									본 가격은 <em>추가할인 쿠폰</em> 적용가 입니다.</strong>";
					html[hIdx++] = "								</strong>";
					html[hIdx++] = "							</div>";
					html[hIdx++] = "							<div class=\"lay-comm--body\">";
					html[hIdx++] = "								<div class=\"lay-comm__inner\">";
					//	html[hIdx++] = strCouponContents;
					html[hIdx++] = "									<div class=\"lay-coupon__price\">";
					html[hIdx++] = "										쿠폰적용가 : <em>" + strMinPrice + "</em>원";
					html[hIdx++] = "									</div>";
					html[hIdx++] = "								</div>";
					html[hIdx++] = "							</div>";
					html[hIdx++] = "						</div>";
					html[hIdx++] = "					</div>";
				}
				html[hIdx++] = "						<a href=\"" + plMoveLinkUrl + "\" target=\"_blank\"><em>" + strMinPrice + "</em>원</a>";
				//										<!-- 배송료 --> "배송비" 문구가 있으면 tx--delivery--paid 클래스, 없으면 tx--delivery 클래스
				if (strDeliveryInfo !== undefined) {
					html[hIdx++] = "					<div class=\"tx--delivery-label\">";
					if (strDeliveryInfo.indexOf("배송비") > -1) {
						html[hIdx++] = "					<div class=\"tx--delivery--paid\">" + strDeliveryInfo + "</div>";
					} else if (strDeliveryInfo != "0") {
						html[hIdx++] = "					<div class=\"tx--delivery\">" + strDeliveryInfo + "</div>";
					}
					html[hIdx++] = "					</div>";
				}
				//										<!-- // -->
				html[hIdx++] = "					</div>";
				html[hIdx++] = "				</div>";
				//								<!-- // -->
				html[hIdx++] = "			</div>";
				html[hIdx++] = "		</div>";
				html[hIdx++] = "	</div>";

			} else if (item.prodType == "M") { //메이크샵
				
				html[hIdx++] = "	<div class=\"goods-item\">";
				html[hIdx++] = "		<!-- 썸네일 -->";
				html[hIdx++] = "		<div class=\"item__thumb\">  ";
				html[hIdx++] = "			<a href=\"" + strLandUrl + "\" target=\"_blank\"><img src=\"" + strImageUrl + "\" alt=\"" + strModelName + "\"></a>";
				html[hIdx++] = "			<!-- 동영상/찜/비교/크게보기 -->";
				html[hIdx++] = "			<div class=\"item__menu\">";
				html[hIdx++] = "				<div class=\"item__menu__inner\">";
				html[hIdx++] = "					<!-- 버튼 : 찜하기 -->";
				html[hIdx++] = "					<!-- 찜된 상품 .is--on -->";
				html[hIdx++] = "					<button class=\"item__btn--zzim "+(strZzimYN == "Y" ? "is--on" : "")+"\" data-zzimno=\"" + strMakeshopID + "\" title=\"찜\" onclick=\"showLayZzim_list(this);return false;\"><i class=\"ico-item--zzim lp__sprite\">찜</i></button>";
				html[hIdx++] = "				</div>";
				html[hIdx++] = "			</div>";
				html[hIdx++] = "			<!-- // -->";
				html[hIdx++] = "		</div>";
				html[hIdx++] = "		<!-- // -->";
				html[hIdx++] = "		<div class=\"item__box\">";
				html[hIdx++] = "			<!-- 상품정보 -->";
				html[hIdx++] = "			<div class=\"item__info\">";
				html[hIdx++] = "				<!-- 모델명 -->";
				html[hIdx++] = "				<div class=\"item__model\">";
				// 순위 ( 1페이지, 인기순 일때만 ) rank
				if (param_pageNum == 1 && param_sort == "1") {
					html[hIdx++] = "				<span class=\"tag--rank\">" + (rank++) + "</span>";
				}
				html[hIdx++] = "					<a href=\"" + strLandUrl + "\" target=\"_blank\" data-type=\"modelname\">" + strModelName + "</a>";
				html[hIdx++] = "				</div>";
				html[hIdx++] = "				<!-- 속성/용어사전 -->";
				html[hIdx++] = "				<!-- '/'' 구분자는 li태그에 자동으로 붙습니다 -->";
				html[hIdx++] = "				<!-- 상세검색 매칭되는 속성은 em태그로 감사주세요 -->";
				html[hIdx++] = "				<!-- 카드 무이자 정보 -->";
				if (item.strFreeinterest !== undefined && item.strFreeinterest.length > 0) {
					html[hIdx++] = "			<ul class=\"item__attr\">";
					html[hIdx++] = "				<li>" + convertFreeInterest(item.strFreeinterest) + "</li>";
					html[hIdx++] = "			</ul>";
				}
				html[hIdx++] = "				<!-- 기타 -->";
				html[hIdx++] = "				<div class=\"item__etc\">";
				html[hIdx++] = "					<ul>";
				html[hIdx++] = "						<!-- 상품평/평점 -->";
				if(strBbsNum!="0") {
					html[hIdx++] = "					<li class=\"item__etc--score\"><a href=\"" + strLandUrl + "\" target=\"_blank\"><strong>상품평</strong> (" + strBbsNum.format() + ")</a></li>";
				}
				html[hIdx++] = "						<!-- 등록일 -->";
				if (strCdate.length > 0 && strCdate.length == 8) {
					html[hIdx++] = "					<li class=\"item__etc--date\">등록일 " + strCdate.substring(0, 4) + "." + strCdate.substring(4, 6) + "</li>";
				}
				html[hIdx++] = "					</ul>";
				html[hIdx++] = "				</div>";
				html[hIdx++] = "			</div>";
				html[hIdx++] = "			<!-- // -->";
				html[hIdx++] = "			<!-- 상품가격 : 일반상품 -->";
				html[hIdx++] = "			<div class=\"item__price\">";
				html[hIdx++] = "				<!-- 출시가 -->";
				/*
				html[hIdx++] = "				<div class=\"price__origin price__origin-strike\">";
				html[hIdx++] = "					<p class=\"tx--price\"><em>" + strMinPrice + "</em>원</p>";
				html[hIdx++] = "				</div>";
				*/
				html[hIdx++] = "				<!-- // -->";
				html[hIdx++] = "				<!-- 일반상품 / 가격 -->";
				html[hIdx++] = "				<div class=\"price__mall\">";
				html[hIdx++] = "					<!-- 쇼핑몰 -->";
				html[hIdx++] = "					<div class=\"col--mall\">";
				html[hIdx++] = "						<!-- 텍스트형 -->";
				html[hIdx++] = "						<span class=\"tx--mall tx--mall-soho\">" + strShopName + "</span>";
				html[hIdx++] = "					</div>";
				html[hIdx++] = "					<!-- 가격 -->";
				html[hIdx++] = "					<div class=\"col--price\">";
				html[hIdx++] = "						<a href=\"" + strLandUrl + "\" target=\"_blank\"><em>" + strMinPrice + "</em>원</a>";
				html[hIdx++] = "					</div>";
				html[hIdx++] = "				</div>";
				html[hIdx++] = "				<!-- // -->";
				html[hIdx++] = "				<!-- 배송료 -->";
				if (strDeliveryInfo !== undefined) {
					if (strDeliveryInfo.indexOf("배송비") > -1) {
						html[hIdx++] = "		<div class=\"tx--delivery--paid\">" + strDeliveryInfo + "</div>";
					} else if (strDeliveryInfo != "0") {
						html[hIdx++] = "		<div class=\"tx--delivery\">" + strDeliveryInfo + "</div>";
					}
				}
				html[hIdx++] = "				<!-- // -->";
				html[hIdx++] = "			</div>";
				html[hIdx++] = "			<!-- // -->";
				html[hIdx++] = "		</div>";
				html[hIdx++] = "	</div>";
			}
			// 						<!-- // -->
			
			// 파워클릭 삽입을 위한 태그 삽입 ( 6위 상품 뒤 )
			if (rank == 7 && (param_pageNum == 1 && param_tabType == 0 && attrSelCnt == 0)) {
				html[hIdx++] = "<li data-type=\"adline_powerclick\" style=\"display:none;\"></li>";
			}
	
			// 슈퍼탑라이트 삽입을 위한 태그 삽입 ( 7위 상품 뒤 )
			if (rank == 9 && (param_pageNum == 1 && param_tabType == 0 && attrSelCnt == 0)) {
				html[hIdx++] = "<li data-type=\"adline\" style=\"display:none;\"></li>";
			}
			
			// 애드오피스 삽입을 위한 태그 삽입 ( 20위 상품 뒤 )
			if (rank == 21 && (param_pageNum == 1 && param_tabType == 0 && attrSelCnt == 0)) {
				html[hIdx++] = "<li data-type=\"adline_adoffice\" style=\"display:none;\"></li>";
			}
			

		/*--------------------------- 갤러리형 ------------------------------------*/
		} else if (viewType == 2) {

			// 모델상품
			if (item.prodType == "G") {

				//				<!-- 그리드형 : Full Case -->
				html[hIdx++] = "	<div class=\"goods-item\">";
				//						<!-- 썸네일 -->
				html[hIdx++] = "		<div class=\"item__thumb\">";
				//							<!-- 히트 브랜드 (기존유지)-->
				if (adAttr.hitbrand !== undefined) {
					html[hIdx++] = "		<span class=\"badge_hitbrand\">히트브랜드</span>";
				}
				//							<!-- // -->
				html[hIdx++] = "			<a href=\"/detail.jsp?modelno=" + strModelNo + "\" target=\"_blank\">";
				html[hIdx++] = "				<img src=\"" + strImageUrl + "\" alt=\"" + strModelName + "\">";
				// 								<!-- 태그 / 기존 마크업 유지 -->
				html[hIdx++] = "				<div class=\"img_tag_v2\">";
				// 									<!-- 타입 A : 기존 태그 -->
				// list_func.js setListImageInIconSet() 에서 호출 
				html[hIdx++] = "				</div>";
				// 								<!-- // -->
				html[hIdx++] = "			</a>";
				//							<!-- 동영상/찜/비교/크게보기 -->
				html[hIdx++] = "			<div class=\"item__menu\">";
				html[hIdx++] = "				<div class=\"item__menu__inner\">";
				// 									<!-- 버튼 : 동영상 -->
				if (strVideoYN == "Y") {
					html[hIdx++] = "				<button class=\"item__btn--movie\" title=\"동영상 보기\" onclick=\"javascript:loadThumNail(" + strModelNo + ",1);\"><i class=\"ico-item--movie lp__sprite\">동영상 보기</i></button>";
				}
				//									<!-- 버튼 : 이미지 크게보기 -->
				if (!(strAdultYN == "Y" && isAdultFlag == "false")) { // 성인상품이면서 성인인증을 받지 않은 경우를 제외하고 돋보기 노출
					html[hIdx++] = "				<button class=\"item__btn--view\" title=\"크게보기\" onclick=\"javascript:loadThumNail(" + strModelNo + ");\"><i class=\"ico-item--view lp__sprite\">크게보기</i></button>";
				}
				//									<!-- 버튼 : 비교하기 -->
				html[hIdx++] = "					<button class=\"item__btn--compare\" title=\"상품비교\" ><i class=\"ico-item--compare lp__sprite\">상품비교</i></button>";
				//									<!-- 버튼 : 찜하기 -->
				//									<!-- 찜된 상품 .is--on -->
				if ((strZzimYN == "Y" && !zzimTmpModelNoRemoveSet.has(strModelNo)) || zzimTmpModelNoSet.has(strModelNo)) {
					html[hIdx++] = "				<button class=\"item__btn--zzim is--on\" title=\"찜\" data-zzimno=\"G" + strModelNo + "\" onclick=\"showLayZzim_list(this);return false;\"><i class=\"ico-item--zzim lp__sprite\">찜</i></button>";
				} else {
					html[hIdx++] = "				<button class=\"item__btn--zzim\" title=\"찜\" data-zzimno=\"G" + strModelNo + "\" onclick=\"showLayZzim_list(this);return false;\"><i class=\"ico-item--zzim lp__sprite\">찜</i></button>";
				}
				html[hIdx++] = "				</div>";
				html[hIdx++] = "			</div>";
				// 							<!-- // -->
				html[hIdx++] = "		</div>";
				//						<!-- // -->
				html[hIdx++] = "		<div class=\"item__box\">";
				//							<!-- 상품가격 : 가격비교형 -->
				html[hIdx++] = "			<div class=\"item__price\">";
				//								<!-- 가격 -->
				if (strProdStatusTxt.length > 0) { // 상태문구 
					html[hIdx++] = "			<a href=\"/detail.jsp?modelno=" + strModelNo + "\" target=\"_blank\" class=\"tx--price\">";
					html[hIdx++] = "				<span class=\"tx--sold\">" + strProdStatusTxt + "</span>";
				} else if (strMinPrice.length > 0) { // 최저가
					html[hIdx++] = "			<a href=\"/detail.jsp?modelno=" + strModelNo + "\" target=\"_blank\" class=\"tx--price\">";
					if (iconAttr.cash !== undefined && iconAttr.cash.price !== undefined) {
						html[hIdx++] = "			최저가 <em>" + iconAttr.cash.price + "</em>원";
					} else {
						html[hIdx++] = "			최저가 <em>" + strMinPrice + "</em>원";
					}
				}
				if (iconAttr.cash !== undefined) {
					//								<!-- 현금 -->
					html[hIdx++] = "				<span class=\"tag--cash lp__sprite\">현금</span>";
				}
				if (iconAttr.ovs !== undefined) {
					//								<!-- 직구 -->
					html[hIdx++] = "				<span class=\"tag--global lp__sprite\">직구</span>";
				}
				if (strProdStatusTxt.length > 0 || strMinPrice.length > 0) {
					html[hIdx++] = "			</a>";
				}
				//								<!-- // -->
				//								<!-- 출시가 (모델상품 전용)-->
				// 출시가/할인율
				if(strExtraPrice && strExtraPrice.length > 0 && strExtraPriceTitle && strExtraPriceTitle.length > 0) {
					if(strDiscountRate && strDiscountRate.length>0) {
						html[hIdx++] = "		<div class=\"tx--release-price\"><span tag=\"tx_price\">"+strExtraPriceTitle+" "+strExtraPrice+"원 (<strong>"+strDiscountRate+"%↓</strong>)</span></div>";
					} else {
						html[hIdx++] = "		<div class=\"tx--release-price\"><span tag=\"tx_price\">"+strExtraPriceTitle+" "+strExtraPrice+"원</span></div>";
					}
				}
				if (strCouponContents.length > 0) {
					// 모델, 컨텐츠 
					var obj = {};
					obj["G:" + strModelNo] = strCouponContents;
					Object.assign(couponContentsObj, obj);

					//							<!-- 쿠폰 -->
					html[hIdx++] = "			<div class=\"tag--coupon\">";
					html[hIdx++] = "				<i class=\"ico-tag--coupon lp__sprite\">쿠폰</i>";
					html[hIdx++] = "				<div class=\"lay-coupon lay-comm lay-comm--sm\" style=\"display:none;\">";
					html[hIdx++] = "					<div class=\"lay-comm--head\">";
					html[hIdx++] = "						<strong class=\"lay-comm__tit\">";
					html[hIdx++] = "							본 가격은 <em>추가할인 쿠폰</em> 적용가 입니다.</strong>";
					html[hIdx++] = "						</strong>";
					html[hIdx++] = "					</div>";
					html[hIdx++] = "					<div class=\"lay-comm--body\">";
					html[hIdx++] = "						<div class=\"lay-comm__inner\">";
					//	html[hIdx++] = strCouponContents;
					html[hIdx++] = "							<div class=\"lay-coupon__price\">";
					html[hIdx++] = "								쿠폰적용가 : <em>" + strMinPrice + "</em>원";
					html[hIdx++] = "							</div>";
					html[hIdx++] = "						</div>";
					html[hIdx++] = "					</div>";
					html[hIdx++] = "				</div>";
					html[hIdx++] = "			</div>";
				}
				if (strMinPriceMobileTag == "Y") {
					html[hIdx++] = "			<span class=\"tag--mobile lp__sprite\" onclick=\"javascript:mobileMinPriceLayer(this);\">모바일최저가</span>";
				}
				html[hIdx++] = "			</div>";
				//							<!-- // -->
				//							<!-- 상품정보 -->
				html[hIdx++] = "			<div class=\"item__info\">";
				//								<!-- 모델명 -->
				html[hIdx++] = "				<div class=\"item__model\">";
				html[hIdx++] = "					<a href=\"/detail.jsp?modelno=" + strModelNo + "\" target=\"_blank\" data-type=\"modelname\">";
				// 순위 ( 1페이지, 인기순 일때만 ) rank
				if (param_pageNum == 1 && param_sort == "1" && item.strAdProdFlagYN == "N") {
					html[hIdx++] = "					<span class=\"tag--rank\">" + (rank++) + "</span>";
				}
				if (item.strAdProdFlagYN == "Y") {
					html[hIdx++] = "					<span class=\"tag--ad\">AD</span>";
				}
				html[hIdx++] = strModelName;
				html[hIdx++] = "					</a>";
				html[hIdx++] = "				</div>";
				//								<!-- // -->
				//								<!-- 상품 요약 -->
				html[hIdx++] = "				<div class=\"item__summ\">";
				//									<!-- 출시일 -->
				if (strCdate.length > 0 && strCdate.length == 8) {
					html[hIdx++] = "				<dl class=\"item__summ--releasedate\">";
					html[hIdx++] = "					<dt>등록일</dt>";
					html[hIdx++] = "					<dd>" + strCdate.substring(0, 4) + "." + strCdate.substring(4, 6) + "</dd>";
					html[hIdx++] = "				</dl>";
				}
				//									<!-- 판매몰수 -->
				if (strMallCnt != "0") {
					html[hIdx++] = "				<dl class=\"item__summ--mall\">";
					html[hIdx++] = "					<dt>판매몰</dt>";
					html[hIdx++] = "					<dt>" + strMallCnt + "몰</dt>";
					html[hIdx++] = "				</dl>";
				}
				html[hIdx++] = "				</div>";
				//								<!-- 기타 -->
				html[hIdx++] = "				<div class=\"item__etc\">";
				html[hIdx++] = "					<ul>";
				//										<!-- 상품평/평점 -->
				html[hIdx++] = "						<li class=\"item__etc--score\">";
				html[hIdx++] = "							<a href=\"/detail.jsp?modelno=" + strModelNo + "&focus=bbs\" target=\"_blank\">";
				if (strBbsPoint != "0" && strBbsPoint != "0.0") {
					html[hIdx++] = "							<i class=\"ico-etc-star lp__sprite\"></i><strong>" + strBbsPoint + "점</strong> (" + strBbsNum.format() + ")";
				} else if (strBbsNum != "0") {
					html[hIdx++] = "상품평 : ("+strBbsNum.format() + ")";
				}
				html[hIdx++] = "							</a>";
				html[hIdx++] = "						</li>";
				html[hIdx++] = "					</ul>";
				html[hIdx++] = "				</div>";
				html[hIdx++] = "			</div>";
				//							<!-- // -->
				html[hIdx++] = "		</div>";
				//						<!-- 옵션, 쇼핑몰 더보기 / 쇼핑몰 바로가기 -->
				html[hIdx++] = "		<div class=\"item__foot\">";
				//							<!-- 버튼 : 옵션 펼치기 -->
				if (optionViewType == "model" && groupModel && groupModel.list !== undefined) {
					if (groupModel.list.length > 0) {
						html[hIdx++] = "	<button class=\"btn--opt-unfold\">다른옵션 더보기<i class=\"ico-arr-select-box lp__sprite\"></i></button>";
					}
				} else if (optionViewType == "shop") {
					if (strProdStatusTxt.length > 0) {
						html[hIdx++] = "출시예정";
					} else {
						html[hIdx++] = "	<button class=\"btn--opt-unfold\">쇼핑몰 더보기<i class=\"ico-arr-select-box lp__sprite\"></i></button>";
					}
				}
				//							<!-- // -->
				html[hIdx++] = "		</div>";
				html[hIdx++] = "	</div>";

			// 일반상품	
			} else if (item.prodType == "P") {

				var plMoveLinkUrl = "/move/Redirect.jsp?type=ex&cmd=move_" + strPlNo + "&pl_no=" + strPlNo;

				html[hIdx++] = "	<div class=\"goods-item\">";
				//						<!-- 썸네일 -->
				html[hIdx++] = "		<div class=\"item__thumb\">";
				html[hIdx++] = "			<a href=\"" + plMoveLinkUrl + "\" target=\"_blank\">";
				html[hIdx++] = "				<img src=\"" + strImageUrl + "\" alt=\"" + strModelName + "\">";
				html[hIdx++] = "			</a>";
				//							<!-- 동영상/찜/비교/크게보기 -->
				html[hIdx++] = "			<div class=\"item__menu\">";
				html[hIdx++] = "				<div class=\"item__menu__inner\">";
				//									<!-- 버튼 : 비교하기 -->
				// html[hIdx++] = "					<button class=\"item__btn--compare\" title=\"상품비교\" onclick=\"javascript:compareProdInput('P"+strPlNo+"');\"><i class=\"ico-item--compare lp__sprite\">상품비교</i></button>";
				//									<!-- 버튼 : 찜하기 -->
				//									<!-- 찜된 상품 .is--on -->
				if ((strZzimYN == "Y" && !zzimTmpPlNoRemoveSet.has(strModelNo)) || zzimTmpPlNoSet.has(strPlNo)) {
					html[hIdx++] = "					<button class=\"item__btn--zzim is--on\" title=\"찜\" data-zzimno=\"P" + strPlNo + "\" onclick=\"showLayZzim_list(this);return false;\"><i class=\"ico-item--zzim lp__sprite\">찜</i></button>";
				} else {
					html[hIdx++] = "					<button class=\"item__btn--zzim\" title=\"찜\" data-zzimno=\"P" + strPlNo + "\" onclick=\"showLayZzim_list(this);return false;\"><i class=\"ico-item--zzim lp__sprite\">찜</i></button>";
				}
				html[hIdx++] = "				</div>";
				html[hIdx++] = "			</div>";
				// 							<!-- // -->
				html[hIdx++] = "		</div>";
				//						<!-- // -->
				html[hIdx++] = "		<div class=\"item__box\">"; 
				//							<!-- 상품가격 : 일반상품 -->
				html[hIdx++] = "			<div class=\"item__price\">";
				//								<!-- 가격 -->
				html[hIdx++] = "				<a href=\"" + plMoveLinkUrl + "\" class=\"tx--price\" target=\"_blank\">";
				html[hIdx++] = "					<em>" + strMinPrice + "</em>원";

				if (iconAttr.cash !== undefined) {
					//								<!-- 현금 -->
					html[hIdx++] = "				<span class=\"tag--cash lp__sprite\">현금</span>";
				}
				if (iconAttr.ovs !== undefined) {
					//								<!-- 직구 -->
					html[hIdx++] = "				<span class=\"tag--global lp__sprite\">직구</span>";
				}

				html[hIdx++] = "				</a>";
				//								<!-- 배송료 (일반상품 전용)-->
				if (strDeliveryInfo && strDeliveryInfo.length > 0 && strDeliveryInfo != "0") {
					html[hIdx++] = "			<div class=\"tx--deleveryfee\">" + strDeliveryInfo + "</div>";
				}
				if (strCouponContents.length > 0) {
					couponContentsObj = $.extend({}, couponContentsObj, obj);

					//							<!-- 쿠폰 -->
					html[hIdx++] = "			<div class=\"tag--coupon\">";
					html[hIdx++] = "				<i class=\"ico-tag--coupon lp__sprite\">쿠폰</i>";
					html[hIdx++] = "				<div class=\"lay-coupon lay-comm lay-comm--sm\" style=\"display:none;\">";
					html[hIdx++] = "					<div class=\"lay-comm--head\">";
					html[hIdx++] = "						<strong class=\"lay-comm__tit\">";
					html[hIdx++] = "							본 가격은 <em>추가할인 쿠폰</em> 적용가 입니다.</strong>";
					html[hIdx++] = "						</strong>";
					html[hIdx++] = "					</div>";
					html[hIdx++] = "					<div class=\"lay-comm--body\">";
					html[hIdx++] = "						<div class=\"lay-comm__inner\">";
					//	html[hIdx++] = strCouponContents;
					html[hIdx++] = "							<div class=\"lay-coupon__price\">";
					html[hIdx++] = "								쿠폰적용가 : <em>" + strMinPrice + "</em>원";
					html[hIdx++] = "							</div>";
					html[hIdx++] = "						</div>";
					html[hIdx++] = "					</div>";
					html[hIdx++] = "				</div>";
					html[hIdx++] = "			</div>";
				}
				if (strMinPriceMobileTag == "Y") {
					html[hIdx++] = "			<span class=\"tag--mobile lp__sprite\" onclick=\"javascript:mobileMinPriceLayer(this);\">모바일최저가</span>";
				}
				//							<!-- // -->
				html[hIdx++] = "			</div>";
				//							<!-- 상품정보 -->
				html[hIdx++] = "			<div class=\"item__info\">";
				//								<!-- 모델명 -->
				html[hIdx++] = "				<div class=\"item__model type--general\">";
				html[hIdx++] = "					<a href=\"" + plMoveLinkUrl + "\" target=\"_blank\" data-type=\"modelname\">";
				// 순위 ( 1페이지, 인기순 일때만 ) rank
				if (param_pageNum == 1 && param_sort == "1" && item.strAdProdFlagYN == "N") {
					html[hIdx++] = "					<span class=\"tag--rank\">" + (rank++) + "</span>";
				}
				html[hIdx++] = strModelName;
				html[hIdx++] = "					</a>";
				html[hIdx++] = "				</div>";
				//								<!-- // -->
				//								<!-- 상품 요약 -->
				html[hIdx++] = "				<div class=\"item__summ\">";
				if (strCdate.length > 0 && strCdate.length == 8) {
					//								<!-- 등록일 -->
					html[hIdx++] = "				<dl class=\"item__summ--releasedate\">";
					html[hIdx++] = "					<dt>등록일</dt>";
					html[hIdx++] = "					<dd>" + strCdate.substring(0, 4) + "." + strCdate.substring(4, 6) + "</dd>";
					html[hIdx++] = "				</dl>";
				}
				if (strBbsNum != "0" && strBbsPoint != "0.0") {
					html[hIdx++] = "			</div>";
					html[hIdx++] = "			<div class=\"item__etc\">";
					html[hIdx++] = "				<ul>";
					html[hIdx++] = "					<li class=\"item__etc--score\"><i class=\"ico-etc-star lp__sprite\"></i><strong>" + strBbsPoint + "점</strong> (" + strBbsNum.format() + ")</li>";
					html[hIdx++] = "				</ul>";
				} else if (strBbsNum != "0") {
					html[hIdx++] = "			</div>";
					html[hIdx++] = "			<div class=\"item__etc\">";
					html[hIdx++] = "				<ul>";
					html[hIdx++] = "					<li class=\"item__etc--score\"><p><span class=\"tx_tit\">상품평</span> (" + strBbsNum.format() + ")</p></li>";
					html[hIdx++] = "				</ul>";
				}
				html[hIdx++] = "				</div>";
				html[hIdx++] = "			</div>";

				//						<!-- // -->
				html[hIdx++] = "		</div>";
				//						<!-- 옵션, 쇼핑몰 더보기 / 쇼핑몰 바로가기 -->
				html[hIdx++] = "		<div class=\"item__foot\">";
				//							<!-- 쇼핑몰 -->
				html[hIdx++] = "			<div class=\"tx--mall\"  data-role=\"logo\">";
				//								<!-- 텍스트 + N페이 -->
				if (strShopName != "" && iconAttr.naverpay !== undefined) {
					html[hIdx++] = "			<a href=\"" + plMoveLinkUrl + "\" class=\"mall--npay\" target=\"_blank\">" + strShopName + "</a>";
					//								<!-- 로고형 -->
				} else if (strShopCode != "0" && strShopName != "") {
					html[hIdx++] = "			<a href=\"" + plMoveLinkUrl + "\" class=\"mall--logo\" target=\"_blank\">";
					html[hIdx++] = "				<img src=\"//storage.enuri.info/logo/logo20/logo_20_" + strShopCode + ".png\" alt=\"" + strShopName + "\" onerror=\"javascript:logoImgNotFound(this);\">";
					html[hIdx++] = "			</a>";
				}
				html[hIdx++] = "			</div>";
				html[hIdx++] = "		</div>";
				html[hIdx++] = "	</div>";
				//					<!-- // -->

			//메이크샵
			} else if (item.prodType == "M") { 

				html[hIdx++] = "<div class=\"goods-item\">";
				html[hIdx++] = "	<!-- 썸네일 -->";
				html[hIdx++] = "	<div class=\"item__thumb\">";
				html[hIdx++] = "		<a href=\"" + strLandUrl + "\" target=\"_blank\"><img src=\"" + strImageUrl + "\" alt=\"" + strModelName + "\"></a>";
				html[hIdx++] = "	</div>";
				html[hIdx++] = "	<!-- // -->";
				html[hIdx++] = "	<div class=\"item__box\">";
				html[hIdx++] = "		<!-- 상품가격 : 가격비교형 -->";
				html[hIdx++] = "		<div class=\"item__price\">";
				html[hIdx++] = "			<!-- 출시가 (모델상품 전용)-->";
			//	html[hIdx++] = "			<div class=\"tx--release-price\"><span class=\"tx_price\">" + strMinPrice + "원</span></div>";
				html[hIdx++] = "			<!-- 가격 -->";
				html[hIdx++] = "			<a href=\"" + strLandUrl + "\" target=\"_blank\" class=\"tx--price\">";
			//	html[hIdx++] = "				<span class=\"tx--percent\">0%</span>";
				html[hIdx++] = "				<!-- 가격 -->";
				html[hIdx++] = "				<em>" + strMinPrice + "</em>원";
				html[hIdx++] = "				<!-- // -->";
				html[hIdx++] = "				<!-- 일시품절/가격예정/출시예정 등 -->";
				html[hIdx++] = "				<!-- <span class=\"tx--sold\">출시예정</span> -->";
				html[hIdx++] = "				<!-- // -->";
				html[hIdx++] = "			</a>";
				html[hIdx++] = "			<!-- // -->";
				html[hIdx++] = "		</div>";
				html[hIdx++] = "		<!-- // -->";
				html[hIdx++] = "		<!-- 상품정보 -->";
				html[hIdx++] = "		<div class=\"item__info\">";
				html[hIdx++] = "			<!-- 모델명 : 모델상품 -->";
				html[hIdx++] = "			<div class=\"item__model\">";
				// 순위 ( 1페이지, 인기순 일때만 ) rank
				if (param_pageNum == 1 && param_sort == "1") {
					html[hIdx++] = "			<span class=\"tag--rank\">" + (rank++) + "</span>";
				}
				html[hIdx++] = "				<a href=\"" + strLandUrl + "\" target=\"_blank\">" + strModelName + "</a>";
				html[hIdx++] = "			</div>";
				html[hIdx++] = "			<!-- // -->";
				html[hIdx++] = "			<!-- 상품 요약 -->";
				html[hIdx++] = "			<div class=\"item__summ\">";
				html[hIdx++] = "				<!-- 등록일 -->";
				html[hIdx++] = "				<dl class=\"item__summ--releasedate\">";
				html[hIdx++] = "					<dt>등록일</dt>";
				html[hIdx++] = "					<dd>" + strCdate.substring(0, 4) + "." + strCdate.substring(4, 6) + "</dd>";
				html[hIdx++] = "				</dl>";
				html[hIdx++] = "				<!-- 배송료 -->";
				//html[hIdx++] = "				<p class=\"item__summ--delivery\">"+strDeliveryInfo+"</p>";
				html[hIdx++] = "			</div>";
				html[hIdx++] = "			<!-- 기타 -->";
				html[hIdx++] = "			<div class=\"item__etc item__etc--soho\">";
				html[hIdx++] = "				<ul>";
				html[hIdx++] = "					<!-- 상품평/평점 -->";
				if(strBbsNum!="0") {
					html[hIdx++] = "				<li class=\"item__etc--score\"><a href=\"" + strLandUrl + "\" target=\"_blank\"><strong>상품평</strong> (" + strBbsNum.format() + ")</a></li>";
				}
				html[hIdx++] = "				</ul>";
				html[hIdx++] = "			</div>";
				html[hIdx++] = "		</div>";
				html[hIdx++] = "		<!-- // -->";
				html[hIdx++] = "	</div>";
				html[hIdx++] = "	<!-- 옵션, 쇼핑몰 더보기 / 쇼핑몰 바로가기 -->";
				html[hIdx++] = "	<div class=\"item__foot\">";
				html[hIdx++] = "		<!-- 버튼 : 옵션 펼치기 -->";
				html[hIdx++] = "		<a href=\"" + strLandUrl + "\" class=\"btn--opt-soho\" target=\"_blank\">"+strShopName+"</a>";
				html[hIdx++] = "		<!-- // -->";
				html[hIdx++] = "	</div>";
				html[hIdx++] = "</div>";
			}
		}
		html[hIdx++] = "		</li>";
		// 						<!-- // -->
	});
	
	$(".goods-bundle").html(html.join(""));

	//검색어 하일라이트
	chgHighlighttxt();

	// 오픈쇼핑, 슈퍼탑라이트 미 삽입 예외 처리 ( 상품이 7개가 되지 않는 경우 )
	if (viewType == 1 && $(".goods-bundle").find("li[data-type=adline]").length == 0 && $("li.prodItem").length > 0 && dataObj.data.list.length < 7 && param_sort == 1) {
		if (param_pageNum == 1 && param_tabType == 0 && attrSelCnt == 0) {
			$("li.prodItem").last().after("<li data-type=\"adline\" style=\"display:none;\"></li>");
		}
	}

	// 슈퍼탑 노출 조건이 아니면 슈퍼탑 삭제
	if (param_pageNum != 1 || param_tabType != 0 && ((param_inKeyword.length > 0 && attrSelCnt > 1) || attrSelCnt > 0)) {
		$(".prodItem.ad").remove();
	}

	loading("hide");

	paging(dataObj.total); // 페이징

	// 모델 이미지 위 태그 색상 노출
	setListImageInIconSet();

	// 후처리 list_func.js 최초 로드시에만 호출
	if (firstLoadFlag) {
		firstLoadFlag = false;
		loadListAddData();

		// SRP 부분검색어
		if (dataObj.data.searchedKeywordAry && dataObj.data.searchedKeywordAry.length > 0) {
			// 키워드 , 선택 배열, 전체 배열
			drawPartialSearch(dataObj.data.searchedKeyword, dataObj.data.searchedKeywordAry, dataObj.data.searchedKeywordOrgAry);
		}
		
		//트렌드를 한 번에 ( 구매가이드, 리뷰, 뉴스 )
		getRightWingKnowboxContent(dataObj.data.strCaCode);
	
		// srp HOT키워드
		if(listType=="search") {
			setSearchIngiKeywrd(1);
			setSearchIngiKeywrd(2);
		}
	}

	// 뉴스, 이벤트, 사용기, 리뷰 등등.... 
	setModelEvent();
	setReview();

	if ((modelNoSet && modelNoSet.size > 0) || (plNoSet && plNoSet.size > 0)) {
		// SRP 해당 카테고리로 ( 표준PC가 있을경우에는 표준PC앞으로 )
		if (listType == "search") {
			getModelCateListLinkTitle();
		}
	}

	// 슈퍼탑
	if (param_pageNum == 1 && param_sort == 1 && param_tabType == 0 && dataObj.data.supertopADNos.length > 0 && (attrSelCnt == 0 || (attrSelCnt == 1 && param_inKeyword.length > 0))) {
		// 슈퍼탑이 있는 경우 T5 배너는 슈퍼탑을 그리고 나서 
		loadSupertop(dataObj.data.supertopADNos, $(".ad"), $(".highrank"));
	} else {
		// LP 중단 배너 ( T5 )
		if (listType == "list" && dataObj.data.supertopADNos.length == 0 ) {
			loadLPCenterBanner(param_cate.substring(0, 4));
		}
	}

	// 슈퍼탑을 그리기 위한 정보를 삭제 supertop.js 에서 그림
	if ($(".ad").length > 0) {
		$(".ad").remove();
	}

	// 갤러리뷰 에서 슈퍼탑이 없거나 2페이지 부터 갤러리뷰 상품 메우기 로직
	if (viewType == 2 && (param_pageNum > 1 || dataObj.data.supertopADNos.length == 0) && (dataObj.data.nonAdItemSize == param_pageGap)) {

		var prodLength = $("li.prodItem").length;
		var useCount = 0;
		if (prodLength > 4) {
			useCount = 4 - ($("li.prodItem").length % 4);
		}
		if (useCount == 4) {
			useCount = 0;
		}

		var highRankData = $(".highrank");
		// 갤러리뷰의 한 줄의 상품카드가 4개 이고, 부족한 갯수만큼 채운다.
		for (var i = 0; i < useCount; i++) {
			var addHtml = highRankData[i].outerHTML;
			if (addHtml.length > 0) {
				$(".goods-list .goods-bundle").append(highRankData[i].outerHTML);
			}
		}

		// 추가된 돔에 대하여 순위제거
		var addIndexCount = $("li.prodItem.highrank").length - useCount;
		$("li.prodItem.highrank").each(function(index, item) {
			if (index >= addIndexCount) {
				$(this).addClass("fill");
				$(this).find(".item__model").removeClass("has--tag");
				$(this).find(".tag--rank").remove();
			}
		});
		$("li.prodItem.highrank").removeClass("highrank");

		// 갤러리뷰 파워클릭 삽입 ( 슈퍼탑 없는 ver )
		if (param_pageNum == 1 && attrSelCnt == 0 && param_sort == 1) {
			// 파워클릭 -> 애드쇼핑 -> 애드오피스
			if (listType == "list") {
				// getPowerClick(파라미터, 파워클릭여부, 애드쇼핑여부, 애드오피스여부)
				getPowerClick(param_cate, blADPowerClick, blADShopping, blADOffice);
			} else if (listType == "search" && (firstGoodsCate !== undefined && firstGoodsCate.length > 0)) {
				getPowerClick(firstGoodsCate, blADPowerClick, blADShopping, blADOffice);
			}
		}
	} else if (param_pageNum == 1 && attrSelCnt == 0 && param_sort == 1 && dataObj.data.supertopADNos.length == 0) {
		// 파워클릭 -> 애드쇼핑 -> 애드오피스
		if (listType == "list") {
			getPowerClick(param_cate, blADPowerClick, blADShopping, blADOffice);
		} else if (listType == "search" && (firstGoodsCate !== undefined && firstGoodsCate.length > 0)) {
			getPowerClick(firstGoodsCate, blADPowerClick, blADShopping, blADOffice);
		}
	}
	
	// 파워링크
	if (listType == "list") {
		getPowerLink("LP", param_cate, param_inKeyword);
	} else {
		getPowerLink("SRP", param_cate, param_keyword);
	}

	// 파워쇼핑
	if (listType == "list") {
		getPowerShopping("LP", param_cate, null);
	} else if (listType == "search" && (firstGoodsCate !== undefined && firstGoodsCate.length > 0)) {
		getPowerShopping("SRP", firstGoodsCate, param_keyword);
	}

	// 쿠폰 내용
	Object.keys(couponContentsObj).forEach(function(data) {
		if (data.indexOf(":") > -1) {
			var splitData = data.split(":");
			if (splitData[0] == "G") {
				$(".prodItem[data-id=model_" + splitData[1] + "] .tag--coupon .lay-comm--body .lay-coupon__price").before(couponContentsObj[data].replace(/\r\n/gi, "<br>"));
			} else if (splitData[0] == "P") {
				$(".prodItem[data-id=pl_" + splitData[1] + "] .tag--coupon .lay-comm--body .lay-coupon__price").before(couponContentsObj[data].replace(/\r\n/gi, "<br>"));
			}
		}
	});
	
	// 최근 본 저장
	if (listType == "list") {
		var recentCates = getCookie("recentCates");
		var arrTmpCate = new Array();
		if(recentCates !=null && recentCates !=""){
			arrTmpCate = recentCates.split(",");
			if(!arrTmpCate.includes(param_cate)) arrTmpCate.push(param_cate);
			if(arrTmpCate.length > 30) arrTmpCate.shift();
		}else{
			arrTmpCate.push(param_cate);
		}
		setCookieCommon("recentCates", arrTmpCate.join(","));
	}
}


// 페이징
function paging(itemTotalCnt) {

	// pages 페이징 그리는 영역
	// param_pageNum 현재 페이지 
	// param_pageGap 페이지당 갯수
	// itemTotalCnt 전체갯수
	// totalPage 총페이지 수
	// pageCount 페이지에서 보여져야 할 갯수
	// pageGroup 페이지 그룹
	// first 화면에 보여질 첫번째 숫자
	// last 화면에 보여질 마지막 숫자
	// prev 이전 숫자
	// next 다음 숫자

	if ($(".goods-list .paging").length == 0) {
		$(".goods-list").append("<div class=\"paging\"></div>");
	}

	var pages = $(".goods-list div.paging");

	var totalPage = Math.ceil(itemTotalCnt / param_pageGap);
	var pageCount = 10;
	var pageGroup = Math.ceil(param_pageNum / pageCount);
	var last = pageGroup * pageCount;
	if (last > totalPage) {
		last = totalPage;
	}
	var first = last - (pageCount - 1);
	var prev = first - 1;
	var next = last + 1;

	if (totalPage < 1) {
		first = last;
	}
	if (first < 1) {
		first = 1;
	}

	var html = [];
	var hIdx = 0;

	html[hIdx++] = "<div class=\"paging__inner\">";
	for (var i = first; i <= last; i++) {
		// 현재 페이지 .is--on
		if (i == param_pageNum) {
			html[hIdx++] = "<a href=\"javascript:void(0);\" class=\"paging__item is--on\" data-page=\"" + i + "\">" + i + "</a>";
		} else {
			html[hIdx++] = "<a href=\"javascript:void(0);\" class=\"paging__item\" data-page=\"" + i + "\">" + i + "</a>";
		}
	}

	// <!-- 이전/다음 페이지 없을때 .is--disabled 붙여주세요 -->
	if (pageGroup > 1) {
		html[hIdx++] = "<button class=\"paging__btn--prev\" data-page=\"" + (first - 1) + "\"><i class=\"ico-paging-prev comm__sprite\">이전</i></button>";
	} else {
		html[hIdx++] = "<button class=\"paging__btn--prev is--disabled\"><i class=\"ico-paging-prev comm__sprite\">이전</i></button>";
	}

	if (pageGroup == Math.ceil(totalPage / pageCount)) {
		html[hIdx++] = "<button class=\"paging__btn--next is--disabled\"><i class=\"ico-paging-next comm__sprite\">다음</i></button>";
	} else {
		html[hIdx++] = "<button class=\"paging__btn--next\" data-page=\"" + (last + 1) + "\"><i class=\"ico-paging-next comm__sprite\">다음</i></button>";
	}
	pages.html(html.join(""));

	// 법적 고지 메세지
	$(".goods-list").append("<div class=\"gooods-list__tx--noti\">※ 제조사명(판매사명)/브랜드명 및 로고는 각 제조사(판매사)의 상표 또는 등록상표 입니다. <a href=\"/etc/disclaimer.jsp\" target=\"_blank\">&lt;법적고지&gt;</a></div>");
}

// 검색결과 없을 때
function drawNoData() {

	var appendObj = $(".goods-list");

	var html = [];
	var hIdx = 0;

	if (listType == "search" && firstLoadFlag) {
		$(".list-head").hide();
	}

	// 탭 카운트 표기
	$("ul.list-filter__tab li").find(".list-tab--count").text("");
	if (param_tabType == 0 && attrSelCnt==0) {
		$("ul.list-filter__tab li[tabType=0]").find(".list-tab--count").text("0");
		$("ul.list-filter__tab li[tabType=1]").find(".list-tab--count").text("0");
		$("ul.list-filter__tab li[tabType=2]").find(".list-tab--count").text("0");
	} else if (param_tabType == 3) {
		$("ul.list-filter__tab li[tabType=3]").find(".list-tab--count").text("0");
	} else if (param_tabType == 4) {
		$("ul.list-filter__tab li[tabType=4]").find(".list-tab--count").text("0");
	} else {
		$("ul.list-filter__tab li[tabType=" + param_tabType + "]").find(".list-tab--count").text("0");
	}

	// SRP 일반검색 시 ( 결과내 검색어 있을 경우 제외 )
	if (listType == "search" && param_keyword.length > 0 && param_inKeyword.length == 0) {
		html[hIdx++] = "<div class=\"no-result--list\" id=\"noSearchListDiv\">";
		html[hIdx++] = "	<div class=\"no-result__inner\">";
		html[hIdx++] = "		<div class=\"no-result__tit\">";
		html[hIdx++] = "			<em>" + param_keyword + "</em> 검색결과가 없습니다.";
		html[hIdx++] = "		</div>";
		html[hIdx++] = "		<div class=\"no-result__txt\">";
		html[hIdx++] = "			<div class=\"no-result__txt--sub\">정확한 검색어인지 확인하시고 다시 검색해 주세요.</div>";
		html[hIdx++] = "			<ul class=\"no-result__txt--case\">";
		html[hIdx++] = "				<li>· 검색어의 철자가 맞는지 확인해 주세요.</li>";
		html[hIdx++] = "				<li>· 붙은 단어일 경우 띄어쓰기를 해보세요.</li>";
		html[hIdx++] = "				<li>· 단어수를 줄이거나, 일반적인 검색어로 다시 검색해 보세요.</li>";
		html[hIdx++] = "			</ul>";
		html[hIdx++] = "		</div>";
		html[hIdx++] = "	</div>";
		html[hIdx++] = "	<div class=\"no-result__foot\">";
		html[hIdx++] = "찾고자 하는 상품이 없으신가요? <a href=\"/faq/customer_seller.jsp?faq_type=4\" class=\"btn--request\" target=\"_blank\">신상품 등록요청</a>";
		html[hIdx++] = "	</div>";
		html[hIdx++] = "</div>";
	} else {
		html[hIdx++] = "<div class=\"no-result--list\" id=\"noSearchListDiv\">";
		html[hIdx++] = "	<div class=\"no-result__inner\">";
		html[hIdx++] = "		<div class=\"no-result__tit\">";
		html[hIdx++] = "			<i class=\"ico-caution\">!</i><em>선택 조건</em>에 해당하는 검색결과가 없습니다.";
		html[hIdx++] = "		</div>";
		html[hIdx++] = "	</div>";
		if (listType == "search") {
			html[hIdx++] = "	<div class=\"no-result__foot\">";
			html[hIdx++] = "찾고자 하는 상품이 없으신가요? <a href=\"/faq/customer_seller.jsp?faq_type=4\" class=\"btn--request\" target=\"_blank\">신상품 등록요청</a>";
			html[hIdx++] = "	</div>";
		}
		html[hIdx++] = "</div>";
	}

	// 최근본 상품 + 유사항품 가져오기
	if (listType == "search" && firstLoadFlag) {
		loadSuggestGoods();
	}
	appendObj.html(html.join(""));

	// 부분검색어 결과 없을 시
	if (listType == "search" && param_isResearch == "N") {
		$(".sr-keyword").text(param_keyword);
		$(".sr-keyword--info-sub").hide();
	}

	loading("hide"); // 로딩바 없애기
}

// 리스트 API 호출 실패시
function failList(errorObj) {
	console.log("LP/SRP list API Call Fail : " + errorObj.statusText);
	drawNoData();
}

// 속성 정보 호출
function loadAttrs() {

	// LP 속성은 _는 AND조건, ,는 OR조건
	// ex) spec=3313,205,_6678,3695,3694,
	var $customSpecArray = new Array();
	var $customSpecNameArray = new Array();
	var $customSpec = "";
	var $customSpecName = "";
	var $customTmpString = "";
	var $customTmpNameString = "";
	var $customSpecArrayCount = 0;
	var $customSpecNameArrayCount = 0;
	
	$("dl.search-box-row[data-attr-type=spec]").each(function(index, item) {
		$customTmpString = "";
		$customTmpNameString = "";
		$(this).find("li.sel").each(function(sub_index, sub_item) {
			if ($customTmpString.length > 0) {
				$customTmpString += ",";
				$customTmpNameString += ",";
			}
			if($(this).find("button[data-type=smartfinder_button]").length>0) {
				$customTmpNameString += $.trim($(this).find("span.tx_attr").text());
			} else if($(this).find("button[data-type=smartfinder_texthighlight]").length>0) {
				$customTmpNameString += $.trim($(this).find("span.tx_attr").text());
			} else {
				$customTmpNameString += $.trim($(this).find("label").text());
			}
		});
		if ($customTmpString.length > 0) {
			$customSpecArray[$customSpecArrayCount++] = $customTmpString;
		}
		if ($customTmpNameString.length > 0) {
			$customSpecNameArray[$customSpecNameArrayCount++] = $customTmpNameString;
		}
	});
	$customSpec = $customSpecArray.join(",_");
	$customSpecName = $customSpecNameArray.join(",_");

	// 파라미터
	var listParam = {
		"from": listType,
		"device": "pc",
		"category": param_cate,
		"tab": param_tabType,
		"isDelivery": param_isDelivery,
		"isRental": param_isRental,
		"pageNum": param_pageNum,
		"pageGap": param_pageGap,
		"sort": param_sort,
//		"factory": encodeURIComponent(param_factory),
//		"factory_code": param_factorycode,
//		"brand": encodeURIComponent(param_brand),
//		"brand_code": param_brandcode,
//		"shopcode": param_shopcode,
		"keyword": encodeURIComponent(param_keyword),
//		"in_keyword": encodeURIComponent(param_inKeyword),
//		"s_price": param_sPrice,
//		"e_price": param_ePrice,
//		"spec": $customSpec,
//		"spec_name": encodeURIComponent($customSpecName),
		"color": param_color,
		"isReSearch": param_isResearch,
		"isTest": (blDevMode) ? "Y" : "N",
		"prtmodelno": param_prtmodelno,
		"isMakeshop": "Y",
		"discount": param_discount,
		"bbsscore" : param_bbsscore
	};

	// 속성 API 호출
	var attrDataPromise = $.ajax({
		type: "POST",
		url: "/wide/api/listSpec.jsp",
		dataType: "json",
		data: listParam
	});
	
	attrDataPromise.then(drawAttr, failAttr);
}

//속성 정보 그리기
function drawAttr(dataObj) {
	
	// 소카테고리는 상품의 유무와 상관없이 노출됨
	// 소카테고리
	if (listType == "list") {
		if (dataObj.data.category !== undefined) {
			var caetgoryLNBObj = $(".category-lp");
			var cateListHtml = [];
			var cateListIdx = 0;
			var selSubCateName = "";
			var data_key = "";
			var data_name = "";

			cateListHtml[cateListIdx++] = "<h2 class=\"category-lp__name\">";
			cateListHtml[cateListIdx++] = "	<a href=\"/list.jsp?cate=" + param_cate.substring(0, 4) + "\">" + dataObj.data.category.mCateName + "</a>";
			cateListHtml[cateListIdx++] = "</h2>";
			if (dataObj.data.category.depth_3.length > 0) {
				cateListHtml[cateListIdx++] = "<ul class=\"category-lp__list\">";
				for (var i = 0; i < dataObj.data.category.depth_3.length; i++) {

					if (dataObj.data.category.depth_3[i].data !== undefined) {

						data_key = dataObj.data.category.depth_3[i].data.code;
						data_name = dataObj.data.category.depth_3[i].data.name;

						var addClass = "";
						if (param_cate.length >= 6 && data_key == param_cate.substring(0, 6)) {
							addClass += " is--on";
							selSubCateName = data_name;
						}
						if (dataObj.data.category.depth_3[i].child !== undefined && dataObj.data.category.depth_3[i].child.length > 0) {
							addClass += " has-child";
						}
						cateListHtml[cateListIdx++] = "<li class=\"category-lp__item " + addClass + "\">";
						if(data_key !== undefined && data_key.length>0) {
							cateListHtml[cateListIdx++] = "	<a href=\"/list.jsp?cate=" + data_key + "\">" + data_name + "</a>";
						} else if(dataObj.data.category.depth_3[i].data.linkUrl !== undefined && dataObj.data.category.depth_3[i].data.linkUrl.length>0){
							cateListHtml[cateListIdx++] = "	<a href=\"" + dataObj.data.category.depth_3[i].data.linkUrl + "\">" + data_name + "</a>";
						}
						// child 미카테 노출
						var child_cate = "";
						var child_name = "";
						if (dataObj.data.category.depth_3[i].child !== undefined && dataObj.data.category.depth_3[i].child.length > 0) {
							cateListHtml[cateListIdx++] = "<span class=\"bar\">|</span>";
							cateListHtml[cateListIdx++] = "<div class=\"category-lp__down\">";
							cateListHtml[cateListIdx++] = "	<ul>";
							$.each(dataObj.data.category.depth_3[i].child, function(child_key, child_data) {
								child_cate = child_data.code;
								child_name = child_data.name;
								if(child_cate !== undefined && child_cate.length>0) {
									cateListHtml[cateListIdx++] = "	<li><a href=\"/list.jsp?cate=" + child_cate + "\" title=\"" + child_name + "\">" + child_name + "</a></li>";
								} else if(child_data.linkUrl !== undefined && child_data.linkUrl.length>0) {
									cateListHtml[cateListIdx++] = "	<li><a href=\"" + child_data.linkUrl + "\" title=\"" + child_name + "\">" + child_name + "</a></li>";
								}
							});

							cateListHtml[cateListIdx++] = "	</ul>";
							cateListHtml[cateListIdx++] = "</div>";
						}

						cateListHtml[cateListIdx++] = "</li>";
					}
				};
				cateListHtml[cateListIdx++] = "</ul>";
			}
			caetgoryLNBObj.html(cateListHtml.join(""));
			caetgoryLNBObj.show();
		}
	}
	
	// 예외처리
	if (dataObj.success === undefined || !dataObj.success || dataObj.total == 0) {
		return;
	}

	// 출시예정 상품 있을 경우 "출시예정" 버튼 노출
	if ((dataObj.data.strOpenExpectYN !== undefined && dataObj.data.strOpenExpectYN == "Y") && !blNewListBtnCheck) {
		$(".list-filter__btn.sortFilter").show();
		blNewListBtnIsset = true;
	} else {
		$(".list-filter__btn.sortFilter").hide();
	}

	var appendObj = $(".adv-search");

	// SRP 에서 카테고리 갯수 표시
	if (listType == "search" && dataObj.data.reqCateCount !== undefined) {
		$("#topAllCateCnt").text(dataObj.data.reqCateCount.format());
	}

	// 미카테고리
	if (listType == "list") {
		if (dataObj.data.category !== undefined) {
			if (dataObj.data.category.depth_4.length > 0 && selSubCateName.length > 0) {
				var dCateObj = $(".category-lp--fine");
				var dCateHtml = [];
				var dCateIdx = 0;
				var dCateAddClass = "";
				if (dataObj.data.category.depth_4.length > 6) {
					dCateAddClass += " type--line2";
				}
				dCateHtml[dCateIdx++] = "<dl class=\"search-box-row is--unfold " + dCateAddClass + "\">";
				dCateHtml[dCateIdx++] = "	<dt class=\"search-box__head\">";
				dCateHtml[dCateIdx++] = "		<div class=\"search-box__head--title\">";
				dCateHtml[dCateIdx++] = "			<div class=\"search-box__head--inner\">";
				//										<!-- 속성명 / 카운트 -->
				dCateHtml[dCateIdx++] = "				<p class=\"search-box__head--name\">\"" + selSubCateName + "\" <span class=\"tx_sub\">하위 카테고리입니다.</span></p>";
				//										<!-- 버튼 : 펼침/닫기 -->
				dCateHtml[dCateIdx++] = "			</div>";
				dCateHtml[dCateIdx++] = "		</div>";
				//								<!-- // -->
				dCateHtml[dCateIdx++] = "	</dt>";
				dCateHtml[dCateIdx++] = "	<dd class=\"search-box__body\">";
				dCateHtml[dCateIdx++] = "		<div class=\"search-box__inner\">";
				dCateHtml[dCateIdx++] = "			<ul class=\"search-box__list list-form--radio\">";

				for (var i = 0; i < dataObj.data.category.depth_4.length; i++) {
					var sub_key = dataObj.data.category.depth_4[i].code;
					var sub_name = dataObj.data.category.depth_4[i].name;
					if(sub_key !== undefined && sub_key.length>0) {
						dCateHtml[dCateIdx++] = "		<li data-cate=\"" + sub_key + "\">";
						if (param_cate == sub_key) {
							dCateHtml[dCateIdx++] = "		<input type=\"radio\" id=\"radioLPCATE_" + sub_key + "\" name=\"radioLPCATE\" class=\"input--radio-item\" checked=\"checked\"><label for=\"radioLPCATE_" + sub_key + "\">" + sub_name + "</label>";
						} else {
							dCateHtml[dCateIdx++] = "		<input type=\"radio\" id=\"radioLPCATE_" + sub_key + "\" name=\"radioLPCATE\" class=\"input--radio-item\"><label for=\"radioLPCATE_" + sub_key + "\">" + sub_name + "</label>";
						}
						dCateHtml[dCateIdx++] = "		</li>";
					} else if(dataObj.data.category.depth_4[i].linkUrl !== undefined && dataObj.data.category.depth_4[i].linkUrl.length > 0) {
						dCateHtml[dCateIdx++] = "		<li data-url=\"" + dataObj.data.category.depth_4[i].linkUrl + "\">";
						dCateHtml[dCateIdx++] = "			<input type=\"radio\" id=\"radioLPCATE_LINK_" + i + "\" name=\"radioLPCATE_LINK\" class=\"input--radio-item\"><label for=\"radioLPCATE_LINK_" + i + "\">" + sub_name + "</label>";
						dCateHtml[dCateIdx++] = "		</li>";
					}
				}

				dCateHtml[dCateIdx++] = "			</ul>";
				dCateHtml[dCateIdx++] = "		</div>";
				dCateHtml[dCateIdx++] = "	</dd>";
				dCateHtml[dCateIdx++] = "</dl>";

				dCateObj.html(dCateHtml.join(""));
				dCateObj.show();

			}
		}
	}

	// 추천카테고리
	if (listType == "search") {

		if (param_cate.length > 0 && dataObj.data.reqCateSelList !== undefined && Object.keys(dataObj.data.reqCateSelList).length > 0) {

			var reqCateListObj = $(".category-srp--list-cate");
			var reqCateListHtml = [];
			var reqCateListIdx = 0;

			reqCateListHtml[reqCateListIdx++] = "	<div class=\"category-srp__head\">";
			reqCateListHtml[reqCateListIdx++] = "		<ul class=\"category-srp__location\">";
			reqCateListHtml[reqCateListIdx++] = "			<li data-type=\"all\"><a href=\"javascript:void(0);\" data-type=\"all\">전체</a></li>";
			if (dataObj.data.reqCateSelList.cateCode1 !== undefined && dataObj.data.reqCateSelList.cateCode1.length > 0 && dataObj.data.reqCateSelList.cateName1 !== undefined && dataObj.data.reqCateSelList.cateName1.length > 0) {
				if (dataObj.data.reqCateSelList.cateCode2 === undefined || dataObj.data.reqCateSelList.cateName2 === undefined) {
					reqCateListHtml[reqCateListIdx++] = "		<li data-type=\"depth1\"><span class=\"tx--cate\">" + dataObj.data.reqCateSelList.cateName1 + "</span> <span class=\"tx--count\">(상품수 : <em>" + dataObj.total.format() + "</em>)</span></li>";
				} else {
					//reqCateListHtml[reqCateListIdx++] = "		<li data-type=\"depth1\"><a href=\"/search.jsp?keyword="+param_keyword+"&cate="+dataObj.data.reqCateSelList.cateCode1+"&from=list\">"+dataObj.data.reqCateSelList.cateName1+"</a></li>";
					reqCateListHtml[reqCateListIdx++] = "		<li data-type=\"depth1\"><a>" + dataObj.data.reqCateSelList.cateName1 + "</a></li>";
				}
			}
			if (dataObj.data.reqCateSelList.cateCode2 !== undefined && dataObj.data.reqCateSelList.cateCode2.length > 0 && dataObj.data.reqCateSelList.cateName2 !== undefined && dataObj.data.reqCateSelList.cateName2.length > 0) {
				if (dataObj.data.reqCateSelList.cateCode3 === undefined || dataObj.data.reqCateSelList.cateName3 === undefined) {
					reqCateListHtml[reqCateListIdx++] = "		<li data-type=\"depth2\"><span class=\"tx--cate\">" + dataObj.data.reqCateSelList.cateName2 + "</span> <span class=\"tx--count\">(상품수 : <em>" + dataObj.total.format() + "</em>)</span></li>";
				} else {
					reqCateListHtml[reqCateListIdx++] = "		<li data-type=\"depth2\"><a href=\"/search.jsp?keyword=" + param_keyword + "&cate=" + dataObj.data.reqCateSelList.cateCode2 + "&from=list\">" + dataObj.data.reqCateSelList.cateName2 + "</a></li>";
				}
			}
			if (dataObj.data.reqCateSelList.cateCode3 !== undefined && dataObj.data.reqCateSelList.cateCode3.length > 0 && dataObj.data.reqCateSelList.cateName3 !== undefined && dataObj.data.reqCateSelList.cateName3.length > 0) {
				reqCateListHtml[reqCateListIdx++] = "		<li data-type=\"depth3\"><span class=\"tx--cate\">" + dataObj.data.reqCateSelList.cateName3 + "</span> <span class=\"tx--count\">(상품수 : <em>" + dataObj.total.format() + "</em>)</span></li>";
			}

			reqCateListHtml[reqCateListIdx++] = "		</ul>";
			reqCateListHtml[reqCateListIdx++] = "	</div>";
			if (dataObj.data.reqCateSelList.sCateList !== undefined && dataObj.data.reqCateSelList.sCateList.length > 0) {
				reqCateListHtml[reqCateListIdx++] = "	<ul class=\"category-srp__list\">";
				$(dataObj.data.reqCateSelList.sCateList).each(function(index, item) {
					reqCateListHtml[reqCateListIdx++] = "	<li>";
					reqCateListHtml[reqCateListIdx++] = "		<a href=\"javascript:void(0);\" data-cate=\""+item.cateCode+"\">";
					if (item.cateCode == param_cate) {
						reqCateListHtml[reqCateListIdx++] = "		<span class=\"tx--cate is--on\">" + item.cateName + "</span>";
					} else {
						reqCateListHtml[reqCateListIdx++] = "		<span class=\"tx--cate\">" + item.cateName + "</span>";
					}
					reqCateListHtml[reqCateListIdx++] = "			<span class=\"tx--count\">(" + item.cateCnt.format() + ")</span>";
					reqCateListHtml[reqCateListIdx++] = "		</a>";
					reqCateListHtml[reqCateListIdx++] = "	</li>";
				});
				reqCateListHtml[reqCateListIdx++] = "	</ul>";
			}
			reqCateListObj.html(reqCateListHtml.join(""));
			reqCateListObj.show();

		} else if (param_cate.length == 0 && dataObj.data.reqCateBest !== undefined && dataObj.data.reqCateBest.length > 0) {
			var reqCateObj = $(".category-srp--recom-cate");
			var reqCateHtml = [];
			var reqCateIdx = 0;

			reqCateHtml[reqCateIdx++] = "	<dl class=\"search-box-row\">";
			reqCateHtml[reqCateIdx++] = "		<dt class=\"search-box__head\">";
			reqCateHtml[reqCateIdx++] = "			<div class=\"search-box__head--title\">";
			reqCateHtml[reqCateIdx++] = "				<div class=\"search-box__head--inner\">";
			reqCateHtml[reqCateIdx++] = "					<p class=\"search-box__head--name\">추천 카테고리</p>";
			reqCateHtml[reqCateIdx++] = "				</div>";
			reqCateHtml[reqCateIdx++] = "			</div>";

			//										<!-- 버튼 : 펼침/닫기 -->
			if (dataObj.data.reqCateBest.length == 5) {
				reqCateHtml[reqCateIdx++] = "		<div class=\"search-box__util\">";

				if (dataObj.data.reqCateCount !== undefined && dataObj.data.reqCateCount > 5) {
					reqCateHtml[reqCateIdx++] = "		<span class=\"search-box__util--count\"><em>" + dataObj.data.reqCateCount + "</em>개</span>";
				}

				reqCateHtml[reqCateIdx++] = "			<button type=\"button\" class=\"search-box__btn--unfold\" onclick=\"$(this).closest('.search-box-row').toggleClass('is--unfold');\"></button>";
				reqCateHtml[reqCateIdx++] = "		</div>";
			}
			//										<!-- // -->
			reqCateHtml[reqCateIdx++] = "		</dt>";
			reqCateHtml[reqCateIdx++] = "		<dd class=\"search-box__body\">";
			reqCateHtml[reqCateIdx++] = "			<div class=\"search-box__inner\">";
			reqCateHtml[reqCateIdx++] = "				<ul class=\"search-box__list\">";
			$(dataObj.data.reqCateBest).each(function(index, item) {
				
				// 메이크샵 브랜드스토어 호출
				if(index==0) { loadbrandStore(item.cate); }
				
				reqCateHtml[reqCateIdx++] = "				<li>";
				reqCateHtml[reqCateIdx++] = "					<a href=\"javascript:void(0);\" class=\"category-srp__item\" data-cate=\""+item.cate+"\">";
				reqCateHtml[reqCateIdx++] = "						<span class=\"tx--name\">" + item.name + "</span><span class=\"tx--count\">" + item.cnt.format() + "</span>";
				reqCateHtml[reqCateIdx++] = "					</a>";
				reqCateHtml[reqCateIdx++] = "				</li>";
			});
			reqCateHtml[reqCateIdx++] = "				</ul>";
			reqCateHtml[reqCateIdx++] = "			</div>";
			reqCateHtml[reqCateIdx++] = "		</dd>";
			reqCateHtml[reqCateIdx++] = "	</dl>";

			//								<!--추천 카테고리 확장 영역 -->
			if (dataObj.data.reqCateList !== undefined && dataObj.data.reqCateList.length > 0) {
				reqCateHtml[reqCateIdx++] = "<div class=\"search-box--expend\">";
				$(dataObj.data.reqCateList).each(function(index, item) {
					reqCateHtml[reqCateIdx++] = "<dl class=\"search-box-row\">";
					reqCateHtml[reqCateIdx++] = "	<dt class=\"search-box__head\">";
					reqCateHtml[reqCateIdx++] = "		<div class=\"search-box__head--title\">";
					reqCateHtml[reqCateIdx++] = "			<div class=\"search-box__head--inner\">";
					reqCateHtml[reqCateIdx++] = "				<p class=\"search-box__head--name\">" + item.name + "</p>";
					reqCateHtml[reqCateIdx++] = "			</div>";
					reqCateHtml[reqCateIdx++] = "		</div>";
					if (item.cateList.length > 5) {
						reqCateHtml[reqCateIdx++] = "	<div class=\"search-box__util\">";
						reqCateHtml[reqCateIdx++] = "		<span class=\"search-box__util--count\"><em>" + (item.cateList.length - 5) + "</em>개</span>";
						reqCateHtml[reqCateIdx++] = "		<button type=\"button\" class=\"search-box__btn--unfold\" onclick=\"$(this).closest('.search-box-row').toggleClass('is--unfold');\"></button>";
						reqCateHtml[reqCateIdx++] = "	</div>";
					}
					reqCateHtml[reqCateIdx++] = "	</dt>";

					reqCateHtml[reqCateIdx++] = "	<dd class=\"search-box__body\">";
					reqCateHtml[reqCateIdx++] = "		<div class=\"search-box__inner\">";
					reqCateHtml[reqCateIdx++] = "			<ul class=\"search-box__list--recomcate\">";

					$(item.cateList).each(function(sub_index, sub_item) {
						reqCateHtml[reqCateIdx++] = "			<li data-cate=\"" + sub_item.cate + "\">";
						reqCateHtml[reqCateIdx++] = "				<a href=\"/search.jsp?keyword=" + param_keyword + "&cate=" + sub_item.cate + "&from=list\" class=\"category-srp__item--expend\">";
						reqCateHtml[reqCateIdx++] = "					<span class=\"tx--name\">" + sub_item.name + "</span>";
						reqCateHtml[reqCateIdx++] = "					<span class=\"tx--count\">" + sub_item.cnt.format() + "</span>";
						reqCateHtml[reqCateIdx++] = "				</a>";
						reqCateHtml[reqCateIdx++] = "				<span class=\"ico-expend-arr lp__sprite\" data-cate=\"" + sub_item.cate + "\"></span>";
						reqCateHtml[reqCateIdx++] = "			</li>";
					});

					reqCateHtml[reqCateIdx++] = "			</ul>";
					reqCateHtml[reqCateIdx++] = "		</div>";
					reqCateHtml[reqCateIdx++] = "	</dd>";
					reqCateHtml[reqCateIdx++] = "</dl>";
				});
				reqCateHtml[reqCateIdx++] = "</div>";
			}

			reqCateObj.html(reqCateHtml.join(""));
			reqCateObj.show();
		}
	}

	var html = [];
	var hIdx = 0;

	html[hIdx++] = "<h3 class=\"blind\">상세검색</h3>";
	html[hIdx++] = "<div class=\"adv-search-box\">";

	// LP 핵심속성
	var orderedArray = new Array();
	var orderedMap = new Map();
	if (listType == "list" && dataObj.data.order !== undefined && dataObj.data.order.length > 0) {
		
		// 이미지 형이나 텍스트 강조 형일 때 딱지 노출된다.
		if(dataObj.data.order[0].imageYN == "Y" || dataObj.data.order[0].highlightYN == "Y") {
			html[hIdx++] = "<div class=\"info_smartfinder\">";
			html[hIdx++] = "	<p class=\"tx_logo\">Smart Finder</p>";
			html[hIdx++] = "	<button type=\"button\" class=\"btn-alert\"><i class=\"ico\">!</i></button>";
			html[hIdx++] = "	<div class=\"lay-alert\">";
			html[hIdx++] = "		<p>스마트파인더란, 카테고리별로 찾고자 하는 상품을 빠르고 쉽게 제공하기 위한 속성검색 추천기능입니다.</p>";
			html[hIdx++] = "	</div>";
			html[hIdx++] = "</div>";
		}
		
		// 핵심속성 노출위치
		html[hIdx++] = "<div data-type=\"smartfinder\">";
		html[hIdx++] = "</div>";

		$(dataObj.data.order).each(function(index, item) {
			orderedMap.set(item.type, item);
		});
	}
	
	var factoryViewFlag = false;
	if (listType == "list" && (lpSetupInfo.sf_factory_viewYN == "" ||  lpSetupInfo.sf_factory_viewYN == "Y")) { 
		factoryViewFlag = true;
	} else if (listType == "search") {
		factoryViewFlag = true;
	}

	if (factoryViewFlag && dataObj.data.factory !== undefined && dataObj.data.factory.length > 0) {
		if (orderedMap.has("FACTORY")) {
			orderedArray[orderedMap.get("FACTORY").index] = drawFactory(dataObj);
		} else {
			html[hIdx++] = drawFactory(dataObj);
		}
	}

	// 브랜드
	var brandViewFlag = false;
	if (listType == "list" && (lpSetupInfo.sf_brand_viewYN == "" || lpSetupInfo.sf_brand_viewYN == "Y")) { 
		brandViewFlag = true;
	} else if (listType == "search") {
		brandViewFlag = true;
	}
	if (brandViewFlag && dataObj.data.brand !== undefined && dataObj.data.brand.length > 0) {
		if (orderedMap.has("REQBRAND")) {
			orderedArray[orderedMap.get("REQBRAND").index] = drawBrand(dataObj, orderedMap.get("REQBRAND"));
		} else if (orderedMap.has("BRAND")) {
			orderedArray[orderedMap.get("BRAND").index] = drawBrand(dataObj, orderedMap.get("BRAND"));
		} else {
			html[hIdx++] = drawBrand(dataObj, null);
		}
	}

	// 쇼핑몰 ( 일반상품에서만 노출 )
	if (dataObj.data.shop !== undefined && dataObj.data.shop.length > 0) {
		if (param_tabType == 2) { // 일반상품에서만 노출
			html[hIdx++] = "	<dl class=\"search-box-row\" data-attr-type=\"shop\">";
		} else {
			html[hIdx++] = "	<dl class=\"search-box-row\" data-attr-type=\"shop\" style=\"display:none;\">";
		}
		html[hIdx++] = "		<dt class=\"search-box__head\">";
		html[hIdx++] = "			<div class=\"search-box__head--title\">";
		html[hIdx++] = "				<div class=\"search-box__head--inner\">";
		//									<!-- 속성명 / 카운트 -->
		html[hIdx++] = "					<p class=\"search-box__head--name\">쇼핑몰</p>";
		html[hIdx++] = "				</div>";
		html[hIdx++] = "			</div>";
		if (dataObj.data.shop.length > attrViewCnt) {
			html[hIdx++] = "			<div class=\"search-box__util\">";
			html[hIdx++] = "				<span class=\"search-box__util--count\"><em>" + (dataObj.data.shop.length - 6) + "</em>개</span>";
			html[hIdx++] = "				<button type=\"button\" class=\"search-box__btn--unfold\" onclick=\"$(this).closest('.search-box-row').toggleClass('is--unfold');\"></button>";
			html[hIdx++] = "			</div>";
		}
		html[hIdx++] = "		</dt>";

		html[hIdx++] = "		<dd class=\"search-box__body\">";
		html[hIdx++] = "			<div class=\"search-box__inner\">";

		$.each(dataObj.data.shop, function(index, item) {
			//							<!-- 반복 : 한줄 최대 6개 / 두줄케이스 12개 -->
			if (index == 0) {
				html[hIdx++] = "		<ul class=\"search-box__list\">";
			}
			html[hIdx++] = "				<li class=\"attrs\" data-attr=\"shop_" + item.shop_code + "_" + item.shop_name + "\"><input type=\"checkbox\" id=\"chShop_" + index + "\" class=\"input--checkbox-item\" data-shopcode=\"" + item.shop_code + "\"><label for=\"chShop_" + index + "\" title=\"" + item.shop_name + "\">" + item.shop_name + "</label></li>";

			if (dataObj.data.shop.length == index + 1) {
				html[hIdx++] = "		</ul>";
			}
		});

		html[hIdx++] = "			</div>";
		html[hIdx++] = "		</dd>";

		html[hIdx++] = "	</dl>";
	}

	// 스펙 ( 전체 / 가격비교 에서만 노출 )
	if(listType == "list" && dataObj.data.custom !== undefined && dataObj.data.custom.length > 0) {
		if (dataObj.data.custom) {
			var vUnfoldFlag = false;
			$.each(dataObj.data.custom, function(index, item) {
				vUnfoldFlag = false;
				if (orderedMap.has(item.strGpno)) {
						if (dataObj.data.unfoldAttr.length > 0 ) {
							$.each(dataObj.data.unfoldAttr, function(i, v) {
								if (v.atr_tp_cd == 3 && v.atr_ref_no == item.strGpno) { //펼쳐야 될 스펙일 때
									vUnfoldFlag = true;
									orderedArray[orderedMap.get(item.strGpno).index] = drawSpec(index, item, "Y", orderedMap.get(item.strGpno), v);
									return false;
								}
							});
						} 
						if (!vUnfoldFlag)	orderedArray[orderedMap.get(item.strGpno).index] = drawSpec(index, item, "Y", orderedMap.get(item.strGpno), null);
				} else {
					html[hIdx++] = drawSpec(index, item, "N", null, null);
				}
			});
		}
	}
	
	//색상
	if (dataObj.data.custom_rgb !== undefined && dataObj.data.custom_rgb.specMenuList !== undefined) {
		customRgbAttrList = dataObj.data.custom_rgb;
		html[hIdx++] = "<dl class=\"search-box-row\" data-attr-type=\"color\">";
		html[hIdx++] = "	<dt class=\"search-box__head\">";
		html[hIdx++] = "		<div class=\"search-box__head--title\">";
		html[hIdx++] = "			<div class=\"search-box__head--inner\">";
		html[hIdx++] = "				<!-- 속성명 / 카운트 -->";
		html[hIdx++] = "				<p class=\"search-box__head--name\">색상<!-- <span class=\"search-box__head--count\">40</span> --></p>";
		html[hIdx++] = "				<!-- 속성명 - 서브 -->";
		html[hIdx++] = "				<!-- <p class=\"search-box__head--sub\">지포스</p> -->";
		html[hIdx++] = "			</div>";
		html[hIdx++] = "		</div>";
		html[hIdx++] = "	</dt>";
		html[hIdx++] = "	<dd class=\"search-box__body\">";
		html[hIdx++] = "		<div class=\"search-box__inner\">";
		$.each(customRgbAttrList.specMenuList, function(index, item) {
			if (index == 0) {
				html[hIdx++] = "	<ul class=\"search-box__list search-box__colorlist\">";
			}
			var btncolor = "";
			if (item.rgb == "FFFFFF") btncolor = " btn-color--white";
			html[hIdx++] = "		<li class=\"attrs\" data-attr=\"color_" + item.strSpecNo + "_" + item.strSpecGroupTitle + "\" data-color=\"" + item.strSpecNo + "\"><button type=\"button\" class=\"btn-color" + btncolor + "\" style=\"background-color:#" + item.rgb + "\">" + item.strSpecGroupTitle + "</button></li>";
			if (customRgbAttrList.specMenuList.length == index + 1) {
				html[hIdx++] = "		</ul>";
			}
		});
		html[hIdx++] = "		</div>";
		html[hIdx++] = "	</dd>";
		html[hIdx++] = "</dl>";
	}
	
	// 평점
	if (listType == "list" && dataObj.data.bbsscore !== undefined && dataObj.data.bbsscore.length > 0) {
		if (orderedMap.has("BBSSCORE")) {
			orderedArray[orderedMap.get("BBSSCORE").index] = drawBbsScore(dataObj);
		} else {
			html[hIdx++] = drawBbsScore(dataObj);
		}
	}
	
	// 할인율
	if (dataObj.data.discount !== undefined && dataObj.data.discount.length > 0) {
		if (orderedMap.has("DISCOUNT")) {
			orderedArray[orderedMap.get("DISCOUNT").index] = drawDiscount(dataObj);
		} else {
			html[hIdx++] = drawDiscount(dataObj);
		}
	}
	
	// 가격대
	/*
	 *  1) 상품 개수 비율로 나눠 가격 상위 10% 및 하위 10% 제외
		2) 남은 가격을 가격대 비율 5개로 나눠 배치
		3) 1번째 가격대 --> 얼마 이하 / 5번째 가격대 --> 얼마 이상
		4) 상품 개수 50개 이하일 때, 가격대 버튼 미노출 & 입력창만 노출
		추가
		1-1) 가격대 첫번째 영역의 끝 값이 0이면 노출안함.
		1-2) 1-1부분 포함 총 3개 이상일때만 노출. 김유미대리(2021-05-24)
	 */
	// 가격대 - 전체상품 기준
	var priceRangeSet_all = new Set();
	if (dataObj.data.price_all !== undefined && dataObj.data.price_all.length > 0 && dataObj.total >= 50) {
		var startPrice_10 = 0;
		var endPrice_10 = 0;

		$.each(dataObj.data.price_all, function(index, item) {
			if (index == 2) { // 하위 10%
				startPrice_10 = item;
			} else if (index == 18) { // 상위 10% 
				endPrice_10 = item;
			}
		});

		if (startPrice_10 > 0 && endPrice_10 > 0) {

			var diffPrice = endPrice_10 - startPrice_10;
			var diffRange = diffPrice / 5;

			// 가격대 영역 5개
			for (var j = 0; j < 5; j++) {
				if (j == 0) {
					if ((Math.round(parseInt(startPrice_10 + diffRange) / 10000) * 10000) > 0) {
						priceRangeSet_all.add("0_" + (Math.round(parseInt(startPrice_10 + diffRange) / 10000) * 10000));
					}
				} else if (j == 4) {
					priceRangeSet_all.add((Math.round(parseInt(startPrice_10) / 10000) * 10000) + "_999999999");
				} else {
					if (Math.round(parseInt(startPrice_10) / 10000) * 10000 != Math.round(parseInt(startPrice_10 + diffRange) / 10000) * 10000) {
						priceRangeSet_all.add((Math.round(parseInt(startPrice_10) / 10000) * 10000) + "_" + (Math.round(parseInt(startPrice_10 + diffRange) / 10000) * 10000));
					}
				}
				startPrice_10 += diffRange;
			}
		}

		if (priceRangeSet_all.size > 2) {
			if (param_tabType != "1" && param_tabType != "2") {
				html[hIdx++] = "<dl class=\"search-box-row row-price-range\" data-attr-type=\"price\" data-price-option=\"all\">";
			} else {
				html[hIdx++] = "<dl class=\"search-box-row row-price-range\" data-attr-type=\"price\" data-price-option=\"all\" style=\"display:none;\">";
			}
			html[hIdx++] = "	<dt class=\"search-box__head\">";
			html[hIdx++] = "		<div class=\"search-box__head--title\">";
			html[hIdx++] = "			<div class=\"search-box__head--inner\">";
			//								<!-- 속성명 / 카운트 -->
			html[hIdx++] = "				<p class=\"search-box__head--name\">가격대</p>";
			html[hIdx++] = "			</div>";
			html[hIdx++] = "		</div>";
			html[hIdx++] = "	</dt>";
			html[hIdx++] = "	<dd class=\"search-box__body\">";
			html[hIdx++] = "		<div class=\"search-box__inner\">";
			html[hIdx++] = "			<ul class=\"search-box__range--price range-class--0" + priceRangeSet_all.size + "\">";
			var rangeCnt = 1;
			var hitFlag = false;

			priceRangeSet_all.forEach(function(item, item_value) {

				var splitPrice = item.split("_");
				var split_s = splitPrice[0];
				var split_e = splitPrice[1];
				var parseMsg = "";

				if (split_e > 0) {
					if (split_s == 0) {
						parseMsg = (split_e / 10000) + "만원 이하";
					} else if (split_e == 999999999) {
						parseMsg = (split_s / 10000) + "만원 이상";
					} else {
						parseMsg = (split_s / 10000) + "~" + (split_e / 10000) + "만원";
					}
					if (parseMsg.length > 0) {
						html[hIdx++] = "	<li class=\"attrs\" data-attr=\"price_" + split_s + "_" + split_e + "\" data-range=\"" + ("range_" + rangeCnt) + "\" data-start=\"" + split_s + "\" data-end=\"" + split_e + "\">";
						html[hIdx++] = "		<button class=\"btn--range-price\">" + parseMsg + "</button>";
						if (!hitFlag && dataObj.data.model_avg_price_all !== undefined && split_e >= dataObj.data.model_avg_price_all) {
							//					<!-- 아이콘 : HIT -->
							html[hIdx++] = "	<i class=\"ico-range-hit lp__sprite\">HIT</i>";
							//					<!-- // -->
							hitFlag = true;
						}
						html[hIdx++] = "	</li>";
						rangeCnt++;
					}
				}
			});

			html[hIdx++] = "			</ul>";
			//							<!-- 가격대 검색 -->
			html[hIdx++] = "			<div class=\"search-box__range--search\">";
			html[hIdx++] = "				<input type=\"text\" class=\"input--text-item start_price\" placeholder=\"0\" onkeyup=\"inputNumberFormat(this)\"> ~ <input type=\"text\" class=\"input--text-item end_price\" placeholder=\"999,999,999\" onkeyup=\"inputNumberFormat(this)\">";
			//								<!-- 버튼 : 가격대 검색 -->
			html[hIdx++] = "				<button class=\"btn--range-search attrs\">가격검색</button>";
			html[hIdx++] = "			</div>";
			//							<!-- // -->
			html[hIdx++] = "		</div>";
			html[hIdx++] = "	</dd>";
			html[hIdx++] = "</dl>";
		}
	}

	// 추천키워드 
	if (listType == "list" && dataObj.data.reqKwd !== undefined && dataObj.data.reqKwd.length > 0 && lpSetupInfo.keyword_cnt > 0) {
		var reqDrawCnt = (lpSetupInfo.keyword_cnt > dataObj.data.reqKwd.length) ? dataObj.data.reqKwd.length : lpSetupInfo.keyword_cnt;

		//				<!-- 상세검색 row : 추천 키워드 .row-recommend -->
		html[hIdx++] = "<dl class=\"search-box-row row-recommend\" data-attr-type=\"reqKwd\">";
		html[hIdx++] = "	<dt class=\"search-box__head\">";
		html[hIdx++] = "		<div class=\"search-box__head--title\">";
		html[hIdx++] = "			<div class=\"search-box__head--inner\">";
		//								<!-- 속성명 / 카운트 -->
		html[hIdx++] = "				<p class=\"search-box__head--name\">추천키워드</p>";
		html[hIdx++] = "			</div>";
		html[hIdx++] = "		</div>";
		html[hIdx++] = "	</dt>";
		html[hIdx++] = "	<dd class=\"search-box__body\">";
		html[hIdx++] = "		<div class=\"search-box__inner\">";
		html[hIdx++] = "			<ul class=\"search-box__keyword\">";
		for (var i = 0; i < reqDrawCnt; i++) {
			var item = dataObj.data.reqKwd[i];
			html[hIdx++] = "			<li class=\"attrs reqKwd\" data-attr=\"reqKwd_" + regSpecExp(item.code) + "\">";
			html[hIdx++] = "				<button class=\"btn--keyword\">" + item.name + "</button>";
			html[hIdx++] = "			</li>";
		}
		html[hIdx++] = "			</ul>";
		html[hIdx++] = "		</div>";
		html[hIdx++] = "	</dd>";

		html[hIdx++] = "</dl>";
	}

	//					<!-- 상세검색 row : 선택한 조건 .row-selected--condition-->
	html[hIdx++] = "	<dl class=\"search-box-row row-selected--condition\" style=\"display:none;\">";
	html[hIdx++] = "		<dt class=\"search-box__head\">";
	html[hIdx++] = "			<div class=\"search-box__head--title\">";
	html[hIdx++] = "				<div class=\"search-box__head--inner\">";
	//									<!-- 속성명 / 카운트 -->
	html[hIdx++] = "					<p class=\"search-box__head--name\">선택한 조건 <span class=\"search-box__head--count\" id=\"attrSelCnt\">0</span></p>";
	html[hIdx++] = "				</div>";
	html[hIdx++] = "			</div>";
	html[hIdx++] = "		</dt>";
	html[hIdx++] = "		<dd class=\"search-box__body\">";
	html[hIdx++] = "			<div class=\"search-box__inner\">";
	//								<!-- 선택한 키워드 -->
	html[hIdx++] = "				<ul class=\"search-box__keyword\">";
	html[hIdx++] = "				</ul>";
	//								<!-- 버튼: 선택 초기화 -->
	html[hIdx++] = "				<button class=\"btn--key-reset lp__sprite\" onclick=\"javascript:void(0);\">선택 초기화</button>";
	html[hIdx++] = "			</div>";
	html[hIdx++] = "		</dd>";
	html[hIdx++] = "	</dl>";

	html[hIdx++] = "</div>";

	if (attrMoreView) {
		//				<!-- 버튼 : 상세검색 > 더보기 -->
		html[hIdx++] = "<button id=\"moreViewOpen\" class=\"adv-search__btn--more\"><span class=\"tx_cnt\" id=\"moreViewOpenCnt\"></span>개 옵션 더보기 <i class=\"ico-adv-arr-down lp__sprite\"></i></button>";
		//				<!-- // -->
		//				<!-- 버튼 : 상세검색 > 닫기 -->
		html[hIdx++] = "<button id=\"moreViewClose\" class=\"adv-search__btn--more\" style=\"display:none;\">닫기<i class=\"ico-adv-arr-up lp__sprite\"></i></button>";
		//				<!-- // -->
	}

	appendObj.html(html.join(""));

	initFactoryHtml = $(".adv-search-box dl[data-attr-type=factory] dd .search-box__inner").html();
	initBrandHtml = $(".adv-search-box dl[data-attr-type=brand] dd .search-box__inner").html();

	//핵심속성 순서조정때문에 기본노출갯수보다 더 많이 보여지고있을때 재조정
	if ($(".adv-search-box .search-box-row[data-attr-type=spec]:visible").length > defaultSpecCnt) {
		var reFormCnt = $(".adv-search-box .search-box-row[data-attr-type=spec]:visible").length - defaultSpecCnt;
		for (var i = 0; i < reFormCnt; i++) {
			var tmpEqCnt = parseInt(defaultSpecCnt + i);
			$(".adv-search-box .search-box-row[data-attr-type=spec]:eq(" + tmpEqCnt + ")").addClass("more_spec").hide();
		}
	}

	// 스마트파인더 그리기
	if (orderedArray.length > 0) {
		var orderedHtml = []; // 순서지정된 html
		var oIdx = 0;
		$(orderedArray).each(function(index, item) {
			if (item !== undefined) {
				orderedHtml[oIdx++] = item;
			}
		});
		if (oIdx > 0) {
			$("div[data-type=smartfinder]").html(orderedHtml.join(""));
		}
	}
	
	//더보기 갯수
	var vMoreSpecLength = $("dl.more_spec").length;
	$("#moreViewOpenCnt").text(vMoreSpecLength);
	
	// 분류검색어 중 키워드 검색어 가 있을 때 
	if (Synonym_From == "search" && Synonym_From_Keyword.length > 0 && param_inKeyword.length > 0) {
		$(".list-filter__search .list-filter__search--input").val(Synonym_From_Keyword);
	}
	
	if(blDeepLink) {
		// 스펙
		if(param_spec.length>0) {
			// MP 속성 ( spec ) 직링크 진입 시
			var tmp_param_spec = param_spec;
			var splitSpec = tmp_param_spec.split(",");
			for (var i = 0; i < splitSpec.length; i++) {
				// 스마트파인더일 경우
				if (listType == "list" && dataObj.data.order !== undefined && dataObj.data.order.length > 0) {
					// 용어사전 있을 경우 label 클릭
					if($("li.attrs[data-spec=" + splitSpec[i] + "]").hasClass("has-dic")) {
						$("li.attrs[data-spec=" + splitSpec[i] + "] label").trigger("click");
					} else {
						$("li.attrs[data-spec=" + splitSpec[i] + "] button").trigger("click");
					}
				} else {
					$("li.attrs[data-spec=" + splitSpec[i] + "] label").trigger("click");
				}
			}
		}
		// 제조사명
		if(param_factory.length>0) {
			// 제조사 속성 ( factory ) 직링크 진입 시
			var tmp_param_factory = param_factory;
			var splitFactory = tmp_param_factory.split(",");
			for (var i = 0; i < splitFactory.length; i++) {
				$("dl[data-attr-type=factory] li.attrs[data-text="+regSpecExp(splitFactory[i])+"] label").trigger("click");
			}
		// 제조사코드
		} else if(param_factorycode.length>0) {
			// 제조사 속성 ( factory ) 직링크 진입 시
			var tmp_param_factorycode = param_factorycode;
			var splitFactoryCode = tmp_param_factorycode.split(",");
			for (var i = 0; i < splitFactoryCode.length; i++) {
				$("dl[data-attr-type=factory] li.attrs[data-attr=factory_"+splitFactoryCode[i]+"] label").trigger("click");
			}
		}
		// 브랜드명
		if(param_brand.length>0) {
			// 브랜드 속성 ( brand ) 직링크 진입 시
			var tmp_param_brand = param_brand;
			var splitBrand = tmp_param_brand.split(",");
			for (var i = 0; i < splitBrand.length; i++) {
				$("dl[data-attr-type=brand] li.attrs[data-text="+regSpecExp(splitBrand[i])+"] label").trigger("click");
			}
		}
		// 결과내 검색어
		if(param_inKeyword.length>0) {
			$("button.list-filter__search--btn").trigger("click");
		}
		loadGoods();
		firstLoadAttrFlag = false;
		blDeepLink = false;
	} else {
		firstLoadAttrFlag = false;
	}
}

//속성 API 호출 실패시
function failAttr(errorObj) {
	console.log("LP/SRP spec API Call Fail : " + errorObj.statusText);
}

// 로딩바 제어
function loading(type) {

	var loadingObj = $(".comm-loader"); // 로딩바

	if (type == "show") {
		loadingObj.show();
	} else if (type == "hide") {
		loadingObj.fadeOut(100);
	}

	return;
}

// 스펙관련 문자열 만들기 - 용어사전
function makerSpecTagDic(vip_spec) {
	if (!vip_spec) return "";

	var svt = vip_spec;
	// g   완전일치(발생할 모든 pattern에 대한 전역 검색)
	// i  대/소문자 무시
	// gi  대/소문자 무시하고 완전 일치
	var regFinder = /[$][T][A][G][$][^$]+[$][E][N][D][$]/g;
	var bTag1 = "</b>";
	var bTag2 = "----b----";
	var brTag1 = "</br>";
	var brTag2 = "----br----";

	var rtnValue = "";

	// 태그 빼기
	svt = svt.split(bTag1).join(bTag2);
	svt = svt.split(brTag1).join(brTag2);

	var svtAry = svt.split("/");

	for (var i = 0; i < svtAry.length; i++) {
		var svtItem = svtAry[i].replace("\\\"", "&amp;#34;");
		var findStrAry = svtItem.match(regFinder);
		if (findStrAry && findStrAry.length > 0) {
			for (var j = 0; j < findStrAry.length; j++) {
				var findItem = findStrAry[j].replace("\\\"", "&amp;#34;");
				var replaceItem = "";

				if (findItem.indexOf("_") > 0) {
					var chItem = findItem;

					chItem = chItem.replace("$TAG$", "");
					chItem = chItem.replace("$END$", "");

					if (chItem.charAt(0) == '_') chItem = chItem.substring(1);

					var chItemAry = chItem.split("_");

					if (chItemAry && chItemAry.length >= 3) {
						replaceItem += "<a href=\"javaScript:void(0);\" class=\"btn--dic\" data-attr_id=\"" + chItemAry[0] + "\" data-attr_el_id=\"" + chItemAry[1] + "\" onclick=\"showDicLayer(this);return false;\">";
						replaceItem += chItemAry[2].replace("&amp;#47;", "/").replace("&amp;#34;", "\"").replace("\\", "");
						replaceItem += "</a>";
					}
				}

				svtItem = svtItem.split(findItem).join(replaceItem).replace("\\", "");
			}
		}

		if (i > 0) rtnValue += "<em>|</em>";
		rtnValue += svtItem;
	}
	// 태그 넣기
	rtnValue = rtnValue.split(bTag2).join(bTag1);
	rtnValue = rtnValue.split(brTag2).join(brTag1);

	rtnValue = rtnValue.split("&amp;#47;").join("/");
	rtnValue = rtnValue.split("&amp;#34;").join("\"");

	return rtnValue;
}

//대괄호용 용어사전 작업
function makeSpecTagBig(vip_spec) {
	if (!vip_spec) return "";
	vip_spec = vip_spec.replace(/\/<b>/gi, '<b>');
	var svt = vip_spec;
	// g 완전일치(발생할 모든 pattern에 대한 전역 검색)
	// i 대/소문자 무시
	// gi  대/소문자 무시하고 완전 일치
	var regFinder = /[$][T][A][G][$][^$]+[$][E][N][D][$]/g;
	var bTag1 = "</b>";
	var bTag2 = "----b----";
	var brTag1 = "</br>";
	var brTag2 = "----br----";

	var rtnValue = "";

	// 태그 빼기
	svt = svt.split(bTag1).join(bTag2);
	svt = svt.split(brTag1).join(brTag2);

	var svtAry = svt.split("/");

	for (var i = 0; i < svtAry.length; i++) {
		var svtItem = svtAry[i];
		var findStrAry = svtItem.match(regFinder);
		if (findStrAry && findStrAry.length > 0) {
			for (var j = 0; j < findStrAry.length; j++) {
				var findItem = findStrAry[j];
				var replaceItem = "";
				if (findItem.indexOf("_") > 0) {
					var chItem = findItem;
					chItem = chItem.replace("$TAG$", "");
					chItem = chItem.replace("$END$", "");
					if (chItem.charAt(0) == '_') chItem = chItem.substring(1);
					var chItemAry = chItem.split("_");
					if (chItemAry && chItemAry.length >= 3) {
						if (i>0 && chItemAry[2].indexOf("<b>[") > -1) {
							replaceItem += "<br><b>";
						}
						replaceItem = "<a href=\"JavaScript:\" class=\"btn--dic\" data-attr_id=\"" + chItemAry[0] + "\" data-attr_el_id=\"" + chItemAry[1] + "\" onclick=\"showDicLayer(this);return false;\">";
						replaceItem += chItemAry[2].replace("&amp;#47;", "/").replace("\\", "");
						replaceItem += "</a>";
						if (chItemAry[2].indexOf("<b>[") > -1) {
							replaceItem += "</b>";
						}
					}
				}
				svtItem = svtItem.split(findItem).join(replaceItem);
			}
		}

		if (i > 0) rtnValue += "<em></em>";
		rtnValue += svtItem.replace(/&amp;#47;/gi, "/").replace(/\\/gi, "");
	}
	// 태그 넣기
	rtnValue = rtnValue.split(bTag2).join(bTag1);
	rtnValue = rtnValue.split(brTag2).join(brTag1);

	//대괄호앞에 개행추가 (두번째줄부터 개행)
	rtnValue = rtnValue.replace(/\<b\>\[/gi, "\<br\>\<b\>\[");
	if(rtnValue.substring(0,2) != "<a") {
		rtnValue = rtnValue.substring(4); // <br> 제거
	}
	
	return rtnValue;
}

// 그룹모델 영역 그리기
function drawGroupModel(groupModelObj, strOpenExpectFlag, adAttr, strDiscountRate) {
	var html = "";
	var groupList = groupModelObj.list;
	var strChange = groupModelObj.strChange;
	var strUnit = groupModelObj.strUnit;

	// 그룹모델 내 이미지형태 광고 여부 
	var adImageADModelNo = "";
	var adImageADModelImageUrl = "";
	if (adAttr.groupImage !== undefined) {
		if (adAttr.groupImage.modelno !== undefined && adAttr.groupImage.modelno.length > 0 && adAttr.groupImage.url !== undefined && adAttr.groupImage.url.length > 0) {
			adImageADModelNo = adAttr.groupImage.modelno;
			adImageADModelImageUrl = adAttr.groupImage.url;
		}
	}

	if (groupList.length > 0) {

		//		<!-- 상품가격 : 가격비교형 -->
		//		<!-- 다른 옵션 더보기 .is--unfold 붙여주세요 -->
		html += "<div class=\"item__price\">";

		//			<!-- 옵션 -->
		html += "	<ul class=\"price__option\">";

		$.each(groupList, function(Index, groupData) {
			var strModelNoRepYN = groupData.strModelNoRepYN; // 대표모델여부 (대표모델일 경우 Y) 
			var strModelNo = groupData.strModelNo; // 모델번호
			var strDicKbNo = groupData.strDicKbNo; // 용어사전 번호
			var strCondiName = groupData.strCondiName; // 옵션 노출명
			var strRank = groupData.strRank; // 순위
			var strUnitPrice = groupData.strUnitPrice; // 단위당환산가
			var strMinUnitPriceYN = groupData.strMinUnitPriceYN; // 단위당환산가 기준 최저가여부(최저가일 경우 Y)
			var strMallCnt = groupData.strMallCnt; // 쇼핑몰갯수
			var strPrice = groupData.strPrice; // 모델 최저가 (minPrice1,2,3 , TLC 가격 계산 된 노출가격) 가격없음, 미정 등 예외 메세지
			var tag = groupData.tag; // 태그정보 - 현금몰(cash), 해외직구(ovs) 
			var strMinPriceYN = groupData.strMinPriceYN; // 최저가모델여부 ( 최저가모델일 경우 Y )
			var strMobileMinPriceYn = groupData.strMobileMinPriceYn; // 모바일 최저가 여부
			var strZzimYN = groupData.strZzimYN; // 찜 여부
			var strSmallImg = groupData.strSmallImg;

			//			<!-- 5개 기본 노출 / 6번째 부터 .is--hide 비노출 -->
			if (Index >= 5) {
				html += "<li class=\"option__row is--hide\" data-type=\"option\" data-modelno=\"" + strModelNo + "\" data-img=\"" + strSmallImg + "\">";
			} else {
				html += "<li class=\"option__row\" data-type=\"option\" data-modelno=\"" + strModelNo + "\" data-img=\"" + strSmallImg + "\">";
			}
			//				<!-- 조건 -->
			if (strUnitPrice != "0") {
				html += "	<div class=\"opt--condition has-unit\">";
			} else {
				html += "	<div class=\"opt--condition\">";
			}

			//				<!-- 순위 : 없으면 비노출 -->
			if (strRank.length > 0) {
				html += "	<span class=\"tx--rank\">" + strRank + "위</span>";
			}

			//				<!-- 조건명 : 필수 노출 -->
			if (strCondiName.length > 0) {
				// 그룹모델 내 이미지형태 광고 여부
				if (adImageADModelNo == strModelNo && adImageADModelImageUrl.length > 0) {
					html += "<span class=\"tx--condition tx--ad\" title=\"" + strCondiName + "\">";
					html += "	<img src=\"" + adImageADModelImageUrl + "\" alt=\"" + strCondiName + "\">";
					html += "</span>";
				} else {
					// 용어사전
					if (strDicKbNo != "0") {
						html += "<span class=\"tx--condition btn--dic\" onclick=\"javascript:showDicLayer(this);\" data-kbno=\"" + strDicKbNo + "\" title=\"" + strCondiName + "\">" + strCondiName + "</span>";
					} else {
						html += "<span class=\"tx--condition\" title=\"" + strCondiName + "\">" + strCondiName + "</span>";
					}
				}
			}
			//					<!-- 단위환산가 : 없으면 비노출 -->
			if (strUnitPrice != "0") {
				if (strChange != "0" && strUnit != "") {
					if (strMinUnitPriceYN == "Y") {
						html += "<span class=\"tx--unit is--minp\">" + strUnitPrice + "원/" + strChange + "" + strUnit + "</span>";
					} else {
						html += "<span class=\"tx--unit\">" + strUnitPrice + "원/" + strChange + "" + strUnit + "</span>";
					}
				} else {
					if (strMinUnitPriceYN == "Y") {
						html += "<span class=\"tx--unit is--minp\">" + strUnitPrice + "원</span>";
					} else {
						html += "<span class=\"tx--unit\">" + strUnitPrice + "원</span>";
					}
				}
			}

			html += "		</div>";
			//				<!-- 가격 -->
			html += "		<div class=\"opt--price\">";
			//					<!-- 태그 : 현금 -->
			if (tag.cash !== undefined) {
				html += "		<span class=\"tag--cash lp__sprite\">현금</span>";
			}
			//					<!-- 태그 : 직구 -->
			if (tag.ovs !== undefined) {
				html += "		<span class=\"tag--global lp__sprite\">직구</span>";
			}
			//					<!-- 태그 : 모바일 -->
			if (param_isDelivery == "N" && strMobileMinPriceYn == "Y") {
				html += "		<span class=\"tag--mobile lp__sprite\" onclick=\"javascript:mobileMinPriceLayer(this);\">모바일</span>";
			}
			//					<!-- 가격 -->
			if (strPrice.length > 0) {
				if (strPrice == "출시예정") {
					html += "	<span class=\"tx--price\">" + strPrice + "</span>";
				} else {
					// 현금몰일 경우 현금가 노출
					if (tag.cash !== undefined && tag.cash.price !== undefined) {
						html += "<span class=\"tx--price\">" + tag.cash.price + "</span>원";
					} else {
						html += "<span class=\"tx--price\">" + strPrice + "</span>원";
					}
				}
			}
			html += "		</div>";
			//				<!-- 몰수 -->
			if (strOpenExpectFlag != "Y") {
				if (!isNaN(strMallCnt)) {
					if (parseInt(strMallCnt) > 999) {
						html += "<div class=\"opt--count\">999+</div>";
					} else if (strMallCnt != "0") {
						html += "<div class=\"opt--count\">" + parseInt(strMallCnt) + "</div>";
					}
				} else {
					html += "	<div class=\"opt--count\">" + strMallCnt + "</div>";
				}
				//				<!-- 체크/찜/비교 -->
				if (strMallCnt != "0") {
					html += "	<div class=\"opt--chk\">";
					html += "		<input type=\"checkbox\" id=\"lpListItem" + strModelNo + "\" class=\"input--checkbox-item\">";
					html += "		<label for=\"lpListItem" + strModelNo + "\"></label>";
					//				<!-- Hover시 노출 -->
					html += "		<div class=\"lay-opt--chk\">";
					//					<!-- 버튼 : 상품 비교 -->
					html += "			<button class=\"btn--opt-compare\" >비교</button>";
					//					<!-- 버튼 : 찜하기 -->
					if ((strZzimYN == "Y" && !zzimTmpModelNoRemoveSet.has(strModelNo)) || zzimTmpModelNoSet.has(strModelNo)) {
						html += "		<button class=\"btn--opt-zzim is--on\" data-zzimno=\"G" + strModelNo + "\" title=\"찜\" onclick=\"showLayZzim_list(this);return false;\">찜<i class=\"ico-opt-zzim lp__sprite\"></i></button>";
					} else {
						html += "		<button class=\"btn--opt-zzim\" data-zzimno=\"G" + strModelNo + "\" title=\"찜\" onclick=\"showLayZzim_list(this);return false;\">찜<i class=\"ico-opt-zzim lp__sprite\"></i></button>";
					}
					html += "		</div>";
					//				<!-- // -->
					html += "	</div>";
					//			<!-- // -->
				}
			}
			html += "	</li>";
			//			<!-- // -->
		});
		html += "	</ul>";
		//			<!-- 버튼 : 더보기 -->
		if (groupList.length > 5) {
			html += "<button class=\"btn--opt-unfold\"><span class=\"tx-btn-opt\">다른옵션 <em>" + parseInt(groupList.length - 5) + "개</em>펼치기</span></button>";
			html += "<button class=\"btn--opt-fold\" onclick=\"$(this).closest('.item__price').removeClass('is--unfold');\" style=\"display:none;\"><span class=\"tx-btn-opt\">닫기</span></button>";
		}
		html += "</div>";
	}

	return html;
}

//프린터 모델번호 API 호출
function loadPrinterModelNo() {

	var printerDataPromise = $.ajax({
		type: "GET",
		url: "/wide/api/prtModel.jsp",
		dataType: "json",
		data: {
			"prtModelNo": param_prtmodelno
		}
	});

	printerDataPromise.then(drawPrinter, failPrinter);
}

// 프린터 영역 그리기
function drawPrinter(dataObj) {

	// 예외처리
	if (dataObj.success === undefined || !dataObj.success) {
		return;
	}
	if (dataObj.data === undefined || dataObj.total === undefined) {
		return;
	}

	var printerDivObj = $(".list-filter--finder");

	var html = [];
	var hIdx = 0;

	// 프린터 영역 은 필터를 따로 관리함.
	html[hIdx++] = "	<div class=\"list-filter__head\">";
	html[hIdx++] = "		<dl>";
	html[hIdx++] = "			<dt>프린터 · 복합기 <em class=\"tx--count\">" + param_prtSrcKey + "</em> 검색결과</dt>";
	html[hIdx++] = "			<dd>" + dataObj.data.modelname + "</dd>";
	html[hIdx++] = "		</dl>";
	html[hIdx++] ="		<button class=\"btn--search-more\" onclick=\"javascript:loadInkFinder('"+param_prtSrcKey+"', 'layer');\">검색결과 전체보기 <i class=\"ico-adv-rarr lp__sprite\"></i></button>"; 
	//					<!-- 필터 > 우측 고정 메뉴 -->
	html[hIdx++] = "		<div class=\"list-filter-side\">";
	//						<!-- 상품 리스트 > 필터 > 정렬 -->
	html[hIdx++] = "			<ul class=\"list-filter__sort\">";
	html[hIdx++] = "				<li class=\"sortFilter is--on\" sortType=\"1\">";
	html[hIdx++] = "					<a href=\"javascript:void(0);\">인기순</a>";
	//								<!-- 툴팁 : 마우스 오버시 노출 -->
	//								<!-- 인기순 -->
	html[hIdx++] = "					<div class=\"lay-filter-tip\">";
	html[hIdx++] = "						<dl>";
	html[hIdx++] = "							<dt>TIP</dt>";
	html[hIdx++] = "							<dd><em>\"인기순\"</em>은 최근 1주일 동안의 <em>가격비교창</em>과 <em>주문버튼 클릭 수,</em><br><em>판매량</em>을 집계하여 합리적인 비례계산 시스템에 의해 만들어진 순위<br><em>*클릭수 조작 및 광고등을 통한 인위적인 조작 불가능함</em></dd>";
	html[hIdx++] = "						</dl>";
	html[hIdx++] = "					</div>";
	//								<!-- // -->
	html[hIdx++] = "				</li>";
	html[hIdx++] = "			</ul>";
	//						<!-- // -->
	//						<!-- 상품리스트 > 필터 > 뷰타입 -->
	html[hIdx++] = "			<div class=\"list-filter__view\">";
	html[hIdx++] = "				<ul class=\"view-type\">";
	html[hIdx++] = "					<li gridType=\"1\" class=\"is--on\"><a href=\"javascript:void(0);\"><i class=\"ico-type-list lp__sprite\">리스트타입</i></a></li>";
	html[hIdx++] = "					<li gridType=\"2\"><a href=\"javascript:void(0);\"><i class=\"ico-type-grid lp__sprite\">그리드타입</i></a></li>";
	html[hIdx++] = "				</ul>";
	html[hIdx++] = "			</div>";
	//						<!-- // -->   
	html[hIdx++] = "		</div>";
	//					<!-- // -->   
	html[hIdx++] = "	</div>";
	html[hIdx++] = "	<div class=\"list-filter__prod type--list\">";
	html[hIdx++] = "		<div class=\"goods-item\">";
	//						<!-- 썸네일 -->
	html[hIdx++] = "			<div class=\"item__thumb\">";
	html[hIdx++] = "				<a href=\"/detail.jsp?modelno=" + param_prtmodelno + "\" class=\"goods-item\" target=\"_blank\">";
	html[hIdx++] = "					<img src=\"" + dataObj.data.image + "\" alt=\"" + dataObj.data.modelname + "\" onerror=\"this.src='" + noImageStr + "';\">";
	html[hIdx++] = "				</a>";
	html[hIdx++] = "			</div>";
	//						<!-- // --> 
	html[hIdx++] = "		</a>";
	html[hIdx++] = "		<div class=\"item__box\">";
	//						<!-- 상품정보 -->
	html[hIdx++] = "			<div class=\"item__info\">";
	//							<!-- 모델명 -->
	html[hIdx++] = "				<div class=\"item__model\">";
	html[hIdx++] = "					<a href=\"/detail.jsp?modelno=" + param_prtmodelno + "\" class=\"goods-item\" target=\"_blank\">" + dataObj.data.modelname + "</a>";
	html[hIdx++] = "				</div>";
	//							<!-- 속성 -->
	html[hIdx++] = "				<ul class=\"item__attr\">";

	// 프린터 데이터 <b> 태그는 엔터키를 강제로 삽입
	html[hIdx++] = makerSpecTagDic(dataObj.data.spec);
	html[hIdx++] = "				</ul>";
	html[hIdx++] = "			</div>";
	//						<!-- // -->
	//						<!-- 상품가격 : 프린터복합기로 검색시 -->
	html[hIdx++] = "			<div class=\"item__price\">";
	//							<!-- 가격있을때 -->
	if (dataObj.data.price > 0) { // dataObj.data.price.format() 
		html[hIdx++] = "			<div class=\"price__mall\">";
		//							<!-- 가격 -->
		html[hIdx++] = "				<div class=\"col--price\">";
		html[hIdx++] = "					<a href=\"/detail.jsp?modelno=" + param_prtmodelno + "\"><em>" + dataObj.data.price.format() + "</em>원</a>";
		html[hIdx++] = "				</div>";
		html[hIdx++] = "			</div>";
		//							<!-- 품절/출시예정 등 예외케이스 -->
	} else {
		html[hIdx++] = "			<div class=\"price--exception\">";
		html[hIdx++] = "				<div class=\"col--price\">";
		html[hIdx++] = "					<a href=\"/detail.jsp?modelno=" + param_prtmodelno + "\">단종/품절</a>";
		html[hIdx++] = "				</div>";
		html[hIdx++] = "			</div>";
	}

	html[hIdx++] = "			</div>";
	html[hIdx++] = "		</div>";
	html[hIdx++] = "	</div>";

	printerDivObj.html(html.join(""));
	printerDivObj.show();


	//<!-- [LP] 복합기(0402) 파인터 검색결과 / 필터+대표 상품-->
	// $(".list-filter--finder")

}

//프린터 API 호출 실패시
function failPrinter(errorObj) {
	console.log("printer API Call Fail : " + errorObj.statusText);
	drawNoData();
}

//리스트 에서 후처리로 처리되는 함수들
function loadListAddData() {
	if (modelNoSet && modelNoSet.size > 0) {
		// 표준PC
		if (viewType == 1) {
			if (listType == "search") {
				set_enuripc();
			} else if (listType == "list") {
				//LP일때 사용하는 카테고리만 해당 function 사용
				if (",0405,0707,0708,0713,0703,0705,0711,0704,071307,071306,0414,".indexOf("," + param_cate + ",") > -1) {
					set_enuripc();
				}
			}
		}
	}

	// 프린터 검색결과 호출
	if (param_prtmodelno.length > 0) {
		loadPrinterModelNo();
	}

	// 이달의 브랜드
	loadKeywordAd();

	$("span.tag--rank, span.tag--ad").closest("div").addClass("has--tag");


}

// 분류검색어 정보 호출
function loadFromSearch() {

	if (Synonym_From == "search" && Synonym_Keyword.length > 0) {

		// API 호출
		var fromSearchPromise = $.ajax({
			type: "GET",
			url: "/lsv2016/ajax/getSubCateList_Ajax.jsp",
			dataType: "json",
			data: {
				"cate": param_cate,
				"pType": "CT"
			}
		});

		fromSearchPromise.then(drawFromSearch, failFromSearch);
	} else {
		return;
	}
}

// 분류검색어 그리기
function drawFromSearch(dataObj) {

	if (dataObj != "") {
		var keyword = ""; // 분류 검색어
		var fromSearchObj = $(".category-from-search");

		if (dataObj.c_name4 != "") {
			keyword = dataObj.c_name4;
		} else if (dataObj.c_name3 != "") {
			keyword = dataObj.c_name3;
		} else if (dataObj.c_name2 != "") {
			keyword = dataObj.c_name2;
		}

		if (keyword.length > 0) {

			var html = [];
			var hIdx = 0;

			html[hIdx++] = "<span class=\"tx--msg\">본 화면은 <em>" + keyword + "</em> 카테고리 입니다.</span>";
			html[hIdx++] = "<div class=\"category-from-search--side\">";
			//					<!-- 버튼 : 검색어 검색 -->
			html[hIdx++] = "	<a href=\"/search.jsp?keyword=" + Synonym_Keyword + "&from=list\" class=\"btn--to-search\">" + Synonym_Keyword + " 검색결과 보기 <i class=\"ico-rarr-blue--sm lp__sprite\">></i></a>";
			//					<!-- // -->
			html[hIdx++] = "</div>";

			fromSearchObj.html(html.join("")).show();

			var synonymUrl = "/lsv2016/ajax/getSubCateList_Ajax.jsp?cate=" + param_cate + "&pType=SK&keyword=" + Synonym_Keyword;
			$.getJSON(synonymUrl, function(synonymData) {
				if (synonymData.cateSynonym !== undefined && synonymData.cateSynonym.length > 0) {
					$("dd[data-type=synonym]").text(synonymData.cateSynonym);
				} else {
					$(".ico-tit-synonym").hide();
					$("dd[data-type=synonym]").hide();
				}
			});
		}
	}
}

// 분류검색어 호출 실패 시
function failFromSearch(errorObj) {
	console.log("분류검색어 API Call Fail : " + errorObj.statusText);
}

// 제조사 그리기
function drawFactory(dataObj) {
	var factoryHtml = "";
	factoryAttrList = dataObj.data.factory;
	var factoryViewItem = 6;
	//var vMinusCnt = 6;
	
	var unfoldAttrArr = [];
	var vUnfoldFlag = false;
	var sub_ls_step  = 0; // 펼침 수
	unfoldAttrArr = dataObj.data.unfoldAttr;
	if (listType=="list" && unfoldAttrArr.length > 0) {
		$.each(unfoldAttrArr, function(i,v){
			if (v.atr_tp_cd == 1) { //제조사일 때
				if (v.sub_ls_step  <=  1 || v.sub_ls_step >= 5) { //전체 펼침
					sub_ls_step = 0;
				} else { 
					sub_ls_step = v.sub_ls_step;
				} 
				vUnfoldFlag = true; //펼침 여부
				return false;
			}
		});
	}
	
	if(factoryAttrList.length<=factoryViewItem) {
		vUnfoldFlag = false;
	}
	
	factoryHtml += "<dl class=\"search-box-row "+(vUnfoldFlag ? "is--unfold" : "")+"\" data-attr-type=\"factory\">";
	
	factoryHtml += "		<dt class=\"search-box__head\">";
	factoryHtml += "			<div class=\"search-box__head--title\">";
	factoryHtml += "				<div class=\"search-box__head--inner\">";
	//									<!-- 속성명 / 카운트 -->
	factoryHtml += "					<p class=\"search-box__head--name\">제조사</p>";
	factoryHtml += "				</div>";
	factoryHtml += "			</div>";
	//							<!-- Sorting -->
	factoryHtml += "			<div class=\"search-box__sort\" data-sort=\"factory\">";
	factoryHtml += "				<button class=\"btn-sort--pop is--selected\">인기순</button>";
	factoryHtml += "				<button class=\"btn-sort--name\">가나다순</button>";
	factoryHtml += "			</div>";
	if (!vUnfoldFlag && factoryAttrList.length > factoryViewItem) {
		factoryHtml += "			<div class=\"search-box__util\">";
		factoryHtml += "				<span class=\"search-box__util--count\"><em>" + (factoryAttrList.length - factoryViewItem) + "</em>개</span>";
		factoryHtml += "				<button type=\"button\" class=\"search-box__btn--unfold\" onclick=\"$(this).closest('.search-box-row').toggleClass('is--unfold');\"></button>";
		factoryHtml += "			</div>";
	}
	factoryHtml += "		</dt>";

	factoryHtml += "		<dd class=\"search-box__body\">";

	//							<!-- 가나다/알파벳순 정렬 -->
	factoryHtml += "			<div class=\"search-box__sort--seq\" style=\"display:none;\"></div>";

	factoryHtml += "			<div class=\"search-box__inner "+(sub_ls_step > 0 ? "line"+sub_ls_step+"" : "")+"\">";

	var factoryDrawCnt = 0;

	$.each(dataObj.data.factory, function(index, item) {
		//							<!-- 반복 : 한줄 최대 6개 / 두줄케이스 12개 -->
		if (factoryDrawCnt == 0) {
			factoryHtml += "		<ul class=\"search-box__list\">";
		}
		factoryHtml += "				<li class=\"attrs\" data-attr=\"factory_" + item.code + "\" data-text=\"" + regSpecExp(item.name) + "\"><input type=\"checkbox\" id=\"chFactory_" + index + "\" class=\"input--checkbox-item\"><label for=\"chFactory_" + index + "\" title=\"" + item.name + "\">" + item.name + "</label></li>";
		factoryNameToCodeMap.put(item.name, item.code);
		factoryDrawCnt++;
	});
	
	factoryHtml += "				</ul>";
	factoryHtml += "			</div>";
	factoryHtml += "		</dd>";
	factoryHtml += "	</dl>";

	return factoryHtml;
}

// 브랜드 그리기
function drawBrand(dataObj, orderMap) {
	var brandHtml = "";
	var brandViewItem = 6;
	var brandAddClass = "";
	var vMinusCnt = 6;
	
	var unfoldAttrArr = [];
	var vUnfoldFlag = false;
	var sub_ls_step  = 0; // 펼침 수
	unfoldAttrArr = dataObj.data.unfoldAttr;
	if (listType=="list" && unfoldAttrArr.length > 0) {
		$.each(unfoldAttrArr, function(i,v){
			if (v.atr_tp_cd == 2) { //브랜드일 때 펼침
				if (v.sub_ls_step  <=  1 || v.sub_ls_step >= 5) { //전체 펼침
					sub_ls_step = 0;
				} else {
					sub_ls_step = v.sub_ls_step;
				} 
				vUnfoldFlag = true; //펼침 여부
				return false;
			}
		});
	}
	
	// LP 추천브랜드
	if (dataObj.data.reqBrandLP !== undefined && orderMap!==null && orderMap.index==0) {
		brandAddClass += " type--except1";
		if(dataObj.data.reqBrandLP.length <= brandViewItem) {
			vUnfoldFlag = false;
		}
	}

	// SRP 추천브랜드
	else if (listType == "search" && dataObj.data.reqBrandList !== undefined && dataObj.data.reqBrandList.length > 0) {
		brandAddClass += " type--recomm-brand";
		if(dataObj.data.reqBrandList.length <= brandViewItem) {
			vUnfoldFlag = false;
		}
	}
	
	else if(dataObj.data.brand !== undefined && dataObj.data.brand.length > 0) {
		if(dataObj.data.brand.length <= brandViewItem) {
			vUnfoldFlag = false;
		}
	}
	
	brandHtml += "	<dl class=\"search-box-row "+(vUnfoldFlag ? "is--unfold" : "")+"" + brandAddClass + "\" data-attr-type=\"brand\">";
	brandHtml += "		<dt class=\"search-box__head\">";
	brandHtml += "			<div class=\"search-box__head--title\">";
	brandHtml += "				<div class=\"search-box__head--inner\">";
	//									<!-- 속성명 / 카운트 -->
	if ((dataObj.data.reqBrandLP !== undefined && orderMap!==null && orderMap.index==0) || (listType == "search" && dataObj.data.reqBrandList !== undefined && dataObj.data.reqBrandList.length > 0)) {
		brandHtml += "				<p class=\"search-box__head--name\">추천브랜드</p>";
	} else {
		brandHtml += "				<p class=\"search-box__head--name\">브랜드</p>";
	}
	brandHtml += "				</div>";
	brandHtml += "			</div>";
	//						<!-- Sorting -->
	brandHtml += "			<div class=\"search-box__sort\" data-sort=\"brand\">";
	brandHtml += "				<button class=\"btn-sort--pop is--selected\">인기순</button>";
	brandHtml += "				<button class=\"btn-sort--name\">가나다순</button>";
	brandHtml += "			</div>";

	if (!vUnfoldFlag && dataObj.data.brand.length > brandViewItem) {
		brandHtml += "			<div class=\"search-box__util\">";
		brandHtml += "				<span class=\"search-box__util--count\"><em>" + (dataObj.data.brand.length - brandViewItem) + "</em>개</span>";
		brandHtml += "				<button type=\"button\" class=\"search-box__btn--unfold\" onclick=\"$(this).closest('.search-box-row').toggleClass('is--unfold');\"></button>";
		brandHtml += "			</div>";
	}

	brandHtml += "		</dt>";

	brandHtml += "		<dd class=\"search-box__body\">";

	// LP 추천브랜드
	if (listType == "list" && dataObj.data.reqBrandLP !== undefined && dataObj.data.reqBrandLP.length > 0 && orderMap!==null && orderMap.index==0) {
		brandHtml += "		<div class=\"search-box__except1\">";
		brandHtml += "			<ul class=\"list__luxury\">";

		$.each(dataObj.data.reqBrandLP, function(index, item) {
			brandHtml += "		<li class=\"attrs\" data-attr=\"brand_" + item.code + "\" data-text=\"" + regSpecExp(item.name) + "\">";
			brandHtml += "				<a href=\"javascript:void(0);\" class=\"luxury\">";
			brandHtml += "					<img src=\"" + item.image_url + "\" alt=\"" + item.name + "\" height=\"20\" onerror=\"this.src='//img.enuri.info/images/finder/icon/img_noicon2.png'\">";
			brandHtml += "					<span class=\"tx_brand\">" + item.name + "</span>";
			brandHtml += "				</a>";
			brandHtml += "			</li>";
			brandReqMap.set(item.name, item.name);
		});

		brandHtml += "			</ul>";
		brandHtml += "		</div>";
	}

	// SRP 추천브랜드
	if (listType == "search" && dataObj.data.reqBrandList !== undefined && dataObj.data.reqBrandList.length > 0) {
		brandHtml += "		<div class=\"search-box__r-brand\">";
		brandHtml += "			<ul class=\"search-box__list\">";
		$.each(dataObj.data.reqBrandList, function(index, item) {
			brandHtml += "		<li class=\"attrs\" data-attr=\"brand_" + item.brand_id + "\" data-text=\"" + regSpecExp(item.brand_nm) + "\"><a href=\"javascript:void(0);\" class=\"r-brand\"><img src=\"//storage.enuri.info/pic_upload/keyword/" + item.brand_img + "\" alt=\"" + item.brand_nm + "\"></a></li>";
			srpReqSet.add(item.brand_nm);
		});
		brandHtml += "			</ul>";
		brandHtml += "		</div>";
	}

	// 							<!-- 가나다/알파벳순 정렬 -->
	brandHtml += "			<div class=\"search-box__sort--seq\" style=\"display:none;\"></div>";

	brandHtml += "			<div class=\"search-box__inner "+(sub_ls_step > 0 ? "line"+sub_ls_step+"" : "")+"\">";

	var brandDrawCnt = 0;
	
	$.each(dataObj.data.brand, function(index, item) {
		if (dataObj.data.reqBrandLP !== undefined && brandReqMap.has(item.name)) {
			return true;
		} else if (listType == "search" && srpReqSet.has(item.name)) {
			return true;
			// 명품, SRP 추천브랜드 를 제외하고 brandAttrList 에 추가
		} else {
			brandAttrList.push(item);
			//					<!-- 반복 : 한줄 최대 6개 / 두줄케이스 12개 -->
			if (brandDrawCnt == 0) {
				brandHtml += "	<ul class=\"search-box__list\">";
			}
			brandHtml += "		<li class=\"attrs\" data-attr=\"brand_" + item.code + "\" data-text=\"" + regSpecExp(item.name) + "\"><input type=\"checkbox\" id=\"chBrand_" + item.code + "\" class=\"input--checkbox-item\"><label for=\"chBrand_" + item.code + "\" title=\"" + item.name + "\">" + item.name + "</label></li>";
			if (dataObj.data.reqBrandLP === undefined || !brandReqMap.has(item.name)) {
				brandDrawCnt++;
			}
		}
	});
	brandHtml += "				</ul>";
	brandHtml += "			</div>";
	brandHtml += "		</dd>";

	brandHtml += "	</dl>";

	return brandHtml;
}

// 스펙 그리기
// smartYN 핵심순서 유무
function drawSpec(index, item, smartYN, orderMap, unfoldObj) {
	var specHtml = "";
	var addClassTxt = "";
	var attrDisplayNone = false; // 기본 설정 시 노출 여부
	var vMinusCnt = 6;
	var orderIndex = -1;
	
	if(orderMap!==null){
		orderIndex = orderMap.index;
	}
	
	var sub_ls_yn = "";
	var sub_ls_step = 0;
	var vUnfoldFlag = false;
	//펼치는 스펙일 경우
	if (unfoldObj != null) {
		sub_ls_yn = unfoldObj.sub_ls_yn;
		sub_ls_step = unfoldObj.sub_ls_step;
		
		if (sub_ls_step  <=  1 || sub_ls_step >= 5) { //전체 펼침
			sub_ls_step = 0;
		} 
		if (item.specMenuList.length > 6 && item.strImgViewYN == "N" && item.strTextHighlightYN =="N") vUnfoldFlag = true; //펼침 여부
	}
	
	if(index==0 && orderIndex==0 && smartYN=="Y" && item.strImgViewYN == "Y" && item.specMenuList.length > 6) { // 스마트파인더 1번 속성 펼침처리
		addClassTxt += "is--expand";
	}
	
	if (index >= defaultSpecCnt) {
		addClassTxt += " more_spec";
		attrDisplayNone = true;
		if (!attrMoreView) { // 속성더보기 노출 여부
			attrMoreView = true;
		}
	}

	// 스마트파인더
	if (smartYN == "Y") {
	 	if(item.strImgViewYN == "Y") {
			addClassTxt += " type--finder-target";
			// <!-- 9개 이하일 때 클래스 추가 : "none-slide" -->
			if (item.specMenuList.length == 8 && item.strAllViewYN == "Y") {
			} else if (item.specMenuList.length < 9) {
				addClassTxt += " none-slide";
			}
		} else if(item.strTextHighlightYN == "Y") {
			addClassTxt += " type--finder-text";
		}
	}

	if (attrDisplayNone) {
		specHtml += "<dl class=\"search-box-row "+(vUnfoldFlag ? "is--unfold" : "")+"" + addClassTxt + "\" style=\"display:none;\" data-attr-type=\"spec\" data-index=\"" + item.strGpno + "\">";
	} else {
		specHtml += "<dl class=\"search-box-row "+(vUnfoldFlag ? "is--unfold" : "")+"" + addClassTxt + "\" data-attr-type=\"spec\" data-index=\"" + item.strGpno + "\">";
	}
	specHtml += "		<dt class=\"search-box__head\">";
	specHtml += "			<div class=\"search-box__head--title\">";
	specHtml += "				<div class=\"search-box__head--inner\">";
	//									<!-- 속성명 / 카운트 -->
	specHtml += "					<p class=\"search-box__head--name\">" + item.strSpecCateTitle + "</p>";
	specHtml += "				</div>";
	specHtml += "			</div>";

	if ((smartYN != "Y" || (item.strImgViewYN == "N" && item.strTextHighlightYN =="N")) &&  item.specMenuList.length > 6) { 
		if (!vUnfoldFlag && item.specMenuList.length > attrViewCnt) {
			specHtml += "	<div class=\"search-box__util\">";
			specHtml += "		<span class=\"search-box__util--count\"><em>" + (item.specMenuList.length - 6) + "</em>개</span>";
			specHtml += "		<button type=\"button\" class=\"search-box__btn--unfold\" onclick=\"$(this).closest('.search-box-row').toggleClass('is--unfold');\"></button>";
			specHtml += "	</div>";
		}
	}
	
	specHtml += "		</dt>";

	specHtml += "		<dd class=\"search-box__body\">";
	specHtml += "			<div class=\"search-box__inner "+(sub_ls_step > 0 ? "line"+sub_ls_step+"" : "")+"\">";

	// 스마트파인더 아이콘 유형
	if (smartYN == "Y" && item.strImgViewYN == "Y") {
		$.each(item.specMenuList, function(index_sub, spec) {
			var dataIndex = index_sub + 1;
			// 용어사전
			var dicHasClass = "";
			if(spec.strKbNo !== undefined && spec.strKbNo.length > 0 && spec.strKbNo != "0") {
				dicHasClass = "has-dic";
			}
			
			if (index_sub == 0) {
				if (item.strAllViewYN == "Y") {
					dataIndex = index_sub + 1;
				}
				var finderItemPageCnt = 1;
				if (item.specMenuList.length > 8) {
					finderItemPageCnt = Math.ceil(item.specMenuList.length / 8);
				}

				//				<!-- 반복 : 한줄 최대 6개 / 두줄케이스 12개 -->
				specHtml += "	<ul class=\"search-box__list finder-icon__list\" data-page=\"1\" data-page-end=\"" + finderItemPageCnt + "\">";

				if (item.strAllViewYN == "Y") {
					specHtml += "	<li class=\"attrs sel\" data-page=\"1\" data-attr=\"spec_all\">";
					specHtml += "		<button type=\"button\" class=\"btn-attr\" data-type=\"smartfinder_button\" data-on-image=\"http://img.enuri.info/images/finder/icon/icon_all_on.svg\" data-off-image=\"http://img.enuri.info/images/finder/icon/icon_all_off.svg\">";
					specHtml += "			<span class=\"ico_thum\"><img src=\"http://img.enuri.info/images/finder/icon/icon_all_on.svg\" class=\"ico\" alt=\"전체보기\" onerror=\"this.src='//img.enuri.info/images/finder/icon/icon_default.png'\" width=\"32\" height=\"32\"></span>";
					specHtml += "			<span class=\"tx_attr\">전체</span>";
					specHtml += "		</button>";
					specHtml += "	</li>";
				}
			}

			if (index_sub >= 8 || (index_sub == 7 && item.strAllViewYN == "Y")) {
				specHtml += "		<li class=\"attrs "+dicHasClass+"\" data-attr=\"spec_" + spec.strSpecNo + "_" + spec.strSpecGroupTitle + "\" data-spec=\"" + spec.strSpecNo + "\" data-page=\"" + (1 + Math.floor(dataIndex / 8)) + "\" style=\"display:none;\">";
			} else {
				specHtml += "		<li class=\"attrs "+dicHasClass+"\" data-attr=\"spec_" + spec.strSpecNo + "_" + spec.strSpecGroupTitle + "\" data-spec=\"" + spec.strSpecNo + "\" data-page=\"" + (1 + Math.floor(dataIndex / 8)) + "\">";
			}
			specHtml += "				<button type=\"button\" class=\"btn-attr\" data-type=\"smartfinder_button\" data-on-image=\"" + spec.strIconImage_on + "\" data-off-image=\"" + spec.strIconImage_off + "\">";
			specHtml += "					<span class=\"ico_thum\"><img src=\"" + spec.strIconImage_off + "\" class=\"ico\" alt=\"" + spec.strSpecGroupTitle + "\" onerror=\"this.src='//img.enuri.info/images/finder/icon/icon_default.png'\" width=\"32\" height=\"32\"></span>";
			specHtml += "					<span class=\"tx_attr\">" + spec.strSpecGroupTitle + "</span>";
			specHtml += "				</button>";
			// 용어사전
			if(dicHasClass=="has-dic") {
				//						<!-- 용어사전 클릭 영역-->
				specHtml += "			<button type=\"button\" class=\"btn--dic\" data-kbno=\"" + spec.strKbNo + "\">" + spec.strSpecGroupTitle + "</button>";
			}
			
			specHtml += "			</li>";
			if (item.specMenuList.length == index_sub + 1) {
				specHtml += "	</ul>";
			}
		});

		//						<!-- 좌/우 화살표 -->
		if (item.specMenuList.length > 8 || (item.specMenuList.length == 8 && item.strAllViewYN == "Y")) { // 한화면에 나올크기보다 클 경우 좌우 버튼을 노출한다 
			specHtml += "		<button type=\"button\" class=\"arr arr-prev\">이전</button>";
			specHtml += "		<button type=\"button\" class=\"arr arr-next\">다음</button>";
		}
	// 스마트파인더 텍스트강조형
	} else if (smartYN == "Y" && item.strImgViewYN == "N" && item.strTextHighlightYN == "Y") {
		$.each(item.specMenuList, function(index_sub, spec) {
			// 용어사전
			var dicHasClass = "";
			if(spec.strKbNo !== undefined && spec.strKbNo.length > 0 && spec.strKbNo != "0") {
				dicHasClass = "has-dic";
			}
			if (index_sub == 0) {
				//				<!-- 반복 : 한줄 최대 6개 / 두줄케이스 12개 -->
				specHtml += "	<ul class=\"search-box__list finder-text__list\">";
			}
			
			specHtml += "			<li class=\"attrs "+dicHasClass+"\" data-attr=\"spec_" + spec.strSpecNo + "_" + spec.strSpecGroupTitle + "\" data-spec=\"" + spec.strSpecNo + "\">";
			specHtml += "				<button type=\"button\" class=\"btn-attr\" data-type=\"smartfinder_texthighlight\"><span class=\"tx_attr\">"+ spec.strSpecGroupTitle + "</span></button>";
			// 용어사전
			if(dicHasClass=="has-dic") {
				//						<!-- 용어사전 클릭 영역-->
				specHtml += "			<button type=\"button\" class=\"btn--dic\" data-kbno=\"" + spec.strKbNo + "\">" + spec.strSpecGroupTitle + "</button>";
			}
			specHtml += "			</li>";
			
			if (item.specMenuList.length == index_sub + 1) {
				specHtml += "	</ul>";
			}
		});
	} else {
		$.each(item.specMenuList, function(index_sub, spec) {
			// 용어사전
			var dicHasClass = "";
			if(spec.strKbNo !== undefined && spec.strKbNo.length > 0 && spec.strKbNo != "0") {
				dicHasClass = "has-dic";
			}
			//					<!-- 반복 : 한줄 최대 6개 / 두줄케이스 12개 -->
			if (index_sub == 0) {
				specHtml += "	<ul class=\"search-box__list\">";
			}
			specHtml += "			<li class=\"attrs "+dicHasClass+"\" data-attr=\"spec_" + spec.strSpecNo + "_" + spec.strSpecGroupTitle + "\" data-spec=\"" + spec.strSpecNo + "\">";
			specHtml += "				<input type=\"checkbox\" id=\"chCustom_" + spec.strSpecNo + "\" class=\"input--checkbox-item\">";
			specHtml += "				<label for=\"chCustom_" + spec.strSpecNo + "\" title=\"" + spec.strSpecGroupTitle + "\">";
			if(dicHasClass=="has-dic") {
				specHtml += "				<button class=\"btn--dic\" data-kbno=\"" + spec.strKbNo + "\">";
			}
			specHtml += spec.strSpecGroupTitle;
			if (spec.intKbNo != "0") {
				specHtml += "				</button>";
			}
			specHtml += "				</label>";
			specHtml += "			</li>";

			if (item.specMenuList.length == index_sub + 1) {
				specHtml += "	</ul>";
			}
		});
	}

	specHtml += "			</div>";
	specHtml += "		</dd>";
	specHtml += "	</dl>";

	return specHtml;
}

// 할인율 그리기
function drawDiscount(dataObj) {
	if(dataObj.data.discount === undefined || dataObj.data.discount.length == 0) {
		return;
	}
	var discountHtml = "";
	
	discountHtml += "<dl class=\"search-box-row\" data-attr-type=\"discount\">";
	discountHtml += "	<dt class=\"search-box__head\">";
	discountHtml += "		<div class=\"search-box__head--title\">";
	discountHtml += "			<div class=\"search-box__head--inner\">";
	//								<!-- 속성명 / 카운트 -->
	discountHtml += "				<p class=\"search-box__head--name\">할인율</p>";
	discountHtml += "				<button type=\"button\" class=\"ico ico--question\" id=\"icoPertip\">?</button>";
	discountHtml += "			</div>";
	discountHtml += "		</div>";
	//						<!-- 할인율 말풍선 클래스(lay-pertip) -->
	discountHtml += "		<div class=\"lay-tooltip lay-pertip\" style=\"display: none; opacity: 1;\">";
	discountHtml += "			<div class=\"lay__inner\">";
	// 패션 노티 문구
	if(param_cate.substring(0,2) == "14" || param_cate.substring(0,2) == "25") {
		discountHtml += "			<p class=\"tx_msg\"><em>TIP</em>패션카테고리의 <strong>할인율 정보</strong>는 쇼핑몰별 가격비교 상품의 최저가와 최고가를 비교하여 제공하고 있습니다.</p>";
	} else {
		discountHtml += "			<p class=\"tx_msg\"><em>TIP</em><strong>할인율 정보</strong>는 제조사(브랜드사)의 정보를 기준으로 책정되었습니다.</p>";
	}
	discountHtml += "			</div>";
	discountHtml += "		</div>";
	discountHtml += "	</dt>";
	
	discountHtml += "	<dd class=\"search-box__body\">";
	discountHtml += "		<div class=\"search-box__inner\">";
	discountHtml += "			<ul class=\"search-box__list\">";
	$.each(dataObj.data.discount, function(index, item) {
		var discountStartVal = item.code.split("~");
		discountHtml += "			<li class=\"attrs\" data-attr=\"discount_" + item.code + "\" data-discount-start=\""+discountStartVal[0]+"\"><input type=\"checkbox\" id=\"chDiscount_" + index + "\" class=\"input--checkbox-item\"><label for=\"chDiscount_" + index + "\" title=\"" + item.name + "\">" + item.name + "</label></li>";
	});
	discountHtml += "			</ul>";
	discountHtml += "		</div>";
	discountHtml += "	</dd>";
	discountHtml += "</dl>";
	
	return discountHtml;
}

// 평점 그리기
function drawBbsScore(dataObj) {
	if(dataObj.data.bbsscore === undefined || dataObj.data.bbsscore.length == 0) {
		return;
	}
	
	var bbsHtml = "";
	
	bbsHtml += "<dl class=\"search-box-row row-rating\" data-attr-type=\"bbsscore\">";
	bbsHtml += "	<dt class=\"search-box__head\">";
	bbsHtml += "		<div class=\"search-box__head--title\">";
	bbsHtml += "			<div class=\"search-box__head--inner\">";
	//							<!-- 속성명 / 카운트 -->
	bbsHtml += "				<p class=\"search-box__head--name\">상품평점</p>";
	bbsHtml += "			</div>";
	bbsHtml += "		</div>";
	bbsHtml += "	</dt>";
	bbsHtml += "	<dd class=\"search-box__body\">";
	bbsHtml += "		<div class=\"search-box__inner\">";
	bbsHtml += "			<ul class=\"search-box__rating list-form--radio\">";
	$.each(dataObj.data.bbsscore, function(index, item) {
		bbsHtml += "			<li class=\"attrs\" data-attr=\"bbsscore_" + item.code + "\">";
		bbsHtml += "				<input type=\"checkbox\" id=\"rate_" + item.code + "\" name=\"searchRate\" class=\"input--checkbox-item\">";
		bbsHtml += "				<label for=\"rate_" + item.code + "\"><i class=\"lp__sprite icon_star_" + item.code + "\"></i>" + item.name + "</label>";
		bbsHtml += "			</li>";
	});
	bbsHtml += "			</ul>";
	bbsHtml += "		</div>";
	bbsHtml += "	</dd>";
	bbsHtml += "</dl>";
	
	return bbsHtml;
}

//브랜드스토어
function loadbrandStore(cate) {
	var brandStorePromise = $.ajax({
		type: "get",
		url: "/brandstore/api/brandList.jsp",
		dataType: "json",
		data: {
			"cate": cate,
			"device": "pc",
		}
	});

	brandStorePromise.then(drawbrandStore, failbrandStore);
}

function drawbrandStore(obj) {
	var brandStoreHtml = "";
	
	if (typeof obj != "undefined" ) {
		if (obj.success) {
			if(typeof obj.data != "undefined") {
				var data = obj.data;
				var rankUrl = "";
				if (typeof data.rankUrl != "undefined" && data.rankUrl.length > 0) {
					rankUrl = data.rankUrl;
				}
    			brandStoreHtml +=  "	<h3 class=\"bs_title\"><em>브랜드</em>스토어<a href=\""+rankUrl+"\" class=\"btn_allview\" target=\"_blank\" onclick=\"insertLog(27428);\">더보기</a></h3>";
				var brandStoreList;
				if (typeof data.list != "undefined" && data.list.length > 2) {
					brandStoreList = data.list; 
					brandStoreHtml += "<div class=\"bs_list\">";                              
                    brandStoreHtml += "		<ul>";
					
					var brandStoreListLen = brandStoreList.length > 6 ? 6 : brandStoreList.length;
					for (var i =0; i < brandStoreListLen; i ++) {
						brandStoreHtml += "		<li>";
                        brandStoreHtml += "			<a href=\""+brandStoreList[i].url+"\" target=\"_blank\" onclick=\"insertLog(27427);\">";
                        brandStoreHtml += "				<div class=\"bs_logo_wrap\">";
						brandStoreHtml += "				<div class=\"bs_logo\">";
						brandStoreHtml += "					<img src=\""+brandStoreList[i].shop_logo+"\" onerror=\"this.src='https://img.enuri.info/images/rev/brandstore/shoplogo_noimg.png'\"/>";
						brandStoreHtml += "				</div>";
                        brandStoreHtml += "				</div>";
                        brandStoreHtml += "				<div class=\"bs_name\">"+brandStoreList[i].shop_nm+"</div>";                        
                        brandStoreHtml += "			</a>";	                        
                        brandStoreHtml += "		</li>";	      
					}
					
					brandStoreHtml += "		</ul>";
			        brandStoreHtml += "</div>";  
					$("#div_lp_brand_store").html(brandStoreHtml);                          
				} 
			} else {
				$("#div_lp_brand_store").remove();
			}
		} else {
			$("#div_lp_brand_store").remove();
		}
	}
}

function failbrandStore(errorObj) {
	console.log("LP brandStore API Call Fail : " + errorObj.statusText);
}