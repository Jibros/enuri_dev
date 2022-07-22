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
    response.sendRedirect("/event2020/vip_award.jsp"); //pc url
    return;
}
String oc = ChkNull.chkStr(request.getParameter("oc")); 
long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String sdt = dayTime.format(new Date(cTime));//진짜시간

if( request.getServerName().indexOf("dev.enuri.com") > -1 && request.getParameter("sdt")!=null && !request.getParameter("sdt").equals("") ) {
	sdt = request.getParameter("sdt");
}

String cUserId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

Members_Proc members_proc = new Members_Proc();
String cUsername = "";
String userArea = "";

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;

    if(cUsername.equals(""))      userArea = cUserNick;
    if(userArea.equals(""))        userArea = cUserId;
    
}
String strEventId = "2020120125";
String tab = ChkNull.chkStr(request.getParameter("tab"));



%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<title>에누리(가격비교) eNuri.com</title>
<meta property="og:title" content="[에누리 가격비교] 2020 VIP AWARD!">
<meta property="og:description" content="소중한 당신께 감사를 전합니다♥">
<meta property="og:image" content="http://img.enuri.info/images/event/2020/vipaward/sns_1200_630.jpg">
<meta name="format-detection" content="telephone=no" />
<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<link rel="stylesheet" href="/css/event/y2020/vipaward_m.css" type="text/css">
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/event_regular.js?v=20200825"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script src="/mobilefirst/js/lib/clipboard.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
</head>
<body>
<script type="text/javascript">
var app = getCookie("appYN"); //app인지 여부
var username = "<%=userArea%>";
Kakao.init('5cad223fb57213402d8f90de1aa27301');
</script>
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
<div class="wrap" id="eventWrap">
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>
	
	
	<!-- 상단 비쥬얼 -->
	<div class="event_cont">

		<!-- visual -->
		<div class="section visual" style="margin-bottom: 0px;">
			<!-- 공통 : 공유하기 버튼  -->
			<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
			<!-- // -->
						
			<div class="inner">
				<span class="top_txt_01">2020 VIP AWARD</span>
				<div class="top_tit">
					<span class="mask">연말결산</span>
					<div class="glitter">
						<div class="bg_inner"></div>
					</div>
				</div>
				<span class="obj_flower"></span>
			</div>

			<div class="loader-box">
				<div class="visual-loader"></div>
			</div>
			<script>
				// 상단 타이들 등장 모션
				$(window).load(function(){
					var $visual = $(".event_cont .visual");
					$visual.addClass("intro");
					setTimeout(function(){
						$visual.addClass("end");
					},2000)
				})
			</script>
		</div>
		<!-- //visual -->
	</div>
	
	<!-- 네비 -->
	<div class="section floattab">
		<div class="contents">
			<ul class="floattab__list">
				<!-- 선택 : li class="is-on" -->
				<li class=""><a href="#evt1" class="floattab__item floattab__item--01">설문조사 하면 스타벅스 스콘</a></li>
				<li class=""><a href="#evt2" class="floattab__item floattab__item--02">특권받기 하면 e머니 20만점</a></li>
			</ul>
		</div>
	</div>
	<!--  -->
	
	<div id="evt1" class="section event_01 scroll"><!-- 이벤트 1 앵커 영역 -->
		<div class="evt_box">
			<h3>설문조사 - 소중한 고객님의 목소리를 들려주세요!</h3>
			<p class="blind">VIP 혜택 특권에-누리다. 이벤트 만족도 조사</p>
			<p class="blind">좋아요! 고객님의 목소리를 들려주세요!</p>
			<p class="blind">설문조사에 참여하시는 모든 분들께 선물을 드립니다.</p>

			<div class="img_evt">
				<!-- 대체 텍스트 -->
				<div class="blind">
					<dl>
						<dt>이벤트대상</dt>
						<dd>2020년 1월 ~ 9월 기간동안 더블적립 or 무제한적립 혜택 받은 고객</dd>
						<dt>이벤트 기간</dt>
						<dd>2020.12.1 ~ 12.31</dd>
						<dt>혜택 지급일</dt>
						<dd>2021. 1. 11</dd>
						<dt>이벤트 경품</dt>
						<dd>스타벅스 클래식 스콘(e머니 3,300점)</dd>
					</dl>
				</div>
				<!-- // -->

				<!-- 설문조사 레이어 띄울때 body 스크롤을 잠궈 줍니다. -->
				<!-- .scroll_lock 클래스 붙여주세요 -->
				<a href="#" class="btn_join" onclick="surveyGo();">참여하기</a>
			</div>
		</div>
		
		<!-- 버튼 : 꼭 확인하세요 -->
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop1"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop1" class="evt_notice--slide">
			<div class="evt_notice--inner">
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<dl>
							<dt>이벤트 대상 및 혜택</dt>
							<dd>
								<ul>
									<li>이벤트 대상 : 2020년 1월 ~ 9월 기간 동안 더블적립 or 무제한적립 혜택 받은 고객</li>
									<li>이벤트 기간 : 2020년 12월 1일 ~ 2020년 12월 31일</li>
									<li>이벤트 혜택 : 스타벅스 클래식 스콘 (e머니 3,300점)</li>
									<li>혜택 지급일 :&nbsp;2021년 1월 11일<br>
										<ul class="sub">
											<li>- 에누리 가격비교 APP &gt; 이벤트/기획전탭 &gt; 이벤트혜택 &gt; 하단 [당첨자/공지]</li>
										</ul>
									</li>
									<li><span class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span><br>
										<span class="noti">※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</span>
									</li>
								</ul>
							</dd>
						</dl>

						<dl>
							<dt>이벤트 참여방법 및 유의사항</dt>
							<dd>									
								<ul>
									<li>참여방법 : 에누리 가격비교 로그인 → 설문조사 이벤트 참여하기<br>
										<span class="noti">※ 이벤트 참여의 경우 PC 및 모바일 앱/웹에서 로그인 후에도 가능합니다.</span>
									</li>
									<li>본 이벤트는 본인인증 ID당 1회만 참여 가능합니다.</li>
									<li><span class="stress">이벤트 대상 제외 :</span> 아래의 경우에는 이벤트 대상 및 혜택 지급에서 제외됩니다.<br>
										<ul class="sub">
											<li>- 2020년 1월 ~ 9월 기간 동안 더블적립 or 무제한적립 혜택 받지않은 고객</li>
											<li>- 설문조사 이벤트 참여하지 않은 경우 </li>
											<li>- 이벤트와 무관한 부적절한 내용 입력하는 경우</li>
											<li>- 동일한 본인인증으로 가입한 다수의 ID로 중복 참여한 경우</li>
										</ul>
									</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>공통 이벤트 유의사항</dt>
							<dd>
								<ul>
									<li>부정 참여 시 본 이벤트 대상 제외 및 혜택 지급이 취소될 수 있습니다.</li>
									<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
								</ul>
							</dd>
						</dl>
					</div>
				</div>
				<div class="evt_notice--foot">						
					<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 유의사항 닫기 -->
				</div>
			</div>
		</div>
		<!-- // -->
	</div>
	<div id="evt2" class="section event_02 scroll">
		<div class="evt_box">
			<h3>VIP 특권 - 소중한 고객님의 e머니를 돌려드려요!</h3>
			<p class="blind">항상 에누리 가격비교에 관심주셔서 감사합니다.</p>
			<p class="blind">구매 NO! 특권받기 버튼만 눌러주세요!</p>
			<p class="blind">추첨을 통해 10분께 e머니 20만점 적립해드립니다.</p>

			<div class="img_evt">
				<!-- 대체 텍스트 -->
				<div class="blind">
					<dl>
						<dt>이벤트대상</dt>
						<dd>2020년 1월 ~ 9월 기간동안 더블적립 or 무제한적립 혜택 받은 고객</dd>							
					</dl>
					<p>※ 당첨 고객님께 특별한 메시지를 보내드립니다!</p>
					<span id="eventSpan" class="stress">이벤트 참여 시 자동으로 알림 동의가 설정됩니다.</span>
				</div>
				<!-- // -->
				<a href="javascript:///" class="btn_apply">신청하기</a>

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
					<div class="evt_notice--continner">
						<dl>
							<dt>이벤트 대상 및 혜택</dt>
							<dd>
								<ul>
									<li>이벤트 대상 : 2020년 1월 ~ 9월 기간 동안 더블적립 or 무제한적립 혜택 받은 고객</li>
									<li>이벤트 기간 : 2020년 12월 1일 ~ 2020년 12월 31일</li>
									<li>이벤트 혜택 : e머니 20만점 적립 - 10명 추첨</li>
									<li>혜택 지급일 :&nbsp;2021년 1월 11일<br>
										<ul class="sub">
											<li>- 에누리 가격비교 APP &gt; 이벤트/기획전탭 &gt; 이벤트혜택 &gt; 하단 [당첨자/공지]</li>
										</ul>
									</li>
									<li><span class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span><br>
										<span class="noti">※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</span>
									</li>
								</ul>
							</dd>
						</dl>

						<dl>
							<dt>이벤트 참여방법 및 유의사항</dt>
							<dd>									
								<ul>
									<li>참여방법 : 에누리 가격비교 로그인 → 특권받기 이벤트 참여하기<br>
										<span class="noti">※ 이벤트 참여의 경우 PC 및 모바일 앱/웹에서 로그인 후에도 가능합니다.</span>
									</li>
									<li>본 이벤트는 본인인증 ID당 1회만 참여 가능합니다.</li>
									<li><span class="stress">당첨 고객님께 특별한 메세지를 보내드립니다.[에누리 앱>My에누리>설정]에서 알림 동의 여부를 꼭 확인해주세요.</span></li>
									<li><span class="stress">이벤트 대상 제외 :</span> 아래의 경우에는 이벤트 대상 및 혜택 지급에서 제외됩니다.<br>
										<ul class="sub">
											<li>- 2020년 1월 ~ 9월 기간 동안 더블적립 or 무제한적립 혜택 받지않은 고객</li>
											<li>- 특권받기 이벤트 참여하지 않은 경우</li>
											<li>- 동일한 본인인증으로 가입한 다수의 ID로 중복 참여한 경우</li>
										</ul>
									</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>공통 이벤트 유의사항</dt>
							<dd>
								<ul>
									<li>부정 참여 시 본 이벤트 대상 제외 및 혜택 지급이 취소될 수 있습니다.</li>
									<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
								</ul>
							</dd>
						</dl>
					</div>
				</div>
				<div class="evt_notice--foot">						
					<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 유의사항 닫기 -->
				</div>
			</div>
		</div>
		<!-- // -->
	</div>
	
