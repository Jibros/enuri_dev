/**
 * 최신 뉴스 render
 */
(function() {

    try {
        var news = JSON.parse(gHomeJson.news);
        renderNews(news, function() {
            // callback
        });
    } catch (e) {
        // 에러시 뉴스 비노출 
        $(".news_area").hide();
    }

    /**
     * [최신뉴스 랜더링]
     * @param  {[type]}   news     [뉴스json]
     * @param  {Function} callback [콜백함수]
     * @return {[type]}            [description]
     */
    function renderNews(news, callback) {
        var rendered = [], // 랜더링 html
            imgNewsTemplate = $('#img_news_template').html(),
            noImgNewsTemplate = $('#no_img_news_template').html(),

            imgNewsHtml = Mustache.render(imgNewsTemplate, news),
            noImgNewsHtml = Mustache.render(noImgNewsTemplate, news);

        $(".top_news_box > ul").append(imgNewsHtml)
            .on('click', 'a', function() {
                var link = $(this).attr('href');
                var kb_no = $(this).attr('kb_no');

                ga('send', 'event', 'mf_home', 'today_news', 'img_' + kb_no);
                window.open(link);
                return false;
            });

        $(".news_list").append(noImgNewsHtml)
            .on('click', 'a', function() {
                var link = $(this).attr('href');
                var kb_no = $(this).attr('kb_no');

                ga('send', 'event', 'mf_home', 'today_news', 'text_' + kb_no);
                window.open(link);
                return false;
            });

        // 안드로이드 3.0.0 버전 이하일때는 최신 뉴스 더보기 숨김
        var verand = getCookie('verand');
        if (verand && verand < '3.0.0') {
            $("#newsMore").hide();
        } else {
            $("#newsMore").on('click', function() {
                var link = $(this).attr("href");
                var verios = getCookie('verios');
                if (verand) {
                    link += "?freetoken=main_tab|3";
                }

                window.location.href = link;
                ga('send', 'event', 'mf_home', 'more', 'more_최신뉴스더보기');
                return false;
            });
        }


        callback();
    }


})();
