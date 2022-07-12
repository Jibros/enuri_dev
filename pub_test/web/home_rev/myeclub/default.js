// 21.10.15__작성자 : 박현원
// 작동시 디자인변경 되는 부분만 참고하시기 바랍니다.
//
// 스크롤시 고정 

// 메뉴출력
$.ajax({
    type:"GET",
    url: './json/gnb.json',
    dataType: "JSON",
}).done(function(data){
    let html = '';
    html += '<ul class="mec__lnb_menu">';
    $.each(data.gnbCategory.depth1, function(index, values){
        html += '    <li>';
        html += '       <'+ values.tagType +' href="'+ (values.href ? values.href : '#') +'" class="menu_name" '+ (values.dropdown != false ? 'data-dropdown="'+ values.dropdown +'"' : '') +'>'+ values.name +'</'+ values.tagType +'>';
        if(values.depth2) {
            html += '       <ul class="mec__lnb_submenu">';
            $.each(values.depth2, function(index, values){
                html += '		    <li><a href="'+ values.href +'" class="submenu_name">'+ values.name +'</a></li>';
            });
            html += '       </ul>';
        }
        html += '    </li>';
    });
    html += '</ul>';

    $('.mec__lnb').append(html);
    slideMenu();
    activeOnLoad()
});

// lnb - 메뉴클릭시 효과
function slideMenu() {
    $('.mec__lnb .menu_name').on('click', function(e){
        if($(this).data('dropdown') || $(this).data('dropdown') === 'possible') {
            e.preventDefault();
            if($(this).hasClass('active')) {
                $(this).removeClass('active').next().stop().slideUp();
            } else {
                $('[data-dropdown]').removeClass('active');
                $('[data-dropdown]').next().stop().slideUp();
                $(this).addClass('active').next().stop().slideDown();
            }    
        }
    });
}
// 파라미터 - 퍼블에서만 사용
// var getParameters = function (paramName) { 
//     var returnValue; 
//     var url = location.href;  
//     var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&'); 
//     for (var i = 0; i < parameters.length; i++) {
//         var varName = parameters[i].split('=')[0]; 
//         if (varName.toUpperCase() == paramName.toUpperCase()) { 
//             returnValue = parameters[i].split('=')[1]; 
//             return decodeURIComponent(returnValue); 
//         }    
//     } 
// };
// lnb - 오픈페이지확인 _(수정)
function activeOnLoad() {
    var filePath = window.location.pathname;
    filePath = filePath.replace("/pub_test/web/home_rev/myeclub/", "");
    $('.mec__lnb a').each(function(index, item){
        var currentFileName = $(item).attr('href');
        currentFileName = currentFileName.replace("./", "");

        // console.log(filePath + ' / ' + currentFileName + ' / ' + $(item).length);

        if(currentFileName === filePath) {
            $(item).addClass('active').parents('.mec__lnb_submenu').show();
            $(item).parents('.mec__lnb_submenu').prev().addClass('active');
        }
    })
}

var gw = $('.global_wrap'), 
    gl = $('.global_left'),
    gw_left = gw.offset().left,
    gl_top = gl.offset().top;

$(window).on('scroll', function(){
    var f_top = $('.footer').offset().top; //페이지 높이가 달라지는경우가있음; 스크롤시 재측정..윈도우사이즈조정시등...
    var scroll_value = $(window).scrollTop();
    var gl_height = gl.height();
    var pos_bottom = gl_height + scroll_value;
    // 메뉴가 윈도우 상단에 닿았을경우
    if(gl_top < scroll_value) {
        gl.addClass('is--fixed').css({'left': gw_left });
    } else {
        gl.removeClass('is--fixed').css('left', '0');
    }
    // 메뉴가 하단에 닿았을경우
    if(f_top < pos_bottom) {
        gl.removeClass('is--fixed').css({'left':'0', 'top': 'auto', 'bottom' :'0'});
    } else {
        gl.css({'top': '0', 'bottom' :'auto'});
    }
});

// lnb - 화면리사이즈시 위치 변경
$(window).on('resize', function(){
    gw_left = gw.offset().left;
    if(gl.hasClass('is--fixed')) {
        gl.css('left', gw_left);
    }
});

// page_content - 더보기레이어 오픈
$('.open_layer').on('click', function(){
    $(this).find('.layer_common').toggle();
});

// 혜택쪽 스와이퍼 기본세팅
var swiperSetting = function(slidesPerView) {
    this.slidesPerView =  slidesPerView,
    this.spaceBetween =  12,
    this.grabCursor =  true,
    this.nextButton  =  '.btn_next',
    this.prevButton  =  '.btn_prev';
}
// slidesPerView만 변경적용, 좋은방법은아닌듯;
var newSoppingmallSetting = new swiperSetting(14);
var newCardbrandSetting = new swiperSetting(7);

