jQuery(document).ready(function($) {
		
		if(document.URL.indexOf("/m/index.jsp") > -1 || document.URL.indexOf("/m/index_new.jsp") > -1
				||document.URL.indexOf("/m/list.jsp") > -1
				||document.URL.indexOf("/m/search.jsp") > -1
				||document.URL.indexOf("/m/cpp.jsp") > -1
                ||document.URL.indexOf("planlist.jsp") > -1
                ||document.URL.indexOf("zzimFolderList.jsp") > -1
				||document.URL.indexOf("/m/cpp_new.jsp") > -1 ) {
                
                    
				//||document.URL.indexOf("/m/brandRank.jsp") > -1
				//||document.URL.indexOf("/m/brand.jsp") > -1 ) {
			
			if(getCookie("appYN") == 'Y')        $("header").hide();
		    else        $("header").show();	
	}
    
    
    //최근본 , 찜 페이지에서는 배너로딩하지 않는
    if( document.URL.indexOf("resentzzimList.jsp") < 0 ){
       //homeBannerLoading();
    	getMainTopBanner();
    	if(document.URL.indexOf("cpp_m") < 0){
    		getMainFooterBanner();
    	}
    }
    //카테고리 메뉴 노출    
    $(".cate_m").click(function(event) {
    	$("#foldingCate").hide();
		
        var cateType = getCookie("cateType");
        if(cateType == 'B'){cateCurtainLoading();ga('send', 'event', 'mf_category', 'type_select', 'type_curtain');
        }else{cateListLoading();ga('send', 'event', 'mf_category', 'type_select', 'type_list'); }
        
        getPoint = getTop();

        if( document.URL.indexOf("/list.jsp") > -1){
        	ga('send', 'event', 'mf_lp', 'lp_GNB', 'GNB_카테고리 메뉴');
        }else if( document.URL.indexOf("/search.jsp") > -1){
        	ga('send', 'event', 'mf_srp', 'srp_GNB', 'GNB_카테고리 메뉴');
        }
    });
    //검색 입력 박스 오픈
    //$("input[name=searchtxt]").bind({focus:function(){searchOpen();}});
        //카테고리 타입
    $("body").on('click', '.type_btn > li', function(event) {    
        var type = $(this).children().text();
        $( ".cate_type" ).children().remove();
        if(type == '전체보기'){
            setCookie("cateType","B");      
            cateCurtainLoading();
        }else{
            setCookie("cateType","A");
            cateListLoading();
        }
    });
    //마이메뉴 오픈   
    $(".mybtn").click(function(v){
        /*
    	$(".my_back").show();
        $(".mymenu").show();
        //최근본 상품 loading
        resentGoodsLoading();
        zzimGoodsLoading();
        loginCheck();
        lockScroll();
        */
        v.preventDefault();
        ga('send', 'event', 'mf_gnb', 'gnb', 'gnb_마이메뉴');
        if( document.URL.indexOf("/list.jsp") > -1){
        	ga('send', 'event', 'mf_lp', 'lp_GNB', 'GNB_마이에누리');
        }else if( document.URL.indexOf("/search.jsp") > -1){
        	ga('send', 'event', 'mf_srp', 'srp_GNB', 'GNB_마이에누리');
        }
        location.href = "https://m.enuri.com/my/my_enuri_m.jsp";
    });
    $(".my_back").click(function(){        $(".my_back").hide();        $(".mymenu").hide();         unlockScroll();    });
    $(".btn-search").click(function(){
        //var url = "/mobilefirst/search2.jsp?keyword=";
    	var url = "/mobilefirst/search.jsp?keyword=";
        var keyword = $("#search_keyword").val();
         
        if($("#searchWrap").is(':visible') && keyword == ""){
            alert("검색어를 입력하세요");
            return;     
        }
        if(keyword.length < 2 ){
            if (!(keyword.length == 1 && varExpKeyWord.indexOf(keyword) >= 0 )){
                alert("한글자는 검색할 수 없습니다.\r\n다른 단어를 함께 선택해 주세요.");
                $("#search_keyword").val("");
                $("#search_keyword").focus();
                return;
            }
        }
        if(keyword.indexOf("__") > 0){ //히스토리
            
            var keywordMake = keyword.substring(0,keyword.indexOf("__"));
            //location.href = url+escape(schKeyword(keywordMake.trim()));
            location.href = url+schKeyword(keywordMake.trim());
            ga('send', 'event', 'mf_search', 'search', 'search_'+keywordMake.trim());
            
        }else{
            //location.href = url+escape(schKeyword(keyword.trim()));
            ga('send', 'event', 'mf_search', 'search', 'search_'+keyword.trim());
            
            if(  document.URL.indexOf("smarthome.jsp") > -1 ){
            	goSearhHistory( schKeyword(keyword.trim()) );
            	location.href = url+schKeyword(keyword.trim())+"&from=swt";
            }else{
            	location.href = url+schKeyword(keyword.trim());
            }
        }
        ga('send', 'event', 'mf_search', 'search', 'search_검색어');
    });
  //마이메뉴 최근본 상품 삭제
	$("body").on('click', '.swiper-wrapper > li > button', function(event) {
		
		var temp_key = $(this).attr("id");
		var tempArray = temp_key.split('_'); 	
		var modelno = tempArray[0];
		var ppplo = tempArray[1];
		
		resentXLint(modelno , ppplo); 
		resentGoodsLoading();
		
	});
    $(window).on('hashchange', function(e){
        var url = location.href;
        if(url.indexOf("#") <= -1 && $( ".cate_type" ).css('display') != 'none'){
            $( ".cate_type" ).hide();
            history.pushState({}, '', url.replace("#menu",""));
            unlockScroll();
            return false;
        }   
    });
});
function goSearhHistory(keyword){
	
	var loadUrl = "/mobilefirst/include/m4_cookie.jsp?type=setKeyword&keyword="+keyword;
    $.ajax({
        url: loadUrl,
        dataType: 'json',
        success: function(data){
        	
        }
    });
}
//리스트형 카테고리 로딩
function cateListLoading(mainYN){
    
	var url = "";
	
	url = "/mobilefirst/gnb/category/webAllCategory_2018.html";
	//url = "/mobilefirst/gnb/category/webAllCategory.html"; //예전버전
	
	$.get( url , function( data ) {
        $( ".cate_type" ).html( data );
        $("#cssmenu > ul > li > ul").css("display","block");
        $( ".cate_type" ).show();
    });
    cateListOpen(mainYN);
    lockScroll();
    location.href = "#menu";
}
//커튼형 카테고리 로딩
function cateCurtainLoading(mainYN){
	
	var url = "";

	url = "/mobilefirst/gnb/category/webCurtainCategory_2018.html";
	//url = "/mobilefirst/gnb/category/webCurtainCategory.html"; //예전버전
	
    $.get( url , function( data ) {
        $( ".cate_type" ).html( data );
        $( ".cate_type" ).show();
        if(mainYN == 'N'){
            $(".type_btn").remove();
        }
    });
    cateCutainOpen(mainYN);
    lockScroll();
    location.href = "#menu";
}
function cateListOpen(mainYN){
        var c1dept = $.trim(getCookie("c1dept")); // class
        var c2dept = getCookie("c2dept"); // name
        setTimeout(function(){
            if(mainYN == 'Y'){
                if (c1dept) {
                    if(c1dept == 'A103'){   	  window.scrollTo(0, $("#1").position().top);
                    }else if(c1dept == 'A107'){   window.scrollTo(0, $("#2").position().top);
                    }else if(c1dept == 'A109'){   window.scrollTo(0, $("#3").position().top);
                    }else if(c1dept == 'A110'){   window.scrollTo(0, $("#4").position().top);
                    }else{
                        var height = $(window).height();
                        window.scrollTo(0, height+150);
                    }
                }
            }else if(mainYN == 'N'){
            }else{
                if (c1dept) {
                        $( ".cate_type" ).find("#"+c1dept+" > a").trigger("click");
                        $( ".cate_type" ).find("[name='"+c2dept+"'] > a").trigger("click");
                }
            }
        },300);
}
// 카테고리 커튼 쿠키 값 오픈
function cateCutainOpen(mainYN){
    var c1dept = getCookie("c1dept"); // class
    var c2dept = getCookie("c2dept"); // name
    /*
    if (c1dept) {
        setTimeout(function(){
            $( "#"+c1dept ).trigger("click");
            $("#two"+c2dept).trigger("click");
            var id = c1dept.replace("A","");
            if(mainYN = 'Y' && id > 109) $( ".first" ).scrollTop( 500 );
        },300);
    }
    */
}
function lockScroll() {
    setTimeout(function(){
        $("footer").hide();               
        var h = window.innerHeight;             
        var header = $("header").height();
        var newgnb = $(".newgnb").height();
        var dimSize = h - header - newgnb;
        $('#wrap').css({'overflow' : 'hidden','height' : dimSize-20});
    },300);
}
function unlockScroll() {$('#wrap').css({'overflow' : 'auto','height' : 'auto'});$("footer").show();}
function cateClose(){
    url = window.location.href;
    history.pushState({}, '', url.replace("#menu",""));
    $( ".cate_type" ).hide();
    unlockScroll();
    var c1 = getCookie("c1dept");
    if(typeof(c1) == "undefined" || c1 == '' ){
        scrollTo(0,getPoint);
    }else{
        scrollTo(0,0);
    }
}
function getTop() {
    var myTop = 0;
    if (typeof(window.pageYOffset) == 'number') {   //WebKit
        myTop = window.pageYOffset;
    } else if (typeof(document.documentElement.scrollTop) == 'number') {
        myTop = Math.max(document.documentElement.scrollTop, document.body.scrollTop);
    }
    return myTop;
}
function getCookie(c_name) {
    var i,x,y,ARRcookies=document.cookie.split(";");
    for(i=0;i<ARRcookies.length;i++) {
        x = ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
        y = ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
        x = x.replace(/^\s+|\s+$/g,"");
        if(x==c_name) return unescape(y);
    }
}
//최근본 상품 loading
function resentGoodsLoading(){
    //$(".swiper-wrapper").append("최근본");
    var resentListStr = decodeURIComponent(getCookie("resentList"));
    var listGoodsCnt = 0;
    //최근본 상품 갯수
    var cnt = 0;

    if (typeof(resentListStr) != "undefined") {
        var resentListStrAry = resentListStr.split(",");
        var resentListStr2 = "";
        if (resentListStr.indexOf(",") > -1) {
            for (var i = 0; i < resentListStrAry.length; i++) {
                resentListStr2 += resentListStrAry[i] + ",";
                cnt++;
            }
        }
    }
    // 쿠키 를 통해 데이터를 읽어옴(resentList)
    var loadUrl = "/mobilefirst/ajax/resentZzim/Ajax_goodsListNew.jsp?listType=9&goodsNumList=" + resentListStr2;
    var $recentMenu = $("#recentMenu").empty();
    
   	
    $.ajax({
        url: loadUrl,
        dataType: 'json',
        success: function(data){
            
            goodsCnt = data["goodsCnt"];
            goodsList = data["goodsList"];
            
            var totalCnt = 0;
            if(cnt != 0) totalCnt = cnt-1 ;
            $(".mymenu > h2 > a").first().text("최근 본 상품 ("+goodsCnt+")");
            if (data.goodsCnt > 0) {
                if(data.goodsCnt < 50){
                    $.each(goodsList, function(i, v){
                    	$recentMenu.append("<li><button type='button' class='del' id = '"+v.modelno+"_"+v.p_pl_no+"'>상품 삭제</button><a href='javascript:search_resent_go("+v.modelno+","+v.p_pl_no+")'><img src='"+v.smallImageUrl+"' alt='' onerror=\"if (this.src != 'http://imgenuri.enuri.gscdn.com/images/m_home/noimg.png') this.src = 'http://imgenuri.enuri.gscdn.com/images/m_home/noimg.png'\" ></a></li>");
                    });
                } 
            } else {
                $(".scrollbox_area").empty();
                liHtml  = "";
                liHtml += "<div class='recent_txt'>최근 본 상품이 없습니다.</div>";
                $(".scrollbox_area").append(liHtml);
            }
        }
    });
}
//찜 loading
function zzimGoodsLoading(){
    $zzimDom = $(".zzim").empty();
    if(IsLogin()){
        var loadUrl = "/mobilefirst/ajax/resentZzim/Ajax_goodsListNew.jsp?listType=2&folder_id=1&deviceType=m&pageNum=1&pageGap=10";
        jQuery.getJSON(loadUrl, null, function(data) {
            var jsonObj = data["goodsList"];
            var zzimCnt = data["myGoodsTotalCnt"];
            if(jsonObj) {
                $(".mymenu > h2 > a").last().text("찜 상품 ("+zzimCnt+")");
                $.each(jsonObj, function(indexI, listObj) {
                    var modelno = listObj["modelno"];
                    var p_pl_no = listObj["p_pl_no"];
                    var factory = listObj["factory"];
                    var modelname = listObj["modelnm"];
                    var minprice = listObj["minprice"];
                    var middleImageUrl = listObj["middleImageUrl"];
                    var smallImageUrl = listObj["smallImageUrl"];
                    var minPriceText = listObj["minPriceText"];
                    var imgSrc = "";
                    
                    if(smallImageUrl.indexOf('working.gif') > -1 ){
                        imgSrc = middleImageUrl;
                    }else{
                        imgSrc = smallImageUrl;
                    }
                    liHtml  = "";
                    liHtml += "<li><a href='javascript:search_resent_go("+modelno+","+p_pl_no+")'>";
                    liHtml +="<img src='"+imgSrc+"' alt='' class='thum' onerror=\"this.src='http://imgenuri.enuri.gscdn.com/images/m_home/noimg.png'\">";
                    //liHtml +="<strong><em>"+factory+"</em>"+modelname+"</strong>";
                    liHtml +="<strong>"+modelname.replace("&amp;amp;","&amp;")+"</strong>";
                    
                    if(minPriceText == '단종/품절'){
                      minPriceText = "<em>단종/품절</em>";
                    }else if(minPriceText == '출시예정' || minPriceText == '별도확인'){
                      minPriceText = "<em class=\"release\">" + minPriceText + "</em>";
                    }
                    if(minprice == '')      liHtml +="<span class='soldout'>"+minPriceText+"</span>";
                    else                        liHtml +="<span><em>"+minprice+"</em>원</span>";                     
                    liHtml +="</a></li>";
                    
                    $zzimDom.append(liHtml);
                });
            }else{
                liHtml  = "";
                liHtml += "<li class='zzim_txt'>찜 상품이 없습니다.<br>";
                liHtml += "<img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/ico_zzim.png' alt='찜'>";
                liHtml += "을 선택하여 담아보세요.</li>";
                $zzimDom.append(liHtml);
            }
        });
    }else{
        $zzimDom.append("<li class='zzim_txt'>찜 상품이 없습니다. <br> <img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/ico_zzim.png' alt='찜' /> 선택하여 담아보세요 </li>");
    }
}
function search_resent_go(modelno,p_pl_no){
    if(modelno=="0" || modelno.length<2)        moveGoodsPage("P"+p_pl_no);     
    else         moveGoodsPage("G"+modelno);
}
// G+MODELNO, P+PLNO 를 이용해서 상품창 이동하는 함수
function moveGoodsPage(goodsCode) {
    if(goodsCode.indexOf("G")>-1) {
        document.location.href = "/mobilefirst/detail.jsp?modelno="+goodsCode.substring(1);
        return false;
    }
    if(goodsCode.indexOf("P")>-1) {
        var url = "/mobilefirst/ajax/resentZzim/getPlno_infos_ajax.jsp";
        var param = "plno="+goodsCode.substring(1);
        var resultChk = false;
        var newUrl = "";
        $.ajax({
            type : "post",
            url : url,
            data : param, 
            async : false,
            dataType : "json",
            success : function(result) {
                var shop_code = result["shop_code"];
                var ca_code = result["ca_code"];
                var pl_no = result["pl_no"];
                var url = result["url"];
                /*
                if(window.android) {
                    document.location.href = url;
                    //http://m.enuri.com/mobilefirst/move.jsp?&vcode=536&plno=1858611251&url=http%3A%2F%2Fwww.gmarket.co.kr%2Fchallenge%2Fneo_jaehu%2Fjaehu_goods_gate.asp%3Fgoodscode%3D651123618%26GoodsSale%3DY%26jaehuid%3D200006254&ch=ddc0b0ce
                } else {
                    //window.open(url);
                    resultChk = true;
                    newUrl = url;
                }
                if(resultChk){
                    if( navigator.userAgent.indexOf("iPhone") > 0 || navigator.userAgent.indexOf("iPod") > 0 || navigator.userAgent.indexOf("iPad") > 0){
                        newUrl = newUrl + "&DEVICE_BROWSER=Y";
                    }
                }
                */
                //newUrl = "/mobilefirst/move.jsp?vcode="+shop_code+"&plno="+pl_no+"&url="+encodeURIComponent(url);
                window.open(url);
                
                var logParam = "cate="+ca_code+"&modelno=0&rank=&pl_no="+pl_no+"&vcode="+shop_code;
                $.ajax({
                    type: "POST",
                    url: "/mobilefirst/include/m4_move_log.jsp",
                    data: logParam
                });
            }
        });
    }
}
// 찜 페이지로 이동
function goResent() {
    ga('send', 'event', 'mf_gnb', 'my', 'my_최근본상품');
    document.location.href = "/mobilefirst/resentzzim/resentzzimList.jsp?listType=1";
}
// 찜 페이지로 이동
function goZzim() {
    if(IsLogin()){
        document.location.href = "/mobilefirst/resentzzim/resentzzimList.jsp?listType=2";   
    }else{
        if(confirm("로그인 하시겠습니까?")) goLogin();
    }
}
function loginCheck(){
    if(IsLogin()){
            var url = "/mobilefirst/ajax/login/loginInfo_ajax.jsp";
            jQuery.getJSON(url, null, function(data) {
                $(".login").empty();
                var html = "<span class='login after'>"+data.id+"님</span>";
                    html += "<span class='logout'><a href='javascript:goLogout()'>로그아웃</a></span>";
                $(".mymenu > h1 ").html(html);  
            });
    }
}

