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
    response.sendRedirect("/event2019/shuangshier.jsp"); //pc url
    return;
}

long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String sdt = dayTime.format(new Date(cTime));//진짜시간

if( request.getServerName().indexOf("dev.enuri.com") > -1 && request.getParameter("sdt")!=null && !request.getParameter("sdt").equals("") ) {
	sdt = request.getParameter("sdt");
}

String[] customDate = new String[2];
try{
	int year  = Integer.parseInt(sdt.substring(0, 4));
	int month = Integer.parseInt(sdt.substring(4, 6));

	Calendar cale = Calendar.getInstance();
    SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy년 M월 d일");
    //현재날짜의 세달전 날짜의 1일자
    cale.set(year, month - 1, 1);
    cale.add(Calendar.MONTH, -3);
    customDate[0] = dateFormatter.format(cale.getTime());

    //구한 날짜의 하루전 날짜 (말일자)
    cale.add(Calendar.DATE, -1);
    customDate[1] = dateFormatter.format(cale.getTime());

}catch(Exception e){
	System.out.println("컴백혜택 유의사항 문구 자동화변경 오류: "+ e.getMessage());
	customDate[0] = "2017년 12월 1일";
	customDate[1] = "2017년 6월 30일";
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
    
    /*
    String snsType = ChkNull.chkStr(cb.GetCookie("MEM_INFO","SNSTYPE"));
	if( "K".equals(snsType) ||  "N".equals(snsType) ){//sns 계정일 경우 닉네임을 넣어준다
		userArea = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK")); //로그인 닉네임
	}
	*/
}
String strEventId = "2019110601";
String tab = ChkNull.chkStr(request.getParameter("tab"));

%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<title>에누리(가격비교) eNuri.com</title>
<meta property="og:title" content="에누리 가격비교">
<meta property="og:description" content="에누리 모바일 가격비교">
<meta property="og:image" content="http://img.enuri.com/images/event/2019/coupang/coupang_sns_1200_630.jpg">
<meta name="format-detection" content="telephone=no" />
<link rel="stylesheet" href="/css/event/y2019/shuangshier_m.css" type="text/css">
<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/event_regular.js?v=20180201"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script src="/mobilefirst/js/lib/clipboard.min.js"></script>
<script type="text/javascript" src="/common/js/paging_workers2.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
</head>
<body>
<script type="text/javascript">
var app = getCookie("appYN"); //app인지 여부
var username = "<%=userArea%>";

</script>
<div id="eventWrap">
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>
	
