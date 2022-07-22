<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{ //pc일때 접속페이지 변경.
	response.sendRedirect("/event2019/newsemester_2019_evt.jsp");
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
String strFb_title = "[에누리 가격비교]";
String strFb_description = "새학기 프로모션";
String strFb_img = ConfigManager.IMG_ENURI_COM + "/images/mobilenew/images/logo_enuri.png";
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
	<meta property="og:title" content="<%=strFb_title%>">
	<meta property="og:description" content="<%=strFb_description%>">
	<meta property="og:image" content="<%=strFb_img%>">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/css/event/y2019/newsemester_pro_m.css?v=20190212"/>
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/lib/animate.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
	<script type="text/javascript" src="/common/js/function.js"></script>
	<script type="text/javascript" src="/common/js/paging_visit_201708.js"></script>
</head>
<body>
<div id="eventWrap">
    <!-- 개인화영역 -->
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile_xmas_2018.jsp"%>

	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">		
		<!-- 상단비주얼 -->
		<div class="visual">
			<div class="sns">
				<span class="sns_share evt_ico" onclick="onoff('snslayer')">sns 공유하기</span>
				<ul id="snslayer" style="display:none;">
					<li>페이스북</li>
					<li>카카오톡</li>
				</ul>
			</div>
			
			<div class="contents">
				<h1 class="blind">HELLO 새학기백서</h1>
				<p class="blind">새로운 시작을 위한 응원 이벤트!</p>
			</div>
		</div>
	
		<div class="section floattab">
			<div class="contents">
				<ul class="floattab__list">
					<li><a onclick="da_ga(2)" class="floattab__item floattab__item--01">최후의 한방 햄버거 받자!</a></li>
					<li><a onclick="da_ga(3)" class="floattab__item floattab__item--02">새학기 응원하면 아이스크림</a></li>
					<li><a onclick="da_ga(4)" class="floattab__item floattab__item--03">APP구매시 해피머니 증정</a></li>
				</ul>
			</div>
		</div>
		
	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<!-- 이벤트01 -->
	<div class="section evt_1st scroll">
		<div class="contents">
			<div id="evt1" class="evt_play">
				<h2 class="tit">이벤트1 : 지우개 최후의 한방! 마지막 뒤집기로 역전하자!</h2>
				<p class="reward">[맥도날드] 불고기버거세트 (e머니 4,500)</p>
			
				<div class="gamebox">
					<div class="game__state">지우개(선택 전)					
						<span class="balloon">파워에 맞춰 손을 터치해주세요</span>
						
						<div class="powergauge">
							<!-- :before = 검은 바탕 -->
							<span class="bar"></span>
							<!-- :after = POWER 텍스트 -->
						</div>
						<div class="game__btn">
							<button type="button" id="btnPlayGame" class="btn_trigger" title="파워에 맞춰 손을 터치해주세요">손</button>
						</div>	
					</div>		
					
					<!-- 선택 결과 -->
					<div class="evt__result">						
						<!-- 결과 : 성공 -->
						<img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newsemester_pro/m_play_success.png" alt="최후의 한방 성공!! 내일 또 만나요~" />
						<!-- 결과 : 꽝 
						<img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newsemester_pro/m_play_fail.png" alt="아쉽지만 실패.. 내일 또 만나요~" />
						-->
					</div>
				</div>
			</div>
			<a href="#" class="sprite btn_caution" onclick="onoff('notetxt1'); return false;">꼭!확인하세요</a>
		</div>
	</div>
	<!-- //이벤트01 -->
	
	<div class="section pro_itemlist">
		<div class="contents">
			<h2 class="tit">완벽준비 필수템 새학기대전</h2>
			
			<!-- 추천상품 탭 -->
			<ul class="pro_tabs">
				<li class="active"><a href="#protab1">PC/노트북</a></li>
				<li><a href="#protab2">학용품</a></li>
				<li><a href="#protab3">가방/패션</a></li>
				<li><a href="#protab4">학생가구</a></li>
				<li><a href="#protab5">든든한아침</a></li>
			</ul>
			<!-- //추천상품 탭 -->
			
			<!-- 추천상품 콘텐츠 -->
			<div class="tab_container">
				<!-- 
					SLICK $(".itemlist")
					5개의 탭 콘텐츠가 있습니다. "tab_content"
					하나의 콘텐츠마다 ul 단위로 한 판(상품4개)씩 움직입니다. 				
				-->
				<!-- PC/노트북 상품 -->
				<div id="protab1" class="tab_content">
					<div class="itemlist"></div>
					<a class="sprite btn_more" href="javascript:///" >상품더보기</a>
				</div>
				<!-- //PC/노트북 상품 -->
			</div>
			<!-- //추천상품 콘텐츠 -->
		</div>
	</div>
	<!-- //추천 상품 영역 -->
	
	<!-- 이벤트02 -->
	<div id="evt2" class="section evt_2th scroll">
		<div class="contents">
			<div id="evt2" class="evt2__anchor"><p class="blind">이벤트 2 앵커 영역</p></div>
			
			<h2 class="tit">이벤트2 : 새로운 시작을 위한 응원메세지 남기기!</h2>
			<p class="blind">새로운 시작을 하는 아이들에게 응원의 메시지 남기고 경품 받으세요!</p>
			<p class="blind">[맥도날드] 딸기 선데이 아이스크림(e머니 1,500점), 100명 추첨</p>
			
			<!-- 게시판 -->
			<div class="input_board">
				<div class="write_area">
					<!-- 
						로그인 전,

						.login_alert 클릭 -> alert(로그인참여)

						로그인 후,
						1. login_alert disNone 클래스 추가
						2. 댓글 입력 시, 창 확대 input open 클래스 추가
						3. 아이콘 버튼 클릭시, z-index 조정
							- 열렸을 때 : $(".thumb_sm").css("z-index", 100);
							- 닫혔을 때 : $(".thumb_sm").animate({"z-index": 0}, 300);

						댓글 영역 외에 터치 했을 때, 2,3 번 반대로 

						작업할 때 설명 한 번 드릴게요~
					-->


					<!-- 댓글 입력창 입력시 .open 클래스 추가 ex) <div class="input open"> -->
					<div class="input">
						<!-- 
							@참고
							로그인 전일 때, 
							보이지 않는 버튼 올려서 로그인 타게 버튼 추가했어요. 로그인 후에는 클래스(disNone) 추가해 주세요. class="login_alert disNone" 
						-->
						<a href="javascript:///" class="login_alert"><!-- 로그인 전 버튼 영역 --></a>

						<textarea id="txt_area" class="txt_area" maxlength="150" placeholder="좋아하는 문구나 재밌는 문구, 힘나는 문구 남겨주세요!"></textarea>
						<!--
							댓글 입력 창 입력시 placeholder 교체
							placeholder="광고글, 욕설 등 부적합한 게시물은 관리자에 의해 삭제될 수 있습니다. 한 번 등록한 댓글은 수정이 불가하오니 등록 전 확인 부탁드립니다."
						-->
						<p class="curr"><span id="word_num">0</span>/150자</p>
						<button id="" class="sprite btn regist board-stripe">등록하기</button>

						<!-- icon -->
						<div class="thumb_sm">
							<div class="inner">
								<div class="thumb_select">
									<p class="thumb" id="btnIcon"></p>
									<p class="sprite btn_thumb"></p>

									<!-- 로그인 후 노출 -->
									<p class="user" id="user_id"></p>
								</div>
								<div class="thumb_sm_list" style="">
									<div class="inner_scroll">
										<div class="swiper_wrapper">
										    <a class="thumb" onclick="selectThumb(1);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/attendance/jan/m_round_person1.png" alt="" class="imgs" /></a>
											<a class="thumb" onclick="selectThumb(2);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/attendance/jan/m_round_person2.png" alt="" class="imgs" /></a>
											<a class="thumb" onclick="selectThumb(3);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/attendance/jan/m_round_person3.png" alt="" class="imgs" /></a>
											<a class="thumb" onclick="selectThumb(4);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/attendance/jan/m_round_person4.png" alt="" class="imgs" /></a>
											<a class="thumb" onclick="selectThumb(1);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/attendance/jan/m_round_person1.png" alt="" class="imgs" /></a>
											<a class="thumb" onclick="selectThumb(2);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/attendance/jan/m_round_person2.png" alt="" class="imgs" /></a>
											<a class="thumb" onclick="selectThumb(3);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/attendance/jan/m_round_person3.png" alt="" class="imgs" /></a>
											<a class="thumb" onclick="selectThumb(4);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/attendance/jan/m_round_person4.png" alt="" class="imgs" /></a>
											<a class="thumb" onclick="selectThumb(1);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/attendance/jan/m_round_person1.png" alt="" class="imgs" /></a>
											<a class="thumb" onclick="selectThumb(2);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/attendance/jan/m_round_person2.png" alt="" class="imgs" /></a>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- //icon -->
					</div>
					<p class="total_num">전체 글 : <span id="reply_cnt"></span></p>
				</div>
				<div class="view_area">
					<!-- 
						썸네일 클래스 10종
						.face1~10 
					-->
					<ul></ul>
				</div>
				<div class="paging" id="paginate">
			</div>
			<!-- // 게시판 -->
			
			<a href="#" class="sprite btn_caution btn_caution-2" onclick="onoff('notetxt2'); return false;">꼭!확인하세요</a>
		</div>
	</div>
	<!-- //이벤트02 -->

	<!-- 이벤트03 -->
	<div class="section evt_3rd scroll">
		<div class="contents">			
			<div id="evt3" class="evt3_area">
				<div class="evt3_area__inner">
					<div class="blind">
						<h2>이벤트3 : APP에서 신학기상품 구매하고 해피머니 상품권 받자!</h2>
						<p>앱에서 많이 구매할수록 당첨확률 UP!</p>
						<ol>
							<li>해피머니 온라인 상품권 2만원 권 (e머니 20,000점으로 지급), 50명 추첨</li>
						</ol>				
					</div>
										
					<a href="javascript:///" class="btn_goevt" target="_blank" title="새창 열림">기획전 보러 가기</a>
					<a href="javascript:///" class="btn_apply" id="event2_join">응모하기</a>
				</div>
				
				<ul class="evt_info">					
					<li>이벤트 참여 및 구매 기간 : 2019년 2월 11일 ~ 3월 10일</li>
					<li>참여 방법 : APP &gt; 적립대상 쇼핑몰에서 구매하고 응모하기</li>
					<li>당첨자 발표 : 2019년 4월 25일 목요일 [에누리 앱 &gt; 이벤트/기획전 &gt; 이벤트 하단 당첨자 발표]</li>
					<li>사정에 따라 경품이 변경될 수 있습니다.</li>
				</ul>
			</div>
		</div>
		
		<!-- 유의사항 WRAPPER -->
		<div class="caution-wrap">
			<a href="#" class="sprite btn_caution evt-caution-3">꼭!확인하세요</a>
			
			<!-- 유의사항 드롭다운 -->
			<div class="moreview">
				<h4>유의사항</h4>
				<div class="txt">
					<dl class="txtlist">
						<dt>이벤트/구매 기간 :</dt>
						<dd>2019년 2월 11일 ~ 3월 10일</dd>
					</dl>
					
					<dl class="txtlist">
						<dt>경품 : </dt>
						<dd>[해피머니] 온라인 상품권 2만원권 – e머니 20,000점 지급 (50명 추첨)</dd>
						<dd><strong>e머니 유효기간 : 적립일로부터 15일</strong></dd>
						<dd>사정에 따라 경품이 변경될 수 있습니다.</dd>				
					</dl>
		
					<dl class="txtlist">
						<dt>당첨자 발표 및 적립</dt>
						<dd>2019년 4월 25일 [APP 이벤트/기획전 탭 &gt; 이벤트 하단 당첨자 발표]</dd>
					</dl>
					
					<dl class="txtlist">
						<dt>구매방법 및 유의사항</dt>
						<dd>에누리 가격비교 앱 로그인 &rarr; 적립대상 쇼핑몰 이동 &rarr; 구매하기 &rarr; 구매확정(배송완료) 금액이 1,000원 이상 시 e머니 적립</dd>
						<dd>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스)</dd>
						<dd>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품 결제금액만 반영</dd>
						<dd>구매 e머니는 구매 확인완료 시점(구매 후 최대 30일)부터 모바일 앱 &rarr; 마이 에누리 &rarr; 적립내역 페이지에서 [적립받기] 선택시 적립(수동적립)</dd>
						<dd>적립내역 페이지에서 [적립받기]를 선택하지 않은 경우에는 구매적립불가</dd>
						<dd>구매 e머니는 카테고리에 따라 차등 적립</dd>
						</dl>
						
						<dl class="txtlist">
						<dt>※ 카테고리별 적립률 상세						
							<div class="tb">
								<table>
									<colgroup>
										<col width="65%" /><col width="30%" />
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
						</dt>
						<dd>적립대상쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제 시 구매건수는 1건이며, 구매금액은 통합 결제한 금액의 e머니 적립</dd>
						<dd>결제일로부터 10~30일간 취소/반품여부 확인 후 적립</dd>
						<dd>e머니는 최소 10점부터 적립되며 (구매금액 1,000원 이상), 1원 단위 e머니는 적립되지 않습니다. 
							<br />(예: 1,200원 결제 시 e머니 10점 적립)</dd>
						<dd>구매적립 e머니 유효기간: 적립가능 시점부터 최대 60일(기간경과 이후 적립불가)</dd>
						<dd>적립된 e머니는 e쿠폰 스토어에서 다양한 e쿠폰으로 교환 가능합니다.</dd>
					</dl>
						
						<dl class="txtlist">
							<dt>상품권 및 e쿠폰 적립 상세</dt>
						<dd>적립가능 상품 (0.3% 적립): 문화상품권(해피머니, 컬쳐랜드), 도서상품권, 백화점상품권, 영화예매권, 국민관광 상품권</dd>
						<dd>적립가능 상품을 제외한 상품권, 지역쿠폰, e교환권, e쿠폰은 적립불가</dd>
						<dd>상품권 적립가능 쇼핑몰: 티몬, G마켓, 옥션</dd>
					</dl>
		
					<dl class="txtlist">
						<dt>아래의 경우에는 구매 확인 및 적립이 불가합니다.</dt>
						<dd>에누리 가격비교 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱으로 결제만 한 경우<br />(에누리 가격비교 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)</dd>
						<dd>에누리 가격비교 앱 미 로그인 후 구매한 경우 또는 에누리 가격비교 PC, 모바일 웹에서 구매한 경우</dd>
					</dl>
					
					<dl class="txtlist">
						<dt>적립대상쇼핑몰 중 e머니 적립 제외 카테고리/서비스 </dt>
						<dd>에누리 가격비교 앱에서 검색되지 않는 상품</dd>
						<dd>인터파크: 에누리 특가상품(크레이지딜), 모바일쿠폰/상품권, 라이프 서비스(티켓, 투어, 아이마켓 등)</dd>
						<dd>11번가: 여행/숙박/항공, 모바일쿠폰/상품권 전체</dd>
						<dd>G마켓: 중고장터, 실시간 여행, 항공권, 도서/음반, 모바일쿠폰/상품권(일부 상품권 적립가능)</dd>
						<dd>옥션: 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권(일부 상품권 적립가능)</dd>
						<dd>SSG: 도서/음반/문구/취미/여행, 모바일쿠폰/상품권/서비스 및 현금성 상품</dd>
						<dd>티몬: 슈퍼꿀딜, 슈퍼마트 등 특가 판매 상품, 모바일쿠폰/상품권(일부 상품권 적립가능)</dd>
						<dd>위메프: 모바일쿠폰/상품권 전체</dd>
						<dd>CJ몰: 모바일쿠폰/상품권 전체</dd>
						<dd>모바일쿠폰/상품권: 상품권, 지역쿠폰, e교환권, e쿠폰 등 (문화상품권, 도서상품권, 백화점상품권, 영화예매권, 국민관광상품권은 적립 가능)</dd>
						<dd>이 외 쇼핑몰에 입점한 제휴 서비스(배달, 티켓, 해외직구 등) 및 일부 카테고리 제외</dd>
					</dl>
					
					<dl class="txtlist">
						<dt>유의사항</dt>
						<dd>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</dd>
						<dd>더블적립 대상자는 본 이벤트와 중복참여하실 수 없습니다.</dd>
					</dl>
					<a href="#" class="btn_check_hide">확인</a>
				</div>
			</div>
			<!-- //첫구매 유의사항 -->
			
			<script>
			// 유의사항 드롭다운
			$('.evt-caution-3').click(function(){
				var _this = $(this);
				_this.siblings(".moreview").toggle();
				
				$(".btn_check_hide").click(function(){
					$(this).parents(".moreview").slideUp();
					$('html,body').stop().animate({scrollTop:_this.offset().top});
					return false;
				});
				
				return false;
			});
			</script>
		</div>
		<!-- //유의사항 WRAPPER -->
	</div>
	<!-- //이벤트 03 -->
	
	<!-- 에누리 혜택 -->
	<%@include file="/eventPlanZone/jsp/eventBannerTapMobile_xmas_2018.jsp"%>
	<span class="go_top"><a href="javascript:///">TOP</a></span>
