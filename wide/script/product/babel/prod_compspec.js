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
        global.prod_compspec = mod.exports;
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

    var specData = {
        specListTitle: null // 스펙
        , totalArray: null // 인기상품(전체)
        , newArray: null // 신상품
        , simArray: null // 비슷한 가격대
        , specExist: null //스펙값 존재 유무
        , originProd: null // 현재상품


        //스펙비교 data
    };var compspecPromise = function compspecPromise() {
        var type = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : "S";

        var param = {
            type: type,
            modelno: gModelData.gModelno
        };

        return new Promise(function (res, rej) {
            $.ajax({
                type: "get",
                url: "/wide/api/product/prodCompSpec.jsp",
                data: param,
                dataType: "JSON",
                success: function success(result) {
                    res(result);
                },
                error: function error(err) {
                    rej(err);
                }
            });
        });
    };

    var prodCompspecFunc = {
        list: function () {
            var _ref = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee() {
                var listHtml;
                return regeneratorRuntime.wrap(function _callee$(_context) {
                    while (1) {
                        switch (_context.prev = _context.next) {
                            case 0:
                                //스펙 리스트
                                listHtml = "";


                                listHtml += "<tr class=\"spec_info\">\n                        <td style=\"height: 226px;\">\uC0C1\uD488\uC815\uBCF4<em></em></td>\n                    </tr>\n                    <tr class=\"row_spec\">\n                        <td style=\"height: 19px;\">\uCD5C\uC800\uAC00</td>\n                    </tr>\n                    <tr class=\"row_spec\">\n                        <td style=\"height: 18px;\">\uC0C1\uD488\uB4F1\uB85D\uC77C</td>\n                    </tr>";
                                specData.specListTitle.forEach(function (v, i) {
                                    var specMain = i < 2 ? "spec_main" : "";
                                    listHtml += "<tr class=\"row_spec " + specMain + "\" gp_no=\"" + v.gp_no + "\">\n                            <td style=\"height: 18px;\">" + v.title + "</td>\n                        </tr>";
                                });

                                $('#prodSpecComparison .comp_item .tb_compspec > tbody').html(listHtml);

                            case 4:
                            case "end":
                                return _context.stop();
                        }
                    }
                }, _callee, this);
            }));

            function list() {
                return _ref.apply(this, arguments);
            }

            return list;
        }(),
        originProd: function () {
            var _ref2 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee2() {
                var obj, dateArr, yyyy, mm, specList, originProdHtml, img;
                return regeneratorRuntime.wrap(function _callee2$(_context2) {
                    while (1) {
                        switch (_context2.prev = _context2.next) {
                            case 0:
                                //현재 모델
                                if (specData.originProd) {
                                    obj = specData.originProd;
                                    dateArr = obj.c_date.split("-");
                                    yyyy = dateArr[0];
                                    mm = dateArr[1];
                                    specList = obj.specList;
                                    originProdHtml = "";
                                    img = "";


                                    if (obj.origin_img.length > 0) {
                                        img = obj.origin_img;
                                    } else if (obj.p_imgurl.length > 0) {
                                        img = obj.p_imgurl;
                                    } else if (obj.p_imgurl2.length > 0) {
                                        img = obj.p_imgurl2;
                                    }

                                    originProdHtml += "<table class=\"tb_compspec\">\n                                    <tbody>\n                                        <tr>\n                                            <td class=\"spec_info\" style=\"height: 226px;\">\n                                                <p class=\"tag__prod\">\uD604\uC7AC\uC0C1\uD488</p>\n                                                <a href=\"#\" class=\"thum__link\">\n                                                    <ul class=\"tag_list\">\n                                                        " + (obj.best_flag == "Y" ? "<li><i class=\"ico_cos\">\uAC00\uC131\uBE44</i></li>" : "") + "\n                                                        " + (obj.most_flag == "Y" ? "<li><i class=\"ico_alo\">\uB9CE\uC774\uAD6C\uB9E4</i></li>" : "") + "\n                                                        " + (obj.new_flag == "Y" ? "<li><i class=\"ico_new\">\uC2E0\uC81C\uD488</i></li>" : "") + "\n                                                    </ul>\n                                                    <img class=\"lazy\" data-original=\"" + img + "\" src=\"http://img.enuri.info/images/home/thum_none.jpg\" alt=\"\" onerror=\"this.src='http://img.enuri.info/images/home/thum_none.jpg'\">\n                                                </a>\n                                                <div class=\"scope\">";
                                    if (obj.bbs_num > 0) {
                                        originProdHtml += "                    <i class=\"ico ico--scope\">\n                                                            <span class=\"ico--scope-active\"><!--\uBCC4\uC810--></span>\n                                                        </i>\n                                                        <p class=\"tx_aval\">" + obj.bbs_point_avg + "</p>\n                                                        <p class=\"tx_cnt\">(" + obj.bbs_num.format() + ")</p>";
                                    }
                                    originProdHtml += "                </div>\n                                                <span class=\"info\">\n                                                    <a href=\"#\" class=\"tx_name\">" + obj.modelnm + "</a>\n                                                </span>\n                                            </td>\n                                        </tr>\n                                        <tr class=\"row_spec\">\n                                            <td style=\"height: 19px;\">\n                                                <span class=\"tx_spec_desc ty_price\"><em>" + obj.minprice3.format() + "</em>\uC6D0</span>\n                                            </td>\n                                        </tr>\n                                        <tr class=\"row_spec\">\n                                            <td style=\"height: 18px;\">\n                                                <span class=\"tx_spec_desc\">" + yyyy + "." + mm + "</span>\n                                            </td>\n                                        </tr>";
                                    specData.specListTitle.forEach(function (b, a) {
                                        var gp_no = b.gp_no.toString();
                                        var specMain = a < 2 ? "spec_main" : "";
                                        var gpArr = new Array();
                                        var title = "";

                                        if (specList[gp_no]) gpArr = specList[gp_no];
                                        specData.specExist[gp_no] = "N";

                                        originProdHtml += "        <tr class=\"row_spec " + specMain + "\" gp_no=\"" + gp_no + "\">\n                                                <td style=\"height: 18px;\">";
                                        if (gpArr.length > 0) {
                                            for (var c = 0; c < gpArr.length; c++) {
                                                specData.specExist[gp_no] = "Y";
                                                if (gpArr[c].spec_title == "부가기능" && gpArr[c].title_group.length > 0) {
                                                    title = gpArr[c].title_group + "(" + gpArr[c].title + ")";;
                                                } else {
                                                    title = gpArr[c].title;
                                                }
                                                originProdHtml += "        <span class=\"tx_spec_desc\">" + title + "</span>";
                                            }
                                        } else {
                                            originProdHtml += "        <span class=\"tx_spec_desc\">-</span>";
                                        }
                                        originProdHtml += "            </td>\n                                            </tr>";
                                    });
                                    originProdHtml += "    </tbody>\n                                </table>";

                                    $('#prodSpecComparison .comp_origin').html(originProdHtml);
                                    $('#prodSpecComparison .comp_origin .spec_info img.lazy').lazyload({
                                        placeholder: 'http://img.enuri.info/images/home/thum_none.jpg',
                                        effect: 'fadeIn',
                                        effectTime: 2000,
                                        threshold: 800
                                    });
                                }

                            case 1:
                            case "end":
                                return _context2.stop();
                        }
                    }
                }, _callee2, this);
            }));

            function originProd() {
                return _ref2.apply(this, arguments);
            }

            return originProd;
        }(),
        compProds: function () {
            var _ref3 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee3() {
                var arr = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : specData.totalArray;
                var pageGap, page, compProdHtml, index, compArray;
                return regeneratorRuntime.wrap(function _callee3$(_context3) {
                    while (1) {
                        switch (_context3.prev = _context3.next) {
                            case 0:
                                //스펙비교 모델
                                pageGap = 4;
                                page = 1;
                                compProdHtml = "";
                                index = 0;
                                compArray = new Array();


                                if (arr.length > 0) {
                                    compArray = arr.sort(function (a, b) {
                                        // 오름차순 정렬
                                        return b['badge_cnt'] - a['badge_cnt'];
                                    });
                                }

                                compArray.forEach(function (v) {
                                    var specList = v.specList;
                                    var dateArr = v.c_date.split("-");
                                    var yyyy = dateArr[0];
                                    var mm = dateArr[1];
                                    var img = "";

                                    if (v.origin_img.length > 0) {
                                        img = v.origin_img;
                                    } else if (v.p_imgurl.length > 0) {
                                        img = v.p_imgurl;
                                    } else if (v.p_imgurl2.length > 0) {
                                        img = v.p_imgurl2;
                                    }

                                    if (v.modelno == gModelData.gModelno) return true;

                                    compProdHtml += "<li data-group=\"" + (parseInt(index / pageGap) + 1) + "\">\n                                <table class=\"tb_compspec\">\n                                    <tbody>\n                                        <tr>\n                                            <td class=\"spec_info\" style=\"height: 221px;\">\n                                                <a href=\"/detail.jsp?modelno=" + v.modelno + "\" class=\"thum__link\" onclick=\"insertLogCate(23350, " + gModelData.gCate4 + ");\">\n                                                    <ul class=\"tag_list\">\n                                                        " + (v.best_flag == "Y" ? "<li><i class=\"ico_cos\">\uAC00\uC131\uBE44</i></li>" : "") + "\n                                                        " + (v.most_flag == "Y" ? "<li><i class=\"ico_alo\">\uB9CE\uC774\uAD6C\uB9E4</i></li>" : "") + "\n                                                        " + (v.new_flag == "Y" ? "<li><i class=\"ico_new\">\uC2E0\uC81C\uD488</i></li>" : "") + "\n                                                    </ul>\n                                                    <img class=\"lazy\" data-original=\"" + img + "\" src=\"http://img.enuri.info/images/home/thum_none.jpg\" alt=\"\" onerror=\"this.src='http://img.enuri.info/images/home/thum_none.jpg'\">\n                                                </a>\n                                                <div class=\"scope\">\n                                                    <i class=\"ico ico--scope\">\n                                                        <span class=\"ico--scope-active\"><!--\uBCC4\uC810--></span>\n                                                    </i>\n                                                    <p class=\"tx_aval\">" + v.bbs_point_avg + "</p>\n                                                    <p class=\"tx_cnt\">(" + v.bbs_num.format() + ")</p>\n                                                </div>\n                                                <span class=\"info\">\n                                                    <a href=\"/detail.jsp?modelno=" + v.modelno + "\" class=\"tx_name\" onclick=\"insertLogCate(23350, " + gModelData.gCate4 + ");\">" + v.modelnm + "</a>\n                                                </span>\n                                            </td>\n                                        </tr>\n                                        <tr class=\"row_spec\">\n                                            <td style=\"height: 19px;\">\n                                                <span class=\"tx_spec_desc ty_price\"><em>" + v.minprice3.format() + "</em>\uC6D0</span>\n                                            </td>\n                                        </tr>\n                                        <tr class=\"row_spec\">\n                                            <td style=\"height: 18px;\">\n                                                <span class=\"tx_spec_desc\">" + yyyy + "." + mm + "</span>\n                                            </td>\n                                        </tr>";
                                    specData.specListTitle.forEach(function (b, a) {
                                        var gp_no = b.gp_no.toString();
                                        var gpArr = new Array();
                                        var title = "";
                                        var specMain = a < 2 ? "spec_main" : "";

                                        if (specList[gp_no]) gpArr = specList[gp_no];
                                        if (gpArr.length > 0) title = gpArr[0].title;

                                        compProdHtml += "        <tr class=\"row_spec " + specMain + "\" gp_no=\"" + gp_no + "\">\n                                            <td style=\"height: 18px;\">";
                                        if (gpArr.length > 0) {
                                            for (var c = 0; c < gpArr.length; c++) {
                                                if (gpArr[c].spec_title == "부가기능" && gpArr[c].title_group.length > 0) {
                                                    title = gpArr[c].title_group + "(" + gpArr[c].title + ")";
                                                } else {
                                                    title = gpArr[c].title;
                                                }
                                                compProdHtml += "<span class=\"tx_spec_desc\">" + title + "</span>";
                                            }

                                            if (arr == specData.totalArray && specData.specExist[gp_no] == "N") specData.specExist[gp_no] = "Y";
                                        } else {
                                            compProdHtml += "        <span class=\"tx_spec_desc\">-</span>";
                                        }
                                        compProdHtml += "            </td>\n                                        </tr>";
                                    });
                                    compProdHtml += "       </tbody>\n                                </table>\n                            </li>";
                                    index++;
                                });

                                $('#prodSpecComparison .comp_item .tb_compspec .spec_info > td > em').text("(" + index + ")"); //필터 별 모델 카운트
                                $('#prodSpecComparison .comp_prod .comp_prod_list').html(compProdHtml);
                                $('#prodSpecComparison .div_compspec').hide();
                                $('#prodSpecComparison .div_compspec').eq(0).show();
                                $('#prodSpecComparison .comp_prod .comp_prod_list .spec_info img.lazy').lazyload({
                                    placeholder: 'http://img.enuri.info/images/home/thum_none.jpg',
                                    effect: 'fadeIn',
                                    effectTime: 2000,
                                    threshold: 800
                                });

                                $("#prodSpecComparison .btn_comp.btn_comp_next, #prodSpecComparison .btn_comp.btn_comp_prev").unbind().click(function () {
                                    //next,prev 버튼
                                    var maxPage = Math.ceil(index / pageGap);

                                    $(this).siblings('ul').find("li[data-group=\"" + page + "\"]").hide();

                                    if ($(this).attr("class").indexOf("next") > 0) {
                                        if (page < maxPage) page++;
                                    } else {
                                        if (page > 1) page--;
                                    }

                                    $(this).siblings('ul').find("li[data-group=\"" + page + "\"]").show();
                                });

                                //스펙값 없으면 해당 스펙그룹 비노출
                                $.each(specData.specExist, function (c, d) {
                                    if (d === "N") $('tr[gp_no=' + c + ']').remove();
                                });

                                return _context3.abrupt("return", true);

                            case 15:
                            case "end":
                                return _context3.stop();
                        }
                    }
                }, _callee3, this);
            }));

            function compProds() {
                return _ref3.apply(this, arguments);
            }

            return compProds;
        }(),
        height: function () {
            var _ref4 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee4() {
                var $compItem, $row, $compProd;
                return regeneratorRuntime.wrap(function _callee4$(_context4) {
                    while (1) {
                        switch (_context4.prev = _context4.next) {
                            case 0:
                                //테이블 높이 조정
                                $compItem = $("#prodSpecComparison .comp_item tr"); // 구분 Table-row

                                $row = $("#prodSpecComparison .comp_origin tr"); // 선택상품 Table-row

                                $compProd = $("#prodSpecComparison .comp_prod > ul > li"); // 비교상품 Table

                                $row.each(function (e) {
                                    var tdH = $(this).find(">td").height();

                                    $compProd.each(function () {
                                        var cptdH = $(this).find("tr").eq(e).find(">td").height();
                                        if (tdH < cptdH) tdH = cptdH;
                                    });

                                    $(this).find(">td").height(tdH);

                                    $compProd.each(function () {
                                        $(this).find("tr").eq(e).find(">td").height(tdH);
                                        $compItem.eq(e).find(">td").height(tdH);
                                    });
                                });

                            case 4:
                            case "end":
                                return _context4.stop();
                        }
                    }
                }, _callee4, this);
            }));

            function height() {
                return _ref4.apply(this, arguments);
            }

            return height;
        }(),
        event: function () {
            var _ref5 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee5() {
                var $compspec_tab, $compspec_sort, $simBtn, $newBtn;
                return regeneratorRuntime.wrap(function _callee5$(_context5) {
                    while (1) {
                        switch (_context5.prev = _context5.next) {
                            case 0:
                                //클릭 이벤트
                                $compspec_tab = $('#prodSpecComparison .speccomp__sort > li'); //비교유형 버튼

                                $compspec_sort = $('#prodSpecComparison .speccomp__insort > li'); //필터 버튼

                                $simBtn = $compspec_sort.eq(1); //비슷한 가격대 버튼

                                $newBtn = $compspec_sort.eq(2); //신제품 버튼

                                $compspec_sort.show();
                                $compspec_sort.removeClass('is-on');
                                $compspec_sort.eq(0).addClass('is-on');

                                //버튼 미노출
                                if (specData.simArray == null || specData.simArray.length == 0) $simBtn.hide();
                                if (specData.newArray == null || specData.newArray.length == 0) $newBtn.hide();

                                $compspec_tab.unbind().click(function () {
                                    //탭 클릭
                                    var $type = $(this).data('type');
                                    var logArr = [23351, 23352, 23353];
                                    var idx = $(this).index();

                                    insertLog(logArr[idx]);
                                    prodCompspecViewTab($type);

                                    $compspec_tab.removeClass('is-on');
                                    $(this).addClass('is-on');
                                });

                                $compspec_sort.unbind().click(function () {
                                    //필터 클릭
                                    var $arr = $(this).data('arr');

                                    switch ($arr) {
                                        case "total":
                                            insertLog(23354);
                                            prodCompspecViewSort(specData.totalArray);
                                            break;
                                        case "sim":
                                            insertLog(23355);
                                            prodCompspecViewSort(specData.simArray);
                                            break;
                                        case "new":
                                            insertLog(23356);
                                            prodCompspecViewSort(specData.newArray);
                                            break;
                                        default:
                                            break;
                                    }

                                    $compspec_sort.removeClass('is-on');
                                    $(this).addClass('is-on');
                                });

                                $(".speccomp__sort li[data-type='S'] button").text(gModelData.gCate6Nm);
                                $(".speccomp__sort li[data-type='B'] button").text(gModelData.gBrand);
                                $(".speccomp__sort li[data-type='D'] button").text(gModelData.gCate8Nm);

                            case 14:
                            case "end":
                                return _context5.stop();
                        }
                    }
                }, _callee5, this);
            }));

            function event() {
                return _ref5.apply(this, arguments);
            }

            return event;
        }()

        //type 변경
    };
    var prodCompspecViewTab = exports.prodCompspecViewTab = function () {
        var _ref6 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee6() {
            var type = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : "S";
            var promiseData;
            return regeneratorRuntime.wrap(function _callee6$(_context6) {
                while (1) {
                    switch (_context6.prev = _context6.next) {
                        case 0:
                            _context6.next = 2;
                            return compspecPromise(type);

                        case 2:
                            promiseData = _context6.sent;


                            specData.totalArray = promiseData.totalArray;
                            specData.newArray = promiseData.newArray;
                            specData.simArray = promiseData.simArray;
                            specData.specListTitle = promiseData.specListTitle;
                            if (specData.totalArray.length > 0) specData.originProd = specData.totalArray[0];
                            specData.specExist = new Object();

                            if (!(promiseData.scate_cnt > 2 || promiseData.brnd_cnt > 2 || promiseData.dcate_cnt > 2)) {
                                _context6.next = 28;
                                break;
                            }

                            if (!(promiseData.scate_cnt < 3)) {
                                _context6.next = 15;
                                break;
                            }

                            $("#prodSpecComparison .speccomp__sort li[data-type='S']").remove();

                            if (!(type == "S")) {
                                _context6.next = 15;
                                break;
                            }

                            prodCompspecViewTab("B");
                            return _context6.abrupt("return");

                        case 15:
                            if (!(promiseData.brnd_cnt < 3)) {
                                _context6.next = 20;
                                break;
                            }

                            $("#prodSpecComparison .speccomp__sort li[data-type='B']").remove();

                            if (!(type == "B")) {
                                _context6.next = 20;
                                break;
                            }

                            prodCompspecViewTab("D");
                            return _context6.abrupt("return");

                        case 20:
                            if (!(promiseData.dcate_cnt < 3)) {
                                _context6.next = 24;
                                break;
                            }

                            $("#prodSpecComparison .speccomp__sort li[data-type='D']").remove();

                            if (!(type == "D")) {
                                _context6.next = 24;
                                break;
                            }

                            return _context6.abrupt("return");

                        case 24:
                            $('#tabSpec').show();
                            $('#prodSpecComparison').show();
                            _context6.next = 30;
                            break;

                        case 28:
                            $('#tabSpec').hide();
                            $('#prodSpecComparison').hide();

                        case 30:
                            _context6.next = 32;
                            return prodCompspecFunc.list();

                        case 32:
                            _context6.next = 34;
                            return prodCompspecFunc.originProd();

                        case 34:
                            _context6.next = 36;
                            return prodCompspecFunc.compProds();

                        case 36:
                            _context6.next = 38;
                            return prodCompspecFunc.height();

                        case 38:
                            _context6.next = 40;
                            return prodCompspecFunc.event();

                        case 40:
                        case "end":
                            return _context6.stop();
                    }
                }
            }, _callee6, this);
        }));

        return function prodCompspecViewTab() {
            return _ref6.apply(this, arguments);
        };
    }();

    var prodCompspecViewSort = exports.prodCompspecViewSort = function () {
        var _ref7 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee7() {
            var arr = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : specData.totalArray;
            return regeneratorRuntime.wrap(function _callee7$(_context7) {
                while (1) {
                    switch (_context7.prev = _context7.next) {
                        case 0:
                            _context7.next = 2;
                            return prodCompspecFunc.compProds(arr);

                        case 2:
                            _context7.next = 4;
                            return prodCompspecFunc.height();

                        case 4:
                        case "end":
                            return _context7.stop();
                    }
                }
            }, _callee7, this);
        }));

        return function prodCompspecViewSort() {
            return _ref7.apply(this, arguments);
        };
    }();
});