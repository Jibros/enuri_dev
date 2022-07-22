<%@ page contentType="text/html; charset=utf-8" %>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data" %>
<%@ page import="com.enuri.bean.knowbox.Members_Proc" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>

<%
//pc면 pc로 센딩
if(
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Linux") >= 0 ) ||
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0)){
}else{
	response.sendRedirect("/eventPlanZone/jsp/HitBrand_202106.jsp");
	return;
}
String event_id="2020112401";

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
	<meta property="og:title" content="에누리 가격비교" />
	<meta property="og:description" content="에누리 모바일 가격비교" />
	<meta property="og:image" content="http://img.enuri.info/images/mobilenew/images/logo_enuri.png" />
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="http://m.enuri.com/mobilefirst/css/lib/slick.css">
	<!-- 프로모션 공통 CSS (Mobile) -->
	<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
	<!-- 프로모션별 커스텀 CSS  -->
	<link rel="stylesheet" type="text/css" href="/css/event/y2021_rev/hit_jun_m.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/event_regular.js?v=2018072301"></script>
	<script src="/mobilefirst/js/utils.js"></script>
	<script src="/mobilefirst/js/lib/ga.js"></script>
</head>

<body>

<div class="wrap">

	<a href="javascript:void(0);" class="win_close">창닫기</a>
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>

	<!-- 메인비주얼 -->
    <div class="visual">
		<div class="inner">
		</div>
	</div>

	<!-- 이벤트 영역 -->
	<div class="event event__wrap">
		<div class="inner">
			<!-- 슬롯머신 게임 + 응모 -->
			<div class="slotm">
				<!-- INNER -->
				<div class="inner">
					<h3>
						<em class="blind">히트브랜드 잭팟</em>
						<span class="blind">
							매일 출석으로 응모권 1개 / 매일 e머니로 응모권 최대 5회 교환<br/>
							획득한 코인으로 스페셜 경품에 도전해 보세요!
						</span>
					</h3>
					<!-- 응모권 갯수 노출 -->
					<div id="ticketarea" class="tx_total">
						히트브랜드 잭팟<span class="tx_dv">|</span><em>응모권 : <span class="num_ticket">0</span>장</em>
					</div>
					<!-- // -->
					<div id="slotarea" class="slotm_game">
						<h4>HIT 슬롯머신</h4>
						<div class="slotm_wrap">
							<!-- 현재 누적 e머니 -->
							<span class="tx_emoney">
								<span class="tx_emoney_tit">현재 누적 e머니 : </span><em></em>원
							</span>
							<!-- // -->
							<div class="mask"></div>
							<div class="slotm_con">
								<div class="box">
									<ul>
										<li class="slot_item_1">1</li>
										<li class="slot_item_2">2</li>
										<li class="slot_item_3">3</li>
										<li class="slot_item_4">4</li>
										<li class="slot_item_5">5</li>
										<li class="slot_item_6">6</li>
										<li class="slot_item_7">7</li>
										<li class="slot_item_8">8</li>
										<li class="slot_item_9">9</li>
										<li class="slot_item_10">10</li>
										<li class="slot_item_11">11</li>
										<li class="slot_item_12">12</li>
										<li class="slot_item_13">13</li>
										<li class="slot_item_14">14</li>
										<li class="slot_item_15">15</li>
										<li class="slot_item_16">16</li>
										<li class="slot_item_17">17</li>
										<li class="slot_item_18">18</li>
										<li class="slot_item_19">19</li>
										<li class="slot_item_20">20</li>
										<li class="slot_item_21">21</li>
										<li class="slot_item_3">3</li>
										<li class="slot_item_4">4</li>
										<li class="slot_item_5">5</li>
										<li class="slot_item_6">6</li>
										<li class="slot_item_7">7</li>
										<li class="slot_item_8">8</li>
										<li class="slot_item_9">9</li>
										<li class="slot_item_10">10</li>
										<li class="slot_item_11">11</li>
										<li class="slot_item_12">12</li>
										<li class="slot_item_13">13</li>
										<li class="slot_item_14">14</li>
										<li class="slot_item_15">15</li>
										<li class="slot_item_16">16</li>
										<li class="slot_item_17">17</li>
										<li class="slot_item_18">18</li>
										<li class="slot_item_19">19</li>
										<li class="slot_item_20">20</li>
										<li class="slot_item_21">21</li>
										<li class="slot_item_1">1</li>
										<li class="slot_item_2">2</li>
										<li class="slot_item_3">3</li>
										<li class="slot_item_4">4</li>
										<li class="slot_item_5">5</li>
										<li class="slot_item_6">6</li>
										<li class="slot_item_7">7</li>
										<li class="slot_item_8">8</li>
										<li class="slot_item_9">9</li>
										<li class="slot_item_10">10</li>
										<li class="slot_item_11">11</li>
										<li class="slot_item_12">12</li>
										<li class="slot_item_13">13</li>
										<li class="slot_item_14">14</li>
										<li class="slot_item_15">15</li>
										<li class="slot_item_16">16</li>
										<li class="slot_item_17">17</li>
										<li class="slot_item_18">18</li>
										<li class="slot_item_19">19</li>
										<li class="slot_item_20">20</li>
										<li class="slot_item_21">21</li>
										<li class="slot_item_3">3</li>
										<li class="slot_item_4">4</li>
										<li class="slot_item_5">5</li>
										<li class="slot_item_6">6</li>
										<li class="slot_item_7">7</li>
										<li class="slot_item_8">8</li>
										<li class="slot_item_9">9</li>
										<li class="slot_item_10">10</li>
										<li class="slot_item_11">11</li>
										<li class="slot_item_12">12</li>
										<li class="slot_item_13">13</li>
										<li class="slot_item_14">14</li>
										<li class="slot_item_15">15</li>
										<li class="slot_item_16">16</li>
										<li class="slot_item_17">17</li>
										<li class="slot_item_18">18</li>
										<li class="slot_item_19">19</li>
										<li class="slot_item_20">20</li>
										<li class="slot_item_21">21</li>
									</ul>
								</div>

								<div class="box">
									<ul>
										<li class="slot_item_1">1</li>
										<li class="slot_item_2">2</li>
										<li class="slot_item_3">3</li>
										<li class="slot_item_4">4</li>
										<li class="slot_item_5">5</li>
										<li class="slot_item_6">6</li>
										<li class="slot_item_7">7</li>
										<li class="slot_item_8">8</li>
										<li class="slot_item_9">9</li>
										<li class="slot_item_10">10</li>
										<li class="slot_item_11">11</li>
										<li class="slot_item_12">12</li>
										<li class="slot_item_13">13</li>
										<li class="slot_item_14">14</li>
										<li class="slot_item_15">15</li>
										<li class="slot_item_16">16</li>
										<li class="slot_item_17">17</li>
										<li class="slot_item_18">18</li>
										<li class="slot_item_19">19</li>
										<li class="slot_item_20">20</li>
										<li class="slot_item_21">21</li>
										<li class="slot_item_3">3</li>
										<li class="slot_item_4">4</li>
										<li class="slot_item_5">5</li>
										<li class="slot_item_6">6</li>
										<li class="slot_item_7">7</li>
										<li class="slot_item_8">8</li>
										<li class="slot_item_9">9</li>
										<li class="slot_item_10">10</li>
										<li class="slot_item_11">11</li>
										<li class="slot_item_12">12</li>
										<li class="slot_item_13">13</li>
										<li class="slot_item_14">14</li>
										<li class="slot_item_15">15</li>
										<li class="slot_item_16">16</li>
										<li class="slot_item_17">17</li>
										<li class="slot_item_18">18</li>
										<li class="slot_item_19">19</li>
										<li class="slot_item_20">20</li>
										<li class="slot_item_21">21</li>
										<li class="slot_item_1">1</li>
										<li class="slot_item_2">2</li>
										<li class="slot_item_3">3</li>
										<li class="slot_item_4">4</li>
										<li class="slot_item_5">5</li>
										<li class="slot_item_6">6</li>
										<li class="slot_item_7">7</li>
										<li class="slot_item_8">8</li>
										<li class="slot_item_9">9</li>
										<li class="slot_item_10">10</li>
										<li class="slot_item_11">11</li>
										<li class="slot_item_12">12</li>
										<li class="slot_item_13">13</li>
										<li class="slot_item_14">14</li>
										<li class="slot_item_15">15</li>
										<li class="slot_item_16">16</li>
										<li class="slot_item_17">17</li>
										<li class="slot_item_18">18</li>
										<li class="slot_item_19">19</li>
										<li class="slot_item_20">20</li>
										<li class="slot_item_21">21</li>
										<li class="slot_item_3">3</li>
										<li class="slot_item_4">4</li>
										<li class="slot_item_5">5</li>
										<li class="slot_item_6">6</li>
										<li class="slot_item_7">7</li>
										<li class="slot_item_8">8</li>
										<li class="slot_item_9">9</li>
										<li class="slot_item_10">10</li>
										<li class="slot_item_11">11</li>
										<li class="slot_item_12">12</li>
										<li class="slot_item_13">13</li>
										<li class="slot_item_14">14</li>
										<li class="slot_item_15">15</li>
										<li class="slot_item_16">16</li>
										<li class="slot_item_17">17</li>
										<li class="slot_item_18">18</li>
										<li class="slot_item_19">19</li>
										<li class="slot_item_20">20</li>
										<li class="slot_item_21">21</li>
									</ul>
								</div>

								<div class="box">
									<ul>
										<li class="slot_item_1">1</li>
										<li class="slot_item_2">2</li>
										<li class="slot_item_3">3</li>
										<li class="slot_item_4">4</li>
										<li class="slot_item_5">5</li>
										<li class="slot_item_6">6</li>
										<li class="slot_item_7">7</li>
										<li class="slot_item_8">8</li>
										<li class="slot_item_9">9</li>
										<li class="slot_item_10">10</li>
										<li class="slot_item_11">11</li>
										<li class="slot_item_12">12</li>
										<li class="slot_item_13">13</li>
										<li class="slot_item_14">14</li>
										<li class="slot_item_15">15</li>
										<li class="slot_item_16">16</li>
										<li class="slot_item_17">17</li>
										<li class="slot_item_18">18</li>
										<li class="slot_item_19">19</li>
										<li class="slot_item_20">20</li>
										<li class="slot_item_21">21</li>
										<li class="slot_item_3">3</li>
										<li class="slot_item_4">4</li>
										<li class="slot_item_5">5</li>
										<li class="slot_item_6">6</li>
										<li class="slot_item_7">7</li>
										<li class="slot_item_8">8</li>
										<li class="slot_item_9">9</li>
										<li class="slot_item_10">10</li>
										<li class="slot_item_11">11</li>
										<li class="slot_item_12">12</li>
										<li class="slot_item_13">13</li>
										<li class="slot_item_14">14</li>
										<li class="slot_item_15">15</li>
										<li class="slot_item_16">16</li>
										<li class="slot_item_17">17</li>
										<li class="slot_item_18">18</li>
										<li class="slot_item_19">19</li>
										<li class="slot_item_20">20</li>
										<li class="slot_item_21">21</li>
										<li class="slot_item_1">1</li>
										<li class="slot_item_2">2</li>
										<li class="slot_item_3">3</li>
										<li class="slot_item_4">4</li>
										<li class="slot_item_5">5</li>
										<li class="slot_item_6">6</li>
										<li class="slot_item_7">7</li>
										<li class="slot_item_8">8</li>
										<li class="slot_item_9">9</li>
										<li class="slot_item_10">10</li>
										<li class="slot_item_11">11</li>
										<li class="slot_item_12">12</li>
										<li class="slot_item_13">13</li>
										<li class="slot_item_14">14</li>
										<li class="slot_item_15">15</li>
										<li class="slot_item_16">16</li>
										<li class="slot_item_17">17</li>
										<li class="slot_item_18">18</li>
										<li class="slot_item_19">19</li>
										<li class="slot_item_20">20</li>
										<li class="slot_item_21">21</li>
										<li class="slot_item_3">3</li>
										<li class="slot_item_4">4</li>
										<li class="slot_item_5">5</li>
										<li class="slot_item_6">6</li>
										<li class="slot_item_7">7</li>
										<li class="slot_item_8">8</li>
										<li class="slot_item_9">9</li>
										<li class="slot_item_10">10</li>
										<li class="slot_item_11">11</li>
										<li class="slot_item_12">12</li>
										<li class="slot_item_13">13</li>
										<li class="slot_item_14">14</li>
										<li class="slot_item_15">15</li>
										<li class="slot_item_16">16</li>
										<li class="slot_item_17">17</li>
										<li class="slot_item_18">18</li>
										<li class="slot_item_19">19</li>
										<li class="slot_item_20">20</li>
										<li class="slot_item_21">21</li>
									</ul>
								</div>
							</div>
							<button id="slotstart" class="btn_start">
								<span class="obj_button"></span>
							</button>
							<span class="tx_push">누르세요</span>
						</div>
						<div class="tx_noti">
							<dl>
								<dt>참여방법</dt>
								<dd>
									01. HIT 스탬프로 1일 2회 잭팟 도전<br/>
									02. E머니로 하루 최대 5번 더 잭팟 기회
								</dd>
							</dl>
							* HIT 브랜드 모델에서 스탬프를 찾아보세요
							<a class="btn_applyway2" onclick="openLayer('ApplyWay2');return false"><em>HIT 스탬프 획득방법</em></a>
						</div>

						<!-- HIT 스탬프 획득방법 -->
						<div id="ApplyWay2" class="explain_layer" style="display:none;">
							<div class="backdim" onclick="$('#ApplyWay').fadeOut(100);"></div>
							<div class="appLayer">
								<h4>HIT 스탬프 획득방법</h4>
								<a href="javascript:///" class="close" onclick="$('#ApplyWay2').hide();">창닫기</a>
								<div class="layercont">
									<img src="http://img.enuri.info/images/event/2020/hitbrand/m_explain2_img_01.jpg" alt="" />
									<img src="http://img.enuri.info/images/event/2020/hitbrand/m_explain2_img_02.jpg" alt="" />
								</div>
							</div>
						</div>
						<div class="exc_wrap">
							<!-- 응모권 교환하기 -->
							<div class="btn_exc_group">
								<a id="stamp_exc" class="btn_stamp_exc" href="javascript:void(0);"><em>HIT스탬프로 응모권 교환하기</em></a>
								<a id="emoney_exc" class="btn_emoney_exc" href="javascript:void(0);" ><em>E머니로 응모권 교환하기</em></a>
							</div>
							<!-- // -->
							<!-- 잭팟 당첨자 -->
							<div class="winner_list" style="display:none;">
								<dl>
									<dt>잭팟 당첨자</dt>
									<dd>
										<ul></ul>
									</dd>
								</dl>
								<a href="javascript:void(0);" class="btn_winlist" onclick="openLayer('winList');return false"><em>당첨자 전체 보기</em></a>
							</div>
							<!-- // -->
						</div>
							<!-- 200612 : 딤레이어 : 당첨자 전부 확인 -->
						<div id="winList" class="winner_layer" style="display:none">
							<div class="backdim" onclick="$('#winList').fadeOut(100);"></div>
							<div class="appLayer">
								<h4>당첨자 내역</h4>
								<a href="javascript:///" class="close" onclick="$('#winList').hide();">창닫기</a>
								<div class="layercont">
									<table class="tb_winlist">
										<colgroup>
											<col width="80px">
											<col width="90px">
											<col width="">
										</colgroup>
										<thead>
											<tr>
												<th>ID</th>
												<th>당첨일시</th>
												<th>당첨e머니</th>
											</tr>
										</thead>
										<tbody></tbody>
									</table>
								</div>
							</div>
						</div>
						<!-- 유의사항, 이벤트 참여방법 -->
						<div class="btn_group">
							<a class="btn_applyway" onclick="openLayer('ApplyWay');return false"><em>이벤트 참여방법</em></a>
						</div>
						<!-- //유의사항, 이벤트 참여방법 -->

						<!-- 이벤트참여방법 레이어 -->
						<div id="ApplyWay" class="explain_layer" style="display:none;">
							<div class="backdim" onclick="$('#ApplyWay').fadeOut(100);"></div>
							<div class="appLayer">
								<h4>이벤트 참여 방법</h4>
								<a href="javascript:///" class="close" onclick="$('#ApplyWay').hide();">창닫기</a>
								<div class="layercont">
									<img src="http://img.enuri.info/images/event/2020/hitbrand_dec/m_explain_img_01.jpg" alt="" />
									<div class="txt">
										<ul class="txt_indent">
											<li>-  스탬프 5개로 매일 응모권을 획득할 수있습니다.<br/>(일 최대 2개)</li>
											<li>-  매일 e머니 100점으로 최대 5회 응모권으로 교환할 수 있습니다.</li>
											<li>-  e머니로 교환한 응모권은 환불 및 교환불가하며, 이벤트 종료시 소진됩니다.</li>
											<li>-  잭팟 결과에 따라 코인이 지급됩니다. <br/>(최소 1코인~최대 1,000코인)</li>
											<li>-  스페셜 경품에 따라 응모 가능한 코인 개수가 상이합니다.</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- //INNER -->
			</div>
			<!-- //슬롯머신 게임 + 응모 -->
		</div>

		<!-- 스페셜 경품 응모 영역 -->
		<div class="apply_box">
			<div class="inner">
				<div class="contents">
					<img src="http://img.enuri.info/images/event/2021/hitbrand/jun/m_gift_img_01.jpg" alt="획득하신 응모권으로 원하시는 경품에 응모하세요" />
					<!-- 응모하기 -->
					<div class="btn_apply_group">
						<a class="btn_apply_go" id="goapplylayer" onclick="openLayer('applyPrize');return false"><em>스페셜 경품전 응모하기</em></a>
						<a class="btn_my_apply" id="myapply" onclick="openLayer('giveaway');return false"><em>나의 응모현황</em></a>
					</div>
					<!-- // -->
					<!-- 당첨안내 및 공지  -->
					<div class="btn_group">
						<a class="btn_caution" onclick="openLayer('Caution');return false"><em>당첨안내 및 공지</em></a>
					</div>
					<!-- // 당첨안내 및 공지  -->

					<!-- 유의사항 -->
					<div id="Caution" class="caution_layer" style="display:none">
						<div class="backdim" onclick="$('#Caution').fadeOut(100);"></div>
						<div class="appLayer">
							<h4>당첨안내 및 유의사항</h4>
							<a href="javascript:///" class="close" onclick="$('#Caution').hide();">창닫기</a>
							<div class="layercont">
								<div class="txt">
									<strong class="top">스페셜 경품 당첨 안내</strong>
									<ol>
										<li>
											<ul class="txt_indent">
												<li><em>선정방법</em>
													<ul>
														<li>-  HIT슬롯머신 코인으로 스페셜 경품전 응모</li>
														<li>-  각 경품에 응모 시 지정된 수량의 코인이 소진됨</li>
														<li>-  코인이 모두 소진될 때까지 언제든 상시 중복 응모 가능</li>
													</ul>
												</li>
												<li><em>경품증정</em>
													<ul>
														<li>-  선택하신 경품 참여자 중 추첨하여 해당 상품을 드립니다.</li>
														<li>-  복수 응모 시 당첨확률이 높아집니다.</li>
													</ul>
												</li>
												<li><em>당첨자 발표</em>
													<ul>
														<li>-  <b>2021년 8월 4일</b> [에누리 고객센터]에서 확인</li>
														<li>-  경품 발송 : 당첨자 개별 연락 후 발송</li>
														<li>-  경품 관련 제세공과금 22%는 당첨자 부담입니다.<br/>(입금 확인 후 경품 발송)</li>
														<li>-  발표일로부터 일주일 이내에 연락이 되지 않을 경우, 당첨이 취소될 수 있습니다.</li>
														<li>- 60계 치킨세트는 당첨된 계정에 e머니로 지급되며, 에누리 e쿠폰 스토어에서 직접 교환하셔야 합니다.<br/>
														※ 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격 변동이 있을 수 있습니다.</li>
													</ul>
												</li>
											</ul>
										</li>
									</ol>
									<strong>참여 시 유의사항</strong>
									<ul class="txt_indent">
										<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
										<li>부정 참여 시 경품 증정이 취소되며, 법적 책임을 질 수 있습니다.</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<!-- //유의사항 레이어 -->
				</div>
			</div>
		</div>
		<!-- //스페셜 경품 응모 영역 -->
	</div>
	<!-- //이벤트 영역 -->

	<!-- 경품응모 레이어 -->
	<div id="applyPrize" class="quizApplyLayer" style="display:none;">
		<div class="backdim"  onclick="$('#applyPrize').fadeOut(100);"></div>
		<div class="appLayer">
			<h4>스페셜 경품 응모</h4>
			<a href="javascript:///" class="close" onclick="$('#applyPrize').hide();">창닫기</a>
			<div class="layercont">
				<!-- popup_box -->
				<div class="join_area">
					<div class="select_prize">
						<span class="tx_apply_prize">
							아래 경품 중 원하시는 경품 하나를 선택해 주세요.<br/>
						</span>
						<div class="num_coin">
							현재 코인 : <em>0</em>개
						</div>
						<ul class="prize_list">
							<!-- 체크한 상품 li.chk 추가 -->
							<li class="chk">
								<input type="radio" id="opt1" class="p_rdo" name="opt" value="" checked="checked">
								<label for="opt1">
									<span class="thumb" >
										<img src="http://img.enuri.info/images/event/2021/hitbrand/jun/m_prize_img1.jpg" alt="" />
									</span>
									<p class="proname">캐리어 창문형<br/>에어컨<br/>(1명)</p>
								</label>
							</li>
							<li>
								<input type="radio" id="opt2" class="p_rdo" name="opt" value=""> 
								<label for="opt2">
									<span class="thumb" >
										<img src="http://img.enuri.info/images/event/2021/hitbrand/jun/m_prize_img2.jpg" alt="" />
									</span>
									<p class="proname">갤럭시 A32<br/>자급제<br/>(1명)</p>
								</label>
							</li>
							<li>
								<input type="radio" id="opt3" class="p_rdo" name="opt" value=""> 
								<label for="opt3">
									<span class="thumb">
										<img src="http://img.enuri.info/images/event/2021/hitbrand/jun/m_prize_img3.jpg" alt="" />
									</span>
									<p class="proname">60계 치킨<br/>기프티콘<br/>(100명)</p>
								</label>
							</li>
						</ul>
					</div>
					<div class="agreebox">
						<p class="tit">당첨 시 경품 발송 안내를 위한 연락처를 넣어주세요.</p>
						<div class="input_num">
							<label for="p_numb">연락처</label><input type="tel" id="p_numb" name="" onfocus="this.value='';"  value="(-) 없이 입력하세요."  />
						</div>
						<div class="info_agree">
							<span class="unchk2" onclick="agreechk(this);"><input type="checkbox" id="" name="" value="N">개인정보 활용에 동의합니다.</span><a href="javascript:///" class="btn_detail" onclick="$('#Personinfo').show(); return false">자세히 보기</a>
						</div>
					</div>
					<div class="btn__group">
						<a id="goapply" class="btn layjoin" >응모하기</a>
					</div>
				</div>
				<!-- //popup_box -->
			</div>
		</div>
	</div>
	<!-- //경품응모 레이어 -->

	<!-- 분야별 탭 & 선정브랜드 -->
	<div class="tabList">
		<!-- tab -->
		<div id="toptab" class="tabBt">
			<ul class="menu">
				<li class="on" tabno="1"><a href="javascript:///">디지털</a></li>
				<li tabno="2"><a href="javascript:///">가전</a></li>
				<li tabno="3"><a href="javascript:///">컴퓨터</a></li>
				<li tabno="4"><a href="javascript:///">라이프</a></li>
			</ul>
			<nav class="m_top">
				<div class="gnbarea">
					<ul class="newgnb"></ul>
				</div>
				<div class="submenu">
					<span class="grd_next"></span>
					<span class="sh"></span>
					<ul></ul>
					<div class="submenu__close"><button type="button" id="closeSubmenu">닫기</button></div>
				</div>
			</nav>
		</div>
		<!--// tab -->

		<div class="conList">
			<!-- 디지털 -->
			<div id="m_bottom" class="plan"></div>
			<!-- 파워클릭 AD -->
				<div class="powerad_wrap">
				<div class="pad_head">
					<h2><img src="http://img.enuri.info/images/event/2019/hit_june/pad_tit.png" alt="파워클릭 AD" class="imgs" /></h2>
					<a href="javascript:///" onclick="goJoin()" class="join">신청하기 &gt;</a>
				</div>
				<div class="horiScrollWrap">
					<div class="scrollList">
						<ul class="adProdList"></ul>
					</div>
				</div>
			</div>
			<!-- //파워클릭 AD -->
		</div>
	</div>
	<!-- //분야별 탭 & 선정브랜드 -->

	<%-- <span class="go_top"><a href="#top" >TOP</a></span> --%>
