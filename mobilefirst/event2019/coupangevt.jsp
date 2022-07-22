<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
String strFb_title = "[에누리 가격비교] 쿠팡 e머니 최대 5% 적립";
String strFb_description = "이벤트 소문내고 카페라떼까지 GET!";
String strFb_img = ConfigManager.IMG_ENURI_COM+"/images/event/2020/coupang/sns_1200_630.jpg";

 if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){

}else{
    response.sendRedirect("/eventPlanZone/jsp/coupangevt.jsp"); //pc url
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
String oc =  ChkNull.chkStr(request.getParameter("oc"));
Members_Proc members_proc = new Members_Proc();
String cUsername = "";
String userArea = "";

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;

    if(cUsername.equals(""))      userArea = cUserNick;
    if(userArea.equals(""))        userArea = cUserId;
    /*
    String snsType = ChkNull.chkStr(cb.GetCookie("MEM_INFO","SNSTYPE"));
	if( "K".equals(snsType) ||  "N".equals(snsType) ){//sns 계정일 경우 닉네임을 넣어준다
		userArea = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK")); //로그인 닉네임
	}
	*/
}
//String strEventId = "2019110601";
//String strEventId =   "2020040110";
String strEventId = "2020100601";
String tab = ChkNull.chkStr(request.getParameter("tab"));

