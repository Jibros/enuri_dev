
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

function popnewwin(my){
    event.stopPropagation();
    window.open( $(my).prev('a').find(".tx_uri").text() );
}

var sheetData = {
    dataPre : "https://spreadsheets.google.com/feeds/list/"+gsheetcode+"/",
    dataSuf : "/public/basic?alt=json-in-script&callback=?",
    strData : [],
    init : function(){
        // 시트 데이터 로드
        var $root = this;
        $root.loadData(1);
    },
    loadData : function(snum){
        var $root = this;
        var _url = this.dataPre+snum+this.dataSuf;
		$.getJSON(_url,function(data){
            // 시트 이름 가져옴
            // var title = data.feed.title.$t;
            // 데이터를 json으로 변형
            var entry=data.feed.entry;//구글 스프레드 시트의 모든 내용은 feed.entry에 담겨있습니다.									
            // 가져온 데이터를 배열에 담기
			$(entry).each(function(){
                $root.strData.push( JSON.parse( '{"'+this.content.$t.replace(/: /g,'":"').replace(/, /g,'", "') + '"}') )
            });
		}).done(function() {
            $root.drawTable($root.strData);
		}).fail(function() {
			console.log( "error" );
			alert('데이터를 가져오지 못했습니다.');
		}).always(function() {
			console.log( "complete" );
		});
    },
    drawTable : function(data){
        var $root = this;
        var $stg = $(".tb_tree");        
        // 데이터 뿌리기
        $.each( data , function(e){            
            var $ta = $stg;            
            if ( e ){
                var _lv = parseInt ( Object.keys( data[e] )[0].replace(/d/,""),10 );
                if ( _lv != 1 ) $ta = $stg.find(".d"+(_lv-1)).last();
                else $ta = $stg;
            }
            $ta.append( $root.makeRecord(this,e) );            
        })
        // 데이터 예외처리
        $.each( data , function(e){               
            var $record = $stg.find(".tb-item[data-record-index='"+e+"']");
            if ( e < data.length-1 ){
                var nochild = parseInt ( Object.keys( data[e] )[0].replace(/d/,""),10 ) < parseInt ( Object.keys( data[e+1] )[0].replace(/d/,""),10 );
                if ( !nochild ) $record.addClass("nochild");
            }else{
                $record.addClass("nochild");
            }
            if ( this.disabled != undefined ) $record.addClass("disabled");
        })
        // 플립 이벤트
        $(".tb-item > a").click(function(e){
            e.preventDefault();
            var $parent = $(this).parent();
            if ( !$parent.is(".nochild") ){
                if ( $parent.is(".open") ){ $parent.find(".tb-item").removeClass("open");}
                $parent.toggleClass("open");
            }
            // 링크 연결
            var $uri = $(this).find(" > .tx_uri");
            var $mobile = $(this).find(" > .type");
            var $wrap = $("#wrapper");
            if ( $uri.length ){
                var _url = $uri.text();
                if ( $mobile.length ){
                    $("#mFrame").attr("src",_url).load(function(){
                        $wrap.addClass("mode_m");
                        $("#m_frame .inner .txt_url").text(_url);
                        var divNode = document.createElement("div");
                        divNode.innerHTML = "<style>body::-webkit-scrollbar {display:none;}</style>";
                        frames['mFrame'].document.body.appendChild(divNode);                  
                    })
                }else{
                    $wrap.removeClass("mode_m");
                    window.open(_url);
                }
                
            }
        })        
    },
    makeRecord : function(data,idx){
        var makeHtml = "";
        var midx = false;
        $.each(data,function(key,value){
            if ( key.indexOf('d') == 0 && key != "disabled"){
                makeHtml += '<div class="tb-item '+key+'" data-record-index="'+idx+'">';
                makeHtml += '<a href="#"><span class="tx_tit">'+value+'</span>';
            }else{
                if ( key == 'type' && (value == 'm' || value == 'M') ){
                    midx = true;
                    
                }
                if ( key != "disabled"){
                    makeHtml += '<span class="'+key.replace('tx','tx_')+'">'+value+'</span>'                    
                }
            }
        });
        makeHtml +='</a>';
        if ( midx ) makeHtml += '<span class="ico_newwin" onclick="popnewwin(this);">새창</span>';
        makeHtml += '</div>';
        return makeHtml;
    }
}

var keyFnc = function(){
    var keyCount = 0;
    $("html").on("keydown",function(e){
        switch (keyCount){
            case 0 :
                ( String(e.key).toUpperCase() == 'A' ) ? keyCount++ : keyCount = 0;
                break;
            case 1 : 
                ( String(e.key).toUpperCase() == 'D' ) ? keyCount++ : keyCount = 0;
                break;
            case 2 : 
                ( String(e.key).toUpperCase() == 'M' ) ? keyCount++ : keyCount = 0;
                break;
            case 3 : 
                ( String(e.key).toUpperCase() == 'I' ) ? keyCount++ : keyCount = 0;
                break;
            case 4 : 
                ( String(e.key).toUpperCase() == 'N' ) ? keyCount++ : keyCount = 0;
                $(".bnr_admin").addClass("on");
                keyCount = 0;
                break;
            default : 
                break;
        }
    })
}

$(function(){
    // 리스트 뿌리기
    sheetData.init();
    // 어드민 키 이벤트
    keyFnc();      
})