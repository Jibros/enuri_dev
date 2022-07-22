<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
String strApp = ChkNull.chkStr(request.getParameter("app"));
String cUserId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String tempIp = request.getRemoteHost();
String seasonYN = "Y";
String seasonName = "#새학기";


String call = ChkNull.chkStr(request.getParameter("call"));
if(call.equals("F")){
		
}else{
	response.sendRedirect("/m/index.jsp");
}

%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
    <title>에누리 가격비교 - 최저가 쇼핑은 에누리 가격비교 사이트</title>
	<meta name="Title" content="에누리 가격비교 - 최저가 쇼핑은 에누리 가격비교 사이트" />
	<meta name="Subject" content="에누리 가격비교 - 최저가 쇼핑은 에누리 가격비교 사이트">
	<meta property="og:title" content="에누리 가격비교 - 최저가 쇼핑은 에누리 가격비교 사이트">
	<meta property="og:description" content="에누리 가격비교 - 최저가 쇼핑은 에누리 가격비교 사이트">
    <meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/logo_enuri.png">
    <meta name="format-detection" content="telephone=no" />
    <meta name="description" CONTENT="에누리 가격비교 - 오픈마켓, 종합몰, 백화점, 소셜 등 국내 주요 쇼핑몰의 상품 정보 및 가격비교 제공">
	<meta name="keyword" CONTENT="가격비교, 최저가, 상품 가격, 쇼핑몰 최저가, 가격비교 사이트, 에누리, 싸게 파는 곳, 쇼핑몰, 상품 추천">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/default.css?v=20190913">
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.tmpl.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.lazyload.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js?v=202020"></script>
    <%@include file="/mobilefirst/renew/include/cssBundle.html"%>
    <%@include file="/mobilefirst/login/login_check.jsp"%>
    <script type="application/ld+json" src="/main/main2018/js/searchboxM.js"></script>
	<script>
		var cUserId = "<%=cUserId%>";
		var tempIp = "<%=tempIp%>";
		var seasonYN = "<%=seasonYN%>";
		var IMG_ENURI_COM       = "<%=ConfigManager.IMG_ENURI_COM%>";
		var STORAGE_ENURI_COM   = "<%=ConfigManager.STORAGE_ENURI_COM%>";
		var PHOTO_ENURI_COM     = "<%=ConfigManager.PHOTO_ENURI_COM%>";
		var BLANK_IMG           = IMG_ENURI_COM + "/images/blank.gif";
	</script>
