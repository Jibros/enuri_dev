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
        global.prod_qna = mod.exports;
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

    var param = {
        modelno: gModelData.gModelno,
        ca_code: gModelData.gCategory,
        page: 1,
        type: "CL",
        title: "",
        content: ""
    };
    var paramHandler = exports.paramHandler = {
        set: function set(prop, value) {
            if (prop != "page") {
                param["page"] = 1;
            }
            param[prop] = value;
            qnaPromise.qnaList().then(qnaView);
            return true;
        },
        get: function get(prop) {
            return param[prop];
        }
    };
    var qnaPromise = exports.qnaPromise = {
        qnaList: function qnaList() {
            param.type = "CL";
            param.modelno = gModelData.gModelno;

            return new Promise(function (resolve, reject) {
                $.ajax({
                    type: "POST",
                    url: "/wide/api/product/prodQna.jsp",
                    data: param,
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
        qnaInsert: function qnaInsert() {
            var title = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : "";
            var content = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : "";

            if (title == "" || content == "") {
                alert("제목 또는 내용을 입력 후 등록해주시기 바랍니다.");
                return;
            } else if (title.length > 50) {
                alert("제목은 최대 50자까지 가능합니다.");
                return;
            }

            param.type = "CI";
            param.title = title;
            param.content = content;

            return new Promise(function (resolve, reject) {
                $.ajax({
                    type: "POST",
                    data: param,
                    url: "/wide/api/product/prodQna.jsp",
                    dataType: "JSON",
                    success: function success(result) {
                        resolve(result);
                        $('#inputCMQNA_01,#inputCMQNA_02').val("");
                        $('#QNAWRITELAYER').hide();
                    },
                    error: function error(err) {
                        reject(err);
                    }
                });
            });
        }
    };

    var qnaView = exports.qnaView = function qnaView(json) {
        if (json.success) {
            var html = "";
            if (json.total > 0) {
                var qnaList = json.data.cm_qna_list;
                if (qnaList.length > 0) {
                    $("#prodQnA").find(".cmqna .cmqna__cont .no-data").hide();
                    $.each(qnaList, function (index, listData) {
                        var userid = listData.userid;
                        var kb_nickname = listData.kb_nickname;
                        var kb_content = listData.kb_content;
                        var kb_no = listData.kb_no;
                        var kb_parent_no = listData.kb_parent_no;
                        var sns_dcd = listData.sns_dcd;
                        var kb_regdate = listData.kb_regdate;
                        var kb_title = listData.kb_title;
                        var kb_rownum = listData.kb_rownum;
                        var pro_reply = listData.pro_reply;
                        var pro_replyYN = listData.pro_replyYN;
                        var useridView = userid;

                        if (sns_dcd != "" && kb_nickname != "" && (sns_dcd == "N" || sns_dcd == "K")) {
                            if (kb_nickname.length > 2) {
                                useridView = kb_nickname.substring(0, 2) + "****";
                            } else {
                                useridView = kb_nickname + "****";
                            }
                        }

                        html += "    <tr>\n                                    <td>" + kb_rownum + "</td>\n                                    <td class=\"tx_stat\">\n                                    " + (pro_replyYN == "Y" ? "<span class=\"badge badge--complete\">\uB2F5\uBCC0\uC644\uB8CC</span>" : "<span class=\"badge\">\uB2F5\uBCC0\uB300\uAE30</span>") + "\n                                    </td>\n                                    <td class=\"tx_cont\" data-idx=\"" + index + "\"><button type=\"button\">" + kb_title + "</button></td>\n                                    <td>" + useridView + "</td>\n                                    <td>" + kb_regdate + "</td>\n                                </tr>";
                    });
                    $('#tabQna em').text("(" + json.total + ")");
                }

                $("#prodQnA").find(".cmqna .cmqna__cont .cmqna__table tbody").html(html);
                $("#prodQnA").find(".cmqna .cmqna__cont .cmqna__table").show();
                $("#prodQnA").find(".cmqna .cmqna__cont .cmqna__table .tx_cont").click(function () {
                    insertLog(18636);
                    qnaContentsView(qnaList[$(this).data("idx")]);
                });
                fn_paging(paramHandler.get("page"), 10, json.total);

                $("#prodQnA").find(".comm__paging ul li").unbind().click(function () {
                    var page = $(this).data("page");
                    paramHandler.set("page", page);
                });
            } else {
                $('#tabQna em').text("");
                $("#prodQnA").find(".cmqna .cmqna__cont .no-data").show();
                $("#prodQnA").find(".cmqna .cmqna__cont .cmqna__table").hide();
            }

            $('#prodQnA .btn__question').click(function () {
                if (!islogin()) {
                    alert("로그인을 하시면 글을 작성할 수 있습니다.");
                    Cmd_Login('');
                    return;
                } else {
                    insertLog(18635);
                    $('#QNAWRITELAYER').show();
                }
            });

            $('#QNAWRITELAYER .lay-comm__btn-group .lay-btn--color--blue').unbind().click(function () {
                fn_qnaInsert();
            });
        }
    };
    var qnaContentsView = function qnaContentsView(json) {
        console.log(json);
        var html = "";
        var userid = json.userid;
        var kb_nickname = json.kb_nickname;
        var kb_content = json.kb_content;
        var kb_no = json.kb_no;
        var kb_parent_no = json.kb_parent_no;
        var sns_dcd = json.sns_dcd;
        var kb_regdate = json.kb_regdate;
        var kb_title = json.kb_title;
        var kb_rownum = json.kb_rownum;
        var pro_reply = json.pro_reply;
        var pro_replyYN = json.pro_replyYN;

        var useridView = userid;

        if (sns_dcd != "" && kb_nickname != "" && (sns_dcd == "N" || sns_dcd == "K")) {
            if (kb_nickname.length > 2) {
                useridView = kb_nickname.substring(0, 2) + "****";
            } else {
                useridView = kb_nickname + "****";
            }
        }
        html += "<div class=\"dimmed\"></div>\n            <div class=\"lay-cmqna lay-comm\">\n                <div class=\"lay-comm--head\">\n                    <strong class=\"lay-comm__tit\">CM Q&amp;A</strong>\n                </div>\n                <div class=\"lay-comm--body\">\n                    <div class=\"lay-comm--inner\">\n                        <div class=\"line__question\">\n                            <p class=\"tx_tit\">" + kb_title + "</p>\n                            <p class=\"tx_source\">\n                                " + (pro_replyYN == "Y" ? "<span class=\"badge badge--complete\">\uB2F5\uBCC0\uC644\uB8CC</span>" : "<span class=\"badge\">\uB2F5\uBCC0\uB300\uAE30</span>") + "\n                                <span class=\"user\">" + useridView + "</span>\n                                <span>" + kb_regdate + "</span>\n                            </p>\n\n                            <p class=\"tx_sub\">" + kb_content + "</p>\n                        </div>\n\n                        <div class=\"line__answer\">\n                        " + (pro_replyYN == "Y" ? " " + pro_reply.kb_content : "<p class=\"tx_wait\">\uB2F5\uBCC0 \uB300\uAE30\uC911\uC785\uB2C8\uB2E4.</p>") + "\n                        </div>\n                    </div>\n                </div>\n                <!-- \uBC84\uD2BC : \uB808\uC774\uC5B4 \uB2EB\uAE30 -->\n                <button class=\"lay-comm__btn--close comm__sprite\" onclick=\"$(this).closest('.lay--dimm-wrap').hide()\">\uB808\uC774\uC5B4 \uB2EB\uAE30</button>\n            </div>";
        $('#QNAVIEWLAYER').html(html);
        $('#QNAVIEWLAYER').show();
    };
    /* 페이징 처리 */
    var fn_paging = function fn_paging(pageNum, pageSize, pageCnt) {
        var pHtml = "";
        var startPage = parseInt(pageNum / 10) * 10;
        var totalPage = pageCnt / pageSize;
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
        $("#prodQnA").find(".comm__paging ul").html(pHtml);
        $("#prodQnA").find(".comm__paging").show();
    };

    var fn_qnaInsert = function () {
        var _ref = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee() {
            return regeneratorRuntime.wrap(function _callee$(_context) {
                while (1) {
                    switch (_context.prev = _context.next) {
                        case 0:
                            _context.next = 2;
                            return qnaPromise.qnaInsert($('#inputCMQNA_01').val(), $('#inputCMQNA_02').val());

                        case 2:
                            _context.next = 4;
                            return qnaPromise.qnaList().then(qnaView);

                        case 4:
                        case "end":
                            return _context.stop();
                    }
                }
            }, _callee, this);
        }));

        return function fn_qnaInsert() {
            return _ref.apply(this, arguments);
        };
    }();
});