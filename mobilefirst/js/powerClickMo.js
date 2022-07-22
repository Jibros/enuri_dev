// 소셜검색 재시도 횟수
var socialRetryCnt = 1;

//마스크 관련 추가 대응 20200305
var maskExpArray = new Array(
	"1회용 마스크","1회용마스크","3M KF94","3M 마스크","3M마스크","3M방진마스크","3중필터 일회용마스크","KF","KF 94","KF 94 마스크","KF 마스크","KF80","KF80 대형",
	"KF80 마스크","KF80 소형","KF80마스크","KF94","KF94 대형","KF94 마스크","KF94 마스크 100매","KF94마스크","KF94마스크 100매","KF94마스크 대형","KF99 마스크",
	"KF마스크","KN95 마스크","N95","N95 마스크","덴탈 마스크","덴탈마스크","마스크 100매","마스크 50매","마스크 94","마스크 KF","마스크 KF80","마스크 KF80 대형","마스크 KF94",
	"마스크 KF94 대형","마스크 대형","마스크 소형","마스크 정전기 필터","마스크 필터","마스크 필터 원단","마스크94","마스크KF94","마스크원단","마스크팩100장","마스크필터","마스크필터원단",
	"면마스크","미세먼지 마스크","미세먼지 마스크 KF80","미세먼지 마스크 KF94","미세먼지마스크","방역마스크","방진마스크","배기밸브 마스크","샤오미 마스크","아에르마스크","웰킵스",
	"웰킵스 KF94","웰킵스 마스크","웰킵스마스크","위생마스크","유한킴벌리 덴탈마스크","유한킴벌리 마스크","유한킴벌리덴탈마스크","의료용 마스크","의료용마스크","일회용 마스크","일회용 마스크 50매",
	"일회용마스크","일회용마스크100매","일회용마스크50매","천마스크","크리넥스 마스크","크린가드 마스크","필터 마스크","필터 면마스크","필터교체 마스크","필터교체형 마스크","황사마스크 KF80",
	"황사마스크 KF94","황사마스크KF94","1636"
);

//  /mobilefirst/edplatform/ebay_cpc.jsp 에서 호출됨.

// 중단 기본 구조 
function initCenterPowerClick() {
	var adHtml = "";
	adHtml += "	<li class=\"powerclick\" style=\"display:none\">";
	adHtml += "		<div class=\"comm_ad ad_powerclick mobile\"  data-type=\"center\">";
	adHtml += "			<div class=\"comm_ad_tit\">";
	adHtml += "				<em>파워클릭</em>";
	adHtml += "				<a href=\"javascript:///\" class=\"comm_btn_apply cpcgo\" id=\"cpcgoList\">신청하기</a>";
	adHtml += "			</div>";
	adHtml += "			<div class=\"comm_ad_list ad_goods\">";
	adHtml += "				<ul id=\"lp_ebaycpc\">";
	// 광고 상품 1개  x 4 반복 
	adHtml += "				</ul>";
	adHtml += "			</div>";
	adHtml += "		</div>";
	adHtml += "	</li>";
	return adHtml;
}

