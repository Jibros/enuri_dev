var adEventAMap = new CustomMap();
// 광고 호출
function loadSupertop(ads, adData, highRankData) {
	if(ads.length == 0) {
		return;
	}
	drawAd(listType, adData, ads, highRankData);
}

function drawAd(listType, adData, dstParam, highRankData) {
	var adHashMap = new CustomMap();
	// 슈퍼탑 A 유형이 있을 경우
	if(adData.length>0) {
		var modelno = 0;
		for(var i=0;i<adData.length;i++) {
			modelno = adData[i].attributes.getNamedItem("data-model-origin").value;
			if(modelno>0) {
				adHashMap.set(modelno, adData[i].outerHTML);
			}
		}
	}
	
	var adHtml = "";
	var adLightHtml = ""; // 20200819 슈퍼탑라이트 추가
	var adContentAMap = new CustomMap();
	var adContentBMap = new CustomMap();
	var adSuperTopAMap = new CustomMap();
	var adSuperTopBMap = new CustomMap();
	var drawCnt = 0;
	var drawACnt = 0;
	
	var	targetUrl = "/lsv2016/ajax/getSearchSponsor_ajax.jsp";
	var	targetParam = "ad=" + dstParam + "&device=PC";
	
	// 2020.08.03 #41050 [슈퍼탑] IMP 집계방식 변경 및 관련 로직 수정
	// boolAd = true 이면 imp 로그호출
	var boolAD = false;
	var ajaxObj = $.ajax({
		type : "get", 
		url : targetUrl + "?" + targetParam,
		dataType : "json", 
		success: function(ret) {
			var obj = ret.adList;
			var objLight = ret.adLightList;
			var drawLimit = ret.drawCnt;
			
			if(obj.length > 0) {
				
				$("ad-supertop").remove();
				// #41717 [PC] 슈퍼탑, 슈퍼탑 라이트 LP 변경
				if(viewType == "1"){
					adHtml += "<li class=\"ad-supertop\">";
					adHtml +="	<div class=\"comm_ad_tit\">";
					adHtml += "		<em>슈퍼탑</em>";
					adHtml += "		<a href=\"https://seller.enuri.com/sdul/supertop/sdul_supertop_redirect.jsp\" target=\"_blank\" class=\"comm_btn_apply\">신청하기</a>";
					adHtml += "	</div>";
					adHtml += "	<ul class=\"ad-supertop__list\">";
				}
				
				// A, B 타입 합쳐서 그린다.
				for(var index in obj) {
					var listObj = obj[index];
					var adType = listObj.ad_type;
					var modelno = listObj.model_number;
					var adId = listObj.adid;
					
					// 초기화 
					boolAD = false;
					
					// A타입
					if(adType == "A") {
						if(adHashMap !== undefined && adHashMap.get(modelno) !== undefined) {
							adHtml += adHashMap.get(modelno);
							
							// 슈퍼탑 컨텐츠 정보가 있는 경우 해당 정보를 가져온다.
							if(listObj.super.length>0 && viewType==1 ) {
								adContentAMap.set(modelno, getSuperTopContent(listObj, "A"));
								adSuperTopAMap.set(modelno, listObj.super);
							}
							drawCnt++;
							drawACnt++;
							boolAD = true;
							adEventAMap.set(modelno, listObj);
						}
						
					// B타입
					} else if(adType == "B") {
						adHtml += drawSuperTopB(listObj);
						// 슈퍼탑 컨텐츠 정보가 있는 경우 해당 정보를 가져온다.
						if(listObj.super.length>0 && viewType==1 ) {
							adContentBMap.set(adId, getSuperTopContent(listObj, "B"));
							adSuperTopBMap.set(adId, listObj.super);
						}
						drawCnt++;
						boolAD = true;
					}
					// 2020.08.03 #41050 [슈퍼탑] IMP 집계방식 변경 및 관련 로직 수정
					// dty pc 1 mobile 2 
					if(boolAD) {
						if(listObj.imp_url) {
							impCall(listObj.imp_url);
						}
					}
					
					// 임시
					if(drawCnt==drawLimit) {
						break;
					}
				}
				
				if(viewType==1){
					adHtml += "	</ul>";
					adHtml += "</li>";
				}
			}
			
			if(objLight.length > 0) {
				
				$("ad-supertop--light").remove();
				// #41717 [PC] 슈퍼탑, 슈퍼탑 라이트 LP 변경
				if(viewType == "1"){
					adLightHtml += "<li class=\"ad-supertop--light\">";
					adLightHtml +="	<div class=\"comm_ad_tit\">";
					adLightHtml += "		<em>슈퍼탑 라이트</em>";
					adLightHtml += "		<a href=\"https://seller.enuri.com/sdul/supertop/sdul_supertop_redirect.jsp\" target=\"_blank\" class=\"comm_btn_apply\">신청하기</a>";
					adLightHtml += "	</div>";
					adLightHtml += "	<ul class=\"ad-supertop__list\">";
				}
				
				// A, B 타입 합쳐서 그린다.
				for(var index in objLight) {
					var listObj = objLight[index];
					var adType = listObj.ad_type;
					var modelno = listObj.model_number;
					var adId = listObj.adid;
					
					// 초기화 
					boolAD = false;
					
					// A타입
					if(adType == "A") {
						if(adHashMap !== undefined && adHashMap.get(modelno) !== undefined) {
							adLightHtml += adHashMap.get(modelno);
							
							// 슈퍼탑 컨텐츠 정보가 있는 경우 해당 정보를 가져온다.
							if(listObj.super.length>0 && viewType==1 ) {
								adContentAMap.set(modelno, getSuperTopContent(listObj, "A"));
								adSuperTopAMap.set(modelno, listObj.super);
							}
							drawCnt++;
							drawACnt++;
							boolAD = true;
							adEventAMap.set(modelno, listObj);
						}
						
					// B타입
					} else if(adType == "B") {
						adLightHtml += drawSuperTopB(listObj);
						// 슈퍼탑 컨텐츠 정보가 있는 경우 해당 정보를 가져온다.
						if(listObj.super.length>0 && viewType==1 ) {
							adContentBMap.set(adId, getSuperTopContent(listObj, "B"));
							adSuperTopBMap.set(adId, listObj.super);
						}
						drawCnt++;
						boolAD = true;
					}
					// 2020.08.03 #41050 [슈퍼탑] IMP 집계방식 변경 및 관련 로직 수정
					// dty pc 1 mobile 2 
					if(boolAD) {
						if(listObj.imp_url) {
							impCall(listObj.imp_url);
						}
					}
					
					// 임시
					if(drawCnt==drawLimit) {
						break;
					}
				}
				
				if(viewType==1){
					adLightHtml += "	</ul>";
					adLightHtml += "</li>";
				}
			}
			
			if(adHtml.length>0) {
				$(".goods-list .goods-bundle").prepend(adHtml);
			}
			
			if(adLightHtml.length>0) {
				$("li[data-type=adline]").after(adLightHtml);
			}
			
			if(adHtml.length>0 || adLightHtml.length>0) {
				$("li.ad img.lazy").lazyload();
				$(".prodItem.ad").show();
				
				// 리스트뷰 슈퍼탑,상품리스트 중복 이슈 
				if(viewType==1) {
					$(".ad-supertop__list li.prodItem.ad").each(function(index, item) {
						$(this).find(".option__row").each(function(sub_index, sub_item) {
							$(this).find(".opt--chk input:checkbox").attr("id", $(this).find(".opt--chk input:checkbox").attr("id")+"_ad");
							$(this).find(".opt--chk label").attr("for", $(this).find(".opt--chk label").attr("for")+"_ad");
						});
					});
				}
			}
			
			// B타입은 리스팅에 영향이 없기때문에 A타입 카운트로 체크하여 리스트 이벤트 제어 처리
			if(drawACnt>0){
				setSuperTopA(adHashMap);
			}
			
			// 슈퍼탑 컨텐츠(A타입)를 추가한다.
			if(adContentAMap.size()>0) {
				for(var modelno in adContentAMap.map) {
					$(".ad-supertop li[data-model-origin="+modelno+"]").find(".item__info").append(adContentAMap.map[modelno]);
				}
				$(".prodItem.ad .prod_ad .ad_type").click(function(){
					var vThis = $(this);
					var vIdx = vThis.attr("idx");
					var vModelno = vThis.closest(".prodItem").attr("id").replace("modelno_", "");
					var click_url = adSuperTopAMap.map[vModelno][vIdx]["click_url"];
					var pc_url =  adSuperTopAMap.map[vModelno][vIdx]["pc_url"];
					infoadLogExe(click_url);
					window.open(pc_url);
				});
			}
			
			// 슈퍼탑 컨텐츠(B타입)를 추가한다.
			if(adContentBMap.size()>0) {
				for(var adid in adContentBMap.map) {
					$(".ad-supertop__list li[data-id=spon_b_"+adid+"]").find(".item__info").append(adContentBMap.map[adid]);
				}
			}
			
			$("li.ad").removeClass("hide");
			
			// 갤러리뷰 상품 메우기 로직
			if(highRankData.length>0) {
				var prodLength = $("li.prodItem").length;
				var useCount = 0;
				if(prodLength>4) {
					useCount = 4 - ($("li.prodItem").length%4);
				}
				if(useCount==4) {
					useCount = 0;
				}
				
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
						$(this).find(".tag--rank").remove();
					}
				});
				$("li.prodItem.highrank").removeClass("highrank");
				
				// 이미지 보여주기
				$("li.fill img.lazy").lazyload({
					placeholder : noImageStr
				});
			}
			
			// LP 중단 배너 ( T5 )
			if (listType == "list") {
				loadLPCenterBanner(param_cate.substring(0, 4));
				// 파워클릭 -> 애드쇼핑 -> 애드오피스
				getPowerClick(param_cate, blADPowerClick, blADShopping, blADOffice);
			} else if (listType == "search" && (firstGoodsCate !== undefined && firstGoodsCate.length > 0)) {
				// 파워클릭 -> 애드쇼핑 -> 애드오피스
				getPowerClick(firstGoodsCate, blADPowerClick, blADShopping, blADOffice);
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
	});
}

