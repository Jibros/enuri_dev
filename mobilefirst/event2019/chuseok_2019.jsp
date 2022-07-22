<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
	response.sendRedirect("/event2019/chuseok_2019.jsp");
	return;
}

String chkId   = ChkNull.chkStr(request.getParameter("chk_id"),"");
String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String userNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK"),"");

Members_Proc members_proc = new Members_Proc();
String userName = members_proc.getUserName(userId);
String userArea = userName;
String strUrl = request.getRequestURI();

if(!userId.equals("")){
    userName = members_proc.getUserName(userId);
    userArea = userName;

    if(userName.equals("")){
        userArea = userNick;
    }
    if(userArea.equals("")){
        userArea = userId;
    }
}

String tab = ChkNull.chkStr(request.getParameter("tab"));
String protab = ChkNull.chkStr(request.getParameter("protab"));
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" >
	<meta name="description" CONTENT="추석선물 미리 준비하고, LG와이드모니터 받아가세요!">
	<meta name="keyword" CONTENT="에누리가격비교, 통합기획전, 추석, 한가위, 추석선물, 추석선물세트,명절선물">
	<title>2019 추석 통합기획전 – 최저가 쇼핑은 에누리</title>
	<meta property="og:title" content="2019 추석 통합기획전 – 최저가 쇼핑은 에누리">
	<meta property="og:description" content="추석선물 미리 준비하고, LG와이드모니터 받아가세요!">
	<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2019/chuseok/ogimg.jpg">
	<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilenew/images/enuri_logo_facebook200.gif">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" href="/css/event/y2019/chuseok_m.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="http://m.enuri.com/mobilefirst/css/lib/slick.css"/>
	<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
	<script type="text/javascript" src="/event2016/js/event_common.js"></script>
</head>

