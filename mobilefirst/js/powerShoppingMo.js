// 파워쇼핑 호출함수 ( 해당 cate 가 SG인지 확인한다. )
function getPowerShopping(listType, ca_code, keyword) {
	
	// 타입 종류에 해당하지 않으면 리턴시킨다.
	var listTypeArr = new Array ( "LP", "SRP", "VIP" );
	if (  $.inArray(listType, listTypeArr) < 0 ) {
		return;
	}
	
	// S/G 일때만 네이버파워쇼핑을 호출한다.
	var firstCat = "";
	if(ca_code === undefined){
		firstCat = ca_code.substring(0,2);
	}else{
		firstCat = param_cate.substring(0,2);
	}
	
	// S/G 카테고리 Array. 앱은 category_type.json 파일을 호출한다.
	var cateSGArr = new Array ( "08", "09", "10","12", "14", "15", "16", "18", "21", "92", "93" );
	
	// S/G 카테고리 가 아닌 경우 리턴한다.
	if (  $.inArray(firstCat, cateSGArr) < 0 ) {
		return;
	}
	
	// 20200303 마스크 예외처리
	if(listType == "LP" && ca_code == "163619") {
		return;
	}
	
	
	var paramString = "type="+listType+"&device=mw&cate="+ca_code;
	if(keyword && keyword.length > 0) {
		paramString = "type=SRP&device=mw&keyword="+encodeURIComponent(keyword);
	}
	
	var powerShopObj = $.ajax({
		type:"GET",
		url: "/lsv2016/ajax/connectApiNaverShop.jsp",
		data: paramString,
		dataType: "JSON",
	});
	setTimeout(function() { powerShopObj }, 0);
	powerShopObj.then(drawPowerShopping);
}

//파워쇼핑 마크업 함수
function drawPowerShopping(obj) {
	
	// 파워쇼핑 객체가 6개가 되지 않으면 노출이 되지 않는다.
	if(!obj.ads || obj.ads.length < 6) {
		return;
	}
	
	var target = $(".ad_powershopping");
	target.css("display", "block");
	
	var targetUl = target.find(".ad_goods ul");
	var emptyImg = "http://img.enuri.info/images/home/thum_none.gif";
	var adHtml = "";
	targetUl.empty();
	$.each(obj.ads, function(index, item) {
		adHtml += "	<li class=\"swiper-slide\">";
		adHtml += "		<a href=\""+item.clickUrl + "\" target=\"_blank\">";
		adHtml += "			<span class=\"ad_thumb\">";
		adHtml += "				<img src=\"" + item.imageUrl + "\" alt=\"파워쇼핑 광고상품\" onerror=\"" + emptyImg + "\">";
		adHtml += "			</span>";
		adHtml += "			<span class=\"ad_info\">";
		adHtml += "				<span class=\"ad_info_nm\">"+ item.productTitle + "</span>";
		adHtml += "				<span class=\"ad_info_price\">";
		adHtml += "					<em>" + item.minPrice.format() + "</em>원";
		adHtml += "				</span>";
		adHtml += "				<span class=\"ad_info_shop\">";
		if(item.isNaverPayIconEnabled) {
			adHtml += "				<em class=\"ad_type_npay\">";
		}
		adHtml += item.mallName;
		if(item.isNaverPayIconEnabled) {
			adHtml += "				</em>";
		}
		adHtml += "				</span>";
		adHtml += "			</span>";
		adHtml += "		</a>";
		adHtml += "	</li>";
	});
	targetUl.append(adHtml);
	
	var swiper = new Swiper('.ad_powershopping .swiper-container', {
		scrollbar: '.ad_powershopping .swiper-scrollbar',
		scrollbarHide: false,
		slidesPerView: 'auto',
		centeredSlides: false,
		spaceBetween: 10,
		grabCursor: true
	});
	
	// 개별로그
	try{
		var objType = obj.type; // LP,SRP,VIP
		var objCate = obj.cate; // LP 카테고리
		if(objCate && objCate.length > 4) {
			objCate = objCate.substring(0,4);
		}
		targetUl.find("li").click(function() {
			if(objType == "LP") {
				insertLogLSV(21410, objCate);
			} else if(objType == "SRP") {
				insertLogLSV(21411);
			}
		});	
	}catch(e){

	}
	
}