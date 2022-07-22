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
	response.sendRedirect("/eventPlanZone/jsp/HitBrand_201812.jsp");
	return;
}

String EVENTID="20180612";

String sdt = ChkNull.chkStr(request.getParameter("sdt"),"");
String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));

if("".equals(sdt) ){
	String nowDate = DateStr.nowStr();
	nowDate = StringUtils.replace(nowDate, "-", "");
	sdt = nowDate;
}
//String nowDate = DateStr.nowStr();
//nowDate = StringUtils.replace(nowDate, "-", "");
//sdt = nowDate; 
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
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/hit_2018dec_m.css?v=201811262"/>
	<link rel="stylesheet" type="text/css" href="http://m.enuri.com/mobilefirst/css/lib/slick.css">
</head>
<body>
<div class="wrap">
	<a href="javascript:///" class="win_close">창닫기</a> 
	<!-- 메인비주얼 -->
	<div class="inner">
		<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_visual.jpg" alt="2018 에누리 히트브랜드" class="imgs">
		<div class="blind">
			<h1>2018 에누리 히트브랜드</h1>
			<p>2018년 12월 17일부터 2019년 1월 30일까지</p>
		</div>
	</div>
<div class="event event__wrap">
		<div class="inner">
			<!-- OX 빙고 영역 -->
			<div class="bingobox">				
				<span class="bgicon bgicon-1">십자가형태</span>
				<span class="bgicon bgicon-2">원형태</span>
				
				<!-- INNER -->
				<div class="inner">				
					<div class="bingo__tit">
						<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_bingo_tit.jpg" alt="">
						<h2 class="blind">OX 퀴즈 BINGO - !</h2>
						<p class="blind">한 줄만 완성해도 매일 5분께 e머니 3000점! BINGO 완성 횟수에 따라 응모권 받고 스페셜 경품에 도전해보세요.</p>
					</div>
					<div class="bingo__table">
						<div class="bingo__head">
							<h3 class="tit">OX BINGO</h3>
							<div class="count">오늘 응모권 : <span class="numb" id="bingoCnt">0장</span></div>
						</div>
						<!-- 
							빙고 각 케이스 이미지명 변경
							default : m_bingo_mark.png
							O : m_bingo_mark-o.png
							X : m_bingo_mark-x.png
						-->
						<!-- <ul class="bingo__list">
							<li class="bingo-o"><a href="#"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_bingo_mark-o.png" alt="O" /></a></li>
							<li class="bingo-x"><a href="#"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_bingo_mark-x.png" alt="X" /></a></li>
							<li><a href="#"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_bingo_mark.png" alt="default" /></a></li>
							<li><a href="#"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_bingo_mark.png" alt="default" /></a></li>
							<li><a href="#"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_bingo_mark.png" alt="default" /></a></li>
							<li><a href="#"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_bingo_mark.png" alt="default" /></a></li>
							<li><a href="#"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_bingo_mark.png" alt="default" /></a></li>
							<li><a href="#"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_bingo_mark.png" alt="default" /></a></li>
							<li><a href="#"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_bingo_mark.png" alt="default" /></a></li>
						</ul> -->
						
						<!-- 
							빙고 각 케이스 클래스명 변경
							default : <li>
							O : <li class="bingo-o">
							X : <li class="bingo-x">
						-->
						<ul class="bingo__list is-bg">
							<li><button type="button" id="bingo1">1</button></li>
							<li><button type="button" id="bingo2">2</button></li>
							<li><button type="button" id="bingo3">3</button></li>
							<li><button type="button" id="bingo4">4</button></li>
							<li><button type="button" id="bingo5">5</button></li>
							<li><button type="button" id="bingo6">6</button></li>
							<li><button type="button" id="bingo7">7</button></li>
							<li><button type="button" id="bingo8">8</button></li>
							<li><button type="button" id="bingo9">9</button></li>
						</ul>
					</div>
				</div>
				<!-- //INNER -->
			</div>
			<!-- //OX 빙고 영역 -->
			
			<!-- 스페셜 경품 응모 영역 -->
			<div class="specialgiftbox">
				<span class="bgicon bgicon-3">마름모꼴형태</span>
				
				<div class="inner">
					<div class="specialgift__cont">
						<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_specialgift_info.jpg" alt="">
						<h2 class="blind">스페셜 경품 응모하기</h2>
						<p class="blind">BINGO 완성 횟수에 따라 획득하신 응모권으로 원하시는 경품에 응모하세요!</p>
						<ul class="blind">
							<li>이벤트 기간 : 2018년 12월 17일부터 2019년 1월 30일까지</li>
							<li>당첨자 발표 : 2019년 2월 1일</li>
						</ul>
						<a href="javascript:///" class="btn__join" >
							<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_specialgift_btn-join.jpg" alt="응모하기">
						</a>
						<a href="javascript:///" class="btn__my" onclick="$('#giveaway').show(); return false;">
							<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_specialgift_btn-my.jpg" alt="나의 응모 현황">
						</a>
					</div>
				</div>
			</div>
			<!-- //스페셜 경품 응모 영역 -->
			
			<!-- 이벤트 참여방법&유의사항 -->
			<div class="btn__group">
				<a href="javascript:///" class="btn__info" onclick="$('#joinExplainLayer').show(); return false"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_event_btn-info.jpg" alt="이벤트 참여방법"></a>
				<a href="javascript:///" class="btn__caution" onclick="$('#note').show(); return false;"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_event_btn-caution.jpg" alt="이벤트 유의사항"></a>
				
				<!-- 유의사항 레이어 -->
				<div id="note" class="caution_layer" style="display: none;">
					<div class="backdim"></div>
					<div class="appLayer">
						<h4>이벤트 유의사항</h4>
						<a href="javascript:///" class="close" onclick="$('#note').hide();">창닫기</a>
						
						<div class="layercont">
							<div class="txt">
								<strong class="top">당첨 안내</strong>
					
								<ol>
									<li>
										<strong>1. 일일 참여상</strong>
										<ul class="txt_indent">
											<li>선정방법: 매일 퀴즈 정답자 중 5분을 추첨하여 e머니 증정</li>
											<li>하루 5분에게 <span class="under">e머니 3,000점 지급</span>됩니다.<br>'e머니스토어'에서 교환 후 사용해 주세요.</li> 
											<li>당첨자발표: 차주 월요일에 전주 당첨자 일괄 발표<br>[에누리 고객센터 및 에누리 가격비교 APP&gt;당첨자발표]</li>
											<li>e머니 지급: 발표일 당일 지급</li>
											<li>e머니 유효기간: <b>적립일로부터 30일</b></li>
											<li>중복당첨은 가능하나, <span class="under">최대 3회</span>로 제한됩니다.</li>
										</ul>
									</li>
									<li>			
										<strong>2. 스페셜 경품 응모</strong>
										<ul class="txt_indent">
											<li>선정방법: 
												<ul>
													<li>- 히트브랜드 관련 OX퀴즈로 BINGO 완성시 마다 획득한 응모권으로 스페셜 경품전 응모</li>
													<li>- 각 경품에 응모 시 지정된 수량의 응모권 소진</li>
													<li>- 응모권이 모두 소진될 때까지 언제든 상시 중복 응모 가능</li>
												</ul>
											</li>
											<li>당첨자발표: <b>2019년 2월 1일</b><br>[에누리 고객센터 및 에누리 가격비교 APP&gt;당첨자발표]</li>
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
				<!-- //유의사항 레이어 -->
			</div>
			<!-- //이벤트 참여방법&유의사항 -->
		</div>
	</div>
	
	<div class="tabList">
		<!-- tab -->
		<div class="tabBt">
			<ul class="menu">
				<li class="on" data-id="digital"><a href="javascript:///">디지털</a></li>
                <li data-id="appliance" ><a href="javascript:///">가전</a></li>
                <li data-id="computer" ><a href="javascript:///">컴퓨터</a></li>
                <li data-id="life"><a href="javascript:///">라이프</a></li>
                <li data-id="fashion"><a href="javascript:///">패션</a></li>
			</ul>
			<nav class="m_top">
				<div class="gnbarea">
					<ul class="newgnb"></ul>
				</div>
				<div class="submenu">
					<span class="grd_next"></span>
					<span class="sh"></span>
					<ul></ul>
					<div class="submenu__close"><button type="button" id="closeSubmenu">X</button></div>
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

