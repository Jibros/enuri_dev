$(document).ready(function() {
	
	try{	topBannerInit(); 		}catch(e){		console.log("topBannerInit:"+e);	}
	try{	pickLoading(); 		}catch(e){		console.log("pickLoading:"+e);	}
	try{	CmdMainKnowcom();	}catch(e){		console.log("CmdMainKnowcom:"+e);	}
	try{	CmdMainKnowcom2();	}catch(e){		console.log("CmdMainKnowcom2:"+e);	}
	try{	mainSuggestGoodsMake(); }catch(e){		console.log("mainSuggestGoodsMake:"+e);	}
	try{	mainPopGoodsMake(); }catch(e){			console.log("mainPopGoodsMake:"+e);	}
	try{	loadEnuripcMore(1);enuripcTabBind(); }catch(e){		console.log("loadEnuripcMore:"+e);	}
	try{	loadGlobalGoods(); }catch(e){		console.log("loadGlobalGoods:"+e);	}
	try{	event_bannerLoading(); }catch(e){		console.log("event_bannerLoading:"+e);	}
	try{	getMainEventBanner();	}catch(e){		console.log("getMainEventBanner:"+e);	}
	try{	mainExhibitionLoading(); }catch(e){		console.log("mainExhibitionLoading:"+e);	}
	try{	loadTourCompare();	}catch(e){		console.log("loadTourCompare:"+e);	}
	try{	initLoading();		}catch(e){		console.log("initLoading:"+e);	}
	try{	userCar();			}catch(e){		console.log("userCar:"+e);	}
	try{	mainCarBanner();	}catch(e){		console.log("mainCarBanner:"+e);	}
	try{	loadNotice();		}catch(e){		console.log("loadNotice:"+e);	}
    
    $("body").on('click', "#related_arrow > button", function(e) {
		changeSuggest(($(this).index() == 0) ? -4 : 4);
	});
    
    $("body").on('click', "#vipSpecTabs > li", function(e) {
    	
    	$(this).addClass("is-on").siblings().removeClass('is-on');
    	
    	var id = $(this).children().attr("id");
    	
    	if(id == "suggest_pop_btn"){
    		
    		$("#compare__list_pop").show();
        	$("#compare__list_sam").hide();
        	$("#compare__list_new").hide();
    		
    	}else if(id == "suggest_sam_btn"){
    		
    		$("#compare__list_pop").hide();
        	$("#compare__list_sam").show();
        	$("#compare__list_new").hide();
    		
    	}else if(id == "suggest_new_btn"){
    		$("#compare__list_pop").hide();
        	$("#compare__list_sam").hide();
        	$("#compare__list_new").show();
    	}
    	insertLog(24357);
    	
    });
    getWingBanner();
    mainReloadGo();
});

var IsKeywordFocused = false;
var startTimeMS = 0;
var timerStep = 1000;
function startTimer() {	startTimeMS = (new Date()).getTime();}
function getRemainingTime() {	return  timerStep - ((new Date()).getTime() - startTimeMS);}
function reloadMain() {	if(!IsKeywordFocused) {	var nowUrl = document.location.href; document.location.href = nowUrl;} }

function mainReloadGo(){
	var refreshTime = 120000; // 2분
	var mainReloadTimer = setInterval(reloadMain, refreshTime);
	$(document).mousemove(function(event) {
		var rTime = getRemainingTime();
		if(rTime<0) {
			clearInterval(mainReloadTimer);
			mainReloadTimer = setInterval(reloadMain, refreshTime);
			startTimer();
		}
	});
	// 포커스 확인
	var keywordObj = $("#search_keyword");
	keywordObj.focus(function() {	IsKeywordFocused = true;	});
	keywordObj.blur(function() {		IsKeywordFocused = false;	});
	startTimer();
}

var iid = "";
function topBannerInit() {

	var ajaxObj = jQuery.ajax({
		type : "get",
		url : "http://ad-api.enuri.info/enuri_PC/pc_home/O1/req",
		async: true,
		cache: false,
		data : param,
		dataType : "json",
		success: function(json) {
			var TXT1 = json["TXT1"];
			var JURL1 = json["JURL1"];
			var IMG1 = json["IMG1"];
			var TARGET = json["TARGET"];
			var BGCOLOR = json["BGCOLOR"];
			iid = json["IID"];
			
			var topBannerNewObj = jQuery("#topBannerNew");
			var html = "<a class=\"banner_inner\" href=\""+JURL1+"\" target=\"_new\" ";
			html += "style=\"background-image: url('"+IMG1+"');\">";
			html += "</a>";
			
			topBannerNewObj.html(html);
			topBannerNewObj.css("background-color", BGCOLOR);

			var iexpad = getCookie('iexpad');
			if( json["IID"] ){
				html += "<div class='hto_wrap'>";			
					html += "<div class='circle_progress s28 btn_ad_expand' style='display: block;'>";
		        html += "        <span class='left_half'><span class='bar'></span></span>";
		        html += "        <span class='right_half'><span class='bar'></span></span>";
		        html += "        <div class='center_full'><i class='lp__sprite ad_arrow_down'></i></div>";
		        html += "    </div>";
		        html += "</div>";
	
		        topBannerNewObj.append(html);

				jQuery.ajax({
					type : "get",
					url : "http://ad-api.enuri.info/enuri_PC/pc_home/O1_1/bundle?bundlenum=10",
					async: true,
					cache: false,
					dataType : "json",
					success: function(json) {

						$.each(json, function (i, v) { 

							if( v["IID"] == iid){
								var TXT1 = v["TXT1"];
								var JURL1 = v["JURL1"];
								var IMG1 = v["IMG1"];
								var TARGET = v["TARGET"];
								var BGCOLOR = v["BGCOLOR"];
								var IID = v["IID"];
			
								var html="";
								var display = "";
								
								html = "<div class=\"header_top_expand_ad_img\" style='background-color: "+BGCOLOR+"'>";
								html += "    <div class=\"htea_warp\">";
								html += "        <a href='"+JURL1+"' TARGET='_blank' ><img src='"+IMG1+"'></a>";
								html += "        <div class=\"btn_area\">";
								html += "            <button type=\"button\" class=\"btn_close_expand_img\">닫기<i class=\"lp__sprite icon_close\"></i></button>";
								html += "        </div>";
								html += "    </div>";
								html += "</div>";
								
								topBannerNewObj.parent().next().before(html);
								if(iexpad != "Y"){
									$('.header_top_expand_ad_img').slideDown();
								}
		
								if(iexpad != "Y"){
									setTimeout(function(){
										$('.header_top_expand_ad_img').slideUp();
										$('.btn_ad_expand').fadeIn();
										fnSetCookie2010("iexpad", "Y", 1);
									}, 2000);
								}
				
								var expandTopImg;
								$('.btn_ad_expand').hover(function(){
									$(this).addClass('loading');
									expandTopImg = setTimeout(function(){
										$('.header_top_expand_ad_img').stop().slideDown();
									},500);
								}, function(){
									$(this).removeClass('loading');
									clearTimeout(expandTopImg);
								}).on('click', function(){
									$('.header_top_expand_ad_img').stop().slideDown();
									clearTimeout(expandTopImg);
								});
								
								$('.header_top_expand_ad_img .btn_close_expand_img').on('click', function(){
									$(this).parents('.header_top_expand_ad_img').stop().slideUp();
									fnSetCookie2010("iexpad", "Y", 1);
								});
								return false;
							}

						});
					}
				});
			
			}

		},
		error: function (xhr, ajaxOptions, thrownError) {
		}
	});
	fnOpenTopBanner();
}
function fnGoPage(url,log){
    window.open(url);
	try {
		if(log != null && log != undefined) insertLog(log);		
	} catch (error) {
		console.log(error);
	}
}
function fnOpenTopBanner(){
    var offsetHeight = 69;
    jQuery("#topBannerNew").css({"overflow":"hidden"}).show();

}
var trendPickUpRolling = function (){
	clearInterval(trendPickUpRolling);
	trendPickUpRolling = setInterval("goStarRolling()",30000);
}

