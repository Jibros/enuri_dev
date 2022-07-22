<%@ page contentType="text/html; charset=utf-8" %>
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
	response.sendRedirect("/event2019/family_2019.jsp");
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

String strFb_title = "[에누리 가격비교]";
String strFb_description = "2019 가정의달 통합기획전";
String strFb_img = ConfigManager.IMG_ENURI_COM + "/images/mobilenew/images/logo_enuri.png";
String tab = ChkNull.chkStr(request.getParameter("tab"));
String protab = ChkNull.chkStr(request.getParameter("protab"));
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<meta property="og:title" content="에누리 가격비교">
<meta property="og:description" content="에누리 모바일 가격비교">
<meta property="og:image" content="<%=IMG_ENURI_COM%>/images/mobilenew/images/logo_enuri.png">
<meta name="format-detection" content="telephone=no" />
<link rel="stylesheet" href="/css/event/y2019/family/special/mobile.css" type="text/css">
<link rel="stylesheet" type="text/css" href="http://m.enuri.com/mobilefirst/css/lib/slick.css"/>
<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
<script type="text/javascript" src="/event2016/js/event_common.js"></script>
</head>
<body>

<div id="eventWrap">
	<!-- 개인화영역 -->
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>
	<!-- 상단비주얼 -->

	<!-- 플로팅 배너 - 둥둥이 -->
    <div id="floating_bnr" class="floating_bnr">
        <a target="_blank" href="/mobilefirst/event2019/family_2019_evt.jsp?tab=2&freetoken=event" onclick="ga_log(7);"><img src="<%=IMG_ENURI_COM%>/images/event/2019/familySpecial/fl_bnr.png" alt="가정의달 선물 반값특가"></a>
        <!-- 닫기 -->
        <a href="#" class="btn_close" onclick="onoff('floating_bnr');return false;">
            <span class="blind">닫기</span>
        </a>
    </div>
    <!-- // -->

	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">
		<!-- 상단비주얼 -->
		<div class="visual">
			<div class="contents">
				<h1 class="blind">감사합니다. 5! 사랑가득 해피데이</h1>
				<img src="<%=IMG_ENURI_COM%>/images/event/2019/familySpecial/m_top_anim.gif" alt="" style="opacity:.3">
			</div>
		</div>

		<!-- 플로팅 탭 -->
		<div class="floattab">
			<div class="floattab__list">
				<div class="scrollList">
					<ul class="floatmove">
						<li><a href="#evt1" class="floattab__item floattab__item--01"><em>매주목요일 반값특가</em></a></li>
						<li><a href="#evt2" class="floattab__item floattab__item--02"><em>우리아이 선물 추천</em></a></li>
						<li><a href="#evt3" class="floattab__item floattab__item--03"><em>부모님 선물추천</em></a></li>
						<li><a href="#evt4" class="floattab__item floattab__item--04"><em>성년 선물추천</em></a></li>
						<li><a href="#evt5" class="floattab__item floattab__item--05"><em>가족 즐길거리</em></a></li>
					</ul>
				</div>
				<a href="javascript:///" class="btn_tabmove next"><em>탭 이동</em></a>

				<script>
					//플로팅 상단 탭 이동
					$(document).on('click', '.floattab__list .floatmove a', function(e) {
						var $anchor = Math.ceil($($(this).attr('href')).offset().top);
							$navHgt = Math.ceil($(".floattab__list").height());
						$('html, body').stop().animate({scrollTop: $anchor - $navHgt}, 500);
						e.preventDefault();
						ga_log($(this).parents().index() + 2);
					});
				</script>
			</div>
		</div>
	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<!-- DEAL페이지 -->
	<div id="evt1" class="section dealwrap scroll">
		<div class="obj_01"></div>
		<div class="contents">
			<div class="tit">
				<h2><img src="<%=IMG_ENURI_COM%>/images/event/2019/familySpecial/m_deal_tit.png" alt="가정의달 선물 반값 특가"></h2>
				<div class="deal_date">
					<div class="date_item visible"><img src="<%=IMG_ENURI_COM%>/images/event/2019/familySpecial/m_sale_date_01.png" alt="4/25"></div>
					<div class="date_item"><img src="<%=IMG_ENURI_COM%>/images/event/2019/familySpecial/m_sale_date_02.png" alt="5/2"></div>
					<div class="date_item"><img src="<%=IMG_ENURI_COM%>/images/event/2019/familySpecial/m_sale_date_03.png" alt="5/9"></div>
				</div>
			</div>
			<!-- 딜 구매영역 -->
			<div class="deal_slide">
				<!-- 딜 아이템 loop -->
				<!-- //딜 아이템 loop -->
			</div>
			<!-- //딜 구매영역 -->

			<!-- 딜 리스트영역 -->
			<div class="deal_list">
				<h4>Next Week</h4>
				<div class="deal_nav">
				</div>
			</div>
			<!--// 딜 리스트영역 -->
			<!-- 화살표 -->
			<div class="deal_arrow">
				<div class="arrow prev"></div>
				<div class="arrow next"></div>
			</div>
		</div>
	</div>
	<!-- //DEAL페이지 -->

	<!-- 추천 상품 영역 -->
	<div class="section pro_itemlist">
		<h2><img src="<%=IMG_ENURI_COM%>/images/event/2019/familySpecial/m_goods_tit.jpg" alt="사랑하는 가족에게 감사의 선물"></h2>
		<div class="contents">

			<!-- 우리아이 선물 추천 -->
			<div id="evt2" class="item_group item_group_01 scroll">
				<h3><img src="<%=IMG_ENURI_COM%>/images/event/2019/familySpecial/m_goods1_tit.png" alt="우리아이 선물 추천"></h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active" id="1"><a href="#protab1" onclick = ga_log(11);>#남아완구</a></li>
					<li id="2"><a href="#protab2" onclick = ga_log(12);>#여아완구</a></li>
					<li id="3"><a href="#protab3" onclick = ga_log(13);>#퀵보드</a></li>
					<li id="4"><a href="#protab4" onclick = ga_log(14);>#게임기</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 남아완구 상품 -->
					<!--
						SLICK $(".itemlist")
						4개의 탭 콘텐츠가 있습니다. "tab_content"
						하나의 콘텐츠마다 ul 단위로 한 판(상품4개)씩 움직입니다.
					-->
					<div id="protab1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more">상품더보기</a>
					</div>
					<!-- //남아완구 상품 -->

					<!-- 여아완구 상품 -->
					<div id="protab2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more">상품더보기</a>
					</div>
					<!-- //여아완구 상품 -->

					<!-- 퀵보드 상품 -->
					<div id="protab3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more">상품더보기</a>
					</div>
					<!-- //퀵보드 상품 -->

					<!-- 게임기 상품 -->
					<div id="protab4" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more">상품더보기</a>
					</div>
					<!-- //게임기 상품 -->
				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 우리아이 선물추천 -->
			<script type="text/javascript">
				$('.item_group_01 .btn_more').on('click', function(e) {
					var arrMore = [
					                "/mobilefirst/list.jsp?cate=1024&freetoken=list"
					               ,"/mobilefirst/list.jsp?cate=1009&freetoken=list"
					               ,"/mobilefirst/list.jsp?cate=0906&freetoken=list"
					               ,"/mobilefirst/list.jsp?cate=040831&freetoken=list"
			            		  ];
					window.open(arrMore[$(this).parents().index()]);
					ga_log(16);
				});
			</script>

			<!-- 부모님 선물추천 -->
			<div id="evt3" class="item_group item_group_02 scroll">
				<h3><img src="<%=IMG_ENURI_COM%>/images/event/2019/familySpecial/m_goods2_tit.png" alt="부모님 선물추천"></h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active" id="5"><a href="#protab5" onclick = ga_log(17);>#건강식품</a></li>
					<li id="6"><a href="#protab6" onclick = ga_log(18);>#안마기</a></li>
					<li id="7"><a href="#protab7" onclick = ga_log(19);>#상품권</a></li>
					<li id="8"><a href="#protab8" onclick = ga_log(20);>#가전용품</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 건강식품 상품 -->
					<div id="protab5" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more">상품더보기</a>
					</div>
					<!-- //건강식품 상품 -->

					<!-- 안마기 상품 -->
					<div id="protab6" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more">상품더보기</a>
					</div>
					<!-- //안마기 상품 -->

					<!-- 상품권 상품 -->
					<div id="protab7" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more">상품더보기</a>
					</div>
					<!-- //상품권 상품 -->

					<!-- 계절가전 상품 -->
					<div id="protab8" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more">상품더보기</a>
					</div>
					<!-- //계절가전 상품 -->
				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 부모님 선물추천 -->
			<script type="text/javascript">
				$('.item_group_02 .btn_more').on('click', function(e) {
					var arrMore = [
								    "/mobilefirst/list.jsp?cate=150105&freetoken=list"
								   ,"/mobilefirst/list.jsp?cate=051015&freetoken=list"
								   ,"/mobilefirst/list.jsp?cate=164722&freetoken=list"
								   ,"/mobilefirst/list.jsp?cate=2406&freetoken=list"
			            		  ];
					window.open(arrMore[$(this).parents().index()]);
					ga_log(22);
				});
			</script>

			<!-- 성년 선물추천 -->
			<div id="evt4" class="item_group item_group_03 scroll">
				<h3><img src="<%=IMG_ENURI_COM%>/images/event/2019/familySpecial/m_goods3_tit.png" alt="성년 선물추천"></h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active" id="9"><a href="#protab9" onclick = ga_log(23);>#패션의류</a></li>
					<li id="10"><a href="#protab10" onclick = ga_log(24);>#향수</a></li>
					<li id="11"><a href="#protab11" onclick = ga_log(25);>#화장품</a></li>
					<li id="12"><a href="#protab12" onclick = ga_log(26);>#가방/지갑</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 패션의류 상품 -->
					<div id="protab9" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more">상품더보기</a>
					</div>
					<!-- //패션의류 상품 -->

					<!-- 향수 상품 -->
					<div id="protab10" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more">상품더보기</a>
					</div>
					<!-- //향수 상품 -->

					<!-- 화장품 상품 -->
					<div id="protab11" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more">상품더보기</a>
					</div>
					<!-- //화장품 상품 -->

					<!-- 가방/지갑 상품 -->
					<div id="protab12" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more">상품더보기</a>
					</div>
					<!-- //가방/지갑 상품 -->
				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 성년 선물추천 -->
			<script type="text/javascript">
				$('.item_group_03 .btn_more').on('click', function(e) {
					var arrMore = [
								    "/mobilefirst/list.jsp?cate=1436&freetoken=list"
								   ,"/mobilefirst/list.jsp?cate=0810&freetoken=list"
								   ,"/mobilefirst/list.jsp?cate=0803&freetoken=list"
								   ,"/mobilefirst/list.jsp?cate=1455&freetoken=list"
					              ];
					window.open(arrMore[$(this).parents().index()]);
					ga_log(28);
				});
			</script>

			<!-- 가족즐길거리 추천 -->
			<div id="evt5" class="item_group item_group_04 scroll">
				<h3><img src="<%=IMG_ENURI_COM%>/images/event/2019/familySpecial/m_goods4_tit.png" alt="가족즐길거리 추천"></h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active" id="13"><a href="#protab13" onclick = ga_log(29);>#외식</a></li>
					<li id="14"><a href="#protab14" onclick = ga_log(30);>#테마파크</a></li>
					<li id="15"><a href="#protab15" onclick = ga_log(31);>#영화,공연관람</a></li>
					<li id="16"><a href="#protab16" onclick = ga_log(32);>#보드게임</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 외식 상품 -->
					<div id="protab13" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more">상품더보기</a>
					</div>
					<!-- //외식 상품 -->

					<!-- 테마파크 상품 -->
					<div id="protab14" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more">상품더보기</a>
					</div>
					<!-- //테마파크 상품 -->

					<!-- 영화,공연관람 상품 -->
					<div id="protab15" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more">상품더보기</a>
					</div>
					<!-- //영화,공연관람 상품 -->

					<!-- 보드게임 상품 -->
					<div id="protab16" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more">상품더보기</a>
					</div>
					<!-- //보드게임 상품 -->
				</div>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 가족즐길거리 추천 -->
			<script type="text/javascript">
				$('.item_group_04 .btn_more').on('click', function(e) {
					var arrMore = [
								    "/mobilefirst/list.jsp?cate=164716&freetoken=list"
								   ,"/mobilefirst/list.jsp?cate=164705&freetoken=list"
								   ,"/mobilefirst/list.jsp?cate=164708&freetoken=list"
								   ,"/mobilefirst/list.jsp?cate=164404&freetoken=list"
					              ];
					window.open(arrMore[$(this).parents().index()]);
					ga_log(33);
				});
			</script>
		</div>
	</div>
	<!-- //추천 상품 영역 -->

	<!-- 스타벅스 초콜렛모카 당첨 -->
	<div class="event_bnr">
		<a target="_blank" href="/mobilefirst/event2019/family_2019_evt.jsp?tab=1&freetoken=event" onclick = ga_log(35);>
			<img src="<%=IMG_ENURI_COM%>/images/event/2019/familySpecial/m_starbucks_bnr.jpg" alt="매일 이벤트 참여하고 스타벅스 초콜렛 모카 당첨">
		</a>
	</div>
	<!-- // -->

	<!-- 에누리 혜택 -->
	<%@include file="/eventPlanZone/jsp/eventBannerTapMobile_xmas_2018.jsp"%>
	<!-- //에누리 혜택 -->
	<script type="text/javascript">
		$(".banlist > li").click(function(){
			var arrMore = [];
			ga_log(36);
		});
	</script>
	<!-- //Contents -->

	<span class="go_top"><a href="#">TOP</a></span>
