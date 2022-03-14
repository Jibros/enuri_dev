(function($) {
    $(function() {
        var sel_data_toggle = $("[data-toggle]");
        var g_fold_menu = $('.global-fold-menu > div');
        var g_left_area = $('.global-column-left');
        var g_right_area = $('.global-column-right');

        // 이건 수정하면서 쓸모없어진기능. 일단 주석처리
        // function toggleGMToggle(idx) {
        //     var target = idx.data('target');
        //     idx.toggleClass('on');
        //     $(target).toggleClass('fold');
        // }

        function toggleSlide(idx) {
            // 해당엘리먼트 작동
            idx.siblings().removeClass('active');
            idx.toggleClass('active');

            // 해당엘리먼트의 타켓에 적용
            var target = idx.data('target');
            $(target).siblings().removeClass('active');
            $(target).toggleClass('active');

            // 해당엘리먼트의 클래스값에따라 왼쪽 메뉴들 열고닫기
            if(idx.hasClass('active')) {
                g_left_area.removeClass('fold');
                g_right_area.removeClass('extend');
            } else {
                g_left_area.addClass('fold');
                g_right_area.addClass('extend');
            }
        }

        // 상단 카테고리분석,찜상품분석시 닫힘
        function toggleSlideClose() {
            sel_data_toggle.removeClass('active');
            g_fold_menu.removeClass('active');
            g_left_area.addClass('fold');
            g_right_area.addClass('extend');
        }

        // 카테고리 클릭시 아코디언형태로 열/닫
        function toggleAccordion(idx) {
            idx.toggleClass('open');
            idx.next().slideToggle(200);
        }

        // 클릭한대상 active 클래스
        function toggleClass(idx) {
            idx.toggleClass('active');
        }

        // 데이타 토글 이벤트명에 따라 작동
        sel_data_toggle.on("click", function(){
            var evt_nm = $(this).data('toggle')
            if(evt_nm === 'globalMnFold') {
                toggleGMToggle($(this));
            }
            if(evt_nm === 'slide') {
                toggleSlide($(this));
            }
            if(evt_nm === 'slide-close') {
                toggleSlideClose();
            }
            if(evt_nm === 'accordion') {
                toggleAccordion($(this));
            }
        });

        // datepicker
        $.datepicker.setDefaults({
            dateFormat: 'y.mm.dd',
            prevText: '이전 달',
            nextText: '다음 달',
            monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            dayNames: ['일', '월', '화', '수', '목', '금', '토'],
            dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
            dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
            showMonthAfterYear: true,
            yearSuffix: '년'
        });
        var now = new Date();
        var year = now.getFullYear().toString();
        var month = now.getMonth() + 1;    //1월이 0으로 되기때문에 +1을 함.
        var date = now.getDate();

        month = month >=10 ? month : "0" + month;
        date  = date  >= 10 ? date : "0" + date;

        // 당일날짜 ex) yy.mm.dd
        var today = year.substring(2, 4) +"."+ month +"."+ date;

        $(".type-date").val(today);
        $(".type-date").datepicker();


        function openModar(target,width) {
            $(target).dialog({
                dialogClass:"innerPopup",
                modal: true,
                width: width,
                show: 'fade',
                // hide: 'fade',
                open: function () {
                    // var subtitle = $(".ui-dialog-subtitle").html();
                    // $("[aria-describedby=all-category] .ui-dialog-title").append(subtitle);

                    // 이외영역클릭시 닫기
                    $(".ui-widget-overlay, .common-dialog .btn-cancel").on('click', function(e){
                        e.preventDefault();
                        $(".ui-dialog-titlebar-close").trigger('click');
                    });
                }
            });
        }

        $("[data-dialog]").on('click', function(e){
            var dialog_nm = $(this).data('dialog');
            var dialog_w = $(this).data('dialogwidth');
            if ($(this).hasClass("btn-compare-prod")) {
                if($(".table-mcss input[type=checkbox]:checked").length > 5) {
                    alert("최대 5개 모델 선택 가능합니다.");
                } else {
                    openModar(dialog_nm, dialog_w);
                }
            } else if($(this).hasClass("btn-modify-zzim-folder")) {
                var checked_fold = $(".zzim-folder-list input[type=checkbox]:checked");
                var checked_fold_cnt = checked_fold.length;
                var checked_fold_name = checked_fold.nextAll(".text").text();

                if(checked_fold_cnt === 1) {
                    openModar(dialog_nm, dialog_w); // 찜선택 개별
                    $(dialog_nm).find(".selected_folder_nm").html("<strong>"+ checked_fold_name +"</strong>");
                } else {
                    alert("반드시 한개의 폴더를 선택해 주세요.");
                }
            } else if($(this).hasClass("btn-select-multi")){
                var chk_count = $(".table-mcss input[type=checkbox]:checked").length; // 체크개수
                $(dialog_nm).find(".selected_prod_nm").html("<strong>"+ chk_count +"</strong>개 상품");
                if(chk_count>0) {
                    openModar(dialog_nm, dialog_w); // 찜선택 멀티
                } else {
                    alert("리스트를 체크해주세요.");
                }
            } else if($(this).hasClass("btn-select-one")) {
                if(!$(this).hasClass("active")) {
                    var prod_nm = $(this).closest("tr").find(".prod-nm").text(); // 찜선택모델명
                    $(dialog_nm).find(".selected_prod_nm").html("<strong>\""+ prod_nm +"\"</strong> 상품");
                    openModar(dialog_nm, dialog_w); // 찜선택 개별
                }
                toggleClass($(this));
            } else {
                openModar(dialog_nm, dialog_w); // 일반
            }
        });

        // 전체선택시 전체체크 ,내용물중체크해제시 자동해제되지는않음..
        function checkAll(idx, target) {
            var chk = idx.is(':checked');
            if(chk) {
                $(target).prop('checked', true);
                // top100제외된상품 체크안되게
                $('.table-default .except input').prop('checked', false);
            } else {
                $(target).prop('checked', false);
            }
        }
        // 전체선택시 전체체크 같이쓰임.
        $('.checkAll-list').on('click', function(){
            var target_nm = $(this).attr('name')
            checkAll($(this), "."+ target_nm +" input");
        });

        // 선택상품 찜 삭제버튼클릭시 리스트제거
        $(".btn-delete-prod").on("click", function(){
            var chked_list = $('.tab_content div.active tbody tr td input:checked');
            var chked_count = chked_list.length;
            if(chked_count > 0) {
                var result = confirm('선택된 리스트를 삭제하시겠습니까?');
                if(result) {
                    alert('선택된 리스트가 삭제되었습니다.');
                } else {

                }
            } else {
                alert('리스트를 1개 이상 선택해주세요.');
            }
        });

        var form_search_category = $(".form-static-category");
        var form_search_zzim = $(".form-static-zzim");
        $('button[type=submit]', form_search_category).on('click', function(e){
            if(!$('input[name=mall_name]:checked') || $('input[name=mall_name]:checked').length == 0) {
                alert('쇼핑몰명 검색 후 선택해주세요.');
                $('input[name=mall_name_input]').focus();
                return false;
            }
        });

        // 추가된 js
        // (탭기능) 스와이퍼 리스트클릭시 해당 리스트 출력
        $('#result_list .swiper-slide').on('click',function(e){
            // e.preventDefault();
            var tabname = $(this).data("tabname");

            $(this).addClass("active").siblings().removeClass("active");
            $(tabname).addClass("active").siblings().removeClass("active");
            // 전체선택시 전체 탭 출력 - 전체선택기능 제거로 주석처리
            // if(tabname === '#alltab') {
            //     $('.result_list_tab_content > div').addClass('active');
            // } else {
            //
            // }
        });

        // 데이터 리스트에서 이미지 마우스오버시 확대
        $('.table-mcss .thumbnail-img').on('mouseenter', function(){
           var imgurl = $(this).css('background-image').replace(/\"/gi, '');
           $(this).parent().append(' <div class="thumbnail-img-popup" style="background-image:'+ imgurl +';"></div>')
        });
        $('.table-mcss .thumbnail-img').on('mouseout', function(){
            $(this).next().remove();
        });

    });
})(jQuery);

// 추가됨
function stopAction(e) {
    e.preventDefault();
}