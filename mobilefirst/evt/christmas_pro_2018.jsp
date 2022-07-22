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
	response.sendRedirect("http://www.enuri.com/mobilefirst/evt/christmas_pro_2018.jsp");
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
String strFb_description = "2018 크리스마스 프로모션";
String strFb_img = ConfigManager.IMG_ENURI_COM+"/images/mobilenew/images/enuri_logo_facebook200.gif";
String tab = ChkNull.chkStr(request.getParameter("tab"));

//DA용 구분
String flow = ChkNull.chkStr(request.getParameter("flow"));
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
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/christmas_pro_m.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
	<script type="text/javascript" src="/common/js/function.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js?v=20180824"></script>
</head>
<body>
	<!-- 개인화영역 -->
	<div class="myarea">
        <p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>
		<a href="javascript:///" class="win_close">창닫기</a>
	</div>
	<!-- //개인화영역 -->

	<div class="wrap">
		<!-- visual -->
		<div class="visual">
			<div class="sns">
				<span class="sns_share evt_ico" onclick="onoff('snslayer')">sns 공유하기</span>
				<ul id="snslayer" style="display:none;">
					<li>페이스북</li>
					<li id="kakao-link-btn">카카오톡</li>
				</ul>
			</div>
			<h1 class="imgbox pagetit">
				MERRY CHRISTMAS
				<p>행복한 크리스마스를 위한 이벤트!</p>
			</h1>
		</div>
		<!-- //visual -->
		
		<!-- floattab__list -->
		<div class="floattab">
			<div class="contents">
				<ul class="floattab__list">
					<li><a href="#evt1" onclick="ga_log(2);" class="movetab floattab__item floattab__item--01 is-on">이벤트 하나, 선물꾸러미 찾고 커피 마시자!</a></li>
					<li><a href="#evt2" onclick="ga_log(3);" class="movetab floattab__item floattab__item--02">이벤트 둘, 앱에서 구매하고 케익 받자!</a></li>
				</ul>
			</div>	
		</div>
		<!-- //floattab__list -->
		
		<!-- 이벤트 01 -->
		<div class="evt1_contents scroll">
			<div class="contents">					
				<div id="evt1" class="evt1__anchor"><p class="blind">이벤트 1 앵커 영역</p></div>
				
				<!-- 양말고르기 -->
				<div class="evt_christmas">
					<h2 class="evt__tit">선물꾸러미를 찾아라!</h2>
					<p class="blind">올해 크리스마스 선물은 뭘까?</p>
				
					<div class="motionbox">
						<p class="reward">[드롭탑] 화이트모카R(e머니 5,100점)</p>
												
						<div class="socks">
							<p class="socks__line">원하는 양말을 클릭해주세요</p>
							
							<ul class="socks__list">
								<li class="socks1"><button type="button">1번 양말</button></li>
								<li class="socks2"><button type="button">2번 양말</button></li>
								<li class="socks3"><button type="button">3번 양말</button></li>
							</ul>
						</div>
						
						<!-- 선택 결과 -->
						<div class="evt__result">
							<!-- 결과 : 꽝-->
							<div class="evt--fail">내일은 꼭! 커피마시자~</div>
							<!-- 결과 : 성공 -->
							<div class="evt--success">축하합니다! 당첨되셨어요~</div>
						</div>
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
					<strong>이 선물만 주면 인싸확정!</strong>
					<h3>크리스마스 BEST 선물</h3>
				</div>
			</div>
			<ul id="pro_itemlist_ul"></ul>
			<div class="recomm_list" id="itemlist">
				<ul class="items clearfix"></ul>
				<a class="btn_more" href="#" id="goods_btn_more">상품더보기</a>
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
							<h3>app에서 선물 구매하고 크리스마스 케익 받자!</h3>
							<p>많이 구매할수록 당첨확률 UP!</p>
							<ol>
								<li>[파리바게뜨] 행복해 청포도케이크 (e머니 19,000점) - 30명</li>
							</ol>						
						</div>
						
						<a href="#" class="btn_appbuy" id="event2_move" target="_blank">기획전 보러가기</a>
						<a href="#" class="btn_apply" id="event2_join">응모하기</a>
					</div>				
					<ul class="evt_info">
						<li>이벤트 참여 및 구매 기간 : 2018년 12월 6일 ~ 12월 25일</li>
						<li>참여 방법 : APP &gt; 적립대상 쇼핑몰에서 구매하고 응모하기</li>
						<li>당첨자 발표 : 2019년 1월 24일 목요일<br> [에누리 앱 &gt; 이벤트/기획전 &gt; 이벤트 하단 당첨자 발표]</li>
						<li>사정에 따라 경품이 변경될 수 있습니다.</li>
					</ul>
				</div>
			</div>
					
			<!-- 유의사항 WRAPPER -->
			<div class="caution-wrap">
				<a href="#" class="btn_check btn_caution">꼭!확인하세요</a>
				
				<!-- 유의사항 드롭다운 -->
				<div class="moreview">
					<h4>유의사항</h4>
					<div class="txt">
						<strong>이벤트/구매 기간 : </strong>
						<ul class="txt_indent">
							<li>2018년 12월 6일 ~ 12월 25일</li>
						</ul>
	
						<strong>경품 :</strong>
						<ul class="txt_indent">
							<li>[파리바게뜨] 행복해 청포도케이크 – e머니 19,000점 지급 (30명 추첨)</li>
							<li>
								<strong>e머니 유효기간 : 적립일로부터 15일</strong>
							</li>
							<li>사정에 따라 경품이 변경될 수 있습니다.</li>
						</ul>
						
						<strong>당첨자 발표 및 적립</strong>
						<ul class="txt_indent">
							<li>2019년 1월 24일 [APP 이벤트/기획전 탭 &gt; 이벤트 하단 당첨자 발표]</li>
						</ul>
		
						<strong>구매방법 및 유의사항</strong>
						<ul class="txt_indent">
							<li>에누리 가격비교 앱 로그인 → 적립대상 쇼핑몰 이동 → 구매하기 → 구매확정(배송완료) 금액이 1,000원 이상 시 e머니 적립</li>
							<li>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스)</li>
							<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품 결제금액만 반영</li>
							<li>구매 e머니는 구매 확인완료 시점(구매 후 최대 30일)부터 모바일 앱 &gt; 마이 에누리 &gt; 적립내역 페이지에서 [적립받기] 선택시 적립(수동적립)</li>
							<li>적립내역 페이지에서 [적립받기]를 선택하지 않은 경우에는 구매적립불가</li>
							<li>구매 e머니는 카테고리에 따라 차등 적립</li>
						</ul>
		
						<strong>※ 카테고리별 적립률 상세 (카테고리 미분류 상품 0.8% 적립)</strong>
						<ul class="txt_indent">
							<li class="no_bul">
								<div class="tb">
									<table>
										<colgroup>
											<col width="65%"><col width="30%">
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
												<td rowspan="5">0.3%</td>
											</tr>
											<tr>
												<td>패션/화장품</td>
											</tr>
											<tr>
												<td>가구/생활/건강</td>
											</tr>
											<tr>
												<td>모바일쿠폰,상품권</td>
											</tr>
											<tr>
												<td>기타</td>
											</tr>
										</tbody>
									</table>
								</div>
							</li>
							<li>적립대상쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제 시 구매건수는 1건이며, 구매금액은 통합 결제한 금액의 e머니 적립</li>
							<li>결제일로부터 10~30일간 취소/반품여부 확인 후 적립</li>
							<li>e머니는 최소 10점부터 적립되며 (구매금액 1,000원 이상), 1원 단위 e머니는 적립되지 않습니다. 
								<br>(예: 1,200원 결제 시 e머니 10점 적립)</li>
							<li>구매적립 e머니 유효기간: 적립가능 시점부터 최대 60일(기간경과 이후 적립불가)</li>
							<li>적립된 e머니는 e쿠폰 스토어에서 다양한 e쿠폰으로 교환 가능합니다.</li>
						</ul>
		
						<strong>상품권 및 e쿠폰 적립 상세</strong>
						<ul class="txt_indent">
							<li>적립가능 상품 (0.3% 적립): 문화상품권(해피머니, 컬쳐랜드), 도서상품권, 백화점상품권, 영화예매권, 국민관광 상품권</li>
							<li>적립가능 상품을 제외한 상품권, 지역쿠폰, e교환권, e쿠폰은 적립불가</li>
							<li>상품권 적립가능 쇼핑몰: 티몬, G마켓, 옥션</li>						
						</ul>
												
						<strong>아래의 경우에는 구매 확인 및 적립이 불가합니다.</strong>
						<ul class="txt_indent">
							<li>에누리 가격비교 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱으로 결제만 한 경우<br>(에누리 가격비교 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)</li>
 							<li>에누리 가격비교 앱 미 로그인 후 구매한 경우 또는 에누리 가격비교 PC, 모바일 웹에서 구매한 경우</li>
						</ul>
						
						<strong>유의사항</strong>
						<ul class="txt_indent">
							<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
							<li>더블적립 대상자는 본 이벤트와 중복참여하실 수 없습니다.</li>
						</ul>
						<a href="#" class="btn_check_hide">확인</a>
					</div>
				</div>
				<!-- //첫구매 유의사항 -->
				
			</div>
			<!-- //유의사항 WRAPPER -->
				
		</div>
		<!-- //이벤트 02 -->

		<!-- 에누리 혜택 -->
		<div class="otherbene">
			<div class="contents">
				<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/christmas_pro/m_otherbene_tit.png" alt="에누리 혜택"></h2>
				<ul class="banlist">
					<li><a href="javascript:;" onclick="window.open('/mobilefirst/evt/visit_event.jsp?tab=1&freetoken=event');ga_log(16);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban1.png" alt="출석체크" /></a></li>
					<li><a href="javascript:;" onclick="window.open('/mobilefirst/evt/visit_event.jsp?tab=2&freetoken=event');ga_log(16);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban2.png" alt="매일룰렛" /></a></li>
					<li><a href="javascript:;" onclick="window.open('/mobilefirst/evt/welcome_event.jsp?tab=1&freetoken=event');ga_log(16);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban3.png" alt="첫구매혜택" /></a></li>
					<li><a href="javascript:;" onclick="window.open('/mobilefirst/evt/mobile_deal.jsp?freetoken=event');ga_log(16);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban4.png" alt="크레이지딜" /></a></li>
					<li><a href="javascript:;" onclick="window.open('/mobilefirst/evt/officeworker_2018.jsp?event_id=2018111600&amp;freetoken=event');ga_log(16);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban5.png" alt="직장공감" /></a></li>
					<li><a href="javascript:;" onclick="more_evt();ga_log(16);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban6.png" alt="더많은 이벤트" /></a></li>
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
				<br>에누리앱을 설치합니다.</p>
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
					<li>이벤트 경품: e5,100점, e10점</li>
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

	<!-- 당첨 레이어 -->
	<div id="prizes" class="layer_back" style="display: none;">
		<div class="dim"></div>
		<div class="vote_box">
			<div class="inner">
				<!-- 당첨 -->
				<img class="vote_img" src="http://imgenuri.enuri.gscdn.com/images/event/2018/christmas_pro/modal_result_success.png" alt="축하합니다 e머니 4,600점 적립! 내일 또 만나요~!">
				 
				<!-- 꽝
				<img class="vote_img" src="http://imgenuri.enuri.gscdn.com/images/event/2018/christmas_pro/modal_result_fail.png" alt="다음 기회에! e머니 5점 적립! 내일 또 만나요~!" />
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
				<ul class="new_product_list">
					<li>
						<a href="#">
							<div class="img_box">
								<!-- original size 266*266 -->
								<img src="http://imgenuri.enuri.gscdn.com/images/event/2017/newsemester/new_test.jpg" alt="">
							</div>
							<div class="txt_box">
								<span class="n_ptit">상품명은이정도길이로해주셨으면좋겠어요!!!!</span>
								<div class="n_price">
									<span class="min stripe_layer">지금최저가</span>
									<span class="num"><strong>111,690</strong>원</span>
								</div>
							</div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="img_box">
								<!-- original size 266*266 -->
								<img src="http://imgenuri.enuri.gscdn.com/images/event/2017/newsemester/new_test.jpg" alt="">
							</div>
							<div class="txt_box">
								<span class="n_ptit">상품명은이정도길이로해주셨으면좋겠어요!!!!</span>
								<div class="n_price">
									<span class="min stripe_layer">지금최저가</span>
									<span class="num"><strong>111,690</strong>원</span>
								</div>
							</div>
						</a>
					</li>
				</ul>
			</div>
			<p class="btn_close"><button type="button" class="btn_confirm stripe_layer" onclick="onoff('completeJoin')">확인</button></p>
		</div>
	</div>
	<!-- //이벤트 응모완료 레이어 -->

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
var flow = "<%=flow%>";