// 최초실행
var shoppingmall_logo_swiper = new Swiper(".shoppingmall_logo_swiper", newSoppingmallSetting);

// page_content - 탭
$('.tab_menu li').on('click', function(){
    var tab_target = $(this).data('tabname');
    $(this).addClass('active').siblings().removeClass('active');
    $(tab_target).addClass('active').siblings().removeClass('active');

    if(tab_target === '#tab_shoppingmall') {
        var shoppingmall_logo_swiper = new Swiper(".shoppingmall_logo_swiper", newSoppingmallSetting);
    }
    if(tab_target === '#tab_cardbrand') {
        var cardbrand_logo_swiper = new Swiper(".cardbrand_logo_swiper", newCardbrandSetting);
    } 
});

// 찜상품 이동 활성/비활성화
function moveBtnDisable() {
    if($('input[name=single_checked]:checked').length > 0) {
        $('.btn_move_zzim').removeClass('disabled');
    } else {
        $('.btn_move_zzim').addClass('disabled');
    }
}
// 전체석택클릭시 전체선택되게
function allCheck() {
    if($('input[name=checkall]').prop('checked')) {
        $('.page_content').find('input[type=checkbox]').prop('checked', true);
    } else {
        $('.page_content').find('input[type=checkbox]').prop('checked', false);
    }
}
// 싱글전체선택시 전체선택체크여부
function singleAllCheck() {
    if($('input[name=single_checked]:checked').length === $('input[name=single_checked]').length ) {
        $('input[name=checkall]').prop('checked',true);
    } else {
        $('input[name=checkall]').prop('checked',false);
    }
}
// 묶음단위 전체체크
function bundleCheckAll(elem) {
    var bundle = $(elem).parents('.bundle');
    if($(elem).prop('checked')) {
        $('input[type=checkbox]', bundle).prop('checked',true);
    } else {
        $('input[type=checkbox]', bundle).prop('checked',false);
    }
}
// 상품체크박스시 박스활성화
function checkBoxCheck(elem) {
    var target = $(elem).find('input[type=checkbox]');
    if(target.prop('checked')) {
        target.parent().parent().addClass('selected'); 
    } else {
        target.parent().parent().removeClass('selected');
    }
}
// 전체,묶음단위는 인풋선택자 클릭가능
$('input[name]').on('click', function(){
    var name = $(this).attr('name');
    if(name === 'checkall') {
        allCheck();
    } 
    if(name === 'bundle_checkall') {
        bundleCheckAll(this);
    }
});
// 일단 싱글체크박스단위는 인풋클릭불가 막아놨음..디자인상..이중클릭이되어버림
// 상품전체영역클릭시 체크되게 적용 선택자가 input이 아님.
// page_content - 체크박스이외 상품영역클릭시 작동되게..
$('.goods .input_wrap, .recent_list .input_wrap, .stores .input_wrap').on('click', function(){
    if($(this).find('input').prop('checked')) {
        $(this).find('input').prop('checked', false);
    } else {
        $(this).find('input').prop('checked', true);
    }
    singleAllCheck();
    checkBoxCheck(this);
    moveBtnDisable();
});

// 모달팝업 열기
function openModalPopup(elem, st, ct) { //팝업대상, 확인대상, 선택대상(onclick시고정)
    var target = $(elem);
    var target_pos_width = target.width();
    var target_pos_height = target.height();
    target.before('<div class="lay_overlay"></div>')
    target.css({
        'margin-top': -(target_pos_height/2),
        'margin-left': -(target_pos_width/2),
    })
    target.fadeIn();

    target.prev().on('click', function(){
        closeModalPopup(elem);
    });
    $('.btn-close, .btn_cancle', target).on('click', function(){
        closeModalPopup(elem);
    });

    target.find('.btn_confirm').on('click', function(){
        if(st) $(st).parent().remove(); 
        if(ct) $(ct).remove();
        closeModalPopup(elem);
    })
}
// 모달팝업 닫기
function closeModalPopup(elem) {
    var target = $(elem),
        target_overlay = $('.lay_overlay');
    target_overlay.fadeOut(function(){$(this).remove();});
    target.fadeOut();
}

// 스크롤이동
function moveScroll(elem) {
    var target = $(elem);
    $('html, body').animate({scrollTop : target.off().top}, 1000);
    return false;
}

$(document).ready(function(){
    $("header").load("header.html");
    $("#footer").load("footer.html");
});


