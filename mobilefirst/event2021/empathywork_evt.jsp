<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
String strFb_title = "[에누리 가격비교] 새롭게 바뀐 NEW 직장공감 친구에게 공유하고 스타벅스 받자!";
String strFb_description = "직장공감이 새롭게 오픈 했어요!";
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
</head>
<body>
<div class="lay_only_mw" style="display: none;">
	<div class="lay_inner">
		<div class="lay_head">
			앱에서는 득템의 기회 <em>타임특가</em>에 참여할 수 있어요!
		</div>
		<!-- 버튼 : 에누리앱으로 보기 -->
		<button class="btn_go_app" onclick="view_moapp();">에누리앱으로 보기</button>
		<!-- 버튼 : 모바일웹으로 보기 -->
		<a href="javascript:void(0);" class="btn_keep_mw" onclick="$('.lay_only_mw').fadeOut(100);">괜찮아요. 모바일 웹으로 볼래요</a>
	</div>
</div>
<div id="eventWrap" class="event_wrap">
	<input type="hidden" id="pagenum" name="pagenum" value="">
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

	<!-- T1 이벤트 : 경품 -->
    <div class="section event_gift" id="evt1">
        <div class="contents">
            <div class="visual__tit">
                <h1 class="blind">직장인 능력 고사</h1>
                <p class="blind">직장에서의 나의 생존력 등급은/</p>

                <a href="/mobilefirst/event2021/empathywork_quiz.jsp#evt1" onclick="da_ga(3);" class="btn btn_quiz">테스트 시작</a>
            </div>
            <script>
                // 상단 타이틀 등장 모션
                var visualLoad = function(){
                    var $visual = $(".event_gift");
                    $visual.addClass("intro");
                    setTimeout(function(){
                        $visual.addClass("end");
                    },100)
                }
                $(window).on({
                    "load" : visualLoad
                })
            </script>


            <div class="gift_box">
                <div class="gift__tit">
                    <p class="blind">공유하기 이벤트</p>
                    <p class="blind">이 재미있는 걸 나만 알 수 없지!</p>
                    <p class="blind">친구에게 SNS로 공유하고 댓글을 남겨주시면 추첨을 통해 스타벅스 아메리카노를 드립니다.</p>
                </div>
                <div class="gift__img"><!--경품이미지--></div>
            </div>

            <div class="sns_box">
                <p class="sns_num">01</p>
                <p class="sns_tit">원하는 SNS로 친구에게 공유해 주세요!</p>

                <ul class="sns_list" id="share_list">
                    <li id="kakao-link-btn2"><button type="button" title="카카오톡 공유하기">카카오톡</button></li>
                    <li><button type="button" title="페이스북 공유하기">페이스북</button></li>
                    <li><button type="button" title="트위터 공유하기">트위터</button></li>
                    <li><button type="button" title="URL 복사" data-clipboard-text="http://m.enuri.com/mobilefirst/event2021/empathywork_evt.jsp" class="btn_co">URL 복사</button></li>
                </ul>
                
                <!-- 공통 : 꼭 확인하세요  -->
                <div class="com__evt_notice">
                    <div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop1"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
                </div>
                <div id="slidePop1" class="evt_notice--slide">
                    <div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
                        <div class="evt_notice--head">유의사항</div>
                        <div class="evt_notice--cont">
                            <div class="evt_notice--continner">
                                <dl>
                                    <dt>이벤트 기간</dt>
                                    <dd>
                                        <ul>
                                            <li>2021년 4월 15일 ~ 2021년 5월 13일</li>
                                        </ul>
                                    </dd>
                                </dl>
                                <dl>
                                    <dt>이벤트 참여방법</dt>
                                    <dd>
                                        <ul>
                                            <li>로그인 후 직장인 능력 테스트를 SNS 아이콘 클릭 후 공유하기</li>
                                            <li>공유한 SNS 링크를 댓글로 남기기(카카오톡으로 공유한 경우 '공유완료!' 댓글만 남겨도 OK!)</li>
                                            <li>SNS 공유와 댓글 모두 참여할 경우에만 이벤트 응모로 집계되며, 둘 중 하나만 참여한 경우에는 추첨시 제외됨</li>
                                        </ul>
                                    </dd>
                                </dl>
                                <dl>
                                    <dt>이벤트 경품</dt>
                                    <dd>
                                        <ul>
                                            <li>스타벅스 아이스 아메리카노(e머니 4,100점)</li>
                                            <li class="stress">E머니 유효기간: 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</li>
                                            <li>경품은 e쿠폰으로 교환 가능한 e머니로 적립되며, e쿠폰 스토어에서 교환 가능<br>
                                                <span class="noti">※ 경품은 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격변동이 있을 수 있음</span>													
                                            </li>
                                        </ul>
                                    </dd>
                                </dl>
                                <dl>
                                    <dt>당첨자 발표 및 경품지급일</dt>
                                    <dd>
                                        <ul>
                                            <li>당첨자 발표일: 2021년 6월 3일</li>
                                            <li>당첨자 공지: 에누리 앱 &gt; 이벤트/기획전탭 &gt; 이벤트혜택 &gt; 하단 '당첨자 발표'에 공지</li>
                                        </ul>
                                    </dd>
                                </dl>
                                <dl>
                                    <dt>유의사항</dt>
                                    <dd>
                                        <ul>
                                            <li>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</li>
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

            <div class="board_box">
                <p class="board_num">02</p>
                <p class="board_tit">SNS에 공유 후 댓글을 남겨주세요!</p>

                <!-- 게시판 영역 -->
                <div class="board_wrap">
                    
                    <div class="write_area">
                        <div class="input_box">
                            <textarea id="txt_area" class="txt_area" maxlength="150" placeholder="SNS에 공유 후 댓글을 남겨주세요!&#10;이벤트와 무관한 부적절한 글은 삭제될 수 있습니다."></textarea>
                            <button id="" class="btn btn-regist" onclick="goEnter()">등록</button>
                        </div> 
                        
                        <script>
                            $(function(){
                                var $logoutUser = $(".is-alert");
                                $logoutUser.on("click", function(){
                                    alert("로그인 후 참여해주세요");
                                    $logoutUser.addClass("is-login");

                                    $(".txt_area").focus();
                                })
                            })
                        </script>
                    </div>
                    <div class="view_area">
                        <ul>
                        </ul>
                    </div>
                    <div class="paging" id="paginate">
					</div>
                </div>
                <!-- 게시판 영역 -->
            </div>
        </div>

        
    </div>
    <!-- // T1 이벤트 : 경품 -->

	<!-- <span class="go_top"><a href="#">TOP</a></span>  -->
