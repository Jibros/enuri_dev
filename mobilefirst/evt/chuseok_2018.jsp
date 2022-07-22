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
	response.sendRedirect("http://www.enuri.com/mobilefirst/evt/chuseok_2018.jsp");
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
String strFb_description = "2018 추석 프로모션";
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
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/chuseok_pro_m.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
	<script type="text/javascript" src="/common/js/function.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js?v=20180824"></script>
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
					<li id="kakao-link-btn">카카오톡</li>
				</ul>
			</div>
			<h1 class="imgbox"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/chuseok_pro/m_visual.jpg" alt="" /></h1>
			<div class="blind">
				<h1>풍요로운 한가위</h1>
				<p>에누리만의 특별한 추석맞이 이벤트를 만나보세요!</p>
			</div>
		</div>
		<!-- //visual -->

		<!-- 이벤트 01 -->
		<div class="evt1_contents scroll">
			<div class="contents">
				<div id="evt1" class="evt1__anchor"><p class="blind">이벤트 1 앵커 영역</p></div>
				
				<!-- floattab__list -->
				<div class="floattab">
					<div class="contents">
						<ul class="floattab__list">
							<li><a href="#evt1" onclick="ga_log(2);" class="movetab floattab__item floattab__item--01 is-on">이벤트 하나, 꿀송편 찾고 가래떡 먹자</a></li>
							<li><a href="#evt2" onclick="ga_log(3);" class="movetab floattab__item floattab__item--02">이벤트 둘, 앱에서 구매하고 마트상품권 받자</a></li>
						</ul>
					</div>	
				</div>
				<!-- //floattab__list -->
				
				<!-- 송편고르기 -->
				<div class="selmochi">
					<div class="inner">
						<span class="balloon">송편을 골라주세요</span>
						<span class="stick">젓가락</span>
						<ul class="mochi__list">
							<li><button type="button" class="mochi mochi__1">송편1</button></li>
							<li><button type="button" class="mochi mochi__2">송편2</button></li>
							<li><button type="button" class="mochi mochi__3">송편3</button></li>
							<li><button type="button" class="mochi mochi__4">송편4</button></li>
							<li><button type="button" class="mochi mochi__5">송편5</button></li>
							<li><button type="button" class="mochi mochi__6">송편6</button></li>
							<li><button type="button" class="mochi mochi__7">송편7</button></li>
							<li><button type="button" class="mochi mochi__8">송편8</button></li>
						</ul>
					</div>
					
					<!-- 송편 결과 : 축하, 꿀송편 -->
					<div class="mochi__result">
						<img src="" alt="" />
						<!-- 송편 결과 : 꽝, 팥송편
						<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/chuseok_pro/m_bg_result_lose.png" alt="아쉽지만 팥송편을 선택하셨어요" />
						-->
					</div>
				</div>
				<a href="#" class="btn_caution" onclick="onoff('notetxt1'); return false;">꼭!확인하세요</a>
			</div>
		</div>
		<!-- //이벤트 01 -->

		<!-- 추천 상품 영역 -->
		<div class="pro_itemlist">
			<div class="pro_tit">
				<div class="blind">
					<strong>추석 인기선물만 모았다</strong>
					<h3>BEST 추석선물</h3>
				</div>
			</div>
			<ul id="pro_itemlist_ul"></ul>
			<div class="recomm_list" id="itemlist">
				<ul class="items clearfix"></ul>
				<a class="btn_more" id="goods_btn_more" href="#">상품더보기</a>
			</div>
		</div>
		<!-- //추천 상품 영역 -->

		<!-- 이벤트 02 -->
		<div class="evt2_contents scroll">
			<div class="contents">
				<div id="evt2" class="evt2__anchor"><p class="blind">이벤트 2 앵커 영역</p></div>
				
				<div class="evt2_area">
					<div class="evt2_cont">
						<div class="blind">
							<h3>app에서 구매하고 롯데마트 쿠폰 받자!</h3>
							<p>많이 구매할수록 당첨확률 UP!</p>
							<ol>
								<li>50만원 이상 구매 시 롯데마트 상품권 4만원권 지급 (10명)</li>
								<li>10만원 이상 구매 시 롯데마트 상품권 2만원권 지급 (15명)</li>
								<li>5만원 이상 구매 시 롯데마트 상품권 5천원권 지급 (60명)</li>
							</ol>						
						</div>
						
						<a href="#" class="btn_appbuy" id="event2_move">기획전 보러가기</a>
						<a href="#" class="btn_apply" id="event2_join">응모하기</a>
					</div>	
					<ul class="evt_info">
						<li>이벤트 참여 및 구매 기간 : 2018년 9월 3일 ~ 9월 21일</li>
						<li>참여 방법 : APP &gt; 적립대상 쇼핑몰에서 구매하고 응모하기</li>
						<li>당첨자 발표 : 2018년 10월 31일 화요일 [에누리 앱 &gt; 이벤트/기획전 &gt; 이벤트 하단 당첨자 발표]</li>
						<li>사정에 따라 경품이 변경될 수 있습니다.</li>
					</ul>
					<a href="#" class="btn_caution" onclick="$('html, body').stop().animate({scrollTop:0}, 500, function(){$('#notetxt2').fadeIn(300)});return false;">꼭!확인하세요</a>
				</div>
			</div>
		</div>
		<!-- //이벤트 02 -->

		<!-- 에누리 혜택 -->
		<div class="otherbene">
			<div class="contents">
				<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/chuseok_pro/m_otherbene_tit.png" alt="에누리 혜택"></h2>
				<ul class="banlist">
					<li><a href="javascript:;" onclick="window.open('/mobilefirst/evt/visit_event.jsp?tab=1&freetoken=event');ga_log(14);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban1.png" alt="출석체크" /></a></li>
				<li><a href="javascript:;" onclick="window.open('/mobilefirst/evt/visit_event.jsp?tab=2&freetoken=event');ga_log(14);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban2.png" alt="매일룰렛" /></a></li>
				<li><a href="javascript:;" onclick="window.open('/mobilefirst/evt/welcome_event.jsp?tab=1&freetoken=event');ga_log(14);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban3.png" alt="첫구매혜택" /></a></li>
				<li><a href="javascript:;" onclick="window.open('/mobilefirst/evt/mobile_deal.jsp?freetoken=event');ga_log(14);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban4.png" alt="크레이지딜" /></a></li>
				<li><a href="javascript:;" onclick="window.open('/mobilefirst/evt/office_workers.jsp?event_id=2018090100&amp;freetoken=event');ga_log(14);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban5.png" alt="직장공감" /></a></li>
				<li><a href="javascript:;" onclick="more_evt();ga_log(14);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban6.png" alt="더많은 이벤트" /></a></li>
				</ul>
			</div>
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
					<li>이벤트 경품: e4,000점, e10점</li>
					<li>적립된 e머니는 e머니 스토어에서 다양한 e쿠폰상품으로 교환 가능합니다.</li>
					<li>
						<strong>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</strong>
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
					<dd>2018년 9월 3일 ~ 9월 21일</dd>
				</dl>

				<dl class="txtlist">
					<dt>경품 : </dt>
					<dd>50만원이상 구매 : 롯데마트 4만원권 – e머니 4만점 지급 (10명 추첨)</dd>
					<dd>50-100만원 구매 : 롯데마트 2만원권 – e머니 2만점 지급 (15명 추첨)</dd>
					<dd>15-50만원 구매 : 롯데마트 5천원권 – e머니 5천점 지급 (60명 추첨)</dd>
					<dd>
						<strong>e머니 유효기간 : 적립일로부터 15일</strong>
					</dd>
					<dd> 사정에 따라 경품이 변경될 수 있습니다.</dd>
				</dl>

				<dl class="txtlist">
					<dt>당첨자 발표 및 적립</dt>
					<dd>2018년 10월 31일 [APP 이벤트/기획전 탭 &gt; 이벤트 &gt; 당첨자 발표]</dd>
				</dl>

				<!-- 20180824 수정 -->
				<dl class="txtlist">
					<dt>구매적립 및 유의사항</dt>
					<dd>에누리 가격비교 앱 로그인 → 적립대상 쇼핑몰 이동 → 구매하기 → 마이에누리 → 적립내역 → 구매에서 '적립받기' 클릭</dd>
					<dd>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 위메프</dd>
					<dd>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품 결제금액만 반영적립 e머니는 카테고리에 따라 차등 적립</dd>
				</dl>

				<dl class="txtlist">
					<dt>※ 카테고리별 적립률 상세
						<div class="tb">
							<table>
								<colgroup>
									<col width="70%">
									<col width="30%">
								</colgroup>
								<tbody>
									<tr>
										<th>카테고리</th>
										<th>적립률</th>
									</tr>
									<tr>
										<td>유아</td>
										<td>1.5%</td>
									</tr>
									<tr>
										<td>식품/스포츠/레저/자동차</td>
										<td>1.0%</td>
									</tr>
									<tr>
										<td>컴퓨터/도서/취미</td>
										<td>0.8%</td>
									</tr>
									<tr>
										<td>디지털/가전</td>
										<td rowspan="3">0.3%</td>
									</tr>
									<tr>
										<td>패션/화장품</td>
									</tr>
									<tr>
										<td>가구/생활/건강</td>
									</tr>
								</tbody>
							</table>
						</div>
					</dt>
					<dd>적립가능 상품을 제외한 상품권, 지역쿠폰, e교환권, e쿠폰은 적립불가</dd>
						<dd>적립대상쇼핑몰에서 장바구니로 여러 상품을 한번에 통합 결제 시 구매건수는 1건이며, 구매금액은 통합 결제한 금액의 e머니 적립</dd>
						<dd>결제일로부터 10~30일간 취소/반품여부 확인 후 적립</dd>
						<dd>e머니는 최소 10점부터 적립되며 (구매금액 1,000원 이상), 1원 단위 e머니는 적립되지 않습니다. 
							<br>(예: 1,200원 결제 시 e머니 10점 적립)</dd>
					<dd>구매적립 e머니 유효기간: 적립일로부터 60일(기간경과 이후 적립불가)</dd>
					<dd>적립된 e머니는 앱에서 다양한 e쿠폰 상품으로 교환 가능합니다</dd>
				</dl>

				<dl class="txtlist">
					<dt>아래의 경우에는 구매 확인 및 적립이 불가합니다.</dt>
					<dd>에누리 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리앱으로 결제만 한 경우
						<br>(에누리 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)</dd>
					<dd>에누리 앱을 로그인하지 않고 구매한 경우 또는 앱이 아닌, 에누리PC/모바일 웹에서 구매한 경우</dd>
				</dl>
				<!-- //20180824 수정 -->

				<dl class="txtlist">
					<dt>유의사항</dt>
					<dd>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</dd>
					<dd>더블적립 대상자는 본 이벤트와 중복참여하실 수 없습니다.</dd>
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
		<div class="vote_box">
			<div class="inner">
				<!-- 꿀송편 당첨 -->
				<img class="vote_img" src="http://imgenuri.enuri.gscdn.com/images/event/2018/chuseok_pro/modal_result_win.png" alt="축하합니다 e머니 4000점 적립! 내일 또 만나요~!" />
				<!-- 팥송편 당첨
				<img class="vote_img" src="http://imgenuri.enuri.gscdn.com/images/event/2018/chuseok_pro/modal_result_lose.png" alt="다음 기회에! e머니 10점 적립! 내일 또 만나요~!" />\
				-->
			</div>
			<button type="button" class="btn layclose" onclick="$('#prizes').fadeOut(150);">
				<em>팝업 닫기</em>
			</button>
		</div>
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
	
	<span class="go_top"><a onclick="$(window).scrollTop(0);">TOP</a></span>

