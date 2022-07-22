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
	if(strServerNm.indexOf("dev.enuri.com") > -1){
		response.sendRedirect("http://dev.enuri.com/event2021/summer_evt.jsp"); //PC경로		
	}else{
		response.sendRedirect("http://www.enuri.com/event2021/summer_evt.jsp"); //PC경로
	}
	return;
}
	String strShareImg =  ConfigManager.IMG_ENURI_COM+ "/images/event/2021/summer_pro/summer_sns_test.jpg";  //수정
	String oc = ChkNull.chkStr(request.getParameter("oc"));
	String strFb_title = "2021 무더위 통합기획전 – 최저가 쇼핑은 에누리";
	String strFb_description = "온 가족 타임특가! 매주 수요일마다 터지는 득템의 기회!";

	String chkId = ChkNull.chkStr(request.getParameter("chk_id"), "");
	String cUserId = ChkNull.chkStr(cb.GetCookie("MEM_INFO", "USER_ID"), "");
	String cUserNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO", "USER_NICK"), "");
	
	Members_Proc members_proc = new Members_Proc();
	String cUsername = members_proc.getUserName(cUserId);
	String userArea = cUsername;

	String strUrl = request.getRequestURI();

	if (!cUserId.equals("")) {
		cUsername = members_proc.getUserName(cUserId);
		userArea = cUsername;

		if (cUsername.equals(""))
			userArea = cUserNick;
		if (userArea.equals(""))
			userArea = cUserId;
	}
	String tab = ChkNull.chkStr(request.getParameter("tab"), "");
	String flow = ChkNull.chkStr(request.getParameter("flow"));

	SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");	//오늘 날짜
	String strToday = formatter.format(new Date());
	int intToday = Integer.parseInt(strToday);
	String sdt = ChkNull.chkStr(request.getParameter("sdt"));

	if (!"".equals(sdt) || request.getServerName().equals("dev.enuri.com")) {
		strToday = sdt;
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<meta property="og:title" content="<%=strFb_title%>">
<meta property="og:description" content="<%=strFb_description%>">
<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM+"/images/event/2021/summer_pro/summer_sns_test.jpg"%>">
<meta name="format-detection" content="telephone=no" />
<title>에누리 가격비교 - 최저가 쇼핑은 에누리 가격비교 사이트</title>
<!-- 프로모션 공통 CSS (Mobile) -->
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<!-- 프로모션별 커스텀 CSS  -->
<link rel="stylesheet" href="/css/event/y2021_rev/summer_pro_m.css" type="text/css">
<link rel="stylesheet" type="text/css"	href="/mobilefirst/css/lib/slick.css" />
<script type="text/javascript" src="/common/js/lib/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<script type="text/javascript" src="/event2016/js/event_common.js"></script>
<script src="/js/wScratchPad.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20200630"></script>
<script type="text/javascript" src="/mobilefirst/event/js/exhibition_m.js"></script>
</head>
<body>

<!-- 200825 : SR#41896 : [MO] SNS 공유 딥링크 연결 팝업  -->
<div class="lay_only_mw" style="display:none;" >
	<div class="lay_inner">
		<div class="lay_head">
			앱에서는 득템의 기회 <em>타임특가</em>에 참여할 수 있어요!
		</div>
		<!-- 버튼 : 에누리앱으로 보기 -->
		<button class="btn_go_app" dealType="">에누리앱으로 보기</button>
		<!-- 버튼 : 모바일웹으로 보기 -->
		<a href="javascript:void(0);" class="btn_keep_mw" onclick="$('.lay_only_mw').fadeOut(100);">괜찮아요. 모바일 웹으로 볼래요</a>
	</div>
</div>
<!-- // -->

<div class="wrap">
    <div class="event_wrap">
        <div class="myarea">
            <p class="name">
                나의 <em class="emy">머니</em>는 얼마일까?
                <button type="button" class="btn_login" onclick="goLogin();">로그인</button>
            </p>
            <a href="javascript:///" class="win_close">창닫기</a>
        </div>

        <!-- 플로팅 배너 - 둥둥이 -->
        <div id="floating_bnr" class="floating_bnr">
            <a href="#프로모션 이동" target="_blank" title="새 창으로 이동합니다."><img src="http://img.enuri.info/images/event/2021/summer_pro/fl_bnr.png" alt="무더위 준비하고 애플워치 득템"></a>
            <!-- 닫기 -->
            <a href="#" class="btn_close" onclick="onoff('floating_bnr');return false;">
                <span class="blind">닫기</span>
            </a>
        </div>
        <!-- // -->
        <!-- visual -->
        <div class="section visual">
            <!-- 200330 추가 : 공통 : 공유하기 버튼  -->
            <button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
            <!-- // -->
            <div class="inner">
                <div class="react_text_area plxtype2" data-vx="30" data-vy="0">
                    <span class="txt_01">다가오는 무더위 미리대탈출!</span>
                    <h2><span>시원함에 누리다</span></h2>
                    <span class="txt_02">2021.07.05 ~ 2021.08.08</span>
                </div>
            </div>
            <script>
                $(window).load(function() {
                    var $visual = $(".event_wrap .visual");
                    setTimeout(function() {
                        $visual.addClass("intro");
                    }, 100)
                })
            </script>
        </div>
        <!-- //visual -->
        <!-- 탭 -->
        <div class="section floattab">
            <div class="contents">
                <ul class="floattab__list">
                    <li><a href="/mobilefirst/event2021/summer_evt.jsp" class="active">무더위 극-복권 긁으러 GO</a></li>
                    <li><a href="/mobilefirst/event2021/summer_deal.jsp" class="">매주 수요일 타임특가</a></li>
                    <li><a href="/mobilefirst/event2021/summer.jsp" class="">여름을 시원하게! 무더위 기획전</a></li>
                </ul>
            </div>
        </div>
        <!-- /탭 -->

        <!-- 이벤트01 -->
        <div class="section event_01">
            <div class="bg"><img src="http://img.enuri.info/images/event/2021/summer_pro/w_evt01_bg.png"></div>
            <div class="inner">
                <h3 class="animated" data-animate="slideup" data-duration="1"><img src="http://img.enuri.info/images/event/2021/summer_pro/mobile/m_lottery_tit.png"></h3>
                <div class="prize_img animated" data-animate="slideup" data-duration="1"><img src="http://img.enuri.info/images/event/2021/summer_pro/w_lottery_prize.png"></div>
                <div class="lottery_area animated" data-animate="slideup" data-duration="1">
                    <div class="scratchpad_wrap">
                        <div id="lottery" class="scratchpad"></div>
                        <!-- <div id="lottery-percent"></div>-->
                        <!--210701 : #시작전 커버추가 -->
						<div class="scratchpad_cover">
							<div class="btn_start_scratch"><img src="http://img.enuri.info/images/event/2021/summer_pro/mobile/btn_start.png"></div>
						</div>
                    </div>
                </div>
                <div class="area_noti">
                    <button class="btn_caution btn__evt_on_slide" data-laypop-id="layPop1">꼭! 확인하세요</button>
                </div>
            </div>
        </div>
        <div id="layPop1" class="evt_slide">
            <div class="evt_notice--inner wide">
                <!-- .wide - 넓은 케이스 -->
                <div class="evt_slide--head">유의사항</div>
                <div class="evt_slide--cont">
                    <div class="evt_slide--continner">
                        <ul class="list_dot list">
                        	<li>이벤트 참여 : ID당 1회 참여 가능</li>
                            <li>이벤트 혜택 :
                                <ul class="list_hyphen">
                                	<li style="color:red;">※실물경품의 경우 2021년 9월 15일 당첨자 개별 연락 후 일괄 배송됩니다.</li>
                                    <li>에이비아 AVIA DE100 (실물경품) – 5명 당첨</li>
                                    <li>오아 디지털 LED 체중계 (실물경품) – 10명 당첨</li>
                                    <li>오난코리아 루메나 N9-FAN MINI 라인프렌즈 (실물경품/색상랜덤) – 20명 당첨<br>
                                    </li>
                                    <li>던킨도너츠 아메리카노s 1잔 & 먼치킨 10개팩 (e머니 7,000점) – 40명 당첨</li>
                                    <li>이디야커피 꿀복숭아 플랫치노 (e머니 3,500점) – 70명 당첨</li>
                                    <li>세븐일레븐 롯데 매일우유 소프트콘185ml (e머니 1,800점) – 100명 당첨</li>
                                    <li>e머니 100점 – 1,000명 당첨</li>
                                    <li>e머니 0점 (꽝)</li>
                                </ul>
                            </li>
                            <li>e머니 유효기간 : 적립일로부터 15일</li>
                            <li>이벤트 참여 시 개인정보 수집에 동의하신 것으로 간주됩니다.</li>
                            <li>이벤트의 원활한 진행을 위해 당첨자의 참여일시, 참여자ID, 본인인증확인(CI, DI)가 수집되며 수집된 개인정보는 이벤트 참여확인을 위한 본인확인 이외의 목적으로 활용되지 않습니다.</li>
                            <li>개인정보 수집자(에누리 가격비교)는 이벤트 기간 동안 개인정보를 수집하며, 이벤트 당첨자 발표 후 개인정보를 즉시 파기합니다.</li>
                            <li>잘못된 정보 입력이나, 3회 이상 통화 시도에도 연락이 되지 않을 경우의 경품수령 불이익은 책임지지 않습니다.
                            <li>적립된 e머니는 e머니 스토어에서 다양한 e쿠폰으로 교환 가능합니다.</li>
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

        <!-- 에누리 혜택 -->
        <div class="otherbene">
            <div class="contents">
                <h3 class="animated" data-animate="slideup" data-duration="1">놓칠 수 없는 특별한 혜택, 에누리 혜택</h3>
                <ul class="banlist">
                    <li class="animated" data-animate="slideleft" data-duration="1">
                        <a href="http://www.enuri.com/event2020/welcome_evt.jsp" target="_blank" title="새창으로 이동">
                            <img src="http://img.enuri.info/images/event/2021/summer_pro/mobile/m_other_b1.jpg">
                        </a>
                    </li>
                    <li class="animated" data-animate="slideright" data-duration="1">
                        <a href="http://www.enuri.com/evt/visit.jsp#evt1" target="_blank" title="새창으로 이동">
                            <img src="http://img.enuri.info/images/event/2021/summer_pro/mobile/m_other_b2.jpg">
                        </a>
                    </li>
                    <li class="animated" data-animate="slideleft" data-duration="1">
                        <a href="http://www.enuri.com/m/event/buy_stamp.jsp#tab4" target="_blank" title="새창으로 이동">
                            <img src="http://img.enuri.info/images/event/2021/summer_pro/mobile/m_other_b3.jpg">
                        </a>
                    </li>
                    <li class="animated" data-animate="slideright" data-duration="1">
                        <a href="http://www.enuri.com/eventPlanZone/jsp/shoppingBenefit.jsp" target="_blank" title="새창으로 이동">
                            <img src="http://img.enuri.info/images/event/2021/summer_pro/mobile/m_other_b4.jpg">
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
                                <span id="txtURL" class="txt__share_url">http://www.enuri.com/mobilefirst/event2021/summer_evt.jsp</span>
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
                $(function() {
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
        <!-- 딤레이어 : 모바일 앱 전용 이벤트 당첨!!-->
        <div id="scratch_result" class="pop-layer" style="display:none;">
            <div class="popupLayer">
                <div class="dim"></div>
            </div>
            <!-- popup_box -->
            <div class="popup_box guide">
                <img class="result_img" src="/">
                <a class="btn layclose" href="#" onclick="onoff('scratch_result');return false"><em>팝업 닫기</em></a>
            </div>
            <!-- //popup_box -->
        </div>
    </div>
    <!--<a href="#top" class="btn_top"><i>TOP</i></a> -->
    <script>
/*         (function(global, $) {
            // 상단 메뉴 스크롤 시, 고정
            var $nav = $('.floattab'),
                $menu = $('.floattab__list li'),
                $flyingbnr = $(".floating_bnr"),
                // $contents = $('.scroll'),
                $navheight = $nav.outerHeight(), // 상단 메뉴 높이
                $navtop = Math.ceil($nav.offset().top); // floattab 현재 위치;

            // menu class 추가
            $(window).scroll(function() {
                var $scltop = Math.ceil($(window).scrollTop()); // 현재 scroll

                if ($scltop > $navtop - 260) $flyingbnr.addClass("is-fixed")
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
        }(window, window.jQuery)); */

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
            var mid = document.getElementById(id);
            if (mid.style.display == '') {
                mid.style.display = 'none';
            } else {
                mid.style.display = '';
            }
        }
    
	function rewards(result){
		$.ajax({
			type: "GET",
			url: "/mobilefirst/evt/ajax/summer2021_setlist.jsp",
			data:{
				"emoney" : numberWithCommas(result),
				"procCode" : 3,
				"sdt" : sdt
			},
			dataType: "JSON",
			success: function(json){
			}
		});
	}
	
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	var vImg;
	var vResult;
	$('.btn_start_scratch').on('click', function(){
		$(this).parent().remove();
		
		// 회원여부 기본 false;
	    var isMember = islogin();
		if(isMember)  {
			getEventAjaxData( {"procCode":1} , function(data) {
				// 1 -  에이비아 AVLA DE4100
				// 2 -  오아 디지털 LED 체중계
				// 3 - 루메나 N9-FAN 라인프렌즈
				// 7000 - 던킨도너츠 아메리카노&먼치킨
				// 3500 - 이디야커피 꿀복숭아 플랫치노
				// 1800 - 세븐일레븐 매일우유 소프트콘
				// 100 -  e머니 100점
				// 0 - 꽝
				vResult = data.result;
				if(vResult == 0) {
					vImg = "./loser.jpg"; //꽝
					//$("#lottery > img").attr("src" , vImg);
				}else if(vResult > 0){
					vImg = "./winner.jpg"; //당첨
					//$("#lottery > img").attr("src" , vImg);
				}else if(vResult == -1 || vResult == -10){
					alert("이미 참여하셨습니다.");
					return;
				}else if(vResult == -2 || vResult == -99){
					alert("임직원은 참여 불가합니다.");
					return;
				}else if(vResult == -55){
					alert("잘못된 접근입니다.");
					return;
				}else if(vResult == -1225){
					alert("이미 참여 하셨습니다.");
					return;
				}else{
					return;
				}
				if(vResult >= 0){
					$('#lottery').wScratchPad({
						size: 30,
						realtime : true,
						bg : vImg,
						fg: './cover.jpg', 
						cursor : 'url("http://img.enuri.info/images/event/2021/summer_pro/mobile/coin_s30.png?v=2") 15 15, default',
						scratchMove: function (e, percent) {
							if (percent > 60 && percent < 99) {
								this.clear();
								$("#scratch_result .result_img").attr('src','http://img.enuri.info/images/event/2021/summer_pro/mobile/m_lottery_result_'+ vResult +'.jpg?v=1');
								$("#scratch_result").show();
							} else if (percent === 100) {
								this.enable(false);
							}
						}
					});
					if(vResult > 3){
						rewards(vResult);
					}
				}
			});

		} else {
			$('#lottery').wScratchPad('enable', false).css('background', 'url("./cover.jpg")').on('click', function(){alert("로그인 후 이용 가능합니다.");goLogin();});
		}
		
	});

        // 애니메이션
        var areaWin = $(window);
        var lastScroll = 0;

        function isScrolledIntoView(target, check) {
            var docViewTop = areaWin.scrollTop();
            var docViewBottom = docViewTop + areaWin.height();
            var elemTop = target.offset().top;
            // return (docViewBottom >= elemTop);
            var animate_nm = target.data('animate');

            if (animate_nm === 'slideup') {
                if (check === 'down') {
                    elemTop = elemTop - target.height();
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
            switch (animate_nm) {
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
            $(document).on("scroll", function() {
                var scroll = $(window).scrollTop();
                if (scroll > position) {
                    var wheelcontrol = 'down'
                } else {
                    var wheelcontrol = 'up'
                }
                position = scroll;

                if (isScrolledIntoView($(item), wheelcontrol)) {
                    $(item).addClass(animate_class + " " + (animate_duration ? animate_duration : ''));
                }
                if (!isScrolledIntoView($(item), wheelcontrol)) {
                    $(item).removeClass(animate_class + " " + (animate_duration ? animate_duration : ''));
                }
            });
        });
    </script>
</div>

<script type="text/javascript">
var oc = '<%=oc%>';
var app = getCookie("appYN"); //app인지 여부

/*
//공통 : 상단 탭 고정
(function (global, $) {
    var $nav = $('.navtab'); // 탭
	var $myarea = $('.myarea');
    $(window).scroll(function () {
        var scroll = $(window).scrollTop();
        if (scroll > $nav.offset().top) {
            $nav.addClass("is-fixed")
			$myarea.addClass("f-nav");
        }else{
            $nav.removeClass("is-fixed")
			$myarea.removeClass("f-nav");
        }
    });
}(window, window.jQuery));

// 공통 : 유의사항 레이어 열기/닫기
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
		var $slide = $(this).closest('.evt_notice--slide')
		$slide.slideToggle();
		$slide.prev('.com__evt_notice').find(".btn__evt_notice").removeClass("on");
		$('html,body').stop(0).animate({scrollTop:$slide.siblings(".com__evt_notice").offset().top - 50});
	})
});
*/

// 공통 :  하단 컨텐츠로 바로 진입시 포지션 보정을 위한 스크립트 처리
$(function(){
	if(window.location.hash) {
		var $hash = $("#"+window.location.hash.substring(1));
		var navH = $(".navtab").outerHeight();
		if ( $hash.length ){
			$("html,body").stop(true,false).animate({"scrollTop": $hash.offset().top - navH},"slow");
		}
	}
});

var vEvent_title = "21년 무더위 통합기획전";
var gaLabel = [  vEvent_title+"_PV"
				,vEvent_title+"_상단탭_단순참여 이벤트"
				,vEvent_title+"_상단탭_타임딜"
				,vEvent_title+"_상단탭_기획전"
				,vEvent_title+"_상단플로팅배너"
				,vEvent_title+"_무더위 극-복권 이벤트 참여"
				,vEvent_title+"_혜택배너"
				,vEvent_title+"_타임딜_상품보기"
				,vEvent_title+"_타임딜_APP구매하기"
				,vEvent_title+"_타임딜_썸네일"
				,vEvent_title+"_구매이벤트_기획전이동"
				,vEvent_title+"_구매이벤트_참여"
				,vEvent_title+"_여름가전템_에어컨"
				,vEvent_title+"_여름가전템_냉방기기"
				,vEvent_title+"_여름가전템_냉풍기/쿨매트"
				,vEvent_title+"_여름가전템_상품클릭"
				,vEvent_title+"_여름가전템_더보기"
				,vEvent_title+"_휴가 치트키템_물놀이용품"
				,vEvent_title+"_휴가 치트키템_패션"
				,vEvent_title+"_휴가 치트키템_카메라/액션캠"
				,vEvent_title+"_휴가 치트키템_상품클릭"
				,vEvent_title+"_휴가 치트키템_더보기"
				,vEvent_title+"_홈캉스템_화장품"
				,vEvent_title+"_홈캉스템_모기퇴치용품"
				,vEvent_title+"_홈캉스템_컴퓨터/게임기"
				,vEvent_title+"_홈캉스템_상품클릭"
				,vEvent_title+"_홈캉스템_더보기"
				,vEvent_title+"_차가워템_홈카페"
				,vEvent_title+"_차가워템_과일"
				,vEvent_title+"_차가워템_기프티콘"
				,vEvent_title+"_차가워템_상품클릭"
				,vEvent_title+"_차가워템_더보기"
				 ];

$(document).ready(function(){
	var vToday = <%=intToday %>;
	
	ga_log(1);

	// 앱으로 보기
	$(".btn_go_app").click(function(){
		view_moapp();
	});

	$(".navtab_list").find("li").click(function(){
		if($(this).index()==0){
			ga_log(2);
		}else if($(this).index()==1){
			ga_log(3);
		}else{
			ga_log(4);
		}
	});
	$("#floating_bnr").click(function(){
		ga_log(5);
		//딜페이지 경로 수정
		location.href = "/mobilefirst/event2021/summer_deal.jsp?tab=05";
		return false;
	});
	$(".share_list").click(function(){
		ga_log(11);
	});
	
	//에누리 혜택 로그
	$(".ben_item--01, .ben_item--02, .ben_item--03, .ben_item--04").click(function(){
		ga_log(7);
	});
	
});

// 공유하기 링크로 진입 시, 팝업 노출(모웹)
if(oc == "sns" && app != 'Y'){ //수정
	//var url = "enuri://freetoken/?url=http%3a%2f%2fdev.enuri.com%2fmobilefirst%2fevent2021%2fnewyear_2021_evt.jsp";
	$('.lay_only_mw').show();
}

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

var evntPage = "";

window.onload = function(){
	evntPage = $(location).attr('href');
	if(evntPage.indexOf("_evt") > -1){ //수정
		$(".navtab_inner .navtab_list .navtab_item--01").parent("li").addClass("is-on");
		$("#txtURL").text("http://"+location.host+"/mobilefirst/event2021/summer_evt.jsp?oc=sns");
	}else if(evntPage.indexOf("_deal") > -1){
		$(".navtab_inner .navtab_list .navtab_item--02").parent("li").addClass("is-on");
		$("#txtURL").text("http://"+location.host+"/mobilefirst/event2021/summer_deal.jsp?oc=sns");
	}else{
		$(".navtab_inner .navtab_list .navtab_item--03").parent("li").addClass("is-on");
		$("#txtURL").text("http://"+location.host+"/mobilefirst/event2021/summer.jsp?oc=sns");
	}
}

//sns 공유하기 함수
function shareSns(param){ //수정
	var share_url = "";
	
	if(evntPage.indexOf("_evt") > -1){
		share_url = "http://" + location.host + "/mobilefirst/event2021/summer_evt.jsp?oc=sns";
	}else if(evntPage.indexOf("_deal") > -1){
		share_url = "http://" + location.host + "/mobilefirst/event2021/summer_deal.jsp?oc=sns";
	}else{
		share_url = "http://" + location.host + "/mobilefirst/event2021/summer.jsp?oc=sns";
	}
	var share_title = "[에누리 가격비교] 2021 무더위 통합기획전 – 최저가 쇼핑은 에누리";
	var share_description = "온 가족 타임특가! 매주 수요일마다 터지는 득템의 기회!";
	var imgSNS = "<%=strShareImg%>";
	if(param == "face"){
		try{
			window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
			//ga("send", "event", "mf_event", vEvent_title +"_APP", "공유하기_페이스북");
		}catch(e){
			window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
			//ga("send", "event", "mf_event", vEvent_title +"_WEB", "공유하기_페이스북");
		}
	}else if(param == "kakao"){
		share_title = "[에누리 가격비교] 시원함에누리다!";
		share_description = "매주 수요일 타임특가도 만나보세요!";
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
		var share_title_twi = "[에누리 가격비교] 시원함에누리다! 매주 수요일 타임특가도 만나보세요!";
		window.open("https://twitter.com/intent/tweet?text="+encodeURIComponent(share_title_twi)+"&url="+share_url);
	}
}

////////////////////////////////////////////////////////////////////////////////
var app = getCookie("appYN"); //app인지 여부
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로
var isFlow = "<%=flow%>" == "ad";
var vOs_type = getOsType();
var state = false;
var tab = "<%=tab%>";
var vServerNm = '<%=strServerNm%>';

function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var url = "";
	url = encodeURIComponent("http://"+location.host+"/mobilefirst/event2021/summer_evt.jsp?freetoken=event");
	var goApp = "enuri://freetoken/?url="+url;
	if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
		goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl="+url;
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
}

$(".go_top").click(function(){		$('body, html').animate({scrollTop:0}, 500);	});

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


/*레이어*/
function onoff(id){
	var mid = $("#"+id);
	if(mid.css("display") !== "none"){
		mid.css("display","none");
	}else{
		mid.css("display","");
	}
}

var userId = "<%=cUserId%>";
$(document).ready(function() {
	if(tab == '01'){
		$('html, body').stop().animate({scrollTop: Math.ceil($('#evt1').offset().top- $(".navtab").outerHeight())}, 0);
	}
	
	// 개인정보 불러오기
	$("body").append("<iframe id='iframeField'></iframe>");
	$("#iframeField").hide();
	
	$(".ben_item--04").click(function(){
		var url = (app != "Y" ? "/mobilefirst/index.jsp#evt" : "/mobilefirst/renew/plan.jsp?freetoken=main_tab|event")
		window.open(url);
	});
	
	//#애드브릭스
	/* setTimeout(function(){
		welcomeGa("evt_family2021_view");
	},500); */
});

var isClick = true;

var sdt = "<%=strToday%>";
var numSdt = parseInt(sdt);
function getEventAjaxData(params, callback){
	if(numSdt < 20210705){
		alert('오픈예정입니다.');
		return false;
	}
	if(numSdt > 20210808){ //마지막 날짜
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
				location.href="https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
			}else{
				return false;
			}
		}else{
			var evtUrl = "/mobilefirst/evt/ajax/summer2021_setlist.jsp";
			ga_log(6);
			if(typeof params === "object") {
				params.sdt = sdt;
				params.osType = "M";
			}
		    if(!isClick){
		    	return false;
		    }
		    isClick = false;
		    //$.ajaxSetup({ async:false });
			 $.post(evtUrl,params,callback,"json").done(function(){
					isClick = true;
			});
		}
	}
}

function numberWithCommas(x) {   return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");		}

function welcomeGa(strEvent){
	if(app == "Y"){
		try{
			if(window.android){ // 안드로이드 
				window.android.igaworksEventForApp (strEvent);
			}else if(/iPhone|iPad|iPod/i.test(navigator.userAgent)){
				// 아이폰에서 호출
				location.href = "enuriappcall://igaworksEventForApp?strEvent="+strEvent;
			}
		}catch(e){}
	}
}

function getOsType() {
	var osType = "";
	if (app == 'Y') {
		if (navigator.userAgent.indexOf("Android") > -1)
			osType = "MAA";
		else
			osType = "MAI";
	} else {
		if (navigator.userAgent.indexOf("Android") > -1)
			osType = "MWA";
		else
			osType = "MWI";
	}
	return osType;
}
	</script>
	<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
</body>
<script  language="JavaScript">
	insertLog(25140);
</script>
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>