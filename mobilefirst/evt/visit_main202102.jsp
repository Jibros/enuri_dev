<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%><%
String chkId = ChkNull.chkStr(request.getParameter("chk_id"));
String userArea = request.getParameter("userArea");
String cUserId = request.getParameter("cUserId");
String sdt = request.getParameter("sdt");
String strUrl = request.getRequestURI();
String eventCode = request.getParameter("eventCode");
String startDate = request.getParameter("startDate");
String endDate = request.getParameter("endDate");
String[] luckeyDay = (String[])request.getAttribute("luckeyDay");
String tab = request.getParameter("tab");
String oc = ChkNull.chkStr(request.getParameter("oc"));
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

String bannerOn = "";

Cookie[] carr = request.getCookies();
String strAppyn = "";
if(carr != null){
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("appYN")){
	      strAppyn = carr[i].getValue();
	      break;
	    }
	}
}

if( ( request.getServerName().indexOf("dev.enuri.com") > -1 || request.getServerName().indexOf("m.enuri.com") > -1   )
		&& request.getParameter("sdt")!=null && !request.getParameter("sdt").equals("") ) {
	sdt = request.getParameter("sdt");
}
int numSdt = Integer.parseInt(sdt);

if( numSdt >= 20200224 && numSdt < 20200309  ){
	bannerOn = "winter";
}
%>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js?v=202020"></script>
<script>
var shareUrl = "http://" + location.host + "/mobilefirst/evt/visit_event.jsp?oc=mo";
Kakao.init('5cad223fb57213402d8f90de1aa27301');
</script>
<body>
<div class="lay_only_mw" style="display: none;">
	<div class="lay_inner">
		<div class="lay_head">
			앱에서는 득템의 기회 <em>타임특가</em>에 참여할 수 있어요!
		</div>
		<!-- 버튼 : 에누리앱으로 보기 -->
		<button class="btn_go_app" onclick="view_moapp();return false;">에누리앱으로 보기</button>
		<!-- 버튼 : 모바일웹으로 보기 -->
		<a href="javascript:void(0);" class="btn_keep_mw" onclick="$('.lay_only_mw').fadeOut(100);">괜찮아요. 모바일 웹으로 볼래요</a>
	</div>
</div>
<div class="com__share_wrap dim" style="z-index: 10000;display:none">
	<div class="com__layer share_layer">
		<div class="lay_head">공유하기</div>
		<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
		<div class="lay_inner">
			<ul id="eventShr">
				<li class="share_fb" id="fbShare" >페이스북 공유하기</li>
				<li class="share_kakao" id="kakao-link-btn">카카오톡 공유하기</li>
				<li class="share_tw" id="twShare" >트위터 공유하기</li>
			</ul>
			<!-- 메인보내기 버튼클릭시 .mail_on 추가해 주세요 -->
			<div class="btn_wrap">
				<div class="btn_group">
					<!-- 주소복사하기 -->
					<div class="btn_item">
						<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/evt/visit_event.jsp</span>
						<button class="btn__share_copy" data-clipboard-target="#txtURL">복사</button>
					</div>
					<!-- 이메일주소 입력하기 -->
					<div class="btn_item">
						<input type="text" class="txt__share_mail" placeholder="이메일 주소 입력해 주세요">
						<button class="btn__share_mail">보내기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="/js/clipboard.min.js"></script>
	<script>
		$(function(){
			var clipboard = new ClipboardJS('.com__share_wrap .btn__share_copy');
			clipboard.on('success', function(e) {
				alert('주소가 복사되었습니다');
			});
			clipboard.on('error', function(e) {
				console.log(e);
			});
		});
	</script>
</div>

<!-- layer-->
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="onoff('app_only')">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();">설치하기</button></p>
	</div>
</div>


<!-- 매일룰렛 유의사항 -->
<div class="dim" style="display:none;" id="notetxt3">
	<div class="noteLayer" >
		<h4>유의사항</h4>
        <a href="javascript:///" class="close" onclick="onoff('notetxt3')">창닫기</a>
        <ul class="txtlist">
            <li>매일룰렛 참여 : ID당 1일 2회 참여 가능</li>
			<li class="no_dot">- 1차 타임  12:00:00 AM ~ 02:59:59 PM</li>
			<li class="no_dot">- 2차 타임  03:00:00 PM ~ 23:59:59 PM</li>
			<li>매일룰렛 참여 혜택 : [이디야] 우리 함께해 세트 (스노우쿠키슈+아메리카노) (e 5,000), [해피머니] 온라인상품권 (e 3,000), e머니 10점</li>
			<li>e쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립해드립니다. <br>(제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격 변동 있을 수 있습니다.)</li>
			<li>e머니 유효기간: 적립일로부터 15일</li>
			<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다.</li>
			<li>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</li>
        </ul>
	</div>
</div>
<!-- 181008뽀나스 혜택 레이어 -->
<div id="bonusLayer" class="dim" style="display:none">
	<!-- 당첨 박스 -->
	<div class="voteWrap">
		<div class="inner">

			<!-- 당첨 O -->
			<div class="case1" id="voteLayer_200" style="display:none">
				<div class="user_msg"><em><%=cUserId %>님</em></div>
				<div class="vote_img">
					<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2019/attendance/feb/vote_prize.jpg" alt="뽀나스 혜택 당첨" />
				</div>
				<!-- 배너영역 -->
				<a href="javascript:void(0);" class="layer_ad_banner" onclick="javascript:goWelcomeFirstbuy();">
					<img src="http://img.enuri.info/images/event/2020/attendance/sep/layer_ad_banner_t1.jpg" alt="에누리 첫 구매 고객이라면 누구나 최대 e머니 17,000점 배너 누르고 WELCOME 혜택 받기>">
				</a>
			</div>
			<!-- //당첨 O -->

			<!-- 당첨 X -->
			<div class="case2" id="voteLayer_0" style="display:none">
                <p class="user_msg"><em><%=cUserId %>님 반가워요!</em>
                <div class="vote_img"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2018/attendance/oct/vote2_img.jpg" alt="아쉽게도 당첨되지 않으셨지만 내일 또 오실거죠?" /></div>
				<!-- 배너영역 -->
				<a href="javascript:void(0);" class="layer_ad_banner" onclick="javascript:goWelcomeFirstbuy();">
					<img src="http://img.enuri.info/images/event/2020/attendance/sep/layer_ad_banner_t2.jpg" alt="에누리 첫 구매 고객이라면 누구나 최대 e머니 17,000점 배너 누르고 WELCOME 혜택 받기>">
				</a>
			</div>
            <!-- //당첨 X -->
			<!-- 보너스 혜택 참여후 -->
			<div class="case3" id="voteLayer_1" style="display:none">
                <div class="vote_img">
                	<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2019/attendance/feb/vote1_img.jpg" alt="반가워요 이미지참여하셨습니다.">
                </div>
                <!-- 배너영역 -->
                <a href="javascript:void(0);" class="layer_ad_banner" onclick="javascript:goWelcomeFirstbuy();">
                    <img src="http://img.enuri.info/images/event/2020/attendance/sep/layer_ad_banner_t2.jpg" alt="에누리 첫 구매 고객이라면 누구나 최대 e머니 17,000점 배너 누르고 WELCOME 혜택 받기>">
                </a>
            </div>
            <!-- //보너스 혜택 참여후 -->
		</div>
		<a href="javascript:///" class="btn layclose" onclick="onoff('bonusLayer');return false"><em>팝업 닫기</em></a>
	</div>
</div>
<!-- //181008뽀나스 혜택 레이어 -->
<!-- 매일룰렛당첨 레이어 -->
<div class="pop-layer" style="display:none;" id="roulleteLayer">
	<div class="backdim"></div>
	<!-- 당첨 박스 -->
	<div class="prizeLayer">
		<div class="lay__inner">
			<p class="tit ep1"><!--3시이전-->
				<span class="line1">당첨을 축하합니다! </span>
				<span class="line2"><strong>2차 간식 타임</strong>에 또 만나요~</span>
			</p>
			<p class="tit ep2"><!--3시이후-->
				<span class="line1">당첨을 축하합니다! </span>
				<span class="line2"><strong>내일 간식타임</strong>에 또 만나요~</span>
			</p>

			<!-- 꽝일때 노출 -->
			<p class="tit bomb_ep1"><!--3시이전-->
				<span class="line1">아쉽게도 당첨되지 않으셨습니다.</span>
				<span class="line2"><strong>2차 간식 타임</strong>에 다시 만나요~</span>
			</p>
			<p class="tit bomb_ep2"><!--3시이후-->
				<span class="line1">아쉽게도 당첨되지 않으셨습니다.</span>
				<span class="line2"><strong>내일 간식 타임</strong>에 다시 만나요~</span>
			</p>

			<div class="prize pr1" style="display:none;">[배스킨라빈스] 더블주니어 아이스크림 (e4,300)</div>
			<div class="prize pr2" style="display:none;">[크리스피크림도넛] 오리지널 하프더즌 (e7,800)</div>
			<div class="prize pr3" style="display:none;">[세븐일레븐] 롯데 칸쵸</div>
			<div class="prize pr4" style="display:none;">e머니 100</div>
			<div class="prize pr5" style="display:none;">e머니 10</div>
			<div class="prize pr6" style="display:none;">꽝</div>

			<button type="button" class="btn_confirm" onclick="onoff('roulleteLayer');return false">확인</button>
		</div>
		<a href="javascript:///" class="close" onclick="onoff('roulleteLayer');return false"><em>팝업 닫기</em></a>
	</div>
	<!-- //당첨 박스 -->
