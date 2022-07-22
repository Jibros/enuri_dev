<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
//pc면 pc로 센딩
if(
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Linux") >= 0 ) ||
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0)){
}else{
	response.sendRedirect("/eventPlanZone/jsp/HitBrand_201806.jsp");
	return;
}

String EVENTID="20180612";

String sdt = ChkNull.chkStr(request.getParameter("sdt"),"");
String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));

String nowDate = DateStr.nowStr();
nowDate = StringUtils.replace(nowDate, "-", "");
sdt = nowDate; 
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
	<meta property="og:title" content="2017 상반기 에누리 히트브랜드 ">
	<meta property="og:description" content="2017 상반기 소비자분들에게 가장 사랑받은 히트브랜드를 소개합니다.">
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
	<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.tmpl.min.js"></script>
	<script src="/mobilefirst/js/utils.js"></script>
	<script src="/mobilefirst/js/lib/ga.js"></script>
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/hit_2018june_m.css"/>
	<link rel="stylesheet" type="text/css" href="http://m.enuri.com/mobilefirst/css/lib/slick.css">
</head>
<body>
<div class="wrap">
	<a href="javascript:///" class="win_close">창닫기</a> 
	<!-- 메인비주얼 -->
	<div class="visual">
		<div class="inner">
			<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_june/m_visual.jpg" alt="2018 에누리 히트브랜드" class="imgs">
			<div class="blind">
				<h1>2018 에누리 히트브랜드</h1>
				<p>2018년 6월 11일부터 2018년 7월 30일까지</p>
			</div>
		</div>
	</div>
	
<div class="event event__wrap">
		<div class="event__head">
			<div class="inner">
				<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_june/m_event_tit.jpg" alt="오늘의 히트상품 찾기!" class="imgs">
				<div class="blind">
					<h2>이벤트! 오늘의 히트상품 찾기!</h2>
					<p>매일 히트상품 정답자 중 5분께 '오늘의 경품' 증정!, 차수별 5일 이상 정답시 '스페셜경품전 응모권' 증정</p>
				</div>
			</div>
		</div>

		<div class="event__cont">
			<!-- 
				좌우이동
				- 클릭 시 캘린더 영역과 퀴즈 영역 전체 판 이동
				- 미래 주차도 이동은 가능
				
				판 종류는 두 가지
				(주차별 차수 or 스페셜경품전)
			 -->
			<div class="pager">
				<button type="button" class="sprite pager__btn pager__btn--prev" id="btn--prev"  >이전</button>
				<button type="button" class="sprite pager__btn pager__btn--next" id="btn--next"  >다음</button>
			</div>
			
			<!-- 판 CONTAINER -->
			<div id="" class="board__container">
				<!-- 판 : 주차별 차수 레이스 -->
				<div class="race" style="display: block;">
					<div class="race__head">
						<div class="inner">	
							<h3 class="tit"><span id="orderNum">1차</span> Race</h3>
							<p class="date" id="period"></p>
						</div>
					</div>
					<!-- Race 테이블 -->
					<div class="race__table">
						<div class="inner">
							<table>
								<colgroup>
									<col width="25%">
									<col width="25%">
									<col width="25%">
									<col width="25%">
								</colgroup>
								<tbody id="race_goods"></tbody>
							</table>
						</div>
					</div>
					<!-- //Race 테이블 -->
	
					<!-- 오늘의 히트상품은? -->
					<div id="todayHit" class="todayhit">
						<div class="inner">
							<div class="todayhit__head">
								<h3><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_june/m_quiz_tit.jpg" alt="오늘의 히트 상품은?" class="imgs"></h3>
								<p class="blind">아래의 키워드를 조합하여 오늘의 히트 상품을 찾아보세요</p>
							</div>
							<div class="todayhit__cont">
								<ul class="quizlist">
								</ul>
								<div class="quizbtn">
									<a href="javascript:///" onclick="goPlayGuide()"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_june/m_quizbtn01.jpg" alt="응모방법 안내" class="imgs"></a>
									<a href="javascript:///" onclick="goWonList();"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_june/m_quizbtn02.jpg" alt="당첨자 발표" class="imgs"></a>
								</div>
							</div>
						</div>
					</div>
					<!-- //오늘의 히트상품은? -->
					
					<!-- 이전날짜 히트상품 소개 -->
					<div id="pastHit" class="pasthit" style="display:none;"></div>
					<!-- //이전날짜 히트상품 소개 -->
				</div>
				<!-- //판 : 주차별 차수 레이스 -->
			</div>
			<div class="ticket" style="display: none;">
					<div class="ticket__head">
						<div class="inner">	
							<h3 class="tit">스페셜 경품전</h3>
							<p class="date">(7/23 ~ 7/30)</p>
						</div>
					</div>
					<div class="ticket__cont">
						<div class="inner">
							<div class="ticket__num sprite">
								<p class="num" id="ticket__num" >응모권: <b>0</b>장</p>
							</div>
							<div class="ticket__info">
								<p>아래 경품 중 원하시는 경품에 응모하세요.<br>획득하신 응모권 개수만큼 1일 응모횟수가 부여됩니다. </p>
								<p>예) 스탬프가 3장인 경우 매일 3회 응모가능</p>
							</div>
							
							<ul class="prize__list">
								<li>
									<span class="thumb"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_june/m_prize_img1.jpg" alt="" class="imgs"></span>
									<span class="proname">닌텐도 스위치</span>
								</li>
								<li>
									<span class="thumb"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_june/m_prize_img2.jpg" alt="" class="imgs"></span>
									<span class="proname">위닉스 공기청정기</span>
								</li>
								<li>
									<span class="thumb"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_june/m_prize_img3.jpg" alt="" class="imgs"></span>
									<span class="proname">고프로 히어로 5 Session</span>
								</li>
							</ul>
							
							<div class="prize__btn">
								<button type="button" id="prize__btn"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_june/m_specialbtn.jpg" alt="스페셜 경품전 응모하기" class="imgs"></button>
							</div>
						</div>
					</div>				
				</div>
			<!-- //판 CONTAINER -->	
		</div>
		
		<!-- 스페셜 경품응모 -->
		<div class="specialgift">
			<div class="inner">
				<div class="specialgift__cont">
					<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_june/m_specialgift.jpg" alt="스페셜 경품 응모하기" class="imgs">
					<div class="blind">
						<p>획득하신 응모권으로 스페셜경품전 응모!<br>응모권의 개수만큼 1일 응모횟수 부여<br>예) 응모권 3장인 경우 매일 3회 응모가능</p>
						<ul>
							<li>이벤트 기간 : 2018년 7월 23일 ~ 7월 30일</li>
							<li>당첨자 발표 : 2018년 8월 2일 고객센터</li>
						</ul>
					</div>
					<button type="button" class="btn__caution" onclick="$('#note').show(); $(document).scrollTop(0);ga('send', 'event', '2018히트브랜드' ,'퀴즈', '꼭 확인하세요!');">꼭 확인하세요!</button>
				</div>
			</div>
		</div>
		<!-- //스페셜 경품응모 -->
			 
	</div>
	
	<div class="tabList">
		<!-- tab -->
		<div class="tabBt">
			<ul class="menu">
				<li class="on" data-id="digital"><a href="javascript:///">디지털</a></li>
                <li data-id="appliance" ><a href="javascript:///">가전</a></li>
                <li data-id="computer" ><a href="javascript:///">컴퓨터</a></li>
                <li data-id="life"><a href="javascript:///">라이프</a></li>
			</ul>
			<nav class="m_top">
				<div class="submenu">
					<span class="grd_next"></span>
					<span class="sh"></span>
					<ul></ul>
				</div>
				<div class="gnbarea">
					<ul class="newgnb"></ul>
				</div>
			</nav>
		</div>
		<!--// tab -->
		<div class="conList">
			<!-- 디지털 -->
			<div class="plan" id="sCon01"></div>
			
			<!-- 파워클릭 AD -->
			<div class="powerad_wrap">
				<div class="pad_head">
					<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2017/hitbrand/mobile/pad_tit.png" alt="파워클릭 AD" class="imgs" /></h2>
					<a href="javascript:///" onclick="goJoin()" class="join">신청하기 &gt;</a>
				</div>
				<div class="horiScrollWrap">
					<div class="scrollList">
						<ul class="adProdList"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<span class="go_top"><a href="javascript:///" >TOP</a></span>
	


