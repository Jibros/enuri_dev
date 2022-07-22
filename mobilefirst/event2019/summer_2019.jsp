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
	response.sendRedirect("/event2019/summer_2019.jsp");
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
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<meta NAME="description" CONTENT="여름시즌상품 구매하고, 아이패드 받아가세요!">
<meta NAME="keyword" CONTENT="에누리가격비교, 통합기획전, 무더위, 여름준비, 여름상품, 바캉스,여름휴가">
<title>여름준비 통합기획전 – 최저가 쇼핑은 에누리</title>
<meta property="og:title" content="여름준비 통합기획전 – 최저가 쇼핑은 에누리">
<meta property="og:description" content="여름시즌상품 구매하고, 아이패드 받아가세요!">
<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
<meta name="format-detection" content="telephone=no" />
<link rel="stylesheet" href="/css/event/y2019/hotsummer_m.css" type="text/css">
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
        <a href="/mobilefirst/event2019/summer_2019_evt.jsp?tab=1&freetoken=event" onclick="ga_log(8);" target="_blank"><img src="http://img.enuri.info/images/event/2019/hot_summer/fl_bnr.png" alt="매일매일 스타벅스 공짜!"></a>
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
				<h1 class="top_tit">
					<span class="txt_01">여름</span><span class="txt_02">준비</span>
				</h1>
				<span class="top_txt">
					<span class="txt_01">매주 목요일 최대 80% 할인</span>
					<span class="txt_02">완벽한 여름 준비 한번에!</span>
					<span class="obj_seed_01"></span>
					<span class="obj_seed_02"></span>
				</span>
				<span class="obj_top"></span> <!-- 수박 -->
				<span class="obj_swim_01"></span> <!-- 수영하는 사람 -->
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
			<div class="floattab__list">
				<div class="scrollList">
					<ul class="floatmove">
						<li><a href="#evt1" class="floattab__item floattab__item--01"><em>최대 80% 타임딜</em></a></li>
						<li><a href="#evt2" class="floattab__item floattab__item--02"><em>시원하게! 계절가전</em></a></li>
						<li><a href="#evt3" class="floattab__item floattab__item--03"><em>센스있게! 여름패션</em></a></li>
						<li><a href="#evt4" class="floattab__item floattab__item--04"><em>더위극복! 바캉스용품</em></a></li>
						<li><a href="#evt5" class="floattab__item floattab__item--05"><em>집이 좋아! 홈캉스</em></a></li>
						<li><a href="#evt6" class="floattab__item floattab__item--06"><em>원기회복! 여름별미</em></a></li>
					</ul>
				</div>
				<a href="javascript:///" class="btn_tabmove next"><em>탭 이동</em></a>
			</div>
		</div>
	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<!-- DEAL페이지 -->
	<div id="evt1" class="section dealwrap scroll">
		<div class="contents">
			<h2><img src="http://img.enuri.info/images/event/2019/hot_summer/m_deal_tit.png" alt="선착순 한정수량 여름시즌템 타임특가"></h2>
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
			</div>
			<!--// 딜 리스트영역 -->
		</div>
	</div>
	<!-- //DEAL페이지 -->

	<!-- 추천 상품 영역 -->
	<div class="section pro_itemlist">
		<h2><img src="http://img.enuri.info/images/event/2019/hot_summer/m_goods_tit.png" alt="더위타파! 여름나기 추천템과 함께"></h2>
		<div class="inner">

			<!-- 시원하게 계절가전 -->
			<div id="evt2" class="item_group item_group_01 scroll">
				<h3>
					<strong class="txt_tit">#시원하게! 계절가전</strong>
					<span class="txt_sub">2019 무더위 HOT ITEM</span>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab1-1" onclick="ga_log(12);">#에어컨</a></li>
					<li><a href="#protab1-2" onclick = "ga_log(13);">#제습기</a></li>
					<li><a href="#protab1-3" onclick = "ga_log(14);">#공기순환기</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">
					<!--
						SLICK $(".itemlist")
						3개의 탭 콘텐츠가 있습니다. "tab_content"
						하나의 콘텐츠마다 ul 단위로 한 판(상품4개)씩 움직입니다.
					-->
					<!-- 에어컨 상품 -->
					<div id="protab1-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="javascript:void(0);">상품더보기</a>
					</div>
					<!-- //에어컨 상품 -->

					<!-- 제습기 상품 -->
					<div id="protab1-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="javascript:void(0);">상품더보기</a>
					</div>
					<!-- //제습기 상품 -->

					<!-- 공기순환기 상품 -->
					<div id="protab1-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="javascript:void(0);">상품더보기</a>
					</div>
					<!-- //공기순환기 상품 -->
				</div>
				<script>
				$('.item_group_01 .tab_content .btn_more').click(function(){
					var link = [
								  "/mobilefirst/list.jsp?cate=2401&freetoken=list"
								, "/mobilefirst/list.jsp?cate=2403&freetoken=list"
								, "/mobilefirst/list.jsp?cate=2402&freetoken=list"
					            ];
					window.open(link[$(this).parents().index()]);
					ga_log(16);
				});
				</script>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 시원하게! 계절가전-->

			<!-- 센스있게! 여름패션 -->
			<div id="evt3" class="item_group item_group_02 scroll">
				<h3>
					<strong class="txt_tit">#센스있게! 여름패션</strong>
					<span class="txt_sub">2019 무더위 HOT ITEM</span>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab2-1" onclick = "ga_log(17);">#남성여름패션</a></li>
					<li><a href="#protab2-2" onclick = "ga_log(18);">#여성여름패션</a></li>
					<li><a href="#protab2-3" onclick = "ga_log(19);">#신발/잡화</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 남성여름패션 상품 -->
					<div id="protab2-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="javascript:void(0);">상품더보기</a>
					</div>
					<!-- //남성여름패션 상품 -->

					<!-- 여성여름패션 상품 -->
					<div id="protab2-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="javascript:void(0);">상품더보기</a>
					</div>
					<!-- //여성여름패션 상품 -->

					<!-- 신발/잡화 상품 -->
					<div id="protab2-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="javascript:void(0);">상품더보기</a>
					</div>
					<!-- //신발/잡화 상품 -->

				</div>
				<script>
					$('.item_group_02 .tab_content .btn_more').click(function(){
						var link = [
									  "/mobilefirst/list.jsp?cate=143501&freetoken=list"
									, "/mobilefirst/list.jsp?cate=143401&freetoken=list"
									, "/mobilefirst/list.jsp?cate=1454&freetoken=list"
						            ];
						window.open(link[$(this).parents().index()]);
						ga_log(21);
					});
				</script>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 센스있게! 여름패션 -->

			<!-- 더위극복! 바캉스용품 -->
			<div id="evt4" class="item_group item_group_03 scroll">
				<h3>
					<strong class="txt_tit">#더위극복! 바캉스용품</strong>
					<span class="txt_sub">2019 무더위 HOT ITEM</span>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab3-1" onclick = "ga_log(22);">#바캉스용품</a></li>
					<li><a href="#protab3-2" onclick = "ga_log(23);">#여행가방</a></li>
					<li><a href="#protab3-3" onclick = "ga_log(24);">#카메라/액션캠</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 바캉스용품 상품 -->
					<div id="protab3-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="javascript:void(0);">상품더보기</a>
					</div>
					<!-- //바캉스용품 상품 -->

					<!-- 여행가방 상품 -->
					<div id="protab3-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="javascript:void(0);">상품더보기</a>
					</div>
					<!-- //여행가방 상품 -->

					<!-- 카메라/액션캠 상품 -->
					<div id="protab3-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="javascript:void(0);">상품더보기</a>
					</div>
					<!-- //카메라/액션캠 상품 -->

				</div>
				<script>
					$('.item_group_03 .tab_content .btn_more').click(function(){
						var link = [
									  "/mobilefirst/list.jsp?cate=090905&freetoken=list"
									, "/mobilefirst/list.jsp?cate=145508&freetoken=list"
									, "/mobilefirst/list.jsp?cate=023526&freetoken=list"
						            ];
						window.open(link[$(this).parents().index()]);
						ga_log(26);
					});
				</script>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 더위극복! 바캉스용품 -->

			<!-- 집이 좋아! 홈캉스 추천 -->
			<div id="evt5" class="item_group item_group_04 scroll">
				<h3>
					<strong class="txt_tit">#집이 좋아! 홈캉스</strong>
					<span class="txt_sub">2019 무더위 HOT ITEM</span>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab4-1" onclick = "ga_log(27);">#VR/게임기</a></li>
					<li><a href="#protab4-2" onclick = "ga_log(28);">#보드게임</a></li>
					<li><a href="#protab4-3" onclick = "ga_log(29);">#e쿠폰</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- VR/게임기 상품 -->
					<div id="protab4-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="javascript:void(0);">상품더보기</a>
					</div>
					<!-- //VR/게임기 상품 -->

					<!-- 보드게임 상품 -->
					<div id="protab4-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="javascript:void(0);">상품더보기</a>
					</div>
					<!-- //보드게임 상품 -->

					<!-- e쿠폰 상품 -->
					<div id="protab4-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="javascript:void(0);">상품더보기</a>
					</div>
					<!-- //e쿠폰 상품 -->

				</div>
				<script>
					$('.item_group_04 .tab_content .btn_more').click(function(){
						var link = [
									  "/mobilefirst/list.jsp?cate=040829&freetoken=list"
									, "/mobilefirst/list.jsp?cate=16440401&freetoken=list"
									, "/mobilefirst/list.jsp?cate=1647&freetoken=list"
						            ];
						window.open(link[$(this).parents().index()]);
						ga_log(31);
					});
				</script>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 집이 좋아! 홈캉스 추천 -->

			<!-- 원기회복! 여름별미 추천 -->
			<div id="evt6" class="item_group item_group_05 scroll">
				<h3>
					<strong class="txt_tit">#원기회복! 여름별미</strong>
					<span class="txt_sub">2019 무더위 HOT ITEM</span>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active"><a href="#protab5-1" onclick = "ga_log(32);">#복날보양식</a></li>
					<li><a href="#protab5-2" onclick = "ga_log(33);">#빙과류</a></li>
					<li><a href="#protab5-3" onclick = "ga_log(34);">#제철과일</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 콘텐츠 -->
				<div class="tab_container">

					<!-- 복날보양식 상품 -->
					<div id="protab5-1" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="javascript:void(0);">상품더보기</a>
					</div>
					<!-- //복날보양식 상품 -->

					<!-- 빙과류 상품 -->
					<div id="protab5-2" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="javascript:void(0);">상품더보기</a>
					</div>
					<!-- //빙과류 상품 -->

					<!-- 제철과일 상품 -->
					<div id="protab5-3" class="tab_content">
						<div class="itemlist">
						</div>
						<a class="sprite btn_more" href="javascript:void(0);">상품더보기</a>
					</div>
					<!-- //제철과일 상품 -->

				</div>
				<script>
					$('.item_group_05 .tab_content .btn_more').click(function(){
						var link = [
									  "/mobilefirst/list.jsp?cate=15110403&freetoken=list"
									, "/mobilefirst/list.jsp?cate=150819&freetoken=list"
									, "/mobilefirst/list.jsp?cate=150211&freetoken=list"
						            ];
						window.open(link[$(this).parents().index()]);
						ga_log(36);
					});
				</script>
				<!-- //추천상품 콘텐츠 -->
			</div>
			<!-- // 원기회복! 여름별미 추천 -->
		</div>
	</div>
	<!-- //추천 상품 영역 -->

	<!-- 여름시즌템 구매하면 아이패드 6세대 당첨 -->
	<div class="event_bnr">
		<a href="/mobilefirst/event2019/summer_2019_evt.jsp?tab=2&freetoken=event" target="_blank" onclick="ga_log(37);">
			<img src="http://img.enuri.info/images/event/2019/hot_summer/m_ipad_bnr.png" alt="아이패드 6세대 당첨">
		</a>
	</div>
	<!-- // -->

	<!-- 에누리 혜택 -->
	<%@include file="/eventPlanZone/jsp/eventBannerTapMobile_201806.jsp"%>
	<script type="text/javascript">
		$('.banlist li').click(function(){
			ga_log(38);
		});
	</script>
	<!-- //에누리 혜택 -->
	<!-- //Contents -->

	<span class="go_top"><a href="#">TOP</a></span>
