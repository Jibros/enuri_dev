// 탭메뉴 클릭시 배경색상 변경
$(function(){
    var tab = $('.tab-menu li') ;
    var defaultColor = 'none';
    var changeColor = ["#d95b34", "#8173ff", "#2d62dd"];
    
    tab.click(function(){
        var liIndex = $(this).index();

        $(this).css('background', changeColor[liIndex]).siblings().css('background', defaultColor);
    })
})

// 탭메뉴 클릭시 글자색 변경
$(function(){
    $('.tab-menu li').click(function(){
        $(this).find("a").addClass('on');
        $(this).siblings().find("a").removeClass('on');
    });
})



// 마우스 hover시 바로가기 올라오기
$(function(){  
  
    /* $('.store').hover(function(){
        $('.go1').addClass('show');
        $('.store a ').css('padding-top', '80px');

    });
    $('.attend').hover(function(){
        $('.go2').addClass('show');
        $('.attend a').css('padding-top', '80px');

    });
    $('.stamp').hover(function(){
        $('.go3').addClass('show');
        $('.stamp a').css('padding-top', '80px');

    });
    $('.event').hover(function(){
        $('.go4').addClass('show');
        $('.event a').css('padding-top', '70px');

    }); */

    $('.benefit-list li').mouseenter(function(){
        $(this).find("a").addClass("show")
    }).mouseleave(function(){
        $(this).find("a").removeClass("show")
    });

    /* $('.benefit-list li').mouseenter(function(){
        $(this).find("a").addClass("show")
    });
    $('.benefit-list li').mouseleave(function(){
        $(this).find("a").removeClass("show")
        $('.go1').removeClass('show')
        $('.go2').removeClass('show')
        $('.go3').removeClass('show')
        $('.go4').removeClass('show')
        $('.store a ').css('padding-top', '95px');
        $('.attend a').css('padding-top', '95px');
        $('.stamp a').css('padding-top', '95px');
        $('.event a').css('padding-top', '95px');

    }) */

})


// 꼭 확인하세요
$(function(){
    $('.notice-area').hide();

    $('.notice-more').on('click',function(){
        $('.notice-area').show();
        $('.notice-popup').addClass('up');
    });

    $('.close').click(function(){
        $('.notice-area').hide();
        $('.notice-popup').removeClass('up');
    });

    $('.notice-button').click(function(){
        $('.notice-area').hide();
        $('.notice-popup').removeClass('up');
    })

    $('.notice-area').click(function(){
        $('.notice-area').hide();
        $('.notice-popup').removeClass('up');
    })
})

// 화면 자동이동 