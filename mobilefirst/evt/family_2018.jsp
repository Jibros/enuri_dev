<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
String browser = request.getHeader("User-Agent");

if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1 
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1 
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){

}else{
	response.sendRedirect("/event2018/family_2018.jsp");	//pc url 
}
String chkId   = ChkNull.chkStr(request.getParameter("chk_id"),"");
String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

Members_Proc members_proc = new Members_Proc();
String cUsername = members_proc.getUserName(cUserId);
String userArea = cUsername;

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;

    if(cUsername.equals("")) userArea = cUserNick;
    if(userArea.equals(""))  userArea = cUserId;
}

SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");	//오늘 날짜
String strToday = formatter.format(new Date());
String sdt = ChkNull.chkStr(request.getParameter("sdt"));

if(!"".equals(sdt) && request.getServerName().equals("dev.enuri.com")){
	strToday = sdt;
}

String strUrl = request.getRequestURI();
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/familymonth_m.css"/>
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/lib/animate.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="http://m.enuri.com/mobilefirst/css/lib/slick.css"/>
	<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/common/js/function.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
</head>
<body>

<div class="wrap">

	<div class="myarea">
	<%if(cUserId.equals("")){%>	
	<p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>	
	<%}else{%>
	<p class="name"><%=userArea%> 님<span id="my_emoney">0점</span></p>
	<%}%>
	<a href="javascript:;" class="win_close">창닫기</a>
	</div>
	
	<!-- 상단비주얼 -->
	<div class="visual">
		<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_visual.png" alt="행복한 5월 가정의 달" class="imgs" />
	</div>

	
	<!-- floattab__list -->
	<div  class="floattab__list">
		<div class="scrollList">
			<ul class="floatmove">
				<li><a href="#evt1" class="floattab__item floattab__item--01 is-on"><em>이벤트혜택</em></a></li>
				<li><a href="#evt2" class="floattab__item floattab__item--02"><em>아이선물</em></a></li>
				<li><a href="#evt3" class="floattab__item floattab__item--03"><em>부모님선물</em></a></li>
				<li><a href="#evt4" class="floattab__item floattab__item--04"><em>성인축하선물</em></a></li>
				<li><a href="#evt5" class="floattab__item floattab__item--05"><em>연휴즐길거리</em></a></li>
			</ul>
		</div>
		<a href="javascript:;" class="btn_tabmove"><em>탭 이동</em></a>		
	</div>
	<!-- //floattab__list -->

	
	
	<!-- 가정의달 이벤트 -->
	<div id="evt1" class="section promotionwrap">
		<div class="contents">
			<div class="promotion__head">
				<div class="promotion__tab">
					<ul class="promotiontab__list">
						<li><a href="#pm__tab1" class="promotiontab__item promotiontab__item--1 is-on">이벤트 01</a>
						<li><a href="#pm__tab2" class="promotiontab__item promotiontab__item--2">이벤트 02</a>
					</ul>
				</div>
			</div>
			
			<div class="promotion__cont">
				<!-- 이벤트 1 -->
				<div id="pm__tab1" class="pm__tab">						
					<h2 class="pm__tab1--tit">무슨 꽃이게? 카네이션 피면 투썸케익 드려요!</h2>
					
					<a href="#pm__tab2" class="arrow__evt arrow__evt--1">이벤트 2로</a>
					
					<div class="pmevt1box">
						<div class="pmevt1box__bg">씨씨 씨를 뿌리고~ 물물 물을 주었죠~♬</div>
						
						<!-- 
							선택 후 보이는 BG (default 비노출)							 
						-->
						<div class="result__bg result__bg--1">꽃길</div>
						<div class="result__bg result__bg--2">레드카펫</div>
						<div class="result__bg result__bg--3">새싹길</div>
						
						<span class="pmevt1box__icon icon--balloon">CLICK</span>
						<span id="spreadWater" class="pmevt1box__icon icon--spreadwater animated infinite swing">물 뿌리개</span>
						<div class="pmevt1box__icon icon--waters">
							<ul class="drops">
								<li class="drop step-1"></li>
								<li class="drop step-2"></li>
								<li class="drop step-3"></li>
								<li class="drop step-4"></li>
							</ul>
						</div>

					</div>
					
					<a href="#" class="btn__caution" onclick="onoff('notetxt1'); return false;">꼭 확인하세요</a>
				</div>
				<!-- //이벤트 1 -->
				
				<!-- 이벤트 2 -->
				<div id="pm__tab2" class="pm__tab" style="display:none;">
					<a href="#pm__tab1" class="arrow__evt arrow__evt--2">이벤트 2로</a>
					
					<div class="pmevt2box">
						<div class="blind">
							<h2>APP에서 혼수 구매하면 공기청정기 드려요!</h2>
							<p>많이 구매할수록 당첨확률 UP!</p>
							<ul>
								<li>샤오미 Mi Air 2명</li>
								<li>설빙 생딸기 초코 브레드 10명</li>
							</ul>
							<p>※ 해당 금액 상당의 e머니로 지급</p>
						</div>
						<a href="javascript:;" class="btn btn__category" id="btn_event2_app">앱에서 구매하기</a>
						<a href="javascript:;" class="btn btn__join" id="btn_event2">응모하기</a>
					</div>
					
					<ul class="pmevt2__info">
						<li>이벤트 참여 및 구매 기간 : 2018년 4월24일 ~ 5월 18일</li>
						<li>당첨자 발표 : 2018년 6월 29일 금요일  [에누리 APP > 이벤트/기획전 > 이벤트 당첨자 발표]</li>
						<li class="emp">응모 시 휴대폰번호 잘 못 기입했거나 연락이 되지 않아 발생하는 불이익에 대해서는 책임지지 않습니다.</li>
					</ul>
					
					<a href="javascript:;" class="btn__caution" onclick="onoff('notetxt2'); $(window).scrollTop(0); return false;">꼭 확인하세요</a>
				</div>
				<!-- //이벤트 2 -->
			</div>
		</div>
	</div>
	<!-- //가정의달 이벤트 -->

	<!-- layer--> 
	<div class="layer_back" id="app_only" style="display:none;">
		<div class="appLayer">
			<h4>모바일 앱 전용 이벤트</h4>
			<a href="javascript:;" class="close" onclick="$('#app_only').hide();">창닫기</a>
			<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
			<p class="btn_close"><button type="button" onclick="install_btt();">설치하기</button></p>
		</div>
	</div>

	<!-- 이벤트1 유의사항 --> 
	<div class="layer_back" id="notetxt1" style="display:none;">
		<div class="dim"></div>
		<div class="noteLayer">
			<h4>유의사항</h4>
			<a href="javascript:;" class="close" onclick="onoff('notetxt1');return false;">창닫기</a>

			<div class="inner">
				<ul class="txtlist">
					<li>ID당 1일 1회 참여 가능</li>
					<li>이벤트 경품: 투썸플레이스 밀키 베리 무스(e6,000점), e5점</li>
					<li>적립된 e머니는 e머니 스토어에서 다양한 e쿠폰상품으로 교환 가능합니다.</li> 
					<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
					<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다.</li>
				</ul>
			</div>
			<p class="btn_close"><button type="button" onclick="onoff('notetxt1');return false;">닫기</button></p>
		</div>
	</div>

	<!-- 이벤트2 유의사항 상단에서 열림 --> 
	<div class="layer_back nofix" id="notetxt2" style="display:none;">
		<div class="dim"></div>
		<div class="noteLayer no_fixed">
			<h4>유의사항</h4>
			<a href="javascript:;" class="close" onclick="onoff('notetxt2');return false;">창닫기</a>

			<div class="inner">
				<dl class="txtlist">
					<dt>이벤트/구매 기간 :</dt>
					<dd>2018년 4월 24일 ~ 5월 18일</dd>
				</dl>
				
				<dl class="txtlist">
					<dt>경품 : </dt>
					<dd>공기청정기 : 샤오미 Mi Air2 (1명 추첨) ※제세공과금 당첨자 부담</dd> 
					<dd>설빙 생딸기 초코 브레드 e머니 6,800점 (100명 추첨)</dd>
					<dd><strong class="emp">e머니 유효기간 : 적립일로부터 15일</strong></dd>
					<dd>적립된 e머니는 e쿠폰 스토어에서 다양한 e쿠폰으로 교환 가능합니다.<br /><u>※ 사정에 따라 경품이 변경될 수 있습니다.</u></dd>
				</dl>

				<dl class="txtlist">
					<dt>당첨자 발표 및 적립</dt>
					<dd>2018년 6월 29일 [APP 이벤트/기획전 탭 &gt; 이벤트 &gt; 당첨자 발표]</dd>
				</dl>
				
				<dl class="txtlist">
					<dt>이벤트 유의사항</dt>
					<dd>응모 시 이벤트 기간 내 해당 카테고리 상품 구매금액이 자동 합산됩니다.</dd>
					<dd><strong class="emp">응모 시 입력한 휴대폰번호로 개별연락 드리며 잘못된 정보 기입했거나 연락이 되지 않아 발생하는 불이익에 대해서는 책임지지 않습니다.</strong></dd>
				</dl>
					
				<dl class="txtlist">
					<dt>아래의 경우에는 구매 확인 및 적립이 불가합니다.</dt>
					<dd>에누리 가격비교 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱으로 결제만 한 경우<br />(에누리 가격비교 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)</dd>
					<dd>에누리 가격비교 앱 미 로그인 후 구매한 경우 또는 에누리 가격비교 PC, 모바일 웹에서 구매한 경우</dd>
				</dl>
				
				<dl class="txtlist">
					<dt>유의사항</dt>
					<dd>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</dd>
				</dl>
			</div>
			<p class="btn_close"><button type="button" onclick="onoff('notetxt2');return false;">닫기</button></p>
		</div>
	</div>


	<!-- 당첨 레이어 --> 
	<div class="voteResult_layer" id="prizes" style="display:none">
		<div class="inner_layer">
			<div class="cont_area">
				<div class="img_box" id="vote_img"></div>
				
				<a class="btn layclose" href="javascript:;" onclick="onoff('prizes'); return false;"><em>팝업 닫기</em></a>
			</div>
		</div>
	</div>

	<!-- 2018-03-12 이벤트 응모하기 레이어 --> 
	<div class="event_layer" id="eventJoin" style="display:none">
		<div class="inner_layer">
			<div class="head">
				<h2 class="p_tit stripe_layer">이벤트 응모하기</h2>
			</div>
			<h3 class="tit stripe_layer">참여해주셔서 감사합니다. 당첨 시 경품배송을 위해 정확한 정보를 입력해 주세요.</h3>
			<a href="javascript:;" class="stripe_layer close" onclick="onoff('eventJoin')">창닫기</a>

			<div class="viewer">
				<fieldset>
					<legend>경품 발송을 위한 정보 입력</legend>
					<label>
						<p>휴대폰번호</p>
						<input type="number" id="u_phone" name="event_phone" class="ipt_box" max="11" value="" placeholder="휴대폰 번호를 입력해 주세요" />
					</label>
					<div class="agree_chk">
						<span class="unchk" onclick="agreechk(this);"><input type="checkbox" id="chkagree" name="agreechk" value="Y">위 개인 정보 활용에 동의 합니다.</span>
						<a href="javascript:;" class="btn_detail stripe_layer" onclick="onoff('privacy')">자세히보기</a>
					</div>
				</fieldset>
			</div>
			<p class="btn_close"><button type="button" id="btn_event2_ok" class="stripe_layer complete">응모완료</button></p>

			<p class="caution_info stripe_layer">
				<strong>꼭 알아두세요!</strong>
				입력하신 정보는 당첨자의 확인 및 경품 발송을 위해서만 이용 후 파기합니다.<br />잘못된 정보 입력으로 인한 경품 수령의 불이익은 책임지지 않습니다
			</p>
		</div>
	</div>

	<!-- 2018-03-12 개인정보 수집 이용안내 레이어 --> 
	<div class="event_layer" id="privacy" style="display:none">
		<div class="inner_layer privacy">
			<h3 class="tit stripe_layer">개인정보 수집·이용안내</h3>
			<a href="javascript:;" class="stripe_layer close" onclick="onoff('privacy')">창닫기</a>

			<div class="viewer">
				<!-- 개인정보 -->
				<div class="privacy__area">
					<p>에누리 가격비교는 이벤트 참여확인 및 경품 발송을 위하여 아래와 같이 개인 정보를 수집하고 있습니다. </p>
					<dl>
						<dt>1. 개인정보 수집 항목</dt>
						<dd>휴대폰 번호, 회원ID, 참여 일시</dd>
						<dt>2. 개인정보 수집 및 이용 목적</dt>
						<dd>이벤트를 위해 수집된 개인정보는 이벤트 참여확인 및 경품 발송을 위한 본인확인 이외의 목적으로 활용되지 않습니다.</dd>
						<dt>3. 개인정보 보유 및 이용 기간</dt>
						<dd>개인 정보 수집자(에누리 가격비교)는 개인 정보의 수집 및 이용 목적이 달성되면 개인 정보를 즉시 파기합니다.</dd>
					</dl>
				</div>
				<!-- //개인정보 -->
			</div>
			<p class="btn_close"><button type="button" class="stripe_layer privacy__close" onclick="onoff('privacy')">닫기</button></p>
		</div>
	</div>
	<!-- Gift of Thanks -->
	<div class="bestWrap">
		<div class="contents">
			<div class="dw_tit">
				<h2 class="title">가정의 달 감사함을 가득 담아 준비한 선물</h2>
			</div>

			<!-- box_keyword -->
			<div class="box_keyword">
				<div class="txt_key">
					<a href="#kwd1" class="on">#게임기</a>
					<a href="#kwd2">#인라인,퀵보드</a>
					<a href="#kwd3">#안마,청정가전</a>
					<a href="#kwd4">#홍삼,건강식품</a>
					<a href="#kwd5">#장난감</a>
					<a href="#kwd6">#e쿠폰</a>
				</div>
			</div>
			<!-- //box_keyword -->

			<div class="dw_slide_wrap">
				
				<!-- 슬라이드 VIEW dw_wrap -->
				<div class="dw_wrap">
					<div id="dwSlide" class="dw_detail"></div>
				</div>
				<!-- //슬라이드 VIEW dw_wrap -->

				<!-- 슬라이드 LIST dw_list -->
				<div id="dwList" class="dw_list"></div>
				<!-- //슬라이드 LIST dw_list -->
			</div>

		</div>
	</div>
	<!-- //Gift of Thanks -->

	<!-- 탭 컨텐츠 id #evt2 / 사랑선물 -->
	<div id="evt2" class="giftWrap child">
		<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_gift_title1.png" class="imgs" alt="사랑스러운 우리아이를 위해 #사랑선물" /></h2>
		<!-- items_area -->
		<div class="items_area">
			<h3>아이들이 좋아하는 BEST 인기상품</h3>
			<ul class="itemlist"></ul>
		</div>
		<!-- items_area -->
	</div>
	<!-- //탭 컨텐츠 id #evt2 / 사랑선물 -->

	<!-- 탭 컨텐츠 id #evt3 / 감사선물 -->
		<div id="evt3" class="giftWrap parents">
			<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_gift_title2.png" class="imgs" alt="언제나 고마운 부모님께 감사의 마음을 담아 #감사선물" /></h2>
			<!-- items_area -->
			<div class="items_area">
				<h3>부모님이 좋아하는 BEST 인기상품</h3>
				<ul class="itemlist">	</ul>
			</div>
			<!-- items_area -->
		</div>
		<!-- //탭 컨텐츠 id #evt3 / 감사선물 -->


		<!-- 탭 컨텐츠 id #evt4 / 축하선물 -->
		<div id="evt4" class="giftWrap adult">
			<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_gift_title3.png" class="imgs" alt="진정한 성인이 된 것을 축하하는 #축하선물" /></h2>
			<!-- items_area -->
			<div class="items_area">
				<h3>성년기념 축하선물 BEST 인기상품</h3>
				<ul class="itemlist"></ul>
			</div>
			<!-- items_area -->
		</div>
		<!-- //탭 컨텐츠 id #evt4 / 축하선물 -->

	
		<!-- 탭 컨텐츠 id #evt5 / 즐길거리 -->
		<div id="evt5" class="giftWrap holiday">
			<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_gift_title4.png" class="imgs" alt="5월 가정의달 연휴 알차게 보내는 방법 #즐길거리" /></h2>
			<!-- items_area -->
			<div class="items_area">
				<h3>5월 연휴 알차게 보내는 방법</h3>
				<ul class="itemlist"></ul>
			</div>
			<!-- items_area -->
		</div>
		<!-- //탭 컨텐츠 id #evt5 / 즐길거리 -->
		<!-- 기획전 배너 -->
		<div class="rd_banner">
			<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_recomzone_tit.png" alt="가정의 달 기획전" /></h2>
			<ul class="evtbnr">
				<li><a href="/mobilefirst/planlist.jsp?t=B_20180508486486" target="_blank">
					<img class="thumb" src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/ban_market1.png" alt="가정의달 부모님효도선물" />
				</a></li>
				<li><a href="/mobilefirst/planlist.jsp?t=B_20180408135567" target="_blank">
					<img class="thumb" src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/ban_market2.png" alt="성년의날 꽃선물" />
				</a></li>
				<li><a href="/mobilefirst/planlist.jsp?t=B_20180406192100" target="_blank">
					<img class="thumb" src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/ban_market3.png" alt="가정의달,사랑을들려주세요" />
				</a></li>
				<li><a href="/mobilefirst/planlist.jsp?t=B_20180406180505" target="_blank">
					<img class="thumb" src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/ban_market4.png" alt="요즘HOT한 게임기 총~출동" />
				</a></li>
				<li><a href="/mobilefirst/planlist.jsp?t=B_20180419110325" target="_blank">
					<img class="thumb" src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/ban_market5.png" alt="가정의달,부모님화장품대전" />
				</a></li>
			</ul>
			<a href="javascript:;" class="total" onclick="onoff('layer_planlist')">전체+</a>
		</div>
		<!--// 기획전 배너 -->

		<!-- 기획전 스프레드 레이어 -->
		<div class="dim" id="layer_planlist" style="display: none;">
			<div class="planlist_view">
				<h2>추천기획전<a href="javascript:;" class="close" onclick="onoff('layer_planlist')">창닫기</a></h2>
				<div class="inner" style="height:500px;">
					<ul>
						<li onclick="location.href='/mobilefirst/planlist.jsp?t=B_20180508486486';">
							<img class="thumb" src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/ban_market1.png" alt="가정의달 부모님효도선물" />
						</li>
						<li onclick="location.href='/mobilefirst/planlist.jsp?t=B_20180408135567';">
							<img class="thumb" src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/ban_market2.png" alt="성년의날 꽃선물" />
						</li>
						<li onclick="location.href='/mobilefirst/planlist.jsp?t=B_20180406192100';">
							<img class="thumb" src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/ban_market3.png" alt="가정의달,사랑을들려주세요" />
						</li>
						<li onclick="location.href='/mobilefirst/planlist.jsp?t=B_20180406180505';">
							<img class="thumb" src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/ban_market4.png" alt="요즘HOT한 게임기 총~출동" />
						</li>
						<li onclick="location.href='/mobilefirst/planlist.jsp?t=B_20180419110325';">
							<img class="thumb" src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/ban_market5.png" alt="가정의달,부모님화장품대전" />
						</li>
					</ul>
				</div>
			</div>
		</div>
		<!-- //기획전 스프레드 레이어 -->


	<!-- 하단 상품 리스트 -->
	<div class="btitem_list">
		<h2 class="blind">하단 상품</h2>
		
		<div id="quick1" class="liveProduct"></div>
		<div id="quick2" class="liveProduct"></div>
		<div id="quick3" class="liveProduct"></div>
		<div id="quick4" class="liveProduct"></div>
	</div>
	<!-- //하단 상품 리스트 -->

	<!-- 에누리 혜택 -->
	<div class="otherbene">
		<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_tit.png" alt="에누리 혜택"></h2>
		<ul class="banlist">
			<li><a href="javascript:;" onclick="window.open('/mobilefirst/evt/visit_event.jsp?tab=1&freetoken=eventclone');"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban1.png" alt="출석체크" /></a></li>
			<li><a href="javascript:;" onclick="window.open('/mobilefirst/evt/visit_event.jsp?tab=2&freetoken=eventclone');"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban2.png" alt="매일룰렛" /></a></li>
			<li><a href="javascript:;" onclick="window.open('/mobilefirst/evt/welcome_event.jsp?tab=1&freetoken=eventclone');"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban3.png" alt="첫구매혜택" /></a></li>
			<li><a href="javascript:;" onclick="window.open('/mobilefirst/evt/mobile_deal.jsp?freetoken=eventclone');"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban4.png" alt="크레이지딜" /></a></li>
			<li><a href="javascript:;" onclick="window.open('/mobilefirst/evt/office_workers.jsp?event_id=2018033009&freetoken=eventclone');"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban5.png" alt="직장공감" /></a></li>
			<li><a href="javascript:;" onclick="more_evt();"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_otherbene_ban6.png" alt="더많은 이벤트" /></a></li>
		</ul>
	</div>
	<!-- //에누리 혜택 -->


	<span class="go_top"><a href="#" >TOP</a></span>

