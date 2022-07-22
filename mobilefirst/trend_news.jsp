<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
response.sendRedirect("/mobilefirst/index.jsp#trend");

Cookie[] carr = request.getCookies();
String strAppyn = "";
String strVerios = "";
String strType= ChkNull.chkStr(request.getParameter("type"),"");    
String strAppyn2 = ChkNull.chkStr(request.getParameter("app"),"");  

String strVerand = "";
String strAd_id = "";

try{
    for(int i=0;i<carr.length;i++){
        if(carr[i].getName().equals("appYN")){
            strAppyn = carr[i].getValue();
            break;
        }
    }
    for(int i=0;i<carr.length;i++){
        if(carr[i].getName().equals("verios")){
            strVerios = carr[i].getValue();
            break;
        }
    }
    for(int i=0;i<carr.length;i++){
        if(carr[i].getName().equals("verand")){
            strVerand = carr[i].getValue();
            //break;
        }
    }
    for(int i=0;i<carr.length;i++){
        if(carr[i].getName().equals("adid")){
            strAd_id = carr[i].getValue();
            break;
        } 
    }
} catch(Exception e) {
}  

%>
<!DOCTYPE html>  
<html lang="ko">
<head>
    <meta charset="utf-8">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />  
    <meta property="og:title" content="에누리 가격비교">
    <meta property="og:description" content="에누리 모바일 가격비교">
    <meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilenew/images/logo_enuri.png">
    <%@ include file="/mobilefirst/include/common.html" %>
    <script type="text/javascript" src="/mobilefirst/js/lib/LazyLoad.1.9.3.min.js"></script>
    <script type="text/javascript" src="/mobilefirst/js/lib/iscroll.js"></script>
    <link rel="stylesheet" type="text/css" href="/mobilefirst/css/trend.css"/><!-- 트렌트 메뉴 추가-->
    <link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css">
    <script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
    <script>  
    //이미지 로더 
    (function(e,t,n,r){e.fn.lazy=function(r){function u(n){if(typeof n!="boolean")n=false;s.each(function(){var r=e(this);var s=this.tagName.toLowerCase();if(f(r)||n){if(r.attr(i.attribute)&&(s=="img"&&r.attr(i.attribute)!=r.attr("src")||s!="img"&&r.attr(i.attribute)!=r.css("background-image"))&&!r.data("loaded")&&(r.is(":visible")||!i.visibleOnly)){var u=e(new Image);++o;if(i.onError)u.error(function(){d(i.onError,r);p()});else u.error(function(){p()});var a=true;u.one("load",function(){var e=function(){if(a){t.setTimeout(e,100);return}r.hide();if(s=="img")r.attr("src",u.attr("src"));else r.css("background-image","url("+u.attr("src")+")");r[i.effect](i.effectTime);if(i.removeAttribute)r.removeAttr(i.attribute);d(i.afterLoad,r);u.unbind("load");u.remove();p()};e()});d(i.beforeLoad,r);u.attr("src",r.attr(i.attribute));d(i.onLoad,r);a=false;if(u.complete)u.load();r.data("loaded",true)}}});s=e(s).filter(function(){return!e(this).data("loaded")})}function a(){if(i.delay>=0)setTimeout(function(){u(true)},i.delay);if(i.delay<0||i.combined){u(false);e(i.appendScroll).bind("scroll",h(i.throttle,u));e(i.appendScroll).bind("resize",h(i.throttle,u))}}function f(e){var t=l(),n=c(),r=e.offset().top,s=e.height();return t+n+i.threshold>r&&r+s>t-i.threshold}function l(){if(n.documentElement.scrollTop)return n.documentElement.scrollTop;return n.body.scrollTop}function c(){if(t.innerHeight)return t.innerHeight;if(n.documentElement&&n.documentElement.clientHeight)return n.documentElement.clientHeight;if(n.body&&n.body.clientHeight)return n.body.clientHeight;if(n.body&&n.body.offsetHeight)return n.body.offsetHeight;return i.fallbackHeight}function h(e,t){function s(){function o(){r=+(new Date);t.apply()}var s=+(new Date)-r;n&&clearTimeout(n);if(s>e||!i.enableThrottle)o();else n=setTimeout(o,e-s)}var n;var r=0;return s}function p(){--o;if(!s.size()&&!o)d(i.onFinishedAll,null)}function d(e,t){if(e){if(t!==null)e(t);else e()}}var i={bind:"load",threshold:500,fallbackHeight:2e3,visibleOnly:true,appendScroll:t,delay:-1,combined:false,attribute:"data-src",removeAttribute:true,effect:"show",effectTime:0,enableThrottle:false,throttle:250,beforeLoad:null,onLoad:null,afterLoad:null,onError:null,onFinishedAll:null};if(r)e.extend(i,r);var s=this;var o=0;if(i.bind=="load")e(t).load(a);else if(i.bind=="event")a();if(i.onError)s.bind("error",function(){d(i.onError,e(this))});return this};e.fn.Lazy=e.fn.lazy})(jQuery,window,document);
    </script> 
</head>
<%@ include file="/mobilefirst/include/common_top.jsp" %>
<body> 
<%@ include file="/mobilefirst/gnb/gnb.html" %> 
<nav class="m_top" <%=(strAppyn.equals("Y")?"style=\"display:none;\"":"") %> >
    <ul class="newgnb">
        <li><a href="Index.jsp" onclick="return false;">홈</a></li>
        <li><a href="/mobilefirst/trend_news.jsp?type=pickup" id="trendTab">트렌드픽업</a></li>
        <li><a href="/mobilefirst/best.jsp" >쇼핑베스트</a></li>
        <li><a href="/mobilefirst/trend_news.jsp"  id="trendNews">쇼핑 TIP</a></li>
        <li><a href="/mobilefirst/plan_event.jsp">이벤트</a></li></ul>
    </ul>  
