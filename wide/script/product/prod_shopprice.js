import * as prodCommon from "./prod_common.js";
export let cardshop_check;
const storageUrl = "http://storage.enuri.info";
let param = {
    "modelno": gModelData.gModelno,
    "card": "",
    "cate": gModelData.gCategory,
    "delivery": "",
    "prono": "",
    "callcnt": 0
};

export const paramHandler = {
    set: (prop, value) => {
        if (prop === "callcnt") {
        } else {
            param["callcnt"]++;
            param[prop] = value;
            shopPricePromise().then(prodShopPriceView);
        }
        return true;
    },
    get: (prop) => {
        return param[prop];
    },
    init: () => {
        param["modelno"] = gModelData.gModelno;
        param["card"] = "";
        param["delivery"] = "";
        param["prono"] = "";
        param["callcnt"] = 0;
    }
};

export const shopPricePromise = (data) => {
    if (typeof data !== 'undefined') {
        param = data;
    }
    return new Promise((resolve, reject) => {
        $.ajax({
            type: "post",
            url: "/wide/api/product/prodShopPrice.jsp",
            data: param,
            dataType: "json",
            success: (response) => {
                resolve(response);
            }, error: (err) => {
                reject("ShopPrice Response is failed");
            }
        });
    });
}

export const prodShopPriceView = (json) => {
    if (json.success && json.total > 0) {
        let shopPriceCnt = json.total;
        let shopPriceJson = json.data;
        let shopPriceList = shopPriceJson.shopPricelist;
        let shopSpecialList = shopPriceJson.specialPrice;
        let priceTop = shopPriceJson.priceTop;
        cardshop_check = shopPriceJson.cardshop_check;
        //순서있음
        let html = ``;
        let visitViewFlag = prodVisitPriceView(json);
        if (paramHandler.get("callcnt") == 0) {
            //첫번째 쇼핑몰 정보로 ....상단,topfix 배송비..최저가 구매하기 링크
            let firstShopObj = shopPriceList[0];
            if (typeof firstShopObj != "undefined") {
                let delivery_text = firstShopObj.delivery_text;
                let bridgeUrl = prodCommon.bridgeUrl('move_link', `${firstShopObj.shopcode}`, `${gModelData.gModelno}`, `${gModelData.gFactory}`, `${firstShopObj.plno}`, `${firstShopObj.coupon}`, `${firstShopObj.price}`, 1);
                if ($.isNumeric(firstShopObj.delivery_text)) {
                    delivery_text = "배송비 " + numComma(firstShopObj.delivery_text) + "원 별도";
                } else {
                    delivery_text = firstShopObj.delivery_text;
                }
                $("#prod_topfix").find(".prodtabinfo__rt .tx_delivery").html(delivery_text);
                $("#prod_topfix").find(".prodtabinfo__rt .btn__purchase").attr("href", bridgeUrl);
                $("#prod_topfix").find(".prodtabinfo__rt .btn__purchase").data("shopcode",firstShopObj.shopcode);
                $("#prod_topfix").find(".prodtabinfo__rt .btn__purchase").data("shoptype",firstShopObj.shoptype);
                $("#prod_summary_top").find(".prodminprice .tx_delivery").html(delivery_text);

                $("#prod_summary_top").find(".prodminprice .btn__purchase").attr("href", bridgeUrl);
                $("#prod_summary_top").find(".prodminprice .btn__purchase").data("shopcode",firstShopObj.shopcode);
                $("#prod_summary_top").find(".prodminprice .btn__purchase").data("shoptype",firstShopObj.shoptype);
                $("#prod_topfix").find(".prodtabinfo__rt .btn__purchase").unbind().click(function(e){

                    let vNowtime = new Date().format("yyyyMMddhhmm")*1;
                    if(serviceNShopChkAlert){
                        if($(this).data("shoptype") == "4") {
                            alert("해당 쇼핑몰은 현재 서비스 점검 중입니다.");
                            return false;
                        }
                    }
                    if(serviceChkAlert[$(this).data("shopcode")] !== undefined){
                        e.preventDefault();
                        alert(serviceChkAlert[$(this).data("shopcode")].contents);
                        return false;
                    }
                    insertLogLSV(19304,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                    insertLogLSV(14515,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                    ga('send','event','vip','top_clickout','lowestprice');
                })
                $("#prod_summary_top").find(".prodminprice .btn__purchase").unbind().click(function(e){
                    let vNowtime = new Date().format("yyyyMMddhhmm")*1;
                    if(serviceNShopChkAlert){
                        if($(this).data("shoptype") == "4") {
                            alert("해당 쇼핑몰은 현재 서비스 점검 중입니다.");
                            return false;
                        }
                    }
                    if(serviceChkAlert[$(this).data("shopcode")] !== undefined){
                        e.preventDefault();
                        alert(serviceChkAlert[$(this).data("shopcode")].contents);
                        return false;
                    }
                    insertLogLSV(18623,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                    insertLogLSV(14515,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                    ga('send','event','vip','summary_clickout','lowestprice');
                    if(visitViewFlag){
                        insertLogLSV(26296,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                    }//직방가 클릭뷰
                });
            }
            //초기화
            $("#prod_shopprice").find(".m_price__sort input").prop('checked',false);
            if (cardshop_check) {
                $("#prod_shopprice").find(".m_price__sort input[data-sort='card']").parent().show();
            } else {
                $("#prod_shopprice").find(".m_price__sort input[data-sort='card']").parent().hide();
            }
            if (Object.keys(shopSpecialList).length > 0 || (Object.keys(priceTop).length > 0 && priceTop.ad_type === "B")) {
                if (typeof shopSpecialList.cardSpecialPrice !== "undefined") {
                    let specialObj = shopSpecialList.cardSpecialPrice;

                    let shopcode = specialObj.shopcode;
                    let shoptype = specialObj.shoptype;
                    let shopname = specialObj.shopname;
                    let cardname = specialObj.cardname;
                    let cardprice = specialObj.cardprice;
                    let delivery_text = specialObj.delivery_text;
                    let plno = specialObj.plno;
                    let coupon = specialObj.coupon;
                    let shoplogo_check = specialObj.shoplogo_check;
                	let bridgeUrl = prodCommon.bridgeUrl('move_link', `${shopcode}`, `${gModelData.gModelno}`, `${gModelData.gFactory}`, `${plno}`, `${coupon}`, `${cardprice}`, 1);
					if ($.isNumeric(delivery_text)) {
                        delivery_text = numComma(delivery_text) + "원";
                    } else {
                        delivery_text = delivery_text;
                    }

                    html += `<li data-type="card" data-shopcode="${shopcode}" data-shoptype="${shoptype}">
                                <span class="col col-1">
                                    <a href="${bridgeUrl}" target="_blank" class="logo" onerror="$(this).replaceWith('${shopname}')" >
                                    ${shoplogo_check ? `<img src="${storageUrl}/logo/logo16/logo_16_${shopcode}.png" alt="${shopname}" onerror="$(this).replaceWith('${shopname}')">` : `${shopname}`}
                                    </a>
                                    ${shoptype=="4" ? `<a href="${bridgeUrl}" target="_blank" class="badge badge--npay">네이버페이</a>` : ``}
                                </span>
                                <span class="col col-2">
                                    <a href="${bridgeUrl}" target="_blank" class="price" >
                                        <span class="tx_msg"><i class="ico ico--card"></i>${cardname} 할인가</span>
                                        <span class="tx_price"><em>${cardprice.format()}</em>원</span>
                                    </a>
                                </span>
                                <span class="col col-3">
                                    <span class="delivery">${delivery_text}</span>
                                </span>
                            </li>`
                } else {
                    $("#prod_shopprice").find(".m_price__sort input[data-sort='card']").prop('checked',false);
                }

                if (typeof shopSpecialList.cashSpecialPrice !== "undefined") {
                    let specialObj = shopSpecialList.cashSpecialPrice;

                    let shopcode = specialObj.shopcode;
                    let shopname = specialObj.shopname;
                    let cardname = specialObj.cardname;
                    let shoplogo_check = specialObj.shoplogo_check;
                    let delivery_text = specialObj.delivery_text;
                    let plno = specialObj.plno;
                    let coupon = specialObj.coupon;

                    let price = numComma(specialObj.price);
                    let bridgeUrl = prodCommon.bridgeUrl('move_link', `${shopcode}`, `${gModelData.gModelno}`, `${gModelData.gFactory}`, `${plno}`, `${coupon}`, `${price}`, 1);
                    if ($.isNumeric(delivery_text)) {
                        delivery_text = numComma(delivery_text) + "원";
                    } else {
                        delivery_text = delivery_text;
                    }
                    html += `<li data-type="cash">
                                <span class="col col-1">
                                    <a href="${bridgeUrl}" target="_blank" class="logo">
                                    ${shoplogo_check ? `<img src="${storageUrl}/logo/logo16/logo_16_${shopcode}.png" alt="${shopname}" onerror="$(this).replaceWith('${shopname}')">` : `${shopname}`}
                                    </a>
                                </span>
                                <span class="col col-2">
                                    <a href="${bridgeUrl}" target="_blank" class="price">
                                        <span class="tx_msg"><i class="ico ico--cash"></i>현금 최저가</span>
                                        <span class="tx_price"><em>${price}</em>원</span>
                                    </a>
                                </span>
                                <span class="col col-3">
                                    <span class="delivery">${delivery_text}</span>
                                </span>
                            </li>`
                }
                if (typeof shopSpecialList.promoSpecialPrice !== "undefined") {
                    let specialObj = shopSpecialList.promoSpecialPrice;

                    let shopcode = specialObj.shopcode;
                    let shopname = specialObj.shopname;
                    let shoplogo_check = specialObj.shoplogo_check;
                    let price = numComma(specialObj.discountPrice);

                    let promoText = specialObj.promotext;
                    let promoUrl = specialObj.promourl;
                    html += `<li class="is-promotion" data-type="promotion">
                                <span class="col col-1">
                                <a href="${promoUrl}" target="_blank" class="logo">
                                      ${shoplogo_check ? `<img src="${storageUrl}/logo/logo16/logo_16_${shopcode}.png" alt="${shopname}" onerror="$(this).replaceWith('${shopname}')">` : `${shopname}`}
                                </a>
                                </span>
                                <span class="col col-2">
                                    <a href="${promoUrl}" target="_blank" class="price">
                                        <span class="tx_msg">${promoText}</span>
                                        <span class="tx_price"><em>${price}</em>원</span>
                                    </a>
                                </span>
                                <span class="col col-3">
                                    <a href="${promoUrl}" target="_blank" class="btn btn--buy">구매하기</a>
                                </span>
                            </li>`
                }

                if(priceTop.ad_type === "B"){
                    let adShopCode = priceTop.shop_code;
                    let adShopName = priceTop.mall_name;
                    let adCopyText = priceTop.copytext;
                    let shoplogo_check = priceTop.shoplogo_check;
                    let adPrice = priceTop.price;
                    let pl_no = priceTop.pl_no;
                    let adshoppingfee = priceTop.shoppingfee;
                    let url = priceTop.url;
                    let bridgeUrl = "";
                    if (url == "") {
                        bridgeUrl = prodCommon.bridgeUrl('move_link', `${adShopCode}`, `${gModelData.gModelno}`, `${gModelData.gFactory}`, `${pl_no}`, `0`, `${adPrice}`, 1);
                    } else {
                        bridgeUrl = url;
                    }
                    html += `<li class="is-adline">
                                <span class="col col-1">
                                    <a href="${bridgeUrl}" class="logo" target="_blank">
                                        ${url != ""
                                        ? `<span>${adShopName}</span>`
                                        : `${shoplogo_check ? `<img src="${storageUrl}/logo/logo16/logo_16_${adShopCode}.png" alt="${adShopName}" onerror="$(this).replaceWith('${adShopName}')">`:`<span>${adShopName}</span>`}`
                                        }
                                        <i class="ico ico--ad"></i>
                                    </a>
                                    <span class="tx_sub">${adCopyText}</span>
                                </span>
                                <span class="col col-2">
                                    <a href="${bridgeUrl}" class="price" target="_blank">
                                        <span class="tx_price"><em>${numComma(adPrice)}</em>원</span>
                                    </a>
                                </span>
                                <span class="col col-3">
                                    <span class="delivery">${adshoppingfee}</span>
                                </span>
                            </li>`
                }

                $("#special_price").find(".s_price__list").html(html);
                $("#special_price").show();
            } else {
                $("#special_price").hide();
            }
        }
        $("#prod_shopprice").find(".m_price__sort input").prop('checked',false);
        (paramHandler.get("delivery") =="Y")
        ? $("#prod_shopprice").find(".m_price__sort input[data-sort='delivery']").prop('checked',true)
        : $("#prod_shopprice").find(".m_price__sort input[data-sort='delivery']").prop('checked',false);

        (paramHandler.get("card") =="Y")
        ? $("#prod_shopprice").find(".m_price__sort input[data-sort='card']").prop('checked',true)
        : $("#prod_shopprice").find(".m_price__sort input[data-sort='card']").prop('checked',false);
        html = ``;
        let firstFreeInterestCnt = 0;
        $.each(shopPriceList, (index, listData) => {
            let goodscode = listData.goodscode;
            let goodsname = listData.goodsname;
            let cardprice = listData.cardprice;
            let cardname = listData.cardname;
            let freeinterest = listData.freeinterest;
            let price = listData.price;
            let price2 = listData.price2;
            let shoptype = listData.shoptype;
            let plno = listData.plno;
            let delivery_text = listData.delivery_text;
            let shopcode = listData.shopcode;
            let shopname = listData.shopname;
            let shoplogo_check = listData.shoplogo_check;
            let delivery_price = listData.delivery_price;
            let cashmall_check = listData.cashmall_check;
            let oversea_check = listData.oversea_check;
            let bagdename = listData.badgename;
            let cardbadge = listData.cardbadge;
            let coupon = listData.coupon;
            let deliveryCod_check = listData.deliveryCod_check;
            let priceView = price;
            let bridgeUrl = prodCommon.bridgeUrl('move_link', `${shopcode}`, `${gModelData.gModelno}`, `${gModelData.gFactory}`, `${plno}`, `${coupon}`, `${price}`, 1);
            //할부
            let freeinterestAry = new Array();
            let firstFreeInterest = 0;
            let freeinterestView = "";
            freeinterestAry = convertFreeInterest(freeinterest).split('/');

            $.each(freeinterestAry, (i,v) => {
                if(v!=""){
                    v = v.replace(/,/gi, "/");
                    freeinterestView +=`<li>${v}</li>`;
                    var freeinterestMonth = v.match(/([0-9]{1,2}~?)개월/);
                    if(freeinterestMonth != null && freeinterestMonth[1].trim().length > 0){
                        var tmpMonth = parseInt(freeinterestMonth[1].trim().replace("~",""));
                        if(firstFreeInterest==0 || firstFreeInterest < tmpMonth){
                            firstFreeInterest = tmpMonth;
                            firstFreeInterestCnt++;
                      }
                  }
                }
            });
            if(shoptype=="4"){
                freeinterestView = "<li><p>최대 10개월<br>(카드정보 해당 페이지에서 확인가능)</p></li>";
                firstFreeInterest = 10;
                firstFreeInterestCnt++;
            }
            if ($.isNumeric(delivery_text)) {
                delivery_text = numComma(delivery_text) + "원";
            } else {
                delivery_text = delivery_text;
            }

            html += `<li class="${index == 0 ? `is-minline` : ``}" data-shopcode="${shopcode}" data-shoptype="${shoptype}">
                        <span class="col col-1">
                            <a href="${bridgeUrl}" target="_blank" class="logo">
                                ${shoplogo_check ? `<img src="${storageUrl}/logo/logo16/logo_16_${shopcode}.png" alt="${shopname}" onerror="$(this).replaceWith('${shopname}')">` : `<span>${shopname}</span>`}
                            </a>
                            ${bagdename != "" ? `<a href="${bridgeUrl}" target="_blank" class="badge badge--${bagdename}"></a>` : ``}
                            ${bagdename == "quick" ?
                    `<div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                    <div class="lay-comm--head">
                                        <strong class="lay-comm__tit">빠른배송</strong>
                                    </div>
                                    <div class="lay-comm--body">
                                        <div class="lay-comm__inner">
                                            <ul class="ins-list">
                                                <li>일정 시간 안에 주문한 건에 한하여 당일 발송하는 빠른배송 상품입니다.</li>
                                                <li>주문 시간에 따른 정확한 발송일은 해당 쇼핑몰 상품 상세페이지에서 꼭 확인해주세요!</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>` : ``}
                        </span>
                        <span class="col col-2">
                            <a href="${bridgeUrl}" target="_blank" class="price">
                            <span class="tx_msg">
                                ${index == 0 ? `최저가` : ``}
                                ${oversea_check ? `<i class="ico ico--direct"></i>` : ``}
                                ${cardbadge ? `<i class="ico ico--card"></i>` : ``}
                                ${cashmall_check ? `<i class="ico ico--cash"></i>` : ``}
                            </span>

                                 <span class="tx_price"><em>${numComma(priceView)}</em>원</span>
                            </a>
                        </span>
                        <span class="col col-3">
                            ${deliveryCod_check === true ? `<span class="delivery--cash">착불</span>
                                                            <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                <div class="lay-comm--head">
                                                                    <strong class="lay-comm__tit">착불/유무료</strong>
                                                                </div>
                                                                <div class="lay-comm--body">
                                                                    <div class="lay-comm__inner">
                                                                        <p class="tx_tit tx_stress">총 상품금액에 배송비가 포함되어 있지 않습니다.</p>
                                                                        <p class="tx_sub">쇼핑몰 이동 후 반드시 상품정보 및 가격을 다시 한번 확인하세요.</p>
                                                                    </div>
                                                                </div>
                                                            </div>` : `<span class="delivery">${delivery_text}</span>`}
                        </span>
                        ${firstFreeInterest > 0 ?
                            `<span class="col col-4">
                                <span class="discount_period">최대 ${firstFreeInterest}개월</span>
                                <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                    <div class="lay-comm--head">
                                        <strong class="lay-comm__tit">무이자할부</strong>
                                    </div>
                                    <div class="lay-comm--body">
                                        <div class="lay-comm__inner">
                                            <p class="tx_tit tx_tit--stress">결제 금액 및 카드사에 따라 무이자 혜택이 다를 수 있으니, 구매 전 반드시 확인하세요!</p>
                                            <ul class="ins-list">
                                            ${freeinterestView}
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </span>` : ``}
                    </li>`
        });
        if (Object.keys(priceTop).length > 0 && priceTop.ad_type === "A") {
            let phtml = ``;
            let adShopCode = priceTop.shop_code;
            let adClickTitle = priceTop.click_title;
            let adShopName = priceTop.mall_name;
            let adCopyText = priceTop.copytext;
            let shoplogo_check = priceTop.shoplogo_check;
            let adPrice = priceTop.price;
            let pl_no = priceTop.pl_no;
            let adshoppingfee = priceTop.shoppingfee;
            let url = priceTop.url;
            let bridgeUrl = "";
            if (url == "") {
                bridgeUrl = prodCommon.bridgeUrl('move_link', `${adShopCode}`, `${gModelData.gModelno}`, `${gModelData.gFactory}`, `${pl_no}`, `0`, `${adPrice}`, 1);
            } else {
                bridgeUrl = url;
            }
            html += `<li class="is-adline" data-type="ad" data-shopcode="${adShopCode}">
                        <span class="col col-1">
                            <a href="${bridgeUrl}" target="_blank" class="logo is-txt" data-ad="${adClickTitle}">
                            ${url != "" ?  `<span>${adShopName}</span>` :
                                 `${shoplogo_check ? `<img src="${storageUrl}/logo/logo16/logo_16_${adShopCode}.png" alt="${adShopName}" onerror="$(this).replaceWith('${adShopName}')">` : `<span>${adShopName}</span>`}`}
                             <i class="ico ico--ad"></i>
                            </a>
                            <p class="tx_sub">${adCopyText}</p>
                        </span>
                        <span class="col col-2">
                            <a href="${bridgeUrl}" target="_blank"  class="price" data-ad="${adClickTitle}">
                                <span class="tx_price"><em>${numComma(adPrice)}</em>원</span>
                            </a>
                        </span>
                        <span class="col col-3">
                            <span class="delivery">${adshoppingfee}</span>
                        </span>
                    </li>`;
            phtml = `<li>
                        <div class="tb_row">
                            <span class="col col-1">
                                <a href="${bridgeUrl}" target="_blank"  class="logo">
                                ${url != "" ?  `<span>${adShopName}</span>` :
                                `${shoplogo_check ? `<img src="${storageUrl}/logo/logo20/logo_20_${adShopCode}.png" alt="${adShopName}" onerror="$(this).replaceWith('${adShopName}')">` : `${adShopName}`}`}
                                </a>
                            </span>
                            <span class="col col-2">
                                <a href="${bridgeUrl}" target="_blank"  class="tx_name">${adCopyText}</a>
                                <span class="tx_delivery">${adshoppingfee}</span>
                            </span>
                            <span class="col col-3">
                                <a href="${bridgeUrl}" target="_blank"  class="tx_price"><em>${numComma(adPrice)}</em>원</a>
                            </span>
                        </div>
                    </li>`;
            //$("#prodSponsorPowerClick").html(phtml);
            //$("#prodSponsorPowerClick").show(phtml);
        } else {
            $("#prodSponsorPowerClick").empty();
            $("#prodSponsorPowerClick").hide();
        }

        html += `<li class="is-adline is-adjoin">
                    <span class="col col-1">
                        <a href="#" class="logo is-txt"><span>쇼핑몰 영역</span><i class="ico ico--ad"><!--AD--></i></a>
                        <p class="tx_sub">홍보문구 노출 영역</p>
                    </span>
                    <span class="col col-2">
                        <a href="#" class="price">
                            <span class="tx_price"><em>광고예시</em> 판매가, 배송비 정책 영역</span>
                        </a>
                    </span>
                    <span class="col col-3">
                        <a href="https://seller.enuri.com/sdul/pricetop/list.jsp" target="_blank" title="광고 신청하기" class="btn_add_apply">광고 신청하기</a>
                    </span>
                </li>`;

        if(firstFreeInterestCnt > 0) {
            $("#prod_shopprice").find(".m_price__list").addClass("column_forth")
        }else{
            $("#prod_shopprice").find(".m_price__list").removeClass("column_forth");
        }
        $("#prod_shopprice").find(".m_price__list").html(html);

        $("#prod_shopprice").find(".m_price__list li a").unbind().click(function(e){
            let vNowtime = new Date().format("yyyyMMddhhmm")*1;
            if(serviceNShopChkAlert){
                if($(this).parents("li").data("shoptype") == "4") {
                    alert("해당 쇼핑몰은 현재 서비스 점검 중입니다.");
                    return false;
                }
            }
            if(serviceChkAlert[$(this).parents("li").data("shopcode")] !== undefined){
                e.preventDefault();
                alert(serviceChkAlert[$(this).parents("li").data("shopcode")].contents);
                return false;
            }else{
                if($(this).parents("li").hasClass("is-adline")){
                    $("#hFrame").attr("src",$(this).data("ad"));
                }
                if($(this).hasClass("logo")){
                    insertLogLSV(18627,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                }else if($(this).hasClass("price")){
                    insertLogLSV(18628,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                }
                insertLogLSV(14515,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                ga('send','event','vip','summary_clickout','Lowestshop');
            }
        });

        $("#special_price").find(".s_price__list li").unbind().click(function(e){
            let specialType = $(this).data("type");
            let vNowtime = new Date().format("yyyyMMddhhmm")*1;
            if(serviceNShopChkAlert){
                if($(this).parents("li").data("shoptype") == "4") {
                    alert("해당 쇼핑몰은 현재 서비스 점검 중입니다.");
                    return false;
                }
            }
            if(serviceChkAlert[$(this).data("shopcode")] !== undefined){
                e.preventDefault();
                alert(serviceChkAlert[$(this).data("shopcode")].contents);
                return false;
            }else{
                if(specialType =="card"){
                    insertLogLSV(17518,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                }
                insertLogLSV(14515,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                ga('send','event','vip','summary_clickout','promotion');
            }

        });
        $("#prod_shopprice").find(".m_price__list li .btn_add_apply" ).hover(
            function(){
                $(this).closest(".is-adjoin").addClass("is-hover");
            }, function(){
                $(this).closest(".is-adjoin").removeClass("is-hover");
            }
        )
        $("#prod_shopprice").show();
    }
}
const prodVisitPriceView = (json) => {
    let visitViewFlag = false;
    if (json.success && json.total > 0) {
        let visitPriceJson = json.data.visitPrice;
        if (typeof visitPriceJson !== "undefined" && Object.keys(visitPriceJson).length > 0) {
            let collectDate = visitPriceJson["collectDate"];
            let dc_ratio = visitPriceJson["dc_ratio"];
            let diffPrice = visitPriceJson["diffPrice"];
            let visitPrice = visitPriceJson["visitPrice"];
            let shopMinPrice = visitPriceJson["goodsMinPrice"];

			if(dc_ratio >= 1){
				$("#discountInfo").html("에누리 쿠폰 <strong>"+parseInt(dc_ratio)+"%할인</strong> 적용중");
				$("#discountInfo").show();
			}else if(dc_ratio > 0){
				$("#discountInfo").html("에누리 쿠폰 할인 적용중");
				$("#discountInfo").show();
			}else{
				$("#discountInfo").hide();
			}

            if(dc_ratio < 5 && diffPrice < 1000){
                //미노출타입
                $("#summary_visitprice").hide();
            }else{
                //직방가 노출뷰
                insertLogLSV(26295,`${gModelData.gCategory}`,`${gModelData.gModelno}`);

                $("#summary_visitprice").find(".ins-list li").eq(0).html(collectDate+" 기준 할인 정보입니다.");
                $("#summary_visitprice").find(".d_currentMallPrice em").html(numComma(visitPrice));
                $("#summary_visitprice").find(".d_discountPrice em").html(numComma(diffPrice));
                $("#summary_visitprice").find(".d_enuriMinPrice em").html(numComma(shopMinPrice));
                $("#summary_visitprice").show();

                // 툴팁 노출
                $("#summary_visitprice").find(".btn_open_question").on("click", function(){
					$("#summary_visitprice .lay-tooltip").toggle();
                });
                visitViewFlag =  true;
            }
        }else{
            $("#summary_visitprice").hide();
            $("#discountInfo").hide();
        }
    }else{
	    $("#summary_visitprice").hide();
	    $("#discountInfo").hide();
	}
    return visitViewFlag;
};
const numComma = (x) => {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

