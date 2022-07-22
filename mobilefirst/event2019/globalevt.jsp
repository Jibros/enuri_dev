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
    response.sendRedirect("/event2019/global_2019_evt.jsp"); //pc url
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
String strEventId = "2019091902";
String tab = ChkNull.chkStr(request.getParameter("tab"));

Cookie[] carr = request.getCookies();
String strAppyn = "";
String strVerios = ChkNull.chkStr(request.getParameter("verios"));
String strVerand = ChkNull.chkStr(request.getParameter("verand"));
String appType="";
int intVerios = 0;
int intVerand = 0;

boolean isVersion=false;//버젼이 3.1.3 이상 : TRUE  미만:FALSE

try {
  for(int i=0;i<carr.length;i++){
      if(carr[i].getName().equals("appYN")){
        strAppyn = carr[i].getValue();
        break;
      }
  }
  if(strVerios.equals("")){
    for(int i=0;i<carr.length;i++){
        if(carr[i].getName().equals("verios")){
          strVerios = carr[i].getValue();
          break;
        }
    }
  }
  if(strVerand.equals("")){
    for(int i=0;i<carr.length;i++){
        if(carr[i].getName().equals("verand")){
          strVerand = carr[i].getValue();
          break;
        }
    }
  }
  
  if(strVerios.length() > 0){
	  
	  strVerios = strVerios.replace(".","");
	  strVerios = strVerios.replace("00","");
	  
	  intVerios = Integer.parseInt(strVerios.replace(".",""));
	}
	if(strVerand.length() > 0){
	  intVerand = Integer.parseInt(strVerand.replace(".",""));
	}
	
	if(strAppyn.equals("Y")){
        if(intVerand >= 355){
            isVersion = true;
        }
        if(intVerios >= 355){
            isVersion = true;
        }
	}
  
} catch(Exception e) {}

	if(strVerios.length() > 0){
		
	  strVerios = strVerios.replace(".","");
      strVerios = strVerios.replace("00","");
      
	  intVerios = Integer.parseInt(strVerios.replace(".",""));
	}
	if(strVerand.length() > 0){
	  intVerand = Integer.parseInt(strVerand.replace(".",""));
	}
	
	if(strAppyn.equals("Y")){
        if(intVerand >= 355){
            isVersion = true;
        }
        if(intVerios >= 355){
            isVersion = true;
        }
	}
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
<link rel="stylesheet" href="/css/event/y2019/global_pro_m.css" type="text/css">
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
				<h2>에누리 해외직구 50% PAYBACK</h2>
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
	<div class="navi">
		<ul>
			<li><a href="#evt1">해외직구 50% PAYBACK</a></li>
			<li><a href="#evt2">방문만 해도 콜드브루 라떼!</a></li>
		</ul>
	</div>
	<!-- // -->

	<!-- 이벤트01 -->
	<div id="evt1" class="section event_01 scroll"><!-- 이벤트 1 앵커 영역 -->
		<div class="evt_box">
			<h3><img src="http://img.enuri.info/images/event/2019/global_pro/m_sec1_tit.png" alt="에누리에서 해외직구 하면 50% PAYBACK"></h3>
			<div class="evt_cnt">
				<span class="img_coupon">
					<img src="http://img.enuri.info/images/event/2019/global_pro/m_sec1_img_01.png" alt="">
				</span>
				<div class="btn_group">
					<button class="btn_go_global"><em>에누리 해외직구</em> 바로가기</button>
					<button class="btn_apply"><em>페이백</em> 응모하기</button>
				</div>
				<ul class="evt_noti_01">
					<li>이벤트기간 : 2019년 10월 21일 ~ 2019년 11월 30일</li>
					<li>당첨자 발표일 : 2020년 2월 26일</li>
					<li>이벤트 경품 : <br/>구매금액의 50% 페이백 (최대 5만점, e머니로 지급)</li>
					<li>참여방법: <br/>에누리 로그인 &gt; 해외직구 이동 &gt; $50 이상 구매 후 응모</li>
					<li>구매금액 기준
						<ul>
							<li>이벤트 기간 동안 구매한 상품의 누적금액</li>
							<li>배송비, 할인, 설치비, 쇼핑몰 포인트 등 제외한 실 결제금액</li>
							<li>구매 후 취소/환불/반품한 경우 제외</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
		<div class="caution-wrap">
			<div class="btn_box">
				<a class="btn_notice" href="javascript:///" onclick="onoff('layerNoti1');return false;">유의사항을 꼭! 확인하세요</a>
			</div>
			<div id="layerNoti1" class="moreview" style="display:none">
				<h4>50% 페이백 유의사항</h4>
				<div class="txt">
					<strong>이벤트 기간</strong>
					<ul class="txt_indent">
						<li>이벤트기간: 2019년 10월 21일 ~ 2019년 11월 30일</li>
					</ul>
					<strong>이벤트 참여방법</strong>
					<ul class="txt_indent">
						<li>에누리 앱 로그인 &rarr; 해외직구 이동 &rarr; $50 이상 구매 &rarr; 50% 페이백 이벤트 응모!</li>
						<li>해외직구 구매적립은 본인인증 후 구매시에만 적립가능</li>
						<li>구매금액 기준
							<ul>
								<li>$50 구매금액은 이벤트 기간 동안 구매한 상품의 누적금액</li>
								<li>배송비, 할인, 설치비, 쇼핑몰 포인트 등을 제외한 실제 결제금액 (구매환율 또는 수수료에 따라 달라질 수 있음)</li>
								<li>구매 후 취소/환불/반품/교환한 경우 제외</li>
							</ul>
						</li>
					</ul>
					<strong>이벤트 경품</strong>
					<ul class="txt_indent">
						<li>이벤트 경품: 구매금액의 50% 페이백 (최대 5만점)</li>
						<li>e머니 유효기간: 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</li>
						<li>경품은 e머니로 적립되며, e쿠폰 스토어에서 교환 가능</li>
					</ul>
					<strong>당첨자 발표 및 페이백 지급일</strong>
					<ul class="txt_indent">
						<li>당첨자 발표 및 페이백 지급일: 2020년 2월 26일</li>
						<li>당첨자 공지: [에누리 가격비교 PC 사이트 > 고객센터] 및 [에누리 가격비교 APP > 당첨자 발표] </li>
					</ul>
					<strong>해외쇼핑몰별 구매 적립률</strong>
					<ul class="txt_indent">
						<li class="no_bul">
							<div class="tb">
								<table>
									<colgroup>
										<col><col>
									</colgroup>
									<tbody>
										<tr>
											<th>쇼핑몰</th>
											<th>적립률</th>
										</tr>
										<tr><td>Ralph Lauren</td><td>3.0%</td></tr>
										<tr><td>AliExpress</td><td>4.0%</td></tr>
										<tr><td>eBay US</td><td>0.5%</td></tr>
										<tr><td>gap</td><td>2.0%</td></tr>
										<!-- <tr><td>MATCHESFASHION</td><td>3.5%</td></tr> -->
										<tr><td>Farfetch Korea</td><td>3.5%</td></tr>
										<tr><td>Carter's</td><td>1.5%</td></tr>
										<tr><td>iHerb</td><td>2.5%</td></tr>
										<!-- <tr><td>DKNY</td><td>7.5%</td></tr> -->
										<tr><td>Nordstrom Rack</td><td>6.5%</td></tr>
										<!-- <tr><td>Saks 5th Avenue</td><td>3.5%</td></tr> -->
										<tr><td>Woot</td><td>1.0%</td></tr>
										<!-- <tr><td>Finish Line</td><td>2.5%</td></tr> -->
										<tr><td>그 외 쇼핑몰</td><td>2.0%</td></tr>
									</tbody>
								</table>
							</div>
						</li>	
					</ul>
					<strong>아래의 경우에는 구매 확인 및 적립이 불가합니다.</strong>
					<ul class="txt_indent">
						<li>에누리 가격비교가 아닌 다른 사이트를 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱으로 결제만 한 경우<br/>(에누리 가격비교를 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)</li>
						<li>에누리 가격비교에서 로그인하지 않고 구매한 경우</li>
						<li>에누리 가격비교에서 검색되지 않는 상품을 구매한 경우</li>
					</ul>
					<strong>유의사항</strong>
					<ul class="txt_indent">
						<li>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</li>
						<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
					</ul>					
					<a href="javascript:///" onclick="onoff('layerNoti1');return false" class="btn_check_hide">확인</a>
				</div>
			</div>
		</div>
	</div>
	<!-- // 이벤트01 -->

	<!-- 이벤트02 -->
	<div id="evt2" class="section event_02 scroll"> <!-- 이벤트 2 앵커 영역 -->
		<div class="evt_box">
			<h3><img src="http://img.enuri.info/images/event/2019/global_pro/m_sec2_tit.png" alt="인기 해외쇼핑몰 방문만 해도 콜드브루 라떼 증정!"></h3>
			<div class="evt_cnt">
				<span class="blind">추첨을 통해 100분에게 이디야 콜드부르 라떼를 드려요!지금 인기쇼핑몰을 방문해보세요!</span>
				<div class="evt_area">
					<!-- 나의 누적 방문건수 -->
					<span class="count">
						나의 누적 방문건수 <em id="userCnt">?</em>회
					</span>
					<span class="txt_sub">방문횟수가 많아질수록 당첨확률 UP!</span>
					<ul class="list_store">
						<li data-mid="440" >
							<a href="javascript:///">
								<span class="thumb"><img src="http://img.enuri.info/images/event/2019/global_pro/ico_brand_01.png" alt="EBAY"></span>
								<span class="earn">0.5% 적립</span>
							</a>
						</li>
						<li data-mid="1739" >
							<a href="javascript:///">
								<span class="thumb"><img src="http://img.enuri.info/images/event/2019/global_pro/ico_brand_02.png" alt="Aliexpress"></span>
								<span class="earn">4.0% 적립</span>
							</a>
						</li>
						<li data-mid="1270">
							<a href="javascript:///">
								<span class="thumb"><img src="http://img.enuri.info/images/event/2019/global_pro/ico_brand_03.png" alt="Ralph Louren"></span>
								<span class="earn">3.0% 적립</span>
							</a>
						</li>
						<li data-mid="1555">
							<a href="javascript:///">
								<span class="thumb"><img src="http://img.enuri.info/images/event/2019/global_pro/ico_brand_04.png" alt="GAP"></span>
								<span class="earn">2.0% 적립</span>
							</a>
						</li>
						<li data-mid="2818">
							<a href="javascript:///">
								<span class="thumb"><img src="http://img.enuri.info/images/event/2019/global_pro/ico_brand_06.png" alt="Farfetch"></span>
								<span class="earn">3.5% 적립</span>
							</a>
						</li>
						<li data-mid="6741">
							<a href="javascript:///">
								<span class="thumb"><img src="http://img.enuri.info/images/event/2019/global_pro/ico_brand_07.png" alt="Carters"></span>
								<span class="earn">1.5% 적립</span>
							</a>
						</li>
						<li data-mid="7650">
							<a href="javascript:///">
								<span class="thumb"><img src="http://img.enuri.info/images/event/2019/global_pro/ico_brand_08.png" alt="iHerb"></span>
								<span class="earn">2.5% 적립</span>
							</a>
						</li>
						
						<li data-mid="469">
							<a href="javascript:///">
								<span class="thumb"><img src="http://img.enuri.info/images/event/2019/global_pro/ico_brand_10.png" alt="Nordstrom Rack"></span>
								<span class="earn">6.5% 적립</span>
							</a>
						</li>
						
						<li data-mid="6744">
							<a href="javascript:///">
								<span class="thumb"><img src="http://img.enuri.info/images/event/2019/global_pro/ico_brand_12.png" alt="woot!"></span>
								<span class="earn">1.0% 적립</span>
							</a>
						</li>
						
					</ul>
				</div>
				<ul class="evt_noti_02">
					<li>이벤트기간 : 2019년 10월 21일 ~ 2019년 11월 30일</li>
					<li>당첨자 발표일 : 2019년 12월 16일</li>
					<li>참여방법 및 유의사항
						<ul>
							<li>에누리 로그인 &gt; 인기 쇼핑몰 아이콘 클릭 &gt;<br/>쇼핑몰 접속시 1회 방문!</li>
							<li><em>1일 30회 제한, 30회 이상 방문시에는<br/>방문건수에서 제외</em></li>
						</ul>
					</li>
					<li>이벤트 경품: 이디야 콜드브루라떼 (e머니 4,200점)</li>
				</ul>
			</div>
		</div>		
		<div class="caution-wrap">
			<div class="btn_box">
				<a class="btn_notice" href="javascript:///" onclick="onoff('layerNoti2');return false;">유의사항을 꼭! 확인하세요</a>
			</div>
			<div id="layerNoti2" class="moreview" style="display:none">
				<h4>방문이벤트 유의사항</h4>
				<div class="txt">
					<strong>이벤트기간</strong>
					<ul class="txt_indent">
						<li>2019년 10월 21일 ~ 2019년 11월 30일</li>
					</ul>
					<strong>이벤트 참여방법</strong>
					<ul class="txt_indent">
						<li>에누리 앱 로그인 &rarr; 프로모션 페이지 &rarr; 인기 해외쇼핑몰 아이콘 클릭 &rarr; 1회 방문 완료!</li>
						<li>로그인하지 않고 방문하거나, 프로모션 페이지가 아닌 다른 페이지에서 방문한 경우 제외</li>
						<li><span class="stress">1일 30회 제한, 30회 초과 방문시에는 방문건수에서 제외</span></li>
						<li><span class="stress">많이 방문할 수록 당첨확률 UP!</span></li>
					</ul>
					<strong>이벤트 경품</strong>
					<ul class="txt_indent">
						<li>이디야 콜드브루라떼(e머니 4,200점)</li>
						<li><span class="stress">e머니 유효기간: 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span></li>
						<li>경품은 e쿠폰으로 교환 가능한 e머니로 적립되며, e쿠폰 스토어에서 교환 가능<br/>※ 경품은 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격변동이 있을 수 있음</li>
					</ul>
					<strong>당첨자 발표 및 경품지급일</strong>
					<ul class="txt_indent">
						<li>당첨자 발표일: 2019년 12월 16일</li>
						<li>당첨자 공지: 에누리 앱 &gt; 이벤트/기획전탭 &gt; 이벤트혜택 &gt; 하단 ‘당첨자 발표’에 공지</li>						
					</ul>
					<strong>유의사항</strong>
					<ul class="txt_indent">
						<li>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</li>
						<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
					</ul>					
					<a href="javascript:///" onclick="onoff('layerNoti2');return false" class="btn_check_hide">확인</a>
				</div>
			</div>
		</div>	
	</div>

	<!-- 이벤트3 -->
	<div id="evt3" class="section event_03">
		<div class="evt_box">
			<h3><img src="http://img.enuri.info/images/event/2019/global_pro/m_sec3_tit.png" alt="에누리에서 해외직구하고 쇼핑 할 때 마다 최대 7.5% 적립 받으세요!"></h3>
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<img src="http://img.enuri.info/images/event/2019/global_pro/m_sec3_slide_01.jpg" alt="에누리 로그인 후 해외직구 페이지 이동 (PC, 모바일에서 모두 가능!)">
					</div>
					<div class="swiper-slide">
						<img src="http://img.enuri.info/images/event/2019/global_pro/m_sec3_slide_02.jpg" alt="구매금액의 최대 7.5% e머니 적립 (※구매일자 환율 기준)">
					</div>
					<div class="swiper-slide">
						<img src="http://img.enuri.info/images/event/2019/global_pro/m_sec3_slide_03.jpg" alt="적립된 e머니는 1,000여개의 인기 e쿠폰으로 교환가능!">
					</div>
				</div>
				<button class="swiper-button-prev">이전</button>
				<button class="swiper-button-next">다음</button>
			</div>
			<span class="swiper-pagination"></span>
			<script>
				$(function(){
					var mySwiper = Swiper('.event_03 .swiper-container',{
						prevButton : '.event_03 .swiper-button-prev',
						nextButton : '.event_03 .swiper-button-next',
						pagination : '.event_03 .swiper-pagination',
						speed : 800,
						autoplayDisableOnInteraction : false,
						autoplay : 4000
					});
				})
			</script>
		</div>
	</div>
	<!-- //Contents -->	
	<span class="go_top"><a href="javascript:///">TOP</a></span>
    <%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