String gkind = "";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<title>에누리(가격비교) eNuri.com</title>
<meta property="og:title" content="<%=strFb_title%>">
<meta property="og:description" content="<%=strFb_description%>">
<meta property="og:image" content="<%=strFb_img%>">
<meta name="format-detection" content="telephone=no" />
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<link rel="stylesheet" href="/css/event/y2020/coupang_oct_m.css" type="text/css">
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
var gkind = "<%=userArea%>";
</script>
<div class="lay_only_mw" style="display:none;">
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
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>
	
	<!-- 플로팅 배너  -->
	<div class="floating_bnr" style="display:none">
		<img src="<%=ConfigManager.IMAGE_ENURI_COM%>/images/event/2019/crazyFriday/fl_bnr.png" alt="매일 오전 10시 매일 한정특가">
		<a href="javascript:///" onclick="$('.floating_bnr').hide();return false;" class="btn_close">닫기</a>
	</div>
	<!-- //  플로팅 배너 -->

	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">

		<!-- 상단비주얼 -->		
		<div class="visual">
			<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
			<div class="inner">
				<span class="obj_rocket"><!-- 로켓 --></span>
				<span class="obj_rocket_fart"><!-- 로켓 방구 --></span>
				<span class="obj_01">
					<span class="txt_01"><!-- P --></span>
					<span class="txt_02"><!-- A --></span>
					<span class="txt_03"><!-- N --></span>
					<span class="txt_04"><!-- G --></span>
				</span>
				<span class="obj_group_01">
					<span class="obj_02"><!-- 이머니 --></span>
					<span class="obj_group_02">
						<span class="obj_04"><!-- 최대 --></span>
						<span class="obj_05"><!-- 5% --></span>
						<span class="obj_03"><!-- %적립 --></span>
					</span>
				</span>
				<span class="obj_group_03">
					<span class="obj_sub"><!-- 이벤트 소문내고 카페모카 까지 GET! --></span>
					<span class="obj_coffee"><!-- 커피 --></span>
				</span>
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
			<li><a href="#evt1">구매금액의 최대 5% 적립!</a></li>
			<li><a href="#evt2">오늘의 인기상품은?</a></li>
			<li><a href="#evt3">소문내고 카페모카 받자!</a></li>
		</ul>
	</div>
	<!-- // -->

	<!-- 이벤트01 -->
	<div id="evt1" class="section event_01 scroll"><!-- 이벤트 1 앵커 영역 -->
		<div class="evt_box">
			<h3><img src="http://img.enuri.com/images/event/2020/coupang/oct/m_sec1_tit.png" alt="APP 전용 이벤트 - 에누리 앱 경유하여 쿠팡에서 구매시 최대 5% 적립!"></h3>
			<div class="evt_cnt">
				<div class="evt_area">
					<a href="javascript:///" class="btn_coupang" >쿠팡 바로가기</a>
				</div>
				<ul class="evt_noti_01">
					<li>이벤트기간 : 2020년 10월 6일 ~ 12월 28일</li>
					<li>참여기간 및 유의사항
						<ul>
							<li>에누리 앱 로그인 &gt; 쿠팡 접속 &gt; 대상 카테고리 상품 1,000원 이상 구매 &gt; 구매금액의 최대 5% 적립! (※구매일로부터 최대 30일 소요)<br>
								<p style="color:red">※ 대상 카테고리는 ‘에누리’ 기준이며, 모바일 이벤트 페이지 내 대상 카테고리   클릭 시 편리하게 상품 확인이 가능합니다.</p>
							</li>
							<li>적립률은 카테고리별로 상이하며, 상세내용 유의사항에서 확인하세요</li>
							<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품의 실제 결제금액만 반영됩니다.</li>
							<li>본인인증 후 구매한 경우에만 적립가능합니다.</li>
						</ul>
					</li>
				</ul>
			</div>
			<div class="category">
				<h4>대상 카테고리</h4>
				<p class="blind">APP에서 구매하세요!</p>
				<ul class="cate_list">
					<li><a href="javascript:///" >유아완구 5.0%</a></li>
					<li><a href="javascript:///" >식품 3.0%</a></li>
					<li><a href="javascript:///" >스포츠 3.0%</a></li>
					<li><a href="javascript:///" >컴퓨터노트북 2.0%</a></li>
					<li><a href="javascript:///" >가전 1.0%</a></li>
					<li><a href="javascript:///" >영상디카 1.0%</a></li>
					<li><a href="javascript:///" >디지털 2.0%</a></li>
					<li><a href="javascript:///" >가구생활 1.0%</a></li>
					<li><a href="javascript:///" >화장품 1.0%</a></li>
				</ul>
			</div>			
		</div>
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop1"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop1" class="evt_notice--slide">
			<div class="evt_notice--inner"> <!-- .wide - 넓은 케이스 -->
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<dl>								
							<dt>이벤트 및 구매기간</dt>
							<dd>
								<ul>
									<li>2020년 10월 6일 ~ 12월 28일</li>
								</ul>
							</dd>
						</dl>

						<dl>
							<dt>이벤트 참여방법 및 대상카테고리별 적립률</dt>
							<dd>
								<ul>
									<li>에누리 앱 로그인 → 쿠팡 접속 → 대상카테고리 상품 1,000원 이상 구매 → 결제금액의 최대 5% 적립 </li>
									<li>본 프로모션은 APP에서만 참여가 가능한 APP전용 프로모션 입니다.</li>
									<li>구매 e머니는 구매 확인완료 시점(구매후 최대 30일)부터 모바일 앱 → my 에누리 → 적립내역 페이지에서 확인 가능<br>
										<span class="noti stress">※ 대상 카테고리는 ‘에누리’ 기준이며, 모바일 이벤트 페이지 내 대상 카테고리 클릭 시 편리하게 상품 확인이 가능합니다.</span>
									</li>
									<li>적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환 가능</li>
									<li>구매적립 e머니 유효기간: 적립일로부터 60일</li>
									<li>대상 쇼핑몰: 쿠팡 (쿠팡 외의 쇼핑몰에서 구매시 미적용)</li>
								</ul>
							</dd>
						</dl>

						<dl>
							<dt>대상카테고리 및 이벤트 적립률</dt>
							<dd>
								<table class="evt_noti_tb" style="width:300px;">
									<tbody>
										<tr><th>대상 카테고리</th><th>기존적립률 →이벤트 적립률</th></tr>
										<tr><td>유아/완구</td><td>1.5% <em>→&nbsp; 5.0%</em></td></tr>
										<tr><td>식품</td><td>1.0% <em>→&nbsp; 3.0%</em></td></tr>
										<tr><td>스포츠</td><td>1.0% <em>→&nbsp; 3.0%</em></td></tr>
										<tr><td>컴퓨터/노트북</td><td>0.8% <em>→&nbsp; 2.5%</em></td></tr>
										<tr><td>생활가전</td><td>0.3% <em>→&nbsp; 1.0%</em></td></tr>
										<tr><td>주방가전</td><td>0.3% <em>→&nbsp; 1.0%</em></td></tr>
										<tr><td>계절가전</td><td>0.3% <em>→&nbsp; 1.0%</em></td></tr>
										<tr><td>영상/디카</td><td>0.3% <em>→&nbsp; 1.0%</em></td></tr>
										<tr><td>디지털</td><td>0.3% <em>→&nbsp; 2.0%</em></td></tr>
										<tr><td>가구/인테리어</td><td>0.3% <em>→&nbsp; 1.0%</em></td></tr>
										<tr><td>생활/취미</td><td>0.2% <em>→&nbsp; 1.0%</em></td></tr>
										<tr><td>화장품</td><td>0.3% <em>→&nbsp; 1.0%</em></td></tr>
									</tbody>
								</table>
							</dd>
						</dl>

						<dl>
							<dt>이벤트 유의사항 </dt>
							<dd>
								<ul>
									<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품의 실제 결제금액만 반영됨</li>
									<li>본인인증 후 구매시에만 적립가능</li>
									<li>구매후 취소/환불/반품한 경우 적립불가</li>
									<li>적립대상쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제 시 구매건수는 1건이며, <br>구매금액은 통합 결제한 금액의 e머니 적립</li>
									<li>e머니는 최소 10점부터 적립되며 (구매금액 1,000원 이상), 1원 단위 e머니는 적립불가.<br>(예: 1,200원 결제 시 e머니 10점 적립)</li>
									<li>생활/취미 카테고리 중 ‘모바일쿠폰,상품권’은 적립불가</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>아래의 경우에는 구매 확인 및 적립이 불가합니다.</dt>
							<dd>
								<ul>
									<li>에누리 가격비교 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱으로 결제만 한 경우<br>(에누리 가격비교 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)</li>
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
					<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 유의사항 닫기 -->
				</div>
			</div>
		</div>
	</div>
	<!-- // 이벤트01 -->

	<!-- 이벤트02 -->
	<div id="evt2" class="section event_02 scroll"> <!-- 이벤트 2 앵커 영역 -->
		<div class="evt_box">
			<h3><img src="http://img.enuri.com/images/event/2020/coupang/oct/m_sec2_tit.png" alt="뭘 구매해야 할 지 고민된다면? 인기상품 추천!"></h3>
			<ul id="goodsList"></ul>
		</div>
	</div>
	<!-- 이벤트3 -->
	<div id="evt3" class="section event_03 scroll">
		<div class="evt_box">
			<h3><img src="http://img.enuri.com/images/event/2020/coupang/oct/m_sec3_tit.png" alt="보너스 이벤트 - 친구에게 이벤트 소문내고 스타벅스 카페모카 받자!"></h3>
			<div class="evt_cnt">
				<span class="blind">원하는 SNS로 친구에게 공유해보세요!</span>
				<ul class="share_area">
					<li>
						<a href="javascript:///">
							<span class="txt_name blind">카카오톡</span>
						</a>
					</li>
					<li>
						<a href="javascript:///">
							<span class="txt_name blind">페이스북</span>
						</a>
					</li>
					<li>
						<a href="javascript:///">
							<span class="txt_name blind">트위터</span>
						</a>
					</li>
					<li>
						<a href="javascript:///" class="icon_share icon_uc"   data-clipboard-text="http://m.enuri.com/mobilefirst/event2019/coupangevt.jsp?flow=share&oc=mo">
							<span  class="txt_name blind url"  >URL복사</span>
						</a>
					</li>
				</ul>
			</div>
		</div>
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop2"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop2" class="evt_notice--slide">
			<div class="evt_notice--inner"> <!-- .wide - 넓은 케이스 -->
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<dl>								
							<dt>이벤트기간</dt>
							<dd>
								<ul>
									<li>2020년 10월 6일 ~ 12월 28일</li>
								</ul>
							</dd>
						</dl>

						<dl>
							<dt>이벤트 참여방법</dt>
							<dd>
								<ul>
									<li>쿠팡 최대 5% 프로모션을 SNS를 통하여 공유하기</li>
									<li>공유한 SNS 링크를 댓글로 남기기(카카오톡으로 공유한 경우 ‘공유완료!’ 댓글만 남겨도 OK!)</li>
									<li>SNS 공유와 댓글 모두 참여할 경우에만 이벤트 응모로 집계되며, 둘 중 하나만 참여한 경우에는 추첨시 제외됨</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>이벤트 경품</dt>
							<dd>
								<ul>
									<li>스타벅스 아이스 카페모카(e머니 5,100점)</li>
									<li class="stress">e머니 유효기간: 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</li>
									<li>경품은 e쿠폰으로 교환 가능한 e머니로 적립되며, e쿠폰 스토어에서 교환 가능<br>
										<span class="noti">※ 경품은 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격변동이 있을 수 있음</span>
									</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>당첨자 발표 및 경품지급일</dt>
							<dd>
								<ul>
									<li>당첨자 발표일: 2021년 1월 20일</li>
									<li>당첨자 공지: 에누리 앱 &gt; 이벤트/기획전탭 &gt; 이벤트혜택 &gt; 하단 ‘당첨자 발표’에 공지</li>
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
					<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 유의사항 닫기 -->
				</div>
			</div>
		</div>
	</div>
	
	<!-- 이벤트04 -->
	<div class="section event_04 scroll">				
		<div class="evt_box">
			<h3><img src="http://img.enuri.com/images/event/2020/coupang/oct/m_sec4_tit.png" alt="SNS로 소문내고 댓글 남겨주시면 스타벅스 카페모카를 드립니다!"></h3>
			<!-- 게시판 -->
			<div class="input_board">
				<div class="write_area">
					<div class="input">
						<!-- 
							@참고
							로그인 전일 때, 
							보이지 않는 버튼 올려서 로그인 타게 버튼 추가했어요. 로그인 후에는 클래스(disNone) 추가해 주세요. class="login_alert disNone" 
						-->
						<a href="javascript:///" class="login_alert disNone "><!-- 로그인 전 버튼 영역 --></a>
						<textarea id="replyMsg" class="txt_area" maxlength="150" placeholder="SNS에 공유 후 댓글을 남겨주세요!"></textarea>						
						<button id="regist" onclick="insertReplayMsg()" class="btn regist">등록</button>
					</div>
					<!-- <p class="total_num">전체 글 : <span>1896</span></p> -->
				</div>
				<div class="view_area">
					<ul id="body_list"></ul>
				</div>
				<div class="paging" id="paginate" ></div>
				
			</div>
			<!-- // 게시판 -->
		</div>
	</div>
	
	<!-- //Contents -->	
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

