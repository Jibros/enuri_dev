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
}else{ //pc일때 접속페이지 변경.
	response.sendRedirect("/event2018/xmas_2018_exh.jsp");
	return;
}

String chkId     = ChkNull.chkStr(request.getParameter("chk_id"),"");
String cUserId   = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK"),"");

Members_Proc members_proc = new Members_Proc();
String cUsername = members_proc.getUserName(cUserId);
String userArea = cUsername;

// long cTime = System.currentTimeMillis();
// SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
// String sdt =dayTime.format(new Date(cTime));//진짜시간


// if( request.getServerName().indexOf("dev.enuri.com") > -1 && request.getParameter("sdt")!=null && !request.getParameter("sdt").equals("")){
//     sdt= request.getParameter("sdt");
// }

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
String strFb_description = "크리스마스 기획전";
String strFb_img = ConfigManager.IMG_ENURI_COM + "/images/mobilenew/images/logo_enuri.png";
String tab = ChkNull.chkStr(request.getParameter("tab"));
String flow = ChkNull.chkStr(request.getParameter("flow"));
String evtUrl = "/mobilefirst/evt/christmas_pro_2018.jsp?freetoken=event";
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
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/christmas_m.css"/>
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/lib/animate.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
</head>
<body>

<div class="wrap">

    <!-- 개인화영역 -->
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile_xmas_2018.jsp"%>

	<!-- 상단비주얼 -->
	<div id="visual" class="visual">
		<div class="contents">
			<div class="obj_b_star b01 active"></div>
			<div class="obj_b_star b02 active"></div>
			<div class="obj_b_star b03 active"></div>
			<div class="obj_m_star m01 active"></div>
			<div class="obj_s_star s01 active"></div>
			<div class="obj_s_star s02 active"></div>
			<div class="blind">
				<h1>SPECIAL CHRISTMAS</h1>
				<em>2018 어느 멋진 크리스마스를 위한 선물</em>
			</div>
		</div>
	</div>
	<!-- //상단비주얼 -->

	<!-- 플로팅 탭 -->
	<div  class="floattab__list">
		<div class="scrollList">
			<ul class="floatmove">
				<li class="evt_join"><a href="javascript:void(0);" title="페이지 이동">케익추첨이벤트</a></li>
				<li><a href="#evt1" class="floattab__item floattab__item--01"><em>3</em></a></li>
				<li><a href="#evt2" class="floattab__item floattab__item--02"><em>4</em></a></li>
				<li><a href="#evt3" class="floattab__item floattab__item--03"><em>5</em></a></li>
				<li><a href="#evt4" class="floattab__item floattab__item--04"><em>6</em></a></li>
				<li><a href="#evt5" class="floattab__item floattab__item--05"><em>7</em></a></li>
				<li><a href="#evt6" class="floattab__item floattab__item--06"><em>8</em></a></li>
			</ul>
		</div>
        <a href="javascript:///" class="btn_tabmove"><em>탭 이동</em></a>
		<script type="text/javascript">
			$('li.evt_join').click(function() {
				window.open('<%=evtUrl%>&tab=evt2');
				ga_log(2);
			});

	        //플로팅 상단 탭 이동
	        $(document).on('click', '.floattab__list .floatmove a.floattab__item', function(e) {
	            var $anchor = Math.ceil($($(this).attr('href')).offset().top);
	                $navHgt = Math.ceil($(".floattab__list").height() * 1.25);

	            $('html, body').stop().animate({scrollTop: $anchor - $navHgt}, 500);
	            e.preventDefault();
	            ga_log($(this).text());
	        });

	        $(window).on("load",function(){
	            var $nav = $(".floattab__list"), // scroll tabs
	                $navTop = $nav.offset().top,
	                $myHgt = $(".myarea").height(),
	                $navHgt = Math.ceil($(".floattab__list").height() * 1.25);

                var tab = "<%=tab%>";

	                $ares1 = $("#evt1").offset().top - $nav.outerHeight(),
	                $ares2 = $("#evt2").offset().top - $nav.outerHeight(),
	                $ares3 = $("#evt3").offset().top - $nav.outerHeight();
	                $ares4 = $("#evt4").offset().top - $nav.outerHeight();
	                $ares5 = $("#evt5").offset().top - $nav.outerHeight();
					$ares6 = $("#evt6").offset().top - $nav.outerHeight();
					$ares7 = $(".banner_area.pr2").offset().top - $nav.outerHeight();
	            // 상단 탭 position 변경 및 버튼 활성화
	            $(window).scroll(function(){
	                var $currY = $(this).scrollTop() + $myHgt // 현재 scroll

	                if ($currY > $navTop) {
	                    $nav.addClass("is-fixed");
	                    $("#hot_keyword").css("margin-top", $nav.outerHeight());

	                    if($ares1 <= $currY && $ares2 > $currY){
	                        $nav.find("a").removeClass("is-on");
	                        $(".floattab__item--01").addClass("is-on");
	                        //$(".scrollList").scrollLeft(0);
							$(".scrollList").scrollLeft(0);
	                    }else if($ares2 <= $currY && $ares3 > $currY){
	                        $nav.find("a").removeClass("is-on");
	                        $(".floattab__item--02").addClass("is-on");
	                        $(".scrollList").scrollLeft(0);
	                    }else if($ares3 <= $currY && $ares4 > $currY){
	                        $nav.find("a").removeClass("is-on");
	                        $(".floattab__item--03").addClass("is-on");
							$(".scrollList").scrollLeft($(".floattab__item--01").width() * 4);
	                    }else if($ares4 <= $currY && $ares5 > $currY){
	                        $nav.find("a").removeClass("is-on");
	                        $(".floattab__item--04").addClass("is-on");
	                        $(".scrollList").scrollLeft($(".floattab__item--01").width() * 5);
	                    }else if($ares5 <= $currY && $ares6 > $currY){
	                        $nav.find("a").removeClass("is-on");
	                        $(".floattab__item--05").addClass("is-on");
	                        $(".scrollList").scrollLeft($(".floattab__item--01").width() * 6);
	                    }else if($ares6 <= $currY && $ares7 > $currY){
	                        $nav.find("a").removeClass("is-on");
	                        $(".floattab__item--06").addClass("is-on");
	                        $(".scrollList").scrollLeft($(".floattab__item--01").width() * 7);
	                    }else{
	                    	$nav.find("a").removeClass("is-on");
	                    }

	                }else{
	                    $nav.removeClass("is-fixed"),
	                    $nav.find("a").removeClass("is-on");
	                    $("#hot_keyword").css("margin-top", $nav.height());
	                    $(".scrollList").scrollLeft(0);
	                }

	                // 윈도우 닫기버튼
	                if($(this).scrollTop() >= $(".visual").height()){
	                    $(".myarea").addClass("f-nav");
	                }else{
	                    $(".myarea").removeClass("f-nav");
	                }
	            });

	            $(".btn_tabmove").click(function(){
	                $(".scrollList").scrollLeft(300);
	            });

        		switch (tab){
        		case "contArea1":
    				$('html, body').stop().animate({ scrollTop:Math.ceil($('#evt1').offset().top) - $navHgt }, 500);
        			break;
        		case "contArea2":
    				$('html, body').stop().animate({ scrollTop:Math.ceil($('#evt2').offset().top) - $navHgt }, 500);
        			break;
        		case "contArea3":
    				$('html, body').stop().animate({ scrollTop:Math.ceil($('#evt3').offset().top) - $navHgt }, 500);
        			break;
        		case "contArea4":
    				$('html, body').stop().animate({ scrollTop:Math.ceil($('#evt4').offset().top) - $navHgt }, 500);
        			break;
        		case "contArea5":
    				$('html, body').stop().animate({ scrollTop:Math.ceil($('#evt5').offset().top) - $navHgt }, 500);
        			break;
        		case "contArea6":
    				$('html, body').stop().animate({ scrollTop:Math.ceil($('#evt6').offset().top) - $navHgt }, 500);
        			break;
        		}
	        });
		</script>
    </div>
    <!-- //플로팅 탭 -->

	<!-- 핫 키워드 -->
	<div id="hot_keyword" class="hot_keyword">
			<div class="contents">
				<h2><img src="<%=IMG_ENURI_COM%>/images/event/2018/christmas/m_hotkeyword_tit.png" alt="Hot keyword"></h2>
				<ul class="keyword">
					<li><a href="/mobilefirst/list.jsp?freetoken=list&cate=16441707" target="_blank" title="크리스마스트리"></a></li>
					<li><a href="/mobilefirst/list.jsp?freetoken=list&cate=16441711" target="_blank" title="인테리어소품"></a></li>
					<li><a href="/mobilefirst/list.jsp?freetoken=list&cate=16471912" target="_blank" title="크리스마스케익"></a></li>
					<li><a href="/mobilefirst/list.jsp?freetoken=list&cate=16471609" target="_blank" title="호텔식사권"></a></li>
					<li><a href="/mobilefirst/list.jsp?freetoken=list&cate=16470817" target="_blank" title="영화관람권"></a></li>
					<li><a href="/mobilefirst/list.jsp?freetoken=list&cate=101014" target="_blank" title="레고"></a></li>
					<li><a href="/mobilefirst/list.jsp?freetoken=list&cate=145704" target="_blank" title="머플러"></a></li>
					<li><a href="/mobilefirst/list.jsp?freetoken=list&cate=145702" target="_blank" title="장갑"></a></li>
				</ul>
			</div>
			<div class="snowbg"></div>
	</div>
	<!-- // 핫 키워드 -->
    <script type="text/javascript">
   		$('.hot_keyword .keyword li').click(function() {
	    	ga_log(9);
	    });
    </script>

	<!-- 스페셜선물1 -->
	<div id="evt1" class="special gift01">
		<div class="contents">
			<h2><img src="<%=IMG_ENURI_COM%>/images/event/2018/christmas/m_tit_section01.png" alt="스페셜!키즈선물"></h2>
			<div class="sp_items">
				<a href="/mobilefirst/list.jsp?freetoken=list&cate=1014" target="_blank" onclick="ga_log(10);" class="btn_more"></a>
			</div>
			<div class="liveProduct">
				<div id="slider01" class="itemlist">

				</div>
            </div>
        </div>
    </div>
	<!-- //스페셜선물1 -->

	<!-- 스페셜선물2 -->
	<div id="evt2" class="special gift02">
		<div class="contents">
			<h2><img src="<%=IMG_ENURI_COM%>/images/event/2018/christmas/m_tit_section02.png" alt="스페셜!연인선물"></h2>
			<div class="sp_items">
				<a href="/mobilefirst/list.jsp?freetoken=list&cate=145208" target="_blank" onclick="ga_log(12);" class="btn_more"></a>
			</div>
			<div class="liveProduct">
				<div id="slider02" class="itemlist">

				</div>
            </div>
        </div>
	</div>
	<!-- 스페셜선물2 -->

	<!-- 스페셜선물3 -->
	<div id="evt3" class="special gift03">
		<div class="contents">
			<h2><img src="<%=IMG_ENURI_COM%>/images/event/2018/christmas/m_tit_section03.png" alt="스페셜!셀프선물"></h2>
			<div class="sp_items">
				<a href="/mobilefirst/list.jsp?freetoken=list&cate=0404" target="_blank" onclick="ga_log(14);" class="btn_more"></a>
			</div>
			<div class="liveProduct">
				<div id="slider03" class="itemlist">

				</div>
            </div>
        </div>
    </div>
	<!-- 스페셜선물3 -->

	<!-- //배너영역1 -->
	<div class="banner_area pr1">
		<a href="<%=evtUrl%>&tab=evt2" target="_blank" class="ban_prize" title="프로모션 새창 이동">
			<img src="<%=IMG_ENURI_COM%>/images/event/2018/christmas/m_bn01.jpg" alt="이벤트배너1" />
		</a>
	</div>
	<!-- //배너영역1 -->
    <script type="text/javascript">
	    $('div.pr1 > a').click(function() {
	    	ga_log(16);
	    });
    </script>

	<!-- 스페셜선물4 -->
	<div id="evt4" class="special gift04">
		<div class="contents">
			<h2><img src="<%=IMG_ENURI_COM%>/images/event/2018/christmas/m_tit_section04.png" alt="스페셜!e쿠폰"></h2>
			<div class="sp_items">
				<a href="/mobilefirst/list.jsp?freetoken=list&cate=1647" target="_blank" onclick="ga_log(17);" class="btn_more"></a>
			</div>
			<div class="liveProduct">
				<div id="slider04" class="itemlist">

				</div>
            </div>
        </div>
    </div>
	<!-- 스페셜선물4 -->

	<!-- 스페셜선물5 -->
	<div id="evt5" class="special gift05">
		<div class="contents">
			<h2><img src="<%=IMG_ENURI_COM%>/images/event/2018/christmas/m_tit_section05.png" alt="스페셜!인테리어소품"></h2>
			<div class="sp_items">
				<a href="/mobilefirst/list.jsp?freetoken=list&cate=164417" target="_blank" onclick="ga_log(19);" class="btn_more"></a>
			</div>
			<div class="liveProduct">
				<div id="slider05" class="itemlist">

				</div>
            </div>
        </div>
    </div>
	<!-- 스페셜선물5 -->

	<!-- 스페셜선물6 -->
	<div id="evt6" class="special gift06">
		<div class="contents">
			<h2><img src="<%=IMG_ENURI_COM%>/images/event/2018/christmas/m_tit_section06.png" alt="스페셜!신년선물"></h2>
			<div class="sp_items">
				<a href="/mobilefirst/list.jsp?freetoken=list&cate=180210" target="_blank" onclick="ga_log(21);" class="btn_more"></a>
			</div>
			<div class="liveProduct">
				<div id="slider06" class="itemlist">

				</div>
            </div>
        </div>
    </div>
	<!-- 스페셜선물6 -->

	<!-- //배너영역2 -->
	<div class="banner_area pr2">
		<a href="<%=evtUrl%>&tab=evt1" target="_blank" class="ban_prize" title="프로모션 새창 이동">
			<img src="<%=IMG_ENURI_COM%>/images/event/2018/christmas/m_bn02.jpg" alt="이벤트배너2" />
		</a>
	</div>
	<!-- //배너영역2 -->
	<script type="text/javascript">
	    $('div.pr2 > a').click(function() {
	    	ga_log(23);
	    });
    </script>

    <!-- 기획전 배너 -->
	<div class="market_area" id="recPlanlist1">
		<div class="contents">
			<div class="obj_deco"></div>
			<h2><img src="<%=IMG_ENURI_COM%>/images/event/2018/christmas/m_tit_market.png" alt="에누리 기획전" /></h2>
			<ul class="evtbnr">
				<li><a href="javascript:void(0);"><img src="<%=IMG_ENURI_COM%>/images/event/2018/familymonth/christmas_2018_1.png" alt=""  /></a></li>
				<li><a href="javascript:void(0);"><img src="<%=IMG_ENURI_COM%>/images/event/2018/familymonth/christmas_2018_2.png" alt=""  /></a></li>
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
					<li><img src="<%=IMG_ENURI_COM%>/images/event/2018/familymonth/christmas_2018_1.png" alt=""></li>
					<li><img src="<%=IMG_ENURI_COM%>/images/event/2018/familymonth/christmas_2018_2.png" alt=""></li>
				</ul>
			</div>
		</div>
	</div>
	<!-- //기획전 스프레드 레이어 -->
	<script type="text/javascript">
		$("#recPlanlist1, #layer_planlist").find("li").click(function(e){
			ga_log(24);
			var exhNo = ["20181116141414","20181115165800"];
			var idx = e.currentTarget.className.indexOf("slick") > -1 ? $(this).index()-1 : $(this).index();
			window.open("/mobilefirst/planlist.jsp?t=B_"+exhNo[idx] + "&freetoken=planlist");
		});
	</script>

	<!-- 에누리 혜택 -->
	<%@include file="/eventPlanZone/jsp/eventBannerTapMobile_xmas_2018.jsp"%>
	<!-- //에누리 혜택 -->
	<script type="text/javascript">
		$('div.otherbene > h2').html("<img src=\"<%=IMG_ENURI_COM%>/images/event/2018/christmas/m_tit_benefit.png\" alt=\"에누리 혜택\" class=\"imgs\">");
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
						'18년 크리스마스 통합기획전_PV',
						'18년 크리스마스 무빙탭_케익',
						'18년 크리스마스 무빙탭_키즈선물',
						'18년 크리스마스 무빙탭_연인선물',
						'18년 크리스마스 무빙탭_셀프선물',
						'18년 크리스마스 무빙탭_e쿠폰',
						'18년 크리스마스 무빙탭_인테리어',
						'18년 크리스마스 무빙탭_신년선물',
						'18년 크리스마스_HOT키워드_클릭',
						'18년 크리스마스_키즈선물_상품클릭',
						'18년 크리스마스_키즈선물_상품더보기',
						'18년 크리스마스_연인선물_상품클릭',
						'18년 크리스마스_연인선물_상품더보기',
						'18년 크리스마스_셀프선물_상품클릭',
						'18년 크리스마스_셀프선물_상품더보기',
						'18년 크리스마스_배너_구매이벤트',
						'18년 크리스마스_e쿠폰_상품클릭',
						'18년 크리스마스_e쿠폰_상품더보기',
						'18년 크리스마스_인테리어_상품클릭',
						'18년 크리스마스_인테리어_상품더보기',
						'18년 크리스마스_신년선물_상품클릭',
						'18년 크리스마스_신년선물_상품더보기',
						'18년 크리스마스_배너_매일이벤트',
						'18년 크리스마스_CM배너',
						'18년 크리스마스_혜택배너'
		              ];
		if (isFlow) gaLabel = [
						'DA_18년 크리스마스 통합기획전_PV',
						'18년 크리스마스 무빙탭_케익',
						'18년 크리스마스 무빙탭_키즈선물',
						'18년 크리스마스 무빙탭_연인선물',
						'18년 크리스마스 무빙탭_셀프선물',
						'18년 크리스마스 무빙탭_e쿠폰',
						'18년 크리스마스 무빙탭_인테리어',
						'18년 크리스마스 무빙탭_신년선물',
						'DA_18년 크리스마스_HOT키워드_클릭',
						'DA_18년 크리스마스_키즈선물_상품클릭',
						'18년 크리스마스_키즈선물_상품더보기',
						'DA_18년 크리스마스_연인선물_상품클릭',
						'18년 크리스마스_연인선물_상품더보기',
						'DA_18년 크리스마스_셀프선물_상품클릭',
						'18년 크리스마스_셀프선물_상품더보기',
						'18년 크리스마스_배너_구매이벤트',
						'DA_18년 크리스마스_e쿠폰_상품클릭',
						'18년 크리스마스_e쿠폰_상품더보기',
						'DA_18년 크리스마스_인테리어_상품클릭',
						'18년 크리스마스_인테리어_상품더보기',
						'DA_18년 크리스마스_신년선물_상품클릭',
						'18년 크리스마스_신년선물_상품더보기',
						'18년 크리스마스_배너_매일이벤트',
						'DA_18년 크리스마스_CM배너',
						'18년 크리스마스_혜택배너'
		               ];

		var vEvent_title = "18년 크리스마스";
		if (isFlow)	vEvent_title = "DA_18년 크리스마스";

		function innerCall (param) {
			if ( param == 1 ) {
	 			ga('send', 'pageview', {'page': vEvent_page,'title': vEvent_title + " 통합기획전_" + "PV"});
			} else {
 				ga('send', 'event', 'mf_event', vEvent_title, gaLabel[param-1]);
			}
		}
		return innerCall;
	}

	/* 데이터 로드 영역 */
	var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=23";

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

	// 스페셜 01~06
	var arrItemLog = [11,13,15,18,20,22];
  	for(var idx=0; idx<6; idx++){
		$.each(ajaxData[idx].GOODS, function(i, v) {
			img = v.GOODS_IMG ? v.GOODS_IMG : v.IMG_SRC;
			if (img == "") {
				img = "<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png";
			}
		    makeHtml += "    <div class=\"lpitem\">";
		    makeHtml += "        <a href=\"javascript:void(0);\" title=\"새탭열기\" onclick=\"ga_log("+arrItemLog[idx]+");itemClick('"+v.MODELNO+"','"+v.MINPRICE+"')\">";
			makeHtml += "            <span class=\"thumb\">";
		    if (v.MINPRICE == 0) {
		    	makeHtml += "           <span class=\"soldout\">SOLD OUT</span>";
			}
	    	makeHtml += "            	<img src=\""+img+"\" alt=\"\" />";
	    	makeHtml += "            </span>";
			makeHtml += "            <span class=\"info\">";
	    	makeHtml += "            	<span class=\"pname\">"+v.TITLE1+v.TITLE2+"</span>";
	    	makeHtml += "            	<em>최저가<b>"+commaNum(v.MINPRICE)+"</b>원</em>";
	    	makeHtml += "			 </span>";
	    	makeHtml += "        </a>";
		    makeHtml += "    </div>";
		});
		$('#evt'+(idx+1)+' .itemlist').html(makeHtml).load();

		makeHtml="";
  	};

  	//스페셜 01~06 slick
	$('.liveProduct .itemlist').slick({
		infinite: true,
		dots: true,
		rows: 1,
		slidesToShow: 2,
		slidesToScroll: 2,
		speed: 300,
		adaptiveHeight: true,
		autoplay: true,
		autoplaySpeed: 5000
	});
});

