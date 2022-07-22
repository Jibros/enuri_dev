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
	response.sendRedirect("http://www.enuri.com/event2018/worldcup_2018.jsp");
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
String strFb_description = "힘내라! 대~한민국!\n누리와 승부차기하고\n치킨먹으며 응원하자!";
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
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/worldcup_2018_m.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
</head>
<body>

	<div class="myarea">
        <p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>
		<a href="javascript:///" class="win_close">창닫기</a>
	</div>

	<div class="wrap">
		<!-- 상단비주얼 -->
		<div class="section visual">
			<div class="sns">
				<span class="sns_share evt_ico" onclick="onoff('snslayer')">sns 공유하기</span>
				<ul id="snslayer" style="display:none;">
					<li>페이스북</li>
					<li>카카오톡</li>
				</ul>
			</div>
			<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/worldcup/m_visual.jpg" alt="승리기원 이벤트" />
			<div class="blind">
				<h1>승리기원 이벤트</h1>
				<p>힘내라 대한민국</p>
			</div>
		</div>
		<!-- //상단비주얼 -->

		<!-- 플로팅 탭 -->
		<div class="floattab">
			<div class="contents">
				<ul class="floattab__list">
					<li onclick = "ga_log(2);"><a href="#evt1" class="movetab floattab__item floattab__item--01">누리와 승부차기</a></li>
					<li onclick = "ga_log(3);"><a href="#evt2" class="movetab floattab__item floattab__item--02">치킨먹고 응원하자</a></li>
					<li onclick = "ga_log(4);"><a href="#evt3" class="movetab floattab__item floattab__item--03">응원 필수템</a></li>
				</ul>
			</div>
		</div>
		<div class="section evt_zone">
			<!-- 이벤트1 -->
			<div id="evt1" class="evt1 scroll">
				<div class="contents">
					<div class="imgbox">
						<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/worldcup/m_evt1_bg.jpg" alt="이벤트1" />
						<div class="blind">
							<h3>이벤트1 누리와 승부차기</h3>
							<span>골 넣으면 투썸 콜드브루 쏜다</span>
							<em>투썸플레이스 콜드브루 e4,500</em>
						</div>

						<!-- 참여 전 : 참여 후 사라짐. -->
						<div class="join__before">
							<!-- 축구공, 풍선 -->
							<button type="button" class="football animated"></button>
							<div class="football__shadow"></div>
							<button type="button" class="balloon"></button>

							<!-- 골키퍼 -->
							<div id="keeper" class="keeper1"></div>
						</div>

						<!-- 참여 후 보이는 BG (default 비노출) -->
						<div class="join__after">
							<div class="result__bg result__bg--1">골인!</div>
							<div class="result__bg result__bg--2">노골! 5점 적립</div>
							<div class="result__bg result__bg--3">노골! 5점 적립</div>
						</div>

						<a href="#" class="btn_caution" onclick="onoff('notetxt1'); return false;">꼭!확인하세요</a>
					</div>
				</div>
			</div>
			<!-- //이벤트1 -->

			<!-- //이벤트2 -->
			<div id="evt2" class="evt2 scroll">
				<div class="contents">
					<div class="imgbox">
						<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/worldcup/m_evt2_bg.jpg" alt="이벤트2" />
						<div class="blind">
							<h3>이벤트1 치킨먹고 응원하자</h3>
							<span>app에서 구매하면 치킨 쏜다</span>
							<em>깐부 크리스피 치킨 e17,000</em>
						</div>
						<a href="javascript:///" class="btn_appbuy" id = "event2_move">앱에서 구매하기</a>
						<a href="javascript:///" class="btn_apply" id = "event2_join">응모하기</a>
						<a href="#" class="btn_caution" onclick="onoff('notetxt2'); $(window).scrollTop(0); return false;">꼭!확인하세요</a>
						<ul>
							<li>이벤트 참여 및 구매 기간 : 2018년 6월14일 ~ 7월 15일</li>
							<li>당첨자 발표 : 2018년 8월 24일 금요일
								<br />[에누리 APP > 이벤트/기획전 > 이벤트 당첨자 발표] </li>
						</ul>
					</div>
				</div>
			</div>
			<!-- //이벤트2 -->
		</div>

		<!-- 하단상품영역 -->
		<div id="evt3" class="section product_zone scroll">

			<div class="pro_list recom1" v-for = "n in 3" >
				<h3>
					<img v-bind:src="bgImg[n-1]" alt="골 넣는 순간 실감나는 초대형 화면" />
				</h3>
				<ul class="product_list clearfix">
					<li v-for = "(item, index) in items[n-1]" v-if = "index <= 6" v-on:click = "ga_log(n * 2 + 4); itemClick(item.MODELNO, item.MINPRICE3)">
						<a href="javascript:///">
							<span class="thumb">
								<template v-if="item.GOODS_IMG">
									<img v-bind:src= "item.GOODS_IMG" alt="" />
								</template>
								<template v-else>
									<img v-bind:src= "item.IMG_SRC" alt="" />
								</template>
								<template v-if="item.MINPRICE3 == 0">
									<span class="soldout">SOLD OUT</span>
	                            </template>
							</span>
							<span class="info_area">{{ item.TITLE1 }}<br />{{item.TITLE2}}</span>
							<span class="price_area">최저가
							<strong>{{commaNum(item.MINPRICE3) }}</strong>원</span>
						</a>
					</li>
				</ul>
				<a href="javascript:///" class="btn_moreview" v-on:click="ga_log(n * 2 + 3); moreItem(n-1)">상품더보기</a>
			</div>		
		
		</div>
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
					<li>이벤트 경품: 투썸플레이스 콜드브루커피 (e4,500점), e5점</li>
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
					<dd>2018년 6월 14일 ~ 7월 15일</dd>
				</dl>

				<dl class="txtlist">
					<dt>경품 : </dt>
					<dd>깐부치킨 크리스피 치킨 e머니 17,000점 (30명 추첨)
					</dd>
					<dd>
						<strong class="emp">e머니 유효기간 : 적립일로부터 15일</strong>
					</dd>
					<dd>적립된 e머니는 e쿠폰 스토어에서 다양한 e쿠폰으로 교환 가능합니다.
						<br />
						<span class="under">※ 사정에 따라 경품이 변경될 수 있습니다.</span>
					</dd>
				</dl>

				<dl class="txtlist">
					<dt>당첨자 발표 및 적립</dt>
					<dd>2018년 8월 24일 [APP 이벤트/기획전 탭 &gt; 이벤트 &gt; 당첨자 발표]</dd>
				</dl>

				<dl class="txtlist">
					<dt>아래의 경우에는 구매 확인 및 적립이 불가합니다.</dt>
					<dd>에누리 가격비교 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱으로 결제만 한 경우
						<br />(에누리 가격비교 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)</dd>
					<dd>에누리 가격비교 앱 미 로그인 후 구매한 경우 또는 에누리 가격비교 PC, 모바일 웹에서 구매한 경우</dd>
				</dl>

				<dl class="txtlist">
					<dt>이벤트 유의사항</dt>
					<dd>응모 시 이벤트 기간 내 해당 카테고리 상품 구매금액이 자동 합산됩니다.</dd>
					<dd>
						<strong class="emp">응모 시 입력한 휴대폰번호로 개별연락 드리며 잘못된 정보 기입했거나 연락이 되지 않아 발생하는 불이익에 대해서는 책임지지 않습니다.</strong>
					</dd>
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
				<!-- 골인 레이어 -->
				<div class="vote_img">
					<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/worldcup/pc_vote_img01.jpg" alt="골인! 축하합니다. 내일 또 만나요~" />
				</div>

				<!-- 노골 레이어
				<div class="vote_img">
					<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/worldcup/pc_vote_img02.jpg" alt="+5점 적립, 아쉽네요ㅠ 그래도 우리 팀 응원해 줄거죠? 내일 또 만나요~"
					/>
				</div> -->

				<button type="button" class="btn_close" onclick="$('#prizes').fadeOut(150);">닫기</button>
			</div>

			<button type="button" class="btn layclose" onclick="$('#prizes').fadeOut(150);">
				<em>팝업 닫기</em>
			</button>
		</div>
		<!-- //popup_box -->
	</div>
	<!-- //당첨 레이어 -->
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

