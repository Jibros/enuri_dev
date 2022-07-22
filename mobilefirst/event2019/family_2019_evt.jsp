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
	response.sendRedirect("/event2019/family_2019_evt.jsp");
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
String strFb_description = "가정의달 프로모션";
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
	<link rel="stylesheet" type="text/css" href="/css/event/y2019/family/promotion/mobile.css"/>
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
	
	<!-- 플로팅 배너 - 둥둥이 -->
    <div id="floating_bnr" class="floating_bnr">
        <a href="/mobilefirst/event2019/family_2019.jsp?tab=1" target="_blank"><img src="http://img.enuri.info/images/event/2019/familyPromo/fl_bnr.png" alt="가정의달 선물 반값특가"></a>
        <!-- 닫기 -->
        <a href="#" class="btn_close" onclick="da_ga(4);onoff('floating_bnr');return false;">
            <span class="blind">닫기</span>
        </a>
    </div>
    <!-- // -->

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
				<h1>감사합니다. 5! 사랑가득 해피데이</h1>
				<div class="obj_area">
					<span class="obj_cloude_01"></span>
					<span class="obj_cloude_02"></span>
					<span class="obj_cloude_03"></span>
					<span class="obj_spark_01 initial"></span>
					<span class="obj_spark_02 initial"></span>
					<span class="obj_spark_03 initial"></span>
				</div>
			</div>
		</div>
	
		<div class="section floattab">
			<div class="contents">
				<ul class="floattab__list">
					<li><a onclick="da_ga(2)" href="#evt1" class="floattab__item floattab__item--01 is-on">매일 참여하고 스타벅스 커피</a></li>
					<li><a onclick="da_ga(3)" href="#evt2" class="floattab__item floattab__item--02">APP 구매하고 에어팟 증정</a></li>
				</ul>
			</div>
		</div>
		
	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<!-- 이벤트01 -->
	<div id="evt1" class="section evt_1st scroll">
		<div class="contents">
            <h2>
                <img src="http://img.enuri.info/images/event/2019/familyPromo/m_crane_tit.jpg" alt="매일 참여하면 혜택 가득 -  매일 선물상자 뽑고 스타벅스 커피 받자">
            </h2>
            <div class="crane">
                <!-- 크레인 오브젝트 -->
                <div class="obj_crane ready">
                    <span class="obj_01"></span>
                    <span class="obj_group_01 swing">
                        <span class="obj_02"></span>
                        <span class="obj_03"></span>
                        <span class="obj_04"></span>
                    </span>                    
                </div>
                <span class="obj_gift"></span>
                <!-- // -->
                <!-- 시작버튼 -->
                <div class="btn_area">
                    <a href="#" class="btn_start">
                        <span class="txt_start">START</span>
                    </a>
				</div>
				<!-- 결과 레이어 영역 -->
				<div class="layer_area">
					<!-- case 1 : 축하합니다! 선물상자를 찾으셨네요! -->
					<div class="layer_success">
						<img src="http://img.enuri.info/images/event/2019/familyPromo/w_result_success.jpg" alt="축하합니다! 선물상자를 찾으셨네요!">
					</div>
					<!-- case 2 : 아쉽지만 선물상자를 찾지 못하셨어요. -->
					<div class="layer_fail">
						<img src="http://img.enuri.info/images/event/2019/familyPromo/w_result_fail.jpg" alt="아쉽지만 선물상자를 찾지 못하셨어요">
					</div>
				</div>
                <!-- // -->
            </div>
            <!-- <a href="#" class="sprite btn_caution evt-caution-1" onclick="onoff('notetxt1'); return false;">꼭 확인하세요</a> -->


			<a href="#" class="sprite btn_caution evt-caution-1" onclick="onoff('notetxt1'); return false;">꼭!확인하세요</a>
		</div>
	</div>
	<!-- //이벤트01 -->
	
	<div class="section pro_itemlist">
		<div class="contents">
			<h2 class="tit">감사의 마음을 담은 선물가득</h2>
			
			<!-- 추천상품 탭 -->
			<ul class="pro_tabs">
				<li class="active"><a href="#protab1">#우리아이선물</a></li>
				<li><a href="#protab2">#부모님선물</a></li>
				<li><a href="#protab3">#성년선물</a></li>
				<li><a href="#protab4">#즐길거리</a></li>
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
	<div id="evt2" class="section evt_2rd scroll">
		<h3 class="tit">선물구매하고 혜택가득</h3>
		<p class="blind">APP에서 많이 구매할수록 당첨확률 UP!</p>
		<div class="contents">			
			<div class="evt2_area">
				<div class="evt2_area__inner">
					<div class="blind">
						<h3>APP에서 설 선물세트 구매하고 황금돼지 골드바 받자!</h3>
						<p>앱에서 많이 구매할수록 당첨확률 UP!</p>
						<ol>
							<li>1등 에ㅐ플 에어팟 1세대 (실물배송) 3명 추첨</li>
							<li>2등 도미노피자 콰트로 치즈퐁듀 피자M + 콜라 1.25L (e 17,000점) 15명 추첨</li>
							<li>3등 해피머니 5천원권 (e 5,000점) 40명 추첨</li>
						</ol>				
					</div>
				</div>
				<div class="btn_wrap">
					<a href="javascript:///" class="btn_goevt" target="_blank" title="새창 열림">기획전 보러 가기</a>
					<a href="javascript:///" class="btn_apply" id="event2_join">응모하기</a>
				</div>
				
				<ul class="evt_info">					
					<li>이벤트 참여 및 구매 기간 : 2019년 4월 15일 ~ 5월 19일</li>
					<li>참여 방법 : APP &gt; 적립대상 쇼핑몰에서 구매하고 응모하기</li>
					<li>당첨자 발표 : 2019년 7월 4일 수요일 [에누리 앱 &gt; 이벤트/기획전 &gt; 이벤트 하단 당첨자 발표]</li>
					<li>사정에 따라 경품이 변경될 수 있습니다.</li>
				</ul>
				
				<!-- <a href="#" class="sprite btn_caution evt-caution-3" onclick="onoff('notetxt3'); $(document).scrollTop(0); return false;">꼭!확인하세요</a> -->
			</div>
		</div>
		
		<!-- 유의사항 WRAPPER -->
		<div class="caution-wrap">
			<a href="#" class="sprite btn_caution evt-caution-2">꼭!확인하세요</a>
			
			<!-- 유의사항 드롭다운 -->
			<div class="moreview">
				<h4>유의사항</h4>
				<div class="txt">
					<dl class="txtlist">
						<dt>이벤트/구매 기간 :</dt>
						<dd>2019년 4월 15일 ~ 5월 19일</dd>
					</dl>
					
					<dl class="txtlist">
						<dt>경품 : </dt>
						<dd>1등 – 애플 에어팟 1세대(실물배송) - 3명 추첨 <strong class="emp">※제세공과금 당첨자 부담</strong></dd>
						<dd>2등 - 도미노피자 콰트로 치즈퐁듀 피자 M+콜라 1.25L (e머니 17,000점)-  15명 추첨</dd>
						<dd>3등 – 해피머니 5천원권 (e머니 5,000점) – 40명 추첨</dd>
						<dd><strong>e머니 유효기간 : 적립일로부터 15일</strong></dd>
						<dd>사정에 따라 경품이 변경될 수 있습니다.</dd>			
					</dl>
		
					<dl class="txtlist">
						<dt>당첨자 발표 및 적립</dt>
						<dd>2019년 7월 4일 [APP 이벤트/기획전 탭 > 이벤트 하단 당첨자 발표]</dd>
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
			$('.evt-caution-2').click(function(){
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
	<!-- //이벤트02 -->

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
				<!-- 5,100점 적립 이미지 -->
				<div class="result_01" style="display:none">
					<img src="http://img.enuri.info/images/event/2019/familyPromo/pc_result_img_01.png" alt="축하해요~!! e머니 5,100점 적립 내일 또 만나요~" />
				</div>
				<!-- 5점 적립 이미지 -->
				<div class="result_02" style="display:none">
					<img src="http://img.enuri.info/images/event/2019/familyPromo/pc_result_img_02.png" alt="5점 적립~" />
				</div>
			</div>
			<a class="btn layclose" href="#" onclick="onoff('prizes'); return false;"><em>팝업 닫기</em></a>
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
				<li>이벤트 경품: e5,100점, e5점</li>
				<li>적립된 e머니는 e머니 스토어에서 다양한 e쿠폰상품으로 교환 가능합니다.</li> 
				<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
			</ul>
		</div>
		<p class="btn_close"><button type="button" onclick="onoff('notetxt1');return false;">닫기</button></p>
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
var vEvent_title = "19년 가정의달프로모션";
var isFlow = "<%=flow%>" == "ad";
var vOs_type = getOsType();
var state = false;
var tab = "<%=tab%>";

Kakao.init('5cad223fb57213402d8f90de1aa27301');

/* 데이터 로드 영역 */
var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=27";

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
		ga('send', 'event', 'mf_event', vEvent_title, "19 가정의달 프로모션_탭_이벤트1");
	}else if(num == 3){
		ga('send', 'event', 'mf_event', vEvent_title, "19 가정의달 프로모션_탭_이벤트2");
	}else if(num == 4){
		ga('send', 'event', 'mf_event', vEvent_title, "19 가정의달 프로모션_탭_플로팅");
	}else if(num == 5){
		ga('send', 'event', 'mf_event', vEvent_title, "19 가정의달 프로모션_이벤트1참여");
	}else if(num == 6){
		ga('send', 'event', 'mf_event', vEvent_title, "19 가정의달 프로모션_상품탭_아이선물");
	}else if(num == 7){
		ga('send', 'event', 'mf_event', vEvent_title, "19 가정의달 프로모션_상품탭_부모님선물");
	}else if(num == 8){
		ga('send', 'event', 'mf_event', vEvent_title, "19 가정의달 프로모션_상품탭_성년선물");
	}else if(num == 9){
		ga('send', 'event', 'mf_event', vEvent_title, "19 가정의달 프로모션_상품탭_즐길거리");
	}else if(num == 10){
		ga('send', 'event', 'mf_event', vEvent_title, "19 가정의달 프로모션_상품구매");
	}else if(num == 11){
		ga('send', 'event', 'mf_event', vEvent_title, "19 가정의달 프로모션_상품더보기");
	}else if(num == 12){
		ga('send', 'event', 'mf_event', vEvent_title, "19 가정의달 프로모션_기획전보러가기");	
	}else if(num == 13){
		ga('send', 'event', 'mf_event', vEvent_title, "19 가정의달 프로모션_응모하기");
	}else if(num == 14){
		ga('send', 'event', 'mf_event', vEvent_title, "19 가정의달 프로모션_응모하기_상품");
	}else if(num == 15){
		ga('send', 'event', 'mf_event', vEvent_title, "19 가정의달 프로모션_혜택배너");
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
		window.location.replace("/mobilefirst/index.jsp");
	}
});

