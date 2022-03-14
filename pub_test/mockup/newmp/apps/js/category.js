var sidebar = new dhx.Sidebar(null, {
    css: "asidebox",
    width: "240px"
})

// 사이드바 토글 버튼 추가
sidebar.data.add({
    id: "toggle",
    css: "toggle-button",
    icon: "mdi mdi-backburger",
});

// 사용자정보& 카테고리 목록 추가
sidebar.data.add({
    type: "customHTML",
    id: "categoryWrap",
    css: "asidebox_inner",
    html:
        "<div class=\"userbox\">" +
            "<p class=\"tx_nm\"><em>이재환(banchick)</em> 님</p>" +
            "<button type=\"button\" class=\"btn-logout\" onclick=\"$('.login__wrap').fadeIn();\">로그아웃</button>" +
        "</div>" + 

        "<div class=\"aside_inner\">" +
            "<div class=\"categorybox\">" +
                "<div class=\"acc-section\">" +
                    "<div class=\"acc-name\">" +
                        "대카테고리" +
                        "<p class=\"tx_sel\"><span>생활,취미</span> <em>(17%)</em></p>" +
                    "</div>" +
                    "<div class=\"acc-content\">" +
                        "<ul class=\"cate_list\">" +
                            /*
                                is-mine : 담당 카테고리
                                is-shown : 카테고리 노출
                                is-on : 선택된 카테고리
                            */
                            "<li class=\"is-mine is-on\"><a><span>생활,취미</span> <em>(17%)</em></a></li>" +
                            "<li><a><span>영상,디카</span> <em>(11%)</em></a></li>" +
                            "<li><a><span>디지털</span> <em>(7%)</em></a></li>" +
                            "<li><a><span>컴퓨터</span> <em>(2%)</em></a></li>" +
                            "<li><a><span>생활가전</span> <em>(5%)</em></a></li>" +
                            "<li><a><span>주방가전</span> <em>(3.5%)</em></a></li>" +
                            "<li><a><span>부품</span> <em>(2%)</em></a></li>" +
                            "<li><a><span>화장품</span> <em>(19%)</em></a></li>" +
                            "<li><a><span>스포츠</span> <em>(21%)</em></a></li>" +
                            "<li><a><span>유아,완구</span> <em>(2.2%)</em></a></li>" +
                            "<li><a><span>가구</span> <em>(3%)</em></a></li>" +
                            "<li><a><span>패션,잡화</span> <em>(6%)</em></a></li>" +
                            "<li><a><span>식품</span> <em>(12%)</em></a></li>" +
                            "<li><a><span>문구,사무</span> <em>(1.6%)</em></a></li>" +
                            "<li><a><span>공구,자동차</span> <em>(18%)</em></a></li>" +
                            "<li><a><span>액세서리</span> <em>(23%)</em></a></li>" +
                            "<li><a><span>계절가전</span> <em>(18%)</em></a></li>" +
                            "<li><a><span>명품관</span> <em>(13%)</em></a></li>" +
                            "<li><a><span>메인배너</span> <em>(14%)</em></a></li>" +
                            "<li><a><span>여행</span> <em>(15%)</em></a></li>" +
                            "<li><a><span>꽃배달</span> <em>(16%)</em></a></li>" +
                            "<li><a><span>도서</span> <em>(11%)</em></a></li>" +
                            "<li><a><span>음반,기타</span> <em>(10%)</em></a></li>" +
                        "</ul>" +

                        "<button type=\"button\" class=\"btn-expand\">대카테 전체보기</button>" +
                        "<button type=\"button\" class=\"btn-fold\">담당 카테고리 보기</button>" +
                    "</div>" +
                "</div>" +
                
                "<div class=\"acc-section\">" +
                    "<div class=\"acc-name\">" +
                        "중카테고리" +
                        "<p class=\"tx_sel\"><span>생활용품</span> <em>(12%)</em></p>" +
                        "</div>" +
                    "<div class=\"acc-content\">" +
                        "<ul class=\"cate_list\">" +
                            "<li class=\"is-mine\"><a><span>드론/피규어/키덜트</span> <em>(12%)</em></a></li>" +
                            "<li class=\"is-mine\"><a><span>모바일쿠폰/상품권</span> <em>(1%)</em></a></li>" +
                            "<li class=\"is-mine is-on\"><a><span>생활용품</span> <em>(5%)</em></a></li>" +
                            "<li><a><span>★관리용</span> <em>(6%)</em></a></li>" +
                            "<li><a><span>구강/욕실용품</span> <em>(2%)</em></a></li>" +
                            "<li><a><span>세탁/청소용품</span> <em>(3%)</em></a></li>" +
                            "<li><a><span>의료/실버용품</span> <em>(9%)</em></a></li>" +
                            "<li><a><span>성인용품</span> <em>(5%)</em></a></li>" +
                            "<li><a><span>반려동물용품</span> <em>(16)</em></a></li>" +
                            "<li><a><span>악기/디지털피아노</span> <em>(18%)</em></a></li>" +
                            "<li><a><span>주방용품</span> <em>(12.3%)</em></a></li>" +
                        "</ul>" +

                        "<button type=\"button\" class=\"btn-expand\">중카테 전체보기</button>" +
                        "<button type=\"button\" class=\"btn-fold\">담당 카테고리 보기</button>" +
                    "</div>" +
                "</div>" +

                "<div class=\"acc-section\">" +
                    "<div class=\"acc-name\">" +
                        "소카테고리" +
                        "<p class=\"tx_sel\"></p>" +
                    "</div>" +
                    "<div class=\"acc-content\">" +
                        "<ul class=\"cate_list\">" +
                            "<li class=\"is-shown\"><a><span>샴푸/헤어케어</span> <em>(11%)</em></a></li>" +
                            "<li class=\"is-shown\"><a><span>화장지</span> <em>(18%)</em></a></li>" +
                            "<li class=\"is-shown\"><a><span>세제/섬유유연제</span> <em>(12%)</em></a></li>" +
                            "<li class=\"is-shown\"><a><span>생리대/성인기저귀</span> <em>(13%)</em></a></li>" +
                            "<li class=\"is-shown\"><a><span>제습/방향/탈취</span> <em>(15%)</em></a></li>" +
                        "</ul>" +
                    "</div>" +
                "</div>" +

                "<div class=\"acc-section\">" +
                    "<div class=\"acc-name\">" +
                        "미카테고리" +
                        "<p class=\"tx_sel\"></p>" +
                    "</div>" +
                    "<div class=\"acc-content\">" +
                        "<ul class=\"cate_list\">" +
                            "<li class=\"is-shown\"><a><span>샴푸</span> <em>(17%)</em></a></li>" +
                            "<li class=\"is-shown\"><a><span>린스/컨디셔너</span> <em>(7%)</em></a></li>" +
                            "<li class=\"is-shown\"><a><span>트리트먼트</span> <em>(2%)</em></a></li>" +
                            "<li class=\"is-shown\"><a><span>에센스/오일/팩</span> <em>(3%)</em></a></li>" +
                            "<li class=\"is-shown\"><a><span>헤어케어세트</span> <em>(8%)</em></a></li>" +
                            "<li class=\"is-shown\"><a><span>파마약</span> <em>(16%)</em></a></li>" +
                            "<li class=\"is-shown\"><a><span>염색약</span> <em>(23%)</em></a></li>" +
                            "<li class=\"is-shown\"><a><span>헤어왁스</span> <em>(2%)</em></a></li>" +
                            "<li class=\"is-shown\"><a><span>헤어스프레이</span> <em>(3%)</em></a></li>" +
                            "<li class=\"is-shown\"><a><span>헤어무스</span> <em>(4%)</em></a></li>" +
                            "<li class=\"is-shown\"><a><span>헤어젤</span> <em>(2%)</em></a></li>" +
                            "<li class=\"is-shown\"><a><span>헤어글레이즈</span> <em>(1%)</em></a></li>" +
                        "</ul>" +
                    "</div>" +
                "</div>" +
            "</div>" +
        "</div>" +

        "<div class=\"selcate\">" + 
            "<p class=\"tx_tit\">카테고리</p>" +
            "<ul>" +
                "<li>생활,취미 (17%)</li>" +
                "<li>생활용품 (12%)</li>" +
            "</ul>" +
        "</div>"
});

