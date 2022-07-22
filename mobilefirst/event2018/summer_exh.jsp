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
	response.sendRedirect("http://www.enuri.com/event2018/summer_exh.jsp");
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
String strFb_description = "무더위 통합기획전";
String strFb_img = ConfigManager.IMG_ENURI_COM+"/images/mobilenew/images/enuri_logo_facebook200.gif";
String tab = ChkNull.chkStr(request.getParameter("tab"));
String flow = ChkNull.chkStr(request.getParameter("flow"));
String evtUrl = "/mobilefirst/evt/summer_2018.jsp?freetoken=event";
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
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/summer_m.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
</head>
<body>


	<div class="wrap">
		<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>
		<!-- 상단비주얼 -->
		<div class="visual">
			<ul class="tab__list">
				<li><a href="javascript:ga_log(2);location.reload();" class="tab1"><i>기획전 : 여름필수템</i></a></li>
				<li><a href="javascript:ga_log(3);window.open('<%=evtUrl %>');" class="tab2"><i>이벤트 : 아이스크림 먹자</i></a></li>
			</ul>
			<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/summer/m_visual.png" alt="[여름생활백서!] 완벽한 여름을 보내기 위한 생활백서" class="imgs" />
		</div>
		<!-- floattab__list -->
		<div  class="floattab__list">
			<div class="scrollList">
				<ul class="floatmove">
					<li><a href="#evt1" class="floattab__item floattab__item--01 is-on"><em>여름필수템</em></a></li>
					<li><a href="#evt2" class="floattab__item floattab__item--02"><em>이벤트</em></a></li>
					<li><a href="#evt3" class="floattab__item floattab__item--03"><em>냉방제습</em></a></li>
					<li><a href="#evt4" class="floattab__item floattab__item--04"><em>여행용품</em></a></li>
					<li><a href="#evt5" class="floattab__item floattab__item--05"><em>다이어트</em></a></li>
					<li><a href="#evt6" class="floattab__item floattab__item--06"><em>레저용품</em></a></li>
					<li><a href="#evt7" class="floattab__item floattab__item--07"><em>여름패션</em></a></li>
					<li><a href="#evt8" class="floattab__item floattab__item--08"><em>리빙용품</em></a></li>
				</ul>
			</div>
			<a href="javascript:///" class="btn_tabmove"><em>탭 이동</em></a>
		</div>
		<!-- //floattab__list -->
		<script type="text/javascript">
			$(".floatmove > li").click(function(e){
				ga_log(4 + $(this).index());
			});
		</script>
		<!-- 여름 필수템 PICK -->
		<div id="evt1" class="banner_pick">
			<div class="contents">
				<h2># 여름필수 PICK 상품</h2>
				<span class="swim1"></span><span class="swim2"></span>
				<span class="swim4"></span>
				
				<!-- dw_wrap -->
				<div class="dw_wrap">
					<div id="dwSlide" class="dw_detail">
						<div class="d_item" v-for = "(item, index) in items" v-on:click = "ga_log(12); itemClick(item.MODELNO, item.MINPRICE3)">
							<div class="_photo">
								<div class="fade_list">
									<a href="javascript:///">
										<template v-if="item.GOODS_IMG">
											<img v-bind:data-lazy= "item.GOODS_IMG" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png"  alt="" />
										</template>
										<template v-else>
											<img v-bind:data-lazy= "item.IMG_SRC" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png"  alt="" />
										</template>
										<template v-if="item.MINPRICE3 == 0">
											<span class="soldout">SOLD OUT</span>
			                            </template>
										<div class="pro_info">
											<span class="title">{{ item.TITLE1 }} <br>{{item.TITLE2}}</span>
											<span class="discount">최저가 <b>{{commaNum(item.MINPRICE3) }}</b>원</span>
										</div>
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- //dw_wrap -->
	
			</div>
		</div>
		<!-- //여름 필수템 PICK -->
		
		<div id="evt2" >
			<a href="javascript:///" class="ban_prize pr1" title="프로모션 새창 이동" onclick = "ga_log(13);window.open('<%=evtUrl %>&tapType=evt2');">
				<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/summer/m_banprize1.png" class="imgs" alt="APP에서 상품 구매할 시 설빙 팥빙수 추첨 증정" />
			</a>
		</div>
		
		<span id = "middleArea" >
			<template v-for = "n in 6">
			<!-- 탭 컨텐츠 / 냉방제습 -->
			<div v-bind:id="htmlInfos[n-1].id" v-bind:class="htmlInfos[n-1].class" >
				<h2><em>{{htmlInfos[n-1].title}}</em></h2>
				
				<ul class="itemlist">
					<li v-for = "(item, index) in items[n-1]"  v-if = "index < 8" v-on:click = "ga_log(n * 2 + 12); itemClick(item.MODELNO, item.MINPRICE3)">
						<a href="javascript:///"  title="새 탭에서 열립니다." class="btn">
							<div class="imgs">
								<template v-if="item.GOODS_IMG">
									<img v-lazy= "item.GOODS_IMG"  alt="" />
								</template>
								<template v-else>
									<img v-lazy= "item.IMG_SRC"   alt="" />
								</template>
								<template v-if="item.MINPRICE3 == 0">
									<span class="soldout">SOLD OUT</span>
	                            </template>
							</div>
							<div class="info">
								<p class="pname">{{ item.TITLE1 }} <br>{{item.TITLE2}}</p>
								<p class="price"><span class="lowst">최저가</span><b>{{commaNum(item.MINPRICE3) }}</b>원</p>
							</div>
						</a>
					</li>
				</ul>
				<p class="moreview"><a href="javascript:///" class="btn_promore" v-on:click="ga_log(n * 2 + 13); moreItem(n-1)">상품 더보기</a></p>
			</div>
			<!-- //탭 컨텐츠 / 냉방제습 -->
			<a v-if = "n==3"  href="javascript:///" class="ban_prize pr2" title="프로모션 새창 이동" onclick = "ga_log(26);window.open('<%=evtUrl %>&tapType=evt1');">
				<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/summer/m_banprize2.png" class="imgs" alt="매일매일 이벤트 참여할 시 베스킨라빈스 싱글콘 증정!" />
			</a>
			</template>
		</span>
		<!-- 기획전 배너 -->
		<div class="rd_banner">
			<div class="contents">
				<span class="fish1"></span>
				<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/summer/m_recomzone_tit.png" alt="에누리 여름 기획전" /></h2>
				<ul class="evtbnr" id ="recPlanlist1">
					<li><a href="javascript:///"><img src="http://imgenuri.enuri.gscdn.com//images/event/2018/summer/rec_planlist1.png" alt=""  /></a></li>
					<li><a href="javascript:///"><img src="http://imgenuri.enuri.gscdn.com//images/event/2018/summer/rec_planlist2.png" alt=""  /></a></li>
					<li><a href="javascript:///"><img src="http://imgenuri.enuri.gscdn.com//images/event/2018/summer/rec_planlist3.png" alt=""  /></a></li>
					<li><a href="javascript:///"><img src="http://imgenuri.enuri.gscdn.com//images/event/2018/summer/rec_planlist4.png" alt=""  /></a></li>
					<li><a href="javascript:///"><img src="http://imgenuri.enuri.gscdn.com//images/event/2018/summer/rec_planlist6.png" alt=""  /></a></li>
					<li><a href="javascript:///"><img src="http://imgenuri.enuri.gscdn.com//images/event/2018/summer/rec_planlist7.png" alt=""  /></a></li>
				</ul>
				<a href="javascript:///" class="total" onclick="onoff('layer_planlist')">전체+</a>
				<span class="fish2"></span>
			</div>
		</div>
		<!--// 기획전 배너 -->
		
		<!-- 기획전 스프레드 레이어 -->
		<div class="dim" id="layer_planlist" style="display: none;">
			<div class="planlist_view">
				<h2>추천기획전<a href="javascript:///" class="close" onclick="onoff('layer_planlist')">창닫기</a></h2>
				<div class="inner" style="height:500px;">
					<ul id ="recPlanlist2">
						<li><img src="http://imgenuri.enuri.gscdn.com//images/event/2018/summer/rec_planlist1.png" alt=""  /></li>
						<li><img src="http://imgenuri.enuri.gscdn.com//images/event/2018/summer/rec_planlist2.png" alt=""  /></li>
						<li><img src="http://imgenuri.enuri.gscdn.com//images/event/2018/summer/rec_planlist3.png" alt=""  /></li>
						<li><img src="http://imgenuri.enuri.gscdn.com//images/event/2018/summer/rec_planlist4.png" alt=""  /></li>
						<li><img src="http://imgenuri.enuri.gscdn.com//images/event/2018/summer/rec_planlist6.png" alt=""  /></li>
						<li><img src="http://imgenuri.enuri.gscdn.com//images/event/2018/summer/rec_planlist7.png" alt=""  /></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- //기획전 스프레드 레이어 -->
		<script type="text/javascript">
			$("#recPlanlist1, #recPlanlist2").find("li").click(function(e){
				ga_log(27);
				var exhNo = [
					"20180320130900","20180330120325","20180508090900","20180516051705","20180412153152","20180413101010"
				];
				var idx = e.currentTarget.className.indexOf("slick") > -1 ? $(this).index()-1 : $(this).index();
				window.open("/mobilefirst/planlist.jsp?t=B_"+exhNo[idx] + "&freetoken=planlist");
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
		</script>
		
		<!-- 하단 상품 리스트 -->
		<div class="btitem_list">
			<h2 class="blind">하단 상품</h2>
			
			<!-- quick1 liveProduct -->
			
			<span id = "bottomArea" >
				<div id="quick1" class="liveProduct" v-for = "n in 4">
					<h3>{{titles[n-1]}}
						<ul class="pp_tabs">
							<li v-for = "(item,index) in keyword[n-1]">
								<a href="javascript:///" class="tab1" v-on:click="ga_log(3 * n + 25); window.open(item.M_URL); ">{{item.KEYWORD}}</a>
							</li>
						</ul>
					</h3>
					<!-- tab_container -->
					<div class="tab_container">
						<!-- tab1 -->
						<div id="tab1" class="tab_content">
							<div class="lp_tabs_cont">
								<!-- items_area -->
								<div class="items_area">
									<!-- itembox -->
									<div class="itembox"  v-for = "k in maxSize[n-1]">
										<ul class="itemlist">
											<li v-for = "(item, index) in items[n-1]" v-if = "index >= 4 * (k-1) && index < 4 * (k-1) + 4" v-on:click="ga_log(3 * n + 26); itemClick(item.MODELNO, item.MINPRICE3);">
												<a href="javascript:///" title="새 탭에서 열립니다." class="btn">
													<div class="imgs">
														<template v-if="item.GOODS_IMG">
															<img v-bind:data-lazy= "item.GOODS_IMG" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png"  alt="" />
														</template>
														<template v-else>
															<img v-bind:data-lazy= "item.IMG_SRC" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png"  alt="" />
														</template>
														<template v-if="item.MINPRICE3 == 0">
															<span class="soldout">SOLD OUT</span>
							                            </template>
													</div>
													<div class="info">
														<p class="pname">{{ item.TITLE1 }} <br>{{item.TITLE2}}</p>
														<p class="price"><span class="lowst">최저가</span><b>{{commaNum(item.MINPRICE3) }}</b>원</p>
													</div>
												</a>
											</li>
										</ul>
									</div>
									<!-- //itembox -->
								</div>
								<!-- //items_area -->
							</div>
							<p class="moreview"><a href="javascript:///" class="btn_promore" v-on:click = 'ga_log(3 * n + 27); moreItem(n-1);'>상품 더보기</a></p>
						</div>
						<!-- //tab1 -->
					</div>
					<!-- //tab_container -->
				</div>
				<!-- //quick1 liveProduct -->
			</span>
			
		</div>
		<!-- //하단 상품 리스트 -->
		<!-- 에누리 혜택 -->
		<%@include file="/eventPlanZone/jsp/eventBannerTapMobile_201806.jsp"%>
		<!-- //에누리 혜택 -->
		<script type="text/javascript">
			$(".banlist > li").click(function(){
				ga_log(40);
			});
		</script>
	</div>
	<!-- layer--> 
	<div class="layer_back" id="app_only" style="display:none;">
		<div class="appLayer">
			<h4>모바일 앱 전용 이벤트</h4>
			<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
			<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
			<p class="btn_close"><button type="button" nclick="install_btt();">설치하기</button></p>
		</div>
	</div>
	<span class="go_top"><a onclick="$(window).scrollTop(0);">TOP</a></span>


<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script type="text/javascript" src="/mobilefirst/js/lib/vue.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/vue-lazyload.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20180614"></script>
<script>
	//플로팅 상단 탭 이동
	$(document).on('click', '.floattab__list .floatmove a', function(e) {
		var $anchor = Math.ceil($($(this).attr('href')).offset().top);
			$navHgt = Math.ceil($(".floattab__list").height() - 30);
		
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
			$ares8 = $("#evt8").offset().top - $nav.outerHeight();

		// 상단 탭 position 변경 및 버튼 활성화
		$(window).scroll(function(){
			var $currY = $(this).scrollTop() + $myHgt // 현재 scroll

			if ($currY > $navTop) {
				$nav.addClass("is-fixed");
				//$("#evt1").css("margin-top", $nav.outerHeight());

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
					$(".scrollList").scrollLeft(300);
				}else if($ares5 <= $currY && $ares6 > $currY){
					$nav.find("a").removeClass("is-on");
					$(".floattab__item--05").addClass("is-on");
					$(".scrollList").scrollLeft(300);
				}else if($ares6 <= $currY && $ares7 > $currY){
					$nav.find("a").removeClass("is-on");
					$(".floattab__item--06").addClass("is-on");
					$(".scrollList").scrollLeft(300);
				}else if($ares7 <= $currY && $ares8 > $currY){
					$nav.find("a").removeClass("is-on");
					$(".floattab__item--07").addClass("is-on");
					$(".scrollList").scrollLeft(300);
				}else if($ares8 <= $currY){
					$nav.find("a").removeClass("is-on");
					$(".floattab__item--08").addClass("is-on");
					$(".scrollList").scrollLeft(300);
				}

			} else {
				$nav.removeClass("is-fixed"),
				$("#evt1").css("margin-top", 0);
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


	$(".rd_banner a.total").click(function(){
			$(".wrap a.win_close").css("display", "none");
	});
	

</script>

<script type="text/javascript">
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로

var ga_log;

$(document).ready(function(){
	ga_log = gaCall();
	var tab = "<%=tab%>";
	var anchorNm = "";

	var ajaxUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=16";
	if(location.host.indexOf("my.enuri.com") > -1) {
		ajaxUrl = "/mobilefirst/http/json/test.json";
	}
	//전체 상품 데이터
	var	ajaxData = (function() {
	    var goodsArray = [];
	    var tagArray = [];
	    var json = {};
	    
	    $.ajax({
	        'async': false,
	        'global': false,
	        'url': ajaxUrl,
	        'dataType': "json",
	        'success': function (data) {
		    	var Tdata = data.T;
				$.each(Tdata, function(i,v){
					goodsArray.push(v.GOODS);
					tagArray.push(v.TAGS);
				});
				json.GOODS = goodsArray;
				json.TAGS = tagArray;
	        }
	    });
	    return json;
	})();
	
	//https://github.com/hilongjw/vue-lazyload
	Vue.use(VueLazyload, {
		preLoad	: 3,
		attempt: 1
	});

	//대표상품
	var represent = new Vue ({
		el : "#evt1",
		data : {
			items : [],
		},
		created : function() {
			this.items = ajaxData.GOODS[0];
		},
		mounted : function() {
			//여름 필수템 pick 플리킹
			$('#dwSlide').slick({
				dots:true,
				lazyLoad: 'ondemand',
				slidesToShow: 1,
				slidesToScroll: 1,
				autoplay: true,
				autoplaySpeed: 3000
			});
		}
	});
	// 중간상품
	var middle = new Vue ({
		el : "#middleArea",
		data : {
			items : [],
			cateNos : ['2401', '145796','151401', '0939', '14360606', '120856'],
			htmlInfos : [
				{
					"id" : "evt3",
					"class" : "giftWrap pro1",
					"title" : "북극보다 더 시원하게! 우리집 필수템 #냉방제습"
				},
				{
					"id" : "evt4",
					"class" : "giftWrap pro2 ty2",
					"title" : "열심히 일한 당신~떠나라! #여행용품"
				},
				{
					"id" : "evt5",
					"class" : "giftWrap pro3",
					"title" : "숨겨왔던 나의 인격, 이젠 안녕~ #다이어트"
				},
				{
					"id" : "evt6",
					"class" : "giftWrap pro4",
					"title" : "무더운 여름을 200% 즐기기 #레저용품"
				},
				{
					"id" : "evt7",
					"class" : "giftWrap pro5 ty2",
					"title" : "열심히 일한 당신~떠나라! #여름패션"
				},
				{
					"id" : "evt8",
					"class" : "giftWrap pro6",
					"title" : "숨겨왔던 나의 인격, 이젠 안녕~ #리빙용품"
				},
			]
			
		},
		created : function() {
			this.items = [ajaxData.GOODS[1],ajaxData.GOODS[2],ajaxData.GOODS[3],ajaxData.GOODS[4],ajaxData.GOODS[5],ajaxData.GOODS[6]];
		},
		methods : {
			//상품더보기
			moreItem : function(param) {
				window.open("/mobilefirst/list.jsp?freetoken=llist&cate=" + this.cateNos[param]);
			}
		}
	});

	// 하단상품
	var bottom = new Vue ({
		el : "#bottomArea",
		data : {
			items : [],
			maxSize : [],
			cateNos : ['0909', '150819', '211417', '14590606'],
			titles : ["수영복","아이스크림,빙수","차량용품","모자,선글라스"],
			keyword : []
		},
		created : function() {
			var that =this;
			that.items = [ajaxData.GOODS[7],ajaxData.GOODS[8],ajaxData.GOODS[9],ajaxData.GOODS[10]];
			that.keyword = [ajaxData.TAGS[7],ajaxData.TAGS[8],ajaxData.TAGS[9],ajaxData.TAGS[10]];
			$.each(that.items, function(i,v){
				that.maxSize.push(Math.floor((v.length-1)/4) + 1);
			});
		},
		mounted : function() {
			//하단상품 리스트 플리킹
			$('.btitem_list .items_area').slick({
				dots:true,
				slidesToScroll: 1
			});
		},
		methods : {
			//상품더보기
			moreItem : function(param) {
				window.open("/mobilefirst/list.jsp?freetoken=llist&cate=" + this.cateNos[param]);
			}
		}
	});
	switch (tab) {
		case "living":
			location.href = "#evt8";
			break;
		case "leisure":
			location.href = "#evt6";
			break;
		case "diet":
			location.href = "#evt5";
			break;
		case "travel":
			location.href = "#evt4";
			break;
		case "appliance":
			location.href = "#evt3";
			break;
		case "fashion":
			location.href = "#evt7";
			break;
		}
	
	//로그인시 개인화영역
	if(islogin()){
		$("#user_id").text("<%=cUserId%>");
		getPoint();//개인e머니 내역 노출
	}

	function gaCall () {
		var gaLabel = [
			'전체PV',
			'상단탭_기획전',
			'상단탭_이벤트 ',
			'앵커탭_여름필수템',
			'앵커탭_이벤트',
			'앵커탭_냉방제습',
			'앵커탭_여행용품',
			'앵커탭_다이어트',
			'앵커탭_레저용품',
			'앵커탭_여름패션',
			'앵커탭_리빙용품',
			'여름필수템_대표상품',
			'이벤트_1',
			'중단_냉방제습대표상품',
			'중단_냉방제습상품더보기',
			'중단_여행용품대표상품',
			'중단_여행용품상품더보기',
			'중단_다이어트대표상품',
			'중단_다이어트상품더보기',
			'중단_레저용품대표상품',
			'중단_레저용품상품더보기',
			'중단_여름패션대표상품',
			'중단_여름패션상품더보기',
			'중단_리빙용품대표상품',
			'중단_리빙용품상품더보기',
			'이벤트_2',
			'CM기획전',
			'하단상품_수영복_해시태그',
			'하단상품_수영복_대표상품',
			'하단상품_수영복_상품더보기',
			'하단상품_아이스크림_해시태그',
			'하단상품_아이스크림_대표상품 ',
			'하단상품_아이스크림_상품더보기',
			'하단상품_차량용품_해시태그',
			'하단상품_차량용품_대표상품',
			'하단상품_차량용품_상품더보기',
			'하단상품_모자_해시태그',
			'하단상품_모자_대표상품',
			'하단상품_모자_상품더보기 ',
			'하단상품_혜택배너'
		];
		var vEvent_title = "무더위 여름통합기획전";

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


window.onload = function(){
	//PV
	if("<%=flow%>" == "ad") {
		ga('send', 'pageview', {'page': vEvent_page,'title': " 무더위 여름통합기획전 > DA용 PV"});
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
</script>
</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>