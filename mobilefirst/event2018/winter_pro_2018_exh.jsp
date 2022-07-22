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
	response.sendRedirect("/event2018/winter_pro_2018_exh.jsp");
	return;
}

String chkId   = ChkNull.chkStr(request.getParameter("chk_id"),"");
String cUserId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK"),"");

Members_Proc members_proc = new Members_Proc();
String cUsername = members_proc.getUserName(cUserId);
String userArea = cUsername;

long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String sdt =dayTime.format(new Date(cTime));//진짜시간

//test
if( request.getServerName().indexOf("dev.enuri.com") > -1 && request.getParameter("sdt")!=null && !request.getParameter("sdt").equals("")){
    sdt= request.getParameter("sdt");
}

String strUrl = request.getRequestURI();

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;

    if(cUsername.equals("")){
        userArea = cUserNick;
    }
    if(userArea.equals("")){
        userArea = cUserId;
    }
}
String strFb_title = "[에누리 가격비교]";
String strFb_description = "월동준비 기획전";
String strFb_img = ConfigManager.IMG_ENURI_COM + "/images/mobilenew/images/logo_enuri.png";
String tab = ChkNull.chkStr(request.getParameter("tab"));
String flow = ChkNull.chkStr(request.getParameter("flow"));
String evtUrl = "/mobilefirst/evt/winter_pro_2018.jsp?freetoken=event";
%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<meta property="og:title" content="<%=strFb_title%>">
	<meta property="og:description" content="<%=strFb_description%>">
	<meta property="og:image" content="<%=strFb_img%>">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/winter_m.css"/>
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/lib/animate.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
</head>
<body>

