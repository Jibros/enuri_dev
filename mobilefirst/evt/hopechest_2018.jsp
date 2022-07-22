<%@ page contentType="text/html;charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>

<%
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
	response.sendRedirect("http://www.enuri.com/event2018/hopechest_2018.jsp");
}

String chkId   = ChkNull.chkStr(request.getParameter("chk_id"),"");
String cUserId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK"),"");

Members_Proc members_proc = new Members_Proc();
String cUsername = members_proc.getUserName(cUserId);
String userArea = cUsername;

long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String sdt =dayTime.format(new Date(cTime));//진짜시간

//test
if( request.getServerName().equals("dev.enuri.com") && request.getParameter("sdt")!=null && !request.getParameter("sdt").equals("")){
    sdt= request.getParameter("sdt");
}

String strUrl = request.getRequestURI();

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;

    if(cUsername.equals("")){
        userArea = cUserNick;
    }
    if(userArea.equals("")){
        userArea = cUserId;
    }
}
String strFb_title = "[에누리 가격비교]";
String strFb_description = "혼수 프로모션/기획전";
String strFb_img = ConfigManager.IMG_ENURI_COM+"/images/mobilenew/images/enuri_logo_facebook200.gif";
String tab = ChkNull.chkStr(request.getParameter("tab"));

%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
    <meta property="og:title" content="<%=strFb_title%>">
    <meta property="og:description" content="<%=strFb_description%>">
    <meta property="og:image" content="<%=strFb_img%>">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/hopechest_m.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
</head>
<body>
<div id="eventWrap" class="wrap">

	<div class="myarea">
        <p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>
		<a href="javascript:///" class="win_close">창닫기</a>
	</div>
  