<div id="Quiz2nd" class="dim" style="display: none;">
	<div class="appLayer">
		<h4>경품 응모</h4>
		<a href="javascript:///" class="close" onclick="$('#Quiz2nd').hide();">창닫기</a>

		<div class="layercont">
			<!-- popup_box -->
			<div class="join_area">
				<div class="select_prize">
					<p class="info">아래 경품 중 원하시는 경품 하나를 선택하시면 <strong>각 경품별로 1명씩 추첨하여</strong> 선택하신 경품을 드립니다.</p>
					
					<div class="ticketbox">
						<p class="user">현재 응모권수 : <strong id="totalCnt"><span>0</span> 장</strong></p>
					</div>
					<ul class="prize_list">
						<!-- 체크한 상품 li.chk 추가 -->
						<li class="chk">
							<input type="radio" id="opt1" class="p_rdo" name="opt" value="" checked="checked"> 
							<label for="opt1">
								<span class="thumb"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_prize_img1.jpg" alt=""></span>
								<p class="proname">LG전자 건조기 <strong>응모권 100장</strong></p>
							</label>
						</li>
						<li>
							<input type="radio" id="opt2" class="p_rdo" name="opt" value=""> 
							<label for="opt2">
								<span class="thumb"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_prize_img2.jpg" alt=""></span>
								<p class="proname">삼성전자 갤럭시탭 <strong>응모권 50장</strong></p>
							</label>
						</li>
						<li>
							<input type="radio" id="opt3" class="p_rdo" name="opt" value=""> 
							<label for="opt3">
								<span class="thumb"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_prize_img3.jpg" alt=""></span>
								<p class="proname">쿨샤 전동칫솔 <strong>응모권 20장</strong></p>
							</label>
						</li>
					</ul>
				</div>
				<div class="agreebox">
					<p class="tit">당첨 시 경품 발송 안내를 위한 연락처를 넣어주세요.</p>
					<div class="input_num">
						<label for="p_numb">연락처</label><input type="tel" id="p_numb" name="" onfocus="this.value='';" value="(-) 없이 입력하세요.">
					</div>
					<div class="info_agree">
						<span class="unchk2" onclick="agreechk(this);"><input type="checkbox" id="" name="" value="N">개인정보 활용에 동의합니다.</span><a href="javascript:///" class="btn_detail" onclick="$('#Personinfo').show(); return false">자세히 보기</a>
					</div>
				</div>
				<div class="btn__group">
					<a class="btn layjoin" href ="javascript:///">응모하기</a>
					<a class="btn layclose" onclick="$('#Quiz2nd').hide(); return false">취소</a>
				</div>
			</div>
			<!-- //popup_box -->
		</div>
	</div>