<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">

		<!-- 상단비주얼 -->		
		<div class="visual">
			<div class="inner">
				<span class="txt_sub">Double 12 Day</span>
				<div class="txt_tit">
					<span class="txt txt_01">1</span><span class="txt txt_02">2</span><span class="txt txt_03">.</span><span class="txt txt_04">1</span><span class="txt txt_05">2</span>
					<span class="txt_box"><span>일년에 딱 한번! 솽스얼 SALE</span></span>
				</div>
				<span class="txt_bottom">AliExpress 방문만 해도 <em>스타벅스 디저트 세트</em> 증정!</span>
			</div>
			<span class="obj_flower">
				<span class="flower_01"></span>
				<span class="flower_02"></span>
			</span>
			<div class="loader-box">
				<div class="visual-loader"></div>
			</div>
			<script>
				// 상단 타이들 등장 모션
				$(window).load(function(){
					var $visual = $(".visual");
					$visual.addClass("intro");
					setTimeout(function(){
						$visual.addClass("intro-step2");
						setTimeout(function(){
							$visual.addClass("end");
						},1000)
					},2000)
				})
			</script>
		</div>
	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<!-- 네비 -->
	<div class="navi">
		<ul>
			<li><a href="#evt1">신규회원 할인쿠폰</a></li>
			<li><a href="#evt2">방문만 해도 스타벅스 디저트</a></li>
			<li><a href="#evt3">솽스얼 SALE 추천상품</a></li>
		</ul>
	</div>
	<!-- // -->

	<!-- 이벤트01 -->
	<div id="evt1" class="section event_01 scroll"><!-- 이벤트 1 앵커 영역 -->
		<div class="evt_box">
			<h3><img src="http://img.enuri.info/images/event/2019/shuangshier/m_sec01_tit.png" alt="AliExpress 신규 고객이라면 누구나 할인 쿠폰 지급!"></h3>
			<div class="img_coupon">
				<img src="http://img.enuri.info/images/event/2019/shuangshier/m_sec01_img.jpg" alt="AliExpress Coupon">
			</div>
			<div class="btn_area">
				<a href="javascript:///" class="btn_get_coupon">GET NOW</a>
			</div>
			<dl class="evt_noti">
				<dt>쿠폰 유의사항</dt>
				<dd>
					<ul>
						<li>할인쿠폰은 알리익스프레스 신규회원에 한해 발급 가능</li>
						<li>위 쿠폰은 AliExpress사정에 따라 사전고지 없이 종료될 수 있음</li>
					</ul>
				</dd>
			</dl>		
		</div>
	</div>
	<!-- // 이벤트01 -->

	<!-- 이벤트 02 -->
	<div id="evt2" class="section event_02 scroll">
		<div class="evt_box">
			<h3><img src="http://img.enuri.info/images/event/2019/shuangshier/m_sec02_tit.png" alt="AliExpress 방문만해도 스타벅스 디저트 세트 공짜!"></h3>
			<div class="img_coupon">
				<img src="http://img.enuri.info/images/event/2019/shuangshier/m_sec02_img.jpg" alt="스타벅스 달콤한 디저트 세트">
			</div>
			<div class="btn_wrap">
				<a href="javascript:///" class="btn_visit_ali">AliExpress 방문하기</a>
				<a href="javascript:///" class="btn_apply">방문하고 응모하기</a>
			</div>
			<ul class="evt_noti">
				<li>이벤트기간: 12월 10일 ~ 12월 12일</li>
				<li>당첨자 발표일: 12월 20일</li>
				<li>경품은 해당 e쿠폰으로 교환할 수 있는 e머니로 지급됩니다.</li>
				<li>참여방법: 에누리 로그인 &gt; 알리익스프레스 접속 <br/>&gt; 이벤트 응모하면 완료!</li>
			</ul>
		</div>
		<div class="caution-wrap">
			<div class="btn_box">
				<a class="btn_notice" href="#" onclick="onoff('layerNoti1');return false;">유의사항을 꼭! 확인하세요</a>
			</div>
			<div id="layerNoti1" class="moreview" style="display:none">
				<h4>방문이벤트 유의사항</h4>
				<div class="txt">
					<strong>이벤트 및 구매기간</strong>
					<ul class="txt_indent">
						<li>2019년 12월 10일 ~ 2019년 12월 12일</li>
					</ul>
					<strong>이벤트 참여방법</strong>
					<ul class="txt_indent">
						<li>에누리 로그인 &rarr; 프로모션 페이지 내 AliExpress 바로가기 버튼 클릭 &rarr; 프로모션 페이지에서 응모하기 클릭시 완료!</li>
						<li>로그인하지 않고 방문하거나, 프로모션 페이지가 아닌 다른 페이지에서 방문한 경우 제외</li>
						<li>이벤트 기간 내 1회 응모 가능</li>
					</ul>
					<strong>이벤트 경품</strong>
					<ul class="txt_indent">
						<li>스타벅스 달콤한 디저트세트 (e머니 9,800점)</li>
						<li>e머니 유효기간: 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</li>
						<li>경품은 e쿠폰으로 교환 가능한 e머니로 적립되며, e쿠폰 스토어에서 교환 가능<br/>※ 경품은 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격변동이 있을 수 있음</li>
					</ul>
					<strong>당첨자 발표 및 경품지급일</strong>
					<ul class="txt_indent">
						<li>당첨자 발표일: 2019년 12월 20일</li>
						<li>당첨자 공지: 에누리 앱 > 이벤트/기획전탭 > 이벤트혜택 > 하단 ‘당첨자 발표’에 공지</li>
					</ul>
					<strong>유의사항</strong>
					<ul class="txt_indent">
						<li>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</li>
						<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
					</ul>					
					<a href="#" onclick="onoff('layerNoti1');return false" class="btn_check_hide">확인</a>
				</div>
			</div>
		</div>
	</div>
	<!-- // 이벤트 02 -->

		<!-- 추천기획전 -->
	<!-- 
	<div class="section event_list">
		<h3><img src="http://img.enuri.info/images/event/2019/shuangshier/m_event_tit.png" alt="잠깐! 결정장애 해결해 줄 솽스얼 세일 추천 기획전"></h3>
		<div class="evt_box">
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<a href="javascript:///" onclick="goExh(1)"><img src="http://img.enuri.info/images/event/2019/shuangshier/event_bnr_01.jpg" alt=""></a>
					</div>
					<div class="swiper-slide">
						<a href="javascript:///" onclick="goExh(2)"><img src="http://img.enuri.info/images/event/2019/shuangshier/event_bnr_02.jpg" alt=""></a>
					</div>
					<div class="swiper-slide">
						<a href="javascript:///" onclick="goExh(3)" ><img src="http://img.enuri.info/images/event/2019/shuangshier/event_bnr_03.jpg" alt=""></a>
					</div>
				</div>					
				<div class="swiper-pagination"></div>					
			</div>
			<div class="btn_prev swiper-button-black"></div>
			<div class="btn_next swiper-button-black"></div>
			<script>
				$(function(){
					var mySwiper = Swiper('.event_list .swiper-container',{
						watchActiveIndex: true,
						prevButton : '.event_list .btn_prev',
						nextButton : '.event_list .btn_next',
						pagination: '.event_list .swiper-pagination',
						paginationClickable : true,
						autoHeight : true,
						speed : 800,
						loop : true,
            			spaceBeetween : 0
					});
				});
			</script>
		</div>
	</div>
	 -->
	<!-- // -->	

	<!-- 이벤트03 -->
	<div id="evt3" class="section event_03 scroll"> <!-- 이벤트 3 앵커 영역 -->
		<h3><img src="http://img.enuri.info/images/event/2019/shuangshier/m_sec03_tit.png" alt="뭘 구매해야 할 지 고민된다면? 솽스얼 세일 추천상품"></h3>
		<div class="evt_box">
			<ul id="goodsList"></ul>
		</div>
	</div>
	<!-- // 이벤트 03 -->

	<!-- //Contents -->	
	<span class="go_top"><a href="javascript:///">TOP</a></span>
	
    <%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
