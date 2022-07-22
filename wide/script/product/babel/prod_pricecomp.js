(function (global, factory) {
    if (typeof define === "function" && define.amd) {
        define(["exports", "./prod_common.js"], factory);
    } else if (typeof exports !== "undefined") {
        factory(exports, require("./prod_common.js"));
    } else {
        var mod = {
            exports: {}
        };
        factory(mod.exports, global.prod_common);
        global.prod_pricecomp = mod.exports;
    }
})(this, function (exports, _prod_common) {
    "use strict";

    Object.defineProperty(exports, "__esModule", {
        value: true
    });
    exports.prodPriceCompView = exports.priceCompPromise = exports.paramHandler = undefined;

    var prodCommon = _interopRequireWildcard(_prod_common);

    function _interopRequireWildcard(obj) {
        if (obj && obj.__esModule) {
            return obj;
        } else {
            var newObj = {};

            if (obj != null) {
                for (var key in obj) {
                    if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key];
                }
            }

            newObj.default = obj;
            return newObj;
        }
    }

    var compTier = "";
    var authImage = "";
    var cardfilterCheck = false;
    var similarModelCheck = false;
    var goodsMinPrice = 0;
    var leftObj = new Object();
    var rightObj = new Object();
    var storageUrl = "http://storage.enuri.info";

    var param = {
        modelno: gModelData.gModelno,
        leftmore: 0,
        rightmore: 0,
        sort: "price",
        card: "N",
        delivery: "N",
        selshop: "",
        prono: promo,
        showcnt: ""
    };
    var paramHandler = exports.paramHandler = {
        set: function set(prop, value) {
            if (prop == "leftmore" || prop == "rightmore") {
                param[prop] += value;
            } else {
                if (prop == "sort") {
                    param["more"] = "N";
                    param["mix"] = "N";
                    param["selshop"] = "";
                    param["leftmore"] = 0;
                    param["rightmore"] = 0;
                } else if (prop == "mix") {} else if (prop == "selshop") {
                    param["sort"] = "price";
                    param["more"] = "N";
                    param["mix"] = "N";
                    param["leftmore"] = 0;
                    param["rightmore"] = 0;
                } else if (prop == "card" || prop == "delivery") {
                    param["sort"] = "price";
                    param["leftmore"] = 0;
                    param["rightmore"] = 0;
                }
                param[prop] = value;
                priceCompPromise().then(prodPriceCompView);
            }
            return true;
        },
        get: function get(prop) {
            return param[prop];
        },
        init: function init() {
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

    var priceCompPromise = exports.priceCompPromise = function priceCompPromise(data) {
        if (typeof data !== 'undefined') {
            param = data;
        }
        return new Promise(function (resolve, reject) {
            $.ajax({
                type: "post",
                url: "/wide/api/product/prodPrice.jsp",
                data: param,
                dataType: "json",
                success: function success(response) {
                    resolve(response);
                }, error: function error(_error) {
                    reject(_error);
                }
            });
        });
    };

    var prodPriceCompView = exports.prodPriceCompView = function prodPriceCompView(json) {
        if (json.success && json.total > 0) {
            leftObj = json.data.left;
            rightObj = json.data.right;

            var cashObj = json.data.cash;
            var selectShopObj = json.data.selectShopList;
            cardfilterCheck = json.data.cardfilterCheck;
            similarModelCheck = json.data.similarModelCheck;
            goodsMinPrice = json.data.goodsMinPrice;
            compTier = json.data.goodsCompareTier;
            authImage = json.data.authCode;
            $("#tabPrice").find("a em").html("(" + json.total + ")");
            $("#prod_comp_except").hide();
            //디폴트 설정
            //카드할인가 포함 버튼 초기화
            $("#prod_pricecomp").find(".comparison__head").show();
            $('#prod_pricecomp .input--checkbox-item').prop('checked', false);
            if (paramHandler.get("delivery") === 'Y') $("#deliveryInc-3").prop('checked', true);
            if (paramHandler.get("card") === 'Y') $("#cardsaleInc-3").prop('checked', true);

            //카드 할인가 없을때 제거
            !cardfilterCheck ? $("#cardsaleInc-3").parent().hide() : $("#cardsaleInc-3").parent().show();

            $("#prod_pricecomp").find(".comparison__cont > div").data("all", false);
            /*$("#prod_pricecomp .sort_block .sort_chk input").unbind('click').click(function(){
                ($(this).is(':checked') === true)
                ? paramHandler.set(`${$(this).data('sort')}`, 'Y')
                : paramHandler.set(`${$(this).data('sort')}`, 'N');
                  /*로그 정리되면 수정
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

            //쇼핑몰 선택 layer
            prodPriceCompShopListView(selectShopObj);

            $("#prod_pricecomp").find(".comparison__cont .comparison__lt .comprod__list").empty();
            $("#prod_pricecomp").find(".comparison__cont .comparison__rt .comprod__list").empty();
            $("#prod_pricecomp").find(".similar__cont .similar__list").empty();
            //유사모델
            if (similarModelCheck) {
                prodPriceSimModelTierView(rightObj);
            } else {
                prodPriceCompTierView(leftObj, "left");
                prodPriceCompTierView(rightObj, "right");
                $("#prod_pricecomp").find(".comparison__cont").show();
            }
            prodCashPriceComShopListView(cashObj);
            //공식인증 log
            if (authImage != "") {
                authInsertLog(1);
            }
            $("#prod_pricecomp .similar__cont").find("li.similar__item").on("click", function () {
                ga('send', 'event', 'vip', 'comparison_clickout', 'pricecomparison');
            });
            $("#prod_pricecomp .comparison__cont").find("li.comprod__item").on("click", function () {
                ga('send', 'event', 'vip', 'comparison_clickout', 'pricecomparison');
            });
            $("#prod_pricecomp .cashmall__cont").find("li.cashmall__item").on("click", function () {
                ga('send', 'event', 'vip', 'comparison_clickout', 'cashmall');
            });
        } else {}
    };

    var prodPriceCompTierView = function prodPriceCompTierView(json, tier) {
        var pricelistObj = json.priceList;
        var tmpPriceListArray = [];

        var pricelistObjCount = json.pricelistCount;
        var pricelistObjTitle = json.pricelistTitle;
        var pricelistCaution = json.cautionInfo;
        var pricelistOpt = json.optInfo;
        var html = "";
        var srcPricelistIdx = 0;
        var drcPricelistIdx = 0;
        var gapPricelistIdx = 50;
        var bannerIdx = -1;
        var etcIdx = -1;
        var bannerHtml = "";
        var etcHtml = "";

        if (tier == "right") {
            if (pricelistObjCount < 4) {
                etcIdx = pricelistObjCount;
            } else {
                bannerIdx = 3;
                etcIdx = 3;
            }
            bannerHtml = prodCommon.prodBannerPromise("comp");
            etcHtml += prodCautionInfoView(pricelistCaution);
            etcHtml += prodOptInfoView(pricelistOpt);
        }
        var domObj = void 0;
        if (tier == "left") {
            srcPricelistIdx = paramHandler.get("leftmore") > 0 ? (paramHandler.get("leftmore") - 1) * gapPricelistIdx + 9 : 0;
            drcPricelistIdx = paramHandler.get("leftmore") * gapPricelistIdx + 9 < pricelistObjCount ? paramHandler.get("leftmore") * gapPricelistIdx + 9 : pricelistObjCount;
            domObj = $("#prod_pricecomp").find(".comparison__cont .comparison__lt");
        } else {
            srcPricelistIdx = paramHandler.get("rightmore") > 0 ? (paramHandler.get("rightmore") - 1) * gapPricelistIdx + 9 : 0;
            drcPricelistIdx = paramHandler.get("rightmore") * gapPricelistIdx + 9 < pricelistObjCount ? paramHandler.get("rightmore") * gapPricelistIdx + 9 : pricelistObjCount;
            domObj = $("#prod_pricecomp").find(".comparison__cont .comparison__rt");
        }
        tmpPriceListArray = pricelistObj.slice(srcPricelistIdx, drcPricelistIdx);

        domObj.find(".head__box").html(prodPriceComTierTitleView(pricelistObjTitle, tier));

        if (pricelistObjCount > 0) {
            $.each(tmpPriceListArray, function (index, listData) {
                var badgename = listData.badgename;
                var cardevnt_text = listData.cardevnt_text;
                var cardname = listData.cardname;
                var cardprice = listData.cardprice;
                var cardprice2 = listData.cardprice2;
                var delivery_price = listData.delivery_price;
                var delivery_text = listData.delivery_text;
                var emoney_reward = listData.emoney_reward;
                var freeinterest = listData.freeinterest;
                var goodscode = listData.goodscode;
                var goodsname = listData.goodsname;
                var imageurl = listData.imageurl;
                var instanceprice = listData.instanceprice;
                var option_check = listData.option_check;
                var plno = listData.plno;
                var price = listData.price;
                var price2 = listData.price2;
                var shopcode = listData.shopcode;
                var shopname = listData.shopname;
                var shoptype = listData.shoptype;
                var coupon = listData.coupon;
                var coupon_contents = listData.coupon_contents;

                var oversea_check = listData.oversea_check;
                var overseaEmoney_check = listData.overseaEmoney_check;
                var overseaShopping_check = listData.overseaShopping_check;
                var tlcshop_check = listData.tlcshop_check;
                var mobileprice_check = listData.mobileprice_check;
                var shoplogo_check = listData.shoplogo_check;
                var ad_check = listData.ad_check;
                var seller_ad = listData.seller_ad;
                var promotion_cpnDcAmt = listData.promotion_cpnDcAmt;
                var promotion_cpnDcCode = listData.promotion_cpnDcCode;
                var promotion_cpnDcPrice = listData.promotion_cpnDcPrice;
                var promotion_cpnDcView = listData.promotion_cpnDcView;
                var promotion_cpnIconView = listData.promotion_cpnIconView;
                var promotion_cpnMiniVipIconView = listData.promotion_cpnMiniVipIconView;
                var promotion_cpnMiniVipIconViewText = listData.promotion_cpnMiniVipIconViewText;
                var promotion_cpnRandUrl = listData.promotion_cpnRandUrl;
                var promotion_cpnRate = listData.promotion_cpnRate;
                var promotion_cpnViewDcd = listData.promotion_cpnViewDcd;
                var promotion_cpnViewText = listData.promotion_cpnViewText;
                var deliveryCod_check = listData.deliveryCod_check;

                var bridgeUrl = prodCommon.bridgeUrl('move_link', "" + shopcode, "" + gModelData.gModelno, "" + gModelData.gFactory, "" + plno, "" + coupon, "" + price, 1);
                var minprice_check = false;
                var delivery_textView = "";
                var freeinterestAry = new Array();
                var firstFreeInterest = 0;
                var freeinterestView = "";
                var priceView = 0;
                if (seller_ad != "") {
                    //판매자 광고 로그
                    setSellerAdLog(plno);
                }
                if ($.isNumeric(delivery_text)) {
                    if (param.card == "Y" && param.delivery == "Y") {
                        delivery_textView = numComma(delivery_text) + "원 (배송제외 " + (cardname != "" ? numComma(cardprice) : numComma(price)) + "원)";
                    } else if (param.delivery == "Y") {
                        delivery_textView = numComma(delivery_text) + "원 (배송제외 " + numComma(price) + "원)";
                    } else if (param.card == "Y") {
                        delivery_textView = numComma(delivery_text) + "원 (배송포함 " + (cardname != "" ? numComma(cardprice2) : numComma(price2)) + "원)";
                    } else {
                        delivery_textView = numComma(delivery_text) + "원 (배송포함 " + numComma(price2) + "원)";
                    }
                } else {
                    if (!deliveryCod_check) delivery_textView = "(" + delivery_text + ")";
                }

                if (param.sort == "price") {
                    if (param.delivery == "Y" && param.card == "Y") {
                        if (cardname != "") {
                            priceView = cardprice2;
                        } else {
                            priceView = price2;
                        }
                    } else if (param.delivery == "Y") {
                        priceView = price2;
                    } else if (param.card == "Y") {
                        if (cardname != "") {
                            priceView = cardprice;
                        } else {
                            priceView = price;
                        }
                    } else {
                        priceView = price;
                    }
                }
                if (priceView === goodsMinPrice) {
                    minprice_check = true;
                }
                //할부

                freeinterestAry = convertFreeInterest(freeinterest).split('/');

                $.each(freeinterestAry, function (i, v) {
                    if (v != "") {
                        v = v.replace(/,/gi, "/");
                        freeinterestView += "<li>" + v + "</li>";
                        var freeinterestMonth = v.match(/([0-9]{1,2}~?)개월/);
                        if (freeinterestMonth != null && freeinterestMonth[1].trim().length > 0) {
                            var tmpMonth = parseInt(freeinterestMonth[1].trim().replace("~", ""));
                            if (firstFreeInterest == 0 || firstFreeInterest < tmpMonth) {
                                firstFreeInterest = tmpMonth;
                            }
                        }
                    }
                });
                if (shoptype == "4") {
                    freeinterestView = "<li><p>최대 10개월<br>(카드정보 해당 페이지에서 확인가능)</p></li>";
                    firstFreeInterest = 10;
                }

                // 강제추가 시 상품명없는 경우 모델명으로 처리.
                if (goodsname === "") goodsname = gModelData.gModelNmView;

                html += "<li class=\"comprod__item " + (ad_check && param.sort == "price" ? "is-top" : "") + "\" data-shoptype=" + shoptype + " data-shopcode=" + shopcode + " data-goodscode=" + goodscode + " data-plno=" + plno + " data-delivery=" + delivery_text + " data-price=" + priceView + ">\n                        <div class=\"col col--lt\">\n                            <a href=\"" + bridgeUrl + "\" target=\"_blank\" class=\"tx_shop\" onclick=\"insertLogLSV(14515,'" + gModelData.gCategory + "','" + gModelData.gModelno + "');\">\n                            " + (shoplogo_check ? "<img src=\"" + storageUrl + "/logo/logo20/logo_20_" + shopcode + ".png\" alt=\"" + shopname + "\" onerror=\"$(this).replaceWith('" + shopname + "')\">" : "" + shopname) + "\n                            </a>\n                            " + (badgename != "" ? "<a href=\"" + bridgeUrl + "\" target=\"_blank\" class=\"badge badge--" + badgename + "\">\uBE60\uB978\uBC30\uC1A1</a>" : "") + "\n                            " + (badgename == "quick" ? "<div class=\"lay-tooltip lay-comm lay-comm--sm\" onmouseleave=\"$(this).fadeOut(300);\" style=\"display: none;\">\n                                                    <div class=\"lay-comm--head\">\n                                                        <strong class=\"lay-comm__tit\">\uBE60\uB978\uBC30\uC1A1</strong>\n                                                    </div>\n                                                    <div class=\"lay-comm--body\">\n                                                        <div class=\"lay-comm__inner\">\n                                                            <ul class=\"ins-list\">\n                                                                <li>\uC77C\uC815 \uC2DC\uAC04 \uC548\uC5D0 \uC8FC\uBB38\uD55C \uAC74\uC5D0 \uD55C\uD558\uC5EC \uB2F9\uC77C \uBC1C\uC1A1\uD558\uB294 \uBE60\uB978\uBC30\uC1A1 \uC0C1\uD488\uC785\uB2C8\uB2E4.</li>\n                                                                <li>\uC8FC\uBB38 \uC2DC\uAC04\uC5D0 \uB530\uB978 \uC815\uD655\uD55C \uBC1C\uC1A1\uC77C\uC740 \uD574\uB2F9 \uC1FC\uD551\uBAB0 \uC0C1\uD488 \uC0C1\uC138\uD398\uC774\uC9C0\uC5D0\uC11C \uAF2D \uD655\uC778\uD574\uC8FC\uC138\uC694!</li>\n                                                            </ul>\n                                                        </div>\n                                                    </div>\n                                                </div>" : "") + "\n                        </div>\n                        <div class=\"col col--rt\">\n                            <div class=\"pinfo__group\">\n                                <div class=\"line__price\">\n                                    <a href=\"" + bridgeUrl + "\" target=\"_blank\" class=\"tx_price\" onclick=\"insertLogLSV(14515,'" + gModelData.gCategory + "','" + gModelData.gModelno + "');\">\n                                        <em>" + numComma(priceView) + "</em>\uC6D0\n                                    </a>\n                                    <span class=\"tx_delivery\">" + delivery_textView + "</span>\n                                    " + (minprice_check ? "<i class=\"badge badge--minp\">\uCD5C\uC800\uAC00</i>" : "") + "\n                                    " + (mobileprice_check ? "<i class=\"badge badge--mspecial\" onclick=\"$(this).siblings('.lay-mobile-min').toggle();setQrCodeImg(); \">\uBAA8\uBC14\uC77C\uD2B9\uAC00</i>\n                                                        <div class=\"lay-mobile-min lay-comm\" style=\"display: none;\">\n                                                            <div class=\"lay-comm--head\">\n                                                                <strong class=\"lay-comm__tit\">\uBAA8\uBC14\uC77C\uC5D0\uC11C \uAD6C\uB9E4 \uC2DC \uB354 \uC800\uB834\uD569\uB2C8\uB2E4.</strong>\n                                                            </div>\n                                                            <div class=\"lay-comm--body\">\n                                                                <div class=\"lay-comm--inner\">\n                                                                    <div class=\"lay-mobile__qr\">\n                                                                        <img src=\"//img.enuri.info/images/home/@qr.gif\" alt=\"\">\n                                                                    </div>\n                                                                    <div class=\"lay-mobile__cont\">\n                                                                        <p class=\"tx_price\"><em>" + numComma(instanceprice) + "</em>\uC6D0</p>\n                                                                        <div class=\"lay-mobile__tx\">\n                                                                            \uD578\uB4DC\uD3F0 \uC804\uC1A1 \uB610\uB294 QR \uCF54\uB4DC\uB97C \uC2A4\uCE94\uD558\uC2DC\uAC70\uB098, <br>\n                                                                            \uC5D0\uB204\uB9AC\uC571\uC744 \uD1B5\uD574 \uAD6C\uB9E4\uD574 \uC8FC\uC138\uC694!\n                                                                        </div>\n                                                                        <div class=\"lay-mobile__btn\">\n                                                                            <button class=\"btn-mobile--zzim " + (gModelData.gZzim ? "is--on" : "") + "\" onclick=\"showLayZzim(this," + gModelData.gModelno + ");\">\uCC1C</button>\n                                                                            <button class=\"btn-mobile--sendsms\" onclick=\"$(this).closest('.lay-comm').find('.lay-mobile-sendsms').toggle();\">\uD578\uB4DC\uD3F0 \uC804\uC1A1</button>\n                                                                            <button class=\"btn-mobile--app\" onclick=\"window.open('/common/jsp/App_Landing.jsp');\">\uC5D0\uB204\uB9AC\uC571 \uC124\uCE58</button>\n                                                                        </div>\n                                                                    </div>\n                                                                </div>\n                                                                <div class=\"lay-mobile-sendsms\" style=\"display:none\">\n                                                                    <div class=\"sendsms__form\">\n                                                                        <fieldset>\n                                                                            <legend>SMS\uBCF4\uB0B4\uAE30</legend>\n                                                                            <input type=\"text\" class=\"sendsms__form--inp\" placeholder=\"- \uC5C6\uC774 \uC785\uB825\uD558\uC138\uC694\">\n                                                                            <button class=\"sendsms__form--btn\" onclick=\"sendDetailSms(this, 'detail');\">\uC804\uC1A1</button>\n                                                                        </fieldset>\n                                                                    </div>\n                                                                    <span class=\"sendsms__send-url--tx\">- \uC0C1\uD488 \uC0C1\uC138 \uC8FC\uC18C\uB97C \uBB34\uB8CC\uBB38\uC790\uB85C \uBC1C\uC1A1\uD574\uB4DC\uB9BD\uB2C8\uB2E4.</span>\n                                                                    <span class=\"sendsms__send-url--tx\">- \uC785\uB825\uD558\uC2E0 \uBC88\uD638\uB294 \uC800\uC7A5\uB418\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.</span>\n                                                                </div>\n                                                            </div>\n                                                            <!-- \uBC84\uD2BC : \uB808\uC774\uC5B4 \uB2EB\uAE30 -->\n                                                            <button class=\"lay-comm__btn--close comm__sprite\" onclick=\"$(this).parent().hide()\">\uB808\uC774\uC5B4 \uB2EB\uAE30</button>\n                                                        </div>" : "") + "\n                                    " + (cardname != "" && param.card == "Y" ? "<i class=\"badge badge--card\">" + cardname + "</i>" : "") + "\n                                    " + (oversea_check ? "<i class=\"badge badge--direct\">\uC9C1\uAD6C</i>" : "") + "\n                                    " + (ad_check && param.sort == "price" ? "<i class=\"badge badge--ad\">AD</i>" : "") + "\n                                    " + (deliveryCod_check === true ? "<div class=\"delicash\">\n                                                                    <span class=\"delivery--cash\">\uCC29\uBD88</span>\n                                                                    <div class=\"lay-tooltip lay-comm lay-comm--sm\" onmouseleave=\"$(this).fadeOut(300);\" style=\"display: none;\">\n                                                                        <div class=\"lay-comm--head\">\n                                                                            <strong class=\"lay-comm__tit\">\uCC29\uBD88/\uC720\uBB34\uB8CC</strong>\n                                                                        </div>\n                                                                        <div class=\"lay-comm--body\">\n                                                                            <div class=\"lay-comm__inner\">\n                                                                                <p class=\"tx_tit tx_stress\">\uCD1D \uC0C1\uD488\uAE08\uC561\uC5D0 \uBC30\uC1A1\uBE44\uAC00 \uD3EC\uD568\uB418\uC5B4 \uC788\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.</p>\n                                                                                <p class=\"tx_sub\">\uC1FC\uD551\uBAB0 \uC774\uB3D9 \uD6C4 \uBC18\uB4DC\uC2DC \uC0C1\uD488\uC815\uBCF4 \uBC0F \uAC00\uACA9\uC744 \uB2E4\uC2DC \uD55C\uBC88 \uD655\uC778\uD558\uC138\uC694.</p>\n                                                                            </div>\n                                                                        </div>\n                                                                    </div>\n                                                                </div>" : "") + "\n                                    " + (cardname != "" ? " <div class=\"tx_cardprice\">\n                                                            <a href=\"" + bridgeUrl + "\" target=\"_blank\"  class=\"tx_price\" onclick=\"insertLogLSV(14515,'" + gModelData.gCategory + "','" + gModelData.gModelno + "');\">\n                                                                <em>" + (param.card == "Y" && param.delivery == "Y" ? numComma(price2) : param.card == "Y" ? numComma(price) : numComma(cardprice2)) + "</em>\uC6D0\n                                                                " + (!(param.card == "Y") ? "<span class=\"tx_card\">" + cardname + "</span>" : "") + "\n                                                            </a>\n                                                        </div>" : "") + "\n                                </div>\n                                <div class=\"line__info\">\n                                    " + (promotion_cpnViewDcd == "M" ? "<div class=\"tx_coupon\">\n                                                                        <span class=\"tx_name\">" + promotion_cpnViewText + "</span>\n                                                                        " + (promotion_cpnIconView == "Y" ? "<a href=\"" + promotion_cpnRandUrl + "\" target=\"_blank\" class=\"btn btn--coupon\">\uCFE0\uD3F0\uBC1B\uAE30</a>" : "") + "\n                                                                    </div>" : "") + "\n                                    " + (promotion_cpnViewDcd == "C" && promotion_cpnViewText != "" ? "<a href=\"" + promotion_cpnRandUrl + "\" target=\"_blank\" class=\"tx_promotion\">" + shopname + " " + promotion_cpnViewText + " " + numComma(promotion_cpnDcPrice) + "\uC6D0</a>" : "") + "\n                                    " + (oversea_check ? " <div class=\"tx_direct\">\n                                                            <span class=\"tx_txt\">\uAD6C\uB9E4 \uC804 \uC0C1\uD488\uC815\uBCF4\uC640 \uAC00\uACA9\uC744 \uAF2D \uD655\uC778\uD558\uC138\uC694!</span>\n                                                        </div>" : "") + "\n                                    " + (shopcode == 6641 ? "<div class=\"tx_timon\">\n                                                            <span class=\"tx_txt\">[\uB2E8\uB3C5] PC\uC5D0\uC11C \uAD6C\uB9E4 \uC2DC e\uBA38\uB2C8 \uC801\uB9BD!</span>\n                                                        </div>" : "") + "\n                                    " + (seller_ad != "" ? "<div class=\"tx_direct\"><span class=\"tx_txt\">" + seller_ad + "</span></div>" : "") + "\n                                    " + (promotion_cpnRandUrl == "C" ? "<a href=\"" + promotion_cpnRandUrl + "\" class=\"tx_promotion\">" + promotion_cpnViewText + " " + numComma(promotion_cpnDcPrice) + "\uC6D0</a>" : "") + "\n                                    <a href=\"" + bridgeUrl + "\" target=\"_blank\" class=\"tx_prodname\" onclick=\"insertLogLSV(14515,'" + gModelData.gCategory + "','" + gModelData.gModelno + "');\">" + goodsname + "</a>\n                                </div>\n                            </div>\n                        </div>\n                        <div class=\"btn__group\">\n                            <ul class=\"btn__list\">\n                                <li class=\"abs--singo\"><button type=\"button\" class=\"btn btn--singo\">\uC2E0\uACE0</button></li>\n                                " + (option_check ? "<li><button type=\"button\" class=\"btn btn--opt\">\uC635\uC158\uBCF4\uAE30</button></li>" : "") + "\n                                " + (cardname != "" ? "<li>\n                                                        <button type=\"button\" class=\"btn btn--card\">\uCE74\uB4DC\uD2B9\uAC00</button>\n                                                            <div class=\"lay-tooltip lay-comm lay-comm--sm\" onmouseleave=\"$(this).fadeOut(300);\" style=\"display: none;\">\n                                                                <div class=\"lay-comm--head\">\n                                                                    <strong class=\"lay-comm__tit\">\uCE74\uB4DC\uD2B9\uAC00</strong>\n                                                                </div>\n                                                                <div class=\"lay-comm--body\">\n                                                                    <div class=\"lay-comm__inner\">\n                                                                        " + cardname + "<br>\n                                                                        " + cardevnt_text + " (\uC801\uC6A9\uAC00 : " + numComma(cardprice) + "\uC6D0)\n                                                                    </div>\n                                                                </div>\n                                                            </div>\n                                                        </li>" : "") + "\n                                " + (freeinterestView != "" ? "<li>\n                                                            " + (firstFreeInterest > 0 ? "<button type=\"button\" class=\"btn btn--infree-type2\">\uBB34\uC774\uC790 \uCD5C\uB300 " + firstFreeInterest + "\uAC1C\uC6D4</button>" : "<button type=\"button\" class=\"btn\">\uD560\uBD80</button>") + "\n                                                            <div class=\"lay-tooltip lay-comm lay-comm--sm\" onmouseleave=\"$(this).fadeOut(300);\" style=\"display: none;\">\n                                                                <div class=\"lay-comm--head\">\n                                                                    <strong class=\"lay-comm__tit\">\uBB34\uC774\uC790\uD560\uBD80</strong>\n                                                                </div>\n                                                                <div class=\"lay-comm--body\">\n                                                                    <div class=\"lay-comm__inner\">\n                                                                        <p class=\"tx_tit tx_tit--stress\">\uACB0\uC81C \uAE08\uC561 \uBC0F \uCE74\uB4DC\uC0AC\uC5D0 \uB530\uB77C \uBB34\uC774\uC790 \uD61C\uD0DD\uC774 \uB2E4\uB97C \uC218 \uC788\uC73C\uB2C8, \uAD6C\uB9E4 \uC804 \uBC18\uB4DC\uC2DC \uD655\uC778\uD558\uC138\uC694!</p>\n                                                                        <ul class=\"ins-list\">\n                                                                        " + freeinterestView + "\n                                                                        </ul>\n                                                                    </div>\n                                                                </div>\n                                                            </div>\n                                                        </li>" : "") + "\n                                " + (coupon_contents != "" ? "<li>\n                                                                <button type=\"button\" class=\"btn\">\uCFE0\uD3F0</button>\n                                                                <div class=\"lay-tooltip lay-comm lay-comm--sm lay-coupon\" onmouseleave=\"$(this).fadeOut(300);\" style=\"display: none;\">\n                                                                    <div class=\"lay-comm--head\">\n                                                                        <strong class=\"lay-comm__tit\">\uBCF8 \uAC00\uACA9\uC740 <em>\uCD94\uAC00\uD560\uC778 \uCFE0\uD3F0</em> \uC801\uC6A9\uAC00 \uC785\uB2C8\uB2E4.</strong>\n                                                                    </div>\n                                                                    <div class=\"lay-comm--body\">\n                                                                        <div class=\"lay-comm__inner\">\n                                                                            " + coupon_contents + "\n                                                                            <div class=\"lay-coupon__price\">\n                                                                                \uCFE0\uD3F0 \uC801\uC6A9\uAC00 : <em>" + numComma(price) + "</em>\uC6D0\n                                                                            </div>\n                                                                        </div>\n                                                                    </div>\n                                                                </div>\n                                                            </li>" : "") + "\n                                " + (overseaShopping_check ? "<li>\n                                                                <button type=\"button\" class=\"btn btn--global\">\uD574\uC678\uC1FC\uD551</button>\n                                                                <div class=\"lay-tooltip lay-comm lay-comm--sm\" onmouseleave=\"$(this).fadeOut(300);\" style=\"display: none;\">\n                                                                    <div class=\"lay-comm--head\">\n                                                                        <strong class=\"lay-comm__tit\">\uD574\uC678\uC1FC\uD551 \uC720\uC758\uC0AC\uD56D</strong>\n                                                                    </div>\n                                                                    <div class=\"lay-comm--body\">\n                                                                        <div class=\"lay-comm__inner\">\n                                                                            \uBC30\uC1A1\uAE30\uAC04\uC774 \uD3C9\uADE0\uC801\uC73C\uB85C \uC624\uB798\uAC78\uB9AC\uACE0<br>\n                                                                            \uAD50\uD658, \uD658\uBD88 \uBC0F A/S\uAC00 \uC5B4\uB824\uC6B8 \uC218 \uC788\uC2B5\uB2C8\uB2E4.\n                                                                        </div>\n                                                                    </div>\n                                                                </div>\n                                                            </li>" : "") + "\n                                " + (tlcshop_check ? "<li>\n                                                        <button type=\"button\" class=\"btn\">TLC\uCE74\uB4DC\uAC00</button>\n                                                        <div class=\"lay-tooltip lay-comm lay-comm--sm\" onmouseleave=\"$(this).fadeOut(300);\" style=\"display: none;\">\n                                                            <div class=\"lay-comm--head\">\n                                                                <strong class=\"lay-comm__tit\">TLC\uCE74\uB4DC\uAC00</strong>\n                                                            </div>\n                                                            <div class=\"lay-comm--body\">\n                                                                <div class=\"lay-comm__inner\">\n                                                                    <p class=\"tx_tit\">NH\uC62C\uC6D0 Shopping&amp;TLC\uCE74\uB4DC\uB85C 36\uAC1C\uC6D4 \uC7A5\uAE30 \uD560\uBD80</p>\n\n                                                                    <ul class=\"ins-list\">\n                                                                        <li>\uC804\uC6D4 \uCE74\uB4DC \uC774\uC6A9 \uC2E4\uC801 \uAE30\uC900 \uCD5C\uB300 \uB9E4\uC6D4 22,000\uC6D0 \uCCAD\uAD6C\uD560\uC778(20,000\uC6D0 \uD560\uC778+2,000\uC6D0 \uCE90\uC2DC\uBC31)</li>\n                                                                        <li>\uD604\uC7AC \uAD6C\uB9E4\uAC00\uC5D0\uC11C 576,000\uC6D0 \uD560\uC778</li>\n                                                                    </ul>\n                                                                </div>\n                                                            </div>\n                                                        </div>\n                                                    </li>" : "") + "\n                                " + (oversea_check ? "<li>\n                                                        <button type=\"button\" class=\"btn btn--direct\">\uD574\uC678\uC9C1\uAD6C</button>\n                                                        <div class=\"lay-tooltip lay-comm lay-comm--sm\" onmouseleave=\"$(this).fadeOut(300);\" style=\"display: none;\">\n                                                            <div class=\"lay-comm--head\">\n                                                                <strong class=\"lay-comm__tit\">\uD574\uC678\uC9C1\uAD6C</strong>\n                                                            </div>\n                                                            <div class=\"lay-comm--body\">\n                                                                <div class=\"lay-comm__inner\">\n                                                                    \uD574\uC678\uC5D0\uC11C \uC9C1\uC811 \uAD6C\uB9E4\uD558\uB294 \uC0C1\uD488\uC73C\uB85C \uC0C1\uD488 \uC815\uBCF4 \uBC0F \uAD6C\uB9E4\uC808\uCC28 \uB4F1\uC744 \uBC18\uB4DC\uC2DC \uD574\uB2F9 \uC0C1\uD488 \uD398\uC774\uC9C0\uC5D0\uC11C \uD655\uC778\uD558\uC2DC\uAE30 \uBC14\uB78D\uB2C8\uB2E4.\n                                                                </div>\n                                                            </div>\n                                                        </div>\n                                                    </li>" : "") + "\n                                " + (overseaEmoney_check ? "<li>\n                                                            <span class=\"tx_emoney--direct\"><i class=\"ico ico--e\">e\uBA38\uB2C8</i>\uC801\uB9BD</span>\n                                                            <div class=\"lay-tooltip lay-comm\" onmouseleave=\"$(this).fadeOut(300);\" style=\"display: none;\">\n                                                                <div class=\"lay-comm--head\">\n                                                                    <strong class=\"lay-comm__tit\">\uD574\uC678\uC9C1\uAD6C e\uBA38\uB2C8 \uC801\uB9BD\uC548\uB0B4</strong>\n                                                                </div>\n                                                                <div class=\"lay-comm--body\">\n                                                                    <div class=\"lay-comm__inner\">\n                                                                        <p class=\"tx_tit\">\uC5D0\uB204\uB9AC PC/\uBAA8\uBC14\uC77C \uC6F9 \uB610\uB294 \uC571\uC5D0 \uB85C\uADF8\uC778 \uD6C4<br>\uD574\uC678\uC9C1\uAD6C \uC0C1\uD488 \uAD6C\uB9E4\uC2DC \uCD5C\uB300 6.5% e\uBA38\uB2C8\uB97C \uC801\uB9BD\uBC1B\uC744 \uC218 \uC788\uC2B5\uB2C8\uB2E4.</p>\n                                                                        <p class=\"tx_sub\">\uC8FC\uC758\uC0AC\uD56D</p>\n                                                                        <ul class=\"ins-list\">\n                                                                            <li>\uBC18\uB4DC\uC2DC \uC5D0\uB204\uB9AC \uB85C\uADF8\uC778\uC744 \uD574\uC8FC\uC138\uC694.</li>\n                                                                            <li>\uAE30\uD504\uD2B8 \uCE74\uB4DC \uB610\uB294 \uD0C0 \uC81C\uD734\uC0AC \uCFE0\uD3F0 \uC0AC\uC6A9 \uC2DC \uC801\uB9BD\uC5D0 \uC81C\uD55C\uC774 \uC788\uC744 \uC218 \uC788\uC2B5\uB2C8\uB2E4.</li>\n                                                                            <li>\uC8FC\uBB38\uD55C \uC0C1\uD488\uC758 \uBC18\uC1A1, \uAD50\uD658, \uCDE8\uC18C \uB4F1\uC774 \uBC1C\uC0DD \uD560 \uACBD\uC6B0 \uD574\uB2F9 \uAE08\uC561\uC740 e\uBA38\uB2C8 \uC801\uB9BD\uC5D0\uC11C \uC81C\uC678\uB429\uB2C8\uB2E4.</li>\n                                                                            <li>\uBC30\uC1A1\uBE44, \uD3EC\uC778\uD2B8/\uCFE0\uD3F0\uC801\uC6A9 \uAE08\uC561, \uBD80\uAC00\uC138, \uCDE8\uC18C\uB41C \uAE08\uC561\uC744 \uC81C\uC678\uD55C \uC2E4\uC81C \uAE08\uC561 \uAE30\uC900\uC73C\uB85C e\uBA38\uB2C8\uB97C \uC801\uB9BD\uD574 \uB4DC\uB9BD\uB2C8\uB2E4.</li>\n                                                                            <li>\uC9C1\uAD6C\uC0C1\uD488\uC740 \uD658\uC728\uC5D0 \uB530\uB77C \uC2E4\uC81C \uC801\uB9BD\uAE08\uC774 \uB2E4\uB97C \uC218 \uC788\uC2B5\uB2C8\uB2E4.</li>\n                                                                            <li>\uC5D0\uB204\uB9AC\uB97C \uACBD\uC720\uD558\uC5EC \uACB0\uC81C\uD55C \uC0C1\uD488\uC5D0\uB9CC e\uBA38\uB2C8\uAC00 \uC801\uB9BD\uB418\uBA70 \uBC14\uB85C\uC811\uC18D \uB610\uB294 \uAC1C\uC778\uACB0\uC81C\uCC3D\uC744 \uD1B5\uD574 \uACB0\uC81C\uD55C \uC0C1\uD488\uC5D0 \uB300\uD574\uC11C\uB294 e\uBA38\uB2C8\uAC00 \uC801\uB9BD\uB418\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.</li>\n                                                                        </ul>\n                                                                    </div>\n                                                                </div>\n                                                            </div>\n                                                        </li>" : "") + "\n                                " + (emoney_reward > 0 ? "<li><button type=\"button\" class=\"btn btn--emoney\" onclick=\"$('#EMONEYLAYER').show();insertLogLSV(14507,'" + gModelData.gCategory + "','" + gModelData.gModelno + "');\"><i class=\"ico ico--e\">e\uBA38\uB2C8</i><em>" + numComma(emoney_reward) + "</em>\uC810 \uC801\uB9BD</button></li>" : "") + "\n                            </ul>\n                        </div>\n                    </li>";
                if (paramHandler.get("rightmore") == 0) {
                    if (bannerIdx == index + 1) {
                        if (bannerHtml.length > 0) {
                            html += bannerHtml;
                        }
                    }
                    if (etcIdx == index) {
                        html += etcHtml;
                    }
                }
            });
            domObj.find(".comprod__list").append(html);
        } else {
            html += "<li class=\"comprod__item no-data\">\n                    <p class=\"tx_msg\">\uD574\uB2F9 \uC1FC\uD551\uBAB0\uC774 \uC5C6\uC2B5\uB2C8\uB2E4.</p>\n                </li>";
            if (paramHandler.get("rightmore") == 0) {
                if (bannerHtml.length > 0) {
                    html += bannerHtml;
                }
                if (etcHtml.length > 0) {
                    html += etcHtml;
                }
            }
            domObj.find(".comprod__list").html(html);
        }

        domObj.find(".comprod__item .col a").unbind().click(function (e) {
            var vNowtime = new Date().format("yyyyMMddhhmm") * 1;
            if (serviceNShopChkAlert) {
                if ($(this).parents("li").data("shoptype") == "4") {
                    alert("해당 쇼핑몰은 현재 서비스 점검 중입니다.");
                    return false;
                }
            }
            if (serviceChkAlert[$(this).parents("li").data("shopcode")] !== undefined) {
                e.preventDefault();
                alert(serviceChkAlert[$(this).parents("li").data("shopcode")].contents);
                return false;
            } else {
                if (authImage != "") {
                    authInsertLog(2);
                }
            }
        });
        domObj.find(".comprod__item .btn--opt").click(function () {
            var $item = $(this).parents(".comprod__item");
            var moveLink = $item.find('.col--rt .line__price .tx_price').eq(0).attr('href');
            if ($item.hasClass("is-option")) {
                $item = $(this).parents(".opt_item");
                moveLink = $item.find('.col.col-1 .thum__logo').attr('href');
                insertLogLSV(14511, "" + gModelData.gCategory, "" + gModelData.gModelno);
            } else {
                insertLogLSV(14508, "" + gModelData.gCategory, "" + gModelData.gModelno);
            }
            addOptionCtu($item.data('shopcode'), $item.data('goodscode'), $item.data('plno'), $item.data('delivery'), $item.data('price'), moveLink);
        });

        domObj.find(".comprod__item .abs--singo").unbind().click(function () {
            insertLogLSV(14509, "" + gModelData.gCategory, "" + gModelData.gModelno);
            prodCommon.declaration.layerDeclaration($(this));
        });

        if (paramHandler.get("leftmore") == 0 && paramHandler.get("rightmore") == 0) {
            if (pricelistObjCount < 10) {
                domObj.find(".cont__box .adv-search__btn--close").hide();
                domObj.find(".cont__box .adv-search__btn--more").hide();
            } else {
                domObj.find(".cont__box .adv-search__btn--more").show();
                domObj.find(".cont__box .adv-search__btn--close").hide();
            }
        } else {
            if (pricelistObjCount < 10) {
                domObj.find(".cont__box .adv-search__btn--close").hide();
                domObj.find(".cont__box .adv-search__btn--more").hide();
            } else {
                if (drcPricelistIdx < pricelistObjCount) {
                    domObj.find(".cont__box .adv-search__btn--more").show();
                    domObj.find(".cont__box .adv-search__btn--close").hide();
                } else {
                    if (drcPricelistIdx == pricelistObjCount) domObj.data("all", true);
                    domObj.find(".cont__box .adv-search__btn--close").show();
                    domObj.find(".cont__box .adv-search__btn--more").hide();
                }
            }
        }
        domObj.find(".cont__box .adv-search__btn--more").unbind().click(function () {
            insertLogLSV(14512, "" + gModelData.gCategory, "" + gModelData.gModelno);

            var allFlag = false;
            $.each($("#prod_pricecomp").find(".comparison__cont > div"), function (index, obj) {
                if ($(obj).data("all")) {
                    allFlag = true;
                    $(obj).find(".cont__box .adv-search__btn--close").show();
                    $(obj).find(".cont__box .adv-search__btn--more").hide();
                }
            });
            if (allFlag) {
                if (!domObj.data("all")) {
                    if (domObj.find(".cont__box").hasClass("is-unfold")) {
                        if (tier == "left") {
                            paramHandler.set("leftmore", 1);
                            prodPriceCompTierView(leftObj, "left");
                        } else {
                            paramHandler.set("rightmore", 1);
                            prodPriceCompTierView(rightObj, "right");
                        }
                    }
                }
            } else {
                paramHandler.set("leftmore", 1);
                prodPriceCompTierView(leftObj, "left");
                paramHandler.set("rightmore", 1);
                prodPriceCompTierView(rightObj, "right");
            }
            $("#prod_pricecomp").find(".cont__box").addClass("is-unfold");
        });
        domObj.find(".cont__box .adv-search__btn--close").unbind().click(function () {
            $("html,body").stop(true, false).animate({ "scrollTop": $("#prod_pricecomp").offset().top - 150 }, 500);
            //domObj.data("all",true);
            if (leftObj.pricelistCount > 9) {
                $("#prod_pricecomp").find(".comparison__lt .cont__box").removeClass("is-unfold");
                $("#prod_pricecomp").find(".comparison__lt .adv-search__btn--more").show();
                $("#prod_pricecomp").find(".comparison__lt .adv-search__btn--close").hide();
            }
            if (rightObj.pricelistCount > 9) {
                $("#prod_pricecomp").find(".comparison__rt .cont__box").removeClass("is-unfold");
                $("#prod_pricecomp").find(".comparison__rt .adv-search__btn--more").show();
                $("#prod_pricecomp").find(".comparison__rt .adv-search__btn--close").hide();
            }
        });
    };
    var prodPriceSimModelTierView = function prodPriceSimModelTierView(json) {
        var pricelistObj = json.priceList;
        var tmpPriceListArray = [];

        var pricelistObjCount = json.pricelistCount;
        var pricelistObjTitle = json.pricelistTitle;

        var html = "";
        var srcPricelistIdx = 0;
        var drcPricelistIdx = 0;
        var gapPricelistIdx = 50;
        var domObj = void 0;

        srcPricelistIdx = paramHandler.get("rightmore") > 0 ? (paramHandler.get("rightmore") - 1) * gapPricelistIdx + 9 : 0;
        drcPricelistIdx = paramHandler.get("rightmore") * gapPricelistIdx + 9;
        tmpPriceListArray = pricelistObj.slice(srcPricelistIdx, drcPricelistIdx);
        if (pricelistObjCount > 0) {

            $.each(tmpPriceListArray, function (index, listData) {
                var badgename = listData.badgename;
                var cardevnt_text = listData.cardevnt_text;
                var cardname = listData.cardname;
                var cardprice = listData.cardprice;
                var cardprice2 = listData.cardprice2;
                var delivery_price = listData.delivery_price;
                var delivery_text = listData.delivery_text;
                var emoney_reward = listData.emoney_reward;
                var freeinterest = listData.freeinterest;
                var goodscode = listData.goodscode;
                var goodsname = listData.goodsname;
                var imageurl = listData.imageurl;
                var instanceprice = listData.instanceprice;
                var option_check = listData.option_check;
                var plno = listData.plno;
                var price = listData.price;
                var price2 = listData.price2;
                var shopcode = listData.shopcode;
                var shopname = listData.shopname;
                var shoptype = listData.shoptype;

                var coupon_contents = listData.coupon_contents;

                var oversea_check = listData.oversea_check;
                var overseaEmoney_check = listData.overseaEmoney_check;
                var overseaShopping_check = listData.overseaShopping_check;
                var tlcshop_check = listData.tlcshop_check;
                var mobileprice_check = listData.mobileprice_check;
                var ad_check = listData.ad_check;
                var shoplogo_check = listData.shoplogo_check;
                var coupon = listData.coupon;
                var promotion_cpnDcAmt = listData.promotion_cpnDcAmt;
                var promotion_cpnDcCode = listData.promotion_cpnDcCode;
                var promotion_cpnDcPrice = listData.promotion_cpnDcPrice;
                var promotion_cpnDcView = listData.promotion_cpnDcView;
                var promotion_cpnIconView = listData.promotion_cpnIconView;
                var promotion_cpnMiniVipIconView = listData.promotion_cpnMiniVipIconView;
                var promotion_cpnMiniVipIconViewText = listData.promotion_cpnMiniVipIconViewText;
                var promotion_cpnRandUrl = listData.promotion_cpnRandUrl;
                var promotion_cpnRate = listData.promotion_cpnRate;
                var promotion_cpnViewDcd = listData.promotion_cpnViewDcd;
                var promotion_cpnViewText = listData.promotion_cpnViewText;

                var bridgeUrl = prodCommon.bridgeUrl('move_link', "" + shopcode, "" + gModelData.gModelno, "" + gModelData.gFactory, "" + plno, "" + coupon, "" + price, 1);

                var minprice_check = false;
                var delivery_textView = "";
                var freeinterestView = "";
                var priceView = 0;

                if ($.isNumeric(delivery_text)) {
                    if (param.card == "Y" && param.delivery == "Y") {
                        delivery_textView = numComma(delivery_text) + "원 (배송제외 " + (cardname != "" ? numComma(cardprice) : numComma(price)) + "원)";
                    } else if (param.delivery == "Y") {
                        delivery_textView = numComma(delivery_text) + "원 (배송제외 " + numComma(price) + "원)";
                    } else if (param.card == "Y") {
                        delivery_textView = numComma(delivery_text) + "원 (배송포함 " + (cardname != "" ? numComma(cardprice2) : numComma(price2)) + "원)";
                    } else {
                        delivery_textView = numComma(delivery_text) + "원 (배송포함 " + numComma(price2) + "원)";
                    }
                } else {
                    delivery_textView = "(" + delivery_text + ")";
                }

                if (param.sort == "price") {
                    if (param.delivery == "Y" && param.card == "Y") {
                        if (cardname != "") {
                            priceView = cardprice2;
                        } else {
                            priceView = price2;
                        }
                    } else if (param.delivery == "Y") {
                        priceView = price2;
                    } else if (param.card == "Y") {
                        if (cardname != "") {
                            priceView = cardprice;
                        } else {
                            priceView = price;
                        }
                    } else {
                        priceView = price;
                    }
                }
                if (priceView === goodsMinPrice) {
                    minprice_check = true;
                }
                //할부
                var freeinterestAry = new Array();
                freeinterestAry = convertFreeInterest(freeinterest).split('/');
                $.each(freeinterestAry, function (i, v) {
                    if (v != "") {
                        v = v.replace(/,/gi, "/");
                        freeinterestView += "<li>" + v + "</li>";
                    }
                });
                if (shoptype == "4") {
                    freeinterestView = "<li><p>\uCD5C\uB300 10\uAC1C\uC6D4<br>(\uCE74\uB4DC\uC815\uBCF4 \uD574\uB2F9 \uD398\uC774\uC9C0\uC5D0\uC11C \uD655\uC778\uAC00\uB2A5)</p></li>";
                }
                html += "<li class=\"similar__item\"  data-shoptype=" + shoptype + " data-shopcode=" + shopcode + " data-goodscode=" + goodscode + " data-plno=" + plno + "  data-delivery=" + delivery_text + " data-price=" + priceView + ">\n                        <div class=\"col col-1\">\n                            <a class=\"thum__link\" href=\"" + bridgeUrl + "\" target=\"_blank\" onclick=\"insertLogLSV(14515,'" + gModelData.gCategory + "','" + gModelData.gModelno + "');\">\n                                <img src=\"" + imageurl + "\" alt=\"" + shopname + "\">\n                            </a>\n                        </div>\n                        <div class=\"col col-2\">\n                            <div class=\"badge__group\">\n                                    " + (mobileprice_check ? "<i class=\"badge badge--mspecial\">\uBAA8\uBC14\uC77C\uD2B9\uAC00</i>" : "") + "\n                                    " + (cardname != "" && param.card == "Y" ? "<i class=\"badge badge--card\">" + cardname + "</i>" : "") + "\n                                    " + (ad_check && param.sort == "price" ? "<i class=\"badge badge--ad\">AD</i>" : "") + "\n                                    " + (coupon_contents != "" ? "<i class=\"badge badge--coupon\">\uCFE0\uD3F0</i>" : "") + "\n                            </div>\n\n                            <a href=\"" + bridgeUrl + "\" target=\"_blank\" class=\"tx_link\" onclick=\"insertLogLSV(14515,'" + gModelData.gCategory + "','" + gModelData.gModelno + "');\">" + goodsname + "</a>\n\n                            <div class=\"btn__group\">\n                                <ul class=\"btn__list\">\n                                    <li class=\"abs--singo\"><button type=\"button\" class=\"btn btn--singo\" onclick=\"$('#SINGOLAYER').show()\">\uC2E0\uACE0</button></li>\n                                    " + (option_check ? "<li><button type=\"button\" class=\"btn btn--opt\">\uC635\uC158\uBCF4\uAE30</button></li>" : "") + "\n                                    " + (cardname != "" ? "<li>\n                                                            <button type=\"button\" class=\"btn btn--card\">\uCE74\uB4DC\uD2B9\uAC00</button>\n                                                                <div class=\"lay-tooltip lay-comm lay-comm--sm\" onmouseleave=\"$(this).fadeOut(300);\" style=\"display: none;\">\n                                                                    <div class=\"lay-comm--head\">\n                                                                        <strong class=\"lay-comm__tit\">\uCE74\uB4DC\uD2B9\uAC00</strong>\n                                                                    </div>\n                                                                    <div class=\"lay-comm--body\">\n                                                                        <div class=\"lay-comm__inner\">\n                                                                            " + cardname + "<br>\n                                                                            " + cardevnt_text + " (\uC801\uC6A9\uAC00 : " + numComma(cardprice) + "\uC6D0)\n                                                                        </div>\n                                                                    </div>\n                                                                </div>\n                                                            </li>" : "") + "\n                                    " + (freeinterest != "" ? "<li>\n                                                                <button type=\"button\" class=\"btn\">\uD560\uBD80</button>\n                                                                <div class=\"lay-tooltip lay-comm lay-comm--sm\" onmouseleave=\"$(this).fadeOut(300);\" style=\"display: none;\">\n                                                                    <div class=\"lay-comm--head\">\n                                                                        <strong class=\"lay-comm__tit\">\uBB34\uC774\uC790\uD560\uBD80</strong>\n                                                                    </div>\n                                                                    <div class=\"lay-comm--body\">\n                                                                        <div class=\"lay-comm__inner\">\n                                                                            <ul class=\"ins-list\">\n                                                                            " + freeinterestView + "\n                                                                            </ul>\n                                                                        </div>\n                                                                    </div>\n                                                                </div>\n                                                            </li>" : "") + "\n                                    " + (coupon_contents != "" ? "<li>\n                                                                    <button type=\"button\" class=\"btn\">\uCFE0\uD3F0</button>\n                                                                    <div class=\"lay-tooltip lay-comm lay-comm--sm lay-coupon\" onmouseleave=\"$(this).fadeOut(300);\" style=\"display: none;\">\n                                                                        <div class=\"lay-comm--head\">\n                                                                            <strong class=\"lay-comm__tit\">\uBCF8 \uAC00\uACA9\uC740 <em>\uCD94\uAC00\uD560\uC778 \uCFE0\uD3F0</em> \uC801\uC6A9\uAC00 \uC785\uB2C8\uB2E4.</strong>\n                                                                        </div>\n                                                                        <div class=\"lay-comm--body\">\n                                                                            <div class=\"lay-comm__inner\">\n                                                                                " + coupon_contents + "\n                                                                                <div class=\"lay-coupon__price\">\n                                                                                    \uCFE0\uD3F0 \uC801\uC6A9\uAC00 : <em>" + numComma(price) + "</em>\uC6D0\n                                                                                </div>\n                                                                            </div>\n                                                                        </div>\n                                                                    </div>\n                                                                </li>" : "") + "\n                                    " + (overseaShopping_check ? "<li>\n                                                                    <button type=\"button\" class=\"btn btn--global\">\uD574\uC678\uC1FC\uD551</button>\n                                                                    <div class=\"lay-tooltip lay-comm lay-comm--sm\" onmouseleave=\"$(this).fadeOut(300);\" style=\"display: none;\">\n                                                                        <div class=\"lay-comm--head\">\n                                                                            <strong class=\"lay-comm__tit\">\uD574\uC678\uC1FC\uD551 \uC720\uC758\uC0AC\uD56D</strong>\n                                                                        </div>\n                                                                        <div class=\"lay-comm--body\">\n                                                                            <div class=\"lay-comm__inner\">\n                                                                                \uBC30\uC1A1\uAE30\uAC04\uC774 \uD3C9\uADE0\uC801\uC73C\uB85C \uC624\uB798\uAC78\uB9AC\uACE0<br>\n                                                                                \uAD50\uD658, \uD658\uBD88 \uBC0F A/S\uAC00 \uC5B4\uB824\uC6B8 \uC218 \uC788\uC2B5\uB2C8\uB2E4.\n                                                                            </div>\n                                                                        </div>\n                                                                    </div>\n                                                                </li>" : "") + "\n                                    " + (tlcshop_check ? "<li>\n                                                            <button type=\"button\" class=\"btn\">TLC\uCE74\uB4DC\uAC00</button>\n                                                            <div class=\"lay-tooltip lay-comm lay-comm--sm\" onmouseleave=\"$(this).fadeOut(300);\" style=\"display: none;\">\n                                                                <div class=\"lay-comm--head\">\n                                                                    <strong class=\"lay-comm__tit\">TLC\uCE74\uB4DC\uAC00</strong>\n                                                                </div>\n                                                                <div class=\"lay-comm--body\">\n                                                                    <div class=\"lay-comm__inner\">\n                                                                        <p class=\"tx_tit\">NH\uC62C\uC6D0 Shopping&amp;TLC\uCE74\uB4DC\uB85C 36\uAC1C\uC6D4 \uC7A5\uAE30 \uD560\uBD80</p>\n\n                                                                        <ul class=\"ins-list\">\n                                                                            <li>\uC804\uC6D4 \uCE74\uB4DC \uC774\uC6A9 \uC2E4\uC801 \uAE30\uC900 \uCD5C\uB300 \uB9E4\uC6D4 22,000\uC6D0 \uCCAD\uAD6C\uD560\uC778(20,000\uC6D0 \uD560\uC778+2,000\uC6D0 \uCE90\uC2DC\uBC31)</li>\n                                                                            <li>\uD604\uC7AC \uAD6C\uB9E4\uAC00\uC5D0\uC11C 576,000\uC6D0 \uD560\uC778</li>\n                                                                        </ul>\n                                                                    </div>\n                                                                </div>\n                                                            </div>\n                                                        </li>" : "") + "\n                                    " + (oversea_check ? "<li>\n                                                            <button type=\"button\" class=\"btn btn--direct\">\uD574\uC678\uC9C1\uAD6C</button>\n                                                            <div class=\"lay-tooltip lay-comm lay-comm--sm\" onmouseleave=\"$(this).fadeOut(300);\" style=\"display: none;\">\n                                                                <div class=\"lay-comm--head\">\n                                                                    <strong class=\"lay-comm__tit\">\uD574\uC678\uC9C1\uAD6C</strong>\n                                                                </div>\n                                                                <div class=\"lay-comm--body\">\n                                                                    <div class=\"lay-comm__inner\">\n                                                                        \uD574\uC678\uC5D0\uC11C \uC9C1\uC811 \uAD6C\uB9E4\uD558\uB294 \uC0C1\uD488\uC73C\uB85C \uC0C1\uD488 \uC815\uBCF4 \uBC0F \uAD6C\uB9E4\uC808\uCC28 \uB4F1\uC744 \uBC18\uB4DC\uC2DC \uD574\uB2F9 \uC0C1\uD488 \uD398\uC774\uC9C0\uC5D0\uC11C \uD655\uC778\uD558\uC2DC\uAE30 \uBC14\uB78D\uB2C8\uB2E4.\n                                                                    </div>\n                                                                </div>\n                                                            </div>\n                                                        </li>" : "") + "\n                                    " + (overseaEmoney_check ? "<li>\n                                                                <span class=\"tx_emoney--direct\"><i class=\"ico ico--e\">e\uBA38\uB2C8</i>\uC801\uB9BD</span>\n                                                                <div class=\"lay-tooltip lay-comm\" onmouseleave=\"$(this).fadeOut(300);\" style=\"display: none;\">\n                                                                    <div class=\"lay-comm--head\">\n                                                                        <strong class=\"lay-comm__tit\">\uD574\uC678\uC9C1\uAD6C e\uBA38\uB2C8 \uC801\uB9BD\uC548\uB0B4</strong>\n                                                                    </div>\n                                                                    <div class=\"lay-comm--body\">\n                                                                        <div class=\"lay-comm__inner\">\n                                                                            <p class=\"tx_tit\">\uC5D0\uB204\uB9AC PC/\uBAA8\uBC14\uC77C \uC6F9 \uB610\uB294 \uC571\uC5D0 \uB85C\uADF8\uC778 \uD6C4<br>\uD574\uC678\uC9C1\uAD6C \uC0C1\uD488 \uAD6C\uB9E4\uC2DC \uCD5C\uB300 6.5% e\uBA38\uB2C8\uB97C \uC801\uB9BD\uBC1B\uC744 \uC218 \uC788\uC2B5\uB2C8\uB2E4.</p>\n                                                                            <p class=\"tx_sub\">\uC8FC\uC758\uC0AC\uD56D</p>\n                                                                            <ul class=\"ins-list\">\n                                                                                <li>\uBC18\uB4DC\uC2DC \uC5D0\uB204\uB9AC \uB85C\uADF8\uC778\uC744 \uD574\uC8FC\uC138\uC694.</li>\n                                                                                <li>\uAE30\uD504\uD2B8 \uCE74\uB4DC \uB610\uB294 \uD0C0 \uC81C\uD734\uC0AC \uCFE0\uD3F0 \uC0AC\uC6A9 \uC2DC \uC801\uB9BD\uC5D0 \uC81C\uD55C\uC774 \uC788\uC744 \uC218 \uC788\uC2B5\uB2C8\uB2E4.</li>\n                                                                                <li>\uC8FC\uBB38\uD55C \uC0C1\uD488\uC758 \uBC18\uC1A1, \uAD50\uD658, \uCDE8\uC18C \uB4F1\uC774 \uBC1C\uC0DD \uD560 \uACBD\uC6B0 \uD574\uB2F9 \uAE08\uC561\uC740 e\uBA38\uB2C8 \uC801\uB9BD\uC5D0\uC11C \uC81C\uC678\uB429\uB2C8\uB2E4.</li>\n                                                                                <li>\uBC30\uC1A1\uBE44, \uD3EC\uC778\uD2B8/\uCFE0\uD3F0\uC801\uC6A9 \uAE08\uC561, \uBD80\uAC00\uC138, \uCDE8\uC18C\uB41C \uAE08\uC561\uC744 \uC81C\uC678\uD55C \uC2E4\uC81C \uAE08\uC561 \uAE30\uC900\uC73C\uB85C e\uBA38\uB2C8\uB97C \uC801\uB9BD\uD574 \uB4DC\uB9BD\uB2C8\uB2E4.</li>\n                                                                                <li>\uC9C1\uAD6C\uC0C1\uD488\uC740 \uD658\uC728\uC5D0 \uB530\uB77C \uC2E4\uC81C \uC801\uB9BD\uAE08\uC774 \uB2E4\uB97C \uC218 \uC788\uC2B5\uB2C8\uB2E4.</li>\n                                                                                <li>\uC5D0\uB204\uB9AC\uB97C \uACBD\uC720\uD558\uC5EC \uACB0\uC81C\uD55C \uC0C1\uD488\uC5D0\uB9CC e\uBA38\uB2C8\uAC00 \uC801\uB9BD\uB418\uBA70 \uBC14\uB85C\uC811\uC18D \uB610\uB294 \uAC1C\uC778\uACB0\uC81C\uCC3D\uC744 \uD1B5\uD574 \uACB0\uC81C\uD55C \uC0C1\uD488\uC5D0 \uB300\uD574\uC11C\uB294 e\uBA38\uB2C8\uAC00 \uC801\uB9BD\uB418\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.</li>\n                                                                            </ul>\n                                                                        </div>\n                                                                    </div>\n                                                                </div>\n                                                            </li>" : "") + "\n                                    " + (emoney_reward > 0 ? "<li><button type=\"button\" class=\"btn btn--emoney\" onclick=\"$('#EMONEYLAYER').show();insertLogLSV(14507,'" + gModelData.gCategory + "','" + gModelData.gModelno + "');\"><i class=\"ico ico--e\">e\uBA38\uB2C8</i><em>" + numComma(emoney_reward) + "</em>\uC810 \uC801\uB9BD</button></li>" : "") + "\n                                </ul>\n                            </div>\n                        </div>\n                        <div class=\"col col-3\">\n                            <div class=\"box--logo\">\n                                <a class=\"thum\" href=\"" + bridgeUrl + "\" target=\"_blank\" onclick=\"insertLogLSV(14515,'" + gModelData.gCategory + "','" + gModelData.gModelno + "');\">\n                                " + (shoplogo_check ? "<img src=\"" + storageUrl + "/logo/logo16/logo_16_" + shopcode + ".png\" alt=\"" + shopname + "\" onerror=\"$(this).replaceWith('" + shopname + "')\">" : "" + shopname) + "\n                                </a>\n                                " + (badgename != "" ? "<a href=\"" + bridgeUrl + "\" target=\"_blank\" class=\"badge badge--" + badgename + "\">\uBE60\uB978\uBC30\uC1A1</a>" : "") + "\n                            </div>\n                        </div>\n                        <div class=\"col col-4\">\n                            <div class=\"box--price\">\n                                <span class=\"tx_delivery\">" + delivery_textView + "</span>\n                                <a href=\"" + bridgeUrl + "\" target=\"_blank\" class=\"tx_price\" onclick=\"insertLogLSV(14515,'" + gModelData.gCategory + "','" + gModelData.gModelno + "');\">" + (minprice_check ? "\uCD5C\uC800\uAC00" : "") + "<em>" + numComma(priceView) + "</em>\uC6D0</a>\n                            </div>\n                        </div>\n                    </li>";
            });
        } else {
            html += "<li class=\"comprod__item no-data\">\n                    <p class=\"tx_msg\">\uD574\uB2F9 \uC1FC\uD551\uBAB0\uC774 \uC5C6\uC2B5\uB2C8\uB2E4.</p>\n                </li>";
            $("#prod_pricecomp").find(".similar__cont .adv-search__btn--more").hide();
        }

        $("#prod_pricecomp").find(".similar__cont .similar__list").append(html);

        if (drcPricelistIdx < pricelistObjCount) {
            $("#prod_pricecomp").find(".similar__cont .adv-search__btn--close").hide();
            $("#prod_pricecomp").find(".similar__cont .adv-search__btn--more").show();
        } else {
            if (pricelistObjCount < 9) {
                $("#prod_pricecomp").find(".similar__cont .adv-search__btn--more").hide();
                $("#prod_pricecomp").find(".similar__cont .adv-search__btn--close").hide();
            } else {
                $("#prod_pricecomp").find(".similar__cont .adv-search__btn--more").hide();
                $("#prod_pricecomp").find(".similar__cont .adv-search__btn--close").show();
            }
        }

        $("#prod_pricecomp").find(".similar__cont .adv-search__btn--more").unbind().click(function () {
            insertLogLSV(14512, "" + gModelData.gCategory, "" + gModelData.gModelno);
            if (!$("#prod_pricecomp").find(".similar__cont").hasClass()) {
                $("#prod_pricecomp").find(".similar__cont").addClass("is-unfold");
            }
            if (drcPricelistIdx > pricelistObjCount) {
                $("#prod_pricecomp").find(".similar__cont").addClass("is-unfold");
                $("#prod_pricecomp").find(".similar__cont .adv-search__btn--close").show();
                $("#prod_pricecomp").find(".similar__cont .adv-search__btn--more").hide();
            } else {
                paramHandler.set("rightmore", 1);
                prodPriceSimModelTierView(rightObj, "right");
            }
        });

        $("#prod_pricecomp").find(".similar__cont .adv-search__btn--close").unbind().click(function () {
            $("#prod_pricecomp").find(".similar__cont").removeClass("is-unfold");
            $("#prod_pricecomp").find(".similar__cont .adv-search__btn--close").hide();
            $("#prod_pricecomp").find(".similar__cont .adv-search__btn--more").show();
        });

        $("#prod_pricecomp").find(".similar__cont .similar__item .btn--opt").unbind().click(function () {
            insertLogLSV(14508, "" + gModelData.gCategory, "" + gModelData.gModelno);
            var $item = $(this).parents('.similar__item');
            var moveLink = $item.find('.col.col-2 .tx_link').attr('href');

            addOptionCtu($item.data('shopcode'), $item.data('goodscode'), $item.data('plno'), $item.data('delivery'), $item.data('price'), moveLink);
        });

        $("#prod_pricecomp").find(".similar__cont .similar__item .abs--singo").unbind().click(function () {
            insertLogLSV(14509, "" + gModelData.gCategory, "" + gModelData.gModelno);
            prodCommon.declaration.layerDeclaration($(this));
        });
        $("#prod_pricecomp").find(".similar__cont .similar__item .col a").unbind().click(function (e) {
            var vNowtime = new Date().format("yyyyMMddhhmm") * 1;

            if (serviceNShopChkAlert) {
                if ($(this).parents("li").data("shoptype") == "4") {
                    alert("해당 쇼핑몰은 현재 서비스 점검 중입니다.");
                    return false;
                }
            }
            if (serviceChkAlert[$(this).parents("li").data("shopcode")] !== undefined) {
                e.preventDefault();
                alert(serviceChkAlert[$(this).parents("li").data("shopcode")].contents);
                return false;
            }
        });
        $("#prod_pricecomp").find(".similar__cont").show();
    };
    var prodPriceCompShopListView = function prodPriceCompShopListView(json) {
        var mallHtml = '';
        var krShopList = json.krShopList;
        var ovsShopList = json.ovsShopList;
        var selShopArray = paramHandler.get("selshop").split(",");

        function cntChecked() {
            var domesticListCnt = $('#mall_layer input[id^=\'chkDOMESTIC\']').not('#chkDOMESTIC').length;
            var overseasListCnt = $('#mall_layer input[id^=\'chkOVERSEAS\']').not('#chkOVERSEAS').length;
            var domesticCheckedCnt = $('#mall_layer input[id^=\'chkDOMESTIC\']:checked').not('#chkDOMESTIC').length;
            var overseasCheckedCnt = $('#mall_layer input[id^=\'chkOVERSEAS\']:checked').not('#chkOVERSEAS').length;
            var shopChecked = $('#mall_layer .lay-mall__list > li > input:checked').not('#chkDOMESTIC,#chkOVERSEAS');

            domesticListCnt === domesticCheckedCnt ? $('#chkDOMESTIC').prop('checked', true) : $('#chkDOMESTIC').prop('checked', false);

            overseasListCnt === overseasCheckedCnt ? $('#chkOVERSEAS').prop('checked', true) : $('#chkOVERSEAS').prop('checked', false);

            $('#mall-layer-apply em').text(shopChecked.length);
        }

        function shopListChkAll($this) {
            var $parent = $this.parent();
            var isChecked = false;

            $this.prop('checked') ? isChecked = true : isChecked = false;

            $parent.siblings("[data-mall=\"" + $parent.data('mall') + "\"]").each(function (i, v) {
                $(v).find('input').prop('checked', isChecked);
            });

            cntChecked();
        }

        function applyShop() {
            var shopChecked = $('#mall_layer .lay-mall__list > li > input:checked').not('#chkDOMESTIC,#chkOVERSEAS');
            var selShopComma = '';

            $.each(shopChecked, function (i, v) {
                if (i > 0) selShopComma += ",";
                selShopComma += v.value;
            });

            paramHandler.set("selshop", selShopComma);

            shopChecked.length > 0 ? $(".btnMallSort").addClass("has-chk") : $(".btnMallSort").removeClass("has-chk");
        }

        if (krShopList.length === 0 && krShopList.length === 0) {
            $('#mall_layer .lay-mall__list li.no-data').show();
            $('#mall-layer-confirm').show();
        } else {
            var makeHtml = function makeHtml(mallType, shopList) {
                var isChked = '';
                var $id = '';
                var domText = '';
                var displayValue = '';

                if (mallType === 'domestic') {
                    displayValue = 'block';
                    $id = 'chkDOMESTIC';
                    $('#mallCountDomestic').text(shopList.length);
                } else if (mallType === 'overseas') {
                    displayValue = 'none';
                    $id = 'chkOVERSEAS';
                    $('#mallCountOverseas').text(shopList.length);
                }

                if (shopList.length > 1) domText += "<li data-mall=\"" + mallType + "\" style=\"display:" + displayValue + "\"><input type=\"checkbox\" id=\"" + $id + "\" class=\"input--checkbox-item\" value=\"all\"><label for=\"" + $id + "\">\uC804\uCCB4</label></li>";

                $.each(shopList, function (index, listData) {
                    selShopArray.indexOf(listData.shopcode.toString()) > -1 ? isChked = 'checked' : isChked = '';

                    domText += "<li data-mall=\"" + mallType + "\" style=\"display:" + displayValue + "\"><input type=\"checkbox\" id=\"" + $id + "_" + index + "\" class=\"input--checkbox-item\" value=\"" + listData.shopcode + "\" " + isChked + "><label for=\"" + $id + "_" + index + "\">" + listData.shopname + "</label></li>";
                });

                return domText;
            };

            ;

            if (krShopList.length > 0) mallHtml += makeHtml('domestic', krShopList);
            if (ovsShopList.length > 0) mallHtml += makeHtml('overseas', ovsShopList);

            $('#mall_layer .lay-tab__mall button').unbind().click(function () {
                var logNo = void 0;
                var selectedMall = $("#mall_layer .lay-mall__list li[data-mall=\"" + $(this).data('mall') + "\"]");

                $(this).data('mall') === 'domestic' ? logNo = 26222 : logNo = 26223;

                insertLogLSV(logNo, "" + gModelData.gCategory, "" + gModelData.gModelno);

                $(this).siblings().removeClass('is-on');
                $(this).addClass('is-on');
                $('#mall_layer .lay-mall__list li').hide();

                selectedMall.length > 0 ? selectedMall.show() : $('#mall_layer .lay-mall__list li.no-data').show();
            });

            $('#mall_layer .btn__group .btn__cancel').unbind().click(function () {
                insertLogLSV(26901, "" + gModelData.gCategory, "" + gModelData.gModelno);
            });

            $('#mall_layer .btn__group .btn__cancel, #mall-layer-apply').show();
        }

        if ($('#mall_layer .lay-mall__list li').not('.no-data').length === 0) $('#mall_layer .lay-mall__list').append(mallHtml);
        $('#mall_layer .lay-mall__list > li > input').not('#chkDOMESTIC,#chkOVERSEAS').unbind().click(function () {
            cntChecked();
        });
        $('#mall_layer .lay-mall__list > li > input[value="all"]').unbind().click(function () {
            shopListChkAll($(this));
        });
        $('#mall_layer .lay-tab__mall button').removeClass('is-on');
        $('#mall_layer .lay-tab__mall button').eq(0).addClass('is-on');
        $('#mall_layer .lay-mall__list li').hide();
        $('#mall_layer .lay-mall__list li[data-mall="domestic"]').show();
        cntChecked();

        $('#mall-layer-apply').unbind().click(function () {
            insertLogLSV(26902, "" + gModelData.gCategory, "" + gModelData.gModelno);
            applyShop();
        });
        $(".btnMallSort").unbind().click(function () {
            insertLogLSV(26900, "" + gModelData.gCategory, "" + gModelData.gModelno);
            var _top = Math.floor($(this).offset().top - 140);
            var _left = Math.floor($(this).offset().left);
            var shopCnt = 0;

            $("#mall_layer .lay-mall__list input").prop('checked', false);

            selShopArray.forEach(function (v) {
                if (v !== '') {
                    $("#mall_layer .lay-mall__list input[value=" + v + "]").prop('checked', true);
                    shopCnt++;
                }
            });

            $('#mall-layer-apply em').text(shopCnt);

            $("#mall_layer").css({ top: _top, left: _left }).show();
        });
    };

    var prodCashPriceComShopListView = function prodCashPriceComShopListView(json) {
        var pricelistObj = json.priceList;
        var pricelistObjCount = json.pricelistCount;
        var html = "";
        if (pricelistObjCount > 0) {
            $.each(pricelistObj, function (index, listData) {
                var delivery_text = listData.delivery_text;
                var goodscode = listData.goodscode;
                var goodsname = listData.goodsname;
                var imageurl = listData.imageurl;
                var instanceprice = listData.instanceprice;
                var plno = listData.plno;
                var price = listData.price;
                var price2 = listData.price2;
                var shopcode = listData.shopcode;
                var shopname = listData.shopname;
                var coupon = listData.coupon;
                var shoplogo_check = listData.shoplogo_check;
                var delivery_textView = "";
                var priceView = 0;
                var bridgeUrl = prodCommon.bridgeUrl('move_link', "" + shopcode, "" + gModelData.gModelno, "" + gModelData.gFactory, "" + plno, "" + coupon, "" + price, 1);

                if ($.isNumeric(delivery_text)) {
                    if (param.delivery == "Y") {
                        delivery_textView = numComma(delivery_text) + "원 (배송제외 " + numComma(price) + "원)";
                    } else {
                        delivery_textView = numComma(delivery_text) + "원 (배송포함 " + numComma(price2) + "원)";
                    }
                } else {
                    delivery_textView = "(" + delivery_text + ")";
                }

                if (param.sort == "price") {
                    if (param.delivery == "Y") {
                        priceView = price2;
                    } else if (param.card == "Y") {
                        priceView = price;
                    } else {
                        priceView = price;
                    }
                }
                html += "<li class=\"cashmall__item\">\n                        <div class=\"col col--lt\">\n                        <a href=\"" + bridgeUrl + "\" class=\"tx_shop\" target=\"_blank\" onclick=\"insertLogLSV(14515,'" + gModelData.gCategory + "','" + gModelData.gModelno + "');\">\n                        " + (shoplogo_check ? "<img src=\"" + storageUrl + "/logo/logo20/logo_20_" + shopcode + ".png\" alt=\"" + shopname + "\" onerror=\"$(this).replaceWith('" + shopname + "')\">" : "" + shopname) + "\n                        </a>\n                        </div>\n                        <div class=\"col col--rt\">\n                            <div class=\"pinfo__group\">\n                                <div class=\"line__price\">\n                                    <a href=\"" + bridgeUrl + "\" class=\"tx_price\" target=\"_blank\" onclick=\"insertLogLSV(14515,'" + gModelData.gCategory + "','" + gModelData.gModelno + "');\"><em>" + numComma(priceView) + "</em>\uC6D0</a>\n                                    <i class=\"badge badge--cash\">\uD604\uAE08</i>\n                                    <p class=\"tx_delivery\">" + delivery_textView + "</p>\n                                </div>\n                                <div class=\"line__info\">\n                                    <a href=\"" + bridgeUrl + "\" class=\"tx_prodname\" target=\"_blank\" onclick=\"insertLogLSV(14515,'" + gModelData.gCategory + "','" + gModelData.gModelno + "');\">" + goodsname + "</a>\n                                </div>\n                            </div>\n                        </div>\n                    </li>";
            });
            if (pricelistObjCount > 10) {
                $("#prod_pricecomp").find(".cashmall__cont .adv-search__btn--more").show();
            } else {
                $("#prod_pricecomp").find(".cashmall__cont .adv-search__btn--more").hide();
            }
            $("#prod_pricecomp").find(".cashmall__list").html(html);
            $("#prod_pricecomp").find(".cashmall__cont").show();
        } else {
            $("#prod_pricecomp").find(".cashmall__cont").hide();
        }

        $("#prod_pricecomp").find(".cashmall__cont .adv-search__btn--more").on("click", function () {
            insertLogLSV(14512, "" + gModelData.gCategory, "" + gModelData.gModelno);
            $(this).closest(".cashmall__cont").addClass("is-unfold");
        });
        $("#prod_pricecomp").find(".cashmall__cont .adv-search__btn--close").on("click", function () {
            insertLogLSV(14512, "" + gModelData.gCategory, "" + gModelData.gModelno);
            $(this).closest(".cashmall__cont").removeClass("is-unfold");
        });
    };
    var prodPriceComTierTitleView = function prodPriceComTierTitleView(title, tier) {
        var html = "";
        if (compTier == "authTier") {
            if (tier == "left") {
                html = "  <h3 class=\"head__tit\">\n                    <a href=\"javascript:void(0);\" class=\"logo__link\"><img src=\"http://storage.enuri.info/pic_upload/sdu/auth/" + authImage + "\" alt=\"\"></a>\n                    " + title + "\n                    <button type=\"button\" class=\"ico ico--question\" onclick=\"$(this).parent('.head__tit').siblings('.lay-comparison').toggle()\">?</button>\n                </h3>\n                <div class=\"lay-comparison lay-tooltip lay-comm\" style=\"display:none;\">\n                    <div class=\"lay-comm--head\">\n                        <strong class=\"lay-comm__tit\">\uACF5\uC2DD \uD310\uB9E4\uC790 <i class=\"ico ico--ad\"></i></strong>\n                    </div>\n                    <div class=\"lay-comm--body\">\n                        <div class=\"lay-comm__inner\">\n                            <p class=\"tx_tit\">\uC81C\uC870\uC0AC\uB85C\uBD80\uD130 \uC628\uB77C\uC778 \uD310\uB9E4 \uC778\uC99D \uBC1B\uC740 \uC815\uC2DD \uD310\uB9E4\uC790\uC785\uB2C8\uB2E4.</p>\n\n                            <p class=\"tx_sub\">\uC8FC\uC694\uD2B9\uC9D5</p>\n                            <ul class=\"order-list\">\n                                <li>\n                                    <p class=\"tx_tit\">1.\uC548\uC815\uC801\uC778 \uC7AC\uACE0 \uD655\uBCF4</p>\n                                    <p class=\"tx_sub\">\uC0C1\uD488 \uCD9C\uD558\uAC00 \uCD5C\uC6B0\uC120\uC801\uC73C\uB85C \uC774\uB904\uC9C0\uAE30 \uB54C\uBB38\uC5D0 \uC18C\uBE44\uC790 \uC8FC\uBB38 \uD6C4 \uC7AC\uACE0\uAC00 \uC5C6\uC5B4 \uD658\uBD88\uC774\uB098 \uBC30\uC1A1\uC9C0\uC5F0\uC774 \uCD5C\uC18C\uD654\uB429\uB2C8\uB2E4.</p>\n                                </li>\n                                <li>\n                                    <p class=\"tx_tit\">2. \uC815\uD488 \uD488\uC9C8 \uD655\uC2E4!</p>\n                                    <p class=\"tx_sub\">\uAC04\uD639 \uBC1C\uC0DD\uB420 \uC218 \uC788\uB294 \uBE44\uC815\uD488 \uBC30\uC1A1 \uC6B0\uB824\uAC00 \uC804\uD600 \uC5C6\uC2B5\uB2C8\uB2E4.</p>\n                                </li>\n                                <li>\n                                    <p class=\"tx_tit\">3. \uCD5C\uC6B0\uB7C9 \uD310\uB9E4 \uC11C\uBE44\uC2A4</p>\n                                    <p class=\"tx_sub\">\uACE0\uAC1D \uC751\uB300 \uB4F1\uC758 \uC18C\uBE44\uC790 \uB300\uC751\uCCB4\uACC4\uAC00 \uC798 \uB418\uC5B4 \uC788\uC2B5\uB2C8\uB2E4.</p>\n                                </li>\n                            </ul>\n                        </div>\n                    </div>\n                    <button class=\"lay-comm__btn--close comm__sprite\" onclick=\"$(this).closest('.lay-comm').hide()\">\uB808\uC774\uC5B4 \uB2EB\uAE30</button>\n                </div>";
            } else {
                html = "<h3 class=\"head__tit\">" + title + "</h3>";
            }
        } else if (compTier == "usedTier") {
            if (tier == "left") {
                html = "\n            <h3 class=\"head__tit\">" + title + " <button type=\"button\" class=\"ico ico--question\" onclick=\"$(this).parent('.head__tit').siblings('.lay-comparison').toggle()\">?</button></h3>\n\n            <div class=\"lay-comparison lay-tooltip lay-comm\" style=\"display: none;\">\n                <div class=\"lay-comm--head\">\n                    <strong class=\"lay-comm__tit\">\uC804\uC2DC/\uC911\uACE0</strong>\n                </div>\n                <div class=\"lay-comm--body\">\n                    <div class=\"lay-comm__inner\">\n                        <p class=\"tx_tit\">\uC0AC\uC6A9\uD588\uB358 \uC81C\uD488(\uAC1C\uC778 \uC0AC\uC6A9, \uC804\uC2DC/\uD14C\uC2A4\uD2B8\uC6A9)\uC744 \uC815\uC0C1\uAC00\uBCF4\uB2E4 \uC2FC \uAC00\uACA9\uC5D0 \uD310\uB9E4\uD569\uB2C8\uB2E4. </p>\n                        <p class=\"tx_sub\">\uC7A5\uC2DC\uAC04 \uCF1C\uB193\uC740 \uAC00\uC804 \uC81C\uD488\uC774\uB098 \uC18C\uBAA8\uD488\uC740 \uAD6C\uB9E4 \uD6C4 \uC2E4\uC81C \uC0AC\uC6A9\uAE30\uAC04\uC774 \uC9E7\uC744 \uC218 \uC788\uC2B5\uB2C8\uB2E4. A/S\uAE30\uAC04 \uBC0F \uAC00\uB2A5 \uC5EC\uBD80\uB97C \uD574\uB2F9 \uC1FC\uD551\uBAB0 \uB610\uB294 \uD310\uB9E4\uC790\uC5D0\uAC8C \uBC18\uB4DC\uC2DC \uD655\uC778 \uD6C4 \uC8FC\uBB38\uD558\uC138\uC694.</p>\n                        <ul class=\"ins-list\">\n                            <li>*\uC911\uACE0 : \uC0AC\uC6A9\uD588\uB358 \uC81C\uD488(\uAC1C\uC778 \uB610\uB294 \uC5C5\uC18C\uC6A9)</li>\n                            <li>*\uC804\uC2DC : \uB9E4\uC7A5 \uC804\uC2DC, \uD488\uC9C8 \uD14C\uC2A4\uD2B8\uC6A9 \uC81C\uD488</li>\n                        </ul>\n                    </div>\n                </div>\n                <button class=\"lay-comm__btn--close comm__sprite\" onclick=\"$(this).closest('.lay-comm').hide()\">\uB808\uC774\uC5B4 \uB2EB\uAE30</button>\n            </div>\n            ";
            } else {
                html = "\n            <h3 class=\"head__tit\">" + title + " <button type=\"button\" class=\"ico ico--question\" onclick=\"$(this).parent('.head__tit').siblings('.lay-comparison').toggle()\">?</button></h3>\n\n            <div class=\"lay-comparison lay-tooltip lay-comm\">\n                <div class=\"lay-comm--head\">\n                    <strong class=\"lay-comm__tit\">\uBC18\uD488 \uC0C1\uD488</strong>\n                </div>\n                <div class=\"lay-comm--body\">\n                    <div class=\"lay-comm__inner\">\n                        <p class=\"tx_tit\">\uB2E8\uC21C\uBCC0\uC2EC, \uBD88\uB7C9\uC73C\uB85C \uC778\uD55C \uBC18\uD488 \uC0C1\uD488\uC744 \uC7AC\uD3EC\uC7A5 \uB610\uB294 \uC218\uB9AC \uD6C4 \uC7AC\uD310\uB9E4\uD558\uB294 \uC81C\uD488\uC785\uB2C8\uB2E4.</p>\n                        <p class=\"tx_sub\">\uBC18\uD488\uACFC\uC815\uC5D0\uC11C \uC0DD\uAE34 \uD760\uC9D1\uC774 \uC788\uC744 \uC218 \uC788\uC73C\uBA70, \uAD6C\uC785 \uD6C4 \uD658\uBD88 \uBC0F \uAD50\uD658\uC774 \uBD88\uAC00\uB2A5\uD569\uB2C8\uB2E4. A/S\uAC00 \uAC00\uB2A5\uD55C \uC81C\uD488\uC778\uC9C0 \uD574\uB2F9 \uC1FC\uD551\uBAB0\uC5D0 \uBC18\uB4DC\uC2DC \uD655\uC778 \uD6C4 \uC8FC\uBB38\uD558\uC138\uC694</p>\n                    </div>\n                </div>\n                <button class=\"lay-comm__btn--close comm__sprite\" onclick=\"$(this).closest('.lay-comm').hide()\">\uB808\uC774\uC5B4 \uB2EB\uAE30</button>\n            </div>\n        ";
            }
        } else if (compTier == "tariffTier") {
            if (tier == "left") {
                html = "<h3 class=\"head__tit\">" + title + "</h3>";
            } else {
                html = "\n            <h3 class=\"head__tit\">" + title + "<button type=\"button\" class=\"ico ico--question\" onclick=\"$(this).parent('.head__tit').siblings('.lay-comparison').toggle()\">?</button></h3>\n            <div class=\"lay-comparison lay-tooltip lay-comm\">\n                <div class=\"lay-comm--head\">\n                    <strong class=\"lay-comm__tit\">\uC138\uAE08/\uBC30\uC1A1\uBE44 \uC720\uBB34\uB8CC</strong>\n                </div>\n                <div class=\"lay-comm--body\">\n                    <div class=\"lay-comm--inner\">\n                        <p class=\"tx_tit\">\uC138\uAE08(\uAD00\uC138,\uBD80\uAC00\uC138), \uBC30\uC1A1\uB8CC\uB97C \uBCC4\uB3C4\uB85C \uB0B4\uC57C \uD569\uB2C8\uB2E4.</p>\n                        <p class=\"tx_sub\">\uD574\uC678 \uBC30\uC1A1\uC2DC \uBD80\uACFC\uB418\uB294 \uC138\uAE08, \uBC30\uC1A1\uB8CC\uAC00 \uAC00\uACA9\uC5D0 \uD3EC\uD568\uB418\uC5B4 \uC788\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4. \uC0C1\uD488 \uD2B9\uC131\uC0C1 \uAD50\uD658, \uD658\uBD88, A/S\uAC00 \uC5B4\uB824\uC6B0\uB2C8 \uC1FC\uD551\uBAB0\uC5D0 \uD655\uC778 \uD6C4 \uAD6C\uB9E4\uD558\uC138\uC694</p>\n\n                        <a href=\"http://www.enuri.com/knowcom/detail.jsp?kbno=438838\" class=\"guide__link\" target=\"_blank\" title=\"\uD574\uC678 \uC1FC\uD551 \uAD6C\uB9E4\uACFC\uC815 \uC548\uB0B4\">*\uD574\uC678 \uC1FC\uD551 \uAD6C\uB9E4\uACFC\uC815 \uC548\uB0B4</a>\n                    </div>\n                </div>\n                <button class=\"lay-comm__btn--close comm__sprite\" onclick=\"$(this).closest('.lay-comm').hide()\">\uB808\uC774\uC5B4 \uB2EB\uAE30</button>\n            </div>\n        </div>";
            }
        } else if (compTier == "deliveryTier") {
            if (tier == "left") {
                html = "<h3 class=\"head__tit\">" + title + "</h3>";
            } else {
                html = "\n            <h3 class=\"head__tit\">" + title + "<button type=\"button\" class=\"ico ico--question\" onclick=\"$(this).parent('.head__tit').siblings('.lay-comparison').toggle()\">?</button></h3>\n            <div class=\"lay-comparison lay-tooltip lay-comm\">\n                <div class=\"lay-comm--head\">\n                    <strong class=\"lay-comm__tit\">\uBC30\uC1A1\uBE44 \uD3EC\uD568 \uAC00\uACA9\uC774\uB780?</strong>\n                </div>\n                <div class=\"lay-comm--body\">\n                    <div class=\"lay-comm__inner\">\n                        <strong>\uBC30\uC1A1\uBE44\uB97C \uD3EC\uD568\uD558\uC5EC \uACC4\uC0B0\uD55C \uAC00\uACA9</strong>\uC744 \uB0AE\uC740 \uC21C\uC73C\uB85C \uC815\uB82C\uD588\uC2B5\uB2C8\uB2E4.<br>\n                        \uCC29\uBD88, \uC870\uAC74\uBC30\uC1A1 \uC0C1\uD488\uC740 \uC81C\uC678\uD558\uACE0 <strong>\uBC30\uC1A1\uBE44\uAC00 \uC815\uD655\uD55C \uC0C1\uD488\uB9CC \uD45C\uC2DC</strong>\uB429\uB2C8\uB2E4.\n                    </div>\n                </div>\n                <button class=\"lay-comm__btn--close comm__sprite\" onclick=\"$(this).closest('.lay-comm').hide()\">\uB808\uC774\uC5B4 \uB2EB\uAE30</button>\n            </div>\n        ";
            }
        } else {
            html = "<h3 class=\"head__tit\">" + title + "</h3>";
        }
        return html;
    };

    var prodCautionInfoView = function prodCautionInfoView(json) {
        var rtnHtml = "";
        if (typeof json != "undefined") {
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
                $.each(content_list, function (Index, listData) {
                    var o_content = listData["content"];
                    if (Index > 0) rtnHtml += "<br>";
                    rtnHtml += o_content;
                });
                rtnHtml += "</p>";
            } else if (content_type == 2) {
                rtnHtml += "<img src=\"http://storage.enuri.info/pic_upload/caution/" + img + "\"  usemap=\"#Map\" style=\"width:970px;\">";
                rtnHtml += "<map name=\"Map\">";
                $.each(imgmap_list, function (Index, listData) {
                    var o_img_map = listData["img_map"];
                    var o_map_url = listData["map_url"];
                    var o_open_type = listData["open_type"];
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
    };

    var prodOptInfoView = function prodOptInfoView(json) {
        var rtnHtml = "";
        var optListObj = json;
        if (typeof optListObj != "undefined" && optListObj.length > 0) {
            rtnHtml += "<li class=\"comprod__item is-option\">\n                        <p class=\"tx_tit\">\uC635\uC158 \uD544\uC218 \uC120\uD0DD \uC0C1\uD488 <i class=\"ico ico--noti\">!</i> <span class=\"tx_sub\">\uCD94\uAC00\uAE08\uBC1C\uC0DD</span></p>\n                        <p class=\"tx_info\">\uC635\uC158\uC744 \uBC18\uB4DC\uC2DC \uC120\uD0DD\uD574\uC57C \uAD6C\uB9E4\uAC00\uB2A5\uD55C \uC0C1\uD488\uC774\uC624\uB2C8, \uCD5C\uC885 \uC635\uC158\uC801\uC6A9\uAC00\uB97C \uD655\uC778 \uD6C4 \uAD6C\uB9E4\uD558\uC138\uC694.</p>\n                        <ul class=\"prodopt__list\">";
            $.each(optListObj, function (i, v) {
                var plno = v.plno;
                var price = v.price;
                var shopcode = v.shopcode;
                var shopname = v.shopname;
                var goodscode = v.goodscode;
                var coupon = v.coupon;
                var delivery_text = v.delivery_text;
                var shoplogo_check = v.shoplogo_check;
                var bridgeUrl = prodCommon.bridgeUrl('move_link', "" + shopcode, "" + gModelData.gModelno, "" + gModelData.gFactory, "" + plno, "" + coupon, "" + price, 1);
                rtnHtml += " <li class=\"opt_item\" data-shopcode=" + shopcode + " data-goodscode=" + goodscode + " data-plno=" + plno + " data-delivery=" + delivery_text + " data-price=" + price + ">\n                            <div class=\"col col-1\">\n                                <a href=\"" + bridgeUrl + "\" target=\"_blank\" class=\"thum__logo\" onclick=\"insertLogLSV(14510," + gModelData.gCategory + "," + gModelData.gModelno + ");\">\n                                " + (shoplogo_check ? "<img src=\"" + storageUrl + "/logo/logo20/logo_20_" + shopcode + ".png\" alt=\"" + shopname + "\" onerror=\"$(this).replaceWith('" + shopname + "')\">" : "" + shopname) + "\n                                </a>\n                            </div>\n                            <div class=\"col col-2\">\n                                <button type=\"button\" class=\"btn btn--opt\">\uC635\uC158\uBCF4\uAE30</button>\n                            </div>\n                            <div class=\"col col-3\">\n                                <a href=\"" + bridgeUrl + "\" target=\"_blank\"  class=\"tx_price\" onclick=\"insertLogLSV(14510," + gModelData.gCategory + "," + gModelData.gModelno + ");\"><em>" + v.price.format() + "</em>\uC6D0</a>\n                                <span class=\"tx_sub\">+ \uCD94\uAC00\uAE08 \uBC1C\uC0DD</span>\n                            </div>\n                        </li>";
            });
            rtnHtml += "    </ul>\n                    </li>";
        }

        return rtnHtml;
    };
    var numComma = function numComma(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    };

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
        var today = new Date();
        var cur_time = "" + today.getHours() + today.getMinutes();

        if (typeof shop_code == "undefined") shop_code = "";
        if (typeof goods_code == "undefined") goods_code = 0;
        if (typeof pl_no == "undefined") pl_no = 0;
        // 새벽 1~5시 사이에는 ctu를 읽어오지 못하므로 갱신 안함
        if (!(cur_time >= 100 && cur_time <= 500)) {
            var param = {
                "ctuActionType": 4,
                "shop_code": shop_code,
                "goods_code": goods_code,
                "pl_no": pl_no
            };

            $.ajax({
                type: "get",
                url: "/move/ctuSyncAction.jsp",
                async: false,
                data: param,
                dataType: "html",
                success: function success(data) {
                    // goption_check = data;
                    loadOptionView(pl_no, deliveryInfo, priceView, moveLink);
                }
            });
        } else {
            loadOptionView(pl_no, deliveryInfo, priceView, moveLink);
        }
    }

    //옵션보기 layer 열기
    function loadOptionView(pl_no, deliveryInfo, priceView, moveLink) {
        if (deliveryInfo === "무료배송") deliveryInfo = 0;

        var param = {
            "pl_nos": pl_no,
            "deliveryShowFlag": true
        };

        $.ajax({
            type: "get",
            url: "/lsv2016/ajax/detail/getGoodsOption_ajax.jsp",
            async: true,
            data: param,
            dataType: "json",
            success: function success(json) {
                var html = "";

                if (json.optionModelList.length > 0) {
                    json.optionModelList.forEach(function (v) {
                        if (v.showOptionName) {
                            html += "<li class=\"\" data-option=\"" + v.showOptionName + "\"><button type=\"button\" class=\"btn\">" + v.showOptionName + "</button></li>";
                        }
                    });

                    if (html == "") {
                        alert("옵션정보가 없습니다.");
                    } else {
                        $('#PRODOPTIONVIEW .optsel__list li').remove();
                        $('#PRODOPTIONVIEW .btn__mall').attr('href', moveLink);
                        $('#PRODOPTIONVIEW .col-1 .optsel__list').html(html);
                        $('#PRODOPTIONVIEW .col-1 .optsel__list li').removeClass("is-on");
                        $('#PRODOPTIONVIEW .col-1 .optsel__list li').eq(0).addClass("is-on");
                        loadSubOptionView(pl_no, $('#PRODOPTIONVIEW .col-1 .optsel__list li').eq(0).data('option'), deliveryInfo, priceView);
                        $('#PRODOPTIONVIEW').show();

                        $('#PRODOPTIONVIEW .col-1 .optsel__list li').click(function () {
                            $('#PRODOPTIONVIEW .col-1 .optsel__list li').removeClass("is-on");
                            $(this).addClass("is-on");
                            loadSubOptionView(pl_no, $(this).data('option'), deliveryInfo, priceView);
                        });

                        // $('#PRODOPTIONVIEW .col-1 .optsel__list li').eq(0).click();
                    }
                } else {
                    alert("옵션정보가 없습니다.");
                }
            }
        });
    }

    //1번 옵션 선택
    function loadSubOptionView(pl_no, optionName, deliveryInfo, priceView) {
        var param = {
            "pl_no": pl_no,
            "deliveryShowFlag": true,
            "optionName": optionName,
            "deliveryinfo": deliveryInfo
        };

        $.ajax({
            type: "get",
            url: "/lsv2016/ajax/detail/getGoodsOption_Sub_ajax.jsp",
            async: true,
            data: param,
            dataType: "json",
            success: function success(json) {
                if (json.optionSubList.length > 0) {
                    var html = "";

                    html += "<li>\n                            <input type=\"radio\" id=\"radioOPTSELECT1_01\" name=\"radioOPTSELECT\" class=\"input--radio-item\" checked>\n                            <label for=\"radioOPTSELECT1_01\" data-name=\"" + optionName + "\">\uC120\uD0DD\uC548\uD568</label>\n                        </li>";

                    json.optionSubList.forEach(function (v, i) {
                        html += "<li>\n                                <input type=\"radio\" id=\"radioOPTSELECT1_0" + (i + 2) + "\" name=\"radioOPTSELECT\" class=\"input--radio-item\">\n                                <label for=\"radioOPTSELECT1_0" + (i + 2) + "\" data-name=\"" + optionName + "\" data-subname=\"" + v.option_sub_name + "\" data-price=" + v.option_price + ">" + v.option_sub_name + ":" + parseInt(v.option_price).format() + "\uC6D0</label>\n                            </li>";
                    });

                    $('#PRODOPTIONVIEW .col-2 .optsel__list').html(html);
                    $('#PRODOPTIONVIEW .optsel__price .line__price').empty();
                    //col-3에 있는 col-2옵션 check
                    if ($("#PRODOPTIONVIEW .col-3 .optsel__list li[data-name=\"" + optionName + "\"]")) {
                        var $subname = $("#PRODOPTIONVIEW .col-3 .optsel__list li[data-name=\"" + optionName + "\"]").data('subname');

                        $("#PRODOPTIONVIEW .col-2 .optsel__list label[data-subname=\"" + $subname + "\"]").prev().prop('checked', true);
                    }

                    //col-2옵션 선택
                    $('#PRODOPTIONVIEW .col-2 .optsel__list label').unbind().click(function () {
                        selectOption($(this).data('name'), $(this).data('subname'), $(this).data('price'), priceView);
                    });
                }
            }
        });
    }

    //2번 옵션 선택
    function selectOption(name, subName, price, priceView) {
        var html = "";

        html += "<li data-name=\"" + name + "\" data-subname=\"" + subName + "\">\n                <p class=\"tx_name\">" + name + "<span class=\"tx_sub\">(" + subName + ")</span></p>\n                <p class=\"tx_price\" data-price=" + price + "><em>" + parseInt(price).format() + "</em>\uC6D0</p>\n                <button type=\"button\" class=\"btn btn__del\">\uC0AD\uC81C</button>\n            </li>";

        deleteOption(name, priceView);

        if (subName && typeof price != "undefined") {
            var priceHtml = "";
            var optCnt = 0;
            var optPrice = 0;

            $('#PRODOPTIONVIEW .col-3 .optsel__list').append(html);
            $('#PRODOPTIONVIEW .col-3 .optsel__list li .btn__del').unbind().click(function () {
                var $name = $(this).parents('li').data('name');
                deleteOption($name, priceView);
            });

            //레이어 하단 옵션 포함가
            for (var i = 0; i < $('#PRODOPTIONVIEW .col-3 .tx_price').length; i++) {
                optPrice = optPrice + $('#PRODOPTIONVIEW .col-3 .tx_price').eq(i).data('price');
            }
            optCnt = $('#PRODOPTIONVIEW .col-3 .optsel__list li').length;
            priceHtml += "\uAE30\uBCF8\uAC00 " + parseInt(priceView).format() + "\uC6D0 + \uC635\uC158 " + optCnt + "\uAC1C " + optPrice.format() + "\uC6D0 = <strong class=\"tx_price\">\uC635\uC158\uD3EC\uD568\uAC00 <em></em>" + parseInt(priceView + optPrice).format() + "\uC6D0</strong>";

            $('#PRODOPTIONVIEW .optsel__price .line__price').html(priceHtml);
        }
    }

    //선택 옵션 삭제
    function deleteOption(name, priceView) {
        var priceHtml = "";
        var optCnt = 0;
        var optPrice = 0;

        $("#PRODOPTIONVIEW .col-2 .optsel__list label[data-name=\"" + name + "\"]").eq(0).prev().prop('checked', true);
        $("#PRODOPTIONVIEW .col-3 li[data-name=\"" + name + "\"]").remove();

        //레이어 하단 옵션 포함가
        for (var i = 0; i < $('#PRODOPTIONVIEW .col-3 .tx_price').length; i++) {
            optPrice = optPrice + $('#PRODOPTIONVIEW .col-3 .tx_price').eq(i).data('price');
        }
        optCnt = $('#PRODOPTIONVIEW .col-3 .optsel__list li').length;
        priceHtml += "\uAE30\uBCF8\uAC00 " + parseInt(priceView).format() + "\uC6D0 + \uC635\uC158 " + optCnt + "\uAC1C " + optPrice.format() + "\uC6D0 = <strong class=\"tx_price\">\uC635\uC158\uD3EC\uD568\uAC00 <em></em>" + parseInt(priceView + optPrice).format() + "\uC6D0</strong>";

        $('#PRODOPTIONVIEW .optsel__price .line__price').html(priceHtml);
    }
    var authInsertLog = function authInsertLog(log_tp_cd) {
        var param = {
            "model_no": gModelData.gModelno,
            "cate_cd": gModelData.gCate4,
            "log_tp_cd": log_tp_cd,
            "os_tp_cd": "PC"
        };

        $.ajax({
            type: "get",
            url: "/sdu/factory_certification_log_ajax.jsp",
            data: param,
            dataType: "json",
            success: function success(data) {}
        });
    };
});