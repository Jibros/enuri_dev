var miniVipEventBool = false;
var miniVipModelNo = 0; // 모델번호
var miniVipActiveTab = 1; // 활성화된 탭 ( 1 : 가격비교 / 2 : 상품설명 / 3 : 상품평 )
var miniVipCategory = "";
var param = {
    "modelno": miniVipModelNo,
    "sort": 'price',
    "card": 'N',
    "delivery": 'N'
};
// 이벤트 호출 함수
function initMiniVip(modelno, category) {
	var $minVip = $('#miniVIP_AREA'); // MiniVip Wrapper
	miniVipModelNo = modelno;
	miniVipCategory = category;
    param.modelno = modelno;
	param.delivery = 'N';
	param.card = 'N';

	var html = [];
	var hIdx = 0;

	// 초기 구성 DOM
	html[hIdx++] = "<div class=\"lay-comm--head\">";
	html[hIdx++] = "	<strong class=\"lay-comm__tit\">가격비교 요약보기</strong>";
	html[hIdx++] = "</div>";
	html[hIdx++] = "<div class=\"minvip__head\">";
	html[hIdx++] = "</div>";
	html[hIdx++] = "<div class=\"minvip__body\">";
	html[hIdx++] = "	<div class=\"minvip__tab\"></div>";
	html[hIdx++] = "	<div class=\"minvip__cont\"></div>";
	html[hIdx++] = "	<button class=\"minvip__btn--top comm__sprite\" onclick=\"$('.minvip__cont').stop(true,false).animate({'scrollTop':0},'slow');\">탑으로</button>";
	html[hIdx++] = "</div>";
	html[hIdx++] = "<button class=\"lay-comm__btn--close comm__sprite\" onclick=\"$(this).parent().hide()\">레이어 닫기</button>";

	$minVip.html(html.join(""));

	// 요약정보
	loadSummary();

	// 가격비교
	loadPrice();
}

// 요약정보 호출
function loadSummary() {

	var summaryPromise = $.ajax({
		type: "GET",
		url: "/wide/api/product/prodInit.jsp",
		dataType: "json",
		data: {
			"modelno": miniVipModelNo
		}
	});

	summaryPromise.then(drawSummary, failMiniVip);
}

// 요약정보 그리기
function drawSummary(dataObj) {

	if (dataObj.data === undefined || dataObj.data.gModelData === undefined) {
		var $failObj = new Object();
		$failObj["statusText"] = "summary empty";
		failMiniVip($failObj);
		return;
	}

	var $minVipHead = $(".minvip__head"); // MiniVIP 상단
	var $minVipTab = $(".minvip__tab"); //MiniVIP 탭
	var $metaData = dataObj.data.gMetaData;
	var $modelData = dataObj.data.gModelData;

	// 상품갯수 가 없을 경우 vip 로 이동
	if($modelData.gCdateView=="출시예정" || $modelData.gMallCnt == 0) {
		window.open("/detail.jsp?modelno=" + miniVipModelNo);
		return false;
	}

	var html_head = [];
	var hIdx_head = 0;

	html_head[hIdx_head++] = "<div class=\"minvip__prod\">";
	html_head[hIdx_head++] = "		<a href=\"/detail.jsp?modelno=" + $modelData.gModelno + "\" target=\"_blank\">";
	html_head[hIdx_head++] = "			<div class=\"minvip__thumb\" onclick=\"javascript:insertLogLSV(15058);\">";
	html_head[hIdx_head++] = "				<img src=\"" + $modelData.gImageUrl + "\" alt=\"" + $modelData.gModelNmView + "\">";
	html_head[hIdx_head++] = "			</div>";
	html_head[hIdx_head++] = "		</a>";
	html_head[hIdx_head++] = "	<div class=\"minvip__info\">";
	//								<!-- 모델명 -->
	html_head[hIdx_head++] = "		<a href=\"/detail.jsp?modelno=" + $modelData.gModelno + "\" target=\"_blank\">";
	html_head[hIdx_head++] = "			<div class=\"minvip__model\" onclick=\"javascript:insertLogLSV(15045);\">" + $modelData.gModelNmView + "</div>";
	html_head[hIdx_head++] = "		</a>";
	//								<!-- 옵션명 -->
	html_head[hIdx_head++] = "		<div class=\"minvip__model--sub\" onclick=\"javascript:insertLogLSV(15057);\">" + $modelData.gCondiName + "</div>";
	//								<!-- 가격 : 최저가 (기본) -->
	html_head[hIdx_head++] = "		<a href=\"/detail.jsp?modelno=" + $modelData.gModelno + "\" target=\"_blank\">";
	if($modelData.gMinPrice !== 0) {
		html_head[hIdx_head++] = "		<div class=\"minvip__price\" >최저가 <em>" + $modelData.gMinPrice.format() + "</em>원</div>";
	} else {
		html_head[hIdx_head++] = "		<div class=\"minvip__price\" >출시예정</div>";
	}
	
	html_head[hIdx_head++] = "		</a>";
	if ($modelData.gConstrain) {
		html_head[hIdx_head++] = "		<button class=\"minvip__btn--similiar\">";
		html_head[hIdx_head++] = "		비슷한 상품비교<a href=\"javascript:void(0);\">?</a>";
		html_head[hIdx_head++] = "			<div class=\"lay-similar\">쇼핑몰 상품들 중에서 동일 상품으로 판단되는 상품들을 자동으로 모았습니다.</div>";
		html_head[hIdx_head++] = "		</button>";
	}

	//								<!-- 버튼 : 신고하기 -->
	html_head[hIdx_head++] = "		<button class=\"minvip__btn--singo\">신고</button>";
	html_head[hIdx_head++] = "	</div>";
	html_head[hIdx_head++] = "</div>";
	html_head[hIdx_head++] = "<div class=\"minvip__noti\">";
	html_head[hIdx_head++] = "	<div class=\"lawnotice\">";
	html_head[hIdx_head++] = "		<div class=\"lawnotice__tx--main\">";
	html_head[hIdx_head++] = "			<span class=\"ico-lawnotice comm__sprite\">!</span> 쇼핑몰 이동 후 정확한 가격 및 상품정보를 꼭 확인 후 구매하세요.";
	html_head[hIdx_head++] = "			<a href=\"/etc/disclaimer.jsp\" target=\"_blank\" onclick=\"javascript:insertLogLSV(14294);\">(법적고지 보기)</a>";
	html_head[hIdx_head++] = "		</div>";
	/*	html_head[hIdx_head++] = "		<div class=\"lawnotice__tx--sub\">";
		html_head[hIdx_head++] = "			<a href=\"/etc/disclaimer.jsp\" target=\"_blank\" onclick=\"javascript:insertLogLSV(14294);\">(법적고지 보기)</a>";
		html_head[hIdx_head++] = "		</div>";*/
	html_head[hIdx_head++] = "	</div>";
	html_head[hIdx_head++] = "</div>";

	$minVipHead.html(html_head.join(""));

	var html_tab = [];
	var hIdx_tab = 0;

	html_tab[hIdx_tab++] = "<ul class=\"minvip__tablist\">";
	html_tab[hIdx_tab++] = "	<li class=\"minvip__tabitem is--on\" id=\"priceComTab\">";
	html_tab[hIdx_tab++] = "		<a href=\"javascript:void(0);\" data-show-tab=\"tabcont--compare\">가격비교 <span class=\"tx--count\">(" + $modelData.gMallCnt.format() + ")</span></a>";
	html_tab[hIdx_tab++] = "		<div class=\"list-filter\">";
	html_tab[hIdx_tab++] = "			<div>";
	html_tab[hIdx_tab++] = "				<input type=\"checkbox\" id=\"deliveryInc\" class=\"input--checkbox-item\">";
	html_tab[hIdx_tab++] = "				<label for=\"deliveryInc\">배송비 포함</label>";
	html_tab[hIdx_tab++] = "			</div>";
	html_tab[hIdx_tab++] = "			<div>";
	html_tab[hIdx_tab++] = "				<input type=\"checkbox\" id=\"cardsaleInc\" class=\"input--checkbox-item\">";
	html_tab[hIdx_tab++] = "				<label for=\"cardsaleInc\">카드할인가 포함</label>";
	html_tab[hIdx_tab++] = "			</div>";
	html_tab[hIdx_tab++] = "		</div>";
	html_tab[hIdx_tab++] = "	</li>";
	html_tab[hIdx_tab++] = "	<li class=\"minvip__tabitem\" id=\"prodDescTab\"><a href=\"javascript:void();\" data-show-tab=\"tabcont--explain\">상품설명</a></li>";
	html_tab[hIdx_tab++] = "	<li class=\"minvip__tabitem\" id=\"prodBbsTab\"><a href=\"javascript:void();\" data-show-tab=\"tabcont--explain\">상품평 <span class=\"tx--count\">(" + $modelData.gBbsNum.format() + ")</span></a></li>";
	html_tab[hIdx_tab++] = "</ul>";

	$minVipTab.html(html_tab.join(""));
}