$( ".trendpickup__inner" ).mouseenter(function() {
	  clearInterval(trendPickUpRolling);
  }).mouseleave(function() {
	  clearInterval(trendPickUpRolling);
	  trendPickUpRolling = setInterval("goStarRolling()",5000);
});
trendPickUpRolling();
function goStarRolling(){
	
	$(".trendtabs__list > li").each(function(i,v){
		if( $(this).hasClass("is-on") ){
			shopMenu_btn(i+1,"N");
			//var data_pg = $(this).attr("data-logno");
			//console.log("data_pg :"+data_pg);
			//if(data_pg > 0 && undifindedCheck(data_pg) )	insertLog(data_pg);	
			return false;
		}
	});
	
}
function undifindedCheck(str){
        
    if(typeof str == "undefined" || str == null || str == "")
        return true;
    else
        return false ;
}
function goTrendGoods(type , modelnoplno , abc , clk_no , trendno){
	try {
		var goUrl = "";
	if(type == "M"){
		goUrl = "/detail.jsp?modelno="+modelnoplno
		if(abc == "A")       insertLogModel(16996,modelnoplno,'');
		else if(abc == "B")  insertLogModel(17002,modelnoplno,'');
		else if(abc == "C")  insertLogModel(17004,modelnoplno,'');
		if(  clk_no  > 0 ) insertLogModel(clk_no,modelnoplno,'');
		
	}else if(type == "P"){
		goUrl = "/move/Redirect.jsp?type=ex&cmd=move_"+modelnoplno+"&pl_no="+modelnoplno;
		if(abc == "A")       insertLog(16996);
		else if(abc == "B")  insertLog(17002);
		else if(abc == "C")  insertLog(17004);
		if(clk_no){
			insertLog(clk_no);	
		}
		
	}else if(type == "O"){
		//템플릿 D 일 경우 type O 는아웃링크  modelnoplno = LNK_URL 을 넣는다
		goUrl = modelnoplno;
		if(clk_no){
			if(clk_no > 0)	insertLog(clk_no); //관리자가 넣은 로그		
		}
		insertLog(17665); //공통 로그
	}
	fnInsertHitLog(trendno,2);
	//window.open(goUrl);
	} catch (error) {
		console.log(error);
	}
	
}
function getWingBanner(){
	
	$.ajax({
	    url: "http://ad-api.enuri.info/enuri_PC/pc_home/A1/req",
	    cache: false,
	    dataType: "JSON",
	    success: function(v) {
	    	
	    	var html = "<a href='"+v.JURL1+"' target='_blank' class='bnr__anchor'>";
	    		html += "<img src='"+v.IMG1+"' alt='광고배너 이미지' />";
	    		html += "</a>";
	    	$(".bnr__band").html(html);
	    }
	});
	
	$.ajax({
	    url: "http://ad-api.enuri.info/enuri_PC/pc_home/A5/req",
	    cache: false,
	    dataType: "JSON",
	    success: function(v) {
	    	
	    	var showYn = false;
	    	
	    	var html1 =  "<div class='wing-ad' id='wing_left_banner1'><a href='"+v.JURL1+"' class='wing-ad__bnr' target='_blank'>";
	    		html1 += "<img src='"+v.IMG1+"' alt=''>";
	    		html1 += "</a>";
	    		html1 += "</div>";
	    		if(v.IMG1){
	    			$(".wing.wing--left").append(html1);
	    			showYn = true;
	    		}
	    		
	    		$.ajax({
	    		    url: "http://ad-api.enuri.info/enuri_PC/pc_home/A6/req",
	    		    cache: false,
	    		    dataType: "JSON",
	    		    success: function(v) {
	    		    	var html2 =  "<div class='wing-ad' id='wing_left_banner2'><a href='"+v.JURL1+"' class='wing-ad__bnr' target='_blank'>";
	    		    		html2 += "<img src='"+v.IMG1+"' alt=''>";
	    		    		html2 += "</a>";
	    		    		html2 += "</div>";
	    		    		if(v.IMG1){
	    		    			$(".wing.wing--left").append(html2);
	    		    			showYn = true;
	    		    		}
	    		    		if(showYn){
	    		    			$(".wing.wing--left").show();	
	    		    		}
	    		    		
	    		    }
	    		});
	    }
	});
	$.ajax({
	    url: "http://ad-api.enuri.info/enuri_PC/pc_home/O4/req",
	    cache: false,
	    dataType: "JSON",
	    success: function(v) {
	    	
	    	if(v.JURL1){
	    		var html = "<a href='"+v.JURL1+"' target='_self' class='bnr__anchor'>";
	    		html += "<img src='"+v.IMG1+"' alt='광고배너 이미지' />";
	    		html += "</a>";
	    		$(".bottom__bnr__band").html(html);	    		
	    	}else{
	    		$(".bottom__bnr__band").hide();
	    	}
	    }
	});
	$.ajax({
	    url: "http://ad-api.enuri.info/enuri_PC/pc_home/A2/req",
	    cache: false,
	    dataType: "JSON",
	    success: function(v) {
	    	var html = "<a href='"+v.JURL1+"' target='_blank' class='bnr__anchor'>";
	    		html += "<img src='"+v.IMG1+"' alt='광고배너 이미지' />";
	    		html += "</a>";
	    	$(".mid__bnr__band").html(html);
	    }
	});
}
function shopmenu_sel(idx){
	var __this;
	var tpcd = "";
	var pglog = "";
	$(".trendtabs__list > li").each(function(i,v){
		if(i == idx){
			__this = $(this);
			tpcd = __this.attr("data-tpcd");
			pglog = __this.attr("data-logno");
			return false;
		}
	});
	if(idx < 0 ){
		var tot = $(".trendtabs__list li").length;
		__this = $(".trendtabs__list > li").eq(tot-1);
		idx = tot-1;
	}
	//var __dot = __this.children("a").attr("href");
	var __dot = __this;
	$(".trendpickup__container").css({"z-index": 0});

	$(".trendtabs__list > li").removeClass("is-on");
	$(__this).addClass("is-on");
	$(__dot).css({"z-index":100});
	
	var trendno = $(__this).attr("trend_no");
	
	$.ajax({
	    url: "/wide/main/ajax/wTrendHtml"+idx+".jsp",
	    cache: false,
	    dataType: "html",
	    success: function(data) {
	    	$(".trendpickup__container").html(data);
			//trendPickSetLoading();	
	    	trendPickSwiperInit(tpcd);
	    	
	    	$(".trendtabs__list > li").each(function(i,v){
	    		var cls = $(this).attr("class");
	    		
	    		if(cls.indexOf("is-on") > -1 ){
	    			//var href = $(this).children("a").attr("href");
	    			var tpcd = $(this).attr("data-tpcd");
	    			
	    			if(tpcd == "F"){
	    				clearInterval(trendPickUpRolling);
	    				trendPickUpRolling = setInterval("goStarRolling()",30000);
	    			}else{
	    				clearInterval(trendPickUpRolling);
	    				trendPickUpRolling = setInterval("goStarRolling()",5000);
	    			}
	    			
	    		}
	    	});
	    }
	});
	try {
		if(pglog){
			if(pglog > 0)	{
				insertLog(pglog);
			}	
		}
		
	} catch (error) {
		console.log(error);
	}
	
}
function trendPickSwiperInit(tpcd){
	
	if(tpcd=="D"){
		var trendPickSwiper = new Swiper('.prodwrap-type1 .swiper-container',{
	        initialSlide : 0,
	        loop : true,
	        slidesPerView: 4,
	        slidesPerGroup: 4,
	        variableWidth: true,
	        speed : 0,
	        prevButton : '.prodwrap-type1 .arr-prev',
	        nextButton : '.prodwrap-type1 .arr-next'
	    	/*
	        navigation: {
	          nextEl: '.prodwrap-type1 .arr-next',
	          prevEl: '.prodwrap-type1 .arr-prev',
	        },
	        */
	    });
		
	}else if(tpcd=="A"){
		 // 트렌드픽업 타입1 스와이퍼
	    var trendPickSwiper2 = new Swiper('.prodwrap-type2 .swiper-container',{
	        initialSlide : 0,
	        loop : true,
	        slidesPerView: 2,
	        slidesPerGroup: 2,
	        speed : 0,
	        variableWidth: true,
	        prevButton : '.prodwrap-type2 .arr-prev',
	        nextButton : '.prodwrap-type2 .arr-next'
	    });
	}
   
}
function shopMenu_btn(num,logYN){
	$shopmenu__list = $(".trendtabs__list > li");
	var total = $(".trendtabs__list li").length;
	
	var _idx = 0;

	if(num == 0){
		$shopmenu__list.each(function(i,v){ if($(this).hasClass("is-on")) _idx = i+1; });
	}else{
		_idx = num;
	}
	//현재 높이 구함.
	var vTop = Math.abs(parseInt($(".trendtabs__list").css("top").replace("px")));
	//현재 선택된놈 * 40px이 현재 위치값
	var vNowp = _idx * 45;
	//if(vNowp < vTop){}
	if(total == _idx){
		$(".trendtabs__list").css("top", 0);
		_idx = 0;
	}else{
		//console.log("_idx : "+_idx);
		var topfix = $(".trendtabs__list").css("top");
		if(_idx > 9 ){
			var fix = _idx-9;
			$(".trendtabs__list").css("top",(fix * 45)* -1);
		}
	}
	shopmenu_sel(_idx);	
	//if(logYN == "Y")		insertLog(16993);	
	
}
var currList = 0;
function initLoading(){
	
	$("#shopmenu__btn_next").click(function(){	shopMenu_btn(0,"Y"); insertLog(24345);	});
	$("#shopmenu__btn_prev").click(function(){
		
		var $list = $(".trendtabs__list > li");
		var _idx = 0;
		
		$list.each(function(i,v){
			if($(this).hasClass("is-on")) _idx = i-1;
		});
		var totalCnt = $(".trendtabs__list > li").length;
		var listCnt = $(".trendtabs__list > li").length-10;
		
		//Math.abs(_currList);
		//_idx = _idx-totalCnt;
		
		//현재 높이 구함.
		var vTop = Math.abs(parseInt($(".trendtabs__list").css("top").replace("px")));
		//현재 선택된놈 * 40px이 현재 위치값
		var vNowp = _idx * 45;
		
		if(vNowp < vTop){
			$(".trendtabs__list").css("top",vNowp* -1);
		}
		
		if(_idx < 0){
			currList += (listCnt+1)*-1;
			var moveSize = currList*45;

    		if(_idx == -1){
        		currList = (listCnt+1)*-1;
        		$(".trendtabs__list").css("top",++currList*45+"px");
        	}
        	if(Math.abs(currList) == _idx)  $(".trendtabs__list").css("top",++currList*45+"px");
		}
		shopmenu_sel(_idx);
		insertLog(24345);
	});
	$(".trendtabs__list > li").click(function(){
		var inx = $(this).index();
		shopmenu_sel(inx-1);
		$(this).addClass("is-on").siblings().removeClass('is-on');
		insertLog(26273);
	});
	
	//0번째는 html 미리 넣어두는거라서 로그에 잡히지 않아서 처음 로딩때 로그 호출해준다
	try{
		var data_logno = $(".trendtabs__list > li").eq(0).attr("data-logno");
		if(data_logno ){
			insertLog(data_logno);
		}
		
	}catch(e){
		console.log(e);
	}
}
// 여행로드
var tourJson;
var tourInx = 0; 
var tourJson = new Array();
var tourSize= 8;
function loadTourCompare(){
	var loadUrl = "/main/main2018/ajax/getTravelCompare.json";
	//var loadUrl = "/main/main1003/ajax/getTravelCompare_Ajax.jsp";
	$.ajax({
		type: "GET",
		cache: false,
		url: loadUrl,
		dataType: "JSON",
		success: function(data){
		
		tourJson = shuffle(data.tourList);
		//tourSize = data.tourList.length;
		
    	var tourHtml = "";
    	tourDraw();
    	
    	 $("#tourPageBtn > button").click(function(){
    		 changeTour(($(this).index() == 0) ? -3 : 3);
    		 insertLog(24382);
    	 });
    	
		},error : function(result) {
			console.log("tour error occured. Status:"+result.status+'--Status Text:'+result.statusText+"--Error Result:" + result);
		}
    });
}
function changeTour (param) {
	//(default : 오른쪽으로 2칸)
	var moveSize = typeof param !== "undefined" ? param : 3; 
	tourInx = (tourInx + moveSize + tourSize) % tourSize;
	tourDraw();
}
function tourDraw() {
	var v = tourJson[tourInx];                                                                        
	var tourHtml = "";
	try{
		tourHtml = tourMakeHtml(v);
		v = tourJson[tourInx+1];
		tourHtml += tourMakeHtml(v);
		v = tourJson[tourInx+2];
		tourHtml += tourMakeHtml(v);
		v = tourJson[tourInx+3];
		tourHtml += tourMakeHtml(v);
		
		$("#mtour__list").html(tourHtml);
		$("img.lazy").lazyload();		
	}catch(e){
		console.log(e);
	}
}
function tourMakeHtml(v){
	var tourHtml = ""; 
	var img = "https://image.hanatour.com/usr/cms/resize/800_0/"+v.tr_imgurl;
	
	var tr_goodsubname = v.tr_goodsubname.replace("\'", "\\\'").replace("\"", "\\\"");
	var startDay = getTourDayMonth(v.tr_startday.trim());
	
	//tourHtml += "<li class='col col-4 prod__item'>";
	tourHtml += "<li class='col col-3 prod__item'>";
	tourHtml += "    <div class='thum'>";
	tourHtml += "        <a href='"+v.tr_url+"' onclick='insertLog(24383);'  target='_self' class='thum__link'>";
	tourHtml += "            <span class='thum'>";
	tourHtml += "                <span class='badge--depart'><em>"+startDay+"</em>출발</span>";
	
	try{
		if( v.tr_url.indexOf("hanatour.com") > -1  ){
			tourHtml += "			<img class=\"lazy\" src=\""+noImageStr+"\" data-original='"+img+"' alt=''>";	
		}else{
			tourHtml += "			<img class=\"lazy\" src=\""+noImageStr+"\" data-original='"+v.tr_imgurl+"' alt=''>";
		}		
	}catch(e){
		console.log(e);
	}
	tourHtml += "            </span>";
	tourHtml += "            <span class='tx_wrap'>";
	tourHtml += "                <span class='tx_shop'>"+v.strShopnm+"</span>";
	tourHtml += "                <span class='tx_sub'>"+v.tr_goodsubname+"</span>";
	tourHtml += "                <span class='tx_price'><em>"+numberFormat(v.tr_price)+"</em>원</span>";
	tourHtml += "            </span>";
	tourHtml += "        </a>";
	tourHtml += "    </div>";
	tourHtml += "</li>";
	return tourHtml; 
}
function goTourService(){
	window.open("/tour2012/Tour_Index.jsp");
	
	return false;
}
function goTourDirect(url){
	window.open(url);
	
	return false;
}
function getTourDayMonth(date) {
    var month;
    var day;
    month = date.substring(5, 7);
    day = date.substring(8, 10);
    return month + "/" + day;
}
//뉴스로그
function insertMainNewsLog(idx){
    var url = "/include/main/main2010/Inc_Main_News_Log.jsp";
    var param = "idx="+idx;

    $.ajax({
        type: "POST",
        url: url,
        data: param
    });
}
var pickJson = new Array();
function pickLoading(){
	var nowUrl = document.URL;
	
	var isDev = false;
	
	if( nowUrl.indexOf("dev.enuri.com") > -1  ){
		var ajaxUrl = "/m/api/main/getPickData.jsp";
		try{
			
			$.ajax({
					url : ajaxUrl,
					cache: false,
			    	dataType: "json",
					success : function(json) {
					
						pickJson = json["pick_kwd"];
						var $pickTab = $("#pickTab");
						
						var pickRand = Math.floor(Math.random() * (pickJson.length-1) );
						
						$.each(pickJson , function( i , v){
							if(i == pickRand) $pickTab.append("<li class='tab-item is-on'><button type='button'>"+v.kwd+"</button></li>");	
							else              $pickTab.append("<li class='tab-item'><button type='button'>"+v.kwd+"</button></li>");
						});
						
						pickHtmlMake(pickJson[pickRand]);
						
	                    $("#pickTab > li").click(function(){
	                        var _this = $(this);
	                        _this.siblings(".tab-item").removeClass("is-on");
	                        _this.addClass("is-on");
	                        
	                        var inx = _this.index();
	                        pickHtmlMake(pickJson[inx]);
	                        
	                        insertLog(24346);
	                        
	                    });
					}
			});
		
		}catch(e){console.log(e); }
			
	}else{
		
		pickJson = jsonPick["pick_kwd"];
		
		var $pickTab = $("#pickTab");
		var pickRand = Math.floor(Math.random() * (pickJson.length-1) );
		
		$.each(pickJson , function( i , v){
			if(i == pickRand) $pickTab.append("<li class='tab-item is-on'><button type='button'>"+v.kwd+"</button></li>");	
			else              $pickTab.append("<li class='tab-item'><button type='button'>"+v.kwd+"</button></li>");
		});
		
		pickHtmlMake(pickJson[pickRand]);
		
		//$("#pickTab > li").eq(pickRand).trigger("click");
		
        $("#pickTab > li").click(function(){
            var _this = $(this);
            _this.siblings(".tab-item").removeClass("is-on");
            _this.addClass("is-on");
            
            var inx = _this.index();
            pickHtmlMake(pickJson[inx]);
            insertLog(24346);
        });
	}
	
}
function pickHtmlMake(v){
	var img_path = "http://storage.enuri.info/Web_Storage/pic_upload/pick/";
	var html = "";
	
        html += "    <div class='tabs__cont'>";
        html += "        <div class='m-row'>";
        html += "            <div class='col col-3'>";
        html += "                <div class='toppick'>";
        html += "                    <div class='arrows arrows--rect'>";
        html += "                        <div class='arrows__inner'>";
        //html += "                            <button type="button" class="arr arr-prev">이전</button>
        //html += "                            <button type="button" class="arr arr-next">다음</button>
        html += "                        </div>";
        html += "                    </div>";
        html += "                    <ul class='prod__list'>";
		$.each(v.kwd_tl_dtl , function(s,o){

			if(o.dtl_tp_cd == "2"){
				
		            html += "                        <li class='prod__item' data-no='"+o.kwd_dtl_no+"' data-ktwno='"+o.ktw_no+"'  >";
		            html += "                            <a href='"+o.dtl_pc_lnk_url+"' onclick='insertLog(24347);' target='_self' class='thum__link'>";
		            
					if(o.main_view_img_url != "")		html+="<span class='thum'><img src='"+img_path+o.main_view_img_url+"' alt=''></span>";
					else								html+="<span class='thum'><img src='"+o.mobl_img_url+"' alt=''></span>";
		            
		            html += "                                <span class='tx_wrap'>";
		            html += "                                    <span class='tx_class'>구매가이드</span>";
		            html += "                                    <span class='tx_name'>"+o.kb_title+"</span>";
		            html += "                                    <span class='tx_detail'>"+o.kb_preview+"</span>";
		            html += "                                </span>";
		            html += "                            </a>";
		            html += "                        </li>";
		            return false;
			}				
			
		});
        html += "                    </ul>";
        html += "                </div>";
        
        html += "            </div>";
        
        html += "            <div class='col col-6'>";
        html += "                <!-- 일반 픽 -->";
        html += "                <div class='nrmpick'>";
        html += "                    <ul class='prod__list'>";
        
        var extCnt = 0;
        
        $.each( shuffle(v.kwd_tl_dtl)  , function(s,o){
			if(o.dtl_tp_cd == "1" || o.dtl_tp_cd == "3"){
        html += "                        <li class='prod__item' data-no='"+o.kwd_dtl_no+"' data-url='"+o.dtl_pc_lnk_url+"' >";
        html += "                            <a href='"+o.dtl_pc_lnk_url+"' onclick='insertLog(24348)' target='_self' class='thum__link'>";
        html += "                                <span class='thum'><img src='"+o.mobl_img_url+"' alt='' /></span>";
        html += "                                <span class='tx_wrap'>";
        if(o.dtl_tp_cd == "1")       	html += "    <span class='tx_class'>기획전</span>";	
        else        	html += "                    <span class='tx_class'>상품</span>";
        
        html += "                                    <span class='tx_name'>"+o.dtl_tl+"</span>";
        html += "                                    <span class='tx_detail'>"+o.dtl_sub_tl+"</span>";
		if(o.dtl_sub_tl2!=undefined && o.dtl_sub_tl2!=""){
 			html += "                                    <span class='tx_detail'>"+o.dtl_sub_tl2+"</span>";
		}
        html += "                                </span>";
        html += "                            </a>";
        html += "                        </li>";
        	extCnt++;
        	if(extCnt == 4) return false;
			}
		});	

        html += "                    </ul>";
        
        html += "                </div>";
        html += "            </div>";
        html += "        </div>";
        html += "    </div>";
        html += "</div>";
        $("#pickContainer").html(html);
}
function event_bannerLoading(){
	//var EvtUrl = AD_DOMAIN_INFO+"/enuri_PC/pc_home/O3/bundle?bundlenum=10";
	var url = AD_DOMAIN_INFO+"/enuri_PC/pc_home/A3/req";
	var _html = "";
	$.getJSON( url ,function(v){
		
		if(!v.TAG){
			_html += "<li>";
			_html += "<a href='"+v.JURL1+"' target='_blank' title=\"새 창에서 열립니다\">";
			_html += "<img src='"+v.IMG1+"' alt=''>";
			_html += "</a>";
			_html += "</li>";
			$("#evt_banner").html(_html);

		}else{
			_html += "<li id='li_zum_dive'>";
			_html += ""+v.TAG+"";
			_html += "<a href='"+v.JURL1+"' target='_blank' title='새 창에서 열립니다' style='display: none;'    >";
			_html += "<img src='"+v.IMG1+"' alt='' style='display: none;'>";
			_html += "</a>";
			_html += "</li>";
			$("#evt_banner").html(_html);

			var scriptTag = document.createElement("script");
			scriptTag.type = "text/javascript";
			scriptTag.src = v.SCRIPT_SRC;
			scriptTag.setAttribute("data-main", "js/main");
			( document.getElementsByTagName("head")[0] || document.documentElement ).appendChild( scriptTag );


		}
	});
}

