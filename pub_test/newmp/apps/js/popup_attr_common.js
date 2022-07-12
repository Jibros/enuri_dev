// Hex코드만 입력 가능
var keyToHex = (obj) =>{
    var iptObj = obj;
    // a~f, 0~9 만 입력
    $(iptObj).on("input", function(e){
        if(!(e.keyCode >= 37 && e.keyCode <= 40)){
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^A-Fa-f0-9]/g,''));
        }else{
            $(this).val("a~f, 0~9 만 입력 가능합니다");
        }
    })
}

// LP색상코드 입력
var colorCodeInput = () => {
    var iptObj = $(".ipt-color"), // 컬러 INPUT
        btnColorInput = $("#btnColorInput"); // 입력 버튼

    keyToHex(iptObj); // 키보드 제어

    btnColorInput.on("click", function(){
        var colorList = $(".color_input > li"), // 컬러 ROW
            colorOne = [], // 첫번째 열 컬러값 저장
            colorTwo = [], // 두번째 열 컬러값 저장
            inputOne = $(".js-oneipt"), // 첫번째 열 인풋
            inputTwo = $(".js-twoipt"), // 두번째 열 인풋
            colorVisible = ".color_visible";
        
        // 초기화 
        $(colorVisible).find("i").remove();

        $.each(inputOne, function(i, item){
            chkPushColor(item, colorOne);
        });
        $.each(inputTwo, function(i, item){
            chkPushColor(item, colorTwo);
        });

        $.each(colorList, function(i, item){
            if(colorOne[i] == false || colorTwo[i] == false){
                $(this).find(colorVisible).removeClass("is-half");
                if(colorOne[i] == false){
                    $(this).find(colorVisible).append("<i style=\"background:#"+colorTwo[i]+"\"></i>");
                }else{
                    $(this).find(colorVisible).append("<i style=\"background:#"+colorOne[i]+"\"></i>");
                }
                
            }else{
                var colorTag = `<i style="background:#${colorOne[i]}"></i><i style="background:#${colorTwo[i]}"></i>`;
                $(this).find(colorVisible).addClass("is-half").append(colorTag);
            }
        });

        // 컬러 값 배열 push
        function chkPushColor(item, arr){
            var iptItem = item, // 인풋
                iptVal = iptItem.value, // 인풋 값
                itemLength = iptItem.value.length; // 인풋 값 길이
                                    
            if(itemLength < 6){ // 6 자리 이하일 때 초기화
                iptItem.value = ''; 
                arr.push(false);
            }else{ // 정상 코드만 push
                arr.push(iptVal);
            }
        }
    })
}

// 범위 옵션 선택
var rangeOption = () => {
    var rangeIpt = $(".inc-text .ipt-text[type=text]"); // 범위 입력 인풋
    var dataArr = ["0.01kg", "0.02kg", "0.03kg", "0.04kg", "0.05kg", "0.06kg", "0.07kg", "0.08kg", "0.09kg", "0.10kg"]; // 임의의 자동검색 데이터

    // 인풋 변화 감지
    rangeIpt.on("input", function(e){
        var value = $(this).val(); // 입력 값
        var parent = $(this).closest(".form-chk"); // 부모 태그
        var childSelect = $(this).siblings(".lay-auto"); // 자동 검색 레이어

        childSelect.find("span").remove();
        if(value){
            parent.children(".input--checkbox-item").prop({"checked": true}); // 입력 값이 있을 때 체크박스 체크
            if(true){
                // 입력한 내용에 자동 검색 레이어 노출 후 해당 값 자동완성어가 있을 때 하단 선택 영역 노출시켜주세요
                var selHtml = ''; 
                $.each(dataArr, function(i, v){
                    selHtml += "<span data-value=\"\">" + dataArr[i] + "</span>";
                });
                childSelect.append(selHtml).show(); // 레이어 노출

                // 옵션 선택
                childSelect.find("span").on("click", function(){
                    selectToLabel(this);
                })
            }                                                
        }else{
            parent.children(".input--checkbox-item").prop({"checked": false}); // 입력 값이 없을 때 체크박스 체크 해제
            childSelect.hide(); // 레이어 숨김
        }
    })

    // 선택된 옵션값을 라벨에 복사 후 레이어 숨김
    function selectToLabel(e){
        var $label = $(e).closest(".form-chk").find(".ipt-text[type=text]");
        $label.val( $(e).text() );
        $(".inc-text .lay-auto").hide();
    }
}

$(function(){
    // INIT : LP색상코드 입력
    colorCodeInput(); 
    // INIT : 범위 옵션 입력
    rangeOption();
})
