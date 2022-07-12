// 헤더 컴퍼넌트 
export var headerComponent = "";

    headerComponent += "<header id=\"header\">";
    headerComponent += "  <h1>NEW MP</h1>";
    headerComponent += "  <div class=\"admin_control\">";
    headerComponent += "      <ul class=\"exlink_list\">";
    headerComponent += "        <li><a href=\"#\" target=\"_blank\" title=\"CM 주요 관리 지표\">CM 주요 관리 지표</a></li>";
    headerComponent += "        <li><a href=\"#\" target=\"_blank\" title=\"경쟁사 모니터링\">경쟁사 모니터링</a></li>";
    headerComponent += "        <li><a href=\"#\" target=\"_blank\" title=\"핵심 속성 입력/점검\">핵심 속성 입력/점검</a></li>";
    headerComponent += "        <li><a href=\"#\" target=\"_blank\" title=\"제조사[불명] 현황\">제조사[불명] 현황</a></li>";
    headerComponent += "        <li class=\"has-sub\"><button title=\"연관상품(소모품)\">연관상품(소모품)</button>";
    headerComponent += "            <div class=\"exlink_sub\">";
    headerComponent += "                <ul>";
    headerComponent += "                    <li><a href=\"./related_products.html\" target=\"_blank\">TV</a></li>";
    headerComponent += "                    <li><a href=\"./related_products.html\" target=\"_blank\">홈시어터</a></li>";
    headerComponent += "                    <li><a href=\"./related_products.html\" target=\"_blank\">프로젝터/스크린</a></li>";
    headerComponent += "                    <li><a href=\"./related_products.html\" target=\"_blank\">홈시어터/HiFi</a></li>";
    headerComponent += "                    <li><a href=\"./related_products.html\" target=\"_blank\">영상가전 액세서리</a></li>";
    headerComponent += "                    <li><a href=\"./related_products.html\" target=\"_blank\">주방가전</a></li>";
    headerComponent += "                    <li><a href=\"./related_products.html\" target=\"_blank\">생활가전</a></li>";
    headerComponent += "                    <li><a href=\"./related_products.html\" target=\"_blank\">계절가전</a></li>";
    headerComponent += "                    <li><a href=\"./related_products.html\" target=\"_blank\">건강가전</a></li>";
    headerComponent += "                    <li><a href=\"./related_products.html\" target=\"_blank\">미용/욕실가전</a></li>";
    headerComponent += "                </ul>";
    headerComponent += "            </div>";
    headerComponent += "        </li>";
    headerComponent += "      </ul>";
    headerComponent += "      <p class=\"user_log\">로그인정보 <span>2021.11.12 10:27:10</span></p>";
    headerComponent += "  </div>";
    headerComponent += "</header>";

// 페이지 정보 컴퍼넌트
export var pageUtilComponent = "";

    pageUtilComponent += "<div class=\"pageutil\">";
    pageUtilComponent += "    <div class=\"container-fluid\">";
    pageUtilComponent += "        <div class=\"row\">";
    pageUtilComponent += "            <div class=\"col-12\">";

    pageUtilComponent += "                <div class=\"datainfo\">";
    pageUtilComponent += "                  <div class=\"datainfo_inner\">";
    pageUtilComponent += "                    <dl>";
    pageUtilComponent += "                        <dt>GMV 달성율:</dt>";
    pageUtilComponent += "                        <dd><p class=\"tx tx-up\">81.75%</p></dd>";
    pageUtilComponent += "                        <dd><p>YOY</p><p class=\"tx tx-up\">103%</p></dd>";
    pageUtilComponent += "                    </dl>";

    pageUtilComponent += "                    <dl>";
    pageUtilComponent += "                        <dt>생산량 달성율:</dt>";
    pageUtilComponent += "                        <dd><p>추가</p><p class=\"tx tx-down\">145%</p></dd>";
    pageUtilComponent += "                        <dd><p>매칭</p><p class=\"tx tx-down\">560%</p></dd>";
    pageUtilComponent += "                    </dl>";
    pageUtilComponent += "                  </div>";
    pageUtilComponent += "                </div>";
    pageUtilComponent += "            </div>";
    pageUtilComponent += "        </div>";
    pageUtilComponent += "    </div>";
    pageUtilComponent += "</div>";



// 레이아웃 변경
export var changeViewBtn = "";
    changeViewBtn += "<div class=\"change_view\">";
    changeViewBtn += "  <button class=\"btn_change\">show</button>";
    changeViewBtn += "</div>";

// 레이아웃 레이어 HTML
var layChangeCont = "";
    layChangeCont += "<div class=\"lay_changeView\">";
    layChangeCont += "  <div class=\"sel_layout\">";
    layChangeCont += "      <ul>";
    layChangeCont += "          <li class=\"is-on\"><button type=\"button\" class=\"btn_lay1\" data-layout=\"1\">레이아웃01</button></li>";
    layChangeCont += "          <li><button type=\"button\" class=\"btn_lay2\" data-layout=\"2\">레이아웃02</button></li>";
    layChangeCont += "      </ul>";
    layChangeCont += "  </div>";
    layChangeCont += "  <div class=\"lay_foot\">";
    layChangeCont += "      <button type=\"button\" class=\"btn_excute\">열기</button>";
    layChangeCont += "      <button type=\"button\"onclick=\"dhxWindow.hide()\">닫기</button>";
    layChangeCont += "  </div>";
    layChangeCont += "</div>";

// 레이어 위젯
var dhxWindow = new dhx.Window({
    title: "화면 유형 설정",
    closable: false,
    css: "lay_changeview",
    html: layChangeCont
});