// 가격비교 호출
var vPriceTabType = "";
function loadPrice() {
	var pricePromise = $.ajax({
		type: "GET",
		url: "/wide/api/product/prodPrice.jsp",
		dataType: "json",
		data: param,
		success :function () {
            // 비즈스프링(로거)에서 알려준 ajax를 확인 할 수 있는 로그 호출 방법
            try {
                _trk_flashEnvView('_TRK_CP=/miniVIP');
            } catch (e) {}
		}
	});

	pricePromise.then(drawPrice, failMiniVip);
}

// 가격비교 그리기
function drawPrice(dataObj) {

	var $minVipContent = $(".minvip__cont"); // MiniVIP 컨텐츠 영역
	var $leftItem = dataObj.data.left;
	var $rightItem = dataObj.data.right;
	var $minPrice = dataObj.data.goodsMinPrice;

	var html_price = [];
	var hIdx_price = 0;

	//							<!-- 탭 : 가격비교 -->
	html_price[hIdx_price++] = "<div class=\"minvip__tabcont tabcont--compare\">";

	if (!dataObj.data.similarModelCheck) {

		//								<!-- 가격비교 > 일반 -->
		html_price[hIdx_price++] = "	<div class=\"mallprice-box\">";
		html_price[hIdx_price++] = "		<div class=\"price-tb\">";
		// 왼쪽
		html_price[hIdx_price++] = "			<div class=\"price-tb--lside\">";
		html_price[hIdx_price++] = "				<div class=\"price-tb__head\" style=\"height: 30px;\">";
		html_price[hIdx_price++] = "					<div class=\"price-tb__tx--head\">" + $leftItem.pricelistTitle + "</div>";
		html_price[hIdx_price++] = "				</div>";

		html_price[hIdx_price++] = "				<ul class=\"price-tb__body\">";
		if ($leftItem.priceList.length > 0) {
			$.each($leftItem.priceList, function(index, item) {
				if($leftItem.priceList[index]["shopname"] === "에누리관리자") { //에누리관리자는 노출 X
					if($leftItem.priceList.length == 1) {
						html_price[hIdx_price++] = "				<div class=\"price-tb__item no_mall\">해당하는 쇼핑몰이<br>없습니다.</div>";
						return false;
					} else {
						return true;
					}
				}
				
				if (index == 20) { // 그리기 최대 갯수 20개
					return false;
				}

				var displayPrice = item.price; // 보여질 가격
				
				if (param.delivery === 'Y' && $.isNumeric(item.delivery_text)) {
					displayPrice = item.price2;
				}

				html_price[hIdx_price++] = "			<li class=\"price-tb__item\">";
				html_price[hIdx_price++] = "				<a href=\"/move/Redirect.jsp?type=ex&cmd=move_" + item.plno + "&pl_no=" + item.plno + "\" target=\"_blank\" \">";
				html_price[hIdx_price++] = "					<div class=\"price-tb__item--head\">";
				if (item.cardname.length > 0 && param.card === "Y") {
					html_price[hIdx_price++] = "				<span class=\"price-tb__tx-card\">" + item.cardname + "</span>";
				}
				//													<!-- 쇼핑몰 명 -->
				html_price[hIdx_price++] = "						<span class=\"price-tb__mall\">" + item.shopname + "</span>";

				//													<!-- TAG : AD -->
				if (item.ad_check) {
					html_price[hIdx_price++] = "					<span class=\"tag--ad comm__sprite\">AD</span>";
				}
				//													<!-- 이벤트 아이콘 관리자 > CM직접 입력 -->
				if (item.promotion_cpnMiniVipIconViewText.length > 0) {
					html_price[hIdx_price++] = "					<span class=\"price-tb__tx-sub\">" + item.promotion_cpnMiniVipIconViewText + "</span>";
				}
				html_price[hIdx_price++] = "					</div>";

				//												<!-- 가격 : 최저가일때 .lowest 붙여주세요 -->
				if (displayPrice == $minPrice) {
					html_price[hIdx_price++] = "				<div class=\"price-tb__item--price lowest\">";
					html_price[hIdx_price++] = "					최저가 <em>" + displayPrice.format() + "</em>원";
					html_price[hIdx_price++] = "				</div>";

					//												<!-- 가격 : 기본형 -->
				} else {
					html_price[hIdx_price++] = "				<div class=\"price-tb__item--price\">";
					if (item.mobileprice_check) {
						html_price[hIdx_price++] = "				<i class=\"ico-mobile comm__sprite\">모바일</i>";
					}
					html_price[hIdx_price++] = "					<em>" + displayPrice.format() + "</em>원";
					html_price[hIdx_price++] = "				</div>";
				}
				//												<!-- 배송비 문구 -->
				if ($.isNumeric(item.delivery_text)) {
					if (param.delivery === 'Y') {
						html_price[hIdx_price++] = "			<div class=\"price-tb__item--delivery\">배송비 " + item.delivery_text.format() + "원 포함</div>";
					} else {
						html_price[hIdx_price++] = "			<div class=\"price-tb__item--delivery\">배송비 " + item.delivery_text.format() + "원</div>";
					}
				} else {
					html_price[hIdx_price++] = "				<div class=\"price-tb__item--delivery\">(" + item.delivery_text + ")</div>";
				}

				html_price[hIdx_price++] = "				</a>";
				html_price[hIdx_price++] = "			</li>";
			});
		} else {
			//											<!-- 쇼핑몰 없음 -->
			html_price[hIdx_price++] = "				<div class=\"price-tb__item no_mall\">해당하는 쇼핑몰이<br>없습니다.</div>";
			//											<!-- // -->
		}
		html_price[hIdx_price++] = "				</ul>";
		html_price[hIdx_price++] = "			</div>";

		// 오른쪽
		html_price[hIdx_price++] = "			<div class=\"price-tb--rside\">";
		html_price[hIdx_price++] = "				<div class=\"price-tb__head\" style=\"height: 30px;\">";
		html_price[hIdx_price++] = "					<div class=\"price-tb__tx--head\">" + $rightItem.pricelistTitle + "</div>";
		html_price[hIdx_price++] = "				</div>";

		html_price[hIdx_price++] = "				<ul class=\"price-tb__body\">";
		if ($rightItem.priceList.length > 0) {
			$.each($rightItem.priceList, function(index, item) {

				if (index == 20) { // 그리기 최대 갯수 20개
					return false;
				}

				var displayPrice = 0; // 보여질 가격
				if(item.cardname.length > 0 && param.card === "Y") {
					displayPrice = item.cardprice;
				} else {
					displayPrice = item.price;
				}
				
				if (param.delivery === 'Y' && $.isNumeric(item.delivery_text)) {
					displayPrice = item.price2;
				}

				html_price[hIdx_price++] = "			<li class=\"price-tb__item\">";
				html_price[hIdx_price++] = "				<a href=\"/move/Redirect.jsp?type=ex&cmd=move_" + item.plno + "&pl_no=" + item.plno + "\" target=\"_blank\">";
				html_price[hIdx_price++] = "					<div class=\"price-tb__item--head\">";
				if (item.cardname.length > 0 && param.card === "Y") {
					html_price[hIdx_price++] = "				<span class=\"price-tb__tx-card\">" + item.cardname + "</span>";
				}
				//													<!-- 쇼핑몰 명 -->
				html_price[hIdx_price++] = "						<span class=\"price-tb__mall\">" + item.shopname + "</span>";
				//													<!-- TAG : AD -->
				if (item.ad_check) {
					html_price[hIdx_price++] = "					<span class=\"tag--ad comm__sprite\">AD</span>";
				}
				//													<!-- 이벤트 아이콘 관리자 > CM직접 입력 -->
				if (item.promotion_cpnMiniVipIconViewText.length > 0) {
					html_price[hIdx_price++] = "					<span class=\"price-tb__tx-sub\">" + item.promotion_cpnMiniVipIconViewText + "</span>";
				}
				html_price[hIdx_price++] = "					</div>";
				//												<!-- 가격 : 최저가일때 .lowest 붙여주세요 -->
				if (displayPrice <= $minPrice ) {
					html_price[hIdx_price++] = "				<div class=\"price-tb__item--price lowest\">";
					html_price[hIdx_price++] = "					최저가 <em>" + displayPrice.format() + "</em>원";
					html_price[hIdx_price++] = "				</div>";

					//												<!-- 가격 : 기본형 -->
				} else {
					html_price[hIdx_price++] = "				<div class=\"price-tb__item--price\">";
					if (item.mobileprice_check) {
						html_price[hIdx_price++] = "				<i class=\"ico-mobile comm__sprite\">모바일</i>";
					}
					html_price[hIdx_price++] = "					<em>" + displayPrice.format() + "</em>원";
					html_price[hIdx_price++] = "				</div>";
				}
				//												<!-- 배송비 문구 -->
				if ($.isNumeric(item.delivery_text)) {
					if (param.delivery === 'Y') {
						html_price[hIdx_price++] = "			<div class=\"price-tb__item--delivery\">배송비 " + item.delivery_text.format() + "원 포함</div>";
					} else {
						html_price[hIdx_price++] = "			<div class=\"price-tb__item--delivery\">배송비 " + item.delivery_text.format() + "원</div>";
					}
				} else {
					html_price[hIdx_price++] = "				<div class=\"price-tb__item--delivery\">(" + item.delivery_text + ")</div>";
				}

				html_price[hIdx_price++] = "				</a>";
				html_price[hIdx_price++] = "			</li>";
			});
		} else {
			//											<!-- 쇼핑몰 없음 -->
			html_price[hIdx_price++] = "				<div class=\"price-tb__item no_mall\">해당하는 쇼핑몰이<br>없습니다.</div>";
			//											<!-- // -->
		}
		html_price[hIdx_price++] = "				</ul>";
		html_price[hIdx_price++] = "			</div>";
		html_price[hIdx_price++] = "			<button class=\"minvip__btn--more\">더보기</button>";
		html_price[hIdx_price++] = "		</div>";
		// 유사모델
	} else if ($rightItem.priceList.length > 0) {

		//								<!-- 가격비교 > 유사상품 -->
		html_price[hIdx_price++] = "	<div class=\"mallprice-box--similar\">";
		html_price[hIdx_price++] = "		<ul class=\"similar__list\">";

		$.each($rightItem.priceList, function(index, item) {

			var displayPrice = item.price; // 보여질 가격
			if (param.delivery === 'Y' && $.isNumeric(item.delivery_text)) {
				displayPrice = item.price2;
			} else if (dataObj.data.goodsCompareTier == "similiarTier" && param.delivery === "Y") {
				displayPrice = item.price2;
			} else if (dataObj.data.goodsCompareTier == "similiarTier" && param.card === "Y") {
				if(item.cardname.length > 0) displayPrice = item.cardprice;
				else displayPrice = item.price;
			}

			html_price[hIdx_price++] = "		<li class=\"similar__item\">";
			html_price[hIdx_price++] = "			<a href=\"/move/Redirect.jsp?type=ex&cmd=move_" + item.plno + "&pl_no=" + item.plno + "\" target=\"_blank\">";
			html_price[hIdx_price++] = "				<div class=\"minvip__thumb\">";
			html_price[hIdx_price++] = "					<img src=\"" + item.imageurl + "\" alt=\"" + item.goodsname + "\" width=\"92\" height=\"92\">";
			html_price[hIdx_price++] = "				</div>";
			html_price[hIdx_price++] = "				<div class=\"minvip__info\">";
			//												<!-- 모델명 -->
			html_price[hIdx_price++] = "					<div class=\"minvip__model\">" + item.goodsname + "</div>";
			//												<!-- 가격 : 최저가일때 .lowest 붙여주세요 -->
			if (displayPrice == $minPrice) {
				html_price[hIdx_price++] = "				<div class=\"minvip__price lowest\">최저가 <em>" + displayPrice.format() + "</em>원</div>";
				//												<!-- 가격 : 기본형 -->
			} else {
				html_price[hIdx_price++] = "				<div class=\"minvip__price\"><em>" + displayPrice.format() + "</em>원</div>";
			}
			//												<!-- 배송비 문구 -->
			if ($.isNumeric(item.delivery_text)) {
				if (param.delivery === 'Y') {
					html_price[hIdx_price++] = "			<span class=\"minvip__tx\">배송비" + item.delivery_text.format() + "원 포함</span>";
				} else {
					html_price[hIdx_price++] = "			<span class=\"minvip__tx\">배송비" + item.delivery_text.format() + "원</span>";
				}
			} else {
				html_price[hIdx_price++] = "				<span class=\"minvip__tx\">무료배송</span>";
			}
			//												<!-- 쇼핑몰 -->
			html_price[hIdx_price++] = "					<span class=\"minvip__tx\">" + item.shopname + "</span>";
			if (item.cardname.length > 0) {
				html_price[hIdx_price++] = "				<div class=\"minvip__card\">" + item.cardname + "</div>";
			}
			html_price[hIdx_price++] = "				</div>";
			html_price[hIdx_price++] = "			</a>";
			html_price[hIdx_price++] = "		</li>";
		});


		html_price[hIdx_price++] = "		</ul>";
		html_price[hIdx_price++] = "		<button class=\"minvip__btn--more\">더보기</button>";
		html_price[hIdx_price++] = "	</div>";
	}

	//									<!-- 가격비교 > 현금몰 -->
	if (dataObj.data.cash !== undefined && dataObj.data.cash.priceList !== undefined && dataObj.data.cash.priceList.length > 0) {
		html_price[hIdx_price++] = "	<div class=\"mallprice-box--cash\">";
		html_price[hIdx_price++] = "		<div class=\"price-tb\">";
		html_price[hIdx_price++] = "			<div class=\"price-tb__head\">";
		html_price[hIdx_price++] = "				<div class=\"price-tb__tx--head\">일반전문몰</div>";
		html_price[hIdx_price++] = "			</div>";
		html_price[hIdx_price++] = "			<ul class=\"price-tb__body\">";
		$.each(dataObj.data.cash.priceList, function(index, item) {

			var displayPrice = item.price; // 보여질 가격
			if (param.delivery === 'Y' && $.isNumeric(item.delivery_text)) {
				displayPrice = item.price2;
			}

			html_price[hIdx_price++] = "			<li class=\"price-tb__item\">";
			html_price[hIdx_price++] = "				<a href=\"/move/Redirect.jsp?type=ex&cmd=move_" + item.plno + "&pl_no=" + item.plno + "\" target=\"_blank\">";
			html_price[hIdx_price++] = "					<div class=\"price-tb__item--head\">";
			//													<!-- 쇼핑몰 명 -->
			html_price[hIdx_price++] = "						<span class=\"price-tb__mall\">" + item.shopname + "</span>";
			html_price[hIdx_price++] = "					</div>";
			//												<!-- 가격 : 기본형 -->
			html_price[hIdx_price++] = "					<div class=\"price-tb__item--price\">";
			html_price[hIdx_price++] = "						<span class=\"tx--cash\">현금</span>";
			html_price[hIdx_price++] = "						<em>" + displayPrice.format() + "</em>원";
			html_price[hIdx_price++] = "					</div>";
			if ($.isNumeric(item.delivery_text)) {
				if (param.delivery === 'Y') {
					html_price[hIdx_price++] = "			<div class=\"price-tb__item--delivery\">배송비 " + item.delivery_text.format() + "원 포함</div>";
				} else {
					html_price[hIdx_price++] = "			<div class=\"price-tb__item--delivery\">배송비 " + item.delivery_text.format() + "원</div>";
				}
			} else {
				html_price[hIdx_price++] = "				<div class=\"price-tb__item--delivery\">(" + item.delivery_text + ")</div>";
			}
			html_price[hIdx_price++] = "				</a>";
			html_price[hIdx_price++] = "			</li>";
		});
		html_price[hIdx_price++] = "			</ul>";
		html_price[hIdx_price++] = "		</div>";
		html_price[hIdx_price++] = "		<button class=\"minvip__btn--more\">더보기</button>";
		html_price[hIdx_price++] = "	</div>";
	}

	html_price[hIdx_price++] = "	</div>";
	html_price[hIdx_price++] = "</div>";

	// 파워링크
	html_price[hIdx_price++] = "<div class=\"ad-minvip-powerlink\"></div>";

	$minVipContent.html(html_price.join(""));

	openMiniVip(); // 미니 vip 보여주기
}