<div id="Quiz2nd" class="dim" style="display:none">
	<div class="quiz_layer">
		<div class="head">
			<h2>경품 응모</h2>
			<a href="javascript:///" class="close" onclick="$('#Quiz2nd').hide();">창닫기</a>
		</div>

		<div class="cont">
			<!-- popup_box -->
			<div class="join_area">
				<dl class="question2">
					<dt>아래 경품 중 원하시는 경품 하나를 선택해 주세요.<br>각 경품별로 1명씩 추첨하여 선택하신 경품을 드립니다. </dt>
					<dd>
						<ul class="prize_list">
							<!-- 체크한 상품 li.chk 추가 -->
							<li class="chk">
								<input type="radio" id="opt1" class="p_rdo" name="opt" value="" checked="checked"> 
								<label for="opt1">
									<span class="thumb"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_june/m_prize_img1.jpg" alt=""></span>
									<span class="proname">닌텐도 스위치</span>
								</label>
							</li>
							<li>
								<input type="radio" id="opt2" class="p_rdo" name="opt" value=""> 
								<label for="opt2">
									<span class="thumb"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_june/m_prize_img2.jpg" alt=""></span>
									<span class="proname">위닉스 제로 공기청정기</span>
								</label>
							</li>
							<li>
								<input type="radio" id="opt3" class="p_rdo" name="opt" value=""> 
								<label for="opt3">
									<span class="thumb"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_june/m_prize_img3.jpg" alt=""></span>
									<span class="proname">고프로 히어로 5 Session</span>
								</label>
							</li>
						</ul>
					</dd>
				</dl>

				<script type="text/javascript">
				$(".prize_list li").click(function(e){
					$(".prize_list li").removeClass("chk");
					$(this).addClass("chk");
					return false;
				});
				</script>


				<div class="agreebox">
					<p class="tit">당첨 시 경품 발송 안내를 위한 연락처를 넣어주세요.</p>
					<div class="input_num">
						<label for="p_numb">연락처</label><input type="text" id="p_numb" name="" onfocus="this.value='';" value="(-) 없이 입력하세요.">
					</div>
					<div class="info_agree">
						<span class="unchk2" onclick="agreechk(this);"><input type="checkbox" id="" name="" value="N">개인정보 활용에 동의합니다.</span><a href="javascript:///" class="btn_detail" onclick="$('#Personinfo').show(); return false">자세히 보기</a>
					</div>
				</div>
				<script type="text/javascript">
					/*checkbox - 라디오*/
					function radiochk(obj){
						if (obj.className== 'unchk') {
							obj.className = 'chk';
						} else {
							obj.className = 'unchk';
							}
						}	
				
					/*checkbox - 네모*/
					function agreechk(obj){
						if (obj.className== 'unchk2') {
							obj.className = 'chk2';
						} else {
							obj.className = 'unchk2';
						}
					}
				</script>
				
				<div class="btn__group">
					<a class="btn layorange" >응모하기</a>
					<a class="btn layclose" onclick="$('#Quiz2nd').hide(); return false">취소</a>
				</div>
			</div>
			<!-- //popup_box -->
		</div>
	</div>
</div>

<div class="dim" id="Personinfo" style="display:none">
	<div class="quiz_layer">
		<div class="head">
			<h2>개인 정보 수집 / 이용안내</h2>
			<a href="javascript:///" class="close" onclick="$('#Personinfo').hide()" >창닫기</a>
		</div>

		<div class="cont">
			<!-- popup_box -->
			<div class="personinfo">
				<div class="box">
					<p class="title">에누리 가격비교는 이벤트 참여확인 및 경품 발송을 위하여<br>아래와 같이 개인정보를 수집하고 있습니다.</p>
					<ol>
						<li>
							<p class="stit">1. 개인정보 수집 항목</p>
							<p class="text">휴대폰 번호, 아이디, 참여일시</p>
						</li>
						<li>
							<p class="stit">2. 개인정보 수집 및 이용 목적</p>
							<p class="text">이벤트를 위해 수집된 개인정보는 이벤트 참여확인 및 경품 발송을 위한 본인확인 이외의 목적으로 활용되지 않습니다.</p>
						</li>
						<li>
							<p class="stit">3. 개인정보 보유 및 이용 기간</p>
							<p class="text">개인 정보 수집자 (에누리 가격비교)는 개인 정보의 수집 및 이용 목적이 달성되면 개인 정보를 즉시 파기합니다.</p>
						</li>
					</ol>
				</div>

				<a class="btn layblack" onclick="$('#Personinfo').hide(); return false">확인</a>
			</div>
			<!-- //popup_box -->
		</div>
	</div>
</div>


<div id="joinExplainLayer" class="explain_layer" style="display: none;">
	<div class="backdim"></div>
	<div class="appLayer">
		<h4>응모방법 안내</h4>
		<a href="javascript:///" class="close" onclick="$('#joinExplainLayer').hide();">창닫기</a>
		<div class="txt">
			<ol>
				<li>다섯 개의 키워드를 조합하여 오늘의 히트 상품을  찾아보세요.</li>
				<li>정답 응모는 하단에 리스팅 되어 있는 히트브랜드 상품들 중 정답이라고 생각되는 상품의 ‘응모‘ 버튼을 클릭하시면 됩니다. (Best 상품만 정답 대상입니다.)
					<div class="thumb"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_june/m_joinexplain_img.jpg" alt="" class="imgs"></div>
				</li>				
				<li>제시된 키워드를 참고하여 각 상품의 상세설명창에 방문하여 정답을 찾아주세요
				</li>
				<li>주차별로 정답 일수가 5일 이상일 경우 응모권 1장을 받을 수 있습니다. 응모권를 모아 마지막 주차 스페셜 경품전에 도전하세요!</li>
			</ol>
		</div>
		<p class="btn_close"><button type="button" onclick="$('#joinExplainLayer').hide();">닫기</button></p>
	</div>
</div>


<!-- 오늘의히트상품찾기 레이어 -->
<div id="Aswmsg1" class="dim" style="display:none">
	<div class="quiz_layer">
		<div class="cont">
			<!-- 레이어 안에 딥레이어 : 정답 -->
			<div class="popin-layer">
				<div class="backdim"></div>
				<div class="answerview">
			
					<div class="hitbox">
						<div class="toptit col"><b>축하드립니다!</b></div>
						<div class="t_detail col">정답입니다.</div>
						<a href="javascript:///" class="btn layblack col" onclick="javascript:goSocces()">닫기</a>
					</div>
				
				</div>
			</div>
			<!-- //레이어 안에 딥레이어 : 정답 -->
		</div>
	</div>
