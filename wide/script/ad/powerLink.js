// 파워링크 호출함수 ( 해당 cate 가 SG인지 확인한다. )
function getPowerLink(listType, ca_code, keyword) {
	
	// 타입 종류에 해당하지 않으면 리턴시킨다.
	var listTypeArr = new Array ( "LP", "SRP", "VIP", "MINIVIP");
	if (  $.inArray(listType, listTypeArr) < 0 ) {
		return;
	}
	
	var paramString = "type="+listType+"&device=pc&cate="+ca_code;
	if(listType == "MINIVIP") paramString = "type=LP&device=pc&cate="+ca_code;
	if(keyword && keyword.length > 0) {
		paramString = "type=SRP&device=pc&keyword="+encodeURIComponent(keyword);
	}
	
	var powerLinkObj = $.ajax({
		type:"GET",
		url: "/lsv2016/ajax/connectApiPowerlink.jsp",
		data: paramString,
		dataType: "JSON"
	});
	if(listType =="MINIVIP"){
		powerLinkObj.then(drawPowerLinkMiniVIP);
	}else{
		powerLinkObj.then(drawPowerLink);	
	}
	
}

// 파워링크 마크업 함수
function drawPowerLink(obj) {
	if(!obj.ads || obj.ads.length == 0) {
		return;
	}
	
	var target = $(".ad_powerlink");
	target.css("display", "block");
	
	var targetUl = target.find(".ad_link ul");
	var emptyImg = "http://img.enuri.info/images/home/thum_none.gif";
	var adHtml = "";
	
	// #38587 광고상품이 홀수일 경우 짝수 처리
	var isEven = true; // 짝수
	if( obj.ads.length %2 != 0 ) {
		isEven = false;
	}
	targetUl.empty();
	
	// 1개 인 경우 숨김 처리 
	if( obj.ads.length < 2) {
		target.css("display", "none");
	}

	$.each(obj.ads, function(index, item) {

		// 짝수이거나 홀수중 마지막을 제외하고 출력
		if( isEven || !(!isEven && (index+1 == obj.ads.length)) ) {
		
			adHtml += "	<li data-type=\"powerlink\">";
			adHtml += "		<a href=\""+item.clickUrl + "\" target=\"_blank\">";
			//	<!-- 이미지가 없을때는 ad_thumb을 제거 -->
			if(item.imageExtension) {
				adHtml += "		<span class=\"ad_thumb\">";
				adHtml += "			<img class=\"lazy\" data-src=\""+item.imageExtension.imageUrl+"\" data-original=\""+item.imageExtension.imageUrl+"\" onerror=\"this.src='"+noImageStr+"'\" alt=\"파워링크 광고상품\">";
				adHtml += "		</span>";
			}
			adHtml += "			<span class=\"ad_info\">";
			adHtml += "				<span class=\"ad_info_nm\">";
			adHtml += item.headline;
			if(item.naverPayIconType && item.naverPayIconType>0) {
				if(item.naverPayIconType == 1) {
					adHtml += "			<i class=\"ico_npay\">";
				} else if(item.naverPayIconType == 2) {
					adHtml += "			<i class=\"ico_npay plus\">";
				}
				adHtml += "</i>";
			}
			adHtml += "				</span>";
			adHtml += "				<span class=\"ad_info_txt\">";
			adHtml += item.description;
			adHtml += "				</span>";
			adHtml += "			</span>";
			adHtml += "		</a>";
			adHtml += "	</li>";
		}
	});
	targetUl.append(adHtml);

	$("li[data-type=powerlink] img.lazy").lazyload();
	
	// 개별로그
	var objType = obj.type; // LP,SRP,VIP
	var objCate = obj.cate; // LP 카테고리
	if(objCate && objCate.length > 4) {
		objCate = objCate.substring(0,4);
	}
	
	targetUl.find("li").click(function() {
		if(objType == "LP") {
			insertLogLSV(21229, objCate);
		} else if(objType == "SRP") {
			insertLogLSV(21233);
		} else if(objType == "VIP") {
			if(gModelData!==undefined && gModelData.gModelno!==undefined && gModelData.gCategory!==undefined) {
				insertLogLSV(21380,gModelData.gCategory,gModelData.gModelno+"");
			}
			
		}
	});
	
}
function drawPowerLinkMiniVIP(obj){
    var pObj = obj.ads;
    var html_minivip = [];
    var hIdx_minivip = 0;
    
    if(!obj.ads || obj.ads.length == 0) {
        $(".ad-minvip-powerlink").hide();
    }else{
        
        html_minivip[hIdx_minivip++] = "<div class=\"ad__tit\">";
        html_minivip[hIdx_minivip++] = "   파워링크 <span class=\"tag--ad comm__sprite\">AD</span>";
        html_minivip[hIdx_minivip++] = "   <a href=\"http://saedu.naver.com/adbiz/searchad/intro.nhn\" class=\"btn-ad-apply\" target=\"_blank\">신청하기 ></a>"
        html_minivip[hIdx_minivip++] = "</div>";
        html_minivip[hIdx_minivip++] = "<ul class=\"ad__list\">";
    
        $.each(pObj, function(index, item) {
            
            if(index==5){
                return false;
            }
            
            html_minivip[hIdx_minivip++] = "<li class=\"ad__item\">";
            html_minivip[hIdx_minivip++] = "   <a href=\""+item.clickUrl + "\" target=\"_blank\">";
            html_minivip[hIdx_minivip++] = "       <div class=\"ad__item--tit\">0"+(index+1)+". "+item.headline+"</div>";
            html_minivip[hIdx_minivip++] = "       <div class=\"ad__item--tx\">"+item.description+"</div>";
            html_minivip[hIdx_minivip++] = "       <div class=\"ad__item--link\">"+item.displayUrl+"</div>";
            html_minivip[hIdx_minivip++] = "   </a>";
            html_minivip[hIdx_minivip++] = "</li>";
        });
        
        html_minivip[hIdx_minivip++] = "</ul>";
        
        $(".ad-minvip-powerlink").html(html_minivip.join(""));
        $(".ad-minvip-powerlink").show();
    }
}