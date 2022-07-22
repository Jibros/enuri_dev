<%@page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page contentType ="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="com.enuri.util.common.ConfigManager"%>
<%
	String strServerNm = request.getServerName();
	String strUserAgent = ChkNull.chkStr(request.getHeader("User-Agent"));
	if(strUserAgent.indexOf("iPhone") > -1 || strUserAgent.indexOf("Android") > -1 || strUserAgent.indexOf("iPod") > -1
			|| strUserAgent.indexOf("iPad") > -1){
	}else{
		response.sendRedirect("http://www.enuri.com/event2021/evtpcdeal.jsp");
	}
	String oc = ChkNull.chkStr(request.getParameter("oc"));
	String chkId   = ChkNull.chkStr(request.getParameter("chk_id"),"");
	String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
	String userNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK"),"");
	
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

%>
<!DOCTYPE html> 
<html lang="ko">
<head>
<meta charset="utf-8">	
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
<title>[에누리 가격비교] 에누리 쓰리고pc</title>
<meta name="description" content="쓰리고PC 조립PC 최저가에 3가치 혜택, 1GO 파격 타임특가! 매월 선착순 최저 특가상품 타임딜, 2GO 추가적립 이벤트! 에누리 앱에서 컴퓨터구매하면 최대 5만점 추가 적립혜택, 3GO 사은품 증정 이벤트! 쓰리고PC 구매 시 스펙UP 또는 사은품 선택 증정, 인텔/AMD 최신 CPU, RTX 3070, RTX 3060, RTX 2060">
<meta name="keywords" content="에누리가격비교, 통합기획전, 가정의달, 오월, 어린이날, 어버이날, 성년의날, 부부의날, 선물, 학생선물">
<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
<meta property="og:title" content="[에누리 가격비교] 에누리 쓰리고PC">
<meta property="og:description" content="최저가는 기본! 할인, 적립, 사은품까지 쓰리고~">
<meta name="format-detection" content="telephone=no" />
<!-- 프로모션 공통 CSS (Mobile) -->
<link rel="stylesheet" type="text/css" href="/css/swiper.css"/> 
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<!-- 프로모션별 커스텀 JS&CSS  -->
<link rel="stylesheet" href="/css/event/y2021_rev/threegopc_m.css?v=20210915" type="text/css">
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/js/clipboard.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
<script type="text/javascript" src="/event2016/js/event_common.js"></script>
<script>
	var userId = "<%=userId%>";
	var username = "<%=userArea%>"; //개인화영역 이름
	var vChkId = "<%=chkId%>";
	var vEvent_page = "<%=strUrl%>"; //경로
	var ssl = "<%=ConfigManager.ENURI_COM_SSL%>";
</script>
</head>

<body>
<!-- 200825 : SR#41896 : [MO] SNS 공유 딥링크 연결 팝업  -->
<div class="lay_only_mw" style="display:none;" >
	<div class="lay_inner">
		<div class="lay_head">
			앱에서는 득템의 기회 <em>타임특가</em>에 참여할 수 있어요!
		</div>
		<!-- 버튼 : 에누리앱으로 보기 -->
		<button class="btn_go_app">에누리앱으로 보기</button>
		<!-- 버튼 : 모바일웹으로 보기 -->
		<a href="javascript:void(0);" class="btn_keep_mw" onclick="$('.lay_only_mw').fadeOut(100);">괜찮아요. 모바일 웹으로 볼래요</a>
	</div>
</div>
<!-- // -->