</div>
<!-- //오늘의히트상품찾기 레이어 -->
<!-- //레이어 영역 -->


<!-- 오늘의히트상품찾기 레이어 -->
<div id="Aswmsg2" class="dim" style="display:none">
	<div class="quiz_layer">
		<div class="cont">
			<!-- 레이어 안에 딥레이어 : 정답 -->
			<div  class="popin-layer">
				<div class="backdim"></div>
				<div class="answerview">
			
					<div class="hitbox">
						<div class="toptit">안타깝지만, <b>오답</b>입니다!</div>
						<div class="t_detail">다시 도전해 보세요!</div>
						<!-- <a href="#" class="btn layblue" onclick="$('#Aswmsg2').hide(); return false">다시 도전</a> -->
						<a href="#" class="btn layblack col" onclick="$('#Aswmsg2').hide(); return false">닫기</a>
					</div>
				
				</div>
			</div>
			<!-- //레이어 안에 딥레이어 : 정답 -->
		</div>
	</div>
</div>
<!-- //오늘의히트상품찾기 레이어 -->
<!-- //레이어 영역 -->

<div id="note" class="caution_layer" style="display: none;">
	<div class="backdim"></div>
	<div class="appLayer">
		<h4>꼭 확인하세요!</h4>
		<a href="javascript:///" class="close" onclick="$('#note').hide();">창닫기</a>
		<div class="txt">
			<strong class="top">당첨 안내</strong>

			<ol>
				<li>
					<strong>1. 오늘의경품</strong>
					<ul class="txt_indent">
						<li>선정방법: 매일 퀴즈 정답자 중 5분을 추첨하여 경품 증정</li>
						<li>당첨자발표: 차주 월요일에 전주 당첨자 일괄 발표<br>[에누리 고객센터 및 에누리 가격비교 APP&gt;당첨자발표]</li>
						<li>'오늘의경품'은 상당하는 금액의 e머니로 지급됩니다. <br>'e머니스토어'에서 교환 후 사용해 주세요.</li>
						<li>e머니 지급: 발표일 당일 지급</li>
						<li>e머니 유효기간: <b>적립일로부터 30일</b></li>
						<li>일자별 중복당첨은 가능하나, <span class="under">최대 3회</span>로 제한됩니다.</li>
					</ul>
				</li>
				<li>			
					<strong>2. 스페셜 경품전</strong>
					<ul class="txt_indent">
						<li>선정방법: 
							<ul>
								<li>- 각 회차별 스탬프 획득일이 5일 이상인 참가자에게는 스페셜경품전 응모권 증정</li>
								<li>- 응모권 소지자는 스페셜경품전 기간 동안 매일 응모권 개수만큼 응모 가능</li>
								<li>- 응모횟수 많을수록 당첨 확률 높음</li>
							</ul>
						</li>
						<li>당첨자발표: <b>2018년 8월 2일</b><br>[에누리 고객센터 및 에누리 가격비교 APP&gt;당첨자발표]</li>
						<li>경품 발송 : 당첨자 개별 연락 후 발송</li>
						<li>경품 관련 제세공과금 22%는 당첨자 부담입니다.<br> (입금 확인 후 경품 발송)</li>
						<li>발표일로부터 일주일 이내에 연락이 되지 않을 경우,<br> 당첨이 취소될 수 있습니다.</li>
					</ul>
				</li>
			</ol>
			
			<strong>참여 시 유의사항</strong>
			<ul class="txt_indent">
				<li>적립된 e머니는 에누리 'e머니스토어'에서 e쿠폰으로 교환 가능합니다.</li>
 				<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
 				<li>부정 참여 시 경품 증정이 취소되며, 법적 책임을 질 수 있습니다.</li>
			</ul>
		</div>
		<p class="btn_close"><button type="button" onclick="$('#note').hide();">닫기</button></p>
	</div>
</div>


</div>
<!-- 푸터 -->
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<!--// 푸터 -->
<script type="text/javascript">

var hintYN = true;
var ord = 1;

function goSocces(){
	$('#Aswmsg1').hide();
	location.reload();
	return false;
}
function goWonList(){
	ga('send', 'event', '2018히트브랜드' ,'퀴즈', "당첨자 발표");
	//window.open("/mobilefirst/event/eventWonView.jsp?freetoken=event&seq=192");
	location.href = "/mobilefirst/event/eventWonView.jsp?freetoken=event&seq=192";
	return false;
}

function goPlayGuide(){
	ga('send', 'event', '2018히트브랜드' ,'퀴즈', "응모방법 안내");
	$('#joinExplainLayer').show(); 
	return false;
}

sdt = "<%=sdt%>"; 