</nav> 
<div id="wrap">  
    <div class="Maincontent">
        <!-- trend_wrap -->
        <section class="trend_wrap">
            <div class="tab_trend" style="display:none;">
                <ul> 
                    <li><a id="bar_news">오늘의 뉴스</a></li>
                    <li><a id="bar_pickup">트렌드 픽업</a></li> 
                </ul>
            </div>
            <div class="tab_news"  style="display:none;"> 
                <ul>
                    <li><a id="bar_news2">오늘의 뉴스</a></li>
                    <li><a id="bar_guide">구매가이드</a></li>
                </ul>
            </div>  

            <!-- trend_area -->
            <div class="trd_nav" style="display:none;">
                <button type="button" class="trd_prev" /></button>
                <button type="button" class="trd_next" /></button>
                <div class="trd_scroll" id="trd_scroll">
                    <div class="hit_List_area">
                        <ul class="hit_product"> 
                            <li><a href="javascript:///" id="t_0"  class="trend_tab on" onclick="trend_tab('0');">전체</a></li>
                            <li><a href="javascript:///" id="t_1"  class="trend_tab" onclick="trend_tab('1');">컴퓨터,디지털</a></li>
                            <li><a href="javascript:///" id="t_2"  class="trend_tab" onclick="trend_tab('2');">영상,가전</a></li>
                            <li><a href="javascript:///" id="t_3"  class="trend_tab" onclick="trend_tab('3');">가구,리빙,FOOD</a></li>
                            <li><a href="javascript:///" id="t_4"  class="trend_tab" onclick="trend_tab('4');">유아.스포츠.패션</a></li>   
                        </ul>
                    </div> 
                </div>
            </div>          
            <div  id="NewsBody" style="display:none;">
                <div class="trend_area  first sp_today">
                    <h3 class="maintit">많이 <span class="stress1">본</span> 뉴스</h3>
                    <!-- news_rank -->
                    <div class="news_rank" id="news_top_list"></div>
                    <!-- //news_rank --> 
                </div>
                <!-- //trend_area -->
         
                <!-- trend_area -->
                <div class="trend_area sp_today">
                    <h3 class="maintit">주제<span onclick="getVer();">별</span> <span class="stress2">최신</span> 뉴스</h3>
                     
                    <!-- news_recent -->
                    <div class="news_recent">
                        <ul class="recentnews_tab">
                            <li><a href="javascript:///" class="recentnews_tab_line on" onclick="news_view('01',this);" id="news_01">디지털/가전</a></li>
                            <li><a href="javascript:///" class="recentnews_tab_line" onclick="news_view('02',this);" id="news_02">컴퓨터</a></li>
                            <li><a href="javascript:///" class="recentnews_tab_line" onclick="news_view('03',this);" id="news_03">스포츠/자동차</a></li>
                            <li><a href="javascript:///" class="recentnews_tab_line" onclick="news_view('04',this);" id="news_04">유아/라이프</a></li> 
                        </ul> 
                    
                        <!-- recentnews_contents -->
                        <ul class="recentnews_contents" id="recentnews_contents"></ul>
                        <!-- //recentnews_contents -->
                    </div>
                    <!-- news_recent -->
                </div>
            </div>
            <div id="PickupBody" style="display:none;"></div>
            <div id="GuideBody" style="display:none;">
                <!-- 최신추천팁 -->
                <div class="trend_area sp_today">
                    <h3 class="maintit"><span class="stress2">최신</span> 추천 TIP</h3>
                    <span class="prod_page"><em>1</em>/<span>5</span></span>
                    
                    <section>
                        <div class="mainbnr">
                            <div class="bannerCarousel"></div>
                        </div>
                    </section>
                </div>
                <!-- 테마별 잘사는 팁 -->
                <div class="trend_area sp_today">
                    <h3 class="maintit">테마별 <span class="stress1">잘사는</span> TIP</h3>
                    <!-- news_recent -->
                    <div class="news_recent">  
                         <ul class="recentnews_tab">
                            <li><a href="javascript://" class="on" onclick="guide_view('01');" id="guide_01">디지털/가전</a></li>
                            <li><a href="javascript://" onclick="guide_view('02');" id="guide_02">컴퓨터</a></li>
                            <li><a href="javascript://" onclick="guide_view('03');" id="guide_03">스포츠/자동차</a></li>
                            <li><a href="javascript://" onclick="guide_view('04');" id="guide_04">유아/라이프</a></li>
                        </ul>
                        <ul class="tip_list">
                            <div id="GuideBodyInner"></div>
                        </ul>
                    </div>
                    <!-- news_recent -->
            </div>
            <!--// 테마별 잘사는 팁 -->
            <div class="news_guide_contents" id="news_guide_contents"></div>
            <!-- trend_area -->
        </section>
        <!-- //trend_wrap -->
    </div>
        
    <%@ include file="/mobilefirst/include/footer.jsp"%> 
</div>  

</body>
</html>
<script language="javascript">

function getVer(){
    //alert(getCookie("verand"));
    //alert('<%=strVerand%>');
}  
//각 주제별 page number
var Page1 = 0;
var Page2 = 0;
var Page3 = 0;
var Page4 = 0;

//각 카테고리별 노출된 초기 뉴스 번호's
var kbno_1 = "";
var kbno_2 = "";
var kbno_3 = "";
var kbno_4 = "";

//현재 보고 잇는 카테고리
var vViewcate = "01";

//현재 보고 있는 구매가이드 카테고리
var vGuide = "01";

var vAppyn = getCookie("appYN");
var vAppyn2 = "<%=strAppyn2%>";

if(vAppyn2 == "Y"){ 
    vAppyn = "Y";
}

var vVerios = getCookie("verios");
//var vVerand = getCookie("verand");
var vVerand = "<%=strVerand%>";
var vType="<%=strType%>";

var json_list;

var json_trend;
var json_trend_00;
var json_trend_01;
var json_trend_02;
var json_trend_03;
var json_trend_04;

var json_guide;
var json_guide_top;

