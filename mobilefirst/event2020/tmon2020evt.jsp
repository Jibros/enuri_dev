<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
String strFb_title = "[에누리 가격비교] 누구나, 티몬에서 쇼핑하면";
String strFb_description = "참깨라면 1,000명 당첨!";
String strFb_img = ConfigManager.IMG_ENURI_COM+"/images/event/2020/tmon_goods/tmonsns_1200_630_1.jpg";

if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{ //pc일때 접속페이지 변경.
	response.sendRedirect("/event2020/tmon2020evt.jsp");
	return;
}

String chkId     = ChkNull.chkStr(request.getParameter("chk_id"),"");
String cUserId   = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK"),"");

Members_Proc members_proc = new Members_Proc();
String cUsername = members_proc.getUserName(cUserId);
String userArea = cUsername;

String strUrl = request.getRequestURI();

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;

    if(cUsername.equals(""))        userArea = cUserNick;
    if(userArea.equals(""))        userArea = cUserId;
}
String tab = ChkNull.chkStr(request.getParameter("tab"),"");
String flow = ChkNull.chkStr(request.getParameter("flow"));

SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");	//오늘 날짜
String strToday = formatter.format(new Date());
String sdt = ChkNull.chkStr(request.getParameter("sdt"));

if(!"".equals(sdt) && request.getServerName().equals("dev.enuri.com")){
	strToday = sdt;
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<META NAME="description" CONTENT="<%=strFb_description%>">
	<META NAME="keyword" CONTENT="에누리가격비교, 프로모션, 티몬">
	<meta property="og:title" content="<%=strFb_title%>">
	<meta property="og:description" content="<%=strFb_description%>">
	<meta property="og:image" content="<%=strFb_img%>">
	<meta name="format-detection" content="telephone=no" />
	<!-- 프로모션 공통 CSS (Mobile) -->
	<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
	<link rel="stylesheet" href="/css/event/y2020/tmon_goods_m.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/js/swiper.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
	<script type="text/javascript" src="/common/js/function.js"></script>
</head>
<body>
<div id="eventWrap">
	<div class="myarea">
		<p class="name">나의 <em class="emy">머니</em>는 얼마일까?<button type="button" class="btn_login" onclick="goLogin();">로그인</button></p>
		<a href="javascript:///" class="win_close">창닫기</a>
	</div>
	
	<!-- 비쥬얼 -->
	<div class="toparea">

		<!-- 상단비주얼 -->		
		<div class="visual">
			<div class="inner">
                <!-- 200330 추가 : 공통 : 공유하기 버튼  -->
                <button class="com__btn_share btn_black" onclick="$('.com__share_wrap').show();">공유하기</button>
                <!-- // -->
                
                <span class="txt_01">누구나, 티몬에서 쇼핑하면</span>
                <h2 class="tit_01">참깨라면 1,000명 당첨</h2>
                <span class="bar"><!-- 막대바 --></span>
            
				<div class="img_goods">참깨라면 이미지</div>
                
                <a href="javascript:///" class="btn_apply" >구매 후 응모하기</a>
            </div>
            <div class="loader-box">
                <div class="visual-loader"></div>
            </div>
            <script>
                // 상단 타이틀 등장 모션
                $(window).load(function(){
                    var $visual = $(".toparea .visual");
                    $visual.addClass("intro");
                    setTimeout(function(){
                        $visual.addClass("end");
                    },2500);
                })
            </script>
		</div>
	</div>
	<!-- //비쥬얼 -->
	

	<!-- 유의사항 -->
	<div class="section evt_notice">
		<div class="inner">
			<ul>
				<li>이벤트기간: 5월 7일 ~ 6월 3일</li>
				<li>당첨자 발표일: 7월 20일</li>
				<li><span class="blk">참여방법:</span>에누리 로그인 &gt; 본 이벤트 페이지 내 티몬 상품 구입 &gt; 구매 후 응모</li>
				<li>이벤트 경품: 오뚜기 참깨라면 1,000명 당첨 (e머니 1,200점)</li> 
			</ul>
		</div>
		<!-- 버튼 : 꼭 확인하세요 -->
		<div class="com__evt_notice btn__white">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop1"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop1" class="evt_notice--slide">
			<div class="evt_notice--inner">
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="txt">
						<strong>이벤트 및 구매기간</strong>
						<ul class="txt_indent">
							<li>2020년 5월 7일 ~ 2020년 6월 3일</li>
						</ul>
						<strong>이벤트 참여방법 및 유의사항</strong>
                        <ul class="txt_indent">                            
                            <li>참여방법 : 에누리 로그인 &gt; 본 이벤트 페이지 내 티몬 상품 구입 &gt; 구매 후 응모</li>
                            <li>본인인증 및 로그인하지 않거나 에누리를 경유하지 않은 경우 적립불가</li>
                            <li>티몬 이외의 쇼핑몰에서 구매시 응모 불가</li>
                            <li>이벤트 기간 내 1회 응모 가능</li>
						</ul>
						<strong>이벤트 경품</strong>
                        <ul class="txt_indent">               
							<!-- 200506 당첨자 수 변경 (100명에서 1,000명) -->             
                            <li>이벤트 경품 : 오뚜기 참깨라면 1,000명 추첨 증정 (e머니 1,200점)</li>
                            <li><span class="stress">e머니 유효기간: 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span></li>
                            <li>경품은 e쿠폰으로 교환 가능한 e머니로 적립되며, e쿠폰 스토어에서 교환 가능</li>
                            <li class="no_dot">※ 경품은 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격변동이 있을 수 있음</li>
						</ul>
						<strong>당첨자 발표 및 경품지급일</strong>
                        <ul class="txt_indent">                            
                            <li>당첨자 발표일: 2020년 7월 20일</li>
                            <li>당첨자 공지: 에누리 앱 &gt; 이벤트/기획전탭 &gt; 이벤트혜택 &gt; 하단 ‘당첨자 발표’에 공지</li>
						</ul>
						<strong>이벤트 유의사항</strong>
                        <ul class="txt_indent">                            
                            <li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품의 실제 결제금액만 반영됨</li>
                            <li>본인인증 후 구매시에만 적립가능</li>
                            <li>구매후 취소/환불/반품한 경우 적립불가</li>
                            <li>적립대상쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제 시 구매건수는 1건이며, 구매금액은 통합 결제한 금액의 e머니 적립</li>
                            <li>e머니는 최소 10점부터 적립되며 (구매금액 1,000원 이상), 1원 단위 e머니는 적립되지 않습니다. (예: 1,200원 결제 시 e머니 10점 적립)</li>
						</ul>
						<ul class="txt_indent">                            
                            <li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품의 실제 결제금액만 반영됨</li>
                            <li>본인인증 후 구매시에만 적립가능</li>
                            <li>구매후 취소/환불/반품한 경우 적립불가</li>
                            <li>적립대상쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제 시 구매건수는 1건이며, 구매금액은 통합 결제한 금액의 e머니 적립</li>
                            <li>e머니는 최소 10점부터 적립되며 (구매금액 1,000원 이상), 1원 단위 e머니는 적립되지 않습니다. (예: 1,200원 결제 시 e머니 10점 적립)</li>
						</ul>
						<strong>e머니 구매 적립 제외 상품</strong>
						<ul class="txt_indent">    
							<li>티몬: 슈퍼꿀딜, 슈퍼마트 등 특가 판매 상품, 모바일쿠폰/상품권(일부 상품권 적립가능)</li>
							<li>※ 적립가능 모바일쿠폰/상품권 (0.2% 적립): 문화상품권(해피머니, 컬쳐랜드), 도서상품권, 백화점상품권, 영화예매권, 국민관광 상품권</li>
							<li>※ 적립가능 모바일쿠폰/상품권을 제외한 상품권, 지역쿠폰, e교환권, e쿠폰은 적립불가</li>
							<li>※ 백화점 상품권 적립기준</br>
								1) 상품명에 ＇백화점 상품권＇ 명시된 상품 또는 백화점에서만 사용할 수 있는 상품권만 적립</br>
								2) 복합상품권 적립불가(삼성 상품권/신세계 기프트카드/롯데카드 상품권/이랜드 상품권/AK플라자 상품권/통합 상품권 등)</br>
								3) 복합 상품권의 경우 사용처에 백화점이 기재되어 있는 경우에도 적립불가</br>
								4) 백화점 상품권으로 전환 가능한 포인트 구매시 적립불가
							</li>
						</ul>
						<strong>유의사항</strong>
                        <ul class="txt_indent">                            
                            <li>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</li>
                            <li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
						</ul>
                    </div>
					
				</div>
				<div class="evt_notice--foot">						
					<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 유의사항 닫기 -->
				</div>
			</div>
		</div>
		<script>
			// 유의사항 열기/닫기
			$(function(){
				var el = {
					btnSlide: $(".btn__evt_notice"), // 열기 버튼
					btnSlideClose : $(".btn__evt_confirm") // 닫기 버튼
				}
				el.btnSlide.click(function(){ // 슬라이드 유의사항 열기
					$(this).toggleClass('on');
					$("#"+$(this).attr("data-laypop-id")).slideToggle();
				})
				el.btnSlideClose.click(function(){ // 슬라이드 유의사항 닫기
					el.btnSlide.click();
				})
			})
		</script>
	</div>
	<!-- // -->
	
	<!-- 상품 영역 -->
	<div class="goods_wrap">
		<!-- 대메뉴 플로팅 탭 -->
		<div class="floattab">
			<div class="floattab__list">
				<div class="scrollList">
					<ul class="floatmove">						
						<li><a href="#protab1" class="floattab__item floattab__item--01"><em>식품</em></a></li>
						<li><a href="#protab2" class="floattab__item floattab__item--02"><em>생활</em></a></li>
						<li><a href="#protab3" class="floattab__item floattab__item--03"><em>패션</em></a></li>
						<li><a href="#protab4" class="floattab__item floattab__item--04"><em>유아</em></a></li>
                        <li><a href="#protab5" class="floattab__item floattab__item--05"><em>화장품</em></a></li>
                        <li><a href="#protab6" class="floattab__item floattab__item--06"><em>e쿠폰</em></a></li>
					</ul>
				</div>
				<a href="javascript:///" class="btn_tabmove next"><em>탭 이동</em></a>
			</div>
		</div>
		<script>
			/*
			$(window).load(function(){
				var posScr = new Array(),
					$nav = $(".floattab__list"), // scroll tabs
					$scrList = $(".scrollList");
				
				$scrList.on("scroll", function(){
					var st = $scrList.scrollLeft();
					if (st >= $nav.find("li").eq(0).width() * 1 - 30) {
						$(".btn_tabmove").removeClass("next").addClass("prev");
					}else {
						$(".btn_tabmove").removeClass("prev").addClass("next");
					}
				});
			});
			*/
		</script>
		<!-- /탭 -->

		<!-- 상단탭 상품 컨테이너 -->
		<div class="goods_container">
			<!--
				[D] 
				SLICK : $(".itemlist")
				하나의 콘텐츠마다 ul 단위로 한 판(상품4개)씩 움직입니다. 	
				
				#goods1 ~ 6 영역은 반복됩니다.  ★ #goods1 마크업만 참고하시면 됩니다.
				ex) 상단탭 상품 컨텐츠(식품)

				[[[[[상품 영역]]]]]
				DEPTH
				.floattab__list                                     - 6개 탭 목록
				.goods_container                                    - 6개 탭 컨테이너(대메뉴)
					.goods_content#goods1 ~ 6                       - 6개 탭 컨텐츠

						.pro_tags                                   - 해시태그
						.tab_container                              - 컨테이너
							.tab_content                            - 추천상품 컨텐츠
								.itemlist                           - 각 상품 목록 (2*2)
			-->
			<!-- 상단탭 상품 컨텐츠(식품) -->
			<div id="goods1" class="goods_content">
				<!-- 추천상품 해시태그 -->
				<ul class="pro_tags">
					<li><span>#슬기로운</span></li>
					<li><span>#에누리생활</span></li>
					<li><span>#혜택챙겨</span></li>
					<li><span>#FLEX누려</span></li>
				</ul>
				<!-- //추천상품 해시태그 -->

				<!-- 추천상품 템플릿 -->
				<div class="tab_container">
					<!-- 추천상품-->
					<div class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix"></ul>
						</div>
					</div>
					<!-- //추천상품-->
				</div>
				<!-- //추천상품 템플릿 -->
			</div>
			<!-- //상단탭 상품 컨텐츠(식품) -->
		</div>
		<!-- //상단탭 상품 컨테이너 -->
	</div>
	<!-- // 상품 영역-->
	<!-- 이벤트02 -->
	<div id="evt2" class="section event_02 scroll"> <!-- 이벤트 2 앵커 영역 -->
		<div class="evt_box">
			<h3>티몬 구매하고 e머니 적립받기</h3>
			<div class="evt_cnt">
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<img src="http://img.enuri.info/images/event/2020/tmon/m_slide_01.jpg" alt="STEP1 - 에누리 로그인 후 티몬 이동하기">
						</div>
						<div class="swiper-slide">
							<img src="http://img.enuri.info/images/event/2020/tmon/m_slide_02.jpg" alt="STEP2 - 티몬에서 상품 구매하기">
						</div>
						<div class="swiper-slide">
							<img src="http://img.enuri.info/images/event/2020/tmon/m_slide_03.jpg" alt="STEP3 - 구매금액의 최대 1.5% e머니 적립">
						</div>
						<div class="swiper-slide">
							<img src="http://img.enuri.info/images/event/2020/tmon/m_slide_04.jpg" alt="STEP4 - e쿠폰 스토어에서 1,000여가지의 인기 e쿠폰으로 교환가능!">
						</div>
					</div>
					<div class="swiper-button-prev btn_prev"></div>
					<div class="swiper-button-next btn_next"></div>
				</div>
				<div class="swiper-pagination"></div>
				<script>
					$(function(){
						var mySwiper = new Swiper('.event_02 .swiper-container',{
							prevButton : '.event_02 .swiper-button-prev',
							nextButton : '.event_02 .swiper-button-next',
							loop : true,
							autoplay : 6000,
							speed : 1000,
							pagination : '.event_02 .swiper-pagination',
							paginationClickable : true
						});
					})
				</script>
			</div>
		</div>
	</div>

	<!-- 이벤트3 -->
	<div id="evt3" class="section event_03 scroll">
		<h3>e머니로 쿠폰교환</h3>
		<div class="evt_box">
			<a href="javascript:///" class="btn_go_store">스토어 바로가기</a>
		</div>
	</div>
	<!-- //Contents -->	
	<span class="go_top"><a href="javascript:///">TOP</a></span>
