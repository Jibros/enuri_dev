<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="com.enuri.util.common.ConfigManager"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
String strFb_img = ConfigManager.IMG_ENURI_COM+ "/images/event/2021/newyear/sns_1200_630.jpg"; //수정
String oc = ChkNull.chkStr(request.getParameter("oc"));
String strFb_title = "[에누리 가격비교] 새해에-누리다!";
String strFb_description = "100% 당첨 설~프라이즈 이벤트를 만나보세요!";

%>
<!-- 200825 : SR#41896 : [MO] SNS 공유 딥링크 연결 팝업  -->
<div class="lay_only_mw" style="display:none;">
	<div class="lay_inner">
		<div class="lay_head">
			앱에서는 득템의 기회 <em>타임특가</em>에 참여할 수 있어요!
		</div>
		<!-- 버튼 : 에누리앱으로 보기 -->
		<button class="btn_go_app" >에누리앱으로 보기</button>
		<!-- 버튼 : 모바일웹으로 보기 -->
		<a href="javascript:void(0);" class="btn_keep_mw" onclick="$('.lay_only_mw').fadeOut(100);">괜찮아요. 모바일 웹으로 볼래요</a>
	</div>
</div>
<!-- // -->

<div class="myarea">
	<p class="name">
		나의 <em class="emy">머니</em>는 얼마일까?
		<button type="button" class="btn_login" onclick="goLogin();">로그인</button>
	</p>
	<a href="javascript:///" class="win_close">창닫기</a>
</div>
<!-- 플로팅 배너 - 둥둥이 -->
<div class="floating_bnr">
	<a href="javascript:///" id="floating_bnr"><img src="http://img.enuri.info/images/event/2021/newyear/visual/bnr_bounce.png"; alt="설 선물 준비하고 골드바 받자!"></a>
	<!-- 닫기 -->
	<a href="#" class="btn_close" onclick="onoff('floating_bnr');return false;">
		<span class="blind">닫기</span>
 	</a>
</div>
<!-- // -->

	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">		
		<!-- 공통 : 공유하기 버튼  -->
		<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
		<!-- // -->

		<!-- 공통 : 상단비주얼 -->
		<div class="visual">
			<div class="inner">
				<span class="txt_01">2021년 신축년</span>
				<h2>새해에-누리다</h2>
				<span class="txt_02">2021. 01. 18 ~ 02. 14</span>
				
				<div class="obj_bird"><!-- 새 --></div>
				<div class="obj_sun"><!-- 해 --></div>
			</div>
			
			<div class="loader-box">
				<div class="visual-loader"></div>
			</div>
			<script>
				// 상단 타이틀 등장 모션
				$(window).load(function(){
					var $visual = $(".toparea .visual");
					$visual.addClass("intro");
					setTimeout(function(){
						$visual.addClass("end");
					},100)
				})
			</script>
		</div>

		<!-- 공통 : 탭 -->	
		<div class="section navtab">
			<div class="navtab_inner">
				<ul class="navtab_list">
					<li><a href="/mobilefirst/event2021/newyear_2021_evt.jsp" class="navtab_item--01">설프라이즈 100% 당첨</a></li>
					<li><a href="/mobilefirst/event2021/newyear_2021_deal.jsp" class="navtab_item--02">설 준비하고 골드바 득템</a></li>
					<li><a href="/mobilefirst/event2021/newyear_2021.jsp" class="navtab_item--03">명절 준비하소</a></li>
				</ul>
			</div>
		</div>
		<!-- //탭 -->
		
	</div>
	<!-- //비쥬얼,플로팅탭 -->

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
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20200629"></script>
<script type="text/javascript" src="/mobilefirst/event/js/exhibition_m.js"></script>
<script type="text/javascript">
var oc = '<%=oc%>';
var app = getCookie("appYN"); //app인지 여부

$(function(){
	var clipboard = new ClipboardJS('.com__share_wrap .btn__share_copy');
	clipboard.on('success', function(e) {
		alert('주소가 복사되었습니다');
	});
	clipboard.on('error', function(e) {
		console.log(e);
	});
});

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

