(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)})(window,document,'script','//www.google-analytics.com/analytics.js','ga_enuri');ga_enuri('create', 'UA-52658695-5', 'auto');
var enuriHome = {};

//가격비교 클릭시 
enuriHome.enuri_home_pageView = function(){
    ga_enuri('send', 'pageview', {        'page': '/mobilefirst/http/uplusHome.html',        'title': '유플러스_에누리홈'    });
};
    
//스마트택배
enuriHome.goSmartInstall = function (){
        ga_enuri('send', 'event', 'mf_home', 'mf_family', 'famliy_스마트택배');
        if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
                location.href = "https://itunes.apple.com/kr/app/id523045854?freetoken=outlink";
        }else if(navigator.userAgent.indexOf("Android") > -1){
                location.href = "market://details?id=com.sweettracker.smartparcel&referrer=utm_source%Enuri%26utm_medium%app_banner%26utm_campaign%3Dinstall_promotion_from_Enuri";
        }
};
//홈쇼핑
enuriHome.goHomeShoppingInstall = function (){
        ga_enuri('send', 'event', 'mf_home', 'mf_family', 'famliy_홈쇼핑_가격비교');
        if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
                location.href = "https://itunes.apple.com/kr/app/id1053348835?freetoken=outlink";
        }else if(navigator.userAgent.indexOf("Android") > -1){
                location.href = "market://details?id=com.enuri.homeshopping&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_app_click%26utm_campaign%3Dfamilyapp20151209";
        }
};
//핫딜
enuriHome.goHotDealInstall = function (){
        ga_enuri('send', 'event', 'mf_home', 'mf_family', 'famliy_소셜가격비교');
        if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
            //location.href = "http://appstore.com/%EC%86%8C%EC%85%9C%EA%B0%80%EA%B2%A9%EB%B9%84%EA%B5%90%ED%95%AB%EB%94%9C%EA%B0%80%EA%B2%A9%EB%B9%84%EA%B5%90%EC%B5%9C%EC%A0%80%EA%B0%80%EC%86%8C%EC%85%9C%EC%BB%A4%EB%A8%B8%EC%8A%A4%EB%B0%98%EA%B0%92?freetoken=outlink";
                location.href = "https://itunes.apple.com/kr/app/id944887654?freetoken=outlink";
        }else if(navigator.userAgent.indexOf("Android") > -1){
                location.href = "market://details?id=com.enuri.deal&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_app_click%26utm_campaign%3Dfamilyapp20151209";
        }
};
//해외직구
enuriHome.directBuyInstall = function(){
        ga_enuri('send', 'event', 'mf_home', 'mf_family', 'famliy_해외직구');
        
        if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
            location.href = "https://itunes.apple.com/kr/app/id992420740?freetoken=outlink";
        }else if(navigator.userAgent.indexOf("Android") > -1){
            location.href = "market://details?id=com.megabrain.modagi&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_web_click%26utm_campaign%3Dfamilyapp20160705";
        }
};
enuriHome.enuri_goLink = function(url,adtxt){
    ga_enuri('send', 'event', 'up_shopping_tab', 'banner', "banner_"+adtxt);
    window.open(url);
};

enuriHome.fn_Enuri_PV = function(part, page_type, shop_code, pl_no, modelno){
    /*
     melog04":pageview, "melog05":click out
     MOBILE : PV - Page_type info  (U+ 메인, 쇼핑, 일반상품, VIP 의 PAGE view)
     =============
     PV_MAIN : 메인 페이지 PV
     PV_POPULAR : 인기상품 페이지 PV
     PV_PL : 일반상품 쇼핑몰 이동시 PV 
     PV_VIP : VIP PV 
     =============
     MOBILE : Click out - Page_type info  (vip이동, 일반상품에 대한 쇼핑몰이동)
     =============
     CO_VIP : enuri vip로 이동시 click out
     CO_PL : 일반상품 쇼핑몰 이동시 click out
     =============
     */
    var logCode = "";
    
    if(part == "pv")        logCode = "melog04";
    else if(part == "co")        logCode = "melog05";
    
    var vUserip = "";
    
    $.getJSON("http://jsonip.com/?callback=?", function (data) {
        vUserip =data.ip;
        
        var strUrl = "http://mymelog.enuri.com/MYMELOG/setLog.enr";
        var strParam = "logAuthCode="+ logCode +"&cpCode=CP0001&pageType="+ page_type +"&shopCode="+ shop_code +"&plNo="+ pl_no +"&modelno="+ modelno +"&userIp="+ vUserip;
        var strUrllink = strUrl + "?" + strParam;
        
          $.ajax({
            url: strUrllink,
            dataType: 'jsonp',
            jsonpCallback: "callback",
            success: function(data) {},
            error: function(xhr) {}
          });
    });
};

