<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
/*
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/event/emoney_info.css?v=20190821"/>
	<!--<link rel="stylesheet" type="text/css" href="emoney_info.css"/>-->
	<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
    <script type="text/javascript" src="/mobilefirst/js/event_common.js"></script>
    <style type="text/css">
    .attend{position:relative; }
    .attend .win_close{top:13px; position:fixed; z-index:100}
    .win_close{z-index:10; position: absolute; width:28px; height: 28px; right:5px; top:37px; text-indent: -9999em; background: url(http://imgenuri.enuri.gscdn.com/images/event/2015/m_newyear/ico_close.png) 0 0 no-repeat; background-size:28px; }
     </style>
</head>

<body>

<script type="text/javascript">
	//레이어
	function onoff(id) {
		var mid=document.getElementById(id);
		if(mid.style.display=='') {
		mid.style.display='none';
	}else{
		mid.style.display='';
		};
	}
	$(function(){
		var app = getCookie("appYN");
		var menupos = $("#topFix");
	   if(menupos.length){
		   menupos= menupos.offset().top;
	   }
	   $(window).scroll(function(){
			var ht = $("#topFix").outerHeight(true) + 1;
			var sc = $(window).scrollTop() + ht;
			if(sc >= menupos + ht) {
				$("#topFix").css("position","fixed");
				$("#topFix").css("top","30px");
				$("#topFix .tabmenu").css("background","none");
				$("#topFix .win_close").show();
				} else {
				$("#topFix").css("position","absolute");
				$("#topFix").css("top","");
				$("#topFix .win_close").hide();
			};
	   });

		$("#topFix li").click(function(){
			var idx = $(this).index();
			var ht = $("#topFix").outerHeight(true);
			//$("body").animate({"scrollTop":},500)
			$('html, body').animate({
				scrollTop: parseInt($("#con"+(idx+1)).offset().top - ht)
			}, 500);
			return false;
		});

		$(".over_ht").height($(document).height());

		 $( ".win_close" ).click(function(){
		        if(app == 'Y')            window.location.href = "close://";
		        else            window.location.replace("/mobilefirst/Index.jsp");
		 });
	});

	</script>

<!-- 자동적립 -->
<div class="layer_back over_ht" id="btn_info03" style="display:none;">
	<div class="appLayer">
		<h4>e머니 적립 유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('btn_info03')">창닫기</a>
		<div class="txt">
			<strong>지급 기준 및 구매 유의사항</strong>
			<ul class="txt_indent">
                <li>에누리 앱 로그인 &rarr; 구매상품 검색 &rarr; 쇼핑몰 이동 &rarr; 구매하기 &rarr; 구매확정(배송완료)</li>
				<li>배송비, 설치비, 할인, 쇼핑몰 포인트를 제외한 결제 금액이 최소 1,000원 이상 시 적립 가능</li>
				<li>대상쇼핑몰에서 장바구니로 여러 상품을 한번에 통합 결제 시 구매건수는 1건으로 적립</li>
                <li>결제일로부터 취소/반품여부 확인 후 적립 (10일~최대 30일 소요)</li>
				<li>e머니는 최소 10점부터 적립되며, 1점 단위 절삭 후 적립됩니다.</li>

			</ul>
			<strong>적립대상 쇼핑몰</strong>
			<ul class="txt_indent">
				<li>옥션, G마켓(G9 제외), 11번가, 인터파크, CJ몰, GSshop, 티몬, SSG몰, 위메프, 쿠팡</li>
			</ul>

			<strong>카테고리 별 적립률 (1점 단위 절삭 후 적립)</strong>
			<ol class="inner">
				<li>- 1.5% 적립 : 유아</li>
				<li>- 1.0% 적립 : 식품 / 스포츠 / 레저 / 자동차</li>
				<li>- 0.8% 적립 : 컴퓨터 / 도서 / 여행 / 취미</li>
				<li>- 0.3% 적립 : 위에 명시되지 않은 카테고리 (디지털 / 가전 / 패션 / 화장품 / 가구 / 생활 등)</li>
			</ol>
			<strong>쇼핑몰 별 적립불가 상품</strong>

			<ol class="inner">
				<li class="tit">쇼핑몰 공통</li>
				<li>- 에누리 가격비교 앱에서 검색되지 않는 상품</li>
				<li>- 각 쇼핑몰에 입점한 제휴서비스 (백화점 등)</li>
				<li>- 장바구니에 담긴 상품을 모바일에서 결제만 하는 경우</li>
			</ol>
			<ol class="inner">
				<li class="tit">&lt;옥션, G마켓&gt;</li>
				<li>- 중고장터, 실시간 여행, 항공권, 해외배송, 도서/음반</li>
				<li>- 상품권 및 e쿠폰 (문화상품권, 도서상품권, 백화점상품권, 영화예매권, 국민관광상품권은 적립 가능)</li>

				<li class="tit">&lt;11번가&gt;</li>
				<li>- 여행, 숙박, 항공권</li>
				<li>- 상품권 및 e쿠폰 전체</li>

				<li class="tit">&lt;인터파크&gt;</li>
				<li>- 에누리 특가상품(크레이지딜), 티켓, 투어, 아이마켓</li>
				<li>- 배달, 상품권 및 e쿠폰 전체</li>

				<li class="tit">&lt;티몬&gt;</li>
				<li>- 슈퍼꿀딜, 슈퍼마트 등 특가 판매 상품</li>
				<li>- 상품권 및 e쿠폰 (문화상품권, 도서상품권, 백화점상품권, 영화예매권, 국민관광상품권은 적립 가능)</li>

				<li class="tit">&lt;위메프&gt;</li>
				<li>- 상품권 및 e쿠폰 전체</li>

				<li class="tit">&lt;SSG몰&gt;</li>
				<li>- 도서/음반, 문구, 취미, 여행</li>
				<li>- 상품권 및 e쿠폰 전체</li>

				<li class="tit">&lt;CJ몰, GS SHOP&gt;</li>
				<li>- 상품권 및 e쿠폰 전체</li>
			</ol>

			<strong>아래의 경우에는 구매 확인 및 적립이 불가합니다.</strong>
			<ul class="txt_indent">
				<li>에누리 앱이 아닌 곳에서 장바구니 또는 관심상품 등록 후 에누리 앱으로 결제만 한경우<br />	(에누리 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)</li>
				<li>에누리 앱 미 로그인 후 구매한 경우 또는 에누리 PC, 모바일 웹에서 구매한 경우</li>
			</ul>

			<strong>e머니 유의사항</strong>
			<ul class="txt_indent">
                <li>e머니 유효기간: 적립일로부터 60일</li>
				<li>적립된 e머니는 앱에서 다양한 e쿠폰 상품으로 교환 가능합니다.</li>
			</ul>

			<strong>적립확인</strong>
			<ul class="txt_indent">
				<li>에누리 앱 로그인 후 마이 페이지에서 확인</li>
			</ul>



			<strong>유의사항</strong>
			<ul class="txt_indent">
				<li>부정 참여 시 적립이 취소될 수 있습니다.</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
			</ul>

		</div>
		<p class="btn_close"><button type="button" onclick="onoff('btn_info03')">확인</button></p>
	</div>
</div>

<div class="wrap">

    <div class="attend">
        <a href="javascript:///" class="win_close">창닫기</a>
   </div>
	<div class="toparea">
		<h1>e머니 모으고 혜택 받으세요!</h1>
		<p>e머니를 쿠폰으로 교환해보세요.</p>
	</div>

	<div class="em_intro">
		<h2>e머니 소개</h2>
		<ul>
			<li>e머니는 에누리를 이용하는 고객님께 드리는 포인트 혜택입니다.</li>
			<li>에누리 앱을 통해 상품을 구매하면 결제금액의 일부를 e머니로 자동 적립해드립니다.</li>
			<li>적립된 e머니로 쿠폰으로 교환 할 수 있습니다.</li>
			<!-- <li>부정거래 방지를 위해 본인인증은 필수입니다.<a href="/mobilefirst/member/myAuth.jsp?freetoken=login_title">본인인증 하러가기</a></li> 170411 -->
		</ul>
	</div>

	<div class="em_benefit">
		<h2>e머니 혜택</h2>
		<h3>스토어 인기상품</h3>
		<a href="/mobilefirst/emoney/emoney_store.jsp?freetoken=emoney">스토어 바로가기</a>
	</div>

	<!-- 180314 마크업 변경 -->
	<!-- 180905 내용 변경 -->
	<div class="em_save">
		<div class="centent">
			<div class="steparea">
				<h2 class="blind">e머니 적립확인</h2>
				<dl class="step1">
					<dt>STEP 1</dt>
					<dd>에누리 앱에 로그인을 해주세요.</dd>
				</dl>
				<dl class="step2">
					<dt>STEP 2</dt>
					<dd>상품구매 시 적립가능 아이콘이<br />활성화되며 선택하면 팝업으로<br />확인 할 수 있습니다.</dd>
				</dl>
				<dl class="step3">
					<dt>STEP 3</dt>
					<dd>e머니 적립은 상품 결제 후 10~30일 후<br />[마이에누리>적립내역]에서 확인 할 수<br />있습니다.</dd>
				</dl>
			</div>

			<div class="mallbox">
				<h3 class="blind">e머니 적립 쇼핑몰</h3>
				<ul class="blind">
					<li>AUCTION</li>
					<li>Gmarket</li>
					<li>11번가</li>
					<li>INTERPARK</li>
					<li>CJmall</li>
					<li>GS SHOP</li>
					<li>TMON</li>
					<li>SSG.COM</li>
					<li>쿠팡</li>
				</ul>
			</div>

			<dl class="note">
				<dt>쇼핑몰 별 적립 불가 상품</dt>
				<dt style ="font-weight: normal">쇼핑몰 공통</dt>
				<dd>에누리 앱에서 검색되지 않는 상품</dd>
				<dd>각 쇼핑몰에 입점한 제휴서비스 (백화점 등)</dd>
				<dd>장바구니에 담긴 상품을 모바일에서 결제만 하는 경우</dd>

				<dt style ="font-weight: normal">&lt;옥션,G마켓&gt;</dt>
				<dd>중고장터, 실시간 여행, 항공권, 해외배송, 도서/음반</dd>
				<dd>상품권 및 e쿠폰 (문화상품권, 도서상품권, 백화점상품권, 영화예매권, 국민관광상품권은 적립 가능)</dd>

				<dt style ="font-weight: normal">&lt;11번가&gt;</dt>
				<dd>여행, 숙박, 항공권</dd>
				<dd>상품권 및 e쿠폰 전체</dd>

				<dt style ="font-weight: normal">&lt;인터파크&gt;</dt>
				<dd>에누리 특가상품(크레이지딜), 티켓, 투어, 아이마켓</dd>
				<dd>배달, 상품권 및 e쿠폰 전체</dd>

				<dt style ="font-weight: normal">&lt;티몬&gt;</dt>
				<dd>슈퍼꿀딜, 슈퍼마트 등 특가 판매상품</dd>
				<dd>상품권 및 e쿠폰 (문화상품권, 도서상품권, 백화점상품권, 영화예매권, 국민관광상품권은 적립 가능)</dd>

				<dt style ="font-weight: normal">&lt;위메프&gt;</dt>
				<dd>상품권 및 e쿠폰 전체</dd>

				<dt style ="font-weight: normal">&lt;SSG몰&gt;</dt>
				<dd>도서/음반, 문구, 취미, 여행</dd>
				<dd>상품권 및 e쿠폰 전체</dd>

				<dt style ="font-weight: normal">&lt;CJ몰, GS SHOP&gt;</dt>
				<dd>상품권 및 e쿠폰 전체</dd>

			</dl>

			<a href="#" onclick="onoff('btn_info03')">꼭 확인하세요</a>
		</div>
	</div>
	<!-- //180314 마크업 변경 -->
	<!-- //180905 내용 변경 -->

</div>
</body>
</html>
<%
*/
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://img.enuri.info/images/mobilenew/images/logo_enuri.png">
    <meta name="format-detection" content="telephone=no" />
    <link rel="stylesheet" type="text/css" href="/css/mobile_v2/common.css"/>
    <link rel="stylesheet" type="text/css" href="/css/mobile_v2/emoney_info.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	
