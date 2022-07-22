<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
String strFb_title = "[에누리 가격비교] PC/부품 구매왕 이벤트";
String strFb_description = "구매왕 도전하고 지포스 RTX 3080 받자!";
String strFb_img = ConfigManager.IMG_ENURI_COM+"/images/event/2020/kingofbuy/sns_1200_630.jpg";

if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{ //pc일때 접속페이지 변경.
	response.sendRedirect("/event2020/kingofbuy_evt.jsp");
	return;
}
String oc = ChkNull.chkStr(request.getParameter("oc"), "");
String chkId     = ChkNull.chkStr(request.getParameter("chk_id"),"");
String cUserId   = cb.GetCookie("MEM_INFO","USER_ID");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

Members_Proc members_proc = new Members_Proc();
String cUsername = members_proc.getUserName(cUserId);
String userArea = cUsername;

String strUrl = request.getRequestURI();

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;

    if(cUsername.equals(""))        userArea = cUserNick;
    if(userArea.equals(""))        userArea = cUserId;
}
String tab = ChkNull.chkStr(request.getParameter("tab"),"");
String flow = ChkNull.chkStr(request.getParameter("flow"));

SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");	//오늘 날짜
String strToday = formatter.format(new Date());
String sdt = ChkNull.chkStr(request.getParameter("sdt"));

