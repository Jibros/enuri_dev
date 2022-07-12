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
 * 서브 > 그룹 조건 컨텐츠
 *********************************/

// 그룹모델 판매조건 가짜 데이터
var groupMdConditionData = [
    // idn :조건번호, attr_a:조건명, attr_b:모델수, attr_c:정렬우선순위, attr_d: 관리
    { "idn": "1",   "attr_a": "총용량 78ml", "attr_b": 2, "attr_c": null, "attr_d": null },
    { "idn": "2",   "attr_a": "50ml, 2개", "attr_b": 3, "attr_c": 1, "attr_d": null },
    { "idn": "3",   "attr_a": "해외쇼핑, 48ml", "attr_b": 1, "attr_c": 2, "attr_d": null },
    { "idn": "4",   "attr_a": "해외쇼핑, 55ml", "attr_b": 2, "attr_c": 3, "attr_d": null },
    { "idn": "5",   "attr_a": "해외쇼핑, 57ml", "attr_b": 0, "attr_c": null, "attr_d": null },
    { "idn": "6",   "attr_a": "해외쇼핑, 80ml", "attr_b": 0, "attr_c": null, "attr_d": null },
    { "idn": "7",   "attr_a": "해외쇼핑, 70ml", "attr_b": 1, "attr_c": null, "attr_d": null },
    { "idn": "8",   "attr_a": "해외쇼핑, 150ml", "attr_b": 2, "attr_c": null, "attr_d": null },
    { "idn": "9",   "attr_a": "해외쇼핑, 12ml", "attr_b": 1, "attr_c": 4, "attr_d": null },
    { "idn": "10",  "attr_a": "해외쇼핑, 225ml x 5개", "attr_b": 1, "attr_c": null, "attr_d": null },
    { "idn": "11",  "attr_a": "해외쇼핑, 40ml", "attr_b": 1, "attr_c": null, "attr_d": null },
    { "idn": "12",  "attr_a": "해외쇼핑, 48ml", "attr_b": 1, "attr_c": null, "attr_d": null },
    { "idn": "13",  "attr_a": "해외쇼핑, 180ml", "attr_b": 1, "attr_c": 5, "attr_d": null },
    { "idn": "14",  "attr_a": "해외배", "attr_b": 1, "attr_c": null, "attr_d": null },
    { "idn": "15",  "attr_a": "50ml, 3개", "attr_b": 1, "attr_c": null, "attr_d": null },
    { "idn": "16",  "attr_a": "60ml, 2개", "attr_b": 1, "attr_c": null, "attr_d": null },
    { "idn": "17",  "attr_a": "해외배송, 150ml", "attr_b": 1, "attr_c": null, "attr_d": null },
    { "idn": "18",  "attr_a": "50ml, 2개", "attr_b": 2, "attr_c": null, "attr_d": null },
]

// 그룹조건 푸터 
// 페이지 로드 후 조건명 입력됩니다. => findMaxText();
var groupMdFooter = "";
    groupMdFooter += "<div class=\"groupmd_footer\">";
    groupMdFooter += "    <p class=\"tx_msg\">*가장 긴 조건명: <strong class=\"condi_width\"></strong> <span class=\"condi_name\"></span></p>";
    groupMdFooter += "</div>";

/*********************************
 * DHTMLX 위젯 생성하여, attach 합니다.
 * FORM 위젯 내 > css명 수정X
 * FORM 위젯 내 > options value 는 수정해서 사용해주세요.
 * FORM 위젯 내 > id 변경 시, 공유해 주세요.
*********************************/
// 그룹모델 판매조건 헤더
var groupMdHeader = new dhx.Form(null, {
    css: "controller_ep",
    padding: 0,
    width: "100%",
    cols: [
        {
            id: "prdcSelect",
            name: "prdcSelect",
            type: "select",
            label: "",
            labelPosition: "left",
            labelWidth: 0,
            value: "조건명",
            required: true,
            options: [
                {
                    value: "0",
                    content: "조건명"
                },
                {
                    value: "1",
                    content: "조건번호"
                },
            ],
            css: "control-comm sel-sort"
        }, 
        {
            id: "keywordInput",
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
            id: "keywordSubmit",
            type: "button",
            text:"검색",
            css: "control-comm btn-srch"
        },
        {
            type: "button",
            text: "일괄등록",
            id: "btnAllRegist",
            align:"right",
            size: "small",
            css: "control-comm btn-regist"
        },
        {
            type: "button",
            text: "추가",
            id: "btnAdd",
            align:"right",
            size: "small",
            css: "control-comm btn-add"
        }
    ]
});

