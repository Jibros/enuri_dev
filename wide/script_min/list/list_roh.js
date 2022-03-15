// 속성 정보 호출
loadAttrs();
//리스트 정보 호출 ( 소셜상품의 경우 별도 호출 ) 
if(param_tabType==4) {
	loadSocial();
} else {
	loadGoods(); 
}
if(listType=="list") {
	// 네비게이션 호출 nav.min.js
	loadNav(param_cate);
	// 탑배너 호출 listbanner.min.js
	loadLPTopBanner(param_cate);
	// 히트브랜드 호출
	loadHitBrand(param_cate);
	// 분류검색어 & 동의어
	if( Synonym_From == "search" && Synonym_Keyword.length > 0 ) {
		loadFromSearch();
		insertSearchKeywordLog(Synonym_Keyword); // 로그
	}
} else if(listType=="search") {
	// 연관검색어
	loadLinkageKeyword();
	insertSearchKeywordLog(param_keyword); // 로그
}

// 리스트 정보 호출
function loadGoods() {
	
	$(".list-filter-bot[data-type=social]").hide();
	$(".list-filter-bot[data-type=prod]").show();
	
	// 상단탭 비활성화 
	if(listType=="list") {
		$(".category-lp--fine").removeClass("is--disabled");
	}
	$(".adv-search").removeClass("is--disabled");
	
	//로딩바 불러오기
	loading("show");
	
	// 탭별 소팅 노출 처리
	// 일반상품, 해외직구는 신제품순, 판매량순 비노출
	if( param_tabType==2 || param_tabType==3 ) {
		$(".list-filter-bot[data-type=prod] .sortFilter[sorttype=4]").hide();
		$(".list-filter-bot[data-type=prod] .sortFilter[sorttype=5]").hide();
		$(".list-filter-bot[data-type=prod] .sortFilter[sorttype=7]").hide();
	} else {
		if(!blNewListBtnCheck) {
			$(".list-filter-bot[data-type=prod] .sortFilter[sorttype=4]").show();
			$(".list-filter-bot[data-type=prod] .sortFilter[sorttype=5]").show();
		}
		if(blNewListBtnIsset && !blNewListBtnCheck) {
			$(".list-filter-bot[data-type=prod] .sortFilter[sorttype=7]").show();
		}
	}
	
	// LP 속성은 _는 AND조건, ,는 OR조건
	// ex) spec=3313,205,_6678,3695,3694,
	var $customSpecArray = new Array();
	var $customSpec = "";
	var $customTmpString = "";
	var $customSpecArrayCount = 0;
	
	if(param_spec.length>0) {
		
		// 직링크 진입 시
		if(firstLoadFlag) {
		
			$customSpec = param_spec;
		
		// 일반
		} else {
			$("dl.search-box-row[data-attr-type=spec]").each(function(index, item) {
				$customTmpString = "";
				$(this).find("li.sel").each(function(sub_index, sub_item) {
					if($customTmpString.length>0) { 
						$customTmpString += ",";
					}
					$customTmpString += $(this).attr("data-spec");
				});
				if($customTmpString.length>0) {
					$customSpecArray[$customSpecArrayCount++] = $customTmpString;
				}
			});
			
			$customSpec = $customSpecArray.join(",_");
		}
	}
	
	// 파라미터
	var listParam = {
		"from" : listType,
		"device" : "pc",
		"category" : param_cate,
		"tab" : param_tabType,
		"isDelivery" : param_isDelivery,
		"isRental" : param_isRental,
		"pageNum" : param_pageNum,
		"pageGap" : param_pageGap,
		"sort" : param_sort,
		"factory" : encodeURIComponent(param_factory),
		"brand" : encodeURIComponent(param_brand),
		"shopcode" : param_shopcode,
		"keyword" : encodeURIComponent(param_keyword),
		"in_keyword" : encodeURIComponent(param_inKeyword),
		"s_price" : param_sPrice,
		"e_price" : param_ePrice,
		"spec" : $customSpec,
		"gb1" : param_gb1,
		"gb2" : param_gb2,
		"isReSearch" : param_isResearch,
		"isTest" : "N",
		"prtmodelno" : param_prtmodelno,
		 "isMakeshop" : "N"
	};
	
	// 리스트 API 호출
	var listDataPromise = $.ajax({
		type : "GET",
		url : "/wide/api/listGoods.jsp",
		dataType : "json",
		data : listParam
	});
	
	listDataPromise.then(drawList, failList);
	
}

