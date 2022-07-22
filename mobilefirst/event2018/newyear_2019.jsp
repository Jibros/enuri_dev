<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>

<%
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
	response.sendRedirect("/event2019/newyear_2019.jsp");
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

String strFb_title = "에누리 가격비교";
String strFb_description = "2019 설 통합기획전";
String strFb_img = ConfigManager.IMG_ENURI_COM + "/images/mobilenew/images/logo_enuri.png";
String tab = ChkNull.chkStr(request.getParameter("tab"));
String flow = ChkNull.chkStr(request.getParameter("flow"));
String evtUrl = "/mobilefirst/event2018/newyear_2019.jsp?freetoken=event";
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
	<link rel="stylesheet" type="text/css" href="/css/event/y2019/newyear_m.css"/>
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/lib/animate.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
	<script type="text/javascript" src="/common/js/function.js"></script>
</head>
<body>

<div class="wrap">

	<a href="#" class="win_close">창닫기</a>

    <!-- 개인화영역 -->
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>

	<!-- 상단비주얼 -->
	<div id="visual" class="visual">
		<img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/m_visual.jpg" class="imgs">
		<div class="contents">
			<div class="blind">
				<h1>설 프라이즈!</h1>
				<em>2019 선물대전</em>
			</div>
		</div>
	</div>
	<!-- //상단비주얼 -->

	<!-- 플로팅 탭 -->
	<div  class="floattab__list">
		<div class="scrollList">
			<ul class="floatmove">
				<li class="evt_join"><a href="javascript:///" onclick="bnrClick('3','2');"  class="floattab__item floattab__item--08" target="_blank" title="페이지 이동"><em>케익추첨이벤트</em></a></li>
				<li><a href="#evt1" onclick="ga_log(3);" class="floattab__item floattab__item--01"><em>설프라이즈 Deal</em></a></li>
				<li><a href="#evt2" onclick="ga_log(4);" class="floattab__item floattab__item--02"><em>가격대별 선물세트</em></a></li>
				<li><a href="#evt3" onclick="ga_log(5);" class="floattab__item floattab__item--03"><em>농수산 선물세트</em></a></li>
				<li><a href="#evt4" onclick="ga_log(6);" class="floattab__item floattab__item--04"><em>한우 선물세트</em></a></li>
				<li><a href="#evt5" onclick="ga_log(7);" class="floattab__item floattab__item--05"><em>가공 선물세트</em></a></li>
				<li><a href="#evt6" onclick="ga_log(8);" class="floattab__item floattab__item--06"><em>건강 선물세트</em></a></li>
				<li><a href="#evt7" onclick="ga_log(9);" class="floattab__item floattab__item--07"><em>상품권</em></a></li>
			</ul>
		</div>
        <a href="javascript:///" class="btn_tabmove next"><em>탭 이동</em></a>

    <script>
            //플로팅 상단 탭 이동
            $(document).on('click', '.floattab__list .floatmove :not(li.evt_join) a', function(e) {
               	var $anchor = Math.ceil($($(this).attr('href')).offset().top);
                    $navHgt = Math.ceil($(".floattab__list").height() * 1.25);

                     //  console.log($anchor, $navHgt);
                $('html, body').stop().animate({scrollTop: $anchor - $navHgt}, 500);
                e.preventDefault();
            });

            $(window).load(function(){
                var $nav = $(".floattab__list"), // scroll tabs
                    $navTop = $nav.offset().top;
                    $myHgt = $(".myarea").height();

                    $ares1 = $("#evt1").offset().top - $nav.outerHeight(),
                    $ares2 = $("#evt2").offset().top - $nav.outerHeight(),
                    $ares3 = $("#evt3").offset().top - $nav.outerHeight();
                    $ares4 = $("#evt4").offset().top - $nav.outerHeight();
                    $ares5 = $("#evt5").offset().top - $nav.outerHeight();
					$ares6 = $("#evt6").offset().top - $nav.outerHeight();
					$ares7 = $("#evt7").offset().top - $nav.outerHeight();

                // 상단 탭 position 변경 및 버튼 활성화
                $(window).scroll(function(){
                    var $currY = $(this).scrollTop() + $myHgt // 현재 scroll

                    if ($currY > $navTop) {
                        $nav.addClass("is-fixed");
                        $("#evt1").css("margin-top", $nav.outerHeight());

                        if($ares1 <= $currY && $ares2 > $currY){
                            $nav.find("a").removeClass("is-on");
                            $(".floattab__item--01").addClass("is-on");
                            //$(".scrollList").scrollLeft(0);
							$(".scrollList").scrollLeft(0);
                        }else if($ares2 <= $currY && $ares3 > $currY){
                            $nav.find("a").removeClass("is-on");
                            $(".floattab__item--02").addClass("is-on");
                            $(".scrollList").scrollLeft($(".floattab__item--01").width() * 2 - 30);
                        }else if($ares3 <= $currY && $ares4 > $currY){
                            $nav.find("a").removeClass("is-on");
                            $(".floattab__item--03").addClass("is-on");
							$(".scrollList").scrollLeft($(".floattab__item--01").width() * 2 - 30);
                        }else if($ares4 <= $currY && $ares5 > $currY){
                            $nav.find("a").removeClass("is-on");
                            $(".floattab__item--04").addClass("is-on");
                            $(".scrollList").scrollLeft($(".floattab__item--01").width() * 4 - 30);
                        }else if($ares5 <= $currY && $ares6 > $currY){
                            $nav.find("a").removeClass("is-on");
                            $(".floattab__item--05").addClass("is-on");
                            $(".scrollList").scrollLeft($(".floattab__item--01").width() * 4 - 30);
                        }else if($ares6 <= $currY && $ares7 > $currY){
                            $nav.find("a").removeClass("is-on");
                            $(".floattab__item--06").addClass("is-on");
                            $(".scrollList").scrollLeft($(".floattab__item--01").width() * 6 - 30);
                        }else if($ares7 <= $currY){
                            $nav.find("a").removeClass("is-on");
                            $(".floattab__item--07").addClass("is-on");
                            $(".scrollList").scrollLeft($(".floattab__item--01").width() * 6 - 30);
                        }

                    } else {
                    	$nav.find("a").removeClass("is-on");
                        $nav.removeClass("is-fixed"),
                        $("#hot_keyword").css("margin-top", $nav.height());
                    }

                    // 윈도우 닫기버튼
                    if($(this).scrollTop() > $(".visual").height()){
                        $(".myarea").addClass("f-nav");
                    }else{
                        $(".myarea").removeClass("f-nav");
                    }
                });

			});
				$(".scrollList").on("scroll", function(){
				var st = $(".scrollList").scrollLeft();
   				if (st >= $(".floattab__item--01").width() * 2 - 30) {
					$(".btn_tabmove").removeClass("next");
					$(".btn_tabmove").addClass("prev");
				}else {
					$(".btn_tabmove").removeClass("prev");
					$(".btn_tabmove").addClass("next");
				}

			});


	</script>

    </div>
	<!-- //플로팅 탭 -->

    <!-- DEAL페이지 -->
	<div id="evt1" class="section dealwrap">
		<div class="obj_01"></div>
		<div class="contents">
			<div class="tit">
				<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/m_tit_deal.png" alt="설프라이즈 Deal"></h2>
			</div>

			<!-- 딜 구매영역 -->
				<div class="deal_slide">

				</div>
			<!-- //딜 구매영역 -->

			<!-- 딜 리스트영역 -->
			<div class="deal_list">
				<div class="deal_nav">
				</div>
			</div>
			<!--// 딜 리스트영역 -->
			<!-- 화살표 -->
			<div class="deal_arrow">
				<div class="arrow prev"></div>
				<div class="arrow next"></div>
			</div>

			<script>

			</script>
		</div>
	</div>
	<!-- //DEAL페이지 -->

	<!-- //배너영역1 -->
	<div class="banner_area pr1">
		<a href="javascript:;" target="_blank" class="ban_prize" title="프로모션 새창 이동" onclick="bnrClick('3','12')">
			<img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/m_bn01.jpg" alt="이벤트배너1" />
		</a>
	</div>
	<!-- //배너영역1 -->

	<!-- 가격대별 선물1 -->
	<div id="evt2" class="special gift01">
		<div class="contents">
			<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/m_tit_01.png" alt="가격대별 선물세트"></h2>
			<div class="liveProduct">
				<ul class="pp_tabs tabs">
					<li><a href="#tab1" onclick="ga_log(13);" class="tab1 done">1만원 이하</a></li>
					<li><a href="#tab2" onclick="ga_log(14);" class="tab2">2~5만원</a></li>
					<li><a href="#tab3" onclick="ga_log(15);" class="tab3">5~10만원</a></li>
					<li><a href="#tab4" onclick="ga_log(16);" class="tab4">10만원 이상</a></li>
				</ul>
				<!-- itemlist1 -->
				<div id="tab1" class="itemlist tab_content">
				</div>
				<!-- itemlist1 -->
				<!-- itemlist2 -->
				<div id="tab2" class="itemlist tab_content">
				</div>
				<!-- itemlist2 -->
				<!-- itemlist3 -->
				<div id="tab3" class="itemlist tab_content">
				</div>
				<!-- itemlist3 -->
				<!-- itemlist4 -->
				<div id="tab4" class="itemlist tab_content">
				</div>
				<!-- itemlist4 -->
			</div>
			<!-- <a href="" class="btn_more">상품더보기</a> -->
        </div>
    </div>
	<!-- //가격대별 선물1-->

	<!-- 스페셜선물2 -->
	<div id="evt3" class="special gift02">
		<div class="contents">
			<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/m_tit_02.png" alt="농수산 선물세트"></h2>
			<div class="liveProduct">
				<div id="slider02" class="itemlist">
				</div>
			</div>
			<a href="javascript:;" target="_blank" class="btn_more" onclick="cateClick('150408');ga_log(20);">상품더보기</a>
        </div>
    </div>
	<!-- //스페셜선물2 -->

	<!-- //배너영역2 -->
	<div class="banner_area pr2">
		<a href="javascript:;" class="ban_prize" title="프로모션 새창 이동" onclick="bnrClick('2','21')">
			<img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/m_bn02.jpg" alt="이벤트배너2" />
		</a>
	</div>
	<!-- //배너영역2 -->

	<!-- 스페셜선물3 -->
	<div id="evt4" class="special gift03">
		<div class="contents">
			<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/m_tit_03.png" alt="한우 선물세트"></h2>
			<div class="liveProduct">
				<div id="slider03" class="itemlist">
				</div>
			</div>
			<a href="javascript:;" target="_blank" class="btn_more" onclick="cateClick('15031501');ga_log(23);">상품더보기</a>
		</div>
	</div>
	<!-- //스페셜선물3 -->

	<!-- 스페셜선물4 -->
	<div id="evt5" class="special gift04">
		<div class="contents">
			<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/m_tit_04.png" alt="가공 선물세트"></h2>
			<div class="liveProduct">
				<div id="slider04" class="itemlist">
				</div>
			</div>
			<a href="javascript:;" target="_blank" class="btn_more" onclick="cateClick('15110510');ga_log(25);">상품더보기</a>
		</div>
	</div>
	<!-- //스페셜선물4 -->

	<!-- //배너영역3 -->
	<div class="banner_area pr3">
		<a href="javascript:;" class="ban_prize" title="프로모션 새창 이동" onclick="bnrClick('1','26')">
			<img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/m_bn03.jpg" alt="이벤트배너2" />
		</a>
	</div>
	<!-- //배너영역3 -->

	<!-- 스페셜선물5 -->
	<div id="evt6" class="special gift05">
		<div class="contents">
			<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/m_tit_05.png" alt="건강 선물세트"></h2>
			<div class="liveProduct">
				<div id="slider05" class="itemlist">
				</div>
			</div>
			<a href="javascript:;" target="_blank" class="btn_more" onclick="cateClick('15010513');ga_log(28);">상품더보기</a>
		</div>
	</div>
	<!-- //스페셜선물5 -->

	<!-- 스페셜선물6 -->
	<div id="evt7" class="special gift06">
		<div class="obj_02"></div>
		<div class="contents">
			<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/m_tit_06.png" alt="상품권 선물세트"></h2>
			<div class="liveProduct">
				<div id="slider06" class="itemlist">
				</div>
			</div>
			<a href="javascript:;" target="_blank" class="btn_more" onclick="cateClick('164715');ga_log(30);">상품더보기</a>
		</div>
	</div>
	<!-- //스페셜선물6 -->

	<!-- 기획전 배너 -->
	<div class="market_area">
		<div class="contents">
			<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/m_tit_market.png" alt="에누리 기획전" /></h2>
			<ul class="evtbnr" id="recPlanlist1">
				<li><a href="javascript:///"><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/newyear_bn1.png" alt=""  /></a></li>
				<li><a href="javascript:///"><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/newyear_bn2.png" alt=""  /></a></li>
				<li><a href="javascript:///"><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/newyear_bn3.png" alt=""  /></a></li>
				<li><a href="javascript:///"><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/newyear_bn4.png" alt=""  /></a></li>
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
				<ul id="recPlanlist2">
					<li><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/newyear_bn1.png" alt="" ></li>
					<li><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/newyear_bn2.png" alt=""></li>
					<li><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/newyear_bn3.png" alt=""></li>
					<li><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/newyear_bn4.png" alt=""></li>
				</ul>
			</div>
		</div>
	</div>
	<!-- //기획전 스프레드 레이어 -->
	<script type="text/javascript">
		$("#recPlanlist1, #recPlanlist2").find("li").click(function(e){
			ga_log(31);
			var exhNo = [
				"20190101110325","20181214093500","20181217170700","20180910141827"
			];
			var idx = e.currentTarget.className.indexOf("slick") > -1 ? $(this).index()-1 : $(this).index();
			window.open("/mobilefirst/planlist.jsp?t=B_"+exhNo[idx] + "&freetoken=planlist");
		});
	</script>
	<!-- 에누리 혜택 -->
	<div class="otherbene">
		<div class="obj_03"></div>
		<div class="obj_04"></div>
		<div class="contents">
			<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/m_tit_benefit.png" alt="에누리 혜택" class="imgs"></h2>
			<ul class="banlist">
				<li><a href="javascript:///" target="_blank" title="새창으로 이동"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban1.png" alt="출석체크" /></a></li>
				<li><a href="javascript:///" target="_blank" title="새창으로 이동"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban2.png" alt="매일룰렛" /></a></li>
				<li><a href="javascript:///" target="_blank" title="새창으로 이동"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban3.png" alt="첫구매혜택" /></a></li>
				<li><a href="javascript:///" target="_blank" title="새창으로 이동"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban4.png" alt="크레이지딜" /></a></li>
				<li><a href="javascript:///" target="_blank" title="새창으로 이동"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban5.png" alt="직장공감" /></a></li>
				<li><a href="javascript:///" target="_blank" title="새창으로 이동"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban6.png" alt="더많은 이벤트" /></a></li>
			</ul>
		</div>
	</div>
	<!-- //에누리 혜택 -->

	<!-- layer-->
	<div class="layer_back" id="app_only" style="display:none;">
		<div class="appLayer">
			<h4>모바일 앱 전용 이벤트</h4>
			<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
			<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
			<p class="btn_close"><button type="button">설치하기</button></p>
		</div>
	</div>
	<!-- top번튼 -->
	<span class="go_top"><a href="javascript:///" onclick="$(window).scrollTop(0);" >TOP</a></span>
	<!-- //top번튼 -->
	<script type="text/javascript">
		$('.go_top').click(function() {
			var $movetab = $('.floattab__list .scrollList ul.floatmove li');
			$movetab.find('.is-on').removeClass('is-on');
			$movetab.eq(0).children().addClass('is-on');
			$(".scrollList").scrollLeft(0);
		});
	</script>
