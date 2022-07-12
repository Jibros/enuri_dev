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
 * 서브 > 전성분 컨텐츠
 *********************************/

// 성분그룹 가짜 데이터
var ingredientGroupData = [
    { "idn": "1","attr_a": "화장품 성분" },
    { "idn": "2","attr_a": "분유 성분" },
    { "idn": "3","attr_a": "분유 성분" },
]
// 성분타이틀 가짜 데이터
var ingredientTitleData = [
    { "idn": "1","attr_a": "알레르기",   "attr_b": "", "attr_c": 1, "attr_d":1, "attr_e":"212441", "attr_f":1 }, 
    { "idn": "2","attr_a": "자외선차단", "attr_b": "", "attr_c": 0, "attr_d":0, "attr_e":"212441", "attr_f":2 }, 
    { "idn": "3","attr_a": "미백",       "attr_b": "", "attr_c": 1, "attr_d":0, "attr_e":"212441", "attr_f":3 }, 
    { "idn": "4","attr_a": "탄력",       "attr_b": "", "attr_c": 1, "attr_d":0, "attr_e":"212441", "attr_f":4 }, 
    { "idn": "5","attr_a": "여드름",     "attr_b": "지성", "attr_c": 0, "attr_d":1, "attr_e":"212441", "attr_f":6 }, 
    { "idn": "6","attr_a": "지성 피부",  "attr_b": "지성", "attr_c": 0, "attr_d":0, "attr_e":"212441", "attr_f":5 }, 
    { "idn": "7","attr_a": "건성 피부",  "attr_b": "건성", "attr_c": 1, "attr_d":1, "attr_e":"212441", "attr_f":8 }, 
    { "idn": "8","attr_a": "피부보습",   "attr_b": "건성", "attr_c": 1, "attr_d":0, "attr_e":"212441", "attr_f":7 }, 
    { "idn": "9","attr_a": "자극",       "attr_b": "민감성", "attr_c": 0, "attr_d":1, "attr_e":"212441", "attr_f":10 }, 
    { "idn": "3","attr_a": "민감성 피부","attr_b": "민감성", "attr_c": 0, "attr_d":0, "attr_e":"212441", "attr_f":9 }, 
]
// 성분 가짜 데이터
var ingredientItemData = [
    { "idn": "21", "attr_a": "향료","attr_b": 0, "attr_c": "Limonene", "attr_d": "향료", "attr_e": "" }, 
    { "idn": "22", "attr_a": "향료","attr_b": 1, "attr_c": "Limonene", "attr_d": "향료", "attr_e": ""  }, 
    { "idn": "23", "attr_a": "향료","attr_b": 2, "attr_c": "Limonene", "attr_d": "향료", "attr_e": ""  }, 
]

// 동의어 가짜 데이터
var ingredientSameData = [
    //{ "idn": "", "attr_a": "" }, 
]


/*********************************
 * DHTMLX 위젯 생성하여, attach 합니다.
 * FORM 위젯 내 > css명 수정X
 * FORM 위젯 내 > options value 는 수정해서 사용해주세요.
 * FORM 위젯 내 > id 변경 시, 공유해 주세요.
*********************************/
// 성분그룹 헤더
var ingreGroupHeader = new dhx.Form(null, {
    css: "step_header",
    padding: "0 10px",
    width: "100%",
    cols:[   
        {
            css:"tx_count",
            cols:[                
                {
                    name: "text",
                    type: "text",
                    value: "성분 그룹 : 2건",
                },
            ]
        },
        {
            css:"btn-group",
            cols: [
                {
                    type: "button",
                    text: "추가",
                    id: "btnAdd",
                    css: "control-comm"
                },
                {
                    type: "button",
                    text: "수정",
                    id: "btnSave",
                    css: "control-comm"
                },
                {
                    type: "button",
                    text: "삭제",
                    id: "btnDel",
                    css: "control-comm"
                }
            ]            
        }
    ]
    
});

// 성분타이틀 헤더
var ingreTitleHeader = new dhx.Form(null, {
    css: "step_header",
    padding: "0 10px",
    width: "100%",
    cols:[   
        {
            css:"tx_count",
            cols:[                
                {
                    name: "text",
                    type: "text",
                    value: "타이틀 : 10건",
                },
            ]
        },
        {
            css:"btn-group",
            cols: [
                {
                    type: "button",
                    text: "추가",
                    id: "btnAdd",
                    css: "control-comm"
                },
                {
                    type: "button",
                    text: "수정",
                    id: "btnSave",
                    css: "control-comm"
                },
                {
                    type: "button",
                    text: "삭제",
                    id: "btnDel",
                    css: "control-comm"
                }
            ]            
        }
    ]
    
});