<%try{ %>
    json_list = <%@ include file="/mobilefirst/http/json/getNews_device.json"%>;
    
    json_trend = <%@ include file="/mobilefirst/http/json/getTrend_list.json"%>;
    json_trend_00 = <%@ include file="/mobilefirst/http/json/getTrend_list.json"%>;
    json_trend_01 = <%@ include file="/mobilefirst/http/json/getTrend_list_01.json"%>;
    json_trend_02 = <%@ include file="/mobilefirst/http/json/getTrend_list_02.json"%>;
    json_trend_03 = <%@ include file="/mobilefirst/http/json/getTrend_list_03.json"%>;
    json_trend_04 = <%@ include file="/mobilefirst/http/json/getTrend_list_04.json"%>;
    
    json_guide = <%@ include file="/mobilefirst/http/json/getShopping_guide.json"%>;    

    
<% }catch(Exception e){ %> 
    
    json_list = (function() {
        var json = null;
        $.ajax({
            'async': false,
            'global': false,
            'url': "/mobilefirst/ajax/main/getNews_list.jsp",
            'dataType': "json",
            'success': function (data) {
                json = data; 
            }
        });
        return json;
    })();

    json_trend = (function() {
        var json = null;
        $.ajax({ 
            'async': false,
            'global': false,
            'url': "/mobilefirst/ajax/main/ajax_to_json_trend_2016.jsp",
            'dataType': "json",
            'success': function (data) {
                json = data;
            }
        });
        return json;
    })();
    json_trend_00 = (function() {
        var json = null;
        $.ajax({ 
            'async': false,
            'global': false,
            'url': "/mobilefirst/ajax/main/ajax_to_json_trend_2016.jsp",
            'dataType': "json",
            'success': function (data) {
                json = data;
            }
        });
        return json;
    })();
    json_trend_01 = (function() {
        var json = null;
        $.ajax({ 
            'async': false,
            'global': false,
            'url': "/mobilefirst/ajax/main/ajax_to_json_trend_2016.jsp?ca_code=01",
            'dataType': "json",
            'success': function (data) {
                json = data;
            }
        });
        return json;
    })();
    json_trend_02 = (function() {
        var json = null;
        $.ajax({ 
            'async': false,
            'global': false,
            'url': "/mobilefirst/ajax/main/ajax_to_json_trend_2016.jsp?ca_code=02",
            'dataType': "json",
            'success': function (data) {
                json = data;
            }
        });
        return json;
    })();
    json_trend_03 = (function() {
        var json = null;
        $.ajax({ 
            'async': false,
            'global': false,
            'url': "/mobilefirst/ajax/main/ajax_to_json_trend_2016.jsp?ca_code=03",
            'dataType': "json",
            'success': function (data) {
                json = data;
            }
        });
        return json;
    })();
    json_trend_04 = (function() {
        var json = null;
        $.ajax({ 
            'async': false,
            'global': false,
            'url': "/mobilefirst/ajax/main/ajax_to_json_trend_2016.jsp?ca_code=04",
            'dataType': "json",
            'success': function (data) {
                json = data;
            }
        });
        return json;
    })();
    json_guide = (function() {
        var json = null;
        $.ajax({ 
            'async': false,
            'global': false,
            'url': "/mobilefirst/ajax/main/getShoppingGuide.jsp?kbcate=kb0,kb10",
            'dataType': "json",
            'success': function (data) {
                json = data;
            }
        });
        return json;
    })();

<% } %>  

var vHash = window.location.hash;