// 상품설명
var vCosChk = false;
var vFurnChk = false;
function loadDesc() {
	var descCate = "";
	if (!param_cate.length > 0) {
		if (miniVipCategory.length > 4) {
			descCate = miniVipCategory.substring(0, 4)
		}
	} else {
		descCate = param_cate;
	}

	// 공통 prodDesc.jsp 호출
	var loadDescPromise = $.ajax({
		type: "GET",
		url: "/wide/api/product/prodDesc.jsp",
		dataType: "JSON",
		data: {
			"modelno": miniVipModelNo
		}
	});
	loadDescPromise.then(drawProdDesc, failMiniVip);
	//유의사항
	//상세페이지
	if (typeof miniVipCategory !== "undefined" && miniVipCategory.length > 0) {
		// 화장품 
		var vCosCateArr = ["0860", "0801", "0805", "0809", "0812", "0802", "0814", "0806", "0807", "0803", "0804", "1654"];
		//가구속성
		var vFurnCateArr = ["1201", "1202"];

		$.each(vCosCateArr, function(i, v) {
			if (descCate.indexOf(v) > -1) {
				vCosChk = true;
				return false;
			}
		});
		if (vCosChk) {
			loadDescCos(descCate); // 화장품
		} else {
			$.each(vFurnCateArr, function(i, v) {
				if (descCate.indexOf(v) > -1) {
					vFurnChk = true;
					return false;
				}
			});
			if (vFurnChk) loadDescFurn(descCate); //가구
		}
	}
}