if(!"".equals(sdt) && request.getServerName().equals("dev.enuri.com")){
	strToday = sdt;
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<META NAME="description" CONTENT="<%=strFb_description%>">
	<META NAME="keyword" CONTENT="에누리가격비교, 프로모션, PC/부품 구매왕 이벤트">
	<meta property="og:title" content="<%=strFb_title%>">
	<meta property="og:description" content="<%=strFb_description%>">
	<meta property="og:image" content="<%=strFb_img%>">
	<meta name="format-detection" content="telephone=no" />
	<!-- 프로모션 공통 CSS (Mobile) -->
	<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
	<link rel="stylesheet" href="/css/event/y2020/kingofbuy_m.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/js/swiper.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
	<script type="text/javascript" src="/common/js/function.js"></script>
</head>
<body>
<div class="lay_only_mw" style="display: none;">
	<div class="lay_inner">
		<div class="lay_head">
			앱에서는 득템의 기회 <em>타임특가</em>에 참여할 수 있어요!
		</div>
		<!-- 버튼 : 에누리앱으로 보기 -->
		<button class="btn_go_app" onclick="view_moapp();">에누리앱으로 보기</button>
		<!-- 버튼 : 모바일웹으로 보기 -->
		<a href="javascript:void(0);" class="btn_keep_mw" onclick="$('.lay_only_mw').fadeOut(100);">괜찮아요. 모바일 웹으로 볼래요</a>
	</div>
</div>
<div id="eventWrap" class="event_wrap">

	<div class="myarea">
		<%if(cUserId.equals("")){%>	
			<p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>	
			<%}else{%>
			<p class="name"><%=userArea%> 님<span id="my_emoney">0점</span></p>
			<%}%>
		<a href="javascript:///" class="win_close">창닫기</a>
	</div>
	
	<!-- 비쥬얼 -->
	<div class="toparea">		
		<!-- 공통 : 공유하기 버튼  -->
		<button class="com__btn_share" onclick="$('.com__share_wrap').show();">공유하기</button>
		<!-- // -->

		<!-- 공통 : 상단 비쥬얼 -->
		<div class="visual">
			<div class="inner">
				<span class="txt_stit">PC/부품 전용 이벤트</span>
				<h2>도전! 구매왕</h2>
				<span class="txt_sub">기회는 단 한 달! 구매왕에 도전하라! 2020년 12월 14일부터 2021년 1월 13일까지</span>
				
				<div class="gift_box">
					<h3 class="gtit">[PC/부품] 구매왕 TOP 1에게 에누리가 드리는 특별한 선물</h3>

					<div class="gift_inner">
						<span class="polygon"><!--2명--></span>
						<span class="gift_img"><!--지포스 이미지--></span>

						<a href="/short/MdJmj"  onclick="da_ga(2);" class="btn_gift" title="새 창에서 열립니다" target="_blank">제품 리뷰 보기</a>
					</div>
				</div>
				
				<div class="loader-box">
					<div class="visual-loader"></div>
				</div>
			</div>
			
			<script>
				// 상단 타이틀 등장 모션
				$(window).load(function(){
					var $visual = $(".event_wrap .visual");
					$visual.addClass("intro");
					setTimeout(function(){
						$visual.addClass("end");
					},100)
				})
			</script>
		</div>
		<!-- // -->	
	</div>
	<!-- //비쥬얼 -->

	<!-- CONT1 -->
	<div class="section cont01" id="evt1">
		<div class="contents">
            <h3>[앱전용] FLEX하면 지포스 3080 쏜다!</h3>
            <p class="blind">이벤트 기간 동안 APP에서 PC/주변기기/부품을 많이 구매하신 분에게 지포스 RTX 3080을 드립니다!</p>
            
			<div class="gift_box">
                <ul class="gift_list">
                    <li>1등 1명, [PALIT] 지포스 RTX 3080 OC D6X 10GB + [해피머니] 온라인 상품권 3만원권 (e머니 30,000)</li>
                    <li>2등 1명, [PALIT] 지포스 RTX 3080 OC D6X 10GB</li>
                    <li>3등 10명, [해피머니] 온라인 상품권 3만원권 (e머니 30,000)</li>
                    <li>4등 30명, [크리스피도넛] 오리지널 하프더즌 (e머니 7,800)</li>
                </ul>
                <a href="javascript:///" class="btn_join">이벤트 신청하기</a>

                <ul class="gift_noti">
                    <li><em>이벤트 기간:</em> 2020. 12. 14(월) ~ 2021. 1. 13(수)</li>
                    <li><em>당첨자 발표:</em> 2021. 2. 25(목)</li>
                </ul>
            </div>

            <!-- 공통 : 꼭 확인하세요  -->
			<div class="com__evt_notice">
				<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop1"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
			</div>
            <!-- // -->
		</div>
		<div id="slidePop1" class="evt_notice--slide">
			<div class="evt_notice--inner wide"> <!-- .wide - 넓은 케이스 -->
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<dl>								
							<dt>이벤트 대상 및 혜택</dt>
							<dd>
								<ul>
									<li>이벤트 참여 : 이벤트 기간 내 대상 카테고리 상품 구매 후 구매왕 이벤트 응모한 고객 <span class="stress">※ 대상 카테고리 확인</span></li>
									<li>이벤트 기간 : 2020년 12월 14일 ~ 2021년 1월 13일</li>
									<li>구매왕 조건 : 이벤트 기간 동안 대상카테고리에서 구입한 누적 구매액</li>
									<li>이벤트 혜택 : [경품] 참고</li>
									<li>혜택 지급일 : 2021년 2월 25일<br />
										<span class="noti">※ 당첨자 공지 : 에누리 가격비교 APP &gt; 이벤트/기획전탭 &gt; 이벤트혜택 &gt; 하단 [당첨자/공지]</span></li>
									<li>컴퓨터/PC부품 대상 카테고리

										<table class="evt_noti_tb" style="width:100%;">
											<tbody>
												<tr>
													<th colspan="3">컴퓨터 대상 카테고리</th>
												</tr>
												<tr>
													<td>노트북</td>
													<td>데스크탑,미니PC</td>
													<td>일체형PC</td>
												</tr>
												<tr>
													<td>모니터</td>
													<td>복합기,프린터,스캐너</td>
													<td>잉크,토너</td>
												</tr>
												<tr>
													<td>게임기,게임SW</td>
													<td>소프트웨어</td>
													<td>노트북용액세서리</td>
												</tr>
												<tr>
													<td>멀티탭,PC관리용품</td>
													<td>CCTV,감시카메라</td>
													<td>&nbsp;</td>
												</tr>
												
												<tr>
													<th colspan="3">PC부품 대상 카테고리</th>
												</tr>
												<tr>
													<td>CPU</td>
													<td>램(RAM)</td>
													<td>메인보드</td>
												</tr>
												<tr>
													<td>그래픽카드</td>
													<td>PC케이스</td>
													<td>파워서플라이</td>
												</tr>
												<tr>
													<td>SSD,HDD</td>
													<td>외장하드,NAS</td>
													<td>USB메모리,ODD</td>
												</tr>
												<tr>
													<td>마우스,타블렛</td>
													<td>키보드</td>
													<td>스피커,헤드셋</td>
												</tr>
												
												<tr>
													<td>쿨러,튜닝용품</td>
													<td>공유기,네트워크장비</td>
													<td>USB허브,케이블,젠더</td>
												</tr>
												<tr>
													<td>멀티미디어,확장카드</td>
													<td>&nbsp;</td>
													<td>&nbsp;</td>
												</tr>
											</tbody>
										</table>
									</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>경품</dt>
							<dd>
								<ul>
									<li>1등 – [PALIT] 지포스 RTX 3080 OC D6X 10GB + [해피머니] 온라인 상품권 3만원권 (e 30,000점) – 1명 <br />
										<span class="stress">※ 제세공과금 당첨자 부담</span></li>
									<li>2등 – [PALIT] 지포스 RTX 3080 OC D6X 10GB – 1명 <span class="stress">※ 제세공과금 당첨자 부담</span></li>
									<li>3등 – [해피머니] 온라인 상품권 3만원권 (e 30,000점) – 10명</li>
									<li>4등 – [크리스피도넛] 오리지널 하프더즌 (e 7,800점) – 30명</li>
									<li class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)<br />
										<span class="noti gray">※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</span>
									</li>
								</ul>
							</dd>
						</dl>
						<dl>	
							<dt>E머니 구매 적립 기준 및 유의사항</dt>
							<dd>
								<ul>
									<li>적립방법 : 에누리 가격비교 모바일 앱 로그인 &rarr; 적립대상 쇼핑몰 이동 &rarr; <span class="stress">1천원 이상 구매</span> &rarr; 구매확정(배송완료) 시 e머니 적립</li>
									<li>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, Cjmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 에누리 해외직구관, SK스토아, 홈플러스</li>
									<li>구매적립 e머니는 구매일로부터 10 ~ 30일간 취소/환불/교환/반품여부 확인 후 적립 됩니다.</li>
									<li class="stress">구매적립 e머니 유효기간 : 적립일로부터 60일 (유효기간 만료 후 재적립 불가)<br />
										<span class="noti gray">※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.</span>
									</li>
									<li>구매적립 e머니는 최소 10점(구매금액 1천원 이상)부터 적립되며, 1원 단위 e머니는 적립되지 않습니다.</li>
									<li>구매적립 e머니는 구매확정(구매일로부터 최 대 30일) 시점부터 MY 에누리 적립내역 페이지에서 확인 가능합니다.</li>
									<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다.</li>
									<li>적립대상 쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제하는 경우 구매건수는 1건이며 구매금액은 통합된 금액으로 e머니 적립 됩니다.</li>
								</ul>
							</dd>
						</dl>
						<dl>	
							<dt>공통 이벤트 유의사항</dt>
							<dd>
								<ul>
									<li>사정에 따라 경품이 변경될 수 있습니다.</li>
									<li>잘못된 정보 입력으로 인한 경품 수령의 불이익은 책임지지 않습니다.</li>
									<li>부정 참여 시 적립이 취소 및 사이트 사용이 제한될 수 있습니다.</li>
									<li>본 이벤트는 당사 사정에 따라 사전 고지 없이 변경 또는 종료 될 수 있습니다</li>
									<li>아래의 경우에는 구매 확인 및 구매적립이 불가합니다.
										<ul class="sub">
											<li>- 에누리 가격비교 모바일 앱이 아닌 다른 모바일 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 모바일 앱으로 결제만 한 경우</li>
											<li>- 에누리 가격비교 미 로그인 후 구매한 경우</li>
											<li>- 에누리 가격비교 PC 및 모바일 웹에서 구매한 경우 (※ 티몬 및 에누리 해외직구관은 PC 및 모바일 앱/웹 구매 시에도 가능)</li>
										</ul>
									</li>                                            
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
    <!-- //CONT1 -->
    
    <!-- CONT2 -->
	<div class="section cont02" id="evt2">
		<div class="contents">
            <h3>구매왕 랭킹 TOP5</h3>

            <div class="rank_box">
                <p class="standard" id="standardTime"></p>

                <!-- 참여자수 -->
                <div class="count_box">
                    <span class="blind">참여자 수</span>
                    <span class="numb" id="rnkCnt"></span>
                </div>

                <!-- 랭킹 테이블-->
                <div class="rank_table" id="rank_table">
                    <table>
                        <colgroup>
                            <col width="50" />
                            <col width="*" />
                            <col width="115" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th>순위</th>
                                <th>아이디</th>
                                <th>닉네임</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
	<!-- //CONT2 -->

	<!-- CONT3 -->
	<div class="section cont03" id="evt3">
		<div class="contents">
            <h3>에누리 추천 상품은? 인기 상품 한 눈에 보기</h3>

            <!-- 상품 영역 -->
            <div class="goods_wrap">
                <!-- 대메뉴 플로팅 탭 -->
				<div class="floattab">
					<div class="floattab__list">
						<div class="scrollList">
							<ul class="floatmove">						
								<li><a href="#goods1" class="floattab__item floattab__item--01"><em>노트북</em></a></li>
								<li><a href="#goods2" class="floattab__item floattab__item--02"><em>데스크탑</em></a></li>
								<li><a href="#goods3" class="floattab__item floattab__item--03"><em>CPU</em></a></li>
								<li><a href="#goods4" class="floattab__item floattab__item--04"><em>그래픽카드</em></a></li>
								<li><a href="#goods5" class="floattab__item floattab__item--05"><em>모니터</em></a></li>
							</ul>
						</div>
						<!-- <a href="javascript:///" class="btn_tabmove next"><em>탭 이동</em></a> -->
					</div>
				</div>
				<script>
					/*$(window).load(function(){
						var posScr = new Array(),
							$nav = $(".floattab__list"), // scroll tabs
							$scrList = $(".scrollList");
						
						$scrList.on("scroll", function(){
							var st = $scrList.scrollLeft();
							if (st >= $nav.find("li").eq(0).width() * 1 - 30) {
								$(".btn_tabmove").removeClass("next").addClass("prev");
							}else {
								$(".btn_tabmove").removeClass("prev").addClass("next");
							}
						});
					});*/
				</script>
				<!-- /탭 -->

                <!-- 상단탭 상품 컨테이너 -->
                <div class="goods_container">
                    <!--
                        [D] 
                        SLICK : $(".itemlist")
                        하나의 콘텐츠마다 ul 단위로 한 판(상품6개)씩 움직입니다. 	
                        
                        #goods1 ~ 5 영역은 반복됩니다.  ★ #goods1 마크업만 참고하시면 됩니다.
                        ex) 상단탭 상품 컨텐츠(노트북)

                        [[[[[상품 영역]]]]]
                        DEPTH
                        .tabs__list                                         - 5개 탭 목록
                        .goods_container                                    - 5개 탭 컨테이너(대메뉴)
                            .goods_content#goods1 ~ 5                       - 5개 탭 컨텐츠

                                .tab_container                              - 컨테이너
                                    .tab_content                            - 추천상품 컨텐츠
                                        .itemlist                           - 각 상품 목록 (2*2)
                    -->
                    <!-- 상단탭 상품 컨텐츠(노트북) -->
                    <div id="goods1" class="goods_content">
                        <!-- 추천상품 템플릿 -->
                        <div class="tab_container">
                            <!-- 추천상품-->
                            <div class="tab_content">
                                <div class="itemlist">
                                	<ul class="items clearfix"></ul>
                                </div>
                            </div>
                            <!-- //추천상품-->
                        </div>
                        <!-- //추천상품 템플릿 -->
                    </div>
                    <!-- //상단탭 상품 컨텐츠(노트북) -->
                </div>
                <!-- //상단탭 상품 컨테이너 -->
            </div>
            <!-- // 상품 영역-->
        </div>
    </div>
    <!-- //CONT3 -->
	
	<!-- //Contents -->	

	<span class="go_top"><a href="#">TOP</a></span>
