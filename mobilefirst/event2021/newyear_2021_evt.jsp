<%@page import="com.enuri.bean.mobile.Event_Welcome_Proc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
	//mobile
}else{
	response.sendRedirect("http://www.enuri.com/event2021/newyear_2021_evt.jsp"); //PC경로
    return;
}

SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMddHHmm");  //오늘 날짜
String strToday = formatter.format(new Date());
String chkId   = ChkNull.chkStr(request.getParameter("chk_id"),"");
String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String userNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK"),"");
Members_Proc members_proc = new Members_Proc();
String userName = members_proc.getUserName(userId);
String userArea = userName;
String strUrl = request.getRequestURI();
if(!userId.equals("")){
    userName = members_proc.getUserName(userId);
    userArea = userName;
    if(userName.equals("")){
        userArea = userNick;
    }
    if(userArea.equals("")){
        userArea = userId;
    }
}
String tab = ChkNull.chkStr(request.getParameter("tab"));
String protab = ChkNull.chkStr(request.getParameter("protab"));
String flow = ChkNull.chkStr(request.getParameter("flow"));

String sdt = ChkNull.chkStr(request.getParameter("sdt"));

if(!"".equals(sdt) && request.getServerName().equals("dev.enuri.com")){
	strToday = sdt;
}

Event_Welcome_Proc event = new Event_Welcome_Proc();
int intEventStep = event.eventUserStepByDate(userId);
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
<meta charset="utf-8">	
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
<meta name="keyword" content="에누리가격비교, 통합기획전, 설날, 새해, 명절선물, 신축년">
<meta property="og:title" content="2021 설날 통합기획전 – 최저가 쇼핑은 에누리">
<meta property="og:description" content="100% 당첨 설~프라이즈 이벤트를 만나보세요!">
<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
<meta name="format-detection" content="telephone=no" />
<!-- 프로모션 공통 CSS (Mobile) -->
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<!-- 프로모션별 커스텀 CSS  -->
<link rel="stylesheet" href="/css/event/y2021/newyear_m.css" type="text/css">
<link rel="stylesheet" type="text/css" href="http://m.enuri.com/mobilefirst/css/lib/slick.css"/>
<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
<script type="text/javascript" src="/event2016/js/event_common.js"></script>
<title>에누리 가격비교 - 최저가 쇼핑은 에누리 가격비교 사이트</title>
<script>
    var userId = "<%=userId%>";
    var tab = "<%=tab%>"; //파라미터 tab
    var username = "<%=userArea%>"; //개인화영역 이름
    var vChkId = "<%=chkId%>";
    var vEvent_page = "<%=strUrl%>"; //경로
    var ssl = "<%=ConfigManager.ENURI_COM_SSL%>";