</div>
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20190611"></script>
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
var cnt = 0;

$(document).ready(function(){
	ga_log = gaCall();

	if(islogin()){
		$("#user_id").text("<%=userId%>");
		getPoint();//개인e머니 내역 노출
	}

	function gaCall(){
		var gaLabel = [
						 "19 무더위 통합기획전_PV"
						,"19 무더위 통합기획전_상단탭_타임딜"
						,"19 무더위 통합기획전_상단탭_계절가전"
						,"19 무더위 통합기획전_상단탭_여름패션"
						,"19 무더위 통합기획전_상단탭_바캉스"
						,"19 무더위 통합기획전_상단탭_홈캉스"
						,"19 무더위 통합기획전_상단탭_여름별미"
						,"19 무더위 통합기획전_상단플로팅배너"
						,"19 무더위 통합기획전_타임딜_상품보기"
						,"19 무더위 통합기획전_타임딜_APP구매하기"
						,"19 무더위 통합기획전_타임딜_썸네일"
						,"19 무더위 통합기획전_계절가전_탭_에어컨"
						,"19 무더위 통합기획전_계절가전_탭_제습기"
						,"19 무더위 통합기획전_계절가전_탭_공기청정기"
						,"19 무더위 통합기획전_계절가전_상품클릭"
						,"19 무더위 통합기획전_계절가전_상품더보기"
						,"19 무더위 통합기획전_여름패션_탭_남성"
						,"19 무더위 통합기획전_여름패션_탭_여성"
						,"19 무더위 통합기획전_여름패션_탭_신발/잡화"
						,"19 무더위 통합기획전_여름패션_상품구매"
						,"19 무더위 통합기획전_여름패션_상품더보기"
						,"19 무더위 통합기획전_바캉스_탭_바캉스용품"
						,"19 무더위 통합기획전_바캉스_탭_여행가방"
						,"19 무더위 통합기획전_바캉스_탭_카메라"
						,"19 무더위 통합기획전_바캉스_상품클릭"
						,"19 무더위 통합기획전_바캉스_상품더보기"
						,"19 무더위 통합기획전_홈캉스_탭_VR"
						,"19 무더위 통합기획전_홈캉스_탭_보드게임"
						,"19 무더위 통합기획전_홈캉스_탭_e쿠폰"
						,"19 무더위 통합기획전_홈캉스_상품클릭"
						,"19 무더위 통합기획전_홈캉스_상품더보기"
						,"19 무더위 통합기획전_여름별미_탭_보양식"
						,"19 무더위 통합기획전_여름별미_탭_빙과류"
						,"19 무더위 통합기획전_여름별미_탭_제철과일"
						,"19 무더위 통합기획전_여름별미_상품클릭"
						,"19 무더위 통합기획전_여름별미_상품더보기"
						,"19 무더위 통합기획전_프로모션띠배너"
						,"19 무더위 통합기획전_혜택배너"
		               ];
		var vEvent_title = "19 무더위";

		function innerCall(param){
			if(param == 1){
				ga('send', 'pageview', {'page': vEvent_page, 'title': vEvent_title + "통합기획전_" + "PV"});
			}else{
				ga('send', 'event', 'mf_event', vEvent_title, gaLabel[param - 1]);
			}
		}
		return innerCall;
	}

	//딜 상품
	$.ajax({
		  url: "/mobilefirst/http/json/exh_deal_list_2019061100.json"
		, dataType : "json"
		, cache    : false
		, success  : function(data){
			var vCur_dtm = YYYYMMDDHHMMSS(new Date());
			var dealItem = "";
			var dealList = "";
			cnt = data.length;
			$.each(data, function(i,v){
				//딜 판매날짜, 할인률
				var month = parseInt(v.GD_SAL_S_DTM_CVT.substring(4,6));
				var day = parseInt(v.GD_SAL_S_DTM_CVT.substring(6,8));
				var discountRate =  Math.round((v.GD_PRC - v.GD_DC_PRC) / v.GD_PRC * 100);
				var text = discountRate+"% 타임특가 / "+v.GD_QTY+"개 한정";

				dealItem += "<div class=\"deal_item clearfix\">";
				dealItem += "	<div class=\"container\">";
				dealItem += "		<div class=\"thumb\">";
				dealItem += "			<img src=\"http://storage.enuri.info/Web_Storage"+v.GD_IMG_URL+"\" />";
// 				dealItem += "			<img src=\"http://img.enuri.info/images/event/2019/hot_summer/@deal_img.png\" />";
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
                dealItem += "				<li><a href=\"/mobilefirst/detail.jsp?modelno="+v.GD_MODEL_NO+"&freetoken=vip\" class=\"btn_dview\" target=\"_blank\" onclick=\"ga_log(9)\">상품보기</a></li>";
                if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT > vCur_dtm) { //판매 전
	                dealItem += "			<li><a class=\"btn_buy_ready\">판매예정</a></li>";
		        }else if (v.GD_SO_YN == "N" && v.GD_SAL_S_DTM_CVT <= vCur_dtm && v.GD_SAL_E_DTM_CVT >= vCur_dtm) { //판매 중
	                dealItem += "			<li><a class=\"btn_buy\" onclick=\"ga_log(10); fnDeal("+v.EXH_DEAL_NO+"); return false;\">구매하기</a></li>";
		        }else{ // 판매 종료
	                dealItem += "			<li><a class=\"btn_buy_soldout\">Sold out</a></li>";
	        	}
                dealItem += "			</ul>";
                dealItem += "		</div>";
                if(i == 0 || i == 3){
	                dealItem += "	<p class=\"ad\">※ 쿠폰적용 필수 / ID당 1회 / 해외통관번호 필수 <span class=\"mark\"><img src=\"http://img.enuri.info/images/event/2019/familySpecial/logo_inter.png\" alt=\"인터파크\"></span></p>";
                }else{
	                dealItem += "	<p class=\"ad\">※ 쿠폰적용 필수 / ID당 1회 / 무료배송 <span class=\"mark\"><img src=\"http://img.enuri.info/images/event/2019/familySpecial/logo_inter.png\" alt=\"인터파크\"></span></p>";
                }
        	    dealItem += "	</div>";
        	    dealItem += "</div>";

        		dealList += "<div class=\"w_item\" onclick=\"ga_log(11);\">";
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
			$('.deal_slide').slick({
				slidesToShow: 1,
				slidesToScroll: 1,
				arrows: true,
				dots: true,
				fade: false,
				//speed: 0,
				asNavFor: '.deal_nav'
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

          //딜 날짜별 상품 노출
			for(var i = 0; i < cnt; i++){
				if($("#ul_btn"+i+" li a").hasClass("btn_buy_soldout")){
					$('.deal_slide').slick('slickGoTo', i+1, true);
				}else{
					break;
				}
			}
		}
	});

	// 탭 상품
	var makeHtml = "";
	var img = "";
	var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=28";

	$.ajax({
		  async     : true
		, url       : loadUrl
		, dataType  : "json"
		, success   : function(data){
			var ajaxData = data.T;

			for(var idx = 0; idx < 15; idx++){
				var num1 = parseInt(idx/3);
				var num2 = (idx % 3) + 1;
				$.each(ajaxData[idx].GOODS, function(i,v){
					var minprice = (v.MINPRICE == null) ? 0 : v.MINPRICE;
					img = v.GOODS_IMG ? v.GOODS_IMG : v.IMG_SRC;
					if (img == "") {
	    				img = "<%=IMG_ENURI_COM%>/images/m_home/noimg.png";
	    			}
					if(i % 4 == 0)
						makeHtml += "<ul class=\"items clearfix\">";
					makeHtml += "	<li class=\"item\">";
					makeHtml += "		<a title=\"새 탭에서 열립니다.\" class=\"btn\" onclick=\"ga_log("+ (num1 + 3) * 5 +"); itemClick('"+v.MODELNO+"','"+v.MINPRICE+"');\">";
					makeHtml += "			<span class=\"thumb\">";
					makeHtml += "				<img src="+img+" alt=\"상품이미지\" onerror=\"replaceImg(this);\"/>";
					if(minprice == 0){
						makeHtml += "<span class=\"soldout\">soldout</span>";
					}
					makeHtml += "			</span>";
					makeHtml += "			<span class=\"pro_info\">";
					makeHtml += "				<span class=\"pro_name\"><b>"+v.TITLE1+"</b><br><b>"+v.TITLE2+"</b></span>";
					makeHtml += "				<span class=\"price\">";
					makeHtml += "				<span class=\"price_label\">최저가</span>";
					makeHtml += "					<em>"+commaNum(minprice)+"</em>";
					makeHtml += "					<span class=\"pro_unit\">원</span>";
					makeHtml += "				</span>";
					makeHtml += "			</span>";
					makeHtml += "		</a>";
					makeHtml += "	</li>";
					if(i % 4 == 3 || i == ajaxData[idx].GOODS.length)
						makeHtml += "</ul>";
				});
				$('#protab'+(num1 + 1)+'-'+num2+' .itemlist').html(makeHtml);
				makeHtml = "";
			}
		}
		, complete : function(){
			ga_log(1);
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
			var slide3 = new slickSlide('.item_group_03');
			var slide4 = new slickSlide('.item_group_04');
			var slide5 = new slickSlide('.item_group_05');

			//스크롤 tabs
			var posScr = new Array(),
			$nav = $(".floattab__list"), // scroll tabs
			$navTop = $nav.offset().top,
			$scrTarget = $("#eventWrap .scroll"),
			$scrList = $(".scrollList"),
			navPerView = parseInt ( screen.width / $nav.find("li").eq(0).width() , 10) ;
			// 네비 활성화
			var activeNavi = function(num){
				$nav.find("a").removeClass("is-on");
				$nav.find("li").eq(num).find("a").addClass("is-on").siblings().removeClass("is-on");
				var moveToScr = function(num){
					if ( num < navPerView ) return 0;
					else return $nav.find("li").eq(0).width() * ( Math.floor( (num - navPerView) / 2 ) + 2 ) - 30;
				}
				$scrList.scrollLeft( moveToScr(num) );
			}
			// 네비 이동영역의 ScrollTop 보관
			$scrTarget.each(function(e){
				posScr[e] = $(this).offset().top - $nav.outerHeight();
			})
			// 상단 탭 position 변경 및 버튼 활성화
			$(window).scroll(function(){
				var $currY = $(this).scrollTop() // 현재 scroll
				var _nowPos = 0;
				if ($currY > $navTop-1) {
					$nav.addClass("is-fixed");
					$(posScr).each(function(e){
						if ( e != posScr.length -1 ){
							if ( posScr[e] <= $currY && posScr[e+1] > $currY ){
								activeNavi(e);
								return false;
							}
						}else{
							activeNavi(e);
						}
					});
				} else {
					$nav.removeClass("is-fixed").find("a").removeClass("is-on");
				}
			});
			$scrList.on("scroll", function(){
				var st = $scrList.scrollLeft();
				if (st >= $nav.find("li").eq(0).width() * 1 - 30) {
					$(".btn_tabmove").removeClass("next").addClass("prev");
				}else {
					$(".btn_tabmove").removeClass("prev").addClass("next");
				}
			});

			//플로팅 상단 탭 이동
			$(document).on('click', '.floattab__list .floatmove a', function(e) {
				var $anchor = Math.ceil($($(this).attr('href')).offset().top);
					$navHgt = Math.ceil($(".floattab__list").height());
				$('html, body').stop().animate({scrollTop: $anchor - $navHgt}, 500);
				e.preventDefault();

				//탭별 ga_log
				var num = $(this).parents().index() + 2;
				ga_log(num);
			});

			//파라이터값 tab 이동
			var tab = "<%=tab%>";
			var $navHgt = Math.ceil($('.floattab__list').height());
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
				case "6":
					$('html, body').stop().animate({scrollTop: Math.ceil($($('.floattab__item--06').attr('href')).offset().top) - $navHgt}, 500);
					break;
			}
		}
	});

	//닫기버튼
	$( ".win_close" ).click(function(){
		if(getCookie("appYN") == 'Y'){
			window.location.href = "close://";
		}else{
			window.location.replace("/mobilefirst/index.jsp");
		}
	});
});

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
				   $.getJSON("/eventPlanZone/ajax/ctuExhDeal.jsp", {"exh_id":"2019061100", "goods_seq":seq , "shop_code":"55"}, function(data) {});
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