$(function() {

    $("body").on('touchend', function(e) {
        if (window.android && android.onTouchEnd) {
            window.android.onTouchEnd();
        } else if ($("#ios").val()) {

        }
    });
    
    vHash = window.location.hash;
    
    if(vAppyn != "Y"){
        $(".m_top").show();
    }else{
        $(".m_top").hide();
    } 

    //많이본 뉴스
    getNews_top();
    //하단 리스트
    getNews_list();
    //뉴스 더가지고 오기
    getNews_list_bottom();
    //트렌드픽업
    getTrendPickupList();
    //구매가이드
    getShoppingGuideListTop();
    getShoppingGuideList();

     if(vHash == "#guide" || vType == "guide"){
        $("#GuideBody").show();
        $("#NewsBody").hide();
        $("#PickupBody").hide();
        $("#bar_news2").removeClass("selected");
        $("#bar_pickup").removeClass("selected");
        $("#bar_guide").addClass("selected");
        $("#trendTab").removeClass("on");
        $("#trendNews").addClass("on");
        $(".tab_news").show();
        $("#footerBannerAD").hide();
        $("#footerBannerBasic").show();
    }else if(vHash != "#pickup" && vType != "pickup"){
        $("#NewsBody").show();
        $("#GuideBody").hide();
        $("#PickupBody").hide();
        $("#bar_news").addClass("selected");
        $("#bar_news2").addClass("selected");
        $("#bar_pickup").removeClass("selected");
        $("#trendTab").removeClass("on");
        $("#trendNews").addClass("on"); 
        $(".tab_news").show(); 
        $("#footerBannerAD").show();
        $("#footerBannerBasic").hide();
    }else{
        $("#NewsBody").hide();
        $("#PickupBody").show();
        $("#GuideBody").hide();
        $("#bar_news").removeClass("selected");
        $("#bar_pickup").addClass("selected");
        $("#trendTab").addClass("on");
        $("#trendNews").removeClass("on");
        $(".tab_news").hide(); 
        $(".trd_nav").show();
        $("#footerBannerAD").hide();
        $("#footerBannerBasic").show();
    }
     
    $("#bar_news").click(function(){
        ga('send', 'event', 'mf_trend', 'click_tab', 'today_news');
        try{
            window.android.trend_news();
        }catch(e){
            location.href = "#news";
            $("#bar_news").addClass("selected");
            $("#bar_pickup").removeClass("selected");
            $("#NewsBody").show();
            $("#PickupBody").hide();
            $(".trd_nav").hide();
        }
        ga('send', 'pageview', { 
            'page': '/mobilefirst/trend_news.jsp',
            'title': 'mf_홈_오늘의뉴스' 
        }); 
    });
    
    var cate_trd;
    
    $(".trd_prev").click(function(){
        if(vTrendCate == 0){
            cate_trd = 4;
        }else{
            cate_trd = vTrendCate-1;
        }
        trend_tab(cate_trd);
    });
    $(".trd_next").click(function(){
        if(vTrendCate == 4){
            cate_trd = 0;
        }else{
            cate_trd = vTrendCate+1;
        } 
        trend_tab(cate_trd);
    }); 
    $("#bar_pickup").click(function(){
        ga('send', 'event', 'mf_trend', 'click_tab', 'today_pickup');
        try{
            window.android.trend_pickup();
        }catch(e){
            location.href = "#pickup";
            $("#bar_news").removeClass("selected");
            $("#bar_pickup").addClass("selected");
            $("#NewsBody").hide(); 
            $("#PickupBody").show();
            $(".trd_nav").show();
        }
        ga('send', 'pageview', { 
            'page': '/mobilefirst/trend_news.jsp#pickup',
            'title': 'mf_홈_트렌드 픽업'  
        });  
    });
    $("#bar_news2").click(function(){
        ga('send', 'event', 'mf_trend', 'click_tab', 'today_news');
        //try{
        //  window.android.trend_news();
        //}catch(e){
            //location.href = "/mobilefirst/trend_news.jsp#news";
            if(getCookie("verios")){
            //  location.href = "/mobilefirst/trend_news.jsp?type=news";
            } 
            $("#bar_news2").addClass("selected");
            $("#bar_guide").removeClass("selected");
            $("#bar_pickup").removeClass("selected");
            $("#NewsBody").show();
            $("#PickupBody").hide();
            $("#GuideBody").hide();
            $("#footerBannerAD").show();
            $("#footerBannerBasic").hide();
        //}
            ga('send', 'event', 'mf_tip', 'click_tab', 'today_news');
        //ga('send', 'pageview', { 
        //  'page': '/mobilefirst/trend_news.jsp',
        //  'title': 'mf_홈_오늘의뉴스' 
        //}); 
    }); 
    $("#bar_guide").click(function(){
        //try{
        //  window.android.trend_news();
        //}catch(e){ 
            //location.href = "#guide"; 
            if(getCookie("verios")){
            //  location.href = "/mobilefirst/trend_news.jsp?type=guide";   
            }
            $("#bar_news").removeClass("selected");
            $("#bar_news2").removeClass("selected");
            $("#bar_guide").addClass("selected");
            $("#bar_pickup").removeClass("selected");
            $("#GuideBody").show();
            $("#NewsBody").hide();
            $("#PickupBody").hide(); 
            $("#footerBannerAD").hide();
            $("#footerBannerBasic").show();
        //}
            ga('send', 'event', 'mf_tip', 'click_tab', 'guide');
    });     
    
    
    /**
     * 메뉴 버튼 
     */
    $(".newgnb > li > a").on('click', function(){
        var $this = $(this),
            url = $(this).attr('href');
        
        if($this.is('.newWindow')){
            window.open(url); 
        }else{
            $(".newgnb > li > a.on").removeClass('on');
            location.href = url;
        }
          
        // log    
        return false;
    });    

    if(vAppyn == "Y"){
        if(vVerios.substring(0,2) == "3." || vVerand.substring(0,2) == "3." ){
            $(".tab_trend").hide();
            //$(".tab_news").show();
        }else{ 
            $(".tab_trend").show();
            $(".tab_news").hide();
        }
    }
    if(vType == "pickup"){
        $("#NewsBody").hide();
        $("#PickupBody").show();
        $(".trd_nav").show();
        $("#bar_news").removeClass("selected");
        $("#bar_pickup").addClass("selected");
        $("#trendTab").addClass("on");
        $("#trendNews").removeClass("on");      
    }
    
    $(".hit_product").on('touchstart', function(e){
        if(window.android && android.onTouchStart){
            window.android.onTouchStart();
        }else if( $("#ios").val()){
            
        }
    }); 
    
    $("body").on('touchend', function(e){
        if(window.android && android.onTouchEnd){
            window.android.onTouchEnd();
        }else if( $("#ios").val()){
            
        }
    });    
    
});

function getNews_top(){
    $("#news_top_list").html(null);

    var json = json_list.top;
    if(json.NewsPopular){
        var template = "<ul>";
                
        for(var i=0;i<json.NewsPopular.length;i++){
            template += "<li><a href=\"javascript:///\" onclick=\"kb_view2("+ json.NewsPopular[i].kb_no +")\" ><em>"+ ( i + 1 ) +"</em>"+ json.NewsPopular[i].kb_title +"<span class=\"hits\"><em>조회수</em>"+  commaNum(json.NewsPopular[i].kb_readcnt) +"</span></a></li>";
        }
        template += "</ul>";
        $("#news_top_list").html(template);
        
        if(json.NewsPopular.length == 0){
            $("#NewsBody .first").hide();
        }
    }
} 
 
