// 기본 이미지
var defaultImgUrl = "http://img.enuri.info/images/home/reborncar/img_default.gif";
var defaultImgUrlMo = "http://img.enuri.info/images/home/reborncar/img_default.gif";

// 중고차 이미지 url 가져오기
// 작은 이미지가 있을 경우 작을 이미지를 가져온다.
// 업체코드, 상품코드, 원본이미지URL, 상태값
function getResellCarImageUrl(spm_cd, gd_cd, url, state) {
	var retUrl = url;
	if(spm_cd && parseInt(spm_cd)>0 && gd_cd && gd_cd.length > 0 && state && parseInt(state) == 2) {
		var imgServerPath = "http://storage.enuri.info/car/photo/";
		retUrl = imgServerPath + spm_cd + "/" + gd_cd + "_s";
	}
	return retUrl;
}

// PC 렌더링될 html을 그린다.
function drawResellCarObj(listObj) {
	if(!listObj || listObj.length == 0) return;

	var retHtml = "";

	$.each(listObj, function(index, obj){
		var item = obj._source;

		/* -- Data Set */
		var spmCd = item.spm_cd; // 쇼핑몰코드
		var gdCd = item.gd_cd; // 상품코드
		var srvStCd = item.srv_st_cd; // 서비스상태코드
		var mkrNo = item.mkr_no; // 제조사번호
		var carNo = item.car_no; // 차량번호
		var carDtlNo = item.car_dtl_no; // 차량모델번호
		var carDtlNm = item.car_dtl_nm; // 차량모델명
		var pcUrl = item.pc_url; // PC URL`
		var moblUrl = item.mobl_url; // 모바일 URL
//		var imgUrl = getResellCarImageUrl(item.spm_cd, item.gd_cd, item.img_url, item.img_st_cd); // 이미지 URL
		var imgUrl = item.img_make_url; // 이미지 URL
		var salPrc = item.sal_prc; // 판매가격
		var leasePrc = item.lease_prc; // 리스가격
		var leaseMnth = item.lease_mnth; // 리스개월수
		var inspPrc = item.insp_prc; // 할부가격
		var inspMnth = item.insp_mnth; // 할부개월수
		var opnPrc = item.opn_prc; // 출시가격
		var dsplvl = item.dsplvl + "cc"; // 배기량
		var fuelSpecNo = item.fuel_spec_no; // 연료스펙번호
		var fuelSpecNm = item.fuel_spec_nm; // 연료명
		var gearboxSpecNo = item.gearbox_spec_no; // 변속기스펙번호
		var carColr = item.car_colr; // 차량색상
		var yridnw = item.yridnw + "년"; // 연식
		var frstRegYm = item.frst_reg_ym; // 최초등록년월
		if(frstRegYm && frstRegYm.length==6) {
			frstRegYm = frstRegYm.substring(0,4) + "년" + frstRegYm.substring(4,6) + "월";
		}
		var drvngDstnc = item.drvng_dstnc.format() + "km"; // 주행거리
		var carJdgmntGrad = item.car_jdgmnt_grad; // 차량판정등급
		var carNoplt = item.car_noplt; // 차량번호판
		var salAdrSiSpecNo = item.sal_adr_si_spec_no; // 판매지역 시 스펙번호
		var salAdrSiSpecNm = item.sal_adr_si_spec_nm; // 판매지역 시 명
		var salAdrGuSpecNo = item.sal_adr_gu_spec_no; // 판매지역 구 스펙번호
		var salAdrGuSpecNm = item.sal_adr_gu_spec_nm; // 판매지역 구 명
		var salAdr = salAdrSiSpecNm + " " + salAdrGuSpecNm; // 시 + 구
		var seaterSpecNo = item.seater_spec_no; // 인승 스펙번호
		var door = item.door; // 창문갯수
		var extintOptnYn = item.extint_optn_yn; // 외관/내장 옵션여부
		var safeOptnYn = item.safe_optn_yn; // 안전옵션 여부
		var cnvncOptnYn = item.cnvnc_optn_yn; // 편의옵션 여부
		var seatOptnYn = item.seat_optn_yn; // 시트옵션 여부
		var insDtm = item.ins_dtm; // 입력일시
		var updDtm = item.upd_dtm; // 수정일시
		var carDisplayName = item.mkr_nm + " " + item.car_nm; // 노출차량명
		var productThumbnail = "http://img.enuri.info/images/home/reborncar/ico_reborncar.jpg"; // 업체썸네일이미지
		var productAlt = "reborncar"; // 업체명
		// 20200611. Acar 추가
		if(spmCd == "17883" ) {
			productThumbnail = "http://img.enuri.info/images/home/reborncar/ico_acar.jpg";
			productAlt = "acar"; 
		}

		retHtml += "<li class=\"prodItem ty_reborn\">";
		retHtml += "	<div class=\"thum_area\">";
		retHtml += "		<a href=\"javascript:goResellCarItem('"+gdCd+"','"+spmCd+"','"+pcUrl+"');\">";
		retHtml += "			<img class=\"lazy\" src=\""+imgUrl+"\" style=\"display: inline;\" onerror=\"this.src='"+defaultImgUrl+"'\">";
		retHtml += "		</a>";
		retHtml += "	</div>";
		retHtml += "	<div class=\"info_area\">";
		retHtml += "		<strong>";
		retHtml += "			<a href=\"javascript:goResellCarItem('"+gdCd+"','"+spmCd+"','"+pcUrl+"');\" class=\"prodName\">";
		retHtml += "				<span class=\"txt_name\">"+carDisplayName+"</span>";
		retHtml += "				<span class=\"txt_model\">"+carDtlNm+"</span>";
		retHtml += "			</a>";
		retHtml += "		</strong>";
		retHtml += "		<dl class=\"specinfo\">";
		retHtml += "			<dt>연식</dt>";
		retHtml += "			<dd>"+yridnw+"</dd>";
		retHtml += "			<dt>주행거리</dt>";
		retHtml += "			<dd>"+drvngDstnc+"</dd>";
		retHtml += "			<dt>연료</dt>";
		retHtml += "			<dd>"+fuelSpecNm+"</dd>";
		retHtml += "			<dt>배기량</dt>";
		retHtml += "			<dd>"+dsplvl+"</dd>";
		retHtml += "			<dt>색상</dt>";
		retHtml += "			<dd>"+carColr+"</dd>";
		retHtml += "		</dl>";
		retHtml += "		<div class=\"tagarea\">";
		retHtml += "			<span class=\"tx\">등록일 : "+frstRegYm+"</span>";
		retHtml += "			<span class=\"tx\">위치 : "+salAdr+"</span>";
		retHtml += "			<span class=\"tx\">차량번호 : "+carNoplt+"</span>";
		retHtml += "		</div>";
		retHtml += "	</div>";
		retHtml += "	<div class=\"price_area\" systemtext=\"\">";
		retHtml += "	판매가 <strong>"+salPrc.format()+"</strong>원";
		retHtml += "		<span class=\"release_price\"><span class=\"txt_price\"><b>"+opnPrc.format()+"</b>원</span></span>";
		retHtml += "		<span class=\"won_mall\">";
		retHtml += "			<div class=\"won_line\">";
		retHtml += "				<a href=\"javascript:goResellCarItem('"+gdCd+"','"+spmCd+"','"+pcUrl+"');\">";
		retHtml += "					<img src=\""+productThumbnail+"\" alt=\""+productAlt+"\">";
		retHtml += "				</a>";
		retHtml += "			</div>";
		retHtml += "		</span>";
		retHtml += "	</div>";
		retHtml += "</li>";
	});

	return retHtml;
}