/*********************************
 * 각 COL 그리드/리스트 생성하여 attach 합니다.
*********************************/
var groupMdGrid; // 그룹모델 판매조건 그리드 

// 그룹모델 판매조건 그리드 생성
groupMdGrid = new dhx.Grid(null, {
    columns: [ 
        {id: "idn",     width: 60, header: [{ text: "조건번호", align: "center" }], align: "center" },
        {id: "attr_a",  width:280, header: [{ text: "조건명", align: "center" }], align: "left" },
        {id: "attr_b",  width: 60, header: [{ text: "모델수", align: "center" }], align: "center" },
        {id: "attr_c",  width: 90, header: [{ text: "정렬우선순위", align: "center" }], align: "center"},
        {id: "attr_d",  width: 90, header: [{ text: "관리", align: "center" }], align: "left", htmlEnable: true,
            template: function(text, row, col){
                var btnTag = "";
                    btnTag += "<div class=\"group_grid_btn\">";
                    btnTag += "     <button type='button' class='btn edit-button'>수정</button>";
                    if(row.attr_b === 0){ // 모델수 0일 때 삭제 버튼 노출
                        btnTag += "     <button type='button' class='btn remove-button'>삭제</button>";
                    }
                    btnTag += "</div>";
                return btnTag;
            } 
        },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth: true,
    data: groupMdConditionData,
    selection: "row",
    multiselection: false,
    keyNavigation: true,
    editable: true,
    resizable:true,
    eventHandlers: {
        onclick: {
            "remove-button": function (e, data) {
                groupMdGrid.data.remove(data.row.id);
            },
            "edit-button": function (e, data) {
                var conditionName = data.row.attr_a; // 조건명
                var condisionLevelt = data.row.attr_c; // 정렬우선순위
                if(condisionLevelt != null){
                    alert("["+conditionName + "] 정렬우선순위 " +condisionLevelt+ "위로 수정되었습니다.") // 수정할 행 id, 수정할 행 조건명 전달
                }else{
                    alert("정렬우선순위 기입해 주세요.");
                }
            }
        }
    }
});

// CELL 수정 X (정렬우선순위 만 수정 가능)
groupMdGrid.events.on("beforeEditStart", function(row,col,editorType){
    if(col.id === "idn" || col.id === "attr_a" || col.id === "attr_b" || col.id === "attr_d"){ // ID 수정 X
        return false;
    }
});
// 그룹모델 판매조건 : 그리드 행 **삭제** 
$(document).on("click", ".remove-button", function(){
    var cell = groupMdGrid.selection.getCell(); // 선택한 행

    if (cell.row) {
        if(window.confirm("삭제하시겠습니까?")) {
            groupMdGrid.data.remove(cell.row.id);
        }
    }
})


/*********************************
 * 각 그리드 추가/수정/삭제 윈도우 생성
*********************************/
var editWindow = new dhx.Window({
    width: 440,
    height: 450,
    title: "그룹모델 판매조건 수정",
    modal: true
});

var editFormConfig = {
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
            name: "tx_condition",
            label: "조건명(필수)",
            required: true // 필수 입력 
        },
        {
            type: "input",
            name: "sort_level",
            label: "정렬우선순위",
            placeholder: "숫자만 입력해주세요",
            css : "sort_level"
        },
        {
            align: "end",
            cols: [
                {
                    id: "apply-button",
                    type: "button",
                    text: "추가",
                    circle: true,
                }
            ]
        }
    ]
}

// 정렬우선순위 숫자만 입력 가능
$(document).on('input', '.sort_level input[type=text]', function(e){
    this.value = this.value.replace(/[^0-9]/g,'');
})

// 그룹조건 추가 버튼 클릭
groupMdHeader.getItem("btnAdd").events.on("click", function(){
    openEditor(groupMdGrid.data.row, "그룹모델 판매조건 추가");
})
// 그룹조건 일괄등록 버튼 클릭
groupMdHeader.getItem("btnAllRegist").events.on("click", function(){
    alert("완료되었습니다.")
})

