// LP 상단 탑 배너 호출 ( T1 )
function loadLPTopBanner(cate) {
	if(cate.length>4) {
		cate = cate.substring(0,4);
	}
	
	// 리스트 API 호출
	var bannerPromise = $.ajax({
		type : "GET",
		url : "http://ad-api.enuri.info/enuri_PC/pc_lp/T1/req",
		dataType : "json",
		data : {
			"cate" : cate
		}
	});
	
	bannerPromise.then(drawLPTopBanner, failBanner);
}

// LP 상단 탑 배너 그리기 ( T1 )
var firstExpandTopAD = false;
var expandADIid = 0;
function drawLPTopBanner(dataObj) {
	
	var lpTopBannerObj = $(".lp-ad--top");
	
	if(dataObj.JURL1 !== undefined && dataObj.IMG1 !== undefined && dataObj.JURL1.length>0 && dataObj.IMG1.length>0) {
		var html = [];
		var hIdx = 0;
	
		html[hIdx++] = "<a href=\""+dataObj.JURL1+"\" target=\"_blank\">";
		html[hIdx++] = "	<img src=\""+dataObj.IMG1+"\" alt=\"LP 탑배너\" width=\"1064\" height=\"90\">";
		html[hIdx++] = "</a>";
		
		// 확장소재 있는지
		if(dataObj.IID !== undefined && dataObj.IID.length > 0) {
			html[hIdx++] = "<div class=\"expand_ad_img\"></div>";
			html[hIdx++] = "<div class=\"circle_progress s32 btn_ad_expand\">";
			html[hIdx++] = "	<span class=\"left_half\"><span class=\"bar\"></span></span>";
			html[hIdx++] = "	<span class=\"right_half\"><span class=\"bar\"></span></span>";
			html[hIdx++] = "	<div class=\"center_full\"><i class=\"lp__sprite ad_arrow_down\"></i></div>";
			html[hIdx++] = "</div>";
			loadLPTopBannerExpand();
			expandADIid = dataObj.IID;
		}
		
		lpTopBannerObj.html(html.join(""));
		lpTopBannerObj.show();
	} else {
		return;
	}
}

// LP 상단 확장 배너 호출하기
function loadLPTopBannerExpand() {
	// 리스트 API 호출
	var bannerPromise = $.ajax({
		type : "GET",
		url : "http://ad-api.enuri.info/enuri_PC/pc_lp/T1_1/bundle",
		dataType : "json",
		data : {
			"bundlenum" : "3",
			"cate" : param_cate.substring(0,4)
		}
	});
	
	bannerPromise.then(drawLPTopBannerExpand, failBanner);
}

// LP 상단 확장 배너 그리기
var LPtopBanner_expandImg;
function drawLPTopBannerExpand(dataObj) {
	
	$(dataObj).each(function(index, item) {
		
		if(expandADIid == item.IID) {

			if(item.JURL1 !== undefined && item.IMG1 !== undefined && item.JURL1.length>0 && item.IMG1.length>0 && expandADIid>0) {
				var $_target = $(".expand_ad_img");
				var html = [];
				var hIdx = 0;
				
				html[hIdx++] = "<a href=\""+item.JURL1+"\" target=\"_blank\">";
				html[hIdx++] = "	<img src=\""+item.IMG1+"\" alt=\"LP 탑배너_확장소재\" width=\""+item.WIDTH+"\" height=\""+item.HEIGHT+"\">";
				html[hIdx++] = "</a>";
				html[hIdx++] = "<button type=\"button\" class=\"btn_close_expand_img\"><i class=\"lp__sprite icon_close\"></i></button>";
				
				$_target.html(html.join(""));
				
				// 이벤트리스너
				if(!firstExpandTopAD) {
					eventLPTopBannerExpand();
				}
			} else {
				return;
			}
		}
		
	});
}

// 이벤트리스너
function eventLPTopBannerExpand() {

	$(document).on("mouseenter", ".btn_ad_expand", function(){
		$(this).addClass('loading');
		LPtopBanner_expandImg = setTimeout(function(){
			$('.expand_ad_img').stop().slideDown();
		},500);
	});
	
	$(document).on("mouseleave", ".btn_ad_expand", function(){
		$(this).removeClass('loading');
		clearTimeout(LPtopBanner_expandImg);
	});
	
	$(document).on("click", ".btn_ad_expand", function(){
		$('.expand_ad_img').stop().slideDown();
	});
	
	$(document).on("click", ".expand_ad_img .btn_close_expand_img", function(){
		$('.expand_ad_img').stop().slideUp();
	});
	
	firstExpandTopAD = true;
	
}

// LP 중단 배너 호출 ( T5 )
function loadLPCenterBanner(cate) {
	if(cate.length>4) {
		cate = cate.substring(0,4);
	}
	
	// 리스트 API 호출
	var bannerPromise = $.ajax({
		type : "GET",
		url : "http://ad-api.enuri.info/enuri_PC/pc_lp/T5/req",
		dataType : "json",
		data : {
			"cate" : cate
		}
	});
	
	bannerPromise.then(drawLPCenterBanner, failBanner);
}

// LP 중단 배너 그리기 ( T5 )
function drawLPCenterBanner(dataObj) {
	
	var lpCenterBannerObj = $("li[data-type=adline]");
	
	if(dataObj.JURL1 !== undefined && dataObj.IMG1 !== undefined && dataObj.JURL1.length>0 && dataObj.IMG1.length>0) {
		var html = [];
		var hIdx = 0;
	
		html[hIdx++] = "<li class=\"ad-wide-bnr\">";
		html[hIdx++] = "	<a href=\""+dataObj.JURL1+"\" target=\"_blank\">";
		html[hIdx++] = "		<img src=\""+dataObj.IMG1+"\" alt=\"LP 중단배너\">";
		html[hIdx++] = "	</a>";
		html[hIdx++] = "</li>";
		
		if(viewType==1) {
			lpCenterBannerObj.before(html.join(""));
		} else if(viewType==2) {
			$(".prodItem").eq(11).after(html.join(""));
		}
		
	} else {
		return;
	}
}

// 배너 호출 실패 시
function failBanner(errorObj) {
	console.log( "banner API Call Fail : " + errorObj.statusText);
}