</div>
<!-- //매일룰렛당첨 레이어 -->

<!-- 이벤트 WRAPPER -->
<div class="event_wrap">
	<!-- 오늘의 한마디 레이어 -->
	<div id="TodaysayLayer" class="pop-layer" style="display:none">
		<div class="popupLayer">
			<div class="dim"></div>
		</div>
		<!-- 당첨 박스 -->
		<div class="vote_box todaysay">
			<div class="inner">
				<!-- 당첨 O -->
				<div class="cont">
					<p class="user_msg" id= "todayUserMsg">매일 드리는 <em>e머니 적립 완료!</em></p>

				</div>

				<a href="javascript:///" class="btn adbanner" onclick="goWelcomeFirstbuy();">
					<img src="http://img.enuri.info/images/event/2021/attance/m_bnr_modal.png" alt="에누리 첫 구매 고객이라면 누구나 최대 e머니 17,000점 배너 누르고 WELCOME 혜택 받기&gt;" />
				</a>
			</div>

			<a href="javascript:///" class="btn layclose" onclick="onoff('TodaysayLayer'); location.reload(); return false"><em>팝업 닫기</em></a>
		</div>
		<!-- //popup_box -->
	</div>
	<!-- //오늘의 한마디 레이어 -->
	<!-- 이벤트 상단 -->
	<div class="evt_head">
	<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp"%>

		<!-- tab_area -->
		<%-- <div class="tab_area attand"><!-- 출석일 때 class="attand" 추가 -->
			<div class="inner">
				<ul class="tabmenu">
					<%if(numSdt >=20201005){ %>
						<li class="tab1"><a class="movetab btn" href="/mobilefirst/evt/welcome_event.jsp"><strong>WELCOME</strong></a></li>
					<%}else{ %>
						<li class="tab1"><a class="movetab btn" href="/mobilefirst/evt/firstbuy100_event.jsp"><strong>WELCOME</strong></a></li>
					<%} %>
					<li class="tab2"><a class="btn" onclick="smartBuyGo();"><strong>구매혜택</strong></a></li>
					<li class="tab3"><a class="btn" href="http://m.enuri.com/m/index.jsp#evt"><strong>매일혜택</strong></a></li>
				</ul>
			</div>
		</div> --%>
	</div>
		<!-- //tab_area -->
	<!-- //이벤트 상단 -->
	<!-- 상단비주얼 -->
	<div class="section visual">
		<div class="inner">
			<!-- 버튼 : 공유하기 -->
			<button class="com__btn_share" onclick="$('.com__share_wrap').show();CmdShare()">공유하기</button>
			<!-- // -->
			<span class="txt_01">출석&amp;룰렛</span>
			<h1>매일에-누리다</h1>
			<span class="txt_02">더 풍성하고 다양해진, 매일 받는 혜택</span>
			<span class="coin_wrap"></span>
		</div>
		<div class="obj_coin_01"> <!-- 앞쪽 코인 -->
			<div class="bg_coin coin_obj_01"></div>
			<div class="bg_coin coin_obj_02"></div>
		</div>
		<div class="obj_coin_02"> <!-- 뒤쪽 코인 -->
			<div class="bg_coin coin_obj_01"></div>
			<div class="bg_coin coin_obj_02"></div>
		</div>
		<div class="loader-box">
			<div class="visual-loader"></div>
		</div>
		<script>
			// 상단 타이들 등장 모션
			$(window).load(function(){
				var $visual = $(".event_wrap .visual");
				$visual.addClass("intro");
				setTimeout(function(){
					$visual.addClass("end");
				},2000)
			})
		</script>
	</div>
	<!-- //상단비주얼 -->

	<!-- floattab-->
	<div class="section floattab">
		<div class="floattab__list">
			<ul>
				<li><a href="#evt1" class="movetab floattab__item floattab__item--01 ">100% 당첨 출석체크</a></li>
				<li><a href="#evt2" class="movetab floattab__item floattab__item--02">하루 2번! 룰렛타임!</a></li>
				<li><a href="#evt3" class="movetab floattab__item floattab__item--03">오늘의 한마디</a></li>
			</ul>
		</div>
	</div>
	<!-- //floattab-->

	<!-- 도전! 프로출첵러 -->
	<div id="evt1" class="section evtnotice">
		<div class="contents">
			<h2 class="evtnotice__tit">매일 적립 받고 다양한 경품까지! 도전! 프로출첵러</h2>

			<ul class="evtnotice__list">
				<li class="evtnotice__item item1">
					<div class="blind">
						<h3>개근상</h3>
						<p>한 달간 매일 출석한 회원 - 20명 추첨</p>
						<p>[스타벅스] 부드러운 디저트 세트 - e머니 12700점 적립</p>
					</div>
					<button type="button" class="btn btn--join" onclick="alert('한 달 간 매일 출석 시 자동으로 응모됩니다.')">자동응모</button>
					<button type="button" class="btn btn--complete" onclick="alert('자동 응모 되었습니다.\n다음 달에 또 참여 해 주세요.')" style="display: none;">응모완료</button>
				</li>
				<li class="evtnotice__item item2">
					<div class="blind">
						<h3>우수상</h3>
						<p>한 달간 20일 출석한 회원 - 30명 추첨</p>
						<p>[맥도날드] 더블 불고기버거 세트 - e머니 5200점 적립</p>
					</div>
					<button type="button" class="btn btn--join" onclick="alert('한 달 간 20일 이상 출석 시 자동으로 응모됩니다.')">자동응모</button>
					<button type="button" class="btn btn--complete" onclick="alert('자동 응모 되었습니다.\n다음 달에 또 참여 해 주세요.')"  style="display: none;">응모완료</button>
				</li>
				<li class="evtnotice__item item3">
					<div class="blind">
						<h3>참가상</h3>
						<p>한 달간 10일 출석한 회원 - 보너스 뽑기</p>
						<p>당첨 시 즉시 지급 - e머니 500점 적립</p>
					</div>
					<button type="button" class="btn btn--disabled" onclick="alert('한 달 간 10회 이상 출석 시 참여 가능합니다.')">뽑기 비활성화</button>
					<button type="button" class="btn btn--active" onclick="bonusPick();" style="display:none;">뽑기 활성화</button>
					<button type="button" class="btn btn--attend-complete" onclick="alert('이미 참여하셨습니다. 다음에 또 만나요!')" style="display:none;">참여완료</button>
				</li>
				<li class="evtnotice__item item4">
					<div class="blind">
						<h3>매일 출석체크</h3>
						<p>하루 한 번, 매일 받는 적립</p>
						<p>100% 당첨 - e머니 5/10/100/500점 적립</p>
					</div>
					<button type="button" class="btn btn--goattend" onclick="$('html, body').stop().animate({scrollTop: $('#evt4').offset().top - 40}, 500);">출석체크 GO</button>
				</li>
			</ul>
		</div>

		<!-- 버튼 : 꼭 확인하세요 -->
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop1"><span>꼭! 확인하세요</span></button></div><!--  열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop1" class="evt_notice--slide">
			<div class="evt_notice--inner">
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<dl>
							<dt>[개근상] 이벤트 대상 및 혜택</dt>
							<dd>
								<ul>
									<li>이벤트 대상 : 한 달 간 매일 출석한 회원 (자동 응모)</li>
									<li>이벤트 기간 : 2021년 2월 1일 ~ 2월 28일</li>
									<li>이벤트 혜택 : [스타벅스] 부드러운 디저트 세트 (e12,700) - 20명 추첨</li>
									<li>당첨자 발표 : 2021년 3월 16일 화요일</li>
									<li class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>[우수상] 이벤트 대상 및 혜택</dt>
							<dd>
								<ul>
									<li>이벤트 대상 : 한 달 간 20회 이상 출석한 회원 (자동 응모)</li>
									<li>이벤트 기간 : 2021년 2월 1일 ~ 2월 28일</li>
									<li>이벤트 혜택 : 맥도날드 더블 불고기버거 세트 (e5,200) - 10명 추첨</li>
									<li>당첨자 발표 : 2021년 3월 16일 화요일</li>
									<li class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>[보너스] 이벤트 대상 및 혜택</dt>
							<dd>
								<ul>
									<li>이벤트 대상 : 한 달 간 10회 이상 출석한 회원</li>
									<li>이벤트 기간 : 2021년 2월 1일 ~ 2월 28일</li>
									<li>이벤트 혜택 : e머니 0점, 500점 – 즉시 지급</li>
									<li class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>[매일 출석체크] 이벤트 대상 및 혜택</dt>
							<dd>
								<ul>
									<li>이벤트 대상 : 모든 에누리 회원 (ID당 1일 1회 출석 참여 가능)</li>
									<li>이벤트 기간 : 2021년 2월 1일 ~ 2월 28일</li>
									<li>이벤트 혜택 : e머니 0점, 10점, 100점, 500점 – 즉시 지급</li>
									<li class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>공통 이벤트 유의사항</dt>
							<dd>
								<ul>
									<li>e쿠폰 스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립 해 드립니다.<br />
										<span class="noti">※ 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격 변동이 있을 수 있습니다.</span>
									</li>
									<li>부정 참여 시 본 이벤트 대상 제외 및 혜택 지급이 취소될 수 있습니다. </li>
									<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
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
	</div>
	<!-- //도전! 프로출첵러 -->

	<!-- 매일매일 출석체크 -->
	<div id="evt4" class="section evtattend">
		<div class="contents">
			<h2 class="evtattend__tit">매일매일 출석체크</h2>
			<div class="calendar-wrap">
				<div class="my-check">이번달 나의 출석일수 <strong id="curStampCnt">0</strong>일</div>
				<!-- 180711 수정 -->
				<!-- 달력 -->
				<div class="calendar">
					<ul class="cal day">
						<li>SUN</li>
						<li>MON</li>
						<li>TUE</li>
						<li>WED</li>
						<li>THU</li>
						<li>FRI</li>
						<li>SAT</li>
					</ul>
					<ul class="cal"  id="calendar">
					</ul>
				</div>
				<!--// 달력 -->

				<!-- 이벤트 목록 -->
				<div class="hotevent">
					<div class="hotevent__head">
						<h3 class="hotevent__tit">이번달 HOT 이벤트</h3>
						<%if(!"Y".equals(strAppyn)){ %>
		                	<a href="http://m.enuri.com/m/index.jsp#evt" class="hotevent__more">더 보기</a>
		                <%}else{ %>
		                	<a href="http://m.enuri.com/m/index.jsp?freetoken=main_tab|event"  class="hotevent__more" ></a>
		                <%}%>
					</div>

					<div class="hotevent__cont">
						<div class="hotevent__slide swiper-container">
							<div class="swiper-wrapper">
								<div class="swiper-slide">
									<a href="http://m.enuri.com/mobilefirst/event2021/newsemester_2021_evt.jsp?freetoken=event&tab=01"><img src="http://img.enuri.info/images/event/2021/attance/m_640_260_01.jpg" alt="새학기에-누리다. 누구나 응모하면, 푸짐한 선물 100% 당첨"></a>
								</div>
								<div class="swiper-slide">
									<a href="http://m.enuri.com/mobilefirst/event2021/newsemester_2021_deal.jsp?freetoken=event&tab=05"><img src="http://img.enuri.info/images/event/2021/attance/m_640_260_02.jpg" alt="새학기에-누리다. 새학기 준비하고, 갤럭시A7득템!"></a>
								</div>
								<div class="swiper-slide">
									<a href="http://m.enuri.com/mobilefirst/evt/apppush_event.jsp"><img src="http://img.enuri.info/images/event/2021/attance/m_640_260_03.jpg" alt="혜택엔 스피드가 생명, 제일 먼저 이벤트 소식 받고 5,000원 상품권도 받고!"></a>
								</div>
								<div class="swiper-slide">
									<a href="http://m.enuri.com/mobilefirst/evt/smart_benefits.jsp?#tab4"><img src="http://img.enuri.info/images/event/2021/attance/m_640_260_04.jpg" alt="이번달만! 최대 5만점 추가적립"></a>
								</div>
								<div class="swiper-slide">
									<a href="http://m.enuri.com/mobilefirst/evt/birthday_event.jsp"><img src="http://img.enuri.info/images/event/2021/attance/m_640_260_05.jpg" alt="생일축하합니다! 이번달 생일이라면? 500점 추가적립"></a>
								</div>
							</div>
						</div>

						<!-- If we need pagination -->
						<div class="swiper-pagination"></div>
						<div class="swiper-button-prev btn_prev"></div>
						<div class="swiper-button-next btn_next"></div>

						<script>
							$(function(){
								var mySwiper = new Swiper('.hotevent__slide',{
									pagination : ".hotevent__cont .swiper-pagination",
									prevButton : '.hotevent__cont .btn_prev',
									nextButton : '.hotevent__cont .btn_next',
									slidesPerView: 'auto',
									setBetween: 20
								});
							})
						</script>
					</div>
				</div>
				<!-- // -->
			</div>
		</div>
	</div>
	<!-- //출석체크 -->

	<!-- 룰렛 -->
	<div id="evt2" class="section evtroulette">
		<div class="contents">
			<h2 class="evtroulette__tit">하루 두번 룰렛과 함께하는 간식 TIME! 행운가득 룰렛</h2>
			<div class="inner">
				<ul class="roulette_episode">
                    <!-- 진행중인 회차에 on 클래스로 활성화 -->
                    <%

                	String inTime   = new java.text.SimpleDateFormat("HHmmss").format(new java.util.Date());

                	String ep1on = "";
                	String ep2on = "";

                	int getTime = Integer.parseInt(inTime);

                	if( getTime >=  000000 && getTime <=  150000  ){
                		ep1on = "on";
                	}else{
                		ep2on = "on";
                	}
                    %>
                    <li class="ep1 <%=ep1on%>">1차타임 12:00AM ~ 03:00PM</li>
                    <li class="ep2 <%=ep2on%>">2차타임 03:00PM ~ 12:00AM</li>
                </ul>
				<!-- roulette_con -->
				<div class="roulette_con">
					<!-- 180816 수정 -->
					<div class="r-stage">
						<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2021/attance/m_roullete__circle.png" alt="룰렛 경품판" id="image" class="imgs" />
					</div>
					<div class="r-arrow">
						<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2021/attance/m_roullete__arr.png" alt="룰렛 화살표" class="imgs" style="margin-top: 13px;" />
					</div>
					<div class="r-start">
						<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2021/attance/m_roullete__btn.png"  alt="룰렛 START 버튼" id="start_btn" class="imgs" />
					</div>
					<div class="r-bg">
						<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2021/attance/m_roullete__bg.png" alt="룰렛 바탕 원" class="imgs" />
					</div>
					<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2018/attendance/feb/m_roulette_bg.png" alt="룰렛 바탕" class="imgs" />
					<div class="bg-coin"></div>
				</div>
				<!-- //roulette_con -->

			</div>
		</div>
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop3"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop3" class="evt_notice--slide">
			<div class="evt_notice--inner">
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<dl>
							<dt>[매일 룰렛] 이벤트 대상 및 혜택</dt>
							<dd>
								<ul>
									<li>이벤트 대상 : 매일 룰렛 참여 회원 (ID당 1일 2회 참여 가능)
										<ul class="sub">
											<li>- 1차 타임 12:00:00 AM ~ 02:59:59 PM</li>
											<li>- 2차 타임 03:00:00 PM ~ 23:59:59 PM</li>
										</ul>
									</li>
									<li>이벤트 혜택 : [크리스피크림도넛] 오리지널 하프더즌 (e7,800), [베스킨라빈스] 더블주니어 아이스크림(e4,300), [세븐일레븐] 롯데 칸쵸(e1,000), e머니 100점, 10점 – 즉시 지급</li>
									<li class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>이벤트 유의사항</dt>
							<dd>
								<ul>
									<li>e쿠폰 스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립 해 드립니다.<br>
										<span class="noti">※ 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격 변동이 있을 수 있습니다.</span>
									</li>
									<li>부정 참여 시 본 이벤트 대상 제외 및 혜택 지급이 취소될 수 있습니다. </li>
									<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
								</ul>
							</dd>
						</dl>
					</div>
				</div>
				<div class="evt_notice--foot">
					<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 유의사항 닫기 -->
				</div>
			</div>
		</div>
	</div>
	<!-- //룰렛 -->

	<!-- 오늘의 한마디 -->
	<div id="evt3" class="section evttoday">
		<div class="contents">
			<h2 class="evttoday__tit">에누리 가족들의 오늘을 응원해주세요! 오늘의 한마디</h2>
			<!-- 게시판 -->

			<div class="evttoday__gift">
				<p class="blind">댓글로 [오늘의 한마디]를 남겨 주시면 추첨을 통해 경품을 드립니다.</p>
				<p class="blind">※ 당첨된 [오늘의 한마디]는 출석체크 팝업 화면에 노출 됩니다.</p>
				<p class="blind">[GS25]모바일상품권 e머니 2000점 - 30명 추첨</p>
			</div>

			<div class="input_board">
				<div class="write_area">
					<!-- 댓글 입력창 입력시 .open 클래스 추가 ex) <div class="input open"> -->
					<div class="input">
						<a href="javascript:///" class="login_alert"><!-- 로그인 전 버튼 영역 --></a>

						<textarea id="txt_area" class="txt_area" maxlength="150" placeholder="좋아하는 문구나 재밌는 문구, 힘나는 문구 남겨주세요!"></textarea>
						<!--
							댓글 입력 창 입력시 placeholder 교체
							placeholder="광고글, 욕설 등 부적합한 게시물은 관리자에 의해 삭제될 수 있습니다. 한 번 등록한 댓글은 수정이 불가하오니 등록 전 확인 부탁드립니다."
						-->
						<p class="curr"><span id="word_num">0</span>/150자</p>
						<button id="" class="btn regist board-stripe">등록하기</button>

						<!-- icon -->
						<div class="thumb_sm">
							<div class="inner">
								<div class="thumb_select">
									<p class="thumb" id="btnIcon"></p>
									<p class="btn_thumb board-stripe"></p>

									<!-- 로그인 후 노출 -->
									<p class="user" id="user_id"></p>
								</div>
								<div class="thumb_sm_list" style="">
									<div class="inner_scroll">
										<div class="swiper_wrapper">
											<a class="thumb" onclick="selectThumb(1);"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2018/attendance/jan/m_round_person1.png" alt="" class="imgs" /></a>
											<a class="thumb" onclick="selectThumb(2);"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2018/attendance/jan/m_round_person2.png" alt="" class="imgs" /></a>
											<a class="thumb" onclick="selectThumb(3);"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2018/attendance/jan/m_round_person3.png" alt="" class="imgs" /></a>
											<a class="thumb" onclick="selectThumb(4);"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2018/attendance/jan/m_round_person4.png" alt="" class="imgs" /></a>
											<a class="thumb" onclick="selectThumb(1);"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2018/attendance/jan/m_round_person1.png" alt="" class="imgs" /></a>
											<a class="thumb" onclick="selectThumb(2);"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2018/attendance/jan/m_round_person2.png" alt="" class="imgs" /></a>
											<a class="thumb" onclick="selectThumb(3);"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2018/attendance/jan/m_round_person3.png" alt="" class="imgs" /></a>
											<a class="thumb" onclick="selectThumb(4);"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2018/attendance/jan/m_round_person4.png" alt="" class="imgs" /></a>
											<a class="thumb" onclick="selectThumb(1);"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2018/attendance/jan/m_round_person1.png" alt="" class="imgs" /></a>
											<a class="thumb" onclick="selectThumb(2);"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2018/attendance/jan/m_round_person2.png" alt="" class="imgs" /></a>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- //icon -->
					</div>
					<p class="total_num">전체 글 : <span id="reply_cnt"></span></p>
				</div>
				<div class="view_area">
					<!--
						썸네일 클래스 10종
						.face1~10
					-->
					<ul>
					</ul>
				</div>
				<div class="paging" id="paginate">
				</div>
				<!-- <a href="javascript:///" class="btn stripe btn-caution" onclick="onoff('notetxt2'); return false;">꼭 확인하세요</a> -->
			</div>
			<!-- // 게시판 -->
		</div>
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop2"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop2" class="evt_notice--slide">
			<div class="evt_notice--inner">
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<dl>
							<dt>[오늘의 한마디!] 이벤트 대상 및 혜택</dt>
							<dd>
								<!-- 201209 : 내용 수정 -->
								<ul>
									<li>이벤트 대상 : 댓글로 오늘의 한마디 참여한 회원 (ID당 1일 1회 출석 참여 가능)</li>
									<li>이벤트 기간 : 2021년 2월 1일 ~ 2월 28일</li>
									<li>이벤트 혜택 : [GS25] 모바일상품권 2천원권 (e2,000) - 30명 추첨</li>
									<li>당첨자 발표 : 2021년 3월 16일 화요일<br>
										<span class="noti">※ 당첨된 오늘의 한마디는 21년 4월 출석체크 팝업 화면에 노출됩니다.</span>
									</li>
									<li class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</li>
								</ul>
								<!-- // -->
							</dd>
						</dl>
						<dl>
							<dt>이벤트 유의사항</dt>
							<dd>
								<ul>
									<li>e쿠폰 스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립 해 드립니다.<br>
										<span class="noti">※ 제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격 변동이 있을 수 있습니다.</span>
									</li>
									<li>부정 참여 시 본 이벤트 대상 제외 및 혜택 지급이 취소될 수 있습니다. </li>
									<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
								</ul>
							</dd>
						</dl>
					</div>
				</div>
				<div class="evt_notice--foot">
					<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 유의사항 닫기 -->
				</div>
			</div>
		</div>
	</div>
	<!-- // 오늘의 한마디 -->

	<!-- layer-->
	<div class="layer_back" id="benefit_layer" style="display:none;">
		<div class="appLayer">
			<h4>모바일 앱 전용 쇼핑 혜택</h4>
			<a href="javascript:///" class="close" onclick="onoff('benefit_layer')">창닫기</a>
			<p class="txt">에누리 앱(APP) 설치 후<br />e머니 적립내역 확인 및<br />다양한 e쿠폰 상품으로 교환할 수 있습니다.</p>
			<p class="btn_close"><button type="button" onclick="install_btt();">설치하기</button></p>
		</div>
	</div>

	<!-- 딤레이어 : 참가상 뽑기 당첨 -->
	<div id="joinAward" class="pop-layer" style="display:none;">
		<div class="backdim"></div>

		<div class="awardLayer">
			<div class="lay__inner">

				<p class="tit win" style="display: none;">당첨을 축하합니다! <br><strong>다음에 또 만나요~</strong></p><!--당첨-->
				<p class="tit" style="display: none;">아쉬워요! <br><strong>다음 기회에 만나요~</strong></p><!--꽝-->

				<div class="prize pr1" style="display: none;">[배스킨라빈스] 더블주니어 아이스크림 (e4,300)</div>
				<div class="prize pr2" style="display: none;">꽝</div>

				<button type="button" class="btn_confirm" onclick="onoff('joinAward');return false">확인</button>
			</div>
			<a class="close" href="javascript:void(0);" onclick="onoff('joinAward');return false"><em>팝업 닫기</em></a>
		</div>
		<!-- //prizeLayer -->
	</div>
	<!-- //딤레이어 : 참가상 뽑기 당첨 -->

	<%@ include file="/mobilefirst/evt/event_bottom.jsp"%>
