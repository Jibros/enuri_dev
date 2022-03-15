////////////////////////////////////////////////// 구형 저장을 위한 비교 레이어 /////////////////////////////////////////////////////

function setCompZzimOldChkDiv() {
	var groupModelItemsObj = $("#listBodyDiv .oldCompZzimChk");
	var compZzimOldChkDivObj = $("#compZzimOldChkDiv"); 

	groupModelItemsObj.unbind();
	groupModelItemsObj.click(function () {
		compZzimOldChkDivHide();

		var thisObj = $(this);

		if(thisObj.hasClass("chk")) {
			thisObj.removeClass("chk");
			thisObj.addClass("unchk");
		} else {
			thisObj.removeClass("unchk");
			thisObj.addClass("chk");
		}

		var compZzimProdNos = getCheckedCompZzimModelnos();

		if(compZzimProdNos.length>0) compZzimOldChkDivShow(this);

		//insertLogLSV(15039);
	});

	compZzimOldChkDivObj.find(".compBtn").unbind();
	compZzimOldChkDivObj.find(".compBtn").click(function () {
		var compZzimProdNos = getCheckedCompZzimModelnos();
		//consoleLog("compZzimProdNos="+compZzimProdNos);
		//return;
		var compZzimProdNosAry = compZzimProdNos.split(",");
		if(compZzimProdNosAry && compZzimProdNosAry.length>0) {
			for(var i=0; i<compZzimProdNosAry.length; i++) {
				compareProdInput(compZzimProdNosAry[i]);
			}
		}

		compareProdBoxDivOpen();

		compZzimOldChkDivHide();

		//insertLogLSV(15040);
		
		var compareProdBoxDivObj = $("#compareProdBoxDiv");
		// 닫혀있을 경우 다시 열어줌 
		if(compareProdBoxDivObj.hasClass("boxfold")) {
			compareProdBoxDivObj.removeClass("boxfold");
		}
	});

	compZzimOldChkDivObj.find(".zzimBtn").unbind();
	compZzimOldChkDivObj.find(".zzimBtn").click(function () {
		if(!Islogin()) {
			//Cmd_Login('inputzzim2010');
			//var rtnUrl = "/list.jsp?cate="+gCate+"&IsOpenCompare=Y";
			var rtnUrl = document.location.href + "&IsOpenCompare=Y";
			Cmd_Login('inputzzim2010', rtnUrl);
			return;
		}

		var compZzimProdNos = getCheckedCompZzimModelnos();
		//consoleLog("compZzimProdNos="+compZzimProdNos);
		//return;

		compareZzimAction(compZzimProdNos);

		compZzimOldChkDivHide();

		//insertLogLSV(15041);
	});

	compZzimOldChkDivObj.find(".close").unbind();
	compZzimOldChkDivObj.find(".close").click(function () {
		compZzimOldChkDivHide();
	});
}

function getCheckedCompZzimModelnos() {
	var groupModelItemsObj = $("#listBodyDiv .oldCompZzimChk");
	var rtnValues = "";

	for(var i=0; i<groupModelItemsObj.length; i++) {
		var groupModelItem = $(groupModelItemsObj[i]);

		if(groupModelItem.hasClass("chk")) {
			var prodNo = "";

			var groupMainDivObj = groupModelItem.parents(".groupModelItem");
			// 매칭된 모델의 경우
			if(groupMainDivObj && groupMainDivObj.length>0) {
				var modelno = groupMainDivObj.attr("id");
				modelno = modelno.split("modelnoGroup_").join("");

				prodNo = "G"+modelno;

			// 일반 상품은 대상에서 빼기로 함
			//} else { // 일반 상품의 경우
				//var groupMainDivObj = groupModelItem.parents(".groupModelItem");
			}

			if(prodNo.length>0) {
				if(rtnValues.length>0) rtnValues += ",";
				rtnValues += prodNo;
			}
		}

	}

	return rtnValues;
}

function compZzimOldChkDivShow(thisTmp) {
	var thisObj = $(thisTmp);
	var compZzimOldChkDivObj = $("#compZzimOldChkDiv");

	// 찜이 되어있는지 표시해주는 함수
	compZzimHeartCheck(thisTmp);

	//var bodyObj = $(window);
	//var top = bodyObj.scrollTop() + bodyObj.height() / 2 - zzimCompDivObj.height() / 2;
	//var left = bodyObj.width() / 2 - zzimCompDivObj.width() / 2;
	var top = thisObj.offset().top - compZzimOldChkDivObj.height() - 1;
	var left = thisObj.offset().left + thisObj.width() - compZzimOldChkDivObj.width() + 12;

	compZzimOldChkDivObj.css("top", top+"px");
	compZzimOldChkDivObj.css("left", left+"px");

	compZzimOldChkDivObj.show();
}

function compZzimHeartCheck(thisTmp) {
	var thisObj = $(thisTmp);

	var modelno = "";
	var pl_no = "";
	var groupMainDivObj = thisObj.parents(".groupModelItem");

	// 매칭된 모델의 경우
	if(groupMainDivObj && groupMainDivObj.length>0) {
		modelno = groupMainDivObj.attr("id");
		modelno = modelno.split("modelnoGroup_").join("");
	}

	var url = "/lsv2016/ajax/getModelnoSaveGoods_ajax.jsp";
	var param = "procType=2&modelno="+modelno+"&pl_no="+pl_no;

	//consoleLog(url+"?"+param)

	if(url.length>0 && param.length>0) {
		var ajaxObj = $.ajax({
			type : "post",
			url : url,
			data : param,
			dataType : "json",
			success : function(ajaxResult) {
				var rtnValue = ajaxResult["rtnValue"];

				var compZzimOldChkZzimHeartObj = $("#compZzimOldChkDiv .zzimBtn");

				if(rtnValue=="true") {
					compZzimOldChkZzimHeartObj.addClass("on");
				} else {
					compZzimOldChkZzimHeartObj.removeClass("on");
				}
			}
		});
	}
}

function compZzimOldChkDivHide() {
	var compZzimOldChkDivObj = $("#compZzimOldChkDiv");

	compZzimOldChkDivObj.hide();
}

//////////////////////////////////////////////////구형 저장을 위한 비교 레이어 /////////////////////////////////////////////////////

////////////////////////////////////////////////// 상품 비교 관련 스크립트 시작 /////////////////////////////////////////////////////

function setCompareProdEvent() {
	var compareProdBoxDivObj = $("#compareProdBoxDiv");

	compareProdBoxDivObj.find(".close").unbind();
	compareProdBoxDivObj.find(".close").click(function () {
		compareProcBoxDivHide();

		// 내리기를 했을 경우는 내려가기만 하고 닫기를 누르면 데이터 삭제됨
		setCookieCommon("compProdList", "");
		var compareProdBoxContentObj = compareProdBoxDivObj.find(".prod_comlist .compare");
		compareProdBoxContentObj.html("");

		//insertLogLSV(14373);
	});

	compareProdBoxDivObj.find(".morr").unbind();
	compareProdBoxDivObj.find(".morr").click(function () {
		if(compareProdBoxDivObj.hasClass("boxfold")) {
			compareProdBoxDivObj.removeClass("boxfold");
			//insertLogLSV(14374);
		} else {
			compareProdBoxDivObj.addClass("boxfold");
			//insertLogLSV(14372);
		}
	});
	
	// 전체 선택
	compareProdBoxDivObj.find(".allSelectBtn").unbind();
	compareProdBoxDivObj.find(".allSelectBtn").click(function () {
		var compareProdBoxContentObj = $("#compareProdBoxDiv");

		if(compareProdBoxContentObj.length==0) {
			alert("상품이 없습니다.");
			return;
		}
		
		$.each(compareProdBoxDivObj.find(".input--checkbox-item"), function(i, v) {
			var chkObj = $(this).attr("id");
			if(compareProdBoxDivObj.find("#"+chkObj).is(":checked")==false){
				//$("label[for='"+chkObj+"']").checked = true;
				$("#"+chkObj).prop("checked",true);
			}else{
				//$("label[for='"+chkObj+"']").checked = false;
				$("#"+chkObj).prop("checked",false);
			}
		});
	});

	// 선택 삭제
	compareProdBoxDivObj.find(".selectDelBtn").unbind();
	compareProdBoxDivObj.find(".selectDelBtn").click(function () {
		var compareProdBoxContentObj = $("#compareProdBoxDiv .compare-prod__list li");

		var deleteCompObj = new Array();

		var checkedCnt = 0;
		for(var i=0; i<compareProdBoxContentObj.length; i++) {
			var compItemObj = $(compareProdBoxContentObj[i]);

			if(compItemObj.find("input").is(":checked")) {
				deleteCompObj[checkedCnt++] = compItemObj;
			}
		}

		if(deleteCompObj.length==0) {
			alert("상품을 선택하여 주십시오.");
			return;
		}

		if(confirm("정말 삭제하시겠습니까?")) {
			for(var i=0; i<deleteCompObj.length; i++) {
				var delCompItemObj = $(deleteCompObj[i]);
				var prodNo = delCompItemObj.attr("prodNo");

				//console.log("prodNo="+prodNo);
				compareProdDelete(prodNo);

				delCompItemObj.remove();

				// 비교는 모델만 하기때문에 G만 올수있음
				var modelno = prodNo.split("G").join("");
				var orgCheckedObj = $("#modelnoGroup_"+modelno+" .groupItemCheck");
				//orgCheckedObj.removeClass(checkStr);
				//orgCheckedObj.addClass(unCheckStr);
			}

		}

		//insertLogLSV(14378);
	});

	// 비교하기
	compareProdBoxDivObj.find(".selectCompBtn").unbind();
	compareProdBoxDivObj.find(".selectCompBtn").click(function () {
		compareAction();

		//insertLogLSV(14379);
	});

	// 찜하기
	compareProdBoxDivObj.find(".selectZzimBtn").unbind();
	compareProdBoxDivObj.find(".selectZzimBtn").click(function () {
		var zzimModelnos = "";
		var compareProdBoxContentObj = $("#compareProdBoxDiv .compare-prod__list li");
		for(var i=0; i<compareProdBoxContentObj.length; i++) {
			var compItemObj = $(compareProdBoxContentObj[i]);

			if(compItemObj.find("input").is(":checked")) {
				var prodno = compItemObj.attr("prodno");

				if(zzimModelnos.length>0) zzimModelnos += ",";
				zzimModelnos += prodno;
			}
		}

		if(zzimModelnos.length==0) {
			alert("선택한 상품이 없습니다.\n찜할 상품을 선택해 주십시오.");
		} else {
			compareZzimAction(zzimModelnos);
		}

		//insertLogLSV(14380);
	});
}

