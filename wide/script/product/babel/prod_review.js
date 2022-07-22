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
        global.prod_review = mod.exports;
    }
})(this, function (exports) {
    "use strict";

    Object.defineProperty(exports, "__esModule", {
        value: true
    });
    exports.prodReviewKnow = prodReviewKnow;
    exports.prodReviewZum = prodReviewZum;
    var pages = {
        table: 1,
        consumables: 1,
        sameSeries: 1,
        buyTogether: 1
    };

    var reviewTitle = gModelData.gModelNmView;

    if (reviewTitle.lastIndexOf("(") > -1) {
        reviewTitle = reviewTitle.substring(0, reviewTitle.indexOf("("));
    }

    if (reviewTitle.lastIndexOf("[") > -1) {
        reviewTitle = reviewTitle.substring(0, reviewTitle.lastIndexOf("["));
    }

    var reviewPromise = exports.reviewPromise = {
        param: {},
        knowcom: function knowcom() {
            var _this = this;

            this.param = {
                modelno: gModelData.gModelno,
                cate: gModelData.gCategory
            };

            return new Promise(function (res, rej) {
                $.ajax({
                    type: "get",
                    url: "/wide/api/product/prodReviewKnow.jsp",
                    data: _this.param,
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
        zum: function zum() {
            var _this2 = this;

            return new Promise(function (res, rej) {
                _this2.param = {
                    modelno: gModelData.gModelno,
                    cate: gModelData.gCategory,
                    modelnm: gModelData.gModelNmView,
                    keyword: encodeURIComponent(gModelData.gModelNm, "UTF-8")
                };

                $.ajax({
                    type: "get",
                    url: "/wide/api/product/prodReviewZum.jsp",
                    data: _this2.param,
                    dataType: "JSON",
                    success: function success(result) {
                        if (result.success) res(result.data);
                    },
                    error: function error(err) {
                        rej(err);
                    }
                });
            });
        }
    };

    function prodReviewKnow(data) {
        var knowArr = data.know_list;
        var $knowcom = $('#prodBlogReview .blogreview');
        var knowHtml = "";

        if (knowArr && knowArr.length > 0) {
            knowArr.forEach(function (obj) {
                knowHtml += "<li>\n                            <a href=\"/knowcom/detail.jsp?kbno=" + obj.kb_no + "\" class=\"thum__link\" target=\"_blank\" onclick=\"insertLog(17550);\">\n                                <img data-original=\"" + obj.thumbnail + "\" src=\"http://img.enuri.info/images/home/thum_none.jpg\" onerror=\"http://img.enuri.info/images/home/thum_none.jpg\" alt=\"\">\n                            </a>\n                            <a href=\"/knowcom/detail.jsp?kbno=" + obj.kb_no + "\" class=\"tx_info\" target=\"_blank\" onclick=\"insertLog(17550);\">\n                                <span class=\"tx_cate\">" + obj.kk_codeNm + "</span>\n                                <span class=\"tx_name\">" + obj.kb_title + "</span>\n                            </a>\n                        </li>";
            });

            $knowcom.find('.blogreview__tit strong').text(reviewTitle + " \uAD00\uB828");
            $knowcom.find('.blogreview__list').html(knowHtml);
            $knowcom.show();
            $("#prodBlogReview").find(".blogreview__list .thum__link img").lazyload({
                placeholder: 'http://img.enuri.info/images/home/thum_none.jpg',
                effect: 'fadeIn',
                effectTime: 2000,
                threshold: 800
            });
        }
    }

    function prodReviewZum(data) {
        var blogArr = data.blog.response;
        var videoArr = data.video.response;
        var $srchResult = $('#prodBlogReview .srchresult');
        var $blog = $("#prodBlogReview .srchresult[data-about='blog']");
        var $blogSrchCnt = $("#prodBlogReview .srchresult[data-about='blog'] .srchresult__cont .srchcnt");
        var $video = $("#prodBlogReview .srchresult[data-about='video']");
        var $videoSrchCnt = $("#prodBlogReview .srchresult[data-about='video'] .srchresult__cont .srchcnt");
        var blogHtml = "";
        var videoHtml = "";
        var blogCnt = 0;
        var blogNoShow = false;

        //블로그
        if (blogArr && blogArr.docs.length > 0) {
            var totalNum = blogArr.numFound;

            blogArr.docs.forEach(function (obj) {
                var createTime = "";

                if (obj.createTime) createTime = obj.createTime.substring(0, 10).replace(/-/g, ".");
                if (obj.channelLink == "http://blog.naver.com/jayulo007" || obj.channelLink == "http://blog.naver.com/walnutbaum" || obj.channelLink == "http://blog.naver.com/sarangmom11" || obj.channelLink == "https://brunch.co.kr/@nimathebride") {
                    blogNoShow = true;
                }
                if (blogCnt < 10 && !blogNoShow) {
                    blogHtml += "<li>\n                            <a href=\"" + obj.wClickLink + "\" class=\"thum__link\" target=\"_blank\" onclick=\"insertLog(14535);\">\n                                <img data-original=\"" + obj.imageThumbnail78x78 + "\" src=\"http://img.enuri.info/images/home/thum_none.jpg\" onerror=\"http://img.enuri.info/images/home/thumb_subst.jpg\" alt=\"\">\n                            </a>\n                            <div class=\"tx_info\">\n                                <a href=\"" + obj.wClickLink + "\" class=\"tx_link\" target=\"_blank\"  onclick=\"insertLog(14535);\">\n                                    <span class=\"tx_name\">" + obj.title[0] + "</span> \n                                    <span class=\"tx_detail\">" + (obj.body ? obj.body[0] : "") + "</span>\n                                </a>                                                    \n                                <ul class=\"tx_util\">\n                                    <li><a href=\"" + obj.key + "\" class=\"tx_url\"  target=\"_blank\">" + obj.key + "</a></li>\n                                    <li>" + createTime + "</li>\n                                </ul>\n                            </div>\n                        </li>";
                    blogCnt++;
                }
                blogNoShow = false;
            });
            $blogSrchCnt.find('.btn__more').attr("href", "http://search.zum.com/search.zum?method=blog&option=accu&query=" + data.keyword + "&cm=tab&co=4");
            $blogSrchCnt.find('.tx_cnt').text("(" + totalNum.format() + ")");
            $srchResult.find('.srchresult__tit strong').eq(0).text(reviewTitle + " \uAD00\uB828");
            $srchResult.find('.vodresult__list').html(blogHtml);
            $blog.show();
            $("#prodBlogReview").find(".srchresult .thum__link img").lazyload({
                placeholder: 'http://img.enuri.info/images/home/thum_none.jpg',
                effect: 'fadeIn',
                effectTime: 2000,
                threshold: 800
            });
        }

        //동영상
        if (videoArr && videoArr.docs.length > 0) {
            var _totalNum = videoArr.numFound;

            videoArr.docs.forEach(function (obj) {
                var createTime = "";

                if (obj.createTime) createTime = obj.createTime.substring(0, 10).replace(/-/g, ".");

                videoHtml += "<li>\n                            <a href=\"" + obj.webLink + "\" class=\"thum__link\" target=\"_blank\" onclick=\"insertLog(14537);\">\n                                <img data-original=\"" + obj.imageThumbnail220x124 + "\" src=\"http://img.enuri.info/images/home/thum_none.jpg\" onerror=\"http://img.enuri.info/images/home/thumb_subst.jpg\" alt=\"\">\n                            </a>\n                            <a href=\"" + obj.webLink + "\" class=\"tx_info\" target=\"_blank\" onclick=\"insertLog(14537);\">\n                                <span class=\"tx_name\">" + obj.title[0] + "</span>\n                            </a>\n                            <ul class=\"tx_util\">\n                                <li>" + createTime + "</li>\n                                <li>Youtube</li>\n                            </ul>\n                        </li>";
            });

            $videoSrchCnt.find('.btn__more').attr("href", "http://search.zum.com/search.zum?method=video&option=accu&query=" + data.keyword + "&cm=tab&co=4");
            $videoSrchCnt.find('.tx_cnt').text("(" + _totalNum.format() + ")");
            $srchResult.find('.srchresult__tit strong').eq(1).text(reviewTitle + " \uAD00\uB828");
            $srchResult.find('.blogresult__list').html(videoHtml);
            $video.show();
            $("#prodBlogReview").find(".srchresult .thum__link img").lazyload({
                placeholder: 'http://img.enuri.info/images/home/thum_none.jpg',
                effect: 'fadeIn',
                effectTime: 2000,
                threshold: 800
            });
        }
    }
});