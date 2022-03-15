// 제조사,브랜드 정렬 변경
var boxDataBrandPopularHtml = "";
var boxDataFactoryPopularHtml = "";
var brandTmpSet = new Set(); // 인기순, 가나다 파인더 변경시 저장 목적
var factoryTmpSet = new Set(); // 인기순, 가나다 파인더 변경시 저장 목적
var brandNameSet = new Set(); // 이름순 브랜드 저장목록
var factoryNameSet = new Set(); // 이름순 제조사 저장목록

$(document).on("click", ".search-box__sort button",function() {

	// 활성화 된 탭일 경우 실행하지 않음
	if($(this).hasClass("is--selected")) {
		return;
	}

	var isName = $(this).hasClass('btn-sort--name');
	var isPopular = $(this).hasClass('btn-sort--pop');
	var boxSeq = $(this).closest('.search-box-row').find(".search-box__sort--seq");
	var boxData = $(this).closest('.search-box-row').find(".search-box__list li");
	if($(this).closest('.search-box-row').find(".search-box__list").length>1) {
		boxData = $(this).closest('.search-box-row').find(".search-box__inner>.search-box__list li");
	}
	var dataType = $(this).closest(".search-box__sort").attr("data-sort");
	
	if(isName && $(boxSeq).find("ul").length==0) {
		var listData = null;
		var listNameOrder = null;
		var selectArray = null;
		
		if(dataType=="factory") { // 제조사
			listData = factoryAttrList;
			if(boxDataFactoryPopularHtml.length==0) { // 초기 인기순 HTML 을 저장
				boxDataFactoryPopularHtml = $("dl[data-attr-type=factory] .search-box__inner .search-box__list")[0].innerHTML;
			}
		} else if(dataType=="brand") {
			listData = brandAttrList;
			if(boxDataBrandPopularHtml.length==0) { // 초기 인기순 HTML 을 저장
				boxDataBrandPopularHtml = $("dl[data-attr-type=brand] .search-box__inner .search-box__list")[0].innerHTML;
			}
		}
		
		listNameOrder = objectNameSort(listData, dataType);
		selectArray = objectNameSelector(listNameOrder);
		
		var resetHtml = [];
		var resetIndex = 0;
		$(listNameOrder).each(function(index, item) {
			if(dataType=="factory") {
				resetHtml[resetIndex++] = "<li class=\"attrs\" data-attr=\"factory_"+factoryNameToCodeMap.get(item)+"\">";
				resetHtml[resetIndex++] = "	<input type=\"checkbox\" id=\"chFactory_"+index+"\" class=\"input--checkbox-item\">";
				resetHtml[resetIndex++] = "	<label for=\"chFactory_"+index+"\" title=\""+item+"\">"+item+"</label>";
				factoryNameSet.add(item);
				
			} else if(dataType=="brand") {
				resetHtml[resetIndex++] = "<li class=\"attrs\" data-attr=\"brand_"+regSpecExp(item)+"\">";
				if(!brandReqMap.has(item)) {
					resetHtml[resetIndex++] = "	<input type=\"checkbox\" id=\"chBrand_"+index+"\" class=\"input--checkbox-item\">";
					resetHtml[resetIndex++] = "	<label for=\"chBrand_"+index+"\" title=\""+item+"\">"+item+"</label>";
					brandNameSet.add(item);
				}
			}
			resetHtml[resetIndex++] = "</li>";
		});
		if(resetHtml.length>0) {
			$(this).closest('.search-box-row').find(".search-box__inner .search-box__list").empty().html(resetHtml.join(""));
		}
		
		var html = [];
		var hIdx = 0;
		
		// <!-- 가나다 Finder -->
		if(selectArray[0].length>0 && selectArray[1]) {
			
			html[hIdx++] = "<ul class=\"kr-consonant list--consonant\">";
			html[hIdx++] = "	<li><button class=\"btn--consonant is--all is--selected\">전체</button></li>";
			
			// i == 아스키코드
			for(var i=0;i<selectArray[0].length;i++) {
				if(selectArray[0][i]!==undefined) {
					html[hIdx++] = "<li><button class=\"btn--consonant\" data-char=\""+i+"\">"+selectArray[0][i]+"</button></li>";
				}
			}
			
			if(selectArray[3]) {
				html[hIdx++] = "<li><button class=\"btn--consonant-en\" onclick=\"$(this).closest('.search-box__sort--seq').find('ul').toggle();\">ABC</button></li>";
			}
			
			html[hIdx++] = "</ul>";
		}
		
		//	<!-- 알파벳 Finder -->
		if(selectArray[2].length>0 && selectArray[3]) {
			
			html[hIdx++] = "<ul class=\"kr-consonant list--consonant\" style=\"display:none;\">";
			html[hIdx++] = "	<li><button class=\"btn--consonant is--all is--selected\">전체</button></li>";
			
			// i == 아스키코드
			for(var i=0;i<selectArray[2].length;i++) {
				if(selectArray[2][i]!==undefined) {
					html[hIdx++] = "<li><button class=\"btn--consonant\" data-char=\""+i+"\">"+selectArray[2][i]+"</button></li>";
				}
			}
			
			// 숫자
			if(selectArray[4]) {
				html[hIdx++] = "<li><button class=\"btn--consonant num\">0~9</button></li>";
			}
			
			if(selectArray[1]) {
				html[hIdx++] = "<li><button class=\"btn--consonant-en\" onclick=\"$(this).closest('.search-box__sort--seq').find('ul').toggle();\">ㄱㄴㄷ</button></li>";
			}
			
			html[hIdx++] = "</ul>";
		}
		
		$(boxSeq).html(html.join(""));
		
		// 데이터에 char 코드 매핑
		$(boxData).each(function(index, item) {
			var itemName = $(this).find("label").attr("title");
			if(itemName.length>0) {
				var charCode = objectNameSelect(itemName.charCodeAt(0));
				
				if(dataType=="brand") {
					if(charCode>=0) {
						$("li.attrs[data-attr='brand_"+regSpecExp(itemName)+"']").attr("data-char", charCode);
					} 
					if(itemName.charCodeAt(0)>=48 && itemName.charCodeAt(0)<=57) {
						$("li.attrs[data-attr='brand_"+regSpecExp(itemName)+"']").attr("data-char", itemName.charCodeAt(0));
					}
				} else if(dataType=="factory") {
					if(charCode>=0) {
						$("li.attrs[data-attr='factory_"+factoryNameToCodeMap.get(itemName)+"']").attr("data-char", charCode);
					} 
					if(itemName.charCodeAt(0)>=48 && itemName.charCodeAt(0)<=57) {
						$("li.attrs[data-attr='factory_"+factoryNameToCodeMap.get(itemName)+"']").attr("data-char", itemName.charCodeAt(0));
					}
				}
			}
		});
	} else if(isName) {
		
		var resetHtml = [];
		var resetIndex = 0;
		if(dataType=="factory") {
			factoryNameSet.forEach(function(item) {
				resetHtml[resetIndex++] = "<li class=\"attrs\" data-attr=\"factory_"+factoryNameToCodeMap.get(item)+"\">";
				resetHtml[resetIndex++] = "	<input type=\"checkbox\" id=\"chFactory_"+index+"\" class=\"input--checkbox-item\">";
				resetHtml[resetIndex++] = "	<label for=\"chFactory_"+index+"\" title=\""+item+"\">"+item+"</label>";
				resetHtml[resetIndex++] = "</li>";
			});
		} else if(dataType=="brand") {
			brandNameSet.forEach(function(item) {
				resetHtml[resetIndex++] = "<li class=\"attrs\" data-text=\""+regSpecExp(item)+"\">";
				resetHtml[resetIndex++] = "	<input type=\"checkbox\" id=\"chFactory_"+index+"\" class=\"input--checkbox-item\">";
				resetHtml[resetIndex++] = "	<label for=\"chFactory_"+index+"\" title=\""+item+"\">"+item+"</label>";
				resetHtml[resetIndex++] = "</li>";
			});
		}
		if(resetHtml.length>0) {
			$(this).closest('.search-box-row').find(".search-box__inner .search-box__list").empty().html(resetHtml.join(""));
		}
	
	} else if(isPopular) {
		
		$(boxSeq).empty();
		
		if(dataType=="factory") { // 제조사
			$(".search-box-row[data-attr-type=factory]").find(".search-box__inner .search-box__list").empty().html(boxDataFactoryPopularHtml);
		} else if(dataType=="brand") { // 브랜드
			$(".search-box-row[data-attr-type=brand]").find(".search-box__inner .search-box__list").empty().html(boxDataBrandPopularHtml);
		}
	}
	
	$(this).addClass("is--selected").siblings().removeClass("is--selected");
	( isName ) ? boxSeq.show() : boxSeq.hide();
	
	brandTmpSet.forEach(function(item) {
		if( $(".btn-sort--name").hasClass("is--selected") ) {
			$("li.attrs[data-attr=brand_"+ regSpecExp(item) +"]").addClass("sel");
			$("li.attrs[data-attr=brand_"+ regSpecExp(item) +"]").find("input").prop("checked", true);
		} else {
			$("li.attrs[data-text="+ regSpecExp(item) +"]").addClass("sel");
			$("li.attrs[data-text="+ regSpecExp(item) +"]").find("input").prop("checked", true);
		}
	});
	factoryTmpSet.forEach(function(item) {
		$("li.attrs[data-attr=factory_"+item+"]").addClass("sel");
		$("li.attrs[data-attr=factory_"+item+"]").find("input").prop("checked", true);
	});
	
	
});

