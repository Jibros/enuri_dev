var IMG_ENURI_COM = "http://img.enuri.info";

//$(document).ready(function() {
//});

// 페이지 로드 기본 세팅
var paramModelShow = false;

function loadBasic() {

	$("#allCheckBox").on('click', function(){
		var checked = $(this).get(0).checked;
		$("input:checkbox").not("#allCheckBox")
						   .prop('checked', checked);
	});

	$("#modelDeleteBtn").click(function (e) {
		menuItemDel();
	});


	$("#modelMoveBtn").click(function (e) {
		showZzimFolderMoveLayer();
	});

	if(listType==2) {
		$("#folderManager").click(function (e) {
			document.location.href = "zzimFolderList.jsp";
		});
	}
}

// 목록에서 아이템 삭제
function menuItemDel() {
	var delItemCnt = 0;
	var delItemList = "";


	$("input:checkbox:checked").not("#allCheckBox").each(function(){
		var $this = $(this);
		var model = $this.attr('id');
		if( !$this.is(":checked")){
			return;
		}

		delItemCnt++;
		delItemList += model.substr(0,1) + ":" + model.substr(1) + ",";

	});

//	for(var i=0; i<listGoodsModelnos.length; i++) {
//		var tempGoodId = listGoodsModelnos[i].replace(":", "");
//		var checked = false;
//		try{
//			checked = document.getElementById(tempGoodId).checked;
//		}catch(e){
//			continue;
//		}
//		if(checked) {
//			delItemCnt++;
//			delItemList += listGoodsModelnos[i] + ",";
//		}
//	}

	if(delItemCnt==0) {
		alert("삭제할 상품을 선택해 주세요.");

		return;
	}

	if(!confirm("선택한 상품을 삭제하시겠습니까?")) {
		return;
	}

	var vResentList = "";

	if(listType==1) {
		for(var i=0; i<showGoodsCnt; i++) {
			var tempGoodId = listGoodsModelnos[i].replace(":", "");

			var checked = false;
			try{
				checked = document.getElementById(tempGoodId).checked;
			}catch(e){
				continue;
			}

			if(checked) {
				var tempModelnoAry = listGoodsModelnos[i].split(":");

				if(vResentList.length == 0){
					vResentList = listGoodsModelnos[i];
				}else{
					vResentList = vResentList +","+ listGoodsModelnos[i];
				}

				if(tempModelnoAry!=null && tempModelnoAry.length==2) {
					deleteStorageGoods("resentList", tempModelnoAry[1], tempModelnoAry[0]);
					$("#" + tempGoodId).parent()
							.parent()
							.parent()
							.remove();

					try {
						loadResentZzimCnt();
						//setTimeout("setTopMenuCnts()", 1000);



					} catch(e) {}
				}
			}

			if(i == (showGoodsCnt-1)){
				try{
					if(window.android){		// 안드로이드
			    		window.android.delRecentList(vResentList);
			    	}else{							// 아이폰에서 호출
			    		//window.location.href = "appcall://getRecentData?name="+encodeURIComponent(thisName)+"&code=P:"+encodeURIComponent(thisId)+"&imageurl="+encodeURIComponent($("#img_"+thisId).attr("src"))+"&url="+encodeURIComponent(newUrl)+"";
			    		window.location.href = "enuriappcall://deleteRecentData?code="+encodeURIComponent(vResentList)+"";
			    	}
				}catch(e){}
			}
		}
	}

	if(listType==2) {
		// 이전 버전 삭제 하던 모듈은 그대로 사용함
		var url = "/view/deleteSaveGoodsProc.jsp";
		var param = "modelnos="+delItemList+"&tbln=save";

		$.ajax({
			type : "post",
			url : url,
			data : param,
			dataType : "html",
			success : function(ajaxResult) {
				setFolderSelectList();
				var arr = delItemList.split(",");
				for(var i=0; i<arr.length; i++){
					var id = $.trim(arr[i].replace(":", ""));


					//백화점상품인지 아닌지 클래스 로 확인
					var deptCheck = $("#" + $.trim(id)).parent().parent().attr("class");

					if(id){

						//백화점 일경우 한단계 위 삭제
						if(deptCheck == 'prodPr'){

								$("#" + $.trim(id)).parent()
								.parent()
								.parent()
								.parent()
								.remove();

						}else{ //일반 상품

								$("#" + $.trim(id)).parent()
								.parent()
								.parent()
								.remove();

						}
					}


				}

				// 페이징 세팅
				var pagingListObj = $("#container .pagination");
				//var pagingListPrevObj = $("#container .pagination .pagingPrev");
				var pagingListNextObj = $(".moreBtn");
				var pagingListSpanStrongObj = $("#container .pagination span strong");
				listGoodsCnt -= delItemCnt;
				listGoodsCnt = $(".prodList > ul > li").size();
				var totalPage = Math.ceil(listGoodsCnt/pageGap);
				listGoodsPageItemNum = (loadPageNum-1) * pageGap + showGoodsCnt - delItemCnt;
				$(".moreBtn span").html("더보기 (" + listGoodsPageItemNum + "/" +listGoodsCnt + ")");

				// 찜하기 버튼 체크
				if($(".prodList > ul > li").size() > 0) {
					//zzimCheckSet();
					// 총 개수를 세팅
					$(".listTotalNum .showCnt").html(listGoodsCnt+"건");

				}else{
					$("#container .nonTxt").html("찜한 상품이 없습니다.");
					loadBodyItems(folder_id, loadPageNum);
					$("#container .nonTxt").css("display", "block");
				}

				pagingListObj.find(".pageLink").unbind();
				pagingListNextObj.off('click').on('click', function (e) {
					var idNum = $(this).attr("pageNum");
					var intIdNum = -1;
					try {
						intIdNum = parseInt(idNum) -1;
					} catch(e) {}
					if($("#container .nonTxt").is(':visible')){
					}else{
						loadBodyItems(folder_id, intIdNum); // ajax로 페이지 변환
					}
				}).trigger('click');


				//loadBodyItems(folder_id, loadPageNum);

//				try {
//					if(window.android) {
//						loadResentZzimCntAnd();
//					} else {
//						loadResentZzimCnt();
//					}
//					setTopMenuCnts();
//				} catch(e) {}
			}
		});
	} else {
		if(listType==1) {
			// 페이징 세팅
			var pagingListObj = $("#container .pagination");
			//var pagingListPrevObj = $("#container .pagination .pagingPrev");
			var pagingListNextObj = $(".moreBtn");
			var pagingListSpanStrongObj = $("#container .pagination span strong");
			listGoodsCnt -= delItemCnt;
			var totalPage = Math.ceil(listGoodsCnt/pageGap);
			listGoodsPageItemNum = (loadPageNum-1) * pageGap + showGoodsCnt - delItemCnt;
			$(".moreBtn span").html("더보기 (" + listGoodsPageItemNum + "/" +listGoodsCnt + ")");

			// 찜하기 버튼 체크
			if($(".prodList > ul > li").size() > 0) {
				zzimCheckSet();
				// 총 개수를 세팅
				$(".listTotalNum .allCnt").html(listGoodsCnt+"건");
			}else{
				loadBodyItems(folder_id, loadPageNum);
			}
		}
	}

}

