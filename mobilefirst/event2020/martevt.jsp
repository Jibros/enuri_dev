<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
String strFb_title = "[에누리 가격비교] 스피드 장보기에-누리다";
String strFb_description = "장바구니에 담으면 에누리가 쏜다";
String strFb_img = ConfigManager.IMG_ENURI_COM+"/images/event/2020/enuri_mart/sns_share_mart.jpg";

if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{ //pc일때 접속페이지 변경.
	response.sendRedirect("/event2020/martevt.jsp");
	return;
}
String oc = ChkNull.chkStr(request.getParameter("oc"), "");
String chkId     = ChkNull.chkStr(request.getParameter("chk_id"),"");
String cUserId   = cb.GetCookie("MEM_INFO","USER_ID");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

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
	<META NAME="keyword" CONTENT="에누리가격비교, 프로모션, 스피드장보기">
	<meta property="og:title" content="<%=strFb_title%>">
	<meta property="og:description" content="<%=strFb_description%>">
	<meta property="og:image" content="<%=strFb_img%>">
	<meta name="format-detection" content="telephone=no" />
	<!-- 프로모션 공통 CSS (Mobile) -->
	<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
	<link rel="stylesheet" href="/css/event/y2020/enuri_mart_m.css" type="text/css">
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
			<p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>	
			<%}else{%>
			<p class="name"><%=userArea%> 님<span id="my_emoney">0점</span></p>
			<%}%>
		<a href="javascript:///" class="win_close">창닫기</a>
	</div>
	
	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">
		<!-- visual -->
		<div class="visual">		
			<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
			<span class="spot"></span>
			<div class="inner">
				<span class="tx_sub">#최저가 한눈에#주문을 한번에#배송은 빠르게</span>
				<h2 class="tx_tit">스피드 장보기</h2>
				<span class="obj_vege"></span>
			</div>	
			<div class="loader-box">
				<div class="visual-loader"></div>
			</div>
			<script>
				// 상단 타이들 등장 모션
				$(window).load(function(){
					var $visual = $(".toparea .visual");
					$visual.addClass("intro");
					setTimeout(function(){
						$visual.addClass("end");
					},2000)
				})
			</script>	
		</div>
	</div>
	<!-- //비쥬얼,플로팅탭 -->
	
	<!-- 네비 -->
	<div class="section floattab">
		<div class="contents">
			<ul class="floattab__list">
				<li><a onclick="da_ga(2);" href="#evt2" class="floattab__item floattab__item--01"><em>퀴즈만 맞춰도 <strong>다이슨 선풍기</strong></em></a></li>
				<li><a onclick="da_ga(3);" href="#evt3" class="floattab__item floattab__item--02"><em>장바구니 담으면 <strong>결제는 에누리가!</strong></em></a></li>
			</ul>
		</div>
	</div>
	<!-- // -->
	
	<!-- 이벤트01 -->
	<div id="evt1" class="section event_01"><!-- 이벤트 1 앵커 영역 -->
		<div class="intro_wrap">
			<div class="intro_cont">
				<div class="intro_slide">
					<h3>
						#최저가 한눈에 #주문을 한번에 #배송은 더 빠르게
						<em>스피드 장보기 이용방법</em>
					</h3>
					<div class="swiper-container" onclick="da_ga(4);return false;">
						<div class="swiper-wrapper">
							<div class="swiper-slide"><div class="slide_inner"><img src="http://img.enuri.info/images/event/2020/enuri_mart/m_slide_01.png" alt="마트별 가격비교로 최저가를 한눈에!"></div></div>
							<div class="swiper-slide"><div class="slide_inner"><img src="http://img.enuri.info/images/event/2020/enuri_mart/m_slide_02.png" alt="장바구니에 담아주문을 한번에!"></div></div>
							<div class="swiper-slide"><div class="slide_inner"><img src="http://img.enuri.info/images/event/2020/enuri_mart/m_slide_03.png" alt="지역별 배송으로 배송을 더 빠르게!"></div></div>
						</div>
					</div>
					<div class="swiper-pagination"></div>
					<!-- 버튼 : 스피드 장보기 -->
					<a href="#" class="btn_go_mart">스피드 장보기</a>
				</div>
			</div>
		</div>
		<script>
			$(function(){
				var $slide = ".event_01 .intro_slide";
				var mySwiper = new Swiper($slide +' .swiper-container',{
					pagination : $slide +' .swiper-pagination',
					autoplay : 4000,
					autoplayDisableOnInteraction:false,
					centeredSlides : true,
					slidesPerView : 1,
					loop : false,
					speed : 1000
				});
			})
		</script>
	</div>
	<!-- // 이벤트01 -->
	
	<!-- 이벤트02 -->
	<div id="evt2" class="section event_02 scroll">				
		<div class="event_wrap">
			<h3>퀴즈만 풀어도 <em>삼성 에어드레서 득템!</em></h3>
			<div class="gift">
				<dl class="blind">
					<dt>경품</dt>
					<dd>
						<ul>
							<li>삼성전자 에어드레서 DF60t8301kg (실물배송) - 1명추첨</li>
							<li>GS25 온라인 상품권 3천원 e머니 3,000점 - 50명 추첨</li>
						</ul>
					</dd>
				</dl>
			</div>
		</div>
		<div class="quiz_wrap">
			<dl>
				<dt>
					마트별 최저가 비교 더 쉽게! 주문은 더 편하게! 배송은 더 빠르게! 
					<em>바쁜 일상을 위한 에누리의 새로운 마트 쇼핑 서비스는?</em>
				</dt>
				<dd>
					<div class="group_inp">
						<!-- 정답입력 -->
						<input type="text" maxlength="1" name="text1" id="text1" ><input type="text" name="text2" id="text2"  maxlength="1"><input type="text" maxlength="1" name="text3" id="text3" >
					</div>
					<span class="tx_box">장</span><span class="tx_box">보</span><span class="tx_box">기</span>
				</dd>
			</dl>
			<script>
				$(function(){
					$(".quiz_wrap .group_inp input").keyup(function(e){
						if($(this).val().length >= 2 ){
							$(this).next('input').focus();
						}
					});
				})
			</script>
			<!-- 버튼 : 응모하기 -->
			<a href="javascript:///" onclick="da_ga(6);return false;" class="btn_apply">응모하기</a>
			
			
		</div>
		<!-- 버튼 : 꼭 확인하세요 -->
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop1"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop1" class="evt_notice--slide" style="display: none;">
			<div class="evt_notice--inner">
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<ul class="list__event">
						<li>이벤트 참여 : ID당 1회 참여 가능</li>
						<li>당첨자 혜택 : <br>
							[삼성전자] 에어드레서 DF60T8301KG (실물배송) – 추첨 1명	
							<span class="tx_noti">※제세공과금 당첨자 부담</span><br>
							[GS25] 온라인 상품권 3천원 (e머니 3,000점) – 추첨 50명
						</li>
						<li>e쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립해드립니다.<br>
						(제휴처의 사정에 따라 해당 쿠폰 품절, 단종, 가격 변동 등이 있을 수 있습니다.)</li>
						<li>잘못된 정보입력으로 인한 경품 수령의 불이익은 책임지지 않습니다.</li>
						<li>이벤트 기간 : 2020년 9월 28일 ~ 2020년 10월 31일</li>
						<li>당첨자 발표 : 2021년 1월 5일 화요일<br>[APP 이벤트/기획전 탭 &gt; 이벤트 하단 당첨자 발표]</li>
						<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다.</li>
						<li>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</li>
						<li>본 이벤트는 에누리앱에서만 응모 가능합니다.<!-- <br>
							<span style="color:#ff2424">※ 안드로이드 에누리 APP에서만 참여 가능합니다. 추후 아이폰 서비스 오픈시 아이폰에서 참여 가능합니다.</span> -->
						</li>
					</ul>
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
				// 200923 : SR#42513 : 스크립트 수정
				el.btnSlideClose.click(function(){ // 슬라이드 유의사항 닫기
					var $slide = $(this).closest('.evt_notice--slide');
					$slide.slideToggle();
					$slide.prev('.com__evt_notice').find(".btn__evt_notice").removeClass("on");
				})				
			})
		</script>
	</div>
	
	
	<!-- 이벤트03 -->
	<div id="evt3" class="section event_03 scroll">
		<div class="event_wrap">
			<h3>장바구니에 담으면 <em>결제는 에누리가 한다!</em></h3>
			<div class="noti">
				<!-- 200909 : SR#42231 : 문구수정/추가 -->
				<p class="blind">주기적으로 구매해야 하는 제품들을 나의 장보기 목록에 담아만 놓으세요!추첨을 통해 에누리가 E머니 5만점을 10분에게 지원해드립니다.</p>
				<dl>
					<dt>참여방법</dt>
					<dd>
						<ul>
							<li>에누리 APP로그인  &gt;  스피드장보기 접속  &gt; 나의 장보기 목록에 상품 담기  &gt; 이벤트응모</li>
						</ul>
					</dd>
				</dl>
				<!-- // -->
			</div>
			<div class="group_btn">
				<a href="javascript:///" id="go_mart"class="btn_go_app" >스피드장보기 바로가기</a>
				<a href="javascript:///" class="btn_invite" >이벤트 참여하기</a>
			</div>
		</div>
		<!-- 버튼 : 꼭 확인하세요 -->
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop2"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop2" class="evt_notice--slide">
			<div class="evt_notice--inner">
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="common__event">
						<strong>이벤트/구매 기간 : </strong>
						<ul class="txt_indent">
							<li>2020년 9월 28일 ~ 2020년 10월 31일</li>
						</ul>
						<strong>당첨자 발표 및 적립</strong>
						<ul class="txt_indent">
							<li>2021년 1월 5일 [APP 이벤트/기획전 탭 &gt; 이벤트 하단 당첨자 발표]</li>
						</ul>
						<strong>경품</strong>
						<ul class="txt_indent">
							<li>에누리 e머니 5만점 – 10명 추첨</li>
						</ul>
						<br>	
						<ul class="txt_indent">
							<li class="stress">이벤트 당첨 발표 시까지 ‘나의 장보기 목록 상품’을 유지하여야 하며 상품을 삭제할 경우 불이익을 받을 수 있습니다.</li>
						</ul>
						<br> 
						<ul class="txt_indent">
							<li>본 프로모션은 에누리앱에서만 참여 가능합니다.</li>
							<li><strong>e머니 유효기간 : 적립일로부터 15일</strong></li>
							<li>사정에 따라 경품이 변경될 수 있습니다.</li>
							<li class="stress">잘못된 정보 입력으로 인한 경품 수령의 불이익은 책임지지 않습니다.</li>
							<li>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</li>
							<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료 될 수 있습니다</li>
						</ul>
						<strong>이벤트 응모방법</strong>
						<ul class="txt_indent">
							<li>에누리 가격비교  : 어플 로그인 → 스피드 장보기 접속 → 나의 장보기 목록에 상품담기 → 이벤트 응모</li>
							<li>이벤트 참여대상 쇼핑몰 : 이마트몰, 쿠팡, 롯데마트몰, 홈플러스</li>
						</ul>
						<!-- <span class="stress">※ 안드로이드 에누리 APP에서만 참여 가능합니다. 추후 아이폰 서비스 오픈시 아이폰에서 참여 가능합니다.</span> -->
						<strong>
							스피드장보기 구매적립 및 유의사항<br>
							<span class="stress">※에누리 앱에서 스피드장보기 구매시만 해당됩니다.</span>
						</strong>
						<ul class="txt_indent">
							<li>적립대상 쇼핑몰: 쿠팡, 이마트, 홈플러스</li>
							<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다.</li>
							<li>구매적립 e머니는 구매확정(구매일로부터 최대 30일) 시점부터 MY 에누리 적립내역 페이지에서 확인 가능합니다.</li>
							<li>구매 e머니는 카테고리에 따라 차등 적립</li>
						</ul>
						<strong>※ 스피드장보기 카테고리별 적립률 상세</strong>
						<div class="tb">
							<table>
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
										<td>식품</td>
										<td>1.0%</td>
									</tr>
									<tr>
										<td>생활</td>
										<td>0.2%</td>
									</tr>
								</tbody>
							</table>
						</div>
						<br>
						<ul class="txt_indent">
							<li>적립대상 쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제 시 구매건수는 1건이며, 구매금액을 통한 결제한 금액의 e머니 적립 됩니다.</li>
							<li>구매적립 e머니는 구매일로부터 10~30일간 취소/환불/교환/반품여부 확인 후 적립됩니다.</li>
							<li>구매적립 e머니는 최소 10점(구매금액 1천원 이상)부터 적립되며, 1원 단위 e머니는 적립되지 않습니다.</li>
							<li class="stress">구매적립 e머니 유효기간 : 적립일로부터 60일 (유효기간 만료 후 재적립 불가)</li>
							<li>적립된 e머니는 e쿠폰 스토어에서 다양한 e쿠폰으로 교환 가능합니다.</li>
						</ul>
						<strong>아래의 경우에는 구매 확인 및 적립이 불가합니다.</strong>
						<ul class="txt_indent">
							<li>에누리 가격비교 앱 스피드장보기 서비스가 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱을 통해 결제만 한 경우</li>
							<li>에누리 가격비교 앱 미 로그인 후 스피드장보기로 구매한 경우</li>
							<li>에누리 가격비교 앱에서 적립대상이 아닌 쇼핑몰(롯데마트몰)에서 구매한 경우</li>
						</ul>
						<strong>적립대상쇼핑몰 중 e머니 적립 제외 카테고리/서비스</strong>
						<ul class="txt_indent">
							<li>에누리 가격비교 앱 스피드장보기 서비스에서 검색되지 않는 상품</li>
						</ul>
					</div>
				</div>
				<div class="evt_notice--foot">						
					<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 유의사항 닫기 -->
				</div>
			</div>
		</div>
	</div>

	<!-- <div class="aside_bnr_01">
		<a href="#"><img src="http://img.enuri.info/images/event/2020/enuri_mart/m_bnr_aside_01.jpg" alt="함께해요! 지역경제 살리기"></a>
	</div> -->

	