<!-- 상단비주얼 -->
	<div class="visual">
		<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hopechest/m_visual.png" alt="최저가 견적으로 최고의 혼수득템" class="imgs" />
	</div>

	<!-- 플로팅 탭 -->
	<div class="floattab">
		<div class="contents">
			<ul class="floattab__list">
				<li><a href="#evt1" class="floattab__item floattab__item--01 is-on">혼수이벤트</a></li>
				<li><a href="#evt2" class="floattab__item floattab__item--02">가격대별 혼수패키지</a></li>
				<li><a href="#evt3" class="floattab__item floattab__item--03">공간별 실속혼수</a></li>
			</ul>
		</div>
	</div>
	<!-- //플로팅 탭 -->


	<!-- 혼수이벤트 -->
	<div id="evt1" class="section promotionwrap">
		<div class="contents">
			<div class="promotion__head">
				<div class="promotion__tab">
					<ul class="promotiontab__list">
						<li><a href="#pm__tab1" class="promotiontab__item promotiontab__item--1 is-on">이벤트 01</a>
						<li><a href="#pm__tab2" class="promotiontab__item promotiontab__item--2">이벤트 02</a>
					</ul>
				</div>
			</div>

			<div class="promotion__cont">
				<!-- 이벤트 1 -->
				<div id="pm__tab1" class="pm__tab">
					<h2 class="pm__tab1--tit">우리 꽃길만 걷자! 꽃길 고르면 스벅커피 드려요</h2>

					<div class="selectroadbox">
						<div class="selectroad__bg">어느 길이 꽃길일까요? 1~3번 중 클릭해주세요!</div>

						<!--
							선택 후 보이는 BG (default 비노출)
						-->
						<div class="resultroad__bg resultroad__bg--1">꽃길</div>
						<div class="resultroad__bg resultroad__bg--2">레드카펫</div>
						<div class="resultroad__bg resultroad__bg--3">새싹길</div>

						<!-- 1,2,3 번 선택 박스 -->
						<ul class="slecetbox__list">
							<li class="slecetbox__item slecetbox__item--1">1번</li>
							<li class="slecetbox__item slecetbox__item--2">2번</li>
							<li class="slecetbox__item slecetbox__item--3">3번</li>
						</ul>

					</div>

					<a href="#" class="btn__caution" onclick="onoff('notetxt1'); return false;">꼭 확인하세요</a>
				</div>
				<!-- //이벤트 1 -->

				<!-- 이벤트 2 -->
				<div id="pm__tab2" class="pm__tab" style="display:none;">
					<div class="pmevt2box">
						<div class="blind">
							<h2>APP에서 혼수 구매하면 다이슨 청소기 드려요</h2>
							<p>행운상 1명 다이슨 V8 앱솔루드</p>
							<ul>
								<li>혼수지원금 50만원 500만원 이상 구매 1명</li>
								<li>혼수지원금 20만원 300만원 이상 구매 5명</li>
								<li>혼수지원금 5만원 100만원 이상 구매 10명</li>
							</ul>
							<p>※ 해당 금액 상당의 e머니로 지급</p>
						</div>
						<a href="#" onclick="onoff('categorytable'); return false;" class="btn btn__category">해당 카테고리 확인</a>
						<a href="javascript:///"  class="btn btn__join" id="event2_join">응모하기</a>
					</div>

					<ul class="pmevt2__info">
						<li>이벤트 참여 및 구매 기간 : 2018년 4월10일 ~ 4월 30일</li>
						<li>당첨자 발표 : 2018년 6월 11일 월요일</li>
						<li>응모 시 휴대폰번호 잘못  기입했거나 연락이 되지 않아 발생하는 불이익에 대해서는 책임지지 않습니다.</li>
					</ul>

					<a href="#" class="btn__caution" onclick="onoff('notetxt2'); $(document).scrollTop(0); return false;">꼭 확인하세요</a>
				</div>
				<!-- //이벤트 2 -->

				<script type="text/javascript">
				$(function(){
					$(".promotiontab__item").click(function(){
						
						ga_log(35 + $(this).parent().index());
						
						$(".promotiontab__item").removeClass("is-on");
						$(this).addClass("is-on");

						$(".pm__tab").hide();
						$($(this).attr("href")).show();

						return false;
					});
				})
				</script>
			</div>
		</div>
	</div>
	<!-- //혼수이벤트 -->


	<!-- 이벤트1 유의사항 -->
	<div class="layer_back" id="notetxt1" style="display:none;">
		<div class="dim"></div>
		<div class="noteLayer">
			<h4>유의사항</h4>
			<a href="javascript:///" class="close" onclick="onoff('notetxt1');return false;">창닫기</a>

			<div class="inner">
				<ul class="txtlist">
					<li>ID당 1일 1회 참여 가능 (카드 공유 시 1회 더)</li>
					<li>이벤트 경품: e5,000점, e10점, 꽝</li>
					<li>적립된 e머니는 e머니 스토어에서 다양한 e쿠폰상품으로 교환 가능합니다.</li>
					<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
					<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
				</ul>
			</div>
			<p class="btn_close"><button type="button" onclick="onoff('notetxt1');return false;">닫기</button></p>
		</div>
	</div>

	<!-- 이벤트2 해당 카테고리 -->
	<div class="layer_back" id="categorytable" style="display:none;">
		<div class="dim"></div>
		<div class="noteLayer">
			<h4>이벤트 대상 카테고리</h4>
			<a href="javascript:///" class="close" onclick="onoff('categorytable');return false;">창닫기</a>

			<div class="inner">
				<ul class="txtlist">
					<li>이벤트 참여 및 구매 기간 : 2018년 4월10일 ~ 4월 30일</li>
					<li>아래 카테고리에서 구매하고 이벤트 응모 시 참여금액에 포함됩니다.</li>
				</ul>

				<table class="popup_table">
					<colgroup>
						<col />
						<col />
						<col />
						<col />
						<col />
					</colgroup>
					<thead>
						<tr>
							<th>탭 명</th>
							<th colspan="4">카테고리</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th>필수가전</th>
							<td>TV</td>
							<td>냉장고</td>
							<td>세탁기</td>
							<td>의류건조기</td>
						</tr>
						<tr>
							<th>주방혼수</th>
							<td>전기밥솥</td>
							<td>주방가전</td>
							<td>주방가구</td>
							<td>식기류</td>
						</tr>
						<tr>
							<th>거실혼수</th>
							<td>소파</td>
							<td>거실가구</td>
							<td>홈시어터</td>
							<td>공기청정기</td>
						</tr>
						<tr>
							<th>침실혼수</th>
							<td>침대</td>
							<td>옷장</td>
							<td>화장대</td>
							<td>조명</td>
						</tr>
						<tr>
							<th>시공 인테리어</th>
							<td>드레스룸</td>
							<td>시스템키친</td>
							<td>욕실</td>
							<td>현관</td>
						</tr>
					</tbody>
				</table>
			</div>
			<p class="btn_close"><button type="button" onclick="onoff('categorytable');return false;">닫기</button></p>
		</div>
	</div>

	<!-- 이벤트2 유의사항 상단에서 열림 -->
	<div class="layer_back nofix" id="notetxt2" style="display:none;">
		<div class="dim"></div>
		<div class="noteLayer no_fixed">
			<h4>유의사항</h4>
			<a href="javascript:///" class="close" onclick="onoff('notetxt2');return false;">창닫기</a>

			<div class="inner">
				<dl class="txtlist">
					<dt>이벤트/구매 기간 :</dt>
					<dd>2018년 4월 10일 ~ 4월 30일</dd>
				</dl>

				<dl class="txtlist">
					<dt>경품 : </dt>
					<dd>[행운상] 다이슨 V8 앱솔루트 (1명 추첨)<br /><strong class="emp">: 해외배송상품 실물 배송으로 당첨시 개인통관고유부호 필수! </strong> <u>※제세공과금 당첨자 부담 </u></dd>
					<dd>[500만원 이상 구매자] 신세계 백화점 상품권 50만원 (1명 추첨) – 제세공과금 당첨자 부담</dd>
					<dd>[300만원 이상 구매자] 신세계 백화점 상품권 20만원 (5명 추첨) – 제세공과금 당첨자 부담 </dd>
					<dd>[100만원 이상 구매자] e머니 50,000점 (10명 추첨) </dd>
					<dd><strong class="emp">e머니 유효기간 : 적립일로부터 15일</strong></dd>
					<dd>적립된 e머니는 e쿠폰 스토어에서 다양한 e쿠폰으로 교환 가능합니다.<br /><u>※ 사정에 따라 경품이 변경될 수 있습니다.</u></dd>
				</dl>

				<dl class="txtlist">
					<dt>당첨자 발표 및 적립</dt>
					<dd>2018년 6월 11일 [APP 이벤트/기획전 탭 &gt; 이벤트 &gt; 당첨자 발표]</dd>
				</dl>

				<dl class="txtlist">
					<dt>이벤트 유의사항</dt>
					<dd>응모 시 이벤트 기간 내 해당 카테고리 상품 구매금액이 자동 합산됩니다.</dd>
					<dd><strong class="emp">응모 시 입력한 휴대폰번호로 개별연락 드리며 잘못된 정보 기입했거나 연락이 되지 않아 발생하는 불이익에 대해서는 책임지지 않습니다.</strong></dd>
				</dl>

				<dl class="txtlist">
					<dt>아래의 경우에는 구매 확인 및 적립이 불가합니다.</dt>
					<dd>에누리 가격비교 앱이 아닌 다른 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 앱으로 결제만 한 경우<br />(에누리 가격비교 앱을 통해 쇼핑몰로 이동 후 장바구니/관심상품 등록 후 구매 시에는 가능)</dd>
					<dd>에누리 가격비교 앱 미 로그인 후 구매한 경우 또는 에누리 가격비교 PC, 모바일 웹에서 구매한 경우</dd>
				</dl>

				<dl class="txtlist">
					<dt>유의사항</dt>
					<dd>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</dd>
				</dl>
			</div>
			<p class="btn_close"><button type="button" onclick="onoff('notetxt2');return false;">닫기</button></p>
		</div>
	</div>


	<!-- 당첨 레이어 -->
	<div class="voteResult_layer" id="prizes" style="display:none">
		<div class="inner_layer">
			<div class="cont_area">
				<div class="img_box">
					<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hopechest/m_vote_img01.png" alt="꽃길 당첨 축하합니다! 내일 또 만나요~" class="p_img" />
					<!--
					<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hopechest/m_vote_img02.png" alt="5점 적립 레드카펫이 펼쳐져 있네요~ 인생에서 당신이 언제나 주인공! 내일은 꽃길에서 만나요~" class="p_img" />
					<img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hopechest/m_vote_img03.png" alt="5점 적립 푸릇푸릇 새싹길이네요. 무럭무럭 자라서 꽃길만 가득하시길! 내일은 꽃길에서 만나요~" class="p_img" />
					-->
				</div>

				<a class="btn layclose" href="#" onclick="onoff('prizes'); return false;"><em>팝업 닫기</em></a>
			</div>
		</div>
	</div>

	<!-- 2018-03-12 이벤트 응모하기 레이어 -->
	<div class="event_layer" id="eventJoin" style="display:none">
		<div class="inner_layer">
			<div class="head">
				<h2 class="p_tit stripe_layer">이벤트 응모하기</h2>
			</div>
			<h3 class="tit stripe_layer">참여해주셔서 감사합니다. 당첨 시 경품배송을 위해 정확한 정보를 입력해 주세요.</h3>
			<a href="javascript:///" class="stripe_layer close" onclick="onoff('eventJoin')">창닫기</a>

			<div class="viewer">
				<fieldset>
					<legend>경품 발송을 위한 정보 입력</legend>
					<label>
						<p>휴대폰번호</p>
						<input type="number" id="u_phone" name="u_phone" class="ipt_box" max="11" value="" placeholder="휴대폰 번호를 입력해 주세요" />
					</label>
					<div class="agree_chk">
						<span class="unchk" onclick="agreechk(this);"><input type="checkbox" checked="checked" id="chkautologin" name="agreechk" value="Y">위 개인 정보 활용에 동의 합니다.</span>
						<a href="javascript:///" class="btn_detail stripe_layer" onclick="onoff('privacy')">자세히보기</a>
					</div>
				</fieldset>
			</div>
			<p class="btn_close"><button type="button" id="event2_submit" class="stripe_layer complete" >응모완료</button></p>

			<p class="caution_info stripe_layer">
				<strong>꼭 알아두세요!</strong>
				입력하신 정보는 당첨자의 확인 및 경품 발송을 위해서만 이용 후 파기합니다.<br />잘못된 정보 입력으로 인한 경품 수령의 불이익은 책임지지 않습니다
			</p>
		</div>
	</div>

	<!-- 2018-03-12 개인정보 수집 이용안내 레이어 -->
	<div class="event_layer" id="privacy" style="display:none">
		<div class="inner_layer privacy">
			<h3 class="tit stripe_layer">개인정보 수집·이용안내</h3>
			<a href="javascript:///" class="stripe_layer close" onclick="onoff('privacy')">창닫기</a>

			<div class="viewer">
				<!-- 개인정보 -->
				<div class="privacy__area">
					<p>에누리 가격비교는 이벤트 참여확인 및 경품 발송을 위하여 아래와 같이 개인 정보를 수집하고 있습니다. </p>
					<dl>
						<dt>1. 개인정보 수집 항목</dt>
						<dd>휴대폰 번호, 회원ID, 참여 일시</dd>
						<dt>2. 개인정보 수집 및 이용 목적</dt>
						<dd>이벤트를 위해 수집된 개인정보는 이벤트 참여확인 및 경품 발송을 위한 본인확인 이외의 목적으로 활용되지 않습니다.</dd>
						<dt>3. 개인정보 보유 및 이용 기간</dt>
						<dd>개인 정보 수집자(에누리 가격비교)는 개인 정보의 수집 및 이용 목적이 달성되면 개인 정보를 즉시 파기합니다.</dd>
					</dl>
				</div>
				<!-- //개인정보 -->
			</div>
			<p class="btn_close"><button type="button" class="stripe_layer privacy__close" onclick="onoff('privacy')">닫기</button></p>
		</div>
	</div>
	
	<span id = "rcmPak">
	<!-- 가격대별 혼수패키지 -->
	<div id="evt2" class="pricepackage">
		<div class="contents">
			<h2 class="title">가격대별 혼수패키지</h2>
			<!-- liveProduct -->
			<div class="liveProduct">
				<ul class="pp_tabs tabs">
					<li v-on:click="changeTab" data-idx = "0"><a href="javascript:///" class="tab1">300만원대 알뜰혼수</a></li>
					<li v-on:click="changeTab" data-idx = "1"><a href="javascript:///" class="tab2">500만원대 실속혼수</a></li>
					<li v-on:click="changeTab" data-idx = "2"><a href="javascript:///" class="tab3">1,000만원대 프리미엄혼수</a></li>
				</ul>
				<!-- tab_container -->
				<div class="tab_container">
					<!-- tab1 -->
					<div id="tab1" class="tab_content">
						<div class="lp_tabs_cont">
							<!-- items_area -->
							<div class="items_area">
								<!-- itembox -->
								<div class="itembox" v-for = "n in 2">
									<div class="itemtit">
										<p class="subtit">{{ selectedItemsTitle[n-1][0] }}</p>
										<p class="tit">{{ selectedItemsTitle[n-1][1] }}</p>
									</div>
									<ul class="itemlist">
										<template v-for="(item, index) in items[n-1]" >
										<li class="top">
		                                	<a href="javascript:///" title="새 탭에서 열립니다." class="btn" v-on:click= "ga_log(9);itemClick(item.MODELNO, item.MINPRICE3);">
												<div class="imgs">
													<template v-if="item.MINPRICE3 == 0">
	                                                    <span class="soldout">SOLD OUT</span>
	                                                </template>
													<template v-if="item.GOODS_IMG">
														<img v-bind:data-lazy= "item.GOODS_IMG" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png" alt="" />
													</template>
													<template v-else>
														<img v-bind:data-lazy= "item.IMG_SRC" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png" alt="" />
													</template>
												</div>
												<div class="info">
													<p class="pname">{{ item.TITLE1 }}<br />{{item.TITLE2}} </p>
													<p class="price"><span class="lowst">최저가</span><b>{{commaNum(item.MINPRICE3) }}</b>원</p>
												</div>
											</a>
										</li>
										</template>
									</ul>
									<!-- estimatebox -->
									<div class="estimatebox">
										<h3><em>{{ selectedestimateTitle[n-1] }}</em></h3>
										<table>
											<colgroup>
												<col width="52px" /><col width="187px" /><col width="15px" /><col width="73px" />
											</colgroup>
											<thead class="blind">
												<tr>
													<th>분류</th>
													<th>상품명</th>
													<th>수량</th>
													<th>가격</th>
												</tr>
											</thead>
											<tbody>
											<tr v-for="(item, index) in items[n-1]">
												 <td class="sort">{{ item.itemCateNm }}</td>
												<td class="proname"><p>{{ item.TITLE1 }}&nbsp;{{item.TITLE2}}</p></td>
												<td class="num">1</td>
												<td class="price"><b>{{commaNum(item.MINPRICE3) }}</b>원</td>
											</tr>
										</tbody>
										<tfoot>
											<tr>
												<td colspan="3"><span class="blind">종합</span></td>
												<td class="price"><b>{{commaNum(itemsTotalPrice[n-1])}}</b>원</td>
											</tr>
										</tfoot>
										</table>
									</div>
									<!-- //estimatebox -->
								</div>
								<!-- //itembox -->
							</div>
							<!-- //items_area -->
						</div>
					</div>
					<!-- //tab1 -->
				</div>
				<!-- //tab_container -->
			</div>
			<!-- /liveProduct -->
		</div>
	</div>
	<!-- //가격대별 혼수패키지 -->


	<!-- 인기 혼수 아이템 -->
	<div class="popular_item">
		<div class="contents">
			<h2 class="title">인기 혼수 아이템</h2>
			<!-- box_keyword -->
			<div class="box_keyword">
				<template v-for="(item, index) in tagList" >
					<a v-bind:href="item.M_URL" target="_blank" title="새창으로 열림" onclick="ga_log(10);">{{ item.KEYWORD }}</a>
				</template>
			</div>
			<!-- //box_keyword -->
		</div>
	</div>
	<!-- //인기 혼수 아이템 -->

	</span>

	<!-- 이벤트 바로가기 영역 -->
	<div class="evt_area">
		<a href="/mobilefirst/evt/welcome_event.jsp?tab=4&freetoken=eventclnoe" class="btn_go" target="_blank" onclick="ga_log(11);"><img src="http://imgenuri.enuri.gscdn.com/images/event/2018/hopechest/m_evt_area2.png" alt="APP에서 TV/냉장고/전기밥솥 사면?e머니 3배적립" class="imgs" /></a>

	</div>
	<!-- //이벤트 바로가기 영역 -->


	<!-- 공간별 맞춤혼수 -->
	<div id="evt3" class="priceListWrap">
		<div class="contents">
			<h2 class="title">공간별 맞춤혼수</h2>
			<!-- liveProduct -->
			<div class="liveProduct">
				<ul class="pp_tabs tabs">
					<li onclick="ga_log(12);viewItem(0);"><a href="javascript:///" class="tab1">거실</a></li>
					<li onclick="ga_log(13);viewItem(1);"><a href="javascript:///" class="tab2">침실</a></li>
					<li onclick="ga_log(14);viewItem(2);"><a href="javascript:///" class="tab3">주방</a></li>
					<li onclick="ga_log(15);viewItem(3);"><a href="javascript:///" class="tab4">서재/드레스룸</a></li>
				</ul>
				<!-- tab_container -->
				<div class="tab_container">
					<!-- tab4 -->
					<div id="tab4" class="tab_content">
						<span id ="spaceArea"></span>
						<p class="moreview"><a href="javascript:///" class="btn_promore" onclick="ga_log(17);moreItem();">상품 더보기</a></p>
					</div>
					<!-- //tab4 -->
				</div>
				<!-- //tab_container -->
			</div>
			<!-- //liveProduct -->
		</div>
	</div>
	<!-- //공간별 맞춤혼수 -->
	<!-- 마켓 배너 -->
	<div class="banner_market">
		<div class="contents">
			<h2 class="title">혼수 기획전</h2>
			<div class="item_list">
				<a href="javascript:///" target="_blank" title="새탭열기">
					<img class="thumb" src="http://imgenuri.enuri.gscdn.com/images/event/2018/hopechest/ban_market1.png" alt="혼수가전기획전" />
				</a>
				<a href="javascript:///" target="_blank" title="새탭열기">
					<img class="thumb" src="http://imgenuri.enuri.gscdn.com/images/event/2018/hopechest/ban_market2.png" alt="축의금+집들이선물 기획전" />
				</a>
				<a href="javascript:///" target="_blank" title="새탭열기">
					<img class="thumb" src="http://imgenuri.enuri.gscdn.com/images/event/2018/hopechest/ban_market3.png" alt="주방 혼수용품 기획전" />
				</a>
				<a href="javascript:///" target="_blank" title="새탭열기">
					<img class="thumb" src="http://imgenuri.enuri.gscdn.com/images/event/2018/hopechest/ban_market4.png" alt="혼수가구 기획전" />
				</a>
			</div>
		</div>
	</div>
	<!-- //마켓 배너 -->
	<script type="text/javascript">
	$(".banner_market .item_list a").click(function(e){
		var idx = $(this).index();
		var planListNos = [ "B_20170822132201","B_20170816011123", "B_20180321010101", "B_20180308091533" ];
		ga_log(18);
		window.open("/mobilefirst/planlist.jsp?t=" + planListNos[idx-1] + "&freetoken=plan");
	});
	</script>

	<!-- 하단 상품 리스트 -->
	<div class="btitem_list">
		<div class="contents">
			<h2 class="blind">하단 상품</h2>
			<!-- quick1 liveProduct -->
			<div  id="quick1" class="liveProduct">
				<h3>필수가전</h3>
				<ul class="pp_tabs">
					<li v-on:click="changeTab" data-idx = "0" class="on"><a href="javascript:///" class="tab1">TV</a></li>
					<li v-on:click="changeTab" data-idx = "1" ><a href="javascript:///"  class="tab2">냉장고</a></li>
					<li v-on:click="changeTab" data-idx = "2" ><a href="javascript:///"  class="tab3">세탁기</a></li>
					<li v-on:click="changeTab" data-idx = "3" ><a href="javascript:///"  class="tab4">의류건조기</a></li>
				</ul>
				<!-- tab_container -->
				<div class="tab_container">
					<!-- tab8 -->
					<div id="tab8" class="tab_content">
						<div class="lp_tabs_cont">
							<!-- items_area -->
							<div class="items_area" id="quick1Area">
								<!-- itembox -->
								<div class="itembox" v-for="n in slickSize">
									<ul class="itemlist" >
										<li v-for = "(item, index) in selectedItems"  v-if =" index >= (n-1)*4 && index < 4*n"  v-on:click= "ga_log(20); itemClick(item.MODELNO, item.MINPRICE3)">
											<a href="javascript:///" title="새 탭에서 열립니다." class="btn">
												<div class="imgs">
													<template v-if="item.GOODS_IMG">
														<img v-bind:data-lazy= "item.GOODS_IMG" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png" alt="" />
													</template>
													<template v-else>
														<img v-bind:data-lazy= "item.IMG_SRC" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png" alt="" />
													</template>
												</div>
												<div class="info">
													<p class="pname">{{ item.TITLE1 }}<br />{{item.TITLE2}}</p>
													<p class="price"><span class="lowst">최저가</span><b>{{commaNum(item.MINPRICE3) }}</b>원</p>
												</div>
											</a>
										</li>
									</ul>
								</div>
								<!-- //itembox -->
								
							</div>
							<!-- //items_area -->
						</div>
						<p class="moreview"><a href="javascript:///" class="btn_promore" v-on:click="moveLP(selectedCateNo)">상품 더보기</a></p>
					</div>
					<!-- //tab8 -->
				</div>
				<!-- //tab_container -->
			</div>
			<!-- //quick1 liveProduct -->
			<!-- quick2 liveProduct -->
			<div  id="quick2" class="liveProduct">
				<h3>주방혼수</h3>
				<ul class="pp_tabs">
					<li v-on:click="changeTab" data-idx = "0" class="on"><a href="javascript:///" class="tab1">전기밥솥</a></li>
					<li v-on:click="changeTab" data-idx = "1" ><a href="javascript:///"  class="tab2">주방가전</a></li>
					<li v-on:click="changeTab" data-idx = "2" ><a href="javascript:///"  class="tab3">주방가구</a></li>
					<li v-on:click="changeTab" data-idx = "3" ><a href="javascript:///"  class="tab4">식기류</a></li>
				</ul>
				<!-- tab_container -->
				<div class="tab_container">
					<!-- tab12 -->
					<div id="tab12" class="tab_content">
						<div class="lp_tabs_cont">
							<!-- items_area -->
							<div class="items_area" id="quick2Area">
								<!-- itembox -->
								<div class="itembox" v-for="n in slickSize">
									<ul class="itemlist" >
										<li v-for = "(item, index) in selectedItems"  v-if =" index >= (n-1)*4 && index < 4*n"  v-on:click= "ga_log(22); itemClick(item.MODELNO, item.MINPRICE3)">
											<a href="javascript:///" title="새 탭에서 열립니다." class="btn">
												<div class="imgs">
													<template v-if="item.GOODS_IMG">
														<img v-bind:data-lazy= "item.GOODS_IMG" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png" alt="" />
													</template>
													<template v-else>
														<img v-bind:data-lazy= "item.IMG_SRC" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png" alt="" />
													</template>
												</div>
												<div class="info">
													<p class="pname">{{ item.TITLE1 }}<br />{{item.TITLE2}}</p>
													<p class="price"><span class="lowst">최저가</span><b>{{commaNum(item.MINPRICE3) }}</b>원</p>
												</div>
											</a>
										</li>
									</ul>
								</div>
								<!-- //itembox -->
								
							</div>
							<!-- //items_area -->
						</div>
						<p class="moreview"><a href="javascript:///" class="btn_promore" v-on:click="moveLP(selectedCateNo)">상품 더보기</a></p>
					</div>
					<!-- // tab12 -->
				</div>
				<!-- //tab_container -->
			</div>
			<!-- //quick2 liveProduct -->
			<!-- quick3 liveProduct -->
			<div  id="quick3" class="liveProduct">
				<h3>거실혼수</h3>
				<ul class="pp_tabs">
					<li v-on:click="changeTab" data-idx = "0" class="on"><a href="javascript:///" class="tab1">소파</a></li>
					<li v-on:click="changeTab" data-idx = "1" ><a href="javascript:///"  class="tab2">거실가구</a></li>
					<li v-on:click="changeTab" data-idx = "2" ><a href="javascript:///"  class="tab3">홈시어터</a></li>
					<li v-on:click="changeTab" data-idx = "3" ><a href="javascript:///"  class="tab4">공기청정기</a></li>
				</ul>
				<!-- tab_container -->
				<div class="tab_container">
					<!-- tab16 -->
					<div id="tab16" class="tab_content">
						<div class="lp_tabs_cont">
							<!-- items_area -->
							<div class="items_area" id="quick3Area">
								<!-- itembox -->
								<div class="itembox" v-for="n in slickSize">
									<ul class="itemlist" >
										<li v-for = "(item, index) in selectedItems"  v-if =" index >= (n-1)*4 && index < 4*n"  v-on:click= "ga_log(24); itemClick(item.MODELNO, item.MINPRICE3)">
											<a href="javascript:///" title="새 탭에서 열립니다." class="btn">
												<div class="imgs">
													<template v-if="item.GOODS_IMG">
														<img v-bind:data-lazy= "item.GOODS_IMG" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png" alt="" />
													</template>
													<template v-else>
														<img v-bind:data-lazy= "item.IMG_SRC" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png" alt="" />
													</template>
												</div>
												<div class="info">
													<p class="pname">{{ item.TITLE1 }}<br />{{item.TITLE2}}</p>
													<p class="price"><span class="lowst">최저가</span><b>{{commaNum(item.MINPRICE3) }}</b>원</p>
												</div>
											</a>
										</li>
									</ul>
								</div>
								<!-- //itembox -->
							</div>
							<!-- //items_area -->
						</div>
						<p class="moreview"><a href="javascript:///" class="btn_promore" v-on:click="moveLP(selectedCateNo)">상품 더보기</a></p>
					</div>
					<!-- // tab16 -->
				</div>
				<!-- //tab_container -->
			</div>
			<!-- //quick3 liveProduct -->
			<!-- quick4 liveProduct -->
			<div  id="quick4" class="liveProduct">
				<h3>침실혼수</h3>
				<ul class="pp_tabs">
					<li v-on:click="changeTab" data-idx = "0" class="on"><a href="javascript:///" class="tab1">침대</a></li>
					<li v-on:click="changeTab" data-idx = "1" ><a href="javascript:///"  class="tab2">옷장</a></li>
					<li v-on:click="changeTab" data-idx = "2" ><a href="javascript:///"  class="tab3">화장대</a></li>
					<li v-on:click="changeTab" data-idx = "3" ><a href="javascript:///"  class="tab4">조명</a></li>
				</ul>
				<!-- tab_container -->
				<div class="tab_container">
					<!-- tab20 -->
					<div id="tab20" class="tab_content">
						<div class="lp_tabs_cont">
							<!-- items_area -->
							<div class="items_area" id="quick4Area">
								<!-- itembox -->
								<div class="itembox" v-for="n in slickSize">
									<ul class="itemlist" >
										<li v-for = "(item, index) in selectedItems"  v-if =" index >= (n-1)*4 && index < 4*n"  v-on:click= "ga_log(26); itemClick(item.MODELNO, item.MINPRICE3)">
											<a href="javascript:///" title="새 탭에서 열립니다." class="btn">
												<div class="imgs">
													<template v-if="item.GOODS_IMG">
														<img v-bind:data-lazy= "item.GOODS_IMG" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png" alt="" />
													</template>
													<template v-else>
														<img v-bind:data-lazy= "item.IMG_SRC" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png" alt="" />
													</template>
												</div>
												<div class="info">
													<p class="pname">{{ item.TITLE1 }}<br />{{item.TITLE2}}</p>
													<p class="price"><span class="lowst">최저가</span><b>{{commaNum(item.MINPRICE3) }}</b>원</p>
												</div>
											</a>
										</li>
									</ul>
								</div>
								<!-- //itembox -->
							</div>
							<!-- //items_area -->
						</div>
						<p class="moreview"><a href="javascript:///" class="btn_promore" v-on:click="moveLP(selectedCateNo)">상품 더보기</a></p>
					</div>
					<!-- // tab20 -->
				</div>
				<!-- //tab_container -->
			</div>
			<!-- //quick4 liveProduct -->
			<!-- quick5 liveProduct -->
			<div  id="quick5" class="liveProduct" style="padding-top:80px;">
				<h3>시공 인테리어</h3>
				<ul class="pp_tabs">
					<li v-on:click="changeTab" data-idx = "0" class="on"><a href="javascript:///" class="tab1">드레스룸</a></li>
					<li v-on:click="changeTab" data-idx = "1" ><a href="javascript:///"  class="tab2">시스템키친</a></li>
					<li v-on:click="changeTab" data-idx = "2" ><a href="javascript:///"  class="tab3">욕실</a></li>
					<li v-on:click="changeTab" data-idx = "3" ><a href="javascript:///"  class="tab4">현관</a></li>
				</ul>
				<!-- tab_container -->
				<div class="tab_container">
					<!-- tab24 -->
					<div id="tab24" class="tab_content">
						<div class="lp_tabs_cont">
							<!-- items_area -->
							<div class="items_area" id="quick5Area">
								<!-- itembox -->
								<div class="itembox" v-for="n in slickSize">
									<ul class="itemlist" >
										<li v-for = "(item, index) in selectedItems"  v-if =" index >= (n-1)*4 && index < 4*n"  v-on:click= "ga_log(28); itemClick(item.MODELNO, item.MINPRICE3)">
											<a href="javascript:///" title="새 탭에서 열립니다." class="btn">
												<div class="imgs">
													<template v-if="item.GOODS_IMG">
														<img v-bind:data-lazy= "item.GOODS_IMG" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png" alt="" />
													</template>
													<template v-else>
														<img v-bind:data-lazy= "item.IMG_SRC" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png" alt="" />
													</template>
												</div>
												<div class="info">
													<p class="pname">{{ item.TITLE1 }}<br />{{item.TITLE2}}</p>
													<p class="price"><span class="lowst">최저가</span><b>{{commaNum(item.MINPRICE3) }}</b>원</p>
												</div>
											</a>
										</li>
									</ul>
								</div>
								<!-- //itembox -->
							</div>
							<!-- //items_area -->
						</div>
						<p class="moreview"><a href="javascript:///" class="btn_promore" v-on:click="moveLP(selectedCateNo)">상품 더보기</a></p>
					</div>
					<!-- // tab24 -->
				</div>
				<!-- //tab_container -->
			</div>
			<!-- //quick5 liveProduct -->
		</div>
	</div>
	<!-- //하단 상품 리스트 -->
	<!-- 퀵메뉴 -->
	<span class="btn_quick">
		<a href="javascript:///" onclick="ga_log(29); $('#QuickMenu').show();">빠른 메뉴 열기</a><!-- 필요시 움직임 멈춤 a class="off" -->
	</span>

	<div class="layer_back" id="QuickMenu" style="display:none;">
		<div class="quickLayer">
			<ul>
				<li><a href="#quick1">필수혼수</a></li>
				<li><a href="#quick2">주방혼수</a></li>
				<li><a href="#quick3">거실혼수</a></li>
				<li><a href="#quick4">침실혼수</a></li>
				<li><a href="#quick5">인테리어</a></li>
			</ul>
			<a href="javascript:///" class="btn_qkclose" onclick="$('#QuickMenu').hide();">빠른 메뉴 닫기</a>
		</div>

	</div>
	<!-- 퀵메뉴 -->	
	<span class="go_top"><a onclick="$(window).scrollTop(0);">TOP</a></span>