</div>
</body>
<script type="text/javascript" src="/common/js/paging_crazydeal.js"></script>
<script type="text/javascript" src="/mobilefirst/js/event_roulette.js"></script>
<script type="text/javascript">
var app = getCookie("appYN"); //app인지 여부
var username = "<%=userArea%>"; <!--개인화영역 이름-->
var vChkId = "<%=chkId%>";
var vOs_type = getOsType();
var vEvent_page = "<%=strUrl%>";<!--경로-->
var startDate = "<%=startDate%>"; //이벤트시작일
var oc = '<%=oc%>';
var sdt = "<%=sdt%>";
var vEvent_title = "21년 출석/룰렛";
var reply_event_code = "2021020108"; //오늘의한마디 댓글 이벤트코드
var PAGENO = 1;
var PAGESIZE = 5;
var BLOCKSIZE = 5;
var totalcnt = 0; //댓글 총갯수
var visitPrize = "N" // 참여상 참여여부

var bannerOn = "<%=bannerOn%>";

var ep1on = "<%=ep1on%>";
var ep2on = "<%=ep2on%>";
var event_Code="<%=eventCode%>";
function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevt%2Fvisit_event.jsp";
	if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
		goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/evt/visit_event.jsp";
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
			window.open(goApp);
		}
	}else{
		setTimeout( function() {
			window.open("https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8");
		}, 1000);
	}
	location.href = goApp;
}
function firstBuyGo(){
	window.location.href = "http://m.enuri.com/mobilefirst/evt/welcome_event.jsp?freetoken=event&chk_id="+vChkId;
}
function smartBuyGo(){
	window.location.href = "http://m.enuri.com/mobilefirst/evt/smart_benefits.jsp?freetoken=event&chk_id="+vChkId;
}
var state = false;
(function(){
	if(islogin()){ //로그인상태인 경우 개인e머니 내역 노출
		getPoint();
	}
	//닫기버튼
	 $( ".win_close" ).click(function(){
	        if(app == 'Y')  window.location.href = "close://";
	        else            window.location.replace("/m/index.jsp");
	});
})();
function goNewFriendGo(){
	ga('send', 'event', 'mf_event', vEvent_title , vEvent_title + " > 출석 후 이벤트" );
	if(bannerOn=="chuseok01"){
		window.open("http://m.enuri.com/mobilefirst/event2019/chuseok_2019.jsp?freetoken=event");
	}else if(bannerOn=="chuseok02"){
		window.open("http://m.enuri.com/mobilefirst/event2019/chuseok_2019.jsp?freetoken=event");
	}else if(bannerOn=="winter"){
		window.open("http://m.enuri.com/mobilefirst/event2020/newsemester_2020_evt.jsp?freetoken=event");
	}else{
		window.open("http://m.enuri.com/mobilefirst/evt/new_friend_20179.jsp?freetoken=event");
	}
	return false;
}
function goWelcomeFirstbuy() {
	ga('send', 'event', 'mf_event', vEvent_title, vEvent_title + " > 보너스혜택 이벤트배너" );
	if(sdt<20201005){
		window.open("/mobilefirst/evt/firstbuy100_event.jsp?freetoken=event&chk_id="+vChkId);
	}else{
		window.open("/mobilefirst/evt/welcome_event.jsp?freetoken=event&chk_id="+vChkId);
	}
}
function CmdShare(){
	shareUrl = "http://" + location.host + "/mobilefirst/evt/visit_event.jsp?oc=mo";
	Kakao.Link.createDefaultButton({
		  container: '#kakao-link-btn',
	      objectType: 'feed',
	      content: {
	        title: '[에누리 가격비교] 매일 출석&룰렛 이벤트',
	        description: '매일 출석 체크하면, e머니가 팡팡!',
	        imageUrl: "http://img.enuri.info/images/event/2021/attance/sns_1200_630.jpg",
	        link: {
	          webUrl: shareUrl,
	          mobileWebUrl: shareUrl
	        }
	      },
		buttons: [{
	          title: '매일 출석/룰렛',
	          link: {
	            mobileWebUrl: shareUrl,
	            webUrl: shareUrl
	          }
		}]
    });
}
$(document).ready(function() {
	if(oc!=''){
		$('.lay_only_mw').show();
	}

	$(".hotevent__cont").click(function(){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title + " > HOT 이벤트" );
	});

	$("#eventShr > li").click(function(){
		var sel = $(this).attr("id");
		var shareTitle = "[에누리 가격비교] 매일 출석&룰렛 이벤트\n매일 출석체크하면, e머니가 팡팡!";
		shareUrl = "http://" + location.host + "/mobilefirst/evt/visit_event.jsp?oc=mo";
		if(sel == "fbShare"){
			try{
				window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(shareTitle)+"&u="+shareUrl);
			}catch(e){
				window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(shareTitle)+"&u="+shareUrl);
			}
		}else if(sel == "twShare"){
			try {
				window.android
						.android_window_open("http://twitter.com/intent/tweet?text="
								+ encodeURIComponent(shareTitle)
								+ "&url=" + shareUrl);
			} catch (e) {
				window.open("http://twitter.com/intent/tweet?text="
						+ encodeURIComponent(shareTitle) + "&url="
						+ shareUrl);
			}
		}
	});
	var luckeyDayList = [];
	var holiday = []; //휴일

	var cnkCnt = 0;

	var isClick = true,
		isClick2 = true;

	var todayDate = Number("<%=sdt%>".substring(6,8));
	var inner_comment = "";

	//트래픽체크
	ga('send', 'pageview', {	    'page': vEvent_page,	    'title': vEvent_title + ' > PV'	});

	// 달력+오늘날짜에 체크버튼
	calendarMake();
	setTodayComment();
	// 럭키데이 설정
	setLuckeyDay();
	// 댓글 페이지 호출
	getEventList(PAGENO, PAGESIZE);

	// 개인정보 불러오기
	if(islogin()){
		$(".login_alert").addClass("disNone");
		<%
		String snsType = ChkNull.chkStr(cb.GetCookie("MEM_INFO","SNSTYPE"));
		if( "K".equals(snsType) ||  "N".equals(snsType) ){//sns 계정일 경우 닉네임을 넣어준다
		%>
		$("#user_id").text("<%=cUserNick%>");
		<%}else{%>
		$("#user_id").text("<%=cUserId%>");
		<%} %>
		getUserVistData();
		getRouletteCnt();
		// 참여상 참여이력
		getAttendPrize();
	}
	// 댓글 썸네일 랜덤 호출
	var rdm = Math.floor(Math.random() * 3) + 1;
	$("#btnIcon").append('<img id="selected_thumb" src="<%=ConfigManager.IMG_ENURI_COM%>/images/event/2018/attendance/jan/m_round_person'+ rdm +'.png" '
			+ 'alt="" class="imgs" idx="'+ rdm +'"/>');

	$(document).mouseup(function(e){
		var container = $(".txt_area");
		if(container.has(e.target).length==0){
			$(this).find("#txt_area").attr("placeholder", "글을 입력해주세요");
			$(".input.open").removeClass("open");
	    }
	});
	$('.txt_area').on('keyup', function() {	$("#word_num").text($(this).val().length);	});

	//뽀나스 혜택 이벤트 클릭
	$("#bonus_reward, #bonus_button").click(function(e){

		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title + " > 뽀나스혜택" );

		if(!isClick2)			return false;

		isClick2=false;
		if(!islogin()) {
		    alert("로그인 후 참여할 수 있습니다.");
		    goLogin();   //login_check.jsp
		    return false;
		}
		var url = "/mobilefirst/evt/ajax/visit_bonus_first_setlist.jsp";
	    var param = "osType="+vOs_type+"&sdt="+sdt;

	    $.ajax({
	        type: "POST",
	        url: url,
	        async: true,
	        data: param,
	        dataType: "JSON",
	        success: function(json){
	        	var result = json.result;

	        	if(result == 1){//축하합니다.
	        		$("#voteLayer_200").show();
	        		$("#bonusLayer").show();
	        	}else if(result == -1){//이미 보너스 해택을 받았으셨습니다.
	        		$("#voteLayer_1").show();
	        		$("#bonusLayer").show();
	        	}else if(result == -2){//출석 첫 참여가 아닙니다.
	        		alert("첫 출석 참여자가 아닙니다.");
	        	}else if(result == -4){
	        		alert("SDU 회원은 본인인증 후 참여 가능합니다.\n※ 본인인증은 ‘앱 설정 > 본인인증’ 또는 ‘PC >\n개인정보관리 화면’을 이용해주세요");
	        	}else if(result==-5){
	        	   var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
				   if(r){
					   location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
				   }
	        	}else{
	        		alert("잘못된 접근입니다.");
	        	}
	        	isClick2 = true;
	        }
	    });
	});
	//달력만들어주는 함수
	function calendarMake(){
		/* 이벤트시작일의 달을 기준으로 달력을 생성합니다. */
		var y = startDate.substring(0,4); // 현재 연도
		var m = parseInt(startDate.substring(4,6))-1; // 현재 월

		// 현재 년(y)월(m)의 1일(1)의 요일을 구합니다.
		var theDate = new Date(y,m,1);
		var theDay = theDate.getDay();//그날의 요일
		var last = [31,28,31,30,31,30,31,31,30,31,30,31]; //1월부터 12월의 마지막일

		// 현재 월의 마지막 일이 며칠인지 구합니다.
		var lastDate = last[m];
		/* 현재 월의 달력에 필요한 행의 개수를 구합니다. */
		    // theDay(빈 칸의 수), lastDate(월의 전체 일수)
		var row = Math.ceil((theDay+lastDate)/7);
		/* 달력 연도/월을 표기하고 달력이 들어갈 테이블을 작성합니다. */
		//document.write("<h1>" + y + "." + (m+1) + "</h1>");
		var calenderTmpl="";
		// 달력에 표기되는 일의 초기값!
		var dNum = 1;
		for (var i=1; i<=row; i++) { // 행 만들기
		    for (var k=1; k<=7; k++) { // 열 만들기
		    	// 월1일 이전은 빈 칸으로
		    	if(i===1 && k<=theDay) {
		    		calenderTmpl +="<li class='pass'><span>"+(last[(m+11)%12]-theDay+k)+"</span></li>";
		    		//$("#calendar").append("<li class='pass'><span>"+(last[m-1]-theDay+k)+"</span></li>");
		        }
		    	//월 마지막일 이후
		    	else if(dNum>lastDate){
		    		calenderTmpl +="<li class='pass'><span>"+(dNum-lastDate)+"</span></li>";
		    		//$("#calendar").append("<li class='pass'><span>"+(dNum-lastDate)+"</span></li>");
		        	dNum++;
		        }
		    	//해당 달의 온전한 day (1~30)
		        else {
		        	calenderTmpl +="<li id='day_"+dNum+"'><span>"+dNum+"</span><strong>출석체크</strong></li>";
		    		//$("#calendar").append("<li id='day_"+dNum+"'><span>"+dNum+"</span><strong>출석체크</strong></li>");
		            dNum++;
		        }
		    }
		}
		$("#calendar").html(calenderTmpl);

		$.each(holiday,function(i,v){
			$("li#day_" + v).addClass("holiday");
		});

		var todayArea = $("#day_"+ todayDate).addClass("today");
		todayArea.find("strong").addClass("check before");

		todayArea.click(function(e){
			if(!isClick){
				return false;
			}
			isClick=false;
			if(!islogin()) {
			    alert("로그인 후 참여할 수 있습니다.");
			    goLogin();   //login_check.jsp
			    return false;
			}

			var url = "/mobilefirst/evt/ajax/visit_setlist.jsp";
		    var param = "strEventId="+event_Code+"&job=1&osType="+vOs_type+"&sdt="+sdt;

		    if(app == "Y")    ga('send', 'event', vEvent_title+'_APP', 'button', '출석하기_'+sdt);
		    else              ga('send', 'event', vEvent_title+'_WEB', 'button', '출석하기_'+sdt);

			goAdbrix("evt_visit_attend_click");

		    $.ajax({
		        type: "POST",
		        url: url,
		        async: true,
		        data: param,
		        dataType: "JSON",
		        success: function(data){
		        	var result = data.result;
		        	if (result == "0") {
		        		alert("잘못된 접근입니다.");
		        		isClick=true;
					}else if(result == "1"){
						alert("오늘은 이미 참여하셨습니다. 내일 다시 만나요~");
						isClick=true;
					}else if(result=="-1"){
						alert("임직원은 참여 불가 합니다");
						isClick=true;
					}else if(result==-4){
						alert("SDU 회원은 본인인증 후 참여 가능합니다.\n※ 본인인증은 ‘앱 설정 > 본인인증’ 또는 ‘PC >\n개인정보관리 화면’을 이용해주세요");
						isClick=true;
					}else if(result==-5){
						var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
						if(r){
							location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
						}
						isClick=true;

					}else{
		                setTodayChk(); //출석체크 도장찍기
		                $("#curStampCnt").text(++cnkCnt); //나의 출석일수 +1 증가
		                visitCntView(cnkCnt); // 개근상/참가상 활성화
		            	getPoint();//e머니 다시불러오기
						$("#TodaysayLayer").show();
		            	//$(".todaysay .ico.e"+result).show();
						todayComment(result);
						//$("#attendCheck").show();
		            }
		        }
		    });
		});
	}

	//user의 출석체크상태
	function getUserVistData() {
	    var vData = {strEventId: event_Code};
	    $.ajax({
	        type: "POST",
	        url: "/event2016/visit2016_getlist.jsp",
	        data: vData,
	        dataType: "JSON",
	        success: function(json){
	            if (json.event_list.length > 0 && json.event_list != "false" ) {
	                cnkCnt=json.curStampNum;//나의 출석일수
	                $("#curStampCnt").text(cnkCnt);

	                visitCntView(cnkCnt);

	                $.each(json.event_list, function(i, v){
	                	//출석체크한 경우
	                	if(v.cnt > 0){
	                		if(v.item_seq != todayDate){
	                			$("#day_"+v.item_seq +"> strong").addClass("check");
	                			//$("#day_"+v.item_seq+" > .lucky").hide();
	                		}else{
	                			setTodayChk(); //오늘출석완료
	                		}
	                	}
	                });
	            }
	        },
	        error: function (xhr, ajaxOptions, thrownError) {
	            alert(xhr.status);
	            alert(thrownError);
	        }
	    });
	}

	// 출석 개근상/우수상 cnt
	function visitCntView(cnt){
		if(cnt >= 10){ // 개근상/우수상/참가상
        	if(cnt >= 28){ //개근상
        		$(".evtnotice__list .evtnotice__item.item1 .btn--join").hide();
        		$(".evtnotice__list .evtnotice__item.item1 .btn--complete").show();
        		$(".evtnotice__list .evtnotice__item.item2 .btn--join").show();
        		$(".evtnotice__list .evtnotice__item.item2 .btn--complete").show();
        	}else if(cnt >= 20){ // 우수상
        		$(".evtnotice__list .evtnotice__item.item2 .btn--join").hide();
        		$(".evtnotice__list .evtnotice__item.item2 .btn--complete").show();
        		$(".evtnotice__list .evtnotice__item.item1 .btn--join").show();
        		$(".evtnotice__list .evtnotice__item.item1 .btn--complete").hide();
        	} else if(cnt >= 10){ // 출석일이 10일 이상 && 응모이력여부
				if(visitPrize == "N"){ // 응모이력X
					$(".evtnotice__list .item3 .btn--disabled").hide();
					$(".evtnotice__list .item3 .btn--attend-complete").hide();
					$(".evtnotice__list .item3 .btn--active").show();
				}else{ // 응모이력O
					$(".evtnotice__list .item3 .btn--disabled").hide();
					$(".evtnotice__list .item3 .btn--active").hide();
					$(".evtnotice__list .item3 .btn--attend-complete").show();
				}
        	}
        }
	}

	function todayComment(eMoney){
		var inner_html="";
		var inner_emoney="";
		inner_emoney += '<div class=\"f_wrap\"><i class=\"boximg\">아이콘1</i><i class=\"ico e'+eMoney+'\">'+eMoney+'</i></div>';
		inner_html = inner_emoney + inner_comment;
		$("#TodaysayLayer #todayUserMsg").after(inner_html);
	}
	//러키데이 설정
	function setLuckeyDay(){
		for(var i=0;i<luckeyDayList.length;i++){
			if(luckeyDayList[i] >= todayDate){// 아직 안지난 러키데이
		     	$("#day_"+luckeyDayList[i]).append("<div class=\"lucky\"></div></li>");
			}else{//지나간 러키데이는 흑백이미지
		     	$("#day_"+luckeyDayList[i]).append("<div class=\"lucky past\"></div></li>");
			}
		}
	}
	//오늘날짜에 도장찍기
	function setTodayChk(){
	    var _dayChk = $("#day_" + todayDate);
	    _dayChk.find("strong").removeClass("before");
		_dayChk.find(".lucky").hide();
	}

	function setTodayComment(){
		//reply_event_code
		var url = "/mobilefirst/evt/ajax/ajax_setTodayComment.jsp";
		var str = "",
		fClass = "";
		$.ajax({
			type: "POST",
			url: url,
			data: {
				reply_eventcode : "2020120106",
				sdt : <%=numSdt%>
			},
		    dataType: "JSON",
		    success: function(result){
		        inner_comment = "<div class=\"f_txt\"><p class='txt'><span> "+result.reply_list.reply_msg+"</span></p>";
		    	inner_comment += "<span class=\"uid\">- 당첨자 <strong>"+result.reply_list.usrid+"</strong>님의 한마디 -</span></div>";
			},
			error: function (xhr, ajaxOptions, thrownError) {}
	    });

	}


});

