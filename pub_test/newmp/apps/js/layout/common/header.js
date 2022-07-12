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

    pageUtilComponent += "                <div class=\"cateshow\">";
    pageUtilComponent += "                  <ol class=\"cate_breadcrumb\">";
    pageUtilComponent += "                      <li><span>생활,취미</span></li>";
    pageUtilComponent += "                      <li><span>생활용품</span></li>";
    pageUtilComponent += "                  </ol>";
    pageUtilComponent += "                  <div class=\"btn-group\">";
    pageUtilComponent += "                      <button type=\"button\" class=\"btn btn_show\">열기</button>";
    pageUtilComponent += "                  </div>";
    pageUtilComponent += "                </div>";

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

// 서브페이지 > 카테고리 노출
export var menuTabComponent = "";
    menuTabComponent += "<div class=\"pageutil\">";
    menuTabComponent += "    <div class=\"container-fluid\">";
    menuTabComponent += "      <div class=\"row\">";
    menuTabComponent += "            <div class=\"col-12\">";
    menuTabComponent += "                <div class=\"cateshow\">";
    menuTabComponent += "                  <ol class=\"cate_breadcrumb\">";
    menuTabComponent += "                      <li><span>생활,취미</span></li>";
    menuTabComponent += "                      <li><span>생활용품</span></li>";
    menuTabComponent += "                  </ol>";
    menuTabComponent += "                  <div class=\"btn-group\">";
    menuTabComponent += "                      <button type=\"button\" class=\"btn btn_show\">열기</button>";
    menuTabComponent += "                  </div>";
    menuTabComponent += "                </div>";
    menuTabComponent += "            </div>";
    menuTabComponent += "        </div>";
    menuTabComponent += "    </div>";
    menuTabComponent += "</div>";

// 서브페이지 > 2뎁스 메뉴 
// 페이지 진입시 해당 페이지 활성화해 주세요. : class="is-on"
export var cateMenuComponent = "";
    cateMenuComponent += "<div class=\"pagetabs\">";
    cateMenuComponent += "    <div class=\"tabs\">";
    cateMenuComponent += "      <ul class=\"tablist\">";
    cateMenuComponent += "          <li><a href=\"#\">카테고리 Admin</a></li>";
    cateMenuComponent += "          <li><a href=\"./spec_admin.html\">상세검색(스마트파인더)</a></li>";
    cateMenuComponent += "          <li><a href=\"./attr_admin.html\">속성 Admin</a></li>";
    cateMenuComponent += "          <li><a href=\"#\">조건(속성)추출</a></li>";
    cateMenuComponent += "          <li><a href=\"./all_ingredient_admin.html\">전성분</a></li>";
    cateMenuComponent += "          <li class=\"is-on\"><a href=\"./group_condition_admin.html\">그룹조건</a></li>";
    cateMenuComponent += "          <li><a href=\"#\">카테고리 재분류</a></li>";
    cateMenuComponent += "      </ul>";
    cateMenuComponent += "    </div>";
    cateMenuComponent += "</div>";


// 메인페이지 우측 > 레이아웃 변경
export var changeViewBtn = "";
    changeViewBtn += "<div class=\"change_view\">";
    changeViewBtn += "  <button class=\"btn_change\">show</button>";
    changeViewBtn += "</div>";

// 메인페이지 우측 > 레이아웃 레이어 HTML
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

// 메인페이지 우측 > 레이어 위젯
var dhxWindow = new dhx.Window({
    title: "화면 유형 설정",
    closable: false,
    css: "lay_changeview",
    html: layChangeCont
});

// 메인페이지 우측 > 위젯 열기
$(document).on("click", ".btn_change", function(){
    dhxWindow.show();
})

// 메인페이지 우측 > 레이아웃 선택 
var loadSt = false; // 로딩 상태
var layoutNum = 1;
$(document).on("click", ".sel_layout>ul>li", function(){
    var _this = $(this);        
    
        _this.addClass("is-on").siblings("li").removeClass("is-on");
        layoutNum = _this.find("button").data("layout");
})
// 메인페이지 우측 > 레이아웃 변경
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