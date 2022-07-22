<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
String strFb_title = "[에누리 가격비교] CRAZY 프라이데이";
String strFb_description = "매주 금요일 오후 2시, 크레이지 파격특가";
String strFb_img = ConfigManager.IMG_ENURI_COM+"/images/mobilefirst/deal/logo/sns_1200_630.jpg";
String flow = ChkNull.chkStr(request.getParameter("flow"));

if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
	String redirectUrl = "/evt/crazy_Friday.jsp";
	if(!"".equals(flow)) {
		redirectUrl += "?flow=" + flow;
	}
    response.sendRedirect(redirectUrl);
    return;
}
String chkId   = ChkNull.chkStr(request.getParameter("chk_id"),"");
String cUserId = cb.GetCookie("MEM_INFO","USER_ID");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

Members_Proc members_proc = new Members_Proc();
String cUsername = members_proc.getUserName(cUserId);
String userArea = cUsername;

long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String sdt =dayTime.format(new Date(cTime));//진짜시간

dayTime = new SimpleDateFormat("yyyyMMddHHmmss");
String todayAtMidn = dayTime.format(new Date(cTime));

//test
if( request.getServerName().equals("dev.enuri.com") &&  request.getParameter("sdt")!=null && !"".equals(request.getParameter("sdt"))){
	sdt= request.getParameter("sdt");
} 

String strUrl = request.getRequestURI();

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;

    if(cUsername.equals(""))	userArea = cUserNick;
    if(userArea.equals(""))		userArea = cUserId;
}

String strEventId = "2019071701";

String appYN = ChkNull.chkStr(request.getParameter("app"),"");
if(appYN.equals("")){
	appYN = ChkNull.chkStr(cb.getCookie_One("appYN"));	
}