// 상품설명 - 화장품
function loadDescCos(descCate) {
	var loadDescCosPromise = $.ajax({
		type: "GET",
		url: "/wide/api/product/prodCosComponent.jsp",
		dataType: "JSON",
		data: {
			"modelno": miniVipModelNo,
			"cate": descCate,
			"opt": "ALL_T"
		}
	});

	loadDescCosPromise.then(drawDescCos, failMiniVip);
}

var vCosHtml = "";
function drawDescCos(obj) {
	vCosHtml = "";
	var vSuccess = obj.resultmsg;
	if (typeof vSuccess !== "undefined" && vSuccess == "success") {
		var vAll_Component_Data = obj.all_component_data;
		//피부타입별 적합도
		var vGoodness_TypeArr = vAll_Component_Data[1].goodness_type;
		//좋은성분, 나쁜성분
		var vComponent_ItemsArr = vAll_Component_Data[2].component_items;
		//<!-- 성분-->
		vCosHtml += "<div class=\"cont-ingredient\">";
		vCosHtml += "    <div class=\"tabcont__tit\">성분</div>";
		vCosHtml += "    	<div id=\"cosmetics\" class=\"cosmetics\">";
		vCosHtml += "    		<div class=\"cosmeticsgraph\">";
		vCosHtml += "    			<h2 class=\"cosmeticsgraph__tit\">피부타입별 적합도</h2>";
		vCosHtml += "    			<ul class=\"cosmeticsgraph__graph type1\">";
		$.each(vGoodness_TypeArr, function(i, v) {
			vCosHtml += "    			<li><em class=\"p" + v.cpt_goodness_percent + "\">" + v.cpt_goodness_percent + "%</em><span>" + v.cpt_group_name + "</span></li>";
		});
		vCosHtml += "    			</ul>";
		vCosHtml += "    		</div>";

		$.each(vComponent_ItemsArr, function(i, v) {
			if (i == 0) {
				vCosHtml += "    		<div class=\"cosmeticsgraph\">";
				vCosHtml += "    			<h2 class=\"cosmeticsgraph__tit\">좋은성분</h2>";
				vCosHtml += "    			<ul class=\"cosmeticsgraph__graph type2\">";
			} else if (i == 3) {
				vCosHtml += "    		<div class=\"cosmeticsgraph\">";
				vCosHtml += "    			<h2 class=\"cosmeticsgraph__tit\">유의성분</h2>";
				vCosHtml += "    			<ul class=\"cosmeticsgraph__graph type3\">";
			}
			vCosHtml += "    					<li><em class=\"" + (v.cpt_cnt > 0 ? "on" : "non") + "\">" + v.cpt_cnt + "</em><span>" + v.cpt_name + "</span></li>";
			if (i == 2 || i == 5) {
				vCosHtml += "    			 </ul>";
				vCosHtml += "    		</div>";
			}
		});
		vCosHtml += "	</div>";
		vCosHtml += "</div>";
	}
	return vCosHtml;
}