</div>
<!-- 딤레이어 : 슬롯머신결과 : 응모권이 부족합니다. -->
<div id="lackTicket" class="pop-layer" style="display:none;">
	<div class="backdim"></div>
	<!-- popup_box -->
	<div class="popup_box result">
		<h4>응모권이 부족합니다</h4>
		<div class="inner">
            <img src="http://img.enuri.info/images/event/2020/hitbrand/m_pop_result_02.jpg" alt="HIT스탬프를 모아 응모권으로 교환할 수 있습니다. 또는, 보유하신 E머니로 응모권을 교환할 수 있습니다.">
		</div>
		<a class="btn_layclose" onclick="$(this).closest('.pop-layer').hide();return false"><em>팝업 닫기</em></a>
	</div>
	<!-- //popup_box -->
</div>
<!-- //딤레이어 : 이벤트 참여 방법 -->

<!-- 딤레이어 : 슬롯머신결과 : n코인 당첨 -->
<div id="winCoin" class="pop-layer" style="display:none;">
	<div class="backdim"></div>
	<!-- popup_box -->
	<div class="popup_box result">
		<h4><em>n</em> 코인 당첨</h4>
		<div class="inner">
            <img src="http://img.enuri.info/images/event/2020/hitbrand/m_pop_result_01.jpg" alt="잭팟이 터지지 않아 아쉽다면? 코인을 모아 스페셜 경품에 도전하세요.">
		</div>
		<a class="btn_layclose" onclick="$(this).closest('.pop-layer').hide();return false"><em>팝업 닫기</em></a>
	</div>
	<!-- //popup_box -->
