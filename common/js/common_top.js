/**********************Common_Top에 사용***************************/
/*window.name ="ENURI.COM";*/
var RB_BUTTONS_HEIGHT = 81+190;
var RB_SEARCH_BTN_H = 0;
var RB_TOP = 509;
//IE6.0백그라운드 오류수정
var rec_zzim = "";
var accNotice = "";
try {document.execCommand('BackgroundImageCache', false, true);} catch(e) {}

var $simpleViewObj;
var asideObj;

function init(){
	$simpleViewObj = document.getElementById("simpleView");
	asideObj = document.getElementById("aside");

	if (document.getElementById("aside")){
		if (document.getElementById("aside").style.display == "none"){
			document.getElementById("aside").style.display = "";
			//setAsideLeftPosition();
		}
	}
	if (document.getElementById("favoritePoB")){
		if (getVistaFlag()){
			document.getElementById("favoritePoB").style.display = "none";
			document.getElementById("favoritePoS").style.display = "";

			document.getElementById("favoritePoS").style.left = (document.getElementById("wrap").offsetWidth/2 - 384/2)+"px"
			document.getElementById("favoritePoS").style.top = 	(getBodyClientHeight()/2 - 150/2) +"px";
		}else{
			document.getElementById("favoritePoB").style.display = "";
			document.getElementById("favoritePoS").style.display = "none";

			document.getElementById("favoritePoB").style.left = (document.getElementById("wrap").offsetWidth/2 - 384/2)+"px"
			document.getElementById("favoritePoB").style.top = 	(getBodyClientHeight()/2 - 182/2) +"px";
		}
	}
	setTimeout(function(){
		showRrightLayer();
	},100);
	setTimeout(function(){
		if (document.getElementById("rb_buttons")){
			if (document.getElementById("rb_buttons").style.display == "none"){
				showRrightLayer();
			}
		}
	},200);
	if (BrowserDetect.OS == "iPad" && BrowserDetect.browser == "Safari"){
		if ($("enuriMenuFrame")){
			$("enuriMenuFrame").width = $("wrap").offsetWidth+"px";
		}
		if ($("enuriMenuFrame")){
			if (document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame")){
				document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").width = $("wrap").offsetWidth+"px";
			}
		}
		if ($("searchListFrame")){
			$("searchListFrame").width = $("wrap").offsetWidth+"px";
		}
	}
	if (document.getElementById("frmMainLogin")){
		if (typeof(showLoginStatus) == "function"){
			document.getElementById("frmMainLogin").onload = function(){
				showLoginStatus();
			}
		}
	}

	var sv=document.createElement('script');
	sv.setAttribute('type','text/javascript');
	sv.setAttribute('id','simpleview');
	sv.setAttribute('src',''+'/common/js/simpleview.js?'+(new Date()).getMilliseconds+'');
	document.body.appendChild(sv);
}
function showRrightLayer(){

	if (document.getElementById("rb_buttons")){
		document.getElementById("rb_buttons").style.display = "";
		if (document.getElementById("catalogListDiv")){
			document.getElementById("catalogListDiv").style.visibility = "visible";
		}
		//setAsideLeftPosition();
		if(!(BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6)) {
			if (BrowserDetect.OS == "iPad" && BrowserDetect.browser == "Safari"){
				document.getElementById("rb_buttons").style.top = setRbButtonsTopPositionIPad();
				document.getElementById("rb_recent_zzim").style.top = setRecentZzimPositionIPad();
			}else{
				document.getElementById("rb_buttons").style.top = setRbButtonsTopPosition();
				if (document.getElementById("catalogListDiv")){
					document.getElementById("catalogListDiv").style.visibility = "visible";
					document.getElementById("catalogListDiv").style.top  = (getBodyClientHeight() - RB_BUTTONS_HEIGHT - 215) +"px";
				}
				if (document.getElementById("rb_recent_zzim")){
					document.getElementById("rb_recent_zzim").style.top  = (getBodyClientHeight() -  getRbTop()) +"px";
				}
			}
		}
	}
	if (document.getElementById("cate_log")){
		document.getElementById("cate_log").style.left = document.getElementById("rb_buttons").offsetLeft+"px";
		document.getElementById("cate_log").style.top = (document.getElementById("rb_buttons").offsetTop - 60)+"px";
		document.getElementById("cate_log").style.display = "";
	}

}
window.onresize = function(){
	resizeAll();
}
function resizeAll(){
	setTimeout(function(){

		if(!(BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6)) {
			if (BrowserDetect.OS == "iPad" && BrowserDetect.browser == "Safari"){
				document.getElementById("rb_buttons").style.top = setRbButtonsTopPositionIPad();
				document.getElementById("rb_recent_zzim").style.top = setRecentZzimPositionIPad();
			}else{
				setTimeout(function(){
					if(document.getElementById("aside")){
						document.getElementById("aside").style.top = setAsideTopPosition();
					}

					if (document.getElementById("rb_recent_zzim")){
						if (document.getElementById("rb_recent_zzim").style.display == "none"){
							document.getElementById("rb_buttons").style.display = "";
						}
					}
					if(document.getElementById("rb_buttons")){
						document.getElementById("rb_buttons").style.top = setRbButtonsTopPosition();
					}
					if (document.getElementById("catalogListDiv")){
						document.getElementById("catalogListDiv").style.visibility = "visible";
						document.getElementById("catalogListDiv").style.top  = (getBodyClientHeight() - RB_BUTTONS_HEIGHT - 215) +"px";
					}
					if (document.getElementById("rb_recent_zzim")){
						document.getElementById("rb_recent_zzim").style.top  = (getBodyClientHeight() - getRbTop()) +"px";
					}
					if(document.getElementById("simpleView")){
						if (document.getElementById("simpleView").className != "_hideClass"){
							document.getElementById("simpleView").style.top = setSimpleViewTopPosition();
						}
					}
					/*
					if (typeof (SimpleView) != "undefined"){
						if (document.getElementById("simpleView").className != "_hideClass"){
							var simpleViewObj = new SimpleView();
							simpleViewObj.setLeft();
							simpleViewObj.setHeight();
							if (document.getElementById("rb_recent_zzim")){
								if (document.getElementById("rb_recent_zzim").style.display != "none"){
									document.getElementById("rb_recent_zzim").style.left = ($(".enuriBi").width()+5-getBodyScrollLeft()) + "px"
								}
							}
						}
					}
					*/
				},100);
			}
		}
	},100);
	if(document.URL.indexOf("/tour/index.jsp") < 0 ){
		if(document.URL.indexOf("/view/fusion/Fusion.jsp") < 0 || document.URL.indexOf("/view/fusion/Fusion_Masterpiece.jsp") < 0 || document.URL.indexOf("/tour/index.jsp") < 0
				|| document.URL.indexOf("/sdul/bid/Bid_List.jsp") < 0 || document.URL.indexOf("/view/Listbrand.jsp") < 0){
			if (document.getElementById("enuriMenuFrame")){
				document.getElementById("enuriMenuFrame").contentWindow.setPositionCategory();
				document.getElementById("enuriMenuFrame").contentWindow.syncHeightListFrame();
			}
		}
	}
	try{
		if (document.URL.indexOf("/search/Searchlist.jsp") >= 0){
			if (document.getElementById("searchListFrame").contentWindow){
				document.getElementById("searchListFrame").contentWindow.showSpreadButton();
			}
		}
	}catch(e){

	}
	// IE6, IE7용 회원 로그인

	try {
		joinLayerResizeSet();
	} catch(e) {}
}
var _varLeftPos = 0;

function fnSetPositionScrollArrow(){
	try{
	if(document.getElementById("frmSimpleView"))
		document.getElementById("frmSimpleView").contentWindow.scrollArrowPositionResetting();
	}catch(err){

	}
}

window.onscroll = function(){
	//try{
		/*IE6에서는 css에서 expression으로 위치 설정한다*/
		if(!(BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6)) {
			if (BrowserDetect.OS == "iPad" && BrowserDetect.browser == "Safari"){
				document.getElementById("aside").style.top = setAsideTopPositionIE6();
				document.getElementById("rb_buttons").style.top = setRbButtonsTopPositionIPad();
				document.getElementById("rb_recent_zzim").style.top = setRecentZzimPositionIPad();
			}else{
				if(asideObj){
					asideObj.style.top = setAsideTopPosition();
				}

				if($simpleViewObj){
					if($simpleViewObj.style.display != "none"){
						var headerOffset = $("#utilMenu").offset().top+35;
						var bodyTop = getBodyScrollTop();
						var topOffset = bodyTop < headerOffset ? (headerOffset - bodyTop) : 0;

						$simpleViewObj.style.top = topOffset + "px";
					}
				}


				if (typeof (SimpleView) != "undefined"){
					if (document.getElementById("simpleView")){
						if (document.getElementById("simpleView").className != "_hideClass"){
							var simpleViewObj = new SimpleView();
							simpleViewObj.setLeft();
							simpleViewObj.setHeight();
							fnSetPositionScrollArrow();
						}
					}
				}
				if (getBodyScrollLeft() > 0 || _varLeftPos != getBodyScrollLeft()){
					if (_varLeftPos != getBodyScrollLeft()){
						setAsideLeftPosition();
					}
					_varLeftPos = getBodyScrollLeft();
				}
/*					var showRbButtons = true;
					if (document.getElementById("rb_recent_zzim")){
						if ( document.getElementById("rb_recent_zzim").style.display != "none" ){
							showRbButtons = false;
						}
					}
					if(showRbButtons){
						if(document.getElementById("rb_buttons")){
							document.getElementById("rb_buttons").style.display = "";
							document.getElementById("rb_buttons").style.top = setRbButtonsTopPosition();
						}
					}
					if (document.getElementById("catalogListDiv")){
						document.getElementById("catalogListDiv").style.visibility = "visible";
						document.getElementById("catalogListDiv").style.top  = (getBodyClientHeight() - RB_BUTTONS_HEIGHT - 215) +"px";
					}
					if (document.getElementById("rb_recent_zzim")){
						document.getElementById("rb_recent_zzim").style.top  = (getBodyClientHeight() - getRbTop()) +"px";
					}
					if(document.getElementById("simpleView")){
						if (document.getElementById("simpleView").style.display != "none"){
							document.getElementById("simpleView").style.top = setSimpleViewTopPosition();
						}
					}*/
			}
		}

		//if (getBodyScrollLeft() > 0 ){
/*			setTimeout(function(){
				setAsideLeftPosition('scroll');
			},100);*/
		//}
/*		if (getBodyScrollHeight() == ( getBodyScrollTop() +  getBodyClientHeight())){
			if (document.URL.indexOf("/view/List.jsp") >= 0 || document.URL.indexOf("/view/Listmp3.jsp") >= 0  || document.URL.indexOf("/view/Listhandphone.jsp") >= 0 || document.URL.indexOf("/view/Listprinter.jsp") >= 0 ){
				document.getElementById("enuriMenuFrame").contentWindow.syncHeightListFrame()
			}else if(document.URL.indexOf("/search/Searchlist.jsp") >= 0){
				syncHeightListFrame();
			}
		}*/
/*		if (typeof (SimpleView) != "undefined"){
			var simpleViewObj = new SimpleView();
			simpleViewObj.setLeft();
			simpleViewObj.setHeight();
		}*/
	//}catch(e){
/*		setTimeout(function(){
			setAsideLeftPosition('scroll');
		},100);*/

	//}
}
/*IE6/에서 aside top 위치 설정*/
function setAsideTopPositionIE6(){
	var varTop = 0;
	if (document.getElementById("aside")){
		if (document.getElementById("aside").offsetHeight > (getBodyClientHeight() - RB_BUTTONS_HEIGHT - getCatalogDownHeight() + getBodyScrollTop())){
			varTop = document.getElementById("aside").offsetTop;
		}else{
			if ((getBodyClientHeight() - RB_BUTTONS_HEIGHT - getCatalogDownHeight()) > document.getElementById("aside").offsetHeight){
				varTop = getBodyScrollTop();
			}else{
				varTop = getBodyScrollTop() - (document.getElementById("aside").offsetHeight - (getBodyClientHeight() - RB_BUTTONS_HEIGHT - getCatalogDownHeight()))
			}
		}
	}

	if(getBodyScrollTop()==0) varTop = 0;

	return varTop + "px";
}
/*IE6제외 나머지 브라우저에서  aside top 위치 설정*/
function setAsideTopPosition(){
	var varTop = 0;
	var varUtilHeight = 30;

	if(asideObj){
		//오른쪽 윙배너 스크롤 시 고정 높이 이상일 경우에만 배너 스크롤 되도록 함.
		if (getBodyScrollTop() > 1620 || getBodyScrollTop() == 0) {

			if (asideObj.offsetHeight > ((getBodyClientHeight() - RB_BUTTONS_HEIGHT - getCatalogDownHeight() ) + getBodyScrollTop())){
				varTop = -getBodyScrollTop();
			}else{
				if (asideObj.offsetHeight > (getBodyClientHeight() - RB_BUTTONS_HEIGHT - getCatalogDownHeight())){
					varTop = (getBodyClientHeight() - RB_BUTTONS_HEIGHT - getCatalogDownHeight()) - asideObj.offsetHeight;
				}else{
					if (asideObj.offsetTop < 0){
						if (-asideObj.offsetTop > getBodyScrollTop() ){
							varTop = getBodyScrollTop() + asideObj.offsetTop;
						}
					}else{
						varTop = varUtilHeight < getBodyScrollTop() ? "0" : varUtilHeight - getBodyScrollTop();
					}
				}
			}

		}
	}

	if (varUtilHeight > getBodyScrollTop()){
		varTop = varUtilHeight - getBodyScrollTop();

		if(jQuery("#topBannerNew"))
			if(jQuery("#topBannerNew").css("display") != "none")
				varTop += jQuery("#topBannerNew").height();
	}

	return varTop + "px";
}
function setSimpleViewTopPosition(){
	var varTop = 0;
	var varUtilHeight = 36;
	if (varUtilHeight > getBodyScrollTop()){
		varTop = varUtilHeight - getBodyScrollTop();

		if(jQuery("#topBannerNew"))
			if(jQuery("#topBannerNew").css("display") != "none")
				varTop += jQuery("#topBannerNew").height();
	}

	return varTop + "px";
}
/* aside left 위치 설정*/
function setAsideLeftPosition(isresize){
	var varLeftPos = 0;
	if (screen.width >= 1024 && screen.width < 1280){
		varLeftPos = 856;
	}else{
		varLeftPos = 1006;
	}
	if(jQuery(".enuriBi").length){
		varLeftPos = $(".enuriBi").width() + 6;
		if(!(BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6) && !(BrowserDetect.OS == "iPad" && BrowserDetect.browser == "Safari")) {
			varLeftPos = varLeftPos - getBodyScrollLeft();
		}
	}
	if (document.getElementById("div_map_detail_info")){
		document.getElementById("div_map_detail_info").style.left = varLeftPos-70 + getBodyScrollLeft() + "px"
	}
	if(document.getElementById("aside")){
		document.getElementById("aside").style.left = varLeftPos + "px"
	}
	if (document.getElementById("rb_buttons")){
		document.getElementById("rb_buttons").style.left = (varLeftPos) + "px";
	}
	if (document.getElementById("catalogListDiv")){
		document.getElementById("catalogListDiv").style.left = (varLeftPos) + "px"
	}
	if (document.getElementById("rb_recent_zzim")){
		document.getElementById("rb_recent_zzim").style.left = (varLeftPos) + "px"
	}
	if (document.getElementById("cate_log")){
		document.getElementById("cate_log").style.left = (varLeftPos-2) + "px"
	}
	if (document.getElementById("checklayer")){
		document.getElementById("checklayer").style.left = (varLeftPos-530) + "px"
	}
	if (document.getElementById("Air_GuideLayer")){
		document.getElementById("Air_GuideLayer").style.left = (varLeftPos-410) + "px"
	}
	if (document.getElementById("Fan_GuideLayer")){
		document.getElementById("Fan_GuideLayer").style.left = (varLeftPos-410) + "px"
	}
	if (document.getElementById("Hum_GuideLayer")){
		document.getElementById("Hum_GuideLayer").style.left = (varLeftPos-410) + "px"
	}
	if (document.getElementById("Iron_GuideLayer")){
		document.getElementById("Iron_GuideLayer").style.left = (varLeftPos-410) + "px"
	}
	if (document.getElementById("TV_GuideLayer")){
		document.getElementById("TV_GuideLayer").style.left = (varLeftPos-410) + "px"
	}
	if (document.getElementById("Pad_GuideLayer")){
		document.getElementById("Pad_GuideLayer").style.left = (varLeftPos-410) + "px"
	}
	if (document.getElementById("Heater_GuideLayer")){
		document.getElementById("Heater_GuideLayer").style.left = (varLeftPos-410) + "px"
	}
	if (document.getElementById("Rangei_GuideLayer")){
		document.getElementById("Rangei_GuideLayer").style.left = (varLeftPos-410) + "px"
	}
	if (document.getElementById("Kimchi_GuideLayer")){
		document.getElementById("Kimchi_GuideLayer").style.left = (varLeftPos-410) + "px"
	}
	if (document.getElementById("Refri_GuideLayer")){
		document.getElementById("Refri_GuideLayer").style.left = (varLeftPos-410) + "px"
	}

}
function setRbButtonsTopPosition(){
	var varTop = 0;
	varTop = (getBodyClientHeight() - RB_BUTTONS_HEIGHT);
	return varTop + "px";
}
/*IE6에서 rb_button top 위치 설정*/
function setRbButtonsTopPositionIE6(){
	var varTop = 0;
	varTop = (getBodyScrollTop() + getBodyClientHeight() - RB_BUTTONS_HEIGHT);
	return varTop + "px";
}
function setRbButtonsTopPositionIPad(){
	var varTop = 0;
	varTop = (getBodyScrollTop() + window.innerHeight - RB_BUTTONS_HEIGHT);
	return varTop + "px";
}
function setCatalogDownTopPositionIE6(){
	var varTop = 0;
	varTop = (getBodyScrollTop() + getBodyClientHeight() - RB_BUTTONS_HEIGHT) - 215;
	return varTop + "px";
}
function getCatalogDownHeight(){
	var varHeight = 0;
	if (document.getElementById("catalogListDiv")){
		if (document.getElementById("catalogListDiv").style.display != "none"){
			varHeight = document.getElementById("catalogListDiv").offsetHeight+5;
		}
	}
	return varHeight;
}
function setRecentZzimPositionIE6(){
	var varTop = 0;
	varTop = (getBodyScrollTop() + getBodyClientHeight() -  getRbTop());
	return varTop + "px";
}
function setRecentZzimPositionIPad(){
	var varTop = 0;
	varTop = (getBodyScrollTop() + window.innerHeight -  getRbTop());
	return varTop + "px";
}
/*최근본/찜상품 레이어 관련 스크립트*/
function syncWHSaveGoods(){
	if (document.getElementById("frmSaveGoods").contentWindow.document.location.href != "" && document.getElementById("frmSaveGoods").contentWindow.document.location.href != "about:blank"){
		setTimeout("syncHeightSaveGoods()",500);
		document.getElementById("frmSaveGoods").style.display = "";
		window.scrollTo(0,0);
   	}
}
function syncHeightSaveGoods(){
	document.getElementById("frmSaveGoods").contentWindow.init();
	document.getElementById("frmSaveGoods").height = document.getElementById("frmSaveGoods").contentWindow.document.body.scrollHeight + "px";
}
function hideSaveGoods(){
	document.getElementById("frmSaveGoods").style.display = "none";
}
/*전체 메뉴 관련 스크립트*/
function syncWHAllMenu(){
	if(document.getElementById("frmAllMenu").contentWindow.document.location.href != "" && document.getElementById("frmAllMenu").contentWindow.document.location.href != "about:blank") {
		syncHeightAllMenu();
		document.getElementById("frmAllMenu").style.display = "";
		window.scrollTo(0,0);
	}
}
function syncHeightAllMenu() {
	document.getElementById("frmAllMenu").height = document.getElementById("frmAllMenu").contentWindow.document.body.scrollHeight + "px";
}
function hideAllMenu() {
	document.getElementById("frmAllMenu").style.display = "none";

}
function setWidthWrap(){
	var varWidth = getBodyClientWidth()*0.83;
	return varWidth < 850 ? "850px" : varWidth > 1000 ? "1000px" : (varWidth)+"px"
}
function getBeginnerDic(){
}
function closeAllBeginnerDic(){
	closeBeginnerDic();
	closeBeginnerDic2();
}
function closeBeginnerDic(kb_no){
	if(document.getElementById("div_beginnerFrame")){
		if (document.getElementById("div_beginnerFrame").style.display != "none"){
			if(document.getElementById("div_beginnerFrame")) document.getElementById("div_beginnerFrame").src = "/html/etc/Blank.htm";
			if(document.getElementById("div_beginnerFrame")) document.getElementById("div_beginnerFrame").style.display = "none";
			if(document.getElementById("div_beginnerFrame")) document.getElementById("div_beginnerFrame").style.display = "none";
			if(document.getElementById("div_inconv")) document.getElementById("div_inconv").style.display = "none";
		}
	}
	resizeAll();
}
function closeBeginnerDic2(kb_no){
	if(document.getElementById("div_beginnerFrame2")){
		if (document.getElementById("div_beginnerFrame2").style.display != "none"){
			if(document.getElementById("ifrmBeginnerFrame2")) document.getElementById("ifrmBeginnerFrame2").src = "/html/etc/Blank.htm";
			if(document.getElementById("div_beginnerFrame2")) document.getElementById("div_beginnerFrame2").style.display = "none";
			if(document.getElementById("dicGoogleLayer")) document.getElementById("dicGoogleLayer").style.display = "none";
			if(document.getElementById("div_inconv")) document.getElementById("div_inconv").style.display = "none";
		}
	}
	resizeAll();
}

