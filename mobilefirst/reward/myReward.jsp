<%@ page contentType="text/html; charset=utf-8" %>
<%@include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
/*
Cookie[] carr = request.getCookies();
String strAppyn = "";
String strVerios = "";

try{
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("appYN")){
	    	strAppyn = carr[i].getValue();
	    }else if(carr[i].getName().equals("")){
	    	strAppyn = carr[i].getValue();
	    }
	    
	}

} catch(Exception e) {
}	

String strID = cb.GetCookie("MEM_INFO","USER_ID");



%>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://img.enuri.info/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/default.css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/reward.css">
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
</head>
<body>
 
<div class="reward main">

	<section class="home_top">
		<ul class="toparea">
			<li><strong><%=strID%></strong>님의 적립현황</li>
			<li class="save_m"><div>적립금<strong>157,500<em>원</em></strong></div></li>
			<li>적립예정금액<strong>8,000<em>원</em></strong></li>
		</ul>
	</section>

	<section class="home_list">
		<ul>
			<li data-id='request'><span>적립 요청하기</span>쇼핑목록에서 꼭 적립요청을 해주세요!</li>
			<li data-id='cashBack' ><span>현금인출 신청</span>적립금은 현금으로 받으실 수 있습니다. </li>
			<li data-id='faq'><span>자주 묻는 질문</span>에누리 적립금 궁금증 해결!</li>
			<li data-id='qna'><span>1:1 문의</span>자주 묻는 질문을 통해 찾지 못한 궁금한 사항을 빠르게 해결해 드립니다. </li>
		</ul>
	</section>
</div>
</body>
<script>

jQuery(document).ready(function($) {
	
	$("li").click(function(){
		
		var id = $(this).attr('data-id');
		
		if(id=='request'){
			location.href = "point_cashout.jsp";
		}else if(id='cashBack'){
			location.href = "point_cashout_apply.jsp";
		}else if(id='faq'){
			location.href = "point_faq.jsp";
		}else if(id='qna'){
			location.href = "qnaRewardList.jsp";
		}
		
	});
	
	
});

</script>
</html>
<%
*/
%>
