var IMG_ENURI_COM = "http://img.enuri.gscdn.com";
var PHOTO_ENURI_COM = "http://photo3.enuri.com";
var STORAGE_ENURI_COM = "http://storage.enuri.gscdn.com";
var BLANK_IMG = IMG_ENURI_COM + "/images/blank.gif";
var rzRoot = IMG_ENURI_COM + "/images/view/resentzzim/";
var rzRoot20140221 = IMG_ENURI_COM + "/images/view/resentzzim/20140221/";

//브라우져 버전 확인
var useragent = navigator.userAgent;
var appversion = navigator.appVersion;
var ieVer = getBrowserType();
function getBrowserType() {
	var trident = useragent.match(/Trident\/(\d.\d)/i);
	var rtnValue = "";

	if(useragent.toLowerCase().indexOf("safari")>-1) {
		rtnValue = "safari";
	}
	if(useragent.toLowerCase().indexOf("firefox")>-1) {
		rtnValue = "firefox";
	}
	if(useragent.toLowerCase().indexOf("chrome")>-1) {
		rtnValue = "chrome";
	}
	if(useragent.toLowerCase().indexOf("msie 7.0")>-1) {
		rtnValue = "ie7";
	}
	if(trident != null && trident[1] == "4.0") {
		if(useragent.toLowerCase().indexOf("msie 8.0")>-1) {
			rtnValue = "ie8";
		}
	}
	if(trident != null && trident[1] == "5.0") {
		rtnValue = "ie9";
	}
	if(trident != null && trident[1] == "6.0") {
		rtnValue = "ie10";
	}

	return rtnValue;
}

// 호환성보기 모드 체크
function getBrowserCompatibleType(tempIeVer) {
	var rtnValue = 0;
	// rtnValue==1 : 호환성보기
	// rtnValue==2 : 일반
	if(tempIeVer=="ie10") {
		try {
			if(useragentJsp.toLowerCase().indexOf("msie 7.0")>-1) rtnValue = 1;
			if(useragentJsp.toLowerCase().indexOf("msie 10.0")>-1) rtnValue = 2;
		} catch(e) {}
	}

	return rtnValue;
}

// 문서 로딩 후 시작
$(document).ready(function() {
	// 클립보드 저장 세팅
	initZeroClipboard();

	// URL, 즐찾, 메일, 인쇄 세팅 메뉴 리스트 읽어오기
	loadListSubMenuDiv();

	// 최근본 찜 이동 버튼 세팅
	loadMoveResentZzimButton();
	
	// 폴더정보 세팅
	if(listType==2) {
		loadZzimFolder();
	}

	// 현재 목록 읽어오기
	loadGoodsList(1);
	
	// 찜이나 최근본의 개수를 읽어와서 페이지 재세팅
	if(mailYN!="Y") {
		loadResentZzimCnt();
	}

	// 최근본에서 찜을 햇을 경우에만 나오는 메세지
	if(listType==1 || listType==9) {
		loadZzimMessage();

		if(listType==1) insertLog(2421);
		if(listType==9) insertLog(9873);
		
	}
	if(listType==2) {
		insertLog(2420);
	}
});

// 최근본에서 찜을 햇을 경우에만 나오는 메세지
function loadZzimMessage() {
	var zzimMessageDivObj = $("#zzimMessageDiv");

	// 닫기 버튼 세팅
	var zzimMessageXBtnObj = zzimMessageDivObj.find("#zzimMessageXBtn"); 
	zzimMessageXBtnObj.unbind();
	zzimMessageXBtnObj.click(function (e) {
		zzimMessageDivHidden();
	});

	// 닫기 버튼 세팅
	var zzimListBtnObj = zzimMessageDivObj.find("#zzimListBtn");

	zzimListBtnObj.unbind();
	zzimListBtnObj.click(function (e) {
		document.location.href = "/view/resentzzim/resentzzimList.jsp?listType=2";
	});

	/*// 찜 목록으로 가는 버튼은 무조건 밑줄로
	zzimListBtnObj.hover(function (e) {
		$(this).attr("src", "http://img.enuri.gscdn.com/images/view/resentzzim/go_zlist_on.gif");
	}, function (e) {
		$(this).attr("src", "http://img.enuri.gscdn.com/images/view/resentzzim/go_zlist.gif");
	});
	*/
	
}

// type=1 : 찜이 되었을때
// type=2 : 체크된상품이 모두 이미 찜되어있을껑우
function zzimMessageDivShow(type) {
	var zzimMessageDivObj = $("#zzimMessageDiv");

	if(zzimMessageDivObj.css("display")=="none") {
		var messageTxt = "";
		if(type==1) {
			messageTxt = "찜 되었습니다!";
		}
		if(type==2) {
			messageTxt = "이미 찜한 상품입니다.";
		}
		
		zzimMessageDivObj.find("#zzimMessageText").html(messageTxt);
		
		// 체크시 보이는 메뉴
		var checkMenuDivObj = $("#checkMenuDiv");

		var posTop = oldCheckMenuTop;
		var posLeft = 300;

		// 전체메뉴가 체크 되었을 경우 위치는 고정
		//if(document.getElementById("allCheckBox").checked) {
			posTop = $("#resentZzimMenuLayer").offset().top + 80;
			posLeft = 320;
		//}

		zzimMessageDivObj.css("top", posTop+"px");
		zzimMessageDivObj.css("left", posLeft+"px");

		zzimMessageDivObj.css("display", "block");

		// 5초뒤 메세지 박스 닫음
		setTimeout("zzimMessageDivHidden()", 5000);
	}
}

function zzimMessageDivHidden() {
	$("#zzimMessageDiv").css("display", "none");
}

// 클립보드 저장 세팅
function initZeroClipboard() {
	ZeroClipboard.setMoviePath("/include/main/main2013/js/ZeroClipboard.swf");
}

// 메인페이지의 최근본과 찜상품 개수 세팅 응용
var myGoodsCnt = 0;
function loadResentZzimCnt() {

	var loadUrl = "/include/main/main2013/ajax/getResentZzimCnt.jsp";

	$.getJSON(loadUrl, null, function(data) {
		var tempGoodsCnt = "0";
		var tempGoodsCntLink1 = "0";
		var tempGoodsCntLink2 = "0";

		// 견적보기 개수 세팅
		if(listType==9) {
			tempGoodsCntLink1 = data["myZzimGoodsCnt"];
			tempGoodsCntLink2 = data["myTodayGoodsCnt"];

			/* 견적보기는 목록값으로 계산
			try {
				myGoodsCnt = goodsNumList.split(",").length;
			} catch(e) {}

			$("#resentZzimMenuLayer .resentZzimMenuBody .listTotalNum span").html(myGoodsCnt+"개");
			*/

		} else {
			// 최근 본 상품 개수 세팅
			if(listType==1) {
				tempGoodsCnt = data["myTodayGoodsCnt"];
			}

			// 찜 상품 개수 세팅
			if(listType==2) {
				tempGoodsCnt = data["myZzimGoodsCnt"];
			}
			tempGoodsCntLink1 = data["myZzimGoodsCnt"];
			tempGoodsCntLink2 = data["myTodayGoodsCnt"];

			try {
				myGoodsCnt = parseInt(tempGoodsCnt);
			} catch(e) {}

			if(myGoodsCnt==0) {
				$("#resentZzimMenuLayer .resentZzimMenuBody .listTotalNum span").html("");

				$("#resentZzimMenuLayer").css("display", "none");
				$("#listSubMenuDiv").css("display", "none");
				$("#listTail").css("display", "none");

				var listNoneInfoHtml = "";
				if(listType==1) {
					listNoneInfoHtml += "<img class=\"noneResentImg\" src=\""+rzRoot+"tx_recent.gif\" border=\"0\" align=\"absmiddle\">";
				}
				if(listType==2) {
					$("#zzimFolderDiv").css("display", "none");
					listNoneInfoHtml += "<img class=\"noneZzimImg\" src=\""+rzRoot+"tx_zzim.gif\" border=\"0\" align=\"absmiddle\">";
				}
				$("#listItemsDiv").css("border", "0px solid #cccccc");
				$("#listItemsDiv").css("height", "330px");
				$("#listItemsDiv").html(listNoneInfoHtml);
			} else {
				$("#resentZzimMenuLayer .resentZzimMenuBody .listTotalNum span").html(myGoodsCnt+"개");
			}
		}
		$("#moveListTypeDiv #moveListTypeCnt2").html(tempGoodsCntLink1);
		$("#moveListTypeDiv #moveListTypeCnt1").html(tempGoodsCntLink2);

		// 데이터의 높이에 따라 창크기를 조절
		setPopupSize();
	});
}

