<div class="cate-main">
    <!-- 버튼 : 전체 카테고리 열기 -->
    <button class="cate-main__btn btn" onclick="allCate();">전체카테고리
        <i class="ico-menu comm__sprite"></i>
    </button>
    <!-- // -->
    <!-- 카테고리 리스트 -->
    <ul class="cate--depth1" id="main_left_cate">
        <!-- [반복] Depth1 -->
        <!-- Depth1는 12개 고정 -->
        <!-- mouseenter 시 is--on 클래스 추가 -->
        <!-- 빈카테고리는 is--empty 클래스 붙여주세요 -->
        <li class="cate-item--depth1">
            <p class="cate__tit">가전/TV</p>
            <!-- 우측 확장메뉴 -->
            <div class="cate-item__expend">
                <ul class="cate--depth2 is--on" id="first_depth0" ></ul>
                <div class="cate-main-right">
	                <div class="cate-main-bnr" id="banner__inner" >
		                <ul class="cate-main-bnr__list" id="cateBanner0"></ul>
		                <div class="cate-main-bnr__paging" id="cateBannerBot0"></div>
	                </div>
	                <%@ include file="/wide/main/include/cate_service.jsp"%>
                </div>
                <div class="cate-main-info"><%@ include file="/wide/main/include/gnbDataSeq1_2021.jsp"%></div>
            </div>
            <!-- // -->
        </li>
        <!-- // 대대카테고리 -->
        <li class="cate-item--depth1">
            <p class="cate__tit">컴퓨터/노트북/조립PC</p>
            <div class="cate-item__expend">
            	<ul class="cate--depth2" id="first_depth1" ></ul>
            	<div class="cate-main-right">
	            	<div class="cate-main-bnr" id="banner__inner">
		                <ul class="cate-main-bnr__list" id="cateBanner1"></ul>
		                <div class="cate-main-bnr__paging" id="cateBannerBot1"></div>
	                </div>
	                <%@ include file="/wide/main/include/cate_service.jsp"%>
                </div>
            	<div class="cate-main-info"><%@ include file="/wide/main/include/gnbDataSeq2_2021.jsp"%></div>
            </div>
        </li>
        <li class="cate-item--depth1">
            <p class="cate__tit">태블릿/모바일/디카</p>
            <div class="cate-item__expend">
            	<ul class="cate--depth2" id="first_depth2" ></ul>
            	<div class="cate-main-right">
	            	<div class="cate-main-bnr" id="banner__inner">
		                <ul class="cate-main-bnr__list" id="cateBanner2" ></ul>
		                <div class="cate-main-bnr__paging" id="cateBannerBot2"></div>
	                </div>
	                <%@ include file="/wide/main/include/cate_service.jsp"%>
                </div>
            	<div class="cate-main-info"><%@ include file="/wide/main/include/gnbDataSeq3_2021.jsp"%></div>
            </div>
        </li>
        <li class="cate-item--depth1">
            <p class="cate__tit">스포츠/아웃도어</p>
            <div class="cate-item__expend">
            	<ul class="cate--depth2" id="first_depth3" ></ul>
            	<div class="cate-main-right">
	            	<div class="cate-main-bnr" id="banner__inner">
		                <ul class="cate-main-bnr__list" id="cateBanner3" ></ul>
		                <div class="cate-main-bnr__paging" id="cateBannerBot3"></div>
	                </div>
	                <%@ include file="/wide/main/include/cate_service.jsp"%>
                </div>
                <div class="cate-main-info"><%@ include file="/wide/main/include/gnbDataSeq4_2021.jsp"%></div>
            </div>
        </li>
        <li class="cate-item--depth1">
            <p class="cate__tit">공구/자동차</p>
            <div class="cate-item__expend">
            	<ul class="cate--depth2" id="first_depth4" ></ul>
            	<div class="cate-main-right">
	            	<div class="cate-main-bnr" id="banner__inner">
		                <ul class="cate-main-bnr__list" id="cateBanner4" ></ul>
		                <div class="cate-main-bnr__paging" id="cateBannerBot4"></div>
	                </div>
	                <%@ include file="/wide/main/include/cate_service.jsp"%>
                </div>
                <div class="cate-main-info"><%@ include file="/wide/main/include/gnbDataSeq5_2021.jsp"%></div>
            </div>
        </li>
        <li class="cate-item--depth1">
            <p class="cate__tit">가구/인테리어</p>
            <div class="cate-item__expend">
            	<ul class="cate--depth2" id="first_depth5" ></ul>
            	<div class="cate-main-right">
	            	<div class="cate-main-bnr" id="banner__inner">
		                <ul class="cate-main-bnr__list" id="cateBanner5" ></ul>
		                <div class="cate-main-bnr__paging" id="cateBannerBot5"></div>
	                </div>
	                <%@ include file="/wide/main/include/cate_service.jsp"%>
                </div>
                <div class="cate-main-info"><%@ include file="/wide/main/include/gnbDataSeq6_2021.jsp"%></div>
            </div>
        </li>
        <li class="cate-item--depth1">
            <p class="cate__tit">유아/식품/건강</p>
            <div class="cate-item__expend">
            	<ul class="cate--depth2" id="first_depth6"></ul>
            	<div class="cate-main-right">
	            	<div class="cate-main-bnr" id="banner__inner">
		                <ul class="cate-main-bnr__list" id="cateBanner6"></ul>
		                <div class="cate-main-bnr__paging" id="cateBannerBot6"></div>
	                </div>
	                <%@ include file="/wide/main/include/cate_service.jsp"%>
                </div>
                <div class="cate-main-info"><%@ include file="/wide/main/include/gnbDataSeq7_2021.jsp"%></div>
            </div>
        </li>
        <li class="cate-item--depth1">
            <p class="cate__tit">생활/주방용품</p>
            <div class="cate-item__expend">
            	<ul class="cate--depth2" id="first_depth7" ></ul>
            	<div class="cate-main-right">
	            	<div class="cate-main-bnr" id="banner__inner">
		                <ul class="cate-main-bnr__list" id="cateBanner7"></ul>
		                <div class="cate-main-bnr__paging" id="cateBannerBot7"></div>
	                </div>
	                <%@ include file="/wide/main/include/cate_service.jsp"%>
                </div>
                <div class="cate-main-info"><%@ include file="/wide/main/include/gnbDataSeq8_2021.jsp"%></div>
            </div>
        </li>
        <li class="cate-item--depth1">
            <p class="cate__tit">반려/취미/문구</p>
            <div class="cate-item__expend">
            	<ul class="cate--depth2" id="first_depth8" ></ul>
            	<div class="cate-main-right">
	            	<div class="cate-main-bnr" id="banner__inner">
		                <ul class="cate-main-bnr__list" id="cateBanner8"></ul>
		                <div class="cate-main-bnr__paging" id="cateBannerBot8"></div>
	                </div>
	                <%@ include file="/wide/main/include/cate_service.jsp"%>
                </div>
                <div class="cate-main-info"><%@ include file="/wide/main/include/gnbDataSeq9_2021.jsp"%></div>
            </div>
        </li>
        <li class="cate-item--depth1">
            <p class="cate__tit">패션/화장품</p>
            <div class="cate-item__expend">
            	<ul class="cate--depth2" id="first_depth9" ></ul>
            	<div class="cate-main-right">
	            	<div class="cate-main-bnr" id="banner__inner">
		                <ul class="cate-main-bnr__list" id="cateBanner9"></ul>
		                <div class="cate-main-bnr__paging" id="cateBannerBot9"></div>
	                </div>
	                <%@ include file="/wide/main/include/cate_service.jsp"%>
                </div>
                <div class="cate-main-info"><%@ include file="/wide/main/include/gnbDataSeq10_2021.jsp"%></div>
            </div>
        </li>
        <li class="cate-item--depth1">
            <p class="cate__tit">명품관</p>
            <div class="cate-item__expend">
            	<ul class="cate--depth2" id="first_depth10" ></ul>
            	<div class="cate-main-right">
	            	<div class="cate-main-bnr" id="banner__inner">
		                <ul class="cate-main-bnr__list" id="cateBanner10"></ul>
		                <div class="cate-main-bnr__paging" id="cateBannerBot10"></div>
	                </div>
	                <%@ include file="/wide/main/include/cate_service.jsp"%>
                </div>
                <div class="cate-main-info"><%@ include file="/wide/main/include/gnbDataSeq11_2021.jsp"%></div>
            </div>
        </li>
    </ul>
    <!-- 메인 > 카테고리 > 확장면 -->
    <!--
    <div class="cate-main__extend">
        <div class="cate-service">
			<a href="/cpp/cpp.jsp" onclick="insertLog(23732);"><i class="ico-service-pc comm__sprite"></i> 컴퓨터/노트북</a>
            <a href="/knowcom/index.jsp" onclick="insertLog(23734);" target="_blank"><i class="ico-service-knowcom comm__sprite"></i> 쇼핑지식</a>
            <a href="/deal/newdeal/index.deal" onclick="insertLog(23735);" target="_blank"><i class="ico-service-social comm__sprite"></i> 소셜가격비교</a>
            <a href="/tour2012/Tour_Index.jsp" onclick="insertLog(23736);" target="_blank"><i class="ico-service-travel comm__sprite"></i> 여행</a>
            <a href="/view/Flower365.jsp" onclick="insertLog(23737);" target="_blank"><i class="ico-service-flower comm__sprite"></i> 꽃배달</a>
            <a href="/view/move_mall.jsp" onclick="insertLog(23738);" target="_blank"><i class="ico-service-move comm__sprite"></i> 이사</a>
            <a href="/enuripc" onclick="insertLog(23739);" target="_blank"><i class="ico-service-enuripc comm__sprite"></i> 조립PC</a>
        </div>
    </div>
     -->
    <!-- // -->
</div>
<div class="cate-all border-box" style="display:none;position: absolute;top:0;left:0">
    <!-- 버튼 : 닫기 -->
    <button class="cate-all__btn" onclick="$('.cate-main').show();$('.cate-all').hide();">전체카테고리
        <i class="ico-cls"></i>
    </button>
    <!-- // -->
    <!-- 카테고리 리스트 -->
    <ul class="cate--depth1" id="all_cate"></ul>
    <!-- // -->
</div>
<!-- // -->            
<!-- 홈메인 > 전체 카테고리 -->
