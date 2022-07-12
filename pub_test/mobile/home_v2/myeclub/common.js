$(function(){
    /**************************************** 
     * BOTTOMSHEET ON/OFF 
    ****************************************/
    var myeBottomSheet = $(".bottomsheet_wrap"), // 달력 바텀시트
        myeOpenBtn = $(".js-sheetOpen"), // 달력 열기
        myeCloseBtn = $(".js-sheetClose"); // 달력 닫기
    
    // OPEN BOTTOMSHEET
    myeOpenBtn.on("click", function(){
        var obj = $(this).data("obj"); // 바텀시트 내 타겟 (카테고리, 폴더)

        myeBottomSheet_open(obj);
    })
    // CLOSE BOTTOMSHEET
    myeCloseBtn.on("click", function(){
        myeBottomSheet_close();
    })

    // OPEN BOTTOMSHEET 함수 
    var myeBottomSheet_open = function(obj){
        var _target = obj; // 바텀시트 내 타겟 (카테고리, 폴더)

        if(_target != null){ // 타겟이 있으면 해당 타겟 컨텐츠 노출시킴.
            myeBottomSheet.addClass("bs-"+_target); // 상단 제목, 컨텐츠 노출
        }
        
        myeBottomSheet.css("z-index", "10000");
        $("body").css({"overflow":"hidden"});

        $('.sheet_cont').stop(0).animate({scrollTop: '0'}, 300);

        setTimeout(function(){
            myeBottomSheet.addClass("is-shown");
        }, 100);
    };
    // CLOSE BOTTOMSHEET 함수 
    var myeBottomSheet_close = function(){
        myeBottomSheet.removeClass("is-shown");
        $("body").css({"overflow":"visible"});

        setTimeout(function(){
            myeBottomSheet.css("z-index", "-1");
            myeBottomSheet.removeClass("bs-category bs-folder");
        }, 300);
    };

    
    /**************************************** 
     * 마이e클럽 탭/컨텐츠 ON/OFF 
    ****************************************/
    var myeTabsItem = $(".mye_tabs > ul > li");
    myeTabsItem.on("click", function(){
        var _idx = $(this).index();
        $(this).addClass("is-on").siblings().removeClass("is-on");

        $(".mye_cont").eq(_idx).show().siblings().hide();
        
        // 탭 클릭 위치 이동
        var liLeftPos = []; // LI 위치
        $.each(myeTabsItem, function(idx, item){
            liLeftPos[idx] = Math.floor($(item).offset().left); // LI 위치 추출
        })
        $(".mye_tabs > ul").stop().animate({scrollLeft: liLeftPos[_idx-1]}) // 활성화 탭 위치로 이동

        return false;
    })

    /**************************************** 
     * 하단 탭바 스크롤 액션 
    ****************************************/ 
	var lastScrollY = 0,
        bottomTabbar = $(".tabbar"); // 하단 탭바

    var scrAlarmPop = function(){
        var standard = 30;
        if(window.scrollY > standard){ 
            if(lastScrollY < window.scrollY){    // 스크롤 아래로
                bottomTabbar.addClass("is-hidden");
            }else{ 								// 스크롤 위로
                bottomTabbar.removeClass("is-hidden");
            }
        }
        lastScrollY = window.scrollY;
    }

    $(window).on({
        "scroll" : scrAlarmPop
    })
    

    /**************************************** 
     * 편집 시, 체크박스 ON/OFF
    ****************************************/ 
    var btnEdit = $(".list_controll .btn_edit"); // 버튼 : 편집
    var btnEditCancel = $(".list_controll .btn_cancel"); // 버튼 : 편집 취소
    var chkboxAll = $(".js-chkall"); // 버튼 : 전체선택 체크박스
    var chkboxBundle = $(".js-bundlechk"); // 버튼 : 일별 체크박스
    var goodsEditBox = $(".goods_edit"); // 영역 : 각 상품 편집 영역
    var goodsBundleChk = $(".goods_bundle .btn_chk"); // 영역 : 번들 단위 체크박스	
    
    // 편집모드 : ON (편집)
    btnEdit.on("click", function(){
        $(this).closest(".list_controll").addClass("is-edit");
        goodsEditBox.addClass("is-shown");

        // 최근 본 카테고리, 최근 검색어 스크롤 이동(문자열 앞으로)
        goodsEditBox.siblings(".breadcrumb_list").stop().animate({scrollLeft:0});
    })
    // 편집모드 : OFF (취소)
    btnEditCancel.on("click", function(){
        $(this).closest(".list_controll").removeClass("is-edit");
        goodsEditBox.removeClass("is-shown");
    })

    // 상품 선택 : 전체 체크 
    function checkAll(allchk, target) {
        var state = allchk.hasClass("is-chk");
        
        if(state) $(target).addClass("is-chk");
        else $(target).removeClass("is-chk")	
    }
    chkboxAll.on("click", function(){
        $(this).toggleClass("is-chk");
        checkAll($(this), goodsBundleChk);
    });

    // 상품 선택 : 번들 하위 개별 체크박스 ON/OFF
    goodsBundleChk.on("click", function(){
        var state = $(this).hasClass("is-chk");
        if(state){
            $(this).removeClass("is-chk");

            // 체크 개별 해제시 전체 체크 해제
            if(chkboxAll.hasClass("is-chk")){
                chkboxAll.removeClass("is-chk")
            }
            if(chkboxBundle.hasClass("is-chk")){
                chkboxBundle.removeClass("is-chk")
            }
        }else{
            $(this).addClass("is-chk");
        }
    })

    // 상품 선택 : 일별 체크박스 ON/OFF
    chkboxBundle.on("click", function(){
        var state = $(this).hasClass("is-chk");
        if(state){
            $(this).addClass("is-chk").closest(".goods_bundle").find(".btn_chk").addClass("is-chk")
        }else{
            $(this).removeClass("is-chk").closest(".goods_bundle").find(".btn_chk").removeClass("is-chk");
        }
    })

    /**************************************** 
     * 페이지공통 하단탭바 작동 / 스크롤업다운체크 (현원추가)
     * 각페이지별 알람여부알수없어 알람존재여부조건추가 _확인후 없으면 해당내용 제거
    ****************************************/ 
    var position = $(window).scrollTop(); 
	var $mainwrap = $("#wrap");
	var $footerTabbar = $(".f_tabbar"); 
	var $footerTabbarController = $(".f_btn_page_contorler"); 
	var posHeader = function(){
		var $myScroll = $(window).scrollTop();
		if ( $myScroll > 0 ){
            if($('.pop_alarm').length < 1) {
                $footerTabbarController.addClass('active');
            }
			if($myScroll > position) {
				$mainwrap.addClass("scr_down").removeClass("scr_reset scr_up");
				$footerTabbar.addClass("scr_down").removeClass("scr_reset scr_up");
			} else {
				$mainwrap.removeClass("scr_down scr_reset").addClass("scr_up");
				$footerTabbar.removeClass("scr_down scr_reset").addClass("scr_up");
			}
		}else{
			$mainwrap.removeClass('scr_down scr_up scr_reset')
            if($('.pop_alarm').length < 1) {
                $footerTabbarController.removeClass('active');
            }
		}
		position = $myScroll;
	};
	$(window).load(posHeader).scroll(posHeader);
})

// 상단이동
function totop() {
    $('html, body').stop().animate({scrollTop: '0'}, 400);
    return false;
}