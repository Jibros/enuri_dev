<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
//스마트쇼핑 from=st 처리
	String strfrom = ChkNull.chkStr(request.getParameter("from"),"");
	if(strfrom.equals("swt")){
		cb.setCookie_One("FROM",strfrom);
		cb.SetCookieExpire("FROM",-1);
		cb.responseAddCookie(response);
	}
%>
<!DOCTYPE html>
<html lang='ko'>
<head>
   <meta charset="utf-8"/>
	<meta http-equiv="x-ua-compatible" content="ie=edge"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
	<meta property="og:title" content="에누리 가격비교">
    <meta property="og:description" content="에누리 모바일 가격비교">
    <meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no"/>
	<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
	<link rel="stylesheet" type="text/css" href="/css/mobile_v2/common.css"/>
    <link rel="stylesheet" type="text/css" href="/css/mobile_v2/cs.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
    <script type="text/javascript" src="/js/swiper.min.js"></script>   <!-- <script type='text/javascript' src='/mobilefirst/js/gnbCurtCateMenu.js'></script> -->
 	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.tmpl.min.js"></script>
</head>
<body>

<!-- 140805 수정 -->
	<div id="wrap">

		<!-- 타입D (닫기) -->
	    <header id="header" class="m_header head__type_d">
	        <div class="header_wrap">
	            <h1 class="m_txt">법적고지</h1>
	            <button class="btn_hd_back comm__sprite" onclick='backButton()'>뒤로</button>
	            <button class="btn_hd_close comm__sprite" onclick='backButton()'>닫기</button>
	        </div>
	    </header>
	    <!-- // 헤더 -->

		<section id="container">
			<div class="policy_wrap">
				<div class="tab_policy_cnt">
					<div class="policy_inner" style="display: block !important">
					<p>
					1. 주식회사 써머스플랫폼(이하 “회사”라 함)은 링크, 다운로드, 광고 등을 포함하여 본 웹 사이트에 포함되어 있거나, 본 웹 사이트를 통해 배포, 전송되거나, 본 웹 사이트에 포함되어 있는 서비스로부터 접근되는 정보(이하 "자료")의 정확성이나 신뢰성에 대해 어떠한 보증도 하지 않으며, 서비스상의, 또는 서비스와 관련된 광고, 기타 정보 또는 제안의 결과로서 디스플레이, 구매 또는 취득하게 되는 상품 또는 기타 정보(이하 "상품")의 질에 대해서도 어떠한 보증도 하지 않습니다.<br /><br />
					자료에 대한 신뢰 여부는 전적으로 사용자 본인의 책임입니다. "회사"는 서비스 또는 기타 자료 및 상품과 관련하여 상품성, 특정 목적에의 적합성에 대한 보증을 포함하되 이에 제한되지 않고 모든 명시적 또는 묵시적인 보증을 명시적으로 부인합니다.<br /><br />
					"회사"는 어떠한 경우에도 서비스, 자료 및 상품과 관련하여 직접, 간접, 부수적, 징벌적, 파생적인 손해에 대해서 책임을 지지 않습니다. "회사"는 보다 나은 정보 제공을 위하여 자료 및 서비스의 일부분을 개선 또는 수정할 수 있으나, 이는 의무사항이 아닙니다.<br /><br />
					따라서 소비자는 본 웹 사이트의 정보는 참조만 하고 다른 정보(예: 신문, 도서, 미디어, 주변의 권고 등)를 고려하여 의사를 결정하시기 바랍니다.<br /><br /><br />


					2. "회사"는 효율적인 정보 제공을 위하여, 인터넷 쇼핑몰들의 컨텐츠를 수집하여 요약정리, 레이아웃 변경 및 정보 가독성을 높이기 위한 정보가공 작업을 수행할 수 있으며, 상품별 제조사명, 브랜드명, 로고 및 쇼핑몰 업체명, 브랜드명, 로고를 게재할 수 있습니다. 상기 정보제공은 관련 협약체결 및 서면승인 절차 등 저작권자의 승인을 기본절차로 진행하되, 연락불능 및 기타 사유로 인하여 승인절차가 생략될 수 있습니다.<br /><br />
					"회사"는 관련 법령이 규정한 특허권, 상표권, 의장권, 실용신안권 등 저작권자의 권리를 존중하며, 저작권자의 권리를
					침해하지 않고, 적법한 권리자의 요구가 있는 경우 요구를 반영하는 업무절차를 마련하고 있습니다. (하단 메일주소로 연락) 이로 인하여 "회사"는 형사상 및 민사상 책임을 지지 않습니다.<br /><br /><br />

					주식회사 써머스플랫폼<br />
					문의 E-mail : master@enuri.com
					</p>
				</div>
				</div>
			</div>
		</section>

		<!-- 푸터 -->
		<%@ include file="/m/include/footer.jsp"%>
		<!-- //푸터 -->

	</div>
	<!-- //140805 수정 -->
</body>
<%@ include file="/mobilefirst/include/common_logger.html"%>
</html>
<script language="javascript">
$(document).ready(function() {
	if(getCookie("appYN") == 'Y'){
		$("header").show();
		$("header").css("display","block important!");
	}
});
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