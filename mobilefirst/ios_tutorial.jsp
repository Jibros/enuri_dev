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
    <style>
        .swiper-wrap{position:fixed;top:0;left:0;width:100%;height:100%;background:#d9f5fe}
        .swiper-wrap .btn_close{position:fixed;z-index:100;width:30px;height:30px;top:20px;right:20px;background:url(http://img.enuri.info/images/event/2021/tutorial/210329/X_gr.png) no-repeat 50% 50%;background-size:100% 100%;text-indent:-9999em}
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
                        <img src="http://img.enuri.info/images/event/2021/tutorial/210329/p_1_common.jpg" alt="">
                    </div>
                </div>
                <div class="swiper-slide slide-bg-02">
                    <div class="img-wrap">
                        <img src="http://img.enuri.info/images/event/2021/tutorial/210329/p_2_common.jpg" alt="">
                    </div>
                </div>
                <div class="swiper-slide slide-bg-03">
                    <div class="img-wrap">
                        <img src="http://img.enuri.info/images/event/2021/tutorial/210329/p_3_ios.jpg" alt="">
                    </div>
                </div>
                <div class="swiper-slide slide-bg-04">
                    <div class="img-wrap">
                        <img src="http://img.enuri.info/images/event/2021/tutorial/210329/p_4_ios.jpg" alt="">
                    </div>
                </div>
            </div>
            <!-- 시작하기 -->
            <div class="btn-wrap" style="display:none">
                <a href="close://" class="btn_benefit"><img src="http://img.enuri.info/images/event/2021/tutorial/210329/bt_01.png" alt="시작하기"></a>
            </div>
            <!-- // -->
            <div class="swiper-pagination"></div>
        </div>
        <!-- 닫기버튼 -->
        <a href="javascript:void(0);" class="btn_close" onclick="fn_close();">닫기</a>
        <!-- // -->
		<script>
			$(function(){				
				var swiper = new Swiper(".swiper-container", {
                    loop :false,
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
			})
			
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