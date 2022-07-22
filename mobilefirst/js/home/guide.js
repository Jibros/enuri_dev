/**
 * 쇼핑 가이드 
 */
(function() {
//function guideLoad(){
    
    try {
        var list = gHomeJson.guide;
        var verand = getCookie('verand');
        if (verand && verand < '3.0.0') { // 3.0 이하면 더보기 숨김 
            $("#newsMore").hide();
        }

        // 쇼핑 가이드 랜더링         
        renderGuide(list, function() {
            $(".guide a.morebtn").on('click', function() {
                var link = $(this).attr("href");
                var verios = getCookie('verios');
                if (verand) {
                    link += "&freetoken=main_tab|3";
                }

                window.location.href = link;
                ga('send', 'event', 'mf_home', 'more', 'more_가이드더보기');
                return false;
            });

        });
    } catch (e) {
        // 오류가 있을시 쇼핑 가이드 비노출 
        $(".guide").hide();
    }


    /**
     * 렌더링 처리
     * @param  {[type]}   list     [쇼핑가이드 랜더링 ]
     * @param  {Function} callback [콜백함수]
     * @return {[type]}            [description]
     */
    function renderGuide(list, callback) {
        var render = [],
            guideMainTemplate = $('#guide_main_template').html(),
            guideTemplate = $('#guide_template').html();

        for (var i = 0; i < list.length; i++) {
            if (i == 0) {
                $(".cam_tip").append(Mustache.render(guideMainTemplate, list[i]));
            } else {
                render.push("<li>");
                render.push(Mustache.render(guideTemplate, list[i]));
                render.push("</li>");
            }
        }

        $("ul.buy_tip").append(render.join(""));

        callback();
    }

})();
//}
