import * as prodCommon from "./prod_common.js";
let compTier = "";
let authImage = "";
let cardfilterCheck = false;
let similarModelCheck = false;
let goodsMinPrice = 0;
let leftObj = new Object();
let rightObj = new Object();
const storageUrl = "http://storage.enuri.info";

let param = {
    modelno : gModelData.gModelno,
    leftmore : 0,
    rightmore : 0,
    sort :"price",
    card :"N",
    delivery :"N",
    selshop : "",
    prono : promo,
    showcnt : ""
};
export const paramHandler = {
    set: (prop, value) => {
        if(prop=="leftmore" || prop=="rightmore"){
            param[prop] += value;
        }else{
            if(prop=="sort"){
                param["more"] = "N";
                param["mix"] = "N";
                param["selshop"] = "";
                param["leftmore"] = 0;
                param["rightmore"] = 0;
            }else if(prop=="mix"){
            }else if(prop=="selshop"){
                param["sort"] = "price";
                param["more"] = "N";
                param["mix"] = "N";
                param["leftmore"] = 0;
                param["rightmore"] = 0;
            }else if(prop=="card" || prop=="delivery"){
                param["sort"] = "price";
                param["leftmore"] = 0;
                param["rightmore"] = 0;
            }
            param[prop] = value;
            priceCompPromise().then(prodPriceCompView);
        }
        return true;
    },
    get : (prop) => {
        return param[prop];
    },
    init : () => {
        param["modelno"] = gModelData.gModelno;
        param["leftmore"] = 0;
        param["rightmore"] = 0;
        param["sort"] = "price";
        param["selshop"] = "";
        param["mix"] = "N";
        param["prono"] = "";
        param["showcnt"] = "";
    }
};

export const priceCompPromise = (data) => {
    if(typeof data !== 'undefined'){
        param = data;
    }
    return new Promise((resolve,reject) => {
        $.ajax({
            type: "post",
            url: "/wide/api/product/prodPrice.jsp",
            data: param,
            dataType: "json",
            success: (response) => {
                resolve(response);
            }, error : (error) => {
                reject(error);
            }
        });
    });
}


export const prodPriceCompView = (json) => {
    if(json.success && json.total > 0){
        leftObj = json.data.left;
        rightObj = json.data.right;

        let cashObj = json.data.cash;
        let selectShopObj = json.data.selectShopList;
        cardfilterCheck = json.data.cardfilterCheck;
        similarModelCheck =  json.data.similarModelCheck;
        goodsMinPrice = json.data.goodsMinPrice;
        compTier = json.data.goodsCompareTier;
        authImage = json.data.authCode;
        $("#tabPrice").find("a em").html(`(${json.total})`);
        $("#prod_comp_except").hide();
        //????????? ??????
        //??????????????? ?????? ?????? ?????????
        $("#prod_pricecomp").find(".comparison__head").show();
        $('#prod_pricecomp .input--checkbox-item').prop('checked',false);
        if(paramHandler.get("delivery") === 'Y') $("#deliveryInc-3").prop('checked', true);
        if(paramHandler.get("card") === 'Y') $("#cardsaleInc-3").prop('checked', true);

        //?????? ????????? ????????? ??????
        (!cardfilterCheck)
        ? $("#cardsaleInc-3").parent().hide()
        : $("#cardsaleInc-3").parent().show();

        $("#prod_pricecomp").find(".comparison__cont > div").data("all",false);
        /*$("#prod_pricecomp .sort_block .sort_chk input").unbind('click').click(function(){
            ($(this).is(':checked') === true)
            ? paramHandler.set(`${$(this).data('sort')}`, 'Y')
            : paramHandler.set(`${$(this).data('sort')}`, 'N');

            /*?????? ???????????? ??????
            // if(sort === "delivery"){
            //     insertLogLSV(14502,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
            //     ga('send','event','vip','comparison_sort','shipping');
            // }else if(sort == "card"){
            //     insertLogLSV(14504,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
            //     ga('send','event','vip','comparison_sort','creditpromotion');
            //     ga('send','event','vip','comparison_sort','Inclusion promotion');
            //     insertLogLSV(17519,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
            // }
        });*/

        //????????? ?????? layer
        prodPriceCompShopListView(selectShopObj);

        $("#prod_pricecomp").find(".comparison__cont .comparison__lt .comprod__list").empty();
        $("#prod_pricecomp").find(".comparison__cont .comparison__rt .comprod__list").empty();
        $("#prod_pricecomp").find(".similar__cont .similar__list").empty();
        //????????????
        if(similarModelCheck){
            prodPriceSimModelTierView(rightObj);
        }else{
            prodPriceCompTierView(leftObj,"left");
            prodPriceCompTierView(rightObj,"right");
            $("#prod_pricecomp").find(".comparison__cont").show();
        }
        prodCashPriceComShopListView(cashObj);
        //???????????? log
        if(authImage !=""){
            authInsertLog(1);
        }
        $("#prod_pricecomp .similar__cont").find("li.similar__item").on("click",function(){
            ga('send','event','vip','comparison_clickout','pricecomparison');
        });
        $("#prod_pricecomp .comparison__cont").find("li.comprod__item").on("click",function(){
            ga('send','event','vip','comparison_clickout','pricecomparison');
        });
        $("#prod_pricecomp .cashmall__cont").find("li.cashmall__item").on("click",function(){
            ga('send','event','vip','comparison_clickout','cashmall');
        })
    }else{

    }
}

