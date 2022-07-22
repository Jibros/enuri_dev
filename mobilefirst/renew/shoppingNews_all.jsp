<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
Cookie[] carr = request.getCookies();
String strAppyn = "";
String strVerios = "";
String strType= ChkNull.chkStr(request.getParameter("type"),"");	
String strAppyn2 = ChkNull.chkStr(request.getParameter("app"),"");	

String strTip_no = ChkNull.chkStr(request.getParameter("tipno"),"01");	

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
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/default.css" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/trend.css"/>
	<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script>
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

	<section class="news news_link">
		<div class="newsbox"> 
			<h2>카테고리별 핫뉴스<a href="#" class="ico_m">창닫기</a></h2>
			<ul class="cate_new">
				<li id="tip_head_01" class="tip_btt" cate="01" class="on" tit="디지털/가전">디지털/가전</li>
				<li id="tip_head_02" class="tip_btt" cate="02" tit="컴퓨터">컴퓨터</li>
				<li id="tip_head_03" class="tip_btt" cate="03" tit="스포츠/자동차">스포츠/자동차</li>
				<li id="tip_head_04" class="tip_btt" cate="04" tit="유아/라이프">유아/라이프</li>
			</ul>

			<ul class="hotnews" id="cate_01" style="display:none"></ul>
			<ul class="hotnews" id="cate_02" style="display:none"></ul>
			<ul class="hotnews" id="cate_03" style="display:none"></ul>
			<ul class="hotnews" id="cate_04" style="display:none"></ul>
			<ul class="hotnews" id="cate_05" style="display:none"></ul>
		</div>
	</section>
</div>	

</body>
</html>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
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
var json_list;
var vHash = window.location.hash;

var vTip_no_now = "<%=strTip_no%>";

var json_base = (function() {
    var json = null;
    $.ajax({
        'async': false,
        'global': false,
        'url': "/mobilefirst/api/main/newsTab_all.jsp",
        'dataType': "json",
        'success': function (data) {
            json = data; 
        }
    });
    return json;
})();

$(function() {

    $("body").on('touchend', function(e) {
        if (window.android && android.onTouchEnd) {
            window.android.onTouchEnd();
        } else if ($("#ios").val()) {

        }
    });
    
	$(".cate_new > li").click(function(){
		var vThis = $(this).attr("cate");
		var vTitle = $(this).attr("tit");

		$(".tip_btt").removeClass("on");
		$(this).addClass("on");
		vTip_no_now = $(this).attr("cate");

		$(".hotnews").hide();
		$("#cate_"+vTip_no_now).show();
		$(window).scrollTop(0);
		fnGa('mf_쇼핑뉴스','click_전체보기','전체보기_'+vTitle);
		// 동적인 이미지 호출
		$(".lazy_"+vTip_no_now).lazyload({
	        effect: 'fadeIn',
	        effectTime : 500
	    });
	});

	vHash = window.location.hash;
	
	if(vAppyn != "Y"){
		$(".m_top").show();
	}else{
		$(".m_top").hide();
	} 

	$(".ico_m").click(function(){
		fnGa('mf_쇼핑뉴스','click_전체보기','전체보기_닫기');
		location.href ="/mobilefirst/index.jsp#3";
	});

	getLlist();
    // 동적인 이미지 호출
	$(".lazy_"+vTip_no_now).lazyload({
        effect: 'fadeIn',
        effectTime : 500
    });

});

function fnGa(pCate,pAction,pLabel){
	ga('send', 'event', pCate, pAction, pLabel);	
}

function setImg(mo_img,mo_img2,rss_thumbnail){
	var vRtn_img = "";
	
	if(mo_img != ""){
		vRtn_img = mo_img;
	}else if(mo_img2 != ""){
		vRtn_img = mo_img2;
	}else if(rss_thumbnail != ""){
		vRtn_img = rss_thumbnail;
	}
	return vRtn_img;
}

function getLlist(){
    var template = "";
	var json_list = json_base.category_tip;
    
    if(json_list.length > 0){
        for(var i = 0;i<json_list.length;i++){
            var vCategory_name = json_list[i].category_name;
            var vTip_no = json_list[i].tip_no;
			var vList = json_list[i].list;

			if(vList.length > 0){
				for(var j=0;j<vList.length;j++){
					var vTmpImg = setImg(vList[j].mo_img,vList[j].mo_img2,vList[j].rss_thumbnail);
					
					template += "<li class=\"tiplist tip_"+ vTip_no +"\" onclick=\"fnGa('mf_쇼핑뉴스','click_전체보기','전체보기_"+ vList[j].kbno +"');show_detail('"+ vList[j].url +"');\">";
					if(vTmpImg != ""){
						if(j<10){
							template += "<span class=\"thum\"><img class=\"lazy_"+ vTip_no +"\" src=\""+ vTmpImg +"\" data-original=\"\" alt=\"\" /></span>";						
						}else{
							template += "<span class=\"thum\"><img class=\"lazy_"+ vTip_no +"\" src=\"http://imgenuri.enuri.gscdn.com/images/m_home/noimg.png\" data-original=\""+ vTmpImg +"\" alt=\"\" /></span>";						
						}
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
				$("#cate_"+vTip_no).html(template);
				template = "";
			}
			
        }
        $("#tip_head_"+vTip_no_now).addClass("on");
        $("#cate_"+vTip_no_now).show();

    }
}

function setMmdd(date){
	var mm = date.substring(0,2);
	var dd = date.substring(3,5);

	return parseInt(mm) + "월 " + parseInt(dd) + "일";
}

function show_detail(url){
	location.href=url;
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