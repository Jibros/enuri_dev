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
 * 서브 > 스펙 관리 컨텐츠
 *********************************/

// 스펙그룹 가짜 데이터
var specGroupData = [
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
    {"attr_a": "1","attr_b": "1","attr_c": "657", "attr_d": "CPU", "attr_e": "0", "attr_f": "111", "attr_g": "0", "attr_h":"", "attr_i": "Y", "attr_j": "" }, 
]
// 스펙그룹상세 가짜 데이터
var specGroupDetailData = [
    {"idn": "1","attr_a": "1","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "2","attr_a": "2","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "3","attr_a": "3","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "4","attr_a": "4","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "5","attr_a": "5","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "6","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "8","attr_a": "7","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "9","attr_a": "8","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "2","attr_a": "9","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "3","attr_a": "10","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "11","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "12","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "13","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "14","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "15","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "16","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "17","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "18","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "19","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "20","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "21","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "22","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "23","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "24","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "25","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "26","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "27","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "28","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "29","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "30","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "31","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "32","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "33","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "34","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "35","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "36","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
    {"idn": "6","attr_a": "37","attr_b": "CPU", "attr_c": 0, "attr_d":"0"}, 
]
// 스펙상세정보 가짜 데이터
var specDetailInfoData = [
    {"attr_a": "5", "attr_b": "5", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "5", "attr_b": "5", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "5", "attr_b": "5", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "5", "attr_b": "5", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "5", "attr_b": "5", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "5", "attr_b": "5", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "5", "attr_b": "5", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "5", "attr_b": "5", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "5", "attr_b": "5", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "0", "attr_b": "0", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "1", "attr_b": "1", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "2", "attr_b": "2", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "3", "attr_b": "3", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "4", "attr_b": "4", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "5", "attr_b": "5", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "6", "attr_b": "6", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "7", "attr_b": "7", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "8", "attr_b": "8", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "9", "attr_b": "9", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "0", "attr_b": "0", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "1", "attr_b": "1", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "2", "attr_b": "2", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "3", "attr_b": "3", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "4", "attr_b": "4", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "5", "attr_b": "5", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "6", "attr_b": "6", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "7", "attr_b": "7", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "8", "attr_b": "8", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "9", "attr_b": "9", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "0", "attr_b": "0", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "1", "attr_b": "1", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "2", "attr_b": "2", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "3", "attr_b": "3", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "4", "attr_b": "4", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "5", "attr_b": "5", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "6", "attr_b": "6", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "7", "attr_b": "7", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "8", "attr_b": "8", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "9", "attr_b": "9", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "0", "attr_b": "0", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "1", "attr_b": "1", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "2", "attr_b": "2", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "3", "attr_b": "3", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "4", "attr_b": "4", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "5", "attr_b": "5", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "6", "attr_b": "6", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "7", "attr_b": "7", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "8", "attr_b": "8", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
    {"attr_a": "9", "attr_b": "9", "attr_c": "21951","attr_d": "코어i9", "attr_e": "", "attr_f": "48813", "attr_g": "0", "attr_h": ""}, 
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
    {"attr_a": "규격_세로","attr_b": "모델명", "attr_c":"코어i7-6700"}
]

// 속성순서세팅 가짜 데이터
var termsDatalist1 = [
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

var specUtil = new dhx.Form(null, {
    css: "spec_header align-right",
    padding: "0 10px",
    width: "100%",
    cols:[
        {
            css:"btn-group",
            cols: [
                {
                    type: "checkbox",
                    text: "미사용 숨기기",
                    name: "checked",
                    css: "control-comm"
                },
                {
                    type: "button",
                    text: "스마트파인더",
                    id: "btnSmartFinder",
                    css: "control-comm btn-smartfinder"
                },
                {
                    type: "button",
                    text: "DEV보기",
                    id: "btnGoDev",
                    css: "control-comm btn-dev"
                },
                {
                    type: "button",
                    text: "그룹조건",
                    id: "btnGroupCond",
                    css: "control-comm"
                },
                {
                    type: "button",
                    text: "LP 이미지 노출 텍스트",
                    id: "btnLPImgText",
                    css: "control-comm"
                },
                {
                    type: "button",
                    text: "Enuri ▲",
                    id: "btnAttrOpen",
                    css: "control-comm btn-attr"
                },
            ]            
        }
    ]
})
// 스마트파인더 핵심속성 관리자 이동
specUtil.getItem("btnSmartFinder").events.on("click", function(e){
    window.open("http://jca.enuri.com:8080/smartFinder/specAdmin/index.jsp")
})
// DEV 미리보기 이동
specUtil.getItem("btnGoDev").events.on("click", function(e){
    window.open("http://dev.enuri.com/list.jsp?cate=0420&openspec=y")
})
// 그룹조건 클릭 > 레이어 노출
// 레이어 내 위젯 하단에 있습니다.
specUtil.getItem("btnGroupCond").events.on("click", function(e){
    $("#groupCondLayer").show();
})
// LP이미지 노출텍스트 클릭 > 레이어 노출
// 레이어 내 위젯 하단에 있습니다.
specUtil.getItem("btnLPImgText").events.on("click", function(e){
    $("#lpImgLayer").show();
})


// 스펙그룹 헤더
var specGroupHeader = new dhx.Form(null, {
    css: "spec_header align-right",
    padding: "0 10px",
    width: "100%",
    cols:[
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
            ]            
        }
    ]
});

// 스펙그룹상세 헤더
var specGroupDetailHeader = new dhx.Form(null, {
    css: "spec_header align-right",
    padding: "0 10px",
    width: "100%",
    cols:[
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
            ]            
        }
    ]
});

