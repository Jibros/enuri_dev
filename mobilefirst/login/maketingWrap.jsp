<%@ page contentType="text/html; charset=utf-8" %>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%
	
	String css = "";
	String cssType = StringUtils.defaultString(request.getParameter("cssType"),"");
	
	if(cssType.contains("mobiledepart")){
		css = "mobiledepart";
	}else if(cssType.contains("mobiledeal")){
		css = "mobiledeal";
	}else{
		css = "agreeWrap";
	}

%>


<!DOCTYPE html> 
<html lang='ko'> 
<head> 
   <meta charset='utf-8'>	
   <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi'>	
   <meta property='og:title' content='에누리 가격비교'> 
   <meta property='og:description' content='에누리 모바일 가격비교'> 
   <meta property='og:image' content='http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png'> 
   <meta name='format-detection' content='telephone=no'>
   <link rel='stylesheet' type='text/css' href='/mobilefirst/css/default.css'> 
   <link rel='stylesheet' type='text/css' href='/mobilefirst/css/gnb.css'>
   <link rel='stylesheet' type='text/css' href='/mobilefirst/css/footer.css'>  
   <script type='text/javascript' src='/mobilenew/js/lib/jquery-2.1.1.min.js'></script> 
   <script type='text/javascript' src='/mobilefirst/js/gnbCurtCateMenu.js'></script> 
</head> 
<body>

	<div id="termsWrap" class="agreeWrap <%=css%>" name="termsWrap">
		<section class="agreeSection">
			<div class="pageHead">
				<h1>개인정보 마케팅 및 광고 이용</h1>
			</div>
			<div class="container">
				<div class="agreeBox">
					아래 목적을 위한 용도로 개인정보를 수집 및 활용할 수 있습니다.<br>
					- 마케팅 및 광고에 활용하고, 신규 서비스(제품) 개발 및 특화 <br>&nbsp;&nbsp;&nbsp이벤트 등 광고성 정보를 전달<br>
					- 인구통계학적 특성에 따른 서비스 제공 및 광고 게재<br>
					- 접속 빈도 파악 또는 회원의 서비스 이용에 대한 통계 등을 위함<br>
				 </div>
			<button type="button" class="btnClose" onclick='backButton();'>레이어팝업 닫기</button>
		</section>
	</div>

</body>
<%@ include file="/mobilefirst/include/common_logger.html"%>
</html>
<script language="javascript">
function backButton(){
	
	var iOS = /(iPad|iPhone|iPod)/g.test( navigator.userAgent );
	
	if(getCookie("appYN") == 'Y' ){
		location.href = "close://"
	}else{
		window.close();
	}
		
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