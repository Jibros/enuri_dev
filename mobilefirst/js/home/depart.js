/**
 * 백화점 관련 render
 */
(function() {
//function departLoad(){

    try {
        var depart = JSON.parse(gHomeJson.depart);
        // 백화점 렌더링	
        renderDepart(depart.departmentGoodsList, function() {
            // callback 
        });
    } catch (e) {
        $(".depart").hide();
        
    }

    /**
     * 백화점 렌더링 
     * @param  {[type]}   list     [description]
     * @param  {Function} callback [description]
     * @return {[type]}            [description]
     */
    function renderDepart(list, callback) {
        var totalCnt = 10, // 노출 총갯수 
            rendered = [],
            template = $('#departTemplate').html(),
            count = 0;
        // 가격 목록 
        subRendered = [],
            subTemplate = $('#departPriceTemplate').html(),
            $depart = $("#depart_list"),
            // 총갯수  샛팅
            $current = $("#departProdPage").find('span')
            .text(totalCnt / 2)
            .prev();

        Mustache.parse(template); // optional, speeds up future uses
        Mustache.parse(subTemplate);
        list = shuffle(list);

        // mall list var
        var prevDeptCode, arr, len;
        var liTag = "";
        for (var i = 0; i < list.length; i++) {

            if (list[i].brand.indexOf("&lt") > 0) {
                list[i].brand = list[i].brand.replace(/&lt;/gi, "<");
                list[i].brand = list[i].brand.replace(/&gt;/gi, ">");
            }
            // 모바일껀만 노출  
            if (list[i].mobile_yn != "Y" ||
                list[i].mallList.length < 2 ||
                !list[i].mobile_img) {
                continue;
            }

            if (count >= totalCnt) {
                break;
            }

            // 가격목록
            subRendered = [];
            arr = list[i].mallList;
            len = arr.length;
            prevDeptCode = null;
            for (var j = 0; j < len; j++) {
                // 중복 제거 처리 
                if (arr[j].dept_code != prevDeptCode) {
                    // 큰이미지로 노출
                    arr[j].dept_img = arr[j].dept_img.replace("_s.", ".");
                    subRendered.push(Mustache.render(subTemplate, arr[j]));
                    prevDeptCode = arr[j].dept_code;
                    // 2개까지만 노출 
                    if (subRendered.length >= 2) {
                        break;
                    }
                }


                // 최종까지 중복되었다면 그냥 
                // 두번째껄로 보여줌 
                if (len >= 2 && j == len - 1) {
                    subRendered.push(Mustache.render(subTemplate, arr[1]));
                }

            }

            list[i].departPriceTemplate = subRendered.join("");
            list[i].folder1 = list[i].modelno.substring(0, 3) + "00000";
            list[i].folder2 = list[i].modelno.substring(0, 4) + "0000";
            liTag += Mustache.render(template, list[i]);
            if (++count % 2 == 0) {
                $depart.append("<li>" + liTag + "</li>");
                
                liTag = "";
            }

        }



        // 최대 5개 노출이지만 5개보다 적을경우 카운트 다시 셋팅
        if (count / 2 < 5) {
            $("#departProdPage").find('span').text(Math.floor(count / 2));
        }

        // rolling        
        $depart.slick({
            arrows: true,
            infinite: true,
            mobileFirst: true,
            draggable: true,
            swipe: true,
            swipeToSlide: true,
            touchThreshold: 14,
            autoplay: false,
            dots: false,
        }).on('afterChange', function(event, slick, direction) {
            $current.text(slick.slickCurrentSlide() + 1);

        }).find('a').on('click', function(e) {

            var $this = $(this);
            var _modelno = $this.attr('href');
            _modelno = _modelno.substring(_modelno.indexOf("modelno=") + 8, _modelno.indexOf("&cate="));
            ga('send', 'event', 'mf_home', 'depart', 'Click_' + _modelno);

            window.location = $this.attr('href');

            return true;
        }).on('touchstart', function(e) {
            if (window.android && android.onTouchStart) {
                window.android.onTouchStart();
            } else if ($("#ios").val()) {

            }
        });

        callback();
    }

})();
//}