// 가나다,ABC 보기
$(document).on("click", "button.btn--consonant", function() {
	$(this).closest(".list--consonant").find("li button").removeClass("is--selected");
	$(this).addClass("is--selected");
	var searchBodyItem = $(this).closest(".search-box__body").find(".search-box__inner");
	var $thisChar = $(this).attr("data-char");
	
	if( $(this).hasClass("is--all") ) {
		searchBodyItem.find("li").show();
	} else if( $(this).hasClass("num") ) {
		searchBodyItem.find("li").hide();
		//  firstASC>=48 && firstASC<=57
		for(var asc=48; asc<=57; asc++) {
			searchBodyItem.find("li[data-char="+asc+"]").show();
		}
	} else {
		searchBodyItem.find("li").hide();
		searchBodyItem.find("li[data-char="+$thisChar+"]").show();	
	}
});
// 속성 클릭 시
$(document).on("click", "li.attrs label, li.attrs button, li.attrs a, button.btn--range-search, button.btn--key-deleted, button.list-filter__search--btn", function() {
	var attr = null;
	var attrType = ""; // 속성 유형
	var attrData1 = ""; // 유형 데이터1 
	var attrData2 = ""; // 유형 데이터2 ( range 검색 시 사용 )
	var attrMode = ""; // plus 추가 ( sel 클래스 추가 ) , minus 삭제 ( sel 클래스 삭제 ) 
	/*
	attr : spec_21863_코어i7 11세대
	attr : price_0_70000
	attr : reqKwd_갤럭시S21
	attr : brand_삼성전자
	attr : factory_삼성전자
	attr : shop_5910_11번가
	attr : discount_70~100
	attr : bbsscore_3
	inKwd // 결과내 검색 
	*/
	
	if(!$(this).hasClass("btn--range-search") && !$(this).hasClass("btn--key-deleted")) {
		attr = $(this).closest("li").attr("data-attr");
	} else {
		attr = $(this).attr("data-attr");
	}
	
	// 스마트파인더 아이콘 클릭
	if($(this).attr("data-type")!==undefined && $(this).attr("data-type")=="smartfinder_button") {
		
		var $ul = $(this).closest("ul.search-box__list");
		var $li = $(this).closest("li.attrs");
		
		if($(this).closest("li").attr("data-attr")!="spec_all") {

			// on -> off 처리 시
			if($li.hasClass("sel")) {
				$(this).find(".ico_thum img").attr("src", $(this).attr("data-off-image"));
				$li.removeClass("sel");
				attrMode = "minus";
				
			// off -> on 처리 시
			} else {
				$(this).find(".ico_thum img").attr("src", $(this).attr("data-on-image"));
				$li.addClass("sel");
				attrMode = "plus";
			}
		// 전체보기
		} else {
		
			// 선택된 스마트파인더 속성 없는"
			if($(".finder-icon__list li.sel").not("[data-attr=spec_all]").length==0) {
				return;
			}
		
			// on -> off 처리 시
			var calcAttrSelCnt = 0;
			if($li.hasClass("sel")) {
				$(this).find(".ico_thum img").attr("src", $(this).attr("data-off-image"));
				$li.removeClass("sel");
			// off -> on 처리 시
			} else {

				$ul.find("li.sel").each(function(index, item) {
					
					var offImageUrl = $(item).find("button").attr("data-off-image");
					var specCode = $(this).attr("data-spec");
					
					$(item).find("button .ico_thum img").attr("src", offImageUrl);
					$(item).removeClass("sel");
					$("button[data-attr=spec_"+specCode+"]").closest("li").remove();
					
					calcAttrSelCnt++;
				});

				$(this).find(".ico_thum img").attr("src", $(this).attr("data-on-image"));
				$li.addClass("sel");
			
				if(calcAttrSelCnt>0) {
					attrSelCnt = attrSelCnt-calcAttrSelCnt;
				}
			
			}
			
			if(calcAttrSelCnt>0) {
				$("#attrSelCnt").text(attrSelCnt);
				param_pageNum = 1;
				loadGoods();
				if(attrSelCnt==0) {
				$(".row-selected--condition").hide();
				} else {
					$(".row-selected--condition").show();
				}
			}
			return false;
		}
	}
	
	if($(this).hasClass("btn--dic")) { 
		lightTermdic(this);
		return false;
	}
	
	if($(this).hasClass("btn--key-deleted")) {
		attrMode = "minus";
		var splitAttr = attr.split("_");
		if(attr.indexOf("reqKwd")>-1) {
			$("li.attrs.reqKwd[data-attr="+attr+"]").removeClass("sel");
			$("li.attrs.reqKwd[data-attr="+attr+"] button").removeClass("is--active");
		} else if(attr.indexOf("spec")>-1) {
			$("li[data-spec="+splitAttr[1]+"]").removeClass("sel");
		} else if(attr.indexOf("color")>-1) {
			$("li[data-color="+splitAttr[1]+"]").removeClass("sel");
			
			//색상코드 추가
			if($("li[data-color="+splitAttr[1]+"] button").hasClass("btn-color")) {
				$("li[data-color="+splitAttr[1]+"] button").parent("li").removeClass("is-on");
			}
		} else if(attr.indexOf("discount")>-1) {
			var discountStartVal = splitAttr[1].split("~");
			$("li[data-discount-start="+discountStartVal[0]+"]").removeClass("sel");
		} else {
			$("li[data-attr="+attr+"]").removeClass("sel");
		}
	// 스마트파인더
	} else if($(this).closest("ul.finder-icon__list").length>0) {	
		if($(this).closest("li").hasClass("sel")) {
			attrMode = "plus";
		} else {
			attrMode = "minus";
		}
	} else if(!$(this).hasClass("btn--range-search")) {
		if( $(this).closest("li").hasClass("sel") || $(this).hasClass("is--active") ) {
			attrMode = "minus";
			// 삭제 시 판단 유무
			if($(this).closest("li").hasClass("sel")) {
				$(this).closest("li").removeClass("sel");
			}
			
			//색상코드 추가
			if($(this).hasClass("btn-color")) {
				$(this).parents("li").removeClass("is-on");
			}
		} else {
			attrMode = "plus";
			
			// 가격대 sel 제거
			if( attr && attr.indexOf("price") > -1 ) {
				$(".search-box__range--price li").removeClass("sel");
				$(".search-box__range--price li button").removeClass("is--active");
			}
			
			// 추천키워드 sel 제거
			if( attr && attr.indexOf("reqKwd") > -1 ) {
				$("li.attrs.reqKwd").removeClass("sel");
			}
			
			$(this).closest("li").addClass("sel"); // 삭제 시 판단 유무
			
			//색상코드 추가
			if($(this).hasClass("btn-color")) {
				$(this).parents("li").addClass("is-on");
			}
		}
	}
	
	// 명품카테 선택 시 활성화 is--on 클래스 추가
	if($(this).hasClass("luxury")) {
		if($(this).closest("li").hasClass("is--on")) {
			attrMode = "minus";
			$(this).closest("li").removeClass("is--on");
		} else {
			attrMode = "plus";
			$(this).closest("li").addClass("is--on");
		}
	}
	
	// SRP 추천브랜드
	if($(this).hasClass("r-brand")) {
		if($(this).closest("li").hasClass("is--on")) {
			$(this).closest("li").removeClass("is--on");
		} else {
			$(this).closest("li").addClass("is--on");
		}
	}
	
	if(attr != null && attr.indexOf("_")>-1) { 	
		var splitAttr = attr.split("_");
		// 속성 유형
		attrType = splitAttr[0];
		
		switch(attrType) {
			case "factory" : 
				attrData1 = splitAttr[1];
				break;
			case "brand" : 
				attrData1 = splitAttr[1];
				break;
			case "shop" : 
				attrData1 = splitAttr[2]; // 쇼핑몰 이름
				attrData2 = splitAttr[1]; // 쇼핑몰 코드 , 실제 검색 시 사용
				break;
			case "spec" : 
				attrData1 = attr.replace("spec_"+splitAttr[1]+"_", ""); // 속성 이름
				attrData2 = splitAttr[1]; // 속성 코드 , 실제 검색 시 사용
				break;
			case "color" : 
				attrData1 = attr.replace("color_"+splitAttr[1]+"_", ""); // 속성 이름
				attrData2 = splitAttr[1]; // 속성 코드 , 실제 검색 시 사용
				break;
			case "price" : 
				attrData1 = splitAttr[1]; // 검색 최소 값
				attrData2 = splitAttr[2]; // 검색 최대 값
				break;
			case "reqKwd" : 
				attrData1 = splitAttr[1];
				break;
			case "discount" : 
				attrData1 = splitAttr[1];
				break;
			case "bbsscore" : 
				attrData1 = splitAttr[1];
				break;
		}
	}
	
	// 가격 검색 버튼 클릭
	if($(this).hasClass("btn--range-search")) {
		attrMode = "plus";
		var priceListDivObj = $(this).closest(".search-box__range--search");
		var startPriceInput = priceListDivObj.find(".start_price").val();
		var endPriceInput = priceListDivObj.find(".end_price").val();

		if(startPriceInput===undefined || endPriceInput===undefined || startPriceInput.length==0 || endPriceInput.length==0) {
			
			if(endPriceInput!==undefined && endPriceInput.length>0) {
				startPriceInput = "0";
			} else {
				alert("가격을 입력하여 주십시오.");
				return;
			}
		}

		//문자 입력시 리턴
		if(isNaN(startPriceInput.split(",").join("")) == true){
			alert("숫자만 입력하여 주십시오.");
			return;
		}
		if(isNaN(endPriceInput.split(",").join("")) == true){
			alert("숫자만 입력하여 주십시오.");
			return;
		}

		var intSPrice = 0;
		var intEPrice = 0;
		try {
			intSPrice = parseInt(startPriceInput.split(",").join(""));
		} catch(e) {}
		try {
			intEPrice = parseInt(endPriceInput.split(",").join(""));
		} catch(e) {}
		if(intSPrice > intEPrice) {
			alert("가격을 확인해주십시오.\r\n시작가격은 마지막 가격보다 클 수 없습니다.");
			return;
		}
		if(intEPrice>999999999) {
			alert("가격 검색 범위가 너무 큽니다");
			return;
		}
		attrType = "price";
		attrData1 = intSPrice; // 검색 최소 값
		attrData2 = intEPrice; // 검색 최대 값
		
		$(".search-box__range--price li").removeClass("sel"); // 가격대 깍두기 영역 sel 클래스 제거
		$(".search-box__range--price li button").removeClass("is--active");
		$(".search-box__range--price li[data-attr=price_"+attrData1+"_"+attrData2+"]").addClass("sel");
		$(".search-box__range--price li[data-attr=price_"+attrData1+"_"+attrData2+"] button").addClass("is--active");
	}
	
	// 결과내검색
	if($(this).hasClass("list-filter__search--btn")) {
		attrMode = "plus";
		attrType = "inKwd";
		var $searchObj = $(".list-filter__search--input");
		var inputTxt = $.trim($searchObj.val()); 
		attr = inputTxt;
		
		if(inputTxt.trim().length==0) {
			alert("검색어를 입력해주세요");
			return false;
		}
		
		if(listType=="list") {
			insertLogLSV(14235, param_cate); // LP>결과내검색 클릭수
		} else if(listType=="search") {
			insertLogLSV(14429); // SRP>결과내검색 클릭수
		}
	}
	
	var selTxtDiv = $(".row-selected--condition .search-box__keyword");
	var vTxtname = $.trim($(this).text());
	
	// 선택한 조건 추가
	if( attrMode=="plus" ) {
	
		var selAppendHtml = "";
		var qstrObj = {};
		
		switch(attrType) {
			case "factory" : 
				if(param_factory.length==0) {
					param_factory = vTxtname;
				} else {
					param_factory += ","+vTxtname;
				}
				if(param_factorycode.length==0) {
					param_factorycode = attrData1;
				} else {
					param_factorycode += ","+attrData1;
				}
				selAppendHtml = "<li data-type=\"factory\">";
				selAppendHtml += "	<span class=\"tx--selected\">"+vTxtname+"</span>";
				selAppendHtml += "	<button class=\"btn--key-deleted lp__sprite\" data-attr=\"factory_"+attrData1+"\">"+vTxtname+"</button>";
				selAppendHtml += "</li>";
				
				factoryTmpSet.add(attrData1);
				
				qstrObj["fbName"] = vTxtname;
				qstrObj["attType"] = "factory";
				
				recentSpec = "factory_" + attrData1;
				
				break;
			case "brand" : 
				// SRP 추천브랜드
				if($(this).hasClass("r-brand")) {
					attrData1 = $(this).closest("li").attr("data-attr").replace("brand_","");
					vTxtname = $(this).closest("li").attr("data-text");
				}
				
				if(param_brand.length==0) {
					param_brand = vTxtname;
				} else {
					param_brand += ","+vTxtname;
				}
				if(param_brandcode.length==0) {
					param_brandcode = attrData1;
				} else {
					param_brandcode += ","+attrData1;
				}
				
				selAppendHtml = "<li data-type=\"brand\">";
				selAppendHtml += "	<span class=\"tx--selected\">"+vTxtname+"</span>";
				selAppendHtml += "	<button class=\"btn--key-deleted lp__sprite\" data-attr=\"brand_"+attrData1+"\" data-text=\""+regSpecExp(vTxtname)+"\">"+vTxtname+"</button>";
				selAppendHtml += "</li>";
				
				brandTmpSet.add(vTxtname);
				
				// LP 추천브랜드
				if(brandReqMap.has(vTxtname)) {
					$("ul.list__luxury li[data-text="+regSpecExp(vTxtname)+"]").addClass("sel").addClass("is--on");
				}
				
				qstrObj["fbName"] = vTxtname;
				qstrObj["attType"] = "brand";
				
				recentSpec = "brand_" + attrData1;
				
				break;
			case "shop" : 
				if(param_shopcode.length==0) {
					param_shopcode = attrData2;
				} else {
					param_shopcode += ","+attrData2;
				}
				selAppendHtml = "<li data-type=\"shop\" shopcode=\""+attrData2+"\">";
				selAppendHtml += "	<span class=\"tx--selected\">"+attrData1+"</span>";
				selAppendHtml += "	<button class=\"btn--key-deleted lp__sprite\" data-attr=\"shop_"+attrData2+"_"+attrData1+"\">"+attrData1+"</button>";
				selAppendHtml += "</li>";
				
				qstrObj["shopcode"] = attrData2;
				qstrObj["attType"] = "shop";
				
				recentSpec = "";
				
				break;
			case "spec" : 
				specSet.add(attrData2);
				selAppendHtml = "<li data-type=\"spec\" speccode=\""+attrData2+"\">";
				selAppendHtml += "	<span class=\"tx--selected\">"+attrData1+"</span>";
				selAppendHtml += "	<button class=\"btn--key-deleted lp__sprite\" data-attr=\"spec_"+attrData2+"\">"+attrData1+"</button>";
				selAppendHtml += "</li>";
				
				qstrObj["specno"] = attrData2;
				qstrObj["attType"] = "spec";
				
				// 스마트파인더 아이콘 클릭
				if($(this).attr("data-type")!==undefined && $(this).attr("data-type")=="smartfinder_button") {
					$(this).find(".ico_thum img").attr("src", $(this).attr("data-on-image"));
				}
				
				// spec 전체보기 off 처리
				if($(this).closest("ul.search-box__list").find("li[data-attr=spec_all]").length>0) {
					var $allViewLi = $(this).closest("ul.search-box__list").find("li[data-attr=spec_all]");
					var $allViewOffImage = $allViewLi.find("button").attr("data-off-image");
					$allViewLi.removeClass("sel");
					$allViewLi.find(".ico_thum img").attr("src", $allViewOffImage);
				}
				
				// spec_{스펙번호}_{그룹번호}
				recentSpec = "spec_" + attrData2 + "_" + $(this).closest("dl.search-box-row").attr("data-index");
				
				specGroupSet.add( $(this).closest("dl.search-box-row").attr("data-index") );
				
				break;
			case "color" : 
				if(param_color.length==0) {
					param_color = attrData2;
				} else {
					param_color += ","+attrData2;
				}
				
				selAppendHtml = "<li data-type=\"color\" colorcode=\""+attrData2+"\">";
				selAppendHtml += "	<span class=\"tx--selected\">"+attrData1+"</span>";
				selAppendHtml += "	<button class=\"btn--key-deleted lp__sprite\" data-attr=\"color_"+attrData2+"\">"+attrData1+"</button>";
				selAppendHtml += "</li>";
				qstrObj["specno"] = attrData2;
				qstrObj["attType"] = "spec";
				
				recentSpec = "spec_" + attrData2 + "_" + $(this).closest("dl.search-box-row").attr("data-index");
				
				specGroupSet.add( $(this).closest("dl.search-box-row").attr("data-index") );
				
				break;
			case "price" : 
				param_sPrice = attrData1;
				param_ePrice = attrData2;
				if(selTxtDiv.find("li[data-type=price]").length>0) {
					selTxtDiv.find("li[data-type=price]").remove();
					attrSelCnt--;
				}
				var attrTxt = attrData1.format()+"~"+attrData2.format()+"원";
				if(attrData1=="0") {
					attrTxt = attrData2.format()+"원 이하";
				}
				if(attrData2=="999999999") {
					attrTxt = attrData1.format()+"원 이상";
				}
				
				selAppendHtml = "<li data-type=\"price\">";
				selAppendHtml += "	<span class=\"tx--selected\">"+attrTxt+"</span>";
				selAppendHtml += "	<button class=\"btn--key-deleted lp__sprite\" data-attr=\"price_"+attrData1+"_"+attrData2+"\">"+attrTxt+"</button>";
				selAppendHtml += "</li>";
				
				$(".search-box__range--search input.start_price").val(attrData1.format());
				$(".search-box__range--search input.end_price").val(attrData2.format());
				
				recentSpec = "";
				
				break;
			case "reqKwd" : 
				param_keyword = attrData1;
				if(selTxtDiv.find("li[data-type=reqKwd]").length>0) {
					selTxtDiv.find("li[data-type=reqKwd]").remove();
					attrSelCnt--;
				}
				$("li.attrs.reqKwd").find("button").removeClass("is--active");
				$(this).addClass("is--active");
				
				// 원본 데이터 ( 띄어쓰기 있는 ) 
				param_keyword = $(this).text();
				
				selAppendHtml = "<li data-type=\"reqKwd\">";
				selAppendHtml += "	<span class=\"tx--selected\">"+param_keyword+"</span>";
				selAppendHtml += "	<button class=\"btn--key-deleted lp__sprite\" data-attr=\"reqKwd_"+regSpecExp(attrData1)+"\">"+param_keyword+"</button>";
				selAppendHtml += "</li>";
				
				recentSpec = "";
				
				break;
			case "inKwd" :
				param_inKeyword = attr;
				if(selTxtDiv.find("li[data-type=inKwd]").length>0) {
					selTxtDiv.find("li[data-type=inKwd]").remove();
					attrSelCnt--;
				}
				selAppendHtml = "<li data-type=\"inKwd\">";
				selAppendHtml += "	<span class=\"tx--selected\">"+attr+"</span>";
				selAppendHtml += "	<button class=\"btn--key-deleted lp__sprite\" data-attr=\"inKwd_"+regSpecExp(attr)+"\">"+attr+"</button>";
				selAppendHtml += "</li>";
				
				recentSpec = "";
				
				break;
			case "discount" : 
				if(param_discount.length==0) {
					param_discount = attrData1;
				} else {
					param_discount += ","+attrData1;
				}
				var discountStartVal = attrData1.split("~");
				
				selAppendHtml = "<li data-type=\"discount\">";
				selAppendHtml += "	<span class=\"tx--selected\">"+vTxtname+"</span>";
				selAppendHtml += "	<button class=\"btn--key-deleted lp__sprite\" data-attr=\"discount_"+attrData1+"\" data-discount-start=\""+discountStartVal[0]+"\">"+vTxtname+"</button>";
				selAppendHtml += "</li>";
				
				qstrObj["fbName"] = attrData1;
				qstrObj["attType"] = "discount";
				
				break;
			case "bbsscore" :
				if(param_bbsscore.length==0) {
					param_bbsscore = attrData1;
				} else {
					param_bbsscore += ","+attrData1;
				}
			
				selAppendHtml = "<li data-type=\"bbsscore\" bbsscore=\""+attrData1+"\">";
				selAppendHtml += "	<span class=\"tx--selected\">"+vTxtname+"</span>";
				selAppendHtml += "	<button class=\"btn--key-deleted lp__sprite\" data-attr=\"bbsscore_"+attrData1+"\">"+vTxtname+"</button>";
				selAppendHtml += "</li>";
				
				qstrObj["fbName"] = attrData1;
				qstrObj["attType"] = "bbsscore";
				
				break;
		}
		
		// 성과측정 로그
		if(qstrObj["attType"]!==undefined) {
			insertDetailAttLog_Wide(qstrObj);
		}
		
		if(selAppendHtml.length>0) {
			attrSelCnt++; // 선택된 속성 갯수
			selTxtDiv.append(selAppendHtml);
			$("#attrSelCnt").text(attrSelCnt);
			param_pageNum = 1;
			if(!firstLoadAttrFlag || !blDeepLink) {
				loadGoods();
			}
		}
	
	// 선택한 조건 제거
	} else {
		// minus
		switch(attrType) {
			case "factory" :
				param_factory = "";
				param_factorycode = "";
				$("button[data-attr=factory_"+attrData1 +"]").closest("li").remove();
				if($(this).hasClass("btn--key-deleted")) {
					$("li[data-attr="+attr+"]").find("input").prop("checked", false);
				}
				
				factoryTmpSet.delete(attrData1);
				
				selTxtDiv.find("li[data-type=factory]").each(function(index, item) {
					if(param_factory.length>0) {
						param_factory += ",";
					}
					if(param_factorycode.length>0) {
						param_factorycode += ",";
					}
					param_factory += $(this).find("span").text();
					param_factorycode += $(this).find("button").attr("data-attr").replace("factory_","");
				});
				
				recentSpec = "factory_" + attrData1;
				
				break;
			case "brand" : 
				// SRP 추천브랜드
				if($(this).hasClass("r-brand")) {
					attrData1 = $(this).closest("li").attr("data-attr").replace("brand_","");
					vTxtname = $(this).closest("li").attr("data-text");
				}
				param_brand = "";
				param_brandcode = "";
				if($(this).hasClass("btn--key-deleted")) {
					$("li[data-attr="+attr+"]").find("input").prop("checked", false);
				}
				$("button[data-text="+regSpecExp(vTxtname)+"]").closest("li").remove();
				// 추천브랜드
				if(brandReqMap.has(vTxtname)) {
					$("ul.list__luxury li[data-text="+regSpecExp(vTxtname)+"]").removeClass("sel").removeClass("is--on");
				} else {
					$("dl.search-box-row[data-attr-type=brand] li[data-text="+regSpecExp(vTxtname)+"]").removeClass("sel");
				}
				brandTmpSet.delete(vTxtname);
				
				selTxtDiv.find("li[data-type=brand]").each(function(index, item) {
					if(param_brand.length>0) {
						param_brand += ",";
					}
					if(param_brandcode.length>0) {
						param_brandcode += ",";
					}
					param_brand += $(this).find("span").text();
					param_brandcode += $(this).find("button").attr("data-attr").replace("brand_","");
				});
				// SRP 추천브랜드
				if($(".search-box__r-brand").length>0) {
					$(".search-box__r-brand li[data-text="+vTxtname+"]").removeClass("is--on");
				}
				
				recentSpec = "brand_" + attrData1;
				
				break;
			case "shop" : 
				param_shopcode = "";
				$("button[data-attr=shop_"+attrData2+"_"+attrData1+"]").closest("li").remove();
				if($(this).hasClass("btn--key-deleted")) {
					$("li[data-attr=shop_"+attrData2+"_"+attrData1+"]").find("input").prop("checked", false);
					
				}
				selTxtDiv.find("li[data-type=shop]").each(function(index, item) {
					if(param_shopcode.length>0) {
						param_shopcode += ",";
					}
					param_shopcode += $(this).attr("shopcode");
				});
				break;
			case "spec" : 
				$("button[data-attr=spec_"+attrData2+"]").closest("li").remove();
				if($(this).hasClass("btn--key-deleted")) {
					$("li[data-spec="+attrData2+"]").find("input").prop("checked", false);
				}
				
				// 스마트파인더
				if($("li[data-spec="+attrData2+"]").find("button[data-type=smartfinder_button]").length>0) {
					var $allViewOffImage = $("li[data-spec="+attrData2+"]").find("button[data-type=smartfinder_button]").attr("data-off-image");
					$("li[data-spec="+attrData2+"]").find(".ico_thum img").attr("src", $allViewOffImage);
				}
				
				specSet.delete(attrData2);
				
				specGroupSet.delete( $("li[data-spec="+attrData2+"]").closest("dl.search-box-row").attr("data-index") );
				
				// spec_{스펙번호}_{그룹번호}
				recentSpec = "spec_" + attrData2 + "_" + $(this).closest("dl.search-box-row").attr("data-index");
				
				break;
			case "color" :
				param_color = "";
				$("button[data-attr=color_"+attrData2+"]").closest("li").remove();
				if($(this).hasClass("btn--key-deleted")) {
					$("li[data-color_="+attrData2+"]").find("input").prop("checked", false);
				}
				
				specSet.delete(attrData2);
				
				specGroupSet.delete( $("li[data-spec="+attrData2+"]").closest("dl.search-box-row").attr("data-index") );
				
				// spec_{스펙번호}_{그룹번호}
				recentSpec = "spec_" + attrData2 + "_" + $(this).closest("dl.search-box-row").attr("data-index");
				
				break;
			case "reqKwd" : 
				param_keyword = "";
				selTxtDiv.find("li[data-type=reqKwd]").remove();
				$(this).removeClass("is--active");
				break;
			case "price" :
				param_sPrice = 0;
				param_ePrice = 0;
				selTxtDiv.find("li[data-type=price]").remove();
				break;
			case "inKwd" :
				param_inKeyword = "";
				$(".list-filter__search--input").val("");
				selTxtDiv.find("li[data-type=inKwd]").remove();
				break;
			case "discount" :
				param_discount = "";
				var discountStartVal = attrData1.split("~");
				$("button[data-discount-start="+discountStartVal[0]+"]").closest("li").remove();
				if($(this).hasClass("btn--key-deleted")) {
					$("li[data-discount-start="+discountStartVal[0]+"]").find("input").prop("checked", false);
				}
				selTxtDiv.find("li[data-type=discount]").each(function(index, item) {
					if(param_discount.length>0) {
						param_discount += ",";
					}
					param_discount += $(this).find("button").attr("data-attr").replace("discount_","");
				});
				break;
			case "bbsscore" :
				param_bbsscore = "";
				$("button[data-attr=bbsscore_"+attrData1+"]").closest("li").remove();
				if($(this).hasClass("btn--key-deleted")) {
					$("li[data-attr=bbsscore_"+attrData1+"]").find("input").prop("checked", false);
					
				}
				selTxtDiv.find("li[data-type=bbsscore]").each(function(index, item) {
					if(param_bbsscore.length>0) {
						param_bbsscore += ",";
					}
					param_bbsscore += $(this).attr("bbsscore");
				});
				break;
		}
		
		attrSelCnt--; // 선택된 속성 갯수

		$("#attrSelCnt").text(attrSelCnt);
		param_pageNum = 1;
		loadGoods();
	}
	
	if(attrSelCnt==0) {
		$(".row-selected--condition").hide();
		
		// 스마트파인더 아이콘 이미지 토글 변경
		if( $("button[data-type=smartfinder_button]").length>0) {
		
			$("button[data-type=smartfinder_button]").each(function(index, item) {
				// 전체보기 off -> on 
				if( $(this).closest("li").attr("data-attr")=="spec_all" ) {
					$(this).closest("li").addClass("sel");
					$(this).find(".ico_thum img").attr("src", $(this).attr("data-on-image"));
				// 나머지 on -> off
				} else {
					$(this).closest("li").removeClass("sel");
					$(this).find(".ico_thum img").attr("src", $(this).attr("data-off-image"));
				}
			});
		}
		recentSpec = "";
		if(!firstLoadAttrFlag || !blDeepLink) {
			firstLoadAttrFlag = true;
		}
	} else {
		$(".row-selected--condition").show();
	}
});
// 속성 선택 초기화
$(document).on("click", "button.btn--key-reset", function() {
	if(confirm('검색한 항목을 전체 삭제하시겠습니까?')) {
		filterReset(true); // 초기화 함수 list_func.js
		
		param_inKeyword = "";
		$(".list-filter__search--input").val("");
		
		if(listType=="list") {
			param_keyword = "";
			insertLogLSV(14225, param_cate); // LP>상세검색>선택한 조건> 선택초기화 버튼 클릭수
		} else if(listType=="search") {
			insertLogLSV(14415); // SRP>상세검색>선택한 조건> 선택초기화 버튼 클릭수
		}
		
		// 스마트파인더 아이콘 이미지 토글 변경
		if( $("button[data-type=smartfinder_button]").length>0) {
		
			$("button[data-type=smartfinder_button]").each(function(index, item) {
				// 전체보기 off -> on 
				if( $(this).closest("li").attr("data-attr")=="spec_all" ) {
					$(this).closest("li").addClass("sel");
					$(this).find(".ico_thum img").attr("src", $(this).attr("data-on-image"));
				// 나머지 on -> off
				} else {
					$(this).closest("li").removeClass("sel");
					$(this).find(".ico_thum img").attr("src", $(this).attr("data-off-image"));
				}
			});
		}
		
		loadGoods();
		recentSpec = "";
		if(!firstLoadAttrFlag || !blDeepLink) {
			firstLoadAttrFlag = true;
		}
	}
	
});
// 가격대 클릭 시
$(document).on("click", "button.btn--range-price", function() {
	var $parent = $(this).parent();
	$parent.siblings().find(".btn--range-price").removeClass("is--active");
	if($(this).hasClass("is--active")) {
		$(this).removeClass('is--active');
	} else {
		$(this).addClass('is--active');
	}
});