// 페이지 목록이 로딩 되었을때 비교 체크값 세팅
function setCompareProdCheckValue() {
	// 페이지를 새로고침 하면 초기 세팅함
	var compProdList = getCookieCommon("compProdList");
	if(compProdList && compProdList.length>0) {
		//setCompareProdList();

		compareProdBoxDivOpen();

		// 비교창이 열리는 페이지가 보이면 카운트
		//insertLogLSV(14371);

		var compareProdBoxDivObj = $("#compareProdBoxDiv");
		if(!compareProdBoxDivObj.hasClass("boxfold")) {
			compareProdBoxDivObj.addClass("boxfold");
		}
	}
}

function setCompareProdCheckIcon() {
	var compProdList = getCookieCommon("compProdList");
	// 비교 체크 박스 넣기
	var compProdListAry = compProdList.split(",");
	for(var i=0; i<compProdListAry.length; i++) {
		if(compProdListAry[i].length<3) continue;

		// 오류가 생겨서 뺐는데 중복해서 들어가는 것같음.
		// 혹시 모르니 일단 놔둠
		if(compProdListAry[i].indexOf("G")>-1) {
			var modelno = compProdListAry[i].split("G").join("");
			var itemCheckObj = $("#modelnoGroup_"+modelno+" .groupItemCheck");
			if(itemCheckObj.hasClass("unchk")) {
				itemCheckObj.removeClass("unchk");
				itemCheckObj.addClass("chk");

				itemCheckObj.find("input").after("<em>상품비교</em>");
			}
		}

		// 우측 최근본 찜 수정
		// 우측은 일반 상품 일 수도 있고 가격비교 상품일수도 있음
		var rbRecentListItem = $("#rbRecent .prodItem"+compProdListAry[i]);
		var recentCheckObj = rbRecentListItem.find(".groupItemCheck");
		if(recentCheckObj.hasClass("unchk")) {
			recentCheckObj.removeClass("unchk");
			recentCheckObj.addClass("chk");

			recentCheckObj.find("input").after("<em>상품비교</em>");
		}
	}

	// 우측 최근본 찜 수정
	/*
	var rbRecentListAry = $("#rbRecent .prodItem");
	for(var i=0; i<rbRecentListAry.length; i++) {
		var recentItem = rbRecentListAry[i];
		var compProdId = recentItem.attr("prodid");
		if(compProdId.indexOf("G")>-1) {
			var modelno = compProdListAry[i].split("G").join("");
			var itemCheckObj = $("#modelnoGroup_"+modelno+" .groupItemCheck");
			if(itemCheckObj.hasClass("unchk")) {
				itemCheckObj.removeClass("unchk");
				itemCheckObj.addClass("chk");

				itemCheckObj.find("input").after("<em>상품비교</em>");
			}
		}
	}
	*/
}

// 여러 상품을 찜하는 함수
function compareZzimAction(orgZzimModelno) {
	if(!Islogin()) {
		//Cmd_Login('inputzzim2010', );
		//var rtnUrl = "/list.jsp?cate="+gCate+"&IsOpenCompare=Y";
		var rtnUrl = document.location.href + "&IsOpenCompare=Y";
		Cmd_Login('inputzzim2010', rtnUrl);
		return;
	}

	var zzimModelno = orgZzimModelno;

	// 기존 로직에서 일반 상품과 모델상품을 구분하기위해 G:, P:로 사용했었음.
	// 태그에서는 :를 빼고 G, P로 통일
	zzimModelno = zzimModelno.split("G").join("G:");
	zzimModelno = zzimModelno.split("P").join("P:");
	
	var action = $("#compZzimOldChkDiv .zzimBtn").hasClass("on") ? "delete" : "insert";
	var url = $("#compZzimOldChkDiv .zzimBtn").hasClass("on") ? "lsv2016/ajax/deleteSaveGoodsProc.jsp" : "/view/include/insertSaveGoodsProc.jsp";
	var param = "modelnos="+zzimModelno;
	if(action == "delete" ) {
		param += "&tbln=save";
	}

	if(url.length>0 && param.length>0) {
		if(action=="delete" && !confirm("이미 찜한 상품입니다.\n해지하겠습니까?")) {
			return;
		}
		var ajaxObj = $.ajax({
			type : "get",
			url : url,
			data : param,
			dataType : "json",
			success : function(ajaxResult) {
				var rtnCount = ajaxResult["count"];

				// 추가든 삭제든 성공했을 경우만 상태를 변경함
				if(rtnCount>0) {
					if(action == "insert" ) {
						var listBodyDivObj = $("#listBodyDiv");
						var orgZzimModelnoAry = orgZzimModelno.split(",");
	
						if(orgZzimModelnoAry && orgZzimModelnoAry.length>0) {
							for(var i=0; i<orgZzimModelnoAry.length; i++) {
								if(orgZzimModelnoAry[i].length>0) {
									listBodyDivObj.find(".zzimSpan_"+orgZzimModelnoAry[i]).addClass("zzimon");
								}
							}
						}
						// 찜 성공
						zzimCompDivShow(orgZzimModelno);
					}
				} else {
					if(typeof onFlag != "undefined" && onFlag != null && onFlag) {
						alert("찜 해제가 실패 하였습니다.")
					} else {
						//alert("찜이 실패 하였습니다.");
				//		console.log( thisObject );
				//		zzimAction(null, orgZzimModelno, true);
					}
				}
				// 우측 찜 레이어 갱신
				if(action == "insert" ) {
					fn_banner_info();
				}
			}
		});
	}
}