</div>
<!-- //딤레이어 : n코인 당첨 -->

<!-- 딤레이어 : 슬롯머신결과 : 잭팟 당첨 -->
<div id="winJackpot" class="pop-layer" style="display:none;">
	<div class="backdim"></div>
	<!-- popup_box -->
	<div class="popup_box result">
		<h4>잭팟 당첨</h4>
		<div class="inner">
            <span class="tx_emoney">획득한 e머니 : <em>34,500</em>점</span>
            <img src="http://img.enuri.info/images/event/2020/hitbrand/m_pop_result_03.jpg" alt="e머니는 자동으로 즉시 지급됩니다. 적립된 e머니는 MY에누리 gt; e쿠폰 스토어에서 사용하세요.">
		</div>
		<a class="btn_layclose" onclick="$(this).closest('.pop-layer').hide();return false"><em>팝업 닫기</em></a>
	</div>
	<!-- //popup_box -->
</div>
<!-- //딤레이어 : 잭팟 당첨 -->

<!-- 딤레이어 : 응모권교환 (스탬프->응모권) -->
<div id="excTicket" class="pop-layer" style="display:none;">
	<div class="backdim"></div>
	<!-- popup_box -->
	<div class="popup_box exchange exc_stamp">
		<h4>응모권 교환</h4>
		<div class="inner">
            <div class="tx_cur">
                <p>현재 스탬프 : <em></em>개</p>
            </div>
            <!-- 버튼 : 응모권 교환하기 -->
            <a href="javascript:void(0);" class="btn_exc_ticket" onclick="openLayer('excTicketComplete');openLayer('excTicketLack');openLayer('excTicketLimit');$(this).closest('.pop-layer').hide();return false;">
                <span class="tx_btn_exc">응모권 교환하기</span>
                <span class="tx_btn_exc_sub">스탬프 5개 필요</span>
            </a>
            <!-- 버튼 : 확인(레이어닫기) -->
            <a href="javascript:void(0);" class="btn_lay_close" onclick="$(this).closest('.pop-layer').hide();return false;">확인</a>
		</div>
	</div>
	<!-- //popup_box -->
