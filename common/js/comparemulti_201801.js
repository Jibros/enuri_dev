(function($) {

	var mini_deliveryFlag = false; //배송비포함
	var mini_cardeventFlag = false; //카드특가
	var mini_cardorderFlag = false; //카드 할인가순
	var mini_deliveryfreeFlag = false; //무료배송
	var mini_authFlag = false; //제조사공식인증
	var mini_departFlag = false; //백화점몰
	var mini_cardfreeFlag = false; //무이자
	var mini_etcmallFlag = false; //홈쇼핑/전문몰

	var mini_shopListAll = "NO"; //더보기
	var mini_modelno = "";
	
	var mini_Rental = "";
	var min_szBidchk  = "";
	var mini_dDate = "";
	var mini_cur_date = "";
	var mini_nMallCnt = "";
	var mini_nMallCnt3 = "";
	var mini_szCategory = "";
	var mini_szModelNm = "";
	var mini_szCategory4 = "";
	var mini_strCondiname = "";
	var mini_factory = "";
	var mini_brand = "";
	var mini_spec = "";
	var mini_strImageUrl = "";
	var mini_sUserId = "";	
	
	$(document).ready(function() {
		getHtmlTagAppend();
	});
	
	/* Html에서 li Tag만 clone 함.  */
	function getHtmlTagAppend() {
		var strArray = chkNo.split(","); 
		
		for (var i=0; i<strArray.length; i++) {
			var varModelno = strArray[i];
	
			if (varModelno > 0) {
				var cloneObj = $("#cpm_unit_1").clone()
									.appendTo($("#block_ul_id"))
									.attr("id", "cpm_unit_"+ varModelno).end();
					
				settingId(varModelno);		// HTML 핸들링 할 요소 ID 셋팅 
			}
		}
	}

	/* 1. HTML 핸들링 할 요소 ID 셋팅  */
	function settingId(modelno) {
		var idObj = $("#cpm_unit_"+modelno);													// li id
		idObj
		.find(".inner_box").attr("id", "product_info_"+ modelno).end()							// 상품정보 div
		.find(".mallList_wrap").attr("id", "mallList_warp_"+ modelno).end()						// 비교 상품 목록 div
		.find("div[id='comtab1_1']").attr("id", "comtab1_1_"+ modelno).end()					// 첫번째 탭 : 판매가 /배송비포함순/ 카드할인가순
		.find("div[id='comtab1_2']").attr("id", "comtab1_2_"+ modelno).end()					// 상품 설명 탭
		.find("div[id='comtab1_3']").attr("id", "comtab1_3_"+ modelno).end()					// 상품평 탭
		.find("em[id='tab01_cnt']").attr("id", "tab01_cnt_"+ modelno).end()					// 가격비교 탭 카운트 
		.find("div[id='shopingmall_all_view']").attr("id", "shopingmall_all_view_"+ modelno).end();	
		
		// 상품정보 DomID 셋팅
		var varProductInfoId = $("#product_info_"+ modelno);
		varProductInfoId
		.find(".thumb").attr("id", "thumb_img_"+ modelno).end();
		
		// 기능별 Tab
		var varMallListWarpId = $("#mallList_warp_"+ modelno);
		varMallListWarpId
		.find("li[id='select_tbl_1']").attr("id", "select_tbl_1_"+ modelno).attr("modelno", modelno).end()				// 가격비교 탭
		.find("li[id='select_tbl_2']").attr("id", "select_tbl_2_"+ modelno).attr("modelno", modelno).end()				// 상품설명 탭
		.find("li[id='select_tbl_3']").attr("id", "select_tbl_3_"+ modelno).attr("modelno", modelno).end();				// 상품평 탭
		
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
		.find("div[id='righttitle']").attr("id", "righttitle_"+ modelno).end();
		
		//두번째 탭 하위 Dom ID 셋팅
		var varComtab1_2 =  $("#comtab1_2_"+modelno);
		varComtab1_2
		.find(".none_detail").attr("id", "none_detail_"+ modelno).end();							// 상품 설명 없을 경우 <!-- 상품설명 없을 때 class="not_attbu" 추가 -->
		
		//세번째 탭 하위 Dom ID 셋팅
		var varComtab1_3 =  $("#comtab1_2_"+modelno);
		varComtab1_3
		.find(".graphBox").attr("id", "graph_"+ modelno).end()									// 사용자 별 평점	
		.find(".novalue").attr("id", "novalue_"+ modelno).end()									// 사용자 별 평점 없음.
		.find(".review_list").attr("id", "review_list_"+ modelno).end()								// 상품평목록
		.find(".no_comment").attr("id", "no_review_"+ modelno).end();							// 상품평목록 없음.
		
		var mini_listType = 1; 		//판매가 순 : 1, 배송비포함순 : 2, 카드할인가순 : 3
		var mini_deliveryFlag = false; //배송비포함
		
		loadCompareVip(modelno, mini_listType);		// 1. 상품 정보 가져 온 후 HTML Making
		
		
		// 탭별 클릭 이벤트 설정
		$("#select_tbl_1_" + modelno).unbind();
		$("#select_tbl_1_" + modelno).click(function() {
				alert("가격비교 클릭");
			return false;
		});
		
		$("#select_tbl_2_" + modelno).unbind();
		$("#select_tbl_2_" + modelno).click(function() {
			alert("상품설명 클릭");	
			return false;
		});
		
		$("#select_tbl_3_" + modelno).unbind();
		$("#select_tbl_3_" + modelno).click(function() {
			alert("상품설명 클릭");	
			return false;
		});
	}

	/************************************************************
 		1. 상품 정보 가져 온 후 HTML Making
	 ************************************************************/
	function loadCompareVip(modelno, mini_listType) {
		
		var objProductInfo = $("#product_info_" + modelno);
		
		var mini_Constrain = "";
		
		var param = {
				"modelno" : modelno
		}
				
		$.ajax({
			type : "get",
			url : "/lsv2016/ajax/detail/getGoodsData_ajax.jsp",
			async: true,
			data : param,
			dataType : "json",
			success: function(json) {
				
				compareUserId = json["sUserId"];
				var mini_isSponsor = json["mini_isSponsor"];
				mini_szModelNm = json["mini_szModelNm"];
				var mini_strCondiname = json["mini_strCondiname"];
				mini_strImageUrl = json["mini_strImageUrl"];
				var mini_intRealMinPrice = parseInt(json["mini_intRealMinPrice"]);
				var mini_mMinPrice3 = parseInt(json["mini_mMinPrice3"]);
				min_szBidchk = json["mini_szBidchk"];
				mini_Constrain = json["mini_strConstrain"];
				mini_Rental = json["mini_strSrv"];
				mini_szCategory4 = json["mini_szCategory4"];
				mini_szCategory = json["mini_szCategory"];
				
				mini_nMallCnt3 = json["mini_nMallCnt3"];
				mini_dDate = json["mini_dDate"];
				mini_cur_date = json["mini_cur_date"];
				
				mini_nMallCnt = json["mini_nMallCnt"];
				if(!isNaN(mini_dDate) && (parseInt(mini_dDate) > parseInt(mini_cur_date))) mini_nMallCnt = 0;
				
				$("#tab01_cnt_" + modelno).html("("+numComma(mini_nMallCnt)+")");
				
				mini_strCondiname = json["mini_strCondiname"];
				mini_bbs_point_avg = json["mini_bbs_point_avg"];
				mini_bbs_point_num = json["mini_bbs_point_num"];
				
				mini_factory = json["mini_szFactory"];
				mini_brand = json["mini_szBrand"];
				mini_spec = json["mini_szSpec"];
				
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
					if(mini_intRealMinPrice>mini_mMinPrice3) priceHtml += "<span class=\"mobileSendLayer icon mobile\" type=\"1\"><em>모바일</em></span>";
					if(mini_Rental=="rental") priceHtml += "<a href=\"javascript:///\"><span class=\"low\">렌탈(월)</span><span class=\"pr\"><strong>"+numComma(mini_mMinPrice3)+"</strong>원</span></a>";
					else priceHtml += "<a href=\"javascript:///\"><span class=\"low\">최저가</span><span class=\"pr\"><strong>"+numComma(mini_mMinPrice3)+"</strong>원</span></a>";
					
					objProductInfo.find('.lowprice').html(priceHtml);
			    }
			    
			    if (mini_Constrain == "5") {
			    	objProductInfo.find(".btn_pack").show();
			    }
			    
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
			    });
			    
			    loadPriceList(modelno, mini_listType, mini_Constrain);
			}		
		});
		
		
		//loadMimiPriceList(mini_modelno);
		
	}	// END : loadCompareVip(modelno)
	
	var gPhonePriceShow = false; //좌우구분이 일시불/할부구매쇼핑몰인 모델 구분
	var gauthShowFlag = false; //제조사 인증
	var mini_limtShowLine = 29; //더보기 제한갯수
	
	function loadPriceList(modelno, mini_listType, mini_Constrain) {
		//var mini_modelno = modelno;
		if(typeof(modelno)=='undefined') modelno = mini_modelno;
		var strShopListAll = mini_shopListAll; 				//YES :더보기
/*		if(mini_deliveryFlag) {mini_listType=2;} 				//배송비포함
		if(mini_cardeventFlag) {mini_listType=3;} 			//카드할인가
		if(!mini_deliveryFlag && !mini_cardeventFlag) {mini_listType=1;} 			//기본
*/
		var param = {
			//"random_seq" : random_seq,
			"modelno" : modelno,
			"strShopListAll" : strShopListAll,
			"listType" : mini_listType,
	//		"szSelectedShop" : mini_SelectedShop,
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
				if(cardButtonShowFlag) $('.option_sel').find('#o_card_'+modelno).show();
				else $('.option_sel').find('#o_card_'+modelno).hide();
			
				if (mini_Constrain == "5") { 			//유사상품
					$('#mini_goodsInfo').find('.proinfo ').addClass("siminfo");
					var priceListObj = json["left_priceList"];
					
					//최저가
					mini_totalminprice = parseInt(json["left_totalMinPrice"]);
												
					var left_msg = json["left_msg"];

					// 유사 상품 HTML Rendering
					loadsimilarGoodsListView(priceListObj, 'left', left_msg, modelno);
					
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
				} else if((!isNaN(mini_dDate) && (parseInt(mini_dDate) > parseInt(mini_cur_date))) || parseInt(mini_nMallCnt) <= 0 && parseInt(mini_nMallCnt3) <=0) { //출시예정 또는  //일시품절
				
					$("#compare_product_"+ modelno).hide();		// 가격비교 상품
					$("#similar_product_"+ modelno).hide();			// 유사상품
					$("#nodata_product_"+ modelno).show();			// 출시예정&일시품절
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
					var righttitleObj = $("#righttitle"+modelno);
					
					var left_title = "";
					var right_title = "";
					if(typeof(json["left_title"])!='undefined'){
						left_title = json["left_title"].replace("인증 공식판매자","공식판매");
						if(left_title.indexOf("<a")>-1) left_title = left_title.substring(0,left_title.indexOf("<a"));
					}
					if(typeof(json["right_title"])!='undefined'){
						right_title = json["right_title"];
						if(right_title.indexOf("<a")>-1) right_title = right_title.substring(0,right_title.indexOf("<a"));
					}
					
					var left_authImg = "";
					var right_authImg = "";
					if(typeof(json["left_authImg"])!='undefined') left_authImg = json["left_authImg"].replace(".gif","_toolbar.gif");
					if(typeof(json["right_authImg"])!='undefined') right_authImg = json["right_authImg"];
					var left_msg = json["left_msg"];
					var right_msg = json["right_msg"];
					
					//제조사 인증
					gauthShowFlag = json["authShowFlag"];
					if(left_authImg !="" && mini_SelectedShop=="") left_title = left_authImg+left_title;
					if(right_authImg !="") right_title = right_authImg+right_title;
					lefttitleObj.html(left_title);
					righttitleObj.html(right_title);
										
					if (leftCnt > 0 || rightCnt > 0) {
						$("#similar_product_"+ modelno).hide();			// 유사상품
						$("#nodata_product_"+ modelno).hide();			// 출시예정&일시품절
						$("#compare_product_"+ modelno).show();		// 가격비교 상품
						
						if (modelno  > 0) {
							loadGoodsListView(left_priceListObj, 'left', left_msg, modelno);
							loadGoodsListView(right_priceListObj, 'right', right_msg, modelno);
						}
					}
				}

				$("#cpm_unit_"+modelno).show();
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
	function loadGoodsListView(priceListObj, leftright, nomall_msg, modelno ) {
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
				if(o_minprice_delivery==0) {
					strdelivery = "무료배송";
				}else if($.isNumeric(o_minprice_delivery)) {
					if(mini_deliveryFlag) strdelivery = "배송비 " + numComma(o_minprice_delivery)+"원 포함";
					else strdelivery = "배송비 " +numComma(o_minprice_delivery)+"원";
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
				
				//11번가 중복쿠폰
				var eventCouponCheck = listData["eventCouponCheck"];

				var deliveryprice = 0;
				if(!isNaN(o_deliveryInfo)) deliveryprice = o_deliveryInfo;
				var o_talminprice = o_minPrice;
				if(o_minPrice>o_instance_price)o_talminprice=o_instance_price;

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
				html +="			<a class=\"mallname\" href=\"javascript:///\" onclick=\"insertLog(15062);goPlnoItem("+o_pl_no+");\">";
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
				//11번가 중복쿠폰
				if(eventCouponCheck=='true'){
					html +="	 	<span class=\"coupon_11st\">중복쿠폰받기</span>";
				}
				//G9이동
				if(o_gmarket_g9=="Y"){
					html +="		<span class=\"icon btn_g9move\" style=\"cursor: pointer;\" onclick=\"G9DivShow(this);\"><em>G9이동</em></span>";
				}
				html +="		</p>";
				html +="		<p class=\"priceline"; if(parseInt(mini_totalminprice)==o_minPrice){ html+=" pricelow"; } if(o_shopBidFlag=='true') {html += " shopbid";} html +="\">";
				if((o_instance_price>0 && o_instance_price < o_minPrice && !mini_deliveryFlag ) || (mini_deliveryFlag && o_instance_price>0 && (parseInt(o_instance_price) + parseInt(deliveryprice)) < o_minPrice)){
					html +="<span class=\"mobileSendLayer icon mobile\" type=\"1\"><em>모바일</em></span>";
				}
				if((o_minPrice<=0 && o_instance_price > 0) || o_shop_code==7870){
					html +="<span class=\"icon mobile3\"><em>모바일</em></span>";
					html +="<span class=\"mobileSendLayer only\" type=\"2\">전용</span>";
				}
				html +="<a href=\"javascript:///\">";
				if(parseInt(mini_totalminprice)==o_minPrice){ html +="<span class=\"prlow\">최저가</span>";}
				html +="<span class=\"pricepack\" onclick=\"insertLog(15063);goPlnoItem("+o_pl_no+");\"><strong>"+numComma(o_minPrice)+"</strong>"; if(o_minPrice<100000000)html +="원";html +="</span>";html +="</a></p><!-- 최저가 p class=\"pricelow\" 추가 -->";
				html +="		<p class=\"delivery\"><a href=\"javascript:///\" onclick=\"goPlnoItem("+o_pl_no+")\">"+strdelivery+"</a></p>";
				html +="	</div>";
				html +="</li>";
				
				
				/*
				if(mini_shopListAll=='NO' && (leftCnt>=mini_limtShowLine || rightCnt>=mini_limtShowLine)){
					$("#list_more").show();
				}else{
					$("#list_more").hide();
				}

				if(mini_shopListAll == "YES") mini_loadingHide();
				
				$("#mini_mallprlist_area").find('.coupon_11st').unbind();
				$("#mini_mallprlist_area").find('.coupon_11st').click(function() {
						var rend_url = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1001161301";
						window.open(rend_url,'','');
					return false;
				});
				
				*/
			});

			sideObj.html(html);
			
			$("#compare_product_"+modelno).show();
			$("#comtab_1_box_malllist_"+modelno).show();
			$("#comtab1_1_"+modelno).show();
			$("#mallList_warp_"+modelno).show();
						
		}else{
			/*
			html = "";
			html += "<li class=\"nomall\"><!-- 쇼핑몰이 없는 경우 class=\"nomall\" 추가 -->";
			html += "<!-- itembox -->";
			html += "<div class=\"itembox\">";
			html += "<p class=\"nomall\">"+nomall_msg+"</p>";
			html += "</div>";
			html += "<!-- //itembox -->";
			html += "</li>";

			sideObj.append(html);
			$('.nomall').addClass("last");
			*/
		}
	}
	
	// 유사 상품 HTML 랜더링
	function loadsimilarGoodsListView(priceListObj, leftright, nomall_msg, modelno){
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
				if(o_minprice_delivery==0) {
					strdelivery = "무료배송";
				}else {
					strdelivery = "배송비 "+numComma(o_minprice_delivery)+"원"; if(mini_deliveryFlag) strdelivery+=" 포함";
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
				if((o_instance_price>0 && o_instance_price < o_minPrice && !mini_deliveryFlag ) || (mini_deliveryFlag && o_instance_price>0 && (parseInt(o_instance_price) + parseInt(deliveryprice)) < o_minPrice)){
					html += "				<span class=\"mobileSendLayer icon mobile\" type=\"1\"><em>모바일</em></span>";
				}
				if((o_minPrice<=0 && o_instance_price > 0) || o_shop_code==7870){
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
	}
	


	
	function numComma(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

	function nuNumComma(x) {
	    return x.toString().replace(/,/g, '');
	}

	
	
})(jQuery);


function goPlnoItem(plno) {
	var url = "/move/Redirect.jsp?type=ex&cmd=move_"+plno+"&pl_no="+plno;
	window.open(url);
}

function goModelnoNew(modelno) {
	var openWindow = window.open("about:blank");
	openWindow.location.href = "/detail.jsp?modelno="+modelno;
}

function goMore_Modelno(modelno, opentype) {
	var openWindow1 = window.open("about:blank");
	var open_url = "/detail.jsp?modelno="+modelno+"&goodsBbsOpenType="+opentype;
	openWindow1.location.href = open_url;
}