var carInx = 0; 
var hitList = new Array();
var cItemSize= 0;
function userCar(){

	var loadUrl = "/main/main2018/ajax/getCarMainList.json";
 	var total = 0;
	
	$.ajax({
		type: "GET",
		url: loadUrl,
		dataType: "JSON",
		success: function(json){
			
			cItemSize = 9;
			hitList = json.data.carList;
			
		    shuffle(hitList);
		    drawCarArea();
		    
		    $("#mnewcarBtn").click(function(){
		    	changeCar(($(this).index() == 0) ? -3 : 3);
		    });
		    
		},complete: function (data) {
	    }
	});
	
}
function changeCar (param) {
	//(default : 오른쪽으로 2칸)
	var moveSize = typeof param !== "undefined" ? param : 3; 
	carInx = (carInx + moveSize + cItemSize) % cItemSize;
	drawCarArea();
}
function drawCarArea() {
	var v = hitList[carInx];                                                                        
	var carHtml = "";
	carHtml = createCarHtml(v);
	v = hitList[carInx+1];
	carHtml += createCarHtml(v); 
	v = hitList[carInx+2];
	carHtml += createCarHtml(v);
	
	$("#carAreaList").html(carHtml);
}
function createCarHtml(v){
	var outHtml = "";
	
	outHtml +="<li class='prod__item'>";
	outHtml +="    <div class='thum'>";
	outHtml +="        <a href='javascript:///' target='_self' class='thum__link'>";
	
	
	outHtml +="            <div class='logo'><img src='"+v.brnd_img_url+"' alt='현대 로고' /></div>";
	outHtml +="            <div class='thum'><img src='"+v.car_model_img_url+"' alt='' /></div>";
	outHtml +="            <div class='md_wrap'>";
	outHtml +="                <p class='md_name'>"+v.car_model_nm+"</span>";
	outHtml +="                <ul class='md_spec'>";
	outHtml +="                    <li>"+v.car_model_kn_nm+" "+v.car_model_legal_nm+"</li>";
	outHtml +="                    <li>"+v.car_model_engine_nm+"</li>";
	outHtml +="                    <li>"+v.car_model_min_dsplvl+"cc</li>";
	outHtml +="                </ul>";
	outHtml +="            </div>";
	
	outHtml +="<div class='tx_wrap'>";
	outHtml +="    <p class='tx_original'><em>"+commaNumSmall(v.car_model_min_prc)+"~"+commaNumSmall(v.car_model_max_prc)+"</em>만원</p>";
	outHtml +="<p class='tx_special'>";
	outHtml +="    <span class='tx_type'>리스/렌트</span>";
	outHtml +="    <span class='tx_price'><em>"+commaNumSmall(v.lease_prc)+"</em>만원</span>";
	outHtml +="</p>";
	outHtml +="</div>";
	
	outHtml +="        </a>";
	outHtml +="    </div>";
	outHtml +="    <div class='prod__dimm'>";
	outHtml +="        <div class='dimm__inner'>";
	outHtml +="            <p class='dimm__tit'>리스/렌트</p>";
	outHtml +="            <div class='dimm__cont'>";
	outHtml +="                <p class='tx_price'>월 <em>"+numberFormat(v.lease_prc)+"</em>원 ~</p>";
	outHtml +="                <p class='tx_sub'>(36개월 / 선납 30%기준)</p>";
	outHtml +="                <p class='tx_info'>";
	outHtml +=					v.car_model_ds_1;
	outHtml +="                </p>";
	outHtml +="            </div>";
	outHtml +="            <div class='dimm__btn'>";
	
	var url =  "http://auto.enuri.com/model/view/"+v.car_model_no;
	var url2 = "http://auto.enuri.com/model/estimate/"+v.car_model_no;
	
	outHtml +="                <a href='"+url+"' onclick='insertLog(24379);' class='btn btn__detail'>상세보기</a>";
	outHtml +="                <a href='"+url2+"' onclick='insertLog(24380);'  class='btn btn__confirm'>견적확인</a>";
	outHtml +="            </div>";
	outHtml +="        </div>";
	outHtml +="    </div>";
	outHtml +="</li>";
	return outHtml; 
}
function commaNumSmall(num) {
	var len, point, str;

	num = Math.round(num / 10000);

	num = num + "";
	point = num.length % 3
	len = num.length;

	str = num.substring(0, point);
	while (point < len) {
		if (str != "") str += ",";
		str += num.substring(point, point + 3);
		point += 3;
	}
	return str;
}
var carBannerArr = [];
var carBannerInx = 0;
var carBannerSize = 0;
function mainCarBanner() {
	var varEvtUrl = AD_DOMAIN_INFO+"/enuri_PC/pc_home/HC1/bundle?bundlenum=5";
	
	$.ajax({
		url : varEvtUrl,
		dataType : "json",
		success : function(jsonObj){
	
		if (jsonObj != undefined) {
			if (jsonObj.length > 1) {
				var sortingField = "SORT";
				jsonObj.sort(function(a, b) { // 오름차순
				    return a[sortingField] - b[sortingField];
				});
			}
			carBannerArr = jsonObj;
			
			drawCarBannerArea(carBannerInx);
			carBannerSize = carBannerArr.length;
			
			if(carBannerSize < 2){
				$("#carBannerArrow").hide();
			}
			
			$("#carBannerArrow > button").click(function(){
				changeCarBanner(($(this).index() == 0) ? -1 : 1);	
				insertLog(25443);
			});
			
		}
		
		},error: function(request,status,error){
			objEvtProm.html(""); 
      	}
	
	});
}
function changeCarBanner (param) {
	//(default : 오른쪽으로 2칸)
	var moveSize = typeof param !== "undefined" ? param : 3; 
	carBannerInx = (carBannerInx + moveSize + carBannerSize) % carBannerSize;
	drawCarBannerArea(carBannerInx);
}

