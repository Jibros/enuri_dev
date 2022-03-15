var varidx = 1;
var IMG_ENURI_COM = "http://img.enuri.info";

function flagImgSearching(f){ //화면 로딩중 표시 이미지 : 플래시에서도 호출
	/*
	if (f==0 && $("div_travel_searching")){
		$("div_travel_searching").style.display = "none";
	}else if (f==1 && $("div_travel_searching")){
		$("div_travel_searching").style.display = "block";
	}
	*/
}
function touronload(){
	var varSearchFlashLeft = Position.cumulativeOffset(document.getElementById("div_searchflash"))[0];
	var varSearchFlashTop = Position.cumulativeOffset(document.getElementById("div_searchflash"))[1];
	// 처음 비행기 버튼
	var div_go_search_default = document.getElementById("div_go_search_default")
	div_go_search_default.style.left = Position.cumulativeOffset($("div_searchflash"))[0]-varSearchFlashLeft+373+"px";
	div_go_search_default.style.top = Position.cumulativeOffset($("div_searchflash"))[1]+290+"px";
	document.getElementById("div_go_search_default").style.display = "";
	// 지역, 날짜, 선택후 비행기 이미지
	// div_go_search
	var div_go_search = document.getElementById("div_go_search");
	div_go_search.style.left =Position.cumulativeOffset($("div_searchflash"))[0]-varSearchFlashLeft+373+"px";
	div_go_search.style.top = Position.cumulativeOffset($("div_searchflash"))[1]+289+"px";
	var div_img_check_msg = document.getElementById("img_check_msg");
	div_img_check_msg.style.left = Position.cumulativeOffset($("div_searchflash"))[0]-varSearchFlashLeft+445+"px";
	div_img_check_msg.style.top = Position.cumulativeOffset($("div_searchflash"))[1]+250+"px";
	
	//document.getElementById("IFrameMyFavoriteList").contentWindow.location.reload();
	top.viewTodayView();
}
function flagImgMonthlySearching(f){ //월별 최저가 로딩중 표시 이미지
	if (f==0 && $("div_travelmainarea_searching")){
		$("div_travelmainarea_searching").style.display = "none";
	}else if (f==1 && $("div_travelmainarea_searching")){
		$("div_travelmainarea_searching").style.display = "block";
	}
}
function init() {
	$("div_tour_right_top").style.display = "block";
	//document.frames["IFrameMyFavoriteList"].location.reload();
	top.viewTodayView();
	//varTourTopBannerTimer = setTimeout("tourTopChangeBanner()",iTourTopBannerTm);
}
function showEventBanner(bannerIdx){
	var varEventCnt = 6;
	if(bannerIdx){
		showEventBanner._idx = bannerIdx
	}
	for (var event_i=1;event_i<=varEventCnt;event_i++){
		if (document.getElementById("img_event_order_"+event_i)){
			if (event_i == showEventBanner._idx){

				document.getElementById("img_event_order_"+event_i).src = IMG_ENURI_COM + "/images/event/banner/"+event_i+"_on.gif";
			}else{
				document.getElementById("img_event_order_"+event_i).src = IMG_ENURI_COM + "/images/event/banner/"+event_i+".gif";		
			}
		}
	}
}
function cmdUrgentGoods(pageNum){
	$("travel_mainurgency").innerHTML = "";
	var url = "/tour/Inc_Main_Urgency.jsp";
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
function inputMonthlyGoods(originalRequest){
	$("travel_mainlist_"+varidx).innerHTML = originalRequest.responseText;
	//viewTravelMainlist(idx);
}
function viewTravelMainlist(idx){
	//flagImgMonthlySearching(0);
}
function cmdFadeSearchingBox(){
	$("div_travel_searching").style.display = "none";
}
function godirecttour(shopCode){
	var newWin = window.open("/tour/Direct_Tour.jsp?shop_code="+shopCode);
	newWin.focus();
}
function movetoeventbbs(){
	insertLog(5855);
	var win = window.open("/event/Event_Guide_Travel.jsp");
	win.focus();
}
function fnClose(){
	$("wndCategoryPopup").style.display = "none";
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
		var url = "/tour/Inc_Main_ManageTravels.jsp";
		var param = "continent=A"+idx;
		var getRec = new Ajax.Request(
			url,
			{
				method:'get',parameters:param,onComplete:inputMonthlyGoods
			}
		);
	}else{
		//viewTravelMainlist(idx);
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
function logInsert(kind){
	var url = "/view/Loginsert.jsp";
	var param = "kind="+kind;
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param
		}
	);
}
function resizeObj(objId, w, h){
	if (document.getElementById(objId)){
		document.getElementById(objId).style.width = w;
		document.getElementById(objId).style.height = h;
	}
}

function openTourGuide(){
	insertLog(1506);
	var win = window.open("/tour/Tour_PopGuide.jsp","TourPopGuide","width=755,height=580,left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=no,resizable=no,menubar=no");
	win.focus();
}
function openNewsAd(adno, adDate, adNewspaper, adAgency){
	var wWidth = screen.availWidth;
	var wHeight = screen.availHeight;
	if (parseInt(wWidth,10)>1024){
		wWidth = 1024;
	}
	var win = window.open("/tour/Tour_Ad.jsp?adno="+adno+"&addate="+adDate+"&adnewspaper="+adNewspaper+"&adagency="+adAgency,"TourAd","width="+wWidth+",height="+wHeight+",left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=yes,resizable=no,menubar=no");
	win.focus();
}