function setTopMenuCnts() {

	if(listType==1) {
		$("#resent_cnt a").html("최근 본 상품("+listGoodsAllCnt+")");
	}
	if(listType==2) {
		$("#zzim_cnt a").html("찜 한 상품("+listGoodsAllCnt+")");
	}
}

// 최근본 목록에서 찜함
function menuZzim() {
	var zzimItemCnt = 0;

	for(var i=0; i<showGoodsCnt; i++) {
		if(listGoodsCheckBox[i]==1) {
			zzimItemCnt++;
		}
	}

	if(zzimItemCnt==0) {
		alert("찜 할 상품을 선택해 주세요.");

		return;
	}

	// 로그인을 했으면
	if(IsLogin()) {
		var checkItemList = "";

		for(var i=0; i<showGoodsCnt; i++) {
			// 추가검색 상품도 찜이 가능하게
			//if(listGoodsCheckBox[i]==1 && listGoodsModelnos[i].indexOf("P:")<0) {
			if(listGoodsCheckBox[i]==1) {
				checkItemList += listGoodsModelnos[i] + ",";
			}
		}

		insertZzimProcNew(checkItemList);
	} else {
		goLogin();
	}
}

function insertZzimProcNew(varChkModelNos) {
	// 추가검색 상품도 찜이 가능하게 바꾸기
	var tempvarChkModelNos = varChkModelNos;

	var url = "/mobilefirst/ajax/resentZzim/insertSaveGoodsProc.jsp";
	var param = "modelnos="+tempvarChkModelNos;

	$.ajax({
		type : "post",
		url : url,
		data : param,
		dataType : "json",
		success : function(ajaxResult) {
			if(ajaxResult["count"]==0) { // 실제로 찜된 상품이 0개 일경우
				// 이미 찜한 상품입니다.
				zzimMessageDivShow(2);
			} else {
				// 찜 되었습니다.
				zzimMessageDivShow(1);
			}
		}
	});
}


function goDetail(modelno,url){

	//var detailUrl = "/mobiledepart/detail.jsp?modelno="+modelno;
	var detailUrl = "/mobilefirst/detail.jsp?modelno="+modelno;

	//if(modelno > 0){
//		alert(11);
		window.location.href = detailUrl;
	//}


}