</div>
<!-- //딤레이어 : 응모권교환 (스탬프->응모권) -->

<!-- 딤레이어 : 응모권교환 (스탬프->응모권 -> 교환완료) -->
<div id="excTicketComplete" class="pop-layer" style="display:none;">
	<div class="backdim"></div>
	<!-- popup_box -->
	<div class="popup_box exchange">
		<h4>교환완료</h4>
		<div class="inner">
            <div class="tx_cur">
                <p>현재 스탬프 : <em>0</em>개</p>
                <p>현재 응모권 : <em>0</em>개</p>
            </div>
            <!-- 버튼 : 확인(레이어닫기) -->
            <a href="javascript:void(0);" class="btn_lay_close" onclick="$(this).closest('.pop-layer').hide();return false;">확인</a>
		</div>
	</div>
	<!-- //popup_box -->
</div>
<!-- //딤레이어 : 응모권교환 (스탬프->응모권 -> 교환완료) -->

<!-- 딤레이어 : 응모권교환 (스탬프->응모권 -> 스탬프부족) -->
<div id="excTicketLack" class="pop-layer" style="display:none;">
	<div class="backdim"></div>
	<!-- popup_box -->
	<div class="popup_box exchange">
		<h4>스탬프 부족</h4>
		<div class="inner">
            <div class="tx_cur">
                <p>현재 스탬프 : <em>0</em>개</p>
                <span class="tx_cur_sub">스탬프 5개로 응모권 교환이 가능합니다.</span>
            </div>
            <!-- 버튼 : 확인(레이어닫기) -->
            <a href="javascript:void(0);" class="btn_lay_close" onclick="$(this).closest('.pop-layer').hide();return false;">확인</a>
		</div>
	</div>
	<!-- //popup_box -->
</div>
<!-- //딤레이어 : 응모권교환 (스탬프->응모권 -> 스탬프부족) -->

<!-- 딤레이어 : 응모권교환 (스탬프->응모권 -> 일일교환횟수 초과) -->
<div id="excTicketLimit" class="pop-layer" style="display:none;">
	<div class="backdim"></div>
	<!-- popup_box -->
	<div class="popup_box exchange">
		<h4>일일 교환 횟수 초과</h4>
		<div class="inner">
            <div class="tx_cur">
                <p>현재 스탬프 : <em>0</em>개</p>
                <span class="tx_cur_sub">스탬프로 응모권은 매일 2번 교환 가능합니다.</span>
            </div>
            <!-- 버튼 : 확인(레이어닫기) -->
            <a href="javascript:void(0);" class="btn_lay_close" onclick="$(this).closest('.pop-layer').hide();return false;">확인</a>
		</div>
	</div>
	<!-- //popup_box -->
</div>
<!-- //딤레이어 : 응모권교환 (스탬프->응모권 -> 일일교환횟수 초과) -->

<!-- 딤레이어 : 응모권교환 (e머니->응모권) -->
<div id="excEmoney" class="pop-layer" style="display:none;">
	<div class="backdim"></div>
	<!-- popup_box -->
	<div class="popup_box exchange exc_emoney">
		<h4>응모권 교환</h4>
		<div class="inner">
            <div class="tx_cur">
                <p>현재 e머니 : <em></em>점</p>
            </div>
            <!-- 버튼 : 응모권 교환하기 -->
            <a href="javascript:void(0);" class="btn_exc_ticket" onclick="openLayer('excEmoneyComplete');openLayer('excEmoneyLack');openLayer('excEmoneyLimit');$(this).closest('.pop-layer').hide();return false;">
                <span class="tx_btn_exc">응모권 교환하기</span>
                <span class="tx_btn_exc_sub">e머니 100점 필요</span>
            </a>
            <span class="tx_exc_noti">응모권 교환은 에누리APP과 PC에서 가능합니다.</span>
            <!-- 버튼 : 확인(레이어닫기) -->
            <a href="javascript:void(0);" class="btn_lay_close" onclick="$(this).closest('.pop-layer').hide();return false;">확인</a>
		</div>
	</div>
	<!-- //popup_box -->
</div>
<!-- //딤레이어 : 응모권교환 (e머니->응모권) -->

<!-- 딤레이어 : 응모권교환 (e머니->응모권 -> 교환완료) -->
<div id="excEmoneyComplete" class="pop-layer" style="display:none;">
	<div class="backdim"></div>
	<!-- popup_box -->
	<div class="popup_box exchange">
		<h4>교환완료</h4>
		<div class="inner">
            <div class="tx_cur">
                <p>현재 e머니 : <em>0</em>점</p>
                <p>현재 응모권 : <em>0</em>개</p>
            </div>
            <!-- 버튼 : 확인(레이어닫기) -->
            <a href="javascript:void(0);" class="btn_lay_close" onclick="$(this).closest('.pop-layer').hide();return false;">확인</a>
		</div>
	</div>
	<!-- //popup_box -->
</div>
<!-- //딤레이어 : 응모권교환 (e머니->응모권 -> 교환완료) -->

<!-- 딤레이어 : 응모권교환 (e머니->응모권 -> e머니부족) -->
<div id="excEmoneyLack" class="pop-layer" style="display:none;">
	<div class="backdim"></div>
	<!-- popup_box -->
	<div class="popup_box exchange">
		<h4>e머니 부족</h4>
		<div class="inner">
            <div class="tx_cur">
                <p>현재 e머니 : <em>0</em>점</p>
                <span class="tx_cur_sub">e머니 100점으로 응모권 교환이 가능합니다.</span>
            </div>
            <!-- 버튼 : 확인(레이어닫기) -->
            <a href="javascript:void(0);" class="btn_lay_close" onclick="$(this).closest('.pop-layer').hide();return false;">확인</a>
		</div>
	</div>
	<!-- //popup_box -->
