<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<% 
    String strVersion   = ChkNull.chkStr(request.getParameter("version"),"");   
    String strApp   = ChkNull.chkStr(request.getParameter("app"),""); 
    String strID = ChkNull.chkStr(request.getParameter("t"),"B_20150604110000");    
    String strType = "";
    String strToday_id = "";
    String tab   = ChkNull.chkStr(request.getParameter("tab"),"");  
    
    if(strID.indexOf("_") > -1){
        String[] arrstrTody = null;
        if (strID.trim().length() > 0 ){ 
            arrstrTody = strID.split("_");
            strType          = arrstrTody[0]; 
            strToday_id = arrstrTody[1]; 
        }   
    }
    
    String strAppYN = "";       
    
    try{
        Cookie[] cookies = request.getCookies();                        // 요청에서 쿠키를 가져온다.

        if(cookies!=null){                                                      // 쿠키가 Null이 아닐때,
            for(int i=0; i<cookies.length; i++){                            // 쿠키를 반복문으로 돌린다.
                if(cookies[i].getName().equals("appYN")){            // 쿠키의 이름이 id 일때
                    strAppYN=cookies[i].getValue();                     // 해당 쿠키의 값을 id 변수에 저장한다.
                }
            } 
        } 
    }catch(Exception e){}

    
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/default.css" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/plan.css"/>
	<%@include file="/mobilefirst/renew/include/common.html"%>
	<%@include file="/mobilefirst/login/login_check.jsp"%>
	<script type="text/javascript" src="/mobilefirst/js/lib/LazyLoad.1.9.3.min.js"></script>
	<script>  
	//이미지 로더 
	(function(e,t,n,r){e.fn.lazy=function(r){function u(n){if(typeof n!="boolean")n=false;s.each(function(){var r=e(this);var s=this.tagName.toLowerCase();if(f(r)||n){if(r.attr(i.attribute)&&(s=="img"&&r.attr(i.attribute)!=r.attr("src")||s!="img"&&r.attr(i.attribute)!=r.css("background-image"))&&!r.data("loaded")&&(r.is(":visible")||!i.visibleOnly)){var u=e(new Image);++o;if(i.onError)u.error(function(){d(i.onError,r);p()});else u.error(function(){p()});var a=true;u.one("load",function(){var e=function(){if(a){t.setTimeout(e,100);return}r.hide();if(s=="img")r.attr("src",u.attr("src"));else r.css("background-image","url("+u.attr("src")+")");r[i.effect](i.effectTime);if(i.removeAttribute)r.removeAttr(i.attribute);d(i.afterLoad,r);u.unbind("load");u.remove();p()};e()});d(i.beforeLoad,r);u.attr("src",r.attr(i.attribute));d(i.onLoad,r);a=false;if(u.complete)u.load();r.data("loaded",true)}}});s=e(s).filter(function(){return!e(this).data("loaded")})}function a(){if(i.delay>=0)setTimeout(function(){u(true)},i.delay);if(i.delay<0||i.combined){u(false);e(i.appendScroll).bind("scroll",h(i.throttle,u));e(i.appendScroll).bind("resize",h(i.throttle,u))}}function f(e){var t=l(),n=c(),r=e.offset().top,s=e.height();return t+n+i.threshold>r&&r+s>t-i.threshold}function l(){if(n.documentElement.scrollTop)return n.documentElement.scrollTop;return n.body.scrollTop}function c(){if(t.innerHeight)return t.innerHeight;if(n.documentElement&&n.documentElement.clientHeight)return n.documentElement.clientHeight;if(n.body&&n.body.clientHeight)return n.body.clientHeight;if(n.body&&n.body.offsetHeight)return n.body.offsetHeight;return i.fallbackHeight}function h(e,t){function s(){function o(){r=+(new Date);t.apply()}var s=+(new Date)-r;n&&clearTimeout(n);if(s>e||!i.enableThrottle)o();else n=setTimeout(o,e-s)}var n;var r=0;return s}function p(){--o;if(!s.size()&&!o)d(i.onFinishedAll,null)}function d(e,t){if(e){if(t!==null)e(t);else e()}}var i={bind:"load",threshold:500,fallbackHeight:2e3,visibleOnly:true,appendScroll:t,delay:-1,combined:false,attribute:"data-src",removeAttribute:true,effect:"show",effectTime:0,enableThrottle:false,throttle:250,beforeLoad:null,onLoad:null,afterLoad:null,onError:null,onFinishedAll:null};if(r)e.extend(i,r);var s=this;var o=0;if(i.bind=="load")e(t).load(a);else if(i.bind=="event")a();if(i.onError)s.bind("error",function(){d(i.onError,e(this))});return this};e.fn.Lazy=e.fn.lazy})(jQuery,window,document);
	</script>
</head>
<body>

