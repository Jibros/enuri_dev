$(function(){
    // init
    setTimeout(function(){
        titChangeLoad(); // 타이틀 변경 Init
        loader();
    }, 0)    
})

// 연관상품 클릭
$("#header").on("click", ".exlink_list > li.has-sub > button", function(e){
    let _sublist = $(this).siblings(".exlink_sub");
    let st = _sublist.is(":visible");
    st ? _sublist.hide() : _sublist.show();            
})
$('html').on('click',function(e){ // 외부클릭=>레이어 숨김
    var $t = $(e.target);
    var $carea = $t.closest('.exlink_list, .lay-auto'); // 클릭 영역
    var layerClass = ".exlink_sub, .lay-auto"; // 레이어 클래스
    if( !$carea.length ){
        $(layerClass).hide();
    }
});

// 1000단위 컴마
function numberFormat(value) {
    var regexp = /\B(?=(\d{3})+(?!\d))/g;
    return value == null ? '' : String(value).replace(regexp, ',');
}

// 숫자만 입력
$('.js-onlyNumb').on('input', function(e){
    if(!$(this).hasClass("nonformat")){ // 컴마 처리
        this.value = numberFormat(this.value.replace(/[^0-9]/g,''));
    }else{
        this.value = this.value.replace(/[^0-9]/g,'');
    }    
})

// 로더 재생 : loader(agr: speed)
var loadSt = false; // 로딩 상태
var loader = function(speed){
    // 인자가 없을 때 1초 후 로더 숨김
    (speed === undefined) ? speed = 1000 : speed;

    $(".loader_box").fadeIn();
    setTimeout(function(){
        loadSt = true;
        if(loadSt){
            $(".loader_box").fadeOut();
            
            loadSt = false;
        }
    }, speed) // 임의속도
}

// 문서 title 변경
var titChangeLoad = function(){
    var titleTag = $("title"),
        bodyTitle = $("body").data("title");

        if(bodyTitle != undefined){
            titleTag.text("NEW MP - " + $("body").data("title"));
        }else{
            titleTag.text("NEW MP - 대량정제");
        }
}

// 드래그 레이어 호출
var jsDragLayer = $(".js-dragLayer"); // 드래그 가능한 레이어 버튼 클래스 
var zIndex = 0;
jsDragLayer.on("click", function(){
    var layer = $(this).data("id"),
        layerId = $("#"+layer);        

    layerId.fadeIn().css({"z-index": zIndex++});

    draggableLayer(layerId) // 레이어 ID 전달
});


// 드래그 레이어 함수
var draggableLayer = function(obj){
    // 조건 매칭 레이어 드래그
    $(obj).find($('.lay-comm')).draggable({
        cancel :'.lay-body, .lay-foot',
        containment : "parent",
        scroll : false
    });
}

// 별도창 윈도우 팝업 
var popupOpen = function(target, pname, wid, hgt){
    var _target = target; // 팝업 경로
    var _pname = pname; // 팝업명
    var _wid = wid, _hgt = hgt; // 팝업 너비,높이

    if(!_wid || !_hgt){ // 기본 팝업 사이즈
        _wid = 810;
        _hgt = 810;
    }
    var options = {
        height: _hgt, // sets the height in pixels of the window.
        width: _wid, // sets the width in pixels of the window.
        toolbar: 0, // determines whether a toolbar (includes the forward and back buttons) is displayed {1 (YES) or 0 (NO)}.
        scrollbars: 0, // determines whether scrollbars appear on the window {1 (YES) or 0 (NO)}.
        status: 0, // whether a status line appears at the bottom of the window {1 (YES) or 0 (NO)}.
        resizable: 0, // whether the window can be resized {1 (YES) or 0 (NO)}. Can also be overloaded using resizable.
        left: 0, // left position when the window appears.
        top: 0, // top position when the window appears.
        center: 0, // should we center the window? {1 (YES) or 0 (NO)}. overrides top and left
        createnew: 0, // should we create a new window for each occurance {1 (YES) or 0 (NO)}.
        location: 0, // determines whether the address bar is displayed {1 (YES) or 0 (NO)}.
        menubar: 0 // determines whether the menu bar is displayed {1 (YES) or 0 (NO)}.
    };

    var parameters = "location=" + options.location +
            ",menubar=" + options.menubar +
            ",height=" + options.height +
            ",width=" + options.width +
            ",toolbar=" + options.toolbar +
            ",scrollbars=" + options.scrollbars +
            ",status=" + options.status +
            ",resizable=" + options.resizable +
            ",left=" + options.left +
            ",screenX=" + options.left +
            ",top=" + options.top +
            ",screenY=" + options.top;

    window.open(_target, _pname, parameters);
    return false;
}