<div class="wrap">

    <!-- 개인화영역 -->
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>

	<!-- 상단비주얼 -->
	<div class="visual">
		<img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/m_visual.jpg" alt="완벽월동준비" class="imgs">
	</div>

	<!-- 플로팅 탭 -->
	<div  class="floattab__list">
		<div class="scrollList">
			<ul class="floatmove">
				<li><a href="#evt1" onclick="ga_log(2);" class="floattab__item floattab__item--01 is-on"><em>월동준비핫템</em></a></li>
				<li><a href="#evt2" onclick="ga_log(3);" class="floattab__item floattab__item--02"><em>난방진열용품</em></a></li>
				<li><a href="#evt3" onclick="ga_log(4);" class="floattab__item floattab__item--03"><em>단열방한용품</em></a></li>
				<li><a href="#evt4" onclick="ga_log(5);" class="floattab__item floattab__item--04"><em>겨울침구세트</em></a></li>
				<li><a href="#evt5" onclick="ga_log(6);" class="floattab__item floattab__item--05"><em>방한패션의류</em></a></li>
				<li class="evt_join"><a href="javascript:void(0);" title="페이지 이동">해피머니 이벤트</a></li>
			</ul>
		</div>
        <a href="javascript:///" class="btn_tabmove"><em>탭 이동</em></a>
		<script type="text/javascript">
			$('li.evt_join').click(function() {
				window.open('<%=evtUrl%>&tab=evt2');
				ga_log(7);
			});

            //플로팅 상단 탭 이동
            $(document).on('click', '.floattab__list .floatmove a', function(e) {
                var $anchor = Math.ceil($($(this).attr('href')).offset().top);
                   $navHgt = Math.ceil($(".floattab__list").height() + $('div.myarea').height());

                $('html, body').stop().animate({scrollTop: $anchor - $navHgt}, 500);
                e.preventDefault();
            });

            $(window).load(function(){
                var $nav = $(".floattab__list"), // scroll tabs
                    $navTop = $nav.offset().top,
                    $myHgt = $(".myarea").height();

                var $ares1 = Math.ceil($("#evt1").offset().top - $nav.outerHeight()),
                    $ares2 = Math.ceil($("#evt2").offset().top - $nav.outerHeight()),
                    $ares3 = Math.ceil($("#evt3").offset().top - $nav.outerHeight()),
                    $ares4 = Math.ceil($("#evt4").offset().top - $nav.outerHeight()),
                    $ares5 = Math.ceil($("#evt5").offset().top - $nav.outerHeight());

                // 상단 탭 position 변경 및 버튼 활성화
                $(window).scroll(function(){
	                var $currY = $(this).scrollTop() + $myHgt // 현재 scroll

                    if ($currY > $navTop) {
                        $nav.addClass("is-fixed");
    					$("#evt1").css("margin-top", $nav.outerHeight());

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
                            $(".scrollList").scrollLeft(0);
                        }else if($ares4 <= $currY && $ares5 > $currY){
                            $nav.find("a").removeClass("is-on");
                            $(".floattab__item--04").addClass("is-on");
                            $(".scrollList").scrollLeft($(".floattab__item--01").width() * 4);
                        }else if($ares5 <= $currY){
                            $nav.find("a").removeClass("is-on");
                            $(".floattab__item--05").addClass("is-on");
                            $(".scrollList").scrollLeft($(".floattab__item--01").width() * 5);
                        }
                    } else {
                        $nav.removeClass("is-fixed"),
                        $("#evt1").css("margin-top", 60);
                    }

                    // 윈도우 닫기버튼
                    if($(this).scrollTop() >= $(".visual").height()){
                        $(".myarea").addClass("f-nav");
                    }else{
                        $(".myarea").removeClass("f-nav");
                    }
                });

                $(".go_top").click(function(){
                    $(".scrollList").scrollLeft(0);
                    $('div.floattab__list > div.scrollList > ul.floatmove > li > .is-on').removeClass("is-on");
                    $('div.floattab__list > div.scrollList > ul.floatmove > li:eq(0) > a').eq(0).addClass("is-on");
                });

                $(".btn_tabmove").click(function(){
                    $(".scrollList").scrollLeft(300);
                });
            });
    	</script>
    </div>
    <!-- //플로팅 탭 -->

	<!-- 월동준비 핫템 -->
	<div id="evt1" class="hot_item">
		<h2><img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/m_hotitem_tit.png" alt="" class="imgs"></h2>
		<div class="item_inner">
			<div id="dwSlide" class="dw_detail">
				<!-- item -->
				<!-- item -->
			</div>
		</div>
	</div>
	<!-- //월동준비 핫템 -->

	<!-- 윈터 핫 키워드 -->
	<div class="hot_keyword">
		<h2><img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/pc_hotkeyword_tit.png" alt="Winter Hot keyword" class="imgs"></h2>
		<ul class="keyword">
			<li><a href="/mobilefirst/list.jsp?freetoken=list&cate=240524" target="_blank" title="욕실난방"><img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/keyword_01.png" class="imgs"></a></li>
			<li><a href="/mobilefirst/list.jsp?freetoken=list&cate=093116" target="_blank" title="난방텐트"><img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/keyword_02.png" class="imgs"></a></li>
			<li><a href="/mobilefirst/list.jsp?freetoken=list&cate=092332" target="_blank" title="롱패딩"><img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/keyword_03.png" class="imgs"></a></li>
			<li><a href="/mobilefirst/list.jsp?freetoken=list&cate=092029" target="_blank" title="핫팩"><img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/keyword_04.png" class="imgs"></a></li>
			<li><a href="/mobilefirst/list.jsp?freetoken=list&cate=211505" target="_blank" title="차량용품"><img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/keyword_05.png" class="imgs"></a></li>
			<li><a href="/mobilefirst/list.jsp?freetoken=list&cate=09202901" target="_blank" title="휴대용난로"><img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/keyword_06.png" class="imgs"></a></li>
			<li><a href="/mobilefirst/list.jsp?freetoken=list&cate=15021504" target="_blank" title="김장용품"><img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/keyword_07.png" class="imgs"></a></li>
			<li><a href="/mobilefirst/list.jsp?freetoken=list&cate=15081307" target="_blank" title="겨울간식"><img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/keyword_08.png" class="imgs"></a></li>
		</ul>
	</div>
	<!-- //윈터 핫 키워드 -->
    <script type="text/javascript">
	    $('div.hot_keyword > ul > li').click(function() {
	    	ga_log(9);
	    });
    </script>

	<!-- //배너영역1 -->
	<div class="pr1">
		<a href="<%=evtUrl%>&tab=evt2" target="_blank" class="ban_prize" title="프로모션 새창 이동">
			<img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/m_banner_01.jpg" class="imgs" alt="해피머니 3만원권 추첨 증정" />
		</a>
	</div>
	<!-- //배너영역1 -->
    <script type="text/javascript">
	    $('div.pr1 > a').click(function() {
	    	ga_log(10);
	    });
    </script>

	<!-- 난방준비 -->
	<div id="evt2" class="priceListWrap">
		<h2><img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/m_ittem_tit_01.png" alt="난방준비" class="imgs"></h2>
		<!-- liveProduct -->
		<div class="liveProduct">
			<div class="tab_content">
				<ul></ul>
				<div class="more_btn">
					<a href="/mobilefirst/list.jsp?freetoken=list&cate=240502" target="_blank" onclick="ga_log(16);"><img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/btn_more.png" alt="" class="imgs"></a>
				</div>
			</div>
		</div>
		<!-- //liveProduct -->
	</div>
	<!-- 난방준비 -->

	<!-- 단열준비 -->
	<div id="evt3" class="priceListWrap bg-gray">
		<h2><img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/m_ittem_tit_02.png" alt="단열준비" class="imgs"></h2>
		<!-- liveProduct -->
		<div class="liveProduct">
			<div class="tab_content">
				<ul></ul>
				<div class="more_btn">
					<a href="/mobilefirst/list.jsp?freetoken=list&cate=120813" target="_blank" onclick="ga_log(18);"><img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/btn_more.png" alt="" class="imgs"></a>
				</div>
			</div>
		</div>
		<!-- //liveProduct -->
	</div>
	<!-- 단열준비 -->

	<!-- 겨울패션 -->
	<div id="evt4" class="priceListWrap">
		<h2><img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/m_ittem_tit_03.png" alt="난방준비" class="imgs"></h2>
		<!-- liveProduct -->
		<div class="liveProduct">
			<div class="tab_content">
				<ul></ul>
				<div class="more_btn">
					<a href="/mobilefirst/list.jsp?freetoken=list&cate=091220" target="_blank" onclick="ga_log(20);"><img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/btn_more.png" alt="" class="imgs"></a>
				</div>
			</div>
		</div>
		<!-- //liveProduct -->
	</div>
	<!-- 겨울패션 -->

	<!-- 김장준비 -->
	<div id="evt5" class="priceListWrap bg-gray">
		<h2><img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/m_ittem_tit_04.png" alt="난방준비" class="imgs"></h2>
		<!-- liveProduct -->
		<div class="liveProduct">
			<div class="tab_content">
				<ul></ul>
				<div class="more_btn">
					<a href="/mobilefirst/list.jsp?freetoken=list&cate=16110917" target="_blank" onclick="ga_log(22);"><img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/btn_more.png" alt="" class="imgs"></a>
				</div>
			</div>
		</div>
		<!-- //liveProduct -->
	</div>
	<!-- 김장준비 -->

	<!-- //배너영역2 -->
	<div class="pr2">
		<a href="<%=evtUrl%>&tab=evt1" target="_blank" class="ban_prize" title="프로모션 새창 이동">
			<img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/m_banner_02.jpg" class="imgs" alt="스타벅스 카페라떼 증정" />
		</a>
	</div>
	<!-- //배너영역2 -->
    <script type="text/javascript">
	    $('div.pr2 > a').click(function() {
	    	ga_log(23);
	    });
    </script>

	<!-- 기획전 배너 -->
	<div class="rd_banner" id="recPlanlist1">
		<h2><img src="<%=IMG_ENURI_COM%>/images/event/2018/winter/m_market_tit.png" alt="에누리 여름 기획전" class="imgs" /></h2>
		<div class="rd_contaner">
			<ul class="evtbnr">
				<li><a href="javascript:void(0);"><img src="<%=IMG_ENURI_COM%>/images/event/2018/familymonth/winter_2018_1.png" alt="겨울 아우터 기획전"  /></a></li>
				<li><a href="javascript:void(0);"><img src="<%=IMG_ENURI_COM%>/images/event/2018/familymonth/winter_2018_2.png" alt="겨울 방한용품 e머니 추가 적립"  /></a></li>
				<li><a href="javascript:void(0);"><img src="<%=IMG_ENURI_COM%>/images/event/2018/familymonth/winter_2018_3.png" alt="겨울 방한용품 e머니 추가 적립"  /></a></li>
				<li><a href="javascript:void(0);"><img src="<%=IMG_ENURI_COM%>/images/event/2018/familymonth/winter_2018_4.png" alt="패딩 e머니 추가 적립"  /></a></li>
				<li><a href="javascript:void(0);"><img src="<%=IMG_ENURI_COM%>/images/event/2018/familymonth/winter_2018_5.png" alt="김장재료 CM기획전"  /></a></li>
			</ul>
			<a href="javascript:///" class="total" onclick="onoff('layer_planlist')">전체+</a>
		</div>
	</div>
	<!--// 기획전 배너 -->

	<!-- 기획전 스프레드 레이어 -->
	<div class="dim" id="layer_planlist" style="display: none;">
		<div class="planlist_view">
			<h2>추천기획전<a href="javascript:///" class="close" onclick="onoff('layer_planlist')">창닫기</a></h2>
			<div class="inner" style="height:500px;">
				<ul>
					<li><img src="<%=IMG_ENURI_COM%>/images/event/2018/familymonth/winter_2018_1.png" alt="겨울 아우터 기획전" ></li>
					<li><img src="<%=IMG_ENURI_COM%>/images/event/2018/familymonth/winter_2018_2.png" alt="겨울 방한용품 e머니 추가 적립"></li>
					<li><img src="<%=IMG_ENURI_COM%>/images/event/2018/familymonth/winter_2018_3.png" alt="겨울 방한용품 e머니 추가 적립"></li>
					<li><img src="<%=IMG_ENURI_COM%>/images/event/2018/familymonth/winter_2018_4.png" alt="패딩 e머니 추가 적립" ></li>
					<li><img src="<%=IMG_ENURI_COM%>/images/event/2018/familymonth/winter_2018_5.png" alt="김장재료 CM기획전" ></li>
				</ul>
			</div>
		</div>
	</div>
	<!-- //기획전 스프레드 레이어 -->
	<script type="text/javascript">
		$("#recPlanlist1, #layer_planlist").find("li").click(function(e){
			ga_log(24);
			var exhNo = [
				"20181016140001","20181012101020","20171025100606","20181019050505", "20181025051212"
			];
			var idx = e.currentTarget.className.indexOf("slick") > -1 ? $(this).index()-1 : $(this).index();
			window.open("/mobilefirst/planlist.jsp?t=B_"+exhNo[idx] + "&freetoken=planlist");
		});
	</script>

	<!-- 에누리 혜택 -->
	<%@include file="/eventPlanZone/jsp/eventBannerTapMobile_201806.jsp"%>
	<!-- //에누리 혜택 -->
		<script type="text/javascript">
		$('div.otherbene > h2').html("<img src=\"<%=IMG_ENURI_COM%>/images/event/2018/winter/m_otherbene_tit.png\" alt=\"에누리 혜택\" class=\"imgs\">");
		$(".banlist > li").click(function(){
			ga_log(25);
		});
	</script>

	<!-- layer-->
	<div class="layer_back" id="app_only" style="display:none;">
		<div class="appLayer">
			<h4>모바일 앱 전용 이벤트</h4>
			<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
			<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
			<p class="btn_close"><button type="button">설치하기</button></p>
		</div>
	</div>
	<span class="go_top"><a href="javascript:void(0);" onclick="$(window).scrollTop(0);">TOP</a></span>
