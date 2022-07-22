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
	// 이벤트 아이디
	final String strEventId = "2016021501";
	// 유저 아이디 가져오기  
	cb = new CookieBean(request.getCookies());
	String userId = cb.GetCookie("MEM_INFO","USER_ID");
	String strApp = cb.getCookie_One("appYN");	// 앱 여부 체크
	
	//test 용
	String strTest = StringUtils.defaultString(request.getParameter("test"));
	String strPart = StringUtils.defaultString(request.getParameter("part"),"");
	String strSetpoint = StringUtils.defaultString(request.getParameter("setpoint"),"1000");
	
	String chkId   = StringUtils.defaultString(request.getParameter("chk_id"));
	
	JSONObject json = null;
	JSONArray jArr = new JSONArray();
	
	Cookie[] carr = request.getCookies();
	String strAppyn = "";
	String strVerios = "";
	String strAd_id = "";
	int intVerios = 0;
	 
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
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/default.css">
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/emoney.css?0922">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.0/themes/smoothness/jquery-ui.css">
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<video width="700" id="a_video" style="display:none;width:100%;height:100%;position:fixed;left:0;top:0;z-index:1000;background:#000000;">
	<source id="movie_src" type="video/mp4" src="cf.mp4" />
</video>
<!-- 탭 -->
	<section class="top">
		<h1>사용가능 <span>e</span>머니</h1>
		<div class="my_e"><span><%=nf.format(userTotalPoint) %><em>점</em></span></div>
		<nav>
			<ul class="sgnb five">
				<li id="saving">적립내역</li>
				<li id="store" >스토어</li>
				<li id="couponbox">쿠폰함</li>
				<li id="emoney_get"  class="on">e머니+</li>
				<li id="notice">혜택안내</li>
			</ul>
		</nav>
	</section>
<!--// 탭 -->
	<section class="shop_contents">
		<div id="set_area" style="display:none;">
			<div style="margin:15px;">처음 오셨군요.<br />설정을 하시고 완료 버튼을 누르시면 서비스를 이용하실 수 있습니다.</div>
			<ul class="setting_head">
				<li><label><input type="radio" name="setting" value="0" /> 바로 받기</label></li>
				<li>
					<label><input type="radio" name="setting" value="1" /> 누적 받기 (200% 지급)</label>
						<select name="setting_money" id="setting_money">
							<option value="">포인트 선택</option>
							<option value="300">300 p</option>
							<option value="500">500 p</option>
							<option value="1000">1000 p</option>
						</select>
				</li>
			</ul>
			<button type="button" class="all_end" name="ok_btt" onclick="btt_ok()" value="" />완료</button>
			<p class="sm">
				이용 안내<br />
				1. 바로직급 받기를 선택하시면 광고를 보시거나 광고를 클릭하시면 즉시 지급 됩니다.<br />
				2. 누적 받기를 선택하시면 누적포인트가 100% 완료 되는 시점에 자동으로 지급 됩니다.<br />
				3. 누적 받기 중간에 설정 수정은 불가하나 포인트가 지급 완료 된 시점에서는 재 설정 가능합니다.
			</p>
		</div>
		
		<div class="save_con" id="direct_area" style="display:none">
			<p><b>바로지급</b>을 선택하셨습니다.</p>
			<ul class="savingList">
				<li>
					<span class="date">2016-02-01</span>
					<strong>e머니 모으기 적립금</strong>
					<span class="point">40<em>점</em></span>
				</li>
				<li>
					<span class="date">2016-02-01</span>
					<strong>e머니 모으기 적립금</strong>
					<span class="point">10<em>점</em></span>
				</li>
				<li>
					<span class="date">2016-02-01</span>
					<strong>e머니 모으기 적립금</strong>
					<span class="point">30<em>점</em></span>
				</li>
			</ul>
		</div>
		
		<div class="save_con" id="acc_area" style="display:none">
			<p><b>누적받기(<em id="acc_point"></em>)</b>를 선택하셨습니다.</p>
			<div id="progressbar"></div>
			<div>진행률 <em id="acc_per"></em></div>
			<ul class="savingList">
				<li>
					<span class="date">2016-02-01</span>
					<strong>e머니 모으기 적립금</strong>
					<span class="point">500<em>점</em></span>
				</li>
				<li>
					<span class="date">2016-02-01</span>
					<strong>e머니 모으기 적립금</strong>
					<span class="point">300<em>점</em></span>
				</li>
				<li>
					<span class="date">2016-02-01</span>
					<strong>e머니 모으기 적립금</strong>
					<span class="point">100<em>점</em></span>
				</li>
			</ul>
		</div>
		<div id="banner_area" style="display:none;">
			<div>
				<p>동영상 광고 (5초 이상 시청 필요함)</p>
				<div style="padding:6px 6px 3px 6px">
					<a href="javascript:///" onclick="banner_click(0,50);">
						<img src="http://storage.enuri.info/banner/640100(62).jpg" border="0" width="100%">
					</a>
				</div>
				<div style="padding:6px 6px 3px 6px">
					<a href="javascript:///" onclick="banner_click(0,80);">
						<img src="http://img.enuri.com/images/mobilefirst/planlist/B_20161025033400/B_20161025033400_banner.png" border="0" width="100%">
					</a>
				</div>
				<p>배너 광고(클릭)</p>
				<div style="padding:6px 6px 3px 6px">
					<a href="javascript:///" onclick="banner_click(1,10);">
						<img src="http://storage.enuri.info/banner/640100(62).jpg" border="0" width="100%">
					</a>
				</div>
				<div style="padding:6px 6px 3px 6px">
					<a href="javascript:///" onclick="banner_click(1,20);">
						<img src="http://img.enuri.com/images/mobilefirst/planlist/B_20161025033400/B_20161025033400_banner.png" border="0" width="100%">
					</a>
				</div>
				<div style="padding:6px 6px 3px 6px">
					<a href="javascript:///" onclick="banner_click(1,5);">
						<img src="http://storage.enuri.info/Web_Storage/pic_upload/mobile/banner/foot_sw.jpg" border="0" width="100%">
					</a>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="/mobilefirst/event2016/event_footer.jsp"%>
