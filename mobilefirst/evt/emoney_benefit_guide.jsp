    <!-- layer2--> 
    <div class="layer_back" id="app_only2" style="display:none;">
        <div class="appLayer">
            <h4>모바일 앱 전용 쇼핑혜택</h4>
            <a href="javascript:///" class="close" onclick="onoff('app_only2')">창닫기</a>
            <p class="txt">에누리앱(APP) 설치 후<br />e머니 적립내역 확인 및<br />다양한 e쿠폰 상품으로 교환할 수 있습니다.</p>
            <p class="btn_close"><button type="button" onclick="install_btt();">설치하기</button></p>
        </div>
    </div>
     <!-- 생활혜택 -->
    <div class="benefit">
		<!-- 170608 이미지 변경 -->
		<h2><img src="http://imgenuri.enuri.gscdn.com/images/event/2017/template/edeal_t3_v2.gif" alt="50% 더! 커진 e머니 e머니 생활혜택"  width="149" height="48" /></h2>       
        <script>
        $(document).ready(function(){
            $('.emy_exp').slick({
                dots: false,
                infinite: true,
                speed: 200,
                slidesToShow: 1,
                adaptiveHeight: true,
                autoplay: true,
                autoplaySpeed: 2000
            });
        });
        </script>
        

        <div class="bene_zone">
            <ul class="emy_exp">
                <li>
					<img src="http://imgenuri.enuri.gscdn.com/images/event/2017/template/slide_benf1_v3.png" alt="앱에서 구매하면 1.5% 자동적립" /><!-- 170608 이미지 변경 -->
                    <a href="javascript:///" onclick="goEmoney(1);"><span>적립내역 보기</span></a>
                </li>
                <li>
                    <img src="http://imgenuri.enuri.gscdn.com/images/event/2017/template/slide_benf2.png" alt="이벤트로 매일 수시로 추가적립" />
                    <a href="javascript:///"onclick="goEmoney(2);"><span>이벤트 보기</span></a>
                </li>
                <li>
                    <img src="http://imgenuri.enuri.gscdn.com/images/event/2017/template/slide_benf3.png" alt="언제든 자유롭게 e머니로 쿠폰교환" />
                    <a href="javascript:///"onclick="goEmoney(3);"><span>스토어 가기</span></a>
                </li>
                <li>
                    <img src="http://imgenuri.enuri.gscdn.com/images/event/2017/template/slide_benf4.png" alt="마음대로 누리는 생활혜택" />
                    <a href="javascript:///"onclick="goEmoney(4);"><span>쿠폰함 가기</span></a>
                </li>
            </ul>
        </div>
    </div>
    <!--// 생활혜택 -->
    