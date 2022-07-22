// google analytics
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
    //런칭할때 UA-52658695-3 으로 변경
    ga('create', 'UA-52658695-3', 'auto');

$(document).ready(function() {
    "use strict"
    var sessionStorage = null,
        gJson = "", // 세션 스토리지에서 menu json 값을 확인 없으면 메뉴json 데이터를 받아온다.
        d = "";
    $("body").on('touchend', function(e) {
        if (window.android && android.onTouchEnd) {
            window.android.onTouchEnd();
        } else if ($("#ios").val()) {}
    });
    /**
     */
    (function initializeHome() {
        setCookie("c1dept", "", -1);
        setCookie("c2dept", "", -1);
        sessionStorage = $.sessionStorage;
        // 앱이면 하단 에누리앱 설치 보이지 않기 
        if ($("#app").val()) {
            $(".install > > li:last").hide();
        }
        if ($("#app").val() && IsLogin()) {
            // if (datePopUpSet("2015/12/30", "popup")) {
            //     return;
            // }

            if (getCookie('cashback_popup') == "CHECKED") {
                return;
            }
            $.getJSON("./ajax/rewardAjax/memberPointYNAjax.jsp", function(result) {
                if (result.pointYN == 0) {
                    var $mainLayer = $("#mainLayer2");
                    //$mainLayer.show();
                    $(".cashLayer").on('click', function(e) {
                        var $target = $(e.target);
                        $mainLayer.hide();
                        if ($target.is("a")) {
                            fnEverSetCookie("cashback_popup", "CHECKED", 1);
                        } else {
                            window.location.href = "./event/event_cashback.jsp?freetoken=event";
                            return false;
                        }
                    });
                }
            });
        }
        initMiddleBanner();
    })();
    /***  중간 띠배너*/
    function initMiddleBanner() {
        $.getJSON('./ajax/middle_banner.json', function(json) {
            // 안드로이드 앱이 아니면 설치 이벤트 화면은 보여주지 않는다.
            if (!$("#app").val()) { // 웹일경우 
                //  if(!$("#ios").val() && !window.android){            // 안드로이드 웹일경우       
                json = $.grep(json, function(n, i) {
                    try {
                        return n.ALT.indexOf("event_cerkey_enter.jsp") <= -1;
                    } catch (e) {
                        return false;
                    }
                });
                //    }             
            }
            json = shuffle(json); // 랜덤으로 하나만 노출
            var item = json[0];
            // 아이템이 없으면 중간 배너 비노출 
            if (!item) {
                return;
            }
            $(".evtbanner").show()
                .find('a')
                .html('<img src="' + item.IMG1 + '" alt="' + item.ALT + '"  width="100%" />')
                .on('click', function() {
                    var url = item.ALT;
                    var title = item.TXT1;
                    if (url.indexOf('mobilefirst/event/ramen') > 0) {
                        if ($("#app").val()) {
                            ga('send', 'event', 'mf_home', 'middle banner', 'middle_banner_라면백_앱');
                            url = "/mobilefirst/event/ramen_event_eve.jsp?app=Y&freetoken=event";
                        } else {
                            ga('send', 'event', 'mf_home', 'middle banner', 'middle_banner_라면백_웹');
                            url = "/mobilefirst/event/ramen_event_web.jsp";
                        }
                    } else {
                        // 이벤트 페이지가 아닐경우 
                        if (url.indexOf('enuri.com/mobilefirst/event') < 0) {
                            url = item.JURL1;
                        }
                        ga('send', 'event', 'mf_home', 'middle banner', 'middle_banner_' + title);
                    }
                    window.location.href = url;
                    //window.open(url);
                }).find('img').error(function() {
                    $(this).parent().hide();
                });
            // img url의 cross domain를 피하기 위해  
            // img 호출을 위해 #dummy div 에 붙여준다.                
            setTimeout(function() {
                var img = "<img src='" + item.IMG1 + "' />";
                $("#dummy").append(img);
            }, 1500);

        });
    }
    /***  로그인*/
    $("#loginBtn").on('click', function() {
        var host = location.hostname,
            url = "http://" + host + "/mobilenew/login/login.jsp?app=&backUrl" + "=http://" + host + "/deal/mobile/main.deal";
        window.location.href = url;
    });
    /*** 메뉴 버튼*/
    $(".newgnb > li > a").on('click', function() {
        var $this = $(this),
            url = $(this).attr('href');
        ga('send', 'event', 'mf_home', 'tab', 'tab_' + $this.text());
        if ($this.is('.newWindow')) {
            window.open(url);
        } else {
            location.href = url;
        }
        return false;
    });
    /*** 트렌드픽업, 백화점, 쇼설모아 더보기*/
    $("#trendPickMoreBtn, #departMoreBtn, .morebtn_deal > a").on('click', function() {
        var $this = $(this);
        var url = $this.attr('href');
        // log  
        if ($this.is("#trendPickMoreBtn")) {
            ga('send', 'event', 'mf_home', 'more', 'more more_트렌드더보기');
            if ($("#ios").val()) {
                url += "#pickup";
            }
        } else if ($this.is("#departMoreBtn")) {
            ga('send', 'event', 'mf_home', 'more', 'more more_백화점더보기');
        } else {
            ga('send', 'event', 'mf_home', 'more', 'more more_소셜모아더보기');
        }
        window.location.href = url;
        return false;
    });
    /*** 카테고리 선택*/
    $("ul.m_depth li").on('click', function(event) {
        try {
            event.stoppropagation();
            event.preventdefault();
        } catch (e) {}
        var $this = $(this),
            className = $this.attr('class'),
            cateType = getCookie("cateType"),
            cate = convertCate($this.index());
        ga('send', 'event', 'mf_home', 'sub', 'sub_' + $this.text());
        // 소셜모아 or 백화점은 링크 이동
        if ($this.index() == 7) { // 소셜비교 
            window.location.href = "http://m.enuri.com/deal/mobile/main.deal";
            return;
        } else if ($this.index() == 8) { // 백화점비교  
            window.location.href = "http://m.enuri.com/mobiledepart/Index.jsp";
            return;
        }
        // 카테고리 메뉴선택항목을 쿠키에 저장 
        setCookie("c1dept", cate);
        if (window.android) {
            try {
                android.onCate(className);
            } catch (e) {console.e('no send android');}
        } else if ($("#ios").val() && $("#app").val() == "Y") {
            var index = parseInt($this.index()) + 1;
            var url = "appcall:gocate=";
            if (className == 'm08') { // 전체 카테고리
                url += "all";
            } else {
                url += index;
            }
            if(index == 10){ //아이폰 전체카테고리 예외처리
                url = "appcall:gocate=1";
            }
            window.location = url;
        } else {
            //  카테고리가 없으면 전체 카테고리임
            // 전체 카테고리일경우에는 N 값으로 셋팅
            if (!cate) {
                cateCurtainLoading("N");
                //$(".type_btn").remove();  
                // 카테고리 버전이 커튼일 경우
            } else if (cateType == 'B') {
                cateCurtainLoading("Y");
            } else { // 카테고리 버전이 리스트일 경우
                cateListLoading("Y");
            }
        }
        $this.css('background-color', '#fff');
        function convertCate(cate) {
            if (cate == 0)  return "A103";
            else if (cate == 1)  return "A107";
            else if (cate == 2)  return "A109";
            else if (cate == 3)  return "A110";
            else if (cate == 4)  return "A112";
            else if (cate == 5)  return "A114";
            else if (cate == 6)  return "A118";
            return '';
        }
    }).on('touchstart', function() {
        $(this).css('background-color', '#c1e0e5')
            .siblings()
            .css('background-color', '#fff');
    }).on('touchend', function() {
        $("ul.m_depth li").css('background-color', '#fff');
    }).on('touchmove', function() {
        $("ul.m_depth li").css('background-color', '#fff');
    });
    // link
    $(".newMallList > li > a > img").click(function() {
        var mall = $(this).attr("alt");
        var outLinkUrl = "";
        if (mall) {
            ga('send', 'event', 'mf_home', 'shop', 'shop_' + mall);
        }

        if (mall == '롯데닷컴') {
            outLinkUrl = "http://m.lotte.com/main_phone.do?udid=&cn=112346&cdn=783491&DEVICE_BROWSER=Y";
        } else if (mall == '신세계몰') {
            outLinkUrl = "http://m.shinsegaemall.ssg.com/mall/main.ssg?ckwhere=s_enuri&DEVICE_BROWSER=Y";
        } else if (mall == '현대H몰') {
            outLinkUrl = "http://www.hyundaihmall.com/front/shNetworkShop.do?NetworkShop=Html&ReferCode=022&Url=http://www.hyundaihmall.com/Home.html&DEVICE_BROWSER=Y";
        } else if (mall == '갤러리아') {
            outLinkUrl = "http://www.galleria.co.kr/common.do?method=join&channel_id=2764&link_id=0001&DEVICE_BROWSER=Y";
        } else if (mall == 'GS SHOP') {
            outLinkUrl = "http://with.gsshop.com/jsp/jseis_withLGeshop.jsp?DEVICE_BROWSER=Y&media=Pg&gourl=http://m.gsshop.com";
        } else if (mall == 'CJmall') {
            outLinkUrl = "http://mw.cjmall.com/m/main.jsp?app_cd=ENURI&DEVICE_BROWSER=Y";
        } else if (mall == '롯데 홈쇼핑') {
            outLinkUrl = "http://www.lotteimall.com/coop/affilGate.lotte?chl_no=140769&chl_dtl_no=2540476&DEVICE_BROWSER=Y";
        } else if (mall == 'ak mall') {
            outLinkUrl = "http://www.akmall.com/assc/associate.jsp?assc_comp_id=26392&DEVICE_BROWSER=Y";
        } else if (mall == '홈앤쇼핑') {
            outLinkUrl = "http://m.hnsmall.com/channel/gate?channel_code=20200&DEVICE_BROWSER=Y";
        } else if (mall == '11번가') {
            outLinkUrl = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1000997249&DEVICE_BROWSER=Y";
        } else if (mall == '이마트') {
            outLinkUrl = "http://m.emart.ssg.com/planshop/planShopBest.ssg?ckwhere=m_enuri&DEVICE_BROWSER=Y";
        } else if (mall == 'dshop') {
            outLinkUrl = "http://www.dnshop.com/?Sid=0024_8H050000_01_01&DEVICE_BROWSER=Y";
        } else if (mall == '위메프') {
            outLinkUrl = "http://www.wemakeprice.com/widget/aff_bridge_public/enuri_m/0/Y/PRICE_af?DEVICE_BROWSER=Y";
            //            var d = new Date();
            //            var currtime = d.getHours() * 100 + d.getMinutes();
            //            if(d.getDate() == 19){
            //              if(currtime >= 800){
            //                  alert("쇼핑몰 시스템 점검 중입니다.\n12/19일(토) ~ 12/21일(월)");
            //                  return; 
            //              }
            //              
            //            }
            //            
            //            if(d.getDate() == 20){
            //              alert("쇼핑몰 시스템 점검 중입니다.\n12/19일(토) ~ 12/21일(월)");
            //              return; 
            //            }
            //            
            //            if(d.getDate() == 21){
            //              if(currtime <= 0930){
            //                  alert("쇼핑몰 시스템 점검 중입니다.\n12/19일(토) ~ 12/21일(월)");
            //                  return; 
            //              }
            //            }

        } else if (mall == '티몬') {
            outLinkUrl = "http://m.ticketmonster.co.kr/entry/?jp=80025&ln=214285&DEVICE_BROWSER=Y";
        } else if (mall == '보리보리') {
            outLinkUrl = "http://m.boribori.co.kr/partner/commonv2.aspx?partnerid=b_enuri_m2&ReturnUrl=http%3a%2f%2fm.boribori.co.kr&DEVICE_BROWSER=Y";
        } else if (mall == 'G9') {
            outLinkUrl = "http://m.g9.co.kr/Default.htm?jaeuid=200006436#/Display/G9Today?DEVICE_BROWSER=Y";
            // outLinkUrl = "http://www.homeplus.co.kr/app.exhibition.main.PartnerMall.ghs?extends_id=enuri&service_cd=56080&nextUrl=http://www.homeplus.co.kr&DEVICE_BROWSER=Y";
        } else if (mall == '지마켓') {
            outLinkUrl = "http://www.gmarket.co.kr/index.asp?jaehuid=200006254&DEVICE_BROWSER=Y";
        } else if (mall == '옥션') {
            outLinkUrl = "http://banner.auction.co.kr/bn_redirect.asp?ID=BN00181187&DEVICE_BROWSER=Y";
        } else if (mall == '인터파크') {
            outLinkUrl = "http://m.interpark.com/mobileGW.html?svc=Shop&bizCode=P14126&url=http://m.shop.interpark.com&DEVICE_BROWSER=Y";
        } else if (mall == '엘롯데') {
            outLinkUrl = "http://m.ellotte.com/main.do?&cn=153348&cdn=2942692&DEVICE_BROWSER=Y";
        } else if (mall == 'NSmall') {
            outLinkUrl = "http://m.nsmall.com/mjsp/site/gate.jsp?co_cd=190&target=http%3A%2F%2Fm.nsmall.com%2FMainView&DEVICE_BROWSER=Y";
        } else if (mall == '쿠팡') {
           outLinkUrl = "http://www.coupang.com/landingMulti.pang?sid=Enuri&src=1033035&spec=10305201&addtag=400&utm_source=EN&utm_medium=Enuri_PCS&utm_campaign=PC_EP&forceBypass=Y&synd_meta=ENURI&homeLanding=Y&DEVICE_BROWSER=Y";
        }
        window.open(outLinkUrl);
    });

    //메인 팝업 레이어 오늘하루 띠우지 않기
    var $mainLayer = $("#mainLayer");
    $mainLayer.find(".btn_today").on('click', function() {
        fnEverSetCookie("linker_popup3", "CHECKED", 7);
        $mainLayer.hide();
    });
/*
    $mainLayer.find("#btnNew").on('click', function() {
        var link = "/mobilefirst/event/event_three.jsp";
        $mainLayer.hide();
        ga('send', 'event', 'mf_home', 'event', "레이어배너_상");
        location.href = link;
    });

    $mainLayer.find("#btnBuy").on('click', function() {
        var link = "/mobilefirst/event/mobile_award_2016.jsp";
        $mainLayer.hide();
        ga('send', 'event', 'mf_home', 'event', "레이어배너_하");
        location.href = link;
    });
    */
    /**
     *  메인 팝업 닫기 
     */
    $("#mainLayer .btn_close").on('click', function() {
        $("#mainLayer").hide();
    });
    //쿠키 날짜 대로
    function fnEverSetCookie(name, value, expiredays) {
        var todayDate = new Date();
        todayDate.toGMTString()
        todayDate.setDate(todayDate.getDate() + expiredays);
        document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";"
    }
    //해당 날짜 이상일 경우는 해당 함수를 호출 하지 않는다.
    //setDate = 설정 날짜
    //setFct = 설정 함수
    function datePopUpSet(setDate, setFct) {
        var now = new Date();
        var todayAtMidn = new Date(now.getFullYear(), now.getMonth(), now.getDate());
        var specificDate = new Date(setDate);
        if (specificDate < todayAtMidn) {
            return true;
        } else {
            return false;
        }
    }
    /***  이벤트 팝업*/
    function shortcutPopUp() {
        if (getCookie('shortcut_popup') == "CHECKED" || getMobileOperatingSystem() != 'Android') {
            return;
        }
        $('.wallpaperLayer').slideToggle(500)
            .find(".goevent a")
            .on('click', function() {

                ga('send', 'event', 'mf_home', 'layer', 'layer_바로가기추가');
                $('.wallpaperLayer').hide();
                fnEverSetCookie("shortcut_popup", "CHECKED", 99999);
                // 바로가기 실행
                // 없으면 naver 앱 설치 화면으로 이동 처리
                var url = ["intent://addshortcut?version=18",
                    "&title=",
                    "가격비교&url=http://m.enuri.com",
                    "&icon=http://imgenuri.enuri.gscdn.com/images/mobilefirst/ic_launcher.png",
                    "&serviceCode=2493",
                    "#Intent;",
                    "scheme=naversearchapp;",
                    "action=android.intent.action.VIEW;",
                    "category=android.intent.category.BROWSABLE;",
                    "package=com.nhn.android.search;",
                    "end"
                ];
                location.href = url.join("");
            });
        // 닫기 실행
        $(".bottom_bt a").on('click', function() {
            $('.wallpaperLayer').hide();
            // 7일동안 보여주지 않기
            if ($(this).is("#weekNoShowBtn")) {
                fnEverSetCookie("shortcut_popup", "CHECKED", 7);
                ga('send', 'event', 'mf_home', 'layer', 'layer_일주일 동안 보지 않기');
            } else {
                ga('send', 'event', 'mf_home', 'layer', 'layer_닫기');
            }
        });

        function getMobileOperatingSystem() {
            var userAgent = navigator.userAgent || navigator.vendor || window.opera;

            if (userAgent.match(/iPad/i) || userAgent.match(/iPhone/i) || userAgent.match(/iPod/i)) {
                return 'iOS';
            } else if (userAgent.match(/Android/i)) {
                return 'Android';
            } else {
                return 'unknown';
            }
        }
    };
    /***  디바이스 구분에 따라 로그 판별*/
    (function pageView() {
        var title = 'mf_홈_웹';
        if (window.android) {
            title = 'mf_홈_안드로이드앱';
        } else if ($("#ios").val() && $("#app").val() == "Y") { // 아이폰앱 
            title = 'mf_홈_아이폰앱';
        }
        ga('send', 'pageview', {
            'page': '/mobilefirst/Index.jsp',
            'title': title
        });
    })();
    /***  이벤트 팝업*/
    (function noticePopUp() {
        // 해당 날짜까지 노출
        //if (datePopUpSet("2016/03/31", "popup")) {
        //return;
        //}
        if (getCookie('linker_popup3') != "CHECKED") {
            $("#mainLayer").show();
            $(window).scrollTop();
        } else {}
    })();    
    /***  앱일경우 세션값 등록*/
    (function setPushSession() {
        if ($("#app").val()) {
            $.post("/mobilefirst/push_step1.jsp", {
                sessionVal: true
            });
        }
    })();
    //var trendLoadYN = false;
    var socialLoadYN = false;
    //var departLoadYN = false;
    //var guideLoadYN = false;
    $( window ).scroll(function() {
        var mainPx = $(document).scrollTop();
        /*
        if( mainPx > 280){
            
            if(!trendLoadYN){
                trendPickLoad();
                departLoad();
                trendLoadYN = true;    
            }
        }
        */
        if(mainPx  > 1400 ){
            if(!socialLoadYN){
                socialLoad();
                socialLoadYN = true;
            }
        }
    });
});
