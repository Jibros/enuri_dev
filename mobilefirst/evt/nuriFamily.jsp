<%@ page contentType="text/html; charset=utf-8"%>
<%@include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%@ include file="/common/jsp/COMMON_CONST_TOP.jsp"%>
<%
String strFb_title = "[에누리 가격비교]";
String strFb_description = "NEW캠페인 유튜브 컨텐츠 프로모션"; 
String strFb_img = ConfigManager.IMG_ENURI_COM + "/images/mobilenew/images/logo_enuri.png";
String strEventId = ChkNull.chkStr(request.getParameter("event_id"),""); 

if(
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Linux") >= 0 ) ||
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0)){
}else{
	response.sendRedirect("/event2020/nuriFamily.jsp");
	return;
}

String chkId     = ChkNull.chkStr(request.getParameter("chk_id"),"");
String cUserId   = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK"),"");

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

SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");	//오늘 날짜
String strToday = formatter.format(new Date());
String sdt = ChkNull.chkStr(request.getParameter("sdt"));

if(!"".equals(sdt) && request.getServerName().equals("dev.enuri.com")){
	strToday = sdt;
}
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
<meta charset="utf-8">	
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
<meta property="og:title" content="에누리 가격비교">
<meta property="og:description" content="에누리 모바일 가격비교">
<meta property="og:image" content="<%=strFb_img%>">
<meta name="format-detection" content="telephone=no" />
<link rel="stylesheet" href="/css/slick.css" type="text/css">
<!-- 프로모션 공통 CSS (Mobile) -->
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<!-- 프로모션별 커스텀 CSS  -->
<link rel="stylesheet" href="/css/event/y2020/nuriFamily_m.css" type="text/css">
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/common/js/lib/jquery.iframetracker.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/common/js/function.js"></script>
<script src="/mobilefirst/js/lib/ga.js"></script>
</head>