<body>
<div id="eventWrap">
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp" %>

	<!-- 플로팅 배너 - 둥둥이 -->
    <div id="floating_bnr" class="floating_bnr">
        <a href="/mobilefirst/event2019/chuseok_2019_evt.jsp?tab=evt1&freetoken=event" onclick="ga_log(6);" target="_blank"><img src="http://img.enuri.com/images/event/2019/chuseok/m_fl_bnr.png" alt="매일매일 버거세트 공짜!"></a>
        <!-- 닫기 -->
        <a href="javascript:void(0);" class="btn_close" onclick="onoff('floating_bnr');return false;">
            <span class="blind">닫기</span>
        </a>
    </div>
    <!-- // -->

	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">
		<!-- 상단비주얼 -->
		<div class="visual">
			<div class="inner">
				<span class="txt_year">2019</span>
				<h2>
					<span class="obj_txt_01">추</span><span class="obj_txt_02">석</span>
					<span class="obj_txt_03 obj_txt_group">선</span><span class="obj_txt_04 obj_txt_group">물</span><span class="obj_txt_05 obj_txt_group">대</span><span class="obj_txt_06 obj_txt_group">전</span>
				</h2>
				<div class="deco_sunrise">
					<span class="obj_mt"><!-- 산 --></span>
					<span class="area_moon">
						<span class="obj_moon"><!-- 보름달 --></span>
					</span>
				</div>
				<span class="txt_sub_01">완벽한 추석준비 한번에</span>
				<span class="txt_sub_02">
					<span class="txt_sub_comm">완벽한 추석준비 한번에</span>
				</span>
			</div>
			<script>
				// 상단 등장 모션
				$(window).load(function(){
					setTimeout(function(){
						$(".visual").addClass("intro");
						setTimeout(function(){
							$(".visual").addClass("end");
						},3500)
					},500)
				})
			</script>
		</div>

		<!-- 플로팅 탭 -->
		<div class="floattab">
			<ul class="floattab__list">
				<li><a href="#evt1" class="lnbtab__item lnbtab__item--01">최대 80% 타임세일</a></li>
				<li><a href="#evt2" class="lnbtab__item lnbtab__item--02">BEST추석 선물추천</a></li>
				<li><a href="#evt3" class="lnbtab__item lnbtab__item--03">가격대별 추석선물</a></li>
				<li><a href="#evt4" class="lnbtab__item lnbtab__item--04">줄기자 추석연휴</a></li>
			</ul>
			<script>
				//플로팅 상단 탭 이동
				$(document).on('click', '.floattab__list a', function(e) {
					e.preventDefault();
					var $anchor = Math.ceil($($(this).attr('href')).offset().top);
					$('html, body').stop().animate({scrollTop: $anchor }, 500);

					var index = $(this).parents().index();

					ga_log((2 + index));
				});
			</script>
		</div>
	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<div class="only_mweb" id="only_mweb" style="display:none">
    	<img src="http://img.enuri.com/images/event/2019/chuseok/ico_app.png" alt="앱전용">
	</div>

	<!-- DEAL페이지 -->
	<div id="evt1" class="section dealwrap scroll">
		<div class="contents">
			<h2>매주 목요일! 선착순 한정수량 - 추석선물 타임특가</h2>
			<!-- 딜 구매영역 -->
			<div class="deal_slide">
			</div>
			<!-- //딜 구매영역 -->
		</div>
		<div>
			<!-- 딜 리스트영역 -->
			<div class="deal_list">
				<h4>Next Week</h4>
				<div class="deal_nav">
				</div>
				<a href="#" class="btn_caution evt-caution-1" onclick="onoff('notetxt1'); return false;">꼭!확인하세요</a>
			</div>
		</div>
	</div>
	<!-- //DEAL페이지 -->

	<!-- 추천 상품 영역 -->
	<div class="section pro_itemlist">

		<div id="evt2" class="pro_itemlist_head scroll">
			<h2>BEST 추석선물 추천</h2>
			<ul class="anc_list">
				<li><a href="#pro_anc_01"><img src="http://img.enuri.com/images/event/2019/chuseok/btn_anc_01.jpg" alt="한우 선물세트"></a></li>
				<li><a href="#pro_anc_02"><img src="http://img.enuri.com/images/event/2019/chuseok/btn_anc_02.jpg" alt="신선식품 선물세트"></a></li>
				<li><a href="#pro_anc_03"><img src="http://img.enuri.com/images/event/2019/chuseok/btn_anc_03.jpg" alt="가공식품 선물세트"></a></li>
				<li><a href="#pro_anc_04"><img src="http://img.enuri.com/images/event/2019/chuseok/btn_anc_04.jpg" alt="생활용품 선물세트"></a></li>
				<li><a href="#pro_anc_05"><img src="http://img.enuri.com/images/event/2019/chuseok/btn_anc_05.jpg" alt="건강 선물세트"></a></li>
				<li><a href="#pro_anc_06"><img src="http://img.enuri.com/images/event/2019/chuseok/btn_anc_06.jpg" alt="상품권 선물"></a></li>
			</ul>
			<script>
				var $ancList = $(".pro_itemlist .anc_list").find("li");
				$ancList.find("a").click(function(e){
					e.preventDefault();
					var $attr = $(this).attr("href");
					var scrPos = $($attr).offset().top;
					$('html, body').stop().animate({ scrollTop: scrPos }, 500);

					var index = $(this).parent().index();

					ga_log((10 + index));
				})
			</script>
		</div>

		<!-- 추선선물 추천 -->
		<div class="item_recomm">
			<!-- 한우선물세트 -->
			<div id="pro_anc_01" class="item_recomm_group item_recomm_01">
				<h3>한우선물세트</h3>
				<div class="tab_content">
					<div class="itemlist">
					</div>
					<a class="btn_more" href="/mobilefirst/list.jsp?cate=15031501&freetoken=list" target="_blank" onclick="ga_log(17);">상품더보기</a>
				</div>
			</div>
			<!-- // 한우선물세트 -->

			<!-- 신선식품 선물세트 -->
			<div id="pro_anc_02" class="item_recomm_group item_recomm_02">
				<h3>신선식품 선물세트</h3>
				<div class="tab_content">
					<div class="itemlist">
					</div>
					<a class="btn_more" href="/mobilefirst/list.jsp?cate=15020323&freetoken=list" target="_blank" onclick="ga_log(19);">상품더보기</a>
				</div>
			</div>
			<!-- // 신선식품 선물세트 -->

			<!-- 가공식품 선물세트 -->
			<div id="pro_anc_03" class="item_recomm_group item_recomm_03">
				<h3>가공식품 선물세트</h3>
				<div class="tab_content">
					<div class="itemlist">
					</div>
					<a class="btn_more" href="/mobilefirst/list.jsp?cate=15110510&freetoken=list" target="_blank" onclick="ga_log(21);">상품더보기</a>
				</div>
			</div>
			<!-- // 가공식품 선물세트 -->

			<!-- 생활용품 선물세트 -->
			<div id="pro_anc_04" class="item_recomm_group item_recomm_04">
				<h3>생활용품 선물세트</h3>
				<div class="tab_content">
					<div class="itemlist">
					</div>
					<a class="btn_more" href="/mobilefirst/list.jsp?cate=080824&freetoken=list" target="_blank" onclick="ga_log(23);">상품더보기</a>
				</div>
			</div>
			<!-- // 생활용품 선물세트 -->

			<!-- 건강 선물세트 -->
			<div id="pro_anc_05" class="item_recomm_group item_recomm_05">
				<h3>건강 선물세트</h3>
				<div class="tab_content">
					<div class="itemlist">
					</div>
					<a class="btn_more" href="/mobilefirst/list.jsp?cate=15010513&freetoken=list" target="_blank" onclick="ga_log(25);">상품더보기</a>
				</div>
			</div>
			<!-- // 건강 선물세트 -->

			<!-- 상품권 선물 -->
			<div id="pro_anc_06" class="item_recomm_group item_recomm_06">
				<h3>상품권 선물</h3>
				<div class="tab_content">
					<div class="itemlist">
					</div>
					<a class="btn_more" href="/mobilefirst/list.jsp?cate=164722&freetoken=list" target="_blank" onclick="ga_log(27);">상품더보기</a>
				</div>
			</div>
			<!-- // 상품권 선물 -->

		</div>
		<!-- // 추선선물 추천 -->

		<div class="inner">
			<!-- 가격대별 추석선물 -->
			<div id="evt3" class="item_group item_group_01 scroll">
				<h3>가격대별 맞춤선물</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab1-1">1만원이하</a></li>
					<li><a href="#protab1-2">1~5만원</a></li>
					<li><a href="#protab1-3">5~10만원</a></li>
					<li><a href="#protab1-4">10만원이상</a></li>
				</ul>
				<!-- //추천상품 탭 -->
				<script>
				$('#evt3 .pro_tabs li a').click(function(){
					var index = $(this).parents().index();

					ga_log(28 + index);
				});
				</script>

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">
					<!--
						SLICK $(".itemlist")
						4개의 탭 콘텐츠가 있습니다. "tab_content"
						하나의 콘텐츠마다 ul 단위로 한 판(상품4개)씩 움직입니다.
					-->
					<!-- 1만원이하 -->
					<div id="protab1-1" class="tab_content">
						<div class="itemlist">
						</div>
					</div>
					<!-- //1만원이하 -->

					<!-- 1~5만원 -->
					<div id="protab1-2" class="tab_content">
						<div class="itemlist">
						</div>
					</div>
					<!-- //1~5만원 -->

					<!-- 5~10만원 -->
					<div id="protab1-3" class="tab_content">
						<div class="itemlist">
						</div>
					</div>
					<!-- //5~10만원 -->

					<!-- 10만원이상 -->
					<div id="protab1-4" class="tab_content">
						<div class="itemlist">
						</div>
					</div>
					<!-- //10만원이상 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 가격대별 추석선물-->

			<!-- 즐기자 추석연휴 -->
			<div id="evt4" class="item_group item_group_02 scroll">
				<h3>즐기자 추석연휴</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab2-1">E쿠폰</a></li>
					<li><a href="#protab2-2">컴퓨터/게임기</a></li>
					<li><a href="#protab2-3">간편가정식</a></li>
					<li><a href="#protab2-4">보드게임</a></li>
				</ul>
				<!-- //추천상품 탭 -->
				<script>
				$('#evt4 .pro_tabs li a').click(function(){
					var index = $(this).parents().index();

					ga_log(33 + index);
				});
				</script>

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- E쿠폰 -->
					<div id="protab2-1" class="tab_content">
						<div class="itemlist">
						</div>
					</div>
					<!-- //E쿠폰 -->

					<!-- 컴퓨터/게임기 -->
					<div id="protab2-2" class="tab_content">
						<div class="itemlist">
						</div>
					</div>
					<!-- //컴퓨터/게임기 -->

					<!-- 간편가정식 -->
					<div id="protab2-3" class="tab_content">
						<div class="itemlist">
						</div>
					</div>
					<!-- //간편가정식 -->

					<!-- 보드게임 -->
					<div id="protab2-4" class="tab_content">
						<div class="itemlist">
						</div>
					</div>
					<!-- //보드게임 -->

				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 즐기자 추석연휴 -->
		</div>
	</div>
	<!-- //추천 상품 영역 -->

	<!-- 추석선물세트 구매하면 LG 울트라 와이드 모니터 당첨 -->
	<div class="event_bnr">
		<a href="/mobilefirst/event2019/chuseok_2019_evt.jsp?tab=evt2&freetoken=event" onclick = "ga_log(38)" target="_blank">
			<img src="http://img.enuri.com/images/event/2019/chuseok/m_aside_bnr.jpg" alt="추석선물세트 구매하면 LG 울트라 와이드 모니터 당첨">
		</a>
	</div>
	<!-- // -->

	<!-- 에누리 혜택 -->
	<%@include	file = "/eventPlanZone/jsp/eventBannerTapMobile_201908.jsp"%>
	<!-- //에누리 혜택 -->
	<script>
		$('.otherbene .banlist li a').click(function(){
			ga_log(39);
		});
	</script>
	<!-- //Contents -->

	<span class="go_top"><a href="#">TOP</a></span>