</script>
</head>
<body>
<div id="eventWrap">
<%@include file="/mobilefirst/event2021/newyear_header.jsp" %>
	<!-- T1 이벤트 : 게임 -->
	<div class="section event_game" id="evt1">
		<div class="contents">
			<h1><img src="http://img.enuri.info/images/event/2021/newyear/m_tab1_g_tit.png" alt="2021 새해 떡국 한 그릇 뚝딱! 매일 떡국 재료를 순서대로 모아주세요 최대 e머니 1,500점을 적립해 드립니다!"></h1>
			<div class="game_wrap">				
				<div class="game_main">
					
					<span class="obj_cow"><!--소--></span>
					
					<ul class="obj_bowl"><!--그릇-->
						<!--
							선택 전 : blinks(깜빡임) 
							선택 후 : is-shown 
						-->
						<li class="step_1"><!--스텝1 : 떡--></li>
						<li class="step_2"><!--스텝2 : 파--></li>
						<li class="step_3"><!--스텝3 : 지단--></li>
						<li class="step_4"><!--스텝4 : 고기--></li>
						<li class="step_5"><!--스텝5 : 김--></li>
					</ul>

					<!--
						재료담기 : active
						미션성공 : complete
						다음재료 : wait
					-->
					<div class="game_step">
						<ul class="steps">
							<li class="wait" onclick = "ga_log(6);"><button type="button" class="gs_1">1단계 : 떡</button></li>
							<li class="wait" onclick = "ga_log(6);"><button type="button" class="gs_2">2단계 : 파</button></li>
							<li class="wait" onclick = "ga_log(6);"><button type="button" class="gs_3">3단계 : 지단</button></li>
							<li class="wait" onclick = "ga_log(6);"><button type="button" class="gs_4">4단계 : 고기</button></li>
							<li class="wait" onclick = "ga_log(6);"><button type="button" class="gs_5">5단계 : 김</button></li>
						</ul>
					</div>
				</div>
				<script>
					// 모션확인을 위한 퍼블참고용입니다.
					
				</script>
			</div>
		</div>

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
							<dd>
								<ul>
									<li>이벤트 기간 : 2021년 1월 18일 ~ 2월 14일</li>
									<li>이벤트 참여 : ID당 최대 5단계 참여 가능</li>
									<li>경품 : e머니 500점</li>
									<li style="color:#FF0000;">연속 5회 참여시에만 e머니 적립 가능합니다.(5단계 참여시 즉시적립)</li>
									<li>e머니 유효기간 : 적립일로부터 15일</li>
									<li>이벤트 참여 시 개인정보 수집에 동의하신 것으로 간주됩니다.</li>
									<li>적립된 e머니는 e머니 스토어에서 다양한 e쿠폰상품으로 교환 가능합니다. </li>
									<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
									<li>부정 참여 시 적립 취소 및 사이트 사용이 제한될 수 있습니다.</li>
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
	<!-- // T1 이벤트 게임 -->

	<!-- T1 이벤트 : 연하장 -->
	<div class="section event_card" id="evt2">
		<div class="contents">
			<!-- 감사카드 -->
			<div class="card_wrap">
				<h1><img src="http://img.enuri.info/images/event/2021/newyear/m_tab1_letter_tit.png" alt="설~프라이즈 연하장 보내기, 고마운 사람에게 새해 인사하고 푸짐한 상품도 받으세요~"></h1>
				
				<div class="card_gift">경품 100% 당첨</div>

				<div class="card_box">
					<p class="blind">신축년 2021 새해복 많이 받으세요</p>
					
					<div class="msg_box">
						<span class="dear"><input type="text" id = "dear_input" placeholder="받는 사람" title="받는 사람 입력"></span>
						<textarea placeholder="신년 메세지를 적어주세요." id="sendMsg" maxlength="40"></textarea>
						<span class="from"><input type="text" id = "from_input" placeholder="보내는 사람" title="받는 사람 입력"></span>
						<em><span id = "sendMsgLen">0</span>/40</em>
					</div>
					
					<button type="button" class="btn_send" id="send_card" onclick="sendLink()">카카오톡으로 카드 보내기</button>
				</div>
			</div>
		</div>

		<!-- 공통 : 꼭 확인하세요  -->
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop2"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop2" class="evt_notice--slide">
			<div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<dl>
							<dd>
								<ul>
									<li>이벤트 기간 : 2021년 1월 18일 ~ 2월 14일</li>
									<li>이벤트 참여 : ID당 최초 1회 상품 지급</li>
									<li>경품 : <br>
										<ul class="sub">
											<li>- S-OIL 모바일주유권 3만원 (e머니 30,000점) 5명</li>
											<li>- 피자헛 메가콤비 A 포테이토피자L + 파스타 + 펩시1.25L (e머니 21,900점) 10명</li>
											<li>- 신세계이마트 10,000원 상품권 교환권 (e머니 10,000점) 10명</li>
											<li>- 맥도날드 맥스파이시 상하이버거 세트 (e머니 5,900점) 10명</li>
											<li>- 이디야 우리 함께해 세트 (e머니 5,000점) 10명</li>
											<li>- GS25 모바일 금액권 1000원권 (e머니 1,000점) 50명</li>
											<li>- e머니 100점 (e머니 100점) 10,000명</li>
										</ul>
									</li>
									<li>e머니 유효기간 : 적립일로부터 15일 (미사용시 자동소멸)</li>
									<li>적립된 e머니는 e머니 스토어에서 다양한 e쿠폰상품으로 교환 가능합니다. </li>
									<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
									<li>부정 참여 시 적립 취소 및 사이트 사용이 제한될 수 있습니다.</li>
									<li>잘못된 정보 입력으로 인한 경품 수령의 불이익은 책임지지 않습니다.</li>
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
	<!-- // T1 이벤트 게임 -->

	<!-- 공통 : 하단 에누리 혜택 -->
	<div class="otherbene">
        <div class="inner">
            <h3 class="blind">놓칠 수  없는 특별한 혜택, 에누리 혜택</h3>
            <ul class="ben_list">
                <li class="ben_item--01"><a href="http://www.enuri.com/event2019/first_purchase_2019_evt.jsp?tab=evt1" target="_blank">첫구매 고객이라면! Welcome 혜택</a></li>
                <li class="ben_item--02"><a href="http://www.enuri.com/evt/visit.jsp" target="_blank">하루라도 놓치면 손해 매일100% 당첨</a></li>
                <li class="ben_item--03"><a href="http://m.enuri.com/mobilefirst/evt/smart_benefits.jsp?#tab4 " target="_blank">받고 또 받는 카테고리 혜택</a></li>
                <li class="ben_item--04"><a href="http://www.enuri.com/eventPlanZone/jsp/shoppingBenefit.jsp" target="_blank">아직 끝나지 않은 혜택 더 많은 이벤트</a></li>
            </ul>
        </div>
	</div>
	<!-- // -->	
	<!-- //Contents -->	
