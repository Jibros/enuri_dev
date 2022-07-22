<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>

<%
String strFb_title = "에누리에서 신규회원 쿠팡 상품 구매시 최대 5배 적립!";
String strFb_description = "신규 회원을 위한 특별 혜택 친구에게 공유하고 스타벅스 받자!";
String strFb_img = "http://img.enuri.info/images/event/2021/coupang_new/sns_1200_630.jpg?v=1";

if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{ //pc일때 접속페이지 변경.
	response.sendRedirect("/event2021/coupang_evt.jsp");
	return;
}
String oc = ChkNull.chkStr(request.getParameter("oc"), "");
String anker = ChkNull.chkStr(request.getParameter("anker"), "");
String chkId     = ChkNull.chkStr(request.getParameter("chk_id"),"");
String cUserId   = cb.GetCookie("MEM_INFO","USER_ID");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

String referer = ChkNull.chkStr(request.getParameter("#"), "");



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

String strEventId = "2021051701";
%>


<!DOCTYPE html> 
<html lang="ko">
<head>
<meta charset="utf-8">	
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	

<META NAME="description" CONTENT="<%=strFb_description%>">
<META NAME="keyword" CONTENT="에누리가격비교, 신규회원 쿠팡, 최대5배 적립, 쿠팡이벤트">

<meta property="og:url"                content="http://www.enuri.com/mobilefirst/event2021/coupang_evt.jsp?oc=mo" />
<meta property="og:type"               content="website" />
<meta property="og:title"              content="<%=strFb_title%>" />
<meta property="og:description"        content="<%=strFb_description%>" />
<meta property="og:image"              content="<%=strFb_img%>" />

<meta name="format-detection" content="telephone=no" />
<link rel="image_src" href="<%=strFb_img%>"/>
<link rel="stylesheet" href="/css/slick.css" type="text/css">
<!-- 200310 CSS 추가/교체 -->
<!-- 프로모션 공통 CSS (Mobile) -->
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css?v=202105131429" type="text/css"><!-- 추가 -->
<!-- 프로모션별 커스텀 CSS  -->
<link rel="stylesheet" href="/css/event/y2021_rev/coupang_new_m.css" type="text/css"><!-- 교체 -->
<!-- // -->
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>

<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
<script type="text/javascript" src="/mobilefirst/js/utils.js"></script>
<script type="text/javascript" src="/common/js/function.js?v=<%=strToday%>"></script>
<script type="text/javascript" src="/common/js/paging_evt.js"></script>



</head>

<body>
<div class="lay_only_mw" style="display: none;">
	<div class="lay_inner">
		<div class="lay_head">
			앱에서는 득템의 기회 <em>타임특가</em>에 참여할 수 있어요!
		</div>
		<!-- 버튼 : 에누리앱으로 보기 -->
		<button class="btn_go_app" onclick="view_moapp();">에누리앱으로 보기</button>
		<!-- 버튼 : 모바일웹으로 보기 -->
		<a href="javascript:void(0);" class="btn_keep_mw" onclick="$('.lay_only_mw').fadeOut(100);">괜찮아요. 모바일 웹으로 볼래요</a>
	</div>
</div>