</div>

<!-- layer--> 
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();">설치하기</button></p>
	</div>
</div>

<!-- 당첨 레이어 --> 
<div class="voteResult_layer" id="prizes" style="display:none">
	<div class="inner_layer">
		<div class="cont_area">
			<div class="img_box">
				<img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear_pro/m_vote_img01.png" alt="축하해요~!! e머니 4,000점 적립 내일 또 만나요~" class="p_img" />
				<!--
				<img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear_pro/m_vote_img02.png" alt="e머니 5점 적립 내일 또 만나요~" class="p_img" />
				-->
			</div>
			<a class="btn layclose" href="javascript:///" onclick="onoff('prizes'); return false;"><em>팝업 닫기</em></a>
		</div>
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
				<li>이벤트 경품: e4,500점, e5점</li>
				<li>적립된 e머니는 e머니 스토어에서 다양한 e쿠폰상품으로 교환 가능합니다.</li> 
				<li><strong class="emp">e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</strong></li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
			</ul>
		</div>
		<p class="btn_close"><button type="button" onclick="onoff('notetxt1');return false;">닫기</button></p>
	</div>
</div>

<!-- 이벤트2 유의사항 --> 
<div class="layer_back" id="notetxt2" style="display:none;">
	<div class="noteLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt2');return false;">창닫기</a>

		<div class="inner">
			<dl class="txtlist">
				<dt>이벤트 기간 :</dt>
				<dd>2019년 2월 11일 ~ 3월 10일</dd>
			</dl>
			
			<dl class="txtlist">
				<dt>경품 : </dt>
				<dd>맥도날드 딸기 선데이 아이스크림 – e머니 1,500점 지급 (100명 추첨)</dd>
					<dd><strong class="emp">e머니 유효기간 : 적립일로부터 15일 (미사용시 자동소멸)</strong></dd>
				<dd>사정에 따라 경품이 변경될 수 있습니다.</dd>
			</dl>

			<dl class="txtlist">
				<dt>당첨자 발표 및 적립</dt>
				<dd>2019년 4월 25일 목요일 [APP 이벤트/기획전 탭 &gt; 이벤트 하단 당첨자 발표]</dd>
				<dd>적립된 e머니는 e머니 스토어에서 다양한 e쿠폰상품으로 교환 가능합니다.</dd>
				<dd>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다.</dd>
			</dl>
		</div>
		<p class="btn_close"><button type="button" onclick="onoff('notetxt2');return false;">닫기</button></p>
	</div>
