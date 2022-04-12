/********************************* 
 * 대량정제 퍼블용 JS
 * - DHTMLX v.7.1.4
 * - BOOTSTRAP v4.0.0
 * - HTML 컴퍼넌트, DHTML위젯(GRID, LIST, FORM 등)  
 
 ※ 참고
 * 레이아웃, GRID 등 ID 값 퍼블/개발 동일하게 사용할 것을 권장합니다. 
 * ID 변경될 경우, 공유해주세요. (해당 ID에 맞게 css/js 사용되고 있습니다)
 * data 목록은 가짜데이터 입니다. (퍼블용)
 * collapse 되는 영역은 위젯, 그리드 등 attach 했습니다.
 * collapse 되지 않는 영역은 일부 HTML 컴퍼넌트, 위젯 혼용했습니다.
*********************************/

// 연관상품 가짜 데이터
var gridData = [
    {"mdNum": 55633173, "mdName": "20W 정품 USB-C타입 고속 충전 아답터(MICRO)", "mdViewName": "액세서리", "mdMake": "Apple", "cnt": 2462}, 
    {"mdNum": 55633173, "mdName": "20W 정품 USB-C타입 고속 충전 아답터(MICRO)", "mdViewName": "충전어댑터", "mdMake": "Apple", "cnt": 2462}, 
    {"mdNum": 55633173, "mdName": "20W 정품 USB-C타입 고속 충전 아답터(MICRO)", "mdViewName": "충전어댑터", "mdMake": "Apple", "cnt": 2462}, 
    {"mdNum": 55633173, "mdName": "20W 정품 USB-C타입 고속 충전 아답터(MICRO)20W 정품 USB-C타입 고속 충전 아답터(MICRO)20W 정품 USB-C타입 고속 충전 아답터(MICRO)", "mdViewName": "충전어댑터", "mdMake": "Apple", "cnt": 2462}, 
    {"mdNum": 55633173, "mdName": "20W 정품 USB-C타입 고속 충전 아답터(MICRO)", "mdViewName": "충전어댑터", "mdMake": "Apple", "cnt": 2462}, 
    {"mdNum": 55633173, "mdName": "20W 정품 USB-C타입 고속 충전 아답터(MICRO)20W 정품 USB-C타입 고속 충전 아답터(MICRO)", "mdViewName": "충전어댑터", "mdMake": "Apple", "cnt": 2462}, 
    {"mdNum": 55633173, "mdName": "20W 정품 USB-C타입 고속 충전 아답터(MICRO)", "mdViewName": "충전어댑터", "mdMake": "Apple", "cnt": 2462}, 
    {"mdNum": 55633173, "mdName": "20W 정품 USB-C타입 고속 충전 아답터(MICRO)", "mdViewName": "충전어댑터", "mdMake": "Apple", "cnt": 2462}, 
    {"mdNum": 55633173, "mdName": "20W 정품 USB-C타입 고속 충전 아답터(MICRO)", "mdViewName": "충전어댑터", "mdMake": "Apple", "cnt": 2462},
    {"mdNum": 55633173, "mdName": "20W 정품 USB-C타입 고속 충전 아답터(MICRO)20W 정품 USB-C타입 고속 충전 아답터(MICRO)", "mdViewName": "충전어댑터", "mdMake": "Apple", "cnt": 2462}, 
    {"mdNum": 55633173, "mdName": "20W 정품 USB-C타입 고속 충전 아답터(MICRO)", "mdViewName": "충전어댑터", "mdMake": "Apple", "cnt": 2462}, 
    {"mdNum": 55633173, "mdName": "20W 정품 USB-C타입 고속 충전 아답터(MICRO)", "mdViewName": "충전어댑터", "mdMake": "Apple", "cnt": 2462}, 
    {"mdNum": 55633173, "mdName": "20W 정품 USB-C타입 고속 충전 아답터(MICRO)", "mdViewName": "충전어댑터", "mdMake": "Apple", "cnt": 2462},
    {"mdNum": 55633173, "mdName": "20W 정품 USB-C타입 고속 충전 아답터(MICRO)20W 정품 USB-C타입 고속 충전 아답터(MICRO)", "mdViewName": "충전어댑터", "mdMake": "Apple", "cnt": 2462}, 
    {"mdNum": 55633173, "mdName": "20W 정품 USB-C타입 고속 충전 아답터(MICRO)", "mdViewName": "충전어댑터", "mdMake": "Apple", "cnt": 2462}, 
    {"mdNum": 55633173, "mdName": "20W 정품 USB-C타입 고속 충전 아답터(MICRO)", "mdViewName": "충전어댑터", "mdMake": "Apple", "cnt": 2462}, 
    {"mdNum": 55633173, "mdName": "20W 정품 USB-C타입 고속 충전 아답터(MICRO)", "mdViewName": "충전어댑터", "mdMake": "Apple", "cnt": 2462},
]
// 연관상품 넘버링(순서)
var gridDataLength = gridData.length;
for (var i = 0; i < gridDataLength; i++) {
    var row = gridData[i];
    row.num = i+1;
}

