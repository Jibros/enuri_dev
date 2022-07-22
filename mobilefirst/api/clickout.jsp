<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
	String strUserip = request.getRemoteAddr(); 
	int intShopcode = ChkNull.chkInt(request.getParameter("shopcode"),0);
	String strShopnm = ChkNull.chkStr(request.getParameter("shopnm"),"");
	
	if("11번가".equals(strShopnm)){intShopcode = 5910;}
	if("G마켓".equals(strShopnm)){intShopcode = 536;}
	if("G9".equals(strShopnm)){intShopcode = 7692;}
	if("옥션".equals(strShopnm)){intShopcode = 4027;}
	if("인터파크".equals(strShopnm)){intShopcode = 55;}
	if("이마트".equals(strShopnm)){intShopcode = 374;}
	if("신세계몰".equals(strShopnm)){intShopcode = 47;}
	if("SSG.COM".equals(strShopnm)){intShopcode = 6665;}
	if("GS쇼핑".equals(strShopnm)){intShopcode = 75;}
	if("위메프".equals(strShopnm)){intShopcode = 6508;}
	if("티켓몬스터".equals(strShopnm)){intShopcode = 6641;}
	if("CJ몰".equals(strShopnm)){intShopcode = 806;}
	if("현대아이몰".equals(strShopnm)){intShopcode = 57;}
	if("AK몰".equals(strShopnm)){intShopcode = 90;}
	if("하이마트".equals(strShopnm)){intShopcode = 6252;}
	if("갤러리아".equals(strShopnm)){intShopcode = 6620;}
	if("OKMALL".equals(strShopnm)){intShopcode = 6427;}
	if("ns홈쇼핑".equals(strShopnm)){intShopcode = 974;}
	if("홈플러스".equals(strShopnm)){intShopcode = 6361;}
	if("롯데마트".equals(strShopnm)){intShopcode = 7455;}
	if("롯데닷컴".equals(strShopnm)){intShopcode = 49;}
	if("롯데아이몰".equals(strShopnm)){intShopcode = 663;}
	if("엘롯데".equals(strShopnm)){intShopcode = 6547;}
	if("홈엔쇼핑".equals(strShopnm)){intShopcode = 6588;}
	if("쿠팡".equals(strShopnm)){intShopcode = 6640;}
	
	out.print(strShopnm+intShopcode);
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
	<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		//런칭할때 UA-52658695-3 으로 변경
		ga('create', 'UA-52658695-3', 'auto');
	</script>
</head>
<body></body></html>
<script language="javascript">
$(function() {
	//app(aos,ios), web 구분
	var shopcode = "<%=intShopcode %>";
	var vTmp_Appyn = $.cookie("appYN");

	if(vTmp_Appyn == "Y"){
		var ua = navigator.userAgent.toLowerCase();
		var isAndroid = ua.indexOf("android") > -1;
		
		if(isAndroid) {
			ga('send', 'event', 'mf_buy', 'Nufari_click_AOS앱' ,  'buy_'+shopcode);	
		}else{
			ga('send', 'event', 'mf_buy', 'Nufari_click_IOS앱' ,  'buy_'+shopcode);
		}
	}else{
		ga('send', 'event', 'mf_buy', 'Nufari_click_웹' ,  'buy_'+shopcode);
	}
});

</script>