// 체크한 상품 목록을 읽어와서 비교함
function compareAction() {
	var compareProdBoxContentObj = $("#compareProdBoxDiv .compare-prod__list li");
	var compModelList = "";
	var adModelList = "";

	for(var i=0; i<compareProdBoxContentObj.length; i++) {
		var compItemObj = $(compareProdBoxContentObj[i]);
		var prodNo = compItemObj.attr("prodNo");
		if(prodNo.length>1 && compItemObj.find("input").is(":checked")) {
			if(prodNo.substring(0, 1)=="G") {
				
				/*
				20190819 : 인포애드 광고상품 아이콘 추가 (비교팝업)
				스폰서 및 인포애드 광고상품 비교 팝업에 자동 노출 
				비교팝업 내 우측 마지막에 노출(AD딱지 노출)  
				광고 상품은 상품으로 안넘긴다.
				 */
				if(compItemObj.find('span.ico_ad').hasClass('ico_ad')) {
					if(adModelList.length>0) adModelList = ",";
					adModelList += prodNo.substring(1);
					// 슈퍼탑 광고관련 로그 20190830
					//insertLogLSV(20442, '', prodNo.substring(1));
				} else {
					if(compModelList.length>0) compModelList += ",";
					compModelList += prodNo.substring(1);
				}
			}
			if(prodNo.substring(0, 1)=="P") {
				if(compModelList.length>0) compModelList += ",";
				compModelList += prodNo.split("P").join("P:");
			}
		}
	}
	if(compModelList.length=="") {
		alert("선택한 상품이 없습니다.");
		return;
	}
	if(compModelList.indexOf(",")<0) {
		alert("상품은 2개 이상 선택하셔야 비교가 가능합니다.");
		return;
	}
	
	if(adModelList.length>0 && adModelList.indexOf(",")!=-1) {
		alert("인포애드 광고상품은 하나만 선택가능합니다.");
		return;
	}
	
	if(compModelList.length>0) {
		var compUrl = "/view/Comparemulti.jsp?chkNo="+compModelList; 
		if(adModelList.length>0) {
			compUrl += "&adModelNo="+adModelList;
		}
		//window.open(compUrl);
		var compareMultiWin = window.open(compUrl,"Comparemulti","width=700,height=600,left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=yes,resizable=yes,menubar=no");
		compareMultiWin.focus();
	}
}

function compareProdBoxDivOpen() {
	var compareProdBoxDivObj = $("#compareProdBoxDiv");

	setCompareProdList();

	//setCompareProdCheckIcon();

	compareProdBoxDivObj.show();
	
	if($("#compareProdBoxDiv").hasClass("is--fold")){
		$("#compareProdBoxDiv").removeClass("is--fold");
	}
}

function compareProcBoxDivHide() {
	var compareProdBoxDivObj = $("#compareProdBoxDiv");

	compareProdBoxDivObj.hide();

	deleteCheckedGroupModels();
}

function deleteCheckedGroupModels() {
	var groupCheckItems = $("#main_body .groupItemCheck");

	groupCheckItems.removeClass("chk");
	groupCheckItems.addClass("unchk");
	groupCheckItems.find("em").remove();
}
var currGoodsNum = 0;
// 비교창에 상품 정보를 ajax로 보여주기
function setCompareProdList() {
	var compareProdBoxDivObj = $("#compareProdBoxDiv");
	var compareProdBoxContentObj = compareProdBoxDivObj.find(".compare-prod__list");
	var compProdList = getCookieCommon("compProdList");
	if(compProdList && compProdList.length>0) {
		var url = "/lsv2016/ajax/getCompareProdList_ajax.jsp";
		var param = {
			"random_seq" : random_seq,
			"goodsNumList" : compProdList
		}

		$.ajax({
			type : "post", 
			url : url, 
			async: false, 
			data : param, 
			dataType : "json", 
			success : function(json) {
				var html = compareProdListViewHtml(json);
				compareProdBoxContentObj.html(html);
				//체크박스활성화
				$.each(compareProdBoxContentObj, function(Index, listData) {
					$(this).find("li input").prop("checked",true);
				});
				var totalGoodsCnt = json["goodsCnt"];
				if(IsOpenCompare=="Y") {
					if(compareProdBoxDivObj.hasClass("boxfold")) compareProdBoxDivObj.removeClass("boxfold");
					IsOpenCompare = "";
				}

				// ajax 안쪽에 넣어야함
				// 비교창안에서 체크박스 이벤트
				compareProdBoxDivObj.find(".compare-prod__item a").unbind();
				compareProdBoxDivObj.find(".compare-prod__item a").click(function () {
					var thisObj = $(this);
					var parentLiObj = thisObj.parents("li");
					var prodNo = parentLiObj.attr("prodNo");

					if(prodNo.indexOf("G")>-1) {
						var modelno = prodNo.split("G").join("");

						goDetailItem(modelno);
					}

					if(prodNo.indexOf("P")>-1) {
						var plno = prodNo.split("P").join("");

						goPlnoItem(plno)
					}
					//insertLogLSV(14376);
					
					// 20190906 슈퍼탑 클릭수 
					if( parentLiObj.find('span.ico_ad').length > 0 ) {
						//insertLogLsv(20507);
					}
					
				});
				
				compareProdBoxDivObj.find(".input--checkbox-item").unbind();
				compareProdBoxDivObj.find(".input--checkbox-item").click(function () {
					var chkObj = $(this).attr("id");
					if($("#"+chkObj).is(":checked")){
						$("#"+chkObj).prop("checked",true);
					}else{
						$("#"+chkObj).prop("checked",false);
					}
				});
			},
			error: function(request, status, error) {
				//console.log("request : " + request + "status : " + status + "error : " + error);
			}
		});
	} else {
		compareProdBoxDivObj.find(".compCntSpan").html("("+0+")");
		compareProdBoxContentObj.html("");
	}
}

//상품창 링크
function goDetailItem(modelno, openType) {
	var url = "/detail.jsp?modelno="+modelno;
	if(openType && openType.length>0) {
		url += "&goodsBbsOpenType="+openType;
	}

	comDetailMultiView(url);
}

function comDetailMultiView(OpenFile) {
	if(navigator.userAgent.toLowerCase().indexOf("firefox")>-1 || 
		navigator.userAgent.toLowerCase().indexOf("opera")>-1 ||
		navigator.userAgent.toLowerCase().indexOf("chrome")>-1){
		//ETC
		detailWin = window.open(OpenFile);
	}else{
		//IE
		detailWin = window.open("/_pre_detail_.jsp");
		detailWin.location.replace(OpenFile);
	}
	detailWin.focus();
}

//일반상품 이동 링크
function goPlnoItem(plno) {
	var url = "/move/Redirect.jsp?type=ex&cmd=move_"+plno+"&pl_no="+plno;
	
	window.open(url);
}

// 상품 비교 입력하기(쿠키 저장)
// compProdList 이름으로 저장
var compareFirstClick = false;
function compareProdInput(prodNo) {
	var compProdList = getCookieCommon("compProdList");

	//console.log("input compProdList="+compProdList);

	// 아무것도 없을경우 초기화
	if(!compProdList) compProdList = "";

	var compProdListTemp = ","+compProdList+",";

	if(compProdListTemp.indexOf(","+prodNo+",")<0) {
		compProdList += "," + prodNo;
		setCookieCommon("compProdList", compProdList);
	}
	if($("#compareProdBoxDiv").attr("display")=="none" || typeof $("#compareProdBoxDiv").attr("display") == "undefined") {
		compareProdBoxDivOpen();
	}
	

	//if(!compareFirstClick) insertLogLSV(14371);
	compareFirstClick = true;
}

// 상품 비교 삭제하기(쿠키 삭제)
function compareProdDelete(prodNo) {
	var compProdList = getCookieCommon("compProdList");

	//console.log("delete compProdList="+compProdList);

	// 아무것도 없을경우 초기화
	if(!compProdList) compProdList = "";

	var compProdListTemp = ","+compProdList+",";

	if(compProdListTemp.indexOf(","+prodNo+",")>-1) {
		compProdListTemp = compProdListTemp.replace(","+prodNo+",", ",")
		compProdList = compProdListTemp.substring(1, (compProdListTemp.length-1));
		
		var compCnt = 0;
		if(compProdList && compProdList.length>0) {
			var compProdListAry = compProdList.split(",");
			if(compProdListAry.length>0) {
				for(var i=0; i<compProdListAry.length; i++) {
					if(compProdListAry[i].length>0) compCnt++;
				}
			}
		}

		$("#compareProdBoxDiv .compCntSpan").html("("+compCnt+")");

		setCookieCommon("compProdList", compProdList);
		
		if($("#compareProdBoxDiv").attr("display")=="none" || typeof $("#compareProdBoxDiv").attr("display") == "undefined") {
			compareProdBoxDivOpen();
		}
	}
}


///////////////////////////////////////////////////// 상품 비교 관련 스크립트 끝 /////////////////////////////////////////////////////


///////////////////////////////////////////////////// 찜하기 스크립트 시작 /////////////////////////////////////////////////////

// 찜완료를 위한 레이어의 기본 세팅
function setZzimCompDiv() {
	var zzimCompDivObj = $("#zzimCompDiv");

	zzimCompDivObj.find(".zzimlist").unbind();
	zzimCompDivObj.find(".zzimlist").click(function() {
		//goLocatonNewWindow("/view/resentzzim/resentzzimList.jsp?listType=2");
		showZzim();
	});

	zzimCompDivObj.find(".close").unbind();
	zzimCompDivObj.find(".close").click(function() {
		zzimCompDivHide();
	});
}