<div id="eventWrap">

	<div class="myarea">
		<%if(cUserId.equals("")){%>	
		<p class="name">나의 <em class="emy">머니</em>는 얼마일까?<button type="button" class="btn_login">로그인</button></p>
		<%}else{%>
		<p class="name"><%=userArea%> 님<span id="my_emoney" onclick="$('#app_only').show();">0점</span></p>
		<%}%>
		<a href="#" class="win_close">창닫기</a>
	</div>

	<!-- 플로팅 배너  -->
	<div class="floating_bnr" style="display:none">
		<img src="http://img.enuri.info/images/event/2019/crazyFriday/fl_bnr.png" alt="매일 오전 10시 매일 한정특가">
		<a href="#" onclick="$('.floating_bnr').hide();return false;" class="btn_close">닫기</a>
	</div>
	<!-- //  플로팅 배너 -->

	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">

		<!-- 상단비주얼 -->		
		<div class="visual">
			<!-- 200310 추가 : 공통 : 공유하기 버튼  -->
			<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
			<!-- // -->
			<div class="inner">
				<div class="box_area">
					<div class="box_inner">
						<h1 class="tx_tit">쿠팡 신규 회원을 위한 특별 혜택</h1>
						<p class="tx_sub">e머니 <strong>최대 5배 적립</strong> 추첨을 통한 푸짐 경품 지급까지!</p>
					</div>
				</div>
				
				<span class="tx_gift2">경품 이미지</span>

				<div class="move_obj"><!--빵빠레--></div>
			</div>
			<script>
				// 상단 타이틀 등장모션
				$(window).load(function(){
					var $visual = $(".toparea .visual");
					$visual.addClass("intro");
					setTimeout(function(){
						$visual.addClass("end");
					},1200)
				})
			</script>
		</div>
	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<!-- 네비 -->
	<div class="section floattab">
		<div class="contents">
			<ul class="floattab__list">
				<li><a href="#evt1" class="floattab__item floattab__item--01">e머니 최대 5배 적립으로 </a></li>
				<li><a href="#evt2" class="floattab__item floattab__item--02">쿠팡 구매 시 쏟아지는 경품</a></li>
				<li><a href="#evt3" class="floattab__item floattab__item--03">지금 쿠팡의 인기 상품은?</a></li>
				<li><a href="#evt4" class="floattab__item floattab__item--04">이벤트 소문내고 스타벅스 받자</a></li>
			</ul>
		</div>
	</div>
	<!-- // -->

	<!-- 이벤트01 -->
	<div id="evt1" class="section event_01 scroll"><!-- 이벤트 1 앵커 영역 -->
		<div class="contents">
			<div class="i_onlyapp">APP 전용</div>

			<div class="cont__head">
				<p class="tx_badge">신규 고객 적립 이벤트</p>
				<h2 class="tx_tit">신규 회원 가입 후 이벤트 기간 내 e머니 기본 적립금의 최대 5배 적립!(앱 경유하여 쿠팡에서 구매 시)</h2>
			</div>

			<div class="cont__body">
				<div class="bg_box">
					<span class="i_phone"><!-- 폰이미지 --></span>
					<a href="javascript:///" class="btn_coupang" >쿠팡 바로가기</a>
					<span class="i_coin1"><!-- 코인이미지 --></span>
					<span class="i_coin2"><!-- 코인이미지 --></span>
				</div>
			</div>
		</div>
	
		<div class="noti_wrap">
			<div class="contents">
				<ul class="tx_noti_list">
					<li><strong>이벤트 기간</strong> : 2021년 5월 17일 ~ 6월 30일</li>
					<li>
						<strong>이벤트 대상</strong> : 이벤트 기간 내 신규 가입자 중 앱으로 쿠팡을 경유하여 구매한 고객 대상입니다.<br />
						<p class="stress">※기존 가입자는 이벤트에서 제외되며 21년 5월 17일 이전 회원가입 이력이 있을 경우에도 이벤트에서 제외됩니다.</p>
					</li>
					<li><strong>이벤트 참여방법 및 유의사항</strong>
						<ul class="tx_sub">
							<li>에누리 앱  접속 &gt; 신규 회원가입 후 로그인 &gt; 쿠팡 접속 &gt; 대상 카테고리 상품 1,000원 이상 구매 &gt; 구매 금액의 기존 적립금의 최대 5배 적립!<br />
								<p class="stress">※ 대상 카테고리는 ‘에누리’ 기준이며,  모바일 이벤트 페이지 내 대상 카테고리 클릭 시 편리하게 상품 확인이 가능합니다.</p>
							</li>
							<li>본인인증 후 구매한 경우에만 적립이 가능하며, 적립률은 카테고리 별로 상이합니다.</li>
							<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품의 실제 결제금액만 반영됩니다.<br>
								<p class="stress">※이벤트 상세내용은 유의사항에서 확인하세요.</p>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>

		<div class="evt_cnt">
			<div class="contents">
				<h3 class="tx_tit">대상 카테고리</h3>
				<p class="blind">APP에서 구매하세요!</p>
				<ul class="cate_list">
					<li><a href="javascript:///" >유아완구 5.0%</a></li>
					<li><a href="javascript:///" >식품 3.0%</a></li>
					<li><a href="javascript:///" >스포츠 3.0%</a></li>
					<li><a href="javascript:///" >컴퓨터/노트북 2.5%</a></li>
					<li><a href="javascript:///" >가전 1.0%</a></li>
					<li><a href="javascript:///" >영상/디카 1.0%</a></li>
					<li><a href="javascript:///" >디지털 1.0%</a></li>
					<li><a href="javascript:///" >가구/생활 1.0%</a></li>
					<li><a href="javascript:///" >화장품 1.0%</a></li>
				</ul>
			</div>
		</div>

		<!-- 버튼 : 꼭 확인하세요  -->
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop1"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 레이어 열기 -->
		</div>
		<div id="slidePop1" class="evt_notice--slide">
			<div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<dl>								
							<dt>이벤트 및 구매기간</dt>
							<dd>
								<ul>
									<li>2021년 5월 17일 ~ 2021년 6월 30일</li>
								</ul>
							</dd>
						</dl>

						<dl>
							<dt>이벤트 대상 및 제외대상</dt>
							<dd>
								<ul>
									<li>이벤트 기간 내 신규 가입자 중 앱으로 쿠팡을 경유하여 구매한 고객 대상</li>
									<li>일반 회원가입 또는  SNS 회원가입 중 본인인증이 된  1개의 신규 아이디만 추가 적립가능</li>
									<li>신규 회원이 아닌 탈퇴 후 재가입 또는  SNS 회원가입 등 계정 을 추가 가입한 경우 적립 제외</li>
									<li class="stress">기존 가입자와 21년 5월 17일 이전에 일반 회원가입 또는 SNS 회원가입  이력이 있는 경우 제외</li>
								</ul>
							</dd>
						</dl>

						<dl>
							<dt>이벤트 참여방법</dt>
							<dd>
								<ul>
									<li>에누리 앱 접속 &rarr; 신규 회원가입 후 로그인 &rarr; 쿠팡 접속 &rarr; 대상 카테고리 상품 1,000원 이상 구매 &rarr; 결제 금액의 기존 적립률의 최대 5배 적립</li>
								</ul>
							</dd>
						</dl>

						<dl>
							<dt>대상카테고리 및 이벤트 적립률</dt>
							<dd>
								<table class="evt_noti_tb" style="width:100%;">
									<tbody>
										<tr><th>대상 카테고리</th><th>기존적립률 &rarr;이벤트 적립률</th></tr>
										<tr><td>유아/완구</td><td>1.5% <em>&rarr;&nbsp; 5.0%</em></td></tr>
										<tr><td>식품</td><td>1.0% <em>&rarr;&nbsp; 3.0%</em></td></tr>
										<tr><td>스포츠</td><td>1.0% <em>&rarr;&nbsp; 3.0%</em></td></tr>
										<tr><td>컴퓨터/노트북</td><td>0.8% <em>&rarr;&nbsp; 2.5%</em></td></tr>
										<tr><td>생활가전</td><td>0.3% <em>&rarr;&nbsp; 1.0%</em></td></tr>
										<tr><td>주방가전</td><td>0.3% <em>&rarr;&nbsp; 1.0%</em></td></tr>
										<tr><td>계절가전</td><td>0.3% <em>&rarr;&nbsp; 1.0%</em></td></tr>
										<tr><td>영상/디카</td><td>0.3% <em>&rarr;&nbsp; 1.0%</em></td></tr>
										<tr><td>디지털</td><td>0.3% <em>&rarr;&nbsp; 2.0%</em></td></tr>
										<tr><td>가구/인테리어</td><td>0.3% <em>&rarr;&nbsp; 1.0%</em></td></tr>
										<tr><td>생활/취미</td><td>0.2% <em>&rarr;&nbsp; 1.0%</em></td></tr>
										<tr><td>화장품</td><td>0.3% <em>&rarr;&nbsp; 1.0%</em></td></tr>
									</tbody>
								</table>
							</dd>
						</dl>

						<dl>
							<dt>이벤트 유의사항</dt>
							<dd>
								<ul>
									<li>적립된 e머니 는 e쿠폰 스토어에서 다양한 쿠폰으로 교환 가능</li>
									<li>대상 쇼핑몰 : 쿠팡 ( 쿠팡 외의 쇼핑몰에서 구매 시 미적용 )</li>
									<li>구매 적립 e머니 유효기간 : 적립일로 부터 60일 ( 유효기간 만료 후 재적립 불가 )</li>
									<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품의 실제 결제금액만 반영됨</li>
									<li>본인인증 후 구매 시 에만 적립가능</li>
									<li>구매후 취소/환불/반품한 경우 적립 불가</li>
									<li>적립 대상 쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제 시 구매건수는 1건이며, 구매금액은 통합 결제한 금액의 e머니 적립</li>
									<li>e머니는 최소 10점부터 적립되며 (구매금액 1,000원 이상) , 1원 단위 e머니는 적립불가. ( 예: 1,200원 결제 시 e머니 10점 적립 )</li>
									<li>생활/취미 카테고리 중 ‘모바일쿠폰, 상품권’ 은 적립불가</li>
									<li class="stress">본 이벤트는 모바일 앱에서만 참여가 가능한 모바일 앱 전용 프로모션입니다.</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>아래의 경우에는 구매 확인 및 적립이 불가합니다.</dt>
							<dd>
								<ul>
									<li>에누리 가격비교 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱으로 결제만 한 경우 <br> 
									( 에누리 가격비교 앱을 통해 쇼핑몰로 이동 후 장바구 / 관심상품 등록 후 구매 시에는 가능 ) 
									</li>
									<li>에누리 가격비교 앱 미 로그인 후 구매한 경우 또는 에누리 가격비교 PC, 모바일 웹에서 구매한 경우</li>
									<li>에누리 가격비교 앱에서 검색되지 않는 상품을 구매한 경우</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>유의사항</dt>
							<dd>
								<ul>
									<li>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</li>
									<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
								</ul>
							</dd>
						</dl>
					</div>
				</div>
				<div class="evt_notice--foot">						
					<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 레이어 닫기 -->
				</div>
			</div>
		</div>
		<!-- // -->
	</div>
	<!-- // 이벤트01 -->

	<!-- 이벤트02 -->
	<div id="evt2" class="section event_02 scroll"><!-- 이벤트 2 앵커 영역 -->
		<div class="contents">
			<div class="i_onlyapp">APP 전용</div>

			<div class="cont__head">
				<p class="tx_badge">신규 고객 추가 이벤트</p>
				<h2 class="tx_tit">지금 구매하고 경품 받자! 이벤트 기간 내 가입한 신규 가입자 중 쿠팡을 경유하여 구매하신 고객님 40명을 추첨하여 푸짐한 경품을 드립니다.</h2>
			</div>

			<div class="cont__body">
				<div class="bg_box">
					<ol class="blind">
						<li>1등 3명, [원할머니보쌈, 족발] 실속원쌈 3인 e머니 45,000원</li>
						<li>2등 7명, [피자마루] 리얼 시카고 BBQ피자 + 코카콜라 1.25L e머니 45,000원</li>
						<li>3등 30명, [맥도날드] 빅맥 세트 e머니 45,000원</li>
					</ol>
					<a href="javascript:///" class="btn_join">구매 후 응모하기</a>
				</div>
			</div>
		</div>
	
		<div class="noti_wrap">
			<div class="contents">
				<ul class="tx_noti_list">
					<li><strong>이벤트 기간</strong> : 2021년 5월 17일 ~ 6월 30일</li>
					<li><strong>당첨자 발표일</strong> : 2021년 10월 7일</li>
					<li>
						<strong>이벤트 대상</strong> : 이벤트 기간 내 에누리 최초 신규 가입자중  앱으로  쿠팡을 경유하여 구매한 고객 대상<br />
						<p class="stress">※기존 가입자는 이벤트에서 제외되며 21년 5월 17일 이전 회원가입 이력이 있을 경우에도 이벤트에서 제외됩니다.</p>
					</li>
					<li><strong>이벤트 참여방법 및 유의사항</strong>
						<ul class="tx_sub">
							<li>에누리 앱  접속 &gt; 신규 회원가입 후 로그인 &gt; 쿠팡 접속 &gt; 대상 카테고리 상품 1,000원 이상 구매 &gt; 구매 후 응모하기 클릭<br />
								<p class="stress">※ 대상 카테고리는 ‘에누리’ 기준이며,  모바일 이벤트 페이지 내 대상 카테고리 클릭 시 편리하게 상품 확인이 가능합니다.</p>
							</li>
							<li>본인인증 후 구매한 경우에만 응모 가능합니다.<br>
								<p class="stress">※이벤트 상세내용은 유의사항에서 확인하세요.</p>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>

		<!-- 버튼 : 꼭 확인하세요  -->
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop2"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 레이어 열기 -->
		</div>
		<div id="slidePop2" class="evt_notice--slide">
			<div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<dl>								
							<dt>이벤트 및 구매기간</dt>
							<dd>
								<ul>
									<li>2021년 5월 17일 ~ 2021년 6월 30일</li>
								</ul>
							</dd>
						</dl>

						<dl>								
							<dt>당첨자 발표 및 경품지급일</dt>
							<dd>
								<ul>
									<li>당첨자 발표일 : 2021년 10월 7일</li>
									<li>당첨자 공지: 에누리 앱 > 이벤트/기획전 > 이벤트혜택 > 하단 '당첨자 발표' 에 공지</li>
								</ul>
							</dd>
						</dl>

						<dl>								
							<dt>이벤트 대상 및 제외대상</dt>
							<dd>
								<ul>
									<li>이벤트 기간 내 신규 가입자 중 앱으로 쿠팡을 경유하여 구매한 고객 대상</li>
									<li>일반 회원가입 또는 SNS 회원가입 중 본인인증이 된 1개의 신규 아이디만 추가 참여 가능</li>
									<li>신규 회원이 아닌 탈퇴 후 재가입 또는  SNS 회원가입 등 계정 을 추가 가입한 경우  참여 불가</li>
									<li class="stress">※ 기존 가입자와 21년 5월 17일 이전에 일반 회원가입 또는 SNS 회원가입  이력이 있는 경우 제외</li>
								</ul>
							</dd>
						</dl>

						<dl>
							<dt>이벤트 참여방법</dt>
							<dd>
								<ul>
									<li>에누리 앱 접속 &rarr; 신규 회원가입 후 로그인 &rarr; 쿠팡 접속 &rarr; 대상 카테고리 상품 1,000원 이상 구매 &rarr; 구매 후 응모하기 클릭</li>
								</ul>
							</dd>
						</dl>

						<dl>
							<dt>이벤트 경품</dt>
							<dd>
								<ul>
									<li>1등  [원할머니보쌈.족발] 실속원쌈 3인 (e머니 45,000원)  - 3명 추첨</li>
									<li>2등  [피자마루]리얼 시카고 BBQ 피자+코카콜라 1.25L (e머니 20,900원) -7명 추첨</li>
									<li>3등  [맥도날드] 빅맥 세트 (e머니 5,900원) -30명</li>
									<li class="stress">※ 경품은 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격변동이 있을 수 있음</li>
								</ul>
							</dd>
						</dl>

						<dl>
							<dt>이벤트 유의사항</dt>
							<dd>
								<ul>
									<li>e머니 유효기간 : 적립일로 부터 15일 ( 유효기간 만료 후 재적립 불가 )</li>
									<li>대상 쇼핑몰 : 쿠팡 ( 쿠팡 외의 쇼핑몰에서 구매 시 미적용 )</li>
									<li>본인인증 후 구매 시 에만 참여가능</li>
									<li>이벤트 참여 시 개인정보 수집 에 동의하신 것으로 간주됩니다.</li>
									<li>이벤트의 원활한 진행을 위해 당첨자의 참여일시, 참여자 IIID, 본인인증확인 ( CI, DI )가 수집되며 수집된 개인정보는 이벤트 참여 확인 이외의 목적으로 활용되지 않습니다.</li>
									<li class="stress">본 이벤트는 모바일 앱에서만 참여가 가능한 모바일 앱 전용 프로모션입니다.</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>아래의 경우에는 구매 확인 및 적립이 불가합니다.</dt>
							<dd>
								<ul>
									<li>에누리 가격비교 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱으로 결제만 한 경우 <br> 
									    ( 에누리 가격비교 앱을 통해 쇼핑몰로 이동 후 장바구니 / 관심상품 등록 후 구매 시에는 가능 )
									</li>
									<li>에누리 가격비교 앱 미 로그인 후 구매한 경우 또는 에누리 가격비교 PC, 모바일 웹에서 구매한 경우</li>
									<li>에누리 가격비교 앱에서 검색되지 않는 상품을 구매한 경우</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>유의사항</dt>
							<dd>
								<ul>
									<li>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</li>
									<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
								</ul>
							</dd>
						</dl>
					</div>
				</div>
				<div class="evt_notice--foot">						
					<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 레이어 닫기 -->
				</div>
			</div>
		</div>
		<!-- // -->
	</div>
	<!-- // 이벤트02 -->

	<!-- 이벤트03 -->
	<div id="evt3" class="section event_03 scroll"> <!-- 이벤트 3 앵커 영역 -->
		<div class="contents">
			<div class="cont__head">
				<h2 class="tx_tit">뭘 구매해야 할지 고민된다면? 인기상품 추천</h2>
			</div>

			<div class="cont__body">
				<div class="prdc__list">
					<ul id="goodsList">
				</div>
			</div>
		</div>
		
		
	</div>

	<!-- 이벤트04 -->
	<div id="evt4" class="section event_04 scroll"><!-- 이벤트 4 앵커 영역 -->
		<div class="contents">
			<div class="cont__head">
				<p class="tx_badge">보너스 공유하기 이벤트</p>
				<h2 class="tx_tit">친구에게 공유하고 스타벅스 받자!</h2>
			</div>

			<div class="cont__body">
				<div class="bg_box">
					<ul class="sns_list" id="share_list">
						<li id="kakao-link-btn2"><button type="button" class="btn btn__sns1" title="카카오톡 공유하기">카카오톡</button></li>
						<li><button type="button" class="btn btn__sns2" title="페이스북 공유하기">페이스북</button></li>
						<li><button type="button" class="btn btn__sns3" title="트위터 공유하기">트위터</button></li>
						<li><button type="button" class="btn btn__sns4" title="URL 복사" data-clipboard-text="http://m.enuri.com/mobilefirst/event2021/coupang_evt.jsp?oc=mo">URL 복사</button></li>
					</ul>
				</div>
			</div>
		</div>

		<!-- 버튼 : 꼭 확인하세요  -->
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop4"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 레이어 열기 -->
		</div>
		<div id="slidePop4" class="evt_notice--slide">
			<div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<dl>								
							<dt>이벤트 및 구매기간</dt>
							<dd>
								<ul>
									<li>2021년 5월 17일 ~  2021년 6월 30일</li>
								</ul>
							</dd>
						</dl>

						<dl>								
							<dt>당첨자 발표 및 경품지급일</dt>
							<dd>
								<ul>
									<li>당첨자 발표일 : 2021년 7월 28일</li>
									<li>당첨자 공지: 에누리 앱 > 이벤트/기획전 > 이벤트혜택 > 하단 '당첨자 발표' 에 공지</li>
								</ul>
							</dd>
						</dl>

						<dl>
							<dt>이벤트 참여방법</dt>
							<dd>
								<ul>
									<li>쿠팡 최대 5배 프로모션을 SNS를 통하여 공유 시 자동 참여</li>
								</ul>
							</dd>
						</dl>

						<dl>
							<dt>이벤트 경품</dt>
							<dd>
								<ul>
									<li>[ 스타벅스 ] 아이스 카페 아메리카노 ( e머니 4,100점 )</li>
									<li>e머니 유효기간 : 적립일로 부터 15일 ( 유효기간 만료 후 재적립 불가 )</li>
									<li>경품은 e쿠폰으로 교환 가능한 e머니로 적립되며,  e쿠폰 스토어에서 교환 가능</li>
									<li class="stress">※ 경품은 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격변동이 있을 수 있음</li>
								</ul>
							</dd>
						</dl>

						<dl>
							<dt>공통 이벤트 유의사항</dt>
							<dd>
								<ul>
									<li>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</li>
									<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
								</ul>
							</dd>
						</dl>
					</div>
				</div>
				<div class="evt_notice--foot">						
					<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 레이어 닫기 -->
				</div>
			</div>
		</div>
		<!-- // -->
	</div>
	<!-- // 이벤트04 -->

	<!-- 에누리 혜택 -->
    <div class="otherbene" id="evt5">
		<div class="contents">
			<h3 class="blind">놓칠 수 없는 특별한 혜택, 에누리 혜택</h3>
			<ul class="banlist">
				<li><a href="http://www.enuri.com/mobilefirst/evt/welcome_event.jsp?oc=" target="_blank" title="새창으로 이동"><img src="http://img.enuri.info/images/event/2021/coupang_new/m_otherbene_bnr1.png" alt="첫 구매 고객이라면! WELCOME 혜택"></a></li>
				<li><a href="http://www.enuri.com/evt/visit.jsp" target="_blank" title="새창으로 이동"><img src="http://img.enuri.info/images/event/2021/coupang_new/m_otherbene_bnr2.png" alt="100% 당첨! 매일받는 e머니 도전!프로출첵러"></a></li>
				<li><a href="http://www.enuri.com/event2019/smart_benefits.jsp?&tab=plus" target="_blank" title="새창으로 이동"><img src="http://img.enuri.info/images/event/2021/coupang_new/m_otherbene_bnr3.png" alt="받고 또 받는 카테고리 혜택 최대 적립 5만점"></a></li>
				<li class="ben_item--04"><a href="http://m.enuri.com/m/index.jsp?null#evt" target="_blank" title="새창으로 이동"><img src="http://img.enuri.info/images/event/2021/coupang_new/m_otherbene_bnr4.png" alt="아직 끝나지 않은 에누리 혜택, 더 많은 이벤트"></a></li>
			</ul>
		</div>
    </div>
    <!-- // -->

	<!-- //Contents -->	
