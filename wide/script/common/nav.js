var nav_selname = "";
var caCode = "";
var vSeqNo = 0;

// 네비게이션 호출
function loadNav(cate) {
	if (cate === undefined || cate.length == 0) {
		return;
	}

	// GNB API 호출
	var gnbDataPromise = $.ajax({
		type: "GET",
		url: "/wide/api/new_categoryGNB.jsp",
		dataType: "json",
		data: {
			"category": cate,
		}
	});
	caCode = cate;
	gnbDataPromise.then(drawNav, failNav);
}

// 네비게이션 이동
var vSeqflag = "";
function moveNav(seqno, seqflag) {
	if (seqno === undefined || seqno == 0) {
		return;
	}
	vSeqflag = seqflag;
	// GNB API 호출
	var gnbDataPromise = $.ajax({
		type: "GET",
		url: "/wide/api/new_categoryGNB.jsp",
		dataType: "json",
		data: {
			"seqno": seqno,
			"seqflag": seqflag
		}
	});
	vSeqNo = seqno;
	gnbDataPromise.then(drawNav, failNav);
}


// 네비게이션 그리기
function drawNav(dataObj) {
	// 예외처리
	if (dataObj.success === undefined || !dataObj.success) {
		return;
	}
	//vip 페이지 여부
	var vModelNo = 0;
	if (typeof gModelData !== "undefined") vModelNo = gModelData.gModelno;

	var vDepth1List = new Array();
	var vDepth2List = new Array();
	var vDepth3List = new Array();
	var vDepth4List = new Array();

	var vDepth1SelCateNm = "";
	var vDepth2SelCateNm = "";
	var vDepth3SelCateNm = "";
	var vDepth4SelCateNm = "";

	var vDepth3CateNm = dataObj.data.depth3CateNm;
	var vDepth4CateNm = dataObj.data.depth4CateNm;
	var vDepth5CateNm = dataObj.data.depth5CateNm;

	if (typeof dataObj.data.depth1 != "undefined") vDepth1List = dataObj.data.depth1.list;
	if (typeof dataObj.data.depth2 != "undefined") vDepth2List = dataObj.data.depth2.list;
	if (typeof dataObj.data.depth3 != "undefined") vDepth3List = dataObj.data.depth3.list;
	if (typeof dataObj.data.depth4 != "undefined") vDepth4List = dataObj.data.depth4.list;

	var vOrgCateFlag = false; //true일 때 원카테

	if (vDepth1List === undefined) vOrgCateFlag = true;

	if (typeof dataObj.data.depth1 != "undefined" && dataObj.data.depth1 != "") {
		vDepth1SelCateNm = dataObj.data.depth1.selCateNm;
	}
	if (typeof dataObj.data.depth2 != "undefined" && dataObj.data.depth2 != "") {
		vDepth2SelCateNm = dataObj.data.depth2.selCateNm;
	}
	if (typeof dataObj.data.depth3 != "undefined" && dataObj.data.depth3 != "") {
		vDepth3SelCateNm = dataObj.data.depth3.selCateNm;
	}
	if (typeof dataObj.data.depth4 != "undefined" && dataObj.data.depth4 != "") {
		vDepth4SelCateNm = dataObj.data.depth4.selCateNm;
	}
	var appendTarget = $(".location");
	appendTarget.empty();

	var vHtml = "";

	vHtml += "<ul class=\"location__list\">";
	vHtml += "		<li class=\"location__item\">";
	vHtml += "			<p class=\"location__tit\"> <a href=\"/Index.jsp?fromLogo=Y\"><i class=\"ico-loc-home lp__sprite\">홈</i></a> </p>";
	vHtml += "		</li>";
	vHtml += "		<li class=\"location__item depth1\">";

	if (vDepth1SelCateNm) {
		vHtml += "		<p class=\"location__tit\"> <button class=\"location__btn--cate depth1\">" + vDepth1SelCateNm + "</button> </p>";
	}

	vHtml += "			<div class=\"location__list--extend\">";
	vHtml += "				<div class=\"scroll__box\">";
	vHtml += "					<dl class=\"cate__group\">";
	vHtml += "						<dd class=\"cate__list\">";
	vHtml += "							<ul>";
	if (!vOrgCateFlag) {
		$.each(vDepth1List, function(i, v) {
			vHtml += "							<li data-type=\"navDepth1\" data-seqno=\"" + v.g_seqno + "\" data-cacode=\"" + v.g_cate + "\"" + (v.cateYN == "Y" ? "class='is--selected'" : "") + "><a href=\"javascript:void(0);\" cate=\"" + v.g_cate + "\">" + v.g_name + "</a></li>";
		});
	} else { //원카테일 때
		vHtml += "							<li data-type=\"llcate\" data-cacode=\"02,05,06,24\"" + (vDepth1SelCateNm == "가전/TV" ? "class='is--selected'" : "") + "><a href=\"javascript:void(0);\">가전/TV</a></li>";
		vHtml += "							<li data-type=\"llcate\" data-cacode=\"04,07\"" + (vDepth1SelCateNm == "컴퓨터/노트북/조립PC" ? "class='is--selected'" : "") + "><a href=\"javascript:void(0);\">컴퓨터/노트북/조립PC</a></li>";
		vHtml += "							<li data-type=\"llcate\" data-cacode=\"02,03,22\"" + (vDepth1SelCateNm == "태블릿/모바일/디카" ? "class='is--selected'" : "") + "><a href=\"javascript:void(0);\">태블릿/모바일/디카</a></li>";
		vHtml += "							<li data-type=\"llcate\" data-cacode=\"09\"" + (vDepth1SelCateNm == "스포츠/아웃도어" ? "class='is--selected'" : "") + "><a href=\"javascript:void(0);\">스포츠/아웃도어</a></li>";
		vHtml += "							<li data-type=\"llcate\" data-cacode=\"21\"" + (vDepth1SelCateNm == "공구/자동차" ? "class='is--selected'" : "") + "><a href=\"javascript:void(0);\">공구/자동차</a></li>";
		vHtml += "							<li data-type=\"llcate\" data-cacode=\"12\"" + (vDepth1SelCateNm == "가구/인테리어" ? "class='is--selected'" : "") + "><a href=\"javascript:void(0);\">가구/인테리어</a></li>";
		vHtml += "							<li data-type=\"llcate\" data-cacode=\"15\"" + (vDepth1SelCateNm == "유아/식품/건강" ? "class='is--selected'" : "") + "><a href=\"javascript:void(0);\">유아/식품/건강</a></li>";
		vHtml += "							<li data-type=\"llcate\" data-cacode=\"16\"" + (vDepth1SelCateNm == "생활/주방" ? "class='is--selected'" : "") + "><a href=\"javascript:void(0);\">생활/주방</a></li>";
		vHtml += "							<li data-type=\"llcate\" data-cacode=\"10,16,18,93\"" + (vDepth1SelCateNm == "반려/취미/문구" ? "class='is--selected'" : "") + "><a href=\"javascript:void(0);\">반려/취미/문구</a></li>";
		vHtml += "							<li data-type=\"llcate\" data-cacode=\"14,08\"" + (vDepth1SelCateNm == "패션/화장품" ? "class='is--selected'" : "") + "><a href=\"javascript:void(0);\">패션/화장품</a></li>";
		vHtml += "							<li data-type=\"llcate\" data-cacode=\"14\"" + (vDepth1SelCateNm == "명품관" ? "class='is--selected'" : "") + "><a href=\"javascript:void(0);\">명품관</a></li>";
	}

	vHtml += "							</ul>";
	vHtml += "						</dd>";
	vHtml += "					</dl>";
	vHtml += "				</div>";
	vHtml += "			 </div>";
	vHtml += "		 </li>";

	if (vDepth1SelCateNm.length > 0 && typeof vDepth2SelCateNm == "undefined") { //vDepth2SelCateNm.length == 0 
		vHtml += "		 <li class=\"location__item depth2 is--shown\">"; //is-shown 펼칠 때
	} else {
		vHtml += "		 <li class=\"location__item depth2\">";
	}

	vHtml += "		 	<p class=\"location__tit\"> <button class=\"location__btn--cate depth2 is--shown\">" + (vDepth2SelCateNm ? vDepth2SelCateNm : "선택하세요") + "</button> </p>";
	vHtml += "			<div class=\"location__list--extend\">";
	vHtml += "				<div class=\"scroll__box\">";

	var vBd_Lcate_Nm1 = "";
	var vBdLcateFlag = true;
	$.each(vDepth2List, function(i, v) {
		var vBd_Lcate_Nm2 = v.bd_lcate_nm;
		if (i == 0 || vBd_Lcate_Nm1 != vBd_Lcate_Nm2) {
			
			if (i != 0 && (vBdLcateFlag || vOrgCateFlag)) {
				vHtml += "								</ul>";
				vHtml += "							</dd>";
				vHtml += "					</dl>";
			}
			
			if (typeof v.bd_lcate_nm == "undefined" || (v.bd_lcate_nm.length > 0  && ! v.g_name.length > 0)) {
					vBdLcateFlag = false;
			} else {
				vBdLcateFlag = true;
			}
			
			if (vBdLcateFlag || vOrgCateFlag) {
				vHtml += "					<dl class=\"cate__group\">";
				if (!vOrgCateFlag) {
					vHtml += "						<dt class=\"cate__tit\">" + v.bd_lcate_nm + "</dt>";
				}
				vHtml += "							<dd class=\"cate__list\">";
				vHtml += "								<ul>";
			}
		}
		
		if (vBdLcateFlag || vOrgCateFlag) {
			if (!vOrgCateFlag) {
				var vHtmlTarget = "";
				if (typeof v.g_link !== "undefined" && v.g_link.length > 0 && v.g_link.indexOf("http") > -1) {
					vHtmlTarget = "target=\"_blank\"";
				}
				vHtml += "									<li data-type=\"navDepth2\"  class=\"" + (v.cateYN == "Y" ? "is--selected" : "") + "\" > <a href=\"" + (v.g_link ? "" + v.g_link + "" : "javascript:moveNav(" + v.g_seqno + ", 'depth2Sel');") + " \" " + vHtmlTarget + ">" + v.g_name + "</a> </li>";
			} else {
					vHtml += "									<li data-type=\"navDepth2\"  class=\"" + (v.g_name == vDepth2SelCateNm ? "is--selected" : "") + "\" > <a href=\"" + "/list.jsp?cate=" + v.g_cate + "\">" + v.g_name + "</a> </li>";
			}
			vBd_Lcate_Nm1 = vBd_Lcate_Nm2;
		}
	});

	vHtml += "				</div>";
	vHtml += "			</div>";
	vHtml += "		</li>";

	if (typeof vDepth3List != "undefined") { //vDepth3List.length > 0
		if (vDepth3List.length > 0) {
			if (vDepth1SelCateNm.length > 0 && vDepth2SelCateNm.length > 0 && vDepth3SelCateNm && vSeqflag == "depth2Sel") {
				vHtml += "		<li class=\"location__item depth3 is--shown\">";
			} else {
				vHtml += "		<li class=\"location__item depth3 \">";
			}
			vHtml += "		 	<p class=\"location__tit\"> <button class=\"location__btn--cate\">" + (vDepth3SelCateNm ? vDepth3SelCateNm : "선택하세요") + "</button> </p>";
			vHtml += "			<div class=\"location__list--extend\">";
			vHtml += "				<div class=\"scroll__box\">";
			vHtml += "					<dl class=\"cate__group\">";
			vHtml += "						<dd class=\"cate__list\">";
			vHtml += "							<ul>";
			$.each(vDepth3List, function(i, v) {
				if (!vOrgCateFlag) {
					var vHtmlTarget = "";
					if (typeof v.g_link !== "undefined" && v.g_link.length > 0 && v.g_link.indexOf("http") > -1) {
						vHtmlTarget = "target=\"_blank\"";
					}
					vHtml += "							<li class=\"" + (v.cateYN == "Y" ? "is--selected" : "") + "\" data-type=\"navDepth3\"> <a href=\"" + v.g_link + "\" " + vHtmlTarget + ">" + v.g_name + "</a> </li>";
				} else { //원카테
					vHtml += "							<li class=\"" + (v.g_name == vDepth3SelCateNm ? "is--selected" : "") + "\" data-type=\"navDepth3\"> <a href=\"" + "/list.jsp?cate=" + v.g_cate + "\">" + v.g_name + "</a> </li>";
				}
			});
			vHtml += "							</ul>";
			vHtml += "						</dd>";
			vHtml += "					</dl>";
			vHtml += "				</div>";
			vHtml += "			</div>";
			vHtml += "		</li>";
		} else if (vDepth3CateNm) {
			vHtml += "	<li class=\"location__item\" id=\"li_depth3Text\">";
			if (vDepth4CateNm) { //depth4까지 노출되고 depth3가 원카테일 때 링크 추가
				vHtml += "			<p class=\"location__tit\"><a href=\"" + "/list.jsp?cate=" + (param_cate.length > 4 ? param_cate.substring(0, 6) : param_cate) + "\">" + vDepth3CateNm + "</a></p>";
			} else {
				vHtml += "			<p class=\"location__tit\">" + vDepth3CateNm + "</p>";
			}
			vHtml += "	</li>";
		}
	}

	//depth4 
	if (typeof vDepth4List != "undefined") {
		if (vDepth4List.length > 0) {
			if (vDepth1SelCateNm.length > 0 && vDepth2SelCateNm.length > 0 && vDepth3SelCateNm && vDepth4SelCateNm.length == 0) {
				vHtml += "		<li class=\"location__item depth4 is--shown\">";
			} else {
				vHtml += "		<li class=\"location__item depth4 \">";
			}
			vHtml += "		 	<p class=\"location__tit\"> <button class=\"location__btn--cate\">" + (vDepth4SelCateNm ? vDepth4SelCateNm : "선택하세요") + "</button> </p>";
			vHtml += "			<div class=\"location__list--extend\">";
			vHtml += "				<div class=\"scroll__box\">";
			vHtml += "					<dl class=\"cate__group\">";
			vHtml += "						<dd class=\"cate__list\">";
			vHtml += "							<ul>";
			$.each(vDepth4List, function(i, v) {
				if (!vOrgCateFlag) {
					vHtml += "							<li class=\"" + (v.cateYN == "Y" ? "is--selected" : "") + "\" data-type=\"navDepth4\"> <a href=\"" + "/list.jsp?cate=" + v.g_cate + "\">" + v.g_name + "</a> </li>";
				} else { //원카테
					vHtml += "							<li class=\"" + (v.g_name == vDepth3SelCateNm ? "is--selected" : "") + "\" data-type=\"navDepth4\"> <a href=\"" + "/list.jsp?cate=" + v.g_cate + "\">" + v.g_name + "</a> </li>";
				}
			});
			vHtml += "							</ul>";
			vHtml += "						</dd>";
			vHtml += "					</dl>";
			vHtml += "				</div>";
			vHtml += "			</div>";
			vHtml += "		</li>";
		} else if (vDepth4CateNm) {
			if (vDepth4CateNm) {
				vHtml += "	<li class=\"location__item\" id=\"li_depth4Text\">";
				if (vModelNo > 0) { //vip일 때 a 태그 추가
					vHtml += "			<p class=\"location__tit\"><a href=\"" + "/list.jsp?cate=" + (param_cate.length > 6 ? param_cate.substring(0, 8) : param_cate) + "\">" + vDepth4CateNm + "</a></p>";
				} else {
					vHtml += "			<p class=\"location__tit\">" + vDepth4CateNm + "</p>";
				}
				vHtml += "	</li>";
			}
		}
	}

	if (vDepth5CateNm) {
		vHtml += "	<li class=\"location__item\" id=\"li_depth5Text\">";
		vHtml += "			<p class=\"location__tit\">" + vDepth5CateNm + "</p>";
		vHtml += "	</li>";
	}
	vHtml += "	</ul>";

	appendTarget.html(vHtml);

	if (vDepth5CateNm) { $("#li_depth5Text").addClass("is--selected"); }
	else if (vDepth4CateNm) { $("#li_depth4Text").addClass("is--selected"); }
	else if (vDepth3CateNm) { $("#li_depth3Text").addClass("is--selected"); }

	// LP/VIP 상단 로케이션 
	var $locateItem = $(".location__item"), // 아이템
		$locateItem1 = $(".location__item.depth1"), // 두번째 아이템 
		$locateItem2 = $(".location__item.depth2"), // 두번째 아이템 
		$locateItemExpand = $(".location__item.depth1 .location__list--extend ul li a"); // 첫번째 아이템 선택 

	$locateItem.on("mouseenter", function() {
		$locateItem.removeClass("is--shown");
		$(this).addClass("is--shown");
	}).on("mouseleave", function() {
		$locateItem.removeClass("is--shown");
	});
}

