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
        global.prod_shopprice = mod.exports;
    }
})(this, function (exports, _prod_common) {
    "use strict";

    Object.defineProperty(exports, "__esModule", {
        value: true
    });
    exports.prodShopPriceView = exports.shopPricePromise = exports.paramHandler = exports.cardshop_check = undefined;

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

    var cardshop_check = exports.cardshop_check = void 0;
    var storageUrl = "http://storage.enuri.info";
    var param = {
        "modelno": gModelData.gModelno,
        "card": "",
        "cate": gModelData.gCategory,
        "delivery": "",
        "prono": "",
        "callcnt": 0
    };

    var paramHandler = exports.paramHandler = {
        set: function set(prop, value) {
            if (prop === "callcnt") {} else {
                param["callcnt"]++;
                param[prop] = value;
                shopPricePromise().then(prodShopPriceView);
            }
            return true;
        },
        get: function get(prop) {
            return param[prop];
        },
        init: function init() {
            param["modelno"] = gModelData.gModelno;
            param["card"] = "";
            param["delivery"] = "";
            param["prono"] = "";
            param["callcnt"] = 0;
        }
    };

    var shopPricePromise = exports.shopPricePromise = function shopPricePromise(data) {
        if (typeof data !== 'undefined') {
            param = data;
        }
        return new Promise(function (resolve, reject) {
            $.ajax({
                type: "post",
                url: "/wide/api/product/prodShopPrice.jsp",
                data: param,
                dataType: "json",
                success: function success(response) {
                    resolve(response);
                }, error: function error(err) {
                    reject("ShopPrice Response is failed");
                }
            });
        });
    };

    var prodShopPriceView = exports.prodShopPriceView = function prodShopPriceView(json) {
        if (json.success && json.total > 0) {
            var shopPriceCnt = json.total;
            var shopPriceJson = json.data;
            var shopPriceList = shopPriceJson.shopPricelist;
            var shopSpecialList = shopPriceJson.specialPrice;
            var priceTop = shopPriceJson.priceTop;
            exports.cardshop_check = cardshop_check = shopPriceJson.cardshop_check;

            //순서있음
            var html = "";
            if (paramHandler.get("callcnt") == 0) {
                //첫번째 쇼핑몰 정보로 ....상단,topfix 배송비..최저가 구매하기 링크
                var firstShopObj = shopPriceList[0];
                if (typeof firstShopObj != "undefined") {
                    var delivery_text = firstShopObj.delivery_text;
                    var bridgeUrl = prodCommon.bridgeUrl('move_link', "" + firstShopObj.shopcode, "" + gModelData.gModelno, "" + gModelData.gFactory, "" + firstShopObj.plno, "" + firstShopObj.coupon, "" + firstShopObj.price, 1);
                    if ($.isNumeric(firstShopObj.delivery_text)) {
                        delivery_text = "배송비 " + numComma(firstShopObj.delivery_text) + "원 별도";
                    } else {
                        delivery_text = firstShopObj.delivery_text;
                    }
                    $("#prod_topfix").find(".prodtabinfo__rt .tx_delivery").html(delivery_text);
                    $("#prod_topfix").find(".prodtabinfo__rt .btn__purchase").attr("href", bridgeUrl);
                    $("#prod_topfix").find(".prodtabinfo__rt .btn__purchase").data("shopcode", firstShopObj.shopcode);
                    $("#prod_summary_top").find(".prodminprice .tx_delivery").html(delivery_text);
                    $("#prod_summary_top").find(".prodminprice .btn__purchase").attr("href", bridgeUrl);
                    $("#prod_summary_top").find(".prodminprice .btn__purchase").data("shopcode", firstShopObj.shopcode);
                    $("#prod_topfix").find(".prodtabinfo__rt .btn__purchase").unbind().click(function (e) {
                        var vNowtime = new Date().format("yyyyMMddhhmm") * 1;
                        if (serviceChkAlert[$(this).data("shopcode")] !== undefined) {
                            e.preventDefault();
                            alert(serviceChkAlert[$(this).data("shopcode")].contents);
                            return false;
                        }
                        insertLogLSV(19304, "" + gModelData.gCategory, "" + gModelData.gModelno);
                        insertLogLSV(14515, "" + gModelData.gCategory, "" + gModelData.gModelno);
                        ga('send', 'event', 'vip', 'top_clickout', 'lowestprice');
                    });
                    $("#prod_summary_top").find(".prodminprice .btn__purchase").unbind().click(function (e) {
                        var vNowtime = new Date().format("yyyyMMddhhmm") * 1;
                        if (serviceChkAlert[$(this).data("shopcode")] !== undefined) {
                            e.preventDefault();
                            alert(serviceChkAlert[$(this).data("shopcode")].contents);
                            return false;
                        }
                        insertLogLSV(18623, "" + gModelData.gCategory, "" + gModelData.gModelno);
                        insertLogLSV(14515, "" + gModelData.gCategory, "" + gModelData.gModelno);
                        ga('send', 'event', 'vip', 'summary_clickout', 'lowestprice');
                    });
                }
                //초기화
                $("#prod_shopprice").find(".m_price__toggle li").each(function () {
                    $(this).find("p").removeClass("is-on");
                });
                if (cardshop_check) {
                    $("#prod_shopprice").find(".toggle__chk.card").parent().show();
                } else {
                    $("#prod_shopprice").find(".toggle__chk.card").parent().hide();
                }
                if (Object.keys(shopSpecialList).length > 0 || Object.keys(priceTop).length > 0 && priceTop.ad_type === "B") {
                    if (typeof shopSpecialList.cardSpecialPrice !== "undefined") {
                        var specialObj = shopSpecialList.cardSpecialPrice;

                        var shopcode = specialObj.shopcode;
                        var shopname = specialObj.shopname;
                        var cardname = specialObj.cardname;
                        var cardprice = specialObj.cardprice;
                        var _delivery_text = specialObj.delivery_text;
                        var plno = specialObj.plno;
                        var coupon = specialObj.coupon;
                        var shoplogo_check = specialObj.shoplogo_check;
                        var _bridgeUrl = prodCommon.bridgeUrl('move_link', "" + shopcode, "" + gModelData.gModelno, "" + gModelData.gFactory, "" + plno, "" + coupon, "" + cardprice, 1);
                        if ($.isNumeric(_delivery_text)) {
                            _delivery_text = numComma(_delivery_text) + "원";
                        } else {
                            _delivery_text = _delivery_text;
                        }

                        html += "<li data-type=\"card\" data-shopcode=\"" + shopcode + "\">\n                                <span class=\"col col-1\">\n                                    <a href=\"" + _bridgeUrl + "\" target=\"_blank\" class=\"logo\" onerror=\"$(this).replaceWith('" + shopname + "')\" >\n                                    " + (shoplogo_check ? "<img src=\"" + storageUrl + "/logo/logo16/logo_16_" + shopcode + ".png\" alt=\"" + shopname + "\" onerror=\"$(this).replaceWith('" + shopname + "')\">" : "" + shopname) + "\n                                    </a>\n                                </span>\n                                <span class=\"col col-2\">\n                                    <a href=\"" + _bridgeUrl + "\" target=\"_blank\" class=\"price\" >\n                                        <span class=\"tx_msg\"><i class=\"ico ico--card\"></i>" + cardname + " \uD560\uC778\uAC00</span>\n                                        <span class=\"tx_price\"><em>" + cardprice.format() + "</em>\uC6D0</span>\n                                    </a>\n                                </span>\n                                <span class=\"col col-3\">\n                                    <span class=\"delivery\">" + _delivery_text + "</span>\n                                </span>\n                            </li>";
                    } else {
                        $("#prod_shopprice").find(".m_price__toggle > .toggle__chk.card").addClass("is-off");
                    }

                    if (typeof shopSpecialList.cashSpecialPrice !== "undefined") {
                        var _specialObj = shopSpecialList.cashSpecialPrice;

                        var _shopcode = _specialObj.shopcode;
                        var _shopname = _specialObj.shopname;
                        var _cardname = _specialObj.cardname;
                        var _shoplogo_check = _specialObj.shoplogo_check;
                        var _delivery_text2 = _specialObj.delivery_text;
                        var _plno = _specialObj.plno;
                        var _coupon = _specialObj.coupon;

                        var price = numComma(_specialObj.price);
                        var _bridgeUrl2 = prodCommon.bridgeUrl('move_link', "" + _shopcode, "" + gModelData.gModelno, "" + gModelData.gFactory, "" + _plno, "" + _coupon, "" + price, 1);
                        if ($.isNumeric(_delivery_text2)) {
                            _delivery_text2 = numComma(_delivery_text2) + "원";
                        } else {
                            _delivery_text2 = _delivery_text2;
                        }
                        html += "<li data-type=\"cash\">\n                                <span class=\"col col-1\">\n                                    <a href=\"" + _bridgeUrl2 + "\" target=\"_blank\" class=\"logo\">\n                                    " + (_shoplogo_check ? "<img src=\"" + storageUrl + "/logo/logo16/logo_16_" + _shopcode + ".png\" alt=\"" + _shopname + "\" onerror=\"$(this).replaceWith('" + _shopname + "')\">" : "" + _shopname) + "\n                                    </a>\n                                </span>\n                                <span class=\"col col-2\">\n                                    <a href=\"" + _bridgeUrl2 + "\" target=\"_blank\" class=\"price\">\n                                        <span class=\"tx_msg\"><i class=\"ico ico--cash\"></i>\uD604\uAE08 \uCD5C\uC800\uAC00</span>\n                                        <span class=\"tx_price\"><em>" + price + "</em>\uC6D0</span>\n                                    </a>\n                                </span>\n                                <span class=\"col col-3\">\n                                    <span class=\"delivery\">" + _delivery_text2 + "</span>\n                                </span>\n                            </li>";
                    }
                    if (typeof shopSpecialList.promoSpecialPrice !== "undefined") {
                        var _specialObj2 = shopSpecialList.promoSpecialPrice;

                        var _shopcode2 = _specialObj2.shopcode;
                        var _shopname2 = _specialObj2.shopname;
                        var _shoplogo_check2 = _specialObj2.shoplogo_check;
                        var _price = numComma(_specialObj2.discountPrice);

                        var promoText = _specialObj2.promotext;
                        var promoUrl = _specialObj2.promourl;
                        html += "<li class=\"is-promotion\" data-type=\"promotion\">\n                                <span class=\"col col-1\">\n                                <a href=\"" + promoUrl + "\" target=\"_blank\" class=\"logo\">\n                                      " + (_shoplogo_check2 ? "<img src=\"" + storageUrl + "/logo/logo16/logo_16_" + _shopcode2 + ".png\" alt=\"" + _shopname2 + "\" onerror=\"$(this).replaceWith('" + _shopname2 + "')\">" : "" + _shopname2) + "\n                                </a>\n                                </span>\n                                <span class=\"col col-2\">\n                                    <a href=\"" + promoUrl + "\" target=\"_blank\" class=\"price\">\n                                        <span class=\"tx_msg\">" + promoText + "</span>\n                                        <span class=\"tx_price\"><em>" + _price + "</em>\uC6D0</span>\n                                    </a>\n                                </span>\n                                <span class=\"col col-3\">\n                                    <a href=\"" + promoUrl + "\" target=\"_blank\" class=\"btn btn--buy\">\uAD6C\uB9E4\uD558\uAE30</a>\n                                </span>\n                            </li>";
                    }

                    if (priceTop.ad_type === "B") {
                        var adShopCode = priceTop.shop_code;
                        var adShopName = priceTop.mall_name;
                        var adCopyText = priceTop.copytext;
                        var _shoplogo_check3 = priceTop.shoplogo_check;
                        var adPrice = priceTop.price;
                        var pl_no = priceTop.pl_no;
                        var adshoppingfee = priceTop.shoppingfee;
                        var url = priceTop.url;
                        var _bridgeUrl3 = "";
                        if (url == "") {
                            _bridgeUrl3 = prodCommon.bridgeUrl('move_link', "" + adShopCode, "" + gModelData.gModelno, "" + gModelData.gFactory, "" + pl_no, "0", "" + adPrice, 1);
                        } else {
                            _bridgeUrl3 = url;
                        }
                        html += "<li class=\"is-adline\">\n                                <span class=\"col col-1\">\n                                    <a href=\"" + _bridgeUrl3 + "\" class=\"logo\" target=\"_blank\">\n                                        " + (url != "" ? "<span>" + adShopName + "</span>" : "" + (_shoplogo_check3 ? "<img src=\"" + storageUrl + "/logo/logo16/logo_16_" + adShopCode + ".png\" alt=\"" + adShopName + "\" onerror=\"$(this).replaceWith('" + adShopName + "')\">" : "<span>" + adShopName + "</span>")) + "\n                                        <i class=\"ico ico--ad\"></i>\n                                    </a>\n                                    <span class=\"tx_sub\">" + adCopyText + "</span>\n                                </span>\n                                <span class=\"col col-2\">\n                                    <a href=\"" + _bridgeUrl3 + "\" class=\"price\" target=\"_blank\">\n                                        <span class=\"tx_price\"><em>" + numComma(adPrice) + "</em>\uC6D0</span>\n                                    </a>\n                                </span>\n                                <span class=\"col col-3\">\n                                    <span class=\"delivery\">" + adshoppingfee + "</span>\n                                </span>\n                            </li>";
                    }

                    $("#special_price").find(".s_price__list").html(html);
                    $("#special_price").show();
                } else {
                    $("#special_price").hide();
                }
            }
            $("#prod_shopprice").find(".toggle__chk").removeClass("is-on");
            if (paramHandler.get("delivery") == "Y") $("#prod_shopprice").find(".toggle__chk.delivery").removeClass("is-off").addClass("is-on");else $("#prod_shopprice").find(".toggle__chk.delivery").removeClass("is-on").addClass("is-off");

            if (paramHandler.get("card") == "Y") $("#prod_shopprice").find(".toggle__chk.card").removeClass("is-off").addClass("is-on");else $("#prod_shopprice").find(".toggle__chk.card").removeClass("is-on").addClass("is-off");
            html = "";
            var firstFreeInterestCnt = 0;
            $.each(shopPriceList, function (index, listData) {
                var goodscode = listData.goodscode;
                var goodsname = listData.goodsname;
                var cardprice = listData.cardprice;
                var cardname = listData.cardname;
                var freeinterest = listData.freeinterest;
                var price = listData.price;
                var price2 = listData.price2;
                var shoptype = listData.shoptype;
                var plno = listData.plno;
                var delivery_text = listData.delivery_text;
                var shopcode = listData.shopcode;
                var shopname = listData.shopname;
                var shoplogo_check = listData.shoplogo_check;
                var delivery_price = listData.delivery_price;
                var cashmall_check = listData.cashmall_check;
                var oversea_check = listData.oversea_check;
                var bagdename = listData.badgename;
                var cardbadge = listData.cardbadge;
                var coupon = listData.coupon;
                var priceView = price;
                var bridgeUrl = prodCommon.bridgeUrl('move_link', "" + shopcode, "" + gModelData.gModelno, "" + gModelData.gFactory, "" + plno, "" + coupon, "" + price, 1);
                //할부
                var freeinterestAry = new Array();
                var firstFreeInterest = 0;
                var freeinterestView = "";
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
                                firstFreeInterestCnt++;
                            }
                        }
                    }
                });
                if (shoptype == "4") {
                    freeinterestView = "<li><p>최대 10개월<br>(카드정보 해당 페이지에서 확인가능)</p></li>";
                    firstFreeInterest = 10;
                    firstFreeInterestCnt++;
                }
                if ($.isNumeric(delivery_text)) {
                    delivery_text = numComma(delivery_text) + "원";
                } else {
                    delivery_text = delivery_text;
                }

                html += "<li class=\"" + (index == 0 ? "is-minline" : "") + "\" data-shopcode=\"" + shopcode + "\">\n                        <span class=\"col col-1\">\n                            <a href=\"" + bridgeUrl + "\" target=\"_blank\" class=\"logo\">\n                                " + (shoplogo_check ? "<img src=\"" + storageUrl + "/logo/logo16/logo_16_" + shopcode + ".png\" alt=\"" + shopname + "\" onerror=\"$(this).replaceWith('" + shopname + "')\">" : "<span>" + shopname + "</span>") + "\n                            </a>\n                            " + (bagdename != "" ? "<a href=\"" + bridgeUrl + "\" target=\"_blank\" class=\"badge badge--" + bagdename + "\"></a>" : "") + "\n                            " + (bagdename == "quick" ? "<div class=\"lay-tooltip lay-comm lay-comm--sm\" onmouseleave=\"$(this).fadeOut(300);\" style=\"display: none;\">\n                                    <div class=\"lay-comm--head\">\n                                        <strong class=\"lay-comm__tit\">\uBE60\uB978\uBC30\uC1A1</strong>\n                                    </div>\n                                    <div class=\"lay-comm--body\">\n                                        <div class=\"lay-comm__inner\">\n                                            <ul class=\"ins-list\">\n                                                <li>\uC77C\uC815 \uC2DC\uAC04 \uC548\uC5D0 \uC8FC\uBB38\uD55C \uAC74\uC5D0 \uD55C\uD558\uC5EC \uB2F9\uC77C \uBC1C\uC1A1\uD558\uB294 \uBE60\uB978\uBC30\uC1A1 \uC0C1\uD488\uC785\uB2C8\uB2E4.</li>\n                                                <li>\uC8FC\uBB38 \uC2DC\uAC04\uC5D0 \uB530\uB978 \uC815\uD655\uD55C \uBC1C\uC1A1\uC77C\uC740 \uD574\uB2F9 \uC1FC\uD551\uBAB0 \uC0C1\uD488 \uC0C1\uC138\uD398\uC774\uC9C0\uC5D0\uC11C \uAF2D \uD655\uC778\uD574\uC8FC\uC138\uC694!</li>\n                                            </ul>\n                                        </div>\n                                    </div>\n                                </div>" : "") + "\n                        </span>\n                        <span class=\"col col-2\">\n                            <a href=\"" + bridgeUrl + "\" target=\"_blank\" class=\"price\">\n                            <span class=\"tx_msg\">\n                                " + (index == 0 ? "\uCD5C\uC800\uAC00" : "") + "\n                                " + (oversea_check ? "<i class=\"ico ico--direct\"></i>" : "") + "\n                                " + (cardbadge ? "<i class=\"ico ico--card\"></i>" : "") + "\n                                " + (cashmall_check ? "<i class=\"ico ico--cash\"></i>" : "") + "\n                            </span>\n\n                                 <span class=\"tx_price\"><em>" + numComma(priceView) + "</em>\uC6D0</span>\n                            </a>\n                        </span>\n                        <span class=\"col col-3\">\n                            <span class=\"delivery\">" + delivery_text + "</span>\n                        </span>\n                        " + (firstFreeInterest > 0 ? "<span class=\"col col-4\">\n                                <span class=\"discount_period\">\uCD5C\uB300 " + firstFreeInterest + "\uAC1C\uC6D4</span>\n                                <div class=\"lay-tooltip lay-comm lay-comm--sm\" onmouseleave=\"$(this).fadeOut(300);\" style=\"display: none;\">\n                                    <div class=\"lay-comm--head\">\n                                        <strong class=\"lay-comm__tit\">\uBB34\uC774\uC790\uD560\uBD80</strong>\n                                    </div>\n                                    <div class=\"lay-comm--body\">\n                                        <div class=\"lay-comm__inner\">\n                                            <p class=\"tx_tit tx_tit--stress\">\uACB0\uC81C \uAE08\uC561 \uBC0F \uCE74\uB4DC\uC0AC\uC5D0 \uB530\uB77C \uBB34\uC774\uC790 \uD61C\uD0DD\uC774 \uB2E4\uB97C \uC218 \uC788\uC73C\uB2C8, \uAD6C\uB9E4 \uC804 \uBC18\uB4DC\uC2DC \uD655\uC778\uD558\uC138\uC694!</p>\n                                            <ul class=\"ins-list\">\n                                            " + freeinterestView + "\n                                            </ul>\n                                        </div>\n                                    </div>\n                                </div>\n                            </span>" : "") + "\n                    </li>";
            });
            if (Object.keys(priceTop).length > 0 && priceTop.ad_type === "A") {
                var phtml = "";
                var _adShopCode = priceTop.shop_code;
                var adClickTitle = priceTop.click_title;
                var _adShopName = priceTop.mall_name;
                var _adCopyText = priceTop.copytext;
                var _shoplogo_check4 = priceTop.shoplogo_check;
                var _adPrice = priceTop.price;
                var _pl_no = priceTop.pl_no;
                var _adshoppingfee = priceTop.shoppingfee;
                var _url = priceTop.url;
                var _bridgeUrl4 = "";
                if (_url == "") {
                    _bridgeUrl4 = prodCommon.bridgeUrl('move_link', "" + _adShopCode, "" + gModelData.gModelno, "" + gModelData.gFactory, "" + _pl_no, "0", "" + _adPrice, 1);
                } else {
                    _bridgeUrl4 = _url;
                }
                html += "<li class=\"is-adline\" data-type=\"ad\" data-shopcode=\"" + _adShopCode + "\">\n                        <span class=\"col col-1\">\n                            <a href=\"" + _bridgeUrl4 + "\" target=\"_blank\" class=\"logo is-txt\" data-ad=\"" + adClickTitle + "\">\n                            " + (_url != "" ? "<span>" + _adShopName + "</span>" : "" + (_shoplogo_check4 ? "<img src=\"" + storageUrl + "/logo/logo16/logo_16_" + _adShopCode + ".png\" alt=\"" + _adShopName + "\" onerror=\"$(this).replaceWith('" + _adShopName + "')\">" : "<span>" + _adShopName + "</span>")) + "\n                             <i class=\"ico ico--ad\"></i>\n                            </a>\n                            <p class=\"tx_sub\">" + _adCopyText + "</p>\n                        </span>\n                        <span class=\"col col-2\">\n                            <a href=\"" + _bridgeUrl4 + "\" target=\"_blank\"  class=\"price\" data-ad=\"" + adClickTitle + "\">\n                                <span class=\"tx_price\"><em>" + numComma(_adPrice) + "</em>\uC6D0</span>\n                            </a>\n                        </span>\n                        <span class=\"col col-3\">\n                            <span class=\"delivery\">" + _adshoppingfee + "</span>\n                        </span>\n                    </li>";
                phtml = "<li>\n                        <div class=\"tb_row\">\n                            <span class=\"col col-1\">\n                                <a href=\"" + _bridgeUrl4 + "\" target=\"_blank\"  class=\"logo\">\n                                " + (_url != "" ? "<span>" + _adShopName + "</span>" : "" + (_shoplogo_check4 ? "<img src=\"" + storageUrl + "/logo/logo20/logo_20_" + _adShopCode + ".png\" alt=\"" + _adShopName + "\" onerror=\"$(this).replaceWith('" + _adShopName + "')\">" : "" + _adShopName)) + "\n                                </a>\n                            </span>\n                            <span class=\"col col-2\">\n                                <a href=\"" + _bridgeUrl4 + "\" target=\"_blank\"  class=\"tx_name\">" + _adCopyText + "</a>\n                                <span class=\"tx_delivery\">" + _adshoppingfee + "</span>\n                            </span>\n                            <span class=\"col col-3\">\n                                <a href=\"" + _bridgeUrl4 + "\" target=\"_blank\"  class=\"tx_price\"><em>" + numComma(_adPrice) + "</em>\uC6D0</a>\n                            </span>\n                        </div>\n                    </li>";
                //$("#prodSponsorPowerClick").html(phtml);
                //$("#prodSponsorPowerClick").show(phtml);
            } else {
                $("#prodSponsorPowerClick").empty();
                $("#prodSponsorPowerClick").hide();
            }

            html += "<li class=\"is-adline is-adjoin\">\n                    <span class=\"col col-1\">\n                        <a href=\"#\" class=\"logo is-txt\"><span>\uC1FC\uD551\uBAB0 \uC601\uC5ED</span><i class=\"ico ico--ad\"><!--AD--></i></a>\n                        <p class=\"tx_sub\">\uD64D\uBCF4\uBB38\uAD6C \uB178\uCD9C \uC601\uC5ED</p>\n                    </span>\n                    <span class=\"col col-2\">\n                        <a href=\"#\" class=\"price\">\n                            <span class=\"tx_price\"><em>\uAD11\uACE0\uC608\uC2DC</em> \uD310\uB9E4\uAC00, \uBC30\uC1A1\uBE44 \uC815\uCC45 \uC601\uC5ED</span>\n                        </a>\n                    </span>\n                    <span class=\"col col-3\">\n                        <a href=\"https://seller.enuri.com/sdul/pricetop/list.jsp\" target=\"_blank\" title=\"\uAD11\uACE0 \uC2E0\uCCAD\uD558\uAE30\" class=\"btn_add_apply\">\uAD11\uACE0 \uC2E0\uCCAD\uD558\uAE30</a>\n                    </span>\n                </li>";

            if (firstFreeInterestCnt > 0) {
                $("#prod_shopprice").find(".m_price__list").addClass("column_forth");
            } else {
                $("#prod_shopprice").find(".m_price__list").removeClass("column_forth");
            }
            $("#prod_shopprice").find(".m_price__list").html(html);

            $("#prod_shopprice").find(".m_price__list li a").unbind().click(function (e) {
                var vNowtime = new Date().format("yyyyMMddhhmm") * 1;
                if (serviceChkAlert[$(this).parents("li").data("shopcode")] !== undefined) {
                    e.preventDefault();
                    alert(serviceChkAlert[$(this).parents("li").data("shopcode")].contents);
                    return false;
                } else {
                    if ($(this).parents("li").hasClass("is-adline")) {
                        $("#hFrame").attr("src", $(this).data("ad"));
                    }
                    if ($(this).hasClass("logo")) {
                        insertLogLSV(18627, "" + gModelData.gCategory, "" + gModelData.gModelno);
                    } else if ($(this).hasClass("price")) {
                        insertLogLSV(18628, "" + gModelData.gCategory, "" + gModelData.gModelno);
                    }
                    insertLogLSV(14515, "" + gModelData.gCategory, "" + gModelData.gModelno);
                    ga('send', 'event', 'vip', 'summary_clickout', 'Lowestshop');
                }
            });

            $("#special_price").find(".s_price__list li").unbind().click(function (e) {
                var specialType = $(this).data("type");
                var vNowtime = new Date().format("yyyyMMddhhmm") * 1;
                if (serviceChkAlert[$(this).data("shopcode")] !== undefined) {
                    e.preventDefault();
                    alert(serviceChkAlert[$(this).data("shopcode")].contents);
                    return false;
                } else {
                    if (specialType == "card") {
                        insertLogLSV(17518, "" + gModelData.gCategory, "" + gModelData.gModelno);
                    }
                    insertLogLSV(14515, "" + gModelData.gCategory, "" + gModelData.gModelno);
                    ga('send', 'event', 'vip', 'summary_clickout', 'promotion');
                }
            });
            $("#prod_shopprice").find(".m_price__list li .btn_add_apply").hover(function () {
                $(this).closest(".is-adjoin").addClass("is-hover");
            }, function () {
                $(this).closest(".is-adjoin").removeClass("is-hover");
            });
            $("#prod_shopprice").show();
        }
    };
    var numComma = function numComma(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    };
});