const prodPriceCompTierView = (json,tier) => {
    let pricelistObj = json.priceList;
    let tmpPriceListArray = [];

    let pricelistObjCount = json.pricelistCount;
    let pricelistObjTitle = json.pricelistTitle;
    let pricelistCaution = json.cautionInfo;
    let pricelistOpt = json.optInfo;
    let html =``;
    let srcPricelistIdx = 0;
    let drcPricelistIdx = 0;
    let gapPricelistIdx = 50;
    let bannerIdx = -1;
    let etcIdx = -1;
    let bannerHtml = "";
    let etcHtml ="";

    if(tier=="right"){
        if(pricelistObjCount < 4){
            etcIdx = pricelistObjCount;
        }else{
            bannerIdx = 3;
            etcIdx = 3;
        }
        bannerHtml = prodCommon.prodBannerPromise("comp");
        etcHtml += prodCautionInfoView(pricelistCaution);
        etcHtml += prodOptInfoView(pricelistOpt);
    }
    let domObj;
    if(tier == "left"){
        srcPricelistIdx = (paramHandler.get("leftmore") > 0) ? (paramHandler.get("leftmore")-1)*gapPricelistIdx+9 : 0;
        drcPricelistIdx = (paramHandler.get("leftmore")*gapPricelistIdx+9 < pricelistObjCount) ? paramHandler.get("leftmore")*gapPricelistIdx+9 : pricelistObjCount;
        domObj = $("#prod_pricecomp").find(".comparison__cont .comparison__lt");
    }else{
        srcPricelistIdx = (paramHandler.get("rightmore") > 0) ? (paramHandler.get("rightmore")-1)*gapPricelistIdx+9 : 0;
        drcPricelistIdx = (paramHandler.get("rightmore")*gapPricelistIdx+9 < pricelistObjCount) ? paramHandler.get("rightmore")*gapPricelistIdx+9 : pricelistObjCount;
        domObj = $("#prod_pricecomp").find(".comparison__cont .comparison__rt");
    }
    tmpPriceListArray = pricelistObj.slice(srcPricelistIdx,drcPricelistIdx);

    domObj.find(".head__box").html(prodPriceComTierTitleView(pricelistObjTitle,tier));

    if(pricelistObjCount > 0){
        $.each(tmpPriceListArray, (index,listData) => {
            let badgename = listData.badgename;
            let cardevnt_text = listData.cardevnt_text;
            let cardname = listData.cardname;
            let cardprice = listData.cardprice;
            let cardprice2 = listData.cardprice2;
            let delivery_price = listData.delivery_price;
            let delivery_text = listData.delivery_text;
            let emoney_reward = listData.emoney_reward;
            let freeinterest = listData.freeinterest;
            let goodscode = listData.goodscode;
            let goodsname = listData.goodsname;
            let imageurl = listData.imageurl;
            let instanceprice = listData.instanceprice;
            let option_check = listData.option_check;
            let plno = listData.plno;
            let price = listData.price;
            let price2 = listData.price2;
            let shopcode = listData.shopcode;
            let shopname = listData.shopname;
            let shoptype = listData.shoptype;
            let coupon = listData.coupon;
            let coupon_contents = listData.coupon_contents;

            let oversea_check = listData.oversea_check;
            let overseaEmoney_check = listData.overseaEmoney_check;
            let overseaShopping_check = listData.overseaShopping_check;
            let tlcshop_check = listData.tlcshop_check;
            let mobileprice_check = listData.mobileprice_check;
            let shoplogo_check = listData.shoplogo_check;
            let ad_check = listData.ad_check;
            let seller_ad = listData.seller_ad;
            let promotion_cpnDcAmt = listData.promotion_cpnDcAmt;
            let promotion_cpnDcCode = listData.promotion_cpnDcCode;
            let promotion_cpnDcPrice = listData.promotion_cpnDcPrice;
            let promotion_cpnDcView = listData.promotion_cpnDcView;
            let promotion_cpnIconView = listData.promotion_cpnIconView;
            let promotion_cpnMiniVipIconView = listData.promotion_cpnMiniVipIconView;
            let promotion_cpnMiniVipIconViewText = listData.promotion_cpnMiniVipIconViewText;
            let promotion_cpnRandUrl = listData.promotion_cpnRandUrl;
            let promotion_cpnRate = listData.promotion_cpnRate;
            let promotion_cpnViewDcd = listData.promotion_cpnViewDcd;
            let promotion_cpnViewText = listData.promotion_cpnViewText;
            let deliveryCod_check = listData.deliveryCod_check;


            let bridgeUrl =prodCommon.bridgeUrl('move_link',`${shopcode}`,`${gModelData.gModelno}`,`${gModelData.gFactory}`,`${plno}`,`${coupon}`,`${price}`,1)
            let minprice_check = false;
            let delivery_textView ="";
            let freeinterestAry = new Array();
            let firstFreeInterest = 0;
            let freeinterestView = "";
            let priceView = 0;
            if(seller_ad != ""){ //????????? ?????? ??????
                setSellerAdLog(plno);
            }
            if($.isNumeric(delivery_text)){
                if(param.card =="Y" && param.delivery =="Y"){
                    delivery_textView = numComma(delivery_text) + "??? (???????????? "+ (cardname !="" ? numComma(cardprice) : numComma(price) )  +"???)";
                }else if(param.delivery =="Y"){
                    delivery_textView = numComma(delivery_text) + "??? (???????????? "+ numComma(price)  +"???)";
                }else if (param.card =="Y") {
                    delivery_textView = numComma(delivery_text) + "??? (???????????? "+ (cardname !="" ? numComma(cardprice2) : numComma(price2))  +"???)";
                }else{
                    delivery_textView = numComma(delivery_text) + "??? (???????????? "+ numComma(price2) +"???)";
                }
            }else{
                if(!deliveryCod_check) delivery_textView = "("+delivery_text+")";
            }

            if(param.sort=="price"){
                if(param.delivery=="Y" && param.card=="Y"){
                    if(cardname !=""){
                        priceView = cardprice2;
                    }else {
                        priceView = price2;
                    }
                }else if(param.delivery=="Y"){
                    priceView = price2;
                }else if(param.card=="Y"){
                    if(cardname !=""){
                        priceView = cardprice;
                    }else {
                        priceView = price;
                    }
                }else{
                    priceView = price;
                }
            }
            if(priceView===goodsMinPrice){
                minprice_check = true;
            }
              //??????

              freeinterestAry = convertFreeInterest(freeinterest).split('/');

            $.each(freeinterestAry, (i,v) => {
                if(v!=""){
                    v = v.replace(/,/gi, "/");
                    freeinterestView +=`<li>${v}</li>`;
                    var freeinterestMonth = v.match(/([0-9]{1,2}~?)??????/);
                    if(freeinterestMonth != null && freeinterestMonth[1].trim().length > 0){
                        var tmpMonth = parseInt(freeinterestMonth[1].trim().replace("~",""));
                        if(firstFreeInterest==0 || firstFreeInterest < tmpMonth){
                            firstFreeInterest = tmpMonth;
                        }
                    }
                }
            });
            if(shoptype=="4"){
                freeinterestView = "<li><p>?????? 10??????<br>(???????????? ?????? ??????????????? ????????????)</p></li>";
                firstFreeInterest = 10;
            }

            // ???????????? ??? ??????????????? ?????? ??????????????? ??????.
            if(goodsname === "") goodsname = gModelData.gModelNmView;

            html +=`<li class="comprod__item ${ad_check && param.sort=="price" ? `is-top` :``}" data-shoptype=${shoptype} data-shopcode=${shopcode} data-goodscode=${goodscode} data-plno=${plno} data-delivery=${delivery_text} data-price=${priceView}>
                        <div class="col col--lt">
                            <a href="${bridgeUrl}" target="_blank" class="tx_shop" onclick="insertLogLSV(14515,'${gModelData.gCategory}','${gModelData.gModelno}');">
                            ${shoplogo_check ? `<img src="${storageUrl}/logo/logo20/logo_20_${shopcode}.png" alt="${shopname}" onerror="$(this).replaceWith('${shopname}')">` : `${shopname}`}
                            </a>
                            ${badgename != "" ? `<a href="${bridgeUrl}" target="_blank" class="badge badge--${badgename}">????????????</a>` : ``}
                            ${badgename=="quick" ?
                                                `<div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                    <div class="lay-comm--head">
                                                        <strong class="lay-comm__tit">????????????</strong>
                                                    </div>
                                                    <div class="lay-comm--body">
                                                        <div class="lay-comm__inner">
                                                            <ul class="ins-list">
                                                                <li>?????? ?????? ?????? ????????? ?????? ????????? ?????? ???????????? ???????????? ???????????????.</li>
                                                                <li>?????? ????????? ?????? ????????? ???????????? ?????? ????????? ?????? ????????????????????? ??? ??????????????????!</li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>` :``}
                        </div>
                        <div class="col col--rt">
                            <div class="pinfo__group">
                                <div class="line__price">
                                    <a href="${bridgeUrl}" target="_blank" class="tx_price" onclick="insertLogLSV(14515,'${gModelData.gCategory}','${gModelData.gModelno}');">
                                        <em>${numComma(priceView)}</em>???
                                    </a>
                                    <span class="tx_delivery">${delivery_textView}</span>
                                    ${minprice_check ? `<i class="badge badge--minp">?????????</i>` : ``}
                                    ${mobileprice_check ? `<i class="badge badge--mspecial" onclick="$(this).siblings('.lay-mobile-min').toggle();setQrCodeImg(); ">???????????????</i>
                                                        <div class="lay-mobile-min lay-comm" style="display: none;">
                                                            <div class="lay-comm--head">
                                                                <strong class="lay-comm__tit">??????????????? ?????? ??? ??? ???????????????.</strong>
                                                            </div>
                                                            <div class="lay-comm--body">
                                                                <div class="lay-comm--inner">
                                                                    <div class="lay-mobile__qr">
                                                                        <img src="//img.enuri.info/images/home/@qr.gif" alt="">
                                                                    </div>
                                                                    <div class="lay-mobile__cont">
                                                                        <p class="tx_price"><em>${numComma(instanceprice)}</em>???</p>
                                                                        <div class="lay-mobile__tx">
                                                                            ????????? ?????? ?????? QR ????????? ??????????????????, <br>
                                                                            ??????????????? ?????? ????????? ?????????!
                                                                        </div>
                                                                        <div class="lay-mobile__btn">
                                                                            <button class="btn-mobile--zzim ${gModelData.gZzim ? `is--on` : ``}" onclick="showLayZzim(this,${gModelData.gModelno});">???</button>
                                                                            <button class="btn-mobile--sendsms" onclick="$(this).closest('.lay-comm').find('.lay-mobile-sendsms').toggle();">????????? ??????</button>
                                                                            <button class="btn-mobile--app" onclick="window.open('/common/jsp/App_Landing.jsp');">???????????? ??????</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="lay-mobile-sendsms" style="display:none">
                                                                    <div class="sendsms__form">
                                                                        <fieldset>
                                                                            <legend>SMS?????????</legend>
                                                                            <input type="text" class="sendsms__form--inp" placeholder="- ?????? ???????????????">
                                                                            <button class="sendsms__form--btn" onclick="sendDetailSms(this, 'detail');">??????</button>
                                                                        </fieldset>
                                                                    </div>
                                                                    <span class="sendsms__send-url--tx">- ?????? ?????? ????????? ??????????????? ?????????????????????.</span>
                                                                    <span class="sendsms__send-url--tx">- ???????????? ????????? ???????????? ????????????.</span>
                                                                </div>
                                                            </div>
                                                            <!-- ?????? : ????????? ?????? -->
                                                            <button class="lay-comm__btn--close comm__sprite" onclick="$(this).parent().hide()">????????? ??????</button>
                                                        </div>` : ``}
                                    ${cardname !="" && (param.card=="Y") ? `<i class="badge badge--card">${cardname}</i>`: ``}
                                    ${oversea_check ? `<i class="badge badge--direct">??????</i>` : ``}
                                    ${ad_check && param.sort=="price" ? `<i class="badge badge--ad">AD</i>` :``}
                                    ${deliveryCod_check === true ? `<div class="delicash">
                                                                    <span class="delivery--cash">??????</span>
                                                                    <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                        <div class="lay-comm--head">
                                                                            <strong class="lay-comm__tit">??????/?????????</strong>
                                                                        </div>
                                                                        <div class="lay-comm--body">
                                                                            <div class="lay-comm__inner">
                                                                                <p class="tx_tit tx_stress">??? ??????????????? ???????????? ???????????? ?????? ????????????.</p>
                                                                                <p class="tx_sub">????????? ?????? ??? ????????? ???????????? ??? ????????? ?????? ?????? ???????????????.</p>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>` :``}
                                    ${cardname !="" ? ` <div class="tx_cardprice">
                                                            <a href="${bridgeUrl}" target="_blank"  class="tx_price" onclick="insertLogLSV(14515,'${gModelData.gCategory}','${gModelData.gModelno}');">
                                                                <em>${(param.card=="Y" && param.delivery=="Y") ? numComma(price2) : 
                                                                        (param.card=="Y") ? numComma(price) : numComma(cardprice) }</em>???
                                                                ${!(param.card=="Y") ? `<span class="tx_card">${cardname}</span>` : ``}
                                                            </a>
                                                        </div>`: ``}
                                </div>
                                <div class="line__info">
                                    ${promotion_cpnViewDcd=="M" ? `<div class="tx_coupon">
                                                                        <span class="tx_name">${promotion_cpnViewText}</span>
                                                                        ${promotion_cpnIconView=="Y" ? `<a href="${promotion_cpnRandUrl}" target="_blank" class="btn btn--coupon">????????????</a>` : ``}
                                                                    </div>` : ``}
                                    ${(promotion_cpnViewDcd=="C" && promotion_cpnViewText !="") ? `<a href="${promotion_cpnRandUrl}" target="_blank" class="tx_promotion">${shopname} ${promotion_cpnViewText} ${numComma(promotion_cpnDcPrice)}???</a>` : ``}
                                    ${oversea_check ? ` <div class="tx_direct">
                                                            <span class="tx_txt">?????? ??? ??????????????? ????????? ??? ???????????????!</span>
                                                        </div>` : ``}
                                    ${shopcode==6641 ? `<div class="tx_timon">
                                                            <span class="tx_txt">[??????] PC?????? ?????? ??? e?????? ??????!</span>
                                                        </div>` :`` }
                                    ${seller_ad !="" ? `<div class="tx_direct"><span class="tx_txt">${seller_ad}</span></div>` : ``}
                                    ${promotion_cpnRandUrl =="C" ? `<a href="${promotion_cpnRandUrl}" class="tx_promotion">${promotion_cpnViewText} ${numComma(promotion_cpnDcPrice)}???</a>`: ``}
                                    <a href="${bridgeUrl}" target="_blank" class="tx_prodname" onclick="insertLogLSV(14515,'${gModelData.gCategory}','${gModelData.gModelno}');">${goodsname}</a>
                                </div>
                            </div>
                        </div>
                        <div class="btn__group">
                            <ul class="btn__list">
                                <li class="abs--singo"><button type="button" class="btn btn--singo">??????</button></li>
                                ${option_check ? `<li><button type="button" class="btn btn--opt">????????????</button></li>` : ``}
                                ${cardname != "" ? `<li>
                                                        <button type="button" class="btn btn--card">????????????</button>
                                                            <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                <div class="lay-comm--head">
                                                                    <strong class="lay-comm__tit">????????????</strong>
                                                                </div>
                                                                <div class="lay-comm--body">
                                                                    <div class="lay-comm__inner">
                                                                        ${cardname}<br>
                                                                        ${cardevnt_text} (????????? : ${numComma(cardprice)}???)
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </li>` : `` }
                                ${freeinterestView !="" ? `<li>
                                                            ${firstFreeInterest > 0 ? `<button type="button" class="btn btn--infree-type2">????????? ?????? ${firstFreeInterest}??????</button>` : `<button type="button" class="btn">??????</button>`}
                                                            <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                <div class="lay-comm--head">
                                                                    <strong class="lay-comm__tit">???????????????</strong>
                                                                </div>
                                                                <div class="lay-comm--body">
                                                                    <div class="lay-comm__inner">
                                                                        <p class="tx_tit tx_tit--stress">?????? ?????? ??? ???????????? ?????? ????????? ????????? ?????? ??? ?????????, ?????? ??? ????????? ???????????????!</p>
                                                                        <ul class="ins-list">
                                                                        ${freeinterestView}
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </li>` :``}
                                ${coupon_contents != "" ? `<li>
                                                                <button type="button" class="btn">??????</button>
                                                                <div class="lay-tooltip lay-comm lay-comm--sm lay-coupon" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                    <div class="lay-comm--head">
                                                                        <strong class="lay-comm__tit">??? ????????? <em>???????????? ??????</em> ????????? ?????????.</strong>
                                                                    </div>
                                                                    <div class="lay-comm--body">
                                                                        <div class="lay-comm__inner">
                                                                            ${coupon_contents}
                                                                            <div class="lay-coupon__price">
                                                                                ?????? ????????? : <em>${numComma(price)}</em>???
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </li>`: ``}
                                ${overseaShopping_check ? `<li>
                                                                <button type="button" class="btn btn--global">????????????</button>
                                                                <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                    <div class="lay-comm--head">
                                                                        <strong class="lay-comm__tit">???????????? ????????????</strong>
                                                                    </div>
                                                                    <div class="lay-comm--body">
                                                                        <div class="lay-comm__inner">
                                                                            ??????????????? ??????????????? ???????????????<br>
                                                                            ??????, ?????? ??? A/S??? ????????? ??? ????????????.
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </li>` : ``}
                                ${tlcshop_check ? `<li>
                                                        <button type="button" class="btn">TLC?????????</button>
                                                        <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                            <div class="lay-comm--head">
                                                                <strong class="lay-comm__tit">TLC?????????</strong>
                                                            </div>
                                                            <div class="lay-comm--body">
                                                                <div class="lay-comm__inner">
                                                                    <p class="tx_tit">NH?????? Shopping&amp;TLC????????? 36?????? ?????? ??????</p>

                                                                    <ul class="ins-list">
                                                                        <li>?????? ?????? ?????? ?????? ?????? ?????? ?????? 22,000??? ????????????(20,000??? ??????+2,000??? ?????????)</li>
                                                                        <li>?????? ??????????????? 576,000??? ??????</li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </li>` : ``}
                                ${oversea_check ? `<li>
                                                        <button type="button" class="btn btn--direct">????????????</button>
                                                        <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                            <div class="lay-comm--head">
                                                                <strong class="lay-comm__tit">????????????</strong>
                                                            </div>
                                                            <div class="lay-comm--body">
                                                                <div class="lay-comm__inner">
                                                                    ???????????? ?????? ???????????? ???????????? ?????? ?????? ??? ???????????? ?????? ????????? ?????? ?????? ??????????????? ??????????????? ????????????.
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </li>` : ``}
                                ${overseaEmoney_check ? `<li>
                                                            <span class="tx_emoney--direct"><i class="ico ico--e">e??????</i>??????</span>
                                                            <div class="lay-tooltip lay-comm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                <div class="lay-comm--head">
                                                                    <strong class="lay-comm__tit">???????????? e?????? ????????????</strong>
                                                                </div>
                                                                <div class="lay-comm--body">
                                                                    <div class="lay-comm__inner">
                                                                        <p class="tx_tit">????????? PC/????????? ??? ?????? ?????? ????????? ???<br>???????????? ?????? ????????? ?????? 6.5% e????????? ???????????? ??? ????????????.</p>
                                                                        <p class="tx_sub">????????????</p>
                                                                        <ul class="ins-list">
                                                                            <li>????????? ????????? ???????????? ????????????.</li>
                                                                            <li>????????? ?????? ?????? ??? ????????? ?????? ?????? ??? ????????? ????????? ?????? ??? ????????????.</li>
                                                                            <li>????????? ????????? ??????, ??????, ?????? ?????? ?????? ??? ?????? ?????? ????????? e?????? ???????????? ???????????????.</li>
                                                                            <li>?????????, ?????????/???????????? ??????, ?????????, ????????? ????????? ????????? ?????? ?????? ???????????? e????????? ????????? ????????????.</li>
                                                                            <li>??????????????? ????????? ?????? ?????? ???????????? ?????? ??? ????????????.</li>
                                                                            <li>???????????? ???????????? ????????? ???????????? e????????? ???????????? ???????????? ?????? ?????????????????? ?????? ????????? ????????? ???????????? e????????? ???????????? ????????????.</li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </li>` : ``}
                                ${emoney_reward > 0 ? `<li><button type="button" class="btn btn--emoney" onclick="$('#EMONEYLAYER').show();insertLogLSV(14507,'${gModelData.gCategory}','${gModelData.gModelno}');"><i class="ico ico--e">e??????</i><em>${numComma(emoney_reward)}</em>??? ??????</button></li>` : ``}
                            </ul>
                        </div>
                    </li>`;
            if(paramHandler.get("rightmore")==0){
                if(bannerIdx==index+1){
                    if(bannerHtml.length > 0){
                        html += bannerHtml;
                    }
                }
                if(etcIdx==index){
                    html +=etcHtml;
                }
            }
        });
        domObj.find(".comprod__list").append(html);
    }else{
        html += `<li class="comprod__item no-data">
                    <p class="tx_msg">?????? ???????????? ????????????.</p>
                </li>`
        if(paramHandler.get("rightmore")==0){
            if(bannerHtml.length > 0){
                html += bannerHtml;
            }
            if(etcHtml.length > 0){
                html +=etcHtml;
            }
        }
        domObj.find(".comprod__list").html(html);
    }


    domObj.find(".comprod__item .col a").unbind().click(function(e){
        let vNowtime = new Date().format("yyyyMMddhhmm")*1;
        if(serviceNShopChkAlert){
            if($(this).parents("li").data("shoptype") == "4") {
                alert("?????? ???????????? ?????? ????????? ?????? ????????????.");
                return false;
            }
        }
        if(serviceChkAlert[$(this).parents("li").data("shopcode")] !== undefined){
            e.preventDefault();
            alert(serviceChkAlert[$(this).parents("li").data("shopcode")].contents);
            return false;
        }else{
            if(authImage !=""){
                authInsertLog(2);
            }
        }


    });
    domObj.find(".comprod__item .btn--opt").click(function(){
        let $item = $(this).parents(".comprod__item");
        let moveLink = $item.find('.col--rt .line__price .tx_price').eq(0).attr('href');
        if($item.hasClass("is-option")){
            $item = $(this).parents(".opt_item");
            moveLink = $item.find('.col.col-1 .thum__logo').attr('href');
            insertLogLSV(14511,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
        }else{
            insertLogLSV(14508,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
        }
        addOptionCtu($item.data('shopcode'),$item.data('goodscode'),$item.data('plno'),$item.data('delivery'),$item.data('price'),moveLink);
    });

    domObj.find(".comprod__item .abs--singo").unbind().click(function(){
        insertLogLSV(14509,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
        prodCommon.declaration.layerDeclaration($(this));
    });

    if(paramHandler.get("leftmore")==0 && paramHandler.get("rightmore")==0){
        if(pricelistObjCount < 10){
            domObj.find(".cont__box .adv-search__btn--close").hide();
            domObj.find(".cont__box .adv-search__btn--more").hide();
        }else{
            domObj.find(".cont__box .adv-search__btn--more").show();
            domObj.find(".cont__box .adv-search__btn--close").hide();
        }
    }else{
        if(pricelistObjCount < 10){
            domObj.find(".cont__box .adv-search__btn--close").hide();
            domObj.find(".cont__box .adv-search__btn--more").hide();
        }else{
            if(drcPricelistIdx < pricelistObjCount){
                domObj.find(".cont__box .adv-search__btn--more").show();
                domObj.find(".cont__box .adv-search__btn--close").hide();
            }else{
                if(drcPricelistIdx == pricelistObjCount) domObj.data("all",true);
                domObj.find(".cont__box .adv-search__btn--close").show();
                domObj.find(".cont__box .adv-search__btn--more").hide();
            }
        }
    }
    domObj.find(".cont__box .adv-search__btn--more").unbind().click(function(){
        insertLogLSV(14512,`${gModelData.gCategory}`,`${gModelData.gModelno}`);

        let allFlag = false;
        $.each($("#prod_pricecomp").find(".comparison__cont > div"),function(index,obj){
            if($(obj).data("all")){
                allFlag = true;
                $(obj).find(".cont__box .adv-search__btn--close").show();
                $(obj).find(".cont__box .adv-search__btn--more").hide();
            }
        });
        if(allFlag){
            if(!domObj.data("all")){
                if(domObj.find(".cont__box").hasClass("is-unfold")){
                    if(tier=="left"){
                        paramHandler.set("leftmore",1);
                        prodPriceCompTierView(leftObj,"left");
                    }else{
                        paramHandler.set("rightmore",1);
                        prodPriceCompTierView(rightObj,"right");
                    }
                }
            }
        }else{
            paramHandler.set("leftmore",1);
            prodPriceCompTierView(leftObj,"left");
            paramHandler.set("rightmore",1);
            prodPriceCompTierView(rightObj,"right");
        }
        $("#prod_pricecomp").find(".cont__box").addClass("is-unfold");
    });
    domObj.find(".cont__box .adv-search__btn--close").unbind().click(function(){
        $("html,body").stop(true,false).animate({"scrollTop": $("#prod_pricecomp").offset().top - 150},500);
        //domObj.data("all",true);
        if(leftObj.pricelistCount > 9){
            $("#prod_pricecomp").find(".comparison__lt .cont__box").removeClass("is-unfold");
            $("#prod_pricecomp").find(".comparison__lt .adv-search__btn--more").show();
            $("#prod_pricecomp").find(".comparison__lt .adv-search__btn--close").hide();
        }
        if(rightObj.pricelistCount > 9){
            $("#prod_pricecomp").find(".comparison__rt .cont__box").removeClass("is-unfold");
            $("#prod_pricecomp").find(".comparison__rt .adv-search__btn--more").show();
            $("#prod_pricecomp").find(".comparison__rt .adv-search__btn--close").hide();
        }
    });
}
const prodPriceSimModelTierView = (json) =>{
    let pricelistObj = json.priceList;
    let tmpPriceListArray = [];

    let pricelistObjCount = json.pricelistCount;
    let pricelistObjTitle = json.pricelistTitle;

    let html =``;
    let srcPricelistIdx = 0;
    let drcPricelistIdx = 0;
    let gapPricelistIdx = 50;
    let domObj;

    srcPricelistIdx = (paramHandler.get("rightmore") > 0) ? (paramHandler.get("rightmore")-1)*gapPricelistIdx+9 : 0;
    drcPricelistIdx = (paramHandler.get("rightmore"))*gapPricelistIdx+9;
    tmpPriceListArray = pricelistObj.slice(srcPricelistIdx,drcPricelistIdx);
    if(pricelistObjCount > 0){

        $.each(tmpPriceListArray, (index,listData) => {
            let badgename = listData.badgename;
            let cardevnt_text = listData.cardevnt_text;
            let cardname = listData.cardname;
            let cardprice = listData.cardprice;
            let cardprice2 = listData.cardprice2;
            let delivery_price = listData.delivery_price;
            let delivery_text = listData.delivery_text;
            let emoney_reward = listData.emoney_reward;
            let freeinterest = listData.freeinterest;
            let goodscode = listData.goodscode;
            let goodsname = listData.goodsname;
            let imageurl = listData.imageurl;
            let instanceprice = listData.instanceprice;
            let option_check = listData.option_check;
            let plno = listData.plno;
            let price = listData.price;
            let price2 = listData.price2;
            let shopcode = listData.shopcode;
            let shopname = listData.shopname;
            let shoptype = listData.shoptype;

            let coupon_contents = listData.coupon_contents;

            let oversea_check = listData.oversea_check;
            let overseaEmoney_check = listData.overseaEmoney_check;
            let overseaShopping_check = listData.overseaShopping_check;
            let tlcshop_check = listData.tlcshop_check;
            let mobileprice_check = listData.mobileprice_check;
            let ad_check = listData.ad_check;
            let shoplogo_check = listData.shoplogo_check;
            let coupon = listData.coupon;
            let promotion_cpnDcAmt = listData.promotion_cpnDcAmt;
            let promotion_cpnDcCode = listData.promotion_cpnDcCode;
            let promotion_cpnDcPrice = listData.promotion_cpnDcPrice;
            let promotion_cpnDcView = listData.promotion_cpnDcView;
            let promotion_cpnIconView = listData.promotion_cpnIconView;
            let promotion_cpnMiniVipIconView = listData.promotion_cpnMiniVipIconView;
            let promotion_cpnMiniVipIconViewText = listData.promotion_cpnMiniVipIconViewText;
            let promotion_cpnRandUrl = listData.promotion_cpnRandUrl;
            let promotion_cpnRate = listData.promotion_cpnRate;
            let promotion_cpnViewDcd = listData.promotion_cpnViewDcd;
            let promotion_cpnViewText = listData.promotion_cpnViewText;

            let bridgeUrl =prodCommon.bridgeUrl('move_link',`${shopcode}`,`${gModelData.gModelno}`,`${gModelData.gFactory}`,`${plno}`,`${coupon}`,`${price}`,1)

            let minprice_check = false;
            let delivery_textView ="";
            let freeinterestView = "";
            let priceView = 0;

            if($.isNumeric(delivery_text)){
                if(param.card =="Y" && param.delivery =="Y"){
                    delivery_textView = numComma(delivery_text) + "??? (???????????? "+ (cardname !="" ? numComma(cardprice) : numComma(price) )  +"???)";
                }else if(param.delivery =="Y"){
                    delivery_textView = numComma(delivery_text) + "??? (???????????? "+ numComma(price)  +"???)";
                }else if (param.card =="Y") {
                    delivery_textView = numComma(delivery_text) + "??? (???????????? "+ (cardname !="" ? numComma(cardprice2) : numComma(price2))  +"???)";
                }else{
                    delivery_textView = numComma(delivery_text) + "??? (???????????? "+ numComma(price2) +"???)";
                }
            }else{
                delivery_textView = "("+delivery_text+")";
            }

            if(param.sort=="price"){
                if(param.delivery=="Y" && param.card=="Y"){
                    if(cardname !=""){
                        priceView = cardprice2;
                    }else {
                        priceView = price2;
                    }
                }else if(param.delivery=="Y"){
                    priceView = price2;
                }else if(param.card=="Y"){
                    if(cardname !=""){
                        priceView = cardprice;
                    }else {
                        priceView = price;
                    }
                }else{
                    priceView = price;
                }
            }
            if(priceView===goodsMinPrice){
                minprice_check = true;
            }
            //??????
            let freeinterestAry = new Array();
            freeinterestAry = convertFreeInterest(freeinterest).split('/');
            $.each(freeinterestAry, (i,v) => {
                if(v!=""){
                    v = v.replace(/,/gi, "/");
                    freeinterestView +=`<li>${v}</li>`;
                }
            });
            if(shoptype=="4"){
                freeinterestView = `<li><p>?????? 10??????<br>(???????????? ?????? ??????????????? ????????????)</p></li>`;
            }
            html += `<li class="similar__item"  data-shoptype=${shoptype} data-shopcode=${shopcode} data-goodscode=${goodscode} data-plno=${plno}  data-delivery=${delivery_text} data-price=${priceView}>
                        <div class="col col-1">
                            <a class="thum__link" href="${bridgeUrl}" target="_blank" onclick="insertLogLSV(14515,'${gModelData.gCategory}','${gModelData.gModelno}');">
                                <img src="${imageurl}" alt="${shopname}">
                            </a>
                        </div>
                        <div class="col col-2">
                            <div class="badge__group">
                                    ${mobileprice_check ? `<i class="badge badge--mspecial">???????????????</i>` : ``}
                                    ${cardname !="" && (param.card=="Y") ? `<i class="badge badge--card">${cardname}</i>`: ``}
                                    ${ad_check && param.sort=="price" ? `<i class="badge badge--ad">AD</i>` :``}
                                    ${coupon_contents != "" ? `<i class="badge badge--coupon">??????</i>` : ``}
                            </div>

                            <a href="${bridgeUrl}" target="_blank" class="tx_link" onclick="insertLogLSV(14515,'${gModelData.gCategory}','${gModelData.gModelno}');">${goodsname}</a>

                            <div class="btn__group">
                                <ul class="btn__list">
                                    <li class="abs--singo"><button type="button" class="btn btn--singo" onclick="$('#SINGOLAYER').show()">??????</button></li>
                                    ${option_check ? `<li><button type="button" class="btn btn--opt">????????????</button></li>` : ``}
                                    ${cardname != "" ? `<li>
                                                            <button type="button" class="btn btn--card">????????????</button>
                                                                <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                    <div class="lay-comm--head">
                                                                        <strong class="lay-comm__tit">????????????</strong>
                                                                    </div>
                                                                    <div class="lay-comm--body">
                                                                        <div class="lay-comm__inner">
                                                                            ${cardname}<br>
                                                                            ${cardevnt_text} (????????? : ${numComma(cardprice)}???)
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </li>` : `` }
                                    ${freeinterest !="" ? `<li>
                                                                <button type="button" class="btn">??????</button>
                                                                <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                    <div class="lay-comm--head">
                                                                        <strong class="lay-comm__tit">???????????????</strong>
                                                                    </div>
                                                                    <div class="lay-comm--body">
                                                                        <div class="lay-comm__inner">
                                                                            <ul class="ins-list">
                                                                            ${freeinterestView}
                                                                            </ul>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </li>` :``}
                                    ${coupon_contents != "" ? `<li>
                                                                    <button type="button" class="btn">??????</button>
                                                                    <div class="lay-tooltip lay-comm lay-comm--sm lay-coupon" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                        <div class="lay-comm--head">
                                                                            <strong class="lay-comm__tit">??? ????????? <em>???????????? ??????</em> ????????? ?????????.</strong>
                                                                        </div>
                                                                        <div class="lay-comm--body">
                                                                            <div class="lay-comm__inner">
                                                                                ${coupon_contents}
                                                                                <div class="lay-coupon__price">
                                                                                    ?????? ????????? : <em>${numComma(price)}</em>???
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </li>`: ``}
                                    ${overseaShopping_check ? `<li>
                                                                    <button type="button" class="btn btn--global">????????????</button>
                                                                    <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                        <div class="lay-comm--head">
                                                                            <strong class="lay-comm__tit">???????????? ????????????</strong>
                                                                        </div>
                                                                        <div class="lay-comm--body">
                                                                            <div class="lay-comm__inner">
                                                                                ??????????????? ??????????????? ???????????????<br>
                                                                                ??????, ?????? ??? A/S??? ????????? ??? ????????????.
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </li>` : ``}
                                    ${tlcshop_check ? `<li>
                                                            <button type="button" class="btn">TLC?????????</button>
                                                            <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                <div class="lay-comm--head">
                                                                    <strong class="lay-comm__tit">TLC?????????</strong>
                                                                </div>
                                                                <div class="lay-comm--body">
                                                                    <div class="lay-comm__inner">
                                                                        <p class="tx_tit">NH?????? Shopping&amp;TLC????????? 36?????? ?????? ??????</p>

                                                                        <ul class="ins-list">
                                                                            <li>?????? ?????? ?????? ?????? ?????? ?????? ?????? 22,000??? ????????????(20,000??? ??????+2,000??? ?????????)</li>
                                                                            <li>?????? ??????????????? 576,000??? ??????</li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </li>` : ``}
                                    ${oversea_check ? `<li>
                                                            <button type="button" class="btn btn--direct">????????????</button>
                                                            <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                <div class="lay-comm--head">
                                                                    <strong class="lay-comm__tit">????????????</strong>
                                                                </div>
                                                                <div class="lay-comm--body">
                                                                    <div class="lay-comm__inner">
                                                                        ???????????? ?????? ???????????? ???????????? ?????? ?????? ??? ???????????? ?????? ????????? ?????? ?????? ??????????????? ??????????????? ????????????.
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </li>` : ``}
                                    ${overseaEmoney_check ? `<li>
                                                                <span class="tx_emoney--direct"><i class="ico ico--e">e??????</i>??????</span>
                                                                <div class="lay-tooltip lay-comm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                    <div class="lay-comm--head">
                                                                        <strong class="lay-comm__tit">???????????? e?????? ????????????</strong>
                                                                    </div>
                                                                    <div class="lay-comm--body">
                                                                        <div class="lay-comm__inner">
                                                                            <p class="tx_tit">????????? PC/????????? ??? ?????? ?????? ????????? ???<br>???????????? ?????? ????????? ?????? 6.5% e????????? ???????????? ??? ????????????.</p>
                                                                            <p class="tx_sub">????????????</p>
                                                                            <ul class="ins-list">
                                                                                <li>????????? ????????? ???????????? ????????????.</li>
                                                                                <li>????????? ?????? ?????? ??? ????????? ?????? ?????? ??? ????????? ????????? ?????? ??? ????????????.</li>
                                                                                <li>????????? ????????? ??????, ??????, ?????? ?????? ?????? ??? ?????? ?????? ????????? e?????? ???????????? ???????????????.</li>
                                                                                <li>?????????, ?????????/???????????? ??????, ?????????, ????????? ????????? ????????? ?????? ?????? ???????????? e????????? ????????? ????????????.</li>
                                                                                <li>??????????????? ????????? ?????? ?????? ???????????? ?????? ??? ????????????.</li>
                                                                                <li>???????????? ???????????? ????????? ???????????? e????????? ???????????? ???????????? ?????? ?????????????????? ?????? ????????? ????????? ???????????? e????????? ???????????? ????????????.</li>
                                                                            </ul>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </li>` : ``}
                                    ${emoney_reward > 0 ? `<li><button type="button" class="btn btn--emoney" onclick="$('#EMONEYLAYER').show();insertLogLSV(14507,'${gModelData.gCategory}','${gModelData.gModelno}');"><i class="ico ico--e">e??????</i><em>${numComma(emoney_reward)}</em>??? ??????</button></li>` : ``}
                                </ul>
                            </div>
                        </div>
                        <div class="col col-3">
                            <div class="box--logo">
                                <a class="thum" href="${bridgeUrl}" target="_blank" onclick="insertLogLSV(14515,'${gModelData.gCategory}','${gModelData.gModelno}');">
                                ${shoplogo_check ? `<img src="${storageUrl}/logo/logo16/logo_16_${shopcode}.png" alt="${shopname}" onerror="$(this).replaceWith('${shopname}')">` : `${shopname}`}
                                </a>
                                ${badgename != "" ? `<a href="${bridgeUrl}" target="_blank" class="badge badge--${badgename}">????????????</a>` : ``}
                            </div>
                        </div>
                        <div class="col col-4">
                            <div class="box--price">
                                <span class="tx_delivery">${delivery_textView}</span>
                                <a href="${bridgeUrl}" target="_blank" class="tx_price" onclick="insertLogLSV(14515,'${gModelData.gCategory}','${gModelData.gModelno}');">${minprice_check ? `?????????` : ``}<em>${numComma(priceView)}</em>???</a>
                            </div>
                        </div>
                    </li>`

        });
    }else{
        html += `<li class="comprod__item no-data">
                    <p class="tx_msg">?????? ???????????? ????????????.</p>
                </li>`
        $("#prod_pricecomp").find(".similar__cont .adv-search__btn--more").hide();
    }

    $("#prod_pricecomp").find(".similar__cont .similar__list").append(html);

    if( drcPricelistIdx < pricelistObjCount) {
        $("#prod_pricecomp").find(".similar__cont .adv-search__btn--close").hide();
        $("#prod_pricecomp").find(".similar__cont .adv-search__btn--more").show();
    }else{
        if(pricelistObjCount < 9){
            $("#prod_pricecomp").find(".similar__cont .adv-search__btn--more").hide();
            $("#prod_pricecomp").find(".similar__cont .adv-search__btn--close").hide();
        }else{
            $("#prod_pricecomp").find(".similar__cont .adv-search__btn--more").hide();
            $("#prod_pricecomp").find(".similar__cont .adv-search__btn--close").show();
        }
    }

    $("#prod_pricecomp").find(".similar__cont .adv-search__btn--more").unbind().click(function(){
        insertLogLSV(14512,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
        if(!$("#prod_pricecomp").find(".similar__cont").hasClass()) {
            $("#prod_pricecomp").find(".similar__cont").addClass("is-unfold");
        }
        if(drcPricelistIdx > pricelistObjCount){
            $("#prod_pricecomp").find(".similar__cont").addClass("is-unfold");
            $("#prod_pricecomp").find(".similar__cont .adv-search__btn--close").show();
            $("#prod_pricecomp").find(".similar__cont .adv-search__btn--more").hide();
        }else{
            paramHandler.set("rightmore",1);
            prodPriceSimModelTierView(rightObj,"right");
        }
    });

    $("#prod_pricecomp").find(".similar__cont .adv-search__btn--close").unbind().click(function(){
        $("#prod_pricecomp").find(".similar__cont").removeClass("is-unfold");
        $("#prod_pricecomp").find(".similar__cont .adv-search__btn--close").hide();
        $("#prod_pricecomp").find(".similar__cont .adv-search__btn--more").show();
    });

    $("#prod_pricecomp").find(".similar__cont .similar__item .btn--opt").unbind().click(function(){
        insertLogLSV(14508,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
        const $item = $(this).parents('.similar__item');
        const moveLink = $item.find('.col.col-2 .tx_link').attr('href');

        addOptionCtu($item.data('shopcode'),$item.data('goodscode'),$item.data('plno'),$item.data('delivery'),$item.data('price'),moveLink);
    });

    $("#prod_pricecomp").find(".similar__cont .similar__item .abs--singo").unbind().click(function(){
        insertLogLSV(14509,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
        prodCommon.declaration.layerDeclaration($(this));
    });
    $("#prod_pricecomp").find(".similar__cont .similar__item .col a").unbind().click(function(e){
        let vNowtime = new Date().format("yyyyMMddhhmm")*1;

        if(serviceNShopChkAlert){
            if($(this).parents("li").data("shoptype") == "4") {
                alert("?????? ???????????? ?????? ????????? ?????? ????????????.");
                return false;
            }
        }
        if(serviceChkAlert[$(this).parents("li").data("shopcode")] !== undefined){
            e.preventDefault();
            alert(serviceChkAlert[$(this).parents("li").data("shopcode")].contents);
            return false;
        }

    });
    $("#prod_pricecomp").find(".similar__cont").show();
}
const prodPriceCompShopListView = (json) => {
    let mallHtml = '';
    let krShopList = json.krShopList;
    let ovsShopList = json.ovsShopList;
    const selShopArray = paramHandler.get("selshop").split(",");
    
    function cntChecked(){
        const domesticListCnt = $('#mall_layer input[id^=\'chkDOMESTIC\']').not('#chkDOMESTIC').length;
        const overseasListCnt = $('#mall_layer input[id^=\'chkOVERSEAS\']').not('#chkOVERSEAS').length;
        const domesticCheckedCnt = $('#mall_layer input[id^=\'chkDOMESTIC\']:checked').not('#chkDOMESTIC').length;
        const overseasCheckedCnt = $('#mall_layer input[id^=\'chkOVERSEAS\']:checked').not('#chkOVERSEAS').length;
        const shopChecked =  $('#mall_layer .lay-mall__list > li > input:checked').not('#chkDOMESTIC,#chkOVERSEAS');
        
        (domesticListCnt === domesticCheckedCnt)
        ? $('#chkDOMESTIC').prop('checked',true)
        : $('#chkDOMESTIC').prop('checked',false);

        (overseasListCnt === overseasCheckedCnt)
        ? $('#chkOVERSEAS').prop('checked',true)
        : $('#chkOVERSEAS').prop('checked',false);
        
        $('#mall-layer-apply em').text(shopChecked.length);
    }
    
    function shopListChkAll($this){
        const $parent = $this.parent();
        let isChecked = false;

        ($this.prop('checked'))
        ? isChecked = true
        : isChecked = false;
        
        $parent.siblings(`[data-mall="${$parent.data('mall')}"]`).each(function(i,v){
            $(v).find('input').prop('checked', isChecked);
        });

        cntChecked();
    }
    
    function applyShop(){
        const shopChecked = $('#mall_layer .lay-mall__list > li > input:checked').not('#chkDOMESTIC,#chkOVERSEAS');
        let selShopComma = '';

        $.each(shopChecked, (i,v) => {
            if(i>0) selShopComma += ",";
            selShopComma += v.value;
        });

        paramHandler.set("selshop",selShopComma);
        
        (shopChecked.length > 0)
        ? $(".btnMallSort").addClass("has-chk")
        : $(".btnMallSort").removeClass("has-chk");
    }
    if(krShopList.length === 0 && krShopList.length === 0){
        //$('#mall_layer .lay-mall__list li.no-data').show();
        mallHtml += `<li class="no-data">
                        <p class="tx_msg">??? ???????????? ????????? ???????????? ????????????.</p>
                    </li>`;
        $('#mall-layer-confirm').show();
    }else{
        function makeHtml(mallType, shopList){
            let isChked = '';
            let $id = '';
            let domText = '';
            let displayValue = '';

            if(mallType === 'domestic'){
                displayValue = 'block';
                $id = 'chkDOMESTIC';
                $('#mallCountDomestic').text(shopList.length);
            }else if(mallType === 'overseas'){
                displayValue = 'none';
                $id = 'chkOVERSEAS';
                $('#mallCountOverseas').text(shopList.length);
            }

            if(shopList.length > 1) domText += `<li data-mall="${mallType}" style="display:${displayValue}"><input type="checkbox" id="${$id}" class="input--checkbox-item" value="all"><label for="${$id}">??????</label></li>`
            else domText = `<li class="no-data"><p class="tx_msg">??? ???????????? ????????? ???????????? ????????????.</p></li>`;

            $.each(shopList, (index,listData) => {
                (selShopArray.indexOf(listData.shopcode.toString()) > -1)
                ? isChked = 'checked'
                : isChked = '';
    
                domText += `<li data-mall="${mallType}" style="display:${displayValue}"><input type="checkbox" id="${$id}_${index}" class="input--checkbox-item" value="${listData.shopcode}" ${isChked}><label for="${$id}_${index}">${listData.shopname}</label></li>`
            });

            return domText;
        };

        /* if(krShopList.length > 0) mallHtml += makeHtml('domestic', krShopList);
        if(ovsShopList.length > 0) mallHtml += makeHtml('overseas', ovsShopList); */
        mallHtml += makeHtml('domestic', krShopList);
        mallHtml += makeHtml('overseas', ovsShopList);

        $('#mall_layer .lay-tab__mall button').unbind().click(function(){
            let logNo
            const selectedMall = $(`#mall_layer .lay-mall__list li[data-mall="${$(this).data('mall')}"]`);

            ($(this).data('mall') === 'domestic')
            ? logNo = 26222
            : logNo = 26223;

            insertLogLSV(logNo,`${gModelData.gCategory}`,`${gModelData.gModelno}`);

            $(this).siblings().removeClass('is-on');
            $(this).addClass('is-on');
            $('#mall_layer .lay-mall__list li').hide();

            (selectedMall.length > 0)
            ? selectedMall.show()
            : $('#mall_layer .lay-mall__list li.no-data').show();
        });

        
        $('#mall_layer .btn__group .btn__cancel').unbind().click(function(){
            insertLogLSV(26901,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
        });

        $('#mall_layer .btn__group .btn__cancel, #mall-layer-apply').show();
    }
    //if($('#mall_layer .lay-mall__list li').not('.no-data').length === 0) $('#mall_layer .lay-mall__list').append(mallHtml);
    $('#mall_layer .lay-mall__list').html(mallHtml);
    $('#mall_layer .lay-mall__list > li > input').not('#chkDOMESTIC,#chkOVERSEAS').unbind().click(function(){cntChecked()});
    $('#mall_layer .lay-mall__list > li > input[value="all"]').unbind().click(function(){shopListChkAll($(this))});
    $('#mall_layer .lay-tab__mall button').removeClass('is-on');
    $('#mall_layer .lay-tab__mall button').eq(0).addClass('is-on');
    $('#mall_layer .lay-mall__list li').hide();
    $('#mall_layer .lay-mall__list li[data-mall="domestic"]').show();
    cntChecked();
    
    $('#mall-layer-apply').unbind().click(()=>{
        insertLogLSV(26902,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
        applyShop();
    });
    $(".btnMallSort").unbind().click(function(){
        insertLogLSV(26900,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
        const _top = Math.floor($(this).offset().top - 140);
        const _left = Math.floor($(this).offset().left);
        let shopCnt = 0;

        $(`#mall_layer .lay-mall__list input`).prop('checked', false);

        selShopArray.forEach(v =>{
            if(v !== ''){
                $(`#mall_layer .lay-mall__list input[value=${v}]`).prop('checked', true);
                shopCnt++;
            }
        });

        $('#mall-layer-apply em').text(shopCnt);

        $("#mall_layer").css({top:_top, left:_left}).show();
    });
}

const prodCashPriceComShopListView = (json) => {
    let pricelistObj = json.priceList;
    let pricelistObjCount = json.pricelistCount;
    let html = ``;
    if(pricelistObjCount > 0){
        $.each(pricelistObj, (index,listData) => {
            let delivery_text = listData.delivery_text;
            let goodscode = listData.goodscode;
            let goodsname = listData.goodsname;
            let imageurl = listData.imageurl;
            let instanceprice = listData.instanceprice;
            let plno = listData.plno;
            let price = listData.price;
            let price2 = listData.price2;
            let shopcode = listData.shopcode;
            let shopname = listData.shopname;
            let coupon = listData.coupon;
            let shoplogo_check = listData.shoplogo_check;
            let delivery_textView ="";
            let priceView = 0;
            let bridgeUrl  = prodCommon.bridgeUrl('move_link',`${shopcode}`,`${gModelData.gModelno}`,`${gModelData.gFactory}`,`${plno}`,`${coupon}`,`${price}`,1);

            if($.isNumeric(delivery_text)){
                if(param.delivery =="Y"){
                    delivery_textView = numComma(delivery_text) + "??? (???????????? "+ numComma(price) +"???)";
                }else{
                    delivery_textView = numComma(delivery_text) + "??? (???????????? "+ numComma(price2) +"???)";
                }
            }else{
                delivery_textView = "("+delivery_text+")";
            }

            if(param.sort=="price"){
                if(param.delivery=="Y"){
                    priceView = price2;
                }else if(param.card=="Y"){
                    priceView = price;
                }else{
                    priceView = price;
                }
            }
            html +=`<li class="cashmall__item">
                        <div class="col col--lt">
                        <a href="${bridgeUrl}" class="tx_shop" target="_blank" onclick="insertLogLSV(14515,'${gModelData.gCategory}','${gModelData.gModelno}');">
                        ${shoplogo_check ? `<img src="${storageUrl}/logo/logo20/logo_20_${shopcode}.png" alt="${shopname}" onerror="$(this).replaceWith('${shopname}')">` : `${shopname}`}
                        </a>
                        </div>
                        <div class="col col--rt">
                            <div class="pinfo__group">
                                <div class="line__price">
                                    <a href="${bridgeUrl}" class="tx_price" target="_blank" onclick="insertLogLSV(14515,'${gModelData.gCategory}','${gModelData.gModelno}');"><em>${numComma(priceView)}</em>???</a>
                                    <i class="badge badge--cash">??????</i>
                                    <p class="tx_delivery">${delivery_textView}</p>
                                </div>
                                <div class="line__info">
                                    <a href="${bridgeUrl}" class="tx_prodname" target="_blank" onclick="insertLogLSV(14515,'${gModelData.gCategory}','${gModelData.gModelno}');">${goodsname}</a>
                                </div>
                            </div>
                        </div>
                    </li>`;
        });
        if(pricelistObjCount > 10){
            $("#prod_pricecomp").find(".cashmall__cont .adv-search__btn--more").show();
        }else{
            $("#prod_pricecomp").find(".cashmall__cont .adv-search__btn--more").hide();
        }
        $("#prod_pricecomp").find(".cashmall__list").html(html);
        $("#prod_pricecomp").find(".cashmall__cont").show();
    }else{
        $("#prod_pricecomp").find(".cashmall__cont").hide();
    }

    $("#prod_pricecomp").find(".cashmall__cont .adv-search__btn--more").on("click", function(){
        insertLogLSV(14512,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
        $(this).closest(".cashmall__cont").addClass("is-unfold");
    });
    $("#prod_pricecomp").find(".cashmall__cont .adv-search__btn--close").on("click", function(){
        insertLogLSV(14512,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
        $(this).closest(".cashmall__cont").removeClass("is-unfold");
    });

}
const prodPriceComTierTitleView = (title,tier) => {
    let html = ``;
    if(compTier=="authTier"){
        if(tier=="left"){
            html= `  <h3 class="head__tit">
                    <a href="javascript:void(0);" class="logo__link"><img src="http://storage.enuri.info/pic_upload/sdu/auth/${authImage}" alt=""></a>
                    ${title}
                    <button type="button" class="ico ico--question" onclick="$(this).parent('.head__tit').siblings('.lay-comparison').toggle()">?</button>
                </h3>
                <div class="lay-comparison lay-tooltip lay-comm" style="display:none;">
                    <div class="lay-comm--head">
                        <strong class="lay-comm__tit">?????? ????????? <i class="ico ico--ad"></i></strong>
                    </div>
                    <div class="lay-comm--body">
                        <div class="lay-comm__inner">
                            <p class="tx_tit">?????????????????? ????????? ?????? ?????? ?????? ?????? ??????????????????.</p>

                            <p class="tx_sub">????????????</p>
                            <ul class="order-list">
                                <li>
                                    <p class="tx_tit">1.???????????? ?????? ??????</p>
                                    <p class="tx_sub">?????? ????????? ?????????????????? ???????????? ????????? ????????? ?????? ??? ????????? ?????? ???????????? ??????????????? ??????????????????.</p>
                                </li>
                                <li>
                                    <p class="tx_tit">2. ?????? ?????? ??????!</p>
                                    <p class="tx_sub">?????? ????????? ??? ?????? ????????? ?????? ????????? ?????? ????????????.</p>
                                </li>
                                <li>
                                    <p class="tx_tit">3. ????????? ?????? ?????????</p>
                                    <p class="tx_sub">?????? ?????? ?????? ????????? ??????????????? ??? ?????? ????????????.</p>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay-comm').hide()">????????? ??????</button>
                </div>`;
        } else {
            html =`<h3 class="head__tit">${title}</h3>`;
        }
    } else if (compTier=="usedTier"){
        if(tier=="left"){
            html =`
            <h3 class="head__tit">${title} <button type="button" class="ico ico--question" onclick="$(this).parent('.head__tit').siblings('.lay-comparison').toggle()">?</button></h3>

            <div class="lay-comparison lay-tooltip lay-comm" style="display: none;">
                <div class="lay-comm--head">
                    <strong class="lay-comm__tit">??????/??????</strong>
                </div>
                <div class="lay-comm--body">
                    <div class="lay-comm__inner">
                        <p class="tx_tit">???????????? ??????(?????? ??????, ??????/????????????)??? ??????????????? ??? ????????? ???????????????. </p>
                        <p class="tx_sub">????????? ????????? ?????? ???????????? ???????????? ?????? ??? ?????? ??????????????? ?????? ??? ????????????. A/S?????? ??? ?????? ????????? ?????? ????????? ?????? ??????????????? ????????? ?????? ??? ???????????????.</p>
                        <ul class="ins-list">
                            <li>*?????? : ???????????? ??????(?????? ?????? ?????????)</li>
                            <li>*?????? : ?????? ??????, ?????? ???????????? ??????</li>
                        </ul>
                    </div>
                </div>
                <button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay-comm').hide()">????????? ??????</button>
            </div>
            `
        }else{
            html = `
            <h3 class="head__tit">${title} <button type="button" class="ico ico--question" onclick="$(this).parent('.head__tit').siblings('.lay-comparison').toggle()">?</button></h3>

            <div class="lay-comparison lay-tooltip lay-comm">
                <div class="lay-comm--head">
                    <strong class="lay-comm__tit">?????? ??????</strong>
                </div>
                <div class="lay-comm--body">
                    <div class="lay-comm__inner">
                        <p class="tx_tit">????????????, ???????????? ?????? ?????? ????????? ????????? ?????? ?????? ??? ??????????????? ???????????????.</p>
                        <p class="tx_sub">?????????????????? ?????? ????????? ?????? ??? ?????????, ?????? ??? ?????? ??? ????????? ??????????????????. A/S??? ????????? ???????????? ?????? ???????????? ????????? ?????? ??? ???????????????</p>
                    </div>
                </div>
                <button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay-comm').hide()">????????? ??????</button>
            </div>
        `
        }
    } else if(compTier=="tariffTier"){
        if(tier=="left"){
            html =`<h3 class="head__tit">${title}</h3>`;
        }else {
            html =`
            <h3 class="head__tit">${title}<button type="button" class="ico ico--question" onclick="$(this).parent('.head__tit').siblings('.lay-comparison').toggle()">?</button></h3>
            <div class="lay-comparison lay-tooltip lay-comm">
                <div class="lay-comm--head">
                    <strong class="lay-comm__tit">??????/????????? ?????????</strong>
                </div>
                <div class="lay-comm--body">
                    <div class="lay-comm--inner">
                        <p class="tx_tit">??????(??????,?????????), ???????????? ????????? ?????? ?????????.</p>
                        <p class="tx_sub">?????? ????????? ???????????? ??????, ???????????? ????????? ???????????? ?????? ????????????. ?????? ????????? ??????, ??????, A/S??? ???????????? ???????????? ?????? ??? ???????????????</p>

                        <a href="http://www.enuri.com/knowcom/detail.jsp?kbno=438838" class="guide__link" target="_blank" title="?????? ?????? ???????????? ??????">*?????? ?????? ???????????? ??????</a>
                    </div>
                </div>
                <button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay-comm').hide()">????????? ??????</button>
            </div>
        </div>`
        }
    } else if(compTier=="deliveryTier"){
        if(tier=="left"){
            html =`<h3 class="head__tit">${title}</h3>`;
        }else {
            html =`
            <h3 class="head__tit">${title}<button type="button" class="ico ico--question" onclick="$(this).parent('.head__tit').siblings('.lay-comparison').toggle()">?</button></h3>
            <div class="lay-comparison lay-tooltip lay-comm">
                <div class="lay-comm--head">
                    <strong class="lay-comm__tit">????????? ?????? ?????????????</strong>
                </div>
                <div class="lay-comm--body">
                    <div class="lay-comm__inner">
                        <strong>???????????? ???????????? ????????? ??????</strong>??? ?????? ????????? ??????????????????.<br>
                        ??????, ???????????? ????????? ???????????? <strong>???????????? ????????? ????????? ??????</strong>?????????.
                    </div>
                </div>
                <button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay-comm').hide()">????????? ??????</button>
            </div>
        `
        }
    } else{
        html =`<h3 class="head__tit">${title}</h3>`;
    }
    return html;
}


const prodCautionInfoView = (json) => {
    let rtnHtml = "";
    if(typeof json != "undefined") {
        var title_type = json.title_type;
        var title = json.title;
        var img = json.img;
        var imgmap_list = json.imgmap_list;
        var content_list = json.content_list;
        var content_type = json.content_type;

        rtnHtml += "<li class=\"comprod__item is-cminput\">";
        if (content_type == 1) {
            if (title_type < 2) {
                if (title_type == 1) {
                    rtnHtml += "<p class=\"tx_tit\"><span>" + title + "</span><i class=\"ico ico--noti\">!</i></p>";
                } else {
                    rtnHtml += "<p class=\"tx_tit\"><span>????????????</span><i class=\"ico ico--noti\">!</i></p>";
                }
            }
            rtnHtml += "<p class=\"tx_info\" >";
            $.each(content_list, function(Index, listData) {
                var o_content = listData["content"];
                if (Index > 0) rtnHtml += "<br>";
                rtnHtml += o_content;
            });
            rtnHtml += "</p>";
        } else if (content_type == 2) {
            rtnHtml += "<img src=\"http://storage.enuri.info/pic_upload/caution/" + img + "\"  usemap=\"#Map\" style=\"width:970px;\">";
            rtnHtml += "<map name=\"Map\">";
            $.each(imgmap_list, function(Index, listData) {
                let o_img_map = listData["img_map"];
                let o_map_url = listData["map_url"];
                let o_open_type = listData["open_type"];
                if (o_img_map != "") {
                    rtnHtml += "<area shape=\"rect\" coords=\"" + o_img_map + "\" href=\"" + o_map_url + "\"";
                    if (o_open_type == 1) {
                        rtnHtml += "target=\"_blank\"";
                    }
                    rtnHtml += ">";
                }
            });
            rtnHtml += "</map>";
        }
        rtnHtml += "</li>";
    }
    return rtnHtml;
}

const prodOptInfoView = (json) => {
    let rtnHtml = "";
    let optListObj = json;
    if(typeof optListObj != "undefined" && optListObj.length > 0) {
        rtnHtml += `<li class="comprod__item is-option">
                        <p class="tx_tit">?????? ?????? ?????? ?????? <i class="ico ico--noti">!</i> <span class="tx_sub">???????????????</span></p>
                        <p class="tx_info">????????? ????????? ???????????? ??????????????? ???????????????, ?????? ?????????????????? ?????? ??? ???????????????.</p>
                        <ul class="prodopt__list">`
        $.each(optListObj,(i,v) =>{
            let plno = v.plno;
            let price = v.price;
            let shopcode = v.shopcode;
            let shopname = v.shopname;
            let goodscode = v.goodscode;
            let coupon = v.coupon;
            let delivery_text = v.delivery_text;
            let shoplogo_check = v.shoplogo_check;
            let bridgeUrl =prodCommon.bridgeUrl('move_link',`${shopcode}`,`${gModelData.gModelno}`,`${gModelData.gFactory}`,`${plno}`,`${coupon}`,`${price}`,1);
            rtnHtml += ` <li class="opt_item" data-shopcode=${shopcode} data-goodscode=${goodscode} data-plno=${plno} data-delivery=${delivery_text} data-price=${price}>
                            <div class="col col-1">
                                <a href="${bridgeUrl}" target="_blank" class="thum__logo" onclick="insertLogLSV(14510,${gModelData.gCategory},${gModelData.gModelno});">
                                ${shoplogo_check ? `<img src="${storageUrl}/logo/logo20/logo_20_${shopcode}.png" alt="${shopname}" onerror="$(this).replaceWith('${shopname}')">` : `${shopname}`}
                                </a>
                            </div>
                            <div class="col col-2"></div>
                            <div class="col col-3">
                                <a href="${bridgeUrl}" target="_blank"  class="tx_price" onclick="insertLogLSV(14510,${gModelData.gCategory},${gModelData.gModelno});"><em>${v.price.format()}</em>???</a>
                                <span class="tx_sub">+ ????????? ??????</span>
                            </div>
                        </li>`;
        });
        rtnHtml += `    </ul>
                    </li>`;
    }

    return rtnHtml;
}
const numComma = (x) => {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


/* const loadBanner(ca_code, bannerpos) {
    var bannerObj = $('#vip_circlebanner'); // ????????? ??????
    if (ca_code.length > 4) {
        ca_code = ca_code.substring(0, 4);
    }
    // bannerpos??? ?????? ????????? ?????? vip ?????? ????????? ?????? ??????.
    var varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_lp/T4/req?cate=" + ca_code;
    if (bannerpos == 'D') {
        bannerObj = $('#comgoodsBanner'); // VIP ?????? ??????
        varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_vip/C1/req?cate=" + ca_code;
        if (IsAdultAd == "true") {
            varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_adult/C1a/req?cate=" + ca_code;
        }
    }
    bannerObj.hide();
    $.getJSON(varBannerUrl, function(json) {
        var varObjcect = json;
        var vipCenterImg = varObjcect.IMG1;
        var vipCenterUrl = varObjcect.JURL1;
        var vipCenterTarget = varObjcect.TARGET;
        var vipCenterAlt = varObjcect.ALT;
        if (vipCenterImg != "" && vipCenterUrl != "") {
            bannerObj.find('img').attr("src", vipCenterImg);
            bannerObj.find('#gourl').click(function() {
                window.open(vipCenterUrl, '', '');
                return false;
            });
            bannerObj.show();
        } else {
            bannerObj.hide();
    }
    });
} */
// ?????? CTU
function addOptionCtu(shop_code, goods_code, pl_no, deliveryInfo, priceView, moveLink) {
    let today = new Date();
    let cur_time = `${today.getHours()}${today.getMinutes()}`;

    if (typeof(shop_code) == "undefined") shop_code = "";
    if (typeof(goods_code) == "undefined") goods_code = 0;
    if (typeof(pl_no) == "undefined") pl_no = 0;
    // ?????? 1~5??? ???????????? ctu??? ???????????? ???????????? ?????? ??????
    if (!(cur_time >= 100 && cur_time <= 500)) {
        var param = {
            "ctuActionType": 4,
            "shop_code": shop_code,
            "goods_code": goods_code,
            "pl_no": pl_no
        }

        $.ajax({
            type: "get",
            url: "/move/ctuSyncAction.jsp",
            async: false,
            data: param,
            dataType: "html",
            success: function(data) {
                // goption_check = data;
                loadOptionView(pl_no,deliveryInfo,priceView,moveLink);
            }
        });
    } else {
        loadOptionView(pl_no,deliveryInfo,priceView,moveLink);
    }
}

//???????????? layer ??????
function loadOptionView(pl_no,deliveryInfo,priceView,moveLink) {
    if(deliveryInfo === "????????????") deliveryInfo = 0;

    const param = {
        "pl_nos": pl_no,
        "deliveryShowFlag": true
    }

    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/getGoodsOption_ajax.jsp",
        async: true,
        data: param,
        dataType: "json",
        success: function(json) {
            let html = "";

            if(json.optionModelList.length > 0){
                json.optionModelList.forEach(v => {
                    if (v.showOptionName){
                        html += `<li class="" data-option="${v.showOptionName}"><button type="button" class="btn">${v.showOptionName}</button></li>`;
                    }
                });

                if(html == ""){
                    alert("??????????????? ????????????.");
                }else{
                    $('#PRODOPTIONVIEW .optsel__list li').remove();
                    $('#PRODOPTIONVIEW .btn__mall').attr('href',moveLink);
                    $('#PRODOPTIONVIEW .col-1 .optsel__list').html(html);
                    $('#PRODOPTIONVIEW .col-1 .optsel__list li').removeClass("is-on");
                    $('#PRODOPTIONVIEW .col-1 .optsel__list li').eq(0).addClass("is-on");
                    loadSubOptionView(pl_no,$('#PRODOPTIONVIEW .col-1 .optsel__list li').eq(0).data('option'),deliveryInfo,priceView);
                    $('#PRODOPTIONVIEW').show();

                    $('#PRODOPTIONVIEW .col-1 .optsel__list li').click(function(){
                        $('#PRODOPTIONVIEW .col-1 .optsel__list li').removeClass("is-on");
                        $(this).addClass("is-on");
                        loadSubOptionView(pl_no,$(this).data('option'),deliveryInfo,priceView);
                    });

                   // $('#PRODOPTIONVIEW .col-1 .optsel__list li').eq(0).click();
                }
            }else{
                alert("??????????????? ????????????.");
            }
        }
    });
}

//1??? ?????? ??????
function loadSubOptionView(pl_no,optionName,deliveryInfo,priceView) {
    var param = {
        "pl_no": pl_no,
        "deliveryShowFlag": true,
        "optionName": optionName,
        "deliveryinfo": deliveryInfo
    }

    $.ajax({
        type: "get",
        url: "/lsv2016/ajax/detail/getGoodsOption_Sub_ajax.jsp",
        async: true,
        data: param,
        dataType: "json",
        success: function(json) {
            if(json.optionSubList.length > 0){
                let html = "";

                html += `<li>
                            <input type="radio" id="radioOPTSELECT1_01" name="radioOPTSELECT" class="input--radio-item" checked>
                            <label for="radioOPTSELECT1_01" data-name="${optionName}">????????????</label>
                        </li>`;

                json.optionSubList.forEach((v,i) => {
                    html += `<li>
                                <input type="radio" id="radioOPTSELECT1_0${i+2}" name="radioOPTSELECT" class="input--radio-item">
                                <label for="radioOPTSELECT1_0${i+2}" data-name="${optionName}" data-subname="${v.option_sub_name}" data-price=${v.option_price}>${v.option_sub_name}:${parseInt(v.option_price).format()}???</label>
                            </li>`;
                });

                $('#PRODOPTIONVIEW .col-2 .optsel__list').html(html);
                $('#PRODOPTIONVIEW .optsel__price .line__price').empty();
                //col-3??? ?????? col-2?????? check
                if($(`#PRODOPTIONVIEW .col-3 .optsel__list li[data-name="${optionName}"]`)){
                    let $subname = $(`#PRODOPTIONVIEW .col-3 .optsel__list li[data-name="${optionName}"]`).data('subname');

                    $(`#PRODOPTIONVIEW .col-2 .optsel__list label[data-subname="${$subname}"]`).prev().prop('checked',true);
                }

                //col-2?????? ??????
                $('#PRODOPTIONVIEW .col-2 .optsel__list label').unbind().click(function(){
                    selectOption($(this).data('name'),$(this).data('subname'),$(this).data('price'),priceView);
                });
            }
        }
    });
}

//2??? ?????? ??????
function selectOption(name,subName,price,priceView){
    let html = "";

    html += `<li data-name="${name}" data-subname="${subName}">
                <p class="tx_name">${name}<span class="tx_sub">(${subName})</span></p>
                <p class="tx_price" data-price=${price}><em>${parseInt(price).format()}</em>???</p>
                <button type="button" class="btn btn__del">??????</button>
            </li>`;

    deleteOption(name,priceView);

    if(subName && typeof price != "undefined"){
        let priceHtml = "";
        let optCnt = 0;
        let optPrice = 0;

        $('#PRODOPTIONVIEW .col-3 .optsel__list').append(html);
        $('#PRODOPTIONVIEW .col-3 .optsel__list li .btn__del').unbind().click(function(){
            const $name = $(this).parents('li').data('name');
            deleteOption($name,priceView);
        });

        //????????? ?????? ?????? ?????????
        for(let i=0; i<$('#PRODOPTIONVIEW .col-3 .tx_price').length; i++){
            optPrice = optPrice + $('#PRODOPTIONVIEW .col-3 .tx_price').eq(i).data('price');
        }
        optCnt = $('#PRODOPTIONVIEW .col-3 .optsel__list li').length;
        priceHtml += `????????? ${parseInt(priceView).format()}??? + ?????? ${optCnt}??? ${optPrice.format()}??? = <strong class="tx_price">??????????????? <em></em>${parseInt(priceView+optPrice).format()}???</strong>`;

        $('#PRODOPTIONVIEW .optsel__price .line__price').html(priceHtml);
    }
}

//?????? ?????? ??????
function deleteOption(name,priceView){
    let priceHtml = "";
    let optCnt = 0;
    let optPrice = 0;

    $(`#PRODOPTIONVIEW .col-2 .optsel__list label[data-name="${name}"]`).eq(0).prev().prop('checked',true);
    $(`#PRODOPTIONVIEW .col-3 li[data-name="${name}"]`).remove();

    //????????? ?????? ?????? ?????????
    for(let i=0; i<$('#PRODOPTIONVIEW .col-3 .tx_price').length; i++){
        optPrice = optPrice + $('#PRODOPTIONVIEW .col-3 .tx_price').eq(i).data('price');
    }
    optCnt = $('#PRODOPTIONVIEW .col-3 .optsel__list li').length;
    priceHtml += `????????? ${parseInt(priceView).format()}??? + ?????? ${optCnt}??? ${optPrice.format()}??? = <strong class="tx_price">??????????????? <em></em>${parseInt(priceView+optPrice).format()}???</strong>`;

    $('#PRODOPTIONVIEW .optsel__price .line__price').html(priceHtml);
}
const authInsertLog = (log_tp_cd) =>{
    var param = {
        "model_no": gModelData.gModelno,
        "cate_cd": gModelData.gCate4,
        "log_tp_cd": log_tp_cd,
        "os_tp_cd": "PC"
    }

    $.ajax({
        type: "get",
        url: "/sdu/factory_certification_log_ajax.jsp",
        data: param,
        dataType: "json",
        success: function(data) {}
    });
}