// 1000단위 컴마
var numberFormat = function(value) {
    var regexp = /\B(?=(\d{3})+(?!\d))/g;
    return value == null ? '' : String(value).replace(regexp, ',');
}

// 헤더 컴퍼넌트 HTML
var headerComponent = `
    <header id="header" class="related_header">
        <h1>연관상품(소모품) 관리 : <span class="tx_cate">프린터</span></h1>
        <div class="admin_control">
            <ul class="exlink_list">
            <li><a href="#" target="_blank" title="CM 주요 관리 지표">CM 주요 관리 지표</a></li>
            <li><a href="#" target="_blank" title="경쟁사 모니터링">경쟁사 모니터링</a></li>
            <li><a href="#" target="_blank" title="핵심 속성 입력/점검">핵심 속성 입력/점검</a></li>
            <li><a href="#" target="_blank" title="제조사[불명] 현황">제조사[불명] 현황</a></li>
            <li class="has-sub"><button title="연관상품(소모품)">연관상품(소모품)</button>
                <div class="exlink_sub">
                    <ul>
                        <li><a href="./related_products.html" target="_blank">TV</a></li>
                        <li><a href="./related_products.html" target="_blank">홈시어터</a></li>
                        <li><a href="./related_products.html" target="_blank">프로젝터/스크린</a></li>
                        <li><a href="./related_products.html" target="_blank">홈시어터/HiFi</a></li>
                        <li><a href="./related_products.html" target="_blank">영상가전 액세서리</a></li>
                        <li><a href="./related_products.html" target="_blank">주방가전</a></li>
                        <li><a href="./related_products.html" target="_blank">생활가전</a></li>
                        <li><a href="./related_products.html" target="_blank">계절가전</a></li>
                        <li><a href="./related_products.html" target="_blank">건강가전</a></li>
                        <li><a href="./related_products.html" target="_blank">미용/욕실가전</a></li>
                    </ul>
                </div>
            </li>
            </ul>
            <p class="user_log">로그인정보 <span>2021.11.12 10:27:10</span></p>
        </div>
    </header>
`;


/*********************************
 * 각 COL 그리드/리스트 생성하여 attach 합니다.
*********************************/
var accGrid, registAccGrid, originGrid, registOriginGrid; // 각 그리드 변수