// 사용자정보& 카테고리 목록 추가
sidebar.data.add({
    type: "customHTML",
    id: "similarbtn",
    css: "similar_btn",
    html:
        "<div class=\"form-chk\">" +
            "<input type=\"checkbox\" id=\"similarModel\" class=\"input--checkbox-item\"><label for=\"similarModel\">유사모델 포함</label>" +
        "</div>"
});

// 사용자정보& 카테고리 목록 추가
sidebar.data.add({
    type: "customHTML",
    id: "collapse",
    css: "collapse_btn",
    html:
        "<div class=\"btnbox\">" +
            "<a class=\"btn_show\">열기</a>" +
        "</div>"
});


// 사이드바 토글
sidebar.events.on("click", function (id) {
    if (id === "toggle") { // 사이드바 토글
        sidebar.toggle();

        if (!sidebar.config.collapsed) { // 확장
            layout.getCell("sidebar").config.width = "240px";
            layout.getCell("sidebar").expand();
        }
        else { // 축소
            layout.getCell("sidebar").config.width = "40px";
            layout.getCell("sidebar").collapse();
        }
    }else if(id === "collapse"){ // 카테고리 열기
        sidebar.collapse();
        layout.getCell("sidebar").config.width = "40px";
        layout.getCell("sidebar").collapse();

        cateInput();

        layout.paint();
    }
});

// 카테고리명 노출
var cateInput = function(){
    var cateArr = []; // 선택한 카테고리 저장
    var selCate = $(".acc-section .tx_sel");
    var showCate = $(".cate_breadcrumb");
    var collapseShowCate = $(".selcate ul");

    showCate.find("li").detach(); // li 삭제
    collapseShowCate.find("li").detach(); // li 삭제
    
    $.each(selCate, function(i, val){
        var valText = val;
        cateArr[i] = $(valText).find("span").text();

        if(cateArr[i] != ""){
            showCate.append("<li>"+cateArr[i]+"</li>") // li 추가
            collapseShowCate.append("<li>"+cateArr[i]+"</li>") // li 추가
        }
    });
}
