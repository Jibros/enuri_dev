<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>

<%
	String strTab = ChkNull.chkStr(request.getParameter("tab"),"1");
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
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/emoney.css">
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
</head>
<body class="layerbg">
 
<div class="wrap"> 
	<a href="javascript:;" class="btnclose">닫기</a>
	<h5>에누리 <em>e</em>머니<span>서비스관련 라면쿠폰 사용 변경안내</span></h5>

	<script type="text/javascript">
		$(document).ready(function() {
		//Default Action
		$(".cont_area").hide();  
		$(".infopop .tab li:first").addClass("on").show(); 
		$(".cont_area:first").show();
		 
		//On Click Event
		$(".infopop .tab li").click(function() {
			$(".infopop .tab li").removeClass("on"); 
			$(this).addClass("on"); 
			$(".cont_area").hide(); 
			var activeTab = $(this).find("a").attr("href");
			$(activeTab).fadeIn(); //페이드효과
			 /* $(activeTab).show(); defalut */
			return false;
		});
		
		$(".btnclose").click(function(){
	    	if(window.android){		// 안드로이드 			
	    		window.location.href = "close://";
	    	}else{							// 아이폰에서 호출
	    		window.location.href = "close://";
	    	}
		});
	});
	</script>
	
	<div class="infopop">
		<ul class="tab">
			<li><a href="#tab01">라면쿠폰</a></li>
			<li><a href="#tab02">라면교환권</a></li>
		</ul>
		
		<!-- 라면쿠폰 -->
		<div class="cont_area" id="tab01">
			<ul class="ramen_txt">
				<li>라면쿠폰은 쿠폰함에서 기존과 동일하게 사용 가능합니다. </li>
				<li><strong>에누리로그인 - e쿠폰 스토어 - 쿠폰함</strong> 선택 시 쿠폰확인</li>
				<li>라면쿠폰 사용기한은 기존 라면이벤트와 동일합니다.  </li>
			</ul>

			<ul class="howto">
				<li><div><span>1. 에누리 로그인</span><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/reward/use01.png" alt="" /></div></li>
				<li><div><span>2. 쿠폰함 선택</span><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/reward/use02.png" alt="" /></div></li>
				<li><div><span>3. 라면쿠폰 선택</span><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/reward/use03.png" alt="" /></div></li>
				<li><div><span>4. 지정 편의점에서 사용</span><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/reward/use04.png" alt="" /></div></li>
			</ul>
		</div>
		
		<!-- 라면교환권 --> 
		<div class="cont_area" id="tab02">
			<ul class="ramen_txt">
				<li>교환권 0.5장 당 e머니 500점으로 적립되어 사용 가능합니다.</li>
				<li><strong>에누리로그인 → e머니 적립내역</strong> 선택 시 내역 확인가능</li>
				<li>e머니는 2016년 2월 15일에 일괄 변경되며 3개월 간 사용가능<br>※ IOS는 2월 중 적용 예정</li>
			</ul>

			<ul class="howto">
				<li><div><span>1. 에누리 로그인</span><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/reward/use01.png" alt="" /></div></li>
				<li><div><span>2. e머니 선택</span><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/reward/use05.png" alt="" /></div></li>
				<li><div><span>3. 적립내역 확인</span><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/reward/use06.png" alt="" /></div></li>
			</ul>
		</div>

	</div>

</div>

</body>
</html>