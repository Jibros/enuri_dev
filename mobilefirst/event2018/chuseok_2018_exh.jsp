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
	response.sendRedirect("/event2018/chuseok_2018_exh.jsp");
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
String strFb_description = "추석통합기획전";
String strFb_img = ConfigManager.IMG_ENURI_COM + "/images/mobilenew/images/logo_enuri.png";
String tab = ChkNull.chkStr(request.getParameter("tab"));
String flow = ChkNull.chkStr(request.getParameter("flow"));
String evtUrl = "/mobilefirst/evt/chuseok_2018.jsp?tab=evt2&freetoken=event";
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
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/chuseok_m.css"/>
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/lib/animate.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="http://m.enuri.com/mobilefirst/css/lib/slick.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
</head>
<body>

<div class="wrap">

	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>

	<!-- 상단비주얼 -->
	<div class="visual">
		<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/chuseok/m_visual.jpg" alt="2018 한눈에 보는 한가위 선물전" class="imgs" />
	</div>

	<!-- floattab__list -->
	<div  class="floattab__list">
		<div class="scrollList">
			<ul class="floatmove">
				<li><a href="#contArea1" onclick="ga_log(2);" class="floattab__item floattab__item--01 is-on">추석선물 BEST</a></li>
				<li><a href="#contArea2" onclick="ga_log(4);" class="floattab__item floattab__item--02">BEST추천 선물세트</a></li>
				<li><a href="#contArea3" onclick="ga_log(5);" class="floattab__item floattab__item--03">가격대별 추석선물</a></li>
                <li><a href="#contArea4" onclick="ga_log(6);" class="floattab__item floattab__item--04">추석연휴 알차게즐기기</a></li>
                <li class="evt_join"><a href="javascript:///" onclick="ga_log(3);window.open('<%=evtUrl%>');" title="페이지 이동">롯데마트상품권 이벤트</a></li>
			</ul>
		</div>
		<a href="javascript:///" class="btn_tabmove"><em>탭 이동</em></a>
	</div>
	<!-- //floattab__list -->

	<script>
		//플로팅 상단 탭 이동