// 찜 완료 창 열기
// modelnoObj.image : 이미지 경로
// modelnoObj.price : 가격
// modelnoObj.name : 상품명
function zzimCompDivShow(zzimModelno) {
	if(zzimModelno.length>0) {
		var url = "/lsv2016/ajax/getCompareProdList_ajax.jsp";
		var param = {
			"random_seq" : random_seq,
			"goodsNumList" : zzimModelno
		}

		$.ajax({
			type : "post", 
			url : url, 
			async: true, 
			data : param, 
			dataType : "json", 
			success : function(json) {
				var goodsCnt = json["goodsCnt"];
				var goodsListObj = json["goodsList"];
				var html = "";

				var showModelno = "";
				var showPriceStr = "";
				var showImageUrl = "";
				var vTlcflag = false;
				var vCashflag = false;
				$.each(goodsListObj, function(Index, listData) {
					var prodNo = listData["prodNo"];
					var modelno = listData["modelno"];
					var p_pl_no = listData["p_pl_no"];
					var minPriceText = listData["minPriceText"];
					var minprice = listData["minprice"];
					var minprice3 = listData["minprice3"];
					var mallcnt = listData["mallcnt"];
					var mallcnt3 = listData["mallcnt3"];
					var cash_min_prc = listData["cash_min_prc"];
					var cash_min_prc_yn = listData["cash_min_prc_yn"];
					var ovs_min_prc_yn = listData["ovs_min_prc_yn"];
					var tlc_min_prc = listData["tlc_min_prc"];
					/*
					var goods_info = listData["goods_info"];
					var sale_cnt = listData["sale_cnt"];
					var ca_code = listData["ca_code"];
					var modelnm = listData["modelnm"];
					var factory = listData["factory"];
					var brand = listData["brand"];
					var strFreeinterest = listData["strFreeinterest"];
					var c_date = listData["c_date"];
					var c_dateStr = listData["c_dateStr"];
					var moddate = listData["moddate"];
					*/
					var smallImageUrl = listData["smallImageUrl"];
					/*
					var gb1_no = listData["gb1_no"];
					var kb_num = listData["kb_num"];
					var kb_title = listData["kb_title"];
					var url1 = listData["url1"];
					var keyword2 = listData["keyword2"];
					var modelCateLink = listData["modelCateLink"];
					var strCategoryName = listData["strCategoryName"];
					var goodscode = listData["goodscode"];
					*/

					showModelno = modelno;
					//현금몰 가격 있으면 현금몰 우선, tlc 가격있으면 tlc 가격 우선
					if(typeof cash_min_prc_yn != "undefined" && cash_min_prc_yn != null && cash_min_prc_yn == "Y" && typeof cash_min_prc != "undefined" && cash_min_prc != null && cash_min_prc > 0) {
						showPriceStr = cash_min_prc.format();
						vCashflag = true;
					} else if(typeof tlc_min_prc != "undefined" && tlc_min_prc != null && tlc_min_prc > 0){
						showPriceStr = tlc_min_prc.format();
						vTlcflag = true;
					}else{
						showPriceStr = minprice.format();						
					}
					showImageUrl = smallImageUrl;

				});

				var zzimCompDivObj = $("#zzimCompDiv");
				var zzimPriceStr = "";
				var bodyObj = $(window);

				var top = bodyObj.scrollTop() + bodyObj.height() / 2 - zzimCompDivObj.height() / 2;
				var left = bodyObj.width() / 2 - zzimCompDivObj.width() / 2;

				// 일반 상품일 경우
				if(showModelno=="0") {
					zzimPriceStr = "<b>"+showPriceStr+"</b>원";
				} else {
					if(vTlcflag || vCashflag){	//tlc, 현금몰은 최저가 노출 안함
						zzimPriceStr = "<b>"+ showPriceStr +"</b>원";
					}else{
						zzimPriceStr = "최저가<b>"+showPriceStr+"</b>원";						
					}
				}

				zzimCompDivObj.find(".zzimProdImage").attr("src", showImageUrl);
				zzimCompDivObj.find(".zzim_price").html(zzimPriceStr);

				zzimCompDivObj.css("top", top+"px");
				zzimCompDivObj.css("left", left+"px");
				zzimCompDivObj.fadeIn().delay(3000).fadeOut();
				//zzimCompDivObj.show();

				// 찜이 성공하면 우측의 찜 윙을 열어줌
				//if($("#spn_close").attr("display")=="none") {
				//	$("#div_myzone .zzim_goods").trigger("click");
				//}

				if(screen.width<=1366) {
					insertLog(14369);
					showMyAllList("save");
				} else {
					$("#div_myzone .zzim_goods").trigger("click");
				}
			},
			error: function(request, status, error) {
				//console.log("request : " + request + "status : " + status + "error : " + error);
			}
		});
	}
}

function zzimCompDivHide() {
	var zzimCompDivObj = $("#zzimCompDiv");

	zzimCompDivObj.hide();
}

///////////////////////////////////////////////////// 찜하기 스크립트 끝 /////////////////////////////////////////////////////


///////////////////////////////////////////////////// 모바일 쇼핑 혜택 스크립트 시작 /////////////////////////////////////////////////////

function setMobileShoppingRecDiv() {
	// 모바일 쇼핑 혜택 레이어 보여주기
	var listBodyDivObj = $("#listBodyDiv");
	listBodyDivObj.find(".eMoneyLink").unbind();
	listBodyDivObj.find(".eMoneyLink").click(function () {
		$("#mobileShoppingRecDiv").show();
		/*if(listGridType==2) {
			insertLogLSV(15024);
		} else {
			insertLogLSV(14289);
		}*/
	});

	var mobileShoppingRecDivObj = $("#mobileShoppingRecDiv");

	mobileShoppingRecDivObj.find(".btn_lay_close").unbind();
	mobileShoppingRecDivObj.find(".btn_lay_close").click(function() {
		$(this).closest('.lay_full').fadeOut(150);
	});
	mobileShoppingRecDivObj.find(".btn_send_sms").unbind();
	mobileShoppingRecDivObj.find(".btn_send_sms").click(function() {
		var myphone = mobileShoppingRecDivObj.find(".send_area input").val();
		var part = "enuri";
		var title = "에누리가격비교";
		var rurl = "http://goo.gl/O8CUnn";

		if(myphone=="") {
			alert("휴대폰 번호가 입력되지않았습니다.");
			return;
		}
		var rgEx = /(01[016789])(\d{4}|\d{3})\d{4}$/g;
		var chkFlg = rgEx.test(myphone);
		if(!chkFlg) {
			alert("잘못된 형식의 휴대폰 번호입니다.");
			return;
		}

		document.getElementById("hFrame").src = "/common/jsp/Ajax_ListHeader_Sms_Proc.jsp?part="+part+"&rurl="+rurl+"&phoneno="+myphone+"&title="+encodeURIComponent(title);

		mobileShoppingRecDivObj.find(".send_area input").val("");

		/*if(listGridType==2) {
			insertLogLSV(15025);
		} else {
			insertLogLSV(14309);
		}*/
	});
	mobileShoppingRecDivObj.find(".btn_more_benefit").unbind();
	mobileShoppingRecDivObj.find(".btn_more_benefit").click(function() {
		goLocatonNewWindow("http://www.enuri.com/eventPlanZone/jsp/shoppingBenefit.jsp");
		/*if(listGridType==2) {
			insertLogLSV(15026);
		} else {
			insertLogLSV(14310);
		}*/
	});
}

function mobileShoppingRecDivShow(thisObject) {
	var mobileShoppingRecDivObj = $("#mobileShoppingRecDiv");

	// 토글
	if(mobileShoppingRecDivObj.css("display")!="none") {
		mobileShoppingRecDivHide();

		return;
	}

	var thisObj = $(thisObject);

	var top = thisObj.offset().top + thisObj.height() + 6;
	var left = thisObj.offset().left - mobileShoppingRecDivObj.width() + thisObj.width() + 20;

	mobileShoppingRecDivObj.css("top", top+"px");
	mobileShoppingRecDivObj.css("left", left+"px");
	//mobileShoppingRecDivObj.show();
	mobileShoppingRecDivObj.fadeIn();
}

function mobileShoppingRecDivHide() {
	var mobileShoppingRecDivObj = $("#mobileShoppingRecDiv");

	//mobileShoppingRecDivObj.hide();
	mobileShoppingRecDivObj.fadeOut();
}

///////////////////////////////////////////////////// 모바일 쇼핑 혜택 스크립트 끝 /////////////////////////////////////////////////////


///////////////////////////////////////////////////// 모바일 최저가,전용 레이어 스크립트 시작 /////////////////////////////////////////////////////

