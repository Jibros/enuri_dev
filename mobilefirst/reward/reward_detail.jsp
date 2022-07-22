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
 
<div class="wrap">
<section class="content">
	<div class="w_box">
		<ul class="myzone">
			<li>라면쿠폰 교환권<strong id="point_remain"></strong></li>
			<li>지급예정 교환권<strong id="point_prefix"></strong></li>
		</ul>
	</div>
</section>

<section class="content_list">
	<p class="ch_txt">* 받기 신청 후 최대 10일 이내에 교환권이 지급됩니다.  <button class="view" onclick="onoff('viewLayer')">자세히보기</button></p>

	<script type="text/javascript">
		//레이어
		function onoff(id) {
			var mid=document.getElementById(id);
			if(mid.style.display=='') {
			mid.style.display='none';
		}else{
			mid.style.display='';
			}
		}
	</script>
	<div class="dim" id="viewLayer" style="display:none">
		<div class="viewLayer_guide">
			<div class="txt_view">
				<a href="#" onclick="onoff('viewLayer')" class="close">창닫기</a>
				<dl>
					<dt>적립가능 쇼핑몰</dt>
					<dd>G마켓, 11번가, 인터파크, 티몬, CJmall, GS SHOP</dd>
					<dt>구매 금액별 라면지급기준</dt>
					<dd class="pd">11월 2일-11월 30일 구매<br />
					- 1만원 이상~3만원 미만 = 라면 반 개<br />
					- 3만원 이상 = 라면 한 개
					</dd>
					<dd>12월 1일- 2월 14일 구매<br />
					- 1만원 이상~2만원 미만 = 라면 반 개<br />
					- 2만원 이상 = 라면 한 개
					</dd>
					<dt>유의사항</dt>
					<dd>에누리 앱을 통해 구매한 경우에만 적립확인이 가능</dd>
					<dd>적립대상쇼핑몰에서 배송완료된 구매금액을 기준으로 라면지급<br/>
					(단, 구매금액에서 배송비, 설치비, 반품/취소 금액은 제외됨)</dd>


					<dd>받기 신청 후 최대 10일 이내에 라면쿠폰 교환권 지급</dd>
					<dd>라면쿠폰 교환권 유효기간 : 2016년 2월14일 까지</dd>
				</dl>
				<p>소멸전에 꼭! 라면쿠폰으로 교환받으세요!</p>
			</div>
		</div>
	</div>
	<ul class="savingList"></ul>
</section>

<!-- 151030 -->
<div class="mall_list">
	<h2>라면 적립가능 쇼핑몰</h2>
	<ul>
		<li>Gmarket</li>
		<li>11번가</li>
		<li>INTERPARK</li>
		<li>CJmall</li>
		<li>GS SHOP</li>
		<li>TMON</li>
	</ul>
</div>
<!--//151030 -->

</div>

</body>
</html>
<script>
var vUserNick = "<%=(cUserNick.equals("")?cUserId:cUserNick) %>";
var remain = 0.0;	//적립금
var prefix = 0.0;	//적립예정

$(function() {
	getPoint();
	
	ga('send', 'pageview', {
		'page': '/mobilefirst/reward/reward_detail.jsp',
		'title': 'mf_라면백_상세내역'
	}); 
});