// 스펙상세정보 헤더
var specDetailInfoHeader = new dhx.Form(null, {
    css: "spec_header align-right",
    padding: "0 10px",
    width: "100%",
    cols:[
        {
            css:"btn-group",
            cols: [
                {
                    type: "button",
                    text: "용어사전",
                    id: "btnDic",
                    css: "control-comm btn-dic"
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
            ]            
        }
    ]
});
// 스마트파인더 핵심속성 관리자 이동
specDetailInfoHeader.getItem("btnDic").events.on("click", function(e){
    window.open("http://jca.enuri.com/knowbox/admin/termdictitle/TermDicTitleSearch.asp?lcate=03&mcate=04&srch_item=0&srch_word=%C8%AD%BC%D2")
})

/*********************************
 * 각 COL 그리드/리스트 생성하여 attach 합니다.
*********************************/
var specGroup, specGroupDetail, specDetailInfo; // 각 COL 그리드

// 스펙그룹 그리드 생성
specGroup = new dhx.Grid(null, {
    columns: [ 
        {id: "attr_a",  header: [{ text: "PC", align: "center" }], align: "center" },
        {id: "attr_b",  header: [{ text: "M", align: "center" }], align: "center" },
        {id: "attr_c",  header: [{ text: "번호", align: "center" }], align: "center" },
        {id: "attr_d",  header: [{ text: "스펙명", align: "center" }], align: "center" },
        {id: "attr_e",  header: [{ text: "핵심", align: "center" }], align: "center" },
        {id: "attr_f",  header: [{ text: "모델수", align: "center" }], align: "center" },
        {id: "attr_g",  header: [{ text: "서비스", align: "center" }], align: "center" },
        {id: "attr_h",  header: [{ text: "I콘", align: "center" }], align: "center" },
        {id: "attr_i",  header: [{ text: "노출", align: "center" }], align: "center" },
        {id: "attr_j",  header: [{ text: "검색", align: "center" }], align: "center" },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth: true,
    data: specGroupData,
    editable: true,
    selection: "row",
    multiselection:false,
    keyNavigation: true,
    adjust: true,
    resizable:true,
});
// 스펙그룹상세 그리드 생성
specGroupDetail = new dhx.Grid(null, {
    columns: [
        {id: "idn",  header: [{ text: "순서", align: "center" }], align: "center" },
        {id: "attr_a",  header: [{ text: "번호", align: "center" }], align: "center" },
        {id: "attr_b",  header: [{ text: "상세명", align: "center" }], align: "center" },
        {id: "attr_c",  header: [{ text: "AND, OR", align: "center" }], align: "center" },
        {id: "attr_d",  header: [{ text: "서비스", align: "center" }], align: "center" },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth: true,
    data: specGroupDetailData,
    editable: true,
    selection: "row",
    multiselection:false,
    keyNavigation: true,
    resizable:true,
});
// 스펙상세정보 그리드 생성
specDetailInfo = new dhx.Grid(null, {
    columns: [
        {id: "attr_a",  header: [{ text: "PC", align: "center" }], align: "center" },
        {id: "attr_b",  header: [{ text: "M", align: "center" }], align: "center" },
        {id: "attr_c",  header: [{ text: "번호", align: "center" }], align: "center" },
        {id: "attr_d",  header: [{ text: "상세명", align: "center" }], align: "center" },
        {id: "attr_e",  header: [{ text: "핵심", align: "center" }], align: "center" },
        {id: "attr_f",  header: [{ text: "용어사전", align: "center" }], align: "center" },
        {id: "attr_g",  header: [{ text: "서비스", align: "center" }], align: "center" },
        {id: "attr_h",  header: [{ text: "I콘", align: "center" }], align: "center" },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth: true,
    data: specDetailInfoData,
    editable: true,
    selection: "row",
    multiselection:false,
    keyNavigation: true,
    resizable:true,
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
            rows : [
                {
                    // 스펙그룹 ROW
                    type: "line",
                    id: "specUtil",
                    width:"60%",
                    height:"60px",
                },
                {
                    // 스펙그룹 ROW
                    type: "line",
                    id: "specGroupRow",
                    headerHeight:32,
                    header: "[스펙그룹]",
                    width:"60%",
                    collapsable: false,
                    htmlEnable: true,
                    resizable: false,
                    customScroll: true,
                    rows : [
                        {
                            // 스펙그룹 HEADER
                            id: "specGroupHeader",
                            height: "48px"
                        },
                        {
                            // 스펙그룹 GRID
                            id: "specGroup",
                            height:"calc(100% - 48px)"
                        }
                    ]
                },
                {
                    // 스펙그룹상세 ROW
                    type: "line",
                    id: "specGroupDetailRow",
                    headerHeight:32,
                    header: "[스펙 그룹 상세]",
                    width: "60%",
                    collapsable: true,
                    htmlEnable: true,
                    resizable: false,
                    customScroll: true,
                    rows : [
                        {
                            // 스펙그룹상세 HEADER
                            id: "specGroupDetailHeader",
                            height: "48px"
                        },
                        {
                            // 스펙그룹상세 GRID
                            id: "specGroupDetail",
                            height:"calc(100% - 48px)"
                        }
                    ]
                },
                {
                    // 스펙상세정보 ROW
                    type: "line",
                    id: "specDetailInfoRow",
                    headerHeight:32,
                    header: "[스펙 상세 정보]",
                    width:"60%",
                    collapsable: true,
                    htmlEnable: true,
                    resizable: false,
                    customScroll: true,
                    rows : [
                        {
                            // 스펙상세정보 HEADER
                            id: "specDetailInfoHeader",
                            height: "48px"
                        },
                        {
                            // 스펙상세정보 GRID
                            id: "specDetailInfo",
                            height:"calc(100% - 48px)"
                        }
                    ]
                },
            ]
        },
    ]
};


/*********************************
 * 생성된 레이아웃에 ID별로 attach합니다.
*********************************/
export var contentLayout = new dhx.Layout("contents", config);

    // 페이지 유틸 
    contentLayout.getCell("specUtil").attach(specUtil);

    // GRID 세팅
    contentLayout.getCell("specGroup").attach(specGroup); // 스펙그룹 GRID
    contentLayout.getCell("specGroupDetail").attach(specGroupDetail); // 스펙그룹상세 GRID
    contentLayout.getCell("specDetailInfo").attach(specDetailInfo); // 스펙상세정보 GRID
    

    contentLayout.getCell("specGroupHeader").attach(specGroupHeader); // 스펙그룹 GRID
    contentLayout.getCell("specGroupDetailHeader").attach(specGroupDetailHeader); // 스펙그룹상세 GRID
    contentLayout.getCell("specDetailInfoHeader").attach(specDetailInfoHeader); // 스펙상세정보 GRID


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
 * 조건검색 레이어 
 * 레이아웃, 그리드 생성 
*********************************/
var groupConditionData = [ // 그룹조건 그리드 가짜 데이터
    { "attr_a": "0647743","attr_b": "1개", "attr_c": "080218" }, 
    { "attr_a": "0647743","attr_b": "1개", "attr_c": "080218" }, 
    { "attr_a": "0647743","attr_b": "1개", "attr_c": "080218" }, 
    { "attr_a": "0647743","attr_b": "1개", "attr_c": "080218" }, 
    { "attr_a": "0647743","attr_b": "1개", "attr_c": "080218" }, 
    { "attr_a": "0647743","attr_b": "1개", "attr_c": "080218" }, 
    { "attr_a": "0647743","attr_b": "1개", "attr_c": "080218" }, 
    { "attr_a": "0647743","attr_b": "1개", "attr_c": "080218" }, 
    { "attr_a": "0647743","attr_b": "1개", "attr_c": "080218" }, 
    { "attr_a": "0647743","attr_b": "1개", "attr_c": "080218" }, 
    { "attr_a": "0647743","attr_b": "1개", "attr_c": "080218" }, 
    { "attr_a": "0647743","attr_b": "1개", "attr_c": "080218" }, 
    { "attr_a": "0647743","attr_b": "1개", "attr_c": "080218" }, 
    { "attr_a": "0647743","attr_b": "1개", "attr_c": "080218" }, 
    { "attr_a": "0647743","attr_b": "1개", "attr_c": "080218" }, 
    { "attr_a": "0647743","attr_b": "1개", "attr_c": "080218" }, 
];

// 그룹조건 검색어 입력
var groupKeyword = new dhx.Form(null, {
    css: "spec_header group_keyowrd",
    padding: "0 10px",
    width: "100%",
    rows:[
        {
            css:"ipt-group",
            cols: [
                {
                    id: "specAttrKeyword",
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
                    id: "specAttrSubmit",
                    type: "button",
                    text:"검색",
                    css: "control-comm btn-srch"
                }
            ]
        },  
    ]
});
// 그룹조건 등록/삭제 속성 헤더
var groupResistDel = new dhx.Form(null, {
    css: "spec_header group_resist",
    padding: "0 10px",
    width: "100%",
    rows:[
        {
            css:"btn-group align-between",
            cols: [
                {
                    type: "button",
                    text: "▼ 등록",
                    id: "btnRegistList",
                    css: "control-comm btn-regist"
                },
                {
                    type: "button",
                    text: "삭제",
                    id: "btnDic",
                    css: "control-comm"
                }
            ]            
        } 
    ]
});
// 그리드 생성
var groupConditionGrid = new dhx.Grid(null, {
    columns: [
        { id: "attr_a", header: [{ text: "조건번호", align: "center" }], align:"center" },
        { id: "attr_b", header: [{ text: "조건명", align: "center" }], align:"center" },
        { id: "attr_c", header: [{ text: "소분류", align: "center" }], align:"center" },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth: true, 
    data: groupConditionData,
    adjust: false,
    selection: "row",
    multiselection: true
});
// 그리드 생성
var groupConditionDetailGrid = new dhx.Grid(null, {
    columns: [
        { id: "attr_a", header: [{ text: "스펙번호", align: "center" }], align:"center" },
        { id: "attr_b", header: [{ text: "조건번호", align: "center" }], align:"center" },
        { id: "attr_c", header: [{ text: "조건명", align: "center" }], align:"center" },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth: true, 
    data: groupConditionData,
    adjust: false,
    selection: "row",
    multiselection: true
});

// 레이아웃
var groupConfig = {
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
                    id: "groupKeyword",
                    height:40
                },
                {
                    // 1단계속성 HEADER
                    id: "groupConditionGrid",
                    height:200
                },
                {
                    id: "groupResistDel",
                    height:40
                },
                {
                    // 1단계속성 GRID
                    id: "groupConditionDetailGrid",
                    height:200
                }
            ]
        },
    ]
};
var groupCondLayout = new dhx.Layout("groupCondLayout", groupConfig);

    groupCondLayout.getCell("groupKeyword").attach(groupKeyword); // 검색 attach
    groupCondLayout.getCell("groupConditionGrid").attach(groupConditionGrid); // 그룹조건 그리드 attach

    groupCondLayout.getCell("groupResistDel").attach(groupResistDel); // 등록삭제 attach
    groupCondLayout.getCell("groupConditionDetailGrid").attach(groupConditionDetailGrid); // 그룹조건상세 그리드 attach

/*********************************
 * LP이미지 노출텍스트 레이어 
 * 레이아웃, 그리드 생성 
*********************************/
var groupConditionData = [ // 그룹조건 그리드 가짜 데이터
    { "attr_a": "0","attr_b": "3287", "attr_c": "IPS계열", "attr_d": "IPS계열" }, 
    { "attr_a": "0","attr_b": "3287", "attr_c": "IPS계열", "attr_d": "IPS계열" }, 
    { "attr_a": "0","attr_b": "3287", "attr_c": "IPS계열", "attr_d": "IPS계열" }, 
    { "attr_a": "0","attr_b": "3287", "attr_c": "IPS계열", "attr_d": "IPS계열" }, 
    { "attr_a": "0","attr_b": "3287", "attr_c": "IPS계열", "attr_d": "IPS계열" }, 
    { "attr_a": "0","attr_b": "3287", "attr_c": "IPS계열", "attr_d": "IPS계열" }, 
    { "attr_a": "0","attr_b": "3287", "attr_c": "IPS계열", "attr_d": "IPS계열" }, 
    { "attr_a": "0","attr_b": "3287", "attr_c": "IPS계열", "attr_d": "IPS계열" }, 
    { "attr_a": "0","attr_b": "3287", "attr_c": "IPS계열", "attr_d": "IPS계열" }, 
    { "attr_a": "0","attr_b": "3287", "attr_c": "IPS계열", "attr_d": "IPS계열" }, 
    { "attr_a": "0","attr_b": "3287", "attr_c": "IPS계열", "attr_d": "IPS계열" }, 
    { "attr_a": "0","attr_b": "3287", "attr_c": "IPS계열", "attr_d": "IPS계열" }, 
    { "attr_a": "0","attr_b": "3287", "attr_c": "IPS계열", "attr_d": "IPS계열" }, 
    { "attr_a": "0","attr_b": "3287", "attr_c": "IPS계열", "attr_d": "IPS계열" }, 
    { "attr_a": "0","attr_b": "3287", "attr_c": "IPS계열", "attr_d": "IPS계열" }, 
    { "attr_a": "0","attr_b": "3287", "attr_c": "IPS계열", "attr_d": "IPS계열" }, 
];

// 버튼부 헤더
var lpButtonGroup = new dhx.Form(null, {
    css: "spec_header",
    padding: "0 10px",
    width: "100%",
    rows:[
        {
            css:"btn-group",
            cols: [
                {
                    type: "button",
                    text: "상세설명",
                    id: "btnDetail",
                    css: "control-comm btn-detail"
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
                }
            ]            
        } 
    ]
});
// 그리드 생성
var lpImgGrid = new dhx.Grid(null, {
    columns: [
        { id: "attr_a", header: [{ text: "순서", align: "center" }], align:"center" },
        { id: "attr_b", header: [{ text: "사양번호", align: "center" }], align:"center" },
        { id: "attr_c", header: [{ text: "상세명", align: "center" }], align:"center" },
        { id: "attr_d", header: [{ text: "노출명", align: "center" }], align:"center" },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth: true, 
    data: groupConditionData,
    adjust: false,
    selection: "row",
    multiselection: true
});

// 레이아웃
var lpImgConfig = {
    type: "line", // space, wide, line
    width:"100%",
    maxWidth:"100%",
    rows: [
        {
            // ROW
            type: "space",
            width:"100%",
            rows : [
                {
                    id: "lpButtonGroup",
                    height:40
                },
                {
                    // 1단계속성 HEADER
                    id: "lpImgGrid",
                },
            ]
        },
    ]
};
var lpImgLayout = new dhx.Layout("lpImgLayout", lpImgConfig);

    lpImgLayout.getCell("lpButtonGroup").attach(lpButtonGroup); // 검색 attach
    lpImgLayout.getCell("lpImgGrid").attach(lpImgGrid); // 그룹조건 그리드 attach