function drawCarBannerArea(page){
	var varHtml = "";
	var o = carBannerArr[page];
	
	varHtml += "<li class='bnr__item'>";
	varHtml += "	<a href='"+o["JURL1"]+"' onclick='insertLog(24377);' >";
	varHtml += "		<img src='"+o["IMG1"]+"' alt=''>";
	varHtml += "	</a>";
	varHtml += "</li>";
	$("#mnewcar__bnr").html(varHtml);
}
var popGoodsArr = new Array();
var pItemSize= 0;
var pGoodsIdx = 0;
function mainPopGoodsMake(){

	var nowUrl = document.URL;
	if( nowUrl.indexOf("dev.enuri.com") > -1  ){
		var ajaxUrl = "/wide/main/ajax/comment_pop_scate_goods_ajax.jsp";
		$.ajax({
	        type: "GET",
	        url: ajaxUrl,
	        async: false,
	        dataType:"JSON",
	        success: function(json){
	        	try{
					popGoodsArr = shufflePop(json);
					pItemSize= popGoodsArr.length;
				    drawGoodsArea();
				}catch(e){
					console.log("main상품로딩오류"+e);
				}
	        },complete : function(data) {
				$("#pop_arrow").find("button").click(function(){
					var page = ($(this).index() == 0) ? -8 : 8;
					changeGoods(page);
		    	});
	        }
	    });
	}else{
		if(jsonPopGoods){
			popGoodsArr = shufflePop(jsonPopGoods);
			pItemSize= popGoodsArr.length;
		    drawGoodsArea();
		    
		    $("#pop_arrow").find("button").click(function(){
				var page = ($(this).index() == 0) ? -8 : 8;
				changeGoods(page);
				insertLog(24359);
			});
		}
	}
}
function drawGoodsArea() {
    var priceChkArr = new Array();
	
	var v = popGoodsArr[pGoodsIdx];
	priceChkArr.push(v);
	
	var page = Math.floor(pGoodsIdx/6);
	
	var pagehtml = "<em>"+(page+1)+"</em> / "+popGoodsArr.length/6;
	$(".tx_mgoods_page").html(pagehtml);
	
	var goodsHtml = "";
	
	goodsHtml = popGoodsTmp(v);
	v = popGoodsArr[pGoodsIdx+1];
	priceChkArr.push(v);
	
	goodsHtml += popGoodsTmp(v);
	v = popGoodsArr[pGoodsIdx+2];
	priceChkArr.push(v);
    
	goodsHtml += popGoodsTmp(v); 
	v = popGoodsArr[pGoodsIdx+3];
	priceChkArr.push(v);
	
	goodsHtml += popGoodsTmp(v);
	v = popGoodsArr[pGoodsIdx+4];
	priceChkArr.push(v);
    
	goodsHtml += popGoodsTmp(v);
	v = popGoodsArr[pGoodsIdx+5];
	priceChkArr.push(v);
	
	goodsHtml += popGoodsTmp(v);
	v = popGoodsArr[pGoodsIdx+6];
	priceChkArr.push(v);
	
	goodsHtml += popGoodsTmp(v);
	v = popGoodsArr[pGoodsIdx+7];
	priceChkArr.push(v);
    
	goodsHtml += popGoodsTmp(v);
	$("#popGoodsList").html(goodsHtml);
	
	getPriceHis(priceChkArr);
}
function popGoodsTmp(v){
	
	var goodsHtml = "";
	
	//goodsHtml +="<li class='col col-4 nowprod__item'  data-id='"+v.modelno+"' data-price='"+v.minprice+"'  >";
	goodsHtml +="<li class='col col-3 nowprod__item'  data-id='"+v.modelno+"' data-price='"+v.minprice+"'  >";
	goodsHtml +="    <a href='detail.jsp?modelno="+v.modelno+"' onclick='insertLog(24358);' target='_self' class='thum__link'>";
	goodsHtml +="        <span class='thum'>";
	goodsHtml +="            <img src='"+v.strImgsrc+"' alt=''>";
	goodsHtml +="            <span class='badge__msg'></span>";
	goodsHtml +="        </span>";
	goodsHtml +="        <span class='tx_wrap'>";
	
	if(v.modelno == "37117674"){
		goodsHtml +="            <span class='tx_shop'>이랜드몰</span>";
	}else{
		goodsHtml +="            <span class='tx_shop'>"+v.shopnm+"</span>";
	}
	goodsHtml +="            <span class='tx_name'>"+v.modelnm+"</span>";
	
	goodsHtml +="            <span class='tx_price'>최저가 <em>"+numberFormat(v.minprice)+"</em>원</span>";
	goodsHtml +="            <span class='tx_emoney'><i class='ico_e'>e머니</i>최대 "+v.rewardRate+"% 적립</span>";
	goodsHtml +="        </span>";
	goodsHtml +="    </a>";
	goodsHtml +="    <a href='detail.jsp?modelno="+v.modelno+"' class='btn__comp'>가격비교 <em>"+v.mallcnt+"</em></a>";
	goodsHtml +="    <div class='scope'>";
    goodsHtml +="    <i class='ico ico--scope'></i>";
    goodsHtml +="    <p class='tx_aval'>"+v.bbs_point_avg+"점</p>";
    goodsHtml +="    <p class='tx_cnt'>("+v.all_cnt+"건)</p>";
    goodsHtml +="    </div>";
	goodsHtml +="</li>";
	return goodsHtml; 
}
function changeGoods (param) {
	//(default : 오른쪽으로 2칸)
	var moveSize = typeof param !== "undefined" ? param : 6; 
	pGoodsIdx = (pGoodsIdx + moveSize + pItemSize) % pItemSize;
	drawGoodsArea();
}
function getPriceHis(popGoodsList){
	
	var msg1 = "<span class='badge__msg'><span class=\"tx_msg\">지난주 대비<br><em>최저가 하락</em></span></span>";
	var msg2 = "<span class='badge__msg'><span class=\"tx_msg\">최근 한달간<br><em>가장 최저가</em></span></span>";
	    
	var modelnos = new Array();
	var minprices = new Array();
	$.each(popGoodsList , function(i,v){
		modelnos.push(v.modelno);
		minprices.push(v.minprice);
	});
	
	var ajaxUrl = "/m/api/main/priceHisData_ajax.jsp";
	
	$.ajax({
        type: "GET",
        url: ajaxUrl+"?modelnos="+modelnos+"&minprices="+minprices,
        dataType:"JSON",
        success: function(json){
        	
        	$.each(json , function(i,v){
        		
        		$("#popGoodsList > li ").each( function(s,o){
        			var modelno = $(this).attr("data-id");
        			var price = $(this).attr("data-price");
        			
        			if(v.modelno == modelno){
        				if(v["priceWeek"]){
        					
        					if( v["priceWeek"]["price"] >= price  ){
            					
            					var per = 100 - (price / v.priceWeek.price  * 100);
            					if(per >= 5){
            						$(this).find("a > span.thum").append(msg1);
            					}
            				}else{
            					if(v.showMinPrice > price ){
                					//$(this).children().prepend(msg2);
            						$(this).find("a > span.thum").append(msg2);
                				}	
            				}        					
        				}
        			}
        		});
        	});
        },error: function (e) {
            console.log(e);
        }
    }); 
}
function numberFormat(x) {    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
function shufflePop(sourceArray) {
	for (var i = 0; i < sourceArray.length - 1; i++) {
        var j = i + Math.floor(Math.random() * (sourceArray.length - i));
        var temp = sourceArray[j];
        sourceArray[j] = sourceArray[i];
        sourceArray[i] = temp;
    }
	var tempGoods = new Array();
	var tempSize = 40;
	
	if(sourceArray.length > 48)		tempSize = 48;
	else if(sourceArray.length > 40 && sourceArray.length < 48 ) tempSize = 40;
	else if(sourceArray.length < 40 && sourceArray.length >= 32 ) tempSize = 32;
	
	$.each(sourceArray,function(i,v){		if(i < tempSize )	tempGoods.push(v);	});
    return tempGoods;
}
var enuriPcBannerArr = [];
var pcBannerInx = 0;
var pcBannerSize = 0;
function getMainEventBanner() {
	var varEvtUrl = AD_DOMAIN_INFO+"/enuri_PC/pc_home/OJ/bundle?bundlenum=5";
	
	$.ajax({
		url : varEvtUrl,
		dataType : "json",
		success : function(jsonObj){
	
		if (jsonObj != undefined) {
			if (jsonObj.length > 1) {
				var sortingField = "SORT";
				jsonObj.sort(function(a, b) { // 오름차순
				    return a[sortingField] - b[sortingField];
				});
			}
			enuriPcBannerArr = jsonObj;
			
			enuriPcBanner(pcBannerInx);
			pcBannerSize = enuriPcBannerArr.length;
			
			if(pcBannerSize == 0){
				$("#pcBannerArrows").hide();
			}
			

			$("#pcBannerNext").click(function(){
				if(pcBannerSize == pcBannerInx+1)	pcBannerInx = 0;
				else 								pcBannerInx = pcBannerInx+1;
				enuriPcBanner(pcBannerInx);
			});
			$("#pcBannerPrev").click(function(){
				if(0 > pcBannerInx-1)	pcBannerInx = pcBannerSize-1;
				else 					pcBannerInx = pcBannerInx-1;

				enuriPcBanner(pcBannerInx);
			});
			
		}
		
		},
		error: function(request,status,error){
			objEvtProm.html(""); 
      	}
	
	});
}
function enuriPcBanner(page){
	
	var varHtml = "";
	var o = enuriPcBannerArr[page];
	
	varHtml += "<li class='bnr__item'>";
	varHtml += "	<a href='"+o["JURL1"]+"' target='_blank'  onclick='insertLog(24368);' >";
	varHtml += "		<img src='"+o["IMG1"]+"' alt=''>";
	varHtml += "	</a>";
	varHtml += "</li>";
	
	$("#pc_banner_list").html(varHtml);
	
}
function goEnuriPcBannerLink(type, link) {

    if(type=="1") {
        window.open(link);
    }else if(type=="2") {
    	window.open(link);
    }else if(type=="3") {
        window.detailWin = window.open(link,"detailMultiWin","width=804,height="+window.screen.height+",left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
        window.detailWin.focus();
    }
}
function enuripcTabBind(){
	$("#enuripcTab > li > button").click(function(){
		var inx = $(this).parent().index();
		loadEnuripcMore(inx+1);
		$("#enuripcTab li ").removeClass("is-on");
		$(this).parent().addClass("is-on");
		insertLog(24367);
	});
}
var enuripcjson;
function loadEnuripcMore(cate){
	if(enuripcjson==null)	getEnuripcDate(cate);	
	else					enuripcListMake(cate);
}

function getEnuripcDate(cate){
	var nowUrl = document.URL;
    var ajaxUrl = "";
    if( nowUrl.indexOf("dev.enuri.com") > -1 ) ajaxUrl = "/enuripc/admin/ajax/enuripc_goods_list_ajax.jsp?pType=5";
    else ajaxUrl = "/main/main2018/ajax/enuripc_goods_list_ajax.json";
    //else ajaxUrl = "/enuripc/admin/ajax/enuripc_goods_list_ajax.jsp?pType=5";
	$.ajax({
		url : ajaxUrl,
		dataType : "json",
		success : function(result){
			enuripcjson = result;
			enuripcListMake(cate);
			setEnuripcNextPrev();
		}
	});
} 

function enuripcListMake(cate){
	var enuripcHtml = "";
	if(enuripcjson){
		$("#pcGoodsList").empty();
		//데이터가 각탭에서 2개 이하이면 조립 PC 섹션 비노출
		if(enuripcjson.sr_home.length<2 || enuripcjson.sr_game.length<2 || enuripcjson.sr_multi.length<2 || enuripcjson.sr_pop.length<2){
			$(".msection.msection__enuripc").hide();
		}
		if( cate  == 1 ){
			if(enuripcjson.sr_home){
				enuripcHtml = enuripcTemplate(enuripcjson.sr_home,1);
				$("#pcGoodsList").append(enuripcHtml);
			}
		}else if( cate  == 2 ){
			if(enuripcjson.sr_multi){
				enuripcHtml = enuripcTemplate(enuripcjson.sr_multi,2);
				$("#pcGoodsList").append(enuripcHtml);
			}
		}else if( cate  == 3 ){
			if(enuripcjson.sr_game){
				enuripcHtml = enuripcTemplate(enuripcjson.sr_game,3);
				$("#pcGoodsList").append(enuripcHtml);
			}
		
		}else if( cate  == 4 ){
			if(enuripcjson.sr_pop){
				enuripcHtml = enuripcTemplate(enuripcjson.sr_pop,4);
				$("#pcGoodsList").append(enuripcHtml);
			}
		}
	}
}
function enuripcTemplate(json,cate){
	var jsonHtml = "";
	$.each(json,function(i,v){
		
		jsonHtml += "<li class='prod__item' >";
		if(cate==4){
			jsonHtml += "<div class='thum'>";
			jsonHtml += "    <a href='http://www.enuri.com/enuripc/detailSub.jsp?pd_no="+v.pd_no+"' onclick='insertLog(24369);' target='_self' class='thum__link' >";
			jsonHtml += "        <span class='thum'>";
			if(v.modelImgPath.length>0){
				jsonHtml += "		<img src=\'"+v.modelImgPath+"' alt=\"\">";
			}else{
				jsonHtml += "		<img src=\'http://imgenuri.enuri.gscdn.com/images/home/thum_none.gif' alt=\"\">";
			}
			jsonHtml += "		 </span>";
			jsonHtml += "        <span class='tx_wrap'>";
			//jsonHtml += "            <span class='tx_shop'>민석시스템</span>";
			jsonHtml += "            <span class='tx_detail'>"+v.pd_name+"</span>";
			jsonHtml += "            <span class='tx_price'><em>"+numberFormat(v.minprice)+"</em>원</span>";
			jsonHtml += "        </span>";
			jsonHtml += "    </a>";
			jsonHtml += "</div>";
			
		}else{

			jsonHtml += "<div class='thum'>";
	        jsonHtml += "    <a href='http://www.enuri.com/enuripc/detailSp.jsp?sy_no="+v.sy_no+"' onclick='insertLog(24369);' target='_self' class='thum__link'  >";
	        jsonHtml += "        <span class='thum'>";
			if(v.home_img.length>0){
				jsonHtml += "		<img src=\'"+STORAGE_ENURI_COM+v.home_img+"' alt=\"\">";
			}else{
				jsonHtml += "		<img src=\'http://imgenuri.enuri.gscdn.com/images/home/thum_none.gif' alt=\"\">";
			}
			jsonHtml += "</span>";
	        
	        jsonHtml += "        <span class='tx_wrap'>";
	        //jsonHtml += "            <span class='tx_shop'>"++"</span>";
	        jsonHtml += "            <span class='tx_detail'>"+v.spec+"</span>";
	        jsonHtml += "            <span class='tx_price'><em>"+numberFormat(v.price)+"</em>원</span>";
	        jsonHtml += "        </span>";
	        jsonHtml += "    </a>";
	        jsonHtml += "</div>";
			
			var sub_v = v.enuripcSubgoodsList;
			
			//<!-- defulat : 숨김, hover : 노출 -->
			jsonHtml += "<div class='prod__dimm'>";
			jsonHtml += "    <div class='dimm__inner'>";
			jsonHtml += "        <p class='dimm__tit'>"+v.goods_nm+"</p>";
			jsonHtml += "        <ul class='dimm__list'>";
			$.each(sub_v, function(idx, g_data){
				if(idx<7){
					jsonHtml += "	<li>["+g_data["cate_name"]+"]</span> <span class=\"td\">"+g_data["modelName"]+"</li>";
				}
			});
			jsonHtml += "        </ul>";
			jsonHtml += "        <div class='dimm__btn'>";
			jsonHtml += "            <a href='http://www.enuri.com/enuripc/requestEstimateList.jsp'   class='btn btn__counsel'>견적상담</a>";
			jsonHtml += "            <a href='http://www.enuri.com/enuripc/detailSp.jsp?sy_no="+v.sy_no+ "'  class='btn btn__confirm'>구매하기</a>";
			jsonHtml += "        </div>";
			jsonHtml += "    </div>";
			jsonHtml += "</div>";
			
		}
		jsonHtml += "</li>";
		if(i > 0)	return false;
	});
	return  jsonHtml; 
}

function setEnuripcNextPrev(){
	$(".mstripe.menuripcbox__btn.slide__btn.slide__btn--prev").click(function(){
		
		$("#enuripcTab > li > a ").each(function(i , v){
			var cls = $(this).attr("class");
			if(cls.indexOf("is-on") > 0){
				var selnum = (i+1)-1;
				if(selnum == 0){
					$(".tab__enuripc--4").find("a").trigger("click");
					return false;
				}
				$(".tab__enuripc--"+selnum).find("a").trigger("click");
				return false;
			}
		});
	});
	
	$(".mstripe.menuripcbox__btn.slide__btn.slide__btn--next").click(function(){
		
		$("#enuripcTab > li > a ").each(function(i , v){
			var cls = $(this).attr("class");
			if(cls.indexOf("is-on") > 0){
				var selnum = (i+1)+1;
				if(selnum == 5){
					$(".tab__enuripc--1").find("a").trigger("click");
					return false;
				}
				$(".tab__enuripc--"+selnum).find("a").trigger("click");
				return false;
			}
		});
	});
}
var suggestInx = 0; 
var suggestJson = new Array();
var suggestMyJson = new Array();
var suggestSize= 0;
function mainSuggestGoodsMake(){

    var ajaxUrl = "/wide/main/ajax/main_resentgoods.jsp";
    
    $.ajax({
		url : ajaxUrl,
		dataType : "json",
		success : function(result){
			
			if(result["suggest_list"]){
				$("#mysuggestArea").show();
				suggestJson = shuffle(result["suggest_list"]);
				suggestSize = result["suggest_list"].length;
				
				if( suggestSize >= 8 ) suggestSize = 8 ;
				else if( suggestSize > 8 && suggestSize < 24 ) suggestSize = 16; 
				
				suggestMyJson = result["myGoods"];
				
				if( suggestSize < 2 ) {
					$("#mysuggestArea").hide();
					return false;
				}
				
				$.each(result["cateList"], function(i,v){
					var html = "<li class='tab-item'><button type=\"button\" data-cate='"+v["scate_cd"]+"' data-specyn="+v["spec_yn"]+">"+v["catenm"]+"</button></li>";				
					$("#related_cate").append(html);				
				});
			
				var html = "";
				
				html +="<div class='tabs__cont'>";
				    html +="<div class='prodbox'>";
				    html +="    <div class='arrows arrows--rect'>";
				    html +="        <div class='arrows__inner' id='related_arrow'>";
				    html +="            <button type='button' class='arr arr-prev'>이전</button>";
				    html +="            <button type='button' class='arr arr-next'>다음</button>";
				    html +="        </div>";
				    html +="    </div>";
				    html +="    <ul class='m-row related__list' id='all_related_list'></ul>";
				    html +="</div>";
			    html +="</div>";
			    $("#suggestList").html(html);
				changeSuggest(0);
			}
			
			$("#related_cate > li").click(function(){
				
				$(this).addClass("is-on").siblings().removeClass('is-on');
				var specyn = $(this).children().attr("data-specyn");
				
				if( specyn == "A" ){
					$("#suggestList").html(html);
					changeSuggest(0);
				}else{
					var cate = $(this).children().attr("data-cate");
					//var modelno = "";
					
					$.each(suggestMyJson,function(i,v){
					//$.each(result["resentlist"],function(i,v){
						var suggest_cate = v["ca_code"].substr(0,4);
						var myModelno = v["myModelno"];
						
						if( cate.indexOf(suggest_cate) > -1 ){
							modelno	= v["modelno"];
							return false;
						}
					});
					spanCompare(cate,modelno,specyn);
				}
				insertLog(24355);
			});
		}
	});
}
function changeSuggest (param) {
	//(default : 오른쪽으로 2칸)
	var moveSize = typeof param !== "undefined" ? param : 4; 
	suggestInx = (suggestInx + moveSize + suggestSize) % suggestSize;
	suggestDraw();
}
function suggestDraw() {
	var v = suggestJson[suggestInx];                                                                        
	var html = "";
	try{
			html += suggestMakeHtml(v);
			v = suggestJson[suggestInx+1];
			html += suggestMakeHtml(v);
			v = suggestJson[suggestInx+2];
			html += suggestMakeHtml(v);
			v = suggestJson[suggestInx+3];
			html += suggestMakeHtml(v);

		$("#all_related_list").html(html);
		
		$("img.lazy").lazyload();
	}catch(e){
		console.log(e);
		$("#mysuggestArea").hide();
	}
}
function suggestMakeHtml(v){
	
	var html = "";
	
	if(v["modelno"]){

		var url = "detail.jsp?modelno="+v["modelno"];
		
		html += "<li class='col col-3 related__item' data-modelno='"+v["modelno"]+"' data-myflag='"+v["myModelno"]+"'>";
	    html += "    <a href='"+url+"' onclick='insertLog(24356);'  target='_self' class='thum__link'>";
	    html += "        <span class='thum'><img src='"+v["strImgsrc"]+"' alt='' ></span>";
	    html += "        <span class='tx_wrap'>";
	    html += "            <span class='tx_shop'>"+v["shopnm"]+"</span>";
	    html += "            <span class='tx_name'>"+v["modelnm"]+"</span>";
	    html += "            <span class='tx_price'>최저가 <em>"+numberFormat(v["minprice"])+"</em>원</span>";
	    html += "        </span>";
	    html += "    </a>";
	    html += "    <a href='"+url+"' onclick='insertLog(24356);' class='btn__comp'>가격비교 <em>"+v["mallcnt"]+"</em></a>";
	    html += "    <div class='scope'>";
	    html += "        <i class='ico ico--scope'><!--별점--></i>";
	    html += "        <p class='tx_aval'>"+v["bbs_point_avg"]+"점</p>";
	    html += "        <p class='tx_cnt'>("+v["bbs_num"]+"건)</p>";
	    html += "    </div>";
	    html += "</li>";
	
	}				
	return html; 
	
} 
//비교제안여부
function spanCompare(cate,modelno,specyn){
	//스펙없음
	if(specyn > 0){
		sCatePopMake(cate,modelno,specyn);
	}else{ //스펙사용
		vipSpecCompareMake(cate,modelno,specyn);
	}
}
function vipSpecCompareMake(cate,modelno,specyn){

	var ajaxUrl = "/wide/main/ajax/getSpecCompare.jsp?modelno="+modelno+"&type=S";
	
    $.ajax({
		url : ajaxUrl,
		dataType : "json",
		success : function(result){
			
			$("#suggestList").empty();
			
			var myHtml = "";
			var cnt = 0;
			
			var html = "";
			html += "<div class='tabs__cont' >";
				html += "<div class='prodbox prodbox--sm-cate'>";
				
				html += "</div>";
			html += "</div>";
	        
	        $("#suggestList").append(html);
			
	        html = "    <ul class='tabs tabs--txt' id='vipSpecTabs'>";
	        
	        if(result["totalArray"].length > 0){
	        html += "        <li class='tab-item is-on'><button type='button' id='suggest_pop_btn'>인기상품</button></li>";
	        }
	        if(result["simArray"].length > 0){
	        html += "        <li class='tab-item'><button type='button' id='suggest_sam_btn' >비슷한가격대</button></li>";
	        }
	        if(result["newArray"].length > 0){
	        	html += "    <li class='tab-item'><button type='button' id='suggest_new_btn'>신상품</button></li>";	
	        }
	        html += "    </ul>";
	        
	        
	        $("#suggestList > div > div").append(html);
	        
	        html = "    <ul class='m-row compare__list' id='compare__list_pop' >";
	        $.each( result["totalArray"] , function(i,v){
	        	
	        	if( cnt == 6 ) return false;
	        	
	        	var url = "detail.jsp?modelno="+v["modelno"];
	        	
	        	if(modelno == v["modelno"] && myHtml !="") return true;
	        	
	        	html += "<li class='col col-4 compare__item'>";
	            html += "    <a href='"+url+"' onclick='insertLog(24356);' target='_self' class='thum__link'>";
	            html += "        <span class='thum'><img src='"+v["origin_img"]+"' alt=''></span>";
	            html += "        <span class='tx_wrap'>";
	            html += "            <span class='tx_shop'>"+v["shopnm"]+"";
	            	
	            if(modelno == v["modelno"])	html +="<i class='badge'>내가본상품</i>";
	            
	            html += 				"</span>";
	            html += "            <span class='tx_name'>"+v["modelnm"]+"</span>";
	            html += "            <span class='tx_price'>최저가 <em>"+numberFormat(v["minprice"])+"</em>원</span>";
	            html += "        </span>";
	            html += "    </a>";
	            html += "</li>";
	        	
	            if(modelno == v["modelno"] && myHtml ==""){

		        	var url = "detail.jsp?modelno="+v["modelno"];
		        	
		        	myHtml += "<li class='col col-4 compare__item'>";
		        	myHtml += "    <a href='"+url+"' onclick='insertLog(24356);'  target='_self' class='thum__link'>";
		        	myHtml += "        <span class='thum'><img src='"+v["origin_img"]+"' alt=''></span>";
		            myHtml += "        <span class='tx_wrap'>";
		            if(modelno == v["modelno"]){
		            	myHtml += "            <span class='tx_shop'>"+v["shopnm"]+" <i class='badge'>내가본상품</i></span>";
		            }
		            myHtml += "            <span class='tx_name'>"+v["modelnm"]+"</span>";
		            myHtml += "            <span class='tx_price'>최저가 <em>"+numberFormat(v["minprice"])+"</em>원</span>";
		            myHtml += "        </span>";
		            myHtml += "    </a>";
		            myHtml += "</li>";
	            	
	            }
	            cnt++;
	            
	        });
	        html += "	</ul>";
	        
	        $("#suggestList > div > div").append(html);
	        
	        html = "    <ul class='m-row compare__list' id='compare__list_sam' style='display:none' >";
	        
	        var simCnt = 0;
	        
	        if(result["simArray"].length > 0){
		        $.each( result["simArray"] , function(i,v){
		        	
		        	var url = "detail.jsp?modelno="+v["modelno"];
		        	
		        	if(i == 0) html += myHtml;
		        	if(v["modelno"] == modelno) return true;
		        	if(simCnt > 4) return false; 
		        	
		        	html += "<li class='col col-4 compare__item'>";
		            html += "    <a href='"+url+"' onclick='insertLog(24356);'  target='_self' class='thum__link'>";
		            html += "        <span class='thum'><img src='"+v["origin_img"]+"' alt=''></span>";
		            html += "        <span class='tx_wrap'>";

		            html += 			"<span class='tx_shop'>"+v["shopnm"]+"";
	            	
		            if(modelno == v["modelno"])	html +="<i class='badge'>내가본상품</i>";
		            
		            html += 			"</span>";
		            
		            html += "            <span class='tx_name'>"+v["modelnm"]+"</span>";
		            html += "            <span class='tx_price'>최저가 <em>"+numberFormat(v["minprice"])+"</em>원</span>";
		            html += "        </span>";
		            html += "    </a>";
		            html += "</li>";
		            
		            simCnt++;
		            
		        });
	        }
	        html += 	"</ul>";
	        
	        $("#suggestList > div > div").append(html);
	        
	        html = "    <ul class='m-row compare__list' id='compare__list_new' style='display:none' >";
	        var newCnt = 0;
	        if(result["newArray"].length > 0){
		        $.each( result["newArray"] , function(i,v){
		        	
		        	var url = "detail.jsp?modelno="+v["modelno"];
		        	
		        	if(i == 0)	html += myHtml;
		        	if(v["modelno"] == modelno) return true;
		        	if(newCnt > 4) return false;
		        	
		        	html += "<li class='col col-4 compare__item'>";
		            html += "    <a href='"+url+"' onclick='insertLog(24356);' target='_self' class='thum__link'>";
		            html += "        <span class='thum'><img src='"+v["origin_img"]+"' alt=''></span>";
		            html += "        <span class='tx_wrap'>";
		            html += 			"<span class='tx_shop'>"+v["shopnm"]+"";
	            	
		            if(modelno == v["modelno"]){
		            		html +="<i class='badge'>내가본상품</i>";
	            	}
		            
		            html += 			"</span>";
		            
		            html += "            <span class='tx_name'>"+v["modelnm"]+"</span>";
		            html += "            <span class='tx_price'>최저가 <em>"+numberFormat(v["minprice"])+"</em>원</span>";
		            html += "        </span>";
		            html += "    </a>";
		            html += "</li>";
		            
		            newCnt++;
		            
		        });
	        }
	        html += 	"</ul>";
	        $("#suggestList > div > div").append(html);
	        
	         
		}
    });
}
function sCatePopMake(cate,modelno,specyn){

	var ajaxUrl = "/wide/main/ajax/main_spec_compare.jsp?cate="+cate+"&modelno="+modelno;
    $.ajax({
		url : ajaxUrl,
		dataType : "json",
		success : function(result){
			
			var html = "";
			
			html += "<div class='tabs__cont' >";
			
			html += "<div class='prodbox prodbox--sm-cate'>";
	        html += "    <div class='arrows arrows--rect'>";
	        html += "        <div class='arrows__inner' id='myCatePopArrows'>";
	        html += "            <button type='button' class='arr arr-prev'>이전</button>";
	        html += "            <button type='button' class='arr arr-next'>다음</button>";
	        html += "        </div>";
	        html += "    </div>";
	        
	        var bpage=0;
	        
	        $.each( result["suggest_list"] , function(i,v){
	        	
	        	if( i%5 == 0 ) {
	        		var isshow = "";
	        		if(i==0) isshow = "style='display:'";
	        		else 	 isshow = "style='display:none'";
	        		html += "<ul class='m-row compare__list' id='compare__list"+(bpage++)+"' "+isshow+">";
	        		html += mySuggestGoods(cate);
				}
	        	
	        	var url = "detail.jsp?modelno="+v["modelno"];
	        	
	        	html += "<li class='col col-4 compare__item'>";
	            html += "    <a href='"+url+"' target='_self' class='thum__link'>";
	            html += "        <span class='thum'><img src='"+v["strImgsrc"]+"' alt=''></span>";
	            html += "        <span class='tx_wrap'>";
	            html += "            <span class='tx_shop'>"+v["shopnm"]+"<span>";
	            
	            html += "            <span class='tx_name'>"+v["modelnm"]+"</span>";
	            html += "            <span class='tx_price'>최저가 <em>"+numberFormat(v["minprice"])+"</em>원</span>";
	            html += "        </span>";
	            html += "    </a>";
	            html += "</li>";
	            
	            if( i!=0 && (i+1)%5 == 0 ){
	            	html += "</ul>"; 
				}
	        	
	        });
	        
	        html += "</div>";
	        html += "</div>";
	        $("#suggestList").html(html);   
	        
	        var cnt = 0;
	        $("#myCatePopArrows > button").click(function(){
	        	
	        	var cls = $(this).attr("class");
	        	$(".m-row.compare__list").hide();
	        	
	        	if(cls.indexOf("prev") > -1){
	        		cnt--;
	        		if(cnt < 0)	cnt = 2;
	        		$("#compare__list"+cnt).show();
	        	}else{
	        		cnt++;
	        		if(cnt>2)	cnt = 0;
	        		$("#compare__list"+cnt).show();
	        	}
	        });
		}
    });
}
function mySuggestGoods(cate){
	var html = "";
	$.each( suggestMyJson , function(i,v){
		
		if(v["ca_code"].indexOf(cate) > -1){
			
			var url = "detail.jsp?modelno="+v["modelno"];
			
			html += "<li class='col col-4 compare__item'>";
		    html += "    <a href='"+url+"' target='_self' class='thum__link'>";
		    html += "        <span class='thum'><img src='"+v["strImgsrc"]+"' alt=''></span>";
		    html += "        <span class='tx_wrap'>";
		    
		    html += "            <span class='tx_shop'>"+v["shopnm"];
		    html += 				"<i class='badge'>내가본상품</i>";
		    html += 			"<span>";
		    
		    html += "            <span class='tx_name'>"+v["modelnm"]+"</span>";
		    html += "            <span class='tx_price'>최저가 <em>"+numberFormat(v["minprice"])+"</em>원</span>";
		    html += "        </span>";
		    html += "    </a>";
		    html += "</li>";
		    return false;
		}
	});
	return html;
}
function shuffle(o){ //v1.0
    for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x){};
    return o;
};
var frontArr = [];
var itemSize = 0;
var selectedIdx = 0;
//var intervalProc; // 자동롤링 프로세스
function mainExhibitionLoading(){
	//var loadUrl = "/main/main2018/ajax/mainExhibition.json";
	//var loadUrl = AD_DOMAIN_INFO+"/enuri_PC/pc_home/O3/bundle?bundlenum=10";
	
	var loadUrl = AD_DOMAIN_INFO+"/enuri_PC/pc_home/O3/bundle?bundlenum=10";
	
	try{
		$.ajax({
				url : loadUrl,
				cache: false,
		    	dataType: "json",
				success : function(data) {
					
					if (data != undefined) {

						if (data.length > 1) {
							var sortingField = "SORT";
							data.sort(function(a, b) { // 오름차순
							    return a[sortingField] - b[sortingField];
							});
						}
					    frontArr = data;
					    itemSize = frontArr.length;
					    drawArea();
					}
				    $("#extArrowBtn").click(function(){
				    	
				    	changeExh(($(this).index() == 0) ? -3 : 3);
				    	//resetInterval();
				    	insertLog(24361);
				    });
				    
				},error: function (xhr, ajaxOptions, thrownError) {}
		});
	}catch(e){
		$(".msection.msection__enuripc").hide();
	}
}
function drawArea() {
    var outHtml = "";
	var v = frontArr[selectedIdx];

	outHtml += "<li class=\"evt__item\">";
			outHtml += "<a href='"+v.JURL1+"' target='_blank' onclick='insertLog(26393);' title=\"새 창에서 열립니다\"  >";
			outHtml += "<img src='"+v.IMG1+"' alt=''>";
		outHtml += "</a>";
	outHtml += "</li>";
	
	v = frontArr[selectedIdx + 1];
	outHtml += "<li class=\"evt__item\">";
	outHtml += "<a href='"+v.JURL1+"' target='_blank'  onclick='insertLog(26393);' title=\"새 창에서 열립니다\"  >";
	outHtml += "<img src='"+v.IMG1+"' alt=''>";
	outHtml += "</a>";
	outHtml += "</li>";
	
	v = frontArr[selectedIdx + 2];
	outHtml += "<li class=\"evt__item\">";
	outHtml += "<a href='"+v.JURL1+"' target='_blank' onclick='insertLog(26393);' title=\"새 창에서 열립니다\"  >";
	outHtml += "<img src='"+v.IMG1+"' alt=''>";
	outHtml += "</a>";
	outHtml += "</li>";
	
	$("#ext_list").html(outHtml);
}
//기획전 카드 변경 
function changeExh (param) {
	//(default : 오른쪽으로 2칸)
	var moveSize = typeof param !== "undefined" ? param : 3; 
	selectedIdx = (selectedIdx + moveSize + itemSize) % itemSize;
	drawArea();
	
}

global_bannerLoading();
loadGlobal();

var gBundleData = [];
var gbannerInx = 0;
function global_bannerLoading(){
	var varEvtUrl = AD_DOMAIN_INFO+"/enuri_PC/pc_home/O2/bundle?bundlenum=10";
	
	$.getJSON( varEvtUrl , function(json){
			
			gBundleData = json.sort(function(a,b){	return a.SORT - b.SORT; });
			globalBannerMake(0);
			var size = gBundleData.length;
			
			$("#globalBannerNext").click(function(){
				if(size == gbannerInx+1)	gbannerInx = 0;
				else 								gbannerInx = gbannerInx+1;
				globalBannerMake(gbannerInx);
				
			});
			$("#globalBannerPrev").click(function(){
				
				if(0 > gbannerInx-1)	gbannerInx = size-1;
				else 								gbannerInx = gbannerInx-1;
				globalBannerMake(gbannerInx);
				
			});
			
			if( size == 1 ){
				$("#globalBannerPrev").hide();
				$("#globalBannerNext").hide();
			}
	});
}
function globalBannerMake(page){
	var _html = "";
	 var v = gBundleData[page];

	if (typeof v.JURL1 !== "undefined") {
	 _html += "<li class='bnr__item'>";
		 _html += "<a href='"+v.JURL1+"' onclick='insertLog(24373);' target='_blank' title=\"새 창에서 열립니다\">";
		 	_html += "<img src='"+v.IMG1+"' alt=''>";
		 _html += "</a>";
	 _html += "</li>";
	 
	 $("#globalBannerArea").html(_html);
	}
}

var frontGlobalArr = [];
var gItemSize= 0;
var gSelectedIdx = 0;

loadGlobalBanner();

function loadGlobalBanner(){
	var loadUrl = "/main/main2018/ajax/globalBannerS.json";
	$.ajax({
		type: "GET",
		url: loadUrl,
		dataType: "JSON",
		success: function(data){
			
			var jsonEnuriObj = data.shop;
			
		    //홀수개인 경우 마지막요소 삭제
		    if(jsonEnuriObj.length % 3 == 1) {
		    	if(jsonEnuriObj.length > 0) 	jsonEnuriObj.pop();
		    }
		    //홀수개인 경우 마지막요소 삭제		    
		    if(jsonEnuriObj.length % 3 == 2) {
		    	if(jsonEnuriObj.length > 0) 	jsonEnuriObj.pop();
		    }
		    
		    frontGlobalArr = jsonEnuriObj;
		    gItemSize= frontGlobalArr.length;
		    
		    drawGlobalArea();
		    
		    //기획전 내 좌우버튼 클릭
		    $(".mgloshop__brand").find("div").click(function(){
		    	changeGlobalLogo(($(this).index() == 0) ? -3 : 3);
		    });
		    
		    /*
			$("body").on('click', '.mgloshop__brand_list > li', function(event) {
				var url = $(this).attr("data-url");
				var mid = $(this).attr("data-id");
				ga('send', 'event', 'mf_home', 'global', "click_compare_"+mid+"_web");
				location.href = url;
			});
			*/
		}
	});
}

function drawGlobalArea() {
    var outHtml = "";
	var v = frontGlobalArr[gSelectedIdx];
	outHtml += "<li data-url='"+v.link+"' data-id='"+v.muid+"'>";
	outHtml += "	<a href='"+v.link+"' onclick='insertLog(24374);'>";
	outHtml += "		<span class='thumb'>";
	outHtml += "			<img src='"+v.img_icon+"' alt=''>";
	outHtml += "		</span>";
	outHtml += "		<span class='tx_item'>";
	outHtml += "			<span class='mglobal__ico_emoney'>E</span>머니<em>"+v.rate+"%</em>적립</span>";
	outHtml += "		</span>";
	outHtml += "	</a>";
	outHtml += "</li>";
	
	v = frontGlobalArr[gSelectedIdx+1];
    
	outHtml += "<li data-url='"+v.link+"' data-id='"+v.muid+"'>";
	outHtml += "	<a href='"+v.link+"' onclick='insertLog(24374);' >";
	outHtml += "		<span class='thumb'>";
	outHtml += "			<img src='"+v.img_icon+"' alt=''>";
	outHtml += "		</span>";
	outHtml += "		<span class='tx_item'>";
	outHtml += "			<span class='mglobal__ico_emoney'>E</span>머니<em>"+v.rate+"%</em>적립</span>";
	outHtml += "		</span>";
	outHtml += "	</a>";
	outHtml += "</li>";
	
	v = frontGlobalArr[gSelectedIdx+2];
    
	outHtml += "<li data-url='"+v.link+"' data-id='"+v.muid+"'>";
	outHtml += "	<a href='"+v.link+"' onclick='insertLog(24374);' >";
	outHtml += "		<span class='thumb'>";
	outHtml += "			<img src='"+v.img_icon+"' alt=''>";
	outHtml += "		</span>";
	outHtml += "		<span class='tx_item'>";
	outHtml += "			<span class='mglobal__ico_emoney'>E</span>머니<em>"+v.rate+"%</em>적립</span>";
	outHtml += "		</span>";
	outHtml += "	</a>";
	outHtml += "</li>";
	
	$(".mgloshop__brand_list").html(outHtml);
}
function changeGlobalLogo (param) {
	//(default : 오른쪽으로 2칸)
	var moveSize = typeof param !== "undefined" ? param : 3; 
	gSelectedIdx = (gSelectedIdx + moveSize + gItemSize) % gItemSize;
	
	drawGlobalArea();
}
var globalGoodsList = new Array();
var goodsIdx = 0;
var goodsItemSize = 0;
function loadGlobalGoods(){
	//var loadUrl = "/global/ajax/getDetailShoplist_ajax.jsp";
	var loadUrl = "/global/ajax/getDetailShoplist_ajax.json";
	$.ajax({
		type: "GET",
		url: loadUrl,
		dataType: "JSON",
		success: function(data){

			var tempGoodsList = data[0].global_model_list;

			if(tempGoodsList.length > 8 && tempGoodsList.length < 12){
				$.each(tempGoodsList, function (i, v) { 
					
					if(i < 8) {
						globalGoodsList.push(v);
					}
				});
			}else if(tempGoodsList.length > 12 && tempGoodsList.length < 16){
				$.each(tempGoodsList, function (i, v) { 
					if(i < 12) {
						globalGoodsList.push(v);
					}
				});
			}

			goodsItemSize = globalGoodsList.length;
			drawGgoodsArea();
			
		    $("#globalGoodsBtn").find("button").click(function(){
		    	changeGlobalGoods(($(this).index() == 0) ? -4 : 4);
		    });
		}
	});
}
function drawGgoodsArea() {
    var outHtml = "";
	var v = globalGoodsList[goodsIdx];
	outHtml += globalGoodsMake(v);
	v = globalGoodsList[goodsIdx+1];
	outHtml += globalGoodsMake(v);
	v = globalGoodsList[goodsIdx+2];
	outHtml += globalGoodsMake(v);
	v = globalGoodsList[goodsIdx+3];
	outHtml += globalGoodsMake(v);
	$("#globalGoodsList").html(outHtml);
}
function changeGlobalGoods (param) {
	//(default : 오른쪽으로 2칸)
	var moveSize = typeof param !== "undefined" ? param : 4; 
	goodsIdx = (goodsIdx + moveSize + goodsItemSize) % goodsItemSize;
	drawGgoodsArea();
}
function globalGoodsMake(v){
	var goodsHtml = "";
	var url = "detail.jsp?modelno="+v.modelno;
	
	goodsHtml += "<li class='prod__item'>";
    goodsHtml += "    <div class='thum'>";
    goodsHtml += "        <a href='"+url+"' onclick='insertLog(24374);'  target='_self' class='thum__link'>";
    goodsHtml += "            <span class='thum'><img src='"+v.strImageUrl+"' alt='' /></span>";
    goodsHtml += "            <span class='tx_wrap'>";
    goodsHtml += "                <span class='tx_name'>"+v.szModelNm+"</span>";
    goodsHtml += "            </span>";
    goodsHtml += "        </a>";
    goodsHtml += "        <ul class='comp__link'>";
	if( v.price_list ) {
		$.each( v.price_list , function(s,o){
			
			var moveUrl = "/move/Redirect.jsp?type=ex&cmd=move_"+o.pl_no+"&pl_no="+o.pl_no;
			if(s == 0)		goodsHtml += "            <li class='top'>";	
			else			goodsHtml += "            <li>";
		    
		    goodsHtml += "                <a href='"+moveUrl+"'>";
		    
		    if( o.shop_code == 8638 )	goodsHtml += "<span class=\"i_logo\">"+o.shop_name+"</span>";
			else						goodsHtml += "<span class=\"i_logo\"><img src='http://storage.enuri.info/logo/logo16/logo_16_"+o.shop_code+".png' alt=''></span>";
		    
		    goodsHtml += "                    <span class='tx_price'><em>"+o.price_text+"</em>원</span>";
		    goodsHtml += "                </a>";
		    goodsHtml += "            </li>";
		});
	}
    goodsHtml += "        </ul>";
    goodsHtml += "    </div>";
    goodsHtml += "</li>";
		
	return goodsHtml;
}
var globalShopArray = new Array();
var gshopIdx = 0;
var gshopSize = 0;
function loadGlobal(){
	
	//global_bannerLoading();
	
	var loadUrl = "/main/main2018/ajax/globalBannerS.json?ver=11";
	//var loadUrl = "/main/main2018/ajax/getGlobalDisplayLog.jsp";
	$.ajax({
		type: "GET",
		url: loadUrl,
		cache: false,
		dataType: "JSON",
		success: function(data){
			
			if(data.shop){
				globalShopArray = data.shop; 
				gshopSize = globalShopArray.length; 
			}
			drawShopArea();
			$("#shopGlobalBtn > button").click(function(){
				changeGlobalShop(($(this).index() == 0) ? -6 : 6);
		    });
		}
	});
}
function drawShopArea() {
    var outHtml = "";
	var v = globalShopArray[gshopIdx];
	outHtml += globalshopMake(v);
	
	v = globalShopArray[gshopIdx+1];
	outHtml += globalshopMake(v);
	v = globalShopArray[gshopIdx+2];
	outHtml += globalshopMake(v);
	v = globalShopArray[gshopIdx+3];
	outHtml += globalshopMake(v);
	v = globalShopArray[gshopIdx+4];
	outHtml += globalshopMake(v);
	v = globalShopArray[gshopIdx+5];
	outHtml += globalshopMake(v);
	
	$("#globalShop").html(outHtml);
}
function changeGlobalShop (param) {
	//(default : 오른쪽으로 2칸)
	var moveSize = typeof param !== "undefined" ? param : 6; 
	gshopIdx = (gshopIdx + moveSize + gshopSize) % gshopSize;
	drawShopArea();
}
function globalshopMake(v){
	
	var shopHtml = "";
	shopHtml += "<li class='shop__item'>";
	shopHtml += "<a href='"+v.link+"' target='_blank'  onclick='insertLog(24375);' >";
	shopHtml += "    <span class='thum'><img src='"+v.img_icon+"' alt='' /></span>";
	shopHtml += "    <span class='info'><span class='tx_save'><i class='ico_e'>e</i>머니 <em>"+v.rate+"%</em> 적립</span></span>";
	shopHtml += "</a>";
	shopHtml += "</li>";
	return shopHtml; 
}
function loadNotice(){
    var loadUrl = "/main/main1003/ajax/getNotice_Ajax.jsp";
    $.getJSON(loadUrl, null, function(data) {
    	var jsonObj = data["titleList"];
    	if (jsonObj.length == 0)    		$(".notice__top").html('');
    	$.each(jsonObj,function(idx,obj){   if(idx == 0)	$(".notice__top").append(obj["title"]);    	});
    });
}