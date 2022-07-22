(function (global, factory) {
    if (typeof define === "function" && define.amd) {
        define(["exports", "./prod_option.js", "./prod_shopprice.js", "./prod_pricecomp.js", "./prod_recomm.js", "./prod_review.js", "./prod_compspec.js", "./prod_bbs.js", "./prod_graph.js", "./prod_desc.js", "./prod_qna.js", "./prod_cate.js", "./prod_common.js"], factory);
    } else if (typeof exports !== "undefined") {
        factory(exports, require("./prod_option.js"), require("./prod_shopprice.js"), require("./prod_pricecomp.js"), require("./prod_recomm.js"), require("./prod_review.js"), require("./prod_compspec.js"), require("./prod_bbs.js"), require("./prod_graph.js"), require("./prod_desc.js"), require("./prod_qna.js"), require("./prod_cate.js"), require("./prod_common.js"));
    } else {
        var mod = {
            exports: {}
        };
        factory(mod.exports, global.prod_option, global.prod_shopprice, global.prod_pricecomp, global.prod_recomm, global.prod_review, global.prod_compspec, global.prod_bbs, global.prod_graph, global.prod_desc, global.prod_qna, global.prod_cate, global.prod_common);
        global.prod_init = mod.exports;
    }
})(this, function (exports, _prod_option, _prod_shopprice, _prod_pricecomp, _prod_recomm, _prod_review, _prod_compspec, _prod_bbs, _prod_graph, _prod_desc, _prod_qna, _prod_cate, _prod_common) {
    "use strict";

    Object.defineProperty(exports, "__esModule", {
        value: true
    });
    exports.gModelHandler = undefined;

    var prodOption = _interopRequireWildcard(_prod_option);

    var prodShopPrice = _interopRequireWildcard(_prod_shopprice);

    var prodPriceComp = _interopRequireWildcard(_prod_pricecomp);

    var prodRecomm = _interopRequireWildcard(_prod_recomm);

    var prodReview = _interopRequireWildcard(_prod_review);

    var prodCompSpec = _interopRequireWildcard(_prod_compspec);

    var prodBbs = _interopRequireWildcard(_prod_bbs);

    var prodGraph = _interopRequireWildcard(_prod_graph);

    var prodDesc = _interopRequireWildcard(_prod_desc);

    var prodQna = _interopRequireWildcard(_prod_qna);

    var prodCate = _interopRequireWildcard(_prod_cate);

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

    $(function () {
        loadNav(gModelData.gCategory);

        init(false);

        // 탭 이동, 활성화
        var $pTabItem = $(".prodtab__item"); // 탭 li

        $pTabItem.find(".tab__link").on("click", function (e) {
            var _this = $(this);
            var objId = _this.attr("href"); // 이동할 탭 아이디
            var objPosTop = $(objId).offset().top; // 탭 위치 
            var fixedInfo_H = $(".prodtabinfo").outerHeight(); // fixed된 상품 정보 높이
            var fixedTab_H = $(".prodtab").outerHeight(); // fixed된 탭 높이

            /* $pTabItem.removeClass("is-on");
            _this.parents("li").addClass("is-on"); */

            $(window).scrollTop(objPosTop - fixedInfo_H - fixedTab_H - 32);

            e.preventDefault();
        });

        // 상단요약 좌측 > 썸네일 목록 스와이퍼 생성
        var prodinfoThumLength = $(".thum__slide .thum__list > li").length;

        if (prodinfoThumLength > 3) {
            var prodinfoThum = $(".thum__slide");
            prodinfoThum.addClass("is-swiper");
        } else {
            prodinfoSwipe.destroy(false, true);
        }
        var specLength = $(".specswipe .specswipe__item > li").length; // 사양 전체갯수

        if (specLength > 5) {
            var specState = $(".proddetail__spec");
            specState.addClass("is-swiper");
            $(".proddetail__spec .swiper-pagination").removeClass('swiper-pagination-hidden');
            $(".proddetail__spec .btn__more").show();
        } else {
            // prodspecSwipe.destroy(false,true);
            $(".proddetail__spec .swiper-pagination").addClass('swiper-pagination-hidden');
            $(".proddetail__spec .btn__more").hide();
        }
        // 상단요약 좌측 > 이미지 컨트롤
        var $thum_cont = $(".proddetail .thum__cont .thum__img > img"),
            // 썸네일 큰 이미지
        $thum_item = $(".proddetail .thum__list > li"),
            // 썸네일 작은 이미지 목록
        _btnVodIdx = 1; // VOD 일 때, 스와이퍼 인덱스 

        $thum_item.on("mouseenter", function () {
            var _this = $(this),
                thumSrc = _this.find("img").attr("src");

            $thum_item.removeClass("is-on");
            _this.addClass("is-on");

            if (_this.hasClass("has-vod")) {
                // VOD 썸네일일때
                $thum_cont.closest(".thum__cont").addClass("is-vod");
            } else {
                $thum_cont.closest(".thum__cont").removeClass("is-vod");
            }
            $thum_cont.attr({ "src": thumSrc });
        }).on("click", function () {
            var __idx = $(this).index(); // 클릭 index
            loadThumNail(gModelData.gModelno, __idx);
        });

        $('.vip__top .btn__declaration').click(function () {
            prodCommon.declaration.layerDeclaration();
        });

        setTimeout(function () {
            $("#prod_summary_top, #prod_topfix").find(".btn__alarm").siblings(".lay-tooltip").fadeOut();
        }, 1000);

        $(window).on("scroll", stickyProdTab);
        $("#prod_shopprice").find(".m_price__toggle .toggle__chk").on("click", function () {
            if ($(this).hasClass("is-off")) {
                $(this).removeClass("is-off");
                $(this).addClass("is-on");
                if ($(this).hasClass("card")) {
                    prodShopPrice.paramHandler.set("card", "Y");
                    prodPriceComp.paramHandler.set("card", "Y");
                    insertLogLSV(18626, "" + gModelData.gCategory, "" + gModelData.gModelno);
                    ga('send', 'event', 'vip', 'summary_sort', 'creditpromotion');
                }
                if ($(this).hasClass("delivery")) {
                    prodShopPrice.paramHandler.set("delivery", "Y");
                    prodOption.paramHandler.set("delivery", "Y");
                    prodPriceComp.paramHandler.set("delivery", "Y");
                    insertLogLSV(18625, "" + gModelData.gCategory, "" + gModelData.gModelno);
                    ga('send', 'event', 'vip', 'summary_sort', 'shipping');
                }
            } else {
                $(this).addClass("is-off");
                $(this).removeClass("is-on");
                if ($(this).hasClass("card")) {
                    prodShopPrice.paramHandler.set("card", "");
                    prodPriceComp.paramHandler.set("card", "N");
                }
                if ($(this).hasClass("delivery")) {
                    prodShopPrice.paramHandler.set("delivery", "");
                    prodOption.paramHandler.set("delivery", "");
                    prodPriceComp.paramHandler.set("delivery", "N");
                }
            }
            prodShopPrice.paramHandler.set("callcnt", 1);
        });
        $("#prod_shopprice").find(".m_price__sort input").on("click", function () {
            if ($(this).is(":checked")) {
                if ($(this).data("sort") === 'card') {
                    prodShopPrice.paramHandler.set("card", "Y");
                    prodPriceComp.paramHandler.set("card", "Y");
                    insertLogLSV(18626, "" + gModelData.gCategory, "" + gModelData.gModelno);
                    ga('send', 'event', 'vip', 'summary_sort', 'creditpromotion');
                }
                if ($(this).data("sort") === 'delivery') {
                    prodShopPrice.paramHandler.set("delivery", "Y");
                    prodOption.paramHandler.set("delivery", "Y");
                    prodPriceComp.paramHandler.set("delivery", "Y");
                    insertLogLSV(18625, "" + gModelData.gCategory, "" + gModelData.gModelno);
                    ga('send', 'event', 'vip', 'summary_sort', 'shipping');
                }
            } else {
                if ($(this).data("sort") === 'card') {
                    prodShopPrice.paramHandler.set("card", "");
                    prodPriceComp.paramHandler.set("card", "N");
                }
                if ($(this).data("sort") === 'delivery') {
                    prodShopPrice.paramHandler.set("delivery", "");
                    prodOption.paramHandler.set("delivery", "");
                    prodPriceComp.paramHandler.set("delivery", "N");
                }
            }
            prodShopPrice.paramHandler.set("callcnt", 1);
        });

        $("#prod_pricecomp .sort_block .sort_chk input").off().on("click", function () {
            if ($(this).is(':checked') === true) {
                prodPriceComp.paramHandler.set("" + $(this).data('sort'), 'Y');
                prodShopPrice.paramHandler.set("" + $(this).data('sort'), 'Y');
                prodOption.paramHandler.set("" + $(this).data('sort'), 'Y');
            } else {
                prodPriceComp.paramHandler.set("" + $(this).data('sort'), 'N');
                prodShopPrice.paramHandler.set("" + $(this).data('sort'), 'N');
                prodOption.paramHandler.set("" + $(this).data('sort'), 'N');
            }
            /* ($(this).is(':checked') === true)
            ? prodPriceComp.paramHandler.set(`${$(this).data('sort')}`, 'Y')
            : prodPriceComp.paramHandler.set(`${$(this).data('sort')}`, 'N'); */

            /*로그 정리되면 수정*/
            if ($(this).data('sort') === "delivery") {
                insertLogLSV(14502, "" + gModelData.gCategory, "" + gModelData.gModelno);
            } else if ($(this).data('sort') == "card") {
                insertLogLSV(14504, "" + gModelData.gCategory, "" + gModelData.gModelno);
            }
        });
    });
    // 상단요약 좌측 > 썸네일 목록 스와이퍼 생성
    var prodinfoSwipe = new Swiper('.thum__slide .swiper-container', {
        centeredSlides: false,
        slidesPerView: 4,
        spaceBetween: 4,
        grabCursor: true,
        prevButton: '.thum__slide .arr-prev',
        nextButton: '.thum__slide .arr-next'
    });
    var prodspecSwipe = new Swiper('.proddetail__spec .specswipe', {
        scrollbarHide: false,
        slidesPerView: "auto",
        centeredSlides: false,
        spaceBetween: 0,
        initialSlide: 0,
        adaptiveHeight: true,
        grabCursor: false,
        prevButton: '.proddetail__spec .arr-prev',
        nextButton: '.proddetail__spec .arr-next',
        pagination: '.swiper-pagination'
    });

    var stickyProdTab = function stickyProdTab() {
        var vTab = $(".prodtab"); // 탭 WRAP
        var vTabItem = $(".prodtab__item:not(.prodtab__item[style*='display:none'])"); // 탭 LI
        var vTab_top = $(".prodtabbox").offset().top - 90; // 탭 + 상품정보 첫 위치
        var vTab_height = Math.ceil($(vTab).outerHeight() + $(".prodtabinfo").outerHeight() + 34); // 탭 + 상품정보 높이
        var scrTop = Math.ceil($(window).scrollTop()); // 현재 scroll 위치
        var vtabContents = $(".tab__scroll:not(.tab__scroll[style*='display:none'])"); // 각 탭 컨텐츠 스크롤 지점
        $("header").removeClass("is--sticky is--show");
        // 탭 FIXED
        if (scrTop > vTab_top) {
            if (!vTab.hasClass("is-fixed")) {
                vTab.addClass("is-fixed");
                $(".prodtabinfo").addClass("over_bar_price");
                $(".wing").addClass("is--over_bar");
            }
        } else {
            if (vTab.hasClass("is-fixed")) {
                vTab.removeClass("is-fixed");
                $(".prodtabinfo").removeClass("over_bar_price");
                $(".wing").removeClass("is--over_bar");
            }
        }
        // 스크롤 위치에 따른 탭 활성화
        $.each(vtabContents, function (idx, item) {
            var $target = vtabContents.eq(idx),
                targetTop = Math.ceil($target.offset().top - vTab_height);
            if (targetTop < scrTop) {
                vTabItem.removeClass('is-on');
                vTabItem.eq(idx).addClass('is-on');
            }
        });
    };
    $(window).on("load", function () {
        stickyProdTab();
        if ($("#prodDetail").find(".section__cont .specdetail .sd__container .sd__cont.is-shown .inner").height() >= 850) {
            $("#prodDetail").find(".section__cont .specdetail .btn__group").show();
        } else {
            $("#prodDetail").find(".section__cont .specdetail .btn__group").hide();
        }
        $("#prod_bbs_top").find(".btn.btn__more").unbind().click(function () {
            $(window).scrollTop($("#prodReview").offset().top - $(".prodtabinfo").outerHeight() - $(".prodtab").outerHeight() - 32);
        });
        $(".proddetail__spec .btn__more").unbind().click(function () {
            $(window).scrollTop($("#prodDetail").offset().top - $(".prodtabinfo").outerHeight() - $(".prodtab").outerHeight() - 32);
        });

        /*  if(focusName=="bbs"){
             setTimeout(function(){
                 $(window).scrollTop( $("#prodReview").offset().top - $(".prodtabinfo").outerHeight() - $(".prodtab").outerHeight() - 32);
             },1000);
         } */
    });

    // Mutation Observer
    // 감시 대상 node 선택
    var target = $("#prod_option")[0];

    // 감시자 인스턴스 만들기+
    var observer = new MutationObserver(function (mutations) {
        // 노드가 변경 됐을 때의 작업
        $("#prod_topfix .prodtabinfo .select-box__list li, #prod_option .pricecomp__list[class*='is-col'] li, #prod_option .compare_price__list li, #prod_option_top .buyopt__list li").click(function (e) {
            if ($(this).data("modelno") != gModelData.gModelno) {
                var modelno = $(this).data("modelno");
                gModelHandler.set("gModelno", modelno);
            }
        });
        //observer.disconnect();
    });

    // 대상 노드에 감시자 전달
    observer.observe(target, {
        //attributes: true,
        //attributeFilter: ["style"]
        subtree: true,
        childList: true
        //characterData: true
    });

    var gModelHandler = exports.gModelHandler = {
        set: function set(prop, value) {
            gModelData[prop] = value;
            init(true);
            return true;
        },
        get: function get(prop) {
            return gModelData[prop];
        }
    };
    var init = function () {
        var _ref = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee() {
            var reInit = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : false;
            return regeneratorRuntime.wrap(function _callee$(_context) {
                while (1) {
                    switch (_context.prev = _context.next) {
                        case 0:
                            $(".comm-loader").show();

                            if (!reInit) {
                                _context.next = 4;
                                break;
                            }

                            _context.next = 4;
                            return prodModelInitPromise().then(prodModelInitView);

                        case 4:
                            if (!(gModelData.gCdateView == "출시예정")) {
                                _context.next = 10;
                                break;
                            }

                            //출시예정
                            $("#prod_top_right_except").show();
                            $("#prod_top_left_except").show();
                            $("#prod_comp_except").show();
                            _context.next = 21;
                            break;

                        case 10:
                            if (!(gModelData.gMallCnt == 0)) {
                                _context.next = 15;
                                break;
                            }

                            //일시품절
                            $("#prod_top_left_except").show();
                            $("#prod_comp_except").show();
                            _context.next = 21;
                            break;

                        case 15:
                            if (reInit) {
                                _context.next = 18;
                                break;
                            }

                            _context.next = 18;
                            return prodOption.optionPromise().then(prodOption.prodOptionViewTop).then(prodOption.prodOptionViewTopFix).then(prodOption.prodOptionView);

                        case 18:
                            _context.next = 20;
                            return prodShopPrice.shopPricePromise().then(prodShopPrice.prodShopPriceView).catch(function (err) {
                                console.log(err);
                            });

                        case 20:
                            if ((gModelData.gCate4 == "1459" || gModelData.gCate4 == "1203" || gModelData.gCate4 == "1205" || gModelData.gCate4 == "1219" || gModelData.gCate4 == "1242" || gModelData.gCate4 == "1254") && prodShopPrice.cardshop_check) {
                                prodPriceComp.paramHandler.set("card", "Y");
                            } else {
                                prodPriceComp.paramHandler.set("sort", "price");
                            }

                        case 21:
                            prodGraph.graphPromise().then(prodGraph.prodGraphView);

                            getPowerLink("VIP", gModelData.gCategory, "");
                            fnEbayVip(gModelData.gModelno);

                            prodCommon.prodBannerPromise("mid");
                            prodCate.catePromise.caution().then(prodCate.prodCateView.caution);

                            if (gModelData.gCate4 == "0860" || gModelData.gCate4 == "0801" || gModelData.gCate4 == "0805" || gModelData.gCate4 == "0809" || gModelData.gCate4 == "0812" || gModelData.gCate4 == "0802" || gModelData.gCate4 == "0814" || gModelData.gCate4 == "0806" || gModelData.gCate4 == "0807" || gModelData.gCate4 == "0803" || gModelData.gCate4 == "0804" || gModelData.gCate4 == "1654") {
                                prodCate.catePromise.cos().then(prodCate.prodCateView.cos);
                            }

                            if (gModelData.gCate4 == "1201" || gModelData.gCate4 == "1202") {
                                prodCate.catePromise.furniture().then(prodCate.prodCateView.furniture);
                            }

                            if (gModelData.gCate4 == "0304" || gModelData.gCate4 == "0305") {
                                prodCate.catePromise.mobile().then(prodCate.prodCateView.mobile);
                            }
                            prodBbs.bbsView();

                            prodQna.qnaPromise.qnaList().then(prodQna.qnaView);

                            prodReview.reviewPromise.zum().then(prodReview.prodReviewZum);
                            prodReview.reviewPromise.knowcom().then(prodReview.prodReviewKnow);

                            prodRecomm.recommPromise().then(function (result) {
                                prodRecomm.prodRecommViewTable(result);
                                prodRecomm.prodRecommViewList(result);
                            });

                            if (!gModelData.gCompare) {
                                _context.next = 37;
                                break;
                            }

                            _context.next = 37;
                            return prodCompSpec.prodCompspecViewTab();

                        case 37:

                            prodDesc.descPromise().then(prodDesc.prodDescView).finally(function () {
                                if (focusName == "bbs") {
                                    setTimeout(function () {
                                        $(window).scrollTop($("#prodReview").offset().top - $(".prodtabinfo").outerHeight() - $(".prodtab").outerHeight() - 32);
                                    }, 1000);
                                }
                            });

                            $(".comm-loader").hide();

                        case 39:
                        case "end":
                            return _context.stop();
                    }
                }
            }, _callee, undefined);
        }));

        return function init() {
            return _ref.apply(this, arguments);
        };
    }();

    var prodModelInitPromise = function prodModelInitPromise() {
        return new Promise(function (resolve, reject) {
            $.ajax({
                type: "post",
                url: "/wide/api/product/prodInit.jsp",
                data: { "modelno": gModelData.gModelno },
                dataType: "json",
                success: function success(response) {
                    resolve(response);
                }, error: function error(_error) {
                    reject(_error);
                }
            });
        });
    };
    var prodModelInitView = function prodModelInitView(json) {
        if (json.success) {
            Object.assign(gModelData, json.data.gModelData);
            history.replaceState(null, null, "/detail.jsp?modelno=" + gModelData.gModelno); //주소강제 변환
            //메타데이터
            if (json.data.gMetaData) {
                var gMetaData = json.data.gMetaData;

                $("title").text(gMetaData.metaTitle);

                $("meta[name=description]").attr('content', gModelData.gModelNmView + " \uCD5C\uC800\uAC00 - " + gMetaData.metaKeyword);
                $("meta[name=keywords]").attr('content', gModelData.gModelNmView + " \uCD5C\uC800\uAC00 - " + gMetaData.metaKeyword);

                $("meta[property='og:title']").attr('content', gMetaData.metaCateName);
                $("meta[property='twitter:title']").attr('content', gMetaData.metaCateName);
                $("meta[property='me2:title']").attr('content', gMetaData.metaCateName);

                $("meta[property='og:description']").attr('content', gModelData.gModelNmView);
                $("meta[property='twitter:description']").attr('content', gModelData.gModelNmView);
                $("meta[property='me2:description']").attr('content', gModelData.gModelNmView);
            }
            if (json.data.gModelData.gSpecList) {

                var specHtml = "";
                var specList = json.data.gModelData.gSpecList;
                if (specList != null) {
                    var specContentView = "";
                    var specTitleView = "";
                    var liCnt = 0;
                    for (var i = 0; i < specList.length;) {
                        var specCellcnt = specList[i].cellcnt;
                        if (liCnt % 5 == 0) {
                            specHtml += "<ul class=\"swiper-slide specswipe__item\">";
                        }
                        if (specCellcnt > 1) {
                            var j = 0;
                            specTitleView = specList[i].title;
                            specContentView = "";
                            for (j = 0; j < specCellcnt; j++) {
                                if (j > 0) specContentView += ",";

                                specContentView += specList[i + j].content;
                            }
                            i += j;
                        } else {
                            specContentView = specList[i].content;
                            specTitleView = specList[i].title;
                            i++;
                        }
                        specHtml += "<li>\n                                <span class=\"tx_spec\">" + specTitleView + "</span>\n                                <span class=\"tx_detail\">" + specContentView + "</span>\n                               </li>";
                        liCnt++;
                        if (liCnt % 5 == 0) {
                            specHtml += "</ul>";
                        }
                    }
                    $("#prod_summary_left").find(".proddetail__spec .swiper-wrapper").html(specHtml);
                }
            }
            var thumHtml = "<li class=\"swiper-slide\"><button type=\"button\" class=\"btn btn--modal\"><img src=\"" + gModelData.gImageUrl + "\" alt=\"" + gModelData.gModelNmView + "\" /></button></li>";
            if (json.data.gModelData.gVideoList) {
                var gVideoList = json.data.gModelData.gVideoList;
                $.each(gVideoList, function (index, listData) {
                    var strSource = listData.video_url;
                    var strVideoThum = "";
                    if (strSource.indexOf("youtu.be") > 0 || strSource.indexOf("youtube") > 0) {
                        var srcIndex = strSource.lastIndexOf("/");
                        var descIndex = 0;
                        if (strSource.lastIndexOf("?list") > 0) {
                            descIndex = strSource.lastIndexOf("?list");
                        } else if (strSource.lastIndexOf("?autoplay") > 0) {
                            descIndex = strSource.lastIndexOf("?autoplay");
                        } else {
                            descIndex = strSource.length;
                        }
                        strVideoThum = strSource.substring(srcIndex + 1, descIndex);
                    }
                    thumHtml += "<li class=\"swiper-slide has-vod\"><span class=\"dimm\"></span><button type=\"button\" class=\"btn btn--modal\"><img src=\"//img.youtube.com/vi/" + strVideoThum + "/hqdefault.jpg\" alt=\"\" /></button></li>";
                });
            }
            if (json.data.gModelData.gThumNailList) {
                var gThumNailList = json.data.gModelData.gThumNailList;
                $.each(gThumNailList, function (index, listData) {
                    thumHtml += "<li class=\"swiper-slide\"><button type=\"button\" class=\"btn btn--modal\"><img src=\"" + listData + "\" alt=\"" + gModelData.gModelNmView + "\" /></button></li>";
                });
            }
            $("#prod_topfix").find(".prodtabinfo__lt .prod__thum").html("<img src=\"" + gModelData.gImageUrl + "\" alt=\"" + gModelData.gModelNmView + "\" />");
            $("#prod_summary_left").find(".proddetail .thum__slide .swiper-wrapper.thum__list").html(thumHtml);
            $("#prod_summary_left").find(".proddetail .thum__cont .thum__img").html("<img src=\"" + gModelData.gImageUrl + "\" alt=\"" + gModelData.gModelNmView + "\" />");
            //탑픽스, 썸네일,대표 이미지 온에러 처리 
            $("#prod_topfix").find(".prodtabinfo__lt .prod__thum img").on("error", function (e) {
                e.preventDefault();
                replaceImg(this);
            });

            $("#prod_summary_left").find(".proddetail .thum__slide .swiper-wrapper.thum__list img").on("error", function (e) {
                e.preventDefault();
                replaceImg(this);
            });
            $("#prod_summary_left").find(".proddetail .thum__cont .thum__img img").on("error", function (e) {
                e.preventDefault();
                replaceImg(this);
            });

            // 상단요약 좌측 > 이미지 컨트롤
            prodinfoSwipe.update();
            // prodspecSwipe.slideTo(0);
            if ($(".thum__slide .thum__list > li").length > 3) {
                $(".thum__slide").addClass("is-swiper");
            } else {
                $(".thum__slide").removeClass("is-swiper");
            }
            prodspecSwipe.update();
            if ($(".specswipe .specswipe__item > li").length > 5) {
                $(".proddetail__spec").addClass("is-swiper");
                $(".proddetail__spec .swiper-pagination").removeClass('swiper-pagination-hidden');
                $(".proddetail__spec .btn__more").show();
                prodspecSwipe.slideTo(0);
            } else {
                $(".proddetail__spec").removeClass("is-swiper");
                $(".proddetail__spec .swiper-pagination").addClass('swiper-pagination-hidden');
                $(".proddetail__spec .btn__more").hide();
                prodspecSwipe.slideTo(0);
            }

            var $thum_cont = $(".proddetail .thum__cont .thum__img > img"),
                // 썸네일 큰 이미지
            $thum_item = $(".proddetail .thum__list > li"); // 썸네일 작은 이미지 목록
            $thum_item.on("mouseenter", function () {
                var _this = $(this),
                    thumSrc = _this.find("img").attr("src");

                $thum_item.removeClass("is-on");
                _this.addClass("is-on");

                if (_this.hasClass("has-vod")) {
                    // VOD 썸네일일때
                    $thum_cont.closest(".thum__cont").addClass("is-vod");
                } else {
                    $thum_cont.closest(".thum__cont").removeClass("is-vod");
                }
                $thum_cont.attr({ "src": thumSrc });
            }).on("click", function () {
                var __idx = $(this).index(); // 클릭 index
                loadThumNail(gModelData.gModelno, __idx);
                insertLog(24448);
            });

            prodPriceComp.paramHandler.init();
            prodShopPrice.paramHandler.init();
            prodGraph.paramHandler.init();
            prodOption.paramHandler.init();
            prodDesc.paramHandler.init();

            ga('create', 'UA-53076228-1', 'auto');
            ga('require', 'displayfeatures');
            ga('require', 'linkid', 'linkid.js');
            ga('send', 'pageview');

            $("#prod_summary_top").find(".prodinfo .prodinfo__tit").html(gModelData.gModelNmViewTag);
            $("#prod_summary_top").find(".prodinfo .prodinfo__spec").html("  \n        " + (gModelData.gFactory != "" && gModelData.gFactoryCheck ? "<li>\uC81C\uC870\uC0AC: " + gModelData.gFactory + "</li>" : "") + "\n        " + (gModelData.gBrand != "" && gModelData.gBrandCheck ? "<li>\uBE0C\uB79C\uB4DC: " + gModelData.gBrand + "</li>" : "") + "\n        " + (gModelData.gCdateView != "" ? "<li>" + gModelData.gCdateView + "</li>" : "<li>\uB4F1\uB85D\uC77C: " + gModelData.gCdate + "</li>") + "\n        " + (gModelData.gReleasePrice > 0 ? "<li>" + gModelData.gReleaseText + "</li>" : ""));

            //상단 세팅
            if (gModelData.gMinPrice > 0) {

                $("#prod_summary_top").find(".prodminprice .box__line1 .tx_msg").html(" \n            " + (gModelData.gOvsMinPrcYn == "Y" ? "\uC9C1\uAD6C" : "") + "\n            " + (gModelData.gCashShopOnly ? "\uD604\uAE08" : "") + " \uCD5C\uC800\uAC00");

                $("#prod_summary_top").find(".prodminprice .box__line2 .tx_price").html("<em>" + gModelData.gMinPrice.format() + "</em>\uC6D0");
                if (gModelData.gMinPrice > 1000 && gModelData.gRewardRate > 0) {
                    var t = Math.floor(gModelData.gRewardRate * 0.01 * gModelData.gMinPrice / 10) * 10;
                    $("#prod_summary_top").find(".prodminprice .area_noti_savemoney .spSaveMoney").html(t.format() + "\uC801\uB9BD");
                    $("#prod_summary_top").find(".prodminprice .area_noti_savemoney").show();
                    if (gModelData.gMinShopCode == 6641) {
                        $("#prod_summary_top").find(".btn_open_layer_noti_save .appBuyFlag").hide();
                    } else {
                        $("#prod_summary_top").find(".btn_open_layer_noti_save .appBuyFlag").show();
                    }
                } else {
                    $("#prod_summary_top").find(".prodminprice .area_noti_savemoney").hide();
                }
                //fix 세팅
                $("#prod_topfix").find(".prodtabinfo__lt .prod__name").html(gModelData.gModelNmView);
                $("#prod_topfix").find(".prodtabinfo__rt .tx_price").html("\n                        <span class=\"tx_msg\">      \n                                " + (gModelData.gOvsMinPrcYn == "Y" ? "\uC9C1\uAD6C" : "") + "\n                                " + (gModelData.gCashShopOnly ? "\uD604\uAE08" : "") + "\n                                \uCD5C\uC800\uAC00\n                        </span>\n                        <em id=\"detail_minprice\">" + gModelData.gMinPrice.format() + "</em>\uC6D0");
            } else {
                if (gModelData.gCdateView == "출시예정") {
                    $("#prod_exception").html("<p class=\"tx_exception\"><strong>\uCD9C\uC2DC\uC608\uC815</strong> \uC0C1\uD488\uC785\uB2C8\uB2E4.</p>");
                } else {
                    $("#prod_exception").html("<p class=\"tx_exception\"><strong>\uC77C\uC2DC\uD488\uC808</strong> \uC0C1\uD488\uC785\uB2C8\uB2E4.</p>");
                }
            }

            $('#txtURL').text(location.href);

            if (blCriteo) {
                window.criteo_q = window.criteo_q || [];
                window.criteo_q.push({ event: "setAccount", account: 17070 }, { event: "setSiteType", type: "d" }, { event: "viewItem", item: "" + gModelData.gModelno });
            }
            gModelData.blHitBrandCheck ? $(".hit_stamp").show() : $(".hit_stamp").hide();

            _TRK_PN = gModelData.gModelNmView.trim();
            _trk_img_base.src = _trk_make_code("log.enuri.com", "1001");
        }
    };
});