<div id="eventWrap">
		<div class="myarea">
			<p class="name">
				나의 <em class="emy">머니</em>는 얼마일까?
				<button type="button" class="btn_login" onclick="goLogin();">로그인</button>
			</p>
			<a href="javascript:///" class="win_close">창닫기</a>
		</div>

		<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">		
		<!-- 공통 : 공유하기 버튼  -->
		<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
		<!-- // -->

        <!-- 공통 : 상단 비쥬얼 -->
        <div class="section visual">
            <div class="inner">
                <h1 class="tx_tit">쓰리(3)고 PC</h1>
                <span class="tx_sub">최저가에 3가지 혜택까지</span>

                <div class="move_coin"><!--코인--></div>
				<div class="move_3go">
                    <span class="go_1" onclick="$('html, body').stop().animate({scrollTop: $('#evt1').offset().top - 35}, 500);">1GO - 할인받고 무조건 최저가 타임특가</span>
                    <span class="go_2" onclick="$('html, body').stop().animate({scrollTop: $('#evt2').offset().top - 35}, 500);">2GO - 적립받고 쓰리고PC 사면 E머니 추가적립</span>
                    <span class="go_3" onclick="$('html, body').stop().animate({scrollTop: $('#evt3').offset().top - 35}, 500);">3GO - 사은품받고 스펙UP/사은품 100% 증정</span>
                </div>
                
                <div class="loader-box">
                    <div class="visual-loader"></div>
                </div>
            </div>
            
            <script>
                // 상단 타이틀 등장 모션
                var visualLoad = function(){
                    var $visual = $(".toparea .visual");
                    $visual.addClass("intro");
                    setTimeout(function(){
                        $visual.addClass("end");
                    },100)
                }
                $(window).on({
                    "load" : visualLoad
                })
            </script>
        </div>
        <!-- // -->
        
		
	</div>
	<!-- //비쥬얼,플로팅탭 -->

    <!-- CONT1 -->
    <div class="section cont01" id="evt1">        
        <div class="cont__head">
            <div class="contents">    
                <p class="cont__num">1GO</p>
                <h2 class="cont__tit">파격 타임 특가 매월 한대! 에누리가 제일 싸다GO!</h2>
            </div>
        </div>
        
        <div class="cont__body">
            <div class="contents">
                <!-- 큰이미지 스와이프 -->
                <div class="prdc_swiper--big">
                    <div class="swiper-container">
                        <div class="swiper-wrapper">
                        </div>
                    </div>
                </div>
                <!-- //큰이미지 스와이프 -->


                <!-- 작은이미지 스와이프 -->
                <div class="prdc_swiper--sm">
                    <!-- <div class="tx_tit">지난 특가 상품</div> -->

                    <div class="scroll-cont">
                        <ul id="smallImage">
                        </ul>
                    </div>
                     <!-- 더보기 -->
                    <!--210824 : SR#48384  : 더많은 쓰리고pc보기 추가 : 하단 라인업으로 이동됨.-->
                    <div class="more_threegopc">
                        <a href="">더 많은 쓰리고PC 보기</a>
                    </div>
                    <script>
                        $('.more_threegopc a').on('click', function(){
                            $('html,body').animate({scrollTop : $('.cont4').offset().top}, 500);
                            return false;
                        });
                    </script>
                    <!-- // 더보기 -->
                </div>
                <!-- //작은이미지 스와이프 -->
            </div>
            <!--210824 : SR#48384  :  위치이동 기존: cm에게 물었습니다 -> 더많은 쓰리고pc보기 버튼 밑  -->
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
                                <dt>이벤트 유의사항</dt>
                                <dd>
                                    <ul>
                                        <li>타임 특가는 선착순 한정 수량 판매로, 결제 진행 중 상품이 품절될 경우 판매가 종료될 수 있습니다.</li>
                                        <li>상품 구성 및 가격은 업체 사정에 따라 변경될 수 있습니다.</li>
                                        <li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다.</li>
                                        <li>부정 참여 시 본 이벤트 대상 제외 및 결제가 취소될 수 있습니다.</li>
                                        <li>당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
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

            <div class="review_box">
                <div class="contents">
                    <p class="review_tit1">타임 특가 런칭과 동시에 뜨거운 반응!</p>
                    <div class="review_img1">쇼핑몰 리뷰</div>

                    <div class="review_img2">커뮤니티 댓글</div>

                    <p class="review_tit2">에누리 CM에게 물었습니다.</p>
                    <div class="review_img3">CM 문의/답변</div>
                </div>

            </div>
        </div>
    </div>
    <!-- //CONT1 -->
    
    <!-- CONT2 -->
    <div class="section cont02" id="evt2">
        <div class="cont__head">
            <div class="contents">    
                <p class="cont__num">2GO</p>
                <h2 class="cont__tit">추가 적립 이벤트 - 에누리 앱에서 컴퓨터 구매하면 최대 5만점 추가 적립!</h2>
            </div>
        </div>

        <div class="cont__body">
            <div class="contents">
                <div class="detail_box">
                    <p class="blind">기본 0.8% + 추가 1.0%</p>

                    <a href="http://m.enuri.com/mobilefirst/evt/smart_benefits.jsp?#tab4" onclick="ga_log(3);" target="_blank" class="btn_link">신청하기 (※ 이벤트 신청 페이지로 이동합니다.)</a>
                </div>
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
                                        <li>이벤트 대상 : 이벤트 기간 내 1만원 이상 대상 카테고리 상품 구매 후 최대 5만점 추가적립 이벤트 신청한 고객 (※ 대상 카테고리 확인)</li>
                                        <li>이벤트 기간 : [신청하기]를 통해 추가적립 이벤트 신청 페이지에서 확인</li>
                                        <li>이벤트 혜택 : 카테고리별 차등 추가 적립(최대 e머니 50,000점)</li>
                                        <li>e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)<br>
                                            <span class="noti">※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</span></li>
                                    	<li>대상 카테고리별 추가 적립률 및 최대 금액은 이벤트 페이지 유의사항에서 확인 가능합니다.</li>
                                    </ul>
                                </dd>
                            </dl>

                            <dl>
                                <dt>이벤트 참여방법 및 유의사항</dt>
                                <dd>
                                    <ul>
                                        <li>참여방법 : 에누리 가격비교 <span class="stress">모바일 앱 로그인</span> &rarr; 적립대상 쇼핑몰 이동 &rarr; <span class="stress">1만원 이상 대상 카테고리 구매</span> &rarr; 최대 5만점 추가적립 이벤트 신청<br/>
                                            <span class="noti">※ 이벤트 신청의 경우 PC 및 모바일 앱/웹에서 로그인 후에도 가능합니다. </span>
                                        </li>
                                        <li>적립대상 쇼핑몰 : G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), SK스토아, 홈플러스<br/>
                                            <span class="stress">※ 구매 유의사항 및 구매적립 제외 카테고리는 이벤트 페이지 하단 'e머니 구매혜택' 유의사항을 꼭 확인하세요.</span>
                                        </li>
                                        <li>대상 카테고리는 에누리 가격비교 카테고리 기준 입니다.</li>
                                        <li>추가적립금이 100원 미만의 경우 혜택 지급되지 않습니다.</li>
                                        <li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다.</li>
                                        <li>
                                            <span class="stress">이벤트 대상 제외 :</span> 아래의 경우에는 이벤트 대상 및 혜택 지급에서 제외됩니다. <br/>
                                            <ul class="sub">
                                                <li>- 추가적립 이벤트 신청하지 않은 경우</li>
                                                <li>- 실제 구매금액이 1만원 미만의 구매일 경우</li>
                                                <li>- 구매적립 제외 카테고리 구매일 경우 </li>
                                                <li>- 구매 후 취소/환불/교환/반품한 경우</li>
                                                <li>- 동일한 본인인증으로 가입한 다수의 ID로 중복 참여한 경우</li>
                                                <li>- 해외직구 상품 구매일 경우</li>
                                                <li class="stress">- 동일한 이벤트 기간의 VIP맞춤적립 이벤트 혜택받은 경우 (중복 지급 불가)</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </dd>
                            </dl>

                            <dl>
                                <dt>공통 이벤트 유의사항</dt>
                                <dd>
                                    <ul>
                                        <li>부정 참여 시 본 이벤트 대상 제외 및 혜택 지급이 취소될 수 있습니다.</li>
                                        <li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
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
    <div class="section cont03" id="evt3">
        <div class="cont__head">
            <div class="contents">    
                <p class="cont__num">3GO</p>
                <h2 class="cont__tit">사은품 증정 이벤트 - 쓰리고PC 구매 시 스펙 UP or 사은품 100% 증정</h2>
            </div>
        </div>

        <div class="cont__body">
            <div class="contents">
                <div class="detail_box">
                    <p class="blind">메모리 용량추가(스펙UP) 또는 게이밍마우스(사은품증정)</p>

                    <a href="http://www.enuri.com/detail.jsp?modelno=31214621" target="_blank" class="btn_prdc">상품 정보 보러가기 (※ 재고 소진 시 이벤트 상품이 변경 될 수 있습니다.)</a>
                    <a href="javascript:///" class="btn_link" onclick="$('html, body').stop().animate({scrollTop: $('#pcList').offset().top}, 500);ga_log(4);">대상 상품 보기</a>
                </div>
            </div>

            <!-- 공통 : 꼭 확인하세요  -->
            <div class="com__evt_notice">
                <div class="evt_notice--btn_area"><button class="btn__evt_notice btn__white" data-laypop-id="slidePop3"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 레이어 열기 -->
            </div>
            <div id="slidePop3" class="evt_notice--slide">
                <div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
                    <div class="evt_notice--head">유의사항</div>
                    <div class="evt_notice--cont">
                        <div class="evt_notice--continner">
                            <dl>	
                                <dt>이벤트 대상 및 혜택</dt>
                                <dd>
                                    <ul>
                                        <li>이벤트 대상 : 쓰리고PC 구매 고객</li>
                                        <li>이벤트 혜택 : 메모리, 저장장치 등 스펙 업그레이드 혹은 사은품 증정 중 택1 선택</li>
                                        <li>참여방법 : 쓰리고PC 구매 시 옵션 선택 후 결제</li>
                                    </ul>
                                </dd>
                            </dl>
                            
                            <dl>
                                <dt>공통 이벤트 유의사항</dt>
                                <dd>
                                    <ul>
                                        <li>재고 소진 시 이벤트 상품이 변경될 수 있습니다.</li>
                                        <li>스펙UP 부품 정보는 상품페이지 내에서 확인하실 수 있습니다.</li>
                                        <li>부정 참여 시 본 이벤트 대상 제외 및 혜택 지급이 취소될 수 있습니다.</li>
                                        <li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
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

    <!-- CONT4 : 쓰리고 PC 라인업 -->
    <!-- 기획전 마크업과 동일합니다. (주석은 지워주세요~)
            참고 : http://m.enuri.com/m/planlist.jsp?t=B_20210401040111
    -->
    <div class="section cont4" id="pcList">
        <div class="contents">
            <div class="cont__head"> 
                <h2 class="cont__tit">쓰리고 PC 라인업</h2>
            </div>

            <div class="cont__body">
                <!-- 인텔 라인업 -->
                <div class="group_wrap">
                    <h3 class="txt_tit"><img src="http://img.enuri.info/images/event/2021/threegopc/m_cont4_intel.png" alt="Intel"></h3>
                    <ul class="goods" id="ul_goods1"></ul>
                </div>
                <!-- //인텔 라인업 -->

                <!-- AMD 라인업 -->
                <div class="group_wrap">
                    <h3 class="txt_tit"><img src="http://img.enuri.info/images/event/2021/threegopc/m_cont4_amd.png" alt="AMD"></h3>

                    <ul class="goods" id="ul_goods2"></ul>
                </div>
                <!-- //AMD 라인업 -->

                <!-- 찜레이어 -->
                <span class="zzimly" style="display: none;">찜 되었습니다</span>
            </div>
        </div>
    </div>