enuriHome.init = function(){
     
     $('.today_list > li > a').off('click').on('click', function(){
           
        var url = $(this).attr("data-url");
        var shop_code = $(this).attr("data-shop");
        var modelno = $(this).attr("data-model");
        var pl_no = $(this).attr("data-plno");
        var part = "co";
        var page_type = "CO_PL";
        var modelnm = $(this).find("strong").text();
        var pl_no = $(this).attr("data-plno");
        var data_part = $(this).attr("data-part");
        var data_txt = $(this).attr("data-txt");
        
        if(data_part == "A"){
            ga_enuri('send', 'event', 'up_shopping_tab', 'middle banner', "middle_banner_"+data_txt);
        }else{
            ga_enuri('send', 'event', 'up_home_goods', 'goods', data_part+"_"+shop_code+"_"+modelnm);
            enuriHome.fn_Enuri_PV(part, page_type, shop_code, pl_no, modelno);            
        }
        window.open(url);
     });
     $('.today_list > li > div').off('click').on('click', function(){ 
        
        var tag = event.target.className;
        var node = event.target.nodeName;
        var id = event.target.id;
        
        var modelno = $(this).attr("data-no");
        var shop_code =  $(this).parent().find("a").attr("data-shop");
        var modelno =  $(this).parent().find("a").attr("data-model");
        var pl_no =  $(this).parent().find("a").attr("data-plno");
        var part = "co";
        var page_type = "CO_VIP";
        
        var cate = $(this).parent().find("a").attr("data-cate");
        var catenm = $(this).parent().find("a").attr("data-catenm");
        
        var data_part = $(this).parent().find("a").attr("data-part");
        var modelnm = $(this).parent().find("a").find("strong").text();
        
        var datailUrl = "http://m.enuri.com/mobilefirst/detail.jsp?from=uplus&modelno="+modelno;
        
        if(tag == 'pr'){
            
            ga_enuri('send', 'event', 'up_home_goods', 'click_goods', "click_VIP_"+modelnm );
            enuriHome.fn_Enuri_PV(part, page_type, shop_code, pl_no, modelno);
            window.open(datailUrl);
        }else if(tag == 'comt' || tag == 'ico_m'){
            
            ga_enuri('send', 'event', 'up_home_goods', 'click_goods', "click_상품평_"+modelnm );
            enuriHome.fn_Enuri_PV(part, page_type, shop_code, pl_no, modelno);
            window.open(datailUrl+"&tab=3");
        }else if(tag == 'go_store'){//카테고리

            ga_enuri('send', 'event', 'up_home_goods', 'click_goods', "click_"+catenm+"_"+modelnm );
             window.open("http://m.enuri.com/mobilefirst/list.jsp?cate="+cate);
        }else if(tag == ""){
            if(node == "EM"){
                if(id == "ptxt"){
                    var data_title = $(this).attr("data-title");
                    ga_enuri('send', 'event', 'up_home_goods', 'plan_banner', 'plan_banner_'+data_title);
                    var planUrl = $(this).attr("data-plan");
                    window.open(planUrl);
                }else{//카테고리
                    ga_enuri('send', 'event', 'up_home_goods', 'click_goods', "click_"+catenm+"_"+modelnm );
                    window.open("http://m.enuri.com/mobilefirst/list.jsp?cate="+cate);
                }
                
            }else if(id == "subtxt"){
                    var data_title = $(this).attr("data-title");
                    ga_enuri('send', 'event', 'up_home_goods', 'plan_banner', 'plan_banner_'+data_title );
                    var planUrl = $(this).attr("data-plan");
                    window.open(planUrl);
            }
        }else if(tag == "txtbox"){
            var data_title = $(this).attr("data-title");
            ga_enuri('send', 'event', 'up_home_goods', 'plan_banner', 'plan_banner_'+data_title );
            var planUrl = $(this).attr("data-plan");
            window.open(planUrl);            
        }
     });

    $(".buy_tip > li ").off('click').on('click', function(){
        var vipUrl = $(this).attr("data-vip");
        var modelnm = $(this).attr("data-nm");
        var ord = $(this).attr("data-ord");
        ga_enuri('send', 'event', 'up_home_goods', 'plan', "plan_sub"+ord+"_"+modelnm);
        window.open("http://m.enuri.com/"+vipUrl+"&from=uplus");
    });
    $('ul.m_depth li').off('click').on('click', function(){ 
        var $this = $(this); 
        var index = $this.index();
        var text = $this.text();
        
        ga_enuri('send', 'event', 'up_shopping_tab', 'sub', "sub_"+text);
        
        if($this.index() == 0)                 window.open('http://m.enuri.com/mobilefirst/cpp.jsp?gcate=1'); 
        else if($this.index() == 1)            window.open('http://m.enuri.com/mobilefirst/cpp.jsp?gcate=2'); 
        else if($this.index() == 2)            window.open('http://m.enuri.com/mobilefirst/cpp.jsp?gcate=3'); 
        else if($this.index() == 3)            window.open('http://m.enuri.com/mobilefirst/cpp.jsp?gcate=4'); 
        else if($this.index() == 4)            window.open('http://m.enuri.com/mobilefirst/cpp.jsp?gcate=5'); 
        else if($this.index() == 5)            window.open('http://m.enuri.com/mobilefirst/cpp.jsp?gcate=6'); 
        else if($this.index() == 6)            window.open('http://m.enuri.com/mobilefirst/cpp.jsp?gcate=7'); 
        
        if (index == 7) {
        	window.open('http://m.enuri.com/mobilefirst/index.jsp#5');//쇼핑팁 시즌텝있을경우 5 없을경우 4
            return; 
        } 
    });

$(".newMallList > li > a > img").off('click').on('click', function(){
        var mall = $(this).attr("alt");
        var outLinkUrl = "";
        ga_enuri('send', 'event', 'up_shopping_tab', 'shop', "shop_"+mall);
        
        if (mall == '롯데닷컴')             outLinkUrl = "http://m.lotte.com/main_phone.do?udid=&cn=112346&cdn=783491&DEVICE_BROWSER=Y";
        else if (mall == '신세계몰')             outLinkUrl = "http://m.shinsegaemall.ssg.com/mall/main.ssg?ckwhere=s_enuri&DEVICE_BROWSER=Y";
        else if (mall == '현대H몰')             outLinkUrl = "http://www.hyundaihmall.com/front/shNetworkShop.do?NetworkShop=Html&ReferCode=022&Url=http://www.hyundaihmall.com/Home.html&DEVICE_BROWSER=Y";
        else if (mall == '갤러리아')             outLinkUrl = "http://www.galleria.co.kr/common.do?method=join&channel_id=2764&link_id=0001&DEVICE_BROWSER=Y";
        else if (mall == 'GS SHOP')             outLinkUrl = "http://with.gsshop.com/jsp/jseis_withLGeshop.jsp?DEVICE_BROWSER=Y&media=Pg&gourl=http://m.gsshop.com";
        else if (mall == 'CJmall')             outLinkUrl = "http://mw.cjmall.com/m/main.jsp?app_cd=ENURI&DEVICE_BROWSER=Y";
        else if (mall == '롯데 홈쇼핑')             outLinkUrl = "http://www.lotteimall.com/coop/affilGate.lotte?chl_no=140769&chl_dtl_no=2540476&DEVICE_BROWSER=Y";
        else if (mall == 'ak mall')             outLinkUrl = "http://www.akmall.com/assc/associate.jsp?assc_comp_id=26392&DEVICE_BROWSER=Y";
        else if (mall == '홈앤쇼핑')             outLinkUrl = "http://m.hnsmall.com/channel/gate?channel_code=20200&DEVICE_BROWSER=Y";
        else if (mall == '11번가')             outLinkUrl = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1000997249&DEVICE_BROWSER=Y";
        else if (mall == '이마트')             outLinkUrl = "http://m.emart.ssg.com/planshop/planShopBest.ssg?ckwhere=m_enuri&DEVICE_BROWSER=Y";
        else if (mall == 'dshop')             outLinkUrl = "http://www.dnshop.com/?Sid=0024_8H050000_01_01&DEVICE_BROWSER=Y";
        else if (mall == '위메프')             outLinkUrl = "http://www.wemakeprice.com/widget/aff_bridge_public/enuri_m/0/Y/PRICE_af?DEVICE_BROWSER=Y";
        else if (mall == '티몬')             outLinkUrl = "http://m.ticketmonster.co.kr/entry/?jp=80025&ln=214285&DEVICE_BROWSER=Y";
        else if (mall == '보리보리')             outLinkUrl = "http://m.boribori.co.kr/partner/commonv2.aspx?partnerid=b_enuri_m2&ReturnUrl=http%3a%2f%2fm.boribori.co.kr&DEVICE_BROWSER=Y";
        else if (mall == 'G9')             outLinkUrl = "http://m.g9.co.kr/Default.htm?jaeuid=200006436#/Display/G9Today?DEVICE_BROWSER=Y";
        else if (mall == '지마켓')             outLinkUrl = "http://www.gmarket.co.kr/index.asp?jaehuid=200006254&DEVICE_BROWSER=Y";
        else if (mall == '옥션')             outLinkUrl = "http://mobile.auction.co.kr/HomeMain?BCODE=BN00149093&DEVICE_BROWSER=Y";
        else if (mall == '인터파크')             outLinkUrl = "http://m.interpark.com/mobileGW.html?svc=Shop&bizCode=P14126&url=http://m.shop.interpark.com&DEVICE_BROWSER=Y";
        else if (mall == '엘롯데')             outLinkUrl = "http://m.ellotte.com/main.do?&cn=153348&cdn=2942692&DEVICE_BROWSER=Y";
        else if (mall == 'NSmall')             outLinkUrl = "http://m.nsmall.com/mjsp/site/gate.jsp?co_cd=190&target=http%3A%2F%2Fm.nsmall.com%2FMainView&DEVICE_BROWSER=Y";
        else if (mall == '쿠팡')            outLinkUrl = "http://www.coupang.com/landingMulti.pang?sid=Enuri&src=1033035&spec=10305201&addtag=400&utm_source=EN&utm_medium=Enuri_PCS&utm_campaign=PC_EP&forceBypass=Y&synd_meta=ENURI&homeLanding=Y&DEVICE_BROWSER=Y";
        window.open(outLinkUrl);
    });
    //slick 호출     
    
};

enuriHome.init();
