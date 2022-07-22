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
	response.sendRedirect("/event2019/newsemester_2019.jsp");
	return;
}

String chkId   = ChkNull.chkStr(request.getParameter("chk_id"),"");
String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String userNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK"),"");

Members_Proc members_proc = new Members_Proc();
String userName = members_proc.getUserName(userId);
String userArea = userName;

// long cTime = System.currentTimeMillis();
// SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
// String sdt =dayTime.format(new Date(cTime));//진짜시간

// if( request.getServerName().indexOf("dev.enuri.com") > -1 && request.getParameter("sdt")!=null && !request.getParameter("sdt").equals("")){
//     sdt= request.getParameter("sdt");
// }

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

String strFb_title = "에누리 가격비교";
String strFb_description = "2019 새학기 통합기획전";
String strFb_img = ConfigManager.IMG_ENURI_COM + "/images/mobilenew/images/logo_enuri.png";
String tab = ChkNull.chkStr(request.getParameter("tab"));
String flow = ChkNull.chkStr(request.getParameter("flow"));
String evtUrl = "";
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
	<link rel="stylesheet" type="text/css" href="/css/event/y2019/newsemester_m.css"/>
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/lib/animate.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
	<script type="text/javascript" src="/common/js/function.js"></script>
</head>
<body>

