// 사용시트수
var maxSheet = 10;

function popnewwin(my){
    event.stopPropagation();
    window.open( $(my).prev('a').find(".tx_uri").text() );
}

var sheetData = {
    dataPre : "https://spreadsheets.google.com/feeds/list/"+gsheetcode+"/",
    dataSuf : "/public/basic?alt=json-in-script&callback=?",
    strData : new Array(),
    init : function(num){
        // 배열 생성
        for ( var i = 0 ; i < maxSheet ; i++ ){
            this.strData[i] = new Array();
        }
        // 시트 데이터 로드
        var $root = this;
        $root.addEvent(); // 메뉴 버튼 이벤트
        $root.loadData(num); // 최초 기본값 1
    },
    loadData : function(snum){
        // Loader Show
        var $loader= $(".loader-wrap");
        var $loaderPerNum = $(".txt-per-num");
        $loader.fadeIn(150);
        $loaderPerNum.html(0);        
        // ---//
        var $root = this;
        if ( $root.strData[snum-1].length ){
            // 불러온 데이터가 있을때
            $root.showPage( snum );
        }else{
            // 불러온 데이터가 없을때            
            var _url = this.dataPre+snum+this.dataSuf;
            $.getJSON(_url,function(data){
                // 시트 이름 가져옴
                // var title = data.feed.title.$t;
                // 데이터를 json으로 변형
                var entry=data.feed.entry;//구글 스프레드 시트의 모든 내용은 feed.entry에 담겨있습니다.									
                // 가져온 데이터를 배열에 담기
                $(entry).each(function(){
                    $root.strData[snum-1].push( JSON.parse( '{"'+this.content.$t.replace(/: /g,'":"').replace(/, /g,'", "') + '"}') )
                });
            }).done(function() {
                $root.drawTable(snum,$root.strData[snum-1]);
            }).fail(function() {
                console.log( "error" );
                alert('데이터를 가져오지 못했습니다.');
            }).always(function() {
                console.log( "complete" );
                // console.log ( this.strData )
            });            
        }
    },
    addEvent : function(){
        var $root = this;
        var $menuItem = $("#menu ul li");
        $menuItem.click(function(){                        
            $root.loadData( $(this).attr("data-sheet-num") );
        });
    },
    drawTable : function(num,data){
        var $root = this;
        var $content = $("#content");
        $content.append('<div class="tb_tree" data-sheet-num="'+num+'"/>');
        var $stg = $(".tb_tree[data-sheet-num='"+num+"']");
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
        $stg.find(".tb-item > a").click(function(e){
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
        
        $root.showPage(num);
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
    },
    loader : function(num){
        var $loader= $(".loader-wrap");
        var $loaderPerNum = $(".txt-per-num");
        var $loaderTxt = $(".txt-status");
        $( {countNum: $loaderPerNum.text()} ).stop(true,true).animate({countNum : num },{
            duration : 200,
            easing : 'linear',
            step : function(){
                $loaderPerNum.text( Math.floor(this.countNum) )
            },
            complete : function(){
                $loaderPerNum.text( this.countNum )
            }
        })  
    },
    showPage : function(num){
        var $root = this;
        var $loader= $(".loader-wrap");
        var $loaderTxtEm = $(".txt-status em");
        var $list = $("#menu ul li[data-sheet-num='"+num+"']");
        var $page = $(".tb_tree[data-sheet-num='"+num+"']");
        $page.addClass("on").siblings().removeClass("on");
        $loaderTxtEm.html( $list.text() );
        $("h1").html( $list.text() );
        $root.loader(100);
        setTimeout(function(){
            $("#menu ul li[data-sheet-num='"+num+"']").addClass("selected").siblings().removeClass("selected");
            $("#wrapper").removeClass("menuon");
            $loader.fadeOut(150);
        },500);

        // 로컬스토리지에 기록합니다.
        if (storageAvailable('localStorage')) {
            localStorage.setItem('idx',num);
        }
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

function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

function storageAvailable(type) {
    var storage;
    try {
        storage = window[type];
        var x = '__storage_test__';
        storage.setItem(x, x);
        storage.removeItem(x);
        return true;
    }
    catch(e) {
        return e instanceof DOMException && (
            // Firefox를 제외한 모든 브라우저
            e.code === 22 ||
            // Firefox
            e.code === 1014 ||
            // 코드가 존재하지 않을 수도 있기 떄문에 이름 필드도 확인합니다.
            // Firefox를 제외한 모든 브라우저
            e.name === 'QuotaExceededError' ||
            // Firefox
            e.name === 'NS_ERROR_DOM_QUOTA_REACHED') &&
            // 이미 저장된 것이있는 경우에만 QuotaExceededError를 확인하십시오.
            (storage && storage.length !== 0);
    }
}

$(function(){
    var param = getParameterByName('view');
    if ( param == "" ){
        if (storageAvailable('localStorage')) {
            var _idx = localStorage.getItem('idx');
            if ( _idx != null ){ // Localstorage에 값이 있을때
                param = _idx;
            }else{ // Localstorage에 값이 없으면 1
                param = 1;
            }
        }
        else { // Localstorage를 사용할수 없는 브라우져
            param = 1;
        }
    }
    // 리스트 뿌리기
    sheetData.init(param);
    // 어드민 키 이벤트
    keyFnc();      
})