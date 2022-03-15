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
		global.prod_desc = mod.exports;
	}
})(this, function (exports, _prod_common) {
	"use strict";

	Object.defineProperty(exports, "__esModule", {
		value: true
	});
	exports.prodDescView = exports.descPromise = exports.paramHandler = undefined;

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

	var param = {
		"modelno": gModelData.gModelno
	};

	var paramHandler = exports.paramHandler = {
		set: function set(prop, value) {
			param[prop] = value;
			return true;
		},
		get: function get(prop) {
			return param[prop];
		},
		init: function init() {
			param["modelno"] = gModelData.gModelno;
		}
	};
	var descPromise = exports.descPromise = function descPromise() {
		return new Promise(function (resolve, reject) {
			$.ajax({
				type: "post",
				url: "/wide/api/product/prodDesc.jsp",
				data: param,
				dataType: "JSON",
				success: function success(response) {
					resolve(response);
				}, error: function error(_error) {
					reject(_error);
				}
			});
		});
	};

	var prodDescView = exports.prodDescView = function () {
		var _ref = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee(json) {
			var ecatal_out_yn, mall_desc_yn, enuri_desc_yn, enuri_knwocom_guide_yn, enuri_caution, contentHtml, enuri_spec_table, enuri_kc_info, enuri_spec_text, $btnUnfold, $btnFold, $tabs, $tabs_item, $tabCont;
			return regeneratorRuntime.wrap(function _callee$(_context) {
				while (1) {
					switch (_context.prev = _context.next) {
						case 0:
							ecatal_out_yn = json["ecatal_out_yn"];
							mall_desc_yn = json["mall_desc_yn"];
							enuri_desc_yn = json["enuri_desc_yn"];
							enuri_knwocom_guide_yn = json["enuri_knwocom_guide_yn"];
							enuri_caution = json["enuri_caution"];

							if (typeof enuri_caution != "undefined") {
								contentHtml = "";

								if (enuri_caution.content_type == "1") {
									contentHtml = "<div class=\"inner\">";
									if (enuri_caution.content_list.length > 0) {
										enuri_caution.content_list.forEach(function (a) {
											contentHtml += a.content + "<br>";
										});
									}
									contentHtml += "</div>";
									$("#prodDetail").find(".row__prodrelated").removeClass('is-thum');
								} else if (enuri_caution.content_type == "2") {
									contentHtml = "<div class=\"inner\">\n\t\t\t<img src=\"http://storage.enuri.info/pic_upload/caution/" + enuri_caution.img + "\" usemap=\"#Map\" style=\"display:block;width:970px;margin:0 auto\">";
									if (enuri_caution.imgmap_list.length > 0) {
										contentHtml += "<map name=\"Map\">";
										enuri_caution.imgmap_list.forEach(function (v) {
											contentHtml += "<area shape=\"rect\" coords=\"" + v.img_map + "\" href=\"" + v.map_url + "\" target=\"_blank\">";
										});
										contentHtml += "</map>";
									}
									contentHtml += "</div>";

									$("#prodDetail").find(".row__prodrelated").addClass('is-thum');
								}
								$("#prodDetail").find(".row__prodrelated").html(contentHtml);
							} else {
								$('#prodDetail').find(".row__prodrelated").hide();
							}
							$("#prodDetail").find(".tab__list li").removeClass("is-on");
							$("#prodDetail").find(".specdetail .sd__container .sd__cont").removeClass("is-shown");
							$("#prodDetail").find(".section__cont .specdetail .sd__container").removeClass('is-unfold');
							//요약설명 table형태
							enuri_spec_table = json["enuri_spec_table"];
							enuri_kc_info = json["enuri_kc_info"];
							enuri_spec_text = json["enuri_spec_text"];

							enuri_spec_text = enuri_spec_text.replace("&nbsp;&nbsp;/&nbsp;&nbsp;", "/");
							prodDescTableView(enuri_spec_table, enuri_kc_info, enuri_spec_text);
							//탭

							if (!(ecatal_out_yn == "N" && mall_desc_yn == "N" && enuri_desc_yn == "N" && enuri_knwocom_guide_yn == "N")) {
								_context.next = 17;
								break;
							}

							//상세설명이 아무것도 없음
							$('#prodDetail .specdetail').hide();
							return _context.abrupt("return");

						case 17:

							if (ecatal_out_yn == "Y") {
								$('#prodDetail .specdetail').show();
								$('#opt_ecatal_out').show();
							} else {
								$('#opt_ecatal_out').hide();
							}
							if (mall_desc_yn == "Y") {
								$('#prodDetail .specdetail').show();
								$('#opt_mall_desc').show();
							} else {
								$('#opt_mall_desc').hide();
							}

							if (enuri_desc_yn == "Y") {
								$('#prodDetail .specdetail').show();
								$('#opt_enuri_desc').show();
							} else {
								$('#opt_enuri_desc').hide();
							}
							if (enuri_knwocom_guide_yn == "Y") {
								$('#prodDetail .specdetail').show();
								$('#opt_knowcom_guide').show();
							} else {
								$('#opt_knowcom_guide').hide();
							}
							if (ecatal_out_yn == "Y") {
								prodExplainEcatalView(json);
								$('#opt_ecatal_out').addClass("is-on");
								$("#prodDetail").find(".sd__cont").addClass("is-shown");
							} else if (ecatal_out_yn == "N") {
								if (enuri_desc_yn == "Y") {
									prodExplainEnuriView(json);
									$('#opt_enuri_desc').addClass("is-on");
									$("#prodDetail").find(".sd__cont").addClass("is-shown");
								} else if (mall_desc_yn == "Y") {
									prodExplainMallView(json);
									$('#opt_mall_desc').addClass("is-on");
									$("#prodDetail").find(".sd__cont").addClass("is-shown");
								} else if (enuri_knwocom_guide_yn == "Y") {
									prodExplainKnowcomGuideView(json);
									$('#opt_knowcom_guide').addClass("is-on");
									$("#prodDetail").find(".sd__cont").addClass("is-shown");
								}
							}

							/*if(enuri_desc_yn=="Y"){
       	prodExplainEnuriView(json);
       	$('#opt_enuri_desc').addClass("is-on");
       	$("#prodDetail").find(".sd__cont").addClass("is-shown");
       }else if(enuri_desc_yn=="N"){
       	if(ecatal_out_yn=="Y"){
       		prodExplainEcatalView(json);
       		$('#opt_ecatal_out').addClass("is-on");
       		$("#prodDetail").find(".sd__cont").addClass("is-shown");
       	}else if(mall_desc_yn=="Y"){
       		prodExplainMallView(json);
       		$('#opt_mall_desc').addClass("is-on");
       		$("#prodDetail").find(".sd__cont").addClass("is-shown");
              }
       }*/

							if ($("#prodDetail").find(".section__cont .specdetail .sd__container .thum_wrap img").length > 0) {
								$("#prodDetail").find(".section__cont .specdetail .sd__container .thum_wrap img").on("load", function () {
									if ($("#prodDetail").find(".section__cont .specdetail .sd__container .sd__cont.is-shown .inner").height() >= 850) {
										$("#prodDetail").find(".section__cont .specdetail .btn__group").show();
									} else {
										$("#prodDetail").find(".section__cont .specdetail .btn__group").hide();
									}
								});
							} else {
								if ($("#prodDetail").find(".section__cont .specdetail .sd__container .sd__cont.is-shown .inner").height() >= 850) {
									$("#prodDetail").find(".section__cont .specdetail .btn__group").show();
								} else {
									$("#prodDetail").find(".section__cont .specdetail .btn__group").hide();
								}
							}

							$btnUnfold = $("#prodDetail").find(".section__cont .specdetail .btn__unfold"); // 펼치기

							$btnFold = $("#prodDetail").find(".section__cont .specdetail .btn__fold"); // 펼치기

							$btnUnfold.click(function () {
								$(this).parents(".btn__group").siblings('.sd__container').addClass('is-unfold');
							});
							$btnFold.click(function () {
								$(this).parents(".btn__group").siblings('.sd__container').removeClass('is-unfold');
								// 스크롤 이동
								var movPos = $(".specdetail").offset().top + (850 - $(window).height());
								$("html,body").stop(true, false).animate({ "scrollTop": movPos }, "slow");
							});
							// TAB 공통
							$tabs = $("#prodDetail").find(".section__cont .specdetail .tab__list"), $tabs_item = $tabs.find("li"), $tabCont = $("#prodDetail").find(".section__cont .specdetail .sd__cont");

							$tabs_item.click(function () {
								var _this = $(this);
								var _thisId = $(this).attr("id");

								_this.siblings("li").removeClass("is-on");
								_this.addClass("is-on");
								$("#opt_knowcom_guide_swiper").hide();

								if (_thisId == "opt_ecatal_out") {
									ga('send', 'event', 'vip', 'Product_tab', 'Maker');
									prodExplainEcatalView(json);
								} else if (_thisId == "opt_mall_desc") {
									ga('send', 'event', 'vip', 'Product_tab', 'Shop');
									prodExplainMallView(json);
								} else if (_thisId == "opt_enuri_desc") {
									ga('send', 'event', 'vip', 'Product_tab', 'Shopping mall');
									prodExplainEnuriView(json);
								} else {
									ga('send', 'event', 'vip', 'Product_tab', 'Guide');
									prodExplainKnowcomGuideView(json);
								}

								$tabCont.removeClass("is-shown");
								$tabCont.addClass("is-shown");

								$("#prodDetail").find(".section__cont .specdetail .sd__container").removeClass('is-unfold');
								if ($("#prodDetail").find(".section__cont .specdetail .sd__container .thum_wrap img").length > 0) {
									$("#prodDetail").find(".section__cont .specdetail .sd__container .thum_wrap img").on("load", function () {
										if ($("#prodDetail").find(".section__cont .specdetail .sd__container .sd__cont.is-shown .inner").height() >= 850) {
											$("#prodDetail").find(".section__cont .specdetail .btn__group").show();
										} else {
											$("#prodDetail").find(".section__cont .specdetail .btn__group").hide();
										}
									});
								} else {
									if ($("#prodDetail").find(".section__cont .specdetail .sd__container .sd__cont.is-shown .inner").height() >= 850) {
										$("#prodDetail").find(".section__cont .specdetail .btn__group").show();
									} else {
										$("#prodDetail").find(".section__cont .specdetail .btn__group").hide();
									}
								}
							});

						case 29:
						case "end":
							return _context.stop();
					}
				}
			}, _callee, undefined);
		}));

		return function prodDescView(_x) {
			return _ref.apply(this, arguments);
		};
	}();

	var prodDescTableView = function prodDescTableView(enuri_spec_table, enuri_kc_info, enuri_spec_text) {
		if (typeof enuri_spec_table != "undefined" && enuri_spec_table.length > 0) {
			var html = "";
			var thCnt = 0;
			for (var i = 0; i < enuri_spec_table.length;) {
				var specGroupname = enuri_spec_table[i].specGroupname;
				var specTitle = enuri_spec_table[i].specTitle;
				var specContent = enuri_spec_table[i].specContent;
				var specCellcnt = enuri_spec_table[i].specCellcnt;
				var att_kbno = enuri_spec_table[i].att_kbno;
				var att_id = enuri_spec_table[i].att_id;
				var att_el_kbno = enuri_spec_table[i].att_el_kbno;
				var att_el_id = enuri_spec_table[i].att_el_id;

				var tmpContent = "";
				var tmpTitle = "";
				if (specGroupname != "" || i == 0) {
					thCnt = 0;
					html += (i > 0 ? "</table></dd>" : "") + "\n\t\t\t\t\t<dt>" + specGroupname + "</dt>\n\t\t\t\t\t<dd><table class=\"tb__spec\">";
				}

				if (specCellcnt > 1) {
					var j = 0;
					for (j = 0; j < specCellcnt; j++) {
						if (j > 0) tmpContent += ",";
						if (enuri_spec_table[i + j].att_el_kbno > 0) {
							tmpContent += "<a href=\"javascript:void(0)\" class=\"lay__def\" onclick=\"showDicLayer(this);insertLogCate(14523);\" data-kbno=\"" + att_el_kbno + "\" data-attr_id=\"" + enuri_spec_table[i + j].att_id + "\" data-attr_el_id=\"" + enuri_spec_table[i + j].att_el_id + "\">" + enuri_spec_table[i + j].specContent + "</a>";
						} else {
							tmpContent += "" + enuri_spec_table[i + j].specContent;
						}
						tmpTitle = specTitle;
					}
					i += j;
				} else {
					tmpContent = att_el_kbno > 0 ? "<a href=\"javascript:void(0)\" class=\"lay__def\" onclick=\"showDicLayer(this);insertLogCate(14523);\"  data-attr_id=\"" + att_id + "\" data-attr_el_id=\"" + att_el_id + "\">" + specContent + "</a>" : specContent;
					tmpTitle = att_kbno > 0 ? "<a href=\"javascript:void(0)\" class=\"lay__def\" onclick=\"showDicLayer(this);insertLogCate(14523);\"  data-attr_id=\"" + att_id + "\" data-attr_el_id=\"0\">" + specTitle + "</a>" : specTitle;
					i++;
				}

				if (thCnt % 2 == 0) {
					html += "<tr>";
				}
				html += "\t<th>" + tmpTitle + "</th>\n\t\t\t\t\t\t<td>" + tmpContent + "</td>";
				thCnt++;
				if (thCnt % 2 == 0 || i == enuri_spec_table.length) {
					html += "</tr>";
				}
				if (i == enuri_spec_table.length) html += "</table></dd>";
			}
			$("#enuri_spec_table").html(html);
			$("#enuri_spec_table").find(".tb__spec tr").each(function () {
				if ($(this).siblings().length > 0 && $(this).find("td").length % 2 == 1) {
					$(this).find("td").attr("colspan", 3);
				}
			});
		} else {}

		if (typeof enuri_kc_info != "undefined") {
			var _html = "";
			var kcObj = enuri_kc_info.kc_info;
			var cert_name = "";
			var cert_key = "";
			var cert_link = "";
			var isViewCert = "N";
			var isViewSuit = "N";
			//전기용품 안전인증 검사 - 노출 카테고리 일 경우
			if (kcObj.cert_yn != "" && kcObj.cert_yn == "Y") {
				if (kcObj.cert_value != "T" && kcObj.cert_name != "" && kcObj.cert_key != "") {
					// template 가 아닌 경우
					cert_name = kcObj.cert_name;
					cert_key = kcObj.cert_key;
					cert_link = "http://safetykorea.kr/search/searchPop?certNum=" + cert_key + "&menu=search";
				} else {
					cert_name = "안전인증";
					cert_key = "상세 쇼핑몰 참고";
					cert_link = "http://safetykorea.kr/";
				}
				isViewCert = "Y";
			} else {
				isViewCert = "N";
			}

			var suit_key = "";
			var suit_link = "http://rra.go.kr/ko/license/A_c_search.do";
			//적합성 평가 검사 - 노출 카테고리 일 경우
			if (kcObj.suit_yn != "" && kcObj.suit_yn == "Y") {
				if (kcObj.suit_value != "T" && kcObj.suit_key != "") {
					suit_key = kcObj.suit_key;
				} else {
					suit_key = "상세 쇼핑몰 참고";
				}
				isViewSuit = "Y";
			} else {
				isViewSuit = "N";
			}

			_html += "\n\t\t<dt><i class=\"ico ico--kc\"></i>\uC778\uC99D\uC815\uBCF4</dt>\n\t\t<dd>\n\t\t\t<table class=\"tb__spec\">\n\t\t\t\t<tbody>\n\t\t\t\t\t" + (isViewCert == "N" ? "" : "\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t<th>" + cert_name + "</th>\n\t\t\t\t\t\t<td>" + cert_key + " <a href=\"" + cert_link + "\" class=\"btn btn__kc\" target=\"_blank\">\uC778\uC99D\uC815\uBCF4 \uD655\uC778</a></td>\n\t\t\t\t\t</tr>") + "\n\t\t\t\t\t" + (isViewSuit == "N" ? "" : "\t\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t<th>\uC801\uD569\uC131\uD3C9\uAC00\uC778\uC99D<i class=\"ico ico--question\">?</i>\n\t\t\t\t\t\t\t<div class=\"lay-tooltip lay-comm\">\n\t\t\t\t\t\t\t\t<div class=\"lay-comm--head\">\n\t\t\t\t\t\t\t\t\t<strong class=\"lay-comm__tit\">\uC801\uD569\uC131\uD3C9\uAC00\uC778\uC99D</strong>\n\t\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t\t<div class=\"lay-comm--body\">\n\t\t\t\t\t\t\t\t\t<div class=\"lay-comm__inner\">\n\t\t\t\t\t\t\t\t\t\t\uC804\uD30C \uD658\uACBD \uBC0F \uBC29\uC1A1\uD1B5\uC2E0\uB9DD \uB4F1\uC5D0 \uC720\uD574\uB97C \uC904 \uC6B0\uB824\uAC00 \uC788\uB294 \uAE30\uC790\uC7AC\uC5D0 \uD574\uB2F9\uD558\uB294 \uC801\uD569\uC778\uC99D, \uC801\uD569\uB4F1\uB85D \uB610\uB294 \uC7A0\uC815\uC778\uC99D \uC911 \uD558\uB098\uC758 \uC778\uC99D\uC744 \uBC1B\uC544\uC57C \uD569\uB2C8\uB2E4.\n\t\t\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t</th>\n\t\t\t\t\t\t<td>" + suit_key + " <a href=\"" + suit_link + "\" class=\"btn btn__kc\" target=\"_blank\">\uC778\uC99D\uC815\uBCF4 \uD655\uC778</a></td>\n\t\t\t\t\t</tr>") + "\n\t\t\t\t\n\t\t\t\t</tbody>\n\t\t\t</table>\n\t\t</dd>";
			if (isViewCert == "Y") {
				$("#enuri_kc_info").html(_html);
				$("#enuri_kc_info").show();
			} else {
				$("#enuri_kc_info").hide();
			}
		} else {
			$("#enuri_kc_info").hide();
		}
	};
	var prodExplainEcatalView = function prodExplainEcatalView(json) {
		var ecatal_out_src = json["ecatal_out_src"]; //이미지url
		var ecatal_out_from = json["ecatal_out_from"]; //제공 업체명
		var enuri_under19_yn = json["enuri_under19_yn"]; //제공 업체명
		var html = "";
		if (ecatal_out_src.length > 0) {
			html += "<div class=\"inner\">\n\t\t\t\t\t<div class=\"tx_wrap\">\n\t\t\t\t\t\t<p class=\"tx_mall\">\uC81C\uC870\uC0AC : " + ecatal_out_from + "</p> \n\t\t\t\t\t\t<p class=\"tx_noti\">\uBCF8 \uCEE8\uD150\uCE20\uB294 " + ecatal_out_from + "\uC5D0\uC11C \uC81C\uACF5\uBC1B\uC740 \uC815\uBCF4\uC774\uBA70, \uD310\uB9E4 \uAC00\uACA9\uACFC\uB294 \uBB34\uAD00\uD569\uB2C8\uB2E4.</p></div>";
			if (enuri_under19_yn == "Y") {
				html += "<div  class=\"prod--exception-adult\" >\n\t\t\t\t\t\t<div class=\"tx_box\">\n\t\t\t\t\t\t\t<p class=\"tx_exception\">\uBCF8 \uAC74\uD150\uCE20\uB294 \uCCAD\uC18C\uB144 \uC720\uD574 \uB9E4\uCCB4\uBB3C\uB85C\uC11C \uC815\uBCF4\uD1B5\uC2E0\uB9DD \uC774\uC6A9 \uBC0F<br>\uC815\uBCF4\uBCF4\uD638 \uB4F1\uC5D0 \uAD00\uD55C \uBC95\uB960, \uCCAD\uC18C\uB144 \uBCF4\uD638\uBC95 \uADDC\uC815\uC5D0 \uC758\uD558\uC5EC<br>19\uC138 \uBBF8\uB9CC\uC758 \uCCAD\uC18C\uB144\uC774 \uC774\uC6A9\uD560 \uC218 \uC5C6\uC2B5\uB2C8\uB2E4.</p>\n\n\t\t\t\t\t\t\t<ul class=\"btn__list\">\n\t\t\t\t\t\t\t\t<li><a href=\"javascript:void(0);\" class=\"btn btn--black\" onclick=\"$('#lay_adult_wrap').show();\">\uC131\uC778\uC778\uC99D \uD6C4 \uC0AC\uC9C4\uBCF4\uAE30</a></li>\n\t\t\t\t\t\t\t</ul>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t</div>";
			} else {
				html += "<div class=\"thum_wrap\">";
				$.each(ecatal_out_src, function (i, v) {
					html += "<img class=\"listShowImg\" data-original=\"" + v + "\" src=\"" + v + "\" onerror=\"this.src='http://img.enuri.info/images/home/thum_none.jpg'\" >";
				});
				html += "</div>";
			}
			html += "</div>";
			$("#prodDetail").find(".specdetail .sd__container .sd__cont").html(html);
		} else {
			//$("#sdTab1").empty();
			$("#prodDetail").find(".specdetail .sd__container .sd__cont").empty();
		}
		//$("#sdTab1").html(html);
	};
	var prodExplainMallView = function prodExplainMallView(json) {
		var enuri_under19_yn = json["enuri_under19_yn"];
		var mall_desc_plno = json["mall_desc_plno"];
		var mall_desc_shopcd = json["mall_desc_shopcd"];
		var mall_desc_contents = json["mall_desc_contents"].replace("<style", "<!-- style").replace("/style>", "/style -->");
		var mall_desc_shopnm = json["mall_desc_shopnm"];
		var html = "";
		mall_desc_contents = mall_desc_contents.replace(/<STYLE/gi, "<!-- <style").replace(/STYLE>/gi, "style> -->");
		mall_desc_contents = mall_desc_contents.replace(/<LINK/gi, "<!-- <style").replace(/LINK>/gi, "style> -->");
		try {
			if (mall_desc_shopnm && mall_desc_shopnm.length > 0 && mall_desc_contents && mall_desc_contents.length > 0) {
				html += "<div class=\"inner\">\n\t\t\t\t\t\t<div class=\"tx_wrap\">\n\t\t\t\t\t\t\t<p class=\"tx_mall\">\uC774\uBBF8\uC9C0\uC81C\uACF5 : " + mall_desc_shopnm + "</p>\n\t\t\t\t\t\t\t<p class=\"tx_noti shopnoti_1\">\uC5D0\uB204\uB9AC \uAC00\uACA9\uBE44\uAD50\uB294 \uACF5\uAC1C\uB41C \uC790\uB8CC\uB97C \uAE30\uBC18\uC73C\uB85C \uC0C1\uD488\uC815\uBCF4\uB97C \uC81C\uACF5\uD569\uB2C8\uB2E4. \uC1FC\uD551\uBAB0\uC5D0\uC11C \uC81C\uACF5\uD558\uB294 \uC0C1\uD488\uC815\uBCF4\uC640 \uB2E4\uB97C \uC218 \uC788\uC73C\uB2C8, \uAD6C\uB9E4 \uC804 \uC1FC\uD551\uBAB0\uC758 \uC0C1\uD488\uC815\uBCF4\uB97C \uB2E4\uC2DC \uD55C\uBC88 \uD655\uC778\uD574\uC8FC\uC138\uC694. (<a href=\"/etc/disclaimer.jsp\" target=\"_blank\">\uBC95\uC801\uACE0\uC9C0 \uBCF4\uAE30</a>)</p>\n\t\t\t\t\t\t\t<p class=\"tx_noti shopnoti_2\">\uBCF8 \uCEE8\uD150\uCE20\uB294 " + mall_desc_shopnm + " \uC0C1\uC138\uC815\uBCF4 \uBBF8\uB9AC\uBCF4\uAE30 \uC785\uB2C8\uB2E4. <a href=\"javascript:void(0);\" class=\"link_mall\">\uD574\uB2F9 \uC1FC\uD551\uBAB0 \uBC14\uB85C\uAC00\uAE30</a></p>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t" + (enuri_under19_yn == "Y" ? "<div class=\"prod--exception-adult\">\n\t\t\t\t\t\t\t<div class=\"tx_box\">\n\t\t\t\t\t\t\t\t<p class=\"tx_exception\">\uBCF8 \uAC74\uD150\uCE20\uB294 \uCCAD\uC18C\uB144 \uC720\uD574 \uB9E4\uCCB4\uBB3C\uB85C\uC11C \uC815\uBCF4\uD1B5\uC2E0\uB9DD \uC774\uC6A9 \uBC0F<br>\uC815\uBCF4\uBCF4\uD638 \uB4F1\uC5D0 \uAD00\uD55C \uBC95\uB960, \uCCAD\uC18C\uB144 \uBCF4\uD638\uBC95 \uADDC\uC815\uC5D0 \uC758\uD558\uC5EC<br>19\uC138 \uBBF8\uB9CC\uC758 \uCCAD\uC18C\uB144\uC774 \uC774\uC6A9\uD560 \uC218 \uC5C6\uC2B5\uB2C8\uB2E4.</p>\n\n\t\t\t\t\t\t\t\t<ul class=\"btn__list\">\n\t\t\t\t\t\t\t\t\t<li><a href=\"javascript:void(0);\" class=\"btn btn--black\" onclick=\"$('#lay_adult_wrap').show();\">\uC131\uC778\uC778\uC99D \uD6C4 \uC0AC\uC9C4\uBCF4\uAE30</a></li>\n\t\t\t\t\t\t\t\t</ul>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t</div>" : "\t<div class=\"thum_wrap\">" + mall_desc_contents + "</div> ") + "\n\t\t\t\t</div>";
			}
			$("#prodDetail").find(".specdetail .sd__container .sd__cont").html(html);
		} catch (e) {
			$("#prodDetail").find(".specdetail .sd__container .sd__cont").empty();
		}
		if (mall_desc_plno && parseInt(mall_desc_plno) > 0) {
			$('#sdTab2 .tx_noti a.link_mall').click(function () {
				//해당 쇼핑몰 링크
				var bridgeUrl = prodCommon.bridgeUrl('move_link', "" + mall_desc_shopcd, "" + gModelData.gModelno, "" + gModelData.gFactory, "" + mall_desc_plno, "0", "", 1);
				window.open(bridgeUrl);
				return false;
			});
		}
	};
	var prodExplainEnuriView = function prodExplainEnuriView(json) {

		//에누리 상세정보 호출

		//$('#area_enuri_desc').show();
		var load_enuri_desc = true;

		var enuri_under19_yn = json["enuri_under19_yn"]; //성인용품 19금 처리여부
		var html = "<div class=\"inner\">";
		if (enuri_under19_yn == "Y") {
			//19금처리
			html += "\t<div class=\"prod--exception-adult\">\n\t\t\t\t\t\t<div class=\"tx_box\">\n\t\t\t\t\t\t\t<p class=\"tx_exception\">\uBCF8 \uAC74\uD150\uCE20\uB294 \uCCAD\uC18C\uB144 \uC720\uD574 \uB9E4\uCCB4\uBB3C\uB85C\uC11C \uC815\uBCF4\uD1B5\uC2E0\uB9DD \uC774\uC6A9 \uBC0F<br>\uC815\uBCF4\uBCF4\uD638 \uB4F1\uC5D0 \uAD00\uD55C \uBC95\uB960, \uCCAD\uC18C\uB144 \uBCF4\uD638\uBC95 \uADDC\uC815\uC5D0 \uC758\uD558\uC5EC<br>19\uC138 \uBBF8\uB9CC\uC758 \uCCAD\uC18C\uB144\uC774 \uC774\uC6A9\uD560 \uC218 \uC5C6\uC2B5\uB2C8\uB2E4.</p>\n\n\t\t\t\t\t\t\t<ul class=\"btn__list\">\n\t\t\t\t\t\t\t\t<li><a href=\"javascript:void(0);\" class=\"btn btn--black\" onclick=\"$('#lay_adult_wrap').show();\">\uC131\uC778\uC778\uC99D \uD6C4 \uC0AC\uC9C4\uBCF4\uAE30</a></li>\n\t\t\t\t\t\t\t</ul>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t</div>\n\t\t\t\t</div>";
		} else {
			//큰이미지
			var bigImageUrlStr = json["bigimage"];
			var bigimage_webshopnm = json["bigimage_webshopnm"];
			var bigimage_webplno = json["bigimage_webplno"];

			var enuriPcViewYn = json["enuripc_view_yn"];
			var enuripcImgUrl = json["enuripc_img_url"];
			var enuri_spec_table = json["enuri_spec_table"];
			var enuri_spec_text = json["enuri_spec_text"];

			html += " <div class=\"tx_wrap\">";

			if (typeof bigimage_webshopnm != "undefined" && bigimage_webshopnm.length > 0) {
				html += "\t\t\t<p class=\"tx_mall\">\uC774\uBBF8\uC9C0\uC81C\uACF5 : " + bigimage_webshopnm + "</p>";
			}
			html += "\t<p class=\"tx_noti\">\uC5D0\uB204\uB9AC \uAC00\uACA9\uBE44\uAD50\uB294 \uACF5\uAC1C\uB41C \uC790\uB8CC\uB97C \uAE30\uBC18\uC73C\uB85C \uC0C1\uD488\uC815\uBCF4\uB97C \uC81C\uACF5\uD569\uB2C8\uB2E4. \uC1FC\uD551\uBAB0\uC5D0\uC11C \uC81C\uACF5\uD558\uB294 \uC0C1\uD488\uC815\uBCF4\uC640 \uB2E4\uB97C \uC218 \uC788\uC73C\uB2C8, \uAD6C\uB9E4 \uC804 \uC1FC\uD551\uBAB0\uC758 \uC0C1\uD488\uC815\uBCF4\uB97C \uB2E4\uC2DC \uD55C\uBC88 \uD655\uC778\uD574\uC8FC\uC138\uC694. (<a href=\"/etc/disclaimer.jsp\" target=\"_blank\">\uBC95\uC801\uACE0\uC9C0 \uBCF4\uAE30</a>)</p>";

			if (typeof enuri_spec_table != "undefined" && enuri_spec_table.length > 0) {} else if (typeof enuri_spec_text != "undefined" && enuri_spec_text.length > 0) {
				enuri_spec_text = enuri_spec_text.replace("&nbsp;&nbsp;/&nbsp;&nbsp;", "/");
				html += "<div class=\"tx_similarinfo\"><p class=\"tx_sort\"><span>" + enuri_spec_text + "</span></p></div>";
			}
			//사이즈 정보
			var enuri_size = json["enuri_size"];

			if (typeof enuri_size != "undefined" || typeof enuri_cateicon != "undefined") {
				html += "<ul class=\"tx_speclist\">";
				if (typeof enuri_size != "undefined") {
					var g_sizeStrAry = enuri_size.split("^");
					if (g_sizeStrAry.length > 0) {
						$.each(g_sizeStrAry, function (index, listData) {
							html += "<li>" + listData + "</li>";
						});
					}
				}
				if (typeof enuri_cateicon != "undefined") {
					if (enuri_cateicon.length > 0) {
						$.each(enuri_cateicon, function (index, listData) {
							html += "<li><img src=\"" + listData + "\" alt=\"\"></li>";
						});
					}
				}
				html += "</ul>";
			}

			var goods_attribute_certi = json["goods_attribute_certi"];
			var goods_attribute_allergy = json["goods_attribute_allergy"];
			var func_icons = json["enuri_func_icon"];

			if (typeof goods_attribute_certi != "undefined" || typeof goods_attribute_allergy != "undefined" || typeof func_icons != "undefined") {
				html += "<div class=\"flag_box\">";
				html += "\t<ul>";
				if (typeof goods_attribute_certi != "undefined") {
					$.each(goods_attribute_certi, function (Index, listData) {
						var certi_attribute_id = listData["attribute_id"];
						var certi_attribute_element_id = listData["attribute_element_id"];
						var certi_iconno = listData["iconno"];
						var certi_attribute_element = listData["attribute_element"];
						var certi_ref_kb_no = listData["ref_kb_no"];

						if (certi_iconno) {
							html += "<li>";
							if (certi_ref_kb_no > 0) {
								html += "<a href=\"javascript:///\" onclick=\"insertLogCate(14523);showTermDic(" + certi_attribute_id + ", " + certi_attribute_element_id + ", this);\"><span class=\"brup\"></span>";
							}
							html += "<img src=\"http://img.enuri.info/images/f_icon/" + certi_iconno + "_b.gif\" alt=\"" + certi_attribute_element + "\">";
							if (certi_ref_kb_no > 0) {
								html += "</a>";
							}
							html += "</li>";
						}
					});
				}
				//알레르기성분

				if (typeof goods_attribute_allergy != "undefined") {
					$.each(goods_attribute_allergy, function (Index, listData) {
						var allergy_attribute_id = listData["attribute_id"];
						var allergy_attribute_element_id = listData["attribute_element_id"];
						var allergy_iconno = listData["iconno"];
						var allergy_attribute_element = listData["attribute_element"];
						var allergy_ref_kb_no = listData["ref_kb_no"];
						if (allergy_iconno > 0) {
							if (allergy_ref_kb_no > 0) {
								html += "<li><img src=\"http://img.enuri.info/images/f_icon/" + allergy_iconno + "}_b.gif\" alt=\"" + allergy_attribute_element + "\"></li>";
							} else {
								html += "<li><img src=\"http://img.enuri.info/images/f_icon/" + allergy_iconno + "_b.gif\" alt=\"" + allergy_attribute_element + "\"></li>";
							}
						}
					});
				}

				//스펙 아이콘

				if (typeof func_icons != "undefined") {
					$.each(func_icons, function (Index, listData) {
						var func_iconsItem = listData["iconno"];

						if (func_iconsItem > 0) {
							html += "<li><img src=\"http://img.enuri.info/images/f_icon/" + func_iconsItem + "_b.gif\" alt=\"\"></li>";
						}
					});
				}
				html += "\t</ul>";
				html += "</div>";
			}

			//PC견적 이미지 사용 시 이미지 경로 변경 함.
			if (typeof enuriPcViewYn != "undefined" && enuriPcViewYn == "Y" && typeof enuripcImgUrl != "undefined" && enuripcImgUrl.length > 0) {
				bigImageUrlStr = enuripcImgUrl;
			}
			if (typeof bigImageUrlStr != "undefined" && bigImageUrlStr.length > 0) {
				if (typeof bigimage_webshopnm != "undefined" && bigimage_webshopnm.length > 0) {
					var bridgeUrl = prodCommon.bridgeUrl('move_link', '', "" + gModelData.gModelno, "" + gModelData.gFactory, "" + bigimage_webplno, "0", "", 1);
					if (parseInt(bigimage_webplno) > 0) {
						html += "<div class=\"thum_wrap\" style=\"\"><img src=\"" + bigImageUrlStr + "\" style=\"cursor:pointer\" target=\"_blank\" onclick=\"window.open('" + bridgeUrl + "');\" ></div>";
					}
				} else {
					html += "<div class=\"thum_wrap\" style=\"\"><img src=\"" + bigImageUrlStr + "\" ></div>";
				}
			} else {
				html += "<div class=\"thum_wrap\" style=\"\"></div>";
			}
		}
		//
		//상세설명

		var enuri_func_title = json["enuri_func_title"];
		var enuri_func_1 = json["enuri_func_1"];
		var enuri_func_2 = json["enuri_func_2"];
		var enuri_func_3 = json["enuri_func_3"];
		var enuri_func_scrap = json["enuri_func_scrap"];
		var enuri_cm_desc_html = "";
		if (typeof enuri_func_1 == "undefined" && typeof enuri_func_2 == "undefined" && typeof enuri_func_3 == "undefined") {} else {
			enuri_cm_desc_html = "\n\t\t\t<div class=\"cmdetail\" id=\"desc_cm\">\n\t\t\t\t<div class=\"cmdetail__head\">\n\t\t\t\t\t<p class=\"tx_tit\">\uC0C1\uC138\uC124\uBA85</p>\n\t\t\t\t\t<p class=\"tx_sub\">" + (typeof enuri_func_title != "undefined" && enuri_func_title.length > 0 ? "" + enuri_func_title : "") + "</p>\n\t\t\t\t\t" + (enuri_func_scrap && enuri_func_scrap == "Y" ? "<button type=\"button\" class=\"btn btn__share\" style=\"display:none;\" onclick=\"alert('\uC810\uAC80 \uC911\uC785\uB2C8\uB2E4. \uC774\uC6A9\uC5D0 \uBD88\uD3B8\uC744 \uB4DC\uB824 \uC8C4\uC1A1\uD569\uB2C8\uB2E4.');\">\uD37C\uAC00\uAE30</button>" : "") + "\n\t\t\t\t\t<div class=\"lay-cm-share lay-comm\">\n\t\t\t\t\t\t<div class=\"lay-comm--head\">\n\t\t\t\t\t\t\t<strong class=\"lay-comm__tit\">\uCE74\uD0C8\uB85C\uADF8 \uD37C\uAC00\uAE30</strong>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t\t<div class=\"lay-comm--body\">\n\t\t\t\t\t\t\t<div class=\"lay-comm__inner\">\n\t\t\t\t\t\t\t\t<p class=\"tx_msg\">\uC57D\uAD00\uC5D0 \uBA3C\uC800 \uB3D9\uC758\uD558\uC154\uC57C \uCE74\uD0C8\uB85C\uADF8 \uD37C\uAC00\uAE30 \uC774\uC6A9\uC774 \uAC00\uB2A5\uD569\uB2C8\uB2E4.<br>\uD574\uB2F9 \uC800\uC791\uAD8C\uC790\uC758 \uC694\uCCAD\uC774 \uC788\uC744 \uACBD\uC6B0 \uCE74\uD0C8\uB85C\uADF8 \uD37C\uAC00\uAE30 \uC81C\uD55C\uC774 \uC788\uC744 \uC218 \uC788\uC2B5\uB2C8\uB2E4.</p>\n\n\t\t\t\t\t\t\t\t<p class=\"tx_boxtit\">\uCE74\uD0C8\uB85C\uADF8 \uD37C\uAC00\uAE30 \uC774\uC6A9 \uC57D\uAD00</p>\n\t\t\t\t\t\t\t\t<div class=\"box_border\">\n\t\t\t\t\t\t\t\t\t<ol class=\"order-list\">\n\t\t\t\t\t\t\t\t\t\t<li>(\uC8FC)\uC368\uBA38\uC2A4\uD50C\uB7AB\uD3FC\uC740 \uC0C1\uD488\uC815\uBCF4\uC758 \uC815\uD655\uB3C4, \uC81C\uC870\uC0AC \uC0C1\uD45C\uAD8C \uB4F1\uC5D0 \uB300\uD574 \uBC95\uC801\uC778 \uCC45\uC784\uC744 \uC9C0\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.</li>\n\t\t\t\t\t\t\t\t\t\t<li>\uC5D0\uB204\uB9AC \uBB34\uB8CC \uCE74\uD0C8\uB85C\uADF8\uB294 \uBB34\uB2E8 \uC218\uC815 \uBC0F \uC7AC\uBC30\uD3EC\uB97C \uAE08\uC9C0\uD569\uB2C8\uB2E4. \uC704\uBC18\uC2DC \uBC95\uC801\uC778 \uCC45\uC784\uC744 \uC9C0\uAC8C \uB429\uB2C8\uB2E4.</li>\n\t\t\t\t\t\t\t\t\t\t<li>\uD37C\uAC00\uC2E0 \uCE74\uD0C8\uB85C\uADF8\uB294 \uB2F9\uC0AC \uC11C\uBC84\uC5D0 \uB9C1\uD06C\uB418\uC5B4 \uC218\uC2DC \uAC1C\uC120\uB418\uBA70, \uC81C\uD488\uD310\uB9E4\uC2DC\uC5D0\uB294 \uAE30\uAC04 \uC81C\uD55C\uC774 \uC5C6\uC2B5\uB2C8\uB2E4.\n\t\t\t\t\t\t\t\t\t\t\t<ul class=\"order-list--sub\">\n\t\t\t\t\t\t\t\t\t\t\t\t<li>\u2460 \uC624\uD508\uB9C8\uCF13 \uD310\uB9E4\uC790 : \uC81C\uD55C\uC5C6\uC74C(\uC81C\uD488\uD310\uB9E4\uC2DC)</li>\n\t\t\t\t\t\t\t\t\t\t\t\t<li>\u2461 \uC785\uC810\uC804\uBB38\uBAB0 : \uD1F4\uC810\uC77C\uAE4C\uC9C0 (\uD1F4\uC810\uC774\uD6C4 \uC801\uC6A9 \uCE74\uD0C8\uB85C\uADF8 \uC0AD\uC81C)</li>\n\t\t\t\t\t\t\t\t\t\t\t</ul>\n\t\t\t\t\t\t\t\t\t\t</li>\n\t\t\t\t\t\t\t\t\t\t<li>\uACFC\uB2E4 \uD2B8\uB798\uD53D \uBC1C\uC0DD\uC2DC \uB2F9\uC0AC\uB294 \uCD5C\uB300\uD55C \uC815\uC0C1 \uC11C\uBE44\uC2A4\uB97C \uC704\uD574 \uB178\uB825\uD558\uC9C0\uB9CC \uC11C\uBE44\uC2A4\uAC00 \uC77C\uC2DC \uC911\uB2E8\uB420 \uC218\uB3C4 \uC788\uC2B5\uB2C8\uB2E4</li>\n\t\t\t\t\t\t\t\t\t</ol>\n\t\t\t\t\t\t\t\t</div>\n\n\t\t\t\t\t\t\t\t<p class=\"tx_agree\">\n\t\t\t\t\t\t\t\t\t<input type=\"checkbox\" id=\"chkCMSHARE_01\" class=\"input--checkbox-item\"><label for=\"chkCMSHARE_01\">\uC704 \uC57D\uAD00\uC5D0 \uB3D9\uC758\uD569\uB2C8\uB2E4.</label>\n\t\t\t\t\t\t\t\t</p>\n\n\t\t\t\t\t\t\t\t<button id=\"enuri_func_scrap_go\" class=\"lay-comm__btn lay-btn--md lay-btn--color--blue\">\uD37C\uAC00\uAE30</button>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t\t<!-- \uBC84\uD2BC : \uB808\uC774\uC5B4 \uB2EB\uAE30 -->\n\t\t\t\t\t\t<button class=\"lay-comm__btn--close comm__sprite\" onclick=\"$(this).closest('.lay-comm').hide()\">\uB808\uC774\uC5B4 \uB2EB\uAE30</button>\n\t\t\t\t\t</div>\n\t\t\t\t</div>\n\n\t\t\t\t<div class=\"cmdetail__cont\">\n\t\t\t\t\t<ul class=\"cmdetail__list\">\n\t\t\t\t\t\t<li id=\"desc_cm_col1\">" + (typeof enuri_func_1 != "undefined" && enuri_func_1.length > 0 ? "<pre>" + enuri_func_1 + "</pre>" : "") + "</li>\n\t\t\t\t\t\t<li id=\"desc_cm_col2\">" + (typeof enuri_func_2 != "undefined" && enuri_func_2.length > 0 ? "<pre>" + enuri_func_2 + "</pre>" : "") + "</li>\n\t\t\t\t\t\t<li id=\"desc_cm_col3\">" + (typeof enuri_func_3 != "undefined" && enuri_func_3.length > 0 ? "<pre>" + enuri_func_3 + "</pre>" : "") + "</li>\n\t\t\t\t\t</ul>\n\t\t\t\t</div>\n\t\t\t</div>";
		}
		html += enuri_cm_desc_html;

		if (enuri_func_scrap && enuri_func_scrap == "Y") {
			/*$('#enuri_func_scrap_go').click(function() {
   			 if(!$("#chkCMSHARE_01").is(":checked")){
   		alert("카탈로그 퍼가기 이용 약관에 동의하셔야 퍼가기가 가능합니다.");
   	}else if($("#chkCMSHARE_01").is(":checked")){
   		var s_param = {
   			"modelno" : gModelData.gModelno,
   			"userid" : "enuri",
   			"imgtype" : 1,
   			"widthtype" : 1
   		}
   		$.ajax({
   			type : "get",
   			url : "/view/include/catalog/AjaxGetCatalogImage.jsp",
   			async: true,
   			data : s_param,
   			dataType : "html",
   			success: function(json) {
   				var catal_result = json;
   				var varImgUrl = "http://storage.enuri.info/func_info/enuri/"+ImgFolder(gModelData.gModelno)+"/"+gModelData.gModelno+"_1.png";
   				var scrapImageUrl = "<img src='";
   				scrapImageUrl += varImgUrl;
   				scrapImageUrl += "' border='0'/>";
   						callCDNImg(varImgUrl);
   						try {
   					if(window.clipboardData) {
   						window.clipboardData.setData("Text", scrapImageUrl);
   								if(catal_result.indexOf("error")<0 && catal_result.indexOf("ok")>0){
   							alert("카탈로그가 복사되었습니다.\n쇼핑몰 상품 등록창에 CTRL+V 를 해주세요");
   						}else{
   							alert("카탈로그가 복사되었습니다.\n쇼핑몰 상품 등록창에 CTRL+V 를 해주세요\n카탈로그 정보가 업데이트되지 않은 경우 퍼가기를 재실행 해주세요");
   						}
   							}else{
   						// IE 체크 후 아래 로직으로 변경 작업을 하게 되면 크롬에서 복사하는 팝업 뜸
   						//prompt("Ctrl+C를 눌러 카탈로그를 클립보드로 복사하세요.", scrapImageUrl);
   						alert("해당 브라우저에서 지원하지않습니다.");
   					}
   				} catch(e) {
   					alert("해당 브라우저에서 지원하지않습니다. " + e);
   				}
   						$('#enuri_func_ScrapLayer').hide();
   			},
   			error: function (xhr, ajaxOptions, thrownError) {
   				$('#enuri_func_ScrapLayer').hide();
   				//alert(xhr.status);
   				//alert(thrownError);
   			}
   		});
   	}
   	return false; 
   });*/
		}

		var enuri_factory_tel = json["enuri_factory_tel"];
		var enuri_factory_telnm = json["enuri_factory_telnm"];
		var enuri_factory_url1 = json["enuri_factory_url1"];
		var enuri_factory_url1nm = json["enuri_factory_url1nm"];
		var enuri_factory_url2 = json["enuri_factory_url2"];
		var enuri_factory_url2nm = json["enuri_factory_url2nm"];

		var factoryhtml = "";

		if (typeof enuri_factory_tel != "undefined" && enuri_factory_tel.length > 0 && typeof enuri_factory_telnm != "undefined" && enuri_factory_telnm.length > 0) {
			factoryhtml += "<div class=\"partbox\" id=\"desc_factory\">\n\t\t\t\t\t\t\t<div class=\"partbox__inner\">\n\t\t\t\t\t\t\t\t<p class=\"tx_tit\">" + enuri_factory_telnm + " <em>TEL. " + enuri_factory_tel + "</em></p>";
			if (typeof enuri_factory_url1 != "undefined" && enuri_factory_url1.length > 0 && typeof enuri_factory_url1nm != "undefined" && enuri_factory_url1nm.length > 0) {
				factoryhtml += "<a href=\"" + enuri_factory_url1 + "\" target=\"_blank\" title=\"\uC0C8 \uCC3D\uC5D0\uC11C \uC5F4\uB9BD\uB2C8\uB2E4.\" class=\"tx_link\">" + enuri_factory_url1nm + "</a>";
			}
			if (typeof enuri_factory_url2 != "undefined" && enuri_factory_url2.length > 0 && typeof enuri_factory_url2nm != "undefined" && enuri_factory_url2nm.length > 0) {
				factoryhtml += "<a href=\"" + enuri_factory_url2 + "\" target=\"_blank\" title=\"\uC0C8 \uCC3D\uC5D0\uC11C \uC5F4\uB9BD\uB2C8\uB2E4.\" class=\"tx_link\">" + enuri_factory_url2nm + "</a>";
			}
			factoryhtml += "</div></div>";
		}
		html += factoryhtml;

		//설명서 안내
		var enuri_manual_viewernm = json["enuri_manual_viewernm"];
		var enuri_manual_viewerlink = json["enuri_manual_viewerlink"];
		var enuri_manual = json["enuri_manual"];
		var enuri_manual_factory = json["enuri_manual_factory"];
		var enuri_manual_html = "";
		if (enuri_manual && enuri_manual.length > 0 || enuri_manual_factory && enuri_manual_factory.length > 0) {
			enuri_manual_html += "<div class=\"partbox\" id=\"desc_factory\">\n\t\t\t\t\t\t\t\t<div class=\"partbox__inner\">\n\t\t\t\t\t\t\t\t\t<p class=\"tx_tit\">\uC124\uBA85\uC11C</p>";
			if (enuri_manual && enuri_manual.length > 0) {
				enuri_manual_html += "<a href=\"" + enuri_manual + "\" targer=\"_blank\" class=\"btn btn__link\">\uC124\uBA85\uC11C\uBCF4\uAE30</a>";
			}
			if (enuri_manual_factory && enuri_manual_factory.length > 0) {
				enuri_manual_html += "<a href=\"" + enuri_manual_factory + "\" targer=\"_blank\" class=\"btn btn__link\">\uC81C\uC870\uC0AC \uC124\uBA85\uC11C \uBAA9\uB85D</a>";
			}
			if (enuri_manual_viewernm && enuri_manual_viewernm.length > 0 && enuri_manual_viewerlink && enuri_manual_viewerlink.length > 0) {
				enuri_manual_html += "\t<span class=\"tx_alert\">\uC124\uBA85\uC11C\uAC00 \uC548 \uBCF4\uC774\uC2DC\uBA74 <a href=\"" + enuri_manual_viewerlink + "\" targer=\"_blank\" title=\"\uC0C8 \uCC3D\uC5D0\uC11C \uC5F4\uB9BD\uB2C8\uB2E4.\" class=\"btn btn__acrobat\">" + enuri_manual_viewernm + "</a>\uB97C \uC124\uCE58\uD574\uC8FC\uC138\uC694</span>";
			}
		}
		html += enuri_manual_html;

		html += "</div>";
		$("#prodDetail").find(".specdetail .sd__container .sd__cont").html(html);
	};
	var prodExplainKnowcomGuideView = function prodExplainKnowcomGuideView(json) {
		var enuri_knowcom_guide = json.enuri_knowcom_guide;

		var html = "";
		var swiper_html = "";
		var enuri_knowcom_guide_kbno = 0;
		if (enuri_knowcom_guide.length > 0) {
			html += "<div class=\"inner\">\n\t\t\t\t\t<div class=\"tx_wrap\">\n\t\t\t\t\t<p class=\"tx_noti\">\n\t\t\t\t\t\t\uBCF8 \uC81C\uC791 \uC790\uB8CC\uC758 \uC800\uC791\uAD8C\uC740 \uC5D0\uB204\uB9AC[\u321C\uC368\uBA38\uC2A4\uD50C\uB7AB\uD3FC]\uC5D0 \uC788\uC2B5\uB2C8\uB2E4. \uBB34\uB2E8 \uBCF5\uC81C \uBC0F \uAC00\uACF5, \uC0AC\uC6A9\uC2DC \uBC95\uC5D0 \uC758\uD55C \uCC98\uBC8C\uC744 \uBC1B\uC744 \uC218 \uC788\uC2B5\uB2C8\uB2E4.<br>\n\t\t\t\t\t\tCopyright \u24D2 SummercePlatform Inc. All rights reserved.\n\t\t\t\t\t</p>";
			html += "\t<div class=\"thum_wrap\">";
			html += enuri_knowcom_guide[0].kb_content;
			enuri_knowcom_guide_kbno = enuri_knowcom_guide[0].kb_no;
			html += "\t</div>";
			html += "</div>";

			$.each(enuri_knowcom_guide, function (i, v) {
				if (enuri_knowcom_guide_kbno == v.kb_no) return true;
				swiper_html += "<div class=\"swiper-slide\">\n\t\t\t\t\t\t\t\t<a href=\"/knowcom/detail.jsp?kbno=" + v.kb_no + "\" target=\"_blank\">\n\t\t\t\t\t\t\t\t\t<div class=\"buy_info_thumbsnail_img\">";
				if (v.rp_thumbnail_img_url && i > 0) {
					swiper_html += "<img src=\"" + v.rp_thumbnail_img_url + "\" />";
				} else if (v.mo_img) {
					swiper_html += "<img src=\"" + v.mo_img + "\" />";
				} else if (v.rss_thumbnail) {
					swiper_html += "<img src=\"" + v.rss_thumbnail + "\" />";
				} else if (v.kb_thumbnail_img) {
					swiper_html += "<img src=\"" + v.kb_thumbnail_img + "\" />";
				} else if (v.mo_img2) {
					swiper_html += "<img src=\"" + v.mo_img2 + "\" />";
				} else if (v.kb_thumbnail) {
					swiper_html += "<img src=\"" + v.kb_thumbnail + "\" />";
				}
				swiper_html += "</div>\n\t\t\t\t\t\t\t\t\t<div class=\"buy_info_tit\">" + v.kb_title + "</div>\n\t\t\t\t\t\t\t\t</a>\n\t\t\t\t\t\t\t</div>";
			});
			if (swiper_html.length > 0) {
				if (enuri_knowcom_guide.length < 3) {
					swiper_html += "<div class=\"swiper-slide\">\n\t\t\t\t\t\t\t\t\t<div class=\"nolist\">\n\t\t\t\t\t\t\t\t\t\t<img src=\"//img.enuri.info/images/sample/sample_nothing@s104x30.png\">\n\t\t\t\t\t\t\t\t\t\t<span class=\"nolist_txt\">\uC900\uBE44\uC911\uC785\uB2C8\uB2E4.</span>\n\t\t\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t\t</div>";
				}
				swiper_html = "<div class=\"swiper-wrapper\">" + swiper_html + "</div>";
				if (enuri_knowcom_guide.length > 2) {
					swiper_html += "<button type=\"button\" class=\"btn-swiper btn-swiper-prev\">\uC774\uC804</button>\n\t\t\t\t\t\t\t\t<button type=\"button\" class=\"btn-swiper btn-swiper-next\">\uB2E4\uC74C</button>";
				}
				$("#opt_knowcom_guide_swiper").find(".buy_info_swiper").html(swiper_html);
				$("#opt_knowcom_guide_swiper").show();
				$("#opt_knowcom_guide_swiper").find(".buy_info_swiper .swiper-slide").on("click", function () {
					ga('send', 'event', 'vip', 'Product_tab', 'Guide_list');
					insertLogCate(26228);
				});
			}
			$("#prodDetail").find(".specdetail .sd__container .sd__cont").html(html);
			var a = new Swiper('#opt_knowcom_guide_swiper .buy_info_swiper', {
				loop: false,
				slidesPerView: 2,
				initialSlide: 0,
				loopAdditionalSlides: 1,
				spaceBetween: 0,
				prevButton: '.buy_info_swiper .btn-swiper-prev',
				nextButton: '.buy_info_swiper .btn-swiper-next',
				paginationClickable: false,
				slideToClickedSlide: true
			});
		} else {
			$("#prodDetail").find(".specdetail .sd__container .sd__cont").empty();
		}
	};
});