</div>

<script type="text/javascript">

$(".quickLayer > ul > li").click(function(e){
	ga_log(34 - $(this).index());
});

</script>

<!-- layer-->
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();">설치하기</button></p>
	</div>
</div>

<script>
//플로팅 상단 탭 이동
$(document).on('click', '.floattab__list > li > a', function(e) {
	
	ga_log(2+$(this).parent().index());
	var $anchor = $($(this).attr('href')).offset().top;
		$navHgt = $(".floattab__list").height() + 30;
	
	$('html, body').stop().animate({scrollTop: $anchor - $navHgt}, 500);
	e.preventDefault();
});

$(window).load(function(){
	var $nav = $(".floattab__list"), // scroll tabs
		$navTop = $nav.offset().top;
		$myHgt = $(".myarea").height();

		$ares1 = $("#evt1").offset().top - $nav.outerHeight(),
		$ares2 = $("#evt2").offset().top - $nav.outerHeight(),
		$ares3 = $("#evt3").offset().top - $nav.outerHeight();

	// 상단 탭 position 변경 및 버튼 활성화
	$(window).scroll(function(){
		var $currY = $(this).scrollTop() + $myHgt // 현재 scroll

		if ($currY > $navTop) {
			$nav.addClass("is-fixed");
			//$("#evt1").css("margin-top", $nav.outerHeight());

			if($ares1 <= $currY && $ares2 > $currY){
				$nav.find("a").removeClass("is-on");
				$(".floattab__item--01").addClass("is-on");
			}else if($ares2 <= $currY && $ares3 > $currY){
				$nav.find("a").removeClass("is-on");
				$(".floattab__item--02").addClass("is-on");
			}else if($ares3 <= $currY){
				$nav.find("a").removeClass("is-on");
				$(".floattab__item--03").addClass("is-on");
			}
		} else {
			$nav.removeClass("is-fixed"),
			$("#evt1").css("margin-top", 0);
		}
	});
});


