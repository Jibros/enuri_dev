<%@ page contentType="text/html;charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>

<%
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
	response.sendRedirect("http://www.enuri.com/mobilefirst/evt/summer_2018.jsp");
}

String chkId   = ChkNull.chkStr(request.getParameter("chk_id"),"");
String cUserId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK"),"");

String tapType   = ChkNull.chkStr(request.getParameter("tapType"),"");

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
String strFb_description = "2018 무더위 프로모션";
String strFb_img = ConfigManager.IMG_ENURI_COM+"/images/mobilenew/images/enuri_logo_facebook200.gif";
String tab = ChkNull.chkStr(request.getParameter("tab"));
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
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/summer_pro_m.css?v=20180625"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
	<script type="text/javascript" src="/common/js/function.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
</head>
<body>

	<div class="myarea">
        <p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>
		<a href="javascript:///" class="win_close">창닫기</a>
	</div>

	<div class="wrap">
		<!-- visual -->
		<div class=" visual">
			<div class="sns">
				<span class="sns_share evt_ico" onclick="onoff('snslayer')">sns 공유하기</span>
				<ul id="snslayer" style="display:none;">
					<li>페이스북</li>
					<li>카카오톡</li>
				</ul>
			</div>
			<h1 class="imgbox"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/summer_pro/m_visual_main.png" alt="스-윗 summer" /></h1>
			<div id="neon_ice" class="neon_ice"></div>
			<a href="/mobilefirst/event2018/summer_exh.jsp" onclick="ga_log(2);" class="btn_summerdeal" target="_blank"><span class="shadow"></span></a>
		</div>
		<!-- //visual -->

		<!-- floattab__list -->
		<div class="floattab">
			<div class="contents">
				<div class="floattab__list">
					<ul>
						<li><a href="#evt1" onclick="ga_log(3);" class="movetab floattab__item floattab__item--01">매일 아이스크림 먹고 하나 더~ 받자</a></li>
						<li><a href="#evt2" onclick="ga_log(4);" class="movetab floattab__item floattab__item--02">앱에서 구매하고 팥빙수 먹자</a></li>
					</ul>
				</div>
			</div>	
		</div>
		<!-- //floattab__list -->
		
		<!-- 이벤트 01 -->
		<div class="evt1_contents scroll">
			<div class="contents">
				<div id="evt1" class="evt1__anchor"><p class="blind">이벤트 1 앵커 영역</p></div>
				<div class="evt1_area">
					<div class="evt1_tit">
						<div class="blind">
							<h3>아이스크림 먹고 하나 더~ 나오면 진짜 아이스크림 드림!</h3>
							<strong>배스킨라빈스 싱글레귤러 e2800</strong>
							<em>아이스크림을 골라주세요</em>
						</div>
					</div>
					<div class="frame">
						<ul>
							<!-- default 선택 없음. -->
							<li><button type="button" data-fruit="watermelon" class="btn_choice fl_item_01">수박아이스크림</button></li>
							<li><button type="button" data-fruit="melona" class="btn_choice fl_item_02">메론아이스크림</button></li>
							<li><button type="button" data-fruit="choco" class="btn_choice fl_item_03">초코아이스크림</button></li>
						</ul>
						
						<div id="startSelect" class="start_btnarea">
							<button type="button" class="startSelect">선택</button>
						</div>

						<!--아이스크림 선택 결과 화면 -->
						<div id="watermelon" class="choice_group">
							<!-- default 노출 -->
							<div class="choice_item watermelon-ice1" style="display:block;"></div>
							<div class="choice_item watermelon-ice2"></div>
							<div class="choice_item watermelon-ice3"></div>
						</div>
						
						<div id="melona" class="choice_group">
							<div class="choice_item melona-ice1"></div>
							<div class="choice_item melona-ice2"></div>
							<div class="choice_item melona-ice3"></div>
						</div>
						
						<div id="choco" class="choice_group">
							<div class="choice_item choco-ice1"></div>
							<div class="choice_item choco-ice2"></div>
							<div class="choice_item choco-ice3"></div>
						</div>
						
						<div class="choice_item cong"></div>
						<div class="choice_item fail"></div>
						<!--//아이스크림 선택 결과 화면 -->
					</div>
					<a class="btn_caution" onclick="onoff('notetxt1'); return false;">꼭!확인하세요</a>	
				</div>
			</div>
		</div>
		<!-- //이벤트 01 -->

		<!-- 추천 상품 영역 -->
		<div class="pro_itemlist">
			<div class="pro_tit">
				<div class="blind">
					<strong>완벽한 여름을 보내기 위한</strong>
					<h3>여름생활백서</h3>
				</div>
			</div>
			<ul id="pro_itemlist_ul"></ul>
			<div class="recomm_list" id="itemlist">
				<ul class="items clearfix"></ul>
				<a class="btn_more"  id="goods_btn_more" href="javascript:void(0);">상품더보기</a>
			</div>
		</div>
		<!-- //추천 상품 영역 -->

		<!-- 이벤트 02 -->
		<div class="evt2_contents scroll">
			<div class="contents">
				<div id="evt2" class="evt2__anchor"><p class="blind">이벤트 2 앵커 영역</p></div>
				<div class="evt2_area">
					<div class="blind">
						<strong>app에서 구매하고</strong>
						<h3>설빙 팥빙수 먹자</h3>
					</div>
					<a href="javascript:///" class="btn_appbuy" id="event2_move">기획전보러가기</a>
					<a href="javascript:///" class="btn_apply" id="event2_join">응모하기</a>
					<a href="javascript:///" class="btn_caution" onclick="onoff('notetxt2'); $(window).scrollTop(0); return false;">꼭!확인하세요</a>
					<ul class="evt_info">
						<li>
							<strong>이벤트 참여 및 구매 기간 :</strong>
							<span>2018년 6월 25일 ~ 7월 27일</span>
						</li>
						<li>
							<strong>참여 방법 :</strong>
							<span>APP > 적립대상 쇼핑몰에서 구매하고 응모하기</span>
						</li>
						<li>
							<strong>당첨자 발표 :</strong>
							<span>2018년 8월 31일 금요일 [에누리 앱 > 이벤트/기획전 > 이벤트 하단 당첨자 발표]</span>
						</li>
						<li>
							<strong>사정에 따라 경품이 변경될 수 있습니다.</strong>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<!-- //이벤트 02 -->

		<!-- 에누리 혜택 -->
		<div class="otherbene">
			<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_tit.png" alt="에누리 혜택"></h2>
			<ul class="banlist">
				<li><a href="javascript:;" onclick="window.open('/mobilefirst/evt/visit_event.jsp?tab=1&freetoken=eventclone');ga_log(16);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban1.png" alt="출석체크" /></a></li>
				<li><a href="javascript:;" onclick="window.open('/mobilefirst/evt/visit_event.jsp?tab=2&freetoken=eventclone');ga_log(16);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban2.png" alt="매일룰렛" /></a></li>
				<li><a href="javascript:;" onclick="window.open('/mobilefirst/evt/welcome_event.jsp?tab=1&freetoken=eventclone');ga_log(16);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban3.png" alt="첫구매혜택" /></a></li>
				<li><a href="javascript:;" onclick="window.open('/mobilefirst/evt/mobile_deal.jsp?freetoken=eventclone');ga_log(16);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban4.png" alt="크레이지딜" /></a></li>
				<li><a href="javascript:;" onclick="window.open('/mobilefirst/evt/office_workers.jsp?event_id=2018070109&amp;freetoken=event');ga_log(16);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban5.png" alt="직장공감" /></a></li>
				<li><a href="javascript:;" onclick="more_evt();ga_log(16);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban6.png" alt="더많은 이벤트" /></a></li>
			</ul>
		</div>
		<!-- //에누리 혜택 -->
	

	</div>
	
	<!-- 설치레이어-->
	<div class="layer_back" id="app_only" style="display:none;">
		<div class="appLayer">
			<h4>모바일 앱 전용 이벤트</h4>
			<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
			<p class="txt">
				<strong>가격비교 최초!</strong>
				<em>현금 같은 혜택</em>을 제공하는
				<br />에누리앱을 설치합니다.</p>
			<p class="btn_close">
				<button type="button" onclick="install_btt();">설치하기</button>
			</p>
		</div>
	</div>
	<!-- //설치레이어-->

	<!-- 이벤트1 유의사항 -->
	<div class="layer_back" id="notetxt1" style="display:none;">
		<div class="dim"></div>
		<div class="noteLayer">
			<h4>유의사항</h4>
			<a href="javascript:///" class="close" onclick="onoff('notetxt1');return false;">창닫기</a>

			<div class="inner">
				<ul class="txtlist">
					<li>ID당 1일 1회 참여 가능</li>
					<li>이벤트 경품: 배스킨라빈스 싱글레귤러 (e2,800점), e5점</li>
					<li>적립된 e머니는 e머니 스토어에서 다양한 e쿠폰상품으로 교환 가능합니다.</li>
					<li>
						<strong class="emp">e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</strong>
					</li>
					<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
				</ul>
			</div>
			<p class="btn_close">
				<button type="button" onclick="onoff('notetxt1');return false;">닫기</button>
			</p>
		</div>
	</div>
	<!-- //이벤트1 유의사항 -->

	<!-- 이벤트2 유의사항 상단에서 열림 -->
	<div class="layer_back nofix" id="notetxt2" style="display:none;">
		<div class="dim"></div>
		<div class="noteLayer no_fixed">
			<h4>유의사항</h4>
			<a href="javascript:///" class="close" onclick="onoff('notetxt2');return false;">창닫기</a>

			<div class="inner">
				<dl class="txtlist">
					<dt>이벤트/구매 기간 :</dt>
					<dd>2018년 6월 25일 ~ 7월 27일</dd>
				</dl>

				<dl class="txtlist">
					<dt>경품 : </dt>
					<dd>설빙 팥인절미 빙수 – e머니 7,900점 (100명 추첨)</dd>
					<dd>
						<strong class="emp">e머니 유효기간 : 적립일로부터 15일</strong>
					</dd>
					<dd> 사정에 따라 경품이 변경될 수 있습니다.</dd>
				</dl>

				<dl class="txtlist">
					<dt>당첨자 발표 및 적립</dt>
					<dd>2018년 8월 31일 [APP 이벤트/기획전 탭 &lt; 이벤트 &lt; 당첨자 발표]</dd>
				</dl>

				<dl class="txtlist">
					<dt>구매방법 및 유의사항</dt>
					<dd>에누리 가격비교 앱 로그인 → 적립대상 쇼핑몰 이동 → 구매하기</dd>
					<dd>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품 결제금액만 반영</dd>
					<dd>적립 e머니는 카테고리에 따라 차등 적립</dd>
				</dl>
				
				<dl class="txtlist">
					<dt>아래의 경우에는 구매 확인 및 적립이 불가합니다.</dt>
					<dd>에누리 가격비교 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱으로 결제만 한 경우
						<br />(에누리 가격비교 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)</dd>
					<dd>에누리 가격비교 앱 미 로그인 후 구매한 경우 또는 에누리 가격비교 PC, 모바일 웹에서 구매한 경우</dd>
				</dl>

				<dl class="txtlist">		
					<dt>유의사항</dt>
					<dd>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</dd>
				</dl>
			</div>
			<p class="btn_close">
				<button type="button" onclick="onoff('notetxt2');return false;">닫기</button>
			</p>
		</div>
	</div>
	<!-- //이벤트2 유의사항 상단에서 열림 -->

	<!-- 당첨 레이어 -->
	<div id="prizes" class="layer_back" style="display:none;">
		<div class="dim"></div>
		<!-- 당첨 박스 -->
		<div class="vote_box">
			<div class="inner">
				<!-- 아이스크림 당첨 -->
				<img class="vote_img" src="http://imgenuri.enuri.gscdn.com/images/event/2018/summer_pro/prize1.jpg" />
				<div class="layer_info"></div>

				<button type="button" class="btn layclose" onclick="$('#prizes').fadeOut(150);">
					<em>팝업 닫기</em>
				</button>
			</div>
		</div>
		<!-- //popup_box -->
	</div>
	<!-- //당첨 레이어 -->
	
	<!-- 이벤트 응모완료 레이어 --> 
	<div class="event_layer complete" id="completeJoin" style="display:none;">
		<div class="inner_layer">
			<h3 class="tit stripe_layer">응모가 완료되었습니다.</h3>
			<a href="javascript:///" class="stripe_layer close" onclick="onoff('completeJoin')">창닫기</a>
	
			<div class="viewer">
				<ul class="new_product_list" id="completeJoin_list"></ul>
			</div>
			<p class="btn_close"><button type="button" class="btn_confirm stripe_layer" onclick="onoff('completeJoin')">확인</button></p>
		</div>
	</div>
	<!-- //이벤트 응모완료 레이어 -->
	<span class="go_top"><a onclick="$(window).scrollTop(0);">TOP</a></span>