function CmdGotoBeginnerDic(kb_no,cate){
	var kind = "2";
	var wWidth = 734+30+6;
	insertLogCate(2397);
	insertTermDicTitleLog('link',kb_no);
	if (typeof(kind)=="number" && kind==20) wWidth = wWidth+35;
	var wHeight = screen.availHeight;
 	if(navigator.userAgent.toLowerCase().indexOf("chrome")>0 && navigator.userAgent.toLowerCase().indexOf("edge")>0){ //win10+edge
 		wHeight -= 150;
 	}
	var win = window.open("/purchaseguide/GuideLayer.jsp?kind="+kind+"&cate="+cate+"&kbno="+((typeof(kb_no)=="number")?kb_no:0)+"&btnhits=yes","GuideLayer","width="+wWidth+",height="+wHeight+",left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=yes,resizable=no,menubar=no");
	win.focus();
	closeBeginnerDic(kb_no);
}
function insertTermDicTitleLog(vmode,kb_no){
	var url = "/view/include/IncBeginnerDic_Loginsert.jsp";
	var param = "vmode="+vmode+"&kb_no="+kb_no+"&vtype=LIST";
	commonAjaxRequest(url,param,function(){});
	/*
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param
		}
	);
	*/
}

function searchGuideTitle(guideTitle,kb_no){
	insertLog(3555);
	closeBeginnerDic(kb_no);
	if (top.document.body.scrollTop){
		top.document.body.scrollTop = "0px";
	}else{
		top.document.documentElement.scrollTop = "0px";
	}
	if (document.URL.indexOf("/search/Searchlist.jsp") >= 0 ){
		var varFormObj = document.getElementById("searchListFrame").contentWindow.document.frmList;
		/*
		var varFormElements = Form.getElements(varFormObj);
		for (var i=0;i<varFormElements.length;i++){
			if (varFormElements[i].name != "key" && varFormElements[i].name != "keyword"){
				varFormElements[i].value = "";
			}
		}
		*/
		$(varFormObj).each(function(){
			if ($(this).attr("name") != "key" && $(this).attr("name") != "keyword"){
				$(this).val("");
			}
		});
		document.getElementById("searchListFrame").contentWindow.document.frmList.in_keyword.value = guideTitle;
		document.getElementById("searchListFrame").contentWindow.getCountInResult();
	}else if(document.URL.indexOf("/view/Listnewgoods_New.jsp") >= 0){
		var varFormObj = document.frm_Search_New;
		$(varFormObj).each(function(){
			if ($(this).attr("name") != "key" && $(this).attr("name") != "keyword"){
				$(this).val("");
			}
		});
		document.frm_Search_New.search_keyword.value = guideTitle;
		document.frm_Search_New.submit();
	}else if(document.URL.indexOf("/view/Sslist.jsp") >= 0){
		var varFormObj = document.getElementById("enuriListFrame").contentWindow.document.frmList;
		document.getElementById("enuriListFrame").contentWindow.document.getElementById("keyword").value = document.getElementById("enuriListFrame").contentWindow.document.getElementById("keyword").value + " " + guideTitle;
		document.getElementById("enuriListFrame").contentWindow.setKeywordBackground();
		document.getElementById("enuriListFrame").contentWindow.getCountInResult();
	}else{
		var varFormObj = document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document.frmList;
		//document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.unCheckAllPrice();
		//document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.unCheckAllFactory();
		//document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.unCheckAllCondi();
		/*
		var varFormElements = Form.getElements(varFormObj);
		for (var i=0;i<varFormElements.length;i++){
			if (varFormElements[i].name != "key" && varFormElements[i].name != "cate" &&  varFormElements[i].name != "prtmodelno"){
				varFormElements[i].value = "";
			}
		}
		*/
		document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document.getElementById("keyword").value = document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document.getElementById("keyword").value + " " + guideTitle;
		document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.setKeywordBackground();
		document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.getCountInResult();
		//document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document.frmList.submit();
	}
}
function googleSearch(modelno,modelnm,spec,factory,minprice,islayer,cate){
	/*
	insertLog(2546);
	top.document.getElementById("frmGoogleSearch").src = "";
	if (islayer){
		top.document.getElementById("frmGoogleSearch").src = "/include/IncGoogleSearch_2010.jsp?modelno="+modelno+"&modelnm="+encodeURIComponent(modelnm)+"&spec="+encodeURIComponent(spec)+"&factory="+encodeURIComponent(factory)+"&minprice="+minprice;
	}else{
		if(cate == "0404"){
			top.document.getElementById("frmGoogleSearch").src = "/include/IncGuideGoogleSearch_2010.jsp?cate="+cate;
		}else{
			window.open("/view/OpenGoogleSearch.jsp?"+"modelno="+modelno+"&modelnm="+encodeURIComponent(modelnm)+"&factory="+encodeURIComponent(factory),"","toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
		}
	}
	*/
}
//리뷰보기(구글검색)관련 스크립트
function syncWHGoogleSearch(){
	/*
	try{
		if (document.getElementById("frmGoogleSearch").contentWindow.document.location.href != "" && document.getElementById("frmGoogleSearch").contentWindow.document.location.href != "about:blank"){
			document.getElementById("frmGoogleSearch").style.left = "100px";
			document.getElementById("frmGoogleSearch").style.top = getBodyScrollTop()+20+"px";
			document.getElementById("frmGoogleSearch").style.display = "";
			syncHeightGoogleSearch();
		}
   	}catch(e){
   	}
   	*/
}
function hideGoogleSearch(){
	//document.getElementById("frmGoogleSearch").src = "";
	//document.getElementById("frmGoogleSearch").style.display = "none";
}
function syncHeightGoogleSearch(){
	/*
	if(document.body.scrollHeight <= 460){
		document.getElementById("frmGoogleSearch").height = "435px";
	}
	if(document.body.scrollHeight > 460 && document.body.scrollHeight < 705){
		document.getElementById("frmGoogleSearch").contentWindow.googleInit(document.body.scrollHeight-200);
		document.getElementById("frmGoogleSearch").height = (document.body.scrollHeight-90) + "px";
	}
	if(document.body.scrollHeight >= 705){
		document.getElementById("frmGoogleSearch").contentWindow.googleInit(564);
		if (document.getElementById("frmGoogleSearch").src.indexOf("IncGuideGoogleSearch_2010.jsp") >= 0 && (BrowserDetect.browser == "Explorer" )){
			document.getElementById("frmGoogleSearch").height = "655px";
		}else{
			document.getElementById("frmGoogleSearch").height = "670px";
		}

	}
	*/
}

function getCheckedModelNo(){
	var arrCheckedModelNo ="";
	if (document.URL.indexOf("/view/List.jsp") >= 0 || document.URL.indexOf("/view/Listmp3.jsp") >= 0  || document.URL.indexOf("/view/Listhandphone.jsp") >= 0 || document.URL.indexOf("/view/Listprinter.jsp") >= 0  || document.URL.indexOf("/view/Listbrand.jsp") >= 0 || document.URL.indexOf("/view/Listsocial.jsp") >= 0){
		arrCheckedModelNo = document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.arrCheckedModelNo
	}else if(document.URL.indexOf("/search/Searchlist.jsp") >= 0){
		arrCheckedModelNo = document.getElementById("searchListFrame").contentWindow.arrCheckedModelNo
	}
	if (typeof(arrCheckedModelNo) == "undefined"){
		return ;
	}
	if(arrCheckedModelNo.length < 0){
		arrCheckedModelNo = document.getElementById("searchListFrame").contentWindow.arrCheckedModelNo
	}
	var varChkModelNos = "";
	for (i=0;i<arrCheckedModelNo.length;i++){
		if (arrCheckedModelNo[i].toString().trim().length > 0){
			if (i > 0 && varChkModelNos !=""){
				varChkModelNos = varChkModelNos + ",";
			}
			varChkModelNos = varChkModelNos + arrCheckedModelNo[i];
		}
	}
	return varChkModelNos;
}