</div>

<!-- (신규) 공통 : SNS공유하기 -->
<div class="com__share_wrap dim" style="z-index:10000;display:none">
	<div class="com__layer share_layer">
		<div class="lay_head">공유하기</div>
		<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
		<div class="lay_inner">
			<ul id="eventShr">
				<li id="fbShare" class="share_fb">페이스북 공유하기</li>
				<li class="share_kakao" id="kakao-link-btn" >카카오톡 공유하기</li>				
				<li id="twShare" class="share_tw">트위터 공유하기</li>
				<!-- <li class="share_line">라인 공유하기</li> -->
				<!-- 메일아이콘 클릭시 활성화(.on) -->
				<!-- <li class="share_mail" onclick="$(this).toggleClass('on');$(this).parents('.share_layer').find('.btn_wrap').toggleClass('mail_on');">메일로 공유하기</li> -->
				<!-- <li class="share_story">카카오스토리 공유하기</li> -->
				<!-- <li class="share_band">밴드 공유하기</li> -->
			</ul>
			<!-- 메인보내기 버튼클릭시 .mail_on 추가해 주세요 -->
			<div class="btn_wrap">
				<div class="btn_group">
					<!-- 주소복사하기 -->
					<div class="btn_item">
						<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2020/kingofbuy_evt.jsp?oc=mo</span>
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
<div class="layer_back" id="app_only1" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 서비스</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only1').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();" >설치하기</button></p>
	</div>