</div>

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

<!-- layer--> 
<div class="layer_back" id="app_only1" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 서비스</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only1').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();" >설치하기</button></p>
	</div>
</div>

<div class="layer_back" id="app_only2" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only2').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();" >설치하기</button></p>
	</div>
</div>

<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20180831"></script>
<script type="text/javascript">
Kakao.init('5cad223fb57213402d8f90de1aa27301');

var app = getCookie("appYN"); //app인지 여부
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로
var vEvent_title = "새롭게 바뀐 NEW 직장공감 친구에게 공유하고 스타벅스 받자!";
var isFlow = "<%=flow%>" == "ad";
var vOs_type = getOsType();
var state = false;
var tab = "<%=tab%>";

var pageno = 1;
var pagesize = 5;
var totalcnt = 0;
var event_id = <%=strEventId%>;

$(".go_top").click(function(){		$('body, html').animate({scrollTop:0}, 500);	});

var shareUrl = "http://" + location.host + "/mobilefirst/event2021/empathywork_evt.jsp";
var shareTitle = "<%=strFb_title%> <%=strFb_description%>";

var oc = '<%=oc%>';

//공통 : 유의사항 레이어 열기/닫기
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
	ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_PV");
	
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
	
	getEventlist(); //게시판
	//recommendItem(); //추천상품
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