function getCheckedModelNo_fusion(){
	if (document.URL.indexOf("/view/List.jsp") >= 0 || document.URL.indexOf("/view/Listmp3.jsp") >= 0  || document.URL.indexOf("/view/Listhandphone.jsp") >= 0 || document.URL.indexOf("/view/Listprinter.jsp") >= 0 || document.URL.indexOf("/fashion/brand/Clothes_Brand_List.jsp") >= 0 || document.URL.indexOf("/view/fusion/Fusion.jsp") >= 0 || document.URL.indexOf("/view/fusion/Fusion_Masterpiece.jsp") >= 0){
		var arrCheckedModelNo = document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.arrCheckedModelNo
	}else if(document.URL.indexOf("/search/Searchlist.jsp") >= 0){
		var arrCheckedModelNo = document.getElementById("searchListFrame").contentWindow.arrCheckedModelNo
	}
	var varChkModelNos = "";
	for (i=0;i<arrCheckedModelNo.length;i++){
		if (arrCheckedModelNo[i].toString().trim().length > 0){
			if (i > 0 && varChkModelNos !=""){
				varChkModelNos = varChkModelNos + ",";
			}
			varChkModelNos = varChkModelNos + arrCheckedModelNo[i];
		}
	}
	return varChkModelNos;
}
function clickInfoDivShow(){
	if($("clickInfoDiv")) {
		var posLeftTop = Position.cumulativeOffset($("aside"));

		$("clickInfoDiv").style.left = (posLeftTop[0]-350)+"px"
		if((BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6)) {
			$("clickInfoDiv").style.top = (getBodyClientHeight() - 100)+"px"
		} else {
			$("clickInfoDiv").style.top = (getBodyScrollTop() + getBodyClientHeight() - 100)+"px"
		}
		if (document.getElementById("clickInfoDiv").innerHTML == ""){
			var varClickInfoDiv = "";
			varClickInfoDiv += "<img src=\""+var_img_enuri_com+"/images/layer/layer_compare02.gif\" width=\"329\" height=\"102\" border=\"0\" usemap=\"#clickInfoMap\" />";
			varClickInfoDiv += "<map name=\"clickInfoMap\" id=\"clickInfoMap\">";
			varClickInfoDiv += "<area shape=\"rect\" coords=\"302,4,323,23\" href=\"#\" onclick=\"document.getElementById('clickInfoDiv').style.display='none';return false;\" />";
			varClickInfoDiv += "</map>";
			document.getElementById("clickInfoDiv").innerHTML = varClickInfoDiv;
		}
		$("clickInfoDiv").style.display = "";
		$("comparisonInfo").style.display = "none";
		//$("myfavoriteInfo").style.display = "none";
	}
}
var compareMultiWin;
function compare(){
	insertLog(939);
	var varChkModelNos = getCheckedModelNo();

	if (compareMultiWin != null && !compareMultiWin.closed ){
		//var chkUrl = compareMultiWin.document.URL;
		//varChkModelNos = chkUrl.substring(chkUrl.indexOf("chkNo=")+6,chkUrl.length)+","+varChkModelNos;
		varChkModelNos = compareMultiWin.chkNo+","+varChkModelNos;
	}
	if (typeof(varChkModelNos) == "undefined"){
		return ;
	}
	if (varChkModelNos.indexOf(",") < 0){
		//var posLeftTop = Position.cumulativeOffset($("aside"));
		var posLeft = $("#aside").position().left;
		var posTop = $("#aside").position().top;
		document.getElementById("comparisonInfo").style.left = (posLeft-350)+"px"
		document.getElementById("comparisonInfo").style.top = (getBodyScrollTop() + getBodyClientHeight() - 110)+"px"
		if (document.getElementById("comparisonInfo").innerHTML == ""){
			var varComparisonInfo = "";
			varComparisonInfo += "<img src=\""+var_img_enuri_com+"/images/layer/layer_compare.gif\" width=\"329\" height=\"102\" border=\"0\" usemap=\"#comparisonInfoMap\" />";
			varComparisonInfo += "<map name=\"comparisonInfoMap\" id=\"comparisonInfoMap\">";
			varComparisonInfo += "<area shape=\"rect\" coords=\"302,4,323,23\" href=\"#\" onclick=\"document.getElementById('comparisonInfo').style.display='none';return false;\" />";
			varComparisonInfo += "<area shape=\"rect\" coords=\"278,73,315,94\" href=\"#\" onclick=\"insertLog(939);OpenWindowPosition('/view/popup/TowCheckInfo_Popup.jsp','towcheck_1','398','400','YES','NO','250','250');document.getElementById('comparisonInfo').style.display='none';return false;\" />";
			varComparisonInfo += "</map>";
			document.getElementById("comparisonInfo").innerHTML = varComparisonInfo;
		}
		document.getElementById("comparisonInfo").style.display = "";
		//document.getElementById("myfavoriteInfo").style.display = "none";
		document.getElementById("div_inconv").style.display = "none";
	}else{
		varChkModelNos = cleanArray(eliminateDuplicates(varChkModelNos.split(","))).toString();
		varChkModelNos = varChkModelNos.split("G:").join("");
		compareMultiWin = window.open("/view/Comparemulti.jsp?chkNo="+varChkModelNos,"Comparemulti","width=700,height=600,left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=yes,resizable=yes,menubar=no");
		compareMultiWin.focus();
	}
	function cleanArray(actual){
		var newArray = new Array();
		for(var i = 0; i<actual.length; i++){
			if (actual[i]){
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
function compare_fusion(){
	insertLog(939);
	var varChkModelNos = getCheckedModelNo_fusion();

	if (compareMultiWin != null && !compareMultiWin.closed ){
		var chkUrl = compareMultiWin.document.URL;
		varChkModelNos = chkUrl.substring(chkUrl.indexOf("chkNo=")+6,chkUrl.length)+","+varChkModelNos;
	}
	if (varChkModelNos.indexOf(",") < 0){
		//var posLeftTop = Position.cumulativeOffset($("aside"));
		var posLeft = $("#aside").position().left;
		var posTop = $("#aside").position().top;
		document.getElementById("comparisonInfo").style.left = (posLeft-350)+"px"
		document.getElementById("comparisonInfo").style.top = (getBodyScrollTop() + getBodyClientHeight() - 110)+"px"
		if (document.getElementById("comparisonInfo").innerHTML == ""){
			var varComparisonInfo = "";
			varComparisonInfo += "<img src=\""+var_img_enuri_com+"/images/layer/layer_compare.gif\" width=\"329\" height=\"102\" border=\"0\" usemap=\"#comparisonInfoMap\" />";
			varComparisonInfo += "<map name=\"comparisonInfoMap\" id=\"comparisonInfoMap\">";
			varComparisonInfo += "<area shape=\"rect\" coords=\"302,4,323,23\" href=\"#\" onclick=\"document.getElementById('comparisonInfo').style.display='none';return false;\" />";
			varComparisonInfo += "<area shape=\"rect\" coords=\"278,73,315,94\" href=\"#\" onclick=\"insertLog(939);OpenWindowPosition('/view/popup/TowCheckInfo_Popup.jsp','towcheck_1','398','400','YES','NO','250','250');document.getElementById('comparisonInfo').style.display='none';return false;\" />";
			varComparisonInfo += "</map>";
			document.getElementById("comparisonInfo").innerHTML = varComparisonInfo;
		}
		document.getElementById("comparisonInfo").style.display = "";
		//document.getElementById("myfavoriteInfo").style.display = "none";
		document.getElementById("div_inconv").style.display = "none";
	}else{
		varChkModelNos = eliminateDuplicates(varChkModelNos.split(",")).toString();
		compareMultiWin = window.open("/view/Comparemulti.jsp?chkNo="+varChkModelNos,"Comparemulti","width=700,height=600,left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=yes,resizable=yes,menubar=no");
		compareMultiWin.focus();
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
function zzim(){
	insertLog(938);
	/*
	if (rec_zzim == "zzim" && document.getElementById('rb_recent_zzim').style.display != "none"){
		document.getElementById('rb_buttons').style.display="";
		document.getElementById('rb_recent_zzim').style.display = "none";
	}else{
		var varChkModelNos = getCheckedModelNo();
		if(islogin()){
			insertZzimProcNew(varChkModelNos)
		}else{
			setLogintopModelno(varChkModelNos);
			Cmd_Login('inputzzim2010');
		}
	}
	*/
	if (rec_zzim == "zzim"){
		if(document.getElementById('rb_recent_zzim').style.display != "none"){
			document.getElementById('rb_buttons').style.display="";
			document.getElementById('rb_recent_zzim').style.display = "none";
		}
	}
	var varChkModelNos = getCheckedModelNo();
	if (document.getElementById("divLoginLayer")){
		document.getElementById("divLoginLayer").style.position = "absolute";
	}
	if(islogin()){
		insertZzimProcNew(varChkModelNos)
	}else{
		setLogintopModelno(varChkModelNos);
		Cmd_Login('inputzzim2010');
	}


	if (document.getElementById("simpleView")){
		if (document.getElementById("simpleView").className != "_hideClass"){
			insertLog(8449);
		}
	}
}
function zzim_fusion(){
	insertLog(938);
	var varChkModelNos = getCheckedModelNo_fusion();
	if(islogin()){
		insertZzimProcNew(varChkModelNos)
	}else{
		setLogintopModelno(varChkModelNos);
		Cmd_Login('inputzzim2010');
	}
	if (document.getElementById("simpleView")){
		if (document.getElementById("simpleView").className != "_hideClass"){
			insertLog(8449);
		}
	}
}
function toggleZzim(){
	if (document.getElementById('div_inconv')){
		document.getElementById('div_inconv').style.display = "none";
	}
	if (document.getElementById('rb_recent_zzim').style.display != "none"){
		document.getElementById('rb_recent_zzim').style.display = "none";
		showRrightLayer();
	}else{
		/*
		var varChkModelNos = getCheckedModelNo();
		if(islogin()){
			insertZzimProcNew(varChkModelNos)
		}else{
			setLogintopModelno(varChkModelNos);
			Cmd_Login('inputzzim2010');
		}
		*/
		if (document.getElementById("simpleView")){
			if (document.getElementById("simpleView").className != "_hideClass"){
				insertLog(12402);
			}else{
				insertLog(5049);
			}
		}else{
			insertLog(5049);
		}
		if(islogin()){
			insertZzimProcNew("")
		}else{
			setLogintopModelno("");
			Cmd_Login('inputzzim2010');

			document.getElementById("divLoginLayer").style.position = "fixed";
			document.getElementById("divLoginLayer").style.top = (getBodyClientHeight() - 155) +"px";;
			document.getElementById("divLoginLayer").style.left = ($(".enuriBi").width() - 243) +"px";

		}
	}
}
function smallLandingAppDown(rurl){
	if (document.getElementById("simpleView")){
		if (document.getElementById("simpleView").className != "_hideClass"){
			insertLog(12403);
		}else{
			insertLog(12372);
		}
	}else{
		insertLog(12372);
	}
	var nwin = window.open(rurl);
	nwin.focus();
}
function catalogDown(){
	//insertLog(938);
	var varChkModelNos = getCheckedModelNo();
	if (varChkModelNos.trim().length > 0){
		insertCatalogDownProc(varChkModelNos);
	}else{
		alert("퍼가기 할 상품을 선택하세요.")
	}
}
function insertZzimProcNew(szChkNo){
	function ShowSaveInfo(originalRequest){
		//top.document.getElementById("IFrameMyFavoriteList").src = "/include/Incmyfavoritelistmain.jsp";
		if (libType() == "PR"){
   	 		var tempResponse = originalRequest.responseText;
    	}else{
       		var tempResponse = originalRequest;
   		}
		eval("arrReturn = " + tempResponse);
		var varCount = parseInt(arrReturn.count);
		var varSaveMsgObj
		if (!document.getElementById("div_save_msg")){
			varSaveMsgObj = document.createElement("DIV");
			varSaveMsgObj.id = "div_save_msg";
			if((BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6)) {
				varSaveMsgObj.style.position = "absolute";
				varSaveMsgObj.style.top = (400 + getBodyScrollTop()) + "px";
			}else{
				varSaveMsgObj.style.position = "fixed";
				//varSaveMsgObj.style.top = "400px";
				varSaveMsgObj.style.top = (getBodyClientHeight()/2-20) + "px";
			}
			varSaveMsgObj.style.left = ($(".enuriBi").width()/2 - 90) + "px";

			varSaveMsgObj.style.width="156px";
			varSaveMsgObj.style.height="62px";
			varSaveMsgObj.style.backgroundImage = "url("+var_img_enuri_com+"/images/view/resentzzim/layer_ok.png)";
			document.getElementById("wrap").insertBefore(varSaveMsgObj,null);
		}else{
			if((BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6)) {
				document.getElementById("div_save_msg").style.top = (400 + getBodyScrollTop()) + "px";
			}else{
				//document.getElementById("div_save_msg").style.top = "400px";
				document.getElementById("div_save_msg").style.top = (getBodyClientHeight()/2-20) + "px";
			}
			document.getElementById("div_save_msg").style.left = ($(".enuriBi").width()/2 - 90) + "px";
			document.getElementById("div_save_msg").style.display = "";
		}

		var varSaveMsg = "<img src='"+var_img_enuri_com+"/images/view/resentzzim/btn_x.gif' border='0' align='absmiddle' border='0' align='absmiddle' style='position:absolute;left:140px;top:5px;cursor:pointer;' onclick=\"document.getElementById('div_save_msg').style.display='none'\">";
		varSaveMsg += "<img src='"+var_img_enuri_com+"/images/view/resentzzim/go_zlist_over.gif' border='0' align='absmiddle' border='0' align='absmiddle' style='position:absolute;left:50px;top:37px;cursor:pointer;'  onclick=\"resentZzimOpen(2)\">";
		if (varCount == 0 ){
			document.getElementById("div_save_msg").innerHTML = varSaveMsg+"<span style='position:absolute;left:10px;top:15px;color:#008ad6;font-weight:bold;font-family:맑은 고딕';>이미 찜한 상품입니다.</span>";
		}else if (varCount > 0){
			document.getElementById("div_save_msg").innerHTML = varSaveMsg+"<span style='position:absolute;left:36px;top:15px;color:#008ad6;font-weight:bold;font-family:맑은 고딕';'>찜 되었습니다!</span>";
		}else{
			document.getElementById("div_save_msg").innerHTML = varSaveMsg+"<span style='position:absolute;left:30px;top:15px;color:#008ad6;font-weight:bold;font-family:맑은 고딕';'>다시 시도해 주세요.</span>";
		}

		var strPageName = this.document.URL;
		if( strPageName.indexOf("/search/Searchlist.jsp") > -1 ){
			setTimeout(function(){$('#div_save_msg').hide();},3000);

		}else{
			//new Effect.Fade($('div_save_msg'), {duration:3.0, from: 3, to: 0});
			setTimeout(function(){$('#div_save_msg').hide();},3000);
		}

		// 찜한후에 리스트열기
		selectedRGuideNum = 2;
		getGuide_Resent_Zzim(3, 1);
	}
	if (szChkNo == ""){
		getGuide_Resent_Zzim(3, 1);
	}else{
		var url = "/view/include/insertSaveGoodsProc.jsp";
		var param = "modelnos="+szChkNo;
		/*var getRec = new Ajax.Request(
			url,
			{
				method:'get',parameters:param,onComplete:ShowSaveInfo
			}
		);*/
		commonAjaxRequest(url,param,ShowSaveInfo);
	}
}
function insertCatalogDownProc(szChkNo){

	var url = "/view/include/insertCatalogDownProc.jsp";
	var param = "modelnos="+szChkNo;
	/*
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:OpenCatalogDownWin
		}
	);
	*/
	commonAjaxRequest(url,param,OpenCatalogDownWin);

	function OpenCatalogDownWin(originalRequest){
		//top.document.getElementById("IFrameMyFavoriteList").src = "/include/Incmyfavoritelistmain.jsp";
		if (libType() == "PR"){
   	 		var tempResponse = originalRequest.responseText;
    	}else{
       		var tempResponse = originalRequest;
   		}
		eval("arrReturn = " + tempResponse);
		var varCount = parseInt(arrReturn.count);
		if (varCount > 0){

		}
	}
}
function notice(n_type,title,modelno){
	if (n_type == 1){
		insertLog(2068);
		if (typeof(notice._f_none) == "undefined"){
			notice._f_none = ""
		}else if(notice._f_none == ""){
			notice._f_none= "none";
		}else{
			notice._f_none= "";
		}
		if (notice._f_none != "none"){
			if(document.getElementById("divLoginLayer")){
				hideLoginLayer();
			}
		}

		if (document.URL.indexOf("/view/Listmp3.jsp") >= 0  || document.URL.indexOf("/view/Listprinter.jsp") >= 0 || document.URL.indexOf("/view/Listbrand.jsp") >= 0  ){
			//var goodsListObj = document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document.getElementById("goodslist");
			var goodsListObj = $("#enuriMenuFrame").contents().find("#enuriListFrame").contents().find("#wrap");
			if (goodsListObj){
				var singoObjs = $(goodsListObj).find(".btn_singo");
				for (var i=0;i<singoObjs.length;i++){
					singoObjs[i].style.display = notice._f_none;
				}
				document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.hideAllLayer();
				if (document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("singo_cate_comm")){
					document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("singo_cate_comm").style.display = notice._f_none;
				}

			}
		}else if(document.URL.indexOf("/search/Searchlist.jsp") >= 0){
			var goodsListObj =document.getElementById("searchListFrame").contentWindow.document.getElementById("wrap");
			if(goodsListObj!=null && $(goodsListObj)) {
				//var singoObjs = $(goodsListObj).getElementsBySelector('*[class="btn_singo"]');
				//var singoObjs = goodsListObj.getElementsByClassName("btn_singo");
				var singoObjs = $(goodsListObj).find(".btn_singo");
				for (var i=0;i<singoObjs.length;i++){
					singoObjs[i].style.display = notice._f_none;
				}
			}
			if (typeof(document.getElementById("searchListFrame").contentWindow.hideAllLayer) == "function"){
				document.getElementById("searchListFrame").contentWindow.hideAllLayer();
			}
		}
	}
	function ShowInConv(originalRequest){
		var varHideStatus = false;
		var varHideRecentZzim = false;
		if (libType() == "PR"){
			document.getElementById("div_inconv").innerHTML = originalRequest.responseText;
    	}else{
    		document.getElementById("div_inconv").innerHTML = originalRequest;
   		}
		if (n_type == 1 ){
			document.getElementById("div_inconv").style.position = "fixed";
			document.getElementById("div_inconv").style.top = (getBodyClientHeight() - 265) +"px";;
			document.getElementById("div_inconv").style.left = ($(".enuriBi").width() - 275) +"px";
			hideRecentZzim();
			varHideRecentZzim = true;
		}else if(n_type == 2){
			if (notice._f_type == n_type && document.getElementById("div_inconv").style.display != "none"){
				document.getElementById("div_inconv").style.display = "none";
				varHideStatus = true;
			}else{
				/*var posLeftTop = Position.cumulativeOffset(top.document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("comment_layer"));
				document.getElementById("div_inconv").style.top = (posLeftTop[1] + top.document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("comment_layer").offsetHeight + 84 ) +"px";;
				document.getElementById("div_inconv").style.left = posLeftTop[0] +"px";*/
				document.getElementById("div_inconv").style.position = "absolute";
				document.getElementById("div_inconv").style.top = (top.document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("comment_layer").offsetTop + top.document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("comment_layer").offsetHeight + 84 ) +"px";;
				document.getElementById("div_inconv").style.left = top.document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("comment_layer").offsetLeft +"px";
			}
		}else if(n_type == 4){
			if (notice._f_type == n_type && notice._f_modelno == modelno && document.getElementById("div_inconv").style.display != "none"){
				document.getElementById("div_inconv").style.display = "none";
				varHideStatus = true;
			}else{
				var varTop = 0;
				if (document.getElementById("enuriMenuFrame")){
					if (document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame")){
						/*varTop = Position.cumulativeOffset(top.document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document.getElementById("modelImg_"+modelno))[1] - 5;
						varTop = varTop + Position.cumulativeOffset(top.document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame"))[1]
						varTop = varTop + Position.cumulativeOffset(top.document.getElementById("enuriMenuFrame"))[1];*/

						varTop = $(top.document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document.getElementById("modelImg_"+modelno)).position().top - 5;
						varTop = varTop + $(top.document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame")).position().top;
						varTop = varTop + $(top.document.getElementById("enuriMenuFrame")).position().top;

						if ( (varTop + document.getElementById("div_inconv").offsetHeight) > (getBodyClientHeight() + getBodyScrollTop())){
							varTop = (getBodyClientHeight() + getBodyScrollTop()) - document.getElementById("div_inconv").offsetHeight - 10;
						}
					}
				}
				if (document.getElementById("searchListFrame")){
					varTop = $(top.document.getElementById("searchListFrame").contentWindow.document.getElementById("modelImg_"+modelno)).position().top - 5;
					varTop = varTop+$(top.document.getElementById("searchListFrame")).position().top;
					if ((varTop + document.getElementById("div_inconv").offsetHeight) > (getBodyClientHeight() + getBodyScrollTop())){
						varTop = (getBodyClientHeight() + getBodyScrollTop()) - document.getElementById("div_inconv").offsetHeight - 10;
					}
				}
				document.getElementById("div_inconv").style.position = "absolute";
				document.getElementById("div_inconv").style.top = (varTop) +"px";
				document.getElementById("div_inconv").style.left = ($(".enuriBi").width() - 200) +"px";
			}
		}else if(n_type == 5){
			if (notice._f_type == n_type && document.getElementById("div_inconv").style.display != "none"){
				document.getElementById("div_inconv").style.display = "none";
				varHideStatus = true;
			}else{
				/*
	            var topPos =  145;
	            if(document.getElementById("tx_favorite_1203")) {
	            	document.getElementById("div_inconv").style.left = "192px";
	            }else if(document.getElementById("menu_openprd_1203")) {
	            	document.getElementById("div_inconv").style.left = "192px";
	            }else if(document.getElementById("tx_favorite_1203_2")) {
	            	document.getElementById("div_inconv").style.left = "315px";
	            }else{
	            	document.getElementById("div_inconv").style.left = "340px";
	            }
	            document.getElementById("div_inconv").style.top = topPos + "px";
	            */
				//var posLeftTop = Position.cumulativeOffset($("More_layer_2"));
				var posLeft = $("#More_layer_2").position().left;
				var posTop = $("#More_layer_2").position().top;
				document.getElementById("div_inconv").style.position = "absolute";
				document.getElementById("div_inconv").style.top = (posTop+document.getElementById("More_layer_2").offsetHeight+30) + "px";
				document.getElementById("div_inconv").style.left = posLeft+ "px";
	            insertLog(2067);
			}
		}else if(n_type == 6){
			document.getElementById("div_inconv").style.position = "absolute";
			document.getElementById("div_inconv").style.top = (700+getBodyScrollTop())+"px";
			document.getElementById("div_inconv").style.left = "570px";
	        document.getElementById("div_inconv").style.display = "";
		}
		if (typeof(notice._f_type) == "undefined"){
			notice._f_type = "";
		}else{
			notice._f_type = n_type;
		}
		if (typeof(notice._f_modelno) == "undefined"){
			notice._f_modelno = "";
		}else{
			notice._f_modelno = modelno;
		}
		if (varHideStatus){
			return;
		}
		if(document.getElementById("div_inconv")){
			document.getElementById("div_inconv").style.display = "";
		}
		if(document.getElementById("rb_buttons")){
			document.getElementById("rb_buttons").style.display = "";
		}
		if(varHideRecentZzim){
			return;
		}
		if(document.getElementById("rb_recent_zzim")){
			document.getElementById("rb_recent_zzim").style.display = "";
		}

	}
	setTimeout(function(){

		if( (typeof(notice._f_none) == "undefined" || notice._f_none== "") || (n_type == 5 && document.getElementById("div_inconv").style.display == "none") ) {

			var url = "/include/ajax/AjaxInconv.jsp";
			var varpType = n_type;
			if (n_type == 6){
				varpType = 5;
			}
			var param = "type="+varpType;
			if (typeof(grzTempCate) != "undefined"){
				param = param+"&cate="+grzTempCate;
			}

			if (n_type == 2 || n_type == 3 || n_type == 4){
				param += "&title="+title;
			}
			if (n_type == 4){
				param += "&modelno="+modelno;
			}
			/*var getRec = new Ajax.Request(
				url,
				{
					method:'get',parameters:param,onComplete:ShowInConv
				}
			);	*/
			commonAjaxRequest(url,param,ShowInConv);
		}else{
			if (typeof(notice._f_none) == "undefined"){
				if (document.getElementById("div_inconv").style.display != "none"){
					document.getElementById("div_inconv").style.display = "none";
				}
			}else{
				document.getElementById("div_inconv").style.display = notice._f_none;
			}
		}
	},100);
}
function notice_more(){
	insertLog(2068);
	if (typeof(notice._f_none) == "undefined"){
		notice._f_none = ""
	}else if(notice._f_none == ""){
		notice._f_none= "none";
	}else{
		notice._f_none= "";
	}
	if (document.URL.indexOf("/view/List.jsp") >= 0 || document.URL.indexOf("/view/Listmp3.jsp") >= 0  || document.URL.indexOf("/view/Listhandphone.jsp") >= 0 || document.URL.indexOf("/view/Listbrand.jsp") >= 0 ){
		var goodsListObj = document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document.getElementById("goodslist");

		var singoObjs = $(goodsListObj).getElementsBySelector('*[class="btn_singo"]');

		for (var i=0;i<singoObjs.length;i++){
			singoObjs[i].style.display = notice._f_none;
		}
		document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.hideAllLayer();
		if (document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("singo_cate_comm")){
			document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("singo_cate_comm").style.display = notice._f_none;
		}
	}else if(document.URL.indexOf("/search/Searchlist.jsp") >= 0){
		var goodsListObj =document.getElementById("searchListFrame").contentWindow.document.getElementById("goodslist");
		if(goodsListObj!=null && $(goodsListObj)) {
			var singoObjs = $(goodsListObj).getElementsBySelector('*[class="btn_singo"]');
			for (var i=0;i<singoObjs.length;i++){
				singoObjs[i].style.display = notice._f_none;
			}
		}
		if (typeof(document.getElementById("searchListFrame").contentWindow.hideAllLayer) == "function"){
			document.getElementById("searchListFrame").contentWindow.hideAllLayer();
		}
	}
	function ShowInConv(originalRequest){

		document.getElementById("div_inconv").innerHTML = originalRequest.responseText;
		document.getElementById("div_inconv").style.top = (getBodyClientHeight() + getBodyScrollTop()  - 600) +"px";;
		document.getElementById("div_inconv").style.left = (document.getElementById("wrap").offsetWidth - 600) +"px";;
		document.getElementById("div_inconv").style.display = "";
		document.getElementById("rb_buttons").style.display="";
		document.getElementById("rb_recent_zzim").style.display='none';
	}
	setTimeout(function(){
		if( notice._f_none == "") {
			var varType = "";
			var varNowUrl = document.URL;
			if(varNowUrl.indexOf("/Index.jsp") >= 0 || varNowUrl.indexOf("/mime/Err_404.jsp") >= 0 || varNowUrl.indexOf("/fashion/Fashion_SubList.jsp") >= 0 ||
				varNowUrl.indexOf("/fashion/clothes/") >= 0 || varNowUrl.indexOf("/fashion/Fashion_Masstige_SubList.jsp") >= 0 || varNowUrl.indexOf("/view/fusion/Fusion.jsp") >= 0 ||
				varNowUrl.indexOf("/view/fusion/Fusion_Masterpiece.jsp") >= 0 || varNowUrl.indexOf("/view/fusion/Fusion_Sub.jsp") >= 0 ||
				varNowUrl.indexOf("/view/fusion/Fusion_Scate.jsp") >= 0 || varNowUrl.indexOf("/view/fusion/Fusion_Brand_Sub.jsp") >= 0 ||
				varNowUrl.indexOf("/fashion/brand/") >= 0
			){
				varType = "1";
			}
			var url = "/include/ajax/AjaxInconv.jsp";
			var param = "type="+varType+"&cate="+grzTempCate;
			/*var getRec = new Ajax.Request(
				url,
				{
					method:'get',parameters:param,onComplete:ShowInConv
				}
			);*/
			commonAjaxRequest(url,param,ShowInConv);

		}else{
			document.getElementById("div_inconv").style.display = notice._f_none;
		}
	},100);
}
function checkBackground(obj){
	if (obj.value.trim().length == 0 ){
		if (obj.id == "inconv_txt"){
			obj.style.backgroundImage = "url("+var_img_enuri_com+"/images/view/error/error_webFont01.gif)";
		}else{
			obj.style.backgroundImage = "url("+var_img_enuri_com+"/images/view/error/error_webFont02.gif)";
		}
	}
}
function noticeInconvenionce(cate,kbno,modelno,errType){
	if (document.getElementById("inconv_txt").value.trim().length == 0 ){
		alert("오류내용을 입력해 주십시오.");
		document.getElementById("inconv_txt").focus();
		return;
	}
	if (document.getElementById("inconv_txt").value.trim().korlen() > 1000){
		alert("500자 이상 입력하실수 없습니다.")
		document.getElementById("inconv_txt").focus();
		return;
	}
	/*
	if (document.getElementById("inconv_email").value.trim().length > 0 ){
		if (!document.getElementById("inconv_email").value.trim().isemail()){
			alert("올바른 E-Mail주소를 입력해 주십시오.");
			document.getElementById("inconv_email").focus();
			return;
		}
	}
	*/
	var url = "/include/layer/InsertInconvenience.jsp";
	var param = "cate="+cate+"&inconv_txt="+encodeURIComponent(document.getElementById("inconv_txt").value.trim())+"<BR>"+navigator.userAgent+"<BR>"+getOSInfoStr();
	/*
	if(document.URL.indexOf("/knowbox/List.jsp") >= 0 ){
		cate = document.URL.substring(document.URL.indexOf("?cate=")+6,document.URL.indexOf("&"));
		rkbno = document.URL.substring(document.URL.indexOf("kbno=")+5,document.URL.length);
		param = "cate="+cate+"&inconv_txt="+encodeURIComponent(document.getElementById("inconv_txt").value.trim())+"<BR>"+navigator.userAgent+"<BR>"+getOSInfoStr()+"&rkbno="+rkbno;
	}
	*/
	if (typeof(kbno) != "undefined"){
		param += "&kbno="+kbno;
	}
	if (typeof(modelno) != "undefined"){
		param += "&modelno="+modelno;
	}
	if (typeof(errType) != "undefined"){
		if (errType == 1){
			param += "&epclass=34";
		}else if (errType == 2){
			param += "&epclass=36";
		}else if (errType == 4){
			param += "&epclass=10";
		}
	}
	/*var getRec = new Ajax.Request(
		url,
		{
			method:'post',parameters:param,onComplete:showSaveMsg
		}
	);*/
	commonAjaxRequest(url,param,showSaveMsg);
	function showSaveMsg(originalRequest){
		document.getElementById("inconv_txt").value="";
		//document.getElementById("inconv_email").value="";
		document.getElementById("div_inconv").style.display = "none";
		//alert(originalRequest);
		if (libType() == "PR"){
   	 		var tempResponse = originalRequest.responseText;
    	}else{
       		var tempResponse = originalRequest;
   		}
		if(tempResponse.indexOf("ERROR_CNT_OVER") >= 0){
        	alert("일일 신고 제한 건수인 20 건을 초과했습니다.\n내일 다시 신고 주시기 바랍니다.\n문의: (02)6354-3601(내선:206)");
        }else{
        	alert("불편신고가 접수되었습니다.");
        }
	}
}
function getOSInfoStr(){
	var ua = navigator.userAgent;
	if(ua.indexOf("NT 6.0") != -1) return "Windows Vista/Server 2008";
	else if(ua.indexOf("NT 5.2") != -1) return "Windows Server 2003";
	else if(ua.indexOf("NT 5.1") != -1) return "Windows XP";
	else if(ua.indexOf("NT 5.0") != -1) return "Windows 2000";
	else if(ua.indexOf("NT") != -1) return "Windows NT";
	else if(ua.indexOf("9x 4.90") != -1) return "Windows Me";
	else if(ua.indexOf("98") != -1) return "Windows 98";
	else if(ua.indexOf("95") != -1) return "Windows 95";
	else if(ua.indexOf("Win16") != -1) return "Windows 3.x";
	else if(ua.indexOf("Windows") != -1) return "Windows";
	else if(ua.indexOf("Linux") != -1) return "Linux";
	else if(ua.indexOf("Macintosh") != -1) return "Macintosh";
	else return "";
}

// 브라우져 정보 읽어오기
function getBrowserName() {
	if(navigator.userAgent.toLowerCase().indexOf('msie 6')>-1 && navigator.userAgent.toLowerCase().indexOf('msie 7')==-1 && navigator.userAgent.toLowerCase().indexOf('msie 8')==-1) {
		return "msie6";
	}
	if(navigator.userAgent.toLowerCase().indexOf('msie 7')>-1 && navigator.userAgent.toLowerCase().indexOf('msie 8')==-1) {
		if(navigator.userAgent.toLowerCase().indexOf('trident/4.0')>-1) {
			return "msie8";
		}else if(navigator.userAgent.toLowerCase().indexOf('trident/5.0')>-1) {
			return "msie9";
		}else if(navigator.userAgent.toLowerCase().indexOf('trident/6.0')>-1) {
			return "msie10";
		}else {
			return "msie7";
		}
	}
	if(navigator.userAgent.toLowerCase().indexOf('msie 8')>-1) {
		return "msie8";
	}
	if(navigator.userAgent.toLowerCase().indexOf('msie 9')>-1) {
		return "msie9";
	}
	if(navigator.userAgent.toLowerCase().indexOf('msie 10')>-1) {
		return "msie10";
	}
	if(navigator.userAgent.toLowerCase().indexOf('msie')!=-1) {
		return "msie";
	}
	if(navigator.userAgent.toLowerCase().indexOf('firefox')>-1) {
		return "firefox";
	}
	if(navigator.userAgent.toLowerCase().indexOf('opera')>-1) {
		return "opera";
	}
	if(navigator.userAgent.toLowerCase().indexOf('chrome')>-1) {
		return "chrome";
	}
	if(navigator.userAgent.toLowerCase().indexOf('safari')>-1) {
		return "safari";
	}


}
function getAdditionalBeginnerDic(kb_no,org_kb_no,cate,level){
	if (document.URL.indexOf("/view/List.jsp") >= 0 || document.URL.indexOf("/view/Listmp3.jsp") >= 0  || document.URL.indexOf("/view/Listhandphone.jsp") >= 0 || document.URL.indexOf("/view/Listprinter.jsp") >= 0 ){
		document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.getAdditionalBeginnerDic(kb_no,org_kb_no,cate,level)
	}else if(document.URL.indexOf("/view/Searchlist.jsp") >= 0 ){
		document.getElementById("searchListFrame").contentWindow.getAdditionalBeginnerDic(kb_no,org_kb_no,cate,level);
	}

}
function openGoodsDetailInfoLayer(){
	if (document.getElementById("divGoodsDetailInfo")){
		if (document.getElementById("divGoodsDetailInfo").style.display != "none"){
			document.getElementById("divGoodsDetailInfo").style.display = "none";
		}else{
			document.getElementById("divGoodsDetailInfo").style.left = (document.getElementById("wrap").offsetWidth - 550)+"px";
			if (document.getElementById("divGoodsDetailInfo").innerHTML == ""){
				var varDivGoodsDetailInfo = "";
				varDivGoodsDetailInfo = "<table cellpadding=\"0\" cellspacing=\"0\" width=\"434\" border=\"0\">";
				varDivGoodsDetailInfo += "<tr>";
				varDivGoodsDetailInfo += "<td height=\"237\" align=\"center\"><img usemap=\"#divGoodsDetailInfoMap\" src=\""+var_img_enuri_com+"/2012/list/layer_120918.png\" width=\"434\" height=\"237\" /></td>";
				varDivGoodsDetailInfo += "</tr>";
				varDivGoodsDetailInfo += "</table>";
				varDivGoodsDetailInfo += "<map name=\"divGoodsDetailInfoMap\" id=\"divGoodsDetailInfoMap\">";
				varDivGoodsDetailInfo += "<area shape=\"rect\" coords=\"407,12,421,27\" href=\"#\" onclick=\"document.getElementById('divGoodsDetailInfo').style.display='none';return false;\" />";
				varDivGoodsDetailInfo += "</map>";
				document.getElementById("divGoodsDetailInfo").innerHTML = varDivGoodsDetailInfo;
			}
			document.getElementById("divGoodsDetailInfo").style.display = "";
		}
	}
}
function viewLoadingBar(isSpread){
	var varIsSpread = false;
	if (typeof(isSpread) != "undefined"){
		document.getElementById("loading").style.top = "174px"
		document.getElementById("loadingListBg").style.top = "174px"
	}
	document.getElementById("loading").style.left = (document.getElementById("dvMenuFrame").offsetWidth/2 - 107)+"px";

	document.getElementById("loading").style.top = 430+"px"
	document.getElementById("loading").style.display = "";
	if (document.getElementById("loadingListBg")){
		document.getElementById("loadingListBg").style.width = $(".enuriBi").width()+"px"
		document.getElementById("loadingListBg").style.display = "";
	}
	insertLog(10381);
}
function hideLoadingBar(){

	document.getElementById("loading").style.display = "none";
	if(document.getElementById("loadingListBg")){
		document.getElementById("loadingListBg").style.display = "none";
	}
	if (document.getElementById("img_spec_search_loading")){
		document.getElementById("img_spec_search_loading").style.display = "none";
	}

}
function showBeginnerDicBigImage(varImg){
	document.getElementById("beginner_big").src = varImg;
	/*
	var beginnerBigImage = new Image();
	beginnerBigImage = document.createElement("IMG");
	beginnerBigImage.src = varImg;
	*/
	document.getElementById("beginner_big").onload = function(){
		document.getElementById("beginner_big_img").style.left = (document.getElementById("wrap").offsetWidth/2 - document.getElementById("beginner_big").width/2)+"px";
		document.getElementById("beginner_big_img").style.top = (getBodyClientHeight()/2 - document.getElementById("beginner_big").height/2 + getBodyScrollTop())+"px";
		document.getElementById("beginner_big_img").style.display = "";
		document.getElementById("beginner_big_img").style.left = (document.getElementById("wrap").offsetWidth/2 - document.getElementById("beginner_big").width/2)+"px";
		document.getElementById("beginner_big_img").style.top = (getBodyClientHeight()/2 - document.getElementById("beginner_big").height/2 + getBodyScrollTop())+"px";
	}
}
var detailWin = null;
function detailMultiView(OpenFile,name,modelno){
//	var detailWin = window.open(OpenFile,"detailMultiWin","width=780,height=600,left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
//	detailWin.focus();
	/*
	if(navigator.userAgent.indexOf("Chrome/")>0 && BrowserDetect.browser != "Explorer") {
		window.detailWin = window.open("","detailMultiWin","width=0,height=0,left=0,top=0");
		window.detailWin.close();
		window.detailWin = null;
	}
	*/
	//window.detailWin = window.open(OpenFile,"detailMultiWin","width=804,height="+window.screen.height+",left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
	//window.detailWin.focus();
 	var sheight = eval(screen.height);
 	if(navigator.userAgent.toLowerCase().indexOf("chrome")>0 && navigator.userAgent.toLowerCase().indexOf("edge")>0){ //win10+edge
 		sheight -= 150;
 	}
	/*detailWin = window.open("/_pre_detail_.jsp","detailMultiWin","width=804,height="+sheight+",left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
	detailWin.location.href = OpenFile;
	detailWin.focus();*/

	//vip 개편작업

 	if(OpenFile.indexOf("/view/Detailmulti.jsp")>-1 ){
 		OpenFile = OpenFile.replace("/view/Detailmulti.jsp","/detail.jsp");
 	}
	detailWin = window.open("/_pre_detail_.jsp");
	detailWin.location.replace(OpenFile);
	detailWin.focus();
	if(top.location.pathname.indexOf("view/Listmp3.jsp")>=0){
		insertLog(14951);
	}else if(top.location.pathname.indexOf("search/Searchlist.jsp")>=0){
		insertLog(14953);
	}
}
function clauseInfoCheckOnclick(){
	document.getElementById("chkTerms").checked = document.getElementById("clauseInfoCheck").checked
	document.getElementById("clauseInfoDiv").style.display = "none";
	checkCatalogTerms();
	if (document.getElementById("chkTerms").checked){
		document.getElementById("btn_catalog_down").style.display = "";
	}else{
		document.getElementById("btn_catalog_down").style.display = "none";
	}
	/*
	if (typeof(catalogDownload._modelno) != "undefined" && catalogDownload._modelno != ""){
		catalogDownload(catalogDownload._modelno,catalogDownload._userid)
	}
	*/
}
function checkCatalogTermsNShow(){
	checkCatalogTerms();
	if (document.getElementById("chkTerms").checked){
		/*
		setTimeout(function(){
			showCatalogTerms();
		},100);
		*/
		document.getElementById("btn_catalog_down").style.display = "";
		document.getElementById("clauseInfoDiv").style.display = "none";
	}else{
		document.getElementById("btn_catalog_down").style.display = "none";
		document.getElementById("clauseInfoCheck").checked = false;
	}
}
function checkCatalogTerms(){
	var now=new Date();
	var url = "/include/ajax/AjaxCatalogUsedTerms.jsp";
	var param = "mt=put&t="+now.getTime();
	if (document.getElementById("chkTerms").checked){
		param = param + "&ck=Y";
	}else{
		param = param + "&ck=N";
	}
	commonAjaxRequest(url,param,function(){});
	/*
	var getTerms = new Ajax.Request(
		url,
		{
			method:'get',parameters:param
		}
	);
	*/
}
function checkCatalogType(imgtype){
	if (imgtype == 1){
		insertLog(4968);
	}else if(imgtype == 2){
		insertLog(4969);
	}else if(imgtype == 3){
		insertLog(4970);
	}

	var now=new Date();
	var url = "/include/ajax/AjaxSelectedCatalogType.jsp";
	var param = "img_type="+imgtype+"&t="+now.getTime();
	commonAjaxRequest(url,param,function(){});
	/*
	var getTerms = new Ajax.Request(
		url,
		{
			method:'get',parameters:param
		}
	);
	*/
}
function showCatalogTerms(){
	if (document.getElementById("clauseInfoDiv")){
		if (document.getElementById("clauseInfoDiv").style.display != "none"){
			document.getElementById("clauseInfoDiv").style.display = "none";
			return;
		}
	}
	var now=new Date();
	var url = "/include/ajax/AjaxCatalogUsedTerms.jsp";
	var param = "mt=get&t="+now.getTime();
	commonAjaxRequest(url,param,isCheckCatalogTerms);
	/*
	var getTerms = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:isCheckCatalogTerms
		}
	);
	*/
	function isCheckCatalogTerms(originalRequest){
		if (libType() == "PR"){
   	 		var tempResponse = originalRequest.responseText;
    	}else{
       		var tempResponse = originalRequest;
   		}

		if (tempResponse == "Y"){
			document.getElementById("clauseInfoCheck").checked = true;
		}else{
			document.getElementById("clauseInfoCheck").checked = false;
		}

		if((BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6)) {
			document.getElementById("clauseInfoDiv").style.position = "absolute";
			document.getElementById("clauseInfoDiv").style.top = ((getBodyClientHeight()/2-50) + getBodyScrollTop()) + "px";
		}else{
			document.getElementById("clauseInfoDiv").style.position = "fixed";
			document.getElementById("clauseInfoDiv").style.top = (getBodyClientHeight()/2-50) + "px";
		}
		document.getElementById("clauseInfoDiv").style.left = ($(".enuriBi").width()/2 - 320) + "px";
		document.getElementById("clauseInfoDiv").style.display = "";


	}
}
function hiddenClauseInfoDiv(){
	document.getElementById("clauseInfoDiv").style.display = "none";
}
// 퍼가기를 클릭했을 경우
function showCatalogDownload(modelno,userid,top,modelname,factory) {
	if (typeof(userid) != ""){
		insertLog(4965);
	}
	function ShowClauseLayer(originalRequest){
		if (libType() == "PR"){
   	 		var tempResponse = originalRequest.responseText;
    	}else{
       		var tempResponse = originalRequest;
   		}
		document.getElementById("clauseLayer").style.position = "absolute";
		document.getElementById("clauseLayer").style.top = top + "px";
		document.getElementById("clauseLayer").style.left = ($(".enuriBi").width()/2 - 180) + "px";
		document.getElementById("clauseLayer").innerHTML = tempResponse;
		document.getElementById("clauseLayer").style.display = "";
		showCatalogDownload._modelno = modelno;
		showCatalogDownload._userid = userid;
	}
	var url = "/include/ajax/AjaxClauseLayer.jsp";
	var param = "modelno="+modelno+"&modelname="+modelname+"&factory="+factory;
	commonAjaxRequest(url,param,ShowClauseLayer);
	/*
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:ShowClauseLayer
		}
	);
	*/
}
function catalogDownload(ecatalmodel){
	if(typeof(ecatalmodel)=="undefined") ecatalmodel = 0;
	var modelno = showCatalogDownload._modelno;
	var userid = showCatalogDownload._userid;

	var imgtype = "";
	if (document.getElementById("rdoCopyType1") && document.getElementById("rdoCopyType1").checked){
		imgtype = "1";
	}else if(document.getElementById("rdoCopyType2").checked){
		imgtype = "2";
	}else if(document.getElementById("rdoCopyType4") && document.getElementById("rdoCopyType4").checked){
		imgtype = "4";
	}

	var widthtype = "";
	if (document.getElementById("rdoWidthType1").checked){
		widthtype = "1";
	}else if(document.getElementById("rdoWidthType2").checked){
		widthtype = "2";
	}else if(document.getElementById("rdoWidthType3").checked){
		widthtype = "3";
	}
	copyCatalogUrl(modelno,userid,imgtype,widthtype,ecatalmodel);
}
function ImgFolder(modelno){
    var output = "1";
    var input = modelno+"";
	if( modelno < 1000){
		output = "1";
	}else{
		output = input.substring(0, input.length-3) + "000";
	}
   return output;
}
// 퍼가기 실행
function copyCatalogUrl(modelno,userid,imgtype,widthtype,ecatalmodel) {
	if(typeof(ecatalmodel)=="undefined") ecatalmodel = 0;
	userid = "enuri";
	//userid = "enuri007"; //151용
	showCatalogDownload._userid = userid;

	if(ecatalmodel>0 && imgtype==4){ //큰사진만 퍼가기는 다르게
		var returnImageUrl = "";
		function returnCopyOnlyBigImage(originalRequest){
			//returnImageUrl = originalRequest.responseText;
			if (libType() == "PR"){
	   	 		var returnImageUrl = originalRequest.responseText;
	    	}else{
	       		var returnImageUrl = originalRequest;
	   		}
			if(window.clipboardData) {
				window.clipboardData.setData("Text", returnImageUrl);
			}
		}
		var url = "/view/include/catalog/AjaxGetOnlyBigImage.jsp";
		var param = "modelno="+modelno+"&ecatal_modelno="+ecatalmodel;
		commonAjaxRequest(url,param,returnCopyOnlyBigImage);
		/*
		var getCatalogImg = new Ajax.Request(
			url,
			{
				method:'get',parameters:param,onComplete:returnCopyOnlyBigImage
			}
		);
		*/
	}else{

		var url = "/view/include/catalog/AjaxGetCatalogImage.jsp";
		var param = "imgtype="+imgtype+"&modelno="+modelno+"&userid="+userid+"&widthtype="+widthtype;

		var dateLong = (new Date()).getTime();
		param += "&dateLong="+dateLong;
		commonAjaxRequest(url,param,function(){});
		/*
		var getCatalogImg = new Ajax.Request(
			url,
			{
				method:'get',parameters:param
			}
		);
		*/
		var withtype_name = "";
		if (widthtype == "2" || widthtype == "3"){
			withtype_name = "_1";
		}
		var returnImageUrl = "";
		if (widthtype != "3"){
			returnImageUrl = "http://storage.enuri.info/func_info/"+userid+"/"+ImgFolder(modelno)+"/"+modelno+"_"+imgtype+withtype_name+".png";
		}else{
			returnImageUrl = "http://goodsinfo.enuri.gscdn.com/func_info/"+userid+"/"+ImgFolder(modelno)+"/"+modelno+"_"+imgtype+withtype_name+".png";
		}
		var returnImageTag = "<img src='"+returnImageUrl+"' border='0' />";

		if(window.clipboardData) {
			window.clipboardData.setData("Text", returnImageTag);
		}
		callCDNImg(returnImageUrl);
	}

	if(window.clipboardData) {
		if (fnGetCookie2010("copy_today") != "Y"){
			showCatalogCopyInfoDiv();
		}
	}else{
		alert("해당 브라우저에서 지원하지않습니다.");
	}
	catalogDownload._modelno = "";
	catalogDownload._userid = "";
	document.getElementById("clauseLayer").style.display = "none";
}
function callCDNImg(url){
	var cdn_url = "http://async.wisen.gscdn.com/rsync?id=1103&files=" + url;
	var cdn_if = document.createElement("iframe");
	cdn_if.style.width = "0px";
	cdn_if.style.height = "0px";
	cdn_if.style.display = "none";
	cdn_if.width = "0";
	cdn_if.height = "0";
	cdn_if.src = cdn_url;
	document.body.appendChild(cdn_if);
}
function showCatalogCopyInfoDiv() {
	if(document.getElementById("catalogCopyInfoDiv").style.display=="none") {
		hiddenClauseInfoDiv();

		if((BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6)) {
			document.getElementById("catalogCopyInfoDiv").style.position = "absolute";
			document.getElementById("catalogCopyInfoDiv").style.top = ((getBodyClientHeight()/2-20) + getBodyScrollTop()) + "px";
		}else{
			document.getElementById("catalogCopyInfoDiv").style.position = "fixed";
			document.getElementById("catalogCopyInfoDiv").style.top = (getBodyClientHeight()/2-20) + "px";
		}
		document.getElementById("catalogCopyInfoDiv").style.left = (document.getElementById("wrap").offsetWidth/2 - 40) + "px";
		document.getElementById("catalogCopyInfoDiv").style.display = "";
		document.getElementById("catalogCopyInfoDiv").style.zIndex = "1100";
	} else {
		hiddenCatalogCopyInfoDiv();
	}
}
function hiddenCatalogCopyInfoDiv() {
	document.getElementById("catalogCopyInfoDiv").style.display = "none";
}
function showCatalogCopyInfoDiv2(){
	if((BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6)) {
		document.getElementById("catalogCopyInfoDiv2").style.position = "absolute";
		document.getElementById("catalogCopyInfoDiv2").style.top = ((getBodyClientHeight()/2-20) + getBodyScrollTop()) + "px";
	}else{
		document.getElementById("catalogCopyInfoDiv2").style.position = "fixed";
		document.getElementById("catalogCopyInfoDiv2").style.top = (getBodyClientHeight()/2-20) + "px";
	}
	document.getElementById("catalogCopyInfoDiv2").style.left = (document.getElementById("wrap").offsetWidth/2 - 40) + "px";
	document.getElementById("catalogCopyInfoDiv2").style.display = "";
	document.getElementById("catalogCopyInfoDiv2").style.zIndex = "1100";
}
function goCatalogSample(bigImgFlag) {
	insertLog(4967);

	var imgtype = "";
	if (document.getElementById("rdoCopyType1") && document.getElementById("rdoCopyType1").checked){
		imgtype = "1";
	}else if(document.getElementById("rdoCopyType2").checked){
		imgtype = "2";
	}else if(document.getElementById("rdoCopyType4") && document.getElementById("rdoCopyType4").checked){
		imgtype = "4";
	}

	var widthtype = "";
	if (document.getElementById("rdoWidthType1").checked){
		widthtype = "1";
	}else if(document.getElementById("rdoWidthType2").checked){
		widthtype = "2";
	}else if(document.getElementById("rdoWidthType3").checked){
		widthtype = "3";
	}
 	var sheight = eval(screen.height);
 	if(navigator.userAgent.toLowerCase().indexOf("chrome")>0 && navigator.userAgent.toLowerCase().indexOf("edge")>0){ //win10+edge
 		sheight -= 150;
 	}
	var showUrl = "/view/include/catalog/catalogDownloadSample.jsp?checkedValue="+imgtype+"&checkedWidthValue="+widthtype+"&bigImgFlag="+bigImgFlag;
	var catalogSample = window.open (showUrl,"catalogSample","width=908,height="+sheight+",top=0,left=0,toolbar=no,location=no,directories=no,status=no,scrollbars=yes,menubar=no,personalbar=no");
	catalogSample.focus();
}
function checkCatalogWidthType(widthtype){
	if (widthtype == 1){
		insertLog(4977);
	}else if(widthtype == 2){
		insertLog(4978);
	}else if(widthtype == 3){
		insertLog(4978);
	}

	if(widthtype==1){ //오픈마켓 선택시만 큰사진 선택 가능
		if(document.getElementById("onlyopen")){
			document.getElementById("onlyopen").style.display = "block";
			document.getElementById("rdoCopyType4").checked = true;
		}
	}else{
		if(document.getElementById("onlyopen")){
			if(document.getElementById("rdoCopyType4").checked){ //큰사진 선택시 해제
				//document.getElementById("rdoCopyType1").checked = true;
				document.getElementById("rdoCopyType2").checked = true;
			}
			document.getElementById("onlyopen").style.display = "none";
		}
	}

	var now=new Date();
	var url = "/include/ajax/AjaxSelectedCatalogType.jsp";
	var param = "width_type="+widthtype+"&t="+now.getTime();
	commonAjaxRequest(url,param,function(){});
	/*
	var getTerms = new Ajax.Request(
		url,
		{
			method:'get',parameters:param
		}
	);
	*/
}
function addFavorite(){
	if (document.getElementById("enuriMenuFrame")){
		var addFavoriteFunction = document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document.getElementById("add_favorite").onclick.toString();
		var addFavoriteFunction1 = addFavoriteFunction.substring(0,addFavoriteFunction.indexOf("favoriteURL_NEW"));
		var varParam1 = addFavoriteFunction.substring(addFavoriteFunction.indexOf("favoriteURL_NEW")+17,addFavoriteFunction.indexOf(",",addFavoriteFunction.indexOf("favoriteURL_NEW"))-1) + "&_C_=41"
		var varParam2 = addFavoriteFunction.substring(addFavoriteFunction.indexOf(",",addFavoriteFunction.indexOf("favoriteURL_NEW"))+3, addFavoriteFunction.lastIndexOf("'") )
		//document.getElementById("enuriMenuFrame").contentWindow.favoriteURL_NEW(varParam1,varParam2)
		if (window.sidebar){ // 파폭
			window.sidebar.addPanel(param_text, param, "");
		}else if (document.all){ // IE
			window.external.AddFavorite(varParam1, varParam2);
		}else if (navigator.appName=="Netscape") { //크롬
			alert("확인을 누르시고 <Ctrl-D>를 사용하여 이 페이지를 즐겨찾기 하세요.");
		}
		insertLog(5022);
	}
}
function addBattang(){
	if (document.getElementById("enuriMenuFrame")){
		//document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document.frmFavorite.batang.value = "Y";
		document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.go_icon();
		//document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document.frmFavorite.batang.value = "";
		insertLog(5023);
	}
}
function today(pricelist){
	if (rec_zzim == "today" && document.getElementById('rb_recent_zzim').style.display != "none"){
		document.getElementById('rb_buttons').style.display="";
		document.getElementById('rb_recent_zzim').style.display = "none";
	}else{
		document.getElementById('div_inconv').style.display="none";
		if (typeof(pricelist) == "undefined"){
			if (document.getElementById("main_price_layer")){
				if (document.getElementById("main_price_layer").style.display != "none"){
					document.getElementById("main_price_layer").style.display = "none";
				}
				if (document.getElementById("main_price_layer_bar").style.display != "none"){
					document.getElementById("main_price_layer_bar").style.display = "none";
				}
			}
			if (document.getElementById("main_price_layer_info")){
				if (document.getElementById("main_price_layer_info").style.display != "none"){
					document.getElementById("main_price_layer_info").style.display = "none";
				}
			}
		}
		top.getGuide_Resent_ZzimCate(2,1,"");
		if (document.getElementById("simpleView")){
			if (document.getElementById("simpleView").className != "_hideClass"){
				insertLog(8448);
			}else{
				insertLog(5043);
			}
		}else{
			insertLog(5043);
		}


		if (document.getElementById("ifrmBeginnerFrame")){
			if (document.getElementById("ifrmBeginnerFrame").style.display != "none"){
				closeBeginnerDic();
			}
			if (document.getElementById("ifrmBeginnerFrame2").style.display != "none"){
				closeBeginnerDic2();
			}
		}

	}
}
function begGoogleShow(){
	insertLog(5155);

	var varDicLoc = $("ifrmBeginnerFrame").contentWindow.document.location.href
	if (varDicLoc.indexOf("kb_no=") >= 0){
		var kb_no = varDicLoc.substring(varDicLoc.indexOf("kb_no=")+6,varDicLoc.indexOf("&",varDicLoc.indexOf("kb_no=")+6))
		//document.getElementById("dicGoogleLayer").style.top = 90 + getBodyScrollTop() +"px";
		//document.getElementById("dicGoogleLayer").style.display = "";
		//document.getElementById("ifGoogle").src = "/include/IncGuideGoogleSearch_2010.jsp?kb_no="+kb_no+"&dic=y";
		var googleSearch1 = window.open("/include/IncGuideGoogleSearch_2010.jsp?kb_no="+kb_no+"&dic=y","guideGoogleSearch","width=688,height=650,left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=no,menubar=no");
		googleSearch1.focus();
	}


}
function changeDicType(type){
	$("beg_dic_btn").style.height = "20px";
	$("beg_dic_btn").style.backgroundImage="url("+var_img_enuri_com+"/2010/images/view/beg_tab01.gif)";
	$("beg_board_btn").style.height = "20px";
	$("beg_board_btn").style.backgroundImage="url("+var_img_enuri_com+"/2010/images/view/beg_tab02.gif)";
	$("beg_google").style.height = "20px";
	$("beg_google").style.backgroundImage="url("+var_img_enuri_com+"/2010/images/view/beg_tab03.gif)";
	if (type == "dic"){
		$("beg_dic_btn").style.height = "24px"
		$("beg_dic_btn").style.backgroundImage="url("+var_img_enuri_com+"/2010/images/view/beg_tab01_on.gif)";
	}else if(type == "bbs"){
		insertLog(5154);
		$("beg_board_btn").style.height = "22px";
		$("beg_board_btn").style.backgroundImage="url("+var_img_enuri_com+"/2010/images/view/beg_tab02_on.gif)";
	}else{
		insertLog(5155);
		var varDicLoc = $("ifrmBeginnerFrame").contentWindow.document.location.href
		if (varDicLoc.indexOf("kb_no=") >= 0){
			var kb_no = varDicLoc.substring(varDicLoc.indexOf("kb_no=")+6,varDicLoc.indexOf("&",varDicLoc.indexOf("kb_no=")+6))
			document.getElementById("dicGoogleLayer").style.top = 90 + getBodyScrollTop() +"px";
			document.getElementById("dicGoogleLayer").style.display = "";
			document.getElementById("ifGoogle").src = "/include/IncGuideGoogleSearch_2010.jsp?kb_no="+kb_no+"&dic=y";
		}
		return;
	}
	if (type == "bbs"){
		var varBtnTop = Position.cumulativeOffset($("beg_dic_btn"))[1] - 10;
		window.scrollTo(0,varBtnTop)
	}
	if (type == "dic"){
		$("ifrmBeginnerFrame").height = ($("ifrmBeginnerFrame").contentWindow.document.getElementById("dic_desc").offsetHeight ) + "px"
	}else{
		$("ifrmBeginnerFrame").height = ($("ifrmBeginnerFrame").contentWindow.document.getElementById("dic_desc").offsetHeight + 110 ) + "px"
	}
	var varDicLoc = $("ifrmBeginnerFrame").contentWindow.document.location.href
	if (varDicLoc.indexOf("&type") >= 0){
		varDicLoc = varDicLoc.substring(0,varDicLoc.indexOf("&type")+6) + type;
	}else{
		varDicLoc = varDicLoc + "&type=" + type;
	}
	$("ifrmBeginnerFrame").contentWindow.document.location.href = varDicLoc;
}

function getRbTop(){
	/*
	if ($("rz_num_2_on") || $("rz_num_3_on")){
		return RB_TOP;
	}else{
		return $("rb_recent_zzim").offsetHeight
	}
	*/
	var varAddInfo = 0;
	/*
	var varAddInfo = 15;
	if (document.getElementById("simpleView")){
		if (document.getElementById("simpleView").className != "_hideClass"){
			varAddInfo = 0;
		}
	}
	*/
	if (document.getElementById("rb_recent_zzim").style.display != "none"){
		return document.getElementById("rb_recent_zzim").offsetHeight + varAddInfo;
	}else{
		return RB_TOP + varAddInfo;
	}
}
function CmdGotoMall(type, cmd, vcode, modelno, price, url,cate,pl_no,imgurl){
	var varMoveTargetPage = "/move/Redirect.jsp";
	var w = window.screen.width;
	var h = screen.availHeight ;
 	if(navigator.userAgent.toLowerCase().indexOf("chrome")>0 && navigator.userAgent.toLowerCase().indexOf("edge")>0){ //win10+edge
 		h -= 150;
 	}
	var varTargetUrl = varMoveTargetPage+"?type="+type+"&cmd="+cmd+"&vcode="+vcode+"&modelno="+modelno+"&price="+price+"&pl_no="+pl_no+"&imgurl="+imgurl;
	//var k = window.open (varTargetUrl,"","width="+w+" height="+h+" top=0 left=0 toolbar=yes,location=yes,directories=yes,status=yes,scrollbars=yes,resizable=yes,menubar=yes,personalbar=yes");
	var k = window.open("/_pre_detail_.jsp", "_blank");
	k.location.href = varTargetUrl;
	k.focus();
	if(top.location.pathname.indexOf("view/Listmp3.jsp")>=0){
		insertLog(14955);
	}else if(top.location.pathname.indexOf("search/Searchlist.jsp")>=0){
		insertLog(14956);
	}
	return;

}
function fum(){

	var varChkModelNos = getCheckedModelNo();
	var fHeight=screen.availHeight;
	if(BrowserDetect.browser == "Chrome"){
		fHeight = fHeight - 60;
	}
 	if(navigator.userAgent.toLowerCase().indexOf("chrome")>0 && navigator.userAgent.toLowerCase().indexOf("edge")>0){ //win10+edge
 		fHeight -= 150;
 	}
	var fumWin = window.open("/view/include/insertCatalogDownProc.jsp?cmd=insert&modelnos="+varChkModelNos,"Fum","width=310,height="+fHeight+",left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=no,resizable=no,menubar=no");
	fumWin.focus();
}
function showOffToday(){
	insertLog(6029);
	fnSetCookie2010("copy_today","Y",7);
}
function showCateLayer(){
	if (document.URL.indexOf("/view/Sslist_2013.jsp") < 0 ){
		if(document.getElementById("catelayer")){
			if (document.getElementById("catelayer").style.display != "none"){
				document.getElementById("btn_arrow").src= var_img_enuri_com +"/images/view/detail/ingi/combo_btn.gif";
				document.getElementById("catelayer").style.display = "none";
			}else{
				document.getElementById("btn_arrow").src= var_img_enuri_com + "/images/view/detail/ingi/combo_x_btn.gif";
				document.getElementById("catelayer").style.display = "";
			}
		}
	}

}
function showPopularList(flag){
	var tdMObjs = $("popularListDiv").getElementsBySelector('td[class="mcate_rank"]');
	var tdSObjs = $("popularListDiv").getElementsBySelector('td[class="scate_rank"]');
	for (var i=0;i<tdMObjs.length;i++){
		if (flag == "M"){
			tdMObjs[i].style.display = "";
			tdSObjs[i].style.display = "none";
			$("catename").innerHTML = $("mcatename").innerHTML
			$("catecnt").innerHTML = $("mcatecnt").innerHTML
		}else{
			tdMObjs[i].style.display = "none";
			tdSObjs[i].style.display = "";
			$("catename").innerHTML = $("scatename").innerHTML
			$("catecnt").innerHTML = $("scatecnt").innerHTML
		}
	}
	$("catelayer").style.display = "none";
	$("btn_arrow").src= var_img_enuri_com + "/images/view/detail/ingi/combo_btn.gif";
}
function popOrderlist(){
	if(document.getElementById("orderListDiv")){
		var varLeft = 0;
		var varTop = 0;
		if (document.getElementById("popularListDiv") && document.getElementById("popularListDiv").style.display != "none"){
			varTop = document.getElementById("popularListDiv").offsetTop+50;
			varLeft = document.getElementById("popularListDiv").offsetLeft+80;
		}else{
			if (top.document.getElementById("searchListFrame")){
				varTop = Position.cumulativeOffset(top.document.getElementById("searchListFrame").contentWindow.document.getElementById("location"))[1];
				varTop = varTop + Position.cumulativeOffset(top.document.getElementById("searchListFrame"))[1];
				varLeft = 2;
			}else if(top.document.getElementById("enuriListFrame")){
				varTop = Position.cumulativeOffset(top.document.getElementById("enuriListFrame").contentWindow.document.getElementById("linemap"))[1];
				varTop = varTop + Position.cumulativeOffset(top.document.getElementById("enuriListFrame"))[1];
				varLeft = 2;
			}else if (top.document.getElementById("enuriMenuFrame")){
				varLeft = 2;
				if(top.document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document.getElementById("linemap")){
					varTop = Position.cumulativeOffset(top.document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document.getElementById("linemap"))[1];
					varTop = varTop + Position.cumulativeOffset(top.document.getElementById("enuriMenuFrame"))[1];
					varTop = varTop + Position.cumulativeOffset(top.document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame"))[1];
				}else{
					varTop = Position.cumulativeOffset(top.document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame"))[1]+80;
				}
			}
		}
		function ShowOrderInfoLayer(originalRequest){
			//document.getElementById("orderListDiv").innerHTML = originalRequest.responseText;
			if (libType() == "PR"){
	   	 		var tempResponse = originalRequest.responseText;
	    	}else{
	       		var tempResponse = originalRequest;
	   		}
			document.getElementById("orderListDiv").innerHTML = tempResponse;
			document.getElementById("orderListDiv").style.top = varTop + "px";
			document.getElementById("orderListDiv").style.left = varLeft + "px";
			document.getElementById("orderListDiv").style.display = "";
		}
		if(document.getElementById("orderListDiv").innerHTML==""){
			/*
			var url = "/include/ajax/AjaxOrderInfoLayer.jsp";
			var getRec = new Ajax.Request(
				url,
				{
					method:'get',onComplete:ShowOrderInfoLayer
				}
			);
			*/
			var url = "/include/ajax/AjaxOrderInfoLayer.jsp";
			commonAjaxRequest(url,"",ShowOrderInfoLayer);
		}else{
			document.getElementById("orderListDiv").style.top = varTop + "px";
			document.getElementById("orderListDiv").style.left = varLeft + "px";
			document.getElementById("orderListDiv").style.display = "";
		}
	}
}
function orderListClose() {
	top.document.getElementById("orderListDiv").style.display = "none";
}
function changeOrderLayer(){
	top.document.getElementById("orderLayer").style.display = "none";
	top.document.getElementById("popLayer").style.display = "";
}
function changePopLayer(){
	top.document.getElementById("popLayer").style.display = "none";
	top.document.getElementById("orderLayer").style.display = "";
}
function showMainPriceLayerInfo(){
	if (document.getElementById("main_price_layer_info")){
		if (document.getElementById("main_price_layer_info").style.display != "none"){
			document.getElementById("main_price_layer_info").style.display = "none";
		}else{
			if (document.getElementById("main_price_layer_info").innerHTML == ""){
				var varMainPriceInfo = "";
				varMainPriceInfo += "<img src=\""+var_img_enuri_com+"/2010/images/view/layer_111102.gif\" width=\"337\" height=\"124\" border=\"0\" usemap=\"#mainPriceInfoMap\" />";
				varMainPriceInfo += "<map name=\"mainPriceInfoMap\" id=\"mainPriceInfoMap\">";
				varMainPriceInfo += "<area shape=\"rect\" coords=\"318,4,333,19\" href=\"#\" onclick=\"document.getElementById('main_price_layer_info').style.display='none';return false;\" />";
				varMainPriceInfo += "</map>";
				document.getElementById("main_price_layer_info").innerHTML = varMainPriceInfo;
			}
			document.getElementById("main_price_layer_info").style.left = (document.getElementById("main_price_layer").offsetLeft+50)+"px";
			document.getElementById("main_price_layer_info").style.top = (document.getElementById("main_price_layer").offsetTop+20)+"px";
			document.getElementById("main_price_layer_info").style.display = "";
		}
	}
}
function notifyDic(kbno,cate,title,modelno){

	function ShowInConv(originalRequest){
		if (libType() == "PR"){
			document.getElementById("div_inconv").innerHTML = originalRequest.responseText;
    	}else{
    		document.getElementById("div_inconv").innerHTML = originalRequest;
   		}
		document.getElementById("div_inconv").style.top = (getBodyClientHeight() + getBodyScrollTop()  - 300) +"px";;
		document.getElementById("div_inconv").style.left = ($(".enuriBi").width() - 200) +"px";;
		document.getElementById("div_inconv").style.display = "";
		document.getElementById("rb_buttons").style.display="";
		document.getElementById("rb_recent_zzim").style.display='none';
	}

	var url = "/include/ajax/AjaxInconv.jsp";
	var param = "isdic=y&kbno="+kbno+"&cate="+cate+"&title="+title+"&type=3";
	if (typeof(modelno) != "undefined"){
		param += "&modelno="+modelno;
	}
	/*
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:ShowInConv
		}
	);
	*/
	commonAjaxRequest(url,param,ShowInConv);


}
function smart_cate(){
	function showBrandLayer(originalRequest){
		if (libType() == "PR"){
   	 		var tempResponse = originalRequest.responseText;
    	}else{
       		var tempResponse = originalRequest;
   		}
		top.document.getElementById("div_brand_list").innerHTML = tempResponse;
		top.document.getElementById("div_brand_list").style.top = Position.cumulativeOffset($("c_menu_div"))[1] +"px";;
		top.document.getElementById("div_brand_list").style.left = Position.cumulativeOffset($("c_menu_div"))[0] + $("c_menu_div").offsetWidth +"px";;
		top.document.getElementById("div_brand_list").style.display = "";
	}
	var url = "/include/ajax/AjaxGetBrand.jsp";
	var param = "from=_top";
	commonAjaxRequest(url,param,showBrandLayer);
	/*
	var getBrand = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:showBrandLayer
		}
	);
	*/
}
function reloadListPage(){
	var varNowUrl = document.URL;
	if (varNowUrl.indexOf("Listmp3.jsp") >= 0 || varNowUrl.indexOf("List.jsp") >= 0 || varNowUrl.indexOf("/view/Listprinter.jsp") >= 0){
		if (viewInLoadingBar._functionName == "getCountList"){
			document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.getCountList()
		}else if(viewInLoadingBar._functionName == "getCountInResult"){
			document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.getCountInResult(viewInLoadingBar._param1)
		}else if(viewInLoadingBar._functionName == "getSpecSearchCount"){
			document.getElementById("enuriMenuFrame").contentWindow.regetSpecSearchCount()
		}
	}else if(varNowUrl.indexOf("/fashion/Fashion_SubList.jsp") >= 0 || varNowUrl.indexOf("/fashion/clothes/") >= 0 || varNowUrl.indexOf("/fashion/Fashion_Masstige_SubList.jsp") >= 0 ||
		varNowUrl.indexOf("/view/fusion/Fusion.jsp") >= 0 || varNowUrl.indexOf("/view/fusion/Fusion_Masterpiece.jsp") >= 0 || varNowUrl.indexOf("/view/fusion/Fusion_Sub.jsp") >= 0 ||
		varNowUrl.indexOf("/view/fusion/Fusion_Scate.jsp") >= 0 || varNowUrl.indexOf("/view/fusion/Fusion_Brand_Sub.jsp") >= 0 || varNowUrl.indexOf("/fashion/brand/") >= 0 ){

	}else if(varNowUrl.indexOf("/search/Searchlist.jsp") >= 0 ){

	}

}
function hideRecentZzim(e){
	if(!e) var e = window.event;
	document.getElementById('rb_buttons').style.display="";
	document.getElementById('rb_recent_zzim').style.display = "none";
	try{
		selectedGetType = 0;
		e.cancelBubble = true;
		e.returnValue = false;
		if (e.stopPropagation) {
			e.stopPropagation();
			e.preventDefault();
		}
	}catch(e){}
}
function modifySimpleView() {
	var varFrmSimpleViewSrc = document.getElementById("frmSimpleView").src;
	if (varFrmSimpleViewSrc.indexOf("/toolbar/index.jsp") < 0 && varFrmSimpleViewSrc.indexOf("/sim/index.jsp") < 0){
		return;
	}

	var varFrmSimpleViewDoc = document.getElementById("frmSimpleView").contentWindow.document;
	var mousewheelevt=(/Firefox/i.test(navigator.userAgent))? "DOMMouseScroll" : "mousewheel" //FF doesn't recognize mousewheel as of FF3.x

	if (varFrmSimpleViewDoc.body.attachEvent){
		varFrmSimpleViewDoc.body.attachEvent("on"+mousewheelevt, simpleViewWheel)
	}else if (varFrmSimpleViewDoc.body.addEventListener){
		varFrmSimpleViewDoc.body.addEventListener(mousewheelevt, simpleViewWheel, false)
	}

	if (varFrmSimpleViewSrc.indexOf("/sim/index.jsp") >= 0){

		varFrmSimpleViewDoc.getElementById("mainCloseBtn").getElementsByTagName("a")[0].onclick = function(){
			hideSimpleView();
			insertLog(8436);
		}
		document.getElementById("svfTopborder").style.backgroundImage = "url('"+var_img_enuri_com+"/2012/toolbar/bg_similar_01_top.gif')";
		document.getElementById("svfTopborder").style.left = "0px";
		setTimeout(function(){var simpleViewObj = new SimpleView();simpleViewObj.hideFilter();},500);
		setTimeout(function(){modifySimilarityViewFunc();},2000);
		/*
		if(BrowserDetect.browser == "Chrome" || BrowserDetect.browser == "Safari") {
			var varAObj = varFrmSimpleViewDoc.getElementsByTagName("a");
			for (var ai=0;ai<varAObj.length;ai++){
				varAObj[ai].onclick = function(){
					return false;
				}
			}
		}
		*/
	}

	varFrmSimpleViewDoc.getElementById("defaultInfo").getElementsByTagName("span")[0].onclick = function(){
		hideSimpleView();
		insertLog(8436);
	}
	document.getElementById("frmSimpleView").contentWindow.viewMessageBox = function(){
		openShareMenu();
	}

	document.getElementById("frmSimpleView").contentWindow.moveMall = function(){
		var varMoveMallObj = document.getElementById("frmSimpleView").contentWindow.moveMall.arguments[0][0];
		var varModelNo = document.getElementById("frmSimpleView").contentWindow.modelno;
		var varCate = document.getElementById("frmSimpleView").contentWindow.strCate ;
		var varModelName = document.getElementById("frmSimpleView").contentWindow.modelName;

		simpleGotoMall(varMoveMallObj.getAttribute("plno"),varMoveMallObj.getAttribute("shopcode"),varModelNo,varCate,varModelName,varMoveMallObj.getAttribute("price"));
	}

	if(varFrmSimpleViewDoc.getElementById("toolbarNotice")) varFrmSimpleViewDoc.getElementById("toolbarNotice").style.display = "none";
	if (varFrmSimpleViewDoc.getElementById("goodsDetailWrap")){
		varFrmSimpleViewDoc.getElementById("goodsDetailWrap").style.marginBottom="50px";
	}
	if (varFrmSimpleViewDoc.getElementById("bbsWrap")){
		varFrmSimpleViewDoc.getElementById("bbsWrap").style.marginBottom="50px";
	}
	if (varFrmSimpleViewDoc.getElementById("menu1")){
		varFrmSimpleViewDoc.getElementById("menu1").onclick = function(){
			setSimpleViewCate("1");
			insertLog(8432);
		}
	}
	if (varFrmSimpleViewDoc.getElementById("menu11")){
		varFrmSimpleViewDoc.getElementById("menu11").onclick = function(){
			setSimpleViewCate("1");
			insertLog(8432);
		}
	}
	if (varFrmSimpleViewDoc.getElementById("menu2")){
		varFrmSimpleViewDoc.getElementById("menu2").onclick = function(){
			setSimpleViewCate("2");
			insertLog(8433);
		}
	}
	if (varFrmSimpleViewDoc.getElementById("menu3")){
		varFrmSimpleViewDoc.getElementById("menu3").onclick = function(){
			setSimpleViewCate("3");
			insertLog(8434);
		}
	}
	document.getElementById("svfTopborder").style.backgroundImage = "url('"+var_img_enuri_com+"/2012/toolbar/bg_goodsInfo_01.gif')";
	document.getElementById("svfTopborder").style.left = "1px";
	setTimeout(function(){var simpleViewObj = new SimpleView();simpleViewObj.hideFilter();},500);
	setTimeout(function(){modifySimpleViewFunc();},2000);

	if(BrowserDetect.browser == "Chrome" || BrowserDetect.browser == "Safari") {
		var varAObj = varFrmSimpleViewDoc.getElementsByTagName("a");
		for (var ai=0;ai<varAObj.length;ai++){
			if (varAObj[ai].parentElement.id != "defaultActionLinks"){
				varAObj[ai].onclick = function(){
					return false;
				}
			}
		}
	}
	if(document.getElementById("simple_blank")){
		$("#simple_blank").show();
	}else{
		var _varWidth = $(".enuriBi").width()+$("#simpleView").width()+5;
		var varSimpleBlank = document.createElement("DIV");
		varSimpleBlank.id = "simple_blank";
		varSimpleBlank.style.position = "absolute";
		varSimpleBlank.style.top = "0px";
		varSimpleBlank.style.left = "0px";
		varSimpleBlank.style.width=_varWidth+"px";
		varSimpleBlank.style.height="1px";
		document.getElementById("wrap").insertBefore(varSimpleBlank,null);
	}
}
function modifySimpleViewFunc(){
	try{
		var varFrmSimpleViewDoc = document.getElementById("frmSimpleView").contentWindow.document;
		if (varFrmSimpleViewDoc.getElementById("defaultActionLinks")){
			var varDetailWinFunc = varFrmSimpleViewDoc.getElementById("defaultActionLinks").getElementsByTagName("a")[0].onclick;
			varFrmSimpleViewDoc.getElementById("defaultActionLinks").getElementsByTagName("a")[0].onclick = function(){
				varDetailWinFunc();
				insertLog(8438);
				return false;
			}
		}
		if (varFrmSimpleViewDoc.getElementById("scrollDown")){
			varFrmSimpleViewDoc.getElementById("scrollDown").onclick = function(){
				insertLog(8446);
			}
		}
		if (varFrmSimpleViewDoc.getElementById("scrollUp")){
			varFrmSimpleViewDoc.getElementById("scrollUp").onclick = function(){
				insertLog(8445);
			}
		}
		if (varFrmSimpleViewDoc.getElementById("scrollTop")){
			varFrmSimpleViewDoc.getElementById("scrollTop").onclick = function(){
				insertLog(8447);
			}
		}
		/*
		if (varFrmSimpleViewDoc.getElementById("frm_list")){
			varFrmSimpleViewDoc.getElementById("frm_list").getElementsByTagName("a")[0].onclick = function(){
				varDetailWinFunc();
				insertLog(8493);
			}
		}
		*/
		if (varFrmSimpleViewDoc.getElementById("goodsPhoto")){
			varFrmSimpleViewDoc.getElementById("goodsPhoto").getElementsByTagName("img")[0].onclick = function(){
				insertLog(8437);
			}
		}

	}catch(e){
		if (typeof(modifySimpleViewFunc._cnt == "undefined")){
			modifySimpleViewFunc._cnt = 0;
		}
		if (modifySimpleViewFunc._cnt < 3){
			setTimeout(function(){modifySimpleViewFunc();},2000);
			modifySimpleViewFunc._cn++;
		}
	}
}
function modifySimilarityViewFunc(){
	try{
		var varFrmSimpleViewDoc = document.getElementById("frmSimpleView").contentWindow.document;
		if (varFrmSimpleViewDoc.getElementById("defaultActionLinks")){
			var varDetailWinFunc = varFrmSimpleViewDoc.getElementById("defaultActionLinks").getElementsByTagName("a")[0].onclick;
			varFrmSimpleViewDoc.getElementById("defaultActionLinks").getElementsByTagName("a")[0].onclick = function(){
				varDetailWinFunc();
				insertLog(8438);
			}
		}
		if (varFrmSimpleViewDoc.getElementById("scrollDown")){
			varFrmSimpleViewDoc.getElementById("scrollDown").onclick = function(){
				insertLog(8446);
			}
		}
		if (varFrmSimpleViewDoc.getElementById("scrollUp")){
			varFrmSimpleViewDoc.getElementById("scrollUp").onclick = function(){
				insertLog(8445);
			}
		}
		if (varFrmSimpleViewDoc.getElementById("scrollTop")){
			varFrmSimpleViewDoc.getElementById("scrollTop").onclick = function(){
				insertLog(8447);
			}
		}
		if (varFrmSimpleViewDoc.getElementById("frm_list")){
			varFrmSimpleViewDoc.getElementById("frm_list").getElementsByTagName("a")[0].onclick = function(){
				varDetailWinFunc();
				insertLog(8493);
			}
		}
		if (varFrmSimpleViewDoc.getElementById("goodsPhoto")){
			varFrmSimpleViewDoc.getElementById("goodsPhoto").getElementsByTagName("img")[0].onclick = function(){
				insertLog(8437);
			}
		}

	}catch(e){
		if (typeof(modifySimpleViewFunc._cnt == "undefined")){
			modifySimpleViewFunc._cnt = 0;
		}
		if (modifySimpleViewFunc._cnt < 3){
			setTimeout(function(){modifySimpleViewFunc();},2000);
			modifySimpleViewFunc._cn++;
		}
	}
}
function simpleViewWheel(e){
	var evt=window.event || e
    var delta=evt.detail? evt.detail*(-120) : evt.wheelDelta;
    //showLog(delta);

    if (delta < 0){
    	document.getElementById("frmSimpleView").contentWindow.pageScroll("down", 60);
    }else{
    	document.getElementById("frmSimpleView").contentWindow.pageScroll("up", 60);
    }
	try{
		e.cancelBubble = true;
		e.returnValue = false;
		if (e.stopPropagation) {
			e.stopPropagation();
			e.preventDefault();
		}
	}catch(e){}
}
function changeRecentZzim(type){
	if (type == 1){ //요약보기 닫을때
		RB_BUTTONS_HEIGHT = 81+45;
		RB_TOP = 509;
		document.getElementById("rb_buttons").className = "rb_buttons1";
	}else if(type == 2){ //요약보기 펼칠때
		RB_BUTTONS_HEIGHT = 50+45;
		RB_TOP = 509;
		document.getElementById("rb_buttons").className = "rb_buttons2";
	}
	if(!(BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6)) {
		if (BrowserDetect.OS == "iPad" && BrowserDetect.browser == "Safari"){
			document.getElementById("rb_buttons").style.top = setRbButtonsTopPositionIPad();
		}else{
			setTimeout(function(){
				if(document.getElementById("rb_buttons")){
					document.getElementById("rb_buttons").style.top = setRbButtonsTopPosition();
				}
			},100);
		}
	}
}
function svCheck(modelno,tp){
	if (svCheck.addModelNos){
		var varSameModelNo = (svCheck.addModelNos+"").indexOf(modelno);
		if (varSameModelNo >= 0){
			svCheck.addModelNos.splice(varSameModelNo,1);
			svCheck.addModelType.splice(varSameModelNo,1);
			document.getElementById("sv_"+modelno).src = "http://img.enuri.info/images/main/2015/hp/check2.gif"
		}else{
			svCheck.addModelNos[svCheck.addModelNos.length] = modelno;
			svCheck.addModelType[svCheck.addModelType.length] = tp;
			document.getElementById("sv_"+modelno).src = "http://img.enuri.info/images/main/2015/hp/check2_on.gif"
		}
	}else{
		svCheck.addModelNos = new Array();
		svCheck.addModelType = new Array();
		svCheck.addModelNos[0] = modelno;
		svCheck.addModelType[0] = tp;
		document.getElementById("sv_"+modelno).src = "http://img.enuri.info/images/main/2015/hp/check2_on.gif"
	}

	var posLeft1 = $("#sv_"+modelno).offset().left;
	var posTop1 = $("#sv_"+modelno).offset().top;
	var posLeft2 = $("#rb_recent_zzim").position().left;
	var posTop2 = $("#rb_recent_zzim").position().top;
	document.getElementById("bigyoBtnDiv").style.left = (posLeft1-posLeft2-5)+"px";
	document.getElementById("bigyoBtnDiv").style.top = (posTop1-posTop2-25- getBodyScrollTop())+"px";
	document.getElementById("bigyoBtnDiv").style.display = "";

	if(!e) var e = window.event;
	try{
		e.cancelBubble = true;
		e.returnValue = false;
		if (e.stopPropagation) {
			e.stopPropagation();
			e.preventDefault();
		}
	}catch(e){}
}
function nvCheck(modelno,tp){
	if (nvCheck.addModelNos){
		var varSameModelNo = (nvCheck.addModelNos+"").indexOf(modelno);
		if (varSameModelNo >= 0){
			nvCheck.addModelNos.splice(varSameModelNo,1);
			nvCheck.addModelType.splice(varSameModelNo,1);
			document.getElementById("nv_"+modelno).src = "http://img.enuri.info/images/main/2015/hp/check2.gif"
		}else{
			nvCheck.addModelNos[nvCheck.addModelNos.length] = modelno;
			nvCheck.addModelType[nvCheck.addModelType.length] = tp;
			document.getElementById("nv_"+modelno).src = "http://img.enuri.info/images/main/2015/hp/check2_on.gif"
		}
	}else{
		nvCheck.addModelNos = new Array();
		nvCheck.addModelType = new Array();
		nvCheck.addModelNos[0] = modelno;
		nvCheck.addModelType[0] = tp;
		document.getElementById("nv_"+modelno).src = "http://img.enuri.info/images/main/2015/hp/check2_on.gif"
	}
	//var posLeftTop = Position.cumulativeOffset($("nv_"+modelno));
	//var posLeftTop2 = Position.cumulativeOffset($("rb_recent_zzim"));
	var posLeft1 = $("#nv_"+modelno).offset().left;
	var posTop1 = $("#nv_"+modelno).offset().top;
	var posLeft2 = $("#rb_recent_zzim").position().left;
	var posTop2 = $("#rb_recent_zzim").position().top;
	document.getElementById("bigyoBtnDiv").style.left = (posLeft1-posLeft2-5)+"px";
	document.getElementById("bigyoBtnDiv").style.top = (posTop1-posTop2-25 - getBodyScrollTop())+"px";
	document.getElementById("bigyoBtnDiv").style.display = "";

	if(!e) var e = window.event;
	try{
		e.cancelBubble = true;
		e.returnValue = false;
		if (e.stopPropagation) {
			e.stopPropagation();
			e.preventDefault();
		}
	}catch(e){}
}
function goSvResentBigyo(){
	var varCompareModelNo = "";
	var varCompareModelCnt = 0;
	var varAddModelNo = nvCheck.addModelNos;
	var varAddModelType = nvCheck.addModelType;
	//if (document.getElementById("simpleView")){
	//	if (document.getElementById("simpleView").className != "_hideClass"){
			varAddModelNo = svCheck.addModelNos;
			varAddModelType = svCheck.addModelType;
	//	}
	//}
	if (varAddModelNo){
		for (var i=0;i<varAddModelNo.length;i++){
			/*
			if (varAddModelType[i] == "G"){
				varCompareModelNo += varAddModelNo[i]+",";
				varCompareModelCnt++;
			}
			*/
			varCompareModelNo += varAddModelType[i] + ":" + varAddModelNo[i]+",";
			varCompareModelCnt++;
		}
	}
	if (varCompareModelCnt > 1){
		varCompareModelNo = varCompareModelNo.substring(0,varCompareModelNo.length-1);
		varCompareModelNo = varCompareModelNo.split("G:").join("");
		var compareMultiWin = window.open("/view/Comparemulti.jsp?chkNo="+varCompareModelNo,"Comparemulti","width=700,height=600,left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=yes,resizable=yes,menubar=no");
		compareMultiWin.focus();

	}else{
		alert("2개 이상 선택하셔야 비교할 수 있습니다.")
	}
	insertLog(8452);

}
function deleteSvCheckedModels(type,page){
	var varDeleteSvModel = "";
	var varAddModelNo = nvCheck.addModelNos;
	var varAddModelType = nvCheck.addModelType;
	//if (document.getElementById("simpleView")){
		//if (document.getElementById("simpleView").className != "_hideClass"){
			varAddModelNo = svCheck.addModelNos;
			varAddModelType = svCheck.addModelType;
		//}
	//}
	if (varAddModelNo){
		for (var i=0;i<varAddModelNo.length;i++){
			varDeleteSvModel = varDeleteSvModel + varAddModelType[i] + ":" + varAddModelNo[i]+ ",";
		}
	}
	if (varDeleteSvModel.length > 0){
		varDeleteSvModel = varDeleteSvModel.substring(0,varDeleteSvModel.length-1);
	}
	var varTbln = "";
	if (type == "r"){
		varTbln = "today"
	}else{
		varTbln = "save"
	}

	var url = "/view/deleteSaveGoodsProc.jsp";
	var param = "modelnos="+varDeleteSvModel+"&tbln="+varTbln;
	function showDeleteInfo(originalRequest) {
		reloadFlag = true;
		if(varTbln=="today") getGuide_Resent_Zzim(2, page);
		if(varTbln=="save") getGuide_Resent_Zzim(3, page);
	}
	commonAjaxRequest(url,param,showDeleteInfo);
	/*
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:showDeleteInfo
		}
	);
	*/

	insertLog(8453);

}
function isLoadedSimpleView(){
	var varReturn = false;
	if (typeof (SimpleView) != "undefined"){
		var simpleViewObj = new SimpleView();
		if (simpleViewObj.viewState){
			varReturn = true;
		}
	}
	return varReturn;
}
//CmdGotoMall(type, cmd, vcode, modelno, price, url,cate,pl_no,imgurl,addsearch)
//CmdGotoMall('ex','move_"+intPlNo+"','"+intShopCode+"','"+intPlNo+"','"+lngPrice+"','"+strUrl+"','"+strPCa_Code+"','"+intPlNo+"','"+strImgUrl
//var varTargetUrl = strMoveTargetUrl+"?type="+type+"&cmd="+cmd+"&vcode="+vcode+"&modelno="+modelno+"&price="+price+"&pl_no="+pl_no+"&imgurl="+imgurl+"&ads="+addsearch;
function simpleGotoMall(plno,vcode,modelno,cate,modelnm,price){
	if (plno != null && plno != "" && typeof(plno) != "undefined"){
		//===================로그 분석================================================================================
		try{
			document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow._trk_flashEnvView("_TRK_PI=ODR","_TRK_OP="+modelnm+"","_TRK_OA="+price,"_TRK_OE=1");
		} catch (e){}
		var w = window.screen.width;
		var h = screen.availHeight;
		var strMoveTargetUrl = "/move/Redirect.jsp";
		var varTargetUrl = strMoveTargetUrl+"?cmd=move_link&from=detail&cmd=move_"+plno+"&vcode="+vcode+"&modelno="+modelno+"&pl_no="+plno+"&cate="+cate;
		var k = window.open("/_pre_detail_.jsp", "_blank");
		k.location.href = varTargetUrl;
		k.focus();
		insertLog(14958);
	}
}
function showDiagram(kb_no,modelno,cate){
	/*
	if (document.getElementById("enuriMenuFrame")){
		document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.getBeginnerDic(kbno,modelno,cate,false)
	}else if (document.getElementById("searchListFrame")){
		document.getElementById("searchListFrame").contentWindow.getBeginnerDic(kbno,modelno,cate,false)
	}
	*/
	var getBeginnerDicFunc;
	if (document.getElementById("enuriMenuFrame")){
		getBeginnerDicFunc = document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.getBeginnerDic;
	}else if (document.getElementById("searchListFrame")){
		getBeginnerDicFunc = document.getElementById("searchListFrame").contentWindow.getBeginnerDic;
	}

	var mileObj = new Date();
	var strUrl = "/include/IncBeginnerDic_2010.jsp?kb_no="+kb_no+"&modelno="+modelno+"&cate="+cate+"&t="+mileObj.getMilliseconds();
	document.getElementById("ifrmBeginnerFrame").src = strUrl;


	//$("div_beginnerFrame").style.left = "410px";
	//$("div_beginnerFrame").style.top = (417+getBodyScrollTop())+"px";
	document.getElementById("div_beginnerFrame").style.left = (document.getElementById("wrap").offsetWidth/2 - 232)+"px"
	document.getElementById("div_beginnerFrame").style.top = 	(getBodyScrollTop() + getBodyClientHeight()/2 - 110) +"px";
	document.getElementById("div_beginnerFrame").style.display = "";
	getBeginnerDicFunc._kb_no = kb_no;

}
function adultReload(){
	if (document.URL.indexOf("/view/List.jsp") >= 0 || document.URL.indexOf("/view/Listmp3.jsp") >= 0  || document.URL.indexOf("/view/Listhandphone.jsp") >= 0 || document.URL.indexOf("/view/Listprinter.jsp") >= 0 ){
		document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.pageReload();
	}else if(document.URL.indexOf("/search/Searchlist.jsp") >= 0){
		document.getElementById("searchListFrame").contentWindow.pageReload();
	}
}
function resentZzimOpen(listType) {
 	var sheight = eval(screen.height);
 	if(navigator.userAgent.toLowerCase().indexOf("chrome")>0 && navigator.userAgent.toLowerCase().indexOf("edge")>0){ //win10+edge
 		sheight -= 150;
 	}
	 var openUrl = "/view/resentzzim/resentzzimList.jsp?listType="+listType;
	 var resentZzimWin = window.open(openUrl,"resentZzimWin","width=804,height="+sheight+",left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
	 resentZzimWin.focus();
}
function showEbaySponsorGoodsImg(k){
	if (document.URL.indexOf("/search/Searchlist.jsp") >= 0){
		if (document.getElementById("searchListFrame").contentWindow.document.getElementById("ebayOrgImg_"+k).src != "http://img.enuri.info/images/blank.gif"){
			var varLeft = Position.cumulativeOffset(top.document.getElementById("searchListFrame").contentWindow.document.getElementById("ebayImg_"+k))[0];
			var varTop = Position.cumulativeOffset(top.document.getElementById("searchListFrame").contentWindow.document.getElementById("ebayImg_"+k))[1];
			document.getElementById("searchListFrame").contentWindow.document.getElementById("ebayOrgImg_"+k).style.left = (varLeft-55)+"px";
			document.getElementById("searchListFrame").contentWindow.document.getElementById("eBayOrgImgBorderLayer_"+k).style.left = (varLeft-55)+"px";

			document.getElementById("searchListFrame").contentWindow.document.getElementById("ebayOrgImg_"+k).style.top = (varTop- 25)+"px";
			document.getElementById("searchListFrame").contentWindow.document.getElementById("eBayOrgImgBorderLayer_"+k).style.top = (varTop-25)+"px";

			document.getElementById("searchListFrame").contentWindow.document.getElementById("ebayOrgImg_"+k).style.display = "";
			document.getElementById("searchListFrame").contentWindow.document.getElementById("eBayOrgImgBorderLayer_"+k).style.display = "";
		}
	}else{
		if (document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document.getElementById("ebayOrgImg_"+k).src != "http://img.enuri.info/images/blank.gif"){
			var varLeft = Position.cumulativeOffset(top.document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document.getElementById("ebayImg_"+k))[0];
			document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document.getElementById("ebayOrgImg_"+k).style.left = (varLeft-55)+"px";
			document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document.getElementById("eBayOrgImgBorderLayer_"+k).style.left = (varLeft-55)+"px";
			if (getBrowserName() == "msie7"){
				document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document.getElementById("ebayOrgImg_"+k).style.top = "5px";
				document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document.getElementById("eBayOrgImgBorderLayer_"+k).style.top = "5px";
			}
			document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document.getElementById("ebayOrgImg_"+k).style.display = "";
			document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame").contentWindow.document.getElementById("eBayOrgImgBorderLayer_"+k).style.display = "";
		}
	}

}
function epClose(){
	document.getElementById('inconv_txt').value='';
	document.getElementById('div_inconv').style.display='none'
}
function viewSearchLoadingBar(){
	document.getElementById("searchlist_loading").style.left = ($(".enuriBi").width()/2 - 150)+"px";
	var varTop = 300;
	if (document.getElementById("topBannerNew")){
		if(document.getElementById("topBannerNew").style.display != "none"){
			varTop += document.getElementById("topBannerNew").offsetHeight;
		}
	}

	document.getElementById("searchlist_loading").style.top = varTop+"px"
	document.getElementById("searchlist_loading").style.display = "";
	if (document.getElementById("searchlist_loading_bg")){
		document.getElementById("searchlist_loading_bg").style.width = $(".enuriBi").width()+"px"
		document.getElementById("searchlist_loading_bg").style.display = "";
	}
}
function viewSearchReloadingBar(){
	document.getElementById("searchlist_loading").style.display = "none";
	document.getElementById("searchlist_reloading").style.left = ($(".enuriBi").width()/2 - 131)+"px";
	var varTop = 300;
	if (document.getElementById("topBannerNew")){
		if(document.getElementById("topBannerNew").style.display != "none"){
			varTop += document.getElementById("topBannerNew").offsetHeight;
		}
	}
	document.getElementById("searchlist_reloading").style.top = varTop+"px"
	document.getElementById("searchlist_reloading").style.display = "";
	document.getElementById("searchlist_loading_filter").style.width = $(".enuriBi").width()+"px";
	document.getElementById("searchlist_loading_filter").style.height = (getBodyScrollHeight()-130)+"px";
	document.getElementById("searchlist_loading_filter").style.display = "";
}
function showCateSearchLoadingImg(){
	var varTop = 200;
	if (document.getElementById("topBannerNew")){
		if(document.getElementById("topBannerNew").style.display != "none"){
			varTop += document.getElementById("topBannerNew").offsetHeight;
		}
	}
	document.getElementById("img_cate_search_loading").style.left = ($(".enuriBi").width()/2 - 112)+"px";
	document.getElementById("img_cate_search_loading").style.top = varTop + "px";
	document.getElementById("img_cate_search_loading").style.display = "";
}
function viewInLoadingBar(funcName){
	if (funcName == "getSpecSearchCount"){
		var varWidth = 0;
		if (document.getElementById("wrap")){
			varWidth = document.getElementById("wrap").offsetWidth;
		}else{
			varWidth = document.body.offsetWidth;
		}
		var varTop = 230;
		if (document.getElementById("topBannerNew")){
			if(document.getElementById("topBannerNew").style.display != "none"){
				varTop += document.getElementById("topBannerNew").offsetHeight;
			}
		}
		document.getElementById("img_spec_search_loading").style.top = (varTop + getBodyScrollTop()) + "px"
		document.getElementById("img_spec_search_loading").style.left = (varWidth/2 - 112)+"px";
		document.getElementById("img_spec_search_loading").style.display = "";
	}
}
var libType = function(){
    var rtn = "";
    if (typeof(Prototype) != "undefined" ){
        rtn = "PR"
    }else if(typeof(jQuery) != "undefined"){
        rtn = "JQ"
    }
    return rtn;
}
function commonAjaxRequest(url,param,callback){
    if (libType() == "PR"){
        var getInstProd = new Ajax.Request(
            url,
            {
                method:'post',parameters:param,onComplete:callback
            }
        );
    }else if(libType() == "JQ"){
        $.ajax({
            type: "POST",
            url: url,
            data: param,
            success: function(result){
                callback(result);
            }
        });
    }
}

function commonAjaxRequest_async(url,param,callback){
    if (libType() == "PR"){
        var getInstProd = new Ajax.Request(
            url,
            {
                method:'post',parameters:param,onComplete:callback
            }
        );
    }else if(libType() == "JQ"){
        $.ajax({
            type: "POST",
            url: url,
            data: param,
            async: false,
            success: function(result){
                callback(result);
            }
        });
    }
}

function getBrowserTypeMenu() {
	var useragentMenu = navigator.userAgent;
    var trident = useragentMenu.match(/Trident\/(\d.\d)/i);
    var rtnValue = "";

    if(useragentMenu.toLowerCase().indexOf("safari")>-1) {
        rtnValue = "safari";
    }
    if(useragentMenu.toLowerCase().indexOf("firefox")>-1) {
        rtnValue = "firefox";
    }
    if(useragentMenu.toLowerCase().indexOf("chrome")>-1) {
        rtnValue = "chrome";
    }
    if(useragentMenu.toLowerCase().indexOf("msie 7.0")>-1) {
        rtnValue = "ie7";
    }
    if(trident != null && trident[1] == "4.0") {
        if(useragentMenu.toLowerCase().indexOf("msie 8.0")>-1) {
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
