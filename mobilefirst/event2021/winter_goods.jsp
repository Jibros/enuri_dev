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
	response.sendRedirect("/event2021/winter_goods.jsp"); //PC경로
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
	<meta property="og:title" content="2021 월동준비 통합기획전 – 최저가 쇼핑은 에누리">
	<meta property="og:description" content="온 가족 타임특가! 매주 수요일마다 터지는 득템의 기회! ">
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />

	<link rel="shortcut icon" href="http://img.enuri.info/2014/layout/favicon_enuri.ico">
	<title>2021 월동준비 통합기획전 – 최저가 쇼핑은 에누리</title>
	<link rel="stylesheet" type="text/css" href="/css/slick.css">
	<link rel="stylesheet" type="text/css" href="/css/rev/common.css"/> <!-- reset -->
	<link rel="stylesheet" type="text/css" href="/css/rev/template.css"/> <!-- template -->
	<!-- 프로모션 공통 CSS (Mobile) -->
	<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
	<!-- 프로모션별 커스텀 CSS  -->
	<link rel="stylesheet" href="/css/event/y2021_rev/winter_pro_m.css" type="text/css">
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
<div class="lay_only_mw"  <%if(!strApp.equals("Y") && oc.equals("sns")){%><%}else{%>style="display:none;"<%} %>>>
	<div class="lay_inner">
		<div class="lay_head">
			더 다양한 <em>이벤트 혜택</em>을 누리고 싶다면?
		</div>
		<!-- 버튼 : 에누리앱으로 보기 -->
		<button class="btn_go_app" onclick="alert('APP으로 보기');">에누리앱으로 보기</button>
		<!-- 버튼 : 모바일웹으로 보기 -->
		<a href="javascript:void(0);" class="btn_keep_mw" onclick="$('.lay_only_mw').fadeOut(100);">괜찮아요. 모바일 웹으로 볼래요</a>
	</div>
</div>

