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
    response.sendRedirect("/event2019/vipcareevt.jsp"); //pc url
    return;
}

long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String sdt = dayTime.format(new Date(cTime));//진짜시간

if( request.getServerName().indexOf("dev.enuri.com") > -1 && request.getParameter("sdt")!=null && !request.getParameter("sdt").equals("") ) {
	sdt = request.getParameter("sdt");
}

String[] customDate = new String[2];
try{
	int year  = Integer.parseInt(sdt.substring(0, 4));
	int month = Integer.parseInt(sdt.substring(4, 6));

	Calendar cale = Calendar.getInstance();
    SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy년 M월 d일");
    //현재날짜의 세달전 날짜의 1일자
    cale.set(year, month - 1, 1);
    cale.add(Calendar.MONTH, -3);
    customDate[0] = dateFormatter.format(cale.getTime());

    //구한 날짜의 하루전 날짜 (말일자)
    cale.add(Calendar.DATE, -1);
    customDate[1] = dateFormatter.format(cale.getTime());

}catch(Exception e){
	System.out.println("컴백혜택 유의사항 문구 자동화변경 오류: "+ e.getMessage());
	customDate[0] = "2017년 12월 1일";
	customDate[1] = "2017년 6월 30일";
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
String strEventId = "2019121601";
String tab = ChkNull.chkStr(request.getParameter("tab"));



%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<title>에누리(가격비교) eNuri.com</title>
<meta property="og:title" content="에누리 가격비교">
<meta property="og:description" content="에누리 모바일 가격비교">
<meta property="og:image" content="http://img.enuri.com/images/event/2019/coupang/coupang_sns_1200_630.jpg">
<meta name="format-detection" content="telephone=no" />
<link rel="stylesheet" href="/css/event/y2019/vipcare_m.css" type="text/css">
<link rel="stylesheet" href="/css/home/member.css" type="text/css">
<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/event_regular.js?v=20180201"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script src="/mobilefirst/js/lib/clipboard.min.js"></script>
<script type="text/javascript" src="/common/js/paging_workers2.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
</head>
<body>
<script type="text/javascript">
var app = getCookie("appYN"); //app인지 여부
var username = "<%=userArea%>";

</script>
<div id="eventWrap">
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>

<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">

		<!-- 상단비주얼 -->		
		<div class="visual">
			<div class="inner">
				<span class="top_txt_01">Thank You 2019<span class="obj_leaf_01"></span><span class="obj_leaf_02"></span></span>
				<div class="top_tit">
					<span class="mask">연말결산</span>
					<div class="glitter">
						<div class="bg_inner"></div>
					</div>
				</div>
				<span class="top_txt_02">올 한해 에누리를 사랑해주셔서 감사 드리며, 더블적립 또는 무제한 적립을 받으신 고객 분들께 <em>특별한 선물</em>을 드립니다!</span>				
				<span class="star_group">
					<span class="st_bg star_01"></span>
					<span class="st_bg star_02"></span>
					<span class="st_md star_03"></span>
					<span class="st_md star_04"></span>
					<span class="st_md star_05"></span>
					<span class="st_sm star_06"></span>
					<span class="st_sm star_07"></span>
					<span class="st_sm star_08"></span>
				</span>
			</div>
			<div class="loader-box">
				<div class="visual-loader"></div>
			</div>
			<script>
				// 상단 타이들 등장 모션
				$(window).load(function(){
					var $visual = $(".visual");
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
				<li><a href="#evt1" class="floattab__item floattab__item--01">설문조사 하면 베스킨라빈스 100% 증정</a></li>
				<li><a href="#evt2" class="floattab__item floattab__item--02">특별한 회원에게 에누리 굿즈 증정!</a></li>
			</ul>
		</div>
	</div>
	<!-- // -->

	<!-- 이벤트01 -->
	<div id="evt1" class="section event_01 scroll"><!-- 이벤트 1 앵커 영역 -->
		<div class="evt_box">
			<h3>설문조사 이벤트 - 고객님들의 이야기를 들려주세요!</h3>
			<div class="img_evt_01">
				<span class="txt_hide">
					에누리 가격비교 사이트의 이용목적/만족도와 향후 개선사항 또는 바라는점 등 여러분들의 솔직한 의견을 들려주세요.<br/>
					설문조사에 참여하시는 모든 분들께 선물을 드립니다.<br/>
				</span>
			</div>
			<div class="img_evt_02">
				<dl class="txt_hide">
					<dt>이벤트기간</dt>
					<dd>2019.12.24 ~ 2020.1.12</dd>
					<dt>당첨자 발표일</dt>
					<dd>2020.01.20 월요일</dd>
					<dt>설문 대상</dt>
					<dd>2019년 1월 ~ 9월 기간동안 더블적립 or 무제한적립 받은 회원대상</dd>
					<dt>이벤트 경품</dt>
					<dd>베스킨라빈스 싱글레귤러 아이스크림</dd>
				</dl>
			</div>
			<div class="btn_area">
				<!-- 설문조사 레이어 띄울때 body 스크롤을 잠궈 줍니다. -->
				<!-- .scroll_lock 클래스 붙여주세요 -->
				<a href="javascript:///" class="btn_join" onclick="surveyGo()">참여하기</a>
				<!-- // -->
			</div>	
		</div>
		<div class="caution-wrap">
			<div class="btn_box">
				<a class="btn_notice" href="javascript:///" onclick="onoff('layerNoti1');return false;">유의사항을 꼭! 확인하세요</a>
			</div>
			<div id="layerNoti1" class="moreview" style="display:none">
				<h4>설문조사 유의사항</h4>
				<div class="txt">
					<dl>
						<dt>설문조사 기간 및 이벤트 내용</dt>
						<dd>설문조사 기간: 2019년 12월 24일 ~ 2020년 1월 12일</dd>
						<dd>이벤트 내용: 대상자에 한하여 설문조사에 참여하시면 참여자 전원에게 베스킨라빈스 싱글레귤러 증정!</dd>
					</dl>
					<dl>
						<dt>설문조사 대상</dt>
						<dd>2019년 1월~9월 기간동안 더블적립 또는 무제한적립 받은 이력이 있는 회원 대상</dd>
						<dd>대상자 중 다른 ID이더라도 본인인증 정보가 동일할 경우 중복 참여 불가</dd>
						<dd>대상자 외의 회원의 경우 참여 불가</dd>
					</dl>
					<dl>
						<dt>설문조사 참여방법</dt>
						<dd>설문조사 참여하기 클릭 &gt; 문항에 대한 답변 및 의견 남기기</dd>
						<dd>기간 내 1회 참여가능</dd>
						<dd>이벤트와 무관한 부적절한 내용 입력시에는 경품지급 대상에서 제외됩니다.</dd>
					</dl>
					<dl>
						<dt>설문조사 참여경품</dt>
						<dd>이벤트 경품: 베스킨라빈스 싱글레귤러 아이스크림 (e머니 3,100점)</dd>
						<dd>E머니 유효기간: 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</dd>
						<dd>경품은 e머니로 적립되며, e쿠폰 스토어에서 교환가능</dd>
					</dl>
					<dl>
						<dt>경품 지급일</dt>
						<dd>경품지급일: 2020년 1월 20일</dd>
						<dd>당첨자 공지: [에누리 가격비교 PC 사이트 &gt; 고객센터] 및 [에누리 가격비교 APP &gt; 당첨자 발표] </dd>
					</dl>
					<dl>
						<dt>유의사항</dt>
						<dd>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</dd>
						<dd>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</dd>
					</dl>				
					<a href="javascript:///" onclick="onoff('layerNoti1');return false" class="btn_check_hide">확인</a>
				</div>
			</div>
		</div>
	</div>
	<!-- // 이벤트01 -->

	<!-- 이벤트 02 -->
	<div id="evt2" class="section event_02 scroll">
		<div class="evt_box">
			<h3>Special Gift 특별한 회원분들께 한정판 에누리굿즈 증정!</h3>
			<div class="img_evt">에누리 로고가 새겨진! 블루투스 마이크&amp;스피커</div>
			<div class="btn_area">
				<a href="javascript:///" class="btn_apply" id="vipEvt" >신청하기</a>
			</div>
			<ul class="evt_noti">
				<li>신청기간 : 2019년 12월 24일 ~ 2020년 1월 12일</li>
				<li>당첨자 발표일 : 2020년 1월 20일</li>
				<li>대상자 : 2019년 1월~9월 기간동안 더블적립 or 무제한적립 받은 회원</li>
				<li>유의사항<Br>
				· 경품배송을 위한 개인정보 수집 동의 및 개인정보 입력 필수<br>
				· 다른 ID이더라도 본인인증 정보가 같을 경우 중복 신청 불가
				</li>
			</ul>
		</div>
		<div class="caution-wrap">
			<div class="btn_box">
				<a class="btn_notice" href="javascript:///" onclick="onoff('layerNoti2');return false;">유의사항을 꼭! 확인하세요</a>
			</div>
			<div id="layerNoti2" class="moreview" style="display:none">
				<h4>에누리굿즈 이벤트 유의사항</h4>
				<div class="txt">
					<dl>
						<dt>이벤트 기간 및 내용</dt>
						<dd>이벤트 기간: 2019년 12월 24일 ~ 2020년 1월 12일</dd>
						<dd>이벤트 내용: 대상자에 한하여 경품 신청하시면 에누리 굿즈 증정!</dd>
					</dl>
					<dl>
						<dt>이벤트 대상</dt>
						<dd>2019년 1월~9월 기간동안 더블적립 또는 무제한적립 받은 이력이 있는 회원 대상</dd>
						<dd>대상자 중 다른 ID이더라도 본인인증 정보가 동일할 경우 중복 신청 불가</dd>
						<dd>대상자 외의 회원의 경우 신청 불가</dd>
					</dl>
					<dl>
						<dt>신청방법</dt>
						<dd>이벤트 기간 내 에누리굿즈 신청 &rarr; 개인정보 동의 &rarr; 수령인 정보(이름, 핸드폰번호, 주소) 기입 &rarr; 신청완료!</dd>
						<dd>이벤트기간 내 1회 신청가능</dd>
					</dl>
					<dl>
						<dt>에누리 굿즈</dt>
						<dd>에누리 로고가 새겨진 블루투스 마이크&amp;스피커</dd>
					</dl>
					<dl>
						<dt>경품 지급 대상자 공지 </dt>
						<dd>대상자 공지: 2020년 1월 20일</dd>
						<dd>[에누리 가격비교 PC 사이트 &gt; 고객센터] 및 [에누리 가격비교 APP &gt; 당첨자 발표] </dd>
					</dl>
					<dl>
						<dt>유의사항</dt>
						<dd>이벤트 기간 동안 개인정보를 수집하며, 경품배송이 완료되면 개인정보를 즉시 파기합니다.</dd>
						<dd>경품은 사정에 따라 사전공지 없이 변경될 수 있습니다.</dd>
						<dd>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</dd>
						<dd>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</dd>
					</dl>		
					<a href="javascript:///" onclick="onoff('layerNoti2');return false" class="btn_check_hide">확인</a>
				</div>
			</div>
		</div>
	</div>
	<!-- // 이벤트 02 -->

	<!-- 에누리혜택 -->
	<div class="otherbene" style="background-color: white">
		<div class="contents">
			<h2><img src="http://img.enuri.info/images/event/2019/vipcare/m_benefit_tit.png" alt="놓칠수 없는 특별한 혜택"></h2>
			<ul class="banlist">
				<li><a href="javascript:///"  title="새창으로 이동"><img src="http://img.enuri.info/images/event/2019/hot_summer/m_otherbene_ban1.jpg" alt="출석체크"></a></li>
				<li><a href="javascript:///"  title="새창으로 이동"><img src="http://img.enuri.info/images/event/2019/hot_summer/m_otherbene_ban3.jpg" alt="첫구매혜택"></a></li>
				<li><a href="javascript:///"  title="새창으로 이동"><img src="http://img.enuri.info/images/event/2019/hot_summer/m_otherbene_ban4.jpg" alt="크레이지딜"></a></li>
				<li><a href="javascript:///"  title="새창으로 이동"><img src="http://img.enuri.info/images/event/2019/hot_summer/m_otherbene_ban6.jpg" alt="더많은 이벤트"></a></li>
			</ul>
		</div>
	</div>
	<!-- // -->

	<!-- //Contents -->	
	<span class="go_top"><a href="javascript:///">TOP</a></span>
</div>

<!-- layer--> 
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button">설치하기</button></p>
	</div>
</div>

<!-- 개인정보 수집 및 이용동의 -->
<div class="layer_back" id="agreeLayer1" style="display:none">
	<div class="agree_layer">
		<div class="inner">
			<div class="txt_tit">개인정보 수집 및 이용동의</div>			
			<div class="txt_cnt">
				<div class="agree_tit">
					개인정보는 이벤트 기간 동안 수집하며,<br/>
					경품발송 완료 후 파기됩니다.
				</div>
				<div class="agree_txt">
					<label><input id="agree_chk_01" type="checkbox" class="chkbox">이벤트 참여를 위한 개인정보 활용에 동의합니다.</label><Br/>
					<a href="" onclick="onoff('agreeLayer1');onoff('agreeLayer2');return false;" class="btn_view_detail">자세히보기&gt;</a>
				</div>
			</div>			
			<p class="btn_apply"><button type="button" onclick="eventApply();">신청하기</button></p>			
		</div>
		<a href="javascript:///" onclick="onoff('agreeLayer1');return false;" class="btn_close">닫기</a>
	</div>
	<script>
		// 퍼블 테스트용
		function eventApply(){ 
			var $agreeChk = $("#agree_chk_01");
			if ( $agreeChk.is(":checked") ){
				onoff('agreeLayer1');
				onoff('applyLayer');
			}else{
				alert('이벤트 참여를 위한 개인정보 활용에 동의해 주세요');
			}
		}
	</script>
</div>
<!-- // -->
	
<!-- 개인정보 수집 이용안내 레이어 -->
<div class="layer_back" id="agreeLayer2" style="display:none">
	<div class="agree_noti_layer">
		<div class="inner">
			<div class="txt_tit">개인정보 수집 &middot; 이용안내</div>
			<div class="txt_cnt">
				<strong>에누리 가격비교는 경품배송을 위하여 <br/>아래와 같이 개인 정보를 수집하고 있습니다.</strong><br/>
				<dl>
					<dt>1. 개인정보 수집 항목</dt>
					<dd>참여자ID,  이름, 연락처, 주소, 본인인증확인(CI,DI)</dd>
					<dt>2. 개인정보 수집 목적</dt>
					<dd>경품 배송을 위해 수집된 개인정보는 배송 이외의 목적으로 활용되지 않습니다.</dd>
					<dt>3. 개인정보 보유 및 이용기간</dt>
					<dd>개인정보 수집자 (에누리 가격비교)는 이벤트 기간 동안 개인정보를 수집하며, 경품배송이 완료되면 개인정보를 즉시 파기합니다.</dd>
				</dl>
			</div>
			<p class="btn_close"><button type="button" onclick="onoff('agreeLayer1');onoff('agreeLayer2');">확인</button></p>
		</div>
	</div>
</div>
<!-- // -->

<!-- 레이어 : 배송지 입력 레이어-->

<div id="applyLayer" class="layer_back" style="display:none;">
	<div class="dimmed" onclick="if(confirm('신청이 완료되지 않았습니다. \n레이어를 닫으시겠습니까?')){$(this).parent().fadeOut(100);};"></div>
	<!-- popup_box -->
	<form id="vipaddr" onsubmit="return false;" >
	<div class="evt_apply_layer"  >
		<div class="inner">
			<h4 class="txt_tit">고객님 에누리를 애용해주셔서 감사합니다.<b>에누리 굿즈 발송을 위해 <br/>아래의 정보를 정확하게 입력해주세요.</b></h4>
			<div class="popup_cnt">
				<div class="apply_row">
					<span class="txt_row">받는분</span>
					<input type="text" name="usernm" id="usernm"  placeholder="이름을 입력해 주세요">
				</div>
				<div class="apply_row">
					<span class="txt_row">연락처</span>
					<input type="text" name="phone"  id="phone"  placeholder="- 없이 입력해 주세요">
				</div>
				<div class="apply_row">
					<span class="txt_row">주소</span>
					<input type="text" class="inp_zipcode" placeholder="우편변호" name="zipcode" id="zipcode"   >
					<button class="btn_zipcode" onclick="btn_zipcode()" >주소찾기</button>
					<input type="text" placeholder="도로명주소로 입력해주세요" id="r_address1" name="addr1">
					<input type="text" placeholder="상세주소를 입력해 주세요" id="r_address2" name="addr2" >
				</div>
			</div>
			<div class="popup_noti">
				<span class="tit_noti">꼭! 확인하세요!</span>
				<ul>
					<li>입력된 정보는 수정이 불가하오니 제출 전 확인 부탁드립니다.</li>
					<li>잘못된 정보 입력으로 인한 불이익은 책임지지 않습니다.</li>
				</ul>
			</div>
			<div class="popup_btn">
				<button type="button" class="btn_pop_apply" >신청완료</button>			
			</div>
		</div>
		<a href="javascript:///" onclick="onoff('applyLayer');return false;" class="btn_close">닫기</a>
	</div>
	</form>
	<!-- //popup_box -->
	
	<!-- 주소검색 -->
<div class="dim" id="post" style="display:none;">
	<div class="adr_search">
			<button class="btnClose" type="button" onclick="$('#post').hide();">주소검색 창 닫기</button>
			<h2>주소검색</h2>
			<div class="adrarea">
				<ul class="adr_tab">
					<li class="on">
						<a href="javascript:///">도로명 주소</a>
						<div class="type2">
							<p class="location">
								<label>도로명</label><input type="text" class="post_search" id="road_keyword"   />
								<button type="button" class="searchbtn" id="road_search">검색</button>
								<em>*도로명+건물번호 : 퇴계로 18<br />*건물명 : 대우재단빌딩</em>
							</p>
							<div class="adr_sel">검색 후 해당하는 주소를 선택해 주세요.</div>
							<!-- 검색 후 리스트 -->
							<div class="adr_sel_list">
								<ul></ul>
							</div>
							<!--// 검색 후 리스트 -->
						</div>
					</li>
					<li>
						<a href="javascript:///">지번 주소</a>
						<div class="type1">
							<p class="location">
								<label>지역명</label><input type="text" class="post_search" id="addr_keyword"/>
								<button class="searchbtn" type="button" id="addr_search">검색</button>
								<em>(동/읍/면/리/가)</em>
							</p>
							<div class="adr_sel">검색 후 해당하는 주소를 선택해 주세요.</div>
							<!-- 검색 후 리스트 -->
							<div class="adr_sel_list">
								<ul></ul>
							</div>
							<!--//검색 후 리스트 -->
						</div>
					</li>
				</ul>
			</div>
		</div>
</div>
<!--// 주소검색 -->
	
</div>

<!-- // -->	
<!-- 레이어 : 설문조사-->
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
					<dt><em>Q1.</em> 에누리 가격비교를 처음 알게된 경로는 어떻게 되시나요?</dt>
					<dd>
						<ul>
							<li><input type="radio" id="survey_q1_01" name="survey_q1" value="1"><label for="survey_q1_01"><span class="q_num num1">1</span><em>지인소개 추천</em></label></li>
							<li><input type="radio" id="survey_q1_02" name="survey_q1" value="2"><label for="survey_q1_02"><span class="q_num num2">2</span><em>인터넷 검색</em></label></li>
							<li><input type="radio" id="survey_q1_03" name="survey_q1" value="3"><label for="survey_q1_03"><span class="q_num num3">3</span><em>광고</em></label></li>
							<li><input type="radio" id="survey_q1_04" name="survey_q1" value="etc"><label for="survey_q1_04"><span class="q_num num4">4</span><em>기타</em>( <input type="text" name="survey_q1_etc" class="survey_q1_etc" maxlength="10" placeholder="내용을 작성해 주세요"> )</label></li>
						</ul>
					</dd>
				</dl>
				<!-- // -->
				<!-- 문제2 -->
				<dl class="survey_list survey_q2">
					<dt><em>Q2.</em> 에누리 가격비교에 방문하시는 목적은 무엇인가요?</dt>
					<dd>
						<ul>
							<li><input type="radio" id="survey_q2_01" name="survey_q2" value="1"><label for="survey_q2_01"><span class="q_num num1">1</span><em>가격비교 정보검색</em></label></li>
							<li><input type="radio" id="survey_q2_02" name="survey_q2" value="2"><label for="survey_q2_02"><span class="q_num num2">2</span><em>상품구매</em></label></li>
							<li><input type="radio" id="survey_q2_03" name="survey_q2" value="3"><label for="survey_q2_03"><span class="q_num num3">3</span><em>이벤트 응모</em></label></li>
							<li><input type="radio" id="survey_q2_04" name="survey_q2" value="etc"><label for="survey_q2_04"><span class="q_num num4">4</span><em>기타</em>( <input type="text" name="survey_q2_etc" class="survey_q2_etc" maxlength="10" placeholder="내용을 작성해 주세요"> )</label></li>
						</ul>
					</dd>
				</dl>
				<!-- // -->
				<!-- 문제3 -->
				<dl class="survey_list survey_q3">
					<dt><em>Q3.</em> 에누리 가격비교를 통하여 구매하시는 이유를 알려주세요.</dt>
					<dd>
						<textarea class="survey_q3" id="survey_q3" name="survey_q3" rows="4" placeholder="최대 100자까지 입력가능 합니다." maxlength="100"></textarea>							
					</dd>
				</dl>
				<!-- // -->
				<!-- 문제4 -->
				<dl class="survey_list survey_q4">
					<dt><em>Q4.</em> 회원님의 유형을 선택해주세요. </dt>
					<dd>
						<ul>
							<li><input type="radio" id="survey_q4_01" name="survey_q4" value="1"><label for="survey_q4_01"><span class="q_num num1">1</span><em>사업자</em></label></li>
							<li><input type="radio" id="survey_q4_02" name="survey_q4" value="2"><label for="survey_q4_02"><span class="q_num num2">2</span><em>일반구매자</em></label></li>
							<li><input type="radio" id="survey_q4_03" name="survey_q4" value="etc"><label for="survey_q4_03"><span class="q_num num3">3</span><em>기타</em>( <input type="text" class="survey_q4_etc" name="survey_q4_etc" maxlength="10" placeholder="내용을 작성해 주세요"> )</label></li>
						</ul>
					</dd>
				</dl>
				<!-- // -->
				<!-- 문제5 -->
				<dl class="survey_list survey_q5">
					<dt><em>Q5.</em> 앞으로도 구매시 e머니가 적립되는 혜택이 지속된다면, 에누리를 이용할 의향이 있으신가요? 고객님의 e머니 적립에 대한 만족도를 평가해주세요. </dt>
					<dd>
						<ul>
							<li><input type="radio" id="survey_q5_01" name="survey_q5" value="1"><label for="survey_q5_01"><span class="q_num num1">1</span><em>매우만족</em></label></li>
							<li><input type="radio" id="survey_q5_02" name="survey_q5" value="2"><label for="survey_q5_02"><span class="q_num num2">2</span><em>만족</em></label></li>
							<li><input type="radio" id="survey_q5_03" name="survey_q5" value="3"><label for="survey_q5_03"><span class="q_num num3">3</span><em>불만족</em></label></li>
							<li><input type="radio" id="survey_q5_04" name="survey_q5" value="4"><label for="survey_q5_04"><span class="q_num num4">4</span><em>매우불만족</em></label></li>
						</ul>
					</dd>
				</dl>
				<!-- // -->
				<!-- 문제6 -->
				<dl class="survey_list survey_q6">
					<dt><em>Q6.</em> 에누리 e머니 적립 서비스 중 개선되었으면 하는 부분이 있다면?</dt>
					<dd>
						<ul>
							<li><input type="radio" id="survey_q6_01" name="survey_q6" value="1"><label for="survey_q6_01"><span class="q_num num1">1</span><em>적립률</em></label></li>
							<li><input type="radio" id="survey_q6_02" name="survey_q6" value="2"><label for="survey_q6_02"><span class="q_num num2">2</span><em>적립몰&적립상품추가</em></label></li>
							<li><input type="radio" id="survey_q6_03" name="survey_q6" value="3"><label for="survey_q6_03"><span class="q_num num3">3</span><em>PC구매시적립</em></label></li>
							<li><input type="radio" id="survey_q6_04" name="survey_q6" value="etc"><label for="survey_q6_04"><span class="q_num num4">4</span><em>기타</em>( <input type="text" name="survey_q6_etc" class="survey_q6_etc" maxlength="10" placeholder="내용을 작성해 주세요"> )</label></li>
						</ul>
					</dd>
				</dl>
				<!-- // -->
				<!-- 문제7 -->
				<dl class="survey_list survey_q7">
					<dt><em>Q7.</em> 더블적립 또는 무제한적립자를 대상으로 추가되었으면 하는 이벤트가 있다면?</dt>
					<dd>
						<ul>
							<li><input type="radio" id="survey_q7_01" name="survey_q7" value="1"><label for="survey_q7_01"><span class="q_num num1">1</span><em>전용특가</em></label></li>
							<li><input type="radio" id="survey_q7_02" name="survey_q7" value="2"><label for="survey_q7_02"><span class="q_num num2">2</span><em>경품증정 이벤트</em></label></li>
							<li><input type="radio" id="survey_q7_03" name="survey_q7" value="3"><label for="survey_q7_03"><span class="q_num num3">3</span><em>전용 고객상담</em></label></li>
							<li><input type="radio" id="survey_q7_04" name="survey_q7" value="etc"><label for="survey_q7_04"><span class="q_num num4">4</span><em>기타</em>( <input type="text" name="survey_q7_etc" class="survey_q7_etc" maxlength="10" placeholder="내용을 작성해 주세요"> )</label></li>
						</ul>
					</dd>
				</dl>
				<!-- // -->
			</div>
			<div class="popup_noti">
				<em>고객님의 소중한 의견 감사드립니다.</em>
				남겨주시는 의견 반영하여 더 좋은 서비스를<br/>제공해드리도록 하겠습니다.
			</div>
			<div class="popup_btn">
				<button type="button" class="btn_survey" onclick="surveyApply();">작성완료</button>
			</div>
		</div>
		<a href="javascript:///" onclick="$('body').removeClass('scroll_lock');onoff('surveyLayer');return false;" class="btn_close">닫기</a>
	</div>

</div>
</form>

<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>

<!-- layer-->
<div class="layer_back fixed" id="app_only" style="display:none;">
    <div class="dimm" onclick="onoff('app_only');"></div>
    <div class="appLayer">
        <h4>모바일 앱 전용 이벤트</h4>
        <a href="javascript:///" class="close" onclick="onoff('app_only');">창닫기</a>
        <p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
        <p class="btn_close"><button type="button"  onclick="install_btt();">설치하기</button></p>
    </div>
</div>

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
	
});$(function(){
	
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
        else            window.location.replace("/mobilefirst/index.jsp");
	});
	
	$(".go_top").click(function(){		$(window).scrollTop(0);	});
	
	ga('send', 'pageview', {'title': vEvent_title + " > " + "PV"});
	
	//주소검색
	$( ".adr_tab > li > a" ).click(function() {
		$(this).parent().addClass("on").siblings().removeClass("on");
		$(".adr_sel_list").empty();
		$("#road_keyword").val('');
		$("#addr_keyword").val('');
		return false;
	});
	
	if(islogin()){
		getPoint();
	}
	
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
	});
	$("body").on('click', '.searchbtn', function(event) {
	//$(".searchbtn").click(function(){
		//alert("btn click");
		
		var isNewType = $(this).attr("id") == "road_search" ? "Y" : "N";
		var keyword = isNewType == "Y" ? $("#road_keyword").val() : $("#addr_keyword").val();
		//var url = "https://m.enuri.com/mobilefirst/member/Addr.jsp?newtype="+ isNewType + "&keyword=" + keyword;
		var url = "/mobilefirst/member/Addr.jsp?newtype="+ isNewType + "&keyword=" + keyword;
		//console.log("keyword : " + keyword + ", type : " + isNewType);
		//alert("keyword : " + keyword + ", type : " + isNewType);
		//alert("url :" + url);
		$.ajax({

			 url: url,
			 dataType: 'json',
			 async: false,
			 success: function(data){
				 appendAddressList(isNewType, data);
			 },error: function(x, o, e){
				 //alert("error");
						//alert(x.status + " : "+ o +" : "+e);
			 }
		 });
	});
	$(".btn_pop_apply").click(function(){
		
		var form = $( "#vipaddr" ).serializeArray() ;
		
		var usernm = form[0].value; 
		var phone = form[1].value;
		var zipcode = form[2].value;
		var addr1 = form[3].value;
		var addr2 = form[4].value;
		
		if(usernm == ""  ){
			alert("이름을 입력하세요");
			$("#usernm").focus();
			return false;
		}else if(phone == ""){
			alert("전화번호를 입력하세요");
			$("#phone").focus();
			return false;
			
		}else if(zipcode == ""){
			alert("우편번호를 입력하세요");
			$("#zipcode").focus();
			return false;
			
		}else if(addr1 == ""){
			alert("주소를 입력하세요");
			$("#addr1").focus();
			return false;
			
		}else if(addr2 == ""){
			
			alert("주소를 입력하세요");
			$("#addr2").focus();
			return false;
		}
		$.ajax({
			url: "/mobilefirst/evt/ajax/vipcareevt2019_setlist.jsp?proc=2&osType="+getOsType(),
		  	data:  form ,
		  	dataType: "JSON"
		}).done(function(data) {
			
			if(data.result == 1){
				alert('신청이 완료되었습니다!\n올 한해도 에누리를 이용해주셔서 감사합니다.');
				$("#applyLayer").hide();
				
			}else if(data.result == -2){
				alert("이미 응모하셨습니다.!");
				$("#applyLayer").hide();
				
			}else if(data.result == -3){
				alert("아쉽지만 대상자가 아닙니다.");
				$("#applyLayer").hide();
			}
		});	
	});
	
	$("#vipEvt").click(function(){
		
		alert("이벤트 종료 되었습니다.");
		return false;
		
		if(!islogin()){
			
			alert("로그인 후 신청 가능합니다!");
			location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
			return false;
			
		}else{
			
			$.ajax({
				url: "/mobilefirst/evt/ajax/vipcareevt2019_setlist.jsp?proc=4",
			  	dataType: "JSON"
			}).done(function(data) {
				
				if(!data.result){
					
					alert("아쉽지만 대상자가 아닙니다!");
				}else{
					if(data.orderCnt > 0){
						alert("이미 신청하셨습니다.");
					}else{
						onoff('agreeLayer1');
					}
				}
			});
		}
			
	});
	$(".banlist > li").click(function(){
		var inx = $(this).index();
		if( inx == 0 ){
			window.open("/mobilefirst/evt/visit_event.jsp?freetoken=event");
		}else if(inx == 1){
			window.open("/mobilefirst/evt/firstbuy100_event.jsp?freetoken=event");
		}else if(inx == 2){
			window.open("/mobilefirst/evt/mobile_deal.jsp?freetoken=event");
		}else if(inx == 3){
			window.open("/mobilefirst/index.jsp#3");
		}
		return false;
	});
});
function surveyGo(){

	alert("이벤트 종료 되었습니다.");
	return false;
	
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
				alert("아쉽지만 대상자가 아닙니다!");
			}else{
				if(data.orderCnt > 0){
					alert("이미 설문조사에 참여해주셨습니다! \n소중한의견 감사합니다.");
				}else{
					$('body').addClass('scroll_lock');
					onoff('surveyLayer');
				}
			}
		});
	}
	return false;
	
}
	