<script type="application/ld+json">
{"@context": "http://schema.org","@type": "Person","name": "에누리닷컴","url": "http://www.enuri.com","sameAs": ["http://blog.naver.com/enuriblog","http://cafe.naver.com/enuriprosumer","https://www.instagram.com/enuristory","https://m.facebook.com/enuriStory/","https://www.youtube.com/channel/UCN6V42RolYz-LcIyd0N11XA"]}
</script>
<!-- Global site tag (gtag.js) - Google Ads: 966646648 -->
<script async src="https://www.googletagmanager.com/gtag/js?id=AW-966646648"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'AW-966646648');
</script>
</head>
<body>
<div id="main">
    <!-- 헤더영역 -->
    <!-- 홈메인 GNB -->
    <%@include file="/mobilefirst/renew/include/gnb.html"%>
    <nav class="m_top">
        <div class="grd_next"></div>
        <div class="gnbarea" id="iscroll">
            <ul class="newgnb" style="heigth:177px">
                <%@ include file="/mobilefirst/renew/include/topMenu.jsp"%>
            </ul>
        </div>
    </nav>
    <!--// 홈메인 GNB -->
    <!-- 서브 -->
    <nav class="m_top_sub" style="display:none;" >
        <h2>'검색단어' 검색결과 <em>(2,589건)</em><span class="tip">구매 TIP</span></h2>
    </nav>
    <!-- <div class="dim" id="mainLayer"  style="z-index:999; display: none;"></div>  -->
    <div class="dim" id="terms" style="z-index:999; display: none;"></div>
    <!-- 170711 전면배너 -->
	<div class="dim" id="mainLayer" onclick="$('#coffee_bnr').hide();" style="z-index:999; display: none;"></div>
    <!--// 서브 -->
    <!--// 헤더영역 -->
    <div id="wrap" class="swiper-container homem">
	    <div id="home_wrap" class="Maincontent swiper-wrapper">
		    <!-- mainHome -->
		    <div id="mainHome" class="swiper-slide">
		        <ul class="m_depth">
						<li><span>가전/해외직구</span></li>
						<li><span>TV/영상/디카</span></li>
						<li><span>컴퓨터/노트북</span></li>
						<li><span>태블릿/모바일</span></li>
						<li><span>스포츠/자동차</span></li>
						<li><span>유아/식품</span></li>
						<li><span>가구/생활</span></li>
						<li><span>패션/화장품</span></li>
						<li><span>소셜비교</span></li>
						<li><span>쇼핑지식</span></li>
				</ul>
		        <!-- 메인 배너 -->
		        <div class="mainbnr swiper-container"  id="home_bnr" >
			            <ul class="evtbnr swiper-wrapper" id="mainEvtbnr"></ul>
			            <div class="pagination"></div>
		                <div class="btn_prev swbtn"></div>
		                <div class="btn_next swbtn"></div>
		        </div>
		        <!--// 메인 배너 -->
		        <!-- 혜택존 -->
		        <ul class="evt_cate"></ul>
		        <!--// 혜택존 -->
		        <ul class="mall_cate">
		            <li><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/logo_gmarket.gif" alt="gmarket"><span>지마켓</span></li>
		            <li><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/logo_auction.gif" alt="auction"><span>옥션</span></li>
		            <li><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/logo_11st.gif" alt="11st"><span>11번가</span></li>
		            <li><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/logo_tmon.gif" alt="tmon"><span>티몬</span></li>
					<li><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/logo_wemake.gif" alt="wemake"><span>위메프</span></li>
		        </ul>
		        <!-- 에누리딜 -->
		        <!--// 160513 에누리딜 -->
		        <%@include file="/mobilefirst/include/inc_ctu.jsp"%>
		        <div class="enuri_deal swiper-container" id="home_deal">
		            <h3>CRAZY DEAL 세상에 없던 미친 할인</h3>
		            <span class="myset">전체보기</span>
		            <ul class="deal_goods swiper-wrapper"></ul>
		        </div>
		        <!--// 에누리딜 -->
		        
		        <%@include file="/mobilefirst/renew/include/globalArea.jsp"%>
		        <%@include file="/mobilefirst/renew/include/rebornCarArea.jsp"%>
		        <!-- 오늘의 추천상품 -->
		         <div class="today_goods">
		            <h3>오늘의 추천상품</h3>
		            <ul class="today_list" id="today_list"></ul>
		         </div>
		        <!--// 오늘의 추천상품 -->
		        <!--  인기쇼핑몰 -->
		        <div class="shop_mall">
		            <h3 class="maintit">인기 쇼핑몰</h3>
		            <ul class="newMallList">
		                <li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/tmp/logo_gmarket.gif" alt="지마켓"></a></li>
		                <li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/tmp/logo_auction.gif" alt="옥션"></a></li>
		                <li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/tmp/logo_11st.gif" alt="11번가"></a></li>
		                <li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/tmp/logo_interpark.gif" alt="인터파크"></a></li>
		                <!--2번줄-->
		                <li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/tmp/logo_ssg.gif" alt="ssg"></a></li>
		                <li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/tmp/logo_lotte.gif" alt="롯데닷컴"></a></li>
		                <li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/tmp/img_logo03.gif" alt="현대H몰"></a></li>
		                <li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/tmp/img_logo_AKmall.gif" alt="ak mall"></a></li>
		                <!--3번줄-->
		                <li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/tmp/img_logo05.gif" alt="GS SHOP"></a></li>
		                <li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/tmp/img_logo06.gif" alt="CJmall"></a></li>
		                <li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/tmp/img_logo07.gif" alt="롯데 홈쇼핑"></a></li>
		                <li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/tmp/img_logo09.gif" alt="홈앤쇼핑"></a></li>
		                <!-- 4번째줄 -->
		                <li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/tmp/logo_wema.gif" alt="위메프"></a></li>
		                <li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/tmp/logo_timon.gif" alt="티몬"></a></li>
		                <li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/tmp/logo_coupang.gif" alt="쿠팡"></a></li>
		                <li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/tmp/logo_g9.gif" alt="G9"></a></li>
		                <!--5번줄-->
		                <li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/tmp/logo_ellotte.gif" alt="엘롯데"></a></li>
		                <li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/tmp/img_logo04.gif" alt="갤러리아"></a></li>
		                <li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/tmp/img_logo_ns.gif" alt="NSmall"></a></li>
		                <li><a href="javascript:///"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/tmp/logo_im.gif" alt="공영홈쇼핑"></a></li>
		            </ul>
		        </div>
		        <!--  인기쇼핑몰 -->
		    </div>
		    <div id="hotDealBest" class="swiper-slide">
			    <ul class="tab_deal">
			        <li id="deal_1"><a href="javascript:///" onclick="getBaselist(1);">슈퍼딜</a></li>
			        <li id="deal_2"><a href="javascript:///" onclick="getBaselist(2);">올킬</a></li>
			        <li id="deal_3"><a href="javascript:///" onclick="getBaselist(3);">쇼킹딜</a></li>
			        <li id="deal_4"><a href="javascript:///" onclick="getBaselist(4);">티몬</a></li>
			        <li id="deal_6"><a href="javascript:///" onclick="getBaselist(6);">위메프</a></li>
			        <li id="deal_7"><a href="javascript:///" onclick="getBaselist(7);">쎈딜</a></li>
			    </ul>
			    <h4 class="hot_title"><img id="hot_title" src="" alt="" /></h4>
			    <ul class="today_list sdeal" id="hotDealBestList">
					<li><div class="thum"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png"></div></li>
					<li><div class="thum"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png"></div></li>
			    </ul>
		    </div>
		    <!-- 2017-05-26 시즌탭 추가 -->
		    <%if(seasonYN.equals("Y")){ %>
			<div id="season" class="cont_area swiper-slide"></div>
			<%} %>
		    <!-- 기획전 & 이벤트 -->
		    <div id="planEvt" class="swiper-slide">
			    <ul class="newTab">
		            <li class="on" data-id="P"><a href="#tab01">인기 기획전</a></li>
		            <li data-id="E"><a href="#tab02">이벤트 혜택</a></li>
		        </ul>
		        <div class="plan">
				     <!-- 특별 기획전 -->
			        <div class="cont_area plan" id="tab01">
			            <ul id="planList">
				            <li><a href="javascript:///"><img class="swiper-lazy swiper-lazy-loaded" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png"></a></li>
				            <li><a href="javascript:///"><img class="swiper-lazy swiper-lazy-loaded" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png"></a></li>
				            <li><a href="javascript:///"><img class="swiper-lazy swiper-lazy-loaded" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png"></a></li>
				            <li><a href="javascript:///"><img class="swiper-lazy swiper-lazy-loaded" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png"></a></li>
			            </ul>
			        </div>
			        <!--// 특별 기획전 -->
			        <!-- 이벤트 -->
			        <div class="cont_area plan" id="tab02">
			            <ul id="eventList"></ul>
			            <button type="button" class="winner" onclick="goWonList()" style="display:none"><em>당첨자발표</em></button>
			        </div>
			        <!--// 이벤트-->
		        </div>
	        </div>
	        <!-- //쇼핑팁 -->
	        <%/* %>
	        <div id="newNews" class="swiper-slide">
		        <section class="news new">
					<div class="big_photo" id="news_top">
						<img class="lazy" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png" data-original="" alt="">
					</div>
					<div class="newsbox" id="news_bottom">
						<ul class="sp_list"  id="news_bottom_body"></ul>
					</div>
					<div class="newsbox" id="news_review"></div>
					<div class="newsbox" id="news_theme"></div>

					<!-- 20190122 투데이 HOT CLIP -->
					<div class="newsbox">
						<h3 class="hotclip_tit">
							투데이 HOT CLIP
							<em class="all" onclick="insertLog(19107);location.href='/knowcom/news.jsp?cateno=5'">더보기</em>
						</h3>

						<!-- Scroll wrap -->
						<div id="swiperHotclip" class="swiper-container">
							<ul class="swiper-wrapper hotclip_list"></ul>
						</div>
						<!-- Scroll wrap -->
						<script type="text/javascript">
						$(window).load(function(){
							// 이미지 사이즈 가로가 세로보다 같거나 클 경우, 해당 영역에 클래스 추가 "vertical_mid" 세로 가운데 정렬
							var g_img = $(".hotclip_list > li .g_thumb > img");
							$(g_img).each(function(i){
								var g_w = $(this).width(), 	// 이미지 너비
									g_h = $(this).height();	// 이미지 높이
								if(g_w >= g_h){
									$(this).parents(".g_thumb").addClass("vertical_mid");
								}
							});
						});
						</script>
					</div>
					<!-- //20190122 투데이 HOT CLIP -->

					<div class="newsbox">
						<h3>카테고리별 <b>핫뉴스</b></h3>
						<ul class="cate_new">
							<li id="newscate_head_01" class="newscate_btt" cate="01" class="on">디지털/가전</li>
							<li id="newscate_head_02" class="newscate_btt" cate="02">컴퓨터</li>
							<li id="newscate_head_03" class="newscate_btt" cate="03">스포츠/자동차</li>
							<li id="newscate_head_04" class="newscate_btt" cate="04">유아/라이프</li>
						</ul>
						<ul class="hotnews"  id="newscate_01" style="display:none"></ul>
						<ul class="hotnews"  id="newscate_02" style="display:none"></ul>
						<ul class="hotnews"  id="newscate_03" style="display:none"></ul>
						<ul class="hotnews"  id="newscate_04" style="display:none"></ul>
					</div>
				</section>
			</div>
			<!-- //가이드 -->
			<div id="shoppingTip" class="swiper-slide">
		        <section class="news">
					<div class="big_photo" id="todaytip_top">
						<img class="lazy" src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png" data-original="" alt="">
					</div>
					<div class="newsbox" id="weekly_push"></div>
					<div class="newsbox" id="tip_01"> </div>
					<div class="newsbox" id="tip_02"> </div>
					<div class="newsbox" id="tip_03"> </div>
					<div class="newsbox" id="tip_04"> </div>
					<div class="newsbox" id="tip_05"> </div>
				</section>
			</div>
	        <!-- 웹젠 -->
	        <div id="webzine" class="cont_area swiper-slide">
				<ul class="webzine_list"></ul>
			</div>
			<%*/ %>
	        <div class="swiper-slide">
				<ul class="brand_snb">
					<li class="brand_btt on" id="brand_1" onclick="getBestlist(1);"><a href="javascript:////">Gmarket</a></li>
					<li class="brand_btt" id="brand_2" onclick="getBestlist(2);"><a href="javascript:////">AUCTION</a></li>
					<li class="brand_btt" id="brand_3" onclick="getBestlist(3);"><a href="javascript:////">11ST</a></li>
					<li class="brand_btt" id="brand_4" onclick="getBestlist(4);"><a href="javascript:////">interpark</a></li>
				</ul>
				<section class="shop_best">
					<ul class="best_list" id="best_body">
						<li><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg320.gif"></li>
						<li><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg320.gif"></li>
						<li><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg320.gif"></li>
						<li><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg320.gif"></li>
					</ul>
				</section>
			</div>
			<!-- 마트 -->
		    <div class="martBest swiper-slide">
		        <!-- 메인 배너 -->
		        <div class="mainbnr swiper-container"   id="mart_bnr" >
					<ul class="evtbnr swiper-wrapper" id="martBanner"></ul>
					<div class="pagination"></div>
	                <div class="btn_prev swbtn"></div>
	                <div class="btn_next swbtn"></div>
		        </div>
		        <!--// 메인 배너 -->
		        <ul class="mart_cate"></ul>
		        <!-- 상품 list -->
		        <h4 class="mart_tit"></h4>
		        <ul class="mart_list"></ul>
		        <!--// list -->
		    </div>
		    
			<!-- 히든탭 -->
			<div class="swiper-slide">
			<img src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/extratab_bg_web.jpg" onclick="goEventPlan()" alt="" width="100%"/>
			</div>
    	</div>
	</div><!-- 전체 영역 -->
	<%@ include file="/mobilefirst/renew/include/footer.jsp"%>
