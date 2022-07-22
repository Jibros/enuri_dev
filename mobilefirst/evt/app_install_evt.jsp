<%@page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
	String cUserId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
	String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");
	
	String chkId = ChkNull.chkStr(request.getParameter("chk_id"));
	
	Members_Proc members_proc = new Members_Proc();

	String cUsername = "";
	String userArea = "";

	if(!cUserId.equals("")){
	    cUsername = members_proc.getUserName(cUserId);
	    userArea = cUsername;
	
	    if(cUsername.equals(""))      userArea = cUserNick;
	    if(userArea.equals(""))        userArea = cUserId;
	    
	}
	String strEventId = "2019061801";
	String strEventId2 = "2019061802";
	
	String appYN = ChkNull.chkStr(request.getParameter("app"),"");
	if(appYN.equals("")){
		appYN = ChkNull.chkStr(cb.getCookie_One("appYN"));	
	}
%>

<!DOCTYPE html> 
<html lang="ko">
<head>
<meta charset="utf-8">	
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
<!-- <meta property="og:title" content="에누리 가격비교">
<meta property="og:description" content="에누리 모바일 가격비교">
<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png"> -->
<meta name="format-detection" content="telephone=no" />
<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
<link rel="stylesheet" href="/css/event/y2019/renewapp_m.css" type="text/css">
<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/common/js/paging_workers2.js"></script>
<script type="text/javascript" src="/mobilefirst/js/event_regular.js?v=20180201"></script>
</head>