///////////////////////////////////////////// 중고차 SRP 시작 /////////////////////////////////////////////

//중고차 리스트 불러오기
//search.js 에서 호출됨
function loadResellCarList(page) {
	loadingShow();

	if(orderNum == 0) {
		orderNum == 1;
	}
	var pKeyword = gKeyword;
	// 결과내 검색어 가 있을 경우 조합하여 파라미터로 전달한다.
	// ex ) '자전거' 검색후 결과내 검색으로 '체인' 이라면 '자전거 체인'
	if(gIn_keyword.length > 0) {
		pKeyword = gKeyword + " " + gIn_keyword;
	}

	/*
	var params = {
		"sort" : orderNum,
		"pageNum" : page,
		"pageGap" : pageGap,
		"keyword" : pKeyword
	};
	*/

	// 현재 페이지를 지정
	if(page>0) pageNum = page;

	var promiseObj = $.ajax({
		type : "GET",
		url : "/lsv2016/ajax/getCarSearch_ajax.jsp?keyword=" + encodeURIComponent(pKeyword) + "&pageNum=" + page + "&pageGap=" + pageGap + "&sort=" + orderNum,
		dataType : "json"
	});
	promiseObj.then(setloadRebornCarGoodsListView);
}


//중고차 가 검색어결과에 포함되어있는지 확인한다.
//20191127 jinwook
function checkCountRebornCar(data) {
	if(data && data.hits.total.value && parseInt(data.hits.total.value) > 0) {
		$(".rebornCarList").show();
	} else {
		$(".rebornCarList").hide();
		return;
	}
}

