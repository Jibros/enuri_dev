/**
 * 쇼셜모아 
 */
function socialLoad() {
    
    try {
        // 핫딜 렌더링 
        renderSocial(function() {
            // callback
            $(".deal_nav > ul > li").on('click', function() {
                var $this = $(this),
                    index = $this.index(),
                    title = $this.find('a').text();

                ga('send', 'event', 'mf_home', 'social', 'social_' + title);

                $(".deal_nav a.on").removeClass('on');
                $this.find("a").addClass("on");
                $(".deal_list").hide()
                    .eq(index).show()
                    .scroll()
                    .siblings("ul")
                    .hide();
            });
        });
    } catch (e) {
        // 에러시 쇼설모아 비노출 
        $(".deal_list, .morebtn_deal, .dealtit").hide();
    }
    
    /**
     * 소셜모아 렌더링 처리
     * @param  {[type]}   list     [ 소셜모아 json]
     * @param  {Function} callback [description]
     */
    function renderSocial(callback) {
        var rendered = [], // 랜더링 html
            subMenuTemplate = $('#hotDealTemplate').html(), //  소분탬플릿
            width = $(window).width();

        Mustache.parse(subMenuTemplate); // optional, speeds up future uses
    
        var list = [
            gDealJson.home.list.DS_COUPON,
            gDealJson.shopping.list.DS_COUPON,
            gDealJson.local.list.DS_COUPON,
            gDealJson.trip.list.DS_COUPON,
            gDealJson.culture.list.DS_COUPON
        ];

        $.each(list, function(i, cate) {
            rendered = [];
            $.each(cate, function(k, json) {
                if (json.cpSalerate) {        // 할인율이 있으면 노출 없으면 특가로 
                    json.cpSalerate = "<span class=\"sale\">" + json.cpSalerate + "<em>%</em></span>";
                } else {
                    json.cpSalerate = "<span class=\"special\">특가</span>";
                }

                if (!json.cpPrice || json.cpPrice == json.cpSaleprice) {
                    json.classNm = "sp";
                    json.cpPrice = "특가";
                } else {
                    json.classNm = "pr01";
                    json.cpPrice = commaNum(json.cpPrice) + "<em>원</em>";
                }

                // 통화 단위 append
                json.cpSaleprice = commaNum(json.cpSaleprice);
                rendered.push(Mustache.render(subMenuTemplate, json));

            });

            // 동적이미지로드 적용 
            $(".deal_list:eq(" + i + ")").append(rendered.join(""))
                .on('click', "a", function() {
                    // 아이폰 앱일경우 파라미터 추가
                    ga('send', 'event', 'mf_home', 'social', 'Click_goods');
                    if ($("#ios").val() && $("#app").val() == "Y") {
                        location.href = $(this).attr('href') + "&enuriCore=Y";
                        return false;
                    }

                });

        });

        // 쇼설모아는 탭 구성이기 때문에 
        // 레이지 로드가 정상적으로 작동이 안됨 
        // 따라서 1초후 이미지 자동로드 적용시킴 
        $("img.lazy").lazyload({
            event: "sporty"
        });
        var timeout = setTimeout(function() {
            $("img.lazy").trigger("sporty")
        }, 1000);

        callback();

    }



}