function setMobileSendProdDivDiv() {
	// 모바일 전용상품 및 모바일 최저가 상품 레이어 보여주기
	var listBodyDivObj = $("#listBodyDiv");
	listBodyDivObj.find(".mobileSendLayer").unbind();
	listBodyDivObj.find(".mobileSendLayer").click(function () {
		var type = $(this).attr("type");

		mobileSendProdDivShow(type, this);
	});

	var mobileSendProdDivObj = $("#mobileSendProdDiv");

	// 닫기 이벤트
	mobileSendProdDivObj.find(".close").unbind();
	mobileSendProdDivObj.find(".close").click(function() {
		mobileSendProdDivHide();
	});

	// 핸드폰 전송 하단 레이어 열기
	mobileSendProdDivObj.find(".smsp").unbind();
	mobileSendProdDivObj.find(".smsp").click(function() {
		var type = mobileSendProdDivObj.attr("type");

		mobileSendProdDivObj.find(".boxly_b").toggle();

		// 모바일 최저가
		/*if(type=="1") {
			if(listGridType==3) insertLogLSV(14319);
			else if(listGridType==2) insertLogLSV(15033);
			else insertLogLSV(14279);
		}
		// 모바일 전용
		if(type=="2") {
			if(listGridType==3) insertLogLSV(14324);
			else if(listGridType==2) insertLogLSV(15038);
			else insertLogLSV(14284);
		}*/
	});

	// 찜하기 체크박스
	mobileSendProdDivObj.find(".mobileSendCheck").unbind();
	mobileSendProdDivObj.find(".mobileSendCheck").click(function() {
		if(Islogin()) {
			var type = mobileSendProdDivObj.attr("type");

			if(type != "3"){
				var onFlag = this.checked;
				var zzimModelno = "G"+mobileSendSelModelno;
				// 하트 오브 젝트
				var zzimObject = ".zzimSpan_"+zzimModelno;
	
				// onFlag의 반대로 동작함
				zzimAction($(zzimObject), zzimModelno, !onFlag);
	
				// 모바일 최저가
				/*if(type=="1") {
					if(listGridType==3) insertLogLSV(14318);
					else if(listGridType==2) insertLogLSV(15030);
					else insertLogLSV(14278);
				}
				// 모바일 전용
				if(type=="2") {
					if(listGridType==3) insertLogLSV(14323);
					else if(listGridType==2) insertLogLSV(15035);
					else insertLogLSV(14283);
				}*/
			}else{
				var onFlag = this.checked;
				var zzimPlno = "P"+mobileSendSelPlno;

				zzimAction(this, zzimPlno, !onFlag);
			}
		} else {
			//Cmd_Login('inputzzim2010');
			//var rtnUrl = "/list.jsp?cate="+gCate+"&IsOpenCompare=Y";
			var rtnUrl = document.location.href + "&IsOpenCompare=Y";
			Cmd_Login('inputzzim2010', rtnUrl);
		}
	});

	// 에누리앱 설치
	mobileSendProdDivObj.find(".app").unbind();
	mobileSendProdDivObj.find(".app").click(function() {
		var type = mobileSendProdDivObj.attr("type");

		goLocatonNewWindow("/common/jsp/App_Landing.jsp");

		// 모바일 최저가
		/*if(type=="1") {
			if(listGridType==3) insertLogLSV(14320);
			else if(listGridType==2) insertLogLSV(15032);
			else insertLogLSV(14280);
		}
		// 모바일 전용
		if(type=="2") {
			if(listGridType==3) insertLogLSV(14325);
			else if(listGridType==2) insertLogLSV(15037);
			else insertLogLSV(14285);
		}*/
	});

	// 핸드폰 번호 전송
	mobileSendProdDivObj.find(".btn_send").unbind();
	mobileSendProdDivObj.find(".btn_send").click(function() {
		var type = mobileSendProdDivObj.attr("type");

		var phoneTxt = mobileSendProdDivObj.find(".phoneNum").val();
		
		if(type != "3"){
			var listItemObj = $("#modelno_"+mobileSendSelModelno);

			if(listItemObj.length<1) {
				if($("#modelnoGroup_"+mobileSendSelModelno).length>0) {
					listItemObj = $("#modelnoGroup_"+mobileSendSelModelno).parents(".prodItem");
				}else if($("#"+mobileSendSelModelno).length>0) {
					listItemObj = $("#"+mobileSendSelModelno);
				}
			}
			
			var title = listItemObj.find(".info_area strong a").html();

			// 자바스크립트 태그 제거
			title = removeHtml(title);

			sendDetailSms(phoneTxt, "detail", title)

			mobileSendProdDivObj.find(".phoneNum").val("");

			// 모바일 최저가
			/*if(type=="1") {
				if(listGridType==3) insertLogLSV(14321);
				else if(listGridType==2) insertLogLSV(15031);
				else insertLogLSV(14281);
			}
			// 모바일 전용
			if(type=="2") {
				if(listGridType==3) insertLogLSV(14326);
				else if(listGridType==2) insertLogLSV(15036);
				else insertLogLSV(14286);
			}*/
		}else{
			var listItemObj = $("#plno_"+mobileSendSelPlno);
			
			var title = listItemObj.find(".info_area strong a").html();

			// 자바스크립트 태그 제거
			title = removeHtml(title);
			//대괄호 제거
			title= title.replace(/\[([^\]]+)\]/g, "");

			sendDetailSms(phoneTxt, "srp", title)
			


			mobileSendProdDivObj.find(".phoneNum").val("");
		}

	});
}

// SMS보내기
function sendDetailSms(phoneTxt, part, title) {
	var myphone = phoneTxt;
	var rurl;

	if(myphone=="") {
		alert("휴대폰 번호가 입력되지않았습니다.");
		return;
	}

	var rgEx = /(01[016789])(\d{4}|\d{3})\d{4}$/g;
	var chkFlg = rgEx.test(myphone);

	if(!chkFlg) {
		alert("잘못된 형식의 휴대폰 번호입니다.");
		return;
	}

	if(part == "srp"){	//type3일때 srp로 던짐
		rurl = encodeURIComponent("http://m.enuri.com/mobilefirst/search.jsp?keyword="+title);
	}else{
		rurl = encodeURIComponent("http://m.enuri.com/mobilefirst/detail.jsp?_qr=y&modelno="+mobileSendSelModelno+"&hoticon=-1");	
	}
	
	if(rurl!="") {
		rurl = rurl.replace(/\?/ig, "--***--");
		rurl = rurl.replace(/\&/ig, "--**--");
		document.getElementById("hFrame").src = "/common/jsp/Ajax_ListHeader_Sms_Proc.jsp?part="+part+"&rurl="+rurl+"&phoneno="+myphone+"&title="+encodeURIComponent(title);
	} else {
		alert("주소를 읽어오지 못했습니다.");
	}
}

