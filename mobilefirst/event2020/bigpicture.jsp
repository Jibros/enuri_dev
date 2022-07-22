<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
 if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){

}else{
    response.sendRedirect("/event2020/bigpicture.jsp"); //pc url
    return;
}

long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String sdt = dayTime.format(new Date(cTime));//진짜시간

if( request.getServerName().indexOf("dev.enuri.com") > -1 && request.getParameter("sdt")!=null && !request.getParameter("sdt").equals("") ) {
	sdt = request.getParameter("sdt");
}

String cUserId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

Members_Proc members_proc = new Members_Proc();
String cUsername = "";
String userArea = "";

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;

    if(cUsername.equals(""))      userArea = cUserNick;
    if(userArea.equals(""))        userArea = cUserId;
    
}
String tab = ChkNull.chkStr(request.getParameter("tab"));
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
<meta charset="utf-8">	
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
<meta property="og:title" content="에누리제작지원  인기 뮤직웹드라마 빅픽처하우스 이벤트">
<meta property="og:description" content="AOA유나, 엔플라잉 승협, 재현 주연 청춘로맨스! 이벤트 참여하고 스타벅스 받자~">
<meta property="og:image" content="http://img.enuri.info/images/mobilenew/images/logo_enuri.png">
<meta name="keyword" content="에누리가격비교, 웹드라마, 유튜브, AOA유나, 엔플라잉, 엔플라잉 승협, 엔플라잉 재현, 빅픽처하우스, 이벤트">
<meta name="format-detection" content="telephone=no" />
<!-- 프로모션 공통 CSS (Mobile) -->
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<!-- 프로모션별 커스텀 CSS  -->
<link rel="stylesheet" href="/css/swiper.css" type="text/css"/>
<link rel="stylesheet" href="/css/event/y2020/bigpicture_rev_m.css" type="text/css">
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/event_regular.js?v=20180201"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript">
var app = getCookie("appYN"); //app인지 여부
var username = "<%=userArea%>";
var vChkId = "";
</script>
</head>
<body>
<div id="eventWrap">
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>
	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">
		<!-- 상단비주얼 -->		
		<div class="visual">
			<h2 class="blind">에누리 제작지원 뮤지웹드라마</h2>
		</div>
	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<!-- 이벤트01 -->
	<div id="evt1" class="section event_01 scroll"><!-- 이벤트 1 앵커 영역 -->
		<div class="evt_tab">
			<ul>
                <li><a href="javascript:void(0);" class="tab0">HOT ISSUE 빅픽처하우스</a></li>
				<li><a href="javascript:void(0);" class="tab1">꿀잼 에누리 PPL</a></li>
                <li><a href="javascript:void(0);" class="tab2">심쿵 로맨스 본편</a></li>
                <li><a href="javascript:void(0);" class="tab3">감성촉촉 OST</a></li>
			</ul>
        </div>
        <div class="evt_cnt">
            <ul>
                <li>
                    <img src="http://img.enuri.info/images/event/2020/bigpicture/m_tab1_img_01.png" alt="">
                    <div class="casting scroller">
                        <ul class="casting scroll-cont">
                            <li><img src="http://img.enuri.info/images/event/2020/bigpicture/m_casting_01.png" alt=""></li>
                            <li><img src="http://img.enuri.info/images/event/2020/bigpicture/m_casting_02.png" alt=""></li>
                            <li><img src="http://img.enuri.info/images/event/2020/bigpicture/m_casting_03.png" alt=""></li>
                            <li><img src="http://img.enuri.info/images/event/2020/bigpicture/m_casting_04.png" alt=""></li>
                            <li><img src="http://img.enuri.info/images/event/2020/bigpicture/m_casting_05.png" alt=""></li>
                        </ul>
                    </div>
                </li>
                <li class="evt_mv">
                    <div class="mv_tit"></div>
                    <div class="mv_area"></div>
                    <div class="mv_thumb scroller">
                        <ul class="scroll-cont"></ul>
                    </div>
                    <div class="paging">
                        <span class="tx_page">
                            <em>1</em> / 12
                        </span>
                    </div>
                </li>
                <li class="evt_mv">
                    <div class="mv_tit"></div>
                    <div class="mv_area"></div>
                    <div class="mv_thumb scroller">
                        <ul class="scroll-cont"></ul>
                    </div>
                    <div class="paging">
                        <span class="tx_page">
                            <em>1</em> / 12
                        </span>
                    </div>
                </li>
                <li class="evt_mv">
                    <div class="mv_tit"></div>
                    <div class="mv_area"></div>
                    <div class="mv_thumb scroller">
                        <ul class="scroll-cont"></ul>
                    </div>
                    <div class="paging">
                        <span class="tx_page">
                            <em>1</em> / 12
                        </span>
                    </div>
                </li>
            </ul>
        </div>
        <div class="evt_bottom">
            <span class="blind">매주 금,일 저녁 6시 유튜브[빅픽쳐하우스]에서 만나요!</span>
        </div>
        <script>
            $(function(){
                // 탭 이벤트
                var $tab = $(".evt_tab li");
                var $cnt = $(".evt_cnt > ul > li");
                $tab.click(function(){ // 탭 이벤트 ( + 탭 클릭시 영상 리로드 (무한재생이슈))
                    var _idx = $(this).index();
                    if ( !$cnt.eq(_idx).hasClass("on") ){
                        $tab.eq(_idx).addClass("on").siblings().removeClass("on");					
                        $cnt.eq(_idx).addClass("on").siblings().removeClass("on");
                        $cnt.find(".mv_area").each(function(){
                            var tmp = $(this).html();
                            $(this).html( tmp );
                        })
                    }
                }).eq(0).click();
                // 200406 영상정보 추가
                // 영상 정보
                var mvInfo = [
                    [ // tab2 - 꿀잼
                        {
                            tit : 'tab2_tt_m01.png',
                            id : '3_TemkDI-Mk'
                        },{
                            tit : 'tab2_tt_m02.png',
                            id : 'VvTWY3zAuiU'
                        },{
                            tit : 'tab2_tt_m03.png',
                            id : 'QikxvRg7CdA'
                        },{
                            tit : 'tab2_tt_m04.png',
                            id : 'ExdHny3SS9w'
                        },{
                            tit : 'tab2_tt_m05.png',
                            id : 'hHb3U3tum64'
                        }
                    ],[ // tab3 - 심쿵
                        {
                            tit : 'tab3_tt_m01.png',
                            id : '4ognzYtiYsY'
                        },{
                            tit : 'tab3_tt_m02.png',
                            id : '7vzJ7mBH-Ic'
                        },{
                            tit : 'tab3_tt_m03.png',
                            id : 'wSHRFvybNvM'
                        },{
                            tit : 'tab3_tt_m04.png',
                            id : 'RE-gdUVEhBo'
                        },{
                            tit : 'tab3_tt_m05.png',
                            id : 'hrrZGNGgvC0'
                        },{
                            tit : 'tab3_tt_m06.png',
                            id : 'xiWZx2R1Gd0'
                        },{
                            tit : 'tab3_tt_m07.png',
                            id : 'eaEDZ8izOkQ'
                        },{
                            tit : 'tab3_tt_m08.png',
                            id : '8wwu6_LG4L4'
                        },{
                            tit : 'tab3_tt_m09.png',
                            id : null
                        },{
                            tit : 'tab3_tt_m10.png',
                            id : null
                        },{
                            tit : 'tab3_tt_m11.png',
                            id : null
                        },{
                            tit : 'tab3_tt_m12.png',
                            id : null
                        }
                    ],[ // tab4 - 감성촉촉
                        {
                            tit : 'tab4_tt_m01.png',
                            id : 'usiHq_54xP0'
                        },{
                            tit : 'tab4_tt_m02.png',
                            id : 'ejUtMbAuDXM'
                        }
                        // ,{
                        //     tit : 'tab4_tt_pc03.png',
                        //     id : null
                        // }
                    ]
                ]
                var mvPlayer = function(tab){
                    var $this = $(tab),
                    index = $this.index(),
                    mvData = mvInfo[index-1],
                    length = mvData.length,
                    showContent = function(num){ // 영상 교체 이벤트
                        $this.find(".mv_tit").css({"background-image":"url(http://img.enuri.info/images/event/2020/bigpicture/"+mvData[num].tit+")"});
                        if ( mvData[num].id != null ){
                            $this.find(".mv_area").removeClass("coming");
                            $this.find(".mv_area").html('<iframe id="ytplayer" type="text/html" width="600" height="338" src="http://www.youtube.com/embed/'+mvData[num].id+'?rel=0&showinfo=0&wmode=transparent" frameborder="0" allowfullscreen/></iframe>')
                            $this.find(".mv_thumb li").eq(num).addClass("on").siblings().removeClass("on");;
                        }else{
                            $this.find(".mv_area").addClass("coming").html('');
                        }                            
                        $this.find(".paging .tx_page").html('<em>'+(num+1)+'</em> / '+length);
                    };
                    $(mvData).each(function(e){ // 썸네일 가져오기
                        if ( this.id != null ){
                            $this.find(".mv_thumb ul").append('<li class="onair"><img src="https://img.youtube.com/vi/'+this.id+'/default.jpg" style="margin-top:-9px"/></li>')
                        }else{
                            $this.find(".mv_thumb ul").append('<li><img src="http://img.enuri.info/images/event/2020/bigpicture/m_coming.png"/></li>')
                        }
                    })
                    $this.find(".mv_thumb ul li").each(function(e){ // 썸네일 클릭 이벤트
                        if ( mvData[e].id != null ){
                            $(this).click(function(){
                                showContent(e);
                            })
                        }else{
                            $(this).click(function(){
                                alert('4월 중 공개됩니다');
                            })
                        }
                    });
                    showContent(0);
                }
                var $mv_cnt = $(".evt_mv");                                        
                $mv_cnt.each(function(e){
                    mvPlayer(this);
                })
            })
        </script>
	</div>
    <!-- // 이벤트01 -->
    
	
	<!-- PPL -->
    <div class="section event_ppl">
        <div class="evt_inner">
            <h3>빅픽쳐 하우스 친구들의 필수 쇼핑앱 '에누리 가격비교'</h3>
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <div class="swiper-slide">
                        <img src="http://img.enuri.info/images/event/2020/bigpicture/ppl_01.jpg" alt="">
                    </div>
                    <div class="swiper-slide">
                        <img src="http://img.enuri.info/images/event/2020/bigpicture/ppl_02.jpg" alt="">
                    </div>
                    <div class="swiper-slide">
                        <img src="http://img.enuri.info/images/event/2020/bigpicture/ppl_03.jpg" alt="">
                    </div>
                    <div class="swiper-slide">
                        <img src="http://img.enuri.info/images/event/2020/bigpicture/ppl_04.jpg" alt="">
                    </div>
                    <div class="swiper-slide">
                        <img src="http://img.enuri.info/images/event/2020/bigpicture/ppl_05.jpg" alt="">
                    </div>
                </div>
            </div>
            <div class="paging">
                <span class="tx_page">
                    <em>1</em> / 5
                </span>
                <a href="#" class="btn_arr btn_prev">이전</a>
                <a href="#" class="btn_arr btn_next">다음</a>
            </div>
            <script>
                $(function(){
                    var $txtIndexlNum = $(".event_ppl .tx_page em");
                    var mySwiper = new Swiper('.event_ppl .swiper-container',{
                        prevButton : '.event_ppl .btn_prev',
                        nextButton : '.event_ppl .btn_next',
                        loop : false,
                        autoplay : false,
                        speed : 800,
                        onTransitionEnd  : function(e){
                            var _idx = e.realIndex;
                            $txtIndexlNum.html(_idx+1);
                        }
                    })
                })
            </script>
        </div>
    </div>
	
	
	<!-- 이벤트02 -->
	<div id="evt2" class="section event_02 scroll">						
		<div class="evt_inner">
			<div class="evt_img_01">
				<h3 class="blind">에누리 빅픽처마트 유튜브 구독하고 던킨 도너츠 먼치킨 받자!</h3>
			</div>
			<div class="evt_img_02">
		        <a href="javascript:///" target="_blank" class="btn_reply">정답 댓글 남기기</a>
				<!-- 버튼 : 에누리채널 구독하기 -->
				<a href="javascript:///" target="_blank" class="btn_subscribe">에누리 채널 구독하기</a>
			</div>
		</div>
		
		<!-- 버튼 : 웹드라마 더 많은 영상보러가기 -->
		<a href="https://www.youtube.com/channel/UC1g-Zw5BgM4rtiR5E6HOuUg/videos" class="btn_mv_more">웹드라마 더 많은 영상 보러가기</a>
	</div>
	
	
	<!-- //Contents -->	
	<span class="go_top"><a href="javascript:///">TOP</a></span>
	<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