// 속성 더보기, 닫기
$(document).on("click", "#moreViewOpen", function() {
	$(".search-box-row.more_spec").show();
	$("#moreViewClose").show();
	$(this).hide();
	if(listType=="list") {
		insertLogLSV(14214, param_cate); // LP>상세검색>항목 더보기/닫기 버튼 클릭수
	} else if(listType=="search") {
		insertLogLSV(26209); // SRP>상세검색>항목 더보기/닫기 버튼 클릭수
	}
});
$(document).on("click", "#moreViewClose", function() {
	$(".search-box-row.more_spec").hide();
	$("#moreViewOpen").show();
	$(this).hide();
	if(listType=="list") {
		insertLogLSV(14214, param_cate); // LP>상세검색>항목 더보기/닫기 버튼 클릭수
	} else if(listType=="search") {
		insertLogLSV(26209); // SRP>상세검색>항목 더보기/닫기 버튼 클릭수
	}
});
// 쿠폰 레이어 제어
$(document).on("mouseover", ".tag--coupon", function() {
	$(this).find(".lay-coupon").show();
});
// 탭 변경 
$(document).on("click", "ul.list-filter__tab li", function() {
	$("ul.list-filter__tab li").removeClass("is--on");
	$(this).addClass("is--on");
	param_tabType = $(this).attr("tabtype");
	
	// 신제품순/판매량순은 가격비교에서만 조회가능함
	if(param_tabType>=2 && (param_sort==4 || param_sort==5)) {
		param_sort = 1;
		$("ul.list-filter__sort .sortFilter").removeClass("is--on");
		$("ul.list-filter__sort li[sorttype=1]").addClass("is--on");
	}
	
	filterReset(false); // 초기화 함수 list_func.js
	
	loadGoods();
	
	// 가격대 노출 변경
	$(".search-box-row.row-price-range").hide();
	$(".search-box__range--price .attrs").removeClass("sel");
	$(".search-box__range--price .attrs .btn--range-price").removeClass("is--active");
	$(".search-box__range--price .attrs[data-start="+param_sPrice+"][data-end="+param_ePrice+"]").addClass("sel");
	$(".search-box__range--price .attrs[data-start="+param_sPrice+"][data-end="+param_ePrice+"]").find("button").addClass("is--active");
	
	if(param_tabType==0) {
		if(listType=="list") {
			insertLogLSV(24137, param_cate); // LP>전체상품 탭 클릭수
		} else if(listType=="search") {
			insertLogLSV(26159); // SRP>전체상품 탭 클릭수
		}
		$(".search-box-row.row-price-range[data-price-option=all]").show();
	} else if(param_tabType==1) {
		if(listType=="list") {
			insertLogLSV(24138, param_cate); // LP>가격비교 탭 클릭수
		} else if(listType=="search") {
			insertLogLSV(26160); // SRP>가격비교 탭 클릭수
		}
		$(".search-box-row.row-price-range[data-price-option=model]").show();
	} else if(param_tabType==2) {
		if(listType=="list") {
			insertLogLSV(24139, param_cate); // LP>일반상품 탭 클릭수
		} else if(listType=="search") {
			insertLogLSV(26161); // SRP>일반상품 탭 클릭수
		}
		$(".search-box-row.row-price-range[data-price-option=pl]").show();
	} else if(param_tabType==3) {
		if(listType=="list") {
			insertLogLSV(24140, param_cate); // LP>해외직구 탭 클릭수
		} else if(listType=="search") {
			insertLogLSV(26162); // SRP>해외직구 탭 클릭수
		} 
		$(".search-box-row.row-price-range[data-price-option=model]").show();
	}
	
	// 탭별 노출 처리 
	if(listType=="list") {
		switch(param_tabType) {
			case "0" : lpCateTab = ""; break;
			case "1" : lpCateTab = "가격비교"; break;
			case "2" : lpCateTab = "쇼핑몰"; break;
			case "3" : lpCateTab = "해외직구"; break;
		}
		
		$(document).attr("title",lpCateTitle+" "+lpCateTab+" 최저가 검색 - 에누리 가격비교");
	}
	
	// 쇼핑몰 필터는 일반상품에서만 노출된다.
	if(param_tabType==2){
		$("dl.search-box-row[data-attr-type=shop]").show();
	} else {
		$("dl.search-box-row[data-attr-type=shop]").hide();
	}
});
// 탭 마우스 아웃 시 레이어 미노출 처리
$(document).on("mouseout", "ul.list-filter__tab li", function() {
	$(this).find(".lay-tab-caution").hide();
});
// 정렬 변경 (상품)
$(document).on("click", ".list-filter-bot[data-type=prod] .sortFilter", function() {
	var sortType = $(this).attr("sorttype");
	var filterObj = $(".list-filter-bot");
	
	// 출시예정
	if(sortType==7) {
		$("ul.list-filter__tab li").removeClass("is--on");
		$("ul.list-filter__tab li[tabtype=1]").addClass("is--on");
		$("ul.list-filter__sort .sortFilter").removeClass("is--on");
		$("ul.list-filter__sort li[sorttype=1]").addClass("is--on");
		$(".list-filter__btn.newListDiv").show();
		$(".list-filter-bot[data-type=prod] .sortFilter").hide();
		blNewListBtnCheck = true;
	} else {
		$("ul.list-filter__sort .sortFilter").removeClass("is--on");
		$(this).addClass("is--on");
		$(".list-filter__btn.newListDiv").hide();
		$(".list-filter-bot[data-type=prod] .sortFilter").show();
		if(!blNewListBtnIsset) {
			$(".list-filter-bot[data-type=prod] .sortFilter[sorttype=7]").hide();
		}
		blNewListBtnCheck = false;
	}
	
	if(sortType==2) { // 최저가
		// 중고/렌탈 제외 체킹
		$("#chLPcondition1").prop("checked", true);
		param_isRental = "Y";
	} else {
		if(blIsRentalUserClick){
			$("#chLPcondition1").prop("checked", true);
			param_isRental = "Y";
		} else {
			$("#chLPcondition1").prop("checked", false);
			param_isRental = "N";
		}
	}
	
	if(sortType==1) {
		if(listType=="list") {
			insertLogLSV(24142, param_cate); // LP>인기순 클릭수
		} else if(listType=="search") {
			insertLogLSV(26163); // SRP>인기순 클릭수
		} 
	} else if(sortType==2) {
		if(listType=="list") {
			insertLogLSV(24143, param_cate); // LP>최저가순 클릭수
		} else if(listType=="search") {
			insertLogLSV(26164); // SRP>최저가순 클릭수
		}
	} else if(sortType==3) {
		if(listType=="list") {
			insertLogLSV(24144, param_cate); // LP>최고가순 클릭수
		} else if(listType=="search") {
			insertLogLSV(26165); // SRP>최고가순 클릭수
		} 
	} else if(sortType==4) {
		if(listType=="list") {
			insertLogLSV(24145, param_cate); // LP>신제품순 클릭수
		} else if(listType=="search") {
			insertLogLSV(26166); // SRP>신제품순 클릭수
		} 
		param_tabType = 1;
		$("ul.list-filter__tab li").removeClass("is--on");
		$("ul.list-filter__tab li[tabtype=1]").addClass("is--on");
	} else if(sortType==5) {
		if(listType=="list") {
			insertLogLSV(24146, param_cate); // LP>판매량순 클릭수
		} else if(listType=="search") {
			insertLogLSV(26167); // SRP>판매량순 클릭수
		}
		param_tabType = 1;
		$("ul.list-filter__tab li").removeClass("is--on");
		$("ul.list-filter__tab li[tabtype=1]").addClass("is--on");
	} else if(sortType==6) {
		if(listType=="list") {
			insertLogLSV(24147, param_cate); // LP>상품평 많은순 클릭수
		} else if(listType=="search") {
			insertLogLSV(26168); // SRP>상품평 많은순 클릭수
		}
	} else if(sortType==7) {
		if(listType=="list") {
			insertLogLSV(17516, param_cate); // LP>출시예정 버튼 클릭수
		} else if(listType=="search") {
			insertLogLSV(26169); // SRP>출시예정 버튼 클릭수
		} 
		param_tabType = 1;
	}
	param_sort = sortType;
	param_pageNum = 1
	loadGoods();
});
// 출시예정 시 관련 이벤트
$(document).on("click", ".list-filter__btn.newListDiv", function() {
	var btnType = $(this).attr("buttontype");
	
	// 판매중 상품
	if(btnType==1) {
		$("ul.list-filter__tab li").removeClass("is--on");
		$("ul.list-filter__tab li[tabtype=0]").addClass("is--on");
		$("ul.list-filter__sort .sortFilter").removeClass("is--on");
		$("ul.list-filter__sort li[sorttype=1]").addClass("is--on");
		param_tabType = 0;
		param_sort = 1;
		blNewListBtnCheck = false;
		$(".list-filter__btn.newListDiv").hide();
		$(".sortFilter").show();
		param_pageNum = 1;
		loadGoods();
		if(listType=="list") {
			insertLogLSV(14253, param_cate); // LP>출시예정 > 판매중상품 버튼 클릭수
		} else if(listType=="search") {
			insertLogLSV(26171); // SRP>출시예정 > 판매중상품 버튼 클릭수
		}
	// 신상품 등록요청
	} else if(btnType==2) {
		if(listType=="list") {
			insertLogLSV(14254, param_cate); // LP>출시예정 > 신상품 등록요청 버튼 클릭수
		} else if(listType=="search") {
			insertLogLSV(26170); // SRP>출시예정 > 신상품 등록요청 버튼 클릭수
		}
		window.open("/faq/customer_seller.jsp?faq_type=4");
	}
});
//중고/렌탈 제외 체크
$(document).on("change", ".condition--used-rental input[type=checkbox]", function() {
	if(this.checked) {
		param_isRental = "Y";
		blIsRentalUserClick = true;
	} else {
		param_isRental = "N";
		blIsRentalUserClick = false;
	}
	if(listType=="list") {
		insertLogLSV(17517, param_cate); // LP>중고/렌탈제외 체크박스 선택
	} else if(listType=="search") {
		insertLogLSV(26172); // SRP>중고/렌탈제외 체크박스 선택
	}
	param_pageNum = 1
	loadGoods();
});
//배송비 포함 체크
$(document).on("change", ".condition--delivery-fee input[type=checkbox]", function() {
	if(this.checked) {
		param_isDelivery = "Y";
	} else {
		param_isDelivery = "N";
	}
	if(listType=="list") {
		insertLogLSV(14249, param_cate); // LP>배송비포함 체크박스 선택
	} else if(listType=="search") {
		insertLogLSV(26173); // SRP>배송비포함 체크박스 선택
	}
	param_pageNum = 1
	loadGoods();
});
//~개씩 보기
$(document).on("click", "li.select-box__item", function() {
	var count = $(this).attr("data-count");
	$("li.select-box__item").removeClass("is--selected");
	$(this).addClass("is--selected");
	$(this).closest("div.select-box--basic").find(".select-box--selected").html(count+"개씩 보기<i class=\"ico-arr-select-box lp__sprite\"></i>");
	
	if(count==30) {
		if(listType=="list") {
			insertLogLSV(14255, param_cate); // LP>전체/가격비교/일반상품/해외직구 탭 > 30개씩 보기
		} else if(listType=="search") {
			insertLogLSV(26176); // SRP>전체/가격비교/일반상품/해외직구 탭 > 30개씩 보기
		}
	} else if(count==60) {
		if(listType=="list") {
			insertLogLSV(14256, param_cate); // LP>전체/가격비교/일반상품/해외직구 탭 > 60개씩 보기
		} else if(listType=="search") {
			insertLogLSV(26175); // SRP>전체/가격비교/일반상품/해외직구 탭 > 60개씩 보기
		}
	} else if(count==90) {
		if(listType=="list") {
			insertLogLSV(14257, param_cate); // LP>전체/가격비교/일반상품/해외직구 탭 > 90개씩 보기
		} else if(listType=="search") {
			insertLogLSV(26174); // SRP>전체/가격비교/일반상품/해외직구 탭 > 90개씩 보기
		}
	}
	
	param_pageGap = count;
	param_pageNum = 1
			
	//세션세팅
	Set_session("pagegap", param_pageGap);
	loadGoods();
});
//엔터키 처리
$(document).on("keypress", ".input--text-item.end_price", function(e) {
	if(e.keyCode==13) {
		$(this).closest("div.search-box__range--search").find(".btn--range-search").trigger("click");
	}
});
$(document).on("keypress", ".list-filter__search--input", function(e) {
	if(e.keyCode==13) {
		$(".list-filter__search--btn").trigger("click");
	}
});
// 뷰타입 변경
$(document).on("click",".list-filter__view ul.view-type li", function() {
	viewType = $(this).attr("gridtype");
	$(".list-filter__view ul.view-type li").removeClass("is--on");
	$(this).addClass("is--on");
	
	if(viewType=="1") {
		if(listType=="list") {
			insertLogLSV(15014, param_cate); // LP>전체/가격비교/일반상품/해외직구 탭 > 심플리스트뷰 선택
		} else if(listType=="search") {
			insertLogLSV(26177); // SRP>전체/가격비교/일반상품/해외직구 탭 > 심플리스트뷰 선택
		}
	} else if(viewType=="2") {
		if(listType=="list") {
			insertLogLSV(14259, param_cate); // LP>전체/가격비교/일반상품/해외직구 탭 > 갤러리뷰 선택
		} else if(listType=="search") {
			insertLogLSV(26178); // SRP>전체/가격비교/일반상품/해외직구 탭 > 갤러리뷰 선택
		}
	}
	
	//세션세팅
	Set_session("listgridtype", viewType);
	
	// 애드쇼핑 초기화
	if(typeof blAdShopingFirst !== undefined) {
		blAdShopingFirst = false;
	}
	// 애드오피스 초기화
	if(typeof blAdOfficeFirst !== undefined) {
		blAdOfficeFirst = false;
	}
	drawList(tmpDataObj);
});
// 브랜드/제조사 모아보기
$(document).on("click",".btn--view-brand", function() {
	var $type = $(this).attr("viewtype");
	var $text = $(this).attr("searchtext");
	var $code = $(this).attr("searchcode");
 	if(listType=="list") {
		insertLogLSV(15023, param_cate); // LP > 리스트뷰 > 제조사 선택
	} else if(listType=="search") {
		insertLogLSV(26256); // SRP > 리스트뷰 > 제조사 선택
	}
	
	if($type == "factory") {
		$("li.attrs[data-attr=factory_"+$code+"] label").trigger("click");
	} else if($type == "brand") {
		if(brandReqMap.has($text)) {
			$("ul.list__luxury li.attrs[data-text="+regSpecExp($text)+"] a").trigger("click");
		} else {
			if( $(".btn-sort--name").hasClass("is--selected") ) {
				$("dl[data-attr-type=brand] li.attrs[data-attr=brand_"+regSpecExp($text)+"] label").trigger("click");
			} else {
				$("dl[data-attr-type=brand] li.attrs[data-text="+regSpecExp($text)+"] label").trigger("click");
			}
		}
	}
});
// 페이징 이동처리
$(document).on("click", ".paging .paging__inner a, .paging .paging__inner button", function() {
	$page = $(this).attr("data-page");
	param_pageNum = $page;
	loadGoods();
	var listFilterTop = $(".list-filter").offset().top;
	$("html,body").scrollTop(listFilterTop-51);
	
	// insertLogLSV(개별로그번호, 카테고리, 페이지번호)
	if(listType=="list") {
		insertLogLSV(26210, param_cate, $page); // LP > 페이징 버튼 클릭 (페이지 숫자 저장)
	} else if(listType=="search") {
		insertLogLSV(26211, "", $page); // SRP > 페이징 버튼 클릭 (페이지 숫자 저장)
	}
});
// 프린터 검색 함수 호출
$(document).on("keypress", ".model-finder__input", function(e) {
	if(e.keyCode==13) {
		if($(this).val()=="") {
			alert("검색어를 입력하세요.\n정확한 모델명으로 다시 검색해 주세요.");
			return;
		}
		loadInkFinder($(this).val(), "layer"); 
	}
});
$(document).on("click", ".model-finder__btn", function() {
	if($(".model-finder__input").val()=="") {
		alert("검색어를 입력하세요.\n정확한 모델명으로 다시 검색해 주세요.");
		return;
	}
	loadInkFinder($(".model-finder__input").val(), "layer"); 
});
//잉크,토너 파인더 검색 자동완성
$(document).on("keyup", ".model-finder__input", function() {
	var vFinderKeyword = "";
	vFinderKeyword = $(this).val();
	if(vFinderKeyword.length > 0) {
		$(this).parent().addClass('is--active');
		loadInkFinder(vFinderKeyword, "auto")
	}else{
		$(this).parent().removeClass('is--active');
	}
});