<div class="com__share_wrap dim" style="z-index: 10000;display:none">
	<div class="com__layer share_layer">
		<div class="lay_head">공유하기</div>
		<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
		<div class="lay_inner">
			<ul id="eventShr">
				<li class="share_fb" id="fbShare" >페이스북 공유하기</li>
				<li class="share_kakao" id="kakao-link-btn">카카오톡 공유하기</li>				
				<li class="share_tw" id="twShare" >트위터 공유하기</li>
			</ul>
			<!-- 메인보내기 버튼클릭시 .mail_on 추가해 주세요 -->
			<div class="btn_wrap">
				<div class="btn_group">
					<!-- 주소복사하기 -->
					<div class="btn_item">
						<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2019/coupangevt.jsp?oc=mo</span>
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

<script type="text/javascript">
var tapType = "<%=tab%>";
var default_src = "<%=ConfigManager.STORAGE_ENURI_COM%>";

var totalcnt = 0;
var event_id = "<%=strEventId%>";

var PAGENO = 1;
var PAGESIZE = 5;
var BLOCKSIZE = 5;

var vEvent_title = "쿠팡이벤트";
var vEvent_page = "";

var vChkId ="";

var shareUrl = "http://" + location.host + "/mobilefirst/event2019/coupangevt.jsp?flow=share&oc=mo";

