// 탭 이동 , 메뉴색 변경
$(function(){
    var $li = $('.tab-menu li');
    $('.tab-menu li').on('click' ,function(){
        var target = $(this).data('target');
        var targetPos = $(target).offset().top;
        var tabheight = $('.tab-menu-wrap').height();
        $('html').animate({scrollTop: (targetPos - tabheight) });
        $(this).addClass('on').siblings().removeClass('on');
    });
})



$(window).scroll(function(){ 
    var add = $('html').scrollTop();
    var menu = $('.tab-menu-wrap');
    var menuHeight = menu.height();
    var addpos = $('.tabcontent1').offset().top;
    var content = $('.content3').offset().top;

    if (add >= (addpos - menuHeight)) {
        menu.addClass('fixed');
        menu.parents('.tabintro').css('padding-bottom', '160px')
        if (add >= (content - menuHeight)) {
            menu.removeClass('fixed');
    
        }
    } else {
        menu.removeClass('fixed');
        menu.parents('.tabintro').css('padding-bottom', '80px')
    }
});

//   $(window).scroll(function(){
//       var remove = $('html').scrollTop();
//       var menu = $('.tab-menu-wrap');
//       var removePos = $('.content3').offset().top;
//       var removetab = $('.tabintro').offset().top;
//       if( remove >= removePos){ menu.removeClass('fixed')}
//       else if( remove < removetab) { menu.removeClass('fixed')}
//   })

//   스크롤시 메뉴색 변경
//   $(window).scroll(function(){
//       var $tabmenu = $('.tab-menu li');    
//      if( $('tabcontent1').offset().top){$(tabmenu).eq(0).addClass('on')}
//   })