</div>
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20190611"></script>

<!-- layer-->
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 DEAL</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();">설치하기</button></p>
	</div>
</div>

<!-- 이벤트1 유의사항 -->
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="noteLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1');return false;">창닫기</a>
		<div class="inner">
			<ul class="txtlist">
				<li>본인인증이 완료된 ID로만 참여가능합니다.</li>
				<li>시즌기획전 타임딜 상품의 주문/배송/환불/보증 책임은 해당 쇼핑몰의 판매자에게 있습니다.</li>
				<li>부정한 방법으로 상품 구매 시 주문이 취소될 수 있습니다.</li>
				<li>본 이벤트는 당사에 사정에 따라 사전고지 없이 변경 또는 조기종료 될 수 있습니다.</li>
				<li>시즌기획전 타임딜은 선착순 한정수량 판매로 결제 진행 중 상품이 품절될 경우 판매가 종료될 수 있습니다.</li>
				<li>모바일 APP 에서만 구매가능하며, 이 외 다른 환경에서 구매시도하여 발생되는 문제에 대해서는<br/>책임 및 보상이 이루어지지 않습니다.</li>
			</ul>
		</div>
		<p class="btn_close"><button type="button" onclick="onoff('notetxt1');return false;">닫기</button></p>
	</div>
</div>

