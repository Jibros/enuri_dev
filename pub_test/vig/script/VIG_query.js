//prevent browser scroll
$("body").css("overflow", "hidden");

//refresh scroll 
$(window).on('beforeunload', function() {
    $(window).scrollTop(0); 

});
 
//initiate boxes
$(document).ready(function() {  
    $.each(contentsBox, function(key, value){ 
        for(var i=0; i<=innerContentsMax; i++){
            var distance = eval('inner_c_0'+i);
            var delay = eval('inner_c_duration_0'+i);
            $(value).find('.innerContents_0'+i).css({
                top : '+='+distance
            });
        };       
    });

    $('.blockingPage').css('display','block');
    contentsMove("#contentsBox_0", 1.0, 0, 2000, 'easeOutExpo', 'easeOutExpo', '-', 300)
    tabMenu();
    
    var transJump = localStorage.getItem('transPage');
    if(isNaN(transJump)|transJump==null)transJump=0;
    console.log(transJump);   
    initValue();
    jumpPageNumber = transJump;           
    jumpMove("#div"+jumpPageNumber, 0, 'linear');
    $('.coverPage').fadeTo(300, 0, function(){
        $('.coverPage').css('display','none');
    });

    height = $(window).height();
    btnChange();  
});

/*$(window).on('keydown', function(e) {
    if(e.keyCode == 189 || e.keyCode == 187 || e.keyCode == 61 || e.keyCode == 107 || e.keyCode == 109){
        e.preventDefault();
        return;
    };
});*/

//browser resize live detecting 
var width,
    height,
    jumpDetecting = 0;
$(window).resize(function() {
    width = $(this).width();
    height = $(this).height();
    if(jumpDetecting == 0){
        $('body,html').animate({
            scrollTop: $("#div"+jumpPageNumber).offset().top,
        }, 1, 'linear');
    }else{
        $('body,html').animate({
            scrollTop: $("#div"+jumpPageNumber).stop().offset().top,
        }, 1, 'linear');
    } ;
    $('.blockingPage').css('display','none');  

    btnChange();
});

//function

// Animation ++++ MAKE 'animate function' HERE!!!!!  VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV
var inner_c_00 = 150,
    inner_c_duration_00 = 0,

    inner_c_01 = 500,
    inner_c_02 = 600,
    inner_c_03 = 800,
    inner_c_duration_01 = 800,
    inner_c_duration_02 = 300,
    inner_c_duration_03 = 0,//much ver

    inner_c_04 = 500, 
    inner_c_05 = 700, 
    inner_c_06 = 700,
    inner_c_07 = 700,
    inner_c_duration_04 = 800,
    inner_c_duration_05 = 600,
    inner_c_duration_06 = 400,
    inner_c_duration_07 = 200,//linear ver

    innerContentsMax = 7;
// Animation ++++ MAKE 'distance' HERE!!!!!

function btnUpCss(btn){
    $(btn).css({
        top : '10px'
    });
    $('.btn_line_intro, .btn_line').stop().fadeTo(20,0);
    $(btn).stop().fadeTo(0,0,function(){
        $(btn).stop().fadeTo(400,1)
    });
};

function btnDownCss(btn){
    $(btn).css({
        bottom : '6px'
    });
    $('.btn_line_intro, .btn_line').stop().fadeTo(20,0);
    $(btn).stop().fadeTo(0,0,function(){
        $(btn).stop().fadeTo(400,1)
    });
};

function btnUpRec(btn){
    $(btn).css({
        top : '8%',
    });
    $('.btn_line_intro, .btn_line').stop().fadeTo(200,1);
    $(btn).stop().fadeTo(0,0,function(){
        $(btn).stop().fadeTo(400,1)
    });
};

function btnDownRec(btn){
    $(btn).css({
        bottom : '8%'
    });
    $('.btn_line_intro, .btn_line').stop().fadeTo(200,1);
    $(btn).stop().fadeTo(0,0,function(){
        $(btn).stop().fadeTo(400,1)
    }); 
};

function btn_0Css(btn){
    $(btn).css({
        bottom : '4%'
    });
    $('.btn_line_intro, .btn_line').stop().fadeTo(20,0);
    $(btn).stop().fadeTo(0,0,function(){
        $(btn).stop().fadeTo(400,1)
    });
};

function btn_0Rec(btn){
    $(btn).css({
        bottom : '13%'
    });
    $('.btn_line_intro, .btn_line').stop().fadeTo(200,1);
    $(btn).stop().fadeTo(0,0,function(){
        $(btn).stop().fadeTo(400,1)
    });
};