//잉크,토너 파인더 검색어 지우기
$(document).on("click",  ".model-finder__delete_btn", function(){
	$(".model-finder__input").val("");
	$(".model-finder__form").removeClass("is--active");
});

//잉크, 토너 파인더 자동완성리스트 숨기기
$(document).on("mouseup", "body", function(e){
	var $modelfinder__form = $(".model-finder__form");
	if(typeof e.target !== "undefined") {
		if($modelfinder__form.has(e.target).length === 0) {
			$modelfinder__form.removeClass("is--active");
		}
	}	
});

// 심플리스트뷰 더보기 이벤트
$(document).on("click", ".type--list .btn--opt-unfold", function() {
	$(this).closest('.item__price').addClass('is--unfold');
	$(this).hide();
	$(this).closest(".item__price").find("button.btn--opt-fold").show();
	if(listType=="list") {
		insertLogLSV(15042, param_cate); // LP > 리스트뷰 > 다른옵션 펼치기/닫기 버튼
	} else if(listType=="search") {
		insertLogLSV(26260); // SRP > 리스트뷰 > 다른옵션 펼치기/닫기 버튼
	}
});
$(document).on("click", ".type--list .btn--opt-fold", function() {
	$(this).hide();
	$(this).closest(".item__price").find("button.btn--opt-unfold").show();
	if(listType=="list") {
		insertLogLSV(15042, param_cate); // LP > 리스트뷰 > 다른옵션 펼치기/닫기 버튼
	} else if(listType=="search") {
		insertLogLSV(26260); // SRP > 리스트뷰 > 다른옵션 펼치기/닫기 버튼
	}
});
//갤러리뷰 더보기 이벤트 
$(document).on("click", ".type--grid .btn--opt-fold", function() {
	$(this).closest('.item__price').removeClass('is--unfold');
	$(this).addClass("hide");
	$(this).closest(".item__price").find("button.btn--opt-unfold").removeClass("hide");
	if(listType=="list") {
		insertLogLSV(24153, param_cate); // LP > 갤러리뷰 > 다른옵션 더보기, 쇼핑몰 더보기
	} else if(listType=="search") {
		insertLogLSV(26271); // SRP > 갤러리뷰 > 다른옵션 더보기, 쇼핑몰 더보기
	}
});
//옵션창을 내가 선택한 상품의 라인에 맞춰 높이를 계산하여 위치하고, 같은 라인 상품의 여백을 설정해 줍니다.
//dataId, groupModelData
$(document).on("click", ".type--grid .btn--opt-unfold", function() {
	
	$(this).closest('.item__price').addClass('is--unfold');
	$(this).addClass("hide");
	$(this).closest(".item__price").find("button.btn--opt-fold").removeClass("hide");
	
	var $list = $(this).closest('ul').find(">li.prodItem"); // 전체상품
	var $this = $(this).closest('li.prodItem'); // 선택된 상품
	var _len = 4; // 한줄에 노출될 상품수
	var _idx = $this.index('li.prodItem'); // 선택된 상품의 인덱스
	var _line = parseInt(_idx/_len,10) + 1 // 라인
	var _num = _idx%_len + 1 // 라인에 몇번째 상품인지
	var _itemH = $this.outerHeight() + 20; // 선택된 상품의 높이
	var $option = $(document).find(".goods-option-bundle"); // 옵션을 감싸는 박스
	var $optionIn = $(document).find(".goods-option-bundle .goods-option"); // 옵션 리스트
	
	var dataId = $this.attr("data-id");
	var viewType = $this.attr("data-viewtype");
	var dataSplit = dataId.split("_");
	if(dataSplit[0] !== "model" ) {
		return;
	}
	var modelNo = dataSplit[1];
	var groupModelObj = modelNoGroupMap.get(modelNo);
	var groupList = groupModelObj.list;
	var strChange = groupModelObj.strChange;
	var strUnit = groupModelObj.strUnit;
	// 그룹모델 내 이미지형태 광고 여부 
	var groupImageADflag = false;
	if(groupModelObj.groupImage !== undefined) {
		groupImageADflag = true;
	}
	
	// 그룹모델의 순서를 바꾼다.
	var tmpGroupModelArray = [];
	if(groupList && groupList.length>5) {
		tmpGroupModelArray = groupList;
		
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
		
		groupList = tmpGroupModelArray;
	}
	
	if ( !$this.hasClass('is--unfold') ){
		
		var appendObj = $(".goods-option-bundle .goods-option");
		appendObj.empty();
		
		var html = [];
		var hIdx = 0;
		
		var topMargin = _itemH * _line;
		
		// 오픈쇼핑 이 있을 경우 높이 재계산
		if($(".ad--openad").length>0 && _idx > 7) {
			topMargin = topMargin + 455;
		}
		
		// 중단 띠배너가 있을 경우 높이 추가 계산
		if($(".ad-wide-bnr").length>0 && _idx > 11) {
			topMargin = topMargin + 150;
		}
		
		// 애드쇼핑이 있을 경우 높이 추가 계산
		if($(".ad--openad[ad-type=adshopping]").length>0 && _idx > 15) {
			topMargin = topMargin + 455;
		}
		// 애드오피스 있을 경우 높이 추가 계산
		if($(".ad--openad[ad-type=adoffice]").length>0 && _idx > 23) {
			topMargin = topMargin + 455;
		}
		
		// 다른옵션 더보기
		if(viewType=="model" && groupList.length>0) {
			html[hIdx++] = "<ul class=\"goods-option__list\">";
			$(groupList).each(function(index, groupData) {
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
				
				//단위당환산가 콤마 처리
				strUnitPrice  = strUnitPrice.replace(",","");
				
				// 출시예정 별도 처리
				if(index==0) {
					if( $("li.prodItem[data-id=model_"+strModelNo+"] .goods-item .item__box .item__price .tx--sold").text() == "출시예정" ) {
						strPrice = "출시예정";
					}
				}
				
				if(index<5) {
					html[hIdx++] = "<li class=\"goods-option__item\" data-type=\"option_mall\" data-modelno=\""+strModelNo+"\" data-rank=\""+$this.attr("data-all-rank")+"\">";
					html[hIdx++] = "	<div class=\"goods-option__inner\">";
					//						<!-- 찜 -->
					html[hIdx++] = "		<div class=\"col--zzim\">";
					if((strZzimYN=="Y" && !zzimTmpModelNoRemoveSet.has(strModelNo)) || zzimTmpModelNoSet.has(strModelNo)) {
						html[hIdx++] = "		<button class=\"btn--zzim is--on\" data-zzimno=\"G"+strModelNo+"\" onclick=\"showLayZzim_list(this);return false;\"><i class=\"ico-item--zzim lp__sprite\">찜</i></button>";
					} else {
						html[hIdx++] = "		<button class=\"btn--zzim\" data-zzimno=\"G"+strModelNo+"\" onclick=\"showLayZzim_list(this);return false;\"><i class=\"ico-item--zzim lp__sprite\">찜</i></button>";
					}
					html[hIdx++] = "		</div>";
					//						<!-- 비교 -->
					html[hIdx++] = "		<div class=\"col--select\">";
					html[hIdx++] = "			<input type=\"checkbox\" id=\"lpListItemGrid"+index+"\" class=\"input--checkbox-item\">";
					html[hIdx++] = "			<label for=\"lpListItemGrid"+index+"\"></label>";
					html[hIdx++] = "			<button class=\"btn--compare\" onclick=\"javascript:compareProdInput('G"+strModelNo+"');\">상품비교</button>";
					html[hIdx++] = "		</div>";
					//						<!-- 이미지형 그룹조건 클래스 "col--ad"-->
					if(groupImageADflag && groupModelObj.groupImage.modelno!==undefined && groupModelObj.groupImage.modelno.length>0 
						&& groupModelObj.groupImage.url!==undefined && groupModelObj.groupImage.url.length>0 && groupModelObj.groupImage.modelno==strModelNo) {
						html[hIdx++] = "	<div class=\"col--name col--ad\">";
						html[hIdx++] = "		<img src=\""+groupModelObj.groupImage.url+"\" alt=\""+strCondiName+"\">";
						html[hIdx++] = "	</div>";
					} else {
						//					<!-- 옵션명 -->
						html[hIdx++] = "	<div class=\"col--name\">"+strCondiName;
						if(strRank.length>0) {
							html[hIdx++] = "	<span class=\"tag--rank\">"+(strRank)+"위</span>";
						}
						html[hIdx++] = "	</div>";
					}
					//						<!-- 단위환산가 : 없으면 비노출 -->
					if(strUnitPrice!="0") {
						if(strChange!="0" && strUnit !="") {
							if(strMinUnitPriceYN=="Y") {
								html[hIdx++] = "<span class=\"col--unit is--minp\">"+strUnitPrice.format()+"원/"+strChange+""+strUnit+"</span>";
							} else {
								html[hIdx++] = "<span class=\"col--unit\">"+strUnitPrice.format()+"원/"+strChange+""+strUnit+"</span>";
							}
						} else {
							if(strMinUnitPriceYN=="Y") {
								html[hIdx++] = "<span class=\"col--unit is--minp\">"+strUnitPrice.format()+"원</span>";
							} else {
								html[hIdx++] = "<span class=\"col--unit\">"+strUnitPrice.format()+"원</span>";
							}
						}
					}
					//						<!-- 가격 -->
					html[hIdx++] = "		<div class=\"col--price\">";
					//							<!-- 현금 -->
					if(tag.cash!==undefined) {
						html[hIdx++] = "		<span class=\"tag--cash lp__sprite\">현금</span>";
					}
					//							<!-- 직구 -->
					if(tag.ovs!==undefined) {
						html[hIdx++] = "		<span class=\"tag--global lp__sprite\">직구</span>";
					}
					//							<!-- 태그 : 모바일 -->
					if(param_isDelivery=="N" && strMobileMinPriceYn=="Y") {
						html[hIdx++] = "		<span class=\"tag--mobile lp__sprite\">모바일최저가</span>";
					}
					if(strPrice.length>0) {
						if( strPrice.indexOf("미정")>-1 || strPrice.indexOf("없음")>-1 || strPrice.indexOf("출시예정")>-1 ) {
							html[hIdx++] = "	<strong>출시예정</strong>";
						} else {
							if(tag.cash!==undefined && tag.cash.price!==undefined) {
								html[hIdx++] = "<strong>"+tag.cash.price+"</strong>원";
							} else {
								html[hIdx++] = "<strong>"+strPrice+"</strong>원";
							}
						}
					}
					html[hIdx++] = "		</div>";
					//						<!-- 몰수 -->
					if( strPrice.indexOf("미정")>-1 || strPrice.indexOf("없음")>-1 || strPrice.indexOf("출시예정")>-1) {
						html[hIdx++] = "	<div class=\"col--mall\"></div>";
					} else if(strMallCnt.length>0) {
						html[hIdx++] = "	<div class=\"col--mall\">("+strMallCnt+")</div>";
					}
					html[hIdx++] = "	</div>";
					html[hIdx++] = "</li>";
				} else if(index==5) {
					html[hIdx++] = "<li class=\"goods-option__item\">";
					html[hIdx++] = "	<a href=\"/detail.jsp?modelno="+modelNo+"\" target=\"_blank\" data-modelno=\""+modelNo+"\">다른옵션 "+(groupList.length-5)+"개 더보기 ></a>";
					
				}
				
				
			});
			html[hIdx++] = "</ul>";
			
			appendObj.show();
			appendObj.html(html.join(""));
			
			// 상품 활성화
			$this.addClass("is--unfold").siblings().removeClass("is--unfold");
			// 옵션창 열기
			$option.show().css("top",topMargin);
			// 옵션 리스트 타입 결정
			$optionIn.removeClass("option--type1 option--type2 option--type3 option--type4").addClass("option--type"+_num);
			// 라인간 간격 설정
			$list.css("margin-bottom",0);
			for ( var i = _len ; i > 0 ; i-- ){
				$list.eq( _len * _line - i ).css("margin-bottom",$optionIn.outerHeight()+14);
			}
			
		
		// 쇼핑몰 더보기
		} else if(viewType=="shop") {
			
			var shopListUrl = "wide/api/product/prodShopPrice.jsp?modelno="+modelNo+"&cate="+param_cate;
			$.getJSON(shopListUrl, function(shopData){
			
				if(shopData.data.shopPricelist!==undefined && shopData.data.shopPricelist.length>0) {
					html[hIdx++] = "	<ul class=\"goods-option__list\">";
					$(shopData.data.shopPricelist).each(function(index, item) {
					
						if(index<5) { 
							html[hIdx++] = "<li class=\"goods-option__item\" data-type=\"shop\" data-rank=\""+$this.attr("data-all-rank")+"\">";
							html[hIdx++] = "	<a href=\"/move/Redirect.jsp?cmd=move_link&vcode="+ item.shopcode +"&modelno="+modelNo+"&pl_no="+item.plno+"&from=lp&showPrice="+item.price+"&buycnt=1\" target=\"_blank\" data-plno=\""+item.plno+"\">";
							html[hIdx++] = "		<div class=\"col--name\">";
							//							<!-- 쇼핑몰 로고 -->
							html[hIdx++] = "			<span class=\"tx--shop\"><img src=\"//storage.enuri.info/logo/logo16/logo_16_"+item.shopcode+".png\" alt=\""+item.shopname+"\" onerror=\"javascript:logoImgNotFound(this);\"></span>";
							/*
							if(item.shoptype!==undefined && item.shoptype=="4") {
							// 							<!-- 쇼핑몰 명 + NPAY -->
							html[hIdx++] = "			<span class=\"tx--shop type--npay\">"+item.shopname+"</span>";
							} else {
							//							<!-- 쇼핑몰 명 -->
							html[hIdx++] = "			<span class=\"tx--shop\">"+item.shopname+"</span>";
							}
							*/
							html[hIdx++] = "		</div>";
							if(item.delivery_text!==undefined && item.delivery_text.length>0) {
							//						<!-- 배송비 -->
								if ($.isNumeric(item.delivery_text)) {
									html[hIdx++] = "<div class=\"col--delivery\">"+item.delivery_text.format()+"원</div>";
								} else {
									html[hIdx++] = "<div class=\"col--delivery\">"+item.delivery_text+"</div>";
								}
							}
							html[hIdx++] = "		<div class=\"col--price\">";
							//cash_mall
							if(item.cashmall_check) {
								html[hIdx++] = "		<span class=\"tag--cash lp__sprite\">현금</span>";
							}
							//ovsflag
							if(item.oversea_check) {
								html[hIdx++] = "		<span class=\"tag--global lp__sprite\">직구</span>";
							}
							html[hIdx++] = "			<strong>"+item.price.format()+"</strong>원";
							html[hIdx++] = "		</div>";
							html[hIdx++] = "	</a>";
							html[hIdx++] = "</li>";
						} else if(index==5) {
							html[hIdx++] = "<li class=\"goods-option__item\">";
							html[hIdx++] = "	<a href=\"/detail.jsp?modelno="+modelNo+"\" target=\"_blank\" data-modelno=\""+modelNo+"\">다른 쇼핑몰 "+(shopData.data.shopPricelist.length-5)+"개 더보기 ></a>";
						} 
					});
					html[hIdx++] = "	</ul>";
				}
				appendObj.show();
				appendObj.html(html.join(""));
				
				// 상품 활성화
				$this.addClass("is--unfold").siblings().removeClass("is--unfold");
				// 옵션창 열기
				$option.show().css("top",topMargin);
				// 옵션 리스트 타입 결정
				$optionIn.removeClass("option--type1 option--type2 option--type3 option--type4").addClass("option--type"+_num);
				// 라인간 간격 설정
				$list.css("margin-bottom",0);
				for ( var i = _len ; i > 0 ; i-- ){
					$list.eq( _len * _line - i ).css("margin-bottom",$optionIn.outerHeight()+14);
				}
			
			});
		}
	}else{
		// 상품 비활성화
		$this.removeClass("is--unfold");
		// 옵션창 닫기
		$option.removeAttr("style").hide();
		// 옵션 리스트 타입 제거
		$optionIn.removeClass("option--type1 option--type2 option--type3 option--type4");
		// 라인간 간격 삭제
		$list.css("margin-bottom",0);
	}
	
	if(listType=="list") {
		insertLogLSV(24153, param_cate); // LP > 갤러리뷰 > 다른옵션 더보기, 쇼핑몰 더보기
	} else if(listType=="search") {
		insertLogLSV(26271); // SRP > 갤러리뷰 > 다른옵션 더보기, 쇼핑몰 더보기
	}
});