//type=1 : 찜이 되었을때
//type=2 : 체크된상품이 모두 이미 찜되어있을껑우
function zzimMessageDivShow(type) {
	var messageTxt = "";
	if(type==1) {
		zzimInfoShow(1);
	}
	if(type==2) {
		zzimInfoShow(2);
	}
}

//페이지 UI의 사이즈를 조절하는 스크립트 연결
function sizeSet() {
	sizeChangeCss();

	$(window).unbind();
	$(window).resize(function() {
		sizeChangeCss();
	});
}

function sizeChangeCss() {
	var tempWidth = $(window).width();

	// 공통
	$("#goodsList .itemContent .itemSpec").css("width",  tempWidth - 124);
	$("#goodsList .itemContent .itemSpecP").css("width",  tempWidth - 124);
}


//resentList, zzimList1, zzimList2, zzimList3, zzimList4, zzimList5
//getGoodsListStorage(name)
//페이징 처리 필요
var pageNum = 1;
var pageGap = 50;
var listGoodsCnt = 0; // 최근 본이나 찜의 모든 상품의 수를 저장
var listGoodsAllCnt = 0; // 최근 본이나 찜의 모든 상품의 수를 저장
var listGoodsModelnos = null;
var showGoodsCnt = 0;
var oldCheckIdNum = -1;
var listGoodsPageItemNum = 0;
function loadBodyItems(tempFolder_id, sPageNum) {
	var loadFolder_id = 1;
	if(tempFolder_id>0) loadFolder_id = tempFolder_id;

	var loadGoodsList = "";
	listGoodsCnt = 0;


	if(listType==1) {
		loadGoodsList = getCookie("resentList");

		if(loadGoodsList!=null && loadGoodsList.length>0) {
			var tempGoodsAry = loadGoodsList.split(",");
			for(var i=0; i<tempGoodsAry.length; i++) {
				if(tempGoodsAry[i].length>0) {
					listGoodsCnt++;
				}
			}
		}
	}

	// DB를 통해 데이터를 읽어옴
	var loadParam = "listType="+listType+"&folder_id="+loadFolder_id+"&deviceType=m";

	if(listType==1 && !paramModelShow) {
		loadParam += "&goodsNumList="+loadGoodsList;
	}

	// 모델번호를 이용해 그냥 데이터를 읽어옴
	if(paramModelShow) {
		loadGoodsList = showModelnos;
		loadParam = "listType="+listType+"&folder_id="+loadFolder_id;

		loadParam += "&mailYN=Y"; // mailYN일경우 넘어간 goodsNumList로 데이터를 조회해옴
		loadParam += "&goodsNumList="+loadGoodsList;
	}

	loadParam += "&deviceType=m&pageNum="+sPageNum+"&pageGap="+pageGap;

	var nonTxtObj = $(".nonTxt");
	nonTxtObj.css("display", "none");

	var prodListUlObj = $("#container .prodList ul");
	//prodListUlObj

	folder_id = tempFolder_id;

	// 로딩중 시작
	loadingStart();

	$.ajax({
		type: "GET",
		url: "/mobilefirst/ajax/resentZzim/Ajax_goodsListNew.jsp",
		async: false,
		data: loadParam,
		dataType:"JSON",
		success: function(result){
			var jsonObj = result["goodsList"];
			var listHtml = "";

			// 최근본이나 찜의 전체 개수를 구함
			try {
				listGoodsCnt = parseInt(result["myGoodsTotalCnt"]);
			} catch(e) {}
			try {
				listGoodsAllCnt = parseInt(result["myGoodsAllTotalCnt"]);
			} catch(e) {}

			showGoodsCnt = 0;
			if(jsonObj!=null) {
				listGoodsModelnos = new Array();

				var tempModelnos = "";
				$.each(jsonObj, function(indexI, listObj) {
					showGoodsCnt++;

					listGoodsModelnos[indexI] = listObj["modelnoID"];
					listGoodsModelnos[indexI] = listGoodsModelnos[indexI].replace("P", "P:");
					listGoodsModelnos[indexI] = listGoodsModelnos[indexI].replace("G", "G:");

					tempModelnos += listGoodsModelnos[indexI] + ",";
				});

				goodsNumbers = tempModelnos;
			}

			if(jsonObj!=null) {

				var template = "";

			    Mustache.parse(); // optional, speeds up future uses
//				$.each(jsonObj,function(i,v){
//					showGoodsCnt++;
//					listGoodsModelnos[i] = v["modelnoID"].replace("P", "P:").replace("G", "G:");
//				//	listGoodsModelnos[indexI] = listGoodsModelnos[indexI]
//				//	listGoodsModelnos[indexI] = listGoodsModelnos[indexI]
//				//	tempModelnos += listGoodsModelnos[i] + ",";
//
//					if(v.plnoGoodFlag){
//						v.factory = "업체 "+ v.mallcnt;
//					}
//
//					if(v.minpriceTextFlag == 'Y'){
//						v.minLabel = "최저가";
//					}
//
//					if(!v.minprice){
//						v.minprice = v.minpriceText;
//					}
//
//		            rendered.push(Mustache.render(template, v));
//				});
			    //var tpl = $(listType==2 ? '#zzim_template' : '#goods_template').html();
			    var tpl = "";

			    if(listType==1){
			    	tpl = $('#goods_template').html();
			    }

				var	rendered = [];

				$.each(jsonObj,function(i,v){

				if(v.dept_yn == 'Y'){

		    		tpl = $('#zzim_dept_template').html();
		    	}else{
		    		if(listType==1){
		    			tpl = $('#goods_template').html();
		    		}else{
		    			tpl = $('#zzim_template').html();
		    		}

		    	}


				if($("#" + v.modelnoID).size() > 0){
					return;
				}


				//if(listType==1){ //최근본

				//if(v.dept_yn == 'Y' ){//백화점 일 경우



				//}else{

					if(v.modelno > 0) v.eGood = 'Y'; //에누리 가격비교 상품

					if(v.plnoGoodFlag){
						//v.factory = "업체 "+ v.mallcnt;

					}else{

						if( v.mallcnt <= 10){
						//v.factory = '';
						}

					}

					if(v.minpriceTextFlag == 'Y'){
						v.minLabel = "<span class=\"min\">최저가</span>";
					}


					if(v.dept_yn == 'Y' && v.shopCode == 0 && v.departLogo == ''){//백화점 일 경우
						v.minprice = "";
						v.minPriceText = "단종/품절";
					}


					if(v.minPriceText == '단종/품절'){
						v.minPriceText = "<em class=\"soldout\">단종/품절</em>";
					}else if(v.minPriceText == '출시예정' || v.minPriceText == '별도확인'){
						v.minPriceText = "<em class=\"release\">" + v.minPriceText + "</em>";
					}

					modelnm = v.modelnm;
					v.modelnm = modelnm.replace("&amp;amp;","&amp;");

					if(v.c_dateStr){
						if(v.c_dateStr == "출시예정"){
						}else{
							v.c_dateStr = "등록일 "+v.c_dateStr.replace('출시', '');
						}
					}

					if(v.modelno == 0){
						v.factory_etc = '';
					}

					rendered.push(Mustache.render(tpl, v));
				//}

				});

				prodListUlObj.append(rendered.join(""));
				//var html = Mustache.to_html(template, result);
				//prodListUlObj.html(template);

			}
			if(listGoodsCnt==0) {
				var nonTxtStr = "";
				if(listType==1) {
					nonTxtStr = "최근 본 상품이 없습니다.";
				}
				if(listType==2) {
					nonTxtStr = "찜한 상품이 없습니다.";
				}
				$("#container .nonTxt").html(nonTxtStr);
				$("#container .nonTxt").css("display", "block");

				$("#container .listTotalNum").css("visibility", "hidden");
				$("#container .pagination").css("visibility", "hidden");
				$("#modelMoveBtn").css("visibility", "hidden");
				$("#modelDeleteBtn").css("visibility", "hidden");
			} else {
				$("#container .nonTxt").html("");

				$("#container .listTotalNum").css("visibility", "");
				$("#container .pagination").css("visibility", "");
				$("#modelMoveBtn").css("visibility", "");
				$("#modelDeleteBtn").css("visibility", "");
			}

			prodListUlObj.find(".prodThum").unbind();
			prodListUlObj.find(".prodThum").click(function (e) {
				var modelnoID = $(this).parent().attr("modelnoID");
				var adultImageFlag = $(this).attr("adultImageFlag");

				if(adultImageFlag=="Y") {
					goALogin();
				} else {
					if(modelnoID.indexOf("P")>-1) {
						/*
						var shopcode = $(this).parent().attr("shopcode");
						var goodscode = $(this).parent().attr("goodscode");
						var instance_price = $(this).parent().attr("instance_price");
						var ca_code = $(this).parent().attr("ca_code");
						var url = $(this).parent().attr("url");
						var price = $(this).parent().attr("price");

						goShop(url, shopcode, modelnoID.substring(1), goodscode, instance_price, ca_code, price, 0, this);
						*/

						var url = $(this).parent().attr("url");
						var shopcode = $(this).parent().attr("shopcode");
						var modelno = modelnoID.substring(1);

						addResentZzimItem(1, "P", modelno);
						goNomalGoods(modelno,url,shopcode);

					} else {
						moveGoodsPage(modelnoID);
					}
				}
			});

			prodListUlObj.find(".prodSection").unbind();
			prodListUlObj.find(".prodSection").click(function (e) {
				var modelnoID = $(this).parent().attr("modelnoID");

				if(modelnoID.indexOf("P")>-1) {
					/*
					var shopcode = $(this).parent().attr("shopcode");
					var goodscode = $(this).parent().attr("goodscode");
					var instance_price = $(this).parent().attr("instance_price");
					var ca_code = $(this).parent().attr("ca_code");
					var url = $(this).parent().attr("url");
					var price = $(this).parent().attr("price");

					goShop(url, shopcode, modelnoID.substring(1), goodscode, instance_price, ca_code, price, 0, this);
					*/

					//moveGoodsPage(modelnoID);
					//addResentZzimItem(1, "P", modelnoID.substring(1));

					var url = $(this).parent().attr("url");
					var shopcode = $(this).parent().attr("shopcode");
					var modelno = modelnoID.substring(1);

					addResentZzimItem(1, "P", modelno);
					goNomalGoods(modelno,url,shopcode);

				} else {
					moveGoodsPage(modelnoID);
				}
			});

			// 페이징 세팅
			var pagingListObj = $("#container .pagination");
			//var pagingListPrevObj = $("#container .pagination .pagingPrev");
			var pagingListNextObj = $(".moreBtn");
			var pagingListSpanStrongObj = $("#container .pagination span strong");
			var totalPage = Math.ceil(listGoodsCnt/pageGap);
			//if(sPageNum>1) {
			//	pagingListPrevObj.css("visibility", "visible");
			//	pagingListPrevObj.attr("pageNum", (sPageNum-1));
			//} else {
			//	pagingListPrevObj.css("visibility", "hidden");
			//}
			listGoodsPageItemNum = (sPageNum-1) * pageGap + showGoodsCnt;
			$(".moreBtn span").html("더보기 (" + listGoodsPageItemNum + "/" +listGoodsCnt + ")");
			if(sPageNum<totalPage) {
				pagingListNextObj.css("visibility", "visible");
				pagingListNextObj.attr("pageNum", (sPageNum+1));
			} else {
				pagingListNextObj.css("visibility", "hidden");
				$(".moreBtn").css("display", "none");
			}

			pagingListObj.find(".pageLink").unbind();
			pagingListNextObj.off('click').on('click', function (e) {
				var idNum = $(this).attr("pageNum");
				var intIdNum = -1;
				try {
					intIdNum = parseInt(idNum);
				} catch(e) {}
				loadBodyItems(tempFolder_id, intIdNum); // ajax로 페이지 변환
			});

			if(showGoodsCnt==0) nonTxtObj.css("display", "block");

			// 찜하기 버튼 체크
			if(listType==1) {
				zzimCheckSet();

				// 총 개수를 세팅
				$(".listTotalNum .allCnt").html(listGoodsCnt+"건");
			} else {
				// 총 개수를 세팅

				$(".listTotalNum .showCnt").html(listGoodsCnt+"건");

				//$(".listTotalNum .allCnt").html(listGoodsAllCnt+"건");
			}

			loadingEnd();

			$("#container").css("display", "block");

			document.getElementById("allCheckBox").checked = false;
		}
	});
}

