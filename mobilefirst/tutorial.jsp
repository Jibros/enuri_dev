<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%/* %>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8"/>
	<meta http-equiv="x-ua-compatible" content="ie=edge"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>	
	<meta property="og:title" content="에누리 가격비교"/>
	<meta property="og:description" content="에누리 모바일 가격비교"/>
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/logo_enuri.png"/>
	<meta name="format-detection" content="telephone=no"/>
	<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
	<link rel="stylesheet" type="text/css" href="/css/default.css"/>
    
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
    <script type="text/javascript" src="/js/swiper.min.js"></script> 
    <script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
    <style>
       .swiper-wrap{position:fixed;top:0;left:0;width:100%;height:100%;background:#d9f5fe}
       .swiper-wrap .btn_close{position:fixed;z-index:100;width:30px;height:30px;top:20px;right:20px;text-indent: -9999em;}
       .btn_close:before,.btn_close:after {position:absolute;left: 12px;content:'';height:34px;width:2px;background-color: #222;border-radius: 1px 1px;}
       .btn_close:before {-webkit-transform: rotate(45deg);-ms-transform: rotate(45deg);transform: rotate(45deg);}
       .btn_close:after {-webkit-transform: rotate(-45deg);-ms-transform: rotate(-45deg);transform: rotate(-45deg);}
       .swiper-wrap .btn_close.btn_w:before,
       .swiper-wrap .btn_close.btn_w:after{background-color:#d1d1d1}
       .slide-bg-01{background:#1b1b1b}
       .slide-bg-02{background:#1b1b1b}
       .slide-bg-03{background:#03b0d8}
       .slide-bg-04{background:#03b0d8}
       .slide-bg-05{background:#fee95a}
       .swiper-wrap .tutorial_wrap{position:absolute;top:0;left:0;width:100%;height:100%}
       .swiper-wrap .tutorial_wrap .swiper-slide{position:relative;text-align:center}
       .swiper-wrap .tutorial_wrap .swiper-slide .img-wrap{position:absolute;top:50%;left:0;width:100%;
           transform:translateY(-50%);
           -webkit-transform: translateY(-50%);
           -ms-transform: translateY(-50%);
           -o-transform: translateY(-50%);
           -moz-transform: translateY(-50%);
       }
       .swiper-wrap .swiper-slide{overflow: hidden;}
       .swiper-wrap .swiper-slide img{width:100%}
       .swiper-wrap .swiper-pagination{position:fixed;bottom:40px;left:0;width:100%;z-index:100;text-align:center}
       .swiper-wrap .swiper-pagination span{background:#cccccc;opacity:1;width:12px;height:12px;margin:0 6px}
       .swiper-wrap .swiper-pagination span.swiper-pagination-bullet-active{background:#3b21a0}
       .swiper-no-touch{width:100%;height:50%;position:absolute;top:50%;left:0;right:0;z-index:10}
       .intro_slide {width:1024px;top:50%;padding-top:50px;position:absolute;left:50%;margin-left:-512px;z-index: 8;}
       .intro_slide .swiper-slide {background-position:center;background-size:cover;width:224px;height:134px;opacity:0}
       .intro_slide .swiper-slide.swiper-slide-active{opacity:1}
       .intro_slide .swiper-slide.swiper-slide-next,
       .intro_slide .swiper-slide.swiper-slide-prev{opacity:.8}
       .swiper-wrap .btn-wrap{position:absolute;bottom:80px;padding:0 6.250%;z-index:100;width:100%;-webkit-box-sizing:border-box;box-sizing:border-box}
       .swiper-wrap .btn-wrap ul li{display:none}
       .swiper-wrap .btn-wrap ul li.active{display:block}
       .swiper-wrap .btn-wrap a{display:block;max-width:328px;margin:0 auto}
       .swiper-wrap .btn-wrap img{width:100%}
       /* tablet +  */
       @media (min-width:768px) {
           .swiper-wrap .swiper-slide img{width:auto;height:100%}
           .swiper-wrap .btn-wrap a{max-width:520px}
           .intro_slide {padding-top:100px}
           .intro_slide .swiper-slide {width:383px;height:228px;}
       }
   </style>