function getNews_list(){
    $("#recentnews_contents").html(null);
    
    var json = json_list.list;

    if(json.NewsList){

        var template = "";
        for(var i=0;i<json.NewsList.length;i++){
            /*
            var vData = (json.NewsList[i].kb_regdate).substring(0,10);
            var vData_today = "";
            
            var d = new Date();

            var month = d.getMonth()+1;
            var day = d.getDate();

            var output_today = d.getFullYear() + '-' +
                (month<10 ? '0' : '') + month + '-' +
                (day<10 ? '0' : '') + day;
            
            if(vData == output_today){
                vData_today = "today";
            }
            */
            
            if( (i+1) % 8 == 1 ){   
                template += "<li class=\"news_list_cate_part\" id=\"cate_"+ json.NewsList[i].mm_llcate +"\">";
                template += "<div class=\"top_news_box\">";
                template += "   <ul>";
                template += "       <li>";
                template += "           <a href=\"javascript:///\" onclick=\"kb_view("+ json.NewsList[i].kb_no +")\" >";
                template += "               <span class=\"thumb\"><img src=\"http://storage.enuri.gscdn.com/pic_upload/main/news/"+ json.NewsList[i].mn_img +"\" alt=\"\" /></span>";
                template += "               <span class=\"tit\">"+ json.NewsList[i].kb_title +"</span>";
                template += "           </a>";
                template += "       </li>";
            }else if( (i+1) % 8 == 2 ){
                template += "       <li>";
                template += "           <a href=\"javascript:///\" onclick=\"kb_view("+ json.NewsList[i].kb_no +")\" >";
                template += "               <span class=\"thumb\"><img src=\"http://storage.enuri.gscdn.com/pic_upload/main/news/"+ json.NewsList[i].mn_img +"\" alt=\"\" /></span>";
                template += "               <span class=\"tit\">"+ json.NewsList[i].kb_title +"</span>";
                template += "           </a>";
                template += "       </li>";
                template += "   </ul>";
                template += "</div>";
            }else if( (i+1) % 8 == 3 ){
                template += "<ul class=\"news_list\">";
                //template += " <li><a href=\"javascript:///\" onclick=\"kb_view("+ json.NewsList[i].kb_no +")\" >"+ json.NewsList[i].kb_title +"</a></li>";
                template += "   <li class=\"news_pic\">";
                template += "       <a href=\"javascript:///\" onclick=\"kb_view("+ json.NewsList[i].kb_no +")\" ><strong>"+ json.NewsList[i].kb_title + "</strong>";
                
                template += "       <span class=\"thumb\"><img src=\"http://storage.enuri.gscdn.com/pic_upload/main/news/"+ json.NewsList[i].mn_img +"\" onerror=\"fn_err_img(this);\" /></span>";
                template += "       <span class=\"date\"><em>"+ (json.NewsList[i].kb_regdate).substring(0,10) +"</em>";
                if(json.NewsList[i].kb_readcnt >= 200){
                    template += "       <em>조회수 : "+ commaNum(json.NewsList[i].kb_readcnt) +"</em>";
                }   
                template += "       </span>";
                template += "       <span class=\"txt\">"+json.NewsList[i].kb_content+"</span>";
                template += "   </a></li>";
            }else if( (i+1) % 8 == 0 ){ 
                //template += " <li><a href=\"javascript:///\" onclick=\"kb_view("+ json.NewsList[i].kb_no +")\" >"+ json.NewsList[i].kb_title +"</a></li>";
                template += "   <li class=\"news_pic\">";
                template += "       <a href=\"javascript:///\" onclick=\"kb_view("+ json.NewsList[i].kb_no +")\" ><strong>"+ json.NewsList[i].kb_title + "</strong>";
                
                template += "       <span class=\"thumb\"><img src=\"http://storage.enuri.gscdn.com/pic_upload/main/news/"+ json.NewsList[i].mn_img +"\" onerror=\"fn_err_img(this);\" /></span>";
                template += "       <span class=\"date\"><em>"+ (json.NewsList[i].kb_regdate).substring(0,10) +"</em>";
                if(json.NewsList[i].kb_readcnt >= 200){
                    template += "       <em>조회수 : "+ commaNum(json.NewsList[i].kb_readcnt) +"</em>";
                }   
                template += "       </span>";
                template += "       <span class=\"txt\">"+json.NewsList[i].kb_content+"</span>";
                template += "   </a></li>";
                template += "</ul>";
                template += "<ul class=\"news_list last\" id=\"news_list_bottom_"+ json.NewsList[i].mm_llcate +"\"></ul>";
                template += "</li>";
                
            }else{
                //template += " <li><a href=\"javascript:///\" onclick=\"kb_view("+ json.NewsList[i].kb_no +")\" >"+ json.NewsList[i].kb_title +"</a></li>";
                template += "   <li class=\"news_pic\">";
                template += "       <a href=\"javascript:///\" onclick=\"kb_view("+ json.NewsList[i].kb_no +")\" ><strong>"+ json.NewsList[i].kb_title + "</strong>";
                
                template += "       <span class=\"thumb\"><img src=\"http://storage.enuri.gscdn.com/pic_upload/main/news/"+ json.NewsList[i].mn_img +"\" onerror=\"fn_err_img(this);\" /></span>";
                template += "       <span class=\"date\"><em>"+ (json.NewsList[i].kb_regdate).substring(0,10) +"</em>";
                if(json.NewsList[i].kb_readcnt >= 200){
                    template += "       <em>조회수 : "+ commaNum(json.NewsList[i].kb_readcnt) +"</em>";
                }   
                template += "       </span>";
                template += "       <span class=\"txt\">"+json.NewsList[i].kb_content+"</span>";
                template += "   </a></li>";
            }

            if(json.NewsList[i].mm_llcate == "01"){
                if(kbno_1 != ""){
                    kbno_1 += ",";
                }
                kbno_1 += json.NewsList[i].kb_no;
            }else if(json.NewsList[i].mm_llcate == "02"){
                if(kbno_2 != ""){
                    kbno_2 += ",";
                }
                kbno_2 += json.NewsList[i].kb_no;
            }else if(json.NewsList[i].mm_llcate == "03"){
                if(kbno_3 != ""){
                    kbno_3 += ",";
                }
                kbno_3 += json.NewsList[i].kb_no;
            }else if(json.NewsList[i].mm_llcate == "04"){
                if(kbno_4 != ""){
                    kbno_4 += ",";
                }
                kbno_4 += json.NewsList[i].kb_no;
            }
        }

        $("#recentnews_contents").html(template);
        
        $(".news_list_cate_part").hide();
        $("#cate_01").show();
    }
}

function news_view(cate,obj){
    vViewcate = cate;
     
    $(".recentnews_tab_line").removeClass("on");
    $(obj).addClass("on");
    
    $(".news_list_cate_part").hide();
    $("#cate_"+cate).show();
    
    getNews_list_bottom();
}


function guide_view(cate){
    vGuide = cate;
    
    $("#GuideBody .recentnews_tab li a").removeClass("on");
    $("#guide_"+cate).addClass("on");

    getShoppingGuideList();
    
}