</div>

<div class="layer_back" id="app_only2" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only2').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();" >설치하기</button></p>
	</div>
</div>


<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20180831"></script>
<script type="text/javascript">
Kakao.init('5cad223fb57213402d8f90de1aa27301');

var app = getCookie("appYN"); //app인지 여부
var username = "<%=userArea%>"; //개인화영역 이름
var vChkId = "<%=chkId%>";
var vEvent_page = "<%=strUrl%>"; //경로
var vEvent_title = "20년 구매왕 프로모션";
var isFlow = "<%=flow%>" == "ad";
var vOs_type = getOsType();
var state = false;
var tab = "<%=tab%>";

$(".go_top").click(function(){		$('body, html').animate({scrollTop:0}, 500);	});

var shareUrl = "http://" + location.host + "/mobilefirst/event2020/kingofbuy_evt.jsp?oc=mo";
var shareTitle = "<%=strFb_title%> <%=strFb_description%>";

var oc = '<%=oc%>';

/* 데이터 로드 영역 */
var loadUrl = "/mobilefirst/evt/chuseok_201709_ajax.jsp?exh_id=41";

//전체 상품 데이터
var	ajaxData = (function() {
    var json = {};
    $.ajax({
        'async': false,
        'global': false,
        'url': loadUrl,
        'dataType': "json",
        'success': function (data) {
	    	json = data.T;
        }
    });
    return json;
})();

