<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
int intModelno = ChkNull.chkInt(request.getParameter("modelno"),0);
long lngPlno = ChkNull.chkLong(request.getParameter("plno"),0);
int intInstanceprice = ChkNull.chkInt(request.getParameter("instanceprice"),0);

%>
<!DOCTYPE html> 
<html lang="ko"> 
<head>
	<meta charset="utf-8">	 
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
	<meta http-equiv="Cache-Control" Content="no-cache" />
	<meta http-equiv="Pragma" Content="no-cache" />
	<meta http-equiv="Expires" Content="0" />
	<meta property="og:title" content="에누리 가격비교">
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
</head>
<body>
<!-- WIDERPLANET PURCHASE SCRIPT START 2015.7.21 -->
<div id="wp_tg_cts" style="display:none;"></div>
<script type="text/javascript">
var wptg_tagscript_vars = wptg_tagscript_vars || [];
wptg_tagscript_vars.push(
(function() {
	return {
		wp_hcuid:"",
		ti:"22262",            	     /*광고주 코드*/
		ty:"PurchaseComplete",       /*트래킹태그 타입*/
		device:"mobile",             /*디바이스 종류 (web 또는 mobile)*/
		items:[{i:<%=intModelno %>,         /*전환 식별코드 (한글, 영문, 숫자, 공백 허용)*/
			t:<%=lngPlno %>,         /*전환명 (한글, 영문, 숫자, 공백 허용)*/
			p:<%=intInstanceprice %>,		     /*전환가격 (전환 가격이 없을경우 1로 설정)*/
			q:"1"		     /*전환수량 (전환 수량이 고정적으로 1개 이하일 경우 1로 설정)*/
		}]
	};
}));
</script>
<script type="text/javascript" src="//astg.widerplanet.com/js/wp_astg_4.0.js"></script>
<!-- // WIDERPLANET PURCHASE SCRIPT END 2015.7.21 -->
</body>
</html>