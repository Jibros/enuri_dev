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
	response.sendRedirect("/event2019/newyear_2019_evt.jsp");
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
String strFb_description = "새해이벤트";
String strFb_img = ConfigManager.IMG_ENURI_COM + "/images/mobilenew/images/logo_enuri.png";
String tab = ChkNull.chkStr(request.getParameter("tab"),"0");
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
	<link rel="stylesheet" type="text/css" href="/css/event/y2019/newyear_pro_m.css?v=20181227"/>
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/lib/animate.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
	<script type="text/javascript" src="/common/js/function.js"></script>
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
				<h1 class="blind">2019년 福터지는 설맞이 혜택</h1>
				<p class="blind">새해맞이 특별한 이벤트 누리세요</p>
			</div>
		</div>
	
		<div class="section floattab">
			<div class="contents">
				<ul class="floattab__list">
					<li><a onclick="da_ga(2)" class="floattab__item floattab__item--01">행운의 모찾고 상품권 받자!</a></li>
					<li><a onclick="da_ga(3)" class="floattab__item floattab__item--02">신년카드 발송이벤트</a></li>
					<li><a onclick="da_ga(4)" class="floattab__item floattab__item--03">APP구매시 황금돼지바 증정</a></li>
				</ul>
			</div>
		</div>
		
	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<!-- 이벤트01 -->
	<div id="evt1" class="section evt_1st scroll">
		<!-- 윷놀이 -->
		<div class="evt_play">
			<h2 class="tit">이벤트1 : 새해복 많이 받으세요! 행운의 윷을 찾아라!</h2>
		
			<div class="gamebox">
				<!-- <div class="game__state">윷 이미지</div> -->					
				
				<div class="game__btn">
					<button type="button" class="btn_yoot1">윷1</button>
					<button type="button" class="btn_yoot2">윷2</button>
					<button type="button" class="btn_yoot3">윷3</button>
					<button type="button" class="btn_yoot4">윷4</button>
				</div>
				<span class="balloon">윷을 클릭해주세요</span>
				
				<div id="motionPlay" class="motionyoot1"></div>
				
				<button type="button" id="btnPlayGame" class="game__trigger">윷던지기 클릭 영역</button>
				<!-- 선택 결과 -->
				<div class="evt__result">
					<img src=""  alt=""/>
					<!-- 결과 : 성공 -->
					<!-- <img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear_pro/m_play_success.png" alt="축하합니다! 행운의 윷이 나왔어요~~!" /> -->
					<!-- 결과 : 꽝 
					<img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear_pro/m_play_fail.png" alt="아쉽지만 행운의 모가 나오지 않았어요" />
					-->
				</div>
			</div>
			<a href="javascript:///" class="sprite btn_caution" onclick="onoff('notetxt1'); return false;">꼭!확인하세요</a>
		</div>
	</div>
	<!-- //이벤트01 -->
	
	<!-- 이벤트02 -->
	<div id="evt2" class="section evt_2th scroll">
		 <div class="contents">
			<!-- 감사카드 -->
			<div class="card_area">
				<h2 class="tit">이벤트2 : 고마운 사람에게 신년카드 보내기!</h2>
									
				<div class="card_body">
					<ul class="thum_img">
						<li class="on"><a href="#tab01"><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear_pro/m_card_thumb01.jpg" alt="" /></a></li>
						<li><a href="#tab02"><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear_pro/m_card_thumb02.jpg" alt="" /></a></li>
						<li><a href="#tab03"><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear_pro/m_card_thumb03.jpg" alt="" /></a></li>
					</ul>
	
					<ul class="big_img">
						<li id="tab01"><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear_pro/m_card_img01.jpg" alt="" /></li>
						<li id="tab02"><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear_pro/m_card_img02.jpg" alt="" /></li>
						<li id="tab03"><img src="http://imgenuri.enuri.gscdn.com/images/event/2019/newyear_pro/m_card_img03.jpg" alt="" /></li>
					</ul>
					
					<div class="msg_box">
						<span class="dear"><input type="text" placeholder="받는 사람" id="dearUsr" title="받는 사람 입력"></span>
						<textarea placeholder="신년 메세지를 적어주세요." id="sendMsg"></textarea>
						<span class="from"><input type="text" placeholder="보내는 사람" title="받는 사람 입력" id="fromUsr"  ></span>
						<em><span id="word_num">0</span>/30</em>
					</div>
					<a href="javascript:///" class="sprite send_card" id="send_card" onclick="sendLink()" >카카오톡으로 카드 보내기</a>
					<a href="javascript:///" class="sprite btn_caution btn_caution-2" onclick="onoff('notetxt2'); return false;">꼭!확인하세요</a>
				</div>
			</div>
		</div>
	</div>
	<!-- //이벤트02 -->