</div>

<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>

</body>
</html>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
<script>
var vOs_type = "";
var vEvent_page = "<%=strUrl%>"; //경로
var vChkId = "<%=chkId%>";
var app = getCookie("appYN"); //app인지 여부

if(app == "Y"){
	 if(navigator.userAgent.indexOf("Android") > -1){
		 vOs_type = "MAA"; 		
	 }else{
		 vOs_type = "MAI"; 				 
	 }
}else{	
	 if(navigator.userAgent.indexOf("Android") > -1){
		 vOs_type = "MWA"; 		
	 }else{
		 vOs_type = "MWI"; 				 
	 }
}

var ajaxUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=13";
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
var topjsonArray = new Array(); 
var midjsonArray = new Array();
var bottomjsonArray = new Array();
var topitemCateList =  ["게임기", "인라인,퀵보드", "안마기","홍삼,건강식품","장난감","e쿠폰"];
var miditemCateList =  ["사랑선물","감사선물","축하선물","즐길거리"];
var bottomitemCateList = ["게임기,게임SW","건강식품","디지털카메라","외식,상품권"];
var moreview = ["0408","1501","0242","164716"];

$(function(){ 
	ga('send', 'event', 'mf_event', '가정의달기획전', '전체PV');
	$(".btn_login").click(function(){
		goLogin();       
    });
    
	$(".box_keyword .txt_key a").click(function(){
		$(".box_keyword .txt_key a").removeClass("on");
		$(this).addClass("on");
		var jsonIndex = $(this).attr("href").replace("#kwd","");
		// Gift of Thanks 플리킹
		$('#dwSlide').slick('unslick');
		$('#dwList').slick('unslick');
		fn_topTap(topjsonArray[parseInt(jsonIndex)-1]);
	});
	
	if(ajaxData.length>0){
		$.each(ajaxData,function(index,listData){
			if(listData["TITLE2"] =="대표상품"){
				for(var i=0;i<topitemCateList.length;i++){
					if(topitemCateList[i]==listData["TITLE1"]){
						topjsonArray.push(listData);
					}
				}	
			}else if(listData["TITLE2"] =="선물탭"){
				for(var i=0;i<miditemCateList.length;i++){
					if(miditemCateList[i]==listData["TITLE1"]){
						midjsonArray.push(listData);
					}
				}	
			}else if(listData["TITLE2"] =="하단탭"){
				for(var i=0;i<bottomitemCateList.length;i++){
					if(bottomitemCateList[i]==listData["TITLE1"]){
						bottomjsonArray.push(listData);
					}
				}	
			}
		});
	}
	fn_topTap(topjsonArray[0]);
	fn_midTap(midjsonArray);
	fn_bottomTap(bottomjsonArray);
	
	$(".promotiontab__item").click(function(){
		$(".promotiontab__item").removeClass("is-on");
		$(this).addClass("is-on");
		
		$(".pm__tab").hide();
		$($(this).attr("href")).show();

		if($(this).hasClass("promotiontab__item--1")){
			ga('send', 'event', 'mf_event', '2018가정의달', '탭_이벤트1');
		}else{
			ga('send', 'event', 'mf_event', '2018가정의달', '탭_이벤트2');
		}

		return false;
	});
	$(".arrow__evt").click(function(){
		var curr = $(this).attr("href"),
			protab_item = ".promotiontab__item";
		
		$(protab_item).removeClass("is-on");
		if(curr === "#pm__tab2"){
			$(protab_item + "--2").addClass("is-on");	
			ga('send', 'event', 'mf_event', '2018가정의달', '이벤트2_전환');
		}else{
			$(protab_item + "--1").addClass("is-on");
			ga('send', 'event', 'mf_event', '2018가정의달', '이벤트1_전환');
		}
		
		
		$(".pm__tab").hide();
		$($(this).attr("href")).show();
		
		return false;
	});
	
	$("#spreadWater").click(function () {
		$(this).unbind("click");
		$(this).removeClass("animated infinite bounce").addClass("rotate");
		
		getEventAjaxData({"procCode":1}, function(data){
			var result = data.result;
			if(result >= 0) {
				var selected = 0;
				if(result == 5) {
					selected = Math.floor(Math.random()*2) + 2;
				} else if(result == 6000) {
					selected = 1;				
				}
				$(this).removeClass("animated infinite bounce").addClass("rotate");
				$(".drops .step-1").stop().delay(500).animate({"opacity": 1}, 400, function(){
					$(".drops .step-2").animate({"opacity": 1}, 400, function(){
						$(".drops .step-3").animate({"opacity": 1}, 400, function(){
							$(".drops .step-4").animate({"opacity": 1}, 400, function(){
								$(".pmevt1box__icon").fadeOut(300);
								$(".pmevt1box__bg").animate({"opacity": 0}, 500); // 기존  BG를 감추고, 
								$(".result__bg--" + selected).animate({"opacity": 1}, 2000, function(){ // 선택된 BG 노출됨.
									$("#prizes").fadeIn(300); // 레이어 팝업 열림
									getPoint();														
								}); 
							});
						})
					})
				});
				//$("#vote_img").html("<img src=\"http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_vote_img0"+selected+".png\" class=\"p_img\" alt=\"\">");

				var vVote_img = "";
				if(selected == "1"){
					vVote_img += "<img src=\"http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_vote_img01.png\" alt=\"투썸 플레이스 케잌 이미지\" class=\"p_img\" />";
					vVote_img += "<div class=\"result_txt blossom\"><p><strong>카네이션이 피었어요!</strong></p> 내일 또 만나요~</div>";
				}else if(selected == "2"){
					vVote_img += "<img src=\"http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_vote_img02.png\" alt=\"5점 적립\" class=\"p_img\" />";
					vVote_img += "<div class=\"result_txt blossom\"><p>꽃인 줄 알았는데 <br /> 꽃게가 자랐어요 ㅠ <br /><strong>사는게 꽃같네!</strong></p>내일 또 만나요~</div>";
				}else if(selected == "3"){
					vVote_img += "<img src=\"http://imgenuri.enuri.gscdn.com/images/event/2018/familymonth/m_vote_img03.png\" alt=\"5점 적립\" class=\"p_img\" />";
					vVote_img += "<div class=\"result_txt green\"><p><strong><%=cUserId %></strong> <br /> 꽃이 피었어요^^ <br />활짝 웃어보세요~</p>내일 또 만나요~</div>";
				} 
				
				$("#vote_img").html(vVote_img);
				
			} else if(result == -1){
				alert("이미 참여하셨습니다.\n내일 또 참여해주세요.");
				return;
			} else if(result == -2){
				alert("임직원은 참여 불가합니다.");
				return;
			}
		});
	});

	$("#btn_event2_app").click(function(){
		if(app =='Y'){
			location.href = "#evt2";
			return false;
		}else{
			$("#app_only").show();
			return false;
		}
	});
	
	$("#btn_event2").click(function(){
		if(!islogin()){
			alert("로그인 후 이용 가능합니다.");
			goLogin();
			return false;
		}else{
			if(app =='Y'){
				getEventAjaxData({"procCode":3}, function(data){
					var result = data.result;
					if(result == 1) {
						alert("이미 응모하셨습니다.\n앱에서 구매 시\n구매내역 자동 누적됩니다.");
						return false;
					}else if(result == 0) {
						$("#eventJoin").show();
					}
				});
			}else{
				$("#app_only").show();
				return false;
			}
		}
	});

	//앱에서 구매후 응모 파라미터
	var appBuyParams = function(){
		var uphone = $("#u_phone").val();
		var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;//전화번호 체크

		if(!uphone){
			alert("휴대폰 번호를 입력해주세요.");
			return false;
		}else if(!regExp.test(uphone)){
			alert("연락처를 정확히 입력해주세요");
			return false;
		}else if($("div.agree_chk > span").attr("class")=="unchk"){
			alert("경품 배송을 위해 개인정보 활용 동의해주세요");
			return false;
		}else{
			return {
				"procCode" : 2 ,
				uphone : uphone
			};
		}
	};
	
	$("#btn_event2_ok").click(function(){
		getEventAjaxData(appBuyParams, function(data){
			var result = data.result;
			if(result == -1) {
				alert("이미 응모하셨습니다.\n앱에서 구매 시\n구매내역 자동 누적됩니다.");
				$("#eventJoin").hide();
				return false;
			}else if(result == 1) {
				alert("응모가\n완료 되었습니다.");
				$("#eventJoin").hide();
				return false;
			}
		});
	});
	$(".bestWrap .contents .box_keyword .txt_key a").click(function(){
		ga('send', 'event', 'mf_event', '가정의달기획전', '감사선물_탭');
	});
	$("#dwSlide .d_item a").click(function(){
		ga('send', 'event', 'mf_event', '가정의달기획전', '감사선물_탭_대표상품');
	});
	$("#dwList .d_item").click(function(){
		ga('send', 'event', 'mf_event', '가정의달기획전', '감사선물_탭_상품썸네일');
	});
	$("#evt2 .items_area .itemlist li a").click(function(){
		ga('send', 'event', 'mf_event', '가정의달기획전', '아이_사랑선물');
	});
	$("#evt3 .items_area .itemlist li a").click(function(){
		ga('send', 'event', 'mf_event', '가정의달기획전', '부모님_감사선물');
	});
	$("#evt4 .items_area .itemlist li a").click(function(){
		ga('send', 'event', 'mf_event', '가정의달기획전', '성인_축하선물');
	});
	$("#evt5 .items_area .itemlist li a").click(function(){
		ga('send', 'event', 'mf_event', '가정의달기획전', '연휴_즐길거리');
	});
	$(".rd_banner .evtbnr a").click(function(){
		ga('send', 'event', 'mf_event', '가정의달기획전', 'CM기획전배너');
	});
	$("#quick1 a").click(function(){
		ga('send', 'event', 'mf_event', '가정의달기획전', '하단상품_게임기');
	});
	$("#quick2 a").click(function(){
		ga('send', 'event', 'mf_event', '가정의달기획전', '하단상품_건강식품');
	});
	$("#quick3 a").click(function(){
		ga('send', 'event', 'mf_event', '가정의달기획전', '하단상품_디지털카메라');
	});
	$("#quick4 a").click(function(){
		ga('send', 'event', 'mf_event', '가정의달기획전', '하단상품_외식,상품권');
	});
	$(".otherbene ul li a").click(function(){
		ga('send', 'event', 'mf_event', '가정의달기획전', '이벤트배너');
	});
	// 기획전 배너
	$('.evtbnr').slick({
	  dots: true,
	  arrows: false,
	  infinite: true,
	  speed: 300,
	  slidesToShow: 1,
	  adaptiveHeight: false,
	  autoplay: true,
	  autoplaySpeed: 3000
	});

	$(".rd_banner a.total").click(function(){
		$(".wrap a.win_close").css("display", "none");
	});

	//하단상품 리스트 플리킹
	$('.btitem_list .items_area').slick({
		dots:true,
		slidesToScroll: 1,
	});

	//플로팅 상단 탭 플리킹
	/*
	$('.floatmove').slick({
	  arrows:false,
	  dots:false,
	  infinite: false,
	  slidesToShow: 3,
	  slidesToScroll: 3
	});
	*/
	
	getPoint();

	//닫기버튼
	$( ".win_close" ).click(function(){
		if(app == 'Y'){
			window.location.href = "close://";
		}else{
			window.location.replace("/mobilefirst/Index.jsp");
		}
	});
});