function setSuperTopA(adHashMap) {
	for (var modelno in adHashMap.map) {
		if(adEventAMap.containsKey(modelno)) {
			var listObj = adEventAMap.get(modelno);
		
			var modelnm = listObj["model_name"];
			var advertiser = listObj["advertiser"]; // 용도가?
			var copy_phrase_yn = listObj["copytext"];
	
			var recd_link = listObj["recommend"];
			var event_link = listObj["event"];
			var ad_subcate = listObj["ad_subcate"];
			var infoAdKnowBoxListObj = listObj["infoAdKnowBoxList"];
			
			var click_image = listObj["click_image"];
			var click_title = listObj["click_title"];
			var click_subs = listObj["click_subs"];
			
			var saveModelno = modelno;
		}
		var modelnoObj = $("#modelno_"+modelno);
		
		if(modelnoObj.length>0) {
		
			modelnoObj.find(".detailMultiLink").click(function() {
				infoadLogExe(click_title);
			});
			
			//if(copy_phrase_yn=="Y") modelnoObj.find(".copy_phrase").show();
			// copytext에 데이터가 있을 경우 현재 모델의 카피문구를 보여줌
			if(copy_phrase_yn && copy_phrase_yn.length>0) modelnoObj.find(".copy_phrase").show();
			if(recd_link && recd_link.length>0) {
				modelnoObj.find(".recd_link").show();
				modelnoObj.find(".recd_link").click(function() {
					goLocatonNewWindow(recd_link);
				});
			}
			
			if(event_link && event_link.length>0) {
				modelnoObj.find(".event_link").show();
				modelnoObj.find(".event_link").click(function() {
					goLocatonNewWindow(event_link);
				});
			}
		
		} else {
			modelnoObj = $("#modelnoGroup_"+modelno).parents(".prodItem")
			if(modelnoObj.attr("id")) {
				var modelnoTmp = modelnoObj.attr("id");

				saveModelno = modelnoTmp.split("_")[0];
			}
		}
	}
	
}