(function (global, $) {
	// 상단 메뉴 스크롤 시, 고정
	var $nav = $('.floattab'),
		$menu = $('.floattab__list li'),
		$contents = $('.scroll'),
		$navheight = $nav.outerHeight(), // 상단 메뉴 높이
		$navtop = Math.ceil($nav.offset().top); // floattab 현재 위치; 

	// menu class 추가 
	$(window).scroll(function () {
		var $scltop = Math.ceil($(window).scrollTop());	// 현재 scroll

		if ($scltop > $navtop) {
			$nav.addClass("is-fixed");
			$(".visual").css("margin-bottom", $navheight);
		} else {
			$nav.removeClass("is-fixed");
			$menu.children("a").removeClass('is-on');
			$(".visual").css("margin-bottom", 0);
		}

		$.each($contents, function (idx, item) {
			var $target = $contents.eq(idx),
				i = $target.index(),
				targetTop = Math.ceil($target.offset().top - $navheight);

			if (targetTop <= $scltop) {
				$menu.children("a").removeClass('is-on');
				$menu.eq(idx).children("a").addClass('is-on');
			}
			if (!($navheight <= $scltop)) {
				$menu.children("a").removeClass('is-on');
			}
		})
	});

	//스크롤
	var nav = $('.myarea'); 
	$(window).scroll(function () {
		if ($(this).scrollTop() > $(".toparea").height()) {
			nav.addClass("f-nav");
		} else {
			nav.removeClass("f-nav");
		}
	});
}(window, window.jQuery));

//공통 : 유의사항 레이어 열기/닫기
$(function(){
	var el = {
		btnSlide: $(".btn__evt_notice"), // 열기 버튼
		btnSlideClose : $(".btn__evt_confirm") // 닫기 버튼
	}
	el.btnSlide.click(function(){ // 슬라이드 유의사항 열기
		$(this).toggleClass('on');
		$("#"+$(this).attr("data-laypop-id")).slideToggle();
	})
	el.btnSlideClose.click(function(){ // 슬라이드 유의사항 닫기
		var thisClosest = $(this).closest('.evt_notice--slide')
		el.btnSlide.toggleClass('on');
		$(thisClosest).slideToggle();
		$('html,body').stop(0).animate({scrollTop:$(thisClosest).siblings(".com__evt_notice").offset().top - 50});
	})
})

// 공통 :  하단 컨텐츠로 바로 진입시 포지션 보정을 위한 스크립트 처리
$(function(){
	if(window.location.hash) {
		var $hash = $("#"+window.location.hash.substring(1));
		var navH = $(".navtab").outerHeight();
		if ( $hash.length ){
			$("html,body").stop(true,false).animate({"scrollTop": $hash.offset().top - navH},"slow");
		}
	}
})

/*레이어*/
function onoff(id){
	var mid = $("#"+id);
	if(mid.css("display") !== "none"){
		mid.css("display","none");
	}else{
		mid.css("display","");
	}
}

