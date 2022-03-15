var checkcategory_value = "";
function convertSpecialKeyword(keyword){
		
	keyword = replace2(keyword, "'");		
	keyword = replace2(keyword, "\"");				
    keyword = replace2(keyword, "^");
    //keyword = replace2(keyword, "&");
    keyword = replace2(keyword, "~");
    keyword = replace2(keyword, "!");
    keyword = replace2(keyword, "@");
    keyword = replace2(keyword, "$");
    keyword = replace2(keyword, "%");
    keyword = replace2(keyword, "*"); 
    keyword = replace2(keyword, "+");
    keyword = replace2(keyword, "=");
    keyword = replace2(keyword, "\\");
    keyword = replace2(keyword, "{");
    keyword = replace2(keyword, "}");
    keyword = replace2(keyword, "[");
    keyword = replace2(keyword, "]");
    //keyword = replace2(keyword, ":");
    keyword = replace2(keyword, ";");
    keyword = replace2(keyword, "/");
    keyword = replace2(keyword, "<");
    keyword = replace2(keyword, ">");
    //keyword = replace2(keyword, "."); 
    keyword = replace2(keyword, ",");
    keyword = replace2(keyword, "?");
    keyword = replace2(keyword, "(");
    keyword = replace2(keyword, ")");
    keyword = replace2(keyword, "'");
    keyword = replace2(keyword, "_");
    keyword = replace2(keyword, "-");
    keyword = replace2(keyword, "`");
    keyword = replace2(keyword, "|");
    keyword = replace2(keyword, ",");
	
    keyword = keyword.trim();		
	return keyword;
	
	function replace2(src, delWrd){
		var newSrc = "";
		for(var i=0;i<src.length;i++){
			if(src.charAt(i) == delWrd) {
				newSrc = newSrc + " ";
			}else{
				newSrc = newSrc + src.charAt(i);
			}			
		}
		return newSrc;
	}		

	return keyword;
}
function check2Hyphen(keyword){
	var bReturn = false;
	if (keyword.length >= 2){
		if (keyword.substring(1,2) == "-" || keyword.substring(1,2) == "_" || keyword.substring(1,2) == " "){
			bReturn = true;
		}
	}
	return bReturn;
}
function getKeywordObj(){
	if (varTargetPage == "/search/EnuriSearch.jsp"){
		if (document.getElementById("in_keyword")){
			return document.getElementById("in_keyword");
		}
	}else{
		if (document.getElementById("rec_keyword")){
			return document.getElementById("rec_keyword");
		}else{
			if (document.getElementById("in_keyword")){
				return document.getElementById("in_keyword")
			}else if(document.getElementById("keyword")){
				return document.getElementById("keyword");
			}		
		}
	}
}
function preCheckSearchKeyword(){
	//var varKeyword = getKeywordObj().value;
	if (document.getElementById("removesynonym")){
		if (document.getElementById("removesynonym").value == "Y" ){
			return true;
		}
	}
	var varKeyword = "";
	if (varTargetPage == "/search/EnuriSearch.jsp"){
		if (document.getElementById("in_keyword")){
			varKeyword = document.getElementById("in_keyword").value;
		}
	}else{
		if(document.getElementById("keyword")){
			varKeyword = document.getElementById("keyword").value;
		}
	}	
	varKeyword = convertSpecialKeyword(varKeyword);
	
	if(isExpKeyword(varKeyword)) {
		if (document.getElementById("in_keyword")){
			var varTop = Position.cumulativeOffset(document.getElementById("in_keyword"))[1];
		}else if(document.getElementById("keyword")){
			var varTop = Position.cumulativeOffset(document.getElementById("keyword"))[1];
		}
		
		showNoResultMsg(varTop);
		getKeywordObj().focus();
		return false
	}
	
	if (varKeyword.length < 2){
		if (!(varKeyword.length == 1 && varExpKeyWord.indexOf(varKeyword) >= 0 )){
			alert("2자 이상의 검색어를 넣으세요.\t\t\r\n\특수문자는 제외 됩니다.");
			getKeywordObj().focus();
			return false;	
		} else {
			return true;
		}
	}else{
		//getKeywordObj().value = varKeyword;
		return true;	
	}
}

function isExpKeyword(strKeyword) {
	var bReturn = false;

	/*
	#33351 검색 금지어 전체 삭제 2019.04.08, 최서진 선임 
	#35507 "수퍼굽 스킨 수딩 미네랄 선스크린" 외 15건 결과없음 처리 2019.08.19, jinwook 
	#35971 조개젓 관련 키워드 결과 없음 처리 2019.09.18. shwoo
	#36492 삼성 셀리턴 외 2019.10.23 jinwook
	*/
	
	 strKeyword = strKeyword.trim().replace( /(\s*)/g, "" ).toUpperCase();
	
	//단어 일치 할 경우 
	var strNoUseKwd = ["SKINSOOTHINGMINERALSUNSCREENSPF40","SOOTHINGMINERALSUNSCREENSPF40","수퍼굽스킨수딩미네랄선스크린SPF40"
	                   ,"수퍼굽스킨수딩미네랄선스크린","수퍼굽스킨수딩미네랄","수퍼굽스킨수딩","수퍼굽스킨","수퍼굽수딩","수퍼굽선스크린"
	                   ,"수퍼굽미네랄선스크린","수퍼굽수딩미네랄선스크린","AUSTRALIANGOLDLOTIONSUNSCREENSPF15"
	                   ,"오스트레일리안골드로션선스크린SPF15","오스트레일리안골드선스크린SPF15","CERAVESUNSCREENBODYLOTIONSPF30","세라베선스크린바디로션SPF30"
	                   ,"조개젓","조개젓갈","whrowjt","삼성셀리턴","삼성전자셀리턴","삼성LED마스크","삼성전자LED마스크"];

	//단어가 포함될 경우 
	var strNoUseContainKwd = ["조개젓","조개젓갈","whrowjt","삼성셀리턴","삼성전자셀리턴","삼성LED마스크","삼성전자LED마스크"];

	for(var i = 0; i < strNoUseKwd.length; i++){
		if (strNoUseKwd[i] == strKeyword.trim()){
			bReturn = true;
			break;
		}
	}
	
	if (!bReturn) {
		for(var i = 0; i < strNoUseContainKwd.length; i++){
			if (strKeyword.indexOf(strNoUseContainKwd[i]) > -1){
				bReturn = true;
				break;
			}
		}
	}
	return bReturn;
}