<body>
<div id="eventWrap">
	<div class="myarea">
		<p class="name">나의 <em class="emy">머니</em>는 얼마일까?<button type="button" class="btn_login" onclick="goLogin();">로그인</button></p>
		<a href="javascript:///" class="win_close">창닫기</a>
	</div>
		
	<!-- <div class="myarea">
		<p class="name">홍길동 님<span onclick="$('#app_only').show();">14,005,005점</span></p>
		<p class="name" style="display:none;">나의 <em class="emy">머니</em>는 얼마일까?<button type="button" class="btn_login">로그인</button></p>
		<a href="#" class="win_close">창닫기</a>
	</div> -->

	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">
		<!-- 상단비주얼 -->		
		<div class="visual">
			<h2 class="blind">누리네 가족</h2>
		</div>
	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<!-- 이벤트01 -->
	<div id="evt1" class="section event_01 scroll"><!-- 이벤트 1 앵커 영역 -->
		<h3><em>못 말리는 누리네 가족</em>현실공감! 웹 드라마 전격 대공개!</h3>
		<div class="evt_tab ep2">
			<ul>
				<li><a href="#" class="ep1" onclick="insertGa(2);loadPlayer(1);">Episode 1</a></li>
				<li><a href="#" class="ep2" onclick="insertGa(3);loadPlayer(2);">Episode 2</a></li>
			</ul>
		</div>
		<div class="inner">
			<div class="mv_area"  id="ytplayer">
				<iframe id="ytplayer" type="text/html" width="100%" height="100%" src="" frameborder="0" allowfullscreen style="display:none;"/></iframe>
			</div>
		</div>
		
		<script>
		
		</script>
	</div>
	<!-- // 이벤트01 -->

	<!-- 이벤트02 -->
	<div id="evt2" class="section event_02 scroll">				
		<h3>
			<em>누리네 가족</em> 에피소드 시청하시고 감상평을 남겨주세요!
			<small>감상평을 남겨주시는 분들 중 추첨을 통해 경품을 드립니다.</small>
		</h3>
		<div class="inner">
			<div class="event_gift">
				커피빈 상품권 모바일 교환권 5,000원
				<span class="tag">100명 추첨</span>
			</div>
			<!-- 게시판 -->
			<div class="input_board">
				<div class="write_area">
					<div class="input">
						<textarea id="replyMsg" class="txt_area" maxlength="150" placeholder="이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다."></textarea>						
						<button id="registBtn" class="btn regist">등록</button>
					</div>
					<!-- <p class="total_num">전체 글 : <span>1896</span></p> -->
				</div>
				<div class="view_area">
					<ul  id="body_list">
					<!-- 	<li>
							<p class="user">abcdef** <span class="date">2020-01-09</span></p>
							<p class="cont">이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다. 이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다. </p>
						</li>
						<li>
							<p class="user">nuri10** <span class="date">2020-01-09</span></p>
							<p class="cont">이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다. 이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다. </p>
						</li>
						<li>
							<p class="user">lover09** <span class="date">2020-01-09</span></p>
							<p class="cont">이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다. 이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다. </p>
						</li>
						<li>
							<p class="user">ALOHA53** <span class="date">2020-01-09</span></p>
							<p class="cont">이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다. 이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다. </p>
						</li>
						<li>
							<p class="user">abcdef** <span class="date">2020-01-09</span></p>
							<p class="cont">이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다. 이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다. </p>
						</li> -->
					</ul>
				</div>
				<div class="paging" id="paginate">
					<!-- <button class="btn_paging_prev">이전</button>
					<span class="num_paging">
						<em>1</em> / 20
					</span>
					<button class="btn_paging_next">다음</button> -->
				</div>
			</div>
			<!-- // 게시판 -->
		</div>
		<!-- 버튼 : 꼭 확인하세요 -->
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop1" onclick="insertGa(6);"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop1" class="evt_notice--slide">
			<div class="evt_notice--inner">
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<ul class="list__event">
						<li>유튜브를 시청하고 감상평을 댓글로 남길 시 추첨을 통해 경품증정</li>
						<li>이벤트기간 : 2월 17일 ~ 3월 15일</li>
						<li>당첨자 혜택: [커피빈] 커피빈상품권 모바일교환권 5,000원권<br/>(e머니 5,000점) - 100명</li>
						<li>e쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립해드립니다.<br/>(제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격 변동 있을 수 있습니다.)</li>
						<li>당첨자 발표: 5월 15일 당첨자발표 페이지 내 공지</li>
						<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
						<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
					</ul>
				</div>
				<div class="evt_notice--foot">						
					<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 유의사항 닫기 -->
				</div>
			</div>
		</div>
		<script>
			// 유의사항 열기/닫기
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
					el.btnSlide.click();
				})
			})
		</script>
	</div>

	<!-- 이벤트03 -->
	<div id="evt3" class="section event_03 scroll"> <!-- 이벤트 3 앵커 영역 -->
		<h3>우리 가족에게 필요한 아이템을 준비했다! <em>우리집 뽐뿌템</em></h3>
		<div class="inner">
			<div class="goods_list">
	</div>
	
	<!-- //Contents -->	
	<span class="go_top"><a href="#">TOP</a></span>
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
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20180831"></script>
<script type="text/javascript">
var app = getCookie("appYN"); //app인지 여부
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vOs_type = getOsType();
var event_id = "2020020301";
var PAGENO = 1;
var PAGESIZE = 5;
var totalcnt = 0; // 전체 레코드 수
var vEvent_page = "<%=strUrl%>"; //경로
var vEvent_title = "20 유튜브 캠페인 프로모션";