// 성분 헤더
var ingreItemHeader = new dhx.Form(null, {
    css: "step_header",
    padding: "0 10px",
    width: "100%",
    cols:[   
        {
            css:"tx_count",
            cols:[                
                {
                    name: "text",
                    type: "text",
                    value: "성분 : 178건",
                },
            ]
        },
        {
            css:"btn-group",
            cols: [
                {
                    type: "button",
                    text: "추가",
                    id: "btnAdd",
                    css: "control-comm"
                },
                {
                    type: "button",
                    text: "수정",
                    id: "btnSave",
                    css: "control-comm"
                },
                {
                    type: "button",
                    text: "삭제",
                    id: "btnDel",
                    css: "control-comm"
                }
            ]            
        }
    ]
});

// 동의어 헤더
var ingreSameHeader = new dhx.Form(null, {
    css: "step_header",
    padding: "0 10px",
    width: "100%",
    cols:[   
        {
            css:"tx_count",
            cols:[                
                {
                    name: "text",
                    type: "text",
                    value: "동의어 : 178건",
                },
            ]
        },
        {
            css:"btn-group",
            cols: [
                {
                    type: "button",
                    text: "추가",
                    id: "btnAdd",
                    css: "control-comm"
                },
                {
                    type: "button",
                    text: "수정",
                    id: "btnSave",
                    css: "control-comm"
                },
                {
                    type: "button",
                    text: "삭제",
                    id: "btnDel",
                    css: "control-comm"
                }
            ]            
        }
    ]
});

/*********************************
 * 각 COL 그리드/리스트 생성하여 attach 합니다.
*********************************/
var ingreGroupGrid, ingreTitleGrid, ingreItemGrid, ingreSameGrid; // 성분그룹, 성분타이틀, 성분, 동의어 그리드