<body>
<div id="eventWrap">
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>
	
	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">		
		<!-- 상단비주얼 -->		
		<div class="visual">
			<div class="inner">
				<span class="txt_stit">리뉴얼 기념 이벤트</span>
				<h1><span class="txt_tit txt_01">에누리APP이</span><span class="txt_tit txt_02">달</span><span class="txt_tit txt_03">라</span><span class="txt_tit txt_04">졌</span><span class="txt_tit txt_05">어</span><span class="txt_tit txt_06">요</span></h1>			
				<span class="top_tit_02">지금 더 쉽고 편리해진 에누리 앱을 만나보세요!</span>
				<div class="obj-phone">
					<div class="swiper-cover"></div>
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<div class="swiper-slide" style="background:url(http://img.enuri.info/images/event/2019/renewAppEvent/home_372x686.jpg) no-repeat 50% 0;background-size:100% auto"></div>
							<div class="swiper-slide" style="background:url(http://img.enuri.info/images/event/2019/renewAppEvent/cate_372x686.jpg) no-repeat 50% 0;background-size:100% auto"></div>
							<div class="swiper-slide" style="background:url(http://img.enuri.info/images/event/2019/renewAppEvent/SRP_372x686.jpg) no-repeat 50% 0;background-size:100% auto"></div>
							<div class="swiper-slide" style="background:url(http://img.enuri.info/images/event/2019/renewAppEvent/MY_372x686.jpg) no-repeat 50% 0;background-size:100% auto"></div>
							<div class="swiper-slide" style="background:url(http://img.enuri.info/images/event/2019/renewAppEvent/VIP_372x686.jpg) no-repeat 50% 0;background-size:100% auto"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="bg_visual">
				<span class="bg_deco"></span>
			</div>			
		</div>
		<script>
			$(window).load(function(){
				// 로드 후 
				var $visual = $('.visual');
				$visual.addClass("play");
				setTimeout(function(){
					var mySwiper = new Swiper('.visual .swiper-container', {
						simulateTouch : false,
						speed : 800,
						autoplay : 4000,
						loop : true,
						spaceBetween: 0
					});  
				},1000)
			});
		</script>	
	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<!-- 190626 수정 : 이벤트01 -->
	<div id="evt1" class="section evt_1st scroll">
		<div class="contents">
			<h3><img src="http://img.enuri.info/images/event/2019/renewAppEvent/m_sec1_tit.png" alt="에누리 앱이 이렇게 달라졌어요!"></h3>
			<div class="inner">
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide"><img src="http://img.enuri.info/images/event/2019/renewAppEvent/m_sec1_slide_01.png" alt=""></div>
						<div class="swiper-slide"><img src="http://img.enuri.info/images/event/2019/renewAppEvent/m_sec1_slide_02.png" alt=""></div>
						<div class="swiper-slide"><img src="http://img.enuri.info/images/event/2019/renewAppEvent/m_sec1_slide_03.png" alt=""></div>
						<div class="swiper-slide"><img src="http://img.enuri.info/images/event/2019/renewAppEvent/m_sec1_slide_04.png" alt=""></div>
					</div>
					<div class="swiper-pagination"></div>
					<script>
						$(function(){
							var mySwiper = new Swiper('.evt_1st .swiper-container', {
								simulateTouch : true,
								pagination : ".evt_1st .swiper-pagination",
								speed : 800,
								autoplay : 4000,
								loop : true,
								spaceBetween: 0
							}); 
						})
					</script>
				</div>
				<!-- 앱 다운받기 -->
				<a href="javascript:///" class="btn_app btn_app_down" onclick="ga('send','event', 'mf_event','19년 앱개편프로모션','app다운받기');onoff('app_only'); return false;" style="display:none">앱 다운받기</a>
				<!-- 앱 바로가기 -->
				<!-- <a href="#" class="btn_app" onclick="onoff('app_only'); return false;">앱 바로가기</a> -->
			</div>	
		</div>
	</div>
	<!-- //이벤트01 -->


	<!-- 이벤트02 -->
	<div class="section evt_2nd scroll">				
		<div class="contents">
			<h3><img src="http://img.enuri.info/images/event/2019/renewAppEvent/m_sec2_tit.png" alt="달라진 에누리 앱에 대한 의견을 남겨주세요! 인기쿠폰을 선물로 드립니다."></h3>
			<ul class="gift_list">
				<li><img src="http://img.enuri.info/images/event/2019/renewAppEvent/m_sec2_gift_01.jpg" alt="피자헛 크런치 베이컨 포테이토 + 콜라 (10명)"></li>
				<li><img src="http://img.enuri.info/images/event/2019/renewAppEvent/m_sec2_gift_02.jpg" alt="설빙 애플망고 치즈설빙 (20명)"></li>
				<li><img src="http://img.enuri.info/images/event/2019/renewAppEvent/m_sec2_gift_03.jpg" alt="맥도날드 빅맥세트 (90명)"></li>
				<li><img src="http://img.enuri.info/images/event/2019/renewAppEvent/m_sec2_gift_04.jpg" alt="e머니 10점 (참여자전원)"></li>
			</ul>

			<!-- 게시판 -->
			<div class="input_board">
				<div class="write_area">
					<!-- 
						로그인 전,

						.login_alert 클릭 -> alert(로그인참여)

						로그인 후,
						1. login_alert disNone 클래스 추가
						2. 댓글 입력 시, 창 확대 input open 클래스 추가

						댓글 영역 외에 터치 했을 때, 2,3 번 반대로 

						작업할 때 설명 한 번 드릴게요~
					-->
					<%if(cUserId.equals("")){%>
					<div class="input logout">
						<textarea id="" class="txt_area" placeholder="글을 입력해 주세요."></textarea>
						<!--
							로그인 전, placeholder="글을 입력해 주세요."
							로그인 후, placeholder="이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다."
						-->
						<button class="btn regist stripe">등록하기</button>
					</div>
					<%}else{ %>
					<!-- 로그인 후 -->
					<div class="input login">
						<textarea id="replyMsg" class="txt_area" maxlength="150"  placeholder="이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다."></textarea>
						<button id="" class="btn regist stripe">등록하기</button>
					</div>
					<%} %>
				</div>
				<div class="view_area">
					<ul id="body_list"></ul>
				</div>
				<div class="paging" id="paginate"></div>
			</div>
			<!-- // 게시판 -->
			<a href="javascript:///" class="btn_caution btn_caution-1" onclick="onoff('notetxt1'); return false;">꼭!확인하세요</a>
		</div>
	</div>
	
	<!-- 190626 추가 : 이벤트 03 -->
	<div class="section evt_3rd scroll">
		<div class="contents">
			<h3><img src="http://img.enuri.info/images/event/2019/renewAppEvent/m_sec3_tit.png" alt="에누리 앱을 이용하고 리뷰를 남기시면 보너스 경품을 드립니다!"></h3>
			<img src="http://img.enuri.info/images/event/2019/renewAppEvent/m_sec3_img.jpg" alt="앱 리뷰어 50명 추첨 베스킨라빈스 싱글레귤러 2,500점">
			<div class="btn_wrap">
				<a href="javascript:///" class="btn_app_store" onclick="goAppStore()" >앱스토어 바로가기</a>
				<a href="javascript:///" class="btn_join_evt" onclick="ga('send','event', 'mf_event','19년 앱개편프로모션','앱스토어 바로가기');onoff('appEvtJoin1'); return false;">이벤트 참여하기</a>
			</div>
			<a href="javascript:///" class="btn_caution btn_caution-1" onclick="ga('send','event', 'mf_event','19년 앱개편프로모션','이벤트 참여하기');onoff('notetxt2'); return false;">꼭!확인하세요</a>
		</div>
	</div>
	<!-- //이벤트 03 -->
	
	<!-- //Contents -->	
	<span class="go_top"><a href="javascript:///">TOP</a></span>
