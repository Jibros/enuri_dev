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
		<div class="big_photo" id="news_top"></div>
		
		<div class="newsbox" id="news_bottom">
			<ul class="sp_list"  id="news_bottom_body"></ul>
		</div>

		<div class="newsbox" id="news_review"></div>

		<div class="newsbox" id="news_theme"></div>


		<div class="newsbox"> 
			<h3>카테고리별 <b>핫뉴스</b><em class="all" id="news_all">전체보기</em></h3>
			<ul class="cate_new">
				<li id="newscate_head_01" class="newscate_btt" cate="01" class="on">디지털/가전</li>
				<li id="newscate_head_02" class="newscate_btt" cate="02">컴퓨터</li>
				<li id="newscate_head_03" class="newscate_btt" cate="03">스포츠/자동차</li>
				<li id="newscate_head_04" class="newscate_btt" cate="04">유아/라이프</li>
			</ul>
		
			<ul class="hotnews"  id="newscate_01" style="display:none"></ul>
			<ul class="hotnews"  id="newscate_02" style="display:none"></ul>
			<ul class="hotnews"  id="newscate_03" style="display:none"></ul>
			<ul class="hotnews"  id="newscate_04" style="display:none"></ul>
		</div>

	</section>
	
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
var vType="<%=strType%>";

var vNews_no_now = "01";

var vHash = window.location.hash;

$(function() {

    $("body").on('touchend', function(e) {
        if (window.android && android.onTouchEnd) {
            window.android.onTouchEnd();
        } else if ($("#ios").val()) {

        }
    });
    
	vHash = window.location.hash;

	$(".cate_new > li").click(function(){
		var vThis = $(this).attr("cate");

		$(".newscate_btt").removeClass("on");
		$(this).addClass("on");
		vNews_no_now = $(this).attr("cate");

		$(".hotnews").hide();
		$("#newscate_"+vNews_no_now).show();
	});

	$("#news_all").click(function(){
		location.href = "/mobilefirst/renew/shoppingNews_all.jsp";
	});

	getList();
});


function setImg(mo_img,mo_img2,rss_thumbnail){
	var vRtn_img = "";
	
	if(mo_img != ""){
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

function getList(){
	$.ajax({  
		type: "POST",
		dataType:"json",
		url: "/mobilefirst/api/main/newsTab.json",   
		success: function(json_list){ 	
			var newsTab_top = json_list.newsTab_top;
			var newsTab_bottom = json_list.newsTab_bottom;
			var newsTab_review = json_list.newsTab_review;
			var newsTab_theme = json_list.newsTab_theme;
			var category_tip = json_list.category_tip;

		    var template = "";
		    
		    if(newsTab_top){
		        var vTopimg = setImg(newsTab_top[0].mo_img,newsTab_top[0].mo_img2,newsTab_top[0].rss_thumbnail);

		        if(vTopimg){
		      		template += "<img src=\""+ vTopimg +"\" alt=\"\" />";
		           	template += "<span class=\"tit\"><em>"+ newsTab_top[0].name +"</em></span>";
		    		
		            $("#news_top").attr("onclick","show_detail('"+newsTab_top[0].url+"');");
		            $("#news_top").html(template);
		        }else{
		        	$("#news_top").hide();
		        }
		    }else{
		    	$("#news_top").hide();
		    }

		    template = "";
		    
		    if(newsTab_bottom){
		        for(var i=0;i<newsTab_bottom.length;i++){
		            template += "<li onclick=\"show_detail('"+newsTab_bottom[i].url+"');\">";
		            template += "	<a href=\"javascript:///\">";
		            template += "		<img src=\""+ setImg(newsTab_bottom[i].mo_img,newsTab_bottom[i].mo_img2,newsTab_bottom[i].rss_thumbnail) +"\" alt=\"\" />";
		            template += "		<strong>"+ newsTab_bottom[i].name +"</strong>";
		            template += "	</a>";
		            template += "</li>";
		        }

		        $("#news_bottom_body").html(template);
		    }else{
		    	$("#news_bottom").hide();
		    	$("#news_bottom_body").html(null);
		    }

		    template = "";
		    
		    if(newsTab_review){

		    	template += "<h3><b>"+ newsTab_review.title1 +"</b> "+ newsTab_review.title2 +"</h3>";

		    	var newsTab_review_list = newsTab_review.list;
			    
		        var vTopimg = setImg(newsTab_review_list[0].mo_img,newsTab_review_list[0].mo_img2,newsTab_review_list[0].rss_thumbnail);

		        if(vTopimg){
		        	template += "<div class=\"big_photo\">";
		      		template += "	<img src=\""+ vTopimg +"\" alt=\"\" />";
		           	template += "	<span class=\"tit\"><em>"+ newsTab_review_list[0].name +"</em></span>";
		           	template += "</div>";
		           	
		            $("#news_review").attr("onclick","show_detail('"+newsTab_review_list[0].url+"');");
		            $("#news_review").html(template);

		            $("#news_review").attr("onclick","show_detail('"+newsTab_review_list[0].url+"');");
		            $("#news_review").html(template);
		        }else{
		        	$("#news_review").hide();
		        }
		    }else{
		    	$("#news_review").hide();
		    }

 			template = "";
		    
		    if(newsTab_theme){

		    	template += "<h3><b>"+ newsTab_theme.title1 +"</b> "+ newsTab_theme.title2 +"</h3>";

		    	var newsTab_theme_list = newsTab_theme.list;

		    	if(newsTab_theme_list.length > 0){
		    		template += "<ul class=\"sp_list\">";

		    		for(var i = 0;i<newsTab_theme_list.length;i++){
		    			var vTmp_img = setImg(newsTab_theme_list[i].mo_img, newsTab_theme_list[i].mo_img2, newsTab_theme_list[i].rss_thumbnail);
						
						template += "<li onclick=\"show_detail('"+newsTab_theme_list[i].url+"');\">";
						template += "	<a href=\"javascript:///\">";
						template += "		<img src='"+ vTmp_img +"' />";
						template += "		<strong>"+ newsTab_theme_list[i].name +"</strong>";
						template += "	</a>";
						template += "</li>";
				    }
		    		template += "</ul>";
			    }
			    
		    	$("#news_theme").html(template);
		    }else{
		    	$("#news_theme").hide();
			}

		    template = "";
		    
		    var json_list = category_tip;
		    
		    if(json_list.length > 0){
		        for(var i = 0;i<json_list.length;i++){
		            var vCategory_name = json_list[i].category_name;
		            var vTip_no = json_list[i].tip_no;
					var vList = json_list[i].list;

					if(vList.length > 0){
						for(var j=0;j<vList.length;j++){
							var vTmpImg = setImg(vList[j].mo_img,vList[j].mo_img2,vList[j].rss_thumbnail);
							
							template += "<li class=\"tiplist tip_"+ vTip_no +"\" onclick=\"show_detail('"+ vList[j].url +"')\">";
							if(vTmpImg != ""){
								template += "<span class=\"thum\"><img src=\""+ vTmpImg +"\" alt=\"\" /></span>";						
							}
							template += "<strong>"+ vList[j].name +"</strong>";
							template += setMmdd(vList[j].kb_regdate.substring(5,10));
							if(vList[j].source != ""){
								template += " | "+ vList[j].source;
							}
							template += "</li>";
						}
					}

					if(template != ""){
						$("#newscate_"+vTip_no).html(template);
						template = "";
					}
					
		        }
		        $("#newscate_head_"+vNews_no_now).addClass("on");
		        $("#newscate_"+vNews_no_now).show();
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