</div>

<!-- (신규) 공통 : SNS공유하기 -->
<div class="com__share_wrap dim" style="z-index:10000;display:none">
	<div class="com__layer share_layer">
		<div class="lay_head">공유하기</div>
		<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
		<div class="lay_inner">
			<ul id="eventShr">
				<li id="fbShare" class="share_fb">페이스북 공유하기</li>
				<li class="share_kakao" id="kakao-link-btn" >카카오톡 공유하기</li>				
				<li id="twShare" class="share_tw">트위터 공유하기</li>
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
						<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2020/martevt.jsp?oc=mo</span>
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
<div class="layer_back" id="app_only1" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 서비스</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only1').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();" >설치하기</button></p>
	</div>
</div>

<div class="layer_back" id="app_only2" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only2').hide();">창닫기</a>
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
Kakao.init('5cad223fb57213402d8f90de1aa27301');

var app = getCookie("appYN"); //app인지 여부
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로
var vEvent_title = "스피드장보기";
var isFlow = "<%=flow%>" == "ad";
var vOs_type = getOsType();
var state = false;
var tab = "<%=tab%>";

$(".go_top").click(function(){		$('body, html').animate({scrollTop:0}, 500);	});

var shareUrl = "http://" + location.host + "/mobilefirst/event2020/martevt.jsp?oc=mo";
var shareTitle = "<%=strFb_title%> <%=strFb_description%>";