</div>
<!-- //딤레이어 : 응모권교환 (e머니->응모권 -> e머니부족) -->

<!-- 딤레이어 : 응모권교환 (e머니->응모권 -> 일일교환횟수 초과) -->
<div id="excEmoneyLimit" class="pop-layer" style="display:none;">
	<div class="backdim"></div>
	<!-- popup_box -->
	<div class="popup_box exchange">
		<h4>일일 교환 횟수 초과</h4>
		<div class="inner">
            <div class="tx_cur">
                <p>현재 e머니 : <em>0</em>점</p>
                <span class="tx_cur_sub">e머니로 응모권은 매일 5번 교환 가능합니다.</span>
            </div>
            <!-- 버튼 : 확인(레이어닫기) -->
            <a href="javascript:void(0);" class="btn_lay_close" onclick="$(this).closest('.pop-layer').hide();return false;">확인</a>
		</div>
	</div>
	<!-- //popup_box -->
</div>
<!-- //딤레이어 : 응모권교환 (e머니->응모권 -> 일일교환횟수 초과) -->

<!-- 딤레이어 : 응모권교환 (e머니->응모권 -> APP전용(모바일웹에서만 노출)) -->
<div id="excApponly" class="pop-layer" style="display:none;">
	<div class="backdim" onclick="$(this).closest('.pop-layer').hide();"></div>
	<!-- popup_box -->
	<div class="popup_box app_only">
		<div class="inner">
			<a href="javascript:void(0);" class="btn_app_only" onclick="alert('앱설치');return false;">에누리 앱에서 교환하기</a>
			<span class="tx_app_only_noti">
				e머니 교환하기는<br/>PC와 에누리앱에서만 가능합니다.
			</span>
		</div>
	</div>
	<!-- //popup_box -->
</div>
<!-- //딤레이어 : 응모권교환 (e머니->응모권 -> APP전용(모바일웹에서만 노출)) -->

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
<!-- layer-->
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="onoff('app_only')">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();">설치하기</button></p>
	</div>
</div>
<!-- 나의 경품 응모현황-->
<div id="giveaway" class="dim" style="display:none;">
	<!-- popup_box -->
	<div class="appLayer mycheck">
		<h4>나의 경품 응모현황</h4>
		<a href="javascript:///" class="close" onclick="$('#giveaway').hide();">창닫기</a>

		<div class="layercont">
			<p class="tit">응모권 현황</p>
			<div class="mycheck_box">
				<ul>
					<li class="get">
						<strong>획득 코인 : <em></em>개</strong>
					</li>
					<li class="remain">
						<strong>남은 코인 : <em></em>개</strong>
					</li>
				</ul>
			</div>

			<p class="tit">응모내역</p>
			<div class="detail_box">
					<div class="used">
						<strong>사용한 코인 : <em></em>개</strong>
					</div>
					<div class="detail_view">
						<table>
							<colgroup>
								<col class="col1" />
								<col class="col2" />
								<col class="col3" />
								<col class="col4" />
							</colgroup>
							<tbody></tbody>
						</table>
					</div>
				</ul>
			</div>
		</div>
	</div>
	<!-- //popup_box -->
</div>
<!-- //나의 경품 응모현황 -->
<!-- 푸터 -->
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<!--// 푸터 -->


<script type="text/javascript">
var ord = 1;

sdt = "<%=sdt%>";
//sdt = "20201217";  //test
var username = "<%=userArea%>"; <!--개인화영역 이름-->
var vDataArray = new Array();

$(window).load(function(){
	tabScroll(".tabBt");
	if(sdt > 20210730 && sdt < 20210616){
		alert('히트브랜드 이벤트가 종료되었으며, 적립된 코인은 2월 2일까지만 사용이 가능하니, 빠르게 응모해주세요');
	}
});

$(document).ready(function(){
	loadProdData(1);
	eBayCpcSet();
	//이베이cpc 운영배포할때는 삭제
	//$(".powerad_wrap").remove();

	loadPostData(0);

	$(".btn_login").click(function() {
		goLogin();
	});

	if(islogin()){
		$("#user_id").text("<%=cUserId%>");
		getPoint();//개인e머니 내역 노출
	}

	$("#toptab .menu li").click(function(){
		var vThis = $(this);
		var vThisTabNo = vThis.attr("tabno");
		vThis.siblings().removeClass("on");
		vThis.addClass("on");
		if(vDataArray[vThisTabNo]==null){
			loadProdData(vThisTabNo);
		}else{
			drawTopList(vDataArray[vThisTabNo]["topList"]);
			drawBottomList(vDataArray[vThisTabNo]["bottomList"]);
		}
	});

	// 서브메뉴 닫기
	$(".submenu .submenu__close button").click(function(){
		$(".submenu").removeClass("on");
	});
	// 서브메뉴 Toggle
	$(".submenu .grd_next").click(function() {
		if($(this).parent().hasClass("on")){
			$(".submenu").removeClass("on");
		}else{
			$(this).parent().addClass("on").siblings().removeClass("on");
		}
		return false;
	});


	//슬롯 start
	$("#slotstart").click(function(){
		if ( !$(this).hasClass("playing") ){
			loadPostData(1);
		}
	});

	//코인 경품 응모
	$("#goapplylayer").click(function(){
		loadPostData(3);
	});

	//나의 응모 현황
	$("#myapply").click(function(){
		loadPostData(4);
	});

	$("#stamp_exc").click(function(){
		//alert("이벤트가 종료되었습니다.");
		loadExchangeData("S");
	});

	$("#emoney_exc").click(function(){
		//alert("이벤트가 종료되었습니다.");
		loadExchangeData("E");
	});
    if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
    //    ga('send', 'pageview', {'page': '/mobilefirst/evt/event_hitbrand201912.jsp', 'title': '201912히트브랜드  pv_iphone'});
    }else if(navigator.userAgent.indexOf("Android") > -1){
    //   ga('send', 'pageview',  {'page': '/mobilefirst/evt/event_hitbrand201912.jsp',  'title': '201912히트브랜드  pv_android'});
    }
    $(".win_close").click(function(){
        if(getCookie("appYN") == 'Y')	window.location.href = "close://";
        else				            window.location.replace("/m/index.jsp");
    });
});
function loadExchangeData(type){
	$.ajax({
		type: "POST",
		url: "/eventPlanZone/ajax/getHitBrandTicket.jsp",
		data : {"pth" : type},
		async: true,
		dataType:"JSON",
		success : function(json){
			if(typeof json.success !="undefined" ){
				alert(json.rtnmsg);
				if(islogin()){
					$("#user_id").text("<%=cUserId%>");
					getPoint();//개인e머니 내역 노출
				}
				loadPostData(0);
				return;
			}
		}
	});
}
function loadPostData(type){
	var param = {"procCode" : type};
	var vSuccess = false;
	if(type == 2){
		var _selected ="";
		$("#applyPrize").find(".prize_list li").each(function(i,v){
			var cls = $(this).attr("class");
			if(cls == "chk"){
				_selected = (i+1);
			}
		});
		param.uphone=$("#p_numb").val();
		param.selectItem = _selected;
	}

	if(type == 2 || type == 3 || type == 4){
		if(!coinEvtChk()){
			return ;
		}
	}else if(type > 0){ //1(슬롯)
		if(!evtCommonChk(type)){
			return ;
		}
	}

	$.ajax({
		type: "POST",
		url: "/eventPlanZone/ajax/hitBrand202012_getData.jsp",
		data : param,
		async: true,
		dataType:"JSON",
		success: function(json){
			isClick = false;
			vSuccess = json["success"];
			if(vSuccess){
				var vData = json["data"];
				if(typeof vData != "undefined" && vData !=null){
					if(type == 0){
						drawInit(vData);
					}else if(type == 1){
						drawSlot(vData);
					}else if(type == 2){
						drawApply(vData);
					}else if(type == 3){
						drawPreApply(vData);
					}else if(type == 4){
						drawMyApply(vData);
					}
				}
			}else{
				var vMsg = json["message"];
				if(vMsg.indexOf("UserID") > 0){
					alert("로그인 후 이용 가능합니다.");
					return ;
				} else if(vMsg.indexOf("Date") > 0){
					alert("이벤트 기간이 종료되었습니다.");
					return ;
				}
			}
		},complete : function(data) {
			if(vSuccess){
				isClick = true;
			}

		},error: function(x, o, e){
		}
	});
}

