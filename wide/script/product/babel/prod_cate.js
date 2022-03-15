(function (global, factory) {
    if (typeof define === "function" && define.amd) {
        define(["exports"], factory);
    } else if (typeof exports !== "undefined") {
        factory(exports);
    } else {
        var mod = {
            exports: {}
        };
        factory(mod.exports);
        global.prod_cate = mod.exports;
    }
})(this, function (exports) {
    "use strict";

    Object.defineProperty(exports, "__esModule", {
        value: true
    });

    function _asyncToGenerator(fn) {
        return function () {
            var gen = fn.apply(this, arguments);
            return new Promise(function (resolve, reject) {
                function step(key, arg) {
                    try {
                        var info = gen[key](arg);
                        var value = info.value;
                    } catch (error) {
                        reject(error);
                        return;
                    }

                    if (info.done) {
                        resolve(value);
                    } else {
                        return Promise.resolve(value).then(function (value) {
                            step("next", value);
                        }, function (err) {
                            step("throw", err);
                        });
                    }
                }

                return step("next");
            });
        };
    }

    var cosMap = new CustomMap();

    var catePromise = exports.catePromise = {
        param: {},
        cos: function cos() {
            var opt = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : "ALL_T";

            var _this = this;

            var cpids = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : "";
            var titletext = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : "";

            this.param = {
                modelno: gModelData.gModelno,
                cate: gModelData.gCategory,
                opt: opt,
                cpids: cpids,
                titletext: titletext
            };

            return new Promise(function (res, rej) {
                $.ajax({
                    type: "post",
                    url: "/wide/api/product/prodCosComponent.jsp",
                    data: _this.param,
                    dataType: "JSON",
                    success: function success(result) {
                        if (result.resultmsg == "success") res(result);
                    },
                    error: function error(err) {
                        rej(err);
                    }
                });
            });
        },
        mobile: function mobile() {
            var _this2 = this;

            this.param = {
                vipModelNo: gModelData.gModelno,
                deviceType: 1
            };

            return new Promise(function (res, rej) {
                $.ajax({
                    type: "get",
                    url: "/wide/api/product/prodSearchType.jsp",
                    data: _this2.param,
                    dataType: "JSON",
                    success: function success(result) {
                        if (result.total > 0) res(result.data);
                    },
                    error: function error(err) {
                        rej(err);
                    }
                });
            });
        },
        furniture: function furniture() {
            var _this3 = this;

            this.param = {
                modelno: gModelData.gModelno,
                cate: gModelData.gCategory
            };

            return new Promise(function (res, rej) {
                $.ajax({
                    type: "get",
                    url: "/wide/api/product/prodAttrGraph.jsp",
                    data: _this3.param,
                    dataType: "JSON",
                    success: function success(result) {
                        if (result.total > 0) res(result.data);
                    },
                    error: function error(err) {
                        rej(err);
                    }
                });
            });
        },
        caution: function caution() {
            var _this4 = this;

            this.param = {
                modelno: gModelData.gModelno,
                modelnm: gModelData.gModelNm,
                cate: gModelData.gCategory,
                factory: gModelData.gFactory,
                brand: gModelData.gBrand
            };

            return new Promise(function (res, rej) {
                $.ajax({
                    type: "get",
                    url: "/wide/api/product/prodCaution.jsp",
                    data: _this4.param,
                    dataType: "JSON",
                    success: function success(result) {
                        if (result.total > 0) res(result.data);
                    },
                    error: function error(err) {
                        rej(err);
                    }
                });
            });
        }
    };

    var prodCateView = exports.prodCateView = {
        cos: function () {
            var _ref = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee(data) {
                return regeneratorRuntime.wrap(function _callee$(_context) {
                    while (1) {
                        switch (_context.prev = _context.next) {
                            case 0:
                                _context.next = 2;
                                return prodCateCosFunc.table(data);

                            case 2:
                                _context.next = 4;
                                return prodCateCosFunc.hover();

                            case 4:
                                _context.next = 6;
                                return prodCateCosFunc.moreView();

                            case 6:
                            case "end":
                                return _context.stop();
                        }
                    }
                }, _callee, this);
            }));

            function cos(_x4) {
                return _ref.apply(this, arguments);
            }

            return cos;
        }(),
        mobile: function mobile(data) {
            prodCateMobileFunc(data);
        },
        furniture: function furniture(data) {
            prodCateFurnitureFunc(data);
        },
        caution: function () {
            var _ref2 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee2(data) {
                return regeneratorRuntime.wrap(function _callee2$(_context2) {
                    while (1) {
                        switch (_context2.prev = _context2.next) {
                            case 0:
                                prodCateCautionFunc(data);

                            case 1:
                            case "end":
                                return _context2.stop();
                        }
                    }
                }, _callee2, this);
            }));

            function caution(_x5) {
                return _ref2.apply(this, arguments);
            }

            return caution;
        }()
    };

    var prodCateCosFunc = {
        table: function () {
            var _ref3 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee3(data) {
                var tableHtml, compData, allIngredients, goodenssFit, mainIngredients;
                return regeneratorRuntime.wrap(function _callee3$(_context3) {
                    while (1) {
                        switch (_context3.prev = _context3.next) {
                            case 0:
                                tableHtml = "";
                                compData = data.all_component_data;
                                allIngredients = compData[0].all_component; //전성분

                                goodenssFit = compData[1].goodness_type; //피부타입별 적합도

                                mainIngredients = compData[2].component_items; //좋은성분, 주의성분

                                if (!(allIngredients.length == 0)) {
                                    _context3.next = 9;
                                    break;
                                }

                                return _context3.abrupt("return");

                            case 9:
                                tableHtml += "<tr>\n                            <td>\n                                <ul class=\"graph__list graph--type1\">";
                                goodenssFit.forEach(function (v) {
                                    tableHtml += "<li data-layer=\"" + (v.cpt_goodness_round_percent > 0 ? "on" : "") + "\" data-cptid=" + v.cpt_id + " data-cpids=" + v.cp_ids + " data-title=" + v.cpt_group_name + ">\n                                                        <i class=\"ico p" + v.cpt_goodness_round_percent + "\">" + v.cpt_goodness_round_percent + "%</i>\n                                                        <em class=\"tx_type\">" + v.cpt_group_name + "</em>\n                                                    </li>";
                                });
                                tableHtml += "</ul>\n                                <div class=\"lay-cosmetic lay-comm\">\n                                </div>\n                            </td>\n                            <td>\n                                <ul class=\"graph__list graph--type2\">";
                                mainIngredients.forEach(function (v) {
                                    var cpt_name = v.cpt_name.indexOf("피부") > -1 ? v.cpt_name : "\uD53C\uBD80" + v.cpt_name;

                                    if (v.cpt_harmflag == "0") {
                                        tableHtml += "<li data-layer=\"" + (v.cpt_cnt > 0 ? "on" : "") + "\" data-cptid=" + v.cpt_id + " data-cpids=" + v.cp_ids + " data-title=" + cpt_name + ">\n                                                        <i class=\"ico " + (v.cpt_cnt > 0 ? "is-on" : "") + "\">" + v.cpt_cnt + "</i>\n                                                        <em class=\"tx_type\">" + cpt_name + "</em>\n                                                    </li>";
                                    }
                                });
                                tableHtml += "</ul>\n                                <div class=\"lay-cosmetic lay-comm\">\n                                </div>\n                            </td>\n                            <td>\n                                <ul class=\"graph__list graph--type3\">";
                                mainIngredients.forEach(function (v) {
                                    if (v.cpt_harmflag == "1") {
                                        tableHtml += "<li data-layer=\"" + (v.cpt_cnt > 0 ? "on" : "") + "\" data-cptid=" + v.cpt_id + " data-cpids=" + v.cp_ids + " data-title=" + v.cpt_name + ">\n                                                            <i class=\"ico " + (v.cpt_cnt > 0 ? "is-on" : "") + "\">" + v.cpt_cnt + "</i>\n                                                            <em class=\"tx_type\">" + v.cpt_name + "</em>\n                                                        </li>";
                                    }
                                });
                                tableHtml += "</ul>\n                                <div class=\"lay-cosmetic lay-comm\">\n                                </div>\n                            </td>\n                            <td>\n                                <div class=\"cosmetic__info\">\n                                    <p class=\"tx_detail\">" + allIngredients + "</p>\n                                    <button type=\"button\" class=\"btn btn__more\">\uC804\uC131\uBD84 " + compData[0].total_cnt + "\uAC1C \uB354\uBCF4\uAE30</button><!-- \uB808\uC774\uC5B4 \uC788\uB294 \uC131\uBD84 -->\n                                    <!-- \uC804\uC131\uBD84 \uB808\uC774\uC5B4 -->\n                                    <div class=\"lay-cosmetic lay-cosmetic--wide lay-comm\">\n                                    </div>\n                                </div>\n                            </td>\n                        </tr>";

                                $('#cosComponent .tb__cosmetic tbody').html(tableHtml);
                                $('#cosComponent').show();

                            case 18:
                            case "end":
                                return _context3.stop();
                        }
                    }
                }, _callee3, this);
            }));

            function table(_x6) {
                return _ref3.apply(this, arguments);
            }

            return table;
        }(),
        hover: function () {
            var _ref4 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee5() {
                var hasLayer;
                return regeneratorRuntime.wrap(function _callee5$(_context5) {
                    while (1) {
                        switch (_context5.prev = _context5.next) {
                            case 0:
                                hasLayer = $("#cosComponent .tb__cosmetic .graph__list > li");

                                if (!(hasLayer.length == 0)) {
                                    _context5.next = 5;
                                    break;
                                }

                                return _context5.abrupt("return");

                            case 5:
                                $(hasLayer).hover(_asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee4() {
                                    var layerState, cptId, cpIds, title;
                                    return regeneratorRuntime.wrap(function _callee4$(_context4) {
                                        while (1) {
                                            switch (_context4.prev = _context4.next) {
                                                case 0:
                                                    layerState = $(this).data("layer");
                                                    cptId = $(this).data("cptid");
                                                    cpIds = $(this).data("cpids");
                                                    title = $(this).data("title");


                                                    $("#cosComponent .lay-cosmetic").removeClass("is-shown");

                                                    if (!(layerState === "on")) {
                                                        _context4.next = 9;
                                                        break;
                                                    }

                                                    _context4.next = 8;
                                                    return prodCateCosFunc.hoverLayer($(this), cptId, cpIds, title);

                                                case 8:
                                                    $(this).closest("td").find(".lay-cosmetic").addClass("is-shown");

                                                case 9:
                                                case "end":
                                                    return _context4.stop();
                                            }
                                        }
                                    }, _callee4, this);
                                })), function () {
                                    $(this).closest("td").find(".lay-cosmetic").removeClass("is-shown");
                                });

                            case 6:
                            case "end":
                                return _context5.stop();
                        }
                    }
                }, _callee5, this);
            }));

            function hover() {
                return _ref4.apply(this, arguments);
            }

            return hover;
        }(),
        hoverLayer: function () {
            var _ref6 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee6($this, cptId, cpIds, title) {
                var data, layerHtml, layerTitle;
                return regeneratorRuntime.wrap(function _callee6$(_context6) {
                    while (1) {
                        switch (_context6.prev = _context6.next) {
                            case 0:
                                data = null;
                                layerHtml = "";
                                layerTitle = "";

                                if (cosMap.containsKey(cptId)) {
                                    _context6.next = 8;
                                    break;
                                }

                                _context6.next = 6;
                                return catePromise.cos("4", cpIds, title);

                            case 6:
                                data = _context6.sent;

                                cosMap.put(cptId, data);

                            case 8:

                                if ($this.parent().hasClass("graph--type1")) {
                                    insertLog(14488);
                                    layerTitle = $this.find('em').text() + "\uC5D0 \uC88B\uC740 \uC131\uBD84 " + cosMap.get(cptId).total_cnt + "\uAC1C";
                                } else if ($this.parent().hasClass("graph--type2")) {
                                    insertLog(14489);
                                    layerTitle = $this.find('em').text() + " \uC131\uBD84 " + cosMap.get(cptId).total_cnt + "\uAC1C";
                                } else if ($this.parent().hasClass("graph--type3")) {
                                    insertLog(14490);
                                    layerTitle = $this.find('em').text() + " \uC131\uBD84 " + cosMap.get(cptId).total_cnt + "\uAC1C";
                                }

                                layerHtml += "<div class=\"lay-comm--head\">\n                            <strong class=\"lay-comm__tit\">" + layerTitle + "</strong>\n                        </div>\n                        <div class=\"lay-comm--body\">\n                            <div class=\"lay-comm--inner\">\n                                <table class=\"lay-tb lay-tb--cosmetic\">\n                                    <colgroup>\n                                        <col width=\"50%\">\n                                        <col width=\"50%\">\n                                    </colgroup>\n                                    <thead>\n                                        <tr>\n                                            <th>\uC131\uBD84\uBA85</th>\n                                            <th>\uBC30\uD569\uBAA9\uC801</th>\n                                        </tr>\n                                    </thead>\n                                    <tbody>";
                                cosMap.get(cptId).component_list.forEach(function (v) {
                                    layerHtml += "<tr>\n                                                            <td>" + v.cp_name_kr + "</td>\n                                                            <td>" + v.cp_purpose + "</td>\n                                                        </tr>";
                                });
                                layerHtml += "</tbody>\n                                </table>\n                            </div>\n                        </div>";

                                $this.closest("td").find(".lay-cosmetic").html(layerHtml);

                            case 13:
                            case "end":
                                return _context6.stop();
                        }
                    }
                }, _callee6, this);
            }));

            function hoverLayer(_x7, _x8, _x9, _x10) {
                return _ref6.apply(this, arguments);
            }

            return hoverLayer;
        }(),
        moreView: function () {
            var _ref7 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee8() {
                var $button, cpIds;
                return regeneratorRuntime.wrap(function _callee8$(_context8) {
                    while (1) {
                        switch (_context8.prev = _context8.next) {
                            case 0:
                                $button = $(".tb__cosmetic .cosmetic__info .btn__more");
                                cpIds = $(".tb__cosmetic .cosmetic__info .tx_detail").text();

                                if (!($button.length == 0)) {
                                    _context8.next = 6;
                                    break;
                                }

                                return _context8.abrupt("return");

                            case 6:
                                $button.click(_asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee7() {
                                    var data, moreHtml;
                                    return regeneratorRuntime.wrap(function _callee7$(_context7) {
                                        while (1) {
                                            switch (_context7.prev = _context7.next) {
                                                case 0:
                                                    data = null;
                                                    moreHtml = "";

                                                    if (cosMap.containsKey("total")) {
                                                        _context7.next = 11;
                                                        break;
                                                    }

                                                    _context7.next = 5;
                                                    return catePromise.cos("6", cpIds);

                                                case 5:
                                                    data = _context7.sent;

                                                    cosMap.put("total", data);

                                                    moreHtml += "<div class=\"lay-comm--head\">\n                                    <strong class=\"lay-comm__tit\">\uC804\uC131\uBD84 " + cosMap.get("total").Allcomponent_list.length + "\uAC1C</strong>\n                                </div>\n                                <div class=\"lay-comm--body\">\n                                    <div class=\"lay-comm--inner\">\n                                        <table class=\"lay-tb lay-tb--cosmetic\">\n                                            <colgroup>\n                                                <col width=\"30%\">\n                                                <col width=\"50%\">\n                                                <col width=\"20%\">\n                                            </colgroup>\n                                            <thead>\n                                                <tr>\n                                                    <th>\uC131\uBD84\uBA85</th>\n                                                    <th>\uBC30\uD569 \uBAA9\uC801</th>\n                                                    <th>\uC131\uBD84 \uB0B4\uC6A9</th>\n                                                </tr>\n                                            </thead>\n                                            <tbody>";
                                                    cosMap.get("total").Allcomponent_list.forEach(function (v) {
                                                        var cpt_name = "";

                                                        switch (v.cpt_name) {
                                                            case "건성피부":
                                                                cpt_name = "피부건조";
                                                                break;
                                                            case "지성피부":
                                                                cpt_name = "지성좋음";
                                                                break;
                                                            case "민감성피부":
                                                                cpt_name = "민감성좋음";
                                                                break;
                                                            case "자극":
                                                                cpt_name = "피부자극";
                                                                break;
                                                            case "미백":
                                                                cpt_name = "피부미백";
                                                                break;
                                                            case "탄력":
                                                                cpt_name = "피부탄력";
                                                                break;
                                                            default:
                                                                cpt_name = v.cpt_name;
                                                                break;
                                                        }

                                                        moreHtml += "<tr>\n                                                                <td>" + v.cp_name_kr + "</td>\n                                                                <td>" + v.cp_purpose + "</td>\n                                                                <td class=\"" + (v.cpt_harmflag == "1" ? "tx_emp" : "") + "\">" + cpt_name + "</td>\n                                                            </tr>";
                                                    });
                                                    moreHtml += "</tbody>\n                                        </table>\n                                    </div>\n                                </div>\n                                <button class=\"lay-comm__btn--close comm__sprite\" onclick=\"$(this).parent().hide()\">\uB808\uC774\uC5B4 \uB2EB\uAE30</button>";

                                                    $(".tb__cosmetic .cosmetic__info .lay-cosmetic").html(moreHtml);

                                                case 11:

                                                    insertLog(14491);
                                                    $(this).siblings('.lay-cosmetic--wide').show();

                                                case 13:
                                                case "end":
                                                    return _context7.stop();
                                            }
                                        }
                                    }, _callee7, this);
                                })));

                            case 7:
                            case "end":
                                return _context8.stop();
                        }
                    }
                }, _callee8, this);
            }));

            function moreView() {
                return _ref7.apply(this, arguments);
            }

            return moreView;
        }()
    };

    function prodCateMobileFunc(data) {
        var opt1Arr = Object.keys(data.option1); //option1 그룹
        var opt2Arr = data.option2; //option2 array
        var tableHtml = "";
        var thisTab = "";

        //탭 순서 정렬
        if (gModelData.gCategory.substring(0, 4) == "0304") {
            opt1Arr.sort(function (a, b) {
                return parseInt(a.substring(0, a.indexOf("G"))) - parseInt(b.substring(0, b.indexOf("G")));
            });
        } else {
            opt1Arr.sort();
        }
        opt1Arr.forEach(function (v, i) {
            var tableObj = new Object();
            var idx1 = 0;

            tableHtml += "<li  data-tab=" + opt1Arr[i] + ">\n                        <button class=\"srp-type__tab\">" + opt1Arr[i] + "</button>\n                        <div class=\"srp-type__cont\">\n                            <dl class=\"srp-type__cond\">";
            while (idx1 < 3) {
                //가로 3칸 고정
                if (opt2Arr[idx1]) {
                    (function () {
                        var a = opt2Arr[idx1];
                        var tmpArray = new Array();
                        var idx2 = 0;

                        tableObj[a] = data.option1[v].filter(function (obj) {
                            return obj.OPTION_2 == a;
                        });

                        tmpArray = tableObj[a];

                        tableHtml += "<dt>" + a + "</dt>\n                                                    <dd>\n                                                        <table class=\"tb-conditon--type-c\">\n                                                            <tbody>";
                        while (idx2 < 4) {
                            //세로 4칸 고정
                            if (tmpArray[idx2]) {
                                var value = tmpArray[idx2];

                                if (gModelData.gModelno == value.MODELNO) thisTab = opt1Arr[i];

                                tableHtml += "<tr>\n                                                                                    <th>" + value.OPTION_3 + "</th>\n                                                                                    " + (value.MINPRICE3 == 0 ? "<td class = is--soldout>\uD488\uC808</td>" : "<td><a href=\"/detail.jsp?modelno=" + value.MODELNO + "\" onclick=\"insertLog(24451);\">\uCD5C\uC800\uAC00 <em>" + parseInt(value.MINPRICE3).format() + "</em>\uC6D0</a></td>") + "\n                                                                                </tr>";
                            } else {
                                tableHtml += "<tr class=\"is--empty\"><th></th><td></td></tr>";
                            }
                            ++idx2;
                        }
                        tableHtml += "</tbody>\n                                                        </table>\n                                                    </dd>";
                    })();
                } else {
                    tableHtml += "<dt class=\"is--blank\"></dt><dd class=\"is--blank\"></dd>";
                }
                ++idx1;
            }
            tableHtml += "</dl>\n                        </div>\n                    </li>";
        });

        $('.srp-type--c ul').html(tableHtml);
        $(".srp-type--c [data-tab=\"" + thisTab + "\"]").addClass('is--on');
        $('.srp-type--c').show();

        $(".srp-type__list .srp-type__tab").click(function () {
            var $pa = $(this).parent();
            $pa.addClass("is--on").siblings().removeClass("is--on");
        });
    }

    function prodCateFurnitureFunc(data) {
        var tableHtml = "";
        var title_1 = "자재등급";
        var class_1 = "level_0";
        var attrId_1 = 0;
        var title_2 = "";
        var class_2 = "level_00";
        var attrId_2 = 0;

        if (gModelData.gCategory.substring(0, 4) == "1201") {
            title_2 = "착석감";
        } else if (gModelData.gCategory.substring(0, 4) == "1202") {
            title_2 = "쿠션감";
        }

        data.list.forEach(function (v) {
            switch (v.attribute_id) {
                case 123660:
                case 133553:
                    title_1 = "자재등급";
                    class_1 = "level_" + v.attribute_element.toLowerCase();
                    attrId_1 = v.attribute_id;
                    break;
                case 211331:
                    title_2 = "착석감";
                    class_2 = "level_0" + v.attribute_element_id;
                    attrId_2 = v.attribute_id;
                    break;
                case 205023:
                    var attribute_element_id = "";

                    switch (v.attribute_element_id) {
                        case 5:
                            attribute_element_id = 1;
                            break;
                        case 6:
                            attribute_element_id = 2;
                            break;
                        case 2:
                            attribute_element_id = 3;
                            break;
                        case 3:
                            attribute_element_id = 4;
                            break;
                        case 7:
                            attribute_element_id = 5;
                            break;
                        default:
                            break;
                    }

                    title_2 = "쿠션감";
                    class_2 = "level_0" + attribute_element_id;
                    attrId_2 = v.attribute_id;
                    break;
                default:
                    break;
            }
        });

        tableHtml += "<table class=\"tb__fungrade\">\n                    <colgroup>\n                        <col width=\"25%\">\n                        <col width=\"25%\">\n                    </colgroup>\n                    <thead>\n                        <tr>\n                            <th>" + title_1 + " <button type=\"button\" class=\"ico ico--question\" onclick=\"showDicLayer(this);\" data-attr_id=\"" + attrId_1 + "\" data-attr_el_id=\"0\">?</button> <p class=\"tx_sub\">\uC720\uD574\uBB3C\uC9C8 \uD3EC\uB984\uC54C\uB370\uD788\uB4DC \uBC29\uCD9C\uB7C9\uC5D0 \uB530\uB978 \uB4F1\uAE09\uBD84\uB958</p></th>\n                            <th>" + title_2 + " <button type=\"button\" class=\"ico ico--question\" onclick=\"showDicLayer(this);\" data-attr_id=\"" + attrId_2 + "\" data-attr_el_id=\"0\">?</button> <p class=\"tx_sub\">\uD479\uC2E0\uD568\uC758 \uAC15\uB3C4\uB97C \uB098\uD0C0\uB0B4\uBA70, 1\uC774 \uAC00\uC7A5 \uD479\uC2E0\uD558\uACE0 5\uAC00 \uAC00\uC7A5 \uB2E8\uB2E8\uD569\uB2C8\uB2E4.</p></th>\n                        </tr>\n                    </thead>\n                    <tbody>\n                        <tr>\n                            <td>\n                                <div class=\"grade_level " + class_1 + "\">\n                                </div>\n                            </td>\n                            <td>\n                                <div class=\"grade_level " + class_2 + "\"></div>\n                            </td>\n                        </tr>\n                    </tbody>\n                </table>";

        $('.row__fungrade .inner').html(tableHtml);
        $('.row__fungrade').show();
    }

    function prodCateCautionFunc(data) {
        data.forEach(function (v) {
            if (v.view_type == "1") {
                var contentHtml = "";

                // if (title_type == 1){
                //     html += "<span class=\"tit\"><strong>" + title + "</strong><span class=\"speaker\"></span></span>";
                // }else{
                //     html += "<span class=\"tit\"><strong>특가/이벤트</strong><span class=\"speaker\"></span></span>";
                // } 

                if (v.content_type == "1") {
                    contentHtml = "<div class=\"inner\">";
                    if (v.content_list.length > 0) {
                        v.content_list.forEach(function (a) {
                            contentHtml += a.content + "<br>";
                        });
                    }
                    contentHtml += "</div>";
                } else if (v.content_type == "2") {
                    contentHtml = "<div class=\"inner\">\n                <img src=\"http://storage.enuri.info/pic_upload/caution/" + v.img + "\" usemap=\"#Map\">";
                    if (v.imgmap_list.length > 0) {
                        contentHtml += "<map name=\"Map\">";
                        v.imgmap_list.forEach(function (v) {
                            contentHtml += "<area shape=\"rect\" coords=\"" + v.img_map + "\" href=\"" + v.map_url + "\" target=\"_blank\">";
                        });
                        contentHtml += "</map>";
                    }
                    contentHtml += "</div>";

                    $('#caution1').addClass('is-thum');
                }

                $('#caution1').html(contentHtml);
                $('#caution1').show();
            } else if (v.view_type == "2") {
                var _contentHtml = "";

                // if (title_type == 1){
                //     html += "<p class=\"tit\"><strong>" + title + "</strong></p>";
                // }else{
                //     html += "<p class=\"tit\"><strong>주의사항</strong></p>";
                // }

                if (v.content_type == "1") {
                    _contentHtml = "<div class=\"inner\">";
                    if (v.content_list.length > 0) {
                        _contentHtml += "" + v.content_list[0].content;
                    }
                    _contentHtml += "</div>";
                } else if (v.content_type == "2") {
                    _contentHtml = "<div class=\"inner\">\n                <img src=\"http://storage.enuri.info/pic_upload/caution/" + v.img + "\" usemap=\"#Map\">";
                    if (v.imgmap_list.length > 0) {
                        _contentHtml += "<map name=\"Map\">";
                        v.imgmap_list.forEach(function (v) {
                            _contentHtml += "<area shape=\"rect\" coords=\"" + v.img_map + "\" href=\"" + v.map_url + "\" target=\"_blank\">";
                        });
                        _contentHtml += "</map>";
                    }
                    _contentHtml += "</div>";

                    $('.container__section .row__section.row__prodrelated').addClass('is-thum');
                }

                $('.container__section .row__section.row__prodrelated').html(_contentHtml).show();
            }
        });
    }
});