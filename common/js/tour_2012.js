var varidx = 1;
//검색 리스트 결과 나옴 
var isSearch = false;
var isSearchLoading = false;
//검색 고버튼 눌렀을때  
var isSearchBtnClick = false;
var IMG_ENURI_COM = "http://img.enuri.info";
//기본조건 검색
var tmpDefaultSearchParam = "";
//최대값 최소값
var intTravelMinPrice = 0;
var intTravelMaxPrice = 0;
//버튼 VIEW FLAG 값
var viewBtn = "N";
// Detail Info View Flag
var detailViewFlag = false;
// 현재 위치 저장
var strCurHtml = "";
// 경고창 flag들
var div_tour_layer_3tour_flag = true; 
var div_tour_air_3_flag = true;
var div_tour_factory_3_flag = true;
var div_tour_nation_5_flag = true;

function cmdTravelTop(){
	CmdLink('/tour2012/Tour_Index.jsp');
}
function godirecttour(shopCode){
	if(typeof(shopCode)=="undefined") return;	
	var newWin = window.open("/tour2012/Direct_Tour.jsp?shop_code="+shopCode);
	newWin.focus();
}
function cmdTravelDefaultSearch(param,type){
	function cmdTravelDefaultGetcount(originalRequest){
		eval("arrReturn = " + originalRequest.responseText);
		var cnt = eval("arrReturn.count");
		if (cnt=="0"){
			if (tmpDefaultSearchParam.indexOf("subject=")>0){
				// 검색후 상품이 없을때 말풍선 안뜨게 
				//$("img_result_subjectnone").style.display = "block";
				alert("입력하신 검색어가 포함된 여행상품이 없습니다.\n검색어를 변경하여 다시 검색해 보세요");
			}else{
				// 검색 결과 없을때 말풍선 보이게 하는 부분
				//$("img_result_none").style.display = "block";
				alert("선택하신 조건의 여행상품이 없습니다.\n조건을 변경해서 다시 검색해 보세요");
			}
			//loadingbaroff();
		}else{
			//검색 리스트 결과 나옴
			isSearch = true;
			isSearchBtnClick = true;
			$("div_searchresultmap").style.display = "block";
			var sidx;
			var eidx;
			sidx = tmpDefaultSearchParam.indexOf("subject=")+8;
			eidx = tmpDefaultSearchParam.indexOf("&",sidx);
			var subject = tmpDefaultSearchParam.substring(sidx,eidx);
			if (subject!="" && subject.length>1){
				tmpDefaultSearchParam = tmpDefaultSearchParam.substring(0,sidx) + encodeURIComponent(subject) + tmpDefaultSearchParam.substring(eidx);
			}else{
				param = "";
			}
			// 디테일 설정 파라미터 추가
			var tempStrParameter = "";
			tempStrParameter = tmpDefaultSearchParam;
			var strDetailSearchParameter = detailSearchParameter();
			if (strDetailSearchParameter.length > 0 && strDetailSearchParameter !=""){
				tempStrParameter = tempStrParameter + strDetailSearchParameter;
			} 
			$("tbl_main_middle").style.display = "none";
			//$("sponsor_link").style.display = "none";
			//$("red_link").style.display = "none";
			//$("sp_layer").style.display = "none";

			$("travelListFrame").style.display = "block";
			$("travelListFrame").src = "/tour2012/Tour_Listbody.jsp?"+tempStrParameter;
			if (typeof(type) == "undefined"){
				var searchParameter = makeSearchParameter();
				cmdGetCountChange(searchParameter);
			}
		}
		if(!isSearch){
			$("main_resultmap_getcntline").style.display = "none";
		}else{
			$("resultmap_getcntline").style.display = "none";
		}
		//$("div_go_search").style.display = "none";
		//$("div_go_search_default").style.display = "block";
	}
	
	//loadingbaron();
	$("main_resultmap_getcntline").style.display="none";
	param = getBeforeParamCheck(param);
	if (param && param!=""){
		// 디테일 설정 파라미터 추가
		var strDetailSearchParameter = detailSearchParameter();
		if (typeof (strDetailSearchParameter) != "undefined"){
			if (strDetailSearchParameter.length > 0 && strDetailSearchParameter !=""){
				param += strDetailSearchParameter;
			} 
			tmpDefaultSearchParam = param;
			//현재 조건에 관한 상품이 몇개 있는지 조사
			var url = "/tour2012/GetCount.jsp";
			var param = "rtype=count&" + param;
			//alert(param);
			var getRec = new Ajax.Request(
				url,
				{
					method:'get',parameters:param,onComplete:cmdTravelDefaultGetcount
				}
			);
		}
	}
}

// 최근본 상품 클릭시 이동
function cmdTravelRedirect(param, nocpc){
	var w = window.screen.width;
	var h = screen.availHeight;
	if (nocpc){
		var win = window.open("/move/Redirect_Tour.jsp?model_subno="+param+"&nocpc=Y","_blank");
	}else{
		var win = window.open("/move/Redirect_Tour.jsp?model_subno="+param,"_blank");
	}
	win.focus();
}
function cmdUrgentGoods(pageNum){
	$("travel_mainurgency").innerHTML = "";
	var url = "/tour2012/Inc_Main_Urgency.jsp";
	var param = "pageNum="+pageNum;
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:inputUrgentGoods
		}
	);
}
function inputUrgentGoods(originalRequest){
	$("travel_mainurgency").innerHTML = originalRequest.responseText;
}
function cmdMonthlyGoods(idx){
	
	varidx = idx;
	var monthlyImg = document.getElementsByName("img_monthly");
	for (i=1;i<=monthlyImg.length;i++){
		$("img_monthly"+i).src = $("img_monthly"+i).src.replace("tabmenu_A"+i+"_ov.gif","tabmenu_A"+i+".gif");
		$("travel_mainlist_"+i).style.display = "none";
	}
	$("travel_mainlist_"+idx).style.display = "block";
	$("img_monthly"+idx).src = $("img_monthly"+idx).src.replace("tabmenu_A"+idx+".gif","tabmenu_A"+idx+"_ov.gif");

	if ($("travel_mainlist_"+idx).innerHTML==""){
		var url = "/tour2012/Inc_Main_ManageTravels.jsp";
		var param = "continent=A"+idx;
		var getRec = new Ajax.Request(
			url,
			{
				method:'get',parameters:param,onComplete:inputMonthlyGoods
			}
		);
	}else{
	}
}
function inputMonthlyGoods(originalRequest){
	$("travel_mainlist_"+varidx).innerHTML = originalRequest.responseText;
}
function setStartDateType(type){
	strSelectedToDate = "";
	strSelectedFromDate = "";
	arrSelectedDate = new Array();
	if (type == "D"){
		document.getElementById("daychkbox").src = IMG_ENURI_COM+"/images/view/travel/2012/daychkbox_on.gif";	
		document.getElementById("termchkbox").src = IMG_ENURI_COM+"/images/view/travel/2012/termchkbox.gif";
		document.getElementById("select_day_text_img").src = IMG_ENURI_COM+"/images/view/travel_new/text_02.gif";
	}else{
		document.getElementById("daychkbox").src = IMG_ENURI_COM+"/images/view/travel/2012/daychkbox.gif";
		document.getElementById("termchkbox").src = IMG_ENURI_COM+"/images/view/travel/2012/termchkbox_on.gif";
		document.getElementById("select_day_text_img").src = IMG_ENURI_COM+"/images/view/travel_new/text_01.gif";		
	}

	varStartDateType = type;
	var searchParameter = makeSearchParameter();
	if (searchParameter.length > 0){
		showGoButton(200);
	}
	if(isSearch){
		cmdGetCountChange(searchParameter);
	}else{
		cmdMainGetCountResult(searchParameter);	
	}
				
	document.getElementById("if_prev_month").contentWindow.location.href = "/tour2012/SelectStartDate.jsp?selYear="+nowYear+"&selMonth="+nowMonth+"&sstart=&selType="+type+"&sstartmaxafter="+strSelectMaxDayAfter;
	if (nowMonth==12){
		document.getElementById("if_next_month").contentWindow.location.href = "/tour2012/SelectStartDate.jsp?selYear="+(nowYear+1)+"&selMonth=1&sstart=&selType="+type+"&sstartmaxafter="+strSelectMaxDayAfter;
	}else{
		document.getElementById("if_next_month").contentWindow.location.href = "/tour2012/SelectStartDate.jsp?selYear="+nowYear+"&selMonth="+(nowMonth+1)+"&sstart=&selType="+type+"&sstartmaxafter="+strSelectMaxDayAfter;
	}
}
function inputFlash(vId, vUri, vWidth, vHeight, vWmode, vFlashVar) {
	var str = "";
	str = '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" id="' + vId + '" VIEWASTEXT width="' + vWidth + '" height="' + vHeight + '" align="middle">';
	str += '<param name="allowScriptAccess" value="always" />';
	str += '<param name="allowFullScreen" value="false" />';
	str += '<param name="quality" value="best" />';
	str += '<param name="wmode" value="' + vWmode + '" />';
	str += '<param name="bgcolor" value="#ffffff" />';
	str += '<param name="movie" value="' + vUri + '" />';
	str += '<param name="FlashVars" value="' + vFlashVar + '" />';
	str += '<embed src="' + vUri + '" quality="high" wmode="' + vWmode + '" bgcolor="#ffffff" width="' + vWidth +'" height="' + vHeight + '" id="' + vId + '" name="' + vId + '" align="middle" swLiveConnect=true allowScriptAccess="always" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash" /></embed>';
	str += '</object>';
	document.writeln(str);
}
function inputImg(vId, vUri, vWidth, vHeight, vWmode, vFlashVar) {
	var str = "";
	str = '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" id="' + vId + '" VIEWASTEXT width="' + vWidth + '" height="' + vHeight + '" align="middle">';
	str += '<param name="allowScriptAccess" value="always" />';
	str += '<param name="allowFullScreen" value="false" />';
	str += '<param name="quality" value="best" />';
	str += '<param name="wmode" value="' + vWmode + '" />';
	str += '<param name="bgcolor" value="#ffffff" />';
	str += '<param name="movie" value="' + vUri + '" />';
	str += '<param name="FlashVars" value="' + vFlashVar + '" />';
	str += '<img src="' + vUri + '" bgcolor="#ffffff" width="' + vWidth +'" height="' + vHeight + '" id="' + vId + '" name="' + vId + '" align="middle"  />';
	str += '</object>';
	document.writeln(str);
}
function nextMonth(){
	if ((nowYear==maxYear && nowMonth>=maxMonth) || (nowYear>maxYear)){
		return false;
	}
	if (nowMonth != 12 ){
		nowMonth++;
	}else{
		nowYear++;
		nowMonth = 1;
	}
	var dateParam = getDateParam();
	document.getElementById("span_prev_month").innerHTML = nowMonth+"월";
	
	document.getElementById("if_prev_month").src = "/tour2012/SelectStartDate.jsp?selYear="+nowYear+"&selMonth="+nowMonth+"&selType="+varStartDateType+dateParam;
	if (nowMonth != 12 ){
		document.getElementById("if_next_month").src = "/tour2012/SelectStartDate.jsp?selYear="+nowYear+"&selMonth="+(nowMonth+1)+"&selType="+varStartDateType+"&sstartmaxafter="+strSelectMaxDayAfter+dateParam;
		document.getElementById("span_next_year").innerHTML = "";
		document.getElementById("span_next_month").innerHTML = (nowMonth+1)+"월";
	}else{
		document.getElementById("if_next_month").src = "/tour2012/SelectStartDate.jsp?selYear="+(nowYear+1)+"&selMonth=1&selType="+varStartDateType+"&sstartmaxafter="+strSelectMaxDayAfter+dateParam;
		document.getElementById("span_next_year").innerHTML = (nowYear+1);
		document.getElementById("span_next_month").innerHTML = "1월";
	}
	monthMoveCnt++;
	document.getElementById("img_prev").src = IMG_ENURI_COM + "/images/view/travel_new/btn_back.gif";
	document.getElementById("img_prev").style.cursor = "pointer";			
	if ((nowYear==maxYear && nowMonth>=maxMonth) || (nowYear>maxYear)){
		document.getElementById("span_next_year").innerHTML = "";
		document.getElementById("span_next_month").innerHTML = nowMonth+"월";
		document.getElementById("img_next").src = IMG_ENURI_COM + "/images/view/travel_new/btn_more_after.gif"
		document.getElementById("img_next").style.cursor = "default";
	}
	document.getElementById("span_prev_year").innerHTML = nowYear;
}
function getDateParam(){
	var strParam = "";
	if (varStartDateType == "D"){
		strParam = strParam +"&sdatetype=D";
		if (strSelectMaxDayAfter==""){
			var selectedStartDates = "";
			for (var i=0;i<arrSelectedDate.length;i++){
				selectedStartDates = selectedStartDates + arrSelectedDate[i]+",";
			}
        	if (selectedStartDates.length > 0 ){
        		strParam = strParam +"&sstart="+selectedStartDates.substring(0,selectedStartDates.length-1);
        	}
        }else{
        	strParam = strParam +"&sstartmaxafter="+strSelectMaxDayAfter;
        }
   	}else{
   		strParam = strParam +"&sdatetype=T";
   		if (strSelectMaxDayAfter==""){
	       	if (strSelectedToDate != ""){
		   		strParam = strParam +"&sstart="+strSelectedFromDate + "," + strSelectedToDate;
		   	}else if (strSelectedFromDate != ""){
		   		strParam = strParam +"&sstart="+strSelectedFromDate;
		   	}
		}else{
			strParam = strParam +"&sstartmaxafter="+strSelectMaxDayAfter;
		}
	}
	return strParam;
}
function prevMonth(){
	if (monthMoveCnt == 0 ){
		return false;
	}
	if (nowMonth != 1 ){
		nowMonth--;
	}else{
		nowYear--;
		nowMonth = 12;
	}
   	var dateParam = getDateParam();
	document.getElementById("span_prev_month").innerHTML = nowMonth+"월";
	document.getElementById("if_prev_month").src = "/tour2012/SelectStartDate.jsp?selYear="+nowYear+"&selMonth="+nowMonth+"&selType="+varStartDateType+dateParam;
	if (nowMonth != 12 ){
		document.getElementById("if_next_month").src = "/tour2012/SelectStartDate.jsp?selYear="+nowYear+"&selMonth="+(nowMonth+1)+"&selType="+varStartDateType+dateParam;
		document.getElementById("span_next_year").innerHTML = "";
		document.getElementById("span_next_month").innerHTML = (nowMonth+1)+"월";
	}else{
		document.getElementById("if_next_month").src = "/tour2012/SelectStartDate.jsp?selYear="+(nowYear+1)+"&selMonth=1&selType="+varStartDateType+dateParam;
		document.getElementById("span_next_year").innerHTML = (nowYear+1);
		document.getElementById("span_next_month").innerHTML = "1월";
	}
	monthMoveCnt--;
	document.getElementById("img_next").src = IMG_ENURI_COM + "/images/view/travel_new/btn_more.gif";
	document.getElementById("img_next").style.cursor = "pointer";
	if (monthMoveCnt == 0 ){
		document.getElementById("img_prev").src = IMG_ENURI_COM + "/images/view/travel_new/btn_back_1.gif";
		document.getElementById("img_prev").style.cursor = "default";
	}
	document.getElementById("span_prev_year").innerHTML = nowYear;
}	
function tourBackImgOver(obj){
	if(obj.className=="selected_day"){
		obj.className = "selected_day_over";
	}
}
function tourBackImgOut(obj){
	if(obj.className=="selected_day_over"){
		obj.className = "selected_day";
	}
}
function selectStartDate(varYear, varMon, varDay){
	var selectedYear = varYear+"";
	var selectedMonth = "";
	var selectedDay = "";
	if (varMon < 10 ){
		selectedMonth = "0"+varMon;
	}else{
		selectedMonth = varMon;
	}
	if (varDay< 10 ){
		selectedDay = "0"+varDay;
	}else{
		selectedDay = varDay;
	}
	setStartDate(selectedYear+""+selectedMonth+""+selectedDay,false);
}
function makeSearchParameter(){
	var selectedSubject = document.getElementById("txt_subject").value;
	if (varStartDateType == "D"){
		if (strSelectMaxDayAfter=="" && arrSelectedDate.length == 0 ){
		}
	}else{
		if (strSelectMaxDayAfter=="" && strSelectedFromDate == "" && strSelectedToDate == "" ){
		}else if (strSelectMaxDayAfter=="" && strSelectedFromDate == ""){
			strSelectedFromDate = strSelectedToDate;
			strSelectedToDate = "";
		}
	}

	var strSearchParameters = "";
	strSearchParameters = "sptype=detail";
	var strKindCode = "";
	if(selectedTravelType==1){ //일반패키지
		strKindCode = "1";
	}else if(selectedTravelType==2){ //자유/배낭여행
		strKindCode = "4";
	}else if(selectedTravelType==3){ //허니문
		strKindCode = "2";
	}else if(selectedTravelType==4){ //크루즈/럭셔리
		strKindCode = "5";
	}else if(selectedTravelType==5){ //골프
		strKindCode = "7";
	}else{
		strKindCode = "4";
	}
	strSearchParameters = strSearchParameters + "&skind=" + strKindCode;
	
	if (selectedCon=="A7" && selectedSubject!=""){ //주제어검색

		strSearchParameters = strSearchParameters +"&subject="+selectedSubject.replace("&","");
	}else{
		var selectedAllCountryCodes = "";
		var selectedCountryCodes = "";
		for (var i=0;i<arrSelectedArea.length;i++){
			selectedAllCountryCodes = selectedAllCountryCodes + arrSelectedArea[i]+",";
			if (arrSelectedArea[i].substring(0,2) == selectedCon){
				selectedCountryCodes = selectedCountryCodes + arrSelectedArea[i]+",";
			}
		}
		selectedAllCountryCodes = selectedAllCountryCodes.substring(0,selectedAllCountryCodes.length-1);
		selectedCountryCodes = selectedCountryCodes.substring(0,selectedCountryCodes.length-1);
		if (selectedCountryCodes.length == 0 ){
		}else{
			strSearchParameters = strSearchParameters +"&varea="+selectedAllCountryCodes;
			strSearchParameters = strSearchParameters +"&sarea="+selectedCountryCodes;
		}
	}
   //    지방 출발은 따른데서 체크함
   	if (varStartDateType == "D"){
		strSearchParameters = strSearchParameters +"&sdatetype=D";
		if (strSelectMaxDayAfter==""){
			var selectedStartDates = "";
			for (var i=0;i<arrSelectedDate.length;i++){
				selectedStartDates = selectedStartDates + arrSelectedDate[i]+",";
			}
        	if (selectedStartDates.length > 0 ){
        		strSearchParameters = strSearchParameters +"&sstart="+selectedStartDates.substring(0,selectedStartDates.length-1);
        	}
        }else{
        	strSearchParameters = strSearchParameters +"&sstartmaxafter="+strSelectMaxDayAfter;
        }
   	}else{
   		strSearchParameters = strSearchParameters +"&sdatetype=T";
   		if (strSelectMaxDayAfter==""){
	       	if (strSelectedToDate != ""){
		   		strSearchParameters = strSearchParameters +"&sstart="+strSelectedFromDate + "," + strSelectedToDate;
		   	}else if (strSelectedFromDate != ""){
		   		strSearchParameters = strSearchParameters +"&sstart="+strSelectedFromDate;
		   	}
		}else{
			strSearchParameters = strSearchParameters +"&sstartmaxafter="+strSelectMaxDayAfter;
		}
	}
   	return strSearchParameters;
}