//ga_log(1) - ga_log(14)
var ga_log;

(function (global, $) {
	// 상단 메뉴 스크롤 시, 고정
	var $nav = $('.floattab'),
		$menu = $('.floattab__list li'),
		$contents = $('.scroll'),
		$navheight = $nav.outerHeight(); // 상단 메뉴 높이
		$navtop = Math.ceil($nav.offset().top); // floattab 현재 위치;

	$(function () {
		// 해당 섹션으로 스크롤 이동 
		$menu.on('click', 'a', function (e) {
			var $target = $(this).parent(),
				idx = $target.index(),
				offsetTop = Math.ceil($contents.eq(idx).offset().top - $navheight);

			// 페이지 이동
			$('html, body').stop().animate({ scrollTop: offsetTop}, 500);
			return false;
		});
		
	});
	
	// menu class 추가 
	$(window).scroll(function(){  
		var $scltop = Math.ceil($(window).scrollTop());	// 현재 scroll
		if ($scltop > $navtop) {
			$nav.addClass("is-fixed");
			$(".visual").css("margin-bottom", $navheight);
			$('.win_close').css({ "top": $navheight + 7});
		}else{
			$nav.removeClass("is-fixed");
			//$menu.children("a").removeClass('is-on'); 
			$(".visual").css("margin-bottom", 0);
		}
		
		if($scltop < $navtop){
			$('.win_close').css({ "top": "40px"});
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
				//$menu.children("a").removeClass('is-on'); 
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

// 유의사항 드롭다운
$('.btn_check').click(function(){
	var _this = $(this);
	_this.siblings(".moreview").toggle();
	
	$(".btn_check_hide").click(function(){
		$(this).parents(".moreview").slideUp();
		$('html,body').stop().animate({scrollTop:_this.offset().top});
		return false;
	});
	
	return false;
});

$(document).ready(function(){
	Kakao.init('5cad223fb57213402d8f90de1aa27301');
	$("#snslayer li").unbind();
	$("#snslayer li").click(function(){
		var shareUrl = "http://" + location.host + "/mobilefirst/evt/christmas_pro_2018.jsp";
		var shareTitle = "[에누리 가격비교]\n행복가득 크리스마스!\n특별한 혜택을 받고싶다면\n에누리로 와~\n";
		var idx = $(this).index();
		console.log("idx>"+idx);
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
				"상품탭_키즈",
				"상품탭_연인",
				"상품탭_셀프",
				"e쿠폰",
				"인테리어",
				"신년",
				"상품클릭",
				"기획전 상품더보기",
				"기획전보러가기",
				"이벤트2응모하기",
				"구매응모 상품클릭",
				"에누리혜택"
		];
		var vEvent_title = "2018 크리스마스 프로모션";

		function innerCall (param) {
			if ( param == 1 ) {
				ga('send', 'pageview', {'page': vEvent_page,'title': vEvent_title + " > " + "PV"});
			} else {
				ga('send', 'event', 'mf_event', vEvent_title, vEvent_title + " > " + gaLabel[param-1]);
			}
		}

		return innerCall;
	}
	
	da_log = daCall();
	
	function daCall () {
		var daLabel = [
				"PV",
				"이벤트1참여",
				"기획전 상품클릭",
				"기획전 상품더보기",
				"기획전 보러가기",
				"응모하기",
		];
		var vEvent_title = "2018 월동이벤트 ";

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

var ajaxUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=23";
/*if(location.host.indexOf("dev.enuri.com") > -1) {
	ajaxUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=21";
}*/

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
	if(flow == "ad") ad_log(1);
	else ga_log(1);
	
	$(function(){
		$(".socks__list li").hover(function(){
			$(this).addClass("stop").animate({scale: "+=0.12"}, 100);
		}, function(){
			$(this).removeClass("stop");
		})
	});
	
	var $evtbtn = $(".socks__list li"), // 양말
		$evtresult = $(".evt__result"); // 결과화면
	
	//양말선택
	$evtbtn.on("click", function(){
		if(flow == "ad") ad_log(2);
		else ga_log(4);
		
		getEventAjaxData( {"procCode":1} , function(data) {
			var result = data.result;
			var vVote_img = "";
			var result_img = "";
			var vVote_alt = "";
			var result_alt = "";
			if(result >= 5){
				if(result == 5100){
					vVote_img += "http://imgenuri.enuri.gscdn.com/images/event/2018/christmas_pro/modal_result_success.png";
					vVote_alt = "축하합니다 e머니 5,100점 적립! 내일 또 만나요~!";
					$evtresult.find(".evt--success").show();
					$evtresult.find(".evt--fail").hide();
                }else if(result == 5){
					vVote_img += "http://imgenuri.enuri.gscdn.com/images/event/2018/christmas_pro/modal_result_fail.png";
					vVote_alt = "다음 기회에! e머니 5점 적립! 내일 또 만나요~!";
					$evtresult.find(".evt--success").hide();
					$evtresult.find(".evt--fail").show();
                } 
				$(".vote_img").attr("src", vVote_img);
				$(".vote_img").attr("alt", vVote_alt);
				
				
				$(".socks").fadeOut();
				$evtresult.fadeIn(1000, function(){ // 당첨 결과 보여줌.
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
		if(flow == "ad") ad_log(6);
		else ga_log(14);
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
			 				html+= "	<a href=\"javascript:;\" onclick=\"window.open('/mobilefirst/detail.jsp?modelno="+modelno+"&freetoken=vip');ga_log(15);\" title=\"새 탭에서 열립니다.\">";
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
		if(flow == "ad") ad_log(5);
		else ga_log(13);
		window.open('/mobilefirst/event2018/xmas_2018_exh.jsp');
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
		if(sdt < "20181205"){
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
		$.post("/mobilefirst/evt/ajax/christmas2018_setlist.jsp" , $.extend({sdt : "<%=sdt%>" , osType : getOsType()}, param),
				callback, "json")
			.done(function(){
				isClick = true;
			});
	}

	function eventCommonChk(){
		var sdt="<%=sdt%>";
		var endDate = "20181225";
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
		var tapList = ["키즈선물","연인선물","셀프선물","E쿠폰","인테리어","신년선물"];
		var html = "";
		var tapGoodsArray = new Array();
		
		//새로고침 시마다 탭 랜덤 선택
	    var rdm = Math.floor(Math.random() * 5);
		
		var is_on = "";
		for(var i=0;i<tapList.length;i++){
			if(i==rdm) is_on = "is-on";
			else is_on = "";
			
			html +="<li>";
			html +="	<a id=\""+i+"\" class=\""+is_on+"\" href=\"javascript:///\" onclick=\"ga_log("+(i+5)+");\">"+tapList[i]+"</a>";
			html +="</li>";
		}
		
		$("#pro_itemlist_ul").html(html);
		
		loadGoodsList(ajaxData[rdm+1]);
		
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
				html+= "	<a href=\"javascript:;\" onclick=\"window.open('/mobilefirst/detail.jsp?modelno="+modelno+"&freetoken=vip');clickGa(1);\" title=\"새 탭에서 열립니다.\">";
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
		
		}
		
		var tapIndex = $("#pro_itemlist_ul li .is-on").attr("id");
		var tapList = ["1","2","3","4","5","6"];
		var goods_more = "/mobilefirst/event2018/xmas_2018_exh.jsp?tab=contArea"+tapList[tapIndex]+"&freetoken=event";
		
		$("#goods_btn_more").unbind();
		$("#goods_btn_more").click(function(){
			window.open(goods_more);
			if(flow == "ad") ad_log(4);
			else ga_log(12);
		});
		
		if(tapType!='') {
			//location.href = "#"+tapType;
		}
	}
};

function clickGa(type){
	if(type==1){
		if(flow == "ad") ad_log(3);
		else ga_log(11)
	}
}

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
		$('html, body').animate({scrollTop: Math.ceil($('#'+tapType).offset().top-$(".floattab__list").height())}, 1000);
		
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