<!--	<span class="go_top"><a href="#">TOP</a></span>-->
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

<!-- 200310 추가 : 공통 : SNS공유하기 -->
<div class="com__share_wrap dim" style="z-index:10000;display:none">
	<div class="com__layer share_layer">
		<div class="lay_head">공유하기</div>
		<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
		<div class="lay_inner">
			<ul>
				<li class="share_fb">페이스북 공유하기</li>
				<li class="share_kakao" id="kakao-share-btn">카카오톡 공유하기</li>				
				<li class="share_tw">트위터 공유하기</li>
				<!-- <li class="share_line">라인 공유하기</li> -->
				<!-- 메일아이콘 클릭시 활성화(.on) -->
				<!-- <li class="share_mail" onclick="$(this).toggleClass('on');$(this).parents('.share_layer').find('.btn_wrap').toggleClass('mail_on');">메일로 공유하기</li> -->
				<!-- <li class="share_story">카카오스토리 공유하기</li> -->
				<!-- <li class="share_band">밴드 공유하기</li> -->
			</ul>
			<!-- 메일보내기 버튼클릭시 .mail_on 추가해 주세요 -->
			<div class="btn_wrap">
				<div class="btn_group">
					<!-- 주소복사하기 -->
					<div class="btn_item">
						<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2021/coupang_evt.jsp?oc=mo</span>
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
<!-- // -->	