</div>

<!-- (신규) 공통 : SNS공유하기 -->
<div class="com__share_wrap dim" style="z-index:10000;display:none">
	<div class="com__layer share_layer">
		<div class="lay_head">공유하기</div>
		<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
		<div class="lay_inner">
			<ul id="eventShr">
				<li class="share_fb">페이스북 공유하기</li>
				<li class="share_kakao" id="kakao-link-btn" >카카오톡 공유하기</li>				
				<li class="share_tw">트위터 공유하기</li>
				<!-- <li class="share_line">라인 공유하기</li> -->
				<!-- 메일아이콘 클릭시 활성화(.on) -->
				<!-- <li class="share_mail" onclick="$(this).toggleClass('on');$(this).parents('.share_layer').find('.btn_wrap').toggleClass('mail_on');">메일로 공유하기</li> -->
				<!-- <li class="share_story">카카오스토리 공유하기</li> -->
				<!-- <li class="share_band">밴드 공유하기</li> -->
			</ul>
			<!-- 메인보내기 버튼클릭시 .mail_on 추가해 주세요 -->
			<div class="btn_wrap">
				<div class="btn_group">
					<!-- 주소복사하기 -->
					<div class="btn_item">
						<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2020/tmon2020evt.jsp</span>
						<button class="btn__share_copy" data-clipboard-target="#txtURL">복사</button>
					</div>
					<!-- 이메일주소 입력하기 -->
					<div class="btn_item">
						<input type="text" class="txt__share_mail" placeholder="이메일 주소 입력해 주세요">
						<button class="btn__share_mail">보내기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="/js/clipboard.min.js"></script>
	<script>
		$(function(){
			var clipboard = new ClipboardJS('.com__share_wrap .btn__share_copy');
			clipboard.on('success', function(e) {
				alert('주소가 복사되었습니다');
			});
			clipboard.on('error', function(e) {
				console.log(e);
			});
		});
	</script>