String snsUserYN = "";

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;

    if(cUsername.equals(""))	userArea = cUserNick;
    if(userArea.equals(""))		userArea = cUserId;
    
    String snsType = ChkNull.chkStr(cb.GetCookie("MEM_INFO","SNSTYPE"));
	if( "K".equals(snsType) ||  "N".equals(snsType) ){//sns 계정일 경우 닉네임을 넣어준다
		snsUserYN = "Y";
	}else{
		snsUserYN = "N";
	}
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
<link rel="stylesheet" href="/css/event/y2019/crazy_friday_m.css" type="text/css">
<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/common/js/paging_workers2.js"></script>
<script type="text/javascript" src="/mobilefirst/js/event_regular.js?v=20180201"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<script type="text/javascript" src="/event2016/js/event_common.js"></script>
<script src="/mobilefirst/js/lib/clipboard.min.js"></script>
</head>
<body>
<div id="eventWrap">
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>
	<!-- 플로팅 배너 :: 오픈시 빼고 노출 -->
	<div class="floating_bnr" style="display:none">
		<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2019/crazyFriday/fl_bnr.png" alt="매일 오전 10시 매일 한정특가">
		<a href="javascript:///" onclick="$('.floating_bnr').hide();return false;" class="btn_close">닫기</a>
	</div>
	<!-- //  플로팅 배너 -->

	<!-- 비쥬얼,플로팅탭 -->
	<div class="toparea">

		<!-- CrazyDeal + Friday Gnb -->
		<div class="evt_gnb">
			<ul id="evtTab">
				<li class="on"><a href="javascript:///" class="nav_friday">CRAZY <em>프라이데이</em></a></li>
				<li><a href="javascript:///" class="nav_deal">매일 오전 10시, <em>CRAZY딜</em></a></li>
			</ul>
		</div>
		<!-- // CrazyDeal + Friday Gnb -->		
		
		<!-- 상단비주얼 -->		
		<div class="visual">
			<div class="sns">
				<span class="sns_share evt_ico" onclick="dealGA('SNS공유'); onoff('snslayer');">sns 공유하기</span>
				<ul id="snslayer" style="display:none;">
					<li onclick="event_share('face');">페이스북</li>
					<li id="kakao-link-btn" onclick="event_share('kakao');"  >카카오톡</li>
				</ul>
			</div>
			<!-- 앱 일때 아래 span.txt_app 제거해 주세요. -->
			<%if( "Y".equals(appYN) ){ %>
			<%}else{ %>
			<span class="txt_app">APP 전용</span>
			<%} %>
			<!-- // -->
			<div class="inner">
				<h2>
					<span class="top_tit_01">CRAZY</span><span class="top_tit_02">프라이데이</span>
				</h2>
				<span class="top_txt_01"><span class="txt_inner">매주 금요일 오후 2시, 크레이지 파격특가</span></span>
			</div>
			<script>
				// 상단 타이틀 등장모션
				$(window).load(function(){
					var $visual = $(".toparea .visual");
					$visual.addClass("intro");
					setTimeout(function(){	$visual.addClass("end");	},1500);
				});
			</script>
		</div>
	</div>
	<!-- //비쥬얼,플로팅탭 -->

	<!-- 이벤트01 -->
	<div id="evt1" class="section event_01 scroll"><!-- 이벤트 1 앵커 영역 -->
		<div class="evt_box">
			<div class="inner">
				<div class="deal_slide"></div>
			</div>
		</div>
		<div class="btn_box">
			<a class="btn_notice" href="javascript:///" onclick="$(this).parent().toggleClass('box_on');return false;">구매Tip &amp; 유의사항</a>
		</div>
		<div class="evt_notice">
			<div class="inner">
				<p class="tit tip">구매 Tip ( 구매전 반드시 확인하세요! )</p>
				<ul>	
					<li>	-Crazy 프라이데이는 APP전용 코너이므로 에누리 APP을 설치해주세요</li>
					<li>	-본인인증 완료 된 에누리 ID로만 참여가 가능합니다.</li>
					<li>	-상품결제는 인터파크에서 이루어지며 인터파크 ID가 필요합니다.</li> 
				</ul>
				<p class="tit">유의사항</p>
				<ul>
					<li>	- 부정한 방법으로 상품 구매 시 주문이 취소될 수 있습니다.</li>
					<li>	- CRAZY 프라이데이는 선착순 한정수량 판매로 결제 진행 중 상품이 품절될 경우 판매가 종료될 수 있습니다.</li>
					<li>	- 모바일 APP 이 외 다른 환경에서 구매시도하여 발생되는 문제에 대해서는 책임 및 보상이 이루어지지 않습니다. </li> 
					<li>	- CRAZY 프라이데이 상품의 주문/배송/환불/보증 관련 책임은 해당 쇼핑몰의 판매자에게 있습니다.</li>
					<li>	- 9/13일(금)은 추석명절연휴로 인하여 진행하지 않고, 1주뒤인 9/20일(금)부터 정상진행합니다.</li>
					<li>	- 본 이벤트는 당사에 사정에 따라 사전고지 없이 변경 또는 조기종료 될 수 있습니다.</li>
				</ul>
			</div>
		</div>
	</div>
	<!-- // 이벤트01 -->

	<!-- 이벤트02 -->
	<div id="evt2" class="section event_02 scroll"> <!-- 이벤트 2 앵커 영역 -->
		<div class="head">
			<h3>매주 금요일 파격특가</h3>
			<span class="txt_sub">판매예정 상품을 미리 확인하세요!</span>
		</div>
		<div class="inner">
			<ul id="dealist"></ul>
		</div>
	</div>

	<!-- 이벤트3 -->
	<div id="evt3" class="section event_03 scroll">
		<div class="head">
			<h3><span class="txt_crazy"><span class="blind">CRAZY</span> 보너스 이벤트</span></h3>
			<span class="txt_sub">SNS에 상품을 공유하고 댓글을 남기시면<br/>추첨을 통해 선물을 드립니다.</span>
		</div>
		<div class="inner"  id="bounsEvt" ></div>
		<div class="btn_box">
			<a class="btn_notice" href="javascript:///" onclick="$(this).parent().toggleClass('box_on');return false;">꼭 확인하세요!</a>
		</div>
		<div class="evt_notice">
			<div class="inner">
				<p class="tit">이벤트 참여방법</p>
				<ul>
					<li>-  SNS로 이번주 CRAZY 프라이데이 상품 공유하기 </li>
					<li>-  공유한 SNS 링크를 댓글로 남기기! (카카오톡으로 공유한 경우 ‘공유완료!’ 댓글만 남겨도 OK!)</li>
					<li>-  SNS 공유와 댓글 모두 참여할 경우에만 이벤트 응모로 집계되며, 둘 중 하나만 참여할 경우에는 당첨시 제외됩니다.</li>
					<li>-  SNS 공유는 횟수 제한없이 참여 가능하며, 댓글은 1일 1회 참여 가능합니다.</li>
				</ul>
				<p class="tit">경품</p>
				<ul>
					<li>-  e쿠폰으로 교환 가능한 e머니로 적립되며, e쿠폰 스토어에서 교환 가능합니다.</li>
					<li>-  경품은 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격변동 있을 수 있습니다.</li>
				</ul>
				<p class="tit">당첨자 발표 및 경품지급일</p>
				<ul>
					<li>-  당첨자발표 : 2019년 10월 7일 월요일 [APP 이벤트/기획전 탭 > 이벤트 하단 당첨자 발표]</li>
					<li>-  e머니 적립 후 App Push 메시지 발송 <br/>(Push 알림 미동의자 제외) </li>
					<li>-  e머니 유효기간 : 적립일로부터 15일</li>
				</ul>
				<p class="tit">유의사항</p>
				<ul>
					<li>-  부정 참여 시 적립이 취소될 수 있습니다.</li>
					<li>-  본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
				</ul>
			</div>
		</div>
	</div>
	
	<!-- 이벤트04 -->
	<div class="section event_04 scroll">				
		<div class="head">
			<h3><strong>CRAZY FRIDAY</strong> 상품 공유 후 댓글남기면<br/>추첨을 통해 선물을 드립니다.</h3>
			<div class="prizes" id="replyEvt" >
			</div>
		</div>
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
				-->
				<%if(cUserId.equals("")){%>
				<div class="input logout">
					<textarea class="txt_area" placeholder="글을 입력해 주세요."></textarea>
					<!--
						로그인 전, placeholder="글을 입력해 주세요."
						로그인 후, placeholder="이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다."
					-->
					<button class="btn regist stripe" onclick="insertReplayMsg();" >등록하기</button>
				</div>
				<%}else{ %>
				<!-- 로그인 후 -->
				<div class="input login">
					<textarea id="replyMsg"   class="txt_area" maxlength="150"  placeholder="이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다."></textarea>
					<button id="" class="btn regist stripe" onclick="insertReplayMsg();" >등록하기</button>
				</div>
				<%} %>
			</div>
			
			<div class="view_area">
				<ul id="body_list"></ul>
			</div>
			<div class="paging" id="paginate"></div>
		</div>
		<!-- // 게시판 -->
	</div>
	<!-- //Contents -->	
	<span class="go_top"><a onclick="$(window).scrollTop(0);">TOP</a></span>