// 파워클릭 마크업
// object : connectApi2 콜백 객체
// keyword: : 검색어
// ca_code : 카테고리 ( srp 는 첫번째 상품의 카테고리  )
// listType : LP/SRP
function drawPowerClick(object, keyword, ca_code, boolAdult, listType) {
	
	var cHtml = ""; //Center Html
	var bHtml = ""; //Bottom Html
	var itemCnt = object.length; //ebay cpc 상품 갯수. 10개가 되지 않으면 소셜상품을 붙여넣는다.
	var cCnt = 0;
	var bCnt = 0;
	
	// 1636 이하 카테고리 미노출 
	if (  ca_code.indexOf("1636") > -1 ) {
		isSGArr = false;
	}
	
	// maskExpArray 에 속한 키워드일 경우 미노출
	if (  $.inArray(keyword, maskExpArray) > -1 ) {
		return;
	}
	
	for(var i=0; i<itemCnt; i++) {
		// 중단 cHtml 
		if(i<4) {
			if( i==0 ) {
				cHtml += "[";
			}
			cHtml += JSON.stringify(object[i]);
			if( i == itemCnt-1 || i ==3 ) {
				cHtml += "]";
			} else {
				cHtml += ",";
			}
			
			cCnt++;
		// 하단 bHtml
		} else {
			if( i==4 ) {
				bHtml += "[";
			}
			bHtml += JSON.stringify(object[i]);
			if( i == itemCnt-1 || i == 9 ) {
				bHtml += "]";
			} else {
				bHtml += ",";
			}
			
			bCnt++;
		}
	}
	
	// 중단 마크업 함수 호출
	if(cCnt>0) {
		if(cHtml.length > 0) {
			drawCenterPowerClick(JSON.parse(cHtml), boolAdult, listType);
		}
	}
	
	// 하단 마크업 함수 호출
	if(bHtml.length > 0) {
		drawBottomPowerClick(JSON.parse(bHtml), keyword, ca_code, boolAdult, listType );
	} else {
		drawBottomPowerClick(null, keyword, ca_code, boolAdult, listType);
	}
}
// 파워클릭 중단 마크업 함수
function drawCenterPowerClick(obj, boolAdult, listType) {

	var displayCnt = 4;
	
	if(!obj || obj.length == 0) {
		return;
	}
	
	var target = $("li.powerclick");
	drawCommon(target, obj, listType, "center");
	
}


//파워클릭 하단 마크업 함수
function drawBottomPowerClick(obj, keyword, ca_code, boolAdult, listType) {
	
	var displayCnt = 6; // 하단에 보여지는 광고상품수
	var ebayCnt = obj != null ? obj.length : 0; // ebay 상품갯수
	var socialCnt = displayCnt - ebayCnt; // 소셜상품수
	var target = $("div.ad_powerclick[data-type=bottom]");

	drawCommon(target, obj, listType, "bottom");
}

// 공통 마크업
// position : center, bottom 
function drawCommon(target, obj, listType, position) {
	var targetUl = $(target).find("ul");
	var emptyImg = "http://img.enuri.info/images/home/thum_none.gif";
	var adultImg = "http://imgenuri.enuri.gscdn.com/images/mobilenew/images/img_19.jpg";
	var adHtml = "";
	targetUl.empty();
	var drawCnt = 0;
	if(obj && obj.length >  0) {
		$.each(obj, function(index, item) {
			// mobilefirst/ebay_cpc.jsp line 237 에 삽입됨.
			if(item.enuri_pl_no) {
				adHtml += "	<li data-type=\"cpc\" class=\"swiper-slide\" data-log=\""+item.clk_t+"\" data-id=\""+item.enuri_pl_no+"\">";
			} else {
				adHtml += "	<li data-type=\"cpc\" class=\"swiper-slide\" data-log=\""+item.clk_t+"\" data-id=\""+item.landing+"\">";
			}
			
			adHtml += "			<a href=\""+item.landing + "\" target=\"_blank\">";
			adHtml += "				<span class=\"ad_thumb\">";
			
			if(item.is_adult && boolAdult != 1) { 
				adHtml += "				<img src=\"" + adultImg + "\" alt=\"성인인증\" onerror=\"" + emptyImg + "\">";
			} else {
				adHtml += "				<img src=\"" + item.imgS + "\" alt=\"파워클릭 광고상품\" onerror=\"" + emptyImg + "\">";
			}
			adHtml += "					<img src=\"" + item.imp_t + "\"  style=\"display:none;\" />";	//노출 스크립트
			adHtml += "				</span>";
			adHtml += "				<span class=\"ad_info\">";
			adHtml += "					<span class=\"ad_info_nm\">"+ item.title + "</span>";
	
			var displayPrice = (item.enuri_price == -1) ? item.sale_price.format() : item.enuri_price.format();
			
			adHtml += "					<span class=\"ad_info_price\">";
			adHtml += "						<em>" + displayPrice + "</em>원";
			adHtml += "					</span>";
			
			var shopNm = "";
			if (item.shopcode == "536") {
				shopNm = "G마켓";
			} else 	if (item.shopcode == "4027") {
				shopNm = "옥션";
			}
			
			adHtml += "					<span class=\"ad_info_shop\">";
			adHtml += "						<em>" + shopNm + "</em>";
			adHtml += "					</span>";
			
			var etcText = "";
			//배송비 노출 정책에 따른 로직 마켓별로 노출 Text 정책이 다름
			if (item.shipping_fee > 0) {
				if (item.shopcode == "536") {	//G마켓
					etcText = "배송비 "+ item.shipping_fee.format();
				} else if (item.shopcode == "4027") {	//옥션
					etcText = "조건부무료배송";
				}
			} else {}
				etcText = "무료배송";
			
			
			adHtml += "					<span class=\"ad_info_etc\">"; // <!-- 배송 / 쇼핑몰베스트 / 구매수량 등 -->
			adHtml += etcText;
			adHtml += "					</span>";
			adHtml += "				</span>";
			adHtml += "			</a>";
			adHtml += "		</li>";
			
			drawCnt++;
		});
		target.css("display", "block");
	}
	targetUl.append(adHtml);
	
	// 개별로그 
	if(position == "bottom") {
		targetUl.find("li[data-type=cpc]").click(function() {
			if(listType == "LP") {
				insertLogLSV(21237);
			} else if(listType == "SRP") {
				insertLogLSV(21241);
			}
		});
	}
	
	targetUl.find("li").click(function() {
		// ebay_cpc.jsp line 742
		goClk_t($(this).attr("data-log")); 
	});
	
	if( $(target).hasClass("ad_slide") ) {
		var socialCnt = 6 - drawCnt;
		
		if( socialCnt > 0 ) {
			if( listType == "LP" ) {
				getSocialLp(varEDCateCode, socialCnt);
			} else if( listType == "SRP" ) {
				getSocialSRP(keywordStr, socialCnt);
			}
		}
		
		// 하단 스와이프
		var swiper = new Swiper('.ad_powerclick.ad_slide .swiper-container', {
			scrollbar: '.ad_powerclick.ad_slide .swiper-container .swiper-scrollbar',
			scrollbarHide: false,
			slidesPerView: 'auto',
			centeredSlides: false,
			spaceBetween: 10,
			grabCursor: true
		});
	}
}