</div>

<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20190402"></script>
<!-- layer-->
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();">설치하기</button></p>
	</div>
</div>

<script type="text/javascript">
	var username = "<%=userArea%>"; //개인화영역 이름
	var vChkId = "<%=chkId%>";
	var vEvent_page = "<%=strUrl%>"; //경로
	var ga_log;
	$(document).ready(function() {
		ga_log = gaCall();

		if(islogin()){
			$("#user_id").text("<%=userId%>");
			getPoint();//개인e머니 내역 노출
		}

		function gaCall() {
			var gaLabel = [
							 '19 가정의달 통합기획전 PV'
							,'19 가정의달 통합기획전_탭_타임딜'
							,'19 가정의달 통합기획전_탭_아이선물'
							,'19 가정의달 통합기획전_탭_부모님선물'
							,'19 가정의달 통합기획전_탭_성년선물'
							,'19 가정의달 통합기획전_탭_즐길거리'
							,'19 가정의달 통합기획전_탭_플로팅'
							,'19 가정의달 통합기획전_타임딜_상품보기'
							,'19 가정의달 통합기획전_타임딜_구매하기'
							,'19 가정의달 통합기획전_타임딜_썸네일'
							,'19 가정의달 통합기획전_우리아이_탭_남아추천'
							,'19 가정의달 통합기획전_우리아이_탭_여아추천'
							,'19 가정의달 통합기획전_우리아이_탭_퀵보드'
							,'19 가정의달 통합기획전_우리아이_탭_컴퓨터'
							,'19 가정의달 통합기획전_우리아이_상품구매'
							,'19 가정의달 통합기획전_우리아이_상품더보기'
							,'19 가정의달 통합기획전_부모님_탭_건강식품'
							,'19 가정의달 통합기획전_부모님_탭_안마기'
							,'19 가정의달 통합기획전_부모님_탭_상품권'
							,'19 가정의달 통합기획전_부모님_탭_가전'
							,'19 가정의달 통합기획전_부모님_상품구매'
							,'19 가정의달 통합기획전_부모님_상품더보기'
							,'19 가정의달 통합기획전_성년_탭_패션의류'
							,'19 가정의달 통합기획전_성년_탭_향수'
							,'19 가정의달 통합기획전_성년_탭_화장품'
							,'19 가정의달 통합기획전_성년_탭_가방'
							,'19 가정의달 통합기획전_성년_상품구매'
							,'19 가정의달 통합기획전_성년_상품더보기'
							,'19 가정의달 통합기획전_즐길거리_탭_외식'
							,'19 가정의달 통합기획전_즐길거리_탭_테마파크'
							,'19 가정의달 통합기획전_즐길거리_탭_영화'
							,'19 가정의달 통합기획전_즐길거리_탭_보드게임'
							,'19 가정의달 통합기획전_즐길거리_상품구매'
							,'19 가정의달 통합기획전_즐길거리_상품더보기'
							,'19 가정의달 통합기획전_프로모션띠배너'
							,'19 가정의달 통합기획전_혜택배너'
			              ];

			var vEvent_title = "19 가정의달";

			function innerCall (param) {
				if ( param == 1 ) {
		 			ga('send', 'pageview', {'page': vEvent_page,'title': vEvent_title + " 통합기획전_" + "PV"});
				} else {
	 				ga('send', 'event', 'mf_event', vEvent_title, gaLabel[param-1]);
				}
			}
			return innerCall;
		}

		var makeHtml = "";
		var img = "";
		var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=27";

		//전체 데이터
		var	ajaxData = (function() {
		    var json = {};
		    $.ajax({
		        async: false,
		        global: false,
		        url: loadUrl,
		        dataType: "json",
		        success: function (data) {
			    	json = data.T;
		        }
		    });
		    return json;
		})();

		for(var idx=0; idx<16; idx++){
			var arrLog = [15,21,27,33];
			$.each(ajaxData[idx].GOODS, function(i, v) {
				img = v.GOODS_IMG ? v.GOODS_IMG : v.IMG_SRC;
				if(i % 4 == 0)
					makeHtml += "<ul class=\"items clearfix\">";
				makeHtml += "	<li class=\"item\">";
				makeHtml += "		<a target=\"_blank\" title=\"새 탭에서 열립니다.\" class=\"btn\" onclick=\"ga_log("+arrLog[parseInt(idx/4)]+");itemClick('"+v.MODELNO+"','"+v.MINPRICE+"')\">";
				makeHtml += "			<span class=\"thumb\">";
				makeHtml += "				<img src="+img+" alt=\"상품이미지\" onerror=\"replaceImg(this);\"/>";
				if(v.MINPRICE == 0 || v.MINPRICE == null){
					makeHtml += "<span class=\"soldout\">soldout</span>";
				}
				makeHtml += "			</span>";
				makeHtml += "			<span class=\"pro_info\">";
				makeHtml += "				<span class=\"pro_name\">"+v.TITLE1+"<br>"+v.TITLE2+"</span>";
				makeHtml += "				<span class=\"price\">";
				makeHtml += "				<span class=\"price_label\">최저가</span>";
				makeHtml += "					<em>"+commaNum(v.MINPRICE)+"</em>";
				makeHtml += "					<span class=\"pro_unit\">원</span>";
				makeHtml += "				</span>";
				makeHtml += "			</span>";
				makeHtml += "		</a>";
				makeHtml += "	</li>";
				if(i % 4 == 3 || i == ajaxData[idx].GOODS.length)
					makeHtml += "</ul>";
			});
			$('#protab'+(idx+1)+' .itemlist').html(makeHtml);
			makeHtml = "";
		}

		//딜영역
		var htmlInfos = [{
			"img"  : "<%=IMG_ENURI_COM%>/images/event/2019/familySpecial/m_sale_img_01.jpg?v=20190409",
			"period": "4/25(목) 2PM"
		},
		{   "img"  : "<%=IMG_ENURI_COM%>/images/event/2019/familySpecial/m_sale_img_02.jpg?v=20190409",
			"period": "5/2(목) 2PM"
		},
		{   "img"  : "<%=IMG_ENURI_COM%>/images/event/2019/familySpecial/m_sale_img_03.jpg?v=20190409",
			"period": "5/9(목) 2PM"
		}];

		$.ajax({
			url      : "/mobilefirst/http/json/exh_deal_list_2019040200.json",
			dataType : "JSON",
			cache    : false,
			success  : function(data) {
				var vCur_dtm = YYYYMMDDHHMMSS(new Date());
				var dealItem = "", dealList = "";
				$.each(data, function(i,v) {
					dealItem += "	<div class=\"deal_item clearfix\">";
					dealItem += "		<div class=\"container\">";
					dealItem += "			<div class=\"thumb\">";
					dealItem += "				<img src="+htmlInfos[i].img+" alt=\"\" />";
			        dealItem += "   		</div>";
			        dealItem += "			<div class=\"item_info\">";
			        dealItem += "       		<p class=\"tit\">"+v.GD_MODEL_NM1+"<br>"+v.GD_MODEL_NM2+"</p>";
			        dealItem += "       		<p class=\"price\"><strong>"+commaNum(v.GD_DC_PRC)+"<span>원</span></strong></p>";
			        dealItem += "   			<ul class=\"btn_area clearfix\" id=\"ul_btn"+i+"\">";
		        	dealItem += "       			<li><a href=\"/detail.jsp?modelno="+v.GD_MODEL_NO+"&freetoken=vip\" class=\"deal_btn dview\" onclick=\"ga_log(8);\" target=\"_blank\">상품보기</a></li>";
			        if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT > vCur_dtm) {
			        	dealItem += "       		<li><a class=\"deal_btn time14\">판매예정</a></li>";
			        } else if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT <= vCur_dtm && v.GD_SAL_E_DTM_CVT >= vCur_dtm) {
			        	dealItem += "       		<li><a class=\"deal_btn goapp\" onclick=\"ga_log(9); fnDeal("+v.EXH_DEAL_NO+"); return false;\">구매하기</a></li>";
			        } else {
			        	dealItem += "       		<li><a class=\"deal_btn soldout\">품절</a></li>";
			        }
			        dealItem += "   			</ul>";
			        dealItem += "   		</div>";
		        	dealItem += "   		<p class=\"ad\">※ <em>쿠폰적용 필수</em> / ID당 1회 / 무료배송 <span class=\"mark\"><img src=\"http://img.enuri.info/images/event/2019/familySpecial/logo_inter.png\" alt=\"인터파크\"></span></p>";
		        	dealItem += "		</div>";
		        	dealItem += "	</div>";

		        	dealList += "	<div class=\"w_item\" onclick=\"ga_log(10);\">";
		        	dealList += "		<div class=\"period\">";
		        	dealList += "			<span>"+htmlInfos[i].period+"</span>";
		        	dealList += "		</div>";
		        	dealList += "		<div class=\"w_thumb\">";
		        	dealList += "			<img src=\"http://storage.enuri.info"+v.GD_IMG_URL+"\" alt=\"\" />";
		        	dealList += "		</div>";
		        	dealList += "		<span class=\"w_tit\">"+v.GD_MODEL_NM1+"<br>"+v.GD_MODEL_NM2+"</span>";
		        	dealList += "	</div>";

		        	if(i==2) return false;
				});
				$('#evt1 .deal_slide').html(dealItem);
				$('#evt1 .deal_list .deal_nav').html(dealList);
			},
			complete : function(data){
				$('.deal_slide').slick({
					slidesToShow: 1,
					slidesToScroll: 1,
					arrows: false,
					dots: true,
					fade: false,
					//speed: 0,
					asNavFor: '.deal_nav'
				}).on("beforeChange", function(e, slick, currentSlide, nextslide){
					$('.deal_nav .w_item').removeClass("slick-current");
					$('.deal_nav .w_item').eq(nextslide).addClass("slick-current");
					$('.deal_date .date_item').removeClass("visible");
					$('.deal_date .date_item').eq(nextslide).addClass("visible");
				});
	            $('.deal_nav').slick({
					slidesToShow: 3,
					slidesToScroll: 1,
					asNavFor: '.deal_slide',
					dots: false,
					centerMode: false,
					focusOnSelect: true,
					variableWidth: true
				});
				//  화살표 이전
				$('.deal_arrow .arrow.prev').on('click', function(e) {
					var index = $('.deal_slide').slick("slickCurrentSlide");
					$('.deal_slide').slick('slickPrev');

					$('.deal_nav .w_item').removeClass("slick-current");
					$('.deal_nav .w_item').eq(--index).addClass("slick-current");
				});
				//  화살표 다음
				$('.deal_arrow .arrow.next').on('click', function(e) {
					var index = $('.deal_slide').slick("slickCurrentSlide");
					$('.deal_slide').slick('slickNext');
					$('.deal_nav .w_item').removeClass("slick-current");
					if(index === 2){
						$('.deal_nav .w_item').eq(0).addClass("slick-current");
					}else{
						$('.deal_nav .w_item').eq(++index).addClass("slick-current");
					}
				});

				for(var i = 0; i < 3; i++){
	        		if($("#ul_btn"+i+" li a").hasClass("soldout")){
	        		} else {
		        		$('.deal_slide').slick('slickGoTo', i, false);
	        		}
	    		}
			}
		});
	});

	function itemClick(modelNo, minprice) {
		if (minprice > 0) {
			window.open('/mobilefirst/detail.jsp?modelno=' + modelNo+ '&freetoken=vip');
		} else {
			alert("품절된 상품 입니다.");
			return false;
		}
	}

	function fnDeal(seq){
		if(islogin()){
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
					   $.getJSON("/eventPlanZone/ajax/ctuExhDeal.jsp", {"exh_id":"2019040200", "goods_seq":seq , "shop_code":"55"}, function(data) {});
				   }else{
					   alert("다시 시도해주세요.");
				   }
				   return false;
			   },
			   error    : function(){
				   alert("잘못 된 접근입니다.");
			   }
			});
		}else{
			alert("로그인 후 참여할 수 있습니다.");
			goLogin('emoneyPoint');
			return;
		}
	}

	function YYYYMMDDHHMMSS(today) {
		return	today.getFullYear() + pad2(today.getMonth() + 1) + pad2(today.getDate())
				+ pad2(today.getHours()) + pad2(today.getMinutes()) + pad2(today.getSeconds());
		function pad2(n) { return (n < 10 ? '0' : '') + n; }
	}

	function replaceImg(obj){
		$(obj).error(function(){
			$(obj).attr("src","http://img.enuri.info/images/home/recommend_none_300_m.jpg");
	    });
		var imgsrc = $(obj).attr("src").replace("webimage_300","webimage2");
		$(obj).attr("src",imgsrc);
	}