<!-- 추천 상품 영역 -->
	<div class="section pro_itemlist">
		<div class="contents">
			<h2 class="tit">실속만점 가격대별 설 선물세트</h2>
			
			<!-- 추천상품 탭 -->
			<ul class="pro_tabs">
				<li class="active"><a href="#protab1">1만원이하</a></li>
				<li><a href="#protab2">1~5만원</a></li>
				<li><a href="#protab3">5~10만원</a></li>
				<li><a href="#protab4">10만원이상</a></li>
			</ul>
			<!-- //추천상품 탭 -->
			
			<!-- 추천상품 콘텐츠 -->
			<div class="tab_container">
				<!-- 1만원대 상품 -->
				<!-- 
					SLICK $(".itemlist")
					4개의 탭 콘텐츠가 있습니다. "tab_content"
					하나의 콘텐츠마다 ul 단위로 한 판(상품4개)씩 움직입니다. 				
				-->
				<div id="protab1" class="tab_content">
					<div class="itemlist"></div>
					<a class="sprite btn_more" href="javascript:///" >상품더보기</a>
				</div>
				<!-- //1~5만원대 상품 -->
			</div>
			<!-- //추천상품 콘텐츠 -->
		</div>
	</div>
	<!-- //추천 상품 영역 -->
	
	<!-- 이벤트03 -->
	<div class="section evt_3rd scroll">
		<div class="contents">			
			<div class="evt3_area">
				<div class="evt3_area__inner">
					<div class="blind">
						<h3>APP에서 설 선물세트 구매하고 황금돼지 골드바 받자!</h3>
						<p>앱에서 많이 구매할수록 당첨확률 UP!</p>
						<ol>
							<li>50만원 이상 구매한 3명에게 황금돼지 골드바 1돈 실물배송</li>
							<li>10만원 이상 구매한 10명에게 호두파운드케익 e머니 12000점으로 지급</li>
							<li>5만원 이상 구매한 40명에게 GS25상품권 5천원, e머니 5000점으로 지급</li>
						</ol>				
					</div>
										
					<a href="javascript:///" class="btn_goevt" title="새창 열림">기획전 보러 가기</a>
					<a href="javascript:///" class="btn_apply" >응모하기</a>
				</div>
				
				<ul class="evt_info">					
					<li>이벤트 참여 및 구매 기간 : 2019년 1월 7일 ~ 2월 6일</li>
					<li>참여 방법 : APP &gt; 적립대상 쇼핑몰에서 구매하고 응모하기</li>
					<li>당첨자 발표 : 2019년 3월 20일 수요일 [에누리 앱 &gt; 이벤트/기획전 &gt; 이벤트 하단 당첨자 발표]</li>
					<li>사정에 따라 경품이 변경될 수 있습니다.</li>
				</ul>
				<!-- <a href="#" class="sprite btn_caution evt-caution-3" onclick="onoff('notetxt3'); $(document).scrollTop(0); return false;">꼭!확인하세요</a> -->
			</div>
		</div>
		
		<!-- 유의사항 WRAPPER -->
		<div class="caution-wrap">
			<a href="javascript:///" class="sprite btn_caution evt-caution-3">꼭!확인하세요</a>
			
			<!-- 유의사항 드롭다운 -->
			<div class="moreview">
				<h4>유의사항</h4>
				<div class="txt">
					<dl class="txtlist">
						<dt>이벤트 기간 :</dt>
						<dd>2019년 1월 7일 ~ 2월 6일</dd>
					</dl>
					
					<dl class="txtlist">
						<dt>경품 : </dt>
						<dd>50만원이상 구매시 – 황금돼지골드바 1돈(실물배송) – 3명 추첨 <strong class="emp">※제세공과금 당첨자 부담</strong></dd>
						<dd>10만원이상 구매시 – [파리바게뜨]호두파운드케익(e머니 12,000점) – 10명 추첨</dd>
						<dd>5만원이상 구매시 – GS25상품권 5천원권(e머니 5,000점) - 40명 추첨</dd>
						<dd><strong>e머니 유효기간 : 적립일로부터 15일</strong></dd>
						<dd>사정에 따라 경품이 변경될 수 있습니다.</dd>				
					</dl>
		
					<dl class="txtlist">
						<dt>당첨자 발표 및 적립</dt>
						<dd>2019년 3월 20일 [APP 이벤트/기획전 탭 > 이벤트 하단 당첨자 발표]</dd>
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
					<a href="javascript:///" class="btn_check_hide">확인</a>
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
				<li>이벤트 경품: e4,000점, e5점</li>
				<li>적립된 e머니는 e머니 스토어에서 다양한 e쿠폰상품으로 교환 가능합니다.</li> 
				<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
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
				<dd>2019년 1월 7일 ~ 2월 6일</dd>
			</dl>
			
			<dl class="txtlist">
				<dt>경품 : </dt>
				<dd>맥도날드 상하이 치킨스낵랩 – e머니 2,000점 지급 (100명 추첨)</dd>
					<dd><strong class="emp">e머니 유효기간 : 적립일로부터 15일 (미사용시 자동소멸)</strong></dd>
				<dd>사정에 따라 경품이 변경될 수 있습니다.</dd>
			</dl>

			<dl class="txtlist">
				<dt>당첨자 발표 및 적립</dt>
				<dd>2019년 3월 20일 [APP 이벤트/기획전 탭 &gt; 이벤트 하단 당첨자 발표]</dd>
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
			<ul class="new_product_list"></ul>
		</div>
		<p class="btn_close"><button type="button" class="btn_confirm stripe_layer" onclick="onoff('completeJoin')">확인</button></p>
	</div>