</div>
<!-- // 프로모션 -->
<!-- LAYER WRAP -->
<div class="layerwrap">
	<!-- 공통 : SNS공유하기 -->
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
							<span id="txtURL" class="txt__share_url"></span>
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
	</div>
	<!-- // -->
	<!-- // -->	<!-- 모바일웹 공통 : 모바일 앱 전용 이벤트  -->
	<div class="layer_back" id="app_only" style="display:none;">
		<div class="appLayer">
			<h4>모바일 앱 전용 이벤트</h4>
			<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
			<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
			<p class="btn_close"><button type="button" onclick="install_btn();">설치하기</button></p>
		</div>
	</div>
</div>
<!-- // -->
<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20200630"></script>
<script type="text/javascript" src="/mobilefirst/event/js/exhibition_m.js"></script>
<script>
var vEvent_title = "쓰리고PC";
var gaLabel = [  vEvent_title+"_PV"
				,vEvent_title+"_1GO_상품보기"
				,vEvent_title+"_2GO_신청하기"
				,vEvent_title+"_3GO_대상상품보기"
				,vEvent_title+"_라인업"
				 ];

$(window).on('load', function(){
	alert("종료된 이벤트입니다.");
	location.href = "http://m.enuri.com/m/index.jsp";
    var oc = '<%=oc%>';
    var app = getCookie("appYN"); //app인지 여부
    var userId = "<%=userId%>";
    
    ga_log(1);
	getThreegopcDealData();
	getThreegopcLineUp();
	
    // 탭 전환
    var $appItem = $(".appdown__item");
    $appItem.click(function(){
        $(this).addClass("is--active").siblings().removeClass("is--active");
    })
    
	// 앱으로 보기
	$(".btn_go_app").click(function(){
		view_moapp();
	});

 	// 공유하기 링크로 진입 시, 팝업 노출(모웹)
    if(oc == "sns" && app != 'Y'){ //수정
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
    $("#pcList").on("click", function(){
    	ga_log(5);
    });
    
    $("#txtURL").text("http://"+location.host+"/mobilefirst/event2021/threegopc_evt.jsp?oc=sns");
});

$(function(){
	var clipboard = new ClipboardJS('.com__share_wrap .btn__share_copy');
	clipboard.on('success', function(e) {
		alert('주소가 복사되었습니다');
	});
	clipboard.on('error', function(e) {
		console.log(e);
	});
});

function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var url = "";
	url = encodeURIComponent("http://" + location.host + "/mobilefirst/event2021/threegopc_evt.jsp?freetoken=event"); 
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

function shareSns(param){ //수정
	var share_url = "http://" + location.host + "/mobilefirst/event2021/threegopc_evt.jsp?oc=sns";
	var share_title = "[에누리 가격비교] 에누리 쓰리고PC";
	var share_description = "최저가는 기본!할인, 적립, 사은품까지, 쓰리고~";
	var imgSNS = "http://img.enuri.info/images/event/2021/threegopc/sns_1200_630.jpg";
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
		var share_title_twi = "[에누리 가격비교] 최저가는 기본! 쓰리고PC 할인 받고, 적립 받고, 사은품 받고!";
		window.open("https://twitter.com/intent/tweet?text="+encodeURIComponent(share_title_twi)+"&url="+share_url);
	}
}