//중고차 조건 세팅
//20191127 jinwook
function setOrderLinksRebornCar() {
	var orderDivObj = $('#goods_tab05');

	$("#listOrderDiv").hide();
	$("#newListDiv").hide();
	orderDivObj.show();
	$("#listShowTypeDiv .noShowNormalProd").hide();
	$(".view_choice .list_type").hide();

	orderDivObj.find(".orderLinkSpan").click(function() {

		var idx = $(this).attr("idx");
		orderNum = idx;

		var lastUrl = getLastUrl("page");
		lastUrl = getLastUrlText("order", lastUrl);
		var titleText = getTitleText(1);
		History.pushState({page:1,tabType:tabType,orderNum:orderNum}, titleText, lastUrl+"&page=1&order="+orderNum);

		var intIdx = 0;
		var linkSpanObj = orderDivObj.find(".orderLinkSpan");

		try {
			if(idx) intIdx = parseInt(idx);
		} catch(e) {}

		for(var i=1; i<=linkSpanObj.length; i++) {
			if(i==intIdx) {
				$("#goods_tab05 .orderLinkSpan[idx=" + i + "]").addClass("on");
			} else {
				$("#goods_tab05 .orderLinkSpan[idx=" + i + "]").removeClass("on");
			}
		}

//		setOrderBtnLogs(idx);

	});
}

//중고차 리스트를 실제로 보여줌
function setloadRebornCarGoodsListView(data) {

	if(!data || data === null || !data.hits) return;

	var rebornCarListBodyDivObj = $("#rebornCarListBodyDiv");
	rebornCarListBodyDivObj.empty();

	var obj = data.hits;
	var totalCnt = obj.total.value;
	var listObj = obj.hits;

	var allCnt = 0;

	try {
		if(totalCnt) allCnt = parseInt(totalCnt);
	} catch(e) {}

	var goods_tab05Obj = $("#goods_tab05");
	if(allCnt==0) {
		setNoDataBodyObject(goods_tab05Obj);
	} else {
		showHideBodyObject(goods_tab05Obj);
	}

	var html = [];
	var hIdx = 0;

	var showItemCnt = 0;
	if(listObj) {
		var html = drawResellCarObj(listObj);
		pagingInfoShow();
		if(html.length > 0) {
			rebornCarListBodyDivObj.html(html);
		}
	}

	// 이미지 보여주기
	$("img.lazy").lazyload();

	loadingHide();

	itemTotalCnt = allCnt;
	itemTotalPageCnt = Math.ceil(itemTotalCnt/pageGap);

	setPagingTagWrap();
}


//모바일 리스트 불러오기 - 개편
function loadResellcarListMobile(){
	// 200224 모바일웹 개편 test #searchtxt이 없음
	//var keyword = $("#searchtxt").val().trim();
	var keyword = vAllKeyword.trim();
	var promiseObj = $.ajax({
		type : "GET",
		url : "/lsv2016/ajax/getCarSearch_ajax.jsp?keyword=" + keyword + "&pageNum=1&pageGap=10&sort=1",
		dataType : "json"
	});

	promiseObj.then(setListViewMobile);
}