</div>

<!-- layer-->
<div class="layer_back fixed" id="app_only" style="display:none;">
    <div class="dimm" onclick="onoff('app_only');"></div>
    <div class="appLayer">
        <h4>모바일 앱 전용 이벤트</h4>
        <a href="javascript:///" class="close" onclick="onoff('app_only');">창닫기</a>
        <p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
        <p class="btn_close"><button type="button"  onclick="install_btt();">설치하기</button></p>
    </div>
</div>
<script type="text/javascript">
var tapType = "<%=tab%>";

var default_src = "<%=ConfigManager.STORAGE_ENURI_COM%>";

var totalcnt = 0;
var event_id = "<%=strEventId%>";

var PAGENO = 1;
var PAGESIZE = 5;
var BLOCKSIZE = 5;

var vEvent_title = "알리이벤트";
var vEvent_page = "";

var vChkId ="";

Kakao.init('5cad223fb57213402d8f90de1aa27301');

var aliYN = "N";

//공통영역//
(function(){
	//스크롤
	var nav = $('.myarea'); 
	$(window).scroll(function () {
		if ($(this).scrollTop() > $(".event_01").offset().top) {
			nav.addClass("f-nav");
		} else {
			nav.removeClass("f-nav");
		}
	});
	
	$(".navi > ul > li ").click(function(){
		var inx = $(this).index();
		if(inx == 0 )      GA("상단탭_할인쿠폰");
		else if(inx == 1 ) GA("상단탭_스타벅스");
		else if(inx == 2 ) GA("상단탭_추천상품");
	});
	
	ga('send', 'pageview', {'title': vEvent_title + " > " + "PV"});
	
	//url 복사
	var clipboard = new ClipboardJS('.icon_share.icon_uc');
	clipboard.on('success', function(e) {
		alert("복사가 완료되었습니다!");
		shareInsert(3);
 	}).on('error', function(e) {
		prompt("아래의 URL을 길게 누르면 복사할 수 있습니다.", shareUrl);
		shareInsert(3);
 	});
	
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1)		mType = "I";
	else if(navigator.userAgent.indexOf("Android") > -1)		mType = "A";
	
	if(islogin())		getPoint();
	//닫기버튼
	 $( ".win_close" ).click(function(){
        if(app == 'Y')  window.location.href = "close://";
        else            window.location.replace("/mobilefirst/index.jsp");
	});
	
	$(".go_top").click(function(){		$(window).scrollTop(0);	});

	getGoodsList();
	
	$(".btn_visit_ali").click(function(){
		
		GA("방문하기");
		
		if(islogin()){
			
			aliYN = "Y";
			
			if(app == "Y")	location.href = "http://s.click.aliexpress.com/e/5we97JYU?freetoken=outlink";
			else			window.open("http://s.click.aliexpress.com/e/5we97JYU?freetoken=outlink");
			
		}else{
			alert("로그인 후 이동 가능합니다");
			loginGo();
		} 
	});
	$(".btn_apply").click(function(){
		
		GA("응모하기");
		
		if(islogin()){
		
			$.ajax({
		 		type: "GET",
		 		url: "/mobilefirst/evt/ajax/aliexpevt2019_setlist.jsp?procCode=3",
		 		dataType: "JSON",
		 		success: function(json){
		 			
		 			if(json.result > 0){
		 				alert("이미 응모해주셨습니다!");
		 			}else{
		 				
		 				if(aliYN == "Y") {
		 					setEnter();	
		 				}else{
		 					alert("AliExpress 바로가기 버튼을 통해 방문 후 응모해주세요!");
		 				}
		 			}
		 		}
		 	});
			
		
		}else{
			alert("로그인 후 참여가능합니다.");
			loginGo();
		}
	});
	
	if(islogin()){
		getPoint();
	}
	
		$(".btn_get_coupon").click(function(){
			
			GA("getnow");
			
			if(islogin()){
				
				if(app == "Y")	location.href = "http://s.click.aliexpress.com/e/koTPbNZm?freetoken=outlink";
				else			window.open("http://s.click.aliexpress.com/e/koTPbNZm?freetoken=outlink");
				
			}else{
				alert("로그인 후 이동가능합니다.");
				loginGo();
			}
		});

})();

