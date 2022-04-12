$(function(){
    // 연관상품 클릭
    $("#header").on("click", ".exlink_list > li.has-sub > button", function(e){
        let _sublist = $(this).siblings(".exlink_sub");
        let st = _sublist.is(":visible");
        st ? _sublist.hide() : _sublist.show();            
    })
    $('html').on('click',function(e){ // 외부클릭=>레이어 숨김
        var $t = $(e.target);
        if( !$t.closest('.exlink_list').length ){
            $(".exlink_sub").hide();
        }
    });
});