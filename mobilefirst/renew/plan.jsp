<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
String strApp = ChkNull.chkStr(request.getParameter("app"));
Cookie[] carr = request.getCookies();
String strAppyn = "";
String strVerios = "";
String strType= ChkNull.chkStr(request.getParameter("type"),"");	
String strAppyn2 = ChkNull.chkStr(request.getParameter("app"),"");	

String menu = ChkNull.chkStr(request.getParameter("menu"),"");	

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

long cTime = System.currentTimeMillis(); 
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String nowDt = dayTime.format(new Date(cTime));

String seasonYN = "N";
String seasonName = "#가정의달";

response.sendRedirect("http://m.enuri.com/mobilefirst/index.jsp");

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
<div id="main">
	<!-- 헤더영역 -->
    <!-- 홈메인 GNB -->
    <%@include file="/mobilefirst/renew/include/gnb.html"%>
    <nav class="m_top">
        <div class="grd_next"></div>
        <div class="gnbarea" id="iscroll">
            <ul class="newgnb" style="heigth:177px">
                <%@ include file="/mobilefirst/renew/include/topMenu.jsp"%>
            </ul>
        </div>
    </nav>
	<!-- 160215 -->
		<script type="text/javascript">
			$(document).ready(function() {
				var menu = "<%=menu%>";
				//Default Action
				$(".cont_area").hide();
				
				if(menu == "E"){
					$(".newTab li:last").addClass("on").show(); 
					$(".cont_area:last").show();
				}else{
					$(".newTab li:first").addClass("on").show(); 
					$(".cont_area:first").show();
				}
				//On Click Event
				$(".newTab li").click(function() {
					$(".newTab li").removeClass("on"); 
					$(this).addClass("on"); 
					$(".cont_area").hide(); 
					var activeTab = $(this).find("a").attr("href");
					 $(activeTab).show(); 
					return false;
				});
			});
		</script>
<div id="wrap">
		<ul class="newTab">
			<li><a href="#tab01">인기 기획전</a></li>
			<li><a href="#tab02">이벤트 혜택</a></li>
		</ul>
	<div class="plan">
		<!-- 특별 기획전 -->
		<div class="cont_area" id="tab01">
			<ul id="planList"></ul>
		</div>
		<!--// 특별 기획전 -->
		<!-- 이벤트 -->
		<div class="cont_area" id="tab02">
			<ul id="eventList"></ul>
			<button type="button" class="winner" onclick="goWonList()"><em>당첨자발표</em></button>
		</div>
		<!--// 이벤트--> 
	</div>
</div>
	<%@ include file="/mobilefirst/include/inc_ctu.jsp"%>
	<%@ include file="/mobilefirst/renew/include/footer.jsp"%>
</div>	
</body>
</html>
<script language="javascript">
var vAppyn = getCookie("appYN");
var vAppyn2 = "<%=strAppyn2%>";

if(vAppyn2 == "Y"){ 
	vAppyn = "Y";
}

var vVerios = getCookie("verios");
var vVerand = "<%=strVerand%>";
var mType = "";
if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
	mType = "I";
}else if(navigator.userAgent.indexOf("Android") > -1){
	mType = "A";
}