function loginGo(){
	location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
	return false;
}

function setEnter(){
	
	if(!islogin()){
		alert("로그인 후 참여가능합니다.");
		loginGo();
	}else{
	
	 	$.ajax({
	 		type: "GET",
	 		url: "/mobilefirst/evt/ajax/aliexpevt2019_setlist.jsp",
	 		dataType: "JSON",
	 		success: function(json){
	 			
	 			if(json.result == 1){
	 				alert("응모완료! 당첨자 발표일을 기다려주세요!");
	 			}else if(json.result == 2601){
	 				alert("이미 응모해주셨습니다!");
	 			}
	 		}
	 	});
 	
	}
	
}

function getCookie(c_name) {
	var i,x,y,ARRcookies=document.cookie.split(";");
	for(i=0;i<ARRcookies.length;i++) {
		x = ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
		y = ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
		x = x.replace(/^\s+|\s+$/g,"");
		if(x==c_name) return unescape(y);
	}
}
function setCookie(c_name, value, exdays) {
	var exdate=new Date();
	exdate.setDate(exdate.getDate() + exdays);
	var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
	c_value += "; domain=" + document.domain;
	c_value += "; path=/ ";

	document.cookie=c_name + "=" + c_value;
}

function inner() {
	$('html, body').animate({scrollTop: Math.ceil($('#'+tapType).offset().top-$("#topFix").height())}, 1000);
}

function GA(label){
	ga('send', 'event', 'mf_event', '알리이벤트',label);		
}

