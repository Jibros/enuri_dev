(function($) {
	var totalModelCnt = 0;
	var checkModelCnt = 0;
	
	$(document).ready(function() {
		// Test 용 : 퍼블과 영역 분리 위한 테스트
		// $("#test_contets").load("/pub_test/web/home/compare_product.html");
		getHtmlTagAppend();
		if (varTabNo == 2) {
			setTimeout("blockHeightSet(2)", 4000);
		} else if (varTabNo == 3) {
			setTimeout("blockHeightSet(3)", 4000);
		} else {
			setTimeout("blockHeightSet()", 1000);
		}
	});

	/* Html에서 li Tag만 clone 함.  */
	function getHtmlTagAppend() {
		var strArray = chkNo.split(","); 
		
		totalModelCnt = strArray.length;
			
		for (var i=0; i<strArray.length; i++) {
			var varModelno = strArray[i];
	
			if (varModelno > 0) {
				var cloneObj = $("#cpm_unit_1").clone()
									.appendTo($("#block_ul_id"))
									.attr("id", "cpm_unit_"+ varModelno).end();
					
				settingId(varModelno);		// HTML 핸들링 할 요소 ID 셋팅 
			}
		}
		
		// 인포애드 광고상품
		var adModelNo = adNo;
		if (adModelNo > 0) {
			adModelNo = "AD"+adModelNo;
			
			var cloneObj = $("#cpm_unit_1").clone()
								.appendTo($("#block_ul_id"))
								.attr("id", "cpm_unit_"+ adModelNo).end();
			settingId(adModelNo);		// HTML 핸들링 할 요소 ID 셋팅 
			totalModelCnt++;
		}
		
	}

	/* 1. HTML 핸들링 할 요소 ID 셋팅  */
	function settingId(modelno) {
		var originModelno = modelno.replace("AD", ""); // 모델번호 원본
		
		var idObj = $("#cpm_unit_"+modelno);													// li id
		idObj
		.find(".inner_box").attr("id", "product_info_"+ modelno).end()							// 상품정보 div
		.find(".mallList_wrap").attr("id", "mallList_warp_"+ modelno).end()						// 비교 상품 목록 div
		.find("div[id='comtab1_1']").attr("id", "comtab1_1_"+ modelno).end()					// 첫번째 탭 : 판매가 /배송비포함순/ 카드할인가순
		.find("div[id='comtab1_2']").attr("id", "comtab1_2_"+ modelno).end()					// 상품 설명 탭
		.find("div[id='comtab1_3']").attr("id", "comtab1_3_"+ modelno).end()					// 상품평 탭
		.find("em[id='tab01_cnt']").attr("id", "tab01_cnt_"+ modelno).end()					// 가격비교 탭 카운트 
		.find("em[id='tab03_cnt']").attr("id", "tab03_cnt_"+ modelno).end()					// 가격비교 탭 카운트 
		.find("div[id='shopingmall_all_view']").attr("id", "shopingmall_all_view_"+ modelno).end();	
		 
		// 상품정보 DomID 셋팅
		var varProductInfoId = $("#product_info_"+ modelno);
		varProductInfoId
		.find(".thumb").attr("id", "thumb_img_"+ modelno).end();
		
		// 기능별 Tab
		var varMallListWarpId = $("#mallList_warp_"+ modelno);
		varMallListWarpId
		.find("li[id='select_tbl_1']").attr("id", "select_tbl_1_"+ modelno).attr("modelno", originModelno).end()				// 가격비교 탭
		.find("li[id='select_tbl_2']").attr("id", "select_tbl_2_"+ modelno).attr("modelno", originModelno).end()				// 상품설명 탭
		.find("li[id='select_tbl_3']").attr("id", "select_tbl_3_"+ modelno).attr("modelno", originModelno).end();				// 상품평 탭
		
		//첫번째 탭 하위 Dom ID 셋팅
		var varComtab1_1 =  $("#comtab1_1_"+modelno);
		varComtab1_1
		.find(".box_malllist").attr("id", "comtab_1_box_malllist_"+ modelno).end()				// 가격비교 상품 및 유사 상품 상위 div
		.find(".compare_pack").attr("id", "compare_product_"+ modelno).end()				// 가격 비교 상품 div
		.find(".similar_pack").attr("id", "similar_product_"+ modelno).end()						// 유사상품
		.find(".nodata_pack").attr("id", "nodata_product_"+ modelno).end()					// 출시예정&일시품절
		.find("li[id='o_basic']").attr("id", "o_basic_"+ modelno).end()							// 판매가순 정렬
		.find("li[id='o_delivery']").attr("id", "o_delivery_"+ modelno).end()						// 배송비포함순 정렬
		.find("li[id='o_card']").attr("id", "o_card_"+ modelno).end()								// 카드가순 정렬
		.find("div[id='lefttitle']").attr("id", "lefttitle_"+ modelno).end()
		.find("div[id='righttitle']").attr("id", "righttitle_"+ modelno).end()
		.find(".cashmallprlist_zone").attr("id","mini_cashpricelist_area_"+modelno).end();//  현금몰 div
		
		//두번째 탭 하위 Dom ID 셋팅
		var varComtab1_2 =  $("#comtab1_2_"+modelno);
		varComtab1_2
		.find("div[id='mini_caution']").attr("id", "caution_txt_"+ modelno).end()
		.find(".none_detail").attr("id", "none_detail_"+ modelno).end()							// 상품 설명 없을 경우 <!-- 상품설명 없을 때 class="not_attbu" 추가 -->
		.find("table[id='spec_table']").attr("id", "spec_table_"+ modelno).end()
		.find("tbody[id='spec_tbody']").attr("id", "spec_tbody_"+ modelno).end()
		.find("div[id='book_spec']").attr("id", "spec_tbody_"+ modelno).end()
		.find("div[id='cosmetics']").attr("id", "cosmetics_"+ modelno).end();
		
		//세번째 탭 하위 Dom ID 셋팅
		var varComtab1_3 =  $("#comtab1_3_"+modelno);
		varComtab1_3
	//	.find(".graphBox").attr("id", "goodsBbsChart_"+ modelno).end()						// 그래프	
		.find(".userRating").attr("id", "review_status2_"+ modelno).end()						// 별점 영역
		.find(".novalue").attr("id", "goodsBbsNoChart_"+ modelno).end()						// 사용자 별 평점 없음.
		.find("div[id='goodsBbsChart']").attr("id", "goodsBbsChart_"+ modelno).end()		// 
		.find(".review_list").attr("id", "review_list_"+ modelno).end()								// 상품평목록
		.find(".no_comment").attr("id", "no_review_"+ modelno).end()							// 상품평목록 없음.
		.find(".btn_pack").attr("id", "bbs_more_btn_"+ modelno).end();								// 더 많은 상품평 보기
		
		//현금몰 하위 dom ID 셋팅
		var mini_listType = 1; 					//판매가 순 : 1, 배송비포함순 : 2, 카드할인가순 : 3
		var mini_deliveryFlag = false; 		//배송비포함
	
		loadCompareVip(modelno, mini_listType);		// 1. 상품 정보 가져 온 후 HTML Making
		// 탭별 클릭 이벤트 설정
		$("#select_tbl_1_" + modelno).unbind();
		$("#select_tbl_1_" + modelno).click(function(e) {
			e.preventDefault();
			
			$(".select_tbl_1").show();
			$(".select_tbl_2").hide();
			$(".select_tbl_3").hide();
			
			$(".select_tab_1").addClass("on");
			$(".select_tab_2").removeClass("on");
			$(".select_tab_3").removeClass("on");
			
			blockHeightSet(1);
			
			return false;
		});
		
		$("#select_tbl_2_" + modelno).unbind();
		$("#select_tbl_2_" + modelno).click(function(e) {
			e.preventDefault();

			$(".select_tbl_1").hide();
			$(".select_tbl_2").show();
			$(".select_tbl_3").hide();
			
			$(".select_tab_1").removeClass("on");
			$(".select_tab_2").addClass("on");
			$(".select_tab_3").removeClass("on");
			
			blockHeightSet(2);
			
			return false;
		});
		
		$("#select_tbl_3_" + modelno).unbind();
		$("#select_tbl_3_" + modelno).click(function(e) {
			e.preventDefault();
			
			$(".select_tbl_1").hide();
			$(".select_tbl_2").hide();
			$(".select_tbl_3").show();
			
			$(".select_tab_1").removeClass("on");
			$(".select_tab_2").removeClass("on");
			$(".select_tab_3").addClass("on");
			
			blockHeightSet(3);
			return false;
		});
		
		// 인포애드 광고 태깅 노출
		if(originModelno!=modelno) {
			$("#cpm_unit_"+ modelno).prepend("<span class=\"ico_ad\">AD</span>");
		}
	}
	
	/************************************************************
 		1. 상품 정보 가져 온 후 HTML Making
	 ************************************************************/
	function loadCompareVip(modelno, mini_listType) {
		var originModelno = modelno.replace("AD", ""); // 모델번호 원본
		var objProductInfo = $("#product_info_" + modelno);
				
		var param = {
			"modelno" : originModelno
		}
				
		$.ajax({
			type : "get",
			url : "/lsv2016/ajax/detail/getGoodsData_ajax.jsp",
			async: true,
			data : param,
			dataType : "json",
			success: function(json) {
				var mini_szModelNm = json["mini_szModelNm"];
				var mini_strCondiname = json["mini_strCondiname"];
				var mini_strImageUrl = json["mini_strImageUrl"];
				var mini_intRealMinPrice = parseInt(json["mini_intRealMinPrice"]);
				var mini_mMinPrice3 = parseInt(json["mini_mMinPrice3"]);
				var min_szBidchk = json["mini_szBidchk"];
				var mini_Constrain = json["mini_strConstrain"];
				var mini_Rental = json["mini_strSrv"];
				var mini_szCategory4 = json["mini_szCategory4"];
				var mini_szCategory = json["mini_szCategory"];
				var mini_nMallCnt3 = json["mini_nMallCnt3"];
				var mini_dDate = json["mini_dDate"];
				var mini_cur_date = json["mini_cur_date"];
				var mini_nMallCnt = json["mini_nMallCnt"];
				var mini_factory = json["mini_szFactory"];
				var mini_brand = json["mini_szBrand"];
				var mini_spec = json["mini_szSpec"];
				//현금몰, tlc 로직 추가 (2019.12.13)
				var mini_mCashMinPrice = json["mini_mCashMinPrice"];
				var mini_mCashMinYn = json["mini_mCashMinYn"];
				var mini_mOvsMinYn = json["mini_mOvsMinYn"];
				var mini_mTlcMinPrice = json["mini_mTlcMinPrice"];
				
				if(!isNaN(mini_dDate) && (parseInt(mini_dDate) > parseInt(mini_cur_date))) mini_nMallCnt = 0;
				
				$("#tab01_cnt_" + modelno).html("("+numComma(mini_nMallCnt)+")");
				$("#thumb_img_" + modelno).find(".imgs").attr("src", mini_strImageUrl);
				
				objProductInfo.find('.proname').html(mini_szModelNm);
				objProductInfo.find('.subcon').html(mini_strCondiname);
				
				var priceHtml = "";
			    if (!isNaN(mini_dDate) && (parseInt(mini_dDate) > parseInt(mini_cur_date))) {
			    	priceHtml += "<span class=\"low\">가격미정</span>";
			    	objProductInfo.find('.lowprice').html(priceHtml);
			    } else if(parseInt(mini_nMallCnt) <= 0 && parseInt(mini_nMallCnt3) <=0) { 
			    	priceHtml += "일시품절";
			    	objProductInfo.find('.lowprice').html(priceHtml);
			    } else {
			    	if(parseInt(mini_mMinPrice3) == 0 && parseInt(mini_nMallCnt) > 0 && typeof mini_mCashMinYn != undefined && mini_mCashMinYn != null && mini_mCashMinYn == "Y" && typeof mini_mCashMinPrice != undefined && mini_mCashMinPrice != null) {
			    		priceHtml += "<span class=\"cash_price\"><em>현금</em></span><a href=\"javascript:///\"><span class=\"low\">최저가</span><span class=\"pr\"><strong>"+numComma(mini_mCashMinPrice)+"</strong>원</span></a>";
			    	} else if(typeof mini_mTlcMinPrice != undefined && mini_mTlcMinPrice != null && mini_mTlcMinPrice != "0" && mini_mMinPrice3 == "0") {
			    		priceHtml += "<a href=\"javascript:///\"><span class=\"low\">TLC카드가</span><span class=\"pr\"><strong>"+numComma(mini_mTlcMinPrice)+"</strong>원</span></a>";
			    	} else {	
			    		if(mini_intRealMinPrice>mini_mMinPrice3) priceHtml += "<span class=\"mobileSendLayer icon mobile\" type=\"1\"><em>모바일</em></span>";
			    		if(mini_Rental=="rental") priceHtml += "<a href=\"javascript:///\"><span class=\"low\">렌탈(월)</span><span class=\"pr\"><strong>"+numComma(mini_mMinPrice3)+"</strong>원</span></a>";
			    		else priceHtml += "<a href=\"javascript:///\"><span class=\"low\">최저가</span><span class=\"pr\"><strong>"+numComma(mini_mMinPrice3)+"</strong>원</span></a>";
			    		
			    	}
					objProductInfo.find('.lowprice').html(priceHtml);
			    }
			    
			    if (mini_Constrain == "5") {
			    	objProductInfo.find(".btn_pack").show();
			    }
			   
			    loadPriceList(modelno, mini_listType, mini_Constrain, mini_dDate, mini_cur_date, mini_nMallCnt, mini_nMallCnt3);		// 가격 정보
			    loadComponent(modelno,mini_szCategory4);
			    getMiniGoods_caution(mini_szCategory, modelno, mini_szModelNm, mini_factory, mini_brand); 							// 주의 사항
			    getMiniSpec(modelno, mini_szCategory, mini_szModelNm, mini_spec, mini_strImageUrl); 									// 요약 설명
			    getMiniBbs(modelno);																														// 상품평
				loadCashList(modelno, mini_listType);
			    objProductInfo.find('img').unbind();
			    objProductInfo.find('img').click(function() {
			    	goModelnoNew(modelno);
			    });
			    
			    objProductInfo.find('.proname').unbind();
			    objProductInfo.find('.proname').click(function() {
			    	goModelnoNew(modelno);
			    });
			    
			    objProductInfo.find('.subcon').unbind();
			    objProductInfo.find('.subcon').click(function() {
			    	goModelnoNew(modelno);
			    });
			    
			    objProductInfo.find('.lowprice a').unbind();
			    objProductInfo.find('.lowprice a').click(function() {
			    	goModelnoNew(modelno);
			    });
				
			    $("#cpm_unit_"+modelno).find(".del_unit")
				$("#cpm_unit_"+modelno).find(".del_unit").click(function() {
					$("#cpm_unit_"+modelno).remove();
					isShowHideDelBtn();
			    });
			    
				var basicObj = $("#o_basic_" + modelno);
				var deliveryObj = $("#o_delivery_" + modelno);
				var cardObj = $("#o_card_" + modelno);
			    var isDeliveryClick = false;		// 배송비 포함 관련 tab 클릭 시 상품 랜더링에 사용하기 위함.
			    
				// 가격 비교 탭 내 정렬순 클릭 이벤트
				basicObj.unbind();
				basicObj.click(function(e) {		// 판매가순
					e.preventDefault();
					loadPriceList(modelno, 1, mini_Constrain, mini_dDate, mini_cur_date, mini_nMallCnt, mini_nMallCnt3, isDeliveryClick);
					loadCashList(modelno, 1);
					basicObj.addClass("on");
					deliveryObj.removeClass("on");
					cardObj.removeClass("on");
					
					return false;
				});
				
				deliveryObj.unbind();
				deliveryObj.click(function(e) {			// 배송비포함순
					e.preventDefault();
					
					isDeliveryClick = true;
					loadPriceList(modelno, 2, mini_Constrain, mini_dDate, mini_cur_date, mini_nMallCnt, mini_nMallCnt3, isDeliveryClick);
					loadCashList(modelno, 2);
					basicObj.removeClass("on");
					deliveryObj.addClass("on");
					cardObj.removeClass("on");
					
					return false;
				});
				
				cardObj.unbind();
				cardObj.click(function(e) {			// 카드가순
					e.preventDefault();
					loadPriceList(modelno, 3, mini_Constrain, mini_dDate, mini_cur_date, mini_nMallCnt, mini_nMallCnt3, isDeliveryClick);
					
					basicObj.removeClass("on");
					deliveryObj.removeClass("on");
					cardObj.addClass("on");
					
					return false;
				});
			}		
		});
		
	}	// END : loadCompareVip(modelno)
	
	var gPhonePriceShow = false; //좌우구분이 일시불/할부구매쇼핑몰인 모델 구분
	var gauthShowFlag = false; //제조사 인증
	var mini_limtShowLine = 29; //더보기 제한갯수
	
	function loadPriceList(modelno, mini_listType, mini_Constrain, mini_dDate, mini_cur_date, mini_nMallCnt, mini_nMallCnt3, isDeliveryClick) {
		var originModelno = modelno.replace("AD", ""); // 모델번호 원본
		var mini_cardeventFlag = false; 		//카드특가
		
		if (mini_listType == 3) {
			mini_cardeventFlag = true; 
		} 

		var param = {
			"modelno" : originModelno,
			"strShopListAll" : "NO",			//YES :더보기
			"listType" : mini_listType,
			"constrain" : mini_Constrain,
			"showLine" : mini_limtShowLine
		}
		$.ajax({
			type : "get",
			url : "/lsv2016/ajax/detail/getPriceList_ajax.jsp",
			async: true,
			data : param,
			dataType : "json",
			success: function(json) {
				//가격비교 개수
				var compareGoodsCnt = json["compareGoodsCnt"];
				var cardButtonShowFlag = false;
				cardButtonShowFlag = json["cardButtonShowFlag"];
				
				cardButtonShowFlag = (cardButtonShowFlag == 'true');
				if(cardButtonShowFlag) {
					$('#o_card_'+modelno).show();
				} else {
					$('#o_card_'+modelno).hide();
				}
				
				if (mini_Constrain == "5") { 			//유사상품
					$('#mini_goodsInfo').find('.proinfo ').addClass("siminfo");
					var priceListObj = json["left_priceList"];
					
					//최저가
					mini_totalminprice = parseInt(json["left_totalMinPrice"]);
												
					var left_msg = json["left_msg"];

					// 유사 상품 HTML Rendering
					loadsimilarGoodsListView(priceListObj, 'left', left_msg, modelno, mini_cardeventFlag, isDeliveryClick);
					
					/************************************************************
					 	상품 Show, hide 영역
					 ************************************************************/
					// 속도 개선을 위해 모두 객체 선언 (2번 이상 호출되는 ID에 한함)
					var shopingMallAllViewObj = $("#shopingmall_all_view_" + modelno);
					
					// 가격비교 탭의 모든 소핑몰 가격비교 보기 버튼 체크
					if (compareGoodsCnt > 29) {
						shopingMallAllViewObj.show();
					} else {
						shopingMallAllViewObj.hide();
					}	
					
					$("#compare_product_"+modelno).hide();
					
					$("#comtab_1_box_malllist_"+modelno).show();
					$("#comtab1_1_"+modelno).show();
					$("#mallList_warp_"+modelno).show();
					
					$("#comtab1_2_"+modelno).hide();
					$("#comtab1_3_"+modelno).hide();
				} else if (!isNaN(mini_dDate) && (parseInt(mini_dDate) > parseInt(mini_cur_date))) {				// 가격미정
					var NoPriceHmtl = "";
					NoPriceHmtl += "<span class=\"stripe nomark\"></span>";
					NoPriceHmtl += "<p class=\"txt txt1\">출시예정</p>";
					NoPriceHmtl += "<p class=\"txt txt2\">출시예정 상품으로 아직<br>판매중인 쇼핑몰이 없습니다.</p>";
					$("#nodata_product_"+ modelno).html(NoPriceHmtl);
					
					$("#compare_product_"+ modelno).hide();		// 가격비교 상품
					$("#similar_product_"+ modelno).hide();			// 유사상품
					$("#comtab1_1_"+ modelno).find(".option_sel").hide();		// 가격비교 내 탭	
					
					$("#nodata_product_"+ modelno).show();	
					$("#comtab_1_box_malllist_"+ modelno).show();	
					$("#comtab1_1_"+ modelno).show();	
					$("#mallList_warp_"+ modelno).show();	
					
				} else if(parseInt(mini_nMallCnt) <= 0 && parseInt(mini_nMallCnt3) <=0) { 	// 일시품절
					var NoPriceHmtl = "";
					NoPriceHmtl += "<span class=\"stripe nomark\"></span>";
					NoPriceHmtl += "<p class=\"txt txt1\">일시품절</p>";
					NoPriceHmtl += "<p class=\"txt txt2\">일시품절 또는 단종되어<br>판매중인 쇼핑몰이 없습니다.</p>";
					$("#nodata_product_"+ modelno).html(NoPriceHmtl);
					
					$("#compare_product_"+ modelno).hide();		// 가격비교 상품
					$("#similar_product_"+ modelno).hide();			// 유사상품
					$("#comtab1_1_"+ modelno).find(".option_sel").hide();		// 가격비교 내 탭	
					
					$("#nodata_product_"+ modelno).show();	
					$("#comtab_1_box_malllist_"+ modelno).show();	
					$("#comtab1_1_"+ modelno).show();	
					$("#mallList_warp_"+ modelno).show();	

				} else {
					
					var left_priceListObj = json["left_priceList"];
					var right_priceListObj = json["right_priceList"];
					
					//가격비교 개수
					leftCnt = parseInt(json["left_cnt"]);
					rightCnt = parseInt(json["right_cnt"]);

					//최저가
					mini_totalminprice = parseInt(json["left_totalMinPrice"]);
					var right_totalMinPrice = parseInt(json["right_totalMinPrice"]);
					if(mini_totalminprice <= 0 ) mini_totalminprice = right_totalMinPrice;
					else if(right_totalMinPrice < mini_totalminprice && right_totalMinPrice>0) mini_totalminprice = right_totalMinPrice;
					
					/****************************************************************************
					 	상품비교 Left, Right Title 
					 ****************************************************************************/
					var lefttitleObj = $("#lefttitle_"+modelno);
					var righttitleObj = $("#righttitle_"+modelno);
					
					var left_title = "";
					var right_title = "";
					var mini_SelectedShop = "";
					
					if(typeof(json["left_title"]) != 'undefined'){
						left_title = json["left_title"].replace("인증 공식판매자","공식판매");
						
						if(left_title.indexOf("<a") > -1) {
							left_title = left_title.substring(0, left_title.indexOf("<a"));
						}
					}
					if(typeof(json["right_title"]) != 'undefined'){
						right_title = json["right_title"];
						
						if(right_title.indexOf("<a") > -1) {
							right_title = right_title.substring(0, right_title.indexOf("<a"));
						} 
					}
					
					var left_authImg = "";
					var right_authImg = "";
					if(typeof(json["left_authImg"])!='undefined') left_authImg = json["left_authImg"].replace(".gif","_toolbar.gif");
					if(typeof(json["right_authImg"])!='undefined') right_authImg = json["right_authImg"];
					var left_msg = json["left_msg"];
					var right_msg = json["right_msg"];
					
					//제조사 인증
					gauthShowFlag = json["authShowFlag"];
					if(left_authImg !="" && mini_SelectedShop=="") {left_title = left_authImg+left_title};
					if(right_authImg !="") {right_title = right_authImg+right_title};
				
					lefttitleObj.html(left_title);
					righttitleObj.html(right_title);
					
					$("#similar_product_"+ modelno).hide();			// 유사상품
					$("#nodata_product_"+ modelno).hide();			// 출시예정&일시품절
					$("#compare_product_"+ modelno).show();		// 가격비교 상품

					if (leftCnt > 0 || rightCnt > 0) {
						$("#similar_product_"+ modelno).hide();			// 유사상품
						$("#nodata_product_"+ modelno).hide();			// 출시예정&일시품절
						$("#compare_product_"+ modelno).show();		// 가격비교 상품
						
						if (modelno.length>0) {
							loadGoodsListView(left_priceListObj, 'left', left_msg, modelno, mini_cardeventFlag, isDeliveryClick);
							loadGoodsListView(right_priceListObj, 'right', right_msg, modelno, mini_cardeventFlag, isDeliveryClick);
						}
					}else{
						//$("#nodata_product_"+ modelno).show();	
						$("#comtab_1_box_malllist_"+ modelno).show();	
						$("#comtab1_1_"+ modelno).show();	
						$("#mallList_warp_"+ modelno).show();
						var leftObj = $("#compare_product_"+modelno+" ._left").find(".proitemlist");
						var rightObj = $("#compare_product_"+modelno+" ._right").find(".proitemlist");
						var html ="";
						html += "<li>";
						html += "	<div class=\"itembox\">";
						html += "		<p class=\"nomall\">해당 쇼핑몰이<br>없습니다.</p>";
						html += "	</div>";
						html += "</li>";
						lefttitleObj.html("오픈마켓");
						righttitleObj.html("일반쇼핑몰");
						leftObj.html(html);
						rightObj.html(html);
					}
				}
				
				// 상품 탭 번호 들어왔을 경우 show / hide 
				if (varTabNo == 2) {
					$("#comtab1_1_"+modelno).hide();
					$("#comtab1_2_"+modelno).show();
					$("#comtab1_3_"+modelno).hide();
					
					$("#select_tbl_1_"+modelno).removeClass("on");
					$("#select_tbl_2_"+modelno).addClass("on");
					$("#select_tbl_3_"+modelno).removeClass("on");
					
				} else if (varTabNo == 3) {
					$("#comtab1_1_"+modelno).hide();
					$("#comtab1_2_"+modelno).hide();
					$("#comtab1_3_"+modelno).show();
					
					$("#select_tbl_1_"+modelno).removeClass("on");
					$("#select_tbl_2_"+modelno).removeClass("on");
					$("#select_tbl_3_"+modelno).addClass("on");
				}
							
				$("#cpm_unit_"+modelno).show();
				//G9이동
				setG9Div();
			},
			error: function (xhr, ajaxOptions, thrownError) {
				//alert(xhr.status);
				//alert(thrownError);
			}
		});
	}
	
	/**************************************************************************
	 *  가격 비교 상품 랜더링
	 **************************************************************************/
	function loadGoodsListView(priceListObj, leftright, nomall_msg, modelno, mini_cardeventFlag, isDeliveryClick ) {
		var sideObj = null;
		var lastcnt = 0;
		if(leftright=='left') {
			sideObj = $("#compare_product_"+modelno+" ._left").find(".proitemlist");
			lastcnt = leftCnt;
		}
		if(leftright=='right'){
			sideObj = $("#compare_product_"+modelno+" ._right").find(".proitemlist");
			lastcnt = rightCnt;
		}

		var html = "";
		sideObj.html(html);
		
		if (priceListObj != "") {
			$.each(priceListObj, function(Index, listData) {
			//	html = "";
				var o_shop_cnt = listData["shop_cnt"];
				var o_shop_code = listData["shop_code"];
				var o_emoneyshop = listData["emoneyshop"];
				var o_shop_name = listData["shop_name"];
				var o_minPrice = listData["minPrice"];
				var o_instance_price = listData["instance_price"];
				var o_minPrice2 = listData["minPrice2"];
				var o_minPrieFlag = listData["minPrieFlag"];
				var o_deliveryInfo = listData["deliveryInfo"];
				var o_deliveryinfo2 = listData["deliveryinfo2"];
				var o_deliverytype2 = listData["deliverytype2"];
				var o_minprice_delivery = listData["minprice_delivery"];
				var strdelivery = "";
				
				if (o_deliverytype2 == 1) {
					mini_deliveryFlag = true;
				}
				
				if(o_deliveryInfo == "조건부무료"){	//쿠팡조건추가 2019-04-03
					strdelivery = o_deliveryInfo;
				}else if(o_minprice_delivery==0) {
					strdelivery = "무료배송";
				}else if($.isNumeric(o_minprice_delivery)) {
					if(isDeliveryClick) {
						strdelivery = "배송비 " + numComma(o_minprice_delivery)+"원 포함";
					} else {
						strdelivery = "배송비 " +numComma(o_minprice_delivery)+"원";
					}
					
				}else {
					strdelivery = o_minprice_delivery;
				}
				var o_eventTxt = listData["eventTxt"];
				var o_telTxt = listData["telTxt"];
				var o_agree_monthTxt = listData["agree_monthTxt"];
				var o_powerFlag = listData["powerFlag"];
				var o_shopBidFlag = listData["shopBidFlag"];
				var o_bidTopClass = listData["bidTopClass"];
				var o_seller_ad = listData["seller_ad"];
				var o_nhCardAdShowFlag = listData["nhCardAdShowFlag"];
				var o_CardEvent = listData["CardEvent"];
				var o_Price_card = listData["Price_card"];
				var o_CardName = listData["CardName"];
				var o_mallLinkUrl = listData["mallLinkUrl"];
				var o_logLinkUrl = listData["logLinkUrl"];
				var o_pl_no = listData["pl_no"];
				var o_goodsCode = listData["goodsCode"];
				var o_goodsName = listData["goodsName"].replace("\"", "&quot;").replace("'","\'");
				var o_Freeinterest = listData["Freeinterest"];
				var o_PlCoupon = listData["PlCoupon"];
				var o_CouponFlag = listData["CouponFlag"];
				var o_CouponUrl = listData["CouponUrl"];
				var o_CouponSale1 = listData["CouponSale1"];
				var o_CouponSale2 = listData["CouponSale2"];
				var o_option_flag = listData["option_flag"];
				var o_deliveryShowFlag = listData["deliveryShowFlag"];
				var o_CouponContents = listData["CouponContents"].replace( /\r\n/g, '<br>');
				var o_CouponURL = listData["CouponURL"];
				var o_OverseaDelivery = listData["OverseaDelivery"];
				var o_phonePriceShowInfo = listData["phonePriceShowInfo"];
				var o_strSystemContents = listData["strSystemContents"].replace( /\r\n/g, '<br>');
				var o_strSystemSdate = listData["strSystemSdate"];
				var o_strSystemEdate = listData["strSystemEdate"];
				var o_bDepartGoods = listData["bDepartGoods"];
				var o_strDepartname = listData["strDepartname"];
				var o_gmarket_g9 = listData["gmarket_g9"];
				
				//프로모션 자동화
				var o_pc_mini_vip_icn_view_dcd = listData["pc_mini_vip_icn_view_dcd"];
				var o_pc_mini_vip_icn_str = listData["pc_mini_vip_icn_str"];
				var o_pc_promtn_url = listData["pc_promtn_url"];
				var vNowtime = new Date().format("yyyyMMddhhmm");
				var cmdGoToUrl = "";
                vNowtime = vNowtime * 1;
                var minCheck = 202011190200;
                var maxCheck = 202011190330;
                if((o_shop_code == "5910") && (vNowtime >= minCheck) && (vNowtime <= maxCheck)){
                    cmdGoToUrl = "insertLog(15062);alert('쇼핑몰 시스템 점검중입니다.');return false;";
                }else{
                    cmdGoToUrl = "insertLog(15062);goPlnoItem(" + o_pl_no + ");";
                }
				var deliveryprice = 0;
				if(!isNaN(o_deliveryInfo)) deliveryprice = o_deliveryInfo;
				var o_talminprice = o_minPrice;
				if(o_minPrice > o_instance_price) {o_talminprice=o_instance_price;}

				var sponcheck = false;
				if(o_bidTopClass>0 || o_shopBidFlag=='true') sponcheck = true;
				
				var mini_logflag = 0;
				if(leftright=='right' && o_bidTopClass>0) mini_logflag = 1;
				if(leftright=='left' && o_bidTopClass>0) mini_logflag = 2;
				
				//상위입찰 적용 노출 로그
				if(o_bidTopClass>0) insertLog(15078);

				var deliveryIscollect = (strdelivery=="배송비유무료" || strdelivery=="착불" || strdelivery=="배송비유료") ? "N":"Y";
				
				var rightLast = false;
				if(leftright=="right" && priceListObj.length==(Index+1) && (leftCnt>4 || rightCnt>4)) rightLast = true;
				
				html +="<li"; if(rightLast){html +=" class=\"last\""}html +=" id=\"item"+(Index+1)+"\">";
				html +="	<div class=\"itembox\">";
				html +="		<p class=\"mallinfo\">";
				html +="			<a class=\"mallname\" href=\"javascript:///\" onclick=\""+cmdGoToUrl+"\">";
				
				if(mini_cardeventFlag && leftright=='right'){
					html +="			<strong class=\"crcard\">"+o_CardName+"</strong>";
				}
				html +="				<strong>"+o_shop_name+"</strong>";
				if(sponcheck){
					html +="				<span class=\"icon sponser\"><em>스폰서</em></span>";
				}
				if(o_powerFlag=='Y'){
					html +="				<span class=\"icon powerseller\"><em>파워셀러</em></span>";
				}
				html +="			</a>";

				// 프로모션 자동화
				if(o_pc_mini_vip_icn_view_dcd == "C"){
					html +="	 	<span class=\"coupon_11st\" strUrl='" + o_pc_promtn_url + "'>중복쿠폰받기</span>";
				} else if(o_pc_mini_vip_icn_view_dcd== "M" && o_pc_mini_vip_icn_str != "" ){
					html +="	 	<span class=\"coupon_11st word\" strUrl='" + o_pc_promtn_url + "'>" + o_pc_mini_vip_icn_str + "</span>";
				}

				//G9이동
				/*if(o_gmarket_g9=="Y"){
					html +="		<span class=\"icon btn_g9move\" style=\"cursor: pointer;\" onclick=\"G9DivShow(this);\"><em>G9이동</em></span>";
				}*/
				html +="		</p>";
				html +="		<p class=\"priceline"; if(parseInt(mini_totalminprice)==o_minPrice){ html+=" pricelow"; } if(o_shopBidFlag=='true') {html += " shopbid";} html +="\">";
				
				if((o_instance_price>0 && o_instance_price < o_minPrice && !isDeliveryClick ) || (isDeliveryClick && o_instance_price>0 && (parseInt(o_instance_price) + parseInt(deliveryprice)) < o_minPrice)){
					html +="<span class=\"mobileSendLayer icon mobile\" type=\"1\"><em>모바일</em></span>";
				}
				if(o_minPrice<=0 && o_instance_price > 0){
					html +="<span class=\"icon mobile3\"><em>모바일</em></span>";
					html +="<span class=\"mobileSendLayer only\" type=\"2\">전용</span>";
				}
				html +="<a href=\"javascript:///\">";
				if(parseInt(mini_totalminprice)==o_minPrice){ html +="<span class=\"prlow\">최저가</span>";}
				if((o_shop_code == "5910") && (vNowtime >= minCheck) && (vNowtime <= maxCheck)){
					html +="<span class=\"pricepack\" onclick=\"alert('쇼핑몰 시스템 점검중입니다.');return false;\">";
				}else{
					html +="<span class=\"pricepack\" onclick=\"goPlnoItem("+o_pl_no+");\">";
				}
				html +="<strong>"+numComma(o_minPrice)+"</strong>";
				if(o_minPrice<100000000)html +="원";html +="</span>";html +="</a></p><!-- 최저가 p class=\"pricelow\" 추가 -->";
				if((o_shop_code == "5910") && (vNowtime >= minCheck) && (vNowtime <= maxCheck)){
					html +="		<p class=\"delivery\"><a href=\"javascript:///\" onclick=\"alert('쇼핑몰 시스템 점검중입니다.');return false;\">"+strdelivery+"</a></p>";
				}else{
					html +="		<p class=\"delivery\"><a href=\"javascript:///\" onclick=\"goPlnoItem("+o_pl_no+")\">"+strdelivery+"</a></p>";
				}
				
				html +="	</div>";
				html +="</li>";

				if (leftCnt>=mini_limtShowLine || rightCnt>=mini_limtShowLine) {
					$("#shopingmall_all_view_" + modelno).unbind();
					$("#shopingmall_all_view_" + modelno).click(function(e) {
						e.preventDefault();
						goModelnoNew(modelno);
					}).show();
					
				}else{
					$("#shopingmall_all_view_" + modelno).hide();
				}
				
			});

			sideObj.html(html);
			
			$("#compare_product_"+modelno).find('.coupon_11st').unbind();
			$("#compare_product_"+modelno).find('.coupon_11st').click(function() {
					//var rend_url = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1001161301";
					var rend_url = $(this).attr("strUrl");
					
					if (rend_url == '') {
						rend_url = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1001161301";
					}
					window.open(rend_url,'','');
				return false;
			});
			
			$("#compare_product_"+modelno).show();
			$("#comtab_1_box_malllist_"+modelno).show();
			$("#comtab1_1_"+modelno).show();
			$("#mallList_warp_"+modelno).show();
						
		} else {
			var noItemObj = $("#nodata_product_"+modelno);
			
			html = "";
			html += "<li>";
			html += "	<div class=\"itembox\">";
			html += "		<p class=\"nomall\">해당 쇼핑몰이<br>없습니다.</p>";
			html += "	</div>";
			html += "	</li>";
				
			sideObj.html(html);
		
		}
		
		checkModelCnt = checkModelCnt + 1;
		if (totalModelCnt == checkModelCnt) {
			resizeWinByUnit();
			//blockHeightSet(1);
			setTimeout("blockHeightSet()", 1000);
		}
		
	}
	
	// 유사 상품 HTML 랜더링
	function loadsimilarGoodsListView(priceListObj, leftright, nomall_msg, modelno, mini_cardeventFlag, isDeliveryClick ){
		var itemlistObj = $("#similar_product_"+modelno);
		var noItemObj = $("#nodata_product_"+modelno);
		
		var html = "";
		itemlistObj.find(".ul_simlist").html(html);
		
		if (priceListObj != "") {
			$.each(priceListObj, function(Index, listData) {
				var o_shop_cnt = listData["shop_cnt"];
				var o_shop_code = listData["shop_code"];
				var o_emoneyshop = listData["emoneyshop"];
				var o_shop_name = listData["shop_name"];
				var o_minPrice = listData["minPrice"];
				var o_instance_price = listData["instance_price"];
				var o_minPrice2 = listData["minPrice2"];
				var o_minPrieFlag = listData["minPrieFlag"];
				var o_deliveryInfo = listData["deliveryInfo"];
				var o_deliveryinfo2 = listData["deliveryinfo2"];
				var o_deliverytype2 = listData["deliverytype2"];
				var o_minprice_delivery = listData["minprice_delivery"];
				var strdelivery = "";
				
				if (o_deliverytype2 == 1) {
					mini_deliveryFlag = true;
				}
				
				if(o_deliveryInfo == "조건부무료"){	//쿠팡조건추가 2019-04-03
					strdelivery = o_deliveryInfo;
				}else if(o_minprice_delivery==0) {
					strdelivery = "무료배송";
				}else {
					strdelivery = "배송비 "+numComma(o_minprice_delivery)+"원"; 
					if(isDeliveryClick) {
						strdelivery+=" 포함";
					}
					
				}
				var o_imgUrl = listData["imgUrl"];
				var o_eventTxt = listData["eventTxt"];
				var o_telTxt = listData["telTxt"];
				var o_agree_monthTxt = listData["agree_monthTxt"];
				var o_powerFlag = listData["powerFlag"];
				var o_shopBidFlag = listData["shopBidFlag"];
				var o_bidTopClass = listData["bidTopClass"];
				var o_seller_ad = listData["seller_ad"];
				var o_CardEvent = listData["CardEvent"];
				var o_Price_card = listData["Price_card"];
				var o_CardName = listData["CardName"];
				var o_mallLinkUrl = listData["mallLinkUrl"];
				var o_logLinkUrl = listData["logLinkUrl"];
				var o_pl_no = listData["pl_no"];
				var o_goodsCode = listData["goodsCode"];
				var o_goodsName = listData["goodsName"];
				var o_Freeinterest = listData["Freeinterest"];
				var o_PlCoupon = listData["PlCoupon"];
				var o_CouponFlag = listData["CouponFlag"];
				var o_CouponUrl = listData["CouponUrl"];
				var o_CouponSale1 = listData["CouponSale1"];
				var o_CouponSale2 = listData["CouponSale2"];
				var o_option_flag = listData["option_flag"];
				var o_deliveryShowFlag = listData["deliveryShowFlag"];
				var o_CouponContents = listData["CouponContents"].replace( /\r\n/g, '<br>');
				var o_CouponURL = listData["CouponURL"];
				var o_OverseaDelivery = listData["OverseaDelivery"];
				var deliveryprice = 0;
				if(!isNaN(o_deliveryInfo)) deliveryprice = o_deliveryInfo;
				var o_talminprice = o_minPrice;
				if(o_minPrice>o_instance_price) o_talminprice=o_instance_price;

				var deliveryIscollect = (strdelivery=="배송비유무료" || strdelivery=="착불" || strdelivery=="배송비유료") ? "N":"Y";

				html += "<li ";if(Index==(priceListObj.length-1)){html +=" class=\"last\""}html+=">    <!-- 마지막 li class=\"last\" -->";
				html += "	<div class=\"itembox\">";
				html += "		<span class=\"thumb\">";
				html += "			<img src=\""+o_imgUrl+"\" onclick=\"goPlnoItem('"+o_pl_no+"')\" onerror=\"this.src='http://img.enuri.info/images/home/thum_none.gif'\" alt=\"\">";
				html += "		</span>";
				html += "		<div class=\"proinfo\">";
				html += "			<div class=\"modelname cutPara\" onclick=\"goPlnoItem('"+o_pl_no+"')\">";
				html += "				"+o_goodsName+"";
				html += "			</div>";
				html += "			<div class=\"fixbt_info\">";
				html += "				<p class=\"lineprice";if(parseInt(mini_totalminprice)>=parseInt(o_minPrice) && (deliveryIscollect=="Y")){html +=" lowprice";}html +="\">";

				if((o_instance_price>0 && o_instance_price < o_minPrice && !isDeliveryClick ) || (isDeliveryClick && o_instance_price>0 && (parseInt(o_instance_price) + parseInt(deliveryprice)) < o_minPrice)){
					html += "				<span class=\"mobileSendLayer icon mobile\" type=\"1\"><em>모바일</em></span>";
				}
				if(o_minPrice<=0 && o_instance_price > 0){
					html +="				<span class=\"icon mobile3\"><em>모바일</em></span>";
					html +="				<span class=\"mobileSendLayer only\" type=\"2\">전용</span>";
				}
				html +="				<a href=\"javascript:///\" onclick=\"goPlnoItem('"+o_pl_no+"')\">";
				if(parseInt(mini_totalminprice)>=parseInt(o_minPrice) && (deliveryIscollect=="Y")){
					html += "				<span class=\"low\">최저가</span>";
				}
				html +="					<strong>";if(mini_cardeventFlag && o_CardEvent!=""){html+=numComma(o_Price_card)}else{html+=numComma(o_minPrice)}html+="</strong>원</a></p>";
				html += "				<p class=\"etcinfo\"><span>"+strdelivery+"</span><span>"+o_shop_name+"</span></p>";

				if(mini_cardeventFlag){
					html +="				<span class=\"crcard\">"+o_CardName+"</span>";
				}
				html += "			</div>";
				html += "		</div>";
				html += "	</div>";
				html += "	<!-- top 버튼, 4행 미만일 시 비노출 -->";
				html += "</li>";
			});
			itemlistObj.find(".ul_simlist").html(html);
			
			itemlistObj.show();
			noItemObj.hide();

		} else {

			html = "";
			html += "<span class=\"stripe nomark\"></span>";
			html += "<p class=\"txt txt1\">"+nomall_msg+"</p>";
			html += "<p class=\"txt txt2\">"+nomall_msg+" 또는 단종되어<br />판매중인 쇼핑몰이 없습니다.</p>";
		
			noItemObj.find(".stripe").append(html);
			
			itemlistObj.hide();
			noItemObj.show();
		}

		checkModelCnt = checkModelCnt + 1;
		if (totalModelCnt == checkModelCnt) {
			resizeWinByUnit();
			//blockHeightSet(1);
			setTimeout("blockHeightSet()", 1000);
		}
		
	}
	

	function loadCashList(modelno,mini_listType){
		var param = {
				"modelno" : modelno,
				"listType" : mini_listType
			};
		
		$.ajax({
			type : "get",
			url : "/lsv2016/ajax/detail/getCashGoodsList_ajax.jsp",
			data : param,
			dataType : "json",
			success: function(json) {
				
				if(json.cash_pricelist_cnt != 0){
					
					if(json.cash_pricelist.length > 0){
						loadCashListView(json,mini_listType,modelno);
					}else{
						$("#mini_cashpricelist_area_"+modelno).hide();
					}
				}else{
					$("#mini_cashpricelist_area_"+modelno).hide();
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				//alert(xhr.status);
				//alert(thrownError);
			}
		});
	}
	function loadCashListView(json,mini_listType,modelno){
		var cashListCnt = json["cash_pricelist_cnt"];
		var cashList = json["cash_pricelist"];
		var cashShopName = "";
		var cashShopCode = "";
		var cashPrice = "";
		var cashGoodsName = "";
		var cashDeliveryPrice = "";
		var cashUrl = "";
		var cashDeliveryInfo = "";
		var cashDeliveryInfo2 = "";
		var cashDeliveryType2 = "";
		var cashDisplayDelivery = "";
		var cashInstancePrice = 0;
		var cashPlno = "";
		var cashGoodsCode = "";
		var html="";
		var cashListObj = $("#cash_pricelist").find(".tbody");
		var cmdGoToUrl = "";
		var displayCss = "";
		if(cashListCnt > 0 && cashList !=null && cashList.length > 0 ){
			$.each(cashList,function(index,listData){
				if(index > 3) return false;
				cashShopCode = listData["shop_code"];
				cashShopName = listData["shop_name"];
				cashPrice = listData["price"];
				cashInstancePrice = listData["instance_price"];
				cashGoodsName = listData["goodsnm"];
				cashDeliveryPrice = listData["pc_displaydelivery"];
				cashUrl = listData["url"];
				cashDeliveryInfo = listData["deliveryinfo"];
				cashDeliveryInfo2 = listData["deliveryinfo2"];
				cashDeliveryType2 = listData["deliverytype2"];
				cashGoodsCode = listData["cashGoodsCode"];
				cashPlno = listData["pl_no"];
				cashPrice = (mini_listType==1) ? numComma(cashPrice) : numComma(cashPrice + cashDeliveryInfo2);
				displayCss = (index<4) ? "" : "style = \"display:none\" "; 
				
				if(cashDeliveryInfo == "조건부무료"){
					cashDisplayDelivery = cashDeliveryInfo;
				}else if(cashDeliveryPrice==0) {
					cashDisplayDelivery = "무료배송";
				}else if($.isNumeric(cashDeliveryPrice)) {
					cashDisplayDelivery = numComma(cashDeliveryPrice)+"원";
				}else {
					cashDisplayDelivery = cashDeliveryPrice;
				}
				
				cmdGoToUrl = "goPlnoItem("+cashPlno+");";
				html+="<li "+displayCss+" >";
				html+="	<div class=\"itembox\">";
				html+="		<p class=\"mallinfo\">";
				html+="			<a class=\"mallname\" href=\"javascript:void(0);\" onclick=\""+cmdGoToUrl+"\"><strong>"+cashShopName+"</strong></a>";
				html+="		</p>";
				html+="		<p class=\"priceline\">";
				html+="			<a href=\"javascript:void(0);\" onclick=\""+cmdGoToUrl+"\"><span class=\"prcash\">현금</span><span class=\"pricepack\"><strong>"+cashPrice+"</strong>원</span></a>";
				html+="		</p>";
				html+="		<p class=\"delivery\">";
				html+="			<a href=\"javascript:void(0);\" onclick=\""+cmdGoToUrl+"\">"+cashDisplayDelivery+"</a>";
				html+="		</p>";
				html+="	</div>";
				html+="</li>";
			});
			$("#mini_cashpricelist_area_"+modelno).find(".tbody ul").html(html);
			$("#mini_cashpricelist_area_"+modelno).show();
			/*if(cashListCnt>5){
				$("#mini_cashpricelist_area_"+modelno).find(".list_more").show();
			}
			$("#mini_cashpricelist_area_"+modelno).find(".list_more").click(function(){
				$("#mini_cashpricelist_area_"+modelno).find(".tbody ul li").show();
			});*/
		}else{
			$("#mini_cashpricelist_area_"+modelno).hide();
		}
	}
	
	
	
	/****************************************************************************
  		화장품 전성분 UI 개선 (20180425)
	 ****************************************************************************/

	function loadComponent(gModelno,szCategory){
		var modelno = gModelno;
		var originModelno = modelno.replace("AD", ""); // 모델번호 원본
		var cacode = szCategory;
		var opt = "ALL_T";
		var param = {
			"modelno" : originModelno,
			"cacode" : cacode,
			"opt" : opt
		}

		$.ajax({
			type : "get",
			url : "/common/jsp/Ajax_Component_Data.jsp",
			async: true,
			data : param,
			dataType : "json",
			success: function(json) {
				var vAll_Component = json.all_component_data[0];
				var vGoodness_type = json.all_component_data[1];
				var vComponent_items = json.all_component_data[2];
					var vGoods_itemTemplate = "";
					var vBad_itemTemplate = "";
					var vGoods_Itemli ="";
					var vBad_Itemli ="";
					var vGoodnessTemplate ="";
					var vAllTemplate ="";
					var vTemplate ="";
					var cpt_name = "";
					if(vAll_Component.total_cnt == 0){
						return;
					}
					for(var i=0;i<vGoodness_type.goodness_type.length;i++){
						vTemplate += "<li><em class=\"p"+ vGoodness_type.goodness_type[i].cpt_goodness_round_percent+ "\">"+ vGoodness_type.goodness_type[i].cpt_goodness_percent+ "%</em><span>" + vGoodness_type.goodness_type[i].cpt_group_name + "</span></li>";
					}for(var i=0;i<vComponent_items.component_items.length;i++){
						if(vComponent_items.component_items[i].cpt_harmflag == "0"){
							if(vComponent_items.component_items[i].cpt_name == "피부보습"){
								cpt_name ="피부 보습";
							}else{
								cpt_name = "피부 "+ vComponent_items.component_items[i].cpt_name
							}
							if(vComponent_items.component_items[i].cpt_cnt=="0"){
								vGoods_Itemli += "<li><em class=\"non\">"+vComponent_items.component_items[i].cpt_cnt+"</em><span>"+cpt_name+"</span></li>";
							}else{
								vGoods_Itemli += "<li><em class=\"on\">"+vComponent_items.component_items[i].cpt_cnt+"</em><span>"+cpt_name+"</span></li>";
							}
						}else{
							if(vComponent_items.component_items[i].cpt_cnt=="0"){
								vBad_Itemli += "<li><em class=\"non\">"+vComponent_items.component_items[i].cpt_cnt+"</em><span>"+vComponent_items.component_items[i].cpt_name+"</span></li>";
							}else{
								vBad_Itemli += "<li><em class=\"on\">"+vComponent_items.component_items[i].cpt_cnt+"</em><span>"+vComponent_items.component_items[i].cpt_name+"</span></li>";
							}
						}
					}
					vGoodnessTemplate += 	"<p class=\"cosmetics__tit\">성분</p>";
					vGoodnessTemplate +=	"<div class=\"cosmeticsgraph\">";
					vGoodnessTemplate +=	"	<h2 class=\"cosmeticsgraph__tit\">";
					vGoodnessTemplate +=	"			<span>*</span>피부타입별 적합도";
					vGoodnessTemplate +=	"	</h2>";
					vGoodnessTemplate +=	"	<ul class=\"cosmeticsgraph__graph type1\">";
					vGoodnessTemplate +=	vTemplate;	
					vGoodnessTemplate +=	"	</ul>";
					vGoodnessTemplate +=	"</div>";
					
					vGoods_itemTemplate +=	"<div class=\"cosmeticsgraph\">";
					vGoods_itemTemplate +=	"	<h2 class=\"cosmeticsgraph__tit\">";
					vGoods_itemTemplate +=	"			<span>*</span>좋은성분";
					vGoods_itemTemplate +=	"	</h2>";
					vGoods_itemTemplate +=	"	<ul class=\"cosmeticsgraph__graph type2\">";
					vGoods_itemTemplate +=	vGoods_Itemli;	
					vGoods_itemTemplate +=	"	</ul>";
					vGoods_itemTemplate +=	"</div>";
					
					vBad_itemTemplate +=	"<div class=\"cosmeticsgraph\">";
					vBad_itemTemplate +=	"	<h2 class=\"cosmeticsgraph__tit\">";
					vBad_itemTemplate +=	"			<span>*</span>유의성분";
					vBad_itemTemplate +=	"	</h2>";
					vBad_itemTemplate +=	"	<ul class=\"cosmeticsgraph__graph type3\">";
					vBad_itemTemplate +=	vBad_Itemli;	
					vBad_itemTemplate +=	"	</ul>";
					vBad_itemTemplate +=	"</div>";
					$("#cosmetics_"+modelno).html(vGoodnessTemplate+vGoods_itemTemplate+vBad_itemTemplate);
					$("#cosmetics_"+modelno).show();
				
			},
			error: function (xhr, ajaxOptions, thrownError) {
				//alert(xhr.status);
				//alert(thrownError);
			}
		});
	}
	/****************************************************************************
	  	주의사항
	 ****************************************************************************/
	function getMiniGoods_caution(mini_szCategory, mini_modelno, mini_szModelNm, mini_factory, mini_brand){
		var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
		var originModelno = mini_modelno.replace("AD", ""); // 모델번호 원본
		var param = {
			"view_type" : 4,
			"ca_code" : mini_szCategory,
			"modelnos" : originModelno,
			"modelnm" : mini_szModelNm.replace(regExp, ''),
			"factory" : mini_factory,
			"brand" : mini_brand,
			"spec" : ""
			//"spec" : spec
		}
		$("#caution_txt_"+ mini_modelno).hide();
		$("#caution_txt_"+ mini_modelno).html("");
		$.ajax({
			type : "get",
			url : "/lsv2016/ajax/detail/getCautionInfo_ajax.jsp",
			async: true,
			data : param,
			dataType : "json",
			success: function(json) {
				var title_type = json["title_type"];
				var title = json["title"];
				var content_list = json["content_list"];
				var content_type = json["content_type"];
				var img = json["img"];
				var imgmap_list = json["imgmap_list"];
				var caution_html = "";
				
				if(content_list && content_list.length>0) {
					if(content_type==1){
						if(title_type < 2){
							if(title_type==1){
								caution_html += "<dt class=\"txt\"><strong>"+title+"</strong></dt>";
							}else{
								caution_html += "<dt class=\"txt\"><strong>주의사항</strong></dt>";
							}
						}
						
						$.each(content_list, function(Index, listData) {
							var o_content = listData["content"];
							caution_html += "<dd><em>*</em>" + o_content + "</dd>";
						});
						
					}
					/*else if(content_type==2){
						caution_html += "<img src=\"http://storage.enuri.info/pic_upload/caution/"+img+"\"  usemap=\"#Map\" style=\"width:970px;\">";
						caution_html += "<map name=\"Map\">";
						
						$.each(imgmap_list, function(Index, listData) {
							var o_img_map = listData["img_map"];
							var o_map_url = listData["map_url"];
							var o_open_type = listData["open_type"];
							if(o_img_map!=""){
								caution_html += "<area shape=\"rect\" coords=\""+o_img_map+"\" href=\""+o_map_url+"\""; if(o_open_type==1){caution_html+="target=\"_blank\""} caution_html+=">";
							}
						});
	
						caution_html += "</map>"
					}*/
					
					$("#caution_txt_"+ mini_modelno).html(caution_html);
					$("#caution_txt_"+ mini_modelno).show();
					
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				//alert(xhr.status);
				//alert(thrownError);
			}
		});
	}

	/****************************************************************************
	  	상품설명
	 ****************************************************************************/
	function getMiniSpec(mini_modelno, mini_szCategory, mini_szModelNm, mini_spec, mini_strImageUrl){
		var originModelno = mini_modelno.replace("AD", ""); // 모델번호 원본
		var template = "";
		template += "<div style=\"display:none\" class=\"thum_area\">";
		template += "<img style=\"display:none\" class=\"listShowImg\" src=\"\">";
		template += "<em style=\"display:none\" class=\"prodName\"></em>";
		template += "</div>";
		
		$.ajax({
			type: "GET",
			url: "/lsv2016/ajax/detail/getMinidetailSpec_ajax.jsp",
			data: "modelno="+originModelno+"&szCategory="+mini_szCategory,
			dataType:"JSON",
			success: function(json){
				var detailSpecObj = json["detailSpec"];
				
				
				var spec_tbodyObj = $("#spec_tbody_" + mini_modelno);
				
				spec_tbodyObj.attr("ingimodelno", mini_modelno);
				spec_tbodyObj.attr("dtype", "mini_vip");
				spec_tbodyObj.attr("cate", mini_szCategory);
				spec_tbodyObj.addClass("prodItem");
				
				spec_tbodyObj.html(null);
				
				if(detailSpecObj!=null){
					$.each(detailSpecObj, function(Index, listData) {
						var specGroupname = listData["specGroupname"];
						var specCellcnt = listData["specCellcnt"];
						var specContent = listData["specContent"];
						var specTitle = listData["specTitle"];
						var att_id = listData["att_id"];
						var att_el_id = listData["att_el_id"];
						var att_kbno = listData["att_kbno"];
						var att_el_kbno = listData["att_el_kbno"];
						
						if(specGroupname.length>0) {
							template += "<tr><th>"+specGroupname+"</th><th></th></tr>";
						}
						template += "<tr>";
						if(specTitle != ""){
								template += "<td"; if(specCellcnt>1){template += " rowspan=\""+specCellcnt+"\"";}  template +=">"+specTitle+"</td>";
						}
						
						template += "<td>"+specContent+"</td>";
						
						template += "</tr>";
						if(template.length > 1){
							template = template.replace(/&amp;/gi,"&");
							spec_tbodyObj.html(template);
							spec_tbodyObj.find(".thum_area .listShowImg").attr("src", mini_strImageUrl);
							spec_tbodyObj.find(".prodName").html(mini_szModelNm);
						}else{
							$("#spec_table_" + mini_modelno).hide();
						}
					});
				}else{
					$("#comtab1_2_"+ mini_modelno).find(".offercon").hide();
					
					//도서인경우 저자명노출
					if(mini_szCategory.length>=2 && mini_szCategory.substring(0,2)=="93") {
						$("#none_detail_"+ mini_modelno).find('.array').html(mini_spec);
					} else {
						$("#none_detail_"+ mini_modelno).find('.array').hide();
					}
					
					$("#none_detail_"+ mini_modelno).show();
					$("#none_detail_"+ mini_modelno).find('.btn').click(function() {
						goModelnoNew(mini_modelno);
					});
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				//alert(xhr.status);
				//alert(thrownError);
			}
		});
	}
	
	function getMiniBbs(modelno){
		var originModelno = modelno.replace("AD", ""); // 모델번호 원본
		var html = "";
		
		/***********************************************************************
		  	평점 조회
		 ***********************************************************************/
		$.ajax({
			type : "get",
			url : "/lsv2016/ajax/detail/goods_bbs_list_ajax.jsp",
			data : "modelno=" + originModelno + "&pType=GB",
			async: false,
			dataType : "JSON",
			success : function(result) {
				var pObj = result.pointList;

				var resultPointCnt = result.iBbs_num;
				var resultPointavg = result.bbs_point_avg;

				var bbsObj = $("#goodsBbsChart_" + modelno);
				var bbsNoCart = $("#goodsBbsNoChart_" + modelno);
				var reviewStatus2Obj = $("#review_status2_" + modelno);
				
				// 별점 재정의
				if (result.bbs_point_avg != "") {
					reviewStatus2Obj
					.find(".star_graph .ico_m").css("width", resultPointavg * 10).end()
					.find("em").html(resultPointavg+"/5").end();
				}
				
				/* 차트 */
				if (pObj.length > 0) {
					bbsNoCart.hide();
					
					var maxPoint = 0;
					var maxPointCnt = 0;

					for (i = 0; i < pObj.length; i++) {
						var pPoint = pObj[i].point;
						if (parseInt(pObj[i].pointCnt) > 0) {
							if (maxPointCnt < parseInt(pObj[i].pointCnt)) {
								maxPointCnt = parseInt(pObj[i].pointCnt);
								maxPoint = pPoint;
							} else if (maxPointCnt == parseInt(pObj[i].pointCnt)) {
								maxPoint += "," + pPoint;
							}
						}

						if (parseInt(pObj[i].pointCnt) > 0) {
							bbsObj.find(".star" + pPoint).addClass("pShow");
							bbsObj.find(".gpoint" + pObj[i].point).parent().addClass("pShow");
						} else {
							bbsObj.find(".star" + pPoint).addClass("pHide");
							bbsObj.find(".gpoint" + pObj[i].point).parent().addClass("pHide");
						}

						var chartPoint = (pObj[i].pointCnt / result.iBbs_point_cnt * 100);

						if (chartPoint > 0 && chartPoint < 10)
							chartPoint = 10;

						bbsObj.find(".gpoint" + pObj[i].point).attr("style", "height:" + chartPoint + "%;");

						var pointCnt = pObj[i].pointCnt;
						if (pointCnt == "0")
							pointCnt = "";
						bbsObj.find(".gpoint" + pObj[i].point + " em").text(pointCnt);
					}

					if (maxPoint != "") {
						var maxPointArray = maxPoint.split(",");

						if (maxPointArray.length > 0) {
							for (i = 0; i < maxPointArray.length; i++) {
								bbsObj.find(".gpoint"+ maxPointArray[i]).addClass("on");
							}
						}
						reviewStatus2Obj.show();
						bbsObj.show();
						
					} else {
						bbsObj.hide();
						
						if(bbsNoCart.css("display") == "none"){
							//bbsNoCart.show();		// 평점은 평점 없음 영역 노출 안하기로 함. UI상 이상하다고... 혹시 몰라 html은 보존 해 놓음
							bbsNoCart.hide();
						}
						reviewStatus2Obj.hide();
					}
					
				} else {
					bbsObj.hide();

					if($("#goodsBbsNoList_" + modelno).css("display") == "none"){
						//bbsNoCart.show();
						bbsNoCart.hide();
						reviewStatus2Obj.show();
					}
				}
			},
			error : function(request, status, error) {
				// alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
		
		$.ajax({
			type: "GET",
			url: "/lsv2016/ajax/detail/goods_bbs_list_ajax.jsp",
			data: "modelno=" + originModelno+"&pType=ML",
			dataType:"JSON",
			success: function(json){
				var html = "";
				var bbsListObj = json["list"];
				var bbsTotalCnt = json["iTotalCnt"];
				var moreBtnObj = $("#bbs_more_btn_" + modelno);
				
				$("#tab03_cnt_" + modelno).html("("+bbsTotalCnt+")");
				
				if(bbsTotalCnt>31){
					moreBtnObj.click(function() {
						goMore_Modelno(modelno, "2");
					}).show();
					
				}else{
					moreBtnObj.hide(); //더보기
				}
				
				var com_listObj = $("#review_list_" + modelno);
				var noReviewObj = $("#no_review_"+modelno);
				
				if(bbsListObj!=null){
					$.each(bbsListObj, function(Index, listData) {
						var contents = listData["contents"];
						var shop_name = listData["shop_name"];
						var regdate = listData["regdate"].replace(/[.]/gi, "-");
						var usernm = listData["usernm"];
						
						html += "<li id=\"mbbs_"+(Index+1)+"\">";
						html += "	<div class=\"rv_ment\">";
						html += contents;
						html += "	</div>";
						html += "	<div class=\"rv_info\">";
						html += "		<strong class=\"shop\">"+shop_name+"</strong>";
						html += "		<p class=\"subinfo\">";
						html += "			<span class=\"date\">"+regdate+"</span> | <span class=\"write\">"+usernm+"</span>";
						html += "		</p>";
						html += "	</div>";
						html += "</li>";
					});
					
					if(html.length > 1){
						com_listObj.find(" ul").html(html);
					}					
					
				} else {
					html = "<div class=\"no_comment\">등록된 상품평이 없습니다.</div>";
					com_listObj.html(html);
					$("#goodsBbsNoChart_" + modelno).hide();
				}
				
				com_listObj.show();
			},
			error: function (xhr, ajaxOptions, thrownError) {
				//alert(xhr.status);
				//alert(thrownError);
			}
		});
	
	}
	
	// Dom 갯수가 2개 이하일 경우 삭제 버튼 제거 : 기본 li Dom 포함해서 3개
	function isShowHideDelBtn() {
		var liCnt = $("li[id^='cpm_unit_'").length;
		
		if (liCnt <= 3) {
			$("#block_ul_id").find(".del_unit").hide();
		}
	}
	
	function numComma(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

	function nuNumComma(x) {
	    return x.toString().replace(/,/g, '');
	}	
	
	function laypop(name){
		var objid = document.getElementById(name);
		if(objid.style.display == "block"){
			objid.style.display = "none";
		}
		else{
			objid.style.display = "block";
		}
	}
	
	var viewtab = 1;
	
	function resizeWinByUnit() {
		var selfW = window.screen.width;
		var selfH = screen.availHeight;
		var tW = 80+25; //총 넓이

		tW = 293*totalModelCnt + tW;
		
		if(selfW > tW){
			selfW = tW;
		}

		selfW = selfW + 5;
		self.resizeTo(selfW, selfH);
		
		isShowHideDelBtn();
		
	}
	
})(jQuery);

function blockHeightSet(clickTabNo) {
	
	var maxHeight = -1;
	var defalutHeight = 416;
	
	var findClassObj = $('.select_tbl_1');

	if (clickTabNo == 2) {
		findClassObj = $('.select_tbl_2');
	} else if (clickTabNo == 3) {
		findClassObj = $('.select_tbl_3');
	}
	
	findClassObj.each(function() {
	   	maxHeight = maxHeight > $(this).height() ? maxHeight : $(this).height();
   });

   $('.inner_box').each(function() {
	   $(this).height(maxHeight + defalutHeight);
   });
}

function setG9Div() {
	var G9DivObj = $("#G9Div");

	G9DivObj.find(".btnclose").unbind();
	G9DivObj.find(".btnclose").click(function() {
		G9DivHide();
	});
}

function G9DivShow(thisObject) {
	var G9DivObj = $("#G9Div");

	// 토글
	if(G9DivObj.css("display") != "none") {
		G9DivHide();
		//return;
	}

	var thisObj = $(thisObject);

	var top = thisObj.offset().top + 15; //- G9DivObj.height()-140;
	var left = thisObj.parents(".itembox").offset().left - (G9DivObj.width() - thisObj.parents(".itembox").width()) + 58;
	
	G9DivObj.css("top", top+"px");
	G9DivObj.css("left", left+"px");
	G9DivObj.show();
}

function G9DivHide() {
	var G9DivObj = $("#G9Div");

	G9DivObj.hide();
}

function goPlnoItem(plno) {
	var url = "/move/Redirect.jsp?type=ex&cmd=move_"+plno+"&pl_no="+plno+"&referrer="+referrer;
	window.open(url);
}

function goModelnoNew(modelno) {
	// 20190906 슈퍼탑 클릭수 
	if(modelno.indexOf("AD") != -1) {
		insertLog(20508);
	}
	var originModelno = modelno.replace("AD", ""); // 모델번호 원본
	var openWindow = window.open("about:blank");
	openWindow.location.href = "/detail.jsp?modelno="+originModelno;
}

function goMore_Modelno(modelno, opentype) {
	// 20190906 슈퍼탑 클릭수 
	if(modelno.indexOf("AD") != -1) {
		insertLog(20508);
	}
	var originModelno = modelno.replace("AD", ""); // 모델번호 원본
	var openWindow1 = window.open("about:blank");
	var open_url = "/detail.jsp?modelno="+originModelno+"&goodsBbsOpenType="+opentype;
	openWindow1.location.href = open_url;
}

//로그 넣기
function insertLog(logNum) {
	var url = "/view/Loginsert_2010.jsp"
	var param = "kind="+logNum;

	$.ajax({
		type: "GET",
		url: url,
		data: param
	});

	showLogView(logNum);
}
Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";
    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var d = this;
    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
        switch ($1) {
            case "yyyy":
                return d.getFullYear();
            case "yy":
                return (d.getFullYear() % 1000).zf(2);
            case "MM":
                return (d.getMonth() + 1).zf(2);
            case "dd":
                return d.getDate().zf(2);
            case "E":
                return weekName[d.getDay()];
            case "HH":
                return d.getHours().zf(2);
            case "hh":
                return d.getHours().zf(2);
            case "mm":
                return d.getMinutes().zf(2);
            case "ss":
                return d.getSeconds().zf(2);
            case "a/p":
                return d.getHours() < 12 ? "오전" : "오후";
            default:
                return $1;
        }
    });
};
String.prototype.string = function(len) {
    var s = '',
        i = 0;
    while (i++ < len) {
        s += this;
    }
    return s;
};
String.prototype.zf = function(len) {
    return "0".string(len - this.length) + this;
};
Number.prototype.zf = function(len) {
    return this.toString().zf(len);
};