function deletedetailSearchParameter(){
	var obj = document.frmTravel;
	obj.spday.value = "";
	obj.sappoint.value = "";
	obj.stimetype.value = "";
	obj.stime.value = "";
	obj.spricef.value = "";
	obj.spricet.value = "";
	obj.spricef.value = "";
	obj.spricet.value = "";
	obj.sfactory.value = "";
	obj.sairline.value = "";
	obj.slocalcity.value = ""; 
}

function detailSearchParameter(){
	var obj = document.frmTravel;
	var strSearchDetailParameters = "&sstep=3";
	var tempChk = "";
	viewBtn = "N";
	//여행 기간
	strSearchDetailParameters += "&spday="+obj.spday.value;
	tempChk += obj.spday.value;
	//예약 상태
	strSearchDetailParameters += "&sappoint="+obj.sappoint.value;
	tempChk += obj.sappoint.value;
	//항공시간 선택
	//항공시간 직접입력
	strSearchDetailParameters += "&stimetype="+obj.stimetype.value+"&stime="+obj.stime.value;
	tempChk += obj.stime.value;
	//가격대
	if($("travel_detail3_min")){
		var minprice = $("travel_detail3_min").value;
		var maxprice = $("travel_detail3_max").value;
		
		try{
			minprice = parseInt(minprice,10);
		}catch(e){
			minprice = 0;
			$("travel_detail3_min").value = 0;
		}
		try{
			maxprice = parseInt(maxprice,10);
		}catch(e){
			maxprice = 0;
			$("travel_detail3_max").value = 0;
		}
		if (minprice>0 || maxprice>0){
		
			if (minprice==0) minprice = intTravelMinPrice;
			if (maxprice==0) maxprice = intTravelMaxPrice;
	
			if (minprice>maxprice) {
				alert("가격 검색 범위가 올바르지 않습니다.");
				return;
			}
			obj.spricef.value = (minprice*10000);
			obj.spricet.value = (maxprice*10000);
		}else{
			//alert("가격검색 범위를 입력하셔야 합니다.");
			obj.spricef.value = "";
			obj.spricet.value = "";
		}
	}
	strSearchDetailParameters += "&spricef=" + obj.spricef.value;
	tempChk += obj.spricef.value;
	strSearchDetailParameters += "&spricet=" + obj.spricet.value;
	tempChk += obj.spricet.value;
	//여행사 선택
	strSearchDetailParameters += "&sfactory=" + obj.sfactory.value;
	tempChk += obj.sfactory.value;
	//항공사 선택
	strSearchDetailParameters += "&sairline=" + obj.sairline.value;
	tempChk += obj.sairline.value;
	//지방 출발
	strSearchDetailParameters += "&slocalcity=" + obj.slocalcity.value; 
	tempChk += obj.slocalcity.value;
	if(tempChk == "" || tempChk.length == 0){
		strSearchDetailParameters = "";
	}
	return strSearchDetailParameters;
}
/*function searchMainButtonView(varFlag){
	if(varFlag=='T'){
		document.getElementById("div_go_search").style.display = "block";
		document.getElementById("div_go_search_default").style.display = "none";
	}else{
		document.getElementById("div_go_search").style.display = "none";
		document.getElementById("div_go_search_default").style.display = "block";
	}
}
function searchButtonView(varFlag){
	if(varFlag=='T'){
		document.getElementById("div_go_search").style.display = "block";
		if(!isSearch){
			$("main_resultmap_getcntline").style.display = "none";
		}
		document.getElementById("div_go_search_default").style.display = "none";
	}else{
		document.getElementById("div_go_search").style.display = "none";
		//document.getElementById("div_go_search_default").style.display = "block";
		if(!isSearch){
			$("main_resultmap_getcntline").style.display = "none";
		}
	}

}*/
// 날짜 초기화
function setDateReset(){
	setStartDateType(varStartDateType);
}
//기본조건 선택마다 현재위치 표시값 가져오기
function cmdGetCountChange(param){
	//loadingbaron();
	var new_param = param;
	if (new_param.indexOf("subject=")>=0){ //주제어 체크
		sidx = new_param.indexOf("subject=")+8;
		eidx = new_param.indexOf("&",sidx);
		var subject = new_param.substring(sidx,eidx);
		if (subject!=""){
			subject = cmdRemoveSpchar(subject); //특수문자제외
			if (!subject){
				return;
			}
			$("txt_subject").value = subject;
			if (subject!=""){
				new_param = new_param.substring(0,sidx) + subject + new_param.substring(eidx);
			}
		}
	}
	
	var url = "/tour2012/GetCount.jsp";
	var rtype = "rtype=condition&" + new_param + "&ltab=" + selectedCon + "&selectDetailView=" + selectDetailView;
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:rtype,onComplete:inputCountChange
		}
	);
	
	// 검색 결과 개수 바꿔 주는 부분
	// X종 (X개)의 여행 상품이 검색 되었습니다 개수 바꿔주는 부분
	var tempDetailparam = param + detailSearchParameter();
	cmdGetCountResult(tempDetailparam);
	var new_param = getBeforeParamCheck(param);
	
	if (new_param==""){
		// X종 (X개)의 여행 상품이 검색 되었습니다 레이어
		$("resultmap_getcntline").style.display = "none";
	}
}
function detailbunov(obj){
	$(obj).src = $(obj).src.replace(".gif","_ov.gif");
}
function detailbunou(obj){
	$(obj).src = $(obj).src.replace("_ov.gif",".gif");
}
function displayLayer(varLayer){
	$(varLayer).style.display = "none";
}
function chkGoViewBtn(){
	var searchParameter = makeSearchParameter();
	if (searchParameter.length > 0){
		showGoButton(200);
	}
}
function cmdTravelDetail0(obj, dayCnt){
	dayCnt = dayCnt.replace("일","");
	dayCnt = dayCnt.replace("~","");
	var object = document.frmTravel;
	var spday = object.spday.value;
	var exists = 0;
	var new_spday = "";
	var i = 0;
	var arrSpday = spday.split(",");
	if( obj=="SpdayCnt0" && $(obj).src.indexOf("_chk_ov.gif")<0){
		for(i=1;i<10;i++){
			if($("SpdayCnt"+i)){
				$("SpdayCnt"+i).src = IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_65.gif";
			}
		}
		new_spday = "";
	}
	if( obj!="SpdayCnt0"){
		$("SpdayCnt0").src = IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_65.gif";
		if($(obj).src.indexOf("_chk_ov.gif")<0){// 선택 안되있는거 클릭 
			for(i=0; i<arrSpday.length; i++){
				if (dayCnt == arrSpday[i]){
					exists = 1;
				}else{
					if (new_spday==""){
						new_spday = arrSpday[i];
					}else{
						new_spday += "," + arrSpday[i];
					}
				}
			}
			if (exists != 1){ //이미 선택되어 있는 날짜면 선택해제
				if (new_spday==""){
					new_spday = dayCnt;
				}else{
					new_spday += "," + dayCnt;
				}
			}
		}else{ // 선택 되있는거 크
			for(i=0; i<arrSpday.length; i++){
				if(dayCnt != arrSpday[i]){
					if (new_spday==""){
						new_spday = arrSpday[i];
					}else{
						new_spday += "," + arrSpday[i];
					}
				}
			}
		}
	}
	if($(obj).src.indexOf("_chk_ov.gif")>0){
		$(obj).src = $(obj).src.replace("_chk_ov.gif","_ov.gif");
	}else{
		$(obj).src = $(obj).src.replace("_ov.gif","_chk_ov.gif");
	}
	object.spday.value = new_spday;
	//chkGoViewBtn();
	var param = makeSearchParameter() + detailSearchParameter();
	cmdGetCountResult(param);
	showGoBtn0();
}
function showGoBtn0(){
	var object = document.frmTravel;
	var spday = object.spday.value;	
	var varIsShow = false;
	if($("SpdayCnt0")){
		if ($("SpdayCnt0").src.indexOf("/images/view/travel/2012/btn/tourbtn_65_chk") >= 0){
			varIsShow = true;
		}
	}	
	var varIsShow1 = true;
	var arrSpday = spday.split(",");
	for(i=1;i<10;i++){
		if($("SpdayCnt"+i)){
			if (varIsShow1 && $("SpdayCnt"+i).src.indexOf("/images/view/travel/2012/btn/tourbtn_65_chk") >= 0 ){
				varIsShow1 = true;
			}else{
				varIsShow1 = false;
			}
		}
	}
	if (varIsShow || varIsShow1){
		$("div_go_search1").hide();
	}else{
		$("div_go_search1").show();
	}
}
function sortNumber(a,b){
	return a - b;
}
function cmdTravelDetail1(obj, stateNum){
	var object = document.frmTravel;
	var sappoint = object.sappoint.value;
	var exists = 0;
	var new_sappoint = "";
	var arrSappoint = sappoint.split(",");
	var i=0;
	if( obj=="ExistState0" && $(obj).src.indexOf("_chk_ov.gif")<0){
		$("ExistState1").src = IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_83.gif";
		$("ExistState2").src = IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_110.gif";
		$("ExistState3").src = IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_65.gif";
		new_sappoint = "";
	}

	if( obj!="ExistState0"){
		$("ExistState0").src = IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_65.gif";
		if($(obj).src.indexOf("_chk_ov.gif")<0){
			for (i=0; i<arrSappoint.length; i++){
				if (stateNum == arrSappoint[i]){
					exists = 1;
				}else{
					if (new_sappoint==""){
						new_sappoint = arrSappoint[i];
					}else{
						new_sappoint += "," + arrSappoint[i];
					}
				}
			}
			if (exists != 1){ //이미 선택되어 있는 날짜면 선택해제
				if (new_sappoint==""){
					new_sappoint = stateNum;
				}else{
					new_sappoint += "," + stateNum;
				}
			}
		}else{
			for(i=0; i<arrSappoint.length; i++){
				if(stateNum != arrSappoint[i]){
					if (new_sappoint==""){
						new_sappoint = arrSappoint[i];
					}else{
						new_sappoint += "," + arrSappoint[i];
					}
				}
			}
		}
	}
	if($(obj).src.indexOf("_chk_ov.gif")>0){
		$(obj).src = $(obj).src.replace("_chk_ov.gif","_ov.gif");
	}else{
		$(obj).src = $(obj).src.replace("_ov.gif","_chk_ov.gif");
	}
	
	object.sappoint.value = new_sappoint;
	//chkGoViewBtn();
	var param = makeSearchParameter() + detailSearchParameter();
	cmdGetCountResult(param);
}
function cmdTravelDetail2(obj, num){
	var object = document.frmTravel;
	var stime = object.stime.value;
	var new_stime = "";
	var exists = 0;
	var new_existtimes = "";
	var tempStr = "";
	var arrExists = stime.split(",");
	var i = 0;
	var existtimes = object.existtimes.value;
	if(num==1){
		tempStr = "S0004";
	}else if(num==2){
		tempStr = "S0408";
	}else if(num==3){
		tempStr = "S0812";
	}else if(num==4){
		tempStr = "S1216";
	}else if(num==5){
		tempStr = "S1620";
	}else if(num==6){
		tempStr = "S2024";
	}else if(num==7){
		tempStr = "E0004";
	}else if(num==8){
		tempStr = "E0408";
	}else if(num==9){
		tempStr = "E0812";
	}else if(num==10){
		tempStr = "E1216";
	}else if(num==11){
		tempStr = "E1620";
	}else if(num==12){
		tempStr = "E2024";
	}
	if( obj=="ExistTimes0" && ($(obj).src.indexOf("_chk_ov.gif")<0 || $(obj).src.indexOf("_chk.gif")<0)){
		for(i=1;i<13;i++){
			if($("ExistTimes"+i)){
				$("ExistTimes"+i).src = IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_6020.gif";
			}
		}
		new_stime = "";
	}
	if( obj!="ExistTimes0"){
		if( $(obj).src.indexOf("_chk_ov.gif")<0){
			$("ExistTimes0").src = IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_65.gif";
			for (i=0; i<arrExists.length; i++){
				if (tempStr == arrExists[i]){
					exists = 1;
				}else{
					if (new_stime==""){
						new_stime = arrExists[i];
					}else{
						new_stime += "," + arrExists[i];
					}
				}
			}
			if (exists != 1){ //이미 선택되어 있는 날짜면 선택해제
				if (new_stime==""){
					new_stime = tempStr;
				}else{
					new_stime += "," + tempStr;
				}
			}
		}else{
			for(i=0; i<arrExists.length; i++){
				if(tempStr != arrExists[i]){
					if (new_stime==""){
						new_stime = arrExists[i];
					}else{
						new_stime += "," + arrExists[i];
					}
				}
			}
		}
	}
	object.stime.value = new_stime;
	object.stimetype.value = "B";
	if( obj=="ExistTimes0" && ($(obj).src.indexOf("_chk_ov.gif")<0 || $(obj).src.indexOf("_chk.gif")<0)){
		$("travel_detail2_info").innerHTML = "";
	}else{
	}
	
	if($(obj).src.indexOf("_chk_ov.gif")>0){
		$(obj).src = $(obj).src.replace("_chk_ov.gif","_ov.gif");
	}else{
		$(obj).src = $(obj).src.replace("_ov.gif","_chk_ov.gif");
	}
	
	//chkGoViewBtn();
	var param = makeSearchParameter() + detailSearchParameter();
	cmdGetCountResult(param);
}
/* 항공시간 선택2 : 직접입력 */
function cmdTravelDetail2Select(){
	$("ExistTimes0").src = IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_65.gif";
	for(var i=1;i<13;i++){
		if($("ExistTimes"+i)){
			$("ExistTimes"+i).src = IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_6020.gif";
		}
	}
	var startend = "";
	var hms = $("travel_detail2_1").value;
	var hme = $("travel_detail2_2").value;
	
	if ($("travel_detail2_3start").checked) startend = "start";
	if ($("travel_detail2_3end").checked) startend = "end";
	
	var hm = hms + "" + hme;
	var obj = document.frmTravel;
	if (startend=="start"){
		hm = "S" + hm;
	}else{
		hm = "E" + hm;
	}
	obj.stime.value = hm;
	obj.stimetype.value = "T";
	var param = makeSearchParameter() + detailSearchParameter();
	cmdGetCountResult(param);
}
/* 항공시간 선택내용 하단에 표시 */
function cmdTravelDetail2Info(){
	var obj = document.frmTravel;
	var stime = obj.stime.value;
	var stimetype = obj.stimetype.value;
	var arrStime = stime.split(",");
	var stimeInfo = "";
	var stimeStartInfo = "";
	var stimeEndInfo = "";
	var stimeStartCnt = 0;
	var stimeEndCnt = 0;

	if (stime!=""){
		stimeInfo = "<font style='font-size:9pt'>☞</font> ";
		if (stimetype=="B"){ //이미지버튼으로 선택
			for (i=0; i<arrStime.length; i++){
				if (arrStime[i].substring(0,1)=="S"){
					if (stimeStartInfo!="") stimeStartInfo += " 또는 ";
					stimeStartInfo += "<u>" + arrStime[i].substring(1,3) + "~" + arrStime[i].substring(3,5) + "시</u>";
					stimeStartCnt++;
				}else if (arrStime[i].substring(0,1)=="E"){
					if (stimeEndInfo!="") stimeEndInfo += " 또는 ";
					stimeEndInfo += "<u>" + arrStime[i].substring(1,3) + "~" + arrStime[i].substring(3,5) + "시</u>";
					stimeEndCnt++;
				}
			}
			if (stimeStartCnt==6){
				stimeStartInfo = "<u>00~24시</u>";
			}
			if (stimeEndCnt==6){
				stimeEndInfo = "<u>00~24시</u>";
			}
			if (stime.indexOf("S")>=0){
				stimeStartInfo += "에 <font color='blue'>출발</font>";
			}
			stimeInfo += stimeStartInfo;
			if (stime.indexOf("E")>=0){
				if (stimeStartInfo!=""){
					stimeInfo += "하고,<br>&nbsp;&nbsp;&nbsp;&nbsp;";
				}
				stimeEndInfo += "에 <font color='blue'>도착</font>";
			}
			stimeInfo += stimeEndInfo + "하는 상품을 선택했습니다.";
		}else if (stimetype=="T"){ //직접입력으로 선택
			stimeInfo += stime.substring(1,3) + "~" + stime.substring(3,5) + "시에 ";
			if (stime.substring(0,1)=="S"){
				stimeInfo += "<font color='blue'>출발</font>";
			}else{
				stimeInfo += "<font color='blue'>도착</font>";
			}
			stimeInfo += "하는 상품을 선택했습니다.";
		}
	}else{
		stimeInfo = "<font style='font-size:9pt'>☞</font> 모든 시간대 상품을 선택했습니다.";
	}
	$("travel_detail2_info").innerHTML = stimeInfo;
}
function cmdTravelDetail6(obj, slocalCityName){
	var object = document.frmTravel;
	var slocalcity = object.slocalcity.value;
	var exists = 0;
	var new_slocalcity = "";
	var slocalCityCnt = "0";
	
	if(slocalCityName == "부산"){
		slocalCityCnt = "1";
	}else if(slocalCityName == "광주"){
		slocalCityCnt = "2";
	}else if(slocalCityName == "대구"){
		slocalCityCnt = "3";
	}else if(slocalCityName == "청주"){
		slocalCityCnt = "4";
	}else if(slocalCityName == "제주"){
		slocalCityCnt = "5";
	}
	var arrSlocalcity = slocalcity.split(",");
	if( obj=="Location0" && $(obj).src.indexOf("_chk_ov.gif")<0){
		for(var i=1;i<10;i++){
			if($("Location"+i)){
				$("Location"+i).src = IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_65.gif";
			}
		}
		new_slocalcity = "";
	}
	if( obj!="Location0"){
		$("Location0").src = IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_65.gif";
		if($(obj).src.indexOf("_chk_ov.gif")<0){
			for (var i=0; i<arrSlocalcity.length; i++){
				if (slocalCityCnt == arrSlocalcity[i]){
					exists = 1;
				}else{
					if (new_slocalcity==""){
						new_slocalcity = arrSlocalcity[i];
					}else{
						new_slocalcity += "," + arrSlocalcity[i];
					}
				}
			}
			if (exists != 1){
				if (new_slocalcity==""){
					new_slocalcity = slocalCityCnt;
				}else{
					new_slocalcity += "," + slocalCityCnt;
				}
			}
		}else{
			for(var i=0; i<arrSlocalcity.length; i++){
				if(slocalCityCnt != arrSlocalcity[i]){
					if (new_slocalcity==""){
						new_slocalcity = arrSlocalcity[i];
					}else{
						new_slocalcity += "," + arrSlocalcity[i];
					}
				}
			}
		}
	}
	if($(obj).src.indexOf("_chk_ov.gif")>0){
		$(obj).src = $(obj).src.replace("_chk_ov.gif","_ov.gif");
	}else{
		$(obj).src = $(obj).src.replace("_ov.gif","_chk_ov.gif");
	}
	object.slocalcity.value = new_slocalcity;
	//chkGoViewBtn();
	var param = makeSearchParameter() + detailSearchParameter();
	cmdGetCountResult(param);
}
function viewDirectTime(){
	$("travel_detail2_info").innerHTML = "";
	removeTimeBgImg();
	$("directViewImg").style.display="none";
	$("inputexisttime").style.display="block";
}
function hideDirectTime(){
	$("travel_detail2_3start").checked = true;
	$("travel_detail2_1").options[0].selected = "selected";
	$("travel_detail2_2").options[0].selected = "selected";
	var object = document.frmTravel;
	object.stime.value = "";
	object.stimetype.value = "";
	$("directViewImg").style.display="block";
	$("inputexisttime").style.display="none";
	$("travel_detail2_info").innerHTML = "";
}
function inputCountChange(originalRequest){
	
	eval("arrReturn = " + originalRequest.responseText);
	var obj = document.frmTravel;
	if (eval("arrReturn")){
		var i=0;
		var mapsubject = eval("arrReturn.mapsubject");
		var maparea = eval("arrReturn.maparea");
		var mapsdatetype = eval("arrReturn.mapsdatetype");
		var mapstart = eval("arrReturn.mapstart");
		var mapstartmaxafter = eval("arrReturn.mapstartmaxafter");
		var mapkind = eval("arrReturn.mapkind");
		var mapperiod = eval("arrReturn.mapperiod");
		var ltab = eval("arrReturn.ltab");
		var selectDetailView = eval("arrReturn.selectDetailView");
		
		for(i=1;i<8;i++){
			document.getElementById("div_detail_layer_"+i).style.display = "none";
		}
		for(i=1;i<8;i++){
			$("img_travel_detail_tab"+i).src = IMG_ENURI_COM+"/images/view/travel/2012/tour_btab_0"+i+".gif";
		}
		$("img_travel_detail_tab7").src = IMG_ENURI_COM+"/images/view/travel/2012/tour_btab_07_on.gif";
		document.getElementById("div_detail_layer_7").style.display = "block";
		// 초기화
		$("div_detail_layer_1").innerHTML = "";
		$("div_detail_layer_2").innerHTML = "";
		$("div_detail_layer_3").innerHTML = "";
		$("div_detail_layer_4").innerHTML = "";
		$("div_detail_layer_5").innerHTML = "";
		$("div_detail_layer_6").innerHTML = "";
		$("div_detail_layer_7").innerHTML = "";
		//여행 선택 텍스트
		var strSpdayText = "";
		var tempSelectedSpday = (obj.spday.value).split(",");
		if(tempSelectedSpday != ""){
			for(var s=0;s<tempSelectedSpday.length;s++){
				if(tempSelectedSpday[s]==3){
			  		strSpdayText = strSpdayText + "~3";
			  		if(s==tempSelectedSpday.length-1){
			  			strSpdayText += "일";
			  		}
			  	}else if(tempSelectedSpday[s]==10){
			  		if(strSpdayText != ""){
			  			strSpdayText += ", ";
			  		}
			  		strSpdayText = strSpdayText + "10일~";
			  	}else{
			  		if(strSpdayText != ""){
			  			strSpdayText += ", ";
			  		}
			  		strSpdayText += tempSelectedSpday[s]
			  	}
			  	if(s==tempSelectedSpday.length-1 && tempSelectedSpday[s]!=10){
			  		strSpdayText += "일";
			  	}
			}
		}
		// 여행기간
		var strSpday = eval("arrReturn.strSpday").split(",");
		// 여행 기간 개수
		var strSpdayCnt = eval("arrReturn.strSpdayCnt").split(",");
		var totalSpdayCnt = 0; 
		for(i=0;i<strSpdayCnt.length;i++){
			totalSpdayCnt += parseInt(strSpdayCnt[i]);
		}
		if(strSpday == ""){
			$("div_detail_layer_1").innerHTML = "<div style=\"float:left;width:830px;height:15px;text-align:center;margin-top:55px;\">해당 여행기간이 없습니다.</div>";
		}else{
			var selectedSpday = (obj.spday.value).split(",");
			var spdayBtnImgUrl = IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_65.gif";
			if(selectedSpday == "" || spdayBtnImgUrl.length == 0){			
	   			spdayBtnImgUrl = IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_65_chk.gif";
	   		}
			var tempInnerHtml = "";
			 tempInnerHtml = "<div id=\"div_detail_layer_1_div1\">"
								  + "	<ul>"
								  + "		<li><span>여행기간 →</span></li>"
								  + "	</ul>"
								  + "	<ul>"
								  + "		<li>"
								  + "			<div class=\"detail_layer_1_img_div\">"
								  + "				<img class=\"detail_layer_1_img\" id=\"SpdayCnt0\" src=\""+spdayBtnImgUrl+"\" complete=\"complete\"/>"
								  + "				<div class=\"detail_layer_1_stitleblod\">전체</div>"
								  + "				<div class=\"detail_layer_1_scnt\"><font class=\"detail_layer_cnt\">"+totalSpdayCnt+"</font><font class=\"detail_layer_ea\">개</font></div>"
								  + "				<div class=\"btn65\" onmouseover=\"detailbunov('SpdayCnt0');\" onmouseout=\"detailbunou('SpdayCnt0')\" onclick=\"cmdTravelDetail0('SpdayCnt0','0')\" >"
								  + "				<img src=\""+IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_none_65.gif\" complete=\"complete\"/>"
								  + "				</div>"
								  + "			</div>";
								  + "		</li>"
								  for(var i=0;i<strSpday.length;i++){
								  	spdayBtnImgUrl = IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_65.gif";
								   	for(var j=0;j<selectedSpday.length;j++){
								   		if(selectedSpday[j]==strSpday[i]){
								   			spdayBtnImgUrl = IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_65_chk.gif";
								   		}
								   	}
								  	if(strSpday[i]==3){
								  		strSpday[i] = "~3일";
								  	}else if(strSpday[i]==10){
								  		strSpday[i] = "10일~";
								  	}else{
								  		strSpday[i] = strSpday[i]+"일";
								  	}
										 tempInnerHtml = tempInnerHtml
								   + "		<li>"
								   + "			<div class=\"detail_layer_1_img_div\">"
								   + "				<img class=\"detail_layer_1_img\" id=\"SpdayCnt"+(i+1)+"\" src=\""+spdayBtnImgUrl+"\" complete=\"complete\"/>"
								   + "				<div class=\"detail_layer_1_stitle\">"+strSpday[i]+"</div>"
								   + "				<div class=\"detail_layer_1_scnt\"><font class=\"detail_layer_cnt\">"+strSpdayCnt[i]+"</font><font class=\"detail_layer_ea\">개</font></div>"
								   + "				<div class=\"btn65\" onmouseover=\"detailbunov('SpdayCnt"+(i+1)+"');\" onmouseout=\"detailbunou('SpdayCnt"+(i+1)+"')\" onclick=\"cmdTravelDetail0('SpdayCnt"+(i+1)+"','"+strSpday[i]+"')\" >"
								   + "				<img src=\""+IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_none_65.gif\" complete=\"complete\"/>"
								   + "				</div>"
							       + "			</div>";
								   + "		</li>"
								  }								  	  
								  if(totalSpdayCnt !== strSpday[i]){
									  tempInnerHtml = tempInnerHtml
								  + "	<li>" 
								  + "		<div id=\"div_go_search1\" style=\"display:none\" onclick=\"goSearch(1);\">"
								  + "		<img src=\""+IMG_ENURI_COM+"/images/view/travel_new/go_btn_1211141.gif\" >"
								  + "		</div>"
								  + "	</li>"
								  }
			tempInnerHtml = tempInnerHtml + "</ul></div>";
			$("div_detail_layer_1").innerHTML = tempInnerHtml;
		}
		// 여행 예약상태
		var strExistStateCnt = eval("arrReturn.strExistStateCnt").split(",");
		var strExistStateText = "";
		var selectedExistState = (obj.sappoint.value).split(",");
		var existStateBtnImgUrl = ".gif";
		if(selectedExistState == "" || selectedExistState.length == 0){
			existStateBtnImgUrl = "_chk.gif";
		}
		if(strExistStateCnt == ""){
			$("div_detail_layer_2").innerHTML = "<div style=\"float:left;width:830px;height:15px;text-align:center;margin-top:55px;\">해당 예약 상태가 없습니다.</div>";
		}else{
			var tempInnerHtml = "";
			 tempInnerHtml = "<div id=\"div_detail_layer_2_div1\">"
								  + "	<ul>"
								  + "		<li style=\"width:100px\">"
								  + "			<div cles=\"detail_layer_2_img_div\">"
								  + "				<img class=\"detail_layer_2_img\" id=\"ExistState0\" src=\""+IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_65"+existStateBtnImgUrl+"\" complete=\"complete\"/>"
								  + "				<div class=\"detail_layer_2_stitleblod\">전체</div>"
								  + "				<div class=\"detail_layer_2_scnt\"><font class=\"detail_layer_cnt\">"+strExistStateCnt[0]+"</font><font class=\"detail_layer_ea\">개</font></div>"
								  + "				<div class=\"btn65\" onmouseover=\"detailbunov('ExistState0');\" onmouseout=\"detailbunou('ExistState0')\" onclick=\"cmdTravelDetail1('ExistState0','0')\" >"
								  + "				<img src=\""+IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_none_65.gif\" complete=\"complete\"/>"
								  + "				</div>"
								  + "			</div>"
								  + "		</li>"
								  + "		<li style=\"width:120px\">"
								  + "			<div class=\"detail_layer_2_img_div\">";
								  existStateBtnImgUrl = ".gif";
								  for(var j=0;j<selectedExistState.length;j++){
								  	if(selectedExistState[j]==1){
								  		existStateBtnImgUrl = "_chk.gif";
								  		strExistStateText = "<span class=\"ft_resultline\">접수중</span>";
								  	}
								  }
								  tempInnerHtml = tempInnerHtml
								  + "				<img class=\"detail_layer_2_img\" id=\"ExistState1\" src=\""+IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_83"+existStateBtnImgUrl+"\" complete=\"complete\"/>"
								  + "				<div class=\"detail_layer_2_stitle\">접수중</div>"
								  + "				<div class=\"detail_layer_2_scnt83\"><font class=\"detail_layer_cnt\">"+strExistStateCnt[1]+"</font><font class=\"detail_layer_ea\">개</font></div>"
								  + "				<div class=\"btn85\" onmouseover=\"detailbunov('ExistState1');\" onmouseout=\"detailbunou('ExistState1')\" onclick=\"cmdTravelDetail1('ExistState1','1')\" >"
								  + "				<img src=\""+IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_none_83.gif\" complete=\"complete\"/>"
								  + "				</div>"
								  + "			</div>"
								  + "		</li>"
								  + "		<li style=\"width:150px\">"
								  + "			<div class=\"detail_layer_2_img_div\">";
								  existStateBtnImgUrl = ".gif";
								  for(var j=0;j<selectedExistState.length;j++){
								  	if(selectedExistState[j]==2){
								  		existStateBtnImgUrl = "_chk.gif";
								  		if(strExistStateText.length != 0){
								  			strExistStateText = strExistStateText + ",<br>";
								  		}
								  		strExistStateText = strExistStateText + "<span class=\"ft_resultline\" title=\"예약인원 상관없이 출발 가능\">접수중<font style=\"font-family:돋움;font-size:8pt;color:gray\">(출발확정)</font></span>";
								  	}
								  }
								  tempInnerHtml = tempInnerHtml
								  + "				<img class=\"detail_layer_2_img\" id=\"ExistState2\" src=\""+IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_110"+existStateBtnImgUrl+"\" complete=\"complete\"/>"
								  + "				<div class=\"detail_layer_2_stitle_110\">접수중(출발확정)</div>"
								  + "				<div class=\"detail_layer_2_scnt110\"><font class=\"detail_layer_cnt\">"+strExistStateCnt[2]+"</font><font class=\"detail_layer_ea\">개</font></div>"
								  + "				<div class=\"btn110\" onmouseover=\"detailbunov('ExistState2');\" onmouseout=\"detailbunou('ExistState2')\" onclick=\"cmdTravelDetail1('ExistState2','2')\" >"
								  + "				<img src=\""+IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_none_110.gif\" complete=\"complete\"/>"
								  + "				</div>"
								  + "			</div>"
								  + "		</li>"
	  							  + "		<li style=\"width:100px\">"
								  + "			<div class=\"detail_layer_2_img_div\">";
								  existStateBtnImgUrl = ".gif";
								  for(var j=0;j<selectedExistState.length;j++){
								  	if(selectedExistState[j]==3){
								  		existStateBtnImgUrl = "_chk.gif";
								  		if(strExistStateText.length != 0){
								  			strExistStateText = strExistStateText + ",<br>";
								  		}
								  		strExistStateText = strExistStateText + "<span class=\"ft_resultline\">마감</span>";
								  	}
								  }
								  tempInnerHtml = tempInnerHtml
								  + "				<img class=\"detail_layer_2_img\" id=\"ExistState3\" src=\""+IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_65"+existStateBtnImgUrl+"\" complete=\"complete\"/>"
								  + "				<div class=\"detail_layer_2_stitle\">마감</div>"
								  + "				<div class=\"detail_layer_2_lscnt\"><font class=\"detail_layer_cnt\">"+strExistStateCnt[3]+"</font><font class=\"detail_layer_ea\">개</font></div>"
								  + "				<div class=\"btnl65\" onmouseover=\"detailbunov('ExistState3');\" onmouseout=\"detailbunou('ExistState3')\" onclick=\"cmdTravelDetail1('ExistState3','3')\" >"
								  + "				<img src=\""+IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_none_65.gif\" complete=\"complete\"/>"
								  + "				</div>"
								  + "			</div>"
								  + "		</li>"
								  + "   </ul>"
								  + "	<li>" 
								  +"		<div id=\"div_go_search2\" onclick=\"goSearch(2)\">"
								  +"		<img src=\""+IMG_ENURI_COM+"/images/view/travel_new/go_btn_1211141.gif\"  >"
								  +"		</div>"
								  + "	</li>"
								  + "</div>";								  
			$("div_detail_layer_2").innerHTML = tempInnerHtml;
		}
		// 항공시간 html make
		var strArrExistTimesCnt = eval("arrReturn.strArrExistTimesCnt").split(",");
		var selectedExistTimes = (obj.stime.value).split(",");
		selectedExistTimes = selectedExistTimes.sort();
		var strExistTimesText = "";
		var strExistTimesSText = "";
		var strExistTimesEText = "";
		var tempArrStime = new Array(13);
		tempArrStime[0] = ".gif";
		for(var k=1; k<13; k++){
			tempArrStime[k] = ".gif";
		}
		if(obj.stimetype.value == "B"){
			for(i=0; i<selectedExistTimes.length; i++){
				if (selectedExistTimes[i].substring(0,1)=="S"){
					if(selectedExistTimes[i].substring(1,5)=="0004"){
						tempArrStime[1] = "_chk.gif";
						strExistTimesSText = strExistTimesSText + "00시~04시,";
					}else if(selectedExistTimes[i].substring(1,5)=="0408"){
						tempArrStime[2] = "_chk.gif";
						strExistTimesSText = strExistTimesSText + "04시~08시,";
					}else if(selectedExistTimes[i].substring(1,5)=="0812"){
						tempArrStime[3] = "_chk.gif";
						strExistTimesSText = strExistTimesSText + "08시~12시,";
					}else if(selectedExistTimes[i].substring(1,5)=="1216"){
						tempArrStime[4] = "_chk.gif";
						strExistTimesSText = strExistTimesSText + "12시~16시,";
					}else if(selectedExistTimes[i].substring(1,5)=="1620"){
						tempArrStime[5] = "_chk.gif";
						strExistTimesSText = strExistTimesSText + "16시~20시,";
					}else if(selectedExistTimes[i].substring(1,5)=="2024"){
						tempArrStime[6] = "_chk.gif";
						strExistTimesSText = strExistTimesSText + "20시~24시,";
					}
				}else if (selectedExistTimes[i].substring(0,1)=="E"){
					if(selectedExistTimes[i].substring(1,5)=="0004"){
						tempArrStime[7] = "_chk.gif";
						strExistTimesEText = strExistTimesEText + "00시~04시,";
					}else if(selectedExistTimes[i].substring(1,5)=="0408"){
						tempArrStime[8] = "_chk.gif";
						strExistTimesEText = strExistTimesEText + "04시~08시,";
					}else if(selectedExistTimes[i].substring(1,5)=="0812"){
						tempArrStime[9] = "_chk.gif";
						strExistTimesEText = strExistTimesEText + "08시~12시,";
					}else if(selectedExistTimes[i].substring(1,5)=="1216"){
						tempArrStime[10] = "_chk.gif";
						strExistTimesEText = strExistTimesEText + "12시~16시,";
					}else if(selectedExistTimes[i].substring(1,5)=="1620"){
						tempArrStime[11] = "_chk.gif";
						strExistTimesEText = strExistTimesEText + "16시~20시,";
					}else if(selectedExistTimes[i].substring(1,5)=="2024"){
						tempArrStime[12] = "_chk.gif";
						strExistTimesEText = strExistTimesEText + "20시~24시,";
					}
				}
			}
		}
		if(strExistTimesSText.length > 0){
			strExistTimesSText = "출발:"+strExistTimesSText.substring(0,strExistTimesSText.length-1);
		}
		if(strExistTimesEText.length > 0){
			strExistTimesEText = "도착:"+strExistTimesEText.substring(0,strExistTimesEText.length-1);
		}
		strExistTimesText = strExistTimesSText;
		if(strExistTimesEText.length > 0){
			if(strExistTimesText.length > 0){
			 	strExistTimesText = strExistTimesText + "<BR>" + strExistTimesEText;
			 }else{
			 	strExistTimesText = strExistTimesEText;
			 }
		 }
		if(selectedExistTimes == "" || selectedExistTimes.length == 0){
			tempArrStime[0] = "_chk.gif";
		}
		if(strArrExistTimesCnt == ""){
			$("div_detail_layer_3").innerHTML = "<div style=\"float:left;width:830px;height:15px;text-align:center;margin-top:55px;\">해당 항공 시간이 없습니다.</div>";
		}else{
			var tempInnerHtml = "";
			 tempInnerHtml = "<div id=\"div_detail_layer_3_div1\">"
						  + "	<ul>"
						  + "		<li style=\"width:550px\">"
						  + "			<div class=\"detail_layer_3_img_div\">"
						  + "				<img class=\"detail_layer_3_img\" id=\"ExistTimes0\" src=\""+IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_65"+tempArrStime[0]+"\" complete=\"complete\"/>"
						  + "				<div class=\"detail_layer_3_stitleblod\">전체</div>"
						  + "				<div class=\"detail_layer_3_scnt\"><font class=\"detail_layer_cnt\">"+strArrExistTimesCnt[0]+"</font><font class=\"detail_layer_ea\">개</font></div>"
						  + "				<div class=\"btn65\" onmouseover=\"detailbunov('ExistTimes0');\" onmouseout=\"detailbunou('ExistTimes0')\" onclick=\"cmdTravelDetail2('ExistTimes0','0')\" >"
						  + "				<img src=\""+IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_none_65.gif\" complete=\"complete\"/>"
						  + "				</div>"
						  + "			</div>"
						  + "		</li>"
						  + "	</ul>"								
						  + "	<ul>"
						  + "		<li style=\"width:500px;height:65px;\">"
						  + "			<div class=\"detail_layer_3_timeimg\">";
						   for(i=1;i<strArrExistTimesCnt.length;i++){
						   	if(strArrExistTimesCnt[i] > 0){
								 tempInnerHtml = tempInnerHtml
						  + "				<div class=\"detail_layer_3_time"+i+"\">"
						  + "					<img id=\"ExistTimes"+i+"\" src=\""+IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_6020"+tempArrStime[i]+"\" complete=\"complete\"/>"
						  + "					<div class=\"detail_layer_3_dcnt\"><font class=\"detail_layer_cnt\">"+strArrExistTimesCnt[i]+"</font><font class=\"detail_layer_ea\">개</font></div>"
						  + "					<div class=\"btn6020\" onmouseover=\"detailbunov('ExistTimes"+i+"');\" onmouseout=\"detailbunou('ExistTimes"+i+"')\" onclick=\"cmdTravelDetail2('ExistTimes"+i+"','"+i+"')\" >"
						  + "					<img src=\""+IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_none_6020.gif\" complete=\"complete\"/>"
						  + "					</div>"
						  + "				</div>";
						  	}else{
						  		 tempInnerHtml = tempInnerHtml
						  + "				<div class=\"detail_layer_3_time"+i+"\">"
						  + "					<div class=\"btn6020n\" >"
						  + "					<img src=\""+IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_none_6020.gif\" complete=\"complete\"/>"
						  + "					</div>"
						  + "				</div>";
						  	}
						  }						   
						  tempInnerHtml = tempInnerHtml 
						  + "	<li>" 
						  +"		<div id=\"div_go_search3\" onclick=\"goSearch(3)\">"
						  +"		<img src=\""+IMG_ENURI_COM+"/images/view/travel_new/go_btn_1211141.gif\"  >"
						  +"		</div>"
						  + "	</li>"
						  tempInnerHtml = tempInnerHtml
						  + "			</div>"
						  + "		</li>"
						  + "	</ul>"
						  + "</div>";
						  
						  var directInputImg = "";
						  var directInputBox = "";
						  if(obj.stimetype.value == "T"){
						  	directInputImg = "style=\"display:none\""; 
						  }else{
						  	directInputBox = "style=\"display:none\"";
						  }
						  
						  
						  tempInnerHtml = tempInnerHtml
						  + "<div id=\"div_detail_layer_3_div2\">"
						  + "	<img id=\"directViewImg\" class=\"existtimebtn\" "+directInputImg+" src=\""+IMG_ENURI_COM+"/images/view/travel/search/time_direct_bt.gif\" onclick=\"viewDirectTime()\" complete=\"complete\"/>"
						  + "	<div id=\"inputexisttime\" class=\"inputexisttime\" "+directInputBox+">"
						  + "		<ul style=\"height:30px;\">"
						  + "			<li><span class=\"inputexisttimetit\">직접입력</span><img class=\"xbtn\" src=\""+IMG_ENURI_COM+"/images/view/travel/2012/tour_air_directTime_Btn.gif\" onclick=\"hideDirectTime();\" complete=\"complete\"/></li>"
						  + "		</ul>"
						  + "		<ul style=\"height:40px;\">"
						  + "			<li>"
						  + "				<select id=\"travel_detail2_1\" class=\"txtarea\" onChange=\"cmdTravelDetail2Select()\" >";
						  		var strStimeExpress = "";
								var strStimeSelected = "";
								
								
								var tStartTime = "00";
								var tEndTime = "00";
								var tStartChecked = "checked";
								var tEndChecked = "";
								
								if(obj.stimetype.value == "T"){
									strExistTimesText = "출발:";
									tStartTime = (obj.stime.value).substring(1,3);
									tEndTime = (obj.stime.value).substring(3,5);
									if((obj.stime.value).substring(0,1) == "E" ){
										tStartChecked = "";
										tEndChecked = "checked";
										strExistTimesText = "도착:";
									}
									strExistTimesText = strExistTimesText + tStartTime + "시~" + tEndTime + "시";
								}
								
								for (i=0; i<24; i++){
									strStimeExpress = "";
									strStimeSelected = "";
									if (i<10){
										strStimeExpress = "0" + i;
									}else{
										strStimeExpress = "" + i;
									}
									if(strStimeExpress == tStartTime){
										strStimeSelected = "selected";
									}
						  tempInnerHtml = tempInnerHtml
						  + "					<option value=\""+strStimeExpress+"\" "+strStimeSelected+">"+strStimeExpress+"</option>";
								}
						  tempInnerHtml = tempInnerHtml
						  + "				</select> 시~"
						  + "				<select id=\"travel_detail2_2\" class=\"txtarea\" onChange=\"cmdTravelDetail2Select()\" >";
								for (i=0; i<=24; i++){
									strStimeExpress = "";
									strStimeSelected = "";
									if (i<10){
										strStimeExpress = "0" + i;
									}else{
										strStimeExpress = "" + i;
									}
									if(strStimeExpress == tEndTime){
										strStimeSelected = "selected";
									}		
						  tempInnerHtml = tempInnerHtml
						  + "					<option value=\""+strStimeExpress+"\" "+strStimeSelected+">"+strStimeExpress+"</option>";
								}
						  tempInnerHtml = tempInnerHtml
						  + "				</select> 시 "
						  + "			</li>"
						  tempInnerHtml = tempInnerHtml 
						  + "		</ul>"
						  + "		<ul>"
						  + "			<li><input type=\"radio\" name=\"travel_detail2_3\" id=\"travel_detail2_3start\" value=\"start\" onClick=\"cmdTravelDetail2Select()\" "+tStartChecked+"></li>"
						  + "			<li>출발</li>"
						  + "			<li style=\"width:40px;\">&nbsp;</li>"
						  + "			<li><input type=\"radio\" name=\"travel_detail2_3\" id=\"travel_detail2_3end\" value=\"end\" onClick=\"cmdTravelDetail2Select()\" "+tEndChecked+"></li>"
						  + "			<li>도착</li>"
						  + "		</ul>"
						  + "	</div>"
						  + "</div>"
						  + "<div id=\"div_detail_layer_3_div3\">"
						  + "<div id=\"travel_detail2_info\"></div>";
						  + "</div>";
						  		  
			$("div_detail_layer_3").innerHTML = tempInnerHtml;
		}	
		var strPrice = eval("arrReturn.strPrice").split(",");
		var inputMinPrice = "";
		var inputMaxPrice = "";
		var strPriceText = "";
		var minPrice = 0;
		var maxPrice = 0;
		if(strPrice == ""){
			$("div_detail_layer_4").innerHTML = "<div style=\"float:left;width:830px;height:15px;text-align:center;margin-top:55px;\">해당 가격대가 없습니다.</div>";
		}else{
			var tempInnerHtml = "";
			minPrice = 0;
			maxPrice = 0;
			
			if(strPrice[0]>0){
				minPrice = strPrice[0];
			}
			
			if(strPrice[1]>0){
				maxPrice = strPrice[1];
			}
			inputMinPrice = parseInt(obj.spricef.value/10000,10);
			inputMaxPrice = parseInt(obj.spricet.value/10000,10);
			if(obj.spricef.value == minPrice || inputMinPrice == 0){
				inputMinPrice = minPrice;
			}
			if(obj.spricet.value == maxPrice || inputMaxPrice == 0){
				inputMaxPrice = maxPrice;
			}
			strPriceText = inputMinPrice + "만원 ~ " + inputMaxPrice + "만원";
			 tempInnerHtml = "<div id=\"div_detail_layer_4_div1\">"
  								  + "	<ul class=\"detail_layer_4_tbl1\">"
								  + "		<li>"
								  + "       	<span> 원하시는 가격대를 입력해주세요   </span>"
								  + "		</li>"
								  + "		<li>"
								  + "			<img src=\""+IMG_ENURI_COM+"/images/view/travel/p_arrow.gif\" complete=\"complete\"/>"
								  + "		</li>"
								  + "		<li>가격범위:</li>"
								  + "		<li>"
								  + "			<input type=\"text\" name=\"travel_detail3_min\" id=\"travel_detail3_min\" class=\"txtareaprice\" size=\"3\" value=\""+inputMinPrice+"\" maxlength=\"3\" onKeyDown=\"only_number();\">"
								  + "		</li>"
								  + "		<li>만원 ~&nbsp;</li>"
								  + "		<li>"
								  + "			<input type=\"text\" name=\"travel_detail3_max\" id=\"travel_detail3_max\" class=\"txtareaprice\" size=\"3\" value=\""+inputMaxPrice+"\" maxlength=\"3\" onKeyDown=\"only_number();\">"
								  + "		</li>"
								  + "		<li>만원 </li>"
								  + "	</ul>"
								  + "	<ul class=\"detail_layer_4_tbl2\">"
								  + "		<li><span>입력범위:</li>"
								  + "		<li><span id=\"detail_price_min\">"+minPrice+"</span>만원 ~&nbsp;</li>"
								  + "		<li><span id=\"detail_price_max\">"+maxPrice+"</span>만원</li>"
								  + "	</ul>"
								  tempInnerHtml = tempInnerHtml 
								  + "	<li>" 
								  +"		<div id=\"div_go_search4\" onclick=\"goSearch(4)\">"
								  +"		<img src=\""+IMG_ENURI_COM+"/images/view/travel_new/go_btn_1211141.gif\"  >"
								  +"		</div>"
								  + "	</li>"
								  + "</div>";
			$("div_detail_layer_4").innerHTML = tempInnerHtml;	
		}
	var strArrFactoryName = eval("arrReturn.strArrFactoryName").split(",");
	var strArrFactoryCnt = eval("arrReturn.strArrFactoryCnt").split(",");
	var strArrAirName = eval("arrReturn.strArrAirName").split(",");
	var strArrAirCnt = eval("arrReturn.strArrAirCnt").split(",");
	var strArrAirCode = eval("arrReturn.strArrAirCode").split(",");
	var selectedFactory = (obj.sfactory.value).split(",");
	var selectedAirline = (obj.sairline.value).split(",");
	var strFactoryText = "";
	var strAirText = "";
	if(strArrFactoryCnt == "0" || strArrAirCnt == "0" || strArrFactoryCnt == "" || strArrAirCnt == ""){
		$("div_detail_layer_5").innerHTML = "<div style=\"float:left;width:830px;height:15px;text-align:center;margin-top:55px;\">해당 여행사/항공사가 없습니다.</div>";
	}else{
		var factoryBtn = "";
		var factoryBtnUnderLine = "";
		if(selectedFactory == "" || selectedFactory.length == 0){
			factoryBtn = "checked";
			factoryBtnUnderLine = "text-decoration:underline;"
		}
		var tempInnerHtml ="";
		tempInnerHtml = "<div id=\"div_detail_layer_5_div1\">"
					  + "	<ul class=\"div_detail_layer_5_tr1\">"
					  + "		<li style=\"width:120px;\"><ul><li style=\"width:15px;\"><input type=\"checkbox\" style=\"width:13px;height:13px;\" id=\"detail_factoryname_all\" onclick=\"cmdFactoryDetail4Click('all');\" "+factoryBtn+" /></li><li id=\"detail_factorycnt_all\" style=\"width:105px;"+factoryBtnUnderLine+"\"><STRONG>"+strArrFactoryName[0]+"</STRONG><font class=\"red_cnt\">"+strArrFactoryCnt[0]+"</font><font class=\"black_ea\">개</font></li></ul></li>"
					  + "		<li style=\"width:600px;height:54px;\">"
					  + "			<div id=\"div_detail_layer_5_tourlist\">";
					  for(i=1;i<strArrFactoryName.length;i++){
					   	factoryBtn = "";
						factoryBtnUnderLine = ""
					    for(var j=0;j<selectedFactory.length;j++){
					   	  	if(strArrFactoryName[i] == selectedFactory[j]){
					   	  		factoryBtn = "checked";
								factoryBtnUnderLine = "text-decoration:underline;"
								if(j==0){
									strFactoryText ="<span style=\"float:left;width:44px;\">여행사 : </span>"+selectedFactory[j] + "<br>";
								}else{
									strFactoryText = strFactoryText + "<span style=\"float:left;width:44px;\">&nbsp;</span>" + selectedFactory[j] + "<br>";
								}
					   	  	 } 
					   	  }
						  if(i%6==1){
					  	  	tempInnerHtml = tempInnerHtml + "				<ul style=\"height:18px;width:700px;border:\">";
						  }
					        tempInnerHtml = tempInnerHtml + "					<li style=\"width:15px;margin-left:5px;\"><input type=\"checkbox\" style=\"width:13px;height:13px;\" id=\"detail_factoryname_"+(i-1)+"\"   onclick=\"cmdFactoryDetail4Click('"+(i-1)+"');\" "+factoryBtn+"/></li><li id=\"detail_factorycnt_"+(i-1)+"\" style=\"width:96px;text-align:left;"+factoryBtnUnderLine+"\">"+strArrFactoryName[i]+"<font class=\"red_cnt\">"+strArrFactoryCnt[i]+"</font><font class=\"black_ea\">개</font></li>";
						  if(i%6==0 || i == strArrFactoryName.length-1){
						  	tempInnerHtml = tempInnerHtml  + "				</ul>";
						  }
					  }
					   var airBtn = "";
					   var airBtnUnderLine = "";
					   if(selectedAirline == "" || selectedAirline.length == 0){
						   airBtn = "checked";
						   airBtnUnderLine = "text-decoration:underline;"
					   }
					   
					  tempInnerHtml = tempInnerHtml
					  + "			</div>"
					  + "		</li>"
					  + "	</ul>"
					  + "	<ul class=\"div_detail_layer_5_tr2\">"
					  + "		<li>&nbsp;</li>"
					  + "	</ul>"
					  + "	<ul class=\"div_detail_layer_5_tr3\">"
					  + "		<li style=\"float:left;width:120px;\"><ul><li style=\"width:15px;\"><input type=\"checkbox\" style=\"width:13px;height:13px;\" id=\"detail_airname_all\" onclick=\"cmdAirDetail4Click('all');\" "+airBtn+" /></li><li id=\"detail_aircnt_all\"  style=\"width:105px;"+airBtnUnderLine+"\"><STRONG>"+strArrAirName[0]+"</STRONG><font class=\"red_cnt\">"+strArrAirCnt[0]+"</font><font class=\"black_ea\">개</font><font id=\"codeAll\" style=\"display:none;\">all</font></li></ul></li>"
					  + "		<li style=\"width:600px;height:54px;\">"
					  + "			<div id=\"div_detail_layer_5_airlist\">";
					   for(i=1;i<strArrAirName.length;i++){
					   	  airBtn = "";
						  airBtnUnderLine = ""
					   	  for(var j=0;j<selectedAirline.length;j++){
					   	  	 if(strArrAirCode[i] == selectedAirline[j]){
					   	  		airBtn = "checked";
								airBtnUnderLine = "text-decoration:underline;"
								if(j==0){
									strAirText = "<span style=\"float:left;width:44px;\">항공사  : </span>" + strArrAirName[i] + "<br>";
								}else{
									strAirText = strAirText + "<span style=\"float:left;width:44px;\">&nbsp;</span>" + strArrAirName[i] + "<br>";
								}
					   	  	 } 
					   	  }
						  if(i%6==1){
					  	  	tempInnerHtml = tempInnerHtml + "				<ul style=\"height:18px;width:700px;border:\">";
						  }
						    tempInnerHtml = tempInnerHtml + "					<li style=\"width:15px;margin-left:5px;\"><input type=\"checkbox\" style=\"width:13px;height:13px;\" id=\"detail_airname_"+(i-1)+"\" onclick=\"cmdAirDetail4Click('"+(i-1)+"');\" "+airBtn+" /></li><li id=\"detail_aircnt_"+(i-1)+"\"  style=\"width:96px;text-align:left;"+airBtnUnderLine+"\">"+strArrAirName[i]+"<font class=\"red_cnt\">"+strArrAirCnt[i]+"</font><font class=\"black_ea\">개</font><font id=\"code"+(i-1)+"\" style=\"display:none;\">"+strArrAirCode[i]+"</font></li>";
						  if(i%6==0 || i == strArrAirName.length-1){
						   	tempInnerHtml = tempInnerHtml  + "				</ul>";
						  }
					  }
					  tempInnerHtml = tempInnerHtml
					  + "			</div>"
					  + "		</li>"
					  + "	</ul>"
					  + "</div>";
					  tempInnerHtml = tempInnerHtml 
					  + "	<li>" 
					  +"		<div id=\"div_go_search5\" onclick=\"goSearch(5)\">"
					  +"		<img src=\""+IMG_ENURI_COM+"/images/view/travel_new/go_btn_1211141.gif\"  >"
					  +"		</div>"
					  + "	</li>"					  
		$("div_detail_layer_5").innerHTML = tempInnerHtml;	
	} 	
	var strFactoryAirText = strFactoryText.substring(0, strFactoryText.length-4);
	if(strAirText.length > 0){
		if(strFactoryText.length==0){
			strFactoryAirText = strFactoryAirText;
		}else{
			strFactoryAirText = strFactoryAirText + "<br>";
		}
	}
	strFactoryAirText = strFactoryAirText + strAirText.substring(0, strAirText.length-4);
	// 지방 출발 상태
	var strArrLocationName = eval("arrReturn.strArrLocationName").split(",");
	var strArrLocationCnt = eval("arrReturn.strArrLocationCnt").split(",");
	var selectedLocation = (obj.slocalcity.value).split(",");
	var strLocationText = "";
	var locationBtn = ".gif";
	if(selectedLocation == "" || selectedLocation.length == 0){
		locationBtn = "_chk.gif";
	}
	if(strArrLocationCnt == "0" || strArrLocationCnt == ""){
		$("div_detail_layer_6").innerHTML = "<div style=\"float:left;width:830px;height:15px;text-align:center;margin-top:55px;\">해당 지방 출발이 없습니다.</div>";
	}else{
		var tempInnerHtml = "";
		 tempInnerHtml = "<div id=\"div_detail_layer_6_div1\">"
							  + "	<ul>"
							  + "		<li><span>지방출발 →</span></li>"
							  + "	</ul>"
							  + "	<ul>"
							  + "		<li>"
							  + "			<div class=\"detail_layer_6_img_div\">"
							  + "				<img class=\"detail_layer_6_img\" id=\"Location0\" src=\""+IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_65"+locationBtn+"\" complete=\"complete\"/>"
							  + "				<div class=\"detail_layer_6_stitleblod\">"+strArrLocationName[0]+"</div>"
							  + "				<div class=\"detail_layer_6_scnt\"><font class=\"detail_layer_cnt\">"+strArrLocationCnt[0]+"</font><font class=\"detail_layer_ea\">개</font></div>"
							  + "				<div class=\"btn65\" onmouseover=\"detailbunov('Location0');\" onmouseout=\"detailbunou('Location0')\" onclick=\"cmdTravelDetail6('Location0')\" >"
							  + "				<img src=\""+IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_none_65.gif\" complete=\"complete\"/>"
							  + "				</div>"
							  + "			</div>"
							  + "		</li>";
							  for(var i=1;i<strArrLocationName.length;i++){
							  		locationBtn = ".gif";
							  		for(var j=0;j<selectedLocation.length;j++){
							  			
							  			if(selectedLocation[j] == "1"){
											selectedLocation[j] = "부산";
										}else if(selectedLocation[j] == "2"){
											selectedLocation[j] = "광주";
										}else if(selectedLocation[j] == "3"){
											selectedLocation[j] = "대구";
										}else if(selectedLocation[j] == "4"){
											selectedLocation[j] = "청주";
										}else if(selectedLocation[j] == "5"){
											selectedLocation[j] = "제주";
										}
							  		
							  			if(strArrLocationName[i] == selectedLocation[j]){
							  				locationBtn = "_chk.gif";
							  			}
							  		}
							   tempInnerHtml = tempInnerHtml
							   + "		<li>"
							   + "			<div class=\"detail_layer_6_img_div\">"
							   + "				<img class=\"detail_layer_6_img\" id=\"Location"+i+"\" src=\""+IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_65"+locationBtn+"\" complete=\"complete\"/>"
							   + "				<div class=\"detail_layer_6_stitle\">"+strArrLocationName[i]+"</div>"
							   + "				<div class=\"detail_layer_6_scnt\"><font class=\"detail_layer_cnt\">"+strArrLocationCnt[i]+"</font><font class=\"detail_layer_ea\">개</font></div>"
							   + "				<div class=\"btn65\" onmouseover=\"detailbunov('Location"+i+"');\" onmouseout=\"detailbunou('Location"+i+"')\" onclick=\"cmdTravelDetail6('Location"+i+"','"+strArrLocationName[i]+"')\" >"
							   + "				<img src=\""+IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_none_65.gif\" complete=\"complete\"/>"
							   + "				</div>"
						       + "			</div>";
							   + "		</li>"
							  }
							  tempInnerHtml = tempInnerHtml 
							  + "	<li>" 
							  +"		<div id=\"div_go_search6\" onclick=\"goSearch(6)\">"
							  +"		<img src=\""+IMG_ENURI_COM+"/images/view/travel_new/go_btn_1211141.gif\"  >"
							  +"		</div>"
							  + "	</li>"
		tempInnerHtml = tempInnerHtml + "</ul></div>";
		$("div_detail_layer_6").innerHTML = tempInnerHtml;	
	}	
	for(var j=0;j<selectedLocation.length;j++){
		strLocationText = strLocationText + selectedLocation[j];
		if(j != selectedLocation.length-1){
			strLocationText = strLocationText + ",";
		} 
	}
	var tempInnerHtml = "";
	tempInnerHtml = "<div id=\"div_detail_layer_7_div1\">"
					+"	<ul>"
					+"		<li id=\"detail_layer_7_title1\" class=\"detail_layer_7_title1\">";
					if(ltab!="A7"){
					tempInnerHtml = tempInnerHtml
					+"			<img id=\"img_resultmap_tit1\" src=\""+IMG_ENURI_COM+"/images/view/travel/2012/resultmap_tit1.gif\" complete=\"complete\"/>"
					+"			<div class=\"ft_resultline\" id=\"resultmap_getarea\">"+maparea+"</div>";
					}else{
					tempInnerHtml = tempInnerHtml
					+"			<img id=\"img_resultmap_tit1\" src=\""+IMG_ENURI_COM+"/images/view/travel/2012/resultmap_tit2.gif\" complete=\"complete\"/>"
					+"			<div class=\"ft_resultline\" id=\"resultmap_getarea\">"+mapsubject+"</div>";
					}
					
					tempInnerHtml = tempInnerHtml
					+"		</li>"
					+"		<li id=\"detail_layer_7_title3\" class=\"detail_layer_7_title3\">"
					+"			<img id=\"img_resultmap_tit3\" src=\""+IMG_ENURI_COM+"/images/view/travel/2012/resultmap_tit3.gif\" complete=\"complete\"/>"
					+"			<div class=\"ft_resultline\" id=\"resultmap_getstartday\">"+mapstart+"</div>"
					+"		</li>";
					
					if(mapperiod != "" || strSpdayText != ""){
					var tempInnerPeriod = "";
					if(strSpdayText != ""){
						tempInnerPeriod = strSpdayText;
					}else{
						tempInnerPeriod = mapperiod;
					}
					tempInnerHtml = tempInnerHtml
					+"		<li id=\"detail_layer_7_title4\" class=\"detail_layer_7_title4\">"
					+"			<img id=\"img_resultmap_tit4\" src=\""+IMG_ENURI_COM+"/images/view/travel/2012/resultmap_tit4.gif\" complete=\"complete\"/>"
					+"			<div class=\"ft_resultline\" id=\"resultmap_getperiod\">"+tempInnerPeriod+"</div>"
					+"		</li>";
					}
					if(detailViewFlag){
						if(strExistStateText.length>0){
							strCurHtml = strCurHtml
							+"		<li id=\"detail_layer_7_title5\" class=\"detail_layer_7_title5\" >"
							+"			<img id=\"img_resultmap_tit4\" src=\""+IMG_ENURI_COM+"/images/view/travel/2012/resultmap_tit5.gif\" complete=\"complete\"/>"
							+"			<div class=\"ft_resultline\" id=\"resultmap_getstate\">"+strExistStateText+"</div>"
							+"		</li>";
						}
						if(strExistTimesText.length>0){
							strCurHtml = strCurHtml
							+"		<li id=\"detail_layer_7_title6\" class=\"detail_layer_7_title6\" >"
							+"			<img id=\"img_resultmap_tit4\" src=\""+IMG_ENURI_COM+"/images/view/travel/2012/resultmap_tit6.gif\" complete=\"complete\"/>"
							+"			<div class=\"ft_resultline\" id=\"resultmap_getairtime\">"+strExistTimesText+"</div>"
							+"		</li>";
						}
						if(inputMinPrice != minPrice || inputMaxPrice != maxPrice){
							strCurHtml = strCurHtml
							+"		<li id=\"detail_layer_7_title7\" class=\"detail_layer_7_title7\" >"
							+"			<img id=\"img_resultmap_tit4\" src=\""+IMG_ENURI_COM+"/images/view/travel/2012/resultmap_tit7.gif\" complete=\"complete\"/>"
							+"			<div class=\"ft_resultline\" id=\"resultmap_getprice\">" + inputMinPrice + "만원 ~ " + inputMaxPrice + "만원</div>"
							+"		</li>";
						}
						if(strFactoryAirText.length>0){
							strCurHtml = strCurHtml
							+"		<li id=\"detail_layer_7_title8\" class=\"detail_layer_7_title8\" >"
							+"			<img id=\"img_resultmap_tit4\" src=\""+IMG_ENURI_COM+"/images/view/travel/2012/resultmap_tit8.gif\" complete=\"complete\"/>"
							+"			<div class=\"ft_resultline\" id=\"resultmap_getairtour\">"+strFactoryAirText+"</div>"
							+"		</li>";
						}
						if(strLocationText.length>0){
							strCurHtml = strCurHtml
							+"		<li id=\"detail_layer_7_title9\" class=\"detail_layer_7_title9\" >"
							+"			<img id=\"img_resultmap_tit4\" src=\""+IMG_ENURI_COM+"/images/view/travel/2012/resultmap_tit9.gif\" complete=\"complete\"/>"
							+"			<div class=\"ft_resultline\" id=\"resultmap_getregionstart\">"+strLocationText+"</div>"
							+"		</li>";
						}						
					}
					// 현재 위치를 다시 넣을때 사용
					tempInnerHtml = tempInnerHtml + strCurHtml
					+"	</ul>"
					+"</div>";
		$("div_detail_layer_7").innerHTML = tempInnerHtml;
		//현재 위치 저장된 부분 삭제	
		strCurHtml = "";
		// 가격 설정
		intTravelMinPrice = minPrice;
		intTravelMaxPrice = maxPrice;
		if ((maparea.indexOf("없습니다")>0 || (ltab=="A7" && mapsubject=="")) && mapstart.indexOf("없습니다")>0 && selectDetailView == '3'){ //여행지, 출발일 둘다 선택이 없으면 현재위치 사라짐
			$("div_searchresultmap").style.display = "none";
		}else{
			$("div_searchresultmap").style.display = "block";
		}
	}
	if(selectDetailView=="7"){
		$("div_detail_layer_7").style.display = "block";
	}
	if(detailViewFlag){
		detailViewFlag = false;
		//deletedetailSearchParameter();
	}
	var selectedSubject = document.getElementById("txt_subject").value;
	if(  (selectedSubject.length > 0 || arrSelectedArea.length > 0 )  && (strSelectMaxDayAfter!="" || (varStartDateType=="D" && arrSelectedDate.length>0) || (varStartDateType=="T" && strSelectedFromDate!="" && strSelectedToDate!="")) ){
	
	}else{
		$("resultmap_gettextline").style.display = "none";
		$("resultmap_getcntline").style.display = "none";
	}
	$("main_resultmap_getcntline").style.display = "none";
	//setTimeout("loadingbaroff();", 500);
}
function CmdLink(url){
	location.href = url;
}
function only_number() {
	if ((event.keyCode>=48 && event.keyCode<=57) || (event.keyCode>=96 && event.keyCode<=105) || (event.keyCode==9) || (event.keyCode==8) || (event.keyCode==46) || (event.keyCode==37) || (event.keyCode==39)) {
		chkGoViewBtn();
	}else{
		event.returnValue=false;
	}
}
//기본조건 선택마다 현재위치 상품수 가져오기
function cmdGetCountResult(param){
	var new_param = getBeforeParamCheck(param);
	if (new_param && new_param!=""){
		var url = "/tour2012/GetCount.jsp";
		var param = "rtype=count&" + new_param + "&selectDetailView=" + selectDetailView;
		var getRec = new Ajax.Request(
			url,
			{
				method:'get',parameters:param,onComplete:inputGetCountResult
			}
		);
	}
}
//기본조건 선택결과 현재위치에 상품수 표시
function inputGetCountResult(originalRequest){
	eval("arrReturn = " + originalRequest.responseText);
	if (eval("arrReturn")){
		var cnt = eval("arrReturn.count");
		var gcnt = eval("arrReturn.groupcount");
		if(cnt == 0){
			$("resultmap_getcntline").style.display = "none";
			$("resultmap_gettextline").style.display = "block";
			//searchButtonView('F');
		}else{
			$("resultmap_getcnt").innerHTML = (cnt.length>3) ? (cnt.substring(0,cnt.length-3)+","+cnt.substring(cnt.length-3)) : cnt;
			$("resultmap_getgroupcnt").innerHTML = (gcnt.length>3) ? (gcnt.substring(0,gcnt.length-3)+","+gcnt.substring(gcnt.length-3)) : gcnt;
			var selectDetailView = eval("arrReturn.selectDetailView");
			$("resultmap_gettextline").style.display = "none";
			$("resultmap_getcntline").style.display = "block";
			if(isSearchBtnClick){
				//searchButtonView('F');
				isSearchBtnClick = false;
			}else{
				//searchButtonView('T');
			}
		}
	}
}
//메인화면 기본조건 선택마다 현재위치 상품수 가져오기
function cmdMainGetCountResult(param){
	var new_param = getBeforeParamCheck(param);
	if (new_param && new_param!=""){
		var url = "/tour2012/GetCount.jsp";
		var param = "rtype=count&" + new_param + "&selectDetailView=" + selectDetailView;
		var getRec = new Ajax.Request(
			url,
			{
				method:'get',parameters:param,onComplete:inputMainGetCountResult
			}
		);
	}else{
		$("main_resultmap_getcntline").style.display = "none";
		$("main_resultmap_gettextline").style.display = "none";
		//searchMainButtonView('F');
	}
}
//메인화면 기본조건 선택결과 현재위치에 상품수 표시
function inputMainGetCountResult(originalRequest){
	eval("arrReturn = " + originalRequest.responseText);
	if (eval("arrReturn")){
		var cnt = eval("arrReturn.count");
		var gcnt = eval("arrReturn.groupcount");
		$("main_resultmap_getcnt").innerHTML = (cnt.length>3) ? (cnt.substring(0,cnt.length-3)+","+cnt.substring(cnt.length-3)) : cnt;
		$("main_resultmap_getgroupcnt").innerHTML = (gcnt.length>3) ? (gcnt.substring(0,gcnt.length-3)+","+gcnt.substring(gcnt.length-3)) : gcnt;
		var selectDetailView = eval("arrReturn.selectDetailView");
		if(cnt==0){
			$("main_resultmap_getcntline").style.display = "none";
			$("main_resultmap_gettextline").style.display = "block";
			//searchMainButtonView('F');
		}else{
			$("main_resultmap_gettextline").style.display = "none";
			$("main_resultmap_getcntline").style.display = "block";
			searchMainButtonView('T');
		}
	}
}
function getTimeSearchCnt(){
	var searchParameter = makeSearchParameter();
	var url = "/tour2012/GetCountTimeSearchCnt.jsp";
	var param = searchParameter + "&stimetype=" + document.frmTravel.stimetype.value + "&stime=" + document.frmTravel.stime.value+"&sstep=3";
	//alert(param);
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:inputTimeSearchCnt
		}
	);
}
function inputTimeSearchCnt(originalRequest){
	eval("arrReturn = " + originalRequest.responseText);
	var cnt = parseInt(arrReturn.cnt,10);
	var stimecnt = parseInt(arrReturn.stimecnt,10);
	var etimecnt = parseInt(arrReturn.etimecnt,10);
	var strInfo = $("travel_detail2_info").innerHTML;
	strInfo = strInfo.substring(0, strInfo.indexOf("했습니다.")+5);
	if (etimecnt==5){
		$("travel_detail2_info").innerHTML = strInfo + " <span style='margin-left:100;'>=> <span style='background-color:red;color:white;padding:1 1 0 0;margin-top:-1;height:10;'>" + cnt + "</span>개 검색</span>";
	}else{
		$("travel_detail2_info").innerHTML = strInfo + " <span style=''>=> <span style='background-color:red;color:white;padding:1 1 0 0;margin-top:-1;height:10;'>" + cnt + "</span>개 검색</span>";
	}
}
function openTourGuide(){
	var win = window.open("/tour2012/Tour_PopGuide.jsp","TourPopGuide","width=850,height=580,left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=no,resizable=no,menubar=no");
	win.focus();
}
function syncHeightTravelFrame(el){
	try{
		//$("travelListFrame").style.height = $("travelListFrame").contentWindow.document.body.scrollHeight + "px";
		$("travelListFrame").style.height = "auto";
		contentHeight = $("travelListFrame").contentWindow.document.body.scrollHeight;
		$("travelListFrame").style.height = contentHeight + 4 + "px";

   	}catch(e){}
}
function syncHeightListFrame(){
	setTimeout("syncHeightTravelFrame()",1000);
}
function cmdRemoveSpchar(param){
	var schWrdExp = param;
	schWrdExp = replaceSpchar(schWrdExp, "'");		
	schWrdExp = replaceSpchar(schWrdExp, "\"");	
    schWrdExp = replaceSpchar(schWrdExp, "~");
    schWrdExp = replaceSpchar(schWrdExp, "!");
    schWrdExp = replaceSpchar(schWrdExp, "@");
    schWrdExp = replaceSpchar(schWrdExp, "#");
    schWrdExp = replaceSpchar(schWrdExp, "$");
    schWrdExp = replaceSpchar(schWrdExp, "%");
    schWrdExp = replaceSpchar(schWrdExp, "^");
    schWrdExp = replaceSpchar(schWrdExp, "&");        
    schWrdExp = replaceSpchar(schWrdExp, "*");
    schWrdExp = replaceSpchar(schWrdExp, "+");
    schWrdExp = replaceSpchar(schWrdExp, "=");
    schWrdExp = replaceSpchar(schWrdExp, "\\");
    schWrdExp = replaceSpchar(schWrdExp, "{");
    schWrdExp = replaceSpchar(schWrdExp, "}");
    schWrdExp = replaceSpchar(schWrdExp, "[");
    schWrdExp = replaceSpchar(schWrdExp, "]");
    schWrdExp = replaceSpchar(schWrdExp, ":");
    schWrdExp = replaceSpchar(schWrdExp, ";");
    schWrdExp = replaceSpchar(schWrdExp, "/");
    schWrdExp = replaceSpchar(schWrdExp, "<");
    schWrdExp = replaceSpchar(schWrdExp, ">");
    schWrdExp = replaceSpchar(schWrdExp, "."); 
    schWrdExp = replaceSpchar(schWrdExp, "?");
    schWrdExp = replaceSpchar(schWrdExp, "(");
    schWrdExp = replaceSpchar(schWrdExp, ")");
    schWrdExp = replaceSpchar(schWrdExp, "'");
    schWrdExp = replaceSpchar(schWrdExp, "_");
    schWrdExp = replaceSpchar(schWrdExp, "-");
    schWrdExp = replaceSpchar(schWrdExp, "`");
    schWrdExp = replaceSpchar(schWrdExp, "|");
    schWrdExp = schWrdExp.trim();
	schWrdExp = schWrdExp.replace(","," ");
	
	if (schWrdExp.length>0){
		var arrWrd = schWrdExp.split(" ");
		if (arrWrd.length>0){
			schWrdExp = "";
			for (i=0; i<arrWrd.length; i++){
				if (arrWrd[i].trim()!=""){
					if (schWrdExp.length>0) schWrdExp += " ";
					schWrdExp += arrWrd[i].trim();
				}
			}
		}
	}

	var schLen = schWrdExp.length;	
	var varExpKeyWord = "";

	if(schLen < 2){
		if (schLen == 1 && varExpKeyWord.indexOf(schWrdExp) >= 0 ){
			return schWrdExp;
		}else{
			alert("2자 이상의 검색어를 넣으세요.\t\t\r\n\특수문자는 제외 됩니다.");
			return false;
		}
	}else{
		return schWrdExp;
	}
}
function replaceSpchar(src, delWrd){
	var newSrc = "";
	var i;
	for(i=0; i<src.length; i++){
		if(src.charAt(i) != delWrd) {
			newSrc = newSrc + src.charAt(i);
		}			
	}
	return newSrc;
}
function getBeforeParamCheck(param){
	var sidx;
	var eidx;
	if (param){ //출발일 범위지정일때는 두개일자 선택했을때만 호출
		if (param.indexOf("sstartmaxafter=")>0){ //4개월이후
		
		}else{
			if (param.indexOf("sstart=")>0){
			
			}else{
				param = "";
			}
		}
	}
	if (param){
		if (param.indexOf("subject=")>=0){ //주제어 체크
			sidx = param.indexOf("subject=")+8;
			eidx = param.indexOf("&",sidx);
			var subject = param.substring(sidx,eidx);
			if (subject==""){
				param = "";
			}else{
				subject = cmdRemoveSpchar(subject); //특수문자제외
				if (!subject){
					return;
				}
				$("txt_subject").value = subject;
				if (subject!="" && subject.length>1){
					param = param.substring(0,sidx) + subject + param.substring(eidx);
				}else{
					param = "";
				}
			}
		}else{ //지역선택
			if (param.indexOf("&varea=")>=0 && param.indexOf("&sarea=")>=0){
				sidx = param.indexOf("&varea=")+7;
				eidx = param.indexOf("&",sidx);
				var area = param.substring(sidx,eidx);
				if (area==""){
					param = "";
				}
			}else{
				param = "";
			}
		}
	}
	return param;
}
function cmdTravelDetailTab(tab){
	for(var i=1;i<8;i++){
		$("img_travel_detail_tab"+i).src = $("img_travel_detail_tab"+i).src.replace("tour_btab_0"+i+"_on.gif","tour_btab_0"+i+".gif");
	}
	$("img_travel_detail_tab"+tab).src = $("img_travel_detail_tab"+tab).src.replace("tour_btab_0"+tab+".gif","tour_btab_0"+tab+"_on.gif");
	selectDetailView = tab;

	for(var k=1;k<8;k++){
		$("div_detail_layer_"+k).style.display = "none";
	}
	$("div_detail_layer_"+tab).style.display="block";
	var selectedSubject = document.getElementById("txt_subject").value;
	if(  (selectedSubject.length > 0 || arrSelectedArea.length > 0 )  && (strSelectMaxDayAfter!="" || (varStartDateType=="D" && arrSelectedDate.length>0) || (varStartDateType=="T" && strSelectedFromDate!="" && strSelectedToDate!="")) ){
		
	}else{
		$("resultmap_gettextline").style.display = "none";
		$("resultmap_getcntline").style.display = "none";
	}
	//$("div_go_search_default").style.display = "none";
	//$("div_go_search").style.display = "none";
	showGoBtn0();
}