</div>

<!-- layer--> 
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 에서 확인해주세요</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt()" >설치하기</button></p>
	</div>
</div>

<!-- 기능 자세히 보기 --> 
<div id="vDetail" class="pop-layer" style="!display:none;">
	<div class="popupLayer">
		<div class="dim"></div>
	</div>
	<div class="popup_box">
		<!-- 에누리앱이 이렇게 달라졌어요! -->
		<a href="javascript:void(0);" class="btn_close" onclick="$('#vDetail').removeClass('show');$(this).parent().removeClass('view').removeAttr('data-bg-type');return false;"></a>
	</div>
</div>

<!-- 유의사항 -->
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="noteLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1');return false;">창닫기</a>

		<div class="inner">
			<dl class="txtlist">
				<dt>이벤트 기간 :</dt>
				<dd>2019년 7월 4일 ~ 7월 21일</dd>
			</dl>
			
			<dl class="txtlist">
				<dt>이벤트 경품 : </dt>
				<dd>&lt;피자헛&gt;크런치베이컨포테이토+콜라 1.25(e 28,500점) - 10명 추첨</dd>
				<dd>&lt;설빙&gt;애플망고 치즈설빙 (e 9,900점) - 20명 추첨</dd>
				<dd>&lt;맥도날드&gt;빅맥세트 (e 5,800점) – 90명 추첨</dd>
				<dd>e머니 10점 (e 10점) – 참여자 전원<br/>
					<strong class="emp">※ e머니 10점 경품은 다른 경품과 중복당첨되지 않습니다.</strong>
				</dd>
			</dl>

			<dl class="txtlist">
				<dt> 당첨자 발표 :</dt>
				<dd>2019년 8월 5일 [APP 이벤트/기획전 탭 &gt; 이벤트 하단 당첨자 발표]<br/><br/></dd>
				<dd>ID당 1일 1회 참여 가능 </dd>
				<dd>적립된 e머니는 e머니 스토어에서 다양한 e쿠폰상품으로 교환 가능합니다.</dd>
				<dd>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)  </dd>
				<dd>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다.</dd>
			</dl>
		</div>
		<p class="btn_close"><button type="button" onclick="onoff('notetxt1');return false;">닫기</button></p>
	</div>
	
</div>

<!-- 190626 추가 : 유의사항 -->
<div class="layer_back" id="notetxt2" style="display:none;">
	<div class="noteLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt2');return false;">창닫기</a>

		<div class="inner">
			<ul class="txtlist">
				<li>앱스토어에 리뷰를 남길 시 추첨을 통해 경품을 지급해드립니다.</li>
				<li>당첨자 혜택: <span class="emp">[베스킨라빈스] 싱글레귤러 아이스크림(e 2,800) - 50명 추첨 </span></li>
				<li> 이벤트 참여하기에 남긴 ID가 리뷰에 남긴 ID와 동일하지 않을 경우 경품지급 제외될 수 있습니다.</li>
				<li>E쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립해드립니다. (제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격 변동 있을 수 있습니다.)</li>
				<li>당첨자 발표: <span class="emp">2019년 8월 5일 월요일</span> </li>
				<li>E머니 유효기간: <span class="emp">적립일로부터 15일 (미사용시 자동소멸)</span></li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
			</ul>
		</div>
		<p class="btn_close"><button type="button" onclick="onoff('notetxt2');return false;">닫기</button></p>
	</div>
