/* 퍼블 테스트 전용 파일입니다. */
// 쇼핑지식 적응+반응형 전환용
$(function(){
    var $body = $("body");
    var $head = $("head");
    var UserAgent = navigator.userAgent;
    var setDeivce = function(){
        if(UserAgent.match(/iPhone|iPod|iPad|iPad2|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null || UserAgent.match(/LG|SAMSUNG|Samsung/) != null) {
            $head.find("meta[name='viewport']").remove();
            $head.append('<meta NAME="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">');
            $body.addClass("mobile").removeClass("pc_o pc_u");
        }else{
            $body.addClass("pc_o");
        }
    }();
    var resizeResolution = function(){
        var _winW = $(window).width();
        if ( !$body.hasClass("mobile") ){
            if ( _winW > 1280 ) $body.addClass("pc_o").removeClass("pc_u mobile");
            else $body.addClass("pc_u").removeClass("pc_o mobile");
        }
    }
    $(window).load(resizeResolution).resize(resizeResolution);
})
