var swiperAll;
var mainGoodsFirstJson = new Array(); //메인 상품 첫 로딩
var mainGoodsSocial = new Array(); //소셜상품
var mainGoodsA = new Array(); //이벤트, 기획전
var mainGoodsG = new Array(); //이벤트, 기획전
var mainGoodsQ = new Array(); //롤링기획전
var main = new Array(); //메인 상품 첫 로딩
var seasonName = '';
var pagingYN = true;
var resizeYN = false;
var nowpage = 0;
function lastPosted(){
	var size = $("#today_list").children().size();
		if(size > 18){
			if(pagingYN){
				var paginList = new Array();

	        	$.each(mainGoodsSocial,function(i,v){
	        		if(i > 4){
	        			paginList.push(v);
	        		}
	        	});
	        	//20 , 40  = A 30 , 50 , 60 , 70 , 80 = G
	        	if(paginList.length >= 30 && mainGoodsG.length > 0)	paginList.splice(8,0,mainGoodsG[0]);
	        	if(paginList.length >= 40 && mainGoodsA.length > 1) paginList.splice(18,0,mainGoodsA[1]);
	        	if(paginList.length >= 50 && mainGoodsG.length > 1) paginList.splice(28,0,mainGoodsG[1]);
	        	if(paginList.length >= 60 && mainGoodsG.length > 2) paginList.splice(38,0,mainGoodsG[2]);
	        	if(paginList.length >= 70 && mainGoodsG.length > 3)	paginList.splice(48,0,mainGoodsG[3]);
	        	if(paginList.length >= 80 && mainGoodsG.length > 4) paginList.splice(58,0,mainGoodsG[4]);
				mainGoodsListHtml("",paginList);
				rollingPlan();
				var home_plan = new Swiper('#home_plan2', {slidesPerView: 'auto'});
				pagingYN = false;
				$("img.lazy").lazyload({
	        		effect:'fadeIn',
                    threshold:500,
                    failure_limit:2 ,
                    skip_invisible : true
	        	});
				setDelay();
			}
		}
}
function rollingPlan(){
	if(mainGoodsQ.length > 0){

		var planHtml =  "<li id=\"Q\" class=\"bnrarea qq2 \">";
		planHtml += 	"<div class=\"plan_area swiper-container\"  id=\"home_plan2\" >";
		planHtml += 		"<ul class=\"swiper-wrapper\">";

		var cnt = 0;
		$.each(mainGoodsQ,function(i,v){
			if(i > 2){
				planHtml +=				"<li class='swiper-slide' onclick=\"goQQlink('"+v.section_url+"','"+v.part+"','"+v.section_txt+"');\" ><img src='"+v.img+"' alt='' /></li>";
				cnt++;
			}
			if(cnt == 3) return false;
		});
		planHtml +=			"</ul>";
		planHtml +=		"</div>";
		planHtml +=	"</li>";
		$("#today_list li:eq(27)").after(planHtml);
	}
}
function goQQlink(url,part,sectiontxt){
	ga('send', 'event', 'mf_home_goods', 'plan_Q', "plan_Q_"+sectiontxt);
	location.href = url;
	return false;
}
function getSeasonTab(){
	var seasonHtml = $("#season").children().html();

	if(!seasonHtml){
		$.ajax({
	        type: "GET",
	        url: "/mobilefirst/api/main/seasonTab.json",
	        async: true,
	        dataType:"JSON",
	        success: function(json){
	        	$("#seasonTabTmp").tmpl(json).appendTo("#season");
	        },
	        complete : function(data) {
	        	setDelay();
	        }
	    });
	}
}
function getWebzine(){
	var webzine_list = $(".webzine_list").children().html();
	if(webzine_list)		return false;

	var loadUrl = "/mobilefirst/api/main/trendWebzine.json";
	var vHtml = "";

	$.ajax({
		url: loadUrl,
		dataType:"JSON",
		success: function(result){
			if(result.trend_Webzine){

				result.trend_Webzine = shuffle(result.trend_Webzine);

				$.each(result.trend_Webzine, function(i,v){
					vHtml += "<li> ";
					vHtml += "<a href='javascript:///' class=\"webzine_area\" kbUrl=\""+v.url+"\" data-no='"+v.kbno+"'> ";
					if(i < 3) vHtml += "	<img src='"+v.img+"' alt='' class='m_img' /> ";
					else vHtml += "	<img data-original='"+v.img+"' alt='' class='m_img lazy' src="+IMG_ENURI_COM+"'/images/m_home/noimg.png' /> ";

					vHtml += "	<div class=\"wcont\"> ";
					vHtml += "		<div class=\"inner\"> ";
					vHtml += "			<p class=\"tit\">"+v.title+"</p> ";
					vHtml += "			<p class=\"info\">"+v.content+"</p> ";
					vHtml += "			<p class=\"date\">"+v.date.substring(0, 10)+"</p> ";
					vHtml += "		</div> ";
					vHtml += "	</div> ";
					vHtml += "</a> ";
					vHtml += "</li> ";
				});
			}
			$(".webzine_list").html(vHtml);
			$(".webzine_area").each(function(){
				$(this).on("click",function(event) {
					var kbno = $(this).attr("data-no");
					ga('send', 'event', 'mf_트렌드웹진', 'click_trend_news', 'trend_news_'+kbno);
					window.open($(this).attr("kbUrl"));
				});
			});
		},complete : function(data) {
        	$(".m_img.lazy").lazyload({
        		effect:'fadeIn',
                threshold:500,
                failure_limit:2 ,
                skip_invisible : true
        	});
			setDelay();
        }
	});
}
$(document).ready(function(){
        mainBannerLoading(); //배너로딩
        iconLoading(); //아이콘로딩
        mainGoodsListLoading();
        martGoodsLoading(); //마트배너
        swiperAll.on('onSlideChangeStart', function (obj) {

            $(".newgnb > li a").removeClass();
            $(".newgnb > li:eq("+obj.realIndex+") > a").addClass("on");
            $(window).scrollTop(0);

            if(seasonYN == "Y"){
                
                if( obj.realIndex == 1){ //핫딜 베스트
                    getBaselist1(1);
                    $(".gnbarea").scrollLeft(0);
                    ga('send', 'event', 'mf_home', 'tab', 'tab_'+"핫딜베스트");
                }else if( obj.realIndex == 2){ //시즌텝
                    getSeasonTab(); //유플러스 쇼핑팁 확인
                    $(".gnbarea").scrollLeft(0);
                    ga('send', 'event', 'mf_home', 'tab', 'tab_'+"시즌텝");
                }else if( obj.realIndex == 3){//이벤트/기획전
                    ga('send', 'event', 'mf_home', 'tab', 'tab_'+'이벤트기획전');
                    getPlanBanner();
                }else if( obj.realIndex == 4){//특가모음
                    getBestlist1(1);
                    $(".gnbarea").scrollLeft(600);
                    ga('send', 'event', 'mf_home', 'tab', 'tab_'+'특가모음');
                }else if( obj.realIndex == 5){//마트핫픽
                    getMartGoodsLoading();
                    $(".gnbarea").scrollLeft(600);
                    ga('send', 'event', 'mf_home', 'tab', 'tab_'+'마트핫픽');
                }else if( obj.realIndex == 6){
                    ga('send', 'event', 'mf_home', 'tab', 'tab_'+'혜택페이지');
                }else if( obj.realIndex == 0){
                    $(".gnbarea").scrollLeft(0);
                    ga('send', 'event', 'mf_home', 'tab', 'tab_'+"홈");
                    if(nowpage == 7)	history.go(0);
                }
                
            }else{
                //시즌탭 없음
                if( obj.realIndex == 1){ //핫딜 베스트
                    getBaselist1(1);
                    $(".gnbarea").scrollLeft(0);
                    ga('send', 'event', 'mf_home', 'tab', 'tab_'+"핫딜베스트");
                }else if( obj.realIndex == 2){//이벤트/기획전
                    ga('send', 'event', 'mf_home', 'tab', 'tab_'+'이벤트기획전');
                    getPlanBanner();
                }else if( obj.realIndex == 3){//특가모음
                    getBestlist1(1);
                    $(".gnbarea").scrollLeft(600);
                    ga('send', 'event', 'mf_home', 'tab', 'tab_'+'특가모음');
                }else if( obj.realIndex == 5){
                    ga('send', 'event', 'mf_home', 'tab', 'tab_'+'혜택페이지');
                }else if( obj.realIndex == 0){
                    $(".gnbarea").scrollLeft(0);
                    ga('send', 'event', 'mf_home', 'tab', 'tab_'+"홈");
                    if(nowpage == 7)	history.go(0);
                }
            }
            nowpage = obj.realIndex;
            location.href = "#"+obj.realIndex;
            return false;
        });
    var pageloc = location.href;
    var swiperCnt = swiperAll.slides.length-2;
    
    if(seasonYN == "Y"){
    	
    	if( pageloc.indexOf("#1") > -1 )       swiperAll.slideTo(2);
        else if( pageloc.indexOf("#2") > -1 )  swiperAll.slideTo(3);  //쇼핑뉴스
        else if( pageloc.indexOf("#3") > -1 )  swiperAll.slideTo(4);  //쇼핑팁
        else if( pageloc.indexOf("#4") > -1 )  swiperAll.slideTo(5);
        else if( pageloc.indexOf("#5") > -1 )  swiperAll.slideTo(6);
        else if( pageloc.indexOf("#evt") > -1 )  goEventPlan();
        else if( pageloc.indexOf("#trend") > -1 )  {
        	location.replace("/knowcom/index.jsp");
        } else if( pageloc.indexOf("#plan") > -1 ){
        	if(swiperCnt >= 10)	swiperAll.slideTo(3);  
        	else         		swiperAll.slideTo(4);
        }
    	
    }else{
    	if( pageloc.indexOf("#1") > -1 )       swiperAll.slideTo(2);
        else if( pageloc.indexOf("#2") > -1 )  swiperAll.slideTo(3);  //이벤트기획전
        else if( pageloc.indexOf("#3") > -1 )  swiperAll.slideTo(4);  //쇼핑뉴스
        else if( pageloc.indexOf("#4") > -1 )  swiperAll.slideTo(5);  //쇼핑팁
        else if( pageloc.indexOf("#5") > -1 )  swiperAll.slideTo(6);
        else if( pageloc.indexOf("#6") > -1 )  swiperAll.slideTo(7);
        else if( pageloc.indexOf("#7") > -1 )  swiperAll.slideTo(8);
        else if( pageloc.indexOf("#evt") > -1 )  goEventPlan();
        else if( pageloc.indexOf("#trend") > -1 )  {
        	location.replace("/knowcom/index.jsp");
        } else if( pageloc.indexOf("#plan") > -1 ){
        	if(swiperCnt >= 10)	swiperAll.slideTo(3);  
        	else         		swiperAll.slideTo(4);
        }
        
    }

    //기획전 텝
	$(".newgnb > li > a").click(function() {
    //$("body").on('.newgnb > li', 'click' , function(event) {
		var gname = $(this).attr("data-id");
		
		if(seasonYN == "Y"){
			
			if(gname == "home")				swiperAll.slideTo(1);
			else if(gname == "hot")			swiperAll.slideTo(2);
			else if(gname == "season")			swiperAll.slideTo(3);
			else if(gname == "plan")			swiperAll.slideTo(4);
			else if(gname == "best")			swiperAll.slideTo(5);
			else if(gname == "mart")			swiperAll.slideTo(6);
			
		}else{
			if(gname == "home")					swiperAll.slideTo(1);
			else if(gname == "hot")				swiperAll.slideTo(2);
			else if(gname == "plan")			swiperAll.slideTo(3);
			else if(gname == "best")			swiperAll.slideTo(4);
			else if(gname == "mart")			swiperAll.slideTo(5);
			else if(gname == "pick")			swiperAll.slideTo(6);
		}
		return false;
	});
    //기획전 텝
	$(".newTab li").click(function() {
		$(".newTab li").removeClass("on");
		$(this).addClass("on");
		$(".cont_area.plan").hide();
		var activeTab = $(this).find("a").attr("href");
		$(activeTab).show();
		getEventBanner();
		if(activeTab.indexOf("tab01") > -1) ga('send', 'event', 'mf_plan_event', 'event_tab', 'tab_plan');
		else ga('send', 'event', 'mf_plan_event', 'event_tab', 'tab_benefit');
		return false;
	});
    //쇼핑팁+ 텝
	$("#tab_news li").click(function() {
		$("#tab_news li").removeClass("on");
		$(this).addClass("on");
		//getEventBanner();
		var id = $(this).find("a").attr("id");
		if(id == "bar_news2"){
			$("#GuideBody").hide();
			$("#NewsBody").show();
			setDelay();
		}else if(id == "bar_guide"){
			$("#NewsBody").hide();
			$("#GuideBody").show();
			getGuide_top();
			setDelay();
		}
		return false;
	});
	$(".mall_cate > li").click(function() {
		var alt = $(this).find("img").attr("alt");
		ga('send', 'event', 'mf_home', 'shop_top', 'shop_top_' + alt);
		
		var outLinkUrl = "";
		var shopCode = "";
		
		if(alt == "gmarket"){
			//outLinkUrl = "http://www.gmarket.co.kr/index.asp?jaehuid=200006254";
			outLinkUrl = "http://mobile.gmarket.co.kr/?jaehuid=200006254";
			shopCode = "536";
		}else if(alt == "auction"){
			outLinkUrl = "http://banner.auction.co.kr/bn_redirect.asp?ID=BN00181187";
			shopCode = "4027";
		}else if(alt == "11st"){
			outLinkUrl = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1000997249";
			shopCode = "5910";
		}else if(alt == "interpark"){
			outLinkUrl = "http://m.interpark.com/mobileGW.html?svc=Shop&bizCode=P14126&url=http://m.shop.interpark.com";
			shopCode = "55";
		}else if(alt == "tmon"){
			outLinkUrl = "http://m.tmon.co.kr/entry/?jp=80025&ln=214285";
			shopCode = "6641";
		}else if(alt == "wemake"){
			outLinkUrl = "https://mw.wemakeprice.com/affiliate/bridge?channelId=1000032";
			shopCode = "6508";
		}
		goGateShopUrl(shopCode,outLinkUrl);
	});
    /*** 카테고리 선택*/
    $("ul.m_depth li").on('click', function(event) {
        var $this = $(this);
        var index = $this.index();
        if($this.index() == 0)                 window.location.href = "/mobilefirst/cpp2.jsp?gcate=1";
        //else if($this.index() == 1)            window.location.href = "/mobilefirst/cpp.jsp?gcate=2";
        else if($this.index() == 1)            window.location.href = "/mobilefirst/cpp2.jsp?gcate=2";
        else if($this.index() == 2)            window.location.href = "/cpp/cpp_m.jsp";
        else if($this.index() == 3)            window.location.href = "/mobilefirst/cpp2.jsp?gcate=4";
        else if($this.index() == 4)            window.location.href = "/mobilefirst/cpp2.jsp?gcate=5";
        else if($this.index() == 5)            window.location.href = "/mobilefirst/cpp2.jsp?gcate=6";
        else if($this.index() == 6)            window.location.href = "/mobilefirst/cpp2.jsp?gcate=7";
        else if($this.index() == 7)            window.location.href = "/mobilefirst/cpp2.jsp?gcate=8";
        
        if( index == 8) { // 소셜
        	window.location.href = "/deal/newdeal/index.deal";
            ga('send', 'event', 'mf_home', 'sub', 'sub_' + $this.text());
        }else if( index == 9){//쇼핑지식
        	ga('send', 'event', 'mf_home', 'sub', 'sub_' + $this.text());
            //cateCurtainLoading("Y");
        	window.open("/knowcom/index.jsp");
            return;
        }
        ga('send', 'event', 'mf_home', 'sub', 'sub_' + $this.text());
    });
    $(".newMallList > li > a > img").click(function() {
        var mall = $(this).attr("alt");
        var outLinkUrl = "";
        var shopCode = "";
        if (mall) ga('send', 'event', 'mf_home', 'shop', 'shop_' + mall);
        
        if      (mall == '롯데닷컴'){    
        	shopCode="49"; 
        	outLinkUrl = "http://m.lotte.com/main_phone.do?udid=&cn=112346&cdn=783491";        
        }else if (mall == 'ssg'){    
        	shopCode="6665"; 
        	outLinkUrl = "http://m.ssg.com?ckwhere=enuri_mdirect";
        }else if (mall == '현대H몰'){     
        	shopCode="57"; 
        	//outLinkUrl = "http://www.hyundaihmall.com/front/shNetworkShop.do?NetworkShop=Html&ReferCode=s49&Url=http://www.hyundaihmall.com/Home.html";
        	outLinkUrl = "http://www.hyundaihmall.com/front/shNetworkShop.do?NetworkShop=Html&ReferCode=022&Url=http://www.hyundaihmall.com/Home.html";        }else if (mall == '갤러리아'){
        	shopCode="6620"; 
        	outLinkUrl = "https://mobile.galleria.co.kr/gate/initMain.action?chnl_no=2764";
        }else if (mall == 'GS SHOP'){
        	shopCode="75"; 
        	outLinkUrl = "http://with.gsshop.com/jsp/jseis_withLGeshop.jsp?DEVICE_BROWSER=Y&media=Pg&gourl=http://m.gsshop.com";
        }else if (mall == 'CJmall'){
        	shopCode="806"; 
        	outLinkUrl = "http://display.cjmall.com/m/main?infl_cd=I0580";
        }else if (mall == '롯데 홈쇼핑'){
        	shopCode="663"; 
        	outLinkUrl = "http://www.lotteimall.com/coop/affilGate.lotte?chl_no=140769&chl_dtl_no=2540476";
        }else if (mall == 'ak mall'){
        	shopCode="90"; 
        	outLinkUrl = "http://www.akmall.com/assc/associate.jsp?assc_comp_id=26392";
        }else if (mall == '홈앤쇼핑'){
        	shopCode="6588"; 
        	outLinkUrl = "http://m.hnsmall.com/channel/gate?channel_code=20200";
        }else if (mall == '11번가'){      
        	shopCode="5910"; 
        	outLinkUrl = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1000997249";
    	}else if (mall == '쿠팡'){
    		shopCode="7861"; 
    		outLinkUrl = "http://landing.coupang.com/pages/M_home?src=1033035&amp;spec=10305201&amp;lptag=Enuri_M_logo&amp;forceBypass=Y";
    	}else if (mall == 'dshop'){
    		shopCode="1878"; 
    		outLinkUrl = "http://www.dnshop.com/?Sid=0024_8H050000_01_01";
    	}else if (mall == '위메프'){
    		shopCode="6508"; 
    		outLinkUrl = "https://mw.wemakeprice.com/affiliate/bridge?channelId=1000032";
    	}else if (mall == '티몬'){
    		shopCode="6641"; 
    		//outLinkUrl = "http://m.ticketmonster.co.kr/entry/?jp=80025&ln=214285&DEVICE_BROWSER=Y";
    		outLinkUrl = "http://m.tmon.co.kr/entry/?jp=80025&ln=214285";
    	}else if (mall == '공영홈쇼핑'){
    		shopCode="7935"; 
    		outLinkUrl = "https://m.gongyoungshop.kr/gate/selectAliance.do?alcLnkCd=enrpcs&amp;tgUrl=/main.do";
    	}else if (mall == 'G9'){          
    		shopCode="7692"; 
    		outLinkUrl = "http://m.g9.co.kr/Default/Home?jaehuid=200006436";
    	}else if (mall == '지마켓'){
    		shopCode="536"; 
    		//outLinkUrl = "http://www.gmarket.co.kr/index.asp?jaehuid=200006254";
    		outLinkUrl = "http://mobile.gmarket.co.kr/?jaehuid=200006254";
    	}else if (mall == '옥션'){
    		shopCode="4027"; 
    		outLinkUrl = "http://banner.auction.co.kr/bn_redirect.asp?ID=BN00181187";
    	}else if (mall == '인터파크'){
    		shopCode="55"; 
    		outLinkUrl = "http://m.interpark.com/mobileGW.html?svc=Shop&bizCode=P14126&url=http://m.shop.interpark.com";
    	}else if (mall == '엘롯데'){
    		shopCode="6547"; 
        	outLinkUrl = "https://m.display.ellotte.com/display-mo/shop?chnlNo=100023&chnlDtlNo=1000023";
    	}else if (mall == 'NSmall'){
    		shopCode="974"; 
    		outLinkUrl = "http://m.nsmall.com/mjsp/site/gate.jsp?co_cd=190&target=http%3A%2F%2Fm.nsmall.com%2FMainView";
		}
        goGateShopUrl(shopCode,outLinkUrl);
        return false;
    });
     /***  메인 팝업 닫기     */
    $("#mainLayer .btn_close").on('click', function() {         $("#mainLayer").hide();    });
    /*
    (function userPopUp() {
    	if(cUserId != ""){
    		if (getCookie('userpopup') != "CHECKED") {
            	jQuery.getJSON("/mobilefirst/member/getAuthInfo.jsp", null, function(data) {
            		if(data.loginLayer == "1"){
            			alert(cUserId+"님의 본인인증상태가 해제되었습니다.마이 에누리에서 본인인증을 다시 진행해주세요.(다른 회원이 동일번호로 본인인증에 성공한 경우 자동 해제될 수 있습니다.)");
            		}else if(data.loginLayer == "2"){
            			alert(cUserId+"님의 회원정보를 최신정보로 업데이트 해주세요. 회원정보는 PC사이트에서 수정하실 수 있습니다.");
            		}
            		fnEverSetCookie("userpopup", "CHECKED", 7);
            	});
            }
    	}
    })();
    */
    $("body").on('click', "#termButton", function(event) {    window.open("/mobilefirst/login/policy.jsp?param=1");    });
    $("body").on('click', "#emoneyButton", function(event) {  window.open("/mobilefirst/login/policy.jsp?param=3");    });
    $("body").on('click', "#replaceN", function(event) {
        setCookie("tempYN","Y",365);
        $("#terms").remove();
    });
    //메인 팝업 레이어 오늘하루 띠우지 않기
    var $mainLayer = $("#mainLayer");
    /*
    $mainLayer.find(".btn_today").on('click', function() {
        fnEverSetCookie("linker_popup3", "CHECKED", 3);
        $mainLayer.hide();
    });
    */
    $("body").on('click', '.s_area_inner > img', function(event) {
        var url = $(this).attr("data-url").trim();
        var num = $(this).attr("data-num").trim();

        $(".newgnb li > a").each(function(i,v){
        	var sName = $(this).attr("data-id");
        	if(sName == "season"){
        		seasonName = $(this).text();
        	}
        });

        if( url == "" ){
        }else{
        	ga('send', 'event', 'mf_season_banner type', seasonName , "banner_"+num);
        	//location.href=url;
        	window.open(url);
        	return false;
        }

    });
    //기존용 2017 07 12
     $("body").on('click', '.btn_today', function(event) {
        fnEverSetCookie("linker_popup3", "CHECKED", 7);
        $mainLayer.hide();
    });
     //임시 커피용 2017 07 12
     $("body").on('click', '#coffee_close', function(event) {
    	 //X 하루 닫기
    	 event.stopPropagation();
         fnEverSetCookie("linker_popup3", "CHECKED", 1);
         $mainLayer.hide();
     });
     $(".week_close").click(function(event) {
    	 event.stopPropagation();
    	 //일주일 동안 보지 않기
         fnEverSetCookie("linker_popup3", "CHECKED", 7);
         $mainLayer.hide();
     });
     $("body").on('click', '.myset', function(event) {
    	 ga('send', "event", "mf_home", "CRAZY_deal", "전체보기");
    	 location.href = "/mobilefirst/evt/mobile_deal.jsp?freetoken=event";
    	 return false;
     });
     $("body").on('click', '.frontLayer > ul > li', function(event) {
        var url = $(this).attr("data-id");
        var alt = $(this).children().attr("alt");
        ga('send', 'event', 'mf_home', 'event', alt);
        location.href = url;
        return false;
    });
     $(window).scroll(function(){
    	 var endpx = ($(document).height() - $(window).height())-1000;

		 if($(window).scrollTop() > endpx){ //최하단의 위치값과 동일여부
			 lastPosted(); //스크롤페이징 ajax 호출 스크립트
		 }
		 var height = $(document).scrollTop();
		 //if( !resizeYN ){ //리사이즈는 마지막에 한번만 한다
			 if(height > 36000){
				 swiperAll.onResize();
				 resizeYN = true;
			 }
		 //}
		 if($(window).scrollTop() == $(document).height() - $(window).height()){
			 swiperAll.onResize();
			 return false;
		 }
	 });
     getCommingDeal();

     indexBannerLayer();
     /***  이벤트 팝업*/
});
function goGateShopUrl(shop,url){
	window.open("/mobilefirst/move2.jsp?vcode="+shop+"&url="+encodeURIComponent(url));	
	return false;
}
	
