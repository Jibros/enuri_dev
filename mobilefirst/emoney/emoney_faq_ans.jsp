<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
Cookie[] carr = request.getCookies();
String strAppyn = "";
String strVerios = "";
String strAd_id = "";
int intVerios = 0;
int intQno = ChkNull.chkInt(request.getParameter("qno"),0);

try {
      for(int i=0;i<carr.length;i++){
          if(carr[i].getName().equals("appYN")){
           strAppyn = carr[i].getValue();
           break;
          }
      }
      for(int i=0;i<carr.length;i++){
          if(carr[i].getName().equals("verios")){
           strVerios = carr[i].getValue();
           break;
          }
      }
      for(int i=0;i<carr.length;i++){
          if(carr[i].getName().equals("adid")){
           strAd_id = carr[i].getValue();
           break;
          }
      }
} catch(Exception e) {
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8"/>
	<meta http-equiv="x-ua-compatible" content="ie=edge"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
	<meta name="format-detection" content="telephone=no"/>
	<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
	<link rel="stylesheet" type="text/css" href="/css/mobile_v2/common.css"/>
    <link rel="stylesheet" type="text/css" href="/css/mobile_v2/cs.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/js/swiper.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/utils.js"></script>
	<script>
     (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
           (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
          m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
          })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
           //런칭할때 UA-52658695-3 으로 변경
           ga('create', 'UA-52658695-3', 'auto');
     </script>
</head>
<body>
<div id="wrap">
	<%if(!strAppyn.equals("Y")) {%>
		<header id="header" class="page_header nomargin">
			<div class="header_top">
				<div class="wrap">
					<button class="btn__sr_back comm__sprite2"><i class="icon_arrow_back comm__sprite2">뒤로</i></button>
					<div class="header_top_page_name">자주 묻는 질문</div>
				</div>
			</div>
		</header>
    <%} %>

	<section id="container" class="m_faq_cont">
		<div class="my__cont_sub my__cs_cnt">
            <div class="cs_tab_cnt">
            	<div id="tab_faq" class="tab_cs tab_cs_faq">
            		<ul>
            			<li class="selected">
            				<dl>
				                <dt class="txt_q" id="q1" style="display:none;">
				                	<span class="txt_inner">
				                		에누리 가격비교 앱 e머니는 어떤 서비스 인가요?
				                	</span>
			                	</dt>
				                <dd id="a1" class="txt_a" style="display:none;">
				                	<span class="txt_inner">
						                <span class="mall">
						                	에누리 가격비교 앱(APP)을 이용하여,<br>상품구매 및 이벤트 참여 시 적립 받는 혜택입니다.
					                	</span><br>
						                <span class="mall">
						                	적립된 e머니는 My계정 내 쿠폰스토어에서 <br>e쿠폰으로 교환 가능합니다.
					                	</span><br>
				                	</span>
				                </dd>
				                <dt class="txt_q" id="q2" style="display:none;">
				                	<span class="txt_inner">
				                		e머니 적립은 어떻게 받을 수 있나요?
				                	</span>
			                	</dt>
				                <dd id="a2" class="txt_a" style="display:none;">
				                	<span class="txt_inner">
						                <span style="font-weight:bold;">▶ e머니 적립 방법</span><br>
						                <ul class="indent">
											<li>- 에누리 앱을 통해 적립대상 쇼핑몰에서 구매를 통한 적립</li>
											<li>&nbsp;※ 티몬 및 에누리 해외직구관의 경우 PC 및 모바일 앱/웹에서 로그인 후 구매시에도 구매적립 가능합니다.</li>
											<li>- 에누리 이벤트 참여를 통한 적립</li>
										</ul>
										<br>
						                <span style="font-weight:bold;">▶ 구매적립 기준 및 유의사항</span>
										<ul class="indent">
											<li>- 적립방법 : 에누리 가격비교 모바일 앱 로그인 → 적립대상 쇼핑몰 이동 → 1천원 이상 구매 → 구매확정(배송완료) 시 e머니 적립</li>
											<li>- 적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 에누리 해외직구관, SK스토아, 홈플러스</li>
											<li>&nbsp;※ 티몬 및 에누리 해외직구관의 경우 PC 및 모바일 앱/웹에서 로그인 후 구매시에도 구매적립 가능합니다.</li>
											<li>- 구매적립 e머니는 구매일로부터 10 ~ 30일간 취소/환불/교환/반품여부 확인 후 적립 됩니다.</li>
											<li>- 구매적립 e머니 유효기간 : 적립일로부터 60일 (유효기간 만료 후 재적립 불가)</li>
											<li>&nbsp;※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</li>
											<li>- 구매적립 e머니는 최소 10점(구매금액 1천원 이상)부터 적립되며, 1원 단위 e머니는 적립되지 않습니다.</li>
											<li>- 구매적립 e머니는 구매확정(구매일로부터 최대 30일) 시점부터 MY 에누리 적립내역 페이지에서 확인 가능합니다.</li>
											<li>- 구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다.</li>
											<li>- 적립대상 쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제하는 경우 구매건수는 1건이며 구매금액은 통합된 금액으로 e머니 적립 됩니다.</li>
										</ul>
										<br>
						                <span style="font-weight:bold;">▶ 구매적립 제외 카테고리/서비스</span><br>
										<ul class="indent">
											<li>- 에누리 가격비교에서 검색되지 않는 상품</li>
											<li>- 모바일쿠폰,상품권 : 상품권, 지역쿠폰, e교환권, e쿠폰 등</li>
											<li>- 쇼핑몰 제휴 서비스(배달, 티켓, 해외직구 등) 및 일부 카테고리</li>
											<li>&nbsp;ㄴ G마켓 : 중고장터, 실시간 여행, 항공권, 도서/음반, 모바일쿠폰/상품권(일부 적립가능)</li>
											<li>&nbsp;ㄴ 옥션 : 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권(일부 적립가능)</li>
											<li>&nbsp;ㄴ 11번가 : 여행/숙박/항공, 모바일쿠폰/상품권</li>
											<%if (DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2020.11.01. 00:00")<0 ) {%>
											<li>&nbsp;ㄴ 인터파크 : 라이프 서비스(티켓, 투어, 아이마켓 등), 모바일쿠폰/상품권</li>
											<li>&nbsp;ㄴ 티몬 : 특가 판매 상품(슈퍼꿀딜, 슈퍼마트 등), 모바일쿠폰/상품권(일부 적립가능 <b>※2020년 11월 1일부터 적립불가</b>)</li>
											<%} else{%>ㅣ
											<li>&nbsp;ㄴ 인터파크 : 라이프 서비스(티켓, 투어, 아이마켓 등), 모바일쿠폰/상품권(일부 적립가능)</li>
											<li>&nbsp;ㄴ 티몬 : 특가 판매 상품(슈퍼꿀딜, 슈퍼마트 등), 모바일쿠폰/상품권</li>
											<%}%>
											<li>&nbsp;ㄴ 위메프 : 모바일쿠폰/상품권</li>
											<li>&nbsp;ㄴ GS SHOP, CJmall : 모바일쿠폰/상품권</li>
											<li>&nbsp;ㄴ SSG : 도서/음반/문구/취미/여행, 모바일쿠폰/상품권</li>
										</ul>
										<br>
						                <span style="font-weight:bold;">▶ [모바일쿠폰,상품권] 구매적립 기준</span><br>
										<ul class="indent">
											<%if (DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2020.11.01. 00:00")<0 ) {%>
											<li>- 적립가능 쇼핑몰 : 티몬, G마켓, 옥션</li>
											<li><b>&nbsp;※ 2020년 11월 1일부터 티몬 상품권 e머니 구매적립이 종료될 예정입니다.</b></li>
											<%} else {%>
											<li>- 적립가능 쇼핑몰 : G마켓, 옥션, 인터파크</li>
											<%}%>
											<li>- 적립가능 상품 (0.2% 적립) : 문화상품권(해피머니, 컬쳐랜드), 도서상품권, 백화점상품권, 영화예매권, 국민관광 상품권</li>
											<li>- 백화점상품권 기준 상세</li>
											<li>&nbsp;1) 상품명에 '백화점 상품권' 명시된 상품 또는 백화점에서만 사용할 수 있는 상품권만 적립가능</li>
											<li>&nbsp;2) 복합상품권 적립불가 (삼성 상품권, 신세계 기프트카드, 롯데카드 상품권, 이랜드 상품권, AK플라자 상품권, 통합 상품권 등)</li>
											<li>&nbsp;&nbsp;- 복합 상품권의 경우 사용처에 백화점이 기재되어 있는 경우에도 적립불가</li>
											<li>&nbsp;3) 백화점 상품권으로 전환 가능한 포인트 구매 시 적립불가</li>
										</ul>
										<br>
										<span style="font-weight:bold;">▶ 구매확인/구매적립 불가한 경우</span><br>
										<ul class="indent">
											<li>아래의 경우에는 구매 확인 및 구매적립이 불가합니다.</li>
											<li>&nbsp;- 에누리 가격비교 모바일 앱이 아닌 다른 모바일 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 모바일 앱으로 결제만 한 경우</li>
											<li>&nbsp;- 에누리 가격비교 미 로그인 후 구매한 경우</li>
											<li>&nbsp;- 에누리 가격비교 PC 및 모바일 웹에서 구매한 경우 (※ 티몬 및 에누리 해외직구관은 PC 및 모바일 앱/웹 구매 시에도 가능)</li>
										</ul>
										<br>
										<span style="font-weight:bold;">※ e머니가 적립되지 않을 경우 고객센터로 문의주세요.</span>
					                </span>
				                </dd>
				                <dt class="txt_q" id="q3" style="display:none;">
				                	<span class="txt_inner">
				                		구매 후 적립 받는 e머니는 얼마나 되나요?
				                	</span>
			                	</dt>
				                <dd id="a3" class="txt_a" style="display:none;">
				                	<span class="txt_inner">
						                <span class="mall">* e머니는 구매하신 상품의 <b>에누리 카테고리 기준</b>으로 적립되며, 카테고리 별 적립률은 아래와 같습니다.</span><br/><br/>
										<span style="font-weight:bold;">▶ 카테고리 별 적립률</span><br>
							            <ul class="indent">
											<li>- 1.5% 적립 : 유아,완구</li>
											<li>- 1.0% 적립 : 식품 / 스포츠,레저 / 자동차 / 화장품</li>
											<li>- 0.8% 적립 : 컴퓨터 / 도서 / 문구,사무 / PC부품</li>
											<li>- 0.3% 적립 : 디저털 / 영상,디카 / 가전(생활,주방,계절) / 패션,잡화 / 가구,인테리어</li>
											<li>- 0.2% 적립 : 생활,취미 / 모바일쿠폰,상품권(※특정 상품에 한하여 적립되오니적립가능 상품은 하단에서 확인해주세요.)</li>
							            </ul>
						                <br>
										<span style="font-weight:bold;">▶ [모바일쿠폰,상품권] 구매적립 기준</span><br>
							            <ul class="indent">
											<%if (DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2020.11.01. 00:00")<0 ) {%>
											<li>- 적립가능 쇼핑몰 : 티몬, G마켓, 옥션</li>
											<li><b>&nbsp;※ 2020년 11월 1일부터 티몬 상품권 e머니 구매적립이 종료될 예정입니다.</b></li>
											<%} else {%>
											<li>- 적립가능 쇼핑몰 : G마켓, 옥션, 인터파크</li>
											<%}%>
											<li>- 적립가능 상품 (0.2% 적립) : 문화상품권(해피머니, 컬쳐랜드), 도서상품권, 백화점상품권, 영화예매권, 국민관광 상품권</li>
											<li>- 백화점상품권 기준 상세</li>
											<li>&nbsp;1) 상품명에 '백화점 상품권' 명시된 상품 또는 백화점에서만 사용할 수 있는 상품권만 적립가능</li>
											<li>&nbsp;2) 복합상품권 적립불가 (삼성 상품권, 신세계 기프트카드, 롯데카드 상품권, 이랜드 상품권, AK플라자 상품권, 통합 상품권 등)</li>
											<li>&nbsp;&nbsp;- 복합 상품권의 경우 사용처에 백화점이 기재되어 있는 경우에도 적립불가</li>
											<li>&nbsp;3) 백화점 상품권으로 전환 가능한 포인트 구매 시 적립불가</li>
							            </ul>
						                <br>
										<span style="font-weight:bold;">※ e머니가 적립되지 않을 경우 고객센터로 문의주세요.</span><br>
					                </span>
				                </dd>
				                <dt class="txt_q" id="q4" style="display:none;">
				                	<span class="txt_inner">
				                		구매 후 30일이 지났는데 적립이 되지 않아요.
				                	</span>
			                	</dt>
				                <dd id="a4" class="txt_a" style="display:none;">
					                <span class="txt_inner">
										<span style="font-weight:bold;">▶ 구매적립 제외 카테고리/서비스</span><br>
										<ul class="indent">
											<li>- 에누리 가격비교에서 검색되지 않는 상품</li>
											<li>- 모바일쿠폰,상품권 : 상품권, 지역쿠폰, e교환권, e쿠폰 등</li>
											<li>- 쇼핑몰 제휴 서비스(배달, 티켓, 해외직구 등) 및 일부 카테고리</li>
											<li>&nbsp;ㄴ G마켓 : 중고장터, 실시간 여행, 항공권, 도서/음반, 모바일쿠폰/상품권(일부 적립가능)</li>
											<li>&nbsp;ㄴ 옥션 : 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권(일부 적립가능)</li>
											<li>&nbsp;ㄴ 11번가 : 여행/숙박/항공, 모바일쿠폰/상품권</li>
											<%if (DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2020.11.01. 00:00")<0 ) {%>
											<li>&nbsp;ㄴ 인터파크 : 라이프 서비스(티켓, 투어, 아이마켓 등), 모바일쿠폰/상품권</li>
											<li>&nbsp;ㄴ 티몬 : 특가 판매 상품(슈퍼꿀딜, 슈퍼마트 등), 모바일쿠폰/상품권(일부 적립가능 <b>※2020년 11월 1일부터 적립불가</b>)</li>
											<%} else{%>
											<li>&nbsp;ㄴ 인터파크 : 라이프 서비스(티켓, 투어, 아이마켓 등), 모바일쿠폰/상품권(일부 적립가능)</li>
											<li>&nbsp;ㄴ 티몬 : 특가 판매 상품(슈퍼꿀딜, 슈퍼마트 등), 모바일쿠폰/상품권</li>
											<%}%>
											<li>&nbsp;ㄴ 위메프 : 모바일쿠폰/상품권</li>
											<li>&nbsp;ㄴ GS SHOP, CJmall : 모바일쿠폰/상품권</li>
											<li>&nbsp;ㄴ SSG : 도서/음반/문구/취미/여행, 모바일쿠폰/상품권</li>
										</ul>
										<br>
										<span style="font-weight:bold;">▶ [모바일쿠폰,상품권] 구매적립 기준</span><br>
										<ul class="indent">
											<%if (DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2020.11.01. 00:00")<0 ) {%>
											<li>- 적립가능 쇼핑몰 : 티몬, G마켓, 옥션</li>
											<li><b>&nbsp;※ 2020년 11월 1일부터 티몬 상품권 e머니 구매적립이 종료될 예정입니다.</b></li>
											<%} else {%>
											<li>- 적립가능 쇼핑몰 : G마켓, 옥션, 인터파크</li>
											<%}%>
											<li>- 적립가능 상품 (0.2% 적립) : 문화상품권(해피머니, 컬쳐랜드), 도서상품권, 백화점상품권, 영화예매권, 국민관광 상품권</li>
											<li>- 백화점상품권 기준 상세</li>
											<li>1) 상품명에 '백화점 상품권' 명시된 상품 또는 백화점에서만 사용할 수 있는 상품권만 적립가능</li>
											<li>2) 복합상품권 적립불가 (삼성 상품권, 신세계 기프트카드, 롯데카드 상품권, 이랜드 상품권, AK플라자 상품권, 통합 상품권 등)</li>
											<li>&nbsp;- 복합 상품권의 경우 사용처에 백화점이 기재되어 있는 경우에도 적립불가</li>
											<li>3) 백화점 상품권으로 전환 가능한 포인트 구매 시 적립불가</li>
										</ul>
										<br>
										<span style="font-weight:bold;">▶ 구매확인/구매적립 불가한 경우</span><br>
										<ul class="indent">
											<li>아래의 경우에는 구매 확인 및 구매적립이 불가합니다.</li>
											<li>- 에누리 가격비교 모바일 앱이 아닌 다른 모바일 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 모바일 앱으로 결제만 한 경우</li>
											<li>- 에누리 가격비교 미 로그인 후 구매한 경우</li>
											<li>- 에누리 가격비교 PC 및 모바일 웹에서 구매한 경우 (※ 티몬 및 에누리 해외직구관은 PC 및 모바일 앱/웹 구매 시에도 가능)</li>
										</ul>
										<br>
										<span style="font-weight:bold;">※ e머니가 적립되지 않을 경우 고객센터로 문의주세요.</span><br>
										<ul class="indent">
											<li>적립 제외가 아닌데도 구매후 30일 후에도 e머니가 적립되지 않는 경우, 주문 정보와 함께 고객문의 > 이벤트/e머니 게시판에 문의 남겨주세요.</li>
											<br>
											<li>전달 주신 정보로 구매 내역 확인 및 적립을 도와드리고 있습니다.</li>
										</ul>
										<br>
										<span style="font-weight:bold;">[구매 내역 전달 방법]</span><br>
										<ul class="indent">
											<li>- 문의 글에 에누리 ID와 해당 쇼핑몰에서 "쇼핑몰명 / 주문일 / 주문번호 / 상품명 / 결제금액" 의 항목이 모두 확인되도록 주문 내역 캡쳐 이미지를  첨부하여 문의</li>
										</ul>
									</span>
				                </dd>
				                <dt class="txt_q" id="q5" style="display:none;">
				                	<span class="txt_inner">
				                		e머니 사용은 어떻게 하나요?
				                	</span>
			                	</dt>
				                <dd id="a5" class="txt_a" style="display:none;">
				                	<span class="txt_inner">
					               		 적립된 e머니는 My페이지에서 e쿠폰으로 교환할 수 있습니다.<br><br>
						                <span style="font-weight:bold;">▶ e쿠폰 교환 방법</span><br>
						                <ul class="faq5">
						                     <li><p>1) 앱(APP) 우측 상단 My페이지</p><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/emoney/faq/faq05_01.png" alt=""/></li>
						                     <li><p>2) e쿠폰 스토어 메뉴 선택</p><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/emoney/faq/faq05_02.png" alt=""/></li>
						                     <li><p>3) 원하는 e쿠폰으로 교환</p><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/emoney/faq/faq05_03.png" alt=""/></li>
						                     <li><p>4) 쿠폰함에서 교환한 e쿠폰 확인</p><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/emoney/faq/faq05_04.png" alt=""/></li>
						                </ul>
					                </span>
				                </dd>
				                <dt class="txt_q" id="q6" style="display:none;">
				                	<span class="txt_inner">
				                		e머니로 교환한 e쿠폰 사용방법 알려 주세요.
				                	</span>
			                	</dt>
				                <dd id="a6" class="txt_a" style="display:none;">
				                	<span class="txt_inner">
						                <span class="mall">교환한 e쿠폰은 My페이지 쿠폰함에서 확인하세요.</span>
						                <p class="faq_img">
											<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/emoney/faq/faq06.png" alt=""/>
						                </p>
						                <span class="mall">e쿠폰은 바코드형과 온라인쿠폰이 있습니다.</span>
						                <br>
						                <span style="font-weight:bold;">▶ 바코드형</span><br>
										오프라인 매장에서 상품 구매 시 쿠폰 제시<br><br>
						                <span style="font-weight:bold;">▶ 온라인 쿠폰</span><br>
										사용 웹사이트에서 쿠폰번호를 입력해서 사용<br><br>
										※ 상세한 쿠폰 사용방법은 쿠폰의 상세페이지를 확인하세요.<br>
									</span>
				                </dd>
				                <dt class="txt_q" id="q7" style="display:none;">
				                	<span class="txt_inner">
				                		적립된 e머니는 언제 소멸되나요?
				                	</span>
			                	</dt>
				                <dd id="a7" class="txt_a" style="display:none;">
				                	<span class="txt_inner">
										<span class="mall">유효기간이 지난 e머니는 자동 소멸되며, 소멸된 e머니는 재적립 불가합니다.</span>
										<span class="mall">e머니 소멸 7일 전, 소멸 안내 Push 알림 발송 (Push 알림 미 동의 시 예외)</span>
										<br>
										<span style="font-weight:bold;">▶ 유효기간 </span><br>
										<ul class="indent">
											<li>- 구매 적립 : 적립일로부터 60일</li>
											<li>- 이벤트 적립 : 이벤트페이지 내 별도 게재</li>
										</ul><br />
										<span style="font-weight:bold;">▶ 소멸 예정 e머니 확인 방법</span><br>
										<p class="faq_img">
											<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/emoney/faq/faq07.png" alt=""/>
										</p>
									</span>
				                </dd>
				                <dt class="txt_q" id="q8" style="display:none;">
				                	<span class="txt_inner">
				                		교환한 e쿠폰 교환 및 환불 되나요?
				                	</span>
			                	</dt>
				                <dd id="a8" class="txt_a" style="display:none;">
				                	<span class="txt_inner">
						                <span style="font-weight:bold;">▶ 유효기간 만료 전</span><br>
						                <span class="mall">미사용 쿠폰은 100% e머니로 환불</span>
						                <span class="mall">환불방법 : 쿠폰 상세페이지 하단 ‘환불요청’</span>
						                <br>
						                <span>※최초 교환시 e머니 적립 시점에 따라 환불 e머니 유효기간이 다를 수 있습니다.</span><br>
						                <span>- 만료시점이 과거 : 유효기간 1일</span><br>
						                <span>- 오늘 만료예정 : 유효기간 1일</span><br>
						                <span>- 유효기간 남은 경우 : 유효기간 유지</span><br>
						                <br>
						                <span style="font-weight:bold;">▶ 유효기간 만료 후</span><br>
						                <span class="mall">사용여부에 관계없이 교환 및 환불 불가</span>
						                <br>
					                </span>
				                </dd>
				                <dt class="txt_q" id="q9" style="display:none;">
				                	<span class="txt_inner">
				                		교환한 e쿠폰 상품에 오류가 있어 사용이 안 됩니다.
				                	</span>
			                	</dt>
				                <dd id="a9" class="txt_a" style="display:none;">
				                	<span class="txt_inner">
										<span>▶ e쿠폰으로 교환했으나 쿠폰함에 없을 경우, 또는 사용할 수 없는 바코드로 확인될 경우</span>
										<span class="mall">에누리 고객센터로 문의주시면 100% e머니로 환불해 드립니다._</span><br />
										<span>▶ 교환한 e쿠폰 상품이 단종됐을 경우</span>
										<span class="mall">e쿠폰 유효기간 만료 전 에누리 고객센터로 문의주시면 100% e머니로 환불해 드립니다.</span><br />
										<span>▶ e쿠폰 환불 접수</span>
										<span class="mall">모바일 : 자주묻는질문> 문의하기 </span>
										<span class="mall">PC : 고객센터 > 문의하기</span>
									</span>
				                </dd>
				           </dl>
            			</li>
            		</ul>
            	</div>

            	<!-- 버튼 : 목록으로 -->
                <button class="btn_list">
                    <span class="btn__txt">목록으로</span>
                </button>
                <!-- // -->
            </div>
		</div>

		<%@ include file="/my/include/m_appDownload.jsp"%>
	</section>
	<%@ include file="/my/include/m_footer.jsp"%>
</div>
<script>
var vApp = "<%=strAppyn%>";
var qno = <%=intQno%>;
var vTitle = "자주묻는 질문";

$(document).ready(function(){
	$('#a'+qno+', #q'+qno+'').show();

	//title생성
	try{
		window.android.getEmoneyTitle("자주묻는 질문");
	}catch(e){}

	if(vApp == "Y"){
		$('#wrap').addClass("isApp");
	}

	//헤더 뒤로가기
	$(".btn__sr_back, .btn_list").click(function(){
		if(vApp != 'Y' ){	// 웹에서 호출
			location.href = "/mobilefirst/emoney/emoney_faq.jsp";
		}else{
			// 앱에서 호출
			window.location.href = "close://";
		}
	});
});
</script>

<script>
    $(window).load(function(){
    	// 페이지 로드후 fadeIn
        var $view = $(".tab_cs li");
        $view.addClass("loaded");
    });
</script>
</body>
</html>
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>