function loadProdData(tab){
	$.ajax({
		type: "GET",
		url: "/eventPlanZone/ajax/getHitBrandProdData.jsp?tab="+tab,
		async: true,
		dataType:"JSON",
		success: function(json){
			if(json != null){
				var topListJson = json["topList"];
				var bottomListJson = json["bottomList"];

				if(topListJson.length > 0){
					drawTopList(topListJson);
				}
				if(bottomListJson.length > 0){
					drawBottomList(bottomListJson);
				}
			}
		},complete : function(data){
			vDataArray[tab] = data.responseJSON;
		},error: function(x, o, e){

		}
	});
}

function drawInit(json){
	var vTicket = json["ticket"];
	var vPrice = json["price"];
	var vWinnerList = json["winnerList"];

	$("#ticketarea").find(".num_ticket").html(vTicket);
	$("#slotarea").find(".slotm_wrap .tx_emoney em").html(commaNum(vPrice));
	if(vWinnerList.length > 0){
		$("#slotarea").find(".exc_wrap .winner_list ul").empty();
		var winner_text = "";
		$.each(vWinnerList,function(index,listData){
			var winner_price = listData["winner_price"];
			var winner_id = listData["winner_id"];
			var winner_date = listData["winner_date"];

			if(index < 3){
				$("#slotarea").find(".exc_wrap .winner_list ul").append("<li>"+winner_id + " / " + winner_date+ " / " + commaNum(winner_price) + "점"+"</li>");
			}
			winner_text += "<tr>";
			winner_text += "	<td><span class=\"tx_id\">"+winner_id+"</span></td>";
			winner_text += "	<td>"+winner_date.replace(" ","<br>")+"</td>";
			winner_text += "	<td>"+commaNum(winner_price)+"</td>";
			winner_text += "</tr>";
		});
		$("#winList").find(".tb_winlist tbody").html(winner_text);
		$("#slotarea").find(".exc_wrap .winner_list").show();
	}else{
		$("#slotarea").find(".exc_wrap .winner_list").hide();
	}
}

function drawTopList(json){
	if(json.length > 0){
		var topUlObject = $("#toptab").find(".gnbarea ul");
		var subUlObject = $("#toptab").find(".submenu ul");
		topUlObject.empty();
		subUlObject.empty();

		var html = "";
		var vName = "";
		var vTab = "";
		var vTitle = "";
		var vOrdNo = "";
		var vOnClass = "";
		$.each(json,function(index,listData){
			vName = listData["choice_part"];
			vTab =  listData["tab"];
			vOrdNo = listData["ord"];
			if(index > 8){
				if(index==9){
					if(vTab == "digital") vTitle="디지털 수상부문";
					else if(vTab == "appliance") vTitle="가전 수상부문";
					else if(vTab == "computer")	vTitle="컴퓨터 수상부문";
					else if(vTab == "life") vTitle="라이프 수상부문";
					subUlObject.append("<li class=\"cate\"><a href=\"javascript:void(0);\">"+vTitle+"</a></li>");
				}
				subUlObject.append("<li ordno=\""+vOrdNo+"\"><a href=\"javascript:void(0);\" >"+vName+"</a></li>");
			}else{
				vOnClass = (index==0) ? "on" : "";
				topUlObject.append("<li ordno=\""+vOrdNo+"\"><a href=\"javascript:void(0);\" class=\""+vOnClass+"\">"+vName+"</a></li>");
			}
		});
		topUlObject.find("li").add(subUlObject.find("li")).click(function(){
			var vThis = $(this);
			var vOrdNo = vThis.attr("ordno");
			var vThisTop = $("#m_bottom .planlist[ordno="+vOrdNo+"]").offset().top;
			var vFixedH = $(".tabBt").height() + $(".m_top").height();
			if(vThis.hasClass("cate")){
				return false;
			}else{
				vThis.siblings().find("a").removeClass("on");
				vThis.find("a").addClass("on");
			}
			$('html, body').animate({scrollTop : Math.round(vThisTop-vFixedH) }, 400);
		});
	}
}

function drawBottomList(json){
	if(json.length > 0){

		var vBrand ="";
		var vName = "";
		var vBrandImg = "";
		var vOrdNo = "";
		$("#m_bottom").empty();
		$.each(json,function(index,listData){
			var html = "";
			var vModelList = listData["modelList"];
			vBrand =listData["brand"];
			vName = listData["choice_part"]
			vBrandImg = listData["brand_image"];
			vOrdNo = listData["ord"];
			html+="<div class=\"planlist\" ordno=\""+vOrdNo+"\">";
			html+="	<h4><span>"+vName+"</span></h4>";
			if(vModelList.length > 0){
				var vModelName ="";
				var vModelNo ="";
				var vGoodsImg = "";
				var vGoodsUrl = "";
				var vGoodsPrice = "";
				var vHitbrandNo = "";
				var vPlPrice  = "";
				var vOnClass = "";
				var vThreeClass = (vModelList.length < 4) ? "three" : "";
				$.each(vModelList,function(index,listData){
					vOnClass = (index==0) ? "on" : "";
					vModelName = listData["modelname"];
					vModelNo = listData["modelno"];
					vGoodsImg = listData["goods_image"];
					vGoodsPrice = listData["minprice_mobile"];
					vPlPrice = listData["gd_prc"];
					vGoodsUrl = listData["url"];
					vHitbrandNo = listData["hit_brand_no"];
					if(index==0){
						html+="	<ul class=\"plan_thum\">";
						html+="		<li>";
						html+="			<div class=\"detail\" data-code=\""+vHitbrandNo+"\" data-id=\""+vModelNo+"\" data-url=\""+vGoodsUrl+"\">";
						html+="				<em class=\"md\">BEST</em>";
						html+="				<div class=\"thum_image\"><img src=\""+vGoodsImg+"\" class=\"thum\"></div>";
						html+="				<span class=\"com\"><img src=\""+vBrandImg+"\" alt=\"\">"+vBrand+"</span>";
						html+="				<strong class=\"tit\">"+vModelName+"</strong>";
						if(vBrand !="리본카"){
							if(vPlPrice != ""){
								html += "              <span class=\"price\"><em>최저가</em><strong>"+vPlPrice+"</strong>원</span>";
							}else {
								html += "              <span class=\"price\"><em>최저가</em><strong>"+vGoodsPrice+"</strong>원</span>";
							}
						}
						html+="			</div>";
						html+="		</li>";
						html+="	</ul>";
						html+="	<div class=\"plan_list "+vThreeClass+"\">";
						html+="		<ul>";
					}
					html+="			<li class=\""+vOnClass+"\"><a href=\"javascript:///\"><img src=\""+vGoodsImg+"\"></a></li>";
				});
				html+="		</ul>";
				html+="	</div>";
				html+="</div>";
			}
			$("#m_bottom").append(html);
		});
		$("#m_bottom").find(".planlist .plan_thum .detail").unbind("click");
		$("#m_bottom").find(".planlist .plan_thum .detail").click(function(){

			var modelno = $(this).attr("data-id");
			var bno = $(this).attr("data-code");
			var url = $(this).attr("data-url");
			hitbrandLog(bno , 'H' , 'M');
		  	// ga('send', 'event', '2019히트브랜드' ,'goods', modelno);

			if(url != ""){
				if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
					window.open("http://"+url+"&freetoken=outlink");
				}else{
					window.open("http://"+url);
				}
			}else{
				location.href = "/m/vip.jsp?modelno="+modelno;
			}
		});
		$("#m_bottom").find(".planlist .plan_list ul li").unbind("click");
		$("#m_bottom").find(".planlist .plan_list ul li").click(json,function(e){
			var vThis = $(this);
			var vThisIndex = vThis.index();
			var vParent = vThis.parents(".planlist");
			var vParentIndex = vParent.index();
			var vParentThumDiv = vParent.find(".plan_thum .detail");
			var vBottomList = e.data[vParentIndex];
			var vModelObject = vBottomList["modelList"][vThisIndex];
			vThis.siblings().removeClass("on");
			vThis.addClass("on");
			if(vThisIndex==0){
				vParentThumDiv.find(".md").show();
			}else{
				vParentThumDiv.find(".md").hide();
			}
			vParentThumDiv.find(".thum_image img").attr("src",vModelObject["goods_image"]);
			vParentThumDiv.find(".tit").html(vModelObject["modelname"]);
			vParentThumDiv.find(".price strong").html(vModelObject["minprice"]);
			vParentThumDiv.attr("data-code",vModelObject["hit_brand_no"])
			vParentThumDiv.attr("data-id",vModelObject["modelno"])
		});
	}
}

