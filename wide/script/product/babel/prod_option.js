(function (global, factory) {
    if (typeof define === "function" && define.amd) {
        define(["exports", "./prod_init.js", "./prod_pricecomp.js", "./prod_shopprice.js"], factory);
    } else if (typeof exports !== "undefined") {
        factory(exports, require("./prod_init.js"), require("./prod_pricecomp.js"), require("./prod_shopprice.js"));
    } else {
        var mod = {
            exports: {}
        };
        factory(mod.exports, global.prod_init, global.prod_pricecomp, global.prod_shopprice);
        global.prod_option = mod.exports;
    }
})(this, function (exports, _prod_init, _prod_pricecomp, _prod_shopprice) {
    "use strict";

    Object.defineProperty(exports, "__esModule", {
        value: true
    });
    exports.prodOptionView = exports.prodOptionViewTopFix = exports.prodOptionViewTop = exports.optionPromise = exports.paramHandler = undefined;

    var prodInit = _interopRequireWildcard(_prod_init);

    var prodPriceComp = _interopRequireWildcard(_prod_pricecomp);

    var prodShopPrice = _interopRequireWildcard(_prod_shopprice);

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

    function _toConsumableArray(arr) {
        if (Array.isArray(arr)) {
            for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) {
                arr2[i] = arr[i];
            }

            return arr2;
        } else {
            return Array.from(arr);
        }
    }

    var param = {
        "modelno": gModelData.gModelno,
        "unit": "",
        "delivery": "",
        "callcnt": 0
    };
    /* const paramProxy = new Proxy(param,{
        set: (target, prop, value) => {
            if(prop=="modelno"){
                target[prop] = value;
                target["delivery"] = "";
                target["callcnt"] = 0;
            }else if(prop=="callcnt"){
                target[prop]++;
            }else{
                target[prop] = value;
                optionPromise().then(prodOptionView);
            }
            return true;
        }
    }); */
    var paramHandler = exports.paramHandler = {
        set: function set(prop, value) {
            if (prop == "callcnt") {} else {
                param["callcnt"]++;
                param[prop] = value;
                //optionPromise().then(prodOptionView);
                optionPromise().then(prodOptionViewTop).then(prodOptionViewTopFix).then(prodOptionView);
            }
            return true;
        }, get: function get(prop) {
            return param[prop];
        },
        init: function init() {
            param["modelno"] = gModelData.gModelno;
            param["delivery"] = "";
            param["callcnt"] = 0;
        }
    };

    var optionPromise = exports.optionPromise = function optionPromise(data) {
        if (typeof data != "undefined") {
            param = data;
        }
        return new Promise(function (resolve, reject) {
            $.ajax({
                type: "post",
                url: "/wide/api/product/prodOption.jsp",
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

    var prodOptionViewTop = exports.prodOptionViewTop = function prodOptionViewTop(json) {
        if (json.success && json.total > 1) {
            var optionCnt = json.total;
            var optionJson = json.data;
            var optionViewType = optionJson.optionViewType;

            var optionList = optionJson.optionList;
            var optionSelIdx = 0;
            var html = "";

            if (optionCnt > 4) {
                html = "<button type=\"button\" class=\"btn btn__toggle\" >\uD3BC\uCE58\uAE30</button>";
            }
            html += "<ul class=\"buyopt__list\">";
            $.each(optionList, function (index, listData) {
                var price = listData.price;
                var rank = listData.rank;
                var condiname = listData.condiname;
                var modelno = listData.modelno;
                var condilogo = listData.condilogo;
                var rankcount = 0;

                if (gModelData.gModelno == modelno) {
                    optionSelIdx = index;
                }
                if (optionCnt == 3) rankcount = 1;else if (optionCnt > 3 && optionCnt < 8) rankcount = 2;else if (optionCnt >= 8) rankcount = 3;

                html += "<li data-modelno=\"" + modelno + "\" data-val-price=\"" + price + "\" data-name=\"" + condiname + "\" data-rank=\"" + index + "\">\n                        <input type=\"radio\" id=\"radioOPTIONTOP" + index + "\" name=\"radioOPTIONTOP\" class=\"input--radio-item\">\n                        <label for=\"radioOPTIONTOP" + index + "\">\n                        " + (condilogo != "" ? "<span class=\"tx--ad\"><img src=\"" + condilogo + "\" alt=\"" + condiname + "\"></span>" : "<span>" + condiname + "</span>") + "\n                        " + (rank > 0 && rank <= rankcount ? "<i class=\"badge badge--rank\">" + rank + "</i>" : "") + "\n                        </label>\n                    </li>";
            });
            html += "</ul>";+$("#prod_option_top").find(".buyoption").html(html);

            $("#prod_option_top").find(".buyopt__list li[data-modelno=" + gModelData.gModelno + "] input:radio").prop("checked", true);
            if (optionSelIdx > 3) {
                $($("#prod_option_top").find(".buyoption li")[2]).after($("#prod_option_top").find(".buyopt__list li[data-modelno=" + gModelData.gModelno + "]"));
                //$("#prod_option_top").find(".buyopt__list li[data-modelno="+gModelData.gModelno+"]").insertAfter($("#prod_option_top").find(".buyoption li")[2]);
            }
            $("#prod_option_top").find(".btn.btn__toggle").off().on("click", function () {
                if (optionSelIdx > 3) {
                    if (!$("#prod_option_top").find(".buyoption").hasClass("is-unfold")) {
                        //$($("#prod_option_top").find(".buyopt__list li[data-modelno="+gModelData.gModelno+"]")).insertAfter($("#prod_option_top").find(".buyoption li")[optionSelIdx]);
                        //$($("#prod_option_top").find(".buyoption li")[optionSelIdx]).insertAfter($("#prod_option_top").find(".buyopt__list li[data-modelno="+gModelData.gModelno+"]"));
                        $($("#prod_option_top").find(".buyoption li")[optionSelIdx]).after($("#prod_option_top").find(".buyopt__list li[data-modelno=" + gModelData.gModelno + "]"));
                    } else {
                        $($("#prod_option_top").find(".buyoption li")[2]).after($("#prod_option_top").find(".buyopt__list li[data-modelno=" + gModelData.gModelno + "]"));
                        //$("#prod_option_top").find(".buyopt__list li[data-modelno="+gModelData.gModelno+"]").insertAfter($("#prod_option_top").find(".buyoption li")[2]);
                    }
                }
                $(this).closest('.buyoption').toggleClass('is-unfold');
            });
            /* if(!$("#prod_option_top").find(".buyoption").hasClass("is-unfold")){
                if(optionSelIdx > 3){
                 //   $("#prod_option_top").find(".buyoption").addClass("is-unfold");
                 $($("#prod_option_top").find(".buyoption li")[2]).insertAfter($("#prod_option_top").find(".buyopt__list li[data-modelno="+gModelData.gModelno+"]"));
                }else{
                    $("#prod_option_top").find(".buyoption").removeClass("is-unfold");
                }
            } */

            $("#prod_option_top").find(".buyopt__list li").unbind().click(function (e) {

                var modelno = $(this).data("modelno");
                var thisIndex = $(this).index();
                if (modelno != gModelData.gModelno) {
                    insertLog(24450);
                    $(this).siblings().removeClass("is-on");
                    $(this).addClass("is-on");
                    $(this).find("input:radio").prop("checked", true);
                    $("#prod_option").find(".pricecomp__list li, .compare_price__list li").removeClass("is-on");
                    $("#prod_option").find(".pricecomp__list li[data-modelno=" + modelno + "], .compare_price__list li[data-modelno=" + modelno + "]").addClass("is-on");
                    $("#prod_option").find(".pricecomp__list li[data-modelno=" + modelno + "] input:radio, .compare_price__list li[data-modelno=" + modelno + "] input:radio").prop("checked", true);
                    //top fix 세팅
                    $("#prod_topfix").find(".prodtabinfo .select-box__list li").removeClass("is--selected");
                    $("#prod_topfix").find(".prodtabinfo .select-box__list li[data-modelno=" + modelno + "]").addClass("is--selected");
                    $("#prod_topfix").find(".prodtabinfo .select-box--selected #changeOpt").html($(this).data("name"));

                    //가격 변동 효과
                    var price = parseInt($("#prod_summary_top").find(".prodminprice .box__minprice .tx_price em").text().replace(/,/g, ''), 10);
                    var limitNum = $("#prod_option_top").find(".buyopt__list li[data-modelno=" + modelno + "]").data("val-price");
                    $({ countNum: price }).stop(true, true).animate({ countNum: limitNum }, {
                        duration: 400,
                        easing: 'linear',
                        step: function step() {
                            $("#prod_summary_top").find(".prodminprice .box__minprice .tx_price em").text(numComma(Math.floor(this.countNum)));
                        },
                        complete: function complete() {
                            $("#prod_summary_top").find(".prodminprice .box__minprice .tx_price em").text(numComma(Math.floor(this.countNum)));
                        }
                    });
                    e.preventDefault();
                    $("#prod_option_top").find(".btn.btn__toggle").off().on("click", function () {
                        var list = document.querySelector('#prod_option_top .buyopt__list');

                        [].concat(_toConsumableArray(list.children)).sort(function (a, b) {
                            return $(a).data("rank") > $(b).data("rank") ? 1 : -1;
                        }).forEach(function (node) {
                            return list.appendChild(node);
                        });
                        if (thisIndex > 3) {
                            if (!$("#prod_option_top").find(".buyoption").hasClass("is-unfold")) {
                                $($("#prod_option_top").find(".buyoption li")[thisIndex]).after($("#prod_option_top").find(".buyopt__list li[data-modelno=" + modelno + "]"));
                            } else {
                                $($("#prod_option_top").find(".buyoption li")[2]).after($("#prod_option_top").find(".buyopt__list li[data-modelno=" + modelno + "]"));
                            }
                        }
                        $(this).closest('.buyoption').toggleClass('is-unfold');
                    });
                }
                //하단 펼쳐주기 
                if (!$("#prod_option").hasClass("is-unfold")) {
                    if (optionViewType == "1" && optionCnt > 5) {
                        if (thisIndex >= 5) {
                            $("#prod_option").addClass("is-unfold");
                        }
                    } else if (optionViewType == "2" && optionCnt > 10) {
                        if (thisIndex >= 10) {
                            $("#prod_option").addClass("is-unfold");
                        }
                    }
                }
            });
            $("#prod_option_top").show();
        } else {
            $("#prod_option_top").hide();
        }
        return json;
    };
    var prodOptionViewTopFix = exports.prodOptionViewTopFix = function prodOptionViewTopFix(json) {
        if (json.success && json.total > 1) {
            var optionCnt = json.total;
            var optionJson = json.data;
            var optionList = optionJson.optionList;
            var optionViewType = optionJson.optionViewType;
            var html = "";
            $.each(optionList, function (index, listData) {
                html += "<li class=\"select-box__item\" data-modelno=\"" + listData.modelno + "\" data-val-price=\"" + listData.price + "\"><a href=\"#\">" + listData.condiname + "</a></li>";
            });
            $("#prod_topfix").find(".prodtabinfo .prodtabinfo__lt .select-box__list").html(html);

            $("#prod_topfix").find(".prodtabinfo .prodtabinfo__lt .select-box__list li[data-modelno=" + gModelData.gModelno + "]").addClass("is--selected");
            $("#prod_topfix").find(".prodtabinfo .prodtabinfo__lt .prod__select").show();

            $("#prod_topfix").find(".prodtabinfo .select-box__list > li").unbind("click");
            $("#prod_topfix").find(".prodtabinfo .select-box__list > li").click(function (e) {
                var modelno = $(this).data("modelno");
                var thisIndex = $(this).index();

                if (modelno != gModelData.gModelno) {
                    insertLog(24455);
                    $(this).addClass("is--selected").siblings().removeClass("is--selected");
                    $(".prodtabinfo .select-box--selected #changeOpt").html($(this).find("a").html());
                    var $price = $("#detail_minprice").text();
                    var price = parseInt($price.replace(/,/g, ''), 10);
                    var limitNum = $(this).attr('data-val-price');
                    modelno = $(this).data("modelno");
                    // prodInit.gModelHandler.set("gModelno",modelno);

                    $({ countNum: price }).stop(true, true).animate({ countNum: limitNum }, {
                        duration: 400,
                        easing: 'linear',
                        step: function step() {
                            $("#detail_minprice").text(numComma(Math.floor(this.countNum)));
                        },
                        complete: function complete() {
                            $("#detail_minprice").text(numComma(Math.floor(this.countNum)));
                        }
                    });

                    $("#prod_option_top").find(".buyopt__list li[data-modelno=" + modelno + "] input:radio").prop("checked", true);
                    if (!$("#prod_option_top").find(".buyoption").hasClass("is-unfold")) {
                        if (thisIndex > 3) {
                            $("#prod_option_top").find(".buyoption").addClass("is-unfold");
                        }
                    }
                    //중단세팅
                    //하단 펼쳐주기 
                    if (!$("#prod_option").hasClass("is-unfold")) {
                        if (optionViewType == "1" && optionCnt > 5) {
                            if (thisIndex >= 5) {
                                $("#prod_option").addClass("is-unfold");
                            }
                        } else if (optionViewType == "2" && optionCnt > 10) {
                            if (thisIndex >= 10) {
                                $("#prod_option").addClass("is-unfold");
                            }
                        }
                    }
                    $("#prod_option").find(".pricecomp__list li, .compare_price__list li").removeClass("is-on");
                    $("#prod_option").find(".pricecomp__list li[data-modelno=" + modelno + "], .compare_price__list li[data-modelno=" + modelno + "]").addClass("is-on");
                    $("#prod_option").find(".pricecomp__list li[data-modelno=" + modelno + "] input:radio, .compare_price__list li[data-modelno=" + modelno + "] input:radio").prop("checked", true);

                    e.preventDefault();
                }
            });
        } else {
            $("#prod_topfix").find(".prodtabinfo .prodtabinfo__lt .prod__select").hide();
        }
        return json;
    };
    var prodOptionView = exports.prodOptionView = function prodOptionView(json) {
        if (json.success && json.total > 0) {
            var optionCnt = json.total;
            var optionJson = json.data;

            var optionUnitType = optionJson.optionUnitType;
            var optionUnit = optionJson.optionUnit;

            var optionViewType = optionJson.optionViewType;
            var optionList = optionJson.optionList;

            var optionSelIdx = 0;

            var html = "";

            $("#prod_option").removeClass("inc-delivery").removeClass("inc-unitprice").addClass("pricecomp");
            if (optionViewType == "1") {
                $("#prod_option").addClass("inc-delivery");
            } else {
                $("#prod_option").addClass("inc-unitprice");
            }
            if (optionViewType == "1") {
                html += "<p class=\"toggle__chk " + (param.delivery === "Y" ? "is-on" : "is-off") + " \">\n                        <span class=\"switch\"><span class=\"btn\"><em>on/off</em></span><strong>\uBC30\uC1A1\uBE44 \uD3EC\uD568 \uCD5C\uC800\uAC00</strong></span>\n                    </p>\n                    <div class=\"lay-tooltip\">\n                        <div class=\"lay__inner\">\n                            <p class=\"tx_msg\"><em>TIP</em><strong>\uBC30\uC1A1\uBE44\uD3EC\uD568\uCD5C\uC800\uAC00</strong>\uB85C <strong>\uB2E8\uC704\uB2F9 \uAC00\uACA9\uC744 \uBE44\uAD50</strong>\uD574 \uBCFC \uC218 \uC788\uC2B5\uB2C8\uB2E4.</p>\n                        </div>\n                    </div>\n                    <ul class=\"pricecomp__list is-sort\">\n                        <li>\n                            <span class=\"col col-1\"><strong>\uAD6C\uB9E4\uC635\uC158</strong></span>";
                if (optionUnitType) {
                    html += "<span class=\"col col-2\" data-sort=\"asc\"><button type=\"button\" class=\"btn btn--sort\">\uBC30\uC1A1\uBE44</button></span>\n                            <span class=\"col col-3\" data-sort=\"asc\"><button type=\"button\" class=\"btn btn--sort\">" + optionUnit + "\uB2F9 \uAC00\uACA9</button></span>";
                } else {
                    html += "<span class=\"col col-2\" data-sort=\"asc\"></span>\n                            <span class=\"col col-3\" data-sort=\"asc\"><button type=\"button\" class=\"btn btn--sort\">\uBC30\uC1A1\uBE44</button></span>";
                }
                html += "<span class=\"col col-4\" data-sort=\"asc\"><button type=\"button\" class=\"btn btn--sort\">" + (param.delivery == "Y" ? "\uBC30\uC1A1\uBE44 \uD3EC\uD568" : "") + "\uCD5C\uC800\uAC00</button></span>\n                            <span class=\"col col-5\" data-sort=\"asc\"><button type=\"button\" class=\"btn btn--sort\">\uD310\uB9E4\uBAB0</button></span>\n                        </li>\n                    </ul>";
                html += "<ul class=\"pricecomp__list is-col--1\">";
                $.each(optionList, function (index, listData) {
                    var unit_per_price = listData.unit_per_price;
                    var price = listData.price;
                    var price2 = listData.price2;
                    var cash_check = listData.cash_check;
                    var delivery_text = listData.delivery_text;
                    var mallcnt = listData.mallcnt;
                    var unit = listData.unit;
                    var rank = listData.rank;
                    var condiname = listData.condiname;
                    var modelno = listData.modelno;
                    var delivery_textView = "";
                    var priceView = price;
                    var rankcount = 0;
                    var condilogo = listData.condilogo;

                    if (gModelData.gModelno == modelno) {
                        optionSelIdx = index;
                    }
                    if ($.isNumeric(delivery_text)) {
                        delivery_textView = numComma(delivery_text) + "원";
                    } else {
                        delivery_textView = delivery_text;
                    }

                    if (param.delivery == "Y") {
                        priceView = price2;
                    } else {
                        priceView = price;
                    }
                    if (optionCnt == 3) rankcount = 1;else if (optionCnt > 3 && optionCnt < 8) rankcount = 2;else if (optionCnt >= 8) rankcount = 3;
                    html += "<li data-modelno=\"" + modelno + "\" data-name=\"" + condiname + "\" >\n                            <a href=\"javascript:void(0);\" class=\"opt_link\">\n                                <span class=\"col col-1\"  >\n                                    <input type=\"radio\" id=\"radioOPTION" + index + "\" name=\"radioOPTION\" class=\"input--radio-item\" >\n                                    " + (condilogo != "" ? "\n                                    <label for=\"radioOPTION" + index + "\" class=\"tx--ad\">\n                                        <img src=\"" + condilogo + "\" alt=\"" + condiname + "\">\n                                        " + (rank > 0 && rank <= rankcount ? "<i class=\"badge badge--rank\">" + rank + "</i>" : "") + "\n                                    </label>" : "<label for=\"radioOPTION" + index + "\">\n                                        " + condiname + "\n                                        " + (rank > 0 && rank <= rankcount ? "<i class=\"badge badge--rank\">" + rank + "</i>" : "") + "\n                                    </label>") + "\n                                </span>";
                    if (optionUnitType) {
                        html += "<span class=\"col col-2\" data-value=\"" + delivery_text + "\">\n                                        <span class=\"tx_delivery\">" + delivery_textView + "</span>\n                                </span>\n                                <span class=\"col col-3\" data-value=\"" + unit_per_price + "\">\n                                    <span class=\"tx_unitprice\">" + numComma(unit_per_price) + "\uC6D0/" + unit + "</span>\n                                </span>";
                    } else {
                        html += "<span class=\"col col-2\" data-value=\"\">\n                                    <span class=\"tx_delivery\"></span>\n                                </span>\n                                <span class=\"col col-3\" data-value=\"" + delivery_text + "\">\n                                    <span class=\"tx_unitprice\">" + delivery_textView + "</span>\n                                </span>";
                    }
                    html += "<span class=\"col col-4\" data-value=\"" + priceView + "\">\n                            " + (cash_check ? "<i class=\"ico ico--cash\" title=\"\uD604\uAE08 \uCD5C\uC800\uAC00\"></i>" : "") + "\n                                    <span class=\"tx_price\"><em>" + numComma(priceView) + " </em>\uC6D0</span>\n                                </span>\n                                <span class=\"col col-5\" data-value=\"" + mallcnt + "\">\n                                    <span class=\"tx_cnt\"><em>" + numComma(mallcnt) + "</em>\uBAB0</span>\n                                </span>\n                            </a>\n                        </li>";
                });
                html += "</ul>  \n            " + (optionCnt > 5 ? "<button class=\"adv-search__btn--more\">\uB354\uBCF4\uAE30<i class=\"ico-adv-arr-down lp__sprite\"></i></button>\n                        <button class=\"adv-search__btn--close\">\uB2EB\uAE30<i class=\"ico-adv-arr-up lp__sprite\"></i></button>\n                " : "");
            } else {
                html += "<div class=\"pricecomp__head\">\n                        <div class=\"sort_block\">\n                            <div class=\"sort_first\">\n                                <label class=\"tx_tit\">\n                                    <input type=\"radio\" name=\"pricecomp_sort_list_type1\" data-sort=\"price\" " + (param.unit !== "Y" ? "checked" : "") + ">\n                                    <span class=\"sort_name\">\uCD5C\uC800\uAC00\uC21C</span>\n                                </label>\n                                " + (optionUnitType ? "<label class=\"tx_tit\">\n                                    <input type=\"radio\" name=\"pricecomp_sort_list_type1\" data-sort=\"unit\" " + (param.unit === "Y" ? "checked" : "") + ">\n                                    <span class=\"sort_name\">\uB2E8\uC704\uB2F9 \uD658\uC0B0\uAC00\uC21C</span>\n                                </label>" : "") + "\n                            </div>\n                            <div class=\"sort_chk\">\n                                <div>\n                                    <input type=\"checkbox\" id=\"deliveryInc\" class=\"input--checkbox-item\" data-sort=\"delivery\" " + (param.delivery === "Y" ? "checked" : "") + ">\n                                    <label for=\"deliveryInc\">\uBC30\uC1A1\uBE44 \uD3EC\uD568</label>\n                                </div>\n                            </div>                                           \n                        </div>\n                    </div>";
                html += "<ul class=\"compare_price__list border-box\">";
                $.each(optionList, function (index, listData) {
                    var unit_per_price = listData.unit_per_price;
                    var price = listData.price;
                    var price2 = listData.price2;
                    var delivery_text = listData.delivery_text;
                    var cash_check = listData.cash_check;
                    var mallcnt = listData.mallcnt;
                    var unit = listData.unit;
                    var rank = listData.rank;
                    var condiname = listData.condiname;
                    var modelno = listData.modelno;
                    var delivery_textView = "";
                    var priceView = price;

                    var rankcount = 0;
                    var condilogo = listData.condilogo;

                    if (gModelData.gModelno == modelno) {
                        optionSelIdx = index;
                    }
                    if ($.isNumeric(delivery_text)) {
                        delivery_textView = numComma(delivery_text) + "원";
                    } else {
                        delivery_textView = delivery_text;
                    }
                    if (param.delivery == "Y") {
                        priceView = price2;
                    } else {
                        priceView = price;
                    }
                    if (optionCnt == 3) rankcount = 1;else if (optionCnt > 3 && optionCnt < 8) rankcount = 2;else if (optionCnt >= 8) rankcount = 3;
                    html += "<li data-modelno=\"" + modelno + "\" data-name=\"" + condiname + "\" " + (index == 0 ? "class=\"is-on " + (param.unit == "" ? "is-low-price" : "is-low-per-price") + "\" " : "") + " >\n                            <a href=\"javascript:void(0);\" class=\"opt_link\">\n                                <span class=\"col col-1\">\n                                    <input type=\"radio\" id=\"radioOPTION" + index + "\" name=\"radioOPTION\" class=\"input--radio-item\">\n                                    " + (condilogo != "" ? "\n                                        <label for=\"radioOPTION" + index + "\" class=\"tx--ad\">\n                                            <img src=\"" + condilogo + "\" alt=\"" + condiname + "\">\n                                            " + (rank > 0 && rank <= rankcount ? "<i class=\"badge badge--rank\">" + rank + "</i>" : "") + "\n                                        </label>" : "<label for=\"radioOPTION" + index + "\">\n                                            " + condiname + "\n                                            " + (rank > 0 && rank <= rankcount ? "<i class=\"badge badge--rank\">" + rank + "</i>" : "") + "\n                                        </label>") + "\n                                </span>\n                                <span class=\"col col-2\">\n                                    " + (index == 0 && param.delivery == "Y" && param.unit == "Y" ? "<span class=\"tx_low-price\">\uCD5C\uC800</span>" : "") + "\n                                    <span class=\"tx_unitprice\">" + (unit_per_price > 0 ? numComma(unit_per_price) + "\uC6D0/" + unit : "") + "</span>\n                                </span>\n                                <span class=\"col col-3\">\n                                    " + (cash_check > 0 ? "<i class=\"ico ico--cash\" title=\"\uD604\uAE08 \uCD5C\uC800\uAC00\"></i>" : "") + " \n                                    " + (index == 0 && param.delivery == "Y" && param.unit != "Y" ? "<span class=\"tx_low-price\">\uCD5C\uC800\uAC00</span>" : "") + "\n                                    <span class=\"tx_price\"><em>" + numComma(priceView) + "</em>\uC6D0</span>\n                                </span>\n                                <span class=\"col col-4\">\n                                    <span class=\"tx_cnt\"><em>" + numComma(mallcnt) + "</em>\uBAB0</span>\n                                </span>\n                            </a>\n                        </li>";
                });
                html += "</ul> \n            " + (optionCnt > 10 ? "<button class=\"adv-search__btn--more\">\uB354\uBCF4\uAE30<i class=\"ico-adv-arr-down lp__sprite\"></i></button>\n                                <button class=\"adv-search__btn--close\">\uB2EB\uAE30<i class=\"ico-adv-arr-up lp__sprite\"></i></button>\n            " : "");
            }

            $("#prod_option").html(html);

            // $("#prod_option").find(".pricecomp__list li[data-modelno="+gModelData.gModelno+"]").addClass("is-on");

            $("#prod_option").find(".pricecomp__list li[data-modelno=" + gModelData.gModelno + "] input:radio, .compare_price__list li[data-modelno=" + gModelData.gModelno + "] input:radio").prop("checked", true);
            $("#prod_option").show();
            if (!$("#prod_option").hasClass("is-unfold")) {
                if (optionViewType == "1" && optionCnt > 5) {
                    if (optionSelIdx >= 5) {
                        $("#prod_option").addClass("is-unfold");
                    }
                } else if (optionViewType == "2" && optionCnt > 10) {
                    if (optionSelIdx >= 10) {
                        $("#prod_option").addClass("is-unfold");
                    }
                }
            }
            //소팅
            $("#prod_option").find(".pricecomp__list.is-sort .col").unbind().click(function () {
                var optionObj = $("#prod_option").find(".pricecomp__list.is-col--1");
                var optionObjli = $("#prod_option").find(".pricecomp__list.is-col--1 li");
                var optionColClass = $(this).attr("class").replace("is-up", "").replace("is-down", "").trim();
                var optionAsc = $(this).data("sort");
                optionObjli.sort(function (a, b) {

                    var an = $(a).find(".opt_link span[class*='" + optionColClass + "']").data("value");
                    var bn = $(b).find(".opt_link span[class*='" + optionColClass + "']").data("value");
                    an = $.isNumeric(an) ? parseInt(an) : 0;
                    bn = $.isNumeric(bn) ? parseInt(bn) : 0;
                    if (an > bn) {
                        return optionAsc == "desc" ? -1 : 1;
                    }
                    if (an < bn) {
                        return optionAsc == "desc" ? 1 : -1;
                    }
                    return 0;
                });
                $(optionObj).html(optionObjli);

                $(this).siblings().removeClass("is-up");
                $(this).siblings().removeClass("is-down");

                if (optionAsc == "asc") {
                    $(this).removeClass("is-up");
                    $(this).addClass("is-down");
                } else {
                    $(this).removeClass("is-down");
                    $(this).addClass("is-up");
                }
                // $(optionObjli).find(".opt_link span").removeClass("is-on");
                // $(optionObjli).find(".opt_link span[class*='"+optionColClass+"']").addClass("is-on");
                optionAsc == "asc" ? $(this).data("sort", "desc") : $(this).data("sort", "asc");

                $("#prod_option").find(".pricecomp__list li, .compare_price__list li").unbind().click(function (e) {

                    var modelno = $(this).data("modelno");
                    var thisIndex = $(this).index();
                    if (modelno != gModelData.gModelno) {
                        if (optionViewType == "1") {
                            insertLogLSV(14497, "" + gModelData.gCategory, "" + gModelData.gModelno);
                        } else {
                            insertLogLSV(18630, "" + gModelData.gCategory, "" + gModelData.gModelno);
                        }
                        // $(this).siblings().removeClass("is-on");
                        // $(this).addClass("is-on");
                        $(this).find("input:radio").prop("checked", true);

                        //top 세팅
                        var list = document.querySelector('#prod_option_top .buyopt__list');

                        [].concat(_toConsumableArray(list.children)).sort(function (a, b) {
                            return $(a).data("rank") > $(b).data("rank") ? 1 : -1;
                        }).forEach(function (node) {
                            return list.appendChild(node);
                        });

                        $("#prod_option_top").find(".buyopt__list li[data-modelno=" + modelno + "] input:radio").prop("checked", true);
                        if (!$("#prod_option_top").find(".buyoption").hasClass("is-unfold")) {
                            if (thisIndex > 3) {
                                $($("#prod_option_top").find(".buyoption li")[2]).after($("#prod_option_top").find(".buyopt__list li[data-modelno=" + modelno + "]"));
                            }
                        }

                        //fixtop 세팅
                        $("#prod_topfix").find(".prodtabinfo .select-box__list li").removeClass("is--selected");
                        $("#prod_topfix").find(".prodtabinfo .select-box__list li[data-modelno=" + modelno + "]").addClass("is--selected");
                        $("#prod_topfix").find(".prodtabinfo .select-box--selected #changeOpt").html($(this).data("name"));
                        var price = parseInt($("#detail_minprice").text().replace(/,/g, ''), 10);
                        var limitNum = $("#prod_topfix").find(".prodtabinfo .select-box__list li[data-modelno=" + modelno + "]").data("val-price");
                        $({ countNum: price }).stop(true, true).animate({ countNum: limitNum }, {
                            duration: 400,
                            easing: 'linear',
                            step: function step() {
                                $("#detail_minprice").text(numComma(Math.floor(this.countNum)));
                            },
                            complete: function complete() {
                                $("#detail_minprice").text(numComma(Math.floor(this.countNum)));
                            }
                        });
                    }
                    e.preventDefault();
                });
            });
            $(".pricecomp .adv-search__btn--more").on("click", function () {
                $(this).closest(".pricecomp").addClass("is-unfold");
            });
            $(".pricecomp .adv-search__btn--close").on("click", function () {
                $(this).closest(".pricecomp").removeClass("is-unfold");
            });
            $("#prod_option").find("input").on("click", function () {
                var chkDelivery = "";
                var chkUnit = "";
                paramHandler.set("callcnt", 1);
                if ($(this).data("sort") === "delivery") {
                    //1단토글insertLog(14492);
                    insertLogLSV(26899, "" + gModelData.gCategory, "" + gModelData.gModelno);

                    if ($(this).prop("checked")) {
                        chkDelivery = "Y";
                    } else {
                        chkDelivery = "N";
                    }

                    paramHandler.set("delivery", chkDelivery);
                    prodPriceComp.paramHandler.set("delivery", chkDelivery);
                    prodShopPrice.paramHandler.set("delivery", chkDelivery);
                } else {
                    if ($(this).data("sort") === "unit") {
                        insertLogLSV(26278, "" + gModelData.gCategory, "" + gModelData.gModelno);
                        chkUnit = "Y";
                    } else {
                        insertLogLSV(26277, "" + gModelData.gCategory, "" + gModelData.gModelno);
                        chkUnit = "N";
                    }

                    paramHandler.set("unit", chkUnit);
                }
            });
            $("#prod_option").find(".pricecomp__list li, .compare_price__list li").unbind().click(function (e) {

                var modelno = $(this).data("modelno");
                var thisIndex = $(this).index();

                if (modelno != gModelData.gModelno) {
                    //$(this).siblings().removeClass("is-on");
                    //$(this).addClass("is-on");
                    $(this).find("input:radio").prop("checked", true);
                    if (optionViewType == "1") {
                        insertLog(14497);
                    } else {
                        insertLog(18630);
                    }
                    //top 세팅
                    var list = document.querySelector('#prod_option_top .buyopt__list');

                    [].concat(_toConsumableArray(list.children)).sort(function (a, b) {
                        return $(a).data("rank") > $(b).data("rank") ? 1 : -1;
                    }).forEach(function (node) {
                        return list.appendChild(node);
                    });
                    $("#prod_option_top").find(".buyopt__list li[data-modelno=" + modelno + "] input:radio").prop("checked", true);
                    if (!$("#prod_option_top").find(".buyoption").hasClass("is-unfold")) {
                        if (thisIndex > 3) {
                            $($("#prod_option_top").find(".buyoption li")[2]).after($("#prod_option_top").find(".buyopt__list li[data-modelno=" + modelno + "]"));
                        }
                    }
                    $("#prod_option_top").find(".btn.btn__toggle").off().on("click", function () {
                        if (thisIndex > 3) {
                            if (!$("#prod_option_top").find(".buyoption").hasClass("is-unfold")) {
                                $($("#prod_option_top").find(".buyoption li")[thisIndex]).after($("#prod_option_top").find(".buyopt__list li[data-modelno=" + modelno + "]"));
                            } else {
                                $($("#prod_option_top").find(".buyoption li")[2]).after($("#prod_option_top").find(".buyopt__list li[data-modelno=" + modelno + "]"));
                            }
                        }
                        $(this).closest('.buyoption').toggleClass('is-unfold');
                    });
                    //fixtop 세팅
                    $("#prod_topfix").find(".prodtabinfo .select-box__list li").removeClass("is--selected");
                    $("#prod_topfix").find(".prodtabinfo .select-box__list li[data-modelno=" + modelno + "]").addClass("is--selected");
                    $("#prod_topfix").find(".prodtabinfo .select-box--selected #changeOpt").html($(this).data("name"));
                    var price = parseInt($("#detail_minprice").text().replace(/,/g, ''), 10);
                    var limitNum = $("#prod_topfix").find(".prodtabinfo .select-box__list li[data-modelno=" + modelno + "]").data("val-price");
                    $({ countNum: price }).stop(true, true).animate({ countNum: limitNum }, {
                        duration: 400,
                        easing: 'linear',
                        step: function step() {
                            $("#detail_minprice").text(numComma(Math.floor(this.countNum)));
                        },
                        complete: function complete() {
                            $("#detail_minprice").text(numComma(Math.floor(this.countNum)));
                        }
                    });
                }
                e.preventDefault();
            });
        } else {
            $("#prod_option").hide();
        }
    };

    var numComma = function numComma(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    };
});