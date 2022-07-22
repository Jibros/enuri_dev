// 표준PC
// LP 특정카테 에서만, SRP 는 전체 적용
// LP 적용카테 : 0405,0707,0708,0713,0703,0705,0711,0704,071307,071306,0414
function set_enuripc() {
	if(modelNoSet && modelNoSet.size>0) {
		var ingiModelnos = "";
		modelNoSet.forEach(function(ingModelNo) {
			if(ingModelNo!==undefined) {
				if(ingiModelnos.length>0) {
					ingiModelnos += ",";
				}
				ingiModelnos += ingModelNo;
			}
		});
		var param = {
			"procType" : 1,
			"modelno" : ingiModelnos
		}

		var ajaxObj = $.ajax({
			type : "get",
			url : "/enuripc/ajax/getEnuripcStandGoods_ajax.jsp",
			async: true,
			data : param,
			dataType: 'json',
			success : function(json) {
				var enuripclist = json["enuripcStandGoodsList"];
				for(var i = 0;i<enuripclist.length;i++){
					var modelRootObj = $("div.goods-list li[data-id='model_"+enuripclist[i].modelno+"']");
					var modelObj = modelRootObj.find(".item__etc ul");
					var html = "<li class=\"item__etc--enuripc\">";
					html += "		<a href=\"/enuripc/detail.jsp?sy_no="+enuripclist[i].sy_no+"\" class=\"btn--go-enuripc\" title=\"새창이 열립니다.\" target=\"_blank\">에누리 조립PC로<i class=\"ico-enuripc-rarr lp__sprite\"></i></a>";
					html += "	</li>";
					if(modelObj.length>0) {
						try {
							modelObj.append(html);
						} catch(e) {
				//			modelObj.parent().append(html);
						}
					}
				}
			}
		});
	}
}

