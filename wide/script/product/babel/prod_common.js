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
        global.prod_common = mod.exports;
    }
})(this, function (exports) {
    "use strict";

    Object.defineProperty(exports, "__esModule", {
        value: true
    });
    var bridgeUrl = exports.bridgeUrl = function bridgeUrl(cmd, sCode, mNo, mFactory, iPlNo, sCoupon, showPrice, buycnt, epKey) {
        mFactory = encodeURIComponent(mFactory);
        if (typeof buycnt == "undefined") buycnt = 1;
        if (typeof epKey == "undefined") epKey = "";

        var strMoveTargetUrl = "/move/Redirect.jsp";
        var varTargetUrl = strMoveTargetUrl + "?cmd=" + cmd + "&vcode=" + sCode + "&modelno=" + mNo + "&pl_no=" + iPlNo + "&cate=" + gModelData.gCategory + "&urltype=0&coupon=" + sCoupon + "&from=detail&showPrice=" + showPrice + "&buycnt=" + buycnt + "&referrer=" + enrRefer;
        if (sCode == 536) {
            varTargetUrl = varTargetUrl + "&tempid=" + TMPUSER_ID + "&memberid=" + USER_ID;
        }
        if (epKey != "") {
            varTargetUrl = varTargetUrl + "&ep=y&epkey=" + epKey;
        }

        return varTargetUrl;
    };
    // VIP 엠크로니 배너 교체 작업
    var prodBannerPromise = exports.prodBannerPromise = function prodBannerPromise(type) {
        var rtnHtml = "";
        var bannerUrl = "";

        if (type == "comp") {
            bannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_vip/C2/req?cate=" + gModelData.gCategory.substring(0, 4);
        } else if ("mid") {
            bannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_vip/C1/req?cate=" + gModelData.gCategory.substring(0, 4);
            /*  if (IsAdultAd == "true") {
                 bannerUrl = "http://ad-api.enuri.info/enuri_PC/pc_adult/C1a/req?cate=" + ca_code;
             } */
        } else {}
        $.ajax({
            type: "get",
            url: bannerUrl,
            dataType: "json",
            async: false,
            success: function success(data) {
                var vipGoodsImg = data.IMG1;
                var vipGoodsUrl = data.JURL1;
                var vipGoodsTarget = data.TARGET;
                var vipGoodsAlt = data.ALT;
                if (type == "comp") {
                    if (vipGoodsImg != "" && vipGoodsUrl != "") {
                        rtnHtml = "<li class=\"comprod__item is-bnr--ad\">\n                        <a href=\"" + vipGoodsUrl + "\" target=\"_blank\" class=\"bnr__link\"><img src=\"" + vipGoodsImg + "\" alt=\"" + vipGoodsAlt + "\"></a>\n                    </li>";
                    }
                } else if (type == "mid") {
                    if (vipGoodsImg != "" && vipGoodsUrl != "") {
                        rtnHtml = "<a href=\"" + vipGoodsUrl + "\" target=\"_blank\" class=\"bnr__anchor\">\n                                <img src=\"" + vipGoodsImg + "\" alt=\"" + vipGoodsAlt + "\" />\n                            </a>";
                    }
                }
            }

        });
        if (type == "mid") {
            if (rtnHtml.length > 0) {
                $("#midBanner").html(rtnHtml).show();
            }
        }
        return rtnHtml;
    };

    var declaration = exports.declaration = {
        singoClick: false,
        layerDeclaration: function layerDeclaration(obj) {
            var shopCode = 0;
            var plno = 0;
            var radioHtml = "";

            if (obj) {
                var $comprod__item = obj.parents('.comprod__item');

                shopCode = $comprod__item.data('shopcode');
                plno = $comprod__item.data('plno');

                radioHtml = "<li><input type=\"radio\" id=\"epNew8\" name=\"epNew\" class=\"input--radio-item\" value=\"8\"><label for=\"epNew8\">\uC798\uBABB\uB41C \uC0C1\uD488(\uB2E4\uB978\uC0C1\uD488)</label></li>\n                        <li><input type=\"radio\" id=\"epNew9\" name=\"epNew\" class=\"input--radio-item\" value=\"9\"><label for=\"epNew9\">\uC1FC\uD551\uBAB0 \uC811\uC18D\uBD88\uAC00/\uB2E4\uB978 \uC1FC\uD551\uBAB0</label></li>\n                        <li><input type=\"radio\" id=\"epNew10\" name=\"epNew\" class=\"input--radio-item\" value=\"10\"><label for=\"epNew10\">\uC798\uBABB\uB41C \uAC00\uACA9\uC815\uBCF4</label></li>\n                        <li><input type=\"radio\" id=\"epNew11\" name=\"epNew\" class=\"input--radio-item\" value=\"11\"><label for=\"epNew11\">\uC798\uBABB\uB41C \uBC30\uC1A1\uBE44/\uD61C\uD0DD</label></li>\n                        <li><input type=\"radio\" id=\"epNew12\" name=\"epNew\" class=\"input--radio-item\" value=\"12\"><label for=\"epNew12\">\uD488\uC808/\uC7AC\uACE0\uC5C6\uC74C</label></li>\n                        <li><input type=\"radio\" id=\"epNew13\" name=\"epNew\" class=\"input--radio-item\" value=\"13\"><label for=\"epNew13\">\uCD94\uAC00\uBE44\uC6A9/\uD604\uAE08\uACB0\uC81C \uC694\uAD6C</label></li>\n                        <li><input type=\"radio\" id=\"epNew29\" name=\"epNew\" class=\"input--radio-item\" value=\"29\"><label for=\"epNew29\">\uAE30\uD0C0</label></li>";
            } else {
                radioHtml = "<li><input type=\"radio\" id=\"epNew10\" name=\"epNew\" class=\"input--radio-item\" value=\"10\"><label for=\"epNew10\">\uC798\uBABB\uB41C \uAC00\uACA9\uC815\uBCF4</label></li>\n                        <li><input type=\"radio\" id=\"epNew6\" name=\"epNew\" class=\"input--radio-item\" value=\"6\"><label for=\"epNew6\">\uC798\uBABB\uB41C \uC81C\uC870\uC0AC/\uBE0C\uB79C\uB4DC \uC815\uBCF4</label></li>\n                        <li><input type=\"radio\" id=\"epNew5\" name=\"epNew\" class=\"input--radio-item\" value=\"5\"><label for=\"epNew5\">\uC798\uBABB\uB41C \uC0C1\uD488\uC815\uBCF4/\uC774\uBBF8\uC9C0</label></li>\n                        <li><input type=\"radio\" id=\"epNew7\" name=\"epNew\" class=\"input--radio-item\" value=\"7\"><label for=\"epNew7\">\uC798\uBABB\uB41C \uCE74\uD14C\uACE0\uB9AC</label></li>\n                        <li><input type=\"radio\" id=\"epNew4\" name=\"epNew\" class=\"input--radio-item\" value=\"4\"><label for=\"epNew4\">\uD398\uC774\uC9C0\uC624\uB958(\uC774\uBBF8\uC9C0 \uB9E4\uCE6D /\uAE30\uB2A5\uC624\uB958 \uB4F1)</label></li>\n                        <li><input type=\"radio\" id=\"epNew29\" name=\"epNew\" class=\"input--radio-item\" value=\"29\"><label for=\"epNew29\">\uAE30\uD0C0</label></li>";
            }

            $('#SINGOLAYER .list-form--radio').html(radioHtml);
            $('#SINGOLAYER div.error-report__box').text(gModelData.gModelNm); // 모델명

            $('#SINGOLAYER .lay-comm__btn-group .lay-comm__btn').eq(0).unbind().click(function () {
                $(':radio[name="epNew"]:checked').prop('checked', false);
                $('#inconv_txt').val('');
                $('#chkEmail:checked').prop('checked', false);
                $('#inconv_email').val('');
                $('#SINGOLAYER').hide();
            });

            $('#SINGOLAYER .lay-comm__btn--close').unbind().click(function () {
                $(':radio[name="epNew"]:checked').prop('checked', false);
                $('#inconv_txt').val('');
                $('#chkEmail:checked').prop('checked', false);
                $('#inconv_email').val('');
                $('#SINGOLAYER').hide();
            });

            $('#SINGOLAYER .lay-comm__btn-group .lay-comm__btn').eq(1).unbind().click(function () {
                declaration.goDeclaration(shopCode, plno);
            });

            $('#SINGOLAYER').show();
        },
        goDeclaration: function goDeclaration(shopCode, plno) {
            var strEp = "34";
            var strEp_ch_new = "";
            var param = {
                "cate": gModelData.gCategory,
                "inconv_txt": $("#inconv_txt").val().trim(),
                "http_header": navigator.userAgent + "<BR>" + declaration.getOSInfoStr(),
                "modelno": gModelData.gModelno,
                "shop_code": shopCode,
                "pl_no": plno,
                "inconv_email": $("#inconv_email").val(),
                "ep_ch_new": "",
                "epclass": "",
                "ep_device": 1,
                "ep_site": 1
            };

            if ($(':radio[name="epNew"]').length > 0) {
                if ($(':radio[name="epNew"]:checked').val()) {
                    strEp_ch_new = $(':radio[name="epNew"]:checked').val();
                }
            } else {
                strEp_ch_new = "14";
            }

            if (strEp_ch_new != "") {
                param.ep_ch_new = strEp_ch_new;
            } else {
                alert("신고항목을 선택해주세요");
                $("radio[name=epNew]").eq(0).focus();
                return;
            }

            if (strEp_ch_new != "14") {
                switch (strEp_ch_new) {
                    case "4":
                        strEp = "09";
                        break;
                    case "5":
                        strEp = "10";
                        break;
                    case "6":
                        strEp = "05";
                        break;
                    case "7":
                        strEp = "01";
                        break;
                    case "10":
                        strEp = "08";
                        break;
                    case "29":
                        strEp = "11";
                        break;
                    default:
                        break;
                }
            } else {
                if ($("#inconv_txt").val().trim().length == 0) {
                    alert("오류내용을 입력해 주십시오.");
                    $("#inconv_txt").focus();
                    return;
                }

                if ($("#inconv_txt").val().trim().korlen() > 1000) {
                    alert("500자 이상 입력하실수 없습니다.");
                    $("#inconv_txt").focus();
                    return;
                }
            }

            if (strEp != "") {
                param.epclass = strEp;
            }
            if (!declaration.singoClick) {
                declaration.singoClick = true;
                $.ajax({
                    url: "/include/layer/InsertInconvenience.jsp",
                    data: param,
                    dataType: "text",
                    type: "post",
                    success: function success(result) {
                        if (result.indexOf("ERROR_CNT_OVER") >= 0) {
                            alert("일일 신고 제한 건수인 20 건을 초과했습니다.\n내일 다시 신고 주시기 바랍니다.\n문의: (02)6354-3601(내선:206)");
                        } else {
                            alert(result);
                        }
                        $("#SINGOLAYER").hide();
                        declaration.singoClick = false;
                    }
                });
            } else {
                alert("신고 접수 중 입니다.\n잠시만 기다려 주세요. ");
            }
        },
        getOSInfoStr: function getOSInfoStr() {
            var ua = navigator.userAgent;
            if (ua.indexOf("NT 6.0") != -1) return "Windows Vista/Server 2008";else if (ua.indexOf("NT 5.2") != -1) return "Windows Server 2003";else if (ua.indexOf("NT 5.1") != -1) return "Windows XP";else if (ua.indexOf("NT 5.0") != -1) return "Windows 2000";else if (ua.indexOf("NT") != -1) return "Windows NT";else if (ua.indexOf("9x 4.90") != -1) return "Windows Me";else if (ua.indexOf("98") != -1) return "Windows 98";else if (ua.indexOf("95") != -1) return "Windows 95";else if (ua.indexOf("Win16") != -1) return "Windows 3.x";else if (ua.indexOf("Windows") != -1) return "Windows";else if (ua.indexOf("Linux") != -1) return "Linux";else if (ua.indexOf("Macintosh") != -1) return "Macintosh";else return "";
        }
    };
});