</div>

<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20180831"></script>

<script type="text/javascript">
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로

var ga_log;
var isFlow = "<%=flow%>" == "ad";

$(document).ready(function() {
	ga_log = gaCall();

	//로그인시 개인화영역
	if(islogin()){
		$("#user_id").text("<%=cUserId%>");
		getPoint();//개인e머니 내역 노출
	}

	function gaCall() {
		var gaLabel = [
						'월동준비 통합기획전_PV',
						'월동준비_앵커탭_월동HOT템',
						'월동준비_앵커탭_난방전열용품',
						'월동준비_앵커탭_단열방한용품',
						'월동준비_앵커탭_겨울침구세트',
						'월동준비_앵커탭_방한패션의류',
						'월동준비_앵커탭_해피머니이벤트',
						'월동준비HOT템_대표상품',
						'HOT키워드_클릭',
						'월동준비_배너_구매이벤트',
						'겨울나기템_탭_난방전열용품',
						'겨울나기템_탭_단열방한용품',
						'겨울나기템_탭_겨울침구세트',
						'겨울나기템_탭_방한패션의류',
						'겨울나기템_난방전열용품_상품클릭',
						'겨울나기템_난방전열용품_더보기',
						'겨울나기템_단열방한용품_상품클릭',
						'겨울나기템_단열방한용품_더보기',
						'겨울나기템_겨울침구세트_상품클릭',
						'겨울나기템_겨울침구세트_더보기',
						'겨울나기템_방한패션의류_상품클릭',
						'겨울나기템_방한패션의류_더보기',
						'월동준비_배너_매일이벤트',
						'월동준비_CM배너',
						'월동준비_혜택배너'
		               ];
		if (isFlow) gaLabel = [
						'DA_월동준비 통합기획전_PV',
						'월동준비_앵커탭_월동HOT템',
						'월동준비_앵커탭_난방전열용품',
						'월동준비_앵커탭_단열방한용품',
						'월동준비_앵커탭_겨울침구세트',
						'월동준비_앵커탭_방한패션의류',
						'월동준비_앵커탭_해피머니이벤트',
						'DA_월동준비HOT템_대표상품',
						'DA_월동준비HOT키워드_클릭',
						'월동준비_배너_구매이벤트',
						'겨울나기템_탭_난방전열용품',
						'겨울나기템_탭_단열방한용품',
						'겨울나기템_탭_겨울침구세트',
						'겨울나기템_탭_방한패션의류',
						'DA_월동준비_난방전열용품_상품클릭',
						'DA_월동준비_난방전열용품_더보기',
						'DA_월동준비_단열방한용품_상품클릭',
						'DA_월동준비_단열방한용품_더보기',
						'DA_월동준비_겨울침구세트_상품클릭',
						'DA_월동준비_겨울침구세트_더보기',
						'DA_월동준비_방한패션의류_상품클릭',
						'DA_월동준비_방한패션의류_더보기',
						'월동준비_배너_매일이벤트',
						'DA_월동준비_CM배너',
						'월동준비_혜택배너'
		               ];

		var vEvent_title = "월동준비";
		if (isFlow)	vEvent_title = "DA_월동준비";

		function innerCall (param) {
			if ( param == 1 ) {
	 			ga('send', 'pageview', {'page': vEvent_page,'title': vEvent_title + " 통합기획전_" + "PV"});
			} else {
				if (!isFlow || gaLabel[param-1].length > 0)
	 				ga('send', 'event', 'mf_event', vEvent_title, gaLabel[param-1]);
			}
		}
		return innerCall;
	}

	/* 데이터 로드 영역 */
	var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=21";

	//전체 상품 데이터
	var	ajaxData = (function() {
	    var json = {};
	    $.ajax({
	        'async': false,
	        'global': false,
	        'url': loadUrl,
	        'dataType': "json",
	        'success': function (data) {
		    	json = data.T;
	        }
	    });
	    return json;
	})();

	var makeHtml = "";
	var img = "";

	// 월동준비
	$.each(ajaxData[0].GOODS, function(i, v) {
		img = v.GOODS_IMG ? v.GOODS_IMG : v.IMG_SRC;
		if (img == "") {
			img = "<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png";
		}

		makeHtml += "<div class=\"d_item\">                                                                                         ";
		makeHtml += "	<div class=\"_photo\">                                                                                      ";
		makeHtml += "		<div class=\"fade_list\">                                                                               ";
		makeHtml += "           <a href=\"javascript:void(0);\" onclick=\"ga_log(8);itemClick('"+v.MODELNO+"','"+v.MINPRICE3+"');\">";
		makeHtml += "           	<span class=\"thumb\">                                                                          ";
		makeHtml += "           		<img src=\""+img+"\" alt=\"\" />                                                            ";
		if (v.MINPRICE3 == 0) {
			makeHtml += "           		<span class=\"soldout\">SOLD OUT</span>                                                 ";
		}
		makeHtml += "           	</span>                                                                                         ";
		makeHtml += "           	<span class=\"pro_info\">                                                                       ";
		makeHtml += "           		<span class=\"title\">"+v.TITLE1+"<br>"+v.TITLE2+"</span>                                   ";
		makeHtml += "           		<span class=\"discount\">최저가 <b>"+commaNum(v.MINPRICE3)+"</b>원</span>                   ";
		makeHtml += "           	</span>                                                                                         ";
		makeHtml += "           </a>                                                                                                ";
		makeHtml += "		</div>                                                                                                  ";
		makeHtml += "	</div>                                                                                                      ";
		makeHtml += "</div>                                                                                                         ";
	});
	$('#evt1 div.item_inner div.dw_detail').append(makeHtml).load();	// slick 붙이기
	makeHtml="";

	// 난방준비, 단열준비, 겨울패션, 김장준비
	var arrItemLog = [15,17,19,21];
	for (var idx=1; idx<5; idx++) {
		$.each(ajaxData[idx].GOODS, function(i, v) {
			if (i < 8) {
				img = v.GOODS_IMG ? v.GOODS_IMG : v.IMG_SRC;
				if (img == "") {
					img = "<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png";
				}

				makeHtml += "<li>                                                                                                                                              ";
				makeHtml += "	<a href=\"javascript:void(0);\" onclick=\"ga_log("+arrItemLog[idx-1]+");itemClick('"+v.MODELNO+"','"+v.MINPRICE3+"');\" title=\"새 탭에서 열립니다.\" class=\"btn\">                                                                   ";
				makeHtml += "		<div class=\"imgs\">                                                                                                                       ";
				makeHtml += "			<img src=\""+img+"\" class=\"lazy\" alt=\"\" />                                                                                        ";
				if (v.MINPRICE3 == 0) {
			    	makeHtml += "            <span class=\"soldout\">SOLD OUT</span>                                                                                           ";
				}
				makeHtml += "		</div>                                                                                                                                     ";
				makeHtml += "		<div class=\"info\">                                                                                                                       ";
				makeHtml += "			<p class=\"pname\">"+v.TITLE1+"<br>"+v.TITLE2+"</p> ";
				makeHtml += "			<p class=\"price\"><span class=\"lowst\">최저가</span><i>"+commaNum(v.MINPRICE3)+"</i>원</p>                                           ";
				makeHtml += "		</div>                                                                                                                                     ";
				makeHtml += "	</a>                                                                                                                                           ";
				makeHtml += "</li>                                                                                                                                             ";
			}
		});
		$('#evt'+(idx+1)+' > div.liveProduct > div.tab_content > ul').append(makeHtml);
		makeHtml="";
	};
});

