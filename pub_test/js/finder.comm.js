var $finderWrap = $(".finder_wrap"); // 파인더 wrapper
var $optBtn = $(".finder__source .opt__btn li"); // 필터 버튼
var $fTabItem = $(".finder__head li"), // 파인더 상단 탭 LI
    $fTabBtn = $fTabItem.children(".tab"), // 파인더 상단 탭 LI > 탭 버튼
    $resetBtn = $(".btn-reset"), // 파인더 선택초기화 버튼
    $listingBtn = $(".btn-listing"), // 파인더 상품보기 버튼
    $listingBtnCount = $listingBtn.find("em"); // 파인더 상품보기 버튼 내 갯수
    $finderCloseBtn = $(".finder_wrap .dimmed"); // 파인더 닫는 버튼 
    $totalCnt = parseInt($(".prdc_total .tx_cnt strong").text().replace(/,/g,''),10), // 임의 상품 목록 갯수
    $reTotalCnt = $totalCnt; // 재적립 갯수

// INIT
$(function(){
    // 파인더 함수 실행
    finderInit();

    // 파인더 열기
    $optBtn.on("click", function(){ 
        var _idx = $(this).index();
        finder_open(_idx);
    });
})

// 파인더 이너 스와이퍼 생성                                    
var finderInnerSwiper = new Swiper(".finder__swiper", {
    loop : false,
    slidesPerView : 1,
    spaceBetween : 0,
    adaptiveHeight:true
});

var finder_close = function(idx){
    $finderWrap.removeClass("is-shown");    
    $("body").css({"overflow":"visible"});

    setTimeout(function(){
        $optBtn.removeClass('is--on');
    }, 100)
    setTimeout(function(){
        $finderWrap.css("z-index", "-1");

        console.log(idx)
        $optBtn.eq(idx).addClass("is--on");
    }, 300)

    if($(".finder").hasClass("is-expand")){
        $(".finder").removeClass("is-expand");
    }
}

var finder_open = function(idx){
    var _idx = idx;
    $finderWrap.css("z-index", "10000");
    $("body").css({"overflow":"hidden"});

    setTimeout(function(){
        $finderWrap.addClass("is-shown");
        
        $fTabItem.eq(_idx).addClass('is--on');

        $(".finder__foot .btn-listing").attr("data-idx",_idx)
    }, 100)
    finderInnerSwiper.slideTo(_idx);    

}

// 스크롤 탑 
var topMove = function(){
    $('.cate__list').stop(0).animate({scrollTop: '0'}, 300);
    $('.brand_list').stop(0).animate({scrollTop: '0'}, 300);
    $('.sort__list').stop(0).animate({scrollTop: '0'}, 300);
}


// 파인더 함수
var finderInit = function(){
    // 처음 한번 총 상품 갯수 삽입 
    $listingBtn.find("em").text(comma(Math.floor($totalCnt)));    
   
    // 가격 탭 > 슬라이더 실행
    priceRangeFunc(); 
    // 카테고리(체크 목록 형태) 탭 > 실행
    cateOptionFunc();
    // 브랜드 정렬 탭 선택
    brandSortFunc();

    // 파인더 상단 버튼 클릭 
    $fTabItem.on("click", function(){
        var _idx = $(this).closest("li").index();

        // 해당 탭 Slide이동
        finderInnerSwiper.slideTo(_idx);

        // 탭 상단 이동
        topMove();
    })

    // 슬라이드할 때 해당 탭 활성화
    finderInnerSwiper.on("slideChangeStart", function(e){
        var _idx = e.activeIndex; // 현재 슬라이드 Index

        $fTabItem.removeClass("is--on").eq(_idx).addClass("is--on");
        
        $(".finder").removeClass("is-expand");
    })

    // 파인더 선택초기화 버튼
    $resetBtn.on("click", function(){
        $listingBtn.find("em").text(0);
        $cateTab.removeClass("is--on")
        $fTabBtn.removeClass("tab-choice")
        _totalCount = 0;    
    })

    // 파인더 닫기
    $finderCloseBtn.on("click", function(){ 
        finder_close();
    });    
}

$listingBtn.on("click",function(){
    prodViewFunc(this);
});  
var prodViewFunc = function(obj){
    // 상품보기 클릭이벤트    
    var prodViewIdx = $(obj).attr("data-idx");

    finder_close(prodViewIdx);

    $("#loadingDiv").fadeIn(500);
    setTimeout(function(){
        $("#loadingDiv").fadeOut(500);
        
        // 선택된 버튼 활성화 
        $(".opt__btn li").addClass("is--on")
    },400);
}

// 함수 : 카테고리 탭 > 옵션 선택
var cateOptionFunc = function(){
    var $cateList = $(".cate__list");
    var $cateTab = $cateList.children("li");
    
    $cateTab.on("click", function(){
        var _this = $(this),
            _thisState = _this.hasClass("is--on"),
            _idx = _this.closest(".finder__item").index()+1;
            
        _addCount = _this.find(".btn, .btn-color").data("cnt");

        // spinner 실행
        $listingBtn.addClass("is-loading");						

        if(!_thisState){
            $(this).addClass("is--on");

            setTimeout(function(){
                // 1초뒤 spinner 제거
                $listingBtn.removeClass("is-loading");

                $totalCnt += _addCount;

                optionCountAni(_idx)
            },1000)
        }else{
            $(this).removeClass("is--on");

            setTimeout(function(){
                // 1초뒤 spinner 제거
                $listingBtn.removeClass("is-loading");

                $totalCnt -= _addCount;

                optionCountAni(_idx);
            },1000);
        }
        
        // 옵션 선택 시 상단 탭 활성화 (".finder__head li")
        var selState = _this.closest(".cate__box .cate__list").find("li").hasClass("is--on"); // 선택이 있나/없나
        
        if(!selState) $fTabItem.eq(_idx-1).find(".tab").removeClass("tab-choice");
        else $fTabItem.eq(_idx-1).find(".tab").addClass("tab-choice");
    })
}