</div>
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br>에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button">설치하기</button></p>
	</div>
</div>
<form id="survey" >
<div id="surveyLayer" class="full-layer" style="display:none;">
	<div class="dimmed" onclick="$('body').removeClass('scroll_lock');$(this).parent().fadeOut(100);"></div>
	<!-- popup_box -->
	<div class="popup_box survey">
		<h4>에누리 가격비교 연말결산 고객 선물조사</h4>
		<div class="inner">
			<div class="popup_cnt">
				<!-- 문제1 -->
				<dl class="survey_list survey_q1">
					<dt><em>Q1.</em> VIP 고객님의 유형은 무엇인가요?</dt>
					<dd>
						<ul>
							<li><input type="radio" id="survey_q1_01" name="survey_q1" value="1"><label for="survey_q1_01"><span class="q_num num1">1</span><em>사업자</em></label></li>
							<li><input type="radio" id="survey_q1_02" name="survey_q1" value="2"><label for="survey_q1_02"><span class="q_num num2">2</span><em>일반 구매자</em></label></li>
							<li><input type="radio" id="survey_q1_03" name="survey_q1" value="3"><label for="survey_q1_03"><span class="q_num num3">3</span><em>사업자&amp;일반구매자</em></label></li>
							<li><input type="radio" id="survey_q1_04" name="survey_q1" value="etc"><label for="survey_q1_04"><span class="q_num num4">4</span><em>기타</em>( <input type="text" class="survey_q1_etc" maxlength="10" placeholder="내용을 작성해 주세요"> )</label></li>
						</ul>
					</dd>
				</dl>
				<!-- // -->
				<!-- 문제2 -->
				<dl class="survey_list survey_q2">
					<dt><em>Q2.</em> 에누리 가격비교를 처음 알게 된 경로는 어떻게 되시나요?</dt>
					<dd>
						<ul>
							<li><input type="radio" id="survey_q2_01" name="survey_q2" value="1"><label for="survey_q2_01"><span class="q_num num1">1</span><em>지인소개/추천</em></label></li>
							<li><input type="radio" id="survey_q2_02" name="survey_q2" value="2"><label for="survey_q2_02"><span class="q_num num2">2</span><em>인터넷 검색</em></label></li>
							<li><input type="radio" id="survey_q2_03" name="survey_q2" value="3"><label for="survey_q2_03"><span class="q_num num3">3</span><em>광고</em></label></li>
							<li><input type="radio" id="survey_q2_04" name="survey_q2" value="etc"><label for="survey_q2_04"><span class="q_num num4">4</span><em>기타</em>( <input type="text" class="survey_q2_etc" maxlength="10" placeholder="내용을 작성해 주세요"> )</label></li>
						</ul>
					</dd>
				</dl>
				<!-- // -->
				<!-- 문제3 -->
				<dl class="survey_list survey_q3">
					<dt><em>Q3.</em> 에누리 가격비교를 이용하시는 목적은 무엇인가요?</dt>
					<dd>
						<ul>
							<li><input type="radio" id="survey_q3_01" name="survey_q3" value="1"><label for="survey_q3_01"><span class="q_num num1">1</span><em>가격비교 정보 검색</em></label></li>
							<li><input type="radio" id="survey_q3_02" name="survey_q3" value="2"><label for="survey_q3_02"><span class="q_num num2">2</span><em>쇼핑몰 상품 구매</em></label></li>
							<li><input type="radio" id="survey_q3_03" name="survey_q3" value="3"><label for="survey_q3_03"><span class="q_num num3">3</span><em>이벤트 참여</em></label></li>
							<li><input type="radio" id="survey_q3_04" name="survey_q3" value="etc"><label for="survey_q3_04"><span class="q_num num4">4</span><em>기타</em>( <input type="text" class="survey_q3_etc" maxlength="10" placeholder="내용을 작성해 주세요"> )</label></li>
						</ul>
					</dd>
				</dl>
				<!-- // -->
				<!-- 문제4 -->
				<dl class="survey_list survey_q4">
					<dt><em>Q4.</em> VIP 혜택 ‘특권에-누리다’의 어떤 이벤트가 만족스러우셨나요?</dt>
					<dd>
						<ul>
							<li><input type="radio" id="survey_q4_01" name="survey_q4" value="1"><label for="survey_q4_01"><span class="q_num num1">1</span><em>더블적립</em></label></li>
							<li><input type="radio" id="survey_q4_02" name="survey_q4" value="2"><label for="survey_q4_02"><span class="q_num num2">2</span><em>무제한 추가적립</em></label></li>
							<li><input type="radio" id="survey_q4_03" name="survey_q4" value="3"><label for="survey_q4_03"><span class="q_num num3">2</span><em>더블적립&amp;무제한 추가적립</em></label></li>
							<li><input type="radio" id="survey_q4_04" name="survey_q4" value="etc"><label for="survey_q4_04"><span class="q_num num4">3</span><em>기타</em>( <input type="text" class="survey_q4_etc" maxlength="10" placeholder="내용을 작성해 주세요"> )</label></li>
						</ul>
					</dd>
				</dl>
				<!-- // -->
				<!-- 문제5 -->
				<dl class="survey_list survey_q5">
					<dt><em>Q5.</em> VIP 혜택 ‘특권에-누리다’ 더블적립 이벤트 중 가장 만족하는 점은 무엇인가요?</dt>
					<dd>
						<ul>
							<li><input type="radio" id="survey_q5_01" name="survey_q5" value="1"><label for="survey_q5_01"><span class="q_num num1">1</span><em>추가 적립률</em></label></li>
							<li><input type="radio" id="survey_q5_02" name="survey_q5" value="2"><label for="survey_q5_02"><span class="q_num num2">2</span><em>추가 적립액</em></label></li>
							<li><input type="radio" id="survey_q5_03" name="survey_q5" value="3"><label for="survey_q5_03"><span class="q_num num3">3</span><em>구매구간별 적립액 구분</em></label></li>
							<li><input type="radio" id="survey_q5_04" name="survey_q5" value="etc"><label for="survey_q5_04"><span class="q_num num4">4</span><em><em>기타</em>( <input type="text" class="survey_q5_etc" maxlength="10" placeholder="내용을 작성해 주세요"> )</em></label></li><em>
						</em></ul><em>
					</em></dd><em>
				</em></dl><em>
				<!-- // -->
				<!-- 문제6 -->
				<dl class="survey_list survey_q6">
					<dt><em>Q6.</em> VIP 혜택 ‘특권에-누리다’ 무제한 추가적립 이벤트 중 가장 만족하는 점은 무엇인가요?</dt>
					<dd>
						<ul>
							<li><input type="radio" id="survey_q6_01" name="survey_q6" value="1"><label for="survey_q6_01"><span class="q_num num1">1</span><em>추가 적립률</em></label></li>
							<li><input type="radio" id="survey_q6_02" name="survey_q6" value="2"><label for="survey_q6_02"><span class="q_num num2">2</span><em>무제한 추가 적립액</em></label></li>
							<li><input type="radio" id="survey_q6_03" name="survey_q6" value="3"><label for="survey_q6_03"><span class="q_num num3">3</span><em>대상 카테고리(컴퓨터/가전 등)</em></label></li>
							<li><input type="radio" id="survey_q6_04" name="survey_q6" value="etc"><label for="survey_q6_04"><span class="q_num num4">4</span><em>기타</em>( <input type="text" class="survey_q6_etc" maxlength="10" placeholder="내용을 작성해 주세요"> )</label></li>
						</ul>
					</dd>
				</dl>
				<!-- // -->
				<!-- 문제7 -->
				<dl class="survey_list survey_q7">
					<dt><em>Q7.</em> VIP 고객 대상으로 추가되었으면 하는 이벤트가 있다면 무엇인가요?</dt>
					<dd>
						<ul>
							<li><input type="radio" id="survey_q7_01" name="survey_q7" value="1"><label for="survey_q7_01"><span class="q_num num1">1</span><em>특가 이벤트</em></label></li>
							<li><input type="radio" id="survey_q7_02" name="survey_q7" value="2"><label for="survey_q7_02"><span class="q_num num2">2</span><em>경품 이벤트</em></label></li>
							<li><input type="radio" id="survey_q7_03" name="survey_q7" value="3"><label for="survey_q7_03"><span class="q_num num3">3</span><em>적립 이벤트</em></label></li>
							<li><input type="radio" id="survey_q7_04" name="survey_q7" value="etc"><label for="survey_q7_04"><span class="q_num num4">4</span><em>기타</em>( <input type="text" class="survey_q7_etc" maxlength="10" placeholder="내용을 작성해 주세요"> )</label></li>
						</ul>
					</dd>
				</dl>
				<!-- // -->
				<!-- 문제8 -->
				<dl class="survey_list survey_q8">
					<dt><em>Q8.</em> VIP 고객님의 자유로운 의견을 남겨주세요!</dt>
					<dd>
						<textarea name="survey_q8"class="survey_q8" rows="4" placeholder="최대 100자까지 입력가능 합니다." maxlength="100"></textarea>	
					</dd>
				</dl>
				<!-- // -->
			</em></div><em>
			<div class="popup_noti">
				<em>VIP 고객님의 소중한 의견 감사드립니다.</em>
					더욱 만족할 수 있는 서비스로 보답하겠습니다.
			</div>
			<div class="popup_btn">
				<button type="button" class="btn_survey" onclick="surveyApply();">작성완료</button>
			</div>
		</em></div><em>
		<a href="#" onclick="$('body').removeClass('scroll_lock');onoff('surveyLayer');return false;" class="btn_close">닫기</a>
		<script>
			// input focus 시 스크롤 이동
			$(function(){
				var $surveyInput = 	$(".survey input");
				var $surveyCont = $(".survey .popup_cnt");
				$surveyInput.on({
					'click':function(){
						// fucus시 checked
						$(this).closest('li').find("input").prop("checked",true);
					}/* ,'focus':function(){
						// 키보드에 인풋이 가려지지 않도록 이동
						var posTop = $(this).closest('dl').position().top - 86;
						setTimeout(function(){
							$surveyCont.css({"transition":".2s all linear","transform":"translateY(-"+posTop+"px)"});
						},300);
					},'blur':function(){
						// 원위치 복귀
						$surveyCont.css({"transition":"none","transform":"translateY(0)"});
					} */
				})
			})
		</script>		
	</em>
	</div>