</div>
<!-- // 유의사항 -->


<!-- 190626 추가 : 앱 리뷰 이벤트 - 참여하기 -->
<div class="layer_back" id="appEvtJoin1" style="display:none;">
	<div class="reviewEvtLayer">
		<h4>앱 리뷰 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#appEvtJoin1').hide();">창닫기</a>
		<p class="tit"><em>리뷰 남긴 ID 혹은 닉네임</em>을 적은후<br/>참여완료 버튼을 눌러주세요.</p>
		<p class="input_area">
			<input type="text" name="userNick" id="userNick" maxlength="20" onfocus="this.value='';" value="ID / 닉네임 입력"  />
			<a class="btn layjoin" href="javascript:void(0);" >참여완료</a>
		</p>
	</div>
</div>

<!-- 190626 추가 : 앱 리뷰 이벤트 - 참여하기 완료 -->
<div class="layer_back" id="appEvtJoin2" style="display:none;">
	<div class="reviewEvtLayer">
		<h4>앱 리뷰 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#appEvtJoin2').hide();">창닫기</a>
		<p class="tit">참여완료 되었습니다<br/>&nbsp;</p>
		<a class="btn layConfirm" href="javascript:void(0);" onclick="onoff('appEvtJoin2');return false">확인</a>
	</div>
</div>


<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>

<!-- // 유의사항 -->
<script type="text/javascript">

var app = getCookie("appYN"); //app인지 여부

var totalcnt = 0;

var event_id = "<%=strEventId%>";
var event_id2 = "<%=strEventId2%>";
var PAGENO = 1;
var PAGESIZE = 5;
var BLOCKSIZE = 5;

var username = "<%=userArea%>";
var vChkId = "<%=chkId %>";


