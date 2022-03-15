        <header class="header">
            <!-- [C] 헤더 탑 -->
            <div class="header-top">
                <div class="header-top__inner cont__inner">
                    <!-- 헤더탑 탭 -->
                    <ul class="header-top__tab">
                        <li><a href="#">쇼핑지식</a></li>
                        <!-- 새로운 이슈가 있을때 .is--new 클래스 붙여주세요 -->
                        <li class="is--new"><a href="#">혜택존</a></li>
                        <li><a href="#">PICK</a></li>
                    </ul>
                    <!-- // 헤더 탭 -->
    
                    <!-- 헤더탑 메뉴 -->
                    <!-- .is--login : 로그인 상태 전용 -->
                    <!-- .is--logout : 로그아웃 상태 전용 -->
                    <!-- 더보기는 둘다 노출 -->
                    <ul class="header-top__menu">
                        <!-- 로그인 : 회원정보 -->
                        <li class="menu-user-info is--login">
                            <a href="#">
                                <!-- 아이콘 : 등급 -->
                                <i class="ico-grade ico-grade--sm ico-grade--vip">VIP</i>
                                <!-- <i class="ico-grade ico-grade--sm ico-grade--family">FAMILY</i> -->
                                <!-- <i class="ico-grade ico-grade--sm ico-grade--green">GREEN</i> -->
                                <!-- 유저 id/Nickname -->
                                <span class="user-info__name">
                                    <em>에누리관리자</em>님
                                </span>
                                <i class="ico-arr comm__sprite"></i>
                            </a>
                            <!-- 오버시 : 레이어 -->
                            <div class="header-top__lay user-info__lay">
                                <div class="header-top__lay--body">
                                    <!-- 아이콘 : 등급 -->
                                    <i class="ico-grade ico-grade--big ico-grade--vip">VIP</i>
                                    <!-- <i class="ico-grade ico-grade--big ico-grade--family">FAMILY</i> -->
                                    <!-- <i class="ico-grade ico-grade--big ico-grade--green">GREEN</i> -->
                                    <div class="user-info__lay__detail">
                                        <div class="user-info__lay__row">
                                            <a href="#" class="user-info--name">
                                                <em>WangKooN</em> 님
                                                <i class="ico-lock comm__sprite"></i>
                                            </a>
                                        </div>
                                        <div class="user-info__lay__row">
                                            <a href="#" class="user-info--emoney">
                                                <dl>
                                                    <dt>e머니</dt>
                                                    <dd><em>10,000</em></dd>
                                                </dl>
                                            </a>
                                            <a href="#" class="ico-store comm__sprite">쿠폰스토어</a>
                                        </div>
                                        <div class="user-info__lay__row">
                                            <a href="#" class="user-info--score">
                                                <dl>
                                                    <dt>활동점수</dt>
                                                    <dd><em>150</em></dd>
                                                </dl>
                                            </a>
                                            <a href="#" class="user-info--rank">
                                                <dl>
                                                    <dt>활동랭킹</dt>
                                                    <dd><em>-</em></dd>
                                                </dl>
                                            </a>
                                        </div>
                                        <!-- 버튼 : 로그아웃 -->
                                        <button class="user-info__btn--logout comm__sprite">로그아웃</button>
                                    </div>
                                </div>
                                <div class="header-top__lay--foot">
                                    <a href="#">MY에누리</a>
                                    <a href="#">최근본글</a>
                                    <a href="#">쇼핑Q&A</a>
                                    <a href="#">개인정보관리</a>
                                </div>
                            </div>
                            <!-- // -->
                        </li>
                        <!-- 로그인 : SDU/SDUL회원 전용 -->
                        <!-- <li class="is--login">
                            <a href="#">SDU(L)</a>
                        </li> -->
                        <!-- 로그인 : e머니 노출 -->
                        <li class="is--login">
                            <a href="#">e머니 <em class="menu__tx--emoney">127,120</em></a>
                        </li>
                        <!-- 로그인 : 쇼핑지식 활동점수 -->
                        <li class="is--login">
                            <a href="#">활동점수 <em class="menu__tx--act">0</em></a>
                        </li>
                        <!-- 로그아웃 : 로그인 버튼 -->
                        <li class="is--logout">
                            <a href="#"><i class="ico-login comm__sprite"></i> 로그인</a>
                        </li>
                        <!-- 로그아웃 : 회원가입 버튼 -->
                        <li class="is--logout">
                            <a href="#"><i class="ico-join comm__sprite"></i> 회원가입</a>
                        </li>                        
                        <!-- 로그아웃/인 공통 : 더보기 -->
                        <li class="menu-more">
                            <a href="#" onclick="return false;">더보기 <i class="ico-arr comm__sprite"></i></a>
                            <!-- 오버시 : 더보기 레이어 -->
                            <!-- template.html 참고 -->
                            <div class="header-top__lay sitemap__lay">
                                <div class="header-top__lay--body">
                                    <dl class="sitemap__group group--core">
                                        <dt>주요 서비스</dt>
                                        <dd>
                                            <ul class="sitemap__list">
                                                <li><a href="#">소셜비교</a></li>
                                                <li><a href="#">조립PC</a></li>
                                                <li><a href="#">해외직구</a></li>
                                                <li><a href="#">여행비교</a></li>
                                                <li><a href="#">자동차</a></li>
                                            </ul>
                                            <ul class="sitemap__list">
                                                <li><a href="#">쇼핑BEST</a></li>
                                                <li><a href="#">이사견적</a></li>
                                                <li><a href="#">꽃배달</a></li>
                                            </ul>
                                        </dd>
                                    </dl>
                                    <dl class="sitemap__group group--comm">
                                        <dt>커뮤니티</dt>
                                        <dd>
                                            <ul class="sitemap__list">
                                                <li><a href="#">쇼핑지식</a></li>
                                                <li><a href="#">뉴스</a></li>
                                                <li><a href="#">구매가이드</a></li>
                                                <li><a href="#">사용기</a></li>
                                                <li><a href="#">자유게시판</a></li>
                                            </ul>
                                            <ul class="sitemap__list">
                                                <li><a href="#">에누리TV</a></li>
                                                <li><a href="#">이벤트존</a></li>
                                                <li><a href="#">누리GO</a></li>
                                                <li><a href="#">쇼핑Q&amp;A</a></li>
                                                <li><a href="#">PICK</a></li>
                                            </ul>
                                        </dd>
                                    </dl>
                                </div>
                                <div class="header-top__lay--foot">
                                    <a href="#">에누리 서비스 전체보기 <i class="ico-arrr comm__sprite"></i></a>
                                </div>
                            </div>
                            <!-- // -->
                        </li>
                        <!-- // -->
                    </ul>
                </div>
            </div>
            <!-- [C] 헤더 -->
            <!-- 스크롤 되어 가려질때 .is--show 클래스가 붙습니다 -->
            <div class="header-core">
                <div class="header__inner">
                    <h1><a class="header-core__bi comm__sprite" href="/index.jsp">에누리 가격비교</a></h1>
                    <!-- 헤더 - 검색 -->
                    <!-- .is--focused : input 포커스됨 ( 광고문구 가림 / 하단 레이어 활성화 / 저장된 검색어 노출 ) -->
                    <!-- .is--active : input 값 입력됨 ( 광고문구 가림 / 연관검색어 노출 ) -->
                    <div class="header-sr">
                        <!-- 검색바 -->                        
                        <div class="header-sr__form">
                            <!-- 검색창 -->
                            <input type="text" class="header-sr__form__inp">
                            <!-- 광고문구 -->
                            <span class="header-sr__form__tx-ad">워라벨의 시작은 주방가전으로부터</span>
                            <!-- 아이콘 : 열림/닫힘 표시 -->
                            <i class="header-sr__ico-arr comm__sprite"></i>
                            <!-- 검색버튼 -->
                            <button type="text" class="header-sr__form__btn">
                                <i class="comm__sprite">검색</i>                                
                            </button>
                        </div>
                        <!-- 저장/연관검색어 -->
                        <!-- .header-sr__form__inp 의 value length가 1이상일때 활성화 -->
                        <div class="sr-related">                            
                            <!-- 리스트 : 최근검색어 -->
                            <div class="sr-related__list list--recent">
                                <!-- 검색어 저장 기능이 꺼져있음 -->
                                <div class="sr-related__tx--off">
                                    검색어 저장 기능이 꺼져 있습니다.
                                </div>
                                <!-- 최근 검색어 없음 -->
                                <div class="sr-related__tx--off">
                                    최근 검색어가 없습니다.
                                </div>
                                <!-- 검색어 리스트 -->
                                <!-- 최대 10개 까지 노출 -->
                                <ul>
                                    <!-- 타입 : 최근 검색어 -->
                                    <li class="sr-related__item">
                                        <a href="#" class="sr-related__tx-item">
                                            75인치 TV
                                        </a>
                                        <button class="sr-related__btn--del comm__sprite" onclick="alert('삭제');">삭제</button>
                                    </li>
                                </ul>
                            </div>
                            <!-- 리스트 : 연관검색어  -->
                            <div class="sr-related__list list--related">
                                <!-- 검색어 리스트 -->
                                <!-- 최대 10개 까지 노출 -->
                                <ul>
                                    <!-- 타입 : 자동완성 -->
                                    <li class="sr-related__item">
                                        <a href="#" class="sr-related__tx-item">
                                            <!-- 입력된 텍스트는 em으로 감싸주세요 -->
                                            <em>카</em>메라
                                        </a>                                        
                                    </li>
                                    <!-- // -->
                                    <!-- 타입 : 자동완성 (카테고리) -->
                                    <li class="sr-related__item item--cate">
                                        <a href="#" class="sr-related__tx-item">
                                            영상,디카 &gt; DSLR 디카
                                        </a>                                        
                                    </li>
                                    <!-- // -->
                                    <li class="sr-related__item">
                                        <a href="#" class="sr-related__tx-item">
                                            <em>카</em>페트
                                        </a>
                                    </li>
                                    <li class="sr-related__item">
                                        <a href="#" class="sr-related__tx-item">
                                            <em>카</em>시트
                                        </a>
                                    </li>
                                    <li class="sr-related__item">
                                        <a href="#" class="sr-related__tx-item">
                                            SD <em>카</em>드
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <!-- 배너 : 연관배너 -->
                            <div class="sr-related__bnr">
                                <a href="#"><img src="https://ad-cdn.enuri.info/20201127/6824_pc_%ED%99%88%EC%A2%8C%EB%82%A0%EA%B0%9C_130_260_03.jpg" alt=""></a>
                            </div>
                            <!-- 하단 툴 -->
                            <div class="sr-related__foot">
                                <button class="related__btn--save--off">검색어 저장 끄기</button>
                                <button class="related__btn--save--on">검색어 저장 켜기</button>
                                <button class="related__btn--lay--off">닫기</button>
                            </div>
                        </div>
                    </div>
                    <script>
                        // 검색창 관련 (퍼블테스트)
                        $(function(){
                            var $sr = $(".header-sr");
                            var $srInp = $(".header-sr__form__inp");
                            var $btnClose = $(".related__btn--lay--off");
                            var $dim = $(".container");
                            // 검색창이 focus 되어있을때 확장 레이어 노출
                            $srInp.on({
                                "focus": function(){
                                    var inpLen = $srInp.val().length;
                                    if ( !inpLen ){
                                        $sr.addClass("is--focused")
                                        $sr.removeClass("is--active");
                                        $dim.addClass("is--dim");
                                    }else{
                                        $sr.addClass('is--focused is--active');
                                        $dim.addClass("is--dim");
                                    }
                                },"keyup" : function(){
                                    var inpLen = $srInp.val().length;
                                    if ( !inpLen ){
                                        $sr.removeClass('is--active');
                                    }else{
                                        $sr.addClass('is--active');
                                        $dim.addClass("is--dim");                                        
                                    }
                                }
                            }); 
                            // 검색창 초기화 (닫기)
                            var resetSR = function(){
                                var inpLen = $srInp.val().length;
                                ( !inpLen ) ? $sr.removeClass('is--focused is--active') :$sr.removeClass('is--focused');
                                $dim.removeClass("is--dim");
                            }
                            // 검색창 외부를 클릭했을때 초기화
                            $('html').on('click',function(e){ 
                                var $t = $(e.target);
                                if( !$t.closest('.header-sr').length ){
                                    if ( !$srInp.is(":focus") ){
                                        resetSR();
                                    }
                                }
                            });
                            // 버튼 : 닫기
                            $btnClose.click(resetSR);
                        })
                    </script>
                    <!-- // 검색 -->

                    <!-- 헤더 - 카테고리 -->
                    <div class="header-cate">
                        <ul class="header-cate__list">
                            <li class="header-cate__item"><a href="#"><i class="ico-cate"><img src="//img.enuri.info/images/rev/@header-top-cate.png" alt=""></i> 가전/TV</a></li>
                            <li class="header-cate__item"><a href="#"><i class="ico-cate"><img src="//img.enuri.info/images/rev/@header-top-cate.png" alt=""></i> 태블릿</a></li>
                            <li class="header-cate__item"><a href="#"><i class="ico-cate"><img src="//img.enuri.info/images/rev/@header-top-cate.png" alt=""></i> 카메라</a></li>
                        </ul>
                        <!-- 버튼 : 전체카테고리 열기 -->
                        <button class="header-cate__btn--all" onclick="$('.lay-cate-all').removeClass('is--hide');">
                            <i class="ico-cate--all comm__sprite"></i> 전체카테고리
                        </button>
                    </div>
                    <!-- // -->

                    <!-- 헤더 - 우측광고 -->
                    <div class="header-ad">
                        <!-- 배너 -->
                        <a href="#"><img src="//img.enuri.info/images/rev/@header-ad__bnr.png" alt=""></a>
                        <!-- // -->                        
                        <button class="header-ad__btn header-ad__btn--prev comm__sprite">이전</button>
                        <button class="header-ad__btn header-ad__btn--next comm__sprite">다음</button>
                    </div>
                </div>
            </div>
        </header>        