</div>
<!-- // 프로모션 -->

<!-- LAYER WRAP -->
<div class="layerwrap">
	<!-- 공통 : SNS공유하기 -->
	<!-- // -->	<!-- 모바일웹 공통 : 모바일 앱 전용 이벤트  -->
	<div class="layer_back" id="app_only" style="display:none">
		<div class="appLayer">
			<h4>모바일 앱 전용 이벤트</h4>
			<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
			<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
			<p class="btn_close"><button type="button" onclick="install_btn();">설치하기</button></p>
		</div>
	</div>

	<!-- 당첨 레이어 -->
	<div id="prizes" class="pop-layer" style="display:none">
		<div class="popupLayer">
			<div class="dim"></div>
		</div>
		<!-- 당첨 박스 -->
		<div class="vote_box">
			<div class="inner">
				<!-- 레이어 -->
				<div class="vote_img" >
					<div class="result_030000" style="display:none">
						<img src="http://img.enuri.info/images/event/2021/newyear/m_result_img_01.png" alt="축하합니다! S-OIL 주유권에 당첨됐어요! (e머니 30,000점)">
					</div>
					<div class="result_021900" style="display:none">
						<img src="http://img.enuri.info/images/event/2021/newyear/m_result_img_02.png" alt="축하합니다! 피자헛 메가콤비A에 당첨됐어요! (e머니 21,900점)">
					</div>
					<div class="result_0100" style="display:none">
						<img src="http://img.enuri.info/images/event/2021/newyear/m_result_img_03.png" alt="축하합니다! E머니에 당첨됐어요! (e머니 100점)">
					</div>
					<div class="result_010000" style="display:none">
						<img src="http://img.enuri.info/images/event/2021/newyear/m_result_img_04.png" alt="축하합니다! 신세계 1만원 상품권에 당첨됐어요! (e머니 10,000점)">
					</div>
					<div class="result_05900" style="display:none">
						<img src="http://img.enuri.info/images/event/2021/newyear/m_result_img_05.png" alt="축하합니다! 맥스파이시 상하이버거세트에 당첨됐어요! (e머니 5,900점)">
					</div>
					<div class="result_05000" style="display:none">
						<img src="http://img.enuri.info/images/event/2021/newyear/m_result_img_06.png" alt="축하합니다! 이디야 우리함께해 세트에 당첨됐어요! (e머니 5,000점)">
					</div>
					<div class="result_01000" style="display:none">
						<img src="http://img.enuri.info/images/event/2021/newyear/m_result_img_07.png" alt="축하합니다! GS25 1천원권에 당첨됐어요! (e머니 1,000점)">
					</div>
				</div>
			</div>
			<a href="#" class="btn layclose" onclick="onoff('prizes');return false"><em>팝업 닫기</em></a>
		</div>
		<!-- //popup_box -->
	</div>
	<!-- //당첨 레이어 -->