</div>

<!-- layer--> 
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();" >설치하기</button></p>
	</div>
</div>

<!-- 당첨 레이어 --> 
<div class="voteResult_layer" id="prizes" style="display:none">
	<div class="inner_layer">
		<div class="cont_area">
			<div class="img_box">
				<!-- 당첨 -->
				<div class="result_01" style="display:none">
					<img src="http://img.enuri.info/images/event/2020/family_pro/m_result_img_03.jpg" alt="축하해요~!!" />
				</div>
				<!-- 꽝 - 5점 적립 -->
				<div class="result_02" style="display:none">
					<img src="http://img.enuri.info/images/event/2020/family_pro/m_result_img_04.jpg" alt="5점 적립~" />
				</div>
			</div>
			<a class="btn layclose" href="javascript:///" onclick="onoff('prizes'); return false;"><em>팝업 닫기</em></a>
		</div>
	</div>
</div>

<!-- 이벤트 응모완료 -->
<div class="complete_layer" id="completeJoin" style="display:none">
	<div class="inner_layer">
		<div class="cont_area">
			<p class="blind">응모가 완료되었습니다.</p>
			<ul class="lay_goods_list" id="completeJoin_list" ></ul>
			<a href="javascript:///" class="btn_close" onclick="onoff('completeJoin'); return false;">확인</a>
		</div>
		<a class="btn layclose" href="javascript:///" onclick="onoff('completeJoin'); return false;"><em>팝업 닫기</em></a>
	</div>