// type=1 : 모바일 최저가 상품
// type=2 : 모바일 전용 상품 (이동가능)
// type=3 : 모바일 전용 상품 (이동불가)
var mobileSendSelModelno = "";
var mobileSendSelPlno = "";
function mobileSendProdDivShow(type, thisObject) {
	var mobileSendProdDivObj = $("#mobileSendProdDiv");

	mobileSendProdDivObj.attr("type", type);

	// 토글
	if(mobileSendProdDivObj.css("display")!="none") {
		mobileSendProdDivHide();

		return;
	}

	var thisObj = $(thisObject);
	var top = thisObj.offset().top + thisObj.height() + 3;
	var left = thisObj.offset().left - mobileSendProdDivObj.width() + thisObj.width();

	if(left<mobileSendProdDivObj.width()) left = thisObj.offset().left;

	if(type != "3"){
		if(type=="1") {
			mobileSendProdDivObj.find("h4").html("모바일 최저가 상품");
			mobileSendProdDivObj.find(".m_txt p").html("본 상품은 <b>모바일로 구매 시 더 저렴</b>합니다.<br />찜/핸드폰 전송 또는 QR코드를 스캔하여<br />모바일에서 최저가를 확인하세요.");
		}
		if(type=="2") {
			mobileSendProdDivObj.find("h4").html("모바일 전용 상품");
			mobileSendProdDivObj.find(".m_txt p").html("모바일에서만 구매할 수 있는 모바일 전용<br />상품 입니다. 찜/핸드폰 전송 또는 QR코드를<br />스캔하여 모바일에서 최저가를 확인하세요.");
		}

		mobileSendProdDivObj.css("top", top+"px");
		mobileSendProdDivObj.css("left", left+"px");
		mobileSendProdDivObj.fadeIn();

		// 그룹 모델의 경우
		if(thisObj.parent().hasClass("op_price")) {
			var prodItemObj = thisObj.parents("li");
			var modelnoStr = prodItemObj.attr("id");

			mobileSendSelModelno = modelnoStr.split("modelnoGroup_").join("");
			
		} else { // 대표또는 인기인 경우
			var prodItemObj = thisObj.parents(".prodItem");
			var modelnoStr = prodItemObj.attr("id");

			mobileSendSelModelno = modelnoStr.split("modelno_").join("");
		}
		
		// 찜 했을 경우 체크 박스의 체크를 표시함
		var zzimChecked = $(".zzimSpan_G"+mobileSendSelModelno).hasClass("zzimon");
		mobileSendProdDivObj.find(".mobileSendCheck").attr("checked", zzimChecked);

		// 클릭한 모델의 qr코드 생성
		mobileSendProdDivObj.find(".boxly .qrcode img").css("visibility","hidden");
		mobileSendProdDivObj.find(".boxly .qrcode img").attr("src", "/view/qrcode/qr_model_"+mobileSendSelModelno+".png");
		mobileSendProdDivObj.find(".boxly .qrcode img").attr("onerror", "setQrCodeImgLP();");

		// 모바일 최저가
		/*if(type=="1") {
			if(listGridType==3) insertLogLSV(14317);
			else if(listGridType==2) insertLogLSV(15029);
			else insertLogLSV(14277);
		}
		// 모바일 전용
		if(type=="2") {
			if(listGridType==3) insertLogLSV(14322);
			else if(listGridType==2) insertLogLSV(15034);
			else insertLogLSV(14282);
		}*/
	}else{
		//type3일때만
		mobileSendProdDivObj.find("h4").html("모바일 전용 상품");
		mobileSendProdDivObj.find(".m_txt p").html("모바일에서만 구매할 수 있는 모바일 전용<br />상품 입니다. 찜/핸드폰 전송 또는 QR코드를<br />스캔하여 모바일에서 최저가를 확인하세요.");

		mobileSendProdDivObj.css("top", top+"px");
		mobileSendProdDivObj.css("left", left+"px");
		//mobileSendProdDivObj.show();
		mobileSendProdDivObj.fadeIn();

		var prodItemObj = thisObj.parents(".prodItem");
		var modelnoStr = prodItemObj.attr("id");

		mobileSendSelPlno = modelnoStr.split("plno_").join("");

		// 찜 했을 경우 체크 박스의 체크를 표시함
		var zzimChecked = $(".zzimSpan_P"+mobileSendSelPlno).hasClass("zzimon");
		mobileSendProdDivObj.find(".mobileSendCheck").attr("checked", zzimChecked);

		// 클릭한 모델의 qr코드 생성
		mobileSendProdDivObj.find(".boxly .qrcode img").css("visibility","hidden");
		//mobileSendProdDivObj.find(".boxly .qrcode img").attr("src", "/view/qrcode/qr_model_plno_4645217441.png");
		mobileSendProdDivObj.find(".boxly .qrcode img").attr("src", "/view/qrcode/qr_plno_"+mobileSendSelPlno+".png");
		mobileSendProdDivObj.find(".boxly .qrcode img").attr("onerror", "setQrCodeImgLP_plno();");
	}
}

// 모델에서 휴대폰 아이콘 클릭시 qr코드를 생성함
var qrCodeResetTryCnt = 0;
function setQrCodeImgLP() {
	var newDate = new Date();
	var qrName = newDate.getTime();
	var mobileSendProdDivObj = $("#mobileSendProdDiv");
	var qrImgSrc = mobileSendProdDivObj.find(".boxly .qrcode img").attr("src");

	if(qrImgSrc=="") {
		mobileSendProdDivObj.find(".boxly .qrcode img").attr("src","/view/qrcode/qr_model_"+mobileSendSelModelno+".png?v="+(new Date()).getTime());
	} else { //onerror이므로 생성 호출
		if(qrCodeResetTryCnt<5) { //5회까지만 생성 재시도
			qrCodeResetTryCnt++;

			function showQr(originalRequest) {
				setTimeout(function() {
					mobileSendProdDivObj.find(".boxly .qrcode img").attr("src","/view/qrcode/qr_model_"+mobileSendSelModelno+".png?v="+qrName);
				},1000);
			}
			var aUrl = "/view/make_qr2.jsp";
			var param = "";
			param += "&url="+encodeURIComponent("http://m.enuri.com/mobilefirst/detail.jsp?_qr=y&modelno="+mobileSendSelModelno+"&hoticon=-1");
			param = param + "&t=qr_model_"+mobileSendSelModelno;
			var ajaxObj = $.ajax({
				type : "post", 
				url : aUrl, 
				async: true, 
				data : param, 
				dataType : "json", 
				success: function(json) {
					showQr("");
				},
				error: function (xhr, ajaxOptions, thrownError) {
				}
			});
		} else {
			return;
		}
	}
}

function setQrCodeImgLP_plno() {
	var newDate = new Date();
	var qrName = newDate.getTime();
	var mobileSendProdDivObj = $("#mobileSendProdDiv");
	var qrImgSrc = mobileSendProdDivObj.find(".boxly .qrcode img").attr("src");
	
	var listItemObj = $("#plno_"+mobileSendSelPlno);
	var title = listItemObj.find(".info_area strong a").html();

	// 자바스크립트 태그 제거
	title = removeHtml(title);
	//대괄호 제거
	title= title.replace(/\[([^\]]+)\]/g, "");

	if(qrImgSrc=="") {
		mobileSendProdDivObj.find(".boxly .qrcode img").attr("src","/view/qrcode/qr_plno_"+mobileSendSelPlno+".png?v="+(new Date()).getTime());
	} else { //onerror이므로 생성 호출
		if(qrCodeResetTryCnt<5) { //5회까지만 생성 재시도
			qrCodeResetTryCnt++;

			function showQr(originalRequest) {
				setTimeout(function() {
					mobileSendProdDivObj.find(".boxly .qrcode img").attr("src","/view/qrcode/qr_plno_"+mobileSendSelPlno+".png?v="+qrName);
				},1000);
			}
			var aUrl = "/view/make_qr2.jsp";
			var param = "";
			
			param = "url="+encodeURIComponent("http://m.enuri.com/mobilefirst/search.jsp?keyword=" + title + "&_qr=y");
			param += "&t=qr_plno_"+mobileSendSelPlno;
			
			var ajaxObj = $.ajax({
				type : "post", 
				url : aUrl, 
				async: true, 
				data : param, 
				dataType : "json", 
				success: function(json) {
					showQr("");
				},
				error: function (xhr, ajaxOptions, thrownError) {
				}
			});
		} else {
			return;
		}
	}
}

function mobileSendProdDivHide() {
	var mobileSendProdDivObj = $("#mobileSendProdDiv");

	//mobileSendProdDivObj.hide();
	mobileSendProdDivObj.fadeOut();

	mobileSendSelModelno = "";

	mobileSendProdDivObj.find(".boxly .qrcode img").attr("src", "");
}

///////////////////////////////////////////////////// 모바일 최저가,전용 레이어 스크립트 끝 /////////////////////////////////////////////////////


///////////////////////////////////////////////////// 공유 레이어 스크립트 시작 /////////////////////////////////////////////////////

function setShareLayerDiv() {
	// 모바일 전용상품 및 모바일 최저가 상품 레이어 보여주기
	var listBodyDivObj = $("#listBodyDiv");
	listBodyDivObj.find(".shareDivShow").unbind();
	listBodyDivObj.find(".shareDivShow").click(function () {
		shareLayerDivShow(this);

		//insertLogLSV(14293);
	});

	var shareLayerDivObj = $("#shareLayerDiv");

	shareLayerDivObj.find(".close").unbind();
	shareLayerDivObj.find(".close").click(function() {
		shareLayerDivHide();
	});

	// URL복사
	shareLayerDivObj.find(".url").unbind();
	shareLayerDivObj.find(".url").click(function() {
		copy_URL("http://www.enuri.com/p/"+shareSelModelno, "goods");

		//insertLogLSV(14302);
	});

	// 메일 보내기
	shareLayerDivObj.find(".mail").unbind();
	shareLayerDivObj.find(".mail").click(function() {
		shareLayerDivHide();

		mailSendLayerDivShow(this);

		//insertLogLSV(14303);
	});

	// 페이스북
	shareLayerDivObj.find(".fb").unbind();
	shareLayerDivObj.find(".fb").click(function() {
		goSnsLinkLP(2);

		//insertLogLSV(14304);
	});

	// 트위터
	shareLayerDivObj.find(".tw").unbind();
	shareLayerDivObj.find(".tw").click(function() {
		goSnsLinkLP(1);

		//insertLogLSV(14305);
	});
}