// 현재 목록 읽어오기
var listGoodsCnt = 0;
var listGoodsStr = "";
var myZzimTotalCnt = ""
var listGoodsCopyLinkUrl = new Array();
var listModelCateLink = new Array();
var listLinkInfoObj = new Array();
var estSelectPlno = new Array();
var estSelectShopObjValue = "";
function loadGoodsList(tempFolder_id) {
	var loadUrl = "/view/resentzzim/ajax/Ajax_goodsList.jsp?listType="+listType+"&folder_id="+tempFolder_id;
	var listItemsDivObj = $("#listItemsDiv");

	if(mailYN.length>0) {
		loadUrl += "&mailYN="+mailYN;
	}
	if(goodsNumList.length>0) {
		loadUrl += "&goodsNumList="+goodsNumList;
	}
	
	// 메일에서 목록을 읽어올경우
	// URL 즐찾 메일, 최근본 링크등 안보여야함
	if(mailYN=="Y") {
		//resentZzimMenuLayer
		$("#listSubMenuDiv").css("display", "none");
		$("#moveListTypeDiv").css("display", "none");

		// 날짜 세팅
		$("#listTitleDiv .listTotalNum").css("display", "none");
		$("#listTitleDiv .listDate span").html(listShownDate);

		$("#listItemsDiv").css("margin", "20px 0px 0px 3px");
	}

	folder_id = tempFolder_id;
	listGoodsStr = "";
	nowFolderItemNum = 0;

	$.getJSON(loadUrl, null, function(data) {
		//$("#listTitleDiv .listTotalNum span").html(data["goodsCnt"]+"개");
		//$("#resentZzimMenuLayer .sumPriceDiv span").html(data["priceSum"]);

		var jsonObj = data["goodsList"];
		var listHtml = "";

		myZzimTotalCnt = data["myZzimTotalCnt"];
		
		listItemsDivObj.html("");
		closelistCheckMenu();
		if(listType==2) {
			zzimMoveLayerHidden();
		}
		if(listType==9) {
			var tempEstCnt = 0;
			try {
				tempEstCnt = parseInt(data["goodsCnt"]);
			} catch(e) {}

			$("#resentZzimMenuLayer .resentZzimMenuBody .listTotalNum span").html(tempEstCnt+"개");
		}

		if(jsonObj!=null) {

			$.each(jsonObj, function(indexI, listObj) {
				var modelno = 0;
				try {
					modelno = parseInt(listObj["modelno"]);
				} catch(e) {}
				var headerText = listObj["modelnm"];
				var bodyText = listObj["strSpec"];
				
				if(modelno==0) {
					headerText = "";
					bodyText = listObj["modelnm"];
				}
				
				var modelnoCheck = "";
				if(modelno>0) {
					modelnoCheck = "G:"+listObj["modelno"];
				} else {
					modelnoCheck = "P:"+listObj["p_pl_no"];
				}
				
				listGoodsStr += modelnoCheck + ",";

				listHtml += "<div id=\"listItem"+indexI+"\" class=\"listItem\">";
				listHtml += "	<div class=\"smallImage\"><img class=\"goodslink\" src=\""+listObj["smallImageUrl"]+"\" onerror=\"this.src='"+PHOTO_ENURI_COM+"/data/working.gif'\"></div>";
				listHtml += "	<div class=\"itemBody\">";
				listHtml += "		<div id=\"listItemTitle"+indexI+"\" class=\"bodyTitle\">";
				listHtml += "			<div id=\"name\">";
				listHtml += "			<div class=\"checkBox\" align=\"absmiddle\"><input id=\"listCheck"+indexI+"\" class=\"listCheckItem\" type=\"checkBox\" value=\""+modelnoCheck+"\"></div>";
				listHtml += "<span id=\"nameTxt\" class=\"goodslink\">"+headerText+"</span>&nbsp;&nbsp;";
				if(modelno>0) {
					listHtml += "<span id=\"factory\" class=\"goodslink\">"+listObj["factory"]+"</span>";
				}
				listHtml += "</div>";

				if(listType==9) {
					// 견적보기 합계 구하기
					var subSumPriceTxt = "";
					var tempPrice = 0;
					var tempDeliveryPrice = 0;
					if(modelno>0) {
						var tempPricelistInfo = "";
						var shopPriceInfoAry = null;
						try {
							shopPriceInfoAry = listObj["price_txt1"].split("**");
						} catch(e) {}

						if(shopPriceInfoAry!=null && shopPriceInfoAry.length>1) {
							// pl_no:price:shop_code:shop_name:url:deliveryinfo
							var tempPriceTxt = shopPriceInfoAry[1].split(",").join("");
							try {
								tempPrice = parseInt(tempPriceTxt);
							} catch(e) {}
							
							var tempDeliveryPriceTxt = shopPriceInfoAry[5].split("배송:").join("");
							tempDeliveryPriceTxt = tempDeliveryPriceTxt.split(",").join("");
							tempDeliveryPriceTxt = tempDeliveryPriceTxt.split("원").join("");
							try {
								tempDeliveryPrice = parseInt(tempDeliveryPriceTxt);
							} catch(e) {}
						}

					} else { // 추가검색 상품 일 경우
						var tempPriceTxt = listObj["minprice"].split(",").join("");
						try {
							tempPrice = parseInt(tempPriceTxt);
						} catch(e) {}

						var tempDeliveryPriceTxt = listObj["goods_info"].split("배송:").join("");
						tempDeliveryPriceTxt = tempDeliveryPriceTxt.split(",").join("");
						tempDeliveryPriceTxt = tempDeliveryPriceTxt.split("원").join("");
						try {
							tempDeliveryPrice = parseInt(tempDeliveryPriceTxt);
						} catch(e) {}
					}
					if(!tempDeliveryPrice) tempDeliveryPrice = 0;
					subSumPriceTxt = addCommaNumber(tempPrice+tempDeliveryPrice);
					
					listHtml += "			<div class=\"estTitleRight\">";
					listHtml += "				<div id=\"estSelectShop"+indexI+"\" class=\"estSelectShop\">";
					listHtml += "					<span class=\"estSelectShopTitle\">선택한 쇼핑몰 상품</span>";
					listHtml += "					<div class=\"estSelectShopNum\"><input type=\"text\" value=\"1\"></div>";
					listHtml += "					<div class=\"estSelectShopUpDown\">";
					listHtml += "						<img class=\"estUpImg\" src=\"http://img.enuri.gscdn.com/images/view/resentzzim/20140221/btn_up.png\" border=\"0\" align=\"absmiddle\">";
					listHtml += "						<img class=\"estDownImg\" src=\"http://img.enuri.gscdn.com/images/view/resentzzim/20140221/btn_down.png\" border=\"0\" align=\"absmiddle\">";
					listHtml += "					</div>";
					listHtml += "					<div class=\"estSelectShopSum\">";
					listHtml += "						<div class=\"titleText\">소  계 : </div>";
					listHtml += "						<div class=\"priceText\">"+subSumPriceTxt+"</div>";
					listHtml += "						<div class=\"wonText\">원</div>";
					listHtml += "					</div>";
					listHtml += "				</div>";
					listHtml += "				<div class=\"estGroupTotal\">";
					listHtml += "				</div>";
					listHtml += "			</div>";
				} else {
					if(modelno>0) {
						listHtml += "			<div class=\"mall\">업체</div>";
					} else {
						listHtml += "			<div id=\"delivery\" class=\"goodslink\"><span>"+listObj["goods_info"]+"</span></div>";
					}
					if(listObj["c_dateStr"]!="") {
						var dateClass = "";
						var dateText = "";
						var tempC_dateStr = listObj["c_dateStr"];
						if(modelno>0) {
							dateClass = "cdate";
							dateText = "<span class=\"cdate_text\">출시</span>";
						} else {
							dateClass = "cdateNo";
							dateText = "";
						}
						if(listObj["c_dateStr"].indexOf("-")>-1) {
							// 년과 날짜를 끄집어옴
							var tempC_dateStrAry = listObj["c_dateStr"].split("-");
							if(tempC_dateStrAry.length>1) {
								listHtml += "			<div class=\""+dateClass+"\"><sup>'"+tempC_dateStrAry[0]+"</sup><span class=\"cdate_mon1\">"+tempC_dateStrAry[1]+"</span>";
								listHtml += "<span class=\"cdate_mon2\">월</span>"+dateText+"</div>";
							}
						} else {
							if(listObj["c_dateStr"]=="출시예정") {
								listHtml += "			<div class=\""+dateClass+"\"><span class=\"cdate_textOnly\">출시예정</span></div>";
							} else {
								listHtml += "			<div class=\""+dateClass+"\"><sup>'</sup><span class=\"cdate_mon2_1\">"+listObj["c_dateStr"]+"</span>";
								listHtml += "<span class=\"cdate_mon2_2\">년</span>"+dateText+"</div>";
							}
						}
					}
				}
				
				listHtml += "		</div>";
				listHtml += "		<div class=\"bodyData\">";
				listHtml += "			<div class=\"leftInfo\">";
				listHtml += "				<div class=\"bodyData_body\">";
				if(modelno>0 && listObj["keyword2"].length>0) {
					listHtml += "					<div class=\"keyword\"><span class=\"goodslink\">"+listObj["keyword2"]+"</span></div>";
				}
				listHtml += "					<div class=\"spec\">";
				listHtml += "						<span>"+bodyText+"</span>";
				//listHtml += "						<br><span class=\"goodslink\">[미국Spec]강도:S,R,M / 밸런스:D6 / 길이:46인치(116.8cm)</span>";
				//listHtml += "						<br><span class=\"goodslink\">[일본Spec]강도:S,SR,R / 밸런스:D2.5~D3 / 길이:46인치(116.8cm)</span>";
				listHtml += "					</div>";
				if(modelno==0 && listObj["strFreeinterest"].length>0) {
					listHtml += "					<div class=\"Freeinterest\">";
					listHtml += "						<span>"+listObj["strFreeinterest"]+"</span>";
					listHtml += "					</div>";
				}
				if(listObj["kb_title"]!="") {
					listHtml += "					<div class=\"news\">";
					if (listObj["kb_title"].indexOf("[정보]") >= 0){
						listObj["kb_title"] = listObj["kb_title"].replace("[정보]","");
						listHtml += "						<img class=\"kb_title\" src=\"http://img.enuri.gscdn.com/2010/images/view/icon_news3.gif\" border=\"0\" align=\"absmiddle\">";
					}else if(listObj["kb_title"].indexOf("[동영상]") >= 0){
						listObj["kb_title"] = listObj["kb_title"].replace("[동영상]","");
						listHtml += "						<img class=\"kb_title\" src=\"http://img.enuri.gscdn.com/2010/images/view/icon_movie.gif\" border=\"0\" align=\"absmiddle\">";						
					}else if(listObj["kb_title"].indexOf("[리뷰]") >= 0){
						listObj["kb_title"] = listObj["kb_title"].replace("[리뷰]","");
						listHtml += "						<img class=\"kb_title\" src=\"http://img.enuri.gscdn.com/2010/images/view/icon_review.gif\" border=\"0\" align=\"absmiddle\">";						
					}else if(listObj["kb_title"].indexOf("[사용기]") >= 0){
						listObj["kb_title"] = listObj["kb_title"].replace("[사용기]","");
						listHtml += "						<img class=\"kb_title\" src=\"http://img.enuri.gscdn.com/2010/images/view/icon_use.gif\" border=\"0\" align=\"absmiddle\">";						
					}else{
						listHtml += "						<img class=\"kb_title\" src=\"http://img.enuri.gscdn.com/2010/images/view/icon_news2.gif\" border=\"0\" align=\"absmiddle\">";
					}
					listHtml += "						<span class=\"kb_title\">"+listObj["kb_title"]+"</span>";
					listHtml += "					</div>";
				}
				listHtml += "				</div>";
				var bulletTxt = "<span style='color:#aa0000'>&bull;</span>";
				if(modelno>0) {
					listHtml += "				<div class=\"etc\">";
					if(listObj["bBigImageYN"]=="Y") {
						listHtml += "<span class=\"bbigImage\">더큰사진</span> "+bulletTxt;
					}
					listHtml += "<span class=\"modelBoardLink\"><span>상품평("+listObj["kb_num"]+")</span></span>";
					listHtml += "					"+bulletTxt+"<span id=\"listModelUrl"+indexI+"\" class=\"urlCopyLink\">URL</span>";
					//listHtml += "					<img id=\"listModelUrl"+indexI+"\" src=\""+rzRoot+"url.gif\">";
					if(listObj["sale_cnt"]!="0" && listObj["sale_cnt"].length>1) {
						listHtml += "					"+bulletTxt+"<span>판매량:"+listObj["sale_cnt"]+"</span>";
					}
					if(listType==2) {
						if(listObj["moddate"].length>0) {
							listHtml += "					"+bulletTxt+"<span>찜날짜:<span class=\"zzimdate\">"+listObj["moddate"]+"</span></span>";
						}
						if(listObj["alarmYN"]=="Y") {
							//listObj["alarmPrice"];
							listHtml += "					"+bulletTxt+"<span>";
							listHtml += "<div class=\"alarmPrice\">";
							listHtml += "<img src=\""+rzRoot+"alarmSample.png\">";
							listHtml += "</div>";
							listHtml += "</span>";
						}
					}
					if(listObj["modelCateLink"]!="") {
						listHtml += "					"+bulletTxt+"<span id=\"modelCateLink"+indexI+"\" title=\""+listObj["strCategoryName"]+"\" class=\"modelCateLink\">해당 카테고리로 <img align=\"absmiddle\" src=\"http://img.enuri.gscdn.com/2012/list/arr2.gif\"></span>";
					}
					listHtml += "				</div>";
				} else {
					listHtml += "				<div class=\"etc\">";
					if(listType==2) {
						var tempBulletTxt = bulletTxt;
						if(listObj["moddate"].length>0) {
							listHtml += "					<span>찜날짜:<span class=\"zzimdate\">"+listObj["moddate"]+"</span></span>";
						} else {
							tempBulletTxt = "";
						}
						if(listObj["modelCateLink"]!="") {
							listHtml += "					"+tempBulletTxt+"<span id=\"modelCateLink"+indexI+"\" title=\""+listObj["strCategoryName"]+"\" class=\"modelCateLink\">해당 카테고리로 <img align=\"absmiddle\" src=\"http://img.enuri.gscdn.com/2012/list/arr2.gif\"></span>";
						}
					} else {
						if(listObj["modelCateLink"]!="") {
							listHtml += "					<span id=\"modelCateLink"+indexI+"\" title=\""+listObj["strCategoryName"]+"\" class=\"modelCateLink\">해당 카테고리로 <img align=\"absmiddle\" src=\"http://img.enuri.gscdn.com/2012/list/arr2.gif\"></span>";
						}
					}
					if(listObj["pList_modelno"]!="0") {
						listHtml += "					<span id=\"pList_modelnoLink"+listObj["pList_modelno"]+"\" class=\"pList_modelnoLink\">가격비교</span>";
					}
					listHtml += "				</div>";
				}
				listHtml += "			</div>";
				listHtml += "			<div class=\"rightInfo\">";

				if(listType==9) {
					listHtml += "				<div class=\"estPlnoItemTitle\"><span class=\"title1\">쇼핑몰</span><span class=\"title2\">표시가</span><span class=\"title3\">배송비</span></div>";
					listHtml += "				<div class=\"estDotlineDiv\"></div>";

					var listOptionSelectFlag = " checked";

					if(modelno>0) {
						for(var i=0; i<3; i++) {
							var tempPricelistInfo = "";
							var shopPriceInfoAry = null;
							try {
								shopPriceInfoAry = listObj["price_txt"+(i+1)].split("**");
							} catch(e) {}
							if(i>0) listOptionSelectFlag = "";
							
							if(shopPriceInfoAry!=null && shopPriceInfoAry.length>1) {
								// pl_no:price:shop_code:shop_name:url:deliveryinfo
								var tempModelnoCheck = "P"+shopPriceInfoAry[0];

								tempPricelistInfo += "<div class=\"estInputDiv\"><input class=\"estPlnoItemOne estCheckSubInput\" name=\""+modelnoCheck+"\" id=\""+tempModelnoCheck+"\" value=\""+indexI+"\" type=\"radio\" "+listOptionSelectFlag+"\></div>";
								if(shopPriceInfoAry[3].length>6) {
									tempPricelistInfo += "<div class=\"estPlnoItemOne shopName\"><span title=\""+shopPriceInfoAry[3]+"\" class=\"goodslink\">"+shopPriceInfoAry[3]+"</span></div>";
								} else {
									tempPricelistInfo += "<div class=\"estPlnoItemOne shopName\"><span class=\"goodslink\">"+shopPriceInfoAry[3]+"</span></div>";
								}
								if(shopPriceInfoAry[1].length>10) {
									tempPricelistInfo += "<div class=\"estPrice goodslink\"><span class=\"estPriceNumLong\">"+shopPriceInfoAry[1]+"</span>원</div> ";
								} else {
									tempPricelistInfo += "<div class=\"estPrice goodslink\"><span class=\"estPriceNum\">"+shopPriceInfoAry[1]+"</span>원</div> ";
								}
								tempPricelistInfo += "<div class=\"estPlnoItemOne goodslink deliveryInfo\">"+shopPriceInfoAry[5]+"</div>";

								listHtml += "				<div id=\"estModelPlno"+shopPriceInfoAry[0]+"\" class=\"estPlnoItem\">"+tempPricelistInfo+"</div>";

								listLinkInfoObj[shopPriceInfoAry[0]] = listObj["price_txt"+(i+1)];
								if(i==0) estSelectPlno[indexI] = shopPriceInfoAry[0];
							}

						}
					} else { // 추가검색 상품 일 경우
						var tempModelnoCheck = "P"+listObj["p_pl_no"];

						var tempPricelistInfo = "";
						tempPricelistInfo += "<input class=\"estPlnoItemOne estCheckSubInput\" name=\""+modelnoCheck+"\" id=\""+tempModelnoCheck+"\" type=\"radio\" value=\""+indexI+"\" "+listOptionSelectFlag+"\> ";
						tempPricelistInfo += "<div class=\"estPlnoItemOne shopName\"><span class=\"goodslink\">"+listObj["factory"]+"</span></div> ";
						tempPricelistInfo += "<div class=\"estPrice goodslink\"><span class=\"estPriceNum\">"+listObj["minprice"]+"</span>원</div> ";
						tempPricelistInfo += "<div class=\"estPlnoItemOne goodslink deliveryInfo\">"+listObj["goods_info"].split("배송:").join("")+"</div>";

						listHtml += "				<div class=\"estPlnoItem\">"+tempPricelistInfo+"</div>";

						listLinkInfoObj[listObj["p_pl_no"]] = listObj["p_pl_no"]+"**"+listObj["minprice"]+"**"+0+"**"+0+"**"+0+"**"+listObj["goods_info"];
						estSelectPlno[indexI] = listObj["p_pl_no"];
					}

				} else {
					listHtml += "				<div class=\"price_mall\">";
					if(listObj["minprice"]=="0") {
						listHtml += "					<div class=\"priceStr goodslink\"><div class=\"priceTxt\">"+listObj["minPriceText"]+"</div></div>";
					} else {
						if(listObj["minprice"].length>10) {
							listHtml += "					<div class=\"priceLong goodslink\"><span class=\"";
							listHtml += "numberLong";
						}else{
							listHtml += "					<div class=\"price goodslink\"><span class=\"";
							listHtml += "number";
						}
						listHtml += "\">"+listObj["minprice"]+"</span></div>";
					}
					if(modelno>0) {
						listHtml += "					<div class=\"mallCnt\"><span class=\"goodslink\">"+listObj["mallcnt"]+"</span></div>";
					}
					listHtml += "				</div>";
					if(modelno==0) {
						listHtml += "				<div class=\"shopName\">";
						listHtml += "					<span class=\"shopNamePpan goodslink\">"+listObj["factory"]+"</span>";
						listHtml += "				</div>";
					}
				}

				listHtml += "			</div>";
				listHtml += "		</div>";
				listHtml += "	</div>";
				listHtml += "</div>";

				listGoodsCnt++;
				nowFolderItemNum++;
			});

			listItemsDivObj.html(listHtml);

			if(listType==9) {
				listItemsDivObj.find(".listItem .itemBody .bodyData .leftInfo").css("width", "400px");
				listItemsDivObj.find(".listItem .itemBody .bodyData .rightInfo").css("width", "270px");
				listItemsDivObj.find(".listItem .itemBody .bodyData .pList_modelnoLink").css("right", "224px");

				// 이벤트 추가
				var estSelectShopObj = listItemsDivObj.find(".estSelectShop");

				estSelectShopObj.unbind();
				// up 버튼
				estSelectShopObj.find(".estUpImg").click(function (e) {
					var topParentObj = $(this).parent().parent();
					var numberObj = topParentObj.find(".estSelectShopNum input");
					var intNumber = 1;
					try {
						intNumber = parseInt(numberObj.val()) + 1;
					} catch(e) {}

					if(intNumber>99) {
						intNumber = 99;
						return;
					}

					numberObj.val(intNumber);

					var listItemNum = topParentObj.attr("id").replace("estSelectShop", "");
					calSubSumListItem(listItemNum);
				});
				// down 버튼
				estSelectShopObj.find(".estDownImg").click(function (e) {
					var topParentObj = $(this).parent().parent();
					var numberObj = topParentObj.find(".estSelectShopNum input");
					var intNumber = 1;
					try {
						intNumber = parseInt(numberObj.val()) - 1;
					} catch(e) {}

					if(intNumber<1) {
						intNumber = 1;
						return;
					}

					numberObj.val(intNumber);

					var listItemNum = topParentObj.attr("id").replace("estSelectShop", "");
					calSubSumListItem(listItemNum);
				});
				// 숫자만 입력하게 함
				estSelectShopObj.find(".estSelectShopNum input").keydown(function (e) {
					var word = $(this).val();
					estSelectShopObjValue = word;
				});
				// 숫자만 입력하게 함
				estSelectShopObj.find(".estSelectShopNum input").keyup(function (e) {
					var word = $(this).val();
					var numStr = "1234567890";
					for(var i=0; i<word.length; i++) {
						if(numStr.indexOf(word.charAt(i))<0) {
							$(this).val(estSelectShopObjValue);
						}
					}
					if($(this).val().length>2) {
						$(this).val(estSelectShopObjValue);
					}
					if($(this).val()=="0") {
						$(this).val("1");
					}

					var topParentObj = $(this).parent().parent();
					var listItemNum = topParentObj.attr("id").replace("estSelectShop", "");
					calSubSumListItem(listItemNum);
				});
				// 숫자만 입력하게 함
				estSelectShopObj.find(".estSelectShopNum input").blur(function (e) {
					if($(this).val()=="") {
						$(this).val("1");
					}

					var topParentObj = $(this).parent().parent();
					var listItemNum = topParentObj.attr("id").replace("estSelectShop", "");
					calSubSumListItem(listItemNum);
				});
				// 옵션을 클릭합
				listItemsDivObj.find(".estCheckSubInput").click(function (e) {
					var thisCheckStatus = $(this).is(":checked");

					if(thisCheckStatus) {
						var tempId = $(this).attr("id");
						var tempIdx = $(this).val();
						var intTempIdx = -1;
						try {
							intTempIdx = parseInt(tempIdx);
						} catch(e) {}
						if(intTempIdx>-1) {
							estSelectPlno[intTempIdx] = tempId.replace("P", "");

							calSubSum($(this));
						}
					}
				});

			} else {
				listItemsDivObj.find(".listItem .itemBody .bodyData .rightInfo .price").css("float", "left");
				listItemsDivObj.find(".listItem .itemBody .bodyData .rightInfo .priceLong").css("float", "left");
				listItemsDivObj.find(".listItem .itemBody .bodyData .rightInfo .priceStr").css("float", "left");
			}

			// 특정 이름의 크기 조절
			$.each(jsonObj, function(indexI, listObj) {
				var modelno = 0;
				var nameMaxWidth = 440;

				var listItemObj = $("#listItem"+indexI);
				var bodyTitleObj = listItemObj.find(".itemBody .bodyTitle");
				var nameObj = listItemObj.find(".itemBody .bodyTitle #name");
				var cdateObj = listItemObj.find(".itemBody .bodyTitle .cdate");
				var bodyDataObj = listItemObj.find(".itemBody .bodyData");
				var bodyData_bodyObj = listItemObj.find(".itemBody .bodyData .leftInfo .bodyData_body");

				if(listType==9) {
					nameMaxWidth = 330;
				}

				// 만약 name필드가 너무 클경우 2줄로 보이게함
				if(nameObj.width()>nameMaxWidth) {
					bodyTitleObj.css("height", "38px");
					nameObj.css("margin", "3px 0px 0px 0px");
					nameObj.css("height", "32px");
					nameObj.css("width", nameMaxWidth+"px");
					if(listType==9) {
						listItemObj.find(".estSelectShop").css("margin", "6px 0px 0px 0px");
					}
				}
				
				try {
					modelno = parseInt(listObj["modelno"]);
				} catch(e) {}

				if(bodyDataObj.height()<80) bodyDataObj.css("height", "80px");
				//if(modelno>0) {
					if(bodyData_bodyObj.height()<(bodyDataObj.height()-28)) {
						bodyData_bodyObj.css("height", (bodyDataObj.height()-28)+"px");
					}
				//}

				// 체크된 정보를 초기화
				checkedModelList = "";
				checkedGoodsList = "";
				var listCheckObj = $("#listCheck"+indexI);
				listCheckObj.unbind();
				listCheckObj.click(function (e) {
					var thisModelno = $(this).attr("value");
					var thisCheckStatus = $(this).is(":checked");
					var checkedCnt = 0;

					checkedModelList = "";
					checkedGoodsList = "";
					for(var i=0; i<listGoodsCnt; i++) {
						var listCheckObj = $("#listCheck"+i);
						var modelno = listCheckObj.attr("value");
						var checkStatus = listCheckObj.is(":checked");

						if(checkStatus) {
							if(checkedModelList!="") checkedModelList += ",";
							checkedModelList += modelno;

							if(checkedGoodsList!="") checkedGoodsList += ",";
							checkedGoodsList += modelno;
						}
						if(checkStatus) {
							checkedCnt++;
							
							insertLog(9805);
						}
					}

					/*
					if(checkedCnt>0) {
						showlistCheckMenu($(this));
					} else {
						closelistCheckMenu();
					}
					*/

					// 전체가 선택된 경우 상단의 메뉴 세팅
					// 현재 자신이 선택되면 title부분 배경색을 변경
					var itemTitleObj = $(this).parent().parent().parent();
					if(thisCheckStatus) {
						//if(checkedCnt==nowFolderItemNum) {
							allCheckEventAdd();
						//}
						if(itemTitleObj) {
							itemTitleObj.css("background-color", "#dbecf4");
						}
					} else {
						if(checkedGoodsList.length==0) {
							allCheckEventDelete();
						}
						if(itemTitleObj) {
							itemTitleObj.css("background-color", "#eaeaea");
						}
					}

					checkedItemPriceSum();

					// 상단의 견적 보기는 체크가 되어있을 때만 활성화
					if(listType==1 || listType==2) {
						var topMenuBtn0Obj = $("#topMenuBtn0");
						var sumPriceText = $("#resentZzimMenuLayer .sumPriceDiv span").text();
						topMenuBtn0Obj.unbind();
						if(checkedGoodsList.length>0 && sumPriceText!="0") {
							// 견적보기 활성화
							topMenuBtn0Obj.css("cursor", "pointer");
							topMenuBtn0Obj.click(function (e) {
								insertLog(checkedBtnLogs[3]);
								estiListModel();
							});
							
							var imgUrl = topMenuBtn0Obj.attr("src");
							if(imgUrl.indexOf("_off")>-1) {
								imgUrl = imgUrl.split("_off.png").join("_on.png");

								topMenuBtn0Obj.attr("src", imgUrl);
							}

						} else {
							topMenuBtn0Obj.css("cursor", "default");

							var imgUrl = topMenuBtn0Obj.attr("src");
							if(imgUrl.indexOf("_on")>-1) {
								imgUrl = imgUrl.split("_on.png").join("_off.png");

								topMenuBtn0Obj.attr("src", imgUrl);
							}
						}
					}

				});
				
				var modelLinkUrl = "";
				if(modelno>0) {
					modelLinkUrl = "http://www.enuri.com/p/"+modelno;
				} else {
					modelLinkUrl = listObj["url1"];
				}
				listGoodsCopyLinkUrl[indexI] = modelLinkUrl;
				listModelCateLink[indexI] = listObj["modelCateLink"];
				
				// 매칭되기전에 찜이나 최근본에 들어갔을 경우 상품창으로 클릭 이벤트
				var pList_modelnoLinkObj = listItemObj.find(".pList_modelnoLink");
				pList_modelnoLinkObj.unbind();
				pList_modelnoLinkObj.click(function (e) {
					var thisId = $(this).attr("id");
					var modelno = thisId.replace("pList_modelnoLink", "");
					detailMultiView("/view/Detailmulti.jsp?modelno="+modelno+"&fb=1&porder=13&key=popular DESC&factory=&search=&m_price=&spec=&sel_spec=&pagesize=20&page=1&keyword=&orgkeyword=&spec_name=","detailmulti_"+listObj["modelno"],listObj["modelno"]);

				});
				
				// 상풍창 클릭 이벤트
				var goodslinkObj = listItemObj.find(".goodslink");
				goodslinkObj.unbind();
				goodslinkObj.css("cursor", "pointer");
				goodslinkObj.click(function (e) {
					// 일반 상품창
					if(modelno>0) {
						if(listType==9) {
							var parentId = "";
							try {
								if($(this).parent().attr("id")) {
									parentId = $(this).parent().attr("id");
								}
							} catch(e) {}

							if(parentId.length>0 && parentId.indexOf("estModelPlno")>-1) {
								var plnoNum = parentId.replace("estModelPlno", "");
								var plnoInfo = listLinkInfoObj[plnoNum];
								if(plnoInfo!=null && plnoInfo.length>0) {
									// pl_no:price:shop_code:shop_name:url:deliveryinfo
									var plnoInfoAry = plnoInfo.split("**");

									CmdGotoMall("ex","move_"+plnoInfoAry[0],plnoInfoAry[2],plnoInfoAry[0],plnoInfoAry[1],plnoInfoAry[4],listObj["ca_code"],plnoInfoAry[0],listObj["smallImageUrl"]);
								}
							} else {
								detailMultiView("/view/Detailmulti.jsp?modelno="+listObj["modelno"]+"&fb=1&porder=13&key=popular DESC&factory=&search=&m_price=&spec=&sel_spec=&pagesize=20&page=1&keyword=&orgkeyword=&spec_name=","detailmulti_"+listObj["modelno"],listObj["modelno"]);
							}
						} else {
							detailMultiView("/view/Detailmulti.jsp?modelno="+listObj["modelno"]+"&fb=1&porder=13&key=popular DESC&factory=&search=&m_price=&spec=&sel_spec=&pagesize=20&page=1&keyword=&orgkeyword=&spec_name=","detailmulti_"+listObj["modelno"],listObj["modelno"]);
						}
					} else {
						CmdGotoMall("ex","move_"+listObj["p_pl_no"],listObj["gb1_no"],listObj["p_pl_no"],listObj["minprice"],listObj["url1"],listObj["ca_code"],listObj["p_pl_no"],listObj["smallImageUrl"]);
					}

					insertLog(9810);
				});

				// 지식통상품평 이 있을 경우 이벤트 추가
				if(listObj["kb_title"]!="") {
					var kb_titleObj = listItemObj.find(".kb_title");
					kb_titleObj.unbind();
					kb_titleObj.click(function (e) {
						window.open("/knowbox/List.jsp?from=list&modelno="+modelno+"&modelInfoSelect=1");
					});
				}

				// 더큰 사진보기 이미지 열기
				if(listObj["bBigImageYN"]=="Y") {
					var bbigImageObj = listItemObj.find(".bbigImage");
					bbigImageObj.unbind();
					bbigImageObj.click(function (e) {
						showImage(modelno);
					});
				}

				// 상품창의 게시판상품평 링크
				var modelBoardLinkObj = listItemObj.find(".modelBoardLink span");
				modelBoardLinkObj.unbind();
				modelBoardLinkObj.css("cursor", "pointer");
				modelBoardLinkObj.click(function (e) {
					detailMultiView("/view/Detailmulti.jsp?modelno="+listObj["modelno"]+"&cate=00000000&fb=1&porder=8&key=popular&factory=&search=YES&m_price=&spec=&sel_spec=&pagesize=30&page=1&keyword=kobo ora&orgkeyword=kobo ora&spec_name=&from=list&goodsBbsOpenType=2","detailmulti_"+listObj["modelno"],listObj["modelno"]);
				});
			});
			
			// 메일을 보낼때는 현재보이는 상품 리스트를 보냄
			//$("#mailForm #mailSendGoods").attr("value", listGoodsStr);
			document.mailForm.mailSendGoods.value = listGoodsStr;

			// url copy 세팅
			var urlCopyLinkObj = listItemsDivObj.find(".urlCopyLink");
			urlCopyLinkObj.unbind();
			urlCopyLinkObj.click(function (e) {
				var thisId = $(this).attr("id");
				var idNum = thisId.replace("listModelUrl", "");
				var intIdNum = -1;
				try {
					intIdNum = parseInt(idNum);
				} catch(e) {}

				if(window.clipboardData) {
					window.clipboardData.setData("Text", listGoodsCopyLinkUrl[intIdNum]);
					alert("URL이 복사되었습니다.");
				} else {
					alert("URL복사 기능이 지원하지 않는 브라우져 입니다.");
				}
			});

			// url copy 세팅
			var modelCateLinkObj = listItemsDivObj.find(".modelCateLink");
			modelCateLinkObj.unbind();
			modelCateLinkObj.click(function (e) {
				var thisId = $(this).attr("id");
				var idNum = thisId.replace("modelCateLink", "");
				var intIdNum = -1;
				try {
					intIdNum = parseInt(idNum);
				} catch(e) {}

				window.open(listModelCateLink[intIdNum]);
			});

			// 전체 체크 박스 세팅
			var allCheckBoxObj = $("#resentZzimMenuLayer #allCheckBox");
			allCheckBoxObj.unbind();
			allCheckBoxObj.click(function (e) {
				var thisCheckStatus = $(this).is(":checked");

				for(var i=0; i<nowFolderItemNum; i++) {
					document.getElementById("listCheck"+i).checked = thisCheckStatus;
					if(thisCheckStatus) {
						$("#listItemTitle"+i).css("background-color", "#dbecf4");
					} else {
						$("#listItemTitle"+i).css("background-color", "#eaeaea");
					}
				}

				checkedItemPriceSum();
				
				if(thisCheckStatus) {
					oldCheckMenuTop = 0;
					allCheckEventAdd();
				}
				else allCheckEventDelete();
			});

			// 견적보기의 경우는 초기 체크를 함
			if(listType==9) {
				var allCheckBoxObj = $("#allCheckBox");
				allCheckBoxObj.trigger("click");

				for(var i=0; i<nowFolderItemNum; i++) {
					document.getElementById("listCheck"+i).checked = true;
					$("#listItemTitle"+i).css("background-color", "#dbecf4");
				}

				checkedItemPriceSum();
				
				oldCheckMenuTop = 0;
				allCheckEventAdd();
			}
		}
		
		// ie 버전에 따른 이상현상 해결
		if(ieVer=="ie9" || ieVer=="ie10") {
			$("#listItemsDiv .priceTxt").css("margin", "3px 5px 0px 0px");
		}
		
		// 새로고침후 상단 메뉴 리셋
		if(listType!=9) {
			if(nowFolderItemNum>0) {
				allCheckEventDelete();
			}
			
			// 새로고침후 총합 리셋
			$("#resentZzimMenuLayer .sumPriceDiv span").html("0");
		}
		
		// 찜에서 현재 폴더의 상품이 없을 경우 이미지 보여줌
		if(listType==2 && nowFolderItemNum==0 && myZzimTotalCnt!="0") {
			var listNoneInfoHtml = "";

			listNoneInfoHtml += "<img class=\"noneZzimImgSub\" src=\""+rzRoot+"img_zzim.gif\" width=\"694\" height=\"374\" border=\"0\" align=\"absmiddle\">";

			$("#listTail").css("display", "none");

			$("#listItemsDiv").css("border", "0px solid #cccccc");
			$("#listItemsDiv").css("border-top", "1px solid #cccccc");
			$("#listItemsDiv").html(listNoneInfoHtml);
		} else {
			if(nowFolderItemNum>0) {
				$("#listTail").css("display", "block");

				$("#listItemsDiv").css("border", "1px solid #cccccc");
				$("#listItemsDiv").css("border-top", "0px solid #cccccc");
			}

			if(mailYN!="Y") {
				loadResentZzimCnt();
			}
		}

		setPopupSize();

	});
}

