<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
String strFb_title = "[에누리 가격비교] 에누리 표준PC 이벤트";
String strFb_description = "가성비甲 라인업 확인하고, 표준PC 경품 받자!";
String strFb_img = ConfigManager.IMG_ENURI_COM+"/images/event/2021/standardpc/sns_1200_630_1.jpg";

if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{ //pc일때 접속페이지 변경.
	response.sendRedirect("/event2021/standardpc_evt.jsp");
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
	<META NAME="keyword" CONTENT="에누리가격비교, 프로모션, 에누리 표준PC 이벤트">
	<meta property="og:title" content="<%=strFb_title%>">
	<meta property="og:description" content="<%=strFb_description%>">
	<meta property="og:image" content="<%=strFb_img%>">
	<meta name="format-detection" content="telephone=no" />
	<!-- 프로모션 공통 CSS (Mobile) -->
	<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
	<link rel="stylesheet" href="/css/event/y2021/standardpc_m.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/js/swiper.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
	<script type="text/javascript" src="/common/js/function.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.easy-paging.js"></script>
	<script src="/mobilefirst/js/lib/jquery.paging.min.js"></script>
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
<div id="eventWrap" class="event_wrap">

	<div class="myarea">
		<%if(cUserId.equals("")){%>	
			<p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>	
		<%}else{%>
			<p class="name"><%=userArea%> 님<span id="my_emoney">0점</span></p>
		<%}%>
		<a href="javascript:///" class="win_close">창닫기</a>
	</div>
	
	<!-- 비쥬얼 -->
	<div class="toparea">		
		<!-- 공통 : 공유하기 버튼  -->
		<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
		<!-- // -->

		<!-- 공통 : 상단 비쥬얼 -->
		<div class="visual">
			<div class="inner">
				<span class="txt_stit">2월 한정 특별 이벤트</span>
                <h1>에누리 표준PC 오픈 기념 AMP 조립 PC 증정</h1>
                <span class="txt_date">2021. 2. 3 ~ 2. 28</span>
                
                <div class="obj_box"><!-- 컴퓨터 --></div>
				
				<div class="loader-box">
					<div class="visual-loader"></div>
				</div>
			</div>
			
			<script>
				// 상단 타이틀 등장 모션
				$(window).load(function(){
					var $visual = $(".event_wrap .visual");
					$visual.addClass("intro");
					setTimeout(function(){
						$visual.addClass("end");
					},100)
				})
			</script>
		</div>
		<!-- // -->	
	</div>
	<!-- //비쥬얼 -->

    <!-- CONT1 -->
	<div class="section cont01" id="evt1">        
        <div class="cont__head">
		    <div class="contents">    
                <h2 class="cont__tit">2월 에누리 표준PC 라인업 소개</h2>

                <div class="cont__info">
                    <dl>
                        <dt>에누리 표준PC 란?</dt>
                        <dd>에누리에서 제시하는 합리적인 가격과 엄선된 부품으로 구성된 최고의 만족감을 주는 조립 PC입니다. 전문가의 꼼꼼한 조립 검수와 100% 사전 테스트를 통해 뛰어난 안정성을 보장합니다.</dd>
                    </dl>
                </div>
            </div>
        </div>
          
        <div class="cont__body">
		    <div class="contents">   
                <div class="tabs" id="prodTab">
                    <ul class="tabs_list">
                        <li class="is-on"><button type="button" class="btn">전체 상품</button></li>
                        <li><button type="button" class="btn">인텔</button></li>
                        <li><button type="button" class="btn">AMD</button></li>
                    </ul>
                </div>

                <div class="tabs_container">
                    <!-- 전체 상품 -->
                    <div class="tabs_cont is-shown">
                        <div class="swiper-container prod__swipe">
                            <div class="swiper-wrapper">
                                <ul class="swiper-slide prod__list">
                                    <li><a href="http://m.enuri.com/m/vip.jsp?modelno=60327565"><img src="http://img.enuri.info/images/event/2021/standardpc/m_prod_intel01.png" alt="인텔 - 에누리표준PC 홈&amp;오피스용 IY-121" /></a></li>
                                    <li><a href="http://m.enuri.com/m/vip.jsp?modelno=60327567"><img src="http://img.enuri.info/images/event/2021/standardpc/m_prod_intel02.png" alt="인텔 - 에누리표준PC 홈&amp;멀티미디어용 IY-221" /></a></li>
                                    <li><a href="http://m.enuri.com/m/vip.jsp?modelno=60327569"><img src="http://img.enuri.info/images/event/2021/standardpc/m_prod_intel03.png" alt="인텔 - 에누리표준PC 홈&amp;게이밍용 IY-321" /></a></li>
                                    <li><a href="http://m.enuri.com/m/vip.jsp?modelno=60327570"><img src="http://img.enuri.info/images/event/2021/standardpc/m_prod_intel04.png" alt="인텔 - 에누리표준PC 홈&amp;하이엔드용IY-421" /></a></li>
                                </ul>

                                <ul class="swiper-slide prod__list">
                                    <li><a href="http://m.enuri.com/m/vip.jsp?modelno=61576475"><img src="http://img.enuri.info/images/event/2021/standardpc/m_prod_amd01.png" alt="AMD - 에누리표준PC 홈&amp;멀티미디어용 AD-121" /></a></li>
                                    <li><a href="http://m.enuri.com/m/vip.jsp?modelno=60327571"><img src="http://img.enuri.info/images/event/2021/standardpc/m_prod_amd02.png" alt="AMD - 에누리표준PC 홈&amp;멀티미디어용 AD-221" /></a></li>
                                    <li><a href="http://m.enuri.com/m/vip.jsp?modelno=60327572"><img src="http://img.enuri.info/images/event/2021/standardpc/m_prod_amd03.png" alt="AMD - 에누리표준PC 홈&amp;게이밍용 AD-222" /></a></li>
                                    <li><a href="http://m.enuri.com/m/vip.jsp?modelno=60327574"><img src="http://img.enuri.info/images/event/2021/standardpc/m_prod_amd04.png" alt="AMD - 에누리표준PC 홈&amp;하이엔드용 AD-421" /></a></li>
                                </ul>
                            </div>
                            <div class="swiper-button-prev btn_prev"></div>
                            <div class="swiper-button-next btn_next"></div>

                            <!-- pagination -->
                            <div class="swiper-pagination"></div>
                        </div>
                    </div>
                    <!-- // -->

                    <!-- 인텔 상품 -->
                    <div class="tabs_cont">
                        <ul class="prod__list">
                            <li><a href="http://m.enuri.com/m/vip.jsp?modelno=60327565"><img src="http://img.enuri.info/images/event/2021/standardpc/m_prod_intel01.png" alt="인텔 - 에누리표준PC 홈&amp;오피스용 IY-121" /></a></li>
                            <li><a href="http://m.enuri.com/m/vip.jsp?modelno=60327567"><img src="http://img.enuri.info/images/event/2021/standardpc/m_prod_intel02.png" alt="인텔 - 에누리표준PC 홈&amp;멀티미디어용 IY-221" /></a></li>
                            <li><a href="http://m.enuri.com/m/vip.jsp?modelno=60327569"><img src="http://img.enuri.info/images/event/2021/standardpc/m_prod_intel03.png" alt="인텔 - 에누리표준PC 홈&amp;게이밍용 IY-321" /></a></li>
                            <li><a href="http://m.enuri.com/m/vip.jsp?modelno=60327570"><img src="http://img.enuri.info/images/event/2021/standardpc/m_prod_intel04.png" alt="인텔 - 에누리표준PC 홈&amp;하이엔드용IY-421" /></a></li>
                        </ul>
                    </div>
                    <!-- // -->

                    <!-- AMD 상품 -->
                    <div class="tabs_cont">
                        <ul class="prod__list">
                            <li><a href="http://m.enuri.com/m/vip.jsp?modelno=61576475"><img src="http://img.enuri.info/images/event/2021/standardpc/m_prod_amd01.png" alt="AMD - 에누리표준PC 홈&amp;멀티미디어용 AD-121" /></a></li>
                            <li><a href="http://m.enuri.com/m/vip.jsp?modelno=60327571"><img src="http://img.enuri.info/images/event/2021/standardpc/m_prod_amd02.png" alt="AMD - 에누리표준PC 홈&amp;멀티미디어용 AD-221" /></a></li>
                            <li><a href="http://m.enuri.com/m/vip.jsp?modelno=60327572"><img src="http://img.enuri.info/images/event/2021/standardpc/m_prod_amd03.png" alt="AMD - 에누리표준PC 홈&amp;게이밍용 AD-222" /></a></li>
                            <li><a href="http://m.enuri.com/m/vip.jsp?modelno=60327574"><img src="http://img.enuri.info/images/event/2021/standardpc/m_prod_amd04.png" alt="AMD - 에누리표준PC 홈&amp;하이엔드용 AD-421" /></a></li>
                        </ul>
                    </div>
                    <!-- // -->

                    <p class="prod__noti">※ 상품 가격은 업체 사정에 따라 변경될 수 있습니다.</p>

                    <script type="text/javascript">
                        $(function(){
                            var prodinfoSwipe = new Swiper('.prod__swipe', {
                                scrollbarHide: false,
                                centeredSlides: false,
                                spaceBetween: 30,
                                initialSlide: 0,
                                grabCursor: true,
                                prevButton : '.prod__swipe .swiper-button-prev',
							    nextButton : '.prod__swipe .swiper-button-next',
                                pagination: ".prod__swipe .swiper-pagination"
                            });
                            
                            // 대메뉴 클릭이벤트
                            $(".tabs_list li").click(function(e) {
                                if ( !$(this).hasClass("is-on") ){
                                    $(".tabs_list li").removeClass("is-on"); 
                                    $(this).addClass("is-on");
                                    
                                    var _idx = $(this).index(); // 탭 인덱스
                                    $(".tabs_container .tabs_cont").hide().eq(_idx).show();
                                }
                                return false;
                            });
                        })
                    </script>
                </div>
            </div>
		</div>
	</div>
    <!-- //CONT1 -->
    
    <!-- CONT2 -->
	<div class="section cont02">
		<div class="contents">
            <h2 class="cont__tit">01.구매이벤트 - 2월 에누리 표준PC를 구매해 주신 10분에게 추첨을 통해 갤럭시 게이밍 마우스를 드립니다! (앱전용)</h2>
            
			<div class="gift_box">
                <a href="http://m.enuri.com/m/vip.jsp?modelno=31214621" class="btn_gift" title="갤럭시 XANOVA MENSA">갤럭시 XANOVA MENSA - 10명 추첨</a>

                <a href="javascript:///" class="btn btn_link" onclick="$('html, body').stop().animate({scrollTop: $('#prodTab').offset().top}, 500);">2월 상품보기</a>
                <a href="javascript:///" class="btn btn_join">이벤트 신청하기</a>
            </div>

        </div>

        <div class="cont__noti">
            <div class="contents">
                <ul class="gift_noti">
                    <li>이벤트 기간: 2021. 2. 3 ~ 2. 28</li>
                    <li>당첨자 발표: 2021. 3. 30</li>
                    <li>경품 : 갤럭시 XANOVA MENSA <a href="http://m.enuri.com/m/vip.jsp?modelno=31214621" class="btn__link">경품 보러가기</a></li>
                </ul>
            </div>

            <!-- 공통 : 꼭 확인하세요  -->
            <div class="com__evt_notice">
                <div class="evt_notice--btn_area"><button class="btn__evt_notice btn__white" data-laypop-id="slidePop1"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 레이어 열기 -->
            </div>
            <div id="slidePop1" class="evt_notice--slide">
                <div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
                    <div class="evt_notice--head">유의사항</div>
                    <div class="evt_notice--cont">
                        <div class="evt_notice--continner">
                            <dl>								
                                <dt>이벤트 대상 및 혜택</dt>
                                <dd>
                                    <ul>
                                        <li>이벤트 내용 : 이벤트 신청한 고객 중 에누리 앱에서 2월 선정 에누리 표준PC 구매 고객</li>
                                        <li>이벤트 기간 : 2021년 2월 3일 ~ 2021년 2월 28일</li>
                                        <li>이벤트 혜택 : 갤럭시 XANOVA MENSA – 10명 추첨 <span class="noti stress">※제세공과금 발생 시 당첨자 부담</span></li>
                                        <li>당첨자 발표 : 2021년 3월 30일 화요일</li>
                                    </ul>
                                </dd>
                            </dl>
                            <dl>	
                                <dt>이벤트 유의사항</dt>
                                <dd>
                                    <ul>
                                        <li>사정에 따라 경품이 변경될 수 있습니다.</li>
                                        <li>이벤트 참여 시 개인정보 수집에 동의하신 것으로 간주됩니다.</li>
                                        <li>이벤트의 원활한 진행을 위해 당첨자의 참여일시, 참여자ID, 본인인증확인(CI, DI)가 수집되며 수집된 개인정보는 이벤트 참여확인을 위한 본인확인 이외의 목적으로 활용되지 않습니다.</li>
                                        <li>개인정보 수집자(에누리 가격비교)는 이벤트 기간 동안 개인정보를 수집하며, 이벤트 당첨자 발표 후 개인정보를 즉시 파기합니다.</li>
                                        <li>잘못된 정보 입력이나, 3회 이상 통화 시도에도 연락이 되지 않을 경우의 경품수령 불이익은 책임지지 않습니다.</li>
                                        <li>부정 참여 시 적립 취소 및 사이트 사용이 제한될 수 있습니다.</li>
                                        <li>본 이벤트는 당사 사정에 따라 사전 고지 없이 변경 또는 종료 될 수 있습니다.</li>                                            
                                    </ul>
                                </dd>
                            </dl>
                            <dl>                                		
                                <dt>구매 적립 기준 및 유의사항</dt>
                                <dd>
                                    <ul>
                                        <li>적립방법 : 에누리 가격비교 모바일 앱 로그인 → 적립대상 쇼핑몰 이동 &rarr; <span class="stress">1천원 이상 구매</span> &rarr; 구매확정(배송완료) 시 e머니 적립</li>
                                        <li>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, Cjmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 에누리 해외직구관, SK스토아, 홈플러스<br>
                                            <span class="noti">※ 티몬 및 에누리 해외직구관의 경우 PC 및 모바일 앱/웹에서 로그인 후 구매시에도 구매적립 가능합니다.</span>
                                        </li>
                                        <li>구매적립 e머니는 구매일로부터 10 ~ 30일간 취소/환불/교환/반품여부 확인 후 적립 됩니다.</li>
                                        <li class="stress">구매적립 e머니 유효기간 : 적립일로부터 60일 (유효기간 만료 후 재적립 불가)<br>
                                            <span class="noti gray">※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</span>
                                        </li>
                                        <li>구매적립 e머니는 최소 10점(구매금액 1천원 이상)부터 적립되며, 1원 단위 e머니는 적립되지 않습니다.</li>
                                        <li>구매적립 e머니는 구매확정(구매일로부터 최 대 30일) 시점부터 MY 에누리 적립내역 페이지에서 확인 가능합니다.</li>
                                        <li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다.</li>
                                        <li>적립대상 쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제하는 경우 구매건수는 1건이며 구매금액은 통합된 금액으로 e머니 적립 됩니다.</li>
                                        <li>구매적립 e머니는 카테고리별 차등 적립됩니다.
                                            <dl>
                                                <dt>※ 카테고리별 적립률 상세</dt>
                                                <dd>
                                                    <table class="evt_noti_tb" style="width:100%">
                                                        <tbody>
                                                            <tr>
                                                                <th>카테고리</th>
                                                                <th>적립률</th>
                                                            </tr>
                                                            <tr>
                                                                <td>유아,완구</td>
                                                                <td>1.5%</td>
                                                            </tr>
                                                            <tr>
                                                                <td>식품/스포츠,레저/자동차/화장품</td>
                                                                <td>1.0%</td>
                                                            </tr>
                                                            <tr>
                                                                <td>컴퓨터/도서/문구,사무/PC부품</td>
                                                                <td>0.8%</td>
                                                            </tr>
                                                            <tr>
                                                                <td>디지털/영상,디카</td>
                                                                <td rowspan="4">0.3%</td>
                                                            </tr>
                                                            <tr>
                                                                <td>가전(생활,주방,계절)</td>
                                                            </tr>
                                                            <tr>
                                                                <td>패션/잡화</td>
                                                            </tr>
                                                            <tr>
                                                                <td>가구,인테리어/생활,취미</td>
                                                            </tr>
                                                            <tr>
                                                                <td>모바일쿠폰,상품권<br/>
                                                                    <p class="stress">*특정 상품에 한하여 적립되오니<br/>적립가능 상품은 하단에서 확인해주세요.</p>
                                                                </td>	
                                                                <td>0.2%</td>												
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </dd>
                                            </dl>
                                        </li>
                                        <li>[모바일쿠폰,상품권] 구매적립 기준</li>
                                        <li>적립가능 쇼핑몰 : G마켓, 옥션, 인터파크</li>
                                        <li>적립가능 상품 (0.2% 적립) : 문화상품권(해피머니, 컬쳐랜드), 도서상품권, 백화점상품권, 영화예매권, 국민관광 상품권</li>
                                        <li>백화점상품권 기준 상세
                                            <ul class="sub">
                                                <li>1) 상품명에 '백화점 상품권' 명시된 상품 또는 백화점에서만 사용할 수 있는 상품권만 적립가능</li>
                                                <li>2) 복합상품권 적립불가 (삼성 상품권, 신세계 기프트카드, 롯데카드 상품권, 이랜드 상품권, AK플라자 상품권, 통합 상품권 등)- 복합 상품권의 경우 사용처에 백화점이 기재되어 있는 경우에도 적립불가</li>
                                                <li>3) 백화점 상품권으로 전환 가능한 포인트 구매 시 적립불가</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </dd>
                            </dl>
                            <dl>	
                                <dt>적립대상 쇼핑몰 중 구매적립 제외 카테고리 및 서비스</dt>
                                <dd>
                                    <ul>
                                        <li>에누리 가격비교에서 검색되지 않는 상품</li>
                                        <li>모바일쿠폰,상품권 : 상품권, 지역쿠폰, e교환권, e쿠폰 등</li>
                                        <li>쇼핑몰 제휴 서비스(배달, 티켓, 해외직구 등) 및 일부 카테고리
                                            <ul class="sub">
                                                <li>- G마켓 : 중고장터, 실시간 여행, 항공권, 도서/음반, 모바일쿠폰/상품권(일부 적립가능)</li>
                                                <li>- 옥션 : 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권(일부 적립가능)</li>
                                                <li>- 11번가 : 여행/숙박/항공, 모바일쿠폰/상품권</li>
                                                <li>- 인터파크 : 라이프 서비스(티켓, 투어, 아이마켓 등), 모바일쿠폰/상품권(100원딜 상품만 적립가능)</li>
                                                <li>- 티몬 : 특가 판매 상품(슈퍼꿀딜, 슈퍼마트 등), 모바일쿠폰/상품권(일부 적립가능)</li>
                                                <li>- 위메프 : 모바일쿠폰/상품권</li>
                                                <li>- GS SHOP, CJmall : 모바일쿠폰/상품권</li>
                                                <li>- SSG : 도서/음반/문구/취미/여행, 모바일쿠폰/상품권</li>
                                            </ul>
                                        </li>                                            
                                    </ul>
                                </dd>
                            </dl>
                            <dl>	
                                <dt>공통 이벤트 유의사항</dt>
                                <dd>
                                    <ul>
                                        <li>아래의 경우에는 구매 확인 및 구매적립이 불가합니다.
                                            <ul class="sub">
                                                <li>- 에누리 가격비교 모바일 앱이 아닌 다른 모바일 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 모바일 앱으로 결제만 한 경우</li>
                                                <li>- 에누리 가격비교 미 로그인 후 구매한 경우</li>
                                                <li>- 에누리 가격비교 PC 및 모바일 웹에서 구매한 경우 (※ 티몬 및 에누리 해외직구관은 PC 및 모바일 앱/웹 구매 시에도 가능)</li>
                                            </ul>
                                        </li>                                            
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
    </div>
    <!-- //CONT2 -->

    <!-- CONT3 -->
	<div class="section cont03">
		<div class="contents">
            <h2 class="cont__tit">02.공유이벤트 - 친구에게 에누리 표준PC 오픈 소식 공유하면 추첨을 통해 AMD 표준PC를 드립니다!</h2>
            <p class="blind">많이 공유할수록 당첨 확률 UP!</p>
            
			<div class="gift_box">
                <a href="http://m.enuri.com/m/vip.jsp?modelno=60327571" class="btn_gift" title="에누리표준PC 멀티미디어용 AD-221">에누리표준PC 멀티미디어용 AD-221 - 1명 추첨</a>

                <ul class="sns__list">
                    <li id="kakao-link-btn"><a href="javascript:Share_detail('kakao');" class="btn">카카오톡 공유하기</a></li>
                    <li><a href="javascript:Share_detail('face');" class="btn">페이스북 공유하기</a></li>
                    <li><a href="javascript:///" data-clipboard-text="http://m.enuri.com/mobilefirst/event2021/standardpc_evt.jsp?oc=sns" class="btn btn_co">URL 복사</a></li>
                </ul>
            </div>
			<script>
				$(function(){
					var clipboard = new ClipboardJS('.sns__list .btn_co');
					clipboard.on('success', function(e) {
						if(islogin()){
							alert('주소가 복사되었습니다');
							sharePaticipant('url');
						}else{
							alert("로그인 후 이용 가능합니다.");
							goLogin();
							return false;
						}
					});
					clipboard.on('error', function(e) {
						console.log(e);
					});
				});
			</script>
        </div>

        <div class="cont__noti">
            <div class="contents">
                <ul class="gift_noti">
                    <li>이벤트 기간: 2021. 2. 3 ~ 2. 28</li>
                    <li>당첨자 발표: 2021. 3. 30</li>
                    <li>경품 : 에누리표준PC 멀티미디어용 AD-221 <a href="http://m.enuri.com/m/vip.jsp?modelno=60327571" class="btn__link">경품 보러가기</a></li>
                </ul>                
            </div>

            <!-- 공통 : 꼭 확인하세요  -->
            <div class="com__evt_notice">
                <div class="evt_notice--btn_area"><button class="btn__evt_notice btn__white" data-laypop-id="slidePop2"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 레이어 열기 -->
            </div>
            <div id="slidePop2" class="evt_notice--slide">
                <div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
                    <div class="evt_notice--head">유의사항</div>
                    <div class="evt_notice--cont">
                        <div class="evt_notice--continner">
                            <dl>								
                                <dt>이벤트 대상 및 혜택</dt>
                                <dd>
                                    <ul>
                                        <li>이벤트 내용 : 본 이벤트를 SNS(카카오톡, 페이스북, URL복사)를 통해 공유한 고객</li>
                                        <li>이벤트 기간 : 2021년 2월 3일 ~ 2021년 2월 28일</li>
                                        <li>이벤트 혜택 : 에누리표준PC 멀티미디어용 AD-221 – 1명 추첨 <span class="noti stress">※제세공과금 발생 시 당첨자 부담</span></li>
                                        <li>당첨자 발표 : 2021년 3월 30일 화요일</li>
                                    </ul>
                                </dd>
                            </dl>
                            <dl>	
                                <dt>이벤트 유의사항</dt>
                                <dd>
                                    <ul>
                                        <li>SNS 공유는 횟수 제한없이 참여 가능합니다.</li> 
                                        <li>경품은 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격변동이 있을 수 있습니다.</li> 
                                        <li>이벤트 참여 시 개인정보 수집에 동의하신 것으로 간주됩니다.</li> 
                                        <li>이벤트의 원활한 진행을 위해 당첨자의 참여일시, 참여자ID, 본인인증확인(CI, DI)가 수집되며 수집된 개인정보는 이벤트 참여확인을 위한 본인확인 이외의 목적으로 활용되지 않습니다.</li> 
                                        <li>개인정보 수집자(에누리 가격비교)는 이벤트 기간 동안 개인정보를 수집하며, 이벤트 당첨자 발표 후 개인정보를 즉시 파기합니다.</li> 
                                        <li>잘못된 정보 입력이나, 3회 이상 통화 시도에도 연락이 되지 않을 경우의 경품 수령 불이익은 책임지지 않습니다.</li> 
                                        <li>부정 참여 시 적립 취소 및 사이트 사용이 제한될 수 있습니다.</li> 
                                        <li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료 될 수 있습니다.</li>                                            
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
    </div>
    <!-- //CONT3 -->
	
	<!-- //Contents -->	

	<span class="go_top"><a href="#">TOP</a></span>