// 모델 이미지 위 태그 색상 노출
function setListImageInIconSet() {
	if(modelNoSet && modelNoSet.size>0) {
		var ingiModelnos = "";
		modelNoSet.forEach(function(ingModelNo) {
			if(ingModelNo!==undefined) {
				if(ingiModelnos.length>0) {
					ingiModelnos += ",";
				}
				ingiModelnos += ingModelNo;
			}
		});
		var param = {
			"procType" : "1",
			"modelnos" : ingiModelnos
		}
		var ajaxObj = $.ajax({
			type : "get",
			url : "/lsv2016/ajax/getGoods_List_Colors_ajax.jsp",
			async: true,
			data : param,
			dataType : "json",
			success: function(json) {
				var goodsColorsListObj = json["goodsColorsList"];
				var goodsColorsCnt = json["goodsColorsCnt"];
				var goodsDisplayListObj = json["goodsDisplayList"];
				var goodsDisplayCnt = json["goodsDisplayCnt"];
				var goodsDisplayAttrListObj = json["goodsDisplayAttrList"];
				var goodsDisplayAttrCnt = json["goodsDisplayAttrCnt"];
				var goodsThumbTypeListObj = json["goodsThumbTypeList"];

				// 20190814 [PC/M] LP/SRP 썸네일 이미지 내 속성 노출
				// 20190822 3가지 타입으로 수정
				// 카테고리별 써머리 타입 정보 배열 Array
				var cateTypeAry = new Array();
				if(goodsThumbTypeListObj && goodsThumbTypeListObj.length>0) {
					$.each(goodsThumbTypeListObj, function(Index, listData) {
						var cateno = listData["category"];
						cateTypeAry[cateno] = listData["type"];
					});
				}

				var gcAry = new Array();
				if(goodsColorsListObj && goodsColorsListObj.length>0) {
					$.each(goodsColorsListObj, function(Index, listData) {
						var modelno = listData["modelno"];

						var html = "";
						for(var i=1; i<=5; i++) {
							var goods_colorL = listData["goods_color"+i+"_1"];
							var goods_colorR = listData["goods_color"+i+"_2"];
							if(!goods_colorL) goods_colorL = "";
							if(!goods_colorR) goods_colorR = "";

							if(goods_colorL.length==0) break;

							if(i==1) {
								html += "<ul class=\"tag_list tag_hue\">";
							}

							if(goods_colorR.length==0) {
								if(goods_colorL.toLowerCase()=="ffffff") {
									html += "<li class=\"w\"><em>&nbsp;</em></li>";
								} else {
									html += "<li><em style=\"background:#"+goods_colorL+";\">&nbsp;</em></li>";
								}
							} else {
								html += "<li><em class=\"half\" style=\"background:#"+goods_colorL+";\">&nbsp;</em>";
								html += "<em class=\"half\" style=\"background:#"+goods_colorR+";\">&nbsp;</em></li>";
							}
						}
						if(html.length>0) {
							html += "</ul>";
							gcAry[modelno] = html;
						}
					});
				}

				var gdAry = new Array();
				if(goodsDisplayListObj && goodsDisplayListObj.length>0) {
					$.each(goodsDisplayListObj, function(Index, listData) {
						var cate = listData["cate"];
						var modelno = listData["modelno"];
						var specnoList = listData["specnoList"];
						var titleList = listData["titleList"];

						var html = "";
						if(specnoList.length>0) {
							var specnoListAry = specnoList.split(",");
							var titleListAry = titleList.split(",");

							if(titleListAry && titleListAry.length>0) {

								// B,C 타입
								if(cateTypeAry[cate] == "B" || cateTypeAry[cate] == "C") {
									html += "<span class=\"tag_sub\">"+titleListAry[0]+"</span>";
								// D 타입
								} else if(cateTypeAry[cate] == "D") {
									var grade = titleListAry[0].replace("등급","");
									html += "<span class=\"tag_energy grade"+grade+"\">"+titleListAry[0]+"</span>";
								// 기존 ( A 타입 )
								} else {
									html += "<div class=\"tag_list pos_tr tag_blk\">";
									for(var i=0; i<titleListAry.length; i++) {
										html += "<span>"+titleListAry[i]+"</span>";
									}
									html += "</div>";
								}
							}
						}
						if(html.length>0) gdAry[modelno] = html;
					});
				}

				var gdaAry = new Array();
				if(goodsDisplayAttrListObj && goodsDisplayAttrListObj.length>0) {
					$.each(goodsDisplayAttrListObj, function(Index, listData) {
						var category = listData["category"];
						var modelno = listData["modelno"];
						var orderno = listData["orderno"];
						var attribute_idList = listData["attribute_idList"];
						var attribute_element_idList = listData["attribute_element_idList"];
						var attribute_elementList = listData["attribute_elementList"];

						var html = "";
						if(attribute_idList.length>0) {
							var aiListAry = attribute_idList.split(",");
							var aeiListAry = attribute_element_idList.split(",");
							var aeListAry = attribute_elementList.split(",");

							if(aeListAry && aeListAry.length>0) {

								// B,C,D 타입
								if(cateTypeAry[category]) {
									for(var i=0; i<aeListAry.length; i++) {
										html += "<span class=\"tag_spec\">"+aeListAry[i]+"</span>";
									}
								// 기존 ( A 타입 )
								} else {
									html += "<div class=\"tag_list pos_br tag_blu\">";
									for(var i=0; i<aeListAry.length; i++) {
										html += "<span>"+aeListAry[i]+"</span>";
									}
									html += "</div>";
								}
							}
						}
						if(html.length>0){
							// B,C,D 타입
							if(cateTypeAry[category]) {
								// "0502" 타입만 두개가 노출된다.
								if(!gdaAry[modelno]){
									gdaAry[modelno] = html;
								} else if(category == "0502") {
									if(orderno == 1){
										gdaAry[modelno] = html+gdaAry[modelno];
									}else if(orderno == 2){
										gdaAry[modelno] = gdaAry[modelno]+html;
									}
								}
							// 기존 ( A 타입 )
							} else {
								if(gdaAry[modelno]){
									if(orderno == 1){
										gdaAry[modelno] = html+gdaAry[modelno];
									}else if(orderno == 2){
										gdaAry[modelno] = gdaAry[modelno]+html;
									}
								}else{
									gdaAry[modelno] = html;
								}
							}
						}
					});
				}

				var listLiAry = $("li.prodItem[data-type=model]");

				for(var i=0; i<listLiAry.length; i++) {
					var liItem = $(listLiAry[i]);
					var modelno = liItem.attr("data-id").replace("model_", "");
					// 20190814 [PC/M] LP/SRP 썸네일 이미지 내 속성 노출
					// 20190822 3가지 타입으로 수정
					var tagClassPrefix = "tag_type_";
					var tagClass = "a";
					var catenoOrigin = liItem.attr("cate");
					var cateno = "";

					var cateExtBool = false;

					if(catenoOrigin && catenoOrigin.length==8) {
						cateno = catenoOrigin.substr(0, 4);
						if(cateTypeAry[cateno]) {
							tagClass = cateTypeAry[cateno].toLowerCase();
							cateExtBool = true;
						}
					}

					var iconHtml = "";
					if(modelno && modelno.length>0) {
						var thumAreaObj = liItem.find(".item__thumb");
						// 슈퍼탑 광고상품이 아닐 경우 상단 아이콘도 붙임
						if(thumAreaObj.find(".ad").length<1) {
							if(gdAry[modelno] && gdAry[modelno].length>0) iconHtml += gdAry[modelno];
							if(gdaAry[modelno] && gdaAry[modelno].length>0) {
								if(cateExtBool) {
									iconHtml += gdaAry[modelno];
								} else {
									iconHtml += "<div class=\"blue\">"+gdaAry[modelno]+"</div>";
								}
							}

							if(iconHtml.length>0) {
								iconHtml = "<div class=\"tag_group " + tagClassPrefix + tagClass + "\">" + iconHtml ;
								if(gcAry[modelno] && gcAry[modelno].length>0) iconHtml += gcAry[modelno];
								iconHtml += "</div>";
							}else{
								iconHtml = "<div class=\"tag_group " + tagClassPrefix + tagClass + "\">";
								if(gcAry[modelno] && gcAry[modelno].length>0) iconHtml += gcAry[modelno];
								iconHtml += "</div>";
							}
						}else{
							iconHtml = "<div class=\"tag_group " + tagClassPrefix + tagClass + "\">";
							if(gcAry[modelno] && gcAry[modelno].length>0) iconHtml += gcAry[modelno];
							iconHtml += "</div>";
						}
					}

					if(iconHtml.length>0) {
						thumAreaObj.find(".img_tag_v2").append(iconHtml);
					}
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				//alert(xhr.status);
				//alert(thrownError);
			}
		});
	}
}

// 뉴스,브랜드관, 이벤트, 특가, 사용기
function setModelEvent() {
	if(modelNoSet && modelNoSet.size>0) {
		var ingiModelnos = "";
		modelNoSet.forEach(function(ingModelNo) {
			if(ingModelNo!==undefined) {
				if(ingiModelnos.length>0) {
					ingiModelnos += ",";
				}
				ingiModelnos += ingModelNo;
			}
		});
		var param = {
			"modelnos" : ingiModelnos
		}

		var ajaxObj = $.ajax({
			type : "get",
			url : "/lsv2016/ajax/getModelsEventInfo_ajax2.jsp",
			async: true,
			data : param,
			dataType : "json",
			success: function(json) {
				var modelEventContentListObj = json["modelEventContentList"];
				var factoryEventContentListObj = json["factoryEventContentList"];
				var modelContentCnt = ( modelEventContentListObj && modelEventContentListObj.length > 0 ) ? modelEventContentListObj.length  : 0;
				var factoryContentCnt = ( factoryEventContentListObj && factoryEventContentListObj.length > 0 ) ? factoryEventContentListObj.length  : 0;

				if(modelContentCnt>0) {
					$.each(modelEventContentListObj, function(Index, listData) {
						var modelno = listData["modelno"];
						var subList = listData["sub"];
						var appendHtml = "";

						if($("div.goods-list li[data-id='model_"+modelno+"']").length>0 && subList.length > 0) {

							var modelRootObj = $("li[data-id='model_"+modelno+"']");

							$.each(subList,function(index,subData){
								var icn_tp = subData["icn_tp"];
								var linkUrl = subData["evnt_lnk_url"];
								var content = subData["evnt_view_cts"];
								var icn_tpname = "";

								if(icn_tp=="1"){
									icn_tpname = "뉴스";
								}else if(icn_tp=="2"){
									icn_tpname = "이벤트";
								}else if(icn_tp=="3"){
									icn_tpname = "특가";
								}else if(icn_tp=="4"){
									icn_tpname = "사용기";
								}else if(icn_tp=="5"){
									icn_tpname = "관련정보";
								}else if(icn_tp=="6"){
									icn_tpname = "브랜드관";
								}

								if(linkUrl!==undefined && linkUrl.length>0 && content!==undefined && content.length>0) {
									appendHtml += "<dl>";
									appendHtml += "	<dt>"+icn_tpname+"</dt>";
									appendHtml += "	<dd><a href=\""+linkUrl+"\" target=\"_blank\">"+content+"</a></dd>";
									appendHtml += "</dl>";
								}
							});
							if(appendHtml.length>0) {
								modelRootObj.find(".item__cont").append(appendHtml);
							}
						}
					});
				}

				if(factoryContentCnt>0) {
					$.each(factoryEventContentListObj, function(Index, listData) {
						var factory = listData.factory;
						var factoryContent = listData.evnt_view_cts;
						var factoryLink = listData.evnt_lnk_url;
						var factoryObject = $("div.goods-list li[data-factory="+factory+"]");
						var appendHtml = "";
						if(factoryLink!==undefined && factoryLink.length>0 && factoryContent!==undefined && factoryContent.length>0) {
							appendHtml += "<dl>";
							appendHtml += "	<dt>브랜드관</dt>";
							appendHtml += "	<dd><a href=\""+factoryLink+"\" target=\"_blank\">"+factoryContent+"</a></dd>";
							appendHtml += "</dl>";
						}

						if($("div.goods-list li[data-factory='"+factory.toUpperCase()+"']").length>0 && appendHtml.length>0) {
							$.each(factoryObject, function(Index, listData) {
								$(listData).find(".item__cont").append(appendHtml);
							});
						}
					});
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				//alert(xhr.status);
				//alert(thrownError);
			}
		});
	}
}

// 리뷰
function setReview() {
	if(modelNoSet && modelNoSet.size>0) {
		var ingiModelnos = "";
		modelNoSet.forEach(function(ingModelNo) {
			if(ingModelNo!==undefined) {
				if(ingiModelnos.length>0) {
					ingiModelnos += ",";
				}
				ingiModelnos += ingModelNo;
			}
		});
		var param = {
			"procType"	: 1,
			"modelnos" : ingiModelnos
		}

		var ajaxObj = $.ajax({
			type : "get",
			url : "/lsv2016/ajax/getKnowBoxFlashReview_ajax.jsp",
			async: true,
			data : param,
			dataType : "json",
			success: function(json) {
				var showCnt = json["showCnt"];
				var knowboxlistObj = json["knowboxlist"];
				var kbFHtmlAry = new Array();

				if(knowboxlistObj && showCnt>0) {
					$.each(knowboxlistObj, function(Index, listData) {
						var kb_no = listData["kb_no"];
						var kb_title = listData["kb_title"];
						var modelno = listData["g_modelno"];
						var html ="";
						if($("div.goods-list li[data-id='model_"+modelno+"']").length>0) {
							var modelRootObj = $("div.goods-list li[data-id='model_"+modelno+"']");
							var appendObj = modelRootObj.find(".item__cont");
							if(kb_no.length>0 && kb_title.length>0) {
								html += "<dl>";
								html += "	<dt>리뷰</dt>";
								html += "	<dd><a href=\"/knowcom/detail.jsp?kbno="+kb_no+"\">"+kb_title+"</a></dd>";
								html += "</dl>";
								appendObj.append(html);
							}
						}
					});
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				//alert(xhr.status);
				//alert(thrownError);
			}
		});
	}
}

// SRP 해당카테고리로
function getModelCateListLinkTitle() {
	var ingiModelnos = "";

	if(modelNoSet && modelNoSet.size>0) {
		modelNoSet.forEach(function(ingModelNo) {
			if(ingModelNo!==undefined) {
				if(ingiModelnos.length>0) {
					ingiModelnos += ",";
				}
				ingiModelnos += ingModelNo;
			}
		});
	}

	if(ingiModelnos.length>0) {
		
		// API 호출
		var gnbDataPromise = $.ajax({
			type: "POST",
			url: "/wide/api/gnbNameListByCate.jsp",
			dataType: "json",
			data: {
				"ingiModelnos" : ingiModelnos
			}
		});
	
		gnbDataPromise.then(drawModelCateList, failModelCateList);
	}
}

function drawModelCateList(dataObj) {
	
	if (dataObj.success) {
		if (dataObj.total > 0) {

			$.each(dataObj.data, function(index, listData) {
			
				var modelno = listData.modelno;
				var cateCode = listData.cateCode;
				var cateNameListObj = listData.cateNameList;
				
				var html = "";
				if($("div.goods-list li[data-id='model_"+modelno+"']").length>0) {
					var modelRootObj = $("div.goods-list li[data-id='model_"+modelno+"']");
					var appendObj = modelRootObj.find(".item__etc ul");
					var cateTipTitle = "";
					for(var i=cateNameListObj.length;i>0;i--) {
						if(cateNameListObj[i-1].cate_nm !==  undefined && cateNameListObj[i-1].cate_nm.length>0) {
							if(cateTipTitle.length>0) cateTipTitle += " > ";
							cateTipTitle += cateNameListObj[i-1].cate_nm;
						}
					}
					
					html += "<li class=\"item__etc--cate\">";
					html += "	<a href=\"/list.jsp?cate="+cateCode+"\" target=\"_blank\" class=\"btn--go-cate\" title=\""+cateTipTitle+" 카테고리로 이동\">";
					html += "		해당 카테고리로<i class=\"ico-adv-rarr lp__sprite\"></i>";
					html += "	</a>";
					html += "</li>";
			
					// 조립PC가 있을 경우 조립 PC 앞으로
					if(appendObj.find(".item__etc--enuripc").length>0) {
						appendObj.find(".item__etc--enuripc").before(html);
					} else {
						appendObj.append(html);
					}
				}
			});
		}
	}

}

// SRP 해당카테고리로 API 호출 실패시
function failModelCateList(errorObj) {
	console.log( "SRP gnbNameListByCate API Call Fail : " + errorObj.statusText);
}


var objListKRNameSelector = new Array;
var objListENGNameSelector = new Array;
function objectNameSelector(nameListObj){
	var objListNameArray = new Array();
	var korNameArray = new Array();
	var engNameArray = new Array();
	var isKorNameArray = false;
	var isEnrNameArray = false;
	var isNumArray = false;
	var strFirstAscii = "";
	var strFirst = "";
	for(var i=0;i<nameListObj.length;i++){
		var firstASC = nameListObj[i].charCodeAt(0);
		if( (firstASC>=44032 && firstASC<=55203) || (firstASC>=12593 && firstASC<=12643) ) {		//한글
			var init = [ 'ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ' ];
			strFirstAscii = Math.floor(((firstASC-44032)/28)/21);
			strFirst = init[strFirstAscii];
			if(korNameArray.indexOf(strFirst) == -1){
				korNameArray[strFirstAscii] = strFirst;
				if(!isKorNameArray && korNameArray[strFirstAscii]!==undefined) {
					isKorNameArray = true;
				}
			}
		} else if( (firstASC>=65 && firstASC<=90) || (firstASC>=97 && firstASC<=122) ) {			//영어
			if(firstASC >= 97 && firstASC <=122){
				firstASC -= 32;
				strFirst = String.fromCharCode(firstASC).toUpperCase(); //A , B, a , b
			}else{
				strFirst = String.fromCharCode(firstASC); //A , B, a , b
			}
			if(engNameArray.indexOf(strFirst) == -1){
				engNameArray[firstASC]=strFirst;
				if(!isEnrNameArray && engNameArray[firstASC]!==undefined) {
					isEnrNameArray = true;
				}
			}
		} else if( firstASC>=48 && firstASC<=57 && !isNumArray) {
			isNumArray = true;
		}
	}
	objListNameArray[0] = korNameArray;
	objListNameArray[1] = isKorNameArray;
	objListNameArray[2] = engNameArray;
	objListNameArray[3] = isEnrNameArray;
	objListNameArray[4] = isNumArray;
	return objListNameArray;
}

//전체를 이름 순서대로 정렬하기
// dataType : brand factory
function objListTextSort(sortObj, dataType) {
	if(sortObj.length==0) return sortObj;
	var tmpArray = new Array();
	if(dataType=="brand") {
		brandAttrList = sortObj;
	} else if(dataType=="factory") {
		factoryAttrList = sortObj;
	}

	var rtnObj = new Array();
	for(var i=0; i<sortObj.length; i++) {
		rtnObj[i] = sortObj[i];

		for(var j=i+1; j<sortObj.length; j++) {
			if(rtnObj[i]>sortObj[j]) {
				var tempItem = rtnObj[i];
				rtnObj[i] = sortObj[j];
				sortObj[j] = tempItem;
			}
		}
	}
	return rtnObj;
}

function objectNameArray(objListNameOrder,objListType){
	var init = [ 'ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ' ];
	var strFirst = "";
	var oldstrFirst = null;
	var objListNameArray = new Array();
	var arycnt = new Array();

	if(objListType == "KR"){
		for(var i=0;i<19;i++){
			objListKRNameSelector[i] =[];
			arycnt[i] = 0;
		}
		for(var i=0;i<objListNameOrder.length;i++){
			var firstASC = objListNameOrder[i].charCodeAt(0);
				strFirst = Math.floor(((firstASC-44032)/28)/21);
				objListKRNameSelector[strFirst][arycnt[strFirst]++] = objListNameOrder[i];
		}
	}else if(objListType == "ENG"){
		for(var i=0;i<122;i++){
			objListENGNameSelector[i] =[];
			arycnt[i] = 0;
		}
		for(var i=0;i<objListNameOrder.length;i++){
			var firstASC = objListNameOrder[i].charCodeAt(0);
			if(firstASC >= 97 && firstASC <=122){
				firstASC -= 32;
				strFirst = String.fromCharCode(firstASC).toUpperCase(); //A , B, a , b
			}else{
				strFirst = String.fromCharCode(firstASC); //A , B, a , b
			}
			objListENGNameSelector[firstASC][arycnt[firstASC]++] = objListNameOrder[i];
		}
	}
}

function objectNameSelect(firstText){
	var objListNameArray = new Array();
	var korNameArray = new Array();
	var engNameArray = new Array();
	var strFirstAscii = "";
	var strFirst = "";
	var firstASC = firstText;
	if( (firstASC>=44032 && firstASC<=55203) || (firstASC>=12593 && firstASC<=12643) ) {		//한글
		var init = [ 'ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ' ];
		strFirstAscii = Math.floor(((firstASC-44032)/28)/21);
	} else if( (firstASC>=65 && firstASC<=90) || (firstASC>=97 && firstASC<=122) ) {			//영어
		if(firstASC >= 97 && firstASC <=122){
			strFirstAscii = firstASC-32;
		}else{
			strFirstAscii = firstASC;
			strFirst = String.fromCharCode(firstASC); //A , B, a , b
		}
	}
	return strFirstAscii;
}

//잉크파인더 레이어, 자동완성
var vInkFinderKeyword = "";
function loadInkFinder(finderKeyword, type) {
	//type : auto (자동완성), layer (검색결과레이어)
	if (typeof finderKeyword == "undefined" || finderKeyword.length == 0) {
		return;
	}
	vInkFinderKeyword = finderKeyword;
	$.ajax({
		type: "get",
		url: "/lsv2016/ajax/getPrinterFinder_ajax.jsp",
		data: "keyword=" + encodeURI(finderKeyword),
		dataType: "json",
		success: function(json) {
			if(type === "layer") {
				drawInkFinderLayer(json);
			} else if (type === "auto") {
				drawInkFinderSearchAutoMake(json);
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
	});
}

var tmpFactoryNm = "";
function drawInkFinderLayer(dataObj) {
	if (dataObj.result == "success") {
		if (dataObj.totalCnt > 0) {
			var appendObj = $(".lay-finder-result--ink .lay-comm--inner");

			var vHtml = "";
			$.each(dataObj.find_list, function(Index, listData) {

				if (tmpFactoryNm != listData.factory) {
					if (tmpFactoryNm.length > 0) {
						vHtml += "		</ul>";
						vHtml += "	</div>";
						vHtml += "</div>";
					}
					vHtml += "	<div class=\"finder-result--ink\">";
					vHtml += "		<div class=\"finder-result__tit\">" + listData.factory + " 프린터 · 복합기</div>";
					vHtml += "			<ul class=\"finder-result__list\">";
				} 
				vHtml += "					<li><a href=\"/list.jsp?cate=" + param_cate.substring(0, 4) + "&prtmodelno=" + listData.modelno + "&srckey=" + vInkFinderKeyword + "\" title=\"" + listData.modelnm + "\">" + listData.modelnm + "</a></li>";
				tmpFactoryNm = listData.factory;
			});
			if (vHtml.length > 0) {
				vHtml += "				</ul>";
				vHtml += "			</div>";
				vHtml += "		</div>";
				appendObj.html(vHtml);
				$(".lay-finder-result--ink").fadeIn(250);
			}
			$("#inkSearchLayerSpan").html("<em>" + vInkFinderKeyword + "</em> 검색결과 (" + dataObj.totalCnt + "개)")
		} else {
			alert("검색결과가 없습니다. \n정확한 모델명으로 다시 검색해 주세요.");
			return;
		}
	} else {
		alert("검색결과가 없습니다. \n정확한 모델명으로 다시 검색해 주세요.");
		return;
	}
}

function drawInkFinderSearchAutoMake(dataObj) {
	var vResult = dataObj.result;
	if (vResult !== "success") return;

	var vFind_List = dataObj.find_list;
	var $div_finderSearchAuthMake = $("#div_finderSearchAuthMake");
	var vHtml = "";

	if (vFind_List.length > 0) {
		var vFactory = "";
		$.each(vFind_List, function(i, v) {
			var vModelNmHtml = v.modelnm;
			//var vRegEx = new RegExp(vAutoMakeKeyword, "i");
			//vModelNmHtml = vModelNmHtml.replace(vRegEx , '<em>'+vAutoMakeKeyword+'</em>');
			var vIndex = vModelNmHtml.toLowerCase().indexOf(vInkFinderKeyword.toLowerCase());
			var vKeywordLength = vInkFinderKeyword.length;
			var vReplaceWord = vModelNmHtml.substring(vIndex, vIndex + vKeywordLength);

			vModelNmHtml = vModelNmHtml.replace(vReplaceWord, '<em>' + vReplaceWord + '</em>');

			if (vFactory !== v.factory) {
				if (i != 0) {
					vHtml += "				</ul>";
					vHtml += "	</div>";
				}
				vHtml += "<div class=\"relate--list-wrap\">";
				vHtml += "   <div class=\"ralate-cate-name\">" + v.factory + " 프린터 · 복합기</div>";
				vHtml += "   		<ul class=\"ralate-model-list\">";
			}
			vHtml += "					<li class=\"ralate-model-name\"><a href=\"/list.jsp?cate=" + param_cate.substring(0, 4) + "&prtmodelno=" + v.modelno + "&srckey=" + vInkFinderKeyword + "\" >" + vModelNmHtml + "</a></li>";
			vFactory = v.factory;
		});
	} else {
		$(".model-finder__form").removeClass("is--active");
	}
	$div_finderSearchAuthMake.html(vHtml);
}

// 이달의 브랜드
function loadKeywordAd() {
	if(listType=="list" && param_cate.length==0) return;
	if(listType=="search" && param_keyword.length==0) return;

	var dataParam = {};

	if(listType=="list") {
		dataParam = {
			"cate" : param_cate.substring(0,4)
		}
	} else if(listType=="search") {
		dataParam = {
			"keyword" : param_keyword
		}
	}

	var keywordADPromise = $.ajax({
		type : "GET",
		url : "/lsv2016/ajax/getNewBrandThema_ajax.jsp",
		dataType : "json",
		data : dataParam
	});
	keywordADPromise.then(drawKeywordAD, failKeywordAD);
}

// 이달의 브랜드
function drawKeywordAD(dataObj) {
	var appendObj = $(".side__ad_brand");
	var html = [];
	var hIdx = 0;
	
	if(dataObj===undefined || dataObj.length==0) {
		$(".appendObj").remove();
		return;
	}
	
	var blVideoAD = false;
	
	html[hIdx++] = "<div class=\"s_ad_tit\">";
	html[hIdx++] = "	<div class=\"s_ad_tit_before\">이달의 브랜드</div>";
	if(dataObj.length>1) {
		html[hIdx++] = "<div class=\"s_ad_tit_after\">이달의 브랜드"; 
		html[hIdx++] = "	<div class=\"swiper-btn ad_btn_prev\"></div>";
		html[hIdx++] = "	<div class=\"swiper-btn ad_btn_next\"></div>";
		html[hIdx++] = "</div>";
	} else {
		html[hIdx++] = "<div class=\"s_ad_tit_after\">이달의 브랜드</div>"; 
	}
	html[hIdx++] = "</div>";
	
	html[hIdx++] = "<div class=\"s_ad_swiper swiper-container\">";
	html[hIdx++] = "	<div class=\"swiper-wrapper\">";
	$(dataObj).each(function(index, item) {
		html[hIdx++] = "	<div class=\"swiper-slide\">";
		html[hIdx++] = "		<div class=\"brand_logo\">";
		html[hIdx++] = " 			<img src=\""+item.strLogoUrl+"\" alt=\"이달의 브랜드 로고\" height=\"20\">";
		if(item.strMainType=="H") {
			html[hIdx++] = " 		<img src=\"//img.enuri.info/images/rev/icon_hitbrand@h20.png\" alt=\"히트브랜드 아이콘\" height=\"20\">";
		}
		html[hIdx++] = "		</div>";
		html[hIdx++] = "		<ul class=\"s_ad_goods_list\" data-s-ad-type=\""+item.strMainType+"\">";
		html[hIdx++] = "			<li class=\"item full\">";
		if(item.strMainType=="V") {
			html[hIdx++] = "			<a href=\"javascript:void(0);\">";
		} else {
			html[hIdx++] = "			<a href=\""+item.strMainImgUrl+"\" title=\"새 창에서 열립니다\" target=\"_blank\">";
		}
		html[hIdx++] = "					<div class=\"thumbs\">";
		if(item.strMainType=="I") {
			html[hIdx++] = "					<img src=\""+item.strMainImg+"\" alt=\"이달의 브랜드 메인 이미지\" width=\"230\" height=\"130\">";
			html[hIdx++] = "					<div class=\"caption link_type\">"+item.strMainTitleText+"</div>";
		} else if(item.strMainType=="V") {
			html[hIdx++] = "					<img src=\""+item.strMainImg+"\" alt=\"이달의 브랜드 메인 이미지\" width=\"230\" height=\"130\">";
			html[hIdx++] = "					<div class=\"caption video_type\" data-videourl=\""+item.strMainVideoUrl+"\">"+item.strMainTitleText+"</div>";
		} else if(item.strMainType=="H") {
			html[hIdx++] = "					<div class=\"hitbrand_symbol\"></div>";
			html[hIdx++] = "					<img src=\""+item.strMainImg+"\" alt=\"이달의 브랜드 메인 이미지\" width=\"230\" height=\"130\">";
		}
		html[hIdx++] = "					</div>";
		if(item.strMainType=="H") {
			html[hIdx++] = "				<div class=\"hitbrand_sector_name\">"+item.strMainTitleDesc+"</div>";
			html[hIdx++] = "				<div class=\"goods_name\">"+item.strMainTitleDesc2+"</div>";
		} else {
			html[hIdx++] = "				<div class=\"goods_name\">"+item.strMainTitleDesc;
			if(item.strMainTitleDesc2.length>0) {
				html[hIdx++] = "				<br>"+item.strMainTitleDesc2;
			}
			html[hIdx++] = "				</div>";
		}
		html[hIdx++] = "				</a>";
		html[hIdx++] = "			</li>";
		$(item.detailModelList).each(function(sub_index, sub_item) {
			if(sub_index<2) {
				html[hIdx++] = "	<li class=\"item half\">";
				html[hIdx++] = "		<a href=\""+sub_item.goodsUrl+"\" target=\"_blank\">";
				html[hIdx++] = "			<div class=\"thumbs\">";
				html[hIdx++] = "				<img src=\""+sub_item.strModelImage+"\" width=\"110\" height=\"76\" alt=\"이달의 브랜드 서브 이미지\">";
				html[hIdx++] = "			</div>";
				html[hIdx++] = "			<div class=\"goods_name\">"+sub_item.strModelDesc+"</div>";
				html[hIdx++] = "		</a>";
				html[hIdx++] = "	</li>";
			} else {
				return;
			}
		});
		html[hIdx++] = "		</ul>";
		html[hIdx++] = "	</div>";
		
		if(!blVideoAD && item.strMainType=="V") {
			blVideoAD = true;
		}
	});
	
	html[hIdx++] = "	</div>";
	html[hIdx++] = "</div>";
	
	if(blVideoAD) {
		html[hIdx++] = "<div class=\"adPlayer\"></div>"; // 동영상 유형이 있을 경우 노출
	}
	
	appendObj.html(html.join(""));
	appendObj.show();
	
	// 2개이상일 경우 스와이프 동작
	if(dataObj.length>1) {
		var s_settings = {
			loop: true,
			slidesPerView: 'auto',
			centeredSlides: false,
			spaceBetween: 8,
			nextButton : '.side__ad_brand .ad_btn_next',
			prevButton : '.side__ad_brand .ad_btn_prev',
			
		}
		new Swiper('.s_ad_swiper' ,s_settings);
	}
	
	if(!blVideoAD) {
		$(".appendObj .adPlayer").remove();
	}
	
	var $adbrand = $(".list-body-side .side__ad_brand");
	$(window).on('scroll', function(){
		var scroll = $(window).scrollTop();
		var adbrandT = $adbrand.offset().top; // 브랜드광고 offset top
		var winHhalf = $(window).height() * 0.5; // 스크린 Y 크기절반

		if (scroll > (adbrandT - winHhalf)) {
			$('.side__ad_brand').addClass('on');
		} else {
			$('.side__ad_brand').removeClass('on');
		}
	});
}

// SRP 키워드 브랜드 광고 호출 실패시
function failKeywordAD(errorObj) {
	console.log( "SRP Keyword AD API Call Fail : " + errorObj.statusText);
}

// SRP 추천 카테고리 상품 불러오기
function loadSubCateList(cate) {
	if(cate.length==0 || param_keyword.length==0) return;

	// 속성 API 호출
	var subCatePromise = $.ajax({
		type : "GET",
		url : "/lsv2016/ajax/getSearchCateList_ajax.jsp",
		dataType : "json",
		data : {
			"procType" : "1",
			"cate" : cate,
			"keyword" : param_keyword
		}
	});

	subCatePromise.then(drawSubCate, failSubCate);
}

// SRP 추천 카테고리 상품 그리기
function drawSubCate(dataObj) {
	if( dataObj.sCateList === undefined || dataObj.sCateList.sCateList !== undefined ) {
		return;
	}

	var cate = dataObj.mainCate;
	var appendObj = $("ul.search-box__list--recomcate li[data-cate="+cate+"]");
	appendObj.find(".search-box__sub").empty();
	var appendHtml = "";

	appendHtml += "<ul class=\"search-box__sub\">";
	$(dataObj.sCateList).each(function(index, item) {
		appendHtml += "<li>";
		appendHtml += "	<a href=\"/search.jsp?keyword="+param_keyword+"&cate="+item.cateCode+"&from=list\">";
		appendHtml += "		<span class=\"tx--name\">"+item.cateName+"</span>";
		appendHtml += "		<span class=\"tx--count\">"+ numberWithCommas(item.cateCnt) +"</span>";
		appendHtml += "	</a>";
		appendHtml += "</li>";
	});
	appendHtml += "</ul>";

	if(appendHtml.length>0){
		$("ul.search-box__list--recomcate li").removeClass("is--active");
		appendObj.addClass("is--active");
		appendObj.append(appendHtml);
	}
}

// SRP 추천 카테고리 상품 호출 실패 시
function failSubCate(errorObj) {
	console.log( "SRP subCate API Call Fail : " + errorObj.statusText);
}

// 찜레이어 열고 닫기
var zzimTimer;
function showLayZzim_list(obj){

	clearTimeout(zzimTimer);
	var $layZzim = $(".lay-zzim");
	var $this = $(obj);

	if(!Islogin()) {
		varSSLDomain = "https://www.enuri.com";
		if(confirm("로그인 후 찜 할 수 있습니다.\n로그인 하시겠습니까?")) {
			window.open("https://www.enuri.com/member/login/login.jsp?rtnUrl="+encodeURIComponent(location.href));
		} else {
			return;
		}
	}

	var prodObj = $(obj).closest("li.prodItem");
	var param_key = "";
	var param_type = "model";
	var param_origin = "";

	// 모바일최저가상품 레이어
	if($this.attr("data-zzimno")!==undefined && $this.attr("data-zzimno").indexOf("LAYER_")>-1) {
		param_key = $this.attr("data-zzimno").replace("LAYER_","");
		param_origin = param_key.replace("G:", "");

		insertLogLSV(15030); // LP/SRP>모바일 최저가 아이콘 클릭>레이어열림>찜 클릭수

	// 그룹모델
	} else if($(obj).closest("li").attr("data-type")=="option") {
		$("li.prodItem li.option__row input:checked").each(function(k,v) {
			prodObj = $(v).closest("li.option__row");
			if(param_key.length>0) {
				param_key += ",";
			}
			param_key += "G:" + prodObj.attr("data-modelno");
		});

	//	param_origin = prodObj.attr("data-modelno");
	// 그룹모델 - 갤러리형
	} else if($(obj).closest("li").attr("data-type")=="option_mall") {
		prodObj = $(obj).closest("li.goods-option__item");
		param_key = "G:" + prodObj.attr("data-modelno");
		param_origin = prodObj.attr("data-modelno");

		insertLogLSV(24154); // LP/SRP>갤러리형 리스팅>옵션 레이어>찜버튼

	}else if ($this.attr("data-layertype") == "relProd"){ //프린터 연관상품 레이어일 때
		param_origin =$this.attr("data-modelno");
		param_key =  "G:"+ param_origin;
		prod_type = "model";
	}else { // 상품 메인
		// 메이크샵
		var prod_type = prodObj.attr("data-type");
		if(prod_type=="model") {
			param_key = "G:" + prodObj.attr("data-id").replace("model_","");
			param_origin = prodObj.attr("data-id").replace("model_","");
		} else if(prod_type=="pl") {
			param_key = "P:" + prodObj.attr("data-id").replace("pl_","");
			param_type = "pl";
			param_origin = prodObj.attr("data-id").replace("pl_","");
		} else if (prod_type=="makeshop") {
			param_key = "M:"+ prodObj.attr("data-id").replace("makeshop_","");
			param_type="makeshop";
		}
	}

	$layZzim.show();

	if ( !$(obj).hasClass("is--on") ){

		// 찜하기
		var ajaxObj = $.ajax({
			type : "get",
			url : "/view/include/insertSaveGoodsProc.jsp",
			data : {
				"modelnos" : param_key
			},
			dataType : "json",
			success : function(ajaxResult) {
				if($(obj).closest("li").attr("data-type")=="option") {
					setTimeout(function(){
						$layZzim.removeClass("is--off").addClass("is--show").show();
					},1);

					var split_param_key = param_key.split(",");
					for(var i=0; i<split_param_key.length; i++) {

						$("button[data-zzimno="+split_param_key[i].replace(":", "")+"]").addClass("is--on");
						zzimTmpModelNoSet.add(split_param_key[i].replace("G:",""));
						if(zzimTmpModelNoRemoveSet.has(split_param_key[i].replace("G:",""))) {
							zzimTmpModelNoRemoveSet.delete(split_param_key[i].replace("G:",""));
						}
						if(!zzimLayerSet.has(split_param_key[i].replace("G:",""))) {
							zzimLayerSet.add(split_param_key[i].replace("G:",""));
						}
					}


				} else if(param_type=="model") {
					$("button[data-zzimno="+param_key.replace(":", "")+"]").addClass("is--on");
					setTimeout(function(){
						$layZzim.removeClass("is--off").addClass("is--show").show();
					},1);

					zzimTmpModelNoSet.add(param_origin);
					if(zzimTmpModelNoRemoveSet.has(param_origin)) {
						zzimTmpModelNoRemoveSet.delete(param_origin);
					}
					if(!zzimLayerSet.has(param_origin)) {
						zzimLayerSet.add(param_origin);
					}
				} else {
					
					if (param_type == "makeshop") {
						$("button[data-zzimno="+param_key.replace("M:", "")+"]").addClass("is--on");
					} else {
						$("button[data-zzimno="+param_key.replace(":", "")+"]").addClass("is--on");
					}
					
					setTimeout(function(){
						$layZzim.removeClass("is--off").addClass("is--show").show();
					},1);

					zzimTmpPlNoSet.add(param_origin);
					if(zzimTmpPlNoRemoveSet.has(param_origin)) {
						zzimTmpPlNoRemoveSet.delete(param_origin);
					}
				}

				// 모바일최저가상품 레이어
				if($this.attr("data-zzimno")!==undefined && $this.attr("data-zzimno").indexOf("LAYER_")>-1) {
					$this.addClass("is--on");
				}
			}
		});

	}else{

		if(!confirm("이미 찜한 상품입니다.\n해지하겠습니까?")) {
			return;
		}

		var zzimDelUrl = "/lsv2016/ajax/deleteSaveGoodsProc.jsp";
		if (param_type == "makeshop") {
			zzimDelUrl = "/view/deleteSaveGoodsProc.jsp";
		}
		
		// 찜해제
		var ajaxObj = $.ajax({
			type : "get",
			url : zzimDelUrl,
			data : {
				"modelnos" : param_key,
				"tbln" : "save"
			},
			dataType : "json",
			success : function(ajaxResult) {
				if (param_type == "makeshop") {
					$("button[data-zzimno="+param_key.replace("M:", "")+"]").removeClass("is--on");
				} else {
					$("button[data-zzimno="+param_key.replace(":", "")+"]").removeClass("is--on");
				}
				
				setTimeout(function(){
					$layZzim.addClass("is--off is--show").show();
				},1);

				if(param_type=="model") {
					zzimTmpModelNoSet.delete(param_origin);
					if(!zzimTmpModelNoRemoveSet.has(param_origin)) {
						zzimTmpModelNoRemoveSet.add(param_origin);
					}
					if(zzimLayerSet.has(param_origin)) {
						zzimLayerSet.delete(param_origin);
					}
				} else {
					zzimTmpPlNoSet.delete(param_origin);
					if(!zzimTmpPlNoRemoveSet.has(param_origin)) {
						zzimTmpPlNoRemoveSet.add(param_origin);
					}
				}

				// 모바일최저가상품 레이어
				if($this.attr("data-zzimno")!==undefined && $this.attr("data-zzimno").indexOf("LAYER_")>-1) {
					$this.removeClass("is--on");
				}
			}
		});



	}
	// 2초후 자동 닫기
	zzimTimer = setTimeout(function(){
		$layZzim.removeClass('is--show');
	},2000);

}

// SRP C타입 그리기
function drawCtype(){
	var tmpKeyword = encodeURIComponent(param_keyword);
	var ajaxObj = $.ajax({
		type : "get",
		url : "/wide/api/product/prodSearchType.jsp",
		async: true,
		data : "keyword="+tmpKeyword+"&deviceType=1",
		dataType : "json",
		success: function(json) {

			var opt1Arr = json.data.option1; //option1 그룹
			var opt1ArrKeys = Object.keys(json.data.option1); //option1 그룹
			var opt2Arr = json.data.option2; //option2 array
			var targetObj = $(".srp-type--c");

			var tableHtml = [];
			var tableIdx = 0;

			tableHtml[tableIdx++] = "<ul class=\"srp-type__list\">";

			var tmpOption2 = "";
			var type_cd = "";

			for(var i=0; i<opt1ArrKeys.length; i++) {
				var arr1_key = opt1ArrKeys[i];
				var arr1_data = json.data.option1[arr1_key];

				var skMap = new CustomMap();
				var ktMap = new CustomMap();
				var lgMap = new CustomMap();
				var v16GMap = new CustomMap();
				var v32GMap = new CustomMap();
				var v64GMap = new CustomMap();
				var v128GMap = new CustomMap();
				var v256GMap = new CustomMap();
				var v512GMap = new CustomMap();
				var v1TMap = new CustomMap();

				var skCount = 0;
				var ktCount = 0;
				var lgCount = 0;
				var v16Count = 0;
				var v32Count = 0;
				var v64Count = 0;
				var v128Count = 0;
				var v256Count = 0;
				var v512Count = 0;
				var v1TCount = 0;

				$(arr1_data).each(function(index, item) {
					if(i == 0){
						type_cd =  item.TYPE_CD;
					}

					if(item.OPTION_2 == "SKT") {
						skMap.set(skCount++, item);
					} else if(item.OPTION_2 == "KT") {
						ktMap.set(ktCount++, item);
					} else if(item.OPTION_2 == "LG") {
						lgMap.set(lgCount++, item);
					} else if(item.OPTION_2 == "16G") {
						v16GMap.set(v16Count++, item);
					} else if(item.OPTION_2 == "32G") {
						v32GMap.set(v32Count++, item);
					} else if(item.OPTION_2 == "64G") {
						v64GMap.set(v64Count++, item);
					} else if(item.OPTION_2 == "128G") {
						v128GMap.set(v128Count++, item);
					} else if(item.OPTION_2 == "256G") {
						v256GMap.set(v256Count++, item);
					} else if(item.OPTION_2 == "512G") {
						v512GMap.set(v512Count++, item);
					} else if(item.OPTION_2 == "1T") {
						v1TMap.set(v1TCount++, item);
					}
				});

				var maxTableSize = 4;

				if(i==0) {
					tableHtml[tableIdx++] = "<li class=\"is--on\">";
				} else {
					tableHtml[tableIdx++] = "<li>";
				}

				//								<!-- 버튼 -->
				tableHtml[tableIdx++] = "		<button class=\"srp-type__tab\">"+arr1_key+"</button>";
				//								<!-- // -->

				//								<!-- 통신사별 -->
				tableHtml[tableIdx++] = "		<div class=\"srp-type__cont\">";
				tableHtml[tableIdx++] = "			<dl class=\"srp-type__cond\">";

				if(type_cd != "T"){
					// SKT
					tableHtml[tableIdx++] = "				<dt>SKT</dt>";
					tableHtml[tableIdx++] = "				<dd>";
					tableHtml[tableIdx++] = "					<table class=\"tb-conditon--type-c\">";
					tableHtml[tableIdx++] = "						<tbody>";

					for(var s=0;s<maxTableSize;s++) {
						if(skMap.has(s)) {
							tableHtml[tableIdx++] = "					<tr>";
							tableHtml[tableIdx++] = "						<th>"+skMap.get(s).OPTION_3+"</th>";
							if(skMap.get(s).MINPRICE3==0) {
								tableHtml[tableIdx++] = "					<td class=\"is--soldout\">품절</td>";
							} else {
								tableHtml[tableIdx++] = "					<td><a href=\"/detail.jsp?modelno="+skMap.get(s).MODELNO+"\" target=\"_blank\" data-modelno=\""+skMap.get(s).MODELNO+"\">최저가 <em>"+skMap.get(s).MINPRICE3.format()+"</em>원</a></td>";
							}
							tableHtml[tableIdx++] = "					</tr>";
						} else {
							tableHtml[tableIdx++] = "					<tr class=\"is--empty\">";
							tableHtml[tableIdx++] = "						<th></th>";
							tableHtml[tableIdx++] = "						<td></td>";
							tableHtml[tableIdx++] = "					</tr>";
						}
					}
					tableHtml[tableIdx++] = "						</tbody>";
					tableHtml[tableIdx++] = "					</table>";
					tableHtml[tableIdx++] = "				</dd>";

					// KT
					tableHtml[tableIdx++] = "				<dt>KT</dt>";
					tableHtml[tableIdx++] = "				<dd>";
					tableHtml[tableIdx++] = "					<table class=\"tb-conditon--type-c\">";
					tableHtml[tableIdx++] = "						<tbody>";
					for(var s=0;s<maxTableSize;s++) {
						if(skMap.has(s)) {
							tableHtml[tableIdx++] = "					<tr>";
							tableHtml[tableIdx++] = "						<th>"+ktMap.get(s).OPTION_3+"</th>";
							if(ktMap.get(s).MINPRICE3==0) {
								tableHtml[tableIdx++] = "					<td class=\"is--soldout\">품절</td>";
							} else {
								tableHtml[tableIdx++] = "					<td><a href=\"/detail.jsp?modelno="+ktMap.get(s).MODELNO+"\" target=\"_blank\" data-modelno=\""+ktMap.get(s).MODELNO+"\">최저가 <em>"+ktMap.get(s).MINPRICE3.format()+"</em>원</a></td>";
							}
							tableHtml[tableIdx++] = "					</tr>";
						} else {
							tableHtml[tableIdx++] = "					<tr class=\"is--empty\">";
							tableHtml[tableIdx++] = "						<th></th>";
							tableHtml[tableIdx++] = "						<td></td>";
							tableHtml[tableIdx++] = "					</tr>";
						}
					}
					tableHtml[tableIdx++] = "						</tbody>";
					tableHtml[tableIdx++] = "					</table>";
					tableHtml[tableIdx++] = "				</dd>";

					// LG
					tableHtml[tableIdx++] = "				<dt>LG</dt>";
					tableHtml[tableIdx++] = "				<dd>";
					tableHtml[tableIdx++] = "					<table class=\"tb-conditon--type-c\">";
					tableHtml[tableIdx++] = "						<tbody>";
					for(var s=0;s<maxTableSize;s++) {
						if(lgMap.has(s)) {
							tableHtml[tableIdx++] = "					<tr>";
							tableHtml[tableIdx++] = "						<th>"+lgMap.get(s).OPTION_3+"</th>";
							if(lgMap.get(s).MINPRICE3==0) {
								tableHtml[tableIdx++] = "					<td class=\"is--soldout\">품절</td>";
							} else {
								tableHtml[tableIdx++] = "					<td><a href=\"/detail.jsp?modelno="+lgMap.get(s).MODELNO+"\" target=\"_blank\" data-modelno=\""+lgMap.get(s).MODELNO+"\">최저가 <em>"+lgMap.get(s).MINPRICE3.format()+"</em>원</a></td>";
							}
							tableHtml[tableIdx++] = "					</tr>";
						} else {
							tableHtml[tableIdx++] = "					<tr class=\"is--empty\">";
							tableHtml[tableIdx++] = "						<th></th>";
							tableHtml[tableIdx++] = "						<td></td>";
							tableHtml[tableIdx++] = "					</tr>";
						}
					}
					tableHtml[tableIdx++] = "						</tbody>";
					tableHtml[tableIdx++] = "					</table>";
					tableHtml[tableIdx++] = "				</dd>";
				}else{
				//테블릿
					if(v16Count > 0){
						tableHtml[tableIdx++] = "				<dt>16G</dt>";
						tableHtml[tableIdx++] = "				<dd>";
						tableHtml[tableIdx++] = "					<table class=\"tb-conditon--type-c\">";
						tableHtml[tableIdx++] = "						<tbody>";
						for(var s=0;s<maxTableSize;s++) {
							if(v16GMap.has(s)) {
								tableHtml[tableIdx++] = "					<tr>";
								tableHtml[tableIdx++] = "						<th>"+v16GMap.get(s).OPTION_3+"</th>";
								if(v16GMap.get(s).MINPRICE3==0) {
									tableHtml[tableIdx++] = "					<td class=\"is--soldout\">품절</td>";
								} else {
									tableHtml[tableIdx++] = "					<td><a href=\"/detail.jsp?modelno="+v16GMap.get(s).MODELNO+"\" target=\"_blank\" data-modelno=\""+v16GMap.get(s).MODELNO+"\">최저가 <em>"+v16GMap.get(s).MINPRICE3.format()+"</em>원</a></td>";
								}
								tableHtml[tableIdx++] = "					</tr>";
							} else {
								tableHtml[tableIdx++] = "					<tr class=\"is--empty\">";
								tableHtml[tableIdx++] = "						<th></th>";
								tableHtml[tableIdx++] = "						<td></td>";
								tableHtml[tableIdx++] = "					</tr>";
							}
						}
						tableHtml[tableIdx++] = "						</tbody>";
						tableHtml[tableIdx++] = "					</table>";
						tableHtml[tableIdx++] = "				</dd>";
					}
					if(v32Count > 0){
						tableHtml[tableIdx++] = "				<dt>64G</dt>";
						tableHtml[tableIdx++] = "				<dd>";
						tableHtml[tableIdx++] = "					<table class=\"tb-conditon--type-c\">";
						tableHtml[tableIdx++] = "						<tbody>";
						for(var s=0;s<maxTableSize;s++) {
							if(v32GMap.has(s)) {
								tableHtml[tableIdx++] = "					<tr>";
								tableHtml[tableIdx++] = "						<th>"+v32GMap.get(s).OPTION_3+"</th>";
								if(v32GMap.get(s).MINPRICE3==0) {
									tableHtml[tableIdx++] = "					<td class=\"is--soldout\">품절</td>";
								} else {
									tableHtml[tableIdx++] = "					<td><a href=\"/detail.jsp?modelno="+v32GMap.get(s).MODELNO+"\" target=\"_blank\" data-modelno=\""+v32GMap.get(s).MODELNO+"\">최저가 <em>"+v32GMap.get(s).MINPRICE3.format()+"</em>원</a></td>";
								}
								tableHtml[tableIdx++] = "					</tr>";
							} else {
								tableHtml[tableIdx++] = "					<tr class=\"is--empty\">";
								tableHtml[tableIdx++] = "						<th></th>";
								tableHtml[tableIdx++] = "						<td></td>";
								tableHtml[tableIdx++] = "					</tr>";
							}
						}
						tableHtml[tableIdx++] = "						</tbody>";
						tableHtml[tableIdx++] = "					</table>";
						tableHtml[tableIdx++] = "				</dd>";
					}
					if(v64Count > 0){
						tableHtml[tableIdx++] = "				<dt>64G</dt>";
						tableHtml[tableIdx++] = "				<dd>";
						tableHtml[tableIdx++] = "					<table class=\"tb-conditon--type-c\">";
						tableHtml[tableIdx++] = "						<tbody>";
						for(var s=0;s<maxTableSize;s++) {
							if(v64GMap.has(s)) {
								tableHtml[tableIdx++] = "					<tr>";
								tableHtml[tableIdx++] = "						<th>"+v64GMap.get(s).OPTION_3+"</th>";
								if(v64GMap.get(s).MINPRICE3==0) {
									tableHtml[tableIdx++] = "					<td class=\"is--soldout\">품절</td>";
								} else {
									tableHtml[tableIdx++] = "					<td><a href=\"/detail.jsp?modelno="+v64GMap.get(s).MODELNO+"\" target=\"_blank\" data-modelno=\""+v64GMap.get(s).MODELNO+"\">최저가 <em>"+v64GMap.get(s).MINPRICE3.format()+"</em>원</a></td>";
								}
								tableHtml[tableIdx++] = "					</tr>";
							} else {
								tableHtml[tableIdx++] = "					<tr class=\"is--empty\">";
								tableHtml[tableIdx++] = "						<th></th>";
								tableHtml[tableIdx++] = "						<td></td>";
								tableHtml[tableIdx++] = "					</tr>";
							}
						}
						tableHtml[tableIdx++] = "						</tbody>";
						tableHtml[tableIdx++] = "					</table>";
						tableHtml[tableIdx++] = "				</dd>";
					}
					if(v128Count > 0){
						tableHtml[tableIdx++] = "				<dt>128G</dt>";
						tableHtml[tableIdx++] = "				<dd>";
						tableHtml[tableIdx++] = "					<table class=\"tb-conditon--type-c\">";
						tableHtml[tableIdx++] = "						<tbody>";
						for(var s=0;s<maxTableSize;s++) {
							if(v128GMap.has(s)) {
								tableHtml[tableIdx++] = "					<tr>";
								tableHtml[tableIdx++] = "						<th>"+v128GMap.get(s).OPTION_3+"</th>";
								if(v128GMap.get(s).MINPRICE3==0) {
									tableHtml[tableIdx++] = "					<td class=\"is--soldout\">품절</td>";
								} else {
									tableHtml[tableIdx++] = "					<td><a href=\"/detail.jsp?modelno="+v128GMap.get(s).MODELNO+"\" target=\"_blank\" data-modelno=\""+v128GMap.get(s).MODELNO+"\">최저가 <em>"+v128GMap.get(s).MINPRICE3.format()+"</em>원</a></td>";
								}
								tableHtml[tableIdx++] = "					</tr>";
							} else {
								tableHtml[tableIdx++] = "					<tr class=\"is--empty\">";
								tableHtml[tableIdx++] = "						<th></th>";
								tableHtml[tableIdx++] = "						<td></td>";
								tableHtml[tableIdx++] = "					</tr>";
							}
						}
						tableHtml[tableIdx++] = "						</tbody>";
						tableHtml[tableIdx++] = "					</table>";
						tableHtml[tableIdx++] = "				</dd>";
					}
					if(v256Count > 0){
						tableHtml[tableIdx++] = "				<dt>256G</dt>";
						tableHtml[tableIdx++] = "				<dd>";
						tableHtml[tableIdx++] = "					<table class=\"tb-conditon--type-c\">";
						tableHtml[tableIdx++] = "						<tbody>";
						for(var s=0;s<maxTableSize;s++) {
							if(v256GMap.has(s)) {
								tableHtml[tableIdx++] = "					<tr>";
								tableHtml[tableIdx++] = "						<th>"+v256GMap.get(s).OPTION_3+"</th>";
								if(v256GMap.get(s).MINPRICE3==0) {
									tableHtml[tableIdx++] = "					<td class=\"is--soldout\">품절</td>";
								} else {
									tableHtml[tableIdx++] = "					<td><a href=\"/detail.jsp?modelno="+v256GMap.get(s).MODELNO+"\" target=\"_blank\" data-modelno=\""+v256GMap.get(s).MODELNO+"\">최저가 <em>"+v256GMap.get(s).MINPRICE3.format()+"</em>원</a></td>";
								}
								tableHtml[tableIdx++] = "					</tr>";
							} else {
								tableHtml[tableIdx++] = "					<tr class=\"is--empty\">";
								tableHtml[tableIdx++] = "						<th></th>";
								tableHtml[tableIdx++] = "						<td></td>";
								tableHtml[tableIdx++] = "					</tr>";
							}
						}
						tableHtml[tableIdx++] = "						</tbody>";
						tableHtml[tableIdx++] = "					</table>";
						tableHtml[tableIdx++] = "				</dd>";
					}
					if(v512Count > 0){
						tableHtml[tableIdx++] = "				<dt>512G</dt>";
						tableHtml[tableIdx++] = "				<dd>";
						tableHtml[tableIdx++] = "					<table class=\"tb-conditon--type-c\">";
						tableHtml[tableIdx++] = "						<tbody>";
						for(var s=0;s<maxTableSize;s++) {
							if(v512GMap.has(s)) {
								tableHtml[tableIdx++] = "					<tr>";
								tableHtml[tableIdx++] = "						<th>"+v512GMap.get(s).OPTION_3+"</th>";
								if(v512GMap.get(s).MINPRICE3==0) {
									tableHtml[tableIdx++] = "					<td class=\"is--soldout\">품절</td>";
								} else {
									tableHtml[tableIdx++] = "					<td><a href=\"/detail.jsp?modelno="+v512GMap.get(s).MODELNO+"\" target=\"_blank\" data-modelno=\""+v512GMap.get(s).MODELNO+"\">최저가 <em>"+v512GMap.get(s).MINPRICE3.format()+"</em>원</a></td>";
								}
								tableHtml[tableIdx++] = "					</tr>";
							} else {
								tableHtml[tableIdx++] = "					<tr class=\"is--empty\">";
								tableHtml[tableIdx++] = "						<th></th>";
								tableHtml[tableIdx++] = "						<td></td>";
								tableHtml[tableIdx++] = "					</tr>";
							}
						}
						tableHtml[tableIdx++] = "						</tbody>";
						tableHtml[tableIdx++] = "					</table>";
						tableHtml[tableIdx++] = "				</dd>";
					}
					if(v1TCount > 0){
						tableHtml[tableIdx++] = "				<dt>1T</dt>";
						tableHtml[tableIdx++] = "				<dd>";
						tableHtml[tableIdx++] = "					<table class=\"tb-conditon--type-c\">";
						tableHtml[tableIdx++] = "						<tbody>";
						for(var s=0;s<maxTableSize;s++) {
							if(v1TMap.has(s)) {
								tableHtml[tableIdx++] = "					<tr>";
								tableHtml[tableIdx++] = "						<th>"+v1TMap.get(s).OPTION_3+"</th>";
								if(v1TMap.get(s).MINPRICE3==0) {
									tableHtml[tableIdx++] = "					<td class=\"is--soldout\">품절</td>";
								} else {
									tableHtml[tableIdx++] = "					<td><a href=\"/detail.jsp?modelno="+v1TMap.get(s).MODELNO+"\" target=\"_blank\" data-modelno=\""+v1TMap.get(s).MODELNO+"\">최저가 <em>"+v1TMap.get(s).MINPRICE3.format()+"</em>원</a></td>";
								}
								tableHtml[tableIdx++] = "					</tr>";
							} else {
								tableHtml[tableIdx++] = "					<tr class=\"is--empty\">";
								tableHtml[tableIdx++] = "						<th></th>";
								tableHtml[tableIdx++] = "						<td></td>";
								tableHtml[tableIdx++] = "					</tr>";
							}
						}
						tableHtml[tableIdx++] = "						</tbody>";
						tableHtml[tableIdx++] = "					</table>";
						tableHtml[tableIdx++] = "				</dd>";
					}
				}
				tableHtml[tableIdx++] = "			</dl>";
				tableHtml[tableIdx++] = "		</div>";
				tableHtml[tableIdx++] = "	</li>";
			}

			tableHtml[tableIdx++] = "</ul>";

			targetObj.html(tableHtml.join(""));
			targetObj.show();

			$(document).find(".srp-type__list .srp-type__tab").click(function(){
				var $pa = $(this).parent();
				$pa.addClass("is--on").siblings().removeClass("is--on");
			});
		},
		error: function (xhr, ajaxOptions, thrownError) {
		//	alert(xhr.status);
		//	alert(thrownError);
		}
	});
}

// SRP 연관검색어 API 호출
function loadLinkageKeyword() {

	if(param_keyword.length==0) {
		return;
	}

	// 속성 API 호출
	var linkagePromise = $.ajax({
		type : "GET",
		url : "/lsv2016/ajax/getLinkageKeyword_ajax.jsp",
		dataType : "json",
		data : {
			"procType" : "1",
			"keyword" : param_keyword
		}
	});

	linkagePromise.then(drawLinkage, failLinkage);
}

// SRP 연관검색어 그리기
function drawLinkage(dataObj) {

	if(dataObj.linkageKeywordList === undefined || dataObj.linkageKeywordList.length == 0 ){
		return;
	}

	var html = [];
	var hIdx = 0;

	var appendObj = $(".related-keyword");

	html[hIdx++] = "<div class=\"related-keyword__inner\">";
	html[hIdx++] = "	<div class=\"related-keyword__tit\">연관검색어</div>";
	html[hIdx++] = "	<ul class=\"related-keyword__list\">";
	$(dataObj.linkageKeywordList).each(function(index, item) {
		html[hIdx++] = "	<li><a href=\"/search.jsp?keyword="+item.linkageKeyword+"\">"+item.linkageKeyword+"</a></li>";
	});

	html[hIdx++] = "	</ul>";
	html[hIdx++] = "	</div>";
	html[hIdx++] = "</div>";

	appendObj.html(html.join(""));
	appendObj.show();
}

// SRP 연관검색어 API 호출 실패시
function failLinkage(errorObj) {
	console.log( "SRP Linkage API Call Fail : " + errorObj.statusText);
}

// SRP 부분검색어 그리기
// 키워드 , 선택 배열, 전체 배열
function drawPartialSearch(searchedKeyword, searchedKeywordAry, searchedKeywordOrgAry) {

	if(searchedKeywordOrgAry.length==0) {
		return;
	}

	var appendObj = $(".part-keyword");

	var html = [];
	var hIdx = 0;

	var partialKeywordSet = new Set();
	$(searchedKeywordAry).each(function(sub_index, sub_item) {
		partialKeywordSet.add(sub_item);
	});

	html[hIdx++] = "<div class=\"part-keyword__inner\">";
	html[hIdx++] = "	<div class=\"part-keyword__tit\">부분검색어</div>";
	html[hIdx++] = "	<ul class=\"part-keyword__list\">";
	$(searchedKeywordOrgAry).each(function(index, item) {
		if(partialKeywordSet.has(item)) {
			html[hIdx++] = "<li><input type=\"checkbox\" id=\"partKey0"+index+"\" class=\"input--checkbox-item\" checked=\"true\"><label for=\"partKey0"+index+"\">"+item+"</label></li>";
		} else {
			html[hIdx++] = "<li><input type=\"checkbox\" id=\"partKey0"+index+"\" class=\"input--checkbox-item\" ><label for=\"partKey0"+index+"\">"+item+"</label></li>";
		}
	});
	html[hIdx++] = "	</ul>";
	html[hIdx++] = "	<button class=\"part-keyword__btn--research\">재검색</button>";
	html[hIdx++] = "</div>";

	appendObj.html(html.join(""));
	appendObj.show();
}

// 모바일최저가 레이어
function mobileMinPriceLayer(thisObject) {

	var mobileSendProdDivObj = $("#MOBILEMINLAYER");

	// 토글
	if(mobileSendProdDivObj.css("display")!="none") {
		mobileSendProdDivObj.hide();
		return;
	}

	var thisObj = $(thisObject);

	var prodObj = thisObj.closest("li.prodItem");

	var modelno = prodObj.attr("data-id").replace("model_","");
	var modelname = prodObj.find(".goods-item .item__model a").text();
	var modelprice = "";
	if( viewType == 1) {
		modelprice = thisObj.closest("div.opt--price").find(".tx--price").text();
	} else if( viewType == 2) {
		modelprice = thisObj.closest("div.item__price").find("em").text();
	}

	$("button.btn-mobile--zzim").attr("data-zzimno", "LAYER_G:"+modelno);
	$("button.btn-mobile--zzim").attr("onclick", "showLayZzim_list(this);return false;");
	$("button.btn-mobile--sendsms").attr("data-modelno", modelno);
	$("button.btn-mobile--sendsms").attr("data-modelname", modelname.trim());
	mobileSendProdDivObj.find(".lay-comm--body .lay-mobile__cont .tx_price").html("<em>"+modelprice+"</em>원");
	$(".sendsms__form--inp").val("");
	$(".lay-mobile-sendsms").hide();

	// 찜 되어있을 경우 활성화 체크
	if(zzimLayerSet.has(modelno)) {
		$("button.btn-mobile--zzim").addClass("is--on");
	}

	// QR 코드 생성
	setQrCodeImg(modelno);

	var top = thisObj.offset().top + thisObj.height() + 3;
	var left = thisObj.offset().left - mobileSendProdDivObj.width() + thisObj.width();
	if(left<mobileSendProdDivObj.width()) left = thisObj.offset().left;
	mobileSendProdDivObj.css("top", top+"px");
	mobileSendProdDivObj.css("left", left+"px");
	mobileSendProdDivObj.fadeIn();
	mobileSendProdDivObj.show();

	insertLogLSV(15029); // LP/SRP>모바일 아이콘 클릭수
}

// 제조사, 브랜드 가나다순정렬하기
// dataType : factory / brand
function objectNameSort(nameListObj, dataType) {

	// 0:한글, 1:숫자, 2:영어, 3:특수 순서대로 저장
	var objList = new Array();
	var aryCnt = new Array();
	for(var i=0; i<4; i++) {
		objList[i] = [];
		aryCnt[i] = 0;
	}
	for(var i=0; i<nameListObj.length; i++) {

		var orderText = nameListObj[i].name;
		if(orderText && orderText.length>0) {
			var firstASC = orderText.charCodeAt(0);

			// 한글 가~힣 : 44032~55203
			// 한글 자음 : 12593~12622
			// 한글 모음 : 12623~12643
			if( (firstASC>=44032 && firstASC<=55203) || (firstASC>=12593 && firstASC<=12643) ) {
				objList[0][aryCnt[0]++] = nameListObj[i].name;

			// 숫자 0~9 : 48~57
			} else if(firstASC>=48 && firstASC<=57) {
				objList[1][aryCnt[1]++] = nameListObj[i].name;

			// 영문 대문자  : 65~90
			// 영문 소문자  : 97~122
			} else if( (firstASC>=65 && firstASC<=90) || (firstASC>=97 && firstASC<=122) ) {
				objList[2][aryCnt[2]++] = nameListObj[i].name;

			// 특수문자
			} else {
				objList[3][aryCnt[3]++] = nameListObj[i].name;
			}
		}
	}

	for(var aryI=0; aryI<objList.length; aryI++) {
		objList[aryI] = objList[aryI].sort();
	}

	var retArray = new Array();
	var aryCnt = 0;
	// 한글 영어 숫자 특수문자 순

	if(objList[0].length>0) { // 한글
		for(var i=0; i<objList[0].length; i++) {
			retArray[aryCnt++] = objList[0][i];
		}
	}
	if(objList[2].length>0) { // 영어
		for(var i=0; i<objList[2].length; i++) {
			retArray[aryCnt++] = objList[2][i];
		}
	}
	if(objList[1].length>0) { // 숫자
		for(var i=0; i<objList[1].length; i++) {
			retArray[aryCnt++] = objList[1][i];
		}
	}
	if(objList[3].length>0) { // 특수문자
		for(var i=0; i<objList[3].length; i++) {
			retArray[aryCnt++] = objList[3][i];
		}
	}

	return retArray;
}

// 필터 초기화
// attrReset 속성 초기화 ( true/false )
function filterReset(attrReset) {
	if(attrReset) {
		attrSelCnt = 0;
		$("#attrSelCnt").text(attrSelCnt);

		$("ul.search-box__list li").find("input[type=checkbox]").prop("checked", false);
		$("button.btn--range-price").removeClass("is--active");
		$("dl.row-recommend ul.search-box__keyword li.reqKwd").find("button").removeClass("is--active");
		$("div.search-box__range--search input").val("");
		if($("ul.list__luxury").length>0) {
			$("ul.list__luxury li").removeClass("sel").removeClass("is--on");
		}
		if($(".search-box__r-brand li").length>0) {
			$(".search-box__r-brand li").removeClass("is--on");
		}
		$("li.attrs").removeClass("sel");
		//색상코드 추가
		$("button.btn-color").parent("li").removeClass("is-on");
		$("li.attrs").find("input").prop("checked", false);
		$(".adv-search .search-box-row").removeClass("is--unfold");
		$(".search-box-row .search-box__sort--seq").hide();
		$(".search-box-row .search-box__sort--seq ul").remove();
		$("button.btn--consonant").removeClass("is--selected");
		$("button.btn-sort--pop").addClass("is--selected");
		$("button.btn-sort--name").removeClass("is--selected");
		$(".list-filter__search--input").val("");
		$("ul.list-filter__tab li .list-tab--count").text("");
		brandTmpSet.clear();
		factoryTmpSet.clear();

		$(".row-selected--condition").hide();
		$(".row-selected--condition").find("ul.search-box__keyword").empty();
	
		if(initBrandHtml && initBrandHtml.length>0) {
			$(".adv-search-box dl[data-attr-type=brand] dd .search-box__inner").html(initBrandHtml);
		}
	
		if(initFactoryHtml && initFactoryHtml.length>0) {
			$(".adv-search-box dl[data-attr-type=factory] dd .search-box__inner").html(initFactoryHtml);
		}
	
		param_factory = "";
		param_factorycode = "";
		param_brand = "";
		param_brandcode = "";
		param_shopcode = "";
		param_spec = "";
		param_specname = "";
		param_sPrice = 0;
		param_ePrice = 0;
		param_inKeyword = "";
		param_bbsscore = "";
		param_pageNum = 1;
		param_discount = "";
	}

	// 탭별 소팅 노출 처리
	// 일반상품, 해외직구는 신제품순, 판매량순 비노출
	$("button.list-filter__btn.newListDiv").hide();
	$(".list-filter-bot[data-type=prod] .sortFilter").show();
	$(".list-filter-bot[data-type=prod] .sortFilter[sorttype=7]").hide();

	if( param_tabType==2 || param_tabType==3 ) {
		$(".list-filter-bot[data-type=prod] .sortFilter[sorttype=4]").hide();
		$(".list-filter-bot[data-type=prod] .sortFilter[sorttype=5]").hide();
	}
	if(param_tabType==0 && blNewListBtnIsset) {
		$(".list-filter-bot[data-type=prod] .sortFilter[sorttype=7]").show();
	}
}

// 속성에 하이라이트 표시
function chgHighlighttxt() {
	//검색단어 하일라이트
	var vSearchword = param_keyword;
	var vSearchword_in = param_inKeyword;
	
	var vSpecialCharacter = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자

	if(vSearchword.length > 0) {
		$(".item__model > a, .item__tx--copy, .item__attr a, .item__summ > a, .tx--condition").each(function(){
			if($(this).text().indexOf(vSearchword) > -1) {
				$(this).html($(this).html().replaceAll(vSearchword,"HighlighttextS"+ vSearchword +"HighlighttextE"));
				var tmpHtml = $(this).html();
				tmpHtml = tmpHtml.replaceAll("HighlighttextS","<strong class=\"tx_highlight\">").replaceAll("HighlighttextE","</strong>");
				$(this).html(tmpHtml);
			}
		});
	}

	// 특수문자 제거
	if(vSpecialCharacter.test(vSearchword_in)) {
		vSearchword_in = vSearchword_in.replaceAll("[~!@#$%^&*()_+|<>?:{}]", "");
	}

	if(vSearchword_in.length > 0 && vSearchword!==vSearchword_in) {
		$(".item__model > a, .item__tx--copy, .item__attr a, .item__summ > a, .tx--condition").each(function(){
			if($(this).text().indexOf(vSearchword_in) > -1) {
				$(this).html($(this).html().replaceAll(vSearchword_in,"HighlighttextS"+ vSearchword_in +"HighlighttextE"));
				var tmpHtml = $(this).html();
				tmpHtml = tmpHtml.replaceAll("HighlighttextS","<strong class=\"tx_highlight\">").replaceAll("HighlighttextE","</strong>");
				$(this).html(tmpHtml);
			}
		});
	}

}

// 에어컨(2401) 카테고리
// 1순위 수도권 , 2순위 일반
function changeModelNumber2401(strModelNo,groupModelList) {
	var retModelNo = strModelNo;
	var chkBool = true;
	if(groupModelList.length>0) {
		$(groupModelList).each(function(index, item) {
			if( chkBool && item.strCondiName !== undefined && item.strModelNo !== undefined && item.strModelNo.length > 0 ) {
				if( item.strCondiName.indexOf("수도권") > -1 ) {
					retModelNo = item.strModelNo;
					chkBool = false;
				} else if( item.strCondiName.indexOf("일반") > -1 ) {
					retModelNo = item.strModelNo;
					chkBool = false;
				}
			}
		});
	}
	return retModelNo;
}

//프린터 연관상품 레이어
var relOrgModelNo ;
function loadRelatedProd(modelno, relProdModelno, orgModelNo, relProdModelnm, relBtnText, adProdYN) {
	relOrgModelNo = orgModelNo;
	if (modelno == undefined || relProdModelno == undefined) return;

	var relatedProdPromise = $.ajax({
		type: "GET",
		url: "/wide/api/product/relatedProdV2.jsp",
		data: { 
			"modelno": modelno, 
			"relmodelno": relProdModelno, 
			"relmodelnm" : relProdModelnm, 
			"reltext" : relBtnText,
			"adProdYN" : (adProdYN===true) ? "Y" : "N"
		},
		dataType: "JSON",
	});
	relatedProdPromise.then(drawRelatedProd, failRelatedProd);
}

function drawRelatedProd(dataObj) {
	if (dataObj == undefined || !dataObj.success) {
		return;
	}
	var vHtml = "";
	var vProdData = dataObj.prodData;
	var vRelProdList = dataObj.relProdList;
	var vRelText = dataObj.layerText;
	
	var $item__relate_layer = $(".item__relate_layer");
	$item__relate_layer.remove();

	vHtml += "<div class=\"item__relate_layer\" style=\"display: none;\">";
	vHtml += "	<div class=\"item__rl_header\">"+vRelText+"</div>";
	vHtml += "	<div class=\"item__rl_cont\">";
	vHtml += "		<div class=\"cont_left\">";
	vHtml += "			<a href=\"/detail.jsp?modelno="+vProdData.modelno+"\" target=\"_blank\">";
	vHtml += "				<div class=\"left_goods_img\">";
    vHtml += "					<img src="+vProdData.imgUrl+" onerror=\"this.src='" + noImageStr + "'\">";
    vHtml += "				</div>";
    vHtml += "				<div class=\"left_goods_name\">"+vProdData.modelnm+"</div>";
	if (vProdData.extraText == "") {
		vHtml += "			<div class=\"left_goods_price\"><em>" + vProdData.price + "</em>원</div>";
	} else if (vProdData.extraText == "일시품절" || vProdData.extraText == "출시예정") {
		vHtml += "			<div class=\"left_goods_price tx_ready\">" + vProdData.extraText + "</div>";
	}
	vHtml += "			</a>";

	vHtml += "		</div>";
	vHtml += "		<div class=\"cont_right\">";
	vHtml += "			<ul class=\"item__r_list\">";
	$.each(vRelProdList, function(i,v) {
		var vSpecArr = new Array();
		var vSpecText = v.specText.replace(/&nbsp;&nbsp;\/&nbsp;&nbsp;/gi, " ;");
		vSpecArr = vSpecText.split(";");
		vHtml += "			<li class=\"r_list\">";
		vHtml += "				<div class=\"rl_info\">";
		vHtml += "					<a href=\"/detail.jsp?modelno="+v.modelno+"\" target=\"_blank\">";
		vHtml += "						<div class=\"rl_img\"><img src=\""+v.imgUrl+"\" onerror=\"this.src='" + noImageStr + "'\"></div>";
		vHtml += "						<div class=\"rl_name\">"+v.modelnm+"</div>";
		vHtml += "						<div class=\"rl_option\">";
		$.each(vSpecArr, function(index , item) {
			vHtml += "						<span>"+vSpecArr[index]+"</span>"; 
		});
	    vHtml += "						</div>";
		vHtml += "					</a>";
		vHtml += "				</div>";
		if (v.extraText == "") {
			vHtml += "			<div class=\"rl_price\"><em>" + v.price + "</em>원</div>";
		} else if (v.extraText == "일시품절" || v.extraText == "출시예정") {
			vHtml += "			<div class=\"rl_price rl_ready\">" + v.extraText + "</div>";
		}
		vHtml += "				<div class=\"rl_zzim\">";
		vHtml += "					<button class=\"item__btn--zzim "+(v.zzimYN == "Y" ? "is--on" : "")+"\" data-layertype=\"relProd\" data-zzimno=\"G"+v.modelno+"\" data-modelno=\""+v.modelno+"\" title=\"찜\" onclick=\"showLayZzim_list(this);return false;\"><i class=\"ico-item--zzim lp__sprite\">찜</i></button>";
	    vHtml += "				</div>";
		vHtml += "			</li>";
	});
    vHtml += "			</ul>";
    vHtml += "		</div>";
	vHtml += "	</div>";
	vHtml += "	<div class=\"btn_close_layer\"><i class=\"lp__sprite icon_close_s16\"></i></div>";
	vHtml += "</div>";

	// 슈퍼탑 - 리스팅 상품 중복 예외 처리
	if( $("li.prodItem[data-model-origin="+relOrgModelNo+"]").length == 2 ) {
		if( dataObj.adYN == "Y" ) {
			$("li.prodItem[data-model-origin="+relOrgModelNo+"].ad .item__info").append(vHtml); 
		} else {
			$("li.prodItem[data-model-origin="+relOrgModelNo+"]:not('.ad') .item__info").append(vHtml); 
		}
	} else {
		$("li.prodItem[data-model-origin="+relOrgModelNo+"] .item__info").append(vHtml);
	}
	$(".item__relate_layer").toggle();
	$('.btn_close_layer').on('click', function() {
		$(".item__relate_layer").hide();
	});
}

function failRelatedProd(errorObj) {
	console.log("relatedProd API Call Fail : " + errorObj.statusText);
}

// 우측 컨텐츠박스 불러오기
function getRightWingKnowboxContent(cate) {
	if(cate.length==0) return;
	
	var rightContentPromise = $.ajax({
		type:"GET",
		url: "/wide/api/rightContent.jsp",
		data: {
			cate : cate,
			listType : listType
		},
		dataType: "JSON"
	});
	
	// 돔 그리기
	rightContentPromise.then(function(obj) {
		drawRightWingKnowboxContent(obj);
	})
	
	// 돔 이벤트처리
	rightContentPromise.then(function(obj) {
		eventRightWingKnowboxContent(obj);
	})
}

// 우측 컨텐츠박스 그리기
function drawRightWingKnowboxContent(dataObj) {
	if(!dataObj.success || dataObj.data===undefined) {
		return;
	}
	
	var $targetObj = $(".knowcom-box");
	
	var html = [];
	var hIdx = 0;
	
	// 카테고리 이름
	if((dataObj.data.exhibition!==undefined && dataObj.data.exhibition.length>0) ||
		(dataObj.data.guide!==undefined && dataObj.data.guide.length>0) ||
		(dataObj.data.review!==undefined && dataObj.data.review.length>0) ||
		(dataObj.data.news!==undefined && dataObj.data.news.length>=3) 
	) {
		html[hIdx++] = "<div class=\"knowcom-box--head\">트렌드를 한번에";
		html[hIdx++] = "	<span class=\"tx--cate\">"+dataObj.data.cateNm+"</span>";
		html[hIdx++] = "</div>";
	}
	
	// 기획전
	if(dataObj.data.exhibition!==undefined && dataObj.data.exhibition.length>0) {
		var exhibitionObj = dataObj.data.exhibition[0];
		
		html[hIdx++] = "<div class=\"knowcom-box--group group--bguide\" knowbox-type=\"1\">";
		html[hIdx++] = "	<div class=\"knowcom-group--head\">기획전";
		if(dataObj.data.exhibition.length>1) {
			html[hIdx++] = "	<div class=\"knowcom-group__btn\" data-idx=\"0\" data-max=\""+dataObj.data.exhibition.length+"\" data-type=\"exhibition\">";
			html[hIdx++] = "		<button class=\"knowcom-group__btn--prev\">이전</button>";
			html[hIdx++] = "		<button class=\"knowcom-group__btn--next\">다음</button>";
			html[hIdx++] = "	</div>";
		}
		html[hIdx++] = "	</div>";
		html[hIdx++] = "	<div class=\"knowcom-group--body\">";
		//						<!-- 기획전 > 컨텐츠 : 썸네일형 230x140 -->
		html[hIdx++] = "		<a href=\"/cmexhibition/exhibition_view_E.jsp?adsNo="+exhibitionObj.ads_no+"\" class=\"knowcom-group__thum\" target=\"_blank\" title=\"새 창 열림\">";
		html[hIdx++] = "			<span class=\"knowcom-group__thum--img\">";
		html[hIdx++] = "				<img src=\""+exhibitionObj.img_url+"\" alt=\"기획전 썸네일 이미지\" width=\"230\" onerror=\"this.src='"+ noImageStr +"';\"/>";
		html[hIdx++] = "			</span>";
		html[hIdx++] = "		</a>";
		html[hIdx++] = "	</div>";
		html[hIdx++] = "</div>";
	}
	
	// 구매가이드
	if(dataObj.data.guide!==undefined && dataObj.data.guide.length>0) {
		var guideObj = dataObj.data.guide[0];
		
		html[hIdx++] = "<div class=\"knowcom-box--group group--bguide\" knowbox-type=\"2\">";
		html[hIdx++] = "	<div class=\"knowcom-group--head\">구매가이드";
		if(dataObj.data.guide.length>1) {
			html[hIdx++] = "	<div class=\"knowcom-group__btn\" data-idx=\"0\" data-max=\""+dataObj.data.guide.length+"\" data-type=\"guide\">";
			html[hIdx++] = "		<button class=\"knowcom-group__btn--prev\">이전</button>";
			html[hIdx++] = "		<button class=\"knowcom-group__btn--next\">다음</button>";
			html[hIdx++] = "	</div>";
		}
		html[hIdx++] = "	</div>";
		html[hIdx++] = "	<div class=\"knowcom-group--body\">";
		//						<!-- 기획전 > 컨텐츠 : 썸네일형 230x140 -->
		html[hIdx++] = "		<a href=\"/knowcom/detail.jsp?kbno="+guideObj.bbs_no+"\" class=\"knowcom-group__thum\" target=\"_blank\" title=\"새 창 열림\">";
		html[hIdx++] = "			<span class=\"knowcom-group__thum--img\">";
		html[hIdx++] = "				<img src=\""+guideObj.thumbnail_url+"\" alt=\"구매가이드 썸네일 이미지\" width=\"230\" onerror=\"this.src='"+ noImageStr +"';\"/>";
		html[hIdx++] = "			</span>";
		html[hIdx++] = "		</a>";
		html[hIdx++] = "	</div>";
		html[hIdx++] = "</div>";
	}
	
	// 리뷰 ( 3개가 한묶음 )
	if(dataObj.data.review!==undefined && dataObj.data.review.length>0) {
	
		var reviewTotalPage = Math.floor( dataObj.data.review.length / 3 );
		if(reviewTotalPage<1) {
			reviewTotalPage = 1;
		}
		html[hIdx++] = "<div class=\"knowcom-box--group group--review\" knowbox-type=\"3\">";
		html[hIdx++] = "	<div class=\"knowcom-group--head\">리뷰";
		if(reviewTotalPage>1) {
			html[hIdx++] = "	<div class=\"knowcom-group__btn\" data-cur-page=\"0\" data-max-page=\"" + reviewTotalPage + "\" data-type=\"review\">";
			html[hIdx++] = "		<button class=\"knowcom-group__btn--prev\">이전</button>";
			html[hIdx++] = "		<button class=\"knowcom-group__btn--next\">다음</button>";
			html[hIdx++] = "	</div>";
		}
		html[hIdx++] = "	</div>";
		html[hIdx++] = "	<div class=\"knowcom-group--body\">";
								//	<!-- 리뷰 > 컨텐츠 : 썸네일형 1개 고정-->
		html[hIdx++] = "		<a href=\"/knowcom/detail.jsp?kbno="+ dataObj.data.review[0].kb_no +"\" class=\"knowcom-group__thum\" target=\"_blank\" title=\"새 창 열림\">";
									//	<!-- 동영상 썸네일은 .type--movie 붙여주세요 -->
		if(dataObj.data.review[0].kk_code=="20") {
			html[hIdx++] = "		<span class=\"knowcom-group__thum--img type--movie\">";
		} else {
			html[hIdx++] = "		<span class=\"knowcom-group__thum--img\">";
		}
		html[hIdx++] = "				<img src=\"" + dataObj.data.review[0].showThumbImg + "\" alt=\"리뷰 썸네일 이미지\" width=\"230\" onerror=\"this.src='"+ noImageStr +"';\"/>";
		html[hIdx++] = "			</span>";
									//	<!-- 구매가이드 > 컨텐츠 > 썸네일형 텍스트 > 말줄임 없이 노출 -->
		html[hIdx++] = "			<span class=\"tx--thumb\">" + reviewTitleEscape(dataObj.data.review[0].kb_title) + "</span>";
		html[hIdx++] = "		</a>";
								//	<!-- 구매가이드 > 컨텐츠 : 리스트형 2개 고정-->
		if(dataObj.data.review.length>=2) {
			html[hIdx++] = "	<ul class=\"knowcom-group__list\">";
			html[hIdx++] = "		<li><a href=\"/knowcom/detail.jsp?kbno="+ dataObj.data.review[1].kb_no +"\" target=\"_blank\">"+ reviewTitleEscape(dataObj.data.review[1].kb_title) + "</a></li>";
			if(dataObj.data.review.length>=3) {
				html[hIdx++] = "	<li><a href=\"/knowcom/detail.jsp?kbno="+ dataObj.data.review[2].kb_no +"\" target=\"_blank\">"+ reviewTitleEscape(dataObj.data.review[2].kb_title) + "</a></li>";
			}
			html[hIdx++] = "	</ul>";
		}
		html[hIdx++] = "	</div>";
		html[hIdx++] = "</div>";
	}
	
	// 뉴스 ( 5개가 한묶음 )
	if(dataObj.data.news!==undefined && dataObj.data.news.length>=3) {
		
		var newsTotalPage = Math.floor( dataObj.data.news.length / 5 );
		if(newsTotalPage<1) {
			newsTotalPage = 1;
		}
		
		html[hIdx++] = "<div class=\"knowcom-box--group group--news\" knowbox-type=\"4\">";
		html[hIdx++] = "	<div class=\"knowcom-group--head\">뉴스";
		if(newsTotalPage>1) {
			html[hIdx++] = "	<div class=\"knowcom-group__btn\" data-cur-page=\"0\" data-max-page=\"" + newsTotalPage + "\" data-type=\"news\">";
			html[hIdx++] = "		<button class=\"knowcom-group__btn--prev\">이전</button>";
			html[hIdx++] = "		<button class=\"knowcom-group__btn--next\">다음</button>";
			html[hIdx++] = "	</div>";
		}
		html[hIdx++] = "	</div>";
		html[hIdx++] = "	<div class=\"knowcom-group--body\">";
								//	<!-- 뉴스 > 컨텐츠 : 리스트형 5개 고정-->
		html[hIdx++] = "		<ul class=\"knowcom-group__list\">";
		html[hIdx++] = "			<li><a href=\"/knowcom/detail.jsp?kbno="+ dataObj.data.news[0].kb_no +"\" target=\"_blank\">" + dataObj.data.news[0].kb_title + "</a></li>";
		if(dataObj.data.news.length>=2) {
			html[hIdx++] = "		<li><a href=\"/knowcom/detail.jsp?kbno="+ dataObj.data.news[1].kb_no +"\" target=\"_blank\">" + dataObj.data.news[1].kb_title + "</a></li>";
		}
		if(dataObj.data.news.length>=3) {
			html[hIdx++] = "		<li><a href=\"/knowcom/detail.jsp?kbno="+ dataObj.data.news[2].kb_no +"\" target=\"_blank\">" + dataObj.data.news[2].kb_title + "</a></li>";
		}
		if(dataObj.data.news.length>=4) {
			html[hIdx++] = "		<li><a href=\"/knowcom/detail.jsp?kbno="+ dataObj.data.news[3].kb_no +"\" target=\"_blank\">" + dataObj.data.news[3].kb_title + "</a></li>";
		}
		if(dataObj.data.news.length>=5) {
			html[hIdx++] = "		<li><a href=\"/knowcom/detail.jsp?kbno="+ dataObj.data.news[4].kb_no +"\" target=\"_blank\">" + dataObj.data.news[4].kb_title + "</a></li>";
		}
		html[hIdx++] = "		</ul>";
		html[hIdx++] = "	</div>";
		html[hIdx++] = "</div>";
	}
	
	$targetObj.html(html.join(""));
	
	$targetObj.show();
}

// 우측 컨텐츠박스 이벤트리스너
function eventRightWingKnowboxContent(dataObj) {
	
	// 우측 컨텐츠 fixed 관련 스크립트
	var $body = $(".list-body");
	var $side = $(".list-body-side .side__inner");
	var fixSidePos = function(){
		var scroll = $(window).scrollTop(),
		bodyH = $body.outerHeight(), // 컨테이너 높이
		bodyT = $body.offset().top, // 컨테이너 Position Top
		sideH = $side.outerHeight(), // 우측컨텐츠 높이
		winH = $(window).height(), // 스크린 Y 크기
		distT = 70; // 상단과 FIXED 될 거리

		if ( bodyH > sideH ){ // 우측 컨텐츠 보다 상품리스트가 크고
			if ( sideH < winH - distT ){ // 우측 컨텐츠가 스크린H 보다 작을때
				if ( scroll > bodyT - distT ){ // 상단에 고정
					if ( scroll > bodyT + bodyH - sideH - distT){ // 스크롤이 컨텐츠 하단으로 벗어날때
						$side.addClass("is--fixBotOv").removeClass("is--fixBot is--fixTop");
					}else{ // 스크롤이 컨텐츠 내에 존재할때
						$side.addClass("is--fixTop").removeClass("is--fixBot is--fixBotOv");
					}
				}else{
					$side.removeClass("is--fixTop is--fixBot is--fixBotOv");
				}
			}else{ // 우측 컨텐츠가 스크린H 보다 클때
				if ( scroll > bodyT + (sideH-winH) ){ // 하단에 고정
					if ( scroll > bodyT + bodyH - winH ){ // 스크롤이 컨텐츠 하단으로 벗어날때
						$side.addClass("is--fixBotOv").removeClass("is--fixBot is--fixTop");
					}else{ // 스크롤이 컨텐츠 내에 존재할때
						$side.addClass("is--fixBot").removeClass("is--fixTop is--fixBotOv");
					}
				}else{
					$side.removeClass("is--fixTop is--fixBot is--fixBotOv");
				}
			}
		}else{ // 우측 컨텐츠가 상품리스트 보다 길때는 실행 안함
			$side.removeClass("is--fixTop is--fixBot is--fixBotOv")
		}
	}

	$(window).on({
		"load" : fixSidePos,
		"scroll" : fixSidePos,
		"resize" : fixSidePos
	});
	var $wingPH = $(".knowcom-group__placecholder");
	$(window).on('load', function() {
		setTimeout(function(){ // 퍼블테스트
			$wingPH.fadeOut(300);
		},1000)
	});
	
	// 좌/우 클릭 이벤트
	$(document).on("click", ".knowcom-group__btn--prev, .knowcom-group__btn--next", function() {
		var actionObj = $(this).closest(".knowcom-group__btn");
		var actionType = actionObj.attr("data-type");
		var changeObj = $(this).closest(".knowcom-box--group").find(".knowcom-group--body");

		// 좌
		if( $(this).hasClass("knowcom-group__btn--prev") ) {
		
			switch(actionType) {
				case "exhibition" : 
					var idx = actionObj.attr("data-idx");
					var max = actionObj.attr("data-max");
					var nextIdx = 0;
					if(idx==0) {
						nextIdx = Number(parseInt(max)-parseInt(1));
					} else {
						nextIdx = Number(parseInt(idx)-parseInt(1));
					}
					changeObj.find(".knowcom-group__thum").attr("href", "/cmexhibition/exhibition_view_E.jsp?adsNo="+dataObj.data.exhibition[nextIdx].ads_no);
					changeObj.find("img").attr("src", dataObj.data.exhibition[nextIdx].img_url);
					actionObj.attr("data-idx", nextIdx);
					break;
				case "guide" :
					var idx = actionObj.attr("data-idx");
					var max = actionObj.attr("data-max");
					var nextIdx = 0;
					if(idx==0) {
						nextIdx = Number(parseInt(max)-parseInt(1));
					} else {
						nextIdx = Number(parseInt(idx)-parseInt(1));
					}
					changeObj.find(".knowcom-group__thum").attr("href", "/knowcom/detail.jsp?kbno="+dataObj.data.guide[nextIdx].bbs_no);
					changeObj.find("img").attr("src", dataObj.data.guide[nextIdx].thumbnail_url);
					actionObj.attr("data-idx", nextIdx);
					break;
				case "review" : 
					var idx = actionObj.attr("data-cur-page");
					var max = actionObj.attr("data-max-page");
					var nextIdx = 0;
					if(idx==0) {
						nextIdx = Number(parseInt(max)-parseInt(1));
					} else {
						nextIdx = Number(parseInt(idx)-parseInt(1));
					}
					var nextPageStart = nextIdx * 3; // 3개가 한묶음
					var nextPageStart_1 = Number(parseInt(nextPageStart)+parseInt(1));
					var nextPageStart_2 = Number(parseInt(nextPageStart)+parseInt(2));
					changeObj.find(".knowcom-group__thum").attr("href", "/knowcom/detail.jsp?kbno="+dataObj.data.review[nextPageStart].kb_no);
					changeObj.find(".knowcom-group__thum--img img").attr("src", dataObj.data.review[nextPageStart].showThumbImg);
					changeObj.find(".tx--thumb").text(reviewTitleEscape(dataObj.data.review[nextPageStart].kb_title));
					changeObj.find(".knowcom-group__list li:eq(0) a").attr("href", "/knowcom/detail.jsp?kbno="+dataObj.data.review[nextPageStart_1].kb_no);
					changeObj.find(".knowcom-group__list li:eq(0) a").text(reviewTitleEscape(dataObj.data.review[nextPageStart_1].kb_title));
					changeObj.find(".knowcom-group__list li:eq(1) a").attr("href", "/knowcom/detail.jsp?kbno="+dataObj.data.review[nextPageStart_2].kb_no);
					changeObj.find(".knowcom-group__list li:eq(1) a").text(reviewTitleEscape(dataObj.data.review[nextPageStart_2].kb_title));
					actionObj.attr("data-cur-page", nextIdx);
					break;
				case "news" : 
					var idx = actionObj.attr("data-cur-page");
					var max = actionObj.attr("data-max-page");
					var nextIdx = 0;
					if(idx==0) {
						nextIdx = Number(parseInt(max)-parseInt(1));
					} else {
						nextIdx = Number(parseInt(idx)-parseInt(1));
					}
					var nextPageStart = nextIdx * 5; // 5개가 한묶음
					var nextPageStart_1 = Number(parseInt(nextPageStart)+parseInt(1));
					var nextPageStart_2 = Number(parseInt(nextPageStart)+parseInt(2));
					var nextPageStart_3 = Number(parseInt(nextPageStart)+parseInt(3));
					var nextPageStart_4 = Number(parseInt(nextPageStart)+parseInt(4));
					changeObj.find(".knowcom-group__list li:eq(0) a").attr("href", "/knowcom/detail.jsp?kbno="+dataObj.data.review[nextPageStart].kb_no);
					changeObj.find(".knowcom-group__list li:eq(0) a").text(reviewTitleEscape(dataObj.data.review[nextPageStart].kb_title));
					changeObj.find(".knowcom-group__list li:eq(1) a").attr("href", "/knowcom/detail.jsp?kbno="+dataObj.data.review[nextPageStart_1].kb_no);
					changeObj.find(".knowcom-group__list li:eq(1) a").text(reviewTitleEscape(dataObj.data.review[nextPageStart_1].kb_title));
					changeObj.find(".knowcom-group__list li:eq(2) a").attr("href", "/knowcom/detail.jsp?kbno="+dataObj.data.review[nextPageStart_2].kb_no);
					changeObj.find(".knowcom-group__list li:eq(2) a").text(reviewTitleEscape(dataObj.data.review[nextPageStart_2].kb_title));
					changeObj.find(".knowcom-group__list li:eq(3) a").attr("href", "/knowcom/detail.jsp?kbno="+dataObj.data.review[nextPageStart_3].kb_no);
					changeObj.find(".knowcom-group__list li:eq(3) a").text(reviewTitleEscape(dataObj.data.review[nextPageStart_3].kb_title));
					changeObj.find(".knowcom-group__list li:eq(4) a").attr("href", "/knowcom/detail.jsp?kbno="+dataObj.data.review[nextPageStart_4].kb_no);
					changeObj.find(".knowcom-group__list li:eq(4) a").text(reviewTitleEscape(dataObj.data.review[nextPageStart_4].kb_title));
					actionObj.attr("data-cur-page", nextIdx);
					break;
			}
		
		// 우
		} else if( $(this).hasClass("knowcom-group__btn--next") ) {
		
			switch(actionType) {
				case "exhibition" : 
					var idx = actionObj.attr("data-idx");
					var max = actionObj.attr("data-max");
					var nextIdx = 0;
					if(Number(parseInt(idx)+parseInt(1))==Number(max)) {
						nextIdx = 0;
					} else {
						nextIdx = Number(parseInt(idx)+parseInt(1));
					}
					changeObj.find(".knowcom-group__thum").attr("href", "/cmexhibition/exhibition_view_E.jsp?adsNo="+dataObj.data.exhibition[nextIdx].ads_no);
					changeObj.find("img").attr("src", dataObj.data.exhibition[nextIdx].img_url);
					actionObj.attr("data-idx", nextIdx);
					break;
				case "guide" :
					var idx = actionObj.attr("data-idx");
					var max = actionObj.attr("data-max");
					var nextIdx = 0;
					if(Number(parseInt(idx)+parseInt(1))==Number(max)) {
						nextIdx = 0;
					} else {
						nextIdx = Number(parseInt(idx)+parseInt(1));
					}
					changeObj.find(".knowcom-group__thum").attr("href", "/knowcom/detail.jsp?kbno="+dataObj.data.guide[nextIdx].bbs_no);
					changeObj.find("img").attr("src", dataObj.data.guide[nextIdx].thumbnail_url);
					actionObj.attr("data-idx", nextIdx);
					break;
				case "review" : 
					var idx = actionObj.attr("data-cur-page");
					var max = actionObj.attr("data-max-page");
					var nextIdx = 0;
					if(Number(parseInt(idx)+parseInt(1))==Number(max)) {
						nextIdx = 0;
					} else {
						nextIdx = Number(parseInt(idx)+parseInt(1));
					}
					var nextPageStart = nextIdx * 3; // 3개가 한묶음
					var nextPageStart_1 = Number(parseInt(nextPageStart)+parseInt(1));
					var nextPageStart_2 = Number(parseInt(nextPageStart)+parseInt(2));
					changeObj.find(".knowcom-group__thum").attr("href", "/knowcom/detail.jsp?kbno="+dataObj.data.review[nextPageStart].kb_no);
					changeObj.find(".knowcom-group__thum--img img").attr("src", dataObj.data.review[nextPageStart].showThumbImg);
					changeObj.find(".tx--thumb").text(reviewTitleEscape(dataObj.data.review[nextPageStart].kb_title));
					changeObj.find(".knowcom-group__list li:eq(0) a").attr("href", "/knowcom/detail.jsp?kbno="+dataObj.data.review[nextPageStart_1].kb_no);
					changeObj.find(".knowcom-group__list li:eq(0) a").text(reviewTitleEscape(dataObj.data.review[nextPageStart_1].kb_title));
					changeObj.find(".knowcom-group__list li:eq(1) a").attr("href", "/knowcom/detail.jsp?kbno="+dataObj.data.review[nextPageStart_2].kb_no);
					changeObj.find(".knowcom-group__list li:eq(1) a").text(reviewTitleEscape(dataObj.data.review[nextPageStart_2].kb_title));
					actionObj.attr("data-cur-page", nextIdx);
					break;
				case "news" : 
					var idx = actionObj.attr("data-cur-page");
					var max = actionObj.attr("data-max-page");
					var nextIdx = 0;
					if(Number(parseInt(idx)+parseInt(1))==Number(max)) {
						nextIdx = 0;
					} else {
						nextIdx = Number(parseInt(idx)+parseInt(1));
					}
					var nextPageStart = nextIdx * 5; // 5개가 한묶음
					var nextPageStart_1 = Number(parseInt(nextPageStart)+parseInt(1));
					var nextPageStart_2 = Number(parseInt(nextPageStart)+parseInt(2));
					var nextPageStart_3 = Number(parseInt(nextPageStart)+parseInt(3));
					var nextPageStart_4 = Number(parseInt(nextPageStart)+parseInt(4));
					changeObj.find(".knowcom-group__list li:eq(0) a").attr("href", "/knowcom/detail.jsp?kbno="+dataObj.data.review[nextPageStart].kb_no);
					changeObj.find(".knowcom-group__list li:eq(0) a").text(reviewTitleEscape(dataObj.data.review[nextPageStart].kb_title));
					changeObj.find(".knowcom-group__list li:eq(1) a").attr("href", "/knowcom/detail.jsp?kbno="+dataObj.data.review[nextPageStart_1].kb_no);
					changeObj.find(".knowcom-group__list li:eq(1) a").text(reviewTitleEscape(dataObj.data.review[nextPageStart_1].kb_title));
					changeObj.find(".knowcom-group__list li:eq(2) a").attr("href", "/knowcom/detail.jsp?kbno="+dataObj.data.review[nextPageStart_2].kb_no);
					changeObj.find(".knowcom-group__list li:eq(2) a").text(reviewTitleEscape(dataObj.data.review[nextPageStart_2].kb_title));
					changeObj.find(".knowcom-group__list li:eq(3) a").attr("href", "/knowcom/detail.jsp?kbno="+dataObj.data.review[nextPageStart_3].kb_no);
					changeObj.find(".knowcom-group__list li:eq(3) a").text(reviewTitleEscape(dataObj.data.review[nextPageStart_3].kb_title));
					changeObj.find(".knowcom-group__list li:eq(4) a").attr("href", "/knowcom/detail.jsp?kbno="+dataObj.data.review[nextPageStart_4].kb_no);
					changeObj.find(".knowcom-group__list li:eq(4) a").text(reviewTitleEscape(dataObj.data.review[nextPageStart_4].kb_title));
					actionObj.attr("data-cur-page", nextIdx);
					break;
			}
		
		}
	});
}

// 리뷰 컨텐츠 문구 예외처리
function reviewTitleEscape(reviewTitle) {
	var title = reviewTitle;
	title = title.split("&#39;").join("'");
	if(title.length>32) {
		title = title.substring(0, 32) + "···";
	}
	return title;
}

//orderBy=1 : 중복제거한 인기 검색어
//orderBy=2 : 중복제거한 급상승 검색어
function setSearchIngiKeywrd(orderBy) {

	var param = {
		"procType" : 1,
		"orderBy" : orderBy
	}

	var ajaxObj = $.ajax({
		type : "get",
		url : "/lsv2016/ajax/getSearch_Keyword_Rank_ajax.jsp",
		async: true,
		data : param,
		dataType : "json",
		success: function(json) {
			var searchIngiKeywrdDivObj = $("#searchIngiKeywrdDiv");
			var html = "";

			var keywordListObj = json["keywordList"];
			var keywordCnt = json["keywordCnt"];

			if(keywordListObj) {
				searchIngiKeywrdDivObj.show();
				$.each(keywordListObj, function(Index, listData) {
					var keyword = listData["keyword"];
					var rank_1 = listData["rank_1"];
					var rank_2 = listData["rank_2"];
					var new_rank_1 = listData["new_rank_1"];
					var new_rank_2 = listData["new_rank_2"];
					var hotRankClass = " red";
					if(Index>2) hotRankClass = "";

					html += "<li>";
					html += "	<em class=\"tx--rank\">"+(Index+1)+"</em>";
					html += "	<a href=\"search.jsp?keyword="+keyword+"&from="+listType + "\">";
					html += keyword;
					html += "	</a>";
					html += "</li>";
				});
			}
			var listobj = $(".hot-keyword__list--hit");
			if(orderBy=="1") listobj = $(".hot-keyword__list--pop");
			else if (orderBy=="2") listobj = $(".hot-keyword__list--hit");
			listobj.html(html);

			searchIngiKeywrdDivObj.show();

			listobj.find("li a").unbind();
			listobj.find("li a").click(function() {
				var thisObj = $(this);
				var keyword = thisObj.text().trim();
				keyword = encodeURIComponent(keyword);

				if(orderBy=="1") {
					insertLogLSV(14861);
				} else if(orderBy=="2") {
					insertLogLSV(14859);
				}
			});

			var $tab = $(".hot-keyword__tab");
			$tab.click(function(e){
				e.preventDefault();
				var $pa = $(this).parent();
				$pa.addClass("is--on").siblings().removeClass("is--on");
			})
		},
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
			//console.log("thrownError="+thrownError);
		}
	});
}

///////////////////////////////////////////////////////////////// 검색결과가 없을때 최근본 상품 연관상품 시작 /////////////////////////////////////////////////////////////////

var suggestJSON;
var _suggestPageCnt;
var _currSuggestPage;

var recentItemJSON;
var recentItemCnt;
var currItem;

var recentSuggestGoods;
var recentSuggestCnt;
var _CurrRecentSuggestPage;

function fnToggleRealTime(){
	$("#realtm").toggle();
}

function loadSuggestGoods(){
	var selectedItem;
	var maxCnt = 15;
	var arrRnd;

	$.getJSON("/lsv2016/ajax/getSuggestData_json.jsp", null, function(data){

		var noResultObj = $("#noSearchListDiv");
		var jsonObj = data["suggestList"];

		var outHtml = [];

		if(jsonObj.length == 1){
			maxCnt = 18;
			/*
			outHtml.push("<div class=\"today-aboutyou\" id=\"aboutyou\">");
			outHtml.push("    <div class=\"keywords-cont\">");
			outHtml.push("    	<div class=\"keywordDesc\">에누리 인기상품<span>최근 에누리 고객이 가장 많이 클릭한 상품</span></div>");
			outHtml.push("    	<span class=\"total-paging\"><strong><em>1</em>/1</strong></span>");
			outHtml.push("       <div id=\"suggestList\"></div>");
			outHtml.push("       <div class=\"bullet_set\"><a href=\"javascript://\" class=\"Nprev\">이전</a> <a href=\"javascript://\" class=\"Nnext\">다음</a></div>");
			outHtml.push("    </div>");
			outHtml.push("</div>");
			*/

			outHtml.push("<div class=\"related-prod only-related\">");
			outHtml.push("    <div class=\"related-prod__cont\" id=\"aboutyou_cont\">");
			outHtml.push("        <p class=\"related-prod__tit\"><em>에누리 인기상품</em> 최근 에누리 고객이 가장 많이 클릭한 상품</p>");
			outHtml.push("	       <div class=\"related-prod__inner\">");
			outHtml.push("	           <div class=\"related-prod__paging\"><em></em></div>");
			outHtml.push("	           <button class=\"related-prod__btn--prev lp__sprite\">이전</button>");
			outHtml.push("	           <button class=\"related-prod__btn--next lp__sprite\">다음</button>");
			outHtml.push("	           <ul class=\"related-prod__list\"></ul>");
			outHtml.push("	      </div>");
			outHtml.push("    </div>");
			outHtml.push("</div>");


			noResultObj.after(outHtml.join("").replace(/(\>)([\s|\t]+)(\<)/gi,"$1$3"));

			suggestJSON = jsonObj[0]["goodsList3"];

			_suggestPageCnt = suggestJSON.length;

			_currSuggestPage = 1;

			$('#aboutyou_cont > .related-prod__inner > .related-prod__paging').html('<em>'+_currSuggestPage+'</em>/' + _suggestPageCnt/6);

			setSuggestPage(_currSuggestPage);

			$("#aboutyou_cont > .related-prod__inner > .related-prod__btn--prev").click(function(e){
				_currSuggestPage = _currSuggestPage - 1 == 0 ? _suggestPageCnt/6 : --_currSuggestPage;
				setSuggestPage(_currSuggestPage);
			});

			$("#aboutyou_cont > .related-prod__inner > .related-prod__btn--next").click(function(e){
				_currSuggestPage = _currSuggestPage + 1 > _suggestPageCnt/6 ? 1 : ++_currSuggestPage;
				setSuggestPage(_currSuggestPage);
			});
		} else {
			outHtml.push("<div class=\"related-prod\">");
			outHtml.push("    <div class=\"recent-prod__cont\" id=\"aboutyou\">");
			outHtml.push("	       <p class=\"recent-prod__tit\">최근 본 상품</p>");
			outHtml.push("	       <div class=\"recent-prod__inner\">");
			outHtml.push("	           <div class=\"recent-prod__paging\"><em></em></div>");
			outHtml.push("	           <button class=\"recent-prod__btn--prev lp__sprite\">이전</button>");
			outHtml.push("	           <button class=\"recent-prod__btn--next lp__sprite\">다음</button>");
			outHtml.push("	           <ul class=\"recent-prod__list\"></ul>");
			outHtml.push("	       </div>");
			outHtml.push("	   </div>");
			outHtml.push("    <div class=\"related-prod__cont\" id=\"aboutyou_cont\">");
			outHtml.push("        <p class=\"related-prod__tit\"><em></em>의 연관인기상품</p>");
			outHtml.push("	       <div class=\"related-prod__inner\">");
			outHtml.push("	           <div class=\"related-prod__paging\"><em></em></div>");
			outHtml.push("	           <button class=\"related-prod__btn--prev lp__sprite\">이전</button>");
			outHtml.push("	           <button class=\"related-prod__btn--next lp__sprite\">다음</button>");
			outHtml.push("	           <ul class=\"related-prod__list\"></ul>");
			outHtml.push("	      </div>");
			outHtml.push("    </div>");
			outHtml.push("</div>");

			/*
			noResultObj.after(outHtml.join("").replace(/(\>)([\s|\t]+)(\<)/gi,"$1$3")).queue(function(){
				$(".realtime > a").mouseenter(function(){fnToggleRealTime();}).mouseleave(function(){fnToggleRealTime();});
			});
			*/
			noResultObj.after(outHtml.join("").replace(/(\>)([\s|\t]+)(\<)/gi,"$1$3"));

			tempJSON1  = jsonObj[5]["goodsList6"];
			tempJSON2  = jsonObj[6]["goodsList7"];
			tempJSON3  = jsonObj[7]["TodayGoods"];

			tempJSON4  = jsonObj[0]["goodsList1"];
			tempJSON5  = jsonObj[1]["goodsList2"];
			tempJSON6  = jsonObj[2]["goodsList4"];
			tempJSON7  = jsonObj[3]["goodsList5"];
			tempJSON8  = jsonObj[4]["goodsList3"];
			tempJSON9  = jsonObj[8]["goodsList8"];
			tempJSON10 = jsonObj[9]["goodsList9"];

			jsonText = "";
			jsonText += "[";

			recentSuggestText = "";
			recentSuggestText = "[";

			for(i=0;i<tempJSON3.length;i++){
				var jsonTextTemp1 = [];
				var jsonTextTemp2 = [];

				jsonTextTemp1.push("{");
				jsonTextTemp1.push("  \"goodsType\":     \"" + tempJSON3[i]["goodsType"] 	+ "\"");
				jsonTextTemp1.push(" ,\"goodsModelno\":  \"" + tempJSON3[i]["goodsModelno"] + "\"");
				jsonTextTemp1.push(" ,\"goodsPrice\":    \"" + tempJSON3[i]["goodsPrice"] 	+ "\"");

				if(tempJSON3[i]["goodsType"]=="G"){
					for(k=0;k<tempJSON1.length;k++){
						if(tempJSON3[i]["goodsModelno"] == tempJSON1[k]["modelno"]){
							jsonTextTemp2.push(" ,\"minprice\":\""  		+ tempJSON1[k]["minprice"] 			+ "\"");
							jsonTextTemp2.push(" ,\"minprice2\":\""  		+ tempJSON1[k]["minprice2"] 		+ "\"");
							jsonTextTemp2.push(" ,\"strImgsrc\":\"" 		+ tempJSON1[k]["strImgsrc"]			+ "\"");
							jsonTextTemp2.push(" ,\"strImgsrc2\":\"" 		+ tempJSON1[k]["strImgsrc2"]		+ "\"");
							jsonTextTemp2.push(" ,\"modelnm\":\"" 	 		+ tempJSON1[k]["modelnm"].replaceAll("\t","").replace("[일반]","")	+ "\"");
							jsonTextTemp2.push(" ,\"ca_code\":\"" 	 		+ tempJSON1[k]["ca_code"] 			+ "\"");
							jsonTextTemp2.push(" ,\"openexpectflag\":\"" 	+ tempJSON1[k]["openexpectflag"] 	+ "\"");

							break;
						}
					}
				} else if(tempJSON3[i]["goodsType"]=="P"){
					for(k=0;k<tempJSON2.length;k++){
						if(tempJSON3[i]["goodsModelno"] == tempJSON2[k]["pl_no"]){
							jsonTextTemp2.push(" ,\"minprice\":\""  		+ tempJSON2[k]["price"] 	 	+ "\"");
							jsonTextTemp2.push(" ,\"minprice2\":\"\"");
							jsonTextTemp2.push(" ,\"strImgsrc\":\"" 		+ tempJSON2[k]["imgurl"] 	 	+ "\"");
							jsonTextTemp2.push(" ,\"strImgsrc2\":\"\"");
							jsonTextTemp2.push(" ,\"modelnm\":\"" 			+ tempJSON2[k]["goodsnm"].replaceAll("\t","") 	 	+ "\"");
							jsonTextTemp2.push(" ,\"url\":\"" 				+ tempJSON2[k]["url"] 		 	+ "\"");
							jsonTextTemp2.push(" ,\"shop_name\":\"" 		+ tempJSON2[k]["shop_name"] 	+ "\"");
							jsonTextTemp2.push(" ,\"ca_code\":\""   		+ tempJSON2[k]["ca_code"]   	+ "\"");
							jsonTextTemp2.push(" ,\"shop_code\":\"" 		+ tempJSON2[k]["shop_code"]   	+ "\"");
							jsonTextTemp2.push(" ,\"openexpectflag\":\""	+ tempJSON2[k]["openexpectflag"]+ "\"");

							break;
						}
					}
				}

				if(jsonTextTemp2.length != 0){
					jsonText += jsonTextTemp1.join("").replace(/(\>)([\s|\t]+)(\<)/gi,"$1$3") + jsonTextTemp2.join("").replace(/(\>)([\s|\t]+)(\<)/gi,"$1$3") + "}";

					if(i!=tempJSON3.length-1)
						jsonText += ",";
				}
			}

			jsonText += "]";

			recentItemJSON = $.parseJSON(jsonText);

			recentSuggestGoods = new Array();

			for(i=0;i<recentItemJSON.length;i++){
				cnt = 50;
				var tempJSON = [];

				tempJSON.push("[");

				for(j=0;j<tempJSON4.length;j++){
					if(((recentItemJSON[i]["ca_code"].trim().length >= 6 && recentItemJSON[i]["ca_code"].substring(0,6) == tempJSON4[j]["ca_code"].substring(0,6)) || (recentItemJSON[i]["ca_code"].trim().length < 6 && recentItemJSON[i]["ca_code"].trim() == tempJSON4[j]["org_ca_code"].trim())) && recentItemJSON[i]["goodsModelno"] != tempJSON4[j]["modelno"]){
						if((parseInt(tempJSON4[j]["openexpectflag"]) == 0 && parseInt(tempJSON4[j]["mallcnt"]) > 0) || parseInt(tempJSON4[j]["openexpectflag"]) == 1){
							cnt--;

							tempJSON.push("{");
							tempJSON.push("  \"goodsType\":\"G\"");
							tempJSON.push(" ,\"modelno\":\""   		+ tempJSON4[j]["modelno"] 	 		+ "\"");
							tempJSON.push(" ,\"minprice\":\""  		+ tempJSON4[j]["minprice"]  		+ "\"");
							tempJSON.push(" ,\"minprice2\":\""  	+ tempJSON4[j]["minprice2"]  		+ "\"");
							tempJSON.push(" ,\"strImgsrc\":\"" 		+ tempJSON4[j]["strImgsrc"] 		+ "\"");
							tempJSON.push(" ,\"strImgsrc2\":\"" 	+ tempJSON4[j]["strImgsrc2"] 		+ "\"");
							tempJSON.push(" ,\"modelnm\":\"" 	 	+ tempJSON4[j]["modelnm"] 	 		+ "\"");
							tempJSON.push(" ,\"ca_code\":\"" 	 	+ tempJSON4[j]["ca_code"] 	 		+ "\"");
							tempJSON.push(" ,\"openexpectflag\":\"" + tempJSON4[j]["openexpectflag"] 	+ "\"");
							tempJSON.push(" ,\"shop_code\":\"\"");
							tempJSON.push(" ,\"url\":\"\"");
							tempJSON.push(" ,\"shop_name\":\"\"");
							tempJSON.push("},");
						}
					}
				}

				for(j=0;j<tempJSON5.length;j++){
					if(((recentItemJSON[i]["ca_code"].trim().length >= 6 && (recentItemJSON[i]["ca_code"].substring(0,6) == tempJSON5[j]["ca_code"].substring(0,6))) || (recentItemJSON[i]["ca_code"].trim().length < 6 && (recentItemJSON[i]["ca_code"].trim() == tempJSON5[j]["org_ca_code"].trim()))) && recentItemJSON[i]["goodsModelno"] != tempJSON5[j]["modelno"]){
						if((parseInt(tempJSON5[j]["openexpectflag"]) == 0 && parseInt(tempJSON5[j]["mallcnt"]) > 0) || parseInt(tempJSON5[j]["openexpectflag"]) == 1){
							cnt--;

							tempJSON.push("{");
							tempJSON.push("  \"goodsType\":\"G\"");
							tempJSON.push(" ,\"modelno\":\""   		+ tempJSON5[j]["modelno"] 	 		+ "\"");
							tempJSON.push(" ,\"minprice\":\""  		+ tempJSON5[j]["minprice"]  		+ "\"");
							tempJSON.push(" ,\"minprice2\":\""  	+ tempJSON5[j]["minprice2"]  		+ "\"");
							tempJSON.push(" ,\"strImgsrc\":\"" 		+ tempJSON5[j]["strImgsrc"] 		+ "\"");
							tempJSON.push(" ,\"strImgsrc2\":\"" 	+ tempJSON5[j]["strImgsrc2"] 		+ "\"");
							tempJSON.push(" ,\"modelnm\":\"" 	 	+ tempJSON5[j]["modelnm"] 	 		+ "\"");
							tempJSON.push(" ,\"ca_code\":\"" 	 	+ tempJSON5[j]["ca_code"] 	 		+ "\"");
							tempJSON.push(" ,\"openexpectflag\":\"" + tempJSON5[j]["openexpectflag"] 	+ "\"");
							tempJSON.push(" ,\"shop_code\":\"\"");
							tempJSON.push(" ,\"url\":\"\"");
							tempJSON.push(" ,\"shop_name\":\"\"");
							tempJSON.push("},");
						}
					}
				}

				for(j=0;j<tempJSON6.length;j++){
					if(((recentItemJSON[i]["ca_code"].trim().length >= 6 && (recentItemJSON[i]["ca_code"].substring(0,6) == tempJSON6[j]["ca_code"].substring(0,6))) || (recentItemJSON[i]["ca_code"].trim().length < 6 && (recentItemJSON[i]["ca_code"].trim() == tempJSON6[j]["org_ca_code"].trim()))) && recentItemJSON[i]["goodsModelno"] != tempJSON6[j]["pl_no"]){
						cnt--;

						tempJSON.push("{");
						tempJSON.push("  \"goodsType\":\"P\"");
						tempJSON.push(" ,\"modelno\":\""   		+ tempJSON6[j]["pl_no"] 	 	+ "\"");
						tempJSON.push(" ,\"minprice\":\""  		+ tempJSON6[j]["price"] 	 	+ "\"");
						tempJSON.push(" ,\"minprice2\":\"\"");
						tempJSON.push(" ,\"strImgsrc\":\"" 		+ tempJSON6[j]["imgurl"] 	 	+ "\"");
						tempJSON.push(" ,\"strImgsrc2\":\"\"");
						tempJSON.push(" ,\"modelnm\":\"" 	 	+ tempJSON6[j]["goodsnm"].replaceAll("\t","") + "\"");
						tempJSON.push(" ,\"ca_code\":\""   		+ tempJSON6[j]["ca_code"]   	+ "\"");
						tempJSON.push(" ,\"shop_code\":\"" 		+ tempJSON6[j]["shop_code"] 	+ "\"");
						tempJSON.push(" ,\"url\":\"" 		 	+ tempJSON6[j]["url"] 		 	+ "\"");
						tempJSON.push(" ,\"shop_name\":\"" 		+ tempJSON6[j]["shop_name"] 	+ "\"");
						tempJSON.push(" ,\"openexpectflag\":\"" + tempJSON6[j]["openexpectflag"]+ "\"");
						tempJSON.push("},");
					}
				}

				for(j=0;j<tempJSON7.length;j++){
					if(((recentItemJSON[i]["ca_code"].trim().length >= 6 && recentItemJSON[i]["ca_code"].substring(0,6) == tempJSON7[j]["ca_code"].substring(0,6)) || (recentItemJSON[i]["ca_code"].trim().length < 6 && recentItemJSON[i]["ca_code"].trim() == tempJSON7[j]["org_ca_code"].trim())) && recentItemJSON[i]["goodsModelno"] != tempJSON7[j]["pl_no"]){
						cnt--;

						tempJSON.push("{");
						tempJSON.push("  \"goodsType\":\"P\"");
						tempJSON.push(" ,\"modelno\":\""   		+ tempJSON7[j]["pl_no"] 	 		+ "\"");
						tempJSON.push(" ,\"minprice\":\""  		+ tempJSON7[j]["price"] 	 		+ "\"");
						tempJSON.push(" ,\"minprice2\":\"\"");
						tempJSON.push(" ,\"strImgsrc\":\"" 		+ tempJSON7[j]["imgurl"] 	 		+ "\"");
						tempJSON.push(" ,\"strImgsrc2\":\"\"");
						tempJSON.push(" ,\"modelnm\":\"" 	 	+ tempJSON7[j]["goodsnm"].replaceAll("\t","")	+ "\"");
						tempJSON.push(" ,\"ca_code\":\""   		+ tempJSON7[j]["ca_code"]   		+ "\"");
						tempJSON.push(" ,\"shop_code\":\"" 		+ tempJSON7[j]["shop_code"] 		+ "\"");
						tempJSON.push(" ,\"url\":\"" 		 	+ tempJSON7[j]["url"] 		 		+ "\"");
						tempJSON.push(" ,\"shop_name\":\"" 		+ tempJSON7[j]["shop_name"] 		+ "\"");
						tempJSON.push(" ,\"openexpectflag\":\"" + tempJSON7[j]["openexpectflag"] 	+ "\"");
						tempJSON.push("},");
					}
				}

				if(cnt > 38){
					for(j=0;j<tempJSON9.length && cnt > 38;j++){
						if((recentItemJSON[i]["ca_code"].trim().substring(0,tempJSON9[j]["org_ca_code"].trim().length) == tempJSON9[j]["org_ca_code"].trim()) && recentItemJSON[i]["goodsModelno"] != tempJSON9[j]["modelno"]){
							if((parseInt(tempJSON9[j]["openexpectflag"]) == 0 && parseInt(tempJSON9[j]["mallcnt"]) > 0) || parseInt(tempJSON9[j]["openexpectflag"]) == 1){
								cnt--;

								tempJSON.push("{");
								tempJSON.push("  \"goodsType\":\"G\"");
								tempJSON.push(" ,\"modelno\":\""   			+ tempJSON9[j]["modelno"] 	 		+ "\"");
								tempJSON.push(" ,\"minprice\":\""  			+ tempJSON9[j]["minprice"]  		+ "\"");
								tempJSON.push(" ,\"minprice2\":\""  		+ tempJSON9[j]["minprice2"]  		+ "\"");
								tempJSON.push(" ,\"strImgsrc\":\"" 			+ tempJSON9[j]["strImgsrc"] 		+ "\"");
								tempJSON.push(" ,\"strImgsrc2\":\"" 		+ tempJSON9[j]["strImgsrc2"] 		+ "\"");
								tempJSON.push(" ,\"modelnm\":\"" 	 		+ tempJSON9[j]["modelnm"] 	 		+ "\"");
								tempJSON.push(" ,\"ca_code\":\"" 	 		+ tempJSON9[j]["ca_code"] 	 		+ "\"");
								tempJSON.push(" ,\"openexpectflag\":\"" 	+ tempJSON9[j]["openexpectflag"] 	+ "\"");
								tempJSON.push(" ,\"shop_code\":\"\"");
								tempJSON.push(" ,\"url\":\"\"");
								tempJSON.push(" ,\"shop_name\":\"\"");
								tempJSON.push("},");
							}
						}
					}

					for(j=0;j<tempJSON10.length && cnt > 38;j++){
						if((recentItemJSON[i]["ca_code"].trim().substring(0,tempJSON10[j]["org_ca_code"].trim().length) == tempJSON10[j]["org_ca_code"].trim()) && recentItemJSON[i]["goodsModelno"] != tempJSON10[j]["modelno"]){
							cnt--;

							tempJSON.push("{");
							tempJSON.push("  \"goodsType\":\"P\"");
							tempJSON.push(" ,\"modelno\":\""   		+ tempJSON10[j]["pl_no"] 	 	+ "\"");
							tempJSON.push(" ,\"minprice\":\""  		+ tempJSON10[j]["price"] 	 	+ "\"");
							tempJSON.push(" ,\"minprice2\":\"\"");
							tempJSON.push(" ,\"strImgsrc\":\"" 		+ tempJSON10[j]["imgurl"] 	 	+ "\"");
							tempJSON.push(" ,\"strImgsrc2\":\"\"");
							tempJSON.push(" ,\"modelnm\":\"" 	 	+ tempJSON10[j]["goodsnm"] 	 	+ "\"");
							tempJSON.push(" ,\"ca_code\":\""   		+ tempJSON10[j]["ca_code"]   	+ "\"");
							tempJSON.push(" ,\"shop_code\":\"" 		+ tempJSON10[j]["shop_code"] 	+ "\"");
							tempJSON.push(" ,\"url\":\"" 		 	+ tempJSON10[j]["url"] 		 	+ "\"");
							tempJSON.push(" ,\"shop_name\":\"" 		+ tempJSON10[j]["shop_name"] 	+ "\"");
							tempJSON.push(" ,\"openexpectflag\":\"" + tempJSON10[j]["openexpectflag"]+ "\"");
							tempJSON.push("},");
						}
					}

					for(j=0;j<tempJSON8.length && cnt > 38;j++){
						if(recentItemJSON[i]["goodsModelno"] != tempJSON8[j]["modelno"]){
							cnt--;

							tempJSON.push("{");
							tempJSON.push("  \"goodsType\":\"G\"");
							tempJSON.push(" ,\"modelno\":\""   		+ tempJSON8[j]["modelno"] 	 	 + "\"");
							tempJSON.push(" ,\"minprice\":\""  		+ tempJSON8[j]["minprice"]  	 + "\"");
							tempJSON.push(" ,\"minprice2\":\""  	+ tempJSON8[j]["minprice2"]  	 + "\"");
							tempJSON.push(" ,\"strImgsrc\":\"" 		+ tempJSON8[j]["strImgsrc"] 	 + "\"");
							tempJSON.push(" ,\"strImgsrc2\":\""		+ tempJSON8[j]["strImgsrc2"] 	 + "\"");
							tempJSON.push(" ,\"modelnm\":\"" 	 	+ tempJSON8[j]["modelnm"] 	 	 + "\"");
							tempJSON.push(" ,\"ca_code\":\"" 	 	+ tempJSON8[j]["ca_code"] 	 	 + "\"");
							tempJSON.push(" ,\"openexpectflag\":\""	+ tempJSON8[j]["openexpectflag"] + "\"");
							tempJSON.push(" ,\"shop_code\":\"\"");
							tempJSON.push(" ,\"url\":\"\"");
							tempJSON.push(" ,\"shop_name\":\"\"");
							tempJSON.push("},");
						}
					}
				}

				var tempJSON2 = tempJSON.join("").replace(/(\>)([\s|\t]+)(\<)/gi,"$1$3");

				if(tempJSON2.substring(tempJSON2.length-1,tempJSON2.length) == ",")
					tempJSON2 = tempJSON2.substring(0,tempJSON2.length-1);

				tempJSON2 += "]";

				recentSuggestGoods.push($.parseJSON(tempJSON2.replaceAll("\\r\\n","").replaceAll("\\n","").replaceAll("\n","")));

				tempJSON2 = null;
			}

			tempJSON = null;

			var recentSuggestText;
			var recentSuggestTemp = new Array();

			for(i=0;i<recentSuggestGoods.length;i++){
				var rndEnd = 15;
				var rndStart = recentSuggestGoods[i].length;
				if(rndStart<rndEnd) rndEnd = rndStart;
				var rndValue = fnGetRandomNum(rndStart, rndEnd);
				//var rndValue = fnGetRandomNum(recentSuggestGoods[i].length, 15);

				recentSuggestText = "[";

				for(j=0;j<rndValue.length;j++){
					if(j>0){
						recentSuggestText += ",";
					}
					recentSuggestText += "{";
					recentSuggestText += "  \"goodsType\":\"" 		+ recentSuggestGoods[i][rndValue[j]]["goodsType"]  		+ "\"";
					recentSuggestText += " ,\"modelno\":\""   		+ recentSuggestGoods[i][rndValue[j]]["modelno"] 	 	+ "\"";
					recentSuggestText += " ,\"minprice\":\""  		+ recentSuggestGoods[i][rndValue[j]]["minprice"] 	 	+ "\"";
					recentSuggestText += " ,\"minprice2\":\""  		+ recentSuggestGoods[i][rndValue[j]]["minprice2"] 	 	+ "\"";
					recentSuggestText += " ,\"strImgsrc\":\"" 		+ recentSuggestGoods[i][rndValue[j]]["strImgsrc"]  		+ "\"";
					recentSuggestText += " ,\"strImgsrc2\":\""		+ recentSuggestGoods[i][rndValue[j]]["strImgsrc2"]  	+ "\"";
					recentSuggestText += " ,\"modelnm\":\""   		+ recentSuggestGoods[i][rndValue[j]]["modelnm"].replace("[일반]","") 	 	+ "\"";
					recentSuggestText += " ,\"ca_code\":\""   		+ recentSuggestGoods[i][rndValue[j]]["ca_code"]    		+ "\"";
					recentSuggestText += " ,\"shop_code\":\"" 		+ recentSuggestGoods[i][rndValue[j]]["shop_code"]  		+ "\"";
					recentSuggestText += " ,\"url\":\""       		+ recentSuggestGoods[i][rndValue[j]]["url"] 	 	 	+ "\"";
					recentSuggestText += " ,\"shop_name\":\"" 		+ recentSuggestGoods[i][rndValue[j]]["shop_name"]  		+ "\"";
					recentSuggestText += " ,\"openexpectflag\":\"" 	+ recentSuggestGoods[i][rndValue[j]]["openexpectflag"]  + "\"";
					recentSuggestText += "}";
				}

				recentSuggestText += "]";

				recentSuggestTemp.push($.parseJSON(recentSuggestText));
			}

			recentSuggestText = null;

			recentSuggestGoods = recentSuggestTemp;

			recentSuggestTemp = null;

			currItem = 1;

			recentItemCnt = recentItemJSON.length;

			//innerHTML 부분
			//$("#aboutyou > .recent > .total-paging > strong").html("<em>" + currItem + "</em>/" + recentItemCnt);
			$("#aboutyou > .recent-prod__inner > .recent-prod__paging").html("<em>" + currItem + "</em>/" + recentItemCnt);

			setRecentItem(currItem);

			$("#aboutyou > .recent-prod__inner > .recent-prod__btn--prev").click(function(){
				currItem = currItem - 1 == 0 ? recentItemCnt : --currItem;
				setRecentItem(currItem);
			});

			$("#aboutyou > .recent-prod__inner > .recent-prod__btn--next").click(function(){
				currItem = currItem + 1 > recentItemCnt ? 1 : ++currItem;
				setRecentItem(currItem);
			});

			$("#aboutyou_cont > .related-prod__inner > .related-prod__btn--prev").click(function(){
				if((_CurrRecentSuggestPage - 1) <=0) {
					_CurrRecentSuggestPage = parseInt(recentSuggestCnt / 4);
				} else {
					_CurrRecentSuggestPage = _CurrRecentSuggestPage - 1;
				}

				setRecentSuggestGoods(_CurrRecentSuggestPage);
			});

			$("#aboutyou_cont > .related-prod__inner > .related-prod__btn--next").click(function(){
				_CurrRecentSuggestPage = _CurrRecentSuggestPage + 1 > recentSuggestCnt/4 ? 1 : ++_CurrRecentSuggestPage;
				setRecentSuggestGoods(_CurrRecentSuggestPage);
			});
		}
	});
}

function setRecentItem(list){
	//try{
		//var bLowerPrice = Math.floor((recentItemJSON[currItem-1]["goodsPrice"]-recentItemJSON[currItem-1]["minprice"])*100/recentItemJSON[currItem-1]["goodsPrice"]) > 0 && parseInt(recentItemJSON[currItem-1]["openexpectflag"])==0;

		//$("#aboutyou > .recent > .total-paging > strong > em").html(list);
		$("#aboutyou  > .recent-prod__inner > .recent-prod__paging > em").html(list);

		var outHtml = [];
		outHtml.push("				<li  class=\"recent-prod__item\">");

		if(recentItemJSON[currItem-1]["goodsType"] == "G" ){
			outHtml.push("					<a href=\"/detail.jsp?modelno=" + recentItemJSON[currItem-1]["goodsModelno"] +"\">");
		}else{
			outHtml.push("					<a href=\"/move/Redirect.jsp?type=ex&cmd=move_"+recentItemJSON[currItem-1]["goodsModelno"]+"&pl_no="+recentItemJSON[currItem-1]["goodsModelno"]+"\">");
		}

				// 강제로 성인이미지 변경
		if(recentItemJSON[currItem-1]["strImgsrc"].indexOf("thum_adult.gif")>-1) {
			recentItemJSON[currItem-1]["strImgsrc"] = adultImgStr;
		}

		outHtml.push("						<div class=\"recent-prod__thumb\">");
		outHtml.push("							<img src=\""+ recentItemJSON[currItem-1]["strImgsrc"] + "\" onerror=\"this.src='" + (recentItemJSON[currItem-1]["strImgsrc2"].trim() == "" ? noImageStr : recentItemJSON[currItem-1]["strImgsrc2"].trim()) + "'\" alt=\"" + recentItemJSON[currItem-1]["modelnm"] + "\">");
		outHtml.push("						</div>");

		if(recentItemJSON[currItem-1]["goodsType"] == "P"){
			outHtml.push("						<div class=\"recent-prod__name\">");
			outHtml.push("							<span class=\"shop\">[" + recentItemJSON[currItem-1]["shop_name"] + "]</span>" + recentItemJSON[currItem-1]["modelnm"].trim().replace(/\[[^\]]*\]/,''));
			outHtml.push("						</div>");
			outHtml.push("						<div class=\"recent-prod__price\">");
			outHtml.push("							최저가 <em>" + recentItemJSON[currItem-1]["minprice"].NumberFormat() + "</em>원");
			outHtml.push("						</div>");
		}else{
			outHtml.push("						<div class=\"recent-prod__name\">");
			outHtml.push("							"+ recentItemJSON[currItem-1]["modelnm"] +"");
			outHtml.push("						</div>");
			outHtml.push("						<div class=\"recent-prod__price\">");

			if(parseInt(recentItemJSON[currItem-1]["openexpectflag"])==1){
				outHtml.push("							<em class=\"lowprice\">가격미정</em>");
			} else {
				if ((recentItemJSON[currItem-1]["ca_code"].substring(0,4) == "0304" || recentItemJSON[currItem-1]["ca_code"].substring(0,4) == "0305" || recentItemJSON[currItem-1]["ca_code"].substring(0,4) == "0353") && parseInt(recentItemJSON[currItem-1]["minprice"])==0 && recentItemJSON[currItem-1]["minprice2"] != "")
					outHtml.push("							최저가<em>수수료 " + recentItemJSON[currItem-1]["minprice2"].NumberFormat() + "</em>원");
				else if(parseInt(recentItemJSON[currItem-1]["minprice"]) == 0)
					outHtml.push("							최저가<em>일시품절</em>");
				else
					outHtml.push("							최저가<em>" + recentItemJSON[currItem-1]["minprice"].NumberFormat() + "</em>원");
			}
			outHtml.push("						</div>");
		}
		outHtml.push("					</li>");

		$("#aboutyou_cont > .related-prod__tit > em").html(recentItemJSON[currItem-1]["modelnm"].trim().replace(/\[[^\]]*\]$/,'').replace(/^\[[^\]]*\]/,''));
		$("#aboutyou  > div").find("ul").html(outHtml.join("").replace(/(\>)([\s|\t]+)(\<)/gi,"$1$3"));

		_CurrRecentSuggestPage = 1;
		recentSuggestCnt = recentSuggestGoods[currItem-1].length;

		var tmpTotPage = Math.ceil(recentSuggestCnt/5);

		$("#aboutyou_cont > .related-prod__inner > .related-prod__paging").html("<em>" + _CurrRecentSuggestPage + "</em>/" + tmpTotPage);

		setRecentSuggestGoods(_CurrRecentSuggestPage);
	//}catch(e){

	//}
}

function setRecentSuggestGoods(page){

	//$("#aboutyou_cont > .keywords-cont > .total-paging > strong > em").html(page);
	$("#aboutyou_cont  > .related-prod__inner > .related-prod__paging > em").html(page);

	var outHtml = [];

	for(i=(page-1)*5;i<(page)*5;i++){
		if(!recentSuggestGoods[currItem-1][i]) continue;

		outHtml.push("				<li  class=\"related-prod__item\">");

		if(recentSuggestGoods[currItem-1][i]["goodsType"] == "G"){
			outHtml.push("					<a href=\"/detail.jsp?modelno=" +recentSuggestGoods[currItem-1][i]["modelno"]+"\">");
		}else{
			outHtml.push("					<a href=\"/move/Redirect.jsp?type=ex&cmd=move_"+recentSuggestGoods[currItem-1][i]["modelno"]+"&pl_no="+recentSuggestGoods[currItem-1][i]["modelno"]+"\">");
		}

		// 강제로 성인이미지 변경
		if(recentItemJSON[currItem-1]["strImgsrc"].indexOf("thum_adult.gif")>-1) {
			recentItemJSON[currItem-1]["strImgsrc"] = adultImgStr;
		}

		outHtml.push("						<div class=\"related-prod__thumb\">");
		outHtml.push("							<img src=\""+ recentSuggestGoods[currItem-1][i]["strImgsrc"] + "\" onerror=\"this.src='" + (recentSuggestGoods[currItem-1][i]["strImgsrc2"].trim() == "" ? noImageStr : recentSuggestGoods[currItem-1][i]["strImgsrc2"].trim()) + "'\" alt=\"" + recentSuggestGoods[currItem-1][i]["modelnm"] + "\">");
		outHtml.push("						</div>");

		if(recentSuggestGoods[currItem-1][i]["goodsType"] == "P"){
			outHtml.push("						<div class=\"related-prod__name\">");
			outHtml.push("							<span class=\"shop\">[" + recentSuggestGoods[currItem-1][i]["shop_name"] + "]</span>" + recentSuggestGoods[currItem-1][i]["modelnm"].trim().replace(/\[[^\]]*\]/,''));
			outHtml.push("						</div>");
			outHtml.push("						<div class=\"related-prod__price\">");
			outHtml.push("							최저가 <em>" + recentSuggestGoods[currItem-1][i]["minprice"].NumberFormat() + "</em>원");
			outHtml.push("						</div>");
		}else{
			outHtml.push("						<div class=\"related-prod__name\">");
			outHtml.push("							"+ recentSuggestGoods[currItem-1][i]["modelnm"] +"");
			outHtml.push("						</div>");
			outHtml.push("						<div class=\"related-prod__price\">");

			if(parseInt(recentSuggestGoods[currItem-1][i]["openexpectflag"])==1){
				outHtml.push("							<em class=\"lowprice\">가격미정</em>");
			} else {
				if ((recentSuggestGoods[currItem-1][i]["ca_code"].substring(0,4) == "0304" || recentSuggestGoods[currItem-1][i]["ca_code"].substring(0,4) == "0305" || recentSuggestGoods[currItem-1][i]["ca_code"].substring(0,4) == "0353") && parseInt(recentSuggestGoods[currItem-1][i]["minprice"])==0 && recentSuggestGoods[currItem-1][i]["minprice2"] != "")
					outHtml.push("							최저가<em>수수료 " + recentSuggestGoods[currItem-1][i]["minprice2"].NumberFormat() + "</em>원");
				else if(parseInt(recentSuggestGoods[currItem-1][i]["minprice"]) == 0)
					outHtml.push("							최저가<em>일시품절</em>");
				else
					outHtml.push("							최저가<em>" + recentSuggestGoods[currItem-1][i]["minprice"].NumberFormat() + "</em>원");
			}
			outHtml.push("						</div>");
		}
		outHtml.push("					</li>");
	}

	$("#aboutyou_cont > .related-prod__inner > ul").html(outHtml.join("").replace(/(\>)([\s|\t]+)(\<)/gi,"$1$3"));
}