</div>
<!-- // -->
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20180831"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#sendMsg").keyup(function(){
		$("#sendMsgLen").text($(this).val().length);
	});
	
    if(tab == '01'){
		$('html, body').stop().animate({scrollTop: Math.ceil($('#evt1').offset().top- $(".navtab").outerHeight())}, 0);
	}else if(tab == '02'){
		$('html, body').stop().animate({scrollTop: Math.ceil($('#evt2').offset().top- $(".navtab").outerHeight())}, 0);
	}
    
	//#애드브릭스
	setTimeout(function(){
		welcomeGa("evt_newyear2021_view");
	},500);
	
});

function welcomeGa(strEvent){
	if(app == "Y"){
		try{
			if(window.android){ // 안드로이드 
				window.android.igaworksEventForApp (strEvent);
			}else if(/iPhone|iPad|iPod/i.test(navigator.userAgent)){
				// 아이폰에서 호출
				location.href = "enuriappcall://igaworksEventForApp?strEvent="+strEvent;
			}
		}catch(e){}
	}
}

// 퍼블테스트용 : 팝업 on/off
function onoff(id) {
    var mid=document.getElementById(id);
    if(mid.style.display=='') {
        mid.style.display='none';
    }else{
        mid.style.display='';
    }
} 

var sdt = "<%=strToday%>";
var isClick = true;
function getEventAjaxData(params, callback){
	if(!islogin()){
		alert("로그인 후 이용 가능합니다.");
		goLogin();
		return false;
	}else{
		if(!getSnsCheck()){

			if (confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?") == true){
				location.href="<%=ConfigManager.ENURI_COM_SSL%>/mobilefirst/member/myAuth.jsp?cmdType=modify&f=p";
			}else{
				return false;
			}
		}else{
			var evtUrl = "/mobilefirst/evt/ajax/newyear2021_setlist.jsp";

			if(typeof params === "object") {
				params.sdt = sdt;
				params.osType =  "M";
			}
			if(!isClick){
				return false;
			}
		  	isClick = false;
			 $.post(evtUrl,params,callback,"json").done(function(){
					isClick = true;
			});
		}
	}
	var evtUrl = "/mobilefirst/evt/ajax/newyear2021_setlist.jsp";

	if(typeof params === "object") {
		params.sdt = sdt;
		params.osType =  "M";
	}
	if(!isClick){
		return false;
	}
  	isClick = false;
	 $.post(evtUrl,params,callback,"json").done(function(){
			isClick = true;
	});
}

