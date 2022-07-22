<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%@ include file="/event/common/include/event_common.jsp" %>
<%
String strServerNm = request.getServerName();
if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
       || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
       || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
       || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
}else{
	response.sendRedirect("/event2021/via.jsp"); //PC경로
    return;
}

String strUrl = request.getRequestURI();
String oc = ChkNull.chkStr(request.getParameter("oc"));
String pd = ChkNull.chkStr(request.getParameter("pd"));
String tab = ChkNull.chkStr(request.getParameter("tab"));
String protab = ChkNull.chkStr(request.getParameter("protab"));
String strApp = ChkNull.chkStr(request.getParameter("app"),"");

Cookie[] carr = request.getCookies();
if(carr != null){
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("appYN")){
	      strApp = carr[i].getValue();
	      break;
	    }
	}
}

int KB_NO = 2173044;

%>
<!doctype html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<meta property="og:title" content="[에누리 가격비교] 진짜 최저가, 에누리에 답이 있다">
	<meta property="og:description" content="에누리로 최저가 찾고 선물 받자~">
	<meta property="og:image" content="http://img.enuri.info/images/mobilefirst/etc/viasns.jpg">
	<meta name="format-detection" content="telephone=no" />

	<link rel="shortcut icon" href="http://img.enuri.info/2014/layout/favicon_enuri.ico">
	<title>에누리(가격비교) eNuri.com</title>
	<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
	<!-- 프로모션 공통 CSS (Mobile) -->
	<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
	<!-- 프로모션별 커스텀 CSS  -->
	<link rel="stylesheet" href="/css/event/y2021_rev/enuri_via_m.css?modify=211112" type="text/css">
	<!-- 프로모션 공통 JS -->
	<script type="text/javascript" src="/common/js/lib/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="/js/swiper.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>
	<script type="text/javascript" src="/event2016/js/event_common.js?v=20210826"></script>
	<script type="text/javascript" src="/common/js/lib/jquery-ui.js"></script>
	<script type="text/javascript" src="/common/js/lib/jquery.fileupload.js"></script>
	<script type="text/javascript" src="/common/js/paging_via.js"></script>
	<script>
	var app = "<%=strApp%>"; 
	var pd = "<%=pd%>";
	var userId = "<%=USERID%>";
	var username = "<%=USERINFO%>";
	var PAGESIZE = 3; 
	var BLOCKSIZE = 5;

	</script>  
</head>
<body>
<div class="lay_only_mw" <%if(!strApp.equals("Y") && oc.equals("sns")){%><%}else{%>style="display:none;"<%} %>>>
	<div class="lay_inner">
		<div class="lay_head">
			더 다양한 <em>이벤트 혜택</em>을 누리고 싶다면?
		</div>
		<!-- 버튼 : 에누리앱으로 보기 -->
		<button class="btn_go_app" onclick="ga_log(9);view_moapp();">에누리앱으로 보기</button>
		<!-- 버튼 : 모바일웹으로 보기 -->
		<a href="javascript:void(0);" class="btn_keep_mw" onclick="ga_log(10);$('.lay_only_mw').fadeOut(100);">괜찮아요. 모바일 웹으로 볼래요</a>
	</div>
</div>