// 성분그룹 그리드 생성
ingreGroupGrid = new dhx.Grid(null, {
    columns: [ 
        {id: "idn",     width: 40, header: [{ text: "ID", align: "center" }], align: "center" },
        {id: "attr_a",  header: [{ text: "그룹명", align: "center" }], align: "left" },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth: true,
    data: ingredientGroupData,
    selection: "row",
    multiselection: false,
    keyNavigation: true,
    resizable:true,
});
// 성분타이틀 그리드 생성
ingreTitleGrid = new dhx.Grid(null, {
    columns: [
        {id: "idn",     width: 40,  header: [{ text: "ID", align: "center" }], align: "center", gravity: 1.5 },
        {id: "attr_a",  header: [{ text: "타이틀명", align: "center" }], align: "left" },
        {id: "attr_b",  header: [{ text: "타이틀 그룹명", align: "center" }], align: "left" },
        {id: "attr_c",  width: 40,  header: [{ text: "노출", align: "center" }], align: "center",
            template : function(text, row, col){
                if(text == 1) return "Y";
                else return "N";
            }
        },
        {id: "attr_d",  width: 40,  header: [{ text: "유해", align: "center" }], align: "center" },
        {id: "attr_e",  width: 60,  header: [{ text: "속성ID", align: "center" }], align: "center" },
        {id: "attr_f",  width: 60,  header: [{ text: "속성원ID", align: "center" }], align: "center" },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth: true,
    data: ingredientTitleData,
    selection: "row",
    multiselection: false,
    keyNavigation: true,
    resizable:true,
});
// 성분 그리드 생성
ingreItemGrid = new dhx.Grid(null, {
    columns: [
        {id: "idn",     width: 60,  header: [{ text: "ID", align: "center" }], align: "center" },
        {id: "attr_a",  header: [{ text: "한글 성분명", align: "center" }], align: "left" },
        {id: "attr_b",  header: [{ text: "등록", align: "center" }], align: "center" },
        {id: "attr_c",  width: 150, header: [{ text: "영문 성분명", align: "center" }], align: "left" },
        {id: "attr_d",  header: [{ text: "목적", align: "center" }], align: "center" },
        {id: "attr_e",  width: 150, header: [{ text: "설명", align: "center" }], align: "left" },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth: true,
    data: ingredientItemData,
    selection: "row",
    multiselection: false,
    keyNavigation: true,
    resizable:true,
});
// 동의어 그리드 생성
ingreSameGrid = new dhx.Grid(null, {
    columns: [
        {id: "idn",    width: 60,   header: [{ text: "ID", align: "center" }], align: "center" },
        {id: "attr_a", header: [{ text: "동의어", align: "center" }], align: "left" },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth: true,
    data: ingredientSameData,
    selection: "row",
    multiselection: false,
    keyNavigation: true,
    resizable:true,
    tooltip: false,
});

/*********************************
 * 전체 레이아웃 생성
*********************************/
var config = {
    type: "line", // space, wide, line
    width:"100%",
    maxWidth:"100%",
    rows: [
        {
            type:"space",
            id: "rowTop",
            cols:[
                {
                    // 좌측 COL
                    type: "line",
                    rows:[
                        {
                            // [성분 그룹]
                            id: "ingredientGroup",
                            headerHeight:32,
                            header: "[성분 그룹]",
                            height: 245,
                            collapsable: false,
                            htmlEnable: true,
                            resizable: false,
                            customScroll: true,                                    
                            rows : [
                                {
                                    // 성분그룹 HEADER
                                    id: "ingreGroupHeader",
                                    height: "48px"
                                },
                                {
                                    // 성분그룹 GRID
                                    id: "ingreGroupGrid",
                                    height:"calc(100% - 48px)"
                                }
                            ]
                        },
                        {
                            // [타이틀]
                            id: "ingredientTitle",
                            headerHeight:32,
                            header: "[타이틀]",
                            collapsable: false,
                            htmlEnable: true,
                            resizable: false,
                            customScroll: true,                                    
                            rows : [
                                {
                                    // 타이틀 HEADER
                                    id: "ingreTitleHeader",
                                    height: "48px"
                                },
                                {
                                    // 타이틀 GRID
                                    id: "ingreTitleGrid",
                                    height:"calc(100% - 48px)"
                                }
                            ]
                        },
                    ],
                },
                {
                    // 가운데 COL
                    type: "line",
                    id: "ingredientItem",
                    headerHeight:32,
                    header: "[성분]",
                    collapsable: false,
                    htmlEnable: true,
                    resizable: false,
                    customScroll: true,
                    // [성분]
                    rows : [
                        {
                            // 성분 HEADER
                            id: "ingreItemHeader",
                            height: "48px"
                        },
                        {
                            // 성분 GRID
                            id: "ingreItemGrid",
                            height:"calc(100% - 48px)"
                        }
                    ]
                },
                {
                    // 우측 COL
                    type: "line",
                    id: "ingredientSame",
                    headerHeight:32,
                    header: "[동의어]",
                    width:400,
                    collapsable: true,
                    htmlEnable: true,
                    resizable: false,
                    customScroll: true,
                    // [동의어]
                    rows : [
                        {
                            // 동의어 HEADER
                            id: "ingreSameHeader",
                            height: "48px"
                        },
                        {
                            // 동의어 GRID
                            id: "ingreSameGrid",
                            height:"calc(100% - 48px)"
                        }
                    ]
                }
            ],
        }
    ]
};


/*********************************
 * 생성된 레이아웃에 ID별로 attach합니다.
*********************************/
export var contentLayout = new dhx.Layout("allIngredientsLayout", config);

    // GRID 세팅
    contentLayout.getCell("ingreGroupGrid").attach(ingreGroupGrid); // 성분그룹 GRID
    contentLayout.getCell("ingreTitleGrid").attach(ingreTitleGrid); // 성분타이틀 GRID
    contentLayout.getCell("ingreItemGrid").attach(ingreItemGrid); // 성분 GRID    
    contentLayout.getCell("ingreSameGrid").attach(ingreSameGrid); // 동의어 GRID

    contentLayout.getCell("ingreGroupHeader").attach(ingreGroupHeader); // 성분그룹 헤더
    contentLayout.getCell("ingreTitleHeader").attach(ingreTitleHeader); // 성분타이틀 헤더
    contentLayout.getCell("ingreItemHeader").attach(ingreItemHeader); // 성분 헤더
    contentLayout.getCell("ingreSameHeader").attach(ingreSameHeader); // 동의어 헤더

/*********************************
 * 페이지 로딩 후 실행됩니다.
 * - 로딩 스피너
 * - 레이어 오픈, 팝업 오픈 등
*********************************/
$(function(){
    // 로그인 로딩
    $(".btn_login").on("click", function(){
        $(".loader_box").fadeIn()
        setTimeout(function(){
            $(".loader_box").fadeOut();

            $(".login__wrap").fadeOut();
        },2000)
        return false;
    })
})

/*********************************
 * 각 그리드 추가/수정/삭제 윈도우 생성
*********************************/
var editWindow = new dhx.Window({
    width: 440,
    title: "타이틀",
//    minHeight: 500,
    modal: true
});

// editWindow 폼 : 성분그룹 config
var ingreGroupFormConfig = {
    padding: 0,
    rows: [
        {
            id: "id",
            type: "input",
            name: "id",
            hidden: true
        },
        {
            type: "input",
            name: "title",
            label: "그룹명",
            required: true
        },
        {
            align: "end",
            cols: [
                {
                    id: "apply-button",
                    type: "button",
                    text: "추가/저장",              
                    icon: "mdi mdi-check",
                    circle: true,
                }
            ]
        }
        
    ]
}
// editWindow 폼 : 타이틀 config
var ingreTitleFormConfig = {
    padding: 0,
    rows: [
        {
            id: "id",
            type: "input",
            name: "id",
            hidden: true
        },
        {
            type: "input",
            name: "titleName",
            label: "타이틀명",
            required: true
        },
        {
            type: "input",
            name: "titleGroupName",
            label: "타이틀 그룹명",
            required: true
        },
        {
            type: "radioGroup",
            name: "showhideState",
            disabled: false,
            required: false,
            hidden: false,
            label: "노출",
            options: {
                cols: [
                    {
                        type: "radioButton",
                        text: "미노출(N)",
                        value: "1",
                        checked: true
                    },
                    {
                        type: "radioButton",
                        text: "노출(Y)",
                        value: "0",
                    },
                ]
            }
        },
        {
            type: "radioGroup",
            name: "noxiousState",
            disabled: false,
            required: false,
            hidden: false,
            label: "유해",
            options: {
                cols: [
                    {
                        type: "radioButton",
                        text: "좋음(0)",
                        value: "0",
                        checked: true
                    },
                    {
                        type: "radioButton",
                        text: "나쁨(1)",
                        value: "1",
                    },
                ]
            }
        },
        {
            type: "input",
            name: "propertyId",
            label: "속성ID",
            required: true
        },
        {
            type: "input",
            name: "attributeId",
            label: "속성원ID",
            required: true
        },
        {
            align: "end",
            cols: [
                {
                    id: "apply-button",
                    type: "button",
                    text: "추가/저장",
                    icon: "mdi mdi-check",
                    circle: true,
                }
            ]
        }
        
    ]
}
// editWindow 폼 : 성분 config
var ingreItemFormConfig = {
    padding: 0,
    rows: [
        {
            id: "id",
            type: "input",
            name: "id",
            hidden: true
        },
        {
            type: "input",
            name: "attrKorName",
            label: "한글 성분명",
            required: true,
        },
        {
            type: "input",
            name: "attrEngName",
            label: "영문 성분명",
            required: true,
        },
        {
            id:"registCheck",
            type: "checkboxGroup",
            name: "registCheck",
            disabled: false,
            required: false,
            hidden: false,
            label: "등록",
            options:{
                cols: [
                    { 
                        type: "checkbox", 
                        text: "알레르기 (나쁨)",
                        width: "50%"
                    },
                    { 
                        type: "checkbox", 
                        text: "자외선차단 (좋음)",
                        width: "50%"
                    },
                    { 
                        type: "checkbox", 
                        text: "미백 (좋음)",
                        width: "50%"
                    },
                    { 
                        type: "checkbox", 
                        text: "자외선차단 (좋음)",
                        width: "50%"
                    },
                    { 
                        type: "checkbox", 
                        text: "미백 (좋음)",
                        width: "50%"
                    },
                    { 
                        type: "checkbox", 
                        text: "탄력 (좋음)",
                        width: "50%"
                    },
                    { 
                        type: "checkbox", 
                        text: "알레르기 (나쁨)",
                        width: "50%"
                    },
                    { 
                        type: "checkbox", 
                        text: "자외선차단 (좋음)",
                        width: "50%"
                    },
                    { 
                        type: "checkbox", 
                        text: "미백 (좋음)",
                        width: "50%"
                    },
                    { 
                        type: "checkbox", 
                        text: "탄력 (좋음)",
                        width: "50%"
                    },
                    { 
                        type: "checkbox", 
                        text: "미백 (좋음)",
                        width: "50%"
                    },
                    { 
                        type: "checkbox", 
                        text: "탄력 (좋음)",
                        width: "50%"
                    },
                ]
            },
        },
        {
            type: "input",
            name: "purposeTxt",
            label: "목적",
            required: true,
        },
        {
            type: "input",
            name: "detailTxt",
            label: "설명",
            required: true,
        },
        {
            align: "end",
            cols: [
                {
                    id: "apply-button",
                    type: "button",
                    text: "추가/저장",              
                    icon: "mdi mdi-check",
                    circle: true,
                    submit: true,
                }
            ]
        }
        
    ]
}
// editWindow 폼 : 성분 config
var ingreSameFormConfig = {
    padding: 0,
    rows: [
        {
            id: "id",
            type: "input",
            name: "id",
            hidden: true
        },
        {
            type: "input",
            name: "sameThing",
            label: "동의어",
            required: true
        },
        {
            align: "end",
            cols: [
                {
                    id: "apply-button",
                    type: "button",
                    text: "추가/저장",              
                    icon: "mdi mdi-check",
                    circle: true,
                }
            ]
        }
        
    ]
}


// 추가/수정 윈도우 내 폼 생성
var ingreGroupForm = new dhx.Form(null, ingreGroupFormConfig); // 성분 그룹 폼 생성
var ingreTitleForm = new dhx.Form(null, ingreTitleFormConfig); // 타이틀 폼 생성
var ingreItemForm = new dhx.Form(null, ingreItemFormConfig); // 성분 폼 생성
var ingreSameForm = new dhx.Form(null, ingreSameFormConfig); // 동의어 폼 생성

// 윈도우 열기
function openEditor(tit) {
    var winTitle = tit;
    
    editWindow.show();
    editWindow.header.data.update("title", { value: winTitle });
}

// 윈도우 닫기
function closeEditor() {
    ingreGroupForm.clear();
    ingreTitleForm.clear();
    ingreItemForm.clear();
    ingreSameForm.clear();
    editWindow.hide();
}

// 성분 그룹 : 그리드 행 **추가**
ingreGroupHeader.getItem("btnAdd").events.on("click", function(){
    editWindow.attach(ingreGroupForm);
    openEditor("성분 그룹 추가"); // 윈도우 TITLE 전달
    
    // 성분 그룹 : 추가 버튼 클릭
    ingreGroupForm.getItem("apply-button").events.on("click", function () {
        var newData = ingreGroupForm.getValue(); // 입력 값 저장
        var validate = ingreGroupForm.validate(); // 입력 상태 체크
        if(validate){                
            // 로직 넣어주세요.
            
            closeEditor();
        }
    }); 
})
// 성분 그룹 : 그리드 행 **수정**
ingreGroupHeader.getItem("btnSave").events.on("click", function(){
    var cell = ingreGroupGrid.selection.getCell(); // 선택한 행
    
    if (cell) {
        editWindow.attach(ingreGroupForm);
        openEditor("성분 그룹 수정"); // 윈도우 TITLE 전달

        // 성분 그룹 : 수정 버튼 클릭
        ingreGroupForm.getItem("apply-button").events.on("click", function () {
            var newData = ingreGroupForm.getValue(); // 입력 값 저장
            var validate = ingreGroupForm.validate(); // 입력 상태 체크
            if(validate){
                // 로직 넣어주세요.
            
                closeEditor();
            }
        }); 
    }else alert("수정할 행을 선택해주세요.")
})


// 타이틀 : 그리드 행 **추가**
ingreTitleHeader.getItem("btnAdd").events.on("click", function(){
    editWindow.attach(ingreTitleForm);
    openEditor("타이틀 추가"); // 윈도우 TITLE 전달
    
    // 타이틀 : 추가 버튼 클릭
    ingreTitleForm.getItem("apply-button").events.on("click", function () {
        var newData = ingreTitleForm.getValue(); // 입력 값 저장
        var validate = ingreTitleForm.validate(); // 입력 상태 체크
        if(validate){    
            // 로직 넣어주세요.
            
            closeEditor();
        }
    }); 
})
// 타이틀 : 그리드 행 **수정**
ingreTitleHeader.getItem("btnSave").events.on("click", function(){
    var cell = ingreTitleGrid.selection.getCell(); // 선택한 행
    
    if (cell) {
        editWindow.attach(ingreTitleForm);
        openEditor("타이틀 수정"); // 윈도우 TITLE 전달

        // 성분 그룹 : 수정 버튼 클릭
        ingreTitleForm.getItem("apply-button").events.on("click", function () {
            var newData = ingreTitleForm.getValue(); // 입력 값 저장
            var validate = ingreTitleForm.validate(); // 입력 상태 체크
            if(validate){
                // 로직 넣어주세요.
            
                closeEditor();
            }
        }); 
    }else alert("수정할 행을 선택해주세요.")
})


// 성분 : 그리드 행 **추가**
ingreItemHeader.getItem("btnAdd").events.on("click", function(){
    editWindow.attach(ingreItemForm);
    openEditor("성분 추가"); // 윈도우 TITLE 전달
    
    // 성분 : 추가 버튼 클릭
    ingreItemForm.getItem("apply-button").events.on("click", function () {
        var newData = ingreItemForm.getValue(); // 입력 값 저장
        var validate = ingreItemForm.validate(); // 입력 상태 체크
        if(validate){
            // 로직 넣어주세요.
            
            closeEditor();
        }
    }); 
})
// 성분 : 그리드 행 **수정**
ingreItemHeader.getItem("btnSave").events.on("click", function(){
    var cell = ingreItemGrid.selection.getCell(); // 선택한 행
    
    if (cell) {
        console.log(ingreSameFormConfig)
        editWindow.attach(ingreItemForm);
        openEditor("성분 수정"); // 윈도우 TITLE 전달

        // 성분 : 수정 버튼 클릭
        ingreItemForm.getItem("apply-button").events.on("click", function () {
            var newData = ingreItemForm.getValue(); // 입력 값 저장
            var validate = ingreItemForm.validate(); // 입력 상태 체크
            if(validate){
                // 로직 넣어주세요.
            
                closeEditor();
            }
        }); 
    }else alert("수정할 행을 선택해주세요.")
})


// 동의어 : 그리드 행 **추가**
ingreSameHeader.getItem("btnAdd").events.on("click", function(){
    editWindow.attach(ingreSameForm);
    openEditor("동의어 추가"); // 윈도우 TITLE 전달
    
    // 동의어 : 추가 버튼 클릭
    ingreSameForm.getItem("apply-button").events.on("click", function () {
        var newData = ingreSameForm.getValue(); // 입력 값 저장
        var validate = ingreSameForm.validate(); // 입력 상태 체크
        if(validate){
            // 로직 넣어주세요.
            
            closeEditor();
        }
    }); 
})
// 동의어 : 그리드 행 **수정**
ingreSameHeader.getItem("btnSave").events.on("click", function(){
    var cell = ingreSameGrid.selection.getCell(); // 선택한 행
    
    if (cell) {
        editWindow.attach(ingreSameForm);
        openEditor("타이틀 수정"); // 윈도우 TITLE 전달

        // 동의어 : 수정 버튼 클릭
        ingreSameForm.getItem("apply-button").events.on("click", function () {
            var newData = ingreSameForm.getValue(); // 입력 값 저장
            var validate = ingreSameForm.validate(); // 입력 상태 체크
            if(validate){
                // 로직 넣어주세요.
            
                closeEditor();
            }
        }); 
    }else alert("수정할 행을 선택해주세요.")
})


// 성분 그룹 : 그리드 행 **삭제**
ingreGroupHeader.getItem("btnDel").events.on("click", function () {
    var cell = ingreGroupGrid.selection.getCell(); // 선택한 행

    if (cell.row) {
        if(window.confirm("삭제하시겠습니까?")) {
            //ingreGroupGrid.data.remove(cell.row.id);
        }
    }
});
// 타이틀 : 그리드 행 **삭제** 
ingreTitleHeader.getItem("btnDel").events.on("click", function () {
    var cell = ingreTitleGrid.selection.getCell(); // 선택한 행

    if (cell.row) {
        if(window.confirm("삭제하시겠습니까?")) {
            //ingreTitleGrid.data.remove(cell.row.id);
        }
    }
});
// 성분 : 그리드 행 **삭제** 
ingreItemHeader.getItem("btnDel").events.on("click", function () {
    var cell = ingreItemGrid.selection.getCell(); // 선택한 행

    if (cell.row) {
        if(window.confirm("삭제하시겠습니까?")) {
            //ingreItemGrid.data.remove(cell.row.id);
        }
    }
});
// 동의어 : 그리드 행 **삭제** 
ingreSameHeader.getItem("btnDel").events.on("click", function () {
    var cell = ingreSameGrid.selection.getCell(); // 선택한 행

    if (cell.row) {
        if(window.confirm("삭제하시겠습니까?")) {
            //ingreSameGrid.data.remove(cell.row.id);
        }
    }
});