Kakao.init('5cad223fb57213402d8f90de1aa27301');

var shareTitle = "<%=strFb_title%> <%=strFb_description%>";
var oc = '<%=oc%>';
//공통영역//
(function(){
	
	if(oc!=''){
		$('.lay_only_mw').show();
	}
	
	var nav = $('.myarea'); 
	$(window).scroll(function () {
		if ($(this).scrollTop() > $(".event_01").offset().top) {
			nav.addClass("f-nav");
		} else {
			nav.removeClass("f-nav");
		}
	});
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
		})
	$("#eventShr > li").click(function(){
		var sel = $(this).attr("class");
		
		if(sel == "share_fb"){
			shareInsert(1);
			try{
				window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(shareTitle)+"&u="+shareUrl);
			}catch(e){
				window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(shareTitle)+"&u="+shareUrl);
			}	
		}else if(sel == "share_tw"){
			
			shareInsert(4);
			
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
	
	$(".navi > ul > li ").click(function(){
		var inx = $(this).index();
		if(inx == 0 )      GA("상단탭_5%적립");
		else if(inx == 1 ) GA("상단탭_쿠팡최저가");
		else if(inx == 2 ) GA("상단탭_스벅쿠폰");
	});
	
	ga('send', 'pageview', {'title': vEvent_title + " > " + "PV"});
	
	//url 복사
	var clipboard = new ClipboardJS('.icon_share.icon_uc');
	clipboard.on('success', function(e) {
		alert("복사가 완료되었습니다!");
		shareInsert(3);
 	}).on('error', function(e) {
		prompt("아래의 URL을 길게 누르면 복사할 수 있습니다.", shareUrl);
		shareInsert(3);
 	});
	
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1)		mType = "I";
	else if(navigator.userAgent.indexOf("Android") > -1)		mType = "A";
	
	if(islogin())		getPoint();
	//닫기버튼
	 $( ".win_close" ).click(function(){
        if(app == 'Y')  window.location.href = "close://";
        else            window.location.replace("/mobilefirst/index.jsp");
	});
	
	$(".go_top").click(function(){		$(window).scrollTop(0);	});

	getGoodsList();
	goPage(1);
	snsShare();
	//getCerti();
	
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
		
		if(app == "Y"){
		
			if(!islogin()){
				alert("로그인 후 참여가능합니다.");
				location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
				return false;
			}else{
				location.href = "http://landing.coupang.com/pages/M_home?src=1033035&spec=10305201&lptag=Enuri_M_logo&forceBypass=Y";	
				return false;
			}
		
		}else{
			onoff('app_only');
		}

	});
	if(islogin()){
		getPoint();
	}
	
	if(tapType!='') {
		setTimeout(inner, 300);
	}

	try{
		Kakao.Link.createDefaultButton({
			container: '#kakao-link-btn',
			objectType: 'feed',
			content: {
				title: '<%=strFb_title%>',
		        description: '<%=strFb_description%>',
		        imageUrl: "<%=strFb_img%>",
				link: {
					mobileWebUrl: shareUrl,
					webUrl: shareUrl
				}
			},
			buttons: [
				{title: '에누리 가격비교 열기',
					link: {
						mobileWebUrl: shareUrl,
						webUrl: shareUrl
					}
				}
			]
		});
		
	}catch(e){
		//alert("카카오 톡이 설치 되지 않았습니다.");
		alert(e.message);
	}
	
})();
function getCerti(){
	 
 	$.ajax({
 		type: "GET",
 		url: "/mobilefirst/evt/ajax/ajax_get_certi.jsp",
 		dataType: "JSON",
 		success: function(json){
 			var cikeycnt = json.cikeyCnt;
 		}
 	});
}
function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2019%2Fcoupangevt.jsp%3Ffreetoken%3Devent";
	if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
		goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2019/coupangevt.jsp?freetoken=event";
		chrome25 = uagentLow.search("chrome") > -1 && navigator.appVersion.match(/Chrome\/\d+.\d+/)[0].split("/")[1] > 25;
		kitkatWebview = uagentLow.indexOf("naver") != -1 || uagentLow.indexOf("daum") != -1; 
		setTimeout( function() {
			if (new Date - openAt < 1001) {
				if (uagentLow.search("android") > -1) {
					location.href = "market://details?id=com.enuri.android";
				}
			}
		}, 1000);
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
			window.open("https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8");
		}, 1000);
		location.href = goApp;
	}
}
function inner() {
	$('html, body').animate({scrollTop: Math.ceil($('#'+tapType).offset().top-$("#topFix").height())}, 1000);
}

