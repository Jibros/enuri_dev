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
    response.sendRedirect("/event2019/initial_quiz.jsp"); //pc url
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
}
String strEventId = "2019091902";
String tab = ChkNull.chkStr(request.getParameter("tab"));

Cookie[] carr = request.getCookies();
String strAppyn = "";
String strVerios = ChkNull.chkStr(request.getParameter("verios"));
String strVerand = ChkNull.chkStr(request.getParameter("verand"));
String appType="";
int intVerios = 0;
int intVerand = 0;

boolean isVersion=false;//버젼이 3.1.3 이상 : TRUE  미만:FALSE

try {
  for(int i=0;i<carr.length;i++){
      if(carr[i].getName().equals("appYN")){
        strAppyn = carr[i].getValue();
        break;
      }
  }
  if(strVerios.equals("")){
    for(int i=0;i<carr.length;i++){
        if(carr[i].getName().equals("verios")){
          strVerios = carr[i].getValue();
          break;
        }
    }
  }
  if(strVerand.equals("")){
    for(int i=0;i<carr.length;i++){
        if(carr[i].getName().equals("verand")){
          strVerand = carr[i].getValue();
          break;
        }
    }
  }
  
  if(strVerios.length() > 0){
	  
	  strVerios = strVerios.replace(".","");
	  strVerios = strVerios.replace("00","");
	  
	  intVerios = Integer.parseInt(strVerios.replace(".",""));
	}
	if(strVerand.length() > 0){
	  intVerand = Integer.parseInt(strVerand.replace(".",""));
	}
	
	if(strAppyn.equals("Y")){
        if(intVerand >= 355){
            isVersion = true;
        }
        if(intVerios >= 355){
            isVersion = true;
        }
	}
  
} catch(Exception e) {}

	if(strVerios.length() > 0){
		
	  strVerios = strVerios.replace(".","");
      strVerios = strVerios.replace("00","");
      
	  intVerios = Integer.parseInt(strVerios.replace(".",""));
	}
	if(strVerand.length() > 0){
	  intVerand = Integer.parseInt(strVerand.replace(".",""));
	}
	
	if(strAppyn.equals("Y")){
        if(intVerand >= 355){
            isVersion = true;
        }
        if(intVerios >= 355){
            isVersion = true;
        }
	}
	
	String strGno     = ChkNull.chkStr(cb.GetCookie("GATEP","GNO"),"");
	String strGkind     = ChkNull.chkStr(cb.GetCookie("GATEP","GKIND"),"");
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<title>에누리(가격비교) eNuri.com</title>
<meta property="og:title" content="에누리 가격비교">
<meta property="og:description" content="에누리 모바일 가격비교">
<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/event/2019/initial_quiz/sns.jpg">
<meta name="format-detection" content="telephone=no" />
<link rel="stylesheet" href="/css/event/y2019/initial_quiz_m.css" type="text/css">
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

var vChkId  = "";

var gkind = '<%=strGkind%>'+'';
var gno = '<%=strGno%>'+'';