function cmdTravelGuide(){
	CmdLink("/tour/Tour_Guide_Airline1.jsp");
}

function cmdTravelTab(){
	if ($("div_searchflash").style.display=="none"){ //보이기

		bsShow(); //기본조건선택 플래시 떨어뜨리기

	}else{
		bsHidden(); //기본조건선택 플래시 없애기

	}
}
/* 목록 출발시간정렬시 세부내용 레이어 */
function cmdShowListDownInfo(){
	if ($("rightListDownDesc").style.display=="none"){
		$("rightAirlineDesc").style.display = "none";
		$("rightListDownDesc").style.display = "block";
	}else{
		$("rightListDownDesc").style.display = "none";
	}
}
/* 항공사 로고 사전 */
function cmdShowAirline(){
	if ($("rightAirlineDesc").style.display=="none"){
		$("rightListDownDesc").style.display = "none";
		$("rightAirlineDesc").style.display = "block";
	}else{
		$("rightAirlineDesc").style.display = "none";
	}
}
function cmdHideAirline(){
	$("rightAirlineDesc").style.display = "none";
}

/* 상세조건 탭 선택 */
function cmdTravelDetailTab(tab){
	cmdSearchEmptyBalloonHide();
	if (tab || tab==0){
		var obj = $("travel_detail"+tab);
		if (obj.style.display=="none"){
			$("img_travel_detail_tab"+tab).src = $("img_travel_detail_tab"+tab).src.replace("_stab0"+tab+".gif","_stab0"+tab+"ov.gif");
		}else{
			$("img_travel_detail_tab"+tab).src = $("img_travel_detail_tab"+tab).src.replace("_stab0"+tab+"ov.gif","_stab0"+tab+".gif");
		}
		if (obj.style.display=="none"){
			obj.style.display = "block";
		}else{
			obj.style.display = "none";
		}
		resetTravelPeriod();
		resetAppointFlag();
		resetTravelTime();
		resetTravelPrice();
		resetFactory();
		resetAirline();
		

		if (tab==0){ //여행기간
			//resetAppointFlag();
			//resetTravelTime();
			//resetTravelPrice();
			//resetFactory();
			//resetAirline();
		}else if (tab==1){ //예약상태
			//resetTravelPeriod();
			//resetTravelTime();
			//resetTravelPrice();
			//resetFactory();
			//resetAirline();
		}else if (tab==2){ //항공시간
			//resetTravelPeriod();
			//resetAppointFlag();
			//resetTravelPrice();
			//resetFactory();
			//resetAirline();
		}else if (tab==3){ //가격대
			getPriceCnt();
			//resetTravelPeriod();
			//resetAppointFlag();
			//resetTravelTime();
			//resetFactory();
			//resetAirline();
		}else if (tab==4){ //여행사

			getFactoryCnt();
			getAirCnt();
			//resetTravelPeriod();
			//resetAppointFlag();
			//resetTravelTime();
			//resetTravelPrice();
		}
		for (i=0; i<5; i++){
			if (i!=tab){
				$("img_travel_detail_tab"+i).src = $("img_travel_detail_tab"+i).src.replace("_stab0"+i+"ov.gif","_stab0"+i+".gif");
				$("travel_detail"+i).style.display = "none";
				$("img_travel_detail"+i+"_go").style.display = "none";
				$("img_travel_detail"+i+"_default").style.display = "block";
			}
		}
	}else{
		for (i=0; i<5; i++){
			$("img_travel_detail_tab"+i).src = $("img_travel_detail_tab"+i).src.replace("_stab0"+i+"ov.gif","_stab0"+i+".gif");
			$("travel_detail"+i).style.display = "none";
		}
	}
	parent.syncHeightListFrame();
}
/* 여행기간 선택 */
function cmdTravelDetail0(param){
	var obj = document.frmTravel;
	var spday = obj.spday.value;
	var exists = 0;
	var new_spday = "";
	var arrSpday = spday.split(",");
	
	if (param=="all"){ //전체기간 선택
		$("img_travel_detail0_all").style.backgroundImage = $("img_travel_detail0_all").style.backgroundImage.replace("all.gif","all_ov.gif");
		for (i=3; i<=10; i++){
			if ($("td_travel_detail0_"+i)){
				$("td_travel_detail0_"+i).className = "detail_period";
			}
		}
		new_spday = "";
	}else{ //기간선택
		$("img_travel_detail0_all").style.backgroundImage = $("img_travel_detail0_all").style.backgroundImage.replace("all_ov.gif","all.gif");
		for (i=0; i<arrSpday.length; i++){
			if (param == arrSpday[i]){
				exists = 1;
			}else{
				if (new_spday==""){
					new_spday = arrSpday[i];
				}else{
					new_spday += "," + arrSpday[i];
				}
			}
		}
		if (exists==1){ //이미 선택되어 있는 날짜면 선택해제
			$("td_travel_detail0_"+param).className = "detail_period";
			if (new_spday==""){
				$("img_travel_detail0_all").style.backgroundImage = $("img_travel_detail0_all").style.backgroundImage.replace("all.gif","all_ov.gif");
			}
		}else{
			if (new_spday==""){
				new_spday = param;
			}else{
				new_spday += "," + param;
			}
			$("td_travel_detail0_"+param).className = "detail_period_circle_ovx";
			tourBackImgOver($("td_travel_detail0_"+param));
		}
	}
	obj.spday.value = new_spday;
	cmdEffectBtnGo(0);
}
/* 예약상태 선택 */
function cmdTravelDetail1(param){
	var obj = document.frmTravel;
	var sappoint = obj.sappoint.value;
	var exists = 0;
	var new_sappoint = "";
	var arrSappoint = sappoint.split(",");

	if (param=="all"){ //전체상태 선택
		$("img_travel_detail1_all").style.backgroundImage = $("img_travel_detail1_all").style.backgroundImage.replace("all.gif","all_ov.gif");
		$("img_travel_detail1_1").src = $("img_travel_detail1_1").src.replace("_ov.gif", ".gif");
		$("img_travel_detail1_2").src = $("img_travel_detail1_2").src.replace("_ov.gif", ".gif");
		$("img_travel_detail1_3").src = $("img_travel_detail1_3").src.replace("_ov.gif", ".gif");
		new_sappoint = "";
	}else{ //특정상태 선택
		$("img_travel_detail1_all").style.backgroundImage = $("img_travel_detail1_all").style.backgroundImage.replace("all_ov.gif","all.gif");
		for (i=0; i<arrSappoint.length; i++){
			if (param == arrSappoint[i]){
				exists = 1;
			}else{
				if (new_sappoint==""){
					new_sappoint = arrSappoint[i];
				}else{
					new_sappoint += "," + arrSappoint[i];
				}
			}
		}
		if (exists==1){ //이미 선택되어 있는 상태면 선택해제
			$("img_travel_detail1_"+param).src = $("img_travel_detail1_"+param).src.replace("_ovx.gif", ".gif");
			$("img_travel_detail1_"+param).src = $("img_travel_detail1_"+param).src.replace("_ov.gif", ".gif");
			if (new_sappoint==""){
				$("img_travel_detail1_all").style.backgroundImage = $("img_travel_detail1_all").style.backgroundImage.replace("all.gif","all_ov.gif");
			}
		}else{
			if (new_sappoint==""){
				new_sappoint = param;
			}else{
				new_sappoint += "," + param;
			}
			$("img_travel_detail1_"+param).src = $("img_travel_detail1_"+param).src.replace(".gif", "_ov_ovx.gif");
		}
	}
	obj.sappoint.value = new_sappoint;
	cmdEffectBtnGo(1);
}
/* 항공시간 선택1 */
function cmdTravelDetail2Click(startend, idx){
	var hm, hmbox1, hmbox2;
	var obj = document.frmTravel;
	var stime = obj.stime.value;
	var existtimes = obj.existtimes.value;
	$("travel_detail2_1").selectedIndex = 0;
	$("travel_detail2_2").selectedIndex = 0;
	if (startend=="all"){ //모든시간대
		$("img_travel_detail2_all").style.backgroundImage = $("img_travel_detail2_all").style.backgroundImage.replace("all.gif","all_ov.gif");
		removeTimeBgImg();
		obj.stimetype.value = "";
		obj.stime.value = "";
	}else{
		if (idx==0){
			hm = "0004";
		}else if (idx==1){
			hm = "0408";
		}else if (idx==2){
			hm = "0812";
		}else if (idx==3){
			hm = "1216";
		}else if (idx==4){
			hm = "1620";
		}else if (idx==5){
			hm = "2024";
		}
		if (startend=="start"){
			if ($("detail_time_0_"+idx).innerHTML.indexOf("gae.gif")<0){
				return false;
			}
			hm = "S" + hm;
		}else if (startend=="end"){
			if ($("detail_time_1_"+idx).innerHTML.indexOf("gae.gif")<0){
				return false;
			}
			hm = "E" + hm;
		}
		if (obj.stimetype.value=="T" || stime==""){ //전체시간대에서 또는 직접입력에서 선택
			stime = hm;
			if (startend=="start"){
				$("detail_time_0_"+idx).className = "detail_timebox_circle_ovx";
			}else if (startend=="end"){
				$("detail_time_1_"+idx).className = "detail_timebox_circle_ovx";
			}
		}else if (obj.stimetype.value!="T" && stime.indexOf(hm)>=0){ //이미 선택되어 있는 상태에서 선택해제
			stime = stime.replace(","+hm,"");
			stime = stime.replace(hm+",","");
			stime = stime.replace(hm,"");
			if (startend=="start"){
				$("detail_time_0_"+idx).className = "detail_timebox";
			}else if (startend=="end"){
				$("detail_time_1_"+idx).className = "detail_timebox";
			}
		}else{ //추가선택
			stime += "," + hm;
			if (startend=="start"){
				$("detail_time_0_"+idx).className = "detail_timebox_circle_ovx";
			}else if (startend=="end"){
				$("detail_time_1_"+idx).className = "detail_timebox_circle_ovx";
			}
		}
		$("img_travel_detail2_all").style.backgroundImage = $("img_travel_detail2_all").style.backgroundImage.replace("all_ov.gif","all.gif");
		if (stime==""){ //아무것도 선택 안된 상태이면 전체시간대로 변경

			$("img_travel_detail2_all").style.backgroundImage = $("img_travel_detail2_all").style.backgroundImage.replace("all.gif","all_ov.gif");
			removeTimeBgImg();
		}
		obj.stime.value = stime;
		obj.stimetype.value = "B";
	}
	$("travel_detail2_3start").checked = true;
	$("travel_detail2_3end").checked = false;
	$("img_travel_detail2_select").src = $("img_travel_detail2_select").src.replace("time_direct_bt_ov.gif","time_direct.gif");
	cmdTravelDetail2Info();
	cmdTravelDetail2SelectShow(false);
	cmdEffectBtnGo(2);
	getTimeSearchCnt();
}
/* 항공시간 선택2 : 직접입력 */
function cmdTravelDetail2Select(){
	$("img_travel_detail2_all").style.backgroundImage = $("img_travel_detail2_all").style.backgroundImage.replace("all_ov.gif","all.gif");
	$("img_travel_detail2_select").src = $("img_travel_detail2_select").src.replace("time_direct.gif","time_direct_bt_ov.gif");
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
	removeTimeBgImg();
	cmdTravelDetail2Info();
	cmdEffectBtnGo(2);
	getTimeSearchCnt();
}
/* 항공시간 직접입력 보이기 */
function cmdTravelDetail2SelectShow(flag){
	var stimetype = document.frmTravel.stimetype.value;
	var src = $("img_travel_detail2_select").src;
	if (flag){ //보이기

		$("img_travel_detail2_selectdot").style.display = "inline";
		$("tbl_travel_detail2_select").style.display = "block";
		$("img_travel_detail2_select").style.cursor = "default";
		if (stimetype=="T"){
			src = src.replace("time_direct.gif","time_direct_bt_ov.gif");
			src = src.replace("time_direct_bt.gif","time_direct_bt_ov.gif");
			$("img_travel_detail2_select").src = src;
		}else{
			src = src.replace("time_direct_bt_ov.gif","time_direct.gif");
			src = src.replace("time_direct_bt.gif","time_direct.gif");
			$("img_travel_detail2_select").src = src;
		}
	}else{ //감추기

		$("img_travel_detail2_selectdot").style.display = "none";
		$("tbl_travel_detail2_select").style.display = "none";
		$("img_travel_detail2_select").style.cursor = "pointer";
		src = src.replace("time_direct.gif","time_direct_bt.gif");
		src = src.replace("time_direct_bt_ov.gif","time_direct_bt.gif");
		$("img_travel_detail2_select").src = src;
	}
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
function cmdTravelDetail4Circle(oid,flg,cflag){
	if (flg){
		var oid_width = 0;
		if ($(oid)){
			oid_width = Element.getDimensions($(oid)).width;
			//$("temp").innerText = "width:"+oid_width;
			if (oid_width%10 > 0 && oid_width%10<=5){
				oid_width = parseInt(oid_width/10,10)*10 + 5;
			}else if (oid_width%10 > 5 && oid_width%10<=9){
				oid_width = parseInt(oid_width/10,10)*10 + 10;
			}
			if (oid_width<35){
				oid_width = 35;
			}
			$("p_"+oid).className = "detail_factory_circle_"+oid_width;
			if (cflag){
				tourFactoryCircleOver($("p_"+oid));
			}
		}
	}else{
		$("p_"+oid).className = "";
	}
}
/* 여행사 선택 */
function cmdTravelDetail4Click(idx){
	var obj = document.frmTravel;
	var sfactory = obj.sfactory.value; //현재목록 검색조건 여행사


	if (idx=="all"){ //전체여행사 선택
		cmdTravelDetail4Circle("td_detail_factory_all",true,false);
		for(i=0; i<30; i++){
			if ($("detail_factoryname_"+i).innerHTML=="") break;
			cmdTravelDetail4Circle("td_detail_factory_"+i,false);
		}
		sfactory = "";
	}else{ //특정여행사 선택
		var clickFactoryName = $("detail_factoryname_"+idx).innerHTML; //클릭한 여행사명
		var clickFactoryCnt = $("detail_factorycnt_"+idx).innerHTML; //클릭한 여행사의 상품갯수
		
		cmdTravelDetail4Circle("td_detail_factory_all",false);
		if (sfactory.indexOf(clickFactoryName)>=0){ //선택된 여행사 다시 클릭
			cmdTravelDetail4Circle("td_detail_factory_"+idx,false);
			sfactory = sfactory.replace(","+clickFactoryName,"");
			sfactory = sfactory.replace(clickFactoryName+",","");
			sfactory = sfactory.replace(clickFactoryName,"");
			if (sfactory==""){
				cmdTravelDetail4Circle("td_detail_factory_all",true);
			}
		}else{ //선택안된 여행사 선택
			cmdTravelDetail4Circle("td_detail_factory_"+idx,true,true);
			if (sfactory.indexOf(clickFactoryName)<0){
				if (sfactory!="") sfactory += ",";
				sfactory += clickFactoryName;
			}
		}
	}
	obj.sfactory.value = sfactory;
	cmdEffectBtnGo(4);
}
/* 항공사 선택 */
function cmdTravelDetail4AirClick(idx){
	var obj = document.frmTravel;
	var sairline = obj.sairline.value; //현재목록 검색조건 항공사


	if (idx=="all"){ //전체항공사 선택
		cmdTravelDetail4Circle("td_detail_air_all",true,false);
		for(i=0; i<80; i++){
			if ($("detail_airname_"+i).innerHTML=="") break;
			cmdTravelDetail4Circle("td_detail_air_"+i,false);
		}
		sairline = "";
	}else{ //특정항공사 선택
		var clickAirCode = $("detail_airname_"+idx).code; //클릭한 항공사코드

		var clickAirCnt = $("detail_aircnt_"+idx).innerHTML; //클릭한 항공사의 상품갯수
		
		cmdTravelDetail4Circle("td_detail_air_all",false);
		if (sairline.indexOf(clickAirCode)>=0){ //선택된 항공사 다시 클릭
			cmdTravelDetail4Circle("td_detail_air_"+idx,false);
			sairline = sairline.replace(","+clickAirCode,"");
			sairline = sairline.replace(clickAirCode+",","");
			sairline = sairline.replace(clickAirCode,"");
			if (sairline==""){
				cmdTravelDetail4Circle("td_detail_air_all",true);
			}
		}else{ //선택안된 항공사 선택
			cmdTravelDetail4Circle("td_detail_air_"+idx,true,true);
			if (sairline.indexOf(clickAirCode)<0){
				if (sairline!="") sairline += ",";
				sairline += clickAirCode;
			}
		}
	}
	obj.sairline.value = sairline;
	cmdEffectBtnGo(4);
}
/* 여행기간 모두선택 상태로 */
function resetTravelPeriod(){
	var obj = document.frmTravel;
	obj.spday.value = obj.spday.defaultValue;
	var spday = obj.spday.value;
	if (spday==""){ //전체기간 상태
		$("img_travel_detail0_all").style.backgroundImage = $("img_travel_detail0_all").style.backgroundImage.replace("all.gif","all_ov.gif");
		for (i=3; i<=10; i++){
			if ($("td_travel_detail0_"+i)){
				$("td_travel_detail0_"+i).className = "detail_period";
			}
		}
	}else{ //특정기간 선택상

		$("img_travel_detail0_all").style.backgroundImage = $("img_travel_detail0_all").style.backgroundImage.replace("all_ov.gif","all.gif");
		for (i=3; i<=10; i++){
			if (spday.indexOf(i)>=0){
				if ($("td_travel_detail0_"+i)){
					$("td_travel_detail0_"+i).className = "detail_period_circle";
				}
			}else{
				if ($("td_travel_detail0_"+i)){
					$("td_travel_detail0_"+i).className = "detail_period";
				}
			}
		}
	}
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
		removeTimeBgImg();
	}
}