// 소셜상품 LP 가져오기
// ca_code : 카테고리
function getSocialLp(ca_code, drawCnt) {
	var socailLpObj = $.ajax({
		type:"GET",
		url: "/mobilefirst/ajax/listAjax/getListDealMini_ajax.jsp",
		data:"cate="+ca_code,
		dataType: "JSON"
	});
	
	if (  ca_code.indexOf("1636") > -1 ) {
		return;
	}
	
	socailLpObj.then(function(obj) {
		drawSocialList(obj, "LP", drawCnt)
	});
}

// 소셜상품 SRP 그리기
// keyword : 검색어
function getSocialSRP(keyword, drawCnt) {
	var params = { 
			"keyword":keyword,
			"mbId":"",
			"mobile":"M",
			"pagingRnum":"0",
			"pagingSize":"20"
		};
		var socialSRPObj = $.ajax({
			type:"POST",
			contentType: "application/json",
			url: "/deal/mobile/search.deal",
			data : JSON.stringify(params),
			dataType: "JSON"
		});
		
		if( keyword === undefined ) {
			return;
		}
		
		// maskExpArray 에 속한 키워드일 경우 미노출
		if (  $.inArray(keyword, maskExpArray) > -1 ) {
			return;
		}
		
		socialSRPObj.then(function(obj) {
			drawSocialList(obj, "SRP", drawCnt)
		});
}