</script>
<div id="eventWrap">
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>
	
	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">
		
		<!-- 상단비주얼 -->		
		<div class="visual">
			<div class="bg_area">
				<span class="bg_obj_01"></span>
				<span class="bg_obj_02"></span>
			</div>
			<div class="inner">
				<h2>
					<span class="txt_01">CRAZY</span>
					<span class="txt_02">초성퀴즈</span>
					</span>
				</h2>
				<span class="txt_03"></span>
			</div>
			<!-- SNS공유하기 -->
			<div class="sns">
				<span class="sns_share evt_ico" onclick="onoff('snslayer')">sns 공유하기</span>
				<ul id="snslayer" style="display:none;">
					<li>페이스북</li>
					<li>카카오톡</li>
				</ul>
			</div>
			<!-- // -->
			<script>
				// 상단 타이틀 등장모션
				$(window).load(function(){
					var $visual = $(".toparea .visual");
					$visual.addClass("intro");
					setTimeout(function(){
						$visual.addClass("end");
					},1500)
				})
			</script>
		</div>
	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<!-- 이벤트01 -->
	<div id="evt1" class="section event_01 scroll"><!-- 이벤트 1 앵커 영역 -->
		<div class="evt_box">
			<div class="quiz_box">
				<h3>본격 리얼 쇼핑 버라이어티쇼 에누리TV <strong>새로운 컨텐츠는 언제 볼 수 있을까요?</strong></h3>
				<div class="quiz_con">
					<div class="inp_area">
						<%if( "Y".equals( strAppyn )  ) { %>
						<input type="text" name="text5" id="text5"  placeholder="정답 5글자를 입력하세요">
						<%}else{ %>
						<input type="text" name="text5" id="text5"  placeholder="에누리 APP에서 참여해주세요.">
						<%} %>
					</div>
					<!-- 앱 아닐때 -->
					<!-- <button class="btn_apply" onclick="onoff('app_only');">정답 맞히고 e머니 받기</button> -->
					<!-- 결과레이어 - 정답 -->
					<%if( "Y".equals( strAppyn )  ) { %>
					<button class="btn_apply">정답 맞히고 e머니 받기</button>
					<%}else{ %>
					<button class="btn_apply">APP에서 참여하기</button>
					<%} %>
					<!-- 결과레이어 - 오답 -->
					<!-- <button class="btn_apply" onclick="onoff('result_pop2');">정답 맞히고 e머니 받기</button> -->
				</div>
			</div>
			<div class="quiz_box_02">
				<h3>참여만해도 100% e머니 즉시당첨</h3>
				<div class="quiz_gift">
					<ul class="blind">
						<li>에어팟 2세대</li>
						<li>e머니 (e머니 랜덤지급)</li>
					</ul>
				</div>
				<ul class="quiz_noti">
					<li>이벤트기간 : 2019년 10월 29일 ~ 11월 30일</li>
					<li class="point">※ 선착순 e머니 경품 소진시 이벤트는 자동종료됩니다.</li>
					<li>참여방법 : APP > 초성퀴즈 페이지 접속후 퀴즈참여</li>
					<li>에어팟 당첨자발표 : 2019년 12월 24일 화요일 <br/><em>[ 에누리 앱 > 이벤트/기획전 > 이벤트 하단 당첨자발표 ]</em></li>
					<li>사정에 따라 경품이 변경될 수 있습니다.</li>
					<li>에어팟 경품 당첨시 제세공과금은 당첨자 부담입니다.</li>
					<li>잘못된 정보입력으로 인한 경품수령 불이익은 책임지지 않습니다.</li>
					<li class="point">※ 회원정보에 기입된 연락처가 맞는지 반드시 확인부탁드립니다.</li>
				</ul>
			</div>
		</div>
		<div class="btn_box">
			<a class="btn_notice" href="javascript:///" onclick="$(this).parent().toggleClass('box_on');return false;">꼭 확인하세요!</a>
		</div>
		<div class="evt_notice">
			<div class="inner">
				<p class="tit tip">이벤트 참여 방법</p>					
				<ul>
					<li>CRAZY 초성퀴즈는 APP전용 코너이므로 에누리APP을 설치해주세요.</li>
					<li>본인인증 완료된 에누리ID로만 참여가 가능합니다.</li>
					<li>프로모션 진행기간 내 ID당 1회만 참여가능합니다.</li>
				</ul>
				<p class="tit">이벤트 기간</p>
				<ul>
					<li>2019년 10월 29일 ~ 11월 30일</li>
					<li class="point">※ 선착순 e머니 경품 소진시 이벤트는 자동종료됩니다.</li>
				</ul>
				<p class="tit">경품</p>					
				<ul>
					<li>에어팟 2세대 유선충전(실물경품) - 3명 추첨  </li>
					<li class="point">※제세공과금 당첨자 부담</li>
					<li>e머니 50점, 300점, 1,000점, 10,000점 – 2,500명 선착순 지급 (금액 랜덤 지급) </li>
				</ul>
				<p class="tit">e머니 유효기간 : <em>적립일로부터 15일</em></p>
				<ul>
					<li>사정에 따라 경품이 변경될 수 있습니다.</li>
					<li>적립된 e머니는 e머니 스토어에서 다양한 e쿠폰상품으로 교환 가능합니다. </li>
				</ul>
				<p class="tit">실물경품 당첨자 발표</p>
				<ul>
					<li>2019년 12월 24일 <br/><em>[APP 이벤트/기획전 탭 > 이벤트 하단 당첨자 발표]</em></li>
				</ul>
				<p class="tit">유의사항</p>
				<ul>
					<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
				</ul>	
			</div>
		</div>
	</div>
	<!-- // 이벤트01 -->

	<!-- 이벤트02 -->
	<div id="evt2" class="section event_02 scroll"> <!-- 이벤트 2 앵커 영역 -->
		<h3>Hint 크레이지 꿀팁</h3>
		<div class="evt_box">
			<div class="enuri_tv">
				<span class="blind">에누리TV</span>
			</div>
			<h4>에누리 지식 게시판에서도 정답 힌트를 찾아보세요!</h4>
			<div class="swiper-wrap">
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<img src="http://img.enuri.info/images/event/2019/initial_quiz/m_tip_slide_01.jpg" alt="">
						</div>
						<div class="swiper-slide">
							<img src="http://img.enuri.info/images/event/2019/initial_quiz/m_tip_slide_02.jpg" alt="">
						</div>
						<div class="swiper-slide">
							<img src="http://img.enuri.info/images/event/2019/initial_quiz/m_tip_slide_03.jpg" alt="">
						</div>
						<div class="swiper-slide">
							<img src="http://img.enuri.info/images/event/2019/initial_quiz/m_tip_slide_04.jpg" alt="">
						</div>
					</div>
				</div>
				<div class="swiper-pagination"></div>
				<%if( "Y".equals( strAppyn )  ) { %>				
				<a href="javascript:///" class="btn_knowcom">쇼핑지식 바로가기</a>
				<%} %>
				<script>
					$(function(){
						var mySlide = new Swiper('.event_02 .swiper-container',{
							speed : 1000,
							autoplay : 4000,
							autoplayDisableOnInteraction : false,
							loop : false,
							pagination : '.event_02 .swiper-pagination',
							paginationClickable : true
						})
					})
				</script>
			</div>
		</div>
	</div>
	
	<!-- //Contents -->	
	<span class="go_top"><a href="javascript:///">TOP</a></span>