// 브랜드 인기순,A-Z,ㄱ-ㅎ 탭 선택 시 컨텐츠 노출
var brandSortFunc = function(){
    var $brandTab = $(".sort_tab > ul > li");
    var $brandCont = $(".brand_container .brand_cont");

    $brandTab.on("click", function(){
        var _this = $(this);
        var _idx = _this.index();

        $brandTab.removeClass("is--on");
        _this.addClass("is--on");
        $brandCont.removeClass("is-shown");
        $brandCont.eq(_idx).addClass("is-shown");

        // 탭 상단 이동
        topMove();
    })

    // 브랜드 스크롤 상단 시, 파인더 확장
    var startY, endY;
    $(".brand_container").on('touchstart',function(event){
        startY = event.originalEvent.changedTouches[0].screenY;
    });
    $(".brand_container").on('touchend',function(event){
        endY = event.originalEvent.changedTouches[0].screenY;
        if(startY-endY>50){
            $(".finder").addClass("is-expand")
        }
    });
}

// 함수 : 가격 탭 > Range 슬라이더
var priceRangeFunc = function(){
    // 가격 슬라이더
    var nonLinearSlider = document.getElementById('nonlinear');

    // 슬라이더 생성
    noUiSlider.create(nonLinearSlider, {
        connect: true,
        behaviour: 'tap',
        start: [1000, 270000],
        range: {
            // Starting at 500, step the value by 500,
            // until 4000 is reached. From there, step by 1000.
            'min': [1000, 50],
            '10%': [5000, 1000],
            '50%': [134500, 1000],
            'max': [270000]
        }
    });

    // 슬라이더 min,max 노드
    var nodes = [
        document.getElementById('rangeMin'), // 0
        document.getElementById('rangeMax')  // 1
    ];

    // Display the slider value and how far the handle moved
    // from the left edge of the slider.

    // 슬라이더 이동시
    nonLinearSlider.noUiSlider.on('update', function (values, handle, unencoded, isTap, positions) {
        //nodes[handle].innerHTML = values[handle] + ', ' + positions[handle].toFixed(2) + '%';
        //console.log(Math.floor(values[0], values[1])/* , handle, unencoded, isTap, positions */)
        var values = nonLinearSlider.noUiSlider.get();
        var value = Math.floor(values[handle]);
        
        nodes[handle].innerHTML = comma(Math.floor(values[handle]));
    });

    // 슬라이더 이동 끝난 후
    nonLinearSlider.noUiSlider.on('end', function(values, handle){
        // spinner 실행
        $listingBtn.addClass("is-loading");

        setTimeout(function(){
            // 1초뒤 spinner 제거
            $listingBtn.removeClass("is-loading");

            // spinner 제거 후 상품 갯수 카운팅
            var prdcCount = parseInt($listingBtnCount); // 임의 갯수 
            
            $fTabItem.eq(0).children(".tab").addClass("tab-choice");

            // 상품 갯수 카운팅 호출
            countAnimate(prdcCount, values, handle);
        },1000)
    });
}

// 상품 수 카운팅 애니메이션 (가격 슬라이더 전용)
var countAnimate = function(prdcCount, values, handle){
    // prdcCount = 선택한 가격내 갯수 
    // values = 최소가,최고가
    // handle = 좌:0, 우:1 controller 
    // console.log(prdcCount, values, handle)
    $( {countNum: prdcCount } ).stop(true,true).animate({countNum : values[handle]/3 },{
        duration : 400,
        easing : 'linear',
        step : function(){
            $listingBtnCount.text( comma(Math.floor(this.countNum)) )
        },
        complete : function(){
            $totalCnt = Math.floor(this.countNum);
        }
    })								
}

// 상품 수 카운팅 애니메이션 (공통)
var optionCountAni = function(_idx){
    // spinner 제거 후 버튼에 상품 갯수 입력
    var _prevTotal = parseInt($("#prodCnt"+_idx).text().replace(/,/g,''),10);
                
    $( {countNum: _prevTotal } ).stop(true,true).animate({countNum : $totalCnt },{
        duration : 400,
        easing : 'linear',
        step : function(){
            $listingBtnCount.text( comma(Math.floor(this.countNum)) )
        },
        complete : function(){
            $totalCnt = Math.floor(this.countNum);
        }
    })
}

// 금액 3자릿수 "," 찍기
function comma(num){
    var len, point, str; 
    num = num + ""; 
    point = num.length % 3 ;
    len = num.length; 
    str = num.substring(0, point); 
    while (point < len) { 
        if (str != "") str += ","; 
        str += num.substring(point, point + 3); 
        point += 3; 
    } 
    return str;
}