</div>
<!-- 앱설치 레이어 -->
<div class="dim" id="appLayer" style="display:none;">
    <div class="app_install">
        <a href="javascript:///" class="go_app">에누리 앱 설치하기</a>
        <a href="javascript:///" class="closebtn" onclick="onoff('appLayer')">닫기</a>
    </div>
</div>
<span class="zzimly" style="display:none">찜 되었습니다</span>
</body>
<script>
var subBannerIcon = '<%@include file="/mobilefirst/http/json/main_event_list.json"%>'; //메인아이콘배너
var martBannerAndCate = <%@ include file="/mobilefirst/http/json/bannerAndCate.json"%>;
ga('send', 'pageview', {    'page': "IndexNew",    'title': 'HOME_WEB'});
</script>
<%@include file="/mobilefirst/renew/include/jsBundle.html"%>
<!--메인광고배너-->
<script id="mainBanner" type="text/x-jquery-tmpl">
    <li class="swiper-slide"><a href="javascript:goMainBanner('\${JURL1}','\${TXT1}');" title="\${TXT1}"><img src="\${TARGET}" alt="\${ALT}"  /></a></li>
</script>
<script id="mainGoodsList" type="text/x-jquery-tmpl">
    {{if part =='T' || part == 'C' }}
    <li id="part_\${part}">
        <a href="javascript:///" onclick="addResentZzimItem(1, 'P', '\${pl_no}');goShopLink('\${url}','\${part}' , '\${shopcode}' ,  '\${modelno}' , '\${pl_no}' );"  >
            <div class="thum">
				{{if fix_location > 8}}
				<img class="lazy" data-original="\${img}" alt="" src='<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png';">
				{{else}}
				<img src="\${img}" onerror="if (this.src != '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png') this.src = '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png';">
				{{/if}}
			</div>
            {{if badge_yn== 'Y'}}
            <span class="hotpic ico_m">HOT PICK</span>
            {{/if}}
            {{if title != ""}}
            <p class="ment" {{if title_bg != ""}}  style="background:\${title_bg}" {{/if}} ><em>\${title}<br>\${subtitle}</em></p>
            {{/if}}
            <div class="zzimarea" onclick="event.cancelBubble=true;" >
                <button type="button" class="heart"  onclick="zzimSet('\${modelno}' , '\${pl_no}' ,this, '\${part}' , '\${shopcode}' );" id="G_\${modelno}">찜</button>
            </div>
            {{if  shopcode != null  || shopcode != ""}}
	            {{if shopcode == 1634}}
				<span class="mall txt">컴퓨존</span>
	            {{else shopcode == 6695}}
				<span class="mall txt">멸치쇼핑</span>
				{{else}}
				<span class="mall"><img src="\${mainShopLogo(shopcode)}" alt="" onerror="if (this.src != '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png') this.src = '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png';"></span>
	            {{/if}}
            {{/if}}
            <div class="titarea"><strong>\${modelnm}</strong></div>
            <div class="price">
                <span class="sale">최저가</span>
                <span class="prc"><b>\${commaNum(price)}</b>원</span>
            </div>
        </a>
         <div class="info_btn">
                {{if section != ""}}
                <span class="comt"  onclick="mainSectionGo('\${section_url}' , '\${modelno}' );" >\${section_txt}</span>
                {{else  bbs_cnt != "" && bbs_cnt != "0"}}
                <span class="comt" onclick="goUserReview('\${vip_url}','\${part}','\${modelno}')">상품평 (\${commaNum(bbs_cnt)})
	                <span class="star_graph ico_m">
	                    {{if bbs_staravg != ""}}
	                    <span class="ico_m" style="width:\${bbs_staravg*2}%">별점</span>
	                    {{/if}}
	                </span>
                </span>
                <span class="pr" onclick="goVip('\${vip_url}','\${part}','\${modelno}');">가격비교<em>\${mallcnt}</em></span>
	            {{else bbs_cnt == "" || bbs_cnt == "0" }}
	                <span class="go_store" onclick="mainCateGo('\${category}')"><em>\${categorynm}</em></span>
	                <span class="pr" onclick="goVip('\${vip_url}','\${part}');">가격비교<em>\${mallcnt}</em></span>
	            {{/if}}
        </div>
    </li>
    {{/if}}
    {{if part =='S' }}
    <li id="part_\${part}">
		<a href="javascript:///"  onclick="addResentZzimItem(1, 'P', '\${pl_no}');goShopLink('\${url}','\${part}' , '\${shopcode}' , '\${pl_no}' , '\${pl_no}' );"   >
            {{if imgtype == '1'}}
            <div class="thum">
					{{if typeof wmov != "undefined"}}
						<em class="play ico_m" onclick="goMovLink('\${wmov}','\${imov}','\${part}','\${shopcode}','\${pl_no}','\${modelnm}');event.cancelBubble=true;">PLAY</em>
					{{/if}}
					<img class="lazy" data-original="\${img}" alt="" src='<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png';">
			</div>
            {{/if}}
            {{if imgtype == '2'}}
            <div class="thum sq">
					<img class="lazy" data-original="\${img}" alt=""  src='<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png';">
			</div>
            {{/if}}
            {{if title != ""}}
            <p class="ment" style="background:\${title_bg}"><em>\${title}<br>\${subtitle}</em></p>
            {{/if}}
            <div class="zzimarea" onclick="event.cancelBubble=true;" >
                <button type="button" class="heart"  onclick="zzimSet('\${modelno}' , '\${pl_no}' ,this,'\${part}', '\${shopcode}' );"  id="P_\${pl_no}">찜</button>
            </div>
            {{if typeof shopcode != "undefined"}}
            <span class="mall"><img src="\${mainShopLogo(shopcode)}" alt=""></span>
            {{/if}}
            <div class="titarea"><strong>\${modelnm}</strong></div>
            <div class="price">
                {{if orgPrice != "" && discount_rate != ""}}
                <span class="sale"><b>\${discount_rate}</b>%</span>
                {{/if}}
                {{if orgPrice == "" && discount_rate == ""}}
                <span class="sale">특별가</span>
                {{/if}}
                <span class="prc">
                <b>\${commaNum(price)}</b>원
                {{if orgPrice != "" && discount_rate != ""}}
                <del>\${commaNum(orgPrice)}원</del>
                {{/if}}
                </span>
                {{if pcnt != ""}}
                <span class="buy">\${commaNum(pcnt)}개 구매</span>
                {{/if}}
            </div>
        </a>
    </li>
    {{/if}}
    {{if part =='N' }}
    <li id="part_\${part}">
        <a href="javascript:///"  onclick="addResentZzimItem(1, 'P', '\${pl_no}');goShopLink('\${url}','\${part}' , '\${shopcode}'  , '\${pl_no}' , '\${pl_no}' );"  >
            <div class="thum">
				<img class="lazy" data-original="\${img}" alt="" src = '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png';">
			</div>
            {{if title != ""}}
            <p class="ment" style="background:\${title_bg}"><em>\${title}<br>\${subtitle}</em></p>
            {{/if}}
            <div class="zzimarea" onclick="event.cancelBubble=true;" >
                <button type="button" class="heart"  onclick="zzimSet('\${modelno}' , '\${pl_no}' ,this,'\${part}', '\${shopcode}' );"  id="P_\${pl_no}">찜</button>
            </div>
            {{if typeof shopcode != "undefined"}}
            <span class="mall"><img src="\${mainShopLogo(shopcode)}" alt=""></span>
            {{/if}}
            <div class="titarea"><strong>\${modelnm}</strong></div>
            <div class="price">
                <span class="prc"><b>\${commaNum(price)}</b>원</span>
                {{if salecnt != '' }}
                <span class="buy">\${commaNum(salecnt)}개 구매</span>
                {{/if}}
            </div>
        </a>
    </li>
    {{/if}}
    {{if part == 'A' ||  part =='G' }}
    <li id="part_\${part}" class="bnrarea" onclick="javascript:mainEventGo('\${part}','\${section_txt}','\${section_url}');">
        <img class="lazy" data-original="\${img}" src = "<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png"  alt="" onerror="if (this.src != '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png');">
    </li>
    {{/if}}
    {{if part =='D' }}
    <li id="part_\${part}">
        <a href="javascript:///" onclick="addResentZzimItem(1, 'P', '\${pl_no}');goShopLink('\${url}','\${part}' , '\${shopcode}' , '\${modelno}', '\${pl_no}' );"  >
            <div class="thum">
				<img class="lazy" data-original="\${img}" alt="" src='<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png';">
			</div>
            {{if badge_yn == 'Y' }}
	            {{if badge_shop == 6 }}<span class="depart galleria">갤러리아백화점</span>{{/if}}
	            {{if badge_shop == 5 }}<span class="depart hyundai">현대백화점</span>{{/if}}
	            {{if badge_shop == 3 }}<span class="depart ak">AK플라자</span>{{/if}}
	            {{if badge_shop == 1 }}<span class="depart shinsegae">신세계백화점</span>{{/if}}
	            {{if badge_shop == 2 }}<span class="depart lotte">롯데백화점</span>{{/if}}
	            {{if badge_shop == 4 }}<span class="depart daegu">대구백화점</span>{{/if}}
	        {{/if}}
            {{if title != ""}}
            <p class="ment" style="background:\${title_bg}"><em>\${title}<br>\${subtitle}</em></p>
            {{/if}}
            <div class="zzimarea" onclick="event.cancelBubble=true;" >
                <button type="button" class="heart"  onclick="zzimSet('\${modelno}' , '\${pl_no}' ,this, '\${part}' , '\${shopcode}' );" id="G_\${modelno}">찜</button>
            </div>
            <span class="mall"><img src="\${mainShopLogo(shopcode)}" alt=""></span>
            <div class="titarea"><strong>\${modelnm}</strong></div>
            <div class="price">
                <span class="sale">특별가</span>
                <span class="prc"><b>\${commaNum(price)}</b>원</span>
            </div>
        </a>
        <div class="info_btn">
            {{if bbs_staravg != ""}}
                <span class="comt" onclick="goUserReview('\${vip_url}','\${part}','\${modelno}')">상품평 (\${commaNum(bbs_cnt)})<span class="star_graph ico_m">
                <span class="ico_m" style="width:\${bbs_staravg*2}%">별점</span></span></span>
                <span class="pr" onclick="goVip('\${vip_url}','\${part}');"">가격비교<em>\${mallcnt}</em></span>
            {{else mallcnt == "" }}
                <span class="go_store onebtn"><em>\${section_txt}</em></span>
            {{else mallcnt != ""}}
            <span class="go_store"><em>\${section_txt}</em></span>
            <span class="pr" onclick="goVip('\${vip_url}','\${part}');"">가격비교<em>\${mallcnt}</em></span>
            {{/if}}
        </div>
    </li>
    {{/if}}
    {{if part =='P' }}
	<li id="part_\${part}">
	    <div class="guide">
	         {{if title !='' }}
	        <div class="cam_tip">
	            <div class="txtbox" onclick="goMainPlan('\${section_url}','\${modelno}')"><span>\${title}<em><br>\${subtitle}</em></span></div>
	            <img class="lazy" data-original="\${img}" alt="" src='<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png';">
	        </div>
	        {{/if}}
	         {{if title =='' }}
            <div class="cam_tip img">
                <div class="txtbox" onclick="goMainPlan('\${section_url}','\${modelno}')"></div>
                <img src="\${img}"  alt="" onerror="if (this.src != '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png') this.src = '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png';">
            </div>
            {{/if}}
	        <ul class="buy_tip">
	           {{each(prop, val) sublist}}
	            <li>
	                <a href="javascript:///" onclick="goSublistClick('\${val.url}', '\${val.parent_modelno}' )">
	                    <img src="\${val.shop_img}" onerror="if (this.src != '\${val.enuri_img}') this.src = '\${val.enuri_img}';">
	                    <span class="tit">\${val.modelnm}</span>
	                    <b>\${commaNum(val.minprice3)}<em>원</em></b>
	                </a>
	            </li>
	            {{/each}}
	        </ul>
	    </div>
	</li>
    {{/if}}
    {{if part =='B' }}
    <li id="part_\${part}">
        <a href="javascript:///" onclick="goShopLink('\${url}','\${part}' , '\${shopcode}'  , '\${pl_no}'  , '\${pl_no}'  );">
            <div class="thum sq">
				<img src="\${img}" alt="" onerror="if (this.src != '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png') this.src = '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png';">
			</div>
            {{if badge_yn== 'Y'}}
            <span class="hotpic ico_m">HOT PICK</span>
            {{/if}}
            {{if title != ""}}
            <p class="ment" style="background:\${title_bg}"><em>\${title}<br>\${subtitle}</em></p>
            {{/if}}
            <div class="zzimarea" onclick="event.cancelBubble=true;" >
                <button type="button" class="heart"  onclick="zzimSet('\${modelno}' , '\${pl_no}' ,this,'\${part}', '\${shopcode}' );"  id="P_\${pl_no}">찜</button>
            </div>
            {{if  shopcode != null  || shopcode != ""}}
            <span class="mall"><img src="\${mainShopLogo(shopcode)}" alt="" onerror="if (this.src != '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png') this.src = '<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/noimg.png';"></span>
            {{/if}}
            <strong>\${modelnm}</strong>
            <div class="price">
                <span class="prc"><b>\${commaNum(price)}</b>원</span>
                {{if pcnt != ""}}
                <span class="buy">\${commaNum(pcnt)}개 구매</span>
                {{/if}}
            </div>
        </a>
        <a href = "\${section_url}">
        <div class="info_btn">
            <span class="go_store onebtn" onclick="">
               <em>\${section_txt}</em>
            </span>
        </div>
        </a>
    </li>
    {{/if}}
    {{if part =='QQ' }}
	<li id="part_\${part}" class="bnrarea">
		<div class="plan_area swiper-container"  id="home_plan" >
			<ul class="swiper-wrapper">
				{{each(prop, val) list}}
				<li class="swiper-slide" onclick="goQQlink('\${section_url}','\${part}' , '\${section_txt}');" ><img src="\${val.img}" alt="" /></li>
				{{/each}}
			</ul>
		</div>
	</li>
    {{/if}}