</div>

<!-- 레이어 - 축하합니다 -->
<div class="layer_back" id="result_pop1" style="display:none;">
	<div class="lay_result lay_result_01">
		<p class="blind">축하합니다. 퀴즈 정답을 정확히 맞히셨어요!</p>
		<!-- 당첨 E머니 -->
		<span class="comm">
			e머니 <em id="nowPoint"></em>점이 적립되었습니다.
		</span>
		<!-- 버튼 : 확인 -->
		<button class="btn_confirm" onclick="$(this).closest('.layer_back').hide();">확인</button>
		<!-- 버튼 : 닫기 -->
		<a href="javascript:///" class="btn_close" onclick="$(this).closest('.layer_back').hide();">창닫기</a>
	</div>
</div>
<!-- // -->

<!-- 레이어 - 오답입니다 -->
<div class="layer_back" id="result_pop2" style="display:none;">
	<div class="lay_result lay_result_02">
		<p class="blind">오답입니다. 다시한번 정답에 도전</p>
		<!-- 버튼 : 확인 -->
		<button class="btn_confirm" onclick="$(this).closest('.layer_back').hide();">확인</button>
		<!-- 버튼 : 닫기 -->
		<a href="javascript:///" class="btn_close" onclick="$(this).closest('.layer_back').hide();">창닫기</a>
	</div>
