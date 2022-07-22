<%@page import="com.enuri.bean.member.Login_Proc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.main.Shoplist_Data"%>
<%@ page import="com.enuri.bean.main.Shoplist_Proc"%>
<jsp:useBean id="Shoplist_Data" class="com.enuri.bean.main.Shoplist_Data"  />
<jsp:useBean id="Shoplist_Proc" class="com.enuri.bean.main.Shoplist_Proc"  />
<%@ include file="/move/tempid.jsp"%>
<%
int szVcode				= ChkNull.chkInt(request.getParameter("vcode"),0);
String strUrl				= ChkNull.chkStr(request.getParameter("url"),"");
String strFrom				= ChkNull.chkStr(request.getParameter("from"),"");

String strId = cb.GetCookie("MEM_INFO","USER_ID");
 
try{	//전체오류나면 그냥 URL 센딩.

Shoplist_Data sdata    = Shoplist_Proc.getData_One(szVcode);

String strShopName     = sdata.getShop_name();
String strApFlag       = sdata.getApflag();
String strEtcLogo      = sdata.getEtclogo();
String strCpc_flag     = sdata.getCpc_flag();

String strShopLogo = "";

if(strEtcLogo.trim().equals("Y")) {
   strShopLogo = "<img src=\""+ConfigManager.STORAGE_ENURI_COM+"/logo/logo20/logo_20_"+szVcode+".png\" onerror=\"$(this).replaceWith('"+strShopName+"')\">";
} else {
    strShopLogo = "<span class=\"noimg\">" + strShopName + "</span>";
}


String euserkey = "";
Login_Proc login_Proc = new Login_Proc();
if(  !"".equals(strId)  ){
	
	if( "6641".equals(szVcode+"")  ){ //티몬
		//if( "wiseroh".equals(cUserId) ||  "toodoo".equals(cUserId) ){
		euserkey = login_Proc.getUsrMtcEnc(strId);
	}else if( "7943".equals(szVcode+"")  ){
		euserkey = login_Proc.getUsrMtcEnc(strId);
	}
}

if(strUrl.length() == 0) strUrl = Shoplist_Proc.getData_One_Url(szVcode, "m");
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
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/default.css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/move.css?v=20180913">
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
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


<div class="move_wrap">
    <div class="mall">
       <%=strShopLogo %>
        <span class="txt_move">쇼핑몰로 이동중 입니다.</span>
    </div>
    <div class="bar_area">로딩중</div>
    <div class="btn_mv">
    	<a href="javascript:void(0);" class="stop" title="쇼핑몰이동 멈춤">일시정지</a>
  		<a href="javascript:void(0);" class="play" title="쇼핑몰이동">play</a></div>
    <div class="guide_area"><span class="txt">쇼핑몰에서 <b>정확한 가격과 상품정보를 꼭 확인</b>하세요!</span></div>
	<dl class="notice">
        <dd><span>1.</span>"에누리"와 쇼핑몰의 상품정보, 가격이 일치하지 않을 수 있습니다. <em class="red">쇼핑몰 이동 후 반드시 상품정보 및 가격을 다시 한번 확인하세요.</span></dd>
        <dd><span>2.</span>"에누리"를 운영하는 (주)써머스플랫폼은 통신판매 정보제공자로<em class="red">상품의 주문/배송/환불에 대한 의무와 책임은 각 쇼핑몰(판매자)에게 있습니다.</em></dd>
        <dd><span>3.</span>안전한 구매를 위해 안전거래(에스크로,전자 보증 등)를 통해 구매하시기 바랍니다.        </dd>
        <dd><span>4.</span>쇼핑몰 이동 후 할인쿠폰이 있을 경우,쿠폰 다운받기 하신 후 결제 단계에서 적용해야 해당 가격으로 구매 가능합니다.</dd>
    </dl>
</div>

</body>
</html>

<script>

var varMoveTimer;

$(function() {
	if("<%=strUrl %>" != ""){
		//viewCatchIcon();
		varMoveTimer = setTimeout("redirect_url()", 1000);
		
	}
	ga('send', 'pageview', {
		'page': '/mobilefirst/move2.jsp',
		'title': 'mf_화면이동_<%=szVcode %>'
	}); 
	$(".stop").on("click",function(){
	    clearInterval(varMoveTimer);
	});
	$(".play").on("click",function(){
		varMoveTimer = setTimeout("redirect_url()", 1000);
	});
});

function redirect_url(){
	
	if( "7943" == "<%=szVcode%>" || "6641" == "<%=szVcode%>" ){ //에누리PC //티몬
		
		<% if(!"".equals(euserkey) ){ %>
			location.href = "<%=strUrl %>&euserkey=<%=euserkey%>";
			return false;
		<%}else{%>
			location.href = "<%=strUrl %>";
			return false;
		<%}%>
		
	}else{
		location.href = "<%=strUrl %>";
		return false;
	}
}
</script>

<%
}catch(Exception e){
	response.sendRedirect(strUrl);
}
%>