</div>

</div>
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20180831"></script>
<script type="text/javascript">
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로
var vEvent_title = "19년 설날프로모션";
var isFlow = "<%=flow%>" == "ad";

var tab = "<%=tab%>";

Kakao.init('5cad223fb57213402d8f90de1aa27301');

/* 데이터 로드 영역 */
var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=24";

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
		ga('send', 'event', 'mf_event', vEvent_title, "19년 설날프로모션_무빙탭_이벤트1");
	}else if(num == 3){
		ga('send', 'event', 'mf_event', vEvent_title, "19년 설날프로모션_무빙탭_이벤트2");
	}else if(num == 4){
		ga('send', 'event', 'mf_event', vEvent_title, "19년 설날프로모션_무빙탭_이벤트3");
	}else if(num == 5){
		if(isFlow){
			ga('send', 'event', 'mf_event', vEvent_title, "DA_19년 설날프로모션_이벤트1 참여");
		}else{
			ga('send', 'event', 'mf_event', vEvent_title, "19년 설날프로모션_이벤트1 참여");
		}
		
	}else if(num == 6){
		if(isFlow){
			ga('send', 'event', 'mf_event', vEvent_title, "DA_19년 설날프로모션_이벤트2 카카오톡전송");
		}else{
			ga('send', 'event', 'mf_event', vEvent_title, "19년 설날프로모션_이벤트2 카카오톡전송");	
		}
	}else if(num == 7){
		ga('send', 'event', 'mf_event', vEvent_title, "19년 설날프로모션_상품탭_1만원이하");
	}else if(num == 8){
		ga('send', 'event', 'mf_event', vEvent_title, "19년 설날프로모션_상품탭_1~5만원");
	}else if(num == 9){
		ga('send', 'event', 'mf_event', vEvent_title, "19년 설날프로모션_상품탭_5~10만원");
	}else if(num == 10){
		ga('send', 'event', 'mf_event', vEvent_title, "19년 설날프로모션_상품탭_10만원이상");
	}else if(num == 11){
		if(isFlow)	ga('send', 'event', 'mf_event', vEvent_title, "DA_19년 설날프로모션_상품클릭");
		else		ga('send', 'event', 'mf_event', vEvent_title, "19년 설날프로모션_상품클릭");
	}else if(num == 12){
		if(isFlow)	ga('send', 'event', 'mf_event', vEvent_title, "DA_19년 설날프로모션_상품더보기");
		else		ga('send', 'event', 'mf_event', vEvent_title, "19년 설날프로모션_상품더보기");	
	}else if(num == 13){
		if(isFlow) ga('send', 'event', 'mf_event', vEvent_title, "DA_19년 설날프로모션_기획전보러가기");
		else	   ga('send', 'event', 'mf_event', vEvent_title, "19년 설날프로모션_기획전보러가기");
	}else if(num == 14){
		if(isFlow) ga('send', 'event', 'mf_event', vEvent_title, "DA_19년 설날프로모션_응모하기");
		else	   ga('send', 'event', 'mf_event', vEvent_title, "19년 설날프로모션_응모하기");
	}else if(num == 15){
		ga('send', 'event', 'mf_event', vEvent_title, "19년 설날프로모션_구매응모상품클릭");
	}else if(num == 16){
		ga('send', 'event', 'mf_event', vEvent_title, "19년 설날프로모션_혜택배너");
	}
}