// ListItemObj를 이용해서 계산함
function calSubSumListItem(listItemNum) {
	var listItemObj = $("#listItem"+listItemNum);

	var selectdPlnoObj = listItemObj.find("#P"+estSelectPlno[listItemNum]);
	//alert(selectdPlnoObj.attr("id"))

	calSubSum(selectdPlnoObj);
}

// 리스트 하나에서 체크 옵션을 이용해 소계를 계산함
function calSubSum(thisObj) {
	var listItemObj = $("#listItem"+thisObj.val());
	var itemCnt = 1;
	try {
		itemCnt = parseInt(listItemObj.find(".estSelectShopNum input").val());
	} catch(e) {}
	
	var plnoStr = thisObj.attr("id").split("P").join("");
	var plnoInfoStr = listLinkInfoObj[plnoStr];
	var plnoInfoStrAry = null;
	
	plnoInfoStrAry = plnoInfoStr.split("**");
	
	var tempPrice = 0;
	var tempDeliveryPrice = 0;
	if(plnoInfoStrAry!=null) {
		// pl_no:price:shop_code:shop_name:url:deliveryinfo
		var tempPriceTxt = plnoInfoStrAry[1].split(",").join("");
		try {
			tempPrice = parseInt(tempPriceTxt) * itemCnt;
		} catch(e) {}
		
		var tempDeliveryPriceTxt = plnoInfoStrAry[5].split("배송:").join("");
		tempDeliveryPriceTxt = tempDeliveryPriceTxt.split(",").join("");
		tempDeliveryPriceTxt = tempDeliveryPriceTxt.split("원").join("");
		try {
			tempDeliveryPrice = parseInt(tempDeliveryPriceTxt);
		} catch(e) {}
	}

	if(!tempDeliveryPrice) tempDeliveryPrice = 0;
	var subSumPriceTxt = addCommaNumber(tempPrice+tempDeliveryPrice);

	listItemObj.find(".estTitleRight .estSelectShopSum .priceText").html(subSumPriceTxt);
	if(subSumPriceTxt.length>12) {
		listItemObj.find(".estTitleRight .estSelectShopSum .priceText").css("letter-spacing", "-1px");
		listItemObj.find(".estTitleRight .estSelectShopSum .priceText").css("margin-right", "1px");
	} else {
		listItemObj.find(".estTitleRight .estSelectShopSum .priceText").css("letter-spacing", "0px");
	}

	// 총합 계산
	checkedItemPriceSum();
}