</div>
<!-- 이벤트1 유의사항 --> 
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="noteLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1');return false;">창닫기</a>
		<div class="inner">
			<ul class="txtlist">
				<li>ID당 1일 1회 참여 가능</li>
				<li>이벤트 경품: e13,200점, e5점</li>
				<li class="emp">e머니 유효기간: 적립일로부터 15일</li>
				<li>적립된 e머니는 e머니 스토어에서 다양한 e쿠폰상품으로 교환 가능합니다.</li> 
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다.</li>
				<li>부정 참여 시 적립 취소 및 사이트 사용이 제한될 수 있습니다.</li>
			</ul>
		</div>
		<p class="btn_close"><button type="button" onclick="onoff('notetxt1');return false;">닫기</button></p>
	</div>
</div>
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20180831"></script>
<script type="text/javascript">
var app = getCookie("appYN"); //app인지 여부
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로
var vEvent_title = "20년5월 티몬상품이벤트";
var isFlow = "<%=flow%>" == "ad";
var vOs_type = getOsType();
var state = false;
var tab = "<%=tab%>";

$(".go_top").click(function(){		$('body, html').animate({scrollTop:0}, 500);	});

var shareUrl = "http://" + location.host + "/mobilefirst/event2020/tmon2020evt.jsp";
var shareTitle = "<%=strFb_title%> <%=strFb_description%>";