function deviceCheck(){
    var iphoneAndroid = "";
    if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1)        iphoneAndroid ="I";
    else if(navigator.userAgent.indexOf("Android") > -1)        iphoneAndroid ="A";
    return iphoneAndroid;
}

function homeBannerLoading(){
        $.getJSON( "/mobilefirst/http/json/banner_list.json", function(json) {
        if ( fnGetCookie2010('linkerEvtTop') != "CHECKED" ) {
            
            if(json.webtop.banner){
               var bannerJson = new Array();
               //top 배너
               $.each(json.webtop.banner, function(i, v){
                     
                    var viewYN = false;
                     
                    var sdate = replaceAll(v.sdate,"-" ,"/"); 
                    sdate = new Date(sdate);
                    
                    var edate = replaceAll(v.edate,"-" ,"/");
                    edate = new Date(edate);
                    
                    if(dateComparison(sdate,edate)){
                        if(deviceCheck() == "I" && v.IOS == "Y") viewYN = true;  
                        else if(deviceCheck() == 'A' && v.ANDROID == "Y"  ) viewYN = true;
                        if(viewYN) bannerJson.push(v);
                    }
               }); 
                var webFrontTop = shuffle(bannerJson);
                var bannerObj = webFrontTop[0];
                if(bannerObj)   $("header").prepend($("#homeBanner").tmpl(bannerObj));
            }
        }
        //footer 배너
        if(json.footer.banner){
            var bannerJson = new Array();
             $.each(json.footer.banner, function(i, v){
                    var viewYN = false;
                    
                    var sdate = replaceAll(v.sdate,"-" ,"/"); 
                    sdate = new Date(sdate);
                    
                    var edate = replaceAll(v.edate,"-" ,"/");
                    edate = new Date(edate);
                    
                    if(dateComparison(sdate,edate)){
                        if(deviceCheck() == "I" && v.IOS == "Y") viewYN = true;  
                        else if(deviceCheck() == 'A' && v.ANDROID == "Y"  ) viewYN = true;
                        if(viewYN)  bannerJson.push(v);
                    }
             }); 
            var webFooter = shuffle(bannerJson);
            var bannerObj = webFooter[0];
            if(bannerObj)                    $(".family_app").after($("#footerBanner").tmpl(bannerObj));    
        }
        /*
        if(json.webFrontPop.banner){
            
            var size = json.webFrontPop.banner.length;
            var type = "";
            //if(size > 1) type = "tb";  //두장레이어
            //else type = "t"; //한장레이어
            var loctype = ""; //ALL TOP BOTTOM
            if(size > 0 ) loctype = json.webFrontPop.banner[0].location;
            
            var html = "";
            if(loctype != 'all')  html += "<div class=\"frontLayer\"><ul>";
            else                html += "<div class=\"frontLayer one\"><ul>";
            
            var bottom = "";
            var top = "";
            var viewCnt = 0;
            
            $.each(json.webFrontPop.banner, function(i, v){
                    
                    var sdate = replaceAll(v.sdate,"-" ,"/"); 
                    sdate = new Date(sdate);
                    var edate = replaceAll(v.edate,"-" ,"/");
                    edate = new Date(edate);
                    
                    if(dateComparison(sdate,edate)){
                        var viewYN = false;
                        if(deviceCheck() == "I" && v.IOS == "Y") viewYN = true;
                        else if(deviceCheck() == 'A' && v.ANDROID == "Y"  ) viewYN = true;
                        
                        if( viewYN ){
                            viewCnt++;
                            if(v.location == 'top'){
                                if(top == ""){
                                    top = "<li data-id='"+v.link+"'><img src='"+v.img+"'  alt='"+v.name+"' /></li>";    
                                }
                            } else if( v.location == 'bottom' ){
                                if( bottom == ""  ){
                                    bottom = "<li data-id='"+v.link+"'><img src='"+v.img+"' alt='"+v.name+"' /></li>";    
                                }
                            }else if( v.location == 'all' ){
                                bottom = "<li data-id='"+v.link+"'><img src='"+v.img+"' alt='"+v.name+"' /></li>";
                                return false;
                            }
                        }
                            if(top != "" &&  bottom != ""){
                                return false;
                            }
                    }
              
             });
             html += top;
             html += bottom;
             html += "<p class=\"frontbtn\">";
                 html += "<span><a href='javascript:///' class=\"btn_today\">일주일 동안 보지 않기</a></span>";
                 html += "<span><a href='javascript:///' onclick='mainLayerOneDay()' >닫기</a></span>";
             html += "</p>";
             html += "</div>";
            var viewYN = false;
            //if(deviceCheck() == "I" && bannerObj.IOS == "Y") viewYN = true;  
            //else if(deviceCheck() == 'A' && bannerObj.ANDROID == "Y"  ) viewYN = true;
             //console.log("viewCnt :"+viewCnt);
             if(viewCnt == 0)  $("#mainLayer").hide();
             else                   $("#mainLayer").html(html); 
        }
        */
    });
}
//gnb 상단 이벤트 배너
function gnbEvtTopOnOff(){
    fnEverSetCookie("linkerEvtTop", "CHECKED", 1);
    $("#topBanner").hide();
}
function dateComparison(sdate , edate){
    var nowDate = new Date();
    var result = false;
    if(sdate < nowDate && edate > nowDate){        result = true;    }
    return result; 
}
function goToBanner(url,name){
    if( url.indexOf('install') > -1 ){
        if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
            ga('send', 'event', 'mf_common', 'header', '헤더_앱다운클릭_iOS');
            window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8';
        }else if(navigator.userAgent.indexOf("Android") > -1){
            ga('send', 'event', 'mf_common', 'header', '헤더_앱다운클릭_andorid');
            window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
        }else{
            ga('send', 'event', 'mf_common', 'header', '헤더_앱다운클릭_etc');
        }
    }else{
        ga('send', 'event', 'mf_common', 'header', name);
        location.href = url;        
    }
}
//최근본 상품 삭제
function resentXLint(modelno,plno){
	
	var deleteModelno = "G"+modelno;
	
	// 삭제할 상품이 없음
	if(modelno=="0" && plno=="0") return;
	
	if(modelno=="0") deleteModelno = "P"+plno;
	else if(plno=="0") deleteModelno = "G"+modelno;
	
	delResentAppGNB(deleteModelno);
}
function goHome(){ga('send', 'event', 'mf_gnb', 'gnb', 'gnb_에누리');window.location.replace("/mobilefirst/index.jsp");}
