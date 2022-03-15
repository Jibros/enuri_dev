<!-- [C] 우측윙 -->
<div class="wing wing--right" id="mainRightDiv">
	 <!-- 윙 > 광고배너 -->
     <div class="wing-ad" id="mainRightDivAD">
     </div>
     <!-- // -->
     
     <!-- [C] 우측 하단 고정 영역 -->
     <div class="wing-summ">
        <!-- 210121 마크업 일부 수정 -->
        <!-- [C] 윙 > 최근본 상품, 찜폴더 -->
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
            <button class="wing-summ__btn--unfold" onclick="$('.wing-summ__prod').removeClass('is--fold');">최근 본 <span class="wing-summ__count" id="wing_btn_recent_cnt"></span></button>
            <!-- // -->
            <!-- 210121 추가 - 버튼 : 접기 -->
            <button class="wing-summ__btn--fold" onclick="$('.wing-summ__prod').addClass('is--fold');"><i class="ico-darr20 comm__sprite">접기</i></button>
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
<script type="text/javascript" src="/common/js/IncListLayers.js"></script>
<script type="text/javascript" src="/common/js/IncListLayersCommon.js"></script>
<script>
var rbViewFlag = <%=viewFlag%>;
var vIsLogin = <%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()>0?true:false%>;
var strCate_banner = "";
if(typeof param_cate != "undefined") strCate_banner = param_cate;
var rbPage_recent = 1;
var rbPage_zzim = 1;
var vWingfrom = "lsv";
var random_seq = "";
var gCate = param_cate;
var IsOpenCompare = "";
var mainRightDivObj = $("#mainRightDiv");

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

	if (rbViewFlag == 2) {
		getSrpFirstRightBanner();	// SRP 우측윙 배너 호출
	}

	if(mainRightDivObj){
		mainRightDivObj.show();
		if( rbViewFlag == 1 || rbViewFlag == 0 ) {
			setRightBanner1();
		}
	}
});


function getSrpFirstRightBanner() {
	if (rbViewFlag == 2) {
		var varS3Url = "http://ad-api.enuri.info/enuri_PC/pc_srp/S3/req";		// SRP
	}
	
	$.get(varS3Url, function(dataObj){
		var varRightBanHtml = "";
		if(dataObj.JURL1 !== undefined && dataObj.IMG1 !== undefined && dataObj.JURL1.length>0 && dataObj.IMG1.length>0) {
			var html = [];
			var hIdx = 0;
			html[hIdx++] = "<a href=\""+dataObj.JURL1+"\" class=\"wing-ad__bnr\" target=\"_blank\">";
			html[hIdx++] = "	<img src=\""+dataObj.IMG1+"\" alt=\"SRP 우측 윙배너\" width=\"100\" height=\"200\">";
			html[hIdx++] = "</a>";
			$("#mainRightDivAD").html(html.join("")).show();
		}
	});
}

//우측배너1
function setRightBanner1() {
	/*
	우측 배너_1 / http://ad-api.enuri.info/enuri_PC/pc_lp/T7_1/req
	우측 배너_2 / http://ad-api.enuri.info/enuri_PC/pc_lp/T7_2/req
	우측 배너_3 / http://ad-api.enuri.info/enuri_PC/pc_lp/T7_3/req
	 */
	var reqUrl = "http://ad-api.enuri.info/enuri_PC/pc_lp/T7_1/req?cate=" + param_cate.substring(0,4);
	var promise1 = $.ajax({
		type : "GET",
		url : reqUrl,
		dataType : "json"
	});
	
	promise1.then(randRightBanner, failBanner);
	promise1.then(setRightBanner2);
}

//우측배너2
function setRightBanner2() {
	var reqUrl = "http://ad-api.enuri.info/enuri_PC/pc_lp/T7_2/req?cate=" + param_cate.substring(0,4);
	var promise2 = $.ajax({
		type : "GET",
		url : reqUrl,
		dataType : "json"
	});
	
	promise2.then(randRightBanner, failBanner);
	promise2.then(setRightBanner3);
}

//우측배너3
function setRightBanner3() {
	var reqUrl = "http://ad-api.enuri.info/enuri_PC/pc_lp/T7_3/req?cate=" + param_cate.substring(0,4);
	var promise3 = $.ajax({
		type : "GET",
		url : reqUrl,
		dataType : "json"
	});
	
	promise3.then(randRightBanner, failBanner);
}

function randRightBanner(banner) {
	var bannerObj = $("#mainRightDivAD");
	var banHtml = "";
	if(banner) banHtml = drawRightBanner(banner);
	if(banHtml.length>0) {
		bannerObj.append(banHtml);
	}
}

function drawRightBanner(banner) {

	var banHtml = "";
	var banImg = banner["IMG1"];
	var banUrl= banner["JURL1"];
	var banTarget = banner["TARGET"];
	var banAlt = banner["ALT"];

	if (banUrl != "" && banTarget != "" ) {

		if($("#mainRightDivAD").css("display") == "none") {
			$("#mainRightDivAD").show();
		}

		if( banTarget == 2 ) {
			banHtml += "	<a href=\""+ banUrl + "\" class=\"wing-ad__bnr\">";
		} else {
			banHtml += "	<a href=\""+ banUrl + "\" class=\"wing-ad__bnr\" target=\"_blank\">";
		}
		banHtml += "		<img alt=\"" + banAlt + "\" src=\"" + banImg + "\" width=\"100\" height=\"200\">";
		banHtml += "	</a>";
	}
	return banHtml;
}

//배너 호출 실패 시
function failBanner(errorObj) {
	console.log( "banner API Call Fail : " + errorObj.statusText);
}

/* -------- 개별로그 -------- */
$(document).on("click", "#compareProdBoxDiv button.lay-compare__btn--flip", function() {
	if($("#compareProdBoxDiv").hasClass("is--fold")) {
		insertLogLSV(14372); // 홈/LP/VIP/SRP/지식통>하단 상품비교 레이어>접기
	} else {
		insertLogLSV(14374); // 홈/LP/VIP/SRP/지식통>하단 상품비교 레이어>열기
	}
});
$(document).on("click", "#compareProdBoxDiv button.lay-compare__btn--close", function() {
	insertLogLSV(14373); // 홈/LP/VIP/SRP/지식통>하단 상품비교 레이어>열기
});
$(document).on("change", ".compare-prod__list input[type=checkbox]", function() {
	insertLogLSV(14375); // 홈/LP/VIP/SRP/지식통>하단 상품비교 레이어>체크박스
});
$(document).on("click", "#compareProdBoxDiv button.allSelectBtn", function() {
	insertLogLSV(14377); // 홈/LP/VIP/SRP/지식통>하단 상품비교 레이어>전체선택 버튼
});

/* -------- // 개별로그 -------- */

</script>