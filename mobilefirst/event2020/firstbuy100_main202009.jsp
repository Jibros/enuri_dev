<% String pd = ChkNull.chkStr(request.getParameter("pd")); %>
<!-- 이벤트01 -->
	<div id="evt1" class="section evt_1st scroll">
		<div class="contents">
            <h2><img src="http://img.enuri.info/images/event/2020/buy_first/sep/m_deallist_tit.png" alt="APP 전용, 첫구매하고 페이백 신청하면 e머니 9,900점!"></h2>
			<ul class="deal_list"></ul>
			<!-- 페이백 신청하기 -->
			<!-- <a href="#" onclick="onoff('app_only');return false;" class="btn_payback">페이백 신청하기</a> -->
			<a href="javascript:///" id="firstbuyClk" class="btn_payback">페이백 신청하기</a>
			<!-- // -->
			
			<div class="event_noti">
		        <div class="noti_cnt">
		            <ul>
		                <li class="stress">※ ID(본인인증), 첫 구매, 페이백 신청 모두 동일한 모바일 기기에서 진행할 경우에만 참여 가능합니다.</li>
		                <li class="stress">※ 100원딜 상품 외에도 모바일 앱에서 1만원 이상 구매 시 참여 가능합니다.</li>
		                <li class="stress">※ 본 이벤트는 모바일 앱에서만 참여 가능합니다.</li>
		                <li class="stress">※ 친구초대 이벤트 혜택과 중복 참여 불가합니다.</li>
		            </ul>
		        </div>
		    </div>
	    </div>
		<div class="com__evt_notice">
			<div class="evt_notice--btn_area"><button class="btn__evt_notice" data-laypop-id="slidePop1"><span>꼭! 확인하세요</span></button></div> <!-- 열기 : 유의사항 열기 -->
		</div>
		<div id="slidePop1" class="evt_notice--slide" style="display: none;">
			<div class="evt_notice--inner"> <!-- .wide - 넓은 케이스 -->
				<div class="evt_notice--head">유의사항</div>
				<div class="evt_notice--cont">
					<div class="evt_notice--continner">
						<dl>								
							<dt>이벤트 대상 및 혜택</dt>
							<dd>
								<ul>
									<li>이벤트 대상 : 에누리 가격비교 모바일 앱에서 구매이력 없는 고객 (※ 100원딜 상품 또는 1만원 이상 첫 구매 후 첫구매 페이백 이벤트 신청한 고객)</li>
									<li>이벤트 기간 : 첫 구매일로부터 30일 이내 </li>
									<li>이벤트 혜택 : e머니 9,900점</li>
									<li>혜택 지급일 : 구매일로부터 최대 30일 이내 적립 (※ 해외직구 상품 구매 시 최대 70일 소요)</li>
									<li>
										<span class="stress">e머니 유효기간 : 적립일로부터 30일 (유효기간 만료 후 재적립 불가)</span><br>
										※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.
									</li>
								</ul>
							</dd>
						</dl>

						<dl>
							<dt>이벤트 참여방법 및 유의사항</dt>
							<dd>
								<ul>
									<li>참여방법 : 에누리 가격비교 모바일 앱 로그인 → <span class="stress">본 이벤트 페이지 내 100원딜 상품 첫 구매</span> →&nbsp;첫구매 페이백 이벤트 신청<br>
										<span class="stress">※ 100원딜 상품 외에도 모바일 앱 로그인 후 적립대상 쇼핑몰 이동하여 1만원 이상 첫 구매 시 신청 가능합니다.</span>
									</li>
									<li>적립대상 쇼핑몰 : G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, Cjmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 에누리 해외직구관, SK스토아, 홈플러스<br>
										<span class="stress">※ 구매 유의사항 및 구매적립 제외 카테고리는 이벤트 페이지 하단 'e머니 구매혜택' 유의사항을 꼭 확인하세요!</span>
									</li>
									<li>인터파크 상품권의 경우 100원딜 상품만 이벤트 대상이며, 그 외 e머니 적립 제외 카테고리 상품으로 이벤트 대상에서 제외됩니다.</li>
									<li>본 이벤트는 ID당 1회 참여 가능합니다.  </li>
									<li>본 이벤트는 ID와 구매한 기기 모두 첫 구매일 경우에만 참여 가능합니다. (※ 구매한 기기에 구매이력 있으면 참여 불가)</li>
									<li>본 이벤트는 본인인증 및 이벤트 정보 활용 동의 후 참여 가능합니다.</li>
									<li class="stress">본 이벤트는 모바일 앱에서만 참여가 가능한 모바일 앱전용 프로모션 입니다.</li>
									<li class="stress">본 이벤트는 ID(본인인증), 첫 구매, 페이백 신청을 모두 동일한 모바일 기기에서 진행한 경우에만 혜택 지급 가능합니다.</li>
									<li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다.</li>
									<li>
										<span class="stress">이벤트 대상 제외 :</span> 아래의 경우에는 이벤트 대상 및 혜택 지급에서 제외됩니다. <br>
										<ul class="sub">
											<li>- 첫구매 페이백 이벤트 신청하지 않은 경우</li>
											<li>- 실제 구매금액이 1만원 미만의 구매일 경우</li>
											<li>- 구매적립 제외 카테고리 구매일 경우 (※ 페이백 신청일로부터 30일 이내 재구매 시 혜택 지급 가능)</li>
											<li>- 구매 후 취소/환불/교환/반품한 경우 (※ 페이백 신청일로부터 30일 이내 재구매 시 혜택 지급 가능)</li>
											<li>- 동일한 본인인증으로 가입한 다수의 ID로 중복 참여한 경우</li>
											<li class="stress">- 친구초대 첫구매 혜택 받은 고객 (중복 지급 불가)</li>
										</ul>
									</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>공통 이벤트 유의사항</dt>
							<dd>
								<ul>
									<li>부정 참여 시 본 이벤트 대상 제외 및 혜택 지급이 취소될 수 있습니다.</li>
									<li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
								</ul>
							</dd>
						</dl>
					</div>
				</div>
				<div class="evt_notice--foot">						
					<button class="btn__evt_confirm">확인</button> <!-- 닫기 : 레이어 닫기 -->
				</div>
			</div>
		</div>
	</div>
	
	<div class="com_event_benefit">
        <div class="com_event__inner">
            <h3 class="blind">에누리에서 구매하고 현금같은 e머니 적립 받으세요!</h3>
            <div class="com_benefit_slide swiper-container swiper-container-horizontal">
                <div class="swiper-wrapper" style="transform: translate3d(-610px, 0px, 0px); transition-duration: 0ms;"><div class="swiper-slide swiper-slide-duplicate swiper-slide-prev" data-swiper-slide-index="3" style="width: 610px;">
                        <img src="http://img.enuri.info/images/event/2020/common/m_com_evt_ben_slide_04.png" alt="STEP4. e쿠폰 스토어에서 1,000여가지의 인기 e쿠폰으로 교환가능!">
                    </div>
                    <div class="swiper-slide swiper-slide-active" data-swiper-slide-index="0" style="width: 610px;">
                        <img src="http://img.enuri.info/images/event/2020/common/m_com_evt_ben_slide_01.png" alt="STEP1. 에누리 앱에서 로그인 후 적립대상 쇼핑몰 이동하기">
                    </div>
                    <div class="swiper-slide swiper-slide-next" data-swiper-slide-index="1" style="width: 610px;">
                        <img src="http://img.enuri.info/images/event/2020/common/m_com_evt_ben_slide_02.png" alt="STEP2. 상품 구매하기">
                    </div>
                    <div class="swiper-slide" data-swiper-slide-index="2" style="width: 610px;">
                        <img src="http://img.enuri.info/images/event/2020/common/m_com_evt_ben_slide_03.png" alt="STEP3. 구매금액의 최대 1.5% E머니 적립!">
                    </div>
                    <div class="swiper-slide swiper-slide-duplicate-prev" data-swiper-slide-index="3" style="width: 610px;">
                        <img src="http://img.enuri.info/images/event/2020/common/m_com_evt_ben_slide_04.png" alt="STEP4. e쿠폰 스토어에서 1,000여가지의 인기 e쿠폰으로 교환가능!">
                    </div>
                <div class="swiper-slide swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="0" style="width: 610px;">
                        <img src="http://img.enuri.info/images/event/2020/common/m_com_evt_ben_slide_01.png" alt="STEP1. 에누리 앱에서 로그인 후 적립대상 쇼핑몰 이동하기">
                    </div></div>
                <div class="swiper-button-prev btn_prev"></div>
                <div class="swiper-button-next btn_prev"></div>
            </div>
            <div class="swiper-pagination swiper-pagination-clickable swiper-pagination-bullets"><span class="swiper-pagination-bullet swiper-pagination-bullet-active"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span></div>
            <!-- 200207 : 유의사항 버튼  수정-->
            <a href="#appinfo" class="btn_com_benefit_noti btn__evt_notice" data-laypop-id="appinfo">유의사항</a>	
            <!-- // -->
        </div>
        <script>
            $(function(){
                var mySwiper = new Swiper('.com_benefit_slide',{
                    prevButton : '.com_event_benefit .swiper-button-prev',
                    nextButton : '.com_event_benefit .swiper-button-next',
                    pagination : '.com_event_benefit .swiper-pagination',
                    speed : 1000,
                    loop : true,
                    paginationClickable : true
                })
            })
        </script>
    </div>
    <div id="appinfo" class="evt_notice--slide">
        <div class="evt_notice--inner">
            <div class="evt_notice--head">유의사항</div>
            <div class="evt_notice--cont">
                <div class="evt_notice--continner">
                    <dl>
                        <dt>e머니 구매적립 기준 및 유의사항</dt>
                        <dd>
                            <ul>
                                <li>적립 방법 : 에누리 가격비교 모바일 앱 로그인 → 적립대상 쇼핑몰 이동 → <span class="stress">1천원 이상 구매</span> → 구매확정(배송완료) 시 e머니 적립</li>
                                <li>적립대상 쇼핑몰: G마켓, 옥션, 11번가, 인터파크, 티몬, 위메프, 쿠팡, GS SHOP, CJmall, SSG (신세계몰, 신세계백화점, 이마트몰, 트레이더스), 에누리 해외직구관, SK스토아, 홈플러스<br>
                                    <span class="stress">※ 티몬 및 에누리 해외직구관의 경우 PC 및 모바일 앱/웹에서 로그인 후 구매시에도 구매적립 가능합니다.</span>
                                </li>
                                <li>구매적립 e머니는 구매일로부터 10 ~ 30일간 취소/환불/교환/반품여부 확인 후 적립 됩니다.</li>
                                <li><span class="stress">구매적립 e머니 유효기간 : 적립일로부터 60일 (유효기간 만료 후 재적립 불가)</span><br>
                                    ※ 적립된 e머니는 e쿠폰 스토어에서 다양한 쿠폰으로 교환가능합니다.
                                </li>
                                <li>구매적립 e머니는 최소 10점(구매금액 1천원 이상)부터 적립되며, 1원 단위 e머니는 적립되지 않습니다.</li>
                                <li>구매적립 e머니는 구매확정(구매일로부터 최대 30일) 시점부터 MY 에누리 적립내역 페이지에서 확인 가능합니다.</li>
                                <li>구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 금액만 반영됩니다. </li>
                                <li>적립대상 쇼핑몰에서 장바구니에 여러 상품을 담아 한 번에 결제하는 경우 구매건수는 1건이며 구매금액은 통합된 금액으로 e머니 적립 됩니다.</li>
                                <li>구매적립 e머니는 카테고리별 차등 적립됩니다. <br>
                                    <u>※ 카테고리별 적립률</u>
                                    <table class="evt_noti_tb" style="width:300px;">
                                        <colgroup>
                                            <col width="70%"><col width="30%">
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th>카테고리</th>
                                                <th>적립률</th>
                                            </tr>
                                            <tr>
                                                <td>유아,완구</td>
                                                <td>1.5%</td>
                                            </tr>
                                            <tr>
                                                <td>식품/스포츠,레저/자동차/화장품</td>
                                                <td>1.0%</td>
                                            </tr>
                                            <tr>
                                                <td>컴퓨터/도서/문구,사무/PC부품</td>
                                                <td>0.8%</td>
                                            </tr>
                                            <tr>
                                                <td>디지털/영상,디카</td>
                                                <td rowspan="4">0.3%</td>
                                            </tr>
                                            <tr>
                                                <td>가전(생활,주방,계절)</td>
                                            </tr>
                                            <tr>
                                                <td>패션/잡화</td>
                                            </tr>
                                            <tr>
                                                <td>가구,인테리어</td>
                                            </tr>
                                            <tr>
                                                <td>생활,취미</td>
                                                <td rowspan="2">0.2%</td>
                                            </tr>
                                            <tr>
                                                <td>모바일쿠폰,상품권<br>
                                                    <p class="stress">*특정 상품에 한하여 적립되오니<br>적립가능 상품은 하단에서 확인해주세요.</p>
                                                </td>													
                                            </tr>
                                        </tbody>
                                    </table>
                                </li>
                            </ul>
                        </dd>
                    </dl>
                    <dl>
                        <dt class="stress">[모바일쿠폰,상품권] 구매적립 기준</dt>
                        <dd>
                            <ul>
                                <li>적립가능 쇼핑몰 : 티몬, G마켓, 옥션</li>
                                <li>적립가능 상품 (0.2% 적립) : 문화상품권(해피머니, 컬쳐랜드), 도서상품권, 백화점상품권, 영화예매권, 국민관광 상품권</li>
                                <li>백화점상품권 기준 상세 
                                    <ul class="sub">
                                        <li>1) 상품명에 '백화점 상품권' 명시된 상품 또는 백화점에서만 사용할 수 있는 상품권만 적립가능</li>
                                        <li>2) 복합상품권 적립불가 (삼성 상품권, 신세계 기프트카드, 롯데카드 상품권, 이랜드 상품권, AK플라자 상품권, 통합 상품권 등)<br>
                                            <span class="indent">- 복합 상품권의 경우 사용처에 백화점이 기재되어 있는 경우에도 적립불가</span>
                                        </li>
                                        <li>3) 백화점 상품권으로 전환 가능한 포인트 구매 시 적립불가</li>
                                    </ul>
                                </li>
                            </ul>
                        </dd>
                    </dl>							
                    <dl>
                        <dt>적립대상 쇼핑몰 중 구매적립 제외 카테고리 및 서비스</dt>
                        <dd>
                            <ul>
                                <li>에누리 가격비교에서 검색되지 않는 상품</li>
                                <li>모바일쿠폰,상품권 : 상품권, 지역쿠폰, e교환권, e쿠폰 등</li>
                                <li>쇼핑몰 제휴 서비스(배달, 티켓, 해외직구 등) 및 일부 카테고리
                                    <ul class="sub">
                                        <li>- G마켓 : 중고장터, 실시간 여행, 항공권, 도서/음반, 모바일쿠폰/상품권(일부 적립가능)</li>
                                        <li>- 옥션 : 중고장터, 실시간 여행, 항공권, 모바일쿠폰/상품권(일부 적립가능)</li>
                                        <li>- 11번가 : 여행/숙박/항공, 모바일쿠폰/상품권</li>
                                        <li>- 인터파크 : 라이프 서비스(티켓, 투어, 아이마켓 등), 모바일쿠폰/상품권(100원딜 상품만 적립가능)</li>
                                        <li>- 티몬 : 특가 판매 상품(슈퍼꿀딜, 슈퍼마트 등), 모바일쿠폰/상품권(일부 적립가능)</li>
                                        <li>- 위메프 : 모바일쿠폰/상품권</li>
                                        <li>- GS SHOP, CJmall : 모바일쿠폰/상품권</li>
                                        <li>- SSG : 도서/음반/문구/취미/여행, 모바일쿠폰/상품권</li>
                                    </ul>
                                </li>
                            </ul>
                        </dd>
                    </dl>
                    <dl>
                        <dt>공통 이벤트 유의사항</dt>
                        <dd>
                            <ul>
                                <li>아래의 경우에는 구매 확인 및 구매적립이 불가합니다.
                                    <ul class="sub">
                                        <li>- 에누리 가격비교 모바일 앱이 아닌 다른 모바일 앱을 통해서 장바구니 또는 관심상품 등록 후 에누리 가격비교 모바일 앱으로 결제만 한 경우</li>
                                        <li>- 에누리 가격비교 미 로그인 후 구매한 경우</li>
                                        <li>- 에누리 가격비교 PC 및 모바일 웹에서 구매한 경우 (※ 티몬 및 에누리 해외직구관은 PC 및 모바일 앱/웹 구매 시에도 가능)</li>
                                    </ul>
                                </li>
                            </ul>
                        </dd>
                    </dl>
                </div>
            </div>
            <!-- // -->
            <div class="evt_notice--foot">						
                <button class="btn__evt_confirm">확인</button> <!-- 닫기 : 유의사항 닫기 -->
            </div>
        </div>
    </div>
	

	