</div>
</form>
<!-- // -->	

<!-- 공통 : SNS공유하기 -->
<div class="com__share_wrap dim" style="z-index:10000;display:none">
	<div class="com__layer share_layer">
		<div class="lay_head">공유하기</div>
		<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
		<div class="lay_inner">
			<ul id="eventShr">
				<li class="share_fb" id="fbShare" >페이스북 공유하기</li>
				<li class="share_kakao" id="kakao-link-btn">카카오톡 공유하기</li>				
				<li class="share_tw" id="twShare" >트위터 공유하기</li>
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
						<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/evt/vip_award.jsp?oc=sns</span>
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

<script type="text/javascript">
var oc = '<%=oc%>';
(function (global, $) {
	$(function () {
		if(app != 'Y'){
			$('#eventSpan').text('이벤트 참여 시, [에누리앱>My에누리>설정]에서 알림 동의를 꼭 설정해주세요!');
		}
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
			$('.myarea').addClass("f-nav");
		} else {
			$nav.removeClass("is-fixed");
			$menu.removeClass('is-on');
			$(".visual").css("margin-bottom", 0);
			$('.myarea').removeClass("f-nav");
		}

		$.each($contents, function (idx, item) {
			var $target = $contents.eq(idx),
				i = $target.index(),
				targetTop = Math.ceil($target.offset().top - $navheight);

			if (targetTop <= $scltop) {
				$menu.removeClass('is-on');
				$menu.eq(idx).addClass('is-on');
			}
			if (!($navheight <= $scltop)) {
				$menu.removeClass('is-on');
			}
		})
	});
	
}(window, window.jQuery));
var shareUrl = "http://" + location.host + "/mobilefirst/evt/vip_award.jsp?oc=mo";
// 유의사항 열기/닫기
$(function(){
	
	if(oc!=''){
		$('.lay_only_mw').show();
	}
	
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
		$(thisClosest).slideToggle();
		$('html,body').stop(0).animate({scrollTop:$(thisClosest).siblings(".com__evt_notice").offset().top - 50});
	});
	
	$("#eventShr > li").click(function(){
		var sel = $(this).attr("id");
		var shareTitle = '[에누리 가격비교] 2020 VIP AWARD!\n'+'소중한 당신께 감사를 전합니다♥';
			

		if(sel == "fbShare"){
			try{
				window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(shareTitle)+"&u="+shareUrl);
			}catch(e){
				window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(shareTitle)+"&u="+shareUrl);
			}	
		}else if(sel == "twShare"){
			try {
				window.android.android_window_open("http://twitter.com/intent/tweet?text="
								+ encodeURIComponent(shareTitle)
								+ "&url=" + shareUrl);
			} catch (e) {
				window.open("http://twitter.com/intent/tweet?text="
						+ encodeURIComponent(shareTitle) + "&url="
						+ shareUrl);
			}
		}
	});
})
/*레이어*/
function onoff(id){
	var mid = $("#"+id);
	if(mid.css("display") !== "none"){
		mid.css("display","none");
	}else{
		mid.css("display","");
	}
}