</div>
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

var totalcnt = 0;
var event_id = "<%=strEventId%>";

var PAGENO = 1;
var PAGESIZE = 5;
var BLOCKSIZE = 5;

var vEvent_title = "해외직구이벤트";
var vEvent_page = "";

//공통영역//
(function(){
	
	ga('send', 'pageview', {'title': vEvent_title + " > " + "PV"});
	
	if(islogin())		getPoint();
	//닫기버튼
	 $( ".win_close" ).click(function(){
        if(app == 'Y')  window.location.href = "close://";
        else            window.location.replace("/mobilefirst/index.jsp");
	});
	
	$(".go_top").click(function(){		$(window).scrollTop(0);	});

	if(islogin())		getPoint();
	if(tapType!='') 		setTimeout(inner, 300);
	
	$(".btn_go_global").click(function(){
		
		GA("해외직구 바로가기");
		
		if(islogin()){
			if(app == "Y"){
				
				if(<%=isVersion%>){
					location.href = "/global/m/Index.jsp?freetoken=global";
				}else{
					location.href = "/global/m/Index.jsp?freetoken=outbrowser";	
				}
				
			}else{
				window.open("/global/m/Index.jsp?freetoken=outbrowser","_blank");
			}
		}else{
			alert("로그인 후 이동 가능합니다!");
			location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
			return false;
		}
	});
	
	$(".btn_apply").click(function(){
		
		GA("응모하기");
		
		if(islogin()){
			
			$.ajax({
		 		type: "GET",
		 		url: "/mobilefirst/evt/ajax/global2019_setlist.jsp?procCode=1&osType="+getOsType(),
		 		dataType: "JSON",
		 		success: function(json){
		 			if(json.result == 2601){
		 				alert("이미 응모해주셨습니다! 한 번만 응모해도 구매금액 자동 누적됩니다.");
		 			}else if(json.result == -99){
		 				alert("구매 후 응모 가능합니다!");
		 			}else if(json.result == 1){
		 				alert("응모완료! 당첨자 발표일을 기다려주세요!");
		 			}
		 		}
		 	});
		}else{
			alert("로그인 후 참여가능합니다.");
			location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
			return false;
		}
	});
	
	$(".list_store > li").click(function(){
		
		if(islogin()){
		
			var muid = $(this).attr("data-mid");
			
			$.ajax({
		 		type: "GET",
		 		url: "/mobilefirst/evt/ajax/global2019_setlist.jsp?procCode=2&muid="+muid+"&osType="+getOsType(),
		 		dataType: "JSON",
		 		success: function(json){
		 			
		 			GA("쇼핑몰:"+muid);
		 			
		 			if(app == 'Y'){
		 				
		 				if(<%=isVersion%>){
		 					location.href = "/global/m/mvp.jsp?muid="+muid+"&freetoken=global";
		 				}else{
		 					location.href = "/global/m/mvp.jsp?muid="+muid+"&freetoken=outbrowse";	
		 				}
		 				
		 			}else{
		 				location.href = "/global/m/mvp.jsp?muid="+muid;
		 			}
		 			
		 			
		 			if(json.logCnt >= 30){
		 				alert("방문횟수는 하루에 30회까지만 집계됩니다!");
		 			}
		 			
		 			userCnt();
		 			return false;
		 		}
		 	});
		
		}else{
			alert("로그인 후 이동 가능합니다!");
			location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
			return false;
		}
	});
	if(islogin()){
		userCnt();
	}
})();

function userCnt(){
	
	$.ajax({
 		type: "GET",
 		url: "/mobilefirst/evt/ajax/global2019_setlist.jsp?procCode=3",
 		dataType: "JSON",
 		success: function(json){
 			$("#userCnt").text(json.userCnt);
 		}
 	});
}

function inner() {
	$('html, body').animate({scrollTop: Math.ceil($('#'+tapType).offset().top-$("#topFix").height())}, 1000);
}

function GA(label){
	ga('send', 'event', 'mf_event', vEvent_title  ,label);		
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
function boardTopMove(){
	var offset = $("#replyMsg").offset();
	$('html, body').animate({scrollTop : offset.top});
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
	welcomeGa("evt_globalevt_view");    
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