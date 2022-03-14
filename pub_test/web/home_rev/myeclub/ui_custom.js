// 21.11.23__작성자 : 박현원
// jquery ui 사용시에만 해당 js
// datepicker 한글적용

$.datepicker.setDefaults({
    dateFormat: 'yy-mm-dd',
    prevText: '이전 달',
    nextText: '다음 달',
    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    // dayNames: ['일', '월', '화', '수', '목', '금', '토'],
    // dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
    // dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
    dayNames: ['월', '화', '수', '목', '금', '토', '일'],
    dayNamesShort: ['월', '화', '수', '목', '금', '토', '일'],
    dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
    showMonthAfterYear: true,
    yearSuffix: '년'
});