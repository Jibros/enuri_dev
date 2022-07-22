<%@ page contentType="text/html; charset=utf-8" %>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%

	String css = "";
	String cssType = StringUtils.defaultString(request.getParameter("cssType"));

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
   <meta property='og:image' content='<%=ConfigManager.IMG_ENURI_COM%>/images/mobilenew/images/logo_enuri.png'>
   <meta name='format-detection' content='telephone=no'>
   <link rel='stylesheet' type='text/css' href='/mobilefirst/css/default.css'>
   <link rel='stylesheet' type='text/css' href='/mobilefirst/css/gnb.css'>
   <link rel='stylesheet' type='text/css' href='/mobilefirst/css/footer.css'>
   <script type='text/javascript' src='/mobilenew/js/lib/jquery-2.1.1.min.js'></script>
   <script type='text/javascript' src='/mobilefirst/js/gnbCurtCateMenu.js'></script>
</head>
<body>

<!-- 140805 수정 -->
	<div id="privacyWrap" class="agreeWrap <%=css%>" name="privacyWrap">
		<section class="agreeSection">
			<div class="pageHead">
				<h1>이전 방침(수정일:2016.09.06)</h1>
			</div>
			<div class="container">
				<div class="agreeBox">
					<dl class="infotxt">
						<dt>[e머니 이용약관]<br />제1조 (목적)</dt>
						<dd>이 약관은 에누리닷컴(이하 "회사“)이 제공하는 리워드 서비스를 이용함에 있어 회사와 회원간의 권리, 의무 및 책임사항과 절차 등을 정하기 위해 만들어졌습니다.</dd>
						<dt>제2조 (용어의 정의)</dt>
						<dd>이 약관에서는 용어를 다음과 같이 정의하여 사용합니다.<br />
						1. 에누리 리워드 서비스(이하 “서비스”)란 회원의 단말기(모바일 등의 장치를 포함)를 통하여 상품을 구매 하거나 일정한 행위를 이행하면, 그에 대한 포인트 및 혜택을 제공하는 서비스를 말합니다</dd>
						<dd>2. “회원”이란 본 약관에 동의 후 이용계약을 체결하여 "서비스"를 이용하는 고객을 말합니다.</dd>
						<dd>3. "포인트"란 제5조에 따라 회원이 일정한 행위를 완료하면 시스템에 적립되는 서비스 상의 데이터입니다.</dd>
						<dd>4. "제휴컨텐츠"란 회사가 외부 업체(이하 “제휴사”)와 제휴하여 회원에게 제공하는 유/무상의 컨텐츠를 말합니다.</dd>
						<dt>제3조 (약관의 게시 및 변경)</dt>
						<dd>1. 서비스 이용계약은 회원이 본 약관에 동의하여 서비스를 신청한 후, 회사가 이를 수락함으로써 체결됩니다.</dd>
						<dd>2. 이 약관을 회원이 알 수 있도록 서비스 화면 및 회사 도메인에(이하 "사이트")에 게시합니다.</dd>
						<dd>3. 회사는 필요에 따라 "약관의규제에관한법률", "정보통신망이용촉진및정보보호등에관한법률" 등 관련 법령을 위반하지 않는 범위 내에서 이 약관을 개정할 수 있습니다.</dd>
						<dd>4. 회사가 약관을 개정하는 경우 적용일자 및 개정사항을 명시하여 적용 7일 이내에 사이트에 공지합니다.</dd>
						<dd>5. 개정된 약관과 관련하여 이의가 있는 회원에게는 개정된 약관을 적용할 수 없습니다. 단, 회사가 사이트에 공지한 후 14일 이내에 거부의사를 표명하지 않은 회원은 개정 약관에 동의한 것으로 봅니다.</dd>
						<dt>제4조 (서비스 내용)</dt>
						<dd>1. 본 약관 제5조의 행위를 완료한 회원에 대해 회사는 회원에게 포인트를 제공합니다.</dd>
						<dd>2. 회원은 적립된 포인트로 회사가 서비스 화면에 게시한 포인트 사용처 및 컨텐츠를 이용할 수 있습니다.</dd>
						<dd>3. 회원은 원활한 서비스 제공을 위해 서비스와 관련된 상세한 내용을 사이트에서 확인 및 문의할 수 있습니다.</dd>
						<dd>4. 회사는 운영/기술상의 문제로 서비스 내용을 변경 /중단/종료할 수 있으며, 이에 대하여 회원에게 별도의 보상을 하지 않습니다.</dd>
						<dd>5. 서비스를 변경/중지/종료하는 경우 사유, 일자 등의 관련 내용을 30일 이내에 사이트에 공지합니다</dd>
						<dt>제5조 (포인트의 적립과 사용)</dt>
						<dd>1. 회원이 사이트를 통해 상품을 구매하거나, 제휴컨텐츠 시청, 이벤트 참여 등의 일정한 행위를 완료하면 명시된 포인트가 적립됩니다.</dd>
						<dd>2. 회원이 제5조 1항을 이행하는 과정에서 회사는 원활한 리워드 서비스 제공을 위한 목적으로 회원의 ‘쇼핑몰 구매내역’을 수집할 수 있으며, 회사는 해당 이용목적이 달성되면 수집한 구매내역을 즉시 파기하며,  회사가 이용하는 구매내역 상세 내용은 아래와 같습니다.
						i. 회원 ID<br />
						ii. 주문일자<br />
						iii. 주문액</dd>
						<dd>3. 회원은 적립된 포인트 내역을 설정 화면에서 확인할 수 있습니다.</dd>
						<dd>4. 포인트 적립 및 사용방법 등은 회사에서 정한 정책을 따르며, 회사는 해당 내용을 사이트에 게재 및 갱신합니다.</dd>
						<dd>5. 제휴컨텐츠 및 포인트 사용처는 제휴사와의 협의 상황에 따라 변경될 수 있습니다.</dd>
						<dd>6. 포인트 적립 한도는 전자금융거래법 등 관련 법령에 따라 달라질 수 있습니다.</dd>
						<dd>7. 포인트 적립과 관련하여 발생하는 제세공과금은 회원의 부담으로 합니다.</dd>
						<dd>8. 제휴컨텐츠 및 포인트 사용처와 관련된 분쟁에서 명시적인 책임소재가 제휴된 업체 측에 있을 경우, 회사는 책임을 지지 않습니다.</dd>
						<dt>제6조 (포인트의 정정/취소/소멸)</dt>
						<dd>1. 포인트 적립에 오류가 발생한 경우 회원은 오류 발생일로부터 30일 이내에 회사에 정정 신청 할 수 있으며, 정당한 요구임이 확인되면 회사는 정정 신청일로부터 30일 이내에 정정합니다.</dd>
						<dd>2. 적립 포인트의 소멸 조건은 회사의 사정에 따라 변동될 수 있으며, 이때 변경된 소멸 조건을 최소 30일 전에 사이트에 게재합니다.</dd>
						<dd>3. 포인트는 회원탈퇴 즉시 소멸되므로, 회원은 회원탈퇴 전까지 포인트를 사용해야 합니다.</dd>
						<dt>제7조 (회사의 의무)</dt>
						<dd>1. 회사는 관련 법령 또는 이 약관을 위반하지 않으며, 안정적인 서비스를 제공하기 위하여 최선을 다합니다.</dd>
						<dd>2. 회사는 회원의 개인정보 보호를 위해 보안시스템을 갖추어야 하며, 개인정보취급방침을 공시하고 준수합니다.</dd>
						<dd>3. 회사는 서비스와 관련된 회원의 의견이 정당하다고 인정할 경우 이를 처리하여야 합니다. 처리된 결과는 가능한 수단/채널을 통해 회원에게 통보합니다.</dd>
						<dt>제8조 (회원의 의무)</dt>
						<dd>회원은 서비스 이용과 관련하여 다음의 행위를 하여서는 안됩니다.<br />
						i. 서비스 이용 관련 제반 신청 및 변경행위 시 허위 내용의 등록<br />
						ii. 서비스 내 게시된 각종 정보의 무단 변경, 삭제 등 훼손<br />
						iii. 일체의 가공행위를 통해 서비스를 분해, 변경, 모방하는 행위<br />
						iv. 회사 기타 제3자의 지적재산권을 포함하여 권리를 침해하는 행위<br />
						v. 다른 회원의 개인정보를 수집하거나 명예를 손상하는 행위<br />
						vi. 회사의 동의 없이 광고를 전송하거나 외설, 폭력적인 정보 등을 노출하는 행위<br />
						vii. 기타 이 약관상의 의무를 불이행하는 행위<br />
						viii. 기타 불법, 부당한 행위</dd>
						<dt>제9조 (저작권의 귀속 및 이용제한)</dt>
						<dd>1. 회사의 상표, 로고, 제공하는 서비스 및 광고내용에 관한 지적재산권 등의 권리는 회사에 귀속합니다.</dd>
						<dd>2. 회원은 서비스를 이용함으로써 얻은 정보를 회사의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하도록 하여서는 안됩니다.</dd>
						<dt>제10조 (서비스 관련 분쟁해결)</dt>
						<dd>1. 회사는 서비스 이용과 관련한 회원의 의견이나 불만 사항을 신속하게 처리합니다. 단, 신속한 처리가 곤란한 경우에는 그 사유와 처리일정을 통보하여 드립니다.</dd>
						<dd>2. 회사와 회원간에 발생한 분쟁은 서울중앙지방법원을 전속적 합의관할로 하여 해결합니다.</dd>
						<dt>제11조 (준거법 및 합의 관할)</dt>
						<dd>1. 회사와 회원간에 제기된 법적 분쟁은 대한민국 법을 준거법으로 합니다.</dd>
						<dd>2. 회사와 회원간의 분쟁에 관한 소송은 서울중앙지방법원 또는 민사소송법 상의 관할법원에 제소합니다.</dd>
						<dt>제12조 (개인정보보호의무)</dt>
						<dd>회사는 관련 법령이 정하는 바에 따라서 회원 등록정보를 포함한 개인정보를 보호하기 위하여 노력합니다. 이에 관해서는 관련 법령 및 회사의 "개인정보취급방침"에 의합니다.</dd>
						<dt>부칙</dt>
						<dd>이 약관은 2016년 02월 15일부터 적용됩니다.</dd>
					</dl>
				</div>
			</div>
			<button type="button" class="btnClose" onclick='backButton()'>레이어팝업 닫기</button>
		</section>
	</div>
	<!-- //140805 수정 -->
</body>
</html>
<script language="javascript">

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

function backButton(){

	var iOS = /(iPad|iPhone|iPod)/g.test( navigator.userAgent );

	if(getCookie("appYN") == 'Y' ){
		location.href = "close://"
	}else{
		window.close();
	}

}
</script>