function noticePopUp() {
    // 해당 날짜까지 노출
    //if (datePopUpSet("2016/03/31", "popup")) {        //return;        //}
    if (getCookie('linker_popup3') != "CHECKED") {
        $("#mainLayer").show();
        $(window).scrollTop();
    }
}

function goEventCoffee(url){
	ga('send', 'event', 'mf_home', 'event', "첫구매 이벤트 이디야커피");
	//location.href = "/mobilefirst/evt/welcome_event.jsp?tab=1&freetoken=event";
	location.href = url;
	return false;
}
function mainLayerOneDay(){
	$("#mainLayer").hide();
	setCookie("linker_popup3", "CHECKED", 1);
}
//메인상품 로딩
function mainGoodsListLoading() {
        var nowUrl = document.URL;
        var ajaxUrl = "";

        if(nowUrl.indexOf("m.enuri.com") > -1)  ajaxUrl = "/mobilefirst/http/json/hotdealRank.json";
        else if(nowUrl.indexOf("preview") > -1) ajaxUrl = "/mobilefirst/api/main/mobile_mainlistpreview.json";
        else if( nowUrl.indexOf("dev.enuri.com") > -1 ) ajaxUrl = "/mobilefirst/http/json/hotdealRankDev.json";
        else ajaxUrl = "/mobilefirst/http/json/hotdealRank.json";

    		$.ajax({
    	        type: "GET",
    	        url: ajaxUrl,
    	        async: false,
    	        dataType:"JSON",
    	        success: function(json){
    	        	//mainGoodsListHtml(ajaxUrl,mainGoodsJson);
    	        	//var setJson = {"goodsList":json};
    	        	try{
    	        		if(nowUrl.indexOf("preview") > -1 ) json = json.MainJsonpreview;
	    	        	var mainGoodsTDCN = new Array();
	    	        	//try catch 걸어 catch 알람톡 발송해
	    	        	//Err_500.jsp 242 라인 참고
	    	        	$.each(json,function(i,v){
	    	        		if(v.part == "T" || v.part == "D" || v.part == "C" || v.part == "N") mainGoodsTDCN.push(v);
	    	        		if(v.part == "A" ) mainGoodsA.push(v);
	    	        		if(v.part == "G") mainGoodsG.push(v);
	    	        		if(v.part == "Q" ) mainGoodsQ.push(v);
	    	        		if(v.part == "S")  mainGoodsSocial.push(v);
	    	        	});
	    	        	mainGoodsQ = shuffle(mainGoodsQ);
	    	        	mainGoodsTDCN = shuffle(mainGoodsTDCN);
	    	        	mainGoodsA = shuffle(mainGoodsA);
	    	        	mainGoodsG = shuffle(mainGoodsG);
	    	        	mainGoodsSocial = shuffle(mainGoodsSocial);

	    	        	$.each(mainGoodsTDCN,function(i,v){//관리상품 10개
	    	        		if(nowUrl.indexOf("preview") > -1){
	    	        			mainGoodsFirstJson.push(v);
	    	        		}else{
	    	        			if(i < 10) mainGoodsFirstJson.push(v);
	    	        		}

	    	        	});

	    	        	$.each(mainGoodsSocial,function(i,v){//4개는 소셜상품
	    	        		if(i < 4) mainGoodsFirstJson.push(v);
	    	        	});
	    	        	var mainGoodsQTempArray = new Array();

	    	        	$.each(mainGoodsQ,function(i,v){
	    	        		mainGoodsQTempArray.push(v);
	    	        		if(i == 2) return false;
	    	        	});

	    	        	if(mainGoodsQTempArray.length > 0){//Q타입 가공
	    					var qPart = new Object();
	    					qPart.part = "QQ";
	    					qPart.list = mainGoodsQTempArray;
	    					mainGoodsFirstJson.push(qPart);
	    				}
	    	        	$.each(mainGoodsTDCN,function(i,v){ //관리상품 3개
	    	        		if(i >= 10 && i <= 12)		mainGoodsFirstJson.push(v);
	    	        	});

	    	        	if(mainGoodsSocial.length > 5){
	    	        		mainGoodsFirstJson.push(mainGoodsSocial[4]);
	    	        	}
	    	        	if( nowUrl.indexOf("preview") > -1 ){

	    	        		$.each(mainGoodsA,function(i,v){
		    	        		mainGoodsFirstJson.push(this);
		    	        	});

	    	        		$.each(mainGoodsG,function(i,v){
		    	        		mainGoodsFirstJson.push(this);
		    	        	});

	    	        	}else{
	    	        		if(mainGoodsA.length > 0)  	mainGoodsFirstJson.push(mainGoodsA[0]);
	    	        	}

	    	        	//20번구좌끝
	    	        	$("#mainGoodsList").tmpl(mainGoodsFirstJson).appendTo("#today_list");
	    	        	//mainGoodsListHtml(ajaxUrl,setJson);

	    	        	var middleLink = "";

	    	        	if( nowUrl.indexOf("dev.enuri.com") > -1  ) middleLink = "http://ad-api.enuri.info/enuri_M/m_main/M2/bundle?bundlenum=2";
	    	        	else middleLink = "/mobilefirst/ajax/middle_banner.json";

	    	        	$.ajax({
	    	    	        type: "GET",
	    	    	        url: middleLink,
	    	    	        async: false,
	    	    	        dataType:"JSON",
	    	    	        success: function(json){

	    	    	        	var mbJson = json;
	    	    				var selVal = Math.floor(Math.random() * mbJson.length);
	    	    				mbJson = mbJson[selVal];
	    	    				if(mbJson){
	    	    					var mbanner =  "<li class=\"bnrarea\" onclick=\"javascript:middleBannerGo('"+mbJson.JURL1+"','"+mbJson.TXT1+"')\">";
	    	    						if( nowUrl.indexOf("dev.enuri.com") > -1 ){
	    	    							mbanner += "<img src='"+mbJson.IMG1+"' onerror=\"if (this.src != '"+IMG_ENURI_COM+"/images/mobilefirst/noimg_plan.png') this.src = '"+IMG_ENURI_COM+"/images/mobilefirst/noimg_plan.png';\">";
	    	    						}else{
	    	    							mbanner += "<img src='"+mbJson.TARGET+"' onerror=\"if (this.src != '"+IMG_ENURI_COM+"/images/mobilefirst/noimg_plan.png') this.src = '"+IMG_ENURI_COM+"/images/mobilefirst/noimg_plan.png';\">";
	    	    						}
	    	    						mbanner += "</li>";
	    	    					$("#today_list li:eq(3)").after($(mbanner));
	    	    				}
	    	    	        }
	    	        	});

	    	        	/*
	    				var mbJson = JSON.parse(middleBanner);
	    				var selVal = Math.floor(Math.random() * mbJson.length);
	    				mbJson = mbJson[selVal];
	    				if(mbJson){
	    					var mbanner =  "<li class=\"bnrarea\" onclick=\"javascript:middleBannerGo('"+mbJson.JURL1+"','"+mbJson.TXT1+"')\">";
	    						mbanner += "<img src='"+mbJson.TARGET+"' onerror=\"if (this.src != 'http://imgenuri.enuri.gscdn.com/images/mobilefirst/noimg_plan.png') this.src = 'http://imgenuri.enuri.gscdn.com/images/mobilefirst/noimg_plan.png';\">";
	    						mbanner += "</li>";
	    					$("#today_list li:eq(3)").after($(mbanner));
	    				}
	    				*/
					}catch(e){
						console.log("main상품로딩오류"+e);
					}

    	        },complete : function(data) {
    	        	zzimCheckSet();
    	        	var home_plan = new Swiper('#home_plan', {slidesPerView: 'auto'});
    	        	swiperLoading();
    	        	//if(mainGoodsQQJson.length > 0){
    			    //}
    	        	$("img.lazy").lazyload({
    	        		effect:'fadeIn',
	                    threshold:500,
	                    failure_limit:2 ,
	                    skip_invisible : true
    	        	});
    	        	setDelay();
    	        }
    	    });
}
function goEventPlan(){//혜택이벤트 링크
	swiperAll.slideTo(swiperAll.slides[3].id == "season" ? 4 : 3);
	setTimeout(function(){
	$(".newTab > li ").each(function(i,v){
		if(i > 0) $(".newTab > li ").eq(1).trigger("click");
	});
	ga('send', 'event', 'mf_hidden_tab', 'click', "click");

	},500);
}
function mainGoodsListHtml(ajaxUrl,listJson){
	if( ajaxUrl.indexOf("/mobilefirst/api/main/mobile_mainlistpreview.json") > -1 )	$("#mainGoodsList").tmpl(listJson.MainJsonpreview).appendTo("#today_list");
	else	$("#mainGoodsList").tmpl(listJson).appendTo("#today_list");
}
        var random = 0;
        var selnum = 0;
            (function(){
                Date.prototype.format = function(f) {
                    if (!this.valueOf()) return " ";

                    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
                    var d = this;

                    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
                        switch ($1) {
                            case "yyyy": return d.getFullYear();
                            case "yy": return (d.getFullYear() % 1000).zf(2);
                            case "MM": return (d.getMonth() + 1).zf(2);
                            case "dd": return d.getDate().zf(2);
                            case "E": return weekName[d.getDay()];
                            case "HH": return d.getHours().zf(2);
                            case "hh": return d.getHours().zf(2);
                            case "mm": return d.getMinutes().zf(2);
                            case "ss": return d.getSeconds().zf(2);
                            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
                            default: return $1;
                        }
                    });
                };
                String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
                String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
                Number.prototype.zf = function(len){return this.toString().zf(len);};

                var loadUrl = "/mobilefirst/http/json/mobile_deal_list.json";

                $.ajax({
                    url: loadUrl,
                    dataType: 'json',
                    async: false,
                    success: function(json){
                        var seq = [];
                        var type = 0;
                        var total = 0;
                        var temp = "";
                        var template = "";
                        var todayAtMidn = new Date().format("yyyyMMddhhmmss");
                        todayAtMidn = todayAtMidn * 1;
                        var todayAtMidnDay = new Date().format("yyyyMMdd");
                        todayAtMidnDay = todayAtMidnDay * 1;

                        var nearestSeq = 0;

                        if(json){
                            if( !seq.length ){
                                for(var i=0; i<json.length; i++){
                                    if(todayAtMidnDay == json[i].GOODS_ST_SELLDATE_DIF.substring(0,8)){
                                        if(
                                            (todayAtMidn > json[i].GOODS_ST_EXPODATE_DIF)
                                            && (todayAtMidn < json[i].GOODS_END_EXPODATE_DIF)
                                            && (json[i].GOODS_EXPO_FLAG == "Y")
                                            && (json[i].GOODS_URL_TYPE == 1)){
                                            type = json[i].GOODS_URL_TYPE;
                                        }
                                        if((todayAtMidn > json[i].GOODS_ST_EXPODATE_DIF)
                                            && (todayAtMidn < json[i].GOODS_END_EXPODATE_DIF)
                                            && (todayAtMidn < json[i].GOODS_END_SELLDATE_DIF)
                                            && (json[i].GOODS_EXPO_FLAG == "Y")
                                            && (json[i].GOODS_URL_TYPE == 1)
                                            && (json[i].GOODS_SOLD_FLAG == "N")){
                                            seq[seq.length] = json[i].SEQ;
                                            break;
                                        }
                                    }
                                }
                            }
                            if(!seq.length && type == 1){
                                for(var i=0; i<json.length; i++){
                                    if(
                                        (todayAtMidn > json[i].GOODS_ST_EXPODATE_DIF)
                                        && (todayAtMidn < json[i].GOODS_END_EXPODATE_DIF)
                                        && (json[i].GOODS_EXPO_FLAG == "Y")
                                        && (todayAtMidnDay < json[i].GOODS_ST_SELLDATE_DIF.substring(0,8))
                                        && (json[i].GOODS_URL_TYPE == 1)
                                        && (json[i].GOODS_SOLD_FLAG == "N")){
                                        seq[seq.length] = json[i].SEQ;
                                        break;
                                    }
                                }
                            }
                            if(!seq.length && type != 1){
                                seq = [];
                                for(var i=0; i<json.length; i++){
                                    if(
                                        (todayAtMidn > json[i].GOODS_ST_EXPODATE_DIF)
                                        && (todayAtMidn < json[i].GOODS_END_EXPODATE_DIF)
                                        && (json[i].GOODS_EXPO_FLAG == "Y")
                                        && (json[i].GOODS_SOLD_FLAG == "N")
                                        && (json[i].GOODS_URL_TYPE == 2)){
                                        seq[seq.length] = json[i].SEQ;
                                    }
                                }
                                for(var i=0; i<json.length; i++){
                                    if(
                                        (todayAtMidn > json[i].GOODS_ST_EXPODATE_DIF)
                                        && (todayAtMidn < json[i].GOODS_END_EXPODATE_DIF)
                                        && (json[i].GOODS_EXPO_FLAG == "Y")
                                        && (todayAtMidnDay < json[i].GOODS_ST_SELLDATE_DIF.substring(0,8))
                                        && (json[i].GOODS_URL_TYPE == 1)
                                        && (json[i].GOODS_SOLD_FLAG == "N")){
                                        seq[seq.length] = json[i].SEQ;
                                        break;
                                    }
                                }
                            }

                            /*
                            if( seq.length )  random = seq[Math.floor(Math.random() * seq.length)];

                            if(random ==  0 ){
                                var html = "";
                                     html += "<div class=\"newLayer\">";
                                     html += "   <ul>";
                                     html += "      <li><a href=\"javascript:///\" class=\"btn_new\" id=\"btnNew\">e 머니 드려봄</a></li>";
                                     html += "       <li><a href=\"javascript:///\" class=\"btn_buy\" id=\"btnBuy\">모바일 어워드 수상</a></li>";
                                     html += "   </ul>";
                                     html += "   <a href=\"javascript:;\" class=\"btn_today\">오늘 하루 보지 않기</a>";
                                     html += "   <a href=\"javascript:;\" class=\"btn_close\" >닫기</a>";
                                     html += "</div>";
                                     $(".dealLayer").html(html);
                              }
                             */

                            for(var i=0; i<json.length; i++){
                                 //메인레이어 에누리딜 상품 노출
                            	//if(random == json[i].SEQ)   selNum = i;

                                if(!nearestSeq && isAvailableDealGoods(json[i]) ) nearestSeq = json[i].SEQ;

                                if((todayAtMidn > json[i].GOODS_ST_EXPODATE_DIF) && (todayAtMidn < json[i].GOODS_END_EXPODATE_DIF) && (json[i].GOODS_EXPO_FLAG == "Y")){

                                    if(json[i].GOODS_SOLD_FLAG == "Y" || todayAtMidn > json[i].GOODS_END_SELLDATE_DIF ||  json[i].GOODS_QUANTITY == 0  ){

                                    	if(json[i].GOODS_URL_TYPE == "1"){
                                    		temp += "<li class='soldout swiper-slide' data-type='O'  data-seq='"+json[i].SEQ+"' data-code='"+json[i].GOODS_COMPANY+"' data-stdate='"+json[i].GOODS_ST_SELLDATE_DIF.substring(0,8)+"' >";
                                            temp += "<div class='edeal_area' onclick='javascript:deal_click(\""+json[i].GOODS_NAME+"\", \"O\", \""+json[i].GOODS_URL+"\", \""+json[i].GOODS_URL_TYPE+"\", \""+json[i].GOODS_COMPANY+"\", \""+json[i].SEQ+"\" ,  \""+json[i].GOODS_MODELNO+"\" )'>";
                                            temp += "<span class='soldout'>SOLD OUT</span>";
                                    	}else{
                                    		temp += "<li class='soldout swiper-slide' data-type='E'  data-seq='"+json[i].SEQ+"' data-code='"+json[i].GOODS_COMPANY+"' data-stdate='"+json[i].GOODS_ST_SELLDATE_DIF.substring(0,8)+"' >";
                                            temp += "<div class='edeal_area' onclick='javascript:deal_click(\""+json[i].GOODS_NAME+"\", \"E\", \""+json[i].GOODS_URL+"\", \""+json[i].GOODS_URL_TYPE+"\", \""+json[i].GOODS_COMPANY+"\", \""+json[i].SEQ+"\" ,  \""+json[i].GOODS_MODELNO+"\" )'>";
                                            if(json[i].EVENT_NO && json[i].EVENT_SOLDOUT_YN == 'Y' ){
                                            	temp += "<span class='soldout'>SOLD OUT</span>";
                                            }
                                    	}
                                    }else{
                                        if(todayAtMidn <= json[i].GOODS_ST_SELLDATE_DIF){
                                            if(json[i].GOODS_URL_TYPE == "1"){
                                            	temp += "<li class='soon swiper-slide' data-type='S' data-seq='"+json[i].SEQ+"' data-code='"+json[i].GOODS_COMPANY+"' data-stdate='"+json[i].GOODS_ST_SELLDATE_DIF.substring(0,8)+"'>";
                                                temp += "<div class='edeal_area' onclick='javascript:deal_click(\""+json[i].GOODS_NAME+"\",  \"S\", \""+json[i].GOODS_URL+"\", \""+json[i].GOODS_URL_TYPE+"\", \""+json[i].GOODS_COMPANY+"\", \""+json[i].SEQ+"\" , \""+json[i].GOODS_MODELNO+"\" )'>";
                                            	temp += "<span class='soon'>"+json[i].GOODS_TAG+"</span>";

                                            }else{
                                            	temp += "<li class='soon swiper-slide' data-type='E' data-seq='"+json[i].SEQ+"' data-code='"+json[i].GOODS_COMPANY+"' data-stdate='"+json[i].GOODS_ST_SELLDATE_DIF.substring(0,8)+"'>";
                                                temp += "<div class='edeal_area' onclick='javascript:deal_click(\""+json[i].GOODS_NAME+"\",  \"E\", \""+json[i].GOODS_URL+"\", \""+json[i].GOODS_URL_TYPE+"\", \""+json[i].GOODS_COMPANY+"\", \""+json[i].SEQ+"\" , \""+json[i].GOODS_MODELNO+"\" )'>";
                                                if(json[i].EVENT_NO ){
                                                	temp += "<span class='soon'>"+json[i].GOODS_TAG+"</span>";
                                                }
                                            }

                                        }else{
                                        	if(json[i].GOODS_URL_TYPE == "2"){
                                        		temp += "<li class='attand swiper-slide' data-type='E'  data-seq='"+json[i].SEQ+"' data-code='"+json[i].GOODS_COMPANY+"' data-stdate='"+json[i].GOODS_ST_SELLDATE_DIF.substring(0,8)+"'>";
                                                temp += "<div class='edeal_area' onclick='javascript:deal_click(\""+json[i].GOODS_NAME+"\",  \"E\"  ,\""+json[i].GOODS_URL+"\", \""+json[i].GOODS_URL_TYPE+"\", \""+json[i].GOODS_COMPANY+"\", \""+json[i].SEQ+"\" , \""+json[i].GOODS_MODELNO+"\" )'>";
                                                if( json[i].EVENT_NO && json[i].EVENT_SOLDOUT_YN == 'Y' ){
                                                	temp += "<span class='soldout'>SOLD OUT</span>";
                                                }
                                        	}else{
                                                temp += "<li class='attand swiper-slide' data-type='A' data-seq='"+json[i].SEQ+"' data-code='"+json[i].GOODS_COMPANY+"' data-stdate='"+json[i].GOODS_ST_SELLDATE_DIF.substring(0,8)+"'>";
                                                temp += "<div class='edeal_area' onclick='javascript:deal_click(\""+json[i].GOODS_NAME+"\",  \"A\"  ,\""+json[i].GOODS_URL+"\", \""+json[i].GOODS_URL_TYPE+"\", \""+json[i].GOODS_COMPANY+"\", \""+json[i].SEQ+"\" , \""+json[i].GOODS_MODELNO+"\" )'>";
                                        	}
                                        }
                                    }

                                    temp += "<div id='zoom_img'>";
                                    temp += "<img src='"+STORAGE_ENURI_COM+"/Web_Storage"+json[i].GOODS_BIG_IMG+"' alt=\"\" class=\"thum\" />";
                                    temp += "</div>";
                                    //temp += "<span class='mall'>";
                                    //if(json[i].GOODS_COMPANY != "") temp += "<img src='http://imgenuri.enuri.gscdn.com/images/view/ls_logo/2013/Ap_logo_"+json[i].GOODS_COMPANY+".png'>";
                                    //else temp += "&nbsp;";
                                    //temp += "</span>";
                                    
                                    //json[i].GOODS_COMPANY = "8090";
                                    
                                    //if(json[i].GOODS_COMPANY == "8090"){
                                    temp += "<a href='javascript:///'>";
                                    //}
                                    temp += "<strong>"+json[i].GOODS_NAME+"<br/>"+json[i].GOODS_NAME_SUB+"</strong>";
                                    
                                    if(json[i].GOODS_COMPANY == "8090"){
                                    	temp += "<span class=\"market market3\">테일리스트</span>";	
                                    }else if(json[i].GOODS_COMPANY == "55"){
                                    	temp += "<span class=\"market market1\">인터파크</span>";
                                    }
                                    
                                    temp += "<div class='price'>";

                                    var goods_sale_price = Number(json[i].GOODS_SALE_PRICE);
                                    var goods_price = Number(json[i].GOODS_PRICE);
                                    if( json[i].EVENT_NO ){
                                    	if(json[i].GOODS_URL_TYPE == "2" )       temp += "<span class=\"sale evt\">EVENT</span>"; //이벤트인 경우
                                    }else{
                                    	if(json[i].GOODS_SALE_PER != ""){	temp += "<span class='sale'><b>"+json[i].GOODS_SALE_PER+"</b>%<em>"+json[i].GOODS_QUANTITY+"개</em></span>"; }
                                    	
                                    	//json[i].GOODS_PRICE_MARK_HEAD = "$";
                                    	//json[i].GOODS_PRICE_MARK_TAIL = "";
                                    	
                                    	if(json[i].GOODS_PRICE_MARK_HEAD == "" && json[i].GOODS_PRICE_MARK_TAIL == ""){
                                    		if(json[i].GOODS_SALE_PRICE != "" && goods_sale_price > 0){	temp += "<span class='prc'><b>"+numberWithCommas(json[i].GOODS_SALE_PRICE)+"</b>원</span>"; }
                                            if(json[i].GOODS_PRICE != "" && goods_price > 0 ){		temp += "<del><b>"+numberWithCommas(json[i].GOODS_PRICE)+"</b>원</del>"; }	
                                    	}else if(json[i].GOODS_PRICE_MARK_HEAD != "" && json[i].GOODS_PRICE_MARK_TAIL == ""){
                                    		if(json[i].GOODS_SALE_PRICE != "" && goods_sale_price > 0){	temp += "<span class='prc'><b>$"+numberWithCommas(json[i].GOODS_SALE_PRICE)+"</b></span>"; }
                                            if(json[i].GOODS_PRICE != "" && goods_price > 0 ){		temp += "<del><b>$"+numberWithCommas(json[i].GOODS_PRICE)+"</b></del>"; }
                                    	}else if(json[i].GOODS_PRICE_MARK_HEAD == "" && json[i].GOODS_PRICE_MARK_TAIL != ""){
                                    		if(json[i].GOODS_SALE_PRICE != "" && goods_sale_price > 0){	temp += "<span class='prc'><b>"+numberWithCommas(json[i].GOODS_SALE_PRICE)+"$</b></span>"; }
                                            if(json[i].GOODS_PRICE != "" && goods_price > 0 ){		temp += "<del><b>"+numberWithCommas(json[i].GOODS_PRICE)+"$</b></del>"; }
                                    	}
                                        if(json[i].GOODS_URL_TYPE == "2" )       temp += "<span class=\"sale evt\">EVENT</span>"; //이벤트인 경우
                                    }
                                    temp += "<ul class='e_info'></ul>";
                                    temp += "</div>";
                                    //if(json[i].GOODS_COMPANY == "8090"){
                                    temp += "</a>";
                                    //}
                                    temp += "</div>";
                                    temp += "</li>";
                                }
                            }
                        }
                        $(".deal_goods").html(temp);
                        //edeal
                         var swiperDeal = new Swiper('#home_deal', {  slidesPerView: 'auto', centeredSlides: true, loop: true });
                         var todayNum = 0;
                         try{

                        	 if(nearestSeq > 0){
                            	 $(".deal_goods > li").each(function(i,v){
                            		 var id = $(this).attr("data-seq");
                            		 var stdate = $(this).attr("data-stdate");//판매시작시간

                            		 if(stdate == todayAtMidnDay){
                            			 
                            			 var type = $(this).attr("data-type");
                            			 if("O" == type) todayNum = i+1;
                            			 else todayNum = i;
                            			 swiperDeal.slideTo(todayNum);	 
                            		 }
                            		 if(nearestSeq == id){
                            			 todayNum = i;
                            			 swiperDeal.slideTo(todayNum);
                            			 return false;
                            		 }
                            		 //json[i].SEQ
                            	 });
                             }

                         }catch(e){
                        	 console.log("nearestSeq error:"+e);
                         }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {}
                });
                $(".deal_goods").on('touchstart', function(e){
                    if(window.android && android.onTouchStart){
                        window.android.onTouchStart();
                    }else if( $("#ios").val()){ }
                });
                $(".go_app").click(function(){	webInstall();	});
                $( ".thumb li a" ).click(function() {
                    $(this).parent().addClass("on").siblings().removeClass("on");
                    selnum = $(this).attr("value");
                    return false;
                });
            })();