Kakao.init('5cad223fb57213402d8f90de1aa27301');
/* 데이터 로드 영역 */
var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=36";
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
function da_ga(num){
	if(num == 2){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 티몬상품이벤트_탭_응모하기");
	}else if(num == 3){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 티몬상품이벤트_탭_식품");
	}else if(num == 4){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 티몬상품이벤트_식품_상품클릭");
	}else if(num == 5){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 티몬상품이벤트_탭_생활");
	}else if(num == 6){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 티몬상품이벤트_생활_상품클릭");
	}else if(num == 7){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 티몬상품이벤트_탭_패션");
	}else if(num == 8){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 티몬상품이벤트_패션_상품클릭");
	}else if(num == 9){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 티몬상품이벤트_탭_유아");
	}else if(num == 10){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 티몬상품이벤트_유아_상품클릭");
	}else if(num == 11){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 티몬상품이벤트_탭_화장품");
	}else if(num == 12){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 티몬상품이벤트_화장품_상품클릭");	
	}else if(num == 13){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 티몬상품이벤트_탭_e쿠폰");
	}else if(num == 14){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 티몬상품이벤트_e쿠폰_상품클릭");
	}else if(num == 15){
		ga('send', 'event', 'mf_event', vEvent_title, "20년 티몬상품이벤트_스토어바로가기");
	}
}