<script type="text/javascript">

</script>
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script type="text/javascript" src="/mobilefirst/js/lib/vue.min.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js"></script>

<script type="text/javascript">
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로
var tapType = "<%=tab%>";

//ga_log(1) - ga_log(14)
var ga_log;

(function (global, $) {
	$(function () {
		var $nav = $('.floattab'),
		$menu = $('.floattab__list li'),
		$contents = $('.scroll'),
		$navheight = $nav.outerHeight(); // 상단 메뉴 높이
		
		// 해당 섹션으로 스크롤 이동 
		$menu.on('click', 'a', function (e) {
			var $target = $(this).parent(),
				idx = $target.index(),
				offsetTop = Math.ceil($contents.eq(idx).offset().top);

			$('html, body').stop().animate({ scrollTop: offsetTop }, 500);
			return false;
		});
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
	
	$("#snslayer li").click(function(){
		var shareUrl = "http://" + location.host + "/mobilefirst/evt/chuseok_2018.jsp";
		var shareTitle = "[에누리 가격비교]\n풍요로운 한가위!\n풍성한 혜택을 받고싶다면\n에누리로 와~";
		var idx = $(this).index();
		Kakao.init('5cad223fb57213402d8f90de1aa27301');
		if(idx == 1) {
			try{ 
				Kakao.Link.createDefaultButton({
				      container: '#kakao-link-btn',
				      objectType: 'feed',
				      content: {
				        title: shareTitle,
				        imageUrl: 'http://imgenuri.enuri.gscdn.com/images/mobilenew/images/enuri_logo_facebook200.gif',
				        link: {
				          mobileWebUrl: shareUrl,
				          webUrl: shareUrl
				        }
				      },
				      social: {
				        likeCount: 286,
				        commentCount: 45,
				        sharedCount: 845
				      },
				      buttons: [
				        {
				          title: '에누리 가격비교 열기',
				          link: {
				            mobileWebUrl: shareUrl,
				            webUrl: shareUrl
				          }
				        }
				      ]
				    });
			}catch(e){
				alert(e);
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
				"앵커탭 이벤트1",
				"앵커탭 이벤트2",
				"이벤트1참여",
				"기획전탭 농수산",
				"기획전탭 가공생활",
				"기획전탭 건강식품",
				"기획전탭 상품권",
				"기획전 상품클릭",
				"기획전 상품더보기",
				"기획전보러가기",
				"구매응모 상품클릭",
				"에누리혜택"
		];
		var vEvent_title = "2018 한가위이벤트 ";

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

var ajaxUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=18";
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
	var $mochi = $(".mochi"), // 송편
	$mochi_result = $(".mochi__result"); // 팥/꿀 결과화면
	
	//송편선택 후
	$mochi.click(function(){
		ga_log(4);
		getEventAjaxData( {"procCode":1} , function(data) {
			var result = data.result;
			var vVote_img = "";
			var result_img = "";
			var vVote_alt = "";
			var result_alt = "";
			if(result >= 10){
				if(result == 4000){
					vVote_img += "http://imgenuri.enuri.gscdn.com/images/event/2018/chuseok_pro/modal_result_win.png";
					result_img += "http://imgenuri.enuri.gscdn.com/images/event/2018/chuseok_pro/pc_bg_result_win.jpg";
					vVote_alt = "축하합니다 e머니 4000점 적립! 내일 또 만나요~!";
					result_alt = "축하합니다 달달한 꿀송편을 찾으셨어요!";
                }else if(result == 10){
					vVote_img += "http://imgenuri.enuri.gscdn.com/images/event/2018/chuseok_pro/modal_result_lose.png";
					result_img += "http://imgenuri.enuri.gscdn.com/images/event/2018/chuseok_pro/pc_bg_result_lose.jpg";
					vVote_alt = "다음 기회에! e머니 10점 적립! 내일 또 만나요~!";
					result_alt = "아쉽지만 팥송편을 선택하셨어요";
                } 
				$(".vote_img").attr("src", vVote_img);
				$(".vote_img").attr("alt", vVote_alt);
				$mochi_result.find("img").attr("src", result_img);
				$mochi_result.find("img").attr("alt", result_alt);
				
				$(".selmochi .balloon, .selmochi .stick").fadeOut();
				$mochi_result.fadeIn(1000, function(){ // 당첨 결과 보여줌.
					$("#prizes").fadeIn(300); // 레이어 팝업 열림
				});

				getTopEmoney();

			}else if(result == -1){
				alert("이미 참여하셨습니다.\n내일 또 참여해주세요.");
                working = false;
			}else if(result == -2){
				alert("임직원은 참여 불가합니다.");
                working = false;
			} else if(result == -55){
				alert("잘못된 접근입니다.");
			}else{
                working = false;
			}
		});

		return false;
		
	});
	
	//응모하기 버튼
	$("#event2_join").click(function(e){
		ga_log(12);
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
			         var rdm = Math.floor(Math.random() * 4);
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
			 				var goods_minprice = goodsData["MINPRICE"]==null?0:goodsData["MINPRICE"];
			 				
			 				html+= "<li>";
			 				html+= "	<a href=\"javascript:;\" onclick=\"window.open('/mobilefirst/detail.jsp?modelno="+modelno+"&freetoken=vip');ga_log(9);\" title=\"새 탭에서 열립니다.\">";
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
			 				html+= "			    <span class=\"num\"><strong>"+numberWithCommas(goods_minprice)+"</strong>원</span>";
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
		ga_log(11);
		window.open('/mobilefirst/event2018/chuseok_2018_exh.jsp');
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
		var sdt = "<%=sdt%>";
		if(sdt < "20180903"){
			alert('오픈예정입니다.');
			return false;
		}
		//이벤트 공통 체크
		if(!eventCommonChk()){
			return false;
		}
		
	    if(!isClick){
	    	return false;
	    }
	    isClick = false;
		$.post("/mobilefirst/evt/ajax/chuseok2018_setlist.jsp" , $.extend({sdt : "<%=sdt%>" , osType : getOsType()}, param),
				callback, "json")
			.done(function(){
				isClick = true;
			});
	}

	function eventCommonChk(){
		var sdt="<%=sdt%>";
		var endDate = "20180921";
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
	
	//기획전 상품로드
	fn_goodsTap();
	
	function fn_goodsTap(){
		var tapList = ["농수산","가공,생활","건강식품","상품권"];
		var html = "";
		var tapGoodsArray = new Array();
		
		//새로고침 시마다 탭 랜덤 선택
	    var rdm = Math.floor(Math.random() * 4);
		
		var is_on = "";
		for(var i=0;i<tapList.length;i++){
			if(i==rdm) is_on = "is-on";
			else is_on = "";
			
			html +="<li>";
			html +="	<a id=\""+i+"\" class=\""+is_on+"\" href=\"javascript:///\" onclick=\"ga_log("+(i+5)+");\">"+tapList[i]+"</a>";
			html +="</li>";
		}
		
		$("#pro_itemlist_ul").html(html);
		
		loadGoodsList(ajaxData[rdm]);
		
		$("#pro_itemlist_ul a").unbind();
		$("#pro_itemlist_ul a").click(function(e){
			var objIndex = $(this).parents("li").index();
			$("#pro_itemlist_ul li a").removeClass("is-on");
			$(this).addClass("is-on");
			
			//기획전 상품로드
			loadGoodsList(ajaxData[objIndex]);
			
		});
	}
	
	
	function loadGoodsList(obj){
		var goodsList = obj["GOODS"];
		var html = "";
		$("#itemlist ul").html(html);
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
				var goods_minprice = goodsData["MINPRICE"]==null?0:goodsData["MINPRICE"];

				html+= "<li>";
				html+= "	<a href=\"javascript:;\" onclick=\"window.open('/mobilefirst/detail.jsp?modelno="+modelno+"&freetoken=vip');ga_log(9);\" title=\"새 탭에서 열립니다.\">";
				html+= "		<div class=\"thumb\">";
				html+= "			<img src=\""+goods_img+"\" alt=\"\" />";
				if(goodsData["MINPRICE"]==0){
				html+= "			<span class=\"soldout\">SOLD OUT</span>";	
				}
				html+= "		</div>";
				html+= "		<span class=\"info_area\">"+goods_title1+"<br />"+goods_title2+"</span>";
				html+= "		<span class=\"price_area\"><span class=\"price_label\">최저가</span><strong>"+numberWithCommas(goods_minprice)+"</strong><span class=\"pro_unit\">원</span></span>";
				html+= "	</a>";
				html+= "</li>";	
				
			}
			$("#itemlist ul").html(html);
			
			/*$('#itemlist ul').contentchanged(){
				if(tapType!='') {
					$('html, body').animate({
						scrollTop: $('#'+tapType).offset().top
					}, 'slow');
				}
			}*/
			/*function loadComplete(){
				console.log("1111");
				if(tapType!='') {
					$('html, body').animate({
						scrollTop: $('#'+tapType).offset().top
					}, 'slow');
				}
			}*/


			
				/*if(tapType!='') {
					$('html, body').animate({
						scrollTop: $('#'+tapType).offset().top)
					}, 'slow');
				}*/

		
		}
		
		var tapIndex = $("#pro_itemlist_ul li .is-on").attr("id");
		var tapList = ["2","5","6","7"];
		var goods_more = "/mobilefirst/event2018/chuseok_2018_exh.jsp?tab=contArea"+tapList[tapIndex]+"&freetoken=event";
		
		$("#goods_btn_more").unbind();
		$("#goods_btn_more").click(function(){
			window.open(goods_more);
			ga_log(10);
		});
		
		if(tapType!='') {
			//location.href = "#"+tapType;
		}
	}
};

function tabFix(){
	var tab = "<%=tab%>";
	
	switch (tab) {
	case "evt1":
		location.href = "#evt1";
		break;
	case "evt2":
		location.href = "#evt2";
		break;
	}
}

$(window).load(function(){
	if(tapType!='') {
		setTimeout(inner, 300);
	}
	function inner() {
		$('html, body').animate({scrollTop: Math.ceil($('#'+tapType).offset().top)}, 500);
	}
});



function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function more_evt(){
	if( getCookie("appYN") != "Y"){
		vUrl = "/mobilefirst/index.jsp#evt";
	}else{
		vUrl = "/mobilefirst/renew/plan.jsp?freetoken=main_tab|event";
	}
	window.open(vUrl);
}

</script>
</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