$(document).ready(function() {
	loadPlayer(2);
	insertGa(1);
	getEventList(PAGENO, PAGESIZE); // 게시판의 첫번째 페이지
	recommendItem();
	// 개인정보 불러오기
	if(islogin()){
		$(".login_alert").addClass("disNone");
		$("#user_id").text("<%=cUserId%>");
		getPoint();//개인e머니 내역 노출
	}
	
	$("#registBtn").click(function() {
		insertGa(5);
		if (islogin()) {
			insertAttend();
		} else {
			alert("로그인 후 참여 가능합니다!");
			goLogin();
			return false;
			//Cmd_Login('emoneyPoint');
		}
	});
});
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
//등록하기
function insertAttend() {
	var replyMsg = $("#replyMsg").val();

	if (replyMsg.length < 1) {
		alert("내용을 입력해주세요!");
		return false;
	}

	var url = "/event2017/ajax/event_reply_no_uk.jsp";
	var vData = {replyMsg : replyMsg, event_id : event_id, osType:getOsType()};

	$.ajax({
        type: "POST",
        url: url,
        data: vData,
        dataType: "JSON",
        success: function(result){
        	 if (result.result == "true") {
        		alert("등록되었습니다!");
				goPage(PAGENO);
        	 }else if(result.result == "over"){
        		 alert("아이디당 하루 10건까지 작성 가능합니다. \n내일 또 남겨주세요~");
        	 }else {
				 alert("임직원은 참여가 불가합니다.");
			}
        	$("#replyMsg").val("");
        },
		error: function (xhr, ajaxOptions, thrownError) {
		}
    });
}
//페이지 이동
function goPage(pageno) {
	getEventList(pageno, PAGESIZE);
}
//게시판
function getEventList(varPageNo, varPageSize) {
	$.ajax({
		type: "GET",
		url: "/event2017/ajax/event_reply_no_uk_getlist.jsp",
		data: "pageno="+varPageNo+"&pagesize="+varPageSize+"&event_id="+event_id+"&del_yn=N",
		dataType: "JSON",
		success: function(json){
			$("#body_list").html(null);
			if(json.eventlist){
				var template = "";
				for(var i=0;i<json.eventlist.length;i++){
					if(i==0){
						totalcnt = json.eventlist[i].totalcnt;
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
				if (totalcnt == 0) {
				} else {
					var paging2 = new paging(varPageNo, varPageSize, totalcnt, 'paginate','goPage');
				  	paging2.calcPage();
				  	paging2.getPaging();
					$("#paginate").find("button").click(boardTopMove);
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
	$('html, body').animate({scrollTop : offset.tlop});
}
function XSSfilter (content) {
	return content.replace(/\</g, "&lt;").replace(/\>/g, "&gt;");
}
//페이징
//nCurrentPage : 현재 페이지, nRecordSize : 한 페이지에 있는 레코드 수, nBlockSize : 블록 수
//nTotalRecordSize : 전체 레코드 수, target : 타겟 ID 값, fName : 네비게이션 숫자 클릭시 실행되는 함수 명
function paging(nCurrentPage , nRecordSize, nTotalRecordSize , target,fName){
	this.nRecordSize      = nRecordSize ? nRecordSize : 5;    
	this.nCurrentPage     = nCurrentPage? nCurrentPage: 1; 
	this.nTotalRecordSize = nTotalRecordSize ? nTotalRecordSize : 100;           
	this.nTotalPageSize   = 0;

this.setPage = function(nCurrentPage){
   this.nCurrentPage = nCurrentPage;
}

this.calcPage = function(){
   this.nTotalPageSize =  Math.round(Math.ceil(this.nTotalRecordSize/this.nRecordSize));    
}

this.getPaging = function(){
   var html = "";
   var prev = (1 < nCurrentPage) ? nCurrentPage - 1 : 1;
   var next = (nCurrentPage + 1 > Math.ceil(nTotalRecordSize / nRecordSize)) ? nCurrentPage : nCurrentPage + 1;
   
   html += "<button class='btn_paging_prev' num='" + prev + "'>이전</button>";
   html += "<span class='num_paging'>";
   html += "<em num='" + this.nCurrentPage + "'>"+this.nCurrentPage+"</em> / "+this.nTotalPageSize+"</span>";
   html += "<button class='btn_paging_next'  num='" + next + "'>다음</button>";
   document.getElementById(target).innerHTML = html;   

   $(".btn_paging_prev").click(function(){
  	 eval(fName + '(' + prev +');');
   });
   
   $(".btn_paging_next").click(function(){
  	 eval(fName + '(' + next +');');
   });
}
};

//추천상품
function recommendItem() {
	var ajaxUrl = "/mobilefirst/evt/officeworker_getlist.jsp?p=2&event_id="+event_id+"&tab_no=0";

	var ajaxGD = (function() {
		var GDjson = new Array();
		$.ajax({
			async: false,
			cache: false,
			global: false,
			url: ajaxUrl,
			dataType: "json",
			success: function(data){
				GDjson = data;
			},
			error: function(){
			}
		});
		return GDjson;
	})();

	var GDList = ajaxGD["data"];
	var makehtml = "";
	$(".goods_list").html(makehtml);
	if(GDList.length >0){
		for(var i=0;i<GDList.length;i++){
			if(i<8){
				if(i%4==0) makehtml += "<ul>";				
				var modelno = GDList[i]["model_no"];
				var image = GDList[i]["image"];
				var price = GDList[i]["price"];
				var gd_nm1 = GDList[i]["gd_nm1"];
				var gd_nm2 = GDList[i]["gd_nm2"];
				var url = " /detail.jsp?modelno="+modelno;
				makehtml += "	<li>";
				makehtml+= "	<a href=\"javascript:;\" onclick=\"window.open('/mobilefirst/detail.jsp?modelno="+modelno+"&freetoken=vip');insertGa(7);\" title=\"새 탭에서 열립니다.\">";
				makehtml += " 			<span class='thumb'>";
				makehtml += "				<img src='"+image+"'/>";
				makehtml += "			</span>";
				makehtml += "     		<span class='info'>";
				makehtml += "   			<span class='txt_name'>"+gd_nm1+"<br/>"+gd_nm2+"</span>";
				makehtml += "   			<span class='txt_price'>";			
				makehtml += " 					<span class='lowst1'>최저가</span>";
				makehtml += " 					<em>"+commaNum(price)+"</em>원</span>";
				makehtml += "  			</span>";
				makehtml += "  		</a>";
				makehtml += "	</li>";
				if(i%4==3) makehtml += "</ul>";
			}	
		}
		$(".goods_list").html(makehtml);
		var proSlide = $('.event_03 .goods_list').slick({
			dots:true,
			arrows: true,
			speed : 500,
			focusOnSelect : false,
			slidesToScroll: 1
		});
	}
}
function commaNum(x) {
	var num;
	try{
		num = x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}catch(e){}
    return num; 
}
//닫기버튼
$('.win_close').click(function(){
	if(getCookie("appYN") == 'Y'){
		window.location.href = "close://";
	}else{
		window.location.replace("/mobilefirst/index.jsp");
	}
});
/*레이어*/
function onoff(id){
	var mid = $("#"+id);
	if(mid.css("display") !== "none"){
		mid.css("display","none");
	}else{
		mid.css("display","");
	}
}
function insertGa(num){
	if(num == 1){
		ga('send', 'pageview', {'page': vEvent_page,'title': '20 유튜브 캠페인 프로모션_PV'});
	}else if(num == 2){
		ga('send', 'event', 'mf_event', vEvent_title, "20 유튜브 캠페인 프로모션_상단탭_Ep1");
	}else if(num == 3){
		ga('send', 'event', 'mf_event', vEvent_title, "20 유튜브 캠페인 프로모션_상단탭_Ep2");
	}else if(num == 4){
		ga('send', 'event', 'mf_event', vEvent_title, "20 유튜브 캠페인 프로모션_상단탭_동영상");
	}else if(num == 5){
		ga('send', 'event', 'mf_event', vEvent_title, "20 유튜브 캠페인 프로모션전_댓글");
	}else if(num == 6){
		ga('send', 'event', 'mf_event', vEvent_title, "20 유튜브 캠페인 프로모션_꼭확인하세요");
	}else if(num == 7){
		ga('send', 'event', 'mf_event', vEvent_title, "20 유튜브 캠페인 프로모션_상품클릭");
	}else{
		console.log("8");
	}
}
var tag = document.createElement('script');
tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag); 

var $tab = $(".evt_tab li");
$tab.click(function(e){
	e.preventDefault();
	if ( !$(this).hasClass('disabled') ){
		var idx = $(this).index();
		$tab.eq(idx).addClass("on").siblings().removeClass("on");
	}else{
		alert('2월 중 공개예정 입니다.');
	}
}); 

$(function(){
	$tab.eq(1).click(); // 2주차
}); 

function getArtistId(type) {
	var youtubeId = "LvPNsgCo5JY";
	if(type==1){
		youtubeId ="eu8TbALIZGo";
	}
  return youtubeId;
}  

function loadPlayer(type) { 
	
  if (typeof(YT) == 'undefined' || typeof(YT.Player) == 'undefined') {
    var tag = document.createElement('script');
    tag.src = "https://www.youtube.com/iframe_api";
    var firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
    window.onYouTubePlayerAPIReady = function() {
      onYouTubePlayer(type);
    };
  }else{ 
	  onYouTubePlayer(type);
  } 
}
function onYouTubePlayer(type) {
	  var logCnt = 0; // 로그 카운트
	  var player;
	  // player.destroy;
	 if( logCnt == 0 ) {
		 $("iframe#ytplayer").css("display", "block");
	 } else {
		 $("iframe#ytplayer").attr("src", null);
	 }
	 $("iframe#ytplayer").attr("src", "https://www.youtube.com/embed/" + getArtistId(type));
	/*   player = new YT.Player('ytplayer', {
	    height: '100%',
	    width: '100%',
	    videoId: ,
	    events: {
	      'onStateChange':  function(event) {
	    	  if(logCnt == 0 || logCnt > 2) {
	    		 
	    		  insertGa(4);
	    	  }
	    	  logCnt++;
	      }
	    }
	 
	  }); 
	   */
	i=0;
}

</script> 
</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>