// 리스트 정보 그리기
function drawList(dataObj) {
	
	// 예외처리
	if(dataObj.success===undefined || !dataObj.success) {
		drawNoData(); // 리스트 정보 없을때
		return;
	}
	if(dataObj.data.list===undefined || dataObj.total===undefined) {
		drawNoData(); // 리스트 정보 없을때
		return;
	}
	
	tmpDataObj = dataObj;
	
	var listObj = dataObj.data.list;
	
	if(listObj.length==0 || dataObj.data.total==0) {
		drawNoData(); // 리스트 정보 없을때
		return;
	}
	
	// SRP 에서 상품 갯수 표시
	if(listType=="search" && dataObj.total>0) {
		$("#topAllCntEm").text(dataObj.total.format());
	}
	
	//serchtypeC check
	if(dataObj.data.strKeywordCTypeYN == "Y"){
		drawCtype();
	}
	
	// 부분검색어 있을때는 부분검색어, 없으면 검색어를 노출
	if(listType=="search") {
		if(dataObj.data.searchedKeyword.length>0 && param_isResearch=="Y") {
			$(".sr-keyword").text(dataObj.data.searchedKeyword);
		} else {
			$(".sr-keyword").text(param_keyword);
		}
		
		if(param_isResearch=="N") {
			$(".sr-keyword--info-sub").show();
			$(".category-srp--recom-cate").show();
			$(".adv-search").show();
		}
	}
	
	// 유사검색어 여부
	if(listType=="search") {
		if(dataObj.data.strFuzzy!="-1" && dataObj.data.strFuzzy!="0") {
			$(".similar-keyword").show();
		} else {
			$(".similar-keyword").hide();
		}
	}
	
	// 상품갯수 표기
	$("ul.list-filter__tab li[tabType="+param_tabType+"]").find(".list-tab--count").text(dataObj.total.format());
	
	var html = [];
	var hIdx = 0;
	
	var rank = 1; // 순위 표기용
	
	// 리스트형 type--list 그리드형 type--grid 소셜형 type--social
	var viewTypeClass = "type--list";
	if(viewType==1) {
	} else if(viewType==2) {
		viewTypeClass = "type--grid";
	}
	
	// 쿠폰 컨텐츠 임시 저장소 ( html 을 동적으로 삽입해야함 )
	var couponContentsObj = new Object();
	
	// 갤러리뷰 상품메우기 로직을 위해 3위 까지 임의의 class 부여
	var highRankMaxCnt = 3;
	
	// 애드쇼핑 그리는 판단자 ( 상품갯수가 16개 이상 일때 true )
	if( dataObj.data.nonAdItemSize >= 16 ) {
		blADShopping = true;
	}
	
	$.each(dataObj.data.list, function(index, item) {
		
		var strModelName = item.strModelName; // 상품명
		var strCaCode = item.strCate; // 상품의 원 카테고리
		var strExtraPriceTitle = item.strExtraPriceTitle; // 속성 특수가격 구분
		var strExtraPrice = item.strExtraPrice; // 속성 특수가격
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
		var strBrand = item.strBrand; // 브랜드
		var strPlNo = item.strPlNo; // 상품코드(plno)
		var strImageUrl = item.strImageUrl; // 이미지주소
		var strAdultYN = item.strAdultYN; // 성인상품유무
		var strTip = item.strTip; // 팁 노출문구
		var strBbsNum = item.strBbsNum; // 상품평 갯수
		var strBbsPoint = Math.floor(item.strBbsPoint*10)/10; // 상품평 평점
		var strKeywordDTypeYN = item.strKeywordDTypeYN; // 상품 D타입 유무(Y/N)
		var strCouponContents = item.strCouponContents; // 쿠폰문구
		var strShopCode = item.strShopCode; // 쇼핑몰코드
		var strShopName = item.strShopName; // 쇼핑몰명
		var strEventTxt = item.strEventTxt; // 이벤트 문구
		var strEventPrice = item.strEventPrice; // 이벤트 가격
		var strDeliveryInfo  = item.strDeliveryInfo; // 배송 문구
		var strLandUrl = item.strLandUrl; // 상품 링크 주소
		var optionViewType = item.optionViewType; // 옵션유형 ( model : 그룹모델 , shop : 쇼핑몰정보 , 없음 : 비노출 )
		var strOpenExpectFlag = item.strOpenExpectYN; // 출시예정 유무
		if(optionViewType=="" || optionViewType===undefined) {
			optionViewType="shop";
		}
		var groupModel = item.groupModel; // 그룹모델(옵션) 정보
		
		// 그룹모델의 순서를 바꾼다.
		var tmpGroupModelArray = [];
		if(groupModel && groupModel.list.length>5) {
			tmpGroupModelArray = groupModel.list;
			
			var rank14 = false; // 1~4 순위에 포함되어 있는지
			var rank5 = false; // 5 순위에 포함되어 있는지
			for(var g=0;g<5;g++) {
				var data = tmpGroupModelArray[g];
				if(data.strRank=="1" || data.strRank=="2") {
					if(g==4) {
						rank5 = true;
					} else {
						rank14 = true;
					}
				}
			}
			
			// 1, 2위 둘다 포함 ( rank14 true , rank5 true 그대로 )
			// 1, 2위 중 한개만 5번째 노출 ( rank14 false, rank5 true => 5번째를 4번째로, 나머지를 5번째로 
			// 1, 2위 중 한개만 1~4번째 노출 ( rank14 true, rank5 false => 다른 한개를 5번째 노출 
			// 1, 2위 둘다 미포함 ( rank14 false, rank5 false ) 
			if( !rank14 && rank5 ) {
			
				// 5위를 4위로
				var shifted = tmpGroupModelArray.splice(4, 1);
				tmpGroupModelArray.splice(3, 0, shifted[0]);
				
				// 6위부터 나머지가 있는지 조회
				for(var g_m=5; g_m<tmpGroupModelArray.length; g_m++) {
					if(tmpGroupModelArray[g_m].strRank=="1" || tmpGroupModelArray[g_m].strRank=="2") {
						var shifted_more = tmpGroupModelArray.splice(g_m, 1);
						tmpGroupModelArray.splice(4, 0, shifted_more[0]);
					}
				}
			} else if( rank14 && !rank5 ) {
			
				// 6위부터 나머지가 있는지 조회
				for(var g_m=5; g_m<tmpGroupModelArray.length; g_m++) {
					if(tmpGroupModelArray[g_m].strRank=="1" || tmpGroupModelArray[g_m].strRank=="2") {
						var shifted_more = tmpGroupModelArray.splice(g_m, 1);
						tmpGroupModelArray.splice(4, 0, shifted_more[0]);
					}
				}
			} else if( !rank14 && !rank5 ) {
				// 6위부터 나머지가 있는지 조회
				var shifted_rank1 = [];
				var shifted_rank2 = [];
				for(var g_m=0; g_m<tmpGroupModelArray.length; g_m++) {
					if(tmpGroupModelArray[g_m].strRank=="2") {
						shifted_rank2 = tmpGroupModelArray.splice(g_m, 1);
					}
				}
				if(shifted_rank2.length>0) {
					tmpGroupModelArray.splice(4, 0, shifted_rank2[0]);
				}
				for(var g_m=0; g_m<tmpGroupModelArray.length; g_m++) {
					if(tmpGroupModelArray[g_m].strRank=="1") {
						shifted_rank1 = tmpGroupModelArray.splice(g_m, 1);
					}
				}
				if(shifted_rank1.length>0) {
					tmpGroupModelArray.splice(3, 0, shifted_rank1[0]);
				}
			}
			
			groupModel.list = tmpGroupModelArray;
		}
		
		var strVideoYN = item.strVideoYN; // 비디오 포함여부
		var strPromotionUrl = item.strPromotionUrl; // 프로모션 링크 주소
		var strPromotionShopName  = item.strPromotionShopName; // 프로모션 쇼핑몰 이름
		var strZzimYN = item.strZzimYN;
		// 모델상품 중 찜표기가 되어있으면 저장한다. ( 레이어 표현 위해 ) 
		if(strZzimYN=="Y" && strModelNo!="") {
			zzimLayerSet.add(strModelNo);
		}
		
		/* -- ~Attr 은 유동적을 관리, 폐기될수 있음 */
		var priceAttr = item.priceAttr; // 가격 속성 
		var iconAttr = item.iconAttr; // 아이콘 속성
		var adAttr = item.adAttr; // 광고 속성
		var lpEtcAttr = item.lpEtcAttr; // LP 개별카테고리 속성 
		
		// 모델번호 저장
		if(strModelNo!="0") {
			modelNoSet.add(strModelNo);
		} else if(strPlNo!="0"){
			plNoSet.add(strPlNo);
		}
		
		// srp 일 경우 1등 상품의 카테고리를 저장한다. 
		if(listType=="search" && index==0 ){
			firstGoodsCate = strCaCode;
		}
		
		// 상품 Data-id 세팅, 대표모델 세팅
		var dataId = "";
		var dataOrigin = 0;
		var dataType = "model";
		if(strModelNo=="0") {
			dataId = "pl_"+strPlNo;
			dataType = "pl";
		} else {
			dataId = "model_"+strModelNo;
			modelNoGroupMap.set(strModelNo, groupModel);
		}
		if(strModelNo!="0" && strModelNoRep!==undefined && strModelNoRep.length>0) {
			dataOrigin = strModelNoRep;
		}
		
		if(viewType==1) {
			$(".goods-list").empty().append("<div class=\"goods-cont\"><ul class=\"goods-bundle\"></ul></div>");
		} else if(viewType==2) {
			$(".goods-list").empty().append("<div class=\"goods-cont\"><ul class=\"goods-bundle\"></ul><div class=\"goods-option-bundle\" style=\"display:none;\"><div class=\"goods-option\"></div></div></div>");
		}
		$(".goods-cont").addClass(viewTypeClass); // 뷰타입 설정

		var supertopNos = dataObj.data.supertopADNos; // 슈퍼탑 광고 번호
		
		var prodAddClass = "";
		if(strModelNo!="0" && item.strAdProdFlagYN=="Y") {
			prodAddClass += " ad";
		}
		
		if(viewType==2) {
			if(param_tabType==0 || param_tabType==1) {
				if(item.strAdProdFlagYN=="N" && highRankMaxCnt>0 && (dataObj.data.nonAdItemSize<=param_pageGap)) {
					prodAddClass += " highrank";
					highRankMaxCnt--;
				}
			} else {
				if(highRankMaxCnt>0 && (dataObj.data.nonAdItemSize<=param_pageGap)) {
					prodAddClass += " highrank";
					highRankMaxCnt--;
				}
			}
		}
		
		// <!-- 리스트형 : 반복 -->
		// 슈퍼탑 상품은 비노출 , supertop.js 에서 처리
		if(strModelNo!="0") { 
			if(item.strAdProdFlagYN=="Y") {
				// ad 클래스 생성, 슈퍼탑 그릴때 .ad-supertop 으로 이동.
				html[hIdx++] = "<li class=\"prodItem"+prodAddClass+"\" data-type=\""+dataType+"\" data-id=\""+dataId+"\" data-model-origin=\""+dataOrigin+"\" data-cate=\""+strCaCode+"\" data-factory=\""+strFactory.toUpperCase()+"\" data-viewtype=\""+optionViewType+"\" style=\"display:none\">"; // 일단 비노출 처리
			} else {
				html[hIdx++] = "<li class=\"prodItem"+prodAddClass+"\" data-type=\""+dataType+"\" data-id=\""+dataId+"\" data-model-origin=\""+dataOrigin+"\" data-cate=\""+strCaCode+"\" data-factory=\""+strFactory.toUpperCase()+"\" data-viewtype=\""+optionViewType+"\">";
			}
		} else {
			html[hIdx++] = "	<li class=\"prodItem"+prodAddClass+"\" data-type=\""+dataType+"\" data-id=\""+dataId+"\" data-viewtype=\""+optionViewType+"\">";
		}
		
		/*--------------------------- 리스트형 ------------------------------------*/
		if(viewType==1) {
		
			// 모델상품
			if(strModelNo!="0") {
				
				// 					<!-- 리스트형 : 가격비교 > Full Case -->
				html[hIdx++] = "	<div class=\"goods-item\">";
				//						<!-- 썸네일 -->
				html[hIdx++] = "		<div class=\"item__thumb\">";
				// 							<!-- 히트 브랜드 (기존유지)-->
				if(adAttr.hitbrand!==undefined) {
					html[hIdx++] = 	"		<span class=\"badge_hitbrand\">히트브랜드</span>";
				}
				//							<!-- // -->
				html[hIdx++] = "			<a href=\"/detail.jsp?modelno="+strModelNo+"\" target=\"_blank\">";
				html[hIdx++] = "				<img class=\"lazy\" data-original=\""+strImageUrl+"\"  onerror=\"this.src='"+noImageStr+"'\" alt=\""+strModelName+"\">";
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
				
				if(strVideoYN=="Y") {
					html[hIdx++] = "				<button class=\"item__btn--movie\" title=\"동영상 보기\" onclick=\"javascript:loadThumNail("+strModelNoRep+",1);\"><i class=\"ico-item--movie lp__sprite\">동영상 보기</i></button>";
				}
				//									<!-- 버튼 : 이미지 크게보기 -->
				if( !(strAdultYN=="Y" && isAdultFlag=="false") ) { // 성인상품이면서 성인인증을 받지 않은 경우를 제외하고 돋보기 노출 
					html[hIdx++] = "				<button class=\"item__btn--view\" title=\"크게보기\" onclick=\"javascript:loadThumNail("+strModelNoRep+");\"><i class=\"ico-item--view lp__sprite\">크게보기</i></button>";
				}
				//									<!-- 버튼 : 비교하기 -->
				html[hIdx++] = "					<button class=\"item__btn--compare\" title=\"상품비교\" ><i class=\"ico-item--compare lp__sprite\">상품비교</i></button>";
				//									<!-- 버튼 : 찜하기 -->
				//									<!-- 찜된 상품 .is--on -->
				if( (strZzimYN=="Y" && !zzimTmpModelNoRemoveSet.has(strModelNo)) || zzimTmpModelNoSet.has(strModelNo)) {
					html[hIdx++] = "					<button class=\"item__btn--zzim is--on\" title=\"찜\" data-zzimno=\"G"+strModelNo+"\" onclick=\"showLayZzim_list(this);return false;\"><i class=\"ico-item--zzim lp__sprite\">찜</i></button>";
				} else {
					html[hIdx++] = "					<button class=\"item__btn--zzim\" title=\"찜\" data-zzimno=\"G"+strModelNo+"\" onclick=\"showLayZzim_list(this);return false;\"><i class=\"ico-item--zzim lp__sprite\">찜</i></button>";
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
				
				if(item.strAdProdFlagYN=="Y") {
					html[hIdx++] = "				<span class=\"tag--ad\">AD</span>";
				} 
				// 순위 ( 1페이지, 인기순 일때만 ) rank
				if(param_pageNum==1 && param_sort=="1" && item.strAdProdFlagYN=="N") {
					html[hIdx++] = "				<span class=\"tag--rank\">"+(rank++)+"</span>";
				}
				
				// sr #45776 [PC] LP/SRP > 심플리스트 > 특정카테고리 그룹모델 VIP 발생 로직 변경
				// 심플리스트뷰의 그룹모델 상품명 클릭 시 지정 그룹조건의 VIP로 랜딩
				if(listType=="list" && param_cate.substring(0,4)=="2401" && groupModel.list!==undefined) {
					var tmpModelNo = changeModelNumber2401(strModelNo,groupModel.list);
					html[hIdx++] = "				<a href=\"/detail.jsp?modelno="+tmpModelNo+"\" target=\"_blank\" data-type=\"modelname\">"+strModelName+"</a>";
				} else {
					html[hIdx++] = "				<a href=\"/detail.jsp?modelno="+strModelNo+"\" target=\"_blank\" data-type=\"modelname\">"+strModelName+"</a>";
				}
				
				//	case 1. <!-- 브랜드관 --> 미사용 <span class="tag--brand lp__sprite">브랜드관</span>
				//	case 2. <!-- 쇼핑몰 추가할인 -->
				if (strPromotionUrl != undefined && strPromotionShopName != undefined && strPromotionUrl != "" && strPromotionShopName != "") {
					html[hIdx++] = "				<a href=\""+strPromotionUrl+"\" target=\"_blank\" class=\"tag--discount\"><i class=\"ico-tag-enuri lp__sprite\"></i>"+strPromotionShopName+" 추가할인</a>";
				}
				html[hIdx++] = "				</div>";
				// 								<!-- 카피문구 -->
				// 								<!-- '/'' 구분자는 li태그에 자동으로 붙습니다 -->
				//								<!-- 상세검색 매칭되는 속성은 em태그로 감사주세요 -->
				if(strTip && strTip.length>0) {
					strTip = strTip.split("▶").join("");
					html[hIdx++] = "			<div class=\"item__tx--copy\">"+strTip+"</div>";
				}
				// 								<!-- 속성/용어사전 -->
				if(strSpec1 && strSpec1.length>0) {
					html[hIdx++] = "			<ul class=\"item__attr\">" +makerSpecTagDic(strSpec1) + "</ul>";
				}
				// 								<!-- 대괄호속성 -->
				if(strSpec2 && strSpec2.length>0) {
					html[hIdx++] = "			<div class=\"item__summ\">" +makeSpecTagBig(strSpec2) + "</div>";
				}
				//								<!-- 컨텐츠 -->
				// getModelsEventInfo_ajax2 : 뉴스, 브랜드관, 이벤트, 특가, 사용기
				// getKnowBoxFlashReview_ajax : 리뷰
				html[hIdx++] = "				<div class=\"item__cont\"></div>";
				//								<!-- 성분 / 등급 / 자재,착석감 등 -->
				html[hIdx++] = "				<div class=\"item__addinfo\">";
				//									<!-- 화장품 전성분 UI -->
				if(lpEtcAttr.cosmetic) {
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
					if(lpEtcAttr.cosmetic.value) {
						html[hIdx++] = "					<ul class=\"lpcosmetics__list\">";
						$.each(lpEtcAttr.cosmetic.value,function(index,listData){
							html[hIdx++] = "					<li>";
							html[hIdx++] = "						<span class=\"lpcosmetics__tit\">"+listData.cpt_goodness+"</span>";
							html[hIdx++] = "							<div class=\"watergraph\">";
							html[hIdx++] = "								<em class=\"watergraph data data"+Math.round(listData.cpt_goodness_percent_gage/10)*10+"\">"+listData.cpt_goodness_percent_gage+"%</em>";
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
				if(lpEtcAttr.furniture) {
					html[hIdx++] = "				<div class=\"lpfurniture\">";
					
					$.each(lpEtcAttr.furniture,function(index,listData){
						var attribute_id = listData["attribute_id"];
						var attribute_element_id = listData["attribute_element_id"];
						var attribute_element = listData["attribute_element"];
						var attribute_title = listData["title"];
						var attribute_type = listData["type"];
						if(attribute_type==1) {
							//							<!-- 자재등급.grade--01 -->
							html[hIdx++] = "			<div class=\"lpfurniture__grade grade--01\">";
							html[hIdx++] = "				<div class=\"lpfurniture__tit\"><a href=\"javascript:void(0);\" class=\"btn--dic\" data-attr_id=\""+attribute_id+"\" data-attr_el_id=\"0\" onclick=\"showDicLayer(this);return false;\" title=\"클릭 시 용어사전\">자재등급</a></div>";
							html[hIdx++] = "				<div class=\"lpfurniture__level level--"+attribute_element.toLowerCase()+"\"></div>";
							html[hIdx++] = "			</div>";
							//							<!-- // -->
						} else if(attribute_type=="2") {
							//							<!-- 쿠션감 / 착석감 .grade--2 -->  att_txt_211331_0
							html[hIdx++] = "			<div class=\"lpfurniture__grade grade--02\">";
							html[hIdx++] = "				<div class=\"lpfurniture__tit\"><a href=\"javascript:void(0);\" class=\"btn--dic\" data-attr_id=\""+attribute_id+"\" data-attr_el_id=\"0\" onclick=\"showDicLayer(this);return false;\" title=\"클릭 시 용어사전\">착석감</a></div>";
							// <!-- <div class="lpfurniture__tit"><a href="#" onclick="showDicLayer(this);return false;" title="클릭 시 용어사전">착석감</a></div> -->
							html[hIdx++] = "				<div class=\"lpfurniture__level level--0"+attribute_element_id+"\"></div>";
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
				if(strModelNo != "0") {
					html[hIdx++] = "						<a href=\"/detail.jsp?modelno="+strModelNo+"&focus=bbs\" target=\"_blank\">";
					if(strBbsPoint!="0" && strBbsPoint!="0.0") {
						html[hIdx++] = "						<i class=\"ico-etc-star lp__sprite\"></i><strong>"+strBbsPoint+"점</strong> ("+strBbsNum.format()+"건)";
					} else if(strBbsNum!="0"){
						html[hIdx++] = strBbsNum.format()+"건";
					}
					html[hIdx++] = "						</a>";
				} else {
					if(strBbsPoint!="0" && strBbsPoint!="0.0") {
						html[hIdx++] = "					<i class=\"ico-etc-star lp__sprite\"></i><strong>"+strBbsPoint+"점</strong> ("+strBbsNum.format()+"건)";
					} else if(strBbsNum!="0"){
						html[hIdx++] = strBbsNum.format()+"건";
					}
				}
				html[hIdx++] = "						</li>";
				//										<!-- 등록일 -->
				if(strCdate.length>0 && strCdate.length==8) {
					html[hIdx++] = "					<li class=\"item__etc--date\">등록일 "+strCdate.substring(0,4)+"."+strCdate.substring(4,6)+"</li>";
				}
				// 										<!-- 브랜드/제조사 모아보기 --> 제조사 1 브랜드 2
				if(listType=="list") {
					if(lpSetupInfo.tab_factory_flag=="" || lpSetupInfo.tab_factory_flag=="1" && strFactory.length>0) {
						html[hIdx++] = "				<li class=\"item__etc--brand\"><a href=\"javascript:void(0);\" class=\"btn--view-brand\" viewtype=\"factory\" searchtext=\""+strFactory+"\">"+strFactory+"<i class=\"ico-etc-sr lp__sprite\"></i></a></li>";
					} else if(lpSetupInfo.tab_brand_flag=="" || lpSetupInfo.tab_brand_flag=="1" && strBrand.length>0) {
						html[hIdx++] = "				<li class=\"item__etc--brand\"><a href=\"javascript:void(0);\" class=\"btn--view-brand\" viewtype=\"brand\" searchtext=\""+strBrand+"\">"+strBrand+"<i class=\"ico-etc-sr lp__sprite\"></i></a></li>";
					}
				} else if(listType=="search") {
					if(strFactory.length>0) {
						html[hIdx++] = "				<li class=\"item__etc--brand\"><a href=\"javascript:void(0);\" class=\"btn--view-brand\" viewtype=\"factory\" searchtext=\""+strFactory+"\">"+strFactory+"<i class=\"ico-etc-sr lp__sprite\"></i></a></li>";
					} else if(strBrand.length>0) {
						html[hIdx++] = "				<li class=\"item__etc--brand\"><a href=\"javascript:void(0);\" class=\"btn--view-brand\" viewtype=\"brand\" searchtext=\""+strBrand+"\">"+strBrand+"<i class=\"ico-etc-sr lp__sprite\"></i></a></li>";
					}
				}
				html[hIdx++] = "					</ul>";
				html[hIdx++] = "				</div>";
				html[hIdx++] = "			</div>";
				//							<!-- // -->
				if(optionViewType=="model" || groupModel.list!==undefined) {
					html[hIdx++] = drawGroupModel(groupModel, strExtraPriceTitle, strExtraPrice, strOpenExpectFlag);
				}
				html[hIdx++] = "		</div>";
				html[hIdx++] = "	</div>";
			
			// 일반상품
			} else {
				
				var plMoveLinkUrl = "/move/Redirect.jsp?type=ex&cmd=move_"+strPlNo+"&pl_no="+strPlNo;
				
				//					<!-- 리스트형 : 일반상품 Case -->
				html[hIdx++] = "	<div class=\"goods-item\">";
				//						<!-- 썸네일 -->
				html[hIdx++] = "		<div class=\"item__thumb\">";
				html[hIdx++] = "			<a href=\""+plMoveLinkUrl+"\" target=\"_blank\">";
				html[hIdx++] = "				<img class=\"lazy\" data-original=\""+strImageUrl+"\" src=\""+noImageStr+"\" alt=\""+strModelName+"\">";
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
				if((strZzimYN=="Y" && !zzimTmpPlNoRemoveSet.has(strPlNo)) || zzimTmpPlNoSet.has(strPlNo)) {
					html[hIdx++] = "					<button class=\"item__btn--zzim is--on\" title=\"찜\" data-zzimno=\"P"+strPlNo+"\" onclick=\"showLayZzim_list(this);return false;\"><i class=\"ico-item--zzim lp__sprite\">찜</i></button>";
				} else {
					html[hIdx++] = "					<button class=\"item__btn--zzim\" title=\"찜\" data-zzimno=\"P"+strPlNo+"\" onclick=\"showLayZzim_list(this);return false;\"><i class=\"ico-item--zzim lp__sprite\">찜</i></button>";
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
				if(param_pageNum==1 && param_sort=="1" && item.strAdProdFlagYN=="N") {
					html[hIdx++] = "				<span class=\"tag--rank\">"+(rank++)+"</span>";
				}
				html[hIdx++] = "					<a href=\""+plMoveLinkUrl+"\" target=\"_blank\" data-type=\"modelname\">"+strModelName+"</a>";
				html[hIdx++] = "				</div>";
				//								<!-- 카드 무이자 정보 -->
				if(item.strFreeinterest!==undefined && item.strFreeinterest.length>0) {
					html[hIdx++] = "			<ul class=\"item__attr\">";
					html[hIdx++] = "				<li>"+convertFreeInterest(item.strFreeinterest)+"</li>";
					html[hIdx++] = "			</ul>";
				}
				//								<!-- 기타 -->
				html[hIdx++] = "				<div class=\"item__etc\">";
				html[hIdx++] = "					<ul>";
				//										<!-- 상품평/평점 -->
				html[hIdx++] = "						<li class=\"item__etc--score\">";
				if(strModelNo != "0") {
					html[hIdx++] = "						<a href=\"/detail.jsp?modelno="+strModelNo+"&focus=bbs\" target=\"_blank\">";
					if(strBbsPoint!="0" && strBbsPoint!="0.0") {
						html[hIdx++] = "						<i class=\"ico-etc-star lp__sprite\"></i><strong>"+strBbsPoint+"점</strong> ("+strBbsNum.format()+"건)";
					} else if(strBbsNum!="0"){
						html[hIdx++] = strBbsNum.format()+"건";
					}
					html[hIdx++] = "						</a>";
				} else {
					if(strBbsPoint!="0" && strBbsPoint!="0.0") {
						html[hIdx++] = "					<i class=\"ico-etc-star lp__sprite\"></i><strong>"+strBbsPoint+"점</strong> ("+strBbsNum.format()+"건)";
					} else if(strBbsNum!="0"){
						html[hIdx++] = "<span class=\"tx_tit\">상품평</span> ("+strBbsNum.format()+"건)";
					}
				}
				html[hIdx++] = "						</li>";
				//										<!-- 등록일 -->
				if(strCdate.length>0 && strCdate.length==8) {
					html[hIdx++] = "					<li class=\"item__etc--date\">등록일 "+strCdate.substring(0,4)+"."+strCdate.substring(4,6)+"</li>";
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
				if(strShopName!="" && iconAttr.naverpay!==undefined ) {
					html[hIdx++] = "					<span class=\"tx--mall-npay\">"+strShopName+"</span>";
				//										<!-- 로고형 -->
				} else if(strShopCode!="0" && strShopName!="") {
					html[hIdx++] = "					<img class=\"lazy\" data-original=\"//storage.enuri.info/logo/logo20/logo_20_"+strShopCode+".png\" src=\"//storage.enuri.info/logo/logo20/logo_20_"+strShopCode+".png\" alt=\""+strShopName+"\" onerror=\"javascript:logoImgNotFound(this);\">";
				}
				html[hIdx++] = "					</div>";
				//									<!-- 가격 -->
				html[hIdx++] = "					<div class=\"col--price\">";
				if(iconAttr.cash!==undefined) {
					//									<!-- 현금 -->
					html[hIdx++] = "					<span class=\"tag--cash lp__sprite\">현금</span>";
				}
				if(iconAttr.ovs!==undefined) {
					//									<!-- 직구 -->
					html[hIdx++] = "					<span class=\"tag--global lp__sprite\">직구</span>";
				}
				if(strCouponContents.length>0) {
					// 모델, 컨텐츠 
					var obj = {};
					obj["P:"+strPlNo] = strCouponContents;
					Object.assign(couponContentsObj, obj);
					
					//									<!-- 쿠폰 -->
					html[hIdx++] = "					<div class=\"tag--coupon\">";
					html[hIdx++] = "						<i class=\"ico-tag--coupon lp__sprite\">쿠폰</i>";
					html[hIdx++] = "						<div class=\"lay-coupon lay-comm lay-comm--sm\" style=\"display:none;\">";
					html[hIdx++] = "							<div class=\"lay-comm--head\">";
					html[hIdx++] = "								<strong class=\"lay-comm__tit\">";
					html[hIdx++] =	"									본 가격은 <em>추가할인 쿠폰</em> 적용가 입니다.</strong>";
					html[hIdx++] = "								</strong>";
					html[hIdx++] = "							</div>";
					html[hIdx++] = "							<div class=\"lay-comm--body\">";
					html[hIdx++] = "								<div class=\"lay-comm__inner\">";
				//	html[hIdx++] = strCouponContents;
					html[hIdx++] = "									<div class=\"lay-coupon__price\">";
					html[hIdx++] = "										쿠폰적용가 : <em>"+strMinPrice+"</em>원";
					html[hIdx++] = "									</div>";
					html[hIdx++] = "								</div>";
					html[hIdx++] = "							</div>";
					html[hIdx++] = "						</div>";
					html[hIdx++] = "					</div>";
				}
				html[hIdx++] = "						<a href=\""+plMoveLinkUrl+"\" target=\"_blank\"><em>"+strMinPrice+"</em>원</a>";
				html[hIdx++] = "					</div>";
				html[hIdx++] = "				</div>";
				//								<!-- // -->
				//								<!-- 배송료 --> "배송비" 문구가 있으면 tx--delivery--paid 클래스, 없으면 tx--delivery 클래스
				if(strDeliveryInfo!==undefined) {
					if(strDeliveryInfo.indexOf("배송비")>-1) {
						html[hIdx++] = "		<div class=\"tx--delivery--paid\">"+strDeliveryInfo+"</div>";
					} else if(strDeliveryInfo!="0") {
						html[hIdx++] = "		<div class=\"tx--delivery\">"+strDeliveryInfo+"</div>";
					}
				}
				//								<!-- // -->
				html[hIdx++] = "			</div>";
				html[hIdx++] = "		</div>";
				html[hIdx++] = "	</div>";
			}
			// 						<!-- // -->
			
		/*--------------------------- 그리드형 ------------------------------------*/
		} else if(viewType==2) {
			
			// 모델상품
			if(strModelNo!="0") {
				
//				<!-- 그리드형 : Full Case -->
				html[hIdx++] = "	<div class=\"goods-item\">";
				//						<!-- 썸네일 -->
				html[hIdx++] = "		<div class=\"item__thumb\">";
				//							<!-- 히트 브랜드 (기존유지)-->
				if(adAttr.hitbrand!==undefined) {
					html[hIdx++] = "		<span class=\"badge_hitbrand\">히트브랜드</span>";
				}
				//							<!-- // -->
				html[hIdx++] = "			<a href=\"/detail.jsp?modelno="+strModelNo+"\" target=\"_blank\">";
				html[hIdx++] = "				<img class=\"lazy\" data-original=\""+strImageUrl+"\" src=\""+noImageStr+"\" alt=\""+strModelName+"\">";
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
				if(strVideoYN=="Y") {
					html[hIdx++] = "				<button class=\"item__btn--movie\" title=\"동영상 보기\" onclick=\"javascript:loadThumNail("+strModelNo+",1);\"><i class=\"ico-item--movie lp__sprite\">동영상 보기</i></button>";
				}
				//									<!-- 버튼 : 이미지 크게보기 -->
				if( !(strAdultYN=="Y" && isAdultFlag=="false") ) { // 성인상품이면서 성인인증을 받지 않은 경우를 제외하고 돋보기 노출
					html[hIdx++] = "				<button class=\"item__btn--view\" title=\"크게보기\" onclick=\"javascript:loadThumNail("+strModelNo+");\"><i class=\"ico-item--view lp__sprite\">크게보기</i></button>";
				}
				//									<!-- 버튼 : 비교하기 -->
				html[hIdx++] = "					<button class=\"item__btn--compare\" title=\"상품비교\" ><i class=\"ico-item--compare lp__sprite\">상품비교</i></button>";
				//									<!-- 버튼 : 찜하기 -->
				//									<!-- 찜된 상품 .is--on -->
				if((strZzimYN=="Y" && !zzimTmpModelNoRemoveSet.has(strModelNo)) || zzimTmpModelNoSet.has(strModelNo)) {
					html[hIdx++] = "				<button class=\"item__btn--zzim is--on\" title=\"찜\" data-zzimno=\"G"+strModelNo+"\" onclick=\"showLayZzim_list(this);return false;\"><i class=\"ico-item--zzim lp__sprite\">찜</i></button>";
				} else {
					html[hIdx++] = "				<button class=\"item__btn--zzim\" title=\"찜\" data-zzimno=\"G"+strModelNo+"\" onclick=\"showLayZzim_list(this);return false;\"><i class=\"ico-item--zzim lp__sprite\">찜</i></button>";
				}
				html[hIdx++] = "				</div>";
				html[hIdx++] = "			</div>";
				// 							<!-- // -->
				html[hIdx++] = "		</div>";
				//						<!-- // -->
				html[hIdx++] = "		<div class=\"item__box\">";
				//							<!-- 상품정보 -->
				html[hIdx++] = "			<div class=\"item__info\">";
				//								<!-- 모델명 -->
				html[hIdx++] = "				<div class=\"item__model\">";
				html[hIdx++] = "					<a href=\"/detail.jsp?modelno="+strModelNo+"\" target=\"_blank\" data-type=\"modelname\">";
				if(item.strAdProdFlagYN=="Y") {
					html[hIdx++] = "					<span class=\"tag--ad\">AD</span>";
				} 
				// 순위 ( 1페이지, 인기순 일때만 ) rank
				if(param_pageNum==1 && param_sort=="1" && item.strAdProdFlagYN=="N") {
					html[hIdx++] = "					<span class=\"tag--rank\">"+(rank++)+"</span>";
				}
				
				html[hIdx++] = strModelName;
				html[hIdx++] = "					</a>";
				html[hIdx++] = "				</div>";
				//								<!-- // -->
				//								<!-- 상품 요약 -->
				html[hIdx++] = "				<div class=\"item__summ\">";
				//									<!-- 출시일 -->
				if(strCdate.length>0 && strCdate.length==8) {
					html[hIdx++] = "				<dl class=\"item__summ--releasedate\">";
					html[hIdx++] = "					<dt>등록일</dt>";
					html[hIdx++] = "					<dd>"+strCdate.substring(0,4)+"."+strCdate.substring(4,6)+"</dd>";
					html[hIdx++] = "				</dl>";
				}
				//									<!-- 판매몰수 -->
				if(strMallCnt!="0") {
					html[hIdx++] = "				<dl class=\"item__summ--mall\">";
					html[hIdx++] = "					<dt>판매몰</dt>";
					html[hIdx++] = "					<dt>"+strMallCnt+"몰</dt>";
					html[hIdx++] = "				</dl>";
				}
				html[hIdx++] = "				</div>";
				//								<!-- 기타 -->
				html[hIdx++] = "				<div class=\"item__etc\">";
				html[hIdx++] = "					<ul>";
				//										<!-- 상품평/평점 -->
				html[hIdx++] = "						<li class=\"item__etc--score\">";
				html[hIdx++] = "							<a href=\"/detail.jsp?modelno="+strModelNo+"&focus=bbs\" target=\"_blank\">";
				if(strBbsPoint!="0" && strBbsPoint!="0.0") {
					html[hIdx++] = "							<i class=\"ico-etc-star lp__sprite\"></i><strong>"+strBbsPoint+"점</strong> ("+strBbsNum.format()+"건)";
				} else if(strBbsNum!="0"){
					html[hIdx++] = strBbsNum.format()+"건";
				}
				html[hIdx++] = "							</a>";
				html[hIdx++] = "						</li>";
				html[hIdx++] = "					</ul>";
				html[hIdx++] = "				</div>";
				html[hIdx++] = "			</div>";
				//							<!-- // -->
				//							<!-- 상품가격 : 가격비교형 -->
				html[hIdx++] = "			<div class=\"item__price\">";
				//								<!-- 출시가 (모델상품 전용)-->
				if(strExtraPriceTitle.length>0 && strExtraPrice.length>0) {
					html[hIdx++] = "			<div class=\"tx--release-price\">";
					html[hIdx++] = "				<span class=\"tx_price\">"+strExtraPrice+"원</span>";
					html[hIdx++] = "			</div>";
				}
				if(iconAttr.cash!==undefined) {
					//							<!-- 현금 -->
					html[hIdx++] = "			<span class=\"tag--cash lp__sprite\">현금</span>";
				}
				if(iconAttr.ovs!==undefined) {
					//							<!-- 직구 -->
					html[hIdx++] = "			<span class=\"tag--global lp__sprite\">직구</span>";
				}
				if(strCouponContents.length>0) {
					// 모델, 컨텐츠 
					var obj = {};
					obj["G:"+strModelNo] = strCouponContents;
					Object.assign(couponContentsObj, obj);
					
					//							<!-- 쿠폰 -->
					html[hIdx++] = "			<div class=\"tag--coupon\">";
					html[hIdx++] = "				<i class=\"ico-tag--coupon lp__sprite\">쿠폰</i>";
					html[hIdx++] = "				<div class=\"lay-coupon lay-comm lay-comm--sm\" style=\"display:none;\">";
					html[hIdx++] = "					<div class=\"lay-comm--head\">";
					html[hIdx++] = "						<strong class=\"lay-comm__tit\">";
					html[hIdx++] =	"							본 가격은 <em>추가할인 쿠폰</em> 적용가 입니다.</strong>";
					html[hIdx++] = "						</strong>";
					html[hIdx++] = "					</div>";
					html[hIdx++] = "					<div class=\"lay-comm--body\">";
					html[hIdx++] = "						<div class=\"lay-comm__inner\">";
				//	html[hIdx++] = strCouponContents;
					html[hIdx++] = "							<div class=\"lay-coupon__price\">";
					html[hIdx++] = "								쿠폰적용가 : <em>"+strMinPrice+"</em>원";
					html[hIdx++] = "							</div>";
					html[hIdx++] = "						</div>";
					html[hIdx++] = "					</div>";
					html[hIdx++] = "				</div>";
					html[hIdx++] = "			</div>";
				}
				if(strMinPriceMobileTag=="Y") {
					html[hIdx++] = "			<span class=\"tag--mobile lp__sprite\" onclick=\"javascript:mobileMinPriceLayer(this);\">모바일최저가</span>";
				}
				//								<!-- 가격 -->
				if(strOpenExpectFlag=="Y") {
					html[hIdx++] = "			<a href=\"/detail.jsp?modelno="+strModelNo+"\" target=\"_blank\" class=\"tx--price\">";	
					html[hIdx++] = "				<span class=\"tx--sold\">가격미정</span>";
					html[hIdx++] = "			</a>";
				} else if(strProdStatusTxt.length>0) {
					html[hIdx++] = "			<a href=\"/detail.jsp?modelno="+strModelNo+"\" target=\"_blank\" class=\"tx--price\">";	
					html[hIdx++] = "				<span class=\"tx--sold\">"+strProdStatusTxt+"</span>";
					html[hIdx++] = "			</a>";
				} else if(strMinPrice.length>0) {
					html[hIdx++] = "			<a href=\"/detail.jsp?modelno="+strModelNo+"\" target=\"_blank\" class=\"tx--price\">";	
					if(iconAttr.cash!==undefined && iconAttr.cash.price!==undefined) {
						html[hIdx++] = "			최저가 <em>"+iconAttr.cash.price+"</em>원";
					} else {
						html[hIdx++] = "			최저가 <em>"+strMinPrice+"</em>원";
					}
					html[hIdx++] = "			</a>";
				}
				//								<!-- // -->
				html[hIdx++] = "			</div>";
				//							<!-- // -->
				html[hIdx++] = "		</div>";
				//						<!-- 옵션, 쇼핑몰 더보기 / 쇼핑몰 바로가기 -->
				html[hIdx++] = "		<div class=\"item__foot\">";
				//							<!-- 버튼 : 옵션 펼치기 -->
				if(optionViewType=="model" && groupModel && groupModel.list!==undefined) {
					if(groupModel.list.length>0) {
						html[hIdx++] = "	<button class=\"btn--opt-unfold\">다른옵션 더보기<i class=\"ico-arr-select-box lp__sprite\"></i></button>";
					}
				} else if(optionViewType=="shop") {
					if(strProdStatusTxt.length>0) {
						html[hIdx++] = "출시예정";
					} else {
						html[hIdx++] = "	<button class=\"btn--opt-unfold\">쇼핑몰 더보기<i class=\"ico-arr-select-box lp__sprite\"></i></button>";
					}
				}
				//							<!-- // -->
				html[hIdx++] = "		</div>";
				html[hIdx++] = "	</div>";
				
			// 일반상품	
			} else {

				var plMoveLinkUrl = "/move/Redirect.jsp?type=ex&cmd=move_"+strPlNo+"&pl_no="+strPlNo;
				
				html[hIdx++] = "	<div class=\"goods-item\">";
				//						<!-- 썸네일 -->
				html[hIdx++] = "		<div class=\"item__thumb\">";
				html[hIdx++] = "			<a href=\""+plMoveLinkUrl+"\" target=\"_blank\">";
				html[hIdx++] = "				<img class=\"lazy\" data-original=\""+strImageUrl+"\" src=\""+noImageStr+"\" alt=\""+strModelName+"\">";
				html[hIdx++] = "			</a>";
				//							<!-- 동영상/찜/비교/크게보기 -->
				html[hIdx++] = "			<div class=\"item__menu\">";
				html[hIdx++] = "				<div class=\"item__menu__inner\">";
				//									<!-- 버튼 : 비교하기 -->
				// html[hIdx++] = "					<button class=\"item__btn--compare\" title=\"상품비교\" onclick=\"javascript:compareProdInput('P"+strPlNo+"');\"><i class=\"ico-item--compare lp__sprite\">상품비교</i></button>";
				//									<!-- 버튼 : 찜하기 -->
				//									<!-- 찜된 상품 .is--on -->
				if((strZzimYN=="Y" && !zzimTmpPlNoRemoveSet.has(strModelNo)) || zzimTmpPlNoSet.has(strPlNo)) {
					html[hIdx++] = "					<button class=\"item__btn--zzim is--on\" title=\"찜\" data-zzimno=\"P"+strPlNo+"\" onclick=\"showLayZzim_list(this);return false;\"><i class=\"ico-item--zzim lp__sprite\">찜</i></button>";
				} else {
					html[hIdx++] = "					<button class=\"item__btn--zzim\" title=\"찜\" data-zzimno=\"P"+strPlNo+"\" onclick=\"showLayZzim_list(this);return false;\"><i class=\"ico-item--zzim lp__sprite\">찜</i></button>";
				}
				html[hIdx++] = "				</div>";
				html[hIdx++] = "			</div>";
				// 							<!-- // -->
				html[hIdx++] = "		</div>";
				//						<!-- // -->
				html[hIdx++] = "		<div class=\"item__box\">";
				//							<!-- 상품정보 -->
				html[hIdx++] = "			<div class=\"item__info\">";
				//								<!-- 모델명 -->
				html[hIdx++] = "				<div class=\"item__model type--general\">";
				html[hIdx++] = "					<a href=\""+plMoveLinkUrl+"\" target=\"_blank\" data-type=\"modelname\">";
				// 순위 ( 1페이지, 인기순 일때만 ) rank
				if(param_pageNum==1 && param_sort=="1" && item.strAdProdFlagYN=="N") {
					html[hIdx++] = "					<span class=\"tag--rank\">"+(rank++)+"</span>";
				}
				html[hIdx++] = strModelName;
				html[hIdx++] = "					</a>";
				html[hIdx++] = "				</div>";
				//								<!-- // -->
				//								<!-- 상품 요약 -->
				html[hIdx++] = "				<div class=\"item__summ\">";
				if(strCdate.length>0 && strCdate.length==8) {
					//								<!-- 출시일 -->
					html[hIdx++] = "				<dl class=\"item__summ--releasedate\">";
					html[hIdx++] = "					<dt>출시일</dt>";
					html[hIdx++] = "					<dd>"+strCdate.substring(0,4)+"."+strCdate.substring(4,6)+"</dd>";
					html[hIdx++] = "				</dl>";
				}
				/*
				if(strBbsPoint!="0" && strBbsPoint!="0.0") {
					html[hIdx++] = "				<dl class=\"item__summ--score\">";
			   		html[hIdx++] = "					<dt>상품평</dt>";
			    	html[hIdx++] = "					<dd>"+strBbsNum.format()+"건</dd>";
					html[hIdx++] = "				</dl>";
					html[hIdx++] = "			</div>";
					html[hIdx++] = "			<div class=\"item__etc\">";
					html[hIdx++] = "    			<ul>";
					html[hIdx++] = "        			<li class=\"item__etc--score\"><i class=\"ico-etc-star lp__sprite\"></i><strong>"+strBbsPoint+"점</strong> ("+strBbsNum.format()+"건)</li>";
					html[hIdx++] = "    			</ul>";
				} else if(strBbsNum!="0"){
					html[hIdx++] = 	"				<dl class=\"item__summ--score\">";
			   		html[hIdx++] =  "					<dt>상품평</dt>";
			    	html[hIdx++] =  "					<dd>"+strBbsNum.format()+"건</dd>";
					html[hIdx++] = 	"				</dl>";
				}
				*/
				if(strBbsPoint!="0" && strBbsPoint!="0.0") {
					html[hIdx++] = "			</div>";
					html[hIdx++] = "			<div class=\"item__etc\">";
					html[hIdx++] = "    			<ul>";
					html[hIdx++] = "        			<li class=\"item__etc--score\"><i class=\"ico-etc-star lp__sprite\"></i><strong>"+strBbsPoint+"점</strong> ("+strBbsNum.format()+"건)</li>";
					html[hIdx++] = "    			</ul>";
				} else if(strBbsNum!="0"){
					html[hIdx++] = "			</div>";
					html[hIdx++] = "			<div class=\"item__etc\">";
					html[hIdx++] = "    			<ul>";
					html[hIdx++] = "        			<li class=\"item__etc--score\"><p><span class=\"tx_tit\">상품평</span> ("+strBbsNum.format()+"건)</p></li>";
					html[hIdx++] = "    			</ul>";
				}
				html[hIdx++] = "				</div>";
				html[hIdx++] = "			</div>";
				//							<!-- 상품가격 : 일반상품 -->
				html[hIdx++] = "			<div class=\"item__price\">";
				//								<!-- 배송료 (일반상품 전용)-->
				if(strDeliveryInfo && strDeliveryInfo.length>0 && strDeliveryInfo!="0") {
					html[hIdx++] = "			<div class=\"tx--deleveryfee\">"+strDeliveryInfo+"</div>";
				}
				if(iconAttr.cash!==undefined) {
					//							<!-- 현금 -->
					html[hIdx++] = "			<span class=\"tag--cash lp__sprite\">현금</span>";
				}
				if(iconAttr.ovs!==undefined) {
					//							<!-- 직구 -->
					html[hIdx++] = "			<span class=\"tag--global lp__sprite\">직구</span>";
				}
				if(strCouponContents.length>0) {
					// 모델, 컨텐츠 
					var obj = {};
					obj["P:"+strPlNo] = strCouponContents;
					Object.assign(couponContentsObj, obj);
					
					//							<!-- 쿠폰 -->
					html[hIdx++] = "			<div class=\"tag--coupon\">";
					html[hIdx++] = "				<i class=\"ico-tag--coupon lp__sprite\">쿠폰</i>";
					html[hIdx++] = "				<div class=\"lay-coupon lay-comm lay-comm--sm\" style=\"display:none;\">";
					html[hIdx++] = "					<div class=\"lay-comm--head\">";
					html[hIdx++] = "						<strong class=\"lay-comm__tit\">";
					html[hIdx++] =	"							본 가격은 <em>추가할인 쿠폰</em> 적용가 입니다.</strong>";
					html[hIdx++] = "						</strong>";
					html[hIdx++] = "					</div>";
					html[hIdx++] = "					<div class=\"lay-comm--body\">";
					html[hIdx++] = "						<div class=\"lay-comm__inner\">";
				//	html[hIdx++] = strCouponContents;
					html[hIdx++] = "							<div class=\"lay-coupon__price\">";
					html[hIdx++] = "								쿠폰적용가 : <em>"+strMinPrice+"</em>원";
					html[hIdx++] = "							</div>";
					html[hIdx++] = "						</div>";
					html[hIdx++] = "					</div>";
					html[hIdx++] = "				</div>";
					html[hIdx++] = "			</div>";
				}
				if(strMinPriceMobileTag=="Y") {
					html[hIdx++] = "			<span class=\"tag--mobile lp__sprite\" onclick=\"javascript:mobileMinPriceLayer(this);\">모바일최저가</span>";
				}
				//								<!-- 가격 -->
				html[hIdx++] = "				<a href=\""+plMoveLinkUrl+"\" class=\"tx--price\" target=\"_blank\">";
				html[hIdx++] = "					<em>"+strMinPrice+"</em>원";
				html[hIdx++] = "				</a>";
				//							<!-- // -->
				html[hIdx++] = "			</div>";
				//						<!-- // -->
				html[hIdx++] = "		</div>";
				//						<!-- 옵션, 쇼핑몰 더보기 / 쇼핑몰 바로가기 -->
				html[hIdx++] = "		<div class=\"item__foot\">";
				//							<!-- 쇼핑몰 -->
				html[hIdx++] = "			<div class=\"tx--mall\"  data-role=\"logo\">";
				//								<!-- 텍스트 + N페이 -->
				if(strShopName!="" && iconAttr.naverpay!==undefined ) {
					html[hIdx++] = "			<a href=\""+plMoveLinkUrl+"\" class=\"mall--npay\" target=\"_blank\">"+strShopName+"</a>";
				//								<!-- 로고형 -->
				} else if(strShopCode!="0" && strShopName!="") {
					html[hIdx++] = "			<a href=\""+plMoveLinkUrl+"\" class=\"mall--logo\" target=\"_blank\">";
					html[hIdx++] = "				<img class=\"lazy\" data-original=\"//storage.enuri.info/logo/logo20/logo_20_"+strShopCode+".png\" src=\"//storage.enuri.info/logo/logo20/logo_20_"+strShopCode+".png\" alt=\""+strShopName+"\" onerror=\"javascript:logoImgNotFound(this);\">";
					html[hIdx++] = "			</a>";
				}
				html[hIdx++] = "			</div>";
				html[hIdx++] = "		</div>";
				html[hIdx++] = "	</div>";
				//					<!-- // -->
			}
		}
		html[hIdx++] = "		</li>";
		// 						<!-- // -->
		
		// 오픈쇼핑, 슈퍼탑라이트 삽입을 위한 태그 삽입
		// 7위 상품 뒤 오픈쇼핑 > 슈퍼탑라이트 순
		if( viewType==1 && rank==8 && (param_pageNum==1 && param_tabType==0 && attrSelCnt==0) ) {
			html[hIdx++] = "<li data-type=\"adline\" style=\"display:none;\"></li>";
		}

	});
	
	$(".goods-bundle").html(html.join(""));
	
 	//검색어 하일라이트
	chgHighlighttxt();

	//트렌드를 한 번에
	getRightWingKnowList2(dataObj.data.strCaCode);
	
	// 오픈쇼핑, 슈퍼탑라이트 미 삽입 예외 처리 ( 상품이 7개가 되지 않는 경우 )
	if( viewType==1 && $(".goods-bundle").find("li[data-type=adline]").length == 0 && $("li.prodItem").length>0 && dataObj.data.list.length<7 && param_sort==1) {
		if(param_pageNum==1 && param_tabType==0 && attrSelCnt==0) {
			$("li.prodItem").last().after("<li data-type=\"adline\" style=\"display:none;\"></li>");
		}
	}
	
	// 슈퍼탑 노출 조건이 아니면 슈퍼탑 삭제
	if(param_pageNum!=1 || param_tabType!=0 && ( (param_inKeyword.length>0 && attrSelCnt>1) || attrSelCnt>0 )) {
		$(".prodItem.ad").remove();
	}
	
	loading("hide");
	
	// 이미지 보여주기
	$("img.lazy").lazyload({
		placeholder : noImageStr
	});
	
	paging(dataObj.total); // 페이징
	
	// 모델 이미지 위 태그 색상 노출
	setListImageInIconSet();
	
	// 후처리 list_func.js 최초 로드시에만 호출
	if(firstLoadFlag) {
		firstLoadFlag = false;
		loadListAddData();
		
		// SRP 부분검색어
		if(dataObj.data.searchedKeywordAry && dataObj.data.searchedKeywordAry.length > 0){
			// 키워드 , 선택 배열, 전체 배열
			drawPartialSearch(dataObj.data.searchedKeyword, dataObj.data.searchedKeywordAry, dataObj.data.searchedKeywordOrgAry);
		}
	}
	
	// 뉴스, 이벤트, 사용기, 리뷰 등등.... 
	setModelEvent();
	setReview();
	
	if( (modelNoSet && modelNoSet.size>0) || (plNoSet && plNoSet.size>0) ) {
		// SRP 해당 카테고리로 ( 표준PC가 있을경우에는 표준PC앞으로 )
		if(listType=="search") {
			getModelCateListLinkTitle();
		}
	}
	
	// 슈퍼탑
	if(param_pageNum==1 && param_sort==1 && param_tabType==0 && dataObj.data.supertopADNos.length>0 ) {
		loadSupertop(dataObj.data.supertopADNos, $(".ad"), $(".highrank"));
	}
	
	// 슈퍼탑을 그리기 위한 정보를 삭제 supertop.js 에서 그림
	if($(".ad").length>0) {
		$(".ad").remove();
	}
	
	// 갤러리뷰 에서 슈퍼탑이 없거나 2페이지 부터 갤러리뷰 상품 메우기 로직
	if(viewType==2 && (param_pageNum>1 || dataObj.data.supertopADNos.length==0) && (dataObj.data.nonAdItemSize==param_pageGap)) {
	
		var prodLength = $("li.prodItem").length;
		var useCount = 0;
		if(prodLength>4) {
			useCount = 4 - ($("li.prodItem").length%4);
		}
		if(useCount==4) {
			useCount = 0;
		}
		
		var highRankData = $(".highrank");
		// 갤러리뷰의 한 줄의 상품카드가 4개 이고, 부족한 갯수만큼 채운다.
		for(var i=0;i<useCount;i++) {
			var addHtml = highRankData[i].outerHTML;
			if(addHtml.length>0) {
				$(".goods-list .goods-bundle").append(highRankData[i].outerHTML);
			}
		}
		
		// 추가된 돔에 대하여 순위제거 및 lazyload 적용
		var addIndexCount = $("li.prodItem.highrank").length - useCount;
		$("li.prodItem.highrank").each(function(index,item) {
			if(index>=addIndexCount) {
				$(this).addClass("fill");
				$(this).find(".item__model").removeClass("has--tag");
				$(this).find(".tag--rank").remove();
			}
		});
		$("li.prodItem.highrank").removeClass("highrank");
		
		// 이미지 보여주기
		$("li.fill img.lazy").lazyload({
			placeholder : noImageStr
		});
		
		// 갤러리뷰 오픈쇼핑 삽입 ( 슈퍼탑 없는 ver )
		if(param_pageNum==1 && attrSelCnt==0 && param_sort==1) { 
			// 오픈쇼핑
			if(listType=="list") {
				loadOpenShopping(param_cate, blADShopping);
			} else if(listType=="search" && (firstGoodsCate!==undefined && firstGoodsCate.length>0)) {
				loadOpenShopping(firstGoodsCate, blADShopping);
			}
		}
	}
	
	// 오픈쇼핑
	if(param_pageNum==1 && attrSelCnt==0 && param_sort==1 && viewType==1) {
		if(listType=="list") {
			loadOpenShopping(param_cate, blADShopping);
		} else if(listType=="search" && (firstGoodsCate!==undefined && firstGoodsCate.length>0)) {
			loadOpenShopping(firstGoodsCate, blADShopping);
		}
	}
	
	// 파워링크
	if(listType=="list") {
		getPowerLink("LP",param_cate,param_inKeyword);
	} else {
		getPowerLink("SRP",param_cate,param_keyword);
	}
	
	// 파워쇼핑
	if(listType=="list") {
		getPowerShopping("LP", param_cate, null);
	} else if(listType=="search" && (firstGoodsCate!==undefined && firstGoodsCate.length>0)) {
		getPowerShopping("SRP", firstGoodsCate, param_keyword);
	}
	
	// 쿠폰 내용
	Object.keys(couponContentsObj).forEach(function(data) {
		if(data.indexOf(":")>-1) {
			var splitData = data.split(":");
			if(splitData[0]=="G") {
				$(".prodItem[data-id=model_"+splitData[1]+"] .tag--coupon .lay-comm--body .lay-coupon__price").before(couponContentsObj[data].replace(/\r\n/gi, "<br>"));
			} else if(splitData[0]=="P") {
				$(".prodItem[data-id=pl_"+splitData[1]+"] .tag--coupon .lay-comm--body .lay-coupon__price").before(couponContentsObj[data].replace(/\r\n/gi, "<br>"));
			}
		}
	});
	
	// LP 중단 배너 ( T5 )
	if(listType=="list") {
		loadLPCenterBanner(param_cate.substring(0,4));
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
	
	if($(".goods-list .paging").length==0) {
		$(".goods-list").append("<div class=\"paging\"></div>");
	}
	
	var pages = $(".goods-list div.paging");
	
	var totalPage = Math.ceil(itemTotalCnt / param_pageGap);
	var pageCount = 10;
	var pageGroup = Math.ceil(param_pageNum / pageCount);
	var last = pageGroup * pageCount;
	if( last > totalPage ) {
		last = totalPage;
	}
	var first = last - (pageCount - 1);
	var prev = first - 1;
	var next = last + 1;
	
	if(totalPage < 1) {
		first = last;
	}
	if(first<1) {
		first = 1;
	}
	
	var html = [];
	var hIdx = 0;
	
	html[hIdx++] ="<div class=\"paging__inner\">";
	for(var i=first; i<=last; i++) {
		// 현재 페이지 .is--on
		if(i==param_pageNum) {
			html[hIdx++] ="<a href=\"javascript:void(0);\" class=\"paging__item is--on\" data-page=\""+i+"\">"+i+"</a>";
		} else {
			html[hIdx++] ="<a href=\"javascript:void(0);\" class=\"paging__item\" data-page=\""+i+"\">"+i+"</a>";
		}
	}
	
	// <!-- 이전/다음 페이지 없을때 .is--disabled 붙여주세요 -->
	if(pageGroup>1) {
		html[hIdx++] ="<button class=\"paging__btn--prev\" data-page=\""+(first-1)+"\"><i class=\"ico-paging-prev comm__sprite\">이전</i></button>";
	} else {
		html[hIdx++] ="<button class=\"paging__btn--prev is--disabled\"><i class=\"ico-paging-prev comm__sprite\">이전</i></button>";
	}
	
	if(pageGroup==Math.ceil(totalPage/pageCount)) {
		html[hIdx++] ="<button class=\"paging__btn--next is--disabled\"><i class=\"ico-paging-next comm__sprite\">다음</i></button>";
	} else {
		html[hIdx++] ="<button class=\"paging__btn--next\" data-page=\""+(last+1)+"\"><i class=\"ico-paging-next comm__sprite\">다음</i></button>";
	}
	pages.html(html.join(""));
	
	// 법적 고지 메세지
	$(".goods-list").append("<div class=\"gooods-list__tx--noti\">※ 각 제조사명(판매사명) 및 로고, 브랜드명 및 로고는 각 제조사(판매사)의 상표 또는 등록상표 입니다. <a href=\"/etc/disclaimer.jsp\" target=\"_blank\">&lt;법적고지&gt;</a></div>");
}

// 검색결과 없을 때
function drawNoData() {

	var appendObj = $(".goods-list");
	
	$("ul.list-filter__tab li[tabType="+param_tabType+"]").find(".list-tab--count").text("0");
	
	var html = [];
	var hIdx = 0;
	
	if(listType=="search" && firstLoadFlag) {
		$(".list-head").hide();
	}
	
	// SRP 일반검색 시 ( 결과내 검색어 있을 경우 제외 )
	if(listType=="search" && param_keyword.length>0 && param_inKeyword.length==0) {
		html[hIdx++] ="<div class=\"no-result--list\" id=\"noSearchListDiv\">";
		html[hIdx++] ="	<div class=\"no-result__inner\">";
		html[hIdx++] ="		<div class=\"no-result__tit\">";
		html[hIdx++] ="			<em>"+param_keyword+"</em> 검색결과가 없습니다.";
		html[hIdx++] ="		</div>";
		html[hIdx++] ="		<div class=\"no-result__txt\">";
		html[hIdx++] ="			<div class=\"no-result__txt--sub\">정확한 검색어인지 확인하시고 다시 검색해 주세요.</div>";
		html[hIdx++] ="			<ul class=\"no-result__txt--case\">";
		html[hIdx++] ="				<li>· 검색어의 철자가 맞는지 확인해 주세요.</li>";
		html[hIdx++] ="				<li>· 붙은 단어일 경우 띄어쓰기를 해보세요.</li>";
		html[hIdx++] ="				<li>· 단어수를 줄이거나, 일반적인 검색어로 다시 검색해 보세요.</li>";
		html[hIdx++] ="			</ul>";
		html[hIdx++] ="		</div>";
		html[hIdx++] ="	</div>";
		html[hIdx++] ="	<div class=\"no-result__foot\">";
		html[hIdx++] ="찾고자 하는 상품이 없으신가요? <a href=\"/faq/customer_seller.jsp?faq_type=4\" class=\"btn--request\" target=\"_blank\">신상품 등록요청</a>";
		html[hIdx++] ="	</div>";
		html[hIdx++] ="</div>";
	} else {
		html[hIdx++] ="<div class=\"no-result--list\" id=\"noSearchListDiv\">";
		html[hIdx++] ="	<div class=\"no-result__inner\">";
		html[hIdx++] ="		<div class=\"no-result__tit\">";
		html[hIdx++] ="			<i class=\"ico-caution\">!</i><em>선택 조건</em>에 해당하는 검색결과가 없습니다.";
		html[hIdx++] ="		</div>";
		html[hIdx++] ="	</div>";
		if(listType=="search") {
			html[hIdx++] ="	<div class=\"no-result__foot\">";
			html[hIdx++] ="찾고자 하는 상품이 없으신가요? <a href=\"/faq/customer_seller.jsp?faq_type=4\" class=\"btn--request\" target=\"_blank\">신상품 등록요청</a>";
			html[hIdx++] ="	</div>";
		}
		html[hIdx++] ="</div>";
	}
	
	// 최근본 상품 + 유사항품 가져오기
	if(listType=="search" && firstLoadFlag) {
		loadSuggestGoods();
	}
	appendObj.html(html.join(""));
	
	// 부분검색어 결과 없을 시
	if(listType=="search" && param_isResearch=="N") {
		$(".sr-keyword").text(param_keyword);
		$(".sr-keyword--info-sub").hide();
		$(".category-srp--recom-cate").hide();
		$(".adv-search").hide();
	}
	
	loading("hide"); // 로딩바 없애기
}

// 리스트 API 호출 실패시
function failList(errorObj) {
	console.log( "LP/SRP list API Call Fail : " + errorObj.statusText);
	drawNoData();
}

// 속성 정보 호출
function loadAttrs() {
	
	// LP 속성은 _는 AND조건, ,는 OR조건
	// ex) spec=3313,205,_6678,3695,3694,
	var $customSpecArray = new Array();
	var $customSpec = "";
	var $customTmpString = "";
	var $customSpecArrayCount = 0;
	if(param_spec.length>0) {
		$("dl.search-box-row[data-attr-type=spec]").each(function(index, item) {
			$customTmpString = "";
			$(this).find("li.sel").each(function(sub_index, sub_item) {
				if($customTmpString.length>0) { 
					$customTmpString += ",";
				}
				$customTmpString += $(this).attr("data-spec");
			});
			if($customTmpString.length>0) {
				$customSpecArray[$customSpecArrayCount++] = $customTmpString;
			}
		});
	}
	$customSpec = $customSpecArray.join(",_");
	
	// 파라미터
	var listParam = {
		"from" : listType,
		"device" : "pc",
		"category" : param_cate,
		"tab" : param_tabType,
		"isDelivery" : param_isDelivery,
		"isRental" : param_isRental,
		"pageNum" : param_pageNum,
		"pageGap" : param_pageGap,
		"sort" : param_sort,
		"factory" : encodeURIComponent(param_factory),
		"brand" : encodeURIComponent(param_brand),
		"shopcode" : param_shopcode,
		"keyword" : encodeURIComponent(param_keyword),
		"in_keyword" : encodeURIComponent(param_inKeyword),
		"s_price" : param_sPrice,
		"e_price" : param_ePrice,
		"spec" : $customSpec,
		"color" : param_color,
		"gb1" : param_gb1,
		"gb2" : param_gb2,
		"isReSearch" : param_isResearch,
		"isTest" : "N",
		"isMakeshop" : "Y"
	};
	
	// 속성 API 호출
	var attrDataPromise = $.ajax({
		type : "GET",
		url : "/wide/api/listSpec.jsp",
		dataType : "json",
		data : listParam
	});
	
	attrDataPromise.then(drawAttr, failAttr);
}

//속성 정보 그리기
function drawAttr(dataObj) {
	
	// 예외처리
	if(dataObj.success===undefined || !dataObj.success || !dataObj.data.length==0) {
		return;
	}
	
	// 출시예정 상품 있을 경우 "출시예정" 버튼 노출
	if( (dataObj.data.strOpenExpectYN!==undefined && dataObj.data.strOpenExpectYN=="Y") && !blNewListBtnCheck) {
		$(".list-filter__btn.sortFilter").show();
		blNewListBtnIsset = true;
	} else {
		$(".list-filter__btn.sortFilter").hide();
	}
	
	var appendObj = $(".adv-search");
	
	// SRP 에서 카테고리 갯수 표시
	if(listType=="search" && dataObj.data.reqCateCount!==undefined) {
		$("#topAllCateCnt").text(dataObj.data.reqCateCount.format());
	}
	
	// 카테고리
	if(listType=="list") {
		if( dataObj.data.category !==undefined ) {
		
			var caetgoryLNBObj = $(".category-lp");
			var cateListHtml = [];
			var cateListIdx = 0;
			var selSubCateName = "";
			var data_key = "";
			var data_name = "";
		
			cateListHtml[cateListIdx++] = "<h2 class=\"category-lp__name\">";
			cateListHtml[cateListIdx++] = "	<a href=\"/list.jsp?cate="+param_cate.substring(0,4)+"\">"+dataObj.data.category.mCateName+"</a>";
			cateListHtml[cateListIdx++] = "</h2>";
			if(dataObj.data.category.depth_3.length>0) {
				cateListHtml[cateListIdx++] = "<ul class=\"category-lp__list\">";
				for(var i=0;i<dataObj.data.category.depth_3.length;i++) {
					
					if( dataObj.data.category.depth_3[i].data !== undefined ) {
						
						data_key = dataObj.data.category.depth_3[i].data.code;
						data_name = dataObj.data.category.depth_3[i].data.name;
						
						var addClass = "";
						if(param_cate.length>=6 && data_key==param_cate.substring(0,6)) {
							addClass += " is--on";
							selSubCateName = data_name;
						}
						if( dataObj.data.category.depth_3[i].child !== undefined && dataObj.data.category.depth_3[i].child.length>0 ) {
							addClass += " has-child";
						}
						cateListHtml[cateListIdx++] = "<li class=\"category-lp__item "+addClass+"\">";
						cateListHtml[cateListIdx++] = "	<a href=\"/list.jsp?cate="+data_key+"\">"+data_name+"</a>";
						
						// child 미카테 노출
						var child_cate = "";
						var child_name = "";
						if( dataObj.data.category.depth_3[i].child !== undefined && dataObj.data.category.depth_3[i].child.length>0 ) {
							cateListHtml[cateListIdx++] = "<span class=\"bar\">|</span>";
							cateListHtml[cateListIdx++] = "<div class=\"category-lp__down\">";
							cateListHtml[cateListIdx++] = "	<ul>";
							$.each(dataObj.data.category.depth_3[i].child, function(child_key, child_data) {
								child_cate = child_data.code;
								child_name = child_data.name;
								cateListHtml[cateListIdx++] = "	<li><a href=\"/list.jsp?cate="+child_cate+"\" title=\""+child_name+"\">"+child_name+"</a></li>";
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
			
			// 미카테고리
			if( dataObj.data.category.depth_4.length>0 && selSubCateName.length>0 ) {
				var dCateObj = $(".category-lp--fine");
				var dCateHtml = [];
				var dCateIdx = 0;
				var dCateAddClass = "";
				if(dataObj.data.category.depth_4.length>6) {
					dCateAddClass += " type--line2";
				}
				dCateHtml[dCateIdx++] = "<dl class=\"search-box-row"+dCateAddClass+"\">";
				dCateHtml[dCateIdx++] = "	<dt class=\"search-box__head\">";
				dCateHtml[dCateIdx++] = "		<div class=\"search-box__head--title\">";
				dCateHtml[dCateIdx++] = "			<div class=\"search-box__head--inner\">";
				//										<!-- 속성명 / 카운트 -->
				dCateHtml[dCateIdx++] = "				<p class=\"search-box__head--name\">\""+selSubCateName+"\" <span class=\"tx_sub\">하위 카테고리입니다.</span></p>";
				//										<!-- 버튼 : 펼침/닫기 -->
				if(dataObj.data.category.depth_4.length>12) {
					dCateHtml[dCateIdx++] = "			<button type=\"button\" class=\"search-box__btn--unfold\" onclick=\"$(this).closest('.search-box-row').toggleClass('is--unfold');\"></button>";
				}
				dCateHtml[dCateIdx++] = "			</div>";
				dCateHtml[dCateIdx++] = "		</div>";
				//								<!-- // -->
				dCateHtml[dCateIdx++] = "	</dt>";
				dCateHtml[dCateIdx++] = "	<dd class=\"search-box__body\">";
				dCateHtml[dCateIdx++] = "		<div class=\"search-box__inner\">";
				dCateHtml[dCateIdx++] = "			<ul class=\"search-box__list list-form--radio\">";
				
				for(var i=0;i<dataObj.data.category.depth_4.length;i++) {
					var sub_key = dataObj.data.category.depth_4[i].code;
					var sub_name = dataObj.data.category.depth_4[i].name;
					dCateHtml[dCateIdx++] = "		<li data-cate=\""+sub_key+"\">";
					if(param_cate==sub_key) {
						dCateHtml[dCateIdx++] = "		<input type=\"radio\" id=\"radioLPCATE_"+sub_key+"\" name=\"radioLPCATE\" class=\"input--radio-item\" checked=\"checked\"><label for=\"radioLPCATE_"+sub_key+"\">"+sub_name+"</label>";
					} else {
						dCateHtml[dCateIdx++] = "		<input type=\"radio\" id=\"radioLPCATE_"+sub_key+"\" name=\"radioLPCATE\" class=\"input--radio-item\"><label for=\"radioLPCATE_"+sub_key+"\">"+sub_name+"</label>";
					}
					dCateHtml[dCateIdx++] = "		</li>";
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
	if(listType=="search") {
		
		if( param_cate.length>0 && dataObj.data.reqCateSelList!==undefined && Object.keys(dataObj.data.reqCateSelList).length>0 ) {
			
			var reqCateListObj = $(".category-srp--list-cate");
			var reqCateListHtml = [];
			var reqCateListIdx = 0;
			
			reqCateListHtml[reqCateListIdx++] = "	<div class=\"category-srp__head\">";
			reqCateListHtml[reqCateListIdx++] = "		<ul class=\"category-srp__location\">";
			reqCateListHtml[reqCateListIdx++] = "			<li data-type=\"all\"><a href=\"/search.jsp?keyword="+param_keyword+"&from=list\">전체</a></li>";
			if(dataObj.data.reqCateSelList.cateCode1!==undefined && dataObj.data.reqCateSelList.cateCode1.length>0 && dataObj.data.reqCateSelList.cateName1!==undefined && dataObj.data.reqCateSelList.cateName1.length>0) {
				if(dataObj.data.reqCateSelList.cateCode2===undefined || dataObj.data.reqCateSelList.cateName2===undefined) {
					reqCateListHtml[reqCateListIdx++] = "		<li data-type=\"depth1\"><span class=\"tx--cate\">"+dataObj.data.reqCateSelList.cateName1+"</span> <span class=\"tx--count\">(상품수 : <em>"+dataObj.total.format()+"</em>)</span></li>";
				} else {
					//reqCateListHtml[reqCateListIdx++] = "		<li data-type=\"depth1\"><a href=\"/search.jsp?keyword="+param_keyword+"&cate="+dataObj.data.reqCateSelList.cateCode1+"&from=list\">"+dataObj.data.reqCateSelList.cateName1+"</a></li>";
					reqCateListHtml[reqCateListIdx++] = "		<li data-type=\"depth1\"><a>"+dataObj.data.reqCateSelList.cateName1+"</a></li>";
				} 
			}
			if(dataObj.data.reqCateSelList.cateCode2!==undefined && dataObj.data.reqCateSelList.cateCode2.length>0 && dataObj.data.reqCateSelList.cateName2!==undefined && dataObj.data.reqCateSelList.cateName2.length>0) {
				if(dataObj.data.reqCateSelList.cateCode3===undefined || dataObj.data.reqCateSelList.cateName3===undefined) {
					reqCateListHtml[reqCateListIdx++] = "		<li data-type=\"depth2\"><span class=\"tx--cate\">"+dataObj.data.reqCateSelList.cateName2+"</span> <span class=\"tx--count\">(상품수 : <em>"+dataObj.total.format()+"</em>)</span></li>";
				} else {
					reqCateListHtml[reqCateListIdx++] = "		<li data-type=\"depth2\"><a href=\"/search.jsp?keyword="+param_keyword+"&cate="+dataObj.data.reqCateSelList.cateCode2+"&from=list\">"+dataObj.data.reqCateSelList.cateName2+"</a></li>";
				} 
			}
			if(dataObj.data.reqCateSelList.cateCode3!==undefined && dataObj.data.reqCateSelList.cateCode3.length>0 && dataObj.data.reqCateSelList.cateName3!==undefined && dataObj.data.reqCateSelList.cateName3.length>0) {
				reqCateListHtml[reqCateListIdx++] = "		<li data-type=\"depth3\"><span class=\"tx--cate\">"+dataObj.data.reqCateSelList.cateName3+"</span> <span class=\"tx--count\">(상품수 : <em>"+dataObj.total.format()+"</em>)</span></li>";
			}
			
			reqCateListHtml[reqCateListIdx++] = "		</ul>";
			reqCateListHtml[reqCateListIdx++] = "	</div>";
			if(dataObj.data.reqCateSelList.sCateList!==undefined && dataObj.data.reqCateSelList.sCateList.length>0) {
				reqCateListHtml[reqCateListIdx++] = "	<ul class=\"category-srp__list\">";
				$(dataObj.data.reqCateSelList.sCateList).each(function(index, item) {
					reqCateListHtml[reqCateListIdx++] = "	<li>";
					reqCateListHtml[reqCateListIdx++] = "		<a href=\"/search.jsp?keyword="+param_keyword+"&cate="+item.cateCode+"&from=list\">";
					if(item.cateCode==param_cate) {
						reqCateListHtml[reqCateListIdx++] = "		<span class=\"tx--cate is--on\">"+item.cateName+"</span>";
					} else {
						reqCateListHtml[reqCateListIdx++] = "		<span class=\"tx--cate\">"+item.cateName+"</span>";
					}
					reqCateListHtml[reqCateListIdx++] = "			<span class=\"tx--count\">("+item.cateCnt.format()+")</span>";
					reqCateListHtml[reqCateListIdx++] = "		</a>";
					reqCateListHtml[reqCateListIdx++] = "	</li>";
				});
				reqCateListHtml[reqCateListIdx++] = "	</ul>";
			}
			reqCateListObj.html(reqCateListHtml.join(""));
			reqCateListObj.show();
			
		} else if( param_cate.length==0 && dataObj.data.reqCateBest!==undefined && dataObj.data.reqCateBest.length>0) {
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
			if(dataObj.data.reqCateBest.length==5) {
				//reqCateHtml[reqCateIdx++] = "		<button type=\"button\" class=\"search-box__btn--unfold\" onclick=\"$(this).closest('.search-box-row').toggleClass('is--unfold');\"></button>";
				reqCateHtml[reqCateIdx++] = "<div class=\"search-box__util\"><button type=\"button\" class=\"search-box__btn--unfold\" onclick=\"$(this).closest('.search-box-row').toggleClass('is--unfold');\"></button> </div>";
			}
			//										<!-- // -->
			reqCateHtml[reqCateIdx++] = "		</dt>";
			reqCateHtml[reqCateIdx++] = "		<dd class=\"search-box__body\">";
			reqCateHtml[reqCateIdx++] = "			<div class=\"search-box__inner\">";
			reqCateHtml[reqCateIdx++] = "				<ul class=\"search-box__list\">";
			$(dataObj.data.reqCateBest).each(function(index, item) {
				reqCateHtml[reqCateIdx++] = "				<li><a href=\"/search.jsp?keyword="+param_keyword+"&cate="+item.cate+"&from=list\" class=\"category-srp__item\"><span class=\"tx--name\">"+item.name+"</span><span class=\"tx--count\">"+item.cnt.format()+"</span></a></li>";
			});
			reqCateHtml[reqCateIdx++] = "				</ul>";
			reqCateHtml[reqCateIdx++] = "			</div>";
			reqCateHtml[reqCateIdx++] = "		</dd>";
			reqCateHtml[reqCateIdx++] = "	</dl>";
			
			//								<!--추천 카테고리 확장 영역 -->
			if(dataObj.data.reqCateList!==undefined && dataObj.data.reqCateList.length>0) {
				reqCateHtml[reqCateIdx++] = "<div class=\"search-box--expend\">";
				$(dataObj.data.reqCateList).each(function(index, item) {
					reqCateHtml[reqCateIdx++] = "<dl class=\"search-box-row\">";
					reqCateHtml[reqCateIdx++] = "	<dt class=\"search-box__head\">";
					reqCateHtml[reqCateIdx++] = "		<div class=\"search-box__head--title\">";
					reqCateHtml[reqCateIdx++] = "			<div class=\"search-box__head--inner\">";
					reqCateHtml[reqCateIdx++] = "				<p class=\"search-box__head--name\">"+item.name+"</p>";
					reqCateHtml[reqCateIdx++] = "			</div>";
					reqCateHtml[reqCateIdx++] = "		</div>";
					if(item.cateList.length>5) {
						reqCateHtml[reqCateIdx++] = "		<div class=\"search-box__util\">";
    					reqCateHtml[reqCateIdx++] = "			<span class=\"search-box__util--count\"><em>"+(item.cateList.length-5)+"</em>개</span>";
    					reqCateHtml[reqCateIdx++] = "			<button type=\"button\" class=\"search-box__btn--unfold\" onclick=\"$(this).closest('.search-box-row').toggleClass('is--unfold');\"></button>";
						reqCateHtml[reqCateIdx++] = "		</div>";
					}
					reqCateHtml[reqCateIdx++] = "	</dt>";
					
					reqCateHtml[reqCateIdx++] = "	<dd class=\"search-box__body\">";
					reqCateHtml[reqCateIdx++] = "		<div class=\"search-box__inner\">";
					reqCateHtml[reqCateIdx++] = "			<ul class=\"search-box__list--recomcate\">";
					
					$(item.cateList).each(function(sub_index, sub_item) {
						reqCateHtml[reqCateIdx++] = "			<li data-cate=\""+sub_item.cate+"\">";
						reqCateHtml[reqCateIdx++] = "				<a href=\"/search.jsp?keyword="+param_keyword+"&cate="+sub_item.cate+"&from=list\" class=\"category-srp__item--expend\">";
						reqCateHtml[reqCateIdx++] = "					<span class=\"tx--name\">"+sub_item.name+"</span>";
						reqCateHtml[reqCateIdx++] = "					<span class=\"tx--count\">"+sub_item.cnt.format()+"</span>";
						reqCateHtml[reqCateIdx++] = "				</a>";
						reqCateHtml[reqCateIdx++] = "				<span class=\"ico-expend-arr lp__sprite\" data-cate=\""+sub_item.cate+"\"></span>";
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
	
	// 제조사
	var factoryViewFlag = false;
	if(listType=="list" && (lpSetupInfo.tab_factory_flag=="" || lpSetupInfo.tab_factory_flag=="1")) {
		factoryViewFlag = true;
	} else if(listType=="search") {
		factoryViewFlag = true;
	}
	
	var factoryLength = dataObj.data.factory.length;
	
	if(factoryViewFlag && dataObj.data.factory!==undefined ) {
		factoryAttrList = dataObj.data.factory;
		var factoryViewItem = 6;
		var vMinusCnt = 6;

		if(listType=="list" && lpSetupInfo!==undefined && lpSetupInfo.dtl_view_itm=="factory") {
			
			if(factoryLength > 12 ){
				html[hIdx++] = "<dl class=\"search-box-row is--unfold\" data-attr-type=\"factory\">";
			}else{
				html[hIdx++] = "<dl class=\"search-box-row type--line2\" data-attr-type=\"factory\">";
				factoryViewItem = 12;
				vMinusCnt = 12;	
			}
			
		} else {
			html[hIdx++] = "<dl class=\"search-box-row\" data-attr-type=\"factory\">";
		}
		
		html[hIdx++] = "		<dt class=\"search-box__head\">";
		html[hIdx++] = "			<div class=\"search-box__head--title\">";
		html[hIdx++] = "				<div class=\"search-box__head--inner\">";
		//									<!-- 속성명 / 카운트 -->
		html[hIdx++] = "					<p class=\"search-box__head--name\">제조사</p>";
		html[hIdx++] = "				</div>";
		html[hIdx++] = "			</div>";
//		<!-- Sorting -->
		html[hIdx++] = "			<div class=\"search-box__sort\" data-sort=\"factory\">";
		html[hIdx++] = "				<button class=\"btn-sort--pop is--selected\">인기순</button>";
		html[hIdx++] = "				<button class=\"btn-sort--name\">가나다순</button>";
		html[hIdx++] = "			</div>";
		if(dataObj.data.factory.length>factoryViewItem) {
			html[hIdx++] = "			<div class=\"search-box__util\">";
    		html[hIdx++] = "				<span class=\"search-box__util--count\"><em>"+(dataObj.data.factory.length-vMinusCnt)+"</em>개</span>";
    		html[hIdx++] = "				<button type=\"button\" class=\"search-box__btn--unfold\" onclick=\"$(this).closest('.search-box-row').toggleClass('is--unfold');\"></button>";
			html[hIdx++] = "			</div>";
		}
		html[hIdx++] = "		</dt>";
		
		html[hIdx++] = "		<dd class=\"search-box__body\">";
		
//		<!-- 가나다/알파벳순 정렬 -->
		html[hIdx++] = "			<div class=\"search-box__sort--seq\" style=\"display:none;\"></div>";
		
		html[hIdx++] = "			<div class=\"search-box__inner\">";
		
		$.each(dataObj.data.factory, function(index, item){
			//							<!-- 반복 : 한줄 최대 6개 / 두줄케이스 12개 -->
			if(index==0) {
				html[hIdx++] = "		<ul class=\"search-box__list\">";
			}
			html[hIdx++] = "				<li class=\"attrs\" data-attr=\"factory_"+regSpecExp(item.code)+"\"><input type=\"checkbox\" id=\"chFactory_"+index+"\" class=\"input--checkbox-item\"><label for=\"chFactory_"+index+"\" title=\""+item.name+"\">"+item.name+"</label></li>";
			if(dataObj.data.factory.length==index+1) {
				html[hIdx++] = "		</ul>";
			}
		});
		html[hIdx++] = "			</div>";
		html[hIdx++] = "		</dd>";
		html[hIdx++] = "	</dl>";
	}
	// 브랜드
	var brandViewFlag = false;
	if(listType=="list" && (lpSetupInfo.tab_brand_flag=="" || lpSetupInfo.tab_brand_flag=="1")) {
		brandViewFlag = true;
	} else if(listType=="search") {
		brandViewFlag = true;
	}
	if(brandViewFlag && dataObj.data.brand!==undefined && dataObj.data.brand.length>0) {
	//	brandAttrList = dataObj.data.brand;
		var brandViewItem = 6;
		var brandAddClass = "";
		var vMinusCnt = 6;
		if(listType=="list" && lpSetupInfo!==undefined && lpSetupInfo.dtl_view_itm=="brand") {
			vMinusCnt = 12;
			brandViewItem = 12;
			if(dataObj.data.brand.length > 12)	brandAddClass += "is--unfold";	
			else				brandAddClass += " type--line2";	
		}
		// 명품
		if(luxuryCateFlag=="Y") {
			brandAddClass += " type--except1";
		}
		// SRP 추천브랜드
		if(listType=="search" && dataObj.data.reqBrandList!==undefined && dataObj.data.reqBrandList.length>0) {
			brandAddClass += " type--recomm-brand";
		}
		
		html[hIdx++] = "	<dl class=\"search-box-row "+brandAddClass+"\" data-attr-type=\"brand\">";
		html[hIdx++] = "		<dt class=\"search-box__head\">";
		html[hIdx++] = "			<div class=\"search-box__head--title\">";
		html[hIdx++] = "				<div class=\"search-box__head--inner\">";
		//									<!-- 속성명 / 카운트 -->
		if(luxuryCateFlag=="Y" || (listType=="search" && dataObj.data.reqBrandList!==undefined && dataObj.data.reqBrandList.length>0)) {
			html[hIdx++] = "				<p class=\"search-box__head--name\">추천브랜드</p>";
		} else {
			html[hIdx++] = "				<p class=\"search-box__head--name\">브랜드</p>";
		}
		html[hIdx++] = "				</div>";
		html[hIdx++] = "			</div>";
		//							<!-- Sorting -->
		html[hIdx++] = "			<div class=\"search-box__sort\" data-sort=\"brand\">";
		html[hIdx++] = "				<button class=\"btn-sort--pop is--selected\">인기순</button>";
		html[hIdx++] = "				<button class=\"btn-sort--name\">가나다순</button>";
		html[hIdx++] = "			</div>";

		if(dataObj.data.brand.length>brandViewItem) {
			html[hIdx++] = "			<div class=\"search-box__util\">";
    		html[hIdx++] = "				<span class=\"search-box__util--count\"><em>"+(dataObj.data.brand.length - vMinusCnt)+"</em>개</span>";
    		html[hIdx++] = "				<button type=\"button\" class=\"search-box__btn--unfold\" onclick=\"$(this).closest('.search-box-row').toggleClass('is--unfold');\"></button>";
			html[hIdx++] = "			</div>";
		}
		
		html[hIdx++] = "		</dt>";
		
		html[hIdx++] = "		<dd class=\"search-box__body\">";
	
		// #44493 [PC] LP > 명품패션(1459)/명품뷰티(0860) 예외 20210127
		if(luxuryCateFlag=="Y") {
			
			html[hIdx++] = "		<div class=\"search-box__except1\">";
			html[hIdx++] = "			<ul class=\"list__luxury\">";
			
			// 0860 명품뷰티
			if(param_cate.substring(0,4)=="0860") {
				blLuxuryMap.set("입생로랑", "입생로랑");
				blLuxuryMap.set("에스티로더", "에스티로더");
				blLuxuryMap.set("SK-II", "SK-II");
				blLuxuryMap.set("크리스찬디올", "크리스찬디올");
				blLuxuryMap.set("랑콤", "랑콤");
				blLuxuryMap.set("샤넬", "샤넬");
				blLuxuryMap.set("MAC", "MAC");
				blLuxuryMap.set("록시땅", "록시땅");
				blLuxuryMap.set("비오템", "비오템");
				blLuxuryMap.set("조르지오아르마니", "조르지오아르마니");
			
				html[hIdx++] = "			<li class=\"attrs\" data-attr=\"brand_입생로랑\"><a href=\"javascript:void(0);\" class=\"luxury\"><img src=\"//img.enuri.info/images/home/luxury/logo36_yslr.png\" alt=\"입생로랑\"></a></li>";
				html[hIdx++] = "			<li class=\"attrs\" data-attr=\"brand_에스티로더\"><a href=\"javascript:void(0);\" class=\"luxury\"><img src=\"//img.enuri.info/images/home/luxury/logo36_estee.png\" alt=\"에스티로더\"></a></li>";
				html[hIdx++] = "			<li class=\"attrs\" data-attr=\"brand_SK-II\"><a href=\"javascript:void(0);\" class=\"luxury\"><img src=\"//img.enuri.info/images/home/luxury/logo36_sk2.png\" alt=\"SK-II\"></a></li>";
				html[hIdx++] = "			<li class=\"attrs\" data-attr=\"brand_크리스찬디올\"><a href=\"javascript:void(0);\" class=\"luxury\"><img src=\"//img.enuri.info/images/home/luxury/logo36_dior.png\" alt=\"크리스찬디올\"></a></li>";
				html[hIdx++] = "			<li class=\"attrs\" data-attr=\"brand_랑콤\"><a href=\"javascript:void(0);\" class=\"luxury\"><img src=\"//img.enuri.info/images/home/luxury/logo36_lancome.png\" alt=\"랑콤\"></a></li>";
				html[hIdx++] = "			<li class=\"attrs\" data-attr=\"brand_샤넬\"><a href=\"javascript:void(0);\" class=\"luxury\"><img src=\"//img.enuri.info/images/home/luxury/logo36_chanel.png\" alt=\"샤넬\"></a></li>";
				html[hIdx++] = "			<li class=\"attrs\" data-attr=\"brand_MAC\"><a href=\"javascript:void(0);\" class=\"luxury\"><img src=\"//img.enuri.info/images/home/luxury/logo36_mac.png\" alt=\"MAC\"></a></li>";
				html[hIdx++] = "			<li class=\"attrs\" data-attr=\"brand_록시땅\"><a href=\"javascript:void(0);\" class=\"luxury\"><img src=\"//img.enuri.info/images/home/luxury/logo36_loccitane.png\" alt=\"록시땅\"></a></li>";
				html[hIdx++] = "			<li class=\"attrs\" data-attr=\"brand_비오템\"><a href=\"javascript:void(0);\" class=\"luxury\"><img src=\"//img.enuri.info/images/home/luxury/logo36_biotherm.png\" alt=\"비오템\"></a></li>";
				html[hIdx++] = "			<li class=\"attrs\" data-attr=\"brand_조르지오아르마니\"><a href=\"javascript:void(0);\" class=\"luxury\"><img src=\"//img.enuri.info/images/home/luxury/logo36_armani.png\" alt=\"조르지오아르마니\"></a></li>";
				
			// 1459 명품패션
			} else if(param_cate.substring(0,4) == "1459") {
				blLuxuryMap.set("구찌", "구찌");
				blLuxuryMap.set("프라다", "프라다");
				blLuxuryMap.set("버버리", "버버리");
				blLuxuryMap.set("샤넬", "샤넬");
				blLuxuryMap.set("루이비통", "루이비통");
				blLuxuryMap.set("생로랑", "생로랑");
				blLuxuryMap.set("페라가모", "페라가모");
				blLuxuryMap.set("메종마르지엘라", "메종마르지엘라");
				blLuxuryMap.set("보테가베네타", "보테가베네타");
				blLuxuryMap.set("셀린느", "셀린느");
				
				html[hIdx++] = "			<li class=\"attrs\" data-attr=\"brand_구찌\"><a href=\"javascript:void(0);\" class=\"luxury\"><img src=\"//img.enuri.info/images/home/luxury/logo36_gucci.png\" alt=\"구찌\"></a></li>";
				html[hIdx++] = "			<li class=\"attrs\" data-attr=\"brand_프라다\"><a href=\"javascript:void(0);\" class=\"luxury\"><img src=\"//img.enuri.info/images/home/luxury/logo36_prada.png\" alt=\"프라다\"></a></li>";
				html[hIdx++] = "			<li class=\"attrs\" data-attr=\"brand_버버리\"><a href=\"javascript:void(0);\" class=\"luxury\"><img src=\"//img.enuri.info/images/home/luxury/logo36_burberry.png\" alt=\"버버리\"></a></li>";
				html[hIdx++] = "			<li class=\"attrs\" data-attr=\"brand_샤넬\"><a href=\"javascript:void(0);\" class=\"luxury\"><img src=\"//img.enuri.info/images/home/luxury/logo36_chanel.png\" alt=\"샤넬\"></a></li>";
				html[hIdx++] = "			<li class=\"attrs\" data-attr=\"brand_루이비통\"><a href=\"javascript:void(0);\" class=\"luxury\"><img src=\"//img.enuri.info/images/home/luxury/logo36_louisvuitton.png\" alt=\"루이비통\"></a></li>";
				html[hIdx++] = "			<li class=\"attrs\" data-attr=\"brand_생로랑\"><a href=\"javascript:void(0);\" class=\"luxury\"><img src=\"//img.enuri.info/images/home/luxury/logo36_slr.png\" alt=\"생로랑\"></a></li>";
				html[hIdx++] = "			<li class=\"attrs\" data-attr=\"brand_페라가모\"><a href=\"javascript:void(0);\" class=\"luxury\"><img src=\"//img.enuri.info/images/home/luxury/logo36_feragamo.png\" alt=\"페라가모\"></a></li>";
				html[hIdx++] = "			<li class=\"attrs\" data-attr=\"brand_메종마르지엘라\"><a href=\"javascript:void(0);\" class=\"luxury\"><img src=\"//img.enuri.info/images/home/luxury/logo36_naison.png\" alt=\"메종마르지엘라\"></a></li>";
				html[hIdx++] = "			<li class=\"attrs\" data-attr=\"brand_보테가베네타\"><a href=\"javascript:void(0);\" class=\"luxury\"><img src=\"//img.enuri.info/images/home/luxury/logo36_bottega.png\" alt=\"보테가베네타\"></a></li>";
				html[hIdx++] = "			<li class=\"attrs\" data-attr=\"brand_셀린느\"><a href=\"javascript:void(0);\" class=\"luxury\"><img src=\"//img.enuri.info/images/home/luxury/logo36_celine.png\" alt=\"셀린느\"></a></li>";
			}
			html[hIdx++] = "			</ul>";
			html[hIdx++] = "		</div>";
		}
		
		// SRP 추천브랜드
		if(listType=="search" && dataObj.data.reqBrandList!==undefined && dataObj.data.reqBrandList.length>0) {
			html[hIdx++] = "		<div class=\"search-box__r-brand\">";
			html[hIdx++] = "			<ul class=\"search-box__list\">";
			$.each(dataObj.data.reqBrandList, function(index, item){
				html[hIdx++] = "			<li class=\"attrs\" data-attr=\"brand_"+regSpecExp(item.brand_nm)+"\"><a href=\"javascript:void(0);\" class=\"r-brand\"><img src=\"//storage.enuri.gscdn.com/pic_upload/keyword/"+item.brand_img+"\" alt=\""+item.brand_nm+"\"></a></li>";
				srpReqSet.add(item.brand_nm);
			});
			html[hIdx++] = "			</ul>";
			html[hIdx++] = "		</div>";
		}
		
		// 							<!-- 가나다/알파벳순 정렬 -->
		html[hIdx++] = "			<div class=\"search-box__sort--seq\" style=\"display:none;\"></div>";
		
		html[hIdx++] = "			<div class=\"search-box__inner\">";
		
		var brandDrawCnt = 0;
		
		$.each(dataObj.data.brand, function(index, item){
			if(luxuryCateFlag=="Y" && blLuxuryMap.has(item.code)) {
				return true;
			} else if(listType=="search" && srpReqSet.has(item.code)) {
				return true;
			// 명품, SRP 추천브랜드 를 제외하고 brandAttrList 에 추가
			} else {
				brandAttrList.push(item);
				//							<!-- 반복 : 한줄 최대 6개 / 두줄케이스 12개 -->
				if(brandDrawCnt==0) {
					html[hIdx++] = "		<ul class=\"search-box__list\">";
				}
				html[hIdx++] = "				<li class=\"attrs\" data-attr=\"brand_"+regSpecExp(item.code)+"\"><input type=\"checkbox\" id=\"chBrand_"+index+"\" class=\"input--checkbox-item\"><label for=\"chBrand_"+index+"\" title=\""+item.name+"\">"+item.name+"</label></li>";
				if(dataObj.data.brand.length==brandDrawCnt+1) {
					html[hIdx++] = "		</ul>";
				}
				if(luxuryCateFlag!="Y" || !blLuxuryMap.has(item)) {
					brandDrawCnt++;
				}
			}
		});
		
		html[hIdx++] = "			</div>";
		html[hIdx++] = "		</dd>";
		
		html[hIdx++] = "	</dl>";
	}
	
	//색상
	if(dataObj.data.custom_rgb!==undefined) {
		customRgbAttrList = dataObj.data.custom_rgb;
		html[hIdx++] = "<dl class=\"search-box-row\" data-attr-type=\"spec\">";
	    html[hIdx++] = "    <dt class=\"search-box__head\">";
	    html[hIdx++] = "        <div class=\"search-box__head--title\">";
	    html[hIdx++] = "            <div class=\"search-box__head--inner\">";
	    html[hIdx++] = "                <!-- 속성명 / 카운트 -->";
	    html[hIdx++] = "                <p class=\"search-box__head--name\">색상<!-- <span class=\"search-box__head--count\">40</span> --></p>";
	    html[hIdx++] = "                <!-- 속성명 - 서브 -->";
	    html[hIdx++] = "                <!-- <p class=\"search-box__head--sub\">지포스</p> -->";
	    html[hIdx++] = "            </div>";
	    html[hIdx++] = "        </div>";
	    html[hIdx++] = "    </dt>";
	    html[hIdx++] = "    <dd class=\"search-box__body\">";
	    html[hIdx++] = "        <div class=\"search-box__inner\">";
		$.each(customRgbAttrList.specMenuList, function(index, item){
	        if(index==0) {
				html[hIdx++] = "	<ul class=\"search-box__list search-box__colorlist\">";
			}
			var btncolor = "";
			if(item.rgb=="FFFFFF") btncolor=" btn-color--white";
			html[hIdx++] = "    	<li class=\"attrs\" data-attr=\"spec_"+item.strSpecNo+"_"+item.strSpecGroupTitle+"\" data-spec=\""+item.strSpecNo+"\"><button type=\"button\" class=\"btn-color"+btncolor+"\" style=\"background-color:#"+item.rgb+"\">"+item.strSpecGroupTitle+"</button></li>";
			if(customRgbAttrList.specMenuList.length==index+1) {
				html[hIdx++] = "		</ul>";
			}
		});
	    html[hIdx++] = "        </div>";
	    html[hIdx++] = "    </dd>";
	    html[hIdx++] = "</dl>";
	}
	
	// 쇼핑몰 ( 일반상품에서만 노출 )
	if(dataObj.data.shop!==undefined && dataObj.data.shop.length>0) {
		html[hIdx++] = "	<dl class=\"search-box-row\" data-attr-type=\"shop\">";
		html[hIdx++] = "		<dt class=\"search-box__head\">";
		html[hIdx++] = "			<div class=\"search-box__head--title\">";
		html[hIdx++] = "				<div class=\"search-box__head--inner\">";
		//									<!-- 속성명 / 카운트 -->
		html[hIdx++] = "					<p class=\"search-box__head--name\">쇼핑몰</p>";
		html[hIdx++] = "				</div>";
		html[hIdx++] = "			</div>";
		if(dataObj.data.shop.length>attrViewCnt) {
			html[hIdx++] = "			<div class=\"search-box__util\">";
    		html[hIdx++] = "				<span class=\"search-box__util--count\"><em>"+(dataObj.data.shop.length-6)+"</em>개</span>";
    		html[hIdx++] = "				<button type=\"button\" class=\"search-box__btn--unfold\" onclick=\"$(this).closest('.search-box-row').toggleClass('is--unfold');\"></button>";
			html[hIdx++] = "			</div>";
		}
		html[hIdx++] = "		</dt>";
		
		html[hIdx++] = "		<dd class=\"search-box__body\">";
		html[hIdx++] = "			<div class=\"search-box__inner\">";
		
		$.each(dataObj.data.shop, function(index, item){
			//							<!-- 반복 : 한줄 최대 6개 / 두줄케이스 12개 -->
			if(index==0) {
				html[hIdx++] = "		<ul class=\"search-box__list\">";
			}
			html[hIdx++] = "				<li class=\"attrs\" data-attr=\"shop_"+item.shop_code+"_"+item.shop_name+"\"><input type=\"checkbox\" id=\"chShop_"+index+"\" class=\"input--checkbox-item\" data-shopcode=\""+item.shop_code+"\"><label for=\"chShop_"+index+"\" title=\""+item.shop_name+"\">"+item.shop_name+"</label></li>";

			if(dataObj.data.shop.length==index+1) {
				html[hIdx++] = "		</ul>";
			}
		});
		
		html[hIdx++] = "			</div>";
		html[hIdx++] = "		</dd>";
		
		html[hIdx++] = "	</dl>";
	}
	
	// LP 카테고리 속성 ( 전체 / 가격비교 에서만 노출 )
	if(listType=="list" && (dataObj.data.custom!==undefined && dataObj.data.custom.length>0) ) {
		// 속성 기본 노출 4개 ( 변경 가능 )
		var defaultSpecCnt = 4;
		if(dataObj.data.custom) { 

			$.each(dataObj.data.custom, function(index, item){
				
				var addClassTxt = "";
				var attrDisplayNone = false; // 기본 설정 시 노출 여부
				var vMinusCnt = 6;
				if(lpSetupInfo!==undefined && lpSetupInfo.dtl_view_itm=="spec" && lpSetupInfo.dtl_view_itm_no==item.strGpno && item.specMenuList.length>6) {
					
					if(item.specMenuList.length > 12)	addClassTxt += "is--unfold";
					else								addClassTxt += "type--line2";
					vMinusCnt = 12;
				}
				if(index>=defaultSpecCnt) {
					addClassTxt += " more_spec";
					attrDisplayNone = true;
					if(!attrMoreView) { // 속성더보기 노출 여부
						attrMoreView = true;
					}
				}
				if(attrDisplayNone) {
					html[hIdx++] = "<dl class=\"search-box-row "+addClassTxt+"\" style=\"display:none;\" data-attr-type=\"spec\">";
				} else {
					html[hIdx++] = "<dl class=\"search-box-row "+addClassTxt+"\" data-attr-type=\"spec\">";
				}
				html[hIdx++] = "		<dt class=\"search-box__head\">";
				html[hIdx++] = "			<div class=\"search-box__head--title\">";
				html[hIdx++] = "				<div class=\"search-box__head--inner\">";
				//									<!-- 속성명 / 카운트 -->
				html[hIdx++] = "					<p class=\"search-box__head--name\">"+item.strSpecCateTitle+"</p>";
				//									<!-- 속성명 - 서브 -->
				
				if(item.strSubTitle!==undefined && item.strSubTitle.length>0) {
					html[hIdx++] = "				<p class=\"search-box__head--sub\">";
					if(item.strKbNo!="0" ) {
							html[hIdx++] = "			<button class=\"btn--dic\" data-kbno=\""+item.strKbNo+"\" onclick=\"javascript:lightTermdic(this);\">";
					}
					html[hIdx++] = item.strSubTitle;
					if(item.strKbNo!="0" && typeof item.strKbNo!="undefined") {
						html[hIdx++] = "				</button>";
					}
					html[hIdx++] = "				</p>";
				}
				html[hIdx++] = "				</div>";
				html[hIdx++] = "			</div>";
				//							<!-- 버튼 : 펼침/닫기 -->
				
				if(vMinusCnt == 12){
					if(item.specMenuList.length>attrViewCnt && item.specMenuList.length > 12) {
						html[hIdx++] = "			<div class=\"search-box__util\">";
    					html[hIdx++] = "				<span class=\"search-box__util--count\"><em>"+(item.specMenuList.length-12)+"</em>개</span>";
    					html[hIdx++] = "				<button type=\"button\" class=\"search-box__btn--unfold\" onclick=\"$(this).closest('.search-box-row').toggleClass('is--unfold');\"></button>";
						html[hIdx++] = "			</div>";
					}
				}else{
					if(item.specMenuList.length>attrViewCnt) {
						html[hIdx++] = "			<div class=\"search-box__util\">";
    					html[hIdx++] = "				<span class=\"search-box__util--count\"><em>"+(item.specMenuList.length-6)+"</em>개</span>";
    					html[hIdx++] = "				<button type=\"button\" class=\"search-box__btn--unfold\" onclick=\"$(this).closest('.search-box-row').toggleClass('is--unfold');\"></button>";
						html[hIdx++] = "			</div>";
					}
				}
				
				html[hIdx++] = "		</dt>";
				
				html[hIdx++] = "		<dd class=\"search-box__body\">";
				html[hIdx++] = "			<div class=\"search-box__inner\">";
				
				$.each(item.specMenuList, function(index_sub, spec){
					//							<!-- 반복 : 한줄 최대 6개 / 두줄케이스 12개 -->
					if(index_sub==0) {
						html[hIdx++] = "		<ul class=\"search-box__list\">";
					}
					html[hIdx++] = "				<li class=\"attrs\" data-attr=\"spec_"+spec.strSpecNo+"_"+spec.strSpecGroupTitle+"\" data-spec=\""+spec.strSpecNo+"\">";
					html[hIdx++] = "					<input type=\"checkbox\" id=\"chCustom_"+spec.strSpecNo+"\" class=\"input--checkbox-item\">";
					html[hIdx++] = "					<label for=\"chCustom_"+spec.strSpecNo+"\" title=\""+spec.strSpecGroupTitle+"\">";
					
					
					if(spec.intKbNo!="0" && typeof item.intKbNo != "undefined" ) {
						html[hIdx++] = "					<button class=\"btn--dic\" data-kbno=\""+spec.strKbNo+"\">";
					}
					html[hIdx++] = spec.strSpecGroupTitle;
					if(spec.intKbNo!="0") {
						html[hIdx++] = "					</button>";
					}
					html[hIdx++] = "					</label>";
					html[hIdx++] = "				</li>";
	
					if(item.specMenuList.length==index_sub+1) {
						html[hIdx++] = "		</ul>";
					}
				});
				
				html[hIdx++] = "			</div>";
				html[hIdx++] = "		</dd>";
				
				html[hIdx++] = "	</dl>";
			});
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
	if(dataObj.data.price_all!==undefined && dataObj.data.price_all.length>0 && dataObj.total>=50) {
		var startPrice_10 = 0;
		var endPrice_10 = 0;
		
		$.each(dataObj.data.price_all, function(index, item){
			if(index==2) { // 하위 10%
				startPrice_10 = item;
			} else if(index==18) { // 상위 10% 
				endPrice_10 = item;
			}
		});
			
		if(startPrice_10>0 && endPrice_10>0) {
			
			var diffPrice = endPrice_10 - startPrice_10;
			var diffRange = diffPrice/5;
			
			// 가격대 영역 5개
			for(var j=0;j<5;j++) {
				if(j==0) {
					if((Math.round(parseInt(startPrice_10 + diffRange)/10000)*10000) > 0) {
						priceRangeSet_all.add("0_"+(Math.round(parseInt(startPrice_10 + diffRange)/10000)*10000));						
					}
				} else if (j==4) {
					priceRangeSet_all.add((Math.round(parseInt(startPrice_10)/10000)*10000)+"_999999999");
				} else {
					if(Math.round(parseInt(startPrice_10)/10000)*10000!=Math.round(parseInt(startPrice_10 + diffRange)/10000)*10000) {
						priceRangeSet_all.add((Math.round(parseInt(startPrice_10)/10000)*10000)+"_"+(Math.round(parseInt(startPrice_10 + diffRange)/10000)*10000));
					}
				}
				startPrice_10 += diffRange;
			}
		}
		
		if(priceRangeSet_all.size>2) {
			if(param_tabType != "1" && param_tabType != "2" ) {
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
			html[hIdx++] = "			<ul class=\"search-box__range--price range-class--0"+priceRangeSet_all.size+"\">";
			var rangeCnt = 1;
			var hitFlag = false;

			priceRangeSet_all.forEach(function(item, item_value) {
				
				var splitPrice = item.split("_");
				var split_s = splitPrice[0];
				var split_e = splitPrice[1];
				var parseMsg = "";
				
				if(split_e > 0) {
					if(split_s==0) {
						parseMsg = (split_e/10000)+"만원 이하";
					} else if(split_e==999999999) {
						parseMsg = (split_s/10000)+"만원 이상";
					} else {
						parseMsg = (split_s/10000)+"~"+(split_e/10000)+"만원";
					}
					if(parseMsg.length>0) {
						html[hIdx++] = "		<li class=\"attrs\" data-attr=\"price_"+split_s+"_"+split_e+"\" data-range=\""+("range_"+rangeCnt)+"\">";
						html[hIdx++] = "			<button class=\"btn--range-price\">"+parseMsg+"</button>";
						if(!hitFlag && dataObj.data.model_avg_price_model!==undefined && split_e>=dataObj.data.model_avg_price_model) {
							//						<!-- 아이콘 : HIT -->
							html[hIdx++] = "		<i class=\"ico-range-hit lp__sprite\">HIT</i>";
							//						<!-- // -->
							hitFlag = true;
						}
						html[hIdx++] = "		</li>";
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
	// 가격대 - 모델상품 기준
	var priceRangeSet_model = new Set();
	if(dataObj.data.price_model!==undefined && dataObj.data.price_model.length>0 && dataObj.total>=50) {
		var startPrice_10 = 0;
		var endPrice_10 = 0;
		
		$.each(dataObj.data.price_model, function(index, item){
			if(index==2) { // 하위 10%
				startPrice_10 = item;
			} else if(index==18) { // 상위 10% 
				endPrice_10 = item;
			}
		});
		
		if(startPrice_10>0 && endPrice_10>0) {
		
			var diffPrice = endPrice_10 - startPrice_10;
			var diffRange = diffPrice/5;
			
			// 가격대 영역 5개
			for(var j=0;j<5;j++) {
				if(j==0) {
					if((Math.round(parseInt(startPrice_10 + diffRange)/10000)*10000) > 0) {
						priceRangeSet_all.add("0_"+(Math.round(parseInt(startPrice_10 + diffRange)/10000)*10000));						
					}
				} else if (j==4) {
					priceRangeSet_model.add((Math.round(parseInt(startPrice_10)/10000)*10000)+"_999999999");
				} else {
					if(Math.round(parseInt(startPrice_10)/10000)*10000!=Math.round(parseInt(startPrice_10 + diffRange)/10000)*10000) {
						priceRangeSet_model.add((Math.round(parseInt(startPrice_10)/10000)*10000)+"_"+(Math.round(parseInt(startPrice_10 + diffRange)/10000)*10000));
					}
				}
				startPrice_10 += diffRange;
			}
		}
		
		if(priceRangeSet_model.size>2) {
			if(param_tabType == "1") {
				html[hIdx++] = "<dl class=\"search-box-row row-price-range\" data-attr-type=\"price\" data-price-option=\"model\">";
			} else {
				html[hIdx++] = "<dl class=\"search-box-row row-price-range\" data-attr-type=\"price\" data-price-option=\"model\" style=\"display:none;\">";
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
			html[hIdx++] = "			<ul class=\"search-box__range--price range-class--0"+priceRangeSet_model.size+"\">";
			var rangeCnt = 1;
			var hitFlag = false;
	
			priceRangeSet_model.forEach(function(item, item_value) {
				
				var splitPrice = item.split("_");
				var split_s = splitPrice[0];
				var split_e = splitPrice[1];
				var parseMsg = "";
				
				if(split_e > 0) {
					if(split_s==0) {
						parseMsg = (split_e/10000)+"만원 이하";
					} else if(split_e==999999999) {
						parseMsg = (split_s/10000)+"만원 이상";
					} else {
						parseMsg = (split_s/10000)+"~"+(split_e/10000)+"만원";
					}
					if(parseMsg.length>0) {
						html[hIdx++] = "		<li class=\"attrs\" data-attr=\"price_"+split_s+"_"+split_e+"\" data-range=\""+("range_"+rangeCnt)+"\">";
						html[hIdx++] = "			<button class=\"btn--range-price\">"+parseMsg+"</button>";
						if(!hitFlag && dataObj.data.model_avg_price_model!==undefined && split_e>=dataObj.data.model_avg_price_model) {
							//						<!-- 아이콘 : HIT -->
							html[hIdx++] = "		<i class=\"ico-range-hit lp__sprite\">HIT</i>";
							//						<!-- // -->
							hitFlag = true;
						}
						html[hIdx++] = "		</li>";
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
	// 가격대 - 일반상품 기준
	var priceRangeSet_pl = new Set();
	if(dataObj.data.price_pl!==undefined && dataObj.data.price_pl.length>0 && dataObj.total>=50) {
		var startPrice_10 = 0;
		var endPrice_10 = 0;
		
		$.each(dataObj.data.price_pl, function(index, item){
			if(index==2) { // 하위 10%
				startPrice_10 = item;
			} else if(index==18) { // 상위 10% 
				endPrice_10 = item;
			}
		});
		
		if(startPrice_10>0 && endPrice_10>0) {
		
			var diffPrice = endPrice_10 - startPrice_10;
			var diffRange = diffPrice/5;
			
			// 가격대 영역 5개
			for(var j=0;j<5;j++) {
				if(j==0) {
					if((Math.round(parseInt(startPrice_10 + diffRange)/10000)*10000) > 0) {
						priceRangeSet_all.add("0_"+(Math.round(parseInt(startPrice_10 + diffRange)/10000)*10000));						
					}
				} else if (j==4) {
					priceRangeSet_pl.add((Math.round(parseInt(startPrice_10)/10000)*10000)+"_999999999");
				} else {
					if(Math.round(parseInt(startPrice_10)/10000)*10000!=Math.round(parseInt(startPrice_10 + diffRange)/10000)*10000) {
						priceRangeSet_pl.add((Math.round(parseInt(startPrice_10)/10000)*10000)+"_"+(Math.round(parseInt(startPrice_10 + diffRange)/10000)*10000));
					}
				}
				startPrice_10 += diffRange;
			}
		}
		
		if(priceRangeSet_pl.size>2) {
			if(param_tabType == "2") {
				html[hIdx++] = "<dl class=\"search-box-row row-price-range\" data-attr-type=\"price\" data-price-option=\"pl\">";
			} else {
				html[hIdx++] = "<dl class=\"search-box-row row-price-range\" data-attr-type=\"price\" data-price-option=\"pl\" style=\"display:none;\">";
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
			html[hIdx++] = "			<ul class=\"search-box__range--price range-class--0"+priceRangeSet_pl.size+"\">";
			var rangeCnt = 1;
			var hitFlag = false;
	
			priceRangeSet_pl.forEach(function(item, item_value) {
				
				var splitPrice = item.split("_");
				var split_s = splitPrice[0];
				var split_e = splitPrice[1];
				var parseMsg = "";
				
				if(split_e > 0) {
					if(split_s==0) {
						parseMsg = (split_e/10000)+"만원 이하";
					} else if(split_e==999999999) {
						parseMsg = (split_s/10000)+"만원 이상";
					} else {
						parseMsg = (split_s/10000)+"~"+(split_e/10000)+"만원";
					}
					if(parseMsg.length>0) {
						html[hIdx++] = "		<li class=\"attrs\" data-attr=\"price_"+split_s+"_"+split_e+"\" data-range=\""+("range_"+rangeCnt)+"\">";
						html[hIdx++] = "			<button class=\"btn--range-price\">"+parseMsg+"</button>";
						if(!hitFlag && dataObj.data.model_avg_price_pl!==undefined && split_e>=dataObj.data.model_avg_price_pl) {
							//						<!-- 아이콘 : HIT -->
							html[hIdx++] = "		<i class=\"ico-range-hit lp__sprite\">HIT</i>";
							//						<!-- // -->
							hitFlag = true;
						}
						html[hIdx++] = "		</li>";
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
	if(dataObj.data.reqKwd!==undefined && dataObj.data.reqKwd.length>0 && lpSetupInfo.keyword_cnt>0) {
		var reqDrawCnt = (lpSetupInfo.keyword_cnt>dataObj.data.reqKwd.length) ? dataObj.data.reqKwd.length : lpSetupInfo.keyword_cnt;
		
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
		for(var i=0;i<reqDrawCnt;i++) {
			var item = dataObj.data.reqKwd[i];
			html[hIdx++] = "			<li class=\"attrs reqKwd\" data-attr=\"reqKwd_"+regSpecExp(item.code)+"\">";
			html[hIdx++] = "				<button class=\"btn--keyword\">"+item.name+"</button>";
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
	
	if(attrMoreView) {
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
	
	// 탭별 노출 처리 
	if(listType=="list") {
		if(param_tabType==2 || param_tabType==4) {
			// LP 상세검색
			$("dl.search-box-row[data-attr-type=spec]").hide();
			// 상세검색 더보기/닫기 버튼 숨김
			$(".adv-search__btn--more").hide();
		}
	}
	if(param_tabType!=2) {
		// 쇼핑몰
		$("dl.search-box-row[data-attr-type=shop]").hide();
	}
	
	// LP 속성 ( spec ) 직링크 진입 시
	if(param_spec.length>0) {
		var splitSpec = param_spec.split(",");
		for(var i=0;i<splitSpec.length;i++) {
			$("li.attrs[data-spec="+splitSpec[i]+"] label").trigger("click");
		}
	}
	
	// 분류검색어 중 키워드 검색어 가 있을 때 
	if(Synonym_From=="search" && Synonym_From_Keyword.length>0 && param_inKeyword.length>0) {
		$(".list-filter__search .list-filter__search--input").val(Synonym_From_Keyword);
		$("button.list-filter__search--btn").trigger("click");
	}
	
	//더보기 갯수
	var vMoreSpecLength = $("dl.more_spec").length;
	$("#moreViewOpenCnt").text(vMoreSpecLength);
	
	firstLoadAttrFlag = false;	
}

//속성 API 호출 실패시
function failAttr(errorObj) {
	console.log( "LP/SRP spec API Call Fail : " + errorObj.statusText);
}

// 로딩바 제어
function loading(type) {
	
	var loadingObj  = $(".comm-loader"); // 로딩바
	
	if(type=="show") {
		loadingObj.show();
	} else if(type=="hide") {
		loadingObj.fadeOut(100);
	}
	
	return;
}

// 스펙관련 문자열 만들기 - 용어사전
function makerSpecTagDic(vip_spec) {
	if(!vip_spec) return "";

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
	
	for(var i=0; i<svtAry.length; i++) {
		var svtItem = svtAry[i].replace("\\\"", "&amp;#34;");
		var findStrAry = svtItem.match(regFinder);
		if(findStrAry && findStrAry.length>0) {
			for(var j=0; j<findStrAry.length; j++) {
				var findItem = findStrAry[j].replace("\\\"", "&amp;#34;");
				var replaceItem = "";
				
				if(findItem.indexOf("_")>0) {
					var chItem = findItem;

					chItem = chItem.replace("$TAG$", "");
					chItem = chItem.replace("$END$", "");

					if(chItem.charAt(0)=='_') chItem = chItem.substring(1);

					var chItemAry = chItem.split("_");

					if(chItemAry && chItemAry.length>=3) {
						replaceItem += "<a href=\"javaScript:void(0);\" class=\"btn--dic\" data-attr_id=\""+chItemAry[0]+"\" data-attr_el_id=\""+chItemAry[1]+"\" onclick=\"showDicLayer(this);return false;\">";
						replaceItem += chItemAry[2].replace("&amp;#47;","/").replace("&amp;#34;","\"").replace("\\","");
						replaceItem += "</a>";
					}
				}

				svtItem = svtItem.split(findItem).join(replaceItem).replace("\\","");
			}
		}

		if(i>0) rtnValue += "<em>|</em>";
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

	if(!vip_spec) return "";

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

	for(var i=0; i<svtAry.length; i++) {
		var svtItem = svtAry[i];
		var findStrAry = svtItem.match(regFinder);
		if(findStrAry && findStrAry.length>0) {
			for(var j=0; j<findStrAry.length; j++) {
				var findItem = findStrAry[j];
				var replaceItem = "";

				if(findItem.indexOf("_")>0) {
					var chItem = findItem;

					chItem = chItem.replace("$TAG$", "");
					chItem = chItem.replace("$END$", "");

					if(chItem.charAt(0)=='_') chItem = chItem.substring(1);

					var chItemAry = chItem.split("_");

					if(chItemAry && chItemAry.length>=3) {
						if(chItemAry[2].indexOf("<b>[") > -1){
							if(i>0){
								replaceItem += "<br><b>";
							}else{
								replaceItem += "<b>"; //첫줄 개행금지
							}
						}
						replaceItem =  "<a href=\"JavaScript:\" class=\"btn--dic\" data-attr_id=\""+chItemAry[0]+"\" data-attr_el_id=\""+chItemAry[1]+"\" onclick=\"showDicLayer(this);return false;\">";
						replaceItem += chItemAry[2].replace("&amp;#47;","/").replace("\\","");
						replaceItem += "</a>";
						if(chItemAry[2].indexOf("<b>[") > -1){
							replaceItem += "</b>";
						}
					}
				}
				svtItem = svtItem.split(findItem).join(replaceItem);
			}
		}

		if(i>0) rtnValue += "<em> </em>";
		rtnValue += svtItem.replace("&amp;#47;","/").replace("\\","");
	}
	// 태그 넣기
	rtnValue = rtnValue.split(bTag2).join(bTag1);
	rtnValue = rtnValue.split(brTag2).join(brTag1);
	//대괄호앞에 개행추가 (두번째줄부터 개행)
	rtnValue = rtnValue.replace(/\>\<b\>\[/gi,"\>\<br\>\<b\>\[");
	return rtnValue;
} 

// 그룹모델 영역 그리기
function drawGroupModel(groupModelObj, strExtraPriceTitle, strExtraPrice, strOpenExpectFlag) {
	
	var html = "";
	var groupList = groupModelObj.list;
	var strChange = groupModelObj.strChange;
	var strUnit = groupModelObj.strUnit;
	
	if(groupList.length>0) {
		
//		<!-- 상품가격 : 가격비교형 -->
		//	<!-- 다른 옵션 더보기 .is--unfold 붙여주세요 -->
		html += "<div class=\"item__price\">";
		
		// 			<!-- 출시가 -->
		if(strExtraPriceTitle.length>0 && strExtraPrice.length>0) {
			html += "<div class=\"price__origin\">";
			html += "	<p class=\"tx--price\"><span class=\"tx_sub\">"+strExtraPriceTitle+"</span> <em>"+strExtraPrice+"</em>원</p>";
			html += "</div>";
		}
		
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
			if(Index>=5) {
				html += "<li class=\"option__row is--hide\" data-type=\"option\" data-modelno=\""+strModelNo+"\" data-img=\""+strSmallImg+"\">";
			} else {
				html += "<li class=\"option__row\" data-type=\"option\" data-modelno=\""+strModelNo+"\" data-img=\""+strSmallImg+"\">";
			}
			//				<!-- 조건 -->
			html += "		<div class=\"opt--condition\">";
			//					<!-- 순위 : 없으면 비노출 -->
			if(strRank.length>0) {
				html += "		<span class=\"tx--rank\">"+strRank+"위</span>";
			}
			//						<!-- 조건명 : 필수 노출 -->
			if(strCondiName.length>0) {
				// 용어사전
				if(strDicKbNo!="0") {
					html += "	<span class=\"tx--condition btn--dic\" onclick=\"javascript:showDicLayer(this);\" data-kbno=\""+strDicKbNo+"\" title=\""+strCondiName+"\">"+strCondiName+"</span>";
				} else {
					html += "	<span class=\"tx--condition\" title=\""+strCondiName+"\">"+strCondiName+"</span>";
				}
			}
			//					<!-- 단위환산가 : 없으면 비노출 -->
			if(strUnitPrice!="0") {
				if(strChange!="0" && strUnit !="") {
					if(strMinUnitPriceYN=="Y") {
						html += "	<span class=\"tx--unit is--minp\">"+strUnitPrice+"원/"+strChange+""+strUnit+"</span>";
					} else {
						html += "	<span class=\"tx--unit\">"+strUnitPrice+"원/"+strChange+""+strUnit+"</span>";
					}
				} else {
					if(strMinUnitPriceYN=="Y") {
						html += "	<span class=\"tx--unit is--minp\">"+strUnitPrice+"원</span>";
					} else {
						html += "	<span class=\"tx--unit\">"+strUnitPrice+"원</span>";
					}
				}
			}
			html += "		</div>";
			//				<!-- 가격 -->
			html += "		<div class=\"opt--price\">";
			//					<!-- 태그 : 현금 -->
			if(tag.cash!==undefined) {
				html += "		<span class=\"tag--cash lp__sprite\">현금</span>";
			}
			//					<!-- 태그 : 직구 -->
			if(tag.ovs!==undefined) {
				html += "		<span class=\"tag--global lp__sprite\">직구</span>";
			}
			//					<!-- 태그 : 모바일 -->
			if(param_isDelivery=="N" && strMobileMinPriceYn=="Y") {
				html += "		<span class=\"tag--mobile lp__sprite\" onclick=\"javascript:mobileMinPriceLayer(this);\">모바일</span>";
			}
			//					<!-- 가격 -->
			if(strOpenExpectFlag=="Y") {
				html += "		<span class=\"tx--price\">가격미정</span>";
			} else {
				if(strPrice.length>0) {
					if(strPrice=="미정" || strPrice=="없음") {
						html += "<span class=\"tx--price\">"+strPrice+"</span>";
					} else {
						// 현금몰일 경우 현금가 노출
						if(tag.cash!==undefined && tag.cash.price!==undefined) {
							html += "<span class=\"tx--price\">"+tag.cash.price+"</span>원";
						} else {
							html += "<span class=\"tx--price\">"+strPrice+"</span>원";
						}
					}
				}
			}
			html += "		</div>";
			//				<!-- 몰수 -->
			if(strOpenExpectFlag!="Y") {
				if(!isNaN(strMallCnt)) {
					if(parseInt(strMallCnt)>999) {
						html += "<div class=\"opt--count\">999+</div>";
					} else if(strMallCnt!="0") {
						html += "<div class=\"opt--count\">"+parseInt(strMallCnt)+"</div>";
					}
				} else {
					html += "	<div class=\"opt--count\">"+strMallCnt+"</div>";
				}
				//				<!-- 체크/찜/비교 -->
				if(strMallCnt!="0") {
					html += "	<div class=\"opt--chk\">";
					html += "		<input type=\"checkbox\" id=\"lpListItem"+strModelNo+"\" class=\"input--checkbox-item\">";
					html += "		<label for=\"lpListItem"+strModelNo+"\"></label>";
					//				<!-- Hover시 노출 -->
					html += "		<div class=\"lay-opt--chk\">";
					//					<!-- 버튼 : 상품 비교 -->
					html += "			<button class=\"btn--opt-compare\" >비교</button>";
					//					<!-- 버튼 : 찜하기 -->
					if((strZzimYN=="Y" && !zzimTmpModelNoRemoveSet.has(strModelNo)) || zzimTmpModelNoSet.has(strModelNo)) {
						html += "		<button class=\"btn--opt-zzim is--on\" data-zzimno=\"G"+strModelNo+"\" title=\"찜\" onclick=\"showLayZzim_list(this);return false;\">찜<i class=\"ico-opt-zzim lp__sprite\"></i></button>";
					} else {
						html += "		<button class=\"btn--opt-zzim\" data-zzimno=\"G"+strModelNo+"\" title=\"찜\" onclick=\"showLayZzim_list(this);return false;\">찜<i class=\"ico-opt-zzim lp__sprite\"></i></button>";
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
		if(groupList.length>5) {
			html += "<button class=\"btn--opt-unfold\"><span class=\"tx-btn-opt\">다른옵션 <em>"+parseInt(groupList.length-5)+"개</em>펼치기</span></button>";
			html += "<button class=\"btn--opt-fold\" onclick=\"$(this).closest('.item__price').removeClass('is--unfold');\" style=\"display:none;\"><span class=\"tx-btn-opt\">닫기</span></button>";
		}
		html += "</div>";
	}

	return html;
}

// 소셜 정보 호출
function loadSocial() {
	
	$(".list-filter-bot[data-type=prod]").hide();
	$(".list-filter-bot[data-type=social]").show();
	
	// 상단탭 비활성화 
	if(listType=="list") {
		$(".category-lp--fine").addClass("is--disabled");
	}
	$(".adv-search").addClass("is--disabled");
	
	//로딩바 불러오기
	loading("show");
	
	if(listType=="list") {
		// 파라미터
		var listSocailParam = {
			"pageNum" : param_pageNum,
			"pageGap" : param_pageGap,
			"cate" : param_cate,
			"order" : param_sort
		};
		
		// 리스트 API 호출
		var listSocailPromise = $.ajax({
			type : "POST",
			url : "/lsv2016/ajax/getLPSocialGoodsList.jsp",
			dataType : "json",
			data : listSocailParam
		});
	
		listSocailPromise.then(drawSocialLP, failSocial);
	} else if(listType=="search") {
		
		var prodAlign = "pop";
		if(param_sort==1) prodAlign = "pop";
		if(param_sort==2) prodAlign = "lowprice";
		if(param_sort==3) prodAlign = "salerate";
		if(param_sort==4) prodAlign = "salecnt";
		
		// 파라미터
		var searchSocailParam = {
			"keyword": param_keyword,
			"pagingLimit": null,
			"pagingRnum": (param_pageNum-1),
			"pagingSize": parseInt(param_pageGap),
			"prodAlign": prodAlign,
			"cate1": "search"
		};
		
		// 리스트 API 호출
		var searchSocailPromise = $.ajax({
			type : "POST",
			contentType: "application/json; charset=UTF-8",
			url : "/deal/search.deal",
			dataType : "json",
			data : JSON.stringify(searchSocailParam),
		});
	
		searchSocailPromise.then(drawSocialSRP, failSocial);
	}
}

// 소셜 LP 그리기
function drawSocialLP(dataObj) {
	
	if((dataObj.goodsList && dataObj.goodsList.length==0) || dataObj.totalCnt==0) {
		drawNoData(); // 리스트 정보 없을때
		return;
	}
	
	// 상품갯수 표기
	$("ul.list-filter__tab li[tabType="+param_tabType+"]").find(".list-tab--count").text(dataObj.totalCnt.format());
	
	$(".goods-list").empty().append("<div class=\"goods-cont type--social\"><ul class=\"goods-bundle\"></ul></div>");
	
	$(".list-filter-bot[data-type=social]").append("<div class=\"list-filter-side\"><button onclick=\"javascript:socialSearchAllLink();\" class=\"list-filter__btn\">소셜가격비교 바로가기<i class=\"ico-rarr--sm lp__sprite\"></i></button></div>");
	
	var html = [];
	var hIdx = 0;

	var rank = 1; // 순위 표기용
	
	// 갤러리뷰 상품메우기 로직을 위해 3위 까지 임의의 class 부여
	var highRankMaxCnt = 3;

	$.each(dataObj.goodsList, function(index, item) {
		var cp_id = item.cp_id;
		var cp_pid = item.cp_pid;
		var cp_company_name = item.cp_company_name;
		var cp_name = item.cp_name;
		var cp_url = item.cp_url;
		var cp_image1 = item.cp_image1;
		var cp_image5 = item.cp_image5;
		var cp_price = item.cp_price;
		var cp_saleprice = item.cp_saleprice;
		var cp_salerate = item.cp_salerate;
		var cp_salecnt = item.cp_salecnt;
		var cp_today_use = item.cp_today_use;
		var cp_instant_deliver = item.cp_instant_deliver;
		var cp_free_ship = item.cp_free_ship;
		var soldrate = item.soldrate;
		var intSoldrate = 0;

		try {
			if(soldrate) intSoldrate = parseInt(soldrate);
		} catch(e) {}
		
		if(cp_salerate=="0") cp_salerate = "특가";
		else cp_salerate += "%";
		
		var prodAddClass = "";
		if(highRankMaxCnt>0) {
			prodAddClass += " highrank";
			highRankMaxCnt--;
		}

		html[hIdx++] = "<li class=\"prodItem"+prodAddClass+"\" data-type=\"social\" data-id=\"social_"+cp_id+"\">";
		html[hIdx++] = "	<div class=\"goods-item\">";
		html[hIdx++] = "		<div class=\"item__thumb\">";
		//							<!-- 순위 -->
		if(param_pageNum==1) {
			html[hIdx++] = "		<span class=\"tag--rank\">"+(rank++)+"</span>";
		}
		//							<!-- // -->
		html[hIdx++] = "			<a href=\"JavaScript:goSocialItem('"+cp_id+"', '"+cp_url+"');\">";
		html[hIdx++] = "				<img class=\"lazy\" data-original=\""+cp_image5+"\" src=\""+noImageStr+"\">";
		html[hIdx++] = "			</a>";
		html[hIdx++] = "		</div>";
		html[hIdx++] = "		<div class=\"item__box\">";
		html[hIdx++] = "			<div class=\"item__head\">";
		//								<!-- 쇼핑몰 -->
		html[hIdx++] = "				<span class=\"tx--mall\">"+cp_company_name+"</span>";
		//								<!-- 구매수량 -->
		html[hIdx++] = "				<span class=\"tx--count\">"+cp_salecnt.format()+"개 구매</span>";
		html[hIdx++] = "			</div>";
		//							<!-- 상품명 -->
		html[hIdx++] = "			<div class=\"item__name\">";
		html[hIdx++] = "				<a href=\"JavaScript:goSocialItem('"+cp_id+"', '"+cp_url+"');\">"+cp_name+"</a>";
		html[hIdx++] = "			</div>";
		//							<!-- 상품가격 -->
		html[hIdx++] = "			<div class=\"item__price\">";
		//								<!-- 할인전 가격-->
		if(cp_salerate!="특가") {
			html[hIdx++] = "			<div class=\"tx--org-price\"><em>"+cp_price.format()+"</em>원</div>";
		}
		//								<!-- 특가/할인율 등 --> 
		html[hIdx++] = "				<span class=\"tx--prefix\">"+cp_salerate+"</span>";
		//								<!-- 가격 -->
		html[hIdx++] = "				<a href=\"JavaScript:goSocialItem('"+cp_id+"', '"+cp_url+"');\" class=\"tx--sale-price\">";
		html[hIdx++] = "					<em>"+cp_saleprice.format()+"</em>원";
		html[hIdx++] = "				</a>";
		//								<!-- // -->
		html[hIdx++] = "			</div>";
		//							<!-- 하단 태그 -->
		html[hIdx++] = "			<div class=\"item__foot\">";
		if(cp_instant_deliver=="Y") {
			html[hIdx++] = "			<span class=\"tag--deli-quick lp__sprite\">빠른배송</span>";
		}
		if(cp_free_ship=="Y") {
			html[hIdx++] = "			<span class=\"tag--deli-free lp__sprite\">무료배송</span>";
		}
		if(intSoldrate>=80) {
			html[hIdx++] = "			<span class=\"tag--sold lp__sprite\">매진임박</span>";
		}
		if(cp_today_use=="Y") {
			html[hIdx++] = "			<span class=\"tag--use-quick lp__sprite\">바로사용</span>";
		}
		html[hIdx++] = "			</div>";
		html[hIdx++] = "		</div>";
		html[hIdx++] = "	</div>";
		html[hIdx++] = "</li>";
	});
	
	$(".goods-bundle").html(html.join(""));
	
	loading("hide");
	
	// 이미지 보여주기
	$("img.lazy").lazyload();
	
	paging(dataObj.totalCnt); // 페이징
	
	// 갤러리뷰 상품 메우기 로직
	var prodLength = $("li.prodItem").length;
	var useCount = 0;
	if(prodLength>4) {
		useCount = 4 - (prodLength%4);
	}
	if(useCount==4) {
		useCount = 0;
	}

	var highRankData = $(".highrank");
	// 갤러리뷰의 한 줄의 상품카드가 4개 이고, 부족한 갯수만큼 채운다.
	for(var i=0;i<useCount;i++) {
		var addHtml = highRankData[i].outerHTML;
		if(addHtml.length>0) {
			$(".goods-list .goods-bundle").append(highRankData[i].outerHTML);
		}
	}
	
	// 추가된 돔에 대하여 순위제거 및 lazyload 적용
	var addIndexCount = $("li.prodItem.highrank").length - useCount;
	$("li.prodItem.highrank").each(function(index,item) {
		if(index>=addIndexCount) {
			$(this).addClass("fill");
			$(this).find(".item__model").removeClass("has--tag");
			$(this).find(".tag--rank").remove();
		}
	});
	$("li.prodItem.highrank").removeClass("highrank");
	
	// 이미지 보여주기
	$("li.fill img.lazy").lazyload({
		placeholder : noImageStr
	});
}

//소셜 SRP 그리기
function drawSocialSRP(dataObj) {
	
	var totalCnt = 0;
	try {
		if(dataObj.param.pagingTotalCnt!==undefined) totalCnt = parseInt(dataObj.param.pagingTotalCnt);
	} catch(e) {}
	
	// 상품갯수 표기
	$("ul.list-filter__tab li[tabType="+param_tabType+"]").find(".list-tab--count").text(totalCnt.format());
	
	$(".goods-list").empty().append("<div class=\"goods-cont type--social\"><ul class=\"goods-bundle\"></ul></div>");
	
	$(".list-filter-bot[data-type=social]").append("<div class=\"list-filter-side\"><button onclick=\"javascript:socialSearchAllLink();\" class=\"list-filter__btn\">소셜가격비교 바로가기<i class=\"ico-rarr--sm lp__sprite\"></i></button></div>");
	
	var html = [];
	var hIdx = 0;

	var rank = 1; // 순위 표기용
	
	// 갤러리뷰 상품메우기 로직을 위해 3위 까지 임의의 class 부여
	var highRankMaxCnt = 3;
	
	var goodsList = dataObj.list["DS_COUPON"];
	
	if(goodsList) {
		$.each(goodsList, function(indexI, item) {
			var cate1 = item.cate1;
			var cate1Name = item.cate1Name;
			var cate2 = item.cate2;
			var cate2Name = item.cate2Name;
			var cate3 = item.cate3;
			var cate3Name = item.cate3Name;
			var companyNm = item.companyNm;
			var cpAddress = item.cpAddress;
			var cpCompany = item.cpCompany;
			var cpCouponEnd = item.cpCouponEnd;
			var cpCouponStart = item.cpCouponStart;
			var cpDescript = item.cpDescript;
			var cpFreeShip = item.cpFreeShip;
			var cpId = item.cpId;
			var cpImage = item.cpImage;
			var cpImage1 = item.cpImage1;
			var cpImage2 = item.cpImage2;
			var cpImage5 = item.cpImage5;
			var cpInstantDeliver = item.cpInstantDeliver;
			var cpLat = item.cpLat;
			var cpLimitdate = item.cpLimitdate;
			var cpLng = item.cpLng;
			var cpMaxcnt = item.cpMaxcnt;
			var cpMobileRank = item.cpMobileRank;
			var cpMobileRankOld = item.cpMobileRankOld;
			var cpName = item.cpName;
			var cpPrice = item.cpPrice;
			var cpRank = item.cpRank;
			var cpSalecnt = item.cpSalecnt;
			var cpSaleprice = item.cpSaleprice;
			var cpSalerate = item.cpSalerate;
			var cpStartdate = item.cpStartdate;
			var cpSummary = item.cpSummary;
			var cpTodayUse = item.cpTodayUse;
			var cpUrl = item.cpUrl;
			var likeCnt = item.likeCnt;
			var pagingRnum = item.pagingRnum;
			var pagingTotalCnt = item.pagingTotalCnt;
			var soldrate = item.soldrate;
			var intSoldrate = 0;

			try {
				if(soldrate) intSoldrate = parseInt(soldrate);
			} catch(e) {}
			
			if(cpSalerate=="0") cpSalerate = "특가";
			else cpSalerate += "%";
			
			var prodAddClass = "";
			if(highRankMaxCnt>0) {
				prodAddClass += " highrank";
				highRankMaxCnt--;
			}
			
			html[hIdx++] = "<li class=\"prodItem"+prodAddClass+"\" data-type=\"social\" data-id=\"social_"+cpId+"\">";
			html[hIdx++] = "	<div class=\"goods-item\">";
			html[hIdx++] = "		<div class=\"item__thumb\">";
			//							<!-- 순위 -->
			if(param_pageNum==1) {
				html[hIdx++] = "		<span class=\"tag--rank\">"+(rank++)+"</span>";
			}
			//							<!-- // -->
			html[hIdx++] = "			<a href=\"JavaScript:goSocialItem('"+cpId+"', '"+cpUrl+"');\">";
			html[hIdx++] = "				<img class=\"lazy\" data-original=\""+cpImage5+"\" src=\""+noImageStr+"\">";
			html[hIdx++] = "			</a>";
			html[hIdx++] = "		</div>";
			html[hIdx++] = "		<div class=\"item__box\">";
			html[hIdx++] = "			<div class=\"item__head\">";
			//								<!-- 쇼핑몰 -->
			html[hIdx++] = "				<span class=\"tx--mall\">"+companyNm+"</span>";
			//								<!-- 구매수량 -->
			html[hIdx++] = "				<span class=\"tx--count\">"+cpSalecnt.format()+"개 구매</span>";
			html[hIdx++] = "			</div>";
			//							<!-- 상품명 -->
			html[hIdx++] = "			<div class=\"item__name\">";
			html[hIdx++] = "				<a href=\"JavaScript:goSocialItem('"+cpId+"', '"+cpUrl+"');\">"+cpName+"</a>";
			html[hIdx++] = "			</div>";
			//							<!-- 상품가격 -->
			html[hIdx++] = "			<div class=\"item__price\">";
			//								<!-- 할인전 가격-->
			if(cpSalerate!="특가") {
				html[hIdx++] = "			<div class=\"tx--org-price\"><em>"+cpPrice.format()+"</em>원</div>";
			}
			//								<!-- 특가/할인율 등 --> 
			html[hIdx++] = "				<span class=\"tx--prefix\">"+cpSalerate+"</span>";
			//								<!-- 가격 -->
			html[hIdx++] = "				<a href=\"JavaScript:goSocialItem('"+cpId+"', '"+cpUrl+"');\" class=\"tx--sale-price\">";
			html[hIdx++] = "					<em>"+cpSaleprice.format()+"</em>원";
			html[hIdx++] = "				</a>";
			//								<!-- // -->
			html[hIdx++] = "			</div>";
			//							<!-- 하단 태그 -->
			html[hIdx++] = "			<div class=\"item__foot\">";
			if(cpInstantDeliver=="Y") {
				html[hIdx++] = "			<span class=\"tag--deli-quick lp__sprite\">빠른배송</span>";
			}
			if(cpFreeShip=="Y") {
				html[hIdx++] = "			<span class=\"tag--deli-free lp__sprite\">무료배송</span>";
			}
			if(intSoldrate>=80) {
				html[hIdx++] = "			<span class=\"tag--sold lp__sprite\">매진임박</span>";
			}
			if(cpTodayUse=="Y") {
				html[hIdx++] = "			<span class=\"tag--use-quick lp__sprite\">바로사용</span>";
			}
			html[hIdx++] = "			</div>";
			html[hIdx++] = "		</div>";
			html[hIdx++] = "	</div>";
			html[hIdx++] = "</li>";
		});
	}
	
	$(".goods-bundle").html(html.join(""));
	
	loading("hide");
	
	// 이미지 보여주기
	$("img.lazy").lazyload();
	
	paging(totalCnt); // 페이징
	
	// 갤러리뷰 상품 메우기 로직
	var prodLength = $("li.prodItem").length;
	var useCount = 0;
	if(prodLength>4) {
		useCount = 4 - (prodLength%4);
	}
	if(useCount==4) {
		useCount = 0;
	}

	var highRankData = $(".highrank");
	// 갤러리뷰의 한 줄의 상품카드가 4개 이고, 부족한 갯수만큼 채운다.
	for(var i=0;i<useCount;i++) {
		var addHtml = highRankData[i].outerHTML;
		if(addHtml.length>0) {
			$(".goods-list .goods-bundle").append(highRankData[i].outerHTML);
		}
	}
	
	// 추가된 돔에 대하여 순위제거 및 lazyload 적용
	var addIndexCount = $("li.prodItem.highrank").length - useCount;
	$("li.prodItem.highrank").each(function(index,item) {
		if(index>=addIndexCount) {
			$(this).addClass("fill");
			$(this).find(".item__model").removeClass("has--tag");
			$(this).find(".tag--rank").remove();
		}
	});
	$("li.prodItem.highrank").removeClass("highrank");
	
	// 이미지 보여주기
	$("li.fill img.lazy").lazyload({
		placeholder : noImageStr
	});
}

//소셜 API 호출 실패시
function failSocial(errorObj) {
	console.log( "LP/SRP social API Call Fail : " + errorObj.statusText);
	drawNoData();
}

// 히트브랜드 정보 호출
function loadHitBrand(cate) {
	if(cate===undefined || cate.length<4) {
		return;
	}
	
	if(cate.length>4) {
		cate = cate.substring(0,4);
	}
	
	var param = {
		"procType" : "1",
		"cate" : cate
	}
	
	// 속성 API 호출
	var hitBrandPromise = $.ajax({
		type : "GET",
		url : "/lsv2016/ajax/getLPHitBrand_ajax.jsp",
		dataType : "json",
		data : param
	});
	
	hitBrandPromise.then(drawHitBrand, failHitBrand);
}

//히트브랜드 그리기
function drawHitBrand(dataObj) {
	
	var p_choicep_no = dataObj.choicep_no;
	var p_ord = dataObj.ord;
	var p_tab = dataObj.tab;
	var p_choice_part = dataObj.choice_part;
	var p_brand = dataObj.brand;
	var p_brand_image = dataObj.brand_image;
	var p_brand_des = dataObj.brand_des;

	var hitBrandModelListObj = dataObj.hitBrandModelList;
	
	var hitBrandModelCnt = 0;
	var modelnoAry = new Array();
	var randArray = new Array();
	var imgRoot = "http://storage.enuri.info/pic_upload/exhibition/";
	
	if(hitBrandModelListObj) {
		$.each(hitBrandModelListObj, function(indexI, listObj) {
			var hit_brand_no = listObj.hit_brand_no;
			var tab = listObj.tab;
			var ord = listObj.ord;
			var modelno = listObj.modelno;
			var minprice = listObj.minprice;
			var modelname = listObj.modelname;
			var goods_image = listObj.goods_image;
			var useenuri500 = listObj.useenuri500;
			var logo_image = listObj.logo_image;
			var url = listObj.url;
			var choice_cause = listObj.choice_cause;
			var reg_date = listObj.reg_date;
			var copy = listObj.copy;
			var gd_prc = listObj.gd_prc;
			var url = listObj.url;
			hitBrandItem = {};
		
			hitBrandItem.modelno = modelno;
			hitBrandItem.minprice = minprice;
			hitBrandItem.choice_cause = choice_cause;
			hitBrandItem.modelname = modelname;
			if(goods_image.indexOf("http:") > -1 ){
				hitBrandItem.goods_image = goods_image;	
			}else{
				hitBrandItem.goods_image = imgRoot + goods_image;
			}
			
			modelnoAry[hitBrandModelCnt] = hitBrandItem;
			hitBrandModelCnt++;
		});
	}
	
	
	if(hitBrandModelCnt>=3) {
		var hitBrandDivObj = $(".hitbrand-box");
		
		var html = [];
		var hIdx = 0;
		
		html[hIdx++] ="	<h1><i class=\"ico-hitbrand--medal lp__sprite\"></i>2021 상반기 에누리 히트 브랜드</h1>";
		html[hIdx++] ="	<div class=\"hitbrand-box__inner\">";
		html[hIdx++] ="		<div class=\"hitbrand-box__brand\">";
		//						<!-- 브랜드 로고 -->
		html[hIdx++] ="			<h2 class=\"hitbrand-box__brand--logo\">";
		html[hIdx++] ="				<img src=\""+(imgRoot+p_brand_image)+"\" alt=\""+p_brand+"\" />";
		html[hIdx++] ="			</h2>";
		//						<!-- 브랜드 설명 -->
		html[hIdx++] = p_brand_des;
		html[hIdx++] ="		</div>";
		html[hIdx++] ="		<div class=\"hitbrand-box__prod\">";
		//						<!-- 베스트 상품 -->
		html[hIdx++] ="			<a href=\"/detail.jsp?modelno="+modelnoAry[0].modelno+"\" class=\"hitbrand-box__item--best\" target=\"_blank\">";
		html[hIdx++] ="				<div class=\"hitbrand-box__thumb\">";
		html[hIdx++] ="					<i class=\"ico-hitbrand--best lp__sprite\">BEST</i>";
		html[hIdx++] ="					<img src=\""+modelnoAry[0].goods_image+"\" alt=\""+modelnoAry[0].modelname+"\">";
		html[hIdx++] ="				</div>";
		html[hIdx++] ="				<div class=\"hitbrand-box__info\">"; // 
		html[hIdx++] ="					<div class=\"hitbrand-box__tag\">"+p_choice_part+"</div>";
		html[hIdx++] ="					<div class=\"hitbrand-box__name\">"+modelnoAry[0].modelname+"</div>";
		html[hIdx++] ="					<div class=\"hitbrand-box__price\">최저가 <em>"+modelnoAry[0].minprice.format()+"</em>원</div>";
		html[hIdx++] ="				</div>";
		html[hIdx++] ="			</a>";
		//						<!-- 상품2개 -->
		html[hIdx++] ="			<ul class=\"hitbrand-box__list\">";
		html[hIdx++] ="				<li>";
		html[hIdx++] ="					<a href=\"/detail.jsp?modelno="+modelnoAry[1].modelno+"\" class=\"hitbrand-box__item\" target=\"_blank\">";
		html[hIdx++] ="						<div class=\"hitbrand-box__thumb\">";
		html[hIdx++] ="							<img src=\""+modelnoAry[1].goods_image+"\" alt=\""+modelnoAry[1].modelname+"\">";
		html[hIdx++] ="						</div>";
		html[hIdx++] ="						<div class=\"hitbrand-box__info\">";
		html[hIdx++] ="							<div class=\"hitbrand-box__name\">"+modelnoAry[1].modelname+"</div>";
		html[hIdx++] ="							<div class=\"hitbrand-box__price\">최저가 <em>"+modelnoAry[1].minprice.format()+"</em>원</div>";
		html[hIdx++] ="						</div>";
		html[hIdx++] ="					</a>";
		html[hIdx++] ="				</li>";
		html[hIdx++] ="				<li>";
		html[hIdx++] ="					<a href=\"/detail.jsp?modelno="+modelnoAry[2].modelno+"\" class=\"hitbrand-box__item\" target=\"_blank\">";
		html[hIdx++] ="						<div class=\"hitbrand-box__thumb\">";
		html[hIdx++] ="							<img src=\""+modelnoAry[2].goods_image+"\" alt=\""+modelnoAry[2].modelname+"\">";
		html[hIdx++] ="						</div>";
		html[hIdx++] ="						<div class=\"hitbrand-box__info\">";
		html[hIdx++] ="							<div class=\"hitbrand-box__name\">"+modelnoAry[2].modelname+"</div>";
		html[hIdx++] ="							<div class=\"hitbrand-box__price\">최저가 <em>"+modelnoAry[2].minprice.format()+"</em>원</div>";
		html[hIdx++] ="						</div>";
		html[hIdx++] ="					</a>";
		html[hIdx++] ="				</li>";
		html[hIdx++] ="			</ul>";
		//						<!-- // -->
		html[hIdx++] ="		</div>";
		html[hIdx++] ="	</div>";
		html[hIdx++] ="	<a href=\"/eventPlanZone/jsp/HitBrand_202106.jsp\" class=\"hitbrand-box__btn--view\" target=\"_blank\">수상 브랜드 보기 <i class=\"ico-rarr--sm--white lp__sprite\"></i></a>";
		
		
		hitBrandDivObj.html(html.join(""));
		hitBrandDivObj.show();
	}
}

//히트브랜드 API 호출 실패시
function failHitBrand(errorObj) {
	console.log( "HitBrand API Call Fail : " + errorObj.statusText);
	drawNoData();
}

//프린터 모델번호 API 호출
function loadPrinterModelNo() {
	
	var printerDataPromise = $.ajax({
		type : "GET",
		url : "/wide/api/prtModel.jsp",
		dataType : "json",
		data : {
			"prtModelNo" : param_prtmodelno
		}
	});
	
	printerDataPromise.then(drawPrinter, failPrinter);
}

// 프린터 영역 그리기
function drawPrinter(dataObj) {
	
	// 예외처리
	if(dataObj.success===undefined || !dataObj.success) {
		return;
	}
	if(dataObj.data===undefined || dataObj.total===undefined) {
		return;
	}
	
	var printerDivObj = $(".list-filter--finder");
	
	var html = [];
	var hIdx = 0;
	
	// 프린터 영역 은 필터를 따로 관리함.
	html[hIdx++] ="	<div class=\"list-filter__head\">";
	html[hIdx++] ="		<dl>";
	html[hIdx++] ="			<dt>프린터 · 복합기 <em class=\"tx--count\">"+param_prtSrcKey+"</em> 검색결과</dt>";
	html[hIdx++] ="			<dd>"+dataObj.data.modelname+"</dd>";
	html[hIdx++] ="		</dl>";
	html[hIdx++] ="		<button class=\"btn--search-more\" onclick=\"javascript:getInkfinder('"+param_prtSrcKey+"');\">검색결과 전체보기 <i class=\"ico-adv-rarr lp__sprite\"></i></button>";
	//					<!-- 필터 > 우측 고정 메뉴 -->
	html[hIdx++] ="		<div class=\"list-filter-side\">";
	//						<!-- 상품 리스트 > 필터 > 정렬 -->
	html[hIdx++] ="			<ul class=\"list-filter__sort\">";
	html[hIdx++] ="				<li class=\"sortFilter is--on\" sortType=\"1\">";
	html[hIdx++] ="					<a href=\"javascript:void(0);\">인기순</a>";
	//								<!-- 툴팁 : 마우스 오버시 노출 -->
	//								<!-- 인기순 -->
	html[hIdx++] ="					<div class=\"lay-filter-tip\">";
	html[hIdx++] ="						<dl>";
	html[hIdx++] ="							<dt>TIP</dt>";
	html[hIdx++] ="							<dd><em>\"인기순\"</em>은 최근 1주일 동안의 <em>가격비교창</em>과 <em>주문버튼 클릭 수,</em><br><em>판매량</em>을 집계하여 합리적인 비례계산 시스템에 의해 만들어진 순위<br><em>*클릭수 조작 및 광고등을 통한 인위적인 조작 불가능함</em></dd>";
	html[hIdx++] ="						</dl>";
	html[hIdx++] ="					</div>";
	//								<!-- // -->
	html[hIdx++] ="				</li>";
	html[hIdx++] ="			</ul>";
	//						<!-- // -->
	//						<!-- 상품리스트 > 필터 > 뷰타입 -->
	html[hIdx++] ="			<div class=\"list-filter__view\">";
	html[hIdx++] ="				<ul class=\"view-type\">";
	html[hIdx++] ="					<li gridType=\"1\" class=\"is--on\"><a href=\"javascript:void(0);\"><i class=\"ico-type-list lp__sprite\">리스트타입</i></a></li>";
	html[hIdx++] ="					<li gridType=\"2\"><a href=\"javascript:void(0);\"><i class=\"ico-type-grid lp__sprite\">그리드타입</i></a></li>";
	html[hIdx++] ="				</ul>";
	html[hIdx++] ="			</div>";
	//						<!-- // -->   
	html[hIdx++] ="		</div>";
	//					<!-- // -->   
	html[hIdx++] ="	</div>";
	html[hIdx++] ="	<div class=\"list-filter__prod type--list\">";
	html[hIdx++] ="		<div class=\"goods-item\">";
	//						<!-- 썸네일 -->
	html[hIdx++] ="			<div class=\"item__thumb\">";
	html[hIdx++] ="				<a href=\"/detail.jsp?modelno="+param_prtmodelno+"\" class=\"goods-item\" target=\"_blank\">";
	html[hIdx++] ="					<img src=\""+dataObj.data.image+"\" alt=\""+dataObj.data.modelname+"\" onerror=\"this.src='"+noImageStr+"';\">";
	html[hIdx++] ="				</a>";
	html[hIdx++] ="			</div>";
	//						<!-- // --> 
	html[hIdx++] ="		</a>";
	html[hIdx++] ="		<div class=\"item__box\">";
	//						<!-- 상품정보 -->
	html[hIdx++] ="			<div class=\"item__info\">";
	//							<!-- 모델명 -->
	html[hIdx++] ="				<div class=\"item__model\">";
	html[hIdx++] ="					<a href=\"/detail.jsp?modelno="+param_prtmodelno+"\" class=\"goods-item\" target=\"_blank\">"+dataObj.data.modelname+"</a>";
	html[hIdx++] ="				</div>";
	//							<!-- 속성 -->
	html[hIdx++] ="				<ul class=\"item__attr\">";
	
	// 프린터 데이터 <b> 태그는 엔터키를 강제로 삽입
	html[hIdx++] = makerSpecTagDic(dataObj.data.spec);
	html[hIdx++] ="				</ul>";
	html[hIdx++] ="			</div>";
	//						<!-- // -->
	//						<!-- 상품가격 : 프린터복합기로 검색시 -->
	html[hIdx++] ="			<div class=\"item__price\">";
	//							<!-- 가격있을때 -->
	if(dataObj.data.price > 0){ // dataObj.data.price.format() 
		html[hIdx++] ="			<div class=\"price__mall\">";
		//							<!-- 가격 -->
		html[hIdx++] ="				<div class=\"col--price\">";
		html[hIdx++] ="					<a href=\"/detail.jsp?modelno="+param_prtmodelno+"\"><em>"+dataObj.data.price.format()+"</em>원</a>";
		html[hIdx++] ="				</div>";
		html[hIdx++] ="			</div>";
	//							<!-- 품절/출시예정 등 예외케이스 -->
	}else{
		html[hIdx++] ="			<div class=\"price--exception\">";
		html[hIdx++] ="				<div class=\"col--price\">";
		html[hIdx++] ="					<a href=\"/detail.jsp?modelno="+param_prtmodelno+"\">단종/품절</a>";
		html[hIdx++] ="				</div>";
		html[hIdx++] ="			</div>";
	}
	
	html[hIdx++] ="			</div>";
	html[hIdx++] ="		</div>";
	html[hIdx++] ="	</div>";
	
	printerDivObj.html(html.join(""));
	printerDivObj.show();
	
	
	//<!-- [LP] 복합기(0402) 파인터 검색결과 / 필터+대표 상품-->
	// $(".list-filter--finder")
	
}

//프린터 API 호출 실패시
function failPrinter(errorObj) {
	console.log( "printer API Call Fail : " + errorObj.statusText);
	drawNoData();
}

//리스트 에서 후처리로 처리되는 함수들
function loadListAddData() {
	if(modelNoSet && modelNoSet.size>0) {
		// 표준PC
		if(viewType==1) {
			if(listType=="search") {
				set_enuripc();
			} else if(listType=="list") {
				//LP일때 사용하는 카테고리만 해당 function 사용
				if(",0405,0707,0708,0713,0703,0705,0711,0704,071307,071306,0414,".indexOf(","+param_cate+",") > -1){
					set_enuripc();
				}
			}
		}
	}
	
	// 프린터 검색결과 호출
	if(param_prtmodelno.length>0) {
		loadPrinterModelNo();
	}
	
	if(listType=="search") {
		// SRP 키워드 브랜드 광고
		loadKeywordAd();
	}
	
	$("span.tag--rank, span.tag--ad").closest("div").addClass("has--tag");
	
	
}

// 분류검색어 정보 호출
function loadFromSearch() {

	if( Synonym_From == "search" && Synonym_Keyword.length > 0 ) {
		
		// API 호출
		var fromSearchPromise = $.ajax({
			type : "GET",
			url : "/lsv2016/ajax/getSubCateList_Ajax.jsp",
			dataType : "json",
			data : {
				"cate" : param_cate,
				"pType" : "CT"
			}
		});
		
		fromSearchPromise.then(drawFromSearch, failFromSearch);
	} else {
		return;
	}
}

// 분류검색어 그리기
function drawFromSearch(dataObj) {
	
	if(dataObj!="") {
		var keyword = ""; // 분류 검색어
		var fromSearchObj = $(".category-from-search");
		
		if(dataObj.c_name4 != "") {
			keyword = dataObj.c_name4;
		} else if(dataObj.c_name3 != "") {
			keyword = dataObj.c_name3;
		} else if(dataObj.c_name2 != "") {
			keyword = dataObj.c_name2;
		}
		
		if(keyword.length>0) {
		
			var html = [];
			var hIdx = 0;
		
			html[hIdx++] = "<span class=\"tx--msg\">현재 <em>"+keyword+"</em> 카테고리를 보고 계십니다.</span>";
			html[hIdx++] = "<div class=\"category-from-search--side\">";
			html[hIdx++] = "	<dl class=\"category-from-search__keyword\">";
			//						<!-- 검색어 -->
			html[hIdx++] = "		<dt><i class=\"ico-tit-search-word lp__sprite\">검색어</i></dt>";
			html[hIdx++] = "		<dd>"+Synonym_Keyword+"</dd>";
			//						<!-- 동의어 -->
			html[hIdx++] = "		<dt><i class=\"ico-tit-synonym lp__sprite\">동의어</i></dt>";
			html[hIdx++] = "		<dd data-type=\"synonym\"></dd>";
			html[hIdx++] = "	</dl>";
			//					<!-- 버튼 : 검색어 검색 -->
			html[hIdx++] = "	<a href=\"/search.jsp?keyword="+Synonym_Keyword+"&from=list\" class=\"btn--to-search\">검색어 관련 모든 검색결과 보기 <i class=\"ico-rarr-blue--sm lp__sprite\">></i></a>";
			//					<!-- // -->
			html[hIdx++] = "</div>";
			
			fromSearchObj.html(html.join("")).show();
			
			var synonymUrl = "/lsv2016/ajax/getSubCateList_Ajax.jsp?cate="+param_cate+"&pType=SK&keyword="+Synonym_Keyword;
			$.getJSON(synonymUrl, function(synonymData){
				if(synonymData.cateSynonym !== undefined && synonymData.cateSynonym.length>0) {
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
	console.log( "분류검색어 API Call Fail : " + errorObj.statusText);
}