</div>

<!-- 개인 정보 수집 / 이용안내 레이어 -->
<div id="Personinfo" class="dim" style="display:none;">
	<div class="appLayer">
		<h4>개인 정보 수집 / 이용안내</h4>
		
		<div class="layercont">
			<div class="personinfo">
				<div class="box">
					<p class="title">에누리 가격비교는 이벤트 참여확인 및 경품 발송을 위하여 아래와 같이 개인정보를 수집하고 있습니다.</p>
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
		</div>
	</div>
</div>
<!-- //개인 정보 수집 / 이용안내 레이어 -->


<div id="joinExplainLayer" class="explain_layer" style="display: none;">
	<div class="backdim"></div>
	<div class="appLayer">
		<h4>이벤트 참여 방법</h4>
		<a href="javascript:///" class="close" onclick="$('#joinExplainLayer').hide();">창닫기</a>
		
		<div class="layercont">
			<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_explain_img.jpg" alt="">
			
			<p class="btn_close"><button type="button" onclick="$('#joinExplainLayer').hide();">확인</button></p>
		</div>
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
						<a href="javascript:///" class="btn layblack col" onclick="javascript:goIncorrect()">닫기</a>
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
<div id="OXquiz" class="dim" style="display:none">
	<!-- popup_box -->
	<div class="appLayer quiz">
		<h4>히트브랜드 OX 퀴즈 BINGO</h4>
		<a href="javascript:///" class="close" onclick="$('#OXquiz').hide();">창닫기</a>
		
		<div class="layercont">
			<div class="quiz_box">
				<p id="quizText"></p>
			</div>
			
			<ul class="choice_box">
				<li><button type="button" id="btnO" ><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_oxselect_o.jpg" alt="O"></button></li>
				<li><button type="button" id="btnX" ><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hitbrand_dec/m_oxselect_x.jpg" alt="X"></button></li>
			</ul>
			
			<p class="btn_close" id="goHint"><button type="button">힌트보기</button></p>
			
		</div>
	</div>
	<!-- //popup_box -->
