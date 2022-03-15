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
    selshop : "",
    mix : "N",
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
        //디폴트 설정
        //카드할인가 포함 버튼 초기화
        $("#prod_pricecomp").find(".comparison__head").show();
        $("#prod_pricecomp").find(".comparison__sort li").removeClass("is-on");
        $("#prod_pricecomp").find(".comparison__sort li[data-sort='"+paramHandler.get("sort")+"']").addClass("is-on");
        if(paramHandler.get("mix")=="N"){
            $("#prod_pricecomp").find(".comparison__cont .head__opt .toggle__chk").removeClass("is-on");
        }

        //카드 할인가 없을때 제거
        if(!cardfilterCheck){
            $("#prod_pricecomp").find(".comparison__head .comparison__sort li[data-sort='card']").hide();
            $("#prod_pricecomp").find(".comparison__cont .head__opt").hide();
        }else{
            $("#prod_pricecomp").find(".comparison__head .comparison__sort li[data-sort='card']").show();
            $("#prod_pricecomp").find(".comparison__cont .head__opt").show();

            //카드할인가가 있지만 판매가순 아닐땐 수고링
            if(paramHandler.get("sort") != "price"){
                $("#prod_pricecomp").find(".comparison__cont .head__opt").hide();
            }else{
                $("#prod_pricecomp").find(".comparison__cont  .head__opt").show();
            }
        }

        $("#prod_pricecomp").find(".comparison__cont > div").data("all",false);
        $("#prod_pricecomp").find(".comparison__head .comparison__sort li").unbind("click");
        $("#prod_pricecomp").find(".comparison__head .comparison__sort li").click(function(){
            $(this).siblings().removeClass("is-on");
            $(this).addClass("is-on");
            let sort = $(this).attr("data-sort");

            if(sort == "price"){
                insertLogLSV(14503,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                ga('send','event','vip','comparison_sort','price');
            }else if(sort == "delivery"){
                insertLogLSV(14502,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                ga('send','event','vip','comparison_sort','shipping');
            }else if(sort == "card"){
                insertLogLSV(14504,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
                ga('send','event','vip','comparison_sort','creditpromotion');
            }
            paramHandler.set("sort", sort);


        });
        //쇼핑몰 선택 layer
        prodPriceCompShopListView(selectShopObj);

        $("#prod_pricecomp").find(".comparison__cont .comparison__lt .comprod__list").empty();
        $("#prod_pricecomp").find(".comparison__cont .comparison__rt .comprod__list").empty();
        $("#prod_pricecomp").find(".similar__cont .similar__list").empty();
        //유사모델
        if(similarModelCheck){
            prodPriceSimModelTierView(rightObj);
        }else{
            prodPriceCompTierView(leftObj,"left");
            prodPriceCompTierView(rightObj,"right");
            $("#prod_pricecomp").find(".comparison__cont").show();
        }
        prodCashPriceComShopListView(cashObj);
        //공식인증 log
        if(authImage !=""){
            authInsertLog(1);
        }
        $("#prod_pricecomp").find(".comparison__cont .head__opt .toggle__chk").unbind().click(function(){
            let toggleObj = $("#prod_pricecomp").find(".comparison__cont .head__opt .toggle__chk");
            ga('send','event','vip','comparison_sort','Inclusion promotion');
            insertLogLSV(17519,`${gModelData.gCategory}`,`${gModelData.gModelno}`);

            if($(this).hasClass("is-on")){
                toggleObj.removeClass("is-on").addClass("is-off");
                paramHandler.set("mix","N");
            }else{
                toggleObj.removeClass("is-off").addClass("is-on");
                paramHandler.set("mix","Y");
            }
        });
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


            let bridgeUrl =prodCommon.bridgeUrl('move_link',`${shopcode}`,`${gModelData.gModelno}`,`${gModelData.gFactory}`,`${plno}`,`${coupon}`,`${price}`,1)
            let minprice_check = false;
            let delivery_textView ="";
            let freeinterestAry = new Array();
            let firstFreeInterest = 0;
            let freeinterestView = "";
            let priceView = 0;
            if(seller_ad != ""){ //판매자 광고 로그
                setSellerAdLog(plno);
            }
            if($.isNumeric(delivery_text)){
                if(param.sort =="delivery"){
                    delivery_textView = numComma(delivery_text) + "원(배송제외 "+ numComma(price) +"원)";
                }else{
                    delivery_textView = numComma(delivery_text) + "원(배송포함 "+ numComma(price2) +"원)";
                }
            }else{
                delivery_textView = "("+delivery_text+")";
            }

            if(param.sort=="price"){
                if(param.mix=="Y" && cardname !=""){
                    priceView = cardprice;
                }else{
                    priceView = price;
                }
            }else if(param.sort=="delivery"){
                priceView = price2;
            }else if(param.sort=="card"){
                if(cardname !=""){
                    priceView = cardprice;
                }else {
                    priceView = price;
                }
            }
            if(priceView===goodsMinPrice){
                minprice_check = true;
            }
              //할부

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
                        }
                    }
                }
            });
            if(shoptype=="4"){
                freeinterestView = "<li><p>최대 10개월<br>(카드정보 해당 페이지에서 확인가능)</p></li>";
                firstFreeInterest = 10;
            }

            // 강제추가 시 상품명없는 경우 모델명으로 처리.
            if(goodsname === "") goodsname = gModelData.gModelNmView;

            html +=`<li class="comprod__item ${ad_check && param.sort=="price" ? `is-top` :``}" data-shoptype=${shoptype} data-shopcode=${shopcode} data-goodscode=${goodscode} data-plno=${plno} data-delivery=${delivery_text} data-price=${priceView}>
                        <div class="col col--lt">
                            <a href="${bridgeUrl}" target="_blank" class="tx_shop" onclick="insertLogLSV(14515,'${gModelData.gCategory}','${gModelData.gModelno}');">
                            ${shoplogo_check ? `<img src="${storageUrl}/logo/logo20/logo_20_${shopcode}.png" alt="${shopname}" onerror="$(this).replaceWith('${shopname}')">` : `${shopname}`}
                            </a>
                            ${badgename != "" ? `<a href="${bridgeUrl}" target="_blank" class="badge badge--${badgename}">빠른배송</a>` : ``}
                            ${badgename=="quick" ?
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
                                                </div>` :``}
                        </div>
                        <div class="col col--rt">
                            <div class="pinfo__group">
                                <div class="line__price">
                                    <a href="${bridgeUrl}" target="_blank" class="tx_price" onclick="insertLogLSV(14515,'${gModelData.gCategory}','${gModelData.gModelno}');">
                                        <em>${numComma(priceView)}</em>원
                                    </a>
                                    <span class="tx_delivery">${delivery_textView}</span>
                                    ${minprice_check ? `<i class="badge badge--minp">최저가</i>` : ``}
                                    ${mobileprice_check ? `<i class="badge badge--mspecial" onclick="$(this).siblings('.lay-mobile-min').toggle();setQrCodeImg(); ">모바일특가</i>
                                                        <div class="lay-mobile-min lay-comm" style="display: none;">
                                                            <div class="lay-comm--head">
                                                                <strong class="lay-comm__tit">모바일에서 구매 시 더 저렴합니다.</strong>
                                                            </div>
                                                            <div class="lay-comm--body">
                                                                <div class="lay-comm--inner">
                                                                    <div class="lay-mobile__qr">
                                                                        <img src="//img.enuri.info/images/home/@qr.gif" alt="">
                                                                    </div>
                                                                    <div class="lay-mobile__cont">
                                                                        <p class="tx_price"><em>${numComma(instanceprice)}</em>원</p>
                                                                        <div class="lay-mobile__tx">
                                                                            핸드폰 전송 또는 QR 코드를 스캔하시거나, <br>
                                                                            에누리앱을 통해 구매해 주세요!
                                                                        </div>
                                                                        <div class="lay-mobile__btn">
                                                                            <button class="btn-mobile--zzim ${gModelData.gZzim ? `is--on` : ``}" onclick="showLayZzim(this,${gModelData.gModelno});">찜</button>
                                                                            <button class="btn-mobile--sendsms" onclick="$(this).closest('.lay-comm').find('.lay-mobile-sendsms').toggle();">핸드폰 전송</button>
                                                                            <button class="btn-mobile--app" onclick="window.open('/common/jsp/App_Landing.jsp');">에누리앱 설치</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="lay-mobile-sendsms" style="display:none">
                                                                    <div class="sendsms__form">
                                                                        <fieldset>
                                                                            <legend>SMS보내기</legend>
                                                                            <input type="text" class="sendsms__form--inp" placeholder="- 없이 입력하세요">
                                                                            <button class="sendsms__form--btn" onclick="sendDetailSms(this, 'detail');">전송</button>
                                                                        </fieldset>
                                                                    </div>
                                                                    <span class="sendsms__send-url--tx">- 상품 상세 주소를 무료문자로 발송해드립니다.</span>
                                                                    <span class="sendsms__send-url--tx">- 입력하신 번호는 저장되지 않습니다.</span>
                                                                </div>
                                                            </div>
                                                            <!-- 버튼 : 레이어 닫기 -->
                                                            <button class="lay-comm__btn--close comm__sprite" onclick="$(this).parent().hide()">레이어 닫기</button>
                                                        </div>` : ``}
                                    ${cardname !="" && (param.mix=="Y" || param.sort=="card") ? `<i class="badge badge--card">${cardname}</i>`: ``}
                                    ${oversea_check ? `<i class="badge badge--direct">직구</i>` : ``}
                                    ${ad_check && param.sort=="price" ? `<i class="badge badge--ad">AD</i>` :``}
                                    ${cardname !="" ? ` <div class="tx_cardprice">
                                                            <a href="${bridgeUrl}" target="_blank"  class="tx_price" onclick="insertLogLSV(14515,'${gModelData.gCategory}','${gModelData.gModelno}');">
                                                                <em>${(param.mix=="Y"||param.sort=="card") ? numComma(price) : numComma(cardprice)}</em>원
                                                                ${!(param.mix=="Y" || param.sort=="card") ? `<span class="tx_card">${cardname}</span>` : ``}
                                                            </a>
                                                        </div>`: ``}
                                </div>
                                <div class="line__info">
                                    ${promotion_cpnViewDcd=="M" ? `<div class="tx_coupon">
                                                                        <span class="tx_name">${promotion_cpnViewText}</span>
                                                                        ${promotion_cpnIconView=="Y" ? `<a href="${promotion_cpnRandUrl}" target="_blank" class="btn btn--coupon">쿠폰받기</a>` : ``}
                                                                    </div>` : ``}
                                    ${(promotion_cpnViewDcd=="C" && promotion_cpnViewText !="") ? `<a href="${promotion_cpnRandUrl}" target="_blank" class="tx_promotion">${shopname} ${promotion_cpnViewText} ${numComma(promotion_cpnDcPrice)}원</a>` : ``}
                                    ${oversea_check ? ` <div class="tx_direct">
                                                            <span class="tx_txt">구매 전 상품정보와 가격을 꼭 확인하세요!</span>
                                                        </div>` : ``}
                                    ${shopcode==6641 ? `<div class="tx_timon">
                                                            <span class="tx_txt">[단독] PC에서 구매 시 e머니 적립!</span>
                                                        </div>` :`` }
                                    ${seller_ad !="" ? `<div class="tx_direct"><span class="tx_txt">${seller_ad}</span></div>` : ``}
                                    ${promotion_cpnRandUrl =="C" ? `<a href="${promotion_cpnRandUrl}" class="tx_promotion">${promotion_cpnViewText} ${numComma(promotion_cpnDcPrice)}원</a>`: ``}
                                    <a href="${bridgeUrl}" target="_blank" class="tx_prodname" onclick="insertLogLSV(14515,'${gModelData.gCategory}','${gModelData.gModelno}');">${goodsname}</a>
                                </div>
                            </div>
                        </div>
                        <div class="btn__group">
                            <ul class="btn__list">
                                <li class="abs--singo"><button type="button" class="btn btn--singo">신고</button></li>
                                ${option_check ? `<li><button type="button" class="btn btn--opt">옵션보기</button></li>` : ``}
                                ${cardname != "" ? `<li>
                                                        <button type="button" class="btn btn--card">카드특가</button>
                                                            <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                <div class="lay-comm--head">
                                                                    <strong class="lay-comm__tit">카드특가</strong>
                                                                </div>
                                                                <div class="lay-comm--body">
                                                                    <div class="lay-comm__inner">
                                                                        ${cardname}<br>
                                                                        ${cardevnt_text} (적용가 : ${numComma(cardprice)}원)
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </li>` : `` }
                                ${freeinterestView !="" ? `<li>
                                                            ${firstFreeInterest > 0 ? `<button type="button" class="btn btn--infree-type2">무이자 최대 ${firstFreeInterest}개월</button>` : `<button type="button" class="btn">할부</button>`}
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
                                                        </li>` :``}
                                ${coupon_contents != "" ? `<li>
                                                                <button type="button" class="btn">쿠폰</button>
                                                                <div class="lay-tooltip lay-comm lay-comm--sm lay-coupon" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                    <div class="lay-comm--head">
                                                                        <strong class="lay-comm__tit">본 가격은 <em>추가할인 쿠폰</em> 적용가 입니다.</strong>
                                                                    </div>
                                                                    <div class="lay-comm--body">
                                                                        <div class="lay-comm__inner">
                                                                            ${coupon_contents}
                                                                            <div class="lay-coupon__price">
                                                                                쿠폰 적용가 : <em>${numComma(price)}</em>원
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </li>`: ``}
                                ${overseaShopping_check ? `<li>
                                                                <button type="button" class="btn btn--global">해외쇼핑</button>
                                                                <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                    <div class="lay-comm--head">
                                                                        <strong class="lay-comm__tit">해외쇼핑 유의사항</strong>
                                                                    </div>
                                                                    <div class="lay-comm--body">
                                                                        <div class="lay-comm__inner">
                                                                            배송기간이 평균적으로 오래걸리고<br>
                                                                            교환, 환불 및 A/S가 어려울 수 있습니다.
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </li>` : ``}
                                ${tlcshop_check ? `<li>
                                                        <button type="button" class="btn">TLC카드가</button>
                                                        <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                            <div class="lay-comm--head">
                                                                <strong class="lay-comm__tit">TLC카드가</strong>
                                                            </div>
                                                            <div class="lay-comm--body">
                                                                <div class="lay-comm__inner">
                                                                    <p class="tx_tit">NH올원 Shopping&amp;TLC카드로 36개월 장기 할부</p>

                                                                    <ul class="ins-list">
                                                                        <li>전월 카드 이용 실적 기준 최대 매월 22,000원 청구할인(20,000원 할인+2,000원 캐시백)</li>
                                                                        <li>현재 구매가에서 576,000원 할인</li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </li>` : ``}
                                ${oversea_check ? `<li>
                                                        <button type="button" class="btn btn--direct">해외직구</button>
                                                        <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                            <div class="lay-comm--head">
                                                                <strong class="lay-comm__tit">해외직구</strong>
                                                            </div>
                                                            <div class="lay-comm--body">
                                                                <div class="lay-comm__inner">
                                                                    해외에서 직접 구매하는 상품으로 상품 정보 및 구매절차 등을 반드시 해당 상품 페이지에서 확인하시기 바랍니다.
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </li>` : ``}
                                ${overseaEmoney_check ? `<li>
                                                            <span class="tx_emoney--direct"><i class="ico ico--e">e머니</i>적립</span>
                                                            <div class="lay-tooltip lay-comm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                <div class="lay-comm--head">
                                                                    <strong class="lay-comm__tit">해외직구 e머니 적립안내</strong>
                                                                </div>
                                                                <div class="lay-comm--body">
                                                                    <div class="lay-comm__inner">
                                                                        <p class="tx_tit">에누리 PC/모바일 웹 또는 앱에 로그인 후<br>해외직구 상품 구매시 최대 6.5% e머니를 적립받을 수 있습니다.</p>
                                                                        <p class="tx_sub">주의사항</p>
                                                                        <ul class="ins-list">
                                                                            <li>반드시 에누리 로그인을 해주세요.</li>
                                                                            <li>기프트 카드 또는 타 제휴사 쿠폰 사용 시 적립에 제한이 있을 수 있습니다.</li>
                                                                            <li>주문한 상품의 반송, 교환, 취소 등이 발생 할 경우 해당 금액은 e머니 적립에서 제외됩니다.</li>
                                                                            <li>배송비, 포인트/쿠폰적용 금액, 부가세, 취소된 금액을 제외한 실제 금액 기준으로 e머니를 적립해 드립니다.</li>
                                                                            <li>직구상품은 환율에 따라 실제 적립금이 다를 수 있습니다.</li>
                                                                            <li>에누리를 경유하여 결제한 상품에만 e머니가 적립되며 바로접속 또는 개인결제창을 통해 결제한 상품에 대해서는 e머니가 적립되지 않습니다.</li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </li>` : ``}
                                ${emoney_reward > 0 ? `<li><button type="button" class="btn btn--emoney" onclick="$('#EMONEYLAYER').show();insertLogLSV(14507,'${gModelData.gCategory}','${gModelData.gModelno}');"><i class="ico ico--e">e머니</i><em>${numComma(emoney_reward)}</em>점 적립</button></li>` : ``}
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
                    <p class="tx_msg">해당 쇼핑몰이 없습니다.</p>
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
                alert("해당 쇼핑몰은 현재 서비스 점검 중입니다.");
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
                if(param.sort =="delivery"){
                    delivery_textView = numComma(delivery_text) + "원(배송제외 "+ numComma(price) +"원)";
                }else{
                    delivery_textView = numComma(delivery_text) + "원(배송포함 "+ numComma(price2) +"원)";
                }
            }else{
                delivery_textView = "("+delivery_text+")";
            }

            if(param.sort=="price"){
                if(param.mix=="Y" && cardname !=""){
                    priceView = cardprice;
                }else{
                    priceView = price;
                }
            }else if(param.sort=="delivery"){
                priceView = price2;
            }else if(param.sort=="card"){
                if(cardname !=""){
                    priceView = cardprice;
                }else {
                    priceView = price;
                }
            }
            if(priceView===goodsMinPrice){
                minprice_check = true;
            }
            //할부
            let freeinterestAry = new Array();
            freeinterestAry = convertFreeInterest(freeinterest).split('/');
            $.each(freeinterestAry, (i,v) => {
                if(v!=""){
                    v = v.replace(/,/gi, "/");
                    freeinterestView +=`<li>${v}</li>`;
                }
            });
            if(shoptype=="4"){
                freeinterestView = `<li><p>최대 10개월<br>(카드정보 해당 페이지에서 확인가능)</p></li>`;
            }
            html += `<li class="similar__item"  data-shoptype=${shoptype} data-shopcode=${shopcode} data-goodscode=${goodscode} data-plno=${plno}  data-delivery=${delivery_text} data-price=${priceView}>
                        <div class="col col-1">
                            <a class="thum__link" href="${bridgeUrl}" target="_blank" onclick="insertLogLSV(14515,'${gModelData.gCategory}','${gModelData.gModelno}');">
                                <img src="${imageurl}" alt="${shopname}">
                            </a>
                        </div>
                        <div class="col col-2">
                            <div class="badge__group">
                                    ${mobileprice_check ? `<i class="badge badge--mspecial">모바일특가</i>` : ``}
                                    ${cardname !="" && (param.sort=="card") ? `<i class="badge badge--card">${cardname}</i>`: ``}
                                    ${ad_check && param.sort=="price" ? `<i class="badge badge--ad">AD</i>` :``}
                                    ${coupon_contents != "" ? `<i class="badge badge--coupon">쿠폰</i>` : ``}
                            </div>

                            <a href="${bridgeUrl}" target="_blank" class="tx_link" onclick="insertLogLSV(14515,'${gModelData.gCategory}','${gModelData.gModelno}');">${goodsname}</a>

                            <div class="btn__group">
                                <ul class="btn__list">
                                    <li class="abs--singo"><button type="button" class="btn btn--singo" onclick="$('#SINGOLAYER').show()">신고</button></li>
                                    ${option_check ? `<li><button type="button" class="btn btn--opt">옵션보기</button></li>` : ``}
                                    ${cardname != "" ? `<li>
                                                            <button type="button" class="btn btn--card">카드특가</button>
                                                                <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                    <div class="lay-comm--head">
                                                                        <strong class="lay-comm__tit">카드특가</strong>
                                                                    </div>
                                                                    <div class="lay-comm--body">
                                                                        <div class="lay-comm__inner">
                                                                            ${cardname}<br>
                                                                            ${cardevnt_text} (적용가 : ${numComma(cardprice)}원)
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </li>` : `` }
                                    ${freeinterest !="" ? `<li>
                                                                <button type="button" class="btn">할부</button>
                                                                <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                    <div class="lay-comm--head">
                                                                        <strong class="lay-comm__tit">무이자할부</strong>
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
                                                                    <button type="button" class="btn">쿠폰</button>
                                                                    <div class="lay-tooltip lay-comm lay-comm--sm lay-coupon" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                        <div class="lay-comm--head">
                                                                            <strong class="lay-comm__tit">본 가격은 <em>추가할인 쿠폰</em> 적용가 입니다.</strong>
                                                                        </div>
                                                                        <div class="lay-comm--body">
                                                                            <div class="lay-comm__inner">
                                                                                ${coupon_contents}
                                                                                <div class="lay-coupon__price">
                                                                                    쿠폰 적용가 : <em>${numComma(price)}</em>원
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </li>`: ``}
                                    ${overseaShopping_check ? `<li>
                                                                    <button type="button" class="btn btn--global">해외쇼핑</button>
                                                                    <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                        <div class="lay-comm--head">
                                                                            <strong class="lay-comm__tit">해외쇼핑 유의사항</strong>
                                                                        </div>
                                                                        <div class="lay-comm--body">
                                                                            <div class="lay-comm__inner">
                                                                                배송기간이 평균적으로 오래걸리고<br>
                                                                                교환, 환불 및 A/S가 어려울 수 있습니다.
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </li>` : ``}
                                    ${tlcshop_check ? `<li>
                                                            <button type="button" class="btn">TLC카드가</button>
                                                            <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                <div class="lay-comm--head">
                                                                    <strong class="lay-comm__tit">TLC카드가</strong>
                                                                </div>
                                                                <div class="lay-comm--body">
                                                                    <div class="lay-comm__inner">
                                                                        <p class="tx_tit">NH올원 Shopping&amp;TLC카드로 36개월 장기 할부</p>

                                                                        <ul class="ins-list">
                                                                            <li>전월 카드 이용 실적 기준 최대 매월 22,000원 청구할인(20,000원 할인+2,000원 캐시백)</li>
                                                                            <li>현재 구매가에서 576,000원 할인</li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </li>` : ``}
                                    ${oversea_check ? `<li>
                                                            <button type="button" class="btn btn--direct">해외직구</button>
                                                            <div class="lay-tooltip lay-comm lay-comm--sm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                <div class="lay-comm--head">
                                                                    <strong class="lay-comm__tit">해외직구</strong>
                                                                </div>
                                                                <div class="lay-comm--body">
                                                                    <div class="lay-comm__inner">
                                                                        해외에서 직접 구매하는 상품으로 상품 정보 및 구매절차 등을 반드시 해당 상품 페이지에서 확인하시기 바랍니다.
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </li>` : ``}
                                    ${overseaEmoney_check ? `<li>
                                                                <span class="tx_emoney--direct"><i class="ico ico--e">e머니</i>적립</span>
                                                                <div class="lay-tooltip lay-comm" onmouseleave="$(this).fadeOut(300);" style="display: none;">
                                                                    <div class="lay-comm--head">
                                                                        <strong class="lay-comm__tit">해외직구 e머니 적립안내</strong>
                                                                    </div>
                                                                    <div class="lay-comm--body">
                                                                        <div class="lay-comm__inner">
                                                                            <p class="tx_tit">에누리 PC/모바일 웹 또는 앱에 로그인 후<br>해외직구 상품 구매시 최대 6.5% e머니를 적립받을 수 있습니다.</p>
                                                                            <p class="tx_sub">주의사항</p>
                                                                            <ul class="ins-list">
                                                                                <li>반드시 에누리 로그인을 해주세요.</li>
                                                                                <li>기프트 카드 또는 타 제휴사 쿠폰 사용 시 적립에 제한이 있을 수 있습니다.</li>
                                                                                <li>주문한 상품의 반송, 교환, 취소 등이 발생 할 경우 해당 금액은 e머니 적립에서 제외됩니다.</li>
                                                                                <li>배송비, 포인트/쿠폰적용 금액, 부가세, 취소된 금액을 제외한 실제 금액 기준으로 e머니를 적립해 드립니다.</li>
                                                                                <li>직구상품은 환율에 따라 실제 적립금이 다를 수 있습니다.</li>
                                                                                <li>에누리를 경유하여 결제한 상품에만 e머니가 적립되며 바로접속 또는 개인결제창을 통해 결제한 상품에 대해서는 e머니가 적립되지 않습니다.</li>
                                                                            </ul>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </li>` : ``}
                                    ${emoney_reward > 0 ? `<li><button type="button" class="btn btn--emoney" onclick="$('#EMONEYLAYER').show();insertLogLSV(14507,'${gModelData.gCategory}','${gModelData.gModelno}');"><i class="ico ico--e">e머니</i><em>${numComma(emoney_reward)}</em>점 적립</button></li>` : ``}
                                </ul>
                            </div>
                        </div>
                        <div class="col col-3">
                            <div class="box--logo">
                                <a class="thum" href="${bridgeUrl}" target="_blank" onclick="insertLogLSV(14515,'${gModelData.gCategory}','${gModelData.gModelno}');">
                                ${shoplogo_check ? `<img src="${storageUrl}/logo/logo16/logo_16_${shopcode}.png" alt="${shopname}" onerror="$(this).replaceWith('${shopname}')">` : `${shopname}`}
                                </a>
                                ${badgename != "" ? `<a href="${bridgeUrl}" target="_blank" class="badge badge--${badgename}">빠른배송</a>` : ``}
                            </div>
                        </div>
                        <div class="col col-4">
                            <div class="box--price">
                                <span class="tx_delivery">${delivery_textView}</span>
                                <a href="${bridgeUrl}" target="_blank" class="tx_price" onclick="insertLogLSV(14515,'${gModelData.gCategory}','${gModelData.gModelno}');">${minprice_check ? `최저가` : ``}<em>${numComma(priceView)}</em>원</a>
                            </div>
                        </div>
                    </li>`

        });
    }else{
        html += `<li class="comprod__item no-data">
                    <p class="tx_msg">해당 쇼핑몰이 없습니다.</p>
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
                alert("해당 쇼핑몰은 현재 서비스 점검 중입니다.");
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
    let krhtml = ``;
    let krShopList = json.krShopList;
    let ovshtml = ``;
    let ovsShopList = json.ovsShopList;
    if(krShopList.length > 0){
        krhtml += `<li><input type="checkbox" id="chkDOMESTIC" class="input--checkbox-item" value="all"><label for="chkDOMESTIC">전체</label></li>`
        $.each(krShopList, (index,listData) => {
            krhtml += `<li><input type="checkbox" id="chkDOMESTIC_${index}" class="input--checkbox-item" value="${listData.shopcode}"><label for="chkDOMESTIC_${index}">${listData.shopname}</label></li>`
        });
    }else{
        krhtml += ` <li class="no-data">
                    <p class="tx_msg">선택할 쇼핑몰이 없습니다.</p>
                </li>`;
    }
    if(ovsShopList.length > 0){
        ovshtml += `<li><input type="checkbox" id="chkOVERSEA" class="input--checkbox-item" value="all"><label for="chkOVERSEA">전체</label></li>`
        $.each(ovsShopList, (index,listData) => {
            ovshtml += `<li><input type="checkbox" id="chkOVERSEA_${index}" class="input--checkbox-item" value="${listData.shopcode}"><label for="chkOVERSEA_${index}">${listData.shopname}</label></li>`
        });
        $("#ovs_shoplist").find(".lay_tooltip").show();
    }else{
        ovshtml += `<li class="no-data">
                     <p class="tx_msg">선택할 쇼핑몰이 없습니다.</p>
                    </li>`;
        $("#ovs_shoplist").find(".lay_tooltip").hide();
    }
    $("#kr_shoplist").find(".lay-mallsel .lay-mall__list").html(krhtml);
    $("#ovs_shoplist").find(".lay-mallsel .lay-mall__list").html(ovshtml);

    $("#kr_shoplist .btn__sel, #ovs_shoplist .btn__sel").unbind().click(function(){
        let vThisParentId = $(this).parents("li").attr("id");
        if(vThisParentId == "kr_shoplist") {
            insertLogLSV(26222,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
            ga('send','event','vip','comparison_sort','domestic');
        }else if(vThisParentId == "ovs_shoplist"){
            insertLogLSV(26223,`${gModelData.gCategory}`,`${gModelData.gModelno}`);
            ga('send','event','vip','comparison_sort','overseas');
        }
        $(this).parent().siblings(".lay-mallsel").toggle();
        $("#ovs_shoplist").find(".lay_tooltip").hide();
    })
    $("#prod_pricecomp .comparison__select > li").each(function(index,obj){
        let selShopArray = paramHandler.get("selshop").split(",");
        $.each(selShopArray, (index) => {
            $(this).find(".lay-mallsel .lay-mall__list input:checkbox[value='"+selShopArray[index]+"']").prop("checked",true);
        });

        $(this).find(".lay-mallsel .lay-mall__list input:checkbox[value='all']").unbind().click(() => {
            if($(this).find("input:checkbox[value='all']").is(":checked")){
                $(this).find("input:checkbox[value!='all']").prop("checked",true);
            }else{
                $(this).find("input:checkbox[value!='all']").prop("checked",false);
            }
        });
        $(this).find(".lay-mallsel .lay-mall__list input:checkbox[value!='all']").unbind().click(() => {
            $(this).find("input:checkbox[value='all']").prop("checked",false);
        });
        $(this).find(".lay-mallsel .btn__group .btn__apply").unbind().click(() =>{
            let ShopCheck =  $(this).find("input:checkbox[value!='all']:checked");
            let selShopComma = "";
            $.each(ShopCheck, (i,v) => {
                if(i>0) selShopComma += ",";
                selShopComma += v.value;
            });

            paramHandler.set("selshop",selShopComma);
        });

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
                if(param.sort =="delivery"){
                    delivery_textView = numComma(delivery_text) + "원(배송제외 "+ numComma(price) +"원)";
                }else{
                    delivery_textView = numComma(delivery_text) + "원(배송포함 "+ numComma(price2) +"원)";
                }
            }else{
                delivery_textView = "("+delivery_text+")";
            }

            if(param.sort=="price"){
                priceView = price;
            }else if(param.sort=="delivery"){
                priceView = price2;
            }else if(param.sort=="card"){
                priceView = price;
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
                                    <a href="${bridgeUrl}" class="tx_price" target="_blank" onclick="insertLogLSV(14515,'${gModelData.gCategory}','${gModelData.gModelno}');"><em>${numComma(priceView)}</em>원</a>
                                    <i class="badge badge--cash">현금</i>
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
                        <strong class="lay-comm__tit">공식 판매자 <i class="ico ico--ad"></i></strong>
                    </div>
                    <div class="lay-comm--body">
                        <div class="lay-comm__inner">
                            <p class="tx_tit">제조사로부터 온라인 판매 인증 받은 정식 판매자입니다.</p>

                            <p class="tx_sub">주요특징</p>
                            <ul class="order-list">
                                <li>
                                    <p class="tx_tit">1.안정적인 재고 확보</p>
                                    <p class="tx_sub">상품 출하가 최우선적으로 이뤄지기 때문에 소비자 주문 후 재고가 없어 환불이나 배송지연이 최소화됩니다.</p>
                                </li>
                                <li>
                                    <p class="tx_tit">2. 정품 품질 확실!</p>
                                    <p class="tx_sub">간혹 발생될 수 있는 비정품 배송 우려가 전혀 없습니다.</p>
                                </li>
                                <li>
                                    <p class="tx_tit">3. 최우량 판매 서비스</p>
                                    <p class="tx_sub">고객 응대 등의 소비자 대응체계가 잘 되어 있습니다.</p>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay-comm').hide()">레이어 닫기</button>
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
                    <strong class="lay-comm__tit">전시/중고</strong>
                </div>
                <div class="lay-comm--body">
                    <div class="lay-comm__inner">
                        <p class="tx_tit">사용했던 제품(개인 사용, 전시/테스트용)을 정상가보다 싼 가격에 판매합니다. </p>
                        <p class="tx_sub">장시간 켜놓은 가전 제품이나 소모품은 구매 후 실제 사용기간이 짧을 수 있습니다. A/S기간 및 가능 여부를 해당 쇼핑몰 또는 판매자에게 반드시 확인 후 주문하세요.</p>
                        <ul class="ins-list">
                            <li>*중고 : 사용했던 제품(개인 또는 업소용)</li>
                            <li>*전시 : 매장 전시, 품질 테스트용 제품</li>
                        </ul>
                    </div>
                </div>
                <button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay-comm').hide()">레이어 닫기</button>
            </div>
            `
        }else{
            html = `
            <h3 class="head__tit">${title} <button type="button" class="ico ico--question" onclick="$(this).parent('.head__tit').siblings('.lay-comparison').toggle()">?</button></h3>

            <div class="lay-comparison lay-tooltip lay-comm">
                <div class="lay-comm--head">
                    <strong class="lay-comm__tit">반품 상품</strong>
                </div>
                <div class="lay-comm--body">
                    <div class="lay-comm__inner">
                        <p class="tx_tit">단순변심, 불량으로 인한 반품 상품을 재포장 또는 수리 후 재판매하는 제품입니다.</p>
                        <p class="tx_sub">반품과정에서 생긴 흠집이 있을 수 있으며, 구입 후 환불 및 교환이 불가능합니다. A/S가 가능한 제품인지 해당 쇼핑몰에 반드시 확인 후 주문하세요</p>
                    </div>
                </div>
                <button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay-comm').hide()">레이어 닫기</button>
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
                    <strong class="lay-comm__tit">세금/배송비 유무료</strong>
                </div>
                <div class="lay-comm--body">
                    <div class="lay-comm--inner">
                        <p class="tx_tit">세금(관세,부가세), 배송료를 별도로 내야 합니다.</p>
                        <p class="tx_sub">해외 배송시 부과되는 세금, 배송료가 가격에 포함되어 있지 않습니다. 상품 특성상 교환, 환불, A/S가 어려우니 쇼핑몰에 확인 후 구매하세요</p>

                        <a href="http://www.enuri.com/knowcom/detail.jsp?kbno=438838" class="guide__link" target="_blank" title="해외 쇼핑 구매과정 안내">*해외 쇼핑 구매과정 안내</a>
                    </div>
                </div>
                <button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay-comm').hide()">레이어 닫기</button>
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
                    <strong class="lay-comm__tit">배송비 포함 가격이란?</strong>
                </div>
                <div class="lay-comm--body">
                    <div class="lay-comm__inner">
                        <strong>배송비를 포함하여 계산한 가격</strong>을 낮은 순으로 정렬했습니다.<br>
                        착불, 조건배송 상품은 제외하고 <strong>배송비가 정확한 상품만 표시</strong>됩니다.
                    </div>
                </div>
                <button class="lay-comm__btn--close comm__sprite" onclick="$(this).closest('.lay-comm').hide()">레이어 닫기</button>
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
                    rtnHtml += "<p class=\"tx_tit\"><span>주의사항</span><i class=\"ico ico--noti\">!</i></p>";
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
                        <p class="tx_tit">옵션 필수 선택 상품 <i class="ico ico--noti">!</i> <span class="tx_sub">추가금발생</span></p>
                        <p class="tx_info">옵션을 반드시 선택해야 구매가능한 상품이오니, 최종 옵션적용가를 확인 후 구매하세요.</p>
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
                            <div class="col col-2">
                                <button type="button" class="btn btn--opt">옵션보기</button>
                            </div>
                            <div class="col col-3">
                                <a href="${bridgeUrl}" target="_blank"  class="tx_price" onclick="insertLogLSV(14510,${gModelData.gCategory},${gModelData.gModelno});"><em>${v.price.format()}</em>원</a>
                                <span class="tx_sub">+ 추가금 발생</span>
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
    var bannerObj = $('#vip_circlebanner'); // 둥둥이 배너
    if (ca_code.length > 4) {
        ca_code = ca_code.substring(0, 4);
    }
    // bannerpos에 따라 둥둥이 또는 vip 중단 배너를 호출 한다.
    var varBannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_lp/T4/req?cate=" + ca_code;
    if (bannerpos == 'D') {
        bannerObj = $('#comgoodsBanner'); // VIP 중단 배너
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
// 옵션 CTU
function addOptionCtu(shop_code, goods_code, pl_no, deliveryInfo, priceView, moveLink) {
    let today = new Date();
    let cur_time = `${today.getHours()}${today.getMinutes()}`;

    if (typeof(shop_code) == "undefined") shop_code = "";
    if (typeof(goods_code) == "undefined") goods_code = 0;
    if (typeof(pl_no) == "undefined") pl_no = 0;
    // 새벽 1~5시 사이에는 ctu를 읽어오지 못하므로 갱신 안함
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

//옵션보기 layer 열기
function loadOptionView(pl_no,deliveryInfo,priceView,moveLink) {
    if(deliveryInfo === "무료배송") deliveryInfo = 0;

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
                    alert("옵션정보가 없습니다.");
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
                alert("옵션정보가 없습니다.");
            }
        }
    });
}

//1번 옵션 선택
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
                            <label for="radioOPTSELECT1_01" data-name="${optionName}">선택안함</label>
                        </li>`;

                json.optionSubList.forEach((v,i) => {
                    html += `<li>
                                <input type="radio" id="radioOPTSELECT1_0${i+2}" name="radioOPTSELECT" class="input--radio-item">
                                <label for="radioOPTSELECT1_0${i+2}" data-name="${optionName}" data-subname="${v.option_sub_name}" data-price=${v.option_price}>${v.option_sub_name}:${parseInt(v.option_price).format()}원</label>
                            </li>`;
                });

                $('#PRODOPTIONVIEW .col-2 .optsel__list').html(html);
                $('#PRODOPTIONVIEW .optsel__price .line__price').empty();
                //col-3에 있는 col-2옵션 check
                if($(`#PRODOPTIONVIEW .col-3 .optsel__list li[data-name="${optionName}"]`)){
                    let $subname = $(`#PRODOPTIONVIEW .col-3 .optsel__list li[data-name="${optionName}"]`).data('subname');

                    $(`#PRODOPTIONVIEW .col-2 .optsel__list label[data-subname="${$subname}"]`).prev().prop('checked',true);
                }

                //col-2옵션 선택
                $('#PRODOPTIONVIEW .col-2 .optsel__list label').unbind().click(function(){
                    selectOption($(this).data('name'),$(this).data('subname'),$(this).data('price'),priceView);
                });
            }
        }
    });
}

