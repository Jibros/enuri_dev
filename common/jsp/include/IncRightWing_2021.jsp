<%
int rbViewFlag = 0;
if (request.getServletPath().trim().indexOf("/detail.jsp")>=0) {
	rbViewFlag = 1;
} else if (request.getServletPath().trim().indexOf("/search.jsp")>=0) {
	rbViewFlag = 2;
} else if (request.getServletPath().trim().indexOf("/event/Resell.jsp")>=0) {
	rbViewFlag = 3;
} else if (request.getServletPath().trim().indexOf("/callrate/Crlisthandphone.jsp")>=0) {
	rbViewFlag = 4;
} else if (request.getServletPath().trim().indexOf("/callrate/")>=0) {
	rbViewFlag = 5;
} else if (request.getServletPath().trim().indexOf("/brandlist/Brandlist.jsp")>=0) {
	rbViewFlag = 6;
} else if (request.getServletPath().trim().indexOf("/fast_view/Brand_View.jsp")>=0) {
	rbViewFlag = 7;
} else if (request.getServletPath().trim().indexOf("/fashion/Fashion_Searchlist.jsp")>=0) {
	rbViewFlag = 8;
} else if (request.getServletPath().trim().indexOf("/callrate/Crlistnational.jsp")>=0) {
	rbViewFlag = 9;
} else if (request.getServletPath().trim().indexOf("/view/Mytodayviewselectlist.jsp")>=0) {
	rbViewFlag = 10;
} else if (request.getServletPath().trim().indexOf("/view/Myfavoriteselectlist.jsp")>=0) {
	rbViewFlag = 11;
} else if (request.getServletPath().trim().indexOf("/etc/Secure.jsp")>=0) {
	rbViewFlag = 12;
} else if (request.getServletPath().trim().indexOf("/etc/Duty.jsp")>=0) {
	rbViewFlag = 13;
} else if (request.getServletPath().trim().indexOf("/list.jsp")>=0) {
	rbViewFlag = 14;
} else if (request.getServletPath().trim().indexOf("/Index.jsp")>=0) {
	rbViewFlag = 15;
}
java.util.Random random = new java.util.Random();
int random_seq = random.nextInt(1000);
%>
<script type="text/javascript" src="/common/js/IncListLayers.js"></script>
<script type="text/javascript" src="/common/js/IncListLayersCommon.js"></script>
<div class="wing wing--right">
	<%if(rbViewFlag==15){ %>
	<div class="wing-adcenter">
	    <a href="http://www.enuri.com/ad" class="btn" target="_blank">에누리 광고센터 바로가기</a>
	</div>

	<%} %>
    <!-- [C] 우측 하단 고정 영역 -->
    <div class="wing-summ">
        <!-- 210121 마크업 일부 수정 -->
        <!-- [C] 윙 > 최근본 상품, 찜폴더 -->
        <!-- 접힌 상태 .is--fold 추가 -->
        <div class="wing-summ__prod is--fold">
            <!-- 최근본상품 -->
            <div class="wing-summ__prod--recent">
                <div class="wing-summ__tit" title="최근 본 상품 팝업이 열립니다" onclick="resentZzimOpen(1);"><i class="ico-wing-recent comm__sprite"></i><span class="wing-sum__tit__tx">최근 본</span> <span class="wing-summ__count" id="wing_head_recent_cnt"></span></div>
                <!-- 최근본 상품 없을때 -->
                
                <!-- 상품리스트 -> 최근본 상품 최대 2개 노출 -->
                <div class="wing-summ__prod__list">
                    <ul id="wing_recent_list">
                        <!-- 상품 아이템 -->
                    </ul>
                    <!-- 페이징 -->
                    <!-- 페이징 될때만 노출 -->
                    <div class="wing-summ_prod__paging" id="wing_recent_page">
                        <em>1</em>/100
                        <button class="paging-arr paging-arr--prev comm__sprite is--disabled" id="wing_recent_page_prev">이전</button>
                        <button class="paging-arr paging-arr--next comm__sprite" id="wing_recent_page_next">다음</button>
                    </div>
                </div>
                <!-- // -->
            </div>
            <!-- 찜상품 -->
            <div class="wing-summ__prod--zzim" id="div_wing_recent_zzim">
                <div class="wing-summ__tit"  title="찜상품 팝업이 열립니다"  onclick="resentZzimOpen(2);"><i class="ico-wing-zzim comm__sprite"></i><span class="wing-sum__tit__tx">찜</span> <span class="wing-summ__count" id="wing_head_zzim_cnt"></span></div>
                <!-- 찜상품 상품 없을때 -->
                <!-- 상품리스트 -> 찜상품 최대 1개 노출 -->
                <div class="wing-summ__prod__list">
                    <ul id="wing_zzim_list">
                        <!-- 상품 아이템 -->
                        <!-- // -->
                    </ul>
                    <!-- 페이징 -->
                    <!-- 페이징 될때만 노출 -->
                    <div class="wing-summ_prod__paging" id="wing_zzim_page">
                        <em>1</em>/100
                        <button class="paging-arr paging-arr--prev comm__sprite is--disabled">이전</button>
                        <button class="paging-arr paging-arr--next comm__sprite">다음</button>
                    </div>
                </div>
                <!-- // -->
            </div>
            <!-- 210121 추가 - 버튼 : 펼치기 -->
            <button class="wing-summ__btn--unfold" onclick="$('.wing-summ__prod').removeClass('is--fold');insertLog(24279);">최근 본 <span class="wing-summ__count" id="wing_btn_recent_cnt"></span></button>
            <!-- // -->
            <!-- 210121 추가 - 버튼 : 접기 -->
            <button class="wing-summ__btn--fold" onclick="$('.wing-summ__prod').addClass('is--fold');insertLog(24280);"><i class="ico-darr20 comm__sprite">접기</i></button>
            <!-- // -->
        </div>
        <!-- [C] 윙 > 신고,알람,탑 버튼 -->
        <div class="wing-summ__btn-group" id="ulFixed">
            <!-- 버튼 : 불편신고 -->
            <button class="wing-sum__btn wing-sum__btn--singo" title="불편신고" id="singoButton">
                <i class="ico-wing-singo comm__sprite"></i><span class="wing-sum__btn__tx" >불편신고</span>
            </button>
            <!-- 버튼 : PC알람 -->
            <button class="wing-sum__btn wing-sum__btn--noti" title="PC알람 설정방법" onclick="open_pc_alert();">
                <i class="ico-wing-noti comm__sprite"></i><span class="wing-sum__btn__tx">PC알람</span>
            </button>
            <!-- 버튼 : 상단으로 -->
            <button class="wing-sum__btn wing-sum__btn--top" id="grGoTop" title="탑으로 이동">
                <i class="ico-arr-top comm__sprite"></i><span class="wing-sum__btn__tx">TOP</span>
            </button>
        </div>
    </div>
    <!-- // -->