function getThreegopcDealData(){
	var vUrl = "/mobilefirst/http/mobile_deal_list.jsp";
	$.getJSON(vUrl, function(data){
		threegopcDeal(data);
	});
}

	function threegopcDeal(json){
		var vHtml1 = "";
		var vHtml2 = "";
		var vCur_dtm = YYYYMMDDHHMMSS(new Date());
		var vStatusFlag = 0;
		var vSlideNum = 0;
		$.each(json, function(i, v){
			vHtml1 = "";
			vHtml2 = "";
			
			if(vCur_dtm.substring(0,6) == v.GOODS_ST_SELLDATE_DIF.substring(0,6)){
				vSlideNum = i;
			}
			var month = parseInt(v.GOODS_ST_SELLDATE_DIF.substring(4,6));
			var day = parseInt(v.GOODS_ST_SELLDATE_DIF.substring(6,8));
			var vSUB_IMGList = v.SUB_IMG;
	        var vSmllImageDate1 = v.GOODS_ST_SELLDATE_DIF.substring(4,6);
	        var vSmllImageDate2 = v.GOODS_ST_SELLDATE_DIF.substring(6,8);
	        var vSmllImageDate3 = v.GOODS_ST_SELLDATE_DIF.substring(8,10);
			
	      //큰이미지 sold out 0, 특가오픈1, 특가종료2, coming soon3
			if(v.GOODS_SOLD_FLAG == "Y"){ //sold out
				vStatusFlag = 0;
			}else if(v.GOODS_SOLD_FLAG == "N" && v.GOODS_ST_SELLDATE_DIF > vCur_dtm){//is -ready
				vStatusFlag = 3;
			}else if(v.GOODS_SOLD_FLAG == "N" && v.GOODS_ST_SELLDATE_DIF <= vCur_dtm && v.GOODS_END_SELLDATE_DIF >= vCur_dtm){ //특가오픈
				vStatusFlag = 1;
			}else if(v.GOODS_SOLD_FLAG == "N" && v.GOODS_END_SELLDATE_DIF <= vCur_dtm){ //특가종료
				vStatusFlag = 2;
			}
			
			if(v.GOODS_ETC5 == ""){ //커밍순
	           	 vHtml1 += "<div class=\"swiper-slide is-comming\" style=\"width: 320px;\">";
	        	 vHtml1 += "	<div class=\"tx_progress\">";
	             vHtml1 += "		<div class=\"tx_badge is-ready\">";
	             vHtml1 += "			<p class=\"tx_cnt\"><em>"+vSmllImageDate1+"월 "+vSmllImageDate2+"일 "+vSmllImageDate3+"시"+"</em></p>";
	             vHtml1 += "		</div>";
	             vHtml1 += "	</div>";
	             vHtml1 += "	<div class=\"btn_box\">";
	             vHtml1 += "		<a href=\"javascript:void(0)\" class=\"btn is-disabled\">상품 보기</a>";
	             vHtml1 += "	</div>";
	             vHtml1 += "</div>";				
			}else{
				if(vStatusFlag != 0){
					vHtml1 += "<div class=\"swiper-slide\">";	
				}else{
					vHtml1 += "<div class=\"swiper-slide is-soldout\">";
				}
				vHtml1 += "		<div class=\"tx_progress\">";
				
				//vStatusFlag = 3; //test
				
				if(vStatusFlag == 1){
					vHtml1 += "			<div class=\"tx_badge is-open\">특가 오픈</div>";
				}else if(vStatusFlag == 2){
					vHtml1 += "			<div class=\"tx_badge is-close\">특가 종료</div>";
				}else if(vStatusFlag == 3){
					vHtml1 += "			<div class=\"tx_badge is-ready\">";
					vHtml1 += "				<p class=\"tx_cnt\"><em>"+vSmllImageDate1+"월 "+vSmllImageDate2+"일 "+vSmllImageDate3+"시"+"</em></p>"
					vHtml1 += "	    	</div>";
				}
				vHtml1 += "		</div>";
				if(v.GOODS_NAME !== "comming soon") {
					vHtml1 += "		<img src=\"http://storage.enuri.info"+v.GOODS_ETC5+"\" alt=\"\" />";
				}
				vHtml1 += "		<div class=\"btn_box\">";
		        if(vStatusFlag ==1){
		        	vHtml1 += "			<a href=\"javascript:void(0);\" onclick='goPcDealShop("+v.SEQ+");ga_log(2);'  class=\"btn\">상품 보기</a>";
		        }else{
		        	vHtml1 += "			<a href=\"javascript:void(0);\"  onclick='goPcDealShop("+v.SEQ+");' class=\"btn is-disabled\">상품 보기</a>";
		        }
		        vHtml1 += "		</div>";
		        vHtml1 += "	</div>";
			}
	        
	        $("div.swiper-wrapper").append(vHtml1);

	        //작은 이미지
	        if(v.GOODS_ETC5 == ""){ //커밍순
	        	vHtml2 += "<li>";
	        	vHtml2 += "	<div class=\"item\">";
	        	vHtml2 += "		<div class=\"thumb_img is-ready\"></div>";
	        	vHtml2 += "		<div class=\"tx_date\">"+vSmllImageDate1+"월 "+vSmllImageDate2+"일 "+vSmllImageDate3+"시"+"</div>";
	        	vHtml2 += "	</div>";
	        	vHtml2 += "</li>";	 
	        }else{
	        	vHtml2 += "<li>";
	        	vHtml2 += "	<div class=\"item\">";
	        	if(vStatusFlag ==0){
	        		vHtml2 += "<div class=\"sold_out\">SOLD OUT</div>";
	        	}
	        	vHtml2 += "		<div class=\"thumb_img\">";
	        	$.each(vSUB_IMGList, function(item, value){
	        		vHtml2 += "		<img src=\"http://storage.enuri.info"+value.IMG_SRC+"\" alt=\"\" />";
	        	});
	        	
	        	vHtml2 += "		</div>";
	        	vHtml2 += "		<div class=\"tx_date\">"+vSmllImageDate1+"월 "+vSmllImageDate2+"일 "+vSmllImageDate3+"시"+"</div>";
	        	vHtml2 += "	</div>";
	        	vHtml2 += "</li>";
	        }
	        $("#smallImage").append(vHtml2);
		});
		
	    var boxImgWrap = ".prdc_swiper--big .swiper-container",    // 큰이미지
	    boxThumbWrap = ".prdc_swiper--sm .scroll-cont",  // 작은이미지
	    $boxThumbItem = $(boxThumbWrap).find(".swiper-slide");  // 작은이미지 아이템
	
		// 큰이미지 스와이퍼 생성                                    
		var bImgSwiper = new Swiper(boxImgWrap, {
		    centeredSlides: true,
		    slidesPerView : 1,
		    spaceBeetween : 0                                       
		}).on("onSlideChangeEnd", function(swiper){
		    var _swiper = swiper;
		    var _idx = _swiper.activeIndex;
		
		    $(boxThumbWrap).stop().animate({scrollLeft : (_idx * 110)-110},100)
		    $(boxThumbWrap).find("li").removeClass("is-active");
		    $(boxThumbWrap).find("li").eq(_idx).addClass("is-active");
		});
		
		// 메뉴 탭 아이템 클릭 이벤트
		$(boxThumbWrap).find("li").on("click",function(){
		    var _idx = $(this).index(),
		    _offsetLeft = (_idx * 110)-110;
		    
		    $(boxThumbWrap).stop().animate({scrollLeft : _offsetLeft},100)
		    bImgSwiper.slideTo(_idx)
		    $(boxThumbWrap).find("li").removeClass("is-active")
		    $(this).addClass("is-active");
		})
		bImgSwiper.slideTo(vSlideNum);
	}

	function goPcDealShop(goods_seq){
		var newUrl = "";

		//url get
		$.ajax({
			type: "POST",
			url: "/mobilefirst/ajax/getEalurl3.jsp",
			data: "seq="+goods_seq,
			dataType:"JSON",
			async: false,
			success: function(json){
				if(json.IsEnuriEmployee){
					alert("임직원은 참여 할수 없습니다!");
					return false;
				}

				if(json.resultMsg == "SUCCESS"){
					if(json.soldout == "Y"){
						alert("품절 되었습니다.");
						location.reload();
					}else{
						newUrl = json.resultUrl;
					}
				}
			}
		});

		if(newUrl != ""){
			var newWin = window.open("/move/Simpleredirect.jsp?enuritargeturl=" + encodeURIComponent(newUrl));
		}
		try{
			//2016-01-05 CTU V2 적용
			ctu_v2_forDeal(55, goods_seq);
		}catch(e){
			
		}
	}

	function ctu_v2_forDeal(vcode, goods_seq){
		var vIp = "10.100.21.11";
		var vDevice = "2";

		if(vcode == "7885"){
			vDevice = "1";
		}

	  	var vData_M = { shop_code: vcode, goods_seq: goods_seq };
			//var vData_P = {ctu_test: "N", system_type : "4" , device : "1", service: "1", shop_code: vcode, goods_code: goodscode, pl_no: pl_no, user_ip: vIp};
			$.ajax({
				type: "POST",
				url: "/mobilefirst/evt/ajax/ctuCrazyDeal.jsp",
				data: vData_M,
				dataType:"JSON",
				success: function(json){
					if(json.resultMsg == "SUCCESS"){
						if(json.resultData.SoldOut == "1"){
							//품절처리
							$.ajax({
								type: "POST",
								url: "/mobilefirst/include/inc_enurideal2.jsp",
								data: "seq="+ goods_seq,
								dataType:"JSON",
								success: function(result){}
							});
						}
					}
				}
			});
	}


	function getThreegopcLineUp(){
		$.ajax({
			type : "GET",
			dataType :"JSON",
			url : "/mobilefirst/evt/ajax/ajax_threegopc_getlist.jsp?adsno=1956",
			success :function(result){
				var vSuccess = result.success;
				if(vSuccess){
					var vData = result.data;
					var vHtml1 = "";
					var vHtml2 = "";
					var vFlag = false;
					var vAdsbannertitleno2 = 0;
					$.each(vData, function(i,v){
						var vAdsbannertitleno = v.adsbannertitleno;
						var vModelNo = v.modelno;
						var vModelNoSub  = ""+v.modelno;
						vModelNoSub = vModelNoSub.substring(0,5)+"000";
						var vCopytext = v.copytext.substring(1);
						var vShopList = v.shopList;
						//vShopList.length > 0 일 때 품절이 아님.
						if(vAdsbannertitleno != vAdsbannertitleno2 && i != 0){
							vFlag = true;
						}
						
						if(!vFlag){
							if(vShopList.length > 0){
								vHtml1 += "<li class=\"item\">";
								vHtml1 += "   <a href=\"/m/vip.jsp?modelno="+vModelNo+"\">";
								vHtml1 += "	<div class=\"inner\">";
								vHtml1 += "		<div class=\"thumb\">";
								vHtml1 += "			<img src=\""+v.img+"\" alt=\"\">";
								vHtml1 += "			 <input type=\"hidden\" name=\"errImg\" id=\"errImg_"+vModelNo+"\" value=\""+v.img+"\">";
								vHtml1 += "    	</div>";
								vHtml1 += "    <div class=\"info_wrap\">";
								vHtml1 += "       <div class=\"info_cnt\">";
								
								vHtml1 += "         <span class=\"txt_company\">&nbsp;</span>";
								vHtml1 += "         <span class=\"txt_prdname\">"+v.modelname+"</span>";
								vHtml1 += "         <span class=\"txt_desc\">"+vCopytext+"</span>";
								vHtml1 += "         <span class=\"txt_price\">";
								vHtml1 += "         	<span class=\"lowest\">최저가</span>";
								$.each(vShopList, function(item, value){
									if(item == 0){
										vHtml1 += "        <span class=\"price\">"+numberWithCommas(value.minprice)+"</span>";
									}
								});
								vHtml1 += "         		<span class=\"won\">원</span>";
								vHtml1 += "        	 </span>";
								
								vHtml1 += "     </div>";
								vHtml1 += "   </div>";
								vHtml1 += "  </div>";
								vHtml1 += "  </a>";
								vHtml1 += "</li>";								
							}
						}else{
							if(vShopList.length > 0){
								vHtml2 += "<li class=\"item\">";
								vHtml2 += "   <a href=\"/m/vip.jsp?modelno="+vModelNo+"\">";
								vHtml2 += "	<div class=\"inner\">";
								vHtml2 += "		<div class=\"thumb\">";
								vHtml2 += "			<img src=\""+v.img+"\" alt=\"\">";
								vHtml2 += "			 <input type=\"hidden\" name=\"errImg\" id=\"errImg_"+vModelNo+"\" value=\""+v.img+"\">";
								vHtml2 += "    	</div>";
								vHtml2 += "    <div class=\"info_wrap\">";
								vHtml2 += "       <div class=\"info_cnt\">";
								vHtml2 += "         <span class=\"txt_company\">&nbsp;</span>";
								vHtml2 += "         <span class=\"txt_prdname\">"+v.modelname+"</span>";
								vHtml2 += "         <span class=\"txt_desc\">"+vCopytext+"</span>";
								vHtml2 += "         <span class=\"txt_price\">";
								vHtml2 += "         	<span class=\"lowest\">최저가</span>";
								$.each(vShopList, function(item, value){
									if(item == 0){
										vHtml2 += "         	<span class=\"price\">"+numberWithCommas(value.minprice)+"</span>";
									}
								});
								vHtml2 += "         	<span class=\"won\">원</span>";
								vHtml2 += "         </span>";
								vHtml2 += "     </div>";
								vHtml2 += "   </div>";
								vHtml2 += "  </div>";
								vHtml2 += "  </a>";
								vHtml2 += "</li>";
							}
						}
						vAdsbannertitleno2 = vAdsbannertitleno;
					});
					$("#ul_goods1").html(vHtml1);
					$("#ul_goods2").html(vHtml2);
				}
			}
		});
	}
	
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

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
	
</script>
</body>
</html>