var oc = '<%=oc%>';

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

	//스크롤
	var nav = $('.myarea'); 
	$(window).scroll(function () {
		if ($(this).scrollTop() > $(".toparea").height()) {
			nav.addClass("f-nav");
		} else {
			nav.removeClass("f-nav");
		}
	});
}(window, window.jQuery));

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
	ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_PV");
	
	if(oc!=""){
		$('.lay_only_mw').show();
	}
	$("#my_emoney").click(function(){	
		window.location.href = "https://m.enuri.com/my/my_emoney_m.jsp?freetoken=emoney";	//e머니 적립내역
	});
	
	
	$(".btn_login").click(function(){
		location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
		return false;
	})
	$(".btn_apply").click(function(){
		if(app=="Y"){ 
			btn_apply();
		}else{
			$('.lay_only_mw').show();
			return false;
		} 
	});
	
	$(".btn_invite").click(function(){
		da_ga(8);
		if(app=="Y"){
			btn_invite();
		}else{
			$('.lay_only_mw').show();
			return false;			
		}
	});
	$(".btn_go_mart").click(function(){
		da_ga(5);
		if(app=="Y"){
			//if(navigator.userAgent.indexOf("Android") > -1){
				document.location.href="/m/index?freetoken=mart_home";
			/* }else{
				alert('iOS 서비스 준비 중입니다.\n현재 안드로이드에서만 참여 가능합니다.');
			} */
		}else{
			$('.lay_only_mw').show();
			return false;			
		}
	});
	$("#go_mart").click(function(){
		da_ga(7);
		if(app=="Y"){
			//if(navigator.userAgent.indexOf("Android") > -1){
				document.location.href="/m/index?freetoken=mart_home";
			/* }else{
				alert('iOS 서비스 준비 중입니다.\n현재 안드로이드에서만 참여 가능합니다.');
			} */
		 }else{
			 $('.lay_only_mw').show();
			return false;			
		}
	});
	
	$("#eventShr > li").click(function(){
		var sel = $(this).attr("id");
		
		if(sel == "fbShare"){
			try{
				window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(shareTitle)+"&u="+shareUrl);
			}catch(e){
				window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(shareTitle)+"&u="+shareUrl);
			}	
		}else if(sel == "twShare"){
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
	
	if(islogin()){
		getPoint();
	}
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
function btn_apply() {
	
	var text1 = $("#text1").val();
	var text2 = $("#text2").val();
	var text3 = $("#text3").val();
	
	var answer = text1+text2+text3;
	

	
	if(answer.length < 3 ){
		alert("정답을 입력해주세요!");
		return false;
	}
	
	if(!islogin()){
		
		alert("로그인 후 신청 가능합니다!");
		location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
		return false;
		
	}else{
		if(!getSnsCheck()){
		
			if (confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?") == true){    
				location.href="<%=ConfigManager.ENURI_COM_SSL%>/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
				return false;
			}else{
				return false;
			}
			
		}else{
			
			$.ajax({
				type: "GET",
				url: "/mobilefirst/evt/ajax/mart_setlist.jsp?proc=1&osType="+getOsType()+"&answer="+encodeURIComponent(answer),
				dataType: "JSON",
				async : false,
				success: function(json){
					if(json.result == 1){
						alert("응모완료! 당첨자 발표일을 기다려주세요");
					}else if(json.result == 2601){
						alert("이미 응모완료 되었습니다!");
					}else if(json.result == -99){
						alert("티몬에서 구매 후 응모 가능합니다.");
					}else if(json.result == 100){
						alert("이벤트가 종료 되었습니다.");
					}else if(json.result == -44){
						alert("정답을 확인해주세요");
					}else if(json.result == -100){
						alert("임직원은 참여 불가합니다.");
					}
					//onoff('agreeLayer1');
				}
				/* ,error: function (xhr, ajaxOptions, thrownError) {
					alert(xhr.status);
					alert(thrownError);
				} */
			});
			
		}
	}
}
function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2020%2Fmartevt.jsp%3Ffreetoken%3Devent";
	
	if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
		goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2020/martevt.jsp?freetoken=event";
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

function btn_invite() {
	
	if(!islogin()){
		
		alert("로그인 후 신청 가능합니다!");
		location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
		return false;
		
	}else{
		if(!getSnsCheck()){
		
			if (confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?") == true){    
				location.href="<%=ConfigManager.ENURI_COM_SSL%>/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
				return false;
			}else{
				return false;
			}
			
		}else{
			
			$.ajax({
				type: "GET",
				url: "/mobilefirst/evt/ajax/mart_setlist.jsp?proc=2&osType="+getOsType(),
				dataType: "JSON",
				async : false,
				success: function(json){
					
					if(json.result == 1){
						alert("응모완료! 당첨자 발표일을 기다려주세요");
					}else if(json.result == 2601){
						alert("이미 응모완료 되었습니다!");
					}else if(json.result == -99){
						alert("스피드 장보기 상품 담기 후 응모 가능합니다.");
					}else if(json.result == 100){
						alert("이벤트가 종료 되었습니다.");
					}else if(json.result == -100){
						alert("임직원은 참여 불가합니다.");
					}

				} 
				/* ,error: function (xhr, ajaxOptions, thrownError) {
					console.log(xhr.status);
					console.log(thrownError);
				} */
			});
			
		}
	}
}

function da_ga(num){
	if(num == 2){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_상단탭_이벤트1");
	}else if(num == 3){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_상단탭_이벤트2");
	}else if(num == 4){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_이용방법_이미지");
	}else if(num == 5){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_이용방법_서비스바로가기");
	}else if(num == 6){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_이벤트1_참여");
	}else if(num == 7){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_이벤트2_서비스바로가기");
	}else if(num == 8){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_이벤트2_참여");
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
CmdShare();
function CmdShare(){
	Kakao.Link.createDefaultButton({
	  container: '#kakao-link-btn',
      objectType: 'feed',
      content: {
        title: '<%=strFb_title%>',
        description: "<%=strFb_description%>",
        imageUrl: "<%=strFb_img%>",
			link : {
				webUrl : shareUrl,
				mobileWebUrl : shareUrl
			}
		},
		buttons : [ {
			title : '에누리 가격비교',
			link : {
			mobileWebUrl : shareUrl,
			webUrl : shareUrl
			}
		} ]
	});
}
</script>

</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
