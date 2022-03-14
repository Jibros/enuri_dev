<%@ page contentType="text/html; charset=utf-8"%>
<%@include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
	String chkId = ChkNull.chkStr(request.getParameter("chk_id"));
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">
<meta property="og:title" content="에누리 가격비교">
<meta property="og:description" content="에누리 모바일 가격비교">
<meta property="og:image"
	content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" type="text/css"
	href="http://m.enuri.com/mobilefirst/css/default.css">
<script type="text/javascript"
	src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
</head>
<body style="background:#000000 !important; margin: 0;">
	<div id="wrap"  >

		<ul class="eventlist">
	
		</ul>
		
	</div>

</body>
</html>

<script language="javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	//런칭할때 UA-52658695-3 으로 변경
	ga('create', 'UA-52658695-3', 'auto');

function isiPhone(){
    return (
        //Detect iPhone
        (navigator.platform.indexOf("iPhone") != -1) ||
        //Detect iPod
        (navigator.platform.indexOf("iPod") != -1) ||
        //Detect iPod
        (navigator.platform.indexOf("iPad") != -1)
    );
}
$(function() {	

	$.getJSON( "/mobilefirst/http/json/banner_list.json", function(json) {
		if(json.appFrontPop.banner){	           
			var topJson=null,bottomJson=null,centerJson=null;
			//top 배너
			$.each(json.appFrontPop.banner, function(i, v){
				var sdate = replaceAll(v.sdate,"-" ,"/"); 
				sdate = new Date(sdate);
				
				var edate = replaceAll(v.edate,"-" ,"/");
				edate = new Date(edate);
				
				if(dateComparison(sdate,edate)){	                    
					if(v.location =='top')
						topJson = v;
					if(v.location =='bottom')
						bottomJson = v;
					if(v.location=='all')
						centerJson = v;
				}
			});
		         
			/*if(!(topJson &&bottomJson))
			{
			   window.location.href = "close://";		   
			   return;
			}*/
			var strHtml = "";
			strHtml +=	"<a onclick=\"goClose()\" class=\"close\" style=\"position:absolute; right:10px; top:10px; background: url(http://imgenuri.enuri.com/images/event/2016/super/btn_lyclose.png) 0 0 no-repeat; background-size:36px 36px; width:36px; height:36px; text-indent: -9999em;\">닫기</a>"
			if(topJson)
				strHtml = "<li><img src=\""+topJson.img+"\" width=\"100%\"  id=\"btntop\"></li>";	  
			if(bottomJson)
				strHtml += "<li><img src=\""+bottomJson.img+"\" width=\"100%\"  id=\"btnbottom\"></li>";	
			if(centerJson)
				strHtml += "<li><img src=\""+centerJson.img+"\" width=\"100%\"  id=\"btncenter\"></li>";	
			

			$(".eventlist").html(strHtml);
			
			$("#btntop").click(function(){
				ga('send','event','mf_event',topJson.name,'이동');			
				if(isiPhone())
					location.href =topJson.link;
				else	
					location.href =topJson.link;
			});
			$("#btnbottom").click(function(){
				ga('send','event','mf_event',bottomJson.name,'이동');			
				if(isiPhone())
					location.href =bottomJson.link;
				else 
					location.href =bottomJson.link;			
			});
			$("#btncenter").click(function(){
				ga('send','event','mf_event',centerJson.name,'이동');			
				if(isiPhone())
					location.href =centerJson.link;
				else 
					location.href =centerJson.link;			
			});
			

			if(bottomJson)
  				$('body').parent().css('background-color', bottomJson.bgcolor);
			if(centerJson)

				$('body').parent().css('background-color', centerJson.bgcolor);
			
		}
	});
	// var a = getParameterByName("verios");
// 	if(a)
// 		alert(">>"+Number(a.split(".").join("")));
});
  function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

function replaceAll(str, searchStr, replaceStr) {

    return str.split(searchStr).join(replaceStr);
}
function dateComparison(sdate , edate){
    var nowDate = new Date();
    var result = false;
    if(sdate < nowDate && edate > nowDate){
        result = true; 
    }
    return result; 
}

function goClose(){
	ga('send','event','mf_event','닫기','이동');
	window.location.href = "close://";
}
</script>