//모바일 리스트 그리기 - 개편
function setListViewMobile(data) {
	if(!data || !data.hits.total.value || data.hits.total.value==0 ) return;

	$(".m_reborn").show();

	var rHtmlObj = $(".m_reborn .swiper-wrapper");
	var listObj = data.hits.hits;
	var rHtml = "";

	// <!-- 상품 타입 -->
	$.each(listObj, function(index, obj){
		var item = obj._source;

		/* -- Data Set */
		var spmCd = item.spm_cd; // 쇼핑몰코드
		var gdCd = item.gd_cd; // 상품코드
		var srvStCd = item.srv_st_cd; // 서비스상태코드
		var mkrNo = item.mkr_no; // 제조사번호
		var carNo = item.car_no; // 차량번호
		var carDtlNo = item.car_dtl_no; // 차량모델번호
		var carDtlNm = item.car_dtl_nm; // 차량모델명
		var pcUrl = item.pc_url; // PC URL
		var moblUrl = item.mobl_url; // 모바일 URL
//		var imgUrl = getResellCarImageUrl(item.spm_cd, item.gd_cd, item.img_url, item.img_st_cd); // 이미지 URL
		var imgUrl = item.img_make_url; // 이미지 URL
		var salPrc = Math.floor(item.sal_prc/10000); // 판매가격
		var leasePrc = item.lease_prc; // 리스가격
		var leaseMnth = item.lease_mnth; // 리스개월수
		var inspPrc = item.insp_prc; // 할부가격
		var inspMnth = item.insp_mnth; // 할부개월수
		var opnPrc = Math.floor(item.opn_prc/10000); // 출시가격

		var dsplvl = item.dsplvl + "cc"; // 배기량
		var fuelSpecNo = item.fuel_spec_no; // 연료스펙번호
		var fuelSpecNm = item.fuel_spec_nm; // 연료명
		var gearboxSpecNo = item.gearbox_spec_no; // 변속기스펙번호
		var carColr = item.car_colr; // 차량색상
		var yridnw = item.yridnw + "연식"; // 연식
		var frstRegYm = item.frst_reg_ym; // 최초등록년월
		if(frstRegYm && frstRegYm.length==6) {
			frstRegYm = frstRegYm.substring(0,4) + "년" + frstRegYm.substring(4,6);
		}
		var drvngDstnc = item.drvng_dstnc.format() + "km"; // 주행거리
		var carJdgmntGrad = item.car_jdgmnt_grad; // 차량판정등급
		var carNoplt = item.car_noplt; // 차량번호판
		var salAdrSiSpecNo = item.sal_adr_si_spec_no; // 판매지역 시 스펙번호
		var salAdrSiSpecNm = item.sal_adr_si_spec_nm; // 판매지역 시 명
		var salAdrGuSpecNo = item.sal_adr_gu_spec_no; // 판매지역 구 스펙번호
		var salAdrGuSpecNm = item.sal_adr_gu_spec_nm; // 판매지역 구 명
		var salAdr = salAdrSiSpecNm + " " + salAdrGuSpecNm; // 시 + 구
		var seaterSpecNo = item.seater_spec_no; // 인승 스펙번호
		var door = item.door; // 창문갯수
		var extintOptnYn = item.extint_optn_yn; // 외관/내장 옵션여부
		var safeOptnYn = item.safe_optn_yn; // 안전옵션 여부
		var cnvncOptnYn = item.cnvnc_optn_yn; // 편의옵션 여부
		var seatOptnYn = item.seat_optn_yn; // 시트옵션 여부
		var insDtm = item.ins_dtm; // 입력일시
		var updDtm = item.upd_dtm; // 수정일시
		var carDisplayName = item.mkr_nm + " " + item.car_nm; // 노출차량명
		var displaySpmName = "리본카";
		if(spmCd == "17883") {
			displaySpmName = "A-CAR";
		}
		
		
		if(moblUrl == null || moblUrl.length == 0) {
			moblUrl = pcUrl;
		}

		rHtml = "";

		rHtml += "<div class=\"swiper-slide type_goods\">";
		rHtml += "	<a href=\"javascript:goResellCarItem('"+gdCd+"','"+spmCd+"','"+moblUrl+"');\">";
		rHtml += "		<span class=\"thumb\"><img src=\""+imgUrl+"\" alt=\"\" onerror=\"this.src='"+defaultImgUrlMo+"'\"></span>";
		rHtml += "		<span class=\"info\">";
		rHtml += "			<span class=\"txt_mall\">"+displaySpmName+"</span>";
		rHtml += "			<span class=\"txt_name\">";
		rHtml += "				<span class=\"name\">"+carDisplayName+"</span>";
		rHtml += "				<span class=\"model\">"+carDtlNm+"</span>";
		rHtml += "			</span>";
		rHtml += "			<span class=\"txt_spec\">";
		rHtml += "				<span class=\"item\">"+yridnw+"</span><span class=\"item\">"+drvngDstnc+"</span><span class=\"item\">"+fuelSpecNm+"</span>";
		rHtml += "			</span>";
		rHtml += "			<span class=\"txt_price\">";
		rHtml += "				<span class=\"org_price\"><em>"+opnPrc.format()+"</em>만원</span>";
		rHtml += "				<span class=\"sell_price\">";
		rHtml += "					<span class=\"txt\">판매가</span><em>"+salPrc.format()+"</em>만원";
		rHtml += "				</span>";
		rHtml += "			</span>";
		rHtml += "		</span>";
		rHtml += "	</a>";
		rHtml += "</div>";

		rHtmlObj.append(rHtml);
	});

	// <!-- 배너 타입 -->
	callBannerMobile();
	/*
	rHtml = "";
	rHtml += "<div class=\"swiper-slide type_bnr\">";
	rHtml += "	<a href=\"/enuricar/m/list.jsp\" style=\"background-color:#e9f0ff;background-image:url(http://img.enuri.info/images/home/reborncar/m_bnr_reborn_main.jpg)\">";
	rHtml += "		상담신청만 해도 e머니 10,000점 지급!";
	rHtml += "	</a>";
	rHtml += "</div>";
	rHtmlObj.append(rHtml);*/

	
}