</div>

<!-- (신규) 공통 : SNS공유하기 -->
<div class="com__share_wrap dim" style="z-index:10000;display:none">
	<div class="com__layer share_layer">
		<div class="lay_head">공유하기</div>
		<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
		<div class="lay_inner">
			<ul id="eventShr">
				<li id="fbShare" class="share_fb">페이스북 공유하기</li>
				<li class="share_kakao" id="kakao-share-btn" >카카오톡 공유하기</li>				
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
						<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2020/kingofbuy_evt.jsp?oc=mo</span>
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


<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20180831"></script>
<script type="text/javascript">
Kakao.init('5cad223fb57213402d8f90de1aa27301');

var app = getCookie("appYN"); //app인지 여부
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로
var vEvent_title = "에누리 표준PC 이벤트";
var isFlow = "<%=flow%>" == "ad";
var vOs_type = getOsType();
var state = false;
var tab = "<%=tab%>";

$(".go_top").click(function(){		$('body, html').animate({scrollTop:0}, 500);	});

var shareUrl = "http://" + location.host + "/mobilefirst/event2021/standardpc_evt.jsp?oc=mo";
var shareTitle = "<%=strFb_title%> <%=strFb_description%>";

var oc = '<%=oc%>';

//공통 : 유의사항 레이어 열기/닫기
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