function drawSlot(json){
	var result = json["result"];
	var rtnValue = json["value"];
	if(typeof result == "undefined") {
		return ;
	}
	var $btnStart = $("#slotstart");
	var num = 0;
	// 버튼 연타 방지
	$btnStart.addClass("playing");

	var $box = $(".box");
	var boxH = 45; // 상품1개당 높이
	var boxL = 40; // 상품총갯수
	var addTime = [3,6,9]; // 순차적 딜레이를 위한 룰렛 추가 시간
	var centerGap = boxH/2; // 상하 가운데 정렬을 위한 위치 차이
	var startPos = (boxH * boxL) + centerGap; //
	var ranGenerator = function(max, min){ // 랜덤
		return Math.floor((Math.random() * max) + min);
	}

	var calcPosition = function(num){ // 목표위치 계산
		// 결과가 1일때 예외처리
		if ( num == 1 ) return (boxH * boxL) - centerGap;
		else return (num * boxH) - (boxH * 2) + centerGap;
	}
	var calcTimer = function(num){ // 선택한 번호에 따른 룰렛 플레이 타임 계산
		return num * .2;
	}

	if(result == 1){
		num = 2;
		$("#winJackpot").find(".tx_emoney em").html(commaNum(rtnValue));
	}else if(result == 2 ){
		while(num = ranGenerator(50,1)){
			if(num != 2) break;
		}
	}else if(result == 3){
		num = 0;
	}else {
		if(result == -1){
			openLayer("lackTicket");
		}else if(result == -2){
			alert("진행중인 슬롯이 없습니다.");
		}else if(result == -9){
			alert("임직원은 참여 할수없습니다.");
		}else {
			alert("잠시후에 다시 시도해주세요.");
		}
		$btnStart.removeClass("playing");
		return ;
	}
	if ( num == 0 ){ // 꽝일때 위치 담기
		var lose = new Array(3);
		// 랜덤수 채움
		for(var i = 0; i < lose.length ; i++){
			lose[i] = ranGenerator(50, 1);
			// 중복체크
			for(var j = 0; j < i; j++ ){
				// 중복일경우 random 값 다시 생성
				if(lose[i] == lose[j]){
					i = i - 1;
					break;
				}
			}
		}
		endPos = calcPosition(lose[0]);
	}else{ // 당첨일때 위치 담기
		endPos = calcPosition(num);
	}

	// 슬롯머신 CSS 생성 ( 결과 모션은 CSS로 처리 )
	var sheet = document.createElement('style');
	var sheet_str = "";
	sheet_str += '\n\ .slotm_con .box ul.animA.anim1{-webkit-animation: slotm '+(calcTimer(num)+addTime[0])+'s linear 1;animation: slotm '+(calcTimer(num)+addTime[0])+'s linear 1;-webkit-animation-fill-mode: forwards;animation-fill-mode: forwards;}'
	sheet_str += '\n\ .slotm_con .box ul.animA.anim2{-webkit-animation: slotm '+(calcTimer(num)+addTime[1])+'s linear 1;animation: slotm '+(calcTimer(num)+addTime[1])+'s linear 1;-webkit-animation-fill-mode: forwards;animation-fill-mode: forwards;}'
	sheet_str += '\n\ .slotm_con .box ul.animA.anim3{-webkit-animation: slotm '+(calcTimer(num)+addTime[2])+'s linear 1;animation: slotm '+(calcTimer(num)+addTime[2])+'s linear 1;-webkit-animation-fill-mode: forwards;animation-fill-mode: forwards;}'
	sheet_str += '\n\ .slotm_con .box ul.animB{-webkit-animation: slotm1 '+(calcTimer(num)+addTime[1])+'s linear 1;animation: slotm1 '+(calcTimer(num)+addTime[1])+'s linear 1;-webkit-animation-fill-mode: forwards;animation-fill-mode: forwards;}'
	sheet_str += '\n\ .slotm_con .box ul.animC{-webkit-animation: slotm2 '+(calcTimer(num)+addTime[2])+'s linear 1;animation: slotm2 '+(calcTimer(num)+addTime[2])+'s linear 1;-webkit-animation-fill-mode: forwards;animation-fill-mode: forwards;}'
	sheet_str += '\n\ @-webkit-keyframes slotm{'
	sheet_str += '\n\    0%{-webkit-transform: translateY(-'+centerGap+'px);transform: translateY(-'+centerGap+'px)} \n\ 59.9%{-webkit-transform: translateY(-'+startPos+'px);transform: translateY(-'+startPos+'px)} \n\ 60.0%{-webkit-transform: translateY(-'+centerGap+'px);transform: translateY(-'+centerGap+'px)} \n\ 100%{-webkit-transform: translateY( -'+endPos+'px );transform: translateY( -'+endPos+'px )}'
	sheet_str += '\n\ }'
	sheet_str += '\n\ @keyframes slotm{'
	sheet_str += '\n\    0%{-webkit-transform: translateY(-'+centerGap+'px);transform: translateY(-'+centerGap+'px)}\n\ 59.9%{-webkit-transform: translateY(-'+startPos+'px);transform: translateY(-'+startPos+'px)}\n\ 60.0%{-webkit-transform: translateY(-'+centerGap+'px);transform: translateY(-'+centerGap+'px)}\n\ 100%{-webkit-transform: translateY( -'+endPos+'px );transform: translateY( -'+endPos+'px )}'
	sheet_str += '\n\ }'
	// 꽝 일때 처리
	if ( num == 0 ){
		sheet_str += '\n\ @-webkit-keyframes slotm1{'
		sheet_str += '\n\    0%{-webkit-transform: translateY(-'+centerGap+'px);transform: translateY(-'+centerGap+'px)} \n\ 59.9%{-webkit-transform: translateY(-'+startPos+'px);transform: translateY(-'+startPos+'px)} \n\ 60.0%{-webkit-transform: translateY(-'+centerGap+'px);transform: translateY(-'+centerGap+'px)} \n\ 100%{-webkit-transform: translateY( -'+calcPosition(lose[1])+'px );transform: translateY( -'+calcPosition(lose[1])+'px )}'
		sheet_str += '\n\ }'
		sheet_str += '\n\ @keyframes slotm1{'
		sheet_str += '\n\    0%{-webkit-transform: translateY(-'+centerGap+'px);transform: translateY(-'+centerGap+'px)}\n\ 59.9%{-webkit-transform: translateY(-'+startPos+'px);transform: translateY(-'+startPos+'px)}\n\ 60.0%{-webkit-transform: translateY(-'+centerGap+'px);transform: translateY(-'+centerGap+'px)}\n\ 100%{-webkit-transform: translateY( -'+calcPosition(lose[1])+'px );transform: translateY( -'+calcPosition(lose[1])+'px )}'
		sheet_str += '\n\ }'
		sheet_str += '\n\ @-webkit-keyframes slotm2{'
		sheet_str += '\n\    0%{-webkit-transform: translateY(-'+centerGap+'px);transform: translateY(-'+centerGap+'px)} \n\ 59.9%{-webkit-transform: translateY(-'+startPos+'px);transform: translateY(-'+startPos+'px)} \n\ 60.0%{-webkit-transform: translateY(-'+centerGap+'px);transform: translateY(-'+centerGap+'px)} \n\ 100%{-webkit-transform: translateY( -'+calcPosition(lose[2])+'px );transform: translateY( -'+calcPosition(lose[2])+'px )}'
		sheet_str += '\n\ }'
		sheet_str += '\n\ @keyframes slotm2{'
		sheet_str += '\n\    0%{-webkit-transform: translateY(-'+centerGap+'px);transform: translateY(-'+centerGap+'px)}\n\ 59.9%{-webkit-transform: translateY(-'+startPos+'px);transform: translateY(-'+startPos+'px)}\n\ 60.0%{-webkit-transform: translateY(-'+centerGap+'px);transform: translateY(-'+centerGap+'px)}\n\ 100%{-webkit-transform: translateY( -'+calcPosition(lose[2])+'px );transform: translateY( -'+calcPosition(lose[2])+'px )}'
		sheet_str += '\n\ }'
	}
	var head = document.head || document.getElementsByTagName('head')[0];
	sheet.type='text/css';
	if (sheet.styleSheet) { // for under ie9
		sheet.styleSheet.cssText=sheet_str;
	}else { // for recently browsers(ie9 and over, chrome, firefox, safari etc...)
		sheet.appendChild(document.createTextNode(sheet_str));
	}
	head.appendChild(sheet);

	// Play
	setTimeout(function(){
		var addDelayTime = addTime[2];
		if ( num == 2 ) addDelayTime = 5;

		if ( num == 0 ){
			$box.eq(0).find("ul").addClass("anim animA anim1");
			$box.eq(1).find("ul").addClass("anim animB anim2");
			$box.eq(2).find("ul").addClass("anim animC anim3");
		}else{
			$box.eq(0).find("ul").addClass("anim animA anim1");
			$box.eq(1).find("ul").addClass("anim animA anim2");
			$box.eq(2).find("ul").addClass("anim animA anim3");
		}
		// 결과 레이어 호출
		setTimeout(function(){
			resultLayer(num);
		},(calcTimer(num)+addDelayTime+1.5)*1000);
	},300);
}