</div>
<!-- layer--> 
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();" >설치하기</button></p>
	</div>
</div>
<!-- 공유하기 -->
<div class="layer_back" style="position: fixed; height: 100%;display:none" id="popShare">
	<div class="noteLayer popshare">
		<div class="inner">
			<h3 class="tit share_sprite">친구에게 공유하기!</h3>
			<div class="cont">
				<ul class="list_share">
					<li>
						<a href="javascript:///" class="icon_share icon_fb"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2017/crazydeal/micon_share_fb.jpg" alt="페이스북 공유하기"></a>
					</li>
					<li>
						<a href="javascript:///" class="icon_share icon_kt"  id = "kakao-link-btn2" ><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2017/crazydeal/micon_share_kt.jpg" alt="카카오톡 공유하기"></a>
					</li>
					<li>
						<a href="javascript:///" class="icon_share icon_uc"  data-clipboard-text = "http://m.enuri.com/mobilefirst/evt/crazy_Friday.jsp?flow=share"   ><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2017/crazydeal/micon_share_uc.jpg" alt="URL 복사"></a>
					</li>
				</ul>
				<div class="btn_area">
					<a class="btn share_sprite" href="javascript:///" onclick="$('#popShare').hide();">닫기</a>
				</div>
			</div>
			<!-- //popup_box -->
			
			<a href="javascript:///" class="btn_close sprite" onclick="$('#popShare').hide();">창닫기</a>
		</div>
	</div>
</div>
<%@ include file="/mobilefirst/include/inc_ctu.jsp"%>
<!-- // 공유하기 -->
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script type="text/javascript">
var default_src = "<%=ConfigManager.STORAGE_ENURI_COM%>";
var app = getCookie("appYN"); //app인지 여부
var totalcnt = 0;

var event_id = "<%=strEventId%>";

var PAGENO = 1;
var PAGESIZE = 5;
var BLOCKSIZE = 5;

var username = "<%=userArea%>";
var vChkId = "<%=chkId %>";

var jsonData;