<!-- layer--> 
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 이벤트</h4>
		<a href="javascript:///" class="close" onclick="$('#app_only').hide();">창닫기</a>
		<p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
		<p class="btn_close"><button type="button">설치하기</button></p>
	</div>
</div>


<div class="layer_back" id="myInvitedetail" style="display:none">
	<div class="agree_layer">
		<div class="inner">
			<div class="txt_tit">개인정보 수집 및 이용동의</div>			
			<div class="txt_cnt">
				<div class="agree_tit">
					본인인증 정보는 이벤트 종료 시까지<br/>
					저장하며 이벤트 종료 후 파기됩니다.
				</div>
				<div class="agree_txt">
					<label><input type="checkbox" class="chkbox" id="">이벤트 참여를 위한 개인정보 활용에 동의합니다.</label>
					<a href="" onclick="onoff('pop_agree_noti');return false;" class="btn_view_detail">자세히보기&gt;</a>
				</div>
			</div>			
			<p class="btn_apply"><button type="button" id="couponIns">응모완료 &gt;</button></p>
		</div>
		<!-- 닫기 -->
		<a href="javascript:///" onclick="onoff('myInvitedetail');return false;" class="btn_close">닫기</a>
		<!-- // 닫기 -->
	</div>
</div>
<!-- 개인정보 수집 이용안내 레이어 -->
<div class="layer_back" id="pop_agree_noti" style="display:none">
	<div class="agree_noti_layer">
		<div class="inner">
			<div class="txt_tit">개인정보 수집 &middot; 이용안내</div>
			<div class="txt_cnt">
				<strong>에누리 가격비교는 이벤트 참여확인을 위하여 <br/>아래와 같이 개인 정보를 수집하고 있습니다.</strong><br/>
				<dl>
					<dt>1. 개인정보 수집 항목</dt>
					<dd>- 휴대폰번호, 참여일시, 참여자ID, 본인인증확인(CI,DI)</dd>
					<dt>2. 개인정보 수집 목적</dt>
					<dd>- 이벤트를 위해 수집된 개인정보는 이벤트 참여확인을 위한 본인확인 이외의 목적으로 활용되지 않습니다.</dd>
					<dt>3. 개인정보 보유 및 이용기간</dt>
					<dd>- 개인정보 수집자 (에누리 가격비교)는 이벤트 기간 동안 개인정보를 수집하며, 이벤트가 종료되면 개인정보를 즉시 파기합니다.</dd>
				</dl>
			</div>
			<p class="btn_close"><button type="button" onclick="onoff('pop_agree_noti');">닫기</button></p>
		</div>
	</div>