(function (global, $) {
	var $spark01 = $(".obj_spark_01"),
	$spark02 = $(".obj_spark_02");
	var sparkTimer01 = setInterval(function(){sparkAnim($spark01)},300);
	var sparkTimer02 = setInterval(function(){sparkAnim($spark02)},400);
	function sparkAnim ($ta){
		if ( $ta.hasClass("initial") ) $ta.removeClass("initial").addClass("step1");
		else if ( $ta.hasClass("step1") ) $ta.removeClass("step1").addClass("step2");
		else if ( $ta.hasClass("step2") ) $ta.removeClass("step2").addClass("step3"); 
		else if ( $ta.hasClass("step3") ) $ta.removeClass("step3").addClass("step4"); 
		else if ( $ta.hasClass("step4") ) $ta.removeClass("step4").addClass("initial");
	}
	    
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
			}else{
				$menu.eq(0).children("a").addClass('is-on');
			}
			if (!($navheight <= $scltop)) {
				$menu.children("a").removeClass('is-on');
				$menu.children("a").eq(0).addClass('is-on');
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
	// 개인정보 불러오기
	if(islogin()){
		$(".login_alert").addClass("disNone");
		$("#user_id").text("<%=cUserId%>");
	}
	
	ga('send', 'pageview', {'page': vEvent_page,'title': '19 가정의달 프로모션_PV'});
	
	if(tab != ""){
		setTimeout(function() {
	        $(".floattab__list li > a").eq(tab-1).trigger("click");
	    },300);
	}
	
	//응모하기 버튼
	$("#event2_join").click(function(e){
		da_ga(13);
		if(app != 'Y'){
			onoff('app_only');
		}else {
			getEventAjaxData({"procCode": 2}, function(data){
				var result = data.result;
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
			 				html+= "	<a href=\"javascript:;\" onclick=\"window.open('/mobilefirst/detail.jsp?modelno="+modelno+"&freetoken=vip');da_ga(14);\" title=\"새 탭에서 열립니다.\">";
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
		da_ga(12);
		window.open("/mobilefirst/event2019/family_2019.jsp");
		return false;
	});
	
	//로그인시 개인화영역
	if(islogin()){
		$("#user_id").text("<%=cUserId%>");
		getPoint();//개인e머니 내역 노출
	}
	
	$(".sprite.btn_more").click(function(){
		var tabnum = nowTab+1;
		var goods_more = "/mobilefirst/event2019/family_2019.jsp?tab="+tabnum;
		da_ga(11);
		window.open(goods_more); 
	});
	
	$("#snslayer li").click(function(){
		var shareUrl = "http://" + location.host + "/mobilefirst/event2019/family_2019_evt.jsp";
		var shareTitle = "[에누리 가격비교]\n사랑가득 5월 가정의달 이벤트!";
		var idx = $(this).index();
		
		if(idx == 1) {
			 try{ 
				
				Kakao.Link.sendDefault({
				      objectType: 'feed',
				      content: {
				        title: shareTitle,
				        description: "사랑가득 5월 가정의달\n추천선물 구매하면\n애플 에어팟 1세대 추첨증정!\n지금 당장 에누리로~!",
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
});

var proSlide ;

setTimeout(function(){
	proSlide = $('.itemlist').slick({
		dots:true,
		slidesToScroll: 1
	});
},100);

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
	$(".pro_itemlist .tab_content").hide(); 
	$(".pro_itemlist ul.pro_tabs li").removeClass("active"); 
	//첫 로딩 시, 랜덤 노출
    var rndNum = Math.floor(Math.random() * 4);
    var object = ajaxData[rndNum*4+0]["GOODS"].concat(ajaxData[rndNum*4+1]["GOODS"], ajaxData[rndNum*4+2]["GOODS"], ajaxData[rndNum*4+3]["GOODS"]);
	loadGoodsList(object);
	$(".pro_itemlist ul.pro_tabs li").eq(rndNum).addClass("active").show();
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
			var object = ajaxData[0]["GOODS"].concat(ajaxData[1]["GOODS"], ajaxData[2]["GOODS"], ajaxData[3]["GOODS"]);
			loadGoodsList(object);
			da_ga(6);
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			
			nowTab = 1;
		}else if(activeTab == "#protab2"){
			var object = ajaxData[4]["GOODS"].concat(ajaxData[5]["GOODS"], ajaxData[6]["GOODS"], ajaxData[7]["GOODS"]);
			loadGoodsList(object);
			da_ga(7);
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			
			nowTab = 2;
		}else if(activeTab == "#protab3"){
			var object = ajaxData[8]["GOODS"].concat(ajaxData[9]["GOODS"], ajaxData[10]["GOODS"], ajaxData[11]["GOODS"]);
			loadGoodsList(object);
			da_ga(8);
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			
			nowTab = 3;
		}else if(activeTab == "#protab4"){
			var object = ajaxData[12]["GOODS"].concat(ajaxData[13]["GOODS"], ajaxData[14]["GOODS"], ajaxData[15]["GOODS"]);
			loadGoodsList(object);
			da_ga(9);
			proSlide = $('.itemlist').slick({
				dots:true,
				slidesToScroll: 1
			});
			
			nowTab = 4;
		}
		return false;
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
					
					html+= "<li class=\"item\">";
					html+= "	<a href=\"javascript:;\" onclick=\"itemClick("+goodsData["MODELNO"]+","+goodsData["MINPRICE"]+");da_ga(10);\" target=\"_blank\" title=\"새 탭에서 열립니다.\">";
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

var isClick = true;
var sdt = "<%=strToday%>";
function getEventAjaxData(params, callback){
	if(sdt < "20190415"){
		alert('오픈예정입니다.');
		return false;
	}
	if(sdt > "20190519"){
		alert('이벤트가 종료되었습니다.');
		return false;
	}
	
	if(!islogin()){
		alert("로그인 후 이용 가능합니다.");
		goLogin();
		return false;
	}else{
		if(!getSnsCheck()){
			if (confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?") == true){    
				location.href="<%=ConfigManager.ENURI_COM_SSL%>/mobilefirst/member/myAuth.jsp?cmdType=modify&f=p";
			}else{
				return false;
			}
		}
	}
	
	var evtUrl = "/mobilefirst/evt/ajax/family2019_setlist.jsp";
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
	var result = 0;
    //선물뽑기
	var craneGame = {
		timer : null, // timer
	    el : { // elements
	        btnStart : $(".btn_start"), // btn 스타트버튼
	        crane : $(".obj_crane"), // obj-group 크레인
	        craneLine : $(".obj_group_01 .obj_02"), // obj 크레인을 내리는 줄
	        craneTongsL : $(".obj_03"), // obj 좌측 집게
	        craneTongsR : $(".obj_04"), // obj 우측 집게
	        craneGift : $(".obj_gift") // obj 선물						 
	    },
	    init : function(){ // 최초실행
	        this.ready();
	        this.addEvent();
	    },
	    addEvent : function(){ // 스타트 버튼 이벤트
	    var self = this;
	    // 스타트 버튼 이벤트
	    self.el.btnStart.click(function(e){
	    	da_ga(5);
		    e.preventDefault();
		    getEventAjaxData( {"procCode":1} , function(data) {
				result = data.result;
			    if(result >= 5){
					// 게임 진행중일때 재 클릭 금지
					if  ( !$(this).hasClass("game_ing") ){
						self.play();
					}
			    }else if(result == -1){
					alert("이미 참여하셨습니다.\n내일 또 참여해주세요.");
		            working = false;
				}else if(result == -2 || result == -99){
					alert("임직원은 참여 불가합니다.");
		            working = false;
				} else if(result == -55){
					alert("잘못된 접근입니다.");
				}else{
		            working = false;
				}
		    });
	     });
	    },
	    ready : function(){ // 준비 상태 (좌우움직임)
			var self = this;
			var motion = function(){
				self.el.crane.animate({"left":"230px"},3000,function(){
		        	self.el.crane.animate({"left":"50px"},3000);
		        });
			}
			motion();
	   		self.timer = setInterval(motion,6000);
	    },
	    play : function(){ // 크레인 선물 집는 모션
	    	var self = this;
            if ( self.el.crane.hasClass("ready") ){
				self.el.btnStart.addClass("game_ing"); // 재실행 금지용 클래스 추가
				clearInterval(self.timer);
                self.el.crane.removeClass("ready")
                // STEP1 : 가운데로 이동
                self.el.crane.stop(true,false).animate({"left":"143px"},2000,function(){
                    // STEP2 : 움직임 멈추고 하강
                    self.el.craneLine.parent().removeClass("swing");
                    setTimeout(function(){
                        // STEP3 : 집게 벌리고 집기
                        self.el.craneTongsL.addClass("grab");
                        self.el.craneTongsR.addClass("grab");
                    },2000)
                    self.el.craneLine.delay(500).animate({"height":"190px"},3000,function(){
                        // STEP4 : 복귀
                        self.el.craneGift.delay(1000).animate({"height":"171px"},2000);
                        self.el.craneLine.delay(1000).animate({"height":"57px"},2000,function(){
                            // STEP5 : 당첨결과 발표																				
							rewards(result);
		                });
		             })
	             });
	         }                        
	     },
	     reset : function(){ // 초기화
			 // this.ready();
	    	 this.el.crane.addClass("ready").css("left","50px");
             this.el.craneTongsL.removeClass("grab");
             this.el.craneTongsR.removeClass("grab");
             this.el.craneLine.parent().addClass("swing");
             this.el.craneLine.css("height","57px");
             this.el.craneGift.css("height","38px");
	     }
	}
    // 게임 실행
    craneGame.init();

    // 당첨 결과 처리
    function rewards(result){
		// 0 - 낙첨
		// 1 - 당첨 - 5점 적립
		// 2 - 당첨 - 5,100점 적립
		setTimeout(function(){
		// 레이어 띄우기
		var $Layer = $(".crane .layer_area");
			// 결과 레이어 노출
		if ( result == 0 ){ // 낙첨
			$Layer.find(".layer_fail").show()
			$Layer.fadeIn();
		}else if ( result == 5 || result == 5100 ){ // 당첨
			if(result == 5100) $Layer.find(".layer_success").show();
			else if(result == 5) $Layer.find(".layer_fail").show()
			$Layer.fadeIn();
			// 팝업 띄우기
			setTimeout(function(){
				onoff('prizes');
				if ( result == 5100 ) $("#prizes").find(".result_01").show(); // 5,100점
				else if ( result == 5 ) $("#prizes").find(".result_02").show(); // 5점
			},1000);
		}
	    craneGame.reset();
	  },500);
	}    
    
	//기획전상품
	tabLoading()
});

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