<script>
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로
var ga_log;
var cnt = 0;
var app = getCookie("appYN"); //app인지 여부

$(document).ready(function(){
	ga_log = gaCall();
	ga_log(1);

	//#타임특가 PV
	setTimeout(function(){
		welcomeGa("evt_chuseok deal_view");
	},500);

	if(islogin()){
		$("#user_id").text("<%=userId%>");
		getPoint();//개인e머니 내역 노출
	}

	//닫기버튼
	$(".win_close").click(function(){
		if(getCookie("appYN") == 'Y'){
			window.location.href = "close://";
		}else{
			window.location.replace("/mobilefirst/index.jsp");
		}
	});

	var makeHtml = "";

	//딜 상품
	$.ajax({
		  url: "/mobilefirst/http/json/exh_deal_list_2019080200.json"
		, dataType : "json"
		, cache    : false
		, success  : function(data){
			var vCur_dtm = YYYYMMDDHHMMSS(new Date());
			var dealItem = "";
			var dealList = "";
			$.each(data, function(i,v){
				//딜 판매날짜, 할인률
				var month = parseInt(v.GD_SAL_S_DTM_CVT.substring(4,6));
				var day = parseInt(v.GD_SAL_S_DTM_CVT.substring(6,8));
				var discountRate =  Math.round((v.GD_PRC - v.GD_DC_PRC) / v.GD_PRC * 100);
				var text = discountRate+"% 타임특가 / "+v.GD_QTY+"개 한정";
				cnt = data.length;

				dealItem += "<div class=\"deal_item clearfix\">";
				dealItem += "	<div class=\"container\">";
				dealItem += "		<div class=\"thumb\">";
				dealItem += "			<img src=\"http://storage.enuri.info/Web_Storage"+v.GD_IMG_URL+"\" />";
				dealItem += "			<span class=\"ico_date\">";
				dealItem += "				<span>";
				dealItem += "					<strong>"+month+"."+day+"일("+getWeek(v.GD_SAL_S_DTM_CVT)+")</strong>2pm 오픈";
				dealItem += "				</span>";
				dealItem += "			</span>";
				dealItem += "		</div>";
                dealItem += "		<div class=\"item_info\">";
                dealItem += "			<div class=\"inner\">";
				dealItem += "				<strong class=\"limit\">"+text+"</strong>";
                dealItem += "				<p class=\"tit\">"+v.GD_MODEL_NM1+v.GD_MODEL_NM2+"</p>";
                dealItem += "				<p class=\"price\"><strong>"+commaNum(v.GD_DC_PRC)+"</strong>원</p>";
                dealItem += "			</div>";
                dealItem += "			<ul class=\"btn_area clearfix\" id=\"ul_btn"+i+"\">";
                dealItem += "				<li><a href=\"/mobilefirst/detail.jsp?modelno="+v.GD_MODEL_NO+"&freetoken=vip\" class=\"btn_dview\" target=\"_blank\" onclick=\"ga_log(7)\">상품보기</a></li>";
                if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT > vCur_dtm) { //판매 전
	                dealItem += "			<li id='deal_btn'><a class=\"btn_buy\">판매예정</a></li>";
		        }else if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT <= vCur_dtm && v.GD_SAL_E_DTM_CVT >= vCur_dtm) { //판매 중
	                dealItem += "			<li id='deal_btn'><a class=\"btn_buy\" onclick=\" fnDeal("+v.EXH_DEAL_NO+"); return false;\">구매하기</a></li>";
		        }else{ // 판매 종료
	                dealItem += "			<li id='deal_btn'><a class=\"btn_buy_soldout\">Sold out</a></li>";
	        	}
                dealItem += "			</ul>";
                dealItem += "		</div>";
//                 if(i == 0 || i == 3){
// 	                dealItem += "	<p class=\"ad\">※ 쿠폰적용 필수 / ID당 1회 / 해외통관번호 필수 <span class=\"mark\"><img src=\"http://img.enuri.info/images/event/2019/familySpecial/logo_inter.png\" alt=\"인터파크\"></span></p>";
//                 }else{
	                dealItem += "	<p class=\"ad\">※ 쿠폰적용 필수 / ID당 1회 / 무료배송 <span class=\"mark\"><img src=\"http://img.enuri.com/images/event/2019/chuseok/logo_inter.png\" alt=\"인터파크\"></span></p>";
//                 }
        	    dealItem += "	</div>";
        	    dealItem += "</div>";

        		dealList += "<div class=\"w_item\" onclick=\"ga_log(9);\">";
                dealList += "	<div class=\"w_thumb\">";
                dealList += "		<img src=\"http://storage.enuri.info/Web_Storage"+v.GD_IMG_URL+"\" />";
                dealList += "	</div>";
				dealList += "	<div class=\"period\">";
                dealList += "		<span>"+month+"/"+day+"("+getWeek(v.GD_SAL_S_DTM_CVT)+") 14:00</span>";
                dealList += "	</div>";
                dealList += "	<span class=\"w_tit\">"+v.GD_MODEL_NM1+"<br>"+v.GD_MODEL_NM2+"</span>";
				dealList += "</div>";
			});
			$('#evt1 .deal_slide').html(dealItem);
			$('#evt1 .deal_list .deal_nav').html(dealList);
		},
		complete: function(){
			var $deal_slide = $('#evt1 .deal_slide');
	    	var $w_item = $('.deal_nav .w_item');

			$deal_slide.slick({
				slidesToShow: 1,
				slidesToScroll: 1,
				arrows: true,
				dots: true,
				fade: false,
				//speed: 0,
				asNavFor: '.deal_nav'
			});
			$('#evt1 .deal_list .deal_nav').slick({
				slidesToShow: 3,
				slidesToScroll: 1,
				asNavFor: '.deal_slide',
				dots: false,
				centerMode: false,
				focusOnSelect: true
			});

  		    $deal_slide.on('beforeChange', function(e, s, c, n){
  		    	$w_item.removeClass("slick-current");
  		    	$w_item.eq(n).addClass("slick-current");
            });

          //딜 날짜별 상품 노출
			for(var i = 0; i < cnt; i++){
				if($("#ul_btn"+i+" li a").hasClass("btn_buy_soldout")){
					$deal_slide.slick('slickGoTo', i+1, true);
				}else{
					break;
				}
			}

          if(app != 'Y'){
        	  var deal_btn = $('#deal_btn a');

        	  $('#only_mweb').show();

        	  deal_btn.text('APP에서 구매하기');
        	  deal_btn.removeAttr('onclick');
        	  deal_btn.attr('onclick',"$('#app_only').show();");
          }
		}
	});

	//상품 영역
	var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=29";

	$.ajax({
		  dataType : "json"
		, url	   : loadUrl
		, success  : function(result){
			var tab = result.T;
			for(var idx = 0; idx < 14; idx ++){
				var listSize = (idx < 6) ? 2 : 4;
				var no = "";
				if(idx > 5 && idx < 10){
					no = 32;
				}else if(idx >= 10){
					no = 37;
				}else{
					no = 16 + (idx*2);
				}
				makeHtml = "";
				$.each(tab[idx].GOODS, function(i,v){
					var minprice = (v.MINPRICE == null) ? 0 : v.MINPRICE;

					if((i % listSize) == 0)
						makeHtml += "<ul class='items clearfix'>";
					makeHtml += "<li class='item'>";
					makeHtml +=	"	<a href='javascript:void(0);' onclick='itemClick("+v.MODELNO+", "+minprice+"); ga_log("+no+")'>";
					makeHtml +=	"		<span class='thumb'>";
					makeHtml += "			<img src='"+v.GOODS_IMG+"' alt='상품이미지' onerror = 'replaceImg(this);'>";
					if(minprice == 0 || minprice == null){
						makeHtml +=	"			<span class='soldout'>soldout</span> <!-- 품절시 노출 -->";
					}
					makeHtml +=	"		</span>";
					makeHtml +=	"		<span class='pro_info'>";
					makeHtml +=	"			<span class='pro_name'>"+v.TITLE1+"<br>"+v.TITLE2+"</span>";
					makeHtml +=	"			<span class='price'>";
					makeHtml +=	"				<span class='price_label'>최저가</span>";
					makeHtml +=	"				<em>"+commaNum(minprice)+"</em>";
					makeHtml +=	"				<span class='pro_unit'>원</span>";
					makeHtml +=	"			</span>";
					makeHtml +=	"		</span>";
					makeHtml +=	"	</a>";
					makeHtml += "</li>";
					if(i % listSize == (listSize - 1) || i == tab[idx].GOODS.length)
						makeHtml += "</ul>";
				});
				if(idx < 6){
					$('#pro_anc_0'+(idx+1)+' .itemlist').html(makeHtml);
				}else{
					$('#protab'+ (parseInt((idx-6)/4 + 1)) + '-' + ((idx-6)%4 + 1) +' .itemlist').html(makeHtml);
				}
			}
		}
	   , complete : function(){
		// 상품 슬라이드 관련
			$(".item_recomm_group").each(function(e){
				var proSlide = $(this).find('.itemlist').slick({
					dots:true,
					slidesToScroll: 1
				});
			});
			// 상품 슬라이드 관련
			var slickSlide = function(el){
				var $wrap = $(el);
				// 탭초기화
				$wrap.find(".tab_content").hide();
				$wrap.find("ul.pro_tabs li").eq(0).addClass("active").show();
				$wrap.find(".tab_content").eq(0).show();
				// 슬라이드 실행
				var proSlide = $(el + ' .itemlist').slick({
					dots:true,
					slidesToScroll: 1
				});
				// 클릭이벤트
				$wrap.find("ul.pro_tabs li").click(function() {
					if ( !$(this).hasClass("active") ){
						$wrap.find("ul.pro_tabs li").removeClass("active");
						$(this).addClass("active")
						$wrap.find(".tab_content").hide();
						var activeTab = $(this).find("a").attr("href");
						$(activeTab).fadeIn();
						proSlide.slick("setPosition");
					}
					return false;
				});
			}
			// 슬라이드 실행
			var slide1 = new slickSlide('.item_group_01');
			var slide2 = new slickSlide('.item_group_02');

			//파라이터값 tab 이동
			var tab = "<%=tab%>";
			var protab = "<%=protab%>";
			var $navHgt = Math.ceil($('.floattab__list').height());
			switch (tab){
				case "1":
					$('html, body').stop().animate({scrollTop: Math.ceil($('#evt1').offset().top)}, 500);
					break;
				case "2":
					$('html, body').stop().animate({scrollTop: Math.ceil($('#evt2').offset().top)}, 500);
					break;
				case "3":
					$('html, body').stop().animate({scrollTop: Math.ceil($('#evt3').offset().top)}, 500);
					break;
				case "4":
					$('html, body').stop().animate({scrollTop: Math.ceil($('#evt4').offset().top)}, 500);
					break;
			}


			switch (protab){
				case "1":
					$('html, body').stop().animate({scrollTop: Math.ceil($('#pro_anc_01').offset().top)}, 500);
					break;
				case "2":
					$('html, body').stop().animate({scrollTop: Math.ceil($('#pro_anc_02').offset().top)}, 500);
					break;
				case "3":
					$('html, body').stop().animate({scrollTop: Math.ceil($('#pro_anc_03').offset().top)}, 500);
					break;
				case "4":
					$('html, body').stop().animate({scrollTop: Math.ceil($('#pro_anc_04').offset().top)}, 500);
					break;
				case "5":
					$('html, body').stop().animate({scrollTop: Math.ceil($('#pro_anc_05').offset().top)}, 500);
					break;
				case "6":
					$('html, body').stop().animate({scrollTop: Math.ceil($('#pro_anc_06').offset().top)}, 500);
					break;
			}
	    }
	});
});

