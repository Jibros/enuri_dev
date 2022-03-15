

///////////////////////////////////////////////////// 찜하기 스크립트 시작 /////////////////////////////////////////////////////

// 찜완료를 위한 레이어의 기본 세팅
function setZzimCompDiv() {
	var zzimCompDivObj = $("#zzimCompDiv");

	zzimCompDivObj.find(".zzimlist").unbind();
	zzimCompDivObj.find(".zzimlist").click(function() {
		goLocatonNewWindow("/view/resentzzim/resentzzimList.jsp?listType=2");
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
function zzimCompDivShow(zzimModelno, mb) {
	if(zzimModelno.toString().length>0) {
		var url = "/lsv2016/ajax/getCompareProdList_ajax.jsp";
		var param = {
			"random_seq" : random_seq,
			"goodsNumList" : "G"+zzimModelno
		}

		$.ajax({
			type : "get", 
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
				var bodyObj = $("body");

				var ua = window.navigator.userAgent;
				var bodyTop = document.documentElement ? document.documentElement.scrollTop : document.body.scrollTop;
				if(ua.indexOf('Chrome') != -1) {
					bodyTop = $(window).scrollTop();
				}

				var top = bodyTop + bodyObj.height() / 2 - zzimCompDivObj.height() / 2;
				var left = bodyObj.width() / 2 - zzimCompDivObj.width() / 2;

				// 일반 상품일 경우
				if(showModelno=="0") {
					zzimPriceStr = "<b>"+showPriceStr+"</b>원";
				} else {
					if(vTlcflag || vCashflag){
						zzimPriceStr = "<b>"+showPriceStr+"</b>원";
					}else{
						zzimPriceStr = "최저가<b>"+showPriceStr+"</b>원";						
					}
				}

				zzimCompDivObj.find(".zzimProdImage").attr("src", showImageUrl);
				if(mb=="mb") zzimCompDivObj.find(".m_txt p").html("<p>선택하신 상품 찜이 완료 되었습니다.<br /> 에누리 <b>모바일에서 찜 상품을 확인</b>해보세요.</p>");
				else zzimCompDivObj.find(".m_txt p").html("<p>선택하신 상품<br />찜이 완료 되었습니다.</p>");
				zzimCompDivObj.find(".zzim_price").html(zzimPriceStr);

				zzimCompDivObj.css("top", top+"px");
				zzimCompDivObj.css("left", left+"px");
				zzimCompDivObj.show();
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

function setMobileShoppingRecDiv(layerflag) {
	// 모바일 쇼핑 혜택 레이어 보여주기
	if(typeof(layerflag)!='undefined' && layerflag=="emoney_area"){
		var mallpriceObj = $("#emoney_area");
		mallpriceObj.find(".btn_phone").unbind();
		mallpriceObj.find(".btn_phone").click(function () {
			mobileShoppingRecDivShow(this, "emoney");
		});
	}else{
		insertLog(14458);
		var mallpriceObj = $(".mallprice_zone");
		mallpriceObj.find(".btn_emoneysave").unbind();
		mallpriceObj.find(".btn_emoneysave").click(function () {
			$("#mobileShoppingRecDiv").show();
		});
		
		mallpriceObj.find(".won_w").unbind();
		mallpriceObj.find(".won_w").click(function () {
			mobileShoppingRecDivShow(this);
		});
	}
	

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

	});
	mobileShoppingRecDivObj.find(".btn_more_benefit").unbind();
	mobileShoppingRecDivObj.find(".btn_more_benefit").click(function() {
		goLocatonNewWindow("http://www.enuri.com/eventPlanZone/jsp/shoppingBenefit.jsp");
	});
}

function mobileShoppingRecDivShow(thisObject, type) {
	if(typeof(type)=='undefined'){
		type = "";
	}
	var mobileShoppingRecDivObj = $("#mobileShoppingRecDiv");

	// 토글
	if(mobileShoppingRecDivObj.css("display")!="none") {
		mobileShoppingRecDivHide();

		return;
	}

	var thisObj = $(thisObject);

	var top = thisObj.offset().top + thisObj.height() + 3;
	//var left = thisObj.offset().left - mobileShoppingRecDivObj.width() + thisObj.width();
	var left = thisObj.offset().left;
	var margin_left=0;
	if(type=="emoney") {
		left = $('.emoney_area .proname .btn_phone').offset().left+"px";
		top += 7;
	}else{
		if(thisObj.parents(".rightside").length > 0 || thisObj.parents(".tbrow").length > 0){
			//오른쪽
			margin_left = 90+"px";
		}else{
			//왼쪽
			margin_left = -400+"px";
		}
		left = "50%";
	}
	mobileShoppingRecDivObj.css("top", top+"px");
	mobileShoppingRecDivObj.css("left", left);
	mobileShoppingRecDivObj.css("margin-left", margin_left);
	mobileShoppingRecDivObj.show();
	
	setQrCodeImg();
}

function mobileShoppingRecDivHide() {
	var mobileShoppingRecDivObj = $("#mobileShoppingRecDiv");

	mobileShoppingRecDivObj.hide();
}

///////////////////////////////////////////////////// 모바일 쇼핑 혜택 스크립트 끝 /////////////////////////////////////////////////////


///////////////////////////////////////////////////// 모바일 최저가,전용 레이어 스크립트 시작 /////////////////////////////////////////////////////

function setMobileSendProdDivDiv(layerflag) {
	// 모바일 전용상품 및 모바일 최저가 상품 레이어 보여주기
	if(typeof(layerflag)!='undefined' && layerflag=="top"){
		var basicDivObj = $("#basic");
		basicDivObj.find(".mobile").unbind();
		basicDivObj.find(".mobile").click(function () {
			var type = 1; //모바일최저가
			insertLog(14456);
			mobileSendProdDivShow(type, this);
		});
		
		basicDivObj.find("#topprice").click(function () {
			var type = 1; //모바일최저가
			insertLog(14456);
			mobileSendProdDivShow(type, this);
		});
	}else if(typeof(layerflag)!='undefined' && layerflag=="mblowest"){
		var compareDivObj = $(".mblow");
		compareDivObj.find("#mblow").unbind();
		compareDivObj.find("#mblow").click(function () {
			var type = 1; //모바일최저가
			insertLog(14456);
			mobileSendProdDivShow(type, this);
		});
	}else if(typeof(layerflag)!='undefined' && layerflag=="onmobile"){
		var basicDivObj = $("#basic");
		basicDivObj.find(".mobile").unbind();
		basicDivObj.find(".mobile").click(function () {
			var type = 2; //모바일전용
			insertLog(14481);
			mobileSendProdDivShow(type, this);
		});
	}else{
		var emoneyAreaDivObj = $("#emoney_area");
		emoneyAreaDivObj.find(".onlymobile").unbind();
		emoneyAreaDivObj.find(".onlymobile").click(function () {
			var type = 2; //모바일전용
			insertLog(14457);
			mobileSendProdDivShow(type, this);
		});
	}
	

	var mobileSendProdDivObj = $("#mobileSendProdDiv");

	// 닫기 이벤트
	mobileSendProdDivObj.find(".close").unbind();
	mobileSendProdDivObj.find(".close").click(function() {
		mobileSendProdDivHide();
	});

	// 핸드폰 전송 하단 레이어 열기
	mobileSendProdDivObj.find(".smsp").unbind();
	mobileSendProdDivObj.find(".smsp").click(function() {
		mobileSendProdDivObj.find(".boxly_b").toggle();
	});

	// 찜하기 체크박스
	mobileSendProdDivObj.find(".mobileSendCheck").unbind();
	mobileSendProdDivObj.find(".mobileSendCheck").click(function() {
		insertZzimProc();
	});

	// 에누리앱 설치
	mobileSendProdDivObj.find(".app").unbind();
	mobileSendProdDivObj.find(".app").click(function() {
		goLocatonNewWindow("/common/jsp/App_Landing.jsp");
	});

	// 핸드폰 번호 전송
	mobileSendProdDivObj.find(".btn_send").unbind();
	mobileSendProdDivObj.find(".btn_send").click(function() {
		var phoneTxt = mobileSendProdDivObj.find(".phoneNum").val();
		var listItemObj = $("#modelno_"+mobileSendSelModelno);

		if(listItemObj.length<1) {
			if($("modelnoGroup_"+mobileSendSelModelno).length>0) {
				listItemObj = $("modelnoGroup_"+mobileSendSelModelno).parents("prodItem");
			}
		}

		var title = szModelNm;

		sendDetailSms(phoneTxt, "detail", title)

		mobileSendProdDivObj.find(".phoneNum").val("");
	});
}

// SMS보내가
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

	rurl = encodeURIComponent("http://m.enuri.com/mobilefirst/detail.jsp?_qr=y&modelno="+mobileSendSelModelno+"&hoticon=-1");

	if(rurl!="") {
		rurl = rurl.replace(/\?/ig, "--***--");
		rurl = rurl.replace(/\&/ig, "--**--");
		document.getElementById("hFrame").src = "/common/jsp/Ajax_ListHeader_Sms_Proc.jsp?part="+part+"&rurl="+rurl+"&phoneno="+myphone+"&title="+encodeURIComponent(title);
	} else {
		alert("주소를 읽어오지 못했습니다.");
	}
}

// type=1 : 모바일 최저가 상품
// type=2 : 모바일 전용 상품
var mobileSendSelModelno = "";
function mobileSendProdDivShow(type, thisObject, modelno, price) {
	if(typeof(price)=='undefined') price = 0;
	var mobileSendProdDivObj = $("#mobileSendProdDiv");

	// 토글
	if(mobileSendProdDivObj.css("display")!="none") {
		mobileSendProdDivHide();

		return;
	}

	var thisObj = $(thisObject);
	var top = thisObj.offset().top + thisObj.height() + 3;
	var left = thisObj.offset().left - mobileSendProdDivObj.width() + thisObj.width();

	if(left<mobileSendProdDivObj.width()) left = thisObj.offset().left;

	if(type=="1") {
		if(price>0){
			mobileSendProdDivObj.find("h4").html("모바일에서구매 시 더 저렴합니다.");
			mobileSendProdDivObj.find("#mb_info").html("<p>찜/핸드폰 전송 버튼을 클릭 또는 QR코드를 스캔하여 모바일 할인가를 확인하세요</p>");
			mobileSendProdDivObj.find("#mb_price").html("<a class=\"icon dismobilepr\"><em>모바일특가</em></a><strong>"+numComma(price)+"원</strong>");
			mobileSendProdDivObj.find("#mb_price").show();
		}else{
			mobileSendProdDivObj.find("h4").html("모바일 최저가 상품");
			mobileSendProdDivObj.find("#mb_info").html("본 상품은 <b>모바일로 구매 시 더 저렴</b>합니다.<br />찜/핸드폰 전송 또는 QR코드를 스캔하여<br />모바일에서 최저가를 확인하세요.");
			mobileSendProdDivObj.find("#mb_price").hide();
		}
	}
	if(type=="2") {
		mobileSendProdDivObj.find("h4").html("모바일 전용 상품");
		mobileSendProdDivObj.find("#mb_info").html("모바일에서만 구매할 수 있는 모바일 전용<br />상품 입니다. 찜/핸드폰 전송 또는 QR코드를<br />스캔하여 모바일에서 최저가를 확인하세요.");
		mobileSendProdDivObj.find("#mb_price").hide();
	}

	left = left + 50;
	
	mobileSendProdDivObj.css("top", top+"px");
	mobileSendProdDivObj.css("left", left+"px");
	mobileSendProdDivObj.css("z-index", "10001");
	mobileSendProdDivObj.show();
	
	if(typeof(modelno)=='undefined') mobileSendSelModelno = gModelno;
	else mobileSendSelModelno = modelno;

	// 찜 했을 경우 체크 박스의 체크를 표시함
	// 여기 확인 해야 함.
	if(bZzim == "true") {
		mobileSendProdDivObj.find(".mobileSendCheck").attr("checked", "checked");
	}
	// 클릭한 모델의 qr코드 생성
	setQrCodeImg();
}

// 모델에서 휴대폰 아이콘 클릭시 qr코드를 생성함
var qrCodeResetTryCnt = 0;
function setQrCodeImg(type) {
	if(typeof(type)=='undefined') type = 0;
	var newDate = new Date();
	var qrName = newDate.getTime();
	var mobileSendProdDivObj = $("#mobileSendProdDiv");
	if(type==1) mobileSendProdDivObj = $("#shoppingSendLayerDiv");
	var qrImgSrc = mobileSendProdDivObj.find(".boxly .qrcode img").attr("src");
	
	if(mobileSendSelModelno=="") mobileSendSelModelno = gModelno;
	if(qrImgSrc=="") {
		mobileSendProdDivObj.find(".boxly .qrcode img").css("visibility","hidden");
		mobileSendProdDivObj.find(".boxly .qrcode img").attr("src","/view/qrcode/qr_model_"+mobileSendSelModelno+".png?v="+(new Date()).getTime());
	} 
	mobileSendProdDivObj.find(".boxly .qrcode img").error(function(){
		makeQr(type);
    });
}

function makeQr(type){
	var mobileSendProdDivObj = $("#mobileSendProdDiv");
	if(type==1) mobileSendProdDivObj = $("#shoppingSendLayerDiv");
	var newDate = new Date();
	var qrName = newDate.getTime();
	if(qrCodeResetTryCnt<5) { //5회까지만 생성 재시도
		qrCodeResetTryCnt++;
		function showQr() {
			setTimeout(function() {
				mobileSendProdDivObj.find(".boxly .qrcode img").attr("src","/view/qrcode/qr_model_"+mobileSendSelModelno+".png?v="+qrName);
				mobileSendProdDivObj.find(".boxly .qrcode img").error(function(){
					makeQr();
			    });
			},1000);
		}
		var aUrl = "/view/make_qr2.jsp";
		var param = "";
		param += "&url="+encodeURIComponent("http://m.enuri.com/mobilefirst/detail.jsp?_qr=y&modelno="+mobileSendSelModelno+"&hoticon=-1");
		param = param + "&t=qr_model_"+mobileSendSelModelno;
		//console.log(param);
		$.ajax({
			type : "get", 
			url : aUrl, 
			async: true, 
			data : param, 
			dataType : "json", 
			success: function(json) {
				showQr();
			},
			error: function (xhr, ajaxOptions, thrownError) {
				//alert(xhr.status);
				//alert(thrownError);
			}
		});
	} else {
		return;
	}
}

function mobileSendProdDivHide() {
	var mobileSendProdDivObj = $("#mobileSendProdDiv");

	mobileSendProdDivObj.hide();

	mobileSendSelModelno = "";

	mobileSendProdDivObj.find(".boxly .qrcode img").attr("src", "");
}

///////////////////////////////////////////////////// 모바일 최저가,전용 레이어 스크립트 끝 /////////////////////////////////////////////////////


///////////////////////////////////////////////////// 공유 레이어 스크립트 시작 /////////////////////////////////////////////////////

function setShareLayerDiv() {
	// 모바일 전용상품 및 모바일 최저가 상품 레이어 보여주기
	insertLog(14467);

	var right_unitsObj = $(".thumbopt");
	right_unitsObj.find(".share").unbind();
	right_unitsObj.find(".share").click(function () {
		shareLayerDivShow(this);
	});

	/*
	var right_unitsObj = $(".right_units");
	right_unitsObj.find(".shareDivShow").unbind();
	right_unitsObj.find(".share").click(function () {
		shareLayerDivShow(this);
	});
*/
	var shareLayerDivObj = $("#shareLayerDiv");

	shareLayerDivObj.find(".close").unbind();
	shareLayerDivObj.find(".close").click(function() {
		shareLayerDivHide();
	});

	// URL복사
	shareLayerDivObj.find(".url").unbind();
	shareLayerDivObj.find(".url").click(function() {
		insertLog(14468);
		copy_URL("http://www.enuri.com/p/"+shareSelModelno, "goods");
	});

	// 메일 보내기
	shareLayerDivObj.find(".mail").unbind();
	shareLayerDivObj.find(".mail").click(function() {
		insertLog(14469);
		mailSendLayerDivShow(this);
	});

	// 페이스북
	shareLayerDivObj.find(".fb").unbind();
	shareLayerDivObj.find(".fb").click(function() {
		insertLog(14470);
		goSnsLinkVIP(2);
	});

	// 트위터
	shareLayerDivObj.find(".tw").unbind();
	shareLayerDivObj.find(".tw").click(function() {
		insertLog(14471);
		goSnsLinkVIP(1);
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

	var top = $('.thumbopt__list').offset().top + 35; 
	var left = ($('.thumbopt__list').offset().left+$('.thumbopt__list').width())-(shareLayerDivObj.width()+100);

	// 공유 버튼 마크업 위치 변경으로 인한 주석 처리
	//var top = $('.proinfo_area').offset().top - 18;//thisObj.offset().top + thisObj.height() + 3; 
	//var left = ($('.proinfo_area').offset().left+$('.proinfo_area').width())-(shareLayerDivObj.width()+2);//thisObj.offset().left - shareLayerDivObj.width() + thisObj.width();

	shareLayerDivObj.css("top", top+"px");
	shareLayerDivObj.css("left", left+"px");
	shareLayerDivObj.show();

	shareSelModelno = gModelno;
}

function shareLayerDivHide() {
	var shareLayerDivObj = $("#shareLayerDiv");

	shareLayerDivObj.hide();
	mailSendLayerDivHide();

	shareSelModelno = "";
}

function copy_URL(address) {
	if(window.clipboardData) {
		window.clipboardData.setData("Text", address);
		copy_URL2();

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
			copy_URL2();
		} catch(e) {
			alert("signed.applets.codebase_principal_support를 설정해주세요!");
		}
	} else {
		alert("해당 브라우저에서는 지원하지 않습니다.");
	}

	return false;
}

function copy_URL2() {
	alert("해당 상품의 URL이 복사되었습니다.\n원하는 곳에 CTRL + V 를 해주세요!");
}

//type=1 : 트위터, type=2 : 미투데이, type=3 : 페이스북
function goSnsLinkVIP(type) {
	var url = "http://www.enuri.com/p/"+shareSelModelno;
	var content = "";

	content = szModelNm;

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
		mailSendLayerDivObj.find(".mail_detail").toggle();
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
	var left = thisObj.offset().left - mailSendLayerDivObj.width() + thisObj.width() + 20;

	mailSendLayerDivObj.css("top", top+"px");
	mailSendLayerDivObj.css("left", left+"px");
	mailSendLayerDivObj.css("z-index", 100);
	
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

	mailSendLayerDivObj.show();
}

function mailSendLayerDivHide() {
	var mailSendLayerDivObj = $("#mailSendLayerDiv");

	mailSendLayerDivObj.hide();
}

var mailPassImg = "";
var mailPassNum = "";
function setPassImage() {
	var dateLong = (new Date()).getTime();
	var url = "/lsv2016/ajax/getMailSendCheckImg_ajax.jsp";
	var param = {
		"random_seq" : random_seq,	
		"dateLong" : dateLong
	}

	$.ajax({
		type : "get", 
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
	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	
	var mailSendLayerDivObj = $("#mailSendLayerDiv");
	var emailadd = $('.to_email').val();
	
	if(emailadd==""){
		alert("메일주소를 입력하세요.");
	    return false
	} else 	if(exptext.test(emailadd) == false){
		//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			
		alert("이 메일형식이 올바르지 않습니다.");
		return false;
	}

	var imgPassText = mailSendLayerDivObj.find(".imgPassText").val();
	var passImgName = mailSendLayerDivObj.find(".passImgName").val();
	var to_email = mailSendLayerDivObj.find(".to_email").val();
	var from_email = mailSendLayerDivObj.find(".from_email").val();
	var subject = mailSendLayerDivObj.find(".subject").val();
	var contents = mailSendLayerDivObj.find(".contents").val();

	var url = "/lsv2016/ajax/sendRecommendmailmulti_ajax.jsp";
	var param = {
		"random_seq" : random_seq,
		"imgPassText" : imgPassText, 
		"passImgName" : passImgName, 
		"to_email" : to_email, 
		"from_email" : from_email, 
		"subject" : subject, 
		"contents" : contents, 
		"modelno" : shareSelModelno
	}

	$.ajax({
		type : "get", 
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

///////////////////////////////////////////////////// 최저가 쇼핑도우미 앱 시작 /////////////////////////////////////////////////////
function shoppingSendLayerDivShow(thisObject) {
	var shoppingSendLayerDivObj = $("#shoppingSendLayerDiv");

	// 토글
	if(shoppingSendLayerDivObj.css("display")!="none") {
		shoppingSendLayerDivObjHide();

		return;
	}
	shoppingSendLayerDivObj.find(".boxly_b").hide();
	
	var thisObj = $(thisObject);
	mobileSendSelModelno = gModelno;
	
	// 클릭한 모델의 qr코드 생성
	setQrCodeImg(1);

	var top = $('.proinfo_area').offset().top - 18;//thisObj.offset().top + thisObj.height() + 3;
	var left =($('.proinfo_area').offset().left+$('.proinfo_area').width())-(shoppingSendLayerDivObj.width()+2); // thisObj.offset().left - shoppingSendLayerDivObj.width() + thisObj.width();

	shoppingSendLayerDivObj.css("top", top+"px");
	shoppingSendLayerDivObj.css("left", left+"px");
	shoppingSendLayerDivObj.show();
}

function shoppingSendLayerDivObjHide() {
	var shoppingSendLayerDivObj = $("#shoppingSendLayerDiv");

	shoppingSendLayerDivObj.hide();

}

function setShoppingSendLayerDiv() {
	// 모바일 전용상품 및 모바일 최저가 상품 레이어 보여주기
	/*var right_unitsObj = $(".right_units");
	right_unitsObj.find(".qr").unbind();
	right_unitsObj.find(".qr").click(function () {
		insertLog(14472);
		shoppingSendLayerDivShow(this);
	});*/

	var shoppingSendLayerDivObj = $("#shoppingSendLayerDiv");

	// 닫기 이벤트
	shoppingSendLayerDivObj.find(".close").unbind();
	shoppingSendLayerDivObj.find(".close").click(function() {
		shoppingSendLayerDivObjHide();
	});

	// 핸드폰 전송 하단 레이어 열기
	shoppingSendLayerDivObj.find(".smsp").unbind();
	shoppingSendLayerDivObj.find(".smsp").click(function() {
		shoppingSendLayerDivObj.find(".boxly_b").toggle();
	});


	// 에누리앱 설치
	shoppingSendLayerDivObj.find(".app").unbind();
	shoppingSendLayerDivObj.find(".app").click(function() {
		insertLog(14474);
		goLocatonNewWindow("/common/jsp/App_Landing.jsp");
	});

	// 핸드폰 번호 전송
	shoppingSendLayerDivObj.find(".btn_send").unbind();
	shoppingSendLayerDivObj.find(".btn_send").click(function() {
		insertLog(14473);
		var phoneTxt = shoppingSendLayerDivObj.find(".phoneNum").val();

		var title = szModelNm;

		sendDetailSms(phoneTxt, "detail", title)

		shoppingSendLayerDivObj.find(".phoneNum").val("");
	});
}

///////////////////////////////////////////////////// 최저가 쇼핑도우미 앱 끝 /////////////////////////////////////////////////////

/////////////////////////////////////////////////////G9 이동 ///////////////////////////////////////////////////////////////////
function setG9Div() {
	var mallpriceObj = $(".mallprice_zone");
	mallpriceObj.find(".btn_g9move").unbind();
	mallpriceObj.find(".btn_g9move").click(function () {
		G9DivShow(this);
	});

	var G9DivObj = $("#G9Div");

	G9DivObj.find(".btnclose").unbind();
	G9DivObj.find(".btnclose").click(function() {
		G9DivHide();
	});
}

function G9DivShow(thisObject) {
	var G9DivObj = $("#G9Div");

	// 토글
	if(G9DivObj.css("display")!="none") {
		G9DivHide();

		return;
	}

	var thisObj = $(thisObject);

	var top = thisObj.offset().top - G9DivObj.height();
	var left = thisObj.offset().left;
	
	G9DivObj.css("top", top+"px");
	G9DivObj.css("left", left+"px");
	G9DivObj.show();
}

function G9DivHide() {
	var G9DivObj = $("#G9Div");

	G9DivObj.hide();
}

/////////////////////////////////////////////////////G9 이동 끝///////////////////////////////////////////////////////////////////
