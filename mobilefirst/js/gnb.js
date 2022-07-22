var getPoint = 0;
jQuery(document).ready(function($) {
    if(getCookie("appYN") == 'Y'){
        $("header").hide();
    }else{
        $("header").show();
    }
	//top 이벤트
	var bannerId = null;
	// 클릭이벤트 속도 향상을 위한 fastclick 적용
	var iOS = /(iPad|iPhone|iPod)/g.test( navigator.userAgent );
	if(iOS){
		$.getScript( "js/lib/fastclick.js", function() {
			// 클릭이벤트 속도 향상을 위한 fastclick 적용
		    FastClick.attach(document.body);			
		});
	}
	//if(datePopUpSet("2016/06/30","popup"))		bannerId = ["appArea"];
	//else		bannerId = ["appArea","attend_topbnr","new_topbnr"];
	
	bannerId = ["appArea","attend_topbnr","new_topbnr","summer_plan_bnr","olympic_bnr"];
	
	var item = bannerId[Math.floor(Math.random()*bannerId.length)];
	$("."+item).show();
	
	if ( fnGetCookie2010('linkerEvtTop') == "CHECKED" ) {
		$("#topBanner").hide();
	}
var nowUrl = document.URL;

	//검색 입력 박스 오픈ㅣ
	$("input[name=search_txt]").bind({
		focus:function(){
			searchOpen();
		}
	});
	//카테고리 메뉴 노출	
	$(".cate_menu").click(function(event) {
		
		var cateType = getCookie("cateType");		
		var nowUrl = document.location.href;
		var sel = "";
		
		if(nowUrl.indexOf("/mobilefirst/best_list.jsp") > -1){
			sel = "best_list";
		}else if(nowUrl.indexOf("/mobilefirst/list.jsp") > -1){
			sel = "list";
		}else if(nowUrl.indexOf("/mobilefirst/search.jsp") > -1){
			sel = "search";
		}else if(nowUrl.indexOf("/mobilefirst/detail.jsp") > -1){
			sel = "detail";
		}else if(nowUrl.indexOf("/mobilefirst/trend_news.jsp") > -1){
			sel = "trend_news";
		}else if(nowUrl.indexOf("/mobilefirst/Index.jsp") > -1){
			sel = "main";
		}else if(nowUrl.indexOf("/mobilefirst/plan_list.jsp") > -1){
			sel = "plan_list";
		}else{
			sel = "etc";
		} 
		ga('send', 'event', 'mf_common', 'cate_button', 'top_category_'+sel);	
		// 카테고리 버전이 커튼일 경우
		if(cateType == 'B'){
			cateCurtainLoading();
			ga('send', 'event', 'mf_category', 'type_select', 'type_curtain');
		}else{// 카테고리 버전이 리스트일 경우
			cateListLoading();
			ga('send', 'event', 'mf_category', 'type_select', 'type_list');			
		}
		getPoint = getTop();
	});
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
	//메인 새로 고침
	$(".logo").click(function(){
		ga('send', 'event', 'mf_gnb', 'gnb', 'gnb_에누리');
		window.location.replace("/mobilefirst/Index.jsp");
	});
	$(".my_back").click(function(){
		$(".my_back").hide();
		$(".mymenu").hide();
		 unlockScroll();
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
	//마이메뉴 오픈	
	$(".mybtn").click(function(v){
		$(".my_back").show();
		$(".mymenu").show();
		//최근본 상품 loading
		resentGoodsLoading();
		zzimGoodsLoading();
		loginCheck();
		lockScroll();
		v.preventDefault();
		ga('send', 'event', 'mf_gnb', 'gnb', 'gnb_마이메뉴');
	});
	$(".btn-search").click(function(){
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
			location.href = url+escape(schKeyword(keywordMake.trim()));
			ga('send', 'event', 'mf_search', 'search', 'search_'+keywordMake.trim());
		}else{
			location.href = url+escape(schKeyword(keyword.trim()));
			ga('send', 'event', 'mf_search', 'search', 'search_'+keyword.trim());
		}
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
function getTop() {
    var myTop = 0;
    if (typeof(window.pageYOffset) == 'number') {   //WebKit
        myTop = window.pageYOffset;
    } else if (typeof(document.documentElement.scrollTop) == 'number') {
        myTop = Math.max(document.documentElement.scrollTop, document.body.scrollTop);
    }
    return myTop;
}
function topBannerLink(type){
	var url = "";
	if(type == 'E'){
		if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
			ga('send', 'event', 'mf_home', 'top_banner', '출석체크_상단띠배너_ios');
		}else if(navigator.userAgent.indexOf("Android") > -1){
			ga('send', 'event', 'mf_home', 'top_banner', '출석체크_상단띠배너_android');
		}else{
			ga('send', 'event', 'mf_home', 'top_banner', '출석체크_상단띠배너_etc');
		}
        url = "/mobilefirst/event2016/visit_201608.jsp?freetoken=event";
	}else if(type == 'X') {
		if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
			ga('send', 'event', 'mf_home', 'top_banner', '구매왕_상단띠배너_ios');
		}else if(navigator.userAgent.indexOf("Android") > -1){
			ga('send', 'event', 'mf_home', 'top_banner', '구매왕_상단띠배너_android');
		}else{
			ga('send', 'event', 'mf_home', 'top_banner', '구매왕_상단띠배너_etc');
		}
		url = "/mobilefirst/event2016/allpayback_201608.jsp?freetoken=event&loc=con01";
	}else if(type == 'F'){
	    if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
            ga('send', 'event', 'mf_home', 'top_banner', '첫구매_ios');
        }else if(navigator.userAgent.indexOf("Android") > -1){
            ga('send', 'event', 'mf_home', 'top_banner', '첫구매_android');
        }else{
            ga('send', 'event', 'mf_home', 'top_banner', '첫구매_etc');
        }
	    url = "/mobilefirst/event2016/allpayback_201608.jsp?loc=con04&freetoken=event&chk_id=";
	}else if(type == 'S'){
        if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
            ga('send', 'event', 'mf_home', 'top_banner', '여름상품전_상단띠배너_ios');
        }else if(navigator.userAgent.indexOf("Android") > -1){
            ga('send', 'event', 'mf_home', 'top_banner', '여름상품전_상단띠배너_android');
        }else{
            ga('send', 'event', 'mf_home', 'top_banner', '여름상품전_상단띠배너_etc');
        }
        url = "/mobilefirst/planlist.jsp?t=B_20160705111111";
    }else if(type == 'O'){
        if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
            ga('send', 'event', 'mf_home', 'top_banner', '올림픽_상단띠배너_ios');
        }else if(navigator.userAgent.indexOf("Android") > -1){
            ga('send', 'event', 'mf_home', 'top_banner', '올림픽_상단띠배너_android');
        }else{
            ga('send', 'event', 'mf_home', 'top_banner', '올림픽_상단띠배너_etc');
        }
        url = "/mobilefirst/event2016/olympic_201608.jsp?freetoken=event";
    }
	location.href = url ;
}
//gnb 상단 이벤트 배너
function gnbEvtTopOnOff(){
	fnEverSetCookie("linkerEvtTop", "CHECKED", 1);
	$("#topBanner").hide();
}
//쿠키 날짜 대로
function fnEverSetCookie( name, value, expiredays )
{
	var todayDate = new Date();
	todayDate.toGMTString();
	todayDate.setDate( todayDate.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";";
}
//리스트형 카테고리 로딩
function cateListLoading(mainYN){
		
	$.get( "/mobilefirst/gnb/category/webAllCategory.html", function( data ) {
  		$( ".cate_type" ).html( data );
  		$("#cssmenu > ul > li > ul").css("display","block");
  		$( ".cate_type" ).show();
 	});
	cateListOpen(mainYN);
	lockScroll();
	location.href = "#menu";
	
}
function cateListOpen(mainYN){
		var c1dept = $.trim(getCookie("c1dept")); // class
		var c2dept = getCookie("c2dept"); // name
		setTimeout(function(){
			if(mainYN == 'Y'){
				if (c1dept) {
					if(c1dept == 'A103'){
						window.scrollTo(0, $("#1").position().top);
					}else if(c1dept == 'A107'){
						window.scrollTo(0, $("#2").position().top);
					}else if(c1dept == 'A109'){
						window.scrollTo(0, $("#3").position().top);
					}else if(c1dept == 'A110'){
						window.scrollTo(0, $("#4").position().top);
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
//커튼형 카테고리 로딩
function cateCurtainLoading(mainYN){
	$.get( "/mobilefirst/gnb/category/webCurtainCategory.html", function( data ) {
  		
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
//app down 링크
function topBannerDown(){
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
		ga('send', 'event', 'mf_common', 'header', '헤더_앱다운클릭_iOS');
		window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8';
	}else if(navigator.userAgent.indexOf("Android") > -1){
		ga('send', 'event', 'mf_common', 'header', '헤더_앱다운클릭_andorid');
		window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
	}else{
		ga('send', 'event', 'mf_common', 'header', '헤더_앱다운클릭_etc');
	}
}
// 카테고리 커튼 쿠키 값 오픈
function cateCutainOpen(mainYN){
		
  	var c1dept = getCookie("c1dept"); // class
	var c2dept = getCookie("c2dept"); // name
	
	if (c1dept) {
  		setTimeout(function(){
  			
			$( "#"+c1dept+" > a" ).trigger("click");
			$("#two"+c2dept).trigger("click");
			
			var id = c1dept.replace("A","");
			
			if(mainYN = 'Y' && id > 109){
				$( ".first" ).scrollTop( 500 );
			}

		},300);
  	}
}
function lockScroll() {
	
	setTimeout(function(){
		//var h = $(window).height();				
		var h = window.innerHeight;				
	    var header = $("header").height();
	    var newgnb = $(".newgnb").height();
	    var dimSize = h - header - newgnb;
		$('#wrap').css({
			'overflow' : 'hidden',
			'height' : dimSize-20
		});
	},300);
}
/**
 * 화면 스크롤 해제
 */
function unlockScroll() {
	$('#wrap').css({
		'overflow' : 'auto',
		'height' : 'auto'
	});
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
function search_resent_go(modelno,p_pl_no){
	if(modelno=="0" || modelno.length<2){
		moveGoodsPage("P"+p_pl_no);		
	} else {
		moveGoodsPage("G"+modelno);		
	}
}
// G+MODELNO, P+PLNO 를 이용해서 상품창 이동하는 함수
function moveGoodsPage(goodsCode) {
	if(goodsCode.indexOf("G")>-1) {
		document.location.href = "/mobilefirst/detail.jsp?modelno="+goodsCode.substring(1);
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

				if(window.android) {
					document.location.href = url;
				} else {
					//window.open(url);
					resultChk = true;
					newUrl = url;
				}

				var logParam = "cate="+ca_code+"&modelno=0&rank=&pl_no="+pl_no+"&vcode="+shop_code;
				$.ajax({
					type: "POST",
					url: "/mobilefirst/include/m4_move_log.jsp",
					data: logParam
				});
			}
		});
		
		if(resultChk){
			if( navigator.userAgent.indexOf("iPhone") > 0 || navigator.userAgent.indexOf("iPod") > 0 || navigator.userAgent.indexOf("iPad") > 0){
				newUrl = newUrl + "&DEVICE_BROWSER=Y";
			}
			 
			window.open(newUrl);
		}
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
		if(confirm("로그인 하시겠습니까?")) {
			goLogin();
		}
	}
}

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
//최근본 상품 loading
function resentGoodsLoading(){
	//$(".swiper-wrapper").append("최근본");
	var resentListStr = getCookie("resentList");
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
				//if (i > 50)	break;
			}
		}
	}
	// 쿠키 를 통해 데이터를 읽어옴(resentList)
	var loadUrl = "/mobilefirst/ajax/resentZzim/Ajax_goodsListNew.jsp?listType=9&goodsNumList=" + resentListStr2;
	var $swiper_wrapper = $(".swiper-wrapper").empty();
	$.ajax({
		url: loadUrl,
		dataType: 'json',
		success: function(data){
			
			goodsCnt = data["goodsCnt"];
			goodsList = data["goodsList"];
			
			var totalCnt = 0;
			
			if(cnt != 0) totalCnt = cnt-1 ;
			
			$(".mymenu > h2 > a").first().text("최근 본 상품 ("+totalCnt+")");
			if (goodsCnt > 0) {
				if(goodsCnt < 50){
					$.each(goodsList, function(i, v){
						$swiper_wrapper.append("<li><button type='button' class='del' id = '"+v.modelno+"_"+v.p_pl_no+"')'>상품 삭제</button><a href='javascript:search_resent_go("+v.modelno+","+v.p_pl_no+")'><img src='"+v.smallImageUrl+"' alt=''></a></li>");
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
//최근본 상품 삭제
function resentXLint(modelno,plno){
	
	var deleteModelno = "G"+modelno;
	
	// 삭제할 상품이 없음
	if(modelno=="0" && plno=="0") return;
	
	if(modelno=="0") deleteModelno = "P"+plno;
	else if(plno=="0") deleteModelno = "G"+modelno;
	
	delResentAppGNB(deleteModelno);
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
					liHtml +="<img src='"+imgSrc+"' alt='' class='thum' onerror=\"this.src='"+middleImageUrl+"'\">";
					//liHtml +="<strong><em>"+factory+"</em>"+modelname+"</strong>";
					liHtml +="<strong>"+modelname.replace("&amp;amp;","&amp;")+"</strong>";
					
					if(minPriceText == '단종/품절'){
				      minPriceText = "<em>단종/품절</em>";
				    }else if(minPriceText == '출시예정' || minPriceText == '별도확인'){
				      minPriceText = "<em class=\"release\">" + minPriceText + "</em>";
				    }
					if(minprice == ''){
						liHtml +="<span class='soldout'>"+minPriceText+"</span>";
					}else{
						liHtml +="<span><em>"+minprice+"</em>원</span>";						
					}
					liHtml +="</a></li>";
					
					$zzimDom.append(liHtml);
				});
			}else{
				liHtml  = "";
				liHtml += "<li class='zzim_txt'>찜 상품이 없습니다.<br>";
				liHtml += "<img src='http://img.enuri.info/images/mobilefirst/ico_zzim.png' alt='찜'>";
				liHtml += "을 선택하여 담아보세요.</li>";
				$zzimDom.append(liHtml);
			}
		});
		
	}else{
		$zzimDom.append("<li class='zzim_txt'>찜 상품이 없습니다. <br> <img src='http://img.enuri.info/images/mobilefirst/ico_zzim.png' alt='찜' /> 선택하여 담아보세요 </li>");
	}
}
function IsLogin() {
	var cName = "LSTATUS";
	var s = document.cookie.indexOf(cName +'=');
	if (s != -1){
		s += cName.length + 1;
		e = document.cookie.indexOf(';',s);
		if (e == -1){
			e = document.cookie.length;
		}
		if( unescape(document.cookie.substring(s,e))=="Y"){
			try {
				if(window.android){
					if(vCheckfirst){
						window.android.isLogin("true");
						vCheckfirst = false;
					}
				}
			} catch(e) {}
			return true;
		}else{
			try {
				if(window.android){
					window.android.isLogin("false");
				}
			} catch(e) {}
			return false;
		}
	}else{
		try {
			if(window.android){
				window.android.isLogin("false");
			}	
		} catch(e) {}
		return false;
	}
}
//해당 날짜 이상일 경우는 해당 함수를 호출 하지 않는다.
//setDate = 설정 날짜
//setFct = 설정 함수