(function (global, $) {
	
	dealGA('PV');
	
	if(app == "Y"){
		$(".txt_app").hide();
	}
	
	//스크롤
	var nav = $('.myarea'); 
	$(window).scroll(function () {
		if ($(this).scrollTop() > $(".event_02").offset().top) {
			nav.addClass("f-nav");
		} else {
			nav.removeClass("f-nav");
		}
	});
	getDealList();
	goPage(1);
	getBounsEvt();
	
	if(islogin()){
		getPoint();
	}
	
	$("a.btn_viewp.sprite").click(function(e){
		window.open("/mobilefirst/detail.jsp?modelno=" + data.GD_MODEL_NO);
	});
	
	$("#evtTab > li > a").click(function(){
		
		var attr = $(this).attr("class");
		if(attr == "nav_deal"){
			
			dealGA('상단_크레이지딜');
			
			window.open("/mobilefirst/evt/mobile_deal.jsp");
			return false;
		}else{
			dealGA('상단_프라이데이');			
		}
	});
	
	//닫기버튼
	$( ".win_close" ).click(function(){
		if(app == 'Y')		window.location.href = "close://";
		else				window.location.replace("/mobilefirst/index.jsp");
	});
	
	var shareUrl = "http://" + location.host + "/mobilefirst/evt/crazy_Friday.jsp?flow=share";
	// 페이스북, 카카오톡 공유
	$(".list_share li").click(function(){
		var idx = $(this).index();
		switch(idx) {
			case 0 :
				window.open("http://www.facebook.com/sharer.php?u=" + shareUrl);
				shareInsert(idx+1);
				break;
			case 1 :
				try{
					Kakao.Link.createDefaultButton({
						container: '#kakao-link-btn2',
						objectType: 'feed',
						content: {
							title: jsonData.SHARE_TL + "\n" + jsonData.SHARE_DS,
							imageUrl: default_src + jsonData.GD_IMG_URL,
							link: {
								mobileWebUrl: shareUrl,
								webUrl: shareUrl
							}
						},
						buttons: [
							{
								title: '에누리 가격비교 열기',
								link: {
									mobileWebUrl: shareUrl,
									webUrl: shareUrl
								}
							}
						]
					});
					shareInsert(idx+1);
				}catch(e){
					//alert("카카오 톡이 설치 되지 않았습니다.");
					alert(e.message);
				}
				break;
		}
	});

	//댓글 글자수 카운팅
	$(".txt_area").keyup(function() {
		$("#word_num").text($(this).val().length);
		if ($("#replyMsg").val().length >= 150) {
			alert("150자 이내로 작성해주세요!");
			return false;
		}
	});//url 복사
	
	//url 복사
	var clipboard = new ClipboardJS('.icon_share.icon_uc');
	clipboard.on('success', function(e) {
		alert("복사가 완료되었습니다!");
		shareInsert(3);
 	}).on('error', function(e) {
		prompt("아래의 URL을 길게 누르면 복사할 수 있습니다.", shareUrl);
		shareInsert(3);
 	});
	
}(window, window.jQuery));

function shareInsert(param) {
	//shareEvtCall({procCode:3, shareType : param , osType : getOsType()}, function(data){});
	
	$.ajax({
		type: "GET",
		url: "/mobilefirst/evt/ajax/crazyFriday_shareEvt_proc.jsp",
		data: "shareType="+param+"&osType="+getOsType(),
		dataType: "JSON",
		success: function(json){
			
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert("잘못된 접근입니다.");

		}
	});
	
}