// 미니vip 불러오기
$(document).on("click", ".option__row .opt--condition, .option__row .opt--price .tx--price, .goods-option__item[data-type=option_mall] .col--name, .goods-option__item[data-type=option_mall] .col--price", function() {
	var $this = $(this);
	
	var modelno = $this.attr("data-modelno");
	var $li = $this.closest("li.prodItem");
	var category = $li.attr("data-cate");
	var rank = $li.attr("data-all-rank");
	
	if(modelno===undefined || modelno.length==0) {
		modelno = $this.closest("li").attr("data-modelno");
	}
	if(modelno===undefined || modelno.length==0) {
		return;
	}
	if($this.find(".btn--dic").length>0) {
		return;
	}
	
	if (($this.attr("class") == "tx--price" && $this.text() == "출시예정") || ($this.attr("class") == "opt--condition" &&  $this.next().find(".tx--price").text() == "출시예정") ){
		window.open("/detail.jsp?modelno=" + modelno);
		return;
	} 
	
	if(listType=="list") {
		insertLogLSV(14381); // LP > 가격비교 상품
		// LP성과측정
		var qstrObj = {};
		qstrObj["click"] = "click";
		qstrObj["modelno"] = modelno;
		qstrObj["rank"] = rank;
		insertDetailAttLog_Wide(qstrObj);
		if( Synonym_From == "search" && Synonym_Keyword.length > 0 ) { // 분류검색어 진입시
			insertSearchKeywordViewLog_Wide(1, modelno, "", rank);
		}
	} else if(listType=="search") {
		insertLogLSV(14446); // SRP > 가격비교 상품
		insertSearchKeywordViewLog_Wide(1, modelno, "", rank);
	}
	
	if(!blLoadMiniVip) {
		var miniVipScript = document.createElement("script");
		miniVipScript.setAttribute("src", "/wide/script_min/miniVip.min.js");
		miniVipScript.setAttribute("type", "text/javascript");
		miniVipScript.onload = function() {
			initMiniVip(modelno, category); // 미니 vip 호출
		}
		document.getElementById("miniVIP_AREA").appendChild(miniVipScript);
		blLoadMiniVip = true;
	} else {
		initMiniVip(modelno , category); // 미니 vip 호출
	}
});