//sns 인증
function getSnsCheck() {
	var snsCertify;
	$.ajax({
		type: "GET",
		url: "/member/ajax/getMemberCetify.jsp",
		dataType: "JSON",
		async : false,
		success: function(json){
			var snsdcd = json["snsdcd"]; //sns회원유무 K:카카오, N:네이버
			snsCertify = json["certify"];
			if(snsdcd==""){
				snsCertify = true;
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
	});
	return snsCertify;
}
//닫기버튼
$('.win_close').click(function(){
	if(getCookie("appYN") == 'Y'){
		window.location.href = "close://";
	}else{
		window.location.replace("/m/index.jsp");
	}
});
/*레이어*/
function onoff(id){
	var mid = $("#"+id);
	if(mid.css("display") !== "none"){
		mid.css("display","none");
	}else{
		mid.css("display","");
	}
}

$(document).ready(function() {
	
	$(".btn_apply").click(function(){
		
		da_ga(2);
		
    	if(!islogin()){
			alert("로그인 후 신청 가능합니다!");
			goLogin();
			return false;
		}
		
		if(!getSnsCheck()){
			if (confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?") == true){    
				location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
				return false;
			}else{
				return false;
			}
		}else{
			
			$.ajax({
				type: "get",
				url: "/mobilefirst/evt/ajax/tmon_setlist2.jsp?proc=1&osType="+getOsType(),
				dataType: "JSON",
				success:function(json){
					
						if(json.result == 1){
    						alert("응모완료! 당첨자 발표일을 기다려주세요");
    					}else if(json.result == 2601){
    						alert("이미 응모완료 되었습니다!");
    					}else if(json.result == -99){
    						alert("티몬에서 구매 후 응모 가능합니다.");
    					}else if(json.result == -100){
    						alert("임직원은 응모할수 없습니다.");
    					}else if(json.result == 100){	
    						alert("이벤트가 종료 되었습니다.");
    					}    						
				}
			});
		}
    	
    });
	
	// 개인정보 불러오기
	if(islogin()){
		$(".login_alert").addClass("disNone");
		$("#user_id").text("<%=cUserId%>");
	}
	
	ga('send', 'pageview', {'page': vEvent_page,'title': vEvent_title+'_PV'});
	
	if(tab != ""){
		setTimeout(function() {
	        $(".floattab__list li > a").eq(tab-1).trigger("click");
	    },300);
	}
	
	
	//로그인시 개인화영역
	if(islogin()){
		$("#user_id").text("<%=cUserId%>");
		getPoint();//개인e머니 내역 노출
	}
		
	$("#eventShr > li").click(function(){
		var sel = $(this).attr("class");
		
		if(sel == "share_fb"){
			try{
				window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(shareTitle)+"&u="+shareUrl);
			}catch(e){
				window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(shareTitle)+"&u="+shareUrl);
			}	
		}else if(sel == "share_tw"){
			try {
				window.android
						.android_window_open("http://twitter.com/intent/tweet?text="
								+ encodeURIComponent(shareTitle)
								+ "&url=" + shareUrl);
			} catch (e) {
				window.open("http://twitter.com/intent/tweet?text="
						+ encodeURIComponent(shareTitle) + "&url="
						+ shareUrl);
			}
		}
	});
	
	tabLoading();
	
	$("body").on('click', '.items > li', function(event) {
		var modelno = $(this).attr("data-mn");
		var price = $(this).attr("data-price");
		
		var line = 0;
		
		$(".floatmove > li").each(function(i,v){
			var cls = $(this).attr("class");
			if(cls == "is-on"){
				line = i;
			}
		});
		
		if(line == 0)        da_ga(3);       
		else if(line == 1)   da_ga(5);
		else if(line == 2)	 da_ga(7);
		else if(line == 3)   da_ga(9);
		else if(line == 4)   da_ga(11);
		else if(line == 5)   da_ga(13);
		
		itemClick(modelno,price);
		return false;
	});
	
	$(".btn_go_store").click(function(){
		da_ga(15);
		if(app == "Y"){
			location.href = "/mobilefirst/emoney/emoney_store.jsp?freetoken=emoney";
			return false;
		}else{
			$("#app_only").show();
		}
	});
});
/*
var proSlide ;

setTimeout(function(){
	proSlide = $('.itemlist').slick({
		dots:true,
		slidesToScroll: 1
	});
},100);
*/
function itemClick(modelNo, minprice) {
	
	da_ga(11);
	
	if(minprice > 0){
		window.open('/mobilefirst/detail.jsp?modelno=' + modelNo +'&freetoken=vip');
	}else{
		alert("품절된 상품 입니다.");
	}
}

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

