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
 * 서브 > 속성 어드민 컨텐츠
 *********************************/

// 1단계속성 가짜 데이터
var stepDatalist1 = [
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":1, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_기타","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":1, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_퀄컴","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":1, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_삼성","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":1, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "디스플레이_화면(비법정)","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "카메라화소_화소수(후면)","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "메모리_내장메모리","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":1, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_클럭","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_모션CPU","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":1, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "메모리_저장장치","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "디스플레이_화면","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "규격_세로","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":1, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
    {"idn": "21130","attr_a": "CPU_미디어택","attr_b": "모델명", "attr_c": 1, "attr_d":0, "attr_e":1, "attr_f":2, "attr_g":"텍스트 입력", "attr_h":"텍스트 입력", "attr_i":"텍스트 입력", "attr_j":1, "attr_k":0}, 
]
// 2단계속성 가짜 데이터
var stepDatalist2 = [
    {"idn": "41","attr_a": "1","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "42","attr_a": "2","attr_b": "듀얼휴먼(1,300만+800만)", "attr_c": 1, "attr_d":23225, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "43","attr_a": "3","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23225, "attr_e":1, "attr_f":0, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "44","attr_a": "4","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23225, "attr_e":1, "attr_f":0, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "45","attr_a": "5","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23225, "attr_e":1, "attr_f":0, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "46","attr_a": "6","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23225, "attr_e":1, "attr_f":0, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "48","attr_a": "7","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23225, "attr_e":1, "attr_f":0, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "49","attr_a": "8","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23225, "attr_e":1, "attr_f":0, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "52","attr_a": "9","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23225, "attr_e":1, "attr_f":0, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "53","attr_a": "10","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23225, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "11","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23225, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "12","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23222, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "13","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "14","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "15","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "16","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "17","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "18","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "19","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "20","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "21","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "22","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "23","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "24","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "25","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "26","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "27","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "28","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "29","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "30","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "31","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "32","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "33","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "34","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "35","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "36","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
    {"idn": "66","attr_a": "37","attr_b": "듀얼휴먼(2,000만+1,600만)", "attr_c": 1, "attr_d":23224, "attr_e":0, "attr_f":1, "attr_g":"텍스트 입력(숫자)"}, 
]
// 속성순서세팅 가짜 데이터
var stepDatalist3 = [
    {"idx": "1", "idn": "21130", "attr_a": "CPU_미디어텍","attr_b": "모델명"}, 
    {"idx": "2", "idn": "21130", "attr_a": "CPU_기타","attr_b": "모델명"}, 
    {"idx": "3", "idn": "21130", "attr_a": "CPU_퀄컴","attr_b": "모델명"}, 
    {"idx": "4", "idn": "21130", "attr_a": "CPU_삼성","attr_b": "모델명"}, 
    {"idx": "5", "idn": "21130", "attr_a": "디스플레이_화면(비법정)", "attr_b": "모델명"}, 
    {"idx": "6", "idn": "21130", "attr_a": "카메라화소_화소수(후면)","attr_b": "모델명"}, 
    {"idx": "7", "idn": "21130", "attr_a": "메모리_내장메모리","attr_b": "모델명"}, 
    {"idx": "8", "idn": "21130", "attr_a": "디스플레이_화면","attr_b": "모델명"}, 
    {"idx": "9", "idn": "21130", "attr_a": "규격_세로","attr_b": "모델명"}, 
    {"idx": "10", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "11", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "12", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "13", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "14", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "15", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "16", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "17", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "18", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "19", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "20", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "21", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "22", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "23", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "24", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "25", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "26", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "27", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "28", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "29", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "30", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "31", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "32", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "33", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "34", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "35", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "36", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "37", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "38", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "39", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "40", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "41", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "42", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "43", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "44", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "45", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "46", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "47", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "48", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
    {"idx": "49", "idn": "21130", "attr_a": "CPU_","attr_b": "모델명"}, 
]

// 속성순서세팅 가짜 데이터
var relatedDatalist1 = [
    {"attr_a": "CPU_미디어텍","attr_b": "모델명", "attr_c":"코어i7-6700"}, 
    {"attr_a": "CPU_기타","attr_b": "모델명", "attr_c":"코어i7-7700"}, 
    {"attr_a": "CPU_퀄컴","attr_b": "모델명", "attr_c":"코어i7-7700K"}, 
    {"attr_a": "CPU_삼성","attr_b": "모델명", "attr_c":"코어i7-8700"}, 
    {"attr_a": "디스플레이_화면(비법정)","attr_b": "모델명", "attr_c":"코어i7-6700"}, 
    {"attr_a": "카메라화소_화소수(후면)","attr_b": "모델명", "attr_c":"코어i7-6700"}, 
    {"attr_a": "메모리_내장메모리","attr_b": "모델명", "attr_c":"코어i7-6700"}, 
    {"attr_a": "디스플레이_화면","attr_b": "모델명", "attr_c":"코어i7-6700"}, 
    {"attr_a": "CPU_삼성","attr_b": "모델명", "attr_c":"코어i7-8700"}, 
    {"attr_a": "디스플레이_화면(비법정)","attr_b": "모델명", "attr_c":"코어i7-6700"}, 
    {"attr_a": "카메라화소_화소수(후면)","attr_b": "모델명", "attr_c":"코어i7-6700"}, 
    {"attr_a": "메모리_내장메모리","attr_b": "모델명", "attr_c":"코어i7-6700"}, 
    {"attr_a": "디스플레이_화면","attr_b": "모델명", "attr_c":"코어i7-6700"}, 
    {"attr_a": "CPU_삼성","attr_b": "모델명", "attr_c":"코어i7-8700"}, 
    {"attr_a": "디스플레이_화면(비법정)","attr_b": "모델명", "attr_c":"코어i7-6700"}, 
    {"attr_a": "카메라화소_화소수(후면)","attr_b": "모델명", "attr_c":"코어i7-6700"}, 
    {"attr_a": "메모리_내장메모리","attr_b": "모델명", "attr_c":"코어i7-6700"}, 
    {"attr_a": "디스플레이_화면","attr_b": "모델명", "attr_c":"코어i7-6700"}, 
    {"attr_a": "규격_세로","attr_b": "모델명", "attr_c":"코어i7-6700"}
]

// 용어사전/연관속성 가짜 데이터
var termsDatalist1 = [
    {"attr_a": "146932","attr_b": "화소", "attr_c":"화소"}, 
    {"attr_a": "146932","attr_b": "화소", "attr_c":"화소"}, 
    {"attr_a": "146932","attr_b": "화소", "attr_c":"화소"}, 
    {"attr_a": "146932","attr_b": "화소", "attr_c":"화소"}, 
    {"attr_a": "146932","attr_b": "화소", "attr_c":"화소"}, 
    {"attr_a": "146932","attr_b": "화소", "attr_c":"화소"}, 
    {"attr_a": "146932","attr_b": "화소", "attr_c":"화소"}, 
    {"attr_a": "146932","attr_b": "화소", "attr_c":"화소"}, 
    {"attr_a": "146932","attr_b": "화소", "attr_c":"화소"},
    {"attr_a": "146932","attr_b": "화소", "attr_c":"화소"}, 
    {"attr_a": "146932","attr_b": "화소", "attr_c":"화소"}, 
    {"attr_a": "146932","attr_b": "화소", "attr_c":"화소"}, 
    {"attr_a": "146932","attr_b": "화소", "attr_c":"화소"}, 
    {"attr_a": "146932","attr_b": "화소", "attr_c":"화소"}, 
    {"attr_a": "146932","attr_b": "화소", "attr_c":"화소"}, 
    {"attr_a": "146932","attr_b": "화소", "attr_c":"화소"}, 
    {"attr_a": "146932","attr_b": "화소", "attr_c":"화소"}, 
    {"attr_a": "146932","attr_b": "화소", "attr_c":"화소"}
]

/*********************************
 * DHTMLX 위젯 생성하여, attach 합니다.
 * FORM 위젯 내 > css명 수정X
 * FORM 위젯 내 > options value 는 수정해서 사용해주세요.
 * FORM 위젯 내 > id 변경 시, 공유해 주세요.
*********************************/
// 1단계속성 헤더
var stepFormHeader1 = new dhx.Form(null, {
    css: "step_header",
    padding: "0 10px",
    width: "100%",
    // ************************* 220121 : SR#51071 : row/col 구조 변경 
    // 셀렉트 폼 추가 
    rows: [
        {
            cols:[   
                {
                    css:"ipt-group",
                    cols: [   
                        {
                            id: "selector123452353",
                            name: "select",
                            type: "select",
                            label: "",
                            labelPosition: "left",
                            labelWidth: 0,
                            value: "속성명",
                            required: true,
                            options: [
                                {
                                    value: "1",
                                    content: "관리용 속성명"
                                },
                                {
                                    value: "2",
                                    content: "전시용 속성명"
                                },
                                {
                                    value: "3",
                                    content: "속성ID"
                                },
                                {
                                    value: "4",
                                    content: "용어사전 제목"
                                },
                                {
                                    value: "5",
                                    content: "용어사전 번호"
                                }
                            ],
                            css: "control-comm sel-sort"
                        },
                        {
                            id: "step1Keyword",
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
                            id: "step1Submit",
                            type: "button",
                            text:"검색",
                            css: "control-comm btn-srch"
                        }
                    ]
                },
                {
                    css:"btn-group",
                    cols: [
                        {
                            name: "text",
                            type: "text",
                            value: "1단계 속성 : 120건",
                            css: "tx_count"
                        },
                        {
                            type: "button",
                            text: "추가",
                            id: "btnAdd",
                            css: "control-comm"
                        },
                        {
                            type: "button",
                            text: "저장",
                            id: "btnSave",
                            css: "control-comm"
                        },
                        {
                            type: "button",
                            text: "삭제",
                            id: "btnDel",
                            css: "control-comm"
                        },
                        {
                            type: "button",
                            text: "속성 ▲",
                            id: "btnAttrOpen",
                            css: "control-comm btn-attr"
                        },
                    ]            
                }
            ]
        },
        {
            css:"tx_count",
            cols:[                
                {
                    name: "text",
                    type: "text",
                    value: "1단계 속성 : 120건",
                },
            ]
        }
    ]
    
});
$(function(){
    // 검색 인풋 위젯은 아래처럼 이벤트 걸어주시면 됩니다.
    $("#step1Keyword").keyup(function(e){
        if(e.key === 'Enter' || e.keyCode === 13){
            console.log("Enter" + e)
        }
    })
    stepFormHeader1.getItem("step1Submit").events.on("click", function(e) {
        console.log(e)
    })

    // ************************* 220121 : SR#51071 : 추가 버튼 클릭 레이어  
    stepFormHeader1.getItem("btnAdd").events.on("click", function(e) {
        $('#step1attrAdd').fadeIn(); // 1단계 속성 추가
    })
})

// 2단계속성원 헤더
var stepFormHeader2 = new dhx.Form(null, {
    css: "step_header",
    padding: "0 10px",
    width: "100%",
    // ************************* 220121 : SR#51071 : row/col 구조 변경 
    // 셀렉트 폼 추가 
    rows:[
        {
            cols:[
                {
                    css:"ipt-group",
                    cols: [  
                        {
                            id: "Selector123452353",
                            name: "select",
                            type: "select",
                            label: "",
                            labelPosition: "left",
                            labelWidth: 0,
                            value: "속성원명",
                            required: true,
                            options: [
                                {
                                    value: "0",
                                    content: "속성원명"
                                },
                                {
                                    value: "1",
                                    content: "속성원ID"
                                },
                            ],
                            css: "control-comm sel-sort"
                        },
                        {
                            id: "step2Keyword",
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
                            id: "step2Submit",
                            type: "button",
                            text:"검색",
                            css: "control-comm btn-srch"
                        }
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
                            text: "저장",
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
        },
        {
            css:"tx_count",
            cols: [
                {
                    name: "text",
                    type: "text",
                    value: "2단계 속성 : 25,777건",
                }
            ]
        }
    ]
    
});
$(function(){
    // ************************* 220121 : SR#51071 : 추가 버튼 클릭 레이어 
    stepFormHeader2.getItem("btnAdd").events.on("click", function(e) {
        $('#step2attrAdd').fadeIn(); // 2단계 속성원 추가
    })
})

// 속성순서세팅 헤더
var stepFormHeader3 = new dhx.Form(null, {
    css: "step_header",
    padding: "0 10px",
    width: "100%",
    rows:[
        {
            css:"ipt-group",
            cols: [
                {
                    id: "stepAlignKeyword",
                    name: "input",
                    type: "input",
                    label: "",
                    labelPosition: "left",
                    icon: "dxi dxi-magnify",
                    labelWidth: 0,
                    required: true,
                    // ************************* 220121 : SR#51071 : 모델번호 복사 인풋 으로 변경
                    placeholder: "",
                    css: "control-comm ipt-modelnum"
                },
                {
                    id: "stepAlignSubmit",
                    type: "button",
                    // ************************* 220121 : SR#51071 : 모델번호 복사 인풋 으로 변경
                    text:"복사",
                    css: "control-comm btn-copy"
                },
                {
                    type: "radioGroup",
                    name: "radioGroup",
                    disabled: false,
                    required: false,
                    css: "control-comm ipt-radio",
                    options: {
                        css: "step_radio-group",
                        cols: [
                            {
                                type: "radioButton",
                                text: "중",
                                value: "",
                            },
                            {
                                type: "radioButton",
                                text: "소",
                                value: "",
                            },
                            {
                                type: "radioButton",
                                text: "미",
                                value: "",
                            }
                        ]
                    },
                },
                {
                    type: "button",
                    text: "추가",
                    id: "btnAdd",
                    css: "control-comm"
                },
                {
                    type: "button",
                    text: "저장",
                    id: "btnSave",
                    css: "control-comm"
                },
                {
                    type: "button",
                    text: "삭제",
                    id: "btnDel",
                    css: "control-comm"
                },/* 
                {
                    type: "button",
                    text: "Enuri ▲",
                    id: "btnAttrOpen",
                    css: "control-comm btn-attr"
                } */
            ]
        },
        // ************************* 220121 : SR#51071 : 속성 순서 건수 추가
        {
            css:"btn-group",
            cols: [
                {
                    name: "text",
                    type: "text",
                    value: "속성 순서 : 77건",
                    css: "tx_cnt"
                }
            ]            
        }
    ]
});

// 대표 자동(연관)속성 헤더
var relatedFormHeader1 = new dhx.Form(null, {
    css: "step_header",
    padding: "0 10px",
    width: "100%",
    cols:[
        {
            name: "text",
            type: "text",
            value: "대표 연관속성",
            css: "tx_tit"
        },
        {
            css:"btn-group",
            cols: [
                {
                    type: "button",
                    text: "등록",
                    id: "btnAdd",
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
// 연관상품 헤더
var relatedFormHeader2 = new dhx.Form(null, {
    css: "step_header",
    padding: "0 10px",
    width: "100%",
    cols:[
        {
            name: "text",
            type: "text",
            value: "연관속성",
            css: "tx_tit"
        },
        {
            css:"btn-group",
            cols: [
                {
                    type: "button",
                    text: "등록",
                    id: "btnAdd",
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

// 용어사전 1단계 속성 헤더
var termsFormHeader1 = new dhx.Form(null, {
    css: "step_header align-right",
    padding: "0 10px",
    width: "100%",
    rows:[
        {
            css:"ipt-group",
            cols: [
                {
                    name: "text",
                    type: "text",
                    value: "1단계 속성 : 9건",
                    css: "tx_tit"
                },
                {
                    css:"btn-group",
                    cols: [
                        {
                            type: "button",
                            text: "등록 리스트",
                            id: "btnRegistList",
                            css: "control-comm btn-regist"
                        },
                        {
                            type: "button",
                            text: "용어사전",
                            id: "btnDic",
                            css: "control-comm btn-dic"
                        }
                    ]            
                }
            ]
        },        
        {
            css:"btn-group",
            cols: [
                {
                    css:"ipt-group",
                    cols: [
                        {
                            id: "stepAlignKeyword",
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
                            id: "stepAlignSubmit",
                            type: "button",
                            text:"검색",
                            css: "control-comm btn-srch"
                        }
                    ]
                },
                {
                    type: "button",
                    text: "추가",
                    id: "btnAdd",
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

// 용어사전 2단계 속성 헤더
var termsFormHeader2 = new dhx.Form(null, {
    css: "step_header",
    padding: "0 10px",
    width: "100%",
    rows:[
        {
            name: "text",
            type: "text",
            value: "2단계 속성 : **건",
            css: "tx_tit"
        },  
        {
            css:"btn-group",
            cols: [
                {
                    css:"ipt-group",
                    cols: [
                        {
                            id: "stepAlignKeyword",
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
                            id: "stepAlignSubmit",
                            type: "button",
                            text:"검색",
                            css: "control-comm btn-srch"
                        }
                    ]
                },
                {
                    type: "button",
                    text: "추가",
                    id: "btnAdd",
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
var stepGrid1, stepGrid2, stepGrid3; // 1단계속성, 2단계속성원, 속성순서세팅 그리드
var relatedGrid1, relatedGrid2; // 자동속성 > 대표연관속성, 연관속성 그리드
var termsGrid1, termsGrid2; // 용어사전 1단계,2단계

// 1단계 속성 그리드 생성
// ************************* 220121 : SR#51071 : 1단계속성 필드 추가, adjust 옵션 추가(true)
stepGrid1 = new dhx.Grid(null, {
    columns: [ 
        {id: "idn",     width: 60, header: [{ text: "ID", align: "center" }], align: "center" },
        {id: "attr_a",  header: [{ text: "관리용 속성명", align: "center" }], align: "left" },
        {id: "attr_b",  header: [{ text: "전시용 속성명", align: "center" }], align: "center" },
        {id: "attr_c",  width: 60, header: [{ text: "핵심", align: "center" }], editorType: "select", options: [0, 1], maxWidth:60, align: "center",
            tooltipTemplate: (value, row, col) => "(0:비핵심, 1:핵심)"},
        {id: "attr_d",  width: 60, header: [{ text: "노출", align: "center" }], editorType: "select", options: [0, 1], maxWidth:60, align: "center",
            tooltipTemplate: (value, row, col) => "(0:미노출, 1:노출)"},
        {id: "attr_e",  width: 60, header: [{ text: "M노출", align: "center" }], editorType: "select", options: [0, 1], maxWidth:60, align: "center",
            tooltipTemplate: (value, row, col) => "(0, 1)"},
        {id: "attr_f",  width: 60, header: [{ text: "구분", align: "center" }], editorType: "select", options: [1, 2], maxWidth:60, align: "center",
            tooltipTemplate: (value, row, col) => "(1:값, 2:범위)"},
        {id: "attr_g",  header: [{ text: "대표ID", align: "center" }], maxWidth:60, align: "center",
            tooltipTemplate: (value, row, col) => "(1:값, 2:범위)"},
        {id: "attr_h",  header: [{ text: "대표기호", align: "center" }], maxWidth:60, align: "center",
        tooltipTemplate: (value, row, col) => "(1:값, 2:범위)"},
        {id: "attr_i",  header: [{ text: "속성원기호", align: "center" }], maxWidth:60, align: "center",
            tooltipTemplate: (value, row, col) => "(1:값, 2:범위)"},
        {id: "attr_j",  width: 60, header: [{ text: "볼드", align: "center" }], editorType: "select", options: [0, 1], maxWidth:60, align: "center",
        tooltipTemplate: (value, row, col) => "(1:값, 2:범위)"},
        {id: "attr_k",  width: 60, header: [{ text: "전송", align: "center" }], editorType: "select", options: [0, 1], maxWidth:60, align: "center",
            tooltipTemplate: (value, row, col) => "(1:값, 2:범위)"},
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth: true,
    data: stepDatalist1,
    editable: true,
    selection: "row",
    multiselection:true,
    adjust:true,
    keyNavigation: true,
    resizable:true,
});
stepGrid1.events.on("beforeEditStart", function(row,col,editorType){
    if(col.id === "idn"){ // ID 수정 X
        return false;
    }
});
// ************************* 220121 : SR#51071 : 1단계속성 필드 우클릭 레이어 추가
/* 1단계 속성 우클릭 (개발 common.js 참고) */
var stepGrid1Popup = new dhx.Popup({
    css: "pop_headecell-sort"
});
var stepGrid1PopHtml = "";

stepGrid1PopHtml += "<div>";
stepGrid1PopHtml += "	<input type=\'checkbox\' id=\'attr_e\' name=\'stepGrid1Chk\' onclick='customField(\"attr_e\");' checked='checked'>M노출	<br>";
stepGrid1PopHtml += "	<input type=\'checkbox\' id=\'attr_g\' name=\'stepGrid1Chk\' onclick='customField(\"attr_g\");' checked='checked'>대표ID	<br>";
stepGrid1PopHtml += "	<input type=\'checkbox\' id=\'attr_h\' name=\'stepGrid1Chk\' onclick='customField(\"attr_h\");' checked='checked'>대표기호	<br>";
stepGrid1PopHtml += "	<input type=\'checkbox\' id=\'attr_i\' name=\'stepGrid1Chk\' onclick='customField(\"attr_i\");' checked='checked'>속성원기호	<br>";
stepGrid1PopHtml += "	<input type=\'checkbox\' id=\'attr_j\' onclick=\'customField(\"attr_j\");\' name='stepGrid1Chk' checked='checked'>볼드	<br>";
stepGrid1PopHtml += "	<input type=\'checkbox\' id=\'attr_k\' onclick=\'customField(\"attr_k\");\' name='stepGrid1Chk' checked='checked'>전송	<br>";
stepGrid1PopHtml += "</div>";
stepGrid1Popup.attachHTML(stepGrid1PopHtml);
const stepGrid1config = {
    centering: true,
    mode: "bottom",
    indent: 0
};
stepGrid1.events.on("headerCellRightClick", function(col, e){
    e.preventDefault();
    stepGrid1Popup.show(e.srcElement, stepGrid1config);
})
function customField(item) {
	if(!$("#"+item).is(":checked")){
		stepGrid1.hideColumn(item);
	}else{
		stepGrid1.showColumn(item);
	}
}
/* // */
// 2단계속성원 그리드 생성
// ************************* 220121 : SR#51071 : 1단계속성 필드 추가, adjust 옵션 추가(true)
stepGrid2 = new dhx.Grid(null, {
    columns: [
        {id: "idn", width: 60, header: [{ text: "ID", align: "center" }], align: "center", gravity: 1.5 },
        {id: "attr_a", width: 60, header: [{ text: "순서", align: "center" }], align: "center" },
        {id: "attr_b", header: [{ text: "속성원명", align: "center" }], align: "left" },
        {id: "attr_c", width: 60, header: [{ text: "노출", align: "center" }], editorType: "select", options: [0, 1], maxWidth:60, align: "center",
            tooltipTemplate: (value, row, col) => "(0:미노출, 1:노출)"
        },
        {id: "attr_d", width: 60, header: [{ text: "상세검색", align: "center" }], align: "center" },
        {id: "attr_e", width: 60, header: [{ text: "볼드", align: "center" }], editorType: "select", options: [0, 1], maxWidth:60, align: "center",
            tooltipTemplate: (value, row, col) => "(0, 1)"
        },
        {id: "attr_f", width: 60, header: [{ text: "강조", align: "center" }], editorType: "select", options: [0, 1], maxWidth:60, align: "center",
            tooltipTemplate: (value, row, col) => "(0, 1)"
        },
        {id: "attr_g", header: [{ text: "아이콘", align: "center" }], maxWidth:60, align: "center"},
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth: true,
    data: stepDatalist2,
    editable: true,
    selection: "row",
    multiselection:true,
    keyNavigation: true,
    adjust: true,
    resizable:true,
});
stepGrid2.events.on("beforeEditStart", function(row,col,editorType){
    console.log(col.id)
    if(col.id === "idn"){ // ID 수정 X
        return false;
    }
});
// ************************* 220121 : SR#51071 : 1단계속성 필드 우클릭 레이어 추가
/* 2단계 속성 우클릭 (개발 common.js 참고) */
var stepGrid2Popup = new dhx.Popup({
    css: "pop_headecell-sort"
});
var stepGrid2PopHtml = "";

stepGrid2PopHtml += "<div>";
stepGrid2PopHtml += "	<input type=\'checkbox\' id=\'attr_e\' name=\'stepGrid2Chk\' onclick='customField2(\"attr_e\");' checked='checked'>볼드	<br>";
stepGrid2PopHtml += "	<input type=\'checkbox\' id=\'attr_f\' name=\'stepGrid2Chk\' onclick='customField2(\"attr_f\");' checked='checked'>강조	<br>";
stepGrid2PopHtml += "	<input type=\'checkbox\' id=\'attr_g\' name=\'stepGrid2Chk\' onclick='customField2(\"attr_g\");' checked='checked'>아이콘	<br>";
stepGrid2PopHtml += "</div>";
stepGrid2Popup.attachHTML(stepGrid2PopHtml);
const stepGrid2config = {
    centering: true,
    mode: "bottom",
    indent: 0
};
stepGrid2.events.on("headerCellRightClick", function(col, e){
    e.preventDefault();
    stepGrid2Popup.show(e.srcElement, stepGrid2config);
})
function customField2(item) {
	if(!$("#"+item).is(":checked")){
		stepGrid2.hideColumn(item);
	}else{
		stepGrid2.showColumn(item);
	}
}
/* // */
// 속성순서세팅 그리드 생성
stepGrid3 = new dhx.Grid(null, {
    columns: [
        {id: "idx", width: 60, header: [{ text: "순서", align: "center" }], align: "center" },
        {id: "idn", width: 60, header: [{ text: "ID", align: "center" }], align: "center" },
        {id: "attr_a", header: [{ text: "관리용 속성명", align: "center" }], align: "left" },
        {id: "attr_b", header: [{ text: "전시용 속성명", align: "center" }], align: "left" },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth: true,
    data: stepDatalist3,
    editable: true, 
    selection: "row",
    multiselection:true,
    keyNavigation: true,
    resizable:true,
});
stepGrid3.events.on("beforeEditStart", function(row,col,editorType){
    if(col.id != "idx"){ // ID 수정 X
        return false;
    }
});
// 자동(연관)속성 > 대표 연관속성 그리드 생성
relatedGrid1 = new dhx.Grid(null, {
    columns: [
        {id: "attr_a", header: [{ text: "관리용 속성명", align: "center" }], align: "left" },
        {id: "attr_b", header: [{ text: "전시용 속성명", align: "center" }], align: "left" },
        {id: "attr_c", header: [{ text: "속성원명", align: "center" }], align: "left" },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth: true,
    data: relatedDatalist1,
    selection: "row",
    multiselection:true,
    keyNavigation: true,
    resizable:true,
    tooltip: false,
});
// 자동(연관)속성 > 연관속성 그리드 생성
relatedGrid2 = new dhx.Grid(null, {
    columns: [
        {id: "attr_a", header: [{ text: "관리용 속성명", align: "center" }], align: "left" },
        {id: "attr_b", header: [{ text: "전시용 속성명", align: "center" }], align: "left" },
        {id: "attr_c", header: [{ text: "속성원명", align: "center" }], align: "left" },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth: true,
    data: relatedDatalist1,
    selection: "row",
    multiselection:true,
    keyNavigation: true,
    resizable:true,
    tooltip: false,
});
// 용어사전 1단계속성 그리드 생성
termsGrid1 = new dhx.Grid(null, {
    columns: [
        {id: "attr_a", header: [{ text: "용어ID", align: "center" }], align: "center", gravity: 1.5 },
        {id: "attr_b", header: [{ text: "제목", align: "center" }], align: "left" },
        {id: "attr_c", header: [{ text: "요약동의어", align: "center" }], align: "left" },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth: true,
    data: termsDatalist1,
    selection: "row",
    multiselection:true,
    keyNavigation: true,
    resizable:true,
    tooltip: false,
});
// 용어사전 2단계속성 그리드 생성
termsGrid2 = new dhx.Grid(null, {
    columns: [
        {id: "attr_a", header: [{ text: "용어ID", align: "center" }], align: "center", gravity: 1.5 },
        {id: "attr_b", header: [{ text: "제목", align: "center" }], align: "left" },
        {id: "attr_c", header: [{ text: "요약동의어", align: "center" }], align: "left" },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth: true,
    data: termsDatalist1,
    selection: "row",
    multiselection:true,
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

    // 그리드 컨텐츠 
    rows: [
        {
            type:"space",
            id: "rowTop",
            cols:[
                {
                    // 1단계속성 COL
                    type: "line",
                    id: "stepAttr1",
                    headerHeight:32,
                    header: "[1단계 속성]",
                    collapsable: false,
                    htmlEnable: true,
                    resizable: false,
                    customScroll: true,
                    rows : [
                        {
                            // 1단계속성 HEADER
                            // ************************* 220121 : SR#51071 : 높이 변경 48 -> 78
                            id: "stepHeader1",
                            height: "78px"
                        },
                        {
                            // 1단계속성 GRID
                            id: "stepGrid1",
                            // ************************* 220121 : SR#51071 : 높이 변경 48 -> 78
                            height:"calc(100% - 78px)"
                        }
                    ]
                },
                {
                    // 2단계속성원 COL
                    type: "line",
                    id: "stepAttr2",
                    headerHeight:32,
                    header: "[2단계 속성원]",
                    collapsable: false,
                    htmlEnable: true,
                    resizable: false,
                    customScroll: true,
                    rows : [
                        {
                            // 2단계속성원 HEADER
                            id: "stepHeader2",
                            // ************************* 220121 : SR#51071 : 높이 변경 48 -> 78
                            height: "78px"
                        },
                        {
                            // 2단계속성원 GRID
                            id: "stepGrid2",
                            // ************************* 220121 : SR#51071 : 높이 변경 48 -> 78
                            height:"calc(100% - 78px)"
                        }
                    ]
                },
                {
                    // 속성순서세팅 COL
                    type: "line",
                    id: "stepAlignSet",
                    headerHeight:32,
                    header: "[속성 순서 세팅]",
                    width:400,
                    collapsable: true,
                    htmlEnable: true,
                    resizable: false,
                    customScroll: true,
                    rows : [
                        {
                            // 속성순서세팅 HEADER
                            id: "stepHeader3",
                            height: "78px"
                        },
                        {
                            // 속성순서세팅 GRID
                            id: "stepGrid3",
                            height:"calc(100% - 78px)"
                        }
                    ]
                },
                {
                    // 자동(연관)속성 COL
                    type: "line",
                    id: "autoAttribute",
                    headerHeight:32,
                    header: "[자동(연관) 속성]",
                    width:400,
                    collapsable: true,
                    collapsed: false,
                    htmlEnable: true,
                    resizable: false,
                    customScroll: true,
                    rows : [
                        {
                            // 대표연관속성 HEADER
                            id: "relatedHeader1",
                            height: "48px"
                        },
                        {
                            // 대표연관속성 GRID
                            id: "relatedGrid1",
                            height:"calc(50% - 48px)"
                        },
                        {
                            // 연관속성 HEADER
                            id: "relatedHeader2",
                            height: "48px"
                        },
                        {
                            // 연관속성 GRID
                            id: "relatedGrid2",
                            height:"calc(50% - 48px)"
                        }
                    ]
                },
                {
                    // 용어사전 COL
                    type: "line",
                    id: "dicAttribute",
                    headerHeight:32,
                    header: "[용어사전]",
                    width:400,
                    collapsable: true,
                    htmlEnable: true,
                    resizable: false,
                    customScroll: true,
                    rows : [
                        {
                            // 용어사전 상단 HEADER
                            id: "termsHeader1",
                            height: "76px"
                        },
                        {
                            // 용어사전 상단 GRID
                            id: "termsGrid1",
                            height:"calc(50% - 76px)"
                        },
                        {
                            // 용어사전 > 연관속성 HEADER
                            id: "termsHeader2",
                            height: "76px"
                        },
                        {
                            // 용어사전 > 연관속성 GRID
                            id: "termsGrid2",
                            height:"calc(50% - 76px)"
                        }
                    ]
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
    contentLayout.getCell("stepGrid1").attach(stepGrid1); // 1단계속성 GRID
    contentLayout.getCell("stepGrid2").attach(stepGrid2); // 2단계속성 GRID
    contentLayout.getCell("stepGrid3").attach(stepGrid3); // 3단계속성 GRID    
    contentLayout.getCell("relatedGrid1").attach(relatedGrid1); // 대표 자동(연관)상품 GRID
    contentLayout.getCell("relatedGrid2").attach(relatedGrid2); // 연관속성 GRID
    contentLayout.getCell("termsGrid1").attach(termsGrid1); // 용어사전 1단계 GRID 
    contentLayout.getCell("termsGrid2").attach(termsGrid2); // 용어사전 1단계 GRID 

    contentLayout.getCell("stepHeader1").attach(stepFormHeader1); // 1단계속성 헤더
    contentLayout.getCell("stepHeader2").attach(stepFormHeader2); // 2단계속성 헤더
    contentLayout.getCell("stepHeader3").attach(stepFormHeader3); // 3단계속성 GRID헤더
    contentLayout.getCell("relatedHeader1").attach(relatedFormHeader1); // 대표 자동(연관)상품 헤더
    contentLayout.getCell("relatedHeader2").attach(relatedFormHeader2); // 연관속성 헤더
    contentLayout.getCell("termsHeader1").attach(termsFormHeader1); // 용어사전 1단계 G헤더
    contentLayout.getCell("termsHeader2").attach(termsFormHeader2); // 용어사전 1단계 G헤더

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

    // 최초 상태 속성순서세팅,자동속성,용어사전 CELL collapse
    contentLayout.cell("stepAlignSet").collapse();
    contentLayout.cell("autoAttribute").collapse();
    contentLayout.cell("dicAttribute").collapse();

    
    // 콜랩스된 영역은 확장 후 이벤트를 별도로 주어야함.
    contentLayout.events.on("afterExpand", function(id){

        
        if(id === "dicAttribute"){ // 용어사전 영역 확장 > 용어사전 클릭 레이어 
            // 용어사전 레이어 노출
            termsFormHeader1.getItem("btnDic").events.on("click", function(e){
                $("#dictionaryLayer").show();
            })

            termsFormHeader1.getItem("btnRegistList").events.on("click", function(e){
                window.open("http://jca.enuri.com/knowbox/admin/termdictitle/TermDicTitleSearch.asp?lcate=03&mcate=04&srch_item=0&srch_word=%C8%AD%BC%D2");
            })
        }
    });
})

/*********************************
 * 용어사전 레이어 
 * 레이아웃, 그리드 생성 
*********************************/
var btnListData = [ // 용어사전 그리드 데이터
    {"idn": "21130","attr_a": "기본사양_알뜰폰","attr_b": "알뜰폰", "attr_c": 1, "attr_d": "알뜰폰", "attr_e": 44769, "attr_f": "알뜰폰(MVNO)"}, 
    {"idn": "21130","attr_a": "기본사양_알뜰폰","attr_b": "알뜰폰", "attr_c": 1, "attr_d": "알뜰폰", "attr_e": 44769, "attr_f": "알뜰폰(MVNO)"}, 
    {"idn": "21130","attr_a": "기본사양_알뜰폰","attr_b": "알뜰폰", "attr_c": 1, "attr_d": "알뜰폰", "attr_e": 44769, "attr_f": "알뜰폰(MVNO)"}, 
    {"idn": "21130","attr_a": "기본사양_알뜰폰","attr_b": "알뜰폰", "attr_c": 1, "attr_d": "알뜰폰", "attr_e": 44769, "attr_f": "알뜰폰(MVNO)"}, 
    {"idn": "21130","attr_a": "기본사양_알뜰폰","attr_b": "알뜰폰", "attr_c": 1, "attr_d": "알뜰폰", "attr_e": 44769, "attr_f": "알뜰폰(MVNO)"}, 
    {"idn": "21130","attr_a": "기본사양_알뜰폰","attr_b": "알뜰폰", "attr_c": 1, "attr_d": "알뜰폰", "attr_e": 44769, "attr_f": "알뜰폰(MVNO)"}, 
    {"idn": "21130","attr_a": "기본사양_알뜰폰","attr_b": "알뜰폰", "attr_c": 1, "attr_d": "알뜰폰", "attr_e": 44769, "attr_f": "알뜰폰(MVNO)"}, 
    {"idn": "21130","attr_a": "기본사양_알뜰폰","attr_b": "알뜰폰", "attr_c": 1, "attr_d": "알뜰폰", "attr_e": 44769, "attr_f": "알뜰폰(MVNO)"}, 
    {"idn": "21130","attr_a": "기본사양_알뜰폰","attr_b": "알뜰폰", "attr_c": 1, "attr_d": "알뜰폰", "attr_e": 44769, "attr_f": "알뜰폰(MVNO)"}, 
    {"idn": "21130","attr_a": "기본사양_알뜰폰","attr_b": "알뜰폰", "attr_c": 1, "attr_d": "알뜰폰", "attr_e": 44769, "attr_f": "알뜰폰(MVNO)"}, 
    {"idn": "21130","attr_a": "기본사양_알뜰폰","attr_b": "알뜰폰", "attr_c": 1, "attr_d": "알뜰폰", "attr_e": 44769, "attr_f": "알뜰폰(MVNO)"}, 
    {"idn": "21130","attr_a": "기본사양_알뜰폰","attr_b": "알뜰폰", "attr_c": 1, "attr_d": "알뜰폰", "attr_e": 44769, "attr_f": "알뜰폰(MVNO)"}, 
    {"idn": "21130","attr_a": "기본사양_알뜰폰","attr_b": "알뜰폰", "attr_c": 1, "attr_d": "알뜰폰", "attr_e": 44769, "attr_f": "알뜰폰(MVNO)"}, 
    {"idn": "21130","attr_a": "기본사양_알뜰폰","attr_b": "알뜰폰", "attr_c": 1, "attr_d": "알뜰폰", "attr_e": 44769, "attr_f": "알뜰폰(MVNO)"}, 
    {"idn": "21130","attr_a": "기본사양_알뜰폰","attr_b": "알뜰폰", "attr_c": 1, "attr_d": "알뜰폰", "attr_e": 44769, "attr_f": "알뜰폰(MVNO)"}, 
    {"idn": "21130","attr_a": "기본사양_알뜰폰","attr_b": "알뜰폰", "attr_c": 1, "attr_d": "알뜰폰", "attr_e": 44769, "attr_f": "알뜰폰(MVNO)"}, 
];

// 용어사전 그리드 생성
var dictionGrid = new dhx.Grid('#attrDicList', {
    columns: [
        { id: "idn", header: [{ text: "속성ID", align: "center" }], align:"center" },
        { id: "attr_a", header: [{ text: "관리용 속성명", align: "center" }], align:"center" },
        { id: "attr_b", header: [{ text: "전시용 속성명", align: "center" }], align:"center" },
        { id: "attr_c", header: [{ text: "속성원ID", align: "center" }], align:"center" },
        { id: "attr_d", header: [{ text: "속성원명", align: "center" }], align:"center" },
        { id: "attr_e", header: [{ text: "용어사전ID", align: "center" }], align:"center" },
        { id: "attr_f", header: [{ text: "용어사전 제목", align: "center" }], align:"center" },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth:true,
    data: btnListData,
    adjust: true,
    selection: "row"
});

// 그룹조건 검색어 입력
var dicKeyword = new dhx.Form(null, {
    css: "spec_header dic_keyowrd",
    padding: "0 10px",
    width: "100%",
    rows:[
        {
            css:"ipt-group",
            cols: [
                {
                    id: "keywordSelect",
                    name: "select",
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
                            content: "셀렉트 타이틀1"
                        },
                        {
                            value: "2",
                            content: "셀렉트 타이틀2"
                        }
                    ],
                    css: "control-comm sel-sort"
                },
                {
                    id: "dicAttrKeyword",
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
                    id: "dicAttrSubmit",
                    type: "button",
                    text:"검색",
                    css: "control-comm btn-srch"
                }
            ]
        },  
    ]
});

// 조검검색 그리드 내 레이아웃
var dictionConfig = {
    type: "line", // space, wide, line
    width:"100%",
    maxWidth:"100%",
    rows: [
        {
            // 스펙그룹 ROW
            type: "space",
            width:"100%",
            rows : [
                {
                    id: "dicKeyword",
                    height:40
                },
                {
                    // 1단계속성 HEADER
                    id: "dictionGrid"
                },
            ]
        },
    ]
};
var groupCondLayout = new dhx.Layout("dictionLayout", dictionConfig);

    groupCondLayout.getCell("dicKeyword").attach(dicKeyword);
    groupCondLayout.getCell("dictionGrid").attach(dictionGrid);