<script type="text/javascript">

</script>

<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/vue.min.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js"></script>
<script type="text/javascript">
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로
var tapType = "<%=tapType%>";

//ga_log(1) - ga_log(14)
var ga_log;

(function (global, $) {
	$(function () {
		// 해당 섹션으로 스크롤 이동 
		$menu.on('click', 'a', function (e) {
			var $target = $(this).parent(),
				idx = $target.index(),
				offsetTop = Math.ceil($contents.eq(idx).offset().top);

			$('html, body').stop().animate({ scrollTop: offsetTop - $navheight }, 500);
			return false;
		});

	});

	// 상단 메뉴 스크롤 시, 고정
	var $nav = $('.floattab'),
		$menu = $('.floattab__list li'),
		$contents = $('.scroll'),
		$navheight = $nav.outerHeight(), // 상단 메뉴 높이
		$navtop = Math.ceil($nav.offset().top); // floattab 현재 위치; 

	// menu class 추가 
	$(window).scroll(function () {
		var $scltop = Math.ceil($(window).scrollTop());	// 현재 scroll

		if ($scltop > $navtop) {
			$nav.addClass("is-fixed");
			$(".visual").css("margin-bottom", $navheight);
		} else {
			$nav.removeClass("is-fixed");
			$menu.children("a").removeClass('is-on');
			$(".visual").css("margin-bottom", 0);
		}

		$.each($contents, function (idx, item) {
			var $target = $contents.eq(idx),
				i = $target.index(),
				targetTop = Math.ceil($target.offset().top - $navheight);

			if (targetTop <= $scltop) {
				$menu.children("a").removeClass('is-on');
				$menu.eq(idx).children("a").addClass('is-on');
			}
			if (!($navheight <= $scltop)) {
				$menu.children("a").removeClass('is-on');
			}
		})
	});
}(window, window.jQuery));