// 슈퍼탑 컨텐츠정보 가져오기
function getSuperTopContent(listObj, listType) {
	
	var superTopContent = "";
	var superTopContentHtml = "";
	var superTopHtml = "";
	$.each(listObj["super"], function(index,listData){
		
		//if(index>1) return false;
		var title = listData["title"];
		var sub1 = listData["sub1"];
		var sub2 = listData["sub2"];
		var type = listData["type"];
		var thumb_url = listData["thumb_url"];
		var pc_url = listData["pc_url"];
		var mb_url = listData["mb_url"];
		var click_url = listData["click_url"];
		var superContentClass = "";
		if(type=="1"){ // 동영상 광고
			superContentClass = "prodad__box--mov";
		}else if(type=="2"){ // 일반형 광고
			superContentClass = "prodad__box--com";
		}else if(type=="3"){ // 배너형 광고
			superContentClass = "prodad__box--bnr";
		}
				
		if(type=="1" || type=="2"){
			superTopContent +="<div class=\"prodad__box "+superContentClass+"\" idx=\""+index+"\" >";
			superTopContent +="	<a href=\""+pc_url+"\" class=\"prodad__link\" target=\"_blank\">";
			superTopContent +="		<span class=\"prodad__thumb\">";
			superTopContent +="			<img src=\""+thumb_url+"\" alt=\"슈퍼탑 컨텐츠\">";
			superTopContent +="		</span>";
			superTopContent +="		<span class=\"prodad__tx\">";
			superTopContent +="			<span class=\"tx_tit\">"+title+"</span>";
			superTopContent +="			<span class=\"tx_sub\">"+sub1+"</span>";
			superTopContent +="		</span>";
			superTopContent +="	</a>";
			superTopContent +="</div>";
		}else if(type=="3"){
			superTopContent +="<div class=\"prodad__box "+superContentClass+"\" idx=\""+index+"\" >";
			superTopContent +="	<a href=\""+pc_url+"\" target=\"_blank\">";
			superTopContent +="		<img src=\""+thumb_url+"\" alt=\"슈퍼탑 컨텐츠\">";
			superTopContent +="	</a>";
			superTopContent +="</div>";
		}
	});
	
	if(superTopContent.length > 0){
		//						<!-- [슈퍼탑] 배너 -->
		superTopContentHtml += "<div class=\"item__supertop-ad\">";
		superTopContentHtml += superTopContent;
		superTopContentHtml += "</div>";
	}
	if(superTopContentHtml.length > 0){
		superTopHtml = superTopContentHtml;
	}
	
	return superTopHtml;
}