function itemClick(modelNo, minprice) {
	if(minprice > 0){
		window.open('/mobilefirst/detail.jsp?modelno=' + modelNo +'&freetoken=vip');
	}else{
		alert("품절된 상품 입니다.");
	}
}

// 탭이동
$(window).load(function() {
	// PV
	ga_log(1);

	//닫기버튼
	$('.win_close').click(function(){
		if(getCookie("appYN") == 'Y'){
			window.location.href = "close://";
		}else{
			window.location.replace("/mobilefirst/index.jsp");
		}
	});
});
</script>

<script type="text/javascript">
/* 퍼블 */
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

	//하단상품 리스트 탭 컨텐츠
	$(document).ready(function() {
		$(".btitem_list #quick1 .tab_content").hide();
		$(".btitem_list #quick1 ul.pp_tabs li:first").addClass("active").show();
		$(".btitem_list #quick1 .tab_content:first").show();
		$(".btitem_list #quick1 ul.pp_tabs li").click(function() {
			$(".btitem_list #quick1 ul.pp_tabs li").removeClass("active");
			$(this).addClass("active");
			$(".btitem_list #quick1 .tab_content").hide();
			var activeTab = $(this).find("a").attr("href");
			$(activeTab).fadeIn();
			return false;
		});

		$(".btitem_list #quick2 .tab_content").hide();
		$(".btitem_list #quick2 ul.pp_tabs li:first").addClass("active").show();
		$(".btitem_list #quick2 .tab_content:first").show();
		$(".btitem_list #quick2 ul.pp_tabs li").click(function() {
			$(".btitem_list #quick2 ul.pp_tabs li").removeClass("active");
			$(this).addClass("active");
			$(".btitem_list #quick2 .tab_content").hide();
			var activeTab = $(this).find("a").attr("href");
			$(activeTab).fadeIn();
			return false;
		});

		$(".btitem_list #quick3 .tab_content").hide();
		$(".btitem_list #quick3 ul.pp_tabs li:first").addClass("active").show();
		$(".btitem_list #quick3 .tab_content:first").show();
		$(".btitem_list #quick3 ul.pp_tabs li").click(function() {
			$(".btitem_list #quick3 ul.pp_tabs li").removeClass("active");
			$(this).addClass("active");
			$(".btitem_list #quick3 .tab_content").hide();
			var activeTab = $(this).find("a").attr("href");
			$(activeTab).fadeIn();
			return false;
		});

		$(".btitem_list #quick4 .tab_content").hide();
		$(".btitem_list #quick4 ul.pp_tabs li:first").addClass("active").show();
		$(".btitem_list #quick4 .tab_content:first").show();
		$(".btitem_list #quick4 ul.pp_tabs li").click(function() {
			$(".btitem_list #quick4 ul.pp_tabs li").removeClass("active");
			$(this).addClass("active");
			$(".btitem_list #quick4 .tab_content").hide();
			var activeTab = $(this).find("a").attr("href");
			$(activeTab).fadeIn();
			return false;
		});
	});



	//하단상품 리스트 플리킹
	$('.btitem_list .items_area').slick({
		dots:true,
		slidesToScroll: 1
	});

	//팝업
	function onoff(id) {
		var mid=document.getElementById(id);
		if(mid.style.display=='') {
			mid.style.display='none';
		}else{
			mid.style.display='';
		}
	}

	//레이어
	function onoff(id){
		var mid = $("#"+id);
		if(mid.css("display") !== "none"){
			mid.css("display","none");
		}else{
			mid.css("display","");
		}
	}

</script>

</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
