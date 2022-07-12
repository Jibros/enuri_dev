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

/*********************************
 * 서브 > 연관상품 컨텐츠
 *********************************/

// 1000단위 컴마
var numberFormat = function(value) {
    var regexp = /\B(?=(\d{3})+(?!\d))/g;
    return value == null ? '' : String(value).replace(regexp, ',');
}


/*********************************
 * 각 COL 그리드/리스트 생성하여 attach 합니다.
*********************************/
var accGrid, registAccGrid, originGrid, registOriginGrid; // 각 그리드 변수

// 액세서리 그리드 생성 (좌상단)
accGrid = new dhx.Grid(null, {
    columns: [
        {id: "mdNum",       header: [{ text: "모델번호", align: "center" }], align: "center", editable: false, width: 70, },
        {id: "mdName",      header: [{ text: "액세서리 모델명", align: "center" }], align: "left", htmlEnable: true, editable: false, width: 440, 
            template: function (text, row, col) { 
                return "<p class=\"tx_tit_one\">"+text+"</p>"; 
            }, 
        },
        {id: "mdViewName",  header: [{ text: "전시모델명", align: "center" }], align: "left", width: 130, },
        {id: "mdMake",      header: [{ text: "제조사", align: "center" }], align: "left", editable: false, },
        {id: "registDate",      header: [{ text: "등록일", align: "center" }], align: "left", editable: false, width:80 },
        {id: "cnt",         header: [{ text: "CNT", align: "center" }], align: "right", editable: false, width:55, },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    //data: gridData,
    //data: accData,
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
        {id: "num",         header: [{ text: "순서", align: "center" }], align: "center", width: 40, },
        {id: "mdNum",       header: [{ text: "모델번호", align: "center" }], align: "center", editable: false, width: 70, },
        {id: "mdName",      header: [{ text: "등록된 액세서리 모델명", align: "center" }], align: "left", htmlEnable: true, editable: false, width: 400, 
            template: function (text, row, col) { 
                return "<p class=\"tx_tit_one\">"+text+"</p>"; 
            }, 
        },
        {id: "mdViewName",  header: [{ text: "전시모델명", align: "center" }], align: "left", editable: false, width: 130,  },
        {id: "mdMake",      header: [{ text: "제조사", align: "center" }], align: "left", editable: false, },
        {id: "registDate",      header: [{ text: "등록일", align: "center" }], align: "left", editable: false, width:80 },
        {id: "cnt",         header: [{ text: "CNT", align: "center" }], align: "right", editable: false, width:55, },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    //data: gridData,
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
        {id: "mdNum",       header: [{ text: "모델번호", align: "center" }], align: "center", editable: false, width: 70, },
        {id: "mdName",      header: [{ text: "본품 모델명", align: "center" }], align: "left", htmlEnable: true, editable: false, width: 440, 
            template: function (text, row, col) { 
                return "<p class=\"tx_tit_one\">"+text+"</p>"; 
            }, 
        },
        {id: "mdViewName",  header: [{ text: "전시모델명", align: "center" }], align: "left", width: 130, },
        {id: "mdMake",      header: [{ text: "제조사", align: "center" }], align: "left", editable: false, },
        {id: "registDate",      header: [{ text: "등록일", align: "center" }], align: "left", editable: false, width:80 },
        {id: "cnt",         header: [{ text: "CNT", align: "center" }], align: "right", editable: false, width:55, },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    //data: gridData,
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
        {id: "num",         header: [{ text: "순서", align: "center" }], align: "center", width: 40, },
        {id: "mdNum",       header: [{ text: "모델번호", align: "center" }], align: "center", editable: false, width: 70, },
        {id: "mdName",      header: [{ text: "등록된 본품 모델명", align: "center" }], align: "left", htmlEnable: true, editable: false, width: 400, 
            template: function (text, row, col) { 
                return "<p class=\"tx_tit_one\">"+text+"</p>"; 
            }, 
        },
        {id: "mdViewName",  header: [{ text: "전시모델명", align: "center" }], align: "left", editable: false, width: 130, },
        {id: "mdMake",      header: [{ text: "제조사", align: "center" }], align: "left", editable: false, },
        {id: "registDate",      header: [{ text: "등록일", align: "center" }], align: "left", editable: false, width:80 },
        {id: "cnt",         header: [{ text: "CNT", align: "center" }], align: "right", editable: false, width:55, },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    //data: gridData,
    editable: true,
    selection: "row",
    multiselection:false,
    keyNavigation: true,
    resizable:true,
    tooltip: false,
});

// 가짜 데이터 호출
const dataUrl = "./apps/js/data/relatedPrdcData.json"
fetch(dataUrl)
    .then((response) => response.json())
    .then((gridData) => {        
        accGrid.data.parse(gridData.accessory);
        originGrid.data.parse(gridData.origin);  
        registAccGrid.data.parse(gridData.registAcc);
        registOriginGrid.data.parse(gridData.registOrigin);

        numbering(gridData.registAcc);
        numbering(gridData.registOrigin);
    }
)

// 그리드 순서 매김
var numbering = function(data){
    var len = data.length;

    for (var i = 0; i < len; i++) {
        var row = data[i];
        row.num = i+1;
    }
}

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
                    content: "카테고리내"
                },,
                {
                    value: "2",
                    content: "키워드 포함"
                },
                {
                    value: "3",
                    content: "키워드 제외"
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
            label: "검색결과 : ",
            width: "content",
            labelPosition: "left",
            value: resultCnt+ "건", // 건수 넣어주세요
            css: "control-comm tx_cnt"
        },
        {
            id: "btnSave",
            type: "button",
            text:"전시모델명 저장",
            css: "control-comm btn-related--save"
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
            label: "등록된 액세서리 : ",
            width: "content",
            labelPosition: "left",
            value: resultCnt+ "건", // 건수 넣어주세요
            css: "control-comm tx_cnt"
        },
        {
            id: "btnSave",
            type: "button",
            text:"순서 저장",
            css: "control-comm btn-related--save"
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
                    content: "카테고리내"
                },,
                {
                    value: "2",
                    content: "키워드 포함"
                },
                {
                    value: "3",
                    content: "키워드 제외"
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
            label: "검색결과 : ",
            width: "content",
            labelPosition: "left",
            value: resultCnt+ "건", // 건수 넣어주세요
            css: "control-comm tx_cnt"
        },
        {
            id: "btnSave",
            type: "button",
            text:"전시모델명 저장",
            css: "control-comm btn-related--save"
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
                    //required: true,
                    disabled: true,
                    placeholder: "모델번호",
                    css: "control-comm ipt-mdnum"
                },
                {
                    id: "originFootMdNum2",
                    name: "originFootMdNum2",
                    type: "input",
                    labelPosition: "left",
                    labelWidth:0,
                    //required: true,
                    disabled: true,
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
                    //required: true,
                    disabled: true,
                    placeholder: "모델번호",
                    css: "control-comm ipt-mdnum"
                },
                {
                    id: "accFootMdNum2",
                    name: "accFootMdNum2",
                    type: "input",
                    labelPosition: "left",
                    labelWidth:0,
                    //required: true,
                    disabled: true,
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
            label: "등록된 본품 : ",
            width: "content",
            labelPosition: "left",
            value: resultCnt+ "건", // 건수 넣어주세요
            css: "control-comm tx_cnt"
        },
        {
            id: "btnSave",
            type: "button",
            text:"순서 저장",
            css: "control-comm btn-related--save"
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
                    placeholder: "본품 모델번호 입력",
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
        /* {
            id: "saveAcc",
            type: "button",
            text:"◀전시모델명 저장",
            css: "control-comm btn-save"
        },
        {
            id: "saveOrigin",
            type: "button",
            text:"전시모델명 저장▷",
            css: "control-comm btn-save"
        }, */
        {
            // X 교차 이미지 
            id: "a",
            type: "text",
            value:"X",
            width: "100%",
            css: "img_cross"
        }
    ]
})/* 
topSaveBtn.getItem("saveAcc").events.on("click", function(evt){
    alert("액세서리 저장")
})
topSaveBtn.getItem("saveOrigin").events.on("click", function(evt){
    alert("본품 저장")
}) */
/* 
var bottomSaveBtn = new dhx.Form(null, {
    css: "btn_save_box",
    padding: 0,
    width: "100%",
    rows: [
        {
            id: "saveRegistAcc",
            type: "button",
            text:"◀순서 저장",
            css: "control-comm btn-save"
        },
        {
            id: "saveRegistOrigin",
            type: "button",
            text:"순서 저장▷",
            css: "control-comm btn-save"
        },
    ]
})
bottomSaveBtn.getItem("saveRegistAcc").events.on("click", function(evt){
    alert("등록된 액세서리 저장")
})
bottomSaveBtn.getItem("saveRegistOrigin").events.on("click", function(evt){
    alert("등록된 본품 저장")
}) */

