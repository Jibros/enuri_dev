<!-- [레이어] 전체 카테고리 -->
        <div class="lay-cate-all is--hide">
            <div class="lay-cate-all__inner">
                <div class="lay-cate-all__head">
                    전체 카테고리
                    <!-- 버튼 : 닫기 -->
                    <button class="lay-cate-all__btn" onclick="$('.lay-cate-all').addClass('is--hide');"><i class="ico-cls--big">닫기</i></button>
                    <!-- // -->
                </div>
                <!-- [레이어] > 전체 카테고리 커스텀 -->
                <!-- 홈메인 > 전체 카테고리 와 마크업 동일합니다. -->
                <!-- template.html 참고 -->
                <div class="cate-all">
                    <!-- 카테고리 리스트 -->
                    <ul class="cate--depth1">
                        <!-- [반복] Depth1 -->
                        <li class="cate-item--depth1 is--on">
                            <p class="cate__tit">가전TV</p>
                            <!-- 우측 확장메뉴 -->
                            <div class="cate-item__expend">
                                <ul class="cate--depth2"  id="first_depth0"></ul>
                            </div>
                            <!-- // -->
                        </li>
                        <!-- // 대대카테고리 -->
                        <li class="cate-item--depth1">
                            <p class="cate__tit">컴퓨터/노트북/조립PC</p>
                            <!-- 우측 확장메뉴 -->
                            <div class="cate-item__expend">
                                <ul class="cate--depth2" id="first_depth1"></ul>
                            </div>
                            <!-- // -->
                        </li>
                        <li class="cate-item--depth1">
                            <p class="cate__tit">태블릿/모바일/디카</p>
                            <div class="cate-item__expend">
                                <ul class="cate--depth2"  id="first_depth2" ></ul>
                            </div>
                        </li>
                        <li class="cate-item--depth1">
                            <p class="cate__tit">스포츠/자동차/공구</p>
                            <div class="cate-item__expend">
                                <ul class="cate--depth2"  id="first_depth3" ></ul>
                            </div>
                        </li>
                        <li class="cate-item--depth1">
                            <p class="cate__tit">가구/유아동</p>
                            <div class="cate-item__expend">
                                <ul class="cate--depth2" id="first_depth4"></ul>
                            </div>
                        </li>
                        <li class="cate-item--depth1">
                            <p class="cate__tit">식품/건강</p>
                            <div class="cate-item__expend">
                                <ul class="cate--depth2" id="first_depth5"></ul>
                            </div>
                        </li>
                        <li class="cate-item--depth1">
                            <p class="cate__tit">생활/주방/반려</p>
                            <div class="cate-item__expend">
                                <ul class="cate--depth2" id="first_depth6" ></ul>
                            </div>
                        </li>
                        <li class="cate-item--depth1">
                            <p class="cate__tit">명품/패션/화장품</p>
                            <div class="cate-item__expend">
                                <ul class="cate--depth2" id="first_depth7" ></ul>
                            </div>
                        </li>
                    </ul>
                </div>
                <!-- // -->                
            </div>
            <div class="lay-cate-all__dim" onclick="$('.lay-cate-all').addClass('is--hide');"></div>
        </div>
        <!-- // -->
 <script>
    $(function(){ // 헤더 > 카테고리 퍼블 테스트용
        var $depth1 = $(".cate-all .cate-item--depth1");
        var delayTimer;
        var delayTime = 100;
        $depth1.on({
            "mouseenter" : function(){
                var $t = $(this);
                delayTimer = setTimeout(function(){
                    $t.addClass("is--on").siblings().removeClass("is--on");
                },delayTime)
            },"mouseleave" : function(){
                clearTimeout(delayTimer);
            }
        })
    })
</script>
<!-- // -->