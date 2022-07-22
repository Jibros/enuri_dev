/**
 * 트렌드 픽업 관련 
 */
(function(){
//function trendPickLoad(){
	// 총갯수  샛팅
	var $total = $("#trendProdPage").find('span');
    var $current = $total.prev();
	
	try{
		var iscroll = new iScroll("#trd_scroll");
	}catch(e){}
	
	// 트렌드리스트 카테고리 
	var trendList = {
			all : [],
			cate1 : [],
			cate2 : [],
			cate3 : [],
			cate4 : []
	};
	
	try {
	    $.each(gHomeJson.trendpick, function(k, item) {
	        if (!item.length) {
	            return;
	        }
	        
	        // 트렌드 픽업 랜더링 
	        renderTrendPick(item, k.indexOf('all') > -1);
	    });
	
	    $total.text(trendList.all.length);
	    // rolling 
	    // 커러셀
	    $("#trendpick").append(trendList.all.join("\n")).slick({
	        arrows: true,
	        infinite: true,
	        mobileFirst: true,
	        draggable: true,
	        swipe: true,
	        swipeToSlide: true,
	        autoplay: false,
	        touchThreshold: 14,
	        dots: false,
	        //autoplaySpeed : 3000
	    }).on('afterChange', function(event, slick, direction) {
	        $current.text(slick.slickCurrentSlide() + 1);
	    }).on('click', "a", function(e) {
	        e.stopPropagation();
	        var $this = $(this);
	        var src, product, label;
	        var model_no = $this.attr('model_no');
	        if ($this.parent().is(".trend_pick_img")) { // 키워드
	            product = $this.find('img').attr('alt');
	            label = model_no + "_" + product;
	        } else {
	            product = $this.find('strong').text();
	            label = model_no + "_관련상품_" + product;
	        }
	
	        ga('send', 'event', 'mf_home', 'trendPickup', label);

	        return true;
	    }).find('a').on('touchstart', function(e) {
	        if (window.android && android.onTouchStart) {
	            window.android.onTouchStart();
	        } else if ($("#ios").val()) {
				// do nothing..	
	        }
	    });
	
	
	
	    // 트랜드픽업의 다른 카테고리를 선택하면 해당 카테고리
	    // 데이터 및 커러셀  갱신 
	    $(".trd_nav  ul > li").on('click', function(e) {
	        var $this = $(this),
	            index = $this.index(),
	            html = "",
	            title = "";
	
	        e.preventDefault();
	        e.stopPropagation();

	        $current.text(1);
	        $(".trd_nav a.on").removeClass('on');
	        title = $this.find("a").addClass("on").text();
	        if (index == 0) {
	            html = trendList.all.join("\n");
	            $total.text(trendList.all.length);
	        } else if (index == 1) {
	            html = trendList.cate1.join("\n");
	            $total.text(trendList.cate1.length);
	        } else if (index == 2) {
	            html = trendList.cate2.join("\n");
	            $total.text(trendList.cate2.length);
	            scrollPosition = 30;
	        } else if (index == 3) {
	            html = trendList.cate3.join("\n");
	            $total.text(trendList.cate3.length);
	        } else if (index == 4) {
	            html = trendList.cate4.join("\n");
	            $total.text(trendList.cate4.length);
	        }
	
	        ga('send', 'event', 'mf_home', 'trendPickup_category', 'category_' + title );
	        	
	        // 선택 위치에 따른 scorll 위치 이동
	        $(".trd_scroll").scrollLeft(getScrollPostion(index));
	
	
	        $("#trendpick").slick('unslick').html(html).slick({
	            arrows: true,
	            infinite: true,
	            mobileFirst: true,
	            draggable: true,
	            swipe: true,
	            swipeToSlide: true,
	            autoplay: false,
	            touchThreshold: 14,
	            dots: false,
	            //autoplaySpeed : 3000
	        }).on('afterChange', function(event, slick, direction) {
	            $current.text(slick.slickCurrentSlide() + 1);
	        }).on('click', "a", function(e) {
	            e.stopPropagation();
	            var $this = $(this);
	            var src, product, label;
	            var model_no = $this.attr('model_no');
	
	            if ($this.parent().is(".trend_pick_img")) { // 키워드
	                product = $this.find('img').attr('alt');
	                label = model_no + "_" + product;
	            } else {
	                product = $this.find('strong').text();
	                label = model_no + "_관련상품_" + product;
	            }
	            ga('send', 'event', 'mf_home', 'trendPickup', label);
	            return true;

	        }).find('a').on('touchstart', function(e) {
	            if (window.android && android.onTouchStart) {
	                window.android.onTouchStart();
	            } else if ($("#ios").val()) {
	
	            }
	        });
	
	    });
	
	} catch (e) {
		// 에러시 트렌드 픽업 box 비노출 
	    $(".trendDiv").hide();
	}
	
	// 트렌드 픽업 메뉴 nav
	var $trendScroll = $(".trd_scroll");
	$(".trd_nav > button").on('click', function(e) {
	    var $this = $(e.target),
	        eq = $(".trd_nav a.on").parent("li").index();
	
	    if ($this.is(".trd_prev")) {
	        --eq;
	    } else {
	        ++eq;
	    }
	    // 이동시마다 스크롤 rolling 기능 
	    var count = Object.keys(trendList).length;
	    if (count <= eq) {
	        eq = 0;
	    } else if (eq <= -1) {
	        eq = count - 1;
	    }
	
	    // 선택 위치에 따른 scorll 위치 이동
	    $trendScroll.scrollLeft(getScrollPostion(eq));
	    $(".trd_nav  ul > li:eq(" + eq + ")").trigger('click');
	});
	
	// app에서 swipe 이벤트 막기 	
	$trendScroll.on('touchstart', function(e) {
	    if (window.android && android.onTouchStart) {
	        window.android.onTouchStart();
	    } else if ($("#ios").val()) {
	
	    }

    });

    $("body").on('touchend', function(e) {
        if (window.android && android.onTouchEnd) {
            window.android.onTouchEnd();
        } else if ($("#ios").val()) {

        }
    });
	
	
	/**
	 *	트랜드 픽업 탭 위치에 따른  scroll 값  
	 */
	function getScrollPostion(index) {
	    var scrollWidth = $(".trd_scroll").width(),
	        scrollPosition = 0;
	
		
		var windowWidth = $(window).width();
//	    if(scrollWidth > windowWidth){
//	    	return 0;
//	    }else if(windowWidth < 1400){
//	    	
//	    }else if(windowWidth < 1800){
//	    	
//	    }
		
		if(scrollWidth >= 420){
			return 0;
		}
	    
	    if (index == 2) {		// 영상가전 
	        scrollPosition = 30;
	    } else if (index == 3) {	// 가구, 리빙 
	    	scrollPosition = 440 - (scrollWidth + 45);
	    } else if (index == 4) {	// 유아 , 스포츠 
	    	scrollPosition = 440 - scrollWidth;
	    }
	
	    return scrollPosition;
	}
	
	
	/**
	 * 트렌드픽업 렌더링 처리
	 * @param  {[type]} list json array
	 * @param  {[boolean]} all  전체 여부 
	 * @return {[type]}      [description]
	 */
	function renderTrendPick(list, all) {
	    
	    var rendered = [], // 랜더링 html
	        template = $('#trendPickTemplate').html(),
	        cate = list[0].cate2,
	        count = 0,
	        $trendDiv;
	
	    Mustache.parse(template); // optional, speeds up future uses
	    $.each(list, function(i, json) {	
	        if (json.reg_date) {		// 날짜가 있다면  new 라벨 추가 
	            json.newTag = "<span class='new' >NEW</span>";
	        }
	        rendered.push(Mustache.render(template, json));
	    });
	
	    if (all) {
	        trendList.all = trendList.all.concat(rendered);
	    } else if (cate == '01') {
	        trendList.cate1 = trendList.cate1.concat(rendered);
	    } else if (cate == '02') {
	        trendList.cate2 = trendList.cate2.concat(rendered);
	    } else if (cate == '03') {
	        trendList.cate3 = trendList.cate3.concat(rendered);
	    } else if (cate == '04') {
	        trendList.cate4 = trendList.cate4.concat(rendered);
	    }
	
	}

	// 아이디값 추출 
    function extractId(src) {
        var n = src.lastIndexOf("/") + 1;
        var m = src.lastIndexOf(".");
        return src.substring(n, m); // 아이디값 
    }	
    
})();
//}