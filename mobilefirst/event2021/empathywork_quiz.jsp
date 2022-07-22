<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
String strFb_title = "[에누리 가격비교] NEW 직장공감 공유하기 이벤트";
String strFb_description = "새롭게 바뀐 NEW 직장공감 친구에게 공유하고 스타벅스 받자!";
String strFb_img = ConfigManager.IMG_ENURI_COM+"/images/event/2021/empathywork/sns_1200_630.jpg";

if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{ //pc일때 접속페이지 변경.
	response.sendRedirect("/event/officeworker/officeworker_2021.jsp");
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

String strEventId = "2021041501";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<META NAME="description" CONTENT="<%=strFb_description%>">
	<META NAME="keyword" CONTENT="에누리가격비교, 프로모션, NEW 직장공감 공유하기 이벤트">
	<meta property="og:title" content="<%=strFb_title%>">
	<meta property="og:description" content="<%=strFb_description%>">
	<meta property="og:image" content="<%=strFb_img%>">
	<meta name="format-detection" content="telephone=no" />
	<!-- 프로모션 공통 CSS (Mobile) -->
	<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
	<link rel="stylesheet" href="/css/event/y2021_rev/empathywork_m.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<script type="text/javascript" src="/common/js/lib/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/common/js/function.js?v=20190102"></script>
	<script type="text/javascript" src="/mobilefirst/js/utils.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
	<script type="text/javascript" src="/common/js/paging_evt.js"></script>
	<script type="text/javascript" src="/js/swiper.min.js"></script>
</head>
<body>
<!-- 200825 : SR#41896 : [MO] SNS 공유 딥링크 연결 팝업  -->
<div class="lay_only_mw" style="display:none;">
	<div class="lay_inner">
		<div class="lay_head">
			앱에서는 득템의 기회 <em>타임특가</em>에 참여할 수 있어요!
		</div>
		<!-- 버튼 : 에누리앱으로 보기 -->
		<button class="btn_go_app" onclick="alert('APP으로 보기');">에누리앱으로 보기</button>
		<!-- 버튼 : 모바일웹으로 보기 -->
		<a href="javascript:void(0);" class="btn_keep_mw" onclick="$('.lay_only_mw').fadeOut(100);">괜찮아요. 모바일 웹으로 볼래요</a>
	</div>
</div>
<!-- // -->

<div id="eventWrap">

	<div class="myarea">
		<%if(cUserId.equals("")){%>	
			<p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>	
		<%}else{%>
			<p class="name"><%=userArea%> 님<span id="my_emoney">0점</span></p>
		<%}%>
		<a href="javascript:///" class="win_close">창닫기</a>
	</div>
	
	<div class="toparea">		
		<!-- 공통 : 공유하기 버튼  -->
		<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
		<!-- // -->

		<!-- 공통 : 상단비주얼 -->
		<div class="visual">
			<div class="inner">
			</div>
		</div>
		
	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<!-- T1 이벤트 : 퀴즈풀기 -->
    <div class="quiz_wrapper">
        <!-- T1 이벤트 : 퀴즈 풀기 -->
        <div class="section event_quiz" id="evt1">
            <div class="contents">
                <div class="quiz__tit">
                    <h1 class="tit">직장인 능력 고사</h1>
                </div>
                <script>
                    // 상단 타이틀 등장 모션
                    var visualLoad = function(){
                        var $visual = $(".event_quiz");
                        $visual.addClass("intro");
                        setTimeout(function(){
                            $visual.addClass("end");
                        },100)
                    }
                    $(window).on({
                        "load" : visualLoad
                    })
                </script>

                <div class="quiz_box">
                    <!-- 퀴즈풀기 Q.1~10 -->
                    <div class="swiper-container quiz__swiper swiper-no-swiping">
                        <div class="swiper-wrapper">
                            <!-- 문제1번 -->
                            <div class="swiper-slide quiz__item">
                                <div class="q_question">
                                    <p class="q_count">Q. 1</p>

                                    <p class="q_txt">‘담당자가 자리를 비워’의<br>숨은 뜻이 아닌 것은??</p>
                                </div>

                                <ul class="q_example">
                                    <li data-point="0"><em>저는 담당자가 아닙니다.</em></li>
                                    <li data-point="1"><em>제가 대신 처리하겠습니다.</em></li>
                                    <li data-point="0"><em>내 업무가 아니다 돌아가</em></li>
                                    <li data-point="0"><em>담당자가 올 때 까지 기다려라</em></li>
                                </ul>								
                            </div>
                            
                            <!-- 문제2번 -->
                            <div class="swiper-slide quiz__item">
                                <div class="q_question">
                                    <p class="q_count">Q. 2</p>

                                    <p class="q_txt">퇴티튜드의 뜻으로<br>단어는?</p>
                                </div>

                                <ul class="q_example">
                                    <li data-point="0"><em>유튜브를 하기 위해 퇴사하는 사람</em></li>
                                    <li data-point="0"><em>퇴근하고 싶은 사람의 태도</em></li>
                                    <li data-point="1"><em>퇴사를 앞둔 사람의 태도</em></li>
                                    <li data-point="0"><em>공부를 위해 퇴사하는 사람</em></li>
                                </ul>								
                            </div>
                            
                            <!-- 문제3번 -->
                            <div class="swiper-slide quiz__item">
                                <div class="q_question">
                                    <p class="q_count">Q. 3</p>

                                    <p class="q_txt">꼭빼기를 뜻하는 단어는?</p>
                                </div>

                                <ul class="q_example">
                                    <li data-point="0"><em>일 시키려고 하면 꼭 안 보이는 사람</em></li>
                                    <li data-point="0"><em>이런 저런 이유로 야근을 꼭 안 하는 사람</em></li>
                                    <li data-point="1"><em>일 시키면 꼭 하나씩 빼먹는 사람</em></li>
                                    <li data-point="0"><em>출근하자마자 꼭 커피 사러 가는 사람</em></li>
                                </ul>								
                            </div>
                            
                            <!-- 문제4번 -->
                            <div class="swiper-slide quiz__item">
                                <div class="q_question">
                                    <p class="q_count">Q. 4</p>

                                    <p class="q_txt">직장인들이 사용하는<br>십시일반과 거리가 먼 뜻은?</p>
                                </div>

                                <ul class="q_example">
                                    <li data-point="1"><em>늦게 출근하고 밤 10시 퇴근</em></li>
                                    <li data-point="0"><em>하루 노동시간이 10시간 이상</em></li>
                                    <li data-point="0"><em>한 달에 10번 이상 야근</em></li>
                                    <li data-point="0"><em>보통 밤 10시까지 야근</em></li>
                                </ul>								
                            </div>
                            
                            <!-- 문제5번 -->
                            <div class="swiper-slide quiz__item">
                                <div class="q_question">
                                    <p class="q_count">Q. 5</p>

                                    <p class="q_txt">직장인들이 점심시간에<br>짬을 내서 할 수 없는 것은?</p>
                                </div>

                                <ul class="q_example">
                                    <li data-point="1"><em>상사와 업무얘기</em></li>
                                    <li data-point="0"><em>운동 또는 취미활동</em></li>
                                    <li data-point="0"><em>은행, 병원 다녀오기</em></li>
                                    <li data-point="0"><em>소개팅</em></li>
                                </ul>								
                            </div>
                            
                            <!-- 문제6번 -->
                            <div class="swiper-slide quiz__item">
                                <div class="q_question">
                                    <p class="q_count">Q. 6</p>

                                    <p class="q_txt">알딱깔센의 뜻은?</p>
                                </div>

                                <ul class="q_example">
                                    <li data-point="0"><em>알아봐 딱 깔쌈하고 센스있게</em></li>
                                    <li data-point="0"><em>알겠어? 딱 깔 거 없이 센스있게</em></li>
                                    <li data-point="0"><em>알고 봐도 딱 깔끔하고 센스있게</em></li>
                                    <li data-point="1"><em>알아서 잘 딱 깔끔하고 센스있게</em></li>
                                </ul>								
                            </div>
                            
                            <!-- 문제7번 -->
                            <div class="swiper-slide quiz__item">
                                <div class="q_question">
                                    <p class="q_count">Q. 7</p>

                                    <p class="q_txt">직장인들이 사용하는<br>언어를 뜻하는 단어는?</p>
                                </div>

                                <ul class="q_example">
                                    <li data-point="0"><em>급식체</em></li>
                                    <li data-point="0"><em>학식체</em></li>
                                    <li data-point="0"><em>궁서체</em></li>
                                    <li data-point="1"><em>급여체</em></li>
                                </ul>								
                            </div>
                            
                            <!-- 문제8번 -->
                            <div class="swiper-slide quiz__item">
                                <div class="q_question">
                                    <p class="q_count">Q. 8</p>

                                    <p class="q_txt">직장인이<br>꿈꾸는 밝은 미래와<br>거리가 가장 먼 것은?</p>
                                </div>

                                <ul class="q_example">
                                    <li data-point="1"><em>매년 조금씩 인상되는 연봉</em></li>
                                    <li data-point="0"><em>로또, 연금복권 당첨</em></li>
                                    <li data-point="0"><em>주식, 비트코인 떡상</em></li>
                                    <li data-point="0"><em>조상님이 숨겨 논 재산 상속</em></li>
                                </ul>								
                            </div>
                            
                            <!-- 문제9번 -->
                            <div class="swiper-slide quiz__item">
                                <div class="q_question">
                                    <p class="q_count">Q. 9</p>

                                    <p class="q_txt">회사에서 몰래 쇼핑하다<br>상사가 지나갈 때<br>눌러야 하는 단축키는?</p>
                                </div>

                                <ul class="q_example">
                                    <li data-point="0"><em>F5</em></li>
                                    <li data-point="1"><em>Ctrl + W</em></li>
                                    <li data-point="0"><em>Alt + Tab</em></li>
                                    <li data-point="0"><em>Windows Key + Tap</em></li>
                                </ul>								
                            </div>
                            
                            <!-- 문제10번 -->
                            <div class="swiper-slide quiz__item">
                                <div class="q_question">
                                    <p class="q_count">Q. 10</p>

                                    <p class="q_txt">상사가 보낸 업무 메일에<br>아삽 (A.S.A.P)이라고 적혀있을 때<br>취해야 하는 옳은 행동은?</p>
                                </div>

                                <ul class="q_example">
                                    <li data-point="0"><em>천천히 느긋하게 업무를 진행한다</em></li>
                                    <li data-point="0"><em>오늘 안에 업무를 진행한다</em></li>
                                    <li data-point="1"><em>최대한 빠르게 업무를 진행한다</em></li>
                                    <li data-point="0"><em>내일까지 업무를 진행한다</em></li>
                                </ul>								
                            </div>

                            <!-- 로딩 슬라이드 -->
                            <div class="swiper-slide">
                                <div class="quiz__loading">
                                    <div class="contents">
                                        <!-- 로딩 1초 후 결과 이동 -->
                                        <div class="lds-dual-ring"></div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <p class="quiz__count"><em>1</em>/10</p>
                    <!-- //퀴즈풀기 Q.1~10 -->
                </div>

                <script>
                    // 퀴즈 스와이퍼 생성
                    var quizSwiper = new Swiper(".quiz__swiper", {
                        loop : false,
                        slidesPerView : 1,
                        spaceBetween : 0,
                        autoHeight : true
                    });
                    quizSwiper.on("onSlideChangeEnd", function(e){
                        var _idx = e.activeIndex+1; // 현재 슬라이드 Index

                        $(".quiz__count > em").text(_idx);
                    })
                </script>
            </div>
        </div>
        <!-- // T1 이벤트 : 퀴즈 풀기 -->

        <!-- T1 이벤트 : 퀴즈 결과 -->
        <div class="section event_result" id="evt1_result" style="display:none">
            <div class="contents">
                <div class="quiz__tit">
                    <h1 class="tit">생존력 A등급 - <em>차장</em></h1>
                </div>

                <div class="quiz_result_box">
                    <div class="result_img">						
                        <div class="grade1"><img src="http://img.enuri.info/images/event/2021/empathywork/m_result_img1.png" alt="S등급 - 부장(팀장)" /></div>
                        <div class="grade2"><img src="http://img.enuri.info/images/event/2021/empathywork/m_result_img2.png" alt="A등급 - 차장" /></div>
                        <div class="grade3"><img src="http://img.enuri.info/images/event/2021/empathywork/m_result_img3.png" alt="B등급 - 과장" /></div>
                        <div class="grade4"><img src="http://img.enuri.info/images/event/2021/empathywork/m_result_img4.png" alt="C등급 - 대리" /></div>
                        <div class="grade5"><img src="http://img.enuri.info/images/event/2021/empathywork/m_result_img5.png" alt="F등급 - 사원" /></div>
                    </div>

                    <div class="sns_box">
                        <p class="sns_tit">내 결과 공유하기</p>

                        <ul class="sns_list" id="share_list">
		                    <li id="kakao-link-btn2"><button type="button" title="카카오톡 공유하기">카카오톡</button></li>
		                    <li><button type="button" title="페이스북 공유하기">페이스북</button></li>
		                    <li><button type="button" title="트위터 공유하기">트위터</button></li>
		                    <li><button type="button" title="URL 복사" data-clipboard-text="http://m.enuri.com/mobilefirst/event2021/empathywork_evt.jsp" class="btn_co">URL 복사</button></li>
		                </ul>

                        <div class="btn_group">
                            <button type="button" class="btn btn_result">다른 결과 보러가기</button>
                            <button type="button" class="btn btn_restart">다른 결과 보러가기</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- // T1 이벤트 : 퀴즈 결과 -->

        <!-- T1 이벤트 : 퀴즈 다른 결과 -->
        <div class="section event_result_list" id="evt1_resultList" style="display:none">
            <div class="contents">
                <div class="quiz__tit">
                    <h1 class="tit">직장인 능력 고사</h1>
                </div>

                <div class="result_list_box">
                    <p class="tx_tit">다른 결과보기</p>

                    <ul class="result_list">
                        <li class="is-on">
                            <span class="tx_thum"><img src="http://img.enuri.info/images/event/2021/empathywork/m_result_list1.png" alt="S등급 - 부장(팀장)" /></span>
                            <p class="tx_grade">생존력 S등급 - <em>부장(팀장)</em></p>
                        </li>
                        <li>
                            <span class="tx_thum"><img src="http://img.enuri.info/images/event/2021/empathywork/m_result_list2.png" alt="A등급 - 차장" /></span>
                            <p class="tx_grade">생존력 A등급 - <em>차장</em></p>
                        </li>
                        <li>
                            <span class="tx_thum"><img src="http://img.enuri.info/images/event/2021/empathywork/m_result_list3.png" alt="B등급 - 과장" /></span>
                            <p class="tx_grade">생존력 B등급 - <em>과장</em></p>
                        </li>
                        <li>
                            <span class="tx_thum"><img src="http://img.enuri.info/images/event/2021/empathywork/m_result_list4.png" alt="C등급 - 대리" /></span>
                            <p class="tx_grade">생존력 C등급 - <em>대리</em></p>
                        </li>
                        <li>
                            <span class="tx_thum"><img src="http://img.enuri.info/images/event/2021/empathywork/m_result_list5.png" alt="F등급 - 사원" /></span>
                            <p class="tx_grade">생존력 F등급 - <em>사원</em></p>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- // T1 이벤트 : 퀴즈 다른 결과 -->
    </div>
    
    <script>	
    $(function(){
        var $quizStart = $("#evt1"),							// 섹션 - 퀴즈풀기 목록
            $quizResult = $("#evt1_result"),					// 섹션 - 퀴즈결과 보기
            $quizResultLIst = $("#evt1_resultList"),			// 섹션 - 다른결과 보기
            $gradeTitle = $(".event_result .quiz__tit .tit"); 	// 결과 등급 타이틀
            
        // 퀴즈 목록 클릭
        var $quizExBtn = $(".q_example > li"),
            totalPoint = 0;		// 퀴즈 토탈 점수

        // 퀴즈풀기
        $quizExBtn.on("click", function(){
            var swiperIdx = $(this).closest(".quiz__item").index(), // 현재 슬라이드 Index
                currPoint = $(this).data("point"); // 선택한 퀴즈 점수

            totalPoint += currPoint;

            //선택한 탭 활성화
            $(this).addClass("is-on").siblings().removeClass("is-on");

            // 9번문항까지 선택시 스와이프
            if(swiperIdx != 9){
                // 0.5초 후 슬라이드 이동
                setTimeout(function(){
                    quizSwiper.slideTo(swiperIdx+1)
                }, 50)
                
            }else{ //로딩 1초 재생 후 결과탭 이동
                setTimeout(function(){
                    quizSwiper.slideTo(swiperIdx+1)
                    $(".quiz__count").hide();

                    setTimeout(function(){
                        $quizStart.fadeOut(300, function(){
                        
                            $(".result_img div").hide();
                            
                            switch(parseInt(totalPoint)){
                                case 0 : case 1: case 2:
                                    $(".grade5").show();
                                    $gradeTitle.html("생존력 F등급 - <em>사원</em>");
                                    break;
                                case 3 : case 4 :
                                    $(".grade4").show();
                                    $gradeTitle.html("생존력 C등급 - <em>대리</em>");
                                    break;
                                case 5 : case 6 :
                                    $(".grade3").show();
                                    $gradeTitle.html("생존력 B등급 - <em>과장</em>");
                                    break;
                                case 7 : case 8 :
                                    $(".grade2").show();
                                    $gradeTitle.html("생존력 A등급 - <em>차장</em>");
                                    break;
                                case 9 : case 10 : 
                                    $(".grade1").show();
                                    $gradeTitle.html("생존력 S등급 - <em>부장(팀장)</em>");
                                    break;
                            }

                            $quizResult.fadeIn(500)
                        })
                    },2000);
                }, 300)
                
                
            }

        })	

        // 퀴즈결과 페이지 내 버튼
        var $btnResult = $(".btn_result"), // 다른결과 보러가기 버튼
            $btnRestart = $(".btn_restart"); // 테스트 다시하기

        $btnResult.on("click", function(){
            $quizResult.fadeOut(300,function(){
                $quizResultLIst.fadeIn(300);
            });            
            return false;
        })

        // 다른결과보기 목록 클릭
        var $resultBtn = $(".result_list > li");

        $resultBtn.on("click", function(){
            var _pointIdx = $(this).index() + 1;
            $(this).addClass("is-on").siblings().removeClass("is-on");

            $(".result_img div").hide();
            $(".grade" + _pointIdx).show();
            // 점수 토탈에 따라 등급 이미지 show 해줌.
            switch(_pointIdx){
                case 5: 
                    $gradeTitle.html("생존력 F등급 - <em>사원</em>"); 
                    break
                case 4: 
                    $gradeTitle.html("생존력 C등급 - <em>대리</em>"); 
                    break
                case 3: 
                    $gradeTitle.html("생존력 B등급 - <em>과장</em>"); 
                    break
                case 2: 
                    $gradeTitle.html("생존력 A등급 - <em>차장</em>"); 
                    break
                case 1: 
                    $gradeTitle.html("생존력 S등급 - <em>부장(팀장)</em>"); 
                    break
            }
            
            $quizResultLIst.fadeOut(300,function(){
                $quizResult.fadeIn(300);
            });
            
        })

        // 테스트 다시하기
        $btnRestart.on("click", function(){
            totalPoint = 0;	
            $quizExBtn.removeClass("is-on");
            $(".quiz__count").show().find("em").text(1);     
            
            quizSwiper.update(true);
            quizSwiper.slideTo(0);  
            
            $quizResult.fadeOut(300,function(){
                $quizStart.fadeIn(300);
            });
            
            location.href="/mobilefirst/event2021/empathywork_evt.jsp";
            
        })
    })
    </script>
    <!-- //T1 이벤트 : 퀴즈풀기 -->

    <!-- T2 이벤트 : 직장인인기상품 -->
    <div class="section event_best" id="evt2">
        <p class="best_tit">직장인 인기 상품</p>
        
        <div class="contents">
            <!-- SWIPER -->
            <div class="swiper-container best__swiper">
                <div class="swiper-wrapper" id="item_list">
                </div>
            </div>
            <!-- //SWIPER -->
            <button type="button" class="arr arr-prev">이전</button>
            <button type="button" class="arr arr-next">다음</button>

            <div class="swiper-pagination"></div>

        </div>
    </div>
    <!-- //T2 이벤트 : 직장인인기상품 -->

	<!-- <span class="go_top"><a href="#">TOP</a></span>  -->
</div>
<!-- // 프로모션 -->
<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
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
						<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2021/empathywork_evt.jsp</span>
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

<script>
Kakao.init('5cad223fb57213402d8f90de1aa27301');
var app = getCookie("appYN"); //app인지 여부
var oc = '<%=oc%>';
var vEvent_title = "NEW 직장공감 공유하기 이벤트";

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
	
    if(islogin()){
    	global_share('kakao');
    }
	
    $(document).ready(function() {
    	
    	if(oc!=""){
    		$('.lay_only_mw').show();
    	}
    	$("#my_emoney").click(function(){	
    		window.location.href = "https://m.enuri.com/my/my_emoney_m.jsp?freetoken=emoney";	//e머니 적립내역
    	});
    	
    	shareSns('kakao');
    	
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
    	
    	if(islogin()){
    		getPoint();
    	}
    });
    
  	//추천상품 상품 영역
	var loadUrl = "/event/ajax/exhibition_ajax.jsp?exh_id=45";

	$.ajax({
		  dataType : "json"
		, url	   : loadUrl
		, cache : false
		, success  : function(result){
			var banner = result.R;
			var tab = result.T;
			var tabSize = 4; //컨텐츠 별 탭 개수
			var listSize = 4; //노출 상품 개수
			var logNo = [17,23,29,35];
			var no = 0;
			var minprice = 0;

				makeHtml = "";
				$.each(tab[0].GOODS, function(i,v){
					minprice = (v.MINPRICE == null) ? 0 : v.MINPRICE;

					if((i % listSize) == 0)	makeHtml += "<div class=\"swiper-slide best_item\">";
					makeHtml += "<div class=\"prdc\">";
					makeHtml += "    <a href='javascript:void(0);' onclick='itemClick("+v.MODELNO+", "+minprice+");' class=\"thum_link\">";
					makeHtml += "        <span class=\"tx_thum\">";
					makeHtml += "            <img src=\""+v.GOODS_IMG+"\" alt=\"\" onerror = 'replaceImg(this);' />";
					if(minprice == 0 || minprice == null) makeHtml += "<span class='soldout'>soldout</span> <!-- 품절시 노출 -->";
					makeHtml += "        </span>";
					makeHtml += "        <span class=\"tx_name\">"+v.TITLE1+"<br>"+v.TITLE2+"</span>";
					makeHtml += "        <span class=\"tx_price\">최저가 <em>"+commaNum(minprice)+"</em>원</span>";
					makeHtml += "    </a>";
					makeHtml += "</div>";
					
					if(i % listSize == (listSize - 1) || i == tab[0].GOODS.length) makeHtml += "</div>";
				});
				$('#item_list').html(makeHtml);
		}
		, complete : function(){

			//상품 슬릭
            var bestSwiper = new Swiper(".best__swiper", {
                loop: true,
                slidesPerView : 1,
                spaceBetween : 10,
                prevButton : '.event_best .arr-prev',
                nextButton : '.event_best .arr-next',
                pagination : '.event_best .swiper-pagination',
                paginationClickable : false,
            });
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
    
    //공유하기 이벤트
    //공유하기 이벤트
	$("#share_list li").unbind();
	$("#share_list li").click(function(){
		da_ga(2);
		if(islogin()){
			var n = $(this).index()+1;
			shareEvent(n);
		}else{
			alert("로그인 후 참여할 수 있습니다.");
			goLogin();
			global_share("kakao");
			return ;
		}
	});
	
	//공유하기 이벤트 참여자
	//공유하기evt
	function shareEvent(n){
		var shareType = n;
		if(n==1) shareType=2;
		else if(n==2) {
			shareType=1;
			shareSns("face");
		}else if(n==3) {
			shareType=4;
			shareSns("twitter");
		}else if(n==4) {
			shareType=3;
			if(ClipboardJS.isSupported()) {
				var clipboard = new ClipboardJS('#share_list .btn_co');
				var cnt = 0;
				clipboard.on('success', function(e) {
					if(cnt==0) alert("복사가 완료되었습니다!");
					cnt++;
				}).on('error', function(e) {
					alert("해당 브라우저는 지원하지 않습니다.");
				});
			}
		}
		var osType = "";
		if(app =='Y'){
	        osType = "MA";
	    }else {
	    	osType = "MW";
	    }
		$.ajax({
			url : "/mobilefirst/evt/ajax/empathywork_setlist.jsp",
			data : {
				"proc" : 1,
				"shareType" : shareType,
				"osType" : osType
			},
			dataType : "JSON",
			success : function(data){
				if(typeof data["result"] !="undefined"){
					if(data["result"]){
						if(n==1){
							global_share('kakao');
						}
					}
				}
			}
		});
	}
	
	function global_share(part){
		var share_url = "http://" + location.host + "/mobilefirst/event2021/empathywork_evt.jsp";
		var share_title = "[에누리 가격비교] NEW 직장공감 공유하기 이벤트";
		var share_description = "새롭게 바뀐 NEW 직장공감 친구에게 공유하고 스타벅스 받자!";
		var imgSNS = "<%=strFb_img%>";
		if(part == "face"){
			shareSns("face");
		}else if(part == "kakao"){
			try{
				Kakao.Link.createDefaultButton({
					container: '#kakao-link-btn2',
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
		}else if (part == "tw") {
			try {
				window.android.android_window_open("http://twitter.com/intent/tweet?text=" + share_title + "&url=" +share_url);
			} catch (e) {
				window.open("http://twitter.com/intent/tweet?text=" + share_title + "&url=" + share_url);
			}
		}
	}
    
    //sns 공유하기 함수
    function shareSns(param){
    	var share_url = "http://" + location.host + "/mobilefirst/event2021/empathywork_evt.jsp";
    	var share_title = "[에누리 가격비교] NEW 직장공감 공유하기 이벤트";
    	var share_description = "새롭게 바뀐 NEW 직장공감 친구에게 공유하고 스타벅스 받자!";
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
    		var share_title_twi = "[에누리 가격비교] 새롭게 바뀐 NEW 직장공감 친구에게 공유하고 스타벅스 받자! ";
    		window.open("https://twitter.com/intent/tweet?text="+share_title_twi+"&url="+share_url);
    	}
    }
  
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
    
    function itemClick(modelNo, minprice) {
    	da_ga(2);
    	if(minprice > 0){
    		window.open('/mobilefirst/detail.jsp?modelno=' + modelNo +'&freetoken=vip');
    	}else{
    		alert("품절된 상품 입니다.");
    	}
    }
    
    function da_ga(num){
    	if(num == 2){
    		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"상품");
    	}
    }
    
    //닫기버튼
    $('.win_close').click(function(){
    	if(getCookie("appYN") == 'Y'){
    		window.location.href = "close://";
    	}else{
    		window.location.replace("/m/index.jsp");
    	}
    });

</script>
</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