<div class="wrap">
    <!-- 개인화영역 -->
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>

	<!-- 상단비주얼 -->
	<div class="visual">
		<div class="bg"></div>
		<div class="contents">
			<div class="blind">
				<h1>새학기대전 출발</h1>
			</div>

			<div id="floatingBN" class="floatingBN">
				<div>
					<a class="close" href="javascript:void(0);" onclick="$('#floatingBN').fadeOut(); return false">닫기</a>
					<a class="evtgo" href="/mobilefirst/event2019/newsemester_2019_evt.jsp?tab=1&freetoken=event" target="_blank" onclick="ga_log(5);">바로가기</a>
				</div>
			</div>
		</div>
	</div>
	<!-- //상단비주얼 -->

	<!-- 플로팅 탭 -->
	<div class="floattab">
		<div class="contents">
			<ul class="floattab__list">
				<li><a href="#evt1" onclick="ga_log(2);" class="floattab__item floattab__item--01"><em>매주 수요일 새학기 타임딜</em></a></li>
				<li><a href="#evt2" onclick="ga_log(3);" class="floattab__item floattab__item--02"><em>쇼핑하면 해피머니 증정</em></a></li>
				<li><a href="#itemlist01" onclick="ga_log(4);" class="floattab__item floattab__item--03"><em>미리미리 준비 새학기 필수템</em></a></li>
			</ul>
		</div>
	</div>
	<!-- //플로팅 탭 -->

    <!-- DEAL페이지 -->
	<div id="evt1" class="section dealwrap scroll">
		<div class="contents">
			<div class="tit">
				<h2><img src="<%=IMG_ENURI_COM%>/images/event/2019/newsemester/m_timedeal_tit.png" alt="새학기 타임딜 매주 수요일 오후 2시!"></h2>
			</div>

			<!-- 딜 구매영역 -->
			<div class="deal_slide">
			</div>
			<!-- 화살표 -->
			<div class="deal_arrow">
				<div class="arrow prev"><span>Prev</span></div>
				<div class="arrow next"><span>Next</span></div>
			</div>
		</div>
			<!-- //딜 구매영역 -->

        <!-- 딜 리스트영역 -->
        <div class="deal_list">
            <div class="contents">
                <h3>nextweek</h3>
                <div class="deal_nav">
                </div>
            </div>
        </div>
        <!--// 딜 리스트영역 -->

	</div>
	<!-- //DEAL페이지 -->

	<!-- //배너영역1 -->
	<div id="evt2" class="banner_area pr1 scroll">
		<a href="/mobilefirst/event2019/newsemester_2019_evt.jsp?tab=3&freetoken=event" class="ban_prize" title="프로모션 새창 이동" target="_blank" onclick="ga_log(8);">
			<img src="<%=IMG_ENURI_COM%>/images/event/2019/newsemester/m_evtbn.png" alt="APP에서 새학기준비물 구매하면 해피머니 상품권 50명 추첨 증정" />
		</a>
	</div>
	<!-- //배너영역1 -->

	<!-- 추천상품 영역 -->
	<div class="recommend_wrap">
		<div class="tit">
			<div class="contents">
				<h2><img src="<%=IMG_ENURI_COM%>/images/event/2019/newsemester/m_recom_tit.png" alt="새학기에 꼭 필요한 추천템!" class="imgs" /></h2>
			</div>
		</div>
		<!-- 추천상품1 -->
		<div id="itemlist01" class="recom_prod Re01 scroll">
			<div class="contents">
				<h2><img src="<%=IMG_ENURI_COM%>/images/event/2019/newsemester/m_re_subtitle01.png" alt="농수산 선물세트" class="imgs"></h2>
				<!-- 태그 -->
				<ul class="taglist">
					<li class="tag on"><a href="#itemlist01">#PC/노트북</a></li>
					<li class="tag"><a href="#itemlist02">#학용품</a></li>
					<li class="tag"><a href="#itemlist03">#가방/패션</a></li>
					<li class="tag"><a href="#itemlist04">#학생가구</a></li>
					<li class="tag"><a href="#itemlist05">#든든한 아침</a></li>
				</ul>
				<!-- 태그 -->
				<div class="liveProduct">
					<div id="slider01" class="itemlist">
					</div>
				</div>
				<a class="btn_more">상품더보기</a>
	        </div>
	    </div>
		<!-- //추천상품1 -->

		<!-- 추천상품2 -->
		<div id="itemlist02" class="recom_prod Re02">
			<div class="contents">
				<h2><img src="<%=IMG_ENURI_COM%>/images/event/2019/newsemester/m_re_subtitle02.png" alt="농수산 선물세트"></h2>
				<!-- 태그 -->
				<ul class="taglist">
					<li class="tag"><a href="#itemlist01">#PC/노트북</a></li>
					<li class="tag on"><a href="#itemlist02">#학용품</a></li>
					<li class="tag"><a href="#itemlist03">#가방/패션</a></li>
					<li class="tag"><a href="#itemlist04">#학생가구</a></li>
					<li class="tag"><a href="#itemlist05">#든든한 아침</a></li>
				</ul>
				<!-- 태그 -->
				<div class="liveProduct">
					<div id="slider02" class="itemlist">
					</div>
				</div>
				<a class="btn_more">상품더보기</a>
	        </div>
	    </div>
		<!-- //추천상품2 -->

		<!-- 추천상품3 -->
		<div id="itemlist03" class="recom_prod Re03">
			<div class="contents">
				<h2><img src="<%=IMG_ENURI_COM%>/images/event/2019/newsemester/m_re_subtitle03.png" alt="농수산 선물세트"></h2>
				<!-- 태그 -->
				<ul class="taglist">
					<li class="tag"><a href="#itemlist01">#PC/노트북</a></li>
					<li class="tag"><a href="#itemlist02">#학용품</a></li>
					<li class="tag on"><a href="#itemlist03">#가방/패션</a></li>
					<li class="tag"><a href="#itemlist04">#학생가구</a></li>
					<li class="tag"><a href="#itemlist05">#든든한 아침</a></li>
				</ul>
				<!-- 태그 -->
				<div class="liveProduct">
					<div id="slider03" class="itemlist">
					</div>
				</div>
				<a class="btn_more">상품더보기</a>
	        </div>
	    </div>
		<!-- //추천상품3 -->

		<!-- 추천상품4 -->
		<div id="itemlist04" class="recom_prod Re04">
			<div class="contents">
				<h2><img src="<%=IMG_ENURI_COM%>/images/event/2019/newsemester/m_re_subtitle04.png" alt="농수산 선물세트"></h2>
				<!-- 태그 -->
				<ul class="taglist">
					<li class="tag"><a href="#itemlist01">#PC/노트북</a></li>
					<li class="tag"><a href="#itemlist02">#학용품</a></li>
					<li class="tag"><a href="#itemlist03">#가방/패션</a></li>
					<li class="tag on"><a href="#itemlist04">#학생가구</a></li>
					<li class="tag"><a href="#itemlist05">#든든한 아침</a></li>
				</ul>
				<!-- 태그 -->
				<div class="liveProduct">
					<div id="slider04" class="itemlist">
					</div>
				</div>
				<a class="btn_more">상품더보기</a>
	        </div>
	    </div>
		<!-- //추천상품4 -->

		<!-- 추천상품5 -->
		<div id="itemlist05" class="recom_prod Re05">
			<div class="contents">
				<h2><img src="<%=IMG_ENURI_COM%>/images/event/2019/newsemester/m_re_subtitle05.png" alt="농수산 선물세트"></h2>
				<!-- 태그 -->
				<ul class="taglist">
					<li class="tag"><a href="#itemlist01">#PC/노트북</a></li>
					<li class="tag"><a href="#itemlist02">#학용품</a></li>
					<li class="tag"><a href="#itemlist03">#가방/패션</a></li>
					<li class="tag"><a href="#itemlist04">#학생가구</a></li>
					<li class="tag on"><a href="#itemlist05">#든든한 아침</a></li>
				</ul>
				<!-- 태그 -->
				<div class="liveProduct">
					<div id="slider05" class="itemlist">
					</div>
				</div>
				<a class="btn_more">상품더보기</a>
	        </div>
	    </div>
		<!-- //추천상품5 -->
	</div>
	<!-- //추천상품 영역 -->

	<!-- 기획전 배너 -->
	<div class="market_area">
		<div class="contents">
			<h2><img src="<%=IMG_ENURI_COM%>/images/event/2019/newsemester/m_market_tit.png" alt="에누리 기획전" /></h2>
			<ul class="evtbnr">