//가격대별 혼수패키지 탭 컨텐츠
$(document).ready(function() {
	$(".pricepackage .tab_content").hide();
	$(".pricepackage ul.tabs li:first").addClass("active").show();
	$(".pricepackage .tab_content:first").show();
	$(".pricepackage ul.tabs li").click(function() {
		$(".pricepackage ul.tabs li").removeClass("active");
		$(this).addClass("active");
		return false;
	});
});


//공간별 맞춤혼수 탭 컨텐츠
$(document).ready(function() {
	$(".priceListWrap .tab_content").hide();
	$(".priceListWrap ul.tabs li:first").addClass("active").show();
	$(".priceListWrap .tab_content:first").show();
	$(".priceListWrap ul.tabs li").click(function() {
		$(".priceListWrap ul.tabs li").removeClass("active");
		$(this).addClass("active");
	});
});

//마켓배너(혼수기획전) 플리킹
$('.item_list').slick({
	dots:true,
	slidesToShow: 1,
	slidesToScroll: 1,
	autoplay: true,
	autoplaySpeed: 3000
});

//하단상품 리스트 탭 컨텐츠
$(document).ready(function() {
	$(".btitem_list #quick1 .tab_content").hide();
	$(".btitem_list #quick1 ul.pp_tabs li:first").addClass("active").show();
	$(".btitem_list #quick1 .tab_content:first").show();
	$(".btitem_list #quick1 ul.pp_tabs li").click(function() {
		$(".btitem_list #quick1 ul.pp_tabs li").removeClass("active");
		$(this).addClass("active");
		return false;
	});

	$(".btitem_list #quick2 .tab_content").hide();
	$(".btitem_list #quick2 ul.pp_tabs li:first").addClass("active").show();
	$(".btitem_list #quick2 .tab_content:first").show();
	$(".btitem_list #quick2 ul.pp_tabs li").click(function() {
		$(".btitem_list #quick2 ul.pp_tabs li").removeClass("active");
		$(this).addClass("active");
		return false;
	});

	$(".btitem_list #quick3 .tab_content").hide();
	$(".btitem_list #quick3 ul.pp_tabs li:first").addClass("active").show();
	$(".btitem_list #quick3 .tab_content:first").show();
	$(".btitem_list #quick3 ul.pp_tabs li").click(function() {
		$(".btitem_list #quick3 ul.pp_tabs li").removeClass("active");
		$(this).addClass("active");
		return false;
	});

	$(".btitem_list #quick4 .tab_content").hide();
	$(".btitem_list #quick4 ul.pp_tabs li:first").addClass("active").show();
	$(".btitem_list #quick4 .tab_content:first").show();
	$(".btitem_list #quick4 ul.pp_tabs li").click(function() {
		$(".btitem_list #quick4 ul.pp_tabs li").removeClass("active");
		$(this).addClass("active");
		return false;
	});

	$(".btitem_list #quick5 .tab_content").hide();
	$(".btitem_list #quick5 ul.pp_tabs li:first").addClass("active").show();
	$(".btitem_list #quick5 .tab_content:first").show();
	$(".btitem_list #quick5 ul.pp_tabs li").click(function() {
		$(".btitem_list #quick5 ul.pp_tabs li").removeClass("active");
		$(this).addClass("active");
		return false;
	});

});