$(document).ready(function() {
	ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_PV");
	
	if(oc!=""){
		$('.lay_only_mw').show();
	}
	$("#my_emoney").click(function(){	
		window.location.href = "https://m.enuri.com/my/my_emoney_m.jsp?freetoken=emoney";	//e머니 적립내역
	});
	
	shareSns('kakao');
	Share_detail_kakao();
	
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
	
	$(".btn_join").click(function(){
		da_ga(3);
		if(app=="Y"){
			btn_join();
		}else{
			$('.lay_only_mw').show();
			return false;			
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

function numberWithCommas(x) {   return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");		}

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
	var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2020%2Fkingofbuy_evt.jsp%3Ffreetoken%3Devent";
	
	if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
		goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2020/kingofbuy_evt.jsp?freetoken=event";
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

function btn_join() {
	
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
				url: "/mobilefirst/evt/ajax/standardpc_setlist.jsp?proc=1&osType="+getOsType(),
				dataType: "JSON",
				async : false,
				success: function(json){
					
					if(json.result == 1){
						alert("정상 참여 되었습니다.");
					}else if(json.result == 2601){
						alert("이미 참여 하셨습니다.");
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
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_이벤트_제품리뷰보기");
	}else if(num == 3){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_이벤트_응모하기");
	}else if(num == 4){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_쇼핑가이드_노트북");
	}else if(num == 5){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_쇼핑가이드_데스크탑");
	}else if(num == 6){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_쇼핑가이드_CPU");
	}else if(num == 7){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_쇼핑가이드_그래픽카드");
	}else if(num == 8){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_쇼핑가이드_모니터");
	}else if(num == 9){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_쇼핑가이드_상품");
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

function Share_detail(param){
	var share_url = "http://m.enuri.com/mobilefirst/event2021/standardpc_evt.jsp?oc=sns";
	var share_title = "[에누리 표준PC 이벤트]가성비甲 라인업 확인하고, 표준PC 경품 받자!";
	var imgSNS = "<%=strFb_img%>";

	if(!islogin()){
		alert("로그인 후 이용 가능합니다.");
		goLogin();
		return false;
	}else{
		// sns 공유하기 함수 호출
		if(param == "face"){
			try{
				window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
				//ga("send", "event", "mf_event", vEvent_title +"_APP", "공유하기_페이스북");
			}catch(e){
				window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
				//ga("send", "event", "mf_event", vEvent_title +"_WEB", "공유하기_페이스북");
			}
		}else if(param == "kakao"){
			Share_detail_kakao();
		}

		// 공유하기 이벤트 참여자 insert
		sharePaticipant(param);

	}
}

function Share_detail_kakao(){
	var share_url = "http://" + location.host + "/mobilefirst/event2021/standardpc_evt.jsp";
	var share_title = "[에누리 표준PC 이벤트]가성비甲 라인업 확인하고, 표준PC 경품 받자!";
	var imgSNS = "<%=strFb_img%>";
	try{
		Kakao.Link.createDefaultButton({
			container: '#kakao-link-btn',
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
}

//공유하기 이벤트 참여자
function sharePaticipant(Type){
	var shareType = 0;
	var osType = "";

	if(Type == "face"){
		shareType = 1;
	}else if(Type == "kakao"){
		shareType = 2;
	}else if(Type == "url"){
		shareType = 3;
	}

	if(app =='Y'){
        osType = "MA";
    }else {
    	osType = "MW";
    }

	$.ajax({
		  url : "/mobilefirst/evt/ajax/standardpc_setlist.jsp"
		, data : {	proc  : 2,
					shareType : shareType,
					osType    : osType	 }
		, dataType : "json"
		, success : function(result){
			if(!result){
				alert('공유하기 이벤트 참여 실패하였습니다.');
			}
		}

	});

}

//sns 공유하기 함수
function shareSns(param){
	var share_url = "http://" + location.host + "/mobilefirst/event2021/standardpc_evt.jsp";
	var share_title = "[에누리 가격비교] 에누리 표준PC 이벤트";
	var share_description = "가성비甲 라인업 확인하고, 표준PC 경품 받자!";
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
		var share_title_twi = "[에누리 가격비교] 추운 겨울, 마음을 녹이는 혜택을 누리다! 매주 수요일 타임특가도 만나보세요! ";
		window.open("https://twitter.com/intent/tweet?text="+share_title_twi+"&url="+share_url);
	}
}
</script>

</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