// 액세서리 그리드 생성 (좌상단)
accGrid = new dhx.Grid(null, {
    columns: [
        {id: "mdNum",       header: [{ text: "모델번호", align: "center" }], align: "center", editable: false, width: 100, },
        {id: "mdName",      header: [{ text: "모델명", align: "center" }], align: "left", htmlEnable: true, editable: false, width: 500, 
            template: function (text, row, col) { 
                return "<p class=\"tx_tit_one\">"+text+"</p>"; 
            }, 
        },
        {id: "mdViewName",  header: [{ text: "전시모델명", align: "center" }], align: "left", },
        {id: "mdMake",      header: [{ text: "제조사", align: "center" }], align: "left", editable: false, },
        {id: "cnt",         header: [{ text: "CNT", align: "center" }], align: "right", editable: false, },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    data: gridData,
    editable: true,
    selection: "row",
    multiselection:true,
    keyNavigation: true,
    resizable:true,
    tooltip: false,
});

// 등록액세서리 그리드 생성 (좌하단)
registAccGrid = new dhx.Grid(null, {
    columns: [
        {id: "num",         header: [{ text: "순서", align: "center" }], align: "center", width: 60, },
        {id: "mdNum",       header: [{ text: "모델번호", align: "center" }], align: "center", editable: false, width: 100, },
        {id: "mdName",      header: [{ text: "모델명", align: "center" }], align: "left", htmlEnable: true, editable: false, width: 500, 
            template: function (text, row, col) { 
                return "<p class=\"tx_tit_one\">"+text+"</p>"; 
            }, 
        },
        {id: "mdViewName",  header: [{ text: "전시모델명", align: "center" }], align: "left", editable: false, },
        {id: "mdMake",      header: [{ text: "제조사", align: "center" }], align: "left", editable: false, },
        {id: "cnt",         header: [{ text: "CNT", align: "center" }], align: "right", editable: false, },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    data: gridData,
    editable: true,
    selection: "row",
    multiselection:false,
    keyNavigation: true,
    resizable:true,
    tooltip: false,
});

// 본품 그리드 생성 (우상단)
originGrid = new dhx.Grid(null, {
    columns: [
        {id: "mdNum",       header: [{ text: "모델번호", align: "center" }], align: "center", editable: false, width: 100, },
        {id: "mdName",      header: [{ text: "모델명", align: "center" }], align: "left", htmlEnable: true, editable: false, width: 500, 
            template: function (text, row, col) { 
                return "<p class=\"tx_tit_one\">"+text+"</p>"; 
            }, 
        },
        {id: "mdViewName",  header: [{ text: "전시모델명", align: "center" }], align: "left", },
        {id: "mdMake",      header: [{ text: "제조사", align: "center" }], align: "left", editable: false, },
        {id: "cnt",         header: [{ text: "CNT", align: "center" }], align: "right", editable: false, },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    data: gridData,
    editable: true,
    selection: "row",
    multiselection:false,
    keyNavigation: true,
    resizable:true,
    tooltip: false,
});

// 등록본품 그리드 생성 (우하단)
registOriginGrid = new dhx.Grid(null, {
    columns: [
        {id: "num",         header: [{ text: "순서", align: "center" }], align: "center", width: 60, },
        {id: "mdNum",       header: [{ text: "모델번호", align: "center" }], align: "center", editable: false, width: 100, },
        {id: "mdName",      header: [{ text: "모델명", align: "center" }], align: "left", htmlEnable: true, editable: false, width: 500, 
            template: function (text, row, col) { 
                return "<p class=\"tx_tit_one\">"+text+"</p>"; 
            }, 
        },
        {id: "mdViewName",  header: [{ text: "전시모델명", align: "center" }], align: "left", editable: false, },
        {id: "mdMake",      header: [{ text: "제조사", align: "center" }], align: "left", editable: false, },
        {id: "cnt",         header: [{ text: "CNT", align: "center" }], align: "right", editable: false, },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    data: gridData,
    editable: true,
    selection: "row",
    multiselection:false,
    keyNavigation: true,
    resizable:true,
    tooltip: false,
});

/*********************************
 * 각 COL 헤더, 풋터 FORM 생성하여 attach 합니다.
*********************************/
var resultCnt = numberFormat(1321212335); // 임의 건수
// 액세서리 상단
var accHeader = new dhx.Form(null, {
    css: "controller_related",
    padding: 0,
    width: "100%",
    cols: [
        {
            id: "accSelect",
            name: "accSelect",
            type: "select",
            label: "",
            labelPosition: "left",
            labelWidth: 0,
            value: "0",
            required: true,
            options: [
                {
                    value: "0",
                    content: "전체"
                },
                {
                    value: "1",
                    content: "분류1"
                },,
                {
                    value: "2",
                    content: "분류2"
                },
                {
                    value: "3",
                    content: "분류3"
                }
            ],
            css: "control-comm sel-sort"
        },
        {
            id: "accInput",
            name: "accInput",
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
            id: "accSubmit",
            type: "button",
            text:"액세서리 검색",
            css: "control-comm btn-srch"
        },
        {
            id: "accAllSubmit",
            type: "button",
            text:"전체",
            css: "control-comm btn-srch"
        },
        {
            id: "accResult",
            width: true,
            type: "text",
            label: "액세서리 검색결과 : ",
            width: "content",
            labelPosition: "left",
            value: resultCnt+ "건", // 건수 넣어주세요
            css: "control-comm tx_cnt"
        }
    ]
})
// 액세서리 하단
var accFooter = new dhx.Form(null, {
    css: "controller_related",
    padding: 0,
    width: "100%",
    cols: [
        {
            id: "accResult",
            width: "100%",
            type: "textarea",
            value: "",
            height: "60px",
            readOnly: true,
            css: "control-comm sel_text"
        }
    ]
})

// 등록된 액세서리 상단
var registAccHeader = new dhx.Form(null, {
    css: "controller_related",
    padding: 0,
    width: "100%",
    cols: [
        {
            id: "registAccResult",
            width: true,
            type: "text",
            label: "등록된 액세서리 리스트 : ",
            width: "content",
            labelPosition: "left",
            value: resultCnt+ "건", // 건수 넣어주세요
            css: "control-comm tx_cnt"
        }
    ]
})

// 본품 상단부
var originHeader = new dhx.Form(null, {
    css: "controller_related",
    padding: 0,
    width: "100%",
    cols: [
        {
            id: "originSelect",
            name: "originSelect",
            type: "select",
            label: "",
            labelPosition: "left",
            labelWidth: 0,
            value: "0",
            required: true,
            options: [
                {
                    value: "0",
                    content: "전체"
                },
                {
                    value: "1",
                    content: "분류1"
                },,
                {
                    value: "2",
                    content: "분류2"
                },
                {
                    value: "3",
                    content: "분류3"
                }
            ],
            css: "control-comm sel-sort"
        },
        {
            id: "originInput",
            name: "originInput",
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
            id: "originSubmit",
            type: "button",
            text:"본품 검색",
            css: "control-comm btn-srch"
        },
        {
            id: "originAllSubmit",
            type: "button",
            text:"go",
            css: "control-comm btn-srch"
        },
        {
            type: "checkbox",
            disabled: false,
            required: false,
            hidden: false,
            css: "control-comm tx_chkbox",
            text: "자동 검색"
        },
        {
            id: "accResult",
            width: true,
            type: "text",
            label: "본품 검색결과 : ",
            width: "content",
            labelPosition: "left",
            value: resultCnt+ "건", // 건수 넣어주세요
            css: "control-comm tx_cnt"
        }
    ]
})
// 본품 하단
var originFooter = new dhx.Form(null, {
    css: "controller_related originFoot",
    padding: 0,
    width: "100%",
    rows: [
        {
            cols: [
                {
                    id: "originFootMdNum",
                    name: "originFootMdNum",
                    type: "input",
                    label: "액세서리 :",
                    labelPosition: "left",
                    labelWidth: "60px",
                    required: true,
                    placeholder: "모델번호",
                    css: "control-comm ipt-mdnum"
                },
                {
                    id: "originFootMdNum2",
                    name: "originFootMdNum2",
                    type: "input",
                    labelPosition: "left",
                    labelWidth:0,
                    required: true,
                    placeholder: "모델명",
                    css: "control-comm ipt-mdname"
                },
                {
                    id: "btnAddOrigin",
                    type: "button",
                    text: "▼ 1개 추가",
                    css: "control-comm btn-addline"
                },
                {
                    id: "btnRemoveOrigin",
                    type: "button",
                    text: "△ 1개 삭제",
                    css: "control-comm btn-addline"
                },
            ]
        },
        {
            cols: [
                {
                    id: "accFootMdNum",
                    name: "accFootMdNum",
                    type: "input",
                    label: "본품 :",
                    labelPosition: "left",
                    labelWidth: "60px",
                    required: true,
                    placeholder: "모델번호",
                    css: "control-comm ipt-mdnum"
                },
                {
                    id: "accFootMdNum2",
                    name: "accFootMdNum2",
                    type: "input",
                    labelPosition: "left",
                    labelWidth:0,
                    required: true,
                    placeholder: "모델명",
                    css: "control-comm ipt-mdname"
                },
                {
                    id: "btnAddAcc",
                    type: "button",
                    text: "▼ 그룹 추가",
                    css: "control-comm btn-addline"
                },
                {
                    id: "btnRemoveAcc",
                    type: "button",
                    text: "△ 그룹 삭제",
                    css: "control-comm btn-addline"
                },
            ]
        }
        
    ]
})
// 등록된 본품 상단
var registOriginHeader = new dhx.Form(null, {
    css: "controller_related",
    padding: 0,
    width: "100%",
    cols: [
        {
            id: "registOriginResult",
            width: true,
            type: "text",
            label: "등록된 본품 리스트 : ",
            width: "content",
            labelPosition: "left",
            value: resultCnt+ "건", // 건수 넣어주세요
            css: "control-comm tx_cnt"
        }
    ]
})
// 연관상품 페이지 하단 (복사)
var relatedFooter = new dhx.Form(null, {
    css: "controller_related is-flex",
    padding: 0,
    width: "100%",
    cols: [
        {
            width: "30%",
            cols: [
                {
                    id: "allCopyInput",
                    name: "allCopyInput",
                    type: "input",
                    label: "전체 액세서리 복사",
                    labelPosition: "left",
                    labelWidth: "content",
                    required: true,
                    placeholder: "카탈로그 번호 입력",
                    css: "control-comm ipt-srch"
                },
                {
                    id: "allCopySubmit",
                    type: "button",
                    text:"그룹 입력",
                    css: "control-comm btn-srch"
                },
            ]
        },
        {
            width: "10%",
            type: "text",
            label: "▶▶▷▷",
            width: "content",
            labelPosition: "left",
            css: "control-comm tx_nonarr"
        },
        {      
            width: "30%",
            cols: [          
                {
                    id: "groupModelCopyNum",
                    name: "groupModelCopyNum",
                    type: "input",
                    disabled: true,
                    label: "",
                    labelPosition: "left",
                    labelWidth: "content",
                    required: true,
                    placeholder: "",
                    css: "control-comm ipt-srch"
                },
                {
                    id: "groupModelCopySubmit",
                    type: "button",
                    text:"복사하기",
                    css: "control-comm btn-copy"
                },
            ]
        },            
        {
            width: "30%",
            type: "button",
            text: "ENURI ▲",
            id: "enuriUpBtn",
            align:"right",
            css: "control-comm btn-enuriup"
        },
    ]
})
// 카탈로그 번호 입력
relatedFooter.getItem("allCopySubmit").events.on("click", function(evt){
    var copyTxt = relatedFooter.getItem("allCopyInput").getValue();
    if(copyTxt != ""){
        // 그룹입력 버튼 클릭 입력된 카탈로그 번호 매칭된 그룹모델번호 입력
        relatedFooter.getItem("groupModelCopyNum").setValue("입력된 카탈로그의 그룹모델번호")
    }    
})
// 입력된 카탈로그의 그룹모델번호 복사
relatedFooter.getItem("groupModelCopySubmit").events.on("click", function(evt){
    var copyTxt = relatedFooter.getItem("groupModelCopyNum").getValue();
    // 복사 
})

/*********************************
 * 가운데 저장 버튼 폼 생성하여 attach 합니다.
*********************************/
var topSaveBtn = new dhx.Form(null, {
    css: "btn_save_box",
    padding: 0,
    width: "100%",
    rows: [
        {
            id: "saveAcc",
            type: "button",
            text:"◀◀ 저장",
            css: "control-comm btn-save"
        },
        {
            id: "saveOrigin",
            type: "button",
            text:"▷▷ 저장",
            css: "control-comm btn-save"
        },
    ]
})
topSaveBtn.getItem("saveAcc").events.on("click", function(evt){
    alert("액세서리 저장")
})
topSaveBtn.getItem("saveOrigin").events.on("click", function(evt){
    alert("본품 저장")
})

var bottomSaveBtn = new dhx.Form(null, {
    css: "btn_save_box",
    padding: 0,
    width: "100%",
    rows: [
        {
            id: "saveRegistAcc",
            type: "button",
            text:"◀◀ 저장",
            css: "control-comm btn-save"
        },
        {
            id: "saveRegistOrigin",
            type: "button",
            text:"▷▷ 저장",
            css: "control-comm btn-save"
        },
    ]
})
bottomSaveBtn.getItem("saveRegistAcc").events.on("click", function(evt){
    alert("등록된 액세서리 저장")
})
bottomSaveBtn.getItem("saveRegistOrigin").events.on("click", function(evt){
    alert("등록된 본품 저장")
})

/*********************************
 * 전체 레이아웃 생성
*********************************/
var config = {
    type: "line", // space, wide, line
    width:"100%",
    maxWidth:"100%",
    rows: [
        {
            // 상단 툴바
            id: "toolbar",
            height: "40px",
            html: headerComponent,
            collapsable: false
        },
        {
            // 컨텐츠 레이아웃 
            type: "space",
            width:"100%",
            cols: [
                {
                    // 좌측
                    type:"line",
                    id: "contentLeft",
                    width: "calc(50% - 70px)",
                    rows:[
                        {
                            // 액세서리 행
                            id: "",
                            width: "100%",
                            height: "55%",
                            customScroll: true,
                            rows : [
                                {
                                    // 액세서리 HEADER
                                    id: "accHeader",
                                    height: "44px"
                                },
                                {
                                    // 액세서리 GRID
                                    id: "accGrid",
                                    height:"calc(100% - 124px)"
                                },
                                {
                                    // 선택한 모델 텍스트
                                    id: "accFooter",
                                    height: "80px"
                                }
                            ]
                        },
                        {
                            // 등록액세서리 행
                            id: "",
                            width: "100%",
                            height: "45%",
                            customScroll: true,
                            rows : [
                                {
                                    // 등록액세서리 HEADER
                                    id: "registAccHeader",
                                    height: "44px"
                                },
                                {
                                    // 등록액세서리 GRID
                                    id: "registAccGrid",
                                    height:"calc(100% - 44px)"
                                }
                            ]
                        },
                    ]
                    
                },
                {
                    type:"line",
                    id:"saveTools",
                    width:"100px",
                    rows:[
                        {
                            id: "topSaveBtn",
                            height:"55%",
                        },
                        {
                            id: "bottomSaveBtn",
                            height:"45%",
                        }
                    ]
                },
                {
                    // 우측
                    type:"line",
                    id: "contentRight",
                    width: "calc(50% - 70px)",
                    rows:[
                        {
                            // 본품 행
                            id: "",
                            width: "100%",
                            height: "55%",
                            customScroll: true,
                            rows : [
                                {
                                    // 본품 HEADER
                                    id: "originHeader",
                                    height: "44px"
                                },
                                {
                                    // 본품 GRID
                                    id: "originGrid",
                                    height:"calc(100% - 124px)"
                                },
                                {
                                    // 선택한 모델&추가,삭제
                                    id: "originFooter",
                                    height: "80px"
                                }
                            ]
                        },
                        {
                            // 등록본품 행
                            id: "",
                            width: "100%",
                            height: "45%",
                            customScroll: true,
                            rows : [
                                {
                                    // 등록본품 HEADER
                                    id: "registOriginHeader",
                                    height: "44px"
                                },
                                {
                                    // 등록본품 GRID
                                    id: "registOriginGrid",
                                    height:"calc(100% - 44px)"
                                }
                            ]
                        },
                    ]
                    
                },
            ],
        },
        {
            type: "line",
            width:"100%",
            height: "44px",
            rows: [
                {
                    id:"relatedFooter",
                    css: ""
                }
            ]
        }
    ]
};


/*********************************
 * 생성된 레이아웃에 ID별로 attach합니다.
*********************************/
var layout = new dhx.Layout("relatedPrdcLayout", config);

    layout.getCell("accGrid").attach(accGrid); // 액세서리 GRID
    layout.getCell("registAccGrid").attach(registAccGrid); // 등록액세서리 GRID
    layout.getCell("originGrid").attach(originGrid); // 본품 GRID
    layout.getCell("registOriginGrid").attach(registOriginGrid); // 등록본품 GRID

    layout.getCell("accHeader").attach(accHeader); // 액세서리 상단
    layout.getCell("accFooter").attach(accFooter); // 액세서리 하단
    layout.getCell("registAccHeader").attach(registAccHeader); // 등록된 액세서리 상단
    layout.getCell("originHeader").attach(originHeader); // 본품 상단
    layout.getCell("originFooter").attach(originFooter); // 본품 하단
    layout.getCell("registOriginHeader").attach(registOriginHeader); // 등록된 본품 상단

    layout.getCell("relatedFooter").attach(relatedFooter); // 연관상품 페이지 하단

    layout.getCell("topSaveBtn").attach(topSaveBtn); // 가운데 저장 버튼 상단
    layout.getCell("bottomSaveBtn").attach(bottomSaveBtn); // 가운데 저장 버튼 하단
    
   