//팝업
function onoff(id) {
	var mid=document.getElementById(id);
	if(mid.style.display=='') {
		mid.style.display='none';
	}else{
		mid.style.display='';
	}
}
</script>

<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<script type="text/javascript" src="/mobilefirst/js/lib/vue.min.js"></script>
<script>
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로

//ga_log(1) - ga_log(14)
var ga_log;


$(document).ready(function(){
	//스크롤
	var nav = $('.myarea');
	$(window).scroll(function () {
		if ($(this).scrollTop() > 80) {
			nav.addClass("f-nav");
		} else {
			nav.removeClass("f-nav");
		}
	});

	ga_log = gaCall();
	viewItem(0);

	//로그인시 개인화영역
	if(islogin()){
		$("#user_id").text("<%=cUserId%>");
		getPoint();//개인e머니 내역 노출
	}

	function gaCall () {
		var gaLabel = [
              "PV",
              '무빙탭_혼수이벤트',
              '무빙탭_가격대별혼수 ',
              '무빙탭_공간별혼수',
              '날개배너_시공인테리어',
              '혼수패키지_탭_300만원',
              '혼수패키지_탭_500만원',
              '혼수패키지_탭_1000만원 ',
              '혼수패키지_상품 ',
              '혼수패키지_인기키워드 ',
              'e머니추가적립',
              '공간혼수_탭_거실',
              '공간혼수_탭_침실 ',
              '공간혼수_탭_주방',
              '공간혼수_탭_서재/드레스룸',
              '공간혼수_상품',
              '공간혼수_상품더보기',
              'CM기획전배너',
              '하단상품_탭_필수가전',
              '하단상품_필수가전',
              ' 하단상품_주방혼수_탭 ',
              '하단상품_주방혼수_상품',
              '하단상품_거실혼수_탭',
              '하단상품_거실혼수_상품 ',
              '하단상품_침실혼수_탭 ',
              '하단상품_침실혼수_상품',
              ' 하단상품_시공인테리어_탭 ',
              '하단상품_시공인테리어_상품',
              '퀵메뉴',
              '퀵메뉴_인테리어',
              '퀵메뉴_침실혼수',
              '퀵메뉴_거실혼수',
              '퀵메뉴_주방혼수',
              '퀵메뉴_필수혼수',
              '탭 이벤트 1',
              '탭 이벤트 2'
		];
		var vEvent_title = "혼수통합기획전";

		function innerCall (param) {
			if ( param == 1 ) {
				ga('send', 'pageview', {'page': vEvent_page,'title': vEvent_title + " > " + "PV"});
			} else {
				ga('send', 'event', 'mf_event', vEvent_title, vEvent_title + " > " + gaLabel[param-1]);
			}
		}

		return innerCall;
	}
});


