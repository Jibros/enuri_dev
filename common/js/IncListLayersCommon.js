
function compareProdListViewHtml(json) {
	var compareProdBoxDivObj = $("#compareProdBoxDiv");

	var goodsCnt = json["goodsCnt"];
	var goodsListObj = json["goodsList"];
	var html = "";

	compareProdBoxDivObj.find(".compCntSpan").html("("+goodsCnt.format()+")");

	$.each(goodsListObj, function(Index, listData) {
		
		var prodNo = listData["prodNo"];
		var modelno = listData["modelno"];
		var p_pl_no = listData["p_pl_no"];
		var minPriceText = listData["minPriceText"];
		var minprice = listData["minprice"];
		var minprice3 = listData["minprice3"];
		var mallcnt = listData["mallcnt"];
		var mallcnt3 = listData["mallcnt3"];
		var goods_info = listData["goods_info"];
		var sale_cnt = listData["sale_cnt"];
		var ca_code = listData["ca_code"];
		var modelnm = listData["modelnm"];
		var factory = listData["factory"];
		var brand = listData["brand"];
		var strFreeinterest = listData["strFreeinterest"];
		var c_date = listData["c_date"];
		var c_dateStr = listData["c_dateStr"];
		var moddate = listData["moddate"];
		var smallImageUrl = listData["smallImageUrl"];
		var gb1_no = listData["gb1_no"];
		var kb_num = listData["kb_num"];
		var kb_title = listData["kb_title"];
		var url1 = listData["url1"];
		var keyword2 = listData["keyword2"];
		var modelCateLink = listData["modelCateLink"];
		var strCategoryName = listData["strCategoryName"];
		var goodscode = listData["goodscode"];
		//현금몰, tlc 최저가 노출 로직 추가 (2019.12.12)
		var cash_min_prc = listData["cash_min_prc"];
		var cash_min_prc_yn = listData["cash_min_prc_yn"];
		var ovs_min_prc_yn = listData["ovs_min_prc_yn"];
		var tlc_min_prc = listData["tlc_min_prc"];
		
		html += "<li prodNo=\""+prodNo+"\" class=\"compare-prod__item\">";
		html += "    <!-- 체크박스 -->";
		html += "    <input type=\"checkbox\" id=\""+prodNo+"\" class=\"input--checkbox-item\"><label for=\""+prodNo+"\"></label>";
		html += "    <!-- // -->";
		html += "    <a href=\"#\">";
		html += "        <div class=\"compare-prod__thumb\">";
		html += "            <!-- AD -->";
		//html += "            <span class=\"compare-prod__tag--ad\">AD</span>";
		html += "            <!-- 썸네일 -->";
		html += "            <img src=\""+smallImageUrl+"\" onerror=\"this.src='"+noImageStr+"'\">";
		html += "        </div>";
		html += "        <div class=\"compare-prod__info\">";
		html += "            <!-- 상품명 -->";
		html += "            <span class=\"compare-prod__name\">"+modelnm+"</span>";
		html += "            <!-- 가격 -->";
		var mPrice = minprice.format();
		if(parseInt(mallcnt3) > 0 && parseInt(minprice3) == 0 && typeof cash_min_prc_yn != "undefined" && cash_min_prc_yn != null && cash_min_prc_yn == "Y" && typeof cash_min_prc != "undefined" && cash_min_prc != null) {
			mPrice = cash_min_prc.format();
		} else if(typeof tlc_min_prc != "undefined" && tlc_min_prc != null && minprice3 == "0" && tlc_min_prc != "0") {
			mPrice = tlc_min_prc.format();
		} else {	
			// 가격비교 상품일 경우만 모바일 아이콘 적용
			if(modelno.length>0 && modelno!="0") {
				if(mallcnt=="0" && mallcnt3!="0") {
					html += "	<span class=\"m_only\">모바일전용</span> ";
				}
			}
			if(minprice3!="0" && minprice>minprice3) {
				html += "<em class=\"m_price\">모바일</em> ";
				mPrice = minprice3.format();
			}
			
		}
		html += "            <span class=\"compare-prod__price\">";
		html += "                <em>"+mPrice+"</em>원";
		html += "            </span>";
		html += "        </div>";
		html += "    </a>";
		html += "</li>";

		/*html += "<li prodNo=\""+prodNo+"\"><a href=\"JavaScript:\">";
		html += "	<span class=\"compareMiniCheck chk\"><input type=\"checkbox\" /></span>";
		html += "	<img src=\""+smallImageUrl+"\" onerror=\"this.src='"+noImageStr+"'\">";
		html += "	<div>";
		html += modelnm; 
		html += "	</div>";
		html += "	<strong>";
		
		if(typeof cash_min_prc_yn != "undefined" && cash_min_prc_yn != null && cash_min_prc_yn == "Y" && typeof cash_min_prc != "undefined" && cash_min_prc != null) {
			html += cash_min_prc.format() + "<em>원</em> </strong>";
			html += "</a></li>";
		} else if(typeof tlc_min_prc != "undefined" && tlc_min_prc != null && minprice3 == "0" && tlc_min_prc != "0") {
			html += tlc_min_prc.format() + "<em>원</em> </strong>";
			html += "</a></li>";
		} else {	
			// 가격비교 상품일 경우만 모바일 아이콘 적용
			if(modelno.length>0 && modelno!="0") {
				if(mallcnt=="0" && mallcnt3!="0") {
					html += "	<span class=\"m_only\">모바일전용</span> ";
				}
			}
			if(minprice3!="0" && minprice>minprice3) {
				html += "<em class=\"m_price\">모바일</em> ";
				minprice = minprice3;
			}
			
			var priceTextStr = "";
			priceTextStr = minprice.format() + "<em>원</em>";
			if(minPriceText.length>0) priceTextStr = minPriceText;
			html += priceTextStr + "</strong>";
			html += "</a></li>";
		}*/
	});
	
	// compareProdBoxDivObj.find(".compCntSpan").html(3);
	
	/*
	20190819 : 인포애드 광고상품 아이콘 추가 (비교팝업)
	스폰서 및 인포애드 광고상품 비교 팝업에 자동 노출 
	비교팝업 내 우측 마지막에 노출(AD딱지 노출)  
	 */
	
	// 랜덤으로 인포애드 광고상품을 가져온다.
	if(goodsCnt>0 && gCate && gCate != '' && gCate>0) {
		$.ajax({
			type : "get",
			url : "/lsv2016/ajax/getAdRandomModelno_ajax.jsp",
			data : "cate=" + gCate,
			dataType: "json",
			async: false,
			success: function(ret) {
				if(ret.prodNo && ret.prodNo.length>0) {
					
					html += "<li prodNo=\""+ret.prodNo+"\"><a href=\"JavaScript:\">";
					html += "	<span class=\"compareMiniCheck chk\"><input type=\"checkbox\" /></span>";
					html += "	<span class=\"ico_ad\">AD</span>";
					html += "	<img src=\""+ret.smallImageUrl+"\" onerror=\"this.src='"+ret.noImageStr+"'\">";
					html += "	<div>";
					html += ret.modelnm; 
					html += "	</div>";
					html += "	<strong>";
					// 가격비교 상품일 경우만 모바일 아이콘 적용
					if(ret.modelno.length>0 && ret.modelno!="0") {
						if(ret.mallcnt=="0" && ret.mallcnt3!="0") {
							html += "	<span class=\"m_only\">모바일전용</span> ";
						}
					}
					if(ret.minprice3!="0" && ret.minprice>ret.minprice3) {
						html += "<em class=\"m_price\">모바일</em> ";
						ret.minprice = ret.minprice3;
					}
		
					var priceTextStr = "";
					priceTextStr = ret.minprice.format() + "<em>원</em>";
					if(ret.minPriceText.length>0) priceTextStr = ret.minPriceText;
					html += priceTextStr + "</strong>";
					html += "</a></li>";
					
					// 슈퍼탑 광고관련 로그 20190830
					insertLogLSV(20441, '', ret.prodNo.substring(1));
					
					// 슈퍼탑 노출로그 20190930
					if(ret.infoAdImpUrl && ret.infoAdImpUrl.length>0){
						infoadLogExe(ret.infoAdImpUrl);
					}
					
					// 슈퍼탑 클릭로그 20190930
					if(ret.infoAdClickUrl && ret.infoAdClickUrl.length>0){
						$(document).on('click', 'li[prodNo='+ret.prodNo+']', function(){
							infoadLogExe(ret.infoAdClickUrl);
						});
					}
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				console.log ('error');
			}
		})
	}
	
	return html;
}