function GA(label){
	ga('send', 'event', 'mf_event', '쿠팡이벤트',label);		
}

function getGoodsList(){
	 
 	$.ajax({
 		type: "GET",
 		url: "/event/ajax/evt_coupang_goods_ajax.jsp?p=list",
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
 		 		var url = "/mobilefirst/detail.jsp?modelno="+modelno;
 		 		
 		 		GA("상품_#"+goodsnm);
 		 		
 		 		if( app == "Y" ){
 		 			
 		 			if(!islogin()){
 		 				alert("로그인 후 참여가능합니다.");
 		 				location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
 		 				return false;
 		 			}else{
 		 				/*
 		 			 	$.ajax({
 		 			 		type: "GET",
 		 			 		url: "/mobilefirst/evt/ajax/ajax_get_certi.jsp",
 		 			 		dataType: "JSON",
 		 			 		success: function(json){
 		 			 			var cikeycnt = json.cikeyCnt;
 		 			 			
 		 			 			if(cikeycnt > 0){
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
 		 				*/
 		 				location.href = url;
 		 			}
 		 			
 		 		}else{
 		 			onoff('app_only');
 		 		}
 		 	});
 		},
 		error: function (xhr, ajaxOptions, thrownError) {
 			alert("잘못된 접근입니다.");
 			//alert(thrownError);
 		}
 	});
}