</div>

<div id="giveaway" class="dim" style="display:none">
	<!-- popup_box -->
	<div class="appLayer mycheck">
		<h4>나의 경품 응모현황</h4>
		<a href="javascript:///" class="close" onclick="$('#giveaway').hide();">창닫기</a>
		
		<div class="layercont">
			<p class="tit">응모권 현황</p>
			<div class="mycheck_box">
				<ul>
					<li class="get">
						<strong>획득 응모권 수 </strong><em id="totalTicket">0</em>
					</li>
					<li class="remain">
						<strong>남은 응모권 수 </strong><em id="availableTicket" >0</em>
					</li>
				</ul>
			</div>
			<p class="tit">응모내역</p>
			<div class="detail_box">
					<div class="used">
						<strong>사용 응모권 수 </strong><em id="useTicket">0</em>
					</div>
					<div class="detail_view">
						<table>
							<colgroup>
								<col class="col1">
								<col class="col2">
								<col class="col3">
								<col class="col4">
							</colgroup>
							<tbody id="ticketTable"></tbody>
						</table>
					</div>
				
			</div>
			<p class="btn_close"><button type="button" onclick="$('#giveaway').hide();">닫기</button></p>
		</div>
	</div>
	<!-- //popup_box -->
</div>

</div>
<!-- 푸터 -->
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<!--// 푸터 -->
<script type="text/javascript">
var ord = 1;

sdt = "<%=sdt%>"; 

