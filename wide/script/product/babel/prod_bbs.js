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
        global.prod_bbs = mod.exports;
    }
})(this, function (exports) {
    "use strict";

    Object.defineProperty(exports, "__esModule", {
        value: true
    });
    var bbsImageList = new Object();
    var minReviewCheck = 202106111600;
    var maxReviewCheck = 202106120400;
    var param = {
        pType: "GL",
        idx: 0,
        modelno: gModelData.gModelno,
        cate: gModelData.gCategory,
        point: 0,
        isphoto: "",
        shopcodes: "",
        word_code: "",
        page: 1,
        pagesize: 5
    };

    var paramHandler = exports.paramHandler = {
        set: function set(prop, value) {
            if (prop == "point") {
                param["word_code"] = "";
            } else if (prop != "page") {
                param["page"] = 1;
            }
            param[prop] = value;
            bbsPromise.bbsList().then(bbsListView).finally(function () {
                $(".reviewall__loader").css({ "position": "absolute" }).hide(); // 로더 숨김
                $(".reviewall__item").show(); // 로딩 후 상품평 목록 노출
            });
            return true;
        },
        get: function get(prop) {
            return param[prop];
        }
    };
    var bbsPromise = exports.bbsPromise = {
        chartParam: {},
        filterParam: {},
        topParam: {},
        imageParam: {},
        detailParam: {},
        shopParam: {},
        registParam: {},
        deleteParam: {},
        bbsTop: function bbsTop() {
            var _this = this;

            this.topParam = {
                pType: "GT",
                modelno: gModelData.gModelno
            };
            return new Promise(function (resolve, reject) {
                $.ajax({
                    type: "POST",
                    url: "/wide/api/product/prodBbsList.jsp",
                    data: _this.topParam,
                    dataType: "JSON",
                    success: function success(result) {
                        resolve(result);
                    },
                    error: function error(err) {
                        reject(err);
                    }
                });
            });
        },
        bbsChart: function bbsChart() {
            var _this2 = this;

            this.chartParam = {
                pType: "GB",
                modelno: gModelData.gModelno
            };

            return new Promise(function (resolve, reject) {
                $.ajax({
                    type: "POST",
                    url: "/wide/api/product/prodBbsList.jsp",
                    data: _this2.chartParam,
                    dataType: "JSON",
                    success: function success(result) {
                        resolve(result);
                    },
                    error: function error(err) {
                        reject(err);
                    }
                });
            });
        },
        bbsFilter: function bbsFilter() {
            var _this3 = this;

            this.filterParam = {
                modelno: gModelData.gModelno,
                cate: gModelData.gCategory
            };
            return new Promise(function (resolve, reject) {
                $.ajax({
                    type: "POST",
                    url: "/wide/api/product/prodCommentFilering.jsp",
                    data: _this3.filterParam,
                    dataType: "JSON",
                    success: function success(result) {
                        resolve(result);
                    },
                    error: function error(err) {
                        reject(err);
                    }
                });
            });
        },
        bbsList: function bbsList() {
            return new Promise(function (resolve, reject) {
                $.ajax({
                    type: "POST",
                    url: "/wide/api/product/prodBbsList.jsp",
                    data: param,
                    dataType: "JSON",
                    beforeSend: function beforeSend() {
                        $(".reviewall__loader").siblings().remove();
                        $(".reviewall__loader").css({ "position": "" }).show();
                    },
                    success: function success(result) {
                        resolve(result);
                    },
                    error: function error(err) {
                        reject(err);
                    }
                });
            });
        },
        bbsImageList: function bbsImageList() {
            var _this4 = this;

            this.imageParam = {
                pType: "PT",
                modelno: gModelData.gModelno
            };
            return new Promise(function (resolve, reject) {
                $.ajax({
                    type: "POST",
                    url: "/wide/api/product/prodBbsList.jsp",
                    data: _this4.imageParam,
                    dataType: "JSON",
                    success: function success(result) {
                        resolve(result);
                    },
                    error: function error(err) {
                        reject(err);
                    }
                });
            });
        },
        bbsDetail: function bbsDetail() {
            var _this5 = this;

            var idx = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : 0;
            var no = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 0;

            this.detailParam = {
                pType: "MD",
                modelno: gModelData.gModelno,
                idx: idx,
                no: no
            };
            return new Promise(function (resolve, reject) {
                $.ajax({
                    type: "POST",
                    url: "/wide/api/product/prodBbsList.jsp",
                    data: _this5.detailParam,
                    dataType: "JSON",
                    success: function success(result) {
                        resolve(result);
                    },
                    error: function error(err) {
                        reject(err);
                    }
                });
            });
        },
        bbsShopList: function bbsShopList() {
            var _this6 = this;

            this.shopParam = {
                pType: "SL",
                modelno: gModelData.gModelno
            };
            return new Promise(function (resolve, reject) {
                $.ajax({
                    type: "POST",
                    url: "/wide/api/product/prodBbsList.jsp",
                    data: _this6.shopParam,
                    dataType: "JSON",
                    success: function success(result) {
                        resolve(result);
                    },
                    error: function error(err) {
                        reject(err);
                    }
                });
            });
        },
        bbsRegist: function bbsRegist(text) {
            var _this7 = this;

            this.registParam = {
                pType: "GI",
                modelno: gModelData.gModelno,
                contents: text
            };
            return new Promise(function (resolve, reject) {
                $.ajax({
                    type: "POST",
                    url: "/wide/api/product/prodBbsList.jsp",
                    data: _this7.registParam,
                    dataType: "JSON",
                    success: function success(result) {
                        resolve(result);
                    },
                    error: function error(err) {
                        reject(err);
                    }
                });
            });
        },
        bbsDelete: function bbsDelete(modelno, no, delpass) {
            var _this8 = this;

            this.deleteParam = {
                pType: "GD",
                modelno: modelno,
                no: no,
                delpass: delpass
            };
            return new Promise(function (resolve, reject) {
                $.ajax({
                    type: "POST",
                    url: "/wide/api/product/prodBbsList.jsp",
                    data: _this8.deleteParam,
                    dataType: "JSON",
                    success: function success(result) {
                        resolve(result);
                    },
                    error: function error(err) {
                        reject(err);
                    }
                });
            });
        }
    };
    var bbsView = exports.bbsView = function bbsView() {
        bbsPromise.bbsChart().then(bbsChartView);
        if (blAdultCate && blAdult || !blAdultCate) {
            if (gModelData.gBbsNum > 0) {
                bbsPromise.bbsTop().then(bbsTopView);
                bbsPromise.bbsFilter().then(bbsFilterView);
                bbsPromise.bbsList().then(bbsListView).finally(function () {
                    $(".reviewall__loader").css({ "position": "absolute" }).fadeOut(); // 로더 숨김
                    $(".reviewall__item").show(); // 로딩 후 상품평 목록 노출
                });
                bbsPromise.bbsImageList().then(bbsImageListView);
                $("#prod_image_bbs").show();
            } else {
                $("#prod_bbs_top").find(".preview__cont .preview__list li.no-data").show();
                $("#prod_bbs").find(".reviewall__item.no-data").show();
            }
            $("#prod_bbs").show();
        } else {
            $("#prod_bbs_top").find(".preview__cont .preview__list li.no-adult").show();
            $("#prod_bbs_exception").show();
            $("#prod_image_bbs").hide();
            $("#prod_bbs").hide();
        }

        $("#prod_bbs").find(".reviewwrite .reviewwrite__cont .btn__register").unbind().click(function () {
            var insertFlag = true;
            var nowDate = new Date().format("yyyyMMddhhmm") * 1;
            if (!islogin()) {
                alert("로그인을 하시면 글을 작성할 수 있습니다.");
                return;
            } else if (nowDate >= minReviewCheck && nowDate <= maxReviewCheck) {
                // 상품평 작성 점검
                alert("2021-06-11 16:00 ~ 2021-06-12 04:00 까지 상품평 작성 점검중입니다. ");
                return;
            } else {
                var textObj = $("#prod_bbs").find(".reviewwrite .reviewwrite__cont textarea");
                var text = textObj.val();
                if (!insertFlag) {
                    alert("등록중입니다. 잠시만 기다려주세요.");
                    return;
                }

                if (text == "") {
                    alert("내용을 입력해 주세요.");
                    text.focus();
                    return;
                }
                if (text.length >= 2000) {
                    alert("2000자 이상은 입력 하실 수 없습니다.");
                    text.focus();
                    return;
                }

                if (text.length < 5) {
                    alert("5자 이상 내용을 입력하셔야 등록이 가능합니다.");
                    text.focus();
                    return;
                }

                bbsPromise.bbsRegist(text).then(function (result) {
                    if (result.success) {
                        if (result.data.flag) {
                            textObj.val("");
                            alert("정상적으로 저장 되었습니다.");

                            bbsPromise.bbsTop().then(bbsTopView);
                            bbsPromise.bbsList().then(bbsListView);

                            ++gModelData.gBbsNum;

                            $('#tabBbs .tab__link em').text("(" + gModelData.gBbsNum.format() + ")");
                            $('#prod_bbs_top .preview__tit span').text(gModelData.gBbsNum.format());
                        } else {
                            alert("저장 실패 하였습니다.");
                        }
                    }
                    insertFlag = false;
                });
            }
        });
    };
    var bbsTopView = function bbsTopView(json) {
        if (json.success && json.total > 0) {
            var bbsTopData = json.data;
            var html = "";
            if (bbsTopData.length > 0) {
                $.each(bbsTopData, function (index, listData) {
                    var imgsrv_flg = listData.imgsrv_flg;
                    var contents = listData.contents;
                    var imgurl_org = listData.imgurl_org;
                    var point = listData.point;
                    var modelno = listData.modelno;
                    var no = listData.no;
                    var regdate = listData.regdate;
                    var shopcode = listData.shopcode;
                    var shopname = listData.shopname;
                    var title = listData.title;
                    var username = listData.username;
                    var imglist = listData.imglist;

                    html += "<li " + (imgsrv_flg == "Y" ? "class=\"is-thum\"" : "class=\"is-txt\"") + " data-idx=\"" + listData.list_idx + "\">\n                            " + (imgsrv_flg == "Y" ? "<a href=\"javascript:void(0)\" class=\"thum__link\"><img src=\"" + imgurl_org + "\" alt=\"\"></a>" : "") + " \n                            <div class=\"thum__info\">\n                                <a href=\"javascript:void(0);\" class=\"tx_review\">" + contents + "</a>\n                                <div class=\"prodscope\">\n                                " + (point > 0 ? " <i class=\"ico ico--scope\">\n                                                    <span class=\"ico--scope-active\" style=\"width:" + point * 20 + "%;\"></span>\n                                                </i><p class=\"tx_aval\">" + point + "</p>" : "") + "\n                                </div>\n                                <p class=\"tx_source\">\n                                    <span>" + shopname + "</span><span class=\"user\">" + username + "</span><span>" + regdate + "</span>\n                                </p>\n                            </div>\n                        </li>";
                });
            }
            $("#prod_bbs_top").find(".preview__list").html(html);
            $("#prod_bbs_top").find(".preview__list li").unbind().click(function () {
                if ($(this).hasClass("is-txt")) {
                    bbsTextDetailView(json.data[$(this).data("idx") - 1]);
                } else {
                    $("#PHOTOLAYER").data("idx", $(this).data("idx"));
                    bbsDetailView(json);
                }
                insertLog(14487);
            });

            $("#prod_bbs_top").find(".preview__list li.is-thum img").on("error", function () {
                //a   console.log(json.data[vThisIdx])
                var vThisIdx = $(this).parents(".is-thum").data("idx");
                if (json.data[vThisIdx - 1].imglist.length > 1) {
                    imgError(json.data[vThisIdx - 1].imglist, this, 1);
                }
            });
        } else if (json.total == 0) {
            var _html = "<li class=\"no-data\" style=\"\">\n                        <p class=\"tx_msg\">\uB4F1\uB85D\uB41C \uC0C1\uD488\uD3C9\uC774 \uC5C6\uC2B5\uB2C8\uB2E4.<br>\uC0C1\uD488\uD3C9\uC744 \uB4F1\uB85D\uD574\uC8FC\uC138\uC694!</p>\n                        <a href=\"javascript:void(0)\" class=\"btn btn__write\" onclick=\" $('html,body').stop(true,false).animate({'scrollTop': $('#prodReview').offset().top - 150},500);\"><span>\uC0C1\uD488\uD3C9 \uC4F0\uAE30</span></a> \n                    </li>";

            $("#prod_bbs_top").find(".preview__list").html(_html);
        }
        $("#prod_bbs_top").show();
    };
    var bbsChartView = function bbsChartView(json) {
        if (json.success) {
            var chartPointCnt = json.data.iBbs_point_cnt;
            var chartPointNum = json.data.iBbs_point_num; //bbs_num
            var chartData = json.data;
            var pointList = json.data.pointList;
            if (chartPointCnt > 0) {
                $("#prodReview").find(".section__cont .userpoint .tx_score strong").html(chartData.bbs_point_avg);
                $("#prodReview").find(".section__cont .userpoint .prodscope span").css("width", chartData.bbs_point_avg * 20 + "%");
                var maxPoint = 1;
                if (pointList.length > 0) {
                    $.each(pointList, function (index, listData) {
                        if (listData.point <= 5) {
                            if (listData.pointCnt > maxPoint) {
                                maxPoint = listData.point;
                            }
                            var pointObj = $("#prodReview").find(".section__cont .userpoint .prodgraph--stick li[data-point=" + listData.point + "]");
                            $(pointObj).find(".tx_cnt").html(listData.pointCnt.format());
                            $(pointObj).find(".stick--gauge").css("height", listData.pointCnt / chartData.iBbs_point_cnt * 100 + "%");
                            $("#prod_bbs .point__filter li[data-point=\"" + listData.point + "\"]").removeClass("is-disabled");
                            $("#prod_bbs .point__filter li[data-point=\"" + listData.point + "\"] .tx-num").html(" (" + listData.pointCnt.format() + ")");
                        }
                    });
                    $("#prod_bbs_chart").find(".prodgraph--stick li[data-point=" + maxPoint + "]").addClass("is-on");
                }
            } else {
                $("#prod_bbs_chart").hide();
            }
            $("#prod_bbs").find(".reviewall__cont .reviewfilter .point__filter li").not(".is-disabled").click(function () {
                $("#prod_bbs").find(".reviewall__cont .reviewfilter .subject__filter ul li").removeClass("is-on");
                $("#prod_bbs").find(".reviewall__cont .reviewfilter .subject__filter ul li[data-code='']").addClass("is-on");
                $(this).siblings().removeClass("is-on");
                $(this).addClass("is-on");
                var point = $(this).data("point");

                paramHandler.set("point", point);
                insertLog(15940);
            });
        } else {
            $("#prod_bbs_chart").hide();
        }
    };
    var bbsFilterView = function bbsFilterView(json) {
        if (json.success) {
            var bbsFilterList = json.data.bbsFilterList;
            var html = "";
            if (bbsFilterList.length > 0) {
                insertLogLSV(26287, "" + gModelData.gCategory, "" + gModelData.gModelno);
                html += "<li class=\"is-on\" data-code=\"\"><button type=\"button\">\uC8FC\uC81C\uC804\uCCB4</button></li>";
                $.each(bbsFilterList, function (index, listData) {
                    html += "<li data-code=" + listData.word_code + "><button type=\"button\">" + listData.word_name + "</button></li>";
                });
                $("#prod_bbs").find(".reviewall__cont .reviewfilter .subject__filter ul").html(html);
                $("#prod_bbs").find(".reviewall__cont .reviewfilter .subject__filter").show();

                $("#prod_bbs").find(".reviewall__cont .reviewfilter .subject__filter ul li").off().on("click", function () {
                    insertLogLSV(26279, "" + gModelData.gCategory, "" + gModelData.gModelno);
                    $(this).siblings().removeClass("is-on");
                    $(this).addClass("is-on");
                    var word_code = $(this).data("code");
                    paramHandler.set("word_code", word_code);
                });
            } else {
                $("#prod_bbs").find(".reviewall__cont .reviewfilter .subject__filter").hide();
            }
        } else {
            $("#prod_bbs").find(".reviewall__cont .reviewfilter .subject__filter").hide();
        }
    };
    var bbsListView = function bbsListView(json) {
        var html = "";
        var bbsToTalCnt = json.iTotalCnt;
        var bbsList = json.list;
        $("#prod_bbs").find(".reviewall__head em.tx_cnt").html("(" + bbsToTalCnt.format() + ")");
        if (bbsList.length > 0) {
            $.each(bbsList, function (index, listData) {
                var contents = listData.contents;
                var imgsrv_flg = listData.imgsrv_flg;
                var imgurl_org = listData.imgurl_org;
                var list_idx = listData.list_idx;
                var no = listData.no;
                var modelno = listData.modelno;
                var point = listData.point;
                var regdate = listData.regdate;
                var shop_code = listData.shop_code;
                var shop_name = listData.shop_name;
                var title = listData.title;
                var userid = listData.userid;
                var usernm = listData.usernm;
                var photo_list = listData.photo_list;
                var delbtn = listData.delbtn;
                html += "<li class=\"reviewall__item " + (imgsrv_flg == "Y" ? "" : "is-text") + " \">\n                        <div class=\"col col--lt\">\n                            <div class=\"tx__source\">\n                                " + (point > 0 ? "<div class=\"prodscope prodscope--14x\">\n                                                <i class=\"ico ico--scope\">\n                                                    <span class=\"ico--scope-active\" style=\"width:" + point * 20 + "%;\"></span>\n                                                </i>\n                                                <p class=\"tx_aval\">" + point + "</p>\n                                            </div>" : "") + "\n                                <ul class=\"tx_info\">\n                                    <li>" + shop_name + "</li>\n                                    <li>" + usernm + "</li>\n                                    <li>" + regdate + "</li>\n                                </ul>\n                                " + (delbtn ? "<div class=\"review__delete\">\n                                                <button type=\"button\" class=\"btn btn-delete\" data-no=\"" + no + "\" data-modelno=\"" + modelno + "\" >\uC0AD\uC81C\uD558\uAE30</button>\n                                                " + (SNSTYPE == "" || SNSTYPE == "E" ? "<div id=\"boardDelLayer\" class=\"smallbox boarddel\" data-no=\"" + no + "\"  data-modelno=\"" + modelno + "\" style=\"display:none;\">\n                                                    <h5>\n                                                        \uAC8C\uC2DC\uAE00\uC744 \uC0AD\uC81C\uD569\uB2C8\uB2E4. \uBE44\uBC00\uBC88\uD638\uB97C \uC785\uB825\uD574\uC8FC\uC138\uC694.\n                                                        <a href=\"javascript:///\" class=\"btnclose\">\uB2EB\uAE30</a>\n                                                    </h5>\n                                                    <div class=\"inner\">\n                                                        <p class=\"pw\">\uBE44\uBC00\uBC88\uD638</p>\n                                                        <p><input type=\"password\"><a class=\"btn_dis del\">\uC0AD\uC81C</a></p>\n                                                    </div>" : "") + "\n                                                </div>" : "") + "\n                            </div>\n                            <button type=\"button\" class=\"tx__link\">" + title + "</button>\n\n                            <span class=\"tx_sub\">\n                                " + contents + "\n                            </span>";
                if (photo_list.length > 0) {
                    html += "<div class=\"thumbox\">";
                    $.each(photo_list, function (index, listData) {
                        html += "<span><img src=\"" + listData + "\" alt=\"\" onerror=\"this.style.visibility='hidden'\"></span>";
                    });
                    html += "</div>";
                }
                html += "    </div>\n                        <div class=\"col col--rt\">\n                        " + (imgsrv_flg == "Y" ? " <a href=\"javascript:void(0)\" class=\"thum__link\">\n                                                <img src=\"" + imgurl_org + "\" alt=\"\">\n                                                " + (photo_list.length > 1 ? "<span class=\"tx_cnt\">+" + photo_list.length + "</span>" : "") + "\n                                            </a>" : "") + "\n                        " + (contents.length <= 120 && imgsrv_flg != "Y" ? "" : "<button type=\"button\" class=\"btn btn__more\">\uC0C1\uD488\uD3C9 \uD3BC\uCE58\uAE30</button>") + "\n                        </div>\n                    </li>";
            });
            $("#prod_bbs").find(".reviewall__cont .reviewall__list").append(html);
            $("#prod_bbs").find(".abs--right .reviewall__onlyphoto .toggle__chk").unbind().click(function () {
                if ($(this).hasClass("is-off")) {
                    $(this).removeClass("is-off").addClass("is-on");
                    paramHandler.set("isphoto", "Y");
                } else {
                    $(this).removeClass("is-on").addClass("is-off");
                    paramHandler.set("isphoto", "");
                }
                insertLog(24453);
            });
            $("#prod_bbs").find(".reviewall__cont .reviewall__list .reviewall__item .col.col--rt img").on("error", function () {
                var vThisIdx = $(this).parents(".reviewall__item").index();
                if (bbsList[vThisIdx - 1].photo_list.length > 1) {
                    imgError(bbsList[vThisIdx - 1].photo_list, this, 1);
                }
            });
            // 상품평 접기/펼치기
            $("#prod_bbs").find(".reviewall__item").click(function (e) {
                if ($(this).find(".btn__more").length > 0) {
                    $(this).closest(".reviewall__item").toggleClass("is-unfold");

                    if ($(this).closest(".reviewall__item").hasClass("is-unfold")) {
                        $(this).find(".btn__more").text("상품평 닫기");
                    } else {
                        $(this).find(".btn__more").text("상품평 펼치기");
                        $("html,body").stop(true, false).animate({ "scrollTop": $("#prod_bbs .reviewall__head").offset().top - 150 }, 500);
                    }
                    insertLog(24454);
                }
            });
            $("#prod_bbs").find(".reviewall__list .reviewall__item .btn-delete").unbind().click(function (e) {
                var nowDate = new Date().format("yyyyMMddhhmm") * 1;
                if (nowDate >= minReviewCheck && nowDate <= maxReviewCheck) {
                    // 상품평 작성 점검
                    alert("2021-06-11 16:00 ~ 2021-06-12 04:00 까지 상품평 작성 점검중입니다. ");
                    return;
                }
                var delno = $(this).data("no");
                var delmodelno = $(this).data("modelno");
                if (SNSTYPE == "" || SNSTYPE == "E") {
                    $("#boardDelLayer").show();
                } else {
                    bbsPromise.bbsDelete(delmodelno, delno, '').then(function (result) {
                        if (result.success) {
                            if (result.data.flag) {
                                alert("선택하신 글이 삭제되었습니다.");

                                bbsPromise.bbsTop().then(bbsTopView);
                                bbsPromise.bbsList().then(bbsListView);

                                --gModelData.gBbsNum;

                                gModelData.gBbsNum == 0 ? $('#tabBbs .tab__link em').text('') : $('#tabBbs .tab__link em').text("(" + gModelData.gBbsNum.format() + ")");

                                $('#prod_bbs_top .preview__tit span').text(gModelData.gBbsNum.format());
                            } else {
                                if (!result.data.passflag) {
                                    alert("비밀번호가 정확하지 않습니다.");
                                }
                            }
                        }
                    });
                }
                e.stopPropagation();
            });
            $("#prod_bbs").find(".reviewall__list .review__delete .smallbox.boarddel .btn_dis.del").unbind().click(function () {
                var delno = $(this).parents(".smallbox.boarddel").data("no");
                var delmodelno = $(this).parents(".smallbox.boarddel").data("modelno");
                var delPass = $(this).siblings("input").val();
                bbsPromise.bbsDelete(delmodelno, delno, delPass).then(function (result) {
                    if (result.success) {
                        if (result.data.flag) {
                            alert("선택하신 글이 삭제되었습니다.");

                            bbsPromise.bbsTop().then(bbsTopView);
                            bbsPromise.bbsList().then(bbsListView);

                            --gModelData.gBbsNum;

                            gModelData.gBbsNum == 0 ? $('#tabBbs .tab__link em').text('') : $('#tabBbs .tab__link em').text("(" + gModelData.gBbsNum.format() + ")");

                            $('#prod_bbs_top .preview__tit span').text(gModelData.gBbsNum.format());
                        } else {
                            if (!result.data.passflag) {
                                alert("비밀번호가 정확하지 않습니다.");
                            }
                        }
                    }
                });
            });
            $("#prod_bbs").find(".reviewall__select").click(function (e) {
                $("#prod_bbs").find(".select-box--basic").siblings().removeClass("is-on");
                $("#prod_bbs").find(".select-box--basic").addClass("is-on");
                if ($(this).data("all-visible")) {
                    $("#prod_bbs").find(".select-box--basic .select-box__list").show();
                } else {
                    $(this).data("all-visible", true);
                    bbsPromise.bbsShopList().then(bbsShopListView);
                }
            });
        } else {
            html += "<li class=\"reviewall__item no-data\">\n                    <p class=\"tx_msg\">\uB4F1\uB85D\uB41C \uC0C1\uD488\uD3C9\uC774 \uC5C6\uC2B5\uB2C8\uB2E4.</p>\n                </li>";
            $("#prod_bbs").find(".reviewall__cont .reviewall__list").append(html);
        }
        fn_paging(paramHandler.get("page"), paramHandler.get("pagesize"), bbsToTalCnt);
        $("#prod_bbs").find(".comm__paging ul li").click(function () {
            var page = $(this).data("page");
            paramHandler.set("page", page);
            $("html,body").stop(true, false).animate({ "scrollTop": $("#prod_bbs .reviewall__head").offset().top - 150 }, 500);
        });
    };
    var bbsImageListView = function bbsImageListView(json) {
        if (json.success && json.total > 0) {
            $("#prod_image_bbs").find(".photoreview__head em.tx_cnt").html("(" + json.total.format() + ")");
            Object.assign(bbsImageList, json);
            var imageBbsList = json.data;
            var html = "";

            $.each(imageBbsList, function (index, listData) {
                if (index == 12) {
                    html += "<li class=\"thum_more\">\n                            <button type=\"button\" class=\"btn btn__layopen\">\n                                <p class=\"tx_cnt\">+" + json.total.format() + "</p>\n                                <img class=\"lazy\" data-original=\"" + listData.imgurl_org + "\" src=\"http://img.enuri.info/images/home/thum_none.jpg\"  alt=\"\" >\n                            </button>\n                        </li>";
                    return false;
                } else {
                    html += "<li data-idx=\"" + listData.list_idx + "\">   \n                            <a href=\"javascript:void(0);\" class=\"thum__link\" title=\"\">\n                            <img class=\"lazy\" data-original=\"" + listData.imgurl_org + "\" src=\"http://img.enuri.info/images/home/thum_none.jpg\"  alt=\"\" >\n                            </a>\n                        </li>";
                }
            });

            if (imageBbsList.length < 13) {
                var cnt = 13 - imageBbsList.length;
                var i = 0;

                while (i < cnt) {
                    html += "<li></li>";
                    ++i;
                }
            }

            $("#prod_image_bbs").find(".thum__list").html(html);

            $("#prod_image_bbs").find(".thum__list li").unbind().click(function () {
                if ($(this).hasClass("thum_more")) {
                    bbsImageListAllView();
                } else if ($(this).data("idx")) {
                    $("#PHOTOLAYER").data("idx", $(this).data("idx"));
                    bbsPromise.bbsDetail($(this).data("idx")).then(bbsDetailView);
                }
                insertLog(24452);
            });
            $("#prod_image_bbs").find(".thum__list li img").lazyload({
                placeholder: 'http://img.enuri.info/images/home/thum_none.jpg',
                effect: 'fadeIn',
                effectTime: 2000,
                threshold: 800
            });
        } else {
            $("#prod_image_bbs").hide();
        }
    };
    var bbsDetailView = function bbsDetailView(json) {
        if (json.success && json.total > 0) {
            var detailbbsData = json.data;
            var detailbbsTotalCnt = json.total;
            var thisIdx = $("#PHOTOLAYER").data("idx");
            var next_idx = 0;
            var prev_idx = 0;
            var this_obj = {};
            var html = "";
            $.each(detailbbsData, function (index, listData) {
                if (listData.list_idx == thisIdx) {
                    next_idx = this_obj.next_idx;
                    prev_idx = this_obj.prev_idx;
                    Object.assign(this_obj, listData);
                    return false;
                }
            });
            $("#PHOTOLAYER").find(".photoreview__view .arr").hide();
            if (this_obj.next_idx > 0) {
                $("#PHOTOLAYER").find(".photoreview__view .arr.arr-next").data("idx", this_obj.next_idx);
                $("#PHOTOLAYER").find(".photoreview__view .arr.arr-next").show();
            }
            if (this_obj.prev_idx > 0) {
                $("#PHOTOLAYER").find(".photoreview__view .arr.arr-prev").data("idx", this_obj.prev_idx);
                $("#PHOTOLAYER").find(".photoreview__view .arr.arr-prev").show();
            }
            if (this_obj.next_idx > 0 && this_obj.prev_idx > 0) {
                $("#PHOTOLAYER").find(".photoreview__lt").html("\n                <p class=\"tx_cnt\"><strong>" + thisIdx.format() + "</strong><span> / " + detailbbsTotalCnt.format() + "</span></p>\n            ");
            } else {
                $("#PHOTOLAYER").find(".photoreview__lt").html("");
            }
            $("#PHOTOLAYER").find(".photoreview__lt").append("<div class=\"thum__box\">\n                <div class=\"thum__big\"><img src=\"" + this_obj.imgurl_org + "\" alt=\"\"/></div>\n            </div>");

            html += "<div class=\"inbo__box\">\n            <div class=\"tx__source\">\n                <div class=\"prodscope prodscope--14x\">\n                    <i class=\"ico ico--scope\">\n                        <span class=\"ico--scope-active\" style=\"width:" + this_obj.point * 20 + "%;\"></span>\n                    </i>\n                    <p class=\"tx_aval\">" + this_obj.point + "</p>\n                </div>\n                <ul class=\"tx_info\">\n                    <li>" + this_obj.shopname + "</li>\n                    <li>" + this_obj.username + "</li>\n                    <li>" + this_obj.regdate + "</li>\n                </ul>\n            </div>\n\n            <p class=\"tx_name\">" + this_obj.title + "</p>\n            <span class=\"tx_sub\">\n                " + this_obj.contents + "\n            </span>\n            <ul class=\"thum__list\">";
            $.each(this_obj.imglist, function (index, listData) {
                html += "<li " + (index == 0 ? "class=\"is-on\"" : "") + " ><button type=\"button\" class=\"btn\"><img src=\"" + listData + "\" alt=\"\"  ></button></li>";
            });
            html += "</ul></div>";

            $("#PHOTOLAYER").find(".photoreview__rt").html(html);
            $("#PHOTOLAYER").find(".photoreview__rt .thum__list li").click(function () {
                var thisImg = $(this).find("img").attr("src");
                $("#PHOTOLAYER").find(".photoreview__lt .thum__box .thum__big img").attr("src", thisImg);
            });
            $("#PHOTOLAYER").find(".photoreview__rt .thum__list li img ").on("error", function () {
                $(this).attr("src", "http://img.enuri.info/images/home/thum_none.jpg");
            });
            $("#PHOTOLAYER").find(".photoreview__lt .thum__box img").on("error", function () {
                $(this).attr("src", "http://img.enuri.info/images/home/thum_none.jpg");
            });
            $("#PHOTOLAYER").find(".btn__viewtype").removeClass("is-on");
            $("#PHOTOLAYER").find(".photoreview__all").hide();
            $("#PHOTOLAYER").find(".photoreview__view").show();

            $("#PHOTOLAYER").show();

            $("#PHOTOLAYER").find(".photoreview__view .arr").unbind().click(function () {
                var idx = $(this).data("idx");
                $("#PHOTOLAYER").data("idx", idx);
                bbsPromise.bbsDetail(idx).then(bbsDetailView);
            });
            $("#PHOTOLAYER").find(".photoreview__rt .thum__list li").click(function () {
                $(".photoreview__rt .thum__list li").removeClass("is-on");
                $(this).addClass("is-on");
            });

            $("#PHOTOLAYER").find(".btn__viewtype").click(function () {
                bbsImageListAllView();
            });
        }
    };
    var bbsTextDetailView = function bbsTextDetailView(json) {
        var html = "";
        if (typeof json != "undefined") {
            html = "<div class=\"info__box\">\n                        <div class=\"tx__source\">\n                            <div class=\"prodscope prodscope--14x\">\n                                <i class=\"ico ico--scope\">\n                                <span class=\"ico--scope-active\" style=\"width:" + json.point * 20 + "%;\"></span>\n                                </i>\n                                <p class=\"tx_aval\">" + json.point + "</p>\n                            </div>\n                            <ul class=\"tx_info\">\n                            <li>" + json.shopname + "</li>\n                            <li>" + json.username + "</li>\n                            <li>" + json.regdate + "</li>\n                        </ul>\n                        </div>\n\n                        <p class=\"tx_name\">" + json.title + "</p>\n                        <span class=\"tx_sub\">\n                        " + json.contents + "\n                        </span>";

            $("#TEXTLAYER").find(".lay-comm--body .textreview__view").html(html);
            $("#TEXTLAYER").show();
        } else {
            $("#TEXTLAYER").hide();
        }
    };
    var bbsImageListAllView = function bbsImageListAllView() {
        $("#PHOTOLAYER").find(".btn__viewtype").addClass("is-on");
        $("#PHOTOLAYER").find(".photoreview__view").hide();
        if (!$("#PHOTOLAYER").find(".btn__viewtype").data("all_visible")) {
            if (bbsImageList.success && bbsImageList.total > 0) {
                var imageBbsList = bbsImageList.data;
                var html = "";
                $.each(imageBbsList, function (index, listData) {
                    html += "<li>   \n                            <button type=\"button\" class=\"btn\" data-idx=\"" + listData.list_idx + "\"><img class=\"lazy\" data-original=\"" + listData.imgurl_org + "\" src=\"http://img.enuri.info/images/home/thum_none.jpg\"  alt=\"\" ></button> \n                        </li>";
                });
                $("#PHOTOLAYER").find(".photoreview__all .photoreview__list").html(html);
                $("#PHOTOLAYER").find(".photoreview__all").show();
                $("#PHOTOLAYER").find(".photoreview__all .photoreview__list li img.lazy").lazyload({
                    container: $("#PHOTOLAYER .photoreview__all"),
                    placeholder: 'http://img.enuri.info/images/home/thum_none.jpg',
                    effect: 'fadeIn',
                    effectTime: 2000,
                    threshold: 800

                });

                $("#PHOTOLAYER").find(".photoreview__all .photoreview__list .btn").click(function () {
                    $("#PHOTOLAYER").find(".photoreview__all .photoreview__list .btn").removeClass("is-on");
                    $(this).addClass("is-on");
                    var idx = $(this).data("idx");
                    $("#PHOTOLAYER").data("idx", idx);
                    bbsPromise.bbsDetail(idx).then(bbsDetailView);
                });
                if (bbsImageList.total > 500) {
                    var _throttleTimer = null,
                        _throttleDelay = 100,
                        $pwrapper = $(".lay-photoreview .photoreview__all"),
                        $plist = $(".lay-photoreview .photoreview__list"),
                        $alarmBox = $(".lay-photoreview .limit__alarm");

                    // 레이어 : 전체보기 최대 500개 노출 
                    $pwrapper.scroll(function () {
                        //throttle event:
                        clearTimeout(_throttleTimer);
                        _throttleTimer = setTimeout(function () {
                            var pTotal = $pwrapper.scrollTop() + $pwrapper.height();

                            if (pTotal > $plist.height() + 40) {
                                $alarmBox.fadeIn(200, function () {
                                    setTimeout(function () {
                                        $alarmBox.fadeOut(200);
                                    }, 1000);
                                });
                            }
                        }, _throttleDelay);
                    });
                }
            }
        }
        $("#PHOTOLAYER").find(".photoreview__all").show();
        $("#PHOTOLAYER").find(".btn__viewtype").data("all_visible", true);
        $("#PHOTOLAYER").show();
    };
    var bbsShopListView = function bbsShopListView(json) {
        if (json.success && json.total > 0) {
            var shopListData = json.data;
            var html = "";
            html += "<li class=\"select-box__item\"  data-shopcode=\"\"><a href=\"javascript:void(0);\">\uC804\uCCB4\uBCF4\uAE30</a></li>";
            $.each(shopListData, function (index, listData) {
                var shopcode = listData.shop_code;
                var shopname = listData.shop_name;

                html += "<li class=\"select-box__item\"  data-shopcode=\"" + shopcode + "\"><a href=\"javascript:void(0);\">" + shopname + "</a></li>";
            });
            $("#prod_bbs").find(".select-box--basic .select-box__list").html(html);
            $("#prod_bbs").find(".select-box--basic .select-box__list li").unbind().click(function (e) {
                e.stopPropagation();
                $("#prod_bbs").find(".reviewall__select .select-box--basic").removeClass("is-on");
                var shopname = $(this).find("a").text();
                var shopcode = $(this).data("shopcode");
                $("#prod_bbs").find(".select-box--basic .select-box--selected").html(shopname + "<i class=\"ico-arr-select-box lp__sprite\"></i>");
                paramHandler.set("shopcodes", shopcode);
                insertLog(14530);
            });
            $("#prod_bbs").find(".reviewall__select").show();
        } else {
            $("#prod_bbs").find(".reviewall__select").hide();
        }
    };

    var imgError = function imgError(imgarray, obj, index) {
        $(obj).replaceWith("<img src=\"" + imgarray[index] + "\" alt=\"\">");
        $(undefined).on("error", function () {
            imgError(imgarray, this, index++);
        });
    };
    var fn_paging = function fn_paging(pageNum, pageSize, pageCnt) {
        var pHtml = "";
        var startPage = parseInt(pageNum / 10) * 10;
        var totalPage = parseInt(pageCnt) / pageSize;
        var endPage = 0;
        if (pageNum > 0 && parseInt(pageNum % 10) == 0) {
            startPage = startPage - 10;
        }

        if (pageNum > 10) {
            pHtml += "<li data-page=\"" + (startPage - 1) + "<a href=\"javascript:;\" class=\"btn btn__prev\">이전</a></li>";
        }

        if (totalPage > startPage + 10) {
            endPage = startPage + 10;
        } else {
            endPage = totalPage;
        }
        var i = startPage;
        for (i = startPage; i < endPage; i++) {
            if (pageNum == i + 1) {
                pHtml += "<li data-page=\"" + (i + 1) + "\" class=\"is-on\"><a href=\"javascript:;\" class=\"p_num\">" + (i + 1) + "</a></li>";
            } else {
                pHtml += "<li data-page=\"" + (i + 1) + "\"><a href=\"javascript:;\" class=\"p_num\">" + (i + 1) + "</a></li>";
            }
        }

        if (totalPage > startPage + 10) {
            pHtml += "<li data-page=\"" + (i + 1) + "\"><a href=\"javascript:;\" class=\"btn btn__next\">다음</a></li>";
        }
        $("#prod_bbs").find(".comm__paging ul").html(pHtml);
        $("#prod_bbs").find(".comm__paging").show();
    };
});