function fnDeal(seq){
	if(islogin()){
		if(!getSnsCheck()){
			if (confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?") == true){
				location.href="<%=ConfigManager.ENURI_COM_SSL%>/mobilefirst/member/myAuth.jsp?cmdType=modify&f=p";
			}else{
				return false;
			}
		}else{
			ga_log(8);
			$.ajax({
				type : "GET",
				url  : "/eventPlanZone/ajax/getExhdealUrl.jsp",
				data : {
						"seq" : seq,
						"osTpCd" : getOsType()
					   },
			   async : false,
			   dataType : "JSON",
			   success  : function(result){
				   if(result.soldoutYN == "Y"){
					   alert("품절 되었습니다.");
				   }else if(result.moveUrl != ""){
					   window.open(result.moveUrl);
					   $.getJSON("/eventPlanZone/ajax/ctuExhDeal.jsp", {"exh_id":"2019080200", "goods_seq":seq , "shop_code":"55"}, function(data) {});
				   }else{
					   alert("다시 시도해주세요.");
				   }
				   return false;
			   },
			   error    : function(){
				   alert("잘못 된 접근입니다.");
			   }
			});
		}
	}else{
		alert("로그인 후 참여할 수 있습니다.");
		goLogin('emoneyPoint');
		return;
	}
}