</head>
<body>
<div id="wrap">
    <div class="swiper-wrap">
        <div class="tutorial_wrap swiper-container">			 
			<div class="swiper-wrapper">
                 <div class="swiper-slide slide-bg-01">
                    <div class="img-wrap">
                        <img src="http://img.enuri.info/images/event/2020/tutorial/200911/p_1.jpg" alt="">
                    </div>
                </div>
                <div class="swiper-slide slide-bg-02">
                    <div class="img-wrap">
                        <img src="http://img.enuri.info/images/event/2020/tutorial/200911/p_2.jpg" alt="">
                    </div>
                </div>
                <div class="swiper-slide slide-bg-03">
                    <div class="img-wrap">
                        <img src="http://img.enuri.info/images/event/2020/tutorial/200911/p_3.jpg" alt="">
                    </div>
                </div>
                <div class="swiper-slide slide-bg-04">
                    <div class="img-wrap">
                        <img src="http://img.enuri.info/images/event/2020/tutorial/200911/p_4.jpg" alt="">
                    </div>
                </div>
            </div>
            </div>
            <!-- 버튼 영역 -->
            <div id="firstimg" class="btn-wrap">
                <ul>
                    <li class="active"></li>
                    <li><a href="javascript:void(0);" class="btn_benefit"><img src="http://img.enuri.info/images/event/2019/tutorial/0624/btn_type1.png" alt="구매하러가기"></a></li>
                    <li><a href="javascript:void(0);" class="btn_benefit"><img src="http://img.enuri.info/images/event/2019/tutorial/0502/btn_type2.png" alt="혜택 받으러 가기"></a></li>
                    <li><a href="javascript:void(0);" class="btn_benefit"><img src="http://img.enuri.info/images/event/2019/tutorial/0502/btn_type2.png" alt="혜택 받으러 가기"></a></li>
                    <li><a href="javascript:void(0);" class="btn_benefit"><img src="http://img.enuri.info/images/event/2019/tutorial/0502/btn_type3.png" alt="시작하기"></a></li>
                </ul>
            </div>
            <!-- // -->
            <div class="swiper-pagination"></div>
        </div>
        <!-- 닫기버튼 -->
        <a href="javascript:void(0);" class="btn_close" onclick="fn_close();">닫기</a>
        <!-- // -->
		<script>
			$(function(){
                // 메인 슬라이드
				var swiper = new Swiper(".tutorial_wrap", {
                    loop :true,
					watchActiveIndex:true,					
                    spceBeetween :0,
                    pagination:'.swiper-pagination',
                    paginationClickable:true,
                    onTransitionEnd : function(swiper){
                        var $btnwrap = $(".btn-wrap").find("li");
                        $btnwrap.eq( swiper.realIndex ).addClass("active").siblings().removeClass("active");
                        var $btnClose = $(".swiper-wrap .btn_close");
                        if ( swiper.realIndex < 2 ) $btnClose.addClass("btn_w")
                        else $btnClose.removeClass("btn_w")
                    }
                });
                // 1번째 슬라이드 내 상품 슬라이드
				var mySwiper = new Swiper('.intro_slide', {
					effect: 'coverflow',
					grabCursor: true,
					centeredSlides: true,
					loop : true,
					speed : 3000,
					autoplay : true,
					slidesPerView: 'auto',
					coverflow: {
						rotate: 0,
						stretch: -10,
						depth: 600,
						modifier: 1,
						slideShadows : false,
					}
                });
				$("#firstimg li").on("click",function(){
                	var liIndex = $(this).index();
                	if(liIndex==1){
                		ga('send', 'event', 'mf_event', "튜토리얼", "100원딜_구매하러가기");	
                	}else if(liIndex==2){
                		ga('send', 'event', 'mf_event', "튜토리얼", "100원딜_적립혜택받기");
                	}else if(liIndex==3){
                		ga('send', 'event', 'mf_event', "튜토리얼", "100원딜_교환혜택받기");
                	}else if(liIndex==4){
                		ga('send', 'event', 'mf_event', "튜토리얼", "100원딜_시작하기");
                	}
                	location.href= "/mobilefirst/evt/firstbuy100_event.jsp"; 
                });
			});
			function fn_close(){
				try{
					window.location.href= "close://";	
				}catch(e){}
				
			}
		</script>
    </div>
</div>
</body>
</html>
<%*/%>