</div>
<!-- // -->

<!-- 페이백 신청완료 -->
<div class="layer_back" id="pop_payback" style="display:none">
	<div class="payback_noti_layer">
		<div class="inner">
			<div class="txt_tit blind">페이백 신청 완료!</div>
			<div class="txt_cnt blind">첫 구매일로부터 최대<em>다음날 e머니 9,900점 적립됩니다.</em></div>
			<span class="blind">자세한 내용은 참여방법을 확인해 주세요!</span>
			<p class="btn_close"><button type="button" onclick="onoff('pop_payback');">닫기</button></p>
		</div>
	</div>
</div>
<!-- // -->

<script>
// 공통 : 상단 탭 고정
(function (global, $) {
    var $nav = $('.navtab'); // 탭
	var $myarea = $('.myarea');
    $(window).scroll(function () {
        var scroll = $(window).scrollTop();     
        if (scroll > $nav.offset().top) {
            $nav.addClass("is-fixed")
			$myarea.addClass("f-nav");
        }else{
            $nav.removeClass("is-fixed")
			$myarea.removeClass("f-nav");
        }
    });	
}(window, window.jQuery));
// 공통 : 유의사항 레이어 열기/닫기
$(function(){
	var el = {
		btnSlide: $(".btn__evt_notice"), // 열기 버튼
		btnSlideClose : $(".btn__evt_confirm") // 닫기 버튼
	}
	el.btnSlide.click(function(){ // 슬라이드 유의사항 열기
		$(this).toggleClass('on');
		$("#"+$(this).attr("data-laypop-id")).slideToggle();
	})
	el.btnSlideClose.click(function(){ // 슬라이드 유의사항 닫기
		var thisClosest = $(this).closest('.evt_notice--slide')
		$(thisClosest).slideToggle();
		$('html,body').stop(0).animate({scrollTop:$(thisClosest).siblings(".com__evt_notice").offset().top - 50});
	})
})