$(document).ready(function() {
	var menu = "<%=menu%>";
	//Default Action
	$(".cont_area").hide();
	
	if(menu == "E"){
		$(".newTab li:last").addClass("on").show(); 
		$(".cont_area:last").show();
	}else{
		$(".newTab li:first").addClass("on").show(); 
		$(".cont_area:first").show();
	}
 
	//On Click Event
	$(".newTab li").click(function() {
		
		var id = $(this).index();
		if(id == 0) ga('send', 'event', 'mf_plan_event', 'event_tab', ' tab_plan'); 
		else 	ga('send', 'event', 'mf_plan_event', 'event_tab', ' tab_benefit');	   
		
		$(".newTab li").removeClass("on"); 
		$(this).addClass("on"); 
		$(".cont_area").hide(); 
		var activeTab = $(this).find("a").attr("href");
		$(activeTab).fadeIn(); //페이드효과
		 /* $(activeTab).show(); defalut */
		return false;
		
	});

});
function bannerCall(){
	
	var vAppyn = getCookie("appYN");
	var vVerios = getCookie("verios");
	var vVerand = getCookie("verand");
	
	$("#ramenBanner").show();
	/*
	if(vAppyn == "Y"){
		if(vVerios.substring(0,2) == "3." || vVerand.substring(0,2) == "3." ){
		}
    }
    */
}
function goWonList(){
	ga('send', 'event', 'mf_plan_event', 'event', 'event_board');
	location.href = "/mobilefirst/event/eventWonList.jsp?before=Y";
}
function goLink(){
	var vAppyn = getCookie("appYN");
	if(vAppyn == "Y"){
		ga('send', 'event', 'mf_plan_event', 'plan', '라면백이벤트배너_APP');
		location.href = "/mobilefirst/event/ramen_event_eve.jsp?freetoken=event";
	}else{
		ga('send', 'event', 'mf_plan_event', 'plan', '라면백이벤트배너_WEB');
		location.href = "/mobilefirst/event/ramen_event_web.jsp";
	}
}
function goPlanView(dataid){

	var goUrl = "/mobilefirst/planlist.jsp?t=B_"+dataid;
	if(dataid == '' ){
	   ga('send', 'event', 'mf_plan_event', 'plan', "히트브랜드");
	   goUrl = "/mobilefirst/event2016/hitBrand_201607.jsp";
	   location.href = goUrl;
	}else{
	    ga('send', 'event', 'mf_plan_event', 'plan', 'plan_'+dataid);
        location.href = goUrl;
	}
}

jQuery(document).ready(function($) {
	
	/*
	var strAppyn = '<%=strAppyn%>'+'';
	
	if(strAppyn != 'Y'){
		$(".m_top").show();
	}
	*/
	
	//bannerCall();
	
	
	ga('send', 'pageview', {
		'page': '/mobilefirst/plan_event.jsp',
		'title': 'mf_홈_이벤트기획전'
	}); 
	getEventBanner();
	getPlanBanner();
		
		
		$("body").on('click', '#eventBanner > li', function(e) {
			
			var id = $(this).children().attr("id");
			
			// /mobilefirst/event/event_cerkey_send.jsp?freetoken=event
			// enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event/install_quiz.jsp
			
			var goUrl = "";
			
			if(id == 'app_install'){
				
				goUrl = "/mobilefirst/event/event_cerkey_send.jsp?freetoken=event";
				
				ga('send', 'event', 'mf_plan_event', 'event', 'event_banner_app_install');
				
				if($.cookie('appYN') == 'Y' ){	// 웹에서 호출
					ga('send', 'event', 'mf_plan_event', 'event', 'APP_배너클릭');
					goUrl = "/mobilefirst/event/event_cerkey_enter.jsp?freetoken=event";
				}else{
					ga('send', 'event', 'mf_plan_event', 'event', 'WEB_배너클릭');
				}
				
				location.href = goUrl; 
				
			}else if(id == 'app_ox'){
				
				goUrl = "/mobilefirst/event/install_quiz.jsp?freetoken=event";
				
				ga('send', 'event', 'mf_plan_event', 'event', 'event_banner_app_ox');
				
				if($.cookie('appYN') != 'Y' ){	// 웹에서 호출
					alert("앱에서만 참여 가능한 이벤트 입니다.");
				}else{
					location.href = goUrl;				
				}
				
			}else if(id == 'choseok_banner'){
				
				goUrl = "/mobilefirst/event/event_shopping.jsp?freetoken=event";
				ga('send', 'event', 'mf_plan_event', 'event', '추석 이벤트 배너');
				location.href = goUrl;				
			}
		});
});