</div>

</body>
<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	//런칭할때 UA-52658695-3 으로 변경
	ga('create', 'UA-52658695-3', 'auto');

var vTitle = "혜택안내";

// 안드로이드 헤더용...
if(window.android){
	android.getEmoneyTitle(vTitle);
}

$( "#progressbar" ).progressbar({
	  value: false
});

var vPart = "<%=strPart %>";
var vPoint = <%=strSetpoint %>;
var vNowpoint = 0;
var vPer = 0;

$(function(){

	//function movieDialog(str) {
		//선택한 버튼의 동영상 경로를 불러옴
		//$("#movie_src").attr("src", $(str).attr("value"));
		//동영상을 다시 load 함
		$("#a_video").load();
		//load한 동영상을 재생
		//
	//};

	
	// 로그인 
	$(".btn_login").on('click', function(){
		goLogin();
	});
	
	if(vPart == ""){
		$("#set_area").show();
	}else if(vPart == "acc"){	//누적받기
		$("#acc_area").show();
		$("#banner_area").show();
		$("#acc_point").text(vPoint+"p");
		$("#acc_per").text(vPer+"%");
		
		setTimeout(function(){ 
			$( "#progressbar" ).progressbar({
				  value: vNowpoint
			})
		}, 2000);	
		
	}else if(vPart == "direct"){	//즉시받기
		$("#direct_area").show();
		$("#banner_area").show();
	}
	


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
	
	$("#emoney_get").click(function(){
		location.href = "/mobilefirst/emoney/emoney_plus.jsp?freetoken=emoney";
	});
});

function btt_ok(){
	var radioButtons = $("input:radio[name='setting']:checked").val();

	if(radioButtons == "0"){
		location.href = "emoney_plus.jsp?freetoken=emoney&part=direct";
	}else if(radioButtons == "1"){
		var vSetting_money = $("#setting_money").val();
		
		if(vSetting_money == ""){
			alert("포인트를 선택하세요.");
			return false;
		}else{
			location.href = "emoney_plus.jsp?freetoken=emoney&part=acc&setpoint="+vSetting_money;
		}
	}else{
		alert("선택하세요.");
		return false;
	}
}

function banner_click(gubun, value, url){
	//window.open(url);

	if(gubun == 0){
		$("#a_video").show();
		document.getElementById("a_video").play();
	}
	
	var vDelay = 0;
	if(gubun == 0){
		if(value == 80){
			vDelay = 10000;
		}else{
			vDelay = 5000;			
		}
	}
	
	setTimeout(function(){
		document.getElementById("a_video").pause();
		$("#a_video").hide();
		if(vPart == "direct"){
			alert(value+"p 적립 되었습니다.");
			return false;
		}else if(vPart == "acc"){
			alert((value*2)+"p 누적 되었습니다.");
			
			vNowpoint = vNowpoint + (value*2);
			
			vPer = (vNowpoint * 100) / vPoint;
			
			$( "#progressbar" ).progressbar({
				  value: false
			});
			
			if(vPer > 99){
				vNowpoint = 0;
				
				setTimeout(function(){
					alert(vPoint+"p가 지급 되었습니다.");
					
					$("#acc_per").text("0%");
					$( "#progressbar" ).progressbar({
						  value: vNowpoint
					});
				}, 2000);
			}else{
				setTimeout(function(){
					
					$("#acc_per").text(vPer+"%");
					$( "#progressbar" ).progressbar({
						  value: vPer
					});
				}, 2000);
			}	
			return false;		
		}
	}, vDelay);
}

</script>
</html>