$(function(){
    /********************************************************
     * 상세 레이어 토글
     ********************************************************/
    // variable
    var _body = $("body"),
        _layer = $(".layer"),
        _layerDimmed = "<div class=\"layer_dimmed\"></div>"
        receiptTarget = $("[data-receipt]"); // 접수번호 클릭 영역

    // 조회 > 접수번호 클릭
    receiptTarget.on("click", function(){
        var _number = this.dataset.receipt; // 접수번호
        
        // 레이어 오픈
        layerShown(_number)
    })

    // 레이어 SHOW FUNC
    function layerShown(num){
        var data = num; // 인자 : 데이터 호출 아무렇게나 해주십숑 

        _body.css({  // body 스크롤 잠금
            "overflow":"hidden", 
            "padding-right":"17px"
        })
        .append(_layerDimmed)
        .ready(function(){
            var dimmEl = $(".layer_dimmed")

            dimmEl.addClass("fade show") // dimmed 노출

            _layer.css({"display":"block"}) // 레이어 노출

            /////////////////////
            // 이 부분에서 데이터 넣어주심 될거에요. 
            /////////////////////

            setTimeout(function(){
                _layer.addClass("show") // 레이어 모션(위에서 아래로 스르륵)
            },200)
        });

        // 레이어 HIDE
        _layer.on("click", function(e){
            layerHidden(e)
        })
    }

    // 레이어 HIDE FUNC
    function layerHidden(e){
        var $t = $(e.target);
        var $carea = $t.closest('.layer_cont'); // 클릭 제외

        var exCloseBtn = $($carea.context).hasClass("js-hideLayer") // 닫기 버튼 클릭 포함

        // 딤 & 닫기버튼 클릭 시 HIDE
        if( !$carea.length || exCloseBtn) hideAction()

        function hideAction(){
            _layer.removeClass("show") // 레이어 모션(아래에서 위로 스르륵 사라짐)

            setTimeout(function(){
                _layer.scrollTop(0) // 레이어 스크롤 상단 이동
                _layer.css({"display":"none"}) // 레이어 숨김
                
                _body.removeAttr("style") // body 스크롤 노출
                
                /////////////////////
                // 이 부분에서 데이터 제거해 주세요.
                /////////////////////

                var dimmEl = $(".layer_dimmed")

                // dimmed 제거
                dimmEl.removeClass("show") 
                setTimeout(function(){
                    dimmEl.removeClass("fade")
                    dimmEl.detach();
                }, 200)
            },200)
        }
    }


    /********************************************************
     * 페이지 내 셀렉트 옵션 
     ********************************************************/
    $(".lay_option li").on("click", function(){
        var _this = $(this),
            _val = _this.text(),
            _data = _this.data("value"),
            _layer = $(this).closest(".lay_option"),
            _label = _layer.siblings(".tx_value"),
            _writeIpt = _this.closest(".box_sr_sort").siblings(".view_write").find(".inp_search");

        // toggle
        _this.addClass("selected").siblings().removeClass("selected");
        
        // value in label
        if(_data === 0){
            _label.text(_val).removeClass("on");
        }else{
            _label.text(_val).addClass("on");
        }

        // 직접입력 선택
        if(_data === "write"){
            _writeIpt.removeAttr("disabled").focus();
        }else{
            _writeIpt.attr("disabled", true);
        }
        // value index
        console.log(_data);
    })


    /********************************************************
     * 엑셀 다운로드 레이어 토글
     ********************************************************/
    var layExcel = $(".lay_excel")
        passInp = layExcel.find(".inp"),

    $(".js-excelDownload").on("click", function(){
        toggleExcel();
    })

    function toggleExcel(){
        if(layExcel.is(":visible")){
            layExcel.hide();
        }else{
            layExcel.show();
        }
    }

    layExcel.find(".btn_grey").on("click", function(){
        layExcel.hide();
    })
    layExcel.find(".btn_blue").on("click", function(){
        var passVal = passInp.val(); //value
        
        if(!passVal || passVal === null){// 입력 체크
            alert("비밀번호를 입력해주세요");
            passInp.focus();
        }else{ 
            // 비번 체크/다운로드해주세요.

            // 틀린 비번
            alert("틀린 비밀번호입니다.\n다시 입력해주세요.")
            passInp.focus().val('');
        }
    })
})