//ga_log(1) - ga_log(14)
var ga_log;

$(document).ready(function(){
	Kakao.init('5cad223fb57213402d8f90de1aa27301');

	$("#snslayer li").click(function(){
		var shareUrl = "http://" + location.host + "/mobilefirst/evt/worldcup_2018.jsp";
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
              "탭 이벤트1",
              "탭 이벤트2",
              "탭 기획전",
              "TV 더보기",
              "TV 상품클릭",
              "야식 더보기",
              "야식 상품클릭",
              "응원도구 더보기",
              "응원도구 상품클릭",
              "SNS 공유"
		];
		var vEvent_title = "2018 월드컵";

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
	var app = getCookie("appYN"); //app인지 여부

	$(".btn_login").click(function(){
		goLogin();       
    });
	
	//PV
	ga_log(1);
	
	//이벤트1
	$(".football, .balloon").bind("click", function(){
		var that = this;
		
		getEventAjaxData({"procCode": 1}, function(data){
			var result = data.result;
			//result = 4500;
			if(result >= 0) {
				var resultRandom = 0;
				if(result == 5) {
					resultRandom = 2;
				} else if(result == 4500) {
					resultRandom = 1;
				}
				$(".vote_img").html("<img src=\"http://imgenuri.enuri.gscdn.com/images/event/2018/worldcup/pc_vote_img0"+ resultRandom +".jpg\" alt=\"\" />");
				/*
					1~3 난수, 퍼블용으로 BG 확인차 넣어둔거니 작업 시, 빼주세요
					1 = 골인
					2 = 노골1
					3 = 노골2
				*/
				if(result == 5) {
					resultRandom += Math.floor(Math.random()*2);
				}
				$(".football").removeClass("animated").addClass("shooting" + resultRandom).stop().delay(400).animate({"opacity": 0}, 100, function(){
					$(".join__before").fadeOut(300);
					$(".result__bg--" + resultRandom).animate({"opacity": 1}, 500, function(){
						$("#prizes").stop().delay(500).fadeIn(300); // 레이어 팝업 열림
					});
				});
				getPoint();
				$(that).unbind("click");
				
			} else if(result == -1){
				alert("이미 참여하셨습니다.\n내일 또 참여해주세요.");
			} else if(result == -2){
				alert("임직원은 참여 불가합니다.");
			} else {
				alert("잘못된 접근입니다.");
			}
			
		});
	});
	//응모하기 버튼
	$("#event2_join").click(function(e){
		if(app != 'Y'){
			onoff('app_only');
		}else {
			getEventAjaxData({"procCode": 2}, function(data){
				
				var result = data.result;
			    if(result == 2601){
			       alert("이미 응모하셨습니다.\n앱에서 구매 시\n구매내역 자동 누적됩니다.");
			    }else if( result == 1 ){
			        alert("이벤트에 응모해주셔서 감사합니다.");
			    }
			});
		}
		return false;
	});
	
	$("#event2_move").click(function(e){
		if(app != 'Y'){
			onoff('app_only');
		}else {
			location.href = "#evt3";
		}
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
		$.post("/mobilefirst/evt/ajax/worldcup2018_setlist.jsp" , $.extend({sdt : "<%=sdt%>" , osType : getOsType()}, param),
				callback, "json")
			.done(function(){
				isClick = true;
			});
	}

	function eventCommonChk(){
		var sdt="<%=sdt%>";
		var endDate = "20180715";
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
};

var rcmdPak = new Vue ({
	el : "#evt3",
	data : {
		items : [],
		cateNos : ["0201","16471808","091108"],
		bgImg : [
			"http://imgenuri.enuri.gscdn.com/images/event/2018/worldcup/m_pro_list_tit1.jpg",
			"http://imgenuri.enuri.gscdn.com/images/event/2018/worldcup/m_pro_list_tit2.jpg",
			"http://imgenuri.enuri.gscdn.com/images/event/2018/worldcup/m_pro_list_tit3.jpg"
		]
	},
	created : function() {
		var that = this;
		$.getJSON("/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=15", function(data){
			var Tdata = data.T;
			$.each(Tdata, function(i,v){
				that.items.push(shuffle(v.GOODS));				
			});
		});
	},
	updated : function() {
		(function (global, $) {
			// 상단 메뉴 스크롤 시, 고정
			var $nav = $('.floattab'),
				$menu = $('.floattab__list li'),
				$contents = $('.scroll'),
				$navheight = $nav.outerHeight(), // 상단 메뉴 높이
				$navtop = Math.ceil($nav.offset().top); // floattab 현재 위치;

			/* 골키퍼 모션 */
			var $keeper = $("#keeper"),
				keeperArr = ["keeper1", "keeper2", "keeper3", "keeper4", "keeper5", "keeper6", "keeper7"],
				keeperIndex = 0,
				turn = false;

			function changeKeeper(){
				$keeper.attr("class", keeperArr[keeperIndex]);

				if(!turn) keeperIndex++;
				else keeperIndex--;

				if(keeperIndex > keeperArr.length) turn = true;
				else if(keeperIndex == 0) turn = false;
			}
			setInterval(changeKeeper, 40);

			// 해당 섹션으로 스크롤 이동
			$menu.on('click','a', function(e){
				var $target = $(this).parent(),
					idx = $target.index(),
					offsetTop = Math.ceil($contents.eq(idx).offset().top);

				$('html, body').stop().animate({ scrollTop :offsetTop - $navheight }, 500);
				return false;
			});

			// menu class 추가
			$(window).scroll(function(){
				var $scltop = Math.ceil($(window).scrollTop());	// 현재 scroll

				if ($scltop > $navtop) {
					$nav.addClass("is-fixed");
					$(".visual").css("margin-bottom", $navheight);
				}else{
					$nav.removeClass("is-fixed");
					$menu.children("a").removeClass('is-on');
					$(".visual").css("margin-bottom", 0);
				}

				$.each($contents, function(idx, item){
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
	},
	methods : {
		//상품더보기
		moreItem : function(param) {
			window.open("/mobilefirst/list.jsp?freetoken=llist&cate=" + this.cateNos[param]);
		},
		//상품 클릭이동
		itemClick : function (modelNo, minprice){
		    if(minprice > 0){
		        window.open('/mobilefirst/detail.jsp?modelno=' + modelNo +'&freetoken=vip');
		    }else{
		        alert("품절된 상품 입니다.");
		    }
		}
	}
});

</script>
</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