function getNews_list_bottom(){
    var vChk_addlist = false;
    var vNotin = "";
    var json;
    
    if(vViewcate == "01" && Page1 == 0){
        vChk_addlist = true;
        vNotin = kbno_1;
        json = json_list.cate_01.NewsCate_01;
    }else if(vViewcate == "02" && Page2 == 0){
        vChk_addlist = true;
        vNotin = kbno_2;
        json = json_list.cate_02.NewsCate_02;
    }else if(vViewcate == "03" && Page3 == 0){
        vChk_addlist = true;
        vNotin = kbno_3;
        json = json_list.cate_03.NewsCate_03;
    }else if(vViewcate == "04" && Page4 == 0){
        vChk_addlist = true;
        vNotin = kbno_4;
        json = json_list.cate_04.NewsCate_04;
    }

    if(vChk_addlist){
        var template = "";
        
        if(json){
            for(var i=0;i<json.length;i++){

                //if(json.NewsCate[i].g_modelno != "0" && vNotin.indexOf(json.NewsCate[i].g_modelno) > -1){
                    /*var vData = (json.NewsCate[i].kb_regdate).substring(0,10);
                    var vData_today = "";
                    
                    var d = new Date();

                    var month = d.getMonth()+1;
                    var day = d.getDate();

                    var output_today = d.getFullYear() + '-' +
                        (month<10 ? '0' : '') + month + '-' +
                        (day<10 ? '0' : '') + day;
                    
                    if(vData == output_today){
                        vData_today = "today";
                    }*/
                    //var vImageUrl = "http://storage.enuri.gscdn.com/pic_upload/main/news/news_"+ json[i].kb_no +".png";
                    template += "   <li class=\"news_pic\">";
                    template += "       <a href=\"javascript:///\" onclick=\"kb_view("+ json[i].kb_no +")\" ><strong>"+ json[i].kb_title + "</strong>";
                    
                    template += "       <span class=\"thumb\"><img src=\"http://storage.enuri.gscdn.com/pic_upload/main/news/news_"+ json[i].kb_no +".png\" onerror=\"fn_err_img(this);\" /></span>";
                    template += "       <span class=\"date\"><em>"+ (json[i].kb_regdate).substring(0,10) +"</em>";
                    if(json[i].kb_readcnt >= 200){
                        template += "       <em>조회수 : "+ commaNum(json[i].kb_readcnt) +"</em>";
                    }   
                    template += "       </span>";
                    template += "       <span class=\"txt\">"+json[i].kb_content+"</span>";
                    template += "   </a></li>";
                //}
            }
        }

        $("#news_list_bottom_"+vViewcate).html(template);
        
        if(vViewcate == "01"){
            Page1 = 1;
        }else if(vViewcate == "02"){
            Page2 = 1;
        }else if(vViewcate == "03"){
            Page3 = 1;
        }else if(vViewcate == "04"){
            Page4 = 1;
        }
    } 
}

function getShoppingGuideListTop(){
    
    if(json_guide.top.ShoppingGuideList){
        var template_guide = "";
        var vCnt = 0;
        
        for(var i=0;i<json_guide.top.ShoppingGuideList.length;i++){ 
            if(json_guide.top.ShoppingGuideList[i].mo_img){
                template_guide += " <div onclick=\"view_guide('"+ json_guide.top.ShoppingGuideList[i].kb_no+"', '1');\"><img src=\"http://storage.enuri.gscdn.com/pic_upload/enurinews_mobile/"+json_guide.top.ShoppingGuideList[i].mo_img+"\"  alt=\"\" style=\"width:100%;\"></div>";
                vCnt = vCnt + 1;
            }
            if(vCnt == 4){ 
                break;
            }
        } 
    }   
    $(".bannerCarousel").html(template_guide);
    $(".prod_page span").html(vCnt);
     
    if(vCnt > 1){
        CmdTimer(); 
    } 
} 
function CmdTimer(){
    setTimeout(function () {
        $('.bannerCarousel').slick({
            arrows : true,
            infinite : true,
            swipeToSlide : true,
            autoplay : true,
            dots: true
        }).on('touchstart', function(e) {
            if (window.android && android.onTouchStart) {
                window.android.onTouchStart();
            } else if ($("#ios").val()) {

            }

        });
    }, 500);
    //var currentSlide = $('.bannerCarousel').slick('slickCurrentSlide');
    //alert(currentSlide);
    $('.bannerCarousel').on('afterChange', function(event, slick, currentSlide, nextSlide){
          $(".prod_page em").html(currentSlide+1);
    });
}
function getShoppingGuideList(){
    var json;
    if(vGuide=="01"){
        json = json_guide.cate_01;
    }else if(vGuide=="02"){
        json = json_guide.cate_02;
    }else if(vGuide=="03"){
        json = json_guide.cate_03;
    }else if(vGuide=="04"){
        json = json_guide.cate_04;
    }   
    var num = 0;
    var json_guide_arr = new Array();
    var template_guide = "";
    var news_template_guide = "<ul class=\"news_list\">";
    if(json.ShoppingGuideList){
        //상단 이미지 리스트
        for(var i=0;i<json.ShoppingGuideList.length;i++){ 
            if(json.ShoppingGuideList[i].img_yn == '1' 
                        && json.ShoppingGuideList[i].date50 == '1' ){
                json_guide_arr[num] = i;
                template_guide += "             <li>        ";
                template_guide += "                 <a href=\"javascript://\" onclick=\"view_guide('"+ json.ShoppingGuideList[i].kb_no+"', '2');\"> ";

                template_guide += "                     <img !class=\"guide_thumb\" src=\"http://storage.enuri.gscdn.com/pic_upload/enurinews_mobile/"+json.ShoppingGuideList[i].mo_img2+"\"  !src=\"http://storage.enuri.gscdn.com/pic_upload/enurinews_mobile/"+json.ShoppingGuideList[i].mo_img2+"\"  alt=\"\" />    ";

                template_guide += "                     <strong>"+ json.ShoppingGuideList[i].kb_title+"</strong>    ";
                template_guide += "                 </a>    ";
                template_guide += "             </li>   ";
                num = num + 1;
            }
        }
        
        //하단 리스트
        for(var i=0;i<json.ShoppingGuideList.length;i++){ 
            //상단 리스트로 사용되었는지 체크
            var arrChk = true;
            for(var j=0;j<json_guide_arr.length;j++){
                if(i == json_guide_arr[j]){
                    arrChk = false;
                }
            }
            if(arrChk){
                if(json.ShoppingGuideList[i].img_yn == '1'){
                    news_template_guide += "<li class=\"news_pic\">";
                }else{
                    news_template_guide += "<li>";
                }
                news_template_guide += "        <a href=\"javascript:///\" onclick=\"view_guide("+ json.ShoppingGuideList[i].kb_no +", '2')\" ><strong>"+ json.ShoppingGuideList[i].kb_title + "</strong>";
                
                //이미지 있는경우 노출
                if(json.ShoppingGuideList[i].img_yn == '1'){
                    news_template_guide += "    <span class=\"thumb\"><img src=\"http://storage.enuri.gscdn.com/pic_upload/enurinews_mobile/"+ json.ShoppingGuideList[i].mo_img +"\" onerror=\"fn_err_img(this);\" /></span>";
                }
                
                news_template_guide += "        <span class=\"date\"><em>"+ (json.ShoppingGuideList[i].kb_regdate).substring(0,10) +"</em>";
                if(json.ShoppingGuideList[i].kb_readcnt >= 200){
                    news_template_guide += "        <em>조회수 : "+ commaNum(json.ShoppingGuideList[i].kb_readcnt) +"</em>";
                }   
                news_template_guide += "        </span>";
                news_template_guide += "        <span class=\"txt\">"+json.ShoppingGuideList[i].kb_content+"</span>";
                news_template_guide += "    </a></li>";
            }           
        }
    }   
    news_template_guide += "</ul>";
    $("#GuideBodyInner").html(template_guide);
    $("#news_guide_contents").html(news_template_guide);
    
    $(".guide_thumb").lazyload({ 
        onError: function(element) {
           console.log("error loading image: " + $(this));
        }
    });
    
} 