// 참가상 뽑기
function bonusPick(){
	if(!islogin()) {
	    alert("로그인 후 참여할 수 있습니다.");
	    goLogin();   //login_check.jsp
	    return false;
	}

	var vData = {strEventId: "2021020105", job : "2", sdt : sdt, "osType" : "MO"};
	$.ajax({
		type: "POST",
		url: "/event2016/visit2016_setlist.jsp",
		dataType: "JSON",
        data: vData,
		success:function(v){
			if(v.result == "-2"){ // 임직원
				alert("임직원은 참여 불가 합니다!");
			}else if(v.result == "-9"){ // 이벤트 대상X
				$(".evtnotice__list .item3 .btn--active").hide();
				$(".evtnotice__list .item3 .btn--attend-complete").hide();
				$(".evtnotice__list .item3 .btn--disabled").show();
				alert("한 달 간 10회 이상 출석 후 참여해주세요.");
			}else if(v.result == "-8"){ // 참가상 참여이력O
				$(".evtnotice__list .item3 .btn--disabled").hide();
				$(".evtnotice__list .item3 .btn--active").hide();
				$(".evtnotice__list .item3 .btn--attend-complete").show();
				alert("이미 참여하셨습니다. 다음에 또 만나요!");
			}else if(v.result >= "500"){ //e500
				// 참가상 참여이력 X
				$("#joinAward").show();
				$(".tit").hide();
				$(".tit.win").show();
				$(".awardLayer .prize.pr1").show();
				$(".awardLayer .prize.pr2").hide();
				$(".evtnotice__list .item3 .btn--disabled").hide();
				$(".evtnotice__list .item3 .btn--active").hide();
				$(".evtnotice__list .item3 .btn--attend-complete").show();
			}else if(v.result >= "0"){ //e0
				// 참가상 참여이력 X
				$("#joinAward").show();
				$(".tit").show();
				$(".tit.win").hide();
				$(".awardLayer .prize.pr1").hide();
				$(".awardLayer .prize.pr2").show();
				$(".evtnotice__list .item3 .btn--disabled").hide();
				$(".evtnotice__list .item3 .btn--active").hide();
				$(".evtnotice__list .item3 .btn--attend-complete").show();
			}
		}
	});
}