$(document).ready(function(){
	
    if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        ga('send', 'pageview', {'page': '/mobilefirst/evt/event_hitbrand201812.jsp', 'title': '201812히트브랜드  pv_iphone'});
    }else if(navigator.userAgent.indexOf("Android") > -1){
       ga('send', 'pageview',  {'page': '/mobilefirst/evt/event_hitbrand201812.jsp',  'title': '201812히트브랜드  pv_android'});
    }
    $(".win_close").click(function(){
        if(getCookie("appYN") == 'Y')	window.location.href = "close://";
        else				            window.location.replace("/mobilefirst/index.jsp");
    });
	
    $(".prize_list li").click(function(e){
		$(".prize_list li").removeClass("chk");
		$(this).addClass("chk");
		return false;
	});
    $(".bingo__list.is-bg > li ").click(function(){
    	if(!evtCommonChk (2)) {
    		return false;
    	}
    	
    	ga('send', 'event', '2018히트브랜드' ,'button', '2018하반기히트브랜드_퀴즈응모');
    	
    	if( $(this).hasClass("bingo-o") || $(this).hasClass("bingo-x") ){
    		 alert("퀴즈완료");
    	}else{
    		var inx = $(this).index();
        	goQuiz(inx+1); //li inx 는 0 부터 시작이라서 +1 해준다
    	}
    });
    
    $(".choice_box > li > button").click(function(){
    	var num = $(this).attr("data-num");
    	var btox = $(this).attr("id");
    	
    	var ox = "";
    	
    	if(btox == "btnO")  ox = "O";
    	else	    		ox = "X";
    	
    	goAnswer(num,ox);
    	$("#OXquiz").hide();
    });
    $(".btn__join").click(function(){
    	
    	if(!evtCommonChk (2))	return false;
    	goBingoTotalCnt();
    	$('#Quiz2nd').show(); 
    	return false;
    });
    
    $("#closeSubmenu").click(function(){		$(".submenu").removeClass("on");	});
    
    //나의응모현황
    $(".btn__my").click(function(){
    	
    	var gourl = "/eventPlanZone/ajax/hitBrand201812_getData.jsp?procCode=7&sdt="+sdt;
    	
    	$.ajax({
    		type:"GET",
    		url: gourl,
    		dataType: "JSON",
    		async : true,
    		success:function(data){
    			$("#totalTicket").text(data.totalTicket);
    			$("#availableTicket").text(data.availableTicket);
    			$("#useTicket").html(data.ticketList.useTicket);
    			
    			var tableHtml = "";
    			
    			$.each(data.ticketList.ticketList,function(i,v){
    				tableHtml += "<tr>";
   					tableHtml +="<th>"+(i+1)+"</th>";
   					tableHtml +="<td>"+v.ins_date+"</td>";
   					
   					if	   (v.select_seq ==1 )	tableHtml +="<td>LG 건조기</td>";  	  				
    				else if(v.select_seq ==2 )	tableHtml +="<td>삼성전자 갤럭시탭</td>";
    				else if(v.select_seq ==3 )	tableHtml +="<td>쿨샤 전동칫솔</td>";
   					
   					tableHtml +="<td>"+v.ticket+"</td>";
   					tableHtml +="</tr>";
   					
    			});
    			$("#ticketTable").html(tableHtml);
    			
    			ga('send', 'event', '2018히트브랜드' ,'button', '2018하반기히트브랜드_응모현황');
    			
    		}
    	});
    	$('#giveaway').show();
	});
    getBingo();
});
function goBingoTotalCnt(){
	var gourl = "/eventPlanZone/ajax/hitBrand201812_getData.jsp?procCode=7&sdt="+sdt;
	
	$.ajax({
		type:"GET",
		url: gourl,
		dataType: "JSON",
		async : true,
		success:function(data){
			$("#totalCnt > span").text(data.availableTicket);
		}
	});
}
function goQuiz(num){
	
	var gourl = "/eventPlanZone/ajax/hitBrand201812_getData.jsp?procCode=2&sdt="+sdt+"&num="+num;
	$.ajax({
		type:"GET",
		url: gourl,
		dataType: "JSON",
		async : true,
		success:function(data){
			$("#OXquiz").show();
			$("#quizText").text(data.response.quiz);
			
			$("#btnO").attr("data-num",num);
			$("#btnX").attr("data-num",num);
			$("#goHint").html("<button type=\"button\" onclick=\"goHint("+data.response.hint+")\">힌트보기</button>");
			
			ga('send', 'event', '2018히트브랜드' ,'button', '2018하반기히트브랜드_응모하기');
		}
	});
}
function getBingo(){
	
	var gourl = "/eventPlanZone/ajax/hitBrand201812_getData.jsp?procCode=5&sdt="+sdt;
	
	$.ajax({
		type:"GET",
		url: gourl,
		dataType: "JSON",
		async : true,
		success:function(data){
			$("#bingoCnt").text(data.bingGoCnt+"장"); //응모권
			$.each(data.bingGoList,function(i,v){
				if(v.WIN == 'Y') $("#bingo"+v.NUM).parent().addClass("bingo-o");
				else			 $("#bingo"+v.NUM).parent().addClass("bingo-x");
			});
		}
	});
}
function goHint(modelno){
	ga('send', 'event', '2018히트브랜드' ,'button', '2018하반기히트브랜드_힌트보기');
	window.open("/mobilefirst/detail.jsp?modelno="+modelno);
	return false;
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
            var url = $(this).parent().attr("data-url");
            
            if(ord == 1)     $(this).parent().parent().parent().parent().find(".md").show();
            else                $(this).parent().parent().parent().parent().find(".md").hide();
            
            $(this).parent().parent().parent().parent().find(".tit").text(modelnm);
            $(this).parent().parent().parent().parent().find("#price").text(price);
            $(this).parent().parent().parent().parent().parent().find("#detail").attr("data-id",modelno);
            $(this).parent().parent().parent().parent().parent().find("#detail").attr("data-url",url);
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
            var url = $(this).attr("data-url");
        	
            hitbrandLogPC(bno , 'H' , 'M');
            
            ga('send', 'event', '2018히트브랜드' ,'goods', modelno);
            
            if(url != ""){
            	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
            		window.open("http://"+url+"&freetoken=outlink");
            	}else{
            		window.open("http://"+url);	
            	}
            }else{
            	location.href = "/mobilefirst/detail.jsp?modelno="+modelno;	
            }
        });
		tabScroll(".tabBt");
	});
	
	function goAnswer(pnum,pOx) {
		
		hitProc({procCode : 1, num : pnum, ox : pOx  }, function(data){
			
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
	    //if(location.host.indexOf("dev.enuri.com") > -1){
		param.sdt = sdt;
		//}
		$.getJSON("/eventPlanZone/ajax/hitBrand201812_getData.jsp", param ,callback)
		.done(function(){
			isClick = true;
		});
	}
	//이벤트 공통체크로직
	function evtCommonChk (procCode) {
		var chkResult = false;
		// 매일 히트상품, 스페셜경품전 이벤트 기간
		var chkDate = [
			{	"startDate" : 20181217,	"endDate" : 20190130	}
		];
		
		if(Number(sdt) < chkDate[0].startDate) {
			alert("이벤트 기간이 아닙니다.");
		} else if(chkDate[0].endDate < sdt) {
			alert("이벤트가 종료되었습니다.");
		}else if (!islogin()) {
			alert("로그인 후 응모 가능합니다");
			//Cmd_Login('event');
			location.href = "/mobilefirst/login/login.jsp?backUrl=/mobilefirst/evt/event_hitbrand201812.jsp?freetoken=event";
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
 		
 		if(location.href.indexOf("local") > -1 || location.href.indexOf("dev") > -1 || location.href.indexOf("stagedev") > -1 || location.href.indexOf("my.") > -1){
 	        console.log("test-powerClickAnalysis()");
 		} else {
 		        var imgSrc = new Image();
 		        imgSrc.src = clickUrl;
 		}
 		
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
	var _selected = "";
	var layerTitle = "";
	
	$(document).ready(function(){
		
		goodsLoading();
		eBayCpcSet();
		//이베이cpc 운영배포할때는 삭제
		//$(".powerad_wrap").remove();

		$(".tab_list li").click(function() {
			$(".tab_list li").removeClass("active");
			$(this).addClass("active");
			$(".tab_content").hide();
			var activeTab = $(this).find("a").attr("href");
			 $(activeTab).show();
			 
			 //var cls = $(this).find("a").attr("class");
			return false;
		});
		
		$("body").on('click', '.btn.layjoin', function(event) {
			
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
					
					var goUrl = "/eventPlanZone/ajax/hitBrand201812_getData.jsp?procCode=6&uphone="+uphone+"&selectItem="+_selected+"&sdt="+sdt;
					
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
							}else if(jsonObj.response == "MissingPoint"){
								alert("응모권이 부족합니다.");
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
	 		mCate.put("fashion",["0805","0908","1644"]);
	 		
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
					//eBayCpcSet();
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
				 makeGoodsList += "       <li id='detail' data-id='"+v.modelno+"' data-bno='"+v.hit_brand_no+"' data-url='"+v.url+"'  >";
				 makeGoodsList += "           <div class=\"detail\">";
				 makeGoodsList += "               <em class=\"md\">BEST</em>";
				 if( v.goods_image.indexOf("http:") > -1 ){
				 makeGoodsList += "               <div id=\"zoom_img\"><img src='"+v.goods_image+"' class=\"thum\"></div>";
				 }else{
				 makeGoodsList += "               <div id=\"zoom_img\"><img src='http://storage.enuri.gscdn.com/pic_upload/exhibition/"+v.goods_image+"' class=\"thum\"></div>";	 
				 }
				 
			     makeGoodsList += "	                <span class=\"com\"><img src='http://storage.enuri.gscdn.com/pic_upload/exhibition/"+v.brand_image+"' alt=''>"+v.brand+"</span>";
				 makeGoodsList += "               <strong class=\"tit\">"+v.modelname+"</strong>";
				 if(v.gd_prc != ""){
					 makeGoodsList += "               <span class=\"price\"><em>최저가</em><strong id='price'>"+commaNum(v.gd_prc)+"</strong>원</span>";	 
				 }else{
					 makeGoodsList += "               <span class=\"price\"><em>최저가</em><strong id='price'>"+commaNum(v.minprice3_mobile)+"</strong>원</span>";
				 }
				 
				 makeGoodsList += "           </div>";
				 makeGoodsList += "       </li>";
				 makeGoodsList += "   </ul>";
				 
		         makeGoodsList += "     <div class=\"plan_list\">";
		         makeGoodsList += "        <ul>";
		         
		         var price = "";
		         
		         if(v.gd_prc != "")	 price = commaNum(v.gd_prc);
				 else				 price = commaNum(v.minprice3_mobile);
		         
		         makeGoodsList += "           <li class='on' data-ord=1 data-id='"+v.modelno+"' data-bno='"+v.hit_brand_no+"' data-name='"+v.modelname+"' data-money='"+price+"'  data-url='"+v.url+"' >";
	             makeGoodsList += "             <a href=\"javascript:///\">";
	             
	             var goodsimg = v.goods_image;
	             
	             if( goodsimg.indexOf("http:") > -1 ){
	            	 makeGoodsList += "					<img src='"+v.goods_image+"'>";	 
	             }else{
	            	 makeGoodsList += "					<img src='http://storage.enuri.gscdn.com/pic_upload/exhibition/"+v.goods_image+"'>";
	             }
	             
	             makeGoodsList += "				</a>";
	             makeGoodsList += "           </li>";
		         
	        }else  if(  part == v.choice_part  ){
	        	
	        	 var price = "";
		         
		         if(v.gd_prc != "")	 price = commaNum(v.gd_prc);
				 else				 price = commaNum(v.minprice3_mobile);
	        	
	             makeGoodsList += "           <li data-id='"+v.modelno+"' data-bno='"+v.hit_brand_no+"'  data-name='"+v.modelname+"' data-money='"+price+"'  data-url='"+v.url+"' >";
	             makeGoodsList += "             <a href=\"javascript:///\">";
	             
	             if( v.goods_image.indexOf("http:") > -1 ){
	            	 makeGoodsList += "					<img src='"+v.goods_image+"'>";	 
	             }else{
	            	 makeGoodsList += "					<img src='http://storage.enuri.gscdn.com/pic_upload/exhibition/"+v.goods_image+"'>";
	             }
	             
	             makeGoodsList += "				</a>";
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
	    	if(i == 0){
	    		var title = "";
	    		if(tabVal == "digital")			title="디지털 부문별";
	    		else if(tabVal == "appliance")	title="가전 부문별";
	    		else if(tabVal == "computer")	title="컴퓨터 부문별";
	    		else if(tabVal == "life")		title="라이프 부문별";
	    		else if(tabVal == "fashion")	title="패션 부문별";
	    		
				$(".submenu > ul").append("<li class=\"cate\"><a href='javascript:///'>"+title+"</a></li>");
			}
	    	
	        if(tabVal == v.tab){
	            if(tempPart  != v.choice_part){
	                $(".newgnb").append("<li><a href='javascript:///'>"+v.choice_part+"</li>");
	                $(".submenu > ul").append("<li><a href='javascript:///'>"+v.choice_part+"</li>");
	            }
	            tempPart = v.choice_part;
	        }
	    });
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
	function goSocces(){
		$('#Aswmsg1').hide();
		getBingo();
		return false;
	}
	function goIncorrect(){
		$('#Aswmsg2').hide();
		getBingo();
		return false;
	}
	/*checkbox - 라디오*/
	function radiochk(obj){
		if (obj.className== 'unchk') obj.className = 'chk';
		else 						 obj.className = 'unchk';
	}	
	/*checkbox - 네모*/
	function agreechk(obj){
		if (obj.className== 'unchk2') 	obj.className = 'chk2';
		else 							obj.className = 'unchk2';
	}
</script>
</body>
</html>
<script type="text/javascript" src="http://imgenuri.enuri.gscdn.com/common/js/Log_Tail_Mobile.js"></script>