//레이어
function onoff(id) {
	var mid=document.getElementById(id);
	if(mid.style.display=='') {
	mid.style.display='none';
}else{
	mid.style.display='';
	}; 
}

$(document).ready(function(){
	Kakao.init('5cad223fb57213402d8f90de1aa27301');

	$("#snslayer li").click(function(){
		var shareUrl = "http://" + location.host + "/mobilefirst/evt/summer_2018.jsp";
		var shareTitle = "[에누리 가격비교]\n힘내라! 대~한민국!\n누리와 승부차기하고\n치킨먹으며 응원하자!";
		var idx = $(this).index();
		
		ga_log(11);
		if(idx == 1) {
			 try{ 
				Kakao.Link.sendTalkLink({
					label: shareTitle,
					image: {
						src: "http://imgenuri.enuri.gscdn.com/images/mobilenew/images/enuri_logo_facebook200.gif",
						width: '400',
						height: '209'
				    },
				    webButton: {
				    	text: "에누리 가격비교 열기",
						url: shareUrl
				    	},
					fail : function() {
					    alert("카카오 톡이 설치 되지 않았습니다.");
					}
			    });
			}catch(e){
				alert("카카오 톡이 설치 되지 않았습니다.");
				alert(e.message);
			}
		} else {
			window.open("http://www.facebook.com/sharer.php?u=" + shareUrl);
		}
	});
	
	ga_log = gaCall();

	//로그인시 개인화영역
	if(islogin()){
		$("#user_id").text("<%=cUserId%>");
		getPoint();//개인e머니 내역 노출
	}

	function gaCall () {
		var gaLabel = [
				"PV",
				"상단탭 기획전",
				"상단탭 이벤트1",
				"상단탭 이벤트2",
				"이벤트1참여",
				"기획전 리빙",
				"기획전 레져",
				"기획전 다이어트",
				"기획전 여행용품",
				"기획전 냉방가전",
				"기획전 여름패션",
				"상품클릭",
				"상품 더보기",
				"기획전 보러가기",
				"응모하기",
				"더많은 이벤트",
				"구매응모 상품클릭"
		];
		var vEvent_title = "2018 무더위 이벤트 ";

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

var ajaxUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=16";
if(location.host.indexOf("my.enuri.com") > -1) {
	ajaxUrl = "./test.json";
}

//전체 상품 데이터
var	ajaxData = (function() {
    var json = new Array();
    $.ajax({
        'async': false,
        'global': false,
        'url': ajaxUrl,
        'dataType': "json",
        'success': function (data) {
        	json = data["T"];
        }
    });
    return json;
})();


window.onload = function(){
	var app = getCookie("appYN"); //app인지 여부

	$(".btn_login").click(function(){
		goLogin();       
    });
	
	//PV
	ga_log(1);
	
	//이벤트1
	var selectDo = 0, // 아이스크림 선택 유무
	choiceIce; // 선택된 아이스크림

	// 아이스크림 선택 전,
	var choicebtn = $(".btn_choice").bind("click", function(){
		choiceIce = $(this).attr("data-fruit");
		
		$(".btn_choice").parents("li").removeClass("is-on");
		$(".choice_item").hide();
		$(this).parents("li").addClass("is-on");
		$("#" + choiceIce).show().children("div").eq(0).fadeIn();
		
		selectDo = 1; // 아이스크림 선택
		return false;
	});
	
	// 아이스크림 선택 후,
	$("#startSelect").click(function(){	
		ga_log(5);
		var that = this; 
		if(selectDo == 0){ // 선택 전,
			alert("아이스크림 종류를 골라주세요.");
		}else{ // 선택 후,	
			getEventAjaxData( {"procCode":1} , function(data) {
				var result = data.result;
				var vVote_img = "";
				var vVote_html = "";
				if(result >= 0){
					$(that).stop(0).animate({opacity: 0}, {
						complete: function(){
							$(choicebtn).unbind("click");
							$(that).hide(); // 영역 숨김
							$("." + choiceIce + "-ice1").hide().next().show(); // 스타트와 동시에 한입 베어물기
							
							// 경품 이미 선택된 시점.
							var resultImg = $(".cong"); // 당첨 결과 막대기    $(".cong") 또는 $(".fail")
							
							if(result == 2800){
								vVote_img += "http://imgenuri.enuri.gscdn.com/images/event/2018/summer_pro/prize1.jpg";
								vVote_html +="<div class=\"layer_info\"><em>2,800 적립</em></div>";
								resultImg  = $(".cong");
			                }else if(result == 5){
								vVote_img += "http://imgenuri.enuri.gscdn.com/images/event/2018/summer_pro/prize2.jpg";
								vVote_html +="<div class=\"layer_info\"><strong>내일 또 만나요~</strong></div>";
								resultImg  = $(".fail");
			                } 
							
							var point = 1; // 클릭한 수												
							var itemclick = $(".choice_item").bind("click", function(){
								if(point < 2){
									$(this).fadeOut().next().show();
									point++;	
								}else if(point === 2){
									$(".vote_box .inner .vote_img").attr("src", vVote_img);
					                $(".vote_box .inner .layer_info").html(vVote_html);
					                
									$(this).fadeOut();
									$(".btn_click").fadeOut(); // 클릭버튼 제거
									$(resultImg).fadeIn(500, function(){ // 당첨 결과 보여줌.
										$("#prizes").stop().delay(500).fadeIn(300); // 레이어 팝업 열림
									});
								
									$(choicebtn).unbind("click");
									$(itemclick).unbind("click");
									
								}
							});
						},
					},100);

				}else if(result == -1){
					alert("이미 참여하셨습니다.\n내일 또 참여해주세요.");
	                working = false;
				}else if(result == -2){
					alert("임직원은 참여 불가합니다.");
	                working = false;
				} else if(result == -55){
					alert("잘못된 접근입니다.");
					working = false;
				}else{
	                working = false;
				}
			});

			return false;
			
		}
	});
	
	//응모하기 버튼
	$("#event2_join").click(function(e){
		ga_log(15);
		if(app != 'Y'){
			onoff('app_only');
		}else {
			getEventAjaxData({"procCode": 2}, function(data){
				
				var result = data.result;
				result =1;
			    if(result == 2601){
			       alert("이미 응모하셨습니다.\n앱에서 구매 시\n구매내역 자동 누적됩니다.");
			    }else if( result == 1 ){
			        //alert("이벤트에 응모해주셔서 감사합니다.");
			         var rdm = Math.floor(Math.random() * 5);
			         var goodsList = arrayShuffle(ajaxData[rdm]["GOODS"]);
			         var html = "";
			 		 if(goodsList.length >0){
			 			for(var i=0;i<goodsList.length;i++){
			 				if(i>=2){
			 					break;
			 				}
			 				var goodsData = goodsList[i];
			 				var modelno = goodsData["MODELNO"];
			 				var goods_img = goodsData["GOODS_IMG"];
			 				var goods_title1 = goodsData["TITLE1"];
			 				var goods_title2 = goodsData["TITLE2"];
			 				var goods_minprice = goodsData["MINPRICE"];
			 				
			 				html+= "<li>";
			 				html+= "	<a href=\"javascript:;\" onclick=\"window.open('/mobilefirst/detail.jsp?modelno="+modelno+"&freetoken=vip');ga_log(17);\" title=\"새 탭에서 열립니다.\">";
			 				html+= "		<div class=\"img_box\">";
			 				html+= "			<img src=\""+goodsData["GOODS_IMG"]+"\" alt=\"\" />";
			 				if(goodsData["MINPRICE"]==0){
			 				html+= "			<span class=\"soldout\">SOLD OUT</span>";	
			 				}
			 				html+= "		</div>";
			 				html+= "		<div class=\"txt_box\">";
			 				html+= "			<span class=\"n_ptit\">"+goods_title1+"<br />"+goods_title2+"</span>";
			 				html+= "			<div class=\"n_price\">";
			 				html+= "				<span class=\"min stripe_layer\">지금최저가</span>";
			 				html+= "			    <span class=\"num\"><strong>"+goods_minprice.NumberFormat()+"</strong>원</span>";
			 				html+= "			</div>";
			 				html+= "		</div>";
			 				html+= "	</a>";
			 				html+= "</li>";	
			 			}
			 			$("#completeJoin_list").html(html);
			 		 }
			 		 
			 		 onoff('completeJoin'); 
			 		 return false;
			    }
			});
		}
		return false;
	});
	
	function arrayShuffle(oldArray) {
	    var newArray = oldArray.slice();
	    var len = newArray.length;
	    var i = len;
	    while (i--) {
	        var p = parseInt(Math.random()*len);
	        var t = newArray[i];
	        newArray[i] = newArray[p];
	        newArray[p] = t;
	    }
	    return newArray;
	};
	
	$("#event2_move").click(function(e){
		ga_log(14);
		window.open('/mobilefirst/event2018/summer_exh.jsp');
		return false;
	});

	//닫기버튼
	$( ".win_close" ).click(function(){
		if(app == 'Y'){
			window.location.href = "close://";
		}else{
			window.location.replace("/mobilefirst/Index.jsp");
		}
	});

	var isClick = true;
	function getEventAjaxData(param, callback){
		//이벤트 공통 체크
		if(!eventCommonChk()){
			return false;
		}
		
	    if(!isClick){
	    	return false;
	    }
	    isClick = false;
		$.post("/mobilefirst/evt/ajax/summer2018_setlist.jsp" , $.extend({sdt : "<%=sdt%>" , osType : getOsType()}, param),
				callback, "json")
			.done(function(){
				isClick = true;
			});
	}

	function eventCommonChk(){
		var sdt="<%=sdt%>";
		var endDate = "20180727";
		if(sdt > endDate){
			alert('이벤트가 종료되었습니다.');
			return false;
		}else if(!islogin()){
			alert("로그인 후 이용 가능합니다.");
			goLogin();
			return false;
		}else{
			return true;
		}
	}
	
	//여름생활백서
	fn_goodsTap();
	
	function fn_goodsTap(){
		var tapList = ["리빙","레져","다이어트","여행용품","냉방가전","여름패션"];
		var tapIndex = ["6","4","3","2","1","5"];
		var html = "";
		var tapGoodsArray = new Array();
		
		//새로고침 시마다 탭 랜덤 선택
	    var rdm = Math.floor(Math.random() * 5);
		
		var is_on = "";
		for(var i=0;i<tapList.length;i++){
			if(i==rdm) is_on = "is-on";
			else is_on = "";
			
			html +="<li>";
			html +="	<a id=\""+i+"\" class=\""+is_on+"\" href=\"javascript:///\" onclick=\"ga_log("+(i+6)+");\">"+tapList[i]+"</a>";
			html +="</li>";
		}
		
		$("#pro_itemlist_ul").html(html);
		
		loadGoodsList(ajaxData[tapIndex[rdm]]);
		
		$("#pro_itemlist_ul a").unbind();
		$("#pro_itemlist_ul a").click(function(e){
			var objIndex = $(this).parents("li").index();
			$("#pro_itemlist_ul li a").removeClass("is-on");
			$(this).addClass("is-on");
			
			//기획전 상품로드
			loadGoodsList(ajaxData[tapIndex[objIndex]]);
			
		});
	}

	function loadGoodsList(obj){
		var goodsList = obj["GOODS"];
		var html = "";
		if(goodsList.length >0){
			for(var i=0;i<goodsList.length;i++){
				if(i>=6){
					break;
				}
				var goodsData = goodsList[i];
				var modelno = goodsData["MODELNO"];
				var goods_img = goodsData["GOODS_IMG"];
				var goods_title1 = goodsData["TITLE1"];
				var goods_title2 = goodsData["TITLE2"];
				var goods_minprice = goodsData["MINPRICE"];
				
				html+= "<li>";
				html+= "	<a href=\"javascript:;\" onclick=\"window.open('/mobilefirst/detail.jsp?modelno="+modelno+"&freetoken=vip');ga_log(12);\" title=\"새 탭에서 열립니다.\">";
				html+= "		<div class=\"thumb\">";
				html+= "			<img src=\""+goodsData["GOODS_IMG"]+"\" alt=\"\" />";
				if(goodsData["MINPRICE"]==0){
				html+= "			<span class=\"soldout\">SOLD OUT</span>";	
				}
				html+= "		</div>";
				html+= "		<span class=\"info_area\">"+goods_title1+"<br />"+goods_title2+"</span>";
				html+= "		<span class=\"price_area\"><span class=\"price_label\">최저가</span><strong>"+goods_minprice.NumberFormat()+"</strong><span class=\"pro_unit\">원</span></span>";
				html+= "	</a>";
				html+= "</li>";	
			}
			$("#itemlist ul").html(html);
			var tapIndex = $("#pro_itemlist_ul li .is-on").attr("id");
			var tapList = ["living","leisure","diet","travel","appliance","fashion"];
			var goods_more = "/mobilefirst/event2018/summer_exh.jsp?tab="+tapList[tapIndex];
			
			$("#goods_btn_more").unbind();
			$("#goods_btn_more").click(function(){
				window.open(goods_more);
				ga_log(13);
			});
			
			if(tapType!='') {
				location.href = "#"+tapType;
			}
		}
		
	}
	
	/*var hash = window.location.hash.substr(1);
	if(hash=='evt1' || hash=='evt2'){
		var idx = hash.replace("evt","")-1;
		var $nav = $('.floattab');
		var $contents = $('.scroll');
		var $navheight = $nav.outerHeight();
		var offsetTop = Math.ceil($contents.eq(idx).offset().top);
		$('html, body').stop().animate({ scrollTop: offsetTop - $navheight }, 500);
	}*/
};



</script>
</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