<div id="wrap">

    <div id="main">
    <!-- 헤더영역 -->
    <!-- 홈메인 GNB -->
    <%@include file="/mobilefirst/renew/include/gnb.html"%>
        <!-- 서브 -->
        <nav class="m_top_sub">
            <h2 class="plan_tit"><a href="#" class="back">뒤로가기</a>에누리 특별 기획전
                <!-- 160829 sns 공유 -->
                <a href="javascript:///" class="sns_share ico_m" onclick="$('#snsPop').show();">공유하기</a>
            </h2>
             
            
            <div class="layerPop_sns" id="snsPop" >
                <div class="layerPopInner">
                    <div class="layerPopCont">
                        <h1 id="layerPopCont_txt">SNS 공유</h1>
                        <button class="btnClose" onclick="$('#snsPop').hide();">SNS 공유 창 닫기</button>
                        <div class="contents">
                            <div class="linkList">
                                <ul>
                                    <li><a href="javascript:///" class="kakao" id="kakao-link-btn">카카오톡</a></li>
                                    <li><a href="javascript:///" class="facebook">페이스북</a></li>
                                    <li><a href="javascript:///" class="url" onclick="$('#layer_geturl').show();">URL</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="layerPop_sns" id="layer_geturl">
                <div class="layerPopInner">
                    <div class="layerPopCont">
                        <h1>URL 복사</h1>
                        <button class="btnClose" type="button" onclick="$('#layer_geturl').hide();">창 닫기</button>
                        <div class="contents">
                            <p class="url_txt">
                                <span id="url_text">아래의 URL을 두번 누르면 복사할 수 있습니다.</span>
                                <span class="input_copy"><input type="text" class="urlCopy" id="txt_getUrl" value=""></span>
                            </p>
                        </div>
                        <div class="layerBtn"><button class="btnTxt" type="button" id="btt_close" onclick="$('#layer_geturl').hide();">닫기</button></div>
                    </div>
                </div>
                <div class="dim"></div>
            </div>
            <!--// 160822 sns 공유 -->

        </nav>
        <!--// 서브 -->

    <!-- 20150618 기획전 공통 레이아웃  시작 -->
    <section id="container">

        <div class="top_visual">
            <span class="more" onclick="$('#layer_planlist').show();">+ 연관기획전(00)</span>
            <img src="http://img.enuri.gscdn.com/images/mobileevent/swim/visual.png" alt="[HOT한 상품들로 COOL하게 떠나자!] 올 여름을 책임질 물놀이용품!!" />
        </div>
        
        <!-- 160829 -->
        <script>
         $(document).ready(function() {
            
            if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
    
		    }else if(navigator.userAgent.indexOf("Android") > -1){
		       
		        var nav = $('.plan_tit');
	            $(window).scroll(function () {
	                if ($(this).scrollTop() > 80) {
	                    nav.addClass("f-nav");
	                } else {
	                    nav.removeClass("f-nav");
	                }
	            });
		       
		    }

        });

         $(document).ready(function() {
            
            var nav = $('.special_event_tab');
            $(window).scroll(function () {
                if ($(this).scrollTop() > 250) {
                    nav.addClass("f-nav");
                } else {
                    nav.removeClass("f-nav");
                }
            });
        });
        </script>
        
        <div class="special_event_tab"> 
            <select class="plan_list" title="기획전 전체상품 보기">
                <option value="" selected>전체상품보기</option>
                <option value="">모기장 (12)</option>
                <option value="">모기약 (8)</option>
                <option value="">모기채,살충기 (11)</option>
                <option value="">모기접근방지 용품 (22)</option>
            </select>
        </div>
        
        
    </section>
</div>
	<%@ include file="/mobilefirst/include/inc_ctu.jsp"%>
	<%@ include file="/mobilefirst/renew/include/footer.jsp"%>
</div>	
<!-- 연관기획전 레이어 -->
<div class="planlist_view" id="layer_planlist">
    <h3>연관기획전<a href="javascript:///" onclick="$('#layer_planlist').hide();" class="close ico_m">창닫기</a></h3>
    <ul>
        <li><img src="http://img.enuri.gscdn.com/images/mobilefirst/planlist/B_20160824130403/B_20160824130403_main.png" alt="" ></li>
        <li><img src="http://img.enuri.gscdn.com/images/mobilefirst/planlist/B_20160818172500/B_20160818172500_main.png" alt=""></li>
        <li><img src="http://img.enuri.gscdn.com/images/mobilefirst/planlist/B_20160817175410/B_20160817175410_main.png" alt=""></li>
        <li><img src="http://img.enuri.gscdn.com/images/mobilefirst/planlist/B_20160824130403/B_20160824130403_main.png" alt="" ></li>
    </ul>
    <div class="dim"></div>
</div>
<!--// 연관기획전 레이어 -->
</body>
</html>
<script>

</scrpt>
<script id="goodsList" type="text/x-jquery-tmpl">

<p id="title_2"class="tab_cons">
    <strong>모기장</strong>모기 빈틈없이 촘촘하게 막아준다!
</p>
<div class="goods" id="11016642">
            <div class="inner">
                <div class="thumb" style="">
                    <img src="http://image.11st.co.kr/t/300/t/1/4/7/8/2/8/592147828_B.jpg" onerror="this.src='http://photo3.enuri.com/data/images/service/small/11016000/11016642.gif'" alt="" />
                </div>
                <div class="infobox"> 
                    <p class="company">상품상세설명 참조</p> 
                    <p class="product">[시즌특가전]A [한립토이스] 에디슨 과학블럭원목놀이/원목블럭/블록</p>
                    <p class="description">고급스러움에 품격을 더하다!</p>
                    <p class="priceinfo">
                        <span class="lowest">최저가</span><span class="price">67,330</span><span class="won">원</span>
                    </p>
                </div>
            </div>
        </div> 
</script>
<%@ include file="/mobilefirst/include/common_logger.html"%>