/*
function getBbs_cnt(){

	var vData = "";
	if(vGroup == 1){
		vData = "modelno="+_modelno_group+"&group="+vGroup;
	}else{
		vData = "modelno="+_modelno+"&group="+vGroup;
	}

	$.ajax({
		type: "GET",
		url: "/mobiledepart/ajax/detail/getDetail_Review_Cnt.jsp",
		data: vData,
		dataType:"JSON",
		success: function(json){
			if(json.reviewCount != ""){
				$("#rv_cnt").text("("+ json.reviewCount +")");
			}
		}
	});

}
*/


function goNomalGoods(plno,newUrl,shopcode){

	var vAppyn = getCookie("appYN");

	if(vAppyn == "Y"){
	  var d = new Date();
	  var curr_hour = d.getHours();
	  var curr_min = d.getMinutes();

	  var curr_sec = d.getSeconds();
	  var curr_msec = d.getMilliseconds();

	  var newWin = window.open("/mobilefirst/move.jsp?freetoken=outlink&vcode="+shopcode+"&plno="+ plno +"&url="+encodeURIComponent(newUrl)+"&ch="+curr_hour+curr_min+curr_sec+curr_msec);
	}else{

	  var newWin = window.open(newUrl);
	}

}

//폴더 정보를 읽어옴
//folder_use:로컬 스토리지에 폴더가 사용중인지 정보를 저장함
var folder_id = 1; // 현재 선택된 폴더, 디폴트는 1
var maxFolderCnt = 5;
//var nowFolderCnt = 0; localStorage.js에 선언
var folderNameAry = ["찜폴더1", "찜폴더2", "찜폴더3", "찜폴더4", "찜폴더5"];
var folderItemsCnt = [0, 0, 0, 0, 0]; // 폴더가 생성되면 -1보다 큼 첫번째 폴더는 데이터의 유무에 상관없이 보임
var folderShowFlag = [1, 0, 0, 0, 0]; // 폴더가 있으면 1 없으면 0 로컬스토리지와 연동해야함
var folderItemsMaxCnt = [50, 50, 50, 50, 50];
function loadFolderList() {
	if(IsLogin()) {
		setFolderSelectList();
	}
}

