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
	ga('send', 'event', 'st_home_goods', 'plan_Q', "plan_Q_"+sectiontxt);
	
	url = url+"&from=swt"; 
	
	location.href = url;
	return false;
}

$(document).ready(function(){
	$(function(){ //화면 스크롤 시 탭 영역 상단 고정
		var $gnb = $(".m_top.type_smd");
		var fixedGnb = function(){
			var $myScroll = $(window).scrollTop();
			if ( $gnb.offset().top-1 < $myScroll ) $gnb.addClass("fixed");
			else $gnb.removeClass("fixed");
		}
		$(window).load(fixedGnb).scroll(fixedGnb).resize(fixedGnb);
	});

    mainBannerLoading(); //배너로딩
    mainGoodsListLoading();
	$(".mall_cate > li").click(function() {
		var alt = $(this).find("img").attr("alt");
		ga('send', 'event', 'st_home', 'shop_top', 'shop_top_' + alt);

		var outLinkUrl = "";
		var shopCode = "";

		if(alt == "gmarket"){
			outLinkUrl = "http://www.gmarket.co.kr/index.asp?jaehuid=200006254&DEVICE_BROWSER=Y";
			shopCode = "536";
		}else if(alt == "auction"){
			outLinkUrl = "http://banner.auction.co.kr/bn_redirect.asp?ID=BN00181187&DEVICE_BROWSER=Y";
			shopCode = "4027";
		}else if(alt == "11st"){
			outLinkUrl = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1000997249&DEVICE_BROWSER=Y";
			shopCode = "5910";
		}else if(alt == "interpark"){
			outLinkUrl = "http://m.interpark.com/mobileGW.html?svc=Shop&bizCode=P14126&url=http://m.shop.interpark.com&DEVICE_BROWSER=Y";
			shopCode = "55";
		}else if(alt == "tmon"){
			outLinkUrl = "http://m.ticketmonster.co.kr/entry/?jp=80025&ln=214285&DEVICE_BROWSER=Y";
			shopCode = "6641";
		}else if(alt == "wemake"){
			outLinkUrl = "https://mw.wemakeprice.com/affiliate/bridge?channelId=1000032";
			shopCode = "6508";
		}
		goGateShopUrl(shopCode,outLinkUrl+"&from=swt");
	});
    /*** 카테고리 선택*/
    $("ul.m_depth li").on('click', function(event) {
        var $this = $(this);
        var index = $this.index();
        
        if($this.index() == 0)                 window.open("/mobilefirst/cpp2.jsp?gcate=1&from=swt");
        else if($this.index() == 1)            window.open("/mobilefirst/cpp2.jsp?gcate=2&from=swt");
        else if($this.index() == 2)            window.open("/cpp/cpp_m.jsp?from=swt");
        else if($this.index() == 3)            window.open("/mobilefirst/cpp2.jsp?gcate=4&from=swt");
        else if($this.index() == 4)            window.open("/mobilefirst/cpp2.jsp?gcate=5&from=swt");
        else if($this.index() == 5)            window.open("/mobilefirst/cpp2.jsp?gcate=6&from=swt");
        else if($this.index() == 6)            window.open("/mobilefirst/cpp2.jsp?gcate=7&from=swt");
        else if($this.index() == 7)            window.open("/mobilefirst/cpp2.jsp?gcate=8&from=swt");
        
        /*
        if($this.index() == 0)                 window.open("/mobilefirst/cpp2.jsp?gcate=1");
        else if($this.index() == 1)            window.open("/mobilefirst/cpp2.jsp?gcate=2");
        else if($this.index() == 2)            window.open("/cpp/cpp_m.jsp");
        else if($this.index() == 3)            window.open("/mobilefirst/cpp2.jsp?gcate=4");
        else if($this.index() == 4)            window.open("/mobilefirst/cpp2.jsp?gcate=5");
        else if($this.index() == 5)            window.open("/mobilefirst/cpp2.jsp?gcate=6");
        else if($this.index() == 6)            window.open("/mobilefirst/cpp2.jsp?gcate=7");
        else if($this.index() == 7)            window.open("/mobilefirst/cpp2.jsp?gcate=8");
        */

        if( index == 8) { // 소셜
        	window.open("/deal/newdeal/index.deal?from=swt");
        	
            ga('send', 'event', 'st_home', 'sub', 'sub_' + $this.text());
        }else if( index == 9){//쇼핑지식
        	ga('send', 'event', 'st_home', 'sub', 'sub_' + $this.text());
            //cateCurtainLoading("Y");
        	window.open("/knowcom/index.jsp?from=swt");
            return;
        }
        ga('send', 'event', 'st_home', 'sub', 'sub_' + $this.text());
    });

    $(".shop_list > li ").click(function() {
        var mall = $(this).find("img").attr("alt");
        var outLinkUrl = "";
        var shopCode = "";

        if (mall) ga('send', 'event', 'st_home', 'shop', 'shop_' + mall);

        if      (mall == '롯데닷컴'){
        	shopCode="49";
        	outLinkUrl = "http://m.lotte.com/main_phone.do?udid=&cn=112346&cdn=783491&DEVICE_BROWSER=Y";
        }else if (mall == 'SSG'){
        	shopCode="6665";
        	outLinkUrl = "http://m.ssg.com?ckwhere=enuri_mdirect";
        }else if (mall == '현대H몰'){
        	shopCode="57";
        	outLinkUrl = "http://www.hyundaihmall.com/front/shNetworkShop.do?NetworkShop=Html&ReferCode=022&Url=http://www.hyundaihmall.com/Home.html";
        }else if (mall == '갤러리아'){
        	shopCode="6620";
        	outLinkUrl = "http://www.galleria.co.kr/common.do?method=join&channel_id=2764&link_id=0001&DEVICE_BROWSER=Y";
        }else if (mall == 'GS SHOP'){
        	shopCode="75";
        	outLinkUrl = "http://with.gsshop.com/jsp/jseis_withLGeshop.jsp?from=swt&media=Pg&gourl=http://m.gsshop.com";
        	goGateShopUrl(shopCode,outLinkUrl);
        	return false;
        }else if (mall == 'CJmall'){
        	shopCode="806";
        	outLinkUrl = "http://display.cjmall.com/m/main?infl_cd=I0580&DEVICE_BROWSER=Y";
        }else if (mall == '롯데 홈쇼핑'){
        	shopCode="663";
        	outLinkUrl = "http://www.lotteimall.com/coop/affilGate.lotte?chl_no=140769&chl_dtl_no=2540476&DEVICE_BROWSER=Y";
        }else if (mall == 'ak mall'){
        	shopCode="90";
        	outLinkUrl = "http://www.akmall.com/assc/associate.jsp?assc_comp_id=26392&DEVICE_BROWSER=Y";
        }else if (mall == '홈앤쇼핑'){
        	shopCode="6588";
        	outLinkUrl = "http://m.hnsmall.com/channel/gate?channel_code=20200&DEVICE_BROWSER=Y";
        }else if (mall == '11번가'){
        	shopCode="5910";
        	outLinkUrl = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1000997249&DEVICE_BROWSER=Y";
    	}else if (mall == '쿠팡'){
    		shopCode="7861";
    		outLinkUrl = "http://landing.coupang.com/pages/M_home?src=1033035&amp;spec=10305201&amp;lptag=Enuri_M_logo&amp;forceBypass=Y";
    	}else if (mall == 'dshop'){
    		shopCode="1878";
    		outLinkUrl = "http://www.dnshop.com/?Sid=0024_8H050000_01_01&DEVICE_BROWSER=Y";
    	}else if (mall == '위메프'){
    		shopCode="6508";
    		outLinkUrl = "https://mw.wemakeprice.com/affiliate/bridge?channelId=1000032";
    	}else if (mall == '티몬'){
    		shopCode="6641";
    		outLinkUrl = "http://m.ticketmonster.co.kr/entry/?jp=80025&ln=214285&DEVICE_BROWSER=Y";
    	}else if (mall == '공영홈쇼핑'){
    		shopCode="7935";
    		outLinkUrl = "https://m.gongyoungshop.kr/gate/selectAliance.do?alcLnkCd=enrpcs&amp;tgUrl=/main.do";
    	}else if (mall == 'G9'){
    		shopCode="7692";
    		outLinkUrl = "http://m.g9.co.kr/Default/Home?jaehuid=200006436";
    	}else if (mall == '지마켓'){
    		shopCode="536";
    		outLinkUrl = "http://www.gmarket.co.kr/index.asp?jaehuid=200006254&DEVICE_BROWSER=Y";
    	}else if (mall == '옥션'){
    		shopCode="4027";
    		outLinkUrl = "http://banner.auction.co.kr/bn_redirect.asp?ID=BN00181187&DEVICE_BROWSER=Y";
    	}else if (mall == '인터파크'){
    		shopCode="55";
    		outLinkUrl = "http://m.interpark.com/mobileGW.html?svc=Shop&bizCode=P14126&url=http://m.shop.interpark.com&DEVICE_BROWSER=Y";
    	}else if (mall == '엘롯데'){
    		shopCode="6547";
        	outLinkUrl = "https://m.display.ellotte.com/display-mo/shop?chnlNo=100023&chnlDtlNo=1000023";
    	}else if (mall == 'NSmall'){
    		shopCode="974";
    		outLinkUrl = "http://m.nsmall.com/mjsp/site/gate.jsp?co_cd=190&target=http%3A%2F%2Fm.nsmall.com%2FMainView&DEVICE_BROWSER=Y";
		}
        goGateShopUrl(shopCode,outLinkUrl+"&from=swt");
        
        return false;
    });
     /***  메인 팝업 닫기     */
    //메인 팝업 레이어 오늘하루 띠우지 않기
     //getCommingDeal();
     $("#lay_gate").click(function(){
    	 $("#smd_gate").hide();
    	 fnEverSetCookie("smpopup", "CHECKED", 10000);
     });
     smPopUp();

     $(".smdgnb > li ").click(function(){
    	 $(".smdgnb li").each(function(){ $(this).children().removeClass('on'); });
    	 $(this).children().addClass("on");
    	 var inx = $(this).index();
    	 
    	 if( inx == 0 )	     location.href = "#/home";
    	 else if( inx == 1 ) location.href = "#/hotdeal";
    	 else if( inx == 2 ) location.href = "#/best";
    	 
    	 $(window).scrollTop(0);
     });

    	 var app = $.sammy(function() {

 			this.get('#/home', function() {

 				$("#home_wrap").show();
 				$("#hotDealBest").hide();
 				$("#best").hide();

 				$(".smdgnb li").each(function(){
		    		 $(this).children().removeClass('on');
		    	 });
 				$(".smdgnb li").eq(0).children().addClass("on");

 			});

 			this.get('#/hotdeal', function() {

 				getBaselist1(1);

 				$("#home_wrap").hide();
 				$("#hotDealBest").show();
 				$("#best").hide();

 				$(".smdgnb li").each(function(){
 		    		 $(this).children().removeClass('on');
 		    	});
 				$(".smdgnb li").eq(1).children().addClass("on");
 			});

 			this.get('#/best', function() {

 				getBestlist1(1);

 				$("#home_wrap").hide();
 				$("#hotDealBest").hide();
 				$("#best").show();

 				$(".smdgnb li").each(function(){
 		    		 $(this).children().removeClass('on');
 		    	});
 				$(".smdgnb li").eq(2).children().addClass("on");
 			});

      	});
        //$(function() {     	   app.run();        });
    	 app.run();

        $("body").on('click', '.myset', function(event) {
       	 ga('send', "event", "sf_home", "CRAZY_deal", "전체보기");
       	 window.open("/mobilefirst/evt/mobile_deal.jsp?freetoken=event&from=swt");
       	 return false;
        });
        
        $("body").on('click', ".logo.ico_m", function(event) {
        	location.href = "/mobilefirst/smarthome.jsp";
        });
        
        $(".newMallList > li > a > img").click(function() {
            var mall = $(this).attr("alt");
            var outLinkUrl = "";
            var shopCode = "";
            if (mall) ga('send', 'event', 'mf_home', 'shop', 'shop_' + mall);
            
            if      (mall == '롯데닷컴'){    
            	shopCode="49"; 
            	outLinkUrl = "http://m.lotte.com/main_phone.do?udid=&cn=112346&cdn=783491&DEVICE_BROWSER=Y";        
            }else if (mall == 'ssg'){    
            	shopCode="6665"; 
            	outLinkUrl = "http://m.ssg.com?ckwhere=enuri_mdirect";
            }else if (mall == '현대H몰'){     
            	shopCode="57"; 
            	outLinkUrl = "http://www.hyundaihmall.com/front/shNetworkShop.do?NetworkShop=Html&ReferCode=022&Url=http://www.hyundaihmall.com/Home.html";
            }else if (mall == '갤러리아'){
            	shopCode="6620"; 
            	outLinkUrl = "http://www.galleria.co.kr/common.do?method=join&channel_id=2764&link_id=0001&DEVICE_BROWSER=Y";
            }else if (mall == 'GS SHOP'){
            	shopCode="75"; 
            	outLinkUrl = "http://with.gsshop.com/jsp/jseis_withLGeshop.jsp?from=swt&media=Pg&gourl=http://m.gsshop.com";
            	goGateShopUrl(shopCode,outLinkUrl);
            	return false;
            	
            }else if (mall == 'CJmall'){
            	shopCode="806"; 
            	outLinkUrl = "http://display.cjmall.com/m/main?infl_cd=I0580&DEVICE_BROWSER=Y";
            }else if (mall == '롯데 홈쇼핑'){
            	shopCode="663"; 
            	outLinkUrl = "http://www.lotteimall.com/coop/affilGate.lotte?chl_no=140769&chl_dtl_no=2540476&DEVICE_BROWSER=Y";
            }else if (mall == 'ak mall'){
            	shopCode="90"; 
            	outLinkUrl = "http://www.akmall.com/assc/associate.jsp?assc_comp_id=26392&DEVICE_BROWSER=Y";
            }else if (mall == '홈앤쇼핑'){
            	shopCode="6588"; 
            	outLinkUrl = "http://m.hnsmall.com/channel/gate?channel_code=20200&DEVICE_BROWSER=Y";
            }else if (mall == '11번가'){      
            	shopCode="5910"; 
            	outLinkUrl = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1000997249&DEVICE_BROWSER=Y";
        	}else if (mall == '쿠팡'){
        		shopCode="7861"; 
        		outLinkUrl = "http://landing.coupang.com/pages/M_home?src=1033035&amp;spec=10305201&amp;lptag=Enuri_M_logo&amp;forceBypass=Y";
        	}else if (mall == 'dshop'){
        		shopCode="1878"; 
        		outLinkUrl = "http://www.dnshop.com/?Sid=0024_8H050000_01_01&DEVICE_BROWSER=Y";
        	}else if (mall == '위메프'){
        		shopCode="6508"; 
        		outLinkUrl = "https://mw.wemakeprice.com/affiliate/bridge?channelId=1000032";
        	}else if (mall == '티몬'){
        		shopCode="6641"; 
        		outLinkUrl = "http://m.ticketmonster.co.kr/entry/?jp=80025&ln=214285&DEVICE_BROWSER=Y";
        	}else if (mall == '공영홈쇼핑'){
        		shopCode="7935"; 
        		outLinkUrl = "https://m.gongyoungshop.kr/gate/selectAliance.do?alcLnkCd=enrpcs&amp;tgUrl=/main.do";
        	}else if (mall == 'G9'){          
        		shopCode="7692"; 
        		outLinkUrl = "http://m.g9.co.kr/Default/Home?jaehuid=200006436";
        	}else if (mall == '지마켓'){
        		shopCode="536"; 
        		outLinkUrl = "http://www.gmarket.co.kr/index.asp?jaehuid=200006254&DEVICE_BROWSER=Y";
        	}else if (mall == '옥션'){
        		shopCode="4027"; 
        		outLinkUrl = "http://banner.auction.co.kr/bn_redirect.asp?ID=BN00181187&DEVICE_BROWSER=Y";
        	}else if (mall == '인터파크'){
        		shopCode="55"; 
        		outLinkUrl = "http://m.interpark.com/mobileGW.html?svc=Shop&bizCode=P14126&url=http://m.shop.interpark.com&DEVICE_BROWSER=Y";
        	}else if (mall == '엘롯데'){
        		shopCode="6547"; 
            	outLinkUrl = "https://m.display.ellotte.com/display-mo/shop?chnlNo=100023&chnlDtlNo=1000023";
        	}else if (mall == 'NSmall'){
        		shopCode="974"; 
        		outLinkUrl = "http://m.nsmall.com/mjsp/site/gate.jsp?co_cd=190&target=http%3A%2F%2Fm.nsmall.com%2FMainView&DEVICE_BROWSER=Y";
    		}
            goGateShopUrl(shopCode,outLinkUrl+"&from=swt");
            return false;
        });
        
});
function goGateShopUrl(shop,url){
	window.open("/mobilefirst/move2.jsp?vcode="+shop+"&url="+encodeURIComponent(url));
	return false;
}
function fnSetCookie2010( name, value, expiredays ){
	if (typeof(expiredays) == "undefined" || expiredays == null) {
		expiredays = "";
	}
	if (expiredays == ""){
		document.cookie = name + "=" + escape( value ) + "; path=/;"
	}else{
		var todayDate = new Date();
		todayDate.toGMTString();
		todayDate.setDate( todayDate.getDate() + expiredays );
		document.cookie = name + "=" + escape( value ) + "; path=/;expires="+ todayDate.toGMTString() + ";"
	}
}
function smPopUp() {
    // 해당 날짜까지 노출
    if (getCookie('smpopup') != "CHECKED") {
        $("#smd_gate").show();
        $(window).scrollTop();
    }
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
	    	        		//if(v.part == "S")  mainGoodsSocial.push(v);
	    	        	});
	    	        	mainGoodsQ = shuffle(mainGoodsQ);
	    	        	mainGoodsTDCN = shuffle(mainGoodsTDCN);
	    	        	mainGoodsA = shuffle(mainGoodsA);
	    	        	mainGoodsG = shuffle(mainGoodsG);
	    	        	//mainGoodsSocial = shuffle(mainGoodsSocial);

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
	    	        	/*
	    	        	if(mainGoodsSocial.length > 5){
	    	        		mainGoodsFirstJson.push(mainGoodsSocial[4]);
	    	        	}
	    	        	*/
    	        		if(mainGoodsA.length > 0)  	mainGoodsFirstJson.push(mainGoodsA[0]);

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

					}catch(e){
						console.log("main상품로딩오류"+e);
					}

    	        },complete : function(data) {

    	        	var home_plan = new Swiper('#home_plan', {slidesPerView: 'auto'});

    	        	//if(mainGoodsQQJson.length > 0){
    			    //}
    	        	$("img.lazy").lazyload({
    	        		effect:'fadeIn',
	                    threshold:500,
	                    failure_limit:2 ,
	                    skip_invisible : true
    	        	});

    	        }
    	    });
}
function mainGoodsListHtml(ajaxUrl,listJson){
	if( ajaxUrl.indexOf("/mobilefirst/api/main/mobile_mainlistpreview.json") > -1 )	$("#mainGoodsList").tmpl(listJson.MainJsonpreview).appendTo("#today_list");
	else	$("#mainGoodsList").tmpl(listJson).appendTo("#today_list");
}
/*
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
    return     json.GOODS_PRICE != null           &&
               json.GOODS_PRICE.length > 0        &&
               json.GOODS_SOLD_FLAG == "N"        &&
               json.GOODS_EXPO_FLAG == "Y"            //&&
               //!json.GOODS_URL.includes("event_id");
}

function edealGoodViewGA(){
   $(".deal_goods > div > div > li").each(function(){
      var tempSeq = $(this).attr("data-seq");
      var tempClass = $(this).attr("class");
      if(tempClass.indexOf("slick-current") > -1){
        var modeNmTxt = $(this).find("strong").text();
        ga('send', 'event', 'st_home', 'enuri_deal_imp', tempSeq+'_'+modeNmTxt);
      }
   });
}
*/
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
function termsLayer(){
    $("#revisedTermsofUse").tmpl().appendTo("#terms");
    $("#terms").show();
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
	if("S" == TYPE){//soon
		ga('send', 'event', 'st_home', 'CRAZY_deal', MODELNO+'_'+GOODS_NAME+'_판매예정('+SEQ+')');
        if(MODELNO && MODELNO > 0 )        	location.href = "/mobilefirst/detail.jsp?modelno="+MODELNO;
        else        	alert("판매예정 입니다.");
	}else if("O" == TYPE){//soldout
		ga('send', 'event', 'st_home', 'CRAZY_deal', MODELNO+'_'+GOODS_NAME+'_판매완료('+SEQ+')');
        if(MODELNO && MODELNO > 0 )        	location.href = "/mobilefirst/detail.jsp?modelno="+MODELNO;
        else        	alert("품절입니다.");
	}else if("E" == TYPE){
		ga('send', 'event', 'st_home', 'CRAZY_deal','[EVENT]'+GOODS_NAME+'_('+SEQ+')');
		location.href = GOODS_URL;
	}else{
		ga('send', 'event', 'st_home', 'CRAZY_deal', MODELNO+'_'+GOODS_NAME+'구매('+SEQ+')');
		goCrazyDeal(GOODS_COMPANY,SEQ);
	}
	window.location = "http://m.enuri.com/mobilefirst/index.jsp?from=swt";
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
function mainShopLogo(shopCode){
    var imgSrc = IMG_ENURI_COM+"/images/view/ls_logo/2013/Ap_logo_"+shopCode+".png";
    return imgSrc;
}
function mainCateGo(cate){
    location.href = "/mobilefirst/list.jsp?cate="+cate;
}
function goVip(url,part,modelno){
    ga('send', 'event', 'st_home_goods', 'click_goods', 'click_VIP_'+modelno);
    
    url = url+"&from=swt"
    window.open(url);
    
    return false;
}
function mainSectionGo(url,modelno){
    ga('send', 'event', 'st_home_goods', 'click_goods', 'click_section_'+modelno);
    location.href = url;
    return false;
}
function mainEventGo(part,section_txt,url){

	if(part == 'A')		 ga('send', 'event', 'st_home_goods', 'event', url);
	else if(part == 'G') ga('send', 'event', 'st_home_goods', 'guide_G', "guide_"+section_txt);
    location.href = url;
}
function middleBannerGo(url,txt){
    ga('send', 'event', 'st_home', 'middle banner', 'middle_banner_'+txt);

    url = url+"&from=swt"
    
    if(url.indexOf("adsvc.enuri.mcrony.com") > -1)        window.open(url);
    else        location.href = window.open(url);

    return false;
}
function goSublistClick(url,modelno){
    ga('send', 'event', 'st_home_goods', 'plan', 'plan_sub_'+modelno);
    location.href = url;
    return false;
}
function goMainPlan(url,modelno){
       ga('send', 'event', 'st_home_goods', 'plan', "plan_"+modelno);
       location.href = url;
       return false;
}
function goUserReview(url,part,modelno){
    ga('send', 'event', 'st_home_goods', 'click_goods', "click_상품평_"+modelno);
    
    url = url+"&from=swt"

    window.open(url);
    return false;
}
function goShopLink(url , part , shopcode , id , plno){
        if(part == 'T')        ga('send', 'event', 'st_home_goods', 'goods', "T_"+shopcode+"_"+id);
        else if(part == 'C')   ga('send', 'event', 'st_home_goods', 'goods', "C_"+shopcode+"_"+id);
        else if(part == 'D')   ga('send', 'event', 'st_home_goods', 'goods', "D_"+shopcode+"_"+id);
        else if(part == 'S')   ga('send', 'event', 'st_home_goods', 'deal', "deal_"+shopcode+"_"+id);
        else if(part == 'N')   ga('send', 'event', 'st_home_goods', 'Normal', "N_"+shopcode+"_"+id);
        
        newUrl = url+"&from=swt";
        
        if(id == plno){
        	goShop(newUrl,shopcode,plno , '','','','','','','');	
        }else{
        	goShop(newUrl,shopcode,plno , '','','','','','',id);
        }
        return false;
}
function goMovLink(url, iurl , part , shopcode,  id ,modelnm){
	try{
		ga('send', 'event', 'st_home_goods', 'video', "video_"+shopcode+"_"+id+"_"+modelnm);
	    if(agentCheck() == "I")    	window.open(iurl);
	    else    					window.open(url);
	}catch(e){}

    return false;
}
function goMainBanner(url,txt){

	if(tempIp.indexOf("175.194.40.126") > -1){
		ga('send', 'event', 'st_home', 'banner', "이상클릭");
		return false;
	}
    ga('send', 'event', 'st_home', 'banner', "banner_"+txt);
    if(url.indexOf("adsvc.enuri.mcrony.com") > -1)        window.open(url+"&from=swt");
    else        location.href = url+"&from=swt";
    
    return false;
}
function agentCheck(){
    var iphoneAndroid = "";
    if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1)        iphoneAndroid ="I";
    else if(navigator.userAgent.indexOf("Android") > -1)        iphoneAndroid ="A";
    return iphoneAndroid;
}
//크레이지딜 오픈여부
/*
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
*/
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
var bast_list; //특가모음
var hot_list; //핫딜베스트
//특가모음
function getBestlist1(param){
	if(bast_list == null){
		getBestlist(param);
	}
}
//핫딜베스트
function getBaselist1(param){
	if(hot_list == null){
		getBaselist(param);
	}
}
function getBestlist(param){

	$(".brand_btt").removeClass("on");

	var shop_code = "536";
	var json_url = "/mobilefirst/http/json/bestGmarket.json";
	var shop_name = "";
	if(param == 1){
		shop_code = "536";
		json_url = "/mobilefirst/http/json/bestGmarket.json";
		$("#brand_1").addClass("on");
		shop_name = "지마켓";
	}else if(param == 2){
		shop_code = "4027";

		if( nowUrl.indexOf("dev.enuri.com") > -1 )	json_url = "/mobilefirst/http/shopBestMake.jsp?bestType=1";
		else										json_url = "/mobilefirst/http/json/bestAuction.json";

		$("#brand_2").addClass("on");
		shop_name = "옥션";
	}else if(param == 3){
		shop_code = "5910";
		json_url = "/mobilefirst/http/json/best11st.json";
		$("#brand_3").addClass("on");
		shop_name = "11번가";
	}else if(param == 4){
		shop_code = "55";
		json_url = "/mobilefirst/http/json/bestInterPark.json";
		$("#brand_4").addClass("on");
		shop_name = "인터파크";
	}
	ga("send", "event", "st_home", "tab_쇼핑베스트_"+shop_name, "tab_쇼핑베스트_"+ shop_name +"_홈");

	$.ajax({
		type: "GET",
		url: json_url,
		dataType: "JSON",
		success: function(json){
			$("#best_body").html(null);

			if(json.goodsList){
				var template = "";

				for(var i=0;i<json.goodsList.length;i++){
					template += "<li>";
					template += "	<a href=\"javascript:///\" class=\"best_area\" modelno=\""+ json.goodsList[i].modelno +"\" url=\""+ json.goodsList[i].url +"\" pl_no=\""+ json.goodsList[i].pl_no +"\">";
					template += "		<span class=\"num\">"+( i + 1) +"</span>";
					if(json.goodsList[i].modelno > 0){
						template += "		<span class=\"infobtn\" modelno=\""+ json.goodsList[i].modelno +"\">카탈로그보기</span>";
					}
					 if(param == 2){
						if(i < 4){
							template += "	<img class='trend_thumb' src=\""+json.goodsList[i].shopImageUrl+"\"  src=\""+json.goodsList[i].shopImageUrl+"\"  alt=\"\"> ";
						}else{
							template += "	<img class='trend_thumb swiper-lazy' src=\""+json.goodsList[i].shopImageUrl+"\"  src=\"http://imgenuri.enuri.gscdn.com/images/mobilefirst/enuri_rod.png\" alt=\"\"> ";
							//template += "	<div class=\"swiper-lazy-preloader swiper-lazy-preloader-black\"></div>";
						}
					 }else{
						if(i < 4){
							template += "	<img class=\"trend_thumb\" src=\""+json.goodsList[i].imgurl+"\"  src=\""+json.goodsList[i].imgurl+"\"  alt=\"\"> ";
						}else{
							template += "	<img class='trend_thumb swiper-lazy' src=\""+json.goodsList[i].imgurl+"\"  src=\"http://imgenuri.enuri.gscdn.com/images/mobilefirst/enuri_rod.png\" alt=\"\"> ";
							//template += "	<div class=\"swiper-lazy-preloader swiper-lazy-preloader-black\"></div>";
						}
					 }
					template += "		<strong>"+ json.goodsList[i].goodsnm +"</strong>";
					template += "		<span class=\"pr\">"+ commaNum(json.goodsList[i].price) +"<em>원</em>";
					if( json.goodsList[i].deliverytype2 == "1" &&  json.goodsList[i].deliveryinfo2 == "0"){
						template += "<span class=\"free\">무료배송</span>";
					}
					template += "		</span>";
					template += "	</a>";
					if(json.goodsList[i].ca_codeName != ""){
						template += "	<a href=\"javascript:///\" class=\"best_more\" cate=\""+ json.goodsList[i].ca_code4 +"\"><span>"+ json.goodsList[i].ca_codeName +"</span></a>";
					}
					template += "</li>";
				}
				$("#best_body").html(template);

				$(".best_area").each(function(){
					$(this).on("click",function(event) {
						
						//insertLogModel(19712,0,'');
						goShop($(this).attr("url")+"&from=swt",shop_code,$(this).attr("pl_no"),'','','','','',this,$(this).attr("modelno"));
						ga("send", "event", "st_home", "tab_쇼핑베스트_"+shop_name, "tab_쇼핑베스트_"+ shop_name +"_상품");
					});
				});
			    $(".infobtn").each(function(){
                    $(this).on("click",function(event) {
                    	
                    	//insertLogModel(19712,$(this).attr("modelno"),'');
                        event.stopPropagation();
                        location.href = "/mobilefirst/detail.jsp?modelno="+ $(this).attr("modelno")+"&from=swt";
                        ga("send", "event", "st_home", "tab_쇼핑베스트_"+shop_name, "tab_쇼핑베스트_"+ shop_name +"_인포");
                    });
                });
                $(".best_more").each(function(){
                    $(this).on("click",function(event) {
                        event.stopPropagation();
                        go_cate($(this).attr("cate"));
                        ga("send", "event", "st_home", "tab_쇼핑베스트_"+shop_name, "tab_쇼핑베스트_"+ shop_name +"_카테");
                    });
                });
			}
			bast_list = json;
		},
		error : function(result) {
			alert("error occured. Status:" + result.status
	                     + ' --Status Text:' + result.statusText
	                    + " --Error Result:" + result);
		}
	});

}
function getBaselist(param){
    $(".tab_deal li").removeClass("on");

    var shop_code = "536";
    var shop_name = "슈퍼딜";
    var json_url = "/mobilefirst/http/json/superDeal.json";

    if(param == 1){
        shop_code = "536";
        shop_name = "슈퍼딜";
        if( nowUrl.indexOf("dev.enuri.com") > -1 )   	json_url = "/mobilefirst/http/shopDeal2Make.jsp?bestType=2";
        else   	json_url = "/mobilefirst/http/json/superDeal.json";

        $("#hot_title").attr("src","http://imgenuri.enuri.gscdn.com/images/m_home/hotdeal_superdeal.png");
        $("#deal_1").addClass("on");
    }else if(param == 2){
        shop_code = "4027";
        shop_name = "올킬";
        json_url = "/mobilefirst/http/json/allKill.json";
        $("#hot_title").attr("src","http://imgenuri.enuri.gscdn.com/images/m_home/hotdeal_allkill.png");
        $("#deal_2").addClass("on");
    }else if(param == 3){
        shop_code = "5910";
        shop_name = "쇼킹딜";
        json_url = "/mobilefirst/http/json/shocking.json";
        $("#hot_title").attr("src","http://imgenuri.enuri.gscdn.com/images/m_home/hotdeal_shocking.png");
        $("#deal_3").addClass("on");
    }else if(param == 4){
        shop_code = "6641";
        shop_name = "티몬";
        json_url = "/mobilefirst/http/json/tmon.json";
        $("#hot_title").attr("src","http://imgenuri.enuri.gscdn.com/images/m_home/hotdeal_timon.png");
        $("#deal_4").addClass("on");
    }else if(param == 5){
    	//쿠팡
    }else if(param == 6){
        shop_code = "6508";
        shop_name = "위메프";

        var locurl = document.location.href;

        if( locurl.indexOf("dev.enuri.com") > -1 ){
        	json_url = "/mobilefirst/http/shopDeal3Make.jsp?bestType=4";
        }else{
        	json_url = "/mobilefirst/http/json/wemake.json";
        }

        $("#hot_title").attr("src","http://imgenuri.enuri.gscdn.com/images/m_home/hotdeal_wemape.png");
        $("#deal_6").addClass("on");
	}else if(param == 7){
	    shop_code = "55";
	    shop_name = "쎈딜";
	    json_url = "/mobilefirst/http/json/ssenDeal.json";
	    $("#hot_title").attr("src","http://imgenuri.enuri.gscdn.com/images/m_home/hotdeal_ssendeal.png");
	    $("#deal_7").addClass("on");
	}

    ga("send", "event", "st_hotdeal", "hotdeal_tab", "tab_"+ shop_name);

    $.ajax({
        type: "GET",
        url: json_url,
        dataType: "JSON",
        success: function(json){
            $("#hotDealBestList").html(null);

            if(json.goodsList){
                var temp = "";

                for(var i=0;i<json.goodsList.length;i++){

                var template = "";
                if(shop_code=="6641" || shop_code=="6508" || shop_code=="55"){
                    template += "<li>";
                    template += "<a href=\"javascript:///\" modelnm=\""+ json.goodsList[i].goodsnm +"\" class=\"best_area\" url=\""+ json.goodsList[i].url +"\" modelno=\""+ json.goodsList[i].modelno +"\" pl_no=\""+ json.goodsList[i].pl_no +"\">";
                    template += "<div class=\"thum sq\">";
                    template += 	"<img data-original=\""+json.goodsList[i].shopImageUrl+"\" alt='' class='bestLazy' src='http://imgenuri.enuri.gscdn.com/images/m_home/noimg.png' />";
                    template += "</div>";

                    template += "<div class=\"info\">";
                    //String[] shopCode = {"536", "4027", "5910", "6641", "6508"};
            		//String[] shopName = {"슈퍼딜", "올킬", "쇼킹딜", "티몬", "위메프"};
                    if(shop_code == "6641"){
                        template += "<span class=\"mall\"><img src=\"http://img.enuri.com/images/mobilefirst/main/shoplogo/tmon.png\" alt=\"\" /></span>";
                    }else if(shop_code == "6508"){
                    	template += "<span class=\"mall\"><img src=\"http://img.enuri.com/images/mobilefirst/main/shoplogo/wemake.png\" alt=\"\" /></span>";
                    }else if(shop_code == "55"){
                        template += "<span class=\"mall\"><img src=\"http://img.enuri.com/images/mobilefirst/main/shoplogo/ssendeal.png\" alt=\"\" /></span>";
                    }
                    template += "<strong>"+json.goodsList[i].goodsnm+"</strong>";
                    template += "<div class=\"price\">";
                    if(json.goodsList[i].discount_rate){
                        if((json.goodsList[i].discount_rate != "" && json.goodsList[i].discount_rate != 0) && (json.goodsList[i].orgPrice != "" && json.goodsList[i].orgPrice != 0)){
                            template += "<span class=\"sale\"><b>"+json.goodsList[i].discount_rate+"</b>%</span>";
                            template += "<span class=\"prc\"><b>"+commaNum(json.goodsList[i].price)+"</b>원";
                            template += "<del>"+commaNum(json.goodsList[i].orgPrice)+"원</del>";
                        }else if((json.goodsList[i].discount_rate == "" || json.goodsList[i].discount_rate == "0") || (json.goodsList[i].orgPrice == "" || json.goodsList[i].orgPrice == "0")){
                            template += "<span class=\"sale\"><b>특별가</b></span>";
                            template += "<span class=\"prc\"><b>"+commaNum(json.goodsList[i].price)+"</b>원";
                        }
                    }else{
                        template += "<span class=\"sale\"><b>특별가</b></span>";
                        template += "<span class=\"prc\"><b>"+commaNum(json.goodsList[i].price)+"</b>원";
                    }
                    template += "</span>";
                    template += "</div>";
                    template += "</div>";
                    template += "</a>";
                    if(json.goodsList[i].pcnt){
                        template += "<div class=\"option_area\">"+json.goodsList[i].pcnt+"개 구매";
                    }
                    if(json.goodsList[i].option){
                        var option = json.goodsList[i].option;
                        var optSplit = option.split(',');
                        for(var j=0;j<optSplit.length;j++){
                            if(optSplit[j] == "무료배송"){
                                template += "<em>"+optSplit[j]+"</em>";
                            }
                        }
                    }
                    template += "</div>";
                    template += "</li>";
                }else{
                    template += "<li>";
                    template += "<a href=\"javascript:///\" modelnm=\""+ json.goodsList[i].goodsnm +"\" class=\"best_area\" url=\""+ json.goodsList[i].url +"\" modelno=\""+ json.goodsList[i].modelno+"\" pl_no=\""+ json.goodsList[i].pl_no +"\">";
                    template += "<div class=\"thum\">";
                    if (typeof json.goodsList[i].wmov != "undefined"){
                    	template += "<em class='play ico_m' data-mov='"+json.goodsList[i].wmov+"'>PLAY</em>";
                    }
                    template += 	"<img data-original=\""+json.goodsList[i].shopImageUrl+"\" alt='' class='bestLazy' src='http://imgenuri.enuri.gscdn.com/images/m_home/noimg.png' />";

                    template += "</div>";

                    template += "<div class=\"info\">";
                    if(shop_code == "536"){
                        template += "<span class=\"mall\"><img src=\""+IMG_ENURI_COM+"/images/mobilefirst/main/shoplogo/superdeal.png\" alt=\"\" /></span>";
                    }else if(shop_code == "4027"){
                        template += "<span class=\"mall\"><img src=\""+IMG_ENURI_COM+"/images/mobilefirst/main/shoplogo/allkill.png\" alt=\"\" /></span>";
                    }else{
                        template += "<span class=\"mall\"><img src=\""+IMG_ENURI_COM+"/images/mobilefirst/main/shoplogo/shocking.png\" alt=\"\" /></span>";
                    }
                    template += "<strong>"+json.goodsList[i].goodsnm+"</strong>";
                    template += "<div class=\"price\">";
                    if(json.goodsList[i].discount_rate){
                        if((json.goodsList[i].discount_rate != "" && json.goodsList[i].discount_rate != 0) && (json.goodsList[i].orgPrice != "" && json.goodsList[i].orgPrice != 0)){
                            template += "<span class=\"sale\"><b>"+json.goodsList[i].discount_rate+"</b>%</span>";
                            template += "<span class=\"prc\"><b>"+commaNum(json.goodsList[i].price)+"</b>원";
                            template += "<del>"+commaNum(json.goodsList[i].orgPrice)+"원</del>";
                        }else if((json.goodsList[i].discount_rate == "" || json.goodsList[i].discount_rate == "0") || (json.goodsList[i].orgPrice == "" || json.goodsList[i].orgPrice == "0")){
                            template += "<span class=\"sale\"><b>특별가 </b></span>";
                            template += "<span class=\"prc\"><b>"+commaNum(json.goodsList[i].price)+"</b>원";
                        }
                    }else{
                        template += "<span class=\"sale\"><b>특별가 </b></span>";
                        template += "<span class=\"prc\"><b>"+commaNum(json.goodsList[i].price)+"</b>원";
                    }
                    template += "</span>";
                    template += "</div>";
                    template += "</div>";
                    template += "</a>";
                    if(json.goodsList[i].pcnt){
                        template += "<div class=\"option_area\">"+json.goodsList[i].pcnt+"개 구매";
                    }
                    if(json.goodsList[i].option){
                        var option = json.goodsList[i].option;
                        var optSplit = option.split(',');
                        for(var j=0;j<optSplit.length;j++){
                            if(optSplit[j] == "무료배송"){
                                template += "<em>"+optSplit[j]+"</em>";
                            }
                        }
                    }
                    template += "</div>";
                    template += "</li>";
                }
                $("#hotDealBestList").append(template);
            }
                hot_list = json;
                $(".best_area").each(function(){
                    $(this).on("click",function(event) {
                        goShop($(this).attr("url")+"&from=swt",shop_code,$(this).attr("pl_no"),'','','','','',this,$(this).attr("modelno"));
                        ga("send", "event", "st_hotdeal", "buy", "buy_"+shop_name+"_"+$(this).attr("modelnm"));
                    });
                });

                $(".play.ico_m").click(function(){
                	if(agentCheck() == "I"){
                		alert("아이폰은 재생할수 없습니다.");
                		return false;
                	}
                	var movUrl = $(this).attr("data-mov");
                	window.open(movUrl);
                	return false;

                });
            }
        },
        complete : function(data) {

        	$(".bestLazy").lazyload({
        		effect:'fadeIn',
                threshold:500,
                failure_limit:2 ,
                skip_invisible : true
        	});

        },
        error : function(result) {
            alert("error occured. Status:" + result.status
             + ' --Status Text:' + result.statusText
            + " --Error Result:" + result);
        }
    });
}
function go_cate(cate){	
	window.open("/mobilefirst/list.jsp?cate="+cate+"&from=swt");
	return false;
}
function insertLogModel(logNum,modelno,cate){
	var url = "/view/Loginsert_2010.jsp"
	var param = "kind="+logNum+"&modelno="+modelno+"&cate="+cate;
	if (libTypeCheck() == "PR"){
		var getRec = new Ajax.Request(
			url,
			{
				method:'get',parameters:param
			}
		);
	}else{
		$.ajax({
			type: "POST",  
			url: url, 
			data: param
		});  
	}
}
var libTypeCheck = function(){
	var rtn = "";
	if (typeof(Prototype) != "undefined" ){
		rtn = "PR"
	}else if(typeof(jQuery) != "undefined"){
		rtn = "JQ"
	}
	return rtn;
}