$(document).ready(function() {
	if(isFlow)	ga('send', 'pageview', {'page': vEvent_page,'title': '19년 설날프로모션_PV'});	
	else		ga('send', 'pageview', {'page': vEvent_page,'title': 'DA_19년 설날프로모션_PV'});
	
	if(tab != "0"){
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
	
	$(".btn_apply").click(function(){
		
		if(getCookie("appYN") == 'Y'){
			
			getEventAjaxData( {"procCode": 5 } ,function(data) {
				if(data.result == 1){
					alert("이미 응모하셨습니다.\n앱에서 구매 시\n구매내역 자동 누적됩니다.");
				}else if(data.result == 2){
					//alert("응모가 완료 되었습니다.");
					getBestGoods();
				}
			});
		}else{
			onoff('app_only');			
		}
	});
	
	$(".btn_goevt").click(function(){
		window.open("/mobilefirst/event2018/newyear_2019.jsp");
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
		var goods_more = "/mobilefirst/event2018/newyear_2019.jsp?tab="+nowTab;
		da_ga(12);
		window.open(goods_more); 
	});
	
	$('#sendMsg').on('keyup', function() {	$("#word_num").text($(this).val().length);	});
	
	$("#snslayer li").click(function(){
		var shareUrl = "http://" + location.host + "/mobilefirst/event2019/newyear_2019_evt.jsp";
		var shareTitle = "[에누리 가격비교]\n2019 터지는 설맞이 혜택";
		var idx = $(this).index();
		
		if(idx == 1) {
			 try{ 
				
				Kakao.Link.sendDefault({
				      objectType: 'feed',
				      content: {
				        title: shareTitle,
				        description: "행운의 모를 찾아라",
				        imageUrl: "http://imgenuri.enuri.gscdn.com/images/event/2019/newyear_pro/m_visual.jpg",
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

function getBestGoods(){
	
		var goodsList = ajaxData[0]["GOODS"]; 
		
		shuffle(goodsList);
		
		if(goodsList.length >0){
			
			var _html = "";
			for(var i=0;i<2;i++){
					
				var goodsData = goodsList[i];
				var modelno = goodsData["MODELNO"];
				var goods_img = goodsData["GOODS_IMG"];
				var goods_title1 = goodsData["TITLE1"];
				var goods_title2 = goodsData["TITLE2"];
				var goods_minprice = goodsData["MINPRICE"]==null?0:goodsData["MINPRICE"];
				
				
				_html += "<li>";
				_html += "	<a href=\"javascript:///\">";
				_html += "		<div class=\"img_box\">";
				_html += "			<img src='"+goods_img+"' >";
				_html += "		</div>";
				_html += "		<div class=\"txt_box\">";
				_html += "			<span class=\"n_ptit\">"+goods_title1+"</span>";
				_html += "			<div class=\"n_price\">";
				_html += "				<span class=\"min stripe_layer\">지금최저가</span>";
				_html += "				<span class=\"num\"><strong>"+numberWithCommas(goods_minprice)+"</strong>원</span>";
				_html += "			</div>";
				_html += "		</div>";
				_html += "	</a>";
				_html += "</li>";
				
			}
			$(".new_product_list").html(_html);
			$("#completeJoin").show();
		}
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
			da_ga(7);
			nowTab =1;
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
		}else if(activeTab == "#protab2"){
			loadGoodsList(ajaxData[1]);
			da_ga(8);
			nowTab =2;
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
		}else if(activeTab == "#protab3"){
			loadGoodsList(ajaxData[2]);
			da_ga(9);
			nowTab =3;
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			
		}else if(activeTab == "#protab4"){
			loadGoodsList(ajaxData[3]);
			da_ga(10);
			nowTab =4;
			
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
			
			if(i == 0 || i == 4 || i == 8 || i == 12 || i == 16 || i == 20 || i == 24) html += "<ul class=\"items clearfix\">";
				
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
				
			if(  i == 3 || i == 7 || i == 11 || i == 15 || i == 19 || i == 23 ) html += "</ul>";
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
	if(sdt < "20190107"){
		alert('오픈예정입니다.');
		return false;
	}
	if(sdt > "20190206"){
		alert('이벤트가 종료되었습니다.');
		return false;
	}
	
	if(!islogin()){
		alert("로그인 후 이용 가능합니다.");
		goLogin();
		return false;
	}
	
	var evtUrl = "/mobilefirst/evt/ajax/newyear2019_setlist.jsp";
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

function sendLink() {
	
	if(!islogin()){
		alert("로그인 후 이용가능합니다.");
		goLogin();
		return false;
	}
	
	var msg = $("#sendMsg").val();
	if(msg == ""){
		alert("메세지를 작성해 주세요");
		return false;
	}
	var shareUrl = "http://" + location.host + "/mobilefirst/event2019/newyear_2019_evt.jsp?flow=share";		
	var dear = $("#dearUsr").val();
	var content = $("#sendMsg").val();
	var from = $("#fromUsr").val();
	
	var imgMsg = "";
	$(".thum_img > li ").each(function(i,v){
		var cls = $(this).attr("class");
		if( cls == "on" ){
			imgMsg = $(this).find("img").attr("src");	
		}
	});
	
    Kakao.Link.sendDefault({
      objectType: 'feed',
      content: {
        title: "dear "+dear,
        description: content+"\n"+"from "+from,
        imageUrl: imgMsg,
        link: {
          mobileWebUrl: shareUrl,
          webUrl: shareUrl
        }
      },
      success : function() {
		getEventAjaxData( {"procCode": 4 , "cardImg" : imgMsg  , "cardMsg" : content  , "cardDear": dear  , "cardFrom" : from } , function(data) {
			da_ga(6);
		});
		}
    });
  }

</script>
<script type="text/javascript">
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
				
				$(".game__btn").fadeOut(150);
				
				/* 윷 던지기 모션 */
				var $motion = $("#motionPlay"),
					motionArr = ["motionyoot1", "motionyoot2", "motionyoot3", "motionyoot4", "motionyoot5", "motionyoot6"],
					motionIndex = 0,
					turn = false;
				
				$motion.fadeIn(150);										
				function motionFnc(){
					$motion.attr("class", motionArr[motionIndex]);
					
					if(!turn) motionIndex++;
					else motionIndex--;
					
					if(motionIndex > motionArr.length - 1) turn = true;
					else if(motionIndex < 0){
						clearInterval(setIntv);
						$motion.fadeOut(800);
					}
				} 
				var setIntv = setInterval(motionFnc, 80); // 420s			
				
				if(result == 4000){
					vVote_img += "http://imgenuri.enuri.gscdn.com/images/event/2019/newyear_pro/m_vote_img01.png";
					result_img += "http://imgenuri.enuri.gscdn.com/images/event/2019/newyear_pro/m_play_success.png";
					vVote_alt = "축하합니다 e머니 4,000점 적립! 내일 또 만나요~!";
					result_alt = "축하합니다! 당첨되셨어요~";
                }else if(result == 5){
					vVote_img += "http://imgenuri.enuri.gscdn.com/images/event/2019/newyear_pro/m_vote_img02.png";
					result_img += "http://imgenuri.enuri.gscdn.com/images/event/2019/newyear_pro/m_play_fail.png";
					vVote_alt = "아쉽지만 행운의 모가 나오지 않았어요";
					result_alt = "e머니 5점 적립 내일 또 만나요~";
                } 
				//$(".vote_img").attr("src", vVote_img);
				//$(".vote_img").attr("alt", vVote_alt);
				
				$(".img_box").html("<img src='"+vVote_img+"' alt='"+vVote_alt+"' />");
				
				$evtresult.find("img").attr("src", result_img);
				$evtresult.find("img").attr("alt", result_alt);

				$evtresult.stop().delay(1620).fadeIn(1000, function(){ // 당첨 결과 보여줌.
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
function numberWithCommas(x) {   return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");		}
</script>
</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