// 수정 윈도우 내 폼 생성
var editForm = new dhx.Form(null, editFormConfig);

editForm.getItem("apply-button").events.on("click", function () {
    var newData = editForm.getValue();
    var validate = editForm.validate(); // 입력 상태 체크
    if(validate){

        // 로직 넣어주세요. 
        // 참고 : https://snippet.dhtmlx.com/5tbcflek?text=window
        //groupMdGrid.data.update(newData.id, { ...newData })

        var dataIdn = (groupMdConditionData.length+1); // 조건번호 카운팅
        
        const dataVal = {
            idn: dataIdn,
            attr_a : newData.tx_condition, // 조건명
            attr_b : newData.tx_model, // 모델수 -> 조건 추가 후 자동으로 카운트 됨
            attr_c : newData.sort_level, // 정렬우선순위
        }
        groupMdConditionData.push(dataVal); // 배열에 푸시
        groupMdGrid.data.add(dataVal); // 그리드에 표시
        
        closeEditor(); // 윈도우 닫기
    }
});

// 윈도우 열기
function openEditor(id, tit) {
    var winTitle = tit;
    
    editWindow.show();
    editWindow.header.data.update("title", { value: winTitle }); // 윈도우 타이틀 수정
    var item = groupMdGrid.data.getItem(id);
    if (item) {
        editForm.setValue(item);
    }
}

// 윈도우 닫기
function closeEditor() {
    editForm.clear();
    editWindow.hide();
}

// 윈도우 내 폼 적용
editWindow.attach(editForm);

/*********************************
 * 전체 레이아웃 생성
*********************************/
var config = {
    type: "line", // space, wide, line
    width:"100%",
    maxWidth:"100%",

    // 그리드 컨텐츠 
    rows:[
        {
            type:"space",
            id: "rowTop",
            rows:[
                {
                    // COL
                    type: "line",
                    width: "595",
                    cols:[
                        {
                            // [성분 그룹]
                            id: "groupMdCondition",
                            headerHeight:32,
                            header: "[그룹모델 판매조건]",
                            collapsable: false,
                            htmlEnable: true,
                            resizable: false,
                            customScroll: true,                                    
                            rows : [
                                {
                                    // 그룹모델 판매조건 HEADER
                                    id: "groupMdHeader",
                                    height: "42px"
                                },
                                {
                                    // 그룹모델 판매조건 GRID
                                    id: "groupMdGrid",
                                    height:"calc(100% - 72px)"
                                },
                                {
                                    // 그룹모델 판매조건 GRID
                                    id: "groupMdFooter",
                                    height: "calc(100% - 30px)",
                                    html: groupMdFooter,
                                }
                            ]
                        },
                    ],
                },
            ],
        }
    ]
};


/*********************************
 * 생성된 레이아웃에 ID별로 attach합니다.
*********************************/
export var contentLayout = new dhx.Layout("contents", config);

    // GRID 세팅
    contentLayout.getCell("groupMdGrid").attach(groupMdGrid); // 그룹모델 판매조건 GRID
    contentLayout.getCell("groupMdHeader").attach(groupMdHeader); // 그룹모델 판매조건 헤더

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

    // 그룹모델 푸터
    findMaxText();
})

// 최대 글자 수 그룹관리 찾아서 푸터에 입력
function findMaxText(){
    let conditionArr = groupMdGrid.data._order; // 그리드 ROW
    let condiMaxArr = conditionArr.map(name => name.attr_a) // 조건명 추출
    let eachLength = condiMaxArr.map(x => x.length) // 글자수 map
    let maxNum = Math.max(...eachLength); // 최대값
    let idx = eachLength.indexOf(maxNum); // 최대값 위치 index

    const condiWidth = document.querySelector('.condi_width'); // 조건명 dom
    const condiName = document.querySelector('.condi_name'); // 조건명 dom    
    condiName.innerText = condiMaxArr[idx];
    const wid = condiName.offsetWidth;
    condiWidth.innerText = wid +"pixel"; // pixel 은 대량정제 폰트 사이즈 대비하여 입력된 거라 이후에 바뀔 수 있습니다. (보여지는 페이지 폰트사이즈 기준 적용되어야 할 여지가 있음)
}