</div>



<div id="div_inconv" style="position:absolute;display:none;z-index:125;width:314px;height:258px;" ></div>

<!-- 상품비교창 -->
<!-- <div class="comparison_box combox" id="compareProdBoxDiv" style="display:none;">
	<h4>상품비교(<span class="compCntSpan"></span>)</h4>
	<span class="updown"><em class="morr" style="cursor:pointer;">더보기</em><em class="close" style="cursor:pointer;">닫기</em></span>

	<div class="prod_comlist">
		<ul class="compare"></ul>
	</div>
	
	<ul class="prod_btn">
		<li class="allSelectBtn">전체 선택</li>
		<li class="selectDelBtn">선택상품 삭제</li>
		<li class="selectCompBtn bl">선택상품 비교</li>
		<li class="selectZzimBtn bl">선택상품 찜</li>
	</ul>
</div> -->

<div class="lay-compare lay-comm" id="compareProdBoxDiv" style="display:none;">
    <div class="lay-comm--head">
        <strong class="lay-comm__tit">상품비교 <span class="lay-comm__count compCntSpan">(30)</span></strong> 
    </div>
    <div class="lay-compare__menu">
        <!-- 상품 비교 찜 관련 그룹 -->
        <div class="lay-compare__group">
            <!-- 전체 선택 -->
            <button class="lay-compare__btn--allcheck allSelectBtn"><i class="ico-check-12 comm__sprite"></i> 전체선택</button>
            <!-- 삭제 -->
            <button class="lay-compare__btn--delete selectDelBtn"><i class="ico-delete-12 comm__sprite"></i> 선택삭제</button>
            <!-- (사용X) 찜 --><!-- 비활성화 .is--disabled -->
            <!-- <button class="lay-compare__btn--zzim">선택 상품 찜</button> -->
            <!-- 비교 --><!-- 비활성화 .is--disabled -->
            <button class="lay-compare__btn--compare selectCompBtn bl">선택 상품 비교</button>
        </div>
        <!-- 버튼 : 펼치고 접기 -->
        <button class="lay-compare__btn--flip" onclick="$('.lay-compare').toggleClass('is--fold');"><i class="ico-uarr-20 comm__sprite">접고/펼치기</i></button>
        <!-- 버튼 : 레이어 닫기 -->
        <button class="lay-compare__btn--close" onclick="$('.lay-compare').hide();"><i class="ico-close-20 comm__sprite">닫기</i></button>
    </div>
    <div class="lay-comm--body">
        <div class="lay-comm__inner">
            <div class="compare-prod__wrap">
                <ul class="compare-prod__list">
                </ul>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="/common/js/IncRightWing_2021.js?v=202105071614"></script>


<script>
var vIsLogin = <%=IsLogin %>;
var strCate_banner = "";
if(typeof param_cate != "undefined") strCate_banner = param_cate;
var rbPage_recent = 1;
var rbPage_zzim = 1;
var vWingfrom = "lsv";
var rbViewFlag = <%=rbViewFlag%>;
if(rbViewFlag==15) vWingfrom = "main";
var random_seq = "<%=random_seq%>";
var gCate = "";
var IsOpenCompare = "";

$(document).ready(function(){
	if(vIsLogin){
		fn_banner_info('');
	}else{
		//비로그인시 찜리스트 숨김처리
		$("#div_wing_recent_zzim").hide();
		fn_banner_info('r');
	}
	
	// 상품 비교창 이벤트 추가
	setCompareProdEvent();

});

	
</script>