</script>
<script id="revisedTermsofUse" type="text/x-jquery-tmpl">
    <div class="terms_layer">
        <div class="con">
            <h1>에누리 이용약관 개정 안내</h1>
            <p class="txt">안녕하세요. 에누리 가격비교입니다.<br />고객님의 보다 편리한 서비스 이용을 돕기 위해<br />이용약관이 전면 개정될 예정입니다.<br /><br />&#183; 시행일자 : 2016년 9월 5일(월요일)부터</p>
            <div class="wbox">
                <h2>에누리 이용약관</h2>
                <ul>
                    <li>에누리 서비스에 대한 정의 보완</li>
                    <li>광고 서비스 제공을 위한 조항 신설</li>
                    <li>‘에누리 오픈마켓’ 서비스 종료에 따른 조항 삭제</li>
                </ul>
                <button class="view"  id="termButton">자세히보기</button>
            </div>
            <div class="wbox">
                <h2>e머니 이용약관</h2>
                <ul>
                    <li>e머니(리워드서비스)에 대한 정의 및 정책 보완</li>
                    <li>약관 변경에 따른 사전 공지기간 변경</li>
                </ul>
                <button class="view" id="emoneyButton">자세히보기</button>
            </div>
            <p class="txt02">※자세히보기는 PC버전으로 지원<br />※개정된 내용에 동의하지 않으신 경우, 회원탈퇴 요청 가능</p>
        </div>
        <p class="frontbtn"><span id="replaceN"><a href="javascript:///">다시 보지 않기</a></span><span><a href="javascript:///" onclick="$('#terms').hide();">닫기</a></span></p>
    </div>
</script>
<script id="seasonTabTmp" type="text/x-jquery-tmpl">
<div class='season_wrap'>
	<div class="s_area">
		<div class="s_area_inner">
			{{each(prop, val) season_Tab}}
			<img src="\${val.img_web}" alt="" class="m_img" data-url="\${val.url}" data-num="\${prop}" />
			{{/each}}
		</div>
	</div>
</div>
</script>
<%@include file="/mobilefirst/include/common_logger.html"%>
</html>