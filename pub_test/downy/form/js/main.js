$('.condition-list ul').each(function(index, item){
    var defaultHeight = 47;
    var target_height = $(item).height();
    if(target_height > defaultHeight) {
        $(item).parent().prev().append('<button type="button" class="btn_more"></button>');
    }
    $(item).css({'height':'46px', 'overflow':'hidden'});
   
});

$('.selection-list ul').each(function(index, item){
    var defaultHeight = 47;
    var target_height = $(item).height();
    if(target_height > defaultHeight) {
        $(item).parent().prev().append('<button type="button" class="btn_more"></button>');
    }
    $(item).css({'height':'46px', 'overflow':'hidden'});
   
});

 // 버튼 클릭
 $('.btn_more').on('click', function(){
    $(this).parents('ul').toggleClass('expand');
});


// 클릭시 조건에 추가 
$('.condition-list ul label').click(function(){
    var addItem = $(this).text();
    var addValue = $(this).prev().val();
    var ischecked = ($(this).prev().prop('checked') === false ? true : false );

    if(ischecked === true) {
        $('.list-inner ul.add_item').append("<li><span data-value='"+ addValue +"'>"+addItem+"<button class='close'>x</button></span></li>");
    } else {
        $('.list-inner ul.add_item li span[data-value='+ addValue +']').remove();
    }
})

function selectedOptionReset(){
    $('.list-inner ul.add_item li').remove();
}
$('button.reset').on('click', function(){
    selectedOptionReset();
});

$("body").on("click", ".close", function(){
    $(this).closest("li").remove();
    console.log('dddd');
})