</script>

<script type="text/javascript">
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
	$(window).on("load",function(){
		ga_log(1);
		// 슬라이드 실행
		var slide1 = new slickSlide('.item_group_01');
		var slide2 = new slickSlide('.item_group_02');
		var slide3 = new slickSlide('.item_group_03');
		var slide4 = new slickSlide('.item_group_04');

		//tab
		var $nav = $(".floattab__list"), // scroll tabs
			$navTop = $nav.offset().top;

		$ares1 = $("#evt1").offset().top - $nav.outerHeight();
		$ares2 = $("#evt2").offset().top - $nav.outerHeight();
		$ares3 = $("#evt3").offset().top - $nav.outerHeight();
		$ares4 = $("#evt4").offset().top - $nav.outerHeight();
		$ares5 = $("#evt5").offset().top - $nav.outerHeight();

		// 상단 탭 position 변경 및 버튼 활성화
		$(window).scroll(function(){
			var $currY = $(this).scrollTop() // 현재 scroll

			if ($currY > $navTop-1) {
				$nav.addClass("is-fixed");

				if($ares1 <= $currY && $ares2 > $currY){
					$nav.find("a").removeClass("is-on");
					$(".floattab__item--01").addClass("is-on");
					$(".scrollList").scrollLeft(0);
				}else if($ares2 <= $currY && $ares3 > $currY){
					$nav.find("a").removeClass("is-on");
					$(".floattab__item--02").addClass("is-on");
					$(".scrollList").scrollLeft(0);
				}else if($ares3 <= $currY && $ares4 > $currY){
					$nav.find("a").removeClass("is-on");
					$(".floattab__item--03").addClass("is-on");
					$(".scrollList").scrollLeft($(".floattab__item--01").width() * 2 - 30);
				}else if($ares4 <= $currY && $ares5 > $currY){
					$nav.find("a").removeClass("is-on");
					$(".floattab__item--04").addClass("is-on");
					$(".scrollList").scrollLeft($(".floattab__item--01").width() * 2 - 30);
				}else if($ares5 <= $currY){
					$nav.find("a").removeClass("is-on");
					$(".floattab__item--05").addClass("is-on");
					$(".scrollList").scrollLeft($(".floattab__item--01").width() * 3 - 30);
				}
			} else {
				$nav.removeClass("is-fixed"),
				$nav.find("a").removeClass("is-on");
			}
		});

		$(".scrollList").on("scroll", function(){
			var st = $(".scrollList").scrollLeft();
			if (st >= $(".floattab__item--01").width() * 1 - 30){
				$(".btn_tabmove").removeClass("next");
				$(".btn_tabmove").addClass("prev");
			}else{
				$(".btn_tabmove").removeClass("prev");
				$(".btn_tabmove").addClass("next");
			}
		});

		var tab = "<%=tab%>";
		var	$navHgt = Math.ceil($(".floattab__list").height());
		switch (tab){
			case "1":
				$('html, body').stop().animate({scrollTop: Math.ceil($($('.floattab__item--01').attr('href')).offset().top) - $navHgt}, 500);
				break;
			case "2":
				$('html, body').stop().animate({scrollTop: Math.ceil($($('.floattab__item--02').attr('href')).offset().top) - $navHgt}, 500);
				break;
			case "3":
				$('html, body').stop().animate({scrollTop: Math.ceil($($('.floattab__item--03').attr('href')).offset().top) - $navHgt}, 500);
				break;
			case "4":
				$('html, body').stop().animate({scrollTop: Math.ceil($($('.floattab__item--04').attr('href')).offset().top) - $navHgt}, 500);
				break;
			case "5":
				$('html, body').stop().animate({scrollTop: Math.ceil($($('.floattab__item--05').attr('href')).offset().top) - $navHgt}, 500);
				break;
		}

		// protab으로 이동
		var protab = "<%=protab%>";
		if(protab > 0 && protab < 17){
			if(protab < 5){
				floattab = ".floattab__item--02"
			}else if(protab < 9){
				floattab = ".floattab__item--03"
			}else if(protab < 13){
				floattab = ".floattab__item--04"
			}else{
				floattab = ".floattab__item--05"
			}
			$("ul.pro_tabs li#"+protab).trigger("click");
			$('html, body').stop().animate({scrollTop: Math.ceil($($(floattab).attr('href')).offset().top) - $navHgt}, 500);
		}

		//닫기버튼
		$( ".win_close" ).click(function(){
			if(getCookie("appYN") == 'Y'){
				window.location.href = "close://";
			}else{
				window.location.replace("/mobilefirst/index.jsp");
			}
		});
	});
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
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>