//찜 폴더와 폴더의 개수를 읽어오는 함수
//folderItemsCnt 배열에 찜의 개수를 저장함
function setFolderSelectList() {
	// 로그인 했을 경우
	if(listType==2) {
		var loadUrl = "/view/resentzzim/ajax/Ajax_zzimFolderList.jsp";

		$.getJSON(loadUrl, null, function(data) {
			folderJsonObj = data["folderList"];

			for(var i=0; i<5; i++) {
				folderShowFlag[i] = 0;
				folderItemsCnt[i] = 0;
			}

			try {
				zzimFolderCnt = parseInt(data["folderCnt"]);
			} catch(e) {}

			nowFolderCnt = 0;
			$.each(folderJsonObj, function(indexI, folderListObj) {
				var tempFolder_id = folderListObj["folder_id"];
				var tempFolder_cnt = folderListObj["folder_cnt"];
				var intTempFolder_id = 0;
				var intTempFolder_cnt = 0;
				try {
					intTempFolder_id = parseInt(tempFolder_id);
				} catch(e) {}
				try {
					intTempFolder_cnt = parseInt(tempFolder_cnt);
				} catch(e) {}

				// 폴더의 아이템개수 세팅
				try {
					if(intTempFolder_cnt>0) {
						folderItemsCnt[intTempFolder_id-1] = intTempFolder_cnt;
					}
				} catch(e) {}
				folderShowFlag[intTempFolder_id-1] = 1;

				nowFolderCnt++;
			});

			setFolderUI();
			setZzimFolderMove();
		});
	}
}

