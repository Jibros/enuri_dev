	var ImageServer = "http://img.enuri.info";
	var intH = 100; //조절사이즈
	var intS = 100; //조절시차
	var searchBlockHandler;
	
	function blindDown(){
		var tH = 361;
		var h = parseInt($("div_searchflash").style.height, 10);
		if (tH-h-intH > intH){
			$("div_searchflash").style.height = h + intH + "px";
			//$("div_searchflash").style.display = "block";
			searchBlockHandler = setTimeout("blindDown()",intS);
		}else{
			$("div_searchflash").style.height = tH + "px";
			$("div_searchflash").style.display = "block";
			$("btn_search_open").style.display = "none";
			$("btn_search_close").style.display = "block";
			cmdViewResultMap('complex');
			setSearchCondition();
			setResultmapClick(0);
			clearTimeout(searchBlockHandler);
		}
	}
	function moveButton(){
		var varSearchFlashLeft = Position.cumulativeOffset(document.getElementById("div_searchflash"))[0];
		var varSearchFlashTop = Position.cumulativeOffset(document.getElementById("div_searchflash"))[1];
		// 처음 비행기 버튼
		var div_go_search_default = document.getElementById("div_go_search_default")
		div_go_search_default.style.left = Position.cumulativeOffset($("div_searchflash"))[0]-varSearchFlashLeft+373+"px";
		div_go_search_default.style.top = Position.cumulativeOffset($("div_searchflash"))[1]+290+"px";
		// div_go_search
		var div_go_search = document.getElementById("div_go_search");
		div_go_search.style.left =Position.cumulativeOffset($("div_searchflash"))[0]-varSearchFlashLeft+373+"px";
		div_go_search.style.top = Position.cumulativeOffset($("div_searchflash"))[1]+289+"px";
	}
	function blindUp(){
		var tH = 0;
		var h = parseInt($("div_searchflash").style.height, 10);
		
		if (h>6){
			if (h-tH > intH){
				$("div_searchflash").style.height = h - intH + "px";
				$("div_searchflash").style.display = "none";
				$("btn_search_close").style.display = "none";
				$("btn_search_open").style.display = "block";
				cmdViewResultMap('simple');
				searchBlockHandler = setTimeout("blindUp()",intS);
			}else{
				$("div_searchflash").style.height = tH + "px";
				$("div_searchflash").style.display = "none";
				setResultmapClick(1);
				clearTimeout(searchBlockHandler);
			}
		}
	}
	function showAlert(strMsg){
		alert(strMsg); 
	}
	function bsShow(){
		insertLog(5230);
		try{
			travelListFrame.cmdTravelDetailTab();
		}catch(e){}
		clearTimeout(searchBlockHandler);
		blindDown();
		//Effect.SlideDown('div_searchflash', {duration:1.0, afterFinish:bsShowAfter()});
	}
	function bsShowAfter(){
		cmdViewResultMap('complex');
		$("btn_search_close").style.display = "block";
		setSearchCondition();
	}
	function bsHidden(){
		insertLog(5231);
		clearTimeout(searchBlockHandler);
		blindUp();
		//Effect.SlideUp('div_searchflash', {duration:1.0, afterFinish:bsHiddenAfter()});
	}
	function bsHiddenAfter(){
		cmdViewResultMap('simple');
		$("btn_search_open").style.display = "block";
		$("btn_search_close").style.display = "none";
	}
	function cmdTravelTop(){
		CmdLink('/tour2012/Tour_Index.jsp');
	}
	function getTravelUrl(){
		var tour_furl = document.URL;
		if (intSstep==1){ //메인
		
		}else{ //검색결과
			var obj = document.frmTravel;
			tour_furl = tour_furl.substring(0,tour_furl.indexOf("Tour_Searchlist.jsp"));
			tour_furl += "Tour_Searchlist.jsp?";
			
			//tour_furl += "sptype=detail2";
			//tour_furl += "&sstep=3";
			if (obj.msearch.value!=""){
				tour_furl += "&msearch=" + obj.msearch.value;
			}
			if (obj.subject.value!=""){
				tour_furl += "&subject=" + obj.subject.value;
			}
			tour_furl += "&skind=" + obj.skind.value;
			if (obj.sarea.value!=""){
				tour_furl += "&sarea=" + obj.sarea.value;
			}
			if (obj.slocalcity.value!=""){
				tour_furl += "&slocalcity=" + obj.slocalcity.value;
			}
			tour_furl += "&sdatetype=" + obj.sdatetype.value;			
			tour_furl += "&sstart=" + obj.sstart.value;
		}
		return tour_furl;
	}
	//즐겨찾기,링크걸기
	function cmdGetLinkLayer(){
		if ($("LinkLayer").style.display!="block"){
			$("LinkLayer").style.display = "block";
		}else{
			$("LinkLayer").style.display = "none";
		}
	}
	function cmdTabmenu1(){
		if (intSstep==1){ //메인에선 여행상품검색 클릭
			cmdTravelTop();
		}else{ //검색결과에서 
			cmdTravelTab();
		}
	}
	function cmdViewResultMap(param){
		// 다시선택 , 감추기 버튼 위치 브라우져별로 조정
		if (param=="complex"){
			// 검색후 펼치기 했을때 레이어 삐져나옴줄임
			if($("detail_info_layer").style.display=="block"){
				$("tbl_resultmap").style.height = "150px";
				$("div_searchresultmap").style.height = "140px";
				if(borwserName=="msie"){
					$("btn_search_close").style.margin="-7px 0 0 661px";
				}else{
					if(borwserName=="msie"){
						$("btn_search_close").style.margin="-7px 0 0 661px";
					}else if(borwserName=="firefox"){
						$("btn_search_close").style.margin="-8px 0 0 661px";	
					}else if(borwserName=="chrome" || borwserName=="safari"){
						$("btn_search_close").style.margin="-12px 0 0 661px";
					}else if(borwserName=="msie6" || borwserName=="msie7"){
						$("btn_search_close").style.margin="-6px 0 0 661px";
					}else if(borwserName=="msie9"){
						$("btn_search_close").style.margin="-8px 0 0 661px";
					}else{
					}
				}
			}else{
				if(borwserName=="safari" || borwserName=="chrome"){
					$("tbl_resultmap").style.height = "128px";
				}else{
					$("tbl_resultmap").style.height = "135px";
				}
				
				if(borwserName=="msie"){
					$("btn_search_close").style.margin="-8px 0 0 661px";
				}else if(borwserName=="firefox"){  
					$("btn_search_close").style.margin="-9px 0 0 661px";
				}else if(borwserName=="chrome"){ 
					$("btn_search_close").style.margin="-15px 0 0 661px";
				}else if(borwserName=="chrome"){ 
					$("btn_search_close").style.margin="-8px 0 0 661px";
				}else if(borwserName=="safari"){
					$("btn_search_close").style.margin="-15px 0 0 661px";
				}else if(borwserName=="msie6" || borwserName=="msie7"){
					$("btn_search_close").style.margin="-7px 0 0 661px";
				}else if(borwserName=="msie9"){
					$("btn_search_close").style.margin="-9px 0 0 661px";
				}else{
					$("btn_search_close").style.margin="-8px 0 0 661px";
				}
				$("div_searchresultmap").style.height = "127px";
			}
			// 검색후 펼치기를 했을때
			$("search_detail_layer_top").style.display = "none";
			$("div_result_blankarea").style.height = "2px";
			$("div_searchresultmap").style.marginTop = "-1px";
			//$("tbl_resultmap").style.background = "url("+ImageServer+"/images/view/travel_new/tong_bg.gif) no-repeat top left";
		}else if (param=="simple"){
			// 검색후 감추기 했을때 레이어 벌어짐 방지
			if($("detail_info_layer").style.display=="block"){
				if(borwserName=="chrome"){ 
					$("btn_search_open").style.margin="-12px 0 0 661px";
				}else if(borwserName=="msie6" || borwserName=="msie7"){
					$("btn_search_open").style.margin="-7px 0 0 661px";
				}else if(borwserName=="msie"){
					$("btn_search_open").style.margin="-8px 0 0 661px";
				}else if(borwserName=="msie9"){
					$("btn_search_open").style.margin="-9px 0 0 661px";
				}else{
				}
				
				$("tbl_resultmap").style.height = "150px";
				$("div_searchresultmap").style.height = "150px";
			}else{
				if(borwserName=="firefox"){  
					$("btn_search_open").style.margin="-9px 0 0 661px";
				}else if(borwserName=="chrome" || borwserName=="safari"){ 
					$("btn_search_open").style.margin="-15px 0 0 661px";
				}else if(borwserName=="msie6" || borwserName=="msie7"){
					$("btn_search_open").style.margin="-7px 0 0 661px";
				}else if(borwserName=="msie"){
					$("btn_search_open").style.margin="-8px 0 0 661px";
				}else if(borwserName=="msie9"){
					$("btn_search_open").style.margin="-9px 0 0 661px";
				}else{
				}
				$("tbl_resultmap").style.height = "127px";
				$("div_searchresultmap").style.height = "140px";
			}
			
			// 검색후 감추기를 했을때
			$("search_detail_layer_top").style.display = "block";
			$("div_searchresultmap").style.marginTop = 0;
			$("div_result_blankarea").style.height = "5px";
			//$("tbl_resultmap").style.background = "url("+ImageServer+"/images/view/travel_new/tong_bg.gif) no-repeat top left";		
		}else if (param=="main"){
			// 처음 화면에서 조건 선택을 했을때
			$("div_result_blankarea").style.height = 7;
			//$("tbl_resultmap").style.backgroundImage = "url("+ImageServer+"/images/view/travel_new/tong_bg.gif) no-repeat top left";
		}
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
	//기본조건 선택마다 현재위치 표시값 가져오기
	function cmdGetCountChange(param){
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
		
		var url = "/tour/GetCount.jsp";
		var rtype = "rtype=condition&" + new_param + "&ltab=" + selectedCon;
		var getRec = new Ajax.Request(
			url,
			{
				method:'get',parameters:rtype,onComplete:inputCountChange
			}
		);
		// 검색 결과 개수 바꿔 주는 부분
		cmdGetCountResult(param);
		var new_param = getBeforeParamCheck(param);
		if (!new_param || new_param==""){
			$("resultmap_getcntline").style.display = "none";
		}
		//cmdGetCountResult(param);
	}
	//기본조건 선택결과 현재위치에 표시
	function inputCountChange(originalRequest){
		//try{
			eval("arrReturn = " + originalRequest.responseText);
			if (eval("arrReturn")){
				var mapsubject = eval("arrReturn.mapsubject");
				var maparea = eval("arrReturn.maparea");
				var mapsdatetype = eval("arrReturn.mapsdatetype");
				var mapstart = eval("arrReturn.mapstart");
				var mapstartmaxafter = eval("arrReturn.mapstartmaxafter");
				var mapkind = eval("arrReturn.mapkind");
				var mapperiod = eval("arrReturn.mapperiod");
				var ltab = eval("arrReturn.ltab");
				if (ltab!="A7"){
					$("img_resultmap_tit1").src = ImageServer+"/images/view/travel_new/resultmap_1_110718.gif";
					$("resultmap_getarea").innerHTML = maparea;
				}else{
					$("img_resultmap_tit1").src = ImageServer+"/images/view/travel_new/resultmap_1_2_110718.gif";
					$("resultmap_getarea").innerHTML = mapsubject;
				}
				if (mapstartmaxafter!="" || mapsdatetype=="T" || mapstart.indexOf("없습니다")>0){
					if(getIEVersion()<0){
						document.getElementById("resultmap_getstartday").style.top = 22;
						document.getElementById("resultmap_getstartday").style.left = 0;
					}else{
						document.getElementById("resultmap_getstartday").style.top = 25;
						document.getElementById("resultmap_getstartday").style.left = 0;
					}
				}else{
					if(getIEVersion()<0){
						document.getElementById("resultmap_getstartday").style.top = 7;
						document.getElementById("resultmap_getstartday").style.left = 52;
					}else{
						document.getElementById("resultmap_getstartday").style.top = 8;
						document.getElementById("resultmap_getstartday").style.left = 52;
					}
				}
				$("resultmap_getstartday").innerHTML = mapstart;
				$("resultmap_getgoodskind").innerHTML = mapkind;
				if (intSstep==1){
					cmdViewResultMap('main');
				}else{
					// 지역 선택하고 여행 기간 나왔다  취소했을때 결과 없음을 보여주는 부분
					//$("resultmap_getperiod").innerHTML = (mapperiod=="")?"결과없음":mapperiod;
					$("resultmap_getperiod").innerHTML = (mapperiod=="")?"":mapperiod;
					$("resultmap_getetc").innerHTML = "";
					$("resultmap_gettitle5").style.display = "none";
					cmdViewResultMap('complex');
				}
				$("img_result_none").style.display = "none";
				$("img_result_subjectnone").style.display = "none";
				//alert(intSstep);
				if(intSstep==1){
					$("div_searchresultmap").style.height = "120px";
				}else{
					if($("detail_info_layer").style.display == "block"){
						$("div_searchresultmap").style.height = "143px";
					}else{
						$("div_searchresultmap").style.height = "125px";
					}
				}
				if (intSstep==1 && (maparea.indexOf("없습니다")>0 || (ltab=="A7" && mapsubject=="")) && mapstart.indexOf("없습니다")>0){ //여행지, 출발일 둘다 선택이 없으면 현재위치 사라짐
					//$("div_searchflash").style.height = "365px";
					if($("search_main_bottom")){
						$("search_main_bottom").style.display = "block";
					}
					$("div_searchresultmap").style.display = "none";
				}else{
					//$("div_searchflash").style.height = "485px";
					if($("search_main_bottom")){
						$("search_main_bottom").style.display = "none";
					}
					$("div_searchresultmap").style.display = "block";
				}
			}			
		//}catch(e){}
	}
	//기본조건 선택마다 현재위치 상품수 가져오기
	function cmdGetCountResult(param){
		var new_param = getBeforeParamCheck(param);
		if (new_param && new_param!=""){
			var url = "/tour/GetCount.jsp";
			var param = "rtype=count&" + new_param;
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
		//try{
			eval("arrReturn = " + originalRequest.responseText);
			if (eval("arrReturn")){
				var cnt = eval("arrReturn.count");
				var gcnt = eval("arrReturn.groupcount");
				$("resultmap_getcnt").innerHTML = (cnt.length>3) ? (cnt.substring(0,cnt.length-3)+","+cnt.substring(cnt.length-3)) : cnt;
				$("resultmap_getgroupcnt").innerHTML = (gcnt.length>3) ? (gcnt.substring(0,gcnt.length-3)+","+gcnt.substring(gcnt.length-3)) : gcnt;
				$("resultmap_getcntline").style.display = "block";
			}
		//}catch(e){}
	}
	//기본조건 검색
	var tmpDefaultSearchParam = "";
	function cmdTravelDefaultSearch(param){
		param = getBeforeParamCheck(param);
		if (param && param!=""){
			tmpDefaultSearchParam = param;
			var url = "/tour/GetCount.jsp";
			var param = "rtype=count&" + param;
			var getRec = new Ajax.Request(
				url,
				{
					method:'get',parameters:param,onComplete:cmdTravelDefaultGetcount
				}
			);
		}
	}
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
				/** 더많은검색
				if (tmpDefaultSearchParam.indexOf("msearch=Y")>=0){
					$("div_nodata_moresearch").style.display = "none";
					alert("검색결과가 없습니다.\n선택을 변경하여 다시 검색해 보세요.");
					return;
				}else{
					//지역선택 결과 없을때 더많은 검색여부 묻기
					$("div_nodata_moresearch").style.display = "block";
				}
				*/
			}
			$("div_go_search").style.display = "none";
			$("div_go_search_default").style.display = "none";
		}else{
			//alert("/tour/Tour_Searchlist.jsp?"+tmpDefaultSearchParam);
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
			location.href = "/tour/Tour_Searchlist.jsp?" + tmpDefaultSearchParam;
		}
	}
	//더많은검색 추가
	function cmdTravelDefaultMoreSearch(param){
		param = getBeforeParamCheck(param);
		if (param && param!=""){
			tmpDefaultSearchParam = "msearch=Y&"+param;
			var strUrl = "/tour/GetCount.jsp";
			var strParam = "rtype=count&msearch=Y&" + param;
			var xmlHttpReq = false;
			xmlHttpReq = createHttpRequest();
			xmlHttpReq.open('POST',strUrl,true);
			xmlHttpReq.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
			xmlHttpReq.onreadystatechange = function(){
				if (xmlHttpReq.readyState == 4 ){
					cmdTravelDefaultGetcount(xmlHttpReq);
				}
			}
			xmlHttpReq.send(strParam);
		}
	}
	function cmdTopMinAirTicket(){
		if (parseInt($("div_top_minairticket").style.height,10)==19){
			$("div_top_minairticket").style.height = 179;
			$("btn_tour_top3").src = ImageServer+"/images/view/travel/tiket_combo_on.gif";
		}else{
			cmdTopMinAirTicketHide();
		}
	}
	function cmdTopMinAirTicketHide(){
		$("div_top_minairticket").style.height = 19;
		$("btn_tour_top3").src = ImageServer+"/images/view/travel/tiket_combo.gif";	
	}
	//결과페이지의 현재위치영역 클릭시 기능들
	function cmdBsShowByResultmap(){
		if ($("btn_search_open").style.display=="block" && $("div_searchflash").style.display=="none"){
			bsShow();
			setResultmapClick(0);
		}
	}
	function cmdDetailTabByResultmap(tab){
		try{
			if ($("div_searchflash").style.display=="none"){
				travelListFrame.cmdTravelDetailTab(tab);
			}
		}catch(e){}
	}
	function setResultmapClick(flg){
		if (flg==1){
			var obj = document.all.td_resultmap_area1;
			for(i=0; i<obj.length; i++){
				obj[i].style.cursor = "pointer";
			}
			$("td_resultmap_area2").style.cursor = "pointer";
			$("td_resultmap_area3").style.cursor = "pointer";	
		}else{
			moveButton();
			var obj = document.all.td_resultmap_area1;
			for(i=0; i<obj.length; i++){
				obj[i].style.cursor = "default";
			}
			$("td_resultmap_area2").style.cursor = "default";
			$("td_resultmap_area3").style.cursor = "default";
		}
	}
	function cmdDetailTabByResult5(){
		var imgname = $("resultmap_gettitle5").src;
		if (imgname.indexOf("5_1")>0){ //예약상태
			cmdDetailTabByResultmap(1);
		}else if (imgname.indexOf("5_2")>0){ //항공시간
			cmdDetailTabByResultmap(2);
		}else if (imgname.indexOf("5_3")>0){ //가격대
			cmdDetailTabByResultmap(3);
		}else if (imgname.indexOf("5_4")>0){ //여행사/항공사
			cmdDetailTabByResultmap(4);
		}
	}
	function showMoreDetailText(obj,ord){
		var ow = Element.getDimensions(obj).width;
		var str = obj.innerText;
		hideMoreDetailText(1);
		hideMoreDetailText(2);
		if (ow > 315){ //레이어로 숨은내용 보이기
			$("resultmap_etc_fulltext"+ord).innerText = str;
			$("resultmap_etc_fulltext"+ord).style.display = "block";
		}
	}
	function hideMoreDetailText(ord){
		$("resultmap_etc_fulltext"+ord).style.display = "none";
	}
	//오른쪽 탑 배너 : Tour_Index.jsp, Tour_Searchlist.jsp 의 div_tour_right_top 영역에 있는 배너 롤링효과
	var iTourTopBannerTm = 5000; //배너 시간간격
	var varTourTopBannerCnt = 2; //배너 갯수
	var varTourTopChangeBannerIdx = 2; //첫 로딩은 2부터 보임
	var tourTopBannerTimeHandler;
	function tourTopChangeBanner(){
		setTourTopBanner(varTourTopChangeBannerIdx);
	}
	function setTourTopBanner(bno){
		clearTimeout(tourTopBannerTimeHandler);
		for (i=1; i<=varTourTopBannerCnt; i++){
			if ($("tour_topad_"+i)){
				if (i==bno){
					$("tour_topad_"+i).style.display="block";
					$("tour_topadnum"+i).src=ImageServer+"/images/view/travel/ad_snum"+i+"_ov.gif";	
				}else{
					$("tour_topad_"+i).style.display="none"; 
					$("tour_topadnum"+i).src=ImageServer+"/images/view/travel/ad_snum"+i+".gif";
				}
			}
		}
		varTourTopChangeBannerIdx++;
		if (varTourTopChangeBannerIdx>varTourTopBannerCnt){
			varTourTopChangeBannerIdx = 1;
		}
		tourTopBannerTimeHandler = setTimeout("tourTopChangeBanner()",iTourTopBannerTm);
	}