//sns 인증
function getSnsCheck() {
	var snsCertify;
	$.ajax({
		type: "GET",
		url: "/member/ajax/getMemberCetify.jsp",
		dataType: "JSON",
		async : false,
		success: function(json){
			var snsdcd = json["snsdcd"]; //sns회원유무 K:카카오, N:네이버
			snsCertify = json["certify"];
			if(snsdcd==""){
				snsCertify = true;
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
	});
	return snsCertify;
}

function replaceImg(obj){
	$(obj).error(function(){
		$(obj).attr("src","http://img.enuri.info/images/home/recommend_none_300_m.jpg");
    });
	var imgsrc = $(obj).attr("src").replace("webimage_300","webimage2");
	$(obj).attr("src",imgsrc);
}

function itemClick(modelNo, minprice) {
	if(minprice > 0){
		window.open('/mobilefirst/detail.jsp?modelno=' + modelNo + '&freetoken=vip');
	}else{
		alert("품절된 상품 입니다.");
		return false;
	}
}

function YYYYMMDDHHMMSS(today) {
	function pad2(n){ return (n < 10 ? '0' : '') + n; }

	return	today.getFullYear() + pad2(today.getMonth() + 1) + pad2(today.getDate())
			+ pad2(today.getHours()) + pad2(today.getMinutes()) + pad2(today.getSeconds());
}

function getWeek(date){
	var week = new Array('일','월','화','수','목','금','토');
	var date = new Date(date.substring(0,4)+"-"+date.substring(4,6)+"-"+date.substring(6,8)).getDay();
	var dayOfWeek = week[date];

	return dayOfWeek;
}

function gaCall(){
	var gaLabel = [
					 "19 추석통합기획전_PV"
					,"19 추석통합기획전_상단탭_타임딜"
					,"19 추석통합기획전_상단탭_BEST추석선물"
					,"19 추석통합기획전_상단탭_가격대별선물"
					,"19 추석통합기획전_상단탭_즐기자추석"
					,"19 추석통합기획전_상단플로팅배너"
					,"19 추석통합기획전_딜_상품보기"
					,"19 추석통합기획전_딜_APP구매하기"
					,"19 추석통합기획전_딜_썸네일"
					,"19 추석통합기획전_중단앵커_한우선물"
					,"19 추석통합기획전_중단앵커_신선식품"
					,"19 추석통합기획전_중단앵커_가공식품"
					,"19 추석통합기획전_중단앵커_생활용품"
					,"19 추석통합기획전_중단앵커_건강선물"
					,"19 추석통합기획전_중단앵커_상품권"
					,"19 추석통합기획전_한우선물_상품클릭"
					,"19 추석통합기획전_한우선물_상품더보기"
					,"19 추석통합기획전_신선선물_상품클릭"
					,"19 추석통합기획전_신선선물_상품더보기"
					,"19 추석통합기획전_가공선물_상품클릭"
					,"19 추석통합기획전_가공선물_상품더보기"
					,"19 추석통합기획전_생활선물_상품클릭"
					,"19 추석통합기획전_생활선물_상품더보기"
					,"19 추석통합기획전_건강선물_상품클릭"
					,"19 추석통합기획전_건강선물_상품더보기"
					,"19 추석통합기획전_상품권선물_상품클릭"
					,"19 추석통합기획전_상품권선물_상품더보기"
					,"19 추석통합기획전_가격대별_탭_1만원이하"
					,"19 추석통합기획전_가격대별_탭_1~5만원"
					,"19 추석통합기획전_가격대별_탭_5~10만원"
					,"19 추석통합기획전_가격대별_탭_10만원이상"
					,"19 추석통합기획전_가격대별_상품클릭"
					,"19 추석통합기획전_즐기자_탭_e쿠폰"
					,"19 추석통합기획전_즐기자_탭_게임기"
					,"19 추석통합기획전_즐기자_탭_가정식"
					,"19 추석통합기획전_즐기자_탭_보드게임"
					,"19 추석통합기획전_즐기자_상품클릭"
					,"19 추석통합기획전_프로모션 띠배너"
					,"19 추석통합기획전_혜택배너"
	               ];
	var vEvent_title = "19 추석";

	function innerCall(param){
		if(param == 1){
			ga('send', 'pageview', {'page': vEvent_page, 'title': gaLabel[0]});
		}else{
			ga('send', 'event', 'mf_event', vEvent_title, gaLabel[param - 1]);
		}
	}
	return innerCall;
}

//앱설치버튼
function install_btt(){
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        window.location.href = "https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8";
    }else if(navigator.userAgent.indexOf("Android") > -1){
    		window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
    }
}

function welcomeGa(strEvent){
	if(app == "Y"){
		try{
			if(window.android){ // 안드로이드
				window.android.igaworksEventForApp(strEvent);
			}else if(/iPhone|iPad|iPod/i.test(navigator.userAgent)){ // 아이폰에서 호출
				location.href = "enuriappcall://igaworksEventForApp?strEvent="+strEvent;
			}
		}catch(e){}
	}
}
</script>

<script type="text/javascript">
/*레이어*/

$(function(){
	//스크롤
	var nav = $('.myarea');
	$(window).scroll(function () {
		if ($(this).scrollTop() > $(".toparea").height()) {
			nav.addClass("f-nav");
		} else {
			nav.removeClass("f-nav");
		}
	});
})
function onoff(id){
	var mid = $("#"+id);
	if(mid.css("display") !== "none"){
		mid.css("display","none");
	}else{
		mid.css("display","");
	}
}
/*checkbox*/
function agreechk(obj){
	if (obj.className== 'unchk') {
		obj.className = 'chk';
	} else {
		obj.className = 'unchk';
	}
}
</script>
</body>
</html>