<div class="wrap">
	<div class="event_wrap">
		<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp" %>
		<!-- 플로팅 배너 - 둥둥이 -->
		<div id="floating_bnr" class="floating_bnr">
			<a href="#프로모션 이동" target="_blank" title="새 창으로 이동합니다."><img src="http://img.enuri.info/images/event/2021/winter_pro/m_fl_bnr.png" alt="월동 준비하고 상품권 득템하자!"></a>
			<!-- 닫기 -->
			<a href="#" class="btn_close" onclick="onoff('floating_bnr');return false;">
				<span class="blind">닫기</span>
			</a>
		</div>
		<!-- // -->

		<!-- visual -->
		<div class="section visual">
			<div class="visual_obj_list">
				<div class="visual_obj obj_snow1"></div>
				<div class="visual_obj obj_snow2"></div>
				<div class="visual_obj obj_human"></div>
			</div>
			<div class="inner">
				<!-- 200330 추가 : 공통 : 공유하기 버튼  -->
				<button class="com__btn_share btn_white" onclick="$('.com__share_wrap').show();">공유하기</button>
				<!-- // -->
				<div class="react_text_area">
					<span class="txt_01">월동준비</span>
					<span class="txt_02"><span>겨울</span>에-누리다</span>
					<span class="txt_date">2021.11.1 ~ 2021.11.28</span>
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
					<li onclick="ga_log(2);"><a href="/mobilefirst/event2021/winter_2021_evt.jsp" class="">군고구마 찾으면<em>라떼당첨!</em></a></li>
					<li onclick="ga_log(3);"><a href="/mobilefirst/event2021/winter_deal.jsp" class="">매주 수요일 <em>타임특가</em></a></li>
					<li id="tab3"><a href="javascript:;" class="active">따뜻한 겨울을 위한 <em>준비템</em></a></li>
				</ul>
			</div>
		</div>
		<!-- /탭 -->

		<!-- 중단배너 -->
		<div class="mid_banner">
			<a href="#프로모션 이동" target="_blank" title="새 창으로 이동합니다."><img src="http://img.enuri.info/images/event/2021/winter_pro/m_mid_banner.png" alt="추운 겨울바람을 녹이는 월동준비 완료!, 따뜻한 겨울나기 쇼핑 가이드" /></a>
		</div>
		<!-- 중단배너 -->

		<!-- 중단 상품 영역 -->
		<div class="pro_itemlist">
			<!-- 월동준비 -->
			<div  id="evt2" class="item_group item_group_01 scroll" id="pro_itemlist">
				<h3>
					<span class="txt_sub">추훈 겨울바람, 이젠 두렵지 않아</span>
					<strong class="txt_tit">월동준비</strong>
				</h3>
				<!-- 월동준비 탭메뉴 -->
				<ul class="pro_tabs">
					<li class="active" onclick="ga_log(14);"><a href="#protab1-1">히터/온풍기</a></li>
					<li onclick="ga_log(15);"><a href="#protab1-2">가습기</a></li>
					<li onclick="ga_log(16);"><a href="#protab1-3">방한용품</a></li>
				</ul>
				<!-- //월동준비 탭 -->

				<!-- 월동준비 탭컨텐츠 -->
				<div class="tab_container" onclick="ga_log(17);">
					<!--
						SLICK $(".itemlist")
						4개의 탭 콘텐츠가 있습니다. "tab_content"
						하나의 콘텐츠마다 ul 단위로 한 판(상품6개)씩 움직입니다.
					-->
					<!-- 히터/온풍기 상품-->
					<div id="protab1-1" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="btn_more" onclick="ga_log(18);" href="http://m.enuri.com/m/list.jsp?cate=2405">상품더보기</a>
					</div>
					<!-- //히터/온풍기 상품-->

					<!-- 가습기 상품-->
					<div id="protab1-2" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="btn_more" onclick="ga_log(18);"  href="http://m.enuri.com/m/list.jsp?cate=2403">상품더보기</a>
					</div>
					<!-- //가습기 상품-->

					<!-- 방한용품 상품 -->
					<div id="protab1-3" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="btn_more" onclick="ga_log(18);" href="http://m.enuri.com/m/list.jsp?cate=145704">상품더보기</a>
					</div>
					<!-- //방한용품 상품 -->
				</div>
				<!-- //월동준비 탭컨텐츠 -->
			</div>
			<!-- //월동준비 -->

			<!-- 겨울꿀잠템 -->
			<div id="evt3" class="item_group item_group_02 scroll">
				<h3>
					<span class="txt_sub">포근한 침실로 꾸며줄게</span>
					<strong class="txt_tit">겨울꿀잠템</strong>
				</h3>
				<!-- 겨울꿀잠템 탭메뉴 -->
				<ul class="pro_tabs">
					<li class="active" onclick="ga_log(19);"><a href="#protab2-1">온수/전기 매트</a></li>
					<li onclick="ga_log(20);"><a href="#protab2-2">난방텐트</a></li>
					<li onclick="ga_log(21);"><a href="#protab2-3">단열필름</a></li>
				</ul>
				<!-- //겨울꿀잠템 탭메뉴 -->

				<!-- 겨울꿀잠템 탭컨텐츠 -->
				<div class="tab_container" onclick="ga_log(22);">
					<!-- 온수/전기 매트 -->
					<div id="protab2-1" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="btn_more" onclick="ga_log(23);" href="http://m.enuri.com/m/list.jsp?cate=2404">상품더보기</a>
					</div>
					<!-- //온수/전기 매트 상품 -->

					<!-- 난방텐트 상품 -->
					<div id="protab2-2" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(23);" href="http://m.enuri.com/m/list.jsp?cate=12262401">상품더보기</a>
					</div>
					<!-- //난방텐트 상품 -->

					<!-- 단열필름 상품 -->
					<div id="protab2-3" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(23);" href="http://m.enuri.com/m/list.jsp?cate=12262406">상품더보기</a>
					</div>
					<!-- //단열필름 상품 -->
				</div>
				<!-- //겨울꿀잠템 탭컨텐츠 -->
			</div>
			<!-- //겨울꿀잠템 -->

			<!-- 건강지키미템 -->
			<div id="evt4" class="item_group item_group_03 scroll">
				<h3>
					<span class="txt_sub">콜록콜록 아프기 전에 미리미리</span>
					<strong class="txt_tit">건강지키미템</strong>
				</h3>
				<!-- 건강지키미템 탭메뉴 -->
				<ul class="pro_tabs">
					<li class="active" onclick="ga_log(24);"><a href="#protab3-1">마스크</a></li>
					<li onclick="ga_log(25);"><a href="#protab3-2">공기살균기</a></li>
					<li onclick="ga_log(26);"><a href="#protab3-3">건강식품</a></li>
				</ul>
				<!-- //건강지키미템 탭메뉴 -->

				<!-- 건강지키미템 탭컨텐츠 -->
				<div class="tab_container" onclick="ga_log(27);">
					<!-- 마스크 상품 -->
					<div id="protab3-1" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="btn_more" onclick="ga_log(28);" href="http://m.enuri.com/m/list.jsp?cate=16360425">상품더보기</a>
					</div>
					<!-- //마스크 상품 -->

					<!-- 공기살균기 상품 -->
					<div id="protab3-2" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(28);" href="http://m.enuri.com/m/list.jsp?cate=240631">상품더보기</a>
					</div>
					<!-- //공기살균기 상품 -->

					<!-- 건강식품 상품 -->
					<div id="protab3-3" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(28);"  href="http://m.enuri.com/m/list.jsp?cate=150101">상품더보기</a>
					</div>
					<!-- //건강식품 상품 -->
				</div>
				<!-- //건강지키미템 탭컨텐츠 -->
			</div>
			<!-- // 건강지키미템 -->

			<!-- 겨울별미 -->
			<div id="evt5" class="item_group item_group_04 scroll">
				<h3>
					<span class="txt_sub">배가 든든해야 덜 추워~</span>
					<strong class="txt_tit">겨울별미</strong>
				</h3>
				<!-- 겨울별미 탭메뉴 -->
				<ul class="pro_tabs">
					<li class="active" onclick="ga_log(29);"><a href="#protab4-1">겨울간식</a></li>
					<li onclick="ga_log(30);"><a href="#protab4-2">e쿠폰</a></li>
					<li onclick="ga_log(31);"><a href="#protab4-3">김장</a></li>
				</ul>
				<!-- //겨울별미 탭메뉴 -->

				<!-- 겨울별미 탭컨텐츠 -->
				<div class="tab_container" onclick="ga_log(32);">
					<!-- 겨울간식 상품 -->
					<div id="protab4-1" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="btn_more" onclick="ga_log(33);" href="http://m.enuri.com/m/list.jsp?cate=15081307">상품더보기</a>
					</div>
					<!-- //겨울간식 상품 -->

					<!-- e쿠폰 상품 -->
					<div id="protab4-2" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(33);" href="http://m.enuri.com/m/list.jsp?cate=164721">상품더보기</a>
					</div>
					<!-- //e쿠폰 상품 -->

					<!-- 김장 상품 -->
					<div id="protab4-3" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
							<ul class="items clearfix">
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(33);" href="http://m.enuri.com/m/list.jsp?cate=15021504">상품더보기</a>
					</div>
					<!-- //김장 상품 -->
				</div>
				<!-- //겨울별미 탭컨텐츠 -->
			</div>
			<!-- //겨울별미 -->
		</div>
		<!-- //중단 상품 영역 -->

		<!-- 에누리 혜택 -->
		<div class="otherbene">
			<div class="contents" onclick="ga_log(8);" >
				<h3><img src="http://img.enuri.info/images/event/2021/winter_pro/m_benefit_tit.png" alt="놓칠 수  없는 특별한 혜택, 에누리 혜택"></h3>
				<ul class="banlist">
					<li>
						<a href="http://m.enuri.com/m/event/welcome.jsp?tab=evt1" target="_blank" title="새창으로 이동">
							<div class="tx1">첫 구매 고객이라면!</div>
							<div class="tx2">50% 웰컴 페이백</div>
							<div class="comm_btn"><img src="//img.enuri.info/images/event/2021/winter_pro/m_other_btn_white.png"></div>
						</a>
					</li>
					<li>
						<a href="http://m.enuri.com/m/event/visit.jsp?oc=#evt1" target="_blank" title="새창으로 이동">
							<div class="tx1">100% 당첨! 매일받는 e머니</div>
							<div class="tx2">도전! 프로출첵러</div>
							<div class="comm_btn"><img src="//img.enuri.info/images/event/2021/winter_pro/m_other_btn_white.png"></div>
						</a>
					</li>
					<li>
						<a href="http://m.enuri.com/m/event/buy_stamp.jsp#tab4" target="_blank" title="새창으로 이동">
							<div class="tx1">받고 또 받고</div>
							<div class="tx2">추가 적립 5만점</div>
							<div class="comm_btn"><img src="//img.enuri.info/images/event/2021/winter_pro/m_other_btn_white.png"></div>
						</a>
					</li>
					<li>
						<a href="http://m.enuri.com/m/index.jsp?freetoken=main_tab|event" target="_blank" title="새창으로 이동">
							<div class="tx1">아직 끝나지 않은 에누리혜택</div>
							<div class="tx2">더 많은 이벤트</div> 
							<div class="comm_btn"><img src="//img.enuri.info/images/event/2021/winter_pro/m_other_btn_white.png"></div>
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
								<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2021/winter_goods.jsp?oc=sns</span>
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
	<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20190611"></script>
	<script type="text/javascript" src="/mobilefirst/event/js/exhibition_m.js"></script>
	<!--<a href="#top" class="btn_top"><i>TOP</i></a>-->
	<script>
	
		var vEvent_title = " 21년 월동준비 기획전";
		var gaLabel = [  vEvent_title+"_PV"
				,vEvent_title+"_단순참여 이벤트"
				,vEvent_title+"_타임딜"
				,vEvent_title+"_기획전"
				,vEvent_title+"_상단플로팅배너"
				,vEvent_title+"_참여이벤트_참여"
				,vEvent_title+"_참여이벤트_공유하기"
				,vEvent_title+"_혜택배너"
				,vEvent_title+"_타임딜_상품보기"
				,vEvent_title+"_타임딜_APP구매하기"
				,vEvent_title+"_타임딜_썸네일"
				,vEvent_title+"_구매이벤트_기획전이동"
				,vEvent_title+"_구매이벤트_참여"
				,vEvent_title+"_월동준비_히터/온풍기"
				,vEvent_title+"_월동준비_가습기"
				,vEvent_title+"_월동준비_방한용품"
				,vEvent_title+"_월동준비_상품클릭"
				,vEvent_title+"_월동준비_상품더보기"
				,vEvent_title+"_겨울꿀잠템_온수매트/전기매트"
				,vEvent_title+"_겨울꿀잠템_난방텐트"
				,vEvent_title+"_겨울꿀잠템_단열필름"
				,vEvent_title+"_겨울꿀잠템_상품클릭"
				,vEvent_title+"_겨울꿀잠템_상품더보기"
				,vEvent_title+"_건강지키미템_마스크"
				,vEvent_title+"_건강지키미템_공기살균기"
				,vEvent_title+"_건강지키미템_건강식품"
				,vEvent_title+"_건강지키미템_상품클릭"
				,vEvent_title+"_건강지키미템_상품더보기"
				,vEvent_title+"_겨울별미_겨울간식"
				,vEvent_title+"_겨울별미_E쿠폰"
				,vEvent_title+"_겨울별미_김장"
				,vEvent_title+"_겨울별미_상품클릭"
				,vEvent_title+"_겨울별미_상품더보기"
		];
	
		$(document).ready(function(){
			$("#tab3").click(function(){
				ga_log(4);
				$('html, body').stop().animate({scrollTop: Math.ceil($('.mid_banner').offset().top - $(".floattab").outerHeight())}, 0);
			});		
			
			$("#floating_bnr").click(function(){
				ga_log(5);
				//딜페이지 경로 수정
				location.href = "/mobilefirst/event2021/winter_deal.jsp?tab=03";
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
			var loadUrl = "/event/ajax/exhibition_ajax.jsp?exh_id=49"; 
	 
			$.ajax({
				  dataType : "json"
				, url	   : loadUrl
				, cache : false
				, success  : function(result){
					var banner = result.R;
					var tab = result.T;
					var tabSize = 3; //컨텐츠 별 탭 개수
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
			var share_url = "http://" + location.host + "/mobilefirst/event2021/winter_goods.jsp?oc=sns";
			var share_title = "[에누리 가격비교] 겨울, 따뜻한 혜택을 누리다!";
			var share_description = "온가족 타임특가! 매주 수요일마다 터지는 득템의 기회!";
			var imgSNS = "http://img.enuri.info/images/event/2021/winter_pro/sns_1200_630.jpg";
			
			if(param == "face"){
				try{
					window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
				}catch(e){
					window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
				}
			}else if(param == "kakao"){
				imgSNS = "http://img.enuri.info/images/event/2021/winter_pro/sns_1200_630.jpg";
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
				var share_title_twi = "[에누리 가격비교] 겨울에누리다! 매주 수요일 타임특가도 만나보세요!";
				window.open("https://twitter.com/intent/tweet?text="+encodeURIComponent(share_title_twi)+"&url="+share_url);
			}
		}
		/*레이어*/
		function onoff(id) {
			var mid=document.getElementById(id);
			if(mid.style.display=='') {
				mid.style.display='none';
			}else{
				mid.style.display='';
			}
		}
	</script>
	<script>
		
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