// LP 미카테고리 라디오 클릭
$(document).on("change", "input[name=radioLPCATE]", function() {
	var cate = $(this).closest("li").attr("data-cate");
	insertLogLSV(24159, param_cate); // LP>카테고리>미분류
	location.href="/list.jsp?cate="+cate;
});

// SRP 추천 카테고리 확장
$(document).on("click", "ul.search-box__list--recomcate li span.ico-expend-arr", function() {
	var cate = $(this).attr("data-cate");
	
	if($(this).closest("li").hasClass("is--active")) {
		$(this).closest("li").removeClass("is--active");
	} else {
		if(param_keyword.length>0 && cate.length>0) {
			loadSubCateList(cate);
			insertLogLSV(14390); // SRP > 전체카테고리 > 중카테고리명 옆 ▼클릭 수(레이어 열림)
		}
	}
});

// 찜 목록열기
$(document).on("click", "button.lay-zzim__btn", function() {
	var openUrl = "/view/resentzzim/resentzzimList.jsp?listType=2";
	var resentZzimWin = window.open(openUrl,"resentZzimWin","width=804,height="+window.screen.height+",left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
	resentZzimWin.focus();
});

// 부분검색어 재검색
$(document).on("click", ".part-keyword__btn--research", function() {
	var tmpKeyword = "";
	$(".part-keyword__list input:checkbox").each(function() {
		if( $(this).is(":checked") ) {
			if(tmpKeyword.length>0) {
				tmpKeyword += " ";
			}
			tmpKeyword += $(this).closest("li").find("label").text();
		}
	});
	param_keyword = tmpKeyword;
	param_isResearch = "N";
	param_pageNum = 1
	loadGoods();
});
// 모바일최저가 레이어 - 핸드폰 전송 영역 토글
$(document).on("click", "button.btn-mobile--sendsms", function() {
	insertLogLSV(15031); // LP/SRP>모바일 최저가 아이콘 클릭>레이어열림>핸드폰 전송 클릭수
	$(".lay-mobile-prod lay-comm--body .lay-mobile-sendsms").toggle();
});
// 모바일최저가 레이어 - SMS보내기
$(document).on("click", "button.sendsms__form--btn", function() {
	
	var phoneTxt = $("input.sendsms__form--inp").val();
	var title = $(this).closest(".lay-comm--body").find("button.btn-mobile--sendsms").attr("data-modelname");
	var modelno = $(this).closest(".lay-comm--body").find("button.btn-mobile--sendsms").attr("data-modelno");
	
	insertLogLSV(15033); // LP/SRP>모바일 최저가 아이콘 클릭>레이어열림>핸드폰전송>전송클릭수
	
	//sendDetailSms(phoneTxt, "detail", title); // incMiniDetail.js
	sendDetailSms(this, "detail", modelno, title);
});
// 모바일최저가 레이어 - 에누리앱 설치
$(document).on("click", "button.btn-mobile--app", function() {
	
	insertLogLSV(15032); // LP/SRP>모바일 최저가 아이콘 클릭>레이어열림>에누리앱 설치 클릭수
	
	window.open("/common/jsp/App_Landing.jsp");
});
// 갤러리형 상품 이동
$(document).on("click", ".option__row .goods-option__item[data-type=option_mall] .col--name, .option__row .goods-option__item[data-type=option_mall] .col--price, .option__row .goods-option__item[data-type=option_mall] .col--mall", function() {
	
	insertLogLSV(24156); // LP/SRP>갤러리형 리스팅>옵션 레이어>로고/옵션/환산가/가격 클릭수
	
	var modelno = $(this).closest("li").attr("data-modelno");
	
	window.open("/detail.jsp?modelno="+modelno);
});
// 그룹모델 마우스 오버 시 썸네일 이미지 변경
$(document).on("mouseover", "li.option__row", function() {
	// 현재 노출되는 이미지와 선택된 이미지가 다르면 교체한다.
	if( $(this).attr("data-img") != $(this).closest("li.prodItem").find(".item__thumb img").attr("src") ) {
		$(this).closest("li.prodItem").find(".item__thumb img").attr("src", $(this).attr("data-img"));
	}
});

//상품비교
$(document).on("click", ".btn--opt-compare", function() {
	var vModelNames = ""; 
	$("div.opt--chk input:checkbox[class='input--checkbox-item']:checked").each(function(i, v){
		var vModelName ="G"+$(this).attr("id").replace(/[^0-9]/g,'')+",";
		var vChk = false; //true 일 때 중복
		$("ul.compare-prod__list li").each(function(){
			if(vModelName.indexOf($(this).attr("prodno")) > -1){
				vChk = true;
				return false;
			}
		});
		if(!vChk){
			vModelNames += vModelName;
		}
	});
	vModelNames = vModelNames.slice(0, -1);
	compareProdInput(vModelNames);
});

//상품 비교 썸네일 
$(document).on("click", ".ico-item--compare", function() {
	var vModelName = $(this).closest("li").attr("data-model-origin"); 
	var vChk = false;
	$("ul.compare-prod__list li").each(function(){
		if(vModelName.indexOf($(this).attr("prodno")) > -1){
			vChk = true;
			return false;
		}
	});
	if(!vChk){
		compareProdInput("G"+vModelName);
	}
});

//상세검색 개수 노출, 미노출
$(document).on("click", "button.search-box__btn--unfold", function() {
	$("dl.search-box-row").each(function(i,v){
		if($(v).hasClass("is--unfold")){
			$(v).find("span.search-box__util--count").hide();
		}else{
			$(v).find("span.search-box__util--count").show();
		}
	});
});

// SRP C 타입
$(document).on("click", "table.tb-conditon--type-c tbody tr td a", function() {
	if($(this).attr("data-modelno")!==undefined && $(this).attr("data-modelno").length>0) {
		insertSearchKeywordViewLog_Wide(1, $(this).attr("data-modelno"), "", "");
	}
});

// 상품평 평점
$(document).on("click", ".item__etc--score a", function() {
	if($(this).closest("li.prodItem").attr("data-id")!==undefined && $(this).closest("li.prodItem").attr("data-id").length>0) {
		var $li = $(this).closest("li.prodItem");
		var dataType = $li.attr("data-type");
		var rank = $li.attr("data-all-rank");
		if(dataType=="model") { // 가격비교
			if(listType=="list") {
				// LP성과측정
				var qstrObj = {};
				qstrObj["click"] = "click";
				qstrObj["modelno"] = $li.attr("data-id").replace("model_","");
				qstrObj["rank"] = rank;
				insertDetailAttLog_Wide(qstrObj);
				insertLogLSV(14381, param_cate); // LP 가격비교 클릭
			} else if(listType=="search") {
				insertSearchKeywordViewLog_Wide(1, $li.attr("data-id").replace("model_",""), "", rank);
				insertLogLSV(14446); // SRP 가격비교 클릭
			}
		}
	}
});

// 갤러리뷰 > 다른옵션 더보기, 쇼핑몰 더보기
$(document).on("click", ".goods-option__item a", function() {
	// 다른옵션 더보기
	if($(this).attr("data-modelno")!==undefined && $(this).attr("data-modelno").length>0) {
		if(listType=="list") {
			// LP성과측정
			var qstrObj = {};
			qstrObj["click"] = "click";
			qstrObj["modelno"] = $(this).attr("data-modelno");
			qstrObj["rank"] = $(this).attr("data-rank");
			insertDetailAttLog_Wide(qstrObj);
			if( Synonym_From == "search" && Synonym_Keyword.length > 0 ) { // 분류검색어 진입시
				insertSearchKeywordViewLog_Wide(1, $(this).attr("data-modelno"), "", $(this).attr("data-rank"));
			}
		} else if(listType=="search") {
			insertSearchKeywordViewLog_Wide(1, $(this).attr("data-modelno"), "", $(this).attr("data-rank"));
		}
	// 쇼핑몰 더보기
	} else if($(this).attr("data-plno")!==undefined && $(this).attr("data-plno").length>0) {
		if(listType=="list") {
			// LP성과측정
			var qstrObj = {};
			qstrObj["click"] = "click";
			qstrObj["plno"] = $(this).attr("data-plno");
			qstrObj["rank"] = $(this).attr("data-rank");
			insertDetailAttLog_Wide(qstrObj);
			insertLogLSV(14382); // LP 일반상품 클릭
		} else if(listType=="search") {
			insertSearchKeywordViewLog_Wide(2, "", $(this).attr("data-plno"), $(this).attr("data-rank"));
			insertLogLSV(14447); // SRP 일반상품 클릭
		}
	};
});

//미니vip 조건명 클릭시 성과로그
$(document).on("click", "span.tx--condition", function(){
	var vModelNo = $(this).closest("li").attr("data-modelno");
	var rank = $(this).closest("li.prodItem").attr("data-all-rank");
	if(param_cate.length > 0){
		var qstrObj = {};
		qstrObj["click"] = "click";
		qstrObj["modelno"] = vModelNo;
		qstrObj["rank"] = rank;
		insertDetailAttLog_Wide(qstrObj);
	}else if(param_keyword.length > 0){
		insertSearchKeywordViewLog_Wide(1, vModelNo, "", rank);
	}
});

//소모품 레이어 닫기
$(document).on("mouseup", "body", function(e){
	var vSpec3Container = $("#expartsLayer");
	if(typeof e.target !== "undefined"){
		if( vSpec3Container.has(e.target).length === 0){
			 vSpec3Container.hide();
		}
	}
});
//스마트파인더 툴팁 클릭
$(document).on("click", ".info_smartfinder button.btn-alert", function() {
	var laySFInfo = $(".info_smartfinder .lay-alert");
	laySFInfo.fadeIn(300, function() {
		setTimeout(function() {
			laySFInfo.fadeOut(300);
		}, 3000);
	})
	insertLogLSV(25291);
});
// 스마트파인더 스와이프
$(document).on("click", "dl.type--finder-target button.arr", function() {
	var $_parent = $(this).closest(".search-box__inner");
	var $_ul = $_parent.find("ul.finder-icon__list");
	var $_pageCurrent = parseInt($_ul.attr("data-page"));
	var $_pageTotal = parseInt($_ul.attr("data-page-end"));
	
	$_ul.find("li").hide();
	var $_showPageCnt = 0;
	if($(this).hasClass("arr-prev")) { // 이전
		$_showPageCnt = $_pageCurrent - 1;
		// 1페이지 이면 끝페이지로
		if($_showPageCnt==0) {
			$_showPageCnt = $_pageTotal;
		}
	} else if($(this).hasClass("arr-next")) {
		$_showPageCnt = $_pageCurrent + 1;
		// 끝페이지 면 1페이지로
		if($_showPageCnt>$_pageTotal) {
			$_showPageCnt = 1;
		}
	}
	$_ul.find("li[data-page="+$_showPageCnt+"]").show();
	$_ul.attr("data-page", $_showPageCnt);
	
	insertLogLSV(25292);
});

// 할인율 마우스오버 이벤트
$(document).on("mouseenter", "#icoPertip", function() {
	$(".lay-pertip").stop().fadeIn(100);
});
$(document).on("mouseleave", "#icoPertip", function() {
	$(".lay-pertip").stop().fadeOut(100);
});

// 이달의 브랜드 동영상유형 클릭 이벤트
// 동영상 띄우기
$(document).on("click", ".side__ad_brand .s_ad_goods_list[data-s-ad-type=V] .full a", function() {
	var $_appendObj = $(".side__ad_brand .adPlayer");
	var $_videoUrl = $(".side__ad_brand .swiper-slide-active .video_type").attr("data-videourl");
	if( $(".side__ad_brand .s_ad_goods_list[data-s-ad-type=V]").length == 1 ) {
		$_videoUrl = $(".side__ad_brand .video_type").attr("data-videourl");
	}
	$_appendObj.empty();
	
	var vHtml = [];
	var vIndex = 0;
	
	vHtml[vIndex++] = "<div class=\"wrap\">";
	vHtml[vIndex++] = "	<div id=\"adPlayer\">";
	vHtml[vIndex++] = "		<iframe id=\"brandPlayAd\" src=\""+$_videoUrl+"\" allowfullscreen=\"allowfullscreen\"></iframe>";
	vHtml[vIndex++] = "	</div>";
	vHtml[vIndex++] = "	<button type=\"button\"><img src=\"//img.enuri.info/images/rev/btn_close@s28.png\"></button>";
	vHtml[vIndex++] = "</div>";
	
	$_appendObj.html(vHtml.join(""));
	$_appendObj.fadeIn();
});
// 동영상 끄기
$(document).on("click", ".side__ad_brand .adPlayer button", function() {
	$(this).parent().fadeOut();
	$(".side__ad_brand .adPlayer").hide();
});

$(document).on("click", "a.btn_relate_item", function(){
	if ($("#TERMDICLAYER").is(":visible")) {
		$("#TERMDICLAYER").hide();
	}
	var vRelProdModelNo = $(this).data("relprodmodelno");
	var vRelProdModelNm = $(this).data("relprodmodelnm");
	var vModelNo = $(this).data("modelno");
	var vRelBtnText = $(this).data("relbtntext");
	var vOriginModelNo = $(this).data("orgmodelno");
	loadRelatedProd(vModelNo, vRelProdModelNo, vOriginModelNo, vRelProdModelNm, vRelBtnText);
 	if(listType=="list") {
		insertLogLSV(26001, param_cate); // LP > 리스트뷰 > 관련잉크토너
	} else if(listType=="search") {
		insertLogLSV(26263); // SRP > 리스트뷰 > 관련잉크토너
	}
});
/*---------------------------------- 개별로그 ------------------------------------------------------*/
$(document).on("click", "#listBodyDiv .category-lp__name", function() {
	insertLogLSV(24124, param_cate); // LP>카테고리>중분류
});
$(document).on("click", ".category-lp .category-lp__item a", function() {
	insertLogLSV(14211, param_cate); // LP>카테고리>소분류
});
$(document).on("click", ".search-box-row[data-attr-type=factory] dt button.search-box__btn--unfold", function() {
	if(listType=="list") {
		insertLogLSV(14216, param_cate); // LP>상세검색>제조사 >더보기 + 클릭수
	} else if(listType=="search") {
		insertLogLSV(14407); // SRP>상세검색>제조사 >더보기 + 클릭수
	}
});
$(document).on("click", ".search-box-row[data-attr-type=factory] dd input:checkbox", function() {
	if(listType=="list") {
		insertLogLSV(14215, param_cate); // LP>상세검색>제조사 체크박스 클릭수
	} else if(listType=="search") {
		insertLogLSV(14406); // SRP>상세검색>제조사 체크박스 클릭수
	}
});
$(document).on("click", ".search-box-row[data-attr-type=factory] button.btn-sort--pop", function() {
	if(listType=="list") {
		insertLogLSV(14226, param_cate); // LP>제조사 더보기 열린 상태>인기순 정렬 클릭
	} else if(listType=="search") {
		insertLogLSV(14408); // SRP>제조사 더보기 열린 상태>인기순 정렬 클릭
	}
});
$(document).on("click", ".search-box-row[data-attr-type=factory] button.btn-sort--name", function() {
	if(listType=="list") {
		insertLogLSV(14227, param_cate); // LP>제조사 더보기 열린 상태>가나다순 정렬 클릭
	} else if(listType=="search") {
		insertLogLSV(14409); // SRP>제조사 더보기 열린 상태>가나다순 정렬 클릭
	}
});
$(document).on("click", ".search-box-row[data-attr-type=factory] dd button.btn--consonant", function() {
	if(listType=="list") {
		insertLogLSV(18275, param_cate); // LP>제조사>가나다/ABC순 정렬>자음 bar 클릭
	} else if(listType=="search") {
		insertLogLSV(24131); // SRP>제조사>가나다/ABC순 정렬>자음 bar 클릭
	}
});
$(document).on("click", ".search-box-row[data-attr-type=brand] dd input:checkbox", function() {
	if(listType=="list") {
		insertLogLSV(14217, param_cate); // LP>상세검색>브랜드 체크박스 클릭수
	} else if(listType=="search") {
		insertLogLSV(14403); // SRP>상세검색>브랜드 체크박스 클릭수
	}
});
$(document).on("click", ".search-box-row[data-attr-type=brand] dt button.search-box__btn--unfold", function() {
	if(listType=="list") {
		insertLogLSV(14218, param_cate); // LP>상세검색>브랜드 >더보기 + 클릭수
	} else if(listType=="search") {
		insertLogLSV(24438); // SRP>상세검색>브랜드 >더보기 + 클릭수
	}
});
$(document).on("click", ".search-box-row[data-attr-type=brand] button.btn-sort--pop", function() {
	if(listType=="list") {
		insertLogLSV(14228, param_cate); // LP>브랜드 더보기 열린 상태>인기순 정렬 클릭
	} else if(listType=="search") {
		insertLogLSV(14404); // SRP>브랜드 더보기 열린 상태>인기순 정렬 클릭
	}
});
$(document).on("click", ".search-box-row[data-attr-type=brand] button.btn-sort--name", function() {
	if(listType=="list") {
		insertLogLSV(14229, param_cate); // LP>브랜드 더보기 열린 상태>가나다순 정렬 클릭
	} else if(listType=="search") {
		insertLogLSV(14405); // SRP>브랜드 더보기 열린 상태>가나다순 정렬 클릭
	}
});
$(document).on("click", ".search-box-row[data-attr-type=brand] dd button.btn--consonant", function() {
	if(listType=="list") {
		insertLogLSV(18274, param_cate); // LP>제조사>가나다/ABC순 정렬>자음 bar 클릭
	} else if(listType=="search") {
		insertLogLSV(24132); // SRP>제조사>가나다/ABC순 정렬>자음 bar 클릭
	}
});
$(document).on("click", ".search-box-row[data-attr-type=shop] dt button", function() {
	if(listType=="list") {
		insertLogLSV(24125, param_cate); // LP>상세검색>쇼핑몰 더보기 클릭수
	}
});
$(document).on("click", ".search-box-row[data-attr-type=shop] dd input:checkbox", function() {
	if(listType=="list") {
		insertLogLSV(24126, param_cate); // LP>상세검색>쇼핑몰 체크박스 클릭수
	}
});
$(document).on("click", ".search-box-row[data-attr-type=spec] dt button", function() {
	if(listType=="list") {
		insertLogLSV(14220, param_cate); // LP>상세검색>쇼핑몰 더보기 클릭수
	} else if(listType=="search") {
		insertLogLSV(14410); // SRP>상세검색>쇼핑몰 더보기 클릭수
	}
});
$(document).on("click", ".search-box-row[data-attr-type=spec] dd input:checkbox", function() {
	if(listType=="list") {
		insertLogLSV(15021, param_cate); // LP>상세검색>속성 체크박스 클릭수
	} else if(listType=="search") {
		insertLogLSV(14411); // SRP>상세검색>속성 체크박스 클릭수
	}
});
$(document).on("click", ".search-box-row[data-attr-type=reqKwd] li button", function() {
	if(listType=="list") {
		insertLogLSV(14223, param_cate); // LP>상세검색>추천키워드 클릭수
	}
});
$(document).on("click", ".search-box-row[data-attr-type=price] dd button.btn--range-price", function() {
	if(listType=="list") {
		insertLogLSV(14221, param_cate); // LP>상세검색>가격대>가격범위 클릭
	} else if(listType=="search") {
		insertLogLSV(14412); // SRP>상세검색>가격대>가격범위 클릭
	}
});
$(document).on("click", ".search-box-row[data-attr-type=price] dd button.btn--range-search", function() {
	if(listType=="list") {
		insertLogLSV(14222, param_cate); // LP>상세검색>가격대>직접 입력 가격 검색 클릭
	} else if(listType=="search") {
		insertLogLSV(14413); // SRP>상세검색>가격대>직접 입력 가격 검색 클릭
	}
});
$(document).on("click", "button.btn--key-deleted", function() {
	if(listType=="list") {
		insertLogLSV(14224, param_cate); // LP>상세검색>선택한 조건> 엑스버튼 클릭수
	} else if(listType=="search") {
		insertLogLSV(14414); // SRP>상세검색>선택한 조건> 엑스버튼 클릭수
	}
});

$(document).on("click", ".category-exception__list a", function() {
	if(param_cate.substring(0,4)=="2211") {
		insertLogLSV(14345); // (2211)LP> 카테고리상단>기종선택로고>로고 클릭수
	} else if(param_cate.substring(0,4)=="2241") {
		insertLogLSV(14347); // (2241)LP> 카테고리상단>기종선택로고>로고 클릭수
	}
});
$(document).on("click", ".lay-finder-result--ink a", function() {
	insertLogLSV(18576); // LP>잉크,토너 파인더>검색레이어>본품 클릭수
});
$(document).on("click", ".list-filter--finder button.btn--search-more", function() {
	insertLogLSV(18577); // LP>잉크,토너 파인더>리스트>전체보기 버튼 클릭수
});
$(document).on("click", ".list-filter--finder a.goods-item", function() {
	insertLogLSV(18578); // LP>잉크,토너 파인더>리스팅> 본품 클릭 수
});
$(document).on("click", ".list__luxury li a", function() {
	insertLogLSV(24160, param_cate); // LP>추천브랜드 로고 클릭수
});
$(document).on("click", ".part-keyword ul.part-keyword__list input:checkbox", function() {
	insertLogLSV(24127); // SRP>부분검색어 체크박스
});
$(document).on("click", ".part-keyword button.part-keyword__btn--research", function() {
	insertLogLSV(24128); // SRP>부분검색어>재검색 버튼 클릭수
});
$(document).on("click", ".srp-type--c button.srp-type__tab", function() {
	insertLogLSV(24129); // SRP>C타입>용량선택 버튼 클릭수
});
$(document).on("click", ".srp-type--c table.tb-conditon--type-c td a", function() {
	insertLogLSV(24130); // SRP>C타입>가격 클릭수
});
$(document).on("click", ".category-srp--recom-cate dd ul.search-box__list li a", function() {
	insertLogLSV(14386); // SRP > 추천카테고리 > 대카테고리 클릭 수
});
$(document).on("click", ".category-srp--recom-cate dt button", function() {
	insertLogLSV(14387); // SRP > 추천카테고리 더보기 클릭수
});
$(document).on("click", ".category-srp--recom-cate div.search-box--expend ul.search-box__list--recomcate li a", function() {
	insertLogLSV(14389); // SRP > 전체카테고리 > 중카테고리 클릭 수
});
$(document).on("click", ".category-srp--recom-cate div.search-box--expend ul.search-box__list--recomcate li.is--active a", function() {
	insertLogLSV(14391); // SRP > 전체카테고리 > 소카테고리 레이어>중카테고리 클릭 수
});
$(document).on("click", ".category-srp--recom-cate div.search-box--expend ul.search-box__list--recomcate ul.search-box__sub li a", function() {
	insertLogLSV(14392); // SRP > 전체카테고리 > 소카테고리 레이어>소카테고리 클릭 수
});
$(document).on("click", ".category-srp--recom-cate div.search-box--expend button.search-box__btn--unfold", function() {
	insertLogLSV(14393); // SRP > 전체카테고리 > 대카테고리별 더보기버튼 클릭 수
});
$(document).on("click", ".category-srp--list-cate ul li[data-type=all] a", function() {
	insertLogLSV(14394); // SRP > 카테고리 내비게이션 > 전체 클릭 수
});
$(document).on("click", ".category-srp--list-cate ul li[data-type=depth1] a", function() {
	insertLogLSV(14395); // SRP > 카테고리 내비게이션 > 대카테고리 클릭 수
});
$(document).on("click", ".category-srp--list-cate ul li[data-type=depth2] a", function() {
	insertLogLSV(14396); // SRP > 카테고리 내비게이션 > 중카테고리 클릭 수
});
$(document).on("click", ".category-srp--list-cate ul.category-srp__list li a", function() {
	if(param_cate.length==2) {
		insertLogLSV(14398); // SRP > 대 카테고리 선택 > 중카테고리 클릭 수
	} else if(param_cate.length==4) {
		insertLogLSV(14399); // SRP > 중 카테고리 선택 > 소카테고리 클릭 수
	}
});
$(document).on("click", "dl.type--recomm-brand .search-box__r-brand li a", function() {
	insertLogLSV(14401); // SRP > 추천 브랜드 로고 클릭 수
});
$(document).on("click", "dl.type--recomm-brand dt button", function() {
	insertLogLSV(14402); // SRP > 추천 브랜드 더보기 클릭 수 (브랜드 더보기 클릭 수 포함)
});
$(document).on("click", "#noSearchListDiv .no-result__foot a", function() {
	insertLogLSV(14443); // SRP > 결과없음 > 신상품 등록요청 버튼 클릭 수
});
$(document).on("click", ".related-prod ul.recent-prod__list li a", function() {
	insertLogLSV(14444); // SRP > 결과없음 > 최근본상품 > 상품 클릭 수
});
$(document).on("click", ".related-prod__cont ul.recent-prod__list li a", function() {
	insertLogLSV(24133); // SRP > 결과없음 > 연관인기상품 > 상품 클릭 수
});
$(document).on("click", ".goods-item .item__thumb a", function() {
	if($(this).closest("li.prodItem").attr("data-id")!==undefined && $(this).closest("li.prodItem").attr("data-id").length>0) {
		var $li = $(this).closest("li");
		var dataType = $li.attr("data-type");
		var rank = $li.attr("data-all-rank");
		if(listType=="list") {
			if(dataType=="model") { // 가격비교
				// LP성과측정
				var qstrObj = {};
				qstrObj["click"] = "click";
				qstrObj["modelno"] = $(this).closest("li.prodItem").attr("data-id").replace("model_","");
				qstrObj["rank"] = rank;
				insertDetailAttLog_Wide(qstrObj);
			}
		} else if(listType=="search") {
			if(dataType=="model") { // 가격비교
				insertSearchKeywordViewLog_Wide(1, $(this).closest("li.prodItem").attr("data-id").replace("model_",""), "", rank);
			}
		}
	}
	
	if(listType=="list") {
		insertLogLSV(14381, param_cate); // LP 가격비교 클릭
	} else if(listType=="search") {
		insertLogLSV(14446); // SRP 가격비교 클릭
	}
});
$(document).on("click", ".goods-item .item__thumb .item__menu .item__menu__inner button.item__btn--movie", function() {
	if(viewType==1) {
		if(listType=="list") {
			insertLogLSV(24148, param_cate); // LP > 리스트뷰 > 썸네일 하단 동영상 버튼
		} else if(listType=="search") {
			insertLogLSV(26249); // SRP > 리스트뷰 > 썸네일 하단 동영상 버튼
		}
	} else if(viewType==2) {
		if(listType=="list") {
			insertLogLSV(24152, param_cate); // LP > 갤러리뷰 > 썸네일 하단 동영상 버튼
		} else if(listType=="search") {
			insertLogLSV(26267); // SRP > 갤러리뷰 > 썸네일 하단 동영상 버튼
		}
	}
});
$(document).on("click", ".goods-item .item__thumb .item__menu .item__menu__inner button.item__btn--view", function() {
	if(viewType==1) {
		if(listType=="list") {
			insertLogLSV(15016, param_cate); // LP > 리스트뷰 > 썸네일 하단 이미지레이어 버튼
		} else if(listType=="search") {
			insertLogLSV(26250); // SRP > 리스트뷰 > 썸네일 하단 이미지레이어 버튼
		}
	} else if(viewType==2) {
		if(listType=="list") {
			insertLogLSV(14312, param_cate); // LP > 갤러리뷰 > 썸네일 하단 이미지레이어 버튼
		} else if(listType=="search") {
			insertLogLSV(26268); // SRP > 갤러리뷰 > 썸네일 하단 이미지레이어 버튼
		}
	}
});
$(document).on("click", ".goods-item .item__thumb .item__menu .item__menu__inner button.item__btn--compare", function() {
	if(viewType==1) {
		if(listType=="list") {
			insertLogLSV(15017, param_cate); // LP > 리스트뷰 > 썸네일 하단 비교 버튼
		} else if(listType=="search") {
			insertLogLSV(26251); // SRP > 리스트뷰 > 썸네일 하단 비교 버튼
		}
	} else if(viewType==2) {
		if(listType=="list") {
			insertLogLSV(14313, param_cate); // LP > 갤러리뷰 > 썸네일 하단 비교 버튼
		} else if(listType=="search") {
			insertLogLSV(26269); // SRP > 갤러리뷰 > 썸네일 하단 비교 버튼
		}
	}
});
$(document).on("click", ".goods-item .item__thumb .item__menu .item__menu__inner button.item__btn--zzim", function() {
	if(viewType==1) {
		if(listType=="list") {
			insertLogLSV(15018, param_cate); // LP > 리스트뷰 > 썸네일 하단 찜 버튼
		} else if(listType=="search") {
			insertLogLSV(26252); // SRP > 리스트뷰 > 썸네일 하단 찜 버튼
		}
	} else if(viewType==2) {
		if(listType=="list") {
			insertLogLSV(14314, param_cate); // LP > 갤러리뷰 > 썸네일 하단 찜 버튼
		} else if(listType=="search") {
			insertLogLSV(26270); // SRP > 갤러리뷰 > 썸네일 하단 찜 버튼
		}
	}
});
$(document).on("click", ".goods-item .item__box .item__info .item__model a.tag--discount", function() {
	insertLogLSV(24151); // LP/SRP>쇼핑몰 프로모션 뱃지 클릭수
});
$(document).on("click", ".goods-item .item__box .item__info .item__attr a.btn--dic, .goods-item .item__box .item__info .item__summ a.btn--dic", function() {
	if(viewType==1) {
		if(listType=="list") {
			insertLogLSV(15364, param_cate); // LP > 리스트뷰 > 요약설명 (밑줄-용어사전)
		} else if(listType=="search") {
			insertLogLSV(26253); // SRP > 리스트뷰 > 요약설명 (밑줄-용어사전)
		}
	}
});
$(document).on("click", ".goods-item .item__box .item__info .item__cont dl dd a", function() {
	if(viewType==1) {
		if(listType=="list") {
			insertLogLSV(15020, param_cate); // LP > 리스트뷰 > 관련정보/뉴스/특가/이벤트 링크
		} else if(listType=="search") {
			insertLogLSV(26257); // SRP > 리스트뷰 > 관련정보/뉴스/특가/이벤트 링크
		}
	}
});
$(document).on("click", ".price__option .option__row .opt--condition .tx--condition, .goods-option .goods-option__item .goods-option__inner .col--name", function() {
	if(viewType==1) {
		if(listType=="list") {
			insertLogLSV(15027, param_cate); // LP > 리스트뷰 > 조건명 (밑줄있음-용어사전)
		} else if(listType=="search") {
			insertLogLSV(26259); // SRP > 리스트뷰 > 조건명 (밑줄있음-용어사전)
		}
	}
});
$(document).on("click", ".price__option .option__row .opt--condition .tx--price, .goods-option .goods-option__item .goods-option__inner .col--price, .goods-item .item__box .item__price a", function() {
	if(viewType==1) {
		insertLogLSV(15028); // LP/SRP>심플리스트형>가격 클릭수
	} else if(viewType==2) {
		insertLogLSV(14316); // LP/SRP>갤러리형 리스팅>가격 클릭수
		if(listType=="list") {
			insertLogLSV(14381, param_cate); // LP 가격비교 클릭
		} else if(listType=="search") {
			insertLogLSV(14446); // SRP 가격비교 클릭
		}
		if($(this).closest("li.prodItem").attr("data-id")!==undefined && $(this).closest("li.prodItem").attr("data-id").length>0) {
			var $li = $(this).closest("li.prodItem");
			var dataType = $li.attr("data-type");
			var rank = $li.attr("data-all-rank");
			if(listType=="list") {
				if(dataType=="model") { // 가격비교
					// LP성과측정
					var qstrObj = {};
					qstrObj["click"] = "click";
					qstrObj["modelno"] = $(this).closest("li.prodItem").attr("data-id").replace("model_","");
					qstrObj["rank"] = rank;
					insertDetailAttLog_Wide(qstrObj);
				}
			} else if(listType=="search") {
				if(dataType=="model") { // 가격비교
					insertSearchKeywordViewLog_Wide(1, $(this).closest("li.prodItem").attr("data-id").replace("model_",""), "", rank);
				}
			}
		}
	}
});
$(document).on("click", ".goods-item .item__box .item__price .price__option .option__row .opt--chk input:checkbox", function() {
	insertLogLSV(15039); // LP/SRP>심플리스트형>비교/찜 선택박스 클릭수
});
$(document).on("click", ".goods-item .item__box .item__price .price__option .option__row .opt--chk .lay-opt--chk button.btn--opt-compare", function() {
	if(listType=="list") {
		insertLogLSV(15040, param_cate); // LP > 리스트뷰 > (모델 체크 후) 비교 버튼
	} else if(listType=="search") {
		insertLogLSV(26261); // SRP > 리스트뷰 > (모델 체크 후) 비교 버튼
	}
});
$(document).on("click", ".goods-item .item__box .item__price .price__option .option__row .opt--chk .lay-opt--chk button.btn--opt-zzim", function() {
	if(listType=="list") {
		insertLogLSV(15041, param_cate); // LP > 리스트뷰 > (모델 체크 후) 찜 버튼
	} else if(listType=="search") {
		insertLogLSV(26262); // SRP > 리스트뷰 > (모델 체크 후) 찜 버튼
	}
});
$(document).on("click", ".goods-item .item__box .item__info .item__etc .item__etc--cate .btn--go-cate", function() {
	insertLogLSV(24149); // SRP>심플리스트형>해당 카테고리로 이동 버튼 클릭수
});
$(document).on("click", ".goods-item .item__box .item__info .item__etc .item__etc--enuripc .btn--go-enuripc", function() {
	insertLogLSV(18495); // LP/SRP>에누리 조립PC 버튼 클릭
});
$(document).on("click", ".lpcosmetics__label a, .lpfurniture__tit a", function() {
	insertLogLSV(24150); //LP/SRP>심플리스트형>이미지속성 설명 클릭수
});
$(document).on("click", ".prodItem[data-type=model] .item__model>a", function() {
	var $li = $(this).closest("li.prodItem");
	var clickModelNo = $li.attr("data-model-origin");
	var rank = $li.attr("data-all-rank");
	if(listType=="list") {
		insertLogLSV(14381); // LP > 가격비교 상품
		// LP성과측정
		var qstrObj = {};
		qstrObj["click"] = "click";
		qstrObj["modelno"] = clickModelNo;
		qstrObj["rank"] = rank;
		insertDetailAttLog_Wide(qstrObj);
		if( Synonym_From == "search" && Synonym_Keyword.length > 0 ) { // 분류검색어 진입시
			insertSearchKeywordViewLog_Wide(1, clickModelNo, "", rank);
		}
	} else if(listType=="search") {
		insertLogLSV(14446); // SRP > 가격비교 상품
		insertSearchKeywordViewLog_Wide(1, clickModelNo, "", rank);
	}
	
	if(viewType==1) {
		insertLogLSV(15019); // LP/SRP>심플리스트형>모델명 텍스트
	} else if(viewType==2) {
		insertLogLSV(14315); // LP/SRP>갤러리형 리스팅>모델명 텍스트 클릭수
	}
});
$(document).on("click", ".prodItem[data-type=pl] a", function() {
	var $li = $(this).closest("li.prodItem");
	var clickPlNo = $li.attr("data-id").replace("pl_","");
	var rank = $li.attr("data-all-rank");
	if(listType=="list") {
		insertLogLSV(14382); // LP > 일반상품 클릭수
		// LP성과측정
		var qstrObj = {};
		qstrObj["click"] = "click";
		qstrObj["plno"] = clickPlNo;
		qstrObj["rank"] = rank;
		insertDetailAttLog_Wide(qstrObj);
		if( Synonym_From == "search" && Synonym_Keyword.length > 0 ) { // 분류검색어 진입시
			insertSearchKeywordViewLog_Wide(2, "", clickPlNo, rank);
		}
	} else if(listType=="search") {
		insertLogLSV(14447); // SRP > 일반상품 클릭수
		insertSearchKeywordViewLog_Wide(2, "", clickPlNo, rank);
	}
});
$(document).on("click", ".goods-option__item .goods-option__inner .col--select input:checkbox", function() {
	insertLogLSV(24155); // LP/SRP>갤러리형 리스팅>옵션 레이어>체크박스 가격비교
});

$(document).on("click", ".compare-prod__list a", function() {
	insertLogLSV(14376); // 홈/LP/VIP/SRP/지식통>하단 상품비교 레이어>상품 클릭수
});

$(document).on("click", "button.selectDelBtn", function() {
	insertLogLSV(14378); // 홈/LP/VIP/SRP/지식통>하단 상품비교 레이어>선택상품 삭제 클릭수
});

$(document).on("click", "button.selectCompBtn", function() {
	insertLogLSV(14379); // 홈/LP/VIP/SRP/지식통>하단 상품비교 레이어>선택상품 비교 버튼 클릭수
});

$(document).on("click", ".finder-result__list a", function() {
	insertLogLSV(18578); // LP>잉크,토너 파인더>리스팅> 본품 클릭 수
});

$(document).on("click", "button.model-finder__btn i", function() {
	insertLogLSV(24529); //LP>잉크,토너 파인더 > 검색 버튼 클릭수 (2021-03-31 개편)
});

$(document).on("click", ".spec3Line", function() {
	if(listType=="list") {
		insertLogLSV(24961, param_cate); // LP > 리스트뷰 > 연관상품 (밑줄)
	} else if(listType=="search") {
		insertLogLSV(26254); // SRP > 리스트뷰 > 연관상품 (밑줄)
	}
});
$(document).on("click", ".item__relate_layer .item__rl_cont .cont_left a", function() {
	if(listType=="list") {
		insertLogLSV(26002, param_cate); // LP > 리스트뷰 > 관련잉크토너 레이어 > 본품
	} else if(listType=="search") {
		insertLogLSV(26264); // SRP > 리스트뷰 > 관련잉크토너 레이어 > 본품
	}
});
$(document).on("click", "#expartsLayer_inner .thum, #expartsLayer_inner .tx_info a, #expartsLayer_inner .tx_opt a", function() {
	if(listType=="list") {
		insertLogLSV(24962, param_cate); // LP > 리스트뷰 > 연관상품 레이어 > 상품클릭
	} else if(listType=="search") {
		insertLogLSV(26255); // SRP > 리스트뷰 > 연관상품 레이어 > 상품클릭
	}
});
$(document).on("click", ".item__relate_layer .item__rl_cont .cont_right .item__r_list .r_list .rl_info a", function() {
	if(listType=="list") {
		insertLogLSV(26377, param_cate); // LP > 리스트뷰 > 관련잉크토너 레이어 > 소모품
	} else if(listType=="search") {
		insertLogLSV(26265); // SRP > 리스트뷰 > 관련잉크토너 레이어 > 소모품
	}
});
$(document).on("click", ".item__relate_layer .item__rl_cont .cont_right .item__r_list .r_list .rl_zzim button", function() {
	if(listType=="list") {
		insertLogLSV(26003, param_cate); // LP > 리스트뷰 > 관련잉크토너 레이어 > 찜
	} else if(listType=="search") {
		insertLogLSV(26266); // SRP > 리스트뷰 > 관련잉크토너 레이어 > 찜
	}
});
$(document).on("click", ".attrs.has-dic .btn--dic", function() {
	if(listType=="list") {
		insertLogLSV(26272, param_cate); // LP > 상세검색 > 속성밑줄 클릭 용어사전
	}
});
$(document).on("click", "button[data-type=smartfinder_button]", function() {
	if(listType=="list") {
		insertLogLSV(26330, param_cate); // LP > 상세검색 > 이미지형 속성
	}
});
$(document).on("click", "button[data-type=smartfinder_texthighlight]", function() {
	if(listType=="list") {
		insertLogLSV(26329, param_cate); // LP > 상세검색 > 텍스트강조형 (미카테고리 속성화 포함)
	}
});
/*---------------------------------- // 개별로그 ------------------------------------------------------*/