// 참가상 참여이력
function getAttendPrize(){
	 var vData = {strEventId: "2021020105", procCode : "2"};
    $.ajax({
        type: "POST",
        url: "/event2016/visit2016_getlist.jsp",
        data: vData,
	    dataType: "JSON",
	    success: function(v){
			if(v.result == -1){ // 대상X
				$(".evtnotice__list .item3 .btn--active").hide();
				$(".evtnotice__list .item3 .btn--attend-complete").hide();
				$(".evtnotice__list .item3 .btn--disabled").show();
			}else if(v.result == 0){  // 참여이력 O
				visitPrize = "Y";
				$(".evtnotice__list .item3 .btn--disabled").hide();
				$(".evtnotice__list .item3 .btn--active").hide();
				$(".evtnotice__list .item3 .btn--attend-complete").show();
			}else if(v.result == 1){ // 참여이력X
				visitPrize = "N";
				$(".evtnotice__list .item3 .btn--disabled").hide();
				$(".evtnotice__list .item3 .btn--attend-complete").hide();
				$(".evtnotice__list .item3 .btn--active").show();
			}
	    },error: function (xhr, ajaxOptions, thrownError) {}
    });
}

$(window).load(function() {
	//상단 탭 이동
	$(".floattab__list > ul > li > a").click(function(e){
		var evtArea = $(this).attr('href');
		if(evtArea == "#evt1"){
			ga('send', 'event', 'mf_event', vEvent_title, vEvent_title + " > 무빙탭_출석체크" );
		}else if(evtArea == "#evt2"){
			ga('send', 'event', 'mf_event', vEvent_title, vEvent_title + " > 무빙탭_매일룰렛" );
		}

		var $anchor = Math.ceil($($(this).attr('href')).offset().top);
		$('html, body').stop().animate({scrollTop: $anchor - 40}, 500);
		e.preventDefault();
	});

	var $nav = $(".floattab__list"), // scroll tabs
		$navTop = $('.floattab').offset().top;
		$ares1 = Math.floor($("#evt1").offset().top - 40),
		$ares2 = Math.floor($("#evt2").offset().top - 40),
		$ares3 = Math.floor($("#evt3").offset().top - 40);

	var tab = "<%=tab%>";
	if(tab == "1"){
		setTimeout(function() {
			$('html, body').stop().animate({scrollTop: $ares1}, 500);
	    },500);

	}else if(tab == "2"){
		setTimeout(function() {
			$('html, body').stop().animate({scrollTop: $ares2}, 500);
	    },500);
	}else if(tab == "3"){
		setTimeout(function() {
			$('html, body').stop().animate({scrollTop: $ares3}, 500);
	    },500);
	}
	// 상단 탭 position 변경 및 버튼 활성화
	$(window).scroll(function(){
		var $currY = $(this).scrollTop(); // 현재 scroll

		if ($currY > $navTop) {
			$nav.addClass("is-fixed");
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
			$nav.removeClass("is-fixed");
			$(".floattab__item").removeClass("is-on");
		}

		// 윈도우 닫기버튼
		if($(this).scrollTop() >= $(".visual").offset().top){
			$(".myarea").addClass("f-nav");
		}else{
			$(".myarea").removeClass("f-nav");
		}
	});

	/* //상단탭 클릭 이벤트
	$("#tabmenu > li").click(function(e){
		var idx = $(this).index();

		if(idx == 0){
			var $anchor = $($(this).find("a").attr('href')).offset().top;
			$('html, body').stop().animate({scrollTop: $anchor}, 500);
		}else{
	    	var vUrl = "";//이동 URL
	    	var vLabel = "상단탭_"; //GA 라벨명
	     	if(idx == 1){
	    		vUrl = "/mobilefirst/evt/buy_event.jsp?freetoken=event";
	    		vLabel += "구매혜택";
	    	}else if(idx == 2){
    			vUrl = "/mobilefirst/evt/welcome_event.jsp?freetoken=eventclone&tab=1";
	    		vLabel += "첫구매";
	    	}
	    	if(app == "Y"){
	    	    ga('send', 'event', vEvent_title+'_APP', 'button', vLabel);
	    	}else{
	    	    ga('send', 'event', vEvent_title+'_WEB', 'button', vLabel);
	    	}
	    	window.open(vUrl);
	    	return false;
		}
    }); */

	//룰렛
	$("#start_btn").click(function(){
		$("#start_btn").unbind("click");
		rotation();
	});

	//아이콘 선택
	$("#btnIcon").on("click", function(e){
		if(!state){
			$(".thumb_sm").css("z-index", 100);
			$(".thumb_sm_list").addClass("showIcon");
			state = true;
		}else{
			$(".thumb_sm_list").removeClass("showIcon");
			$(".thumb_sm").animate({"z-index": 0}, 300);
			$(".txt_area").focus();
			state = false;
		}
	});
	//댓글 클릭 및 등록 이벤트
	$(".login_alert").on("click", function(e){
		alert('로그인 후 참여할 수 있습니다.');
		goLogin();
		return false;
	});
	$(".txt_area").on("click", function(e){
		$(this).parent().addClass("open");
		$(this).attr("placeholder", "광고글, 욕설 등 부적합한 게시물은 관리자에 의해 삭제될 수 있습니다. 한 번 등록한 댓글은 수정이 불가하오니 등록 전 확인 부탁드립니다.");
		$(".txt_area").focus();
	});
	$(".btn.regist.board-stripe").click(function(){
		if(!islogin()){
	        alert("로그인 후 참여 가능합니다.");
	        goLogin();
	        return false;
	    }
	    var replyMsg = $(".txt_area").val();
	    var count = replyMsg.length;
	    var idx= $("#selected_thumb").attr("idx");

	    if(count < 10){
	    	alert("10자 이상 입력해주세요.");
	    }else{
	    	var url = "/event2016/mobile_award_setlist.jsp";
			var vData = {replyMsg : replyMsg, event_id : reply_event_code, iconFlag : idx, osType : vOs_type};
			$.ajax({
		        type: "POST",
		        url: url,
		        data: vData,
		        dataType: "JSON",
		        success: function(result){
		        	if (result.result == "true") {
		        		getEventList(1, PAGESIZE);
		        		alert("등록되었습니다!");
		        		$(".txt_area").val("");
		        	}else if (result.result == -5) {

		        		var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
						if(r){
							location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
						}
		        	}else if (result.result == -99) {

		        		alert("임직원은 참여 불가 합니다!");

		        	} else {
						alert("오늘은 이미 참여해 주셨습니다! \n내일 또 남겨주세요~");
					}
		        	$("#txt_area").val("");
		        	$("#word_num").text("0");
		        },
				error: function (xhr, ajaxOptions, thrownError) {}
		    });
	    }
	});

	$('#reply_area').on('keyup', function() {
		$("#word_num").text($(this).val().length + " /80"); // 댓글창 입력사이즈 보여주기
	});

	if(islogin()){
		$("#input_area").attr("class","input login");
	     $("#reply_area").attr("placeholder", "광고글, 욕설 등 부적합한 게시물은 관리자에 의해 삭제될 수 있습니다.\n 한 번 등록한 댓글은 수정이 불가하오니 등록 전 확인 부탁 드립니다.");
	} else{
		$("#input_area").attr("class","input logout");
	}
});

