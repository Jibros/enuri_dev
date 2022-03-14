
// 주차 구하기
Date.prototype.getWeek = function (dowOffset) {
    dowOffset = typeof(dowOffset) == 'int' ? dowOffset : 0; //default dowOffset to zero
    var newYear = new Date(this.getFullYear(),0,1);
    var day = newYear.getDay() - dowOffset; //the day of week the year begins on
    day = (day >= 0 ? day : day + 7);
    var daynum = Math.floor((this.getTime() - newYear.getTime() - 
    (this.getTimezoneOffset()-newYear.getTimezoneOffset())*60000)/86400000) + 1;
    var weeknum;
    //if the year starts before the middle of a week
    if(day < 4) {
        weeknum = Math.floor((daynum+day-1)/7) + 1;
        if(weeknum > 52) {
            nYear = new Date(this.getFullYear() + 1,0,1);
            nday = nYear.getDay() - dowOffset;
            nday = nday >= 0 ? nday : nday + 7;
            /*if the next year starts before the middle of
              the week, it is week #1 of that year*/
            weeknum = nday < 4 ? 1 : 53;
        }
    }
    else {
        weeknum = Math.floor((daynum+day-1)/7);
    }
    return weeknum;
};

// https://docs.google.com/spreadsheets/d/1SNafz5MLUAkK39phcjUOWhefVgHH4VVuwh_u4bEd0c0/edit?usp=sharing
var sheetData = {
    dataPre : null,
    dataSuf : "/public/basic?alt=json-in-script&callback=?",
    strData : [[],[],[],[]],
    init : function(){
        // 시트 데이터 로드
        var $root = this;
        $root.loadData(1);
    },
    loadData : function(snum){
        var $loader= $(".loader-wrap");
        var $loaderPerNum = $(".txt-per-num");
        var $loaderTxt = $(".txt-status");
        var $root = this;
        if  ( snum <  $root.strData.length+1 ){
            console.log( snum );
            // 로더 시작
            $loader.fadeIn(300);            
            var _url = this.dataPre+snum+this.dataSuf;
            $.getJSON(_url,function(data){
                // 시트 이름 가져옴
                var title = data.feed.title.$t;
                // 데이터를 json으로 변형
                var entry=data.feed.entry;//구글 스프레드 시트의 모든 내용은 feed.entry에 담겨있습니다.									
                // 가져온 데이터를 배열에 담기
                $root.strData[snum-1].push( {"title":title});
                $(entry).each(function(){
                    $root.strData[snum-1].push( JSON.parse( '{"'+this.content.$t.replace(/: /g,'":"').replace(/, /g,'", "') + '"}') )
                });
            }).done(function() {
                if ( snum < $root.strData.length ){ // 더 불러올 데이터가 있으면 재로드
                    $loaderPerNum.html( parseInt ( 100 / $root.strData.length * snum ,10) +"%");
                    if ( snum == 3 ) $loaderTxt.html('가져온 데이터를<br/>그리고 있습니다');
                    // console.log( parseInt ( 100 / $root.strData.length * snum ,10));
                    $root.loadData(snum + 1);
                }else{ // 다 불러왔으면 완료
                    // console.log('데이터 로드 완료');
                    $loaderTxt.html('로딩이<br/>완료 되었습니다');
                    $loaderPerNum.html( "100%");
                    $root.makeHtml();
                    $root.addEvent();
                    setTimeout(function(){
                        $loader.fadeOut(400);
                    },1000)
                }
                console.log( $root.strData );
            }).fail(function() {
                console.log( "error" );
                alert('데이터를 가져오지 못했습니다.');
            }).always(function() {
                console.log( "complete" );
            });
        }
    },
    makeHtml : function(){
        var $root = this;
        $.each($root.strData,function(e){ 
            // 네비 추가
            var $navItem = $(".select-people ul");
            $navItem.append('<li data-index="'+(e+1)+'">'+this[0].title+'</li>');
            // 데이터 박스 그리기
            var domHtml = "";
            domHtml += '<div class="work-data" data-people-index="'+(e+1)+'">'
            // 성명 사번 노출
            var t = this[0].title.split('_');
            domHtml += '    <h3>'+t[1]+' <span class="txt-cnum">'+t[0]+'</span></h3>'
            // 작업량 테이블 생성
            domHtml += '<div class="work-table-wrap">'
            domHtml += '<div class="table-fix-left"><ul>'
            domHtml += '<li>'
            domHtml += '    <span class="tb_code tb_head">code</span>'
            domHtml += '    <span class="tb_group_tit tb_head">항목</span>'
            domHtml += '    <span class="tb_group_stit tb_head">세부항목</span>'
            domHtml += '</li>'
            domHtml += '</ul></div>'
            domHtml += '<div class="work-table">'
            // 테이블 [구분] 생성
            domHtml += '<ul class="table-data"></div>'
            domHtml += '</div>'
            domHtml += '</div>'
            domHtml += '</div>'
            $("#wrap").append(domHtml);
            
            // 데이터 뿌리기
            $(this).each(function(n){     
                var $self = this;           
                var $this = $(".work-data[data-people-index='"+(e+1)+"']");                
                if ( n != 0 ){
                    $this.find(".table-fix-left ul").append('<li></li>');
                    var _idx = 0;
                    $.each(this,function(key,value){                        
                        if ( key == 'code') {
                            $this.find(".table-fix-left ul").find("li").eq(n).append('<span class="tb_code" data-group-code="'+value+'">'+value+'</span>');
                        }
                        if ( key == 'grouptit'){
                            $this.find(".table-fix-left ul").find("li").eq(n).append('<span class="tb_group_tit">'+value+'</span>');
                        }
                        if ( key == 'groupstit'){
                            $this.find(".table-fix-left ul").find("li").eq(n).append('<span class="tb_group_stit">'+value+'</span>');
                        }
                        if ( key.indexOf('d') == 0 ){
                            var $elemTb = $this.find(".table-data");
                            if ( n == 1 ) {
                                // 날짜를 만들고, 주차를 추가
                                var _txtDate = key.replace('d','');
                                var _arrDate = _txtDate.split('-');
                                // 2019년~2020년 분기 예외처리
                                if ( parseInt(_arrDate[0],10) > 2) var _myDate = new Date(2019,parseInt(_arrDate[0]-1,10),parseInt(_arrDate[1]-1,10));
                                else var _myDate = new Date(2020,parseInt(_arrDate[0]-1,10),parseInt(_arrDate[1]-1,10));
                                //
                                $elemTb.append('<li data-week-num="'+_myDate.getWeek()+'" data-month-num="'+parseInt(_arrDate[0],10)+'" data-list-date="'+_txtDate+'"><span class="txt_date">'+_txtDate.replace('-','.')+'</span></li>');
                            }   
                            // 타이틀 및 속성값 넣기
                            var $elemLi = $elemTb.find("li").eq(_idx);
                            $elemLi.append('<span class="txt_value" data-group-code="'+$self.code+'" data-date-value="'+key.replace('d','')+'" data-value-num="'+$root.calcValue(value)+'">'+$root.calcValue(value)+'</span>');
                            _idx++;
                        }
                    })
                }
            });
            // 합계 만ㄷ르기
            $root.calcDayTotal( e+1 );
            // 유효한 내용만 표시
            $root.activeList( e+1 );
            // 오늘날짜 주차 표시
            $root.showTodayWeek();
            // 오늘 주차로 스크롤 이동
            $root.tableScrMove();
        })
    },
    calcValue : function(val){ // 0건인 경우 텍스트 제거
        if  (val == '-') return 0;
        else return val;
    },
    calcDayTotal : function(num){ // 일 합계 만들기
        var $elem = $(".work-data[data-people-index='"+num+"']");
        var $tbLeft = $elem.find(".table-fix-left ul");
        var $tbRight = $elem.find(".table-data li");
        $tbLeft.append("<li><span class='tb_total'>합계</span></li>");
        $tbRight.each(function(e){
            var _tot = 0;
            $(this).find("span.txt_value").each(function(i){
                if ( $(this).attr("data-value-num") != undefined ){
                    _tot += parseInt( $(this).attr("data-value-num"),10);
                }
            })
            $(this).append('<span class="txt_total" data-value-total="'+_tot+'">'+_tot+'</span>');
        })
    },
    tableScrMove : function(){
        setTimeout(function(){
            var _date = new Date();
            $(".work-table").each(function(e){
                var _w = $(this).width() / 2;
                var _scrLeft =  $(this).find("li[data-week-num='"+_date.getWeek()+"']").eq(0).offset().left;
                $(this).scrollLeft( _scrLeft - 420 - _w );
                $(this).addClass("dragscroll");
            });
        },1)
    },
    showTodayWeek : function(){ // 오늘 주차 표시
        var $elem = $(".show-week");
        var _date = new Date();
        var text = _date.getFullYear() + "년 " + (_date.getMonth()+1) + "월 " + _date.getDate() +"일 (" +_date.getWeek()+ ")주차";
        $elem.html( '오늘은 <em>'+text+'</em>입니다' );
        // $("input.inp_mon").val( _date.getMonth()+1 );
        // $("input.inp_week").val( _date.getWeek() );
    },
    activeList : function(num){ // 작업건이 있는 라인만 노출
        var $elem = $(".work-data[data-people-index='"+num+"']");
        // 값이 있는 테이블만 노출
        var $tbLeft = $elem.find(".table-fix-left ul li");
        var $tbRight = $elem.find(".table-data li:visible");
        $tbLeft.each(function(e){
            $(this).show();
            var _code = $(this).find(".tb_code").attr("data-group-code");
            if ( _code != undefined ){
                var _idx = 0;
                $tbRight.each(function(i){
                    if ( $(this).find('span[data-group-code="'+_code+'"]').attr("data-value-num") > 0 ){
                        _idx++;
                    }
                })
                if ( _idx == 0 ){
                    $(this).hide();
                    $tbRight.find('span[data-group-code="'+_code+'"]').hide();
                }
            }
        });
    },
    showSummary : function(){
        var $lay = $(".lay_sum");
        var $valWeek = $(".inp_week").val().trim();
        var $valMonth = $(".inp_mon").val().trim();
        $lay.html('');
        $(window).scrollTop(0);
        var domHtml = "";
        domHtml += '<div class="lay_sum_total">'
        if ( $valWeek == "" && $valMonth == ""){
            if ( $(".work-data:visible").length == 3 ) domHtml += '    <h3>2019년 전체 업무량</h3>'    
            else domHtml += '    <h3>2019년 전체 업무량 <span class="txt_user">('+$(".work-data:visible").find("h3").html()+')</span></h3>'
        }else{
            if ( $(".work-data:visible").length == 3 ){
                if ( $valWeek != "" ) domHtml += '    <h3>2019년 '+$valWeek+'주차 업무량</h3>'
                else domHtml += '    <h3>2019년 '+$valMonth+'월 업무량</h3>'
            }else{
                if ( $valWeek != "" ) domHtml += '    <h3>2019년 '+$valWeek+'주차 업무량 <span class="txt_user">('+$(".work-data:visible").find("h3").html()+')</span></h3>'
                else domHtml += '    <h3>2019년 '+$valMonth+'월 업무량 <span class="txt_user">('+$(".work-data:visible").find("h3").html()+')</span></h3>'
            }
        }
        domHtml += '<div class="tb_wrap">'
        domHtml += '<table id="tbSummary">'
        domHtml += '    <thead>'
        domHtml += '        <tr>'
        domHtml += '            <th class="tb_group tb_head">항목</th>'
        domHtml += '            <th class="tb_group_stit tb_head">세부항목</th>'
        domHtml += '            <th class="tb_total tb_head">작업량</th>'
        domHtml += '        </tr>'
        domHtml += '    </thead>'
        domHtml += '    <tbody>'
        $(".table-fix-left li:visible").each(function(e){
            var _code = $(this).find(".tb_code").attr("data-group-code");
            if ( _code != undefined ){
                // var codeLen = $(".lay_sum_total table").find('tr[data-group-code="'+_code+'"]').length;
                // console.log( codeLen );
                // if ( !codeLen ){
                    domHtml += '<tr data-group-code="'+_code+'">'
                    domHtml += '    <td class="tb_group_tit">'+$(this).find('.tb_group_tit').html()+'</td>'
                    domHtml += '    <td class="tb_group_stit">'+$(this).find('.tb_group_stit').html()+'</td>'
                    domHtml += '    <td class="tb_total">'
                    var _tot = 0;
                    $(".table-data li:visible").find('span[data-group-code="'+_code+'"]').each(function(i){
                        _tot += parseInt($(this).attr("data-value-num"),10);
                    });                    
                    domHtml += _tot + '</td>'
                    domHtml += '</tr>'
                // }
            }
        });  
        domHtml += '    </tbody>'
        domHtml += '</table>'
        domHtml += '</div>'
        domHtml += '</div>'
        domHtml += '<a class="btn_lay_close" href="#" onclick="$(this).parent().fadeOut(100);return false;"></a>'
        $lay.html(domHtml);

        // 중복걸러내는 코드 (임시) - 좋은 방법을 찾는중
        var $tbody = $("#tbSummary tbody");
        var $trecoed = $tbody.find("tr");
        $trecoed.each(function(e){
            var _code = $(this).attr("data-group-code");
            var codeLen = $tbody.find('tr[data-group-code="'+_code+'"]').length;
            if ( codeLen > 1 ) $tbody.find('tr[data-group-code="'+_code+'"]').not(":eq(0)").remove();
        })
        // 순서대로 정렬
        this.sortTable();
        // 활성화
        $lay.fadeIn(400);
        // 선택된 일자의 작업량 총량 계산
        var _totNum = 0;
        $(".lay_sum_total table tr").each(function(e){
            var val = parseInt($(this).find(".tb_total").html(),10);
            if ( val ) _totNum += val
        })
        $(".lay_sum_total .tb_wrap").append('<span class="tb_all_total"> 작업량 총합 : <span class="txt_tot_num">'+_totNum+'</span>건</span>');
    },
    sortTable : function(){
        var switching, rows, i, x, y, shouldSwitch;
        var table = $("#tbSummary tbody");
        switching = true;
        while (switching) {
            switching = false;
            rows = table[0].rows; 
            for (var i = 0; i < (rows.length - 1); i++) { 
                shouldSwitch = false;
                var fCell = rows[i].cells[0];             
                var sCell = rows[i + 1].cells[0]; 
                if (fCell.innerHTML.toLowerCase() > sCell.innerHTML.toLowerCase()) { 
                    shouldSwitch = true;
                    break;
                } 
            } 
            if (shouldSwitch) {
                rows[i].parentNode.insertBefore(rows[i + 1], rows[i]); 
                switching = true;
            }
        }     
    },
    addEvent : function(){ // 각종 이벤트
        var $root = this;       

        // 네비 인물별 선택 보기 이벤트
        var $people = $(".select-people ul li");
        $people.on("click",function(i){
            i.preventDefault();
            var idx = parseInt($(this).attr("data-index"),10);
            if ( !idx ){
                $(".inp_week").val("");
                $(".inp_mon").val("");
                $(".work-data").show(100);
                $(".work-data").find(".table-fix-left li").show();
                $(".work-data").find(".table-data li").show().find("span").show();
                $(".work-data").each(function(e){
                    $root.activeList(e+1);
                })
            }else{                
                $('.work-data[data-people-index="'+idx+'"]').show(0).siblings().hide(200);
            }
        })        

        // 주차별 검색
        var $btnSRWeek = $(".select-week .btn_search");
        var $btnSRMonth = $(".select-month .btn_search");        
        $btnSRWeek.on("click",function(i){
            i.preventDefault();
            var $inpWeek = $(".inp_week");
            var $inpMon = $(".inp_mon");
            
            if ( $inpWeek.val().trim() != "" && $inpWeek.val() < 55 ){
                $inpMon.val("");
                var _weeknum = $inpWeek.val();
                if ( _weeknum != undefined){  
                    $('.table-data li').find("span").show();                  
                    $('.table-data li').hide();
                    $('.table-data li[data-week-num="'+_weeknum+'"]').show();
                    $(".work-data").each(function(e){
                        $root.activeList(e+1);
                    })
                }else{
                    alert('선택하신 주차에 해당되는 정보가 없습니다.');
                }            
            }else{
                alert('주차를 정상적으로 넣어주세요');
                $inpWeek.val("");
            }
        })

        $btnSRMonth.on("click",function(i){
            i.preventDefault();
            var $inpWeek = $(".inp_week");
            var $inpMon = $(".inp_mon");
            if ( $inpMon.val().trim() != "" && $inpMon.val() < 13 ){
                $inpWeek.val("");
                var _monthnum = $inpMon.val();
                if ( _monthnum != undefined){                    
                    $('.table-data li').find("span").show();
                    $('.table-data li').hide();
                    $('.table-data li[data-month-num="'+_monthnum+'"]').show();
                    $(".work-data").each(function(e){
                        $root.activeList(e+1);
                    })
                }else{
                    alert('선택하신 월에 해당되는 정보가 없습니다.');
                }            
            }else{
                alert('월을 정상적으로 넣어주세요');
                $inpMon.val("");
            }
        })
        
        //요약보기
        var $btnSummray = $(".view-total").find("li").eq(0);
        $btnSummray.on("click",function(i){
            $root.showSummary();
        })

        // 챠트보기
        var $btnChart = $(".view-total").find("li").eq(1);
        $btnChart.on("click",function(i){
            $root.showChart();
        })
    },
    showChart : function(){
        var $root = this;
        var $lay = $(".lay_sum");
        var $valWeek = $(".inp_week").val().trim();
        var $valMonth = $(".inp_mon").val().trim();
        if ( $(".work-data:visible").length == 4 ){
            $lay.html('');
            $(window).scrollTop(0);
            var domHtml = "";
            var selChartMode; // 0 전체, 1 월,주간 일별
            domHtml += '<div class="lay_sum_total">'
            if ( $valWeek == "" && $valMonth == ""){
                selChartMode = 0;
                domHtml += '<h3>2019년 월별 업무량</h3>'
                domHtml += '<div class="chart_wrap"><div id="chart-month"></div></div>'
                domHtml += '<h3>2019년 분기별 업무량</h3>'
                domHtml += '<div class="chart_wrap"><div id="chart-quarter"></div></div>'
            }else{
                selChartMode = 1;
                domHtml += '<h3>2019년 '
                if ( !$valWeek == "" ) domHtml += $valWeek +'주차 일별';
                else domHtml += $valMonth +'월 일별';
                domHtml += ' 업무량</h3>'
                domHtml += '<div class="chart_wrap"><div id="chart-month"></div></div>'
            }    
            domHtml += '</div>'
            domHtml += '<a class="btn_lay_close" href="#" onclick="$(this).parent().fadeOut(100);return false;"></a>'        
            $lay.html(domHtml);
            $lay.fadeIn(400);
            $root.drawChart(selChartMode);
        }else{
            alert('선택보기 &gt; 전체보기 모드를 선택해 주세요');
        }
    },
    drawChart : function(mode){ // 차트 그리기
        var $data = $(".work-data");
        var procData = [[0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0]]; // 가공된 월, 분기별 데이터
        var arrData = [[],[]]; // 챠트 데이터        
        var mkObj = function(category,date,value){
            var _data = new Object;
            _data.category = category;
            _data.date = date;
            _data.value = value;
            return _data;
        }
        if ( !mode ){ // 전체
            $data.each(function(e){
                $(this).find(".table-data li:visible").each(function(i){
                    var _month = parseInt($(this).attr("data-month-num"),10);
                    var _value = parseInt($(this).find(".txt_total").html(),10);
                    procData[0][_month-1] += _value;
                })
                $.each ( procData[0] , function(e){
                    arrData[0].push( mkObj('user', (e+1)+'월', this ) );
                })
                $.each ( procData[1] , function(e){
                    var qval = procData[0][3*e] + procData[0][3*e+1] + procData[0][3*e+2];
                    arrData[1].push( mkObj('user', (e+1)+'분기', qval ) );
                })
            })
        }else{ // 월주간 일별
            $data.each(function(e){                
                $(this).find(".table-data li:visible").each(function(i){
                    var _date = $(this).find(".txt_date").html();
                    var _value = $(this).find(".txt_total").html();
                    arrData[0].push( mkObj('user'+e, _date, _value ) );
                })
            })
        }

        jelly.bar()
        .container('#chart-month')
        .data(arrData[0])
        .dimensions(['date'])
        .measures([{field: 'value', op: 'sum'}])
        //   .orient('horizontal')
        // .showDiff(true)
        // .annotation(true)        
        .label(true)
        .autoResize(true)
        .axis('x').axis('y')
        .render();

        if ( !mode ){
            jelly.bar()
            .container('#chart-quarter')
            .data(arrData[1])
            .dimensions(['date'])
            .measures([{field: 'value', op: 'sum'}])
            // .showDiff(true)
            .label(true)
            .autoResize(true)
            .axis('x').axis('y')
            .render();
        }
    }
}

function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

$(function(){
    var sheetCode = [
        "https://spreadsheets.google.com/feeds/list/1ElWqZPlUtDz-GS3EKEXZiEKw1McluxeUdv_jjwOqQg8/", // 2019
        "https://spreadsheets.google.com/feeds/list/1SNafz5MLUAkK39phcjUOWhefVgHH4VVuwh_u4bEd0c0/" // 2020
    ]
    var nowDate = new Date();
    var setIndex = nowDate.getFullYear() - 2019;
    var param = parseInt(getParameterByName('year'),10)
    if ( param > 2018 && param < 2021 ){
        setIndex = param-2019
    }
    sheetData.dataPre = sheetCode[setIndex];
    // console.log(setIndex);
    sheetData.init();
})