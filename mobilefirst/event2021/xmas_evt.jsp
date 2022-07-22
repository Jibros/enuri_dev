<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ include file="/common/jsp/COMMON_CONST_TOP.jsp"%>
<%@ include file="/event/common/include/event_common.jsp"%>
<%
	String oc = ChkNull.chkStr(request.getParameter("oc"));
	// #. 모바일 기기 접속 시 접속 페이지 변경
    /*if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
	|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
	|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
	|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
	}else{
		response.sendRedirect("/event2021/xmas_evt.jsp?oc="+oc);
		return;
	}*/

	String strFb_title = "[에누리 가격비교] 메리크리스마스 혜택을 누리다!";
	String strFb_description = "매주 수요일 타임특가 놓치지 마세요!";



	String tab = ChkNull.chkStr(request.getParameter("tab"),"");
	String strToday = currentDate.format(DateTimeFormatter.ofPattern("yyyyMMdd"));

	String STARTDATE = "20211201";
	String ENDDATE = "20211231";
	String EVENT_CODE = "2021120120";
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
    <meta charset="utf-8">
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
        <META NAME="description" CONTENT="<%=strFb_description%>">
        <META NAME="keyword" CONTENT="휴대폰, 사무, 생활가전, 용품, 영상음향, 컴퓨터, 자동차, 명품, 잡화, 스포츠, 유아, 완구, 가구, 화장품, 식품, 가격비교, 쇼핑몰, 최저가">
        <meta property="og:title" content="<%=strFb_title%>">
	    <meta property="og:description" content="<%=strFb_description%>">
	    <meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM+"/images/event/2021/xmas_pro/xmas_sns_1200_630.jpg"%>">	
        <link rel="shortcut icon" href="http://img.enuri.info/2014/layout/favicon_enuri.ico">
        <title>에누리(가격비교) eNuri.com</title>
        <link rel="stylesheet" type="text/css" href="/css/rev/common.css"/> <!-- reset -->
        <link rel="stylesheet" type="text/css" href="/css/rev/template.css"/> <!-- template -->
        <!-- 프로모션 공통 CSS (PC) -->
        <link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
        <!-- 프로모션별 커스텀 CSS  -->
        <link rel="stylesheet" href="/css/event/y2021_rev/xmas_pro_m.css" type="text/css">

        <script type="text/javascript" src="/common/js/lib/jquery-1.9.1.min.js"></script>
        <script type="text/javascript" src="/js/clipboard.min.js"></script>
        <script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
        <script type="text/javascript" src="/m/event/common/js/event_common.js"></script>
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

        <div class="event_wrap">
            <%@include file="/m/event/common/include/event_emoney.jsp"%>

            <div class="section visual" style="margin-bottom: 0px;">
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
            </div>
            <div id="floating_bnr" class="floating_bnr">
                <a href="/mobilefirst/event2021/xmas_deal.jsp?tab=03"><img src="//img.enuri.info/images/event/2021/xmas_pro/fl_bnr.png" alt="크리스마스 준비하고 서가앤쿡 외식!"></a>
                <!-- 닫기 -->
                <a href="javascript:void(0);" class="btn_close" onclick="onoff('#floating_bnr');return false;">
                    <span class="blind">닫기</span>
                </a>
            </div>
            <div class="section floattab">
                <div class="contents">
                    <ul class="floattab__list">
                    	<li><a href="/mobilefirst/event2021/xmas_evt.jsp" class="active">산타 도와주면<em>유자차 당첨!</em></a></li>
                        <li><a href="/mobilefirst/event2021/xmas_deal.jsp" class="">매주 수요일<em>타임특가</em></a></li>
                        <li><a href="/mobilefirst/event2021/xmas_goods.jsp" class="">메리크리스마스<em>준비템</em></a></li>
                    </ul>
                </div>
            </div>
            <div class="section event_01" id="evt1">
                <div class="inner">
                  	<h3><img src="//img.enuri.info/images/event/2021/xmas_pro/m_evt1_title.png" alt="산타 할아버지의 선물보따리를 찾아주세요, 매일매알 따뜻한 유자차 당첨!"></h3>
    				<div class="prize_img"><img src="//img.enuri.info/images/event/2021/xmas_pro/m_evt1_obj_prize.png" alt="경품, 투썸플레이스 고구마라떼 e5,200점"></div>
                    
                    <!-- 이벤트영역 (산타보따리) -->
                    <div class="game_area_wrap">
                        <div class="santabag">
                            <div class="obj_bg"></div>
                            <div class="obj_santabag">
                                <span class="obj_santabag1"></span>
                                <span class="obj_santabag2"></span>
                                <span class="obj_santabag3"></span>
                            </div>
                        </div>
                   		<button type="button" class="btn_play_game"><img src="//img.enuri.info/images/event/2021/winter_pro/m_evt1_play_btn.png" alt="start"></button>
                    </div>

                    <div class="evt1_sns_share">
                        <div class="tit"><img src="//img.enuri.info/images/event/2021/xmas_pro/m_evt1_share_txt.png" alt="공유하고 이벤트 한번 더! 참여하세요"></div>
                        <ul class="sns_share_list" id="share_list">
                            <li data-share="face"><a href="javascript:void(0);" class="btn_ka"><img src="//img.enuri.info/images/event/2021/winter_pro/m_evt1_sns_facebook.png" alt=""><span>페이스북</span></a></li>
                            <li id="kakao-link-btn2" data-share="kakao"><a href="javascript:void(0);" class="btn_fb"><img src="//img.enuri.info/images/event/2021/winter_pro/m_evt1_sns_kakaotalk.png" alt=""><span>카카오톡</span></a></li>
                            <li data-share="url"><a href="javascript:void(0);" data-clipboard-text="http://m.enuri.com/mobilefirst/event2021/xmas_evt.jsp" class="btn_co"><img src="//img.enuri.info/images/event/2021/winter_pro/m_evt1_sns_url.png" alt=""><span>URL 복사</span></a></li>
                        </ul>
                    </div>

                   	<div class="area_noti">
                        <button class="btn_caution btn__evt_on_slide" data-laypop-id="layPop1">꼭! 확인하세요</button>
                    </div>
                </div>
            </div>
            <div id="layPop1" class="evt_slide">
                <div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
                    <div class="evt_slide--head">유의사항</div>
                    <div class="evt_slide--cont">
                        <div class="evt_slide--continner">
                            <div class="popup_inner_tit">이벤트 기간 및 혜택</div>
                            <ul class="list_dot mb20">
                                <li>이벤트 기간 : 2021년 12월 6일(월) ~ 2021년 12월 31일(금)</li>
                                <li> 이벤트 참여 혜택 : e4,900점 / e5점</li>
                                <li><span class="color-red">e머니 유효기간 : 적립일로부터 15일(유효기간 만료 후 재적립 불가)</span><br>
                                    ※ 적립된 e머니는 1,000여가지 인기 e쿠폰으로 교환 가능합니다. </li>
                            </ul>
                            <div class="popup_inner_tit">이벤트 유의사항</div>
                            <ul class="list_dot mb20">
                                <li>이벤트 참여 : ID당 1일 1회 참여 가능 / 공유이벤트 참여 시 ID당 1일 1회 추가 참여 가능</li>
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
                    <h3><img src="http://img.enuri.info/images/event/2021/winter_pro/m_benefit_tit.png" alt="놓칠 수  없는 특별한 혜택, 에누리 혜택"></h3>
                    <ul class="banlist">
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
            <!-- 공통 : SNS공유하기 -->
            <div class="com__share_wrap dim" style="z-index:10000;display:none">
                <div class="com__layer share_layer">
                    <div class="lay_head">공유하기</div>
                    <a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
                    <div class="lay_inner">
                        <ul id="eventShr">
                            <li id="fbShare" class="share_fb">페이스북 공유하기</li>
                            <li id="kakao-link-btn" class="share_kakao">카카오톡 공유하기</li>
                            <li id="twShare" class="share_tw">트위터 공유하기</li>
                        </ul>
                        <!-- 메일보내기 버튼클릭시 .mail_on 추가해 주세요 -->
                        <div class="btn_wrap">
                            <div class="btn_group">
                                <!-- 주소복사하기 -->
                                <div class="btn_item">
                                    <span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2021/xmas_evt.jsp</span>
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
            </div>
     	    <%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
        </div>
        <a href="javascript:void(0);" class="btn_top" onclick="$('body,html').animate({scrollTop: 0}, 1);"><i>TOP</i></a>
        <!-- LAYER WRAP -->
        <div class="layerwrap">
            <!-- 딤레이어 : 모바일 앱 전용 이벤트 당첨!!-->
            <div id="play_result" class="pop-layer" style="display:none;">
                <div class="popupLayer">
                    <div class="dim"></div>
                </div>
                <!-- popup_box -->
                <div class="popup_box guide">
                    <img class="result_img" src="/">
                    <a class="btn layclose" href="javascript:void(0);" onclick="onoff('#play_result'); return false;"><em>팝업 닫기</em></a>
                </div>
                <!-- //popup_box -->
            </div>
        </div>

    </body>

    <script>
        Kakao.init('5cad223fb57213402d8f90de1aa27301');
        var TODAY = "<%=TODAY%>";
        var isClick = true;
        var vOs_type = getOsType();
        var app = "<%=strApp%>";
        var vOc = "<%=oc%>";
        
        ga('send', 'pageview', {
			'title': '1. 21년 크리스마스 기획전_PV'
		});
        
		if(app != "Y" && vOc == "sns"){
			ga('send', 'event', 'mf_event', "21년 크리스마스", "크리스마스시즌_탭1공유하기_앱설치 팝업_PV" );
		}
        
		(function (global, $) {
             var clipboard = new ClipboardJS('.com__share_wrap .btn__share_copy');
            clipboard.on('success', function(e) {
                alert('주소가 복사되었습니다');
            });
            clipboard.on('error', function(e) {
                console.log(e);
            });
            // 상단 메뉴 스크롤 시, 고정
            var $nav = $('.floattab'),
                $menu = $('.floattab__list li'),
                $flyingbnr = $(".floating_bnr"),
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
        }(window, window.jQuery));

        /*레이어*/
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
      
        $(window).load(function(){
            var $visual = $(".event_wrap .visual");
            setTimeout(function(){
                $visual.addClass("start");
            },1000)
        })

        var s_potato = {
            el : {
                wrap : $(".santabag"),
                obj_p : $(".obj_santabag > span"),
                btn_start : $(".btn_play_game"),
            },
           
            stop : function() {
                this.el.obj_p.off('click');
            },
            start : function(){
                _self = this;
                _self.el.btn_start.fadeOut();
                _self.el.obj_p.addClass('action');
                ga('send', 'event', 'mf_event', "21년 크리스마스", "6. 21년 크리스마스 기획전_참여이벤트_참여" );

                _self.el.obj_p.on('click', function(e){
                    getEventAjaxData({"procCode":1} ,function(data){
                        _self.el.obj_p.removeClass('action');
                        var random_number = 1;
                        if(data.result==-44 || data.result == 5 ){
                            if(data.result ==-44) random_number = Math.floor(Math.random()*2)+1;
                            else random_number = 3;
                            $("#play_result .result_img").attr({
                                'src':'//img.enuri.info/images/event/2021/xmas_pro/bag_result_'+ random_number +'.jpg',
                                'alt' : (random_number === '3' ? '축하합니다. 선물보따리를 찾았어요 [할리스]고흥 유자차 4900점' : (random_number === '2' ? '땡! 어머나 쓰레기가 든 보따리였어요!' : '땡! 이런~텅빈 보따리네요!'))
                            });
                            $(this).addClass('active');
                            // 결과팝업 띄움
                            setTimeout(function(){
                                    onoff('#play_result');
                            },1000);
                        }else if(data.result==-99){
                            alert("임직원은 참여 불가능합니다.");
                        }else if(data.result==-33){
                            alert("이미 참여하셨습니다.\n이벤트 공유해주시면 1번 더 참여 가능해요~");
                        }else if(data.result==-22){
                            alert("오늘 참여 횟수를 모두 사용하셨어요.\n내일 또 참여해주세요!");
                        }
                      //  _self.stop();
                        $(".btn_play_game").show();
                    });
                });
            },
            restart : function(){
                this.el.obj_p.removeClass('active');
                this.start();
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
        // 클릭시 멤버체크후 플레이 실행
        $(".btn_play_game").on('click', function(){
            if(!islogin()){
				alert("로그인 후 이용 가능합니다.");
				goLogin();
				return false;
            }else if(TODAY < "20211206"){
                alert('오픈예정입니다.');
                return false;
            }else if(TODAY > "20211231"){
                alert('이벤트 종료! 다음 이벤트를 기대해주세요');
                return false;
            }else{
                if(!getSnsCheck()){
                    if (confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?") == true){    
                        location.href="<%=ConfigManager.ENURI_COM_SSL%>/mobilefirst/member/myAuth.jsp?cmdType=modify&f=p";
                    }else{
                        return false;
                    }
                }else{
                    s_potato.start();
                }
            }
        });
        shareKaKao("share");
         if(islogin()){
            shareKaKao("event");
         }
        //공유하기
        $(".share_kakao").on('click', function(){
            shareSns('kakao',"share");
        });
        $(".share_fb").on('click', function(){
            shareSns('face',"share");
        });
        $(".share_tw").on('click', function(){
            shareSns('twitter',"share");
        });
          $(".otherbene").find(".banlist li").on("click",function(){
            ga('send', 'event', 'mf_event', "21년 크리스마스", "7. 21년 크리스마스 기획전_참여이벤트_공유하기" );
        });
        $("#floating_bnr").on("click",function(){
            ga('send', 'event', 'mf_event', "21년 크리스마스", "5. 21년 크리스마스 기획전_상단 플로팅배너" );
        })
        $(".section.floattab .floattab__list li").on("click",function(){
            if($(this).index()==0) ga('send', 'event', 'mf_event', "21년 크리스마스", "2. 21년 크리스마스 기획전_단순참여 이벤트" );
            else if($(this).index()==1) ga('send', 'event', 'mf_event', "21년 크리스마스", "3. 21년 크리스마스 기획전_ 타임딜" );
            else if($(this).index()==2) ga('send', 'event', 'mf_event', "21년 크리스마스", "4. 21년 크리스마스 기획전_기획전" );
        });
        $(".btn_go_app").on("click",function(){
        	ga('send', 'event', 'mf_event', "21년 크리스마스", "크리스마스시즌_탭1공유하기_앱설치 팝업_APP설치" );
        });
        $(".btn_keep_mw").on("click",function(){
        	ga('send', 'event', 'mf_event', "21년 크리스마스", "크리스마스시즌_탭1공유하기_앱설치 팝업_닫기" );
        });      
        // 공유버튼클릭시  
        $("#share_list li").off().on('click', function(){
            var vThisData = $(this).data("share");
            if(islogin()){
                shareSns(vThisData,"event");
            }else{
                alert("로그인 후 참여할 수 있습니다.");
                goLogin();
                return ;
            }
            //return false;
        });
        function shareKaKao(type){
            var share_url2 = "http://" + location.host + "/mobilefirst/event2021/xmas_evt.jsp";
            var share_title2 = (type=="event" ? "[에누리 가격비교] 매일매일 100% 당첨!\n산타의 선물 보따리 찾아주고 간식 받아가세요~" : "[에누리 가격비교] 메리크리스마스 혜택을 누리다!\n매주 수요일 타임특가 놓치지 마세요!");
            var imgSNS2 = (type=="event" ? "http://img.enuri.info/images/event/2021/xmas_pro/sns_1200_630_gift.jpg" : "http://img.enuri.info/images/event/2021/xmas_pro/sns_800_800.jpg");
            try{
                Kakao.Link.createDefaultButton({
                    container: (type=="event" ? "#kakao-link-btn2" : "#kakao-link-btn"),
                    objectType: 'feed',
                    content: {
                        title: share_title2,
                        imageUrl: imgSNS2,
                        link: {
                            webUrl: share_url2,
                            mobileWebUrl: share_url2
                        }
                    },
                    buttons: [
                    {
                        title: '상세정보 보기',
                        link: { 
                            webUrl: share_url2,
                            mobileWebUrl: share_url2
                        }
                    }
                    ]
                });
            }catch(e){
                alert("카카오 톡이 설치 되지 않았습니다.");
                alert(e.message);
            }
        }
        function shareSns(param,type){
            var share_url2 = "http://" + location.host + "/mobilefisrt/event2021/xmas_evt.jsp";
            var share_title2 = (type=="event" ? "[에누리 가격비교] 매일매일 100% 당첨!\n산타의 선물 보따리 찾아주고 간식 받아가세요~" : "[에누리 가격비교] 메리크리스마스 혜택을 누리다!\n매주 수요일 타임특가 놓치지 마세요!");
            var imgSNS2 = (type=="event" ? "http://img.enuri.info/images/event/2021/xmas_pro/sns_1200_630_gift.jpg" : "http://img.enuri.info/images/event/2021/xmas_pro/sns_800_800.jpg");
            var shareType = 0;
           
            if(param == "face"){
                try{
                    window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title2)+"&u="+share_url2);
                    //ga("send", "event", "mf_event", vEvent_title +"_APP", "공유하기_페이스북");
                }catch(e){
                    window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title2)+"&u="+share_url2);
                    //ga("send", "event", "mf_event", vEvent_title +"_WEB", "공유하기_페이스북");
                }
                if(type=="event"){
                    
                }
            }else if(param == "kakao"){
                
            }else if(param == "twitter"){
                window.open("https://twitter.com/intent/tweet?text="+share_title2+"&url="+share_url2);
            }else if(param == "url"){
                if(ClipboardJS.isSupported()) {
                    var clipboard2 = new ClipboardJS('#share_list .btn_co');
                    clipboard2.on('success', function(e) {
                        console.log(e);
                        alert("복사가 완료되었습니다!");
                    });
                    clipboard2.on('error', function(e) {
                        alert("해당 브라우저는 지원하지 않습니다.");
                    });
                }
            }
            if(type=="event"){
                if(param == "face") shareType = 1;
                else if(param=="kakao") shareType = 2;
                else if(param=="url") shareType = 3;
                ga('send', 'event', 'mf_event', "21년 크리스마스", "7. 21년 크리스마스 기획전_참여이벤트_공유하기" );
                getEventAjaxData({"procCode":3, "shareType" :shareType} ,function(data){
                });
            }
        }
     
     
        function getEventAjaxData(params, callback){
            var evtUrl = "/mobilefirst/evt/ajax/xmas2021_setlist.jsp";
                    
            if(typeof params === "object") {
                params.sdt = TODAY;
                params.osType = vOs_type;
            }
            if(!isClick){
                return false;
            }
            isClick = false;
            $.post(evtUrl,params,callback,"json").done(function(){
                isClick = true;
            });
        }
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
                }
            });
            return snsCertify;
        }
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

		/*레이어*/
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
    </script>

</html>