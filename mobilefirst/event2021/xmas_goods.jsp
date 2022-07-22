<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%@ include file="/event/common/include/event_common.jsp" %>
<%
String strServerNm = request.getServerName();
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
       || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
       || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
       || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
	response.sendRedirect("/event2021/xmas_goods.jsp"); //PC경로
    return;
}
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
	<meta property="og:title" content="[에누리 가격비교] 메리크리스마스 혜택을 누리다!">
	<meta property="og:description" content="매주 수요일 타임특가 놓치지 마세요! ">
	<meta property="og:image" content="http://img.enuri.info/images/event/2021/xmas_pro/xmas_sns_1200_630.jpg">
	<title>2021 크리스마스 통합기획전 – 최저가 쇼핑은 에누리</title>
	<link rel="stylesheet" type="text/css" href="/css/slick.css">
	<!-- 프로모션 공통 CSS (Mobile) -->
	<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
	<!-- 프로모션별 커스텀 CSS  -->
	<link rel="stylesheet" href="/css/event/y2021_rev/xmas_pro_m.css" type="text/css">
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
	    var tablo = "<%=protab%>";
		var vPop;

	</script>
</head>
<body>
<div class="lay_only_mw" <%if(!strApp.equals("Y") && oc.equals("sns")){%><%}else{%>style="display:none;"<%} %>>>
	<div class="lay_inner">
		<div class="lay_head">
			더 다양한 <em>이벤트 혜택</em>을 누리고 싶다면?
		</div>
		<!-- 버튼 : 에누리앱으로 보기 -->
		<button class="btn_go_app" onclick="ga_log(35);view_moapp();">에누리앱으로 보기</button>
		<!-- 버튼 : 모바일웹으로 보기 -->
		<a href="javascript:void(0);" class="btn_keep_mw" onclick="ga_log(36);$('.lay_only_mw').fadeOut(100);">괜찮아요. 모바일 웹으로 볼래요</a>
	</div>
</div>