// 페이지 로딩후 창높이 조절
function setPopupSize() {
	// 즐겨찾기나 메일로 들어오지 않았을때만 조절가능
	// 그때만 팝업형태임
	if(mailYN!="Y") {
		//var main_bodyObj = $("#main_body");
		//var main_bodyHeight = main_bodyObj.height() + 120;
		//var footerObj = $("footer");
		var main_bodyHeight = screen.height;

		//alert(footerObj.offset().bottom)
		window.resizeTo(828, main_bodyHeight);
	}
}

// 상단 메뉴의 체크를 했을때 이벤트 추가
function allCheckEventAdd() {
	checkedGoodsList = "";
	checkedModelList = "";
	var checkedItemCnt = 0;
	for(var i=0; i<listGoodsCnt; i++) {
		var listCheckObj = $("#listCheck"+i);
		var modelno = listCheckObj.attr("value");
		var checkStatus = listCheckObj.is(":checked");

		if(checkStatus) {
			/*
			if(modelno.indexOf("G:")>-1) {
				if(checkedModelList!="") checkedModelList += ",";
				checkedModelList += modelno.split("G:").join("");
			}
			*/
			if(checkedModelList!="") checkedModelList += ",";
			checkedModelList += modelno;
			if(checkedGoodsList!="") checkedGoodsList += ",";
			checkedGoodsList += modelno;

			checkedItemCnt++;
		}
	}

	if(checkedItemCnt==myGoodsCnt) {
		document.getElementById("allCheckBox").checked = true;
	}

	// 1:삭제, 2:이동, 3:비교, 4:견적, 5:찜, 6:닫기
	//topMenuBtn + 번호
	// 전체메뉴는 닫기가 없음
	for(var i=0; i<checkedBtnEvents.length; i++) {
		var topMenuBtnObj = $("#resentZzimMenuLayer #topMenuBtn"+(i+1));
		if(topMenuBtnObj.length>0) {
			topMenuBtnObj.unbind();
			topMenuBtnObj.click(function (e) {
				var thisId = $(this).attr("id");
				var idNum = thisId.replace("topMenuBtn", "");
				var intIdNum = -1;
				try {
					intIdNum = parseInt(idNum);
				} catch(e) {}

				if(intIdNum>-1) {
					// 로그 넣기 로그 데이터는 수정해야함
					if(checkedBtnLogs[intIdNum-1]>0) insertLog(checkedBtnLogs[intIdNum-1]);

					eval(checkedBtnEvents[intIdNum-1]);
				}
			});
		}
	}

	$("#resentZzimMenuLayer .topMenuBtn").css("cursor", "pointer");

	// 견적보기 활성화
	if(listType==1 || listType==2) {
		var topMenuBtn0Obj = $("#topMenuBtn0");
		topMenuBtn0Obj.css("cursor", "pointer");
		topMenuBtn0Obj.unbind();
		topMenuBtn0Obj.click(function (e) {
			insertLog(checkedBtnLogs[3]);
			estiListModel();
		});
	}

	// 상단 이미지 교체
	for(var i=1; i<=checkedBtnEvents.length; i++) {
		var topMenuBtnObj = $("#resentZzimMenuLayer #topMenuBtn"+i);
		if(topMenuBtnObj.length>0) {
			var imgUrl = topMenuBtnObj.attr("src");
			if(imgUrl.indexOf("_off")>-1) {
				imgUrl = imgUrl.split("_off.gif").join("_on.gif");

				topMenuBtnObj.attr("src", imgUrl);
			}
		}
	}
	
	if(listType==1 || listType==2) {
		var sumPriceText = $("#resentZzimMenuLayer .sumPriceDiv span").text();
		if(sumPriceText!="0") {
			var topMenuBtn0Obj = $("#topMenuBtn0");
			var imgUrl = topMenuBtn0Obj.attr("src");
			if(imgUrl.indexOf("_off")>-1) {
				imgUrl = imgUrl.split("_off.png").join("_on.png");

				topMenuBtn0Obj.attr("src", imgUrl);
			}
		}
	}
}