// 상품설명 - 가구
function loadDescFurn(descCate) {
	var loadDescFurnPromise = $.ajax({
		type: "GET",
		url: "/wide/api/product/prodAttrGraph.jsp",
		dataType: "JSON",
		data: {
			"modelno": miniVipModelNo,
			"cate": descCate
		}
	});

	loadDescFurnPromise.then(drawDescFurn, failMiniVip);
}

var vFurnHtml = "";
function drawDescFurn(obj) {
	vFurnHtml = "";
	var vSuccess = obj.success;
	if (typeof vSuccess !== "undefined" && vSuccess) {
		var vList = obj.data.list;
		if (vList.length > 0) {
			$.each(vList, function(i, v) {
				var vFurText1 = "";
				var vFurText2 = "";
				var vFurNumText = "";
				if (v.attribute_id == "205023") {
					vFurText1 = "쿠션감";
					vFurText2 = "1이 가장 푹신하고 5가 가장 단단합니다.";
					if (v.attribute_element_id > 5) v.attribute_element_id = 5;
					if (v.attribute_element == "소프트") {
						vFurNumText = "" + 1;
					} else if (v.attribute_element == "소프트미디엄") {
						vFurNumText = "" + 2;
					} else if (v.attribute_element == "미디엄") {
						vFurNumText = "" + 3;
					} else if (v.attribute_element == "미디엄하드") {
						vFurNumText = "" + 4;
					} else if (v.attribute_element == "하드") {
						vFurNumText = "" + 5;
					}
				} else if (v.attribute_id == "133553") {
					vFurText1 = "자재등급";
					vFurText2 = "유해물질 포름알데히드 방출량에 따른 등급분류";
					vFurNumText = v.attribute_element;
				}
				vFurnHtml += "<div class=\"cont-grade grade--0" + i + "\">";
				vFurnHtml += "		<div class=\"tabcont__tit\">" + vFurText1 + "</div>";
				vFurnHtml += "		<div class=\"tabcont__tx--sub\">" + vFurText2 + "</div>";
				//<!-- 등급에 따라 lvE2 / lvE1 / lvE0 / lvSE0 클래스 붙여주세요 -->
				vFurnHtml += "		<div class=\"fungrade lv" + vFurNumText + "\"></div>"
				vFurnHtml += "</div>";
			});
		}
		return vFurnHtml;
	}
}

function drawProdDesc(obj) {
	var $minVipContent = $(".minvip__cont"); // MiniVIP 컨텐츠 영역
	$minVipContent.empty();

	var vHtml_desc = [];
	var vHidx_desc = 0;

	if (typeof obj !== "undefined") {
		var vEnuri_Spec_Table = obj.enuri_spec_table;
		vHtml_desc[vHidx_desc++] = "<div class=\"minvip__tabcont tabcont--explain\" style=\"\">";
		//화장품
		if (vCosChk) vHtml_desc[vHidx_desc++] = vCosHtml;
		//가구
		if (vFurnChk) vHtml_desc[vHidx_desc++] = vFurnHtml;

		if (typeof vEnuri_Spec_Table != "undefined" && vEnuri_Spec_Table.length > 0) {
			// <!-- 요약설명 -->
			vHtml_desc[vHidx_desc++] = "	<div class=\"cont-summary\">";
			vHtml_desc[vHidx_desc++] = "		<div class=\"tabcont__tit\">요약설명</div>";
			vHtml_desc[vHidx_desc++] = "			<table id=\"miniVipSpecTable\" class=\"tb-summ\" cellpadding=\"0\" cellspacing=\"0\">";
			vHtml_desc[vHidx_desc++] = "				<colgroup>";
			vHtml_desc[vHidx_desc++] = "					<col class=\"col1\">";
			vHtml_desc[vHidx_desc++] = "					<col class=\"col2\">";
			vHtml_desc[vHidx_desc++] = "				</colgroup>";
			vHtml_desc[vHidx_desc++] = "				<tbody>";
			$.each(vEnuri_Spec_Table, function(i, v) {
				var vSpecGroupName = v.specGroupname;
				var vSpecTitle = v.specTitle;
				var vSpecCellcnt = v.specCellcnt;
				var vSpecContent = v.specContent;
				var vAtt_El_Kbno = v.att_el_kbno;
				var vAtt_Id = v.att_id;
				var vAtt_El_Id = v.att_el_id;

				if (vSpecGroupName.length > 0) {
					vHtml_desc[vHidx_desc++] = "				<tr>";
					vHtml_desc[vHidx_desc++] = "					<th colspan=\"2\">" + vSpecGroupName + "</th>";
					vHtml_desc[vHidx_desc++] = "				</tr>";
				}
				vHtml_desc[vHidx_desc++] = "					<tr>";
				if (vSpecTitle.length > 0) {
					vHtml_desc[vHidx_desc++] = "					    <td rowspan=\"" + vSpecCellcnt + "\">" + vSpecTitle + "</td>";
				}
				if (vAtt_El_Kbno > 0) { //용어사전
					vHtml_desc[vHidx_desc++] = "					    <td><a class=\"attr\" href=\"javascript:void(0);\" data-kbno = \"" + vAtt_El_Kbno + "\" data-attr_id=\"" + vAtt_Id + "\" data-attr_el_id=\"" + vAtt_El_Id + "\" onclick=\"parent.showDicLayer(this);insertLogCate(15389);return false;\">" + vSpecContent + "</a></td>";
				} else {
					vHtml_desc[vHidx_desc++] = "					    <td>" + vSpecContent + "</td>";
				}
				vHtml_desc[vHidx_desc++] = "					</tr>";
			});
			vHtml_desc[vHidx_desc++] = "				</tbody>";
			vHtml_desc[vHidx_desc++] = "			</table>";
			vHtml_desc[vHidx_desc++] = "		</div>";
		} else {
			//enuri_spec_table 없음
			//<!-- 상품 설명 없음 -->
			var vCateText = $("li.prodItem[data-model-origin='" + miniVipModelNo + "'] ul.item__attr").html();
			vHtml_desc[vHidx_desc++] = "		<div class=\"cont-nodata\">";
			vHtml_desc[vHidx_desc++] = "			<div class=\"cont-nodata__locate\">";
			if (vCateText) vHtml_desc[vHidx_desc++] = "" + vCateText + "";
			vHtml_desc[vHidx_desc++] = "			</div>";
			vHtml_desc[vHidx_desc++] = "			상품 상세설명은 쇼핑몰 또는 에누리 상품<br>상세페이지에서 확인하세요.";
			vHtml_desc[vHidx_desc++] = "			<a href=\"/detail.jsp?modelno=" + miniVipModelNo + "\" class=\"cont-nodata__btn-vip\" target=\"_blank\" onclick=\"javascript:insertLogLSV(15391);\">상세페이지</a>";
			vHtml_desc[vHidx_desc++] = "		</div>";
		}
		vHtml_desc[vHidx_desc++] = "	</div>";
		// 파워링크
		vHtml_desc[vHidx_desc++] = "<div class=\"ad-minvip-powerlink\"></div>";
		$minVipContent.html(vHtml_desc.join(""));
		// 파워링크
		if (listType == "list") {
			getPowerLink("MINIVIP", param_cate, param_inKeyword);
		} else {
			getPowerLink("MINIVIP", param_cate, param_keyword);
		}
	}
}