$(document).ready(function(){
	
    if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        ga('send', 'pageview', {'page': '/mobilefirst/evt/event_hitbrand201806.jsp', 'title': '201806히트브랜드  pv_iphone'});
    }else if(navigator.userAgent.indexOf("Android") > -1){
       ga('send', 'pageview',  {'page': '/mobilefirst/evt/event_hitbrand201806.jsp',  'title': '201806히트브랜드  pv_android'});
    }
    $(".win_close").click(function(){
        if(getCookie("appYN") == 'Y')	window.location.href = "close://";
        else				            window.location.replace("/mobilefirst/index.jsp");
    });
    
    if(        sdt >= 20180611 && sdt <= 20180617 ){
    	raceGoodsSet(ord); 	
    } else if( sdt >= 20180618 && sdt <= 20180624 ) {
    	raceGoodsSet(2);
    } else if( sdt >= 20180625 && sdt <= 20180701 ) {
    	raceGoodsSet(3);
    } else if( sdt >= 20180702 && sdt <= 20180708 ) {
    	raceGoodsSet(4);
    } else if( sdt >= 20180709 && sdt <= 20180715 ) {
    	raceGoodsSet(5);
    } else if( sdt >= 20180716 && sdt <= 20180722 ) {
    	raceGoodsSet(6);
    } else if( sdt >= 20180723 && sdt <= 20180730 ) {
    	$(".race").hide();
		$(".ticket").show();
		ord = 7;
    }

    dailyQuizSet();
    
    getTicket();
    $("#btn--prev").click(function(){
    	ord = ord-1;
    	
    	ga('send', 'event', '2018히트브랜드' ,'퀴즈 달력', "prev");
    	
    	if(ord == 0){
    		ord = 7;
    		$(".race").hide();
			$(".ticket").show();
    	}else{
			$(".race").show();
			$(".ticket").hide();
    		raceGoodsSet(ord);	
    	}
    });  
    
	$("#btn--next").click(function(){
		ord = ord+1;
		
		ga('send', 'event', '2018히트브랜드' ,'퀴즈 달력', "next");
		
		if(ord == 7) {
			$(".race").hide();
			$(".ticket").show();
		}else if(ord == 8){
			$(".race").show();
			$(".ticket").hide();
			
			ord = 1;
			raceGoodsSet(ord);
		}else{
			$(".race").show();
			$(".ticket").hide();
			
			raceGoodsSet(ord);	
		}
    });
	
	$("#prize__btn").click(function(){
		
		if(sdt < 20180723){
			alert("스페셜 경품전 응모 기간이 아닙니다.");
			return false;
		}
		$('#Quiz2nd').show();
	});
	
});
function dailyQuizSet(){
	//오늘 이전 상품 정보 가지고 오기
	//http://dev.enuri.com/eventPlanZone/ajax/hitBrand201806_getData.jsp?procCode=2&sdt=20180701&evtStartDate=20180630&evtEndDate=201807022
	
	$.ajax({
		type:"GET",
		url: "/eventPlanZone/ajax/hitBrand201806_getData.jsp?procCode=3&sdt="+sdt,
		dataType: "JSON",
		async : true,
		success:function(result){
			if(result.hint){
				$.each(result.hint,function(i,v){
					$(".quizlist").append("<li><div class=\"sprite quizitem\"><span>#"+v+"</span></div></li>");	
				});	
			}
		}
	});
}
var json;
function raceGoodsSet(order){
	
	//오늘 이전 상품 정보 가지고 오기
	//http://dev.enuri.com/eventPlanZone/ajax/hitBrand201806_getData.jsp?procCode=2&sdt=20180701&evtStartDate=20180630&evtEndDate=201807022
	
	var nowdate = "&sdt="+sdt;
			
	if	   (order == 1)  gourl = "/eventPlanZone/ajax/hitBrand201806_getData.jsp?procCode=2&evtStartDate=20180611&evtEndDate=20180617"; 
	else if(order == 2)  gourl = "/eventPlanZone/ajax/hitBrand201806_getData.jsp?procCode=2&evtStartDate=20180618&evtEndDate=20180624";
	else if(order == 3)  gourl = "/eventPlanZone/ajax/hitBrand201806_getData.jsp?procCode=2&evtStartDate=20180625&evtEndDate=20180701";
	else if(order == 4)  gourl = "/eventPlanZone/ajax/hitBrand201806_getData.jsp?procCode=2&evtStartDate=20180702&evtEndDate=20180708";
	else if(order == 5)  gourl = "/eventPlanZone/ajax/hitBrand201806_getData.jsp?procCode=2&evtStartDate=20180709&evtEndDate=20180715";
	else if(order == 6)  gourl = "/eventPlanZone/ajax/hitBrand201806_getData.jsp?procCode=2&evtStartDate=20180716&evtEndDate=20180722";

	gourl+=nowdate;
	
	if	   (order == 1) $("#period").text(" 6/11 ~ 6/17 "); 
	else if(order == 2) $("#period").text(" 6/18 ~ 6/24 "); 
	else if(order == 3) $("#period").text(" 6/25 ~ 7/1 "); 
	else if(order == 4) $("#period").text(" 7/2 ~ 7/8 "); 
	else if(order == 5) $("#period").text(" 7/9 ~ 7/15 "); 
	else if(order == 6) $("#period").text(" 7/16 ~ 7/22 "); 
	
	$.ajax({
		type:"GET",
		url: gourl,
		dataType: "JSON",
		async : true,
		success:function(data){
			
			var dayGoods = "";
			
			json = data;
			$.each(data.response,function(i,v){
				
				if( i == 0 || i == 4 )dayGoods += "<tr>";			
				//<td class="nb">
				//이전날짜 상품 클릭 시, 하단 영역에 히트상품(#pastHit) 노출
				//<a href="#" onclick="$('#todayHit').hide(); $('#pastHit').show(); return false;">
					//정답시, <b class="complete">완료</b>
				//	<b class="complete">완료</b>
				//	<span class="day">11</span>
				//	<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_june/m_testimg@112x112.jpg" alt="상품이미지" class="thumb">
				//</a>
				//</td>
				if(i == 0) dayGoods += "<td class='nb'>\n";
				else 	   dayGoods += "<td >\n"
				
				var img_src = "";
				
				if(v.goods_image.indexOf("product_before") > -1){
					img_src = "mp_before.jpg";
				}else{
					img_src = v.goods_image;
				}
				
				if( v.itemDate < sdt ){
					dayGoods += "	<a href='javascript:openPastHit("+v.itemDate+")' id='day"+v.itemDate+"' >\n";
					//dayGoods += "		<b class=\"complete\">완료</b>";
					dayGoods += "		<img src=\"http://storage.enuri.gscdn.com/pic_upload/exhibition/"+img_src+"\" alt='' class=\"imgs\">\n";
				}else if(v.itemDate == sdt){
					
					if(v.goods_image == "/product_before.jpg"){
						dayGoods += "	<a href='javascript:goTodayShow();' id='day"+v.itemDate+"' >\n";	
					}else{
						dayGoods += "	<a href='javascript:openPastHit("+v.itemDate+")' id='day"+v.itemDate+"' >\n";
						//dayGoods += "		<b class=\"complete\">완료</b>";
					}
					dayGoods += "		<img src=\"http://storage.enuri.gscdn.com/pic_upload/exhibition/"+img_src+"\" alt='' class=\"imgs\">\n";
				}else{
					dayGoods += "	<a href='javascript:goAlert();' id='day"+v.itemDate+"' >\n";
					dayGoods += "		<img src=\"http://storage.enuri.gscdn.com/pic_upload/exhibition/"+img_src+"\" alt='' class=\"imgs\">\n";
				}
				dayGoods += "		<span class='day'>"+v.itemDate.substr(6,2)+"</span>\n";
				dayGoods += "	</a>\n";
				dayGoods += "</td>\n";
				
				if (i == 6){  dayGoods+="<td class=\"todaygift\">";
								  dayGoods+="<a href=\"javascript:///\"> ";
								  dayGoods+="	<span class=\"text sprite\">오늘의 경품</span>";
								  if( sdt >= 20180611 && sdt <= 20180722 ){
									  var imgSrc = "http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_june/m"+sdt.substr(4,4)+".png";
									  dayGoods+="	<img src=\""+imgSrc+"\" alt=\"상품이미지\" class=\"thumb\">";  
								  }
								  
								  dayGoods+="</a>";
							  dayGoods+="</td>"; 
				}
				
				if( i == 3 || i == 6 ) 	 dayGoods+="</tr>";
				
			});
			//console.log(dayGoods);
			$("#race_goods").html(dayGoods);
			//pastHit
			$("#orderNum").text(order+"차");
			getDayComplete();
		}
	});
}

function getDayComplete(){
	
	var gourl = "/eventPlanZone/ajax/hitBrand201806_getData.jsp?procCode=4&sdt="+sdt;
	
	$.ajax({
		type:"GET",
		url: gourl,
		dataType: "JSON",
		async : true,
		success:function(data){
			$.each(data.response,function(i,v){
				$("#day"+v).prepend("<b class=\"complete\">완료</b>");	
			});
		}
	});
}

function getTicket(){
	
	var gourl = "/eventPlanZone/ajax/hitBrand201806_getData.jsp?procCode=5&sdt="+sdt;
	
	$.ajax({
		type:"GET",
		url: gourl,
		dataType: "JSON",
		async : true,
		success:function(data){
			$("#ticket__num").html("응모권: <b>"+data.response+"</b>장");	
		}
	});
	
}

function goTodayShow(){
	
	$("#todayHit").show();
	$("#pastHit").hide();
	
}
function goAlert(){
	alert('해당 일에 다시 응모하여 주세요!');
}

