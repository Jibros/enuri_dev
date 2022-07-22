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
	response.sendRedirect("/event/dormancy_evt.jsp"); //PC경로
    return;
}

String strUrl = request.getRequestURI();
String oc = ChkNull.chkStr(request.getParameter("oc"));
String pd = ChkNull.chkStr(request.getParameter("pd"));
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
	<meta property="og:title" content="[에누리 가격비교] 돌아와요, 고객님!">
	<meta property="og:description" content="로그인하면 추첨해서 e머니가 와르르~">
	<meta property="og:image" content="http://img.enuri.info/images/mobilefirst/etc/dormancysns.jpg">
	<meta name="format-detection" content="telephone=no" />

	<link rel="shortcut icon" href="http://img.enuri.info/2014/layout/favicon_enuri.ico">
	<title>[에누리 가격비교] 돌아와요, 고객님!</title>
	<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
	<link rel="stylesheet" type="text/css" href="/css/rev/common.css"/> <!-- reset -->
	<link rel="stylesheet" type="text/css" href="/css/rev/common.css"/> <!-- reset -->
	<link rel="stylesheet" type="text/css" href="/css/rev/template.css"/> <!-- template -->
	<!-- 프로모션 공통 CSS (Mobile) -->
	<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
	<!-- 프로모션별 커스텀 CSS  -->
	<link rel="stylesheet" href="/css/event/y2021_rev/dormancy_m.css" type="text/css">
	<!-- 프로모션 공통 JS -->
	<script type="text/javascript" src="/common/js/lib/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="/js/swiper.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
	<script type="text/javascript" src="/event2016/js/event_common.js?v=20210826"></script>
	<script>
	var app = "<%=strApp%>";
	var pd = "<%=pd%>";
	var userId = "<%=USERID%>";
	var username = "<%=USERINFO%>";
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
		<button class="btn_go_app"  onclick="view_moapp();!install_btt();">에누리앱으로 보기</button>
		<!-- 버튼 : 모바일웹으로 보기 -->
		<a href="javascript:void(0);" class="btn_keep_mw" onclick="view_hide();$('.lay_only_mw').fadeOut(100);">괜찮아요. 모바일 웹으로 볼래요</a>
	</div>