var oldMoveBtnImgObj = null;
var selectedFolderId = 0;
function setZzimFolderMove() {
	if(listType==2) {
		selectedFolderId = 0;

		var zzimMoveLayerCancelObj = $("#zzimMoveLayerCancel");
		var zzimMoveLayerOkObj = $("#zzimMoveLayerOk");
		var zzimMoveLayerXObj = $("#zzimMoveLayerX");

		zzimMoveLayerXObj.unbind();
		zzimMoveLayerXObj.click(function (e) {
			hideZzimFolderMoveLayer();
		});

		zzimMoveLayerCancelObj.unbind();
		zzimMoveLayerCancelObj.click(function (e) {
			hideZzimFolderMoveLayer();
		});

		zzimMoveLayerOkObj.unbind();
		zzimMoveLayerOkObj.click(function (e) {
			// 2번째 폴더가 없으면 이동할 폴더가 없는 것임
			if(folderShowFlag[1]==0) {
				alert("이동할 찜폴더가 없습니다.\n관리에서 찜폴더를 추가해 주세요.");

				return;
			}

			var selectedItemCnt = 0;
			for(var i=0; i<listGoodsModelnos.length; i++) {
				var tempGoodId = listGoodsModelnos[i].replace(":", "");
				var checked = false;
				try{
					checked = document.getElementById(tempGoodId).checked;
				}catch(e){
					continue;
				}

			}
			if((folderItemsCnt[selectedFolderId-1]+selectedItemCnt) > folderItemsMaxCnt[selectedFolderId-1]) {
				alert("찜폴더가 꽉 찼습니다.\n해당 찜폴더 상품을 삭제하거나\n다른 찜폴더를 선택해 주세요.");

				return;
			}

			if(selectedFolderId>0) {
				moveFolderItems(selectedFolderId);
			}
		});

		var zzimMoveFoldersObj = $("#zzimMoveLayerSec .zzimlist");
		var folderMoveLayerHtml = "";
		var showMoveFolderCnt = 0;
		for(var i=0; i<nowFolderCnt; i++) {
			var tempFolder_id = i+1;
			var tempFolder_cnt = folderItemsCnt[i];

			if(tempFolder_id!=folder_id) {
				folderMoveLayerHtml += "<li><a href=\"JavaScript:\" id=\"selMoveFolder"+tempFolder_id+"\" folderid=\""+tempFolder_id+"\" class=\"selMoveFolder\">찜폴더"+tempFolder_id+" ("+tempFolder_cnt+")</a></li>";

				showMoveFolderCnt++;
			}
		}
		zzimMoveFoldersObj.html(folderMoveLayerHtml);

		zzimMoveFoldersObj.find(".selMoveFolder").unbind();
		zzimMoveFoldersObj.find(".selMoveFolder").click(function (e) {
			var strFolderid = $(this).attr("folderid");
			var intFolderid = 0;

			try {
				intFolderid = parseInt(strFolderid);
			} catch(e) {}

			if(selectedFolderId!=intFolderid) {
				if(intFolderid>0) {
					if(selectedFolderId>0) {
						$("#selMoveFolder"+selectedFolderId).removeClass("on");
					}

					selectedFolderId = intFolderid;

					$(this).addClass("on");
				}
			}
		});
	}
}