// 위젯 열기
$(document).on("click", ".btn_change", function(){
    dhxWindow.show();
})

// 레이아웃 선택 
var loadSt = false; // 로딩 상태
var layoutNum = 1;
$(document).on("click", ".sel_layout>ul>li", function(){
    var _this = $(this);        
    
        _this.addClass("is-on").siblings("li").removeClass("is-on");
        layoutNum = _this.find("button").data("layout");
})
// 레이아웃 변경
$(document).on("click", ".lay_changeView .btn_excute", function(){
    dhxWindow.hide();

    $(".loader_box").fadeIn();
    setTimeout(function(){
        loadSt = true;
        if(loadSt){
            $(".loader_box").fadeOut();
    
            if(layoutNum === 1){
                //레이아웃1
                window.location.href = "./index.html"
            }else if(layoutNum === 2){
                //레이아웃2
                window.open("./index_srch.html");
            }
            loadSt = false;
        }
    }, 1000) // 임의속도
})

// ************************* 220211 : SR#51192 : 상단 통합검색 키워드 기능 추가
// ************************* 220211 : SR#51192 : 상단 통합검색 영역 추가
// 통합검색 FORM : 검색 영역
export var wrapSrchControll = new dhx.Form(null, {
    css: "controller_all",
    padding: 0,
    width: "100%",
    cols: [
        {
            id: "selectStep1",
            name: "selectStep1",
            type: "select",
            label: "",
            labelPosition: "left",
            labelWidth: 0,
            value: "통합",
            required: true,
            options: [
                {
                    value: "0",
                    content: "통합"
                },
                {
                    value: "1",
                    content: "카탈로그번호"
                },
                {
                    value: "2",
                    content: "원부명"
                },
                {
                    value: "3",
                    content: "제조사"
                },
                {
                    value: "4",
                    content: "브랜드"
                }
            ],
            css: "control-comm sel-sort"
        },
        {
            id: "selectStep2",
            name: "selectStep2",
            type: "select",
            label: "",
            labelPosition: "left",
            labelWidth: 0,
            value: "전체",
            required: true,
            options: [
                {
                    value: "0",
                    content: "전체"
                },
                {
                    value: "1",
                    content: "카테고리내"
                },
                {
                    value: "2",
                    content: "키워드포함"
                },
                {
                    value: "3",
                    content: "키워드제외"
                },
            ],
            css: "control-comm sel-sort"
        },
        {
            id: "allKeywordInput",
            name: "input",
            type: "input",
            label: "",
            labelPosition: "left",
            icon: "dxi dxi-magnify",
            labelWidth: 0,
            required: true,
            placeholder: "검색어를 입력하세요.",
            css: "control-comm ipt-srch"
        },
        {
            id: "allKeywordSubmit",
            type: "button",
            text:"검색",
            css: "control-comm btn-srch"
        }
    ]
})

// ************************* 220211 : SR#51192 : 상단 통합 검색 키워드 탭바 추가 
// 상단 통합 검색 키워드 추가 TABBAR
export var wrapKeywordAdd = new dhx.Tabbar(null, {
    css: "dhx_widget--bordered",
    mode: "top",
    tabAutoWidth: false,
    closable: true,
    noContent: true,
    /* views: [
        { tab: "-제외키워드", id:"keyword-1" },
        { tab: "-제외키워드", id:"keyword-2" },
        { tab: "+포함키워드", id:"keyword-3" },
        { tab: "-키워드", id:"keyword-4" },
        { tab: "+포함키워드", id:"keyword-5" },
        { tab: "-키워드", id:"keyword-6" },
        { tab: "-키워드", id:"keyword-7" },
        { tab: "-키워드", id:"keyword-8" },
        { tab: "-키워드", id:"keyword-9" },
        { tab: "-키워드", id:"keyword-10" },
        { tab: "-키워드", id:"keyword-11" },
    ], */
    css: "keyword_list_all"
})

/********************************* 
 * 참고 : 상단 통합 검색 키워드 추가 기능입니다.
*********************************/
// 검색 폼 위젯 이벤트 : 참고(https://docs.dhtmlx.com/suite/form/api/input/input_change_event/)
// api 참고하여 적절하게 사용해주세요
$(function(){
    $("#allKeywordInput").keyup(function(e){
        if(e.key === 'Enter' || e.keyCode === 13){
            wrapKeywordSubmit();
        }
    })

    // 추가된 키워드 클릭(활성/비활성 토글)
    $(".keyword_list_all, .keyword_list").on("click", ".dhx_tabbar-tab", function(e){
        if(!$(this).hasClass("is-disabled")){ // 비활성
            $(this).addClass("is-disabled");
        }else{ // 활성
            $(this).removeClass("is-disabled");
        }
    })
})
wrapSrchControll.getItem("allKeywordSubmit").events.on("click", function(e) {
    wrapKeywordSubmit();
})
function wrapKeywordSubmit(){ // 검색 키워드 서브밋
    var srchVal = wrapSrchControll.getItem("input").getValue();
    if(srchVal != ""){
        wrapAddKeyword(srchVal); 
    }else{
        wrapSrchControll.getItem("input").focus(); // 포커싱
    }
    wrapSrchControll.getItem("input").clear(); // 검색 후 초기화
}
// EP상품 키워드 추가
function wrapAddKeyword(keyword) { 
    wrapKeywordAdd.addTab({ tab: keyword }, -1); // 뒤로 추가(-1), 앞으로 추가(0)

    wrapSrchControll.getItem("input").focus(); // 포커싱
};