</div>
<div class="wrap">
	<div class="event_wrap">
		<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp" %>

		<!-- visual -->
		<div class="section visual">
			<div class="inner">
				<div class="visual_obj"><!-- 훈장님 --></div>

				<!-- 공통 : 공유하기 버튼  -->
				<button class="">
				</button>
				<button class="com__btn_share btn_white" onclick="$('.com__share_wrap').show();">공유하기</button>
				<!-- // -->
				<div class="react_text_area">
					<span class="txt_01">로그인하면 추첨해서 e머니가 와르르!</span>
					<span class="txt_02"><span>돌아와요,</span> 고객님</span>
					<span class="txt_03">6개월 이상 방문하지 않은 고객이라면 누구나 응모 가능</span>
				</div>
			</div>
			<script>
				$(window).load(function(){
					var $visual = $(".event_wrap .visual");
					setTimeout(function(){
						$visual.addClass("start");
					},1000)
				})
			</script>
		</div>
		<!-- //visual -->

        <!-- 공통 : 탭 -->
		<div class="section navtab">
			<div class="navtab_inner">
				<ul class="navtab_list">
                    <!-- 선택 : is-on -->
                    <li><a href="#evt1" class="navtab_item--01" onclick="ga_log(2);">응모만 해도 최대 1만원 증정</a></li>
                    <li><a href="#evt2" class="navtab_item--02" onclick="ga_log(3);">APP 알림동의하면 추가 경품 득템</a></li>
				</ul>
			</div>
		</div>
		<!-- //탭 -->

		<!---------------------------------- 이벤트 1 ---------------------------------->
		<div class="section scroll" id="evt1">
			<div class="inner">
				<div class="tit">EVENT 01</div>
				<div class="subtit">
					오랜만에 에누리에 로그인하시고<br>상품 받아가세요!
				</div>
				<div class="img_step">
					<img src="//img.enuri.info/images/event/2021/dormancy/m/m_step_img.jpg" alt="">
                    <ol class="ir-txt">
                        <li>오랜만에 에누리에 왔다면</li>
                        <li>PC 또는 모바일에서 로그인 후 응모하기</li>
                        <li>추첨을 통해 푸짐한 선물 당첨!</li>
                    </ol>
				</div>
				<div class="img_gift">
					<img src="//img.enuri.info/images/event/2021/dormancy/m/m_evt1_gift.png" alt="">
                    <ol class="ir-txt">
                        <li>30명 추첨하여 해피머니 상품권 1만원권으로 바꿀 수 있는 e머니 10000점을 드립니다.</li>
                        <li>500명 추첨하여 에누리 E머니 1000점을 드립니다.</li>
                    </ol>
				</div>

                <a href="#" class="btn_apply" id="event1">응모하기</a>

                <div class="evt_period">
					<ul>
						<li><strong>이벤트 기간</strong>: 2021년 11월 22일 ~ 12월 22일</li>
                        <li><strong>당첨자 발표</strong>: 2021년 12월 27일</li>
					</ul>
				</div>

				<div class="area_noti">
					<button class="btn_caution btn__evt_on_slide" data-laypop-id="slidePop1">꼭! 확인하세요</button>
				</div>
            </div>
		</div>

        <!-- 유의사항 : 이벤트 1 -->
        <div id="slidePop1" class="evt_slide">
            <div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
                <div class="evt_slide--head">유의사항</div>
                <div class="evt_slide--cont">
                    <div class="evt_slide--continner">
                        <div class="popup_inner_tit">이벤트 대상 및 혜택</div>
                        <ul class="list_dot mb20">
                            <li>이벤트 대상 : 6개월 이상 미로그인 회원</li>
                            <li>이벤트 참여 혜택 : 해피머니상품권 1만원권 (E머니 10,000점) - 30명, 에누리 e머니 1,000점 - 500명</li>
                            <li>이벤트 기간 : 2021년 11월 22일 ~ 12월 22일</li>
                            <li>혜택 지급일 : 2021년 12월 27일</li>
							<li><span class="color-red">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span><br>
								※ 적립된 e머니는 1,000여가지 인기 e쿠폰으로 교환 가능합니다.
							</li>
                            <li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
                            <li>부정 참여 시 적립 취소 및 사이트 사용이 제한될 수 있습니다.</li>
                        </ul>
                    </div>
                </div>
                <div class="evt_notice--foot">
                    <button class="btn__evt_off_slide">확인</button> <!-- 닫기 : 레이어 닫기 -->
                </div>
            </div>
            <div class="evt_notice--dimmed"></div> <!-- 닫기 : 레이어 외부 클릭 -->
        </div>
        <!-- //유의사항 : 이벤트 1 -->
		<!---------------------------------- //이벤트 1 ---------------------------------->

		<!---------------------------------- 이벤트 2 ---------------------------------->
		<div class="section scroll" id="evt2">
			<div class="inner">
				<div class="img_step">
					<img src="//img.enuri.info/images/event/2021/dormancy/m/m_evt2_info.png" alt="">
                    <div class="ir-txt">
                        <p>앱전용 이벤트</p>
                        <p>EVENT 02</p>
                        <p>에누리 APP알림 동의했다면 추가 추첨 증정!</p>
                        <p>이미 알림 동의를 하셨어도 OK! 새롭게 알림 동의를 하셨어도 OK!</p>

                        <p>5명 추첨하여 신세계상품권 4만원으로 바꿀 수 있는 e머니 4만점을 드립니다.</p>
                    </div>
				</div>
				<div class="evt_guide_wrap">
					<div class="evt_guide_slide swiper-container">
						<div class="swiper-wrapper">
							<div class="swiper-slide">
								<img src="//img.enuri.info/images/event/2021/dormancy/m/m_evtguide_step1.png" alt="STEP1. APP 로그인 후 마이e클럽으로 이동하기">
							</div>
							<div class="swiper-slide">
								<img src="//img.enuri.info/images/event/2021/dormancy/m/m_evtguide_step2.png" alt="STEP2. 마이e클럽에서 '설정' 클릭하기">
							</div>
							<div class="swiper-slide">
								<img src="//img.enuri.info/images/event/2021/dormancy/m/m_evtguide_step3.png" alt="STEP3. 광고/정보알림 모두 ON! 추가 경품 이벤트 자동 응모 완료">
							</div>
						</div>
						<div class="swiper-button-prev btn_prev"></div>
						<div class="swiper-button-next btn_next"></div>
					</div>
					<div class="swiper-pagination"></div>
				</div>
				<script>
					$(function(){
						var mySwiper = new Swiper('.evt_guide_slide',{
							prevButton : '.evt_guide_wrap .swiper-button-prev',
							nextButton : '.evt_guide_wrap .swiper-button-next',
							pagination : '.evt_guide_wrap .swiper-pagination',
							speed : 1000,
							loop : true,
							paginationClickable : true
						})
					})
				</script>

                <a href="javascript:;" class="btn_agree" id="event2">APP 알림동의</a>

                <div class="area_noti">
                    <button href="#" class="btn_caution btn__evt_on_slide" data-laypop-id="slidePop2">꼭 확인하세요</button>
                </div>
			</div>
		</div>

        <!-- 유의사항 : 이벤트 2 -->
        <div id="slidePop2" class="evt_slide">
            <div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
                <div class="evt_slide--head">유의사항</div>
                <div class="evt_slide--cont">
                    <div class="evt_slide--continner">
                        <div class="popup_inner_tit">이벤트 대상 및 혜택</div>
                        <ul class="list_dot mb20">
                            <li>이벤트 대상 : 6개월 이상 미로그인 회원 중 알림동의 한 회원</li>
                            <li>이벤트 참여 혜택 : 신세계 이머니 4만원 상품권 (e 40,000점) - 5명</li>
                            <li>이벤트 기간 : 2021년 11월 22일 ~ 12월 22일</li>
                            <li>혜택 지급일 : 2021년 12월 27일</li>
							<li><span class="color-red">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</span><br>
								※ 적립된 e머니는 1,000여가지 인기 e쿠폰으로 교환 가능합니다.
							</li>
                        </ul>

                        <div class="popup_inner_tit">이벤트 참여 방법 및 유의사항</div>
                        <ul class="list_dot mb20">
                            <li>참여방법 : 에누리 가격비교 모바일 앱 로그인 → 광고/정보 알림 동의 → 자동 응모 완료</li>
                            <li>본 이벤트는 모바일 앱에서 본인인증 ID당 1회만 참여 가능합니다. (※ 본인인증 필수)</li>
							<li>이벤트 당첨자 발표일까지 광고 알림 및 정보 알림 동의가 유지돼 있어야 합니다.  비동의 변경 시 불이익을 받을 수 있습니다.</li>
                            <li>광고 알림 및 정보 알림 모두 동의한 경우에만 혜택 지급 가능합니다.</li>
                            <li>본 이벤트는 모바일 앱에서만 참여가 가능한 모바일 앱 전용 프로모션입니다.</li>
                            <li><span class="color-red">이벤트 대상 제외</span> : 아래의 경우 본 이벤트 대상에서 제외됩니다.
                                <ul>
                                    <li>- 마지막 로그인이 2021년 4월 이후인 회원</li>
                                    <li>- 광고/정보 알림 동의하지 않은 고객 또는 일부만 동의한 고객</li> 
                                    <li>- 동일한 본인인증으로 가입한 다수의 ID로 중복참여한 경우</li>
                                </ul>
                            </li>
                            <li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
                            <li>부정 참여 시 적립 취소 및 사이트 사용이 제한될 수 있습니다.</li>
                        </ul>
                    </div>
                </div>
                <div class="evt_notice--foot">
                    <button class="btn__evt_off_slide">확인</button> <!-- 닫기 : 레이어 닫기 -->
                </div>
            </div>
            <div class="evt_notice--dimmed"></div> <!-- 닫기 : 레이어 외부 클릭 -->
        </div>
        <!-- //유의사항 : 이벤트 1 -->
		<!---------------------------------- //이벤트 2 ---------------------------------->

        <!-- 배너 -->
        <div class="bnr_box" onclick="ga_log(6);">
            <a href="/m/event/buy_birth.jsp?tab=2&oc=sns" target="_blank" title="새 창에서 열립니다."><img src="//img.enuri.info/images/event/2021/dormancy/m/m_bnr_img.png" alt="추가 적립금 받으세요. 컴백! 구매하면 2,000점 100% 적립" /></a>
        </div>
        <!-- //배너 -->

		<!-- 공통 : SNS공유하기 -->
		<div class="com__share_wrap dim" style="z-index:10000;display:none">
			<div class="com__layer share_layer">
				<div class="lay_head">공유하기</div>
				<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
				<div class="lay_inner">
					<ul>
						<li class="share_fb">페이스북 공유하기</li>
						<li class="share_kakao"  id="kakao-share-btn">카카오톡 공유하기</li>
						<li class="share_tw">트위터 공유하기</li>
					</ul>
					<!-- 메인보내기 버튼클릭시 .mail_on 추가해 주세요 -->
					<div class="btn_wrap">
						<div class="btn_group">
							<!-- 주소복사하기 -->
							<div class="btn_item">
								<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2021/dormancy_evt.jsp</span>
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

	<div class="layerwrap">
		<!-- 모바일웹 공통 : 모바일 앱 전용 이벤트  -->
		<div class="layer_back" id="app_only" style="display:none;">
			<div class="appLayer">
				<h4>모바일 앱 전용 이벤트</h4>
				<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
				<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
				<p class="btn_close"><button type="button">설치하기</button></p>
			</div>
		</div>
		<!-- // 딤레이어 : 모바일 앱 전용 이벤트 -->
	</div>
	<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20190611"></script>
	<script type="text/javascript" src="/mobilefirst/event/js/exhibition_m.js"></script>
	<!--<a href="#top" class="btn_top"><i>TOP</i></a>-->
	<script>
		var vEvent_title = "21년 휴면리텐션 프로모션";
		var vEvent_page = "<%=strUrl%>";
		var gaLabel = [  vEvent_title+"_PV"
				,vEvent_title+"_로그인 이벤트"
				,vEvent_title+"_APP 알림동의"
				,vEvent_title+"_로그인 이벤트_참여"
				,vEvent_title+"_APP 알림동의_참여"
				,vEvent_title+"_브릿지 배너" 
				,"휴면회원_공유하기_앱설치 팝업_PV" 
				,"휴면회원_공유하기_앱설치 팝업_APP설치" 
				,"휴면회원_공유하기_앱설치 팝업_닫기" 
				,"휴면회원_APP알림동의_앱설치 팝업_PV" 
				,"휴면회원_APP알림동의_앱설치 팝업_APP설치" 
				,"휴면회원_APP알림동의_앱설치 팝업_닫기" 
		];
		
		$(document).ready(function(){

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

			var vOs_type = getOsType();

			$("#event1").click(function(e){
				ga_log(4);
				//if(app != 'Y'){
				//	$('.btn_go_app').attr("dealType", $(this).attr("tabType"));
				//	$('.lay_only_mw').show();
				//}else {
						getEventAjaxData({"procCode": 2 , "ostpcd" : vOs_type , "eventId" : "2021112201" }, function(data){
						var result = data.result;
 
						if(result == -99){
							alert("임직원은 참여 불가합니다.");
							return false;
						} 
						if(result == -1){
							alert("이미 응모하셨습니다.\n당첨자 발표일을 기다려주세요.");
							return false; 
						}   
						if( result == 1 ){
					    	alert('정상적으로 응모가 완료됐습니다.\n당첨자 발표일을 기대해주세요.');
					        return false;
					    }else{
					    	alert('죄송합니다.\n회원님은 이벤트 대상자가 아닙니다.');
					    	return false;
					    }
					});
				//}
				//return false;
			});

			var isClick2 = true;
			$("#event2").click(function(){
				ga_log(5);
				if(app == 'Y'){
					if(!islogin()){
						goLogin();
					}else{
						if(isClick2){
							$.ajax({
								type: "POST",
								url: "/mobilefirst/evt/ajax/ajax_welcome_upd_alrim.jsp",
								dataType:"JSON",
								success: function(json){
									var result = json.result;
									if(result > 0){
										alert('광고/정보 알림 받기 완료!\n [My에누리>설정]에서 확인 가능합니다!');
									}else if(result == -99){
										alert("본인 인증 후 알림 받기가 가능합니다!");

										if(getCookie("appYN") == "Y"){
											window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid="+userId+"&app=Y&freetoken=login_title&pd="+pd);
										}else{
											window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid="+userId+"&freetoken=login_title");
										}
										return false;
									}else if ( result== -5 ) {
										alert("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
										location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
									}else{
										alert("[My에누리>설정]에서 확인 가능합니다!");
									}
									isClick2 = false;
								}
							});
						}else{
							alert('[My에누리>설정]에서 확인 가능합니다!');
							return false;
						}
					}
				} else{
					$('.lay_only_mw').show();
					ga_log(10);
					vPop = "agree";
				}
			});

	        // 상단 메뉴 스크롤 시 고정
	        var $nav = $('.navtab'),
	            $menu = $('.navtab_list li'),
	            $contents = $('.scroll'),
	            $navheight = $nav.outerHeight(), // 상단 메뉴 높이
	            $navtop = Math.ceil($nav.offset().top); // navtab 현재 위치;

	        // 해당 섹션으로 스크롤 이동
            $menu.on('click', 'a', function (e) {
                var $target = $(this).parent(),
                    idx = $target.index();
                if ( idx < $menu.length ){
                    var offsetTop = Math.ceil($contents.eq(idx).offset().top);
                    $('html, body').stop().animate({ scrollTop: offsetTop - $navheight }, 500);
                    return false;
                }
            });

	        // menu class 추가
	        $(window).scroll(function () {
	            var $scltop = Math.ceil($(window).scrollTop());	// 현재 scroll

	            if ($scltop > $navtop) {
	                $nav.addClass("is-fixed");
	            } else {
	                $nav.removeClass("is-fixed");
	                $menu.children("a").removeClass('is-on');
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

			// 유의사항 열기/닫기
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
		});

		// 레이어 열닫
		function onoff(id) {
			var mid = $(id);
			var cont = mid.find('.popup_box');
			if(mid.css("display") === 'none') {
				mid.css('display','block');
				cont.css('margin-top',  (-1 * (cont.height() / 2)) );
			}else{
				mid.css('display','none');
			}
		}
		function install_btt(){
			if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
		        window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8';
		    }else if(navigator.userAgent.indexOf("Android") > -1){
		    	window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
		    }
		}

		function view_moapp(){ 
			var chrome25;
			var kitkatWebview;
			var uagentLow = navigator.userAgent.toLocaleLowerCase();
			var openAt = new Date;
			var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2021%2Fdormancy_evt.jsp";
			if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
				goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2021/dormancy_evt.jsp";
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
					if (chrome25 && !kitkatWebview){
						window.open(goApp);
					} else{
						window.open(goApp);
					}
				}
				//location.href = "market://details?id=com.enuri.android";
				//location.href = "intent://#Intent;scheme=enuri;package=com.enuri.android;end";
			}else{
				setTimeout( function() { 
					window.open("https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8");
				}, 1000); 
				location.href = goApp;
			}
			if(vPop == "sns"){
				ga_log(8);
			}else if(vPop == "agree"){
				ga_log(11);
			}
		}
		function view_hide(){
			if(vPop == "sns"){
				ga_log(9);
			}else if(vPop == "agree"){
				ga_log(12);
			}
		}
		 
		var isClick = true;
		var sdt = "<%=TODAY%>";
		//sdt = "20210823";
		//var numSdt = parseInt(sdt.substring(0,8));

		function getEventAjaxData(params, callback){

			/*if(numSdt < 20211122){
				alert('오픈예정입니다.');
				return false;
			}
			if(numSdt > 20211122){
				alert('이벤트 종료! 다음 이벤트를 기대해주세요.');
				return false;
			}
			*/
			if(!islogin()){
				alert("로그인 후 이용 가능합니다.");
				goLogin();
				return false;
			}else{
				if(!getSnsCheck()){

					if (confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?") == true){
						location.href= "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
					}else{
						return false;
					}
				}else{
					var evtUrl = "/event/api/ajax_dormancy.jsp";

					if(typeof params === "object") {
						params.sdt = sdt;
						params.osType = "MO";
					}
					if(!isClick){
						return false;
					}
				  	isClick = false;
					 $.post(evtUrl,params,callback,"json").done(function(){
							isClick = true;
					});
				}
			}
		}
		//sns 공유하기 함수
		function shareSns(param){ //수정
			var share_url = "http://" + location.host + "/mobilefirst/event2021/dormancy_evt.jsp?oc=sns";
			var share_title = "[에누리 가격비교] 돌아와요, 고객님!";
			var share_description = "로그인하면 추첨해서 e머니가 와르르~";
			var imgSNS = "http://img.enuri.info/images/mobilefirst/etc/dormancysns.jpg";

			if(param == "face"){
				try{
					window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
				}catch(e){
					window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
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
				var share_title_twi = share_title +" "+share_description;
				window.open("https://twitter.com/intent/tweet?text="+encodeURIComponent(share_title_twi)+"&url="+share_url);
			}
		}

		ga_log(1);
		<%if(!strApp.equals("Y") && oc.equals("sns")){%>
		ga_log(7);
		vPop = "sns";
	<%}%>
	</script>
	<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
	<script type="text/javascript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</div>
</body>
</html>