//상단 메뉴의 체크를 했을때 이벤트 제거
function allCheckEventDelete() {
	document.getElementById("allCheckBox").checked = false;

	$("#resentZzimMenuLayer .topMenuBtn").unbind();
	$("#resentZzimMenuLayer .topMenuBtn").css("cursor", "default");

	// 견적보기 비활성화
	if(listType==1 || listType==2) {
		var topMenuBtn0Obj = $("#topMenuBtn0");
		topMenuBtn0Obj.css("cursor", "default");
		topMenuBtn0Obj.unbind();
	}

	// 상단 이미지 교체
	for(var i=1; i<=checkedBtnEvents.length; i++) {
		var topMenuBtnObj = $("#resentZzimMenuLayer #topMenuBtn"+i);
		if(topMenuBtnObj.length>0) {
			var imgUrl = topMenuBtnObj.attr("src");
			if(imgUrl.indexOf("_off")<0) {
				imgUrl = imgUrl.split("_on.png").join("_off.png");

				topMenuBtnObj.attr("src", imgUrl);
			}
		}
	}

	if(listType==1 || listType==2) {
		var topMenuBtn0Obj = $("#topMenuBtn0");
		var imgUrl = topMenuBtn0Obj.attr("src");
		if(imgUrl.indexOf("_on")>-1) {
			imgUrl = imgUrl.split("_on.png").join("_off.png");

			topMenuBtn0Obj.attr("src", imgUrl);
		}
	}
}

// 체크가 되었을 때 총합 계산
function checkedItemPriceSum() {
	var sumPrice = 0;
	var checkedItemCnt = 0;

	if(listType==1 || listType==2) {
		for(var i=0; i<nowFolderItemNum; i++) {
			var listCheckObj = $("#listCheck"+i);
			var checkStatus = listCheckObj.is(":checked");

			if(checkStatus) {
				var tempPrice = $("#listItem"+i+" .price_mall .number").text();
				
				if(tempPrice.length==0) {
					tempPrice = $("#listItem"+i+" .price_mall .numberLong").text();
				}

				if(tempPrice.length>0) {
					tempPrice = tempPrice.split(",").join("");
					

					var intPrice = 0;
					try {
						intPrice = parseInt(tempPrice);
					} catch(e) {}

					sumPrice += intPrice;
					
				}

				checkedItemCnt++;
			}
		}
	} else {
		sumPrice = 0;
		for(var i=0; i<nowFolderItemNum; i++) {
			var listCheckObj = $("#listCheck"+i);
			var checkStatus = listCheckObj.is(":checked");

			if(checkStatus) {
				var tempPrice = $("#listItem"+i+" .estSelectShopSum .priceText").text();

				if(tempPrice.length>0) {
					tempPrice = tempPrice.split(",").join("");

					var intPrice = 0;
					try {
						intPrice = parseInt(tempPrice);
					} catch(e) {}

					sumPrice += intPrice;
					
				}

				checkedItemCnt++;
			}
		}
	}

	// toLocaleString()을 하면 소수점이 나옴
	var sumPriceStr = sumPrice.toLocaleString().split(".")[0];
	
	$("#resentZzimMenuLayer .sumPriceDiv span").html(sumPriceStr);

	// 선택한 개수 보여주기
	var checkedItemInfoText = "";
	if(checkedItemCnt>0) {
		checkedItemInfoText = "선택한 "+checkedItemCnt+"개 상품을";
	} else {
		checkedItemInfoText = "<span>상품을</span> <img src=\""+rzRoot20140221+"check(1).gif\" align=\"absmiddle\" /><span>하셔서</span>";
	}
	$("#resentZzimMenuLayer .resentZzimMenuBody .menuButtons .menuInfo1").html(checkedItemInfoText);
}

// 큰이미지 여는 함수
function showImage(modelno) {
	var bigbigImage = window.open("/view/enuriupload/Show_ImagePopup.jsp?modelno="+modelno+"&goodsBbsOpenType=1&sopnShowFlag=false&imgname=1","bigbigImage","width="+window.screen.width+",height="+screen.availHeight+",top=0,left=0,toolbar=no,location=no,directories=no,status=no,scrollbars=no,resizable=yes,menubar=no,personalbar=no");	
	bigbigImage.focus();
}

