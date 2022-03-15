
<div id="pop_alarm" class="pop_alarm">
    <div class="alarm__inner">
        <div class="alarm__head">
            <p class="tx_tit">알림함</p>

            <div class="msg_line">
                <p class="tx_msg">안 읽은 메시지 <span class="tx_num">2건</span></p>
            </div>

            <button type="button" class="btn btn-close" onclick="$(this).closest('.pop_alarm').fadeOut();">닫기</button>
        </div>
        <div class="alarm__body">
            <div class="recent_box">
                <div class="recent_unit">
                    <p class="tx_cate">최저가 득템</p>
                </div>

                <div class="recent_msg">
                    <button type="button" class="btn btn-msg">
                        <span class="tx_desc">50% 급하락한 최저가 득템 상품이 급하락 최저가 득템 상품이...</span>
                    </button>
                </div>
            </div>                        
        </div>
    </div>
</div>

<div id="alarmsheet" class="lay-alarmsheet">
    <div class="dimmed"></div>
    <div class="alarmsheet__inner">
        <div class="alarmsheet__head">
            <div class="head_box">
                <p class="tx_tit"><em>MY</em>알림함</p>

                <button type="button" class="btn btn-close" onclick="$(this).closest('.pop_alarm').fadeOut();">닫기</button>
            </div>

            <div class="head_tabs">
                <div class="alarmtabs swiper-container">
                    <div class="swiper-wrapper"></div>
                </div>
            </div>
        </div>

        <div class="alarmsheet__body">
            <div class="card_box">
                <!-- ※ 알림없을때 -->
                <div class="card_item no-data">
                    <p class="tx_noti">받은 알림이 없습니다</p>
                </div>
            </div>
        </div>
    </div>
</div>
<script defer type="text/javascript" src="/wide/include/js/IncAlarm.js?v=20211007"></script>