function clickCnt(){
	ga('send', 'event', 'mf_event', '매일룰렛',  '매일룰렛_나의참여횟수');
	goLogin();
}

function selectThumb(type){
	$("#selected_thumb").attr("src","<%=ConfigManager.IMG_ENURI_COM%>/images/event/2018/attendance/jan/m_round_person" + type + ".png");
	$("#selected_thumb").attr("idx",type);
	$(".thumb_sm_list").removeClass("showIcon");
	$(".thumb_sm").animate({"z-index": 0}, 300);
	$(".txt_area").focus();
	$(".input").addClass("open");
	state = false;
}

//get 게시판, navigation
function getEventList(varPageNo, varPageSize) {
	$.ajax({
		type: "GET",
		url: "/event2016/mobile_award_getlist.jsp",
        data: "pageno="+varPageNo+"&pagesize="+varPageSize+"&event_id="+reply_event_code+"&del_yn=N",
		dataType: "JSON",
		success : function(json){
			$("#body_list").html(null);
			if(json.eventlist){ // get 게시판
				var template = "";
				var idx = Math.floor(Math.random() * 4);

				for(var i=0;i<json.eventlist.length;i++){
					if(i==0){
						totalcnt = json.eventlist[i].totalcnt;
						$("#reply_cnt").text(totalcnt);
					}
					var iconFlag = Number(json.eventlist[i].iconFlag);
					var reply_date = json.eventlist[i].reply_date;
					var year = reply_date.substring(0,4);
					var month = reply_date.substring(6,4);
					var day = reply_date.substring(8,6);
					var user_id = json.eventlist[i].user_id;
					var reply_msg = XSSfilter(json.eventlist[i].reply_msg).replace(/\n/gi, "<br>");

					template +="<li>";
					template +="<p class='thumb'><img src=\"<%=ConfigManager.IMG_ENURI_COM%>/images/event/2018/attendance/jan/m_round_person"+iconFlag+".png\" class=\"imgs\" ></p>";
                    template +="<p class='user'>"+user_id+"</p>";
	                template +="<p class='cont'>"+reply_msg+"</p>";
                    template +="</li>";

				}
				$(".view_area > ul").html(template);

				// get navigation
				if (totalcnt != 0) {
					var paging2 = new paging(varPageNo, varPageSize, BLOCKSIZE, totalcnt, 'paginate','goPage');
				  	paging2.calcPage();
				  	paging2.getPaging();
				  	if(varPageNo!=1){
				  		var offset = $("#reply_cnt").offset();
	        			var head = $(".nav").outerHeight();
	        	    	$("html,body").stop(true).animate({scrollTop:offset.top - head - 50},50,"swing");
				  	}
				}
			}
		}, complete : function(){
			$("#paginate > ul > li").click(function(e){
				$("#paginate > ul > li:eq("+$(this).index()+")").removeClass("selected");
			});
		}, error : function (xhr, ajaxOptions, thrownError) {
		}
	});

	function XSSfilter (content) {
		return content.replace(/\</g, "&lt;").replace(/\>/g, "&gt;");
	}
	goAdbrix("evt_visit_view");
}
// 페이지 이동
function goPage(pageno) {
	getEventList(pageno, PAGESIZE);
}
//참여횟수
function getRouletteCnt(){
	$.ajax({
		type: "POST",
		url: "/mobilefirst/evt/ajax/roulette_getlist.jsp",
		data:{sdt:sdt},
		dataType: "JSON",
		success:function(json){
			$(".box").addClass(" logs");
			$("#rouletteCnt").html("오늘 나의 참여횟수 <em>"+json.rouletteCnt+"</em>회");
		}
	});
}
//룰렛참여
function rotation(test){
	ga('send', 'event', 'mf_event', '매일룰렛',  '매일룰렛_START');
	if(!islogin()) {
	    alert("로그인 후 참여할 수 있습니다.");
	    goLogin();   //login_check.jsp
	    return false;
	}
	$("#start_btn").unbind();
	var rotateMin=0;
	var rotateMax=0;
	var result=0;
	var num = -1;
	var vData = {osType:getOsType(), sdt:sdt };
	$.ajax({
		type: "POST",
		url: "/mobilefirst/evt/ajax/roulette2_setlist.jsp",
		dataType: "JSON",
        data: vData,
		success:function(json){
			result=json.result;
			if(typeof test !="undefined"){
				result = test;
			}

			if(result>=0){
				var itemObj = new Object();
				if(json.part == 1){
					$(".prizeLayer").addClass("ep1");
					$(".prizeLayer").removeClass("bomb");
				}else if(json.part == 2){
					$(".prizeLayer").addClass("ep2");
					$(".prizeLayer").removeClass("bomb");
				}
				//꽝
				if(result==0){
					rotateMin=226;
					rotateMax=314;

					if(json.part == 1){
						//itemObj.msg = "아쉽게도 당첨되지 않으셨습니다.<br>오후 3시에 재도전 하세요";
						$(".prizeLayer").addClass("ep1");
						$(".prizeLayer").addClass("bomb ep1");
					}else if(json.part == 2){
						//itemObj.msg = "아쉽게도 당첨되지 않으셨습니다.<br>내일 또 돌려요";
						$(".prizeLayer").addClass("ep2");
						$(".prizeLayer").addClass("bomb ep2");
					}

					$("#roulette_txt").html("");
					itemObj.imgSrc = "/images/event/2017/welcome/prezis5.png";

					$(".msg_txt").html(itemObj.msg);
					//$(".tit").html("<img src=\"<%=ConfigManager.IMG_ENURI_COM%>/images/event/2017/welcome/layer_tit_bomb.png\" alt=\""+ itemObj.msg +"\" class=\"imgbox\" />");
					num = 180;
					$(".prizeLayer .prize.pr6").show();
				}else if(result==10){
					rotateMin=46;
					rotateMax=134;
					//경품 레이어 지정
					//itemObj.imgSrc = "/images/event/2017/welcome/prezis4.png";
					//itemObj.msg = "e머니 10점";
					num = 0;
					$(".prizeLayer .prize.pr5").show();
				}else if(result==100){
					rotateMin=46;
					rotateMax=134;
					//경품 레이어 지정
					//itemObj.imgSrc = "/images/event/2017/welcome/prezis4.png";
					//itemObj.msg = "e머니 100점";
					num = 240;
					$(".prizeLayer .prize.pr4").show();
				}else if(result==1000){
					rotateMin=136;
					rotateMax=224;
					//itemObj.imgSrc = "/images/event/2018/attendance/nov/m_roullete_img2.jpg";
					//itemObj.imgSrc = "/images/event/2019/attendance/dec/m_roullete_img2.jpg";
					//itemObj.msg = "[세븐일레븐] 롯데 칸쵸 e1,000";
					num = 60;
					$(".prizeLayer .prize.pr3").show();
				}else if(result==4300){
					rotateMin=136;
					rotateMax=224;
					//itemObj.imgSrc = "/images/event/2018/attendance/nov/m_roullete_img2.jpg";
					//itemObj.imgSrc = "/images/event/2019/attendance/dec/m_roullete_img2.jpg";
					//itemObj.msg = "[베스킨라빈스] 더블주니어 아이스크림 e4,300";
					num = 300;
					$(".prizeLayer .prize.pr1").show();
				}else if(result==7800){
					rotateMin=-44;
					rotateMax=44;
					//itemObj.imgSrc = "/images/event/2018/attendance/nov/m_roullete_img1.jpg";
					//itemObj.imgSrc = "/images/event/2019/attendance/dec/m_roullete_img1.jpg";
					//itemObj.msg = "[크리스피크림도넛] 오리지널 하프더즌  e7,800";
					num = 120;
					$(".prizeLayer .prize.pr2").show();
				}

				var rnd = Math.floor(Math.random()*60) - 60;
				if(rnd == 0 || rnd == -60) rnd = -30;

				$(".gift_img").html("<img src=\"<%= ConfigManager.IMG_ENURI_COM%>"+ itemObj.imgSrc +"\" alt=\""+itemObj.msg+"\" class=\"imgbox\" />");
				$("#image").rotate({
					angle:0,
					//animateTo: 360 * 6 + randomize(rotateMin,rotateMax),
					animateTo: 360 * 4 + num+ rnd,
					center: ["50%", "50%"],
					easing: $.easing.easeInOutElastic,
					duration:5000,
					callback: function(){
						getPoint();
						getRouletteCnt();
						$("#roulleteLayer").show();
						$("#start_btn").click(function(){
							rotation();
						});
					}
				});
			}else if(result==-1){
				if(json.part == 1)		alert("1차 타임 이미 참여하셨습니다.\n2차 타임 또 돌려요~");
				else if(json.part == 2)	alert("2차 타임 이미 참여하셨습니다.\n내일 또 돌려요~");

				$("#start_btn").click(function(){ 	rotation();	});
			}else if(result==-2){
				alert("임직원은 참여불가 합니다");
				$("#start_btn").click(function(){
					rotation();
				});
			}else if(result==-3 || result==-55){
				alert("잘못된 접근입니다.");
				$("#start_btn").click(function(){
					rotation();
				});
			}else if(result==-4){
				alert("SDU 회원은 본인인증 후 참여 가능합니다.\n※ 본인인증은 ‘앱 설정 > 본인인증’ 또는 ‘PC >\n개인정보관리 화면’을 이용해주세요");
				$("#start_btn").click(function(){
					rotation();
				});
			}else if(result==-99){
				alert("임직원은 참여 불가 합니다! ");

			}else if(result==-5){
				var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
				if(r){
					location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
				}
			}
		}
	});
}
function goAdbrix(strEvent){
	if(app == "Y"){
		try{
	        if(window.android){            // 안드로이드
				window.android.igaworksEventForApp (strEvent);
	        }else if(/iPhone|iPad|iPod/i.test(navigator.userAgent)){// 아이폰에서 호출
	            window.location.href = "enuriappcall://igaworksEventForApp?strEvent="+ strEvent;
	        }
		}catch(e){}
	}
}
//룰렛각도 랜덤값
function randomize($min, $max){
    return Math.floor(Math.random() * ($max - $min + 1)) + $min;
}
</script>
<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>