<div class="wrap">
		<div class="event_wrap">
		<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp" %>
		<!-- 플로팅 배너 - 둥둥이 -->
		<div id="floating_bnr" class="floating_bnr">
			<a href="/mobilefirst/event2021/xmas_deal.jsp?tab=03" target="_self"><img src="//img.enuri.info/images/event/2021/xmas_pro/m_fl_bnr.png" alt="크리스마스 준비하고 서가앤쿡 외식!"></a>
			<!-- 닫기 -->
			<a href="#" class="btn_close" onclick="onoff('floating_bnr');return false;">
				<span class="blind">닫기</span>
			</a>
		</div>
		<!-- visual -->
		<div class="section visual">
			<div class="visual_obj_list">
				<div class="visual_obj obj_hang1"></div>
				<div class="visual_obj obj_hang2"></div>
				<div class="visual_obj obj_hang3"></div>
				<div class="visual_obj obj_hang4"></div>
				<div class="visual_obj obj_hang5"></div>
				<div class="visual_obj obj_hang6"></div>
				<div class="visual_obj obj_bg1"></div>
				<div class="visual_obj obj_bg2"></div>
				<div class="visual_obj obj_bg3"></div>
				<div class="visual_obj obj_bg4"></div>
				<div class="visual_obj obj_bg5"></div>
			</div>
			<div class="inner">
				<!-- 200330 추가 : 공통 : 공유하기 버튼  -->
				<button class="com__btn_share btn_white" onclick="$('.com__share_wrap').show();">공유하기</button>
				<!-- // -->
				<div class="react_text_area">
					<span class="txt_01">Merri Christmas</span>
					<span class="txt_02"><span>성탄절</span>에-누리다</span>
					<span class="txt_date">2021.12.6 ~ 2021.12.31</span>
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
					<li onclick="ga_log(2);"><a href="/mobilefirst/event2021/xmas_evt.jsp" class="">산타 도와주면<em>유자차 당첨!</em></a></li>
					<li onclick="ga_log(3);"><a href="/mobilefirst/event2021/xmas_deal.jsp" class="">매주 수요일<em>타임특가</em></a></li>
					<li onclick="ga_log(4);"><a href="javascript:;" class="active">메리크리스마스<em>준비템</em></a></li>
				</ul>
			</div>
		</div>
		<!-- /탭 -->

		<!-- 중단배너 -->
		<div class="mid_banner">
			<a href="#프로모션 이동" target="_blank" title="새 창으로 이동합니다."><img src="http://img.enuri.info/images/event/2021/xmas_pro/m_mid_banner.jpg" alt="행복한 크리스마스 쇼핑 가이드" /></a>
		</div>
		<!-- 중단배너 -->

		<!-- 중단 상품 영역 -->
		<div class="pro_itemlist">
			<!-- 어린이를 위한 선물 -->
			<div class="item_group item_group_01 scroll" id="evt2">
				<h3>
					<span class="txt_sub">동심을 지켜라!</span>
					<strong class="txt_tit">어린이를 위한 선물</strong>
				</h3>
				<!-- 어린이를 위한 선물 탭메뉴 -->
				<ul class="pro_tabs">
					<li onclick="ga_log(14);" class="active"><a href="#protab1-1">컴퓨터/게임기</a></li>
					<li onclick="ga_log(15);"><a href="#protab1-2">장난감</a></li>
					<li onclick="ga_log(16);"><a href="#protab1-3">겨울의류</a></li>
				</ul>
				<!-- //어린이를 위한 선물 탭 -->

				<!-- 어린이를 위한 선물 탭컨텐츠 -->
				<div class="tab_container">
					<!--
						SLICK $(".itemlist")
						4개의 탭 콘텐츠가 있습니다. "tab_content"
						하나의 콘텐츠마다 ul 단위로 한 판(상품6개)씩 움직입니다.
					-->
					<!-- 컴퓨터/게임기 상품-->
					<div id="protab1-1" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
								
							</ul>
							<ul class="items clearfix">
								
							</ul>
							<ul class="items clearfix">
								
							</ul>
						</div>
						<a class="btn_more"  onclick="ga_log(18);" href="http://m.enuri.com/m/list.jsp?cate=0408">상품더보기</a>
					</div>
					<!-- //컴퓨터/게임기 상품-->

					<!-- 장난감 상품-->
					<div id="protab1-2" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
								
							</ul>
							<ul class="items clearfix">
								
							</ul>
						</div>
						<a class="btn_more"  onclick="ga_log(18);" href="http://m.enuri.com/m/list.jsp?cate=102433">상품더보기</a>
					</div>
					<!-- //장난감 상품-->

					<!-- 겨울의류 상품 -->
					<div id="protab1-3" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
								
							</ul>
							<ul class="items clearfix">
								
							</ul>
							<ul class="items clearfix">
								
							</ul>
						</div>
						<a class="btn_more"  onclick="ga_log(18);" href="http://m.enuri.com/m/list.jsp?cate=1015">상품더보기</a>
					</div>
					<!-- //겨울의류 상품 -->
				</div>
				<!-- //어린이를 위한 선물 탭컨텐츠 -->
			</div>
			<!-- //어린이를 위한 선물 -->

			<!-- 애정을 담은 선물 -->
			<div id="evt3" class="item_group item_group_02 scroll">
				<h3>
					<span class="txt_sub">연인, 부모님, 사랑하는 사람을 위해 준비했어</span>
					<strong class="txt_tit">애정을 담은 선물</strong>
				</h3>
				<!-- 애정을 담은 선물 탭메뉴 -->
				<ul class="pro_tabs">
					<li onclick="ga_log(19);" class="active"><a href="#protab2-1">쥬얼리/향수</a></li>
					<li onclick="ga_log(20);"><a href="#protab2-2">패션잡화</a></li>
					<li onclick="ga_log(21);"><a href="#protab2-3">효도가전</a></li>
				</ul>
				<!-- //애정을 담은 선물 탭메뉴 -->

				<!-- 애정을 담은 선물 탭컨텐츠 -->
				<div class="tab_container">
					<!-- 쥬얼리/향수 -->
					<div id="protab2-1" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
								
							</ul>
							<ul class="items clearfix">
								
							</ul>
							<ul class="items clearfix">
								
							</ul>
						</div>
						<a class="btn_more"  onclick="ga_log(23);" href="http://m.enuri.com/m/list.jsp?cate=0810">상품더보기</a>
					</div>
					<!-- //쥬얼리/향수 상품 -->

					<!-- 패션잡화 상품 -->
					<div id="protab2-2" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
								
							</ul>
							<ul class="items clearfix">
								
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(23);" href="http://m.enuri.com/m/list.jsp?cate=145704">상품더보기</a>
					</div>
					<!-- //패션잡화 상품 -->

					<!-- 효도가전 상품 -->
					<div id="protab2-3" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
								
							</ul>
							<ul class="items clearfix">
								
							</ul>
							<ul class="items clearfix">
								
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(23);" href="http://m.enuri.com/m/list.jsp?cate=1685">상품더보기</a>
					</div>
					<!-- //효도가전 상품 -->
				</div>
				<!-- //애정을 담은 선물 탭컨텐츠 -->
			</div>
			<!-- //애정을 담은 선물 -->

			<!-- 나 홀로 집에 아이템 -->
			<div id="evt4" class="item_group item_group_03 scroll">
				<h3>
					<span class="txt_sub">휴일엔 역시 집이지!</span>
					<strong class="txt_tit">나 홀로 집에 아이템</strong>
				</h3>
				<!-- 나 홀로 집에 아이템 탭메뉴 -->
				<ul class="pro_tabs">
					<li onclick="ga_log(24);" class="active"><a href="#protab3-1">빔프로젝트</a></li>
					<li onclick="ga_log(25);" ><a href="#protab3-2">밀키트/E쿠폰</a></li>
					<li onclick="ga_log(26);" ><a href="#protab3-3">홈테리어</a></li>
				</ul>
				<!-- //나 홀로 집에 아이템 탭메뉴 -->

				<!-- 나 홀로 집에 아이템 탭컨텐츠 -->
				<div class="tab_container">
					<!-- 빔프로젝트 상품 -->
					<div id="protab3-1" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
								
							</ul>
							<ul class="items clearfix">
								
							</ul>
							<ul class="items clearfix">
								
							</ul>
						</div>
						<a class="btn_more" onclick="ga_log(28);" href="http://m.enuri.com/m/list.jsp?cate=021132">상품더보기</a>
					</div>
					<!-- //빔프로젝트 상품 -->

					<!-- 밀키트/E쿠폰 상품 -->
					<div id="protab3-2" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
								
							</ul>
							<ul class="items clearfix">
								
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(28);" href="http://m.enuri.com/m/list.jsp?cate=1516">상품더보기</a>
					</div>
					<!-- //밀키트/E쿠폰 상품 -->

					<!-- 홈테리어 상품 -->
					<div id="protab3-3" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
								
							</ul>
							<ul class="items clearfix">
								
							</ul>
							<ul class="items clearfix">
								
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(28);" href="http://m.enuri.com/m/list.jsp?cate=122739">상품더보기</a>
					</div>
					<!-- //홈테리어 상품 -->
				</div>
				<!-- //나 홀로 집에 아이템 탭컨텐츠 -->
			</div>
			<!-- // 나 홀로 집에 아이템 -->

			<!-- 신년준비 필수템 -->
			<div id="evt5" class="item_group item_group_04 scroll">
				<h3>
					<span class="txt_sub">아듀 2021! 웰컴 2022!</span>
					<strong class="txt_tit">신년준비 필수템</strong>
				</h3>
				<!-- 신년준비 필수템 탭메뉴 -->
				<ul class="pro_tabs">
					<li onclick="ga_log(29);" class="active"><a href="#protab4-1">달력/다이어리</a></li>
					<li onclick="ga_log(30);"><a href="#protab4-2">건강식품</a></li>
					<li onclick="ga_log(31);"><a href="#protab4-3">위생용품</a></li>
				</ul>
				<!-- //신년준비 필수템 탭메뉴 -->

				<!-- 신년준비 필수템 탭컨텐츠 -->
				<div class="tab_container">
					<!-- 달력/다이어리 상품 -->
					<div id="protab4-1" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
								
							</ul>
							<ul class="items clearfix">
								
							</ul>
							<ul class="items clearfix">
								
							</ul>
						</div>
						<a class="btn_more" onclick="ga_log(33);" href="http://m.enuri.com/m/list.jsp?cate=180209">상품더보기</a>
					</div>
					<!-- //달력/다이어리 상품 -->

					<!-- 건강식품 상품 -->
					<div id="protab4-2" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
								
							</ul>
							<ul class="items clearfix">
								
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(33);" href="http://m.enuri.com/m/list.jsp?cate=1501">상품더보기</a>
					</div>
					<!-- //건강식품 상품 -->

					<!-- 위생용품 상품 -->
					<div id="protab4-3" class="tab_content">
						<div class="itemlist">
							<ul class="items clearfix">
								
							</ul>
							<ul class="items clearfix">
								
							</ul>
							<ul class="items clearfix">
								
							</ul>
						</div>
						<a class="sprite btn_more" onclick="ga_log(33);" href="http://m.enuri.com/m/list.jsp?cate=080613">상품더보기</a>
					</div>
					<!-- //위생용품 상품 -->
				</div>
				<!-- //신년준비 필수템 탭컨텐츠 -->
			</div>
			<!-- //신년준비 필수템 -->

		</div>
		<!-- //중단 상품 영역 -->

		<!-- 에누리 혜택 -->
		<div class="otherbene">
			<div class="contents">
				<h3><img src="http://img.enuri.info/images/event/2021/winter_pro/m_benefit_tit.png" alt="놓칠 수  없는 특별한 혜택, 에누리 혜택"></h3>
				<ul class="banlist"  onclick="ga_log(8);">
					<li>
						<a href="http://m.enuri.com/m/event/welcome.jsp" target="_blank" title="새창으로 이동">
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
						<a href="http://m.enuri.com/m/index.jsp#evt" target="_blank" title="새창으로 이동">
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
						<li class="share_kakao" id="kakao-share-btn">카카오톡 공유하기</li>
						<li class="share_tw">트위터 공유하기</li>
					</ul>
					<!-- 메인보내기 버튼클릭시 .mail_on 추가해 주세요 -->
					<div class="btn_wrap">
						<div class="btn_group">
							<!-- 주소복사하기 -->
							<div class="btn_item">
								<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2021/xmas_goods.jsp?oc=sns</span>
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
	var share_url = "http://m.enuri.com/mobilefirst/event2021/xmas_goods.jsp?oc=sns";
	var share_title = "[에누리 가격비교] 메리크리스마스 혜택을 누리다!";
	var share_description = "매주 수요일 타임특가 놓치지 마세요!";
	var imgSNS = "http://img.enuri.info/images/event/2021/xmas_pro/xmas_sns_1200_630.jpg";
	
	var vEvent_title = "21년 크리스마스 기획전";
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
			,vEvent_title+"_어린이를 위한 선물_컴퓨터/게임기"
			,vEvent_title+"_어린이를 위한 선물_장난감"
			,vEvent_title+"_어린이를 위한 선물_겨울의류"
			,vEvent_title+"_어린이를 위한 선물_상품클릭"
			,vEvent_title+"_어린이를 위한 선물_상품더보기"
			,vEvent_title+"_애정을 담은 선물_쥬얼리/향수"
			,vEvent_title+"_애정을 담은 선물_패션잡화"
			,vEvent_title+"_애정을 담은 선물_효도가전"
			,vEvent_title+"_애정을 담은 선물_상품클릭"
			,vEvent_title+"_애정을 담은 선물_상품더보기"
			,vEvent_title+"_나홀로 집에 아이템_빔프로젝트"
			,vEvent_title+"_나홀로 집에 아이템_밀키트/E쿠폰"
			,vEvent_title+"_나홀로 집에 아이템_홈테리어"
			,vEvent_title+"_나홀로 집에 아이템_상품클릭"
			,vEvent_title+"_나홀로 집에 아이템_상품더보기"
			,vEvent_title+"_신년준비 필수템_달력/다이어리"
			,vEvent_title+"_신년준비 필수템_건강식품"
			,vEvent_title+"_신년준비 필수템_위생용품"
			,vEvent_title+"_신년준비 필수템_상품클릭"
			,vEvent_title+"_신년준비 필수템_상품더보기"
			,"크리스마스시즌_탭3공유하기_앱설치 팝업_PV"
			,"크리스마스시즌_탭3공유하기_앱설치 팝업_APP설치"
			,"크리스마스시즌_탭3공유하기_앱설치 팝업_닫기"
	];
	
	$(document).ready(function(){
		$("#tab3").click(function(){
			$('html, body').stop().animate({scrollTop: Math.ceil($('.mid_banner').offset().top - $(".floattab").outerHeight())}, 0);
		});		
		
		$("#floating_bnr").click(function(){
			//딜페이지 경로 수정
			ga_log(5);
			location.href = "/mobilefirst/event2021/xmas_deal.jsp?tab=03";
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
		var loadUrl = "/event/ajax/exhibition_ajax.jsp?exh_id=50"; 
 
		$.ajax({
			  dataType : "json"
			, url	   : loadUrl
			, cache : false
			, success  : function(result){
				var banner = result.R;
				var tab = result.T;
				var tabSize = 3; //컨텐츠 별 탭 개수
				var listSize = 4; //노출 상품 개수
				var logNo = [17,22,27,32];
				var no = 0;
				var minprice = 0;

				for(var idx = 0; idx < tab.length; idx ++){
					makeHtml = "";
					no = logNo[parseInt(idx/tabSize)];
					$.each(tab[idx].GOODS, function(i,v){ 
						minprice = (v.MINPRICE == null) ? 0 : v.MINPRICE;

						if((i % listSize) == 0)	makeHtml += "<ul class='items clearfix'>";
						makeHtml += "<li class='item'>";
						makeHtml +=	"	<a href='javascript:void(0);' onclick='itemClick("+v.MODELNO+", "+minprice+");ga_log("+no+")'>";
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
			if(param == "face"){
				try{
					window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
				}catch(e){
					window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
				}
			}else if(param == "kakao"){
				imgSNS = "http://img.enuri.info/images/event/2021/xmas_pro/sns_800_800.jpg";
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
				var share_title_twi = "[에누리 가격비교] 메리크리스마스 혜택을 누리다! 매주 수요일 타임특가 놓치지 마세요!";
				window.open("https://twitter.com/intent/tweet?text="+encodeURIComponent(share_title_twi)+"&url="+share_url);
			}
		}
		
		function view_moapp(){ 
			var chrome25;
			var kitkatWebview;
			var uagentLow = navigator.userAgent.toLocaleLowerCase();
			var openAt = new Date;
			var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2021%2Fxmas_goods.jsp";
			if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
				goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2021/xmas_goods.jsp"; 
		 		chrome25 = uagentLow.search("chrome") > -1 && navigator.appVersion.match(/Chrome\/\d+.\d+/)[0].split("/")[1] > 25;
				kitkatWebview = uagentLow.indexOf("naver") != -1 || uagentLow.indexOf("daum") != -1; 
				setTimeout( function() {
					if (new Date - openAt < 4000) {
						if (uagentLow.search("android") > -1) {
							location.href = "market://details?id=com.enuri.android";
						}
					}
				}, 1000);
				if(uagentLow.search("android") > -1){
					chrome25 = uagentLow.search("chrome") > -1 && navigator.appVersion.match(/Chrome\/\d+.\d+/)[0].split("/")[1] > 25;
					kitkatWebview = uagentLow.indexOf("naver") != -1 || uagentLow.indexOf("daum") != -1;
					location.href = goApp;
				}
				//location.href = "market://details?id=com.enuri.android";
				//location.href = "intent://#Intent;scheme=enuri;package=com.enuri.android;end";
			}else{
				setTimeout( function() { 
					window.open("https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8");
				}, 1000); 
				location.href = goApp;
			} 
		}	
		ga_log(1);
		<%if(!strApp.equals("Y") && oc.equals("sns")){%>
		ga_log(34);
		<%}%>
	</script>
	<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
	<script type="text/javascript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</div>
</body>
</html>