</head>
<body>

<div class="wrap">
    <div class="emoney_info">
        <div class="inf_sec_01">
            <h2 class="blind">에누리에서 구매하고 현금같은 e머니 적립 받으세요!</h2>
        </div>
        <ol>
            <li class="inf_sec_02">
                <h3 class="blind">에누리 앱에서 로그인 후 적립대상 쇼핑몰 이동하기</h3>
            </li>
            <li class="inf_sec_03">
                <h3 class="blind">상품 구매하기</h3>
            </li>
            <li class="inf_sec_04">
                <h3 class="blind">구매금액의 최대 1.5% e머니 적립!</h3>
            </li>
            <li class="inf_sec_05">
                <h3 class="blind">e쿠폰 스토어에서 1,000여가지의 인기e쿠폰으로 교환가능!</h3>
            </li>
        </ol>
        <!-- 버튼 : 자세히 보기 -->
        <a href="/mobilefirst/emoney/emoney_faq.jsp?freetoken=faq" class="btn_view_detail">자세히 보기</a>
        <!-- // -->
        <!-- 버튼 : 창닫기 -->
        <button class="btn_pop_close">닫기</button>
        <!-- // -->
    </div>
</div>

</body>

<script type="text/javascript">
	//레이어
	function onoff(id) {
		var mid=document.getElementById(id);
		if(mid.style.display=='') {
		mid.style.display='none';
	}else{
		mid.style.display='';
		};
	}
	$(function(){
		var app = "Y";
		var menupos = $("#topFix");
	   if(menupos.length){
		   menupos= menupos.offset().top;
	   }
	   $(window).scroll(function(){
			var ht = $("#topFix").outerHeight(true) + 1;
			var sc = $(window).scrollTop() + ht;
			if(sc >= menupos + ht) {
				$("#topFix").css("position","fixed");
				$("#topFix").css("top","30px");
				$("#topFix .tabmenu").css("background","none");
				$("#topFix .win_close").show();
				} else {
				$("#topFix").css("position","absolute");
				$("#topFix").css("top","");
				$("#topFix .win_close").hide();
			};
	   });

		$("#topFix li").click(function(){
			var idx = $(this).index();
			var ht = $("#topFix").outerHeight(true);
			//$("body").animate({"scrollTop":},500)
			$('html, body').animate({
				scrollTop: parseInt($("#con"+(idx+1)).offset().top - ht)
			}, 500);
			return false;
		});

		$(".over_ht").height($(document).height());

		 $( ".btn_pop_close" ).click(function(){
		        if(app == 'Y')            window.location.href = "close://";
		        else            window.location.replace("/m/index.jsp");
		 });
	});

	</script>
</html>