function arrayShuffle2(oldArray) {
    var newArray = oldArray;
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
var nowTab = 1;
function tabLoading(){
	//가격대별 탭 컨텐츠
	$(".goods_content .tab_content").hide(); 
	$("ul.floatmove li").removeClass("is-on"); 
	//첫 로딩 시, 랜덤 노출
  var rndNum = Math.floor(Math.random() * 6);
  nowTab = rndNum+1;
  
  $(".goods_content").attr("id","goods"+nowTab);
  
  var object = ajaxData[rndNum]["GOODS"];
	loadGoodsList(object);
	
	$("ul.floatmove li").eq(rndNum).addClass("is-on").show();
  
	$(".goods_content .tab_content:first").show();
	//$("ul.tabs__list li").eq(0).trigger("click");
	
	$("ul.floatmove li").click(function() {
		$("ul.floatmove li").removeClass("is-on"); 
		$(this).addClass("is-on");
		//$(".pro_itemlist .tab_content").hide(); 
		var activeTab = $(this).find("a").attr("href");
		//$(activeTab).fadeIn();
		//proSlide.slick("setPosition");
		$(".goods_content").attr("id","goods"+activeTab.substring(7, 8));
		
		//가격대별 플리킹
		proSlide.slick("destroy");
		if(activeTab == "#protab1"){
			var object = ajaxData[0]["GOODS"];
			loadGoodsList(object);
			
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			da_ga(3);
			nowTab = 1;
		}else if(activeTab == "#protab2"){
			var object = ajaxData[1]["GOODS"];
			loadGoodsList(object);
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			da_ga(5);
			nowTab = 2;
		}else if(activeTab == "#protab3"){
			var object = ajaxData[2]["GOODS"];
			loadGoodsList(object);
			
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			da_ga(7);
			nowTab = 3;
		}else if(activeTab == "#protab4"){
			var object = ajaxData[3]["GOODS"];
			loadGoodsList(object);
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			da_ga(9);
			nowTab = 4;
		}else if(activeTab == "#protab5"){
			var object = ajaxData[4]["GOODS"];
			loadGoodsList(object);
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			da_ga(11);
			nowTab = 5;
		}else if(activeTab == "#protab6"){
			var object = ajaxData[5]["GOODS"];
			loadGoodsList(object);
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			da_ga(13);
			nowTab = 6;
		}
		return false;
	});
	
	//플리킹
	var proSlide = $('.tab_content .itemlist').slick({
		dots:true,
		slidesToScroll: 1
	});
	
}
function loadGoodsList(obj){
	var goodsList = arrayShuffle2(obj);
	var html = "";
	
	if(goodsList.length >0){
		
		for(var i=0;i<goodsList.length;i++){
			if(i<12){
				if(i%4==0) html += "<ul class=\"items clearfix\">";
					
					var goodsData = goodsList[i];
					var modelno = goodsData["MODELNO"];
					var goods_img = goodsData["GOODS_IMG"];
					var goods_title1 = goodsData["TITLE1"];
					var goods_title2 = goodsData["TITLE2"];
					var goods_minprice = goodsData["MINPRICE"]==null?0:goodsData["MINPRICE"];
					
					html+= "<li class=\"item\" data-mn='"+goodsData["MODELNO"]+"' , data-price='"+goodsData["MINPRICE"]+"' >";
					html+= "	<a href=\"javascript:;\" title=\"새 탭에서 열립니다.\">";
					html+= "		<span class=\"thumb\">";
					html+= "			<img src=\""+goodsData["GOODS_IMG"]+"\" alt=\"\" />";
					if(goodsData["MINPRICE"]==0){
					html+= "			<span class=\"soldout\">SOLD OUT</span>";	
					}
					html+= "		</span>";
					html+= "		<span class=\"pro_info\">";
					html+= "			<span class=\"pro_name\">"+goods_title1+"<br />"+goods_title2+"</span>";
					html+= "			<span class=\"price\"><em>"+numberWithCommas(goods_minprice)+"</em><span class=\"pro_unit\"> 원</span></span>";
					html+= "		</span>";
					html+= "		<span class=\"links\">구매하기 &gt;</span>";
					html+= "	</a>";
					html+= "</li>";	
					
				if(i%4==3) html += "</ul>";
			}
		}
		
		$(".itemlist").html(html);
	}
}
//onclick=\"itemClick("+goodsData["MODELNO"]+","+goodsData["MINPRICE"]+");\"

var isClick = true;
var sdt = "<%=strToday%>";

$(window).load(function(){
	if(tab!='') {
		setTimeout(inner, 300);
	}
	function inner() {
		$('html, body').animate({scrollTop: Math.ceil($('#'+tab).offset().top)}, 500);
	}
});

function numberWithCommas(x) {   return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");		}

function welcomeGa(strEvent){
	if(app == "Y"){
		try{
			if(window.android){ // 안드로이드 
				window.android.igaworksEventForApp (strEvent);
			}else if(/iPhone|iPad|iPod/i.test(navigator.userAgent)){
				// 아이폰에서 호출
				location.href = "enuriappcall://igaworksEventForApp?strEvent="+strEvent;
			}
		}catch(e){}
	}
}
setTimeout(function(){
welcomeGa("evt_family_view"); 
},500);
function goPlan(){
	location.href = "/mobilefirst/event2020/family_2020.jsp";
}

CmdShare();
function CmdShare(){
	Kakao.Link.createDefaultButton({
		  container: '#kakao-link-btn',
	      objectType: 'feed',
	      content: {
	        title: '<%=strFb_title%>',
	        description: "<%=strFb_description%>",
	        imageUrl: "<%=strFb_img%>",
	        imageWidth: 380,
	        imageHeight: 198,
	        link: {
	          webUrl: shareUrl,
	          mobileWebUrl: shareUrl
	        }
	      },
		buttons: [{
	          title: '에누리 가격비교',
	          link: {
	            mobileWebUrl: shareUrl,
	            webUrl: shareUrl
	          }
		}]
    });
}
function getOsType(){
    var osType = "";
    if(app =='Y'){
         if(navigator.userAgent.indexOf("Android") > -1)		        	 osType = "MAA";
         else		        	 osType = "MAI";
    }else {
         if(navigator.userAgent.indexOf("Android") > -1)		        	 osType = "MWA";
         else		        	 osType = "MWI";
    }
    return osType;
}


</script>
</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
