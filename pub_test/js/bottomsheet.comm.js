(function(){
    "use strict";

    /*************************************************************** 
     ***** 퍼블 참고 *****
     * 바텀시트 관련 COMMON JS 
	 * 처음에 만든 패션 바텀시트와는 다름, 패션 파인더는 패션 카테에서만 사용함(finder.comm.js)
     * 이후 바텀시트 타입이 늘어날 때 이 파일이 기본이 됨.
     * 바텀시트 트리거 클래스 : 
     *  - Ex) bsTrigger = $(".bs-trigger")
     * 바텀시트 오픈 시, 오픈 버튼에 data-type에 따라 bsType 로 분기할 예정.
     *  - Ex) <button type="button" class="bs-trigger" data-type="parts_list">관련잉크토너 <em>99+</em></button>
    ***************************************************************/

     // 바텀시트에 필요한 변수 생성
	let bottomSheetWrap = $(".bottomsheet_wrap"), // 바텀시트 wrapper
		bottomSheet = bottomSheetWrap.find(".bottomsheet"), // 바텀시트 박스
		bsContent = bottomSheet.find(".bs_cont"), // 바텀시트 > 컨텐츠
		bsTrigger = $(".bs-trigger"), // 바텀시트 호출 클래스/컨텐츠타입 : class=bs-trigger, date-type=parts_list
		bsCloseBtn = $(".bottomsheet_wrap .dimmed, .bs_head_close"); // 바텀시트 숨김 버(dimmed, x)
	
	let widthArr = []; // 관련상품 가격 영역 너비 저장
	let widthMax = false; // 가격영역 최대너비
			
	// 바텀시트 열기 버튼
	bsTrigger.on("click", function(){ 
		let thisType = $(this).data("type");
		bottomSheetOpen(thisType); // 클릭시 바텀시트 타입별 인자 넘겨줌 (211209 현재는 관련소모품 "parts_list" 타입)
	});
	// 바텀시트 닫기 버튼
	bsCloseBtn.on("click", function(){ 
		bottomSheetClose();
	});

	// 함수 : 바텀시트 숨김
	let bottomSheetClose = function(){		
		bottomSheetWrap.removeClass("is-shown");    
		$("body").css({"overflow":"visible"});

		setTimeout(function(){
			bottomSheetWrap.css("z-index", "-1");
		}, 500)

		// 211222 : QA 과정에서 확장 형태 제거
		/* if(bottomSheet.hasClass("is-expand")){
			bottomSheet.removeClass("is-expand");
		} */
	}

    // 함수 : 바텀시트 노출 
	let bottomSheetOpen = function(bsType){
		let _bsType = bsType; // 바텀시트 타입 

		bottomSheetWrap.css("z-index", "100");
		$("body").css({"overflow":"hidden"});

		setTimeout(function(){
			bottomSheetWrap.addClass("is-shown");
		}, 100)

		// 타입별 JS 분기 
        // 관련잉크토너 확장 전 선행되어야 할 코드
        // 가격 자릿수에 따라 영역을 가변으로 적용해야 하여 선행되어야 합니다.
		if(_bsType === "parts_list"){
			let partItem = bsContent.find(".relateparts_box li");
			
			if(!widthMax){
				// 가격너비 저장
				$.each(partItem, function(i, obj){
					let priceWid = $(obj).find(".price").outerWidth()
					widthArr[i] = priceWid;
				})
			}
			
			widthMax = Math.max.apply(null, widthArr) // 가장 넓은 영역 
			 
			// 가격 영역 가장 넓은 너비로 통일
			$.each(partItem.find(".col_td.price"), function(i, val){
				$(this).css({width:widthMax});
			})
		}
	}

	// 211222 : QA 과정에서 확장 형태 제거
	// 바텀시트 컨텐츠 위로 스크롤 할 때 높이 확장
    /* var startY, endY;
    bsContent.on('touchstart',function(e){
        startY = e.originalEvent.changedTouches[0].screenY;
    });
    bsContent.on('touchend',function(e){
        endY = e.originalEvent.changedTouches[0].screenY;

        if(startY-endY>20){
            bottomSheet.addClass("is-expand"); // 확장 클래스 추가
        }
    }); */
})();