<%-- 				<li><a href="/mobilefirst/planlist.jsp?t=B_20190125113122&freetoken=planlist" target="_blank"><img src="<%=IMG_ENURI_COM%>/images/event/2019/newsemester/newsemester_bn3.png" alt=""  /></a></li> --%>
				<li><a href="/mobilefirst/planlist.jsp?t=B_20180009128999&freetoken=planlist" target="_blank"><img src="<%=IMG_ENURI_COM%>/images/event/2019/newsemester/newsemester_bn2.png" alt=""  /></a></li>
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
<%-- 					<li><a href="/mobilefirst/planlist.jsp?t=B_20190125113122&freetoken=planlist" target="_blank"><img src="<%=IMG_ENURI_COM%>/images/event/2019/newsemester/newsemester_bn3.png" alt="" ></a></li> --%>
					<li><a href="/mobilefirst/planlist.jsp?t=B_20180009128999&freetoken=planlist" target="_blank"><img src="<%=IMG_ENURI_COM%>/images/event/2019/newsemester/newsemester_bn2.png" alt="" ></a></li>
				</ul>
			</div>
		</div>
	</div>
	<!-- //기획전 스프레드 레이어 -->
	<script type="text/javascript">
	$(".market_area .evtbnr li:not(.slick-cloned), #layer_planlist .planlist_view li").click(function(){
		ga_log(19);
		if($(this).hasClass("market_area")){
			alert("1");
		}
	})
	</script>
	<!-- 에누리 혜택 -->
	<%@include file="/eventPlanZone/jsp/eventBannerTapMobile_xmas_2018.jsp"%>
	<!-- //에누리 혜택 -->
	<script type="text/javascript">
		$('div.otherbene .contents > h2').html("<img src=\"<%=IMG_ENURI_COM%>/images/event/2019/newsemester/m_otherbene_tit.png\" alt=\"에누리 혜택\" class=\"imgs\">");
		$(".banlist > li").click(function(){
			ga_log(20);
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
	<span class="go_top"><a href="#" >TOP</a></span>
</div>

<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20180831"></script>

<script type="text/javascript">
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로

var ga_log;
var isFlow = "<%=flow%>" == "ad";
$(document).ready(function() {
	ga_log = gaCall();

	if(islogin()){
		$("#user_id").text("<%=userId%>");
		getPoint();//개인e머니 내역 노출
	}

	function gaCall() {
		var gaLabel = [
						 '19년 새학기 통합기획전 PV'
						,'19년 새학기 통합기획전_탭_타임딜'
						,'19년 새학기 통합기획전_탭_이벤트'
						,'19년 새학기 통합기획전_탭_중단상품'
						,'19년 새학기 통합기획전_플로팅_이벤트배너'
						,'19년 새학기 통합기획전_타임딜_상품보기'
						,'19년 새학기 통합기획전_타임딜_구매하기'
						,'19년 새학기 통합기획전_배너_해피머니'
						,'19년 새학기 통합기획전_상품_PC/노트북'
						,'19년 새학기 통합기획전_상품더보기_PC/노트북'
						,'19년 새학기 통합기획전_상품_학용품'
						,'19년 새학기 통합기획전_상품더보기_학용품'
						,'19년 새학기 통합기획전_상품_가방/패션'
						,'19년 새학기 통합기획전_상품더보기_가방/패션'
						,'19년 새학기 통합기획전_상품_학생가구'
						,'19년 새학기 통합기획전_상품더보기_학생가구'
						,'19년 새학기 통합기획전_상품_든든아침'
						,'19년 새학기 통합기획전_상품더보기_든든아침'
						,'19년 새학기 통합기획전_CM배너'
						,'19년 새학기 통합기획전_혜택배너'
		              ];

		var vEvent_title = "19년 새학기";

		function innerCall (param) {
			if ( param == 1 ) {
	 			ga('send', 'pageview', {'page': vEvent_page,'title': vEvent_title + " 통합기획전_" + "PV"});
			} else {
 				ga('send', 'event', 'mf_event', vEvent_title, gaLabel[param-1]);
			}
		}
		return innerCall;
	}

	var getUrl = "/mobilefirst/http/json/exh_deal_list_2019012100.json" //딜영역 데이터
	var vView_s_dtm = "";
	var vView_e_dtm = "";
	var vSal_s_dtm = "";
	var vSal_e_dtm = "";
	var vCur_dtm = YYYYMMDDHHMMSS(new Date());
	var dealInfos = [
	                 {
	                	 "period" : "2/13(수) 2PM",
	                	 "open"   : "2.13일(수) 2PM 오픈",
	                	 "cls"    : "open0213",
                	 },
	                 {
                		 "period" : "2/20(수) 2PM",
	                	 "open"   : "2.20일(수) 2PM 오픈",
	                	 "cls"    : "open0220",
	                 },
	                 {
	                	 "period" : "2/27(수) 2PM",
	                	 "open"   : "2.27일(수) 2PM 오픈",
	                	 "cls"    : "open0227",
	                 },
	                ];

	$.ajax({
		type : "GET",
		url  : getUrl,
		dataType : "JSON",
		success:function(data){
			var makeHtml = "";
			var makeHtml2 = "";
			var txt = ["m1.png","m2.png","m3.png"];
			var img = ["1.png","2.png","3.png"];
			$.each(data, function(i,v){
				vView_s_dtm = v.GD_VIEW_S_DTM_CVT;
				vView_e_dtm = v.GD_VIEW_E_DTM_CVT;
				vSal_s_dtm = v.GD_SAL_S_DTM_CVT;
				vSal_e_dtm = v.GD_SAL_E_DTM_CVT;

				makeHtml +=" <div class=\"deal_item clearfix\">";
				makeHtml +=" 	<div class=\"container\">";
				makeHtml +=" 		<div class=\"thumb\">";
				if(vCur_dtm < vSal_s_dtm){
					makeHtml +="			<div class=\"date "+dealInfos[i].cls+"\"></div>";
				}
				makeHtml +="			<img src=\"http://imgenuri.enuri.gscdn.com/images/exhDeal/mobile/prod_img/"+img[i]+"\">";
				makeHtml +="		</div>";
				makeHtml +="		<div class=\"item_info\">";
				makeHtml +="			<div class=\"inner\">";
				makeHtml +="				<div class=\"sub_tit\">";
				makeHtml +="					<img src=\"http://imgenuri.enuri.gscdn.com/images/exhDeal/mobile/text_img/"+txt[i]+"\" alt=\"타임특가 할인률, 갯수 표시\">";
				makeHtml +="				</div>"
				makeHtml +="				<p class=\"prodname\">"+v.GD_MODEL_NM1+"<br>"+v.GD_MODEL_NM2+"</p>";
				makeHtml +="				<p class=\"price\"><strong>"+commaNum(v.GD_DC_PRC)+"<span>원</span></strong></p>";
				if(i == 2){
					makeHtml +="				<p class=\"ad\">※ <em>쿠폰적용 필수</em> / ID당 1회 / <em>개인통관번호 필수</em> <span class=\"mark\"><img src=\"http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/inter_logo.jpg\" alt=\인터파크\"></span></p>";
				}else{
					makeHtml +="				<p class=\"ad\">※ <em>쿠폰적용 필수</em> / ID당 1회 / 무료배송 <span class=\"mark\"><img src=\"http://imgenuri.enuri.gscdn.com/images/event/2019/newyear/inter_logo.jpg\" alt=\인터파크\"></span></p>";
				}
				makeHtml +="			</div>";
				makeHtml +="		</div><br>";
				makeHtml +="		<ul class=\"btn_area clearfix\" id=\"btn_area"+i+"\">";
				makeHtml +="			<li><a href=\"javascript:void(0);\" class=\"deal_btn dview\" onclick = \"itemClick('"+v.GD_MODEL_NO+"','"+v.GD_DC_PRC+"'); ga_log(6);\">상품보기</a></li>";
				if(v.GD_SO_YN == "Y"){
	 				makeHtml +="			<li><a class=\"deal_btn soldout\">품절</a></li>";
				}else if(vCur_dtm < vSal_s_dtm){
					makeHtml +="			<li><a class=\"deal_btn time14\">판매예정</a></li>";
				}else if(v.GD_SO_YN == "N" && vSal_s_dtm <= vCur_dtm && vSal_e_dtm >= vCur_dtm){
					makeHtml +="			<li><a class=\"deal_btn buy\" onclick=\"fnDeal('"+v.EXH_DEAL_NO+"'); ga_log(7);\">구매하기</a></li>";
				}else{
					makeHtml +="			<li><a class=\"deal_btn soldout\">품절</a></li>";
				}
				makeHtml +="		</ul>";
				makeHtml +="	</div>";
				makeHtml +="</div>";

				makeHtml2 +="<div class=\"w_item\">";
				makeHtml2 +="<div class=\"w_thumb\">";
				makeHtml2 +="    <div class=\"period\">";
				makeHtml2 +="        <span>"+dealInfos[i].period+"</span>";
				makeHtml2 +="    </div>";
				makeHtml2 +="    <img src=\"http://imgenuri.enuri.gscdn.com/images/exhDeal/mobile/prod_img/"+img[i]+"\" alt=\"\" />";
				makeHtml2 +="</div>";
				makeHtml2 +="<span class=\"w_bg\"></span>";
				makeHtml2 +="<span class=\"w_tit\">"+v.GD_MODEL_NM1+"<br>"+v.GD_MODEL_NM2+"</span>";
				makeHtml2 +="</div>";

				if(i==2) return false;
			});

			$(".deal_slide").html(makeHtml);
			$(".deal_list .deal_nav").html(makeHtml2);

		},complete : function(data){
			$('.deal_slide').slick({ //deal영역 slick
				slidesToShow: 1,
				slidesToScroll: 1,
				arrows: false,
				fade: false,
				dots: true,
				speed: 300,
				asNavFor: '.deal_nav'
			});
			$('.deal_nav').slick({
				slidesToShow: 3,
				slidesToScroll: 1,
				asNavFor: '.deal_slide',
				centerMode: false,
				focusOnSelect: true,
				variableWidth: true
			});

			$('.deal_slide').on('beforeChange', function(e, s, c, n){
				$('.deal_nav .w_item').removeClass("slick-current");
				$('.deal_nav .w_item').eq(n).addClass("slick-current");
			});

			//  deal 화살표 이전
			$('.deal_arrow .arrow.prev').on('click', function(e) {
				var index = $('.deal_slide').slick("slickCurrentSlide");
				$('.deal_slide').slick('slickPrev');

				$('.deal_nav .w_item').removeClass("slick-current");
				$('.deal_nav .w_item').eq(--index).addClass("slick-current");
			});
			//  deal 화살표 다음
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
        		if($("#btn_area"+i+" li a").hasClass("soldout")){
        		} else {
	        		$('.deal_slide').slick('slickGoTo', i, false);
        		}
    		}
		}
	});

	var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=25"; //탭영역 데이터

	//탭영역 전체 상품 데이터
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

 	var arrItemLog = [9,11,13,15,17];
	for(var idx=0; idx<5; idx++){
		$.each(ajaxData[idx].GOODS, function(i,v){
			img = v.GOODS_IMG ? v.GOODS_IMG : v.IMG_SRC;
			if(img == ""){
				img = "<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png";
			}
			makeHtml += "<div class=\"lpitem\">";
			makeHtml += "	<a target=\"_blank\" title=\"새 탭에서 열립니다.\" onclick=\"itemClick('"+v.MODELNO+"','"+v.MINPRICE+"'); ga_log("+arrItemLog[idx]+");\">";
			makeHtml += "		<span class=\"thumb\">";
			if(v.MINPRICE == 0){
				makeHtml += "	<span class=\"soldout\"></span>";
			}
			makeHtml += "			<img src=\""+img+"\" alt=\"\" />";
			makeHtml += "		</span>";
			makeHtml += "		<span class=\"info\">";
			makeHtml += "			<span class=\"pname\">"+v.TITLE1+v.TITLE2+"</span>";
			makeHtml += "			<em><b>"+commaNum(v.MINPRICE)+"</b>원</em>";
			makeHtml += "		</span>";
			makeHtml += "	</a>";
			makeHtml += "</div>";
		});
		$("#itemlist0"+(idx+1)+" .itemlist").html(makeHtml);

		makeHtml = "";
	}

	$(".recommend_wrap .btn_more").click(function(){ //탭영역 상품더보기
		var btn = $(this).parent().parent().index();
		var idx = [10, 12, 14, 16, 18];
		var moreUrl = [
		               '/mobilefirst/list.jsp?cate=040461&freetoken=list'
		               ,'/mobilefirst/list.jsp?cate=1822&freetoken=list'
		               ,'/mobilefirst/list.jsp?cate=14550304&freetoken=list'
		               ,'/mobilefirst/list.jsp?cate=1205&freetoken=list'
		               ,'/mobilefirst/list.jsp?cate=151306&freetoken=list'
		               ];

		window.open(moreUrl[btn-1]);
		ga_log(idx[btn-1]);
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
				   $.getJSON("/eventPlanZone/ajax/ctuExhDeal.jsp", {"exh_id":"2019012100", "goods_seq":seq , "shop_code":"55"}, function(data) {});
			   }else{
				   alert("다시 시도해주세요.");
			   }
			   return false;
		   },
		   error    : function(){
			   alert("다시 시도해주세요.");
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

function itemClick(modelNo,minprice){
	if(minprice>0){
		window.open('/mobilefirst/detail.jsp?modelno=' + modelNo +'&freetoken=vip');
	}else{
		alert("품절된 상품입니다.");
	}
}

$(window).on("load",function(){
	ga_log(1);

	var $nav = $(".floattab__item"), // scroll tabs
    $navTop = $nav.offset().top,
    $myHgt = $(".myarea").height(),
    $navHgt = Math.ceil($(".floattab__list").height() * 1.25);

	var tab = "<%=tab%>";

	switch (tab){
	case "1":
		$('html, body').stop().animate({ scrollTop:Math.ceil($('#itemlist01').offset().top)}, 500);
		break;
	case "2":
		$('html, body').stop().animate({ scrollTop:Math.ceil($('#itemlist02').offset().top)}, 500);
		break;
	case "3":
		$('html, body').stop().animate({ scrollTop:Math.ceil($('#itemlist03').offset().top)}, 500);
		break;
	case "4":
		$('html, body').stop().animate({ scrollTop:Math.ceil($('#itemlist04').offset().top)}, 500);
		break;
	case "5":
		$('html, body').stop().animate({ scrollTop:Math.ceil($('#itemlist05').offset().top)}, 500);
		break;
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
</script>

<script>
$(document).ready(function() {

	// 상단 메뉴 스크롤 시, 고정
	var $nav = $('.floattab'),
		$menu = $('.floattab__list li'),
		$contents = $('.scroll'),
		$navheight = $nav.outerHeight(), // 상단 메뉴 높이
		$navtop = Math.ceil($nav.offset().top); // floattab 현재 위치;

	// 해당 섹션으로 스크롤 이동
	$menu.on('click', 'a', function (e) {
		var $target = $(this).parent(),
			idx = $target.index(),
			offsetTop = Math.ceil($contents.eq(idx).offset().top);

		$('html, body').stop().animate({ scrollTop: offsetTop }, 500);
		return false;
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

	// 추천상품1 slick
	$('#slider01, #slider02, #slider03, #slider04, #slider05').slick({
		infinite: true,
		dots: true,
		rows: 2,
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

	//하단상품 리스트 플리킹
	$('.btitem_list .items_area').slick({
		dots:true,
		slidesToScroll: 1
	});
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
</script>

</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>