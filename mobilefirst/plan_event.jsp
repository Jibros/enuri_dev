<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%

response.sendRedirect("/mobilefirst/index.jsp#plan");

Cookie[] carr = request.getCookies();
String strAppyn = "";
String strVerios = "";

strAppyn = ChkNull.chkStr(request.getParameter("app"));

if(   ChkNull.chkStr(strAppyn).equals("")  ){

	try{
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("appYN")){
		    	strAppyn = carr[i].getValue();
		    }
		}
	} catch(Exception e) {}

}

String appYN = "";
appYN = ChkNull.chkStr(request.getParameter("app"));

%>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
	<%@ include file="/mobilefirst/include/common.html" %>
	<link rel="stylesheet" type="text/css" href="http://dev.enuri.com/mobilefirst/css/plan.css">
</head>
<script type="text/javascript" src="js/lib/LazyLoad.1.9.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
<%@ include file="/mobilefirst/include/common_top.jsp" %>
<body> 
<%@ include file="/mobilefirst/gnb/gnb.html" %>

<%
 if(strAppyn.equals("Y")){
 	String viewTag = "";
 }

%>

<%
	String spath = request.getServletPath();  
	String url = request.getRequestURL().toString(); 
%> 

<nav class="m_top" <%if(strAppyn.equals("Y")){%> style="display:none;"<%}else{%><%}%>>
	<ul class="newgnb">
	    <li><a href="Index.jsp" onclck="return false;">홈</a></li>
	    <li><a href="/mobilefirst/trend_news.jsp#pickup" onclck="return false;" >트렌드픽업</a></li>
	    <li><a href="/mobilefirst/best.jsp" onclck="return false;" >쇼핑베스트</a></li>
	    <li><a href="/mobilefirst/trend_news.jsp" onclck="return false;" >쇼핑 TIP</a></li>
	    <li><a href="/mobilefirst/plan_event.jsp" onclck="return false;" class="on">이벤트</a></li>
	</ul> 
</nav>

<div id="wrap">
	
	<ul class="newTab">
		<li><a href="#tab01">이벤트 혜택</a></li>
		<li><a href="#tab02">인기 기획전</a></li>
	</ul>
	
<!--	<div class="plan">
		<h3><strong>이벤트</strong> 놓치면 후회하는 에누리 단독 이벤트!<a href="javascript:///" onclick="goWonList()">당첨자/공지</a></h3>
		<ul id="planList" >
		</ul>
		<h3><strong>에누리 특별 기획전</strong> 좋은 것들만 모은 전문 코너</h3>
	</div>
-->	
	<div class="plan">
		<!-- 이벤트 -->
		<div class="cont_area" id="tab01">
			<ul id="eventList"></ul>
			<button type="button" class="winner" onclick="goWonList()"><em>당첨자/공지</em></button>
		</div>
		<!--// 이벤트--> 
	
		<!-- 특별 기획전 -->
		<div class="cont_area" id="tab02" style="display: block;">
			<ul id="planList"></ul>
		</div>
		<!--// 특별 기획전 -->
		</div>
	<%@ include file="/mobilefirst/include/footer.jsp"%> 
</div>	

</body>
</html>
<script language="javascript">

$(document).ready(function() {
	//Default Action
	$(".cont_area").hide(); 
	$(".newTab li:first").addClass("on").show(); 
	$(".cont_area:first").show();
 
	//On Click Event
	$(".newTab li").click(function() {
		
		var id = $(this).index();
		if(id == 0) ga('send', 'event', 'mf_plan_event', 'event_tab', ' tab_benefit');
		else 		   ga('send', 'event', 'mf_plan_event', 'event_tab', ' tab_plan');
		
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

function goGold(){
	ga('send', 'event', 'mf_plan_event', 'event', '새해이벤트');
	location.href = "/mobilefirst/event/newyear_2016.jsp?freetoken=event";
}


function goWonList(){
	ga('send', 'event', 'mf_plan_event', 'event', 'event_board');
	location.href = "/mobilefirst/event/eventWonList.jsp?before=Y";
}

function gocashback(){
	
	ga('send', 'event', 'mf_plan_event', 'event', '이벤트 캐시백 배너');
	//location.href ="/mobilefirst/event/event_cashback.jsp?freetoken=event";	
	location.href ="/mobilefirst/event/event_payback.jsp?freetoken=event";
}

function goinstall(){
	ga('send', 'event', 'mf_plan_event', 'event', '설치 배너');
	if(getCookie("appYN") == 'Y'){
		location.href ="/mobilefirst/event/event_install.jsp?freetoken=event";
	}else{
		location.href ="/mobilefirst/event/event_install.jsp";
	}	
	
}

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