function remove_gobutton(){
	//$("div_go_search_default").style.display = "none";
	//$("div_go_search").style.display = "none";	
}

/* 예약상태 원래대로 */
function resetAppointFlag(){
	var obj = document.frmTravel;
	obj.sappoint.value = obj.sappoint.defaultValue;
	var sappoint = obj.sappoint.value;
	if (sappoint==""){
		$("img_travel_detail1_all").style.backgroundImage = $("img_travel_detail1_all").style.backgroundImage.replace("all.gif","all_ov.gif");
		$("img_travel_detail1_1").src = $("img_travel_detail1_1").src.replace("1_ov.gif", "1.gif");
		$("img_travel_detail1_2").src = $("img_travel_detail1_2").src.replace("2_ov.gif", "2.gif");
		$("img_travel_detail1_3").src = $("img_travel_detail1_3").src.replace("3_ov.gif", "3.gif");
	}else{
		$("img_travel_detail1_all").style.backgroundImage = $("img_travel_detail1_all").style.backgroundImage.replace("all_ov.gif","all.gif");
		for (i=1; i<=3; i++){
			if (sappoint.indexOf(i)>=0){
				$("img_travel_detail1_"+i).src = $("img_travel_detail1_"+i).src.replace(i+".gif", i+"_ov.gif");
			}else{
				$("img_travel_detail1_"+i).src = $("img_travel_detail1_"+i).src.replace("_ov.gif", ".gif");
			}
		}
	}
}
/* 항공시간 선택 원래대로 */
function resetTravelTime(){
	var hm, hmbox1, hmbox2;
	var obj = document.frmTravel;
	obj.stimetype.value = obj.stimetype.defaultValue;
	obj.stime.value = obj.stime.defaultValue;
	var stimetype = obj.stimetype.value;
	var stime = obj.stime.value;
	var existtimes = obj.existtimes.value;
	$("travel_detail2_info").innerHTML = strStartTimeInfo;

	if (stimetype=="" || stimetype=="B"){
		if (stime==""){ //모든시간대
			$("img_travel_detail2_all").style.backgroundImage = $("img_travel_detail2_all").style.backgroundImage.replace("all.gif","all_ov.gif");
			removeTimeBgImg();
			obj.stimetype.value = "";
		}else{
			for (i=0; i<6; i++){
				if (i==0){
					hm = "0004";
				}else if (i==1){
					hm = "0408";
				}else if (i==2){
					hm = "0812";
				}else if (i==3){
					hm = "1216";
				}else if (i==4){
					hm = "1620";
				}else if (i==5){
					hm = "2024";
				}
				
				if ($("detail_time_0_"+i).innerHTML.indexOf("gae.gif")<0){
					$("detail_time_0_"+i).className = "detail_timebox_empty";
				}else{
					if (stime.indexOf("S"+hm)>=0){
						$("detail_time_0_"+i).className = "detail_timebox_circle";
					}else{
						$("detail_time_0_"+i).className = "detail_timebox";
					}
				}
			}
			for (i=0; i<6; i++){
				if (i==0){
					hm = "0004";
				}else if (i==1){
					hm = "0408";
				}else if (i==2){
					hm = "0812";
				}else if (i==3){
					hm = "1216";
				}else if (i==4){
					hm = "1620";
				}else if (i==5){
					hm = "2024";
				}
				
				if ($("detail_time_1_"+i).innerHTML.indexOf("gae.gif")<0){
					$("detail_time_1_"+i).className = "detail_timebox_empty";
				}else{
					if (stime.indexOf("E"+hm)>=0){
						$("detail_time_1_"+i).className = "detail_timebox_circle";
					}else{
						$("detail_time_1_"+i).className = "detail_timebox";
					}
				}
			}
		}
		$("travel_detail2_1").selectedIndex = 0;
		$("travel_detail2_2").selectedIndex = 0;
		$("travel_detail2_3start").checked = true;
		$("travel_detail2_3end").checked = false;
		$("img_travel_detail2_select").src = $("img_travel_detail2_select").src.replace("time_direct_bt_ov.gif","time_direct.gif");
	}else{
		$("img_travel_detail2_all").style.backgroundImage = $("img_travel_detail2_all").style.backgroundImage.replace("all_ov.gif","all.gif");
		$("img_travel_detail2_select").src = $("img_travel_detail2_select").src.replace("time_direct.gif","time_direct_bt_ov.gif");

		if (stime!=""){
			if (stime.substring(0,1)=="S"){
				$("travel_detail2_3start").checked = true;
				$("travel_detail2_3end").checked = false;
			}else if (stime.substring(0,1)=="E"){
				$("travel_detail2_3start").checked = false;
				$("travel_detail2_3end").checked = true;
			}
			for (i=0; i<24; i++){
				if (i==parseInt(stime.substring(1,3),10)){
					$("travel_detail2_1").selectedIndex = i;
				}
				if (i==parseInt(stime.substring(3,5),10)){
					$("travel_detail2_2").selectedIndex = i;
				}
			}
		}
	}
}
/* 항공시간 모두선택 상태로 */
function resetTimeBgImg(){

}
/* 항공시간 선택 이미지 제거 */
function removeTimeBgImg(){
	$("ExistTimes0").src = IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_65.gif";
	for(var i=1;i<13;i++){
		if($("ExistTimes"+i)){
			$("ExistTimes"+i).src = IMG_ENURI_COM+"/images/view/travel/2012/btn/tourbtn_6020.gif";
		}
	}
	
}
/* 가격대 원래대로 */
function resetTravelPrice(){
	var obj = document.frmTravel;
	var spricef = obj.spricef.value;
	var spricet = obj.spricet.value;
	if(navigator.appName!="Netscape"){
		if (spricef==0 && spricet==0){
			$("travel_detail3_min").value = intTravelMinPrice;
			$("travel_detail3_max").value = intTravelMaxPrice;
		}else{
			$("travel_detail3_min").value = $("travel_detail3_min").defaultValue;
			$("travel_detail3_max").value = $("travel_detail3_max").defaultValue;
		}
	}
}
/* 여행사 선택 */
function cmdFactoryDetail4Click(idx){
	if(idx == 'all'){
		if($("detail_factorycnt_all").style.textDecoration == ''){
			$("detail_factorycnt_all").style.textDecoration = "underline";
		}else{
			$("detail_factorycnt_all").style.textDecoration = "";
		} 
	}else{
		if($("detail_factorycnt_"+idx).style.textDecoration == ''){
			$("detail_factorycnt_"+idx).style.textDecoration = "underline";
		}else{
			$("detail_factorycnt_"+idx).style.textDecoration = "";
		} 
	}
	var obj = document.frmTravel;
	var sfactory = obj.sfactory.value; //현재목록 검색조건 여행사
	var sfactorynum = obj.sfactorynum.value; //현재목록 검색조건 여행사

	if (idx=="all"){ //전체여행사 선택
		for(var i=0;i<20; i++){
			if($("detail_factoryname_"+i)){
				$("detail_factoryname_"+i).checked = false;
				$("detail_factorycnt_"+i).style.textDecoration = "";
			}
		}
		sfactory = "";
		sfactorynum = "";
	}else{ //특정여행사 선택
		$("detail_factoryname_all").checked = false;
		$("detail_factorycnt_all").style.textDecoration = "";
		var clickFactoryName = $("detail_factorycnt_"+idx).innerHTML; //클릭한 여행사명
		clickFactoryName = clickFactoryName.toLowerCase();
		clickFactoryName = clickFactoryName.substring(0,clickFactoryName.indexOf("<font"));
		clickFactoryName = clickFactoryName.toUpperCase();
		if (sfactory.indexOf(clickFactoryName)>=0){ //선택된 여행사 다시 클릭
			sfactory = sfactory.replace(","+clickFactoryName,"");
			sfactory = sfactory.replace(clickFactoryName+",","");
			sfactory = sfactory.replace(clickFactoryName,"");
			sfactorynum = sfactorynum.replace(","+idx,"");
			sfactorynum = sfactorynum.replace(idx+",","");
			sfactorynum = sfactorynum.replace(idx,"");
		}else{ //선택안된 여행사 선택
			if (sfactory.indexOf(clickFactoryName)<0){
				if (sfactory!="") sfactory += ",";
				sfactory += clickFactoryName;
				//여행 num 저장
				if (sfactorynum!="") sfactorynum += ",";
				sfactorynum += idx;
			}
		}
	}
	var arrchkFactory = sfactory.split(","); 
	var arrchkFactoryNum = sfactorynum.split(","); 
	if(arrchkFactory.length >3){
		//레이어를  띄우고
		if(div_tour_factory_3_flag){
			$("div_tour_factory_3").style.display = "block";
			div_tour_factory_3_flag = false;
		}
		//맨앞에 있는것을 삭제 하고
		sfactory = "";
		for(var n=1;n<arrchkFactory.length;n++){
			if(sfactory!="") sfactory += ",";
			sfactory += arrchkFactory[n]; 
		}
		sfactorynum = "";
		for(var k=1;k<arrchkFactoryNum.length;k++){
			if(sfactorynum!="") sfactorynum += ",";
			sfactorynum += arrchkFactoryNum[k]; 
		}
		$("detail_factoryname_"+arrchkFactoryNum[0]).checked = false;
		$("detail_factorycnt_"+arrchkFactoryNum[0]).style.textDecoration = "";
		
	}
	obj.sfactory.value = sfactory;
	obj.sfactorynum.value = sfactorynum;
	//chkGoViewBtn();
	var param = makeSearchParameter() + detailSearchParameter();
	cmdGetCountResult(param);
}
/* 항공사 선택 */
function cmdAirDetail4Click(idx){
	if(idx == 'all'){
		if($("detail_aircnt_all").style.textDecoration == ''){
			$("detail_aircnt_all").style.textDecoration = "underline";
		}else{
			$("detail_aircnt_all").style.textDecoration = "";
		} 
	}else{
		if($("detail_aircnt_"+idx).style.textDecoration == ''){
			$("detail_aircnt_"+idx).style.textDecoration = "underline";
		}else{
			$("detail_aircnt_"+idx).style.textDecoration = "";
		} 
	}
	var obj = document.frmTravel;
	var sairline = obj.sairline.value; //현재목록 검색조건 항공사
	var sairlinestr = obj.sairlinestr.value; //현재목록 검색조건 항공사
	var sairlinenum = obj.sairlinenum.value; //현재목록 검색조건 항공사 num

	if (idx=="all"){ //전체항공사 선택
		for(var i=0;i<20; i++){
			if($("detail_airname_"+i)){
				$("detail_airname_"+i).checked = false;
				$("detail_aircnt_"+i).style.textDecoration = "";
			}
		}
		sairline = "";
		sairlinestr = "";
		sairlinenum = "";
	}else{ //특정항공사 선택
		$("detail_airname_all").checked = false;
		$("detail_aircnt_all").style.textDecoration = "";
		var clickAirCode = $("code"+idx).innerHTML; //클릭한 항공사코드
		var clickAirName = $("detail_aircnt_"+idx).innerHTML; //클릭한 여행사명
		clickAirName = clickAirName.toLowerCase();
		clickAirName = clickAirName.substring(0,clickAirName.indexOf("<font"));
		if (sairline.indexOf(clickAirCode)>=0){ //선택된 항공사 다시 클릭
			sairline = sairline.replace(","+clickAirCode,"");
			sairline = sairline.replace(clickAirCode+",","");
			sairline = sairline.replace(clickAirCode,"");
			
			sairlinestr = sairlinestr.replace(","+clickAirName,"");
			sairlinestr = sairlinestr.replace(clickAirName+",","");
			sairlinestr = sairlinestr.replace(clickAirName,"");
			
			sairlinenum = sairlinenum.replace(","+idx,"");
			sairlinenum = sairlinenum.replace(idx+",","");
			sairlinenum = sairlinenum.replace(idx,"");
			
			
		}else{ //선택안된 항공사 선택
			if (sairline.indexOf(clickAirCode)<0){
				if (sairline!="") sairline += ",";
				sairline += clickAirCode;
				
				if (sairlinestr!="") sairlinestr += ",";
				sairlinestr += clickAirName;
				
				if (sairlinenum!="") sairlinenum += ",";
				sairlinenum += idx;
			}
		}
	}
	var arrchkSairLine = sairline.split(","); 
	var arrchkSairLineStr = sairlinestr.split(","); 
	var arrchkSairLineNum = sairlinenum.split(",");
	if(arrchkSairLine.length >3){
		//레이어를  띄우고
		if(div_tour_air_3_flag){
			$("div_tour_air_3").style.display = "block";
			div_tour_air_3_flag = false;
		}
		//맨앞에 있는것을 삭제 하고
		sairline = "";
		for(var n=1;n<arrchkSairLine.length;n++){
			if(sairline!="") sairline += ",";
			sairline += arrchkSairLine[n]; 
		}
		
		sairlinestr = "";
		for(var k=1;k<arrchkSairLineStr.length;k++){
			if(sairlinestr!="") sairlinestr += ",";
			sairlinestr += arrchkSairLineStr[k]; 
		}
		
		sairlinenum = "";
		for(var l=1;l<arrchkSairLineNum.length;l++){
			if(sairlinenum!="") sairlinenum += ",";
			sairlinenum += arrchkSairLineNum[l]; 
		}
		$("detail_airname_"+arrchkSairLineNum[0]).checked = false;
		$("detail_aircnt_"+arrchkSairLineNum[0]).style.textDecoration = "";
	}
	obj.sairline.value = sairline;
	obj.sairlinestr.value = sairlinestr;
	obj.sairlinenum.value = sairlinenum;
	//chkGoViewBtn();
	var param = makeSearchParameter() + detailSearchParameter();
	cmdGetCountResult(param);
}
function cmdUnloadErrorBox(){
	if ($("singoChk").value=="singo_goods"){
		cmdHideErrorBox();
	}
	cmdHideTourTrouble();
}
function cmdHideErrorBox(){
	var obj = document.getElementById("div_inconv");
	obj.innerHTML = "";
	obj.style.display = "none";
}
function cmdHideTourTrouble(){
	var obj = $("divTourTroubleLayer");
	obj.innerHTML = "";
	obj.style.display = "none";
}
function cmdTravelGuide(){
	CmdLink("/tour2012/Tour_Guide_Airline1.jsp");
}
// 꼭챙기세요 연결 URL
function tourLink(varNo){
	var new_tourLink = ""
	if(varNo ==1){
		new_tourLink = window.open("/view/fusion/Fusion.jsp?cate=145504&factory=&in_keyword=",'_blank');
	}else if(varNo ==2){
		new_tourLink = window.open("/view/Listmp3.jsp?cate=09210301",'_blank');
	}else if(varNo ==3){
		new_tourLink = window.open("/view/fusion/Fusion.jsp?cate=14570697&factory=&in_keyword=",'_blank');
	}else if(varNo ==4){
		new_tourLink = window.open("/view/fusion/Fusion.jsp?cate=14560304&factory=&in_keyword=",'_blank');
	}else if(varNo ==5){
		new_tourLink = window.open("/view/fusion/Fusion.jsp?cate=14571301&factory=&in_keyword=",'_blank');
	}else if(varNo ==6){
		new_tourLink = window.open("/view/Listmp3.jsp?cate=16350601",'_blank');
	}
}
function CmdPopLink(url){
	var w = window.screen.width;
	var h = screen.availHeight;
	var win = window.open(url,"_blank");
	win.focus();
}