function arrayShuffle(oldArray) {
    var newArray = oldArray.slice();
    var len = newArray.length;
    var i = len;
    while (i--) {
        var p = parseInt(Math.random()*len);
        var t = newArray[i];
        newArray[i] = newArray[p];
        newArray[p] = t;
    }
    return newArray;
};

function arrayShuffle2(oldArray) {
    var newArray = oldArray;
    var len = newArray.length;
    var i = len;
    while (i--) {
        var p = parseInt(Math.random()*len);
        var t = newArray[i];
        newArray[i] = newArray[p];
        newArray[p] = t;
    }
    return newArray;
};

function numberWithCommas(x) {   return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");		}

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

function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2021%2Fempathywork_evt.jsp%3Ffreetoken%3Devent";
	
	if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
		goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2021/empathywork_evt.jsp?freetoken=event";
		chrome25 = uagentLow.search("chrome") > -1 && navigator.appVersion.match(/Chrome\/\d+.\d+/)[0].split("/")[1] > 25;
		kitkatWebview = uagentLow.indexOf("naver") != -1 || uagentLow.indexOf("daum") != -1;
		if(kitkatWebview){
			setTimeout( function() {
				if (new Date - openAt < 1100) {
					if (uagentLow.search("android") > -1) {
						location.href = "market://details?id=com.enuri.android";
					}
				}
			}, 1000);
		}else{
			setTimeout( function() {
				if (new Date - openAt < 1500) {
					if (uagentLow.search("android") > -1) {
						location.href = "market://details?id=com.enuri.android";
					}
				}
			}, 1000);
		}
		if(uagentLow.search("android") > -1){
			chrome25 = uagentLow.search("chrome") > -1 && navigator.appVersion.match(/Chrome\/\d+.\d+/)[0].split("/")[1] > 25;
			kitkatWebview = uagentLow.indexOf("naver") != -1 || uagentLow.indexOf("daum") != -1;
			if (chrome25 && !kitkatWebview){
				location.href = goApp;
			} else{
				location.href = goApp;
			}
		}
	}else{
		setTimeout( function() {
			window.location.replace("https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8");
		}, 2000);
		location.href = goApp;
	}
}

function da_ga(num){
	if(num == 2){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_SNS공유_PV");
	}else if(num == 3){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"테스트시작");
	}
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
		}
		/* ,error: function (xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		} */
	});
	return snsCertify;
}
//닫기버튼
$('.win_close').click(function(){
	if(getCookie("appYN") == 'Y'){
		window.location.href = "close://";
	}else{
		window.location.replace("/m/index.jsp");
	}
});

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
//게시판
function goEnter(){
	  if(!IsLogin()){
        alert("로그인 후 참여 가능합니다.");
        goLogin();
        return false;
    }else{
    	$.ajax({
	  		type: "GET",
	  		url: "/member/ajax/getMemberCetify.jsp",
	  		async: false,
	  		dataType:"JSON",
	  		success: function(json){
	  			
	  			/*if(!json.certify){
	  				var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
	  				if(r){
	  					location.href = "/mobilefirst/member/myAuth.jsp?cmdType=&f=m";
	  					return false;	
	  				}else{
	  					return false;	
	  				}
	  				return false;
	  			}else{*/
	  				goReplay();
	  			//}
	  		}
	  	});
    }
	  	
}