function snsShare(){
	
	// 페이스북, 카카오톡 공유
	$(".share_area li").click(function(){
		
		if(!islogin()){
			alert("로그인 후 참여가능합니다.");
			location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
			return false;
		}
		
		var idx = $(this).index();
		GA('공유_PV');
		switch(idx) {
			case 1 :
				window.open("http://www.facebook.com/sharer.php?u=" + shareUrl);
				shareInsert(1);
				break;
			case 0 :
				$("#kakao-link-btn").trigger("click");
				shareInsert(2);
				break;
			case 2 :
				try{    
					shareInsert(4);
					window.android.android_window_open("http://twitter.com/intent/tweet?text="+encodeURIComponent(shareTitle)+"&url="+shareUrl); 
				}catch(e){
					window.open("http://twitter.com/intent/tweet?text="+encodeURIComponent(shareTitle)+"&url="+shareUrl);
				}
				
			case 3 : shareInsert(3);
			break;
		}
	});
	
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
function shareInsert(param) {
	$.ajax({
		type: "GET",
		url: "/mobilefirst/evt/ajax/shareEvt_proc.jsp",
		data: "shareType="+param+"&osType="+getOsType(),
		dataType: "JSON",
		success: function(json){
			
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert("잘못된 접근입니다.");

		}
	});
}
function commaNum(x) {
	var num;
	try{
		num = x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}catch(e){}
    return num; 
}
//페이지 이동
function goPage(pageno) {
	getEventList(pageno, PAGESIZE);
}
//게시판
function getEventList(varPageNo, varPageSize) {
	$.ajax({
		type: "GET",
		//url: "/event2016/mobile_award_getlist.jsp",
		//data: "p=office&pageno="+varPageNo+"&pagesize="+varPageSize+"&event_id="+event_id+"&del_yn=N",
		
 		url: "/mobilefirst/evt/ajax/crazydeal_shareEvt_proc.jsp",
		data: "p=office&pageno="+varPageNo+"&pagesize="+varPageSize+"&event_id="+event_id+"&del_yn=N&procCode=2",
		
		dataType: "JSON",
		success: function(json){
			$("#body_list").html(null);

			if(json.eventlist){
				var template = "";

				for(var i=0;i<json.eventlist.length;i++){
					if(i==0){
						totalcnt = json.eventlist[i].totalcnt;
					}
					var likeCnt = json.eventlist[i].cnt;

					if (likeCnt > 999) {
						likeCnt = 999;
					}
					var reply_date = json.eventlist[i].reply_date;
					var year = reply_date.substring(0,4);
					var month = reply_date.substring(6,4);
					var day = reply_date.substring(8,6);
					var user_id = json.eventlist[i].user_id;
					//var reply_msg = XSSfilter(json.eventlist[i].reply_msg);

					template += "<li>";
					template += "  <p class='user'>" + user_id + " <span class='date'>" + year +"-"+ month +"-"+ day + "</span></p>   ";
					template += "  <p class='cont'>비밀 댓글입니다.</p>";
					template += "</li>";
				}

				$("#body_list").html(template);

				var naviCnt = (totalcnt/varPageSize) + 1;

				if (totalcnt == 0) {
				} else {
					var paging2 = new paging(varPageNo, varPageSize, BLOCKSIZE, totalcnt, 'paginate','goPage');

				  	paging2.calcPage();
				  	paging2.getPaging();
					$("#paginate").find("a").click(boardTopMove);

				}
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert("잘못된 접근입니다.");
			//alert(thrownError);
		}
	});
}
function XSSfilter (content) {
	return content.replace(/\</g, "&lt;").replace(/\>/g, "&gt;");
}
function boardTopMove(){
	var offset = $("#replyMsg").offset();
	$('html, body').animate({scrollTop : offset.top});
}

//등록하기
function insertReplayMsg() {
	
	//ga('send','event', 'mf_event','19년 앱개편프로모션','댓글_등록하기');
	
	if(!islogin()){
		alert("로그인 후 참여가능합니다.");
		location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
		return false;
	}
	
	var replyMsg = $("#replyMsg").val();

	if (replyMsg.length < 1) {
		alert("내용을 입력해주세요!");
		return false;
	}

	var url = "/event2016/mobile_award_setlist.jsp";
	var vData = {replyMsg : replyMsg, event_id : event_id , osType:getOsType()};

	$.ajax({
        type: "POST",
        url: url,
        data: vData,
        dataType: "JSON",
        success: function(result){
        	 if (result.result == "true") {
        		alert("등록되었습니다!");
				goPage(PAGENO);
        	 }else if(result.result == -5){
				if (confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?") == true){    
					location.href="<%=ConfigManager.ENURI_COM_SSL%>/mobilefirst/member/myAuth.jsp?cmdType=modify&f=p";
				}else{
					return false;
				}
        	 }else if(result.result == -99){
        		 alert("임직원은 참여할 수 없습니다"); 
        	 } else {
				alert("오늘은 이미 참여해 주셨습니다! \n내일 또 남겨주세요~");
			 }
        	$("#replyMsg").val("");
        	$("#word_num").text(0);
        },
		error: function (xhr, ajaxOptions, thrownError) {

		}
    });
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
	welcomeGa("evt_coupang_view");    
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