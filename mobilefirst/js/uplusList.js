(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)})(window,document,'script','//www.google-analytics.com/analytics.js','ga_enuri');ga_enuri('create', 'UA-52658695-5', 'auto');
    var enuri = {};
    enuri.pagingLog = function (page){        ga_enuri('send', 'event', 'up_home_shopping', 'paging', "click_"+page);    };
    enuri.pageViewLog = function (page){    
        ga_enuri('send', 'pageview', {'page': '/mobilefirst/http/uplusList.html','title': '유플러스 리스트_'+page});    
    };
    enuri.fn_Enuri_L_PV = function (part, page_type, shop_code, pl_no, modelno){
        //"melog04":pageview, "melog05":click out
        /*
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
        
        if(part == "pv")            logCode = "melog04";
        else if(part == "co")            logCode = "melog05";
        
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
                success: function(data) {
                  console.log('성공 - ', data);
                },
                error: function(xhr) {
                  console.log('실패 - ', xhr);
                }
              });
            
        });
        
    };

$(document).ready(function(){
    enuri.pageViewLog(1);
    
    $("body").on('click', '.enuri_mall > li', function(event) {
        var modelno = $(this).attr("data-id");
        var shopcode = $(this).attr("data-code");
        var plno = $(this).attr("data-no");
        var page_type = "CO_VIP";
        var part = "co";
        
        enuri.fn_Enuri_L_PV(part, page_type, shopcode, plno, modelno);
        ga_enuri('send', 'event', 'up_home_shopping', 'goods', "click_"+modelno);
        
        try{
        	var gaPrefix = window.shoplayer.uplusGaPrefix || '';
            ga('eventGa.send', 'event', {'eventCategory': gaPrefix+'shopping_item_click_tab4','eventAction': 'shopping','eventLabel': ''});
        }catch(e){
        	console.log("eventGa.send error:"+e);
        }
        location.href = "http://m.enuri.com/mobilefirst/detail.jsp?from=uplus&modelno="+modelno;
    });
    
});