// 상품평
function loadBbs() {
	var loadBbsPromise = $.ajax({
		type: "POST",
		data: {
			"pType": "GL",
			"cate": param_cate,
			"modelno": miniVipModelNo,
			"page": 1,
			"pagesize": 30
		},
		dataType: "JSON",
		url: "/wide/api/product/prodBbsList.jsp"
	});

	loadBbsPromise.then(drawBbsList, failMiniVip);
}

function drawBbsList(obj) {
	var $minVipContent = $(".minvip__cont"); // MiniVIP 컨텐츠 영역
	var vList = obj.list;
	var vHtml = "";

	var vHtml_Bbs = [];
	var vHidx_Bbs = 0;
	$minVipContent.empty();

	if (typeof vList !== "undefined") {
		vHtml_Bbs[vHidx_Bbs++] = "<div class=\"minvip__tabcont tabcont--reviews\" style=\"\">";
		//<!-- 상품평 쓰기 > 로그인전 -->
		vHtml_Bbs[vHidx_Bbs++] = "	<div class=\"review-write\">";
		vHtml_Bbs[vHidx_Bbs++] = "		<div class=\"review-write__head\">";
		//<!-- 회원정보 레이어 -->
		vHtml_Bbs[vHidx_Bbs++] = "		<div id=\"membInfoLayer\" class=\"smallbox membinfo\">";
		vHtml_Bbs[vHidx_Bbs++] = "			<h5>";
		vHtml_Bbs[vHidx_Bbs++] = "				<strong></strong>님";
		vHtml_Bbs[vHidx_Bbs++] = "					<a href=\"javascript:///\" class=\"btnclose\" onclick=\"$('#membInfoLayer').hide();\">닫기</a>";
		vHtml_Bbs[vHidx_Bbs++] = "			</h5>";
		vHtml_Bbs[vHidx_Bbs++] = "			<ul class=\"list\">";
		vHtml_Bbs[vHidx_Bbs++] = "				<li><a href=\"https://www.enuri.com/member/info/infoPwChk.jsp\" target=\"_blank\" >회원정보 변경</a></li>";
		vHtml_Bbs[vHidx_Bbs++] = "				<li><a href=\"javascript:void(0);\" onclick=\"parent.logout();\">로그아웃</a></li>";
		vHtml_Bbs[vHidx_Bbs++] = "			</ul>";
		vHtml_Bbs[vHidx_Bbs++] = "		</div>";
		//<!-- //회원정보 레이어 -->
		vHtml_Bbs[vHidx_Bbs++] = "			<div class=\"tabcont__tit\">상품평 쓰기</div>";
		// <!-- 사용자 정보 관련 -->
		vHtml_Bbs[vHidx_Bbs++] = "			<div class=\"review-user\">";
		if (!mini_sUserId.length > 0) {
			vHtml_Bbs[vHidx_Bbs++] = "				<a href=\"javascript:void(0);\" class=\"review-user__login\" id=\"btn_login\">로그인</a>";
		} else {
			vHtml_Bbs[vHidx_Bbs++] = "				<a href=\"javascript:void(0);\" class=\"review-user__id\">" + mini_sUserId + "님</a>";
		}
		vHtml_Bbs[vHidx_Bbs++] = "			</div>";
		vHtml_Bbs[vHidx_Bbs++] = "		</div>";
		vHtml_Bbs[vHidx_Bbs++] = "		<div class=\"review-write__body\">";
		if (!mini_sUserId.length > 0) {
			vHtml_Bbs[vHidx_Bbs++] = "			<textarea class=\"review__textarea\" id=\"gbContent\" cols=\"30\" rows=\"4\" placeholder=\"로그인 후 작성하실 수 있습니다.\" disabled=\"\"></textarea>";
		} else {
			vHtml_Bbs[vHidx_Bbs++] = "			<textarea class=\"review__textarea\" id=\"gbContent\" cols=\"30\" rows=\"4\" placeholder=\"상품평을 작성하세요.\"></textarea>";
			vHtml_Bbs[vHidx_Bbs++] = "			<button class=\"reveiw__btn--register\" id=\"gbBtnWrite\">등록</button>";
		}
		vHtml_Bbs[vHidx_Bbs++] = "		</div>";
		vHtml_Bbs[vHidx_Bbs++] = "	</div>";

		//<!-- 상품평 리스트 -->
		vHtml_Bbs[vHidx_Bbs++] = "	<div class=\"review-list\">";
		//  <!-- [레이어] 삭제하기 -->
		vHtml_Bbs[vHidx_Bbs++] = "		<div id=\"bbsDelLayer\" class=\"mivip__lay--delete lay-comm lay-comm--sm\" style=\"display:none\">";
		vHtml_Bbs[vHidx_Bbs++] = "			<div class=\"lay-comm--head\">";
		vHtml_Bbs[vHidx_Bbs++] = "				<strong class=\"lay-comm__tit\">비밀번호를 입력후 삭제해 주세요</strong>";
		vHtml_Bbs[vHidx_Bbs++] = "			</div>";
		vHtml_Bbs[vHidx_Bbs++] = "			<div class=\"lay-comm--body\">";
		vHtml_Bbs[vHidx_Bbs++] = "				<div class=\"lay-comm__inner\">";
		vHtml_Bbs[vHidx_Bbs++] = "					<div class=\"delete__form\">";
		vHtml_Bbs[vHidx_Bbs++] = "						<fieldset>";
		vHtml_Bbs[vHidx_Bbs++] = "							<legend>비밀번호 입력</legend>";
		vHtml_Bbs[vHidx_Bbs++] = "							<input id=\"del_pass\" type=\"password\" id=\"del_pass\" class=\"delete__form--inp\" placeholder=\"비밀번호 입력\">";
		vHtml_Bbs[vHidx_Bbs++] = "							<button class=\"delete__form--btn\" data-no=\"\" >삭제</button>";
		vHtml_Bbs[vHidx_Bbs++] = "						</fieldset>";
		vHtml_Bbs[vHidx_Bbs++] = "					</div>";
		vHtml_Bbs[vHidx_Bbs++] = "				</div>";
		vHtml_Bbs[vHidx_Bbs++] = "			</div>";
		vHtml_Bbs[vHidx_Bbs++] = "			<button class=\"lay-comm__btn--close comm__sprite\" onclick=\"$(this).parent().hide()\">레이어 닫기</button>";
		vHtml_Bbs[vHidx_Bbs++] = "		</div>";
		//<!-- // -->

		//<!-- // -->
		vHtml_Bbs[vHidx_Bbs++] = " 			<ul>";
		if (vList.length > 0) {
			$.each(vList, function(i, v) {
				vHtml_Bbs[vHidx_Bbs++] = "			<li class=\"review-item\">";
				vHtml_Bbs[vHidx_Bbs++] = "				<div class=\"review-item__comm\">" + v.contents + "</div>";
				vHtml_Bbs[vHidx_Bbs++] = "				<div class=\"review-item__foot\">";
				//<!-- 쇼핑몰 -->
				vHtml_Bbs[vHidx_Bbs++] = "				<div class=\"review__tx--mall\">" + v.shop_name + "</div>";
				//<!-- 작성일 -->
				vHtml_Bbs[vHidx_Bbs++] = "					<span class=\"review__tx--date\">" + v.regdate + "</span>";
				//<!-- 작성자 -->
				vHtml_Bbs[vHidx_Bbs++] = "					<span class=\"review__tx--author\">" + v.usernm + "</span>";
				if (v.delbtn) {
					vHtml_Bbs[vHidx_Bbs++] = "					<a href=\"javascript:void(0);\"  class=\"review__btn--delete\" data-no=\"" + v.no + "\" onclick=\"$('.mivip__lay--delete').show();return false;\">삭제</a>";
				}
				vHtml_Bbs[vHidx_Bbs++] = "				</div>";
				vHtml_Bbs[vHidx_Bbs++] = "			</li>";
			});
		} else {
			//<!-- 상품평 없음 -->
			vHtml_Bbs[vHidx_Bbs++] = "			<li class=\"review-item__noresult\">등록된 상품평이 없습니다</li>";
		}
		vHtml_Bbs[vHidx_Bbs++] = "			</ul>";
		if (obj.iTotalCnt > 30 && vList.length > 0) {
			vHtml_Bbs[vHidx_Bbs++] = "		<button class=\"minvip__btn--more\" id=\"bbs__btn--more\">더보기</button>";
		}
		vHtml_Bbs[vHidx_Bbs++] = "	</div>";
		vHtml_Bbs[vHidx_Bbs++] = "</div>";
		vHtml_Bbs[vHidx_Bbs++] = "<div class=\"ad-minvip-powerlink\"></div>";

		$minVipContent.html(vHtml_Bbs.join(""));

		// 파워링크
		if (listType == "list") {
			getPowerLink("MINIVIP", param_cate, param_inKeyword);
		} else {
			getPowerLink("MINIVIP", param_cate, param_keyword);
		}
	}

}

