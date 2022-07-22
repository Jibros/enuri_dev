<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
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
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
	<%@include file="/mobilefirst/renew/include/common.html"%>
	<script type="text/javascript" src="/mobilefirst/js/lib/LazyLoad.1.9.3.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/default.css" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/trend.css"/>
	<script>  
	//이미지 로더 
	(function(e,t,n,r){e.fn.lazy=function(r){function u(n){if(typeof n!="boolean")n=false;s.each(function(){var r=e(this);var s=this.tagName.toLowerCase();if(f(r)||n){if(r.attr(i.attribute)&&(s=="img"&&r.attr(i.attribute)!=r.attr("src")||s!="img"&&r.attr(i.attribute)!=r.css("background-image"))&&!r.data("loaded")&&(r.is(":visible")||!i.visibleOnly)){var u=e(new Image);++o;if(i.onError)u.error(function(){d(i.onError,r);p()});else u.error(function(){p()});var a=true;u.one("load",function(){var e=function(){if(a){t.setTimeout(e,100);return}r.hide();if(s=="img")r.attr("src",u.attr("src"));else r.css("background-image","url("+u.attr("src")+")");r[i.effect](i.effectTime);if(i.removeAttribute)r.removeAttr(i.attribute);d(i.afterLoad,r);u.unbind("load");u.remove();p()};e()});d(i.beforeLoad,r);u.attr("src",r.attr(i.attribute));d(i.onLoad,r);a=false;if(u.complete)u.load();r.data("loaded",true)}}});s=e(s).filter(function(){return!e(this).data("loaded")})}function a(){if(i.delay>=0)setTimeout(function(){u(true)},i.delay);if(i.delay<0||i.combined){u(false);e(i.appendScroll).bind("scroll",h(i.throttle,u));e(i.appendScroll).bind("resize",h(i.throttle,u))}}function f(e){var t=l(),n=c(),r=e.offset().top,s=e.height();return t+n+i.threshold>r&&r+s>t-i.threshold}function l(){if(n.documentElement.scrollTop)return n.documentElement.scrollTop;return n.body.scrollTop}function c(){if(t.innerHeight)return t.innerHeight;if(n.documentElement&&n.documentElement.clientHeight)return n.documentElement.clientHeight;if(n.body&&n.body.clientHeight)return n.body.clientHeight;if(n.body&&n.body.offsetHeight)return n.body.offsetHeight;return i.fallbackHeight}function h(e,t){function s(){function o(){r=+(new Date);t.apply()}var s=+(new Date)-r;n&&clearTimeout(n);if(s>e||!i.enableThrottle)o();else n=setTimeout(o,e-s)}var n;var r=0;return s}function p(){--o;if(!s.size()&&!o)d(i.onFinishedAll,null)}function d(e,t){if(e){if(t!==null)e(t);else e()}}var i={bind:"load",threshold:500,fallbackHeight:2e3,visibleOnly:true,appendScroll:t,delay:-1,combined:false,attribute:"data-src",removeAttribute:true,effect:"show",effectTime:0,enableThrottle:false,throttle:250,beforeLoad:null,onLoad:null,afterLoad:null,onError:null,onFinishedAll:null};if(r)e.extend(i,r);var s=this;var o=0;if(i.bind=="load")e(t).load(a);else if(i.bind=="event")a();if(i.onError)s.bind("error",function(){d(i.onError,e(this))});return this};e.fn.Lazy=e.fn.lazy})(jQuery,window,document);
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		//런칭할때 UA-52658695-3 으로 변경
		ga('create', 'UA-52658695-3', 'auto');
	</script>
</head>
<body> 
<div id="wrap">
	
	<section class="news">
		<div class="big_photo" id="todaytip_top"></div>
		
		<div class="newsbox" id="weekly_push"></div>

		<div class="newsbox" id="tip_01"> </div>
		<div class="newsbox" id="tip_02"> </div>
		<div class="newsbox" id="tip_03"> </div>
		<div class="newsbox" id="tip_04"> </div>
		<div class="newsbox" id="tip_05"> </div>
	</section>
	
</div>
</body>
</html>
<script>
var vAppyn = getCookie("appYN");
var vAppyn2 = "<%=strAppyn2%>";

if(vAppyn2 == "Y"){ 
	vAppyn = "Y";
}

var vVerios = getCookie("verios");
//var vVerand = getCookie("verand");
var vVerand = "<%=strVerand%>";
var vType="<%=strType%>";

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

	getLlist();
});

function setImg(mo_img,mo_img2,rss_thumbnail,movie_id){
	//console.log("mo_img: "+mo_img);
	//console.log("mo_img2: "+mo_img2);
	
	var vRtn_img = "";
	if(movie_id != "" && typeof movie_id  != "undefined"){
		vRtn_img = "http://img.youtube.com/vi/" + movie_id +"/mqdefault.jpg";
	}else if(mo_img != ""){
		vRtn_img = "http://storage.enuri.gscdn.com/pic_upload/enurinews/"+ mo_img;
	}else if(mo_img2 != ""){
		vRtn_img = "http://storage.enuri.gscdn.com/pic_upload/enurinews_mobile/"+ mo_img2;
	}else if(rss_thumbnail != ""){
		vRtn_img = rss_thumbnail;
	}

	if(vRtn_img != ""){
		return vRtn_img;
	}else{
		return "http://imgenuri.enuri.gscdn.com/images/m_home/noimg.png";
	}
}