function tour_main_taps(varMenu){
	if(varMenu != 6){
		CmdLink('/tour2012/Tour_Index.jsp?skind='+varMenu);
	}else{
		CmdLink('/tour2012/Jeju_Tour.jsp');
	}
}
function movetoeventbbs(){
	insertLog(7946);
	var new_tourLink = window.open("/event/EventTourAll.jsp","new_tourLink","toolbar=yes,menubar=yes,statusbar=yes,location=yes,scrollbars=yes,resizable=yes,width=1024,height=600 top=15,left=15");
}

//Max팝업창 띄우기(임시)
function openMaxWin(url){
	var w = window.screen.width;
	var h = screen.availHeight ;		
	//k = window.open (url,"","width="+w+" height="+h+" top=0 left=0 toolbar=yes,location=yes,directories=yes,status=yes,scrollbars=yes,resizable=yes,menubar=yes,personalbar=yes");
	k = window.open (url,"_blank");
	k.focus();		
	return false;
}


function openZzimListGo(){
	var win = window.open("/tour2012/Tour_PopGuide.jsp","TourPopGuide","width=850,height=580,left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=no,resizable=no,menubar=no");
	window.open('tour_user_choice_list.jsp','SmallWindow','width=890px,height=500px,scrollbars=yes,location=no,status=no,resizable=yes,toolbar=no,menubar=no');
	win.focus();
}