</div>

<div class="event_layer complete" id="completeJoin" style="display:none">
	<div class="inner_layer">
		<h3 class="tit stripe_layer">응모가 완료되었습니다.</h3>
		<a href="javascript:///" class="stripe_layer close" onclick="onoff('completeJoin')">창닫기</a>
		<div class="viewer">
			<ul class="new_product_list" id="completeJoin_list"></ul>
		</div>
		<p class="btn_close"><button type="button" class="btn_confirm stripe_layer" onclick="onoff('completeJoin')">확인</button></p>
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
var vEvent_title = "19년 설날프로모션";
var isFlow = "<%=flow%>" == "ad";
var vOs_type = getOsType();
var state = false;

var tab = "<%=tab%>";

var reply_event_code = "2019021103"; //응원메세지 남기기
var PAGENO = 1;
var PAGESIZE = 5;
var BLOCKSIZE = 5;
var totalcnt = 0; //댓글 총갯수


Kakao.init('5cad223fb57213402d8f90de1aa27301');

/* 데이터 로드 영역 */
var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=25";

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
		ga('send', 'event', 'mf_event', vEvent_title, "19 새학기프로모션_상단탭_매일참여");
	}else if(num == 3){
		ga('send', 'event', 'mf_event', vEvent_title, "19 새학기프로모션_상단탭_응원메세지");
	}else if(num == 4){
		ga('send', 'event', 'mf_event', vEvent_title, "19 새학기프로모션_상단탭_구매응모");
	}else if(num == 5){
		if(isFlow){
			ga('send', 'event', 'mf_event', vEvent_title, "19 새학기프로모션_이벤트1참여");
		}else{
			ga('send', 'event', 'mf_event', vEvent_title, "19 새학기프로모션_이벤트1참여");
		}
		
	}else if(num == 6){
		ga('send', 'event', 'mf_event', vEvent_title, "19 새학기프로모션_상품탭_PC/노트북");
	}else if(num == 7){
		ga('send', 'event', 'mf_event', vEvent_title, "19 새학기프로모션_상품탭_학용품");
	}else if(num == 8){
		ga('send', 'event', 'mf_event', vEvent_title, "19 새학기프로모션_상품탭_가방/패션");
	}else if(num == 9){
		ga('send', 'event', 'mf_event', vEvent_title, "19 새학기프로모션_상품탭_학생가구");
	}else if(num == 10){
		ga('send', 'event', 'mf_event', vEvent_title, "19 새학기프로모션_상품탭_든든아침");
	}else if(num == 11){
		if(isFlow)	ga('send', 'event', 'mf_event', vEvent_title, "19 새학기프로모션_상품클릭");
		else		ga('send', 'event', 'mf_event', vEvent_title, "19 새학기프로모션_상품클릭");
	}else if(num == 12){
		if(isFlow)	ga('send', 'event', 'mf_event', vEvent_title, "19 새학기프로모션_상품더보기");
		else		ga('send', 'event', 'mf_event', vEvent_title, "19 새학기프로모션_상품더보기");	
	}else if(num == 13){
		if(isFlow) ga('send', 'event', 'mf_event', vEvent_title, "19 새학기프로모션_기획전보러가기");
		else	   ga('send', 'event', 'mf_event', vEvent_title, "19 새학기프로모션_기획전보러가기");
	}else if(num == 14){
		if(isFlow) ga('send', 'event', 'mf_event', vEvent_title, "19 새학기프로모션_응모하기");
		else	   ga('send', 'event', 'mf_event', vEvent_title, "19 새학기프로모션_응모하기");
	}else if(num == 15){
		ga('send', 'event', 'mf_event', vEvent_title, "19 새학기프로모션_응모_구매하기");
	}else if(num == 16){
		ga('send', 'event', 'mf_event', vEvent_title, "19 새학기프로모션_혜택배너");
	}
}