var shareSelModelno = "";
function shareLayerDivShow(thisObject) {
	var shareLayerDivObj = $("#shareLayerDiv");

	// 토글
	if(shareLayerDivObj.css("display")!="none") {
		shareLayerDivHide();

		return;
	}

	var thisObj = $(thisObject);

	var top = thisObj.offset().top + thisObj.height() + 3;
	var left = thisObj.offset().left - shareLayerDivObj.width() + thisObj.width();

	shareLayerDivObj.css("top", top+"px");
	shareLayerDivObj.css("left", left+"px");
	//shareLayerDivObj.show();
	shareLayerDivObj.fadeIn();

	var prodItemObj = thisObj.parents(".prodItem");
	var modelnoStr = prodItemObj.attr("id");

	shareSelModelno = modelnoStr.split("modelno_").join("");
}

function shareLayerDivHide() {
	var shareLayerDivObj = $("#shareLayerDiv");

	//shareLayerDivObj.hide();
	shareLayerDivObj.fadeOut();
	mailSendLayerDivHide();

	//shareSelModelno = "";
}

function copy_URL(address) {
	if(window.clipboardData) {
		window.clipboardData.setData("Text", address);
		copy_URL_LP2();

	} else if (window.netscape) {
		try {
			netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
			var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);
			if (!clip) return;
			var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);
			if (!trans) return; trans.addDataFlavor('text/unicode');
			var str = new Object();
			var len = new Object();
			var str = Components.classes['@mozilla.org/supports-string;1'].createInstance(Components.interfaces.nsISupportsString);
			var copytext = address; str.data = copytext; trans.setTransferData('text/unicode',str,copytext.length*2);
			var clipid = Components.interfaces.nsIClipboard;
			if(!clipid) return false;
			clip.setData(trans,null,clipid.kGlobalClipboard);
			copy_URL_LP2();
		} catch(e) {
			alert("signed.applets.codebase_principal_support를 설정해주세요!");
		}
	} else {
		alert("해당 브라우저에서는 지원하지 않습니다.");
	}

	return false;
}

