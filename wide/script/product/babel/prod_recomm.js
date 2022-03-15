(function (global, factory) {
    if (typeof define === "function" && define.amd) {
        define(['exports'], factory);
    } else if (typeof exports !== "undefined") {
        factory(exports);
    } else {
        var mod = {
            exports: {}
        };
        factory(mod.exports);
        global.prod_recomm = mod.exports;
    }
})(this, function (exports) {
    'use strict';

    Object.defineProperty(exports, "__esModule", {
        value: true
    });
    exports.prodRecommViewTable = prodRecommViewTable;
    exports.prodRecommViewList = prodRecommViewList;
    var pages = {
        table: 1,
        consumables: 1,
        sameSeries: 1,
        buyTogether: 1,
        sameBrand: 1,
        diffBrand: 1,
        sameCate: 1
    };

    var totalData = {};

    var recommPromise = exports.recommPromise = function recommPromise() {
        var param = {
            cate: gModelData.gCategory,
            brand: gModelData.gBrand,
            accessoryShowFlag: "false",
            refernum: 0,
            refermodelno: 0,
            modelno: gModelData.gModelno
        };

        $('#prod_consumable').fadeOut();

        return new Promise(function (res, rej) {
            //비동기로 ajax호출
            Promise.all([prodSetData(1), prodSetData(2), prodSetData(3), prodSetData(4), prodSetData(5), prodSetData(6)]).then(function (result) {
                if (!result.includes(false)) {
                    if (totalData.buyTogether.total > 3 || totalData.consumables.total > 3 || totalData.diffBrand.total > 3 || totalData.sameBrand.total > 3 || totalData.sameCate.total > 3 || totalData.sameSeries.total > 3) {
                        res(totalData);
                        $('#prodRecommend').show();
                    } else {
                        $('#tabRecomm').hide();
                    }
                } else {
                    $('#prodRecommend').hide();
                    $('#tabRecomm').hide();
                    rej(result);
                }
            });
        });
    };

    function prodSetData(recomType) {
        var param = {
            cate: gModelData.gCategory,
            brand: gModelData.gBrand,
            accessoryShowFlag: "false",
            refernum: 0,
            refermodelno: 0,
            modelno: gModelData.gModelno,
            recomtype: recomType
        };

        var keyArr = ["consumables", "sameSeries", "buyTogether", "sameBrand", "diffBrand", "sameCate"]; //key

        return new Promise(function (res, rej) {
            $.ajax({
                type: "get",
                url: "/wide/api/product/prodRecommend.jsp",
                data: param,
                dataType: "JSON",
                success: function success(result) {
                    totalData[keyArr[recomType - 1]] = result.data;
                    res(true);
                },
                error: function error(err) {
                    rej(false);
                }
            });
        });
    }

    //본상품전용 소모품 없을때
    var prodHtml2 = "";
    var prodTopCnt = 0;
    var prodTopYn = false;

    //Table형식 추천상품
    function prodRecommViewTable(data) {
        var pageGap = 5;
        var tableData = new Array();
        var $recommSort = $('.recommendprod__head .recommendprod__sort li');
        var logArr = [18641, 18642, 18643];
        var prodCnt = 0;
        var maxPage = 0;

        prodHtml2 = "";
        prodTopCnt = 0;
        prodTopYn = false;

        data.sameBrand.gp_titles && data.sameBrand.gp_titles.length > 2 ? tableData.push(data.sameBrand) : tableData.push({}); //동일 브랜드
        data.diffBrand.gp_titles && data.diffBrand.gp_titles.length > 2 ? tableData.push(data.diffBrand) : tableData.push({}); //다른 브랜드
        data.sameCate.gp_titles && data.sameCate.gp_titles.length > 2 ? tableData.push(data.sameCate) : tableData.push({}); //동일 카테고리

        tableData.forEach(function (obj, idx) {
            if (obj.total > 3) {
                var $recommArea = $('.recommendprod__list').eq(idx);
                var $titleArea = $recommArea.find('.comp_item .tb_compspec');
                var $listArea = $recommArea.find('.comp_prod_list');
                var titlesHtml = "";
                var prodHtml = "";

                var gpnos = new Array();
                //그룹명
                titlesHtml += '<tr><td class="spec_info">\uCD94\uCC9C\uBAA8\uB378 <em>(' + obj.recomgoods_list.length + ')</em></td></tr>\n                            <tr class="row_spec"><td>\uCD5C\uC800\uAC00</td></tr>';

                obj.gp_titles.forEach(function (v) {
                    titlesHtml += '<tr><td class="row_spec">' + v.gp_title + '</td></tr>';
                    gpnos.push(v.gpno);
                });

                //상품
                obj.recomgoods_list.forEach(function (v, i) {
                    prodHtml += '<li data-group="' + (parseInt(i / pageGap) + 1) + '">\n                                <table class="tb_compspec">\n                                    <tbody>\n                                        <tr>\n                                            <td class="spec_info">\n                                                <a href="/detail.jsp?modelno=' + v.modelno + '" class="thum__link" target="_blank" onclick="insertLog(' + logArr[idx] + ');">\n                                                    <span class="thum"><img class="lazy" data-original="' + v.strImageUrl + '" alt="" onerror="this.src=\'http://img.enuri.info/images/home/thum_none.jpg\'"></span>\n                                                    <span class="tx_name">' + v.modelnm + '</span>\n                                                </a>\n                                            </td>\n                                        </tr>\n                                        <tr class="row_spec">\n                                            <td><span class="tx_spec_desc ty_price"><em>' + v.price.format() + '</em>\uC6D0</span></td>\n                                        </tr>';
                    gpnos.forEach(function (a) {
                        var obj = v.gp_detail[a];
                        var attrElement = obj ? obj.attribute_element : "-";

                        prodHtml += '       <tr class="row_spec">\n                                            <td><span class="tx_spec_desc" title="">' + attrElement + '</span></td>\n                                        </tr>';
                    });
                    if (i < 3 && prodTopCnt < 3) {
                        prodHtml2 += '<li class="">\n                                                        <a href="/detail.jsp?modelno=' + v.modelno + '" class="thum__link" onclick="insertLog(24636);"><img src="' + v.strImageUrl + '" alt="" onerror="this.src=\'http://img.enuri.info/images/home/thum_none.jpg\'"></a>\n                                                        <div class="lay__partinfo">\n                                                            <div class="lay__inner">\n                                                                <p class="tx_partname">' + v.modelnm + '</p>\n                                                                <p class="tx_price"><em>' + v.price.format() + '</em>\uC6D0</p>\n                                                            </div>\n                                                        </div>\n                                                    </li>';
                        prodTopCnt++;
                    }
                    prodHtml += '       </tbody>\n                                </table>\n                            </li>';
                });

                $titleArea.find('tbody').html(titlesHtml);
                $listArea.html(prodHtml);
                $recommSort.eq(idx).show();
                $recommArea.find(".comp_prod_list li[data-group='1']").show();
            } else {
                $('.recommendprod__list').eq(idx).hide();
                $recommSort.eq(idx).hide();
            }
        });

        $("#prodRecommend .tb_compspec .lazy").lazyload({
            placeholder: 'http://img.enuri.info/images/home/thum_none.jpg',
            effect: 'fadeIn',
            effectTime: 2000,
            threshold: 800
        });

        var firstIdx = $recommSort.find(':visible').eq(0).parent().index();
        pages.table = 1;
        prodCnt = $('.recommendprod__list').eq(firstIdx).find('.comp_prod_list li').length;
        maxPage = Math.ceil(prodCnt / pageGap);

        $recommSort.removeClass('is-on');
        $recommSort.find(':visible').eq(0).parent().addClass('is-on');

        $('.recommendprod__list').hide();
        $('.recommendprod__list').eq(firstIdx).find('.comp_prod_list li[data-group=1]').show();
        $('.recommendprod__list').eq(firstIdx).show();

        //type 선택
        $recommSort.unbind().click(function () {
            var $prodList = $('.recommendprod__list').eq($(this).index());
            var idx = $(this).index();
            var logArr = [18638, 18639, 18640];

            insertLog(logArr[idx]);

            $recommSort.removeClass('is-on');
            $(this).addClass('is-on');

            $prodList.find('.comp_prod_list li').hide();
            $prodList.find('.comp_prod_list li[data-group=1]').show();

            $('.recommendprod__list').hide();
            $prodList.show();

            pages.table = 1;
            prodCnt = $prodList.find('.comp_prod_list li').length;
            maxPage = Math.ceil(prodCnt / pageGap);

            $("#prodRecommend .tb_compspec .lazy").trigger('appear');
        });

        //next,prev 버튼
        $("#prodRecommend .btn_comp.btn_comp_next, #prodRecommend .btn_comp.btn_comp_prev").unbind().click(function () {
            $(this).siblings('ul').find('li[data-group="' + pages.table + '"]').hide();

            if ($(this).attr("class").indexOf("next") > 0) {
                if (pages.table < maxPage) pages.table++;
            } else {
                if (pages.table > 1) pages.table--;
            }

            $(this).siblings('ul').find('li[data-group="' + pages.table + '"]').show();
            $("#prodRecommend .tb_compspec .lazy").trigger('appear');
        });
    }

    //List형식 추천상품
    function prodRecommViewList(data) {
        var pageGap = 6;
        var listData = new Array();

        listData.push(data.consumables); //소모품
        listData.push(data.sameSeries); //동일 시리즈
        listData.push(data.buyTogether); //함께 살만한

        if (data.sameBrand.gp_titles && data.sameBrand.gp_titles.length < 3) listData.push(data.sameBrand); //동일 브랜드
        if (data.diffBrand.gp_titles && data.diffBrand.gp_titles.length < 3) listData.push(data.diffBrand); //다른 브랜드
        if (data.sameCate.gp_titles && data.sameCate.gp_titles.length < 3) listData.push(data.sameCate); //동일 카테고리

        listData.forEach(function (obj) {
            var $recommBox = null;
            var consumableYn = false;
            var buytogetherYn = false;
            var maxPage = 0;
            var listHtml = "";
            var consumableHtml = "";
            var title = "";
            var subTitle = "";
            var target = "";
            var logNo = 0;

            switch (obj) {
                case data.consumables:
                    title = "본 상품 전용 소모품";
                    subTitle = "본 상품 전용 소모품 또는 호환되는 상품입니다.";
                    target = "consumables";
                    logNo = 14542;
                    break;
                case data.sameSeries:
                    title = "동일 시리즈 상품";
                    subTitle = "본 상품과 동일한 시리즈 상품입니다.";
                    target = "sameSeries";
                    logNo = 14543;
                    break;
                case data.buyTogether:
                    title = "함께 살만한 상품";
                    subTitle = "본 상품과 함께 자주 구매하는 인기상품입니다.";
                    target = "buyTogether";
                    logNo = 14544;
                    break;
                case data.diffBrand:
                    title = "다른 브랜드 인기상품";
                    subTitle = "사람들이 자주 구매하는 인기브랜드 상품입니다.";
                    target = "diffBrand";
                    logNo = 14545;
                    break;
                case data.sameBrand:
                    title = "동일 브랜드 인기상품";
                    subTitle = "본 상품과 동일한 브랜드의 인기 상품입니다.";
                    target = "sameBrand";
                    logNo = 14546;
                    break;
                case data.sameCate:
                    title = "동일 카테고리 인기상품";
                    subTitle = "본 상품과 동일한 카테고리의 인기 상품입니다.";
                    target = "sameCate";
                    logNo = 14547;
                    break;
                default:
                    break;
            }

            $recommBox = $('.recommbox[data-target="' + target + '"]');

            if (title.length > 0 && obj.total > 3) {
                if (target == "consumables") consumableYn = true;
                if (target == "buyTogether") buytogetherYn = true;
                maxPage = Math.ceil(obj.total / pageGap);

                listHtml += '<div class="recommbox__head">\n                            <h3 class="recomm__tit">' + title + '</h3>\n                            <p class="recomm__sub">' + subTitle + '</p>\n                            <p class="recomm__figure"><strong>1</strong>/' + maxPage + '</p>\n                        </div>\n\n                        <div class="recommbox__cont is-first">\n                            <div class="arrows arrows--rect" data-for="' + target + '">\n                                <div class="arrows__inner">\n                                    <button type="button" class="arr arr-prev" >\uC774\uC804</button>\n                                    <button type="button" class="arr arr-next">\uB2E4\uC74C</button>\n                                </div>\n                            </div>\n                            <ul class="recomm__list">';

                obj.recomgoods_list.forEach(function (v, i) {
                    listHtml += '<li data-group="' + (parseInt(i / pageGap) + 1) + '">\n                                <div class="tx_thumb">\n                                    <a href="/detail.jsp?modelno=' + v.modelno + '" class="thum__link" target="_blank" onclick="insertLog(' + logNo + ');"><img class="lazy" data-original="' + v.strImageUrl + '" alt="" onerror="this.src=\'http://img.enuri.info/images/home/thum_none.jpg\'"></a>\n                                    <div class="lay-source">\n                                        <button type="button" class="btn btn--zzim ' + (v.zzim ? 'is--on' : '') + '" onclick="showLayZzim(this,' + v.modelno + ');"></button>\n                                        <button type="button" class="btn btn--comp" onclick="compareProdInput(\'G' + v.modelno + '\');"></button>\n                                    </div>\n                                </div>\n                                <div class="tx_info">\n                                    <a href="/detail.jsp?modelno=' + v.modelno + '" target="_blank" onclick="insertLog(' + logNo + ');">\n                                        <span class="tx_info_nm">' + v.modelnm + '</span>\n                                        <span class="tx_info_price">\n                                            <span class="tx_price_tag">\uCD5C\uC800\uAC00</span>\n                                            <em>' + v.price.format() + '</em>\uC6D0\n                                        </span> \n                                    </a>   \n                                    ' + (v.bbs_num > 0 ? ' <div class="recomm__grade ' + (v.bbs_point_avg > 0 ? 'is-active' : '') + ' ">\n                                                <span class="tx_scope"><i class="ico ico--star"></i> <em>' + v.bbs_point_avg.toFixed(1) + '</em>\uC810</span>\n                                                <span class="tx_cnt">(' + (v.bbs_num > 999 ? '999+' : '' + v.bbs_num) + ')</span>\n                                            </div>          ' : '') + ' \n                                </div>\n                            </li>';
                    if (i < 3 && prodTopCnt < 3 && !buytogetherYn) {
                        prodHtml2 += '<li class="">\n                                                        <a href="/detail.jsp?modelno=' + v.modelno + '" class="thum__link" onclick="insertLog(24636);"><img src="' + v.strImageUrl + '" alt="" onerror="this.src=\'http://img.enuri.info/images/home/thum_none.jpg\'"></a>\n                                                        <div class="lay__partinfo">\n                                                            <div class="lay__inner">\n                                                                <p class="tx_partname">' + v.modelnm + '</p>\n                                                                <p class="tx_price"><em>' + v.price.format() + '</em>\uC6D0</p>\n                                                            </div>\n                                                        </div>\n                                                    </li>';
                        prodTopCnt++;
                    }
                    if (consumableYn && i < 3) {
                        if (i == 0) {
                            consumableHtml += '<div class="pexparts__head">\n                                                <h1 class="pexparts__tit">\uBCF8 \uC0C1\uD488\uC804\uC6A9 \uC18C\uBAA8\uD488</h1>\n                                                <a href="#prodRecommend" class="btn btn__more" onclick="insertLog(23317);">\uB354\uBCF4\uAE30</a>\n                                            </div>\n                                            <div class="pexparts__cont">\n                                                <ul class="pexparts__list">';
                        }
                        consumableHtml += '<li class="">\n                                                        <a href="/detail.jsp?modelno=' + v.modelno + '" class="thum__link" onclick="insertLog(23318);"><img src="' + v.strImageUrl + '" alt="" onerror="this.src=\'http://img.enuri.info/images/home/thum_none.jpg\'"></a>\n                                                        <div class="lay__partinfo">\n                                                            <div class="lay__inner">\n                                                                <p class="tx_partname">' + v.modelnm + '</p>\n                                                                <p class="tx_price"><em>' + v.price.format() + '</em>\uC6D0</p>\n                                                            </div>\n                                                        </div>\n                                                    </li>';

                        if (i == 2) {
                            consumableHtml += '     </ul>\n                                            </div>';
                            prodHtml2 = "";
                        }
                    }
                });
                listHtml += '   </ul>\n                            <button class="adv-search__btn--more">\uB354\uBCF4\uAE30<i class="ico-adv-arr-down lp__sprite"></i></button>\n                            <button class="adv-search__btn--more"  style="display:none">\uB2EB\uAE30<i class="ico-adv-arr-up lp__sprite"></i></button>\n                        </div>';

                if (consumableYn) {
                    $('#prod_consumable').html(consumableHtml).fadeIn();
                }

                $recommBox.html(listHtml);
                $recommBox.show();
                $recommBox.find(".recommbox__cont .recomm__list li[data-group='1']").show();

                if (obj.recomgoods_list.length < 7) {
                    $recommBox.find(".recommbox__cont .recomm__list").siblings('.arrows').hide();
                    $recommBox.find(".recommbox__cont .recomm__list").siblings('.adv-search__btn--more').hide();
                }
            } else {
                $recommBox.hide();
            }

            //함께 찾아본 상품 
            if (consumableYn || !consumableYn && !prodTopYn && prodHtml2.length > 0 && prodTopCnt == 3) {
                if (!consumableYn && !prodTopYn && prodHtml2.length > 0 && prodTopCnt == 3) {
                    var vTmpHtml = "";
                    vTmpHtml += '<div class="pexparts__head">\n                                    <h1 class="pexparts__tit">\uD568\uAED8 \uCC3E\uC544\uBCF8 \uC0C1\uD488</h1>\n                                    <a href="#prodRecommend" class="btn btn__more" onclick="insertLog(24635);">\uB354\uBCF4\uAE30</a>\n                                </div>\n                                <div class="pexparts__cont">\n                                    <ul class="pexparts__list">';
                    vTmpHtml += prodHtml2;
                    vTmpHtml += '</ul></div>';
                    prodHtml2 = vTmpHtml;
                    if ($("#prod_summary_left .inner").height() > $("#prod_summary_right .inner").height() + 107) {
                        $('#prod_consumable').html(prodHtml2).fadeIn();
                    }
                    prodTopYn = true;
                }

                var $exparts = $(".pexparts__list li");
                $exparts.hover(function () {
                    $exparts.removeClass("is-on");
                    $(this).addClass("is-on");
                }, function () {
                    $exparts.removeClass("is-on");
                });

                $('.prodexparts .btn__more').on("click", function (e) {
                    var objPosTop = $('#prodRecommend').offset().top; // 탭 위치 
                    var fixedInfo_H = $(".prodtabinfo").outerHeight(); // fixed된 상품 정보 높이
                    var fixedTab_H = $(".prodtab").outerHeight(); // fixed된 탭 높이

                    $(window).scrollTop(objPosTop - fixedInfo_H - fixedTab_H - 32);

                    e.preventDefault();
                });
            }
        });

        $("#prodRecommend .recommbox .recommbox__cont .lazy").lazyload({
            placeholder: 'http://img.enuri.info/images/home/thum_none.jpg',
            effect: 'fadeIn',
            effectTime: 2000,
            threshold: 800
        });

        //next, prev 버튼
        $("#prodRecommend .arrows__inner .arr-prev,#prodRecommend .arrows__inner .arr-next").unbind().click(function () {
            var $prods = $(this).parents('.arrows--rect').siblings('ul').find('li');
            var prodCnt = $prods.length;
            var maxPage = Math.ceil(prodCnt / pageGap);
            var pageFor = $(this).parents('.arrows--rect').data('for');
            var $recommBox = $(this).parents('.recommbox__cont');

            $(this).parents('.arrows--rect').siblings('ul').find('li[data-group="' + pages[pageFor] + '"]').hide();

            if ($(this).attr("class").indexOf("next") > 0) {
                if (pages[pageFor] < maxPage) {
                    pages[pageFor]++;
                    if ($recommBox.hasClass('is-first')) $recommBox.removeClass('is-first');
                    if (pages[pageFor] == maxPage) $recommBox.addClass('is-end');
                }
            } else {
                if (pages[pageFor] > 1) {
                    pages[pageFor]--;
                    if ($recommBox.hasClass('is-end')) $recommBox.removeClass('is-end');
                    if (pages[pageFor] == 1) $recommBox.addClass('is-first');
                }
            }

            $prods.hide();
            $(this).parents('.recommbox__cont').prev('.recommbox__head').find('.recomm__figure strong').text(pages[pageFor]);
            $(this).parents('.arrows--rect').siblings('ul').find('li[data-group="' + pages[pageFor] + '"]').show();
        });

        //더보기, 닫기 버튼
        $('#prodRecommend .adv-search__btn--more').unbind().click(function () {
            var $recommList = $(this).siblings('.recomm__list');
            var pageFor = $(this).siblings('.arrows--rect').data('for');

            $(this).hide();
            $(this).siblings('.adv-search__btn--more').show();

            if (!$(this).parent().hasClass('is-unfold')) {
                $(this).parent().addClass('is-unfold');
                $(this).parents('.recommbox').find('.recommbox__head .recomm__figure').hide();
                $(this).parent().prev('.recommbox__head').find('.recomm__figure strong').text(1);
                $recommList.find("li").show();
            } else {
                pages[pageFor] = 1;
                $(this).parent().removeClass('is-unfold is-end');
                $(this).parent().addClass('is-first');
                $(this).parents('.recommbox').find('.recommbox__head .recomm__figure').show();
                $recommList.find("li").hide();
                $recommList.find("li[data-group='1']").show();
            }
        });
    }
});