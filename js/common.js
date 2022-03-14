AgentFlag = set_ui();
IEFlag = (navigator.appVersion.indexOf("MSIE 7") > -1 || navigator.appVersion.indexOf("MSIE 8") > -1)?true:false;
IE7Flag = (navigator.appVersion.indexOf("MSIE 7") > -1)?true:false;
ReponList = [];

$(function(){
	mResizeCheck = $(window).width();
	npos = $(window).scrollTop();
	SW	=	$(window).width();
	SH	=	$(window).height();	
	commonTop.init();

	/* List Reponsive Height */
	if(!IE7Flag){		
		if($('.Re_list').length > 0){
			$('.Re_list').each(function(){				
				var list = new ReponsiveList($(this));
				ReponList.push(list);				
			});
		}
	}
	
	gnb.init();
	if($('.accordion-menu').length > 0)Accordion_Menu.init();
});//end ready

$(window).scroll(function() {			
	npos = $(window).scrollTop();
	SW	=	$(window).width();
	SH	=	$(window).height();
	commonTop.scrollCheck();
});//end scroll

$(window).resize(function(){
	if (mResizeCheck != $(window).width()) {
		npos = $(window).scrollTop();
		SW	=	$(window).width();
		SH	=	$(window).height();
		commonTop.scrollCheck();
		gnb.resizeCheck();
		if(!IE7Flag){
			if($('.Re_list').length > 0)ReponsiveListResize();
		}
		mResizeCheck = $(window).width();
	}

});//end resize


/**********************************
@ header function
**********************************/
var commonTop = {
	btnTopFlag:null,
	init:function(){
		commonTop.btnTopFag = (npos >= 135)?false:true;
		$('.global').find(' > a').mouseenter(function(){
			$(this).next().stop(true).slideDown(300);
		});
		$('.global').find(' > ul').mouseleave(function(){
			$(this).stop(true).slideUp(300);
		});
	},
	scrollCheck:function(){
		var _topY = 135;
		if(npos >= _topY){
			if(!commonTop.btnTopFlag){
				$('#btn_top_scroll').stop(true).fadeIn(300);
			}
			commonTop.btnTopFlag = true;
			
		}else{
			if(commonTop.btnTopFlag){
				$('#btn_top_scroll').stop(true).fadeOut(300);
			}			
			commonTop.btnTopFlag = false;
		}
	}
}

var gnb = {
    btnTopFlag:null,
    init:function(){
		/*
		$('#side').find('.side_con > ul > li > a').click(function(){
			gnb.sideAlign($(this).parent().index());
		});
		*/
    },
    GnbCheck:function(){
        if($("#side").hasClass("open")){
            $("#side").removeClass("open");            
			$('html').removeClass('fix');
        }else{
            $("#side").addClass("open");
			$('html').addClass('fix');
        }        
    },
    scrollCheck:function(){

    },
	resizeCheck:function(){
		if(SW > 1024){
            $("#side").removeClass("open");            
			$('html').removeClass('fix');
		}
	},
	sideAlign:function(_i){
		$('#side').find('.side_con > ul > li').each(function(){
			if($(this).index() == _i){
				$(this).addClass('open');
			}else{
				$(this).removeClass('open');
			}
		});
	}
}




//parameter
function getParameter(key) 
{ 
    var url = location.href; 
    var spoint = url.indexOf("?"); 
    var query = url.substring(spoint,url.length); 
    var keys = new Array; 
    var values = new Array; 
    var nextStartPoint = 0; 
    while(query.indexOf("&",(nextStartPoint+1) ) >-1 ){ 
        var item = query.substring(nextStartPoint, query.indexOf("&",(nextStartPoint+1) ) ); 
        var p = item.indexOf("="); 
        keys[keys.length] = item.substring(1,p); 
        values[values.length] = item.substring(p+1,item.length); 
        nextStartPoint = query.indexOf("&", (nextStartPoint+1) ); 
    } 
    item = query.substring(nextStartPoint, query.length); 
    p = item.indexOf("="); 
    keys[keys.length] = item.substring(1,p); 
    values[values.length] = item.substring(p+1,item.length); 
    var value = ""; 
    for(var i=0; i<keys.length; i++){ 
        if(keys[i]==key){ 
            value = values[i]; 
        } 
    } 
    return value; 
};//end getParameter

function set_ui(){
	var UserAgent = navigator.userAgent;
	var UserFlag	=	true;
	if (UserAgent.match(/iPhone|iPad|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null || UserAgent.match(/LG|SAMSUNG|Samsung/) != null)
	{
		//mobile!!
		UserFlag = false;
	}
	return UserFlag
};//end set_ui


function ReponsiveListResize(){
	if($('.Re_list').length > 0){
		var _i = 0;		
		$('.Re_list').each(function(){			
			ReponList[_i].setHeight();
			_i++;
		});
	}
}


function ReponsiveList(_list){
	var _this = this;
	var $list = _list;
	var $items = $list.find( '.list__item__inner' );
	this.setHeight = function(){
		$items.css( 'height', 'auto' );
		var perRow = Math.ceil( $list.width() / $items.width() );
		if( perRow == null || perRow < 2 ) return true;

		for( var i = 0, j = $items.length; i < j; i += perRow )
		{
			var maxHeight	= 0,
				$row		= $items.slice( i, i + perRow );
			$row.each( function()
			{
				var itemHeight = parseInt( $( this ).outerHeight() );				
				if ( itemHeight > maxHeight ) maxHeight = itemHeight;
				
			});
			$row.css( 'height', maxHeight );
		}
	}
	_this.setHeight();
	$list.find( 'img' ).on( 'load', _this.setHeights );
}


Accordion_Menu = {
    init:function(){
        jQuery('.accordion-menu').find('> li > a').click(function(){
            Accordion_Menu.ClickHand($(this).parent().index());
        });
    },
    ClickHand:function(_i){
        jQuery('.accordion-menu').find('> li').each(function(){
            if($(this).index() == _i){
                if($(this).hasClass('open')){
                    $(this).removeClass('open').find('.acoordion-data').stop(true).slideUp(300);
                }else{
                    $(this).addClass('open').find('.acoordion-data').stop(true).slideDown(300);
                }
            }else{
                $(this).removeClass('open').find('.acoordion-data').stop(true).slideUp(300);
            }
        });
    }
}


function openPop(_title){
	$('html').addClass('fix');
	var _target = $('.'+_title);
	_target.stop(true).fadeIn(300);
}

function closePop(){
	$('html').removeClass('fix');
	$('.commonPop').stop(true).fadeOut(300);
}


//숫자만 입력 받을 경우
function numberOnly(num){
	var regNumber = /^[0-9]*$/;
	  
	if(!regNumber.test(num)) {
	    return false;
	}else{
	    return true;	
	}
}

//한글만 입력 받을 경우
function hangulOnly(input){
	var regex= /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
	  
	if(!regex.test(num)) {
	    return false;
	}else{
	    return true;
	}
}

//한글만 입력 받을 경우
function emailCheck(input){
	
	var regex=/^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{1,5}$/;
	  
	if(!regex.test(input)) {
	    return false;
	}else{
	    return true;
	}
}
//전화번호 체크
function phoneCheck(input){
	
	var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;//전화번호 체크 01012341234,010-1234-1234
	
	if(!input || !regExp.test(input)){
		return false;
	}else{
		return true;
	}
}
//script 제거
function XSSfilter (content) {
	return content.replace(/\</g, "&lt;").replace(/\>/g, "&gt;");
}