<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8"/>
	<meta http-equiv="x-ua-compatible" content="ie=edge"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>	
	<meta property="og:title" content="에누리 가격비교"/>
	<meta property="og:description" content="에누리 모바일 가격비교"/>
	<meta property="og:image" content="http://img.enuri.info/images/mobilefirst/images/logo_enuri.png"/>
	<meta name="format-detection" content="telephone=no"/>
	<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
	<link rel="stylesheet" type="text/css" href="/css/default.css"/>
    <script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
    <script type="text/javascript" src="/js/swiper.min.js"></script>
    <style>
        .swiper-wrap{position:fixed;top:0;left:0;width:100%;height:100%;background:#d9f5fe}
        .swiper-wrap .btn_close{position:fixed;z-index:100;width:30px;height:30px;top:20px;right:20px;background:url(http://img.enuri.info/images/event/2020/tutorial/200911/X_gr.png) no-repeat 50% 50%;background-size:100% 100%;text-indent:-9999em}
        .slide-bg-01{background:#f7f7f7}
        .slide-bg-02{background:#dfe0f2}
        .slide-bg-03{background:#dff1f5}
        .slide-bg-04{background:#f9eeec}
        .swiper-wrap .swiper-container{position:absolute;top:0;left:0;width:100%;height:100%}
        .swiper-wrap .swiper-container .swiper-slide{position:relative;text-align:center}
        /* 2019.03.29 구형 브라우저를 위한 prefix추가 */
        .swiper-wrap .swiper-container .swiper-slide .img-wrap{position:absolute;top:50%;left:0;width:100%;
            transform:translateY(-50%);
            -webkit-transform: translateY(-50%);
            -ms-transform: translateY(-50%);
            -o-transform: translateY(-50%);
            -moz-transform: translateY(-50%);
        }
        /* // */
        .swiper-wrap .swiper-slide img{width:100%}
        .swiper-wrap .swiper-pagination{position:fixed;bottom:40px;left:0;width:100%;z-index:100;text-align:center}
        .swiper-wrap .swiper-pagination span{background:#cccccc;opacity:1;width:12px;height:12px;margin:0 6px}
        .swiper-wrap .swiper-pagination span.swiper-pagination-bullet-active{background:#222222}
        .swiper-wrap .btn-wrap{position:fixed;bottom:80px;padding:0 6.250%;z-index:100;width:100%;box-sizing:border-box}
        .swiper-wrap .btn-wrap a{display:block;max-width:328px;margin:0 auto}
        .swiper-wrap .btn-wrap img{width:100%}
        /* tablet */
        @media (min-width:768px) {
            .swiper-wrap .swiper-slide img{width:auto;height:100%}
            .swiper-wrap .btn-wrap a{max-width:520px}
        }
    </style>
</head>
<body>
<div id="wrap">
    <div class="swiper-wrap">
        <div class="swiper-container">			 
			<div class="swiper-wrapper">
                <div class="swiper-slide slide-bg-01">
                    <div class="img-wrap">
                        <img src="http://img.enuri.info/images/event/2020/tutorial/200911/p_1.jpg" alt="">
                    </div>
                </div>
                <div class="swiper-slide slide-bg-02">
                    <div class="img-wrap">
                        <img src="http://img.enuri.info/images/event/2020/tutorial/200911/p_2.jpg" alt="">
                    </div>
                </div>
                <div class="swiper-slide slide-bg-03">
                    <div class="img-wrap">
                        <img src="http://img.enuri.info/images/event/2020/tutorial/200911/p_3.jpg" alt="">
                    </div>
                </div>
                <div class="swiper-slide slide-bg-04">
                    <div class="img-wrap">
                        <img src="http://img.enuri.info/images/event/2020/tutorial/200911/p_4.jpg" alt="">
                    </div>
                </div>
            </div>
            <!-- 시작하기 -->
            <div class="btn-wrap" style="display:none">
                <a href="close://"  onclick="ga('send', 'event', 'mf_event', '튜토리얼', '닫기');" class="btn_benefit"><img src="http://img.enuri.info/images/event/2020/tutorial/200911/bt_01.png" alt="시작하기"></a>
            </div>
            <!-- // -->
            <div class="swiper-pagination"></div>
        </div>
        <!-- 닫기버튼 -->
        <a href="close://" class="btn_close">닫기</a>
        <!-- // -->
		<script>
			$(function(){				
				var swiper = new Swiper(".swiper-container", {
                    loop :true,
					watchActiveIndex:true,					
                    spceBeetween :0,
                    pagination:'.swiper-pagination',
                    paginationClickable:true,
                    onTransitionEnd : function(e){
                        var _idx = e.realIndex;
                        var $btn = $(".btn-wrap");
                        ( _idx == 3 ) ? $btn.show() : $btn.hide();
                    }
				});
			});
			
			function fn_close(){
				try{
					ga('send', 'event', 'mf_event', '튜토리얼', '닫기');
					window.location.href= "close://";	
				}catch(e){}
				
			}
		</script>
    </div>
</div>
</body>
</html>
