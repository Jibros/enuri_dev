// ebay 광고 api 호출 함수 : goods 코드 기반으로 호출 하는 api
var gCategory4 = gModelData.gCategory.substring(0,4);
function fnEbayVip(modelno) {
    var varuml = "modelno=" + modelno;
    $.ajax({
        type: "GET",
        url: "/ebayCpc/jsp/connectApiVip.jsp",
        data: varuml,
        dataType: "JSON",
        success: function(result) {
            if (result.sum_sort2) {
                var firstObj = null;
                var secondObj = null;
                var totalArray = new Array();
                var varMarketNm = "";
                if (result.sum_sort2.first) {
                    firstObj = result.sum_sort2.first.items;
                    if (result.sum_sort2.first.maket_nm == "gmarket") {
                        varMarketNm = "auction";
                    } else if (result.sum_sort2.first.maket_nm == "auction") {
                        varMarketNm = "gmarket";
                    }
                    totalArray = totalArray.concat(firstObj);
                }
                if (result.sum_sort2.second) {
                    secondObj = result.sum_sort2.second.items;
                    totalArray = totalArray.concat(secondObj);
                }
                var renCnt = 0;
                
                if ( totalArray.length > 0) { //first + second 로 변경 
                    vipEbayHtmlRan(totalArray, varMarketNm);
                    fnEbayVip_Conn2(varMarketNm);
                } else {
                    // dispaly none 처리
                    $("#prodPowerClick").hide();
                    //fnEbayVip_Empty();
                     fnEbayVip_Conn2('');
                }
            } else {
                // dispaly none 처리
                $("#prodPowerClick").hide();
                // fnEbayVip_Empty();
                 fnEbayVip_Conn2('');
            }
        },
        error: function(request, status, error) {
            //fnEbayVip_Conn2('');
            $("#prodPowerClick").hide();
        }
    });
}
// vip 상단 영역 HTML 랜더링
function vipEbayHtmlRan(firstObj, varMarketNm) {
    var cHtml = ""; // Center Html
    for (var i = 0; i < firstObj.length; i++) {
        if (i == 4) {
            break;
        }
        var varRanUrl = "/move/Redirect.jsp?cmd=move_link&sb=F&pl_no="; // 운영 :
        // sb=F
        // 로딩
        // 이미지 안
        // 보이도록
        // 함.
        var varShopcode = firstObj[i].shopcode; // shopCode
        var varItemNo = firstObj[i].item_no; // goodsCode
        var varEplno = firstObj[i].enuri_pl_no; // plNo
        var varprice = firstObj[i].enuri_price; // 에누리 가격
        var varImgS = firstObj[i].imgS; // 작은 사이즈 이미지 주소
        var varimgL = firstObj[i].imgL; // 큰 사이즈 이미지 주소
        var varIsAdult = firstObj[i].is_adult; // 성인 여부
        var varSalePrice = firstObj[i].sale_price; // 할인 금액
        var varSellPrice = firstObj[i].sell_price; // 판매 금액
        var varImpT = firstObj[i].imp_t; // 노출 체크를 위한 태그 정보
        var varClickT = firstObj[i].clk_t; // 클릭 체크를 위한 태그 정보
        var varTitle = firstObj[i].title; // 상품명
        var varShippingFee = firstObj[i].shipping_fee; // 배송비
        var varImpPrice = 0;
        var varShipFeeTxt = "무료배송";
        var varShipClass = "deli_free";
        var varShopNm = "";
        var varShopImgUrl = "";
        var varLanding = firstObj[i].landing;
        var varOnClickT = " onclick=\"vipClickTFwd('" + varClickT + "');\"";
        // plno 있을 경우만 에누리 브릿지페이지로 넘김.
        //if (varEplno > 0) {
        //    varRanUrl = varRanUrl + varEplno;
        // } else {
            varRanUrl = varLanding;
       // }
        // 퍼블에 a 링크가 빠져 있어 노출/이동 함수 새로 생성 함.
        var varOnClickTAndMove = " onclick=\"vipClickTFwdAndMove('" + varClickT + "', '" + varRanUrl + "');\"";
        // 성인여부 체크
        if (varIsAdult && !blAdult) {
            varimgL = "http://img.enuri.info/images/home/thum_adult.gif";
            varImgS = "http://img.enuri.info/images/home/thum_adult.gif";
        }
        if(varImpT.length>0) {
            impCall(varImpT);
        }
        // 가격 정보 : 에누리 금액 -> 할인 금액 -> 판매 금액 순 노출
        if (varprice > 0) {
            varImpPrice = numberWithCommas(varprice);
        } else if (varSalePrice > 0) {
            varImpPrice = numberWithCommas(varSalePrice);
        } else {
            varImpPrice = numberWithCommas(varSellPrice);
        }
        // 배송비 노출 정책에 따른 로직 마켓별로 노출 Text 정책이 다름
        if (varShippingFee > 0) {
            if (varShopcode == "536") { // G마켓
                varShipFeeTxt = "배송비" + numberWithCommas(varShippingFee);
                // varShipClass ="deli plnoMoveLink";
                varShipClass = "deli";
            } else if (varShopcode == "4027") { // 옥션
                varShipFeeTxt = "조건부무료배송";
                varShipClass = "deli";
            }
        } else {
            varShipFeeTxt = "무료배송";
            varShipClass = "deli_free";
        }
        if (varShopcode == "536") {
            varShopNm = "G마켓";
            varShopImgUrl = "http://storage.enuri.info/logo/logo20/logo_20_" + varShopcode + ".png";
        }
        if (varShopcode == "4027") {
            varShopNm = "옥션";
            varShopImgUrl = "http://storage.enuri.info/logo/logo20/logo_20_" + varShopcode + ".png";
        }
        var classNm = "";
        if (i == 0) {
            classNm = "left";
        } else {
            classNm = "right";
        }
        
        cHtml += "<li>";
	    cHtml += "    <div class=\"tb_row\">";
	    cHtml += "        <span class=\"col col-1\">";
	    cHtml += "            <a href='"+varRanUrl+"' target=\"_blank\" class=\"logo\" "+varOnClickT+">";
	    cHtml += "              <img src=\"" + varShopImgUrl + "\" onerror=\"this.src='http://img.enuri.info/images/home/thum_none.gif'\" class=\"thum\">";
	    cHtml += "            </a>";
	    cHtml += "        </span>";
	    cHtml += "        <span class=\"col col-2\">";
	    cHtml += "            <a href='"+varRanUrl+"' target=\"_blank\" class='tx_name' "+varOnClickT+">"+varTitle+"</a>";
	    cHtml += "        </span>";
	    cHtml += "        <span class='col col-3'>";
	    cHtml += "            <a href='"+varRanUrl+"' target=\"_blank\" class='tx_price' "+varOnClickT+"><em>"+varImpPrice+"</em>원</a>";
	    cHtml += "            <span class='tx_delivery'>"+varShipFeeTxt+"</span>";
	    cHtml += "        </span>";
	    cHtml += "    </div>";
	    cHtml += "</li>";
        
        
        
    }
    //$("#ebay_cpc_vip_goods_list").html(cHtml);
    //$(".comm_ad.ad_powerclick.lp-ad--openad > .comm_ad_list > ul").html(cHtml);
    
    $("#prodPowerClickList").html(cHtml);
    $("#prodPowerClickList").show();
    $("#prodPowerClickList li").click(function() {
        insertLogLSV(21378, gCategory4, gModelData.gModelno + "");
    });
    $("#prodPowerClick").show();
    //fnEbayVip_Conn2(varMarketNm);
}
// vip 하단에 붙은 ebay cpc 광고 호출 함수
function fnEbayVip_Conn2(maketNm) {
    var varuml = varuml = "keyword=" + encodeURIComponent(param_cate) + "&maxCnt=6&isCate=VIP&isPC=PC&cateCode=" + param_cate;
    var btmMaketNm = maketNm;
    $.ajax({
        type: "GET",
        url: "/ebayCpc/jsp/connectApi2.jsp",
        data: varuml,
        dataType: "JSON",
        success: function(result) {
            if (result.sum_sort2) {
                var firstObj = null;
                var secondObj = null;
                // vip ad ep api 호출 후 상단에 노출된 마켓과 반대되는 마켓 정보를 넣어 줌. (마켓
                // 중복 방지)
                if (result.sum_sort2.first && btmMaketNm == result.sum_sort2.first.maket_nm) { // gmaket
                    // 또는
                    // 옥션
                    firstObj = result.sum_sort2.first.items;
                } else if (result.sum_sort2.second && btmMaketNm == result.sum_sort2.second.maket_nm) { // 옥션
                    // 또는
                    // gmaket
                    firstObj = result.sum_sort2.second.items;
                } else if (result.sum_sort2.first) { // 마켓 정보가 없을 경우
                    // 기본 첫번째 아이템 출력
                    firstObj = result.sum_sort2.first.items;
                } else if (result.sum_sort2.second) { // 마켓 정보가 없을 경우
                    // 기본 두번째 아이템 출력
                    firstObj = result.sum_sort2.second.items;
                }
                /*
                 * if (result.sum_sort2.first) { firstObj =
                 * result.sum_sort2.first.items; }
                 */
                var renCnt = 0;
                var bHtml = ""; // Bottom Html
                if (null != firstObj && firstObj.length >= 3) { // ebay
                    // Cpc가2건이상일 경우만 있을 경우
                    for (var i = 0; i < firstObj.length; i++) {
                        if (i == 6) {
                            break;
                        }
                        var varRanUrl = "/move/Redirect.jsp?cmd=move_link&sb=F&pl_no="; // 운영 : sb=F 로딩 이미지 안 보이도록 함.
                        var varShopcode = firstObj[i].shopcode; // shopCode
                        var varItemNo = firstObj[i].item_no; // goodsCode
                        var varEplno = firstObj[i].enuri_pl_no; // plNo
                        var varprice = firstObj[i].enuri_price; // 에누리
                        // 가격
                        var varImgS = firstObj[i].imgS; // 작은 사이즈 이미지 주소
                        var varimgL = firstObj[i].imgL; // 큰 사이즈 이미지 주소
                        var varIsAdult = firstObj[i].is_adult; // 성인 여부
                        var varSalePrice = firstObj[i].sale_price; // 할인
                        // 금액
                        var varSellPrice = firstObj[i].sell_price; // 판매
                        // 금액
                        var varImpT = firstObj[i].imp_t; // 노출 체크를 위한
                        // 태그 정보
                        var varClickT = firstObj[i].clk_t; // 클릭 체크를 위한
                        // 태그 정보
                        var varTitle = firstObj[i].title; // 상품명
                        var varShippingFee = firstObj[i].shipping_fee; // 배송비
                        var varImpPrice = 0;
                        var varShipFeeTxt = "무료배송";
                        var varShipClass = "deli_free";
                        var varShopNm = "";
                        var varShopImgUrl = "";
                        var varLanding = firstObj[i].landing;
                        var varOnClickT = " onclick=\"vipClickTFwd('" + varClickT + "');\"";
                        // plno 있을 경우만 에누리 브릿지페이지로 넘김.
                        //if (varEplno > 0) {
                        //    varRanUrl = varRanUrl + varEplno;
                        //} else {
                            varRanUrl = varLanding;
                        //}
                        if(varImpT.length>0) {
                            impCall(varImpT);
                        }
                        // 성인여부 체크
                        if (varIsAdult && !blAdult) {
                            varimgL = "http://img.enuri.info/images/home/thum_adult.gif";
                            varImgS = "http://img.enuri.info/images/home/thum_adult.gif";
                        }
                        // 가격 정보 : 에누리 금액 -> 할인 금액 -> 판매 금액 순 노출
                        if (varprice > 0) {
                            varImpPrice = numberWithCommas(varprice);
                        } else if (varSalePrice > 0) {
                            varImpPrice = numberWithCommas(varSalePrice);
                        } else {
                            varImpPrice = numberWithCommas(varSellPrice);
                        }
                        // 배송비 노출 정책에 따른 로직 마켓별로 노출 Text 정책이 다름
                        if (varShippingFee > 0) {
                            if (varShopcode == "536") { // G마켓
                                varShipFeeTxt = "배송비" + numberWithCommas(varShippingFee);
                                varShipClass = "deli plnoMoveLink";
                            } else if (varShopcode == "4027") { // 옥션
                                varShipFeeTxt = "조건부무료배송";
                                varShipClass = "deli plnoMoveLink";
                            }
                        } else {
                            varShipFeeTxt = "무료배송";
                            varShipClass = "deli_free";
                        }
                        if (varShopcode == "536") {
                            varShopNm = "G마켓";
                            varShopImgUrl = "http://storage.enuri.info/logo/logo20/logo_20_" + varShopcode + ".png";
                        }
                        if (varShopcode == "4027") {
                            varShopNm = "옥션";
                            varShopImgUrl = "http://storage.enuri.info/logo/logo20/logo_20_" + varShopcode + ".png";
                        }
                        
                        bHtml += "<li>";
	                    bHtml += "    <a href='"+varRanUrl+"'  target=\"_blank;\" "+varOnClickT+" class='thum__link'>";
	                    bHtml += "        <span class='ad_thumb'>";
	                    bHtml += "			<img data-original=\""+varImgS+"\" src=\"http://img.enuri.info/images/home/thum_none.gif\"  onerror=\"this.src='http://img.enuri.info/images/home/thum_none.gif'\"  alt=''>";
	                    bHtml += "		  </span>";
	                    bHtml += "        <span class='ad_info'>";
	                    bHtml += "            <span class='ad_info_nm'>"+varTitle+"</span>";
	                    bHtml += "            <span class='ad_info_price'>";
	                    //bHtml += "                <!-- 특가/할인율 등 태그 -->
	                    bHtml += "                <span class='ad_price_tag'>특가</span>";
	                    //bHtml += "                <!-- 가격 -->";
	                    bHtml += "                <em>"+varImpPrice+"</em>원";
	                    bHtml += "            </span>";
	                    bHtml += "            <span class='ad_info_shop'>";
	                    bHtml += "                <em>"+varShopNm+"</em>";
	                    //bHtml += "                <i class='ad_type_npay'></i>";
	                    bHtml += "            </span>";
	                    bHtml += "        </span>";
	                    bHtml += "    </a>";
	                    bHtml += "</li>";
                        
                    } // for 문 End
                    //$("#ebay_cpc_vip_bottom_goods_list").html(bHtml);
                    
                    $("#prodPowerClickBottom").find(".comm_ad_list ul").html(bHtml);
                    
                    //$("#ebay_cpc_vip_div_bottom").show();
                    $("#prodPowerClickBottom").find(".comm_ad_list ul").show();
                    
                    $("#prodPowerClickBottom").find(".comm_ad_list ul li").click(function() {
                    	
                    	try{
                            insertLogLSV(21379, gCategory4, gModelData.gModelno + "");	
                    	}catch(e){console.log(e)}
                    	
                    });
                    $("#prodPowerClickBottom").find(".comm_ad_list ul li img").lazyload({
                        placeholder : 'http://img.enuri.info/images/home/thum_none.jpg',
                        effect : 'fadeIn',
                        effectTime : 2000,
                        threshold : 800
                    });
                } else {
                	$("#prodPowerClickBottom").hide();
                }
            } else {
            	$("#prodPowerClickBottom").hide();
            }
        },
        error: function(request, status, error) {}
    });
}
// vip 상단 광고 없을 경우 connectApi2 api를 호출하여 사용 함.
function fnEbayVip_Empty() {
    var varuml = "keyword=" + encodeURIComponent(param_cate) + "&maxCnt=6&isCate=VIP&isPC=PC&cateCode=" + param_cate + "&chInfo=pc_enuri_vip3";
    var btmMaketNm = "";
    $.ajax({
        type: "GET",
        url: "/ebayCpc/jsp/connectApi2.jsp",
        data: varuml,
        dataType: "JSON",
        success: function(result) {
            if (result.sum_sort2) {
                var firstObj = null;
                var secondObj = null;
                var varMarketNm = "";
                if (result.sum_sort2.first) {
                    firstObj = result.sum_sort2.first.items;
                    if (result.sum_sort2.first.maket_nm == "gmarket") {
                        varMarketNm = "auction";
                    } else if (result.sum_sort2.first.maket_nm == "auction") {
                        varMarketNm = "gmarket";
                    }
                }
                var renCnt = 0;
                var cHtml = ""; // Center Html
                var bHtml = ""; // Bottom Html
                if (null != firstObj && firstObj.length >= 2) { // ebay Cpc가 2건
                    // 이상일 경우만 있을 경우
                    vipEbayHtmlRan(firstObj, varMarketNm);
                } else { // dispaly none 처리
                    $("#prodPowerClick").hide();
                    fnEbayVip_Conn2('');
                }
            } else { // dispaly none 처리
                $("#prodPowerClick").hide();
                fnEbayVip_Conn2('');
            }
        },
        error: function(request, status, error) {}
    });
}


function vipClickTFwd(clickUrl) {
    $("#hFrame").attr("src",clickUrl);
}

function vipClickTFwdAndMove(clickUrl, rend_url) {
    var imgSrc = new Image();
    imgSrc.src = clickUrl;
    window.open(rend_url, '', '');
}
//impression call
function impCall(impUrl) {
	if(impUrl && impUrl.length>0) {
		$.ajax({
			type: "GET",
			url: impUrl
		});
	}
}