function getGoodsList(){
	 
 	$.ajax({
 		type: "GET",
 		url: "/event2019/shuangshier_goods_ajax.jsp?p=list",
 		dataType: "JSON",
 		success: function(json){
 			
 			var html = "";
 			var cnt = 0;
 			$.each(json.coupang_admin_data , function(i,v){
 				
 				//if(v.so_yn != 'N') return true;
 				
 				
 				html += "<li data-modelno='"+v.modelno+"' data-gm='"+v.evnt_gd_nm+"' data-soyn='"+v.so_yn+"' >";
 				html += "<a href=\"javascript:///\" >";
 				html += "<span class=\"thumb\">";
 				
 				if(v.so_yn == 'Y'){
 					html += "			<span class=\"ico_soldout\">SOLDOUT</span>";	
 				}
 				
 				html += "			<img src='"+default_src+v.gd_img_url+"' alt=''>";
 				html += "		</span>";
 				html += "		<span class=\"info\">";
 				html += "			<span class=\"txt_name\">"+v.evnt_gd_nm+"</span>";
 				html += "			<span class=\"txt_price\">";
 				html += "				<span class=\"txt_lowest\">최저가</span><em>"+commaNum(v.minprice3)+"</em>원";
 				html += "			</span>";
 				html += "		</span>";
 				html += "	</a>";
 				html += "</li>";
 				cnt++;
 				
 			});
 			if(json.coupang_cate_data){
 				
 				$.each(json.coupang_cate_data ,function(i,v){

 	 				if(cnt == 20) return false; 
 	 				
 	 				html += "<li data-modelno='"+v.modelno+"' >";
 	 				html += "<a href=\"javascript:///\" >";
 	 				html += "<span class=\"thumb\">";
 	 				//html += "			<span class=\"ico_soldout\">SOLDOUT</span>";
 	 				html += "			<img src='"+v.img+"' alt=''>";
 	 				html += "		</span>";
 	 				html += "		<span class=\"info\">";
 	 				html += "			<span class=\"txt_name\">"+v.modelnm+"</span>";
 	 				html += "			<span class=\"txt_price\">";
 	 				html += "				<span class=\"txt_lowest\">최저가</span><em>"+commaNum(v.minprice3)+"</em>원";
 	 				html += "			</span>";
 	 				html += "		</span>";
 	 				html += "	</a>";
 	 				html += "</li>";
 	 				
 	 				cnt++;
 	 			});
 			}
 			
 			$("#goodsList").html(html);
 			
 		 	$("#goodsList > li").click(function(){
 		 		var goodsnm = $(this).attr("data-gm");
 		 		var modelno = $(this).attr("data-modelno");
 		 		var soyn = $(this).attr("data-soyn");
 		 		var url = "/mobilefirst/detail.jsp?modelno="+modelno;
 		 		
 		 		GA("상품_#"+goodsnm);
 		 		
 		 		if(soyn != "Y"){
 		 			if(app == "Y"){
 		 				location.href = url;	
 		 			}else{
 		 				window.open(url);
 		 			}
 		 		}
 		 		/*
 		 		if( app == "Y" ){
 		 			
 		 			if(!islogin()){
 		 				alert("로그인 후 참여가능합니다.");
 		 				location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
 		 				return false;
 		 			}else{
 		 				location.href = url;
 		 			}
 		 			
 		 		}else{
 		 			onoff('app_only');
 		 		}
 		 		*/
 		 	});
 		},
 		error: function (xhr, ajaxOptions, thrownError) {
 			alert("잘못된 접근입니다.");
 			//alert(thrownError);
 		}
 	});
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
setTimeout(function(){
	//welcomeGa("evt_coupang_view");    
},500);

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
function goExh(inx){
	var url = "";
	if(inx == 1){
		url = "http://s.click.aliexpress.com/e/Ln59AjHe";
	}else if(inx == 2){
		url = "http://s.click.aliexpress.com/e/qxFfrP76";	
	}else if(inx == 3){
		url = "http://s.click.aliexpress.com/e/me5dp6z2";
	}
	
	if(app =='Y')	location.href = url+"?freetoken=outlink";
	else			window.open(url);
	
}
</script>
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</body>
</html>