$(document).ready(function() {
	ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_PV");
	
	if(oc!=""){
		$('.lay_only_mw').show();
	}
	$("#my_emoney").click(function(){	
		window.location.href = "https://m.enuri.com/my/my_emoney_m.jsp?freetoken=emoney";	//e머니 적립내역
	});
	
	
	$(".btn_login").click(function(){
		location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
		return false;
	})
	
	$(".btn_join").click(function(){
		da_ga(3);
		if(app=="Y"){
			btn_join();
		}else{
			$('.lay_only_mw').show();
			return false;			
		}
	});
	
	$("#eventShr > li").click(function(){
		var sel = $(this).attr("id");
		
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
	
	if(islogin()){
		getPoint();
	}
	
	//구매왕 랭킹
	getRnk();
	
	tabLoading();
	
	$("body").on('click', '.items > li', function(event) {
		var modelno = $(this).attr("data-mn");
		var price = $(this).attr("data-price");
		
		var line = 0;
		
		$(".floatmove > li").each(function(i,v){
			var cls = $(this).attr("class");
			if(cls == "is-on"){
				line = i;
			}
		});
		
		if(line == 0)        da_ga(4);       
		else if(line == 1)   da_ga(5);
		else if(line == 2)	 da_ga(6);
		else if(line == 3)   da_ga(7);
		else if(line == 4)   da_ga(8);
		
		itemClick(modelno,price);
		return false;
	});
});

function getPoint(){
	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_point.jsp",
		async: false,
		dataType:"JSON",
		success: function(json){
			remain = json.POINT_REMAIN;	//적립금
			$("#my_emoney").html(CommaFormattedN(remain) +""+json.POINT_UNIT);
			
		}
	});
}

function itemClick(modelNo, minprice) {
	
	da_ga(9);
	
	if(minprice > 0){
		window.open('/mobilefirst/detail.jsp?modelno=' + modelNo +'&freetoken=vip');
	}else{
		alert("품절된 상품 입니다.");
	}
}

function arrayShuffle(oldArray) {
    var newArray = oldArray.slice();
    var len = newArray.length;
    var i = len;
    while (i--) {
        var p = parseInt(Math.random()*len);
        var t = newArray[i];
        newArray[i] = newArray[p];
        newArray[p] = t;
    }
    return newArray;
};

function arrayShuffle2(oldArray) {
    var newArray = oldArray;
    var len = newArray.length;
    var i = len;
    while (i--) {
        var p = parseInt(Math.random()*len);
        var t = newArray[i];
        newArray[i] = newArray[p];
        newArray[p] = t;
    }
    return newArray;
};
var nowTab = 1;
function tabLoading(){
	//가격대별 탭 컨텐츠
	$(".goods_content .tab_content").hide(); 
	$("ul.floatmove li").removeClass("is-on"); 
	//첫 로딩 시, 랜덤 노출
  var rndNum = Math.floor(Math.random() * 4);
  nowTab = rndNum+1;
  
  $(".goods_content").attr("id","goods"+nowTab);
  
  var object = ajaxData[rndNum]["GOODS"];
	loadGoodsList(object);
	
	$("ul.floatmove li").eq(rndNum).addClass("is-on").show();
  
	$(".goods_content .tab_content:first").show();
	//$("ul.tabs__list li").eq(0).trigger("click");
	
	$("ul.floatmove li").click(function() {
		$("ul.floatmove li").removeClass("is-on"); 
		$(this).addClass("is-on");
		//$(".pro_itemlist .tab_content").hide(); 
		var activeTab = $(this).find("a").attr("href");
		//$(activeTab).fadeIn();
		//proSlide.slick("setPosition");
		$(".goods_content").attr("id","goods"+activeTab.substring(7, 8));
		
		//가격대별 플리킹
		proSlide.slick("destroy");
		if(activeTab == "#goods1"){
			var object = ajaxData[0]["GOODS"];
			loadGoodsList(object);
			
			proSlide = $('.itemlist').slick({
				dots:false,
				slidesToScroll: 1
			});
			da_ga(4);
			nowTab = 1;
		}else if(activeTab == "#goods2"){
			var object = ajaxData[1]["GOODS"];
			loadGoodsList(object);
			proSlide = $('.itemlist').slick({
				dots:false,
				slidesToScroll: 1
			});
			da_ga(5);
			nowTab = 2;
		}else if(activeTab == "#goods3"){
			var object = ajaxData[2]["GOODS"];
			loadGoodsList(object);
			
			proSlide = $('.itemlist').slick({
				dots:false,
				slidesToScroll: 1
			});
			da_ga(6);
			nowTab = 3;
		}else if(activeTab == "#goods4"){
			var object = ajaxData[3]["GOODS"];
			loadGoodsList(object);
			proSlide = $('.itemlist').slick({
				dots:false,
				slidesToScroll: 1
			});
			da_ga(7);
			nowTab = 4;
		}else if(activeTab == "#goods5"){
			var object = ajaxData[4]["GOODS"];
			loadGoodsList(object);
			proSlide = $('.itemlist').slick({
				dots:false,
				slidesToScroll: 1
			});
			da_ga(8);
			nowTab = 5;
		}
		return false;
	});
	
	//플리킹
	var proSlide = $('.tab_content .itemlist').slick({
		dots:false,
		slidesToScroll: 1
	});
	
}
function loadGoodsList(obj){
	var goodsList = arrayShuffle2(obj);
	var html = "";
	
	if(goodsList.length >0){
		
		for(var i=0;i<goodsList.length;i++){
			if(i<12){
				if(i%4==0) html += "<ul class=\"items clearfix\">";
					
					var goodsData = goodsList[i];
					var modelno = goodsData["MODELNO"];
					var goods_img = goodsData["GOODS_IMG"];
					var goods_title1 = goodsData["TITLE1"];
					var goods_title2 = goodsData["TITLE2"];
					var goods_minprice = goodsData["MINPRICE"]==null?0:goodsData["MINPRICE"];
					
					html+= "<li class=\"item\" data-mn='"+goodsData["MODELNO"]+"' , data-price='"+goodsData["MINPRICE"]+"' >";
					html+= "	<a href=\"javascript:;\" title=\"새 탭에서 열립니다.\">";
					html+= "		<span class=\"thumb\">";
					html+= "			<img src=\""+goodsData["GOODS_IMG"]+"\" alt=\"\" />";
					if(goodsData["MINPRICE"]==0){
					html+= "			<span class=\"soldout\">SOLD OUT</span>";	
					}
					html+= "		</span>";
					html+= "		<span class=\"pro_info\">";
					html+= "			<span class=\"pro_name\">"+goods_title1+"<br />"+goods_title2+"</span>";
					html+= "			<span class=\"price\"><em class=\"minp\">최저가 </em><em>"+numberWithCommas(goods_minprice)+"</em><span class=\"pro_unit\"> 원</span></span>";
					html+= "		</span>";
					html+= "	</a>";
					html+= "</li>";	
					
				if(i%4==3) html += "</ul>";
			}
		}
		
		$(".itemlist").html(html);
	}
}