function view_guide(kbno, param){ 
    window.open("news_detail.jsp?kbno="+kbno+"&from=guide&verios="+vVerios);
    var catenm = "";
    
    if($("#guide_01").hasClass("on")){
        catenm = "디지털/가전";
    }else if($("#guide_02").hasClass("on")){
        catenm = "컴퓨터";
    }else if($("#guide_03").hasClass("on")){
        catenm = "스포츠/자동차";
    }else if($("#guide_04").hasClass("on")){
        catenm = "유아/라이프";
    }
     
    if(param == "1"){
        ga('send', 'event', 'mf_guide', 'guide_newtip', 'guide_newtip_'+kbno);
    }else if(param == "2"){
        ga('send', 'event', 'mf_guide', 'guide_category', 'guide_newtip_'+catenm+'_'+kbno);
    }   
    return;   
} 
function ImgFolder(modelno){
    var output="1"; 
    var input = modelno+"";
  
        if( modelno < 1000){
            output = "1";
        }else{ 
            output = input.substring(0,input.length-3) + "000";
        }
   return output; 
}

function fn_err_img(img){
    var _this = img;
    _this.style.display='none';
    $(img).parents("li").removeClass("news_pic");
} 


function kb_view(kbno){
    var cName = $("#news_"+vViewcate).text();
    //ga('send', 'event', 'mf_trend', 'today_news', 'topic_news_'+cName);
    ga('send', 'event', 'mf_today_new', 'topic_new_'+vViewcate, 'topic_new_'+kbno);
    
    window.open("news_detail.jsp?kbno="+kbno+"&verios="+vVerios);
     return;   
}
function kb_view2(kbno){
    //ga('send', 'event', 'mf_trend', 'today_news', 'best_news');
    ga('send', 'event', 'mf_today_new', 'best_new', 'best_news_'+kbno);
    
    window.open("news_detail.jsp?kbno="+kbno+"&verios="+vVerios);
     return; 
}
function list_view(modelno,  cate){
    //ga('send', 'event', 'mf_trend', 'trend_pickup', modelno+'_more');
    ga('send', 'event', 'mf_trend_pickup', 'trend_'+modelno, 'more');
     
    location.href = "/mobilefirst/list.jsp?cate="+cate;
    return;
} 
function keyword_view(no, modelno,  url){
    var thisNM = $("#keyword_"+modelno + "_"+no).text(); 
    ga('send', 'event', 'mf_trend', 'trend_pickup', modelno+'_키워드_'+thisNM);
     
    location.href = url;  
    return;
}
function detail_view(modelno1, modelno2, param, mobile_url){
    if(!e) var e = window.event;
    e.cancelBubble = true;
    e.returnValue = false;
    if (e.stopPropagation) {
        e.stopPropagation();
        e.preventDefault();
    }
    
    var thisNM = $("#info_"+modelno2 + " .tit").text(); 
    //ga('send', 'event', 'mf_trend', 'trend_pickup', modelno+'_'+thisNM);
    if(param=="1"){
        ga('send', 'event', 'mf_trend_pickup', 'trend_pickup_'+modelno1, thisNM);
    }else if(param=="2"){
        var thisNM2 = $("#info2_"+modelno2).text();
        ga('send', 'event', 'mf_trend_pickup', 'trend_pickup_'+modelno1, '관련상품_'+thisNM2);
    } 
    
    if(mobile_url.length > 0 && mobile_url != "undefined"){
        window.open(mobile_url);
    }else{
        location.href = "/mobilefirst/detail.jsp?modelno="+modelno2;
    }
    return;  
} 
var vTrendCate = 0;

function trend_tab(cate){
    $(".trend_tab").removeClass("on");
    $("#t_"+cate).addClass("on");
 
    if(vTrendCate == cate){
        
    }else{
        if(cate == 1){
            vTrendCate = 1; 
            json_trend = json_trend_01; 
        }else if(cate ==2){
            vTrendCate = 2; 
            json_trend = json_trend_02;
        }else if(cate ==3){
            vTrendCate = 3; 
            json_trend = json_trend_03;
        }else if(cate ==4){
            vTrendCate = 4; 
            json_trend = json_trend_04;     
        }else{
            vTrendCate = 0; 
            json_trend = json_trend_00;
        } 
        if(cate > 1){
            if(cate == 4){
                $(".trd_scroll").scrollLeft(500);
            }else{
                $(".trd_scroll").scrollLeft(vTrendCate*(vTrendCate*10));
            }
        }else{
            $(".trd_scroll").scrollLeft(0);         
        }
        getTrendPickupList();
    }
} 