</div>
<!-- // -->
	
	
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

var event_id = "<%=strEventId%>";

var vEvent_title = "크레이지초성퀴즈";
var vEvent_page = "";

Kakao.init('5cad223fb57213402d8f90de1aa27301');

//공통영역//
(function(){
	
	if(app == "Y"){
		$(".visual > .inner").css("background","none");	
	}
	ga('send', 'pageview', {'title': vEvent_title + " > " + "PV"});
	
	//닫기버튼
	 $( ".win_close" ).click(function(){
        if(app == 'Y')  window.location.href = "close://";
        else            window.location.replace("/mobilefirst/index.jsp");
	});
	
	$(".go_top").click(function(){		$(window).scrollTop(0);	});

	if(islogin())		getPoint();
	
	$(".btn_apply").click(function(){
		
		GA("참여하기");
		
		if(app != 'Y'){
			$("#app_only").show();
			 
			if(gkind == "63" && gno == "5070638"){
				GA("모비팝_초성퀴즈APP참여하기");
	    		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=8820367';
	    	}
			
			return false;
		}
		
		if(islogin()){
			
			var text5 = $("#text5").val();
			
			if(text5.length == 0){
				alert("정답을 입력하세요");
			
			}else if(text5.length > 0 && text5.length < 5){
				alert("정답은 5글자입니다.\n글자수를 확인해주세요!");
			}else{
				
				$.ajax({
			 		type: "GET",
			 		url: "/mobilefirst/evt/ajax/fquiz2019_setlist.jsp?procCode=1&ans="+text5+"&osType="+getOsType(),
			 		dataType: "JSON",
			 		success: function(json){
			 			
			 			if(json.result >= 50){
			 				
			 				$("#result_pop1").show();
			 				$("#nowPoint").text(json.result);
			 				
			 			}else if(json.result == -1){
			 				alert("응모완료 되었습니다.");
			 			}else if(json.result == -9){
			 				$("#result_pop2").show();
			 			}else if(json.result == -2){
			 				alert("임직원은 참여 불가 합니다.");
			 			}else if(json.result == -3){
			 				alert("이벤트 종료되었습니다.");
			 			}else if(json.result == -6){
			 				
			 				var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
							   if(r){
								   location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
							   }
			 				
			 			}
			 		}
			 	});
				
			}
			
		}else{
			alert("로그인 후 참여가능합니다.");
			location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
			return false;
		}
	});
	
	$(".btn_knowcom").click(function(){
		GA("쇼핑지식 바로가기");
		location.href = "/knowcom/index.jsp";
	});
	
	$("#snslayer li").click(function(){
		var shareUrl = "http://" + location.host + "/mobilefirst/event2019/fquiz_evt.jsp";
		var shareTitle = "[에누리 가격비교]\nCRAZY 초성퀴즈";
		var idx = $(this).index();
		
		GA("sns공유하기");
		
		if(idx == 1) {
			 try{ 
				
				Kakao.Link.sendDefault({
				      objectType: 'feed',
				      content: {
				        title: shareTitle,
				        description: "퀴즈만 풀어도 100% e머니 당첨 추첨을 통해 에어팟 행운까지",
				        imageUrl: "http://http://imgenuri.enuri.gscdn.com/images/event/2019/initial_quiz/sns.jpg",
				        link: {
				          mobileWebUrl: shareUrl,
				          webUrl: shareUrl
				        }
				      }
				    });
				
			}catch(e){
				alert("카카오 톡이 설치 되지 않았습니다.");
				alert(e.message);
			}
		} else {
			window.open("http://www.facebook.com/sharer.php?u=" + shareUrl);
		}
	});
	
})();

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
setTimeout(function(){
	welcomeGa("evt_fquiz_view");    
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
</script>
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</body>
</html>