function isAvailableDealGoods(json){
    return     json.GOODS_PRICE != null              &&
               json.GOODS_PRICE.length > 0            &&
               json.GOODS_SOLD_FLAG == "N"                &&
               json.GOODS_EXPO_FLAG == "Y"            //&&
               //!json.GOODS_URL.includes("event_id");
}

function edealGoodViewGA(){
   $(".deal_goods > div > div > li").each(function(){
      var tempSeq = $(this).attr("data-seq");
      var tempClass = $(this).attr("class");
      if(tempClass.indexOf("slick-current") > -1){
        var modeNmTxt = $(this).find("strong").text();
        ga('send', 'event', 'mf_home', 'enuri_deal_imp', tempSeq+'_'+modeNmTxt);
      }
   });
}
function mainBannerLoading(){//메인배너로딩

	var mainBannerLink = "";
	if( nowUrl.indexOf("dev.enuri.com") > -1  ){
		mainBannerLink = "http://ad-api.enuri.info/enuri_M/m_main/M1/bundle?bundlenum=11";
	}else{
		mainBannerLink = "/mobilenew/gnb/category/mainBanner.json";
	}

	$.ajax({
            type: "GET",
            url: mainBannerLink,
            async: false,
            dataType:"json",
            success: function(json){
            $("#mainBanner").tmpl(json).appendTo("#mainEvtbnr");
                $.each(json, function(i, v){
                    var $iFrm = $('<iframe id="iFrm" name="iFrm" scrolling="no"  width="0" height="0" frameborder="0" ></iframe>');
                    $iFrm.attr('src', v.IMG1);
                    $iFrm.appendTo('body');
                    //var imgSrc = new Image();
                    //imgSrc.src = v.IMG1;
                });
            },complete : function(data) {
                //상단배너

            	setTimeout(function(){

            		var swiperBanner = new Swiper('#home_bnr', {
                        pagination: '.pagination',
                        nextButton: '.btn_next',
                        prevButton: '.btn_prev',
                        paginationClickable: true,
                        spaceBetween: 30,
                        centeredSlides: true,
                        autoplay: 3500,
                        autoplayDisableOnInteraction: false,
                        loop: true,
                        lazyLoading: true
                    });

                },500);

            }
        });
}
function iconLoading(){ //아이콘 로딩
    var subJson = JSON.parse(subBannerIcon);
    var html = "";
    $.each(subJson, function(i, v){
        if(v.iosYN == 'N' && v.androidYN =='N')  html += "<li onclick=\"goIconWebMoveLink( '"+v.link+"' , '"+v.title+"'  ) \"><img src='"+v.imgSrc+"' alt='"+v.title+"' ><span>"+v.title+"</span></li>";
    });
    $(".evt_cate").html(html);
}
function termsLayer(){
    $("#revisedTermsofUse").tmpl().appendTo("#terms");
    $("#terms").show();
}
function goIconWebMoveLink(url,title){
	ga('send', 'event', 'mf_home', 'eventzone', title+"_WEB");
	if(title == '이벤트'){
		goEventPlan();
		return false;
	}
	location.href = url;
	return false;
}
function numberWithCommas(x) {    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");}
function onoff(id) {
    var mid=document.getElementById(id);
    if(mid.style.display=='')                     mid.style.display='none';
    else                    mid.style.display='';
}
function webInstall(param){
    var url;
    if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        url = "https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8";
    }else if(navigator.userAgent.indexOf("Android") > -1){
        url = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3Denuri_deal%26utm_campaign%3Denuri";
    }
    window.location.href = url;
}
function deal_click(GOODS_NAME,TYPE , GOODS_URL, GOODS_URL_TYPE, GOODS_COMPANY, SEQ , MODELNO){
	//goCrazyDeal("+json[i].GOODS_COMPANY+","+json[i].SEQ+");
	if(!IsLogin() && "E" != TYPE) {
		alert("로그인 후 참여할 수 있습니다.");
		return false;
	}
	if("S" == TYPE){//soon
		ga('send', 'event', 'mf_home', 'CRAZY_deal', MODELNO+'_'+GOODS_NAME+'_판매예정('+SEQ+')');
        if(MODELNO && MODELNO > 0 )        	location.href = "/mobilefirst/detail.jsp?modelno="+MODELNO;
        else        	alert("판매예정 입니다.");
	}else if("O" == TYPE){//soldout
		ga('send', 'event', 'mf_home', 'CRAZY_deal', MODELNO+'_'+GOODS_NAME+'_판매완료('+SEQ+')');
        if(MODELNO && MODELNO > 0 )        	location.href = "/mobilefirst/detail.jsp?modelno="+MODELNO;
        else        	alert("품절입니다.");
	}else if("E" == TYPE){
		ga('send', 'event', 'mf_home', 'CRAZY_deal','[EVENT]'+GOODS_NAME+'_('+SEQ+')');
		location.href = GOODS_URL;
	}else{
		ga('send', 'event', 'mf_home', 'CRAZY_deal', MODELNO+'_'+GOODS_NAME+'구매('+SEQ+')');
		goCrazyDeal(GOODS_COMPANY,SEQ);
	}
}
 function mainDealLayer(json){
     var html = "";
         if(json){
          html =  "<a href='javascript:goEnuriDeal()'>";
          if(json.GOODS_URL_TYPE == '1')        html +="<span class=\"soon\">"+json.GOODS_TAG+"</span>";

          html +="<div id=\"zoom_img\"><img src='"+Web_Storage+"/Web_Storage"+json.GOODS_BIG_IMG+"' alt='' class=\"thum\"></div>";
          html +="<strong>"+json.GOODS_NAME+"</strong>";

              if(json.GOODS_URL_TYPE == '1'){
                  html +="<div class='price'>";
                  if(json.GOODS_SALE_PER)          html +="<span class=\"sale\"><b>"+json.GOODS_SALE_PER+"</b>%</span>";
                  if(json.GOODS_SALE_PRICE)          html +="<span class=\"prc\"><b>"+numberWithCommas(json.GOODS_SALE_PRICE)+"</b>원</span>";
                  if(json.GOODS_PRICE)          html +="<del><b>"+numberWithCommas(json.GOODS_PRICE)+"</b>원</del>";
                  html +="</div>";
              }else{
                  html +="<div class='price'>";
                  html +="<span style='font-size:18px'>"+ json.GOODS_TAG+"</span>";
                  html +="</div>";
              }
              html +="</a>";
              html +="<a href=\"javascript:///\" class=\"btn_today\">오늘 하루 보지 않기</a>";
              html +="<a href='javascript:///' class=\"btn_close\">닫기</a>";
              $(".dealLayer").html(html);
         }
}
function goEnuriDeal(){
   ga('send', 'event', 'mf_home', 'banner', '전면 레이어_에누리딜_배너');
   location.href = "/event2016/mobile_eal.jsp";
   return false;
}
function pricego(url){
    if(!e) var e = window.event;
        e.cancelBubble = true;
        e.returnValue = false;
        if (e.stopPropagation) {
            e.stopPropagation();
            e.preventDefault();
        }
    location.href = url;
    return false;
}
function martGoodsLoading(){
    getCateAndBanner();//mart.js include
    return false;
}
function mainShopLogo(shopCode){
    var imgSrc = IMG_ENURI_COM+"/images/view/ls_logo/2013/Ap_logo_"+shopCode+".png";
    return imgSrc;
}
function mainCateGo(cate){
    location.href = "/mobilefirst/list.jsp?cate="+cate;
}
function goVip(url,part,modelno){
    ga('send', 'event', 'mf_home_goods', 'click_goods', 'click_VIP_'+modelno);
    if(part == 'D') location.href = url;
    else        location.href = url;
    return false;
}
function mainSectionGo(url,modelno){
    ga('send', 'event', 'mf_home_goods', 'click_goods', 'click_section_'+modelno);
    location.href = url;
    return false;
}
function mainEventGo(part,section_txt,url){

	if(part == 'A')		 ga('send', 'event', 'mf_home_goods', 'event', url);
	else if(part == 'G') ga('send', 'event', 'mf_home_goods', 'guide_G', "guide_"+section_txt);
    location.href = url;
}
function middleBannerGo(url,txt){
    ga('send', 'event', 'mf_home', 'middle banner', 'middle_banner_'+txt);

    //adsvc.enuri.mcrony.com
    if(url.indexOf("ad-api.enuri.info") > -1)        window.open(url);
    else        location.href = url;

    return false;
}
function goSublistClick(url,modelno){
    ga('send', 'event', 'mf_home_goods', 'plan', 'plan_sub_'+modelno);
    location.href = url;
    return false;
}
function goMainPlan(url,modelno){
       ga('send', 'event', 'mf_home_goods', 'plan', "plan_"+modelno);
       location.href = url;
       return false;
}
function goUserReview(url,part,modelno){
    ga('send', 'event', 'mf_home_goods', 'click_goods', "click_상품평_"+modelno);
    if(part == 'D')        location.href = url+"&tab=3";
    else        location.href = url+"&tab=3";
    return false;
}
function goShopLink(url , part , shopcode , id , plno){
        if(part == 'T')        ga('send', 'event', 'mf_home_goods', 'goods', "T_"+shopcode+"_"+id);
        else if(part == 'C')   ga('send', 'event', 'mf_home_goods', 'goods', "C_"+shopcode+"_"+id);
        else if(part == 'D')   ga('send', 'event', 'mf_home_goods', 'goods', "D_"+shopcode+"_"+id);
        else if(part == 'S')   ga('send', 'event', 'mf_home_goods', 'deal', "deal_"+shopcode+"_"+id);
        else if(part == 'N')   ga('send', 'event', 'mf_home_goods', 'Normal', "N_"+shopcode+"_"+id);
        //window.open(url);
        if(part == "S"){
        	newUrl = url;
        }else{
        	//newUrl =  "/mobilefirst/move.jsp?vcode="+shopcode+"&plno="+plno+"&url="+encodeURIComponent(url);
        	newUrl = url;
        }
        
		var newWin = window.open(newUrl);
        return false;
}
function goMovLink(url, iurl , part , shopcode,  id ,modelnm){
	try{
		ga('send', 'event', 'mf_home_goods', 'video', "video_"+shopcode+"_"+id+"_"+modelnm);
	    if(agentCheck() == "I")    	window.open(iurl);
	    else    					window.open(url);
	}catch(e){}
    return false;
}
function goMainBanner(url,txt){
	if(tempIp.indexOf("175.194.40.126") > -1){
		ga('send', 'event', 'mf_home', 'banner', "이상클릭");
		return false;
	}
	//adsvc.enuri.mcrony.com
    ga('send', 'event', 'mf_home', 'banner', "banner_"+txt);
    if(url.indexOf("ad-api.enuri.info") > -1)        window.open(url);
    else        location.href = url;
    return false;
}
function agentCheck(){
    var iphoneAndroid = "";
    if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1)        iphoneAndroid ="I";
    else if(navigator.userAgent.indexOf("Android") > -1)        iphoneAndroid ="A";
    return iphoneAndroid;
}
function zzimDelete(part,delItemList){
        var url = "/view/deleteSaveGoodsProc.jsp";
        var param = "modelnos="+delItemList+"&tbln=save";
        $.ajax({
            type : "post",
            url : url,
            data : param,
            dataType : "html",
            success : function(ajaxResult) {
                 var tempNum = delItemList.replace(":","_");
                if(part == "C" || part == "T" || part == "D" )                    $("#"+tempNum).attr("class","heart");
                else                    $("#"+tempNum).attr("class","heart");
            }
        });
}
function zzimSet(modelno,plno,obj,part,shopcode){
    if(IsLogin()) {

        if( $(obj).attr("class") == "heart"  ){ //찜이 아닐 경우

            if(part == "C" || part == "T" || part == "D" )  {
               addResentZzimItem(2, "G", modelno);
               ga('send', 'event', 'mf_home', 'home_zzim', part +"_"+ shopcode+"_"+modelno+'_home');
            } else {
                addResentZzimItem(2, "P", plno);
                if( part == "S" ) ga('send', 'event', 'mf_home', 'home_zzim', part +"_"+shopcode+"_"+plno+'_home');
                else if( part == "B" ) ga('send', 'event', 'mf_home', 'home_zzim', part +"_"+ shopcode+"_"+plno+'_home');
                else if( part == "N" )  ga('send', 'event', 'mf_home', 'home_zzim', part +"_"+ shopcode+"_"+plno+'_home');
            }
            $(obj).attr("class","hearton");
            $(".zzimly").fadeIn( 820, function() {
                   setTimeout(function(){ $( ".zzimly" ).fadeOut( 760, function() { $(".zzimly").hide(); }); }, 450);
              });
        }else{ //찜상품일 경우
                 if(part == "C" || part == "T" || part == "D" ) zzimDelete(part,"G:"+modelno);
                 else                     					    zzimDelete(part,"P:"+plno);
        }
    }else{
        // 찜버튼을 클릭했을때 이벤트 등록
        if(confirm("찜 하시려면 로그인이 필요합니다.\n로그인 하시겠습니까?")) {
                goLogin();
                return false;
        }else{
            return false;
        }
    }
}
function addResentZzimItem(itemType, productType, modelno) {
    if(itemType==2) {
        if(IsLogin()) {
            var url = "/mobilefirst/ajax/resentZzim/insertSaveGoodsProc.jsp";
            var param = "modelnos="+productType+":"+modelno;
            $.ajax({
                type : "post",
                url : url,
                data : param,
                dataType : "json",
                success : function(ajaxResult) {}
            });
        } else {}
    }else if(itemType==1) {
		try {
			addStorageGoods("resentList", modelno, productType);
		} catch(e) {console.log(e)}
	}
}
function zzimCheckSet() {
    if(IsLogin()) {
        var url = "/mobilefirst/ajax/resentZzim/IsZzim_Main_Find_ajax.jsp";
        //var param = "modelnos="+goodsNumbers;
        var param = "";
        $.ajax({
            type : "post",
            url : url,
            data : param,
            dataType : "json",
            success : function(goodsList) {
                $.each(goodsList, function(i, v){
                        $("#"+v).attr("class","hearton");
                });
            }
        });
    } else {
        // 찜버튼을 클릭했을때 이벤트 등록
        var btn_zzimObj = $(".prodChoice button");
        btn_zzimObj.click(function (e) {
            if(confirm("찜 하시려면 로그인이 필요합니다.\n로그인 하시겠습니까?")) {
                //goLoginZzim(resentZzimModelno);
                goLogin();
                return false;
            }else{
                return false;
            }
        });
    }
}
function swiperLoading(){
	swiperAll = new Swiper('#wrap', {
	    slidesPerView: 1,
	    paginationClickable: true,
	    spaceBetween: 0,
	    loop: true,
	    lazyLoading: true,
	    autoHeight: true,
	    shortSwipes: false,
        longSwipes: true,
        longSwipesMs:100
	});
}
function setDelay(){
	setTimeout(function(){
    	swiperAll.onResize();
    },1000);
}
//크레이지딜 오픈여부
function getCommingDeal(){

    $.ajax({
        type: "get",
        url: "/mobilefirst/evt/ajax/ajax_commingdeal.jsp",
        dataType: "JSON",
        success: function(result){
        	if(result.isSaleSoon){
        		var soonSeq = result.soonSeq;
        		var remainTime = result.remainTime;
        		var soonGoodsCompany = result.soonGoodsCompany;

        		setTimeout(function(e){
                   	 $(".deal_goods > li").each(function(i,v){

                   		 var dataSeq = $(this).attr("data-seq");
                   		 if(soonSeq == dataSeq){
                   			 
                   			var type = $(this).attr("data-type");
                   			 if(type != 'E'){ //이벤트 아닌것만
                   				var shopCode = $(this).attr("data-code");
                          		 $(this).children().attr("onclick","goCrazyDeal("+shopCode+","+dataSeq+")");
                          		 $(this).removeClass("soon");
                          		 $(this).children().find("span.soon").remove();
                   			 }
                   		 }
                   	 });
        		}, remainTime);
        	}
        }
    });
}
function goCrazyDeal(shopcode,seq){
	goDealShop('', shopcode, seq );
	return false;
}