function getTrendPickupList(){
    //처음 한번만 호출. 
    var t_no = 0;
    
    json = json_trend; 
    
    //$.ajax({ 
        //type: "GET",
        //url: "/mobilefirst/ajax/main/ajax_to_json_trend_2016.jsp?ca_code=01",
        //dataType: "JSON",
        //async: false,
        //success: function(json){
            $("#PickupBody").html(null); 
            if(json.trend){
                var template = "";
                
                for(var i=0;i<json.trend.length;i++){ 
                    if(json.trend[i].ref_model_no != undefined && json.trend[i].sublist){
                        t_no = t_no + 1;
                        if(t_no == 1){  
                            template += "<div class=\"trend_area first trdrwd\" id=\"trend_"+ json.trend[i].subject_idx +"\"> ";
                        }else{
                            template += "<div class=\"trend_area trdrwd\" id=\"trend_"+ json.trend[i].subject_idx +"\"> ";
                        }
                        template += "<ul class=\"trendBox\"> ";
                        template += "   <li><a href=\"javascript:///\" onclick=\"detail_view("+ json.trend[i].ref_model_no +","+ json.trend[i].ref_model_no +", '1','"+ json.trend[i].mobile_url +"')\" > ";
                        if(json.trend[i].reg_date.length > 0){
                        template += "   <span class=\"new\">NEW</span> "; 
                        }  
                        template += "   <strong class=\"b_tit\">"+ json.trend[i].subject +"<span>"+json.trend[i].subject_sub+"</span></strong> ";
                        if(i < 4){
                            template += "   <img class=\"trend_thumb\" data-original=\""+json.trend[i].ref_model_img+"\"  src=\""+json.trend[i].ref_model_img+"\"  alt=\"\" style=\"width:100%;\"> ";
                        }else{
                            template += "   <img class=\"trend_thumb\" data-original=\""+json.trend[i].ref_model_img+"\"  src=\"http://img.enuri.info/images/mobilefirst/noimg_plan.png\" alt=\"\" style=\"width:100%;\"> ";
                        }
                        template += "   <div class=\"priceinfo\" id=\"info_"+json.trend[i].ref_model_no+"\"> ";
                        template += "       <span class=\"tit\">"+json.trend[i].ref_modelnm+"</span> ";
                        template += "       <span class=\"price\"><strong>"+json.trend[i].minprice3+"<em>원</em></strong> ~ "+json.trend[i].maxprice+"<em>원</em></span> ";
                        template += "       <button class=\"pricego\" onclick=\"detail_view("+ json.trend[i].ref_model_no +","+ json.trend[i].ref_model_no +", '1','')\" >가격비교 ("+json.trend[i].mallcnt3+")</button> ";
                        template += "   </div> ";
                        template += "   </li></a> ";  
                        template += "</ul> "; 
                        if(json.trend[i].sublist){   
                        template += "<ul class=\"relation\">     "; 
                            for(var k=0;k<json.trend[i].sublist.length;k++){
                                template += "   <li onclick=\"detail_view("+ json.trend[i].ref_model_no +","+ json.trend[i].sublist[k].ref_model_no +",'2','"+ json.trend[i].sublist[k].mobile_url +"')\" > ";
                                template += "       <img class=\"trend_thumb\" data-original=\""+json.trend[i].sublist[k].img_src+"\"  src=\"http://img.enuri.info/images/mobilefirst/noimg_plan.png\" alt=\"\" /> ";
                                template += "       <strong  id=\"info2_"+json.trend[i].sublist[k].ref_model_no+"\">"+json.trend[i].sublist[k].ref_modelnm+"</strong> ";
                                template += "       <span>"+json.trend[i].sublist[k].minprice3+"<em>원</em></span> ";
                                template += "   </li> ";
                            } 
                        template += "</ul> ";
                        } 
                        //template += "<dl class=\"keyword\"> ";
                        //template += " <dt>쇼핑키워드</dt> ";
                        
                        //for(var j=0;j<json.trend[i].keywordlist.length;j++){ 
                        //  template += "   <dd id=\"keyword_"+json.trend[i].ref_model_no+"_"+j+"\"><a href=\"javascript:///\"  onclick=\"keyword_view('"+j+"','"+json.trend[i].ref_model_no+"', '"+ json.trend[i].keywordlist[j].url +"')\" >"+json.trend[i].keywordlist[j].keywords+"</a></dd> ";
                        //}  
                        //template += "</dl> ";
                        template += "<a href=\"javascript:///\" class=\"morebtn\" onclick=\"list_view('"+json.trend[i].ref_model_no+"', '"+ json.trend[i].ca_code +"')\" > <span>"+json.trend[i].c_name+" 더보기</span></a> ";
                        template += "</div> ";
                    } 
                }
 
                $("#PickupBody").html(template);
                 
            }
            $(".trend_thumb").lazyload({
                onError: function(element) {
                   console.log("error loading image: " + $(this));
                }
            });
        //},
        //error : function(result) { 

        //}
    //});
}

//가로스크롤바 숨기기

function loaded(){

          //var iscroll = new iScroll("trd_scroll", {

//                     vScroll:false,

  //                   hScrollbar:false

     //     });

}

$(window).scroll(function() {
  // if($(window).scrollTop() + $(window).height() == $(document).height()) {
       getNews_list_bottom();
   //}
});
  
window.addEventListener("load", function(){
    //setTimeout(scrollTo, 0, 0, 1);
}, false);

document.addEventListener('DOMContentLoaded', loaded, false);

if(vType == "pickup"){
    ga('send', 'pageview', { 
        'page': '/mobilefirst/trend_news.jsp#pickup',
        'title': 'mf_홈_트렌드 픽업'  
    });      
}else{
    ga('send', 'pageview', { 
        'page': '/mobilefirst/trend_news.jsp',
        'title': 'mf_홈_오늘의뉴스' 
    }); 
}
/*[싱크미디어- 모비팜] 광고 제거 20160525
if(vType == "pickup" || vHash == "#pickup"){
}else{
     if(vAppyn != "Y"){
        document.write("<scr"+"ipt src='http://sp1.jssearch.net/script/script_168.js' charset='utf-8'></sc"+"ript>");
    }
}*/
</script>
<%@ include file="/mobilefirst/include/common_logger.html"%>