// 슈퍼탑 B타입 그리기
function drawSuperTopB(listObj) {
	
	var adid = listObj["adid"];
	var model_name = listObj["model_name"];
	var copytext = listObj["copytext"];
	var price = listObj["price"];
	var ad_pc_url = listObj["ad_pc_url"];
	var ad_mobile_url = listObj["ad_mobile_url"];
	var explication = listObj["explication"];
	var splitExp = explication.split(" | ");
	var imgurl = listObj["imgurl"];
	var varHtmlImgUrl = "<img src=\"" + imgurl + "\" onerror=\"this.src='http://img.enuri.info/images/home/thum_none.jpg'\" alt=\"" + model_name + "\">";
	
	var advertiser = listObj["advertiser"];
	var event = listObj["event"];
	var event_comment = listObj["event_comment"];
	
	var click_image = listObj["click_image"];
	var click_title = listObj["click_title"];
	var click_subs = listObj["click_subs"];
	
	var adHtml = "";
	
	if (model_name != "" && price != "" && ad_pc_url != "" && imgurl != "") {		// 해당 data가 없을 경우는 html 노출 하지 않는다. 
	
		adHtml +="<li class=\"prodItem ad\" data-type=\"supertop-b\" data-id=\"spon_b_"+adid+"\">";
		adHtml +="	<div class=\"goods-item\">";
		//				<!-- 썸네일 -->
		adHtml +="		<div class=\"item__thumb\">";
		adHtml +="			<a href=\""+ad_pc_url+"\" target=\"_blank\">"+varHtmlImgUrl+"</a>";
		adHtml +="		</div>";
		//				<!-- // --> 
		adHtml +="		<div class=\"item__box\">";
		
		if(viewType==1) {
		
			//				<!-- 상품정보 -->
			adHtml +="		<div class=\"item__info\">";
			
			//					<!-- 모델명 -->
			adHtml +="			<div class=\"item__model\">";
			adHtml +="				<span class=\"tag--ad\">AD</span>";
			adHtml +="				<a href=\""+ad_pc_url+"\" target=\"_blank\">"+model_name+"</a>";
			adHtml +="			</div>";
			//					<!-- 카피문구 -->
			if(copytext.trim().length>0) {
				adHtml +="		<div class=\"item__tx--copy\">"+copytext+"</div>";
			}
			//					<!-- 속성/용어사전 -->
			if(splitExp.length>0) {
				adHtml +="		<ul class=\"item__attr\">";
				$(splitExp).each(function(index, item) {
					adHtml +="		<li>"+item+"</li>";
				});
				adHtml +="		</ul>";
			} else if(explication.length>0){
				adHtml +="		<ul class=\"item__attr\">";
				adHtml +="			<li>"+explication+"</li>";
				adHtml +="		</ul>";
			}
			
			adHtml +="		</div>";
		
			//				<!-- 상품가격 -->
			adHtml +="		<div class=\"item__price\">";
			adHtml +="			<div class=\"tx--confirm\"><i class=\"ico-info lp__sprite\"></i> 쇼핑몰에서 가격을 확인하세요</div>";
			adHtml +="			<div class=\"price__mall\">";
			//						<!-- 가격 -->
			adHtml +="				<div class=\"col--price\">";
			adHtml +="					<a href=\""+ad_pc_url+"\" target=\"_blank\"><em>"+price+"</em>원</a>";
			adHtml +="				</div>";
			adHtml +="			</div>";
			adHtml +="		</div>";
			adHtml +="	</div>";

		} else if(viewType==2) {
			
			//				<!-- 상품가격 -->
			adHtml +="		<div class=\"item__price\">";
			adHtml +="			<div class=\"price__mall\">";
			//						<!-- 가격 -->
			adHtml +="				<div class=\"col--price\">";
			adHtml +="					<a href=\""+ad_pc_url+"\" class=\"tx--price\" target=\"_blank\"><em>"+price+"</em>원</a>";
			adHtml +="				</div>";
			adHtml +="			</div>";
			adHtml +="		</div>";

			//				<!-- 상품정보 -->
			adHtml +="		<div class=\"item__info\">";
			//					<!-- 모델명 -->
			adHtml +="			<div class=\"item__model type--general\">";
			adHtml +="				<span class=\"tag--ad\">AD</span>";
			adHtml +="				<a href=\""+ad_pc_url+"\" target=\"_blank\">"+model_name+"</a>";
			adHtml +="			</div>";
			//					<!-- // -->
			adHtml +="		</div>";
			adHtml +="	</div>";

			adHtml +="	<div class=\"item__foot\">";
			adHtml +="		<a href=\""+ad_pc_url+"\" class=\"tx--supertop\" target=\"_blank\">";
			adHtml +="			<i class=\"ico-info lp__sprite\"></i> 쇼핑몰에서 가격을 확인하세요";
			adHtml +="		</a>";
			adHtml +="	</div>";
		}
		
		
		adHtml +="	</div>";
		adHtml +="</li>";
	}
	return adHtml;
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