var screenSmall = 0;
function btnChange(){ 
    if(height<800){        
        $.each(btn_up, function(key, value){ 
            if(screenSmall==0)btnUpCss(value);
            $(value).find('img').attr("src", "img/up_in.png");                    
        });
        $.each(btn_dn, function(key, value){ 
            if(key==0){
                if(screenSmall==0)btn_0Css(value);
                $(value).find('img').attr("src", "img/down_in_welcome.png");                 
            }else{
                if(screenSmall==0)btnDownCss(value);
                $(value).find('img').attr("src", "img/down_in.png"); 
            };
        });
        screenSmall = 1;        
    }else{
        $.each(btn_up, function(key, value){ 
            if(screenSmall==1)btnUpRec(value);
            $(value).find('img').attr("src", "img/up_"+key+".png");                  
        });
        $.each(btn_dn, function(key, value){ 
            if(key==0){
                if(screenSmall==1)btn_0Rec(value);
                $(value).find('img').attr("src", "img/down_"+key+".png")   
            }else{
                 if(screenSmall==1)btnDownRec(value);
                $(value).find('img').attr("src", "img/down_"+key+".png") 
            };
        }); 
        screenSmall = 0;    
    };
};


function contentsMove(obj, op, place, duration, ease_01, ease_02, direction,delayT){
    $(obj).stop().animate({
        opacity: op,
        top: place
    }, {duration : duration,
        specialEasing: {
        opacity : ease_02,
        top : ease_01
        }  
    });

    for(var i=0; i<=innerContentsMax; i++){
        var distance = eval('inner_c_0'+i);
        var delay = eval('inner_c_duration_0'+i);
       $(obj).find('.innerContents_0'+i).stop().animate({
            top : direction+'='+distance
        }, duration-delay, ease_01);
    };

    $(obj).find('.slideBox').stop().delay(delayT).slideDown(duration,ease_01);   
};

function contentsMoveInit(obj, op, place, duration, ease_01, ease_02, direction){
    $(obj).stop().animate({
        opacity: op,
        top: place
    }, {duration : duration,
        specialEasing: {
        opacity : ease_02,
        top : ease_01
        }  
    });

    for(var i=0; i<=innerContentsMax; i++){
        var distance = eval('inner_c_0'+i);
       $(obj).find('.innerContents_0'+i).stop().animate({
            top : direction+'='+distance
        }, duration, ease_01);
    };

    $(obj).find('.slideBox').stop().slideUp(duration,ease_01);
};
// Animation ++++ MAKE 'animate function' HERE!!!!!  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

function scrollMove(dest, duration, ease){
    $('body,html').stop().animate({
        scrollTop: $(dest).offset().top,
    }, duration, ease)
    .promise()
    .then(function(){
        $('.blockingPage').css('display','none');         
    });
}; 

function jumpMove(dest, duration, ease){
    $('body,html').stop().animate({
        scrollTop: $(dest).offset().top,
    }, duration, ease)
    .promise()
    .then(function(){
        recoverValue(); 
        localStorage.clear();
    });
}; 

function tabMenu(){
    $(".tabMenu").each(function(){
        var tab = $(this).children("ul"); //tabMenu - ul
        var tabBtn = tab.children("li").children("a"); // tabMenu - ul - li - a
        var content = tabBtn.nextAll(); // nextAll except tabMenu
        tabBtn.click(function(){
            if( $(this).hasClass("on") ) return; //on class return
            content.hide(); //all contents hide
            $(this).nextAll().show(); //clicked tab contents show & give class on
            tabBtn.removeClass("on");
            $(this).addClass("on");  
            tabBtn.each(function(){ //clicked tab btn change img
                var src;
                var img = $(this).children("img");
                if( $(this).hasClass("on") ){
                    src = img.attr("src").replace("_off.", "_on.");
                }else{
                    src = img.attr("src").replace("_on.", "_off.");
                }   
                img.attr("src", src);
            });
        });        
        tabBtn.eq(0).click(); //first tab clicked for default status
    });
}; 

function openOverlay(olEl) {
    $oLay = $(olEl);
    
    if ($('#shade').length == 0)
        $('body').prepend('<div id="shade"></div>');
    $('#shade').stop().fadeTo(300, 0.4);
    $oLay
            .css({
                display : 'block',
                opacity : 0
            })
            .stop().animate({
                opacity : 1
            }, 300);
}

var clicked = 0;
function closeOverlay() {
    if(clicked ==0){
       $('.overlay').stop().animate({
            opacity : 0
        }, 300, function() {
           $(this).css('display','none');
           clicked = 0;
            });
        $('#shade').fadeOut(300); 
    };
    clicked = 1;
};

function valueOn(obj, place){
    $(obj).stop().css({
    display : 'block',
    opacity : 1,
    top : place  
    });
};

function valueOff(obj, place){
    $(obj).stop().css({
    display : 'block',
    opacity : 0,
    top : place 
    });
};