function getCountInResult(b_reckeyword){
	function callBackGetCountInResult(originalRequest){
		if (typeof(b_reckeyword) == "undefined"){
			eval("varCount = " + originalRequest.responseText);
			if (varCount.count == "-1"){
				top.hideLoadingBar();
				alert("현재 검색 시스템 점검 중입니다.\r\n\r\n최대한 빠른 시간 내에 정상화 되도록 최선을 다하겠습니다.	");	
			}else if (varCount.count == "0"){
				var varGbValue = "";	
				if (document.getElementById("gb1")){
					varGbValue = document.getElementById("gb1").value;
				}
				if (document.getElementById("gb2")){
					varGbValue = document.getElementById("gb2").value;
				}
				if (document.getElementById("brand_add_search")){
					if (document.getElementById("brand_add_search").value == "YY" ){
						varGbValue = "";
					}
				}

				if (varGbValue == ""){
					top.hideLoadingBar();
					if (document.getElementById("in_keyword")){
						var varTop = Position.cumulativeOffset(document.getElementById("in_keyword"))[1];
					}else if(document.getElementById("keyword")){
						var varTop = Position.cumulativeOffset(document.getElementById("keyword"))[1];
					}
					showNoResultMsg(varTop);
					getKeywordObj().focus();
				}else{
					document.getElementById("brand_add_search").value = "YY";
					getCountInResult();
				}
			}else{
				document.frmList.page.value="";
				/*if (varTargetPage == "/view/fusion/Fusion.jsp" || varTargetPage == "/view/fusion/Fusion_Masterpiece.jsp" || varTargetPage == "/fashion/Listbody_Brand_Main.jsp"
					|| varTargetPage == "/view/Listbody_Fusion.jsp" || varTargetPage == "/view/Listbody_Fusion_Masterpiece.jsp"
					|| varTargetPage == "/fashion/clothes/include/Listbody_Style.jsp"
					|| varTargetPage == "/fashion/brand/include/Listbody_Brand.jsp"){
					if (document.getElementById("in_keyword")){
						document.getElementById("in_keyword").value = convertSpecialKeyword(document.getElementById("in_keyword").value);
					}
				}else */if(varTargetPage == "/search/EnuriSearch.jsp"){
					document.getElementById("in_keyword").value = convertSpecialKeyword(document.getElementById("in_keyword").value);
					setResearchValue();
					document.frmList.keyword.value = convertSpecialKeyword(document.frmList.keyword.value);
				}else{	
					document.frmList.keyword.value = convertSpecialKeyword(document.frmList.keyword.value);
				}
				if (document.getElementById("brand_add_search") && document.getElementById("brand_add_search").value == "YY"){
					document.getElementById("brand_add_search").value = "Y";
				}				
				document.frmList.submit();
			}
		}else{
			eval("varCount = " + originalRequest.responseText);
			if (varCount.count == "-1"){
				alert("현재 검색 시스템 점검 중입니다.\r\n\r\n최대한 빠른 시간 내에 정상화 되도록 최선을 다하겠습니다.	");	
			}else{
				if (document.getElementById("keyword").value.trim().length > 0){
					document.getElementById("reckeyword_count").innerHTML = varCount.count.NumberFormat();
					document.getElementById("txt_rec_help").style.display = "none";
					document.getElementById("wrap_reckeyword_count").style.display = "";
					setKeywordValueStatus();
				}
			}			
			setRecKeyword._f_loading = false;
		}
	}
	if (preCheckSearchKeyword()){
		tabValueCheck();
		//var url = "/search/GetCountInResult.jsp";

		var url = "";
		var param = "";
		var ca_code = "";
		if (varTargetPage == "/view/Listbody.jsp" || varTargetPage == "/view/Listbody_Social.jsp" || varTargetPage == "/include/IncEcouponList.jsp"){
			url = "/search/GetCountList.jsp";
		}else if (varTargetPage == "/view/Listbody_Mp3.jsp"){
			url = "/search/GetCountListMp3.jsp";
		}else if (varTargetPage == "/view/Listbody_Social_2013.jsp"){
			url = "/search/GetCountListSocial.jsp";
		}else if (varTargetPage == "/view/Listbody_Handphone.jsp"){
			url = "/search/GetCountListMp3.jsp";
		}else if (varTargetPage == "/view/Listbody_Printer.jsp"){
			url = "/search/GetCountListPrinter.jsp";
		}else if (varTargetPage == "/search/EnuriSearch.jsp"){
			insertLog(5470);
			url = "/search/GetCountListSearch.jsp";
		}else if (varTargetPage == "/view/fusion/Fusion.jsp" || varTargetPage == "/view/Listbody_Fusion.jsp" || varTargetPage == "/fashion/brand/include/Listbody_Brand.jsp"
			|| varTargetPage == "/fashion/Listbody_Brand_Main.jsp"
		){
			url = "/search/GetCountListFusion.jsp";
		}else if (varTargetPage == "/view/fusion/Fusion_Masterpiece.jsp" || varTargetPage == "/view/Listbody_Fusion_Masterpiece.jsp"){
			url = "/search/GetCountListFusionMasterpiece.jsp";
		}else if (varTargetPage == "/fashion/clothes/include/Listbody_Style.jsp"){
			url = "/search/GetCountListClothes.jsp";
		}else if (varTargetPage == "/view/Listbody_NewBrand.jsp"){
			url = "/search/GetCountListBrand.jsp";
		}
		if (varTargetPage == "/view/fusion/Fusion.jsp" || varTargetPage == "/view/fusion/Fusion_Masterpiece.jsp" || varTargetPage == "/fashion/Listbody_Brand_Main.jsp"
			|| varTargetPage == "/view/Listbody_Fusion.jsp" || varTargetPage == "/view/Listbody_Fusion_Masterpiece.jsp"
			|| varTargetPage == "/fashion/clothes/include/Listbody_Style.jsp"
			|| varTargetPage == "/fashion/brand/include/Listbody_Brand.jsp"){
			
			if(varTargetPage == "/fashion/brand/include/Listbody_Brand.jsp"){
				insertLog(6570);
			}
			if(varTargetPage == "/fashion/clothes/include/Listbody_Style.jsp"){
				if(document.frmList.cate.value.substring(0,4) == "1471"){
					insertLog('6568');
				}else if(document.frmList.cate.value.substring(0,4) == "1472"){
					insertLog('6569');
				}
			}
			param = "cate="+document.frmList.cate.value;
			ca_code = document.frmList.cate.value;
		}else {
			param = "cate="+document.getElementById("cate").value;
			ca_code = document.getElementById("cate").value;
		}
		if(document.getElementById("factory")){
			param = param + "&factory="+document.getElementById("factory").value.replace(/&/g,"%26").replace(/#/g,"%23");
		}
		if(document.getElementById("brand")){
			param = param + "&brand="+document.getElementById("brand").value.replace(/&/g,"%26").replace(/#/g,"%23");
		}
		if (varTargetPage == "/view/fusion/Fusion_Masterpiece.jsp"
			 || varTargetPage == "/view/Listbody_Fusion_Masterpiece.jsp"){
			param = param + "&glname="+document.getElementById("glname").value.replace(/&/g,"%26").replace(/#/g,"%23");
		}
		if (document.getElementById("m_price")){
			param = param + "&m_price="+document.getElementById("m_price").value;
		}
		if (document.getElementById("start_price") && document.getElementById("end_price")){
			param = param + "&start_price="+document.getElementById("start_price").value;
			param = param + "&end_price="+document.getElementById("end_price").value;
		}		
		if (document.getElementById("spec")){
			param = param + "&spec="+document.getElementById("spec").value;
		}			
		if (document.getElementById("sel_spec")){
			param = param + "&sel_spec="+document.getElementById("sel_spec").value;
		}
		if (document.getElementById("condi")){
			param = param + "&condi="+document.getElementById("condi").value;
		}
		if (document.getElementById("searchkind")){
			param = param + "&searchkind="+document.getElementById("searchkind").value;
		}		
		if (document.getElementById("shop_code")){
			param = param + "&shop_code="+document.getElementById("shop_code").value;
		}			
		if (varTargetPage == "/view/Listbody_Printer.jsp"){
			param = param + "&prtmodelno="+document.getElementById("prtmodelno").value;
		}		
		if (varTargetPage == "/view/fusion/Fusion.jsp" || varTargetPage == "/view/fusion/Fusion_Masterpiece.jsp" || varTargetPage == "/fashion/Listbody_Brand_Main.jsp"
			|| varTargetPage == "/view/Listbody_Fusion.jsp" || varTargetPage == "/view/Listbody_Fusion_Masterpiece.jsp"
			|| varTargetPage == "/fashion/clothes/include/Listbody_Style.jsp" || varTargetPage == "/fashion/brand/include/Listbody_Brand.jsp" ){
			if (document.getElementById("keyword")){
				param = param + "&keyword="+convertSpecialKeyword(document.getElementById("keyword").value).replace(/&/g,"%26").replace(/#/g,"%23");
				if (document.getElementById("keyword").value.trim().length != "" && typeof(b_reckeyword) == "undefined"){
					insertLog(5502);
					insertLogCate(5502,ca_code);
				}
			}
			if(document.getElementById("sub_cate")){
				param = param + "&sub_cate="+document.getElementById("sub_cate").value;
			}			
		}else if(varTargetPage == "/search/EnuriSearch.jsp"){
			if (isResearchStatus()){
				param = param + "&keyword="+convertSpecialKeyword(document.frmList.rekeyword.value).replace(/&/g,"%26").replace(/#/g,"%23");
			}else{
				param = param + "&keyword="+convertSpecialKeyword(document.frmList.keyword.value).replace(/&/g,"%26").replace(/#/g,"%23");	
			}	
			if (document.getElementById("in_keyword")){
				param = param + "&in_keyword="+convertSpecialKeyword(document.getElementById("in_keyword").value).replace(/&/g,"%26").replace(/#/g,"%23");
				if (document.getElementById("in_keyword").value.trim().length != "" && typeof(b_reckeyword) == "undefined"){
					insertLog(5502);
					insertLogCate(5502,ca_code);
				}
			}
			param = param + "&hyphen_2="+document.getElementById("hyphen_2").value;
			if (document.getElementById("search_area")){
				param = param + "&search_area="+document.getElementById("search_area").value;
			}						
			if (document.frmList.in_keyword.value != "" ){
				document.getElementById("prev_r").value = "";
			}					
		}else{
			param = param + "&keyword="+convertSpecialKeyword(document.getElementById("keyword").value).replace(/&/g,"%26").replace(/#/g,"%23");
			if (document.getElementById("keyword").value.trim().length != "" && typeof(b_reckeyword) == "undefined"){
				insertLog(5502);
				insertLogCate(5502,ca_code);
			}			
		}
		if (document.getElementById("brand2no")){
			param = param + "&brand2no="+document.getElementById("brand2no").value;
		}
		if (document.getElementById("brandcate")){
			param = param + "&brandcate="+document.getElementById("brandcate").value;
		}
		if (document.getElementById("brand")){
			param = param + "&brand="+document.getElementById("brand").value;
		}
		if (document.getElementById("gb1")){
			param = param + "&gb1="+document.getElementById("gb1").value;
		}
		if (document.getElementById("gb2")){
			param = param + "&gb2="+document.getElementById("gb2").value;
		}
		if (document.getElementById("gb1no")){
			param = param + "&gb1no="+document.getElementById("gb1no").value;
		}				
		if (document.getElementById("gb2no")){
			param = param + "&gb2no="+document.getElementById("gb2no").value;
		}		
		if (document.getElementById("page_enuri")){
			document.getElementById("page_enuri").value = "";
		}		
		var varCateAddTabSearch = false;
		if (document.getElementById("cate_add_tab_search")){
			if (document.getElementById("cate_add_tab_search").value == "Y" ){
				if (document.getElementById("brand_add_search").value == "Y" ){
					param = param + "&brand_add_search=Y";
					varCateAddTabSearch = true;
				}
			}
		}
		if (document.getElementById("brand_add_search") && !varCateAddTabSearch){
			if (document.getElementById("brand_add_search").value == "Y" ){
				param = param + "&brand_add_search=";
				document.getElementById("brand_add_search").value = "";
			}else if(document.getElementById("brand_add_search").value == "YY"){
				param = param + "&brand_add_search=Y";
				//document.getElementById("brand_add_search").value = "Y";
			}
		}	
		if (document.getElementById("removesynonym")){
			if (document.getElementById("removesynonym").value == "Y" ){
				param = param + "&removesynonym=Y";
			}
		}		
		if (typeof(b_reckeyword) == "undefined"){
			viewInLoadingBar("getCountInResult",b_reckeyword);
		}else{
			param = param + "&recsearch=Y";
		}
		if (document.getElementById("order_type")){
			param = param + "&order_type=all";
			document.frmList.order_type.value = "all"; 
		}	
		if(document.getElementById("brand").value !="" && document.getElementById("m_price").value !=""){
			insertLog(12916);
		}
		if(document.getElementById("factory").value !="" && document.getElementById("brand").value !=""){
			insertLog(12918);
		}
		if(document.getElementById("factory").value !="" && document.getElementById("brand").value !="" && document.getElementById("m_price").value !=""){
			insertLog(12917);
		}
		var getCount = new Ajax.Request(
			url,
			{
				method:'get',parameters:param,onComplete:callBackGetCountInResult
			}
		);
		return false;
	}else{
		return false;
	}
}

function checkFactory(idx){
	var varChecked = false;
	var varFactoryName = "";
	checkFactory._prev_idx = idx;
	if (typeof(checkFactory.value) == "undefined"){
		checkFactory.value = document.frmList.factory.value;
	}	
	if (document.getElementById("factorychk_"+idx).checked){
		document.getElementById("factory_name_"+idx).style.backgroundColor="#9dea9d";
		document.getElementById("factory_name_"+idx).style.color="#c70b09";
		varChecked = true;
	}else{
		var elements = document.getElementsByClassName('factory_name');
		for(var i=0, l=elements.length; i<l; i++){
			elements[i].style.backgroundColor = "#F9F9F9";
		}
		document.getElementById("factory_name_"+idx).style.backgroundColor="#f9f9f9";
		document.getElementById("factory_name_"+idx).style.color="#000000";
	}
	varFactoryName = document.getElementById("factorychk_"+idx).value;	
	if (document.getElementById("factorychk_"+idx).checked){
		var strSelectFactory = checkFactory.value;
		if (strSelectFactory != ""){
			checkFactory.value = strSelectFactory +","+document.getElementById("factorychk_"+idx).value;
		}else{
			checkFactory.value = document.getElementById("factorychk_"+idx).value;
		}	
	}else{
		var strSelectFactory = checkFactory.value;
		var astrSelectFactory = strSelectFactory.split(",");
		/*
		strSelectFactory = strSelectFactory.replace(","+document.getElementById("factorychk_"+idx).value,"");
		strSelectFactory = strSelectFactory.replace(document.getElementById("factorychk_"+idx).value+",","");
		strSelectFactory = strSelectFactory.replace(document.getElementById("factorychk_"+idx).value,"");
		*/
		var varL = astrSelectFactory.length;
		for (var i=0;i<varL;i++){
			if (astrSelectFactory[i] == document.getElementById("factorychk_"+idx).value){
				astrSelectFactory.splice(i,1)
			}
		}
		checkFactory.value = astrSelectFactory.toString();
	}
	setPositionFactoryGo();
	if (document.getElementById("hot_factory_layer")){
		dupCheckFactory(idx,varChecked,varFactoryName)
	}
	if (typeof(idx) != "undefined"){
		if (checkFactory.value != ""){
			document.getElementById("factorychk_all").checked = false;
		}else{
			//document.getElementById("factory_go").style.display = "none";
			//if (document.getElementById("hot_factory_go")){
			//	document.getElementById("hot_factory_go").style.display = "none";
			//}
		}
	}	
}
function dupCheckFactory(idx,checked,factoryName){
	var chkFactory
	if (idx < 4){
		chkFactory = $("factory_layer_inner").getElementsBySelector('input[class="chkbox"]');
	}else{
		chkFactory = $("hot_factory_layer").getElementsBySelector('input[class="chkbox"]');
	}
	for (i=0;i<chkFactory.length;i++){
		if (chkFactory[i].value == factoryName){
			if (chkFactory[i].checked != checked){
				if (checked){
					document.getElementById("factory_name_"+chkFactory[i].id.substring(11,chkFactory[i].id.length)).style.color="#c70b09";
					document.getElementById("factory_name_"+chkFactory[i].id.substring(11,chkFactory[i].id.length)).style.backgroundColor="#9dea9d";
				}else{
					document.getElementById("factory_name_"+chkFactory[i].id.substring(11,chkFactory[i].id.length)).style.color="#000000";
					document.getElementById("factory_name_"+chkFactory[i].id.substring(11,chkFactory[i].id.length)).style.backgroundColor="#f9f9f9";
				}
				chkFactory[i].checked = checked;
			}
		}
	}
}

function checkBrand(idx){
	var varChecked = false;
	var varBrandName = "";
	checkBrand._prev_idx = idx;
	if (typeof(checkBrand.value) == "undefined"){
		checkBrand.value = document.frmList.brand.value;
	}	
	if (document.getElementById("brandchk_"+idx).checked){
		document.getElementById("brand_name_"+idx).style.backgroundColor="#9dea9d";
		document.getElementById("brand_name_"+idx).style.color="#c70b09";
		varChecked = true;
	}else{
		document.getElementById("brand_name_"+idx).style.backgroundColor="#f9f9f9";
		document.getElementById("brand_name_"+idx).style.color="#000000";
	}
	varFactoryName = document.getElementById("brandchk_"+idx).value;	
	if (document.getElementById("brandchk_"+idx).checked){
		var strSelectBrand = checkBrand.value;
		if (strSelectBrand != ""){
			checkBrand.value = strSelectBrand +","+document.getElementById("brandchk_"+idx).value;
		}else{
			checkBrand.value = document.getElementById("brandchk_"+idx).value;
		}	
	}else{
		var strSelectBrand = checkBrand.value;
		var astrSelectBrand = strSelectBrand.split(",");
		var varL = astrSelectBrand.length;
		for (var i=0;i<varL;i++){
			if (astrSelectBrand[i] == document.getElementById("brandchk_"+idx).value){
				astrSelectBrand.splice(i,1)
			}
		}
		checkBrand.value = astrSelectBrand.toString();
	}
	setPositionBrandGo();
	if (document.getElementById("hot_brand_layer")){
		dupCheckBrand(idx,varChecked,varFactoryName)
	}
	if (typeof(idx) != "undefined"){
		if (checkBrand.value != ""){
			document.getElementById("brandchk_all").checked = false;
		}else{
			//document.getElementById("factory_go").style.display = "none";
			//if (document.getElementById("hot_factory_go")){
			//	document.getElementById("hot_factory_go").style.display = "none";
			//}
		}
	}	
}
function dupCheckBrand(idx,checked,brandName){
	var chkBrand
	if (idx < 4){
		chkBrand = $("brand_layer_inner").getElementsBySelector('input[class="chkbox"]');
	}else{
		chkBrand = $("hot_brand_layer").getElementsBySelector('input[class="chkbox"]');
	}
	for (i=0;i<chkBrand.length;i++){
		if (chkBrand[i].value == brandName){
			if (chkBrand[i].checked != checked){
				if (checked){
					document.getElementById("brand_name_"+chkBrand[i].id.substring(9,chkBrand[i].id.length)).style.color="#c70b09";
					document.getElementById("brand_name_"+chkBrand[i].id.substring(9,chkBrand[i].id.length)).style.backgroundColor="#9dea9d";
				}else{
					document.getElementById("brand_name_"+chkBrand[i].id.substring(9,chkBrand[i].id.length)).style.color="#000000";
					document.getElementById("brand_name_"+chkBrand[i].id.substring(9,chkBrand[i].id.length)).style.backgroundColor="#f9f9f9";
				}
				chkBrand[i].checked = checked;
			}
		}
	}
}
function spreadFactoryLayer(){
	if (spreadFactoryLayer._f_bOpen){
		spreadFactoryLayer._f_bOpen = false;
		if ( document.getElementById("factory_layer_inner")){
			document.getElementById("factory_layer_inner").style.overflowY="hidden";
			if (toggleFactoryLayer._f_height){
				document.getElementById("factory_layer_inner").style.height = toggleFactoryLayer._f_height+"px";		
			}else{
				document.getElementById("factory_layer_inner").style.height = document.getElementById("factory_layer_inner").scrollHeight+"px";
			}			
			if(document.getElementById("img_spread_factory")){
				document.getElementById("img_spread_factory").src = var_img_enuri_com+"/2014/list/tab/btn_hidden.gif";
			}
			
			if (BrowserDetect.browser == "Explorer" &&  BrowserDetect.version == 7){
				setTimeout(function(){
					document.getElementById("factory_layer").style.top = "-2px";
					document.getElementById("spread_factory").style.position = "absolute";
					document.getElementById("spread_factory").style.position = "relative";
				},100);
			}
		}					

		document.getElementById("close_factory_btn").style.left = (document.getElementById("factory_layer").offsetWidth - 20)+"px";
		if (varTargetPage == "/search/EnuriSearch.jsp"){
			insertLog(6019);
		}else{
			insertLog(6021);
		}		
		fnSetCookie2010("fts","y");
	}else{
		spreadFactoryLayer._f_bOpen = true;
		if (document.getElementById("factory_layer_inner")){
			if (document.getElementById("factory_layer_inner").offsetHeight > 170 ){
				document.getElementById("factory_layer_inner").style.overflowY="auto";
				document.getElementById("factory_layer_inner").style.height = 170+"px";
				toggleFactoryLayer._f_height = document.getElementById("factory_layer_inner").scrollHeight;				
				if (document.getElementById("hot_factory_layer")){
					document.getElementById("close_factory_btn").style.left = (document.getElementById("factory_layer").offsetWidth - 20)+"px";
				}else{
					document.getElementById("close_factory_btn").style.left = (document.getElementById("factory_layer").offsetWidth - 40)+"px";
				}
				if (document.getElementById("spread_factory")){
					document.getElementById("spread_factory").style.display = "";
				}			
				if(document.getElementById("img_spread_factory")){
					document.getElementById("img_spread_factory").src = var_img_enuri_com+"/2014/list/tab/btn_open.gif";
				}
			}
		}
		if (varTargetPage == "/search/EnuriSearch.jsp"){
			insertLog(6020);
		}else{
			insertLog(6022);
		}		
		/*
		if (document.getElementById("img_spread_tab") && document.getElementById("factory_layer_inner")){
			document.getElementById("img_spread_tab").src = var_img_enuri_com+"/2010/images/view//bt_open_tab_layer02.gif";
			if (document.getElementById("factory_layer_inner").offsetHeight > 170 ){
				toggleFactoryLayer._f_height = document.getElementById("factory_layer_inner").offsetHeight;
				document.getElementById("factory_layer_inner").style.overflowY="auto";
				document.getElementById("factory_layer_inner").style.height = 170+"px";
				if (document.getElementById("hot_factory_layer")){
					document.getElementById("close_factory_btn").style.left = (document.getElementById("factory_layer").offsetWidth - 20)+"px";
				}else{
					document.getElementById("close_factory_btn").style.left = (document.getElementById("factory_layer").offsetWidth - 40)+"px";
				}
			}
		}
		if (BrowserDetect.browser == "Explorer" && (BrowserDetect.version == 6 || BrowserDetect.version == 7)){
			setTimeout(function(){
				try{
					var varWidth = top.document.getElementById("wrap").offsetWidth;
					top.document.getElementById("wrap").style.width = varWidth-1+"px";
					top.document.getElementById("wrap").style.width = varWidth+"px";
					top.document.getElementById("wrap").style.setExpression("width", "setWidthWrap()")
				}catch(e){
				}
			},100);
		}
		*/		
		fnSetCookie2010("fts","n");
	}
	if (typeof(parent.syncHeightListFrame) =="function"){
		parent.syncHeightListFrame();
	}		
	/*
	if (top.document.body.scrollTop){
		top.document.body.scrollTop = "0px";
	}else{
		top.document.documentElement.scrollTop = "0px";
	}
	*/
	/*
	setTimeout(function(){
		document.getElementById("factory_go").style.display = "none";
		if (document.getElementById("hot_factory_go")){
			document.getElementById("hot_factory_go").style.display = "none";
		}
	},100);
	*/
	/*
	if (varTargetPage == "/view/Listbody_Fusion.jsp"){
		cmdFusionResize();
	}
	*/
}

function spreadBrandLayer(){
	if (spreadBrandLayer._f_bOpen){
		spreadBrandLayer._f_bOpen = false;
		if ( document.getElementById("brand_layer_inner")){
			document.getElementById("brand_layer_inner").style.overflowY="hidden";
			if (toggleBrandLayer._f_height){
				document.getElementById("brand_layer_inner").style.height = toggleBrandLayer._f_height+"px";		
			}else{
				document.getElementById("brand_layer_inner").style.height = document.getElementById("brand_layer_inner").scrollHeight+"px";
			}			
			if(document.getElementById("img_spread_brand")){
				document.getElementById("img_spread_brand").src = var_img_enuri_com+"/2014/list/tab/btn_hidden.gif";
			}
			
			if (BrowserDetect.browser == "Explorer" &&  BrowserDetect.version == 7){
				setTimeout(function(){
					document.getElementById("brand_layer").style.top = "-2px";
					document.getElementById("spread_brand").style.position = "absolute";
					document.getElementById("spread_brand").style.position = "relative";
				},100);
			}
		}					

		document.getElementById("close_brand_btn").style.left = (document.getElementById("brand_layer").offsetWidth - 20)+"px";
		if (varTargetPage == "/search/EnuriSearch.jsp"){
			insertLog(12933);
		}else{
			insertLog(12912);
		}		
		fnSetCookie2010("bts","y");
	}else{
		spreadBrandLayer._f_bOpen = true;
		if (document.getElementById("brand_layer_inner")){
			if (document.getElementById("brand_layer_inner").offsetHeight > 170 ){
				document.getElementById("brand_layer_inner").style.overflowY="auto";
				document.getElementById("brand_layer_inner").style.height = 170+"px";
				toggleBrandLayer._f_height = document.getElementById("brand_layer_inner").scrollHeight;				
				if (document.getElementById("hot_brand_layer")){
					document.getElementById("close_brand_btn").style.left = (document.getElementById("brand_layer").offsetWidth - 20)+"px";
				}else{
					document.getElementById("close_brand_btn").style.left = (document.getElementById("brand_layer").offsetWidth - 40)+"px";
				}
				if (document.getElementById("spread_brand")){
					document.getElementById("spread_brand").style.display = "";
				}			
				if(document.getElementById("img_spread_brand")){
					document.getElementById("img_spread_brand").src = var_img_enuri_com+"/2014/list/tab/btn_open.gif";
				}
			}
		}
		if (varTargetPage == "/search/EnuriSearch.jsp"){
			insertLog(12932);
		}else{
			insertLog(12913);
		}		
		
		fnSetCookie2010("bts","n");
	}
	if (typeof(parent.syncHeightListFrame) =="function"){
		parent.syncHeightListFrame();
	}		
}


function togglePriceLayer(isInit){
	setTabReset();
	if (document.getElementById("price_layer")){	
		if (document.getElementById("price_layer").innerHTML.trim() == ""){
			insertInitPriceTab();
			getTabLayer("price",isInit);
			return;
		}else{
			//if (document.getElementById("price_layer").style.display != "none" && !insertInitPriceTab._open){
			if (document.getElementById("price_layer").style.display != "none" ){
				
				document.getElementById("tab_price").src = var_img_enuri_com+"/2014/list/tab/price_tab"+getPriceTabName()+".gif";
				if (BrowserDetect.browser == "Explorer" &&  BrowserDetect.version == 7){
					setTimeout(function(){
						document.getElementById("price_layer").style.display = "none";
						if (document.getElementById("factory_layer") && document.getElementById("factory_layer").style.display != "none" ){
							toggleFactoryLayer();
							toggleFactoryLayer();
						}
						if (document.getElementById("shop_layer") && document.getElementById("shop_layer").style.display != "none" ){
							toggleShoppingLayer();
							toggleShoppingLayer();
						}						
					},100);	
				}else{
					document.getElementById("price_layer").style.display = "none";
				}
				
				fnSetCookie2010("pt","n");
			}else{
				document.getElementById("tab_price").src = var_img_enuri_com + "/2014/list/tab/price_tab_on.gif";
				document.getElementById("price_layer").style.display = "";
				if (typeof(varCate) != "undefined"){
					insertLogCate(82,varCate)
				}
				fnSetCookie2010("pt","y");
				fnSetCookie2010("ft","n");
				fnSetCookie2010("bt","n");
				fnSetCookie2010("st","n");
				if (varTargetPage == "/search/EnuriSearch.jsp"){
					if (document.getElementById("searchkind")){
						if (document.getElementById("searchkind").value == "1"){
							insertLog(5865);
						}else if(document.getElementById("searchkind").value == "2"){
							insertLog(5869);
						}else{
							insertLog(5861);
						}
					}
				}				
				//insertInitPriceTab._open = false;
			}
		}
	}
	toggleTabBorder();
	if (varTargetPage == "/view/Listbody_Fusion.jsp" || varTargetPage == "/view/Listbody_Fusion_Masterpiece.jsp" ||  varTargetPage == "/fashion/clothes/include/Listbody_Style.jsp"){
		cmdFusionResize();
	}
	
}
function getPriceTabName(){
	var varPriceTabName = "2";
	if (document.getElementById("tab_factory")){
		if (document.getElementById("tab_factory").parentElement.style.display != "none"){
			varPriceTabName = "";
		}
	}
	if (document.getElementById("tab_shop")){
		if (document.getElementById("tab_shop").parentElement.style.display != "none"){
			varPriceTabName = "";
		}
	}
	return varPriceTabName;
}
function getTabLayer(tabType,isInit){
	function callBackgetTabLayer(originalRequest){
		if (originalRequest.responseText.trim().length == 0){
			var varTabName = "";
			if (tabType == "price"){
				varTabName = "가격대";
			}else if (tabType == "condi"){
				varTabName = "조건명";
			}else if (tabType == "factory"){
				varTabName = "제조사";
			}else if (tabType == "brand"){
				varTabName = "브랜드";
			}else if (tabType == "shop"){
				varTabName = "쇼핑몰";
			}
			alert(varTabName + " 정보가 없습니다.");
			if (document.getElementById("img_tab_search_loading")){
				document.getElementById("img_tab_search_loading").style.display = "none";
			}						
			return;
		}
		if (tabType == "price"){
			document.getElementById("price_layer").innerHTML = originalRequest.responseText.trim();
			setTimeout(function(){
				togglePriceLayer();
			},100);	
			if (document.getElementById("enuri_price_cnt")){
				setTimeout(function(){
					if (document.getElementById("price_selected_cnt").innerHTML.trim() != "0"){
						document.getElementById("enuri_price_cnt").innerHTML = "("+document.getElementById("price_selected_cnt").innerHTML.NumberFormat()+"개)";
					}
					document.getElementById("loc_price").style.display = "";
					togglePriceLayer._txt_start_price = document.getElementById("txt_start_price").value;
					togglePriceLayer._txt_end_price = document.getElementById("txt_end_price").value;
				},100);			
			}
		}
		if (tabType == "factory"){
			document.getElementById("factory_layer").innerHTML = originalRequest.responseText.trim();
			toggleFactoryLayer();
			/*
			if (document.getElementById("loc_factory_cnt")){
				setTimeout(function(){
					document.getElementById("loc_factory_cnt").innerHTML = "("+document.getElementById("factory_selected_cnt").innerHTML.NumberFormat()+"개)";
					document.getElementById("loc_factory").style.display = "";
				},100);
			}
			*/									
		}
		if (tabType == "brand"){
			document.getElementById("brand_layer").innerHTML = originalRequest.responseText.trim();
			toggleBrandLayer();
		}
		if (tabType == "shop"){
			document.getElementById("shop_layer").innerHTML = originalRequest.responseText.trim();
			toggleShoppingLayer();
			if (document.getElementById("loc_shop")){
				setTimeout(function(){
					document.getElementById("loc_shop_name").innerHTML = document.getElementById("shop_selected_name").innerHTML;
					document.getElementById("loc_shop_cnt").innerHTML = "("+document.getElementById("shop_selected_cnt").innerHTML.NumberFormat()+"개)";
					document.getElementById("loc_shop").style.display = "";
				},100);
			}			
		}
		if (document.getElementById("img_tab_search_loading")){
			document.getElementById("img_tab_search_loading").style.display = "none";
		}
	}
	if (typeof(isInit) == "undefined" ){
		if (document.getElementById("img_tab_search_loading")){
			showTabLoadingImg();
		}
	}else if(isInit != "init"){
		if (document.getElementById("img_tab_search_loading")){
			showTabLoadingImg();
		}
	}
	var url = "/search/getTabLayer.jsp";
	var param = "";
	param = "tTy="+tabType;
	if (varTargetPage == "/view/fusion/Fusion.jsp" || varTargetPage == "/view/fusion/Fusion_Masterpiece.jsp" || varTargetPage == "/fashion/Listbody_Brand_Main.jsp"
		|| varTargetPage == "/view/Listbody_Fusion.jsp" || varTargetPage == "/view/Listbody_Fusion_Masterpiece.jsp"
		|| varTargetPage == "/fashion/clothes/include/Listbody_Style.jsp" || varTargetPage == "/search/EnuriSearch.jsp"
		|| varTargetPage == "/fashion/brand/include/Listbody_Brand.jsp"){
		param = param + "&cate="+document.frmList.cate.value;
	}else {
		param = param + "&cate="+document.getElementById("cate").value;
	}
	if(document.getElementById("factory")){
		param = param + "&factory="+document.getElementById("factory").value.replace(/&/g,"%26").replace(/#/g,"%23")
	}
	if(document.getElementById("brand")){
		param = param + "&brand="+document.getElementById("brand").value.replace(/&/g,"%26").replace(/#/g,"%23")
	}
	if (document.getElementById("brandcate")){
		param = param + "&brandcate="+document.getElementById("brandcate").value; 
	}
	if (!directPriceCheck._f_return){
		document.getElementById("start_price").value = "";
		document.getElementById("end_price").value = "";
	}
	param = param + "&start_price="+document.getElementById("start_price").value;
	param = param + "&end_price="+document.getElementById("end_price").value;
	param = param + "&m_price="+document.getElementById("m_price").value;
	if (document.getElementById("spec")){
		param = param + "&spec="+document.getElementById("spec").value;
	}	
	if (document.getElementById("sel_spec")){
		param = param + "&sel_spec="+document.getElementById("sel_spec").value;
	}
	if (document.getElementById("condi")){
		param = param + "&condi="+document.getElementById("condi").value;
	}
	if (document.getElementById("shop_code")){
		param = param + "&shop_code="+document.getElementById("shop_code").value;
	}
	if (varTargetPage == "/view/fusion/Fusion.jsp" || varTargetPage == "/view/fusion/Fusion_Masterpiece.jsp" || varTargetPage == "/fashion/Listbody_Brand_Main.jsp"
		|| varTargetPage == "/view/Listbody_Fusion.jsp" || varTargetPage == "/view/Listbody_Fusion_Masterpiece.jsp"
		|| varTargetPage == "/fashion/clothes/include/Listbody_Style.jsp"
		|| varTargetPage == "/fashion/brand/include/Listbody_Brand.jsp"){
		if (document.getElementById("orgkeyword")){
			param = param + "&keyword="+convertSpecialKeyword(document.getElementById("orgkeyword").value).replace(/&/g,"%26").replace(/#/g,"%23");
		}
		if(document.getElementById("sub_cate")){
			param = param + "&sub_cate="+document.getElementById("sub_cate").value;
		}		
	}else{	
		if (document.frmList.keyword.value.trim() != ""){
			if (varTargetPage == "/search/EnuriSearch.jsp"){
				if (isResearchStatus()){
					param = param + "&keyword="+convertSpecialKeyword(document.frmList.rekeyword.value).replace(/&/g,"%26").replace(/#/g,"%23");
				}else{
					param = param + "&keyword="+convertSpecialKeyword(document.frmList.keyword.value).replace(/&/g,"%26").replace(/#/g,"%23");	
				}	
			}else{
				if (document.frmList.okeyword.value.trim() != ""){
					document.frmList.keyword.value = document.frmList.okeyword.value;
					param = param + "&keyword="+convertSpecialKeyword(document.frmList.keyword.value).replace(/&/g,"%26").replace(/#/g,"%23");
				}
			}
		}else{
			if (document.getElementById("okeyword")){
				param = param + "&keyword="+convertSpecialKeyword(document.frmList.okeyword.value).replace(/&/g,"%26").replace(/#/g,"%23");
			}
		}
		if (varTargetPage == "/search/EnuriSearch.jsp"){
			param = param + "&hyphen_2="+document.getElementById("hyphen_2").value;
			if (document.getElementById("in_o_keyword")){
				param = param + "&in_keyword="+convertSpecialKeyword(document.getElementById("in_o_keyword").value).replace(/&/g,"%26").replace(/#/g,"%23");
			}			
			if (document.getElementById("search_area")){
				param = param + "&search_area="+document.getElementById("search_area").value;
			}						
		}else{
			param = param + "&hyphen_2="+check2Hyphen(document.frmList.keyword.value);
		}
	}
	if (document.getElementById("brand2no")){
		param = param + "&brand2no="+document.getElementById("brand2no").value;
	}
	if (document.getElementById("searchkind")){
		param = param + "&searchkind="+document.getElementById("searchkind").value;
	}
	if (document.getElementById("ismodelno")){
		param = param + "&ismodelno="+document.getElementById("ismodelno").value;
	}
	if (document.getElementById("brand")){
		param = param + "&brand="+document.getElementById("brand").value;
	}
	if (document.getElementById("gb1")){
		param = param + "&gb1="+document.getElementById("gb1").value;
	}
	if (document.getElementById("gb2")){
		param = param + "&gb2="+document.getElementById("gb2").value;
	}
	if (document.getElementById("gb1no")){
		param = param + "&gb1no="+document.getElementById("gb1no").value;
	}			
	if (document.getElementById("gb2no")){
		param = param + "&gb2no="+document.getElementById("gb2no").value;
	}
	if (document.getElementById("brand_add_search")){
		if (document.getElementById("brand_add_search").value == "Y" || document.getElementById("brand_add_search").value == "YY"){
			if (varTargetPage != "/view/Listbody_Social_2013.jsp"){
				param = param + "&brand_add_search=Y";
			}
		}
	}
	if (document.getElementById("removesynonym")){
		param = param + "&removesynonym="+document.getElementById("removesynonym").value;
	}
	if (document.getElementById("order_type")){
		var varform = document.select_form.order_type;
	    for (var i=0; i<varform.length; i++){ 
	        if (varform[i].checked){ 
	            var ckval = varform[i].value; 
	        } 
	    } 		
		param = param + "&order_type="+ckval;
	}	
	
	var getCount = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:callBackgetTabLayer
		}
	);
	
}
function hidePriceLayer(){
	if (document.getElementById("price_layer")){ 
		if(document.getElementById("tab_price")){                                                                                                           
			document.getElementById("tab_price").src = document.getElementById("tab_price").src.replace(/_on.gif/g,".gif")
		}
		document.getElementById("price_layer").style.display = "none";                                                   
	}
}

function toggleFactoryLayer(isInit){
	setTabReset();
	if (document.getElementById("factory_layer")){
		if (document.getElementById("factory_layer").innerHTML.trim() == ""){
			getTabLayer("factory",isInit);
			return;
		}else{	
			if (document.getElementById("factory_layer").style.display != "none"){
				if (document.getElementById("tab_factory").src.indexOf("factory_tab") >= 0){
					document.getElementById("tab_factory").src = var_img_enuri_com+"/2014/list/tab/factory_tab.gif";
				}else{
					document.getElementById("tab_factory").src = var_img_enuri_com+"/2014/list/tab/brand_tab.gif";
				}
				
				if(document.getElementById("cate").value.length >= 2){
					if(document.getElementById("cate").value.substring(0,2) == 93){
						document.getElementById("tab_factory").src = var_img_enuri_com+"/2014/list/tab/publisher_tab.gif";
					}
				}
				document.getElementById("factory_layer").style.display = "none";
				if (document.getElementById("spread_factory")){
					document.getElementById("spread_factory").style.display = "none";
				}
				fnSetCookie2010("ft","n")
			}else{
				if (document.getElementById("tab_factory").src.indexOf("factory_tab") >= 0){
					document.getElementById("tab_factory").src = var_img_enuri_com+"/2014/list/tab/factory_tab_on.gif";
				}else{
					document.getElementById("tab_factory").src = var_img_enuri_com+"/2014/list/tab/factory_tab_on.gif";
				}	
				
				if(document.getElementById("cate").value.length >= 2){
					if(document.getElementById("cate").value.substring(0,2) == 93){
						document.getElementById("tab_factory").src = var_img_enuri_com+"/2014/list/tab/publisher_tab_on.gif";
					}
				}
				document.getElementById("factory_layer").style.display = "";

				var varCloseBtnTop = Position.cumulativeOffset(document.getElementById("factory_layer_inner"))[1]- Position.cumulativeOffset(document.getElementById("factory_layer"))[1]; 
				if (document.getElementById("hot_factory_layer")){
					varCloseBtnTop = varCloseBtnTop - document.getElementById("hot_factory_layer").offsetHeight; 
				}							
				document.getElementById("close_factory_btn").style.top = (varCloseBtnTop+5)+"px";
				if (document.getElementById("factory_layer_inner").style.overflowY == "auto" ){
					if (document.getElementById("hot_factory_layer")){
						document.getElementById("close_factory_btn").style.left = (document.getElementById("factory_layer").offsetWidth - 20)+"px";
					}else{
						document.getElementById("close_factory_btn").style.left = (document.getElementById("factory_layer").offsetWidth - 40)+"px";
					}
				}else{
					document.getElementById("close_factory_btn").style.left = (document.getElementById("factory_layer").offsetWidth - 20)+"px";
				}
				if (document.getElementById("factory_layer_inner").offsetHeight < 27){
					document.getElementById("factory_layer_inner").style.height = "30px";
				}
				var varFactoryLogCate = "";			
				if (document.getElementById("cate")){
					varFactoryLogCate = document.getElementById("cate").value;
					if (varFactoryLogCate != ""){
						insertLogCate(83,varFactoryLogCate)					
					}else{
						insertLog(83);	
					}
				}	
				fnSetCookie2010("ft","y");
				fnSetCookie2010("bt","n");
				fnSetCookie2010("pt","n");
				fnSetCookie2010("st","n");
				if (varTargetPage == "/search/EnuriSearch.jsp"){
					if (document.getElementById("searchkind")){
						if (document.getElementById("searchkind").value == "1"){
							insertLog(5867);
						}else{
							insertLog(5863);
						}
					}
				}			
				spreadFactoryLayer._f_bOpen = false;
				spreadFactoryLayer();
			}
		}
		//console.log("fnGetCookie2010>>>>>>"+fnGetCookie2010("ft"));
	}
	toggleTabBorder();
	if (varTargetPage == "/view/Listbody_Fusion.jsp"){
		cmdFusionResize();
	}
}
function toggleBrandLayer(isInit){
	setTabReset();
	if (document.getElementById("brand_layer")){
		if (document.getElementById("brand_layer").innerHTML.trim() == ""){
			getTabLayer("brand",isInit);
			return;
		}else{	
			if (document.getElementById("brand_layer").style.display != "none"){
				if (document.getElementById("tab_brand").src.indexOf("brand_tab") >= 0){
					document.getElementById("tab_brand").src = var_img_enuri_com+"/2014/list/tab/brand_tab.gif";
				}else{
					document.getElementById("tab_brand").src = var_img_enuri_com+"/2014/list/tab/brand_tab.gif";
				}
				document.getElementById("brand_layer").style.display = "none";
				if (document.getElementById("spread_brand")){
					document.getElementById("spread_brand").style.display = "none";
				}
				fnSetCookie2010("bt","n")
			}else{
				if (document.getElementById("tab_brand").src.indexOf("brand_tab") >= 0){
					document.getElementById("tab_brand").src = var_img_enuri_com+"/2014/list/tab/brand_tab_on.gif";
				}else{
					document.getElementById("tab_brand").src = var_img_enuri_com+"/2014/list/tab/brand_tab_on.gif";
				}				
				document.getElementById("brand_layer").style.display = "";

				var varCloseBtnTop = Position.cumulativeOffset(document.getElementById("brand_layer_inner"))[1]- Position.cumulativeOffset(document.getElementById("brand_layer"))[1]; 
				if (document.getElementById("hot_brand_layer")){
					varCloseBtnTop = varCloseBtnTop - document.getElementById("hot_brand_layer").offsetHeight; 
				}							
				document.getElementById("close_brand_btn").style.top = (varCloseBtnTop+5)+"px";
				if (document.getElementById("brand_layer_inner").style.overflowY == "auto" ){
					if (document.getElementById("hot_brand_layer")){
						document.getElementById("close_brand_btn").style.left = (document.getElementById("brand_layer").offsetWidth - 20)+"px";
					}else{
						document.getElementById("close_brand_btn").style.left = (document.getElementById("brand_layer").offsetWidth - 40)+"px";
					}
				}else{
					document.getElementById("close_brand_btn").style.left = (document.getElementById("brand_layer").offsetWidth - 20)+"px";
				}
				if (document.getElementById("brand_layer_inner").offsetHeight < 27){
					document.getElementById("brand_layer_inner").style.height = "30px";
				}
				var varBrandLogCate = "";			
				if (document.getElementById("cate")){
					varBrandLogCate = document.getElementById("cate").value;
					if (varBrandLogCate != ""){
						insertLogCate(83,varBrandLogCate)					
					}else{
						insertLog(83);	
					}
				}	
				fnSetCookie2010("bt","y");
				fnSetCookie2010("ft","n");
				fnSetCookie2010("pt","n");
				fnSetCookie2010("st","n");
				if (varTargetPage == "/search/EnuriSearch.jsp"){
					if (document.getElementById("searchkind")){
						if (document.getElementById("searchkind").value == "1"){
							insertLog(5867);
						}else{
							insertLog(5863);
						}
					}
				}			
				spreadBrandLayer._f_bOpen = false;
				spreadBrandLayer();
			}
		}
	}
	toggleTabBorder();
	if (varTargetPage == "/view/Listbody_Fusion.jsp"){
		cmdFusionResize();
	}
}
function setTabReset(){
	if(document.getElementById("price_layer")){document.getElementById("price_layer").style.display = "none"};
	if(document.getElementById("factory_layer")){document.getElementById("factory_layer").style.display = "none"};
	if(document.getElementById("shop_layer")){document.getElementById("shop_layer").style.display = "none"};
	if(document.getElementById("brand_layer")){document.getElementById("brand_layer").style.display = "none"};
	if(document.getElementById("tab_price")){document.getElementById("tab_price").src = var_img_enuri_com+"/2014/list/tab/price_tab2.gif";}
	if(document.getElementById("tab_factory")){
		document.getElementById("tab_factory").src = var_img_enuri_com+"/2014/list/tab/factory_tab.gif";
		if(document.getElementById("cate").value.length >= 2){
			if(document.getElementById("cate").value.substring(0,2) == 93){
				document.getElementById("tab_factory").src = var_img_enuri_com+"/2014/list/tab/publisher_tab.gif";
			}
		}
	}
	if(document.getElementById("tab_shop")){document.getElementById("tab_shop").src = var_img_enuri_com+"/2014/list/tab/shopping_tab.gif";}
	if(document.getElementById("tab_brand")){document.getElementById("tab_brand").src = var_img_enuri_com+"/2014/list/tab/brand_tab.gif";}
	fnSetCookie2010("st","n");
	fnSetCookie2010("ft","n");
	fnSetCookie2010("bt","n");
	fnSetCookie2010("pt","n");
}
function setLayerWidthIE6(){
	return (document.getElementById("tab").offsetWidth-4)+"px";	
}
function hideFactoryLayer(){
	if (document.getElementById("factory_layer")){
		document.getElementById("tab_factory").src = document.getElementById("tab_factory").src.replace(/_on.gif/g,".gif")
		document.getElementById("factory_layer").style.display = "none";
	}
}
function toggleCategoryLayer(){
	if (document.getElementById("category_layer")){
		if (document.getElementById("category_layer").style.display != "none"){
			document.getElementById("category_layer").style.display = "none";
			if (document.getElementById("spread_category")){
				document.getElementById("spread_category").style.display = "none";
			}else{
				document.getElementById("spread_category_bottom").style.display = "none";
			}
			fnSetCookie2010("ct","n")
		}else{
			document.getElementById("category_layer").style.display = "";
			if (document.getElementById("spread_category")){
				document.getElementById("spread_category").style.display = "";
			}else{
				document.getElementById("spread_category_bottom").style.display = "";
			}
			fnSetCookie2010("ct","y")
		}
		if (varTargetPage == "/search/EnuriSearch.jsp"){
			if (document.getElementById("category_spread_tab")){
				document.getElementById("spread_category_bottom").style.display = "none";
				document.getElementById("category_spread_tab").style.display = "";
			}
		}		
	}
	//toggleTabBorder();
}

function toggleShoppingLayer(){
	setTabReset();
	if (document.getElementById("shop_layer")){
		if (document.getElementById("shop_layer").innerHTML.trim() == ""){
			getTabLayer("shop");
			return;
		}else{		
			if (document.getElementById("shop_layer").style.display != "none"){
				document.getElementById("tab_shop").src = var_img_enuri_com+"/2014/list/tab/shopping_tab.gif";
				document.getElementById("shop_layer").style.display = "none";
				fnSetCookie2010("st","n")
			}else{
				document.getElementById("tab_shop").src = var_img_enuri_com+"/2014/list/tab/shopping_tab_on.gif";
				document.getElementById("shop_layer").style.display = "";
				if (document.getElementById("shop_layer_inner").offsetHeight < 27){
					document.getElementById("shop_layer_inner").style.height = "30px";
				}
				var varCloseBtnTop = Position.cumulativeOffset(document.getElementById("shop_layer_inner"))[1]- Position.cumulativeOffset(document.getElementById("shop_layer"))[1]; 
				document.getElementById("close_shop_btn").style.top = (varCloseBtnTop+5)+"px";
				document.getElementById("close_shop_btn").style.left = (document.getElementById("shop_layer_inner").offsetWidth - 20)+"px";

				insertLog(4599);
				fnSetCookie2010("st","y");
				fnSetCookie2010("ft","n");
				fnSetCookie2010("bt","n");
				fnSetCookie2010("pt","n");
				if (varTargetPage == "/search/EnuriSearch.jsp"){
					insertLog(5871);
				}				
			}			
		}
	}
	toggleTabBorder();
}
function hideShoppingLayer(){
	if (document.getElementById("shop_layer")){
		document.getElementById("tab_shop").src = document.getElementById("tab_shop").src.replace(/_on.gif/g,".gif")
		document.getElementById("shop_layer").style.display = "none";
	}
}
function spreadCategoryLayer(){
	if (document.getElementById("div_sperad_button")){
		document.getElementById("div_sperad_button").style.display = "none";
	}
	if (spreadCategoryLayer._f_bOpen){
		spreadCategoryLayer._f_bOpen = false;
		if (document.getElementById("isc_open")){
			document.getElementById("isc_open").style.display = "";
		}
		if (document.getElementById("isc_hide")){
			document.getElementById("isc_hide").style.display = "none";
		}		
		if (document.getElementById("searchkind")){
			if (document.getElementById("searchkind").value == "1" || document.getElementById("searchkind").value == "2" || 
				(document.getElementById("stab_all").parentElement.style.display == "none" && document.getElementById("stab_enuri").parentElement.style.display == "none" ) || 
				(document.getElementById("stab_all").parentElement.style.display == "none" && document.getElementById("stab_web").parentElement.style.display == "none")){
				document.getElementById("category_layer_inner").style.height = "240px";
				document.getElementById("category_layer").style.height = "240px";		
				if (typeof(setPosGoodsDiv) == "function"){
					setPosGoodsDiv();
				}	
			}else{				
				var rec_category_layer_social_offset = 0;
				if (document.getElementById("rec_category_layer_social")){
					rec_category_layer_social_offset = document.getElementById("rec_category_layer_social").offsetHeight;
				}
				//console.log(rec_category_layer_social_offset);
				
				document.getElementById("category_layer_inner").style.height = (document.getElementById("rec_category_layer").offsetHeight + rec_category_layer_social_offset)+"px";
				document.getElementById("category_layer").style.height = (document.getElementById("rec_category_layer").offsetHeight + rec_category_layer_social_offset)+"px";
				setTimeout(function(){
					document.getElementById("category_layer_inner").style.height = (document.getElementById("rec_category_layer").offsetHeight + rec_category_layer_social_offset)+"px";
					document.getElementById("category_layer").style.height = (document.getElementById("rec_category_layer").offsetHeight + rec_category_layer_social_offset)+"px";
					if (typeof(setPosGoodsDiv) == "function"){
						setPosGoodsDiv();
					}
				},500);						
			}
		}				
		insertLog(6018); 
	}else{
		spreadCategoryLayer._f_bOpen = true;
		if (document.getElementById("isc_open")){
			document.getElementById("isc_open").style.display = "none";
		}
		if (document.getElementById("isc_hide")){
			document.getElementById("isc_hide").style.display = "";
		}		
		setTimeout(function(){
			var varCateLayerHeight = document.getElementById("category_layer_inner2").scrollHeight+5;
			document.getElementById("category_layer_inner").style.height = varCateLayerHeight+"px";
			document.getElementById("category_layer").style.height = varCateLayerHeight+"px";
			if (typeof(setPosGoodsDiv) == "function"){
				setPosGoodsDiv();
			}				
		},500);				
		insertLog(6017);		
	}
	if (typeof(parent.syncHeightListFrame) =="function"){
		setTimeout(function(){
			parent.syncHeightListFrame();	
		},1000);			
		
	}
	if (top.document.body.scrollTop){
		top.document.body.scrollTop = "0px";
	}else{
		top.document.documentElement.scrollTop = "0px";
	}

	showSpreadButton();
	/*
	if(BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6) {
		document.getElementById("category_layer_inner2").style.height = document.getElementById("category_layer_inner").offsetHeight;
	}
	*/	

}
function spreadAllTab(){
	if (spreadAllTab._f_bOpen){
		spreadAllTab._f_bOpen = false;
		if (spreadFactoryLayer._f_bOpen){
			spreadFactoryLayer();
		}
		if (spreadBrandLayer._f_bOpen){
			spreadBrandLayer();
		}
		if (spreadCategoryLayer._f_bOpen){
			spreadCategoryLayer();
		}
	}else{
		spreadAllTab._f_bOpen = true;
		if (document.getElementById("factory_layer")){
			if (document.getElementById("factory_layer").style.display != "none"){		
				if (typeof(spreadFactoryLayer._f_bOpen) == "undefined" || !spreadFactoryLayer._f_bOpen ){
					spreadFactoryLayer();
				}
			}
		}
		
		if (document.getElementById("brand_layer")){
			if (document.getElementById("brand_layer").style.display != "none"){		
				if (typeof(spreadBrandLayer._f_bOpen) == "undefined" || !spreadBrandLayer._f_bOpen ){
					spreadBrandLayer();
				}
			}
		}
	}
	if (typeof(parent.syncHeightListFrame) =="function"){
		parent.syncHeightListFrame();
	}	
	if (top.document.body.scrollTop){
		top.document.body.scrollTop = "0px";
	}else{
		top.document.documentElement.scrollTop = "0px";
	}	
}
function checkCategoryName(cate){
	if (document.getElementById("categorychk_"+cate).checked){
		document.getElementById("categorychk_"+cate).checked = false;
	}else{
		document.getElementById("categorychk_"+cate).checked = true;
	}	
	checkCategory(cate,true);
}
function checkCategory(cate,isName){
	/*
	checkCategory._prev_cate = cate;
	var varChecked = false;
	var chkCate = $("category_layer_inner").getElementsBySelector('input[class="chkbox"]');
	var chkSCate = $("scate_layer").getElementsBySelector('img');
	
	if (cate.length <= 4) {
		if (!document.getElementById("categorychk_"+cate).checked){
			if (cate.length == 2){
				document.getElementById("category_name_"+cate).className = "cl_ca_name";
			}else{
				document.getElementById("category_name_"+cate.substring(0,2)).className = "cl_ca_name";
				document.getElementById("categorychk_"+cate.substring(0,2)).checked = false;
			}
		}else{
			varChecked = true;
			if (cate.length == 2 ){
				if (document.getElementById("categorychk_"+cate).checked){
					var chkCate = $("category_layer_inner").getElementsBySelector('input[class="chkbox"]');
					for (i=0;i<chkCate.length;i++){
						if (chkCate[i].id.length == 16 && chkCate[i].id.substring(12,14) == cate){
							chkCate[i].checked = false;
							document.getElementById("category_name_"+chkCate[i].id.substring(12,16)).style.color="#000000";
						}
					}
				}		
			}else{
				if (document.getElementById("categorychk_"+cate).checked){
					for (i=0;i<chkCate.length;i++){
						if (chkCate[i].id  == ("categorychk_"+cate.substring(0,2)) ){
							chkCate[i].checked = false;
							document.getElementById("category_name_"+cate.substring(0,2)).className = "cl_ca_name";
						}
					}
				}		
			}
		}
	}else{
		if (document.getElementById("scate_check_"+cate)){
			if (document.getElementById("scate_check_"+cate).src == (var_img_enuri_com+"/2010/images/view/check.gif")){
				document.getElementById("scate_check_"+cate).src = var_img_enuri_com+"/2010/images/view/check_on.gif"
			}else{
				document.getElementById("scate_check_"+cate).src = var_img_enuri_com+"/2010/images/view/check.gif"
			} 
		}
		var temp_acheckcategory_value = checkcategory_value.split(",")
		for (i=0;i<temp_acheckcategory_value.length;i++){
			if (temp_acheckcategory_value[i].length == 6){
				document.getElementById("categorychk_"+temp_acheckcategory_value[i].substring(0,4)).checked = false;
				document.getElementById("div_category_name_"+temp_acheckcategory_value[i].substring(0,4)).style.color="#000000";			
			}
		}
	}
	
	var varCheckCount = 0;
	checkcategory_value = "";
	for (i=0;i<chkCate.length;i++){
		if (chkCate[i].id != "cate_all"){
			if (chkCate[i].checked){
				checkcategory_value = checkcategory_value + chkCate[i].value + ","
				varCheckCount++;
			}
		}
	} 	
	for (i=0;i<chkSCate.length;i++){
		if (chkSCate[i].src == (var_img_enuri_com+"/2010/images/view/check_on.gif")){
			checkcategory_value = checkcategory_value + chkSCate[i].id.substring(12,chkSCate[i].id.length) + ","
			varCheckCount++;		
		}
	}
	if (checkcategory_value.length > 0){
		checkcategory_value = checkcategory_value.substring(0,checkcategory_value.length-1);
	}

	if (typeof(isName) != "undefined"){
		if (varCheckCount == 1 && varChecked){
			categorySearch()
		}else{
			setPositionCategoryGo();
		}
	}else{
		setPositionCategoryGo();
	}
	*/
	if (cate.length <= 4){
		if (document.getElementById("div_category_name_"+cate)){
			document.getElementById("div_category_name_"+cate).style.color="#2482B3";
		}
	}else{
		if (document.getElementById("scate_check_name_"+cate)){
			document.getElementById("scate_check_name_"+cate).style.color="#C42B1A";
		}
	}
	
	checkcategory_value = cate;
	categorySearch();
	
}

function setPositionCategoryGo(){
	if (document.getElementById("category_layer")){
		if (document.getElementById("category_layer").style.display != "none"){
			if (typeof(checkCategory._prev_cate) != "undefined"){
				if (checkCategory._prev_cate.length <= 4){
					if (document.getElementById("categorychk_"+checkCategory._prev_cate)){
						var varCategoryGoLeft = Position.cumulativeOffset(document.getElementById("categorychk_"+checkCategory._prev_cate))[0];
						var varCategoryGoTop = Position.cumulativeOffset(document.getElementById("categorychk_"+checkCategory._prev_cate))[1] - Position.cumulativeOffset(document.getElementById("category_layer"))[1]+10 ;
						if ((document.getElementById("category_layer_inner").offsetHeight + document.getElementById("category_layer_inner").scrollTop )<= (varCategoryGoTop+15)){
							varCategoryGoTop = varCategoryGoTop - 35;
						}
						document.getElementById("category_go").style.top = varCategoryGoTop+"px";
						document.getElementById("category_go").style.left = varCategoryGoLeft+"px";
						document.getElementById("category_go").style.display = "";
					}
				}else{
					if (document.getElementById("scate_check_"+checkCategory._prev_cate)){
						if (document.getElementById("scate_layer").style.display != "none"){
							var varModLeft = 10;
							if (BrowserDetect.browser == "Explorer" & BrowserDetect.version == 6 ){
								varModLeft = 20;
							}						
							document.getElementById("scate_layer").style.left = (Position.cumulativeOffset(document.getElementById("div_category_name_"+checkCategory._prev_cate.substring(0,4)))[0]-varModLeft)+"px";
							document.getElementById("scate_layer").style.top = (Position.cumulativeOffset(document.getElementById("div_category_name_"+checkCategory._prev_cate.substring(0,4)))[1]-30)+"px";
							
							var varCategoryGoLeft = Position.cumulativeOffset(document.getElementById("scate_check_"+checkCategory._prev_cate))[0];
							var varCategoryGoTop = Position.cumulativeOffset(document.getElementById("scate_check_"+checkCategory._prev_cate))[1] - Position.cumulativeOffset(document.getElementById("category_layer"))[1]+10 ;
							if ((document.getElementById("category_layer_inner").offsetHeight + document.getElementById("category_layer_inner").scrollTop )<= (varCategoryGoTop+15)){
								varCategoryGoTop = varCategoryGoTop - 35;
							}
							document.getElementById("category_go").style.top = varCategoryGoTop+"px";
							document.getElementById("category_go").style.left = varCategoryGoLeft+"px";
							document.getElementById("category_go").style.display = "";
						}
					}			
				}
			}
		}
	}
}

function enuriCategorySearch_W(){
	top.document.getElementById("searchlist_loading").style.display = "";
	top.fnGetCountSearchPage(1,"1",checkcategory_value);
}
function checkEnuriAllCategory(){
	if (document.getElementById("img_cate_all").src.indexOf("_on") < 0){
		top.document.getElementById("searchlist_loading").style.display = "";
		top.fnGetCountSearchPage(1,"1","");
	}
}
function categorySearch(){
	var sk = document.frmList.searchkind.value;
	if (sk == ""){
		insertLog(5466);
	}else if(sk == "1"){
		insertLog(5467);
	}else if(sk == "2"){
		insertLog(5468);
	}
	if (top.document.body.scrollTop){
		top.document.body.scrollTop = "0px";
	}else{
		top.document.documentElement.scrollTop = "0px";
	}
	insertLog(3237);
	document.frmList.cate.value = checkcategory_value;
	document.frmList.page.value = "";
	document.frmList.m_price.value = "";
	document.frmList.factory.value = "";
	document.frmList.brand.value = "";
	document.frmList.shop_code.value = "";
	getCountList();
}
function webCategorySearch_E(cate,cate_name,cate_cnt){
	if (top.document.body.scrollTop){
		top.document.body.scrollTop = "0px";
	}else{
		top.document.documentElement.scrollTop = "0px";
	}
	document.getElementById("wcategorychk_"+cate).checked = true;
	//top.document.getElementById("searchlist_loading").style.display = "";
	document.getElementById("add_category_layer_inner").innerHTML = "<div style='text-align:center;padding-top:15px;'><span style='color:#1a981a;font-size:11pt;font-weight:bold;'>"+cate_name+"</span><span style='color:#444444;font-family:돋움;letter-spacing:-1px;font-size:11pt;font-weight:bold;'>에서 검색중입니다</span></div><div style='width:275px;height:20px;margin:5px auto 0px auto;'><img src='"+var_img_enuri_com+"/2010/images/view/web_cate_loading.gif'></div></div>";
	setTimeout(function(){
		top.fnGetCountSearchPage(1,"3",cate,cate_name,cate_cnt,document.getElementById("category_layer").offsetHeight);
	},100);	
}
function webCategorySearch(cate){
	document.frmList.cate.value = cate;
	document.frmList.page.value = "";
	document.frmList.m_price.value = "";
	document.frmList.shop_code.value = "";
	/*
	if (varTargetPage != "/view/fusion/Fusion.jsp" && varTargetPage != "/view/fusion/Fusion_Masterpiece.jsp"){
		top.viewLoadingBar();
	}
	*/
	top.document.getElementById("searchlist_loading").style.display = "";
	document.frmList.submit();
}
function setCategoryLayer(cate,searchkind){
	checkcategory_value = cate;
	var cate6 = "";
	var cate24 = "";
	if (cate.indexOf(",") > 0){
		var arrcate = cate.split(",");
		for(i=0;i<arrcate.length;i++){
			if(arrcate[i].length == 2 || arrcate[i].length == 4){
				cate24 = cate24 + arrcate[i] + ","; 
			}else if(arrcate[i].length == 6){
				cate6 = cate6 + arrcate[i] + ","; 
			}
		}
		if (cate6 != ""){
			cate6 = cate6.substring(0,cate6.length-1);
		}
		if (cate24 != ""){
			cate24 = cate24.substring(0,cate24.length-1);
		}		
	}else{
		cate24 = cate;
		if (cate.length == 6){
			cate24 = cate.substring(0,4);
			cate6 = cate;
		}
	}
	/*
	if (cate.length == 6 && cate.indexOf(".") < 0){
		cate6 = cate;
		cate = cate.substring(0,4);
	}
	*/
	//setInterval(function(){blinkCategoryName(cate)},1000);
	if (document.getElementById("category_spread_tab")){
		document.getElementById("spread_category_bottom").style.display = "none";
		document.getElementById("category_spread_tab").style.display = "";
	}
	if (cate24 != "" && cate24 != "00000000"){
		//spreadCategoryLayer();
		var onecate24 = "";
		if (cate24.indexOf(",") > 0){
			onecate24 = cate24.split(",")[cate24.split(",").length-1];
		}else{
			onecate24 = cate24;
		}
		var scrollingHeight = (Position.cumulativeOffset(document.getElementById("category_name_"+onecate24))[1] - Position.cumulativeOffset(document.getElementById("category_layer"))[1]);
		if (scrollingHeight < 20){
			scrollingHeight = 0;
		}else{
			scrollingHeight = scrollingHeight - 20;
		}			 
		if (document.getElementById("category_layer_inner")){
			document.getElementById("category_layer_inner").scrollTop = scrollingHeight;
		} 
	}
	if (cate6 != ""){
		showScateLayer(cate6.substring(0,4),null,cate6);
	}
}
function blinkCategoryName(cate){
	if (cate == "" || cate == "00000000"){
		if (document.getElementById("cate_all")){
			if (blinkCategoryName._f){
				document.getElementById("cate_all").style.color = "#FF0000"
				blinkCategoryName._f = false;
			}else{
				document.getElementById("cate_all").style.color = "#000000"
				blinkCategoryName._f = true;
			}
		}
	}else{
		if (document.getElementById("cate_"+cate)){
			if (blinkCategoryName._f){
				document.getElementById("cate_"+cate).style.color = "#FF0000"
				blinkCategoryName._f = false;
			}else{
				document.getElementById("cate_"+cate).style.color = "#000000"
				blinkCategoryName._f = true;
			}
		}		
	}
}
function toggleTabBorder(){
	var visTabLayer = false;
	if (document.getElementById("price_layer")){
		if (document.getElementById("price_layer").style.display != "none"){
			visTabLayer = true;
			if (BrowserDetect.browser == "Explorer" &&  BrowserDetect.version == 7 && varTargetPage == "/search/EnuriSearch.jsp"){
				document.getElementById("price_layer").style.top = "-2px";
			}
		}
	}
 
	if (document.getElementById("shop_layer")){
		if (document.getElementById("shop_layer").style.display != "none"){
			visTabLayer = true;
			if (document.getElementById("price_layer").style.display != "none"){
				document.getElementById("shop_layer_inner").style.borderTop = "1px solid #d0d0d0";
				document.getElementById("shop_layer").style.top = "-3px";
				if (BrowserDetect.browser == "Explorer" &&  BrowserDetect.version == 7 ){
					if ( varTargetPage != "/search/EnuriSearch.jsp"){
						document.getElementById("shop_layer").style.top = "-5px";
					}else{
						document.getElementById("shop_layer").style.top = "-2px";
					}
				}else{
					document.getElementById("shop_layer").style.top = "-3px";
				}						
			}else{
				document.getElementById("shop_layer_inner").style.borderTop = "1px solid #58585c";
				if (BrowserDetect.browser == "Explorer" &&  BrowserDetect.version == 7 ){
					if (varTargetPage != "/search/EnuriSearch.jsp"){
						document.getElementById("shop_layer").style.top = "-4px";
					}else{
						document.getElementById("shop_layer").style.top = "-2px";
					}
				}else{
					document.getElementById("shop_layer").style.top = "-2px";
				}				
			}
		}
	}	
	if (document.getElementById("factory_layer")){
		if (document.getElementById("factory_layer").style.display != "none"){
			visTabLayer = true;
			if (document.getElementById("price_layer").style.display != "none"){
				if (document.getElementById("hot_factory_layer")){
					document.getElementById("hot_factory_layer").style.borderTop = "1px solid #d0d0d0"
				}else{
					document.getElementById("factory_layer_inner").style.borderTop = "1px solid #d0d0d0"
				}
				if (BrowserDetect.browser == "Explorer" &&  BrowserDetect.version == 7 ){
					if ( varTargetPage != "/search/EnuriSearch.jsp"){
						document.getElementById("factory_layer").style.top = "-5px";
					}else{
						document.getElementById("factory_layer").style.top = "-2px";
					}
				}else{
					document.getElementById("factory_layer").style.top = "-3px";
				}				
			}else{
				if (document.getElementById("hot_factory_layer")){
					document.getElementById("hot_factory_layer").style.borderTop = "1px solid #58585c"
				}else{
					document.getElementById("factory_layer_inner").style.borderTop = "1px solid #58585c"
				}
				if (BrowserDetect.browser == "Explorer" &&  BrowserDetect.version == 7 ){
					if (varTargetPage != "/search/EnuriSearch.jsp"){
						document.getElementById("factory_layer").style.top = "-4px";
					}else{
						document.getElementById("factory_layer").style.top = "-2px";
					}
				}else{
					document.getElementById("factory_layer").style.top = "-2px";
				}
			}
		}
	}
	if (document.getElementById("brand_layer")){
		if (document.getElementById("brand_layer").style.display != "none"){
			visTabLayer = true;
			if (document.getElementById("price_layer").style.display != "none"){
				if (document.getElementById("hot_brand_layer")){
					document.getElementById("hot_brand_layer").style.borderTop = "1px solid #d0d0d0"
				}else{
					document.getElementById("brand_layer_inner").style.borderTop = "1px solid #d0d0d0"
				}
				if (BrowserDetect.browser == "Explorer" &&  BrowserDetect.version == 7 ){
					if ( varTargetPage != "/search/EnuriSearch.jsp"){
						document.getElementById("brand_layer").style.top = "-5px";
					}else{
						document.getElementById("brand_layer").style.top = "-2px";
					}
				}else{
					document.getElementById("brand_layer").style.top = "-3px";
				}				
			}else{
				if (document.getElementById("hot_brand_layer")){
					document.getElementById("hot_brand_layer").style.borderTop = "1px solid #58585c"
				}else{
					document.getElementById("brand_layer_inner").style.borderTop = "1px solid #58585c"
				}
				if (BrowserDetect.browser == "Explorer" &&  BrowserDetect.version == 7 ){
					if (varTargetPage != "/search/EnuriSearch.jsp"){
						document.getElementById("brand_layer").style.top = "-4px";
					}else{
						document.getElementById("brand_layer").style.top = "-2px";
					}
				}else{
					document.getElementById("brand_layer").style.top = "-2px";
				}
			}
		}
	}
	if (document.getElementById("goodslist")){
		if (visTabLayer){
			document.getElementById("goodslist").style.marginTop = 3+"px";
		}else{
			document.getElementById("goodslist").style.marginTop = 0+"px";
		}
	}	
	
	if (typeof(parent.syncHeightListFrame) =="function"){
		parent.syncHeightListFrame();
	}
	var varShopListTab = false;
	if (document.getElementById("ul_sel_shoplist")){
		if (document.getElementById("ul_sel_shoplist").style.display == "none"){
			varShopListTab = true;
		}
	}else{
		varShopListTab = true;
	}	

	if (!visTabLayer){
		if (document.getElementById("tab_price")){
			if (document.getElementById("tab_price").style.display != "none"){
				document.getElementById("tab_price").src = var_img_enuri_com+"/2014/list/tab/price_tab"+getPriceTabName()+".gif";
			}
		}
		if (document.getElementById("tab_shop")){
			if (document.getElementById("tab_shop").style.display != "none"){
				document.getElementById("tab_shop").src = var_img_enuri_com+"/2014/list/tab/shopping_tab.gif";
			}
		}		
		if (document.getElementById("tab_factory")){
			if (document.getElementById("tab_factory").style.display != "none"){
				if (document.getElementById("tab_factory").src.indexOf("factory_tab") >= 0){
					document.getElementById("tab_factory").src = var_img_enuri_com+"/2014/list/tab/factory_tab.gif";
				}else{
					document.getElementById("tab_factory").src = var_img_enuri_com+"/2014/list/tab/brand_tab.gif";
				}				
			}	
		}
		if (document.getElementById("page_box_1")){
			document.getElementById("page_box_1").style.display = "";
		}		
	}else{
		if (document.getElementById("page_box_1")){
			document.getElementById("page_box_1").style.display = "none";
		}
	}
	if (typeof(setPosGoodsDiv) == "function"){
		setPosGoodsDiv();
	}
}
function getVisibleTabLayer(){
	var visTabLayer = false;
	if (document.getElementById("price_layer")){
		if (document.getElementById("price_layer").style.display != "none"){
			visTabLayer = true;
		}
	}
	if (document.getElementById("shop_layer")){
		if (document.getElementById("shop_layer").style.display != "none"){
			visTabLayer = true;
		}
	}	
	if (document.getElementById("factory_layer")){
		if (document.getElementById("factory_layer").style.display != "none"){
			visTabLayer = true;
		}
	}
	return visTabLayer;
}
function clickFactorySearch(idx){
	if (typeof(checkFactory.value) == "undefined"){
		checkFactory.value = document.frmList.factory.value;
	}
	if (checkFactory.value == ""){
		document.getElementById("factorychk_"+idx).checked = true;
		checkFactory(idx);
		//factorySearch();
		tabSearch();
	}else{
		if (document.getElementById("factorychk_"+idx).checked ){
			document.getElementById("factorychk_"+idx).checked = false;
			var elements = document.getElementsByClassName('factory_name');
			for(var i=0, l=elements.length; i<l; i++){
				elements[i].style.backgroundColor = "#F9F9F9";
			}
		}else{
			document.getElementById("factorychk_"+idx).checked = true;
		}
		checkFactory(idx);
	}
}

function clickBrandSearch(idx){
	if (typeof(checkBrand.value) == "undefined"){
		checkBrand.value = document.frmList.brand.value;
	}
	if (checkBrand.value == ""){
		document.getElementById("brandchk_"+idx).checked = true;
		checkBrand(idx);
		//factorySearch();
		tabSearch();
	}else{
		if (document.getElementById("brandchk_"+idx).checked ){
			document.getElementById("brandchk_"+idx).checked = false;
		}else{
			document.getElementById("brandchk_"+idx).checked = true;
		}
		checkBrand(idx);
	}
}

function clickFactoryDirectSearch(idx){
	if (typeof(clickFactoryDirectSearch._idx) == "undefined"){
		clickFactoryDirectSearch._idx = idx;
		if (typeof(clickFactoryDirectSearch._pidx) != "undefined"){
			document.getElementById("factory_name_"+clickFactoryDirectSearch._pidx).style.color="#000000";
			document.getElementById("factory_name_"+clickFactoryDirectSearch._pidx).style.fontWeight="normal";
			document.getElementById("factory_name_"+clickFactoryDirectSearch._pidx).style.backgroundColor="#f9f9f9";
		}
		document.getElementById("factory_name_"+idx).style.color="#c70b09";
		document.getElementById("factory_name_"+idx).style.fontWeight="bold";
		document.getElementById("factory_name_"+idx).style.backgroundColor="#9dea9d";
		document.frmList.factory.value = document.getElementById("factorychk_"+idx).value;
		tabSearch();
	}
}
function clickBrandDirectSearch(idx){
	insertLog(12930);
	if (typeof(clickBrandDirectSearch._idx) == "undefined"){
		clickBrandDirectSearch._idx = idx;
		if (typeof(clickBrandDirectSearch._pidx) != "undefined"){
			document.getElementById("brand_name_"+clickBrandDirectSearch._pidx).style.color="#000000";
		}
		document.getElementById("brand_name_"+idx).style.color="#c70b09";
		document.frmList.brand.value = document.getElementById("brandchk_"+idx).value;
		tabSearch();
	}
}
function factorySearch(modelno){
	document.frmList.factory.value = checkFactory.value;
	document.frmList.page.value = "";
	getCountList(modelno);
}

function brandSearch(){
	document.frmList.brand.value = checkBrand.value;
	document.frmList.page.value = "";
	getCountList();
}

function showAllPrice(){
	unCheckAllPrice();
	tabSearch();
}
function showPriceTabLayerTop(price,count,idx,start,end){
	if (typeof(showPriceTabLayerBottom._f_start) == "undefined"){
		if (document.getElementById("txt_start_price").style.fontWeight == "bold"){
			showPriceTabLayerBottom._f_start = document.getElementById("txt_start_price").value;
		}
	}
	if (typeof(showPriceTabLayerBottom._f_end) == "undefined"){
		if (document.getElementById("txt_end_price").style.fontWeight == "bold"){
			showPriceTabLayerBottom._f_end = document.getElementById("txt_end_price").value;
		}
	}
	var PosLeft = Position.cumulativeOffset($("price_group_txt_"+idx))[0];
	var PosTop = Position.cumulativeOffset($("price_group_txt_"+idx))[1];
	
	if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6){
		PosLeft = PosLeft - 10;
	}	
	//document.getElementById("price_tootip_layer").innerHTML = "<span style='margin-left:5px;line-height:20px;color:#2a2a2a;'>" + price +"</span><span style='margin-left:20px;line-height:10px;color:#2a2a2a;margin-top:5px;'>"+count+"</span><span style='color:#717171;line-height:10px;margin-top:5px;'>개</span>";
	document.getElementById("price_tootip_layer").innerHTML = "<span style='margin-left:5px;color:#2a2a2a;margin-top:3px;float:left;display:block;'>" + price +"</span><span style='color:#717171;margin-top:3px;float:right;display:block;'>개&nbsp;</span><span style='color:#2a2a2a;margin-top:3px;float:right;display:block;'>"+count+"</span>";
	document.getElementById("price_tootip_layer").style.left = (PosLeft - 130)+"px";
	document.getElementById("price_tootip_layer").style.top = (PosTop - 26-Position.cumulativeOffset($("price_layer"))[1])+"px";
	document.getElementById("price_tootip_layer").style.backgroundImage  = "url("+var_img_enuri_com+"/2014/list/tab/price_balloon04.png)";
	document.getElementById("price_tootip_layer").style.display = "";
	
	var varMinPrice = (start+"").NumberFormat();;
	var varMaxPrice = (end+"").NumberFormat();
	/*
	document.getElementById("txt_start_price").value = varMinPrice;
	document.getElementById("txt_end_price").value = varMaxPrice;
	document.getElementById("txt_start_price").style.fontWeight = "normal";
	document.getElementById("txt_end_price").style.fontWeight = "normal";
	document.getElementById("txt_select_title").innerHTML = "선택<span style=\"font-weight:bold\">할</span> 가격: ";	
	document.getElementById("img_continual").src = var_img_enuri_com + "/2010/images/view/wave.gif";
	*/
}
function showPriceTabLayerBottom(price,count,idx,start,end){
	if (typeof(showPriceTabLayerBottom._f_start) == "undefined"){
		if (document.getElementById("txt_start_price").style.fontWeight == "bold"){
			showPriceTabLayerBottom._f_start = document.getElementById("txt_start_price").value;
		}
	}
	if (typeof(showPriceTabLayerBottom._f_end) == "undefined"){
		if (document.getElementById("txt_end_price").style.fontWeight == "bold"){
			showPriceTabLayerBottom._f_end = document.getElementById("txt_end_price").value;
		}
	}

	var PosLeft = Position.cumulativeOffset($("price_name_"+idx))[0];
	var PosTop = Position.cumulativeOffset($("price_name_"+idx))[1];
	PosLeft = PosLeft + document.getElementById("price_name_"+idx).offsetWidth/2;
	if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6){
		PosLeft = PosLeft - 10;
	}	
	document.getElementById("price_tootip_layer").innerHTML = "<span style='margin-left:5px;color:#2a2a2a;margin-top:10px;float:left;display:block;'>" + price +"</span><span style='color:#717171;margin-top:10px;float:right;display:block;'>개&nbsp;</span><span style='color:#2a2a2a;margin-top:10px;float:right;display:block;'>"+count+"</span>";
	document.getElementById("price_tootip_layer").style.top = (PosTop + 25 -Position.cumulativeOffset($("price_layer"))[1])+"px";
	if ((PosLeft-69)  < 0 ){
		document.getElementById("price_tootip_layer").style.left = (PosLeft)+"px";
		document.getElementById("price_tootip_layer").style.backgroundImage  = "url("+var_img_enuri_com+"/2014/list/tab/price_balloon01.png)";
	}else if ((PosLeft+69) > document.getElementById("price_layer").offsetWidth ){
		document.getElementById("price_tootip_layer").style.left = (PosLeft - 138)+"px";
		document.getElementById("price_tootip_layer").style.backgroundImage  = "url("+var_img_enuri_com+"/2014/list/tab/price_balloon03.png)";	
	}else{
		document.getElementById("price_tootip_layer").style.left = (PosLeft - 77)+"px";
		document.getElementById("price_tootip_layer").style.backgroundImage  = "url("+var_img_enuri_com+"/2014/list/tab/price_balloon02.png)";	
	}
	document.getElementById("price_tootip_layer").style.display = "";
	
	var varMinPrice = getCheckedPrice("min");
	var varMaxPrice = getCheckedPrice("max");

	if (varMinPrice){
		if (parseInt(varMinPrice.DeNumberFormat()) > start){
			varMinPrice = (start+"").NumberFormat();
		}
	}else{
		varMinPrice = (start+"").NumberFormat();
	}
	if (varMaxPrice){
		if (parseInt(varMaxPrice.DeNumberFormat()) < end){
			varMaxPrice = (end+"").NumberFormat();
		}
	}else{
		varMaxPrice = (end+"").NumberFormat();
	}	
	/*
	document.getElementById("txt_start_price").value = varMinPrice;
	document.getElementById("txt_end_price").value = varMaxPrice;
	document.getElementById("txt_start_price").style.fontWeight = "normal";
	document.getElementById("txt_end_price").style.fontWeight = "normal";
	document.getElementById("txt_select_title").innerHTML = "선택<span style=\"font-weight:bold\">할</span> 가격: ";
	*/
	document.getElementById("price_name_l_"+idx).src = var_img_enuri_com+"/2014/list/tab/price_ba01_ov.png";
	document.getElementById("price_name_"+idx).style.backgroundImage  = "url("+var_img_enuri_com+"/2014/list/tab/price_ba_bg_ov.png)";
	document.getElementById("price_name_r_"+idx).src = var_img_enuri_com+"/2014/list/tab/price_ba02_ov.png";
	/*		
	if (checkContinual(idx)){
		document.getElementById("img_continual").src = var_img_enuri_com + "/2010/images/view/wave.gif";
	}else{
		document.getElementById("img_continual").src = var_img_enuri_com + "/2010/images/view/dot_1.gif";
	}
	*/	
}
function showCheckedPriceButton(idx){
	/*
	var varMinPrice = getCheckedPrice("min");
	var varMaxPrice = getCheckedPrice("max");
	if (varMinPrice){
		document.getElementById("txt_start_price").value = varMinPrice;
	}else{
		document.getElementById("txt_start_price").style.fontWeight = "normal";
		document.getElementById("txt_start_price").value = showPriceTabLayerBottom._f_start;
	}
	if (varMaxPrice){
		document.getElementById("txt_end_price").value = varMaxPrice;
	}else{
		document.getElementById("txt_end_price").style.fontWeight = "normal";
		document.getElementById("txt_end_price").value = showPriceTabLayerBottom._f_end;
	}
	*/
	if (typeof(idx) != "undefined"){
		if (!document.getElementById("pricechk_"+idx).checked){
			document.getElementById("price_name_l_"+idx).src = var_img_enuri_com+"/2014/list/tab/price_bar01.png";
			document.getElementById("price_name_"+idx).style.backgroundImage  = "url("+var_img_enuri_com+"/2014/list/tab/price_ba_bg.png)";
			document.getElementById("price_name_r_"+idx).src = var_img_enuri_com+"/2014/list/tab/price_ba02.png";
		}else{
			document.getElementById("price_name_l_"+idx).src = var_img_enuri_com+"/2014/list/tab/price_ba01_on.png";
			document.getElementById("price_name_"+idx).style.backgroundImage  = "url("+var_img_enuri_com+"/2014/list/tab/price_ba_bg_on.png)";
			document.getElementById("price_name_r_"+idx).src = var_img_enuri_com+"/2014/list/tab/price_ba02_on.png";			
		}
	}
	/*
	if (document.getElementById("btn_directsearch").style.display != "none"){
		if (inputPriceCheck._f_start && inputPriceCheck._f_end){
			document.getElementById("txt_start_price").value = inputPriceCheck._f_start;
			document.getElementById("txt_end_price").value = inputPriceCheck._f_end;
		}
	}
	*/	
	//document.getElementById("txt_select_title").innerHTML = "선택<span style=\"font-weight:bold\">할</span> 가격: ";
	setBoldpriceTxtBox();
	/*
	if (checkContinual()){
		document.getElementById("img_continual").src = var_img_enuri_com + "/2010/images/view/wave.gif";
	}else{
		document.getElementById("img_continual").src = var_img_enuri_com + "/2010/images/view/dot_1.gif";
	}
	*/
	hidePriceLayerToolTip();
}
function hidePriceLayerToolTip(){
	document.getElementById("price_tootip_layer").innerHTML = ""
	document.getElementById("price_tootip_layer").style.display = "none";
}
function clickPriceGroupSearch(start,end,idx){
	insertLog(10090);
	document.getElementById("price_group_txt_"+idx).style.fontWeight="bold";
	document.getElementById("price_group_txt_"+idx).style.color="#3D3D3D";
	unCheckAllPrice();
	var chkPriceGroup = $("price_group_"+idx).getElementsBySelector('input[class="chkbox"]');
	for (i=0;i<chkPriceGroup.length;i++){
		chkPriceGroup[i].checked = true;
	}
	tabSearch();	
}
function unCheckAllPrice(){
	if (document.getElementById("price_layer_inner")){
		chkPrice = $("price_layer_inner").getElementsBySelector('input[class="chkbox"]');
		for (i=0;i<chkPrice.length;i++){
			chkPrice[i].checked = false;
		}
	}
	if (document.getElementById("txt_start_price")){
		document.getElementById("txt_start_price").value = "";
	}
	if (document.getElementById("txt_end_price")){
		document.getElementById("txt_end_price").value = "";
	}
	if (document.getElementById("start_price")){
		document.getElementById("start_price").value = "";
	}
	if (document.getElementById("end_price")){
		document.getElementById("end_price").value = "";
	}	
}
function setPositionPriceGo(){
	if (document.getElementById("price_layer")){
		if (document.getElementById("price_layer").style.display != "none"){
			var chkPrice = $("price_layer_inner").getElementsBySelector('input[class="chkbox"]');
			var selectedPrice = "";
			for (i=0;i<chkPrice.length;i++){
				if (chkPrice[i].id != "pricechk_all" &&  chkPrice[i].id.indexOf("pricechk_group_") < 0 ){
					if (chkPrice[i].checked){
						if (selectedPrice == ""){
							selectedPrice = chkPrice[i].value;
						}else{
							if (selectedPrice.substring(selectedPrice.lastIndexOf(",")+1,selectedPrice.length) == chkPrice[i].value.substring(0,chkPrice[i].value.indexOf(","))){
								selectedPrice = selectedPrice.substring(0,selectedPrice.lastIndexOf(",")) + chkPrice[i].value.substring(chkPrice[i].value.lastIndexOf(","),chkPrice[i].value.length);
							}else{ 
								selectedPrice = selectedPrice + "_" + chkPrice[i].value;
							}
						} 
					}
				}
			}		
			if (document.getElementById("pricechk_"+checkPrice._prev_idx) && selectedPrice.trim().length > 0){
				var PosLeft = Position.cumulativeOffset($("price_name_"+checkPrice._prev_idx))[0] - Position.cumulativeOffset($("price_layer"))[0];
				if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6){
					PosLeft = PosLeft - Position.cumulativeOffset($("price_layer"))[0];
				}else if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 7){
					PosLeft = PosLeft - 5;
				}else{
					PosLeft = PosLeft + 2;
				}
				PosLeft = PosLeft + document.getElementById("price_name_"+checkPrice._prev_idx).offsetWidth/2-20;
				var PosTop = Position.cumulativeOffset($("price_name_"+checkPrice._prev_idx))[1] - 32;

				document.getElementById("btn_price_search").style.top = (PosTop -Position.cumulativeOffset($("price_layer"))[1])+"px";
				document.getElementById("btn_price_search").style.left = PosLeft+"px";
				document.getElementById("btn_price_search").style.display = "";
			}else{
				document.getElementById("btn_price_search").style.display = "none";
			}
		}
	}
}
function checkPrice(start,end,idx){
	insertLog(10088);
	if (!checkPrice._f_start){
		checkPrice._f_start = document.getElementById("txt_start_price").value;
	}
	if (!checkPrice._f_end){
		checkPrice._f_end = document.getElementById("txt_end_price").value;
	}
		
	hidePriceLayerToolTip();
	checkPrice._prev_idx = idx;	
	if (document.getElementById("pricechk_"+idx).checked){
		document.getElementById("pricechk_"+idx).checked = false;
		document.getElementById("price_name_l_"+idx).src = var_img_enuri_com+"/2014/list/tab/price_ba01_on.png";
		document.getElementById("price_name_"+idx).style.backgroundImage  = "url("+var_img_enuri_com+"/2014/list/tab/price_ba_bg_on.png)";
		document.getElementById("price_name_r_"+idx).src = var_img_enuri_com+"/2014/list/tab/price_ba02_on.png";
	}else{
		document.getElementById("pricechk_"+idx).checked = true;
		document.getElementById("price_name_l_"+idx).src = var_img_enuri_com+"/2014/list/tab/price_ba01_on.png";
		document.getElementById("price_name_"+idx).style.backgroundImage  = "url("+var_img_enuri_com+"/2014/list/tab/price_ba_bg_on.png)";
		document.getElementById("price_name_r_"+idx).src = var_img_enuri_com+"/2014/list/tab/price_ba02_on.png";	
	}
	var varMinPrice = getCheckedPrice("min");
	var varMaxPrice = getCheckedPrice("max");
	if (varMinPrice){
		document.getElementById("txt_start_price").value = varMinPrice;
	}else{
		document.getElementById("txt_start_price").value = checkPrice._f_start;
	}
	
	if (varMaxPrice){
		document.getElementById("txt_end_price").value = varMaxPrice;
	}else{
		document.getElementById("txt_end_price").value = checkPrice._f_end;
	}
	//document.getElementById("txt_select_title").innerHTML = "선택<span style=\"font-weight:bold\">할</span> 가격: ";
	setBoldpriceTxtBox();
	if (checkContinual()){
		document.getElementById("img_continual").src = var_img_enuri_com + "/2010/images/view/wave.gif";
	}else{
		document.getElementById("img_continual").src = var_img_enuri_com + "/2010/images/view/dot_1.gif";
	}
	setPositionPriceGo();
	
}
function setBoldpriceTxtBox(){
	var varBFirst = false;
	var varMPrice = document.getElementById("m_price").value;
	if (varMPrice == "" ){
		varBFirst = true;
	}
	if (!varBFirst && showPriceTabLayerBottom._f_start == document.getElementById("txt_start_price").value && showPriceTabLayerBottom._f_end == document.getElementById("txt_end_price").value){
		document.getElementById("txt_start_price").style.fontWeight = "bold";
		document.getElementById("txt_end_price").style.fontWeight = "bold";
		//document.getElementById("txt_select_title").innerHTML = "선택<span style=\"font-weight:bold\">된</span> 가격: ";
	}else{
		document.getElementById("txt_start_price").style.fontWeight = "normal";
		document.getElementById("txt_end_price").style.fontWeight = "normal";	
	}
}
function getCheckedPrice(mx){
	var varReturn = -1;
	var varMaxi = 0;
	for (var i=0;i<25;i++){
		if (document.getElementById("pricechk_"+i)){
			if (document.getElementById("pricechk_"+i).checked){
				if (mx == "min"){
					if (varReturn == -1){
						varReturn = document.getElementById("pricechk_"+i).value.split("~")[0].NumberFormat();
					}
				}
				if (mx == "max"){
					varReturn = document.getElementById("pricechk_"+i).value.split("~")[1].NumberFormat();
				}
			}
			varMaxi = i;
		}	
	}
	if (varReturn == -1){
		if (mx == "min"){
			varReturn = checkPrice._f_start;
		}
		if (mx == "max"){
			varReturn = checkPrice._f_end;
		}	
	}
	return varReturn;
}
function checkContinual(over_i){
	var bCheck = false;
	var bUnCheck = false;
	var bContinual = true;
	var overidx = -1;
	if (typeof(over_i) != "undefined"){
		overidx = over_i;
	}			
	for (var i=0;i<25;i++){
		if (document.getElementById("pricechk_"+i)){
			if (document.getElementById("pricechk_"+i).checked || (overidx > 0 && overidx == i)){
				bCheck = true;
			}
			if (bCheck && !document.getElementById("pricechk_"+i).checked && !(overidx > 0 && overidx == i)){
				bUnCheck = true;
			}
			if (bUnCheck && (document.getElementById("pricechk_"+i).checked || (overidx > 0 && overidx == i))){
				bContinual = false;
			}
		}	
	}

	return bContinual;
}

function directPriceCheck(){
	var startPrice = document.getElementById("txt_start_price").value.trim();
	var endPrice = document.getElementById("txt_end_price").value.trim();
	if (startPrice.length == 0 ){
		alert("가격검색 범위를 입력해 주십시요.")
		document.getElementById("txt_start_price").focus();
		return false;
	}
	if (endPrice.length == 0 ){
		alert("가격검색 범위를 입력해 주십시요.")
		document.getElementById("txt_end_price").focus();
		return false;
	}	
	startPrice = startPrice.DeNumberFormat();
	endPrice = endPrice.DeNumberFormat();
	if (!startPrice.isnumber()){
		alert("가격검색 범위를 숫자로 입력해 주십시요.");
		document.getElementById("txt_start_price").focus();
		return false;
	}
	if (!endPrice.isnumber()){
		alert("가격검색 범위를 숫자로 입력해 주십시요.");
		document.getElementById("txt_end_price").focus();
		return false;
	}	 
	if (parseInt(startPrice) >= parseInt(endPrice)){
		alert("가격 검색 끝 값은 가격 검색 시작 값 보다 커야 합니다.");
		document.getElementById("txt_start_price").focus();
		return false; 	
	}
	if (parseInt(startPrice) >= 1000000000){
		alert("가격이 너무 큽니다.");
		document.getElementById("txt_start_price").focus();
		return false; 	
	}
	if (parseInt(endPrice) >= 1000000000){
		alert("가격이 너무 큽니다.");
		document.getElementById("txt_end_price").focus();
		return false; 	
	}			
	document.frmList.start_price.value = startPrice;
	document.frmList.end_price.value = endPrice;
	//document.frmList.m_price.value = startPrice+","+endPrice;
	document.frmList.key.value="minprice";
	directPriceCheck._f_return = true;
	directPriceCheck._f_noresult = true;
	return true;
}
function directPriceSearch(){
	insertLog(9719);
	if(directPriceCheck()){
		tabSearch();	
	}
}
function WebDirectPriceSearch(){
	if(directPriceCheck()){
		webPriceSearch();
	}
}
function enterChk(e){
	var keycode;
	if(typeof(e) != "undefined"){
		if (typeof(e.which) != "undefined"){
			keycode = e.which;
		}else{
			keycode = e.keyCode;
		}
	}else{
		keycode = event.keyCode;
	}
	if (!((keycode >= 48 && keycode <= 57) || (keycode >= 96 && keycode <= 105) || keycode == 8 || keycode == 9 ||  keycode == 46 || keycode == 13 || (keycode >= 37 && keycode <= 40))){
		if(!e) var e = window.event;
		e.cancelBubble = true;
		e.returnValue = false;
		if (e.stopPropagation) {
			e.stopPropagation();
			e.preventDefault();
		}
	}
	/*
	chkPrice = $("price_layer_inner").getElementsBySelector('input[class="chkbox"]');
	for (i=0;i<chkPrice.length;i++){
		if (chkPrice[i].id != "pricechk_all" && chkPrice[i].id.indexOf("pricechk_group_") >= 0 ){
			chkPrice[i].checked = false;
			document.getElementById("price_name_g_"+chkPrice[i].id.substring(15,chkPrice[i].id.length)).style.color="#000000";
		}else if(chkPrice[i].id != "pricechk_all" && chkPrice[i].id.indexOf("pricechk_") >= 0 ){
			chkPrice[i].checked = false;
			document.getElementById("price_name_"+chkPrice[i].id.substring(9,chkPrice[i].id.length)).style.color="#000000";			
		}
	}
	*/	
	if (keycode == 13 ){
		directPriceSearch();
	}
}
function inputPriceCheck(obj){
	var varReturn = true;
	var startPrice = document.getElementById("txt_start_price").value.trim();
	var endPrice = document.getElementById("txt_end_price").value.trim();
	
	if (startPrice.length == 0 ){
		varReturn = false;
		if (obj.id == "txt_start_price"){
			document.getElementById("img_clear_start").src = var_img_enuri_com+"/2014/list/tab/price_box_04.gif";
			document.getElementById("img_clear_start").style.cursor = "default";
		}
	}else{
		if (obj.id == "txt_start_price"){
			document.getElementById("img_clear_start").src = var_img_enuri_com+"/2014/list/tab/delete.gif";
			document.getElementById("img_clear_start").style.cursor = "pointer";
		}
	}
	if (endPrice.length == 0 ){
		varReturn = false;
		if (obj.id == "txt_end_price"){		
			document.getElementById("img_clear_end").src = var_img_enuri_com+"/2014/list/tab/price_box_04.gif"
			document.getElementById("img_clear_end").style.cursor = "default";			
		}				
	}else{
		if (obj.id == "txt_end_price"){
			document.getElementById("img_clear_end").src = var_img_enuri_com+"/2014/list/tab/delete.gif";
			document.getElementById("img_clear_end").style.cursor = "pointer";
		}						
	}
	startPrice = startPrice.DeNumberFormat();
	endPrice = endPrice.DeNumberFormat();

	if (!startPrice.isnumber()){
		varReturn = false;
	}
	if (!endPrice.isnumber()){
		varReturn = false;
	}	 
	if (parseInt(startPrice) >= parseInt(endPrice)){
		varReturn = false;
	}

	if (varReturn){
		inputPriceCheck._f_start = document.getElementById("txt_start_price").value.trim();
		inputPriceCheck._f_end = document.getElementById("txt_end_price").value.trim();
		document.getElementById("btn_directsearch").src = var_img_enuri_com+"/2014/list/tab/btn_go_on.gif";
		document.getElementById("btn_directsearch").style.cursor = "pointer";
		document.getElementById("btn_directsearch").onclick = function(){
			directPriceSearch();
		}
	}else{
		inputPriceCheck._f_start = "";
		inputPriceCheck._f_end = "";
		document.getElementById("btn_directsearch").src = var_img_enuri_com+"/2014/list/tab/btn_go.gif";
		document.getElementById("btn_directsearch").style.cursor = "default";
		document.getElementById("btn_directsearch").onclick = function(){
		}		
	}	
	keyupEventFunction(obj)
}
function addCommas(nStr)
{
	nStr += '';
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1)) {
		x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
	return x1 + x2;
}
function stripCommas(nStr) {
	return nStr.split(",").join("");
}

function keyupEventFunction(targetObj) {
	var originalCursorPosition = doGetCaretPosition(targetObj)	
	var commaLength_pre = targetObj.value.length - stripCommas(targetObj.value).length;
	targetObj.value = addCommas(stripCommas(targetObj.value));
	var commaLength_post = targetObj.value.length - stripCommas(targetObj.value).length;
	if( commaLength_post > commaLength_pre ) originalCursorPosition = originalCursorPosition + 1;
	if( commaLength_post < commaLength_pre ) originalCursorPosition = originalCursorPosition - 1;
	setCaretPosition(targetObj, originalCursorPosition);
}
function setCaretPosition(elem, caretPos) {
	if( typeof(elem)=="string" ) elem = document.getElementById(elem);    
	try {
		if(elem != null) {
			if(elem.createTextRange) {
				var range = elem.createTextRange();
				range.move('character', caretPos);
				range.select();
			}
			else {
				if(elem.selectionStart) {
					elem.focus();
					elem.setSelectionRange(caretPos, caretPos);
				}
				else
					elem.focus();
			}
		}
	} catch(e) {console.log(e);}
}
function doGetCaretPosition (oField) {
	var iCaretPos = 0;

	if (document.selection) {
		oField.focus ();
		var oSel = document.selection.createRange ();
		oSel.moveStart ('character', -oField.value.length);
		iCaretPos = oSel.text.length;
	}else if (oField.selectionStart || oField.selectionStart == '0')
		iCaretPos = oField.selectionStart;


	return (iCaretPos);
}


function unCheckAllShop(){
	if (document.getElementById("shopchk_all").checked){
		chkShop = $("shop_layer_inner").getElementsBySelector('input[class="chkbox"]');
		for (i=0;i<chkShop.length;i++){
			if (chkShop[i].id != "shopchk_all"){
				chkShop[i].checked = false;
				document.getElementById("shop_name_"+chkShop[i].id.substring(8,chkShop[i].id.length)).style.backgroundColor="#f9f9f9";
			}
		}
		checkShop.value = "";

		var varShopGoLeft = Position.cumulativeOffset(document.getElementById("shopchk_all"))[0]+105;
		var varShopGoTop = Position.cumulativeOffset(document.getElementById("shopchk_all"))[1]-Position.cumulativeOffset(document.getElementById("shop_layer"))[1]-2;

		document.getElementById("shop_go").style.left = varShopGoLeft+"px";
		document.getElementById("shop_go").style.top = varShopGoTop+"px";
		document.getElementById("shop_go").style.display = "";		
	}else{
		document.getElementById("shop_go").style.display = "none";
	}
}
function showAllShop(){
	checkShop.value = "";
	tabSearch();
}
function checkShop(idx){
	checkShop._prev_idx = idx;
	if (typeof(checkShop.value) == "undefined"){
		checkShop.value = document.frmList.shop_code.value;
	}
	//document.getElementById("shop_go_"+idx).style.display = "";
	
	if (document.getElementById("shopchk_"+idx).checked){
		document.getElementById("shop_name_"+idx).style.color="#c70b09";
	}else{
		document.getElementById("shop_name_"+idx).style.color="#000000";
	}
		
	if (document.getElementById("shopchk_"+idx).checked){
		var strSelectShop = checkShop.value;
		if (strSelectShop != ""){
			checkShop.value = strSelectShop +","+document.getElementById("shopchk_"+idx).value;
		}else{
			checkShop.value = document.getElementById("shopchk_"+idx).value;
		}	
	}else{
		var strSelectShop = checkShop.value;
		strSelectShop = strSelectShop.replace(","+document.getElementById("shopchk_"+idx).value,"");
		strSelectShop = strSelectShop.replace(document.getElementById("shopchk_"+idx).value+",","");
		strSelectShop = strSelectShop.replace(document.getElementById("shopchk_"+idx).value,"");		
		checkShop.value = strSelectShop;
	}
	setPositionShopGo();
	if (typeof(idx) != "undefined"){
		if (checkShop.value != ""){
			document.getElementById("shopchk_all").checked = false;
		}else{
			//document.getElementById("shop_go").style.display = "none";			
		}
	}	
}
function clickShopSearch(idx){
	if (typeof(checkShop.value) == "undefined"){
		checkShop.value = document.frmList.shop_code.value;
	}
	if (checkShop.value == ""){
		document.getElementById("shopchk_"+idx).checked = true;
		checkShop(idx);
		tabSearch();
	}else{
		if (document.getElementById("shopchk_"+idx).checked ){
			document.getElementById("shopchk_"+idx).checked = false;
		}else{
			document.getElementById("shopchk_"+idx).checked = true;
		}
		checkShop(idx);
	}
}
function getCountList(modelno){
	if (typeof(modelno) == "undefined"){
		modelno = '';
	}
	function callBackgetCountList(originalRequest){
		eval("varCount = " + originalRequest.responseText);
		if (varCount.count == "-1"){
			top.hideLoadingBar();
			alert("현재 검색 시스템 점검 중입니다.\r\n\r\n최대한 빠른 시간 내에 정상화 되도록 최선을 다하겠습니다.	");	
		}else if (varCount.count == "0"){
			top.hideLoadingBar();
			//alert("선택하신 검색조건에 대한 상품 정보가 없습니다.      \n \n검색조건을 다시 선택해서  검색해보세요.");
			if (varTargetPage == "/view/fusion/Fusion.jsp" || varTargetPage == "/view/fusion/Fusion_Masterpiece.jsp" || varTargetPage == "/fashion/Listbody_Brand_Main.jsp"
				|| varTargetPage == "/view/Listbody_Fusion.jsp" || varTargetPage == "/view/Listbody_Fusion_Masterpiece.jsp"
				|| varTargetPage == "/fashion/clothes/include/Listbody_Style.jsp"
				|| varTargetPage == "/search/EnuriSearch.jsp"
				|| varTargetPage == "/fashion/brand/include/Listbody_Brand.jsp"){
				if (document.getElementById("keyword")){
					var	varTop = Position.cumulativeOffset(document.getElementById("keyword"))[1];
				}
			}else{
				if (document.getElementById("keyword")){
					var varTop = Position.cumulativeOffset(document.getElementById("keyword"))[1];
				}
			}			
			showNoResultMsg(varTop);
			getKeywordObj().focus();			
		}else{
			/*
			if (varTargetPage != "/view/fusion/Fusion.jsp" && varTargetPage != "/view/fusion/Fusion_Masterpiece.jsp"){
				top.viewLoadingBar();
			}
			*/
			if (varTargetPage == "/view/fusion/Fusion.jsp" || varTargetPage == "/view/fusion/Fusion_Masterpiece.jsp" || varTargetPage == "/fashion/Listbody_Brand_Main.jsp"
				|| varTargetPage == "/view/Listbody_Fusion.jsp" || varTargetPage == "/view/Listbody_Fusion_Masterpiece.jsp"
				|| varTargetPage == "/fashion/clothes/include/Listbody_Style.jsp"
				|| varTargetPage == "/fashion/brand/include/Listbody_Brand.jsp"){
				if (document.getElementById("keyword")){
					document.getElementById("keyword").value = convertSpecialKeyword(document.getElementById("keyword").value);
				}
			}else{
				if (varTargetPage != "/search/EnuriSearch.jsp"){
					document.frmList.hyphen_2.value = check2Hyphen(document.frmList.keyword.value)
				}								
				document.frmList.keyword.value = convertSpecialKeyword(document.frmList.keyword.value);
				if (document.getElementById("page_enuri")){
					document.getElementById("page_enuri").value = "";
					if (document.getElementById("brand_add_search")){
						if (document.getElementById("brand_add_search").value == "Y" ){
							document.getElementById("page_enuri").value = "1";
							document.getElementById("page").value = "2";
						}
					}
				}	
			}			
			if (varTargetPage == "/search/EnuriSearch.jsp"){
				if (document.frmList.factory && document.frmList.cate){
					if (document.frmList.factory.value.trim().length > 0 && document.frmList.cate.value.trim().length > 0){
						insertLog(5857);
					}	
					if (document.frmList.factory.value.trim().indexOf(",") > 0){
						insertLog(5933);
					}
					if (document.frmList.cate.value.trim().indexOf(",") > 0){
						insertLog(5932);
					}					
				}
				if (document.getElementById("searchkind")){
					if (document.getElementById("searchkind").value == "1"){
						if (document.frmList.m_price.value.trim().length > 0){
							insertLog(5866);
						}
						if (document.frmList.factory.value.trim().length > 0){
							insertLog(5866);
						}
					}else if(document.getElementById("searchkind").value == "2"){
						if (document.frmList.m_price.value.trim().length > 0){
							insertLog(5870);
						}
						if (document.frmList.shop_code.value.trim().length > 0){
							insertLog(5872);
						}																
					}else{
						if (document.frmList.m_price.value.trim().length > 0){
							insertLog(5862);
						}
						if (document.frmList.factory.value.trim().length > 0){
							insertLog(5864);
						}
					}
				}				
				setResearchValue();
			}	
			//tabLayerDataInsert();
			document.frmList.submit();
		}
	}
	var url = "";
	var param = "";
	var ca_code = "";
	if (varTargetPage == "/view/Listbody.jsp" || varTargetPage == "/view/Listbody_Social.jsp" || varTargetPage == "/include/IncEcouponList.jsp"){
		url = "/search/GetCountList.jsp";
	}else if (varTargetPage == "/view/Listbody_Mp3.jsp"){
		url = "/search/GetCountListMp3.jsp";
	}else if (varTargetPage == "/view/Listbody_Social_2013.jsp"){
		url = "/search/GetCountListSocial.jsp";
	}else if (varTargetPage == "/view/Listbody_Handphone.jsp"){
		url = "/search/GetCountListMp3.jsp";
	}else if (varTargetPage == "/view/Listbody_Printer.jsp"){
		url = "/search/GetCountListPrinter.jsp";
	}else if (varTargetPage == "/search/EnuriSearch.jsp"){
		url = "/search/GetCountListSearch.jsp";
	}else if (varTargetPage == "/view/fusion/Fusion.jsp" || varTargetPage == "/view/Listbody_Fusion.jsp" || varTargetPage == "/fashion/brand/include/Listbody_Brand.jsp"
		|| varTargetPage == "/fashion/Listbody_Brand_Main.jsp"
	){
		url = "/search/GetCountListFusion.jsp";
	}else if (varTargetPage == "/view/fusion/Fusion_Masterpiece.jsp" || varTargetPage == "/view/Listbody_Fusion_Masterpiece.jsp"){
		url = "/search/GetCountListFusionMasterpiece.jsp";
	}else if (varTargetPage == "/fashion/clothes/include/Listbody_Style.jsp"){
		url = "/search/GetCountListClothes.jsp";
	}else if (varTargetPage == "/view/Listbody_NewBrand.jsp"){
		url = "/search/GetCountListBrand.jsp";
	}
	if (varTargetPage == "/view/fusion/Fusion.jsp" || varTargetPage == "/view/fusion/Fusion_Masterpiece.jsp" || varTargetPage == "/fashion/Listbody_Brand_Main.jsp"
		|| varTargetPage == "/view/Listbody_Fusion.jsp" || varTargetPage == "/view/Listbody_Fusion_Masterpiece.jsp" || varTargetPage == "/fashion/brand/include/Listbody_Brand.jsp"
		|| varTargetPage == "/fashion/clothes/include/Listbody_Style.jsp" || varTargetPage == "/search/EnuriSearch.jsp"){
		param = "cate="+document.frmList.cate.value;
		ca_code = document.frmList.cate.value; 
	}else {
		param = "cate="+document.getElementById("cate").value;
		ca_code = document.getElementById("cate").value;
	}
	if(document.getElementById("factory")){
		if (document.getElementById("factory").value.indexOf(",") > 0){
			insertLog(10091);
		}				
		param = param + "&factory="+document.getElementById("factory").value.replace(/&/g,"%26").replace(/#/g,"%23")
	}
	if(document.getElementById("brand")){
		if (document.getElementById("brand").value.indexOf(",") > 0){
			insertLog(10091);
		}				
		param = param + "&brand="+document.getElementById("brand").value.replace(/&/g,"%26").replace(/#/g,"%23")
	}
	if (!directPriceCheck._f_return){
		if (document.getElementById("start_price") && document.getElementById("end_price")){
			document.getElementById("start_price").value = "";
			document.getElementById("end_price").value = "";			
		}
	}
	if (document.getElementById("start_price") && document.getElementById("end_price")){
		param = param + "&start_price="+document.getElementById("start_price").value;
		param = param + "&end_price="+document.getElementById("end_price").value;
	}
	directPriceCheck._f_return = false;
	if (document.getElementById("m_price")){
		if (document.getElementById("m_price").value.indexOf(",") > 0){
			insertLog(10089);
		}		
		param = param + "&m_price="+document.getElementById("m_price").value;
		if (document.getElementById("factory")){
			if (document.getElementById("factory").value.length > 0 && document.getElementById("m_price").value.length){
				insertLog(10092);
			}
		}
	}
	if (document.getElementById("spec")){
		param = param + "&spec="+document.getElementById("spec").value;
	}		
	if (document.getElementById("sel_spec")){
		param = param + "&sel_spec="+document.getElementById("sel_spec").value;
	}
	if (document.getElementById("condi")){
		param = param + "&condi="+document.getElementById("condi").value;
	}
	if (document.getElementById("shop_code")){
		param = param + "&shop_code="+document.getElementById("shop_code").value;
	}	
	
	//param = param + "&keyword="+document.getElementById("keyword").value;
	if (varTargetPage == "/view/fusion/Fusion.jsp" || varTargetPage == "/view/fusion/Fusion_Masterpiece.jsp" || varTargetPage == "/fashion/Listbody_Brand_Main.jsp"
		|| varTargetPage == "/view/Listbody_Fusion.jsp" || varTargetPage == "/view/Listbody_Fusion_Masterpiece.jsp"
		|| varTargetPage == "/fashion/clothes/include/Listbody_Style.jsp"
		|| varTargetPage == "/fashion/brand/include/Listbody_Brand.jsp"){
		if (document.getElementById("keyword")){
			param = param + "&keyword="+convertSpecialKeyword(document.getElementById("keyword").value).replace(/&/g,"%26").replace(/#/g,"%23");
			if (document.getElementById("keyword").value.trim().length != "" ){
				insertLog(5502);
				insertLogCate(5502,ca_code);
			}						
		}
		if(document.getElementById("sub_cate")){
			param = param + "&sub_cate="+document.getElementById("sub_cate").value;
		}		
	}else{	
		if (varTargetPage == "/search/EnuriSearch.jsp"){
			if (isResearchStatus()){
				param = param + "&keyword="+convertSpecialKeyword(document.frmList.rekeyword.value).replace(/&/g,"%26").replace(/#/g,"%23");
			}else{
				param = param + "&keyword="+convertSpecialKeyword(document.frmList.keyword.value).replace(/&/g,"%26").replace(/#/g,"%23");	
			}
			if (document.getElementById("in_keyword")){
				param = param + "&in_keyword="+convertSpecialKeyword(document.getElementById("in_keyword").value).replace(/&/g,"%26").replace(/#/g,"%23");
				if (document.getElementById("in_keyword").value.trim().length != "" ){
					insertLog(5502);
					insertLogCate(5502,ca_code);
				}									
			}			
		}else{
			param = param + "&keyword="+convertSpecialKeyword(document.frmList.keyword.value).replace(/&/g,"%26").replace(/#/g,"%23");
			if (document.frmList.keyword.value.trim().length != "" ){
				insertLog(5502);
				insertLogCate(5502,ca_code);
			}								
		}		
		if (varTargetPage == "/search/EnuriSearch.jsp"){
			param = param + "&hyphen_2="+document.getElementById("hyphen_2").value;
			if (document.getElementById("search_area")){
				param = param + "&search_area="+document.getElementById("search_area").value;
			}						
		}else{
			param = param + "&hyphen_2="+check2Hyphen(document.frmList.keyword.value);
		}
	}
	if (varTargetPage == "/view/Listbody_Printer.jsp"){
		param = param + "&prtmodelno="+document.getElementById("prtmodelno").value;
	}				
	if (document.getElementById("brand2no")){
		param = param + "&brand2no="+document.getElementById("brand2no").value;
	}
	if (document.getElementById("brandcate")){
		param = param + "&brandcate="+document.getElementById("brandcate").value;
	}
	if (document.getElementById("searchkind")){
		param = param + "&searchkind="+document.getElementById("searchkind").value;
	}
	if (document.getElementById("ismodelno")){
		param = param + "&ismodelno="+document.getElementById("ismodelno").value;
	}
	if (document.getElementById("gb1")){
		param = param + "&gb1="+document.getElementById("gb1").value;
	}
	if (document.getElementById("gb2")){
		param = param + "&gb2="+document.getElementById("gb2").value;
	}
	if (document.getElementById("gb1no")){
		param = param + "&gb2="+document.getElementById("gb1no").value;
	}	
	if (document.getElementById("gb1no")){
		param = param + "&gb1no="+document.getElementById("gb1no").value;
	}		
	if (document.getElementById("gb2no")){
		param = param + "&gb2no="+document.getElementById("gb2no").value;
	}	
	/*
	if (document.getElementById("brand_add_search")){
		param = param + "&brand_add_search="+document.getElementById("brand_add_search").value;
	}
	*/
	var varCateAddTabSearch = false;
	if (document.getElementById("cate_add_tab_search")){
		if (document.getElementById("cate_add_tab_search").value == "Y" ){
			if (document.getElementById("brand_add_search").value == "Y" ){
				param = param + "&brand_add_search=Y";
				varCateAddTabSearch = true;
			}
		}
	}
	if (document.getElementById("brand_add_search") && !varCateAddTabSearch){
		if (document.getElementById("brand_add_search").value == "Y" ){
			param = param + "&brand_add_search=";
			document.getElementById("brand_add_search").value = "";
		}else if(document.getElementById("brand_add_search").value == "YY"){
			param = param + "&brand_add_search=Y";
			//document.getElementById("brand_add_search").value = "Y";
		}
	}	
	if (document.getElementById("order_type")){
		var varform = document.select_form.order_type;
	    for (var i=0; i<varform.length; i++){ 
	        if (varform[i].checked){ 
	            var ckval = varform[i].value; 
	        } 
	    } 		
	    document.frmList.order_type.value = ckval; 
		param = param + "&order_type="+ckval;
	}	
	viewInLoadingBar("getCountList",'',modelno);
	var getCount = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:callBackgetCountList
		}
	);
	
}
function showAllFactory(){
	checkFactory.value = "";
	//factorySearch();
	fnSetCookie2010("pt","y");
	tabSearch();
}

function showAllBrand(){
	checkBrand.value = "";
	if(checkFactory.value !="" && typeof(checkFactory.value) != "undefined"){
		fnSetCookie2010("ft","y");
	}else{
		fnSetCookie2010("pt","y");
	}
	tabSearch();
}

function setPositionFactoryGo(){
	if (document.getElementById("factory_layer")){
		if (document.getElementById("factory_layer").style.display != "none"){
			if (document.getElementById("factorychk_"+checkFactory._prev_idx)){
				if (document.getElementById("hot_factory_layer") && checkFactory._prev_idx < 4){
					var varFactoryGoLeft = Position.cumulativeOffset(document.getElementById("factorychk_"+checkFactory._prev_idx))[0]-53;
					var varAddHeight = 34;
					if (BrowserDetect.browser == "Explorer"){
						varAddHeight = 4;
					}
					
					if(document.getElementById("price_layer")){
						if(document.getElementById("price_layer").style.display != "none" && BrowserDetect.browser != "Explorer"){
							varAddHeight = varAddHeight - 27;
						}
						if (BrowserDetect.browser == "Explorer" &&  BrowserDetect.version == 7){
							varAddHeight = varAddHeight + 7;
						}
						if(document.getElementById("price_layer").style.display != "none" && BrowserDetect.browser != "Explorer"){
							varAddHeight = varAddHeight - 27;
						}						
					}
					var varFactoryGoTop = Position.cumulativeOffset(document.getElementById("factorychk_"+checkFactory._prev_idx))[1] - Position.cumulativeOffset(document.getElementById("factory_layer"))[1]-varAddHeight;
					if (varFactoryGoLeft < 0){
						var varFactoryGoLeft = Position.cumulativeOffset(document.getElementById("factory_name_"+checkFactory._prev_idx))[0]+ document.getElementById("factory_name_"+checkFactory._prev_idx).offsetWidth-50;
					}
					
					document.getElementById("factory_go").style.display = "none";
					document.getElementById("hot_factory_go").style.left = varFactoryGoLeft+"px";
					document.getElementById("hot_factory_go").style.top = varFactoryGoTop+"px";
					document.getElementById("hot_factory_go").style.display = "";				
				}else{				
					if (document.getElementById("factorychk_"+checkFactory._prev_idx)){
						var varFactoryGoLeft = Position.cumulativeOffset(document.getElementById("factorychk_"+checkFactory._prev_idx))[0]-53;
						var varAddHeight = 34;
	
						if (document.getElementById("hot_factory_layer")){
							varAddHeight = 66;
						}
						if (BrowserDetect.browser == "Explorer"){
							varAddHeight = varAddHeight - 28;
						}										
						if (BrowserDetect.browser == "Explorer" &&  BrowserDetect.version == 7){
							varAddHeight = varAddHeight - 5;
						}						
						if(document.getElementById("price_layer")){
							if(document.getElementById("price_layer").style.display != "none" && BrowserDetect.browser != "Explorer"){
								varAddHeight = varAddHeight - 27;
							}
						}
						var varFactoryGoTop = Position.cumulativeOffset(document.getElementById("factorychk_"+checkFactory._prev_idx))[1] - Position.cumulativeOffset(document.getElementById("factory_layer"))[1]-varAddHeight;
						if (varFactoryGoLeft < 0){
							var varFactoryGoLeft = Position.cumulativeOffset(document.getElementById("factory_name_"+checkFactory._prev_idx))[0]+ document.getElementById("factory_name_"+checkFactory._prev_idx).offsetWidth-50;
						}
						if(document.getElementById("hot_factory_go")){
							document.getElementById("hot_factory_go").style.display = "none";
						}
						document.getElementById("factory_go").style.left = varFactoryGoLeft+"px";
						document.getElementById("factory_go").style.top = varFactoryGoTop+"px";
						document.getElementById("factory_go").style.display = ""				
					}
				}
			}
							
			var varCloseBtnTop = Position.cumulativeOffset(document.getElementById("factory_layer_inner"))[1]- Position.cumulativeOffset(document.getElementById("factory_layer"))[1]; 
			if (document.getElementById("hot_factory_layer")){
				varCloseBtnTop = varCloseBtnTop - document.getElementById("hot_factory_layer").offsetHeight; 
			}							

			document.getElementById("close_factory_btn").style.top = (varCloseBtnTop+5)+"px";
			
			if (document.getElementById("factory_layer_inner").style.overflowY == "auto" ){
				if (document.getElementById("hot_factory_layer")){
					document.getElementById("close_factory_btn").style.left = (document.getElementById("factory_layer").offsetWidth - 20)+"px";
				}else{
					document.getElementById("close_factory_btn").style.left = (document.getElementById("factory_layer").offsetWidth - 40)+"px";
				}
			}else{
				document.getElementById("close_factory_btn").style.left = (document.getElementById("factory_layer").offsetWidth - 20)+"px";
			}
		} 
	}
}

function setPositionBrandGo(){
	if (document.getElementById("brand_layer")){
		if (document.getElementById("brand_layer").style.display != "none"){
			if (document.getElementById("brandchk_"+checkBrand._prev_idx)){
				if (document.getElementById("hot_brand_layer") && checkBrand._prev_idx < 4){
					var varBrandGoLeft = Position.cumulativeOffset(document.getElementById("brandchk_"+checkBrand._prev_idx))[0]-53;
					var varAddHeight = 34;
					if (BrowserDetect.browser == "Explorer"){
						varAddHeight = 4;
					}
					
					if(document.getElementById("price_layer")){
						if(document.getElementById("price_layer").style.display != "none" && BrowserDetect.browser != "Explorer"){
							varAddHeight = varAddHeight - 27;
						}
						if (BrowserDetect.browser == "Explorer" &&  BrowserDetect.version == 7){
							varAddHeight = varAddHeight + 7;
						}
						if(document.getElementById("price_layer").style.display != "none" && BrowserDetect.browser != "Explorer"){
							varAddHeight = varAddHeight - 27;
						}						
					}
					var varBrandGoTop = Position.cumulativeOffset(document.getElementById("brandchk_"+checkBrand._prev_idx))[1] - Position.cumulativeOffset(document.getElementById("brand_layer"))[1]-varAddHeight;
					if (varBrandGoLeft < 0){
						var varBrandGoLeft = Position.cumulativeOffset(document.getElementById("brand_name_"+checkBrand._prev_idx))[0]+ document.getElementById("brand_name_"+checkBrand._prev_idx).offsetWidth-50;
					}
					
					document.getElementById("brand_go").style.display = "none";
					document.getElementById("hot_brand_go").style.left = varBrandGoLeft+"px";
					document.getElementById("hot_brand_go").style.top = varBrandGoTop+"px";
					document.getElementById("hot_brand_go").style.display = "";				
				}else{				
					if (document.getElementById("brandchk_"+checkBrand._prev_idx)){
						var varBrandGoLeft = Position.cumulativeOffset(document.getElementById("brandchk_"+checkBrand._prev_idx))[0]-53;
						var varAddHeight = 34;
	
						if (document.getElementById("hot_brand_layer")){
							varAddHeight = 66;
						}
						if (BrowserDetect.browser == "Explorer"){
							varAddHeight = varAddHeight - 28;
						}										
						if (BrowserDetect.browser == "Explorer" &&  BrowserDetect.version == 7){
							varAddHeight = varAddHeight - 5;
						}						
						if(document.getElementById("price_layer")){
							if(document.getElementById("price_layer").style.display != "none" && BrowserDetect.browser != "Explorer"){
								varAddHeight = varAddHeight - 27;
							}
						}
						var varBrandGoTop = Position.cumulativeOffset(document.getElementById("brandchk_"+checkBrand._prev_idx))[1] - Position.cumulativeOffset(document.getElementById("brand_layer"))[1]-varAddHeight;
						if (varBrandGoLeft < 0){
							var varBrandGoLeft = Position.cumulativeOffset(document.getElementById("brand_name_"+checkBrand._prev_idx))[0]+ document.getElementById("brand_name_"+checkBrand._prev_idx).offsetWidth-50;
						}
						if(document.getElementById("hot_brand_go")){
							document.getElementById("hot_brand_go").style.display = "none";
						}
						document.getElementById("brand_go").style.left = varBrandGoLeft+"px";
						document.getElementById("brand_go").style.top = varBrandGoTop+"px";
						document.getElementById("brand_go").style.display = ""				
					}
				}
			}
							
			var varCloseBtnTop = Position.cumulativeOffset(document.getElementById("brand_layer_inner"))[1]- Position.cumulativeOffset(document.getElementById("brand_layer"))[1]; 
			if (document.getElementById("hot_brand_layer")){
				varCloseBtnTop = varCloseBtnTop - document.getElementById("hot_brand_layer").offsetHeight; 
			}							

			document.getElementById("close_brand_btn").style.top = (varCloseBtnTop+5)+"px";
			
			if (document.getElementById("brand_layer_inner").style.overflowY == "auto" ){
				if (document.getElementById("hot_brand_layer")){
					document.getElementById("close_brand_btn").style.left = (document.getElementById("brand_layer").offsetWidth - 20)+"px";
				}else{
					document.getElementById("close_brand_btn").style.left = (document.getElementById("brand_layer").offsetWidth - 40)+"px";
				}
			}else{
				document.getElementById("close_brand_btn").style.left = (document.getElementById("brand_layer").offsetWidth - 20)+"px";
			}
		} 
	}
}

function unCheckAllFactory(){
	if (document.getElementById("hot_factory_go")){
		document.getElementById("hot_factory_go").style.display = "none";
	}		
	if (document.getElementById("factory_layer_inner")){
		if (document.getElementById("factorychk_all").checked){
			chkFactory = $("factory_layer_inner").getElementsBySelector('input[class="chkbox"]');
			for (i=0;i<chkFactory.length;i++){
				if (chkFactory[i].id != "factorychk_all"){
					chkFactory[i].checked = false;
					document.getElementById("factory_name_"+chkFactory[i].id.substring(11,chkFactory[i].id.length)).style.backgroundColor="#f9f9f9";
					document.getElementById("factory_name_"+chkFactory[i].id.substring(11,chkFactory[i].id.length)).style.color="#000000";
				}
			}
			checkFactory.value = "";

			var varFactoryGoLeft = Position.cumulativeOffset(document.getElementById("factorychk_all"))[0]-53;
			var varAddHeight = 34;
			if (document.getElementById("hot_factory_layer")){
				varAddHeight = 66;
			}
			if(document.getElementById("price_layer")){
				if(document.getElementById("price_layer").style.display != "none"){
					varAddHeight = varAddHeight - 27;
				}
			}
			var varFactoryGoTop = 0;
			if (varFactoryGoLeft < 0){
				var varFactoryGoLeft = Position.cumulativeOffset(document.getElementById("factory_name_all"))[0]+ document.getElementById("factory_name_all").offsetWidth-50;
			}			
			document.getElementById("factory_go").style.left = varFactoryGoLeft+"px";
			document.getElementById("factory_go").style.top = varFactoryGoTop+"px";
			document.getElementById("factory_go").style.display = ""				
			
		}else{
			document.getElementById("factory_go").style.display = "none";
		}
	}
}
function unCheckAllBrand(){
	if (document.getElementById("hot_brand_go")){
		document.getElementById("hot_brand_go").style.display = "none";
	}		
	if (document.getElementById("brand_layer_inner")){
		if (document.getElementById("brandchk_all").checked){
			chkBrand = $("brand_layer_inner").getElementsBySelector('input[class="chkbox"]');
			for (i=0;i<chkBrand.length;i++){
				if (chkBrand[i].id != "brandchk_all"){
					chkBrand[i].checked = false;
					document.getElementById("brand_name_"+chkBrand[i].id.substring(9,chkBrand[i].id.length)).style.backgroundColor="#f9f9f9";
					document.getElementById("brand_name_"+chkBrand[i].id.substring(9,chkBrand[i].id.length)).style.color="#000000";
				}
			}
			checkBrand.value = "";

			var varBrandGoLeft = Position.cumulativeOffset(document.getElementById("brandchk_all"))[0]-53;
			var varAddHeight = 34;
			if (document.getElementById("hot_brand_layer")){
				varAddHeight = 66;
			}
			if(document.getElementById("price_layer")){
				if(document.getElementById("price_layer").style.display != "none"){
					varAddHeight = varAddHeight - 27;
				}
			}
			var varBrandGoTop = 0;
			if (varBrandGoLeft < 0){
				var varBrandGoLeft = Position.cumulativeOffset(document.getElementById("brand_name_all"))[0]+ document.getElementById("brand_name_all").offsetWidth-50;
			}			
			document.getElementById("brand_go").style.left = varBrandGoLeft+"px";
			document.getElementById("brand_go").style.top = varBrandGoTop+"px";
			document.getElementById("brand_go").style.display = ""				
			
		}else{
			document.getElementById("brand_go").style.display = "none";
		}
	}
}
function tabValueCheck(){
	if (document.getElementById("price_layer_inner")){
		var chkPrice = $("price_layer_inner").getElementsBySelector('input[class="chkbox"]');
		var selectedPrice = "";
		for (i=0;i<chkPrice.length;i++){
			if (chkPrice[i].id != "pricechk_all" &&  chkPrice[i].id.indexOf("pricechk_group_") < 0 ){
				if (chkPrice[i].checked){
					if (selectedPrice == ""){
						selectedPrice = chkPrice[i].value;
					}else{
						if (selectedPrice.substring(selectedPrice.lastIndexOf(",")+1,selectedPrice.length) == chkPrice[i].value.substring(0,chkPrice[i].value.indexOf(","))){
							selectedPrice = selectedPrice.substring(0,selectedPrice.lastIndexOf(",")) + chkPrice[i].value.substring(chkPrice[i].value.lastIndexOf(","),chkPrice[i].value.length);
						}else{ 
							selectedPrice = selectedPrice + "," + chkPrice[i].value;
						}
					} 
				}
			}
		}
		/*
		if (selectedPrice.trim().length > 0){
			document.frmList.m_price.value = selectedPrice;
		}
		*/	
		if (selectedPrice != ""){
			document.frmList.key.value="minprice";
		}
		document.frmList.m_price.value = selectedPrice;	
	}
	if (typeof(checkFactory.value) != "undefined"){
		document.frmList.factory.value = checkFactory.value;
	}
	
	if (typeof(checkBrand.value) != "undefined"){
		document.frmList.brand.value = checkBrand.value;
	}

	if (typeof(checkShop.value) != "undefined"){
		document.frmList.shop_code.value = checkShop.value;
	}	
	if (document.getElementById("brand_add_search")){
		if (document.frmList.brand_add_search.value == "Y" && document.frmList.gb1.value == "" && document.frmList.gb2.value == ""){
			document.frmList.cate_add_tab_search.value = "Y";
			
			/*
			if (document.getElementById("page_enuri")){
				document.frmList.page_enuri.value="1";
				document.getElementById("page").value = "2";
			}
			*/	
		}
	}				
}
function tabSearch(){
	tabValueCheck();
	document.frmList.page.value = "";
	getCountList();

}
function webPriceSearch(){
	document.frmList.shop_code.value = "";
	tabValueCheck();
	document.frmList.page.value = "";
	/*
	if (varTargetPage != "/view/fusion/Fusion.jsp" && varTargetPage != "/view/fusion/Fusion_Masterpiece.jsp"){
		top.viewLoadingBar();
	}
	*/
	document.frmList.submit();
}
function shopSearch(){
	tabValueCheck();
	document.frmList.page.value = "";
	/*
	if (varTargetPage != "/view/fusion/Fusion.jsp" && varTargetPage != "/view/fusion/Fusion_Masterpiece.jsp"){
		top.viewLoadingBar();
	}
	*/
	//document.frmList.submit();
	getCountList();
}
function removeAllSearchCondition(){
	document.frmList.cate.value = "";
	//document.getElementById("pricechk_all").checked="true";
	unCheckAllPrice();
	if (typeof(checkFactory.value) != "undefined"){
		unCheckAllFactory();
	}

	if (typeof(checkShop.value) != "undefined"){
		unCheckAllShop();
	}
	if (top.document.body.scrollTop){
		top.document.body.scrollTop = "0px";
	}else{
		top.document.documentElement.scrollTop = "0px";
	}	
	tabSearch();
}
function removeFactoryAndPrice(cate){
	//document.getElementById("pricechk_all").checked="true";
	unCheckAllPrice();

	document.frmList.cate.value = cate;
	if (typeof(checkFactory.value) != "undefined"){
		checkFactory.value = "";
	}
	if (document.getElementById("factory")){
		document.frmList.factory.value = "";
	}
	if (document.getElementById("brand")){
		document.frmList.brand.value = "";
	}
	if (document.getElementById("condi")){
		document.frmList.condi.value = "";
	}
	if (typeof(checkShop.value) != "undefined"){
		checkShop.value = "";
	}
	if (document.getElementById("shop_code")){
		document.frmList.shop_code.value="";
	}
	tabSearch();
}

function removeFactory(){
	if (typeof(checkFactory.value) != "undefined"){
		checkFactory.value = "";
	}
	document.frmList.factory.value = "";
	if (typeof(checkShop.value) != "undefined"){
		checkShop.value = "";
	}
	document.frmList.shop_code.value="";
	tabSearch();
}

function setPositionShopGo(){
	if (document.getElementById("shop_layer")){
		if (document.getElementById("shop_layer").style.display != "none"){
			if (document.getElementById("shopchk_"+checkShop._prev_idx)){
				var varShopGoLeft = Position.cumulativeOffset(document.getElementById("shopchk_"+checkShop._prev_idx))[0]-53;
				var varShopGoTop = Position.cumulativeOffset(document.getElementById("shopchk_"+checkShop._prev_idx))[1] - Position.cumulativeOffset(document.getElementById("shop_layer"))[1]-2;
				if (varShopGoTop < 50){
					varShopGoTop -= 5;
				}
				if (varShopGoLeft < 0){
					var varShopGoLeft = Position.cumulativeOffset(document.getElementById("shop_name_"+checkShop._prev_idx))[0]+ document.getElementById("shop_name_"+checkShop._prev_idx).offsetWidth-50;
					
				}
				var varCloseBtnTop = Position.cumulativeOffset(document.getElementById("shop_layer_inner"))[1]- Position.cumulativeOffset(document.getElementById("shop_layer"))[1];
				document.getElementById("close_shop_btn").style.top = (varCloseBtnTop+5)+"px";				
				document.getElementById("shop_go").style.left = varShopGoLeft+"px";
				document.getElementById("shop_go").style.top = varShopGoTop+"px";
				document.getElementById("shop_go").style.display = ""
			}
			/*
			if (checkShop.value == ""){
				document.getElementById("shop_go").style.display = "none";
			}
			*/										
		}
	}
}
function showSpreadButton(){
	if (document.getElementById("startCateTab_")){
		if (document.getElementById("category_layer") && document.getElementById("category_layer_inner2")){
			setTimeout(function(){
				//var varSpreadHeight = 40;
				var varSpreadHeight = 80;
				if (document.getElementById("searchkind")){
					if (document.getElementById("searchkind").value == "1" || document.getElementById("searchkind").value == "2" || 
						(document.getElementById("stab_all").parentElement.style.display == "none" && document.getElementById("stab_enuri").parentElement.style.display == "none" ) || 
						(document.getElementById("stab_all").parentElement.style.display == "none" && document.getElementById("stab_web").parentElement.style.display == "none")){
						varSpreadHeight = 240;
						
					}
				}
				
				if (document.getElementById("category_layer_inner2").offsetHeight > varSpreadHeight ){
					
					var varLeft = Position.cumulativeOffset(document.getElementById("category_layer"))[0] + document.getElementById("category_layer_inner").offsetWidth - 85;					
					var varAddTop = 1;
					var varTop = Position.cumulativeOffset(document.getElementById("category_layer"))[1] + document.getElementById("category_layer").offsetHeight-varAddTop;
					
					if (document.getElementById("div_sperad_button")){
						document.getElementById("div_sperad_button").style.left = varLeft+"px";
						document.getElementById("div_sperad_button").style.top = varTop+"px";
						document.getElementById("div_sperad_button").style.display = "";
					}else{
						var varSpreadButtonObj = document.createElement("DIV");
						varSpreadButtonObj.id = "div_sperad_button";
						varSpreadButtonObj.style.position = "absolute";
						varSpreadButtonObj.style.top = varTop+"px"
						varSpreadButtonObj.style.left = varLeft+"px"
						varSpreadButtonObj.style.width="87";
						varSpreadButtonObj.style.height="20";
						varSpreadButtonObj.style.cursor="pointer"
						varSpreadButtonObj.onclick = function(){spreadCategoryLayer()};
						var varOpenBtn = "btn_open_chu.gif";
						if (document.getElementById("searchkind")){
							if (document.getElementById("searchkind").value != "" && (document.getElementById("searchkind").value == "2" || document.getElementById("startCateTab_"))){
								varOpenBtn = "btn_open.gif";
							}
							if (document.getElementById("stab_all").parentElement.style.display =="none" && document.getElementById("stab_enuri").parentElement.style.display =="none"){
								varOpenBtn = "btn_open.gif";
							}
						}							
						varSpreadButtonObj.innerHTML = "<img id=\"isc_open\" src=\""+var_img_enuri_com+"/2014/searchlist/"+varOpenBtn+"\" border=0 ><img id=\"isc_hide\" src=\""+var_img_enuri_com+"/2014/searchlist/btn_hidden.gif\" style=\"display:none;\" border=\"0\" >";
						
						//document.getElementById("wrap").insertBefore(varSpreadButtonObj,null);
						document.body.insertBefore(varSpreadButtonObj,null);
					}
					if (document.getElementById("div_body_catekeyword_layer")){
						document.getElementById("div_body_catekeyword_layer").style.marginTop = "30px";
					}
				}else{
	
					if (document.getElementById("div_sperad_button")){
						document.getElementById("div_sperad_button").style.display = "none";
					}
					if (document.getElementById("div_body_catekeyword_layer")){
						document.getElementById("div_body_catekeyword_layer").style.marginTop = "15px";
					}				
				}
			},500);	
		}else{
			if (showSpreadButton.f_cnt){
				showSpreadButton.f_cnt++;
			}else{
				showSpreadButton.f_cnt = 1;
			}
			if (showSpreadButton.f_cnt < 6){
				setTimeout(function(){showSpreadButton()},500);
			}
		}
	}
}
function checkNumberFormat(priceObj){
	var varInputPrice = priceObj.value.DeNumberFormat();
	var bAllZero = true;
	for (i=0;i<varInputPrice.length;i++){
		if (varInputPrice.charAt(i) != "0"){
			bAllZero = false;
		}
	}	
	if (bAllZero){
		priceObj.value = "0";
		if (priceObj.id == "txt_start_price"){
			document.getElementById("img_clear_start").src = var_img_enuri_com+"/2014/list/tab/delete.gif";
			document.getElementById("img_clear_start").style.cursor = "pointer";
		}
		if (priceObj.id == "txt_end_price"){
			document.getElementById("img_clear_end").src = var_img_enuri_com+"/2014/list/tab/delete.gif";
			document.getElementById("img_clear_end").style.cursor = "pointer";
		}		
	}else{
		if (varInputPrice != "0"){
			var varOutputPrice = "";
			var bZero = false;
			for (i=0;i<varInputPrice.length;i++){
				if (varInputPrice.charAt(i) == "0"){
					if (bZero){
						varOutputPrice += varInputPrice.charAt(i);
					}
				}else{
					bZero = true;
					varOutputPrice += varInputPrice.charAt(i);
				}
			}
			priceObj.value = varOutputPrice.NumberFormat();
		}
	}
}
function showScateLayer(cate,e,cate6,fromMain){
	
	
	insertLog(5469);
	if(!e) var e = window.event;
	if(e!= null){
		e.cancelBubble = true;
		e.returnValue = false;
		if (e.stopPropagation) {
			e.stopPropagation();
			e.preventDefault();
		}
	}
	var varRec = false;
	if (typeof(cate6) != "undefined"){
		if (cate6 == "r"){
			varRec = true;
		}
	}
	var varModTop = 2;
	/*
	var varModTop = 35;
	if (isResearchStatus()){
		varModTop = 102;
	}
	*/

	function callBackshowScateLayer(originalRequest){

		if (originalRequest.responseText.trim().length > 0){
			var varModLeft = 20;
			if (BrowserDetect.browser == "Explorer" & BrowserDetect.version == 6 ){
				varModLeft = 14;
			}
			if (document.getElementById("img_tab_search_loading")){
				document.getElementById("img_tab_search_loading").style.display = "none";
			}				

			document.getElementById("scate_layer").innerHTML = originalRequest.responseText;
			if (!varRec){
				document.getElementById("scate_layer").style.left = (Position.cumulativeOffset(document.getElementById("div_category_name_"+cate))[0]-varModLeft)+"px";
				document.getElementById("scate_layer").style.top = (Position.cumulativeOffset(document.getElementById("div_category_name_"+cate))[1]-varModTop)+"px";
			}else{
				document.getElementById("scate_layer").style.left = (Position.cumulativeOffset(document.getElementById("div_category_name_r_"+cate))[0]-varModLeft)+"px";
				document.getElementById("scate_layer").style.top = (Position.cumulativeOffset(document.getElementById("div_category_name_r_"+cate))[1]-varModTop)+"px";
			}
			
			if (typeof(fromMain) == "undefined" ){
				document.getElementById("scate_layer").style.display = "";
			}

			if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6){
				if (typeof(showScateLayer._reload) == "undefined"){
					document.getElementById("category_layer_inner").scrollTop = document.getElementById("category_layer_inner").scrollTop+1;
					document.getElementById("category_layer_inner").scrollTop = document.getElementById("category_layer_inner").scrollTop-1;
				}
				showScateLayer._reload = "";
			}
			setTimeout(function(){
				showScateLayer._f_orgHeight = 0;
				if (typeof(fromMain) != "undefined" ){
					var chkSCate = $("scate_layer").getElementsBySelector('img');
					for (var i=0;i<chkSCate.length;i++){
						if (chkSCate[i].src.indexOf("check_on.gif") > 0 ){
							var varselected_cate= chkSCate[i].id.substring(12,chkSCate[i].id.length)
							if (document.getElementById("loc_scate_"+varselected_cate)){
								document.getElementById("loc_scate_"+varselected_cate).innerHTML = document.getElementById("scate_check_name_"+varselected_cate).innerHTML;
							}
						}
					}
				}
				
				setTimeout(function(){
					if (document.getElementById("ul_scate_layer").offsetHeight > 132){
						document.getElementById("scate_layer").style.height = "132px";
						document.getElementById("scate_layer").style.overflowY="scroll";
						
					}else{
						document.getElementById("scate_layer").style.height = (document.getElementById("ul_scate_layer").offsetHeight+2) +"px";
						document.getElementById("scate_layer").style.overflowY="auto";
					}
					/*
					setTimeout(function(){
						if (document.getElementById("ul_scate_layer").offsetHeight > 132){
							document.getElementById("scate_layer").style.height = "132px";
							document.getElementById("scate_layer").style.overflowY="scroll";
						}else{
							document.getElementById("scate_layer").style.height = (document.getElementById("ul_scate_layer").offsetHeight+2) +"px";
							document.getElementById("scate_layer").style.overflowY="auto";
						}
					},200);
					*/				
				},300);
				
			},100);			
		}else{
			if (document.getElementById("img_tab_search_loading")){
				document.getElementById("img_tab_search_loading").style.display = "none";
			}				
		}
	}
	var url = "/search/getSCateLayer.jsp";
	var param = "";
	
	param = "cate="+cate;
	if (document.getElementById("in_keyword").value.trim().length > 0){
		param = param + "&in_keyword="+convertSpecialKeyword(document.getElementById("in_keyword").value).replace(/&/g,"%26").replace(/#/g,"%23");
	}
	if (varTargetPage == "/search/EnuriSearch.jsp"){
		if (isResearchStatus()){
			param = param + "&keyword="+convertSpecialKeyword(document.frmList.rekeyword.value).replace(/&/g,"%26").replace(/#/g,"%23");
		}else{
			param = param + "&keyword="+convertSpecialKeyword(document.frmList.keyword.value).replace(/&/g,"%26").replace(/#/g,"%23");	
		}	
	}else{
		param = param + "&keyword="+convertSpecialKeyword(document.frmList.keyword.value).replace(/&/g,"%26").replace(/#/g,"%23");
	}	
	param = param + "&hyphen_2="+document.getElementById("hyphen_2").value;
	param = param + "&searchkind="+document.getElementById("searchkind").value;
	param = param + "&nosale="+document.getElementById("nosale").value;
	param = param + "&etype="+document.getElementById("etype").value;
	if (document.getElementById("search_area")){
		param = param + "&search_area="+document.getElementById("search_area").value;
	}							
	if(document.getElementById("div_category_name_"+cate)){
		param = param + "&catename="+document.getElementById("div_category_name_"+cate).innerHTML;
	}else if(document.getElementById("div_category_name_r_"+cate)){
		param = param + "&catename="+document.getElementById("div_category_name_r_"+cate).innerHTML;
	}
	if (typeof(cate6) != "undefined"){
		if (!varRec){
			param = param + "&cate6="+cate6;
		}
	}else{
		if (typeof(checkcategory_value) != "undefined"){
			if (checkcategory_value != ""){
				cate6 = "";
				var arrcate = checkcategory_value.split(",");
				for(i=0;i<arrcate.length;i++){
					if(arrcate[i].length >= 4){
						cate6 = cate6 + arrcate[i] + ","; 
					}
				}	
				if (cate6 != ""){
					param = param + "&cate6="+cate6.substring(0,cate6.length-1);
				}					
			}
		}
	}
	
	if (document.getElementById("img_tab_search_loading")){
		var varWidth = 0;
		if (document.getElementById("wrap")){
			varWidth = document.getElementById("wrap").offsetWidth;
		}else{
			varWidth = document.body.offsetWidth;
		}
		document.getElementById("img_tab_search_loading").style.left = (varWidth/2 - 112)+"px";
		if(document.getElementById("sarr_"+cate)){
			document.getElementById("img_tab_search_loading").style.top = (Position.cumulativeOffset(document.getElementById("sarr_"+cate))[1]+50) + "px";
		}else if(document.getElementById("sarr_r_"+cate)){
			document.getElementById("img_tab_search_loading").style.top = (Position.cumulativeOffset(document.getElementById("sarr_r_"+cate))[1]+50) + "px";
		}
		document.getElementById("img_tab_search_loading").style.display = "";
	}
	
	var getSCateLayer = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:callBackshowScateLayer
		}
	);
}
function hideSCateLayer(){
	document.getElementById('scate_layer').style.display='none';
	if (typeof(showScateLayer._f_orgHeight) != "undefined"){
		if (showScateLayer._f_orgHeight > 0){
			document.getElementById("category_layer_inner").style.height = showScateLayer._f_orgHeight+"px";
		}
	}
}
function checkRpSearchKeyword(idx,strIsNone){
	insertLog(8166);
	if (document.getElementById("div_search_info_layer")){
		document.getElementById("div_search_info_layer").style.display = "none";
	}
	var chkResearch = $("div_re_seach").getElementsBySelector('input[class="chkbox"]');
	var varResearchChecked = false;
	var varResearchCheckedCnt = 0;
	
	for (var i=0;i<chkResearch.length;i++){
		if (chkResearch[i].checked){
			varResearchChecked = true;
			varResearchCheckedCnt++;
			varResearchKeyword = document.getElementById("div_searck_keyword_"+i).innerHTML;
		}
		/*
		if (typeof(strIsNone) == "string"){
			if (typeof(checkRpSearchKeyword._checked) == "undefined"){
				document.getElementById("div_searck_keyword_"+i).style.textDecoration = "line-through";
			}
		}
		*/
	}
	checkRpSearchKeyword._checked = "checked";
	checkRpSearchKeyword._searchStatus = 0;
	if (!varResearchChecked){
		checkRpSearchKeyword._searchStatus = 2;
	}
	if (varResearchCheckedCnt == 1 && varResearchKeyword.trim().length == 1){
		checkRpSearchKeyword._searchStatus = 3;
	}
	
	if (document.getElementById("chk_searck_keyword_"+idx).checked){
		document.getElementById("div_searck_keyword_"+idx).style.textDecoration = "";
	}else{
		document.getElementById("div_searck_keyword_"+idx).style.textDecoration = "line-through";
	}
	if(checkRpSearchKeyword._searchStatus == 0){
		document.getElementById("btn_research").src = var_img_enuri_com + "/2012/search/btn_re_search_02.gif";
	}else{
		document.getElementById("btn_research").src = var_img_enuri_com + "/2012/search/btn_re_search_03.gif";
	}
}
function reSearch(){
	insertLog(8167);
	var varsearchStatus = 0;
	if (typeof checkRpSearchKeyword._searchStatus != "undefined" ){
		varsearchStatus = checkRpSearchKeyword._searchStatus;
	}else{
		varsearchStatus =1;
	}
	if (varsearchStatus != 0 ){
		showReSearchLayer(varsearchStatus)	
	}else{
		setResearchValue();
		top.viewSearchReloadingBar();
		if (document.getElementById("in_keyword")){
			document.frmList.in_keyword.value = "";
		}
		document.frmList.searchkind.value = "";
		document.frmList.cate.value = "";
		document.frmList.m_price.value = "";	
		document.frmList.factory.value = "";
		document.frmList.brand.value = "";
		document.frmList.shop_code.value = "";		
		document.frmList.submit();
	}
}
function showReSearchLayer(type){
	var varLw = 244;
	var varLh = 48;
	var varMap = "225,7,238,19";
	if (type == 3 ){
		varLw = 214;
		varLh = 64;
		varMap = "196,7,206,18";
	}
	if (document.getElementById("div_search_info_layer")){
		document.getElementById("img_research_info").src = var_img_enuri_com+"/2012/search/search_info_layer_"+type+".png";
		document.getElementById("div_search_info_layer").style.width = varLw+"px";
		document.getElementById("div_search_info_layer").style.height = varLh+"px";
		document.getElementById("div_search_info_layer").innerHTML = "<img id='img_research_info' src=\""+var_img_enuri_com+"/2012/search/search_info_layer_"+type+".png\" border=0 usemap='#sip_map'/><map name='sip_map' id='sip_map'><area shape='rect' coords='"+varMap+"' href='#' onclick=\"document.getElementById('div_search_info_layer').style.display='none'\" /></map> ";
		document.getElementById("div_search_info_layer").style.display = "";
	}else{
		var varSearchInfoLayerObj = document.createElement("DIV");
		varSearchInfoLayerObj.id = "div_search_info_layer";
		varSearchInfoLayerObj.style.position = "absolute";
		varSearchInfoLayerObj.style.top = "110px"
		varSearchInfoLayerObj.style.left = "400px"
		varSearchInfoLayerObj.style.width= varLw+"px";
		varSearchInfoLayerObj.style.height = varLh+"px";
		varSearchInfoLayerObj.innerHTML = "<img id='img_research_info' src=\""+var_img_enuri_com+"/2012/search/search_info_layer_"+type+".png\" border=0 usemap='#sip_map'/><map name='sip_map' id='sip_map'><area shape='rect' coords='"+varMap+"' href='#' onclick=\"document.getElementById('div_search_info_layer').style.display='none'\" /></map> ";
		document.body.insertBefore(varSearchInfoLayerObj,null);
	}	
}
function setResearchValue(){
	/*
	if (isResearchStatus()){
		document.frmList.research.value = "Y";
		document.frmList.reorgkeyword.value = top.document.fmMainSearch.reorgkeyword.value;
		var chkResearch = $("div_re_seach").getElementsBySelector('input[class="chkbox"]');
		var varResearchKeyword = "";
		for (var i=0;i<chkResearch.length;i++){
			if (chkResearch[i].checked){
				varResearchKeyword += document.getElementById("div_searck_keyword_"+i).innerHTML + " "; 
			}
		}
		document.frmList.keyword.value = varResearchKeyword;		
	}
	*/
}
function isResearchStatus(){
	var bReturn = false;
	if (document.getElementById("div_re_seach")){
		if (document.getElementById("div_re_seach").style.display != "none"){
			bReturn = true;
		}
	}	
	return bReturn;	
}
function showNoResultMsg(varTop){
	var varNoResultCase = 0;
	if (document.getElementById("start_price") && document.getElementById("end_price") && document.getElementById("m_price")){
		if (document.getElementById("start_price").value.trim().length > 0 ||  document.getElementById("end_price").value.trim().length > 0 || document.getElementById("m_price").value.trim().length > 0){
			varNoResultCase = 3;
			if(document.getElementById("factory")){
				if (document.getElementById("factory").value.trim().length > 0){
					varNoResultCase = 1;
				}
			}
			if (document.getElementById("shop_code")){
				if (document.getElementById("shop_code").value.trim().length > 0){
					varNoResultCase = 2;
				}
			}
			if(document.getElementById("brand")){
				if (document.getElementById("brand").value.trim().length > 0){
					varNoResultCase = 4;
				}
			}
			
			if(document.getElementById("factory") && document.getElementById("brand")){
				if (document.getElementById("factory").value.trim().length > 0 && document.getElementById("brand").value.trim().length > 0){
					varNoResultCase = 5;
				}
			}
		}else{
			if (document.getElementById("factory") && document.getElementById("brand")){
				if (document.getElementById("factory").value.trim().length > 0 &&  document.getElementById("brand").value.trim().length > 0){
					varNoResultCase = 6;
				}
			}
		}
	}
	
	if (document.getElementById("div_innoresult")){
		setNoResultMsgObj(document.getElementById("div_innoresult"),varNoResultCase);
		document.getElementById("div_innoresult").style.display = "";
		if (document.getElementById("img_tab_search_loading")){
			document.getElementById("img_tab_search_loading").style.display = "none";
		}
	}else{
		var varNoResult = document.createElement("DIV");
		varNoResult.id = "div_innoresult";
		setNoResultMsgObj(varNoResult,varNoResultCase);
		document.body.insertBefore(varNoResult,null);
		if (document.getElementById("img_tab_search_loading")){
			document.getElementById("img_tab_search_loading").style.display = "none";
		}		
	}
	function setNoResultMsgObj(obj,varNoResultCase){
		obj.style.position = "absolute";
		obj.style.top = (varTop+30)+"px";
		obj.style.left = "350px";
		obj.style.zIndex="150";
		
		var varNoResulMsg = "";
		if (varNoResultCase == 0){
			varNoResulMsg = "<img src=\""+var_img_enuri_com+"/2012/search/search_layer.png\" border=0 usemap='#img_innoresult'><map name='img_innoresult' id='img_innoresult'><area shape='rect' coords='279,16,292,30' href='#' onclick=\"closeSearch_loading();closeInnoresult();return false;\"/></map>"
		}else if(varNoResultCase == 1){
			varNoResulMsg = "<img src=\""+var_img_enuri_com+"/2012/search/search_layer1.png\" border=0 usemap='#img_innoresult'><map name='img_innoresult' id='img_innoresult'><area shape='rect' coords='277,12,291,28'  href='#' onclick=\"closeSearch_loading();closeInnoresult();return false;\"/><area shape='rect' coords='185,105,239,139'  href='#' onclick=\"reSetSearchCondi('fact');return false;\"/></map>"
			insertLog(9511);
		}else if(varNoResultCase == 2){
			varNoResulMsg = "<img src=\""+var_img_enuri_com+"/2012/search/search_layer2.png\" border=0 usemap='#img_innoresult'><map name='img_innoresult' id='img_innoresult'><area shape='rect' coords='277,12,291,28' href='#' onclick=\"closeSearch_loading();closeInnoresult();return false;\"/><area shape='rect' coords='185,105,239,139'  href='#' onclick=\"reSetSearchCondi('shop');return false;\"/></map>"
			insertLog(9512);
		}else if(varNoResultCase == 4){
			varNoResulMsg = "<img src=\""+var_img_enuri_com+"/2012/search/search_layer4.png\" border=0 usemap='#img_innoresult'><map name='img_innoresult' id='img_innoresult'><area shape='rect' coords='277,12,291,28' href='#' onclick=\"closeSearch_loading();closeInnoresult();return false;\"/><area shape='rect' coords='185,105,239,139'  href='#' onclick=\"reSetSearchCondi('brand');return false;\"/></map>"
			insertLog(12919);
		}else if(varNoResultCase == 5){
			varNoResulMsg = "<img src=\""+var_img_enuri_com+"/2012/search/search_layer5.png\" border=0 usemap='#img_innoresult'><map name='img_innoresult' id='img_innoresult'><area shape='rect' coords='277,12,291,28' href='#' onclick=\"closeSearch_loading();closeInnoresult();return false;\"/><area shape='rect' coords='185,105,239,139'  href='#' onclick=\"reSetSearchCondi('fact+brand');return false;\"/></map>"
			insertLog(12926);
		}else if(varNoResultCase == 6){
			varNoResulMsg = "<img src=\""+var_img_enuri_com+"/2012/search/search_layer6.png\" border=0 usemap='#img_innoresult'><map name='img_innoresult' id='img_innoresult'><area shape='rect' coords='277,12,291,28' href='#' onclick=\"closeSearch_loading();closeInnoresult();return false;\"/><area shape='rect' coords='185,105,239,139'  href='#' onclick=\"reSetSearchCondi('brand');return false;\"/></map>"
			insertLog(12921);
		}else{
			varNoResulMsg = "<img src=\""+var_img_enuri_com+"/2012/search/search_layer3.png\" border=0 usemap='#img_innoresult'><map name='img_innoresult' id='img_innoresult'><area shape='rect' coords='277,14,291,27' href='#' onclick=\"closeSearch_loading();closeInnoresult();return false;\"/></map>"
		}
		
		obj.innerHTML = varNoResulMsg;
	}
}
function closeSearch_loading(){
	if (document.getElementById("img_tab_search_loading")){
		document.getElementById("img_tab_search_loading").style.display = "none";
	}
}
function closeInnoresult(){
	if (document.getElementById("div_innoresult")){
		document.getElementById("div_innoresult").style.display = "none";
	}
}
function reSetSearchCondi(con){
	if (directPriceCheck._f_noresult){
		directPriceCheck._f_return = true;
		directPriceCheck._f_noresult = false;
	}
	if (con == "fact"){
		insertLog(9477);
		showAllFactory();
	}else if (con == "shop"){
		insertLog(9478);
		showAllShop();
	}else if (con == "brand"){
		insertLog(12922);
		showAllBrand();
	}else if (con == "fact+brand"){
		insertLog(12927);
		showAllFactory();
		showAllBrand();
	}
}
function tabLayerDataInsert(){
	if(document.getElementById("factory") && document.getElementById("factory").value.trim().length > 0){
		if (document.getElementById("factory_layer_inner")){
			document.getElementById("factory_layer_inner").scrollTop = "0px"
		}		
		top.document.getElementById("bodyFactoryTab").innerHTML =  document.getElementById("factory_layer").innerHTML;
	}	
	/*
	if(document.getElementById("m_price") && document.getElementById("m_price").value.trim().length > 0){
		top.document.getElementById("bodyPriceTab").innerHTML =  document.getElementById("price_layer").innerHTML;
	}else if(document.getElementById("start_price") && document.getElementById("start_price").value.trim().length > 0 && document.getElementById("end_price") && document.getElementById("end_price").value.trim().length > 0){
		top.document.getElementById("bodyPriceTab").innerHTML =  document.getElementById("price_layer").innerHTML;
	}
	*/
}
function insertInitPriceTab(){
	/*
	var varInitPriceTab = "<div id=\"price_layer_top\" ><img src=\""+ var_img_enuri_com + "/2010/images/view/price_box01_a.gif\" border=\"0\"  style=\"float:left\"><img src=\""+ var_img_enuri_com + "/2010/images/view/price_box02.gif\" border=\"0\"  style=\"float:right\"></div>";
	varInitPriceTab += "<div id=\"price_layer_inner\">";
	varInitPriceTab += "<div style=\"width:95%;height:30px;margin:auto;\">";
	varInitPriceTab += "<div style=\"float:left;height:30px;line-height:30px;font-size:11px;width:35%\">";
	varInitPriceTab += "<span style=\"text-decoration:underline;cursor:pointer;display:block;float:left;\" onclick=\"showAllPrice()\">전체가격</span>";			
	varInitPriceTab += "</div>";
	varInitPriceTab += "<div style=\"float:left;margin-top:5px;display:inline;width:60%\">";
	varInitPriceTab += "<span id=\"txt_select_title\" onclick=\"showAllPrice()\">선택<span style=\"font-weight:bold\">할</span> 가격: </span>";
	varInitPriceTab += "<input type=\"text\" tabindex=\"23\" id=\"txt_start_price\" value=\"\" size=\"10\" onkeydown=\"enterChk(event)\" onkeyup=\"inputPriceCheck(this)\" onfocusout=\"checkNumberFormat(this)\">원 <img src=\"" + var_img_enuri_com + "/2010/images/view/wave.gif\" id=\"img_continual\" align=\"absmiddle\"> <input type=\"text\" tabindex=\"24\" id=\"txt_end_price\" name=\"end_price\" value=\"\" size=\"10\" onkeydown=\"enterChk(event)\" onkeyup=\"inputPriceCheck(this)\"  onfocusout=\"checkNumberFormat(this)\">원";
	varInitPriceTab += "<img src=\"" + var_img_enuri_com + "/2012/list/btn_go_ani.gif\" border=\"0\" align=\"absmiddle\" style=\"margin-right:5px;cursor:pointer;display:none\" id=\"btn_directsearch\" onclick=\"directPriceSearch()\">";
	varInitPriceTab += "<span style=\"font-size:9pt;color:#757575\">←</span><span style=\"font-size:11px;color:#757575\"> 직접입력가능</span>";
	varInitPriceTab += "</div>";				
	varInitPriceTab += "</div>";
	varInitPriceTab += "<img src=\""+var_img_enuri_com+"/2010/images/view/close_tab_layer.gif\" class=\"img_button\" border=\"0\" onclick=\"togglePriceLayer()\" align=\"top\" style=\"position:relative;top:-25px;float:right;right:5px;\"/>";
	varInitPriceTab += "<div style=\"width:835px;clear:both;margin:auto;height:96px;\">";
	varInitPriceTab += "</div>";
	varInitPriceTab += "<div id=\"price_layer_bottom\" ><img src=\""+var_img_enuri_com+"/2010/images/view/price_box04.gif\" border=\"0\" align=\"absmiddle\" style=\"float:left\"><img src=\""+var_img_enuri_com+"/2010/images/view/price_box03.gif\" border=\"0\" align=\"absmiddle\" style=\"float:right\"></div>";	
	
	document.getElementById("price_layer").innerHTML = varInitPriceTab;
	document.getElementById("tab_price").src = var_img_enuri_com + "/2014/list/tab/price_tab_on.gif";
	document.getElementById("price_layer").style.display = "";
	*/
	insertInitPriceTab._open = true;
}
function showTabLoadingImg(){
	if (document.getElementById("img_tab_search_loading")){
		var varWidth = 0;
		if (document.getElementById("wrap")){
			varWidth = document.getElementById("wrap").offsetWidth;
		}else{
			varWidth = document.body.offsetWidth;
		}
		document.getElementById("img_tab_search_loading").style.left = (varWidth/2 - 112)+"px";
		document.getElementById("img_tab_search_loading").style.top = Position.cumulativeOffset(document.getElementById("tab"))[1] + "px";
		document.getElementById("img_tab_search_loading").style.display = "";
	}
}

function showFactoyLoadingImg(modelno){
	if (document.getElementById("img_tab_search_loading")){
		var varWidth = 0;
		if (document.getElementById("wrap")){
			varWidth = document.getElementById("wrap").offsetWidth;
		}else{
			varWidth = document.body.offsetWidth;
		}
		document.getElementById("img_tab_search_loading").style.left = (varWidth/2 - 112)+"px";
		if(modelno!=""){
			document.getElementById("img_tab_search_loading").style.top = Position.cumulativeOffset(document.getElementById("td_gml_"+modelno))[1] + "px";
		}else{
			document.getElementById("img_tab_search_loading").style.top = Position.cumulativeOffset(document.getElementById("tab"))[1] + "px";
		}
		document.getElementById("img_tab_search_loading").style.display = "";
	}
}

function viewInLoadingBar(functionName,param1,modelno){
	if(functionName=="getCountList"){
		showFactoyLoadingImg(modelno);
	}else{
		showTabLoadingImg();
	}
	viewInLoadingBar._functionName = functionName;
	if (typeof(param1) != "undefined"){
		viewInLoadingBar._param1 = param1;
	}
}
function initCategoryTabSize(){	
	var varSpreadHeight = 40;
	if (document.getElementById("searchkind")){
		if (document.getElementById("searchkind").value == "1" || document.getElementById("searchkind").value == "2" ||
		   (document.getElementById("stab_all").parentElement.style.display == "none" && document.getElementById("stab_enuri").parentElement.style.display == "none" ) || 
		   (document.getElementById("stab_all").parentElement.style.display == "none" && document.getElementById("stab_web").parentElement.style.display == "none")				
		){
			varSpreadHeight = 240;
		}
	}
	
	if (document.getElementById("category_layer_inner2").offsetHeight >= varSpreadHeight ){
		if (document.getElementById("searchkind").value == "" ){
			if ((document.getElementById("stab_all").parentElement.style.display == "none" && document.getElementById("stab_enuri").parentElement.style.display == "none" ) || 
				(document.getElementById("stab_all").parentElement.style.display == "none" && document.getElementById("stab_web").parentElement.style.display == "none")){
				document.getElementById("category_layer_inner").style.height = "240px";
				document.getElementById("category_layer").style.height = "240px";
			}else{				
				if (document.getElementById("rec_category_layer_social") && j$('#rec_category_layer_social').css('display') != 'none'){					
					document.getElementById("category_layer_inner").style.height = "80px";
					document.getElementById("category_layer").style.height = "80px";					
				}else{
					document.getElementById("category_layer_inner").style.height = "43px";
					document.getElementById("category_layer").style.height = "43px";					
				}
			}
		}else{
			document.getElementById("category_layer_inner").style.height = "240px";
			document.getElementById("category_layer").style.height = "240px";					
		}
	}else{		
		var varModHeight = document.getElementById("category_layer_inner2").scrollHeight+5;
		document.getElementById("category_layer_inner").style.height = varModHeight+"px";
		document.getElementById("category_layer").style.height = varModHeight+"px";
	}
	
}
function clearTxtPrice(_t){
	if (_t == 'S'){
		document.getElementById("img_clear_start").src = var_img_enuri_com+"/2014/list/tab/price_box_04.gif";
		document.getElementById("img_clear_start").style.cursor = "default";
		document.getElementById("txt_start_price").value = "";
		document.getElementById("txt_start_price").focus();
	}else{
		document.getElementById("img_clear_end").src = var_img_enuri_com+"/2014/list/tab/price_box_04.gif"
		document.getElementById("img_clear_end").style.cursor = "default";
		document.getElementById("txt_end_price").value = "";
		document.getElementById("txt_end_price").focus();
	}
}
function hideClear(_t){
	if (_t == 'S'){
		document.getElementById("img_clear_start").src = var_img_enuri_com+"/2014/list/tab/price_box_04.gif";
		document.getElementById("img_clear_start").style.cursor = "default";
		document.getElementById("img_clear_start").onclick = function(){
		}
	}else{
		document.getElementById("img_clear_end").src = var_img_enuri_com+"/2014/list/tab/price_box_04.gif"
		document.getElementById("img_clear_end").style.cursor = "default";
		document.getElementById("img_clear_end").onclick = function(){
		}		
	}
}
function showFactorySort(){
	if (document.getElementById("factory_sort").style.display != "none"){
		document.getElementById("factory_sort").style.display = "none";
		document.getElementById("toggle_factory_sort").src = var_img_enuri_com + "/2010/images/view/newdown.gif";
	}else{
		setPositionFactorySort();
		document.getElementById("factory_sort").style.display = "";
		document.getElementById("toggle_factory_sort").src = var_img_enuri_com + "/2010/images/view/newdown_close.gif";
	}
}
function setPositionFactorySort(){
	if (document.getElementById("factory_sort")){
		var varAddV = 0;
		
		if (getBrowserName() == "msie8"){
			varAddV = 1;
		}
		if (BrowserDetect.browser == "Explorer" &&  BrowserDetect.version == 7){
			varAddV = 4;
		}
		document.getElementById("factory_sort").style.left = (Position.cumulativeOffset($("selected_factory_mode"))[0]-3-varAddV)+"px";

		var varFactoryAddHeight = false;
		if(document.getElementById("price_layer")){
			if(document.getElementById("price_layer").style.display != "none"){
				varFactoryAddHeight = true;
			}
		}
	
		varFactoryGoTop = Position.cumulativeOffset($("selected_factory_mode"))[1]-Position.cumulativeOffset(document.getElementById("factory_layer"))[1]+17-varAddV;
		if (BrowserDetect.browser == "Explorer" &&  BrowserDetect.version == 7){
			varFactoryGoTop +=4;
		}
		document.getElementById("factory_sort").style.top = varFactoryGoTop+"px";
	}
}

function showBrandSort(){
	if (document.getElementById("brand_sort").style.display != "none"){
		document.getElementById("brand_sort").style.display = "none";
		document.getElementById("toggle_brand_sort").src = var_img_enuri_com + "/2010/images/view/newdown.gif";
	}else{
		setPositionBrandSort();
		document.getElementById("brand_sort").style.display = "";
		document.getElementById("toggle_brand_sort").src = var_img_enuri_com + "/2010/images/view/newdown_close.gif";
	}
}
function setPositionBrandSort(){
	if (document.getElementById("brand_sort")){
		var varAddV = 0;
		
		if (getBrowserName() == "msie8"){
			varAddV = 1;
		}
		if (BrowserDetect.browser == "Explorer" &&  BrowserDetect.version == 7){
			varAddV = 4;
		}
		document.getElementById("brand_sort").style.left = (Position.cumulativeOffset($("selected_brand_mode"))[0]-3-varAddV)+"px";

		var varBrandAddHeight = false;
		if(document.getElementById("price_layer")){
			if(document.getElementById("price_layer").style.display != "none"){
				varBrandAddHeight = true;
			}
		}
	
		varBrandGoTop = Position.cumulativeOffset($("selected_brand_mode"))[1]-Position.cumulativeOffset(document.getElementById("brand_layer"))[1]+17-varAddV;
		if (BrowserDetect.browser == "Explorer" &&  BrowserDetect.version == 7){
			varBrandGoTop +=4;
		}
		document.getElementById("brand_sort").style.top = varBrandGoTop+"px";
	}
}

function sort_factory(sort,cate,org_cate){
	function showSortedFactoryLayer(originalRequest){
		document.getElementById("factory_layer_inner").innerHTML = originalRequest.responseText;
		var varSort = "";
		if (sort == "G"){
			varSort = "<p>가나다 순</p>";
		}else if(sort == "C"){
			varSort = "<p>상품수 순</p>";
		}else if(sort == "P"){
			varSort = "<p>인기도 순</p>";
		}
		document.getElementById("selected_factory_mode").innerHTML = varSort;
		//document.getElementById("factory_sort").style.display="none";
		showFactorySort();
	}	
	if (sort == "G"){
		insertLog(4492);
	}else if(sort == "C"){
		insertLog(4493);
	}else if(sort == "P"){
		insertLog(4494);
	}	
	chkFactory = $("factory_layer_inner").getElementsBySelector('input[class="chkbox"]');
	var varHotCnt = 0;
	if (document.getElementById("hot_factory_layer")){
		varHotCnt = $("hot_factory_layer").getElementsBySelector('input[class="chkbox"]').length;
	}
	
	var varFactoryUrl = "";
	for (i=0;i<chkFactory.length;i++){
		var varFactoryName = "";
		var varFactoryMallCnt = "";
		var varFactoryPopular = "";
		var varFactoryEtc = "";
		var varFactoryChecked = "";
		if (chkFactory[i].id != "factorychk_all"){
			varFactoryName = chkFactory[i].value.replace(/&/g,"^38^");
			varFactoryName = varFactoryName.replace(/#/g,"^39^"); 
			varFactoryMallCnt = document.getElementById("factory_mall_cnt_"+chkFactory[i].id.substring(11,chkFactory[i].id.length)).value;
			varFactoryPopular = document.getElementById("factory_popular_"+chkFactory[i].id.substring(11,chkFactory[i].id.length)).value;
			varFactoryEtc = document.getElementById("factory_etc_"+chkFactory[i].id.substring(11,chkFactory[i].id.length)).value;
			if (varFactoryEtc == ""){
				varFactoryEtc = "0"
			}
			if (chkFactory[i].checked){
				varFactoryChecked = "1";
			}else{
				varFactoryChecked = "0";
			}
			varFactoryUrl = varFactoryUrl + varFactoryName+"*"+varFactoryMallCnt+"*"+varFactoryPopular+"*"+varFactoryEtc+"*"+varFactoryChecked+"`";
		}
	}

	varFactoryUrl = "factory="+varFactoryUrl+"&sort="+sort+"&cate="+cate+"&org_cate="+org_cate+"&hotcnt="+varHotCnt;
	var url = "/include/IncFactoryLayerSort.jsp";
	var getFactoryInfo = new Ajax.Request(
		url,
		{
			method:'post',parameters:varFactoryUrl,onComplete:showSortedFactoryLayer
		}
	);		
}

function sort_brand(sort,cate,org_cate){
	function showSortedBrandLayer(originalRequest){
		document.getElementById("brand_layer_inner").innerHTML = originalRequest.responseText;
		var varSort = "";
		if (sort == "G"){
			varSort = "<p>가나다 순</p>";
		}else if(sort == "C"){
			varSort = "<p>상품수 순</p>";
		}else if(sort == "P"){
			varSort = "<p>인기도 순</p>";
		}
		document.getElementById("selected_brand_mode").innerHTML = varSort;
		//document.getElementById("factory_sort").style.display="none";
		showBrandSort();
	}	
	if (sort == "G"){
		insertLog(4492);
	}else if(sort == "C"){
		insertLog(4493);
	}else if(sort == "P"){
		insertLog(4494);
	}	
	chkBrand = $("brand_layer_inner").getElementsBySelector('input[class="chkbox"]');
	var varHotCnt = 0;
	if (document.getElementById("hot_brand_layer")){
		varHotCnt = $("hot_brand_layer").getElementsBySelector('input[class="chkbox"]').length;
	}
	
	var varBrandUrl = "";
	for (i=0;i<chkBrand.length;i++){
		var varBrandName = "";
		var varBrandMallCnt = "";
		var varBrandPopular = "";
		var varBrandEtc = "";
		var varBrandChecked = "";
		if (chkBrand[i].id != "brandchk_all"){
			varBrandName = chkBrand[i].value.replace(/&/g,"^38^");
			varBrandName = varBrandName.replace(/#/g,"^39^"); 
			varBrandMallCnt = document.getElementById("brand_mall_cnt_"+chkBrand[i].id.substring(9,chkBrand[i].id.length)).value;
			varBrandPopular = document.getElementById("brand_popular_"+chkBrand[i].id.substring(9,chkBrand[i].id.length)).value;
			varBrandEtc = document.getElementById("brand_etc_"+chkBrand[i].id.substring(9,chkBrand[i].id.length)).value;
			if (varBrandEtc == ""){
				varBrandEtc = "0"
			}
			if (chkBrand[i].checked){
				varBrandChecked = "1";
			}else{
				varBrandChecked = "0";
			}
			varBrandUrl = varBrandUrl + varBrandName+"*"+varBrandMallCnt+"*"+varBrandPopular+"*"+varBrandEtc+"*"+varBrandChecked+"`";
		}
	}

	varFactoryUrl = "brand="+varBrandUrl+"&sort="+sort+"&cate="+cate+"&org_cate="+org_cate+"&hotcnt="+varHotCnt;
	var url = "/include/IncBrandLayerSort.jsp";
	var getFactoryInfo = new Ajax.Request(
		url,
		{
			method:'post',parameters:varFactoryUrl,onComplete:showSortedBrandLayer
		}
	);		
}