// 소셜상품 그리기
function drawSocialList(obj, listType, drawCnt) {
	// 잔여 카운트 ( 6 개가 채워져야 한다 )
	
	return;
	
	var remainCnt = drawCnt;
	var swiperBool = false;
	
	var target = $("div.ad_powerclick[data-type=bottom]");
	var targetUl = target.find(".ad_goods ul");
	if(target.css("display") == "none") {
		target.css("display", "block");
		swiperBool = true;
	}
	var emptyImg = "http://img.enuri.info/images/home/thum_none.gif";
	var adHtml = "";
	var drawObj  = null;
	if( listType == "LP" ) {
		drawObj = obj.goods ? obj.goods :  null;
	} else if ( listType == "SRP" ){
		drawObj = obj.list.DS_COUPON ? obj.list.DS_COUPON : null;
	}
	
	if(drawObj && drawObj.length > 0) {
		$.each(drawObj, function(index, item) {
			
			// LP 마크업 데이터
			if( listType == "LP" ) {
				var img = item.img2;
				var companyNm = item.company; 
				var cpName = item.name;
				var cpPrice = item.price;
				var aLink = "/deal/move.html?freetoken=outlink&&cpId="+item.cp_id+"&cpUrl="+encodeURIComponent(item.url);
				var varTag = (item.rate == 0) ? "특가" : item.rate + "%";
				var varEtc = (item.cnt == "0") ? "쇼핑몰베스트" : (item.cnt + "개 구매");
				
			// SRP 마크업 데이터
			} else if( listType == "SRP" ) {
				
				if(item.cpPrice==0) {
					item.cpSalerate = 99;
				}
				
				var img = item.cpImage;
				var companyNm = item.companyNm; 
				var cpName =item.cpName;
				var cpPrice = item.cpSaleprice.format();
				var aLink = item.cpUrl;
				var varTag = (item.cpSalerate == 0 || item.cpSalerate == 99) ? "특가" : item.cpSalerate + "%";
				var varEtc = (item.cpSalecnt == 0) ? "쇼핑몰베스트" : (item.cpSalecnt.format() + "개 구매");
				
			}
			
			// 소셜 이미지 없는 경우 예외처리
			if( img.trim().length == 0 ) {
				return true;
			}
			
			adHtml = "	<li data-id=\""+aLink+"\" data-type=\"social\" class=\"swiper-slide\">";
			adHtml += "		<a href=\"" + aLink + "\" target=\"_blank;\">";
			adHtml += "			<span class=\"ad_thumb\">";
			adHtml += "				<img src=\"" + img + "\" alt=\"소셜 광고상품\" onerror=\"" + emptyImg + "\" >";
			adHtml += "			</span>";
			adHtml += "			<span class=\"ad_info\">";
			adHtml += "				<span class=\"ad_info_nm\">" + cpName + "</span>";
			adHtml += "				<span class=\"ad_info_price\">";
			adHtml += "					<span class=\"ad_price_tag\">" + varTag + "</span>"; // <!-- 특가/할인율 등 태그 -->
			adHtml += "					<em>" + cpPrice + "</em>원"; // <!-- 가격 -->
			adHtml += "				</span>";
			adHtml += "				<span class=\"ad_info_shop\">";
			adHtml += "					<em>" + companyNm + "</em>";
			adHtml += "				</span>";
			adHtml += "				<span class=\"ad_info_etc\">"; // <!-- 배송 / 쇼핑몰베스트 / 구매수량 등 -->
			adHtml += varEtc;
			adHtml += "				</span>";
			adHtml += "			</span>";
			adHtml += "		</a>";
			adHtml += "	</li>";
			
			targetUl.append(adHtml);
			
			remainCnt--;
			if(remainCnt == 0) {
				return false;
			}
		});
	}
	
	// 상품수가 3개( 남은 그릴 영역 3 개 이상 ) 
	// 가 되지 않을 경우에 파워클릭 영역 비노출
	if( remainCnt >= 3) {
		target.css("display", "none");
	}
	
	// 개별로그 
	targetUl.find("li[data-type=social]").click(function() {
		if(listType == "LP") {
			insertLogLSV(21443);
		} else if(listType == "SRP") {
			insertLogLSV(21444);
		}
	});
	
	if( swiperBool ) {
		// 하단 스와이프
		var swiper = new Swiper('.ad_powerclick.ad_slide .swiper-container', {
			scrollbar: '.ad_powerclick.ad_slide .swiper-container .swiper-scrollbar',
			scrollbarHide: false,
			slidesPerView: 'auto',
			centeredSlides: false,
			spaceBetween: 10,
			grabCursor: true
		});
	}
}