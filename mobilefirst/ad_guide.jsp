<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Know_box_Data"%>
<%@ page import="com.enuri.bean.knowbox.Know_box_Proc"%>
<jsp:useBean id="Know_box_Proc" class="com.enuri.bean.knowbox.Know_box_Proc" scope="page"/>
<%
Cookie[] carr = request.getCookies();
String strAppyn = ChkNull.chkStr(request.getParameter("app"),"");
String strVerios = "";
String strType= ChkNull.chkStr(request.getParameter("type"),"");	

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

//String json = request.getParameter("json");
String strCate = ChkNull.chkStr(request.getParameter("strCate"),"0404");//카테고리
String strNo = ChkNull.chkStr(request.getParameter("strNo"),"");//메인 이미지 번호
String num = request.getParameter("num");//탭

String klist = Know_box_Proc.getList_Search("kc5", "regdate", 1, 100).toString();


/*
if(json.equals("")){
	json = null;
}*/

%>
<!DOCTYPE html>  
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, target-densitydpi=medium-dpi" />
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

<body> 

<div class="adguide">
<div class="head_area">  
	<div class="head_inner">
		<h2 class="tit">에누리 가격비교</h2> 
		<a href="javascript:///" class="close">닫기</a>
	</div>
</div>

<div class="tab_trend three">
	<ul>
		<li><a href="javascript:///" id="barTap01">가이드</a></li>
		<li><a href="javascript:///" id="barTap02">뉴스</a></li>
		<li><a href="javascript:///" id="barTap03">리뷰&amp;사용기</a></li>
	</ul>
</div>
</div>

<section class="guidelist">
</section>

</body>
</html>
<script language="javascript">
var json_news;//뉴스
var json_guide;//가이드
var json_review = <%=klist%>;//사용기
var json_guide_bottom_list;
var json_news_bottom_list;
var json_inc = (function() {
	    var json = null;
	    $.ajax({
	        'async': false,
	        'global': false,
	        'url': "/mobilefirst/ajax/getAdContentType_ajax.jsp",
	        'data': "strCate="+"<%=strCate%>"+"&strNo="+"<%=strNo%>",
	        'success': function (data) {
	            json = JSON.parse(data);
	        }
	    });
	    return json;
	})();
var num = <%=num%>;	//이전페이지 카테고리
var jsonGuide = new Array();	//구매가이드
var jsonNews = new Array();		//뉴스
var jsonReview = new Array();	//리뷰&사용기
var moreBtnCnt = 0;
var vVerios = "<%=strVerios%>";