function fnGetRandomNum(maxNum,cnt){
	var arrRnd = new Array();

	while(arrRnd.length < cnt){
		rnd = Math.floor(Math.random()*maxNum);

		var isExist = false;

		for(k=0;k<arrRnd.length;k++)
			if(arrRnd[k] == rnd)
				isExist = true;

		if(!isExist)
			arrRnd.push(rnd);
	}

	return arrRnd;
}

function setSuggestPage(page){

	$("#aboutyou_cont  > .related-prod__inner > .related-prod__paging > em").html(page);

	var outHtml = [];

	outHtml.push("        <ul>");

	for(i=(page-1)*6;i<(page)*6;i++){
		/*
		outHtml.push("			<li>");
		outHtml.push("				<strong><a href=\"javascript://\" onclick=\"fnopenWin(" + suggestJSON[i]["modelno"] + ");insertLogLSV(14444);\">");
		outHtml.push("				<img alt=\"" + suggestJSON[i]["modelnm"] + "\" src=\"" + suggestJSON[i]["strImgsrc"] + "\" onerror=\"this.src='" + (suggestJSON[i]["strImgsrc2"] == "" ? noImageStr : suggestJSON[i]["strImgsrc2"]) + "'\"></a></strong>");
		outHtml.push("				<p>");
		outHtml.push("					<strong><a href=\"javascript://\" onclick=\"fnopenWin(" + suggestJSON[i]["modelno"] + ");insertLogLSV(14444);\">" + suggestJSON[i]["modelnm"].replace(/\[[^\]]*\]/,'') + "</a></strong>");

		if(parseInt(suggestJSON[i]["openexpectflag"])==1){
			outHtml.push("                        <span><em class=\"lowprice\">가격미정</em></span>");
		} else {
			if ((suggestJSON[i]["ca_code"].substring(0,4) == "0304" || suggestJSON[i]["ca_code"].substring(0,4) == "0305" || suggestJSON[i]["ca_code"].substring(0,4) == "0353") && parseInt(suggestJSON[i]["minprice"])==0 && suggestJSON[i]["minprice2"] != "")
				outHtml.push("                        <span><em class=\"lowest2\">최저가</em><em class=\"lowprice\">수수료 " + suggestJSON[i]["minprice2"].NumberFormat() + "원</em></span>");
			else if(parseInt(suggestJSON[i]["minprice"]) == 0)
				outHtml.push("                        <span><em class=\"lowest2\">최저가</em><em class=\"lowprice\">일시품절</em></span>");
			else
				outHtml.push("                        <span><em class=\"lowest\">최저가</em><em class=\"lowprice\">" + suggestJSON[i]["minprice"].NumberFormat() + "원</em></span>");
		}

		outHtml.push("				</p>");
		outHtml.push("			</li>");
		*/

		outHtml.push("<li class=\"related-prod__item\">");
		outHtml.push("	<a href=\"/detail.jsp?modelno=" + suggestJSON[i]["modelno"] + "\">");
		outHtml.push("		<div class=\"related-prod__thumb\">");
		outHtml.push("			<img alt=\"" + suggestJSON[i]["modelnm"] + "\" src=\"" + suggestJSON[i]["strImgsrc"] + "\" onerror=\"this.src='" + (suggestJSON[i]["strImgsrc2"] == "" ? noImageStr : suggestJSON[i]["strImgsrc2"]) + "'\">");
		outHtml.push("		</div>");
		outHtml.push("		<div class=\"related-prod__name\">");
		outHtml.push("			" + suggestJSON[i]["modelnm"].replace(/\[[^\]]*\]/,'') + "");
		outHtml.push("		</div>");
		outHtml.push("		<div class=\"related-prod__price\">");
		if(parseInt(suggestJSON[i]["openexpectflag"])==1){
			outHtml.push("			가격미정");
		} else {
			if ((suggestJSON[i]["ca_code"].substring(0,4) == "0304" || suggestJSON[i]["ca_code"].substring(0,4) == "0305" || suggestJSON[i]["ca_code"].substring(0,4) == "0353") && parseInt(suggestJSON[i]["minprice"])==0 && suggestJSON[i]["minprice2"] != "")
				outHtml.push("			최저가<em>수수료 " + suggestJSON[i]["minprice2"].NumberFormat() + "</em>원");
			else if(parseInt(suggestJSON[i]["minprice"]) == 0)
				outHtml.push("			최저가<em>일시품절</em>");
			else
				outHtml.push("			최저가<em>" + suggestJSON[i]["minprice"].NumberFormat() + "</em>원");
		}
		outHtml.push("		</div>");
		outHtml.push("	</a>");
		outHtml.push("</li>	");

	}

	outHtml.push("		</ul>");

	$("#aboutyou_cont > .related-prod__inner > ul").html(outHtml.join("").replace(/(\>)([\s|\t]+)(\<)/gi,"$1$3"));
}

function Set_session(part, val) {
	var sessiondata;
	if(part == "pagegap"){
		sessiondata = {"pagegap" : val};
	}else if(part == "listgridtype"){
		sessiondata = {"listgridtype" : val};
	}
	$.ajax({
		type : "POST",
		url : "/wide/common/jsp/S_session.jsp",
		dataType : "json",
		data : sessiondata
	});
}

///////////////////////////////////////////////////////////////// 검색결과가 없을때 최근본 상품 연관상품 끝 /////////////////////////////////////////////////////////////////