</script> 


<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>

<script type="text/javascript">
var tapType = "<%=tab%>";
var default_src = "<%=ConfigManager.STORAGE_ENURI_COM%>";

var event_id = "<%=strEventId%>";

var vEvent_title = "vip이벤트";
var vEvent_page = "";

var aliYN = "N";
var vChkId = "";

var tab = "<%=tab%>";

//공통영역//
(function(){
	//스크롤
	var nav = $('.myarea'); 
	$(window).scroll(function () {
		if ($(this).scrollTop() > $(".event_01").offset().top) {
			nav.addClass("f-nav");
		} else {
			nav.removeClass("f-nav");
		}
	});
	
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1)		mType = "I";
	else if(navigator.userAgent.indexOf("Android") > -1)		mType = "A";
	
});
var dupchk = 0;
$(function(){
	
	var url = window.location.href;

    $(".inner_tabs li a:after").css("background","none");

    var offset = "";
    if( url.indexOf("evt1") > -1 ){
        offset = $("#evt1").offset();
    }else if( url.indexOf("evt2") > -1 ){
        offset = $("#evt2").offset();
    }
    
    if(!!offset){
        var $anchor = offset.top;
        $('html, body').stop().animate({scrollTop: $anchor}, 500);
    }
	
	//닫기버튼
	 $( ".win_close" ).click(function(){
        if(app == 'Y')  window.location.href = "close://";
        else            window.location.replace("/m/index.jsp");
	});
	ga('send', 'pageview', {'page': '/mobilefirst/evt/vip_award.jsp','title': '2020 VIP AWARD_PV'});
	
	if(islogin()){
		getPoint();
	}

	$(".btn_apply").click(function(){
		if(!islogin()){
			alert("로그인 후 참여 가능합니다!");
			location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
			return false;
		}else{
			if(dupchk==1){
				alert("이미 특권받기 이벤트 참여하셨습니다.\n당첨 발표일을 기다려주세요!");
				return false;
			}
			
			if(app=='Y'){
				if(!confirm("본 이벤트 참여 시 자동으로 알림 동의가 설정됩니다.\n 특권받기 이벤트 참여하시겠습니까?")) {
					return true;
				}
			}else{
				if(!confirm("특권받기 이벤트 참여하시겠습니까?\n[에누리 앱>My에누리>설정]에서 알림 동의를 꼭 설정해주세요!")) {
					return true;
				}
			}
			$.ajax({
				url: "/mobilefirst/evt/ajax/vipcareevt2019_setlist.jsp?proc=2&osType="+getOsType()+"&eventid="+2020120126,
			  	dataType: "JSON"
			}).done(function(data) {
				if(!data.result){
					alert('아쉽지만, 대상자가 아닙니다');
					dupchk=2;
				}else{
					if(data.result == -2){
						alert("이미 특권받기 이벤트 참여하셨습니다.\n당첨 발표일을 기다려주세요!");
						dupchk=1;
					}else if(data.result == -3){
						alert("아쉽지만 대상자가 아닙니다.");
						dupchk=2;
					}else{
						$(this).parent().click();
						alert("특권받기 신청완료!\n당첨 발표일을 기다려주세요.");
						dupchk=1;
					}
				}
				chk=false;
			});
		}
			
	});

});
function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevt%2Fvip_award.jsp";
	if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
		goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/evt/vip_award.jsp";
		chrome25 = uagentLow.search("chrome") > -1 && navigator.appVersion.match(/Chrome\/\d+.\d+/)[0].split("/")[1] > 25;
		kitkatWebview = uagentLow.indexOf("naver") != -1 || uagentLow.indexOf("daum") != -1; 
		setTimeout( function() {
			if (new Date - openAt < 2000) {
				if (uagentLow.search("android") > -1) {
					location.href = "market://details?id=com.enuri.android";
				}
			}
		}, 1000);
		
		window.open(goApp);
	}else{
		setTimeout( function() {
			window.open("https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8");
		}, 1000);
		location.href = goApp;
	}
}