<%try{ %>
	json_news = <%@ include file="/mobilefirst/http/json/getNews_device.json"%>;
	json_guide = <%@ include file="/mobilefirst/http/json/getShopping_guide.json"%>;	
<% }catch(Exception e){ %> 
	
	json_news = (function() {
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

$(function() {
	//이전페이지 json리스트 가져오기
	getBeforeJson();
	//가이드리스트
	guideInit();
	//뉴스리스트
	newsInit();
	//사용기리스트
	getReview_list();

	$("#barTap01").click(function(event){   
		moreBtnCnt = 0;
		$("#cate02").hide();
		$(".btm02").hide();
		$("#cate03").hide();
		$(".btm03").hide();
		$("#barTap02").removeClass("selected");
		$("#barTap03").removeClass("selected");
		$("#cate01").show();
		$(".btm01").show();
		$(this).addClass("selected");
		ga('send', 'event', 'mf_lp_Info_Ad_contents_more', 'click_TAB', 'TAB_가이드');
	});
	$("#barTap02").click(function(event){   
		moreBtnCnt = 0;
		$("#cate01").hide();
		$(".btm01").hide();
		$("#cate03").hide();
		$(".btm03").hide();
		$("#barTap01").removeClass("selected");
		$("#barTap03").removeClass("selected");
		$("#cate02").show();
		$(".btm02").show();
		$(this).addClass("selected");
		ga('send', 'event', 'mf_lp_Info_Ad_contents_more', 'click_TAB', 'TAB_뉴스');
	});
	$("#barTap03").click(function(event){   
		moreBtnCnt = 0;
		$("#cate02").hide();
		$(".btm02").hide();
		$("#cate01").hide();
		$(".btm01").hide();
		$("#barTap02").removeClass("selected");
		$("#barTap01").removeClass("selected");
		$("#cate03").show();
		$(".btm03").show();
		$(this).addClass("selected");
		ga('send', 'event', 'mf_lp_Info_Ad_contents_more', 'click_TAB', 'TAB_리뷰&사용기');
	});
	$(".close").on('click', function(){
		if('<%=strAppyn %>' != 'Y'){	// 웹에서 호출 
			window.close();
    	}else{
    		// 앱에서 호출 
	    	if(window.android){		// 안드로이드 			
	    		window.location.href = "close://";
	    	}else{					// 아이폰에서 호출
	    		window.location.href = "close://";
	    	}
    	}
    });
	
	var pageName = "";
	if(num == "1"){
		pageName = "가이드";
	}else if(num == "2"){
		pageName = "뉴스";
	}else{
		pageName = "사용기";
	}
	
	//page view 
	if('<%=strAppyn %>' != 'Y'){
		 if(navigator.userAgent.indexOf("Android") > -1){
			 ga('send', 'pageview', {
				'page': '/mobilefirst/ad_guide.jsp',
				'title': 'mf_인포애드_더보기_'+pageName+'(안드로이드)'
			}); 		
		 }else{
			 ga('send', 'pageview', {
				'page': '/mobilefirst/ad_guide.jsp',
				'title': 'mf_인포애드_더보기_'+pageName+'(ios)'
			}); 				 
		 }
	}else{	
		ga('send', 'pageview', {
			'page': '/mobilefirst/ad_guide.jsp',
			'title': 'mf_인포애드_더보기_'+pageName+'(app)'
		}); 
	}	
});

function getBeforeJson(){
	obj = json_inc.adListContentType;

	var imageRoot          = "http://storage.enuri.info/pic_upload/enurinews_thumbnail/";
	var errImgSrc          = "http://img.enuri.info/images/infoad/noimage.jpg";
	
	var guideNum = 0;
	var newsNum = 0;
	var reviewNum = 0;
	
	//10:구매, 05:뉴스, 07:리뷰
	for(var i=0; i<obj.length; i++){
		if(obj[i].kk_code == '10'){	
			jsonGuide[guideNum] = obj[i];
			guideNum = guideNum + 1;
		}else if(obj[i].kk_code == '05'){	
			jsonNews[newsNum] = obj[i];
			newsNum = newsNum + 1;
		}else if(obj[i].kk_code == '07'){	
			jsonReview[reviewNum] = obj[i];
			reviewNum = reviewNum + 1;
		}
	}
	//alert(jsonNews.length);
	//alert(jsonReview.length);
	var arr = new Array('jsonGuide','jsonNews','jsonReview');
	var arrNm = new Array('가이드','뉴스','리뷰&사용기');
	var html = "";
	
	for(var i=0; i<arr.length; i++) {
		var name = arr[i];
		var len = eval(name+".length");
		//alert(len);
		html += "<ul class=\"news_list\" id=\"cate0"+(i+1)+"\">";
		for(var j=0; j<len; j++){
			var sub_name = eval(name+"["+j+"]");
			if(sub_name.kb_top_write_flag=="Y") {
				html += "<li class=\"thum\">";
				html += "<a href=\"javascript:///\" onclick=\"kb_view("+ sub_name.kb_no +",'"+(i+1)+"')\" !onclick=\"logInsertInfoAdKnowBox('', varCate2);\">";
				if(sub_name.kb_thumbnail_img && sub_name.kb_thumbnail_img.length > 0) {
					html += "<img src=\""+imageRoot+sub_name.kb_thumbnail_img+"\" alt=\"\" onerror=\"this.src='"+errImgSrc+"'\" />";	
				}
				html += sub_name.kb_title+"</a></li>";
			}else{
				if(sub_name.kb_thumbnail_img && sub_name.kb_thumbnail_img.length > 0) {
					html += "<li class=\"news_pic\">";
					html += "	<a href=\"javascript:///\" onclick=\"kb_view("+ sub_name.kb_no +",'"+(i+1)+"')\" ><strong>"+ sub_name.kb_title + "</strong>";
					html += "	<span class=\"thumb\"><img src=\""+imageRoot+sub_name.kb_thumbnail_img +"\" onerror=\"fn_err_img(this);\" /></span>";
				}else{
					html += "<li>";
					html += "	<a href=\"javascript:///\" onclick=\"kb_view("+ sub_name.kb_no +",'"+(i+1)+"')\" ><strong>"+ sub_name.kb_title + "</strong>";
				}
				
				html += "	<span class=\"date\"><em>"+ (sub_name.kb_regdate).substring(0,10) +"</em>";
				if(sub_name.kb_readcnt >= 200){
					html += "	<em>조회수 : "+ commaNum(sub_name.kb_readcnt) +"</em>";
				}	
				html += "	</span>";
				if(fn_filterChk(removeHtml(sub_name.kb_content))){
					html += "	<span class=\"txt\">▶ 상세내용 보러가기</span>";
				}else{
					html += "	<span class=\"txt\">"+sub_name.kb_content+"</span>";
				}
				html += "</a></li>";
			}
		}
		html += "</ul>";
		html += "<span class=\"news_btn_more btm0"+(i+1)+"\"><button type=\"button\" onclick=\"javascript:moreGuide("+(i+1)+");\">더보기<em>(20)</em></button></span>";		
	}

	$('.guidelist').html(html);
	for(var i=1; i<=3; i++){
		if(num != i){
			$("#cate0"+i).hide();
			$(".btm0"+i).hide();
			$("#cate0"+i).hide();
			$(".btm0"+i).hide();
		}
	}
	$("#barTap0"+num).addClass("selected");
}
function moreGuide(param){
	if(param == 1){
		if(moreBtnCnt == 0)	moreBtnCnt = 20;
		moreBtnCnt = moreBtnCnt + 20;
		getGuideListBottom(json_guide_bottom_list,moreBtnCnt);
	}else if(param == 2){
		moreBtnCnt = moreBtnCnt + 20;
		getNewsListBottom(json_news_bottom_list,moreBtnCnt);
	}else if(param == 3){
		if(moreBtnCnt == 0)	moreBtnCnt = 20;
		moreBtnCnt = moreBtnCnt + 20;
		getReviewListBottom(json_review,moreBtnCnt);
	}
}
function guideInit(){
	var list = new Array();
	var cnt = 0;
	for(var i=0; i<json_guide.cate_01.ShoppingGuideList.length; i++){
		list[cnt] = json_guide.cate_01.ShoppingGuideList[i];
		cnt = cnt + 1;
	}
	for(var i=0; i<json_guide.cate_02.ShoppingGuideList.length; i++){
		list[cnt] = json_guide.cate_02.ShoppingGuideList[i];
		cnt = cnt + 1;
	}
	for(var i=0; i<json_guide.cate_03.ShoppingGuideList.length; i++){
		list[cnt] = json_guide.cate_03.ShoppingGuideList[i];
		cnt = cnt + 1;
	}
	for(var i=0; i<json_guide.cate_04.ShoppingGuideList.length; i++){
		list[cnt] = json_guide.cate_04.ShoppingGuideList[i];
		cnt = cnt + 1;
	}
	
	json_guide_bottom_list = {NewsList:list};
	
	json_guide_bottom_list.NewsList.sort(function (a, b) { 
		return a.kb_no < b.kb_no ? 1 : a.kb_no > b.kb_no ? -1 : 0;  
	});	
	
	getGuide_list();
}
function newsInit(){
	json_news.list.NewsList.sort(function (a, b) { 
		return a.kb_no < b.kb_no ? -1 : a.kb_no > b.kb_no ? 1 : 0;  
	});
	
	var list = new Array();
	var cnt = 0;
	for(var i=0; i<json_news.cate_01.NewsCate_01.length; i++){
		list[cnt] = json_news.cate_01.NewsCate_01[i];
		cnt = cnt + 1;
	}
	for(var i=0; i<json_news.cate_02.NewsCate_02.length; i++){
		list[cnt] = json_news.cate_02.NewsCate_02[i];
		cnt = cnt + 1;
	}
	for(var i=0; i<json_news.cate_03.NewsCate_03.length; i++){
		list[cnt] = json_news.cate_03.NewsCate_03[i];
		cnt = cnt + 1;
	}
	for(var i=0; i<json_news.cate_04.NewsCate_04.length; i++){
		list[cnt] = json_news.cate_04.NewsCate_04[i];
		cnt = cnt + 1;
	}
	
	json_news_bottom_list = {NewsList:list};
	
	json_news_bottom_list.NewsList.sort(function (a, b) { 
		return a.kb_no < b.kb_no ? 1 : a.kb_no > b.kb_no ? -1 : 0;  
	});	
	
	getNews_list();
}
function getNews_list(){
	var json = json_news.list;

	if(json.NewsList){
		var template = "";
		for(var i=0;i<json.NewsList.length;i++){
			//위 리스트와 같은 지 체크
			var validYn = true;
			for(var j=0; j<jsonNews.length; j++){
				if(json.NewsList[i].kb_no == jsonNews[j].kb_no){
					validYn = false;
				}
			}
			
			if(validYn){
				if(json.NewsList[i].mn_img && json.NewsList[i].mn_img.length > 0){
					template += "	<li class=\"news_pic\">";
					template += "		<a href=\"javascript:///\" onclick=\"kb_view("+ json.NewsList[i].kb_no +",'2')\" ><strong>"+ json.NewsList[i].kb_title + "</strong>";
					template += "		<span class=\"thumb\"><img src=\"http://storage.enuri.info/pic_upload/main/news/"+ json.NewsList[i].mn_img +"\" onerror=\"fn_err_img(this);\" /></span>";
				}else{
					template += "	<li>";
					template += "		<a href=\"javascript:///\" onclick=\"kb_view("+ json.NewsList[i].kb_no +",'2')\" ><strong>"+ json.NewsList[i].kb_title + "</strong>";
				}
				template += "		<span class=\"date\"><em>"+ (json.NewsList[i].kb_regdate).substring(0,10) +"</em>";
				if(json.NewsList[i].kb_readcnt >= 200){
					template += "		<em>조회수 : "+ commaNum(json.NewsList[i].kb_readcnt) +"</em>";
				}	
				template += "		</span>";
				if(fn_filterChk(removeHtml(json.NewsList[i].kb_content))){
					template += "	<span class=\"txt\">▶ 상세내용 보러가기</span>";
				}else{
					template += "	<span class=\"txt\">"+json.NewsList[i].kb_content+"</span>";
				}
				template += "	</a></li>";
			}
		}
		$("#cate02").append(template);
	}
}

function getNewsListBottom(jsondata,cnt){	
	var json = jsondata;
	var maxCnt;

	if(json){
		var template = "";
		if(json.NewsList.length < cnt){
			maxCnt = json.NewsList.length;
			$(".btm02").hide();
		}else{
			maxCnt = cnt;
		}
		
		for(var i=cnt-20;i<maxCnt;i++){
			//위 리스트와 같은 지 체크
			var validYn = true;
			for(var j=0; j<jsonNews.length; j++){
				if(json.NewsList[i].kb_no == jsonNews[j].kb_no){
					validYn = false;
				}
			}
			
			if(validYn){
				if(json.NewsList[i].mn_img && json.NewsList[i].mn_img.length > 0){
					template += "	<li class=\"news_pic\">";
					template += "		<a href=\"javascript:///\" onclick=\"kb_view("+ json.NewsList[i].kb_no +",'2')\" ><strong>"+ json.NewsList[i].kb_title + "</strong>";
					template += "		<span class=\"thumb\"><img src=\"http://storage.enuri.info/pic_upload/main/news/"+ json.NewsList[i].mn_img +"\" onerror=\"fn_err_img(this);\" /></span>";
				}else{
					template += "	<li>";
					template += "		<a href=\"javascript:///\" onclick=\"kb_view("+ json.NewsList[i].kb_no +",'2')\" ><strong>"+ json.NewsList[i].kb_title + "</strong>";
				}
				template += "		<span class=\"date\"><em>"+ (json.NewsList[i].kb_regdate).substring(0,10) +"</em>";
				if(json.NewsList[i].kb_readcnt >= 200){
					template += "		<em>조회수 : "+ commaNum(json.NewsList[i].kb_readcnt) +"</em>";
				}	
				template += "		</span>";
				if(fn_filterChk(removeHtml(json.NewsList[i].kb_content))){
					template += "	<span class=\"txt\">▶ 상세내용 보러가기</span>";
				}else{
					template += "	<span class=\"txt\">"+json.NewsList[i].kb_content+"</span>";
				}
				template += "	</a></li>";
			}
		}
		
		$("#cate02").append(template);	
	}	
}

function getGuide_list(){
	var json = json_guide_bottom_list;
	var cnt;
	
	if(json.NewsList){
		var template = "";
		if(json.NewsList.length < 20){
			cnt = json.NewsList.length;
		}else{
			cnt = 20;
		}

		for(var i=0;i<cnt;i++){
			//위 리스트와 같은 지 체크
			var validYn = true;
			for(var j=0; j<jsonGuide.length; j++){
				if(json.NewsList[i].kb_no == jsonGuide[j].kb_no){
					validYn = false;
				}
			}
			
			if(validYn){
				if(!(json.NewsList[i].img_yn == '1' 
					&& json.NewsList[i].date50 == '1')){
					if(json.NewsList[i].img_yn == '1'){
						template += "<li class=\"news_pic\">";
					}else{
						template += "<li>";
					}
					template += "		<a href=\"javascript:///\" onclick=\"kb_view("+ json.NewsList[i].kb_no +", '1')\" ><strong>"+ json.NewsList[i].kb_title + "</strong>";
					
					//이미지 있는경우 노출
					if(json.NewsList[i].img_yn == '1'){
						template += "	<span class=\"thumb\"><img src=\"http://storage.enuri.info/pic_upload/enurinews_mobile/"+ json.NewsList[i].mo_img2 +"\" onerror=\"fn_err_img(this);\" /></span>";
					}
					
					template += "		<span class=\"date\"><em>"+ (json.NewsList[i].kb_regdate).substring(0,10) +"</em>";
					if(json.NewsList[i].kb_readcnt >= 200){
						template += "		<em>조회수 : "+ commaNum(json.NewsList[i].kb_readcnt) +"</em>";
					}	
					template += "		</span>";
					if(fn_filterChk(removeHtml(json.NewsList[i].kb_content))){
						template += "	<span class=\"txt\">▶ 상세내용 보러가기</span>";
					}else{
						template += "	<span class=\"txt\">"+json.NewsList[i].kb_content+"</span>";
					}
					template += "	</a></li>";
				}
			}
		}
		$("#cate01").append(template);
	}
}


function getGuideListBottom(jsondata,cnt){	
	var json = jsondata;
	var maxCnt;

	if(json){
		var template = "";
		if(json.NewsList.length < cnt){
			maxCnt = json.NewsList.length;
			$(".btm01").hide();
		}else{
			maxCnt = cnt;
		}
		
		for(var i=cnt-20;i<maxCnt;i++){
			//위 리스트와 같은 지 체크
			var validYn = true;
			for(var j=0; j<jsonGuide.length; j++){
				if(json.NewsList[i].kb_no == jsonGuide[j].kb_no){
					validYn = false;
				}
			}
			
			if(validYn){
				if(!(json.NewsList[i].img_yn == '1' 
					&& json.NewsList[i].date50 == '1')){
					if(json.NewsList[i].img_yn == '1'){
						template += "<li class=\"news_pic\">";
					}else{
						template += "<li>";
					}
					template += "		<a href=\"javascript:///\" onclick=\"kb_view("+ json.NewsList[i].kb_no +", '1')\" ><strong>"+ json.NewsList[i].kb_title + "</strong>";
					
					//이미지 있는경우 노출
					if(json.NewsList[i].img_yn == '1'){
						template += "	<span class=\"thumb\"><img src=\"http://storage.enuri.info/pic_upload/enurinews_mobile/"+ json.NewsList[i].mo_img2 +"\" onerror=\"fn_err_img(this);\" /></span>";
					}
					
					template += "		<span class=\"date\"><em>"+ (json.NewsList[i].kb_regdate).substring(0,10) +"</em>";
					if(json.NewsList[i].kb_readcnt >= 200){
						template += "		<em>조회수 : "+ commaNum(json.NewsList[i].kb_readcnt) +"</em>";
					}	
					template += "		</span>";
					if(fn_filterChk(removeHtml(json.NewsList[i].kb_content))){
						template += "	<span class=\"txt\">▶ 상세내용 보러가기</span>";
					}else{
						template += "	<span class=\"txt\">"+json.NewsList[i].kb_content+"</span>";
					}
					template += "	</a></li>";
				}
			}
		}
		$("#cate01").append(template);	
	}	
}


function getReview_list(){
	var json = json_review;
	var cnt;
	
	if(json.NewsList){
		var template = "";
		if(json.NewsList.length < 20){
			cnt = json.NewsList.length;
		}else{
			cnt = 20;
		}

		for(var i=0;i<cnt;i++){
			//위 리스트와 같은 지 체크
			var validYn = true;
			for(var j=0; j<jsonReview.length; j++){
				if(json.NewsList[i].kb_no == jsonReview[j].kb_no){
					validYn = false;
				}
			}
			
			if(validYn){
				if(json.NewsList[i].kb_thumbnail_img && json.NewsList[i].kb_thumbnail_img.length > 0) {
					template += "<li class=\"news_pic\">";
				}else{
					template += "<li>";
				}
				template += "		<a href=\"javascript:///\" onclick=\"kb_view("+ json.NewsList[i].kb_no +", '3')\" ><strong>"+ json.NewsList[i].kb_title + "</strong>";
				
				if(json.NewsList[i].kb_thumbnail_img && json.NewsList[i].kb_thumbnail_img.length > 0) {
					template += "	<span class=\"thumb\"><img src=\"http://storage.enuri.info/pic_upload/enurinews_thumbnail/"+ json.NewsList[i].kb_thumbnail_img +"\" onerror=\"fn_err_img(this);\" /></span>";
				}	
				
				template += "		<span class=\"date\"><em>"+ (json.NewsList[i].kb_regdate).substring(0,10) +"</em>";
				if(json.NewsList[i].kb_readcnt >= 200){
					template += "		<em>조회수 : "+ commaNum(json.NewsList[i].kb_readcnt) +"</em>";
				}	
				template += "		</span>";
				if(fn_filterChk(removeHtml(json.NewsList[i].kb_content))){
					template += "	<span class=\"txt\">▶ 상세내용 보러가기</span>";
				}else{
					template += "	<span class=\"txt\">"+json.NewsList[i].kb_content+"</span>";
				}
				template += "	</a></li>";
			}
		}
		$("#cate03").append(template);
	}
}


function getReviewListBottom(jsondata,cnt){	
	var json = jsondata;
	var maxCnt;

	if(json){
		var template = "";
		if(json.NewsList.length < cnt){
			maxCnt = json.NewsList.length;
			$(".btm03").hide();
		}else{
			maxCnt = cnt;
		}
		
		for(var i=cnt-20;i<maxCnt;i++){
			//위 리스트와 같은 지 체크
			var validYn = true;
			for(var j=0; j<jsonReview.length; j++){
				if(json.NewsList[i].kb_no == jsonReview[j].kb_no){
					validYn = false;
				}
			}
			
			if(validYn){
				if(json.NewsList[i].kb_thumbnail_img && json.NewsList[i].kb_thumbnail_img.length > 0) {
					template += "<li class=\"news_pic\">";
				}else{
					template += "<li>";
				}
					
				template += "		<a href=\"javascript:///\" onclick=\"kb_view("+ json.NewsList[i].kb_no +", '3')\" ><strong>"+ json.NewsList[i].kb_title + "</strong>";
					
				//이미지 있는경우 노출
				if(json.NewsList[i].kb_thumbnail_img && json.NewsList[i].kb_thumbnail_img.length > 0) {
					template += "	<span class=\"thumb\"><img src=\"http://storage.enuri.info/pic_upload/enurinews_thumbnail/"+ json.NewsList[i].kb_thumbnail_img +"\" onerror=\"fn_err_img(this);\" /></span>";
				}	
				
				template += "		<span class=\"date\"><em>"+ (json.NewsList[i].kb_regdate).substring(0,10) +"</em>";
				if(json.NewsList[i].kb_readcnt >= 200){
					template += "		<em>조회수 : "+ commaNum(json.NewsList[i].kb_readcnt) +"</em>";
				}	
				template += "		</span>";
				if(fn_filterChk(removeHtml(json.NewsList[i].kb_content))){
					template += "	<span class=\"txt\">▶ 상세내용 보러가기</span>";
				}else{
					template += "	<span class=\"txt\">"+json.NewsList[i].kb_content+"</span>";
				}
				template += "	</a></li>";
			}
		}
		$("#cate03").append(template);	
	}	
}

function fn_err_img(img){
	var _this = img;
	_this.style.display='none';
	$(img).parents("li").removeClass("news_pic");
} 

function kb_view(kbno, param){
	
	if(param == 1){
		ga('send', 'event', 'mf_lp_Info_Ad_contents_more', 'click_contents', 'contents_가이드_'+kbno);
		window.open("news_detail.jsp?freetoken=eventclone&strpop=N&kbno="+kbno+"&from=guide&verios="+vVerios);
	}else if(param == 2){
		ga('send', 'event', 'mf_lp_Info_Ad_contents_more', 'click_contents', 'contents_뉴스_'+kbno);
		window.open("news_detail.jsp?freetoken=eventclone&strpop=N&kbno="+kbno+"&verios="+vVerios);
	}else if(param == 3){
		ga('send', 'event', 'mf_lp_Info_Ad_contents_more', 'click_contents', 'contents_리뷰_'+kbno);
		window.open("news_detail.jsp?freetoken=eventclone&strpop=N&kbno="+kbno+"&from=review&verios="+vVerios);
	}
	
	return;   
}

function fn_filterChk(name){
	var chktext = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
	//정규식 구문
	var obj = name;
	if (chktext.test(obj)) {
		return false;
	}
	return true;
}

function removeHtml(obj){
	var tmpStr = new RegExp();
	tmpStr = /[<][^>]*[>]/gi;
	return obj.replace(tmpStr,"");
}

</script>
<%@ include file="/mobilefirst/include/common_logger.html"%>