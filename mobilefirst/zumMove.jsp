<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<jsp:useBean id="Pricelist_Data" class="com.enuri.bean.main.Pricelist_Data" scope="page" />
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc" scope="page" />
<%
int intModelno = ChkNull.chkInt(request.getParameter("modelno"), 0);

cb.setCookie_One("FROM", "zum");
cb.SetCookieExpire("FROM",-1);
cb.responseAddCookie(response);

String strUrl = "";

if (intModelno > 0){
	strUrl = "/mobilefirst/detail.jsp?modelno="+intModelno+"&from=zum";
} else {
	out.print("<script>alert('상품정보가 없습니다.');location.href='/mobilefirst/index.jsp';</script>");
}
%>
<!DOCTYPE html> 
<html lang="ko"> 
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" /> 
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	//런칭할때 UA-52658695-3 으로 변경
	ga('create', 'UA-52658695-3', 'auto');
	</script> 
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/default.css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/move.css">
</head> 
<body>
	<div class="move_wrap">
	    <div class="zum">
	        <img src="<%=ConfigManager.IMG_ENURI_COM%>/images/board/big/logo_zum.gif" alt="zum" />
	        <span class="txt_move">에서 알려드립니다.</span>
	    </div>
	    <div class="bar_area">로딩중</div>
	    <div class="btn_mv">
	    	<a href="javascript:void(0);"  id="move_stop" onclick="changeImgNew('stop');" class="stop" title="쇼핑몰이동 멈춤">일시정지</a>
	    	<a href="javascript:void(0);" id="move_start" onclick="changeImgNew('start');" class="play" title="쇼핑몰이동">play</a>
	    </div>
	    <div class="guide_area"><span class="txt">쇼핑몰에서 <b>정확한 가격과 상품정보를 꼭 확인</b>하세요!</span></div>
		<dl class="notice">
	        <dd><span>1.</span>줌닷컴 쇼핑검색 서비스는 "에누리"를 운영하는 ㈜써머스플랫폼의 데이터 제공으로 이루어집니다.</dd>
	        <dd><span>2.</span>"에누리"와 쇼핑몰의 상품정보, 가격이 일치하지 않을 수 있습니다. <u class="red underline">쇼핑몰 이동 후 반드시 상품정보 및 가격을 다시 한번 확인하세요.</u></span></dd>
	        <dd><span>3.</span>"에누리"를 운영하는 (주)써머스플랫폼은 통신판매 정보제공자로<b class="red"> 상품의 주문/배송/환불에 대한 의무와 책임은 각 쇼핑몰(판매자)에게 있습니다.</b></dd>
	        <dd><span>4.</span>안전한 구매를 위해 안전거래(에스크로,전자 보증 등)를 통해 구매하시기 바랍니다.</dd>
	        <dd><span>5.</span>쇼핑몰 이동 후 할인쿠폰이 있을 경우,쿠폰 다운받기 하신 후 결제 단계에서 적용해야 해당 가격으로 구매 가능합니다.</dd>
	    </dl>
	</div>
</body>
</html>
<script language="javascript">
$(function() {
	if("<%=strUrl %>" != ""){
		varMoveTimer = setTimeout("CmdGoLink()", 1000);
	}
});	

var varMoveTimer;

function changeImgNew(flag) {
	if(flag == 'stop'){
		$('.bar_area').addClass("stop");
        clearInterval(varMoveTimer);
    } else {
    	if($('.bar_area').hasClass("stop")){             // 멈춰 있으면.
            $('.bar_area').removeClass("stop");
        }
        goAfter2Second();
    }
}
	    
function goAfter2Second(){
    <%if(!request.getServerName().equals("stagedev.enuri.com")){%>
    varMoveTimer = self.setTimeout("CmdGoLink()", 1000);
    <%}%>
}

function CmdGoLink(){
    location.href = "<%=strUrl%>";
}

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
    }
    return "";
}
</script>