//2번 옵션 선택
function selectOption(name,subName,price,priceView){
    let html = "";

    html += `<li data-name="${name}" data-subname="${subName}">
                <p class="tx_name">${name}<span class="tx_sub">(${subName})</span></p>
                <p class="tx_price" data-price=${price}><em>${parseInt(price).format()}</em>원</p>
                <button type="button" class="btn btn__del">삭제</button>
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

        //레이어 하단 옵션 포함가
        for(let i=0; i<$('#PRODOPTIONVIEW .col-3 .tx_price').length; i++){
            optPrice = optPrice + $('#PRODOPTIONVIEW .col-3 .tx_price').eq(i).data('price');
        }
        optCnt = $('#PRODOPTIONVIEW .col-3 .optsel__list li').length;
        priceHtml += `기본가 ${parseInt(priceView).format()}원 + 옵션 ${optCnt}개 ${optPrice.format()}원 = <strong class="tx_price">옵션포함가 <em></em>${parseInt(priceView+optPrice).format()}원</strong>`;

        $('#PRODOPTIONVIEW .optsel__price .line__price').html(priceHtml);
    }
}

//선택 옵션 삭제
function deleteOption(name,priceView){
    let priceHtml = "";
    let optCnt = 0;
    let optPrice = 0;

    $(`#PRODOPTIONVIEW .col-2 .optsel__list label[data-name="${name}"]`).eq(0).prev().prop('checked',true);
    $(`#PRODOPTIONVIEW .col-3 li[data-name="${name}"]`).remove();

    //레이어 하단 옵션 포함가
    for(let i=0; i<$('#PRODOPTIONVIEW .col-3 .tx_price').length; i++){
        optPrice = optPrice + $('#PRODOPTIONVIEW .col-3 .tx_price').eq(i).data('price');
    }
    optCnt = $('#PRODOPTIONVIEW .col-3 .optsel__list li').length;
    priceHtml += `기본가 ${parseInt(priceView).format()}원 + 옵션 ${optCnt}개 ${optPrice.format()}원 = <strong class="tx_price">옵션포함가 <em></em>${parseInt(priceView+optPrice).format()}원</strong>`;

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