</div>

<!-- layer--> 
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button">설치하기</button></p>
	</div>
</div>

<script type="text/javascript">
(function (global, $) {
	//스크롤
	var nav = $('.myarea'); 
	$(window).scroll(function () {
		if ($(this).scrollTop() > $(".event_01").offset().top) {
			nav.addClass("f-nav");
		} else {
			nav.removeClass("f-nav");
		}
	});
}(window, window.jQuery));

/*레이어*/
function onoff(id){
	var mid = $("#"+id);
	if(mid.css("display") !== "none"){
		mid.css("display","none");
	}else{
		mid.css("display","");
	}
}
var tapType = "<%=tab%>";
var default_src = "<%=ConfigManager.STORAGE_ENURI_COM%>";

var vEvent_title = "빅피쳐하우스";
var vEvent_page = "";

var tab = "<%=tab%>";

//공통영역//
$(document).ready(function() {

	if(islogin()){
		getPoint();
	}
	
	//스크롤
	var nav = $('.myarea'); 
	$(window).scroll(function () {
		if ($(this).scrollTop() > $(".event_01").offset().top) {
			nav.addClass("f-nav");
		} else {
			nav.removeClass("f-nav");
		}
	});
	
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1)		mType = "I";
	else if(navigator.userAgent.indexOf("Android") > -1)		mType = "A";

	var url = window.location.href;

    var offset = "";
    if( url.indexOf("evt1") > -1 )        offset = $("#evt1").offset();
    else if( url.indexOf("evt2") > -1 )   offset = $("#evt2").offset();
    
    if(!!offset){
        var $anchor = offset.top;
        $('html, body').stop().animate({scrollTop: $anchor}, 500);
    }
	//닫기버튼
	 $( ".win_close" ).click(function(){
        if(app == 'Y')  window.location.href = "close://";
        else            window.location.replace("/mobilefirst/index.jsp");
	});
	
	$(".go_top").click(function(){		$(window).scrollTop(0);	});
	ga('send', 'pageview', {'title': vEvent_title + " > " + "PV"});

	$(".btn_reply").click(function(){
		GA("정답댓글버튼");
		location.href = "https://www.youtube.com/watch?v=8wwu6_LG4L4";
	});
	
	$(".btn_subscribe").click(function(){
		GA("에누리채널구독하기");
		window.open("https://www.youtube.com/channel/UCN6V42RolYz-LcIyd0N11XA?view_as=subscriber");
	});
	
});

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
function inner() {
	$('html, body').animate({scrollTop: Math.ceil($('#'+tapType).offset().top-$("#topFix").height())}, 1000);
}
function GA(label){
	ga('send', 'event', 'mf_event', vEvent_title , label );		
}
//앱설치버튼
function install_btt(){
	
	ga('send','event', 'mf_event','click',vEvent_title+'_설치하기');
	
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8';
    }else if(navigator.userAgent.indexOf("Android") > -1){
    	if(gkind == "42"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','SA 42 M_Naver');
    		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=8820367';
    	}else if(gkind == "43"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','SA 43 M_Daum');
    		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=9238355';
    	}else if(gkind == "44"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','SA 44 M_google');
    		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=2709994';
    	}else if(gkind=="72"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','DA 72 M_icover');
    		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=9999961&sub_referral=5642519';
    	}else if(gkind=="75" && gno == "3120469"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','버즈빌_첫구매CU');
    		window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=1917629&sub_referral=8147655";
		}else if(gkind=="74" && gno == "3120470"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','페이스북_첫구매CU');
			window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=4120949&sub_referral=2082626";
		}else if(gkind=="71" && gno =="3100367"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','망고_첫구매CU');
    		window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=9999961&sub_referral=1319566";
    	}else if(gkind=="76" && gno =="3139542"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','애드립_첫구매CU');
    		window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=3535287&sub_referral=3457934";
    	}else if(gkind=="82" && gno =="4299545"){
			ga('send','event', 'mf_event','첫구매이벤트_설치하기','쉘위애드_첫구매');
    		window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6497571&sub_referral=4519572";
    	}else{
    		window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
    	}
    }
}
function commaNum(x) {
	var num;
	try{
		num = x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}catch(e){}
    return num; 
}
//페이지 이동
function XSSfilter (content) {
	return content.replace(/\</g, "&lt;").replace(/\>/g, "&gt;");
}
function welcomeGa(strEvent){
	if(app == "Y"){
		try{
	        if(window.android){            // 안드로이드                  
                 window.android.igaworksEventForApp (strEvent);
	        }else if(/iPhone|iPad|iPod/i.test(navigator.userAgent)){
        		// 아이폰에서 호출
                 location.href = "enuriappcall://igaworksEventForApp?strEvent="+strEvent;
	        }
		}catch(e){}
	}
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
</script>
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script> 
</body>
</html>