window.onload = function(){
	var app = getCookie("appYN"); //app인지 여부

	$(".btn_login").click(function(){
		goLogin();       
    });
	
	//PV
	ga_log(1);
	if("<%=tab%>" == "2") {
		$(".promotiontab__item").removeClass("is-on");
		$(".promotiontab__item.promotiontab__item--2").addClass("is-on");
		$(".pm__tab").hide();
		$("#pm__tab2").show();
	}
	//event 1 응모
	$(".slecetbox__item").click(function () {

		getEventAjaxData({"procCode":1}, function(data){
			var result = data.result;
			if(result >= 0) {
				var selected = 0;
				if(result == 5) {
					selected = Math.floor(Math.random()*2) + 2;
				} else if(result == 4100) {
					selected = 1;
				}
				getPoint();

				$(".img_box").html("<img src=\"http://imgenuri.enuri.gscdn.com/images/event/2018/hopechest/m_vote_img0"+ selected +".png\" alt=\"\" />")
				$(".slecetbox__list").fadeOut(300); // 3개 버튼 숨김
				
				$(".selectroad__bg").animate({"opacity": 0}, 500); // 기존  BG를 감추고, 
				$(".resultroad__bg--" + selected).animate({"opacity": 1}, 1000, function(){									
					$("#prizes").stop().fadeIn(300); // 레이어 팝업 열림
				}); // 선택된 BG 노출됨.
			} else if(result == -1){
				alert("이미 참여하셨습니다.\n내일 또 참여해주세요.");
			} else if(result == -2){
				alert("임직원은 참여 불가합니다.");
			}
		});
	});
	//응모하기 버튼
	$("#event2_join").click(function(e){
        ga_log(12);
		if(app != 'Y'){
			onoff('app_only');
		}else if(eventCommonChk()){
			
			$.post("/mobilefirst/evt/ajax/hopechest2018_setlist.jsp" , {procCode : 3, sdt : <%=sdt%>}, function(data) {
				
				if (data.result == 1) {
					alert("이미 응모하셨습니다.\n앱에서 구매 시\n구매내역 자동 누적됩니다.");
					$("#event2_join").unbind("click");
				} else {
					onoff('eventJoin');
				}
			}, "json");
			
			
			
			
		}
		return false;
	});

	//앱에서 구매후 응모 파라미터
	var appBuyParams = function(){
		var uphone = $("#u_phone").val();
		var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;//전화번호 체크

		if(!uphone){
			alert("휴대폰 번호를 입력해주세요.");
			return false;
		}else if(!regExp.test(uphone)){
			alert("연락처를 정확히 입력해주세요");
			return false;
		}else if($("div.agree_chk > span").attr("class")=="unchk"){
			alert("경품 배송을 위해 개인정보 활용 동의해주세요");
			return false;
		}else{
			return {
				"procCode" : 2 ,
				uphone : uphone
			};
		}
	};

	//응모완료 버튼
	$("#event2_submit").click(function(e){

		getEventAjaxData(appBuyParams, function(data){
			var result = data.result;
			onoff('eventJoin');
			if(data.result == 1){
				alert('이벤트에 응모해주셔서\n감사합니다.');
			}else if(data.result == -1){
				alert("이미 응모하셨습니다.\n앱에서 구매 시\n구매내역 자동 누적됩니다.");
			}
		});
		$("#event2_join").unbind('click');
		return false;
	});

	//이벤트 이동 영역
	$("#evt_banner > li").click(function(e){
        ga_log(13);

		var vUrl = [
	        "/mobilefirst/evt/welcome_event.jsp?tab=1&freetoken=eventclone",
	        "/mobilefirst/evt/visit_event.jsp?tab=1&freetoken=eventclone",
	        "/mobilefirst/evt/visit_event.jsp?tab=2&freetoken=eventclone",
	        "/mobilefirst/evt/mobile_deal.jsp?freetoken=eventclone"
        ];
		window.open(vUrl[ $(this).index() ]);
	});

	//닫기버튼
	$( ".win_close" ).click(function(){
		if(app == 'Y'){
			window.location.href = "close://";
		}else{
			window.location.replace("/mobilefirst/Index.jsp");
		}
	});

	var isClick = true;
	function getEventAjaxData(paramsChk, callback){
		//이벤트 공통 체크
		if(!eventCommonChk()){
			return false;
		}
		/*
			유효성 체크가 필요한 경우
			함수를 인자로 넘기고, 필요없는 경우 그 이벤트에 해당하는 파라미터 object를 넘긴다.
		*/
		var addParams;

		if(typeof paramsChk === "function"){
			addParams = paramsChk();
		}
		else if(typeof paramsChk === "object") {
			addParams = paramsChk;
		}

		if(addParams){
		    if(!isClick){
		    	return false;
		    }
		    isClick = false;
			$.post("/mobilefirst/evt/ajax/hopechest2018_setlist.jsp" , $.extend({sdt : "<%=sdt%>" , osType : getOsType()}, addParams),
					callback, "json")
			.done(function(){
					isClick = true;
				});;
		}
	}

	function eventCommonChk(){
		var sdt="<%=sdt%>";
		var endDate = "20180430";

		if(sdt > endDate){
			alert('이벤트가 종료되었습니다.');
			return false;
		}else if(!islogin()){
			alert("로그인 후 이용 가능합니다.");
			goLogin();
			return false;
		}else{
			return true;
		}
	}
};


var ajaxUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=12";
if (location.host.indexOf("my.enuri.com") > -1) {
	ajaxUrl = "/event2018/test.json";
}

//전체 상품 데이터
var	ajaxData = (function() {
    var json = new Array();
    $.ajax({
        'async': false,
        'global': false,
        'url': ajaxUrl,
        'dataType': "json",
        'success': function (data) {
        	json = data;
        }
    });
    return json;
})();

//맞춤혼수 추천 패키지
var packData  = [];
var itemCateList =  ["TV", "냉장고", "전기밥솥", "세탁기", "청소기", "침대"];
for(var i=0; i<6; i++) {
	var tmp = ajaxData.T[i].GOODS;
	
	tmp.forEach(function(value, index){
		value.itemCateNm = itemCateList[index];
	});
	packData.push(tmp);
}

//공간별 맞춤혼수
var spaceData = [];
for (var i=6;i<10;i++) {
	spaceData.push(ajaxData.T[i].GOODS);
}

//공간별 실속혼수 (필수가전, 주방혼수, 거실혼수, 침실혼수, 시공 인테리어)
var bottomData = [[],[],[],[],[]];
for (var i=0; i<5; i++) {
	for(var j=0; j<4; j++) {
		var tmp = shuffle(ajaxData.T[10 + i*4 + j].GOODS);
		bottomData[i].push(tmp);
	}
}