(function (global, $) {
	
	if(app != "Y"){
		$(".btn_app.btn_app_down").show();	
	}
	
	//스크롤
	var nav = $('.myarea'); 
	$(window).scroll(function () {
		if ($(this).scrollTop() > $(".toparea").height()) {
			nav.addClass("f-nav");
		} else {
			nav.removeClass("f-nav");
		}
	});
	
	$(".regist").click(function(){
		insertReplayMsg();
	});
	
	getEventList(PAGENO, PAGESIZE); // 게시판의 첫번째 페이지
	
	$(".btn.layjoin").click(function(){
		ga('send','event', 'mf_event','19년 앱개편프로모션','참여완료');
		insertNickName();
	});
	
	if(islogin()) getPoint(); //로그인상태인 경우 개인e머니 내역 노출
	//닫기버튼
	 $( ".win_close" ).click(function(){
        if("<%=appYN %>" == 'Y')  window.location.href = "close://";
        else            window.location.replace("/mobilefirst/index.jsp");
	});
	
	 $(".go_top").click(function(){		$(window).scrollTop(0);	});
	
	 ga('send', 'pageview', {'title': '19년 앱개편프로모션_PV'});
	 
	
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

//페이지 이동
function goPage(pageno) {
	getEventList(pageno, PAGESIZE);
}

//등록하기
function insertReplayMsg() {
	
	ga('send','event', 'mf_event','19년 앱개편프로모션','댓글_등록하기');
	
	if(!islogin()){
		location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
		return false;
	}
	
	var replyMsg = $("#replyMsg").val();

	if (replyMsg.length < 1) {
		alert("내용을 입력해주세요!");
		return false;
	}

	var url = "/event2016/mobile_award_setlist.jsp";
	var vData = {replyMsg : replyMsg, event_id : event_id };

	$.ajax({
        type: "POST",
        url: url,
        data: vData,
        dataType: "JSON",
        success: function(result){
        	 if (result.result == "true") {
        		alert("등록되었습니다!");
				goPage(PAGENO);
        	 }else if(result.result == -5){
				if (confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?") == true){    
					location.href="<%=ConfigManager.ENURI_COM_SSL%>/mobilefirst/member/myAuth.jsp?cmdType=modify&f=p";
				}else{
					return false;
				}
			 } else {
				alert("오늘은 이미 참여해 주셨습니다! \n내일 또 남겨주세요~");
			}
        	$("#replyMsg").val("");
        	$("#word_num").text(0);
        },
		error: function (xhr, ajaxOptions, thrownError) {

		}
    });
}
//등록하기
function insertNickName() {
	
	if(!islogin()){
		location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
		return false;
	}
	
	var userNick = $("#userNick").val();

	if("ID / 닉네임 입력" == userNick){
		alert("닉네임을 입력해주세요!");
		return false;
	}
	
	if (userNick.length < 1) {
		alert("닉네임을 입력해주세요!");
		return false;
	}
	
	var url = "/mobilefirst/ajax/eventAjax/app_install_setlist.jsp";
	var vData = {replyMsg : userNick, event_id : event_id2 };

	$.ajax({
        type: "POST",
        url: url,
        data: vData,
        dataType: "JSON",
        success: function(result){
        	 
        	if (result.result == "true") {
        		alert("등록되었습니다!");
			} else {
				alert("이미 참여해 주셨습니다! ");
			}
        	$("#userNick").val("");
        	$("#appEvtJoin1").hide();
        },
		error: function (xhr, ajaxOptions, thrownError) {
		}
    });
}

function getEventList(varPageNo, varPageSize) {
	$.ajax({
		type: "GET",
		url: "/event2016/mobile_award_getlist.jsp",
		data: "p=office&pageno="+varPageNo+"&pagesize="+varPageSize+"&event_id="+event_id+"&del_yn=N",
		dataType: "JSON",
		success: function(json){
			$("#body_list").html(null);

			if(json.eventlist){
				var template = "";

				for(var i=0;i<json.eventlist.length;i++){
					if(i==0){
						totalcnt = json.eventlist[i].totalcnt;
					}
					var likeCnt = json.eventlist[i].cnt;

					if (likeCnt > 999) {
						likeCnt = 999;
					}
					var reply_date = json.eventlist[i].reply_date;
					var year = reply_date.substring(0,4);
					var month = reply_date.substring(6,4);
					var day = reply_date.substring(8,6);
					var user_id = json.eventlist[i].user_id;
					var reply_msg = XSSfilter(json.eventlist[i].reply_msg);

					template += "<li>";
					template += "  <p class='user'>" + user_id + " <span class='date'>" + year +"-"+ month +"-"+ day + "</span></p>   ";
					template += "  <p class='cont'>" + reply_msg + "</p>             			";
					template += "</li>";
				}

				$("#body_list").html(template);

				var naviCnt = (totalcnt/varPageSize) + 1;

				if (totalcnt == 0) {
				} else {
					var paging2 = new paging(varPageNo, varPageSize, BLOCKSIZE, totalcnt, 'paginate','goPage');

				  	paging2.calcPage();
				  	paging2.getPaging();
					$("#paginate").find("a").click(boardTopMove);

				}
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert("잘못된 접근입니다.");
			//alert(thrownError);
		}
	});
}

function boardTopMove(){
	var offset = $("#replyMsg").offset();
	$('html, body').animate({scrollTop : offset.top});
}

function XSSfilter (content) {
	return content.replace(/\</g, "&lt;").replace(/\>/g, "&gt;");
}

function install_btt(){
	
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8';
    }else if(navigator.userAgent.indexOf("Android") > -1){
    	window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
    }
}

function goAppStore(){
	//설치하기
	var url;
	if( navigator.userAgent.indexOf("iPhone") > -1 || 
		navigator.userAgent.indexOf("iPod") > -1 || 
		navigator.userAgent.indexOf("iPad") > -1){

		//url = "https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8&freetoken=outlink";
		url = "https://play.google.com/store/apps/details?id=com.enuri.android";

	}else if(navigator.userAgent.indexOf("Android") > -1){
		url = "market://details?id=com.enuri.android&referrer=" + 
		"utm_source%3Denuri.%26utm_medium%3Dreview_event%26utm_campaign%3Dreview_promotion_20151231%2520";
	}				
	window.location.href = url;
}

</script> 
</body>
</html>