function numberWithCommas(x) {   return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");		}

function CommaFormattedN(amount) {
  var delimiter = ","; 
  var i = parseInt(amount);

  if(isNaN(i)) { return ''; }
  
  var minus = '';
  
  if (i < 0) { minus = '-'; }
  i = Math.abs(i);
  
  var n = new String(i);
  var a = [];

  while(n.length > 3){
      var nn = n.substr(n.length-3);
      a.unshift(nn);
      n = n.substr(0,n.length-3);
  }
  if (n.length > 0) { a.unshift(n); }
  n = a.join(delimiter);
  amount = minus + (n+ "");
  return amount;
}

function view_moapp(){
	var chrome25;
	var kitkatWebview;
	var uagentLow = navigator.userAgent.toLocaleLowerCase();
	var openAt = new Date;
	var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2020%2Fkingofbuy_evt.jsp%3Ffreetoken%3Devent";
	
	if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
		goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2020/kingofbuy_evt.jsp?freetoken=event";
		chrome25 = uagentLow.search("chrome") > -1 && navigator.appVersion.match(/Chrome\/\d+.\d+/)[0].split("/")[1] > 25;
		kitkatWebview = uagentLow.indexOf("naver") != -1 || uagentLow.indexOf("daum") != -1;
		if(kitkatWebview){
			setTimeout( function() {
				if (new Date - openAt < 1100) {
					if (uagentLow.search("android") > -1) {
						location.href = "market://details?id=com.enuri.android";
					}
				}
			}, 1000);
		}else{
			setTimeout( function() {
				if (new Date - openAt < 1500) {
					if (uagentLow.search("android") > -1) {
						location.href = "market://details?id=com.enuri.android";
					}
				}
			}, 1000);
		}
		if(uagentLow.search("android") > -1){
			chrome25 = uagentLow.search("chrome") > -1 && navigator.appVersion.match(/Chrome\/\d+.\d+/)[0].split("/")[1] > 25;
			kitkatWebview = uagentLow.indexOf("naver") != -1 || uagentLow.indexOf("daum") != -1;
			if (chrome25 && !kitkatWebview){
				location.href = goApp;
			} else{
				location.href = goApp;
			}
		}
	}else{
		setTimeout( function() {
			window.location.replace("https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8");
		}, 2000);
		location.href = goApp;
	}
}

function btn_join() {
	
	if(!islogin()){
		
		alert("로그인 후 신청 가능합니다!");
		location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
		return false;
		
	}else{
		if(!getSnsCheck()){
		
			if (confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?") == true){    
				location.href="<%=ConfigManager.ENURI_COM_SSL%>/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
				return false;
			}else{
				return false;
			}
			
		}else{
			
			$.ajax({
				type: "GET",
				url: "/mobilefirst/evt/ajax/kingofbuy_setlist.jsp?proc=1&osType="+getOsType(),
				dataType: "JSON",
				async : false,
				success: function(json){
					
					if(json.result == 1){
						alert("정상 참여 되었습니다.");
					}else if(json.result == 2601){
						alert("이미 참여 하셨습니다.\n구매왕에 도전하세요!");
					}else if(json.result == -99){
						alert("대상 카테고리 상품 구매 후 응모 가능합니다.");
					}else if(json.result == 100){
						alert("이벤트가 종료 되었습니다.");
					}else if(json.result == -100){
						alert("임직원은 참여 불가합니다.");
					}

				} 
				/* ,error: function (xhr, ajaxOptions, thrownError) {
					console.log(xhr.status);
					console.log(thrownError);
				} */
			});
			
		}
	}
}

