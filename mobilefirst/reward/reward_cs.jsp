<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Reward_Data"%>
<%@ page import="com.enuri.bean.mobile.Reward_Proc"%>
<jsp:useBean id="Reward_Data" class="Reward_Data" scope="page" />
<jsp:useBean id="Reward_Proc" class="Reward_Proc" scope="page" />
<%
	String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
	String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");
%>
<!DOCTYPE html> 
<html lang="ko">
<head> 
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/default.css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/mybag.css">
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
</head>
<body> 
<div class="wrap">
<nav>
<ul class="sgnb">
	<li class="sgnb_btt btt_1"><a href="javascript:///">홈</a></li> 
	<li class="sgnb_btt btt_2"><a href="javascript:///">라면교환소</a></li>
	<li class="sgnb_btt btt_3"><a href="javascript:///">쿠폰함</a></li>
	<li class="sgnb_btt btt_4"><a href="javascript:///" class="on">문의</a></li>
</ul> 
</nav>

<section> 
	<span class="btnrequest"><a href="mailto:mobilemarketing@enuri.com"><button type="button" onclick="onoff('applylayer')"><em>문의하기</em></button></a></span>
	 
	<script type="text/javascript">
	//faq
	$(document).ready(function(){
		$(".faq dd").hide();
		$(".faq dt").click(function() {
			$(this).next("dd").slideToggle("fast")
					.siblings("dd:visible").slideUp("fast");
			$(this).toggleClass("active")
					.siblings("dt").removeClass("active");
			});
	});
	</script>
	
	<dl class="faq">
	<dt>라면을 받으려면 어떻게 해야 하나요?</dt>
	<dd>
	라면을 받기 위해서는 <br /><br />
	1. 에누리 앱 신규 설치하기<br />
	2. 에누리 앱을 통해 구매하기<br /><br />
	 등 총 2가지 방법이 있습니다.
	</dd>
	<dt>에누리 앱을 통해 구매 시 지급 기준은 어떻게 되나요?</dt>
	<dd>
	구매  건당 결제금액을 기준으로 지급 개수가 달라집니다.<br />
	 - 1만원 ~ 2만원 미만 : 라면 반 개 지급<br />
	 - 2만원 이상 : 라면 한 개 지급<br />
	</dd>
	<dt>앱을 새로 설치하였는데 라면 지급이 안돼요.</dt>
	<dd>기존에 설치를 하셨던 고객님은 다시 앱을 설치하셔도 신규 설치로 체크되지 않아 지급이 되지 않습니다. 설치한 이력이 없는데 지급되지 않을 경우 고객센터(02-6354-3601)로 문의주세요.</dd>
	<dt>라면은 바로 지급 되나요?</dt>
	<dd>신규 앱 설치를 통한 라면은 바로 지급되지만, 상품 구매 후 라면 지급은 10일 이후 됩니다.</dd>	
	<dt>구매 후, 라면은 자동으로 지급되나요?</dt>
	<dd>
	아니요. 상품 구매 후 다음날 상세내역확인 > 주문내역의  '받기' 버튼을 눌러주시면 10일 이후 지급됩니다. 단, 구매 후 10일이 지나면 구매내역이 소멸되오니 유의하시기 바랍니다.<br /><br />
	※ 상세내역확인 페이지는 현황에서 '상세내역확인' 버튼을 터치하시면 볼 수 있습니다.
    </dd>
	<dt>모든 쇼핑몰에서 구매 시 라면이 지급되나요?</dt>
	<dd>
	아니요. 지급 대상 쇼핑몰이 정해져 있으며 이외 쇼핑몰에서 구매시 라면을 받으실 수 없습니다.<br /><br />
	▶ 대상 쇼핑몰 : G마켓, 11번가, 인터파크, 티몬, CJ몰, GS SHOP
	</dd>
	<dt>상세내역확인 에서 받기를 신청하려고 하는데 주문한 내역이 없어요.</dt>
	<dd>
	보통 구매 다음날 주문내역을 확인할 수 있지만, 특정한 경우 남지 않을 수 있습니다.<br /><br />
	<주문내역이 남지 않는 경우 ><br />
	     1. 구매 후 10일 이내 '받기'버튼을 누르지 않아 소멸된 경우<br />
	     2. 에누리에서 로그인하지 않고 구매하였을 경우<br />
	     3. 쇼핑몰 이동 시 에누리 브라우저가 아닌 다른 브라우저(기본브라우저, 네이버, 크롬 등)로 이동하였을 경우<br />
	     4. 에누리앱을 통해 장바구니에 담았지만 이 후, 쇼핑몰(웹,앱)로 직접 접속하여 구매하였을 경우<br />
	     5. 구매한 쇼핑몰이 라면 지급 대상 쇼핑몰이 아닌 경우 <br /><br />
	위 경우에 해당하지 않을 시 고객센터(02-6354-3601)로 문의주세요.
	</dd>	
	<dt>구매 건에 대한 라면 지급은 횟수 제한이 있나요?</dt>
	<dd>없습니다. 조건만 충족된다면(구매금액, 쇼핑몰 등) 횟수에 제한 없이 모든 구매 건에 대해 라면을 받을 수 있습니다.</dd>
	<dt>라면쿠폰 교환권을 실제 라면으로 어떻게 교환하나요?</dt>
	<dd>
	라면쿠폰 교환권은 라면교환소에서 교환 하실 수 있으며, 라면 선택 시 편의점에서 사용가능한 쿠폰 형태로 발급됩니다. 발급된 바코드는 My 라면백 > 쿠폰함 메뉴에서 확인하실 수 있습니다.<br /><br />
	※  '라면쿠폰 교환권' 1개 단위로 교환이 가능합니다.
	</dd>
	<dt>라면쿠폰 교환권을 쿠폰으로 발급받는 기한이 정해져 있나요?</dt>
	<dd>라면쿠폰 교환권은 2월 14일까지 사용 가능합니다.</dd>
	<dt>발급받은 라면 쿠폰의 유효기간이 정해져 있나요?</dt>
	<dd>라면 쿠폰은 실제 발급받은 시점부터 15일간 유효합니다. 그 이후에는 사용하실 수 없으므로 잊지 마시고 사용하세요.</dd>
	<dt>발급된 라면 쿠폰은 다른 라면 쿠폰으로 교환 할 수 없나요?</dt> 
	<dd>한번 발급된 라면 쿠폰은 교환이 불가능합니다.</dd>
	<dt>1개월 이전의 지급내역은 조회 할 수 없나요?</dt>
	<dd>개인정보 보호를 위해 최대 1개월 동안의 지급내역만 확인 가능합니다. 이전 지급내역 확인을 원하시는 경우 고객센터(02-6354-3601)로 문의주세요.</dd>
	<dt>My라면백 현황에서 '지급예정 교환권'은 무엇인가요?</dt>
	<dd>고객님의 구매내역 중 '받기'를 클릭 하신 주문에 대해 지급될 교환권의 예상 개수입니다. 해당 교환권은 최대 10일 이내에 라면으로 교환하실 수 있는 '라면쿠폰 교환권'으로 지급됩니다.</dd>
	<dt>'지급예정 교환권' 개수가 모두 '라면쿠폰 교환권'으로 변경 되나요?</dt>
	<dd>아니요. '지급예정 교환권' 인 상태에서 부분 환불, 구매 취소등이 일어날 시 해당 부분은 제외되고 지급되므로 차이가 있을 수 있습니다.</dd>
	<dt>지급된 라면을 현금으로 교환할 수 있나요?</dt>
	<dd>지급된 라면은 현금화 할 수 없으며 라면교환소에서 라면쿠폰으로 교환하는 용도로만 사용하실 수 있습니다.</dd>
	<dt>라면쿠폰 교환권을 타인에게 양도할 수 있나요?</dt>
	<dd>라면쿠폰 교환권은 개인에게 지급되는 것으로 양도 및 선물 하실 수 없습니다.</dd>
	<dt>회원 탈퇴 시 적립된 라면 쿠폰은 어떻게 되나요?</dt>
	<dd>회원 탈퇴 시 모든 정보는 삭제되므로 보유하신 라면 쿠폰 정보 또한 삭제됩니다. 단, 발급받으신 쿠폰을 별도로 저장하셨다면 사용 가능합니다.</dd>
	</dl>