//페이지 이동
function goPage(pageno) {
	getEventList(pageno, PAGESIZE);
}
function getEventList(varPageNo, varPageSize) {
	$.ajax({
		type: "GET",
		url: "/mobilefirst/evt/ajax/crazydeal_shareEvt_proc.jsp",
		data: "p=office&pageno="+varPageNo+"&pagesize="+varPageSize+"&event_id="+event_id+"&del_yn=N&procCode=2",
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
					//var reply_msg = XSSfilter(json.eventlist[i].reply_msg);

					template += "<li>";
					template += "  <p class='user'>" + user_id + " <span class='date'>" + year +"-"+ month +"-"+ day + "</span></p>   ";
					template += "  <p class='cont'>비밀댓글 입니다.</p>	";
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
//등록하기
function insertReplayMsg() {
	
	ga('send','event', 'mf_event','19년 앱개편프로모션','댓글_등록하기');
	
	if(!islogin()){
		alert("로그인 후 참여 하실 수 있습니다.");
		goLogin();
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
        	 }else if(result.result == -99){
        		 alert("임직원은 참여할 수 없습니다"); 
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


function event_share(part) {
	var shareUrl = "http://" + location.host + "/mobilefirst/evt/crazy_Friday.jsp";
	var shareTitle = "[에누리 가격비교] CRAZY 프라이데이 매주 금요일 오후2시! 크레이지한 파격특가가 찾아온다. 지금 바로 참여하세요!";
	
	if(part == 'kakao') {
		
		//dealGA('SNS 공유 > 카카오톡');
		try{
			Kakao.Link.createDefaultButton({
				container: '#kakao-link-btn',
				objectType: 'feed',
				content: {
					title: shareTitle,
					imageUrl: '<%=strFb_img%>',
					link: {
						mobileWebUrl: shareUrl,
						webUrl: shareUrl
					}
				},buttons: [{
					title: '에누리 가격비교 열기',
					link: {
						mobileWebUrl: shareUrl,
						webUrl: shareUrl
					}
				}]
			});
		}catch(e){
			//alert("카카오 톡이 설치 되지 않았습니다.");
			alert(e.message);
		}
	} else if (part == 'face') {
		dealGA('SNS 공유 > 페이스북');
		window.open("http://www.facebook.com/sharer.php?u=" + shareUrl);
	}
}


function getDealList(){
	
	var frontIdx = 0;
	var dealArr = new Array();
	
	var todayDeal = {"SEQ":"", "GOODS_COMPANY":""};
	
	$.ajax({
    	type: "GET",
        url: "/mobilefirst/http/json/friday_deal.json",
        dataType: "JSON",
        success: function(json){
        	dealJson = json;
        	var deal_tmpl = "";
        	var s_deal_tmpl = "";
        	var i=0;
        	var obj;
        	var todayAtMidn = parseInt("<%=todayAtMidn%>");
			var realIdx = 0;
			
        	if(json){
        		
        		var smallRemainTime = 10000000000000;
				var sdt = parseInt("<%=sdt%>");
				var term = 0;
				var idx = 0;      
				//첫번째로 표시할 상품 셋팅
				for(i=0; i<json.length;i++){
					obj=json[i];
					//노출되는 상품만 체크
					if(todayAtMidn >= obj.GOODS_ST_EXPODATE_DIF && todayAtMidn <= obj.GOODS_END_EXPODATE_DIF && obj.GOODS_EXPO_FLAG == "Y"){
						//판매기간 내 있고 구매가 가능한 상품
 						if(todayAtMidn >= obj.GOODS_ST_SELLDATE_DIF && todayAtMidn <= obj.GOODS_END_SELLDATE_DIF && obj.GOODS_EXPO_FLAG == "Y"
 								&& (("Y" != obj.GOODS_SOLD_FLAG && "1"==obj.GOODS_URL_TYPE)  || ("Y" != obj.EVENT_SOLDOUT_YN && "2"==obj.GOODS_URL_TYPE && "" != obj.EVENT_NO))){
	 						frontIdx = idx;
							realIdx = i;
							break;
						}
						//구매가능상태가 아닌 상품(판매기간이 지났거나 솔드아웃)
						else {
							term = parseInt(obj.GOODS_ST_SELLDATE_DIF) - todayAtMidn; 
							//솔드아웃이 아닌것 즉, 판매예정상품들
		        			if( term >= 0 && (("Y" != obj.GOODS_SOLD_FLAG && "1"==obj.GOODS_URL_TYPE) || ("Y" != obj.EVENT_SOLDOUT_YN && "2"==obj.GOODS_URL_TYPE && "" != obj.EVENT_NO) )){
		        				if( term < smallRemainTime){
		        					smallRemainTime = term;
		        					frontIdx= idx;
		        					realIdx = i;
		        				}
		        			}
	        			}
						idx++;
					}
        		}
        		
				for(i=0; i<json.length;i++){
        			obj=json[i];
        			
        			//지금시간이 게시 시작 날짜보다 크고 / 게시 종료 날짜보다 작으며 / 노출여부플래그가 Y 이면
        	    	if((todayAtMidn > obj.GOODS_ST_EXPODATE_DIF) && (todayAtMidn < obj.GOODS_END_EXPODATE_DIF) && (obj.GOODS_EXPO_FLAG == "Y")){
        	    		
        	    		var dealHtml = "";
        				dealHtml += "<div class=\"deal_item\">";
        				dealHtml += "	<div class=\"deal_tit\">";
        				
        				var sellmm =  obj.GOODS_ST_SELLDATE_DIF.substring(4,6);
        				var selldd = obj.GOODS_ST_SELLDATE_DIF.substring(6,8);
        				
        				dealHtml += "		<span calss=\"deal_date\">"+sellmm+"월"+selldd+"일</span> CRAZY 프라이데이";
        				dealHtml += "	</div>";
        				dealHtml += "	<div class=\"deal_img\">";
        				
        				if((todayAtMidn > obj.GOODS_END_SELLDATE_DIF || obj.GOODS_SOLD_FLAG=="Y") && obj.GOODS_URL_TYPE=="1"){
        					dealHtml += "<span class=\"tag_soldout\" >SOLDOUT</span>";
		        		}else if((todayAtMidn > obj.GOODS_END_SELLDATE_DIF || obj.EVENT_SOLDOUT_YN=="Y") && (obj.GOODS_URL_TYPE=="2" && "" != obj.EVENT_NO)){
		        			dealHtml += "<span class=\"tag_soldout\" >SOLDOUT</span>";
		        		}
        				
        				dealHtml += "		<span class=\"tag_open_2pm\" style=\"display:none\">OPEN 오후 2시</span>";
        				dealHtml += "		<span class=\"tag_sale\">";
        				dealHtml += "			<span class=\"txt_rate\">"+obj.GOODS_SALE_PER+"</span>%";
        				dealHtml += "		</span>";
        				dealHtml += "		<img src='"+default_src + obj.GOODS_BIG_IMG+"' alt=\"딜 이미지\">";
        				dealHtml += "	</div>";
        				dealHtml += "	<div class=\"deal_info\">";
        				dealHtml += "		<span class=\"txt_limit\">"+obj.GOODS_QUANTITY+"개 한정판매</span>";
        				dealHtml += "		<span class=\"txt_goods\">"+obj.GOODS_NAME+"</span>";
        				dealHtml += "		<span class=\"txt_price\">";
        				dealHtml += "			<del class=\"txt_orgin_price\">"+commaNum(obj.GOODS_PRICE)+"원</del><span class=\"txt_sale_price\"><strong>"+commaNum(obj.GOODS_SALE_PRICE)+"</strong>원</span>";
        				dealHtml += "		</span>";
        				dealHtml += "	</div>";
        				dealHtml += "	<div class=\"btn_deal\">";
        				//dealHtml += "		<a href=\"javascript:///\" class=\"btn_view_info\">상품보기</a>";
        				//dealHtml += "		<a href=\"javascript:///\" onclick=\"return false\" id='soon_"++"' class=\"btn_ready\">오픈예정</a>";
        				
        				if(obj.GOODS_URL_TYPE=="1"){
        					//판매예정
        					if(todayAtMidn < obj.GOODS_ST_SELLDATE_DIF && "N" == obj.GOODS_SOLD_FLAG){
        						dealHtml += "<a href=\"javascript:///\"  class='btn_view_info' onclick=\"goVip('"+obj.GOODS_MODELNO+"','"+obj.GOODS_TITLE+"');\">상품보기</a>";
        						if(app == "Y"){
        							dealHtml += "<a href=\"javascript:///\" class=\"btn_ready\" id=\"buybtn_"+obj.SEQ+"\" data-no='"+obj.EVENT_NO+"' data-type="+obj.GOODS_URL_TYPE+" data-apl-dt = '"+ obj.DEAL_APL_DT +"' >판매예정</a>";	
        						}else{
        							dealHtml += "<a href=\"javascript:///\" class=\"btn_app\" onclick=\"install_btt();\"  >APP 다운로드</a>";
        						}
        						
        					}else if(todayAtMidn < obj.GOODS_END_SELLDATE_DIF){
        						//판매중
        						if("N" == obj.GOODS_SOLD_FLAG){
        							todayDeal.SEQ = obj.SEQ;
        							todayDeal.GOODS_COMPANY=obj.GOODS_COMPANY ;
        							dealHtml += "<a href=\"javascript:///\" class=\"btn_view_info\" onclick=\"goVip('"+obj.GOODS_MODELNO+"','"+obj.GOODS_TITLE+"');\">상품보기</a>";
        							
        							if(app == "Y"){
        								dealHtml += "<a href=\"javascript:///\" class=\"btn_app\" id=\"buybtn_"+obj.SEQ+"\" data-no='"+obj.EVENT_NO+"' data-type="+obj.GOODS_URL_TYPE+" data-apl-dt = '"+ obj.DEAL_APL_DT +"'>구매하기</a>";	
        							}else{
        								dealHtml += "<a href=\"javascript:///\" class=\"btn_app\" onclick=\"install_btt();\"  >APP 다운로드</a>";	
        							}
        						}else{ //다팔림
        							dealHtml += "<a href=\"javascript:///\" class=\"btn_view_info\" onclick=\"goVip('"+obj.GOODS_MODELNO+"','"+obj.GOODS_TITLE+"');\">상품보기</a>";
        							if(app == "Y"){
        								dealHtml += "<a href=\"javascript:///\" class=\"btn_ready\" >판매완료</a>";	
        							}else{
        								dealHtml += "<a href=\"javascript:///\" class=\"btn_app\" onclick=\"install_btt();\"  >APP 다운로드</a>";
        							}
        							
        						}
        					}else{
        						//판매기간 종료
        						dealHtml += "<a href=\"javascript:///\" class=\"btn_view_info\" onclick=\"goVip('"+obj.GOODS_MODELNO+"','"+obj.GOODS_TITLE+"');\">상품보기</a>";
        						if(app == "Y"){
        							dealHtml += "<a href=\"javascript:///\" class=\"btn_ready\" >판매완료</a>";	
        						}else{
        							dealHtml += "<a href=\"javascript:///\" class=\"btn_app\" onclick=\"install_btt();\"  >APP 다운로드</a>";
        						}
        					}
        				} 
        				
        				dealHtml += "	</div>";
        				dealHtml += "</div>";
        				
        				$(".deal_slide").append(dealHtml);
        				dealArr.push(obj);
        	    	}
				}
        	}
        	
        },complete: function(e){

        	$('.deal_slide').slick({
				slidesToShow: 1,
				slidesToScroll: 1,
				arrows: true,
				fade: true,
				dots: true,
				speed: 500
			});		
        	
        	//첫번째 상품 선택
        	$('.deal_slide').slick('slickGoTo',frontIdx, true);
        	dealList(dealArr);
        	btnBuyChange();
        	
        	
        	//판매중인 상품 있을시 클릭이벤트 활성화
        	if(todayDeal.SEQ != ""){
        		var todaySeq = todayDeal.SEQ;
				$("#buybtn_"+todaySeq).click(function(e){
					dealGA('구매하기');
					var _this = $(this);
					
					var dataType = _this.attr("data-type");
					var eventno = _this.attr("data-no");
					var aplDate = _this.attr("data-apl-dt");
					
					if(!islogin()){
						alert("로그인 후 구매하실 수 있습니다.");
						goLogin();
						return false;
					}
					
					if("Y" == "<%=snsUserYN%>"){
						
						var goUrl = "/member/ajax/getMemberCetify.jsp";
						$.getJSON(goUrl,function(data){
							
							if(!data.certify){
								
								var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
								if(r){
									location.href = "/mobilefirst/member/myAuth.jsp?cmdType=&f=m";
									return false;
								}
								
							}else{
								
								if("2" == dataType){
									if(eventno){//타임이벤트 일경우
										goLuckyTime(todaySeq);	
									}
								}else{
									if(getCookie("appYN") != "Y" && aplDate != "" && typeof aplDate != "undefined"){
										alert("모바일 앱에서만 구매 가능합니다!")
										return false;
									} 
									goFridayDealShop('',todayDeal.GOODS_COMPANY,todaySeq);	
								}
								
							}
						});
					}else{
						
						if("2" == dataType){
							if(eventno){//타임이벤트 일경우
								goLuckyTime(todaySeq);	
							}
						}else{
							if(getCookie("appYN") != "Y" && aplDate != "" && typeof aplDate != "undefined"){
								alert("모바일 앱에서만 구매 가능합니다!")
								return false;
							} 
							goFridayDealShop('',todayDeal.GOODS_COMPANY,todaySeq);	
						}
						
					}
					
				});						
        	}
        }
	});
	
}
function btnBuyChange(){

	//판매가 임박한 상품 버튼 change
	$.ajax({
	    type: "get",
	    url: "/mobilefirst/evt/ajax/ajax_commingdeal.jsp",
	    dataType: "JSON",
	    data: "type=F",
	    async : true,
	    success: function(result){
	    	if(result.isSaleSoon){
	    		var soonSeq = result.soonSeq;
	    		var remainTime = result.remainTime;
	    		
	    		console.log(remainTime);
	    		
	    		var soonGoodsCompany = result.soonGoodsCompany;
	    		var soonBtn = $("#buybtn_"+soonSeq);
	    		var result = result.result;
	    		setTimeout(function(e){
	    			
	    			soonBtn.text("구매하기");
					soonBtn.removeClass("btn_ready");
					soonBtn.addClass("btn_app");
					
					soonBtn.click(function(e){
						
						var _this = $(this);
						
						var dataType = _this.attr("data-type");
						var eventno = _this.attr("data-no");
						var aplDate = _this.attr("data-apl-dt");
						
						if("2" == dataType){
							if(eventno){//타임이벤트 일경우
								
								if( result == -5 ){
									var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
									if(r){
										location.href = "/mobilefirst/member/myAuth.jsp?cmdType=&f=m";
										return false;
									}
								}
								goLuckyTime(soonSeq);	
							}
						}else{
							if(getCookie("appYN") != "Y" && aplDate != "" && typeof aplDate != "undefined"){
								alert("모바일 앱에서만 구매 가능합니다!")
								return false;
							} 
							if(!islogin()){
								alert("로그인 후 구매하실 수 있습니다.");
								goLogin();
								return false;
							}else{
								if( result == -5 ){
									var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
									if(r){
										location.href = "/mobilefirst/member/myAuth.jsp?cmdType=&f=m";
									}
								}
							}
							goFridayDealShop('',soonGoodsCompany,soonSeq);	
						}
					});
	    		}, remainTime);
	    	}
	    }
	});
	
}
function dealList(dealArr){
	
	$.each(dealArr , function(i,v){
		var dealList = "";
		
		dealList += "<li>";
		dealList += "<div class=\"item_sch\">";
		
		var mm =  v.GOODS_ST_SELLDATE_DIF.substring(4,6);
		var dd =  v.GOODS_ST_SELLDATE_DIF.substring(6,8);
		var hh =  v.GOODS_ST_SELLDATE_DIF.substring(8,10); 
		
		dealList += "		<span class=\"item_date\">"+mm+"/"+dd+"일 "+hh+":00</span>";
		dealList += "		<span class=\"item_img\"><img src='"+default_src + v.GOODS_ETC5+"' alt='예고 이미지'></span>";
		dealList += "		<span class=\"item_info\">";
		dealList += "			<span class=\"item_tit\">"+v.GOODS_TITLE+"</span>";
		dealList += "			<span class=\"item_srate\"><strong>"+v.GOODS_SALE_PER+"</strong>% OFF</span>";
		dealList += "		</span>";
		dealList += "	</div>";
		dealList += "</li>";
			
		$("#dealist").append(dealList);
		
	});
	
}
function goVip(modelno,goodsTitle){
	dealGA('상품상세보기_'+goodsTitle);
	if(modelno=='0'){
		alert("최저가 상품이 없습니다!");
		return false;
	}
	window.open("/mobilefirst/detail.jsp?modelno="+modelno+"&freetoken=vip&tab=2", '_blank'); 
}

/*레이어*/
function onoff(id){
	var mid = $("#"+id);
	if(mid.css("display") !== "none")	mid.css("display","none");
	else								mid.css("display","");
}

function XSSfilter (content) {
	return content.replace(/\</g, "&lt;").replace(/\>/g, "&gt;");
}

function boardTopMove(){
	var offset = $("#replyMsg").offset();
	$('html, body').animate({scrollTop : offset.top});
}
function dealGA(label){
	ga('send', 'event', 'mf_event', '크레이지프라이데이',label);		
}

function getBounsEvt(){
	 
	var html = "";
	var rHtml = "";
	 
	$.ajax({
    	type: "GET",
        url: "/mobilefirst/evt/ajax/crazydeal_shareEvt_proc.jsp?procCode=1&evnt_cd=F&sdt=<%=sdt%>",
        dataType: "JSON",
        success: function(json){
        	
        	jsonData = json;
        	
        	html += "<div class=\"deal_img\">";
        	html += "	<span class=\"tag_sale\">";
        	html += "		<span class=\"txt_rate\">"+json.GD_DC_RT+"</span>%";
        	html += "	</span>";
        	html += "	<img src='"+default_src+json.GD_IMG_URL+"' alt='보너스 이벤트 상품 이미지'>";
        	html += "</div>";
        	html += "<div class=\"deal_info\">";
        	html += "	<span class=\"txt_goods\">"+json.GD_MODEL_NM+"</span>";
        	html += "	<span class=\"txt_price\">";
        	html += "		<del class=\"txt_orgin_price\">"+commaNum(json.GD_PRC)+"원</del><span class=\"txt_sale_price\"><strong>"+commaNum(json.GD_DC_PRC)+"</strong>원</span>";
        	html += "	</span>";
        	html += "</div>";
        	html += "<div class=\"btn_deal\">";
        	html += "	<a href=\"javascript:///\" class=\"btn_view_info\" onclick=\"goVip('"+json.GD_MODEL_NO+"','"+json.GD_MODEL_NM+"');\">상품보기</a>";
        	html += "	<a href=\"javascript:///\" class=\"btn_share\" onclick=\"$('#popShare').show();return false;\">공유하기</a>";
        	html += "</div>	";
        	
			$("#bounsEvt").html(html);
			
			rHtml += "<span class=\"prizes_img\">";
			rHtml += "<span class=\"txt_limit\">"+json.PZWR_CNT+"명</span>";
			rHtml += "	<img src='"+default_src+json.PRIZE_IMG_URL+"' alt=\"경품 이미지\">";
			rHtml += "</span>";
			rHtml += "<span class=\"prizes_info\">";
			rHtml += "	<span class=\"info_inner\">";
			rHtml += "		<span class=\"prizes_tit\">"+json.PRIZE_NM1+" <br/>"+json.PRIZE_NM2+"</span>";
			rHtml += "		<span class=\"prizes_noti\">※ 경품은 <span class=\"ico_emoney\">E</span>머니로 지급됩니다.</span>";
			rHtml += "	</span>";
			rHtml += "</span>";
			
			$("#replyEvt").html(rHtml);
        }
	});
	 
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
	welcomeGa("evt_friday_view");    
},500);

</script> 
</body>
</html>