/* 항공시간 모두선택 상태로 */
function resetTimeBgImg(){
	for(i=0; i<6; i++){
		if ($("detail_time_0_"+i).innerHTML.indexOf("gae.gif")<0){
			$("detail_time_0_"+i).className = "detail_timebox_empty";
		}else{
			$("detail_time_0_"+i).className = "detail_timebox_circle";		
		}
		if ($("detail_time_1_"+i).innerHTML.indexOf("gae.gif")<0){
			$("detail_time_1_"+i).className = "detail_timebox_empty";
		}else{
			$("detail_time_1_"+i).className = "detail_timebox_circle";		
		}
	}
}
/* 항공시간 선택 이미지 제거 */
function removeTimeBgImg(){
	for(i=0; i<6; i++){
		if ($("detail_time_0_"+i).innerHTML.indexOf("gae.gif")<0){
			//$("detail_time_0_"+i).className = "detail_timebox_empty";
		}else if ($("detail_time_0_"+i).className!="detail_timebox"){
			$("detail_time_0_"+i).className = "detail_timebox";		
		}
		if ($("detail_time_1_"+i).innerHTML.indexOf("gae.gif")<0){
			//$("detail_time_1_"+i).className = "detail_timebox_empty";
		}else if ($("detail_time_1_"+i).className!="detail_timebox"){
			$("detail_time_1_"+i).className = "detail_timebox";		
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

/* 여행사선택 원래대로 */
function resetFactory(){
	var obj = document.frmTravel;
	obj.sfactory.value = obj.sfactory.defaultValue;
	sfactory = obj.sfactory.value;

	for(i=0; i<30; i++){
		if ($("detail_factoryname_"+i).innerHTML=="") break;
		if (sfactory.indexOf($("detail_factoryname_"+i).innerHTML)>=0){
			cmdTravelDetail4Circle('td_detail_factory_'+i,true);
		}else{
			cmdTravelDetail4Circle('td_detail_factory_'+i,false);
		}
	}
	if (sfactory==""){ //전체여행사 상태
		cmdTravelDetail4Circle('td_detail_factory_all',true);
	}else{
		cmdTravelDetail4Circle('td_detail_factory_all',false);
	}
}

/* 항공사선택 원래대로 */
function resetAirline(){
	var obj = document.frmTravel;
	obj.sairline.value = obj.sairline.defaultValue;
	sairline = obj.sairline.value;

	for(i=0; i<80; i++){
		if ($("detail_airname_"+i).innerHTML=="") break;
		if (sairline.indexOf($("detail_airname_"+i).code)>=0){
			cmdTravelDetail4Circle('td_detail_air_'+i,true);
		}else{
			cmdTravelDetail4Circle('td_detail_air_'+i,false);
		}
	}
	if (sairline==""){ //전체여행사 상태
		cmdTravelDetail4Circle('td_detail_air_all',true);
	}else{
		cmdTravelDetail4Circle('td_detail_air_all',false);
	}
}
function cmdEffectBtnGo(tab){
	if ($("img_travel_detail"+tab+"_default").style.display=="block"){
		$("img_travel_detail"+tab+"_default").style.display = "none";
		$("img_travel_detail"+tab+"_go").style.display = "block";
	}
	/*
	if (!$("img_travel_detail"+tab+"_go").visible()){
		var varDetail0GoLeft = Position.cumulativeOffset($("td_travel_detail"+tab+"_go"))[0]-15;
		var varDetail0GoTop = Position.cumulativeOffset($("td_travel_detail"+tab+"_go"))[1]+15;
		if (tab==0){
			varDetail0GoLeft += 20;
		}else if (tab==1){
		
		}else if (tab==2){
			varDetail0GoLeft -= 40;
			varDetail0GoTop -= 20;
		}else if (tab==3){
			varDetail0GoTop += 10;
		}
		$("img_travel_detail"+tab+"_go").style.left = varDetail0GoLeft-80;
		$("img_travel_detail"+tab+"_go").style.top = varDetail0GoTop;
		new Effect.Parallel(
		    [ 
				new Effect.Appear( $("img_travel_detail"+tab+"_go")),
				new Effect.MoveBy( $("img_travel_detail"+tab+"_go"), varDetail0GoTop, varDetail0GoLeft , {duration: 0.5,  transition: Effect.Transitions.sinoidal,mode:'absolute'})
				
			],
		    {duration: 1,  transition: Effect.Transitions.sinoidal,mode:'absolute'}
		);
	}else{
		if (tab!=3){
			new Effect.Pulsate($("img_travel_detail"+tab+"_go"),{duration: 0.5,pulses:3,afterFinish:function(){Element.setOpacity($("img_travel_detail"+tab+"_go"), 1);}});
		}
	}
	*/
}
function cmdCpcLogInsert(shopcode){
	var url = "/move/cpc_log_insert.jsp";
	var param = "szVcode="+shopcode;
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param
		}
	);
}
function CmdLink(url){
	location.href = url;
}
function CmdPopLink(url){
	var w = window.screen.width;
	var h = screen.availHeight;
	//var win = window.open(url,"","width="+w+" height="+h+" top=0 left=0 toolbar=yes,location=yes,directories=yes,status=yes,scrollbars=yes,resizable=yes,menubar=yes,personalbar=yes");
	var win = window.open(url,"_blank");
	win.focus();
}
function cmdTravelRedirect(param, nocpc){
	insertLog(8753);
	var w = window.screen.width;
	var h = screen.availHeight;
	if (nocpc){
		//var win = window.open("/move/Redirect_Tour.jsp?model_subno="+param+"&nocpc=Y","","width="+w+" height="+h+" top=0 left=0 toolbar=yes,location=yes,directories=yes,status=yes,scrollbars=yes,resizable=yes,menubar=yes,personalbar=yes");
		var win = window.open("/move/Redirect_Tour.jsp?model_subno="+param+"&nocpc=Y","_blank");
	}else{
		//var win = window.open("/move/Redirect_Tour.jsp?model_subno="+param,"","width="+w+" height="+h+" top=0 left=0 toolbar=yes,location=yes,directories=yes,status=yes,scrollbars=yes,resizable=yes,menubar=yes,personalbar=yes");
		var win = window.open("/move/Redirect_Tour.jsp?model_subno="+param,"_blank");
	}
	win.focus();
	setTimeout("top.viewTodayView()",500);
}
function cmdTravelAirRedirect(param){
	var w = parseInt(window.screen.width,10);
	var h = screen.availHeight-120;
	if (w>=1280){
		w = 1100;
	}else if (w>=1024) {
		w = 1024;
	}
	var win = window.open("/move/Redirect_Tourticket.jsp?"+param,"_blank","width="+w+" height="+h+" top=0 left=0 toolbar=yes,location=yes,directories=yes,status=yes,scrollbars=yes,resizable=yes,menubar=yes,personalbar=yes");
	win.focus();
}
function fnGetCookie( name ){
    var nameOfCookie = name + "=";
    var x = 0;
    while ( x <= document.cookie.length )
    {
            var y = (x+nameOfCookie.length);
            if ( document.cookie.substring( x, y ) == nameOfCookie ) {
                    if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
                            endOfCookie = document.cookie.length;
                    return unescape( document.cookie.substring( y, endOfCookie ) );
            }
            x = document.cookie.indexOf( " ", x ) + 1;
            if ( x == 0 )
                    break;
    }
    return "";
}
function fnSetTravelCookie(){
	var maxage = 7;
	var todayDate = new Date();
	todayDate.toGMTString()
	todayDate.setDate( todayDate.getDate() + maxage );
	document.cookie = "DetailInfoTravel" + "=" + escape( "CHECKED" ) + "; path=/; expires=" + todayDate.toGMTString() + ";";
	if ($("div_map_detail_info_travel")){
		$("div_map_detail_info_travel").style.display = "none";
	}else if (parent.$("div_map_detail_info_travel")){
		parent.$("div_map_detail_info_travel").style.display = "none";
	}
	
	setTimeout("top.viewTodayView()",500);
	
	return;
}
function syncHeightTravelFrame(el){
	try{
		//var oBody = document.getElementById("travelListFrame").contentWindow.document.body.scrollHeight;
		//alert(oBody);
		$("travelListFrame").height = $("travelListFrame").contentWindow.document.body.scrollHeight + "px";
		//tourScroll();
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
function insertSession(sname, sval){
	var url = "/tour2012/SetTravelSession.jsp";
	var param = "sname="+sname+"&svalue="+sval;
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param
		}
	);
}
// 브라우저 종류와 버전 체크하는 객체 생성자 함수
function objDetectBrowser() {
	var strUA, s, i;
	this.isIE = false;  // 인터넷 익스플로러인지를 나타내는 속성
	this.isNS = false;  // 넷스케이프인지를 나타내는 속성
	this.version = null; // 브라우저 버전을 나타내는 속성
	// Agent 정보를 담고 있는 문자열.
	// 이 값이 궁금한 사람은 alert 문을 이용하여 strUA 값을 확인하기 바란다!
	strUA = navigator.userAgent; 
	
	s = "MSIE";
	// Agent 문자열(strUA) "MSIE"란 문자열이 들어 있는지 체크
	if ((i = strUA.indexOf(s)) >= 0) {
		this.isIE = true;
		// 변수 i에는 strUA 문자열 중 MSIE가 시작된 위치 값이 들어있고,
		// s.length는 MSIE의 길이 즉, 4가 들어 있다.
		// strUA.substr(i + s.length)를 하면 strUA 문자열 중 MSIE 다음에 
		// 나오는 문자열을 잘라온다.
		// 그 문자열을 parseFloat()로 변환하면 버전을 알아낼 수 있다.
		this.version = parseFloat(strUA.substr(i + s.length));
		return;
	}
	
	s = "Netscape6/";
	// Agent 문자열(strUA) "Netscape6/"이란 문자열이 들어 있는지 체크
	if ((i = strUA.indexOf(s)) >= 0) {
		this.isNS = true;
		this.version = parseFloat(strUA.substr(i + s.length));
		return;
	}
	
	// 다른 "Gecko" 브라우저는 NS 6.1로 취급.
	s = "Gecko";
	if ((i = strUA.indexOf(s)) >= 0) {
		this.isNS = true;
		this.version = 6.1;
		return;
	}
}

var objDetectBrowser = new objDetectBrowser();

// 현재 활성화된 버튼을 추적하기 위한 전역 변수.
var gvActiveButton = null;

// 버튼이 아닌 다른 곳에 마우스를 클릭하면 활성화된 버튼을 비활성화로 변경.
/* imzig. 2013.04.17
if (objDetectBrowser.isIE)
	document.onmousedown = mousedownPage;
if (objDetectBrowser.isNS)
	document.addEventListener("mousedown", mousedownPage, true);
*/

if (objDetectBrowser.isIE)
	document.onclick = mousedownPage;
if (objDetectBrowser.isNS)
	document.addEventListener("click", mousedownPage, true);

function mousedownPage(event) {
	var objElement;
	
	// 활성화된 버튼이 없으면 밖으로 빠져 나감.
	if (!gvActiveButton)
		return;
	
	// 현재 선택된 객체 요소를 얻어 옴.
	if (objDetectBrowser.isIE)
		objElement = window.event.srcElement;
	if (objDetectBrowser.isNS)
		objElement = (event.target.className ? event.target : event.target.parentNode);
	
	// 만일 현재 활성화된 버튼을 클릭했다면 그냥 밖으로 빠져 나감.
	if (objElement == gvActiveButton)
		return;
	
	// 만일 클릭한 요소가 메뉴 버튼, 메뉴 아이템 등이 아니면 활성화된 메뉴를 비활성화 시킴.
	
	/* imzig. 2013.04.18
	if (objElement.className != "menuButton"  && objElement.className != "menuItem" && objElement.className != "menuItem2" &&
		objElement.className != "menuItemSep" && objElement.className != "menu")
		resetButton(gvActiveButton);
	*/

	if (objElement.className != "menuButton"  && objElement.className != "menuItem" && objElement.className != "menuItem2" &&
		objElement.className != "menuItemSep" && objElement.className != "menu") {
		var isReturn = false;
		try {
			$(objElement).ancestors().each(function(aE) { 
				if( aE == gvActiveButton ) isReturn = true;
			});
		} catch(ex) {
			console.log(ex);
		}
		if(!isReturn) resetButton(gvActiveButton);
	}
	// imzig. 2013.04.18
	
}

function mouseoverButton(objMnuButton, strMenuName) {
	// 만일 다른 메뉴 버튼이 활성화되어 있다면 비활성화 시킨 후

	// 현재 마우스 오버된 메뉴를 활성화 시킨다.
	if (gvActiveButton && gvActiveButton != objMnuButton) {
		resetButton(gvActiveButton);
	if (strMenuName)
		clickButton(objMnuButton, strMenuName);
	}
}

function clickButton(objMnuButton, strMenuName) {
	// 링크 주변의 아웃라인을 없앰.
	
	objMnuButton.blur();
	// 이 메뉴 버튼에 하위 풀다운 메뉴 객체를 관장할
	// menu 란 이름의 객체 생성
	if (!objMnuButton.menu)
		objMnuButton.menu = document.getElementById(strMenuName);
	// 현재 활성화된 메뉴 버튼을 처음 상태로 되돌림.
	if (gvActiveButton && gvActiveButton != objMnuButton)
		resetButton(gvActiveButton);	
	// 메뉴 버튼 활성화 여부에 따라 활성화/비활성화 토글.
	if (gvActiveButton){
		resetButton(objMnuButton);
	}
	else{
		pulldownMenu(objMnuButton);
	}  
	return false;
}

function pulldownMenu(objMnuButton) {
	// 현재 선택된 객체의 클래스를 "활성화" 클래스로 변경

	objMnuButton.className = "menuButtonActive";
	
	// 익스플로러의 경우, 첫 번째 메뉴 아이템에 대한 명확한 폭을 명시해 주도록 한다.
	// 만일 이 부분을 설정하지 않으면 마우스로 메뉴 아이템 오버시 텍스트 위에 올려놓을 때만
	// 반전된다. 만일 텍스트가 아닌 메뉴 아이템 영역 위로만 갖다 놔도 반전시키려면
	// 이 부분을 설정해 줘야 한다.
	// 이부분을 지워야 IE6,IE9,FF,크롬,사파리에서 에러 없이 돌아감

	//if (objDetectBrowser.isIE && !objMnuButton.menu.firstChild.style.width) {
	// objMnuButton.menu.firstChild.style.width = objMnuButton.menu.firstChild.offsetWidth + "px";
	//}
	// 브라우저마다 각자 환경에 맞는 드롭 다운 메뉴의 위치를 
	// 결정해 줘야 한다.
	x = objMnuButton.offsetLeft;
	y = objMnuButton.offsetTop + objMnuButton.offsetHeight;
	// 크롬이나 사파리 일때
	if(navigator.userAgent.indexOf("Chrome") > 0 || navigator.userAgent.indexOf("Safari") > 0 ){ 
		x += -1;
		y = y + 18;
	}else{
		if (objDetectBrowser.isIE) {
			x += -1;
			y += 1;
		}else{
			x += -parseInt(objMnuButton.menu.style.width,10)-1;
		}
		if (objDetectBrowser.isNS && objDetectBrowser.version < 6.1){
			y--;
		}
	}
	// 위치 결정 및 풀다운 메뉴를 보여줌

	objMnuButton.menu.style.left = x + "px";
	objMnuButton.menu.style.top  = y + "px";
	

	// imzig. 2013.04.17
	if ( objMnuButton.menu == $("LayerSortSelect") ) {
		
		if( objDetectBrowser.isIE && (objDetectBrowser.version == 8 || objDetectBrowser.version == 9 ) ) {
			objMnuButton.menu.style.left = (x+1) + "px";
			objMnuButton.menu.style.top  = (y-3) + "px";
		} else { 		
			objMnuButton.menu.style.left = "721px";
			objMnuButton.menu.style.top  = "17px";
		}
		$('sArrow').src = 'http://img.enuri.info/2012/list/btn_x.gif';
		$('sArrow').setStyle({"marginLeft":"1px","marginRight":"1px"});
	}

	if( objDetectBrowser.isIE && (objDetectBrowser.version == 7 || objDetectBrowser.version == 8 ) ) {
		if( objDetectBrowser.version == 7 ) {
			objMnuButton.menu.style.left = "719px";
		}
		$("lastCloseBtn").style.bottom = "10px";		
	}
	
	
	objMnuButton.menu.style.visibility = "visible";
	
	// 현재 활성화된 메뉴 객체를 저장하는 전역변수 gvActiveButon에

	// 현재 선택된 메뉴 객체를 설정
	gvActiveButton = objMnuButton;
	//event.preventDefault();

}

function resetButton(objMnuButton) {
	// 원래 스타일로 되돌림
	
	if( !objMnuButton ) return;

	objMnuButton.className = "menuButton";
	// 펼쳐진 풀다운 메뉴를 감춰줌

	if (objMnuButton.menu)
	objMnuButton.menu.style.visibility = "hidden";
	
	// imzig. 2013.04.17
	if ( objMnuButton.menu == $("LayerSortSelect") ) {

		try {
			//console.log("resetButton sArrow src = " + $('sArrow').src);
			$('sArrow').src = 'http://img.enuri.info/images/view/travel_new/btn_keyword_down.gif';
			//console.log("resetButton sArrow src = " + $('sArrow').src);
			$('sArrow').setStyle({"margin":"0"});
			//$('sArrow').parentNode.onclick = function() {toggleSortBtnImg(true)};
		} catch(ex){
			console.log(ex);
		}
	}
	
	// 현재 활성화된 메뉴 버튼이 없는 것으로 설정
	gvActiveButton = null;
	//event.preventDefault();
}

function resetButton2(obj) {
	// 원래 스타일로 되돌림

	obj.style.display = "none";
	// 현재 활성화된 메뉴 버튼이 없는 것으로 설정
	gvActiveButton = null;
}

function CmdMouseOver(Obj,n){
	if(n==1){ //onmouseover
		Obj.style.backgroundColor="#08246B";
		Obj.style.color="#FFFFFF";
	}else{
		Obj.style.backgroundColor="#FFFFFF";
		Obj.style.color="#000000";
	}
}
/* 이미지 겹칠때 투명처리 */
function setPng24(obj) { 
    obj.width=obj.height=1; 
    obj.className=obj.className.replace(/\bpng24\b/i,''); 
    obj.style.filter = 
    "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+ obj.src +"',sizingMethod='image');" 
    obj.src='';
    return '';
}
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
function tourBackImgOver(obj){
	var bimg = obj.style.backgroundImage;
	if (bimg && bimg.indexOf("_ov")>0 && bimg.indexOf("_ovx.gif")<0){
		obj.style.backgroundImage = bimg.replace(".gif", "_ovx.gif");
	}
}
function tourBackImgOut(obj){
	var bimg = obj.style.backgroundImage;
	if (bimg && bimg.indexOf("_ovx.gif")>0){
		obj.style.backgroundImage = bimg.replace("_ovx.gif", ".gif");
	}
}
function tourImgOver(obj){
	var bimg = obj.src;
	if (bimg && bimg.indexOf("_ov")>0 && bimg.indexOf("_ovx.gif")<0){
		obj.src = bimg.replace(".gif", "_ovx.gif");
	}
}
function tourImgOut(obj){
	var bimg = obj.src;
	if (bimg && bimg.indexOf("_ovx.gif")>0){
		obj.src = bimg.replace("_ovx.gif", ".gif");
	}
}
function tourFactoryCircleOver(obj){
	if (obj && obj.className!="" && obj.className.indexOf("_circle")>0 && obj.className.indexOf("_ovx")<0){
		obj.className = obj.className + "_ovx";
	}
}
function tourFactoryCircleOut(obj){
	if (obj && obj.className!="" && obj.className.indexOf("_circle")>0 && obj.className.indexOf("_ovx")>0){
		obj.className = obj.className.replace("_ovx","");
	}
}