<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>

<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20180831"></script>
<script>
	(function (global, $) {
		$(function () {
			var $menu = $('.floattab__list li'),
			$contents = $('.scroll');

			// 해당 섹션으로 스크롤 이동 
			$menu.on('click', 'a', function (e) {
				e.preventDefault();
				var $target = $(this).parent(),
					idx = $target.index(),
					offsetTop = Math.ceil($contents.eq(idx).offset().top);


				
				if(idx == 0){
					console.log("idx : "+idx);
					ga('send', 'event', 'mf_event', '쿠팡프로모션','상단탭_5배적립');
				}else if(idx == 1){
					console.log("idx : "+idx);
					ga('send', 'event', 'mf_event', '쿠팡프로모션','상단탭_구매이벤트');
				}else if(idx == 2){
					console.log("idx : "+idx);
					ga('send', 'event', 'mf_event', '쿠팡프로모션','상단탭_쿠팡인기상품');
				}else if(idx == 3){
					console.log("idx : "+idx);
					ga('send', 'event', 'mf_event', '쿠팡프로모션','상단탭_소문내기이벤트');
				}

				$menu.closest("li").removeClass("is-on");
				$(this).closest("li").addClass("is-on");

				$('html, body').stop().animate({ scrollTop: offsetTop }, 500);
				return false;
			});

		});
	}(window, window.jQuery));
	
	// 공통 : 유의사항 레이어 열기/닫기
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
			var thisClosest = $(this).closest('.evt_notice--slide')
			el.btnSlide.toggleClass('on');
			$(thisClosest).slideToggle();
			$('html,body').stop(0).animate({scrollTop:$(thisClosest).siblings(".com__evt_notice").offset().top - 50});
		})
	})

	// 공통 :  하단 컨텐츠로 바로 진입시 포지션 보정을 위한 스크립트 처리
	$(function(){
		if(window.location.hash) {
			var $hash = $("#"+window.location.hash.substring(1));
			var navH = $(".navtab").outerHeight();
			if ( $hash.length ){
				$("html,body").stop(true,false).animate({"scrollTop": $hash.offset().top - navH},"slow");
			}
  		}
	})

    // 퍼블테스트용 : 팝업 on/off
    function onoff(id) {
        var mid=document.getElementById(id);
        if(mid.style.display=='') {
            mid.style.display='none';
        }else{
            mid.style.display='';
        }
    }







	Kakao.init('5cad223fb57213402d8f90de1aa27301');

	var app = getCookie("appYN"); //app인지 여부
	var username = "<%=userArea%>"; //개인화영역 이름
	var vChkId = "<%=chkId%>";
	var vEvent_page = "<%=strUrl%>"; //경로
	var vEvent_title = "에누리에서 신규회원 쿠팡 상품 구매시 최대 5배 적립!";
	var isFlow = "<%=flow%>" == "ad";
	var vOs_type = getOsType();
	var state = false;
	var tab = "<%=tab%>";

	var pageno = 1;
	var pagesize = 5;
	var totalcnt = 0;
	var event_id = <%=strEventId%>;

	$(".go_top").click(function(){		$('body, html').animate({scrollTop:0}, 500);	});

	var shareUrl = "http://" + location.host + "/mobilefirst/event2021/coupang_evt.jsp?oc=mo";
	var shareTitle = "<%=strFb_title%> <%=strFb_description%>";

	var oc = '<%=oc%>';
	var anker = '<%=anker%>';
	var hash = window.location.hash;

	getGoodsList();

	if(islogin()){
		global_share('kakao');
	}

	$(document).ready(function() {
		if(oc!=""){
			$('.lay_only_mw').show();
		}

		$(".ben_item--04").click(function(){
			if(navigator.userAgent.indexOf("Android") > -1){
				var url = (app != "Y" ? "/mobilefirst/index.jsp#evt" : "/mobilefirst/index.jsp#evt")
				window.open(url);
			}else{
				var url = (app != "Y" ? "/mobilefirst/index.jsp#evt" : "/mobilefirst/renew/plan.jsp?freetoken=main_tab|event")
				window.open(url);
			}
			
		});

		ga('send', 'event', 'mf_event', '쿠팡프로모션','쿠팡프로모션_PV');		

		$("#my_emoney").click(function(){	
			window.location.href = "https://m.enuri.com/my/my_emoney_m.jsp?freetoken=emoney";	//e머니 적립내역
		});

		shareSns('kakao');
	
		//공유하기
		$(".share_kakao").on('click', function(){
			shareSns('kakao');
		});
		$(".share_fb").on('click', function(){
			shareSns('face');
		});
		$(".share_tw").on('click', function(){
			shareSns('twitter');
		});
		
		
		$(".btn_login").click(function(){
			location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
			return false;
		})

		if(islogin()){
			getPoint();
		}

		$(".cate_list > li").click(function(){
			
			var inx = $(this).index();
			
			if(app == "Y"){
			
				if(!islogin()){
					alert("로그인 후 참여가능합니다.");
					location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
					return false;
				}else{
					
					if(inx == 0){
						location.href = "http://m.enuri.com/mobilefirst/cpp2.jsp?gcate=6&freetoken=cpp&gcate=6";
						GA("카테고리_#유아/완구");
					}else if(inx == 1){
						location.href = "http://m.enuri.com/mobilefirst/list.jsp?cate=1501&freetoken=list";
						GA("카테고리_#식품");
					}else if(inx == 2){
						location.href = "http://m.enuri.com/mobilefirst/cpp2.jsp?gcate=5&freetoken=cpp&gcate=5";
						GA("카테고리_#스포츠");
					}else if(inx == 3){
						location.href = "http://m.enuri.com/cpp/cpp_m.jsp?freetoken=list";
						GA("카테고리_#컴퓨터/노트북");
					}else if(inx == 4){
						location.href = "http://m.enuri.com/mobilefirst/cpp2.jsp?gcate=1&freetoken=cpp&gcate=1";
						GA("카테고리_#가전");
					}else if(inx == 5){
						location.href = "http://m.enuri.com/mobilefirst/cpp2.jsp?gcate=2&freetoken=cpp&gcate=2";
						GA("카테고리_#TV/카메라");
					}else if(inx == 6){
						location.href = "http://m.enuri.com/mobilefirst/cpp2.jsp?gcate=4&freetoken=cpp&gcate=4";
						GA("카테고리_#디지털");
						
					}else if(inx == 7){
						location.href = "http://m.enuri.com/mobilefirst/cpp2.jsp?gcate=7&freetoken=cpp&gcate=7";
						GA("카테고리_#가구/생활");				
					}else if(inx == 8){
						location.href = "http://m.enuri.com/mobilefirst/list.jsp?cate=0801&freetoken=list";
						GA("카테고리_#화장품");
					}
					return false;
				}
				
			}else{
				onoff('app_only');
			}
		});

		$(".btn_coupang").click(function(){
			console.log("islogin() : "+islogin());
		
			if(app == "Y"){
			
				if(islogin()){
					if(!getSnsCheck()){
						if (confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?") == true){    
							location.href="<%=ConfigManager.ENURI_COM_SSL%>/mobilefirst/member/myAuth.jsp?cmdType=modify&f=p";
						}else{
							return false;
						}
					}else{
//						window.open("/mobilefirst/move2.jsp?vcode=7861&url=http%3A%2F%2Flanding.coupang.com%2Fpages%2FM_home%3Fsrc%3D1033035%26amp%3Bspec%3D10305201%26amp%3Blptag%3DEnuri_M_logo%26amp%3BforceBypass%3DY");	
//						return false;
//						goGateShopUrl('7861','','쿠팡');
						goGateShopUrl('7861','http://landing.coupang.com/pages/M_home?src=1033035&spec=10305201&lptag=Enuri_M_logo&forceBypass=Y');

					}

					
				}else{
					alert("로그인 후 참여가능합니다.");
					location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
					return false;
					
				}
			
			}else{
				onoff('app_only');
			}

		});
		
	});


	function getPoint(){
		$.ajax({ 
			type: "GET",
			url: "/mobilefirst/emoney/emoney_get_point.jsp",
			async: false,
			dataType:"JSON",
			success: function(json){
				remain = json.POINT_REMAIN;	//적립금
				$("#my_emoney").html(CommaFormattedN(remain) +""+json.POINT_UNIT);
				
			}
		});
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
			}
			/* ,error: function (xhr, ajaxOptions, thrownError) {
				alert(xhr.status);
				alert(thrownError);
			} */
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

	//구매후응모 이벤트
	$(".btn_join").click(function(){

		if(app == "Y"){
		
			if(!islogin()){
				alert("로그인 후 참여가능합니다.");
				location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
				return false;
			}else{
				if(!getSnsCheck()){
					if (confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?") == true){    
						location.href="<%=ConfigManager.ENURI_COM_SSL%>/mobilefirst/member/myAuth.jsp?cmdType=modify&f=p";
					}else{
						return false;
					}
				}else{

					var osType = "MA";
					$.ajax({
						url : "/mobilefirst/evt/ajax/coupang_setlist.jsp",
						data : {
							"proc" : 2,
							"osType" : osType,
							"ostpcd" : vOs_type

						},
						dataType : "JSON",
						success : function(data){
							//console.log("coupang_setlist data : "+JSON.stringify(data));

							let result = data.result;
							if(result == 1){
								alert("정상 참여 되었습니다.");
							}else if(result == 2601){
								alert("이미 참여 하셨습니다..");
							}else if(result == 2602){
								alert("이벤트 대상자가 아닙니다.");
							}else if(result == 2603){
								alert("구매 후 응모해주세요.");
							}else if(result == 2604){
								alert("이벤트 대상자가 아닙니다.(직원)");
							}else{
								alert("이벤트 대상자가 아닙니다.");
							}

							
						}


					});
				}
				
			}
		
		}else{

			onoff('app_only');
		}


	});



	//공유하기 이벤트
	$("#share_list li").unbind();
	$("#share_list li").click(function(){
		ga('send', 'event', 'mf_event', '쿠팡프로모션','쿠팡SNS공유_PV');

		if(islogin()){
			var n = $(this).index()+1;
			shareEvent(n);
		}else{
			alert("로그인 후 참여할 수 있습니다.");
			goLogin();
			global_share("kakao");
			return ;
		}
	});

	//공유하기 이벤트 참여자
	//공유하기evt
	function shareEvent(n){
		var shareType = n;
		if(n==1) shareType=2;
		else if(n==2) {
			shareType=1;
			shareSns("face");
		}else if(n==3) {
			shareType=4;
			shareSns("twitter");
		}else if(n==4) {
			shareType=3;
			if(ClipboardJS.isSupported()) {
				var clipboard = new ClipboardJS('#share_list .btn__sns4');
				var cnt = 0;
				clipboard.on('success', function(e) {
					if(cnt==0) alert("복사가 완료되었습니다!");
					cnt++;
				}).on('error', function(e) {
					alert("해당 브라우저는 지원하지 않습니다.");
				});
			}
		}
		var osType = "";
		if(app =='Y'){
			osType = "MA";
		}else {
			osType = "MW";
		}
		$.ajax({
			url : "/mobilefirst/evt/ajax/coupang_setlist.jsp",
			data : {
				"proc" : 3,
				"shareType" : shareType,
				"osType" : osType
			},
			dataType : "JSON",
			success : function(data){
				console.log("coupang_setlist data : "+JSON.stringify(data));

				if(typeof data["result"] !="undefined"){
					if(data["result"]){
						if(n==1){
							global_share('kakao');
						}
					}
				}
			}
		});
	}

	function global_share(part){
		var share_url = "http://" + location.host + "/mobilefirst/event2021/coupang_evt.jsp?oc=mo";
		var share_title = "에누리에서 신규회원 쿠팡 상품 구매시 최대 5배 적립!";
		var share_description = "신규 회원을 위한 특별 혜택 친구에게 공유하고 스타벅스 받자!";
		var imgSNS = "<%=strFb_img%>";
		if(part == "face"){
			shareSns("face");
		}else if(part == "kakao"){
			try{
				Kakao.Link.createDefaultButton({
					container: '#kakao-link-btn2',
					objectType: 'feed',
					content: {
						title: share_title,
						imageUrl: imgSNS,
						link: {
							mobileWebUrl: share_url,
						}
					},
					buttons: [
					{
						title: '상세정보 보기',
						link: {
							mobileWebUrl: share_url,
						}
					}
					]
				});
			}catch(e){
				alert("카카오 톡이 설치 되지 않았습니다.");
				alert(e.message);
			}
		}else if (part == "tw") {
			try {
				window.android.android_window_open("http://twitter.com/intent/tweet?text=" + share_title + "&url=" +share_url);
			} catch (e) {
				window.open("http://twitter.com/intent/tweet?text=" + share_title + "&url=" + share_url);
			}
		}
	}

	//sns 공유하기 함수
	function shareSns(param){
		ga('send', 'event', 'mf_event', '쿠팡프로모션','쿠팡SNS공유_PV');

		var share_url = "http://" + location.host + "/mobilefirst/event2021/coupang_evt.jsp?oc=mo";
		var share_title = "에누리에서 신규회원 쿠팡 상품 구매시 최대 5배 적립!";
		var share_description = "신규 회원을 위한 특별 혜택 친구에게 공유하고 스타벅스 받자!";
		var imgSNS = "<%=strFb_img%>";

		if(param == "face"){
			try{
				window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
				//ga("send", "event", "mf_event", vEvent_title +"_APP", "공유하기_페이스북");
			}catch(e){
				window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
				//ga("send", "event", "mf_event", vEvent_title +"_WEB", "공유하기_페이스북");
			}
		}else if(param == "kakao"){
			try{
				Kakao.Link.createDefaultButton({
					container: '#kakao-share-btn',
					objectType: 'feed',
					content: {
						title: share_title,
						imageUrl: imgSNS,
						description : share_description,
						link: {
							mobileWebUrl: share_url,
						}
					},
					buttons: [
					{
						title: '상세정보 보기',
						link: {
							mobileWebUrl: share_url,
						}
					}
					]
				});
			}catch(e){
				alert("카카오 톡이 설치 되지 않았습니다.");
				alert(e.message);
			}
		}else if(param == "twitter"){
			var share_title_twi = "에누리에서 신규회원 쿠팡 상품 구매시 최대 5배 적립!";
			window.open("https://twitter.com/intent/tweet?text="+share_title_twi+"&url="+share_url);
		}
	}
	function CommaFormattedN(amount) {
	  var delimiter = ","; 
	  var i = parseInt(amount);

	  if(isNaN(i)) { return ''; }
	  
	  var minus = '';
	  
	  if (i < 0) { minus = '-'; }
	  i = Math.abs(i);
	  
	  var n = new String(i);
	  var a = [];

	  while(n.length > 3){
		  var nn = n.substr(n.length-3);
		  a.unshift(nn);
		  n = n.substr(0,n.length-3);
	  }
	  if (n.length > 0) { a.unshift(n); }
	  n = a.join(delimiter);
	  amount = minus + (n+ "");
	  return amount;
	}

	function view_moapp(){
		var chrome25;
		var kitkatWebview;
		var uagentLow = navigator.userAgent.toLocaleLowerCase();
		var openAt = new Date;
		var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2021%2Fcoupang_evt.jsp%3Ffreetoken%3Devent";
		
		if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
			goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2021/coupang_evt.jsp?freetoken=event";
			chrome25 = uagentLow.search("chrome") > -1 && navigator.appVersion.match(/Chrome\/\d+.\d+/)[0].split("/")[1] > 25;
			kitkatWebview = uagentLow.indexOf("naver") != -1 || uagentLow.indexOf("daum") != -1;
			if(kitkatWebview){
				setTimeout( function() {
					if (new Date - openAt < 1100) {
						if (uagentLow.search("android") > -1) {
							location.href = "market://details?id=com.enuri.android";
						}
					}
				}, 1000);
			}else{
				setTimeout( function() {
					if (new Date - openAt < 1500) {
						if (uagentLow.search("android") > -1) {
							location.href = "market://details?id=com.enuri.android";
						}
					}
				}, 1000);
			}
			if(uagentLow.search("android") > -1){
				chrome25 = uagentLow.search("chrome") > -1 && navigator.appVersion.match(/Chrome\/\d+.\d+/)[0].split("/")[1] > 25;
				kitkatWebview = uagentLow.indexOf("naver") != -1 || uagentLow.indexOf("daum") != -1;
				if (chrome25 && !kitkatWebview){
					location.href = goApp;
				} else{
					location.href = goApp;
				}
			}
		}else{
			setTimeout( function() {
				window.location.replace("https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8");
			}, 2000);
			location.href = goApp;
		}
	}

	function da_ga(num){
		if(num == 2){
			ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_SNS공유_PV");
		}else if(num == 3){
			ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"테스트시작");
		}
	}

	function GA(label){
		ga('send', 'event', 'mf_event', '쿠팡프로모션',label);		
	}

	function getGoodsList(){
		 
		$.ajax({
			type: "GET",
			url: "/event/ajax/evt_coupang_goods_ajax.jsp?p=list&evnt_id=2021051701",
			dataType: "JSON",
			success: function(json){
				
				var html = "";
				var cnt = 0;
				$.each(json[0].coupang_admin_data , function(i,v){
					
					if(v.so_yn != 'N') return true;
					
					html += "<li data-modelno='"+v.modelno+"' data-gm='"+v.evnt_gd_nm+"' >";
					html += "<a href=\"javascript:///\" >";
					html += "<span class=\"thumb\">";
					//html += "			<span class=\"ico_soldout\">SOLDOUT</span>";
					html += "			<img src='"+default_src+v.gd_img_url+"' alt=''>";
					html += "		</span>";
					html += "		<span class=\"info\">";
					html += "			<span class=\"txt_name\">"+v.evnt_gd_nm+"</span>";
					html += "			<span class=\"txt_price\">";
					html += "				<span class=\"txt_lowest\">최저가</span><em>"+commaNum(v.minprice3)+"</em>원";
					html += "			</span>";
					html += "		</span>";
					html += "	</a>";
					html += "</li>";
					cnt++;
					
				});
				
				$.each(json[1].coupang_cate_data ,function(i,v){

					if(cnt == 20) return false; 
					
					html += "<li data-modelno='"+v.modelno+"' >";
					html += "<a href=\"javascript:///\" >";
					html += "<span class=\"thumb\">";
					//html += "			<span class=\"ico_soldout\">SOLDOUT</span>";
					html += "			<img src='"+v.img+"' alt=''>";
					html += "		</span>";
					html += "		<span class=\"info\">";
					html += "			<span class=\"txt_name\">"+v.modelnm+"</span>";
					html += "			<span class=\"txt_price\">";
					html += "				<span class=\"txt_lowest\">최저가</span><em>"+commaNum(v.minprice3)+"</em>원";
					html += "			</span>";
					html += "		</span>";
					html += "	</a>";
					html += "</li>";
					
					cnt++;
				});
				$("#goodsList").html(html);
				
				$("#goodsList > li").click(function(){
					var goodsnm = $(this).attr("data-gm");
					var modelno = $(this).attr("data-modelno");
					//var url = "/mobilefirst/detail.jsp?modelno="+modelno;
					var url = "/m/vip.jsp?modelno="+modelno;
					
					
					GA("상품_#"+goodsnm);
					
					if( app == "Y" ){
						
						if(!islogin()){
							alert("로그인 후 참여가능합니다.");
							location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
							return false;
						}else{
							$.ajax({
								type: "GET",
								url: "/mobilefirst/evt/ajax/ajax_get_certi.jsp",
								dataType: "JSON",
								success: function(json){
									var cikeycnt = json.cikeyCnt;
									var result = json.result;
									
									if(cikeycnt > 0|| result == "S"){
										//window.open(url);		
										location.href = url;
									}else{
										var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
										if(r){
											location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
										}
									}
									return false;
									
								}
							});
						}
						
					}else{

						onoff('app_only');
					}
				});
			},
			error: function (xhr, ajaxOptions, thrownError) {
				alert("잘못된 접근입니다.");
				//alert(thrownError);
			},
			complete : function() {
				if(anker){
					setTimeout(function(){
						$("#evt"+anker).click();
						location.hash = "#evt"+anker;
					}	,300)
				}
				
				
			}
		});
	}

	function goGateShopUrl(shop,url){
		window.open("/mobilefirst/move2.jsp?vcode="+shop+"&url="+encodeURIComponent(url));	
		return false;
	}
</script> 
</body>
</html>