// 		$(document).on('click', '.floattab__list .floatmove a', function(e) {
		$(document).on('click', '.floattab__list .floatmove :not(li.evt_join) a', function(e) {
			var contid = $(this).attr('href'),
				$anchor = Math.ceil($(contid).offset().top),
				$navHgt = Math.ceil($(".floattab__list").height() + 31);
			$('html, body').stop().animate({scrollTop: $anchor - $navHgt}, 500);
			e.preventDefault();
		});

		$(window).load(function(){
			var $nav = $(".floattab__list"), // scroll tabs
				$navTop = $nav.offset().top,
				$myHgt = $(".myarea").height(),
				$ares1 = $("#contArea1").offset().top - $nav.outerHeight(),
				$ares2 = $("#contArea2").offset().top - $nav.outerHeight(),
				$ares3 = $("#contArea3").offset().top - $nav.outerHeight(),
				$ares4 = $("#contArea4").offset().top - $nav.outerHeight()

			// 상단 탭 position 변경 및 버튼 활성화
			$(window).scroll(function(){
				var $currY = $(this).scrollTop() + $myHgt // 현재 scroll

				if ($currY > $navTop) {
					$nav.addClass("is-fixed");
					$("#contArea1").css("margin-top", $nav.outerHeight());

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
						$(".scrollList").scrollLeft(250);
					}else if($ares4 <= $currY){
						$nav.find("a").removeClass("is-on");
						$(".floattab__item--04").addClass("is-on");
						$(".scrollList").scrollLeft(350);
					}

				} else {
					$nav.removeClass("is-fixed"),
					$("#contArea1").css("margin-top",0);
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
		});
	</script>

    <!-- 추석 DEAL페이지 -->
    <div id="contArea1" class="section dealwrap scroll">
        <div id="dealArea" class="contents">
			<div class="dw_tit">
				<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/chuseok/sd_title.png" alt="월요일2시오픈 서프라이즈추석"></h2>
            </div>
            <!-- 딜 구매영역 -->
            <div class="deal_slide">
            	<!-- 딜 아이템 loop -->
            	<div v-for="(item, index) in items" v-if="index < 3" class="deal_item" v-bind:id="'deal_item'+index">
					<div class="sub_area">
						<span><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/chuseok/cloud_Object.png" alt="구름"></span>
						<p class="period_info">{{ htmlInfos[index].period }}</p>
					</div>
	                <div class="thumb">
	                    <em v-bind:class="sell[index].cls"></em>
	                    <div class="pnum_info">
	                        <p class="per"><strong>{{ item.GD_DC_RT==null?0:item.GD_DC_RT }}</strong>%</p>
	                        <p class="num"><strong>{{ item.GD_QTY==null?0:commaNum(item.GD_QTY) }}</strong>개</p>
	                    </div>
	                    <img v-bind:data-lazy="'<%=ConfigManager.STORAGE_ENURI_COM%>'+item.GD_IMG_URL" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png" />
	                </div>
	                <div class="item_info">
	                    <p class="tit">{{ item.GD_MODEL_NM1 }}<br>{{ item.GD_MODEL_NM2 }}</p>
	                    <div class="mark"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/chuseok/logo.png" alt="인터파크">	</div>
	                    <ul class="price_info">
	                        <li><p class="price">정상판매가<strike>{{ item.GD_PRC==null?0:commaNum(item.GD_PRC) }}원</strike></p></li>
	                        <li><p class="price_dis">추석딜 특가 <strong>{{ item.GD_DC_PRC==null?0:commaNum(item.GD_DC_PRC) }}</strong>원</p></li>
	                    </ul>
	                    <div class="btn_group">
	                    	<a href="javascript:///" class="deal_btn" v-on:click="ga_log(7);" v-bind:class="sell[index].btn">
	                    		<template v-if="sell[index].YN == 'Y'">
	                    			<span v-on:click="chuseokDeal(item.EXH_DEAL_NO)">{{ sell[index].btnname }}</span>
	                    		</template>
	                    		<template v-else>
	                    			<span>{{ sell[index].btnname }}</span>
	                    		</template>
	                    	</a>
	                        <span class="btn_detail">※ <em class="txt_point">쿠폰적용 필수</em> / ID당 1회 / 무료배송</span>
	                    </div>
	                </div>
	            </div>
			</div>
	        <!-- //딜 구매영역 -->

            <!-- 딜 리스트영역 -->
            <div class="deal_list">
                <div class="deal_nav">
                	<div v-for="(item, index) in items" v-if="index < 3" v-on:click="ga_log(8);" class="w_item">
                        <div class="period">
                            <span>{{ htmlInfos[index].period }}</span>
                        </div>
                        <div class="w_thumb second"><img v-bind:src="'<%=ConfigManager.STORAGE_ENURI_COM%>'+item.GD_IMG_URL" /></div>
                        <span class="w_bg">그림자</span>
                        <span class="w_tit">{{ item.GD_MODEL_NM1 }}<br>{{ item.GD_MODEL_NM2 }}</span>
                    </div>
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
    <!-- //추석 DEAL페이지 -->

	<!-- 베스트 선물세트 -->
	<div id="bestGiftSetArea">
	<div v-for="(htmlInfo, idx) in htmlInfos" v-bind:id="(idx==0?htmlInfo.id:'')" v-bind:class="htmlInfo.class">
		<template v-if="idx > 0">
			<div v-bind:id="htmlInfo.id" class="anchor_p"></div> <!-- 앵커포인트추가-->
		</template>
		<div class="contents">
            <div class="bt_tit">
                <img v-bind:src="htmlInfo.img" alt="">
            </div>
            <div class="blind">
                <h2>{{ htmlInfo.h2 }}</h2>
                <strong>{{ htmlInfo.strong }}</strong>
                <em>{{ htmlInfo.em }}</em>
            </div>
			<!-- dw_wrap -->
			<div class="dw_wrap">
				<div class="dw_detail">
					<div class="d_item" v-for="(item, index) in items[idx]" v-on:click="ga_log(9+idx); itemClick(item.MODELNO, item.MINPRICE3)">
						<div class="_photo">
							<div class="fade_list">
								<a href="javascript:///">
									<div class="thumb">
										<template v-if="item.GOODS_IMG">
											<img v-bind:data-lazy="item.GOODS_IMG" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png" alt="" />
										</template>
										<template v-else>
											<img v-bind:data-lazy= "item.IMG_SRC" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png" alt="" />
										</template>
										<template v-if="item.MINPRICE3 == 0">
											<em class="stripe sd_soldout">SOLD OUT</em>
			                            </template>
									</div>
									<div class="pro_info">
										<span class="title">{{ item.TITLE1 }} <br>{{ item.TITLE2 }}</span>
										<span class="discount">최저가 <b>{{ (item.MINPRICE3==null?0:commaNum(item.MINPRICE3)) }}</b>원</span>
									</div>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- //dw_wrap -->
            <a href="javascript:///" class="more_btn st1" v-on:click="moreItem(idx)">
                <strong>상품더보기</strong>
            </a>
		</div>
	</div>
	</div>

	<!-- 탭 컨텐츠 id #contArea3 / 가격맞춤 실속선물 -->
	<div id="contArea3" class="section priceListWrap">
		<div class="contents conts_gift1">
			<h2>가격부담 줄이고 만족은 높이고 가격맞춤 실속선물</h2>
			<!-- liveProduct -->
			<div class="liveProduct">
				<ul class="tabs">
					<li v-for="(htmlInfo, idx) in htmlInfos"><a v-bind:href="'#' + htmlInfo.id" v-on:click="ga_log(13+idx)" v-bind:class="htmlInfo.class">{{ htmlInfo.title }}</a></li>
				</ul>

				<!-- tab_container -->
				<div class="tab_container">
					<!-- tab -->
					<div v-for="(htmlInfo, idx) in htmlInfos" v-bind:id="htmlInfo.id" class="tab_content">
						<div class="lp_tabs_cont">
							<ul>
								<li v-for="(item, index) in items[idx]"  v-on:click="ga_log(17); itemClick(item.MODELNO, item.MINPRICE3)">
									<a href="javascript:///" target="_blank" title="새 탭에서 열립니다." class="btn">
										<div class="imgs">
											<template v-if="item.GOODS_IMG">
												<img v-lazy= "item.GOODS_IMG" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png" alt="" />
											</template>
											<template v-else="item.IMG_SRC">
												<img v-lazy= "item.IMG_SRC" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png" alt="" />
											</template>
											<template v-if="item.MINPRICE3 == 0">
												<span class="soldout">SOLD OUT</span>
				                            </template>
										</div>
										<div class="info">
											<p class="pname">{{ item.TITLE1 }} <br>{{ item.TITLE2 }}</p>
											<p class="price"><span class="lowst">최저가 </span><i>{{ (item.MINPRICE3==null?0:commaNum(item.MINPRICE3)) }}</i>원</p>
										</div>
									</a>
								</li>
							</ul>
							<div class="more_btn" v-on:click="moreItem(idx)">
								<a href="javascript:///"><strong>상품더보기</strong></a>
							</div>
						</div>
					</div>
					<!-- //tab -->
				</div>
				<!-- //tab_container -->
			</div>
			<!-- //liveProduct -->
		</div>
	</div>
	<!-- 탭 컨텐츠 id #contArea3 / 가격맞춤 실속선물 -->

	<!-- 탭 컨텐츠 id #contArea4 / 추석연휴 알차게 -->
	<div id="contArea4" class="section priceListWrap">
		<div class="contents conts_gift2">
			<h2>추석연휴를 알차게~ 풍성한 추석연휴</h2>
			<!-- liveProduct -->
			<div class="liveProduct">
				<ul class="tabs">
					<li v-for="(htmlInfo, idx) in htmlInfos"><a v-bind:href="'#' + htmlInfo.id" v-on:click="ga_log(18+idx)" v-bind:class="htmlInfo.class">{{ htmlInfo.title }}</a></li>
				</ul>

				<!-- tab_container -->
				<div class="tab_container">
				<!-- tab -->
					<template v-for = "n in htmlInfos.length">
					<div v-bind:id="htmlInfos[n-1].id" class="tab_content">
						<div class="lp_tabs_cont">
							<ul>
								<li v-for="(item, index) in items[n-1]" v-if="index < 8"  v-on:click="ga_log(22); itemClick(item.MODELNO, item.MINPRICE3)">
									<a href="javascript:///" target="_blank" title="새 탭에서 열립니다." class="btn">
										<div class="imgs">
											<template v-if="item.GOODS_IMG">
												<img v-lazy= "item.GOODS_IMG" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png" alt="" />
											</template>
											<template v-else="item.IMG_SRC">
												<img v-lazy= "item.IMG_SRC" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png" alt="" />
											</template>
											<template v-if="item.MINPRICE3 == 0">
												<span class="soldout">SOLD OUT</span>
				                            </template>
										</div>
										<div class="info">
											<p class="pname">{{ item.TITLE1 }} <br>{{ item.TITLE2 }}</p>
											<p class="price"><span class="lowst">최저가 </span><i>{{ (item.MINPRICE3==null?0:commaNum(item.MINPRICE3)) }}</i>원</p>
										</div>
									</a>
								</li>
							</ul>
							<div class="more_btn" v-on:click="moreItem(n-1)">
								<a href="javascript:///"><strong>상품더보기</strong></a>
							</div>
						</div>
					</div>
					</template>
					<!-- //tab -->
				</div>
				<!-- //tab_container -->
			</div>
			<!-- //liveProduct -->
		</div>
	</div>
	<!-- 탭 컨텐츠 id #contArea4 / 추석연휴 알차게 -->

	<!-- 기획전 배너 -->
	<div class="rd_banner">
		<div class="contents">
			<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/chuseok/banner_tit.png" alt="에누리 여름 기획전" /></h2>
			<ul class="evtbnr" id="recPlanlist1">
				<li><a href="javascript:///"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/chuseok_2018_1.png" alt=""  /></a></li>
				<li><a href="javascript:///"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/chuseok_2018_2.png" alt=""  /></a></li>
				<li><a href="javascript:///"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/chuseok_2018_3.png" alt=""  /></a></li>
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
					<li><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/chuseok_2018_1.png" alt="" ></li>
					<li><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/chuseok_2018_2.png" alt=""></li>
					<li><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/chuseok_2018_3.png" alt=""></li>
				</ul>
			</div>
		</div>
	</div>
	<!-- //기획전 스프레드 레이어 -->
	<script type="text/javascript">
		$("#recPlanlist1, #recPlanlist2").find("li").click(function(e){
			ga_log(23);
			var exhNo = [
				"20180820192100","20180821093500","20180824102700"
			];
			var idx = e.currentTarget.className.indexOf("slick") > -1 ? $(this).index()-1 : $(this).index();
			window.open("/mobilefirst/planlist.jsp?t=B_"+exhNo[idx] + "&freetoken=planlist");
		});
	</script>

	<!-- 에누리 혜택 -->
	<%@include file="/eventPlanZone/jsp/eventBannerTapMobile_201806.jsp"%>
	<script type="text/javascript">
		$(".banlist > li").click(function(){
			ga_log(24);
		});
	</script>
	<!-- //에누리 혜택 -->

	<!-- layer-->
	<div class="layer_back" id="app_only" style="display:none;">
		<div class="appLayer">
			<h4>모바일 앱 전용 이벤트</h4>
			<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
			<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
			<p class="btn_close"><button type="button" onclick="install_btt();">설치하기</button></p>
		</div>
	</div>
	<!-- //layer-->

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
<script type="text/javascript" src="/mobilefirst/js/lib/vue.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/vue-lazyload.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20180831"></script>

<script type="text/javascript">
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로

var ga_log;

$(document).ready(function() {
	ga_log = gaCall();

	//https://github.com/hilongjw/vue-lazyload
	Vue.use(VueLazyload, {
		preLoad	: 3,
		attempt: 1
	});

	// 추석 기획전
	var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=18";
	var ajaxData = (function() {
		var goodsArray = [];
		var json = {};

		$.ajax({
			url		: loadUrl,
			dataType: "json",
			async	: false,
			global	: false,
			success	: function(data) {
				var Tdata = data.T;
				$.each(Tdata, function(i, v) {
					goodsArray.push(v.GOODS);
				});
				json.GOODS = goodsArray;
			}
		});
		return json;
	})();

	// 추석딜
	var dealLoadUrl = "/mobilefirst/http/json/exh_deal_list_2018090101.json";
	var dealData = (function() {
		var dealArray = [];
		var json = {};

		$.ajax({
			url		: dealLoadUrl,
			dataType: "json",
			async	: false,
			global	: false,
			success	: function(data) {
				json = data;
			}
		});
		return json;
	})();

	var deal = new Vue({
		el		: "#dealArea",
		data	: {
			items	: [],
			repItems: [],
			htmlInfos: [
			            {
			            	"period": "9/5 ~ 9/11",
// 			            	"open"	: "9/5 10시오픈",
			            	"cls"	: "stripe soon905"
			            },
			            {
			            	"period": "9/12 ~ 9/18",
// 			            	"open"	: "9/12 10시오픈",
			            	"cls"	: "stripe soon912"
			            },
			            {
			            	"period": "9/19 ~ 9/21",
// 			            	"open"	: "9/19 10시오픈",
			            	"cls"	: "stripe soon919"
			            }
			            ],
			sell: []
		},
		created	: function() {
			// 노출 가능 상품
			var items = [];
			for (i in dealData) {
				var item = dealData[i];
				var now = YYYYMMDDHHMMSS(new Date());
				if (item.GD_VIEW_S_DTM_CVT <= now && item.GD_VIEW_E_DTM_CVT >= now) {
					items.push(item);
				}
			}
			this.items = items;

			// 판매가능
			var sell = [];
			var items = this.items;
			var now = YYYYMMDDHHMMSS(new Date());

			for (i in items) {
				var item = items[i];

				if ("N" == item.GD_SO_YN && item.GD_SAL_S_DTM_CVT > now) {	// 판매예정
					sell.push({"cls":this.htmlInfos[i].cls, "btn":"14time", "btnname":"판매예정", "YN":"N"});
				} else if ("N" == item.GD_SO_YN && item.GD_SAL_S_DTM_CVT <= now && item.GD_SAL_E_DTM_CVT >= now) {	// 구매하기
					sell.push({"cls":"", "btn":"buy", "btnname":"구매하기", "YN":"Y"});
				} else {	// 판매완료
					sell.push({"cls":"stripe sd_soldout", "btn":"soldout", "btnname":"판매완료", "YN":"N"});
				}
			}
			this.sell = sell;
		},
		mounted	: function() {
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
				lazyLoad: 'ondemand',
				centerMode: false,
				focusOnSelect: true,
				variableWidth: true
			});
            // 화살표 이전
			$('.deal_arrow .arrow.prev').on('click', function(e) {
				var index = $('.deal_slide').slick("slickCurrentSlide");
				$('.deal_slide').slick('slickPrev');

				$('.deal_nav .w_item').removeClass("slick-current");
				$('.deal_nav .w_item').eq(--index).addClass("slick-current");
			});
			// 화살표 다음
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

            for( var i = 0; i < 3; i++){
            	if($("#deal_item"+i+" .thumb em").hasClass("sd_soldout")){

            	}else{
            		$('.deal_slide').slick('slickGoTo', i, false);
            		$('.deal_nav .w_item').removeClass("slick-current");
            		$('.deal_nav .w_item').eq(i).addClass("slick-current");
            		return false;
            	}
            }
		}
	});

	// 베스트 추천 선물세트
	var bestGiftSet = new Vue({
		el		: "#bestGiftSetArea",
		data	: {
			items	: [],
			cateNos	: ["15031501","15110510","15010513","164715"],
			htmlInfos: [
			            {
			            	"id"	: "contArea2",
			            	"class"	: "prodwrap bt1",
			            	"img"	: "http://imgenuri.enuri.gscdn.com/images/event/2018/chuseok/bt_no1tit.png",
			            	"h2"	: "#농수산선물",
			            	"strong": "best 선물세트 NO1",
			            	"em"	: "농수산 선물세트로 가족,지인들에게 사랑과 감사의 마음을 전해보세요"
			            },
			            {
			            	"id"	: "contArea5",
			            	"class"	: "prodwrap bt2",
			            	"img"	: "http://imgenuri.enuri.gscdn.com/images/event/2018/chuseok/bt_no2tit.png",
			            	"h2"	: "#가공,생활선물",
			            	"strong": "best 선물세트 NO2",
			            	"em"	: "가공,생활선물세트로 실용성도 챙기고 사랑도 가득담아 선물해보세요!"
			            },
			            {
			            	"id"	: "contArea6",
			            	"class"	: "prodwrap bt3",
			            	"img"	: "http://imgenuri.enuri.gscdn.com/images/event/2018/chuseok/bt_no3tit.png",
			            	"h2"	: "#건강선물",
			            	"strong": "best 선물세트 NO3",
			            	"em"	: "매년 명절때면 건강선물세트가 추석선물로 인기만점"
			            },
			            {
			            	"id"	: "contArea7",
			            	"class"	: "prodwrap bt4",
			            	"img"	: "http://imgenuri.enuri.gscdn.com/images/event/2018/chuseok/bt_no4tit.png",
			            	"h2"	: "#상품권",
			            	"strong": "best 선물세트 NO4",
			            	"em"	: "선물선택이 고민된다면 안성맞춤 고마운 마음을 담아 선물해보세요!"
			            }
			            ]
		},
		created : function() {
			this.items = [ ajaxData.GOODS[0], ajaxData.GOODS[1], ajaxData.GOODS[2], ajaxData.GOODS[3] ];
		},
		mounted	: function() {
			// 베스트 선물세트
			$('.dw_detail').slick({
				dots:true,
				lazyLoad: 'ondemand',
				slidesToShow: 1,
				slidesToScroll: 1,
				autoplay: true,
				autoplaySpeed: 3000
			});
		},
		methods : {
			//상품더보기
			moreItem : function(param) {
				window.open("/mobilefirst/list.jsp?freetoken=llist&cate=" + this.cateNos[param]);
			}
		}
	});

	// 가격대별 추석선물
	var giftAtPrice = new Vue({
		el		: "#contArea3",
		data	: {
			items	: [],
			cateNos	: ["15050724", "15070805", "15020323", "15031501"],
			htmlInfos: [
 			            {
			            	"id"	: "tab1",
			            	"class"	: "t1",
			            	"title"	: "1만원 미만"
			            },
			            {
			            	"id"	: "tab2",
			            	"class"	: "t2",
			            	"title"	: "1~5만원"
			            },
			            {
			            	"id"	: "tab3",
			            	"class"	: "t3",
			            	"title"	: "5~10만원"
			            },
			            {
			            	"id"	: "tab4",
			            	"class"	: "t4",
			            	"title"	: "10만원 이상"
			            }
			            ],
			condition: [
			             {"min":"0", "max":"10000"},
			             {"min":"10000", "max":"50000"},
			             {"min":"50000", "max":"100000"},
			             {"min":"100000", "max":""}
			            ]
		},
		created	: function() {
			var obj = ajaxData.GOODS[4].sort(function(a, b) { return a.MINPRICE3 - b.MINPRICE3; });
			var cond = this.condition;
			var items = [];
			for (i in cond) {		// 가격조건별 배열 생성
				items.push([]);
			}

			for (index in obj) {
				var minprice3 = 0;
				if (obj[index].MINPRICE3 != null && isNaN(obj[index].MINPRICE3)) {	// MINPRICE3이 숫자가 아니면
					continue;
				} else {
					minprice3 = Number(obj[index].MINPRICE3);
				}

				for (i in cond) {	// 가격조건별
					if (items[i].length >= 8) {	// 상품개수 8개 제한
						continue;
					}
					if ("" != cond[i].min && Number(cond[i].min <= minprice3)) {	// 가격 이상
						if ( ("" != cond[i].max && Number(cond[i].max) > minprice3) || "" == cond[i].max) {	// 가격 미만
							items[i].push(obj[index]);
						}
					}
				}
			}

			this.items = items;
		},
		methods : {
			//상품더보기
			moreItem : function(param) {
				window.open("/mobilefirst/list.jsp?freetoken=llist&cate=" + this.cateNos[param]);
			}
		}
	});

	// 추석연휴 대표상품
	var repProduct = new Vue({
		el		: "#contArea4",
		data	: {
			items	: [],
			cateNos	: ["164716", "040823", "16471824", "164705"],
			htmlInfos: [
			            {
			            	"id"	: "tab5",
			            	"class"	: "t1",
			            	"title"	: "외식"
			            },
			            {
			            	"id"	: "tab6",
			            	"class"	: "t2",
			            	"title"	: "게임기"
			            },
			            {
			            	"id"	: "tab7",
			            	"class"	: "t3",
			            	"title"	: "1인가구"
			            },
			            {
			            	"id"	: "tab8",
			            	"class"	: "t4",
			            	"title"	: "E쿠폰"
			            }
			            ]
		},
		created	: function() {
			this.items = [ ajaxData.GOODS[5], ajaxData.GOODS[6], ajaxData.GOODS[7], ajaxData.GOODS[8] ];
		},
		methods : {
			//상품더보기
			moreItem : function(param) {
				window.open("/mobilefirst/list.jsp?freetoken=llist&cate=" + this.cateNos[param]);
			}
		}
	});

	//로그인시 개인화영역
	if(islogin()){
		$("#user_id").text("<%=cUserId%>");
		getPoint();//개인e머니 내역 노출
	}

	function gaCall() {
		var gaLabel = [
						'전체PV',
						'무빙탭 추석딜',
						'무빙탭 이벤트',
						'무빙탭 BEST선물',
						'무빙탭 가격대별',
						'무빙탭 추석연휴',
						'딜 상품클릭',
						'딜 썸네일',
						'BEST_농수산 상품클릭',
						'BEST_가공 상품클릭',
						'BEST_건강 상품클릭',
						'BEST_상품권 상품클릭',
						'가격대별_탭_1만원미만',
						'가격대별_탭_1-5만원',
						'가격대별_탭_5-10만원',
						'가격대별_탭_10만원이상',
						'가격대별_상품클릭',
						'추석연휴_탭_외식',
						'추석연휴_탭_게임기',
						'추석연휴_탭_1인가구',
						'추석연휴_탭_e쿠폰',
						'추석연휴_상품클릭',
						'CM기획전',
						'에누리혜택'
						];
		var vEvent_title = "한가위기획전";

		function innerCall (param) {
			if ( param == 1 ) {
				ga('send', 'pageview', {'page': vEvent_page,'title': vEvent_title + " > " + "PV"});
			} else {
				ga('send', 'event', 'mf_event', vEvent_title, vEvent_title + " > " + gaLabel[param-1]);
			}
		}
		return innerCall;
	}
});