function showZzimFolderMoveLayer() {
	var zzimMoveLayerSecObj = $("#zzimMoveLayerSec");
	var zzimMoveBackDivObj = $("#zzimMoveBackDiv");

	if(zzimMoveLayerSecObj.css("display")=="none") {
		var selectedItem = 0;
		for(var i=0; i<listGoodsModelnos.length; i++) {
			var tempGoodId = listGoodsModelnos[i].replace(":", "");
			var checked = false;
			try{
				checked = document.getElementById(tempGoodId).checked;
				if(checked){
					selectedItem++;
				}
			}catch(e){
				continue;
			}

			if(checked ) {
			//	selectedItem++;
			}
		}

		if(selectedItem==0) {
			alert("선택된 상품이 없습니다.\n상품을 선택해 주세요.");

			return;
		}
		if(nowFolderCnt==1) {
			alert("이동할 찜폴더가 없습니다.\n관리에서 찜폴더를 추가해 주세요.");

			return;
		}

		setZzimFolderMove();

		zzimMoveLayerSecObj.css("display", "block");
		zzimMoveBackDivObj.css("display", "block");
	} else {
		hideZzimFolderMoveLayer();
	}
}

function hideZzimFolderMoveLayer() {
	var zzimMoveLayerSecObj = $("#zzimMoveLayerSec");
	var zzimMoveBackDivObj = $("#zzimMoveBackDiv");

	zzimMoveLayerSecObj.css("display", "none");
	zzimMoveBackDivObj.css("display", "none");
}

//폴더 생성
function createFolderAction() {
	if(nowFolderCnt>=5) {
		alert("폴더는 5개까지만 생성 가능합니다.");
		return;
	}

	// 로그인 했을 경우
	if(listType==2) {
		var url = "/view/resentzzim/ajax/Ajax_createGoodsFolder.jsp";
		var param = "";

		$.ajax({
			type : "post",
			url : url,
			data : param,
			dataType : "html",
			success : function(ajaxResult) {
				alert("새 폴더가 생성되었습니다.");

				setFolderSelectList();
				menuClose();

				// 폴더 생성할때 찜폴더 리스트 열기
				var folderSelectObj = $("#zzimFolderList #folderSelect");
				folderSelectObj.trigger("click");

			}
		});
	}
}

//현재 선택된 폴더를 삭제함
function deleteFolderAction() {
	// 현재 리스트의 아이템 개수가 0보다 크면 삭제 문구 생성
	if(folderItemsCnt[folder_id-1]>0) {
		if(!confirm("해당 폴더에 담긴 상품이 모두 삭제됩니다.\n삭제하시겠습니까?")) {
			return;
		}
	}

	// 로그인 했을 경우
	if(listType==2) {
		var url = "/view/resentzzim/ajax/Ajax_deleteGoodsFolder.jsp";
		var param = "folder_id="+folder_id;

		$.ajax({
			type : "post",
			url : url,
			data : param,
			dataType : "html",
			success : function(ajaxResult) {
				alert("폴더가 삭제되었습니다.");

				folder_id = 1;
				loadBodyItems(folder_id, 1);
				setFolderSelectList();

			}
		});
	}
}

