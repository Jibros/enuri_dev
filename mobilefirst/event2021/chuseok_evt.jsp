<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
String strServerNm = request.getServerName();
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
	response.sendRedirect("/event2021/chuseok_evt.jsp"); //PC경로
    return;
}
SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMddHHmm");  //오늘 날짜
String strToday = formatter.format(new Date());
String chkId   = ChkNull.chkStr(request.getParameter("chk_id"),"");
String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String userNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK"),"");
String oc = ChkNull.chkStr(request.getParameter("oc"));
Members_Proc members_proc = new Members_Proc();
String userName = members_proc.getUserName(userId);
String userArea = userName;
String strUrl = request.getRequestURI();
if(!userId.equals("")){
    userName = members_proc.getUserName(userId);
    userArea = userName;
    if(userName.equals("")){
        userArea = userNick;
    }
    if(userArea.equals("")){
        userArea = userId;
    }
}

String tab = ChkNull.chkStr(request.getParameter("tab"));
String protab = ChkNull.chkStr(request.getParameter("protab"));

String strApp = ChkNull.chkStr(request.getParameter("app"),"");

Cookie[] carr = request.getCookies();
if(carr != null){
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("appYN")){
	      strApp = carr[i].getValue();
	      break;
	    }
	}
}
%>
<!doctype html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />

	<link rel="shortcut icon" href="http://img.enuri.info/2014/layout/favicon_enuri.ico">
	<title>에누리(가격비교) eNuri.com</title>
	<link rel="stylesheet" type="text/css" href="/css/slick.css">
	<link rel="stylesheet" type="text/css" href="/css/rev/common.css"/> <!-- reset -->
	<link rel="stylesheet" type="text/css" href="/css/rev/template.css"/> <!-- template -->
	<!-- 프로모션 공통 CSS (Mobile) -->
	<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
	<!-- 프로모션별 커스텀 CSS  -->
	<link rel="stylesheet" href="/css/event/y2021_rev/chuseok_pro_m.css" type="text/css">
	<script type="text/javascript" src="/common/js/lib/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
		<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
	<script type="text/javascript" src="/event2016/js/event_common.js?v=20210826"></script>
	<script>
	    var userId = "<%=userId%>";
	    var tab = "<%=tab%>"; //파라미터 tab
	    var username = "<%=userArea%>"; //개인화영역 이름
	    var vChkId = "<%=chkId%>";
	    var vEvent_page = "<%=strUrl%>"; //경로
	    var ssl = "<%=ConfigManager.ENURI_COM_SSL%>";
	    var tablo = "<%=protab%>";
	</script>
</head>
<body>
<div class="lay_only_mw" <%if(!strApp.equals("Y") && oc.equals("sns")){%><%}else{%>style="display:none;"<%} %>>
	<div class="lay_inner"> 
		<div class="lay_head">
			더 다양한 <em>이벤트 혜택</em>을 누리고 싶다면?
		</div>
		<!-- 버튼 : 에누리앱으로 보기 -->
		<button class="btn_go_app" onclick="install_btt();">에누리앱으로 보기</button>
		<!-- 버튼 : 모바일웹으로 보기 -->
		<a href="javascript:void(0);" class="btn_keep_mw" onclick="$('.lay_only_mw').fadeOut(100);">괜찮아요. 모바일 웹으로 볼래요</a>
	</div>
</div>