</div>
<%-- 개발 --%>
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20180831"></script>
<script>
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로
var ga_log;

window.onload = function(){
	//PV
	if("<%=flow%>" == "ad") {
		ga('send', 'pageview', {'page': vEvent_page,'title': "DA_2019년 설날기획전 PV"});
	} else {
		ga_log(1);
	}

	//닫기버튼
	$( ".win_close" ).click(function(){
		if(getCookie("appYN") == 'Y'){
			window.location.href = "close://";
		}else{
			window.location.replace("/mobilefirst/index.jsp");
		}
	});

	var tab = "<%=tab%>";
	switch (tab) {
	case "1":	//1만
		$(".tab1").click();
		$(".floattab__item--02").click();
	break;
	case "2":	//2~5만
		$(".tab2").click();
		$(".floattab__item--02").click();
		break;
	case "3":	//5~10만
		$(".tab3").click();
		$(".floattab__item--02").click();
		break;
	case "4":	//10만 이상
		$(".tab4").click();
		$(".floattab__item--02").click();
		break;
	}
};
$(document).ready(function() {

	ga_log = gaCall();

	//로그인시 개인화영역
	if(islogin()){
		$("#user_id").text("<%=cUserId%>");
		getPoint();//개인e머니 내역 노출
	}

	//딜
	getDeal();

	//전체 상품 데이터
	var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=24";

	var ajaxData = (function() {
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


	function getDeal(){
		var getUrl = "/mobilefirst/http/json/exh_deal_list_2019010700.json";
		var vView_s_dtm = "";
		var vView_e_dtm = "";
		var vSal_s_dtm = "";
		var vSal_e_dtm = "";
		var vCur_dtm = YYYYMMDDHHMMSS(new Date());
		var htmlInfos = [
				            {
				            	"period": "1/9 ~ 1/15",
				            	"period2": "1월 9일 ~ 15일",
				            	"open"	: "1/9 2시오픈",
				            	"cls"	: "open0109"
				            },
				            {
				            	"period": "1/16 ~ 1/22",
				            	"period2": "1월 16일 ~ 22일",
				            	"open"	: "1/16 2시오픈",
				            	"cls"	: "open0116"
				            },
				            {
				            	"period": "1/23 ~ 1/29",
				            	"period2": "1월 23일 ~ 29일",
				            	"open"	: "1/23 2시오픈",
				            	"cls"	: "open0123"
				            }
				            ];
		$.ajax({
			type:"GET",
			url: getUrl,
			dataType: "JSON",
			success:function(data){
				var makeHtml = "";
				var makeHtml2 = "";
				$.each(data, function(i, v) {
					vView_s_dtm = v.GD_VIEW_S_DTM_CVT;
					vView_e_dtm = v.GD_VIEW_E_DTM_CVT;
					vSal_s_dtm = v.GD_SAL_S_DTM_CVT;
					vSal_e_dtm = v.GD_SAL_E_DTM_CVT;

					makeHtml +="<div class=\"deal_item clearfix\" >";
					makeHtml +="<span class=\"perio\"><em>"+htmlInfos[i].period+"</em></span>";
					makeHtml +="<div class=\"container\">";
					makeHtml +="	<div class=\"thumb\">";
					if(vCur_dtm < vSal_s_dtm){
						makeHtml +="		<em class=\"stripe "+htmlInfos[i].cls+"\">"+htmlInfos[i].open+"</em>";
					}
					makeHtml +="		<div class=\"pnum stripe\">";
					makeHtml +="			<em class=\"per\"><span>"+v.GD_DC_RT+"</span>%</em>";
					makeHtml +="			<em class=\"num\">"+commaNum(v.GD_QTY)+"개</em>";
					makeHtml +="		</div>";
					makeHtml +="		<img src=\"http://storage.enuri.gscdn.com/"+v.GD_IMG_URL+"\" />";
					makeHtml +="	</div>";
					makeHtml +="	<div class=\"item_info\">";
					makeHtml +="		<div class=\"inner\">";
					makeHtml +="			<p class=\"tit\">"+v.GD_MODEL_NM1+"<br>"+v.GD_MODEL_NM2+"</p>";
					makeHtml +="			<div class=\"mark\"><img src=\"http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/inter_logo.jpg\" alt=\"인터파크\"></div>";
					makeHtml +="			<ul class=\"price_info\">";
					makeHtml +="				<li><p class=\"price\"><span>정상판매가</span><em><strike>"+commaNum(v.GD_PRC)+"</strike>원</em></p></li>";
					makeHtml +="				<li><p class=\"price_dis\"><span>설프라이즈 특가</span><strong>"+commaNum(v.GD_DC_PRC)+"<span>원</span></strong></p></li>";
					makeHtml +="			</ul>";
					makeHtml +="			<div class=\"btn_group clearfix\"  id=\"deal_item"+i+"\">";
					makeHtml +="				<a href=\"javascript:;\" target=\"_blank\" class=\"deal_btn dview\" onclick=\"itemClick('"+v.GD_MODEL_NO+"','"+v.GD_DC_PRC+"');ga_log(10);\" >상품보기</a>";
					if(v.GD_SO_YN == "Y"){
						makeHtml +="				<a href=\"javascript:;\" class=\"deal_btn soldout\">품절</a>";
					}else if(vCur_dtm < vSal_s_dtm){
						makeHtml +="				<a href=\"javascript:;\" class=\"deal_btn time14\">판매예정</a>";
					}else if (v.GD_SO_YN == "N" && vSal_s_dtm <= vCur_dtm && vSal_e_dtm >= vCur_dtm) {
						makeHtml +="				<a href=\"javascript:;\" class=\"deal_btn buy\" onclick=\"fnDeal('"+v.EXH_DEAL_NO+"');ga_log(11);\">구매하기</a>";
					}else{

					}

					makeHtml +="				<em>※ <span>쿠폰적용 필수</span>/ ID당 1회 / 무료배송</em>";
					makeHtml +="			</div>";
					makeHtml +="		</div>";
					makeHtml +="	</div>";
					makeHtml +="</div>";
					makeHtml +="</div>";

					makeHtml2 +="<div class=\"w_item\">";
					makeHtml2 +="<div class=\"period\">";
					makeHtml2 +="	<span>"+htmlInfos[i].period+"</span>";
					makeHtml2 +="</div>";
					makeHtml2 +="<div class=\"w_thumb\">";
					makeHtml2 +="	<img src=\"http://storage.enuri.gscdn.com/"+v.GD_IMG_URL+"\"  alt=\"\" />";
					makeHtml2 +="</div>";
					makeHtml2 +="<span class=\"w_bg\"></span>";
					makeHtml2 +="<span class=\"w_tit\">"+v.GD_MODEL_NM1+"<br>"+v.GD_MODEL_NM2+"</span>";
					makeHtml2 +="</div>";

					if(i==2)	return false;
				});

				$(".deal_slide").html(makeHtml);
				$(".deal_list .deal_nav").html(makeHtml2);

			},complete : function(data) {
				 $('.deal_slide').slick({
						slidesToShow: 1,
						slidesToScroll: 1,
						arrows: false,
						fade: false,
						//speed: 0,
						asNavFor: '.deal_nav'
					}).on("beforeChange", function(e, slick, currentSlide, nextslide){
						$('.deal_nav .w_item').removeClass("slick-current");
						$('.deal_nav .w_item').eq(nextslide).addClass("slick-current");
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
		        		if($("#deal_item"+i+" a").hasClass("soldout")){
		        		} else {
			        		$('.deal_slide').slick('slickGoTo', i, false);
		        		}
		    		}
	        }
		});
	}
	makeHtml="";
	var arrItemLog = [17,19,22,24,27,29];

	for (var idx=0; idx<9; idx++) {
		$.each(ajaxData[idx].GOODS, function(i, v) {
			img = v.GOODS_IMG ? v.GOODS_IMG : v.IMG_SRC;
			if (img == "") {
				img = "<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png";
			}
			makeHtml += "<div class=\"lpitem\">";
			makeHtml += "<a href=\"javascript:;\" target=\"_blank\" title=\"새 탭에서 열립니다.\" onclick=\"itemClick('"+v.MODELNO+"','"+v.MINPRICE3+"');";
			if(idx > 3){
				makeHtml += "ga_log("+arrItemLog[idx-3]+");  ";
			}else{
				makeHtml += "ga_log("+arrItemLog[0]+");  ";
			}
			makeHtml += "\" >";
			makeHtml += "	<span class=\"thumb\">";
			if (v.MINPRICE == 0) {
				makeHtml += "		<span class=\"soldout\"></span>";
			}
			makeHtml += "		<img src=\""+img+"\"  alt=\"\" />";
			makeHtml += "	</span>";
			makeHtml += "	<span class=\"info\">";
			makeHtml += "		<span class=\"pname\">"+v.TITLE1+"<br>"+v.TITLE2+"</span>";
			makeHtml += "		<em>최저가<b>"+commaNum(v.MINPRICE3)+"</b>원</em>";
			makeHtml += "	</span>";
			makeHtml += "</a>";
			makeHtml += "</div>";

			if(idx < 4){
				$('#tab'+(idx+1)).append(makeHtml);
			}else{
				$('#slider0'+(idx-2)).append(makeHtml);
			}
			makeHtml="";
		});
	};

	//에누리혜택
	$(".banlist > li").click(function(){

		var idx = $(this).index();
		var evtUrl = [
			"/mobilefirst/evt/visit_event.jsp?tab=1&freetoken=event",
			"/mobilefirst/evt/visit_event.jsp?tab=2&freetoken=event",
			"/mobilefirst/evt/welcome_event.jsp?tab=1&freetoken=event",
			"/mobilefirst/evt/mobile_deal.jsp?freetoken=event",
			"/mobilefirst/evt/officeworker_2018.jsp?event_id=2019010108&freetoken=event",
			(getCookie("appYN") != "Y" ? "/mobilefirst/index.jsp#evt" : "/mobilefirst/renew/plan.jsp?freetoken=main_tab|event"),
		];

		ga_log(32);
		window.open(evtUrl[idx]);
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

	// 스페셜01 slick
	$('#tab1, #tab2, #tab3, #tab4').slick({
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

	// 스페셜02 slick
	$('#slider02').slick({
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

	// 스페셜03 slick
	$('#slider03').slick({
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

	// 스페셜04 slick
	$('#slider04').slick({
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

	// 스페셜05 slick
	$('#slider05').slick({
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

	// 스페셜06 slick
	$('#slider06').slick({
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

	   // 모바일 닫기
	$(".rd_banner a.total").click(function(){
			$(".wrap a.win_close").css("display", "none");
	});

	//하단상품 리스트 탭 컨텐츠
	$(".special.gift01 .tab_content").hide();
	       $(".special.gift01 ul.tabs li:first").addClass("active").show();
	       $(".special.gift01 .tab_content:first").show();
	       $(".special.gift01 ul.tabs li").click(function() {
	           $(".special.gift01 ul.tabs li").removeClass("active");
	           $(this).addClass("active");
	           $(".special.gift01 .tab_content").hide();
	           var activeTab = $(this).find("a").attr("href");
	           $(activeTab).fadeIn();
	           $(".itemlist").slick("setPosition"); //슬릭 새로고침
	           return false;
	       });

	//하단상품 리스트 플리킹
	$('.btitem_list .items_area').slick({
		dots:true,
		slidesToScroll: 1
	});

	function gaCall() {
		var gaLabel = [
						'전체PV',
						'무빙탭_순금바이벤트',
						'무빙탭_설프라이즈딜',
						'무빙탭_가격대별선물',
						'무빙탭_농수산선물',
						'무빙탭_한우선물',
						'무빙탭_가공선물',
						'무빙탭_건강선물',
						'무빙탭_상품권선물',
						'딜_상품보기',
						'딜_구매하기',
						'배너_구매이벤트',
						'가격대별_탭_1만원이하',
						'가격대별_탭_1~5만원',
						'가격대별_탭_5~10만원',
						'가격대별_탭_10만원이상',
						'가격대별_상품클릭',
						'가격대별_상품더보기',
						'농수산_상품클릭',
						'농수산_상품더보기',
						'배너_설날메세지',
						'한우_상품클릭',
						'한우_상품더보기',
						'가공_상품클릭',
						'가공_상품더보기',
						'배너_매일참여',
						'건강_상품클릭',
						'건강_상품더보기',
						'상품권_상품클릭',
						'상품권_상품더보기',
						'CM배너',
						'혜택배너'
						];
		var vEvent_title = "19년설날기획전";
		var vEvent_title2 = "";

		if("<%=flow%>" == "ad") {
			vEvent_title = "DA_"+vEvent_title;
		}

		function innerCall (param) {
			if ( param == 1 ) {
				ga('send', 'pageview', {'page': vEvent_page,'title': vEvent_title + "_" + "PV"});
			} else if("<%=flow%>" == "ad"){
				if(param == 10 || param == 11){
					vEvent_title2 = "설프라이즈딜";
				}else if(param == 12){
					vEvent_title2 = "배너_구매이벤트";
				}else if(param == 17 || param == 18){
					vEvent_title2 = "가격대별상품클릭";
				}else if(param == 19 || param == 20){
					vEvent_title2 = "농수산상품클릭";
				}else if(param == 21){
					vEvent_title2 = "배너_설날메세지";
				}else if(param == 22 || param == 23){
					vEvent_title2 = "한우상품클릭";
				}else if(param == 24 || param == 25){
					vEvent_title2 = "가공상품클릭";
				}else if(param == 26){
					vEvent_title2 = "배너_매일참여";
				}else if(param == 27 || param == 28){
					vEvent_title2 = "건강상품클릭";
				}else if(param == 29 || param == 30){
					vEvent_title2 = "상품권상품클릭";
				}else if(param == 31){
					vEvent_title2 = "배너_CM배너";
				}else if(param == 32){
					vEvent_title2 = "배너_혜택배너";
				}else{
					vEvent_title2 = "";
				}
				if(vEvent_title2 != ""){
					ga('send', 'event', 'mf_event', vEvent_title, vEvent_title + "_" + vEvent_title2);
				}
			} else {
				ga('send', 'event', 'mf_event', vEvent_title, vEvent_title + "_" + gaLabel[param-1]);
			}
		}
		return innerCall;
	}
});

function fnDeal(seq) {
	if (islogin()) {
		$.ajax({
			type	: "GET",
			url		: "/eventPlanZone/ajax/getExhdealUrl.jsp",
			data	: { "seq" : seq, "osTpCd" : getOsType() },
			async	: false,
			dataType: "JSON",
			success	: function(result) {
				if (result.soldoutYN == "Y") {
					alert("품절 되었습니다.");
					location.reload();
				} else if (result.moveUrl != "") {
					window.open(result.moveUrl);
					$.getJSON("/eventPlanZone/ajax/ctuExhDeal.jsp", {"exh_id":"2019010700", "goods_seq":seq , "shop_code":"55"}, function(data) {});
				} else {
					alert("다시 시도해주세요.");
				}
				return false;
			},
			error	: function() {
				alert("다시 시도해주세요.");
			}
		});
	} else {
		alert("로그인 후 참여할 수 있습니다.");
		Cmd_Login('emoneyPoint');
		return;
	}
}

//팝업
function onoff(id) {
	var mid=document.getElementById(id);
	if(mid.style.display=='') {
	mid.style.display='none';
}else{
	mid.style.display='';
	};
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
function YYYYMMDDHHMMSS(today) {
	return	today.getFullYear() + pad2(today.getMonth() + 1) + pad2(today.getDate())
			+ pad2(today.getHours()) + pad2(today.getMinutes()) + pad2(today.getSeconds());
	function pad2(n) { return (n < 10 ? '0' : '') + n; }
}
function itemClick(modelNo, minprice) {
	if(minprice > 0){
		window.open('/mobilefirst/detail.jsp?modelno=' + modelNo +'&freetoken=vip');
	}else{
		alert("품절된 상품 입니다.");
	}
}
function cateClick(param){
	window.open('/mobilefirst/list.jsp?cate=' + param +'&freetoken=list');
}
function bnrClick(param, param2){
	window.open("/mobilefirst/event2019/newyear_2019_evt.jsp?tab="+param);
}


</script>

</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