function goReplay(){
	
  var txtcnt = $("#txt_area").val().length;
	
  if(txtcnt > 150){
	  alert("150글자 까지만 입력 가능합니다.");
	  return false;
  }

  var reply = $(".txt_area").val();
  var count = reply.length;

  if(reply == "이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다"){
    alert("내용을 입력해주세요!");
    $(".txt_area").focus();
    return false;
  }

  var blank_pattern = /^\s+|\s+$/g;
  if( $("#txt_area").val().replace( blank_pattern, '' ) == "" ){
      alert(' 내용을 입력해주세요! ');
      return false;
  }

  if(count == 0)             alert("내용을 입력해주세요!");
  else{
       var vData = {replyMsg:reply, osType:vOs_type, eventId:event_id,replyType:"O"};
       $.ajax({
          type: "POST",
          url: "/mobilefirst/evt/ajax/reply_setlist.jsp",
          data : vData ,
          dataType: "JSON",
          success: function(json){
               if( json.result == "true"){
                getEventlist();
                alert("등록되었습니다!");
                $(".txt_area").val("");
                $(".word_num > span").text("0");
               
               }else if(json.result==-5){
					
	        	   var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
				   if(r){
						location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
				   }
		           
               }else{
                alert("이미 참여하셨습니다. \n1일 1회 참여가능합니다.");
               }
          },
            error: function (xhr, ajaxOptions, thrownError) {}
       });
   }
	
}

function fnCut(str,lengths) // str은 inputbox에 입력된 문자열이고,lengths는 제한할 문자수 이다.
{
      var len = 0;
      var newStr = '';

      for (var i=0;i<str.length; i++)
      {
        var n = str.charCodeAt(i); // charCodeAt : String개체에서 지정한 인덱스에 있는 문자의 unicode값을 나타내는 수를 리턴한다.
        // 값의 범위는 0과 65535사이이여 첫 128 unicode값은 ascii문자set과 일치한다.지정한 인덱스에 문자가 없다면 NaN을 리턴한다.

       var nv = str.charAt(i); // charAt : string 개체로부터 지정한 위치에 있는 문자를 꺼낸다.


        if ((n>= 0)&&(n<256)) len ++; // ASCII 문자코드 set.
        else len += 2; // 한글이면 2byte로 계산한다.

        if (len>lengths) break; // 제한 문자수를 넘길경우.
        else newStr = newStr + nv;
      }
      return len;
}

function getEventlist(){
	//event_id = "2020112700";
	pageno = $("#pagenum").val()!==""?$("#pagenum").val():1;
	$.ajax({
          type: "GET",
          url: "/event2016/mobile_award_getlist.jsp",
       	  data: "pageno="+pageno+"&pagesize="+pagesize+"&event_id="+event_id+"&del_yn=N",
          dataType: "JSON",
          success: function(json){
                $("#xams_msg").html(null);
                if(json.eventlist){
                     var template = "";

                     for(var i=0;i<json.eventlist.length;i++){
                        var userId = json.eventlist[i].user_id;
                        var reply_msg = XSSfilter(json.eventlist[i].reply_msg).replace(/\n/gi, "<br>");

						if(i==0) totalcnt = json.eventlist[i].totalcnt;
						
                        template += "<li>";
                        template += "	<p class='user'>"+userId+"</p>";
                        template += "	<p class='cont'>"+reply_msg+"</p>";
                    	template += "</li>";
                     }
                     $(".view_area > ul").html(template);
                     
                     if (totalcnt != 0) {
     					var paging2 = new paging(parseInt(pageno), pagesize, 5, totalcnt, 'paginate','goPage');
     				  	paging2.calcPage();
     				  	paging2.getPaging();
     				  	if(pageno!=1){
     				  		var offset = $(".view_area").offset();
     	        	    	$("html,body").stop(true).animate({scrollTop:offset.top - 50},50,"swing");
     				  	}
     				}
                }
          }, complete : function(){
  			$("#paginate > ul > li").click(function(e){
  				$("#paginate > ul > li:eq("+$(this).index()+")").removeClass("selected");
  			});
  		}, error : function (xhr, ajaxOptions, thrownError) {
  		}
     });
	
	function XSSfilter (content) {
		return content.replace(/\</g, "&lt;").replace(/\>/g, "&gt;");
	}
}

//페이지 이동
function goPage(pageno) {
	$("#pagenum").val(pageno);
	getEventlist();
}

</script>

</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