// 댓글 삭제 
function miniVipBbsDelete(delno) {
	var $del_pass = $("#del_pass");
	if ($del_pass.val() == "" && !$del_pass.val().length > 0) {
		alert("비밀번호가 정확하지 않습니다.");
		$del_pass.focus();
		return;
	}

	$.ajax({
		type: "post",
		url: "/wide/api/product/prodBbsList.jsp",
		data: {
			"pType": "GD",
			"modelno": miniVipModelNo,
			"no": delno,
			"delpass": $del_pass.val()
		},
		dataType: "JSON",
		success: function(result) {
			var vFlag = result.data.flag;
			if (vFlag) {
				alert("선택하신 글이 삭제되었습니다.");
				loadBbs();
			} else {
				alert("비밀번호가 정확하지 않습니다.");
			}
		},
		error: function(request, status, error) {
			//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});

	$("#bbsDelLayer").hide();
}

// 댓글 저장
var insertFlag = true;
function miniVipBbsInsert() {
	var $gbContent = $("#gbContent");
	if (miniVipIsLogin() == false) {
		var rtnUrl = document.location.href + "&mvShowModelno=" + miniVipModelNo + "&miniVipTab=3";
		Cmd_Login('miniBbs', rtnUrl);
	} else {
		if (!insertFlag) {
			alert("등록중입니다. 잠시만 기다려주세요.");
			return;
		}

		if ($gbContent.val() == "") {
			alert("내용을 입력해 주세요.");
			$gbContent.focus();
			return;
		}

		$gbContent.val($gbContent.val().replaceAll("&", "&amp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\"", "&quot"));

		if ($gbContent.val().length >= 2000) {
			alert("2000자 이상은 입력 하실 수 없습니다.");
			$gbContent.focus();
			return;
		} else if ($gbContent.val().length < 5) {
			alert("5자 이상 내용을 입력하셔야 등록이 가능합니다.");
			$gbContent.focus();
			return;
		}

		insertFlag = false;
		//var strContents = encodeURIComponent($("#gbContent").val(), "UTF-8");
		var strContents = $gbContent.val();
		$.ajax({
			type: "POST",
			url: "/wide/api/product/prodBbsList.jsp",
			data: {
				"pType": "GI",
				"modelno": miniVipModelNo,
				"contents": strContents,
			},
			dataType: "JSON",
			success: function(result) {
				insertFlag = result.data.flag;
				if (result.data.flag) {
					$gbContent.val("");
					alert("정상적으로 저장 되었습니다.");
					loadBbs();
				} else {
					alert("저장 실패 하였습니다.");
				}
			},
			error: function(request, status, error) {
				//console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
}

function miniVipBbsLogin() {
	if (miniVipIsLogin() == false) {
		var rtnUrl = document.location.href + "&mvShowModelno=" + miniVipModelNo + "&miniVipTab=3";
		Cmd_Login('miniBbs', rtnUrl);
	}
}

function miniVipIsLogin() {
	var cName = "LSTATUS";
	var s = document.cookie.indexOf(cName + '=');
	if (s != -1) {
		s += cName.length + 1;
		e = document.cookie.indexOf(';', s);
		if (e == -1) {
			e = document.cookie.length
		}
		if (unescape(document.cookie.substring(s, e)) == "Y") {
			return true;
		} else {
			return false;
		}
	} else {
		return false;
	}
}

// 미니VIP API 호출 실패
function failMiniVip(errorObj) {
	console.log("[miniVIP call fail] : " + errorObj.statusText);
}

// 미니VIP 위치 조정
function openMiniVip() {

	var $minVip = $('#miniVIP_AREA'); // MiniVip Wrapper

	// 일반 리스트형 > 가격 옵션 클릭 시, miniVip 노출
	$(".lay-minvip").show(0, function() {
		var $body = $(".list-body");
		var $minVip = $('.lay-minvip'); // MiniVip Wrapper
		var $minVipHead = $(".minvip__head"); // MiniVIP 상단
		var $minVipTab = $(".minvip__tab"); //MiniVIP 탭
		var $minVipContent = $(".minvip__cont"); // MiniVIP 컨텐츠 영역
		var resizeMinVip = function() {

			var scroll = $(window).scrollTop(),
				bodyT,
				bodyH,
				winH = $(window).height(), // 스크린 Y 크기
				distT = 70; // 상단과 FIXED 될 거리

			if ($minVip.is(":visible")) {
				var boxH = $minVip.outerHeight();
				var headH = $minVipHead.outerHeight();
				var tabH = $minVipTab.outerHeight();
				$minVipContent.height(boxH - headH - tabH - 38);
				if ($body.length) {
					bodyT = $body.offset().top; // 컨테이너 Position Top
					bodyH = $body.outerHeight(); // 컨테이너 높이
					if (scroll > bodyT - distT) {
						if (scroll > bodyT + bodyH - boxH - distT) {
							$minVip.css("right", "-100%");
						} else {
							$minVip.removeAttr("style").addClass("is--fixTop").height(winH - distT - 50);
						}
					} else {
						$minVip.removeClass("is--fixTop");
					}
				}
			}
		}
		//실행
		resizeMinVip();

		$(window).on({
			"load": resizeMinVip,
			"scroll": resizeMinVip,
			"resize": resizeMinVip
		})
		$minVipContent.on({
			"scroll": resizeMinVip
		})
	})

	// 파워링크
	if (listType == "list") {
		getPowerLink("MINIVIP", param_cate, param_inKeyword);
	} else {
		getPowerLink("MINIVIP", param_cate, param_keyword);
	}
	miniVipEvent();
}

// 미니vip 이벤트리스너
function miniVipEvent() {
	if (!miniVipEventBool && miniVipModelNo > 0) {

		miniVipEventBool = true; // 이벤트리스너는 최초에만 받아들임

		// 탭 클릭, 정렬 변경
		$(document).on("click", ".minvip__tabitem a", function(e) {
			e.preventDefault();
			var ta = $(this).attr("data-show-tab");
			var $minVipCont = $(".minvip__cont");
			$(this).parent().addClass("is--on").siblings().removeClass("is--on");
			$minVipCont.find(".minvip__tabcont").hide();
			$minVipCont.find("." + ta).show();
			$minVipCont.scrollTop(0);
		});

		$(document).on("click", "#priceComTab .list-filter > div > input", function(e) {
            var $id = $(this).attr('id');
            var val = 'N';

            if($(this).is(':checked') === true) val = 'Y';

            if($id === 'cardsaleInc'){
                param.card = val;

				(val === 'Y')
				? vPriceTabType = 'card'
				: vPriceTabType = '';
            }else if($id === 'deliveryInc'){
				param.delivery = val;
				
				(val === 'Y')
				? vPriceTabType = 'delivery'
				: vPriceTabType = '';
            }

            loadPrice();
        });
		$(document).on("click", "#priceComTab.minvip__tabitem a", function(e) {
			loadPrice();
			insertLogLSV(15386);
		});
		//상품설명 탭 클릭
		$(document).on("click", "#prodDescTab", function() {
			loadDesc();
			insertLogLSV(15387);
		});

		//상품평 탭 클릭
		$(document).on("click", "#prodBbsTab", function() {
			loadBbs();
			insertLogLSV(15388);
		});

		//상품평 로그인
		$(document).on("click", "#btn_login", function() {
			miniVipBbsLogin();
		});

		// 더보기 클릭
		$(document).on("click", ".minvip__btn--more", function() {
			window.open("/detail.jsp?modelno=" + miniVipModelNo);
			return false;
		});

		//상품평 로그인
		$(document).on("click", "#btn_login", function() {
			miniVipBbsLogin();
		});

		//상품평 등록
		$(document).on("click", "#gbBtnWrite", function() {
			miniVipBbsInsert();
			insertLogLSV(15392);
		});

		//삭제 레이어 오픈
		$(document).on("click", ".review__btn--delete", function() {
			var vDelNo = $(this).data("no");
			if (mini_SNSTYPE == "K" || mini_SNSTYPE == "N") { //sns삭제는 비밀번호 입력X, 바로 삭제
				if (confirm("삭제하시겠습니까?")) {
					miniVipBbsDelete(vDelNo);
				} else {
					return;
				}
			} else {
				$("#del_pass").val("");
				$(".delete__form--btn").attr("data-no", vDelNo);
				$("#bbsDelLayer").attr("style", "display:block;");
			}
		});

		//삭제 레이어 삭제 버튼
		$(document).on("click", ".delete__form--btn", function() {
			miniVipBbsDelete($(this).attr("data-no"));
		});

		//작성자 정보 레이어
		$(document).on("click", ".review-user__id", function() {
			$("#membInfoLayer").show();
			$("#membInfoLayer h5 strong").html(mini_sUserId);
			insertLogLSV(15393);
		});

		//쇼핑몰명 클릭시 로그
		$(document).on("click", ".price-tb__mall", function() {
			insertLogLSV(15062);
		});

		//상품가격 클릭시 로그
		$(document).on("click", ".price-tb__item--price", function() {
			insertLogLSV(15063);
		});

		$(document).on("click", ".price-tb__item, .similar__item", function() {
			insertLogLSV(15075);
		});

		// 신고 버튼 클릭
		$(document).on("click", "button.minvip__btn--singo", function() {
			insertLogLSV(15044);

			var thisObj = $(this);

			$.ajax({
				url: "/lsv2016/ajax/AjaxInconv.jsp",
				data: "modelno=" + miniVipModelNo + "&type=2",
				dataType: "HTML",
				type: "get",
				success: function(result) {
					var div_inconvObj = $("#div_inconv");
					div_inconvObj.html(result);

					var lStyle = "";
					lStyle += "position:absolute;";
					lStyle += "z-index:9999;";
					lStyle += "top:" + (thisObj.offset().top + thisObj.height() + 4) + "px;";
					lStyle += "left:" + (thisObj.offset().left - div_inconvObj.width() + thisObj.width() + 4) + "px;";

					div_inconvObj.attr("style", lStyle);

					div_inconvObj.fadeIn();

				},
				error: function(request, status, error) {
					//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
			$("#divConvLayer2 .end").click(function() {
				insertLogLSV(14306);
			});
		});
	}

	miniVipResize();
}

function miniVipResize() {
	var $body = $(".list-body");
	var $minVip = $('.lay-minvip'); // MiniVip Wrapper
	var $minVipHead = $(".minvip__head"); // MiniVIP 상단
	var $minVipTab = $(".minvip__tab"); //MiniVIP 탭
	var $minVipContent = $(".minvip__cont"); // MiniVIP 컨텐츠 영역
	var resizeMinVip = function() {

		var scroll = $(window).scrollTop(),
			bodyT,
			bodyH,
			winH = $(window).height(), // 스크린 Y 크기
			distT = 70; // 상단과 FIXED 될 거리

		if ($minVip.is(":visible")) {
			var boxH = $minVip.outerHeight();
			var headH = $minVipHead.outerHeight();
			var tabH = $minVipTab.outerHeight();
			$minVipContent.height(boxH - headH - tabH - 38); //최소높이 잡고, 계산한게 최소보다 작으면 최소높이값으로
			if ($body.length) {
				bodyT = $body.offset().top; // 컨테이너 Position Top
				bodyH = $body.outerHeight(); // 컨테이너 높이
				if (scroll > bodyT - distT) {
					if (scroll > bodyT + bodyH - boxH - distT) {
						$minVip.css("right", "-100%");
					} else {
						$minVip.removeAttr("style").addClass("is--fixTop").height(winH - distT - 50);
					}
				} else {
					$minVip.removeClass("is--fixTop");
				}
			}
		}
	}
	//실행
	resizeMinVip();

	$(window).on({
		"load": resizeMinVip,
		"scroll": resizeMinVip,
		"resize": resizeMinVip
	})
	$minVipContent.on({
		"scroll": resizeMinVip
	})
}