</section>
</div>

</body>
</html>
<script>

(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
//런칭할때 UA-52658695-3 으로 변경
ga('create', 'UA-52658695-3', 'auto');

var vAlert_ios = "※라면백 이벤트 종료※\n라면쿠폰은 쿠폰함에서 사용가능하며\n라면 교환권은 e머니로 교환됩니다.";
var vAlert_aos = "※라면백 이벤트 종료※\n라면쿠폰은 쿠폰함에서 사용가능하며\n라면 교환권은 e머니로 교환됩니다.";

$(function() { 

	if(window.android){
		 alert(vAlert_aos);
	}else{
		 alert(vAlert_ios);
	}
	
	$(".sgnb_btt").click(function(e){
		 if($(this).hasClass("btt_1")){
			 location.href = "/mobilefirst/reward/reward_main.jsp?title=My%20%EB%9D%BC%EB%A9%B4%EB%B0%B1";
		 }else if($(this).hasClass("btt_2")){
			 if(window.android){
				alert(vAlert_aos);
			}else{
				alert(vAlert_ios);
			}
		 }else if($(this).hasClass("btt_3")){
			 location.href = "/mobilefirst/reward/reward_coupon.jsp?title=My%20%EB%9D%BC%EB%A9%B4%EB%B0%B1";
		 }else if($(this).hasClass("btt_4")){
			 location.href = "/mobilefirst/reward/reward_cs.jsp?title=My%20%EB%9D%BC%EB%A9%B4%EB%B0%B1";
		 }
	});
 
	ga('send', 'pageview', {
		'page': '/mobilefirst/reward/reward_cs.jsp',
		'title': 'mf_라면백_문의'
	});
	
});

</script>