// 모바일 배너광고 호출
function callBannerMobile() {
	var reqUrl = "http://ad-api.enuri.info/enuri_M/m_main/MR1/bundle?bundlenum=10";
	var promise = $.ajax({
		type : "GET",
		url : reqUrl,
		dataType : "json"
	});
	setTimeout(function() { promise }, 0);
	
	promise.done(drawBannerMobile);
	promise.fail(failBannerMobile);
}

// 모바일 배너광고 그리기
function drawBannerMobile(banner) {
	
	banner = banner[0];
	
	var bannerObj = $(".m_reborn .swiper-wrapper");
	var banHtml = "";
	var banImg = banner["IMG1"];
	var banUrl= banner["JURL1"];
	var banTarget = banner["TARGET"];
	var banAlt = banner["ALT"];

	if (banUrl != "" && banTarget != "" ) {
		
		banHtml += "<div class=\"swiper-slide type_bnr\">";
		if( banTarget == 2 ) {
			banHtml += "	<a href=\""+ banUrl + "\" style=\"background-image:url("+banImg+")\">";
		} else {
			banHtml += "	<a href=\""+ banUrl + "\" style=\"background-image:url("+banImg+")\" target=\"_blank\">";
		}
		banHtml += "	</a>";
		banHtml += "</div>";
	}
	if(banHtml.length>0) {
		bannerObj.append(banHtml);
		swiperCall();
	}
}

// 모바일 배너광고 호출실패
function failBannerMobile(banner) {
	console.log( "banner called failed");
	swiperCall();
}

function swiperCall() {
	var mySwiper = Swiper('.m_reborn .swiper-container',{
		prevButton : '.m_reborn .swiper-button-prev',
		nextButton : '.m_reborn .swiper-button-next',
		spaceBetween : 10,
		slidesPerView : 2,
		breakpoints : {
			767 : {
				slidesPerView : 'auto'
			}
		},
		loop : true
	});

	$("#loadingLayer").hide();
}

// 브릿지 페이지 이동
function goResellCarItem(gdCd, spmCd, url) {
	if(!gdCd || !url || !spmCd || gdCd.length == 0 || spmCd.length ==0 || url.length == 0) return;

	var varRanUrl = "/move/Redirect_resellcar.jsp?gd_cd="+gdCd+"&spm_cd="+spmCd+"&url="+encodeURIComponent(url)+"&freetoken=outbrowser";
	window.open(varRanUrl, '_blank');
}
///////////////////////////////////////////// 중고차 SRP 끝 /////////////////////////////////////////////