//특정 폴더로 이동
function moveFolderItems(moveFolder_id) {
	var moveItemsCnt = 0;
	var selectedMoveItems = "";

	$("input:checkbox:checked").not("#allCheckBox").each(function(){
		var $this = $(this);
		var model = $this.attr('id');
		if( !$this.is(":checked")){
			return;
		}

		moveItemsCnt++;
		selectedMoveItems += model.substr(0,1) + ":" + model.substr(1) + ",";

	});

//	for(var i=0; i<showGoodsCnt; i++) {
//		alert(listGoodsModelnos[i]);
//		var tempGoodId = listGoodsModelnos[i].replace(":", "");
//		var checked = false;
//		try{
//			checked = document.getElementById(tempGoodId).checked;
//		}catch(e){
//			continue;
//		}
//
//		if(checked) {
//			moveItemsCnt++;
//			selectedMoveItems += listGoodsModelnos[i]+",";
//		}
//	}

	if((moveItemsCnt+folderItemsCnt[moveFolder_id-1])>folderItemsMaxCnt[moveFolder_id-1]) {
		alert("이동할 폴더에 저장공간이 없습니다.\n상품 삭제 후 이동하세요.");

		return;
	}

	// 로그인 했을 경우
	if(listType==2) {
		//selectedMoveItems = selectedMoveItems.split("G:").join("");

		var url = "/view/resentzzim/ajax/Ajax_moveGoodsFolder.jsp";
		var param = "folder_id="+moveFolder_id+"&selectedMoveItems="+selectedMoveItems;

		$.ajax({
			type : "post",
			url : url,
			data : param,
			dataType : "html",
			success : function(ajaxResult) {
				setFolderSelectList();

				alert("정상 이동되었습니다.");
				hideZzimFolderMoveLayer();

				//loadBodyItems(folder_id, 1);
				var arr = selectedMoveItems.split(",");
				for(var i=0; i<arr.length; i++){
					var id = $.trim(arr[i].replace(":", ""));
					if(id){
						$("#" + $.trim(id)).parent()
						.parent()
						.parent()
						.remove();
					}
				}



				// 페이징 세팅
				var pagingListObj = $("#container .pagination");
				//var pagingListPrevObj = $("#container .pagination .pagingPrev");
				var pagingListNextObj = $(".moreBtn");
				var pagingListSpanStrongObj = $("#container .pagination span strong");
				listGoodsCnt -= moveItemsCnt;
				var totalPage = Math.ceil(listGoodsCnt/pageGap);
				listGoodsPageItemNum = (loadPageNum-1) * pageGap + showGoodsCnt - moveItemsCnt;
				$(".moreBtn span").html("더보기 (" + listGoodsPageItemNum + "/" +listGoodsCnt + ")");

				// 찜하기 버튼 체크

				if($(".prodList > ul > li").size() > 0) {
					//zzimCheckSet();
					// 총 개수를 세팅
					$(".listTotalNum .showCnt").html(listGoodsCnt+"건");
				}else{
					$("#container .nonTxt").html("찜한 상품이 없습니다.");
					loadBodyItems(folder_id, loadPageNum);
					$("#container .nonTxt").css("display", "block");
				}

				pagingListObj.find(".pageLink").unbind();
				pagingListNextObj.off('click').on('click', function (e) {
					var idNum = $(this).attr("pageNum");
					var intIdNum = -1;
					try {
						intIdNum = parseInt(idNum) -1;
					} catch(e) {}
						if($("#container .nonTxt").is(':visible')){
						}else{
							loadBodyItems(folder_id, intIdNum); // ajax로 페이지 변환
						}
				}).trigger('click');

			}
		});
	}
}

function setFolderUI() {
	var zzimFolderSelObj = $("#zzimFolderSel");
	var folderTotalCnt = 0;

	zzimFolderSelObj.html("");
	for(var i=0; i<folderShowFlag.length; i++) {
		if(folderShowFlag[i]==1) {
			var checkedStr = "";
			if(i==(folder_id-1)) checkedStr = "selected";
			zzimFolderSelObj.append("<option value=\""+(i+1)+"\" "+checkedStr+">찜폴더"+(i+1)+"</option>");

			folderTotalCnt += folderItemsCnt[i];
		}
	}

	zzimFolderSelObj.change(function (e) {
		var tempFolderId = parseInt($(this).val());
		$(".prodList > ul").empty();
		loadBodyItems(tempFolderId, 1);
	});
}


$(function() {
	$("#container").css("display", "none");

	// 페이지 로드 기본 세팅
	loadBasic();

	// 폴더 개수 세팅
	if(listType==2) {
		loadFolderList();
	}

	//loadBodyItems(0, loadPageNum);
	setTimeout("loadBodyItems(1, "+loadPageNum+")", 100);

	try {
		if(window.android) {
			$("#backArrowA").css("display", "none");
		}
	} catch(e) {}

	try {
		if(listType==1) {
			//insertLog('11037');
		}
		if(listType==2) {
			//insertLog('11038');
		}
	} catch(e) {}

	// 전체 선택 처리여부
	$("body").on('click', 'input:checkbox', function (){
		if($(this).is("#allCheckBox")){
			return;
		}

		var isAll = true;
		$("input:checkbox").not("#allCheckBox").each(function(){
			if(!this.checked){
				isAll = false;
				return true;
			}

		});

		$("#allCheckBox").prop('checked', isAll);
	});
});
