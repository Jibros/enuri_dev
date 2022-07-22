<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="org.apache.commons.lang3.StringUtils"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="com.enuri.util.http.*"%>
<%@ page import="com.enuri.bean.mobile.Reward_Proc"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.event.every.Event_201602_Every_Proc"%>
<%@page import="com.enuri.bean.event.every.Event_201602_Every_Visit_Data"%>
<%
	/*

	SSL 서버에는
	com.enuri.bean.mobile.Reward_Proc
	com.enuri.bean.event.every.Event_201602_Every_Proc
	com.enuri.bean.event.every.Event_201602_Every_Visit_Data
	class가 없기 때문에 아래 redirect 소스만 있음

	StringBuffer strServer = request.getRequestURL();
	 if(strServer.indexOf("https://") > -1 ){
		response.sendRedirect("http://m.enuri.com/mobilefirst/emoney/benefit.jsp");
		return;
	}  */

	// 이벤트 아이디
	final String strEventId = "2016021501";
	// 유저 아이디 가져오기
	cb = new CookieBean(request.getCookies());
	String userId = cb.GetCookie("MEM_INFO","USER_ID");
	String strApp = cb.getCookie_One("appYN");	// 앱 여부 체크

	//test 용
	String strTest = StringUtils.defaultString(request.getParameter("test"));

	String chkId   = StringUtils.defaultString(request.getParameter("chk_id"));

	JSONObject json = null;
	JSONArray jArr = new JSONArray();

	Cookie[] carr = request.getCookies();
	String strAppyn = "";
	String strVerios = "";
    String strVerand = "";
	String strAd_id = "";
	int intVerios = 0;
    int intVerand = 0;

	try {
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("appYN")){
		    	strAppyn = carr[i].getValue();
		    	break;
		    }
		}
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("verios")){
		    	strVerios = carr[i].getValue();
		    	break;
		    }
		}
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("verand")){
		    	strVerand = carr[i].getValue();
		    	//break;
		    }
		}
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("adid")){
		    	strAd_id = carr[i].getValue();
		    	break;
		    }
		}
	} catch(Exception e) {
	}


	int pointRemain = 0;
	String pointPreFix = "";
	int userTotalPoint = 0;
	int curStampNum = 0;	// 이전까지 참여한 스탬프 번호
	int nextStampNum = 0;	// 현재찍을 스탬프 번호
	boolean todayVisited = false;	// 오늘 참석 여부
	NumberFormat nf = NumberFormat.getInstance();
	// 로그인 상태이면 해당 사용자의 출석체크 정보를 가져온다.
	if(StringUtils.isEmpty(userId)){
		userId = "";
	}

	//userId = "";
	Event_201602_Every_Proc event_proc = new Event_201602_Every_Proc();
	Event_201602_Every_Visit_Data event_data = new Event_201602_Every_Visit_Data();
	json = event_proc.getEventEveryItemJson(strEventId, userId);

	userTotalPoint = json.getInt("userTotalPoint");	// 유저 총 포인트
	todayVisited = json.getBoolean("isTodayVisit");		// 오늘 방문여부
	curStampNum = json.getInt("curStampNum");			// 현재까지 출석한 순번
	jArr = json.getJSONArray("event_list");				// 출석 체크내역 목록
	nextStampNum = curStampNum +1;						// 이번에 출석할 순번


	int i_Log = 5941;
	int i_Log_pad = 0;
	if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0){
		i_Log = 5940;
	}else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0){
		i_Log = 5939;
	}else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0){
		i_Log = 5939;
		i_Log_pad = 1;
	}else{
		i_Log = 5941;
	}
	if(strVerios.length() > 0){
		strVerios = strVerios.replace(".","");
	}
	if(strVerand.length() > 0){
		strVerand = strVerand.replace(".","");
	}

	//상품정보 Bar 3.2.0 부터 사라짐 app에서만
    boolean blTopbar_show = true;
    if(strAppyn.equals("Y")){
        if(i_Log == 5940){
        	intVerand = Integer.parseInt(strVerand);
            if(intVerand >= 320){
                blTopbar_show = false;
            }
        }else if(i_Log == 5939){
        	intVerios = Integer.parseInt(strVerios);
            if(intVerios >= 32000){
                blTopbar_show = false;
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>에누리(가격비교) eNuri.com</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<meta property="og:title" content="에누리 가격비교">
<meta property="og:description" content="에누리 모바일 가격비교">
<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilenew/images/logo_enuri.png">
<meta name="format-detection" content="telephone=no" />
<link rel="stylesheet" type="text/css" href="/css/mobile_v2/common.css">
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/emoney.css">
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
</head>
<body>

<div class="wrap">
	<!-- 상단 공통영역 -->
	<!-- <section class="top" style="display:none;">
	<h1>사용가능 <span>e</span>머니</h1>
		<div class="my_e"><span><%=nf.format(userTotalPoint) %><em>점</em></span></div>
		<nav>
			<ul class="sgnb">
				<li id="saving">적립내역</li>
				<li id="store" >스토어</li>
				<li id="couponbox">쿠폰함</li>
				<li id="notice"  class="on">혜택안내</li>
			</ul>
		</nav>
	</section>
	<%if(!strAppyn.equals("Y") && !strApp.equals("Y")){%>
	    <!-- 헤더 B타입 -->
	    <header id="header" class="m_header head__type_b">
	        <div class="header_wrap">
	            <h1 class="m_txt">혜택 안내</h1>
	            <button class="btn_hd_back comm__sprite">뒤로</button>
			</div>
	    </header>
	    <!-- // 헤더 -->
    <%} %>
	<!--// 상단 공통영역 -->
	<!-- 혜택안내 -->
	<section class="benefit">
		<h1><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/reward/benefit_tit.jpg" alt="에누리에서 누리자" /></h1>

		<div class="content">
			<ul class="e_list" id="e_list">
				<li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/reward/benefit01.jpg" alt="" /></a></li>
				<li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/reward/benefit02.jpg" alt="" /></a></li>
				<li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/reward/benefit03.jpg" alt="" /></a></li>
				<li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/reward/benefit04.jpg" alt="" /></a></li>
				<li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/reward/benefit05.jpg" alt="" /></a></li>
				<li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/reward/benefit06.jpg" alt="" /></a></li>
				<li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/reward/benefit07.jpg" alt="" /></a></li>
			</ul>
		</div>
	</section>
	<!--// 혜택안내 -->
</div>

	<%//@ include file="/mobilefirst/event2016/event_footer.jsp"%>
	<%@ include file="/my/include/m_footer.jsp"%>

</body>
<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	//런칭할때 UA-52658695-3 으로 변경
	ga('create', 'UA-52658695-3', 'auto');

var vTitle = "혜택안내";
var blTopbar_show = <%=blTopbar_show%>;

// 안드로이드 헤더용...
if(window.android){
	android.getEmoneyTitle(vTitle);
}

$(function(){
	var moveEvent = [
		{ "title" : "출석체크", "url": "/mobilefirst/evt/visit_event.jsp?tab=1&freetoken=event" } ,
		{ "title" : "첫구매", "url": "/mobilefirst/evt/firstbuy_event.jsp?tab=1&freetoken=eventclone" } ,
		{ "title" : "구매_스탬프", "url": "/mobilefirst/evt/smart_benefits.jsp?tab=1&freetoken=eventclone" } ,
		{ "title" : "구매_더블적립", "url": "/mobilefirst/evt/buy_event.jsp?tab=1&freetoken=event" } ,
		{ "title" : "구매_추가적립", "url": "/mobilefirst/evt/buy_event.jsp?tab=2&freetoken=event" } ,
		{ "title" : "컴백딜", "url": "/mobilefirst/evt/birthday_event.jsp?tab=2&freetoken=eventclone" } ,
		{ "title" : "매일룰렛", "url": "/mobilefirst/evt/visit_event.jsp?tab=2&freetoken=event" }
	];

	//배너 링크 클릭
	$("ul#e_list > li").click(function(){
		var idx = $(this).index();
		ga( 'send', 'event', 'mf_emoney', '혜택안내', moveEvent[idx].title );
		location.href = moveEvent[idx].url;
	});


    //상품정보 Bar 3.2.0 부터 사라짐 app에서만
	if(blTopbar_show==false){
		$(".top").hide();
	}

	// 로그인
	$(".btn_login").on('click', function(){
		goLogin();
	});


	/**
     *	창 닫기
     */
	$(".win_close").on('click', function() {
		self.opener = self;
		window.close();
	});

    /**
     *	top 이동
     */
    $(".go_top").on('click', function(){
		$('html, body').animate({ scrollTop: 0}, 300);
    });


    // 상단 top 메뉴
	$("#topMenu > li").on('click', function(){
		var index = $(this).index(),
			url,
			logMsg = "";

		var chkId = "<%=chkId%>";

		if(index == 0){			// 앱첫구매
			logMsg = "무조건_5천점";
			url = "/mobilefirst/event/event_three.jsp?freetoken=event&chk_id="+chkId;
		}else if(index == 1){	// 페이백
			logMsg = "최대_1천만점";
			url = "/mobilefirst/event/event_allpayback.jsp?freetoken=event&chk_id="+chkId;
		}else{					// 혜택더보기
			window.location.href = "";
			logMsg = "혜택더보기";
			url = "/mobilefirst/Index.jsp?freetoken=main_tab|event";
		}

		window.location.href = url;
		ga('send', 'event', 'mf_event', 'top_menu', logMsg);

		return false;

	});

    /**
     *	e머니 상세내역으로 이동
     */
    $("#myPoint").on('click', function(){
    	window.location.href = "/mobilefirst/emoney/emoney.jsp";
    	ga('send', 'event', 'mf_event', 'top_menu', "매일출석_APP_무빙탭_개인화영역");

    });

	$("#bottomBanner").on('click', function(){
		var url = "/mobilefirst/event/event_20160201_main.jsp?freetoken=event";
    	window.location.href = url;
    	ga('send', 'event', 'mf_event', 'top_menu', "매일출석_APP_무빙탭_개인화영역");

    });

	$("#saving").click(function(){
		location.href = "/mobilefirst/emoney/emoney.jsp?freetoken=emoney";
	});

	$("#store").click(function(){
		location.href = "/mobilefirst/emoney/emoney_store.jsp?freetoken=emoney";
	});

	$("#couponbox").click(function(){
		location.href = "/mobilefirst/emoney/emoney_couponbox.jsp?freetoken=emoney";
	});

	//헤더 뒤로가기
	$(".btn_hd_back").click(function(){
		history.back(-1);
	});

});

</script>
</html>