function shuffle(a) {
    var j, x, i;
    for (i = a.length; i; i--) {
        j = Math.floor(Math.random() * i);
        x = a[i - 1];
        a[i - 1] = a[j];
        a[j] = x;
    }
    return a;
}
function indexBannerLayer(){
	var loadUrl = "http://ad-api.enuri.info/enuri_M/m_fp/M6/bundle?bundlenum=6";

	$.getJSON("/mobilefirst/get_banner_list.jsp",{url:loadUrl},function(json){

		if(json.length > 0){
			
			var ranNum = Math.floor(Math.random() * 3); // 0 ~ (max - 1) 까지의 정수 값을 생성
			
			$.each(json, function(i,v){
				
				if( v.SORT == (ranNum+1)  ){
					var layer = "";
			    	layer += "<div class=\"coffee_go\" data-id='"+v.SORT+"' >";
			    		layer += "<a class=\"close\" id=\"coffee_close\">닫기</a>";
		    			layer += "<a class=\"week_close\">일주일 동안 보지 않기</a>";
		    			
		    			if(v.TXT1 == "banner_webfp6_appdown") layer += "<img src='"+v.IMG1+"' onclick = \"javascript:goToBanner('install','banner_webfp6_appdown')\"  />";
		    			else			    				  layer += "<img src='"+v.IMG1+"' onclick=\"javascript:goEventCoffee('"+v.JURL1+"')\"  />";	
		    			
			    		//layer += "<h1></h1>";
			    	layer += "</div>";
			    	$("#mainLayer").html(layer);
			    	noticePopUp();
			    	return false;
				}//else{
				//	$("#mainLayer").hide();
				//}
			});
			
		}else{
			$("#mainLayer").hide();
		}
	});
}
function coffeeClose(){
	 //X 하루 닫기
	 event.stopPropagation();
    fnEverSetCookie("linker_popup3", "CHECKED", 1);
    $("#mainLayer").hide();
}