/*
 * 
 맞춤혼수 추천패키지
	상품, 타이틀, 견적서 가격총합, 인기키워드
 */
var rcmdPak = new Vue ({
	el : "#rcmPak",
	data : {
		selectedIdx : -1,
		itemsTitle: [ ["최저 예산으로 최고 가성비를!","알뜰혼수 패키지 1"],    ["최저 예산으로 최고 가성비를!","알뜰혼수 패키지 2"],  
		              ["예산에 맞춰 준비하는 똑부러지는","실속혼수 패키지 1"], ["예산에 맞춰 준비하는 똑부러지는","실속혼수 패키지 2"], 
		              ["새로운 시작! 혼수만큼은 특별하게!","프리미엄 혼수 1"], ["새로운 시작! 혼수만큼은 특별하게!","프리미엄 혼수 2"] ],
		estimateTitle : [
		                 "알뜰혼수 패키지 견적서 1", "알뜰혼수 패키지 견적서 2",  
		                 "실속혼수 패키지 견적서 1", "실속혼수 패키지 견적서 2",
		                 "프리미엄 혼수 견적서 1", "프리미엄 혼수 견적서 2",
		                 ]
	},
	created : function() {
		this.selectedIdx = 0;
	},
	mounted: function() {
		//가격대별 혼수패키지 
		$("#packTab li").click(function(e) {
			var idx = $(this).index();
			ga_log(10 + idx);
			rcmdPak.selectedIdx = idx * 2;
		});
		//가격대별 혼수패키지 플리킹
		$('.pricepackage .items_area').slick({
			dots:true,
			slidesToScroll: 1,
		});

	},
	beforeUpdate : function () {
		$('.pricepackage .items_area').slick('unslick');
	},
	updated : function() {
        this.$nextTick(function(){
        	//가격대별 혼수패키지 플리킹
    		$('.pricepackage .items_area').slick({
    			dots:true,
    			slidesToScroll: 1,
    		});
        });
	},
	methods : {
		changeTab : function(event) {
			var idx = Number(event.target.parentNode.dataset.idx);
			ga_log(6+ idx);
			this.selectedIdx = idx * 2;
		}
	},
	computed: {
		//선택된 패키지
		items : function() {
			return [packData[this.selectedIdx], packData[this.selectedIdx+1]];
		},
		//선택된 패키지의 타이틀
		selectedItemsTitle : function() {
			return [ this.itemsTitle[this.selectedIdx], this.itemsTitle[this.selectedIdx + 1]];
		},
		//선택된 견적서 타이틀
		selectedestimateTitle : function() {
			return [ this.estimateTitle[this.selectedIdx], this.estimateTitle[this.selectedIdx + 1]];
		},
		//선택된 탭의 인기키워드
		tagList : function () {
			return ajaxData.T[this.selectedIdx].TAGS;
		},
		//선택된 패키지의 상품가격 합
		itemsTotalPrice : function () {
			var tPrice1 = 0, tPrice2 = 0;
			
			this.items[0].forEach(function(element,index) {
				tPrice1 += Number(element.MINPRICE3);
			});
			this.items[1].forEach(function(element,index) {
				tPrice2 += Number(element.MINPRICE3);
			});
			
			return [tPrice1,tPrice2];
		}
	}
});

function viewItem(index){
	var _html = "<div class=\"lp_tabs_cont\">";
	_html += "<div class=\"items_area\">";

	var itemArr = spaceData[index];
	itemArr.forEach(function(value, index){
		if(index % 4 ==0){
			_html += "<div class=\"itembox\">";
			_html += "<ul class=\"itemlist\">";
		}
		var imgsrc = value.GOODS_IMG;
		if(imgsrc == "" || imgsrc == null || typeof imgsrc == "undefined"){
			imgsrc = value.IMG_SRC;
		}
		var minprice = 	0;
		if(value.MINPRICE3){
			minprice = value.MINPRICE3;
		}

		var title1 = 	value.TITLE1;
		var title2 = 	value.TITLE2;
		var clickout = "ga_log(16);";

		if ( minprice == 0 ){
			clickout += "alert('품절 된 상품입니다.');return false;";
		}else{
			clickout += "itemClick('" + value.MODELNO + "',"+ minprice +");";
		}

		if(index % 4 < 2) {
			_html += "<li class=\"top\">";
		} else {
			_html += "<li>";
		}
		_html += "<a href=\"javascript:///\" onclick=\""+clickout+"\" title=\"\" class=\"btn\">";
		_html += "<div class=\"imgs\">";
		if(index==0){
			_html += "<img src=\""+ imgsrc +"\"  alt=\"\" class=\"imgs\" />";
		}else{
			_html += "<img data-lazy=\""+ imgsrc +"\" src = \"<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png\" alt=\"\" class=\"imgs\" />";
		}
		if ( minprice == 0 ){
			_html += "<span class=\"soldout\">SOLD OUT</span>";
		}
		_html += "</div>";
		_html += "<div class=\"info\">";
		_html += "<p class=\"pname\">"+title1+ "<br /> "+ title2+ "</p>";
		_html += " <p class=\"price\"><span class=\"lowst\">최저가</span><b>"+ commaNum(minprice) +"</b>원</p>";
		_html += "</div>";
		_html += "</a>";
		_html += "</li>";

		if(index % 4 == 3 ){
			_html += "</ul>";
			_html += "</div>";
		}
	});
	_html += "</div>";
	_html += "</div>";
	$("#spaceArea").html(_html);

	//공간별 맞춤혼수 플리킹
	$('.priceListWrap .items_area').slick({
		dots:true,
		slidesToScroll: 1,
	});
	moveAnchorTab = index;
}

function moreItem() {
	var cateNo = "";
	switch (moveAnchorTab) {
		case 0:
			cateNo = "0201";
			break;
		case 1:
			cateNo = "1202";
			break;
		case 2:
			cateNo = "1203";
			break;
		case 3:
			cateNo = "1242";
			break;
	}
	if(cateNo != "") {
		moveLP(cateNo);
	}
}

function moveLP(cateNo) {
	window.open("/mobilefirst/list.jsp?freetoken=llist&cate=" + cateNo);
}

/*
 * 
 bttm1 - bttm 5 : 공간별 실속혼수 (필수가전, 주방혼수, 거실혼수, 침실혼수, 시공 인테리어)
 */
var bttm1 = new Vue({
	el : "#quick1",
	data : {
		elId : "quick1",
		selectedIdx : -1,
		allItems : bottomData[0],
		moreCate : [ "0201", "0602", "0502", "050206" ]
	},
	created : function() {
		this.selectedIdx = 0;
	},
	mounted : function() {
		//하단상품 리스트 플리킹
		$('#' +this.elId +'Area').slick({
			dots:true,
			slidesToScroll: 1,
		});
	},
	beforeUpdate : function() {
		//하단상품 리스트 플리킹
		$('#' +this.elId +'Area').slick("unslick");
	},
	updated : function() {
		//하단상품 리스트 플리킹
		$('#' +this.elId +'Area').slick({
			dots:true,
			slidesToScroll: 1,
		});
	},
	methods : {
		changeTab : function(event) {
			var idx = event.target.parentNode.dataset.idx;
			var tabArea = $("#"+ this.elId +" .tab_item > li");
			tabArea.removeClass("on");
			tabArea.eq(idx).addClass("on");
			
			ga_log(19);
			this.selectedIdx = idx;
		}
	},
	computed: {
		//선택된 탭의 상품
		selectedItems : function() {
			return this.allItems[this.selectedIdx];
		},
		//선택된 탭의 더보기 lp 의 cateNo
		selectedCateNo : function() {
			return this.moreCate[this.selectedIdx];
		},
		//slick 영역 사이즈 
		slickSize : function() {
			return Math.ceil(this.allItems[this.selectedIdx].length/4);
		}
	}
});