function appendAddressList(isNewType, post_data){
	//alert("appendAddressList");
	var element = $(".adr_sel_list");
	var html = "";

	for(var idx in post_data.addrList){
		var data = post_data.addrList[idx];
		element.empty();
		if( data.newzip != null) {
			html += "<li onclick='CmdSetAddr(\""+data.newzip+"\", \""+data.strAddrDetail+"\");'>"
			html += 	"<span>" + data.newzip + "</span>";
			html += 	data.strAddrDetail;
			html += "</li>";
		}else{
			html += "<div class=\"adr_sel\">검색 결과가 없습니다.</div>";
		}
	}
	html = "<ul>" + html + "</ul>";
	element.html(html);
	
}

function btn_zipcode(){
	$('#post').show();
}	
/*기본 주소 입력*/
function CmdSetAddr(newzip, addr){
	$(".inp_zipcode").val(newzip);
	$("#r_address1").val(addr);
	$('#post').hide();
}

// 퍼블테스트 - 설문조사
function surveyApply(){
	var valueArr = new Array(7); // 입력한 정답 배열
	var $list = $(".survey .popup_cnt dl"); // 설문 리스트
	var valiChk = true;
	$list.each(function(e){ // 체크가 없거나 미기입상태일때 배열에 담지 않음
		valueArr[e] = null;
		if ( e != 2 ){ // 3번문제 아닐때
			var _checked = $(this).find("input[type='radio']:checked");
			var _val = _checked.val();
			if ( _val != undefined ){
				if ( _val == 'etc') { // 기타
					if ( _checked.next('label').find('input[type="text"]').val().length ){
						valueArr[e] = _checked.next('label').find('input[type="text"]').val();
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
		
		if(i == 2){
			if( v == null || v.length <= 5 ){
				alert("최대 5자 이상 적어주세요!");
				valiChk = false;
				$(".survey_q3").focus();
				
				return false;
			}
		}
		
		if ( v == '' || v == undefined || v == null ){
			valiChk = false; // 빈값일때
			alert('작성되지 않은 항목이 있습니다.');
			return false;
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
				
				alert('응모완료!\n소중한 의견 감사합니다:)');
				$('body').removeClass('scroll_lock');
				onoff('surveyLayer');
				
			}else if(data.result == -3){
				alert("이미 응모하셨습니다.!");
				onoff('surveyLayer');
			}
			
		});	
		
	}
}

function loginGo(){
	location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
	return false;
}

function inner() {
	$('html, body').animate({scrollTop: Math.ceil($('#'+tapType).offset().top-$("#topFix").height())}, 1000);
}

function GA(label){
	ga('send', 'event', 'mf_event', '알리이벤트',label);		
}

//앱설치버튼
function install_btt(){
	
	ga('send','event', 'mf_event','click',vEvent_title+'_설치하기');
	
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8';
    }else if(navigator.userAgent.indexOf("Android") > -1){
    	if(gkind == "42"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','SA 42 M_Naver');
    		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=8820367';
    	}else if(gkind == "43"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','SA 43 M_Daum');
    		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=9238355';
    	}else if(gkind == "44"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','SA 44 M_google');
    		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=2709994';
    	}else if(gkind=="72"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','DA 72 M_icover');
    		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=9999961&sub_referral=5642519';
    	}else if(gkind=="75" && gno == "3120469"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','버즈빌_첫구매CU');
    		window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=1917629&sub_referral=8147655";
		}else if(gkind=="74" && gno == "3120470"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','페이스북_첫구매CU');
			window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=4120949&sub_referral=2082626";
		}else if(gkind=="71" && gno =="3100367"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','망고_첫구매CU');
    		window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=9999961&sub_referral=1319566";
    	}else if(gkind=="76" && gno =="3139542"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','애드립_첫구매CU');
    		window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=3535287&sub_referral=3457934";
    	}else if(gkind=="82" && gno =="4299545"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','쉘위애드_첫구매');
    		window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6497571&sub_referral=4519572";
    	}else{
    		window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
    	}
    }
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
setTimeout(function(){
	//welcomeGa("evt_coupang_view");    
},500);

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
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</body>
</html>