function getPoint(){
	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/reward/reward_get_point.jsp",
		async: false,
		dataType:"JSON",
		success: function(json){
			remain = parseFloat(json.POINT_REMAIN);	//적립금
			prefix = parseFloat(json.POINT_PRE_FIX);	//적립예정
			
			//test
			//remain = 3.5;
			//prefix = 2.0;
			
			$("#point_remain").html(remain +"<em>개</em>");
			$("#point_prefix").html(prefix +"<em>개</em>");
	
			
		}
	});
	
	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/reward/reward_get_pointlist.jsp",
		async: false,
		dataType:"JSON",
		success: function(data){
			var vTxt = "";

			$.each(data.pointlist, function(i, item) {
				//http://img.enuri.com/images/mobilefirst/browser/marketicon/app_icon_11st_on.png
				if(item.cart_status == "01" || item.cart_status == "02" || item.cart_status == "03" || item.cart_status == "04"){
					vTxt += "<li>";
					vTxt += "	<img src=\"http://img.enuri.gscdn.com/images/mobilefirst/reward/shopicon/reward_buy_icon_"+ item.shop_code +".png\" alt=\"\" class=\"mall\">";
					vTxt += "	<span class=\"date\">"+ item.cart_order_date.substring(0,10) +"</span>";
					vTxt += "	<span class=\"num\">주문번호 : "+ item.cart_id +"</span>";
					vTxt += "	<strong>"+ item.goodsnm;
					if(item.cnt > 1){
						vTxt += " 외 "+item.cnt+"건";
					}
					vTxt += "</strong>";
					
					if(item.cart_status == "01"){
						vTxt += "	<button type=\"button\" class=\"btn_accept\" id=\""+ item.cart_seq  +"\">받기</button>";
					}else if(item.cart_status == "02"){
						vTxt += "	<button class=\"btn_ing\">비적립</button>";
					}else if(item.cart_status == "03"){
						vTxt += "	<button class=\"btn_ing\">지급예정</button>";
					}else if(item.cart_status == "04"){
						vTxt += "	<button class=\"btn_end\">지급완료</button>";
					}
					
					vTxt += "</li>";
				}else if(item.point_code == "07" || item.point_code == "08" || item.point_code == "09"){
					vTxt += "<li>";
					vTxt += "	<img src=\"http://img.enuri.gscdn.com/images/mobilefirst/reward/shopicon/reward_enuri_icon.png\" alt=\"\" class=\"mall\">";
					vTxt += "	<span class=\"date\">"+ item.cart_order_date.substring(0,10) +"</span>";
					vTxt += "	<span class=\"num\"></span>";
					vTxt += "	<strong>";
					if(item.point_code == "07"){
						vTxt += "친구 방문 적립";	
					}else if(item.point_code == "08" ){
						vTxt += "앱 신규 설치 이벤트 적립";
					}else if(item.point_code == "09"){
						vTxt += "라면 적립 동의 완료";
					}
					vTxt += "</strong>";
					
					if(item.cart_status == "01"){
						vTxt += "	<button type=\"button\" class=\"btn_accept\" id=\""+ item.cart_seq  +"\">받기</button>";
					}else if(item.cart_status == "03"){
						vTxt += "	<button class=\"btn_ing\">지급예정</button>";
					}else if(item.cart_status == "04"){
						vTxt += "	<button class=\"btn_end\">지급완료</button>";
					}else if(item.point_code == "07" || item.point_code == "08" || item.point_code == "09"){
						vTxt += "	<button class=\"btn_end\">지급완료</button>";
					}
					
					vTxt += "</li>";
				}
			});
			
			if(vTxt != ""){
				$(".savingList").html(vTxt);
			}
			$(".btn_accept").unbind("click");
			$(".btn_accept").click(function(){
				var vTid = $(this).attr("id");
				setStatus(vTid);
			});
			
		}
	});
	
}

function setStatus(tid){
	$.ajax({
		type: "GET",
		url: "/mobilefirst/reward/cart_status_update.jsp",
		data: "tid="+tid,
		success: function(result){
			getPoint();	//다시 읽어오기.
			//alert("요청이 완료되었습니다.\n\n구매일 기준 10일 후 교환권이 지급됩니다.");
			alert("구매일 기준 10일 후 교환권이 지급됩니다.\n\n2월 14일까지 교환하지 않은 교환권은\n새로운 서비스인 e머니로 적립됩니다.\n(이벤트메뉴 내 공지사항 참조)");
		}
	});
}
</script>