function YYYYMMDDHHMMSS(today) {
	return	today.getFullYear() + pad2(today.getMonth() + 1) + pad2(today.getDate())
			+ pad2(today.getHours()) + pad2(today.getMinutes()) + pad2(today.getSeconds());
	function pad2(n) { return (n < 10 ? '0' : '') + n; }
}

window.onload = function(){
	//PV
	if("<%=flow%>" == "ad") {
		ga('send', 'pageview', {'page': vEvent_page,'title': " 2018 한가위기획전 > DA용 PV"});
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
};
function itemClick(modelNo, minprice) {
	if(minprice > 0){
		window.open('/mobilefirst/detail.jsp?modelno=' + modelNo +'&freetoken=vip');
	}else{
		alert("품절된 상품 입니다.");
	}
}

//추석딜
function chuseokDeal(seq) {
	if (islogin()) {
		$.ajax({
			type	: "GET",
			url		: "/eventPlanZone/ajax/getExhdealUrl.jsp",
			data	: { "seq" : seq, "osTpCd" : getOsType() },
			dataType: "JSON",
			async	: false,
			success	: function(result) {
				if (result.soldoutYN == "Y") {
					alert("품절 되었습니다.");
					location.reload();
				} else if (result.moveUrl != "") {
					window.open(result.moveUrl);
					$.getJSON("/eventPlanZone/ajax/ctuExhDeal.jsp", {"goods_seq":seq , "shop_code":"55"}, function(data) {});
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
		goLogin();
		return false;
	}
}

$(window).load(function() {
	var tab = "<%=tab%>";
	switch (tab) {
	case "contArea2":	//best 선물세트 NO1
		$('html, body').stop().animate({scrollTop:Math.ceil($('#contArea2').offset().top)-60-31}, 500);
		break;
	case "contArea5":	//best 선물세트 NO2
		$('html, body').stop().animate({scrollTop:Math.ceil($('#contArea5').offset().top)}, 500);
		break;
	case "contArea6":	//best 선물세트 NO3
		$('html, body').stop().animate({scrollTop:Math.ceil($('#contArea6').offset().top)}, 500);
		break;
	case "contArea7":	//best 선물세트 NO4
		$('html, body').stop().animate({scrollTop:Math.ceil($('#contArea7').offset().top)}, 500);
		break;
	}
});
</script>

<%-- 퍼블 --%>
<script>
	//가격대별 리스트
	$(document).ready(function() {
		$(".conts_gift1 .tab_content").hide();
		$(".conts_gift1 ul.tabs li:first").addClass("active").show();
		$(".conts_gift1 .tab_content:first").show();
		$(".conts_gift1 ul.tabs li").click(function() {
			$(".conts_gift1 ul.tabs li").removeClass("active");
			$(this).addClass("active");
			$(".conts_gift1 .tab_content").hide();
			var activeTab = $(this).find("a").attr("href");
			$(activeTab).fadeIn();
			return false;
		});

		$(".conts_gift2 .tab_content").hide();
		$(".conts_gift2 ul.tabs li:first").addClass("active").show();
		$(".conts_gift2 .tab_content:first").show();
		$(".conts_gift2 ul.tabs li").click(function() {
			$(".conts_gift2 ul.tabs li").removeClass("active");
			$(this).addClass("active");
			$(".conts_gift2 .tab_content").hide();
			var activeTab = $(this).find("a").attr("href");
			$(activeTab).fadeIn();
			return false;
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

	$(".rd_banner a.total").click(function(){
			$(".wrap a.win_close").css("display", "none");
	});

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
</script>
</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