function drawApply(json){
	if(json.result == 1){
		alert("이벤트에 응모 되었습니다!");
	}else if(json.result == -1){
		alert("코인이 부족합니다.");
	}
	closeLayer("applyPrize");
}

function drawPreApply(json){
	var vTotalCnt =  json["totalCnt"];
	var vUseCnt =  json["useCnt"];
	var vWinCnt =  json["winCnt"];
	$("#applyPrize").find(".join_area .num_coin em").html(vTotalCnt);

	openLayer('applyPrize');

	if(!islogin()){
		alert("로그인 후 응모 가능합니다");
		goLogin();
		return ;
	}else{
		$(".prize_list li").click(function(e){
			$(".prize_list li").removeClass("chk");
			$(this).addClass("chk");
			return false;
		});
		$(".prize_list li .thumb").click(function(e){
			event.stopPropagation();
			var vThis = $(this);
			var vThisIndex = $(this).parents("li").index();
			var vModelNo = 0;
			if(vThisIndex == 0){
				vModelNo = 65608898;
			}else if(vThisIndex == 1){
				vModelNo = 63840526;
			}
			if(vModelNo > 0 ){
				location.href = "/m/vip.jsp?modelno="+vModelNo;
			}else{
				if(getCookie("appYN") == 'Y') location.href = "/mobilefirst/emoney/emoney_detail.jsp";
				else alert("e머니 스토어의 상품보기는 PC와 모바일APP에서 가능합니다");
			}
			return;
		});
		$("#goapply").click(function(){
			if(!coinEvtChk()){
				return ;
			}else{
				var cls = $("#applyPrize").find(".info_agree .unchk2").attr("class");
				var _selected = "";
				if(cls == "unchk2"){//체크 안함
					alert("개인정보 활용에 동의해주세요!");
					return false;
				}else{
					var uphone = $("#p_numb").val();
					var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;//전화번호 체크

					if(!uphone || !regExp.test(uphone)){
						alert("휴대폰번호를 정확히 입력해주세요");
						$("#p_numb").focus();
						return false;
					}
				}
				loadPostData(2);
			}

		});
	}
}

function drawMyApply(json){
	var vWinCnt = json["winCnt"];
	var vTotalCnt = json["totalCnt"];
	var vUseCnt = json["useCnt"];
	var vCoinUseList = json["coinUseList"];
	$("#giveaway").find(".mycheck_box .get em").html(commaNum(json["winCnt"]));
	$("#giveaway").find(".mycheck_box .remain em").html(commaNum(json["totalCnt"]));
	$("#giveaway").find(".detail_box .used strong em").html(commaNum(json["useCnt"]));
	if(vCoinUseList.length > 0){
		var html ="";
		$.each(vCoinUseList,function(index,listdata){
			html += "<tr>";
			html +="<th>"+(index+1)+"</th>";
			html +="<td>"+listdata["ins_date"]+"</td>";

			if	   (listdata["select_seq"] =="1" )	html +="<td>캐리어 창문형 에어컨</td>";
			else if(listdata["select_seq"] =="2" )	html +="<td>갤럭시 A32 자급제</td>";
			else if(listdata["select_seq"] =="3" )	html +="<td>60계 치킨 기프티콘</td>";

			html +="<td>"+listdata["coin"]+"</td>";
			html +="</tr>";

			$("#giveaway").find(".detail_box .detail_view tbody").html(html);

			// ga('send', 'event', '2020히트브랜드' ,'button', '2020상반기히트브랜드_응모현황');
		});
	}
	openLayer('giveaway');
}

// 결과 레이어
function resultLayer(num){
	if ( num == 2 ){ // 2 - 잭팟
		openLayer('winJackpot');
	}else{
		var $winCoinHead = $("#winCoin").find("h4 em");
		if ( num == 0 ){ // 0 - 꽝 : 1코인
			$winCoinHead.html("1");
		}else{ // 1,3~50 - 100코인 당첨
			$winCoinHead.html("100");
		}
		openLayer('winCoin');
	}
	slotmReset();
}

function slotmReset(){ // 초기화
	// Reset
	loadPostData(0);
	getPoint();
	$("#slotstart").removeClass("playing");
	$(".box").find("ul").removeClass("anim animA animB animC anim1 anim2 anim3");
}

//이벤트 공통체크로직
function evtCommonChk (procCode) {
	var chkResult = false;
	// 매일 히트상품, 스페셜경품전 이벤트 기간
	var chkDate = [
		{"startDate" : 20210616, "endDate" : 20210730}
	];
	if(Number(sdt) < chkDate[0].startDate) {
		alert("이벤트 기간이 아닙니다.");
	} else if(chkDate[0].endDate < sdt) {
		alert("이벤트가 종료되었습니다.");
	}else if (!islogin()) {
		alert("로그인 후 응모 가능합니다");
		goLogin();
	} else {
		chkResult = true;
	}
	return chkResult;
}

//코인응모 날짜체크
function coinEvtChk () {
	var chkResult = false;

	var chkDate = [
		{"startDate" : 20210616, "endDate" : 20210730}
	];
	if(Number(sdt) < chkDate[0].startDate) {
		alert("이벤트 기간이 아닙니다.");
	} else if(chkDate[0].endDate < sdt) {
		alert("이벤트가 종료되었습니다.");
	}else if (!islogin()) {
		alert("로그인 후 응모 가능합니다");
		goLogin();
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
			tabId.css({"z-index":"1000"});
		} else {
			tabId.removeAttr("style");
		}
	});
}

function goJoin(){
	window.open("https://ad.esmplus.com/");
	return false;
}

var isClick = true;

function clickTFwd(clickUrl) {
	//이베이 측 통계를 위해 단순 url 호출(이베이측 요청 - 테스트 페이지에서는 호출이 일어나면 안됨!)

	if(location.href.indexOf("local") > -1 || location.href.indexOf("dev") > -1 || location.href.indexOf("stagedev") > -1 || location.href.indexOf("my.") > -1){
		console.log("test-powerClickAnalysis()");
	} else {
		var imgSrc = new Image();
		imgSrc.src = clickUrl;
	}

}
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
	mCate.put("1",["0201","0232","0318","0363"]);
	mCate.put("2",["0502","0602","2401","2406"]);
	mCate.put("3",["0402","0404","0405"]);
	mCate.put("4",["0805","0908","1644"]);

	var cls = $(".menu > .on").attr("tabno");
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
			else if(result.sum_sort2.hasOwnProperty("second"))			obj = result.sum_sort2.second.items;

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
				//var varShippingFee = totalObj[i].shipping_fee;	//배송비

				var varImpPrice = 0;
				var varShipFeeTxt = "무료배송";
				var varShipClass ="deli_free";
				var varShopNm = "";

				var varLanding = val.landing;
				var varShippingFee = val.shipping_fee;

				var varOnClickT = " onclick=\"clickTFwd('" + varClickT + "');\"";


				varRanUrl = varLanding;
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

function replaceTxt(txt){
	var txt = txt.replace(/\n/ig, '<br>');
	return txt;
}

function hitbrandLog(uniqueCode, logFlag, device){
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
Map = function(){this.map = new Object();}
Map.prototype = {
	put : function(key, value){this.map[key] = value;},
	get : function(key){return this.map[key];},
	containsKey : function(key){return key in this.map;},
	containsValue : function(value){for(var prop in this.map){if(this.map[prop] == value) return true;} return false;},
	isEmpty : function(key){return (this.size() == 0);},
	clear : function(){for(var prop in this.map){delete this.map[prop];}},
	remove : function(key){delete this.map[key];},
	keys : function(){var keys = new Array(); for(var prop in this.map){keys.push(prop);} return keys;},
	values : function(){var values = new Array(); for(var prop in this.map){values.push(this.map[prop]);} return values;},
	size : function(){var count = 0; for (var prop in this.map) {count++;} return count;}
};

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
//레이어
function openLayer(IdName){
	var pop = document.getElementById(IdName);
	pop.style.display = "block";
}
function closeLayer(IdName){
	var pop = document.getElementById(IdName);
	pop.style.display = "none";
}

</script>

<!---------------------------------------------------- //레이어 영역 ---------------------------------------------------->

</body>
</html>
<script type="text/javascript" src="http://img.enuri.info/common/js/Log_Tail_Mobile.js"></script>