function getPlanBanner(){

	$plan_Banner_template = $('#plan_Banner_template');

	//var loadUrl = "/mobilefirst/ajax/main/ajax_to_json_plan_banner.jsp";
	var loadUrl = "/mobilefirst/http/json/plan_banner_list.json";

	$.ajax({
		url: loadUrl,
		dataType: 'json',
		async: false,
		success: function(json){
			//$("#planList").append(Mustache.render($plan_Banner_template.html(), json));// 템플릿에 연동
			//$("img.lazy").lazyload();
			
			$.each(json.planList , function(i, v){
                
                var html = "";
                
                if( i == 0){
                
                html +="<li data-id='"+v.TODAY_ID+"'><a href=\"javascript:goPlanView('')\">";
                html +=    "<img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/event/mobile_640_280.jpg' class=\"thum\">";
                html += "</a>";
                html += "</li>"
                
                }			    
			    
			    html +="<li data-id='"+v.TODAY_ID+"'><a href=\"javascript:goPlanView('"+v.TODAY_ID+"')\">";
                html +=    "<img src=\"http://img.enuri.gscdn.com/images/mobilefirst/planlist/B_"+v.TODAY_ID+"/B_"+v.TODAY_ID+"_main.png\" class=\"thum\">";
                html += "</a>";
                html += "</li>"
			    
			    
	               
				$("#planList").append(html);
		    
		    });
		    	
		}
	});
}

function getEventBanner(){

	$event_Banner_template = $('#event_Banner_template');

	//var loadUrl = "/mobilefirst/ajax/main/ajax_to_json_plan_banner.jsp";
	var loadUrl = "/mobilefirst/http/json/plan_banner.json";

	$.ajax({
		url: loadUrl,
		dataType: 'json',
		async: false,
		success: function(json){
			
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
			
			var today = new Date().format("yyyyMMddhhmm");
			today = today * 1;
			
// 			var today = "201609010000";
			
			var template = "";
			
			if(json.planList){
				for(var i=0;i<json.planList.length;i++){
 					if((mType=="I" && json.planList[i].iosYN == "N") || (mType=="A" && json.planList[i].androidYN == "N")){
						continue;
					}  
					if(json.planList[i].event_yn == "Y" && json.planList[i].startDate == "" && json.planList[i].endDate == ""){
						template += "<li>";
						template += "<a href=\"javascript:goEventLink(\'"+json.planList[i].link+"\',\'"+json.planList[i].title+"\')\" >";
						template += "<img src=\""+json.planList[i].imgSrc+"\" class=\"thum\"/>";
						template += "<span><em>"+json.planList[i].title+"</em></span>";
						template += "</a>";
						template += "</li>";
					}else{
						if(json.planList[i].event_yn == "Y" && today > json.planList[i].startDate && today < json.planList[i].endDate){
							template += "<li>";
							template += "<a href=\"javascript:goEventLink(\'"+json.planList[i].link+"\',\'"+json.planList[i].title+"\')\" >";
							template += "<img src=\""+json.planList[i].imgSrc+"\" class=\"thum\"/>";
							template += "<span><em>"+json.planList[i].title+"</em></span>";
							template += "</a>";
							template += "</li>";
						}
					}
					
				}
			}
			
			$("#eventList").html(template);
// 			$("#eventList").append(Mustache.render($event_Banner_template.html(), json));// 템플릿에 연동
			$("img.lazy").lazyload();
		}
	});
}
function goEventLink(link,title){
	ga('send', 'event', 'mf_plan_event', 'event', title);
	
	if(  link == ""){
		alert("이벤트 준비중 입니다.");
		return false;
	}else{
		location.href = link;
	}
}

 
</script>

<!--이벤트 템플릿-->
<script id="event_Banner_template" type="x-tmpl-mustache">
	{{#planList}}
	<li> 
			<a href="javascript:goEventLink('{{{link}}}','{{{title}}}')" >
				<img src="{{{img-src}}}" class="thum"/>
				{{#title}}
				<span><em>{{{title}}}</em></span>
				{{/title}}
			</a>
	</li>
	{{/planList}}

</script>


<!--기획전 템플릿-->
<script id="plan_Banner_template" type="x-tmpl-mustache"> 
		{{#planList}}
		<li data-id='{{{TODAY_ID}}}'><a href="javascript:goPlanView('{{{TODAY_ID}}}')">
			<img src="http://img.enuri.gscdn.com/images/mobilefirst/planlist/B_{{{TODAY_ID}}}/B_{{{TODAY_ID}}}_main.png"  onerror="this.src='http://img.enuri.gscdn.com/images/mobilefirst/planlist/B_{{{TODAY_ID}}}/B_{{{TODAY_ID}}}_main.jpg'" class="thum">
		</a>
		</li>	
		{{/planList}}
</script>


<%@ include file="/mobilefirst/include/common_logger.html"%>