function itemClick(modelNo, minprice) {
	if(minprice > 0){
		window.open('/mobilefirst/detail.jsp?modelno=' + modelNo +'&freetoken=vip');
	}else{
		alert("품절된 상품 입니다.");
	}
}

//동적인 이미지 호출
$("img.lazy").lazyload({
    effect: 'fadeIn',
    effectTime : 500
});

// 탭이동
$(window).load(function() {
	// PV
	ga_log(1);

	//닫기버튼
	$( ".win_close" ).click(function(){
		if(getCookie("appYN") == 'Y'){
			window.location.href = "close://";
		}else{
			window.location.replace("/mobilefirst/index.jsp");
		}
	});

	var tab = "<%=tab%>";
    var $navTop = $(".floattab__list").height() + $(".myarea").height();
	switch (tab) {
	case "contArea1":	//난방준비
		$('html, body').stop().animate({scrollTop:Math.ceil($('#evt2').offset().top) - $navTop}, 500);
		break;
	case "contArea2":	//단열준비
		$('html, body').stop().animate({scrollTop:Math.ceil($('#evt3').offset().top) - $navTop}, 500);
		break;
	case "contArea3":	//겨울패션
		$('html, body').stop().animate({scrollTop:Math.ceil($('#evt4').offset().top) - $navTop}, 500);
		break;
	case "contArea4":	//김장준비
		$('html, body').stop().animate({scrollTop:Math.ceil($('#evt5').offset().top) - $navTop}, 500);
		break;
	}
});
</script>

<script type="text/javascript">
/* 퍼블 */
//여름 필수템 pick 플리킹
$('#dwSlide').load(function() {
	$(this).slick({
		dots:true,
		slidesToShow: 1,
		slidesToScroll: 1,
		autoplay: true,
		autoplaySpeed: 3000
	});
});

// 기획전 배너
$('.evtbnr').slick({
	dots: true,
	arrows: false,
	infinite: true,
	speed: 300,
	slidesToShow: 1,
	adaptiveHeight: true,
	autoplay: true,
	autoplaySpeed: 3000
});

// 모바일 닫기
$(".rd_banner a.total").click(function(){
	$(".wrap a.win_close").css("display", "none");
});

//레이어
function onoff(id) {
	var mid = $("#"+id);
	if (mid.css("display") !== "none") {
		mid.css("display","none");
	} else {
		mid.css("display","");
	}
}
</script>

</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