function getRnk(){
	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/evt/ajax/kingofbuy_setlist.jsp?proc=2",
		async: false,
		dataType:"JSON",
		success: function(json){
			var joincnt = json["joincnt"];	//참여자
			var jsonObj = json["list"];
			$("#rnkCnt").html(CommaFormattedN(joincnt) +" 명");
			
			var date = new Date();
		    var day = ("00" + date.getDate()).slice(-2);
		    var hours = ("00" + date.getHours()).slice(-2);
		    var minutes = ("00" +date.getMinutes()).slice(-2);
			$("#standardTime").html(day+"일 "+hours+"시 "+minutes+"분 기준");
			var html = "";
			var startDate = "";
			if(jsonObj) {
				$.each(jsonObj, function(Index, listData) {
					var rnk = listData["rnk"];
					var enr_usr_id = listData["enr_usr_id"];
					var view_nm = listData["view_nm"];
					var ins_dtm = listData["ins_dtm"];
					var upd_dtm = listData["upd_dtm"];
					
					if(Index==0) startDate = upd_dtm.substring(0,10);
					
            		html += "<tr>";
            		html += "	<td>"+rnk+"</td>";
            		html += "	<td>"+enr_usr_id+"</td>";
            		html += "	<td>"+view_nm+"</td>";
            		html += "</tr>";
            	});
				
				if(html!=""){
					var startDateArr = startDate.split('-');
			         
			        var endDate = '2020-12-14';
			        var endDateArr = endDate.split('-');
			                 
			        var startDateCompare = new Date(startDateArr[0], startDateArr[1], startDateArr[2]);
			        var endDateCompare = new Date(endDateArr[0], endDateArr[1], endDateArr[2]);
			        
			        if(startDateCompare.getTime() >= endDateCompare.getTime()) {
						$("#rank_table tbody").html(html);
			        }else{
			        	$("#evt2").hide();
			        }
				}else{
					$("#evt2").hide();
				}
			}
			
		}
	});
}

function da_ga(num){
	if(num == 2){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_이벤트_제품리뷰보기");
	}else if(num == 3){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_이벤트_응모하기");
	}else if(num == 4){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_쇼핑가이드_노트북");
	}else if(num == 5){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_쇼핑가이드_데스크탑");
	}else if(num == 6){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_쇼핑가이드_CPU");
	}else if(num == 7){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_쇼핑가이드_그래픽카드");
	}else if(num == 8){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_쇼핑가이드_모니터");
	}else if(num == 9){
		ga('send', 'event', 'mf_event', vEvent_title, vEvent_title+"_쇼핑가이드_상품");
	}
}

//sns 인증
function getSnsCheck() {
	var snsCertify;
	$.ajax({
		type: "GET",
		url: "/member/ajax/getMemberCetify.jsp",
		dataType: "JSON",
		async : false,
		success: function(json){
			var snsdcd = json["snsdcd"]; //sns회원유무 K:카카오, N:네이버
			snsCertify = json["certify"];
			if(snsdcd==""){
				snsCertify = true;
			}
		}
		/* ,error: function (xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		} */
	});
	return snsCertify;
}
//닫기버튼
$('.win_close').click(function(){
	if(getCookie("appYN") == 'Y'){
		window.location.href = "close://";
	}else{
		window.location.replace("/m/index.jsp");
	}
});

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
CmdShare();
function CmdShare(){
	Kakao.Link.createDefaultButton({
	  container: '#kakao-link-btn',
      objectType: 'feed',
      content: {
        title: '<%=strFb_title%>',
        description: "지포스 RTX 3080 증정 이벤트 구매왕 도전하면 다양한 경품이 쏟아진다!",
        imageUrl: "<%=strFb_img%>",
			link : {
				webUrl : shareUrl,
				mobileWebUrl : shareUrl
			}
		},
		buttons : [ {
			title : '에누리 가격비교',
			link : {
			mobileWebUrl : shareUrl,
			webUrl : shareUrl
			}
		} ]
	});
}
</script>

</body>
<script language="JavaScript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</html>