function surveyGo(){
	
	if(!islogin()){
		
		alert("로그인 후 참여 가능합니다.");
		location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
		return false;
		
	}else{
		$.ajax({
			url: "/mobilefirst/evt/ajax/vipcareevt2019_setlist.jsp?proc=5",
		  	dataType: "JSON"
		}).done(function(data) {
			
			if(!data.result){
				alert("아쉽지만, 대상자가 아닙니다!");
			}else{
				if(data.orderCnt > 0){
					alert("이미 설문조사에 참여하셨습니다! \n소중한 의견 감사합니다!");
				}else{
					$('body').addClass('scroll_lock');
					onoff('surveyLayer');
				}
			}
		});
	}
	return false;
	
}


// 퍼블테스트 - 설문조사
function surveyApply(){
	var valueArr = new Array(8); // 입력한 정답 배열
	var $list = $(".survey .popup_cnt dl"); // 설문 리스트
	var valiChk = true;
	$list.each(function(e){ // 체크가 없거나 미기입상태일때 배열에 담지 않음
		valueArr[e] = null;
		if ( e != 7 ){ // 3번문제 아닐때
			var _checked = $(this).find("input[type='radio']:checked");
			var _val = _checked.val();
			if ( _val != undefined ){
				if ( _val == 'etc') { // 기타
					if ( _checked.next('label').find('input[type="text"]').val().length ){
						valueArr[e] = _checked.next('label').find('input[type="text"]').val();
						_checked.val(valueArr[e]);
					} 
				}else{
					valueArr[e] = _checked.next('label').find('em').text();
				} 
			}

		}else{ // 3번문제
			var _txAreaval = $(this).find("textarea").val();
			if ( _txAreaval.length ) valueArr[e] = _txAreaval;
		}
	})
		
	$(valueArr).each(function(i,v){ // 입력된 답 체크
		
		if ( (v == '' || v == undefined || v == null) && i != 7 ){
			valiChk = false; // 빈값일때
			alert('작성되지 않은 항목이 있습니다.');
			return false;
		}				
		
		if(i == 7){
			if( v == null || v.length < 5 ){
				alert('최소 5자 이상 입력해주세요.');
				valiChk = false;
				$(".survey_q8").focus();
				
				return false;
			}
		}

	});
	
	if (valiChk){
		
		var form = $( "#survey" ).serializeArray() ;
		
		$.ajax({
			url: "/mobilefirst/evt/ajax/vipcareevt2019_setlist.jsp?proc=1&osType="+getOsType(),
		  	data:  form ,
		  	dataType: "JSON"
		}).done(function(data) {
			
			if(data.result == 1){
				alert('설문조사 참여완료!\n소중한 의견 감사드립니다.');
				$('body').removeClass('scroll_lock');
				onoff('surveyLayer');
				
			}else if(data.result == -3){
				alert("이미 설문조사에 참여해주셨습니다!/n소중한의견 감사합니다.");
				onoff('surveyLayer');
			}
			
		});	
		
	}
}