function initValue(){    
    $('.blockingPage').css('display','block');
    closeOverlay();
    for(var i=0; i<=innerContentsMax; i++){
        var distance = eval('inner_c_0'+i);
        $('.innerContents_0'+i).css({
            top : '-='+distance,
            opacity : 1
        });
    };
    
    $.each(contentsBox, function(key, value){
        valueOn(value, 0);
        if(jumpPageNumber==key){
            for(var i=0; i<=innerContentsMax; i++){
                var distance = eval('inner_c_0'+i);
                $(value).find('.innerContents_0'+i).css({
                    top : '+='+distance
                });
            };
        }; // Animation +++++++++++++++++++++++++++ initiate value
    });
    $('.slideBox').css('display', 'block');
    jumpDetecting = 1; 
};

function recoverValue(){   
    $('.blockingPage').css('display','none');
    $.each(contentsBox, function(key, value){       
        if(key == jumpPageNumber){
            valueOn(value, 0);
            $(value).find('.slidegBox').css('display', 'block');
        }else{
            valueOff(value, 200);
            $(value).find('.slideBox').css('display', 'none');
            for(var i=0; i<=innerContentsMax; i++){
                var distance = eval('inner_c_0'+i);
                $(value).find('.innerContents_0'+i).css({
                    top : '+='+distance
                });
            }; 
        }; // Animation +++++++++++++++++++++++++++ recover value
    });
    jumpDetecting = 0;
};

//DO each scroll
var btn_up = [],
    btn_dn = [],
    contentsBox = [],
    btnMax = 6;

for(var i=0; i<=btnMax; i++){
   btn_up.push("#btn_up_"+i);
   btn_dn.push("#btn_dn_"+i); 
   contentsBox.push("#contentsBox_"+i);
};

$.each(btn_up, function(key, value){
    $(value).off('click').on('click',function(){
        $('.blockingPage').css('display','block');
        scrollMove("#div"+(key-1), 1400, 'easeOutExpo');
        contentsMove("#contentsBox_"+(key-1), 1.0, 0, 0, 'easeOutExpo', 'easeOutExpo', '-',0);
        contentsMoveInit("#contentsBox_"+key, 0.0, 150, 1000, 'easeInQuad', 'easeOutExpo', '+');
        jumpPageNumber--;
        if(jumpPageNumber<0) jumpPageNumber = 0;

    });
});

$.each(btn_dn, function(key, value){
    $(value).off('click').on('click',function(){
        $('.blockingPage').css('display','block');
        scrollMove("#div"+(key+1), 1400, 'easeOutExpo');
        contentsMove("#contentsBox_"+(key+1), 1.0, 0, 2000, 'easeOutExpo', 'easeOutExpo', '-',300);
        contentsMoveInit("#contentsBox_"+key, 0.0, 150, 1000, 'easeInQuad', 'easeOutExpo', '+');
        jumpPageNumber++;
        if(jumpPageNumber>6) jumpPageNumber = 6;
    });
});
  
//DO overlay
$('body').on("click", "#shade, .close", function(){
    closeOverlay();
});// close

var launch = [],
    popMax = 50;

for(var i=0; i<=popMax; i++){
   launch.push("#launch_"+i); 
}

$.each(launch, function(key, value){
    $(value).on('click',function(){
        openOverlay("#inbox_"+key);
        if(key>6){
            $('nav').css('z-index','3');
        }else{
            $('nav').css('z-index','10');
        }
    });
}); //each open

//DO jump menu
var jumpPageNumber = 0,
    jumpBtn = [],
    jumpMax = 6;

for(var i=0; i<=jumpMax; i++){
   jumpBtn.push(".jumpBtn_"+i+" img"); 
};

$.each(jumpBtn, function(key, value){
    $(value).on('click',function(){
        if(jumpPageNumber==key){
            closeOverlay();
            return;
        }else{
            initValue();
            jumpPageNumber = key;           
            jumpMove("#div"+jumpPageNumber, 2000, 'easeOutExpo');    
        }
        
    });
});

//blink tab menu
var blinkLaunchBtn =[],
    blinkLaunchMax = 50;

for(var i=19; i<=blinkLaunchMax; i++){
   blinkLaunchBtn.push("#launch_"+i); 
};

$.each(blinkLaunchBtn, function(key, value){
    $(value).mouseover(function(){
        $("#blink_"+key).stop().fadeTo(200, 1, 'easeInOutSine');
    });
    $(value).mouseleave(function(){
        $("#blink_"+key).stop().fadeTo(200, 0, 'easeInOutSine');
    });
});

//Eng<------------->Kor give page number
$(".kor").on('click',function(){
    localStorage.setItem('transPage', jumpPageNumber);
});