var resetNum = -1;
$(function(){
	// 선물상자찾기
	var vEventStep = <%=intEventStep%>;
	var findGiftBox = {
			
		el : {
			btn : $(".game_step .steps > li"),
			bowl : $(".game_main .obj_bowl > li"),
			joinCnt : 1,			// 참여 카운트 (1~3) : 정상참여 = 1, 재참여 = 2, 임직원참여 = 3
			gCnt : vEventStep 			// 현재 진행 단계 (0~5) : 접속한 유저의 진행된 카운트 입력
		},
		init : function(){
			this.addEvent();

			var _this = this,
				_cnt = 0,				// 초기 COUNT
				_gCnt =vEventStep;	// 현재 진행 단계 

			while(_cnt <= _gCnt){									
				if(_cnt == _gCnt){
					setTimeout(function(){
						_this.el.bowl.eq(_cnt -1).addClass("blinks");
						_this.el.btn.eq(_cnt -1).removeClass("wait").addClass("active");	
					},500)										
				}else{
					_this.el.bowl.eq(_cnt).addClass("is-shown");
					_this.el.btn.eq(_cnt).removeClass("wait").addClass("complete");
				}
				_cnt++;
			}
		},
		addEvent : function(){
			var _self = this;

			// 선물박스 클릭
			this.el.btn.click(function(){
                var _this = $(this),
                _idx = _this.index();
				var vClickStep = $(this).find("button").attr("class").slice(-1);
				
				if ( !$(this).hasClass("complete")){ // 중복클릭방지
					if($(this).hasClass("wait")){ // 도래하지 않은 다음 단계 선택시
						alert((_self.el.gCnt+1) + '단계 먼저 진행해주세요.');
					}else{
						setTimeout(function(){
							_self.alertbox(_self.el.joinCnt, vClickStep);
						},700)
						
						_self.el.bowl.eq(_idx).removeClass("blinks").addClass("is-shown");
					}
				}else{
					if(vEventStep == 5 || _self.el.gCnt == 5){ // 최종단계
						alert('모든 이벤트에 참여하셨습니다.');
					}else{
						//alert('이미 참여하셨습니다.');
						setTimeout(function(){
							_self.alertbox(_self.el.joinCnt, vClickStep);
						},700)
					}
				}
			});
		},
		alertbox : function(jCnt, vClickStep){
			var _self = this,
			//_gCnt = _self.el.gCnt,
			_gCnt = vEventStep ; 
			_st = jCnt; // 참여 카운트(1~3)

			// 당첨결과 보기
			getEventAjaxData( {"procCode":1, "evntStep" : vClickStep} ,  function(data) {
				/*
				-2	 		: 임직원
    	    	-55 		: 오늘날짜로 참여가 아닌경우(이벤트 기간X)
    	    	-10			: 이벤트 단계가 1~5단계 사이X
    	    	-20			: 참여이력X + 2~5단계 참여 시
				-30			: 모든 이벤트 참여완료(5단계)
				-40			: 당일 중복참여
				-50			: 연속참여X
				-60			: 올바르지 않은 단계
				-70			: 이미 완료한 단계
				-80			: 이전 단계 안함
				-90			: 이미 e머니 지급 완료
				10			: 최초참여(참여이력X)
				20			: 2~4단계 연속참여O
				30			: 참여이력O + 연속참여X => 1단계 새로 참여
				500			: 5단계 연속참여O + e머니 500원 지급
				*/
				var vResult = data.result;
				var vEvenStep = data.evntStep;
			   if(vResult == -2){
			    	alert("임직원은 참여 불가합니다.");
			    }else if(vResult == -55){
			    	alert("이벤트기간이 아닙니다.");
			    }else if(vResult == -10 || vResult == -60){
			    	alert("올바른 단계를 선택해주세요.");
			    }else if(vResult == -20){
			    	alert("1단계를 먼저 완료해주세요.");
			    }else if(vResult == -30){
			    	alert("떡국이벤트의 모든 단계를 참여하셨습니다.");
			    }else if(vResult == -40){
			    	alert("이미 참여하셨습니다.\n내일 다시 참여해주세요.");
			    	return false;
			    }else if(vResult == -50){
			    	alert("앗차차! 연속으로 참여하지 않으셨네요~\n떡국재료를 다시 모아주세요.");
		            //초기화면으로 리셋
			    	$(".game_step .steps > li").removeClass("complete").addClass("wait");
			    	$(".game_step .steps > li").removeClass("active").addClass("wait");
			    	$(".game_main .obj_bowl > li").removeClass("is-shown");
			    	$(".game_main .obj_bowl > li").removeClass("blinks");
			    	$(".game_step .steps > li").eq(0).removeClass("wait").addClass("active");
			    	$(".game_main .obj_bowl > li").eq(0).removeClass("wait").addClass("blinks");
                    resetNum = 0; 
                    if(vEventStep + 1 > 1){
                    	vEventStep = 0;
                    }
			    }else if(vResult == -70){
			    	alert("이미 완료한 단계입니다.");
			    }else if(vResult == -80){
			    	alert("이전 단계를 먼저 진행해주세요.");
			    }else if(vResult == -90){
			    	alert("이미 e머니 지급이 완료된 이벤트입니다.");
			    }else if(vResult == 10 || vResult == 20 || vResult == 30 || vResult == 500){
					// 참여완료
			    	alert("재료가 성공적으로 담겼습니다.");
                    if (resetNum > -1) {
                        _gCnt = 0;
                    }
			    	_self.el.btn.eq(_gCnt).removeClass("wait active").addClass("complete");

					setTimeout(function(){
						_self.el.btn.eq(_gCnt+1).removeClass("wait").addClass("active");
						_self.el.bowl.eq(_gCnt+1).addClass("blinks");
					},300)

					//
					 if (resetNum > -1) {
                        _gCnt = vEventStep;
                        resetNum = -1;
                    }
					_self.el.gCnt++;
	
					if(vResult == 500){
						$.ajax({
							type: "GET",
							url: "/mobilefirst/evt/ajax/newyear2021_setlist.jsp",
							data:{
								"emoney" : numberWithCommas(vResult),
								"procCode" : 3,
								"sdt" : sdt
							},
							dataType: "JSON",
							success: function(json){
							}

						});
					}
			    }else{
				}
			 });
		}
	}
	// 실행
	findGiftBox.init();  		
})