//수정
var vEvent_title = "21년 설날 통합기획전";
var gaLabel = [  vEvent_title+"_PV"
				,vEvent_title+"_상단탭_단순참여 이벤트"
				,vEvent_title+"_상단탭_구매응모 이벤트"
				,vEvent_title+"_상단탭_기획전"
				,vEvent_title+"_상단플로팅배너"
				,vEvent_title+"_떡국 이벤트 참여"
				,vEvent_title+"_연하장 이벤트 참여"
				,vEvent_title+"_혜택배너"
				,vEvent_title+"_구매이벤트 기획전보기"
				,vEvent_title+"_구매이벤트 참여"
				,vEvent_title+"_BEST 설날선물_탭_축산/신선식품"
				,vEvent_title+"_BEST 설날선물_탭_건강식품"
				,vEvent_title+"_BEST 설날선물_탭_효도가전"
				,vEvent_title+"_BEST 설날선물_탭_상품권"
				,vEvent_title+"_BEST 설날선물_상품클릭"
				,vEvent_title+"_BEST 설날선물_탭_상품더보기"
				,vEvent_title+"_가격대별 설날선물_탭_1~3만원"
				,vEvent_title+"_가격대별 설날선물_탭_3~5만원"
				,vEvent_title+"_가격대별 설날선물_탭_5~10만원"
				,vEvent_title+"_가격대별 설날선물_탭_10만원 이상"
				,vEvent_title+"_가격대별 설날선물_상품클릭"
				,vEvent_title+"_가격대별 설날선물_상품더보기"
				,vEvent_title+"_즐거운 귀성준비_탭_귀성길"
				,vEvent_title+"_즐거운 귀성준비_탭_돈봉투"
				,vEvent_title+"_즐거운 귀성준비_탭_보드게임"
				,vEvent_title+"_즐거운 귀성준비_탭_유아한복"
				,vEvent_title+"_즐거운 귀성준비_상품클릭"
				,vEvent_title+"_즐거운 귀성준비_탭_상품더보기"
				,vEvent_title+"_1인가구 연휴준비_탭_게임기"
				,vEvent_title+"_1인가구 연휴준비_탭_간편가정식"
				,vEvent_title+"_1인가구 연휴준비_탭_e쿠폰"
				,vEvent_title+"_1인가구 연휴준비_탭_댕냥이한복"
				,vEvent_title+"_1인가구 연휴준비_상품클릭"
				,vEvent_title+"_1인가구 연휴준비_상품더보기"
				,vEvent_title+"_기획전 브릿지"
				 ];

$(document).ready(function(){
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
		location.href = "/mobilefirst/event2021/newyear_2021_deal.jsp?tab=01";
		return false;
	});
	$(".ben_list").click(function(){
		ga_log(7);
	});
	$(".share_list").click(function(){
		ga_log(11);
	});
	
	//에누리 혜택 로그
	$(".ben_item--01, .ben_item--02, .ben_item--03, .ben_item--04").click(function(){
		ga_log(8);
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
		$("#txtURL").text("http://m.enuri.com/mobilefirst/event2021/newyear_2021_evt.jsp?oc=sns");
	}else if(evntPage.indexOf("_deal") > -1){
		$(".navtab_inner .navtab_list .navtab_item--02").parent("li").addClass("is-on");
		$("#txtURL").text("http://m.enuri.com/mobilefirst/event2021/newyear_2021_deal.jsp?oc=sns");
	}else{
		$(".navtab_inner .navtab_list .navtab_item--03").parent("li").addClass("is-on");
		$("#txtURL").text("http://m.enuri.com/mobilefirst/event2021/newyear_2021.jsp?oc=sns");
	}
//
}

//sns 공유하기 함수
function shareSns(param){ //수정
	var share_url = "";
	
	if(evntPage.indexOf("_evt") > -1){
		share_url = "http://" + location.host + "/mobilefirst/event2021/newyear_2021_evt.jsp?oc=sns";
	}else if(evntPage.indexOf("_deal") > -1){
		share_url = "http://" + location.host + "/mobilefirst/event2021/newyear_2021_deal.jsp?oc=sns";
	}else{
		share_url = "http://" + location.host + "/mobilefirst/event2021/newyear_2021.jsp?oc=sns";
	}
	var share_title = "[에누리 가격비교] 새해에-누리다!";
	var share_description = "100% 당첨 설~프라이즈 이벤트를 만나보세요!";
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
		var share_title_twi = "[에누리 가격비교] 새해에-누리는 혜택! 100% 당첨 설~프라이즈 이벤트를 만나보세요! ";
		window.open("https://twitter.com/intent/tweet?text="+encodeURIComponent(share_title_twi)+"&url="+share_url);
	}
}
</script>