function copy_URL_LP2() {
	alert("해당 상품의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
}

//type=1 : 트위터, type=2 : 미투데이, type=3 : 페이스북
function goSnsLinkLP(type) {
	var url = "http://www.enuri.com/p/"+shareSelModelno;
	var content = "";
	var listItemObj = $("#modelno_"+shareSelModelno);

	if(listGridType==2) {
		content = listItemObj.find(".sp_title strong a").html();
	} else {
		content = listItemObj.find(".info_area strong a").html();
	}

	if(content.length>0) {
		var content1 = encodeURIComponent(content);
		var url1 = encodeURIComponent(url);

		// 트위터
		if(type==1) {
			window.open("http://twitter.com/intent/tweet?text="+content1+"&url="+url1, "_new");
		}
		// 페이스북
		if(type==2) {
			window.open("http://www.facebook.com/sharer.php?u="+url1, "_new");
		}
		// 미투데이
		if(type==3) {
			window.open("http://me2day.net/posts/new?new_post[body]="+content1+" "+url1, "_new");
		}
	}
}

///////////////////////////////////////////////////// 공유 레이어 스크립트 끝 /////////////////////////////////////////////////////


///////////////////////////////////////////////////// 메일 보내기 레이어 스크립트 시작 /////////////////////////////////////////////////////

function setMailSendLayerDiv() {
	var mailSendLayerDivObj = $("#mailSendLayerDiv");

	mailSendLayerDivObj.find(".close").unbind();
	mailSendLayerDivObj.find(".close").click(function() {
		mailSendLayerDivHide();
	});

	mailSendLayerDivObj.find(".option a").unbind();
	mailSendLayerDivObj.find(".option a").click(function() {
		//mailSendLayerDivObj.find(".mail_detail").toggle();
		if(mailSendLayerDivObj.find(".mail_detail").css("display")=="none") {
			mailSendLayerDivObj.find(".mail_detail").fadeIn("fast");
		} else {
			mailSendLayerDivObj.find(".mail_detail").fadeOut("fast");
		}
	});

	mailSendLayerDivObj.find(".btn_send").unbind();
	mailSendLayerDivObj.find(".btn_send").click(function() {
		recMailSend();
	});
}

function mailSendLayerDivShow(thisObj) {
	var mailSendLayerDivObj = $("#mailSendLayerDiv");
	var thisObj = $(thisObj);

	var top = thisObj.offset().top + thisObj.height() + 1;
	var left = thisObj.offset().left - mailSendLayerDivObj.width() + thisObj.width() + 60;

	mailSendLayerDivObj.css("top", top+"px");
	mailSendLayerDivObj.css("left", left+"px");

	// 메일 보안코드 열기
	if(Islogin()) {
		mailSendLayerDivObj.find(".mailly .mail_send .securityImg").hide();
	} else {
		// 이미지 처음 초기화
		setPassImage();

		mailSendLayerDivObj.find(".mailly .mail_send dd .passImgResetBtn").unbind();
		mailSendLayerDivObj.find(".mailly .mail_send dd .passImgResetBtn").click(function() {
			setPassImage();
		});

		mailSendLayerDivObj.find(".mailly .mail_send .securityImg").show();
	}

	//mailSendLayerDivObj.show();
	mailSendLayerDivObj.fadeIn();
}

function mailSendLayerDivHide() {
	var mailSendLayerDivObj = $("#mailSendLayerDiv");

	//mailSendLayerDivObj.hide();
	mailSendLayerDivObj.fadeOut();
}

var mailPassImg = "";
var mailPassNum = "";
function setPassImage() {
	var dateLong = (new Date()).getTime();
	var url = "/lsv2016/ajax/getMailSendCheckImg_ajax.jsp";
	var param = {
		"dateLong" : dateLong
	}

	$.ajax({
		type : "post", 
		url : url, 
		async: true, 
		data : param, 
		dataType : "json", 
		success : function(json) {
			mailPassNum = json["passImgNum"];
			mailPassImg = "http://img.enuri.info/images/mailing/mailimage/"+mailPassNum;

			$("#mailSendLayerDiv .mailly .mail_send dd .passImg").attr("src", mailPassImg);

			$("#mailSendLayerDiv .passImgName").val(mailPassNum);
		},
		error: function(request, status, error) {
			//console.log("request : " + request + "status : " + status + "error : " + error);
		}
	});
}

function recMailSend() {
	var mailSendLayerDivObj = $("#mailSendLayerDiv");

	var imgPassText = mailSendLayerDivObj.find(".imgPassText").val();
	var passImgName = mailSendLayerDivObj.find(".passImgName").val();
	var to_email = mailSendLayerDivObj.find(".to_email").val();
	var from_email = mailSendLayerDivObj.find(".from_email").val();
	var subject = mailSendLayerDivObj.find(".subject").val();
	var contents = mailSendLayerDivObj.find(".contents").val();

	var url = "/lsv2016/ajax/sendRecommendmailmulti_ajax.jsp";
	var param = {
		"imgPassText" : imgPassText, 
		"passImgName" : passImgName, 
		"to_email" : to_email, 
		"from_email" : from_email, 
		"subject" : subject, 
		"contents" : contents, 
		"modelno" : shareSelModelno
	}

	$.ajax({
		type : "post", 
		url : url, 
		async: true, 
		data : param, 
		dataType : "json", 
		success : function(json) {
			var mailChk = json["mailChk"];
			var errorType = json["errorType"];

			if(mailChk=="true") {
				alert("메일이 전송 되었습니다.");
				mailSendLayerDivHide();
			} else {
				if(errorType=="1") {
					alert("상품정보가 없거나 잘못된 링크입니다.\n\n다시 확인해 주십시오.");
				}
				if(errorType=="2") {
					alert("입력하신 숫자가 올바르지 않습니다.");
				}
				if(errorType=="3") {
					alert("상품정보가 없거나 잘못된 링크입니다.\n\n다시 확인해 주십시오.");
				}
			}
		},
		error: function(request, status, error) {
			//console.log("request : " + request + "status : " + status + "error : " + error);
		}
	});
}


///////////////////////////////////////////////////// 메일 보내기 레이어 스크립트 끝 /////////////////////////////////////////////////////


///////////////////////////////////////////////////// 쿠폰 레이어 스크립트 시작 /////////////////////////////////////////////////////

function couponInfoDivShow(thisObject) {
	var couponInfoDivObj = $("#couponInfoDiv");

	var thisObj = $(thisObject);
	var won_lineObj = thisObj.parents(".price_area").find(".won_line");

	var top = thisObj.offset().top + thisObj.height() + 3;
	//var left = thisObj.offset().left - couponInfoDivObj.width() + thisObj.width() - 2;
	var left = won_lineObj.offset().left - couponInfoDivObj.width() - 8;

	couponInfoDivObj.css("top", top+"px");
	couponInfoDivObj.css("left", left+"px");
	//couponInfoDivObj.show();
	couponInfoDivObj.fadeIn();
}

function couponInfoDivHide() {
	var couponInfoDivObj = $("#couponInfoDiv");

	//couponInfoDivObj.hide();
	couponInfoDivObj.fadeOut();
}

///////////////////////////////////////////////////// 쿠폰 레이어 스크립트 끝 /////////////////////////////////////////////////////


///////////////////////////////////////////////////// 줌 이미지 보기 스크립트 시작 /////////////////////////////////////////////////////

function setZoomImageDivDiv() {
	var zoomImageDivObj = $("#zoomImageDiv");

	zoomImageDivObj.find(".close").unbind();
	zoomImageDivObj.find(".close").click(function() {
		zoomImageDivHide();
	});

	zoomImageDivObj.find(".report").unbind();
	zoomImageDivObj.find(".report").click(function() {
		console.log("singo");
	});
}

function zoomImageDivShow(thisObject) {
	var zoomImageDivObj = $("#zoomImageDiv");

	var thisObj = $(thisObject);

	//var top = thisObj.offset().top + thisObj.height() + 3;
	//var left = thisObj.offset().left - zoomImageDivObj.width() + thisObj.width();

	var listItemObj = thisObj.parents(".prodItem");
	var modelno = listItemObj.attr("id");

	modelno = modelno.split("modelno_").join("");

	setZoomBigImage(modelno);

	//zoomImageDivObj.css("top", top+"px");
	//zoomImageDivObj.css("left", left+"px");
	//zoomImageDivObj.show();
	zoomImageDivObj.fadeIn();
}

function zoomImageDivHide() {
	var zoomImageDivObj = $("#zoomImageDiv");

	zoomImageDivObj.find(".bigImage").attr("src", "");
	zoomImageDivObj.find(".bigImageModelnm").html("");

	//zoomImageDivObj.hide();
	zoomImageDivObj.fadeOut();
}

function setZoomBigImage(modelno) {
	var url = "/lsv2016/ajax/getBigImageInfo_ajax.jsp";
	var param = {
		"random_seq" : random_seq,
		"modelno" : modelno
	}

	$.ajax({
		type : "post", 
		url : url, 
		async: true, 
		data : param, 
		dataType : "json", 
		success : function(json) {
			var ecatal_out_src = json["ecatal_out_src"];
			var ecatal_out_from = json["ecatal_out_from"];
			var szModelNm = json["szModelNm"];
			var strBigImageUrl = json["strBigImageUrl"];

			var zoomImageDivObj = $("#zoomImageDiv");

			if(ecatal_out_src && ecatal_out_src.length>0) {
				zoomImageDivObj.find(".zoom_info .imgSelOption").show();

				zoomImageDivObj.find(".zoom_info .img1 span").attr("imgSrc", ecatal_out_src);
				//zoomImageDivObj.find(".zoom_info .img1 span").attr("imgFrom", ecatal_out_from);
				zoomImageDivObj.find(".zoom_info .img2 span").attr("imgSrc", strBigImageUrl);

				zoomImageDivObj.find(".zoom_info span").unbind();
				zoomImageDivObj.find(".zoom_info span").click(function() {
					var thisObj = $(this);
					var parentObj = thisObj.parents(".imgSelOption");
					var imageSrc = thisObj.attr("imgSrc");

					// 이 카탈로그 클릭
					if(parentObj.hasClass("img1")) {
						zoomImageDivObj.find(".zoom_info .img2 span").removeClass("chk").addClass("unchk");
						zoomImageDivObj.find(".zoom_info .img1 span").removeClass("unchk").addClass("chk");

						zoomImageDivObj.find(".ecatal_out_fromDiv").show();
					}

					// 큰 이미지 보기 클릭
					if(parentObj.hasClass("img2")) {
						zoomImageDivObj.find(".zoom_info .img1 span").removeClass("chk").addClass("unchk");
						zoomImageDivObj.find(".zoom_info .img2 span").removeClass("unchk").addClass("chk");

						zoomImageDivObj.find(".ecatal_out_fromDiv").hide();
					}

					zoomImageDivObj.find(".bigImage").attr("src", imageSrc);
				});

				zoomImageDivObj.find(".zoom_info .img1 span").removeClass("unchk").addClass("chk");
				zoomImageDivObj.find(".zoom_info .img2 span").removeClass("chk").addClass("unchk");

				zoomImageDivObj.find(".bigImage").attr("src", ecatal_out_src);

				zoomImageDivObj.find(".ecatal_out_fromDiv").show();

				zoomImageDivObj.find(".ecatal_out_fromDiv span").html(ecatal_out_from);

				zoomImageDivObj.find(".ecatal_out_fromDiv span a").hover(
					function() {
						$(this).css("color", "#FF0000");
					},
					function() {
						$(this).css("color", "#000000");
					}
				);

			} else {
				zoomImageDivObj.find(".zoom_info .imgSelOption").hide();

				zoomImageDivObj.find(".bigImage").attr("src", strBigImageUrl);

				zoomImageDivObj.find(".ecatal_out_fromDiv").hide();
			}

			zoomImageDivObj.find(".bigImageModelnm").html(szModelNm);
		},
		error: function(request, status, error) {
			//console.log("request : " + request + "status : " + status + "error : " + error);
		}
	});

}

///////////////////////////////////////////////////// 줌 이미지 보기 스크립트 끝 /////////////////////////////////////////////////////


///////////////////////////////////////////////////// 정기점검 스크립트 시작 /////////////////////////////////////////////////////

function shopInfoLayerDivShow(thisObject) {
	var systemtooltipDivObj = $("#systemtooltipDiv");
	var thisObj = $(thisObject);
	var won_lineObj = thisObj.find(".won_line");

	var systemTooltipTxt = thisObj.attr("systemText");
	systemtooltipDivObj.find(".txt li p").html(systemTooltipTxt);

	if(systemtooltipDivObj.css("display")=="none") {
		var top = thisObj.offset().top + thisObj.height() - 22;
		var left = won_lineObj.offset().left - systemtooltipDivObj.width() - 9;

		systemtooltipDivObj.css("top", top+"px");
		systemtooltipDivObj.css("left", left+"px");

		//systemtooltipDivObj.show();
		systemtooltipDivObj.fadeIn("fast");
	}
}

function shopInfoLayerDivHide() {
	var systemtooltipDivObj = $("#systemtooltipDiv");

	if(systemtooltipDivObj.css("display")!="none") {
		//systemtooltipDivObj.hide();
		systemtooltipDivObj.fadeOut("fast");
	}
}

///////////////////////////////////////////////////// 정기점검 스크립트 끝 /////////////////////////////////////////////////////

// 모든 레이어 닫기
function allLPLayersClose() {
	compareProcBoxDivHide();
	zzimCompDivHide();
	mobileShoppingRecDivHide();
	mobileSendProdDivHide();
	shareLayerDivHide();
	mailSendLayerDivHide();
	couponInfoDivHide();
	zoomImageDivHide();
	shopInfoLayerDivHide();
}


/////////////////////////////////////////////////// LP, SRP 구버전 보기 /////////////////////////////////////////////////////

// 쿠키를 루트 도메인으로 사용함
//쿠키 읽어오기
function getOldVerCookie(c_name) {
	var i,x,y,ARRcookies = document.cookie.split(";");
	for(var i=0; i<ARRcookies.length; i++) {
		x = ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
		y = ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
		x = x.replace(/^\s+|\s+$/g,"");
		if(x==c_name) {
			return unescape(y);
		}
	}
}

//쿠키 입력
function setOldVerCookie(c_name, value, exdays) {
	var exdate=new Date();
	exdate.setDate(exdate.getDate() + exdays);
	var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
	//c_value += "; domain=" + document.domain;
	c_value += "; domain=enuri.com";
	c_value += "; path=/ ";

	document.cookie=c_name + "=" + c_value;
}

// 쿠키에 OLD_POPUP=N 라고 들어있으면 팝업 안뛰움
var findOldVerUrl = "";
function goOldUrl(oldUrl) {
	findOldVerUrl = oldUrl;

	if(listType=="LP") findOldVerUrl += gCate;
	if(listType=="SRP") findOldVerUrl += encodeURIComponent(gKeyword);

	var old_popup = getOldVerCookie("OLD_POPUP");
	if(old_popup && old_popup=="N") { // 팝업 안보이고 바로 보냄
		goOldVersionUrl();
	} else {
		oldInfoDivShow();
	}
}



function goOldVersionUrl() {
	if(findOldVerUrl.length>0) {
		window.open(findOldVerUrl);
		setNotShowOldVerLayer();
	}
}