$(window).load(function(){
	var $nav = $(".floattab__list"), // scroll tabs
		$navTop = $nav.offset().top;
		$myHgt = $(".myarea").height();


	//플로팅 상단 탭 이동
	$('.floattab__list ul li a').click(function(e) {
		var anchor=0;
		var currY = parseInt($(document).scrollTop()); // 현재 scroll
		ga('send', 'event', 'mf_event', '가정의달기획전', '무빙탭');
		if($(".floattab__list").hasClass("is-fixed")){
			anchor= $($(this).attr('href')).offset().top;
		}else{
			anchor= $($(this).attr('href')).offset().top-75;
		}	

		$('html, body').stop().animate({scrollTop: anchor}, 500);	
		e.preventDefault();
	});

	$ares1 = $("#evt1").offset().top - $nav.outerHeight(),
	$ares2 = $("#evt2").offset().top - $nav.outerHeight(),
	$ares3 = $("#evt3").offset().top - $nav.outerHeight();
	$ares4 = $("#evt4").offset().top - $nav.outerHeight();
	$ares5 = $("#evt5").offset().top - $nav.outerHeight();

	// 상단 탭 position 변경 및 버튼 활성화
	$(window).scroll(function(){
		var $currY = $(this).scrollTop() + $myHgt; // 현재 scroll
		var banner_market = $(".rd_banner").offset().top-$nav.outerHeight();

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
			}else if($ares5 <= $currY &&  $currY < banner_market){
				$nav.find("a").removeClass("is-on");
				$(".floattab__item--05").addClass("is-on");
				$(".scrollList").scrollLeft(300);
			}else if(banner_market < $currY){
				$nav.find("a").removeClass("is-on");
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

function getPoint(){
	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_point.jsp",
		async: false,
		dataType:"JSON",
		success: function(json){
			remain = json.POINT_REMAIN;	//적립금
			$("#my_emoney").html(numberWithCommas(remain) +""+json.POINT_UNIT);	
		}
	});
}

function numberWithCommas(x) {   return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");		}
function onoff(id) {var mid=document.getElementById(id);if(mid.style.display=='') 	mid.style.display='none';else mid.style.display='';}
function openLayer(IdName){	var pop = document.getElementById(IdName);	pop.style.display = "block";}
function closeLayer(IdName){	var pop = document.getElementById(IdName);		pop.style.display = "none";	}

var isClick = true;
function getEventAjaxData(params, callback){
	var sdt = "<%=strToday%>";
	if(sdt < "20180424"){
		alert('오픈예정입니다.');
		return false;
	}
	if(sdt > "20180518"){
		alert('이벤트가 종료되었습니다.');
		return false;
	}
	
	if(!islogin()){
		alert("로그인 후 이용 가능합니다.");
		goLogin();
		return false;
	}else{
		var evtUrl = "/mobilefirst/evt/ajax/family2018_setlist.jsp";
		if(typeof params === "object") {
			params.sdt = sdt;
			params.osType = vOs_type;

			$.post(evtUrl,params,callback,"json").done(function(){
				isClick = true;
			});
			
		}else if(typeof params === "function"){
			addParams = params();

			if(addParams){
				$.post(evtUrl , $.extend({sdt : "<%=sdt%>" , osType : vOs_type}, addParams),	callback, "json").done(function(){
					isClick = true;
				});
			}
		}
	    if(!isClick){
	    	return false;
	    }
	    isClick = false;
	}
}

function islogin() {
	var cName = "LSTATUS";
	var s = document.cookie.indexOf(cName +'=');
	if (s != -1){
		s += cName.length + 1;
		e = document.cookie.indexOf(';',s);
		if (e == -1){
			e 	= document.cookie.length;
		}
		if( unescape(document.cookie.substring(s,e))=="Y"){
			
			try {
				if(window.android){
						window.android.isLogin("true");
				}
			} catch(e) {}
			return true;
		}else{
			try {
				if(window.android){
					window.android.isLogin("false");
				}
			} catch(e) {}
			return false;
		}
	}else{
		try {
			if(window.android){
				window.android.isLogin("false");
			}	
		} catch(e) {}
		return false;
	}
}

//로그인페이지 이동
function goLogin(){
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        if(app =='Y'){
        	location.href = "/mobilefirst/login/login.jsp";          	
       }
        else{
        	location.href = "/mobilefirst/login/login.jsp?backUrl="+vEvent_page;          	
        }
    }else if(navigator.userAgent.indexOf("Android") > -1){
        location.href = "/mobilefirst/login/login.jsp?backUrl="+vEvent_page+"?freetoken=event&chk_id="+vChkId;
    }       
}

function getCookie(c_name) {
	var i,x,y,ARRcookies=document.cookie.split(";");
	for(i=0;i<ARRcookies.length;i++) {
		x = ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
		y = ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
		x = x.replace(/^\s+|\s+$/g,"");
		if(x==c_name) {
			return unescape(y);
		}
	}
}

/*레이어*/
function onoff(id){
	var mid = $("#"+id);
	if(mid.css("display") !== "none"){
		mid.css("display","none");
	}else{
		mid.css("display","");
	}
}
/*checkbox*/
function agreechk(obj){
	if (obj.className== 'unchk') {
		obj.className = 'chk';
	} else {
		obj.className = 'unchk';
	}
}

//기획전
function fn_topTap(jsonData){
	var slidehtml ="";
	var slidebottomHtml = "";
	//console.log(jsonData);
	var goodsList = jsonData["GOODS"];
	
	$("#dwSlide").html(null);
	$("#dwList").html(null);
	if(goodsList.length >0){
		$.each(goodsList,function(index,goodsData){
			var modelno = goodsData["MODELNO"];
			var goods_img = goodsData["GOODS_IMG"];
			var goods_title1 = goodsData["TITLE1"];
			var goods_title2 = goodsData["TITLE2"];
			var goods_minprice = goodsData["MINPRICE"];
			if(goods_minprice == 0){
				goods_minprice ="<b>품절</b>";
			}else{
				goods_minprice = "<b>"+goods_minprice.NumberFormat()+"</b>원";
			}	
			slidehtml+= "<div class=\"d_item\">";
			slidehtml+= "	<div class=\"_photo\">";
			slidehtml+= "		<div class=\"fade_list\">";
			slidehtml+= "			<a href=\"/mobilefirst/detail.jsp?modelno="+goodsData["MODELNO"]+"\" target=\"_blank\"><img src=\""+goodsData["GOODS_IMG"]+"\" alt=\"\" />";
			slidehtml+= "				<div class=\"pro_info\">";
			slidehtml+= "					<span class=\"title\">"+goodsData["TITLE1"]+"<br />"+goodsData["TITLE2"]+"</span>";
			slidehtml+= "					<span class=\"discount\">최저가 "+goods_minprice+"</span>";
			slidehtml+= "				</div>";
			slidehtml+= "			</a>";
			slidehtml+= "		</div>";
			slidehtml+= "	</div>";
			slidehtml+= "</div>";
			
			slidebottomHtml += "<div num=\""+index+"\" class=\"d_item active\">";
			slidebottomHtml += "	<div class=\"d_img\">";
			slidebottomHtml += "		<span class=\"cover\"></span>";
			slidebottomHtml += "		<img src=\""+goodsData["GOODS_IMG"]+"\" alt=\"\" />";
			slidebottomHtml += "	</div>";
			slidebottomHtml += "	<div class=\"d_name\">";
			slidebottomHtml += "		<span class=\"tit\">"+goodsData["TITLE1"]+"</span>";
			slidebottomHtml += "		<span class=\"price\">"+goods_minprice+"</span>";
			slidebottomHtml += "	</div>";
			slidebottomHtml += "</div>";
			
		});

		
		$("#dwSlide").html(slidehtml);
		$("#dwList").html(slidebottomHtml);
	
		$('#dwSlide').slick({
			slidesToShow: 1,
			slidesToScroll: 1,
			swipe: false,
			fade: true,
			dots: false,
			arrows: false,
			speed: 300,
			asNavFor: '#dwList'
			
						
		});

		$('#dwList').slick({
			initialSlide: 0,
			slidesToShow: 4,
			slidesToScroll: 1,
			swipe: false,
			fade: false,
			arrows: true,
			speed: 150,
			asNavFor: '#dwSlide',
			//centerMode: true,
			focusOnSelect: true
		});
	}
}
function fn_midTap(jsonData){
	//console.log(jsonData);
	$.each(jsonData,function(index,listData){
		var goodsList = listData["GOODS"];
		var html ="";
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
			 	if(goods_minprice == 0){
					goods_minprice ="<b>품절</b>";
				}else{
					goods_minprice = "<b>"+goods_minprice.NumberFormat()+"</b>원";
				}	 
				html+= "<li>";
				html+= "	<a href=\"/mobilefirst/detail.jsp?modelno="+goodsData["MODELNO"]+"\" target=\"_blank\" title=\"새 탭에서 열립니다.\" class=\"btn\">";
				html+= "		<div class=\"imgs\">";
				html+= "			<img src=\""+goodsData["GOODS_IMG"]+"\" alt=\"\" />";
				if(goodsData["MINPRICE"]==0){
				html+= "			<span class=\"soldout\">SOLD OUT</span>";	
				}
				html+= "		</div>";
				html+= "		<div class=\"info\">";
				html+= "			<p class=\"pname\">"+goodsData["TITLE1"]+"<br />"+goodsData["TITLE2"]+"</p>";
				html+= "			<p class=\"price\"><span class=\"lowst\">최저가</span>"+goods_minprice+"</p>";
				html+= "		</div>";
				html+= "	</a>";
				html+= "</li>";	
			}
			$("#evt"+(index+2)+" .itemlist").html(html);
		}
	});
}
function fn_bottomTap(jsonData){
	//console.log(jsonData);
	
	$.each(jsonData,function(index,listData){
		var tagData = listData["TAGS"];
		var html = "";
		var tagHtml ="";
		var goodsList = listData["GOODS"];
		var srpkeyword;
		for(var i=0;i<tagData.length;i++){
			if(i>1){
				break;
			}
			srpkeyword = tagData[i]["KEYWORD"];
			if(srpkeyword.indexOf("#") > -1){
				srpkeyword = srpkeyword.replace("#","");
			}
			tagHtml += " 		<li><a href=\"javascript:;\" onclick=\"window.open('/mobilefirst/search.jsp?keyword="+srpkeyword+"&freetoken=list');\" >"+tagData[i]["KEYWORD"]+"</a></li>";
		}
		html+=" <h3>"+listData["TITLE1"];
		html+=" 	<ul class=\"pp_tabs\">";
		html+= 		tagHtml;
		html+=" 	</ul>";
		html+=" </h3>";
		html+="	<div class=\"tab_container\">";
		html+="		<div id=\"tab1\" class=\"tab_content\">";
		html+="			<div class=\"lp_tabs_cont\">";
		html+="				<div class=\"items_area\">";

	
		
		if(goodsList.length>0){
			var goodsData;
			var modelno;
			var goods_img;
			var goods_title1;
			var goods_title2;
			var goods_minprice;
			
			for(var i=0;i<goodsList.length;i++){
				goodsData = goodsList[i];
				modelno = goodsData["MODELNO"];
				goods_img = goodsData["GOODS_IMG"];
				goods_title1 = goodsData["TITLE1"];
				goods_title2 = goodsData["TITLE2"];
				goods_minprice = goodsData["MINPRICE"];

				if(i%4==0){
					html+="					<div class=\"itembox\">";
					html+="						<ul class=\"itemlist\">";
				}
				
				if(goods_minprice == 0){
					goods_minprice ="<b>품절</b>";
				}else{
					goods_minprice = "<b>"+goods_minprice.NumberFormat()+"</b>원	";
				}	

				html+="							<li>";
				html+="								<a href=\"javascript:;\" onclick=\"window.open('/mobilefirst/detail.jsp?modelno="+goodsData["MODELNO"]+"&freetoken=vip');\" class=\"btn\">";
				html+="									<div class=\"imgs\">";
				html+="										<img src=\""+ goodsData["GOODS_IMG"] +"\" />";
				html+="									</div>";
				html+="									<div class=\"info\">";
				html+="										<p class=\"pname\">"+goodsData["TITLE1"]+"</p>";
				html+="										<p class=\"price\"><span class=\"lowst\">최저가</span>"+goods_minprice+"</p>";
				html+="									</div>";
				html+="								</a>";
				html+="							</li>";
				
				if(i%4==3){
					html+="							</ul>";
					html+="						 </div>";
				}
			
			}
		}

		html+="				 </div>";
		html+="			</div>";
		html+="			<p class=\"moreview\"><a href=\"javascript:;\" onclick=\"window.open('/mobilefirst/list.jsp?cate="+ moreview[index] +"&freetoken=list');\" class=\"btn_promore\">상품 더보기</a></p>";
		html+="		</div>";
		html+="	</div>";
		
		$("#quick"+(index+1)).html(null);
		$("#quick"+(index+1)).html(html);
	});
	
}

function more_evt(){
	if( getCookie("appYN") != "Y"){
		vUrl = "/mobilefirst/index.jsp#evt";
	}else{
		vUrl = "/mobilefirst/renew/plan.jsp?freetoken=main_tab|event";
	}
	window.open(vUrl);
}

//앱설치버튼
function install_btt(){

	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8';
    }else if(navigator.userAgent.indexOf("Android") > -1){
    	window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
    }
}

</script>