$(document).ready(function() {
	// 댓글 페이지 호출
	getEventList(PAGENO, PAGESIZE);
	
	// 개인정보 불러오기
	if(islogin()){
		$(".login_alert").addClass("disNone");
		$("#user_id").text("<%=cUserId%>");
	}
	
	// 댓글 썸네일 랜덤 호출
	var rdm = Math.floor(Math.random() * 3) + 1;
	$("#btnIcon").append('<img id="selected_thumb" src="http://imgenuri.enuri.gscdn.com/images/event/2018/attendance/jan/m_round_person'+ rdm +'.png" '
			+ 'alt="" class="imgs" idx="'+ rdm +'"/>');
	
	$(document).mouseup(function(e){
		var container = $(".txt_area");
		if(container.has(e.target).length==0){
			$(this).find("#txt_area").attr("placeholder", "글을 입력해주세요");
			$(".input.open").removeClass("open");
	    }
	});

	$('.txt_area').on('keyup', function() {	$("#word_num").text($(this).val().length);	});
	
	if(isFlow)	ga('send', 'pageview', {'page': vEvent_page,'title': '19 새학기프로모션_PV'});	
	else		ga('send', 'pageview', {'page': vEvent_page,'title': '19 새학기프로모션_PV'});
	
	if(tab != ""){
		setTimeout(function() {
	        $(".floattab__list li > a").eq(tab-1).trigger("click");
	    },300);
	}
	
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
	
	$menu.on('click', 'a', function (e) {
		var $target = $(this).parent(),
			idx = $target.index(),
			offsetTop = Math.ceil($contents.eq(idx).offset().top);

		$('html, body').stop().animate({ scrollTop: offsetTop - $navheight }, 500);
		
		//if(idx == 0)		insertLog(18787);	
		//else if(idx == 1)	insertLog(18788);
		//else if(idx == 2)	insertLog(18789);
		
		return false;
	});
	
	//응모하기 버튼
	$("#event2_join").click(function(e){
		da_ga(14);
		if(app != 'Y'){
			onoff('app_only');
		}else {
			getEventAjaxData( {"procCode": 5 } ,function(data) {
				if(data.result == 1){
			       alert("이미 응모하셨습니다.\n앱에서 구매 시\n구매내역 자동 누적됩니다.");
				}else if(data.result == 2){
			        //alert("이벤트에 응모해주셔서 감사합니다.");
			         var rdm = Math.floor(Math.random() * 4);
			         var goodsList = shuffle(ajaxData[rdm]["GOODS"]);
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
			 				html+= "	<a href=\"javascript:;\" onclick=\"window.open('/mobilefirst/detail.jsp?modelno="+modelno+"&freetoken=vip');\" title=\"새 탭에서 열립니다.\">";
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
	
	$(".btn_goevt").click(function(){
		da_ga(13);
		window.open("/mobilefirst/event2019/newsemester_2019.jsp");
		return false;
	});
	
	//닫기버튼
	$('.win_close').click(function(){
		if(getCookie("appYN") == 'Y'){
			window.location.href = "close://";
		}else{
			window.location.replace("/mobilefirst/index.jsp");
		}
	});
	
	//Default Action
	$(".big_img li").hide(); 
	$(".thum_img li:first").addClass("on").show(); 
	$(".big_img li:first").show();
	 
	//On Click Event
	$(".thum_img li").click(function() {
		$(".thum_img li").removeClass("on"); 
		$(this).addClass("on"); 
		$(".big_img li").hide(); 
		var activeTab = $(this).find("a").attr("href");
		$(activeTab).fadeIn();
		return false;
	});
	
	//로그인시 개인화영역
	if(islogin()){
		$("#user_id").text("<%=cUserId%>");
		getPoint();//개인e머니 내역 노출
	}
	
	$(".sprite.btn_more").click(function(){
		var goods_more = "/mobilefirst/event2019/newsemester_2019.jsp?tab="+nowTab;
		da_ga(12);
		window.open(goods_more); 
	});
	
	$('#sendMsg').on('keyup', function() {	$("#word_num").text($(this).val().length);	});
	
	$("#snslayer li").click(function(){
		var shareUrl = "http://" + location.host + "/mobilefirst/event2019/newsemester_2019_evt.jsp";
		var shareTitle = "[에누리 가격비교]\n새로운 시작을 위한 응원이벤트!";
		var idx = $(this).index();
		
		if(idx == 1) {
			 try{ 
				
				Kakao.Link.sendDefault({
				      objectType: 'feed',
				      content: {
				        title: shareTitle,
				        description: "신학기상품 구매하면\n해피머니상품권을?\n지금 당장 에누리로~!",
				        imageUrl: "http://http://imgenuri.enuri.gscdn.com/images/event/2019/newsemester_pro/m_visual2.jpg",
				        link: {
				          mobileWebUrl: shareUrl,
				          webUrl: shareUrl
				        }
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
	
	loadGoodsList(ajaxData[0]);
	tabLoading();
});

$(window).load(function() {
	//아이콘 선택
	$("#btnIcon").on("click", function(e){
		if(!state){
			$(".thumb_sm").css("z-index", 100);
			$(".thumb_sm_list").addClass("showIcon");
			state = true;
		}else{
			$(".thumb_sm_list").removeClass("showIcon");
			$(".thumb_sm").animate({"z-index": 0}, 300);
			$(".txt_area").focus();
			state = false;
		}
	});
	
	//댓글 클릭 및 등록 이벤트
	$(".login_alert").on("click", function(e){
		alert('로그인 후 참여할 수 있습니다.');
		goLogin();
		return false;
	});
	
	$(".txt_area").on("click", function(e){
		$(this).parent().addClass("open");
		$(this).attr("placeholder", "광고글, 욕설 등 부적합한 게시물은 관리자에 의해 삭제될 수 있습니다. 한 번 등록한 댓글은 수정이 불가하오니 등록 전 확인 부탁드립니다.");
		$(".txt_area").focus();
	});
	
	$(".btn.regist.board-stripe").click(function(){
		if(!islogin()){
	        alert("로그인 후 참여 가능합니다.");
	        goLogin();
	        return false;
	    }
	    var replyMsg = $(".txt_area").val();
	    var count = replyMsg.length;
	    var idx= $("#selected_thumb").attr("idx");

	    if(count < 10){
	    	alert("10자 이상 입력해주세요.");
	    }else{
	    	var url = "/event2016/mobile_award_setlist.jsp";
			var vData = {replyMsg : replyMsg, event_id : reply_event_code, iconFlag : idx, osType : vOs_type};
			$.ajax({
		        type: "POST",
		        url: url,
		        data: vData,
		        dataType: "JSON",
		        success: function(result){
		        	if (result.result == "true") {
		        		getEventList(1, PAGESIZE);
		        		alert("등록되었습니다!");
		        		$(".txt_area").val("");
					} else {
						alert("오늘은 이미 참여해 주셨습니다! \n내일 또 남겨주세요~");
					}
		        	$("#txt_area").val("");
		        	$("#word_num").text("0");
		        },
				error: function (xhr, ajaxOptions, thrownError) {}
		    });
	    }
	});

	$('#reply_area').on('keyup', function() {
		$("#word_num").text($(this).val().length + " /80"); // 댓글창 입력사이즈 보여주기
	});

	if(islogin()){
		$("#input_area").attr("class","input login");
	     $("#reply_area").attr("placeholder", "광고글, 욕설 등 부적합한 게시물은 관리자에 의해 삭제될 수 있습니다.\n 한 번 등록한 댓글은 수정이 불가하오니 등록 전 확인 부탁 드립니다.");
	} else{
		$("#input_area").attr("class","input logout");
	}
	
	function selectThumb(type){
		$("#selected_thumb").attr("src","http://imgenuri.enuri.gscdn.com/images/event/2018/attendance/jan/m_round_person" + type + ".png");
		$("#selected_thumb").attr("idx",type);
		$(".thumb_sm_list").removeClass("showIcon");
		$(".thumb_sm").animate({"z-index": 0}, 300);
		$(".txt_area").focus();
		$(".input").addClass("open");
		state = false;
	}
});

//get 게시판, navigation
function getEventList(varPageNo, varPageSize) {
	$.ajax({
		type: "GET",
		url: "/event2016/mobile_award_getlist.jsp",
        data: "pageno="+varPageNo+"&pagesize="+varPageSize+"&event_id="+reply_event_code+"&del_yn=N",
		dataType: "JSON",
		success : function(json){
			$("#body_list").html(null);
			if(json.eventlist){ // get 게시판
				var template = "";
				var idx = Math.floor(Math.random() * 4);

				for(var i=0;i<json.eventlist.length;i++){
					if(i==0){
						totalcnt = json.eventlist[i].totalcnt;
						$("#reply_cnt").text(totalcnt);
					}
					var iconFlag = Number(json.eventlist[i].iconFlag);
					var reply_date = json.eventlist[i].reply_date;
					var year = reply_date.substring(0,4);
					var month = reply_date.substring(6,4);
					var day = reply_date.substring(8,6);
					var user_id = json.eventlist[i].user_id;
					var reply_msg = XSSfilter(json.eventlist[i].reply_msg).replace(/\n/gi, "<br>");

					template +="<li>";
					template +="<p class='thumb'><img src=\"http://imgenuri.enuri.gscdn.com/images/event/2018/attendance/jan/m_round_person"+iconFlag+".png\" class=\"imgs\" ></p>";
                    template +="<p class='user'>"+user_id+"</p>";
	                template +="<p class='cont'>"+reply_msg+"</p>";
                    template +="</li>";

				}
				$(".view_area > ul").html(template);

				// get navigation
				if (totalcnt != 0) {
					var paging2 = new paging(varPageNo, varPageSize, BLOCKSIZE, totalcnt, 'paginate','goPage');
				  	paging2.calcPage();
				  	paging2.getPaging();
				  	if(varPageNo!=1){
				  		var offset = $("#reply_cnt").offset();
	        			var head = $(".nav").outerHeight();
	        	    	$("html,body").stop(true).animate({scrollTop:offset.top - head - 50},50,"swing");
				  	}
				}
			}
		}, complete : function(){
			$("#paginate > ul > li").click(function(e){
				$("#paginate > ul > li:eq("+$(this).index()+")").removeClass("selected");
			});
		}, error : function (xhr, ajaxOptions, thrownError) {
		}
	});

	function XSSfilter (content) {
		return content.replace(/\</g, "&lt;").replace(/\>/g, "&gt;");
	}
	
	//goAdbrix("evt_visit_view");
}
// 페이지 이동
function goPage(pageno) {
	getEventList(pageno, PAGESIZE);
}


var proSlide ;

setTimeout(function(){
	proSlide = $('.itemlist').slick({
		dots:true,
		slidesToScroll: 1
	});
},100);

function shuffle(arra1) {
    var ctr = arra1.length, temp, index;
    while (ctr > 0) {
        index = Math.floor(Math.random() * ctr);
        ctr--;
        temp = arra1[ctr];
        arra1[ctr] = arra1[index];
        arra1[index] = temp;
    }
    return arra1;
}

var nowTab = 1;

function tabLoading(){
	
	$(".pro_itemlist .tab_content").hide(); 
	//첫 로딩 시, 첫번째 탭 show
	$(".pro_tabs li:first").addClass("active").show();
	$(".pro_itemlist .tab_content:first").show();
	
	$(".pro_tabs li").click(function() {
		$(".pro_tabs li").removeClass("active"); 
		$(this).addClass("active");
		//$(".pro_itemlist .tab_content").hide(); 
		var activeTab = $(this).find("a").attr("href"); 
		//$(activeTab).fadeIn();
		
		//가격대별 플리킹
		proSlide.slick("destroy");
		
		if(activeTab == "#protab1"){
			loadGoodsList(ajaxData[0]);
			da_ga(6);
			nowTab =1;
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
		}else if(activeTab == "#protab2"){
			loadGoodsList(ajaxData[1]);
			da_ga(7);
			nowTab =2;
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
		}else if(activeTab == "#protab3"){
			loadGoodsList(ajaxData[2]);
			da_ga(8);
			nowTab =3;
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			
		}else if(activeTab == "#protab4"){
			loadGoodsList(ajaxData[3]);
			da_ga(9);
			nowTab =4;
			
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
		}else if(activeTab == "#protab5"){
			loadGoodsList(ajaxData[4]);
			da_ga(10);
			nowTab =5;
			
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			
		}
		return false;
	});
}

function loadGoodsList(obj){
	var goodsList = obj["GOODS"];
	var html = "";
	
	if(goodsList.length >0){
		
		for(var i=0;i<goodsList.length;i++){
			
			if(i%4==0) html += "<ul class=\"items clearfix\">";
				
				var goodsData = goodsList[i];
				var modelno = goodsData["MODELNO"];
				var goods_img = goodsData["GOODS_IMG"];
				var goods_title1 = goodsData["TITLE1"];
				var goods_title2 = goodsData["TITLE2"];
				var goods_minprice = goodsData["MINPRICE"]==null?0:goodsData["MINPRICE"];
				
				html+= "<li class=\"item\">";
				html+= "	<a href=\"/detail.jsp?modelno="+goodsData["MODELNO"]+"\" onclick=\"da_ga(11);\" target=\"_blank\" title=\"새 탭에서 열립니다.\">";
				html+= "		<div class=\"thumb\">";
				html+= "			<img src=\""+goodsData["GOODS_IMG"]+"\" alt=\"\" />";
				if(goodsData["MINPRICE"]==0){
				html+= "			<span class=\"soldout\">SOLD OUT</span>";	
				}
				html+= "		</div>";
				html+= "		<div class=\"pro_info\">";
				html+= "			<span class=\"pro_name\">"+goods_title1+"<br />"+goods_title2+"</span>";
				html+= "			<span class=\"price\"><span class=\"price_label\">최저가</span><em>"+numberWithCommas(goods_minprice)+"</em><span class=\"pro_unit\">원</span></span>";
				html+= "		</div>";
				html+= "	</a>";
				html+= "</li>";	
				
			if(i%4==3) html += "</ul>";
		}
		
		$(".itemlist").html(html);
		
	}
}

function itemClick(modelNo, minprice) {
	if(minprice > 0){
		window.open('/mobilefirst/detail.jsp?modelno=' + modelNo +'&freetoken=vip');
	}else{
		alert("품절된 상품 입니다.");
	}
}
//팝업
function onoff(id) {
	var mid=document.getElementById(id);
	if(mid.style.display=='') {
		mid.style.display='none';
	}else{
		mid.style.display='';
	}
}
var isClick = true;
var sdt = "<%=strToday%>";
function getEventAjaxData(params, callback){
	if(sdt < "20190211"){
		alert('오픈예정입니다.');
		return false;
	}
	if(sdt > "20190310"){
		alert('이벤트가 종료되었습니다.');
		return false;
	}
	
	if(!islogin()){
		alert("로그인 후 이용 가능합니다.");
		goLogin();
		return false;
	}
	
	var evtUrl = "/mobilefirst/evt/ajax/newsemester2019_setlist.jsp";
	if(typeof params === "object") {
		params.sdt = sdt;
		params.osType = "M";
	}
    if(!isClick){
    	return false;
    }
    isClick = false;
	 $.post(evtUrl,params,callback,"json").done(function(){
			isClick = true;
	});
}

$(function(){	
	var $evtbtn = $("#btnPlayGame"), // 스위치
		$evtresult = $(".evt__result"); // 결과화면
	
	$evtbtn.on("click", function(){
		
		getEventAjaxData( {"procCode":1} , function(data) {
			var result = data.result;
			var vVote_img = "";
			var result_img = "";
			var vVote_alt = "";
			var result_alt = "";
			
			da_ga(5);
			
			if(result >= 5){
				if(result == 4500){
					vVote_img += "http://imgenuri.enuri.gscdn.com/images/event/2019/newsemester_pro/pc_vote_img01.png";
					result_img += "http://imgenuri.enuri.gscdn.com/images/event/2019/newsemester_pro/pc_play_success.png";
					vVote_alt = "축하해요~!! e머니 4,500점 적립 내일 또 만나요~";
					result_alt = "최후의 한방 성공!! 내일 또 만나요~";
                }else if(result == 5){
                	vVote_img += "http://imgenuri.enuri.gscdn.com/images/event/2019/newsemester_pro/pc_vote_img02.png";
					result_img += "http://imgenuri.enuri.gscdn.com/images/event/2019/newsemester_pro/pc_play_fail.png";
					vVote_alt = "e머니 5점 적립 내일 또 만나요~";
					result_alt = "아쉽지만 실패.. 내일 또 만나요~";
                } 
				//$(".vote_img").attr("src", vVote_img);
				//$(".vote_img").attr("alt", vVote_alt);
				
				$(".img_box").html("<img src='"+vVote_img+"' alt='"+vVote_alt+"' />");
				
				$evtresult.find("img").attr("src", result_img);
				$evtresult.find("img").attr("alt", result_alt);

				// 게이지 모션 stop
				$(".powergauge .bar").css("animation-play-state", "paused");
				// 버튼 영역 삭제
				$(".game__state").stop().delay(200).fadeOut(300);
				
				// 레이어 팝업 1.1초 뒤 열림
				$evtresult.stop().delay(500).fadeIn(1000, function(){ // 당첨 결과 보여줌.
					$("#prizes").fadeIn(300); // 레이어 팝업 열림
				});
				
				//getTopEmoney();

			}else if(result == -1){
				alert("이미 참여하셨습니다.\n내일 또 참여해주세요.");
                working = false;
			}else if(result == -99){
				alert("임직원은 참여 불가합니다.");
                working = false;
			} else if(result == -55){
				alert("잘못된 접근입니다.");
			}else{
                working = false;
			}
		});
		
	});
});

function goAdbrix(strEvent){
	if(app == "Y"){
		try{
	        if(window.android){            // 안드로이드                  
	                 window.android.igaworksEventForApp (strEvent);
	        }else{                                                       // 아이폰에서 호출
	                 //window.location.href = "enuriappcall://igaworksEventForApp?strEvent="+ strEvent;
	        }
		}catch(e){}		
	}
}

$(window).load(function(){
	if(tab!='') {
		setTimeout(inner, 300);
	}
	function inner() {
		$('html, body').animate({scrollTop: Math.ceil($('#'+tab).offset().top)}, 500);
	}
});

function numberWithCommas(x) {   return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");		}
</script>
</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
