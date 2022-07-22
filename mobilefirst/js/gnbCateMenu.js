( function( $ ) {
$( document ).ready(function() {
$('#cssmenu ul li > a').on('click', function(i,v){
    
    $(this).removeAttr('href');
    $("#cssmenu > ul li ").find(".gnb4").remove();
        
        var element = $(this).parent('li');
        
        //카테고리가 4뎁스 일 경우 리스트 링크 이동
        if(element.attr("id") == '4depth'){
            
            var cateName = element.children().children().last();
            
            var temp_key = element.attr("name");
            var tempArray = temp_key.split('_');    
            var gseq = tempArray[0];
            var gcate = tempArray[1];
            
            var url = "/mobilefirst/list.jsp?cate="+gcate+"&gseq="+gseq;
            //location.href=url;
            v.preventDefault();
        }else{
            
            var temp_key = element.attr("name");
            
            if(element.attr("id") == '3depth'){
                
                var tempArray = temp_key.split('_');    
                var gseq = tempArray[0];
                var gcate = tempArray[1];
                
                cateView(element.last(),temp_key);  
                
                setCookie("c2dept",'',-1);
                setCookie("c2dept",temp_key);
                
            }
            if (element.hasClass('open')) {
                if(element.parent().attr("id") == '2depth'){
                    element.find('li').removeClass('open');
                    element.removeClass('open');
                    element.find('li').removeClass('open');
                    element.find('ul').hide();
                    
                    //대카테고리 닫으면 초기화
                    setCookie("c1dept",'',-1);
                    setCookie("c2dept",'',-1);
                }
            } else {
                if(element.attr("class") != 'first'){
                    element.addClass('open');
                    element.children('ul').show();
                    element.siblings('li').removeClass('open');
                    element.siblings('li').find('li').removeClass('open');
                    element.siblings('li').find('ul').hide();
                }
                if(element.parent().attr("id") == '2depth'){
                        
                        var id = element.attr('id');
                        
                        setCookie("c1dept",'',-1);
                        setCookie("c1dept",id);
                        
                        $('.first > ul > li > ul').each(function (i,v){
                            
                            if(element.attr('id') != $(this).parent().attr("id")){
                                
                                $(this).parent().attr('class','has-sub');
                                $(this).hide();

                            }
                            
                        });
                        scrollMove(id);
                }
            }
        }
        /*
        if(element.parent().attr("id") == '2depth'){
        
            if($(this).parent().parent().parent().attr("id") > 5 ){
                
                var h = $(window).height();
                document.body.scrollTop = h;
                
            }
            
        }
        */
        goListPage = function (g_cate,g_name){
            var cateName = $("#cssmenu ul li ul li").find(".has-sub.open").children().first().text();
                        
            if(g_name == '전체상품보기') ga('send', 'event', 'mf_common', 'gnb_중카테전체', 'type_list'); 
            else                		 ga('send', 'event', 'mf_common', 'gnb_소카테클릭', 'type_list');
            
            if(g_cate.indexOf("http://") > -1 || g_cate.indexOf("enuri_flower.jsp") > -1 || g_cate.indexOf("https://") > -1 || g_cate.indexOf("freetoken=outlink") > -1  ){
            	window.open(g_cate);
            }else{
                //연령별 추천완구 예외 처리
                if(g_cate == '101447'){
                }else{
                    location.href = '/mobilefirst/list.jsp?cate='+g_cate;   
                }
            }
        };
});
function scrollMove(id){
    window.scrollTo(0, $("#"+id).position().top);
}
/*
$('#cssmenu li.has-sub>a').on('click', function(){
        $(this).removeAttr('href');
        
        var element = $(this).parent('li');
        if (element.hasClass('open')) {
            element.removeClass('open');
            element.find('li').removeClass('open');
            element.find('ul').slideUp();
        } else {
            element.addClass('open');
            element.children('ul').slideDown();
            element.siblings('li').children('ul').slideUp();
            element.siblings('li').removeClass('open');
            element.siblings('li').find('li').removeClass('open');
            element.siblings('li').find('ul').slideUp();
        }
});
*/
    $('#cssmenu>ul>li.has-sub>a').append('<span class="holder"></span>');

    (function getColor() {
        var r, g, b;
        var textColor = $('#cssmenu').css('color');
        textColor = textColor.slice(4);
        r = textColor.slice(0, textColor.indexOf(','));
        textColor = textColor.slice(textColor.indexOf(' ') + 1);
        g = textColor.slice(0, textColor.indexOf(','));
        textColor = textColor.slice(textColor.indexOf(' ') + 1);
        b = textColor.slice(0, textColor.indexOf(')'));
        var l = rgbToHsl(r, g, b);
        if (l > 0.7) {
            $('#cssmenu>ul>li>a').css('0 1px 1px rgba(0, 0, 0, .35)');
            $('#cssmenu>ul>li>a>span').css('border-color', 'rgba(0, 0, 0, .35)');
        }
        else
        {
            $('#cssmenu>ul>li>a').css('text-shadow', '0 1px 0 rgba(255, 255, 255, .35)');
            $('#cssmenu>ul>li>a>span').css('border-color', 'rgba(255, 255, 255, .35)');
        }
    })();

    function rgbToHsl(r, g, b) {
        r /= 255, g /= 255, b /= 255;
        var max = Math.max(r, g, b), min = Math.min(r, g, b);
        var h, s, l = (max + min) / 2;

        if(max == min){
            h = s = 0;
        }
        else {
            var d = max - min;
            s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
            switch(max){
                case r: h = (g - b) / d + (g < b ? 6 : 0); break;
                case g: h = (b - r) / d + 2; break;
                case b: h = (r - g) / d + 4; break;
            }
            h /= 6;
        }
        return l;
    }
    
    
    function cateView(element,temp_key){
            
            var tempArray = temp_key.split('_');    
            var gseq = tempArray[0];
            var gcate = tempArray[1];
            
            loadUrl = "/mobilefirst/gnb/category/fourLevel.json";
            
            $('.gnb4').remove();

                
                $.ajax({
                    url: loadUrl,
                    dataType: 'json',
                    async: false,
                    success: function(json){
                        
                        var height = $(window).height()-50;
                        
                        var result = false;
                        var makeHtml = "";
                        
                        if (json) {
                            makeHtml += "<div class='gnb4'>";
                            makeHtml += "<ul id='ul4depth' style='display:block;height:"+height+"px'>";
                                
                                if(gseq==11650){
                                    makeHtml += "<li id='4depth' name='"+gseq+"_"+gcate+"'><a href=\"javascript:goListPage('"+gcate+"','전체상품보기')\" ><span>전체상품보기</span></a></li>";
                                    
                                }else{
                                
                                    $.each(json , function(i,v){
                                    
                                        if(v.g_parent == gseq){
                                            
                                            var g_name = v.g_name;
                                            var g_cate = $.trim(v.g_cate);
                                            g_name = g_name.replace("@","<em></em>");
                                            g_name = g_name.replace("\"","″");
                                            g_name = replaceAll(g_name,"<br>","");
                                            if(g_cate== '040221' || g_cate== '240619' || g_cate == '050315'){
                                                makeHtml += "<li class='ico_new' id='4depth' name='"+v.g_parent+"_"+v.g_cate+"'><a href=\"javascript:goListPage('"+v.g_cate+"','"+g_name+"')\" ><span>"+g_name+"</span></a></li>";    
                                            }else{
                                                makeHtml += "<li id='4depth' name='"+v.g_parent+"_"+v.g_cate+"'><a href=\"javascript:goListPage('"+v.g_cate+"','"+g_name+"')\" ><span>"+g_name+"</span></a></li>";
                                            }
                                            
                                        }
                                    
                                    });
                                }
                                    
                        }
                            
                            makeHtml += "</ul>";
                            makeHtml += "</div>";
                            
                            element.append(makeHtml);
                            
                            //뉴 아이콘
                            $(".ico_new").each(function(){
                                var ico_box = '<b class=ico_box></b>';
                                $(this).find("span").wrapInner(ico_box);
                                $(this).find(".ico_box").append('<small class="ico">AD</small>');
                                var parent = $(this).find("span").width();
                                var wd = $(this).find(".ico_box").width();
                                if(wd <= parent){
                                    $(this).find(".ico").css("left",wd+4);
                                }else{
                                    $(this).find(".ico").css("left",parent-($(".ico").width()-14));
                                }
                            });
                            
                        }
                    
            });
            
        };
    
});
} )( jQuery );