function loginGo(){
	location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
	return false;
}

function commaNum(x) {
	var num;
	try{
		num = x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}catch(e){}
    return num; 
}
//페이지 이동
function XSSfilter (content) {
	return content.replace(/\</g, "&lt;").replace(/\>/g, "&gt;");
}
function welcomeGa(strEvent){
	if(app == "Y"){
		try{
	        if(window.android){            // 안드로이드                  
                 window.android.igaworksEventForApp (strEvent);
	        }else if(/iPhone|iPad|iPod/i.test(navigator.userAgent)){
        		// 아이폰에서 호출
                 location.href = "enuriappcall://igaworksEventForApp?strEvent="+strEvent;
	        }
		}catch(e){}
	}
}
/* setTimeout(function(){
	welcomeGa("evt_vip_view");    
},500); */

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
	        title: '[에누리 가격비교] 2020 VIP AWARD!',
	        description: '소중한 당신께 감사를 전합니다♥',
	        imageUrl: "http://img.enuri.info/images/event/2020/vipaward/sns_1200_630.jpg",
	        link: {
	          webUrl: shareUrl,
	          mobileWebUrl: shareUrl
	        }
	      },
		buttons: [{
	          title: '에누리 가격 비교',
	          link: {
	            mobileWebUrl: shareUrl,
	            webUrl: shareUrl
	          }
		}]
    });
}
</script>
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</body>
</html>