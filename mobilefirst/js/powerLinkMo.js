// 원본 mobilefirst/include/IncPowerLink.jsp 
// list2.js 에서 호출

// 중단 기본 구조
function initCenterPowerLink() {
	
	var adHtml = "";
	adHtml += "	<li class=\"powerlink\" style=\"display:none\">";
	adHtml += "		<div class=\"comm_ad ad_powerlink mobile\" data-type=\"center\">";
	adHtml += "			<div class=\"comm_ad_tit\">";
	adHtml += "				<em>파워링크</em>";
	adHtml += "				<a href=\"https://m.searchad.naver.com/product/shopProduct\" class=\"comm_btn_apply\" target=\"_blank\">신청하기</a>";
	adHtml += "			</div>";
	adHtml += "			<div class=\"comm_ad_list ad_link\">";
	adHtml += "				<ul>";
	// 광고 1개  x 2개 반복
	adHtml += "				</ul>";
	adHtml += "			</div>";
	adHtml += "		</div>";
	adHtml += "	</li>";
	$('.prodList #adline').after(adHtml);
}

// 파워링크 호출함수 
// listType : LP/SRP/VIP
// ca_code : 카테고리 
// keyword : 검색어 
// centerBool : 중단 표기 할지에 대한 boolean 값 
// 리스트값이 4개 이하인 경우 center 영역 그리지않는다.
function getPowerLink(listType, ca_code, keyword, centerBool) {
	
	// 타입 종류에 해당하지 않으면 리턴시킨다.
	var listTypeArr = new Array ( "LP", "SRP", "VIP" );
	if (  $.inArray(listType, listTypeArr) < 0 ) {
		return;
	}
	
	if( centerBool ) {
		initCenterPowerLink();
	}
	var paramString = "type="+listType+"&device=mw&cate="+ca_code;
	if(keyword && keyword.length > 0) {
		paramString = "type=SRP&device=mw&keyword="+encodeURIComponent(keyword);
	}	
	
	if(listType=="VIP" && $.cookie("appYN")=="Y"){
		paramString = "type="+listType+"&device=mo&cate="+ca_code;
	}
	
	var powerLinkObj = $.ajax({
		type:"GET",
		url: "/lsv2016/ajax/connectApiPowerlink.jsp",
		data: paramString,
		dataType: "JSON",
	});
	setTimeout(function() { powerLinkObj }, 0);
	powerLinkObj.then(function(obj) {
		drawPowerLink(obj, centerBool);
	});
}

//파워링크 마크업 함수
function drawPowerLink(obj, centerBool) {

	//  데이터가 없으면 노출이 되지 않는다.
	if(!obj.ads || obj.ads.length == 0) {
		return;
	}
	
	var centerTarget = $(".powerlink");
	var centerTargetUl = centerTarget.find("ul");
	var bottomTarget = $(".ad_powerlink[data-type=bottom]");
	var bottomTargetUl = bottomTarget.find("ul");
	var bottomBool = false;
	
	if(centerBool) {
		centerTarget.css("display", "block");
	}
	
	// 중단 노출하고 상품이 3개 이상이거나 
	// 하단만 노출하고 상품이 1개 이상이면 하단 노출처리한다.
	if( ( centerBool && obj.ads.length > 2 ) || ( !centerBool && obj.ads.length > 0 ) ) { 
		bottomBool = true;
		bottomTarget.css("display", "block");
	}
	
	var adHtml = "";
	
	if(centerBool) {
		centerTargetUl.empty();
	}
	if(bottomBool) {
		bottomTargetUl.empty();
	}
		
	$.each(obj.ads, function(index, item) {
		adHtml = "	<li>";
		adHtml += "		<a href=\""+item.clickUrl + "\" target=\"_blank\">";
		//	<!-- 이미지가 없을때는 ad_thumb을 제거 -->
		if(item.imageExtension) {
			adHtml += "		<span class=\"ad_thumb\">";
			adHtml += "			<img src=\"" + item.imageExtension.imageUrl + "\" alt=\"파워링크 광고상품\">";
			adHtml += "		</span>";
		}
		adHtml += "			<span class=\"ad_info\">";
		adHtml += "				<span class=\"ad_info_nm\">";
		adHtml += item.headline;
		adHtml += "				</span>";
		adHtml += "				<span class=\"ad_info_txt\">";
		adHtml += item.description;
		adHtml += "				</span>";
		adHtml += "			</span>";
		adHtml += "		</a>";
		adHtml += "	</li>";
		
		// 중단 노출할 경우 상위 2개 상품이 노출된다. 
		
		
		if( centerBool && index < 2 ) {
			centerTargetUl.append(adHtml)
		// 중단 비노출일 경우 5번째까지만 가져온다 . 
		} else if ( bottomBool && ( (!centerBool && index < 5) || centerBool) ) {
			bottomTargetUl.append(adHtml);
		}
	});
	
	// 이미지 에러 시 비노출 처리 ( display : none )
	if( centerBool ) {
		centerTargetUl.find("img").error(function() {
			$(this).css("display", "none");
		});
	}
	if( bottomBool ) {
		bottomTargetUl.find("img").error(function() {
			$(this).css("display", "none");
		});
	}
	
	// 개별로그 
	var objType = obj.type; // LP,SRP,VIP
	var objCate = obj.cate; // LP 카테고리
	if(objCate && objCate.length > 4) {
		objCate = objCate.substring(0,4);
	}
	
	if( centerBool ) {
		centerTargetUl.find("li").click(function() {
			if(objType == "LP") {
				insertLogLSV(21234, objCate);
			} else if(objType == "SRP") {
				insertLogLSV(21238);
			}
		});
	}
	if( bottomBool ) {
		bottomTargetUl.find("li").click(function() {
			if(objType == "LP") {
				insertLogLSV(21235, objCate);
			} else if(objType == "SRP") {
				insertLogLSV(21239);
			} else if(objType =="VIP"){
				insertLog_cate(21382, objCate);
			}
		});
	}
}