// 공통 :  하단 컨텐츠로 바로 진입시 포지션 보정을 위한 스크립트 처리
$(function(){
	if(window.location.hash) {
		var $hash = $("#"+window.location.hash.substring(1));
		var navH = $(".navtab").outerHeight();
		if ( $hash.length ){
			$("html,body").stop(true,false).animate({"scrollTop": $hash.offset().top - navH},"slow");
		}
	}
})

/* 퍼블테스트 : 레이어 열고 닫기*/
function onoff(id){
	var mid = $("#"+id);
	if(mid.css("display") !== "none"){
		mid.css("display","none");
	}else{
		mid.css("display","");
	}
}


(function() {
	
	var isClick = true;
	var point = 9900; //지급포인트
	var chkPrice =10000; //구매값
	
	getEvtGoods(); 
	getPowerReward();
	
	//첫구매 버튼클릭
	$("#firstbuyClk").click(function(e){
		
		//alert("chkid:"+vChkId);
		point = commaNum(point);
		chkPrice = commaNum(chkPrice);

		welcomeGa("evt_firstbuy100_click");
		
		//첫구매변수
		if(getCookie("appYN") == 'Y'){
			ga('send', 'event', 'mf_event', vEvent_title ,  '페이백 신청하기');
		}else{
			onoff('app_only'); 
			
			if(gkind == "42"){
				ga('send','event', 'mf_event','첫구매이벤트_버튼클릭','SA 42 M_Naver');
			}else if(gkind == "43"){
				ga('send','event', 'mf_event','첫구매이벤트_버튼클릭','SA 43 M_Daum');
			}else if(gkind == "44"){
				ga('send','event', 'mf_event','첫구매이벤트_버튼클릭','SA 44 M_google');
			}else if(gkind=="72"){
				ga('send','event', 'mf_event','첫구매이벤트_버튼클릭','DA 72 M_icover');	
			}else if(gkind=="71" && gno == "3100367"){
				ga('send','event', 'mf_event','첫구매이벤트_버튼클릭','망고_첫구매CU');
			}else if(gkind=="75" && gno == "3120469"){
				ga('send','event', 'mf_event','첫구매이벤트_버튼클릭','버즈빌_첫구매CU');
			}else if(gkind=="74" && gno == "3120470"){
				ga('send','event', 'mf_event','첫구매이벤트_버튼클릭','페이스북_첫구매CU');
			}else if(gkind=="76" && gno == "3139542"){
				ga('send','event', 'mf_event','첫구매이벤트_버튼클릭','애드립_첫구매CU');
			}else{
				ga('send', 'event','mf_event', vEvent_title ,'신청하기');
			}
			return false;
		}
		if(!islogin()){
			if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
				location.href = "/mobilefirst/login/login.jsp";
			}else if(navigator.userAgent.indexOf("Android") > -1){
				location.href = "/mobilefirst/login/login.jsp?backUrl=/mobilefirst/evt/firstbuy100_event.jsp?freetoken=event&chk_id="+vChkId;
			}
			return false;
		}
		
		if(!isClick){
			return false;
		}
		isClick = false;
	
		$.ajax({
			type: "POST",
			url: "/mobilefirst/evt/ajax/ajax_firstbuychk.jsp",
			async: false,
			data: { chkid: vChkId, procCode: 1 },
			dataType:"JSON",
			success: function(json){
				var result = json.result;
				if ( result== -77 ) {
					alert("이미 첫구매 혜택을 받았습니다.");
				}else if (result==-22) {//이전 첫구매 신청자
					//alert("아쉽지만\n첫구매 대상자가 아닙니다. (" + result + ")");
					alert("아쉽지만\n첫구매 대상자가 아닙니다. ");
				
				}else if (result==1) {//100원딜 신청자
					alert("이미 신청하셨습니다.");
					
				} else if(result==-5){
					alert("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
					location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
						
				} else if(result==6) {
					alert("구매 후 신청하세요.");
						
				} else if(result==-1 || result>5) {
					//alert("아쉽네요^^;\n첫구매 대상자가 아닙니다. (" + result + ")" );
					alert("아쉽네요^^;\n첫구매 대상자가 아닙니다." );
				} else if(result==-2) {
					var isFriend = confirm("초대코드가 있습니다.\n초대 첫구매 혜택 신청해주세요.");
					if(isFriend){
					 goFriendPurchase();
					}
				}  else if(result==3) {
					alert("구매해주셔서 감사합니다.\n아쉽게도 첫구매액이 "+chkPrice+"원 미만이면 혜택을 받을 수 없습니다.");
				} else if(result==4 || result == 5) {
					welcomeGa("myInvitedetail");
					onoff('myInvitedetail');
				} else if(result==-99) {
					alert("휴대폰번호 본인인증 후\n 참여할 수 있습니다.");
						
						var pd = "<%=pd%>";
						
						if(getCookie("appYN") == "Y"){
							window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&app=Y&freetoken=login_title&pd="+pd);
						}else{
							window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&freetoken=login_title");	
						}
					return false;
				} else if(result==-98) {
					alert("이미 첫구매 혜택을 받았습니다.");
				} else {
					alert("아쉽네요^^;\n첫구매 대상자가 아닙니다." ); //0
				}
				
			}, complete : function() {	isClick=true;	}
		});
	});
	$("#couponIns").click(function(e){
		
		if(!$(".chkbox").prop("checked")){
			alert("정보 수집 동의 후 신청하세요!");
			return false;
		}
		if(!isClick){
			return false;
		}
		isClick = false;
		
		welcomeGa("evt_firstbuy100_complete");
		
		$.ajax({
			type: "POST",
			url: "/mobilefirst/evt/ajax/ajax_firstbuychk.jsp",
			async: false,
			data: { chkid: vChkId, procCode: 2 },
			dataType:"JSON",
			success: function(json){
				var result = json.result;
				
				if (result==1) {
					alert("이미 신청하셨습니다.\n구매일로부터 약 10일 후(최대 30일)\nmy>적립내역에서 적립받기 클릭해주세요.\n구매적립 다음날 적립됩니다.");
				} else if(result==-1 || result>5) {
					//alert("아쉽네요^^;\n첫구매 대상자가 아닙니다.(" + result + ")" );
					alert("아쉽네요^^;\n첫구매 대상자가 아닙니다." );
				} else if(result==-2) {
					//var isFriend = confirm("초대코드가 있습니다.\n초대 첫구매 혜택 신청해주세요.");
					//if(isFriend){
					 alert("초대코드가 있습니다.\n초대 첫구매 혜택 신청해주세요.");
					 goFriendPurchase();
					//}
				} else if(result==2) {
					alert("구매 후 적립 신청하세요.");
				} else if(result==3) {
					alert("구매해주셔서 감사합니다.\n아쉽게도 첫구매액이 "+chkPrice+"원 미만이면 혜택을 받을 수 없습니다.");
				} else if(result==4) {
					//welcomeGa("evt_welcome_combo1_complete");		
					//alert("참여완료!\n구매일로부터 약 10일 후(최대 30일)\nmy>적립내역에서 적립받기 클릭해주세요.\n구매적립 다음날 적립됩니다.");
					onoff('pop_payback');
				} else if(result==5) {
					welcomeGa("evt_welcome_combo1_complete");
					alert("축하드립니다!!\n첫 구매혜택 e머니 "+point+"점이 지급되었습니다.");
					getPoint();
				} else if(result==-99) {
		            alert("휴대폰번호 본인인증 후\n 참여할 수 있습니다.");
		    		location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&freetoken=login_title";
	    		
				} else if(result==-5){
						//var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
						//if(r){
							alert("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
							location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
						//}
				} else {
					//alert("아쉽네요^^;\n첫구매 대상자가 아닙니다.(" + result + ")" );
					alert("아쉽네요^^;\n첫구매 대상자가 아닙니다." );
				}
				
			}, complete : function() {
				isClick=true;
				onoff('myInvitedetail');
			}
		});
	});
	function getEvtGoods(){
		
		$.ajax({
			type: "POST",
			url: "/event/ajax/evt_100deal_goods_ajax.jsp?p=list",
			async: false,
			dataType:"JSON",
			success: function(json){
				
				$.each(json.data,function(i,v){
					
					var html = "";
					
					html += "<li data-id='"+v.gd_lnk_url+"' data-soldout='"+v.so_yn+"' data-gnm='"+v.evnt_gd_nm+"' >";
					
					if(v.so_yn == "Y"){
						html +=	"<span class=\"ico_soldout\">Soldout</span>";	
					}
					
					html +=	"<span class=\"deal_item\">";
					html +=		"<img src='<%="http://storage.enuri.gscdn.com"%>/Web_Storage"+v.gd_img_url+"' alt=''>";
					
					html +=	"</span>";
					html +=	"<a href=\"javascript:///\" class=\"btn_deal\">구매하기</a>";
					html += "</li>";
					
					$(".deal_list").append(html);
					
				});
				$(".deal_list > li").click(function(){
					
					if(getCookie("appYN") == 'Y'){
						
						var soldout = $(this).attr("data-soldout");
						
						if(soldout == "N"){
							var gnm = $(this).attr("data-gnm");
							ga('send', 'event', 'mf_event', vEvent_title ,'상품'+gnm);
							var moveUrl = $(this).attr("data-id");
							
							firstBuyCheck(moveUrl)
							return false;
						}
						
					}else{
						onoff('app_only');
						return false;
					}
				});
				
			}
		});
	}
	function firstBuyCheck(moveUrl){
		
		if(!islogin()){
			if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
				location.href = "/mobilefirst/login/login.jsp";
			}else if(navigator.userAgent.indexOf("Android") > -1){
				location.href = "/mobilefirst/login/login.jsp?backUrl=/mobilefirst/evt/firstbuy100_event.jsp?freetoken=event&chk_id="+vChkId;
			}
			return false;
		}
		
		$.ajax({
			type: "POST",
			url: "/mobilefirst/evt/ajax/ajax_firstbuychk.jsp",
			async: false,
			data: { chkid: vChkId, procCode: 3 },
			dataType:"JSON",
			success: function(json){
				
				var result = json.result;
				
				if ( result== -77 ) {
					alert("이미 첫구매 혜택을 받았습니다.");
				}else if (result==-22) {//이전 첫구매 신청자
					//alert("아쉽지만\n첫구매 대상자가 아닙니다. (" + result + ")");
					alert("아쉽지만\n첫구매 대상자가 아닙니다. ");
				
				}else if (result==1) {//100원딜 신청자
					alert("이미 신청하셨습니다.");
					
				} else if(result==-5){
						//var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
						//if(r){
							alert("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동합니다");
							location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
						//}
				} else if(result==6) {
					//if(navigator.userAgent.indexOf("Android") > -1){
					alert("페이백은 구매일로부터 최대 30일 소요됩니다.\n구매하시겠습니까?");
					//}
					//window.open(moveUrl);
					location.href=moveUrl+"&outlink";
					return false;
						
				} else if(result==-1 || result>5) {
					//alert("아쉽네요^^;\n첫구매 대상자가 아닙니다. (" + result + ")" );
					alert("아쉽네요^^;\n첫구매 대상자가 아닙니다. " );
				} else if(result==-2) {
					//var isFriend = confirm("초대코드가 있습니다.\n초대 첫구매 혜택 신청해주세요.");
					alert("초대코드가 있습니다.\n초대 첫구매 혜택 신청해주세요.");
					//if(isFriend){
					goFriendPurchase();
					//}
				}  else if(result==3) {
					alert("구매해주셔서 감사합니다.\n아쉽게도 첫구매액이 "+chkPrice+"원 미만이면 혜택을 받을 수 없습니다.");
				} else if(result==4 || result == 5) {
					//welcomeGa("myInvitedetail");
					//onoff('myInvitedetail');
					//if(navigator.userAgent.indexOf("Android") > -1){
					alert("페이백은 구매일로부터 최대 30일 소요됩니다.\n구매하시겠습니까?");	
					//}
					//window.open(moveUrl);
					location.href=moveUrl+"&outlink";
					return false;
					
				} else if(result==-99) {
					
					//var r = confirm("휴대폰번호 본인인증 후\n 참여할 수 있습니다.");
					//if(r){
						alert("휴대폰번호 본인인증 후\n 참여할 수 있습니다.");
						var pd = "<%=pd%>";
						
						if(getCookie("appYN") == "Y"){
							window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&app=Y&freetoken=login_title&pd="+pd);
						}else{
							window.open("https://m.enuri.com/mobilefirst/member/myAuth.jsp?userid=<%=cUserId%>&freetoken=login_title");	
						}
						
					//}
					return false;
		            
				} else if(result==-98) {
					alert("이미 첫구매 혜택을 받았습니다.");
				} else {
					//alert("아쉽네요^^;\n첫구매 대상자가 아닙니다.(" + result + ")" ); //0
					alert("아쉽네요^^;\n첫구매 대상자가 아닙니다." ); //0
				}
				
			}
		});
		
	}
	
	function getPowerReward(){
		
		if(!islogin()){
			$(".txt_date").text("로그인 후 확인하세요!");  
			return; 
		}
		
		$.ajax({
			type: "POST",
			url: "/mobilefirst/evt/ajax/ajax_power_reward.jsp",
			async: false,
			dataType:"JSON",
			success: function(json){
					
					for( i=0 ; i < json.cnt ; i++){
						$("#powerList > li").eq(i).addClass("on"); 	
					}
					
					if(getCookie("appYN") == 'Y'){
						
						//첫구매 신청내역 없음
						if ( json.isApply == -2 || json.isApply == -3 || json.isApply == -1  ) {
							
							$(".txt_date").text("아쉽게도 대상자가 아닙니다.");
						} else if ( json.isApply == 1  ) {
							if( typeof json.power_date != 'undefined' || typeof json.power_date != 'undefined' ){
								
								var yy = json.power_date.substring(0,4);
								var mm = json.power_date.substring(4,6);
								var dd = json.power_date.substring(6,8);
								
								$(".txt_date").text(mm+"월 "+dd+"일 까지");	
								
							}else{
								$(".txt_date").text("첫 구매 후 확인하세요!");	
							}
							
						} else if( typeof json.power_date != 'undefined' || typeof json.power_date != 'undefined') {
							var yy = json.power_date.substring(0,4);
							var mm = json.power_date.substring(4,6);
							var dd = json.power_date.substring(6,8);
							
							$(".txt_date").text(mm+"월 "+dd+"일 까지");	
						}
						
					}else{
						$(".txt_date").text("APP에서 확인하세요!");					
					}
					
			}
		});
	}
	
	function goFriendPurchase(){		location.href="/mobilefirst/evt/new_friend_20179.jsp?freetoken=eventclone&tab=3";	}

	$(".btn_more_evt").click(function(){
		var url = (getCookie("appYN") != "Y" ? "/mobilefirst/index.jsp#evt" : "/mobilefirst/renew/plan.jsp?freetoken=main_tab|event")
		window.open(url);
	});
	
}());
</script>