<div class="wrap">
	<div class="event_wrap">
		<%@include file="/eventPlanZone/jsp/eventMovingTapMobile.jsp" %>
		<!-- visual -->
		<div class="section visual">
			<div class="inner">
				<div class="visual_obj"><!-- 훈장님 --></div>

				<!-- 공통 : 공유하기 버튼  -->
				<button class="com__btn_share btn_white" onclick="$('.com__share_wrap').show();">공유하기</button>
				<!-- // -->
				<div class="react_text_area">
					<span class="txt_01">에누리로 최저가 찾고 선물 받자!</span>
					<span class="txt_02">진짜<span>최저가</span> 찾기</span>
					<span class="txt_03">에누리에 가격비교 답이 있다</span>
				</div>
			</div>
			<script>
				$(window).load(function(){
					var $visual = $(".event_wrap .visual");
					setTimeout(function(){
						$visual.addClass("start");
					},1000)
				})
			</script>
		</div>
		<!-- //visual -->

         <!-- 공통 : 탭 -->	
		<div class="section navtab">
			<div class="navtab_inner">
				<ul class="navtab_list">
                    <!-- 선택 : is-on -->
                    <li onclick="ga_log(2);"><a href="#evt1" class="navtab_item--01">평균 8% 저렴, 에누리효과</a></li>
                    <li onclick="ga_log(3);"><a href="#evt2" class="navtab_item--02">에누리 혜택가 찾고 경품 팡팡!</a></li>
				</ul>
			</div>
		</div>
		<!-- //탭 -->

		<!---------------------------------- 이벤트 1 ---------------------------------->
		<div class="section scroll" id="evt1">
			<div class="inner">			
				<div class="subtit">
					같은 쇼핑몰, 같은 상품도 에누리를 통하면 더욱 싸진다.
					<p class="tx">평균 <em>8%</em> 할인효과!</p>
				</div>
				
				<div class="evt_via_wrap">
					<div class="evt_via_slide swiper-container">
						<div class="swiper-wrapper">
							<div class="swiper-slide">
								<img src="//img.enuri.info/images/event/2021/enuri_via/m/m_evtvia_step1.png" alt="APPLE 2020 맥북에어 MGN63KH/A(8GB SSD 256GB)-TZ / 에누리 경유 시 175,770원 저렴, 직접방문 대비 14% 할인효과">
							</div>
							<div class="swiper-slide">
								<img src="//img.enuri.info/images/event/2021/enuri_via/m/m_evtvia_step2.png" alt="구찌 GG마몬트 스몰 마틀라세 크로스백 447632-DT D1T-1000 / 에누리 경유 시 103,920원 저렴, 직접방문 대비 13% 할인효과">
							</div>
							<div class="swiper-slide">
								<img src="//img.enuri.info/images/event/2021/enuri_via/m/m_evtvia_step3.png" alt="42LF640R 엘지 42인치 클래식 LED TV / 에누리 경유 시 50,060원 저렴, 직접방문 대비 6% 할인효과">
							</div>
						</div>
						<div class="swiper-button-prev btn_prev"></div>
						<div class="swiper-button-next btn_next"></div>
					</div>
					<div class="swiper-pagination"></div>
				</div>
				<script>
					$(function(){
						var viaSwiper = new Swiper('.evt_via_slide',{
							prevButton : '.evt_via_wrap .swiper-button-prev',
							nextButton : '.evt_via_wrap .swiper-button-next',
							pagination : '.evt_via_wrap .swiper-pagination',
							speed : 1000,
							loop : true,
							paginationClickable : true
						})
					})
				</script>	
            </div>

			<div class="avrprice">
				<div class="avrprice_inner"  onclick="ga_log(4);">

					<img src="//img.enuri.info/images/event/2021/enuri_via/m/m_cate_avrprice.png" alt="카테고리별 평균 할인효과">

					<a class="a1" target="_blank" href="http://m.enuri.com/m/list.jsp?cate=0201" title="TV, 평균 8% 할인"></a>
					<a class="a2" target="_blank" href="http://m.enuri.com/m/list.jsp?cate=0242" title="카메라, 평균 7% 할인"></a>
					<a class="a3" target="_blank" href="http://m.enuri.com/m/list.jsp?cate=0401" title="데스크탑, 평균 7% 할인"></a>
					<a class="a4" target="_blank" href="http://m.enuri.com/m/list.jsp?cate=0404" title="노트북, 평균 5% 할인"></a>
					<a class="a5" target="_blank" href="http://m.enuri.com/m/list.jsp?cate=0602" title="냉장고, 평균 10% 할인"></a>
					<a class="a6" target="_blank" href="http://m.enuri.com/m/list.jsp?cate=2507" title="명품패션, 평균 6% 할인"></a>
					<a class="a7" target="_blank" href="http://m.enuri.com/m/list.jsp?cate=1501" title="홍삼건강식품, 평균 14% 할인"></a>
					<a class="a8" target="_blank" href="http://m.enuri.com/m/list.jsp?cate=180301" title="복사용지, 평균 9% 할인"></a>
					<a class="a9" target="_blank" href="http://m.enuri.com/m/list.jsp?cate=2401" title="에어컨, 평균 8% 할인"></a>
					<a class="a10" target="_blank" href="http://m.enuri.com/m/list.jsp?cate=240601" title="공기청정기, 평균 10% 할인"></a>
				</div>
			</div>
		</div>
		<!---------------------------------- //이벤트 1 ---------------------------------->

		<!---------------------------------- 이벤트 2 ---------------------------------->
		<div class="section scroll" id="evt2">
			<div class="inner">
				<div class="tit">EVENT</div>
				<div class="subtit">
					쇼핑몰을 직접 방문했을 때보다<br>에누리 경유 가격이 더 저렴한 제품을 찾아주세요.
					<p class="tx"><em>총 250명</em>에게 푸짐한 경품팡팡!</p>
				</div>

				<div class="img_step">
					<img src="//img.enuri.info/images/event/2021/enuri_via/m/m_evtvia_info.png" alt="">
                    <div class="ir-txt">
                        <p>최저가 이벤트</p>
                        <p>진짜! 최저가 찾고 선물 받자 에누리 통하면 진짜 싸진다!</p>
                        <dl>
							<dt>참여방법</dt>
							<dd>참여기간 : 2021. 11. 29 ~ 12. 31</dd>
							<dd>당첨발표 : 2022. 1. 10
								<ol>
									<li>STEP 1. 에누리에서 상품을 검색해 최저가격 쇼핑몰로 이동해 상품 할인가를 캡쳐한다.</li>
									<li>STEP 2. 같은 상품을 동일한 쇼핑몰 직접방문(접속)하여  동일한 상품 가격차이를 확인하고 캡쳐한다.</li>
									<li>STEP 3. 두 상품의 가격 차이가 잘 보이도록  캡쳐한 이미지를 첨부하여 참여 댓글을 작성한다.</li>
								</ol>
							</dd>
						</dl>
                    </div>
				</div>
			</div>
		</div>
		<!---------------------------------- //이벤트 2 ---------------------------------->

		<div class="section welcome_review">
			<div class="inner">
				<div class="write_review">
					<!-- 로그인 하지 않았을때 노출 -->
					<!-- <a href="#" class="btn__login" onclick="alert('로그인 후 의견을 남길 수 있습니다.\n로그인 하시겠습니까?');return false;">로그인</a> -->
					<!-- // -->
					<h2 class="tit">댓글쓰기</h2>									
					
					<div class="writing">
						<div class="txt_area">			
							<!-- 로그인 전 -->			
							<%
								String strPHtext = "의견을 남기시려면 로그인이 필요합니다.";
								if(!USERID.equals("")){
									strPHtext = "타인을 배려하는 댓글 부탁 드립니다.&#13;&#10;상처를 줄 수 있는 댓글이나, 욕설 및 인격 모독성 내용을 작성할 경우 사전고지 없이 제재를 받을 수 있습니다.";
								}
							%>					
							<textarea rows="4" cols="50" id="replyContents" name="" maxlength="1000" placeholder="<%=strPHtext%>"></textarea>
							<p class="curr"><span id="word_num">0</span>/1,000</p>
						</div>
						<div class="write_tools"  onclick="ga_log(5);">                                             
							<span class="loader-img"></span>
							<div class="img_area">
								<input type="checkbox" class="inp_checkbox" style="display:none">
								<button type="button" class="btn_secret" id="secretReply" value="N"><i class="icon_secret">비밀 댓글</i></button>
	
								<form id="form_img" method="post" enctype="multipart/form-data" style="display: none;" onsubmit="return false;">
									<input type="file" class="inp_load_img" id="file_img_url" name="file_img_url" accept="image/*">
								</form>
								<button class="btn_load_img" onclick="addReplyImg(event);"><i class="icon_load_img">이미지추가</i></button>

								<!-- 이미지 정보 표시 영역 -->
								<!-- 로딩중일때는 .loading 붙여주세요. -->
								<span class="box_info_img" style="display: none;">
									<span class="txt_info" style="display: none;">
										<span class="reply_img_url"></span>
										<input type="hidden" class="reply_img_url_path" />
										<span class="btn__delete" onclick="removeReplyImg();">삭제</span>
									</span>
								</span>
							</div>
							<a class="btn_register" href="javascript:;" onclick="setReply($(this));">등록</a>
						</div>										
					</div>
					<div class="write_review_noti">※ 자세한 내용은 쇼핑지식 자유게시판 > [최저가 이벤트] 를 확인하세요!</div>
				</div>

				<div class="review_area">
					<ul id="review_area">
					</ul>

					<div class="review_paging" id="paginate">
						<ul>
						</ul> 
					</div>
				</div>
	
				
				<script>
					// 퍼블리싱 테스트용 입니다.
					/*$(function(){
						$('.btn_secret').on('click', function(){
							$(this).toggleClass('checked');
							$(this).prev('.inp_checkbox').click();
						});
						$('.btn_load_img').on('click', function(){
							$(this).prev('.inp_load_img').click();
						});
					})*/
				</script>
			</div>
		</div>

		<!-- 버튼 : 꼭 확인하세요 -->
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop1"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop1" class="evt_notice--slide">
			<div class="evt_notice--inner"> <!-- .wide - 넓은 케이스 -->
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<h1 class="htit">이벤트 대상 및 혜택</h1>
						<ul>
							<li>이벤트 참여 혜택
								<ul class="sub">
									<li>- 해피머니 온라인상품권 3만원 (E머니 30,000점) – 10명</li>
									<li>- 서가앤쿡 파스타 한상 (E머니 29,800점) – 3명</li>
									<li>- KFC 핫크리스피치킨8pcs (E머니 18,000점) – 10명</li>
									<li>- 스마일캐시 1만원권 (E머니 10,000점) – 10명</li>
									<li>- 스타벅스 아메리카노 (E머니 4,100점) – 30명</li>
									<li>- 맥도날드 상하이치킨랩 (E머니 2,200점) – 80명</li>
									<li>- CU 바나나우유 (E머니 1,400점) – 107명</li>
								</ul>
							</li>
							<li>이벤트 기간 : 2021년 11월 29일 ~ 2021년 12월 31일</li>
							<li>혜택 지급일 : 2022년 1월 10일</li>
							<li class="stress">e머니 유효기간 : 적립일로부터 15일 (유효기간 만료 후 재적립 불가)</li>
							<li>참여하신 이벤트 댓글은 마케팅 용도로 활용될 수 있습니다.</li>
							<li>캡쳐하신 이미지 상품이 중복될 경우 먼저 올라온 댓글만 인정됩니다.</li>
							<li>가격 비교 캡쳐 이미지 없이 올린 경우 추첨 대상에서 제외될 수 있습니다.</li>
							<li>적립된 e머니는 1,000여가지 인기 e쿠폰으로 교환 가능합니다.</li>
							<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
							<li>부정 참여 시 적립 취소 및 사이트 사용이 제한될 수 있습니다.</li>
							<li>이벤트와 관련 없는 댓글 및 이미지 업로드 시 임의로 삭제될 수 있습니다.</li>
						</ul>
					</div>
				</div>
				<div class="evt_notice--foot">						
					<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 유의사항 닫기 -->
				</div>
			</div>
		</div>
		<!-- // -->
			<script>
				// 유의사항 열기/닫기
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
						$(thisClosest).slideToggle();
						$('html,body').stop(0).animate({scrollTop:$(thisClosest).siblings(".com__evt_notice").offset().top - 50});
					})
				})
			</script>
		</div>
		<!---------------------------------- //이벤트 2 ---------------------------------->

        <!-- 배너 -->
        <div class="bnr_box" onclick="ga_log(7);">
            <a href="/knowcom/detail.jsp?kbno=<%=KB_NO%>" target="_blank" title="새 창에서 열립니다."><img src="//img.enuri.info/images/event/2021/enuri_via/m/m_bnr_img.png" alt="추가 적립금 받으세요. 컴백! 구매하면 2,000점 100% 적립"></a>
        </div>
        <!-- //배너 -->	


		<!-- 공통 : SNS공유하기 -->
		<div class="com__share_wrap dim" style="z-index:10000;display:none">
			<div class="com__layer share_layer">
				<div class="lay_head">공유하기</div>
				<a href="#close" class="lay_close" onclick="$(this).closest('.dim').fadeOut(200);return false;">닫기</a>
				<div class="lay_inner">
					<ul>
						<li class="share_fb">페이스북 공유하기</li>
						<li class="share_kakao"  id="kakao-share-btn">카카오톡 공유하기</li>
						<li class="share_tw">트위터 공유하기</li>
					</ul>
					<!-- 메인보내기 버튼클릭시 .mail_on 추가해 주세요 -->
					<div class="btn_wrap">
						<div class="btn_group">
							<!-- 주소복사하기 -->
							<div class="btn_item">
								<span id="txtURL" class="txt__share_url">http://m.enuri.com/mobilefirst/event2021/via.jsp</span>
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
		<!-- // -->
	</div>
	<!-- // 프로모션 -->

	
	<div class="layerwrap">
		<!-- 모바일웹 공통 : 모바일 앱 전용 이벤트  -->
		<div class="layer_back" id="app_only" style="display:none;">
			<div class="appLayer">
				<h4>모바일 앱 전용 이벤트</h4>
				<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
				<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
				<p class="btn_close"><button type="button">설치하기</button></p>
			</div>
		</div>
		<!-- // 딤레이어 : 모바일 앱 전용 이벤트 -->
	</div>
	<!--<a href="#top" class="btn_top"><i>TOP</i></a>-->
	<script type="text/javascript" src="/mobilefirst/evt/js/event_season.js?v=20190611"></script>
	<script type="text/javascript" src="/mobilefirst/event/js/exhibition_m.js"></script>
	<script> 
		var share_url = "http://m.enuri.com/mobilefirst/event2021/via.jsp?oc=sns";
		var share_img = "http://img.enuri.info/images/mobilefirst/etc/viasns.jpg";
		var share_title = "[에누리 가격비교] 진짜 최저가, 에누리에 답이 있다";
		var share_description = "에누리로 최저가 찾고 선물 받자~";    
		var kb_parent_no = <%=KB_NO%>;
		var curReplypage = 1;
		var vEvent_page = "<%=strUrl%>"; //경로
		var now = new Date();
	   	var year=now.getFullYear().toString(), month=now.getMonth()>10?(now.getMonth()+1).toString():"0"+(now.getMonth()+1).toString(), day=now.getDate()>10?now.getDate().toString():"0"+now.getDate().toString();
	   	var monthPath = year + month + day;
	   	var $replyCurTarget;
	   	
		var vEvent_title = "21년 에누리구매경유유도 프로모션";
		var gaLabel = [  vEvent_title+"_PV"
				,vEvent_title+"_상단탭_에누리 가격비교"
				,vEvent_title+"_상단탭_이벤트"
				,vEvent_title+"_카테고리별 할인효과"
				,vEvent_title+"_이벤트 댓글참여"
				,vEvent_title+"_댓글 이동" 
				,vEvent_title+"_브릿지 배너" 
				,"에누리구매경유유도_공유하기_앱설치 팝업_PV" 
				,"에누리구매경유유도_공유하기_앱설치 팝업_APP연결" 
				,"에누리구매경유유도_공유하기_앱설치 팝업_닫기" 
		];
		 
		$(document).ready(function(){

			getNewReplyList(1);
			//공유하기
			$(".share_kakao").on('click', function(){
				shareSns('kakao');
			});
			$(".share_fb").on('click', function(){
				shareSns('face');
			});
			$(".share_tw").on('click', function(){
				shareSns('twitter');
			});

			// 비밀댓글
			$(".btn_secret").click(function(){
				$(this).toggleClass("checked");
				if($(this).hasClass("checked")){
					$(this).val('Y');
				}else{
					$(this).val('N');
				}
			});

			// 댓글 글자 수
			$('#replyContents').on("propertychange change keyup paste input",function(e){
				var content = $(this).val().length;

				$('.write_review #word_num').html(content);

				if(content > 1000) {
		        	alert("1000자까지 입력할 수 있습니다.");
					$('#replyContents').val(txt.substring(0, 1000));
					$('.write_review #word_num').html("1,000");
		        }
			});
			 
            $("#file_img_url").fileupload({
			    url : "/knowcom/include/fileUpload.jsp?sPageType=reply/"+monthPath,
			    dataType: 'json',
			    add: function(e, data){
			    	var uploadFile = data.files[0];
			        if (!(/png|jpe?g|gif/i).test(uploadFile.name)) {
			            alert('해당 이미지 파일은 업로드 할 수 없습니다.\n(JPG, GIF, PNG, BMP 가능)');
			            return;
			        } else if (uploadFile.size > 5*1024*1024) { // 5mb
			            alert('파일 사이즈가 너무 커서 업로드할 수 없습니다. (최대 5MB)');
			        	return;
			        } else {
						gridReplyImg();	// 댓글 이미지 영역

						getOrientation(uploadFile, function(orientation) {
						 	if(orientation==6) {
								data.url += "&sOriType="+orientation;
							}
						 	data.submit();
						});
			        }
			    },
			    done: function (e, data) {
			    	$replyCurTarget.next('.loading').removeClass("loading");

			    	var result = data.result;
			    	var $img = {
			    			url : result.file_url,
			    	    	name : result.file_name,
			    	    	size : result.file_size,
			    	};
		    		$replyCurTarget.next().find('.txt_info').show()
						    		.find('.reply_img_url').text($img.name + "/" + $img.size).show()
						    		.next('.reply_img_url_path').val($img.url);
			    },
			    fail: function(){
			        alert("서버와 통신 중 문제가 발생했습니다");
			    }
			});
		});
		
		(function (global, $) {
	            $(function () {
	                // 해당 섹션으로 스크롤 이동 
	                $menu.on('click', 'a', function (e) {
	                    var $target = $(this).parent(),
	                        idx = $target.index();			
	                    if ( idx < $menu.length ){
	                        var offsetTop = Math.ceil($contents.eq(idx).offset().top);
	                        $('html, body').stop().animate({ scrollTop: offsetTop - $navheight }, 500);
	                        return false;
	                    }
	                });
	               
	            });
	
	            // 상단 메뉴 스크롤 시, 고정
	            var $nav = $('.navtab'),
	                $menu = $('.navtab_list li'),
	                $contents = $('.scroll'),
	                $navheight = $nav.outerHeight(), // 상단 메뉴 높이
	                $navtop = Math.ceil($nav.offset().top); // navtab 현재 위치; 
	
	            // menu class 추가 
	            $(window).scroll(function () {
	                var $scltop = Math.ceil($(window).scrollTop());	// 현재 scroll
	
	                if ($scltop > $navtop) {
	                    $nav.addClass("is-fixed");
	                } else {
	                    $nav.removeClass("is-fixed");
	                    $menu.children("a").removeClass('is-on');
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
	        }(window, window.jQuery));
	        
			// 유의사항 열기/닫기
			$(function(){
				var el = {
					btnSlide: $(".btn__evt_on_slide"), // 열기 버튼
					btnSlideClose : $(".btn__evt_off_slide") // 닫기 버튼
				}
				el.btnSlide.click(function(){ // 슬라이드 유의사항 열기
					$(this).toggleClass('on');
					$("#"+$(this).attr("data-laypop-id")).slideToggle();
				})
				el.btnSlideClose.click(function(){ // 슬라이드 유의사항 닫기
					var thisClosest = $(this).closest('.evt_slide')
					$(thisClosest).slideToggle();
					$('html,body').stop(0).animate({scrollTop:$(thisClosest).siblings(".com__evt_notice").offset().top - 50});
				}) 
				
				
			})
		</script>
	<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
	<script language="javascript">

	// 레이어 열닫
	function onoff(id) {
		var mid = $(id);
		var cont = mid.find('.popup_box');
		if(mid.css("display") === 'none') {
			mid.css('display','block');
			cont.css('margin-top',  (-1 * (cont.height() / 2)) );
		}else{
			mid.css('display','none');
		}
	}
	//sns 공유하기 함수
	function shareSns(param){ //수정
		if(param == "face"){
			try{
				window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
			}catch(e){
				window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
			}
		}else if(param == "kakao"){
			try{
				Kakao.Link.createDefaultButton({
					container: '#kakao-share-btn',
					objectType: 'feed',
					content: {
						title: share_title,
						imageUrl: share_img,
						description : share_description,
						link: {
							mobileWebUrl: share_url,
						}
					},
					buttons: [
					{
						title: '상세정보 보기',
						link: {
							mobileWebUrl: share_url,
						}
					}
					]
				});
			}catch(e){
				alert("카카오 톡이 설치 되지 않았습니다.");
				alert(e.message);
			}
		}else if(param == "twitter"){
			var share_title_twi = share_title +" "+share_description;
			window.open("https://twitter.com/intent/tweet?text="+encodeURIComponent(share_title_twi)+"&url="+share_url);
		}
	}

	// 비로그인 댓글쓰기
	function replyClick() {
		if(confirm('로그인 후 의견을 남길 수 있습니다.\n로그인 하시겠습니까?')) {
			goLogin()
		} else {
			return false;
		}
	}

	// 댓글 이미지 선택
	function addReplyImg(event) {
		if(!islogin()){
			replyClick();
			return false;
		}
		$replyCurTarget = $(event.currentTarget);
		$("#file_img_url").trigger("click");
	}

	function gridReplyImg() {
		$replyCurTarget.addClass("disabled").off("click").removeAttr("onclick");
		$replyCurTarget.siblings('.box_info_img').addClass("loading").show();
	}

	function removeReplyImg() {
		$box_info_img = $(".box_info_img");
		$box_info_img.siblings('.disabled').removeClass("disabled").on("click", addReplyImg);
		$box_info_img.hide().children('.txt_info').hide().find('.reply_img_url').text('').next('.reply_img_url_path').val('');
	}

	// 이미지 회전
	function getOrientation(file, callback) {
		var reader = new FileReader();
		reader.onload = function(e) {
			var view = new DataView(e.target.result);
			if (view.getUint16(0, false) != 0xFFD8) return callback(-2);
			var length = view.byteLength, offset = 2;
			while (offset < length) {
				var marker = view.getUint16(offset, false);
				offset += 2;
				if (marker == 0xFFE1) {
					if (view.getUint32(offset += 2, false) != 0x45786966) return callback(-1);
					var little = view.getUint16(offset += 6, false) == 0x4949;
					offset += view.getUint32(offset + 4, little);
					var tags = view.getUint16(offset, little);
					offset += 2;
					for (var i = 0; i < tags; i++){
						if (view.getUint16(offset + (i * 12), little) == 0x0112){
							return callback(view.getUint16(offset + (i * 12) + 8, little));
						}
					}
				}
				else if ((marker & 0xFF00) != 0xFF00) break;
				else offset += view.getUint16(offset, false);
			}
			return callback(-1);
		};
		reader.readAsArrayBuffer(file);
	} 
	// 댓글 등록
	function setReply($this) {
		var replyContents = $("#replyContents").val();
		var curSecretReply = $("#secretReply").val();
		var curbbsName = "nuri";

		var param = {
				"reply_content" : replyContents,
				"flag" : "insert",
				"m_name" : "등록",
				"bbsname" : curbbsName,
				"originkbno" : kb_parent_no,
				"kb_parent_no" : kb_parent_no,
				"reply_thumbnail" : $this?($this.parent().find('.reply_img_url_path').val()?$this.parent().find('.reply_img_url_path').val():''):'',
				"secretReply" : curSecretReply
			};

		if(!islogin()){
			replyClick();
			return false;
		}
		if (replyContents.trim().length <= 0) {
			alert("댓글 내용을 입력해 주세요.");
			return false;
		}
		if ($this.parent().find('.reply_img_url_path').val().length <= 0) {
			alert("이미지를 함께 첨부해주세요.");
			return false;
		}

		$.ajax({
			type: "POST",
			url: "/knowcom/api/setReply.jsp",
			data : param,
			dataType:"JSON",
			success: function(json){
				if((json.returnMsg).indexOf("로그인")>-1){
					goLogin();
					return false;
				}
				alert(json.returnMsg);

				// 댓글 등록 완료 시 작성한 댓글 추가
				if((json.returnMsg).indexOf("등록") > -1) {
//					getReplyList(1, replyContents);	// 랜덤 댓글 조회
					getNewReplyList(1);	// 랜덤 댓글 조회

					insertLog(25355);
				}
			},
			complete: function(){
				// 댓글 입력란 초기화
				$(".write_review textarea").val("");
				$('.write_review').find('.box_info_img').hide().find('.reply_img_url').hide().text('').next('.reply_img_url_path').val('');
				$('.write_review').find('.disabled').removeClass("disabled").on("click", addReplyImg);
				$replyCurTarget=null;

				$(".btn_secret").removeClass('checked');
				$(".btn_secret").val('N');
			},
			error: function (xhr, thrownError) {
				alert("댓글 등록에 실패했습니다");
				console.log(xhr.status);
				console.log(thrownError);
			}
		});
	}
	
	function getNewReplyList(curReplypage) {
		$("#curreplypage").val(curReplypage);
		
		$.ajax({
			type: "POST",
			url: "/knowcom/api/getReply.jsp",
			data : {
				"kbno" : kb_parent_no,
				"page" : curReplypage,
				"idx" : 0,
				"faqtype" : 0,
				"faqseq" : 0,
				"orderby" : "DESC",
				"os" : "MWA",
				"pv" : 0,
				"pageSize" : PAGESIZE
			},
			dataType:"JSON",
			success: function(json){
				var knowcomReplyData = json["knowcomReplyData"];
				var replyArray = knowcomReplyData["replydata"];
				var qnaproData = knowcomReplyData["qna_pro"];
				var totalreplycnt = knowcomReplyData["totalcnt"];
				var firstDepthCnt = knowcomReplyData["1depth_cnt"]; //1depth만 카운트
				var replypagecnt =  parseInt(firstDepthCnt%3)==0 ? parseInt(firstDepthCnt/3) : parseInt(firstDepthCnt/3+1);
				var makeHtml = "";

				$.each(replyArray,function(index,replyData){
					var kb_nickname = replyData["kb_nickname"];
					var userid = replyData["userid"];
					var writer = kb_nickname ? kb_nickname : userid;
					var kb_content = replyData["kb_content"];
					var kb_del_flag = replyData["kb_del_flag"];
					var kb_display_flag = replyData["kb_display_flag"];
					var kb_thumbnail = typeof(replyData["kb_thumbnail"]) != "undefined" ? replyData["kb_thumbnail"] : "";
					var like_cnt=replyData["like_cnt"];
					var secretReply = replyData["cts_view_yn"];
					var login_yn = replyData["login_yn"];
					var vdepth = replyData["depth"];
					var vkb_no = replyData["kb_no"];
					
					if(vdepth == 1){
						makeHtml  +=	"<li>";
						makeHtml  +=	"<div class=\"review_content\">";
						makeHtml  +=	"	<div class=\"tx_name\">"+writer+"</div>";
						makeHtml  +=	"	<div class=\"tx_cont\">";
						if(secretReply == "Y" && login_yn == "Y"){
							makeHtml  +=	"*비밀댓글입니다.<br><br>";
						} 
						
						makeHtml  +=	kb_content;
						if(kb_del_flag !== "1" && kb_thumbnail.length > 0){
							makeHtml  +=	"		<img src=\""+kb_thumbnail+"\" alt=\"캡쳐이미지\" />";
						}
						
						makeHtml  +=	"	</div>";
						if(kb_del_flag !== "1"){
							makeHtml  +=	"	<div class=\"btn_foot\">";
							makeHtml  +=	"		<button type=\"button\" class=\"btn btn-like\" onclick= \"setLike('MW',"+vkb_no+",'reply'); return false;\" >추천 <em  id=\"like_"+vkb_no+"\">"+like_cnt+"</em></button>";
							makeHtml  +=	"	</div>";
						}
						makeHtml  +=	"</div>";
						makeHtml  +=	"</li>";
					}
				});
				
				$("#review_area").html(makeHtml);
				 
				if (totalreplycnt != 0) {
					var paging2 = new paging(curReplypage, PAGESIZE, BLOCKSIZE, firstDepthCnt, 'paginate','goPage');
					paging2.calcPage();
				  	paging2.getPaging(); 
				}
			}
		});
	}
	// 페이지 이동
	function goPage(pageno) {
		getNewReplyList(pageno, PAGESIZE);
		$('html, body').animate({scrollTop: Math.ceil($('.welcome_review').offset().top - 60)}, 0);
		ga_log(6);               
	}
	function view_moapp(){ 
		var chrome25;
		var kitkatWebview;
		var uagentLow = navigator.userAgent.toLocaleLowerCase();
		var openAt = new Date;
		var goApp = "enuri://freetoken/?url=http%3A%2F%2Fm.enuri.com%2Fmobilefirst%2Fevent2021%2Fvia.jsp";
		if(navigator.userAgent.indexOf("Android") > -1){ // 안드로이드
			goApp = "enuri://event?eventurl=&eventstartdate=&eventrepeatday=&eventdetailurl=http://m.enuri.com/mobilefirst/event2021/via.jsp"; 
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
				location.href = goApp;
			}
			//location.href = "market://details?id=com.enuri.android";
			//location.href = "intent://#Intent;scheme=enuri;package=com.enuri.android;end";
		}else{
			setTimeout( function() { 
				window.open("https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8");
			}, 1000); 
			location.href = goApp;
		}
	}
	function setLike(os,kbno,kind){
		var curcateno = $("#curcateno").val();
		var param = {
				"os" 	 : os,
				"kbno"   : kbno,
				"originkbno" : kb_parent_no
		}
		$.ajax({
			type: "POST",
			url: "/knowcom/api/setLike.jsp",
			data : param,
			async: false,
			dataType:"JSON",
			success: function(json){
				if((json.returnMsg).indexOf("로그인이 필요합니다.")>-1){
					Cmd_Login('knowcom_like',window.location.href,1);
					return false;
				}
				alert(json.returnMsg);
				if((json.returnMsg).indexOf("추천이 완료되었습니다.")>-1){
					$("#like_"+kbno).html((parseInt($("#like_"+kbno).html())+1));
				}else{
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				alert(xhr.status);
				alert(thrownError);
			}
		});
	}
	ga_log(1);
	<%if(!strApp.equals("Y") && oc.equals("sns")){%>
	ga_log(8);
	<%} %>
	</script>
	<script type="text/javascript" src="<%= ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</div>
</body>
</html>