// 네비게이션 API 호출 실패시
function failNav(errorObj) {
	console.log("Nav API Call Fail : " + errorObj.statusText);
}

// 네비게이션 대대카테 클릭 시 (GNB)
$(document).on("click", ".location__item li[data-type=navDepth1] a", function() {
	var vSeqNo = $(this).closest("li").attr("data-seqno");
	if (vSeqNo == 0) {
		return;
	}
	nav_selname = $(this).find("a").text();
	moveNav(vSeqNo, "depth1Sel");
	if($(".vip-page").length) {
		insertLogLSV(26205); // VIP>로컬네비게이션> 대분류 콤보박스 클릭수
	} else {
		insertLogLSV(14207); // LP>로컬네비게이션> 대분류 콤보박스 클릭수
	}
});

// 네비게이션 대대카테 클릭 시 (원카테)
$(document).on("click", ".location__item li[data-type=llcate] ", function() {
	var llCate = $(this).attr("data-cacode");
	if (llCate.length == 0) {
		return;
	}
	nav_selname = $(this).find("a").text();
	loadNav(llCate);
	if($(".vip-page").length) {
		insertLogLSV(26205); // VIP>로컬네비게이션> 대분류 콤보박스 클릭수
	} else {
		insertLogLSV(14207, param_cate); // LP>로컬네비게이션> 대분류 콤보박스 클릭수
	}
});
/*---------------------------------- 개별로그 ------------------------------------------------------*/
$(document).on("click", ".location__list .location__item .location__tit:first a", function() {
	if($(".vip-page").length) {
		insertLogLSV(26204); // VIP>로컬네비게이션> 홈 클릭수
	} else {
		insertLogLSV(14206, param_cate); // LP>로컬네비게이션> 홈 클릭수
	}
});
$(document).on("click", ".location__item li[data-type=navDepth2] a", function() {
	if($(".vip-page").length) {
		insertLogLSV(26206); // VIP>로컬네비게이션> 중분류 콤보박스 클릭수
	} else {
		insertLogLSV(14208, param_cate); // LP>로컬네비게이션> 중분류 콤보박스 클릭수
	}
});
$(document).on("click", ".location__item li[data-type=navDepth3] a, #li_depth3Text a", function() {
	if($(".vip-page").length) {
		insertLogLSV(26207); // VIP>로컬네비게이션> 소분류 콤보박스 클릭수
	} else {
		insertLogLSV(14209, param_cate); // LP>로컬네비게이션> 소분류 콤보박스 클릭수
	}
});
$(document).on("click", "#li_depth4Text a", function() {
	insertLogLSV(26208); // VIP>로컬네비게이션> 미분류 콤보박스 클릭수
});
/*---------------------------------- // 개별로그 ------------------------------------------------------*/