function sendLink() {
	ga_log(7);
	var imgMsg = "<%=ConfigManager.IMG_ENURI_COM+ "/images/event/2021/newyear/sns_1200_630_2.jpg" %>";
	if(!islogin()){
		alert("로그인 후 이용 가능합니다.");
		goLogin();
		return false;
	}else{
		if(!getSnsCheck()){
			if (confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?") == true){
				location.href="<%=ConfigManager.ENURI_COM_SSL%>/mobilefirst/member/myAuth.jsp?cmdType=modify&f=p";
			}else{
				return false;
			}
		}else{
			var dear = $("#dear_input").val();
			var from = $("#from_input").val();
			var msg = $("#sendMsg").val();
			
			if(dear == ""){
				alert("받는 사람을 입력해주세요.")
				return false;
			} 
			
			if(msg == ""){
				alert("메세지를 작성해 주세요");
				return false;
			}
			
			if(from == ""){
				alert("보내는 사람을 입력해주세요.");
				return false;
			} 
			var shareUrl = "http://" + location.host + "/mobilefirst/event2021/newyear_2021_evt.jsp?flow=share";		
			
		    Kakao.Link.sendDefault({
		      objectType: 'feed',
		      content: {
		        title: "dear "+dear,
		        description: msg+"\n"+"from "+from,
		        imageUrl: imgMsg,
		        link: {
		          mobileWebUrl: shareUrl,
		          webUrl: shareUrl
		        }
		      },
			success : function() {
				getEventAjaxData( {"procCode": 4 } , function(data) {
					//da_ga(6);
					setTimeout(function(){
				        result = data.result;
				        if (result >= 100 && result != -210) {
				            rewards(result);
				        } else if (result == -1) {
				            alert("이미 참여하셨습니다.");
				            working = false;
				        } else if (result == -2 || result == -99) {
				            alert("임직원은 참여 불가합니다.");
				            working = false;
				        } else if (result == -55) {
				            alert("잘못된 접근입니다.");
				        } else if (result == -2102) {
				            //alert("테스트");
				            //재참여라 메시지만 전송
				            return;
				        } else {
				            working = false;
				        }
					}, 3000) 
				});
			}
		    });
		}
	}
  }
  
function rewards(result){
	if(result > 0){
		// 팝업 띄우기
		setTimeout(function(){
			// 팝업 띄우기
			onoff('prizes');
			$("#prizes").find(".vote_img > div").hide();
			$("#prizes").find(".result_0" + result).show();
		},1000);
	}
	$.ajax({
		type: "GET",
		url: "/mobilefirst/evt/ajax/newyear2021_setlist.jsp",
		data:{
			"emoney" : numberWithCommas(result),
			"procCode" : 3,
			"sdt" : sdt
		},
		dataType: "JSON",
		success: function(json){
		}
	});
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var goApp = "enuri://freetoken/?url=http%3a%2f%2fm.enuri.com%2fmobilefirst%2fevent2021%2fnewyear_2021_evt.jsp%3ffreetoken%3devent";
	if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
		goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http%3a%2f%2fm.enuri.com%2fmobilefirst%2fevent2021%2fnewyear_2021_evt.jsp%3ffreetoken%3devent";
 		chrome25 = uagentLow.search("chrome") > -1 && navigator.appVersion.match(/Chrome\/\d+.\d+/)[0].split("/")[1] > 25;
		kitkatWebview = uagentLow.indexOf("naver") != -1 || uagentLow.indexOf("daum") != -1;
		setTimeout( function() {
			if (new Date - openAt < 4000) {
				if (uagentLow.search("android") > -1) {
					location.href = "market://details?id=com.enuri.android";
				}
			}
		}, 1000);
		if(uagentLow.search("android") > -1){
			chrome25 = uagentLow.search("chrome") > -1 && navigator.appVersion.match(/Chrome\/\d+.\d+/)[0].split("/")[1] > 25;
			kitkatWebview = uagentLow.indexOf("naver") != -1 || uagentLow.indexOf("daum") != -1;
			if (chrome25 && !kitkatWebview){
				window.open(goApp);
			} else{
				window.open(goApp);
			}
		}
	}else{
		setTimeout( function() {
			window.open("https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8");
		}, 1000);
		location.href = goApp;
	}
}
</script>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</body>
</html>