// 상품창을 여는 함수
var detailWin = null; 
function detailMultiView(OpenFile,name,modelno){
	detailWin = window.open(OpenFile,"detailMultiWin","width=804,height="+window.screen.height+",left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
	detailWin.focus();
}

// 쇼핑몰의 상품페이지로 이동하는 함수
function CmdGotoMall(type, cmd, vcode, modelno, price, url,cate,pl_no,imgurl) {
	var varMoveTargetPage = "/move/Redirect.jsp";
	var w = window.screen.width;
	var h = screen.availHeight ;
	var varTargetUrl = varMoveTargetPage+"?type="+type+"&cmd="+cmd+"&vcode="+vcode+"&modelno="+modelno+"&price="+price+"&pl_no="+pl_no+"&imgurl="+imgurl;
	k = window.open (varTargetUrl,"_blank");
	k.focus();		
	return;
}
// 목록의 상품 URL 클립보드 저장
var clipAry = new Array();
function listModelUrlCopy(idx, url) {
	/*
	var clip = new ZeroClipboard.Client();
	var saveText = url;

	var lastObj = $("#listModelUrl"+idx);
	clip.glue(lastObj[0]);
	
	clip.addEventListener('mouseOver', function(client, text) {
		clip.setText(saveText);
	});

	clip.addEventListener('complete', function(client, text) {
		alert("상품 URL을 저장했습니다.");
	});

	clipAry[idx] = clip;
	*/
	
	
}

// 체크박스에 모델명 저장하기
var checkedModelList = "";
var checkedModelList = "";
// 체크 했을 때 나오는 이미지 버튼들
// 0:삭제, 1:이동, 2:비교, 3:견적, 4:찜, 5:닫기
var checkedBtnImgs = [ "btn_del", "btn_move", "btn_comp", "btn_esti", "btn_zzim", "btn_close" ];
var checkedBtnEvents = [ "deleteListModel();", "moveListModel();", "compareListModel();", "estiListModel();", "zzimListModel();", "closelistCheckMenu();" ];
var checkedBtnLogs = [ 0, 9809, 9808, 9807, 9806, 0 ];
// 체크 했을 때 나오는 이미지 버튼들을 세팅
var oldCheckMenuTop = 0;
function showlistCheckMenu(jObj) {
	var modelno = jObj.attr("value");
	var moveBtnFlag = false;
	if(listType==2 && zzimFolderCnt>1) {
		moveBtnFlag = true;
	}

	var checkMenuDivObj = $("#checkMenuDiv");

	checkMenuDivObj.find(".checkMenu1").html("");
	checkMenuDivObj.find(".checkMenu2").html("");

	var menuHtml1 = "";
	var menuHtml2 = "";
	var menuListStr = "";

	if(mailYN!="Y") {
		menuListStr += "0:"; // 삭제 버튼
	}

	if(checkedModelList.length>0) {
		if(listType==1) {
			menuListStr += "4:"; // 찜 버튼
			if(checkedModelList.indexOf(",")>-1) {
				menuListStr += "2:"; // 비교 버튼
			}
		}
		if(listType==2) {
			if(moveBtnFlag && mailYN!="Y") {
				menuListStr += "1:"; // 이동 버튼
			}
			if(checkedModelList.indexOf(",")>-1) {
				menuListStr += "2:"; // 비교 버튼
			}
		}
		menuListStr += "3"; // 견적 버튼
	}

	var menuListAry = menuListStr.split(":");
	var addMenuCnt = 0;
	for(var i=0; i<menuListAry.length; i++) {
		var menuItemNum = -1;
		try {
			menuItemNum = parseInt(menuListAry[i]);
		} catch(e) {}

		if(menuItemNum>-1) {
			if(addMenuCnt>1 && menuListAry.length>3) {
				menuHtml2 += "<img id=\"eventBtnCheck"+menuItemNum+"\" src=\""+rzRoot+checkedBtnImgs[menuItemNum]+".png\">";
			} else {
				menuHtml1 += "<img id=\"eventBtnCheck"+menuItemNum+"\" src=\""+rzRoot+checkedBtnImgs[menuItemNum]+".png\">";
			}

			addMenuCnt++;
		}
	}
	if(menuListStr.length>0) {
		menuHtml1 += "<img id=\"eventBtnCheck5\" src=\""+rzRoot+checkedBtnImgs[5]+".png\">";

		checkMenuDivObj.find(".checkMenu1").html(menuHtml1);
		checkMenuDivObj.find(".checkMenu2").html(menuHtml2);

		checkMenuDivObj.find("img").unbind();
		checkMenuDivObj.find("img").click(function (e) {
			var thisId = $(this).attr("id");
			var idNum = thisId.replace("eventBtnCheck", "");
			var intIdNum = -1;
			try {
				intIdNum = parseInt(idNum);
			} catch(e) {}

			if(intIdNum>-1) {
				eval(checkedBtnEvents[intIdNum]);

				// 로그 넣기 로그 데이터는 수정해야함
				if(checkedBtnLogs[intIdNum]>0) insertLog(checkedBtnLogs[intIdNum]);
			}
		});
		
		
		// 보여주기
		var posTop = jObj.offset().top + 24;
		var posLeft = jObj.offset().left + 10;

		// 이전에 보였던 위치를 기억해 놓고 다른 곳에서 사용
		oldCheckMenuTop = posTop;

		checkMenuDivObj.css("top", posTop);
		checkMenuDivObj.css("left", posLeft);

		checkMenuDivObj.css("display", "block");
	}
}

function deleteListModel() {
	if(listType==9) {
		//아래는 url로 삭제할 경우 사용함
		//=P:1119274305,P:1119274305
		var thisUrl = document.location.href;

		for(var i=0; i<nowFolderItemNum; i++) {
			var listCheckObj = $("#listCheck"+i);
			var checkStatus = listCheckObj.is(":checked");

			if(checkStatus) {
				var delCheckText = listCheckObj.val();

				thisUrl = thisUrl.split("="+delCheckText).join("=");
				thisUrl = thisUrl.split(","+delCheckText).join("");
				
				document.location.href = thisUrl;

				//새로고침 안하고 제거
				//var delListItemObj = $("#listItem"+i);
				//delListItemObj.remove();
			}
		}
		alert("선택한 상품이 삭제되었습니다.");

	} else {
		if(checkedGoodsList=="") {
			alert("삭제할 모델을 선택해 주세요");
			return;
		}

		var f_checked_del_modelno = checkedGoodsList;
		var strTblName = "today";
		if(listType==2) strTblName = "save";
		
		// 이전 버전 삭제 하던 모듈은 그대로 사용함
		var url = "/view/deleteSaveGoodsProc.jsp";
		var param = "modelnos="+f_checked_del_modelno+"&tbln="+strTblName;

		$.ajax({
			type : "post",
			url : url,
			data : param, 
			dataType : "html",
			success : function(ajaxResult) {
				alert("선택한 상품이 삭제되었습니다.");

				loadGoodsList(folder_id);
				if(listType==2) {
					loadZzimFolder();
				}
				// 최근본과 찜의 개수 다시 세팅
				loadResentZzimCnt();

				closelistCheckMenu();
			}
		}); 
	}

}

function moveListModel() {
	if(checkedModelList=="") {
		alert("이동할 모델을 선택해 주세요");
		return;
	}

	zzimMoveLayerShow();

	closelistCheckMenu();
}

// 찜 이동 레이어 보여주기
function zzimMoveLayerShow() {
	// 이동 레이어 객체
	var zzimMoveLayerObj = $("#zzimMoveLayer");

	setZzimMoveLayer();

	var checkedModelNum = 0;
	try {
		checkedModelNum = checkedModelList.split(",").length;
	} catch(e) {}
	
	zzimMoveLayerObj.find(".zzimMoveLayerInfo span").html(checkedModelNum);

	// 체크시 보이는 메뉴
	var checkMenuDivObj = $("#checkMenuDiv");

	var posTop = checkMenuDivObj.offset().top;
	var posLeft = checkMenuDivObj.offset().left;
	
	// 전체메뉴가 체크 되었을 경우 위치는 고정
	//if(document.getElementById("allCheckBox").checked) {
	//if(oldCheckMenuTop==0) {
		posTop = $("#resentZzimMenuLayer").offset().top + 80;
		posLeft = 220;
	//}

	zzimMoveLayerObj.css("top", posTop+"px");
	zzimMoveLayerObj.css("left", posLeft+"px");

	checkMenuDivObj.css("display", "none");
	zzimMoveLayerObj.css("display", "block");
}

// 미리 저장된 folderJsonObj를 이용해 폴더 이동 레이어를 구성함
function setZzimMoveLayer() {
	var zzimMoveLayerBodyObj = $("#zzimMoveLayerBody");
	var tempFolderMoveLayerHtml = "";

	zzimMoveLayerBodyObj.html("");


	$.each(folderJsonObj, function(indexI, folderListObj) {
		var tempFolder_id = folderListObj["folder_id"];
		var tempFolder_cnt = folderListObj["folder_cnt"];
		var intTempFolder_id = 0;

		try {
			intTempFolder_id = parseInt(tempFolder_id);
		} catch(e) {}

		if(intTempFolder_id!=folder_id) {
			tempFolderMoveLayerHtml += "<div class=\"zzimMoveItem\">";
			tempFolderMoveLayerHtml += "	<div id=\"zzimMoveItem"+tempFolder_id+"\" class=\"zzimMoveItemName\">";
			tempFolderMoveLayerHtml += "		<div id=\"zzimIdx"+tempFolder_id+"\" class=\"zzimIdx\"></div>";
			tempFolderMoveLayerHtml += "		<div id=\"zzimNum"+tempFolder_id+"\" class=\"zzimNum\">("+tempFolder_cnt+")</div>";
			tempFolderMoveLayerHtml += "	</div>";
			tempFolderMoveLayerHtml += "	<div id=\"zzimMoveItemButton"+tempFolder_id+"\" class=\"zzimMoveItemButton\">";
			tempFolderMoveLayerHtml += "		<img id=\"moveBtnImg"+tempFolder_id+"\" src=\"http://img.enuri.gscdn.com/images/view/resentzzim/btn_go.gif\" />";
			tempFolderMoveLayerHtml += "	</div>";
			tempFolderMoveLayerHtml += "</div>";
		}

	});

	zzimMoveLayerBodyObj.html(tempFolderMoveLayerHtml);

	var zzimMoveItemObj = zzimMoveLayerBodyObj.find(".zzimMoveItemName div");
	zzimMoveItemObj.unbind();
	zzimMoveItemObj.click(function (e) {
		var thisId = $(this).parent().attr("id");
		var idNum = thisId.replace("zzimMoveItem", "");
		var intIdNum = -1;
		try {
			intIdNum = parseInt(idNum);
		} catch(e) {}

		if(intIdNum>-1) {
			setMoveFolderName(intIdNum);
		}
	});

	var zzimMoveItemButtonObj = zzimMoveLayerBodyObj.find(".zzimMoveItemButton img");
	zzimMoveItemButtonObj.unbind();
	zzimMoveItemButtonObj.click(function (e) {
		// 폴더의 개수들을 다시 읽어와서 확인함
		resetZzimFolderNums();

		var thisId = $(this).attr("id");
		var tempFolder_id = thisId.replace("moveBtnImg", "");
		var selectedMoveItems = checkedModelList;
		var intTempFolder_id = 0;
		try {
			intTempFolder_id = parseInt(tempFolder_id);
		} catch(e) {}
		var selectedMoveItemsCnt = selectedMoveItems.split(",").length;

		if((folderItemsCnt[intTempFolder_id-1]+selectedMoveItemsCnt)>folderItemsMaxCnt[intTempFolder_id-1]) {
			alert("이동할 폴더에 저장공간이 없습니다.\n상품 삭제 후 이동하세요.");
			return;
		}

		var url = "/view/resentzzim/ajax/Ajax_moveGoodsFolder.jsp";
		var param = "folder_id="+tempFolder_id+"&selectedMoveItems="+selectedMoveItems;
		
		//alert(url+"?"+param)

		$.ajax({
			type : "post",
			url : url,
			data : param, 
			dataType : "html",
			success : function(ajaxResult) {
				alert("정상 이동되었습니다.");

				loadZzimFolder();
				loadGoodsList(folder_id);
				zzimMoveLayerHidden();
				checkedItemPriceSum();
			}
		}); 
	});
	
	for(var i=0; i<zzimFolderCnt; i++) {
		// 링크 적용
		var tempIdx = (i+1);
		if(tempIdx!=folder_id) {
			var zzimIdxObj = zzimMoveLayerBodyObj.find("#zzimIdx"+tempIdx);

			zzimIdxObj.css("background-image", "url(http://img.enuri.gscdn.com/images/view/resentzzim/zzim"+tempIdx+".gif)");
		}
	}

}

// 폴더의 개수정보를 다시 세팅함
function resetZzimFolderNums() {
	var loadUrl = "/view/resentzzim/ajax/Ajax_zzimFolderList.jsp";

	$.getJSON(loadUrl, null, function(data) {
		folderJsonObj = data["folderList"];

		try {
			zzimFolderCnt = parseInt(data["folderCnt"]);
		} catch(e) {}

		$.each(folderJsonObj, function(indexI, folderListObj) {
			var tempFolder_id = folderListObj["folder_id"];
			var tempFolder_cnt = folderListObj["folder_cnt"];

			try {
				intTempFolder_id = parseInt(data["tempFolder_id"]);
			} catch(e) {}

			// 폴더의 아이템개수 세팅
			try {
				folderItemsCnt[tempFolder_id-1] = parseInt(tempFolder_cnt);
			} catch(e) {}

			if(folder_id==intTempFolder_id) {
				nowFolderItemNum = parseInt(tempFolder_cnt);
			}
		});
	});
}

function zzimMoveLayerHidden() {
	var zzimMoveLayerObj = $("#zzimMoveLayer");

	zzimMoveLayerObj.css("display", "none");
}

//목록에서 사용하는 비교 로직을 그대로 가져다 씀
var compareMultiWin;
function compareListModel() {
	if(checkedModelList.indexOf(",")<0) {
		alert("2개 이상 선택하셔야 비교할 수 있습니다.");
		return;
	}

	closelistCheckMenu();

	var varChkModelNos = checkedModelList;
	
	if(compareMultiWin != null && !compareMultiWin.closed) {
		varChkModelNos = compareMultiWin.chkNo+","+varChkModelNos;
	}
	if(varChkModelNos.indexOf(",") < 0) {
		var posLeftTop = Position.cumulativeOffset($("aside"));
		document.getElementById("comparisonInfo").style.left = (posLeftTop[0]-350)+"px"
		document.getElementById("comparisonInfo").style.top = (getBodyScrollTop() + getBodyClientHeight() - 110)+"px"
		if(document.getElementById("comparisonInfo").innerHTML == "") {
			var varComparisonInfo = "";
			varComparisonInfo += "<img src=\""+var_img_enuri_com+"/images/layer/layer_compare.gif\" width=\"329\" height=\"102\" border=\"0\" usemap=\"#comparisonInfoMap\" />";
			varComparisonInfo += "<map name=\"comparisonInfoMap\" id=\"comparisonInfoMap\">";
			varComparisonInfo += "<area shape=\"rect\" coords=\"302,4,323,23\" href=\"#\" onclick=\"document.getElementById('comparisonInfo').style.display='none';return false;\" />";
			varComparisonInfo += "<area shape=\"rect\" coords=\"278,73,315,94\" href=\"#\" onclick=\"insertLog(939);OpenWindowPosition('/view/popup/TowCheckInfo_Popup.jsp','towcheck_1','398','400','YES','NO','250','250');document.getElementById('comparisonInfo').style.display='none';return false;\" />";
			varComparisonInfo += "</map>";
			document.getElementById("comparisonInfo").innerHTML = varComparisonInfo;
		}
		document.getElementById("comparisonInfo").style.display = "";			
		document.getElementById("div_inconv").style.display = "none";
	} else {
		varChkModelNos = cleanArray(eliminateDuplicates(varChkModelNos.split(","))).toString();
		varChkModelNos = varChkModelNos.split("G:").join("");
		compareMultiWin = window.open("/view/Comparemulti.jsp?chkNo="+varChkModelNos,"Comparemulti","width=700,height=600,left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=yes,resizable=yes,menubar=no");
		compareMultiWin.focus();		
	}
	function cleanArray(actual) {
		var newArray = new Array();
		for(var i = 0; i<actual.length; i++) {
			if (actual[i]) {
				newArray.push(actual[i]);
			}
		}
		return newArray;
	}
	function eliminateDuplicates(arr) {
		var i,
		len=arr.length,
		out=[],
		obj={};

		for (i=0;i<len;i++) {
			obj[arr[i]]=0;
		}
		for (i in obj) {
			out.push(i);
		}
		return out;
	}	

}

function estiListModel() {
	if(checkedModelList=="") {
		alert("상품을 선택해 주세요");
		return;
	}

	document.location.href = "/view/resentzzim/resentzzimList.jsp?listType=9&goodsNumList="+checkedModelList;
	/*
	var objEstimate = window.open('/view/resentzzim/resentzzimList.jsp?listType=9&goodsNumList='+checkedModelList,'estimate','menubar=no,toolbar=no,location=no,directories=no,resizable=yes,status=no,scrollbars=yes,height='+window.screen.height+',width=670');
	objEstimate.focus();

	closelistCheckMenu();
	*/
}

function zzimListModel() {
	if(checkedModelList=="") {
		//alert("모델을 선택해 주세요");
		return;
	}

	var varChkModelNos = checkedModelList;

	if(islogin()) {
		insertZzimProcNew(varChkModelNos);
		closelistCheckMenu();
	} else {
		Cmd_Login("resentzzimList");
	}
}

function zzimListClickLoginLayer() {
	var checkMenuDivObj = $("#checkMenuDiv");
	var posTop = checkMenuDivObj.offset().top;
	posTop = $("#resentZzimMenuLayer").offset().top + 80;

	cmdLoginLayer(250, posTop);

	closelistCheckMenu();
}

function insertZzimProcNew(varChkModelNos) {
	var url = "/view/include/insertSaveGoodsProc.jsp";
	var param = "modelnos="+varChkModelNos;
	
	$.ajax({
		type : "post",
		url : url,
		data : param, 
		dataType : "json",
		success : function(ajaxResult) {
			// 최근본과 찜의 개수 다시 세팅
			loadResentZzimCnt();

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

function closelistCheckMenu() {
	var checkMenuDivObj = $("#checkMenuDiv");

	checkMenuDivObj.css("display", "none");
}

// 폴더정보 세팅
var zzimFolderCnt = 0;
var folder_id = 1;
var nowFolderItemNum = 0;
var folderJsonObj = null;
// 폴더별로 들어있는 상품의 개수 세팅
var folderItemsCnt = [0, 0, 0, 0, 0];
// 폴더별 이동 가능한 최대 개수
var folderItemsMaxCnt = [100, 50, 50, 50, 50];
function loadZzimFolder() {
	var loadUrl = "/view/resentzzim/ajax/Ajax_zzimFolderList.jsp";

	$.getJSON(loadUrl, null, function(data) {
		var zzimFolderDivObj = $("#zzimFolderDiv");
		zzimFolderDivObj.css("display", "inline");

		folderJsonObj = data["folderList"];

		try {
			zzimFolderCnt = parseInt(data["folderCnt"]);
		} catch(e) {}
		
		var zzimFolderListDivObj = $("#zzimFolderListDiv");
		// 상단의 폴더 정보 세팅
		var tempFolderListHtml = "";

		zzimFolderListDivObj.html("");

		var tempItemSum = 0;
		$.each(folderJsonObj, function(indexI, folderListObj) {
			var tempFolder_id = folderListObj["folder_id"];
			var tempFolder_cnt = folderListObj["folder_cnt"];
			var intTempFolder_id = 0;

			try {
				intTempFolder_id = parseInt(data["tempFolder_id"]);
			} catch(e) {}
			
			// 폴더의 아이템개수 세팅
			try {
				folderItemsCnt[tempFolder_id-1] = parseInt(tempFolder_cnt);
				tempItemSum += parseInt(tempFolder_cnt);
			} catch(e) {}
			
			tempFolderListHtml += "<div id=\"zzimFolder"+tempFolder_id+"\" class=\"zzimFolder\">";
			tempFolderListHtml += "<div id=\"zzimIdx"+tempFolder_id+"\" class=\"zzimIdx\"></div>";
			tempFolderListHtml += "<div id=\"zzimNum"+tempFolder_id+"\" class=\"zzimNum\">("+tempFolder_cnt+")</div></div>";
		});

		zzimFolderListDivObj.html(tempFolderListHtml);

		
		// 찜폴더의 BackgroundImage 변경
		for(var i=0; i<zzimFolderCnt; i++) {
			// 링크 적용
			var tempIdx = (i+1);
			var zzimIdxObj = $("#zzimIdx"+tempIdx);

			zzimIdxObj.css("background-image", "url(http://img.enuri.gscdn.com/images/view/resentzzim/zzim"+tempIdx+".gif)");

			if(tempIdx==folder_id) {
				zzimIdxObj.parent().find("div").css("border-bottom", "1px solid #000000");
			}
		}

		// 링크 적용
		var zzimFolderObj = zzimFolderListDivObj.find(".zzimFolder div");
		zzimFolderObj.unbind();
		zzimFolderObj.click(function (e) {
			var thisId = $(this).parent().attr("id");
			var idNum = thisId.replace("zzimFolder", "");
			var intIdNum = -1;
			try {
				intIdNum = parseInt(idNum);
			} catch(e) {}

			// 이전 밑줄을 없앰
			if(folder_id!=intIdNum) {
				$("#zzimFolder"+folder_id).find("div").css("border-bottom", "0px solid");
			}

			loadGoodsList(idNum);
		});

		if(zzimFolderCnt>1) {
			zzimFolderObj.hover(function (e) {
				var parentObj = $(this).parent();
				parentObj.find("div").css("border-bottom", "1px solid #000000");
			}, function (e) {
				var parentObj = $(this).parent();
				var idNum = parentObj.attr("id").replace("zzimFolder", "");

				if(idNum!=(folder_id+"")) {
					parentObj.find("div").css("border-bottom", "0px solid #000000");
				}
			});
		}

		// 폴더 5개일때는 '폴더추가' 버튼 안나오도록
		// 폴더 1개일때는 폴더 삭제 안나오도록
		var newZzimFolderImgObj = $("#newZzimFolder img"); 
		if(zzimFolderCnt==5) {
			newZzimFolderImgObj.parent().css("display", "none");
		} else {
			newZzimFolderImgObj.parent().css("display", "inline");
			newZzimFolderImgObj.unbind();
			newZzimFolderImgObj.click(function (e) {
				createFolderAction();
			});
			newZzimFolderImgObj.hover(function (e) {
				$(this).attr("src", "http://img.enuri.gscdn.com/images/view/resentzzim/folder_add_on.gif");
			}, function (e) {
				$(this).attr("src", "http://img.enuri.gscdn.com/images/view/resentzzim/folder_add.gif");
			});
		}

		var deleteZzimFolderImgObj = $("#deleteZzimFolder img");
		if(zzimFolderCnt==1) {
			deleteZzimFolderImgObj.parent().css("display", "none");
		} else {
			deleteZzimFolderImgObj.parent().css("display", "inline");
			deleteZzimFolderImgObj.unbind();
			deleteZzimFolderImgObj.click(function (e) {
				deleteFolderAction();
			});
			deleteZzimFolderImgObj.hover(function (e) {
				$(this).attr("src", "http://img.enuri.gscdn.com/images/view/resentzzim/folder_del_on.gif");
			}, function (e) {
				$(this).attr("src", "http://img.enuri.gscdn.com/images/view/resentzzim/folder_del.gif");
			});
		}
		
		// 폴더가 1개일 경우는 폴더 전체이동이 없어져야함
		if(zzimFolderCnt==1) {
			$("#resentZzimMenuLayer #topMenuBtn2").css("display", "none");
		} else {
			$("#resentZzimMenuLayer #topMenuBtn2").css("display", "inline");
		}
		
		if(tempItemSum==0) {
			$("#zzimFolderDiv").css("display", "none");
		}

	});
}

// URL, 즐찾, 메일, 인쇄 세팅 -> 인쇄는 이번엔 뺌
//var listSubMenuAry = [ "url", "bookmark", "mail", "print" ];
//var listSubMenuLinkAry = [ "", "listFavoriteSave();", "mailLayerShow();", "alert('test44');" ];
var listSubMenuAry = [ "url", "bookmark", "mail", "print" ];
var listSubMenuLinkAry = [ "listUrlCopyOne();", "listFavoriteSave();", "mailLayerShow();", "CmdPagePrint();" ];
var listSubMenuLog = [ 9815, 9816, 9817, 0 ];
var listSubMenuIdx = 0;
function loadListSubMenuDiv() {
	var listSubMenuDivObj = $("#listSubMenuDiv");

	// 상단 타이틀 reload
	$("#listTitleDiv .listTitleImg img").unbind();
	$("#listTitleDiv .listTitleImg img").click(function (e) {
		document.location.reload();
	});

	for(var i=0; i<listSubMenuAry.length; i++) {
		var menuItemObj = listSubMenuDivObj.find("."+listSubMenuAry[i]+"Img img");

		menuItemObj.unbind();
		menuItemObj.click(function (e) {
			var thisName = $(this).parent().attr("class");
			thisName = thisName.replace("Img", "");

			var idx = getArrayIdx(listSubMenuAry, thisName);
			
			if(listSubMenuLinkAry[idx].length>0) {
				eval(listSubMenuLinkAry[idx]);
			}

			if(listSubMenuLog[idx]>0) insertLog(listSubMenuLog[idx]);
		});

		menuItemObj.hover(function (e) {
			var thisName = $(this).parent().attr("class");
			thisName = thisName.replace("Img", "");
			
			$(this).attr("src", IMG_ENURI_COM + "/images/view/resentzzim/"+thisName+"_on.gif");
		}, function (e) {
			var thisName = $(this).parent().attr("class");
			thisName = thisName.replace("Img", "");

			$(this).attr("src", IMG_ENURI_COM + "/images/view/resentzzim/"+thisName+".gif");
		});
	}
}

// 메일 레이어 띄우기
function mailLayerShow() {
	var shareMailObj = $("#shareMail");

	if(shareMailObj.css("display")=="none") {
		//var posTop = $("#resentZzimMenuLayer").offset().top + 58;
		var posTop = document.getElementById("resentZzimMenuLayer").clientTop + 58;

		shareMailObj.css("display", "block");

		shareMailObj.css("top", posTop + "px");

		// 닫기 버튼 세팅
		var closeBtnObj = shareMailObj.find(".closeBtn Img");
		closeBtnObj.unbind();
		closeBtnObj.click(function (e) {
			mailLayerHidden();
		});

		// 받는 메일주소 이벤트 추가
		shareMailObj.find(".recv img").unbind();
		shareMailObj.find(".recv img").click(function (e) {
			addMailRecvShow();
		});
		shareMailObj.find(".addRecvBtn").unbind();
		shareMailObj.find(".addRecvBtn").click(function (e) {
			addMailRecvHidden($(this));
		});

		if(islogin()) {
			shareMailObj.find("#numberInputCheck").css("display", "none");
		} else {
			// 보안문자 변경 이벤트 추가
			captchaImgChange();
			shareMailObj.find("#captchaRefresh img").unbind();
			shareMailObj.find("#captchaRefresh img").click(function (e) {
				captchaImgChange();
			});
		}
		
		
		shareMailObj.find("#emailSend img").unbind();
		shareMailObj.find("#emailSend img").click(function (e) {
			var rEmails = "";
			var rEmailObj = $("#recvEmail");

			if( rEmailObj.val() == "" ) {
				alert("수신자 정보가 없습니다.");
				rEmailObj.focus();
				return;
			} else if( !islogin() && $("#imgPassText").val() == "" ) {
				alert("좌측 이미지의 숫자를 우측 칸에 입력해주세요");
				$("#imgPassText").focus();
				return;
			} else {
				var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
				var email = "";
				if(rEmailObj.parent().css("display")!="none") {
					email = rEmailObj.val();
					if(regex.test(email) === false) {
						alert("잘못된 이메일 형식입니다.");
						rEmailObj.focus();
						return false;
					}
				}

				//if($("#send_name").val()=="" || $("#send_name").val()=="발신자 명") {
					//$("#send_name").val("에누리닷컴");
				//}
				var mailTitleStr = "[에누리] ";
				var nowDate = new Date();
				var nowdatestr = nowDate.getFullYear()+"."+(nowDate.getMonth()+1)+"."+nowDate.getDate();
				mailTitleStr += nowdatestr;

				if(listType==1) mailTitleStr += " 최근본상품";
				if(listType==2) mailTitleStr += " 찜상품";
				if(listType==9) mailTitleStr += " 견적보기";

				var tempEmailTitle = $("#sendMailSubject").val();
				if(tempEmailTitle=="제목") tempEmailTitle = "";
				if(tempEmailTitle.length>0) tempEmailTitle = " - " + tempEmailTitle;

				$("#mailForm_nowdatestr").val(nowdatestr);
				$("#mailForm_subject").val(mailTitleStr + tempEmailTitle);

				if( $("#emailContents").val()=="본문") {
					$("#emailContents").val("");
				}
			}

			if(rEmailObj.parent().css("display")!="none") {
				rEmails += rEmailObj.val();
				if(i+1 < rEmailObj.length) rEmails += ",";
			}

			var mailFormObj = $("#mailForm");

			//mailFormObj.attr("target", "");
			//mailFormObj.attr("method", "get");
			mailFormObj.attr("action", "/view/resentzzim/ajax/Ajax_sendGoodsMail.jsp");
			document.mailForm.to_email.value = rEmails;
			document.mailForm.mailSendGoods.value = listGoodsStr;

			//document.mailForm.target = "";

			document.mailForm.submit();
		});

	} else {
		mailLayerHidden();
	}
}

// 메일 레이어에서 받는 사람 메일 주소 추가(3개까
var addMailRecvShowFlag = [ false, false ];
function addMailRecvShow() {
	for(var i=0; i<addMailRecvShowFlag.length; i++) {
		if(addMailRecvShowFlag[i]==false) {
			var addEmailDivObj = $("#addEmailDiv"+(i+1));
			addEmailDivObj.css("display", "block");

			addMailRecvShowFlag[i] = true;

			break;
		}
	}
}

//메일 보안문자 가져오는 url
function getCaptchaImgUrl() {
	var dateLong = (new Date()).getTime();
	var captchaImgURL = "/mailer/Mailsend_Getpassimage.jsp?dateLong="+dateLong;

	return captchaImgURL;
}

//메일발송 보안문자 그림 변경
function captchaImgChange() {
	var url = getCaptchaImgUrl();

	$.ajax({
		url: url,
		success: function(data) {
			var imgName = $.trim(data);
			$("#captchaImg").attr("src","http://img.enuri.gscdn.com/images/mailing/mailimage/"+imgName);
			$("#mailForm_passImgName").val(imgName);
		},
		error:function (xhr, ajaxOptions, thrownError) {
			try {
				console.log(xhr.status);
				console.log(thrownError);
			} catch(ex) {
			}
		}
	});
}

//필수 입력 처리 하는 함수
function onBlurCheck(obj) {
	try {
		if(obj.value==obj.defaultValue || obj.value=="") {
			obj.value = obj.defaultValue;
			obj.style.color = "#676767";
		}
	} catch(e) {}
}

function onFocusCheck(obj) {
	if(obj.value==obj.defaultValue) {
		obj.value = "";
		obj.style.color = "#000000";
		obj.focus();
	}
}

//메일 내용에 대한 기본내용 세팅
var mailContentDefault = "본문";
function onBlurContentsCheck(obj) {
	if(obj.value==mailContentDefault || obj.value=="") {
		obj.value = mailContentDefault;
		obj.style.color = "#676767";
	}
}
function onFocusContentsCheck(obj) {
	if(obj.value==mailContentDefault) {
		obj.value = "";
		obj.style.color = "#000000";
	}
}
//메일 보내기 테스트
function mailSendAction() {
	var url = "/view/resentzzim/Ajax_sendGoodsMail.jsp";
	var param = "";
	//var param = "selectedMoveItems="+selectedMoveItems;

	$.ajax({
		type : "post",
		url : url,
		data : param, 
		dataType : "html",
		success : function(ajaxResult) {
			alert("메일이 전송되었습니다.");
		}
	}); 
}

function addMailRecvHidden(thisObj) {
	var thisId = thisObj.attr("id");
	var idNum = thisId.replace("addRecvBtn", "");
	var intIdNum = -1;
	try {
		intIdNum = parseInt(idNum);
	} catch(e) {}

	if(intIdNum>0) {
		var addEmailDivObj = $("#shareMail #addEmailDiv"+intIdNum);

		addEmailDivObj.find("input").attr("value", "");
		addEmailDivObj.css("display", "none");

		addMailRecvShowFlag[intIdNum-1] = false;
	}
}

// 메일레이어 닫기
function mailLayerHidden() {
	var shareMailObj = $("#shareMail");
	
	document.mailForm.reset();

	shareMailObj.css("display", "none");
}

function mailBodyToggle(){
	var obj_none = document.getElementById("mailBodyNone");
	var obj_body = document.getElementById("mailBody");
	if(obj_body.style.display=="block"){
		obj_none.style.display = "block";
		obj_body.style.display = "none";
	}else{
		obj_none.style.display = "none";
		obj_body.style.display = "block";
	}
}

// 현재 url즐겨찾기에 저장
function listFavoriteSave() {
	if(listGoodsStr.length==0) {
		alert("현재 목록에 즐겨찾기 할 상품이 없습니다.");
		return;
	}

	var bTitle = "[에누리]";
	var nowDate = new Date();
	var nowdatestr = nowDate.getFullYear()+"."+(nowDate.getMonth()+1)+"."+nowDate.getDate();
	bTitle += nowdatestr;

	//var bUrl = "http://www.enuri.com/view/resentzzim/resentzzimList.jsp?listType="+listType+"&mailYN=Y&listShownDate="+nowdatestr+"&goodsNumList="+listGoodsStr;
	var bUrl = "http://"+document.domain+"/view/resentzzim/resentzzimList.jsp?listType="+listType+"&mailYN=Y&listShownDate="+nowdatestr+"&goodsNumList="+listGoodsStr;

	if(listType==1) bTitle += " 최근본상품 ";
	if(listType==2) bTitle += " 찜상품 ";
	if(listType==9) bTitle += " 견적보기 ";

	try {
		if(window.sidebar) {
			window.sidebar.addPanel(bTitle, bUrl, "");
		} else if (window.external || document.all) {
			window.external.AddFavorite(bUrl, bTitle);
		} else if (window.opera) {
			$("a#bookmark").attr("rel","sidebar");
		}
	} catch(e) {
		alert("현재 브라우저는 즐겨찾기 기능을 지원하지 않습니다.");
	}
}

function listUrlCopyOne() {
	if(window.clipboardData) {
		var nowDate = new Date();
		var nowdatestr = nowDate.getFullYear()+"."+(nowDate.getMonth()+1)+"."+nowDate.getDate();
		var bUrl = "http://"+document.domain+"/view/resentzzim/resentzzimList.jsp?listType="+listType+"&mailYN=Y&listShownDate="+nowdatestr+"&goodsNumList="+listGoodsStr;

		window.clipboardData.setData("Text", bUrl);
		alert("URL이 복사되었습니다.");
	} else {
		alert("URL복사 기능이 지원하지 않는 브라우져 입니다.");
	}
}

function listUrlCopy() {

	var clip = new ZeroClipboard.Client();

	var lastObj = $("#urlCopyImg");

	clip.glue(lastObj[0]);

	clip.addEventListener('mousedown', function(client, text) {
		if(listSubMenuLog[0]>0) insertLog(listSubMenuLog[0]);
	});

	clip.addEventListener('mouseOver', function(client, text) {
		var nowDate = new Date();
		var nowdatestr = nowDate.getFullYear()+"."+(nowDate.getMonth()+1)+"."+nowDate.getDate();

		var bUrl = "http://"+document.domain+"/view/resentzzim/resentzzimList.jsp?listType="+listType+"&mailYN=Y&listShownDate="+nowdatestr+"&goodsNumList="+listGoodsStr;

		clip.setText(bUrl);

		$("#urlCopyImg").attr("src", IMG_ENURI_COM + "/images/view/resentzzim/url_on.gif");
	});

	clip.addEventListener('mouseOut', function(client, text) {
		$("#urlCopyImg").attr("src", IMG_ENURI_COM + "/images/view/resentzzim/url.gif");
	});

	clip.addEventListener('complete', function(client, text) {
		alert("현재 목록의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
		
		$("#urlCopyImg").attr("src", IMG_ENURI_COM + "/images/view/resentzzim/url.gif");
	});
}

// 최근본 찜 이동 버튼 세팅
function loadMoveResentZzimButton() {
	// 우측 상단 최근본이나 찜 버튼 세팅
	var moveResentZzimImgObj = $("#moveListTypeDiv .moveListTypeImg img");

	var moveListTypeLinkObj = $("#moveListTypeDiv .moveListTypeLink");

	if(listType==1) {
		$("#moveListTypeImg2").css("display", "inline");
	}
	if(listType==2) {
		$("#moveListTypeImg1").css("display", "inline");
	}
	if(listType==9) {
		$("#moveListTypeImg1").css("display", "inline");
		$("#moveListTypeImg2").css("display", "inline");
	}

	moveListTypeLinkObj.unbind();
	moveListTypeLinkObj.click(function (e) {
		var thisId = $(this).parent().attr("id");
		var idNum = thisId.replace("moveListTypeImg", "");

		if(idNum=="2") {
			if(islogin()) {
				for(var i=0; i<50; i++) {
					try {
						if(clipAry[i]!=null) {
							clipAry[i].destroy();
						}
					} catch(e) {}
				}
				document.location.href = "/view/resentzzim/resentzzimList.jsp?listType=2";
			} else {
				Cmd_Login("resentzzim");
			}

			insertLog(9811);
		}
		if(idNum=="1") {
			for(var i=0; i<50; i++) {
				try {
					if(clipAry[i]!=null) {
						clipAry[i].destroy();
					}
				} catch(e) {}
			}
			document.location.href = "/view/resentzzim/resentzzimList.jsp?listType=1";

			insertLog(9812);
		}
	});

	moveListTypeLinkObj.hover(function (e) {
		var thisId = $(this).parent().attr("id");
		var idNum = thisId.replace("moveListTypeImg", "");

		var moveResentZzimImgObj = $("#moveListTypeImg"+idNum+" img");

		if(idNum=="1") {
			moveResentZzimImgObj.attr("src", IMG_ENURI_COM + "/images/view/resentzzim/btn_recent_on.gif");
		}
		if(idNum=="2") {
			moveResentZzimImgObj.attr("src", IMG_ENURI_COM + "/images/view/resentzzim/btn_zzim_on.gif");
		}
	}, function (e) {
		var thisId = $(this).parent().attr("id");
		var idNum = thisId.replace("moveListTypeImg", "");

		var moveResentZzimImgObj = $("#moveListTypeImg"+idNum+" img");

		if(idNum=="1") {
			moveResentZzimImgObj.attr("src", IMG_ENURI_COM + "/images/view/resentzzim/btn_recent.gif");
		}
		if(idNum=="2") {
			moveResentZzimImgObj.attr("src", IMG_ENURI_COM + "/images/view/resentzzim/btn_zzim.gif");
		}
	});
}

// 배열의 idx를 읽어오는 함수
function getArrayIdx(tempArray, finder) {
	var rtnValue = -1;

	try {
		for(var i=0; i<tempArray.length; i++) {
			if(tempArray[i]==finder) {
				rtnValue = i;
				break;
			}
		}
	} catch(e) {}
	
	return rtnValue;
}


var oldFolder_id = -1;
function setMoveFolderName(folder_id) {
	var moveBtnImgObj = $("#moveBtnImg"+folder_id);
	var oldMoveBtnImgObj = $("#moveBtnImg"+oldFolder_id);

	if(oldFolder_id>-1) {
		oldMoveBtnImgObj.css("display", "none");
	}
	if(folder_id>-1) {
		moveBtnImgObj.css("display", "block");
	}
	oldFolder_id = folder_id;
}

// 새폴더를 생성함
function createFolderAction() {
	if(zzimFolderCnt==5) {
		alert("폴더는 5개까지만 생성 가능합니다.");
		return;
	}

	var url = "/view/resentzzim/ajax/Ajax_createGoodsFolder.jsp";
	var param = "";

	$.ajax({
		type : "post",
		url : url,
		data : param, 
		dataType : "html",
		success : function(ajaxResult) {
			alert("새 폴더가 생성되었습니다.");

			loadZzimFolder();
		}
	});

	insertLog(9813);
}

// 현재 선택된 폴더를 삭제함
function deleteFolderAction() {
	resetZzimFolderNums();

	if(folder_id==0) {
		alert("삭제할 폴더를 선택해 주세요.");
		return;
	}
	if(nowFolderItemNum>0) {
		if(!confirm("해당 폴더에 담긴 상품이 모두 삭제됩니다.\n삭제하시겠습니까?")) {
			return;
		}
	}

	var url = "/view/resentzzim/ajax/Ajax_deleteGoodsFolder.jsp";
	var param = "folder_id="+folder_id;

	$.ajax({
		type : "post",
		url : url,
		data : param, 
		dataType : "html",
		success : function(ajaxResult) {
			alert("폴더가 삭제되었습니다.");

			loadZzimFolder();
			loadGoodsList(1);
			zzimMoveLayerHidden();
			// 최근본과 찜의 개수 다시 세팅
			loadResentZzimCnt();
		}
	}); 

	insertLog(9814);
}

function CmdLink(url){
	location.href = url;
}

function CmdWindowOpen(url) {
	window.open(url);
}

// 인쇄하기
function CmdPagePrint() {
	try {
		window.print();
	} catch(e) {}
}

// 금액에 숫자 넣기
function addCommaNumber(n) {
	if(isNaN(n)) { return 0; }
	var reg = /(^[+-]?\d+)(\d{3})/;   
	n += '';
	while (reg.test(n))
		n = n.replace(reg, '$1' + ',' + '$2');
	return n;
}