function openPastHit(date){
	
	var pastHit = "";
	
	$.each(json.response,function(i,v){
		
		if(date == v.itemDate){
			
			var dateFormat = v.itemDate;
			dateFormat = dateFormat.substr(4,2)+"월 "+dateFormat.substr(6,2)+"일";
			
			pastHit += "<div class=\"inner\">";
				pastHit += "<div class=\"pasthit__head\">";
				pastHit += "	<h3><span class=\"icon sprite\"></span>"+dateFormat+" <strong>히트</strong>상품</h3>";
				pastHit += "</div>";
				pastHit += "<div class=\"pasthit__cont\">";
				pastHit += "	<div class=\"pasthit__img\">";
				pastHit += "		<a href=\"javascript\" target=\"_blank\"><img src=\"http://storage.enuri.gscdn.com/pic_upload/exhibition/"+v.goods_image+"\" alt='' class=\"imgs\"></a>";
				pastHit += "	</div>";
				pastHit += "	<div class=\"pasthit__info\">";
				pastHit += "		<h4 class=\"name\">"+v.modelname+"</h4>";
				pastHit += "		<p class=\"price\"><strong class=\"min\">최저가</strong> <span>"+v.minprice+"</span>원</p>";
				pastHit += "		<a href=\"javascript:///\" onclick='goDetail("+v.modelno+")' class=\"sprite btn\">자세히 보기</a>";
				pastHit += "	</div>";
				pastHit += "</div>";
			pastHit += "</div>";
		}
	});
	
	$("#todayHit").hide();
	
	$("#pastHit").html(pastHit);
	$("#pastHit").show();
	
	ga('send', 'event', '2018히트브랜드' ,'달력', date);
}