//주방혼수
var bttm2 = new Vue({
	el : "#quick2",
	data : {
		elId : "quick2",
		selectedIdx : -1,
		allItems : bottomData[1],
		moreCate : [ "0601", "0608", "1203", "1626" ]
	},
	created : function() {
		this.selectedIdx = 0;
	},
	mounted : function() {
		//하단상품 리스트 플리킹
		$('#' +this.elId +'Area').slick({
			dots:true,
			slidesToScroll: 1,
		});
	},
	beforeUpdate : function() {
		//하단상품 리스트 플리킹
		$('#' +this.elId +'Area').slick("unslick");
	},
	updated : function() {
		//하단상품 리스트 플리킹
		$('#' +this.elId +'Area').slick({
			dots:true,
			slidesToScroll: 1,
		});
	},
	methods : {
		changeTab : function(event) {
			var idx = event.target.parentNode.dataset.idx;
			var tabArea = $("#"+ this.elId +" .tab_item > li");
			tabArea.removeClass("on");
			tabArea.eq(idx).addClass("on");
			
			ga_log(21);
			this.selectedIdx = idx;
		}
	},
	computed: {
		//선택된 탭의 상품
		selectedItems : function() {
			return this.allItems[this.selectedIdx];
		},
		//선택된 탭의 더보기 lp 의 cateNo
		selectedCateNo : function() {
			return this.moreCate[this.selectedIdx];
		},
		//slick 영역 사이즈 
		slickSize : function() {
			return Math.ceil(this.allItems[this.selectedIdx].length/4);
		}
	}
});
//거실혼수
var bttm3 = new Vue({
	el : "#quick3",
	data : {
		elId : "quick3",
		selectedIdx : -1,
		allItems : bottomData[2],
		moreCate : [ "120104", "120116", "0208", "2406" ]
	},
	created : function() {
		this.selectedIdx = 0;
	},
	mounted : function() {
		//하단상품 리스트 플리킹
		$('#' +this.elId +'Area').slick({
			dots:true,
			slidesToScroll: 1,
		});
	},
	beforeUpdate : function() {
		//하단상품 리스트 플리킹
		$('#' +this.elId +'Area').slick("unslick");
	},
	updated : function() {
		//하단상품 리스트 플리킹
		$('#' +this.elId +'Area').slick({
			dots:true,
			slidesToScroll: 1,
		});
	},
	methods : {
		changeTab : function(event) {
			var idx = event.target.parentNode.dataset.idx;
			var tabArea = $("#"+ this.elId +" .tab_item > li");
			tabArea.removeClass("on");
			tabArea.eq(idx).addClass("on");
			
			ga_log(23);
			this.selectedIdx = idx;
		}
	},
	computed: {
		//선택된 탭의 상품
		selectedItems : function() {
			return this.allItems[this.selectedIdx];
		},
		//선택된 탭의 더보기 lp 의 cateNo
		selectedCateNo : function() {
			return this.moreCate[this.selectedIdx];
		},
		//slick 영역 사이즈 
		slickSize : function() {
			return Math.ceil(this.allItems[this.selectedIdx].length/4);
		}
	}
});
//침실혼수
var bttm4 = new Vue({
	el : "#quick4",
	data : {
		elId : "quick4",
		selectedIdx : -1,
		allItems : bottomData[3],
		moreCate : [ "1202", "1242", "124209", "124501" ]
	},
	created : function() {
		this.selectedIdx = 0;
	},
	mounted : function() {
		//하단상품 리스트 플리킹
		$('#' +this.elId +'Area').slick({
			dots:true,
			slidesToScroll: 1,
		});
	},
	beforeUpdate : function() {
		//하단상품 리스트 플리킹
		$('#' +this.elId +'Area').slick("unslick");
	},
	updated : function() {
		//하단상품 리스트 플리킹
		$('#' +this.elId +'Area').slick({
			dots:true,
			slidesToScroll: 1,
		});
	},
	methods : {
		changeTab : function(event) {
			var idx = event.target.parentNode.dataset.idx;
			var tabArea = $("#"+ this.elId +" .tab_item > li");
			tabArea.removeClass("on");
			tabArea.eq(idx).addClass("on");
			
			ga_log(25);
			this.selectedIdx = idx;
		}
	},
	computed: {
		//선택된 탭의 상품
		selectedItems : function() {
			return this.allItems[this.selectedIdx];
		},
		//선택된 탭의 더보기 lp 의 cateNo
		selectedCateNo : function() {
			return this.moreCate[this.selectedIdx];
		},
		//slick 영역 사이즈 
		slickSize : function() {
			return Math.ceil(this.allItems[this.selectedIdx].length/4);
		}
	}
});
//시공 인테리어
var bttm5 = new Vue({
	el : "#quick5",
	data : {
		elId : "quick5",
		selectedIdx : -1,
		allItems : bottomData[4],
		moreCate : [ "124205", "120302", "16051909", "120131" ]
	},
	created : function() {
		this.selectedIdx = 0;
	},
	mounted : function() {
		//하단상품 리스트 플리킹
		$('#' +this.elId +'Area').slick({
			dots:true,
			slidesToScroll: 1,
		});
	},
	beforeUpdate : function() {
		//하단상품 리스트 플리킹
		$('#' +this.elId +'Area').slick("unslick");
	},
	updated : function() {
		//하단상품 리스트 플리킹
		$('#' +this.elId +'Area').slick({
			dots:true,
			slidesToScroll: 1,
		});
	},
	methods : {
		changeTab : function(event) {
			var idx = event.target.parentNode.dataset.idx;
			var tabArea = $("#"+ this.elId +" .tab_item > li");
			tabArea.removeClass("on");
			tabArea.eq(idx).addClass("on");
			
			ga_log(27);
			this.selectedIdx = idx;
		}
	},
	computed: {
		//선택된 탭의 상품
		selectedItems : function() {
			return this.allItems[this.selectedIdx];
		},
		//선택된 탭의 더보기 lp 의 cateNo
		selectedCateNo : function() {
			return this.moreCate[this.selectedIdx];
		},
		//slick 영역 사이즈 
		slickSize : function() {
			return Math.ceil(this.allItems[this.selectedIdx].length/4);
		}
	}
});

function itemClick(modelNo, minprice){
    if(minprice > 0){
        window.open('/mobilefirst/detail.jsp?modelno=' + modelNo +'&freetoken=vip');
    }else{
        alert("품절된 상품 입니다.");
    }
}

function shuffle(o){ //v1.0
    for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
    return o;
}

/*checkbox*/
function agreechk(obj){
	if (obj.className== 'unchk') {
		obj.className = 'chk';
	} else {
		obj.className = 'unchk';
	}
}

//레이어
function onoff(id) {
	var mid=document.getElementById(id);
	if(mid.style.display=='') {
		mid.style.display='none';
	}else{
		if(id=="app_only"){
			ga('send', 'event', 'mf_event', '프로모션공통영역', '무빙탭_개인화영역');
		}
		mid.style.display='';
	}
}
//로그인페이지 이동
function goLogin(){
	var app = getCookie("appYN"); //app인지 여부

	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        if(app =='Y'){
        	location.href = "/mobilefirst/login/login.jsp";          	
       }
        else{
        	location.href = "/mobilefirst/login/login.jsp?backUrl="+vEvent_page;          	
        }
    }else if(navigator.userAgent.indexOf("Android") > -1){
        location.href = "/mobilefirst/login/login.jsp?backUrl="+vEvent_page+"?freetoken=event&chk_id="+vChkId;
    }       
}
function myArea(){
    if(getCookie("appYN") == 'Y'){
        location.href = "/mobilefirst/emoney/emoney.jsp?freetoken=emoney";
    }else{
        onoff('app_only');
    }

}
function islogin() {
	var cName = "LSTATUS";
	var s = document.cookie.indexOf(cName +'=');
	if (s != -1){
		s += cName.length + 1;
		e = document.cookie.indexOf(';',s);
		if (e == -1){
			e = document.cookie.length;
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

function getPoint(){
	$.ajax({
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_point.jsp",
		async: false,
		dataType:"JSON",
		success: function(json){
			remain = json.POINT_REMAIN;	//적립금

			$(".name").empty();
			$(".name").html(username+" 님<span onclick='myArea()'>"+commaNum(json.POINT_REMAIN)+"점</span></p>");

		}
	});
}
//콤마찍기
function commaNum(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function getOsType(){
	var app = getCookie("appYN"); //app인지 여부
    var osType = "";
    if(app =='Y'){
         if(navigator.userAgent.indexOf("Android") > -1)
        	 osType = "MAA";
         else
        	 osType = "MAI";
    }else {
         if(navigator.userAgent.indexOf("Android") > -1)
        	 osType = "MWA";
         else
        	 osType = "MWI";
    }
    return osType;
}
function getCookie(c_name) {
	var i,x,y,ARRcookies=document.cookie.split(";");
	for(i=0;i<ARRcookies.length;i++) {
		x = ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
		y = ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
		x = x.replace(/^\s+|\s+$/g,"");
		if(x==c_name) {
			return unescape(y);
		}
	}
}
//앱설치버튼
function install_btt(){

	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8';
    }else if(navigator.userAgent.indexOf("Android") > -1){
    	window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
    }
}
</script>
</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