function getLlist(){

	$.ajax({  
		type: "POST",
		dataType:"json",
		url: "/mobilefirst/api/main/shoptipTab.json",   
		success: function(json_list){ 	
			var todaytip_top = json_list.todayTip_top;
			var category_tip = json_list.category_tip;
			var weekly_push = json_list.weekly_push;
		    var template = "";
		    
		    if(todaytip_top){
		        var vTopimg = setImg(todaytip_top[0].mo_img,todaytip_top[0].mo_img2,todaytip_top[0].rss_thumbnail);

		        if(vTopimg){
		      		template += "<img src=\""+ vTopimg +"\" alt=\"\" />";
		           	template += "<span class=\"tit\"><em>"+ todaytip_top[0].name +"</em></span>";
		    		
		            $("#todaytip_top").attr("onclick","show_detail('"+todaytip_top[0].url+"');");
		            $("#todaytip_top").html(template);

		            $("#todaytip_top").attr("onclick","show_detail('"+todaytip_top[0].url+"');");
		            $("#todaytip_top").html(template);
		        }else{
		        	$("#todaytip_top").hide();
		        }
		    }else{
		    	$("#todaytip_top").hide();
		    }

		    template = "";
		    
		    if(weekly_push){
		    	template += "<h3>금주의 <b>추천</b></h3>";
		    	template += "<ul class=\"sp_list\">";
		        for(var i=0;i<weekly_push.length;i++){
		            template += "<li onclick=\"show_detail('"+weekly_push[i].url+"');\">";
		            template += "	<a href=\"javascript:///\">";
		            template += "		<img src=\""+ setImg(weekly_push[i].mo_img,weekly_push[i].mo_img2,weekly_push[i].rss_thumbnail,weekly_push[i].movie_id) +"\" alt=\"\" />";
		            template += "		<strong>"+ weekly_push[i].name +"</strong>";
		            template += "	</a>";
		            template += "</li>";
		        }
		        template += "</ul>";

		        $("#weekly_push").html(template);
		    }else{
		    	$("#weekly_push").hide();
		    }

		    if(category_tip){

		        for(var i=0;i<category_tip.length;i++){

			    	template = "";
			    	
					template += "<h3 class=\"tip_tit\"><b>"+ category_tip[i].category_name +"</b><em class=\"all\" onclick=\"allview('"+ category_tip[i].tip_no +"')\">전체보기</em></h3>";
					template += "<ul class=\"hotnews\">";

					if(category_tip[i].list.length > 0){
						var category_sub = category_tip[i].list;
						
						for(var j=0;j<category_sub.length;j++){
							
							var vTmp_img = setImg(category_sub[j].mo_img, category_sub[j].mo_img2, category_sub[j].rss_thumbnail);
							
							template += "<li onclick=\"show_detail('"+category_sub[j].url+"');\">";
							template += "	<span class=\"thum\"><img src='"+ vTmp_img +"' /></span>";
							template += "	<strong>"+ category_sub[j].name +"</strong>";
							template += "	"+ setMmdd(category_sub[j].kb_regdate.substring(5,10));
							if(category_sub[j].source != ""){
								template += " | "+ category_sub[j].source;
							}
							template += "</li>";
						}
				 	}
					template += "</ul>";

					$("#tip_"+category_tip[i].tip_no).html(template);
		        }
		    }else{
		    	$("#tip_01").hide();
		    	$("#tip_02").hide();
		    	$("#tip_03").hide();
		    	$("#tip_04").hide();
		    	$("#tip_05").hide();
		    }
		}
	});
}

function setMmdd(date){
	var mm = date.substring(0,2);
	var dd = date.substring(3,5);

	return parseInt(mm) + "월 " + parseInt(dd) + "일";
}

function allview(no){
	location.href = "/mobilefirst/renew/shoppingTips_all.jsp?tipno="+no;
}

function show_detail(url){
	window.open(url);
}

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
       var c = ca[i];
       while (c.charAt(0)==' ') c = c.substring(1);
       if(c.indexOf(name) == 0)
          return c.substring(name.length,c.length);
    }
    return "";
}

function commaNum(amount) {
    var delimiter = ","; 
    var i = parseInt(amount);

    if(isNaN(i)) { return ''; }
    
    var minus = '';
    
    if (i < 0) { minus = '-'; }
    i = Math.abs(i);
    
    var n = new String(i);
    var a = [];

    while(n.length > 3)
    {
        var nn = n.substr(n.length-3);
        a.unshift(nn);
        n = n.substr(0,n.length-3);
    }

    if (n.length > 0) { a.unshift(n); }
    n = a.join(delimiter);
    amount = minus + (n+ "");
    return amount; 
}
</script>
<%@ include file="/mobilefirst/include/common_logger.html"%>