function goJoin(){
	window.open("https://ad.esmplus.com/");
	return false;
}
	//레이어 메뉴
	$(document).ready(function(){
		
        $(".go_top").click(function(){	$(window).scrollTop(0);	 });
		
        //썸네일
        $("body").on('click', '.plan_list li a', function(event) {    
        
            var address = $(this).children("img");
            
            $(this).parent().parent().parent().parent().find("#zoom_img img").attr("src",address.attr("src")).attr("alt",address.attr("alt"));
            $(this).parent().addClass("on").siblings().removeClass("on");
            
            var modelno = $(this).parent().attr("data-id");
            var modelnm = $(this).parent().attr("data-name");
            var price = $(this).parent().attr("data-money");
            var bno = $(this).parent().attr("data-bno");
            var ord = $(this).parent().attr("data-ord");
            
            if(ord == 1)     $(this).parent().parent().parent().parent().find(".md").show();
            else                $(this).parent().parent().parent().parent().find(".md").hide();
            
            $(this).parent().parent().parent().parent().find(".tit").text(modelnm);
            $(this).parent().parent().parent().parent().find("#price").text(price);
            $(this).parent().parent().parent().parent().parent().find("#detail").attr("data-id",modelno);
            return false;
        });
        
		$( ".submenu .grd_next").click(function() {
			if($(this).parent().hasClass("on")){
				$(".submenu").removeClass("on");
			}else {
				$(this).parent().addClass("on").siblings().removeClass("on");
			}
			return false;
		});
		$( ".plan_list li a" ).click(function() {
			var address = $(this).children("img");
			$("#zoom_img img").attr("src",address.attr("src")).attr("alt",address.attr("alt"));
			$(this).parent().addClass("on").siblings().removeClass("on");
			return false;
		});
		
        $(".tabBt > ul > li").click(function(){
            $(".tabBt > ul").find("li").removeClass("on");
            $(this).addClass("on");
            $(".submenu").removeClass("on");
            
            var offset = $(".conList").offset();
            
            $('html, body').animate({scrollTop : Math.round(offset.top-100) }, 400);
            
            var tabName = $(this).text();
            
            ga('send', 'event', '2018히트브랜드' ,'button', '2018하반기히트브랜드_Tab_'+tabName);
            
            goodsLoading();
           	eBayCpcSet();
        });
        $("body").on('click', '.submenu > ul > li', function(event) {
            var text = $(this).text();
            
            text =  text.replace(/-/gi , "");
            text = text.replace(/ /gi , "");
            
            var offset = $("#"+text).offset();
            
            $(".submenu").removeClass("on");
            $('html, body').animate({scrollTop : offset.top-100}, 400);
        });
        $("body").on('click', '.newgnb > li > a', function(event) {
            var text = $(this).text();
            
            text =  text.replace(/-/gi , "");
            text = text.replace(/ /gi , "");
            
            var offset = $("#"+text.trim()).offset() ;
            $('html, body').animate({scrollTop : offset.top-100}, 400);
        });
        $("body").on('click', '#detail', function(event) {
        	
        	var target = $(event.target).attr("class");
			
        	var modelno = $(this).attr("data-id");
            var bno = $(this).attr("data-bno");
        	
        	if(target == "sprite btnjoinquiz"){
        		if(confirm("해당 모델에 응모하시겠습니까?")){
        			ga('send', 'event', '2018히트브랜드' ,'퀴즈 정답응모', modelno);
        			goAnswer(modelno);	
        		}
        	}else{
        		
	            hitbrandLogPC(bno , 'H' , 'M');
	            
	            ga('send', 'event', '2018히트브랜드' ,'goods', modelno);
	            location.href = "/mobilefirst/detail.jsp?modelno="+modelno;
        	}
        });
		tabScroll(".tabBt");
	});
	
	function goAnswer(selectedModelNo) {
		
		hitProc({procCode : 1, answer : selectedModelNo }, function(data){
			
			var result = data.response;
			switch (result) {
				case "overdue" :
					alert("이벤트 기간이 아닙니다.");
					break;
				case "exceed" :
					alert("오늘 응모기회를 모두 사용하셨습니다.\n내일 다시 응모해 주세요!");
					break;
				case "duplicate" :
					alert("동일 휴대폰번호 기준으로 1일 1개 아이디만 유효합니다.");
					break;
				case "correct" :
					$("#Aswmsg1").show();
					break;
				case "incorrect" :
					$("#Aswmsg2").show();
					break;				
				default :
					alert("잘못된 접근입니다.");
					break;
			}
			//closeLayer('Aswmsg');		
		});
	}
	var isClick = true;
	function hitProc(param, callback) {
		//insert 호출시에 공통 체크규칙
		if(param.procCode == 1 || param.procCode == 6) {
			if(!evtCommonChk (param.procCode)) {
				return false;
			}
			if(!isClick) {
		    	return false;
		    }
		    isClick = false;
		    
		}
	    if(location.host.indexOf("dev.enuri.com") > -1){
			param.sdt = sdt;
		}
		$.getJSON("/eventPlanZone/ajax/hitBrand201806_getData.jsp", param ,callback)
		.done(function(){
			isClick = true;
		});
	}
	//이벤트 공통체크로직
	function evtCommonChk (procCode) {
		var chkResult = false;
		var sdt = 20180615;
		// 매일 히트상품, 스페셜경품전 이벤트 기간
		var chkDate = [
			{
				"startDate" : 20180611,
				"endDate" : 20180722
			},
			{
				"startDate" : 20180723,
				"endDate" : 20180730
			},
		];
		
		var idx = (procCode == 1) ? 0 : 1;
		if(sdt < chkDate[idx].startDate) {
			alert("이벤트 기간이 아닙니다.\n차수를 확인해주세요.");
		} else if(chkDate[idx].endDate < sdt) {
			alert("이벤트가 종료되었습니다.");
		}else if (!islogin()) {
			alert("로그인 후 응모 가능합니다");
			//Cmd_Login('event');
			location.href = "/mobilefirst/login/login.jsp?backUrl=/mobilefirst/evt/event_hitbrand201806.jsp?freetoken=event";
		} else {
			chkResult = true;
		}
		return chkResult;
	}
	function tabScroll(id){
		var tabId = $(id);
		var tabIdtop = tabId.offset().top;
		var tabIdHe = tabId.height();
		
		$(window).scroll(function(){
			
			if ($(this).scrollTop() >= tabIdtop) { 
				
				tabId.css({"position":"fixed"});
				tabId.css({"z-index":"10000"});
			} else {
				tabId.css({"position":"absolute"});
			}
		});
	}
 	function clickTFwd(clickUrl) {
 		//이베이 측 통계를 위해 단순 url 호출(이베이측 요청 - 테스트 페이지에서는 호출이 일어나면 안됨!)
 		/*
 		if(location.href.indexOf("local") > -1 || location.href.indexOf("dev") > -1 || location.href.indexOf("stagedev") > -1 || location.href.indexOf("my.") > -1){
 	        console.log("test-powerClickAnalysis()");
 		} else {
 		        var imgSrc = new Image();
 		        imgSrc.src = clickUrl;
 		}
 		*/
 		var imgSrc = new Image();
	        imgSrc.src = clickUrl;
 		
 	}
 	$.fn.randomize = function(selector){
 	    var $elems = selector ? $(this).find(selector) : $(this).children(),
 	        $parents = $elems.parent();

 	    $parents.each(function(){
 	        $(this).children(selector).sort(function(){
 	            return Math.round(Math.random()) - 0.5;
 	        // }). remove().appendTo(this); // 2014-05-24: Removed `random` but leaving for reference. See notes under 'ANOTHER EDIT'
 	        }).detach().appendTo(this);
 	    });
 	    return this;
 	};

	var goodsData = null ;

	//var d = new Date();
	//var nowDate = "";		// 현재 날짜
	//nowDate += d.getFullYear();
	//nowDate += (d.getMonth() < 9) ? "0"+ Number(d.getMonth() + 1) : Number(d.getMonth() + 1);
	//nowDate += ( d.getDate() < 9) ? "0"+ Number( d.getDate()) : Number(d.getDate());
	//nowDate = "20170707";
	
	var _selected = "";
	var layerTitle = "";
	
	//if(sdt == "")		sdt = nowDate;
	
	$(document).ready(function(){
		
		goodsLoading();
		eBayCpcSet();
		//이베이cpc 운영배포할때는 삭제
		//$(".powerad_wrap").remove();
		
		$("body").on('click', '.question dd label', function(event) {    

			$(".question dd label").removeClass("on");
			$(this).addClass("on");
			
			var inx = $(this).attr("data-id");
			
			if(inx == 1){
				$("#a1").attr("checked",true);
				$("#a2").attr("checked",false);
				$("#a3").attr("checked",false);
			}else if(inx == 2){
				$("#a1").attr("checked",false);
				$("#a2").attr("checked",true);
				$("#a3").attr("checked",false);
			}else if(inx == 3){
				$("#a1").attr("checked",false);
				$("#a2").attr("checked",false);
				$("#a3").attr("checked",true);
			}
			
	    });

		$(".tab_list li").click(function() {
			$(".tab_list li").removeClass("active");
			$(this).addClass("active");
			$(".tab_content").hide();
			var activeTab = $(this).find("a").attr("href");
			 $(activeTab).show();
			 
			 var cls = $(this).find("a").attr("class");
			 
			 if(cls.indexOf("tab1") > -1){

				 var ccnt = 0;
				 $("#tab1 > div > table > tbody > tr  td").each(function(i,v){
					 var vv = $(this).find("b").text();
					 if(vv.length > 0){
						 ccnt++;
					 }
				 });
				 
				 $(".btn.tab1").children().text("응모:"+ccnt+"일");
				 $("#tabDay2").text("12/26~1/9");
				 $("#tabDay3").text("1/10~1/24");
				 $("#tabDay4").text("1/25~1/31");
			 }else if(cls.indexOf("tab2") > -1){

				 var ccnt = 0;
				 $("#tab2 > div > table > tbody > tr  td").each(function(i,v){
					 var vv = $(this).find("b").text();
					 if(vv.length > 0){
						 ccnt++;
					 }
				 });
				 
				 $("#tabDay1").text("12/11~12/25");
				 $(".btn.tab2").children().text("응모:"+ccnt+"일");
				 $("#tabDay3").text("1/10~1/24");
				 $("#tabDay4").text("1/25~1/31");
			 }else if(cls.indexOf("tab3") > -1){

				 var ccnt = 0;
				 $("#tab3 > div > table > tbody > tr  td").each(function(i,v){
					 var vv = $(this).find("b").text();
					 if(vv.length > 0){
						 ccnt++;
					 }
				 });
				 
				 $("#tabDay1").text("12/11~12/25");
				 $("#tabDay2").text("12/26~1/9");
				 $(".btn.tab3").children().text("응모:"+ccnt+"일");
				 $("#tabDay4").text("1/25~1/31");
			 }
			 else if(cls.indexOf("tab4") > -1){
				 $("#tabDay1").text("12/11~12/25");
				 $("#tabDay2").text("12/26~1/9");
				 $("#tabDay3").text("1/10~1/24");
			 }
			 
			return false;
		});
		
		$("body").on('click', '.btn.layorange', function(event) {
		
			
			if(sdt < 20180723){
				alert("스페셜 경품전 응모 기간이 아닙니다.");
				return false;
			}
			
			
			var cls = $(".unchk2").attr("class");
			
			if(cls == "unchk2"){//체크 안함
				alert("개인정보 활용에 동의해주세요!");
			}else{
				
				try{
					
					var uphone = $("#p_numb").val();
					var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;//전화번호 체크
					
					if(!uphone || !regExp.test(uphone)){
						alert("휴대폰번호를 정확히 입력해주세요");
						$("#p_numb").focus();
						return false;
					}
					
					$(".prize_list > li").each(function(i,v){
						var cls = $(this).attr("class");
						if(cls == "chk"){
							_selected = (i+1);
						}
					});
					
					//getData("procCode=6&uphone="+uphone+"&selectItem="+_selected ,getBigItemIns);
					
					var goUrl = "/eventPlanZone/ajax/hitBrand201806_getData.jsp?procCode=6&uphone="+uphone+"&selectItem="+_selected+"&sdt="+sdt;
					
					$.ajax({
						type:"GET",
						url: goUrl,
						dataType: "JSON",
						async : true,
						success:function(jsonObj){
							
							if(jsonObj.response == "success"){
								alert("이벤트에 응모 되었습니다!");
								//closeLayer('Quiz2nd');
								//$("#bigItemCnt").text(getFunc("bigItemCnt"));// 대박경품전 응모권 갯수
								
								window.location.reload();
								
							}else if(jsonObj.response == "loginNeed"){
								alert("로그인 후 응모 가능합니다");
								//Cmd_Login('event');
								
								location.href = "/mobilefirst/login/login.jsp?backUrl=/mobilefirst/evt/event_hitbrand201806.jsp?freetoken=event";
								
							}else if(jsonObj.response == "overdue"){
								alert("이벤트 기간이 아닙니다");			
							}else if(jsonObj.response == "exceed"){
								alert("금일 응모기회를 모두 사용하셨습니다.\n내일 다시 응모해 주세요!");
								window.location.reload();
							}
							
							
						}
					});
					
				}catch(e){}
			}
		});
	});
	
	/**
	 * 이베이 cpc 
	 */
	 	function eBayCpcSet(){
			/*
	 		ID	매체코드	지면코드	URL	카테 코드
	 		enuri	enuricom	mobile_event_digital		0201,0232,0318,0363
	 		enuri	enuricom	mobile_event_appliances		0502,0602,2401,2406
	 		enuri	enuricom	mobile_event_computer		0402 , 0404 , 0405
	 		enuri	enuricom	mobile_event_life			0805 , 0908, 1644
	 		keyword="+카테고리코드+"
			isCate=LP
	 		*/
	 		var mCate = new Map();
	 		mCate.put("digital",["0201","0232","0318","0363"]);
	 		mCate.put("appliance",["0502","0602","2401","2406"]);
	 		mCate.put("computer",["0402","0404","0405"]);
	 		mCate.put("life",["0805","0908","1644"]);
	 		
	 		var cls = $(".menu > .on").attr("data-id");
	 		var cateinx = Math.floor(Math.random() * mCate.get(cls).length);
	 		var cate = shuffle(mCate.get(cls)[cateinx]);
	 		
			var params = "keyword="+cate+"&isCate=LP";
			
			$.ajax({
				type:"GET",
				url: "/ebayCpc/jsp/connectApi2.jsp",
				data:params,
				dataType: "JSON",
				success:function(result){
					
					var obj = new Array();
					
					if(result.sum_sort2.hasOwnProperty("first"))	obj = result.sum_sort2.first.items;
					else			obj = result.sum_sort2.second.items;
					
					var str = "";				
					$.each(obj, function(idx, val){
						var varRanUrl = "/move/Redirect.jsp?cmd=move_link&sb=F&pl_no="; //운영 : sb=F 로딩 이미지 안 보이도록 함.
						
						var varShopcode = val.shopcode;		//shopCode
						var varItemNo = val.item_no;		//goodsCode
						var varEplno = val.enuri_pl_no;		//plNo
						var varprice = val.enuri_price;		//에누리 가격

						var varImgS = val.imgS;				//작은 사이즈 이미지 주소
						var varimgL = val.imgL;				//큰 사이즈 이미지 주소

						var varIsAdult = val.is_adult;		//성인 여부

						var varSalePrice = val.sale_price;	//할인 금액
						var varSellPrice = val.sell_price;	//판매 금액

						var varImpT = val.imp_t;			//노출 체크를 위한 태그 정보
						var varClickT = val.clk_t;			//클릭 체크를 위한 태그 정보

						var varTitle = val.title;			//상품명
//							var varShippingFee = totalObj[i].shipping_fee;	//배송비

						var varImpPrice = 0;
						var varShipFeeTxt = "무료배송";
						var varShipClass ="deli_free";
						var varShopNm = "";

						var varLanding = val.landing;
						var varShippingFee = val.shipping_fee;
						
						var varOnClickT = " onclick=\"clickTFwd('" + varClickT + "');\"";

						//plno 있을 경우만 에누리 브릿지페이지로 넘김.
						if (varEplno > 0) varRanUrl = varRanUrl + varEplno;
						else 			  varRanUrl = varLanding;
						//성인여부 체크
						if (varIsAdult) {
							varimgL = "http://imgenuri.enuri.gscdn.com/images/home/thum_adult.gif";
							varImgS = "http://imgenuri.enuri.gscdn.com/images/home/thum_adult.gif";
						}
						//가격 정보 : 에누리 금액 -> 할인 금액 -> 판매 금액 순 노출
						if (varprice > 0) 		   varImpPrice = commaNum(String(varprice));
						else if (varSalePrice > 0) varImpPrice = commaNum(String(varSalePrice));
						else 					   varImpPrice = commaNum(String(varSellPrice));

						//배송비 노출 정책에 따른 로직 마켓별로 노출 Text 정책이 다름
						if (varShippingFee > 0) {
							if (varShopcode == "536") {	//G마켓
								varShipFeeTxt = "배송비"+ commaNum(String(varShippingFee));
								varShipClass ="deli plnoMoveLink";

							} else if (varShopcode == "4027") {	//옥션
								varShipFeeTxt = "조건부무료배송";
								varShipClass ="deli plnoMoveLink";
							}
						} else {
							varShipFeeTxt = "무료배송";
							varShipClass ="deli_free";
						}
						if (varShopcode == "536") varShopNm = "G마켓";
						if (varShopcode == "4027") varShopNm = "옥션";
						
						/*
						str += "<li>";
						str += "	<a href='" + varRanUrl + "' " + varOnClickT + " target='_blank;'>";
						str += "	<span class='ad'>AD</span>";
						str += "	<img src='" + varImgS + "' alt='' class='thum' onerror='" + varImpT + "'>";
						str += "	<strong class=''>" + varTitle + "</strong>";
						str += "	<div class='price'>" + varShopNm + "<span class='won'><em>" + varImpPrice + "</em>원</span></div>";
						str += "	</a>";
						str += "</li>";
						*/
						str += "<li>";
						str += "<a href='"+varLanding+"' "+varOnClickT+">";
						str += "	<span class='ad_ico'>AD</span>";
						
						str += "	<img src='" + varImgS + "' alt='' class='thumb' onerror='" + varimgL + "'>";
						//str += "	<img src=\"" + varImpT + "\"  style=\"display:none;\" />";	//노출 스크립트
						goImpT(varImpT);
						
						//str += "	<img src='"+varImgS+"' alt='' class='thumb' onerror='" + varImpT + "' />";
						str += "		<span class='info'>";
						str += "		<span class='delivery_info'>";
						str += "			<i class='i_delivery'>"+varShipFeeTxt+"</i>";
						str += "		</span>";
						str += "		<span class='brand shopbid_"+varShopcode+"'>"+varShopNm+"</span>";
						str += "		<span class='txt'>"+varTitle+"</span>";
						str += "		<span class='price'>";
						str += "			<em class='low'>최저가</em>";
						str += "			<em>"+varImpPrice+"</em>원";
						str += "		</span>";
						str += "	</span>";
						str += "</a>";
						str += "</li>";
						
					});// each
					$(".adProdList").empty().append(str);
					if(obj.length == 0){
						$(".powerad_wrap").remove();
						
					}
				},error: function(request,status,error){
					eBayCpcSet();
					console.log("function eBayCpcSet error...");
				}
			});
		}
 	//노출 log
 	function goImpT(adurl){
 	    if(location.href.indexOf("m.enuri.com") > -1 || location.href.indexOf("www.enuri.com") > -1){
 	        var imgSrc = new Image();
 	        imgSrc.src = adurl;
 	    } else { console.log("test-powerClickAnalysis()"); }
 	}

	function goodsLoading(){
	    var tabVal = $(".menu").find(".on").attr("data-id");
	    $("#sCon01").empty();
	    
	    if(goodsData){ //로딩한 후에는 재로딩 안한다.
	        var inJson = new Array();
	        $.each(goodsData , function(i,v){
	            if(v.tab == tabVal)	inJson.push(v);
	        });
	        $("#sCon01").html(getGoodsList(inJson));
	        $("#goodsTmp").randomize();
	        
	        tabLoading(goodsData , tabVal);
	        return false;
	    }
	    $.ajax({
	        type: "GET", 
	        url: "/mobilefirst/evt/ajax/ajax_hit_proc20171211.jsp",
	        async: true,
	        dataType:"JSON",   
	        success: function(json){
	                
	               var inJson = new Array();
	               $.each(json , function(i,v){
	                   if(v.tab == tabVal)	inJson.push(v);
	               });

	               $("#sCon01").html(getGoodsList(inJson));
	               $("#goodsTmp").randomize();
	               
	               tabLoading(json, tabVal);
	               goodsData = json;
	               
	           },complete : function(data) {
	           },error: function(x, o, e){
	        }
	    });   
	}
	function getGoodsList(data){
	    
	    var makeGoodsList = "<ul id='goodsTmp'>";
	    var part = '';
	    var ord = 0;
	    var cnt = data.length; 
	    
	    $.each(data , function(i,v){
	         
	        if( ord != 0 && ord != v.ord){
	            makeGoodsList += "</ul>";
	            makeGoodsList += "       </div>";
	            makeGoodsList += "   </div>";
	            makeGoodsList += "   </li>";
	        }
	        
	         if(v.ord == 1 && part != v.choice_part){
	             makeGoodsList += "<li>";
		         makeGoodsList += "<div class=\"planlist\">";
		         
		         var choicePart =  v.choice_part.replace(/-/gi , "");
		             choicePart	= choicePart.replace(/ /gi , "");
		         
				 makeGoodsList += "<h4><span id='"+choicePart+"'>"+v.choice_part+"</span></h4>"
				 makeGoodsList += "<ul class=\"plan_thum\">";
				 makeGoodsList += "       <li id='detail' data-id='"+v.modelno+"' data-bno='"+v.hit_brand_no+"' >";
				 makeGoodsList += "           <div class=\"detail\">";
				 makeGoodsList += "               <em class=\"md\">BEST</em>";
				 makeGoodsList += "               <div id=\"zoom_img\"><img src='http://storage.enuri.gscdn.com/pic_upload/exhibition/"+v.goods_image+"' class=\"thum\"></div>";
			     makeGoodsList += "	                <span class=\"com\"><img src='http://storage.enuri.gscdn.com/pic_upload/exhibition/"+v.brand_image+"' alt=''>"+v.brand+"</span>";
				 makeGoodsList += "               <strong class=\"tit\">"+v.modelname+"</strong>";
				 makeGoodsList += "               <span class=\"price\"><em>최저가</em><strong id='price'>"+commaNum(v.minprice3_mobile)+"</strong>원</span>";
				 makeGoodsList += "				  <button type=\"button\" class=\"sprite btnjoinquiz\" >퀴즈 정답 응모!</button>";
				 makeGoodsList += "           </div>";
				 makeGoodsList += "       </li>";
				 makeGoodsList += "   </ul>";
		         makeGoodsList += "     <div class=\"plan_list\">";
		         makeGoodsList += "        <ul>";
		         
		         makeGoodsList += "           <li class='on' data-ord=1 data-id='"+v.modelno+"' data-bno='"+v.hit_brand_no+"' data-name='"+v.modelname+"' data-money='"+commaNum(v.minprice3_mobile)+"'>";
	             makeGoodsList += "             <a href=\"javascript:///\"><img src='http://storage.enuri.gscdn.com/pic_upload/exhibition/"+v.goods_image+"'></a>";
	             makeGoodsList += "           </li>";
		         
	        }else  if(  part == v.choice_part  ){
	             makeGoodsList += "           <li data-id='"+v.modelno+"' data-bno='"+v.hit_brand_no+"'  data-name='"+v.modelname+"' data-money='"+commaNum(v.minprice3_mobile)+"'>";
	             makeGoodsList += "             <a href=\"javascript:///\"><img src='http://storage.enuri.gscdn.com/pic_upload/exhibition/"+v.goods_image+"'></a>";
	             makeGoodsList += "           </li>";
	        }
	        if(cnt == i+1){
	            makeGoodsList += "          </ul>";
	            makeGoodsList += "       </div>";
	            makeGoodsList += "   </div>";
	            makeGoodsList += "   </li>";
	        }
	        
	        part = v.choice_part;
	        ord = v.ord+1;
	        
	    });
	    makeGoodsList += "</ul>";
	    return makeGoodsList;
	}
	function tabLoading(json,tabVal){
	    
	    $(".newgnb").empty();
	    $(".submenu > ul").empty();
	    
	    var tempPart = "";
	    
	    $.each(json, function(i, v){
	        if(tabVal == v.tab){
	            if(tempPart  != v.choice_part){
	                $(".newgnb").append("<li><a href='javascript:///'>"+v.choice_part+"</li>");
	                $(".submenu > ul").append("<li><a href='javascript:///'>"+v.choice_part+"</li>");
	            }
	            tempPart = v.choice_part;
	        }
	    });
	}
	function goDetail(modelno){
		window.open("/mobilefirst/detail.jsp?modelno="+modelno);
		return false;
	}
	function goClose(){
		ga('send', 'event', '2018히트브랜드' ,'button', '2018하반기히트브랜드_퀴즈레이어닫기');
		$('#quizLayer').hide();
		return false;
	}
	function replaceTxt(txt){
		var txt = txt.replace(/\n/ig, '<br>');
		return txt;
	}
	function hitbrandLogPC(uniqueCode, logFlag, device){
		// 히트브랜드 logFlag = H
		var url = "/mobilefirst/event2016/ajax/ajax_click_proc.jsp";
		var params = "uniqueCode=" + uniqueCode + "&logFlag=" + logFlag + "&device=" + device;
		$.post(url,params);
	}
	function islogin() {
		
		var cName = "LSTATUS";
		var s = document.cookie.indexOf(cName +'=');
		if (s != -1){
			s += cName.length + 1;
			e = document.cookie.indexOf(';',s);
			if (e == -1){
				e 	= document.cookie.length;
			}
			if( unescape(document.cookie.substring(s,e))=="Y"){
				
				try {
					if(window.android){
							window.android.isLogin("true");
					}
				} catch(e) {}
				return true;
			}else{
				try {
					if(window.android){
						window.android.isLogin("false");
					}
				} catch(e) {}
				return false;
			}
		}else{
			try {
				if(window.android){
					window.android.isLogin("false");
				}	
			} catch(e) {}
			return false;
		}
	}
	/**
	 * 자바스크립트에서 사용할 Map 
	 */
	Map = function(){ 		 this.map = new Object();	}   
	Map.prototype = {   
	    put : function(key, value){   	        this.map[key] = value;	    },   
	    get : function(key){   	        return this.map[key];	    },
	    containsKey : function(key){    	     return key in this.map;	    },
	    containsValue : function(value){    	     for(var prop in this.map){	      if(this.map[prop] == value) return true;	     }	     return false;	    },
	    isEmpty : function(key){    	     return (this.size() == 0);	    },
	    clear : function(){   	     for(var prop in this.map){	      delete this.map[prop];	     }
	    },	    remove : function(key){	     delete this.map[key];	    },
	    keys : function(){   	        var keys = new Array();	        for(var prop in this.map){            keys.push(prop);	        }	        return keys;	    },
	    values : function(){	     var values = new Array();	        for(var prop in this.map){	         values.push(this.map[prop]);     }	        return values;	    },
	    size : function(){	      var count = 0;	      for (var prop in this.map) {	        count++;	      }	      return count;	    }
	};
</script>
</body>
</html>
<script type="text/javascript" src="http://imgenuri.enuri.gscdn.com/common/js/Log_Tail_Mobile.js"></script>