<div class="wrap">
	<div class="event_wrap">
		<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp" %>
		<!-- 플로팅 배너 - 둥둥이 -->
		<div id="floating_bnr" class="floating_bnr" onclick="ga_log(5);">
			<a href="javascript:///" id='float_btn'><img src="http://img.enuri.info/images/event/2021/chuseok/fl_bnr.png" alt="추석준비하고 횡성한우세트 받자!"></a>
			<!-- 닫기 -->
			<a href="#" class="btn_close" onclick="onoff('floating_bnr');return false;">
				<span class="blind">닫기</span>
			</a>
		</div>
		<!-- // -->
		<!-- visual -->
		<div class="section visual">
			<div class="inner">
				<div class="visual_obj_list">
					<div class="visual_obj obj_moon"></div>
					<div class="visual_obj animated obj_shooting_star1"></div>
					<div class="visual_obj animated obj_shooting_star2"></div>
					<div class="visual_obj animated obj_shooting_star3"></div>
					<div class="visual_obj animated obj_shooting_star4"></div>
					<div class="visual_obj animated obj_shooting_star5"></div>
				</div>

				<!-- 200330 추가 : 공통 : 공유하기 버튼  -->
				<button class="com__btn_share btn_white" onclick="$('.com__share_wrap').show();">공유하기</button>
				<!-- // -->
				<div class="react_text_area">
					<span class="txt_01">건강한 2021 추석 보내세요!</span>
					<span class="txt_02"><span>한가위</span> 에-누리다</span>
					<span class="txt_date">2021.08.23 ~ 2021.09.22</span>
				</div>
			</div>
			<script>
				$(window).load(function(){
					var $visual = $(".event_wrap .visual");
					setTimeout(function(){
						$visual.addClass("start");
					},500)
				})
			</script>
		</div>
		<!-- //visual -->

		<!-- 탭 -->
		<div class="section floattab">
			<div class="contents">
				<ul class="floattab__list">
					<li onclick="ga_log(2);"><a href="/mobilefirst/event2021/chuseok.jsp" class="">매일매일<em>윷놀이</em></a></li>
					<li onclick="ga_log(3);"><a href="/mobilefirst/event2021/chuseok_deal.jsp" class="">매주 수요일<em>타임특가</em></a></li>
					<li onclick="ga_log(4);"><a href="/mobilefirst/event2021/chuseok_evt.jsp" class="active">풍요로운<em>추석 기획전</em></a></li>
				</ul>
			</div>
		</div>
		<!-- /탭 -->

		<!-- 중단배너 -->
		<div class="mid_banner">
			<a href="#프로모션 이동" target="_blank" title="새 창으로 이동합니다."><img src="http://img.enuri.info/images/event/2021/chuseok/mobile/m_mid_banner.png" alt="건강한 2021 추석 보내세요!" /></a>
		</div>
		<!-- 중단배너 -->

		<!-- 중단 상품 영역 -->
		<div class="pro_itemlist">
			<!-- 추석선물 -->
			<div id="evt2" class="item_group item_group_01 scroll">
				<h3>
					<div class="deco_line">
						<span class="color1"></span>
						<span class="color2"></span>
						<span class="color3"></span>
						<span class="color4"></span>
					</div>
					<span class="txt_sub">이번엔 어떤 선물? 이제는 결정해야할 때!</span>
					<strong class="txt_tit">BEST 추석 선물</strong>
				</h3>
				<!-- 추천상품 탭 -->
				<ul class="pro_tabs">
					<li class="active" onclick="ga_log(13);"><a href="#protab1-1">정육/축산</a></li>
					<li onclick="ga_log(14);"><a href="#protab1-2">농산/수산</a></li>
					<li onclick="ga_log(15);"><a href="#protab1-3">건강식품</a></li>
					<li onclick="ga_log(16);"><a href="#protab1-4">상품권</a></li>
				</ul>
				<!-- //추천상품 탭 -->

				<!-- 추천상품 템플릿 -->
				<div class="tab_container" >
					<!--
						SLICK $(".itemlist")
						4개의 탭 콘텐츠가 있습니다. "tab_content"
						하나의 콘텐츠마다 ul 단위로 한 판(상품6개)씩 움직입니다.
					-->
					<!-- 정육/축산 상품-->
					<div id="protab1-1" class="tab_content">
						<div class="itemlist" onclick="ga_log(17);">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="btn_more" onclick="ga_log(18);" href="/m/list.jsp?cate=150306">상품더보기</a>
					</div>
					<!-- //정육/축산 상품-->

					<!-- 농산/수산 상품-->
					<div id="protab1-2" class="tab_content">
						<div class="itemlist"  onclick="ga_log(17);">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="btn_more" onclick="ga_log(18);"  href="/m/list.jsp?cate=150203">상품더보기</a>
					</div>
					<!-- //농산/수산 상품-->

					<!-- 건강식품 상품 -->
					<div id="protab1-3" class="tab_content">
						<div class="itemlist"  onclick="ga_log(17);">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="btn_more" onclick="ga_log(18);" href="/m/list.jsp?cate=1501">상품더보기</a>
					</div>
					<!-- //건강식품 상품 -->

					<!-- 상품권 -->
					<div id="protab1-4" class="tab_content">
						<div class="itemlist"  onclick="ga_log(17);">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="btn_more" onclick="ga_log(18);" href="/m/list.jsp?cate=164715">상품더보기</a>
					</div>
					<!-- //상품권 -->
				</div>
				<!-- //추천상품 템플릿 -->
			</div>
			<!-- //추석선물 -->

			<!-- 금액대별 맞춤 선물 -->
			<div id="evt3" class="item_group item_group_02 scroll">
				<h3>
					<div class="deco_line">
						<span class="color1"></span>
						<span class="color2"></span>
						<span class="color3"></span>
						<span class="color4"></span>
					</div>
					<span class="txt_sub">부담 없는 선물을 찾는다면?</span>
					<strong class="txt_tit">금액대별 맞춤 선물</strong>
				</h3>
				<!-- 금액대별 맞춤 선물 탭 -->
				<ul class="pro_tabs">
					<li onclick="ga_log(19);" class="active"><a href="#protab2-1">3만원 이하</a></li>
					<li onclick="ga_log(20);"><a href="#protab2-2">3만원~5만원</a></li>
					<li onclick="ga_log(21);"><a href="#protab2-3">5만원~10만원</a></li>
					<li onclick="ga_log(22);"><a href="#protab2-4">10만원 이상</a></li>
				</ul>
				<!-- //금액대별 맞춤 선물 탭 -->

				<!-- 금액대별 맞춤 선물 템플릿 -->
				<div class="tab_container">
					<!-- 3만원이하 -->
					<div id="protab2-1" class="tab_content">
						<div class="itemlist" onclick="ga_log(23);">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="btn_more" onclick="ga_log(24);" href="/m/list.jsp?cate=151110">상품더보기</a>
					</div>
					<!-- //3만원이하 상품 -->

					<!-- 3만원~5만원 상품 -->
					<div id="protab2-2" class="tab_content">
						<div class="itemlist" onclick="ga_log(23);">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(24);" href="/m/list.jsp?cate=150808">상품더보기</a>
					</div>
					<!-- //3만원~5만원 상품 -->

					<!-- 5만원~10만원 상품 -->
					<div id="protab2-3" class="tab_content">
						<div class="itemlist" onclick="ga_log(23);">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(24);" href="/m/list.jsp?cate=150105">상품더보기</a>
					</div>
					<!-- //5만원~10만원 상품 -->

					<!-- 10만원이상 상품 -->
					<div id="protab2-4" class="tab_content">
						<div class="itemlist" onclick="ga_log(23);">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(24);" href="/m/list.jsp?cate=0318">상품더보기</a>
					</div>
					<!-- //10만원이상 상품 -->
				</div>
				<!-- //금액대별 맞춤 선물 템플릿 -->
			</div>
			<!-- //금액대별 맞춤 선물 -->

			<!-- 건강한 추선준비 탭 -->
			<div id="evt4" class="item_group item_group_03 scroll">
				<h3>
					<div class="deco_line">
						<span class="color1"></span>
						<span class="color2"></span>
						<span class="color3"></span>
						<span class="color4"></span>
					</div>
					<span class="txt_sub">나홀로 추석에도 추석 음식 포기 못해</span>
					<strong class="txt_tit">건강한 추석 준비</strong>
				</h3>
				<!-- 추선준비 탭 -->
				<ul class="pro_tabs">
					<li onclick="ga_log(25);" class="active"><a href="#protab3-1">명절준비</a></li>
					<li onclick="ga_log(26);"><a href="#protab3-2">신선식품</a></li>
					<li onclick="ga_log(27);"><a href="#protab3-3">생활용품</a></li>
					<li onclick="ga_log(28);"><a href="#protab3-4">건강관리</a></li>
				</ul>
				<!-- //추선준비 탭 -->

				<!-- 추선준비 템플릿 -->
				<div class="tab_container">
					<!-- 명절준비 상품 -->
					<div id="protab3-1" class="tab_content">
						<div class="itemlist" onclick="ga_log(29);">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="btn_more" onclick="ga_log(30);" href="/m/list.jsp?cate=16561501">상품더보기</a>
					</div>
					<!-- //명절준비 상품 -->

					<!-- 신선식품 상품 -->
					<div id="protab3-2" class="tab_content">
						<div class="itemlist" onclick="ga_log(29);">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(30);"href="/m/list.jsp?cate=150203">상품더보기</a>
					</div>
					<!-- //신선식품 상품 -->

					<!-- 생활용품 상품 -->
					<div id="protab3-3" class="tab_content">
						<div class="itemlist" onclick="ga_log(29);">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(30);"href="/m/list.jsp?cate=165609">상품더보기</a>
					</div>
					<!-- //생활용품 상품 -->

					<!-- 건강관리 상품 -->
					<div id="protab3-4" class="tab_content">
						<div class="itemlist" onclick="ga_log(29);">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(30);" href="/m/list.jsp?cate=0515">상품더보기</a>
					</div>
					<!-- //건강관리 상품 -->
				</div>
				<!-- //추선준비 템플릿 -->
			</div>
			<!-- // 건강한 추선준비 탭 -->

			<!-- 즐거운 집콕 추석 -->
			<div id="evt5" class="item_group item_group_04 scroll">
				<h3>
					<div class="deco_line">
						<span class="color1"></span>
						<span class="color2"></span>
						<span class="color3"></span>
						<span class="color4"></span>
					</div>
					<span class="txt_sub">'혼추족'이라도 괜찮아, 댕냥이와 함께라면</span>
					<strong class="txt_tit">즐거운 집콕 추석</strong>
				</h3>
				<!-- 집콕 탭 -->
				<ul class="pro_tabs">
					<li onclick="ga_log(31);" class="active"><a href="#protab4-1">E쿠폰</a></li>
					<li onclick="ga_log(32);"><a href="#protab4-2">컴퓨터/게임기</a></li>
					<li onclick="ga_log(33);"><a href="#protab4-3">간편식품</a></li>
					<li onclick="ga_log(34);"><a href="#protab4-4">댕냥이 간식</a></li>
				</ul>
				<!-- //집콕 탭 -->

				<!-- 집콕 템플릿 -->
				<div class="tab_container">
					<!-- e쿠폰 상품 -->
					<div id="protab4-1" class="tab_content">
						<div class="itemlist" onclick="ga_log(35);">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="btn_more" onclick="ga_log(36);" href="/m/list.jsp?cate=164721">상품더보기</a>
					</div>
					<!-- //e쿠폰 상품 -->

					<!-- 컴퓨터/게임기 상품 -->
					<div id="protab4-2" class="tab_content">
						<div class="itemlist" onclick="ga_log(35);">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(36);" href="/m/list.jsp?cate=0408">상품더보기</a>
					</div>
					<!-- //컴퓨터/게임기 상품 -->

					<!-- 간편식품 상품 -->
					<div id="protab4-3" class="tab_content">
						<div class="itemlist" onclick="ga_log(35);">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(36);" href="/m/list.jsp?cate=1516">상품더보기</a>
					</div>
					<!-- //간편식품 상품 -->

					<!-- 댕냥이간식 상품 -->
					<div id="protab4-4" class="tab_content">
						<div class="itemlist" onclick="ga_log(35);">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(36);" href="/m/list.jsp?cate=164224">상품더보기</a>
					</div>
					<!-- //댕냥이간식 상품 -->
				</div>
				<!-- //집콕 템플릿 -->
			</div>
			<!-- //즐거운 집콕 추석 -->
		</div>
		<!-- //중단 상품 영역 -->

		<!-- 에누리 혜택 -->
		<div class="otherbene">
			<div class="contents">
				<h3><img src="http://img.enuri.info/images/event/2021/chuseok/mobile/m_benefit_tit.png" alt="놓칠 수  없는 특별한 혜택, 에누리 혜택"></h3>
				<ul class="banlist">
					<li>
						<a href="/event2020/welcome_evt.jsp" target="_blank" title="새창으로 이동">
							<div class="tx1">첫 구매 고객이라면!</div>
							<div class="tx2">WELCOME 혜택</div>
							<div class="comm_btn"><img src="http://img.enuri.info/images/event/2021/chuseok/mobile/m_other_btn.png"></div>
						</a>
					</li>
					<li>
						<a href="/evt/visit.jsp#evt1" target="_blank" title="새창으로 이동">
							<div class="tx1">100% 당첨! 매일받는 e머니</div>
							<div class="tx2">도전! 프로출첵러</div>
							<div class="comm_btn"><img src="http://img.enuri.info/images/event/2021/chuseok/mobile/m_other_btn.png"></div>
						</a>
					</li>
					<li>
						<a href="/m/event/buy_stamp.jsp#tab4" target="_blank" title="새창으로 이동">
							<div class="tx1">받고 또 받는 카테고리 혜택</div>
							<div class="tx2">추가 적립 5만점</div>
							<div class="comm_btn"><img src="http://img.enuri.info/images/event/2021/chuseok/mobile/m_other_btn.png"></div>
						</a>
					</li>
					<li>
						<a href="/mobilefirst/plan_event.jsp?freetoken=main_tab|event" target="_blank" title="새창으로 이동">
							<div class="tx1">끝나지 않은 에누리 혜택</div>
							<div class="tx2">더 많은 이벤트</div>
							<div class="comm_btn"><img src="http://img.enuri.info/images/event/2021/chuseok/mobile/m_other_btn.png"></div>
						</a>
					</li>
				</ul>
			</div>
		</div>
		<!-- //에누리 혜택 -->

		<!-- 200330 추가 : 공통 : SNS공유하기 -->
		<div class="com__share_wrap dim" style="z-index:10000;display:none">
			<div class="com__layer share_layer">
				<div class="lay_head">공유하기</div>
				<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
				<div class="lay_inner">
					<ul>
						<li class="share_fb">페이스북 공유하기</li>
						<li class="share_kakao"  id="kakao-share-btn">카카오톡 공유하기</li>
						<li class="share_tw">트위터 공유하기</li> 
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
								<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2021/chuseok_evt.jsp</span>
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
	</div>
	<!-- // 프로모션 -->

	<!--<a href="#top" class="btn_top"><i>TOP</i></a>-->
	<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20190611"></script>
	<script type="text/javascript" src="/mobilefirst/event/js/exhibition_m.js"></script>
	<script>
	var vEvent_title = "21년 추석 기획전";
	var gaLabel = [  vEvent_title+"_PV"
			,vEvent_title+"_상단탭_단순참여 이벤트"
			,vEvent_title+"_상단탭_타임딜"
			,vEvent_title+"_상단탭_기획전"
			,vEvent_title+"_상단플로팅배너"
			,vEvent_title+"_참여이벤트_참여"
			,vEvent_title+"_혜택배너"
			,vEvent_title+"_타임딜_상품보기"
			,vEvent_title+"_타임딜_APP구매하기"
			,vEvent_title+"_타임딜_썸네일"
			,vEvent_title+"_구매이벤트_기획전 이동"
			,vEvent_title+"_구매이벤트_참여"
			,vEvent_title+"_BEST추석선물_정육/축산"
			,vEvent_title+"_BEST추석선물_농산/수산"
			,vEvent_title+"_BEST추석선물_건강식품"
			,vEvent_title+"_BEST추석선물_상품권"
			,vEvent_title+"_BEST추석선물_상품클릭"
			,vEvent_title+"_BEST추석선물_더보기"
			,vEvent_title+"_금액대별맞춤선물_3만원 이하"
			,vEvent_title+"_금액대별맞춤선물_3만원~5만원"
			,vEvent_title+"_금액대별맞춤선물_5만원~10만원"
			,vEvent_title+"_금액대별맞춤선물_10만원 이상"
			,vEvent_title+"_금액대별맞춤선물_상품클릭"
			,vEvent_title+"_금액대별맞춤선물_더보기"
			,vEvent_title+"_건강한추석준비_명절준비"
			,vEvent_title+"_건강한추석준비_신선식품"
			,vEvent_title+"_건강한추석준비_생활용품"
			,vEvent_title+"_건강한추석준비_건강관리"
			,vEvent_title+"_건강한추석준비_상품클릭"
			,vEvent_title+"_건강한추석준비_더보기"
			,vEvent_title+"_즐거운집콕추석_e쿠폰"
			,vEvent_title+"_즐거운집콕추석_컴퓨터/게임기"
			,vEvent_title+"_즐거운집콕추석_간편식품"
			,vEvent_title+"_즐거운집콕추석_댕냥이간식"
			,vEvent_title+"_즐거운집콕추석_상품클릭"
			,vEvent_title+"_차가워템_더보기"
	];
		$(document).ready(function(){
			$("#floating_bnr").click(function(){
				//ga_log(5);
				//딜페이지 경로 수정
				location.href = "/mobilefirst/event2021/chuseok_deal.jsp?tab=03";
				return false;
			});	

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
			
			if(!islogin()){
				$(".myarea").html("<p class='name'>로그인 후 더 많은 혜택을 누리세요.<button type='button' class='btn_login' onclick='goLogin();''>로그인</button></p>");
			}else{
				$(".myarea .name").html($(".myarea .name").html().replace(" 님"," 님 환영합니다.") );
			}
			
			//상품 영역
			var loadUrl = "/event/ajax/exhibition_ajax.jsp?exh_id=48"; 

			$.ajax({
				  dataType : "json"
				, url	   : loadUrl
				, cache : false
				, success  : function(result){
					var banner = result.R;
					var tab = result.T;
					var tabSize = 4; //컨텐츠 별 탭 개수
					var listSize = 4; //노출 상품 개수
					var logNo = [16,21,26,31];
					var no = 0;
					var minprice = 0;

					for(var idx = 0; idx < tab.length; idx ++){
						makeHtml = "";
						no = logNo[parseInt(idx/tabSize)];
						$.each(tab[idx].GOODS, function(i,v){ 
							minprice = (v.MINPRICE == null) ? 0 : v.MINPRICE;

							if((i % listSize) == 0)	makeHtml += "<ul class='items clearfix'>";
							makeHtml += "<li class='item'>";
							makeHtml +=	"	<a href='javascript:void(0);' onclick='itemClick("+v.MODELNO+", "+minprice+"); !ga_log("+no+")'>";
							makeHtml +=	"		<span class='thumb'>";
							makeHtml += "			<img src='"+v.GOODS_IMG+"' alt='상품이미지' onerror = 'replaceImg(this);'>";
							if(minprice == 0 || minprice == null) makeHtml += "<span class='soldout'>soldout</span> <!-- 품절시 노출 -->";
							makeHtml +=	"		</span>";
							makeHtml +=	"		<span class='pro_info'>";
							makeHtml +=	"			<span class='pro_name'>"+v.TITLE1+"<br>"+v.TITLE2+"</span>";
							makeHtml +=	"			<span class='price'>";
							makeHtml +=	"				<span class='price_label'>최저가</span>";
							makeHtml +=	"				<em>"+commaNum(minprice)+"</em>";
							makeHtml +=	"				<span class='pro_unit'>원</span>";
							makeHtml +=	"			</span>";
							makeHtml +=	"		</span>";
							makeHtml +=	"	</a>";
							makeHtml += "</li>";
						  
							if(i % listSize == (listSize - 1) || i == tab[idx].GOODS.length) makeHtml += "</ul>";
						});
						$('#protab'+ (parseInt((idx / tabSize) + 1)) + '-' + ((idx % tabSize) + 1) +' .itemlist').html(makeHtml);
					}
				}
				, complete : function(){
					$navHgt = Math.ceil($(".floattab__list").height());

					//상품 슬릭
					prodSlick();
					
					 if(tablo == '2'){
						$('html, body').stop().animate({scrollTop: Math.ceil($('#evt2').offset().top- $(".floattab").outerHeight())}, 0);
					}else if(tablo == '3'){
						$('html, body').stop().animate({scrollTop: Math.ceil($('#evt3').offset().top- $(".floattab").outerHeight())}, 0);
					}else if(tablo == '4'){
						$('html, body').stop().animate({scrollTop: Math.ceil($('#evt4').offset().top- $(".floattab").outerHeight())}, 0);
					}else if(tablo == '5'){
						$('html, body').stop().animate({scrollTop: Math.ceil($('#evt5').offset().top- $(".floattab").outerHeight())}, 0);
					}
		 		}
			});
		});
		
		(function (global, $) {
			// 상단 메뉴 스크롤 시, 고정
			var $nav = $('.floattab'),
					$menu = $('.floattab__list li'),
					$flyingbnr = $(".floating_bnr"),
					// $contents = $('.scroll'),
					$navheight = $nav.outerHeight(), // 상단 메뉴 높이
					$navtop = Math.ceil($nav.offset().top); // floattab 현재 위치;

			// menu class 추가
			$(window).scroll(function () {
				var $scltop = Math.ceil($(window).scrollTop());	// 현재 scroll

				if ($scltop > $navtop-260) $flyingbnr.addClass("is-fixed")
				else $flyingbnr.removeClass("is-fixed");

				if ($scltop > $navtop) {
					$nav.addClass("is-fixed");
					$(".visual").css("margin-bottom", $navheight);
				} else {
					$nav.removeClass("is-fixed");
					$menu.children("a").removeClass('is-on');
					$(".visual").css("margin-bottom", 0);
				}
			});
		}(window, window.jQuery));

		// 유의사항 열기/닫기
		$(function(){
			var el = {
				btnSlide: $(".btn__evt_on_slide"), // 열기 버튼
				btnSlideClose : $(".btn__evt_off_slide") // 닫기 버튼
			}
			el.btnSlide.click(function(){ // 슬라이드 유의사항 열기
				$(this).toggleClass('on');
				$("#"+$(this).attr("data-laypop-id")).slideToggle();
			})
			el.btnSlideClose.click(function(){ // 슬라이드 유의사항 닫기
				var thisClosest = $(this).closest('.evt_slide')
				$(thisClosest).slideToggle();
				$('html,body').stop(0).animate({scrollTop:$(thisClosest).siblings(".com__evt_notice").offset().top - 50});
			})
		})

		/*레이어*/
		function onoff(id) {
			var mid=document.getElementById(id);
			if(mid.style.display=='') {
				mid.style.display='none';
			}else{
				mid.style.display='';
			}
		}
		function install_btt(){ 
			if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
		        window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8';
		    }else if(navigator.userAgent.indexOf("Android") > -1){
		    	window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
		    }
		}
		//상품 탭, 슬라이트 관련
		function prodSlick(){
			var slickSlide = function(el){
				var $wrap = $(el);
				// 탭초기화
				$wrap.find(".tab_content").hide();
				$wrap.find("ul.pro_tabs li").eq(0).addClass("active").show();
				$wrap.find(".tab_content").eq(0).show();
				// 슬라이드 실행
				var proSlide = $(el + ' .itemlist').slick({
					dots:true,
					slidesToScroll: 1
				});
				// 클릭이벤트
				$wrap.find("ul.pro_tabs li").click(function() {
					if ( !$(this).hasClass("active") ){
						$wrap.find("ul.pro_tabs li").removeClass("active");
						$(this).addClass("active")
						$wrap.find(".tab_content").hide();
						var activeTab = $(this).find("a").attr("href");
						$(activeTab).fadeIn();
						proSlide.slick("setPosition");
					}
					return false;
				});
			}
			// 슬라이드 실행
			var slide1 = new slickSlide('.item_group_01');
			var slide2 = new slickSlide('.item_group_02');
			var slide3 = new slickSlide('.item_group_03');
			var slide4 = new slickSlide('.item_group_04');
			var slide5 = new slickSlide('.item_group_05');
		}
		
		//sns 공유하기 함수
		function shareSns(param){ //수정
			var share_url = "http://" + location.host + "/mobilefirst/event2021/chuseok_evt.jsp";
			var share_title = "[에누리 가격비교] 한가위에에누리다!";
			var share_description = "매주 수요일 타임특가도 만나보세요!";
			var imgSNS = "http://img.enuri.info/images/event/2021/chuseok/sns_1200_630.jpg";
			
			if(param == "face"){
				try{
					window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
				}catch(e){
					window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
				}
			}else if(param == "kakao"){
				imgSNS = "http://img.enuri.info/images/event/2021/chuseok/sns_1200_630.jpg";
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
				var share_title_twi = "[에누리 가격비교] 한가위누리다! 매주 수요일 타임특가도 만나보세요!";
				window.open("https://twitter.com/intent/tweet?text="+encodeURIComponent(share_title_twi)+"&url="+share_url);
			}
		}
	</script>
	<script>
		// 애니메이션
		var areaWin = $(window);
		var lastScroll = 0;
		function isScrolledIntoView(target, check) {
			var docViewTop = areaWin.scrollTop();
			var docViewBottom = docViewTop + areaWin.height();
			var elemTop = target.offset().top;
			// return (docViewBottom >= elemTop);
			var animate_nm = target.data('animate');

			if(animate_nm === 'slideup') {
				if(check === 'down') {
					elemTop = elemTop-target.height();
				}
				return (docViewBottom >= elemTop);
			} else {
				return (docViewBottom >= elemTop);
			}
		}
		$('.animated').each(function(index, item) {
			var animate_nm = $(item).data('animate');
			var animate_duration = "duration__" + $(item).data('duration');
			var animate_class = "";
			switch(animate_nm) {
				case "slideleft":
					animate_class = 'slideInLeft'
					break;
				case "slideright":
					animate_class = 'slideInRight'
					break;
				case "slideup":
					animate_class = 'slideInUp'
					break;
			}

			var position = $(window).scrollTop();
			$(document).on("scroll", function () {
				var scroll = $(window).scrollTop();
				if(scroll > position) {
					var wheelcontrol = 'down'
				} else {
					var wheelcontrol = 'up'
				}
				position = scroll;

				if (isScrolledIntoView($(item),wheelcontrol)) {
					$(item).addClass(animate_class+" "+ (animate_duration ? animate_duration : ''));
				} 
				if (!isScrolledIntoView($(item),wheelcontrol)) {
					$(item).removeClass(animate_class+" "+ (animate_duration ? animate_duration : ''));
				}
			});
		});
		ga_log(1);
	</script>
	<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
	<script type="text/javascript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</div>
</body>
</html>