/*********************************
 * 전체 레이아웃 생성
*********************************/
var config = {
    type: "line", // space, wide, line
    width:"100%",
    maxWidth:"100%",
    rows: [
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
                                    // 액세서리 : 키워드 영역
                                    id:"accKeyword",
                                    height: "44px"
                                },
                                {
                                    // 액세서리 GRID
                                    id: "accGrid",
                                    height:"calc(100% - 168px)"
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
                            height:"100%",
                        }/* ,
                        {
                            id: "bottomSaveBtn",
                            height:"45%",
                        } */
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
                                    // 본품 : 키워드 영역
                                    id:"originKeyword",
                                    height: "44px"
                                },
                                {
                                    // 본품 GRID
                                    id: "originGrid",
                                    height:"calc(100% - 168px)"
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

/************************************************************************************************** 2022.06.15 액세서리,본품 상단 검색 키워드 추가 */
/**************************************************************************************************  레이아웃 생성 전 위젯 생성해 주세요. */
// 액세서리 검색 키워드 추가 TABBAR
var accKeyword = new dhx.Tabbar(null, {
    css: "dhx_widget--bordered",
    mode: "top",
    tabAutoWidth: false,
    closable: true,
    noContent: true,
    /* views: [
        { tab: "-제외키워드", id:"keyword-1" },
    ], */
    css: "keyword_list"
});
// 본품 검색 키워드 추가 TABBAR
var originKeyword = new dhx.Tabbar(null, {
    css: "dhx_widget--bordered",
    mode: "top",
    tabAutoWidth: false,
    closable: true,
    noContent: true,
    /* views: [
        { tab: "-제외키워드", id:"keyword-1" },
    ], */
    css: "keyword_list"
});



/*********************************
 * 생성된 레이아웃에 ID별로 attach합니다.
*********************************/
export var contentLayout = new dhx.Layout("contents", config);

    contentLayout.getCell("accGrid").attach(accGrid); // 액세서리 GRID
    contentLayout.getCell("registAccGrid").attach(registAccGrid); // 등록액세서리 GRID
    contentLayout.getCell("originGrid").attach(originGrid); // 본품 GRID
    contentLayout.getCell("registOriginGrid").attach(registOriginGrid); // 등록본품 GRID

    contentLayout.getCell("accHeader").attach(accHeader); // 액세서리 상단
    contentLayout.getCell("accFooter").attach(accFooter); // 액세서리 하단
    contentLayout.getCell("accKeyword").attach(accKeyword); // 액세서리 키워드 히스토리
    contentLayout.getCell("registAccHeader").attach(registAccHeader); // 등록된 액세서리 상단
    contentLayout.getCell("originHeader").attach(originHeader); // 본품 상단
    contentLayout.getCell("originFooter").attach(originFooter); // 본품 하단
    contentLayout.getCell("originKeyword").attach(originKeyword); // 본품 키워드 히스토리
    contentLayout.getCell("registOriginHeader").attach(registOriginHeader); // 등록된 본품 상단

    contentLayout.getCell("relatedFooter").attach(relatedFooter); // 연관상품 페이지 하단    
    
    contentLayout.getCell("topSaveBtn").attach(topSaveBtn); // 가운데 저장 버튼 상단
    /*contentLayout.getCell("bottomSaveBtn").attach(bottomSaveBtn); // 가운데 저장 버튼 하단
    */


/************************************************************************************************** 2022.06.15 액세서리,본품 상단 검색 키워드 추가 */
/************************************************************************************************** 레이아웃 생성 후 아래 액션 추가해 주세요.  */
/********************************* 
 * 참고 : 액세서리/본품 검색 키워드 추가 기능입니다.
 * 폼 위젯 이벤트 : 참고(https://docs.dhtmlx.com/suite/form/api/input/input_change_event/)
*********************************/

/************* 액세서리 키워드 추가 *************/
var accKeywordVal = 0; // 셀렉트 초기값
accHeader.getItem("accSelect").events.on("change", function(val){
    accKeywordVal = val; // 셀렉트 선택한 값 
})
accHeader.getItem("accSubmit").events.on("click", function(e) {
    accSubmit();
})
function accSubmit(){ // 검색 키워드 서브밋
    var srchVal = accHeader.getItem("accInput").getValue();
    if(srchVal != ""){
        if(accKeywordVal == 2){
            addAccKeyword("+"+srchVal); // 키워드 포함
        }else if(accKeywordVal == 3){
            addAccKeyword("-"+srchVal); // 키워드 제외
        }else{ 
            addAccKeyword(srchVal); // 전체선택
        }
    }else{
        accHeader.getItem("accInput").focus(); // 포커싱
    }
    accHeader.getItem("accInput").clear(); // 검색 후 초기화
}
// EP상품 키워드 추가
function addAccKeyword(keyword) { 
    accKeyword.addTab({ tab: keyword }, -1); // 뒤로 추가(-1), 앞으로 추가(0)

    accHeader.getItem("accInput").focus(); // 포커싱
};
/* // */

/************* 본품 키워드 추가 *************/
var originKeywordVal = 0; // 셀렉트 초기값
originHeader.getItem("originSelect").events.on("change", function(val){
    originKeywordVal = val; // 셀렉트 선택한 값 
})
originHeader.getItem("originSubmit").events.on("click", function(e) {
    originSubmit();
})
function originSubmit(){ // 검색 키워드 서브밋
    var srchVal = originHeader.getItem("originInput").getValue();
    if(srchVal != ""){
        if(originKeywordVal == 2){
            addOriginKeyword("+"+srchVal); // 키워드 포함
        }else if(originKeywordVal == 3){
            addOriginKeyword("-"+srchVal); // 키워드 제외
        }else{ 
            addOriginKeyword(srchVal); // 전체선택
        }
    }else{
        originHeader.getItem("originInput").focus(); // 포커싱
    }
    originHeader.getItem("originInput").clear(); // 검색 후 초기화
}
// EP상품 키워드 추가
function addOriginKeyword(keyword) { 
    originKeyword.addTab({ tab: keyword }, -1); // 뒤로 추가(-1), 앞으로 추가(0)

    originHeader.getItem("originInput").focus(); // 포커싱
};
/* // */


$(function(){    
    // 액세서리 인풋 검색어 입력 후
    $("#accInput").keyup(function(e){
        if(e.key === 'Enter' || e.keyCode === 13){
            accSubmit();
        }
    })

    // 본품 인풋 검색어 입력 후
    $("#originInput").keyup(function(e){
        if(e.key === 'Enter' || e.keyCode === 13){
            originSubmit();
        }
    })

    // 추가된 키워드 클릭(활성/비활성 토글)
    $(".keyword_list").on("click", ".dhx_tabbar-tab", function(e){
        if(!$(this).hasClass("is-disabled")){ // 비활성
            $(this).addClass("is-disabled");
        }else{ // 활성
            $(this).removeClass("is-disabled");
        }
    })
})